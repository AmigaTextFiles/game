/* amiga_game.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/amiga_game.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* GameAdd(struct List *List,int Index,const char *FileName):
	 *
	 *	Add another game file to the list.
	 */

VOID
GameAdd(struct List *List,int Index,const char *FileName)
{
	struct Node	*Node,
			*Next;
	Bool		 GotIt = FALSE;
	char		*Title = Titles[Index];

		/* In order to sort the list properly,
		 * invert the index counter.
		 */

	Index = NUM_GAMES - Index;

		/* Is this game already in the list? */

	Node = List -> lh_Head;

	while(Next = Node -> ln_Succ)
	{
		if(Node -> ln_Pri == Index)
		{
			GotIt = TRUE;

			break;
		}
		else
			Node = Next;
	}

		/* Is it? */

	if(!GotIt)
	{
		struct GameNode	*Node;
		int		 TitleLen;

			/* Determine length of game title. */

		TitleLen = strlen(Title) + 1;

			/* Allocate space for node, title and
			 * corresponding file name.
			 */

		if(Node = (struct GameNode *)AllocVec(sizeof(struct GameNode) + TitleLen + strlen(FileName) + 1,MEMF_ANY | MEMF_CLEAR))
		{
				/* Set up the node contents. */

			Node -> gn_Node . ln_Name	= (char *)(Node + 1);
			Node -> gn_Node . ln_Pri	= Index;
			Node -> gn_FileName		= Node -> gn_Node . ln_Name + TitleLen;

				/* Fill in the game title and the
				 * corresponding file name.
				 */

			strcpy(Node -> gn_Node . ln_Name,	Title);
			strcpy(Node -> gn_FileName,		FileName);

				/* Add the node to the list. */

			Enqueue(List,(struct Node *)Node);
		}
	}
}

	/* GameMatch(const char *Name,const char *Pattern):
	 *
	 *	Test if a name matches a wildcard pattern.
	 */

Bool
GameMatch(const char *Name,const char *Pattern)
{
	char MatchBuffer[MAX_FILENAME_LENGTH];

		/* Tokenize the pattern. */

	if(ParsePatternNoCase((STRPTR)Pattern,MatchBuffer,MAX_FILENAME_LENGTH) != -1)
	{
			/* Make the match. */

		if(MatchPatternNoCase(MatchBuffer,(STRPTR)Name))
			return(TRUE);
	}

	return(FALSE);
}

	/* GameMultiScan(struct List *GameList,const char *Pattern):
	 *
	 *	Scan multi-volumne assignment for game files.
	 */

VOID
GameMultiScan(struct List *GameList,const char *Pattern)
{
	struct DevProc		*DevProc	= NULL;
	struct MsgPort		*FileSysTask	= GetFileSysTask();
	struct FileInfoBlock	*FileInfo;
	header_t		 GameHeader;

		/* Allocate the fileinfo data. */

	if(FileInfo = (struct FileInfoBlock *)AllocDosObjectTags(DOS_FIB,TAG_DONE))
	{
			/* Loop until all assignments are
			 * processed.
			 */

		do
		{
				/* Get the default filesystem task
				 * in case we stumble upon NULL
				 * directory locks.
				 */

			if(DevProc = GetDeviceProc("Infocom:",DevProc))
			{
					/* Set the default filesystem task. */

				SetFileSysTask(DevProc -> dvp_Port);

					/* Check the object type. */

				if(Examine(DevProc -> dvp_Lock,FileInfo))
				{
						/* Is it really a directory? */

					if(FileInfo -> fib_DirEntryType > 0)
					{
							/* Scan the directory... */

						while(ExNext(DevProc -> dvp_Lock,FileInfo))
						{
								/* Did we find a file? */

							if(FileInfo -> fib_DirEntryType < 0)
							{
									/* Does the name match the template? */

								if(GameMatch(FileInfo -> fib_FileName,Pattern))
								{
										/* Build full path name. */

									strcpy(TempBuffer,"Infocom:");

									if(AddPart(TempBuffer,FileInfo -> fib_FileName,MAX_FILENAME_LENGTH))
									{
										FILE *GameFile;

											/* Try to open the file for reading. */

										if(GameFile = fopen(TempBuffer,"rb"))
										{
												/* Read the game file header. */

											if(fread(&GameHeader,sizeof(header_t),1,GameFile) == 1)
											{
													/* Is it a type 3 game? */

												if(GameHeader . z_version == 3)
												{
													int	Serial = 0,
														i;

														/* Calculate the serial number. */

													for(i = 0 ; i < 6 ; i++)
													{
														Serial *= 10;
														Serial += GameHeader . serial_no[i] - '0';
													}

														/* Try to find a corresponding
														 * game in the list.
														 */

													for(i = 0 ; SerialNumbers[i][SERIAL_INDEX] != -1 ; i++)
													{
															/* Do the serial numbers match? */

														if(Serial == SerialNumbers[i][SERIAL_NUMBER] && GameHeader . release == SerialNumbers[i][SERIAL_RELEASE])
														{
																/* Add the game file to the list. */

															GameAdd(GameList,SerialNumbers[i][SERIAL_INDEX],TempBuffer);

															break;
														}
													}
												}
											}

												/* Close the game file. */

											fclose(GameFile);
										}
									}
								}
							}
						}
					}
				}
			}
			else
				break;
		}
		while(DevProc && (DevProc -> dvp_Flags & DVPF_ASSIGN));

			/* Free the fileinfo data. */

		FreeDosObject(DOS_FIB,FileInfo);
	}

		/* Reset the default filesystem task. */

	SetFileSysTask(FileSysTask);

		/* Free device process data. */

	if(DevProc)
		FreeDeviceProc(DevProc);
}

	/* GameGetNodeName(struct List *List,int Offset):
	 *
	 *	Scan the list, returning the nth node.
	 */

