/* amiga_console.c
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
 * $Header: RCS/amiga_console.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* ConCharWidth(const UBYTE Char):
	 *
	 *	Calculate the pixel width of a glyph.
	 */

UWORD
ConCharWidth(const UBYTE Char)
{
	return((UWORD)TextLength(RPort,(STRPTR)&Char,1));
}

	/* ConCursorOff():
	 *
	 *	Turn the terminal cursor on.
	 */

VOID
ConCursorOff()
{
		/* Is it still enabled? */

	if(CursorEnabled)
	{
		LONG	Left	= LastCursorX + Window -> BorderLeft,
			Top	= LastCursorY + Window -> BorderTop;

			/* Turn on xor operation. */

		SetDrMd(RPort,JAM1 | COMPLEMENT);

			/* Complement all planes. */

		SetAPen(RPort,(1 << Depth) - 1);

			/* Is the window inactive? */

		if(!WindowIsActive)
		{
				/* Set the cross-hatch pattern. */

			SetAfPt(RPort,&ChipData[CHIPDATA_PATTERN],1);

				/* Render the cursor data. */

			RectFill(RPort,Left,Top,Left + NewCursorWidth - 1,Top + TextFontHeight - 1);

				/* Reset the pattern. */

			SetAfPt(RPort,NULL,0);
		}
		else
			RectFill(RPort,Left,Top,Left + NewCursorWidth - 1,Top + TextFontHeight - 1);

			/* Reset the drawing mode. */

		SetDrMd(RPort,JAM2);

			/* Reset the drawing pen. */

		SetAPen(RPort,ConTextPen);

			/* It's turned off now. */

		CursorEnabled = FALSE;
	}
}

	/* ConCursorOn(const int New):
	 *
	 *	Turn the terminal cursor off.
	 */

VOID
ConCursorOn(const int New)
{
		/* Is it still disabled? */

	if(!CursorEnabled)
	{
		LONG	Left	= CursorX + Window -> BorderLeft,
			Top	= CursorY + Window -> BorderTop;

			/* Remember new cursor width. */

		switch(New)
		{
			case CURSOR_NOCHANGE:	break;

			case CURSOR_AVERAGE:	NewCursorWidth = DefaultCursorWidth;
						break;

			default:		NewCursorWidth = New;
						break;
		}

			/* Turn on xor operation. */

		SetDrMd(RPort,JAM1 | COMPLEMENT);

			/* Complement all planes. */

		SetAPen(RPort,(1 << Depth) - 1);

			/* Is the window inactive? */

		if(!WindowIsActive)
		{
				/* Set the cross-hatch pattern. */

			SetAfPt(RPort,&ChipData[CHIPDATA_PATTERN],1);

				/* Render the cursor data. */

			RectFill(RPort,Left,Top,Left + NewCursorWidth - 1,Top + TextFontHeight - 1);

				/* Reset the pattern. */

			SetAfPt(RPort,NULL,0);
		}
		else
			RectFill(RPort,Left,Top,Left + NewCursorWidth - 1,Top + TextFontHeight - 1);

			/* Reset the drawing mode. */

		SetDrMd(RPort,JAM2);

			/* Reset the drawing pen. */

		SetAPen(RPort,ConTextPen);

			/* Remember cursor width. */

		OldCursorWidth = NewCursorWidth;

			/* It's turn on now. */

		CursorEnabled = TRUE;

			/* Remember cursor position. */

		LastCursorX = CursorX;
		LastCursorY = CursorY;
	}
}

	/* ConMove(const int Delta,const int New):
	 *
	 *	Move the cursor.
	 */

VOID
ConMove(const int Delta,const int New)
{
		/* If the cursor is still enabled, turn it
		 * off before repositioning it.
		 */

	if(CursorEnabled)
	{
			/* Turn the cursor off. */

		ConCursorOff();

			/* Move it. */

		CursorX += Delta;

			/* Turn the cursor back on. */

		ConCursorOn(New);
	}
	else
	{
		CursorX += Delta;

		switch(New)
		{
			case CURSOR_NOCHANGE:	NewCursorWidth = OldCursorWidth;
						break;

			case CURSOR_AVERAGE:	NewCursorWidth = OldCursorWidth = DefaultCursorWidth;
						break;

			default:		NewCursorWidth = OldCursorWidth = New;
						break;
		}
	}
}

	/* ConSet(const int X,const int Y,const int New):
	 *
	 *	Place the cursor at a specific position.
	 */

VOID
ConSet(const int X,const int Y,const int New)
{
		/* If the cursor is still enabled, turn it
		 * off before repositioning it.
		 */

	if(CursorEnabled)
	{
			/* Turn the cursor off. */

		ConCursorOff();

			/* Move drawing pen. */

		Move(RPort,X + Window -> BorderLeft,Y + ThisFont -> tf_Baseline + Window -> BorderTop);

			/* Position the cursor. */

		CursorX = X;
		CursorY = Y;

			/* Turn the cursor back on. */

		ConCursorOn(New);
	}
	else
	{
			/* Remember new cursor width. */

		switch(New)
		{
			case CURSOR_NOCHANGE:	NewCursorWidth = OldCursorWidth;
						break;

			case CURSOR_AVERAGE:	NewCursorWidth = OldCursorWidth = DefaultCursorWidth;
						break;

			default:		NewCursorWidth = OldCursorWidth = New;
						break;
		}

			/* Move drawing pen. */

		Move(RPort,X + Window -> BorderLeft,Y + ThisFont -> tf_Baseline + Window -> BorderTop);

			/* Position the cursor. */

		CursorX = X;
		CursorY = Y;
	}
}

	/* ConClearEOL():
	 *
	 *	Clear to end of current line.
	 */

VOID
ConClearEOL()
{
		/* Is there anything to clear? */

	if(CursorX < WindowWidth)
	{
			/* Turn the cursor off before the line is cleared. */

		if(CursorEnabled)
		{
				/* Turn the cursor off. */

			ConCursorOff();

				/* Clear the remaining line. */

			SetAPen(RPort,ConBackPen);
			RectFill(RPort,CursorX + Window -> BorderLeft,CursorY + Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),CursorY + Window -> BorderTop + TextFontHeight - 1);
			SetAPen(RPort,ConTextPen);

				/* Turn the cursor back on. */

			ConCursorOn(CURSOR_NOCHANGE);
		}
		else
		{
			SetAPen(RPort,ConBackPen);
			RectFill(RPort,CursorX + Window -> BorderLeft,CursorY + Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),CursorY + Window -> BorderTop + TextFontHeight - 1);
			SetAPen(RPort,ConTextPen);
		}
	}
}

	/* ConCharBackspace(const int Delta,const int New):
	 *
	 *	Move the cursor one glyph back.
	 */

VOID
ConCharBackspace(const int Delta,const int New)
{
	RedrawInputLine = TRUE;

	CursorX -= Delta;

	switch(New)
	{
		case CURSOR_NOCHANGE:	NewCursorWidth = OldCursorWidth;
					break;

		case CURSOR_AVERAGE:	NewCursorWidth = OldCursorWidth = DefaultCursorWidth;
					break;

		default:		NewCursorWidth = OldCursorWidth = New;
					break;
	}
}

	/* ConCharDelete(const int New):
	 *
	 *	Delete the character under the cursor.
	 */

VOID
ConCharDelete(const int New)
{
	RedrawInputLine = TRUE;

	switch(New)
	{
		case CURSOR_NOCHANGE:	NewCursorWidth = OldCursorWidth;
					break;

		case CURSOR_AVERAGE:	NewCursorWidth = OldCursorWidth = DefaultCursorWidth;
					break;

		default:		NewCursorWidth = OldCursorWidth = New;
					break;
	}
}

	/* ConCharInsert(const UBYTE Char):
	 *
	 *	Insert a character at the current cursor position.
	 */

VOID
ConCharInsert(const UBYTE Char)
{
	RedrawInputLine = TRUE;

	CursorX += ConCharWidth(Char);
}

	/* ConScrollUp():
	 *
	 *	Scroll the terminal contents one line up.
	 */

VOID
ConScrollUp()
{
		/* Inside the status line the cursor is always
		 * disabled.
		 */

	if(ConOutputWindow)
		ScrollRaster(RPort,0,TextFontHeight,Window -> BorderLeft,Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),ConNumStatusLines * TextFontHeight);
	else
	{
			/* Is the cursor enabled? */

		if(CursorEnabled)
		{
				/* Turn the cursor off. */

			ConCursorOff();

				/* Scroll the terminal contents up. */

			if(gflags . pr_status || ConNumStatusLines > 1)
				ScrollRaster(RPort,0,TextFontHeight,Window -> BorderLeft,ConNumStatusLines * TextFontHeight + Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));
			else
				ScrollRaster(RPort,0,TextFontHeight,Window -> BorderLeft,Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));

				/* Reposition the cursor. */

			CursorX = 0;
			CursorY = TextFontHeight * (ConNumLines - 1);

				/* Turn it on again. */

			ConCursorOn(CURSOR_NOCHANGE);
		}
		else
		{
				/* Scroll the terminal contents up. */

			if(gflags . pr_status || ConNumStatusLines > 1)
				ScrollRaster(RPort,0,TextFontHeight,Window -> BorderLeft,ConNumStatusLines * TextFontHeight + Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));
			else
				ScrollRaster(RPort,0,TextFontHeight,Window -> BorderLeft,Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));

				/* Reposition the cursor. */

			CursorX = 0;
			CursorY = TextFontHeight * (ConNumLines - 1);
		}
	}
}

	/* ConWrite(const char *Line,LONG Len,LONG Indent):
	 *
	 *	Output a text on the terminal.
	 */

VOID
ConWrite(const char *Line,LONG Len,LONG Indent)
{
		/* Just like console.device, determine the
		 * text length if -1 is passed in as the
		 * length.
		 */

	if(Len == -1)
		Len = strlen(Line);

		/* Is there anything to print? */

	if(Len)
	{
			/* Is the cursor still enabled? */

		if(CursorEnabled)
		{
				/* Turn off the cursor. */

			ConCursorOff();

				/* Print the text. */

			Move(RPort,Indent + CursorX + Window -> BorderLeft,CursorY + ThisFont -> tf_Baseline + Window -> BorderTop);
			Text(RPort,(STRPTR)Line,Len);

				/* Move up. */

			CursorX += TextLength(RPort,(STRPTR)Line,Len);

				/* Turn the cursor back on. */

			ConCursorOn(CURSOR_NOCHANGE);
		}
		else
		{
				/* Print the text. */

			Move(RPort,Indent + CursorX + Window -> BorderLeft,CursorY + ThisFont -> tf_Baseline + Window -> BorderTop);
			Text(RPort,(STRPTR)Line,Len);

				/* Move up. */

			CursorX += TextLength(RPort,(STRPTR)Line,Len);
		}
	}
}

	/* ConRedraw(const int X,const int Y,const STRPTR String,const int Len):
	 *
	 *	Redraw the input string.
	 */

VOID
ConRedraw(const int X,const int Y,const STRPTR String,const int Len)
{
		/* Determine width in pixels. */

	int Width = TextLength(RPort,(STRPTR)String,Len);

		/* Turn the cursor off. */

	ConCursorOff();

		/* Redraw the input string. */

	Move(RPort,X + Window -> BorderLeft,Y + ThisFont -> tf_Baseline + Window -> BorderTop);
	Text(RPort,(STRPTR)String,Len);

		/* Clear to end of line. */

	if(Width < WindowWidth)
	{
		SetAPen(RPort,ConBackPen);
		RectFill(RPort,X + Width + Window -> BorderLeft,Y + Window -> BorderTop,Window -> Width - (Window -> BorderRight + 1),Y + Window -> BorderTop + TextFontHeight - 1);
		SetAPen(RPort,ConTextPen);
	}

		/* Turn the cursor back on. */

	ConCursorOn(CURSOR_NOCHANGE);
}

	/* ConSetColour(const int Colour):
	 *
	 *	Set the text rendering colours. If running on a monochrome
	 *	display, the colours will be mapped to text style attributes.
	 */

