/* amigaio.c ******************************************************************
 *
 *	Minimal  Amiga  interface  for Mark Howell's `ZIP' Infocom Interpreter
 *	Program.  This is public-domain, no distribution restrictions apply.
 *
 *	Written by Olaf `Olsen' Barthel, 4 October 1992
 *
 *	   This  minimal  interface is guaranteed to work both unter Kickstart
 *	1.2/1.3 and Kickstart 2.0 (or higher if you can afford it).
 *
 *	The  screen drag bar is left intact, it is reduced to four lines.  The
 *	input  procedure  uses the following keys:
 *
 *	Return.............. Terminates input
 *	Control-X........... Erases the input line
 *	Backspace........... Deletes the character to the left of the cursor
 *	Delete.............. Deletes the character under the cursor
 *	Cursor left......... Moves the cursor to the left
 *	Shift cursor left... Moves the cursor to the beginning of the line
 *	Cursor right........ Moves the cursor to the right
 *	Shift cursor right.. Moves the cursor to the end of the line
 *	Cursor up........... Moves up in history list
 *	Shift cursor up..... Moves to first history line
 *	Cursor down......... Moves down in history list
 *	Shift cursor down... Moves to end of history list
 *	Help................ Define function key
 *	F1-F10.............. Function keys
 *	Numeric keypad...... Movement
 *
 *	An  ANSI  `C'  compatible  compiler is required to compile this source
 *	code  (e.g.  SAS/C 5.x, Aztec C 5.x, DICE, GCC).
 *
 *****************************************************************************/

#include <intuition/intuitionbase.h>
#include <libraries/dosextens.h>
#include <workbench/workbench.h>
#include <workbench/startup.h>
#include <graphics/gfxbase.h>
#include <devices/conunit.h>
#include <devices/audio.h>
#include <devices/timer.h>
#include <exec/memory.h>

#ifdef __GNUC__
#include <inline/stubs.h>

#include <inline/intuition.h>
#include <inline/graphics.h>
#include <inline/exec.h>
#include <inline/dos.h>

#include <signal.h>

	/* Signals to trap while running. */

#define TRAPPED_SIGNALS (sigmask(SIGINT)|sigmask(SIGQUIT)|sigmask(SIGILL)|sigmask(SIGTRAP)|sigmask(SIGABRT)|sigmask(SIGEMT)|sigmask(SIGFPE)|sigmask(SIGBUS)|sigmask(SIGSEGV)|sigmask(SIGSYS)|sigmask(SIGALRM)|sigmask(SIGTERM)|sigmask(SIGTSTP))

#endif	/* __GNUC__ */

#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/console_protos.h>
#include <clib/icon_protos.h>
#include <clib/alib_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

	/* Some help to keep the code size down. */

#ifdef AZTEC_C
#include <pragmas/exec_lib.h>
#endif	/* AZTEC_C */

#ifdef LATTICE
#include <pragmas/exec_pragmas.h>
#endif	/* LATTICE */

#include <stdarg.h>

#include "ztypes.h"

	/* Disable ^C trapping for several Amiga `C' compilers. */

#ifdef LATTICE
ULONG CXBRK(VOID) { return(0); }
#endif	/* LATTICE */

#ifdef AZTEC_C
LONG Chk_Abort(VOID) { return(0); }
VOID _wb_parse(VOID) {}
#endif	/* AZTEC_C */

	/* Version identifier tag. */

STATIC char			*VersionTag = "\0$VER: AmigaZIP 2.2 (9.10.92)";

	/* Control sequence introducer. */

#define TERM_CSI		0x9B

	/* Backspace character. */

#define TERM_BS			'\b'

	/* Delete character. */

#define TERM_DEL		0x7F

	/* Return character. */

#define TERM_CR			'\r'

	/* Control-X */

#define TERM_X			0x18

	/* Margin between screen top and window top. */

#define SCREEN_MARGIN		4

	/* How many history lines to keep. */

#ifndef HISTORY_LINES
#define HISTORY_LINES		20
#endif	/* !HISTORY_LINES */

	/* Number of function keys. */

#define NUM_FKEYS		20

	/* Length of `fake' input string. */

#define INPUT_LENGTH		1024

	/* Minimum system software release version. */

#define LIB_VERSION		33

	/* A second measured in microseconds. */

#define SECOND			1000000

	/* Two signals to wait for. */

#define SIG_WINDOW		(1 << Window -> UserPort -> mp_SigBit)
#define SIG_TIMER		(1 << TimePort -> mp_SigBit)

	/* Audio channel bits. */

#define LEFT0F  1
#define RIGHT0F  2
#define RIGHT1F  4
#define LEFT1F  8

	/* The two windows. */

enum	{	WINDOW_TEXT,WINDOW_STATUS };

	/* Cursor widths. */

enum	{	CURSOR_AVERAGE = -1,CURSOR_NOCHANGE = 0 };

	/* History structure. */

struct StringEntry
{
	int	Len;		/* Length of the string. */
	STRPTR	Buffer;		/* The string itself. */
};

	/* Global libraries (don't touch!) */

struct IntuitionBase		*IntuitionBase;
struct GfxBase			*GfxBase;
struct Library			*IconBase;
struct Device			*ConsoleDevice;

	/* Workbench startup message. */

STATIC struct WBStartup		*WBenchMsg;

	/* Screen and window data. */

STATIC struct Screen		*Screen;
STATIC struct Window		*Window;
STATIC struct RastPort		*RPort;

	/* Console IO data. */

STATIC struct IOStdReq		*ConRequest;
STATIC struct InputEvent	*InputEvent;
STATIC STRPTR			 InputEventBuffer;

STATIC LONG			 CursorX,
				 CursorY,
				 LastX,
				 LastY,
				 OldWidth,
				 NewWidth,
				 WindowWidth;
STATIC BOOL			 CursorState,
				 Redraw;

STATIC LONG			 SavedX,SavedY;
STATIC BOOL			 SavedCursor = FALSE;

	/* Two different fonts. */

STATIC struct TextFont		*PropFont,
				*FixedFont,
				*ThisFont;

	/* Text font dimensions. */

STATIC UWORD			 TextFontWidth,
				 TextFontHeight,
				 TextFontAverage;

	/* Console data. */

STATIC UBYTE			 ConChar;
STATIC char			*ConLine;
STATIC int			 ConLineLength,
				 ConLineMaxLength,
				 ConLineMinLength;

STATIC int			 ConFgPen,
				 ConBgPen;

	/* Timer data. */

STATIC struct MsgPort		*TimePort;
STATIC struct timerequest	*TimeRequest;

	/* Process and DOS tricks. */

STATIC struct Process		*ThisProcess;
STATIC APTR			 WindowPtr;

	/* History management. */

STATIC struct StringEntry	 HistoryBuffer[HISTORY_LINES];
STATIC int			 LastHistory = -1;

	/* Function key support. */

STATIC struct StringEntry	 FunctionKeys[NUM_FKEYS];

	/* Fake input buffer. */

STATIC UBYTE			 InputBuffer[INPUT_LENGTH];
STATIC STRPTR			 InputIndex;

	/* The currently active text window. */

STATIC int			 CurrentWindow = WINDOW_TEXT;

	/* Current game file name and interpreter program name. */

STATIC STRPTR			 StoryName,
				 InterpreterName;

	/* Current text attribute. */

STATIC int			 CurrentAttribute = NORMAL;

	/* Sound support. */

STATIC struct IOAudio		*SoundRequestLeft,
				*SoundRequestRight,
				*SoundControlRequest;
STATIC struct MsgPort		*SoundPort;

	/* Sound file search path. */

STATIC char			*SoundName,
				*SoundPath;

	/* Sound data storage. */

STATIC int			 SoundNumber = -1;
STATIC APTR			 SoundData;
STATIC LONG			 SoundLength;

	/* Custom routines, local. */

STATIC BYTE			SoundInit(VOID);
STATIC VOID			SoundExit(VOID);
STATIC VOID			SoundAbort(VOID);
STATIC VOID			SoundStop(VOID);
STATIC VOID			SoundStart(VOID);

STATIC WORD			ConCharWidth(const UBYTE Char);
STATIC VOID			ConCursorOff(VOID);
STATIC VOID			ConCursorOn(const int New);
STATIC VOID			ConMove(const int Delta,const int New);
STATIC VOID			ConSet(const int X,const int Y,const int New);
STATIC VOID			ConClearEOL(VOID);
STATIC VOID			ConCharBackspace(const int Delta,const int New);
STATIC VOID			ConCharDelete(const int New);
STATIC VOID			ConCharInsert(const UBYTE Char);
STATIC VOID			ConScrollUp(VOID);
STATIC VOID			ConWrite(char *Line,int Len);
STATIC VOID			ConRedraw(const int X,const int Y,const STRPTR String,const int Len);
STATIC VOID			ConSetKey(int Key,STRPTR String,int Len);
STATIC VOID			ConFlush(VOID);
STATIC UBYTE			ConGetChar(BOOL SingleKey);
STATIC VOID			ConPrintf(char *Format,...);
STATIC int			ConInput(char *Prompt,char *Input,int MaxLen,BOOL DoHistory);

	/* SoundInit():
	 *
	 *	Allocate resources for sound routine.
	 */

