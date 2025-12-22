/*====================================================*/
/*																										*/
/* Sound a beep every time a key is pressed		V1.0		*/
/* © J.Tyberghein																			*/
/*		Tue Sep 26 10:16:00 1989 V1.0										*/
/*		Tue Dec 19 12:07:19 1989												*/
/*																										*/
/* compile with: (Lattice 5.0x)												*/
/*		lc -v -cms -O -j104 MusicGag										*/
/*		blink MusicGag.o lib lib:lc.lib									*/
/*				(no startupcode)														*/
/*																										*/
/*====================================================*/


#include <exec/types.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <devices/audio.h>
#include <devices/input.h>
#include <devices/inputevent.h>
#include <proto/exec.h>
#include <string.h>

#define VERSION				10

#define ERR_ALLOC			0
#define ERR_OPEN			1
#define ERR_CREATE		2

#define LEFT0F				1
#define RIGHT0F				2
#define RIGHT1F				4
#define LEFT1F				8

#define ESCAPEKEY			0x45

#define SBUFLEN				2048L					/* Sound buf length */

#pragma syscall AllocMem c6 1002
#pragma syscall FreeMem d2 902
#pragma syscall CloseLibrary 19e 901
#pragma syscall OpenDevice 1bc 190804
#pragma syscall CloseDevice 1c2 901
#pragma syscall CheckIO 1d4 901
#pragma syscall AbortIO 1e0 901
#pragma syscall OpenLibrary 228 902
#pragma syscall FindTask 126 901
#pragma syscall Wait 13e 1

#pragma libcall Device BeginIO 1e 901

/*================================ Data ======================================*/

APTR DOSBase;
#pragma libcall DOSBase Exit 90 101

/* Look for a left channel, then a right */
UBYTE AllocationMap[] = { LEFT0F,LEFT1F,RIGHT0F,RIGHT1F };

UBYTE *SoundBuf = NULL;					/* WaveForm Buffer */
struct IOAudio *id1 = NULL;
struct IOAudio *id2 = NULL;
struct IOAudio *id3 = NULL;
struct IOAudio *id4 = NULL;			/* Sound IDs */

typedef struct
	{
		struct Task *TaskToSig;
		ULONG QuitSig,QuitSigNum,ActionSig,ActionSigNum;
		LONG Rate;
	} GlobalDat;

GlobalDat Global;

struct MsgPort *InputDevPort = NULL;
struct IOStdReq *InputRequestBlock = NULL;

const char *PortName = "Sound Port";

struct InputEvent * __saveds __asm MyHandler
		(register __a0 struct InputEvent *,register __a1 GlobalDat *);
struct IOAudio *PlaySound (struct IOAudio *,UBYTE *,ULONG,WORD,WORD,WORD);
void SetIOA (WORD,WORD,WORD,ULONG,struct IOAudio **);
void CloseStuff (WORD);

/*================================ Code ======================================*/

/*---------------------------- Main program ----------------------------------*/

