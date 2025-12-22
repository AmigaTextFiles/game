/* g_audio.c */
#include <exec/types.h>
#include <exec/memory.h>
#include <devices/audio.h>
#include <dos/dos.h>
#include <dos/dosextens.h>

#include <clib/exec_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>

#include <stdlib.h>
#include <stdio.h>

#include "g_headers.h"
#include "g_8svx.h"
#include "g_audio.h"


struct IOAudio *AudioIO = NULL;    /* Pointer to the I/O block for I/O commands */
struct MsgPort *AudioMP = NULL;    /* Pointer to a port so the device can reply */
struct Message *AudioMSG = NULL;   /* Pointer for the reply message             */

ULONG  device = 666;
extern LONG clock;

extern struct game_struct game;

/*-----------------------------------------------------------*/
/* The whichannel array is used when we allocate a channel.  */
/* It tells the audio device which channel we want. The code */
/* is 1 =channel0, 2 =channel1, 4 =channel2, 8 =channel3.    */
/* If you want more than one channel, add the codes up.      */
/* This array says "Give me channel 0. If it's not available */
/* then try channel 1; then try channel 2 and then channel 3 */
/*-----------------------------------------------------------*/
unsigned char which_channel = 15;

void play_sample(struct sample_struct *s, unsigned char channel)
{
	ULONG c;

	if(!game.sound_on) return;

	switch(channel) {
	case 0:
		c = 1;
		break;
	case 1:
		c = 2;
		break;
	case 2:
		c = 4;
		break;
	case 3:
		c = 8;
		break;
	}
	
	// stop anything currently playing
	AudioIO->ioa_Request.io_Unit = (struct Unit*)c;
	AudioIO->ioa_Request.io_Message.mn_ReplyPort = AudioMP;
	AudioIO->ioa_Request.io_Command          = ADCMD_FINISH;
	AudioIO->ioa_Request.io_Flags = 0;
	Forbid();
	DoIO((struct IORequest *) AudioIO);
	Permit();
	// play new sample
	AudioIO->ioa_Request.io_Unit = (struct Unit*)c;
	AudioIO->ioa_Request.io_Message.mn_ReplyPort = AudioMP;
	AudioIO->ioa_Request.io_Command          = CMD_WRITE;
	AudioIO->ioa_Request.io_Flags            = ADIOF_PERVOL;
	AudioIO->ioa_Data                        = s->data;
	AudioIO->ioa_Length                      = s->data_size;
	AudioIO->ioa_Period                      = clock / s->sample_rate;
	AudioIO->ioa_Volume                      = game.volume;
	AudioIO->ioa_Cycles                      = 1;
	Forbid();
	BeginIO((struct IORequest *) AudioIO);
	Permit();
}

void loop_sample(struct sample_struct *s, unsigned char channel)
{
	ULONG c;

	if(!game.sound_on) return;

	switch(channel)	{
	case 0:
		c = 1;
		break;
	case 1:
		c = 2;
		break;
	case 2:
		c = 4;
		break;
	case 3:
		c = 8;
		break;
	}
	
	// stop anything currently playing
	AudioIO->ioa_Request.io_Unit = (struct Unit*)c;
	AudioIO->ioa_Request.io_Message.mn_ReplyPort = AudioMP;
	AudioIO->ioa_Request.io_Command          = ADCMD_FINISH;
	AudioIO->ioa_Request.io_Flags = 0;
	Forbid();
	DoIO((struct IORequest *) AudioIO);
	Permit();
	// play new sample
	AudioIO->ioa_Request.io_Unit = (struct Unit*)c;
	AudioIO->ioa_Request.io_Message.mn_ReplyPort = AudioMP;
	AudioIO->ioa_Request.io_Command          = CMD_WRITE;
	AudioIO->ioa_Request.io_Flags            = ADIOF_PERVOL;
	AudioIO->ioa_Data                        = s->data;
	AudioIO->ioa_Length                      = s->data_size;
	AudioIO->ioa_Period                      = clock / s->sample_rate;
	AudioIO->ioa_Volume                      = game.volume;
	AudioIO->ioa_Cycles                      = 0; // 0 = forever
	Forbid();
	BeginIO((struct IORequest *) AudioIO);
	Permit();
}

void stop_loop(unsigned char channel)
{
	ULONG c;

	if(!game.sound_on) return;

	switch(channel) {
	case 0:
		c = 1;
		break;
	case 1:
		c = 2;
		break;
	case 2:
		c = 4;
		break;
	case 3:
		c = 8;
		break;
	}
	
	// stop anything currently playing
	AudioIO->ioa_Request.io_Unit = (struct Unit*)c;
	AudioIO->ioa_Request.io_Message.mn_ReplyPort = AudioMP;
	AudioIO->ioa_Request.io_Command          = CMD_FLUSH;
	AudioIO->ioa_Request.io_Flags = 0;
	Forbid();
	DoIO((struct IORequest *) AudioIO);
	Permit();
}

int init_audio()
{
	AudioMP = CreatePort(0,0);
	if(AudioMP == 0) {
		exit_audio();
		return 0;
	}

	AudioIO = (struct IOAudio *)AllocMem(sizeof(struct IOAudio), MEMF_PUBLIC | MEMF_CLEAR);
	if(AudioIO == 0) return 0;
	
	AudioIO->ioa_Request.io_Message.mn_ReplyPort   = AudioMP;
	AudioIO->ioa_Request.io_Message.mn_Node.ln_Pri = 127;
	AudioIO->ioa_Request.io_Command                = ADCMD_ALLOCATE;
	//AudioIO->ioa_Request.io_Flags                  = ADIOF_NOWAIT;
	AudioIO->ioa_AllocKey                          = 0;
	AudioIO->ioa_Data                              = &which_channel;
	AudioIO->ioa_Length                            = sizeof(unsigned char);
	// open the device
	device = OpenDevice("audio.device", 0L, (struct IORequest *)AudioIO, 0L);
	if(device != 0) {
		exit_audio();
		return 0;
	}

	return 1;
}

void exit_audio()
{
	if(device == 0) CloseDevice((struct IORequest *) AudioIO);
	if(AudioIO) FreeMem(AudioIO,sizeof(struct IOAudio));
	if(AudioMP) DeletePort(AudioMP);
}

