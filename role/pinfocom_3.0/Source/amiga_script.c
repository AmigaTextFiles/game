/* amiga_script.c
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
 * $Header: RCS/amiga_script.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* ScriptWrite(const char *Buffer,int Width):
	 *
	 *	Write a null-terminated string to the
	 *	transcript file, adding a new-line
	 *	character.
	 */

Bool
ScriptWrite(const char *Buffer,const int Width)
{
		/* Are we still to continue scripting? */

	if(ScriptAborted)
		return(FALSE);
	else
	{
		if(Width)
		{
				/* Flush the current line buffer contents to the transcript
				 * file, close it if the action fails.
				 */

			if(!fwrite(Buffer,Width,1,ScriptFile))
			{
				scr_putmesg("Error writing to transcript file",TRUE);

				ScriptAborted = TRUE;

				return(FALSE);
			}
		}

		if(!fwrite("\n",1,1,ScriptFile))
		{
			scr_putmesg("Error writing to transcript file",TRUE);

			ScriptAborted = TRUE;

			return(FALSE);
		}

		return(TRUE);
	}
}

	/* ScriptCreateGadgets():
	 *
	 *	Create the gadgets for the printer control panel.
	 */

struct Gadget *
ScriptCreateGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,const APTR VisualInfo,UWORD *Width,UWORD *Height,const struct Screen *Screen)
{
		/* The gadget title labels. */

	STATIC STRPTR GadgetLabels[] =
	{
		"Transcript output file or device",
		"Transcript page width",
		"Okay",
		"Cancel",
		"Select a file..."
	};

		/* A bunch of local variables. */

	struct Gadget		*Gadget;
	struct NewGadget	 NewGadget;
	WORD			 Counter = 0;

		/* Zero the template. */

	memset(&NewGadget,0,sizeof(struct NewGadget));

		/* Create the root info. */

	if(Gadget = CreateContext(GadgetList))
	{
		WORD	ButtonWidth,
			StringWidth,
			MaxWidth,
			Temp,
			i;

			/* Determine the longest string/integer gadget label. */

		MaxWidth = 0;

		for(i = SCRIPTGAD_PRINTER_STRING ; i <= SCRIPTGAD_PRINTER_WIDTH ; i++)
		{
			if((Temp = 2 * INTERWIDTH + TextLength((struct RastPort *)&Screen -> RastPort,GadgetLabels[i],strlen(GadgetLabels[i]))) > MaxWidth)
				MaxWidth = Temp;
		}

			/* Store the longest label width. */

		StringWidth = MaxWidth;

			/* Determine the longest button gadget label. */

		MaxWidth = 0;

		for(i = SCRIPTGAD_PRINTER_ACCEPT ; i <= SCRIPTGAD_PRINTER_SELECT ; i++)
		{
			if((Temp = 2 * INTERWIDTH + TextLength((struct RastPort *)&Screen -> RastPort,GadgetLabels[i],strlen(GadgetLabels[i]))) > MaxWidth)
				MaxWidth = Temp;
		}

			/* Store the longest label width. */

		ButtonWidth = MaxWidth;

			/* Are the three buttons in a row longer
			 * than the string/integer gadget? If so,
			 * adjust the string/integer gadget width.
			 */

		if(3 * ButtonWidth + 2 * INTERWIDTH > StringWidth)
			StringWidth = 3 * ButtonWidth + 2 * INTERWIDTH;

			/* Determine window size. */

		*Width	= Screen -> WBorLeft + INTERWIDTH + StringWidth + INTERWIDTH + Screen -> WBorRight;
		*Height	= Screen -> WBorTop + Screen -> Font -> ta_YSize + 1 + 2 * (2 * INTERHEIGHT + Screen -> Font -> ta_YSize) + 3 * (Screen -> Font -> ta_YSize + 6) + 2 * INTERHEIGHT + Screen -> WBorBottom;

			/* Set up for gadget creation. */

		NewGadget . ng_GadgetText	= GadgetLabels[SCRIPTGAD_PRINTER_STRING];
		NewGadget . ng_TextAttr		= Screen -> Font;
		NewGadget . ng_VisualInfo	= VisualInfo;
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= PLACETEXT_ABOVE;
		NewGadget . ng_LeftEdge		= Screen -> WBorLeft + INTERWIDTH;
		NewGadget . ng_TopEdge		= Screen -> WBorTop + Screen -> Font -> ta_YSize + 1 + 2 * INTERHEIGHT + Screen -> Font -> ta_YSize;
		NewGadget . ng_Width		= StringWidth;
		NewGadget . ng_Height		= Screen -> Font -> ta_YSize + 6;

		GadgetArray[Counter++] = Gadget = CreateGadget(STRING_KIND,Gadget,&NewGadget,
			GTST_MaxChars,255,
		TAG_DONE);

		NewGadget . ng_GadgetText	= GadgetLabels[SCRIPTGAD_PRINTER_WIDTH];
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + 2 * INTERHEIGHT + Screen -> Font -> ta_YSize;

		GadgetArray[Counter++] = Gadget = CreateGadget(INTEGER_KIND,Gadget,&NewGadget,TAG_DONE);

		NewGadget . ng_GadgetText	= GadgetLabels[SCRIPTGAD_PRINTER_ACCEPT];
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= NULL;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;
		NewGadget . ng_Width		= ButtonWidth;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,TAG_DONE);

		NewGadget . ng_GadgetText	= GadgetLabels[SCRIPTGAD_PRINTER_CANCEL];
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_LeftEdge		= (*Width) - (Screen -> WBorLeft + INTERWIDTH + NewGadget . ng_Width);

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,TAG_DONE);

		NewGadget . ng_GadgetText	= GadgetLabels[SCRIPTGAD_PRINTER_SELECT];
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_LeftEdge		= ((*Width) - NewGadget . ng_Width) / 2;

		GadgetArray[Counter] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,TAG_DONE);
	}

	return(Gadget);
}

	/* ScriptGetPrinterName(STRPTR PrinterName,int *PrinterWidth):
	 *
	 *	Open the printer control panel.
	 */

