#include <libraries/iffparse.h>
#include <workbench/startup.h>
#include <graphics/gfxbase.h>
#include <exec/execbase.h>
#include <dos/dosextens.h>
#include <devices/audio.h>
#include <exec/memory.h>
#include <clib/iffparse_protos.h>
#include <clib/exec_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <h/sound.h>
#include <h/rot.h>


extern struct GfxBase *GfxBase;
extern struct control control;

struct IOAudio *ConChannel;
struct IOAudio *audio[4];
struct MsgPort *audioport;

#define SAMPLENUM 14
struct sounddata sd[SAMPLENUM];

LoadAllSounds()
{
Load8SVX("sounds/playerfire.8svx",0);    /* player fire */
Load8SVX("sounds/thrust.8svx",1);  /* thrust */
Load8SVX("sounds/boom.8svx",2);    /* asteroid/fighter explosion */
Load8SVX("sounds/explosion.8svx",3);    /* player/saucer explsion */
Load8SVX("sounds/saucerfire.8svx",4);	   /* saucer fire */
Load8SVX("sounds/enemyfire.8svx",5);	   /* enemy fire */
Load8SVX("sounds/break.8svx",6);    /* enemy explosion */
Load8SVX("sounds/hyperspace.8svx",7);   /* hyperspace */
Load8SVX("sounds/shield.8svx",8);   /* shield whack */
Load8SVX("sounds/tech.8svx",9);    /* tech box */
Load8SVX("sounds/level.8svx",10);/* level note */
Load8SVX("sounds/shieldpop.8svx",11);/* shield box */
Load8SVX("sounds/extra.8svx",12);	   /* life box */
Load8SVX("sounds/fighterexp.8svx",13); /* fighter explosion */

sd[1].volume = 20;
}


makesound(num,chan)
LONG num,chan;
{

if (control.audio == TRUE)
    {
	StopSound(chan);
	audio[chan] ->ioa_Request.io_Command= CMD_WRITE;
	audio[chan] ->ioa_Request.io_Flags	= ADIOF_PERVOL;
	audio[chan] ->ioa_Period			= sd[num].rate;
	audio[chan] ->ioa_Volume			= sd[num].volume;
	audio[chan] ->ioa_Cycles			= 1;
	audio[chan] ->ioa_Data			= sd[num].audiodata;
	audio[chan] ->ioa_Length			= sd[num].length;
	BeginIO((struct IORequest *)audio[chan]);
    }
}

FlushSound(num)
LONG num;
{
if (control.audio == TRUE)
    {
	audio[num] ->ioa_Request.io_Command	= CMD_FLUSH;
	BeginIO((struct IORequest *)audio[num]);
    }
}


StopSound(num)
LONG num;
{
audio[num] ->ioa_Request.io_Command	= ADCMD_FINISH;
BeginIO((struct IORequest *)audio[num]);
}


initaudio()
{
LONG error,x;

audioport = CreatePort("rot",0);
if (audioport == NULL)
    {
	makerequest("audioport Error");
	makerequest("Game Will Proceed Without Sound");
	control.audio = FALSE;
    }
else
    {
	for (x=0;x<4;x++)
	    {
		audio[x]	= (struct IOAudio *)AllocMem(sizeof(struct IOAudio),MEMF_PUBLIC | MEMF_CLEAR);
		if (audio[x] == NULL)
		    {
			makerequest("Audio Channel Allocation Error");
			makerequest("Game Will Proceed Without Sound");
			control.audio = FALSE;
		    }
	    }

	if (control.audio == TRUE)
	    {
		ConChannel = (struct IOAudio *)AllocMem(sizeof(struct IOAudio),MEMF_PUBLIC | MEMF_CLEAR);
		if (ConChannel == NULL)
		    {
			makerequest("Control Channel Allocation Error");
			makerequest("Game Will Proceed Without Sound");
			control.audio = FALSE;
		    }
		else
		    {
			ConChannel->ioa_Request.io_Message.mn_Node.ln_Type= NT_MESSAGE;
			ConChannel->ioa_Request.io_Message.mn_Length	   	= sizeof(struct IOAudio);
			ConChannel->ioa_Request.io_Command			   	= ADCMD_ALLOCATE;
			ConChannel->ioa_Request.io_Flags				= ADIOF_NOWAIT;
			ConChannel->ioa_Data						= Channel;
			ConChannel->ioa_Length						= sizeof(Channel);
			ConChannel->ioa_AllocKey						= 0;
			ConChannel->ioa_Request.io_Message.mn_ReplyPort	= audioport;
			ConChannel->ioa_Request.io_Message.mn_Node.ln_Pri	= 64;

			error = OpenDevice("audio.device",0,(struct IORequest *)ConChannel,0);
			if (error != NULL)
			    {
				makerequest("audio.port Error");
				makerequest("Game Will Proceed Without Sound");
				control.audio = FALSE;
			    }

			*audio[L2] = *audio[R1] = *audio[R2] = *audio[L1] = *ConChannel;

			audio[L1]->ioa_Request.io_Unit = (APTR)(((ULONG)ConChannel->ioa_Request.io_Unit) & 1);
			audio[R1]->ioa_Request.io_Unit = (APTR)(((ULONG)ConChannel->ioa_Request.io_Unit) & 2);
			audio[L2]->ioa_Request.io_Unit = (APTR)(((ULONG)ConChannel->ioa_Request.io_Unit) & 4);
			audio[R2]->ioa_Request.io_Unit = (APTR)(((ULONG)ConChannel->ioa_Request.io_Unit) & 8);
		    }
	    }
    }
}

