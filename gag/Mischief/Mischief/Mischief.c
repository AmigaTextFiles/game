/* Mischief.c ***************************************************************
*
*	Mischief ------	Strange things happening with your Amiga.
*
*			In the spirit of display hacks, you should
*			not continue reading this document unless
*			you really wish to know what this program
*			does. So STOP now.
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*			Thank you for reading this document. When I was
*			experimenting with the input.device I discovered
*			some useful methods of controlling the input
*			device as well as some interesting approaches
*			to raw key conversion. Mischief is a playful
*			approach to the 'stern' character of the Amiga
*			resource/library/device system. This program
*			fools the user with events such as:
*
*			o Reversing the use of the mouse buttons.
*
*			o Reversing the direction of mouse moves.
*
*			o Feeding random characters into the
*			  input stream instead of the characters
*			  the user types.
*
*			o Closing the window under the mouse pointer
*			  (only if it has a close gadget).
*
*			o Making the screen sink.
*
*			o Pretending to be the GURU.
*
*			None of these events have a destructive
*			character but you should drop the window
*			you are dragging around as soon as the
*			screen sinks. Moving the screen does not
*			affect the placement of the mouse pointer
*			so it might be possible that Intuition
*			tries to render the outline of the window
*			in a place where there is no screen (CRASH!).
*
*	Author --------	Olaf Barthel, ED Electronic Design Hannover
*			Brabeckstrasse 35
*			D-3000 Hannover 71
*
*			Federal Republic of Germany
*
****************************************************************************/

#include <intuition/intuitionbase.h>
#include <devices/inputevent.h>
#include <graphics/gfxbase.h>
#include <exec/interrupts.h>
#include <devices/input.h>
#include <devices/audio.h>
#include <exec/memory.h>

	/* Some external definitions. */

extern struct MsgPort	*CreatePort();
extern struct MsgPort	*FindPort();
extern struct Message	*GetMsg();
extern struct IOStdReq	*CreateStdIO();
extern void		*AllocMem();
extern struct Library	*OpenLibrary();
extern struct IOAudio	*DoAnything();
extern struct Layer	*WhichLayer();

	/* The libraries we need. */

struct IntuitionBase	*IntuitionBase;
struct GfxBase		*GfxBase;
struct Library		*LayersBase;

	/* The input.device handling stuff. */

struct InputEvent	CopyEvent;
struct MsgPort		*InputDevPort;
struct IOStdReq		*InputRequestBlock;
struct Interrupt	HandlerStuff;
struct MemEntry		Mem[10];

	/* The modes we are in. */

short			WeAreInMode;
BOOL			HasAnythingChanged = FALSE;
BOOL			LastModeWas = -1;
struct IOAudio		*Laughter;

	/* Detach definitions. */

long  _stack		= 8000;
long  _priority		= 0;
long  _BackGroundIO	= 0;
char *_procname		= "I'll get you!";

	/* Assembler interface to intercept input events before
	 * Intuition gets them.
	 */

extern void Handler();

#asm
_Handler:	MOVEM.L	A4,-(A7)	; Preserve a register
		MOVEM.L	A0/A1,-(A7)	; Move the data we need

		JSR	_geta4#		; Set up code register (AZTEC)
		JSR	_MyHandler	; Manipulate the data

		ADDQ.L	#8,A7		; Correct stack

		MOVEM.L	(A7)+,A4	; Restore a register

		RTS			; Continue with the list...
#endasm

	/* DoRandom(Code) :
	 *
	 *	Try to find a random character the handler interface
	 *	will feed into the input stream.
	 */

