/* amiga.c
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
 * $Header: RCS/amiga.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

/*
 *  Amiga    terminal  interface  created  by  Olaf  `Olsen' Barthel, send
 *  complaints and bug reports to:
 *
 *         Olaf `Olsen' Barthel
 *         Brabeckstrasse 35
 *         D-3000 Hannover 71
 *
 *         Federal Republic of Germany
 *
 *  EMail: olsen@sourcery.mxm.sub.org
 *
 *  This  interface has been designed to work on any Amiga machine running
 *  Kickstart  1.2   or  higher.   Unlike the original Infocom interpreter
 *  interfaces,  it  supports command-line history (20 lines are standard,
 *  the  value  can  be changed at compile-time) and command-line editing.
 *  Editing functions are as follows:
 *
 *  - Backspace
 *
 *    Deletes the character to the left of the cursor.
 *
 *  - Shift + Backspace
 *
 *    Deletes everything from the cursor backward to the start of the line.
 *
 *  - Delete
 *
 *    Deletes the character under the cursor.
 *
 *  - Shift + Delete
 *
 *    Deletes everything from the cursor forward to the end of the line.
 *
 *  - Control + X
 *
 *    Deletes the entire line contents.
 *
 *  - Control + \
 *
 *    Closes the window.
 *
 *  - Control + A
 *
 *    Moves the cursor to the start of the line.
 *
 *  - Control + Z
 *
 *    Moves the cursor to the end of the line.
 *
 *  - Control + W
 *
 *    Deletes the word to the left of the cursor.
 *
 *  - Control + K
 *
 *    Deletes everything from the cursor forward to the end of the line.
 *
 *  - Control + U
 *
 *    Deletes everything from the cursor backward to the start of the line.
 *
 *  - Control + C
 *
 *    Remembers current input line contents.
 *
 *  - Control + Y
 *
 *    Undoes previous editing operation.
 *
 *  - Cursor up
 *
 *    Recalls previous history line.
 *
 *  - Shift + Cursor up
 *
 *    Recalls first history line.
 *
 *  - Cursor down
 *
 *    Moves to next history line.
 *
 *  - Shift + Cursor down
 *
 *    Moves to last history line.
 *
 *  - Cursor right
 *
 *    Moves the cursor to the right.
 *
 *  - Shift + Cursor right
 *
 *    Moves the cursor to the end of the line.
 *
 *  - Cursor left
 *
 *    Moves the cursor to the left.
 *
 *  - Shift + Cursor left
 *
 *    Moves the cursor to the beginning of the line.
 *
 *  - Help
 *
 *    Starts  function key assignment.  Press the function key you wish to
 *    assign  text  to, then enter the text you wish to use.  The vertical
 *    bar (|) and exclamation mark (!) serve  as line terminators and will
 *    produce a carriage-return when the key assigment is recalled.
 *
 *  - F1-F10, Shift + F1-F10
 *
 *    Recalls function key assignment.
 *
 *  - Numeric keypad
 *
 *    Produces movement commands.
 *
 *  As  for  tool  and  project  icons the following tool type entries are
 *  supported.   Note  that due to a bug in icon.library v1.2 and v1.3 the
 *  single line tool types such as "CUSTOMSCREEN" will have to be followed
 *  by a `=' character (e.g.  "CUSTOMSCREEN=").
 *
 *  - FILETYPE
 *
 *    This  is  where  you  or  the  interpreter  places  the  type of the
 *    corresponding   file.    For   saved   game   files   this  will  be
 *    "FILETYPE=BOOKMARK|ITF",  for  story  files "FILETYPE=STORY" and for
 *    transcript files "FILETYPE=TEXT|ASCII".
 *
 *  - CUSTOMSCREEN
 *
 *    Corresponds to the "-C" command-line option, i.e.  the output window
 *    will  be  opened  on  a  custom  screen rather than on the Workbench
 *    screen.   The screen will inherit attributes such as depth, colours,
 *    size   and  display  mode  from  the  Workbench  screen.   The  only
 *    difference  is  the handling of A2024 screen modes, which will cause
 *    the screen to open in hires-interlaced display mode.
 *       If  running  under operating system revisions previous to v2.04 a
 *    monochrome display with the background and text colours set to black
 *    and white will be opened.
 *
 *  - TEXTFONT
 *
 *    Corresponds  to the "-F" option, i.e.  determines the text rendering
 *    font  to  be used.  This will be a disk-resident proportional-spaced
 *    font.  If this option is specified "LISTFONT" and "FONTSIZE" have to
 *    be   included   as   well.    To  use  the  Adobe  Times  font,  use
 *    "TEXTFONT=Times".
 *
 *  - LISTFONT
 *
 *    Corresponds  to the "-L" option, i.e.  determines the list and table
 *    rendering font to be used.  This will be a disk-resident fixed-width
 *    font.  If this option is specified "TEXTFONT" and "FONTSIZE" have to
 *    be   included   as  well.   To  use  the  Adobe  Courier  font,  use
 *    "LISTFONT=Courier".
 *
 *  - FONTSIZE
 *
 *    Corresponds to the "-S" option, i.e.  the point size of the text and
 *    list fonts specified using the "TEXTFONT" and "LISTFONT" tool types.
 *    To use point size 11, use "FONTSIZE=11".
 *
 *  - STORY
 *
 *    This  tool  type  entry  determines  the  story  file  to  be  used.
 *    Typically, it is saved in the project icon of a saved game file.  In
 *    order  to  use  "Work:Infocom/ZorkIII/Story.Data"  as  a story file,
 *    enter the following text:  "STORY=Work:Infocom/ZorkIII/Story.Data".
 *
 *  - ATTRIBUTEASSIGNMENTS
 *
 *    Corresponds to the "-a" command-line option.
 *
 *  - ATTRIBUTETESTS
 *
 *    Corresponds to the "-A" command-line option.
 *
 *  - CONTEXT
 *
 *    Corresponds  to  the  "-c" command-line option.  In order to use two
 *    lines of inter-page context, use "CONTEXT=2".
 *
 *  - ECHO
 *
 *    Corresponds to the "-e" command-line option.
 *
 *  - INDENT
 *
 *    Corresponds  to  the  "-i" command-line option.  In order to use two
 *    characters of line indent, use "INDENT=2".
 *
 *  - MARGIN
 *
 *    Corresponds  to  the  "-m" command-line option.  In order to use two
 *    characters as a line margin, use "MARGIN=2".
 *
 *  - NOPAGER
 *
 *    Corresponds to the "-p" command-line option.
 *
 *  - PROMPT
 *
 *    Corresponds to the "-P" command-line option.
 *
 *  - NOSTATUS
 *
 *    Corresponds to the "-s" command-line option.
 *
 *  - TRANSFERS
 *
 *    Corresponds to the "-t" command-line option.
 *
 *  - TANDY
 *
 *    Corresponds to the "-T" command-line option.
 *
 *  This   interpreter   supports  proportional  fonts:   by  default  the
 *  Workbench  screen  font  will  be  used  for text display (this can be
 *  overridden  using  the  "TEXTFONT",  "LISTFONT"  and  "FONTSIZE"  tool
 *  types).  If the Workbench screen font and the system font do not match
 *  in  height the system font will be used for text display.  This is due
 *  to  the  fact  that  the  interpreter  contains conditional code which
 *  changes  the type of the font during the game if tables or maps are to
 *  be displayed.
 *
 *  If  you  want the interpreter to save icons with saved game files make
 *  sure  that  the icon file "Icon.Data" is present in the directory from
 *  which  the  interpreter was loaded or saved game files will be created
 *  without getting icons attached.
 *     The  interpreter  recognizes  saved  game  files  by their filetype
 *  entries,  i.e.   the  tooltype  "FILETYPE=BOOKMARK" has to be present.
 *  Function  key  assignments,  the name of the story file being used and
 *  game  options  are  saved along with the game file icon.  Function key
 *  assignments  are  restored  automatically  when  a  saved game file is
 *  loaded.   Story  file  name  and  options  are  considered only if the
 *  interpreter is invoked by double-clicking on a project icon.
 *
 *
 *  The  following  list  of  features is valid only for Kickstart 2.04 or
 *  higher.   Users  whose  machines run Kickstart 1.2 or 1.3 will have to
 *  get along with a slightly simplified interface.
 *
 *  - Several  options  and  commands  can be changed via pull-down menus.
 *    Game   files  can  be  restored  by  dropping  their  icons  on  the
 *    interpreter window.
 *
 *  - If  run  from  Workbench  with no story file available the interface
 *    will  check  the  "Infocom:" assignment or volume if present.  If it
 *    cannot  be  found a file requester will allow you to select the game
 *    file to use.  If present the "Infocom:" volume or assignment will be
 *    scanned for valid type 3 Infocom game files.  If more than one valid
 *    game file is found a list will be displayed to choose from.
 *
 *  - The  interface  also  supports  multi-volume assignments, so you can
 *    assign  "Infocom:" to multiple directories the interface is to scan.
 *    One  example  how  to use it would be to copy the "Lost Treasures of
 *    Infocom"  to your hard disk and then use the "Assign Infocom:  <Game
 *    directory> Add" command for each game file directory.
 *
 *
 *  Some things which you might want to know about:
 *
 *  - Clipboard  support  has been implemented in so far as it is possible
 *    to  paste  the  contents of the clipboard, but there is no option to
 *    copy  the screen text to the clipboard.  This may follow in a future
 *    release  version  since  it  requires  a  good  lot  of work.  Paste
 *    operations  are  limited  to  a single line of input, any additional
 *    text  is  discarded.   Line  feeds  are automatically converted into
 *    carriage  returns.   Any  non-printable  characters are filtered out
 *    while reading.
 *
 *  - As of this writing, the interface ignores any page length settings.
 *
 *  - If  a  fixed  text window is displayed (such as by `Seastalker') the
 *    status line will be enabled by default.  If the fixed text window is
 *    disabled  again the interface will pay attention to the user-defined
 *    settings.
 *
 *  - Due   to  the  current  implementation  of  pull-down-menu  support,
 *    drag-selection and multiple-selection are not supported.
 *
 *  Please  refer to the `COPYING' file for distribution conditions and to
 *  the `pinfo.txt' file for a general list of features and command-line
 *  options.
 *
 *
 *  In  order  to  compile  this program an ANSI compliant `C' compiler is
 *  required.   I  recommend  using the GNU `C' compiler which I also used
 *  for development.
 *
 *  May the source be with you,
 *                              -olsen
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* Disable ^C trapping for several Amiga `C' compilers. */