char *
GameGetNodeName(struct List *List,const int Offset)
{
	struct GameNode	*Node = (struct GameNode *)List -> lh_Head;
	int		 i;

	for(i = 0 ; Node -> gn_Node . ln_Succ && i < Offset ; i++)
		Node = (struct GameNode *)Node -> gn_Node . ln_Succ;

	return(Node -> gn_FileName);
}

	/* GameFreeList(struct List *List):
	 *
	 *	Free the contents of the list,
	 *	including the list itself.
	 */

VOID
GameFreeList(struct List *List)
{
	struct Node	*Node,
			*Next;

	Node = List -> lh_Head;

	while(Next = Node -> ln_Succ)
	{
		FreeVec(Node);

		Node = Next;
	}

	FreeVec(List);
}

	/* GameIsAssign(const STRPTR Name):
	 *
	 *	Check to see if a device name passed in
	 *	actually refers to an assignment.
	 */

Bool
GameIsAssign(const STRPTR Name)
{
	WORD NameLen	= strlen(Name) - 1;
	Bool Result	= FALSE;

		/* Does it end with a colon? */

	if(Name[NameLen] == ':')
	{
		struct DosList *DosList;

			/* Lock the list of assignments for reading. */

		if(DosList = AttemptLockDosList(LDF_ASSIGNS | LDF_READ))
		{
			STRPTR AssignName;

				/* Scan the list... */

			while(DosList = NextDosEntry(DosList,LDF_ASSIGNS))
			{
					/* Convert the name from icky
					 * BCPL to `C' style string.
					 */

				AssignName = (STRPTR)BADDR(DosList -> dol_Name);

					/* Does the name length match? */

				if(AssignName[0] == NameLen)
				{
						/* Does the name itself match? */

					if(!Strnicmp(&AssignName[1],Name,NameLen))
					{
						Result = TRUE;

						break;
					}
				}
			}

				/* Unlock the list of assignments. */

			UnLockDosList(LDF_ASSIGNS | LDF_READ);
		}
	}

		/* Return the result. */

	return(Result);
}

	/* GameBuildList(const char *Pattern):
	 *
	 *	Build a list of infocom games whose names
	 *	match a certain pattern.
	 */