VOID
ConSetColour(const int Colour)
{
		/* Are we running on a monochrome display? */

	Bool IsMono = (Depth == 1 || !NewOS);

		/* The following code decides which text rendering colour
		 * to set.
		 */

	switch(Colour)
	{
			/* Text input colour. */

		case COLOUR_INPUT:	if(IsMono)
					{
						SetAPen(RPort,ConTextPen = 1);
						SetBPen(RPort,ConBackPen = 0);

						SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));
					}
					else
					{
						SetAPen(RPort,ConTextPen = 2);
						SetBPen(RPort,ConBackPen = 0);
					}

					break;

			/* Status line colour. */

		case COLOUR_STATUS:	if(IsMono)
					{
						SetAPen(RPort,ConTextPen = 0);
						SetBPen(RPort,ConBackPen = 1);

						SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));
					}
					else
					{
						SetAPen(RPort,ConTextPen = 2);
						SetBPen(RPort,ConBackPen = 3);
					}

					break;

			/* Error message colour. */

		case COLOUR_ERROR:	if(IsMono)
					{
						SetAPen(RPort,ConTextPen = 1);
						SetBPen(RPort,ConBackPen = 0);

						SetSoftStyle(RPort,FSF_UNDERLINED,AskSoftStyle(RPort));
					}
					else
					{
						SetAPen(RPort,ConTextPen = 3);
						SetBPen(RPort,ConBackPen = 0);
					}

					break;

			/* Special emphasis colour. */

		case COLOUR_SPECIAL:	if(IsMono)
					{
						SetAPen(RPort,ConTextPen = 1);
						SetBPen(RPort,ConBackPen = 0);

						SetSoftStyle(RPort,FSF_BOLD,AskSoftStyle(RPort));
					}
					else
					{
						SetAPen(RPort,ConTextPen = 2);
						SetBPen(RPort,ConBackPen = 0);
					}

					break;

			/* Standard text colour. */

		default:		SetAPen(RPort,ConTextPen = 1);
					SetBPen(RPort,ConBackPen = 0);

					if(IsMono)
						SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));

					break;
	}
}

	/* ConSetKey(const int Key,const STRPTR String,const int Len):
	 *
	 *	Set a specific function key.
	 */

VOID
ConSetKey(const int Key,const STRPTR String,const int Len)
{
		/* Is the new string longer than the old one? */

	if(FunctionKeys[Key] . sb_Len < Len)
	{
			/* Free previous key assignment. */

		free(FunctionKeys[Key] . sb_Buffer);

			/* Create new string buffer. */

		if(FunctionKeys[Key] . sb_Buffer = (char *)malloc(Len + 1))
		{
				/* Copy the key string. */

			memcpy(FunctionKeys[Key] . sb_Buffer,String,Len);

				/* Provide null-termination. */

			FunctionKeys[Key] . sb_Buffer[Len] = 0;

				/* Set string length. */

			FunctionKeys[Key] . sb_Len = Len;
		}
		else
			FunctionKeys[Key] . sb_Len = 0;
	}
	else
	{
			/* Install new string. */

		if(Len)
		{
				/* Copy the key string. */

			memcpy(FunctionKeys[Key] . sb_Buffer,String,Len);

				/* Provide null-termination. */

			FunctionKeys[Key] . sb_Buffer[Len] = 0;
		}
		else
		{
				/* Zero length, free previous buffer
				 * assignment.
				 */

			if(FunctionKeys[Key] . sb_Buffer)
			{
					/* Free the buffer. */

				free(FunctionKeys[Key] . sb_Buffer);

					/* Clear address pointer. */

				FunctionKeys[Key] . sb_Buffer = NULL;
			}
		}

			/* Install new length. */

		FunctionKeys[Key] . sb_Len = Len;
	}
}

	/* ConCloseLibs():
	 *
	 *	Close required system libraries.
	 */

VOID
ConCloseLibs()
{
	if(IntuitionBase)
	{
		CloseLibrary((struct Library *)IntuitionBase);

		IntuitionBase = NULL;
	}

	if(GfxBase)
	{
		CloseLibrary((struct Library *)GfxBase);

		GfxBase = NULL;
	}

	if(DiskfontBase)
	{
		CloseLibrary(DiskfontBase);

		DiskfontBase = NULL;
	}

	if(AslBase)
	{
		CloseLibrary(AslBase);

		AslBase = NULL;
	}

	if(IconBase)
	{
		CloseLibrary(IconBase);

		IconBase = NULL;
	}

	if(IFFParseBase)
	{
		CloseLibrary(IFFParseBase);

		IFFParseBase = NULL;
	}

	if(GadToolsBase)
	{
		CloseLibrary(GadToolsBase);

		GadToolsBase = NULL;
	}

	if(UtilityBase)
	{
		CloseLibrary(UtilityBase);

		UtilityBase = NULL;
	}

	if(WorkbenchBase)
	{
		CloseLibrary(WorkbenchBase);

		WorkbenchBase = NULL;
	}
}

	/* ConOpenLibs():
	 *
	 *	Open required system libraries.
	 */