#ifdef LATTICE
ULONG CXBRK(VOID) { return(0); }
#endif	/* LATTICE */

#ifdef AZTEC_C
long Chk_Abort(VOID) { return(0); }
#endif	/* AZTEC_C */

/*
 * Global Variables
 */

/*
 * Variable:    scr_usage
 *
 * Description:
 *      This variable should contain a usage string for any extra
 *      command-line options available through this terminal
 *      interface.
 */

const char *scr_usage       = "[-C] [-L list font name] [-F text font name] [-S font point size]";

/*
 * Variable:    scr_long_usage
 *
 * Description:
 *      This variable should contain a more verbose usage string
 *      detailing the command-line options available through this
 *      terminal interface, one option per line.
 */

const char *scr_long_usage  = "\t-C\topen custom screen\n\t-L name\tset name of list font\n\t-F name\tset name of text font\n\t-S #\tset font point size\n";

/*
 * Variable:    scr_opt_list
 *
 * Description:
 *      This variable should contain a getopt(3)-style option list for
 *      any command-line options available through this terminal
 *      interface.
 */

const char *scr_opt_list    = "CL:F:S:";

/*
 * Function:    scr_cmdarg()
 *
 * Arguments:
 *      argc        number of original arguments
 *      argvp       pointer to array of strings containing args
 *
 * Returns:
 *      Number of new arguments.
 *
 * Description:
 *      This function is called before any command line parsing is
 *      done.  Any terminal interface-specific arguments should be
 *      pulled out of the argv list and any extra arguments obtained
 *      from resource files or wherever should be added.  Note that
 *      (*argvp)[0] must be the command name and (*argvp)[argc] must
 *      be a null pointer.
 *
 * Notes:
 */

int
scr_cmdarg(int argc, char ***argvp)
{
		/* Obtain current process pointer. */

	ThisProcess = (struct Process *)FindTask(NULL);

		/* Are we running as a child of Workbench? */

	if(!argc)
	{
		STATIC char	*DummyInput[19];

		char		 ProjectName[MAX_FILENAME_LENGTH],
				 StoryName[MAX_FILENAME_LENGTH];
		int		 Count = 0;

			/* Clear the names. */

		ProjectName[0] = StoryName[0] = 0;

			/* Obtain Workbench startup message. */

		WBenchMsg = (struct WBStartup *)*argvp;

			/* Install new input data. */

		*argvp = (char **)DummyInput;

			/* Fill in the program name. */

		DummyInput[Count++] = WBenchMsg -> sm_ArgList[0] . wa_Name;

			/* Open system libraries, we will
			 * need the icon.library routines.
			 */

		if(ConOpenLibs())
		{
				/* Did we succeed in opening icon.library? */

			if(IconBase)
			{
				LONG i;

					/* Run down the list of arguments... */

				for(i = 0 ; Count < 16 && i < WBenchMsg -> sm_NumArgs ; i++)
				{
						/* A correct project icon always has a
						 * directory lock associated, let's check it.
						 */

					if(WBenchMsg -> sm_ArgList[i] . wa_Lock && WBenchMsg -> sm_ArgList[i] . wa_Name)
					{
						struct DiskObject *Icon;

							/* Skip to the icon location. */

						CurrentDir(WBenchMsg -> sm_ArgList[i] . wa_Lock);

							/* Try to read the project icon. */

						if(Icon = GetDiskObject(WBenchMsg -> sm_ArgList[i] . wa_Name))
						{
								/* Is it a project icon or even the
								 * program icon itself?
								 */

							if(Icon -> do_Type == WBPROJECT || (!i && Icon -> do_Type == WBTOOL))
							{
								STRPTR Type;

									/* Find the file type if any. */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FILETYPE"))
								{
										/* Is it a bookmark file? */

									if(MatchToolValue(Type,"BOOKMARK") && MatchToolValue(Type,"ITF"))
										strcpy(ProjectName,WBenchMsg -> sm_ArgList[i] . wa_Name);

										/* Is it a story file? */

									if(MatchToolValue(Type,"STORY"))
										strcpy(StoryName,WBenchMsg -> sm_ArgList[i] . wa_Name);
								}

									/* Are we to use a special text rendering font? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"TEXTFONT"))
									strcpy(TextFontName,Type);

									/* Are we to use a special list text rendering font? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"LISTFONT"))
									strcpy(ListFontName,Type);

									/* Which font size are we to use? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FONTSIZE"))
									FontSize = atoi(Type);

									/* Are we to use a special story file? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"STORY"))
									strcpy(StoryName,Type);

									/* Are we to open a custom screen? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"CUSTOMSCREEN"))
									UseCustomScreen = TRUE;

									/* Are we to print object attribute assignments while playing? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"ATTRIBUTEASSIGNMENTS"))
									DummyInput[Count++] = "-a";

									/* Are we to print object attribute tests while playing? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"ATTRIBUTETESTS"))
									DummyInput[Count++] = "-A";

									/* Are we to set the page context? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"CONTEXT"))
								{
									DummyInput[Count++] = "-c";

									if(DummyInput[Count] = (STRPTR)malloc(strlen(Type) + 1))
										strcpy(DummyInput[Count++],Type);
									else
										Count--;
								}

									/* Are we to set the line indent? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"INDENT"))
								{
									DummyInput[Count++] = "-i";

									if(DummyInput[Count] = (STRPTR)malloc(strlen(Type) + 1))
										strcpy(DummyInput[Count++],Type);
									else
										Count--;
								}

									/* Are we to set the line margin? */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"MARGIN"))
								{
									DummyInput[Count++] = "-m";

									if(DummyInput[Count] = (STRPTR)malloc(strlen(Type) + 1))
										strcpy(DummyInput[Count++],Type);
									else
										Count--;
								}

									/* Are we to echo line input? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"ECHO"))
									DummyInput[Count++] = "-e";

									/* Are we to disable text paging? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"NOPAGER"))
									DummyInput[Count++] = "-p";

									/* Are we to display the alternate prompt, if any? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"PROMPT"))
									DummyInput[Count++] = "-P";

									/* Are we to disable the status line? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"NOSTATUS"))
									DummyInput[Count++] = "-s";

									/* Are we to display object transfers? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"TRANSFERS"))
									DummyInput[Count++] = "-t";

									/* Are we to enable the Tandy mode? */

								if(FindToolType((STRPTR *)Icon -> do_ToolTypes,"TANDY"))
									DummyInput[Count++] = "-T";
							}

								/* Free the icon data. */

							FreeDiskObject(Icon);
						}
					}
				}
			}
		}

			/* Did we get a project file name? */

		if(ProjectName[0])
		{
				/* Supply restore command. */

			DummyInput[Count++] = "-r";

				/* Add the name of the file to
				 * be restored.
				 */

			if(DummyInput[Count] = (STRPTR)malloc(strlen(ProjectName) + 1))
				strcpy(DummyInput[Count++],ProjectName);
			else
				Count--;
		}

			/* Have another try opening the system libraries. */

		if(ConOpenLibs())
		{
				/* No custom story file support. */

			if(NewOS)
			{
				char *Buffer;

					/* Did we get a story file name? */

				if(StoryName[0])
				{
						/* Is it a valid story file? */

					if(!ConCheckStory(StoryName))
					{
							/* Can we locate any story file? */

						if(Buffer = ConLocateStory("",StoryName))
							strcpy(StoryName,Buffer);
						else
						{
								/* Prompt the user to select a new one. */

							if(!GameSelect(StoryName))
								StoryName[0] = 0;
						}
					}
				}
				else
				{
						/* Can we locate any story file? */

					if(Buffer = ConLocateStory("",""))
						strcpy(StoryName,Buffer);
					else
					{
							/* Obviously not, so prompt
							 * the user to select a new one.
							 */

						if(!GameSelect(StoryName))
							StoryName[0] = 0;
					}
				}
			}
		}

			/* Did we get a story file name? */

		if(StoryName[0])
		{
				/* Add the name of the story
				 * file to be used.
				 */

			if(DummyInput[Count] = (STRPTR)malloc(strlen(StoryName) + 1))
				strcpy(DummyInput[Count++],StoryName);
		}

			/* Return new number of arguments. */

		return(Count);
	}
	else
		return(argc);
}