STATIC BYTE
SoundInit()
{
		/* Create io reply port. */

	if(SoundPort = (struct MsgPort *)CreatePort(NULL,0))
	{
			/* Create io control request. We will use it
			 * later to change the volume of a sound.
			 */

		if(SoundControlRequest = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
		{
				/* Create io request for left channel. */

			if(SoundRequestLeft = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
			{
					/* Create io request for right channel. */

				if(SoundRequestRight = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
				{
						/* Channel allocation map,
						 * we want any two stereo
						 * channels.
						 */

					STATIC UBYTE AllocationMap[] =
					{
						LEFT0F | RIGHT0F,
						LEFT0F | RIGHT1F,
						LEFT1F | RIGHT0F,
						LEFT1F | RIGHT1F
					};

						/* Set it up for channel allocation,
						 * any two stereo channels will do.
						 */

					SoundControlRequest -> ioa_Request . io_Message . mn_Node . ln_Pri	= 127;
					SoundControlRequest -> ioa_Request . io_Command				= ADCMD_ALLOCATE;
					SoundControlRequest -> ioa_Request . io_Flags				= ADIOF_NOWAIT | ADIOF_PERVOL;
					SoundControlRequest -> ioa_Data						= AllocationMap;
					SoundControlRequest -> ioa_Length					= sizeof(AllocationMap);

						/* Open the device, allocating the channel on the way. */

					if(!OpenDevice(AUDIONAME,NULL,(struct IORequest *)SoundControlRequest,NULL))
					{
							/* Copy the initial data to the
							 * other audio io requests.
							 */

						CopyMem((BYTE *)SoundControlRequest,(BYTE *)SoundRequestLeft, sizeof(struct IOAudio));
						CopyMem((BYTE *)SoundControlRequest,(BYTE *)SoundRequestRight,sizeof(struct IOAudio));

							/* Divide the channels. */

						SoundRequestLeft  -> ioa_Request . io_Unit = (struct Unit *)((ULONG)SoundRequestLeft  -> ioa_Request . io_Unit & (LEFT0F  | LEFT1F));
						SoundRequestRight -> ioa_Request . io_Unit = (struct Unit *)((ULONG)SoundRequestRight -> ioa_Request . io_Unit & (RIGHT0F | RIGHT1F));

							/* Return success. */

						return(TRUE);
					}
				}
			}
		}
	}

		/* Clean up... */

	SoundExit();

		/* ...and return failure. */

	return(FALSE);
}

	/* SoundExit():
	 *
	 *	Free resources allocated by SoundInit().
	 */

STATIC VOID
SoundExit()
{
		/* Free the left channel data. */

	if(SoundRequestLeft)
	{
			/* Did we open the device? */

		if(SoundRequestLeft -> ioa_Request . io_Device)
		{
				/* Check if the sound is still playing. */

			if(!CheckIO((struct IORequest *)SoundRequestLeft))
			{
					/* Abort the request. */

				AbortIO((struct IORequest *)SoundRequestLeft);

					/* Wait for it to return. */

				WaitIO((struct IORequest *)SoundRequestLeft);
			}
			else
				GetMsg(SoundPort);
		}

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundRequestLeft);

			/* Leave no traces. */

		SoundRequestLeft = NULL;
	}

		/* Free the right channel data. */

	if(SoundRequestRight)
	{
			/* Did we open the device? */

		if(SoundRequestRight -> ioa_Request . io_Device)
		{
				/* Check if the sound is still playing. */

			if(!CheckIO((struct IORequest *)SoundRequestRight))
			{
					/* Abort the request. */

				AbortIO((struct IORequest *)SoundRequestRight);

					/* Wait for it to return. */

				WaitIO((struct IORequest *)SoundRequestRight);
			}
			else
				GetMsg(SoundPort);
		}

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundRequestRight);

			/* Leave no traces. */

		SoundRequestRight = NULL;
	}

		/* Free sound control request. */

	if(SoundControlRequest)
	{
			/* Close the device, free any allocated channels. */

		if(SoundControlRequest -> ioa_Request . io_Device)
			CloseDevice((struct IORequest *)SoundControlRequest);

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundControlRequest);

			/* Leave no traces. */

		SoundControlRequest = NULL;
	}

		/* Free sound io reply port. */

	if(SoundPort)
	{
			/* Delete it. */

		DeletePort(SoundPort);

			/* Leave no traces. */

		SoundPort = NULL;
	}

		/* Free sound data. */

	if(SoundData && SoundLength)
	{
			/* Free it. */

		FreeMem(SoundData,SoundLength);

			/* Leave no traces. */

		SoundData	= NULL;
		SoundLength	= 0;
	}

		/* Clear current sound number. */

	SoundNumber = -1;
}

	/* SoundAbort():
	 *
	 *	Abort any currently playing sound and wait for
	 *	both IORequests to return.
	 */

STATIC VOID
SoundAbort()
{
		/* Abort sound playing on the left channel. */

	if(!CheckIO((struct IORequest *)SoundRequestLeft))
		AbortIO((struct IORequest *)SoundRequestLeft);

		/* Wait for the request to return. */

	WaitIO((struct IORequest *)SoundRequestLeft);

		/* Abort sound playing on the right channel. */

	if(!CheckIO((struct IORequest *)SoundRequestRight))
		AbortIO((struct IORequest *)SoundRequestRight);

		/* Wait for the request to return. */

	WaitIO((struct IORequest *)SoundRequestRight);
}

	/* SoundStop():
	 *
	 *	Stop sound from getting played (somewhat equivalent to ^S).
	 */

STATIC VOID
SoundStop()
{
		/* Fill in the command. */

	SoundControlRequest -> ioa_Request . io_Command = CMD_STOP;

		/* Send it off. */

	SendIO((struct IORequest *)SoundControlRequest);
	WaitIO((struct IORequest *)SoundControlRequest);
}

	/* SoundStart():
	 *
	 *	Restart any queued sound.
	 */

STATIC VOID
SoundStart()
{
		/* Fill in the command. */

	SoundControlRequest -> ioa_Request . io_Command = CMD_START;

		/* Send it off. */

	SendIO((struct IORequest *)SoundControlRequest);
	WaitIO((struct IORequest *)SoundControlRequest);
}

	/* ConCharWidth(const UBYTE Char):
	 *
	 *	Calculate the pixel width of a glyph.
	 */

STATIC WORD
ConCharWidth(const UBYTE Char)
{
	return(TextLength(RPort,(STRPTR)&Char,1));
}

	/* ConCursorOff():
	 *
	 *	Turn the terminal cursor on.
	 */

STATIC VOID
ConCursorOff()
{
		/* Is it still enabled? */

	if(CursorState)
	{
			/* Remove the cursor. */

		SetAPen(RPort,0xFF);
		SetDrMd(RPort,COMPLEMENT|JAM2);

		RectFill(RPort,LastX,LastY,LastX + NewWidth - 1,LastY + TextFontHeight - 1);

		SetAPen(RPort,ConFgPen);
		SetDrMd(RPort,JAM2);

			/* It's turned off now. */

		CursorState = FALSE;
	}
}

	/* ConCursorOn(const int New):
	 *
	 *	Turn the terminal cursor off.
	 */

STATIC VOID
ConCursorOn(const int New)
{
		/* Is it still disabled? */

	if(!CursorState)
	{
			/* Remember new cursor width. */

		switch(New)
		{
			case CURSOR_NOCHANGE:	break;

			case CURSOR_AVERAGE:	NewWidth = TextFontAverage;
						break;

			default:		NewWidth = New;
						break;
		}

			/* Turn the cursor back on. */

		SetAPen(RPort,0xFF);
		SetDrMd(RPort,COMPLEMENT|JAM2);

		RectFill(RPort,CursorX,CursorY,CursorX + NewWidth - 1,CursorY + TextFontHeight - 1);

		SetAPen(RPort,ConFgPen);
		SetDrMd(RPort,JAM2);

			/* Remember cursor width. */

		OldWidth = NewWidth;

			/* It's turn on now. */

		CursorState = TRUE;

			/* Remember cursor position. */

		LastX = CursorX;
		LastY = CursorY;
	}
}

	/* ConMove(const int Delta,const int New):
	 *
	 *	Move the cursor.
	 */

STATIC VOID
ConMove(const int Delta,const int New)
{
		/* If the cursor is still enabled, turn it
		 * off before repositioning it.
		 */

	if(CursorState)
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
		switch(New)
		{
			case CURSOR_NOCHANGE:	break;

			case CURSOR_AVERAGE:	NewWidth = TextFontAverage;
						break;

			default:		NewWidth = New;
						break;
		}

		CursorX += Delta;
	}
}

	/* ConSet(const int X,const int Y,const int New):
	 *
	 *	Place the cursor at a specific position.
	 */

STATIC VOID
ConSet(const int X,const int Y,const int New)
{
		/* If the cursor is still enabled, turn it
		 * off before repositioning it.
		 */

	if(CursorState)
	{
			/* Turn the cursor off. */

		ConCursorOff();

			/* Move drawing pen. */

		Move(RPort,X,Y + ThisFont -> tf_Baseline);

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
			case CURSOR_NOCHANGE:	break;

			case CURSOR_AVERAGE:	NewWidth = OldWidth = TextFontAverage;
						break;

			default:		NewWidth = OldWidth = New;
						break;
		}

			/* Move drawing pen. */

		Move(RPort,X,Y + ThisFont -> tf_Baseline);

			/* Position the cursor. */

		CursorX = X;
		CursorY = Y;
	}
}

	/* ConClearEOL():
	 *
	 *	Clear to end of current line.
	 */

