
#include <exec/types.h>
#include <devices/audio.h>
#include <graphics/gfxbase.h>
#include <proto/all.h>
#include <stdlib.h>
#include <stdio.h>

struct GfxBase *BfxBase = NULL;
UBYTE whichannel[] = { 2, 4, 8, 1 };

int
main(int argc, char **argv)
{
	struct IOAudio	*AIOptr = NULL;
	struct MsgPort	*port = NULL;
	struct Message	*msg;
	ULONG		device;
	BYTE		*waveptr = NULL;
	LONG		frequency = 440;
	LONG		duration = 3;
	LONG		clock;
	LONG		samples = 2;
	LONG		samcyc = 1;

	GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 0L);
	if (GfxBase == NULL) goto killaudio;

	if (GfxBase->DisplayFlags & PAL) clock = 3546895;
	else clock = 3579545;

	if (GfxBase) CloseLibrary((struct Library *)GfxBase);

	if ((AIOptr = (struct IOAudio *)AllocMem(sizeof(struct IOAudio),
		MEMF_PUBLIC | MEMF_CLEAR)) == NULL) goto killaudio;

	if ((port = CreatePort(0, 0)) == NULL) goto killaudio;

	AIOptr->ioa_Request.io_Message.mn_ReplyPort = port;
	/* Priority varies */
	AIOptr->ioa_Request.io_Message.mn_Node.ln_Pri = 70;
	AIOptr->ioa_Request.io_Command = ADCMD_ALLOCATE;
	AIOptr->ioa_Request.io_Flags = ADIOF_NOWAIT;
	AIOptr->ioa_AllocKey = 0;
	AIOptr->ioa_Data = whichannel;
	AIOptr->ioa_Length = sizeof(whichannel);

	if ((device = OpenDevice("audio.device", NULL,
		(struct IORequest *)AIOptr, NULL)) != 0) goto killaudio;

	/* Very simple wave */
	if ((waveptr = (BYTE *)AllocMem(samples,
		MEMF_CHIP | MEMF_PUBLIC)) == NULL) goto killaudio;

	waveptr[0] =  127;
	waveptr[1] = -127;

	AIOptr->ioa_Request.io_Message.mn_ReplyPort = port;
	AIOptr->ioa_Request.io_Command = CMD_WRITE;
	AIOptr->ioa_Request.io_Flags = ADIOF_PERVOL;
	AIOptr->ioa_Data = (BYTE *)waveptr;
	AIOptr->ioa_Length = samples;
	AIOptr->ioa_Period = clock * samcyc / (samples * frequency);
	AIOptr->ioa_Volume = 64;
	AIOptr->ioa_Cycles = frequency * duration / samcyc;

	BeginIO((struct IORequest *)AIOptr);
	Wait(1L << port->mp_SigBit);
	msg = GetMsg(port);

killaudio:

	if (waveptr) FreeMem(waveptr, 2);
	if (port) DeletePort(port);
	if (device == 0) CloseDevice((struct IORequest *)AIOptr);
	if (AIOptr) FreeMem(AIOptr, sizeof(struct IOAudio));
}