Bool
ConOpenLibs()
{
	if(!LibsOpened)
	{
			/* Remember default window pointer. */

		WindowPtr = ThisProcess -> pr_WindowPtr;

			/* Make sure that the cleanup routine gets called on exit. */

		if(atexit(ConCloseLibs))
			return(FALSE);

			/* Open intuition.library. */

		if(!(IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",LIBRARY_MINIMUM)))
			return(FALSE);

			/* Open graphics.library. */

		if(!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",LIBRARY_MINIMUM)))
			return(FALSE);

		DiskfontBase = OpenLibrary("diskfont.library",LIBRARY_MINIMUM);

			/* Which operating system revision is this
			 * machine currently running?
			 */

		if(NewOS = (IntuitionBase -> LibNode . lib_Version >= LIB_VERSION))
		{
				/* Open asl.library (file requester routines). */

			if(!(AslBase = OpenLibrary("asl.library",LIB_VERSION)))
				return(FALSE);

				/* Open icon.library (icon file routines). */

			if(!(IconBase = OpenLibrary("icon.library",LIB_VERSION)))
				return(FALSE);

				/* Open utility.library (string comparison routines). */

			if(!(UtilityBase = OpenLibrary("utility.library",LIB_VERSION)))
				return(FALSE);

				/* Open gadtools.library (menu and gadget creation routines). */

			if(!(GadToolsBase = OpenLibrary("gadtools.library",LIB_VERSION)))
				return(FALSE);

				/* Open iffparse.library (iff file parsing routines). */

			if(!(IFFParseBase = OpenLibrary("iffparse.library",LIB_VERSION)))
				return(FALSE);

				/* Open workbench.library (appwindow routines). */

			WorkbenchBase = OpenLibrary("workbench.library",LIB_VERSION);
		}
		else
			IconBase = OpenLibrary("icon.library",LIBRARY_MINIMUM);
	}

	return(LibsOpened = TRUE);
}

	/* ConCleanup():
	 *
	 *	Free all resources.
	 */

VOID
ConCleanup()
{
		/* Free the sound data. */

	SoundExit();

		/* Close the clipboard. */

	ClipClose();

		/* Free the timer request. */

	if(TimeRequest)
	{
			/* Did we succeed in opening the device? */

		if(TimeRequest -> tr_node . io_Device)
		{
				/* Is the time request still pending? If so, abort it. */

			if(!CheckIO((struct IORequest *)TimeRequest))
				AbortIO((struct IORequest *)TimeRequest);

				/* Remove the request. */

			WaitIO((struct IORequest *)TimeRequest);

				/* Close the device. */

			CloseDevice((struct IORequest *)TimeRequest);
		}

			/* Free the request. */

		DeleteExtIO((struct IORequest *)TimeRequest);
	}

		/* Free the timer port. */

	if(TimePort)
		DeletePort(TimePort);

		/* Free the console request. */

	if(ConRequest)
	{
			/* Did we open the device? If so, close it. */

		if(ConRequest -> io_Device)
			CloseDevice((struct IORequest *)ConRequest);

			/* Free the memory. */

		FreeMem(ConRequest,sizeof(struct IOStdReq));
	}

		/* Free the input conversion buffer. */

	if(InputEventBuffer)
		FreeMem(InputEventBuffer,INPUT_LENGTH);

		/* Free the fake inputevent. */

	if(InputEvent)
		FreeMem(InputEvent,sizeof(struct InputEvent));

		/* Remove appwindow link. */

	if(WorkbenchWindow)
		RemoveAppWindow(WorkbenchWindow);

		/* Remove appwindow msgport and any pending messages. */

	if(WorkbenchPort)
	{
		struct Message *Message;

		while(Message = GetMsg(WorkbenchPort))
			ReplyMsg(Message);

		DeletePort(WorkbenchPort);
	}

		/* Close the window. */

	if(Window)
	{
			/* Cosmeticism. */

		if(Screen)
			ScreenToBack(Screen);

			/* Remove the pull-down menus. */

		if(Menu)
			ClearMenuStrip(Window);

			/* Really close the window. */

		CloseWindow(Window);
	}

		/* Free the menu strip. */

	if(Menu)
		FreeMenus(Menu);

		/* Free the chip memory buffer. */

	if(ChipData)
		FreeMem(ChipData,sizeof(UWORD) * (sizeof(StopwatchData) + 2));

		/* Free the visual information buffer. */

	if(VisualInfo)
		FreeVisualInfo(VisualInfo);

		/* Close the custom screen if any. */

	if(Screen)
		CloseScreen(Screen);

		/* Close the disk fonts if any. */

	if(TextFont)
		CloseFont(TextFont);

	if(ListFont)
		CloseFont(ListFont);

		/* Free the file requester. */

	if(GameFileRequest)
		FreeAslRequest(GameFileRequest);

		/* If not already done, release the lock on the default
		 * public screen.
		 */

	if(DefaultScreen)
		UnlockPubScreen(NULL,DefaultScreen);

		/* Reset the DOS requester location. */

	if(ThisProcess)
		ThisProcess -> pr_WindowPtr = WindowPtr;
}

	/* ConSetup():
	 *
	 *	Set up console interface.
	 */

Bool
ConSetup()
{
	struct IBox	ZoomBox;
	UWORD		Pen	= (UWORD)~0,
			Width;
	WORD		MinHeight,
			MinWidth;
	UBYTE		Char;
	ULONG		Total	= 0,
			Count	= 0;
	Bool		UseFont	= FALSE;

		/* Open system libraries. */

	if(!ConOpenLibs())
		return(FALSE);

		/* Create the console info. */

	if(!(ConRequest = (struct IOStdReq *)AllocMem(sizeof(struct IOStdReq),MEMF_ANY|MEMF_CLEAR)))
		return(FALSE);

		/* Open console.device and extract the device base pointer. */

	if(OpenDevice("console.device",CONU_LIBRARY,(struct IORequest *)ConRequest,NULL))
		return(FALSE);

	ConsoleDevice = ConRequest -> io_Device;

		/* Create the input event auxilary buffers. */

	if(!(InputEventBuffer = (STRPTR)AllocMem(INPUT_LENGTH,MEMF_ANY)))
		return(FALSE);

	if(!(InputEvent = (struct InputEvent *)AllocMem(sizeof(struct InputEvent),MEMF_ANY|MEMF_CLEAR)))
		return(FALSE);

		/* Create timer reply port. */

	if(!(TimePort = CreatePort(NULL,0)))
		return(FALSE);

		/* Create timer request. */

	if(!(TimeRequest = (struct timerequest *)CreateExtIO(TimePort,sizeof(struct timerequest))))
		return(FALSE);

		/* Open timer.device */

	if(OpenDevice(TIMERNAME,UNIT_VBLANK,(struct IORequest *)TimeRequest,0))
		return(FALSE);

		/* Allocate and set up chip memory data area. */

	if(!(ChipData = (UWORD *)AllocMem(sizeof(UWORD) * (sizeof(StopwatchData) + 2),MEMF_CHIP)))
		return(FALSE);

		/* Fill in the cross-hatch pattern. */

	ChipData[CHIPDATA_PATTERN  ] = 0x5555;
	ChipData[CHIPDATA_PATTERN+1] = 0xAAAA;

		/* Fill in the mouse pointer data. */

	CopyMem((BYTE *)StopwatchData,(BYTE *)&ChipData[CHIPDATA_POINTER],sizeof(StopwatchData));

		/* Are we to use special fonts? */

	if(ListFontName[0] && TextFontName[0] && FontSize && DiskfontBase)
	{
			/* Tack on the ".font" suffix. */

		strcat(ListFontName,".font");
		strcat(TextFontName,".font");

			/* Set up the fixed width (`list') font. */

		ListFontAttr . ta_Name	= ListFontName;
		ListFontAttr . ta_YSize	= FontSize;
		ListFontAttr . ta_Style	= FS_NORMAL;
		ListFontAttr . ta_Flags	= FPF_DISKFONT | FPF_DESIGNED;

			/* Set up the proportional-spaced (`text') font. */

		TextFontAttr . ta_Name	= TextFontName;
		TextFontAttr . ta_YSize	= FontSize;
		TextFontAttr . ta_Style	= FS_NORMAL;
		TextFontAttr . ta_Flags	= FPF_DISKFONT | FPF_DESIGNED | FPF_PROPORTIONAL;

			/* Try to open the fonts. */

		if((ListFont = OpenDiskFont(&ListFontAttr)) && (TextFont = OpenDiskFont(&TextFontAttr)))
			UseFont = TRUE;
	}

		/* Are we running under control of Kickstart 2.04 or higher? */

	if(NewOS)
	{
			/* Obtain a lock on the default public screen,
			 * we will try to clone it later.
			 */

		if(!(DefaultScreen = LockPubScreen(NULL)))
			return(FALSE);

			/* Are we to open a custom screen? */

		if(UseCustomScreen)
		{
			ULONG	DefaultMode,
				Mode;

				/* Obtain the default screen display mode. */

			DefaultMode = GetVPModeID(&DefaultScreen -> ViewPort);

				/* Build new display mode ID by looking
				 * at the default screen display mode
				 * properties.
				 */

			if((DefaultMode & LACE) || ((DefaultMode & MONITOR_ID_MASK) == A2024_MONITOR_ID))
				Mode = HIRESLACE_KEY;
			else
				Mode = HIRES_KEY;

				/* Determine new screen depth, don't use more
				 * bit planes than necessary, though.
				 */

			if((Depth = DefaultScreen -> RastPort . BitMap -> Depth) > 2)
				Depth = 2;

				/* Open the custom screen. */

			if(!(Screen = OpenScreenTags(NULL,
				SA_Depth,				Depth,
				SA_DisplayID,				Mode,
				SA_Overscan,				OSCAN_TEXT,
				SA_Pens,				&Pen,
				UseFont ? TAG_IGNORE : SA_SysFont,	1,
				UseFont ? SA_Font : TAG_IGNORE,		&TextFontAttr,
				SA_Title,				SCREEN_TITLE,
				SA_AutoScroll,				TRUE,
				SA_Behind,				TRUE,
			TAG_DONE)))
				return(FALSE);

				/* Open the window on the custom screen. */

			if(!(Window = OpenWindowTags(NULL,
				WA_Left,		0,
				WA_Top,			Screen -> BarHeight + 2,
				WA_Width,		Screen -> Width,
				WA_Height,		Screen -> Height - (Screen -> BarHeight + 2),
				WA_Borderless,		TRUE,
				WA_Backdrop,		TRUE,
				WA_RMBTrap,		TRUE,
				WA_NoCareRefresh,	TRUE,
				WA_NewLookMenus,	TRUE,
				WA_CustomScreen,	Screen,
				WA_IDCMP,		IDCMP_MENUPICK | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_ACTIVEWINDOW | IDCMP_INACTIVEWINDOW,
			TAG_DONE)))
				return(FALSE);
		}
		else
		{
			UWORD Width,Height;

			if(UseFont)
			{
				Width	= DefaultScreen -> WBorLeft + WINDOW_COLUMNS * ListFont -> tf_XSize + DefaultScreen -> WBorRight;
				Height	= DefaultScreen -> WBorTop + DefaultScreen -> Font -> ta_YSize + ListFont -> tf_YSize * WINDOW_LINES + DefaultScreen -> WBorBottom;
			}
			else
			{
				Width	= DefaultScreen -> WBorLeft + WINDOW_COLUMNS * DefaultScreen -> RastPort . Font -> tf_XSize + DefaultScreen -> WBorRight;
				Height	= DefaultScreen -> WBorTop + DefaultScreen -> Font -> ta_YSize * (WINDOW_LINES + 1) + DefaultScreen -> WBorBottom;
			}

				/* Set up the alternative window coordinates and size. */

			ZoomBox . Left		= 0;
			ZoomBox . Top		= DefaultScreen -> WBorTop + DefaultScreen -> Font -> ta_YSize + 1;
			ZoomBox . Width		= DefaultScreen -> Width;
			ZoomBox . Height	= DefaultScreen -> Height - ZoomBox . Top;

				/* Set up the window title. */

			strcpy(WindowTitle,FilePart((STRPTR)gflags . filenm));

				/* Open the window on the Workbench screen. */

			if(!(Window = OpenWindowTags(NULL,
				WA_Title,		WindowTitle,
				WA_Width,		Width,
				WA_Height,		Height,
				WA_MaxWidth,		Width,
				WA_MaxHeight,		Height,
				WA_MinWidth,		Width,
				WA_MinHeight,		Height,
				WA_Zoom,		&ZoomBox,
				WA_RMBTrap,		TRUE,
				WA_DragBar,		TRUE,
				WA_DepthGadget,		TRUE,
				WA_CloseGadget,		TRUE,
				WA_Activate,		TRUE,
				WA_SizeGadget,		TRUE,
				WA_SizeBBottom,		TRUE,
				WA_NoCareRefresh,	TRUE,
				WA_NewLookMenus,	TRUE,
				WA_CustomScreen,	DefaultScreen,
				WA_IDCMP,		IDCMP_CLOSEWINDOW | IDCMP_NEWSIZE | IDCMP_MENUPICK | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_ACTIVEWINDOW | IDCMP_INACTIVEWINDOW,
			TAG_DONE)))
				return(FALSE);
			else
			{
				struct DrawInfo *DrawInfo;

				if(DrawInfo = GetScreenDrawInfo(Window -> WScreen))
				{
					Depth = DrawInfo -> dri_Depth;

					FreeScreenDrawInfo(Window -> WScreen,DrawInfo);
				}
				else
					Depth = 1;

				SetWindowTitles(Window,(STRPTR)~0,SCREEN_TITLE);
			}
		}

			/* Release the lock on the default public screen. */

		UnlockPubScreen(NULL,DefaultScreen);

			/* Clear the address pointer. */

		DefaultScreen = NULL;

			/* Allocate the file requester. */

		if(!(GameFileRequest = AllocAslRequestTags(ASL_FileRequest,
			ASL_LeftEdge,	Window -> LeftEdge + Window -> Width / 4,
			ASL_TopEdge,	Window -> TopEdge + Window -> Height / 4,
			ASL_Width,	Window -> Width / 2,
			ASL_Height,	Window -> Height / 2,
		TAG_DONE)))
			return(FALSE);

			/* Obtain visual info on our custom screen. */

		if(!(VisualInfo = GetVisualInfo(Window -> WScreen,TAG_DONE)))
			return(FALSE);

			/* Create the pull-down menus. */

		if(!(Menu = CreateMenus(ConMenuConfig,TAG_DONE)))
			return(FALSE);

			/* Properly layout the menus. */

		if(!(LayoutMenus(Menu,VisualInfo,
			GTMN_NewLookMenus,	TRUE,
			GTMN_TextAttr,		Window -> WScreen -> Font,
		TAG_DONE)))
			return(FALSE);

			/* Attach the menus to the window. */

		SetMenuStrip(Window,Menu);

			/* Enable the menus. */

		Window -> Flags &= ~WFLG_RMBTRAP;
	}
	else
	{
			/* The buffer to hold information on the Workbench screen. */

		struct Screen		WorkbenchScreen;

			/* Screen and window allocation data. */

		struct NewScreen	NewScreen;
		struct NewWindow	NewWindow;

			/* Clear the new screen structure. */

		memset(&NewScreen,0,sizeof(struct NewScreen));

			/* Fill in the common data. */

		NewScreen . Depth		= 1;
		NewScreen . DetailPen		= 0;
		NewScreen . BlockPen		= 1;
		NewScreen . DefaultTitle	= SCREEN_TITLE;
		NewScreen . Type		= CUSTOMSCREEN | SCREENBEHIND;

		if(UseFont)
			NewScreen . Font = &TextFontAttr;

			/* Get the Workbench screen size and display mode. */

		if(GetScreenData((BYTE *)&WorkbenchScreen,sizeof(struct Screen),WBENCHSCREEN,NULL))
		{
			NewScreen . ViewModes	= WorkbenchScreen . ViewPort . Modes;
			NewScreen . Height	= WorkbenchScreen . Height;
			NewScreen . Width	= WorkbenchScreen . Width;
		}
		else
			return(FALSE);

			/* Clear the new window structure. */

		memset(&NewWindow,0,sizeof(struct NewWindow));

			/* Fill in the common data. */

		NewWindow . LeftEdge	= 0;
		NewWindow . Width	= NewScreen . Width;
		NewWindow . DetailPen	= (UBYTE)-1;
		NewWindow . BlockPen	= (UBYTE)-1;
		NewWindow . IDCMPFlags	= MOUSEBUTTONS | RAWKEY | ACTIVEWINDOW | INACTIVEWINDOW | NEWSIZE | CLOSEWINDOW;
		NewWindow . MinWidth	= NewWindow . Width;
		NewWindow . MinHeight	= NewWindow . Height;
		NewWindow . MaxWidth	= NewWindow . Width;
		NewWindow . MaxHeight	= NewWindow . Height;

			/* Are we to open a custom screen? */

		if(UseCustomScreen)
		{
				/* Default colour palette. */

			STATIC UWORD Palette[2] = { 0x000,0xEEE };

				/* Open the screen. */

			if(!(Screen = OpenScreen(&NewScreen)))
				return(FALSE);

				/* Set the screen colours. */

			LoadRGB4(&Screen -> ViewPort,Palette,2);

				/* Set up the remaining window flags. */

			NewWindow . TopEdge	= Screen -> BarHeight + 1;
			NewWindow . Height	= Screen -> Height - NewWindow . TopEdge;
			NewWindow . Flags	= ACTIVATE | RMBTRAP | SMART_REFRESH | NOCAREREFRESH | BORDERLESS | BACKDROP;
			NewWindow . Screen	= Screen;
			NewWindow . Type	= CUSTOMSCREEN;
		}
		else
		{
				/* Set up the remaining window flags. */

			NewWindow . TopEdge	= WorkbenchScreen . BarHeight + 1;
			NewWindow . Height	= NewScreen . Height - NewWindow . TopEdge;
			NewWindow . Flags	= ACTIVATE | RMBTRAP | SMART_REFRESH | NOCAREREFRESH | WINDOWSIZING | WINDOWDRAG | WINDOWDEPTH | WINDOWCLOSE;
			NewWindow . Title	= SCREEN_TITLE;
			NewWindow . Type	= WBENCHSCREEN;
		}

			/* Open the window. */

		if(!(Window = OpenWindow(&NewWindow)))
			return(FALSE);
		else
			Depth = Window -> RPort -> BitMap -> Depth;
	}

		/* Let's assume that our window is active now. */

	WindowIsActive = TRUE;

		/* Did we open a custom screen? */

	if(!Screen && WorkbenchBase)
	{
			/* Create Workbench appwindow msgport. */

		if(!(WorkbenchPort = CreatePort(NULL,0)))
			return(FALSE);

			/* Create Workbench appwindow link. */

		if(!(WorkbenchWindow = AddAppWindow(0,0,Window,WorkbenchPort,NULL)))
			return(FALSE);
	}

		/* Determine inner window width. */

	WindowWidth = Window -> Width - (Window -> BorderLeft + Window -> BorderRight);

		/* Obtain rastport pointer. */

	RPort = Window -> RPort;

		/* Set text rendering mode. */

	SetDrMd(RPort,JAM2);

		/* Set text colour. */

	ConSetColour(COLOUR_TEXT);

		/* Get both the screen and system default font. The
		 * screen font can be a proportional-spaced font
		 * while the window rastport font is guaranteed
		 * to be a fixed-width font.
		 */

	if(UseFont)
	{
		PropFont	= TextFont;
		FixedFont	= ListFont;
	}
	else
	{
		PropFont	= Window -> WScreen -> RastPort . Font;
		FixedFont	= Window -> IFont;
	}

		/* Obtain the system default font dimensions. */

	TextFontHeight	= FixedFont -> tf_YSize;
	TextFontWidth	= 0;

		/* Both the proportional-spaced and the fixed-width
		 * font have to match in height. If this is not the
		 * case, we will use only the fixed-width font.
		 */

	if(PropFont -> tf_YSize != FixedFont -> tf_YSize)
		PropFont = FixedFont;

		/* Set the fixed-width font. */

	SetFont(RPort,ThisFont = FixedFont);

		/* Look for the widest glyph. */

	for(Char = ' ' ; Char <= '~' ; Char++)
	{
		if((Width = ConCharWidth(Char)) > TextFontWidth)
			TextFontWidth = Width;

			/* Update width. */

		Total += Width;

		Count++;
	}

		/* Set the proportional-spaced font. */

	SetFont(RPort,ThisFont = PropFont);

		/* Look for the widest glyph. */

	for(Char = ' ' ; Char <= '~' ; Char++)
	{
		if((Width = ConCharWidth(Char)) > TextFontWidth)
			TextFontWidth = Width;

			/* Update width. */

		Total += Width;

		Count++;
	}

		/* Determine the average glyph width. */

	DefaultCursorWidth = Total / Count;

		/* Determine space character width. */

	SpaceWidth = ConCharWidth(' ');

		/* Determine window minimum dimensions. */

	MinWidth	= Window -> BorderLeft + MIN_WINDOW_COLUMNS * TextFontWidth + Window -> BorderRight;
	MinHeight	= Window -> BorderTop + MIN_WINDOW_LINES * TextFontHeight + Window -> BorderBottom;

		/* Set the minimum dimensions if possible. */

	if(MinWidth < Window -> Width)
	{
		if(MinHeight < Window -> Height)
			WindowLimits(Window,MinWidth,MinHeight,Window -> WScreen -> Width,Window -> WScreen -> Height);
		else
			WindowLimits(Window,MinWidth,0,Window -> WScreen -> Width,Window -> WScreen -> Height);
	}
	else
		WindowLimits(Window,0,0,Window -> WScreen -> Width,Window -> WScreen -> Height);

		/* Remember initial window width. */

	OldWindowWidth	= Window -> Width;
	OldWindowHeight	= Window -> Height;

		/* Redirect DOS requesters. */

	ThisProcess -> pr_WindowPtr = (APTR)Window;

		/* Start the timer. */

	TimeRequest -> tr_node . io_Command	= TR_ADDREQUEST;
	TimeRequest -> tr_time . tv_secs	= 0;
	TimeRequest -> tr_time . tv_micro	= SECOND / 2;

	SendIO((struct IORequest *)TimeRequest);

		/* Return success. */

	return(TRUE);
}

	/* ConGetChar(Bool SingleKey):
	 *
	 *	Read a single character from the console.
	 */

UBYTE
ConGetChar(const Bool SingleKey)
{
	struct IntuiMessage	*IntuiMessage;
	ULONG			 Qualifier,
				 Class,
				 Code,
				 Signals;
	LONG			 Len;
	Bool			 GotName = FALSE;

		/* Provide `fake' input in case we are
		 * returning the result of a function keypress
		 * or a menu event.
		 */

	if(InputIndex)
	{
			/* Did we reach the end of the string?
			 * If so, clear the index pointer and
			 * fall through to the input routine.
			 * If not, return the next character
			 * in the buffer.
			 */

		if(*InputIndex)
			return(*InputIndex++);
		else
		{
				/* Are we to read input from the clipboard? */

			if(ClipInput)
			{
				LONG Len;

					/* Read next data. */

				if((Len = ClipRead(InputBuffer,INPUT_LENGTH)) > 0)
				{
						/* Reset index pointer. */

					InputIndex = InputBuffer;

						/* Return the next byte. */

					return(*InputIndex++);
				}
				else
				{
						/* Close the clipboard. */

					ClipClose();
				}
			}

				/* Clear the buffer pointer. */

			InputIndex = NULL;
		}
	}

		/* Wait for input... */

	FOREVER
	{
			/* Process all incoming messages. */

		while(IntuiMessage = (struct IntuiMessage *)GetMsg(Window -> UserPort))
		{
				/* Remember the menu code. */

			Qualifier	= IntuiMessage -> Qualifier;
			Class		= IntuiMessage -> Class;
			Code		= IntuiMessage -> Code;

				/* Conver key code to ANSI character or control sequence. */

			if(Class == IDCMP_RAWKEY)
			{
				InputEvent -> ie_Class			= IECLASS_RAWKEY;
				InputEvent -> ie_Code			= Code;
				InputEvent -> ie_Qualifier		= Qualifier;

					/* Not really an APTR, but let's keep
					 * it for the sake of compatibility.
					 */

				InputEvent -> ie_position . ie_addr	= *((APTR *)IntuiMessage -> IAddress);

					/* Clear the conversion buffer, or the
					 * conversion result will be appended
					 * after the current contents.
					 */

				InputEventBuffer[0] = 0;

					/* Convert the event. */

				Len = RawKeyConvert(InputEvent,InputEventBuffer,INPUT_LENGTH - 1,NULL);
			}
			else
				Len = 0;

				/* Reply the message. */

			ReplyMsg((struct Message *)IntuiMessage);

				/* Did the window size change? */

			if(Class == IDCMP_NEWSIZE)
				return(TERM_RESIZE);

				/* Did the window become inactive? */

			if(Class == IDCMP_INACTIVEWINDOW)
			{
					/* Turn the cursor off. */

				ConCursorOff();

					/* Remember that the window is
					 * inactive now.
					 */

				WindowIsActive = FALSE;

					/* Turn on the (disabled) cursor. */

				ConCursorOn(CURSOR_NOCHANGE);
			}

				/* Did the window become active? */

			if(Class == IDCMP_ACTIVEWINDOW)
			{
					/* Turn the cursor off. */

				ConCursorOff();

					/* Remember that the window is
					 * active now.
					 */

				WindowIsActive = TRUE;

					/* Turn on the (enabled) cursor. */

				ConCursorOn(CURSOR_NOCHANGE);
			}

				/* Did the user press the close gadget? */

			if(Class == IDCMP_CLOSEWINDOW && !SingleKey)
				return(TERM_CLOSE);

				/* Did the user press the select button
				 * and a single keypress is wanted? If so,
				 * return a blank space.
				 */

			if(Class == IDCMP_MOUSEBUTTONS && SingleKey && Code == SELECTDOWN)
				return(' ');

				/* Did the user press a key? */

			if(Class == IDCMP_RAWKEY && Len > 0)
			{
					/* Return a blank space if just a
					 * keypress is wanted.
					 */

				if(SingleKey)
					return(' ');
				else
				{
						/* Provide null-termination. */

					InputEventBuffer[Len] = 0;

						/* Is this a numeric pad key
						 * and was no shift key pressed?
						 */

					if((Qualifier & IEQUALIFIER_NUMERICPAD) && !(Qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT|IEQUALIFIER_CAPSLOCK)))
					{
							/* Key codes and associated cardinal directions. */

						STATIC STRPTR Directions[][2] =
						{
							"8",	"north\r",
							"9",	"ne\r",
							"6",	"east\r",
							"3",	"se\r",
							"2",	"south\r",
							"1",	"sw\r",
							"4",	"west\r",
							"7",	"nw\r",

							"[",	"in\r",
							"]",	"out\r",

							"+",	"up\r",
							"-",	"down\r"
						};

						int i;

							/* Run down the list of directions. */

						for(i = 0 ; i < sizeof(Directions) / (2 * sizeof(STRPTR)) ; i++)
						{
								/* Does it match the input? */

							if(!strcmp(Directions[i][0],InputEventBuffer))
							{
									/* Use it as fake input. */

								InputIndex = Directions[i][1];

									/* Return ^X. */

								return(TERM_CUT);
							}
						}

							/* Get back to the loop. */

						continue;
					}

						/* Check for special codes, such as
						 * Shift + Del or Shift + Backspace.
						 */

					if(Qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
					{
							/* Delete to end of line? */

						if(InputEventBuffer[0] == TERM_DEL)
							return(TERM_DELFWD);

							/* Delete to start of line? */

						if(InputEventBuffer[0] == TERM_BS)
							return(TERM_DELBCK);
					}

						/* Take over the input. */

					InputIndex = InputEventBuffer;

						/* Return the first character. */

					return(*InputIndex++);
				}
			}

				/* Process all menu codes, including
				 * cases of multiple-selection.
				 */

			if(Class == IDCMP_MENUPICK)
			{
				struct MenuItem	*Item;
				UBYTE		 Char = 0;

					/* Process all menu selections. */

				while(Code != MENUNULL)
				{
						/* Obtain the address of
						 * the menu item to belong
						 * to this menu code.
						 */

					if(Item = ItemAddress(Menu,Code))
					{
							/* Did we already get
							 * a suitable menu
							 * item?
							 */

						if(!Char)
						{
								/* Get the new input string. */

							if(!(InputIndex = (STRPTR)GTMENUITEM_USERDATA(Item)))
							{
									/* Is it the `About...' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_PROJECT,PROJECTMENU_ABOUT,NOSUB)))
								{
										/* Turn the cursor off. */

									ConCursorOff();

										/* Display the information requester. */

									ConAbout();

										/* Turn the cursor back on. */

									ConCursorOn(CURSOR_NOCHANGE);
								}

									/* Is it the `Script...' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_PROJECT,PROJECTMENU_SCRIPT,NOSUB)))
								{
										/* This is probably the scripting command. */

									if(F2_IS_SET(B_SCRIPTING))
										InputIndex = (STRPTR)"Unscript\r";
									else
										InputIndex = (STRPTR)"Script\r";

										/* `Fake' a Ctrl-X
										 * to clear the contents
										 * of the input line.
										 */

									Char = TERM_CUT;
								}

									/* Is it the `Cut' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_EDIT,EDITMENU_CUT,NOSUB)))
									Char = TERM_CUT;

									/* Is it the `Copy' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_EDIT,EDITMENU_COPY,NOSUB)))
									Char = TERM_COPY;

									/* Is it the `Paste' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_EDIT,EDITMENU_PASTE,NOSUB)))
								{
										/* Open the clipboard for reading. */

									if(ClipOpen())
									{
										LONG Len;

											/* Read next data. */

										if((Len = ClipRead(InputBuffer,INPUT_LENGTH)) > 0)
										{
												/* Reset index pointer. */

											InputIndex = InputBuffer;

												/* Return the next byte. */

											return(*InputIndex++);
										}

											/* Close the clipboard. */

										ClipClose();
									}
								}

									/* Is it the `Undo' item? */

								if(Item == ItemAddress(Menu,FULLMENUNUM(MENU_EDIT,EDITMENU_UNDO,NOSUB)))
									Char = TERM_UNDO;
							}
							else
							{
									/* `Fake' a Ctrl-X
									 * to clear the contents
									 * of the input line.
									 */

								Char = TERM_CUT;
							}
						}

							/* Proceed to next menu entry. */

						Code = Item -> NextSelect;
					}
				}

					/* Did we get anything sensible? If so,
					 * return immediately.
					 */

				if(Char)
					return(Char);
			}
		}

			/* Check the Workbench appwindow. */

		if(WorkbenchPort)
		{
			struct AppMessage *AppMessage;

			while(AppMessage = (struct AppMessage *)GetMsg(WorkbenchPort))
			{
					/* Do we already have a file name? */

				if(!GotName)
				{
					LONG i;

						/* Run down the list of arguments... */

					for(i = 0 ; !GotName && i < AppMessage -> am_NumArgs ; i++)
					{
							/* A correct project icon always has a
							 * directory lock associated, let's check it.
							 */

						if(AppMessage -> am_ArgList[i] . wa_Lock)
						{
								/* Build the project directory name. */

							if(NameFromLock(AppMessage -> am_ArgList[i] . wa_Lock,ProjectName,MAX_FILENAME_LENGTH))
							{
									/* Add the project name. */

								if(AddPart(ProjectName,AppMessage -> am_ArgList[i] . wa_Name,MAX_FILENAME_LENGTH))
								{
									struct DiskObject *Icon;

										/* Try to read the project icon. */

									if(Icon = GetDiskObject(ProjectName))
									{
											/* Is it really a project icon? */

										if(Icon -> do_Type == WBPROJECT)
										{
											STRPTR Type;

												/* Find the file type if any. */

											if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FILETYPE"))
											{
													/* Is it a bookmark file? */

												if(MatchToolValue(Type,"BOOKMARK") && MatchToolValue(Type,"ITF"))
													GotName = TRUE;
											}
										}

											/* Free the icon data. */

										FreeDiskObject(Icon);
									}
								}
							}
						}
					}
				}

					/* Reply the notification message. */

				ReplyMsg((struct Message *)AppMessage);
			}
		}

			/* Did we get a project file name? */

		if(GotName)
		{
				/* Get the new input string. */

			InputIndex = (STRPTR)"Restore\r";

				/* Return with new input. */

			return(TERM_CUT);
		}
		else
			ProjectName[0] = 0;

		do
		{
				/* Wait for input... */

			Signals = Wait(SIG_WINDOW | SIG_WORKBENCH | SIG_TIME);

				/* Did we get a timeout? */

			if(Signals & SIG_TIME)
			{
					/* Toggle the cursor state
					 * only if the window is
					 * really active.
					 */

				if(WindowIsActive)
				{
						/* Which state is the cursor currently in?
						 * If it's enabled, turn it off, else
						 * turn it on.
						 */

					if(CursorEnabled)
						ConCursorOff();
					else
						ConCursorOn(CURSOR_NOCHANGE);
				}

					/* Wait for timer request to return. */

				WaitIO((struct IORequest *)TimeRequest);

					/* Restart timer. */

				TimeRequest -> tr_node . io_Command	= TR_ADDREQUEST;
				TimeRequest -> tr_time . tv_secs	= 0;
				TimeRequest -> tr_time . tv_micro	= SECOND / 2;

				SendIO((struct IORequest *)TimeRequest);
			}
		}
		while(!(Signals & (SIG_WINDOW | SIG_WORKBENCH)));
	}
}

	/* ConPrintf(const char *Format,...):
	 *
	 *	Print a string on the console, including formatting.
	 */