/*
 * Function:    scr_getopt()
 *
 * Arguments:
 *      c           option found
 *      arg         option argument (if requested)
 *
 * Description:
 *      This function is called whenever a command-line option
 *      specified in scr_opt_list (above) is found on the command
 *      line.
 */

void
scr_getopt(int c,const char *arg)
{
		/* Are we to open a custom screen? */

	if(c == 'C')
		UseCustomScreen = TRUE;

		/* Are we to use a special list font? */

	if(c == 'L')
		strcpy(ListFontName,arg);

		/* Are we to use a special text font? */

	if(c == 'F')
		strcpy(TextFontName,arg);

		/* Are we to use a special font size? */

	if(c == 'S')
		FontSize = atoi(arg);
}

/*
 * Function:    scr_setup()
 *
 * Arguments:
 *      margin      # of spaces in the right margin.
 *      indent      # of spaces in the left margin.
 *      scr_sz      # of lines on the screen.
 *      context     # of lines of context to keep when scrolling
 *
 * Description:
 *      This function should set up generic items in the screen
 *      interface that may need to be done before *any* output is
 *      done.
 *
 *      If SCR_SZ is not 0, then this function must use SCR_SZ as the
 *      number of lines the screen can hold at once, no matter what it
 *      may infer otherwise.  If SCR_SZ is 0, then the function must
 *      figure the size of the screen as best it can.
 *
 * Notes:
 *      Any terminal initialization needed only for actually playing
 *      the game should go in scr_begin(), not here.
 */

int
scr_setup(int margin,int indent,int scr_sz,int context)
{
	int Columns = 75;

		/* Remember the config data. */

	ConLineMargin	= margin;
	ConLineIndent	= indent;
	ConLineContext	= context;

		/* Return number of on-screen columns. */

	if(!WBenchMsg && SysBase -> LibNode . lib_Version >= 37)
	{
		struct InfoData *InfoData;

		if(InfoData = (struct InfoData *)AllocVec(sizeof(struct InfoData),MEMF_ANY))
		{
			if(DoPkt1(ThisProcess -> pr_ConsoleTask,ACTION_DISK_INFO,MKBADDR(InfoData)))
			{
				struct ConUnit *ConUnit = (struct ConUnit *)((struct IOStdReq *)InfoData -> id_InUse) -> io_Unit;

				Columns = ConUnit -> cu_XMax + 1;
			}

			FreeVec(InfoData);
		}
	}

		/* Return the number of columns. */

	return(Columns);
}

/*
 * Function:    scr_shutdown()
 *
 * Description:
 *      This function will be called just before we exit.
 */

void
scr_shutdown()
{
	/* Nothing happens here. */
}

/*
 * Function:    scr_begin()
 *
 * Arguments:
 *      game    The game datafile we're about to execute.
 *
 * Description:
 *      This function should perform terminal initializations we need
 *      to actually play the game.
 */

void
scr_begin()
{
		/* Set up the console or fail. */

	if(ConSetup())
	{
		char	*Buffer;
		int	 Len = strlen(gflags . filenm);

			/* Block GCC signal handling. */

#ifdef __GNUC__

		sigset_t trapped;

		trapped = TRAPPED_SIGNALS;

		if(sigprocmask(SIG_BLOCK,&trapped,NULL) != 0)
		{
			ConCleanup();

			exit(RETURN_FAIL);
		}

#endif	/* __GNUC__ */

			/* Determine number of lines on the screen. */

		ConNumLines = (Window -> Height - (Window -> BorderTop + Window -> BorderBottom)) / TextFontHeight;

			/* Jump to the end of the screen. */

		ConSet(0,(ConNumLines - 1) * TextFontHeight,-1);

			/* Clear the status line if any. */

		if(gflags . pr_status)
			ConPrintStatus("","");

			/* Try to get the story name in case we
			 * might need it later.
			 */

		if(NewOS)
		{
				/* Is this just the bare game file name
				 * without any path part attached?
				 */

			if(FilePart((STRPTR)gflags . filenm) == (STRPTR)gflags . filenm)
			{
					/* Allocate space for full path. */

				if(StoryName = malloc(Len + MAX_FILENAME_LENGTH))
				{
						/* Obtain the current directory name. */

					if(GetCurrentDirName(StoryName,Len + MAX_FILENAME_LENGTH))
					{
							/* Build the full path name. */

						if(!AddPart(StoryName,(STRPTR)gflags . filenm,Len + MAX_FILENAME_LENGTH))
							StoryName = "Story.Data";
					}
					else
						StoryName = "Story.Data";
				}
				else
					StoryName = "Story.Data";
			}
			else
			{
					/* Remember the name. */

				if(StoryName = malloc(Len + 1))
					strcpy(StoryName,gflags . filenm);
				else
					StoryName = "Story.Data";
			}
		}
		else
		{
				/* Remember the name. */

			if(StoryName = malloc(Len + 1))
				strcpy(StoryName,gflags . filenm);
			else
				StoryName = "Story.Data";
		}

			/* Determine story file serial number and release. */

		if(NewOS)
		{
			if(Buffer = ConLocateStory("",StoryName))
				ConQueryStoryInformation(Buffer);
		}

			/* Make a copy of the game name. */

		if(SoundName = malloc(Len + AMIGADOS_NAME_LIMIT))
		{
			strcpy(SoundName,gflags . filenm);

				/* Does the sound file name have any
				 * length, i.e. is it a real name?
				 */

			if(Len)
			{
				int i;

					/* Starting from the end of the
					 * file name look for the first
					 * path character.
					 */

				for(i = Len - 1 ; i >= 0 ; i--)
				{
						/* Is it a path name seperation
						 * character?
						 */

					if(SoundName[i] == '/' || SoundName[i] == ':')
					{
							/* Append the sound directory
							 * name to the string.
							 */

						SoundPath = &SoundName[i + 1];

							/* We're finished. */

						break;
					}
				}
			}

				/* If no proper subdirectory name was
				 * to be found, override the entire
				 * string.
				 */

			if(!SoundPath)
				SoundPath = SoundName;
		}

			/* Update the menus. */

		if(NewOS)
			ConUpdateMenus();

			/* Activate the window and bring the screen to the front. */

		if(Window)
		{
			ActivateWindow(Window);

			ScreenToFront(Window -> WScreen);
		}

			/* This interface supports a multiline status window. */

		F1_SETB(B_STATUS_WIN);
	}
	else
		exit(RETURN_FAIL);
}