STATIC VOID
ConClearEOL()
{
		/* Is there anything to clear? */

	if(CursorX < WindowWidth)
	{
			/* Turn the cursor off before the line is cleared. */

		if(CursorState)
		{
				/* Turn the cursor off. */

			ConCursorOff();

				/* Clear the remaining line. */

			SetAPen(RPort,0);
			RectFill(RPort,CursorX,CursorY,Window -> Width - 1,CursorY + TextFontHeight - 1);
			SetAPen(RPort,ConFgPen);

				/* Turn the cursor back on. */

			ConCursorOn(CURSOR_NOCHANGE);
		}
		else
		{
			SetAPen(RPort,0);
			RectFill(RPort,CursorX,CursorY,Window -> Width - 1,CursorY + TextFontHeight - 1);
			SetAPen(RPort,ConFgPen);
		}
	}
}

	/* ConCharBackspace(const int Delta,const int New):
	 *
	 *	Move the cursor one glyph back.
	 */

STATIC VOID
ConCharBackspace(const int Delta,const int New)
{
	Redraw = TRUE;

	CursorX -= Delta;

	switch(New)
	{
		case CURSOR_NOCHANGE:	break;

		case CURSOR_AVERAGE:	NewWidth = TextFontAverage;
					break;

		default:		NewWidth = New;
					break;
	}
}

	/* ConCharDelete(const int New):
	 *
	 *	Delete the character under the cursor.
	 */

STATIC VOID
ConCharDelete(const int New)
{
	Redraw = TRUE;

	switch(New)
	{
		case CURSOR_NOCHANGE:	break;

		case CURSOR_AVERAGE:	NewWidth = TextFontAverage;
					break;

		default:		NewWidth = New;
					break;
	}
}

	/* ConCharInsert(const UBYTE Char):
	 *
	 *	Insert a character at the current cursor position.
	 */

STATIC VOID
ConCharInsert(const UBYTE Char)
{
	Redraw = TRUE;

	CursorX += ConCharWidth(Char);
}

	/* ConScrollUp():
	 *
	 *	Scroll the terminal contents one line up.
	 */

STATIC VOID
ConScrollUp()
{
	UWORD Top = status_size * TextFontHeight;

		/* Is the cursor enabled? */

	if(CursorState)
	{
			/* Turn the cursor off. */

		ConCursorOff();

			/* Scroll the terminal contents up. */

		ScrollRaster(RPort,0,TextFontHeight,0,Top,Window -> Width - 1,Window -> Height - 1);

			/* Reposition the cursor. */

		CursorX = 0;
		CursorY = TextFontHeight * (screen_rows - 1);

			/* Turn it on again. */

		ConCursorOn(CURSOR_NOCHANGE);
	}
	else
	{
			/* Scroll the terminal contents up. */

		ScrollRaster(RPort,0,TextFontHeight,0,Top,Window -> Width - 1,Window -> Height - 1);

			/* Reposition the cursor. */

		CursorX = 0;
		CursorY = TextFontHeight * (screen_rows - 1);
	}
}

	/* ConWrite(const char *Line,LONG Len):
	 *
	 *	Output a text on the terminal.
	 */

STATIC VOID
ConWrite(char *Line,int Len)
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

		if(CursorState)
		{
				/* Turn off the cursor. */

			ConCursorOff();

				/* Print the text. */

			Move(RPort,CursorX,CursorY + ThisFont -> tf_Baseline);
			Text(RPort,(STRPTR)Line,Len);

				/* Move up. */

			CursorX += TextLength(RPort,(STRPTR)Line,Len);

				/* Turn the cursor back on. */

			ConCursorOn(CURSOR_NOCHANGE);
		}
		else
		{
				/* Print the text. */

			Move(RPort,CursorX,CursorY + ThisFont -> tf_Baseline);
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

STATIC VOID
ConRedraw(const int X,const int Y,const STRPTR String,const int Len)
{
	LONG Width = TextLength(RPort,(STRPTR)String,Len);

		/* Turn the cursor off. */

	ConCursorOff();

		/* Redraw the input string. */

	Move(RPort,X,Y + ThisFont -> tf_Baseline);
	Text(RPort,(STRPTR)String,Len);

		/* Clear to end of line. */

	if(Width < WindowWidth)
	{
		SetAPen(RPort,0);
		RectFill(RPort,X + Width,Y,Window -> Width - 1,Y + TextFontHeight - 1);
		SetAPen(RPort,0);
	}

		/* Turn the cursor back on. */

	ConCursorOn(CURSOR_NOCHANGE);
}

	/* ConSetKey(int Key,STRPTR String,int Len):
	 *
	 *	Set a specific function key.
	 */

STATIC VOID
ConSetKey(int Key,STRPTR String,int Len)
{
		/* Is the new string longer than the old one? */

	if(FunctionKeys[Key] . Len < Len)
	{
			/* Free previous key assignment. */

		free(FunctionKeys[Key] . Buffer);

			/* Create new string buffer. */

		if(FunctionKeys[Key] . Buffer = (STRPTR)malloc(Len + 1))
		{
				/* Copy the key string. */

			memcpy(FunctionKeys[Key] . Buffer,String,Len);

				/* Provide null-termination. */

			FunctionKeys[Key] . Buffer[Len] = 0;

				/* Set string length. */

			FunctionKeys[Key] . Len = Len;
		}
		else
			FunctionKeys[Key] . Len = 0;
	}
	else
	{
			/* Install new string. */

		if(Len)
		{
				/* Copy the key string. */

			memcpy(FunctionKeys[Key] . Buffer,String,Len);

				/* Provide null-termination. */

			FunctionKeys[Key] . Buffer[Len] = 0;
		}
		else
		{
				/* Zero length, free previous buffer
				 * assignment.
				 */

			if(FunctionKeys[Key] . Buffer)
			{
					/* Free the buffer. */

				free(FunctionKeys[Key] . Buffer);

					/* Clear address pointer. */

				FunctionKeys[Key] . Buffer = NULL;
			}
		}

			/* Install new length. */

		FunctionKeys[Key] . Len = Len;
	}
}

	/* ConFlush():
	 *
	 *	Flush the text cache.
	 */

STATIC VOID
ConFlush()
{
		/* Are there any characters in the cache? */

	if(ConLineLength)
	{
		register BYTE HasMore = FALSE;

			/* Did we get exactly six character? */

		if(ConLineLength == 6)
		{
				/* Is it the `[MORE]' prompt? */

			if(!memcmp(ConLine,"[MORE]",6))
			{
					/* Reset text attribute. */

				SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));

				if(ConFgPen != 1)
					SetAPen(RPort,ConFgPen = 1);

				if(ThisFont != PropFont)
					SetFont(RPort,ThisFont = PropFont);

				HasMore = TRUE;
			}
		}

		if(HasMore)
		{
				/* Flush the cache. */

			ConWrite(ConLine,ConLineLength);

				/* Reset index. */

			ConLineLength = 0;

				/* Turn on original text attributes. */

			set_attribute(CurrentAttribute);
		}
		else
		{
				/* Flush the cache. */

			ConWrite(ConLine,ConLineLength);

				/* Reset index. */

			ConLineLength = 0;
		}
	}
}

	/* ConGetChar():
	 *
	 *	Read a single character from the console window.
	 */

STATIC UBYTE
ConGetChar(BOOL SingleKey)
{
	struct IntuiMessage	*IntuiMessage;
	ULONG			 Qualifier,
				 Class,
				 Code,
				 Signals;
	LONG			 Len;

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
			InputIndex = NULL;
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
				InputEvent -> ie_position . ie_addr	= *((APTR *)IntuiMessage -> IAddress);

				InputEventBuffer[0] = 0;

				Len = RawKeyConvert(InputEvent,InputEventBuffer,INPUT_LENGTH - 1,NULL);
			}
			else
				Len = 0;

				/* Reply the message. */

			ReplyMsg((struct Message *)IntuiMessage);

				/* Did the user press a key? */

			if(Class == IDCMP_RAWKEY && Len > 0)
			{
					/* Provide null-termination. */

				InputEventBuffer[Len] = 0;

					/* Is this a numeric pad key
					 * and was no shift key pressed?
					 */

				if(Qualifier & IEQUALIFIER_NUMERICPAD)
				{
					if(!(Qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT)))
					{
						if(SingleKey)
							return(InputEventBuffer[0]);
						else
						{
								/* Numbers and associated directions. */

							STATIC STRPTR Directions[][2] =
							{
								"8",	"n\r",
								"9",	"ne\r",
								"6",	"e\r",
								"3",	"se\r",
								"2",	"s\r",
								"1",	"sw\r",
								"4",	"w\r",
								"7",	"nw\r",

								"[",	"in\r",
								"]",	"out\r",

								"+",	"u\r",
								"-",	"d\r"
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

									return(TERM_X);
								}
							}
						}
					}
				}
				else
				{
					if(SingleKey)
					{
						if(InputEventBuffer[0] != TERM_CSI)
							return(InputEventBuffer[0]);
					}
					else
					{
							/* Take over the input. */

						InputIndex = InputEventBuffer;

							/* Return the first character. */

						return(*InputIndex++);
					}
				}
			}
		}

		do
		{
			Signals = Wait(SIG_TIMER | SIG_WINDOW);

			if(Signals & SIG_TIMER)
			{
				if(CursorState)
					ConCursorOff();
				else
					ConCursorOn(CURSOR_NOCHANGE);

					/* Remove timer request. */

				WaitIO(TimeRequest);

					/* Send new timer request. */

				TimeRequest -> tr_node . io_Command	= TR_ADDREQUEST;
				TimeRequest -> tr_time . tv_secs	= 0;
				TimeRequest -> tr_time . tv_micro	= SECOND / 2;

				BeginIO(TimeRequest);
			}
		}
		while(!(Signals & SIG_WINDOW));
	}
}

	/* ConPrintf(char *Format,...):
	 *
	 *	Print a text in the console window, including formatting
	 *	control codes.
	 */