VOID
ConPrintf(const char *Format,...)
{
	va_list VarArgs;

		/* Build the string. */

	va_start(VarArgs,Format);

	vsprintf(TempBuffer,Format,VarArgs);

	va_end(VarArgs);

		/* Print it. */

	ConWrite(TempBuffer,-1,0);
}

	/* ConSwap(STRPTR a,STRPTR b,int Len):
	 *
	 *	Swap the contents of two string buffers.
	 */

VOID
ConSwap(STRPTR a,STRPTR b,int Len)
{
	register UBYTE Temp;

	while(Len--)
	{
		Temp	= *a;
		*a++	= *b;
		*b++	= Temp;
	}
}

	/* ConInput(char *Prompt,char *Input,const int MaxLen,const Bool DoHistory):
	 *
	 *	Read a line of characters.
	 */

int
ConInput(char *Prompt,char *Input,const int MaxLen,const Bool DoHistory)
{
		/* Control sequence buffer and length of control sequence. */

	TEXT		 SequenceBuffer[81];
	int		 SequenceLen;

		/* Input length, current cursor position index, last history buffer. */

	int		 Len		= 0,
			 Index		= 0,
			 HistoryIndex	= LastHistory + 1,
			 i;

		/* Undo buffer area. */

	char		*UndoBuffer;
	int		 UndoLen,
			 UndoIndex;

		/* The character to read. */

	UBYTE		 Char;

		/* Initial cursor X position. */

	UWORD		 InitialCursorX	= CursorX;

		/* Loop flag. */

	Bool		 Done		= FALSE;

		/* Prepare the undo buffer. */

	UndoBuffer = malloc(MaxLen);

	UndoLen = UndoIndex = 0;

		/* Change the font if necessary. */

	if(ThisFont != PropFont)
		SetFont(RPort,ThisFont = PropFont);

		/* Read until done. */

	do
	{
			/* Get a character. */

		switch(Char = ConGetChar(FALSE))
		{
				/* A function key, a cursor key or the help key. */

			case TERM_CSI:	SequenceLen = 0;

						/* Read the whole sequence if possible,
						 * up to 80 characters will be accepted.
						 */

					do
						SequenceBuffer[SequenceLen++] = Char = ConGetChar(FALSE);
					while(SequenceLen < 80 && (Char == ' ' || Char == ';' || Char == '?' || (Char >= '0' && Char <= '9')));

						/* Provide null-termination. */

					SequenceBuffer[SequenceLen] = 0;

						/* Function key. */

					if(SequenceBuffer[0] != '?' && SequenceBuffer[SequenceLen - 1] == '~')
					{
						int Key;

							/* Remove the terminating tilde. */

						SequenceBuffer[SequenceLen - 1] = 0;

							/* Make sure that the function
							 * key code is in reasonable
							 * dimensions, some custom
							 * keyboards have more than
							 * 20 function keys.
							 */

						if((Key = atoi(SequenceBuffer)) < NUM_FKEYS)
						{
								/* Is a string assigned to
								 * this function key?
								 */

							if(FunctionKeys[Key] . sb_Len)
							{
								Bool	GotIt = FALSE;
								int	i;

									/* Examine the string and look
									 * for a bar or exclamation mark
									 * which will terminate the
									 * string and produce a carriage-
									 * return.
									 */

								for(i = 0 ; i < FunctionKeys[Key] . sb_Len ; i++)
								{
										/* Is this the character we are looking for? */

									if(FunctionKeys[Key] . sb_Buffer[i] == '|' || FunctionKeys[Key] . sb_Buffer[i] == '!')
									{
											/* Save the previous input buffer contents. */

										if(Len && UndoBuffer)
											memcpy(UndoBuffer,Input,Len);

										UndoLen		= Len;
										UndoIndex	= Index;

											/* Copy the string. */

										memcpy(InputBuffer,FunctionKeys[Key] . sb_Buffer,i);

											/* Add the carriage-return. */

										InputBuffer[i++] = '\r';
										InputBuffer[i]   = 0;

											/* Stop the search and
											 * remember that we got
											 * a fitting string.
											 */

										GotIt = TRUE;

										break;
									}
								}

									/* Provide new input. */

								if(GotIt)
									InputIndex = InputBuffer;
								else
									InputIndex = FunctionKeys[Key] . sb_Buffer;
							}
							else
								DisplayBeep(Window -> WScreen);
						}

						break;
					}

						/* Help key. */

					if(DoHistory && !strcmp(SequenceBuffer,"?~"))
					{
							/* Which function key is pressed? */

						int WhichKey = -1;

							/* Do not produce any `fake' input. */

						InputIndex = NULL;

							/* Reset the text colour. */

						ConSetColour(COLOUR_TEXT);

						ConCursorOff();

							/* Clear the input line. */

						ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

							/* Ask for the function key to
							 * assign a string to.
							 */

						ConPrintf("Function key to define: ");
						ConClearEOL();

						ConCursorOn(CURSOR_NOCHANGE);

							/* Is the first character we get
							 * a control-sequence introducer?
							 */

						if(ConGetChar(FALSE) == TERM_CSI)
						{
							SequenceLen = 0;

								/* Read the whole sequence if possible,
								 * up to 80 characters will be accepted.
								 */

							do
								SequenceBuffer[SequenceLen++] = Char = ConGetChar(FALSE);
							while(SequenceLen < 80 && (Char == ' ' || Char == ';' || Char == '?' || (Char >= '0' && Char <= '9')));

								/* Provide null-termination. */

							SequenceBuffer[SequenceLen] = 0;

								/* Did we get a function key code? */

							if(SequenceBuffer[0] != '?' && SequenceBuffer[SequenceLen - 1] == '~')
							{
									/* The function key we got. */

								int Key;

									/* Remove the terminating tilde. */

								SequenceBuffer[SequenceLen - 1] = 0;

									/* Get the number of the key. */

								if((Key = atoi(SequenceBuffer)) < NUM_FKEYS)
									WhichKey = Key;
							}
						}

						ConCursorOff();

							/* Return to input colour. */

						ConSetColour(COLOUR_INPUT);

							/* Did we get any key? */

						if(WhichKey == -1)
							ConPrintf("None.");
						else
						{
							int Len;

								/* Print the key name. */

							ConPrintf("%sF%d",(WhichKey > 9) ? "Shift " : "",(WhichKey % 10) + 1);

								/* Provide new line. */

							ConScrollUp();

								/* Set text colour. */

							ConSetColour(COLOUR_TEXT);

								/* Show new prompt. */

							ConPrintf("Key text >");

							ConCursorOn(CURSOR_NOCHANGE);

								/* Return to input colour. */

							ConSetColour(COLOUR_INPUT);

							InputIndex = NULL;

								/* Read key assignment. */

							Len = ConInput("",InputBuffer,0,FALSE);

								/* Set new key string. */

							ConSetKey(WhichKey,InputBuffer,Len);

							ConCursorOff();
						}

							/* Provide new line. */

						ConScrollUp();

							/* Set text colour. */

						ConSetColour(COLOUR_TEXT);

							/* Print the prompt string. */

						ConPrintf(Prompt);

							/* Set input colour. */

						ConSetColour(COLOUR_INPUT);

							/* Write the entire input line. */

						ConWrite(Input,Len,0);

							/* Make sure that the
							 * cursor is placed at
							 * the end of the input
							 * line.
							 */

						Index = Len;

						InputIndex = NULL;

						ConCursorOn(CURSOR_AVERAGE);

						break;
					}

						/* Cursor up: recall previous line in history buffer. */

					if(!strcmp(SequenceBuffer,"A"))
					{
							/* Are any history lines available? */

						if(LastHistory != -1)
						{
							ConCursorOff();

								/* Move cursor back
								 * to beginning of
								 * line.
								 */

							if(Index)
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

								/* Clear line. */

							ConClearEOL();

								/* Go to previous history line. */

							if(HistoryIndex)
								HistoryIndex--;

								/* Save the previous input buffer contents. */

							if(Len && UndoBuffer)
								memcpy(UndoBuffer,Input,Len);

							UndoLen		= Len;
							UndoIndex	= Index;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = MIN(MaxLen,HistoryBuffer[HistoryIndex] . sb_Len);
							else
								Index = Len = HistoryBuffer[HistoryIndex] . sb_Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . sb_Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len,0);

							ConCursorOn(CURSOR_NOCHANGE);
						}

						break;
					}

						/* Cursor down: recall next line in history buffer. */

					if(!strcmp(SequenceBuffer,"B"))
					{
							/* Are any history lines available? */

						if(LastHistory != -1)
						{
							ConCursorOff();

								/* Are we at the end
								 * of the list?
								 */

							if(HistoryIndex < LastHistory)
							{
									/* Move cursor back
									 * to beginning of
									 * line.
									 */

								if(Index)
									ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

									/* Clear line. */

								ConClearEOL();

									/* Get next history line. */

								HistoryIndex++;

									/* Save the previous input buffer contents. */

								if(Len && UndoBuffer)
									memcpy(UndoBuffer,Input,Len);

								UndoLen		= Len;
								UndoIndex	= Index;

									/* Determine history line length. */

								if(MaxLen)
									Index = Len = MIN(MaxLen,HistoryBuffer[HistoryIndex] . sb_Len);
								else
									Index = Len = HistoryBuffer[HistoryIndex] . sb_Len;

									/* Copy the history line over. */

								memcpy(Input,HistoryBuffer[HistoryIndex] . sb_Buffer,Len);

									/* Write the line. */

								ConWrite(Input,Len,0);
							}
							else
							{
									/* Move cursor back
									 * to beginning of
									 * line.
									 */

								if(Index)
									ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

									/* Clear line. */

								ConClearEOL();

									/* Save the previous input buffer contents. */

								if(Len && UndoBuffer)
									memcpy(UndoBuffer,Input,Len);

								UndoLen		= Len;
								UndoIndex	= Index;

									/* Nothing in the line buffer right now. */

								Index = Len = 0;

									/* Make sure that `cursor up'
									 * will recall the last history
									 * line.
									 */

								HistoryIndex = LastHistory + 1;
							}

							ConCursorOn(CURSOR_NOCHANGE);
						}

						break;
					}

						/* Shift + cursor up: recall first history line in buffer. */

					if(!strcmp(SequenceBuffer,"T"))
					{
							/* Are any history lines available? */

						if(LastHistory != -1)
						{
							ConCursorOff();

								/* Move cursor back
								 * to beginning of
								 * line.
								 */

							if(Index)
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

								/* Clear line. */

							ConClearEOL();

								/* Use the first history line. */

							HistoryIndex = 0;

								/* Save the previous input buffer contents. */

							if(Len && UndoBuffer)
								memcpy(UndoBuffer,Input,Len);

							UndoLen		= Len;
							UndoIndex	= Index;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = MIN(MaxLen,HistoryBuffer[HistoryIndex] . sb_Len);
							else
								Index = Len = HistoryBuffer[HistoryIndex] . sb_Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . sb_Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len,0);

							ConCursorOn(CURSOR_NOCHANGE);
						}

						break;
					}

						/* Shift + cursor down: recall last history line. */

					if(!strcmp(SequenceBuffer,"S"))
					{
							/* Are any history lines available? */

						if(LastHistory != -1)
						{
							ConCursorOff();

								/* Move cursor back
								 * to beginning of
								 * line.
								 */

							if(Index)
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

								/* Clear line. */

							ConClearEOL();

								/* Go to last line in history buffer. */

							HistoryIndex = LastHistory;

								/* Save the previous input buffer contents. */

							if(Len && UndoBuffer)
								memcpy(UndoBuffer,Input,Len);

							UndoLen		= Len;
							UndoIndex	= Index;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = MIN(MaxLen,HistoryBuffer[HistoryIndex] . sb_Len);
							else
								Index = Len = HistoryBuffer[HistoryIndex] . sb_Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . sb_Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len,0);

							ConCursorOn(CURSOR_NOCHANGE);
						}

						break;
					}

						/* Cursor right: move cursor to the right. */

					if(!strcmp(SequenceBuffer,"C"))
					{
							/* Are we at the end of the line? */

						if(Index < Len)
						{
							if(Index == Len - 1)
								ConMove(ConCharWidth(Input[Index]),-1);
							else
								ConMove(ConCharWidth(Input[Index]),ConCharWidth(Input[Index + 1]));

							Index++;
						}

						break;
					}

						/* Cursor left: move cursor to the left. */

					if(!strcmp(SequenceBuffer,"D"))
					{
							/* Are we at the beginning of the line? */

						if(Index > 0)
						{
								/* Update internal cursor position. */

							Index--;

								/* Move cursor to the left. */

							ConMove(-ConCharWidth(Input[Index]),ConCharWidth(Input[Index]));
						}

						break;
					}

						/* Shift + cursor right: move cursor to end of line. */

					if(!strcmp(SequenceBuffer," @"))
					{
							/* Are we at the end of the line? */

						if(Index < Len)
						{
								/* Move cursor to end of line. */

							ConMove(TextLength(RPort,&Input[Index],Len - Index),-1);

								/* Update internal cursor position. */

							Index = Len;
						}

						break;
					}

						/* Shift + cursor left: move cursor to beginning of line. */

					if(!strcmp(SequenceBuffer," A"))
					{
							/* Are we at the beginning of the line? */

						if(Index > 0)
						{
								/* Move cursor to beginning of line. */

							if(Len)
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[0]));
							else
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

								/* Update internal cursor position. */

							Index = 0;
						}
					}

					break;

				/* Control-A: move cursor to beginning of line. */

			case TERM_BEGIN:

					if(Index > 0)
					{
							/* Move cursor to beginning of line. */

						if(Len)
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[0]));
						else
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

							/* Update internal cursor position. */

						Index = 0;
					}

					break;

				/* Control-Z: move cursor to end of line. */

			case TERM_END:	if(Index < Len)
					{
							/* Move cursor to end of line. */

						ConMove(TextLength(RPort,&Input[Index],Len - Index),-1);

							/* Update internal cursor position. */

						Index = Len;
					}

					break;

				/* Backspace: delete the character to the left
				 * of the cursor.
				 */

			case TERM_BS:	if(Index > 0)
					{
							/* Save the previous input buffer contents. */

						if(Len && UndoBuffer)
							memcpy(UndoBuffer,Input,Len);

						UndoLen		= Len;
						UndoIndex	= Index;

							/* Delete the character. */

						if(Index == Len)
							ConCharBackspace(ConCharWidth(Input[Index - 1]),-1);
						else
							ConCharBackspace(ConCharWidth(Input[Index - 1]),ConCharWidth(Input[Index]));

							/* Move line contents. */

						for(i = Index - 1 ; i < Len - 1 ; i++)
							Input[i] = Input[i + 1];

							/* Update internal cursor position. */

						Index--;

							/* Update line length. */

						Len--;
					}

					break;

				/* Delete: delete the character under the cursor. */

			case TERM_DEL:	if(Index < Len)
					{
							/* Save the previous input buffer contents. */

						if(Len && UndoBuffer)
							memcpy(UndoBuffer,Input,Len);

						UndoLen		= Len;
						UndoIndex	= Index;

							/* Delete the character. */

						if(Index == Len - 1)
							ConCharDelete(CURSOR_AVERAGE);
						else
							ConCharDelete(ConCharWidth(Input[Index + 1]));

							/* Move line contents. */

						for(i = Index ; i < Len - 1 ; i++)
							Input[i] = Input[i + 1];

							/* Update line length. */

						Len--;
					}

					break;

				/* Control-C: copy input line. */

			case TERM_COPY:	if(UndoBuffer)
					{
						if(Len && UndoBuffer)
							memcpy(UndoBuffer,Input,Len);

						UndoLen		= Len;
						UndoIndex	= Index;
					}
					else
						DisplayBeep(Window -> WScreen);

					if(Len)
						ClipSave(Input,Len);

					break;

				/* Control-Y: undo previous editing action. */

			case TERM_UNDO:	if(UndoBuffer)
					{
						int OldLen,OldIndex;

						if(Len > 0)
						{
								/* Move to beginning of line. */
	
							if(Index)
								ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);
	
								/* Clear line contents. */
	
							ConClearEOL();
						}
	
							/* Set new cursor size. */
	
						ConCursorOff();
						ConCursorOn(CURSOR_AVERAGE);
	
							/* Copy the input line. */

						ConSwap(Input,UndoBuffer,MaxLen);
	
							/* Restore length and index. */
	
						OldLen		= Len;
						OldIndex	= Index;

						Len		= UndoLen;
						Index		= UndoIndex;

						UndoLen		= OldLen;
						UndoIndex	= OldIndex;
	
							/* Move the cursor. */

						if(Index && Len)
						{
							if(Index == Len)
								ConSet(InitialCursorX + TextLength(RPort,Input,Index),TextFontHeight * (ConNumLines - 1),CURSOR_AVERAGE);
							else
							{
								if(Index)
									ConSet(InitialCursorX + TextLength(RPort,Input,Index),TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[Index]));
								else
									ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[Index]));
							}
						}

							/* Redraw the input line. */
	
						RedrawInputLine = TRUE;
					}
					else
						DisplayBeep(Window -> WScreen);

					break;

				/* Control-K: delete everything from the cursor forward
				 * to the end of the line.
				 */

			case TERM_DELFWD:

						/* Save the previous input buffer contents. */

					if(Len && UndoBuffer)
						memcpy(UndoBuffer,Input,Len);

					UndoLen		= Len;
					UndoIndex	= Index;

						/* Cut off the remaining line. */

					Len = Index;

						/* Set new cursor size. */

					ConCursorOff();
					ConCursorOn(CURSOR_AVERAGE);

						/* Redraw the input line. */

					RedrawInputLine = TRUE;

					break;

				/* Control-U: delete everything from the cursor backward
				 * to the start of the line.
				 */

			case TERM_DELBCK:

						/* Save the previous input buffer contents. */

					if(Len && UndoBuffer)
						memcpy(UndoBuffer,Input,Len);

					UndoLen		= Len;
					UndoIndex	= Index;

						/* Is there anything to clear? */

					if(Index > 0 && Len > 0)
					{
							/* Are we to clear the entire line? */

						if(Index == Len)
						{
								/* Move to beginning of line. */
	
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);
	
								/* Clear line contents. */
	
							ConClearEOL();
	
								/* Nothing in the line buffer right now. */
	
							Index = Len = 0;
						}
						else
						{
								/* Move line contents. */
	
							for(i = 0 ; i < Len - Index ; i++)
								Input[i] = Input[Index + i];
	
								/* Move to beginning of line. */
	
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);
	
								/* Update length and index. */

							Len	-= Index;
							Index	 = 0;

								/* Redraw the input line. */

							RedrawInputLine = TRUE;
						}
					}

					break;

				/* Control-W: delete the word to the left of the cursor. */

			case TERM_DELWORD:

						/* Anything to delete? */

					if(Len > 0 && Index > 0)
					{
						int Diff,Offset = Index - 1;

							/* Save the previous input buffer contents. */

						if(Len && UndoBuffer)
							memcpy(UndoBuffer,Input,Len);

						UndoLen		= Len;
						UndoIndex	= Index;

							/* Find the start of the previous word. */

						for(i = Index - 1 ; i >= 0 ; i--)
						{
							if(i)
							{
								if(Input[i] == ' ')
								{
									Offset = i + 1;

									break;
								}
							}
							else
							{
								Offset = i;

								break;
							}

						}

							/* Too much to move? */

						if(!(Diff = Index - Offset))
						{
							Diff	= 1;
							Offset	= Index - 1;
						}

							/* Move the line over. */

						for(i = Offset ; i < Len - Diff ; i++)
							Input[i] = Input[i + Diff];

						Index	-= Diff;
						Len	-= Diff;

							/* Move the cursor. */

						if(Index)
							ConSet(InitialCursorX + TextLength(RPort,Input,Index),TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[Index]));
						else
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),ConCharWidth(Input[Index]));

							/* Redraw the input line. */

						RedrawInputLine = TRUE;
					}

					break;

				/* Control-\: close the window. */

			case TERM_CLOSE:

					if(Len > 0)
					{
							/* Move to beginning of line. */

						if(Index)
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

							/* Clear line contents. */

						ConClearEOL();

							/* Nothing in the line buffer right now. */

						Index = Len = 0;
					}

						/* Drop clipboard processing. */

					ClipClose();

						/* Provide fake input. */

					InputIndex = "Quit\r";

					break;

				/* Control-X: delete the entire line contents. */

			case TERM_CUT:	if(Len > 0)
					{
						ClipSave(Input,Len);

							/* Save the previous input buffer contents. */

						if(UndoBuffer)
							memcpy(UndoBuffer,Input,Len);

						UndoLen		= Len;
						UndoIndex	= Index;

							/* Move to beginning of line. */

						if(Index)
							ConSet(InitialCursorX,TextFontHeight * (ConNumLines - 1),-1);

							/* Clear line contents. */

						ConClearEOL();

							/* Nothing in the line buffer right now. */

						Index = Len = 0;
					}

					break;

				/* Carriage return: terminate input. */

			case TERM_CR:	Done = TRUE;

					break;

				/* Form feed: window was resized. */

			case TERM_RESIZE:

					if(Window -> Width != OldWindowWidth || Window -> Height != OldWindowHeight)
					{
						Bool NewPrompt = FALSE;

							/* Has the width changed? */

						if(Window -> Width != OldWindowWidth)
						{
								/* Determine new window width. */

							WindowWidth = Window -> Width - (Window -> BorderLeft + Window -> BorderRight);

								/* If the input line has become
								 * too long for the window to
								 * hold, trim it.
								 */

							if(InitialCursorX + TextLength(RPort,Input,Len) + TextFontWidth + ConCharWidth(Char) >= WindowWidth)
							{
								while(Len > 0 && InitialCursorX + TextLength(RPort,Input,Len) + TextFontWidth + ConCharWidth(Char) >= WindowWidth)
									Len--;

									/* Turn off the cursor. */

								ConCursorOff();

									/* Is the prompt too long? If so,
									 * use a single character.
									 */

								if(Len < 0)
								{
									InitialCursorX = ConCharWidth('>');

									Prompt = ">";
								}

									/* Redraw prompt and input string. */

								NewPrompt = TRUE;
							}

								/* Remember new window width. */

							OldWindowWidth = Window -> Width;

								/* Print the score line. */

							scr_putscore();
						}

							/* Has the height changed? */

						if(Window -> Height != OldWindowHeight)
						{
							WORD Remainder;

								/* Has the window become less high?
								 * If so, clear the area below the
								 * input line.
								 */

							if((Remainder = Window -> Height - (Window -> BorderTop + ConNumLines * TextFontHeight + Window -> BorderBottom)) > 0)
							{
								SetAPen(RPort,ConBackPen);
								RectFill(RPort,Window -> BorderLeft,Window -> Height - (Window -> BorderBottom + Remainder),Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));
								SetAPen(RPort,ConTextPen);
							}

								/* Turn the cursor off. */

							ConCursorOff();

								/* If the window has become higher,
								 * erase the previous prompt.
								 */

							if(Window -> Height > OldWindowHeight)
							{
								ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

								ConClearEOL();
							}

								/* Determine new number of lines. */

							ConNumLines = (Window -> Height - (Window -> BorderTop + Window -> BorderBottom)) / TextFontHeight;

								/* Redraw both prompt and input string. */

							NewPrompt = TRUE;

								/* Remember new window height. */

							OldWindowHeight = Window -> Height;

								/* Clear the area below the input line. */

							if((Remainder = Window -> Height - (Window -> BorderTop + ConNumLines * TextFontHeight + Window -> BorderBottom)) > 0)
							{
								SetAPen(RPort,ConBackPen);
								RectFill(RPort,Window -> BorderLeft,Window -> Height - (Window -> BorderBottom + Remainder),Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));
								SetAPen(RPort,ConTextPen);
							}
						}

							/* Are we to redraw prompt and input string? */

						if(NewPrompt)
						{
								/* Move to bottom of window. */

							ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

								/* Set text colour. */

							ConSetColour(COLOUR_TEXT);

								/* Print the prompt string. */

							ConPrintf(Prompt);

								/* Set input colour. */

							ConSetColour(COLOUR_INPUT);

								/* Write the entire input line. */

							ConWrite(Input,Len,0);

								/* Clear the rest of the line. */

							ConClearEOL();

								/* Make sure that the
								 * cursor is placed at
								 * the end of the input
								 * line.
								 */

							Index = Len;

							InputIndex = NULL;

							ConCursorOn(CURSOR_AVERAGE);
						}
					}

					break;

				/* If suitable, store the character entered. */

			default:	if(Char >= 32 && Char <= 126)
					{
							/* Is there a length limit? */

						if(!MaxLen || Len < MaxLen)
						{
								/* If the resulting string will become
								 * too long to fit in the window, don't
								 * store the new character.
								 */

							if(InitialCursorX + TextLength(RPort,Input,Len) + TextFontWidth + ConCharWidth(Char) < WindowWidth)
							{
									/* Save the previous input buffer contents. */

								if(Len && UndoBuffer)
									memcpy(UndoBuffer,Input,Len);

								UndoLen		= Len;
								UndoIndex	= Index;

									/* Print the character. */

								ConCharInsert(Char);

									/* Move line contents up if
									 * necessary.
									 */

								if(Index < Len)
								{
									for(i = Len ; i > Index ; i--)
										Input[i] = Input[i - 1];
								}

									/* Store the character. */

								Input[Index++] = Char;

									/* Update line length. */

								Len++;
							}
						}
					}

					break;
		}

			/* Are we to redraw the input line? */

		if(RedrawInputLine)
		{
			ConRedraw(InitialCursorX,TextFontHeight * (ConNumLines - 1),Input,Len);

			RedrawInputLine = FALSE;
		}
	}
	while(!Done);

		/* Did the user enter anything? */

	if(Len && DoHistory)
	{
			/* Move up if space is exhausted. */

		if(LastHistory == HISTORY_LINES - 1)
		{
				/* Free first line in history buffer. */

			free(HistoryBuffer[0] . sb_Buffer);

				/* Move previous contents up. */

			for(i = 1 ; i < HISTORY_LINES ; i++)
				HistoryBuffer[i - 1] = HistoryBuffer[i];
		}
		else
			LastHistory++;

			/* Add next history line. */

		if(HistoryBuffer[LastHistory] . sb_Buffer = (char *)malloc(Len))
		{
				/* Copy the input line. */

			memcpy(HistoryBuffer[LastHistory] . sb_Buffer,Input,Len);

				/* Save the line length. */

			HistoryBuffer[LastHistory] . sb_Len = Len;
		}
		else
			LastHistory--;
	}

		/* Drop the undo buffer. */

	if(UndoBuffer)
		free(UndoBuffer);

		/* Close the clipboard, we don't want multiple
		 * lines to be returned.
		 */

	ClipClose();

		/* Return number of characters entered. */

	return(Len);
}

	/* ConPrintStatus(const char *Left,const char *Right):
	 *
	 *	Print the status line.
	 */