/*
 * Function:    scr_end()
 *
 * Description:
 *      This function will be called after the last line is printed
 *      but before we exit, *only* if scr_begin() was called (*not* if
 *      just scr_startup() was called!)
 */

void
scr_end()
{
		/* Is the console available? */

	if(Window)
	{
			/* Scroll the screen contents up. */

		ConScrollUp();

			/* Set special colour. */

		ConSetColour(COLOUR_SPECIAL);

			/* Block the menu strip. */

		ConLockMenus();

			/* Set the proportional font. */

		SetFont(RPort,ThisFont = PropFont);

			/* Say goodbye... */

		ConPrintf("Press any key to exit.");

			/* Turn on the cursor. */

		ConCursorOn(CURSOR_AVERAGE);

			/* Wait for key to be pressed. */

		ConGetChar(TRUE);
	}

		/* If the script file is still open (although it shouldn't)
		 * close it.
		 */

	if(ScriptFile)
		scr_close_sf(ScriptFileName,ScriptFile,SF_SCRIPT);

		/* Perform cleanup. */

	ConCleanup();

		/* Enable GCC signal handling again. */

#ifdef __GNUC__

	{
		sigset_t trapped;

		trapped = TRAPPED_SIGNALS;

		sigprocmask(SIG_UNBLOCK,&trapped,NULL);
	}

#endif	/* __GNUC__ */
}

/*
 * Function:    scr_putline()
 *
 * Arguments:
 *      buffer          Line to be printed.
 *
 * Description:
 *      This function is passed a nul-terminated string and it should
 *      display the string on the terminal.  It will *not* contain a
 *      newline character.
 *
 *      This function should perform whatever wrapping, paging, etc.
 *      is necessary, print the string, and generate a final linefeed.
 *
 *      If the TI supports proportional-width fonts,
 *      F2_IS_SET(B_FIXED_FONT) should be checked as appropriate.
 *
 *      If the TI supports scripting, F2_IS_SET(B_SCRIPTING) should be
 *      checked as appropriate.
 */

void
scr_putline(const char *buffer)
{
	int MaxLen;

		/* Determine length of text line. */

	MaxLen = strlen(buffer);

		/* Check for scripting. */

	if(F2_IS_SET(B_SCRIPTING))
	{
			/* Is this just a blank line? */

		if(MaxLen)
			ScriptSplitLine((char *)buffer,MaxLen,FALSE);
		else
			ScriptWrite("",0);
	}

		/* Is this just a blank line? */

	if(MaxLen)
	{
			/* Are we to change the text rendering font?
			 * The interpreter may want to change between
			 * a fixed and a proportional-spaced font.
			 */

		if(F2_IS_SET(B_FIXED_FONT))
		{
				/* Use the fixed-width font. */

			if(ThisFont != FixedFont)
				SetFont(RPort,ThisFont = FixedFont);
		}
		else
		{
				/* Use the proportional-spaced font. */

			if(ThisFont != PropFont)
				SetFont(RPort,ThisFont = PropFont);
		}

			/* Chop the line into pieces and
			 * print it.
			 */

		ConSplitLine((char *)buffer,MaxLen,FALSE);
	}
	else
		ConPrintLine("",0,0);
}

/*
 * Function:    scr_putscore()
 *
 * Description:
 *      This function prints the ti_location and ti_status strings
 *      if it can and if status line printing is enabled.
 */

void
scr_putscore()
{
		/* Are we to print the status line? */

	if(gflags . pr_status)
	{
		IMPORT char	*ti_location,
				*ti_status;

			/* Print it. */

		if(ti_location && ti_status)
			ConPrintStatus(ti_location,ti_status);
	}
}

/*
 * Function:    scr_putsound()
 *
 * Arguments:
 *      number      sound number to play
 *      action      action to perform
 *      volume      volume to play sound at
 *      argc        number of valid arguments
 *
 * Description:
 *      This function plays the sound specified if it can; if not it
 *      prints a line to that effect.
 *
 *      If the `argc' value is 1, then the we play `number' of beeps
 *      (usually the ^G character).
 *
 *      If `argc' >1, the `action' argument is used as follows:
 *
 *          2:  play sound file
 *          3:  stop playing sound file
 *          4:  free sound resources
 *
 *      If `argc' >2, the `volume' argument is between 1 and 8 and is
 *      a volume to play the sound at.
 */

void
scr_putsound(int number,int action,int volume,int argc)
{
		/* Single argument? Just beep. */

	if(argc == 1)
	{
			/* Run down the number of beeps to produce. */

		while(number--)
		{
				/* Beep! */

			DisplayBeep(Window -> WScreen);

				/* Wait a bit. */

			if(number)
				Delay(TICKS_PER_SECOND / 2);
		}
	}
	else
	{
			/* Is the sound name buffer available? */

		if(SoundName)
		{
			Bool GotSound;

				/* What are we to do next? */

			switch(action)
			{
					/* If a new sound is to be replayed, stop
					 * the current sound.
					 */

				case 2:	if(number != SoundNumber && SoundNumber != -1 && SoundControlRequest)
					{
						SoundAbort();

							/* Free previously allocated sound data. */

						if(SoundData && SoundLength)
						{
								/* Free it. */

							FreeMem(SoundData,SoundLength);

								/* Leave no traces. */

							SoundData	= NULL;
							SoundLength	= 0;
						}

						SoundNumber = -1;
					}

						/* Make sure that we have the resources we need,
						 * either allocate them or rely on the fact that
						 * the previous call to this routine had already
						 * triggered the allocation.
						 */

					if(!SoundControlRequest)
						GotSound = SoundInit();
					else
						GotSound = TRUE;

						/* Do we have the resources or not? */

					if(GotSound)
					{
							/* If we are to replay the same sound as we
							 * did before, we are probably to change the
							 * replay volume.
							 */

						if(SoundNumber == number && SoundNumber != -1)
						{
								/* Is the sound still playing? If so,
								 * change the volume, else restart
								 * it with the new volume.
								 */

							if(!CheckIO((struct IORequest *)SoundRequestLeft))
							{
									/* Set up new volume. */

								SoundControlRequest -> ioa_Request . io_Command	= ADCMD_PERVOL;
								SoundControlRequest -> ioa_Request . io_Flags	= ADIOF_PERVOL;
								SoundControlRequest -> ioa_Volume		= volume * 8;

									/* Tell the device to make the change. */

								SendIO((struct IORequest *)SoundControlRequest);
								WaitIO((struct IORequest *)SoundControlRequest);
							}
							else
							{
									/* Wait for requests to return. */

								SoundAbort();

									/* Set up new volume. */

								SoundRequestLeft  -> ioa_Volume = volume * 8;
								SoundRequestRight -> ioa_Volume = volume * 8;

									/* Stop the sound. */

								SoundStop();

									/* Queue the sound. */

								BeginIO((struct IORequest *)SoundRequestLeft);
								BeginIO((struct IORequest *)SoundRequestRight);

									/* Start the sound. */

								SoundStart();
							}
						}
						else
						{
								/* The sound file header. */

							struct
							{
								UBYTE	Reserved1[2];
								BYTE	Times;		/* How many times to play (0 = continuously). */
								UBYTE	Rate[2];	/* Replay rate (note: little endian). */
								UBYTE	Reserved2[3];
								UWORD	PlayLength;	/* Length of sound to replay. */
							} SoundHeader;

								/* Sound file handle and name buffer. */

							FILE *SoundFile;

								/* Cancel the number of the previously loaded
								 * sound in case the load fails.
								 */

							SoundNumber = -1;

								/* Set up the sound file name. */

							sprintf(SoundPath,"sound/s%d.dat",number);

								/* Open the file for reading. */

							if(SoundFile = fopen(SoundName,"rb"))
							{
									/* Read the file header. */

								if(fread(&SoundHeader,sizeof(SoundHeader),1,SoundFile) == 1)
								{
										/* Remember the sound file length. */

									SoundLength = SoundHeader . PlayLength;

										/* Allocate chip ram for the sound data. */

									if(SoundData = (APTR)AllocMem(SoundLength,MEMF_CHIP))
									{
											/* Read the sound data. */

										if(fread(SoundData,SoundLength,1,SoundFile) == 1)
										{
												/* Turn the replay rate into a
												 * sensible number.
												 */

											ULONG Rate = (GfxBase -> DisplayFlags & PAL ? 3546895 : 3579545) / ((((UWORD)SoundHeader . Rate[1]) << 8) | SoundHeader . Rate[0]);

												/* Set up the left channel. */

											SoundRequestLeft -> ioa_Request . io_Command	= CMD_WRITE;
											SoundRequestLeft -> ioa_Request . io_Flags	= ADIOF_PERVOL;
											SoundRequestLeft -> ioa_Period			= Rate;
											SoundRequestLeft -> ioa_Volume			= volume * 8;
											SoundRequestLeft -> ioa_Cycles			= SoundHeader . Times;
											SoundRequestLeft -> ioa_Data			= SoundData;
											SoundRequestLeft -> ioa_Length			= SoundLength;

												/* Set up the right channel. */

											SoundRequestRight -> ioa_Request . io_Command	= CMD_WRITE;
											SoundRequestRight -> ioa_Request . io_Flags	= ADIOF_PERVOL;
											SoundRequestRight -> ioa_Period			= Rate;
											SoundRequestRight -> ioa_Volume			= volume * 8;
											SoundRequestRight -> ioa_Cycles			= SoundHeader . Times;
											SoundRequestRight -> ioa_Data			= SoundData;
											SoundRequestRight -> ioa_Length			= SoundLength;

												/* Set up the control request. */

											SoundControlRequest -> ioa_Period		= Rate;

												/* Stop playing any sound. */

											SoundStop();

												/* Queue the sound. */

											BeginIO((struct IORequest *)SoundRequestLeft);
											BeginIO((struct IORequest *)SoundRequestRight);

												/* Play the sound. */

											SoundStart();

												/* Remember the number of the current sound. */

											SoundNumber = number;
										}
										else
										{
												/* The load failed, free the audio memory. */

											FreeMem(SoundData,SoundLength);

												/* Leave no traces. */

											SoundData	= NULL;
											SoundLength	= 0;
										}
									}
								}

									/* Close the sound file. */

								fclose(SoundFile);
							}
						}
					}

					break;

					/* Stop the current sound. */

				case 3:	SoundExit();
					break;
			}
		}
	}
}

