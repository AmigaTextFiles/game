
/***********************************************************************
 *                                                                     *
 *  Headerfile   : SoundInit.c                                         *
 *                                                                     *
 *  Program      : VIDEO-POKERI                                        *
 *                                                                     *
 *  Version      : 1.02       (05.11.1991)   (03.02.1995)              *
 *                                                                     *
 *  Author       : JanTAki                                             *
 *                 92100  RAAHE ,  FINLAND                             *
 *                                                                     *
 *  E-mail       : janta@ratol.fi                                      *
 *                                                                     *
 ***********************************************************************/


/* AvaaSoundit */

#include <exec/types.h>
#include <devices/audio.h>
#include <libraries/dos.h>
#include <exec/memory.h>
#include <proto/exec.h>
#include <clib/dos_protos.h>

#define MakeID(a,b,c,d) ((a)<<24L | (b)<<16L | (c)<<8 | (d))

#define ID_FORM MakeID('F','O','R','M')

#define ID_8SVX MakeID('8','S','V','X')
#define ID_VHDR MakeID('V','H','D','R')
#define ID_BODY MakeID('B','O','D','Y')

#define SOUND_MAX 11          /* Soundien lukumäärä */

extern  UBYTE   stringi[];
extern  UBYTE   BON[] ;
extern  UBYTE   OFF[] ;
extern  UBYTE   COL1[];
extern  UBYTE   COL2[];
extern  UBYTE   SS;
extern  UBYTE   SOUNDS;

extern  VOID cleanExit(SHORT);
extern  ULONG clock;

VOID    AvaaSoundit(VOID);
VOID    VaraaKanavat(VOID);
VOID    Sound(SHORT, SHORT, SHORT);

struct Chunk
{
   LONG  ckID;
   LONG  ckSize;
};

struct Chunk *p8chunk;

UBYTE  *sbase[SOUND_MAX];
ULONG   speed[SOUND_MAX];
ULONG   ssize[SOUND_MAX];
extern  struct  IOAudio     *AIOptr1, *AIOptr2;
extern  struct  MsgPort     *port1;
extern  struct  MsgPort     *port2;
extern  ULONG   device1, device2;

VOID AvaaSoundit()
{
struct  FileHandle  *v8handle;
SHORT   lask;
BYTE    iobuffer[8];
UBYTE  *fname[] = { "Sounds/HoldON.8svx",
                    "Sounds/HoldOFF.8svx",
                    "Sounds/Bet.8svx",
                    "Sounds/Counting.8svx",
                    "Sounds/DoubleOK.8svx",
                    "Sounds/DoubleFail.8svx",
                    "Sounds/CardOFF.8svx",
                    "Sounds/Deal.8svx",
                    "Sounds/GameOver.8svx",
                    "Sounds/DoubleStart.8svx",
                    "Sounds/BigWin.8svx"
                     };


UBYTE  *fbase;
UBYTE  *p8data;
SHORT   freq;
ULONG   rd8count;
UBYTE  *pointer;
ULONG   fsize;
BYTE   *psample[SOUND_MAX];

sbase[0]    = 0L;
sbase[1]    = 0L;
sbase[2]    = 0L;

for(lask=0; lask<SOUND_MAX; lask++)       /* ladataan samplet */
{

v8handle= (struct FileHandle *) Open(fname[lask], MODE_OLDFILE);
if (v8handle==0)
    {
    cleanExit(11);      /* soundi-tiedosto ei aukea */
    }

rd8count = Read((BPTR)v8handle, iobuffer, 8L);
if (rd8count==-1)
    {
    cleanExit(11);      /* lukuvirhe */
    }
if (rd8count<8)
    {
    cleanExit(11);      /* lyhyt -> ei IFF */
    }

p8chunk = (struct Chunk *)iobuffer;
if (p8chunk->ckID != ID_FORM)
    {
    cleanExit(12);
    }

fbase = (UBYTE *)AllocMem(fsize = p8chunk->ckSize, MEMF_PUBLIC | MEMF_CLEAR);
    if (fbase==0)
    {
    cleanExit(9);
    }
        
p8data = fbase;

rd8count = Read( (BPTR)v8handle, p8data, p8chunk->ckSize );
if (rd8count==-1)
    {
    cleanExit(11);
    }
if (rd8count<p8chunk->ckSize)
    {
    cleanExit(11);
    }

if ( MakeID(*p8data, *(p8data+1), *(p8data+2), *(p8data+3) ) != ID_8SVX )
    {
    cleanExit(12);
    }

    p8data += 4;
    while (p8data < fbase+fsize)
        {
        p8chunk = (struct Chunk *)p8data;
        pointer = (UBYTE *)&(p8chunk->ckID);

        switch (p8chunk->ckID)
            {
            case ID_VHDR:
                freq = (SHORT)*(SHORT *)(pointer+20);
                break;
            case ID_BODY:
                    ssize[lask] = (ULONG)*(ULONG *)(pointer+4);
                    psample[lask] = (BYTE *)(p8data+8L);
                break;
            default:
                break;
            }
        p8data = p8data + 8L + p8chunk->ckSize;
        if (p8chunk->ckSize&1L == 1)
            p8data++;
        }

    sbase[lask] = (UBYTE *)AllocMem(ssize[lask], MEMF_CHIP | MEMF_CLEAR);   
    if (sbase[lask]==0)
        {
        cleanExit(9);
        }

    CopyMem(psample[lask], sbase[lask], ssize[lask]);

    if (fbase != 0)  FreeMem(fbase, fsize);
    if (v8handle != 0)  Close((BPTR)v8handle); 

    speed[lask] = clock / freq;

}

}