VOID
ConPrintStatus(const char *Left,const char *Right)
{
	int	LeftLen,	RightLen,
		LeftWidth,	RightWidth,

		Width;

		/* Change the font if necessary. */

	if(ThisFont != PropFont)
		SetFont(RPort,ThisFont = PropFont);

		/* Determine lengths of both strings. */

	LeftLen		= strlen(Left),
	RightLen	= strlen(Right),

		/* Determine pixel widths of both strings. */

	LeftWidth	= TextLength(RPort,(STRPTR)Left,LeftLen);
	RightWidth	= TextLength(RPort,(STRPTR)Right,RightLen);

		/* Determine width of the space in between. */

	Width		= WindowWidth - (LeftWidth + RightWidth + 1);

		/* Set the status colour. */

	ConSetColour(COLOUR_STATUS);

		/* Print the left part if any. */

	if(LeftLen)
	{
		Move(RPort,Window -> BorderLeft,ThisFont -> tf_Baseline + Window -> BorderTop);
		Text(RPort,(STRPTR)Left,LeftLen);
	}

		/* Clear the area between left and right part. */

	if(Width > 0)
	{
		SetAPen(RPort,ConBackPen);
		RectFill(RPort,LeftWidth + Window -> BorderLeft,Window -> BorderTop,LeftWidth + Width + Window -> BorderLeft,Window -> BorderTop + TextFontHeight - 1);
		SetAPen(RPort,ConTextPen);
	}

		/* Print the right part if any. */

	if(RightLen)
	{
		Move(RPort,Window -> Width - (RightWidth + Window -> BorderRight),Window -> BorderTop + ThisFont -> tf_Baseline);
		Text(RPort,(STRPTR)Right,RightLen);
	}

		/* Return to previous cursor position. */

	ConSetColour(COLOUR_TEXT);
}

	/* ConShowRequest():
	 *
	 *	Display a multiple-choice requester.
	 */