/*
 * Function:    scr_putmesg()
 *
 * Arguments:
 *      buffer      message string to be printed.
 *      is_err      1 if message is an error message, 0 if it's not.
 *
 * Description:
 *      This function prints out a message from the interpreter, not
 *      from the game itself.  Often these are errors (IS_ERROR==1)
 *      but not necessarily.
 */

void
scr_putmesg(const char *buffer,Bool is_err)
{
		/* Provide an empty line. */

	ConScrollUp();

		/* Is this supposed to be an error message? */

	if(is_err)
	{
			/* Set error text colour. */

		ConSetColour(COLOUR_ERROR);

			/* Display the error message. */

		ConPrintf("[%s]",buffer);

			/* Reset text colour. */

		ConSetColour(COLOUR_TEXT);
	}
	else
		ConPrintf("[%s]",buffer);
}

/*
 * Function:    scr_getline()
 *
 * Arguments:
 *      prompt    - prompt to be printed
 *      length    - total size of BUFFER
 *      buffer    - buffer to return nul-terminated response in
 *
 * Returns:
 *      # of chars stored in BUFFER
 *
 * Description:
 *      Reads a line of input and returns it.  Handles all "special
 *      operations" such as readline history support, shell escapes,
 *      etc. invisibly to the caller.  Note that the returned BUFFER
 *      will be at most LENGTH-1 chars long because the last char will
 *      always be the nul character.
 *
 *      If the command begins with ESC_CHAR then it's an interpreter
 *      escape command; call ti_escape() with the rest of the line,
 *      then ask for another command.
 *
 * Notes:
 *      May print the STATUS buffer more than once if necessary (i.e.,
 *      a shell escape messed up the screen, a history listing was
 *      generated, etc.).
 */

int
scr_getline(const char *prompt,int length,char *buffer)
{
	char	*EscapeChar	= ESC_CHAR,
		*NewPrompt	= (char *)prompt;
	Bool	 Done		= FALSE;
	int	 InputLength;

		/* Loop until user provides any input. */

	do
	{
			/* Get the scripting menu item. */

		if(NewOS)
		{
			struct MenuItem *Item;

			if(Item = ItemAddress(Menu,FULLMENUNUM(MENU_PROJECT,PROJECTMENU_SCRIPT,NOSUB)))
			{
					/* Change the state of the checkmark. */

				if(!F2_IS_SET(B_SCRIPTING) && (Item -> Flags & CHECKED))
					Item -> Flags &= ~CHECKED;
			}

				/* Update the menu strip. */

			ConUpdateMenus();
		}

			/* Print the status line. */

		scr_putscore();

			/* Scroll the screen contents up. */

		ConScrollUp();

			/* Do we have any prompt to print? */

		if(NewPrompt[0])
		{
				/* Split the prompt and print it. */

			NewPrompt = ConSplitLine(NewPrompt,strlen(NewPrompt),TRUE);

				/* If the prompt was turned into several
				 * lines of text, scroll the screen
				 * contents up.
				 */

			if(NewPrompt != prompt)
				ConScrollUp();

				/* Is there still anything left of it?
				 * If so, print it.
				 */

			if(NewPrompt[0])
				ConWrite(NewPrompt,-1,0);
		}

			/* Enough done. */

		ConLinesPrinted = 0;

			/* Turn on the cursor. */

		ConCursorOn(CURSOR_AVERAGE);

			/* Change the text colour. */

		ConSetColour(COLOUR_INPUT);

			/* Read the line of text. */

		InputLength = ConInput(NewPrompt,buffer,length,TRUE);

			/* Strip trailing blank spaces. */

		while(InputLength > 0)
		{
			if(buffer[InputLength - 1] == ' ')
				InputLength--;
			else
				break;
		}

			/* Provide null-termination. */

		buffer[InputLength] = 0;

			/* Set the text colour. */

		ConSetColour(COLOUR_TEXT);

			/* Turn the cursor off. */

		ConCursorOff();

			/* Special actions to be taken? */

		if(*buffer == *EscapeChar)
		{
				/* Perform special actions. */

			ti_escape(&buffer[1]);

				/* Update options menu items. */

			if(NewOS)
				ConUpdateMenus();
		}
		else
			Done = TRUE;
	}
	while(!Done);

		/* Output text to script file. */

	if(F2_IS_SET(B_SCRIPTING))
	{
			/* Split the prompt. */

		NewPrompt = ScriptSplitLine((char *)prompt,strlen(prompt),TRUE);

			/* Build prompt and input string. */

		strcpy(TempBuffer,NewPrompt);
		strcat(TempBuffer,buffer);

			/* Transcribe it. */

		ScriptWrite(TempBuffer,strlen(TempBuffer));
	}

		/* Return number of characters read. */

	return(InputLength);
}

/*
 * Function:    scr_window()
 *
 * Arguments:
 *      size      - 0 to delete, non-0 means create with SIZE.
 *
 * Description:
 *      Causes a status window to be created if supported by the
 *      terminal interface; note this function won't be called unless
 *      F1_SETB(B_STATUS_WIN) is invoked in scr_begin().
 *
 * Notes:
 */