STATIC VOID
ConPrintf(char *Format,...)
{
	STATIC char	ConBuffer[256];
	va_list		VarArgs;

	va_start(VarArgs,Format);
	vsprintf(ConBuffer,Format,VarArgs);
	va_end(VarArgs);

	ConWrite(ConBuffer,-1);
}

	/* ConInput(char *Input,int MaxLen):
	 *
	 *	Read a line of input from the console window.
	 */

STATIC int
ConInput(char *Prompt,char *Input,int MaxLen,BOOL DoHistory)
{
		/* Control sequence buffer and length of control sequence. */

	UBYTE		SequenceBuffer[81];
	int		SequenceLen;

		/* Input length, current cursor position index, last history buffer. */

	register int	Len		= 0,
			Index		= 0,
			HistoryIndex	= LastHistory + 1,
			i;

		/* The character to read. */

	register UBYTE	Char;

		/* Loop flag. */

	BOOL		Done	= FALSE;

	UWORD		OldX	= CursorX;

	if(ThisFont != PropFont)
	{
		SetFont(RPort,PropFont);

		ThisFont = PropFont;
	}

	ConCursorOn(CURSOR_AVERAGE);

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

							if(FunctionKeys[Key] . Len)
							{
								BOOL	GotIt = FALSE;
								int	i;

									/* Examine the string and look
									 * for a bar or exclamation mark
									 * which will terminate the
									 * string and produce a carriage-
									 * return.
									 */

								for(i = 0 ; i < FunctionKeys[Key] . Len ; i++)
								{
										/* Is this the character we are looking for? */

									if(FunctionKeys[Key] . Buffer[i] == '|' || FunctionKeys[Key] . Buffer[i] == '!')
									{
											/* Copy the string. */

										memcpy(InputBuffer,FunctionKeys[Key] . Buffer,i);

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
									InputIndex = FunctionKeys[Key] . Buffer;
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

							/* Do not produce any `fake' input. */

						InputIndex = NULL;

						ConCursorOff();

							/* Clear the input line. */

						ConSet(0,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

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

							/* Did we get any key? */

						if(WhichKey == -1)
							ConPrintf("none.");
						else
						{
							int Len;

								/* Print the key name. */

							ConPrintf("%sF%d",(WhichKey > 9) ? "Shift " : "",(WhichKey % 10) + 1);

								/* Provide new line. */

							ConScrollUp();

								/* Show new prompt. */

							ConPrintf("Key text >");

							ConCursorOn(CURSOR_NOCHANGE);

							InputIndex = NULL;

								/* Read key assignment. */

							Len = ConInput("",InputBuffer,0,FALSE);

								/* Set new key string. */

							ConSetKey(WhichKey,InputBuffer,Len);

							ConCursorOff();
						}

							/* Provide new line. */

						ConScrollUp();

							/* Print the prompt string. */

						ConPrintf(Prompt);

							/* Write the entire input line. */

						ConWrite(Input,Len);

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
								ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

								/* Clear line. */

							ConClearEOL();

								/* Go to previous history line. */

							if(HistoryIndex)
								HistoryIndex--;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = (HistoryBuffer[HistoryIndex] . Len > MaxLen) ? MaxLen : HistoryBuffer[HistoryIndex] . Len;
							else
								Index = Len = HistoryBuffer[HistoryIndex] . Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len);

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
									ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

									/* Clear line. */

								ConClearEOL();

									/* Get next history line. */

								HistoryIndex++;

									/* Determine history line length. */

								if(MaxLen)
									Index = Len = (HistoryBuffer[HistoryIndex] . Len > MaxLen) ? MaxLen : HistoryBuffer[HistoryIndex] . Len;
								else
									Index = Len = HistoryBuffer[HistoryIndex] . Len;

									/* Copy the history line over. */

								memcpy(Input,HistoryBuffer[HistoryIndex] . Buffer,Len);

									/* Write the line. */

								ConWrite(Input,Len);
							}
							else
							{
									/* Move cursor back
									 * to beginning of
									 * line.
									 */

								if(Index)
									ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

									/* Clear line. */

								ConClearEOL();

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

						/* Shift+cursor up: recall first history line in buffer. */

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
								ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

								/* Clear line. */

							ConClearEOL();

								/* Use the first history line. */

							HistoryIndex = 0;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = (HistoryBuffer[HistoryIndex] . Len > MaxLen) ? MaxLen : HistoryBuffer[HistoryIndex] . Len;
							else
								Index = Len = HistoryBuffer[HistoryIndex] . Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len);

							ConCursorOn(CURSOR_NOCHANGE);
						}

						break;
					}

						/* Shift+cursor down: recall last history line. */

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
								ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

								/* Clear line. */

							ConClearEOL();

								/* Go to last line in history buffer. */

							HistoryIndex = LastHistory;

								/* Determine history line length. */

							if(MaxLen)
								Index = Len = (HistoryBuffer[HistoryIndex] . Len > MaxLen) ? MaxLen : HistoryBuffer[HistoryIndex] . Len;
							else
								Index = Len = HistoryBuffer[HistoryIndex] . Len;

								/* Copy the history line over. */

							memcpy(Input,HistoryBuffer[HistoryIndex] . Buffer,Len);

								/* Write the line. */

							ConWrite(Input,Len);

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
								ConMove(ConCharWidth(Input[Index]),CURSOR_AVERAGE);
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

						/* Shift+cursor right: move cursor to end of line. */

					if(!strcmp(SequenceBuffer," @"))
					{
							/* Are we at the end of the line? */

						if(Index < Len)
						{
								/* Move cursor to end of line. */

							ConMove(TextLength(RPort,&Input[Index],Len - Index),CURSOR_AVERAGE);

								/* Update internal cursor position. */

							Index = Len;
						}

						break;
					}

						/* Shift+cursor left: move cursor to beginning of line. */

					if(!strcmp(SequenceBuffer," A"))
					{
							/* Are we at the beginning of the line? */

						if(Index > 0)
						{
								/* Move cursor to beginning of line. */

							if(Len)
								ConSet(OldX,TextFontHeight * (screen_rows - 1),ConCharWidth(Input[0]));
							else
								ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

								/* Update internal cursor position. */

							Index = 0;
						}
					}

					break;

				/* Backspace: delete the character to the left
				 * of the cursor.
				 */

			case TERM_BS:	if(Index > 0)
					{
							/* Delete the character. */

						if(Index == Len)
							ConCharBackspace(ConCharWidth(Input[Index - 1]),CURSOR_AVERAGE);
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

				/* Control-X: delete the entire line contents. */

			case TERM_X:	if(Len > 0)
					{
							/* Move to beginning of line. */

						if(Index)
							ConSet(OldX,TextFontHeight * (screen_rows - 1),CURSOR_AVERAGE);

							/* Clear line contents. */

						ConClearEOL();

							/* Nothing in the line buffer right now. */

						Index = Len = 0;
					}

					break;

				/* Carriage return: terminate input. */

			case TERM_CR:	Done = TRUE;

					break;

				/* If suitable, store the character entered. */

			default:	if(Char >= 32 && Char < 127)
					{
							/* Is there a length limit? */

						if(MaxLen)
						{
								/* If the string is large
								 * enough already, don't
								 * store the new character.
								 */

							if(Len >= MaxLen)
								break;
						}

							/* Is the resulting string too long
							 * to fit in the window, don't store
							 * the new character.
							 */

						if(OldX + TextLength(RPort,Input,Len) + TextFontWidth + ConCharWidth(Char) >= WindowWidth)
							break;

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

					break;
		}

			/* Are we to redraw the input line? */

		if(Redraw)
		{
			ConRedraw(OldX,TextFontHeight * (screen_rows - 1),Input,Len);

			Redraw = FALSE;
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

			free(HistoryBuffer[0] . Buffer);

				/* Move previous contents up. */

			for(i = 1 ; i < HISTORY_LINES ; i++)
				HistoryBuffer[i - 1] = HistoryBuffer[i];
		}
		else
			LastHistory++;

			/* Add next history line. */

		if(HistoryBuffer[LastHistory] . Buffer = (char *)malloc(Len))
		{
				/* Copy the input line. */

			memcpy(HistoryBuffer[LastHistory] . Buffer,Input,Len);

				/* Save the line length. */

			HistoryBuffer[LastHistory] . Len = Len;
		}
		else
			LastHistory--;
	}

		/* Return number of characters entered. */

	return(Len);
}

	/* initialize_screen():
	 *
	 *	Set up the screen to display the text.
	 */

