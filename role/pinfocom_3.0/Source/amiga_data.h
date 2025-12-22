/* amiga_data.h
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
 * $Header: RCS/amiga_data.h,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

	/* Clipboard support data. */

extern struct IFFHandle		*ClipHandle;

extern STRPTR			 ClipBuffer,
				 ClipIndex;

extern LONG			 ClipSize,
				 ClipLength;

extern Bool			 ClipInput;

	/* Global library pointers, don't touch! */

extern struct ExecBase		*SysBase;

extern struct IntuitionBase	*IntuitionBase;
extern struct GfxBase		*GfxBase;

extern struct Library		*WorkbenchBase,
				*DiskfontBase,
				*IFFParseBase,
				*GadToolsBase,
				*UtilityBase,
				*IconBase,
				*AslBase;

extern struct Device		*ConsoleDevice;

	/* Workbench startup message. */

extern struct WBStartup		*WBenchMsg;

	/* Screen and window data. */

extern struct Window		*Window;
extern struct Menu		*Menu;
extern struct RastPort		*RPort;

extern struct Screen		*DefaultScreen,
				*Screen;
extern APTR			 VisualInfo;
extern UBYTE			 Depth;

	/* Default window title. */

extern TEXT			 WindowTitle[AMIGADOS_NAME_LIMIT + 1];

	/* Global flags. */

extern Bool			 UseCustomScreen,
				 WindowIsActive,
				 LibsOpened,
				 NewOS;

	/* Console IO data. */

extern struct IOStdReq		*ConRequest;
extern struct InputEvent	*InputEvent;
extern STRPTR			 InputEventBuffer;

extern LONG			 CursorX,
				 CursorY,
				 SpaceWidth,
				 LastCursorX,
				 LastCursorY,
				 OldCursorWidth,
				 NewCursorWidth,
				 DefaultCursorWidth;

extern int			 MenuLockCount;

extern Bool			 RedrawInputLine,
				 CursorEnabled;

	/* Process and window tricks. */

extern struct Process		*ThisProcess;
extern APTR			 WindowPtr;

	/* Timer data. */

extern struct MsgPort		*TimePort;
extern struct timerequest	*TimeRequest;

	/* Workbench appwindow support. */

extern struct MsgPort		*WorkbenchPort;
extern struct AppWindow	*WorkbenchWindow;

	/* The name of the project to restore. */

extern TEXT			 ProjectName[MAX_FILENAME_LENGTH];

	/* A temporary string buffer. */

extern TEXT			 TempBuffer[BUFFER_LENGTH];

	/* Story file name. */

extern char			*StoryName;

	/* Story serial number. */

extern ULONG			 StorySerial,
				 StoryRelease,
				 StoryIndex;

	/* Default story file name and file
	 * extension.
	 */

extern char			*StoryNames[],
				*StoryExtensions[];

	/* Two different fonts. */

extern struct TextFont		*PropFont,
				*FixedFont,
				*ThisFont;

	/* Disk font support. */

extern struct TextFont		*ListFont,
				*TextFont;

extern TEXT			 ListFontName[MAXFONTPATH],
				 TextFontName[MAXFONTPATH];

extern LONG			 FontSize;

extern struct TextAttr		 ListFontAttr,
				 TextFontAttr;

	/* Text font dimensions. */

extern UWORD			 TextFontWidth,
				 TextFontHeight;

	/* Window dimensions. */

extern WORD			 WindowWidth,
				 OldWindowWidth,
				 OldWindowHeight;

	/* Screen characteristics. */

extern LONG			 ConNumLines,
				 ConLinesPrinted,
				 ConLineContext,
				 ConLineIndent,
				 ConLineMargin;

	/* Text and background pens. */

extern LONG			 ConTextPen,
				 ConBackPen;

	/* Fixed status window support. */

extern LONG			 ConNumStatusLines;
extern int			 ConOutputWindow;

	/* History management. */

extern struct StringBuffer	 HistoryBuffer[HISTORY_LINES];
extern int			 LastHistory;

	/* Function key support. */

extern struct StringBuffer	 FunctionKeys[NUM_FKEYS];

	/* Fake input buffer. */

extern TEXT			 InputBuffer[INPUT_LENGTH];
extern STRPTR			 InputIndex;

	/* Data to be located in chip-memory. */

extern UWORD			*ChipData;

	/* Pull-down menu definitions. */

extern struct NewMenu ConMenuConfig[NUM_MENUS];

	/* Stopwatch mouse pointer data. */

extern UWORD StopwatchData[(1 + STOPWATCH_HEIGHT + 1) * 2];

	/* File requester support. */

extern struct FileRequester	*GameFileRequest;

	/* Game file release and serial numbers. */

extern LONG			 SerialNumbers[][3];

	/* Type 3 game titles. */

extern char			*Titles[NUM_GAMES];

	/* Type 3 game authors. */

extern char			*Authors[NUM_GAMES];

	/* Type 3 game levels. */

extern int			 GameLevels[NUM_GAMES];
extern char			*Levels[LEVEL_EXPERT + 1];

	/* Transcript file support. */

extern FILE			*ScriptFile;
extern TEXT			 ScriptFileName[MAX_FILENAME_LENGTH];
extern int			 ScriptWidth;
extern Bool			 ScriptAborted;

	/* Sound support. */

extern struct IOAudio		*SoundRequestLeft,
				*SoundRequestRight,
				*SoundControlRequest;
extern struct MsgPort		*SoundPort;

	/* Sound file search path. */

extern char			*SoundName,
				*SoundPath;

	/* Sound file data. */

extern int			 SoundNumber;
extern APTR			 SoundData;
extern LONG			 SoundLength;