void
scr_window(int size)
{
		/* Are we to set up the status window? */

	if(size)
	{
			/* Determine new status window area. */

		ConNumStatusLines = size + 1;

			/* Clear the status window area. */

		SetAPen(RPort,ConBackPen);

		RectFill(RPort,Window -> BorderLeft,Window -> BorderTop + TextFontHeight,Window -> Width - Window -> BorderRight - 1,Window -> BorderTop + TextFontHeight * (size + 1) - 1);

		SetAPen(RPort,ConTextPen);
	}
	else
	{
			/* Reset to defaults. */

		ConNumStatusLines	= 1;
		ConOutputWindow		= 0;
	}
}

/*
 * Function:    scr_set_win()
 *
 * Arguments:
 *      win       - 0==select text window, 1==select status window
 *
 * Description:
 *      Selects a different window.  This function won't be called
 *      unless call F1_SETB(B_STATUS_WIN) in scr_begin().
 *
 * Notes:
 */

void
scr_set_win(int win)
{
	STATIC LONG	SavedCursorX,
			SavedCursorY;

		/* Are we to select the status window? */

	if(win)
	{
			/* Is the text window still active? */

		if(!ConOutputWindow)
		{
				/* Remember old cursor position. */

			SavedCursorX = CursorX;
			SavedCursorY = CursorY;

				/* Turn the cursor off, we
				 * won't be needing it.
				 */

			ConCursorOff();

				/* Remember new output window area. */

			ConOutputWindow = win;
		}

			/* Move to the beginning of the status window. */

		CursorY = TextFontHeight;
		CursorX = 0;
	}
	else
	{
			/* Is the status window still active? */

		if(ConOutputWindow)
		{
				/* Get back the old cursor position. */

			CursorX = SavedCursorX;
			CursorY = SavedCursorY;

				/* Turn the cursor back on. */

			ConCursorOn(CURSOR_NOCHANGE);

				/* Change the current output window. */

			ConOutputWindow = win;
		}
	}
}

/*
 * Function:    scr_open_sf()
 *
 * Arguments:
 *      length    - total size of BUFFER
 *      buffer    - buffer to return nul-terminated filename in
 *      type      - SF_SAVE     opening the file to save into
 *                  SF_RESTORE  opening the file to restore from
 *                  SF_SCRIPT   opening a file for scripting
 *
 * Returns:
 *      FILE* - reference to the opened file, or
 *      NULL  - errno==0: operation cancelled, else error opening file
 *
 * Description:
 *      Obtains the name of the file to be opened for writing (if
 *      TYPE==SF_SAVE or SF_SCRIPT) or reading (if TYPE==SF_RESTORE),
 *      opens the file with fopen(), and returns the FILE*.
 *
 *      The name of the file should be stored in BUFFER.  Upon initial
 *      calling BUFFER contains a possible default filename.
 *
 *      if LENGTH==0 then don't ask the user for a name, just use
 *      BUFFER.  This means, for example, we got the -r option to
 *      restore the file.
 *
 *      If the fopen() fails just return NULL: if errno!=0 then an
 *      error will be printed.
 *
 * Notes:
 *      History is turned off here (why would anyone want it?)
 */

