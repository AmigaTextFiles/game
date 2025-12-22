/*====================================================*/
/*																										*/
/* Little gag to sound a real beep			V1.1					*/
/* © J.Tyberghein																			*/
/*		Tue Sep 26 08:43:30 1989 V1.0										*/
/*		Mon Dec 18 11:04:01 1989 V1.1										*/
/*		Tue Dec 19 09:21:03 1989												*/
/*																										*/
/* compile with: (Lattice 5.0x)												*/
/*		lc -v -cms -O -j104 Beep												*/
/*		blink Beep.o lib lib:lc.lib		(no startupcode)	*/
/*																										*/
/* this program is reexecutable and reentrable				*/
/*																										*/
/*====================================================*/

#include <exec/types.h>
#include <exec/memory.h>
#include <devices/audio.h>
#include <string.h>

#define VERSION				11

#define ERR_ALLOC			0
#define ERR_OPEN			1
#define ERR_CREATE		2

#define LEFT0F				1
#define RIGHT0F				2
#define RIGHT1F				4
#define LEFT1F				8

#pragma libcall (rs->DOSBase) Write 30 32103
#pragma libcall (rs->DOSBase) Output 3c 0
#pragma libcall (rs->DOSBase) Exit 90 101

#pragma libcall Device BeginIO 1e 901

#pragma syscall AllocMem c6 1002
#pragma syscall FreeMem d2 902
#pragma syscall CloseLibrary 19e 901
#pragma syscall OpenDevice 1bc 190804
#pragma syscall CloseDevice 1c2 901
#pragma syscall CheckIO 1d4 901
#pragma syscall AbortIO 1e0 901
#pragma syscall OpenLibrary 228 902

/*================================ Data ======================================*/

const char *PortName = "Sound Port";

/* Look for a left channel, then a right */
UBYTE AllocationMap[] = { LEFT0F,LEFT1F,RIGHT0F,RIGHT1F };

/* This structure is needed to keep all global resources on the stack */
/* So we need no global variables and our program is reentrable */
struct Resources
	{
		struct IOAudio *id;				/* Sound ID */
		UBYTE *SoundBuf;					/* WaveForm Buffer */
		LONG Len;									/* Sample length */
		APTR DOSBase;
	};

void CloseStuff (WORD Error, struct Resources *);
void OpenStuff (struct Resources *);
LONG Stol (char **);
void Usage (struct Resources *);
void Print (char *, struct Resources *);
LONG SkipSpace (char **);
struct IOAudio *PlaySound (struct IOAudio *,UBYTE *,ULONG,WORD,WORD,WORD);
void Error (WORD, char *, struct Resources *);


/*================================ Code ======================================*/

/*---------------------------- Main program ----------------------------------*/

LONG __saveds __asm myMain (register __a0 char *cmdline,register __d0 LONG Length)
{
	WORD i,Div;
	LONG Rate;											/* Sample rate */
	struct Resources rs;
	char *ptr;

	if (!(rs->DOSBase = (APTR)OpenLibrary ("dos.library",0L))) return (100L);

	OpenStuff (&rs);

	ptr = cmdline;
	if (SkipSpace (&ptr)) Usage (&rs);
	if ((Rate = Stol (&ptr)) < 0L) Usage (&rs);
	if (!SkipSpace (&ptr))
		{
			if ((rs.Len = Stol (&ptr)) < 0L) rs.Len = 4000L;
		}
	else rs.Len = 4000L;
	if (rs.Len <= 125L || rs.Len >= 65536L) Usage (&rs);

	if (!(rs.SoundBuf = (UBYTE *)AllocMem (rs.Len,MEMF_CHIP | MEMF_CLEAR)))
		Error (ERR_ALLOC,"SoundBuf",&rs);
	Div = rs.Len/125;
	for (i=0 ; i<rs.Len ; i++)
		(rs.SoundBuf)[i] = (i%2) ? 127 : 127+(i-rs.Len)/Div;
	rs.id = PlaySound (rs.id,rs.SoundBuf,rs.Len,1,(WORD)(3579545L/Rate),64);
	while (!CheckIO (rs.id)) ;
	AbortIO (rs.id);

	CloseStuff (0,&rs);
}

/*----------------------- Skip spaces in a string ----------------------------*/

LONG SkipSpace (char **s)
/* return TRUE if eoln */
{
	while (**s && (**s == ' ' || **s == 0xa)) (*s)++;
	return (!**s);
}