VOID
initialize_screen()
{
		/* Default and system font definitions. */

	STATIC struct TextAttr	 DefaultFont = { (STRPTR)"topaz.font", 8, FS_NORMAL, FPF_ROMFONT | FPF_DESIGNED };

		/* The buffer to receive a copy of the Workbench screen. */

	struct Screen		 WorkbenchScreen;

		/* New screen structure. */

	struct NewScreen	 NewScreen;

		/* New window structure. */

	struct NewWindow	 NewWindow;

		/* System font dimensions. */

	UWORD			 SystemFontWidth,
				 SystemFontHeight;

		/* Auxilary data. */

	UWORD			 Width,Len;
	UBYTE			 Char;

		/* The famous `The story is loading...' (as seen on television). */

	const char		*TheStory = "The story is loading...";

#ifdef __GNUC__

	sigset_t trapped = TRAPPED_SIGNALS;

	if(sigprocmask(SIG_BLOCK,&trapped,NULL) != 0)
		fatal("Could not block signals");

#endif	/* __GNUC__ */

		/* Get current process identifier. */

	ThisProcess = (struct Process *)FindTask(NULL);

		/* Remember old window pointer. */

	WindowPtr = ThisProcess -> pr_WindowPtr;

		/* Open libraries... */

	if(!(IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",LIB_VERSION)))
		fatal("Could not open intuition.library");

	if(!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",LIB_VERSION)))
		fatal("Could not open graphics.library");

	IconBase = OpenLibrary("icon.library",LIB_VERSION);

		/* Create timer reply port. */

	if(!(TimePort = (struct MsgPort *)CreatePort(NULL,0)))
		fatal("Could not create timer port");

		/* Create timer IORequest. */

	if(!(TimeRequest = (struct timerequest *)CreateExtIO(TimePort,sizeof(struct timerequest))))
		fatal("Could not create timer request");

		/* Open timer.device. */

	if(OpenDevice("timer.device",UNIT_VBLANK,(struct IORequest *)TimeRequest,0))
		fatal("Could not open timer.device");

		/* Remember current system font. */

	Forbid();

		/* Remember system font dimensions. */

	SystemFontWidth		= GfxBase -> DefaultFont -> tf_XSize;
	SystemFontHeight	= GfxBase -> DefaultFont -> tf_YSize;

	Permit();

		/* Clear new screen definition. */

	memset(&NewScreen,0,sizeof(struct NewScreen));

		/* Fill in the common screen data. */

	NewScreen . Depth	= 1;
	NewScreen . DetailPen	= 0;
	NewScreen . BlockPen	= 1;
	NewScreen . Type	= CUSTOMSCREEN | SCREENBEHIND | SCREENQUIET;
	NewScreen . Font	= NULL;

	Forbid();

		/* Try to get some information on the Workbench screen. */

	if(GetScreenData(&WorkbenchScreen,sizeof(struct Screen),WBENCHSCREEN,NULL))
	{
		UWORD	Height	= WorkbenchScreen . Height,
			Width	= WorkbenchScreen . Width;

			/* Pick up the screen display mode ID. */

		NewScreen . ViewModes = WorkbenchScreen . ViewPort . Modes;

			/* Check for illegal dimension. */

		if(Width > 2 * GfxBase -> MaxDisplayColumn)
			Width = GfxBase -> NormalDisplayColumns;

		if(NewScreen . ViewModes & LACE)
		{
			if(Height > 2 * GfxBase -> MaxDisplayRow)
				Height = 2 * GfxBase -> NormalDisplayRows;
		}
		else
		{
			if(Height > GfxBase -> MaxDisplayRow)
				Height = GfxBase -> NormalDisplayRows;
		}

		NewScreen . Height = (((Height - SCREEN_MARGIN) / SystemFontHeight) * SystemFontHeight) + SCREEN_MARGIN;

			/* `A mind forever voyaging' requires a fixed screen
			 * width of eighty characters per line.
			 */

		if(h_type == 4 && (h_version == 79 || h_version == 77))
		{
			if(SystemFontWidth * 80 > Width)
			{
				NewScreen . Width	= 640;
				NewScreen . Height	= (((Height - SCREEN_MARGIN) / 8) * 8) + SCREEN_MARGIN;
				NewScreen . Font	= &DefaultFont;
			}
			else
				NewScreen . Width = SystemFontWidth * 80;
		}
		else
		{
				/* The current interpreter release does not
				 * support more than 128 columns.
				 */

			if(Width / SystemFontWidth > 128)
			{
				NewScreen . Width	= 640;
				NewScreen . Height	= (((Height - SCREEN_MARGIN) / 8) * 8) + SCREEN_MARGIN;
				NewScreen . Font	= &DefaultFont;
			}
			else
				NewScreen . Width = Width;
		}
	}
	else
	{
			/* Seems that it went wrong, anyway: let's assume
			 * default values then.
			 */

		NewScreen . ViewModes = HIRES;

			/* If the desired screen width is larger
			 * than 640 pixels, use the default font.
			 */

		if(SystemFontWidth * 80 > 640)
		{
			NewScreen . Width	= 640;
			NewScreen . Font	= &DefaultFont;
		}
		else
			NewScreen . Width = SystemFontWidth * 80;

			/* Adjust screen height accordingly. */

		if((GfxBase -> DisplayFlags & (PAL|NTSC)) == PAL)
			NewScreen . Height = (((256 - SCREEN_MARGIN) / SystemFontHeight) * SystemFontHeight) + SCREEN_MARGIN;
		else
			NewScreen . Height = (((200 - SCREEN_MARGIN) / SystemFontHeight) * SystemFontHeight) + SCREEN_MARGIN;
	}

	Permit();

		/* Open the screen. */

	if(IntuitionBase -> LibNode . lib_Version < 36)
	{
		if(!(Screen = (struct Screen *)OpenScreen(&NewScreen)))
			fatal("Could not open screen");

			/* Turn off the screen title. */

		ShowTitle(Screen,FALSE);
	}
	else
	{
		struct Rectangle	DisplayClip;
		ULONG			DisplayID;

		if(NewScreen . ViewModes & LACE)
			DisplayID = HIRESLACE_KEY;
		else
			DisplayID = HIRES_KEY;

		if(QueryOverscan(DisplayID,&DisplayClip,OSCAN_TEXT))
		{
			LONG Width = DisplayClip . MaxX - DisplayClip . MinX + 1;

			if(NewScreen . Width < Width)
			{
				DisplayClip . MinX += (Width - NewScreen . Width) / 2;
				DisplayClip . MaxX -= (Width - NewScreen . Width) / 2;
			}

			if(!(Screen = (struct Screen *)OpenScreenTags(&NewScreen,
				SA_Behind,	TRUE,
				SA_Quiet,	TRUE,
				SA_ShowTitle,	FALSE,
				SA_Depth,	1,
				SA_DClip,	&DisplayClip,
				SA_DisplayID,	DisplayID,
				SA_SysFont,	NewScreen . Font ? 0 : 1,
			TAG_DONE)))
				fatal("Could not open screen");
		}
		else
		{
			if(!(Screen = (struct Screen *)OpenScreenTags(&NewScreen,
				SA_Behind,	TRUE,
				SA_Quiet,	TRUE,
				SA_ShowTitle,	FALSE,
				SA_Depth,	1,
				SA_Width,	NewScreen . Width,
				SA_Height,	NewScreen . Height,
				SA_DisplayID,	DisplayID,
				SA_SysFont,	NewScreen . Font ? 0 : 1,
			TAG_DONE)))
				fatal("Could not open screen");
		}
	}

	SetRGB4(&Screen -> ViewPort,0,0x0,0x0,0x0);
	SetRGB4(&Screen -> ViewPort,1,0xD,0xD,0xD);

		/* Clear new window defition. */

	memset(&NewWindow,0,sizeof(struct NewWindow));

		/* Fill in the new window definition. */

	NewWindow . Width	= Screen -> Width;
	NewWindow . Height	= Screen -> Height - SCREEN_MARGIN;
	NewWindow . LeftEdge	= 0;
	NewWindow . TopEdge	= SCREEN_MARGIN;
	NewWindow . DetailPen	= 1;
	NewWindow . BlockPen	= 0;
	NewWindow . IDCMPFlags	= IDCMP_RAWKEY | IDCMP_NEWSIZE;
	NewWindow . Flags	= WFLG_RMBTRAP | WFLG_ACTIVATE | WFLG_BORDERLESS | WFLG_BACKDROP;
	NewWindow . MinWidth	= NewWindow . Width;
	NewWindow . MinHeight	= NewWindow . Height;
	NewWindow . MaxWidth	= NewWindow . Width;
	NewWindow . MaxHeight	= NewWindow . Height;
	NewWindow . Screen	= Screen;
	NewWindow . Type	= CUSTOMSCREEN;

		/* Open the window. */

	if(!(Window = (struct Window *)OpenWindow(&NewWindow)))
		fatal("Could not open window");

		/* Create the console write request. */

	if(!(ConRequest = (struct IOStdReq *)AllocMem(sizeof(struct IOStdReq),MEMF_ANY|MEMF_CLEAR)))
		fatal("No console request");

	if(!(InputEventBuffer = (STRPTR)AllocMem(INPUT_LENGTH,MEMF_ANY)))
		fatal("No input event buffer");

	if(!(InputEvent = (struct InputEvent *)AllocMem(sizeof(struct InputEvent),MEMF_ANY|MEMF_CLEAR)))
		fatal("No input event");

	if(OpenDevice("console.device",CONU_LIBRARY,ConRequest,NULL))
		fatal("No console.device");

	ConsoleDevice = ConRequest -> io_Device;

	WindowWidth = Window -> Width;

		/* Obtain rastport pointer. */

	RPort = Window -> RPort;

		/* Set text rendering mode. */

	SetAPen(RPort,ConFgPen = 1);
	SetBPen(RPort,ConBgPen = 0);

	SetDrMd(RPort,JAM2);

	PropFont	= Window -> WScreen -> RastPort . Font;
	FixedFont	= Window -> IFont;

	if(FixedFont -> tf_YSize != PropFont -> tf_YSize || h_type > 3)
		PropFont = FixedFont;

		/* Obtain the system default font dimensions. */

	TextFontHeight = FixedFont -> tf_YSize;

	SetFont(RPort,FixedFont);

		/* Look for the widest glyph. */

	for(Char = ' ' ; Char <= '~' ; Char++)
	{
		if((Width = ConCharWidth(Char)) > TextFontWidth)
			TextFontWidth = Width;

		TextFontAverage += Width;
	}

	SetFont(RPort,ThisFont = PropFont);

		/* Look for the widest glyph. */

	for(Char = ' ' ; Char <= '~' ; Char++)
	{
		if((Width = ConCharWidth(Char)) > TextFontWidth)
			TextFontWidth = Width;

		TextFontAverage += Width;
	}

	TextFontAverage /= (2 * ('~' - ' ' + 1));

		/* Determine screen dimensions. */

	if(h_type > 3)
		screen_cols = Window -> Width / TextFontWidth;
	else
		screen_cols = Window -> Width;

	screen_rows = Window -> Height / TextFontHeight;

		/* Determine maximum cached line length. */

	ConLineMaxLength = screen_cols * TextFontWidth;

		/* Determine minimum number of characters to fit into a single line. */

	ConLineMinLength = Window -> Width / TextFontWidth;

		/* Allocate memory for line cache. */

	if(!(ConLine = (char *)AllocMem(ConLineMaxLength,NULL)))
		fatal("Not enough memory for line cache");

		/* Clear the screen and turn off the cursor. */

	clear_screen();

		/* Display startup message. */

	Len = strlen(TheStory);

	Move(RPort,(Window -> Width - TextLength(RPort,(STRPTR)TheStory,Len)) / 2,(Window -> Height - ThisFont -> tf_YSize) / 2 + ThisFont -> tf_Baseline);
	Text(RPort,(STRPTR)TheStory,Len);

	NewWidth = OldWidth = TextFontAverage;

		/* Start the timer. */

	TimeRequest -> tr_node . io_Command	= TR_ADDREQUEST;
	TimeRequest -> tr_time . tv_secs	= 0;
	TimeRequest -> tr_time . tv_micro	= SECOND / 2;

	BeginIO(TimeRequest);

		/* Fill in new default window pointer. */

	ThisProcess -> pr_WindowPtr = (APTR)Window;

		/* Bring the new screen to the front. */

	ScreenToFront(Screen);
}

	/* restart_screen():
	 *
	 *	Reset the screen status to defaults.
	 */

VOID
restart_screen()
{
	set_attribute(NORMAL);

	clear_screen();
}

	/* reset_screen():
	 *
	 *	Restore original screen contents, in our case we will have to
	 *	free all the resources allocated by initialize_screen.
	 */

VOID
reset_screen()
{
		/* Wait for key to be pressed. */

	if(Window)
	{
		ConPrintf("Press any key to exit.");

		input_character();
	}

		/* Free the console request. */

	if(ConRequest)
	{
			/* Did we open the device? If so, close it. */

		if(ConRequest -> io_Device)
			CloseDevice(ConRequest);

			/* Free the memory. */

		FreeMem(ConRequest,sizeof(struct IOStdReq));
	}

		/* Free the input conversion buffer. */

	if(InputEventBuffer)
		FreeMem(InputEventBuffer,INPUT_LENGTH);

		/* Free the fake inputevent. */

	if(InputEvent)
		FreeMem(InputEvent,sizeof(struct InputEvent));

		/* Free timer data. */

	if(TimeRequest)
	{
		if(TimeRequest -> tr_node . io_Device)
		{
			if(!CheckIO(TimeRequest))
				AbortIO(TimeRequest);

			WaitIO(TimeRequest);

			CloseDevice(TimeRequest);
		}

		DeleteExtIO(TimeRequest);
	}

	if(TimePort)
		DeletePort(TimePort);

		/* Free line cache. */

	if(ConLine)
		FreeMem(ConLine,ConLineMaxLength);

		/* Close the window. */

	if(Window)
	{
		ScreenToBack(Screen);

		CloseWindow(Window);
	}

		/* Close the screen. */

	if(Screen)
	{
		ScreenToBack(Screen);

		CloseScreen(Screen);
	}

		/* Close libraries. */

	if(IconBase)
		CloseLibrary(IconBase);

	if(GfxBase)
		CloseLibrary(GfxBase);

	if(IntuitionBase)
		CloseLibrary(IntuitionBase);

		/* Free sound resources. */

	SoundExit();

		/* Restore window pointer. */

	if(ThisProcess)
		ThisProcess -> pr_WindowPtr = WindowPtr;

#ifdef __GNUC__

	{
		sigset_t trapped = TRAPPED_SIGNALS;

		sigprocmask(SIG_UNBLOCK,&trapped,NULL);
	}

#endif	/* __GNUC__ */
}

	/* clear_screen():
	 *
	 *	Clear the entire screen.
	 */

VOID
clear_screen()
{
		/* Clear character cache. */

	ConLineLength = 0;

	if(CursorState)
	{
		ConCursorOff();

		SetAPen(RPort,0);
		RectFill(RPort,0,0,Window -> Width - 1,Window -> Height - 1);
		SetAPen(RPort,ConFgPen);

		ConCursorOn(CURSOR_NOCHANGE);
	}
	else
	{
		SetAPen(RPort,0);
		RectFill(RPort,0,0,Window -> Width - 1,Window -> Height - 1);
		SetAPen(RPort,ConFgPen);
	}

		/* Move to bottom line. */

	ConSet(0,(screen_rows - 1) * TextFontHeight,CURSOR_NOCHANGE);
}

	/* print_status(int argc,char **argv):
	 *
	 *	Print the status line (type 3 games only).
	 *
	 *	argv[0] : Location name
	 *	argv[1] : Moves/Time
	 *	argv[2] : Score
	 *
	 *	Depending on how many arguments are passed to this routine
	 *	it is to print the status line. The rendering attributes
	 *	and the status line window will be have been activated
	 *	when this routine is called. It is to return FALSE if it
	 *	cannot render the status line in which case the interpreter
	 *	will use display_char() to render it on its own.
	 *
	 *	This routine has been provided in order to support
	 *	proportional-spaced fonts.
	 */

int
print_status(int argc,char *argv[])
{
	STATIC UBYTE	RightBuffer[170];

	STRPTR		Left,
			Right;
	LONG		LeftWidth,
			RightWidth;
	WORD		LeftLen,
			RightLen;

		/* Are we to change the font? */

	if(get_word(H_FLAGS) & FIXED_FONT_FLAG)
	{
		if(ThisFont != FixedFont)
			SetFont(RPort,ThisFont = FixedFont);
	}
	else
	{
		if(ThisFont != PropFont)
			SetFont(RPort,ThisFont = PropFont);
	}

		/* Set up the status bar, we will put both the
		 * score and the moves on the left hand side
		 * if present.
		 */

	switch(argc)
	{
		case 0:	Left	= "";
			Right	= "";
			break;

		case 1:	Left	= argv[0];
			Right	= "";
			break;

		case 2:	Left	= argv[0];
			Right	= argv[1];

			break;

		case 3:	strcpy(RightBuffer,argv[1]);
			strcat(RightBuffer,"  ");
			strcat(RightBuffer,argv[2]);

			Left	= argv[0];
			Right	= RightBuffer;

			break;
	}

		/* Determine lengths of both strings. */

	LeftLen		= strlen(Left);
	RightLen	= strlen(Right);

		/* Determine pixel widths of both strings. */

	LeftWidth	= TextLength(RPort,Left,LeftLen);
	RightWidth	= TextLength(RPort,Right,RightLen);

		/* Fill in the space in between. */

	SetAPen(RPort,ConBgPen);
	RectFill(RPort,LeftWidth,0,Window -> Width - RightWidth - 1,ThisFont -> tf_YSize - 1);
	SetAPen(RPort,ConFgPen);

		/* Print the left hand side text. */

	Move(RPort,0,ThisFont -> tf_Baseline);
	Text(RPort,Left,LeftLen);

		/* Print the right hand side text. */

	Move(RPort,Window -> Width - RightWidth,ThisFont -> tf_Baseline);
	Text(RPort,Right,RightLen);

		/* Return success. */

	return(TRUE);
}

	/* select_status_window():
	 *
	 *	Move the cursor into the status bar area.
	 */

VOID
select_status_window()
{
	ConFlush();

	save_cursor_position();

	ConSet(0,0,CURSOR_NOCHANGE);

	CurrentWindow = WINDOW_STATUS;
}

	/* select_text_window():
	 *
	 *	Move the cursor into the text window area.
	 */

VOID
select_text_window()
{
	ConFlush();

	restore_cursor_position();

	CurrentWindow = WINDOW_TEXT;
}

	/* create_status_window():
	 *
	 *	Create the status window (not required by the Amiga
	 *	implementation).
	 */

VOID
create_status_window()
{
}

	/* delete_status_window():
	 *
	 *	Delete the status window (not required by the Amiga
	 *	implementation).
	 */

VOID
delete_status_window()
{
}

	/* clear_line():
	 *
	 *	Clear the contents of the current cursor line.
	 */

VOID
clear_line()
{
	ConFlush();

	ConSet(0,CursorY,CURSOR_NOCHANGE);

	ConClearEOL();
}

	/* clear_text_window():
	 *
	 *	Clear the entire text window, don't touch the status
	 *	bar area.
	 */

VOID
clear_text_window()
{
	ConFlush();

	if(CursorState)
	{
		ConCursorOff();

		SetAPen(RPort,0);
		RectFill(RPort,0,status_size * TextFontHeight,Window -> Width - 1,(screen_rows - status_size) * TextFontHeight - 1);
		SetAPen(RPort,ConFgPen);

		ConCursorOn(CURSOR_NOCHANGE);
	}
	else
	{
		SetAPen(RPort,0);
		RectFill(RPort,0,status_size * TextFontHeight,Window -> Width - 1,(screen_rows - status_size) * TextFontHeight - 1);
		SetAPen(RPort,ConFgPen);
	}
}

	/* clear_status_window():
	 *
	 *	Clear the status bar area.
	 */

VOID
clear_status_window()
{
	ConFlush();

	if(CursorState)
	{
		ConCursorOff();

		SetAPen(RPort,0);
		RectFill(RPort,0,0,Window -> Width - 1,status_size * TextFontHeight - 1);
		SetAPen(RPort,ConFgPen);

		ConCursorOn(CURSOR_NOCHANGE);
	}
	else
	{
		SetAPen(RPort,0);
		RectFill(RPort,0,0,Window -> Width - 1,status_size * TextFontHeight - 1);
		SetAPen(RPort,ConFgPen);
	}
}

	/* save_cursor_position():
	 *
	 *	Save the current cursor position.
	 */

VOID
save_cursor_position()
{
	if(!SavedCursor)
	{
		SavedX		= CursorX;
		SavedY		= CursorY;
		SavedCursor	= TRUE;
	}
}

	/* restore_cursor_position():
	 *
	 *	Restore the previously saved cursor position.
	 */

VOID
restore_cursor_position()
{
	if(SavedCursor)
	{
		ConSet(SavedX,SavedY,CURSOR_NOCHANGE);

		SavedCursor = FALSE;
	}
}

	/* move_cursor(int row,int col):
	 *
	 *	Move the cursor to a given position.
	 */

VOID
move_cursor(int row,int col)
{
	ConFlush();

	ConSet((col - 1) * TextFontWidth,(row - 1) * TextFontHeight,CURSOR_NOCHANGE);
}

	/* set_attribute(int attribute):
	 *
	 *	Set a text rendering attribute.
	 */

VOID
set_attribute(int attribute)
{
	ConFlush();

	switch(attribute)
	{
			/* Reversed character/cell colours */

		case REVERSE:		if(ConFgPen != 0)
					{
						SetAPen(RPort,ConFgPen = 0);
						SetBPen(RPort,ConBgPen = 1);
					}

					break;

			/* Boldface */

		case BOLD:		SetSoftStyle(RPort,FSF_BOLD,AskSoftStyle(RPort));

					if(ConFgPen != 1)
					{
						SetAPen(RPort,ConFgPen = 1);
						SetBPen(RPort,ConBgPen = 0);
					}

					break;

			/* Italics */

		case BLINK:		SetSoftStyle(RPort,FSF_ITALIC,AskSoftStyle(RPort));

					if(ConFgPen != 1)
					{
						SetAPen(RPort,ConFgPen = 1);
						SetBPen(RPort,ConBgPen = 0);
					}

					break;

			/* Underlined */

		case UNDERSCORE:	SetSoftStyle(RPort,FSF_UNDERLINED,AskSoftStyle(RPort));

					if(ConFgPen != 1)
					{
						SetAPen(RPort,ConFgPen = 1);
						SetBPen(RPort,ConBgPen = 0);
					}

					break;

			/* Default (= Reset) */

		default:		SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));

					if(ConFgPen != 1)
					{
						SetAPen(RPort,ConFgPen = 1);
						SetBPen(RPort,ConBgPen = 0);
					}

					break;
	}

		/* Remember current attribute. */

	CurrentAttribute = attribute;
}

	/* fit_line(const char *line,int pos,int max):
	 *
	 *	This routine determines whether a line of text will still fit
	 *	on the screen.
	 *
	 *	line : Line of text to test.
	 *	pos  : Length of text line (in characters).
	 *	max  : Maximum number of characters to fit on the screen.
	 */

int
fit_line(const char *line,int pos,int max)
{
		/* For type 4 games just compare the current and maximum line width. */

	if(h_type > 3)
		return(pos < max);
	else
	{
		if(pos > ConLineMinLength)
		{
			if(get_word(H_FLAGS) & FIXED_FONT_FLAG)
			{
				if(ThisFont != FixedFont)
				{
					ConFlush();

					SetFont(RPort,ThisFont = FixedFont);
				}
			}
			else
			{
				if(ThisFont != PropFont)
				{
					ConFlush();

					SetFont(RPort,ThisFont = PropFont);
				}
			}

			return(TextLength(RPort,(STRPTR)line,pos) + TextFontWidth < Window -> Width);
                }
		else
			return(TRUE);
	}
}

	/* display_char(int c):
	 *
	 *	Display a single character (characters are cached in
	 *	order to speed up text display).
	 */

VOID
display_char(int c)
{
	if(get_word(H_FLAGS) & FIXED_FONT_FLAG)
	{
		if(ThisFont != FixedFont)
		{
			ConFlush();

			SetFont(RPort,ThisFont = FixedFont);
		}
	}
	else
	{
		if(ThisFont != PropFont)
		{
			ConFlush();

			SetFont(RPort,ThisFont = PropFont);
		}
	}

	if(c >= ' ')
	{
			/* Cache the character. */

		ConLine[ConLineLength] = c;

			/* If the line cache is full, flush it. */

		if(ConLineLength++ == ConLineMaxLength)
			ConFlush();
	}
	else
	{
		ConFlush();

		switch(c)
		{
			case '\n':	ConSet(0,CursorY + TextFontHeight,CURSOR_NOCHANGE);
					break;

			case '\r':	ConSet(0,CursorY,CURSOR_NOCHANGE);
					break;

			case '\a':	DisplayBeep(Window -> WScreen);
					break;

			default:	break;
		}
	}
}

	/* fatal(const char *s):
	 *
	 *	Display a fatal error message.
	 */

VOID
fatal(const char *s)
{
	ConFlush();

		/* If the console window is available, print the message
		 * into it, else send it to the shell window.
		 */

	if(Window)
		ConPrintf("Fatal error: %s",s);
	else
	{
		if(!WBenchMsg)
			printf("\nFatal error: %s\a\n",s);
	}

	reset_screen();

	exit(RETURN_ERROR);
}

	/* input_character():
	 *
	 *	Input a single character.
	 */

char
input_character()
{
	register UBYTE	Char;
	register BYTE	Done = FALSE;

	ConFlush();

	ConCursorOn(CURSOR_AVERAGE);

	do
	{
		switch(Char = ConGetChar(TRUE))
		{
				/* If it's a suitable character, terminate input. */

			case '\b':
			case '\r':	Done = TRUE;
					break;

			default:	if(Char >= 32 && Char < 127)
						Done = TRUE;

					break;
		}
	}
	while(!Done);

		/* Turn off the cursor. */

	ConCursorOff();

	return((char)Char);
}

	/* input_line():
	 *
	 *	Input a single line.
	 */

VOID
input_line()
{
	STATIC char Prompt[140];

	if(ConLineLength)
	{
		memcpy(Prompt,ConLine,ConLineLength);

		Prompt[ConLineLength] = 0;
	}
	else
		Prompt[0] = 0;

	ConFlush();

		/* Read a line of text, input[0] = maximum length,
		 * input[1] = number of characters read.
		 */

	input[1] = ConInput(Prompt,&input[2],input[0],TRUE);

		/* Turn off the cursor. */

	ConCursorOff();

	scroll_line();
}

	/* scroll_line():
	 *
	 *	Scroll the text area one line up.
	 */

VOID
scroll_line()
{
	ConFlush();

	ConScrollUp();
}

	/* process_arguments(int argc, char *argv[]):
	 *
	 *	Do any argument preprocessing necessary before the game is
	 *	started. This may include selecting a specific game file or
	 *	setting interface-specific options.
	 */

void
process_arguments(int argc, char *argv[])
{
	int Len;

	if(argc > 1)
	{
		if(!strcmp(argv[1],"?"))
		{
			printf("Usage: %s [Story file name] [Saved game file name]\n",argv[0]);

			exit(RETURN_WARN);
		}
		else
			StoryName = argv[1];

		if(argc > 2)
			restore_name = argv[2];
	}
	else
		StoryName = "Story.Data";

	if(argc)
		InterpreterName = argv[0];
	else
	{
		WBenchMsg = (struct WBStartup *)argv;

		InterpreterName = WBenchMsg -> sm_ArgList[0] . wa_Name;

		if(IconBase = OpenLibrary("icon.library",LIB_VERSION))
		{
			struct DiskObject *Icon;

			if(Icon = GetDiskObject(InterpreterName))
			{
				char	 Buffer[5],
					*Type;
				int	 i;

					/* Does it have a filetype info attached? */

				if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"STORY"))
				{
					if(StoryName = (STRPTR)malloc(strlen(Type) + 1))
						strcpy(StoryName,Type);
					else
						StoryName = "Story.Data";
				}

					/* Check for function key
					 * defintions and set them
					 * if approriate.
					 */

				for(i = 0 ; i < NUM_FKEYS ; i++)
				{
						/* Build fkey string. */

					sprintf(Buffer,"F0%2d",i + 1);

						/* See if we can find it. */

					if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,Buffer))
						ConSetKey(i,Type,strlen(Type));
					else
						ConSetKey(i,"",0);
				}

					/* Free the icon. */

				FreeDiskObject(Icon);
			}

			if(WBenchMsg -> sm_NumArgs > 1)
			{
				char	*Type;
				int	 i;

				for(i = 0 ; i < WBenchMsg -> sm_NumArgs ; i++)
				{
					CurrentDir(WBenchMsg -> sm_ArgList[i] . wa_Lock);

					if(Icon = GetDiskObject(WBenchMsg -> sm_ArgList[i] . wa_Name))
					{
						/* Does it have a filetype info attached? */

						if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FILETYPE"))
						{
							/* Is it a bookmark file? */

							if(MatchToolValue(Type,"BOOKMARK") && MatchToolValue(Type,"ZIP"))
							{
								restore_name = WBenchMsg -> sm_ArgList[i] . wa_Name;

								if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"STORY"))
								{
									BPTR File;

										/* Try to open the file, this is
										 * easier than locking it, allocating
										 * a fileinfo, reading it and then
										 * to clean up again.
										 */

									if(File = Open(Type,MODE_OLDFILE))
									{
										char *NewName;

										Close(File);

										if(NewName = (STRPTR)malloc(strlen(Type) + 1))
										{
											strcpy(NewName,Type);

											StoryName = NewName;
										}
									}
								}

								FreeDiskObject(Icon);
								break;
							}

							if(MatchToolValue(Type,"STORY"))
							{
								BPTR File;

									/* Try to open the file, this is
									 * easier than locking it, allocating
									 * a fileinfo, reading it and then
									 * to clean up again.
									 */

								if(File = Open(WBenchMsg -> sm_ArgList[i] . wa_Name,MODE_OLDFILE))
								{
									char *NewName;

									Close(File);

									if(NewName = (STRPTR)malloc(strlen(WBenchMsg -> sm_ArgList[i] . wa_Name) + 1))
									{
										strcpy(NewName,WBenchMsg -> sm_ArgList[i] . wa_Name);

										StoryName = NewName;
									}
								}

								FreeDiskObject(Icon);
								break;
							}
						}

							/* Free the icon. */

						FreeDiskObject(Icon);
					}
				}
			}

			CloseLibrary(IconBase);

			IconBase = NULL;
		}
	}

	open_story(StoryName);

	Len = strlen(StoryName);

		/* Make a copy of the game name. */

	if(SoundName = malloc(Len + 40))
	{
		strcpy(SoundName,StoryName);

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
}

	/* file_cleanup(const char *file_name, int flag):
	 *
	 *	Perform certain actions after a game file is saved (flag = 1)
	 *	or restored (flag = 0).
	 */