FILE *
scr_open_sf(int length, char *buffer, int type)
{
		/* Prompt buffer and filename buffer. */

	STATIC char	FileName[MAX_FILENAME_LENGTH],
			Prompt[MAX_FILENAME_LENGTH + 18];

		/* Are we running under control of Kickstart 2.04 or higher? */

	if(NewOS)
	{
		Bool	 GotName = FALSE,
			 GotFile = FALSE;
		int	 Len;
		char	*ScriptMode;

			/* Are we to prompt for a file name? */

		if(length)
		{
			STATIC struct Requester BlockRequester;

				/* Clear the window requester. */

			memset(&BlockRequester,0,sizeof(struct Requester));

				/* Install the requester, blocking all window input. */

			Request(&BlockRequester,Window);

				/* Set the window wait pointer. */

			WaitPointer(Window);

				/* No scripting in this part, please. */

			if(type != SF_SCRIPT)
			{
					/* Are we to load a saved game file? */

				if(ProjectName[0])
				{
						/* Is the project name small enough to fit? */

					if((Len = strlen(ProjectName)) < length)
					{
							/* Store the project name. */

						strcpy(buffer,ProjectName);

							/* Now we've got a name. */

						GotName = TRUE;
					}

						/* Clear the project name. */

					ProjectName[0] = 0;
				}
				else
				{
					char *Index;

						/* Loop until a proper name is entered or the
						 * selection is aborted.
						 */

					do
					{
							/* Save the input file name. */

						strcpy(FileName,buffer);

							/* Extract the path name. */

						if(Index = PathPart(FileName))
							*Index = 0;

							/* If no path name is given, supply the
							 * current directory.
							 */

						if(!FileName[0])
						{
							/* Try to obtain the current directory name.
							 * If this fails, leave the path name empty.
							 */

							if(!GetCurrentDirName(FileName,MAX_FILENAME_LENGTH))
								FileName[0] = 0;
						}

							/* Request a file and path name. */

						if(AslRequestTags(GameFileRequest,
							ASL_Window,	Window,
							ASL_Dir,	FileName,
							ASL_File,	FilePart(buffer),
							ASL_FuncFlags,	(type == SF_SAVE) ? FILF_SAVE | FILF_PATGAD	: FILF_PATGAD,
							ASL_Hail,	(type == SF_SAVE) ? "Select game file to save"	: "Select game file to restore",
							ASL_Pattern,	"#?.Save",
						TAG_DONE))
						{
								/* Did the user select a file? */

							if(Len = strlen((char *)GameFileRequest -> rf_File))
							{
								char *Name = (char *)GameFileRequest -> rf_File;

									/* Are we to save a game file? */

								if(type == SF_SAVE)
								{
									Bool NewName = FALSE;

										/* Is there enough space left to append
										 * the `.Save' suffix?
										 */

									if(Len <= AMIGADOS_NAME_LIMIT - SAVE_SUFFIX_LENGTH)
									{
										if(Len > SAVE_SUFFIX_LENGTH)
										{
												/* Does it already have the `.Save' suffix
												 * attached?
												 */

											if(Stricmp((STRPTR)&Name[Len - SAVE_SUFFIX_LENGTH],SAVE_SUFFIX))
												NewName = TRUE;
										}
										else
											NewName = TRUE;
									}

										/* Are we to append the `.Save' suffix? */

									if(NewName)
									{
											/* Tack on the suffix. */

										strcpy(TempBuffer,Name);
										strcat(TempBuffer,SAVE_SUFFIX);

										Name = TempBuffer;
									}
								}

									/* Copy the path name. */

								strcpy(FileName,(char *)GameFileRequest -> rf_Dir);

									/* Attach the file name. */

								if(AddPart((STRPTR)FileName,(STRPTR)Name,MAX_FILENAME_LENGTH))
								{
										/* Copy the new file name. */

									strcpy(buffer,FileName);

										/* Check whether the destination file already
										 * exists.
										 */

									if(type == SF_SAVE)
									{
										BPTR FileLock;

											/* Does it already exist? */

										if(FileLock = Lock(FileName,ACCESS_READ))
										{
												/* Release the lock. */

											UnLock(FileLock);

												/* Ask the user what to do next. */

											switch(ConShowRequest(Window,"You are about to overwrite an existing file!","Proceed|New name|Cancel"))
											{
												case SAVE_CANCEL:	GotFile = TRUE;
															break;

												case SAVE_PROCEED:	GotFile = GotName = TRUE;
															break;

												case SAVE_NEWNAME:	GotFile = FALSE;
															break;
											}
										}
										else
										{
												/* Remember that we got a new file name. */

											GotFile = GotName = TRUE;
										}
									}
									else
									{
											/* Remember that we got a new file name. */

										GotFile = GotName = TRUE;
									}
								}
								else
									GotFile = TRUE;
							}
							else
								GotFile = TRUE;
						}
						else
							GotFile = TRUE;
					}
					while(!GotFile);
				}
			}
			else
			{
					/* If no printer width has been defined yet,
					 * consult the system preferences settings.
					 */

				if(!ScriptWidth)
				{
					struct Preferences Prefs;

						/* Get the system preferences. */

					if(GetPrefs(&Prefs,sizeof(struct Preferences)))
					{
							/* Adjust the width if too small. */

						if((ScriptWidth = (int)Prefs . PrintRightMargin - (int)Prefs . PrintLeftMargin + 1) < MIN_PRINTER_COLUMNS)
							ScriptWidth = MIN_PRINTER_COLUMNS;
					}
				}

					/* Loop until we get a name. */

				do
				{
						/* Get the desired output file and width. */

					if(ScriptGetPrinterName((STRPTR)buffer,&ScriptWidth))
					{
						STRPTR Index;

							/* Get the file path part. */

						Index = PathPart(buffer);

							/* Is it a real file or a device
							 * name such as "PRT:"?
							 */

						if(*Index)
						{
							BPTR FileLock;

								/* Does it exist already? */

							if(FileLock = Lock(buffer,ACCESS_READ))
							{
									/* Release the lock. */

								UnLock(FileLock);

									/* Ask the user what to do next. */

								switch(ConShowRequest(Window,"You are about to overwrite an existing file!","Proceed|Append|New name|Cancel"))
								{
									case SCRIPT_CANCEL:	GotFile = TRUE;

												break;

									case SCRIPT_PROCEED:	ScriptMode = "w";

												GotFile = GotName = TRUE;

												break;

									case SCRIPT_APPEND:	ScriptMode = "a";

												GotFile = GotName = TRUE;

												break;

									case SCRIPT_NEWNAME:	continue;
								}
							}
							else
							{
								ScriptMode = "w";

								GotFile = GotName = TRUE;
							}
						}
						else
						{
							ScriptMode = "w";

							GotFile = GotName = TRUE;
						}
					}
					else
						GotFile = TRUE;
				}
				while(!GotFile);
			}

				/* Remove the window wait pointer. */

			ClearPointer(Window);

				/* Remove the blocking requester. */

			EndRequest(&BlockRequester,Window);
		}
		else
			GotName = TRUE;

			/* Return the result. */

		if(GotName)
	        {
			FILE *File;

				/* Get the file name. */

			strcpy(WindowTitle,FilePart((STRPTR)buffer));

				/* Determine file name length. */

			Len = strlen(WindowTitle);

				/* Is it long enough to hold the ".Save" suffix? */

			if(Len > SAVE_SUFFIX_LENGTH)
			{
					/* Is the ".Save" suffix present? If so,
					 * get rid of it.
					 */

				if(!Stricmp(&WindowTitle[Len - SAVE_SUFFIX_LENGTH],SAVE_SUFFIX))
					WindowTitle[Len - SAVE_SUFFIX_LENGTH] = 0;
			}

				/* Open the output file. */

			switch(type)
			{
					/* Saved game file handling. */

				case SF_SAVE:		if(File = fopen(buffer,"wb"))
							{
								if(!Screen)
									SetWindowTitles(Window,WindowTitle,(STRPTR)~0);
							}

							return(File);

				case SF_RESTORE:	if(File = fopen(buffer,"rb"))
							{
								if(!Screen)
									SetWindowTitles(Window,WindowTitle,(STRPTR)~0);
							}

							return(File);

					/* Script file handling. */

				case SF_SCRIPT:		if(ScriptFile = fopen(buffer,ScriptMode))
							{
								struct MenuItem *Item;

								strcpy(ScriptFileName,buffer);

									/* Block the menu strip. */

								ConLockMenus();

									/* Change the `Script...' menu item
									 * according to the current scripting
									 * settings.
									 */

								Item = ItemAddress(Menu,FULLMENUNUM(MENU_PROJECT,PROJECTMENU_SCRIPT,NOSUB));

								Item -> Flags |= CHECKED;

									/* Enable the menu strip again. */

								ConUnlockMenus();

									/* Clear the flag. */

								ScriptAborted = FALSE;
							}

							return(ScriptFile);
			}
		}
	}
	else
	{
			/* Are we to ask the user to provide any input? */

		if(length)
		{
				/* Tell the user what to do. */

			scr_putline("Enter a file name.");

				/* Build a prompt string. */

			sprintf(Prompt,"(Default is \"%s\") >",buffer);

				/* Read the input line. */

			if(!scr_getline(Prompt,MAX_FILENAME_LENGTH,FileName))
				strcpy(FileName,buffer);

				/* Are we to open a file for saving? */

			if(type == SF_SAVE || type == SF_SCRIPT)
			{
				BPTR	FileLock;
				int	Len = strlen(FileName);

					/* If no printer width has been defined yet,
					 * consult the system preferences settings.
					 */

				if(!ScriptWidth && type == SF_SCRIPT)
				{
					struct Preferences Prefs;

						/* Get the system preferences. */

					if(GetPrefs(&Prefs,sizeof(struct Preferences)))
					{
							/* Adjust the width if too small. */

						if((ScriptWidth = (int)Prefs . PrintRightMargin - (int)Prefs . PrintLeftMargin + 1) < MIN_PRINTER_COLUMNS)
							ScriptWidth = MIN_PRINTER_COLUMNS;
					}
				}

				if(type == SF_SAVE || (type == SF_SCRIPT && FileName[Len - 1] != ':'))
				{
						/* Does the file already exist? */

					if(FileLock = Lock(FileName,ACCESS_READ))
					{
							/* Release the lock on it. */

						UnLock(FileLock);

							/* Print a warning message. */

						scr_putline("You are about to write over an existing file.");

							/* Really continue? */

						if(scr_getline("Proceed? (Y/N) >",1,TempBuffer))
						{
								/* Check */

							if(toupper(TempBuffer[0]) != 'Y')
								return(NULL);
						}
						else
							return(NULL);
					}

						/* Store the new file name. */

					strcpy(buffer,FileName);

						/* Open the file. */

					if(type == SF_SCRIPT)
					{
						if(ScriptFile = fopen(buffer,"w"))
							strcpy(ScriptFileName,buffer);

						return(ScriptFile);
					}
					else
						return(fopen(buffer,"wb"));
				}
				else
				{
					if(ScriptFile = fopen(buffer,"w"))
						strcpy(ScriptFileName,buffer);

					return(ScriptFile);
				}
			}
			else
			{
					/* Store the new file name. */

				strcpy(buffer,FileName);

					/* Open the file. */

				return(fopen(buffer,"rb"));
			}
		}
		else
		{
				/* Open a file without asking for a name. */

			switch(type)
			{
				case SF_SCRIPT:		if(ScriptFile = fopen(buffer,"w"))
								strcpy(ScriptFileName,buffer);

							return(ScriptFile);

				case SF_SAVE:		return(fopen(buffer,"wb"));
				case SF_RESTORE:	return(fopen(buffer,"rb"));
			}
		}
	}

	return(NULL);
}

/*
 * Function:    scr_close_sf()
 *
 * Arguments:
 *      filenm    - name of file just processed
 *      fp        - FILE* to open saved file
 *      type      - SF_SAVE     closing a saved game file
 *                  SF_RESTORE  closing a restored game file
 *                  SF_SCRIPT   closing a scripting file
 *
 * Description:
 *      This function will be called immediately after a successful
 *      save or restore of a game file, so that if the interface needs
 *      to perform any actions related to the saved game it may.  It
 *      will also be called when the interpreter notices that
 *      scripting has been turned off.  It should at least close the
 *      file.
 *
 *      This function will only be called if the save/restore of the
 *      game succeeded; if it fails the file will be closed by the
 *      interpreter.
 */