LONG
ConShowRequest(const struct Window *Window,const STRPTR Text,const STRPTR Gadgets,...)
{
	STATIC struct Requester	BlockRequester;

	struct EasyStruct	Easy;
	LONG			Result;
	ULONG			IDCMP = NULL;
	va_list			VarArgs;

		/* Clear the requester and install it, blocking
		 * the parent window.
		 */

	memset(&BlockRequester,0,sizeof(struct Requester));

	Request(&BlockRequester,(struct Window *)Window);

		/* Install the wait mouse pointer. */

	WaitPointer((struct Window *)Window);

		/* Fill in the template. */

	Easy . es_StructSize	= sizeof(struct EasyStruct);
	Easy . es_Flags		= NULL;
	Easy . es_Title		= (STRPTR)"Infocom";
	Easy . es_TextFormat	= (STRPTR)Text;
	Easy . es_GadgetFormat	= (STRPTR)Gadgets;

		/* Display the requester. */

	va_start(VarArgs,Gadgets);

	Result = EasyRequestArgs((struct Window *)Window,&Easy,&IDCMP,VarArgs);

	va_end(VarArgs);

		/* Remove the wait mouse pointer. */

	ClearPointer((struct Window *)Window);

		/* Remove the blocking requester. */

	EndRequest(&BlockRequester,(struct Window *)Window);

		/* Return the result. */

	return(Result);
}

	/* ConQueryOption(int Option):
	 *
	 *	Query the state of an interpreter option.
	 */