Bool
ScriptGetPrinterName(STRPTR PrinterName,int *PrinterWidth)
{
	STATIC char	 FileName[MAX_FILENAME_LENGTH];

	struct Gadget	*GadgetArray[SCRIPTGAD_PRINTER_SELECT + 1],
			*GadgetList;
	struct Window	*PrinterWindow;
	UWORD		 Width,
			 Height;
	char		*Index;
	Bool		 Result = FALSE;

		/* Get the path part of the file name,
		 * check if ends in a null-character,
		 * if so, it's probably just a device name.
		 */

	if(Index = PathPart(PrinterName))
	{
			/* If it has a file name attached, copy it to the filename buffer. */

		if(*Index)
			strcpy(FileName,PrinterName);
		else
		{
			int	ExtensionLen,
				NameLen,
				i;
			Bool	GotIt = FALSE;

				/* Use the story file name to start. */

			strcpy(FileName,gflags . filenm);

				/* Determine name length. */

			NameLen = strlen(FileName);

				/* Try to find a matching game
				 * file name extension.
				 */

			for(i = 0 ; !GotIt && StoryExtensions[i] ; i++)
			{
					/* Is the game file name long enough
					 * to hold an extension?
					 */

				if((ExtensionLen = strlen(StoryExtensions[i])) > NameLen)
				{
						/* Does the extension match? */

					if(!Stricmp(&FileName[NameLen - ExtensionLen],StoryExtensions[i]))
					{
							/* Add new file name extension. */

						strcpy(&FileName[NameLen - ExtensionLen],SCRIPT_EXT);

							/* We're done now. */

						GotIt = TRUE;
					}
				}
			}

				/* If we didn't succeed in adding
				 * a new file name extension, just
				 * attach the default.
				 */

			if(!GotIt)
			{
					/* Strip any existing extension. */

				for(i = NameLen - 1 ; i >= 0 ; i--)
				{
					if(FileName[i] == '.')
					{
						FileName[i] = 0;

						break;
					}
				}

					/* Attach the default script
					 * file name extension.
					 */

				strcat(FileName,SCRIPT_EXT);
			}
		}
	}

		/* Create the gadgets for the window. */

	if(ScriptCreateGadgets(&GadgetArray[0],&GadgetList,VisualInfo,&Width,&Height,Window -> WScreen))
	{
			/* Open the window. */

		if(PrinterWindow = OpenWindowTags(NULL,
			WA_Top,			Window -> TopEdge + (Window -> Height - Height) / 2,
			WA_Left,		Window -> LeftEdge + (Window -> Width - Width) / 2,
			WA_Title,		"Save transcript file",
			WA_Width,		Width,
			WA_Height,		Height,
			WA_IDCMP,		IDCMP_VANILLAKEY | IDCMP_CLOSEWINDOW | STRINGIDCMP | BUTTONIDCMP,
			WA_Activate,		TRUE,
			WA_CloseGadget,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_CustomScreen,	Window -> WScreen,
		TAG_DONE))
		{
			STATIC struct Requester	 BlockRequester;

			struct IntuiMessage	*Massage;
			ULONG			 Class;
			struct Gadget		*Gadget;

			Bool			 Terminated = FALSE;
			STRPTR			 Buffer;

				/* Add the gadgets and render them. */

			AddGList(PrinterWindow,GadgetList,(UWORD)-1,(UWORD)-1,NULL);
			RefreshGList(GadgetList,PrinterWindow,NULL,(UWORD)-1);
			GT_RefreshWindow(PrinterWindow,NULL);

				/* Set the string gadget (output file name). */

			GT_SetGadgetAttrs(GadgetArray[SCRIPTGAD_PRINTER_STRING],PrinterWindow,NULL,
				GTST_String,	PrinterName,
			TAG_DONE);

				/* Set the integer gadget (output file width). */

			GT_SetGadgetAttrs(GadgetArray[SCRIPTGAD_PRINTER_WIDTH],PrinterWindow,NULL,
				GTIN_Number,	*PrinterWidth,
			TAG_DONE);

				/* Activate the file/device name gadget. */

			ActivateGadget(GadgetArray[SCRIPTGAD_PRINTER_STRING],PrinterWindow,NULL);

				/* A handy shortcut. */

			Buffer = GT_STRING(GadgetArray[SCRIPTGAD_PRINTER_STRING]);

				/* Enter input loop. */

			do
			{
					/* Wait for input. */

				WaitPort(PrinterWindow -> UserPort);

					/* Process all incoming messages. */

				while(Massage = GT_GetIMsg(PrinterWindow -> UserPort))
				{
						/* Remember input class and gadget. */

					Class	= Massage -> Class;
					Gadget	= (struct Gadget *)Massage -> IAddress;

						/* Return the input event message. */

					GT_ReplyIMsg(Massage);

						/* Which kind of message did we receive? */

					switch(Class)
					{
							/* Activate a string gadget? */

						case IDCMP_VANILLAKEY:		ActivateGadget(GadgetArray[SCRIPTGAD_PRINTER_STRING],PrinterWindow,NULL);
										break;

							/* Close the window? */

						case IDCMP_CLOSEWINDOW:		Terminated = TRUE;
										break;

							/* A button has been pressed? */

						case IDCMP_GADGETUP:		switch(Gadget -> GadgetID)
										{
												/* Activate the printer width gadget? */

											case SCRIPTGAD_PRINTER_STRING:ActivateGadget(GadgetArray[SCRIPTGAD_PRINTER_WIDTH],PrinterWindow,NULL);
														break;

												/* Accept current settings. */

											case SCRIPTGAD_PRINTER_ACCEPT:if(Buffer[0])
														{
																/* Copy the new printer output file/device name. */

															strcpy(PrinterName,(char *)Buffer);

																/* Quit the loop the next time. */

															Terminated = Result = TRUE;

																/* Get current printer width, don't make it too small. */

															if((*PrinterWidth = GT_INTEGER(GadgetArray[SCRIPTGAD_PRINTER_WIDTH])) < MIN_PRINTER_COLUMNS)
																*PrinterWidth = MIN_PRINTER_COLUMNS;
														}

														break;

												/* Select a new output file. */

											case SCRIPTGAD_PRINTER_SELECT:

															/* Clear the requester. */

														memset(&BlockRequester,0,sizeof(struct Requester));

															/* Block window input. */

														Request(&BlockRequester,PrinterWindow);

															/* Set the window wait pointer. */

														WaitPointer(PrinterWindow);

														strcpy(TempBuffer,FileName);

															/* Extract the path name. */

														if(Index = PathPart(TempBuffer))
															*Index = 0;

															/* If no path name is given, supply the
															 * current directory.
															 */

														if(!TempBuffer[0])
														{
																/* Try to obtain the current directory name.
																 * If this fails, leave the path name empty.
																 */

															if(!GetCurrentDirName(TempBuffer,MAX_FILENAME_LENGTH))
																TempBuffer[0] = 0;
														}

															/* Request the file name. */

														if(AslRequestTags(GameFileRequest,
															ASL_Window,	PrinterWindow,
															ASL_Dir,	TempBuffer,
															ASL_File,	FilePart(FileName),
															ASL_FuncFlags,	FILF_SAVE,
															ASL_Hail,	"Select transcript file to save",
															ASL_Pattern,	"~(#?.info)",
														TAG_DONE))
														{
																/* Did we get a file name? */

															if(GameFileRequest -> rf_File[0])
															{
																	/* Copy the drawer name. */

																strcpy(TempBuffer,(char *)GameFileRequest -> rf_Dir);

																	/* Add the file name. */

																if(AddPart(TempBuffer,GameFileRequest -> rf_File,MAX_FILENAME_LENGTH))
																{
																		/* Update the file name string. */

																	GT_SetGadgetAttrs(GadgetArray[SCRIPTGAD_PRINTER_STRING],PrinterWindow,NULL,
																		GTST_String,TempBuffer,
																	TAG_DONE);

																		/* Remember the file name. */

																	strcpy(FileName,TempBuffer);
																}
															}
														}

														ClearPointer(PrinterWindow);

														EndRequest(&BlockRequester,PrinterWindow);

														break;

												/* Cancel the requester. */

											case SCRIPTGAD_PRINTER_CANCEL:Terminated = TRUE;
														break;
										}

										break;
					}

					if(Terminated)
						break;
				}
			}
			while(!Terminated);

				/* Close the printer control window. */

			CloseWindow(PrinterWindow);
		}

			/* Free the gadgets. */

		FreeGadgets(GadgetList);
	}

	return(Result);
}

	/* ScriptSplitLine(char *Line,int Len,const Bool ReturnPrompt):
	 *
	 *	Split a hunk of text into neat little pieces.
	 */