struct List *
GameBuildList(const char *Pattern)
{
	APTR		 OldPtr = ThisProcess -> pr_WindowPtr;
	struct List	*GameList = NULL;
	BPTR		 NewDir;

		/* No DOS requesters, please! */

	ThisProcess -> pr_WindowPtr = (APTR)-1;

		/* Is the assignment present? */

	if(NewDir = Lock("Infocom:",ACCESS_READ))
	{
			/* Allocate space for the new list. */

		if(GameList = (struct List *)AllocVec(sizeof(struct List),MEMF_ANY))
		{
				/* Initialize the list. */

			NewList(GameList);

				/* Will we have to deal with
				 * an assignment or a volume?
				 */

			if(GameIsAssign("Infocom:"))
				GameMultiScan(GameList,Pattern);
			else
			{
				struct FileInfoBlock	*FileInfo;
				header_t		 GameHeader;

					/* Allocate space for two fileinfo blocks. */

				if(FileInfo = (struct FileInfoBlock *)AllocDosObjectTags(DOS_FIB,TAG_DONE))
				{
						/* Take a look at the assignment. */

					if(Examine(NewDir,FileInfo))
					{
							/* Does it really refer to a directory? */

						if(FileInfo -> fib_DirEntryType > 0)
						{
								/* Examine the whole directory. */

							while(ExNext(NewDir,FileInfo))
							{
									/* Is it a file? */

								if(FileInfo -> fib_DirEntryType < 0)
								{
									if(GameMatch(FileInfo -> fib_FileName,Pattern))
									{
											/* Build a path to the story file,
											 * if present.
											 */

										strcpy(TempBuffer,"Infocom:");

										if(AddPart(TempBuffer,FileInfo -> fib_FileName,MAX_FILENAME_LENGTH))
										{
											FILE *GameFile;

												/* Try to open the file for reading. */

											if(GameFile = fopen(TempBuffer,"rb"))
											{
													/* Read the game file header. */

												if(fread(&GameHeader,sizeof(header_t),1,GameFile) == 1)
												{
														/* Is it a type 3 game? */

													if(GameHeader . z_version == 3)
													{
														int	Serial = 0,
															i;

															/* Calculate the serial number. */

														for(i = 0 ; i < 6 ; i++)
														{
															Serial *= 10;
															Serial += GameHeader . serial_no[i] - '0';
														}

															/* Try to find a corresponding
															 * game in the list.
															 */

														for(i = 0 ; SerialNumbers[i][SERIAL_INDEX] != -1 ; i++)
														{
																/* Do the serial numbers match? */

															if(Serial == SerialNumbers[i][SERIAL_NUMBER] && GameHeader . release == SerialNumbers[i][SERIAL_RELEASE])
															{
																	/* Add the game file to the list. */

																GameAdd(GameList,SerialNumbers[i][SERIAL_INDEX],TempBuffer);

																break;
															}
														}
													}
												}

													/* Close the game file. */

												fclose(GameFile);
											}
										}
									}
								}
							}
						}
					}

						/* Free the fileinfo data. */

					FreeDosObject(DOS_FIB,FileInfo);
				}
			}

				/* Does the list contain any entries? */

			if(!GameList -> lh_Head -> ln_Succ)
			{
				FreeVec(GameList);

				GameList = NULL;
			}
		}

			/* Release the lock on the directory. */

		UnLock(NewDir);
	}

		/* Enable DOS requesters again. */

	ThisProcess -> pr_WindowPtr = OldPtr;

		/* Return the game file list. */

	return(GameList);
}

	/* GameGetStoryName():
	 *
	 *	Ask the user for a story game file name.
	 */

char *
GameGetStoryName(const char *Pattern,const struct Window *Window)
{
	struct FileRequester	*StoryRequest;
	char			*Result = NULL;

		/* Get the current directory name. */

	if(!GetCurrentDirName(TempBuffer,MAX_FILENAME_LENGTH))
		TempBuffer[0] = 0;

		/* Allocate the file requester. */

	if(StoryRequest = AllocAslRequestTags(ASL_FileRequest,
		ASL_Hail,				"Select a story file",
		ASL_OKText,				"Select",
		ASL_File,				"Story.Data",
		ASL_Dir,				TempBuffer,
		ASL_Pattern,				Pattern,
		ASL_FuncFlags,				FILF_PATGAD,
		Window ? ASL_Window : TAG_IGNORE,	Window,
	TAG_DONE))
	{
			/* Loop until a result is found. */

		while(!Result)
		{
				/* Ask the user for a file name. */

			if(AslRequestTags(StoryRequest,TAG_DONE))
			{
					/* Did we get a file name? */

				if(StoryRequest -> rf_File[0])
				{
						/* Copy the directory name. */

					strcpy(TempBuffer,StoryRequest -> rf_Dir);

						/* Build the full path name. */

					if(AddPart(TempBuffer,StoryRequest -> rf_File,MAX_FILENAME_LENGTH))
					{
							/* Is it a valid story game file? */

						if(ConCheckStory(TempBuffer))
							Result = TempBuffer;
						else
							ConShowRequest(Window,"File \"%s\" is not a valid story game file.","Continue",StoryRequest -> rf_File);
					}
					else
						ConShowRequest(Window,"Error building path name!","Continue");
				}
				else
					break;
			}
			else
				break;
		}

		FreeAslRequest(StoryRequest);
	}

	return(Result);
}

	/* GameCentreWindow():
	 *
	 *	Adjust coordinates of a window to be opened,
	 *	so that it will come up right under the mouse
	 *	pointer.
	 */