void
scr_close_sf(const char * filenm, FILE *fp, int type)
{
	struct DiskObject	*Icon = NULL;
	int			 Len;

		/* Close the file. */

	fclose(fp);

		/* What are we to do? */

	switch(type)
	{
			/* Close a saved game file? */

		case SF_SAVE:

				/* Clear the `executable' bit. */

			SetProtection((char *)filenm,FIBF_EXECUTE);

				/* Get the default icon. */

			if(IconBase)
			{
				if(NewOS)
					Icon = GetDiskObject("PROGDIR:Icon.Data");
				else
					Icon = GetDiskObject("Icon.Data");
			}

				/* Did we get any? */

			if(Icon)
			{
				STRPTR *ToolTypes;

					/* Create the tool type array. */

				if(ToolTypes = (STRPTR *)malloc(sizeof(char *) * (NUM_FKEYS + NUM_OPTIONS + 1)))
				{
					int i,j = 0;

						/* Fill in the file type. */

					ToolTypes[j++] = "FILETYPE=BOOKMARK|ITF";

						/* Add the story file name. */

					if(ToolTypes[j] = (STRPTR)malloc(strlen(StoryName) + 7))
						sprintf(ToolTypes[j++],"STORY=%s",StoryName);

						/* Add the number of inter-page context lines,
						 * margin and indent settings.
						 */

					if(ToolTypes[j] = (STRPTR)malloc(30))
						sprintf(ToolTypes[j++],"CONTEXT=%d",ConLineContext);

					if(ToolTypes[j] = (STRPTR)malloc(30))
						sprintf(ToolTypes[j++],"INDENT=%d",ConLineIndent);

					if(ToolTypes[j] = (STRPTR)malloc(30))
						sprintf(ToolTypes[j++],"MARGIN=%d",ConLineMargin);

						/* Take care of the remaining options. */

					if(ConQueryOption(OPTION_ATTRIBUTE_ASSIGNMENTS))
					{
						if(ToolTypes[j] = (STRPTR)malloc(21))
							strcpy(ToolTypes[j++],"ATTRIBUTEASSIGNMENTS");
					}

					if(ConQueryOption(OPTION_ATTRIBUTE_TESTS))
					{
						if(ToolTypes[j] = (STRPTR)malloc(15))
							strcpy(ToolTypes[j++],"ATTRIBUTETESTS");
					}

					if(ConQueryOption(OPTION_ECHO))
					{
						if(ToolTypes[j] = (STRPTR)malloc(5))
							strcpy(ToolTypes[j++],"ECHO");
					}

					if(!ConQueryOption(OPTION_PAGING))
					{
						if(ToolTypes[j] = (STRPTR)malloc(8))
							strcpy(ToolTypes[j++],"NOPAGER");
					}

					if(ConQueryOption(OPTION_PROMPT))
					{
						if(ToolTypes[j] = (STRPTR)malloc(7))
							strcpy(ToolTypes[j++],"PROMPT");
					}

					if(!ConQueryOption(OPTION_STATUS))
					{
						if(ToolTypes[j] = (STRPTR)malloc(9))
							strcpy(ToolTypes[j++],"NOSTATUS");
					}

					if(ConQueryOption(OPTION_XFERS))
					{
						if(ToolTypes[j] = (STRPTR)malloc(10))
							strcpy(ToolTypes[j++],"TRANSFERS");
					}

					if(ConQueryOption(OPTION_TANDY))
					{
						if(ToolTypes[j] = (STRPTR)malloc(6))
							strcpy(ToolTypes[j++],"TANDY");
					}

						/* Add the function key definitions if any. */

					for(i = 0 ; i < NUM_FKEYS ; i++)
					{
						if(FunctionKeys[i] . sb_Len)
						{
							if(ToolTypes[j] = (STRPTR)malloc(FunctionKeys[i] . sb_Len + 5))
								sprintf((char *)ToolTypes[j++],"F%02d=%s",i + 1,FunctionKeys[i] . sb_Buffer);
						}
					}

						/* Terminate the tool type array. */

					ToolTypes[j] = NULL;

						/* Were we started from Workbench? */

					if(WBenchMsg)
					{
						if(NewOS)
						{
								/* Get the program directory. */

							if(NameFromLock(WBenchMsg -> sm_ArgList[0] . wa_Lock,TempBuffer,MAX_FILENAME_LENGTH))
							{
									/* Add the file name. */

								if(!AddPart(TempBuffer,WBenchMsg -> sm_ArgList[0] . wa_Name,MAX_FILENAME_LENGTH))
									strcpy((char *)TempBuffer,WBenchMsg -> sm_ArgList[0] . wa_Name);
							}
							else
								strcpy((char *)TempBuffer,WBenchMsg -> sm_ArgList[0] . wa_Name);
						}
						else
							strcpy((char *)TempBuffer,WBenchMsg -> sm_ArgList[0] . wa_Name);
					}
					else
					{
						if(NewOS)
						{
								/* Get the program name. */

							if(!GetProgramName(TempBuffer,MAX_FILENAME_LENGTH))
								strcpy((char *)TempBuffer,"Infocom");
						}
						else
							strcpy((char *)TempBuffer,"Infocom");
					}

						/* Fill in the icon data. */

					Icon -> do_DefaultTool	= (char *)TempBuffer;
					Icon -> do_ToolTypes	= (char **)ToolTypes;
					Icon -> do_StackSize	= ThisProcess -> pr_StackSize;
					Icon -> do_CurrentX	= NO_ICON_POSITION;
					Icon -> do_CurrentY	= NO_ICON_POSITION;

						/* Create the icon. */

					if(!PutDiskObject((char *)filenm,Icon))
						scr_putmesg("Error creating icon file",TRUE);

						/* Free the tool type entries. */

					for(i = 1 ; i < j ; i++)
						free(ToolTypes[i]);

						/* Free the tool type array. */

					free(ToolTypes);
				}
			}
			else
				scr_putmesg("No icon",FALSE);

			break;

				/* Close a restored game file? */

		case SF_RESTORE:

				/* Get the file icon. */

			if(IconBase)
			{
				if(Icon = GetDiskObject((char *)filenm))
				{
					char	 Buffer[5],
						*Type;
					int	 i;

						/* Does it have a filetype info attached? */

					if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FILETYPE"))
					{
							/* Is it a bookmark file? */

						if(MatchToolValue(Type,"BOOKMARK") && MatchToolValue(Type,"ITF"))
						{
								/* Check for function key
								 * defintions and set them
								 * if approriate.
								 */

							for(i = 0 ; i < NUM_FKEYS ; i++)
							{
									/* Build fkey string. */

								sprintf(Buffer,"F%02d",i + 1);

									/* See if we can find it. */

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,Buffer))
									ConSetKey(i,Type,strlen(Type));
								else
									ConSetKey(i,"",0);
							}
						}
					}
				}
				else
					scr_putmesg("No icon",FALSE);
			}
			else
				scr_putmesg("No icon",FALSE);

			break;

		/* Close a script file? */

	case SF_SCRIPT:

				/* Clear the script file pointer. */

			ScriptFile = NULL;

				/* Determine file name length. */

			Len = strlen(filenm);

				/* Is this a file or a device name? */

			if(filenm[Len - 1] != ':')
			{
					/* Clear the executable bit. */

				SetProtection((STRPTR)filenm,FIBF_EXECUTE);

					/* Try to read the story file icon. */

				if(IconBase)
				{
					if(NewOS)
					{
						char *Name;

							/* Try to locate the story file location... */

						if(Name = ConLocateStory("",StoryName))
							Icon = GetDiskObject(Name);
					}

						/* If everything else fails,
						 * try the default.
						 */

					if(!Icon)
						Icon = GetDiskObject("Story.Data");
				}

					/* Did we get one? */

				if(Icon)
				{
					STATIC char *ToolTypes[] =
					{
						"FILETYPE=TEXT|ASCII",
						NULL
					};

						/* Set up the default information. */

					Icon -> do_DefaultTool	= "SYS:Utilities/More";
					Icon -> do_ToolTypes	= ToolTypes;
					Icon -> do_StackSize	= 8192;
					Icon -> do_CurrentX	= NO_ICON_POSITION;
					Icon -> do_CurrentY	= NO_ICON_POSITION;

						/* Create the icon. */

					if(!PutDiskObject((char *)filenm,Icon))
						scr_putmesg("Error creating icon file",TRUE);
				}
				else
					scr_putmesg("No icon",FALSE);
			}

			if(NewOS)
			{
				struct MenuItem *Item;

					/* Block the menu strip. */

				ConLockMenus();

					/* Change the `Script...' menu item
					 * according to the current scripting
					 * settings.
					 */

				Item = ItemAddress(Menu,FULLMENUNUM(MENU_PROJECT,PROJECTMENU_SCRIPT,NOSUB));

				Item -> Flags &= ~CHECKED;

					/* Enable the menu strip again. */

				ConUnlockMenus();
			}

			break;
	}

		/* Release the icon data. */

	if(Icon)
		FreeDiskObject(Icon);
}