LONG __saveds myMain ()
{
	WORD i,Count,Div;
	ULONG sig;
	struct Interrupt HandlerStuff;
	LONG Rate;
	struct IOAudio *id;

	if (!(DOSBase = (APTR)OpenLibrary ("dos.library",0L))) return (100L);

	if (!(SoundBuf = (UBYTE *)AllocMem (SBUFLEN,MEMF_CHIP | MEMF_CLEAR)))
		CloseStuff (ERR_ALLOC);

	Div = SBUFLEN/125;
	for (i=0 ; i<SBUFLEN ; i++) SoundBuf[i] = (i%2) ? 127 : 127+(i-SBUFLEN)/Div;
	SetIOA ((WORD)(3579545L/4000),64,1,SBUFLEN,&id1);
	SetIOA ((WORD)(3579545L/4000),64,1,SBUFLEN,&id2);
	SetIOA ((WORD)(3579545L/4000),64,1,SBUFLEN,&id3);
	SetIOA ((WORD)(3579545L/4000),64,1,SBUFLEN,&id4);

	Global.QuitSigNum = Global.ActionSigNum = 0L;
	Global.TaskToSig = FindTask (0L);
	if (!(InputDevPort = CreatePort (0L,0L))) CloseStuff (ERR_CREATE);
	if (!(InputRequestBlock = CreateStdIO (InputDevPort))) CloseStuff (ERR_CREATE);
	if ((Global.QuitSigNum = AllocSignal (-1L)) == -1L) CloseStuff (ERR_ALLOC);
	Global.QuitSig = 1L<<Global.QuitSigNum;
	if ((Global.ActionSigNum = AllocSignal (-1L)) == -1L) CloseStuff (ERR_ALLOC);
	Global.ActionSig = 1L<<Global.ActionSigNum;
	HandlerStuff.is_Data = (APTR)&Global;
	HandlerStuff.is_Code = (VOID (*)())MyHandler;
	HandlerStuff.is_Node.ln_Pri = 52;
	if (OpenDevice ("input.device",0L,(struct IORequest *)InputRequestBlock,0L))
		CloseStuff (ERR_OPEN);
	InputRequestBlock->io_Command = IND_ADDHANDLER;
	InputRequestBlock->io_Data = (APTR)&HandlerStuff;
	DoIO ((struct IORequest *)InputRequestBlock);
	Count = 0;
	for (;;)
		{
			sig = Wait (Global.QuitSig | Global.ActionSig);
			if (sig & Global.QuitSig) break;
			if (sig & Global.ActionSig)
				{
					switch (++Count)
						{
							case 0 : id = id1; break;
							case 1 : id = id2; break;
							case 2 : id = id3; break;
							case 3 : id = id4; Count = -1; break;
						}
					Rate = Global.Rate*150+200;
					AbortIO ((struct IORequest *)id);
					id = PlaySound (id,SoundBuf,SBUFLEN,1,(WORD)(3579545L/Rate),64);
				}
		}
	InputRequestBlock->io_Command = IND_REMHANDLER;
	InputRequestBlock->io_Data = (APTR)&HandlerStuff;
	DoIO ((struct IORequest *)InputRequestBlock);

	AbortIO ((struct IORequest *)id1);
	AbortIO ((struct IORequest *)id2);
	AbortIO ((struct IORequest *)id3);
	AbortIO ((struct IORequest *)id4);
	CloseStuff (0);
}

/*------------------------- Input event handler ------------------------------*/

struct InputEvent * __saveds __asm MyHandler
		(register __a0 struct InputEvent *ev,register __a1 GlobalDat *gdptr)
{
	register struct InputEvent *ep;

	for (ep=ev ; ep ; ep=ep->ie_NextEvent)
		if (ep->ie_Class == IECLASS_RAWKEY)
			if ((ep->ie_Code == ESCAPEKEY) && (ep->ie_Qualifier&IEQUALIFIER_RCOMMAND))
				{
					ep->ie_Class = IECLASS_NULL;
					Signal (gdptr->TaskToSig,gdptr->QuitSig);
				}
			else if (ep->ie_Code<128)
				{
					gdptr->Rate = ep->ie_Code;
					Signal (gdptr->TaskToSig,gdptr->ActionSig);
				}
	return (ev);
}

/*-------------------------- Close everything --------------------------------*/