VOID
GameCentreWindow(const struct Screen *Screen,const WORD WindowWidth,const WORD WindowHeight,WORD *LeftEdge,WORD *TopEdge)
{
	*LeftEdge	= Screen -> MouseX - WindowWidth / 2;
	*TopEdge	= Screen -> MouseY - WindowHeight / 2;

	while((*LeftEdge) + WindowWidth > Screen -> Width)
		(*LeftEdge)--;

	while((*LeftEdge) < 0)
		(*LeftEdge)++;

	while((*TopEdge) + WindowHeight > Screen -> Height)
		(*TopEdge)--;

	while((*TopEdge) < 0)
		(*TopEdge)++;
}

	/* GameCreateGadgets():
	 *
	 *	Create list view and button for the
	 *	game list selection window.
	 */

struct Gadget *
GameCreateGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,const APTR VisualInfo,const struct List *Labels,const struct Screen *Screen,WORD *WindowWidth,WORD *WindowHeight)
{
	STATIC STRPTR GadgetLabels[] =
	{
		"Choose a story",
		"Select a story file...",
		"Cancel"
	};

	struct Gadget		*Gadget;
	struct NewGadget	 NewGadget;
	UWORD			 Counter,
				 Lines = 0;
	struct Node		*Node,
				*Next;
	UWORD			 MaxWidth,
				 ListWidth	= 0,
				 ButtonWidth	= 0,
				 Width;
	int			 i;

		/* Determine the longest label string. */

	Node = Labels -> lh_Head;

	while(Next = Node -> ln_Succ)
	{
		Lines++;

		if((Width = TextLength((struct RastPort *)&Screen -> RastPort,Node -> ln_Name,strlen(Node -> ln_Name))) > ListWidth)
			ListWidth = Width;

		Node = Next;
	}

		/* Is the button label text longer than
		 * all the list labels?
		 */

	if((Width = TextLength((struct RastPort *)&Screen -> RastPort,GadgetLabels[GAMEGAD_LIST],strlen(GadgetLabels[GAMEGAD_LIST]))) > ListWidth)
		ListWidth = Width;

		/* Determine the longest button label. */

	for(i = GAMEGAD_SELECT ; i <= GAMEGAD_CANCEL ; i++)
	{
		if((Width = TextLength((struct RastPort *)&Screen -> RastPort,GadgetLabels[i],strlen(GadgetLabels[i]))) > ButtonWidth)
			ButtonWidth = Width;
	}

		/* Adjust the values. */

	ListWidth	= (4 + ListWidth + 4) + 16 + 8;
	ButtonWidth	= 4 + ButtonWidth + 4;

		/* Are the two buttons wider than the list? */

	if(2 * ButtonWidth + INTERWIDTH > ListWidth)
		MaxWidth = 2 * ButtonWidth + INTERWIDTH;
	else
	{
		MaxWidth	= ListWidth;
		ButtonWidth	= (ListWidth - INTERWIDTH) / 2;
	}

		/* Loop until the list fits on the screen. */

	FOREVER
	{
			/* Zero the template. */

		memset(&NewGadget,0,sizeof(struct NewGadget));

			/* Clear the gadget counter. */

		Counter = 0;

			/* Create gadget list context. */

		if(Gadget = CreateContext(GadgetList))
		{
				/* Set up for gadget creation. */

			NewGadget . ng_GadgetText	= GadgetLabels[Counter];
			NewGadget . ng_GadgetID		= Counter;
			NewGadget . ng_TextAttr		= Screen -> Font;
			NewGadget . ng_VisualInfo	= VisualInfo;
			NewGadget . ng_GadgetID		= Counter;
			NewGadget . ng_Flags		= PLACETEXT_ABOVE;
			NewGadget . ng_LeftEdge		= Screen -> WBorLeft + INTERWIDTH;
			NewGadget . ng_TopEdge		= Screen -> WBorTop + Screen -> Font -> ta_YSize + 1 + INTERHEIGHT + Screen -> Font -> ta_YSize + INTERHEIGHT;
			NewGadget . ng_Width		= MaxWidth;
			NewGadget . ng_Height		= 4 + Lines * Screen -> Font -> ta_YSize + 4;

				/* Create the list view. */

			GadgetArray[Counter++] = Gadget = CreateGadget(LISTVIEW_KIND,Gadget,&NewGadget,
				GTLV_Labels,Labels,
			TAG_DONE);

			NewGadget . ng_GadgetText	= GadgetLabels[Counter];
			NewGadget . ng_GadgetID		= Counter;
			NewGadget . ng_Flags		= NULL;
			NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;
			NewGadget . ng_Width		= ButtonWidth;
			NewGadget . ng_Height		= 2 + Screen -> Font -> ta_YSize + 2;

				/* Create the left button. */

			GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,TAG_DONE);

			NewGadget . ng_GadgetText	= GadgetLabels[Counter];
			NewGadget . ng_GadgetID		= Counter;
			NewGadget . ng_Flags		= NULL;
			NewGadget . ng_LeftEdge		= NewGadget . ng_LeftEdge + NewGadget . ng_Width + INTERWIDTH;

				/* Create the right button. */

			GadgetArray[Counter] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,TAG_DONE);

				/* Adjust window dimensions. */

			*WindowWidth	= Screen -> WBorLeft + INTERWIDTH + MaxWidth + INTERWIDTH + Screen -> WBorRight;
			*WindowHeight	= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT + Screen -> WBorBottom;

				/* Is the window larger than the screen? */

			if(*WindowHeight > Screen -> Height)
			{
					/* Free gadget list. */

				FreeGadgets(*GadgetList);

				*GadgetList = NULL;

					/* If possible, reduce the list
					 * by another line. If this turns
					 * out to be too much, just fail.
					 */

				if(Lines > 2)
					Lines--;
				else
					return(NULL);
			}
			else
				return(Gadget);
		}
	}
}

	/* GameSelect(char *Name):
	 *
	 *	Select a game file either by list or by file requester.
	 */