char *
ScriptSplitLine(char *Line,int Len,const Bool ReturnPrompt)
{
	int	 Count,
		 Space;

		/* Process & chop the text. */

	do
	{
			/* Does the entire line fit? */

		if(Len <= ScriptWidth)
		{
			if(ReturnPrompt)
				return(Line);
			else
				ScriptWrite(Line,Count = Len);
		}
		else
		{
				/* Reset the counters. */

			Space = Count = 0;

				/* Determine number of
				 * characters to fit and
				 * the last space to use
				 * for text-wrapping.
				 */

			while(Count < Len && Count + 1 < ScriptWidth)
			{
				Count++;

					/* Remember last space. */

				if(Line[Count] == ' ')
					Space = Count;
			}

				/* Return remainder. */

			if(Count == Len)
			{
				if(ReturnPrompt)
					return(Line);
				else
				{
					if(Line[Count - 1] == ' ')
						ScriptWrite(Line,Count - 1);
					else
						ScriptWrite(Line,Count);
				}
			}
			else
			{
					/* Write the line. */

				if(Line[Count - 1] == ' ')
				{
					if(!ScriptWrite(Line,Count - 1))
						break;
				}
				else
				{
					if(!ScriptWrite(Line,Space))
						break;
					else
						Count = Space + 1;
				}
			}

				/* Move up. */

			Line += Count;
		}

			/* Reduce remaining length. */

		Len -= Count;
	}
	while(Len > 0);

		/* Return blank line. */

	return("");
}