USHORT
DoRandom(Code)
USHORT Code;
{
	short Length = 0,Start;

		/* The following if(...) calls will try
		 * to feed only characters into the stream
		 * which can be found in the same
		 * keyboard row.
		 */

	if(Code >= 0 && Code <= 13)
	{
		Start	= 0;
		Length	= 14;
	}

	if(Code >= 16 && Code <= 27)
	{
		Start	= 16;
		Length	= 12;
	}

	if(Code >= 32 && Code <= 43)
	{
		Start	= 32;
		Length	= 12;
	}

	if(Code >= 48 && Code <= 59)
	{
		Start	= 48;
		Length	= 12;
	}

	if(Length)
		Code = 48 + RangeRand(Length);

	return(Code);
}

	/* MyHandler(Event,OtherData) :
	 *
	 *	Just like any interrupt routine this handler receives
	 *	pointers to interrupt structures and MemEntry
	 *	structures.
	 */

struct InputEvent *
MyHandler(Event,OtherData)
struct InputEvent *Event;
struct MemEntry *OtherData[];
{
	struct InputEvent *EventPtr, *LastEvent;
	USHORT CodeIs;

		/* Tracing the chain of events, try to figure out if
		 * there is anything interesting for us.
		 *
		 * This part of code was borrowed from John Toebes'
		 * PopCLI program.
		 */

	for(EventPtr = Event, LastEvent = NULL ; EventPtr != NULL ; EventPtr = EventPtr -> ie_NextEvent)
	{
		if(EventPtr -> ie_Class == IECLASS_RAWKEY)
		{
				/* If it's a raw key event and we are in
				 * mode 2 we will feed a random character
				 * into the stream.
				 */

			if(WeAreInMode == 2)
			{
					/* Mask out UP_PREFIX */

				CodeIs = EventPtr -> ie_Code & 0x7F;

					/* Clear original character
					 * code.
					 */

				EventPtr -> ie_Code &= ~CodeIs;
				EventPtr -> ie_Code |= DoRandom(CodeIs);

					/* Make him laugh. */

				if(LastModeWas != 2)
				{
					LastModeWas = 2;
					HasAnythingChanged = TRUE;
				}
			}
		}
		else
			LastEvent = EventPtr;

		if(EventPtr -> ie_Class == IECLASS_RAWMOUSE)
		{
				/* If it's a raw mouse event and we
				 * are in mode 3 reverse the mouse
				 * moves.
				 */

			if(WeAreInMode == 3)
			{
				EventPtr -> ie_X = -EventPtr -> ie_X;
				EventPtr -> ie_Y = -EventPtr -> ie_Y;

				if(LastModeWas != 3)
				{
					LastModeWas = 3;
					HasAnythingChanged = TRUE;
				}
			}

			if(WeAreInMode == 4)
			{
					/* In mode 4 we will try to
					 * reverse the left and right
					 * mouse button. This works
					 * only with events coming
					 * in from the gameport.device.
					 * If the event comes from the
					 * keyboard.device input.device
					 * will take care of the
					 * transformation on its own and
					 * won't let us know about it.
					 */

				if((EventPtr -> ie_Code & 0x7F) == IECODE_LBUTTON)
				{
					EventPtr -> ie_Code &= ~IECODE_LBUTTON;
					EventPtr -> ie_Code |= IECODE_RBUTTON;

					if(LastModeWas != 4)
					{
						LastModeWas = 4;
						HasAnythingChanged = TRUE;
					}

					continue;
				}

				if((EventPtr -> ie_Code & 0x7F) == IECODE_RBUTTON)
				{
					EventPtr -> ie_Code &= ~IECODE_RBUTTON;
					EventPtr -> ie_Code |= IECODE_LBUTTON;

					if(LastModeWas != 4)
					{
						LastModeWas = 4;
						HasAnythingChanged = TRUE;
					}

					continue;
				}
			}
		}
	}

	return(Event);
}

	/* CloseIt(RetCode) :
	 *
	 *	Close anything there is to close and wave
	 *	goodbye.
	 */

void
CloseIt(RetCode)
long RetCode;
{
	CloseTimerDevice();

	if(InputRequestBlock)
	{
		CloseDevice(InputRequestBlock);
		DeleteStdIO(InputRequestBlock);
	}

	if(InputDevPort)
		DeletePort(InputDevPort);

	if(IntuitionBase)
		CloseLibrary(IntuitionBase);

	if(GfxBase)
		CloseLibrary(GfxBase);

	if(LayersBase)
		CloseLibrary(LayersBase);

	if(Laughter)
		FlushSound(Laughter);

	exit(RetCode);
}

	/* Save some bytes. */