void CloseStuff (WORD Error)
{
	if (InputRequestBlock)
		{
			CloseDevice ((struct IORequest *)InputRequestBlock);
			DeleteStdIO (InputRequestBlock);
		}
	if (Global.ActionSigNum) FreeSignal (Global.ActionSigNum);
	if (Global.QuitSigNum) FreeSignal (Global.QuitSigNum);
	if (InputDevPort) DeletePort (InputDevPort);
	if (id1)
		{
			if (id1->ioa_Request.io_Device) CloseDevice ((struct IORequest *)id1);
			if (id1->ioa_Request.io_Message.mn_ReplyPort)
				DeletePort (id1->ioa_Request.io_Message.mn_ReplyPort);
			FreeMem (id1,(LONG)sizeof (struct IOAudio));
		}
	if (id2)
		{
			if (id2->ioa_Request.io_Device) CloseDevice ((struct IORequest *)id2);
			if (id2->ioa_Request.io_Message.mn_ReplyPort)
				DeletePort (id2->ioa_Request.io_Message.mn_ReplyPort);
			FreeMem (id2,(LONG)sizeof (struct IOAudio));
		}
	if (id3)
		{
			if (id3->ioa_Request.io_Device) CloseDevice ((struct IORequest *)id3);
			if (id3->ioa_Request.io_Message.mn_ReplyPort)
				DeletePort (id3->ioa_Request.io_Message.mn_ReplyPort);
			FreeMem (id3,(LONG)sizeof (struct IOAudio));
		}
	if (id4)
		{
			if (id4->ioa_Request.io_Device) CloseDevice ((struct IORequest *)id4);
			if (id4->ioa_Request.io_Message.mn_ReplyPort)
				DeletePort (id4->ioa_Request.io_Message.mn_ReplyPort);
			FreeMem (id4,(LONG)sizeof (struct IOAudio));
		}
	if (SoundBuf) FreeMem (SoundBuf,SBUFLEN);
	CloseLibrary ((struct Library *)DOSBase);
	Exit ((LONG)Error);
}

/*---------------- Allocate and init an IO Request Block ---------------------*/

void SetIOA (WORD Per,WORD Vol,WORD Repeat,ULONG Len,struct IOAudio **ioa)
{
	struct MsgPort *Port;

	if (!(*ioa = (struct IOAudio *)AllocMem ((LONG)sizeof (struct IOAudio),
								MEMF_PUBLIC | MEMF_CLEAR))) CloseStuff (ERR_ALLOC);
	(*ioa)->ioa_Request.io_Message.mn_Node.ln_Pri = 10;
	if (!(Port = CreatePort (PortName,0L)))
		{
			FreeMem (*ioa,(LONG)sizeof (struct IOAudio));
			CloseStuff (ERR_CREATE);
		}
	else
		{
			/* Get a channel */
			(*ioa)->ioa_Request.io_Message.mn_ReplyPort = Port;
			(*ioa)->ioa_Data = AllocationMap;
			(*ioa)->ioa_Length = sizeof (AllocationMap);
			if (OpenDevice (AUDIONAME,0L,(struct IORequest *)*ioa,0L))
				{
					(*ioa)->ioa_Request.io_Device = NULL;
					CloseStuff (ERR_OPEN);
				}
			else
				{
					/* Set Up Request */
					(*ioa)->ioa_Request.io_Flags = ADIOF_PERVOL;
					(*ioa)->ioa_Request.io_Command = CMD_WRITE;
					(*ioa)->ioa_Period = Per;
					(*ioa)->ioa_Volume = Vol;
					(*ioa)->ioa_Cycles = Repeat;
				}
		}
}

/*------------------------------ SetLength -----------------------------------*/

void SetLength (ULONG BufLen,UBYTE **DataHndl,struct IOAudio *ioa)
{
	ioa->ioa_Length = BufLen;
	ioa->ioa_Data=(*DataHndl);
}	

/*---------------------------- Play a sound ----------------------------------*/

struct IOAudio *PlaySound (struct IOAudio *ioa,UBYTE *Buffer,ULONG BufLen,
													WORD Repeat,WORD Period,WORD Volume)
{
	UBYTE *DataPtr;
	WORD Count;
	struct Device *Device;

	Count = Repeat ? (Repeat-1) : -1;
	DataPtr = Buffer;
	ioa->ioa_Request.io_Flags = ADIOF_PERVOL;
	ioa->ioa_Request.io_Command = CMD_WRITE;
	ioa->ioa_Period = Period;
	ioa->ioa_Volume = Volume;
	ioa->ioa_Cycles = Repeat;
	SetLength (BufLen,&DataPtr,ioa);
	/* Send command to Audio chip */
	Device = ioa->ioa_Request.io_Device;
	BeginIO ((struct IORequest *)ioa);
	/* If no data remains to play, return ioa pointer */
	return (ioa);
}

/*=============================== The end ====================================*/