/*------------------- Convert a string to an integer -------------------------*/

LONG Stol (char **s)
/* return -1 if error */
{
	LONG n;

	for (n=0L ; **s && **s != ' ' && **s != 0xa ; (*s)++)
		{
			if (**s > '9' || **s < '0') return (-1L);
			n = n*10L+**s-'0';
		}
	return (n);
}

/*-------------------------------- Usage -------------------------------------*/

void Usage (struct Resources *rs)
{
	Print ("Usage : Beep <Rate> [<Length>]\n",rs);
	Print ("   <Rate>   : SampleRate\n",rs);
	Print ("   <Length> : Length of sample (125<Length<65536) (default 4000)\n",rs);
	CloseStuff (0,rs);
}

/*-------------------------- Close everything --------------------------------*/

void CloseStuff (WORD Error, struct Resources *rs)
{
	if (rs->id)
		{
			if (rs->id->ioa_Request.io_Device) CloseDevice (rs->id);
			if (rs->id->ioa_Request.io_Message.mn_ReplyPort)
				DeletePort (rs->id->ioa_Request.io_Message.mn_ReplyPort);
			FreeMem (rs->id,(LONG)sizeof (struct IOAudio));
		}
	if (rs->SoundBuf) FreeMem (rs->SoundBuf,rs->Len);
	CloseLibrary ((struct Library *)(rs->DOSBase));
	Exit ((LONG)Error);
}

/*----------------------- Print message on screen ----------------------------*/

void Print (char *mes, struct Resources *rs)
{
	Write (Output (),mes,(long)strlen (mes));
}

/*----------------------- Error handling routine -----------------------------*/

void Error (WORD Error, char *Object, struct Resources *rs)
{
	char *Head;

	switch (Error)
		{
			case ERR_CREATE:	Head = "creating"; break;
			case ERR_OPEN:		Head = "opening"; break;
			case ERR_ALLOC:		Head = "allocating"; break;
		}
	Print ("[33mERROR:[31m ",rs);
	Print (Head,rs);
	Print (" ",rs);
	Print (Object,rs);
	Print (" !\n",rs);
	CloseStuff (Error,rs);
}

/*----------------------------- Open stuff -----------------------------------*/

void OpenStuff (struct Resources *rs)
{
	struct MsgPort *Port;

	rs->id = NULL;
	rs->SoundBuf = NULL;
	rs->Len = 0;

	if (!(rs->id = (struct IOAudio *)AllocMem ((LONG)sizeof (struct IOAudio),MEMF_PUBLIC | MEMF_CLEAR)))
		Error (ERR_ALLOC,"IOAudio",rs);
	rs->id->ioa_Request.io_Message.mn_Node.ln_Pri = 10;

	if (!(Port = (struct MsgPort *)CreatePort (PortName,0L)))
		Error (ERR_CREATE,PortName,rs);
	rs->id->ioa_Request.io_Message.mn_ReplyPort = Port;
	rs->id->ioa_Data = AllocationMap;
	rs->id->ioa_Length = sizeof (AllocationMap);

	if (OpenDevice (AUDIONAME,0L,rs->id,0L))
		{
			rs->id->ioa_Request.io_Device = NULL;
			Error (ERR_OPEN,AUDIONAME,rs);
		}
	rs->id->ioa_Request.io_Flags = ADIOF_PERVOL;
	rs->id->ioa_Request.io_Command = CMD_WRITE;
	rs->id->ioa_Period = 3579545L/8000;
	rs->id->ioa_Volume = 64;
	rs->id->ioa_Cycles = 1;
}

/*---------------------------- Play a sound ----------------------------------*/

struct IOAudio *PlaySound (struct IOAudio *ioa,UBYTE *Buffer,ULONG BufLen,
													WORD Repeat,WORD Period,WORD Volume)
{
	struct Device *Device;

	ioa->ioa_Request.io_Flags = ADIOF_PERVOL;
	ioa->ioa_Request.io_Command = CMD_WRITE;
	ioa->ioa_Period = Period;
	ioa->ioa_Volume = Volume;
	ioa->ioa_Cycles = Repeat;
	ioa->ioa_Length = BufLen;
	ioa->ioa_Data = Buffer;
	Device = ioa->ioa_Request.io_Device;
	BeginIO (ioa);
	return (ioa);
}

/*=============================== The end ====================================*/