Bool
ConQueryOption(int Option)
{
	switch(Option)
	{
		case OPTION_ATTRIBUTE_ASSIGNMENTS:

			if(gflags . pr_attr)
				return(TRUE);
			else
				break;

		case OPTION_ATTRIBUTE_TESTS:

			if(gflags . pr_atest)
				return(TRUE);
			else
				break;

		case OPTION_ECHO:

			if(gflags . echo)
				return(TRUE);
			else
				break;

		case OPTION_PAGING:

			if(gflags . paged)
				return(TRUE);
			else
				break;

		case OPTION_PROMPT:

			if(F1_IS_SET(B_ALT_PROMPT))
				return(TRUE);
			else
				break;

		case OPTION_STATUS:

			if(gflags . pr_status)
				return(TRUE);
			else
				break;

		case OPTION_TANDY:

			if(F1_IS_SET(B_TANDY))
				return(TRUE);
			else
				break;

		case OPTION_XFERS:

			if(gflags . pr_xfers)
				return(TRUE);
			else
				break;

		default:

			break;
	}

	return(FALSE);
}

	/* ConUpdateMenus():
	 *
	 *	Update the main menu items corresponding
	 *	to the runtime options.
	 */

VOID
ConUpdateMenus()
{
	struct MenuItem *Item;

		/* Block the pull-down menu. */

	ConLockMenus();

		/* Are object attribute assignments to be printed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_ATTRIBUTE_ASSIGNMENTS,NOSUB));

	if(ConQueryOption(OPTION_ATTRIBUTE_ASSIGNMENTS))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Are object attribute tests to be printed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_ATTRIBUTE_TESTS,NOSUB));

	if(ConQueryOption(OPTION_ATTRIBUTE_TESTS))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Is input to be echoed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_ECHO,NOSUB));

	if(ConQueryOption(OPTION_ECHO))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Is text paging enabled? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_PAGING,NOSUB));

	if(ConQueryOption(OPTION_PAGING))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Is the alternate prompt to be displayed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_PROMPT,NOSUB));

	if(ConQueryOption(OPTION_PROMPT))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Is the status line to be displayed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_STATUS,NOSUB));

	if(ConQueryOption(OPTION_STATUS))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Is the Tandy license to be displayed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_TANDY,NOSUB));

	if(ConQueryOption(OPTION_TANDY))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Are object transfers to be displayed? */

	Item = ItemAddress(Menu,FULLMENUNUM(MENU_OPTIONS,OPTIONSMENU_XFERS,NOSUB));

	if(ConQueryOption(OPTION_XFERS))
		Item -> Flags |= CHECKED;
	else
		Item -> Flags &= ~CHECKED;

		/* Enable the pull-down menus again. */

	ConUnlockMenus();
}

	/* ConLockMenus():
	 *
	 *	Lock the menu strip.
	 */

VOID
ConLockMenus()
{
		/* Are we allowed to do what we want? */

	if(NewOS)
	{
		if(!MenuLockCount++)
		{
				/* Block the menu strip. */

			Window -> Flags |= WFLG_RMBTRAP;
		}
	}
}

	/* ConUnlockMenus():
	 *
	 *	Unlock the menu strip.
	 */