void _cli_parse(){}
void _wb_parse(){}

void
main()
{
	struct Screen		*AnyScreen;	/* Make it sink. */
	struct Window		*AnyWindow;	/* Close it. */
	struct MsgPort		*ClosePort;	/* Are we active? */
	struct IntuiMessage	Massage;	/* Fake message. */
	BYTE			*LED = 0xBFE001;/* Power LED. */
	struct MsgPort		*MischiefPort,*ReplyPort;
	struct Message		WakeUp,*Terminate;
	struct Layer_Info	*LayerInfo;	/* Which window? */
	struct Layer		*Layer;

	LONG			MouseX,MouseY;	/* Pointer position. */

	long			i,j,WaitCount,ActiveCount;	/* Counters. */

		/* If we are already around, send the other task
		 * a message to close down.
		 */

	if(MischiefPort = (struct MsgPort *)FindPort("Mischief.port"))
	{
		if(!(ReplyPort = (struct MsgPort *)CreatePort(NULL,0)))
			exit(20);

		WakeUp . mn_Node . ln_Type	= NT_MESSAGE;
		WakeUp . mn_Length		= sizeof(struct Message);
		WakeUp . mn_ReplyPort		= ReplyPort;

		PutMsg(MischiefPort,&WakeUp);
		WaitPort(ReplyPort);

		DeletePort(ReplyPort);

		exit(0);
	}

		/* Open everything we need. */

	if(!(InputDevPort = CreatePort(NULL,0)))
		CloseIt(20);

	if(!(InputRequestBlock = CreateStdIO(InputDevPort)))
		CloseIt(20);

	if(!OpenTimerDevice())
		CloseIt(20);

	if(OpenDevice("input.device",0,InputRequestBlock,0))
		CloseIt(20);

	if(!(IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",0)))
		CloseIt(20);

	if(!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",0)))
		CloseIt(20);

	if(!(LayersBase = (struct Library *)OpenLibrary("layers.library",0)))
		CloseIt(20);

	if(!(Laughter = (struct IOAudio *)DoAnything()))
		CloseIt(20);

	if(!(MischiefPort = (struct MsgPort *)CreatePort("Mischief.port",0)))
		CloseIt(20);

		/* Tell input.device to insert our handler code at the
		 * top of the chain.
		 */

	HandlerStuff . is_Data		= (APTR)&Mem[0];
	HandlerStuff . is_Code		= Handler;
	HandlerStuff . is_Node . ln_Pri	= 51;

	InputRequestBlock -> io_Command	= IND_ADDHANDLER;
	InputRequestBlock -> io_Data	= (APTR)&HandlerStuff;

	DoIO(InputRequestBlock);

		/* Clear the copy of the input event. */

	CopyEvent . ie_TimeStamp . tv_secs	= 0;
	CopyEvent . ie_TimeStamp . tv_micro	= 0;
	CopyEvent . ie_Class			= 0;

		/* Initialize counters and prepare the sound. */

	WaitCount = 10 * (RangeRand(10) + 1);
	WeAreInMode = RangeRand(6);

	BeginIO(Laughter);
	WaitIO(Laughter);

	Laughter -> ioa_Volume = 64;

	FOREVER
	{
			/* Wait some time... */

		WaitTime(0,100000);

			/* Has anything change? Then laugh a bit. */

		if(HasAnythingChanged)
		{
			HearSound(Laughter);
			HasAnythingChanged = FALSE;
		}

			/* Any mail for us? */

		if(Terminate = (struct Message *)GetMsg(MischiefPort))
		{
			ReplyMsg(Terminate);
			DeletePort(MischiefPort);

				/* Give him a BIG smile... */

			Laughter -> ioa_Period *= 2;
			HearSound(Laughter);

			break;
		}

			/* Having done our mischievious work, we wait
			 * a moment.
			 */

		if(WaitCount > 0)
		{
			WaitCount--;
			ActiveCount = -1;

			continue;
		}

			/* If we are active, decrement the counter. */

		if(ActiveCount > 0)
		{
			ActiveCount--;
			WaitCount = -1;
		}
		else
		{
				/* Finished? Chose a new period and
				 * a new mode.
				 */

			if(!WaitCount)
			{
				WeAreInMode = RangeRand(6);
				ActiveCount = 10 * (RangeRand(10) + 1);
			}
			else
			{
				WaitCount = 10 * (RangeRand(10) + 1);
				ActiveCount = -1;

				continue;
			}
		}

			/* If we are in mode 0 let the active screen
			 * sink.
			 */

		if(WeAreInMode == 0)
		{
			if(LastModeWas != 0)
			{
				LastModeWas = 0;
				HearSound(Laughter);
			}

			AnyScreen = IntuitionBase -> ActiveScreen;
			MoveScreen(AnyScreen,0,1);
		}

			/* If we are in mode 1 we will try to
			 * close the window the pointer is
			 * "hovering" over. If this window
			 * doesn't have any close gadget we
			 * won't do anything.
			 */

		if(WeAreInMode == 1)
		{
			Forbid();

				/* Try to find the window under
				 * the mouse pointer.
				 */

			LayerInfo = &IntuitionBase -> ActiveScreen -> LayerInfo;

			LockLayerInfo(LayerInfo);

			MouseX = IntuitionBase -> ActiveScreen -> MouseX;
			MouseY = IntuitionBase -> ActiveScreen -> MouseY;

				/* Any layer under the pointer? */

			if(!(Layer = (struct Layer *)WhichLayer(LayerInfo,MouseX,MouseY)))
			{
				Permit();
				continue;
			}

			AnyWindow = (struct Window *)Layer -> Window;

			UnlockLayerInfo(LayerInfo);

			Permit();

				/* If it has a close gadget pretend
				 * we are the user who has hit
				 * it.
				 */

			if(AnyWindow -> Flags & WINDOWCLOSE)
			{
				if(ClosePort = CreatePort(NULL,0))
				{
					setmem(&Massage,sizeof(struct IntuiMessage),0);

						/* Let's pretend we are Intuition
						 * and are sending a CLOSEWINDOW
						 * message.
						 */

					Massage . ExecMessage . mn_Node . ln_Type	= NT_MESSAGE;
					Massage . ExecMessage . mn_Length		= sizeof(struct IntuiMessage);
					Massage . ExecMessage . mn_ReplyPort		= ClosePort;

					Massage . Class					= CLOSEWINDOW;
					Massage . IDCMPWindow				= AnyWindow;

						/* Put it where it belongs,
						 * and hope for a reply.
						 */

					PutMsg(AnyWindow -> UserPort,&Massage);
					WaitPort(ClosePort);

					DeletePort(ClosePort);

					if(LastModeWas != 1)
					{
						LastModeWas = 1;
						HasAnythingChanged = TRUE;
					}
				}
			}
		}

			/* If we are in mode 5 we freeze the machine
			 * and try to make the user believe a guru
			 * is soon to come.
			 */

		if(WeAreInMode == 5)
		{
			Forbid();

			for(i = 0 ; i < 4 ; i++)
			{
				*LED |= 2;
				for(j = 0 ; j < 90000 ; j++);

				*LED &= 253;
				for(j = 0 ; j < 90000 ; j++);
			}

			Permit();

			HasAnythingChanged = TRUE;

			WaitCount = 10 * (RangeRand(10) + 1);
			ActiveCount = -1;

			continue;
		}
	}

		/* Remove the handler. */

	InputRequestBlock -> io_Command	= IND_REMHANDLER;
	InputRequestBlock -> io_Data	= (APTR)&HandlerStuff;

	DoIO(InputRequestBlock);

	CloseIt(0);
}