closeaudio()
{
LONG x;

if (ConChannel) CloseDevice((struct IORequest *)ConChannel);

if (audioport) DeletePort(audioport);

for (x=0;x<4;x++)
	if (audio[x]) FreeMem(audio[x],sizeof(struct IOAudio));

if (ConChannel) FreeMem(ConChannel,sizeof(struct IOAudio));

for (x=0;x<SAMPLENUM;x++)
	if (sd[x].audiodata) FreeVec(sd[x].audiodata);
}



Load8SVX(STRPTR Name,LONG num)
{
struct IFFHandle	*Handle;
struct StoredProperty	*Prop;
struct Voice8Header	*VoiceHeader;
struct ContextNode *ContextNode;
LONG	Rate,Length,Volume;

if(Handle = AllocIFF())  						/* Allocate an IFF handle. */
    {
    
if(Handle->iff_Stream=Open(Name,MODE_OLDFILE))		/* Open the sound file for reading. */
    {
	InitIFFasDOS(Handle);						/* Open the file for reading. */
	if(!OpenIFF(Handle,IFFF_READ))
	    {
		if(!PropChunk(Handle,ID_8SVX,VHDR)) 		/* Remember the voice header chunk if encountered. */
		    {
			if(!StopChunk(Handle,ID_8SVX,BODY)) 	/* Stop in front of the data body chunk. */
			    {
				if(!ParseIFF(Handle,IFFPARSE_SCAN))	/* Scan the file... */
				    {
					if(Prop = FindProp(Handle,ID_8SVX,VHDR))	/* Try to find the voice header chunk. */
						{
						 VoiceHeader = (struct Voice8Header *)Prop -> sp_Data;
						 if(!VoiceHeader->sCompression&&VoiceHeader->ctOctave == 1)		/* No compression and only a single octave, please! */
						    {
							if(ContextNode = CurrentChunk(Handle))  /* Get information on the current chunk. */
							    {
								Length= VoiceHeader->oneShotHiSamples ? VoiceHeader->oneShotHiSamples : VoiceHeader->repeatHiSamples;
								Rate	 = (GfxBase -> DisplayFlags & PAL ? 3546895 : 3579545) / VoiceHeader -> samplesPerSec;
								Volume= (VoiceHeader -> volume * 64) / 0x10000;

								sd[num].audiodata = AllocVec(Length,MEMF_CHIP);
								sd[num].volume = Volume;
	/* sound data insertion */		sd[num].length = Length;
								sd[num].rate 	= Rate;

								if (ReadChunkBytes(Handle,sd[num].audiodata,Length) != Length) printf("Load 8SVX problem \n");
							    }
						    }
						  else printf("compressed!!!!\n");
					    }
				    }
			    }
			}
			CloseIFF(Handle);
		}
		Close(Handle -> iff_Stream);
	}
	FreeIFF(Handle);
	}
}