void
file_cleanup(const char *file_name, int flag)
{
		/* Was the file saved or restored? */

	if(flag == GAME_SAVE)
	{
			/* Clear the `executable' bit. */

		SetProtection((char *)file_name,FIBF_EXECUTE);

		if(IconBase)
		{
			struct DiskObject *Icon;

				/* Get the default icon. */

			if(Icon = GetDiskObject("Icon.Data"))
			{
				char **ToolTypes;

					/* Create the tool type array. */

				if(ToolTypes = (char **)malloc(sizeof(char *) * (NUM_FKEYS + 3)))
				{
					int i,j = 0;

						/* Fill in the file type. */

					ToolTypes[j++] = "FILETYPE=BOOKMARK|ZIP";

						/* Add the story file name. */

					if(ToolTypes[j] = malloc(strlen(StoryName) + 7))
						sprintf(ToolTypes[j++],"STORY=%s",StoryName);

						/* Add the function key definitions if any. */

					for(i = 0 ; i < NUM_FKEYS ; i++)
					{
						if(FunctionKeys[i] . Len)
						{
							if(ToolTypes[j] = malloc(FunctionKeys[i] . Len + 5))
								sprintf(ToolTypes[j++],"F%02d=%s",i + 1,FunctionKeys[i] . Buffer);
						}
					}

						/* Terminat the tool type array. */

					ToolTypes[j] = NULL;

						/* Fill in the icon data. */

					Icon -> do_DefaultTool	= InterpreterName;
					Icon -> do_ToolTypes	= ToolTypes;
					Icon -> do_StackSize	= ThisProcess -> pr_StackSize;
					Icon -> do_CurrentX	= NO_ICON_POSITION;
					Icon -> do_CurrentY	= NO_ICON_POSITION;

						/* Create the icon. */

					if(!PutDiskObject((char *)file_name,Icon))
						output_stringnl("[Error creating icon file]");

						/* Free the tool type entries. */

					for(i = 1 ; i < j ; i++)
						free(ToolTypes[i]);

						/* Free the tool type array. */

					free(ToolTypes);
				}

					/* Free the icon. */

				FreeDiskObject(Icon);
			}
			else
				output_stringnl("[No icon]");
		}
		else
			output_stringnl("[No icon]");
	}

	if(flag == GAME_RESTORE)
	{
		if(IconBase)
		{
			struct DiskObject *Icon;

				/* Get the file icon. */

			if(Icon = GetDiskObject((char *)file_name))
			{
				char	 Buffer[5],
					*Type;
				int	 i;

					/* Does it have a filetype info attached? */

				if(Type = FindToolType((STRPTR *)Icon -> do_ToolTypes,"FILETYPE"))
				{
						/* Is it a bookmark file? */

					if(MatchToolValue(Type,"BOOKMARK") && MatchToolValue(Type,"ZIP"))
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

					/* Free the icon. */

				FreeDiskObject(Icon);
			}
			else
				output_stringnl("[No icon]");
		}
		else
			output_stringnl("[No icon]");
	}
}

	/* sound(int argc, zword_t * argv):
	 *
	 *	Replay a sound file or just a bell (^G) signal:
	 *
	 *	argc = 1: Play bell signal.
	 *
	 *	argc = 2: argv[0] = 0
	 *	          argv[1] = 3
	 *
	 *	          Stop playing current sound.
	 *
	 *	argc = 2: argv[0] = 0
	 *	          argv[1] = 4
	 *
	 *	          Free allocated resources.
	 *
	 *	argc = 3: argv[0] = ID# of sound file to replay.
	 *	          argv[1] = 2
	 *	          argv[2] = Volume to replay sound with, this value
	 *	                    can range between 1 and 8.
	 */

void
sound(int argc, zword_t * argv)
{
	if(argc == 1)
	{
		int Count = argv[0];

		while(Count--)
		{
			DisplayBeep(Window -> WScreen);

			if(Count)
				Delay(TICKS_PER_SECOND / 2);
		}
	}
	else
	{
			/* Is the sound name buffer available? */

		if(SoundName)
		{
			register BOOL GotSound;

				/* What are we to do next? */

			switch(argv[1])
			{
					/* If a new sound is to be replayed, stop
					 * the current sound.
					 */

				case 2:	if(argv[0] != SoundNumber && SoundNumber != -1 && SoundControlRequest)
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

						if(SoundNumber == argv[0] && SoundNumber != -1)
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
								SoundControlRequest -> ioa_Volume		= argv[2] * 8;

									/* Tell the device to make the change. */

								SendIO((struct IORequest *)SoundControlRequest);
								WaitIO((struct IORequest *)SoundControlRequest);
							}
							else
							{
									/* Wait for requests to return. */

								SoundAbort();

									/* Set up new volume. */

								SoundRequestLeft  -> ioa_Volume = argv[2] * 8;
								SoundRequestRight -> ioa_Volume = argv[2] * 8;

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

								/* Cancel the argv[0] of the previously loaded
								 * sound in case the load fails.
								 */

							SoundNumber = -1;

								/* Set up the sound file name. */

							sprintf(SoundPath,"sound/s%d.dat",argv[0]);

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
												 * sensible argv[0].
												 */

											ULONG Rate = (GfxBase -> DisplayFlags & PAL ? 3546895 : 3579545) / ((((UWORD)SoundHeader . Rate[1]) << 8) | SoundHeader . Rate[0]);

												/* Set up the left channel. */

											SoundRequestLeft -> ioa_Request . io_Command	= CMD_WRITE;
											SoundRequestLeft -> ioa_Request . io_Flags	= ADIOF_PERVOL;
											SoundRequestLeft -> ioa_Period			= Rate;
											SoundRequestLeft -> ioa_Volume			= argv[2] * 8;
											SoundRequestLeft -> ioa_Cycles			= SoundHeader . Times;
											SoundRequestLeft -> ioa_Data			= SoundData;
											SoundRequestLeft -> ioa_Length			= SoundLength;

												/* Set up the right channel. */

											SoundRequestRight -> ioa_Request . io_Command	= CMD_WRITE;
											SoundRequestRight -> ioa_Request . io_Flags	= ADIOF_PERVOL;
											SoundRequestRight -> ioa_Period			= Rate;
											SoundRequestRight -> ioa_Volume			= argv[2] * 8;
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

												/* Remember the argv[0] of the current sound. */

											SoundNumber = argv[0];
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

					/* Free resources. */

				case 3:	SoundExit();

					break;
			}
		}
	}
}

	/* get_file_name(char *file_name, char *default_name, int flag):
	 *
	 *	Return the name of a file. Flag can be one of: GAME_SAVE, GAME_RESTORE or
	 *	GAME_SCRIPT.
	 */

int
get_file_name(char *file_name, char *default_name, int flag)
{
	int	 saved_scripting_disable = scripting_disable,
		 columns = (screen_cols > 127) ? 127 : screen_cols,
		 status = TRUE;
	FILE	*tfp;
	char	 c;

	if(!default_name[0])
	{
		if(flag == GAME_SCRIPT)
			strcpy(default_name,"PRT:");
		else
			strcpy(default_name,"Story.Save");
	}

	scripting_disable = ON;

	output_stringnl("Enter a file name.");
	output_string("(Default is \"");
	output_string(default_name);
	output_string("\") >");

	input[0] = (char) (columns - RIGHT_MARGIN - 1 - sizeof("(Default is \"") - strlen(default_name) - sizeof("\"): "));

	input_line();

	if(input[1])
	{
		input[input[1] + 2] = '\0';

		strcpy(file_name, &input[2]);
	}
	else
		strcpy(file_name, default_name);

	if(flag)
	{
		if(tfp = fopen(file_name,"r"))
		{
			fclose(tfp);

			output_string("You are about to write over an existing file.  Proceed? (Y/N) >");

			do
				c = input_character();
			while(toupper(c) != 'Y' && toupper(c) != 'N');

			display_char(c);

			scroll_line();

			if(c == 'N')
				status = FALSE;
		}
	}

	scripting_disable = saved_scripting_disable;

	return(status);
}