Bool
GameSelect(char *Name)
{
	struct Window	*Window;
	struct List	*GameList;
	WORD		 WindowWidth,
			 WindowHeight;
	struct Gadget	*GadgetList,
			*GadgetArray[GAMEGAD_CANCEL + 1];
	Bool		 Result = FALSE;
	struct Screen	*Screen;
	WORD		 Left,
			 Top;
	char		 PatternBuffer[MAX_FILENAME_LENGTH];
	int		 i;

		/* Is more than a single filename extension available? */

	if(StoryExtensions[1])
	{
			/* Start with a standard pattern header. */

		strcpy(PatternBuffer,"#?(");

			/* Add the alternatives. */

		for(i = 0 ; StoryExtensions[i] ; i++)
		{
				/* No extension? Clear the
				 * pattern and exit.
				 */

			if(!StoryExtensions[i][0])
			{
				PatternBuffer[0] = 0;

				break;
			}
			else
			{
				if(i)
					strcat(PatternBuffer,"|");

				strcat(PatternBuffer,StoryExtensions[i]);
			}
		}

			/* Finish the pattern. */

		if(PatternBuffer[0])
			strcat(PatternBuffer,")");
		else
			strcpy(PatternBuffer,"~(#?.info)");
	}
	else
	{
			/* That one's simple: just a standard pattern
			 * plus the extension.
			 */

		strcpy(PatternBuffer,"#?");
		strcat(PatternBuffer,StoryExtensions[0]);
	}

		/* Obtain a lock on the default public screen. */

	if(Screen = LockPubScreen(NULL))
	{
			/* Build a list of game files. */

		if(GameList = GameBuildList(PatternBuffer))
		{
				/* Is there only one entry in the list? */

			if(!GameList -> lh_Head -> ln_Succ -> ln_Succ)
			{
				struct GameNode *Node = (struct GameNode *)GameList -> lh_Head;

				strcpy(Name,Node -> gn_FileName);

				Result = TRUE;
			}
			else
			{
				APTR VisualInfo;

					/* Obtain visual information. */

				if(VisualInfo = GetVisualInfo(Screen,TAG_DONE))
				{
						/* Create gadget list. */

					if(GameCreateGadgets(GadgetArray,&GadgetList,VisualInfo,GameList,Screen,&WindowWidth,&WindowHeight))
					{
							/* Centre the window under the mouse pointer. */

						GameCentreWindow(Screen,WindowWidth,WindowHeight,&Left,&Top);

							/* Open the window. */

						if(Window = OpenWindowTags(NULL,
							WA_Width,	WindowWidth,
							WA_Height,	WindowHeight,
							WA_Left,	Left,
							WA_Top,		Top,
							WA_Title,	"Infocom games",
							WA_RMBTrap,	TRUE,
							WA_DepthGadget,	TRUE,
							WA_CloseGadget,	TRUE,
							WA_DragBar,	TRUE,
							WA_Activate,	TRUE,
							WA_CustomScreen,Screen,
							WA_IDCMP,	IDCMP_CLOSEWINDOW | BUTTONIDCMP | LISTVIEWIDCMP,
						TAG_DONE))
						{
							STATIC struct Requester	 BlockRequest;

							struct IntuiMessage	*Massage;
							ULONG			 Class,
										 Code;
							struct Gadget		*Gadget;
							char			*Buffer;
							Bool			 Terminated = FALSE;

								/* Add and draw the gadget list. */

							AddGList(Window,GadgetList,(UWORD)-1,(UWORD)-1,NULL);
							RefreshGList(GadgetList,Window,NULL,(UWORD)-1);
							GT_RefreshWindow(Window,NULL);

								/* Loop, waiting for input. */

							do
							{
									/* Wait for it... */

								WaitPort(Window -> UserPort);

									/* Process incoming messages. */

								while(Massage = GT_GetIMsg(Window -> UserPort))
								{
										/* Pick up the message data. */

									Class	= Massage -> Class;
									Code	= Massage -> Code;
									Gadget	= (struct Gadget *)Massage -> IAddress;

										/* Reply the message to the sender. */

									GT_ReplyIMsg(Massage);

										/* Process the message class. */

									switch(Class)
									{
											/* Window is to be closed? */

										case IDCMP_CLOSEWINDOW:		Terminated = TRUE;
														break;

											/* A button was pressed or a list
											 * item was selected.
											 */

										case IDCMP_GADGETUP:	switch(Gadget -> GadgetID)
													{
															/* A list entry was selected,
															 * use the corresponding game
															 * file name.
															 */

														case GAMEGAD_LIST:	strcpy(Name,GameGetNodeName(GameList,Code));

																	Result = Terminated = TRUE;

																	break;

															/* Select a game file. */

														case GAMEGAD_SELECT:	memset(&BlockRequest,0,sizeof(struct Requester));

																		/* Block window output. */

																	Request(&BlockRequest,Window);

																		/* Set the wait pointer. */

																	WaitPointer(Window);

																		/* Ask the user for a file name. */

																	if(Buffer = GameGetStoryName(PatternBuffer,Window))
																	{
																		strcpy(Name,Buffer);

																		Result = Terminated = TRUE;
																	}

																		/* Remove the wait pointer. */

																	ClearPointer(Window);

																		/* Remove the blocking requester. */

																	EndRequest(&BlockRequest,Window);

																	break;

															/* Cancel selection. */

														case GAMEGAD_CANCEL:	Terminated = TRUE;

																	break;
													}

													break;
									}
								}
							}
							while(!Terminated);

								/* Close the window. */

							CloseWindow(Window);
						}

							/* Free the gadget data. */

						FreeGadgets(GadgetList);
					}

						/* Relese the visual information data. */

					FreeVisualInfo(VisualInfo);
				}
			}

				/* Free the game file list. */

			GameFreeList(GameList);
		}
		else
		{
			char *Buffer;

				/* Ask the user for a file name. */

			if(Buffer = GameGetStoryName(PatternBuffer,NULL))
			{
				strcpy(Name,Buffer);

				Result = TRUE;
			}
		}

			/* Release the lock on the default
			 * public screen.
			 */

		UnlockPubScreen(NULL,Screen);
	}

		/* Return the result. */

	return(Result);
}