VOID VaraaKanavat()
{
UBYTE   chans1[]  = { 1, 8, 2, 4 };
UBYTE   chans2[]  = { 2, 4, 1, 8 };

    AIOptr1 = (struct IOAudio *) AllocMem( sizeof(struct IOAudio),
        MEMF_CHIP | MEMF_PUBLIC | MEMF_CLEAR);
    if (AIOptr1 == 0)
        {
        cleanExit(9);
        }

    AIOptr2 = (struct IOAudio *) AllocMem( sizeof(struct IOAudio),
        MEMF_CHIP | MEMF_PUBLIC | MEMF_CLEAR);
    if (AIOptr2 == 0)
        {
        cleanExit(9);
        }

    port1 = CreatePort(0, 0);
    if (port1 == 0)
        {
        cleanExit(13);
        }

    port2 = CreatePort(0, 0);
    if (port2 == 0)
        {
        cleanExit(13);
        }

        AIOptr1->ioa_Request.io_Message.mn_ReplyPort    = port1;
        AIOptr1->ioa_Request.io_Message.mn_Node.ln_Pri  = 40;
        AIOptr1->ioa_Request.io_Command                 = ADCMD_ALLOCATE;
        AIOptr1->ioa_AllocKey                           = 0;
        AIOptr1->ioa_Data                               = chans1;
        AIOptr1->ioa_Length                             = sizeof(chans1);

        device1 = OpenDevice("audio.device", 0L,
            (struct IORequest *)AIOptr1, 0L);

    if (device1!=0)
        {
        cleanExit(14);
        }

        AIOptr2->ioa_Request.io_Message.mn_ReplyPort    = port2;
        AIOptr2->ioa_Request.io_Message.mn_Node.ln_Pri  = 40;
        AIOptr2->ioa_Request.io_Command                 = ADCMD_ALLOCATE;
        AIOptr2->ioa_AllocKey                           = 0;
        AIOptr2->ioa_Data                               = chans2;
        AIOptr2->ioa_Length                             = sizeof(chans2);
        device2 = OpenDevice("audio.device", 0L,
            (struct IORequest *)AIOptr2, 0L);

    if (device2!=0)
        {
        cleanExit(14);
        }

}