VOID
ConUnlockMenus()
{
		/* Are we allowed to do what we want? */

	if(NewOS)
	{
		if(MenuLockCount > 0)
		{
			if(MenuLockCount-- == 1)
			{
					/* Unblock the menu strip. */

				Window -> Flags &= ~WFLG_RMBTRAP;
			}
		}
	}
}

	/* ConSplitLine(char *Line,int Len,Bool ReturnPrompt):
	 *
	 *	Split a hunk of text into neat little pieces.
	 */

char *
ConSplitLine(char *Line,int Len,Bool ReturnPrompt)
{
	LONG	Width,
		Indent,
		Columns;

	int	Count,
		Space;

		/* Make sure that the rendering area is large enough. */

	if((WindowWidth - (ConLineIndent * SpaceWidth + ConLineMargin * SpaceWidth)) / TextFontWidth < 40)
	{
		do
		{
			if(ConLineIndent)
				ConLineIndent--;

			if(ConLineMargin)
				ConLineMargin--;
		}
		while(ConLineIndent && ConLineMargin && (WindowWidth - (ConLineIndent * SpaceWidth + ConLineMargin * SpaceWidth)) / TextFontWidth < 40);
	}

		/* Make sure to leave enough space for the user
		 * to type a character.
		 */

	if(ReturnPrompt)
	{
		Width	= WindowWidth - (2 * TextFontWidth + SpaceWidth * ConLineMargin);
		Indent	= 0;
	}
	else
	{
		Width	= WindowWidth - SpaceWidth * (ConLineIndent + ConLineMargin);
		Indent	= SpaceWidth * ConLineIndent;
	}

		/* Determine number of columns. */

	Columns = (Width - SpaceWidth * (ConLineIndent + ConLineMargin)) / TextFontWidth;

		/* Process & chop the text. */

	do
	{
			/* Does the entire line fit? */

		if(Len <= Columns)
		{
				/* Are we to return the
				 * rest of the line as
				 * a buffer suitable for
				 * printing as a prompt?
				 */

			if(ReturnPrompt)
				return(Line);
			else
				ConPrintLine(Line,Count = Len,Indent);
		}
		else
		{
				/* Start with minimum values. */

			Space = Count = Columns;

				/* Try to find the last space in case
				 * the minimum width is the exact line
				 * size to fit which would cause the
				 * line to be broken at the last
				 * character (generally, not a pretty
				 * sight at all).
				 */

			while(Space > 0 && Line[Space] != ' ')
				Space--;

				/* Will another character fit? */

			while(Count < Len && TextLength(RPort,(STRPTR)Line,Count + 1) < Width)
			{
				Count++;

					/* Remember last space. */

				if(Line[Count] == ' ')
					Space = Count;
			}

				/* Print the text. */

			if(Count == Len)
			{
				if(ReturnPrompt)
					return(Line);
				else
				{
					if(Line[Count - 1] == ' ')
						ConPrintLine(Line,Count - 1,Indent);
					else
						ConPrintLine(Line,Count,Indent);
				}
			}
			else
			{
				if(Line[Count - 1] == ' ')
					ConPrintLine(Line,Count - 1,Indent);
				else
				{
					ConPrintLine(Line,Space,Indent);

					Count = Space + 1;
				}
			}

				/* Move up. */

			Line += Count;
		}

			/* Reduce remaining line length. */

		Len -= Count;
	}
	while(Len > 0);

		/* Return blank prompt. */

	return("");
}

	/* ConPrintLine(const char *Buffer,int Len,int Indent):
	 *
	 *	Print a line of text.
	 */

VOID
ConPrintLine(const char *Buffer,int Len,int Indent)
{
		/* Is the plain text window active? */

	if(!ConOutputWindow)
	{
			/* Scroll the screen contents up one line. */

		ConScrollUp();

			/* Are we to perform paging? */

		if(gflags . paged)
		{
			int PageLength;

				/* Determine current page length. */

			if(ConNumStatusLines > 1 || gflags . pr_status)
				PageLength = ConNumLines - ConNumStatusLines;
			else
				PageLength = ConNumLines;

				/* Did we print enough lines already to
				 * show the `[More]' prompt?
				 */

			if(ConLinesPrinted >= PageLength - (ConLineContext + 2))
			{
					/* Turn on the text rendering font. */

				if(ThisFont != PropFont)
					SetFont(RPort,ThisFont = PropFont);

					/* Set special colour. */

				ConSetColour(COLOUR_SPECIAL);

					/* Show the prompt. */

				ConPrintf("[More]");

					/* Set text colour. */

				ConSetColour(COLOUR_TEXT);

					/* Turn on the cursor. */

				ConCursorOn(CURSOR_AVERAGE);

					/* Block the pull-down menus. */

				ConLockMenus();

					/* Did the window size change? If so,
					 * go through the same number of
					 * actions as in the main input
					 * routine.
					 */

				while(ConGetChar(TRUE) == TERM_RESIZE)
				{
					if(Window -> Width != OldWindowWidth)
					{
							/* Remember new window width. */

						OldWindowWidth = Window -> Width;

							/* Determine new window dimensions. */

						WindowWidth = Window -> Width - (Window -> BorderLeft + Window -> BorderRight);

							/* Update score display. */

						scr_putscore();
					}

					if(Window -> Height != OldWindowHeight)
					{
						WORD Remainder;

						ConCursorOff();

							/* If the window has become larger than
							 * before, remove the `[More]' prompt.
							 */

						if(Window -> Height > OldWindowHeight)
						{
							ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

							ConClearEOL();
						}

							/* Calculate new window dimensions. */

						ConNumLines = (Window -> Height - (Window -> BorderTop + Window -> BorderBottom)) / TextFontHeight;

						OldWindowHeight = Window -> Height;

							/* Set input colour. */

						ConSetColour(COLOUR_INPUT);

							/* Go to the bottom of the screen. */

						ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

							/* Show the prompt. */

						ConPrintf("[More]");

						ConClearEOL();

							/* Set text colour. */

						ConSetColour(COLOUR_TEXT);

							/* Turn on the cursor. */

						ConCursorOn(CURSOR_AVERAGE);

						if((Remainder = Window -> Height - (Window -> BorderTop + ConNumLines * TextFontHeight + Window -> BorderBottom)) > 0)
						{
							SetAPen(RPort,ConBackPen);
							RectFill(RPort,Window -> BorderLeft,Window -> Height - (Window -> BorderBottom + Remainder),Window -> Width - (Window -> BorderRight + 1),Window -> Height - (Window -> BorderBottom + 1));
							SetAPen(RPort,ConTextPen);
						}
					}
				}

					/* Enable the pull-down menus again. */

				ConUnlockMenus();

					/* Erase the `[More]' prompt. */

				ConCursorOff();

				ConSet(0,TextFontHeight * (ConNumLines - 1),-1);

				ConClearEOL();

					/* That's all. */

				ConLinesPrinted = 0;
			}
			else
				ConLinesPrinted++;
		}
	}

		/* Is the status window active? */

	if(ConOutputWindow)
	{
			/* Write the string if any. */

		if(Len)
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

				/* Write the string. */

			ConWrite(Buffer,Len,0);
		}

			/* Clear to end of line. */

		ConClearEOL();

			/* Update current cursor position. */

		CursorY	+= TextFontHeight;
		CursorX	 = 0;
	}
	else
	{
			/* Write the string if any. */

		if(Len)
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

				/* Write the string. */

			ConWrite(Buffer,Len,Indent);
		}
	}
}

	/* ConCheckStory(char *Name):
	 *
	 *	Check a file to see if it's a valid type 3
	 *	story game file.
	 */

Bool
ConCheckStory(const char *Name)
{
	struct FileInfoBlock	*FileInfo;
	Bool			 Result = FALSE;

		/* Allocate space for fileinfo data. */

	if(FileInfo = (struct FileInfoBlock *)AllocDosObjectTags(DOS_FIB,TAG_DONE))
	{
		BPTR FileLock;

			/* Try to locate the file. */

		if(FileLock = Lock((STRPTR)Name,ACCESS_READ))
		{
				/* Get a closer look at it. */

			if(Examine(FileLock,FileInfo))
			{
					/* Does it look like a valid file? */

				if(FileInfo -> fib_DirEntryType < 0 && FileInfo -> fib_Size > 0)
				{
					FILE *StoryFile;

						/* Try to open the file for reading. */

					if(StoryFile = fopen(Name,"rb"))
					{
							/* Does it look like a type 3
							 * story game file?
							 */

						if(fgetc(StoryFile) == 3)
							Result = TRUE;

							/* Close the file. */

						fclose(StoryFile);
					}
				}
			}

				/* Release the file lock. */

			UnLock(FileLock);
		}

			/* Free fileinfo data. */

		FreeDosObject(DOS_FIB,FileInfo);
	}

	return(Result);
}

	/* ConLocateStory(char *Directory,char *Default):
	 *
	 *	Try to locate a story file in a directory.
	 */

char *
ConLocateStory(const char *Directory,const char *Default)
{
	char	 LocalBuffer[MAX_FILENAME_LENGTH];
	int	 i,j;

		/* Start with the current default name. */

	if(Default[0])
	{
		for(j = 0 ; StoryExtensions[j] ; j++)
		{
				/* Copy the directory name. */

			strcpy(TempBuffer,Directory);

				/* Build the story file name. */

			strcpy(LocalBuffer,Default);
			strcat(LocalBuffer,StoryExtensions[j]);

				/* Build the full path name. */

			if(AddPart(TempBuffer,LocalBuffer,MAX_FILENAME_LENGTH))
			{
					/* Is it a valid story game file? */

				if(ConCheckStory(TempBuffer))
					return((char *)TempBuffer);
			}
		}
	}

		/* Run down the number of alternatives. */

	for(i = 0 ; StoryNames[i] ; i++)
	{
			/* Run down the number of file name extensions. */

		for(j = 0 ; StoryExtensions[j] ; j++)
		{
				/* Copy the directory name. */

			strcpy(TempBuffer,Directory);

				/* Build the story file name. */

			strcpy(LocalBuffer,StoryNames[i]);
			strcat(LocalBuffer,StoryExtensions[j]);

				/* Build the full path name. */

			if(AddPart(TempBuffer,LocalBuffer,MAX_FILENAME_LENGTH))
			{
					/* Is it a valid story game file? */

				if(ConCheckStory(TempBuffer))
					return((char *)TempBuffer);
			}
		}
	}

	return(NULL);
}

	/* ConQueryStoryInformation(const char *Name):
	 *
	 *	Query the story game header for information.
	 */

VOID
ConQueryStoryInformation(const char *Name)
{
	FILE *GameFile;

		/* Reset information. */

	StorySerial = StoryRelease = 0;

		/* Try to open the file for reading. */

	if(GameFile = fopen(Name,"rb"))
	{
		header_t GameHeader;

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
						/* Do the serial and release numbers match? */

					if(Serial == SerialNumbers[i][SERIAL_NUMBER] && GameHeader . release == SerialNumbers[i][SERIAL_RELEASE])
					{
						StorySerial	= Serial;
						StoryRelease	= GameHeader . release;
						StoryIndex	= SerialNumbers[i][SERIAL_INDEX];
					}
				}
			}
		}

			/* Close the story file. */

		fclose(GameFile);
	}
}

	/* ConAbout():
	 *
	 *	Display an information requester.
	 */

VOID
ConAbout()
{
		/* Show the information requester. */

	if(StorySerial)
	{
		ConShowRequest(Window,"\"%s\" (%s)\nRelease %ld / Serial number %ld\nWritten by %s\n\n\"pinfo\" version %ld.%ld, Amiga release %ld.%ld\nCopyright \251 1987-1992 InfoTaskForce",
			"Continue",Titles[StoryIndex],Levels[GameLevels[StoryIndex]],StoryRelease,StorySerial,Authors[StoryIndex],VERSION,PATCHLEVEL,AMIGA_VERSION,AMIGA_REVISION);
	}
	else
	{
		ConShowRequest(Window,"\"pinfo\" version %ld.%ld, Amiga release %ld.%ld\nCopyright \251 1987-1992 InfoTaskForce",
			"Continue",VERSION,PATCHLEVEL,AMIGA_VERSION,AMIGA_REVISION);
	}
}