VOID Sound(index, time, channel)
SHORT index, time, channel;
                    /* time == 0 --> normaali näytetaajuus!! */
                    /* time <> 0 --> time = näytetaajuus!!   */
                    /* time >  100 --> nopeampi / korkeampi    */
{

if (SOUNDS == 0)    /* SOUNDIT VAIN JOS NE ON PÄÄLLÄ ! ( == 0 ) */
{
if (index > SOUND_MAX-1 || index < 0)
    {
    index = 0;      /* ulkona -> ääni nolla */
    }

switch (channel)
    {
    case 0:             /* vasen / oikea vuorotellen */
        if (SS == 1)
            {
            AIOptr1->ioa_Request.io_Command = CMD_WRITE;
            AIOptr1->ioa_Request.io_Flags   = ADIOF_PERVOL;
            AIOptr1->ioa_Volume             = 64;
            AIOptr1->ioa_Period     = (UWORD)speed[index]-(100-time);
            AIOptr1->ioa_Cycles             = 1;
            AIOptr1->ioa_Data               = (UBYTE *)sbase[index];
            AIOptr1->ioa_Length             = ssize[index];
            SS=2;
            AbortIO( (struct IORequest *)AIOptr1);
            BeginIO( (struct IORequest *)AIOptr1);
            }
        else
            {
            AIOptr2->ioa_Request.io_Command = CMD_WRITE;
            AIOptr2->ioa_Request.io_Flags   = ADIOF_PERVOL;
            AIOptr2->ioa_Volume             = 64;
            AIOptr2->ioa_Period     = (UWORD)speed[index]-(100-time);
            AIOptr2->ioa_Cycles             = 1;
            AIOptr2->ioa_Data               = (UBYTE *)sbase[index];
            AIOptr2->ioa_Length             = ssize[index];
            SS=1;
            AbortIO( (struct IORequest *)AIOptr2);
            BeginIO( (struct IORequest *)AIOptr2);
            }
        break;
    case 1:                 /* vasen kanava */
        AIOptr2->ioa_Request.io_Command = CMD_WRITE;
        AIOptr2->ioa_Request.io_Flags   = ADIOF_PERVOL;
        AIOptr2->ioa_Volume             = 64;
        AIOptr2->ioa_Period         = (UWORD)speed[index]-(100-time);
        AIOptr2->ioa_Cycles             = 1;
        AIOptr2->ioa_Data               = (UBYTE *)sbase[index];
        AIOptr2->ioa_Length             = ssize[index];
            AbortIO( (struct IORequest *)AIOptr2);
            BeginIO( (struct IORequest *)AIOptr2);
        break;
    case 2:                 /* oikea kanava */
        AIOptr1->ioa_Request.io_Command = CMD_WRITE;
        AIOptr1->ioa_Request.io_Flags   = ADIOF_PERVOL;
        AIOptr1->ioa_Volume             = 64;
        AIOptr1->ioa_Period         = (UWORD)speed[index]-(100-time);
        AIOptr1->ioa_Cycles             = 1;
        AIOptr1->ioa_Data               = (UBYTE *)sbase[index];
        AIOptr1->ioa_Length             = ssize[index];
            AbortIO( (struct IORequest *)AIOptr1);
            BeginIO( (struct IORequest *)AIOptr1);
        break;
    case 3:             /* vakiokanava: stereo  */
    default:
        AIOptr1->ioa_Request.io_Command = CMD_WRITE;
        AIOptr1->ioa_Request.io_Flags   = ADIOF_PERVOL;
        AIOptr1->ioa_Volume             = 64;
        AIOptr1->ioa_Period         = (UWORD)speed[index]-(100-time);
        AIOptr1->ioa_Cycles             = 1;
        AIOptr1->ioa_Data               = (UBYTE *)sbase[index];
        AIOptr1->ioa_Length             = ssize[index];

        AIOptr2->ioa_Request.io_Command = CMD_WRITE;
        AIOptr2->ioa_Request.io_Flags   = ADIOF_PERVOL;
        AIOptr2->ioa_Volume             = 64;
        AIOptr2->ioa_Period         = (UWORD)speed[index]-(100-time);
        AIOptr2->ioa_Cycles             = 1;
        AIOptr2->ioa_Data               = (UBYTE *)sbase[index];
        AIOptr2->ioa_Length             = ssize[index];
            AbortIO( (struct IORequest *)AIOptr1);
            AbortIO( (struct IORequest *)AIOptr2);
            BeginIO( (struct IORequest *)AIOptr1);
            BeginIO( (struct IORequest *)AIOptr2);
        break;
    }
}   /* END OF [ if (SOUNDS == 0) ... ] */

}

/* end of SoundInit.c */