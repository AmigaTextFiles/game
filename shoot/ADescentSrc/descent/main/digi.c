/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/main/digi.c,v $
 * $Revision: 1.3 $
 * $Author: hfrieden $
 * $Date: 1998/04/03 13:32:52 $
 * 
 * Routines to access digital sound hardware
 *
 * $Log: digi.c,v $
 * Revision 1.3  1998/04/03 13:32:52  hfrieden
 * Added error messages
 *
 * Revision 1.2  1998/03/13 23:44:52  tfrieden
 * *** empty log message ***
 *
 * Revision 1.1.1.1  1998/03/03 15:12:21  nobody
 * reimport after crash from backup
 *
 * Revision 1.6  1998/02/21 23:15:54  hfrieden
 * *** empty log message ***
 *
 * Revision 1.5  1998/02/18 17:15:23  hfrieden
 * AHI Support finally working. Digital sound available
 *
 * Revision 1.4  1998/02/17 18:59:40  hfrieden
 * Bugfixes on AHI driver
 *
 * Revision 1.3  1998/02/16 22:02:01  hfrieden
 * Almost working AHI support
 *
 * Revision 1.2  1998/02/14 10:07:40  hfrieden
 * AHI sound support added
 *
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: digi.c,v 1.3 1998/04/03 13:32:52 hfrieden Exp $";
#pragma on (unreferenced)

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <malloc.h>
#include <string.h>
#include <ctype.h>

#include "fix.h"
#include "object.h"
#include "mono.h"
#include "timer.h"
#include "joy.h"
#include "digi.h"
#include "sounds.h"
#include "args.h"
#include "key.h"
#include "newdemo.h"
#include "game.h"
#include "error.h"
#include "wall.h"
#include "cfile.h"
#include "piggy.h"
#include "text.h"
#include "gauges.h"
#include "byteswap.h"

#include <exec/exec.h>
#include <devices/ahi.h>
#include <clib/alib_protos.h>
#include <clib/exec_protos.h>
#include <clib/utility_protos.h>
#include <inline/exec.h>
#include <inline/ahi.h>
#include <inline/ahi_sub.h>
#include <inline/utility.h>


// #pragma pack (4);                        // Use 32-bit packing!
#pragma off (check_stack);          // No stack checking!
//*************************************************
//#include "sos.h"
//#include "sosm.h"
//The above two includes are part of a commercial 
//sound library, so they cannot be included in a public 
//release of the source code. -KRB
//#include "no_sos.h" //Added by KRB
//*************************************************
#include "kconfig.h"
//#include "soscomp.h"

#define hp  HUD_init_message

#define DIGI_PAUSE_BROKEN 1     //if this is defined, don't pause MIDI songs

#define _DIGI_SAMPLE_FLAGS (_VOLUME | _PANNING )

#define _DIGI_MAX_VOLUME (16384)    //16384

// patch files
#define  _MELODIC_PATCH       "melodic.bnk"
#define  _DRUM_PATCH          "drum.bnk"
#define  _DIGDRUM_PATCH       "drum32.dig"

 
static int  Digi_initialized        = 0;
static int  digi_atexit_called  = 0;            // Set to 1 if atexit(digi_close) was called

int ahidigi_audio_mode = AHI_DEFAULT_ID;
int ahidigi_audio_freq = AHI_DEFAULT_FREQ;
int ahidigi_next_channel = 0;
int ahidigi_max_channels = 16;
int ahidigi_volume_boost = 1;
ULONG ahidigi_stereo = 0;
ULONG ahidigi_panning = 0;

int digi_driver_board               = 100;      // Hey, this is an Amiga, man.
int digi_driver_port                    = 100;
int digi_driver_irq                 = 100;
int digi_driver_dma                 = 100;
int digi_midi_type                  = 0;            // Midi driver type
int digi_midi_port                  = 0;            // Midi driver port
static int digi_max_channels        = 16;
static int digi_driver_rate     = 11025;            // rate to use driver at
static int digi_dma_buffersize  = 4096;         // size of the dma buffer to use (4k)
int digi_timer_rate                 = 9943;         // rate for the timer to go off to handle the driver system (120 Hz)
int digi_lomem                      = 0;
static int digi_volume              = _DIGI_MAX_VOLUME;     // Max volume
static int midi_volume              = 128/2;                        // Max volume
static int midi_system_initialized      = 0;
static int digi_system_initialized      = 0;
static int timer_system_initialized     = 0;
static int digi_sound_locks[MAX_SOUNDS];
char digi_last_midi_song[16] = "";
char digi_last_melodic_bank[16] = "";
char digi_last_drum_bank[16] = "";
typedef char * LPSTR;
//typedef ushort WORD;
LPSTR digi_driver_path = NULL;//Was _NULL -KRB
static WORD                     hSOSDigiDriver = 0xffff;            // handle for the SOS driver being used 
static WORD                     hSOSMidiDriver = 0xffff;            // handle for the loaded MIDI driver
static WORD                     hTimerEventHandle = 0xffff;     // handle for the timer function

void digi_reset_digi_sounds(void);

static void * lpInstruments = NULL;     // pointer to the instrument file
static int InstrumentSize = 0;
static void * lpDrums = NULL;               // pointer to the drum file
static int DrumSize = 0;
// track mapping structure, this is used to map which track goes
// out which device. this can also be mapped by the name of the 
// midi track. to map by the name of the midi track use the define
// _MIDI_MAP_TRACK for each of the tracks 
/*
static _SOS_MIDI_TRACK_DEVICE   sSOSTrackMap = { 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK,
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, 
   _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK, _MIDI_MAP_TRACK 
};
*/
// handle for the initialized MIDI song
WORD     wSongHandle = 0xffff;         
ubyte       *SongData=NULL;
int     SongSize;


#define SOF_USED                1       // Set if this sample is used
#define SOF_PLAYING         2       // Set if this sample is playing on a channel
#define SOF_LINK_TO_OBJ     4       // Sound is linked to a moving object. If object dies, then finishes play and quits.
#define SOF_LINK_TO_POS     8       // Sound is linked to segment, pos
#define SOF_PLAY_FOREVER    16      // Play forever (or until level is stopped), otherwise plays once

typedef struct sound_object {
	short           signature;      // A unique signature to this sound
	ubyte           flags;          // Used to tell if this slot is used and/or currently playing, and how long.
	fix         max_volume;     // Max volume that this sound is playing at
	fix         max_distance;   // The max distance that this sound can be heard at...
	int         volume;         // Volume that this sound is playing at
	int         pan;                // Pan value that this sound is playing at
	WORD            handle;         // What handle this sound is playing on.  Valid only if SOF_PLAYING is set.
	short           soundnum;       // The sound number that is playing
	int             channel;        // AHI channel number this sound is playing on
	union { 
		struct {
			short           segnum;             // Used if SOF_LINK_TO_POS field is used
			short           sidenum;                
			vms_vector  position;
		} s1;
		struct {
			short           objnum;             // Used if SOF_LINK_TO_OBJ field is used
			short           objsignature;
		} s2;
	} u;
} sound_object;

#define _segnum         u.s1.segnum
#define _sidenum        u.s1.sidenum
#define _position       u.s1.position
#define _objnum         u.s2.objnum
#define _objsignature   u.s2.objsignature

#define MAX_SOUND_OBJECTS 16
sound_object SoundObjects[MAX_SOUND_OBJECTS];
short next_signature=0;

struct MsgPort *AudioPort = NULL;
char AHIDevice = -1;
struct AHIRequest *MasterRequest;
struct Library *AHIBase;
struct AHIAudioCtrl *AudioCtrl;

int ChannelMap[32];

struct AHIEffMasterVolume ahidigi_master_volume;

struct Hook ahidigi_hook;

typedef struct ahidigi_param {
	int         nLoop;
	Fixed       Volume;
	int         Size;
	UBYTE *     Data;
	sposition   Pan;
} ahidigi_param;

extern struct Library *SysBase;

#define AHIDIGI_PAN_CENTER  0x8000L
#define AHIDIGI_VOL_MAX     0x10000L

int digi_sounds_initialized=0;
//this block commented out by KRB


void * testLoadFile( char * szFileName, int * length );

void sosMIDICallback( WORD PassedSongHandle );
void sosEndMIDICallback();

int digi_xlat_sound(int soundno)
{

	if ( soundno < 0 ) return -1;

	if ( digi_lomem )   {
		soundno = AltSounds[soundno];
		if ( soundno == 255 ) return -1;
	}
	return Sounds[soundno];

}


void digi_close_midi()
{
/*
	if (digi_midi_type>0)   {
		if (wSongHandle < 0xffff)   {
		   // stop the last MIDI song from playing
			sosMIDIStopSong( wSongHandle );
		   // uninitialize the last MIDI song
			sosMIDIUnInitSong( wSongHandle );
			wSongHandle = 0xffff;
		}
		if (SongData)   {
			if (!dpmi_unlock_region(SongData, SongSize))    {
				mprintf( (1, "Error unlocking midi file" ));
			}
			free(SongData);
			SongData = NULL;
		}
	   // reset the midi driver and
	   // uninitialize the midi driver and tell it to free the memory allocated
	   // for the driver
		if ( hSOSMidiDriver < 0xffff )  {
		   sosMIDIResetDriver( hSOSMidiDriver );
		sosMIDIUnInitDriver( hSOSMidiDriver, _TRUE  );
			hSOSMidiDriver = 0xffff;
		}

		if ( midi_system_initialized )  {
		   // uninitialize the MIDI system
		   sosMIDIUnInitSystem(); 
			midi_system_initialized = 0;
		}
	}
*/
}

void digi_close_digi()
{
	if (AHIBase && AudioCtrl) {
		ahidigi_master_volume.ahie_Effect = AHIET_CANCEL|AHIET_MASTERVOLUME;
		AHI_SetEffect(&ahidigi_master_volume, AudioCtrl);
	}
	if (!AHIDevice) {
		//AbortIO((struct IORequest *)MasterRequest);
		CloseDevice((struct IORequest *)MasterRequest);
		AHIDevice = -1;
	}
	if (AudioCtrl)     AHI_FreeAudio(AudioCtrl);
	if (MasterRequest) DeleteIORequest((struct IORequest *)MasterRequest);
	if (AudioPort)     DeleteMsgPort(AudioPort);
}


void digi_close()
{
	if (!Digi_initialized) return;
	Digi_initialized = 0;

	digi_close_midi();
	digi_close_digi();

	if ( digi_system_initialized )  {
		digi_system_initialized = 0;
	}
}

extern int loadpats( char * filename );

int digi_load_fm_banks( char * melodic_file, char * drum_file )
{   
/*
   WORD     wError;                 // error code returned from functions

	// set the instrument file for the MIDI driver to use, since we are using
	// the FM driver two instrument files are needed, the first is for 
	// all melodic instruments and the second is for events on channel 10
	// which is the drum track.
	// set the drum instruments
	if (lpInstruments)  {
		dpmi_unlock_region(lpInstruments, InstrumentSize);
		free( lpInstruments );
	}
			
	lpInstruments = testLoadFile( melodic_file, &InstrumentSize );
	if ( !lpInstruments )   {
		printf( "%s '%s'\n", TXT_SOUND_ERROR_OPEN, melodic_file );
		return 0;
	}

	if (!dpmi_lock_region(lpInstruments, InstrumentSize))   {
		printf( "%s '%s', ptr=0x%8x, len=%d bytes\n", TXT_SOUND_ERROR_LOCK, melodic_file, lpInstruments, InstrumentSize );
		return 0;
	}
	
	if( ( wError =  sosMIDISetInsData( hSOSMidiDriver, lpInstruments, 0x01  ) ) )   {
		printf( "%s %s \n", TXT_SOUND_ERROR_HMI, sosGetErrorString( wError ) );
		return 0;
	}
	
	if (lpDrums)    {
		dpmi_unlock_region(lpDrums, DrumSize);
		free( lpDrums );
	}
			
	lpDrums = testLoadFile( drum_file, &DrumSize );
	if ( !lpDrums ) {
		printf( "%s '%s'\n", TXT_SOUND_ERROR_OPEN, drum_file );
		return 0;
	}

	if (!dpmi_lock_region(lpDrums, DrumSize))   {
		printf( "%s  '%s', ptr=0x%8x, len=%d bytes\n", TXT_SOUND_ERROR_LOCK_DRUMS, drum_file, lpDrums, DrumSize );
		return 0;
	}
	
	 // set the drum instruments
	if( ( wError =  sosMIDISetInsData( hSOSMidiDriver, lpDrums, 0x01  ) ) ) {
		printf( "%s %s\n", TXT_SOUND_ERROR_HMI, sosGetErrorString( wError ) );
		return 0;
	}
	
	return 1;
*/
	return 0;//KRB Comment out...

}

int digi_init_midi()
{
/*
   WORD     wError;                 // error code returned from functions
	_SOS_MIDI_INIT_DRIVER           sSOSMIDIInitDriver; // structure for the MIDI driver initialization function 
	_SOS_MIDI_HARDWARE              sSOSMIDIHardware;   // structure for the MIDI driver hardware

	if ( digi_midi_type > 0 )   {
		// Lock the TrackMap array, since HMI references it in an interrupt.
		if (!dpmi_lock_region ( &sSOSTrackMap, sizeof(sSOSTrackMap)) )  {
			printf( "%s\n", TXT_SOUND_ERROR_MIDI);
			digi_close();
			return 1;
		}

//      if (!dpmi_lock_region ((void near *)sosMIDICallback, (char *)sosEndMIDICallback - (char near *)sosMIDICallback))    {
		if (!dpmi_lock_region ((void near *)sosMIDICallback, 4*1024) )  {
			printf( "%s\n", TXT_SOUND_ERROR_MIDI_CALLBACK);
			digi_close();
			return 1;
		}

	   // initialize the MIDI system
	   sosMIDIInitSystem( digi_driver_path, _SOS_DEBUG_NORMAL );
		midi_system_initialized = 1;

	   // set the pointer to the driver memory for the MIDI driver to 
	   // _NULL. this will tell the load driver routine to allocate new
	   // memory for the MIDI driver
	   sSOSMIDIInitDriver.lpDriverMemory  = _NULL;
		sSOSMIDIInitDriver.sDIGIInitInfo = _NULL;
	
		sSOSMIDIHardware.wPort = digi_midi_port;
	
	   // load and initialize the MIDI driver 
	   if( ( wError = sosMIDIInitDriver( digi_midi_type, &sSOSMIDIHardware, &sSOSMIDIInitDriver, &hSOSMidiDriver ) ) )  {
		  printf( "SOUND: (HMI) '%s'\n", sosGetErrorString( wError ) );
			digi_close();
		  return 1;
	   }
		sosMIDIEnableChannelStealing( _FALSE );
	}
	return 0;
*/
	return 0;//KRB Comment out...

}

void __interrupt __saveds ahidigi_callback(struct Hook *hook __asm("a0"), struct AHIAudioCtrl *actrl __asm("a2"), struct AHISoundMessage *msg __asm("a1"))
{
	ChannelMap[msg->ahism_Channel] = 1-ChannelMap[msg->ahism_Channel];
}

int digi_init_digi()
{
	int i;
	ULONG error;

	AudioPort = CreateMsgPort();
	if (!AudioPort) return 1;
#ifdef DEBUG_SOUND
	printf("digi_init_digi: Message Port created\n");
#endif

	MasterRequest = (struct AHIRequest *)CreateIORequest(AudioPort, sizeof(struct AHIRequest));
	if (MasterRequest) {
#ifdef DEBUG_SOUND
	printf("digi_init_digi: IORequest created\n");
#endif
		MasterRequest -> ahir_Version = 4;
		AHIDevice = (char)OpenDevice((unsigned char *)AHINAME,
			(unsigned long)AHI_NO_UNIT, (struct IORequest *)MasterRequest, 0);
	}

	if (AHIDevice) {
#ifdef DEBUG_SOUND
	printf("digi_init_digi: AHIDevice open error %d\n", AHIDevice);
#endif
		if (MasterRequest) DeleteIORequest((struct IORequest *)MasterRequest);
		if (AudioPort) DeleteMsgPort(AudioPort);
		printf("FATAL ERROR: Cannot initalized AHI device\n");
		return 1;
	}

	AHIBase = (struct Library *)MasterRequest->ahir_Std.io_Device;
#ifdef DEBUG_SOUND
	printf("digi_init_digi: AHIDevice created, allocating audio\n");
#endif

	ahidigi_hook.h_Entry = (HOOKFUNC)ahidigi_callback;
	ahidigi_hook.h_SubEntry = 0;

	AudioCtrl = AHI_AllocAudio(
		AHIA_AudioID,       ahidigi_audio_mode,
		AHIA_MixFreq,       ahidigi_audio_freq,
		AHIA_Channels,      (ULONG)ahidigi_max_channels,
		AHIA_Sounds,        30,
		//AHIA_SoundFunc,     (ULONG)&ahidigi_hook,
	TAG_DONE);

#ifdef DEBUG_SOUND
	printf("digi_init_digi: AudioCtrl = %d\n", AudioCtrl);
#endif

	if (AudioCtrl == NULL) {
		printf("FATAL ERROR: Cannot initialize AudioCtrl\n");
		return 1;
	}
#ifdef DEBUG_SOUND
	printf("digi_init_digi: AudioCtrl allocated and done\n");
#endif

	AHI_GetAudioAttrs(ahidigi_audio_mode, NULL,
		AHIDB_Stereo,   (ULONG)&ahidigi_stereo,
		AHIDB_Panning,  (ULONG)&ahidigi_panning,
	TAG_DONE);


	for (i=0; i<32; i++) ChannelMap[i] = 0;

	ahidigi_master_volume.ahie_Effect = AHIET_MASTERVOLUME;
	//i = (ahidigi_stereo && !ahidigi_panning) ? 4 : 2;
	ahidigi_master_volume.ahiemv_Volume = ahidigi_volume_boost * 65535;
	error = AHI_SetEffect(&ahidigi_master_volume, AudioCtrl);

	digi_set_digi_volume ( (Config_digi_volume * 32768)/8);

#ifdef DEBUG_SOUND
	printf("Done\n");
#endif

	return 0;
}

int digi_init()
{
	int i;
	if ( FindArg( "-nomusic" )) 
		digi_midi_type = 0;


	Digi_initialized = 1;
	digi_system_initialized = 1;

	if (digi_init_midi()) return 1;
	if (digi_init_digi()) return 1;

	if (!digi_atexit_called)    {
		atexit( digi_close );
		digi_atexit_called = 1;
	}

	digi_init_sounds();
	digi_set_midi_volume( midi_volume );

	for (i=0; i<MAX_SOUNDS; i++ )
		digi_sound_locks[i] = 0;
	digi_reset_digi_sounds();

	return 0;
}

// Toggles sound system on/off
void digi_reset()   
{
	if ( Digi_initialized ) {
		digi_reset_digi_sounds();
		digi_close();
		mprintf( (0, "Sound system DISABLED.\n" ));
	} else {
		digi_init();
		mprintf( (0, "Sound system ENABLED.\n" ));
	}
}

int digi_total_locks = 0;

ubyte * digi_lock_sound_data( int soundnum )
{
/*
	int i;

	if ( !Digi_initialized ) return NULL;
	if ( digi_driver_board <= 0 )   return NULL;

	if ( digi_sound_locks[soundnum] == 0 )  {
		digi_total_locks++;
		//mprintf(( 0, "Total sound locks = %d\n", digi_total_locks ));
		i = dpmi_lock_region( GameSounds[soundnum].data, GameSounds[soundnum].length );
		if ( !i ) Error( "Error locking sound %d\n", soundnum );
	}
	digi_sound_locks[soundnum]++;
	return GameSounds[soundnum].data;
*/
	digi_total_locks=digi_total_locks;//blah -KRB
	return 0;//KRB Comment out...

}

void digi_unlock_sound_data( int soundnum )
{
/*
	int i;

	if ( !Digi_initialized ) return;
	if ( digi_driver_board <= 0 )   return;

	Assert( digi_sound_locks[soundnum] > 0 );

	if ( digi_sound_locks[soundnum] == 1 )  {
		digi_total_locks--;
		//mprintf(( 0, "Total sound locks = %d\n", digi_total_locks ));
		i = dpmi_unlock_region( GameSounds[soundnum].data, GameSounds[soundnum].length );
		if ( !i ) Error( "Error unlocking sound %d\n", soundnum );
	}
	digi_sound_locks[soundnum]--;
*/
}
/*
static int next_handle = 0;
static WORD SampleHandles[32] = { 0xffff, 0xffff, 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff };
static int SoundNums[32] = { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };
static uint SoundVolumes[32] = { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };
//This block commented out by KRB
*/
void digi_reset_digi_sounds(void)
{
	int i;

	if ( !Digi_initialized ) return;

	for (i=0; i<ahidigi_max_channels; i++)
		AHI_SetSound((UWORD)i, AHI_NOSOUND, 0, 0, AudioCtrl, AHISF_IMM);

	for (i=0; i<32; i++) ChannelMap[i] = 0;
	AHI_ControlAudio(AudioCtrl,
		AHIC_Play, TRUE,
	TAG_DONE);

}

void reset_sounds_on_channel( int channel )
{
	if ( !Digi_initialized ) return;
	AHI_SetSound((UWORD)channel, AHI_NOSOUND, 0, 0, AudioCtrl, AHISF_IMM);
	ChannelMap[channel] = 0;

}


void digi_set_max_channels(int n)
{
	return;
/*    digi_max_channels   = n;

	if ( digi_max_channels < 1 ) 
		digi_max_channels = 1;
	if ( digi_max_channels > (32-MAX_SOUND_OBJECTS) ) 
		digi_max_channels = (32-MAX_SOUND_OBJECTS);

	if ( !Digi_initialized ) return;

	digi_reset_digi_sounds();*/
}

int digi_get_max_channels()
{
	return ahidigi_max_channels;

}


WORD digi_start_sound(ahidigi_param *sampledata, short soundnum )

{
	int i,j;

	struct AHISampleInfo info;

	unsigned long volume;

	if ( !Digi_initialized ) return -1;

	// Start by finding a free channel

	i = ahidigi_next_channel;
	j=0;
	do {
		ahidigi_next_channel++; j++;
		if (ahidigi_next_channel == ahidigi_max_channels)
			ahidigi_next_channel = 0;
		if (ChannelMap[ahidigi_next_channel] == 0) break;
	} while (j<32);

	info.ahisi_Type = AHIST_M8U;
	info.ahisi_Address = sampledata->Data;
	info.ahisi_Length = sampledata->Size;
	AHI_LoadSound(i, AHIST_SAMPLE, &info, AudioCtrl);

	volume = (unsigned long)digi_volume*(unsigned long)(sampledata->Volume) / 65535UL;

	#ifdef DEBUG_SOUND
	hp("Volume: %d (%d)",volume, i);
	#endif

	if (sampledata->nLoop != 0) {
		AHI_Play(AudioCtrl,
			AHIP_BeginChannel,  i,
			AHIP_Freq,      (ULONG)digi_driver_rate,
			AHIP_Vol,       (ULONG)volume,
			AHIP_Sound,     i,
			AHIP_Pan,       sampledata->Pan,
			AHIP_LoopFreq,  (ULONG)digi_driver_rate,
			AHIP_LoopVol,   sampledata->Volume,
			AHIP_LoopPan,   sampledata->Pan,
			AHIP_EndChannel,NULL,
		TAG_DONE);
	} else {
		AHI_Play(AudioCtrl,
			AHIP_BeginChannel,  i,
			AHIP_Freq,      (ULONG)digi_driver_rate,
			AHIP_Vol,       (ULONG)volume,
			AHIP_Pan,       sampledata->Pan,
			AHIP_Sound,     i,
			AHIP_LoopSound, AHI_NOSOUND,
			AHIP_EndChannel,NULL,
		TAG_DONE);
		//AHI_SetSound(i, AHI_NOSOUND, 0,0, AudioCtrl, 0);
	}

	#ifdef DEBUG_SOUND
	{
		int j;
		char xxx[40];
		for (j=0; j<ahidigi_max_channels; j++) xxx[j]='0'+ChannelMap[j];
		xxx[j]=0;
		hp("channels: %s", xxx);
	}
	#endif

	return i;

}

int digi_is_sound_playing(int soundno)
{
	return 0;//KRB Comment out...
}

void digi_play_sample_once( int soundno, fix max_volume )   
{
	digi_sound *snd;
	ahidigi_param params;

#ifdef NEWDEMO
	if ( Newdemo_state == ND_STATE_RECORDING )
		newdemo_record_sound( soundno );
#endif
	soundno = digi_xlat_sound(soundno);

	if (!Digi_initialized) return;

	if (soundno < 0 ) return;
	snd = &GameSounds[soundno];

	params.nLoop        = 0;
	params.Volume       = max_volume;
	params.Size         = snd->length;
	params.Data         = snd->data;
	params.Pan          = AHIDIGI_PAN_CENTER;

	digi_start_sound( &params, soundno );
}


void digi_play_sample( int soundno, fix max_volume )
{
	digi_play_sample_once(soundno, max_volume);
}


void digi_play_sample_3d( int soundno, int angle, int volume, int no_dups ) 
{
	digi_sound *snd;
	ahidigi_param params;

#ifdef NEWDEMO
	if ( Newdemo_state == ND_STATE_RECORDING )
		newdemo_record_sound( soundno );
#endif
	soundno = digi_xlat_sound(soundno);

	if (!Digi_initialized) return;

	if (soundno < 0 ) return;
	snd = &GameSounds[soundno];

	params.nLoop        = 0;
	params.Volume       = volume;
	params.Size         = snd->length;
	params.Data         = snd->data;
	params.Pan          = angle;


	digi_start_sound( &params, soundno );

/*
	sSOSSampleData.wSamplePanLocation   = angle;            // 0 - 0xFFFF
	sSOSSampleData.wSamplePanSpeed      = 0;
	sSOSSampleData.wVolume                  = fixmuldiv(volume,digi_volume,F1_0);;                  // 0 - 0x7fff
*/
}

void digi_set_midi_volume( int mvolume )
{
/*
	int old_volume = midi_volume;

	if ( mvolume > 127 )
		midi_volume = 127;
	else if ( mvolume < 0 )
		midi_volume = 0;
	else
		midi_volume = mvolume;

	if ( (digi_midi_type > 0) && (hSOSMidiDriver < 0xffff) )        {
		if (  (old_volume < 1) && ( midi_volume > 1 ) ) {
			if (wSongHandle == 0xffff )
				digi_play_midi_song( digi_last_midi_song, digi_last_melodic_bank, digi_last_drum_bank, 1 );
		}
		_disable();
		sosMIDISetMasterVolume(midi_volume);
		_enable();
	}
*/
}

void digi_set_digi_volume( int dvolume )
{
	if ( !Digi_initialized ) return;

	if (dvolume <= 0)
		digi_volume = 0;
	else
		digi_volume = dvolume*2-1;

	digi_sync_sounds();

}


// 0-0x7FFF 
void digi_set_volume( int dvolume, int mvolume )    
{

#ifdef DEBUG_SOUND
	printf("digi_set__volume(%d, %d)\n", dvolume, mvolume);
#endif

	digi_set_midi_volume( mvolume );
	digi_set_digi_volume( dvolume );
}

// allocate memory for file, load file, create far pointer
// with DS in selector.
void * testLoadFile( char * szFileName, int * length )
{
/*
   PSTR  pDataPtr;
	CFILE * fp;
	
   // open file
   fp  =  cfopen( szFileName, "rb" );
	if ( !fp ) return NULL;

   *length  =  cfilelength(fp);

   pDataPtr =  malloc( *length );
	if ( !pDataPtr ) return NULL;

   // read in driver
   cfread( pDataPtr, *length, 1, fp);

   // close driver file
   cfclose( fp );

   // return 
   return( pDataPtr );
   */
   return NULL;//KRB Comment out...
}


// ALL VARIABLES IN HERE MUST BE LOCKED DOWN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
void sosMIDICallback( WORD PassedSongHandle )
{
	//sosMIDIStartSong(PassedSongHandle);
	return;//KRB comment out
} 

void sosEndMIDICallback()       // Used to mark the end of sosMIDICallBack
{
}

void digi_stop_current_song()
{
/*
	// Stop last song...
	if (wSongHandle < 0xffff )  {
	   // stop the last MIDI song from playing
		sosMIDIStopSong( wSongHandle );
	   // uninitialize the last MIDI song
		sosMIDIUnInitSong( wSongHandle );
		wSongHandle = 0xffff;
	}
	if (SongData)   {
		if (!dpmi_unlock_region(SongData, SongSize))    {
			mprintf( (1, "Error unlocking midi file" ));
		}
		free(SongData);
		SongData = NULL;
	}
*/
}


void digi_play_midi_song( char * filename, char * melodic_bank, char * drum_bank, int loop )
{
/*
	int i;
	char fname[128];
   WORD     wError;                 // error code returned from functions
	CFILE       *fp;

	// structure to pass sosMIDIInitSong
	_SOS_MIDI_INIT_SONG     sSOSInitSong;

	if (!Digi_initialized) return;
	if ( digi_midi_type <= 0 )  return;

	digi_stop_current_song();

	if ( filename == NULL ) return;

	strcpy( digi_last_midi_song, filename );
	strcpy( digi_last_melodic_bank, melodic_bank );
	strcpy( digi_last_drum_bank, drum_bank );

	fp = NULL;

	if ( (digi_midi_type==_MIDI_FM)||(digi_midi_type==_MIDI_OPL3) ) {   
		int sl;
		sl = strlen( filename );
		strcpy( fname, filename );  
		fname[sl-1] = 'q';
		fp = cfopen( fname, "rb" );
	}

	if ( !fp  ) {
		fp = cfopen( filename, "rb" );
		if (!fp) {
			mprintf( (1, "Error opening midi file, '%s'", filename ));
			return;
		}
	}
	if ( midi_volume < 1 )      {
		cfclose(fp);
		return;             // Don't play song if volume == 0;
	}
	SongSize = cfilelength( fp );
	SongData    = malloc( SongSize );
	if (SongData==NULL) {
		cfclose(fp);
		mprintf( (1, "Error mallocing %d bytes for '%s'", SongSize, filename ));
		return;
	}
	if ( cfread (  SongData, SongSize, 1, fp )!=1)  {
		mprintf( (1, "Error reading midi file, '%s'", filename ));
		cfclose(fp);
		free(SongData);
		SongData=NULL;
		return;
	}
	cfclose(fp);

	if ( (digi_midi_type==_MIDI_FM)||(digi_midi_type==_MIDI_OPL3) ) {   
		if ( !digi_load_fm_banks(melodic_bank, drum_bank) ) {
			return;
		}
	}
		
	if (!dpmi_lock_region(SongData, SongSize))  {
		mprintf( (1, "Error locking midi file, '%s'", filename ));
		free(SongData);
		SongData=NULL;
		return;
	}

	// setup the song initialization structure
	sSOSInitSong.lpSongData = SongData;
	if ( loop )
		sSOSInitSong.lpSongCallback = sosMIDICallback;
	else
		sSOSInitSong.lpSongCallback = _NULL;

	for ( i=0; i<32; i++ )
		sSOSTrackMap.wTrackDevice[i] = _MIDI_MAP_TRACK;
			
	for ( i=0; i<_SOS_MIDI_MAX_TRACKS; i++ )
		_lpSOSMIDITrack[0][i] = _NULL;

	//initialize the song
	if( ( wError = sosMIDIInitSong( &sSOSInitSong, &sSOSTrackMap, &wSongHandle ) ) )    {
		mprintf( (1, "\nHMI Error : %s", sosGetErrorString( wError ) ));
		free(SongData);
		SongData=NULL;
		return;
	}

	Assert( wSongHandle == 0 );
	 
  // start the song playing
   if( ( wError = sosMIDIStartSong( wSongHandle ) ) ) {
		mprintf( (1, "\nHMI Error : %s", sosGetErrorString( wError ) ));
	   // uninitialize the last MIDI song
		sosMIDIUnInitSong( wSongHandle );
		free(SongData);
		SongData=NULL;
		return;
   }
   */
}

void digi_get_sound_loc( vms_matrix * listener, vms_vector * listener_pos, int listener_seg, vms_vector * sound_pos, int sound_seg, fix max_volume, int *volume, int *pan, fix max_distance )   
{     
	vms_vector  vector_to_sound;
	fix angle_from_ear, cosang,sinang;
	fix distance;
	fix path_distance;

	*volume = 0;
	*pan = 0;

	max_distance = (max_distance*5)/4;      // Make all sounds travel 1.25 times as far.

	//  Warning: Made the vm_vec_normalized_dir be vm_vec_normalized_dir_quick and got illegal values to acos in the fang computation.
	distance = vm_vec_normalized_dir_quick( &vector_to_sound, sound_pos, listener_pos );
		
	if (distance < max_distance )   {
		int num_search_segs = f2i(max_distance/20);
		if ( num_search_segs < 1 ) num_search_segs = 1;

		path_distance = find_connected_distance(listener_pos, listener_seg, sound_pos, sound_seg, num_search_segs, WID_RENDPAST_FLAG );
		if ( path_distance > -1 )   {
			*volume = max_volume - fixdiv(path_distance,max_distance);
			//mprintf( (0, "Sound path distance %.2f, volume is %d / %d\n", f2fl(distance), *volume, max_volume ));
			if (*volume > 0 )   {
				angle_from_ear = vm_vec_delta_ang_norm(&listener->rvec,&vector_to_sound,&listener->uvec);
				fix_sincos(angle_from_ear,&sinang,&cosang);
				//mprintf( (0, "volume is %.2f\n", f2fl(*volume) ));
				if (Config_channels_reversed) cosang *= -1;
				*pan = (cosang + F1_0)/2;
			} else {
				*volume = 0;
			}
		}
	}                                                                                     
}


void digi_init_sounds()
{
	int i;

	if (!Digi_initialized) return;

	digi_reset_digi_sounds();

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )    {
		if (digi_sounds_initialized) {
			if ( SoundObjects[i].flags & SOF_PLAYING )  {
			}
		}
		#ifdef DEBUG_SOUND
		hp("SOF_PLAYING reset on %d");
		#endif
		SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
	}
	digi_sounds_initialized = 1;
	for (i=0; i<ahidigi_max_channels; i++) ChannelMap[i]=0;
	#ifdef DEBUG_SOUND
	hp("Sounds initialized");
	#endif
}

void digi_start_sound_object(int i)
{
	ahidigi_param param;
	if (!Digi_initialized) return;


	// Sound is not playing, so we must start it again
	SoundObjects[i].signature=next_signature++;
							
	param.Volume    =   (Fixed)(SoundObjects[i].volume*digi_volume/65535);
	param.Size      =   GameSounds[SoundObjects[i].soundnum].length;
	param.Data      =   GameSounds[SoundObjects[i].soundnum].data;
	param.Pan       =   SoundObjects[i].pan;

	if (SoundObjects[i].flags & SOF_PLAY_FOREVER )  {
		param.nLoop = -1;
	} else param.nLoop = 0;

	SoundObjects[i].channel = digi_start_sound( &param, SoundObjects[i].soundnum );

	SoundObjects[i].flags |= SOF_PLAYING;

	ChannelMap[SoundObjects[i].channel] = 1;

}

int digi_link_sound_to_object2( int org_soundnum, short objnum, int forever, fix max_volume, fix  max_distance )
{
	int i,volume,pan;
	object * objp;
	int soundnum;
#ifdef DEBUG_SOUND
//    HUD_init_message("to_obj(snum=%d,obj=%d,fevr=%d,maxvol=%d,maxdist=%d)",
//        org_soundnum, objnum, forever, max_volume, max_distance);
//    printf("to_obj(org_snum=%d,objnum=%d,forever=%d,max_volume=%d,max_distance=%d)\n",
//        org_soundnum, objnum, forever, max_volume, max_distance);
#endif

	soundnum = digi_xlat_sound(org_soundnum);

	if ( max_volume < 0 ) return -1;
//  if ( max_volume > F1_0 ) max_volume = F1_0;

	if (!Digi_initialized) return -1;
	if (soundnum < 0 ) return -1;
	if (GameSounds[soundnum].data==NULL) {
		Int3();
		return -1;
	}
	if ((objnum<0)||(objnum>Highest_object_index))
		return -1;

	if ( !forever ) {
		// Hack to keep sounds from building up...
		digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, &Objects[objnum].pos, Objects[objnum].segnum, max_volume,&volume, &pan, max_distance );
		digi_play_sample_3d( org_soundnum, pan, volume, 0 );
		return -1;
	}

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )
		if (SoundObjects[i].flags==0)
			break;
	
	if (i==MAX_SOUND_OBJECTS) {
		mprintf((1, "Too many sound objects!\n" ));
		return -1;
	}

	SoundObjects[i].signature=next_signature++;
	#ifdef DEBUG_SOUND
	hp("SOF_PLAYING reset on %d");
	#endif
	SoundObjects[i].flags = SOF_USED | SOF_LINK_TO_OBJ;
	if ( forever )
		SoundObjects[i].flags |= SOF_PLAY_FOREVER;
	SoundObjects[i]._objnum = objnum;
	SoundObjects[i]._objsignature = Objects[objnum].signature;
	SoundObjects[i].max_volume = max_volume;
	SoundObjects[i].max_distance = max_distance;
	SoundObjects[i].volume = 0;
	SoundObjects[i].pan = 0;
	SoundObjects[i].soundnum = soundnum;

	objp = &Objects[SoundObjects[i]._objnum];
	digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, 
					   &objp->pos, objp->segnum, SoundObjects[i].max_volume,
					   &SoundObjects[i].volume, &SoundObjects[i].pan, SoundObjects[i].max_distance );

	digi_start_sound_object(i);

	return SoundObjects[i].signature;
}

int digi_link_sound_to_object( int soundnum, short objnum, int forever, fix max_volume )
{                                                                                                   // 10 segs away
	return digi_link_sound_to_object2( soundnum, objnum, forever, max_volume, 256*F1_0  );
}

int digi_link_sound_to_pos2( int org_soundnum, short segnum, short sidenum, vms_vector * pos, int forever, fix max_volume, fix max_distance )
{
	int i, volume, pan;
	int soundnum;
#ifdef DEBUG_SOUND
//    HUD_init_message("pos(org_sn=%d,seg=%d,maxvol=%d,max_dist=%d)",
//        org_soundnum, segnum, max_volume, max_distance);
//    printf("pos(org_sn=%d,seg=%d,maxvol=%d,max_dist=%d)\n",
//        org_soundnum, segnum, max_volume, max_distance);
#endif

	soundnum = digi_xlat_sound(org_soundnum);

	if ( max_volume < 0 ) return -1;
//  if ( max_volume > F1_0 ) max_volume = F1_0;

	if (!Digi_initialized) return -1;
	if (soundnum < 0 ) return -1;
	if (GameSounds[soundnum].data==NULL) {
		Int3();
		return -1;
	}

	if ((segnum<0)||(segnum>Highest_segment_index))
		return -1;

	if ( !forever ) {
		// Hack to keep sounds from building up...
		digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, pos, segnum, max_volume, &volume, &pan, max_distance );
		digi_play_sample_3d( org_soundnum, pan, volume, 0 );
		return -1;
	}

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )
		if (SoundObjects[i].flags==0)
			break;
	
	if (i==MAX_SOUND_OBJECTS) {
		mprintf((1, "Too many sound objects!\n" ));
		return -1;
	}


	SoundObjects[i].signature=next_signature++;
	SoundObjects[i].flags = SOF_USED | SOF_LINK_TO_POS;
	#ifdef DEBUG_SOUND
	hp("SOF_PLAYING reset on %d");
	#endif
	if ( forever )
		SoundObjects[i].flags |= SOF_PLAY_FOREVER;
	SoundObjects[i]._segnum = segnum;
	SoundObjects[i]._sidenum = sidenum;
	SoundObjects[i]._position = *pos;
	SoundObjects[i].soundnum = soundnum;
	SoundObjects[i].max_volume = max_volume;
	SoundObjects[i].max_distance = max_distance;
	SoundObjects[i].volume = 0;
	SoundObjects[i].pan = 0;
	digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, 
					   &SoundObjects[i]._position, SoundObjects[i]._segnum, SoundObjects[i].max_volume,
					   &SoundObjects[i].volume, &SoundObjects[i].pan, SoundObjects[i].max_distance );
	
	digi_start_sound_object(i);

	return SoundObjects[i].signature;
}

int digi_link_sound_to_pos( int soundnum, short segnum, short sidenum, vms_vector * pos, int forever, fix max_volume )
{
	return digi_link_sound_to_pos2( soundnum, segnum, sidenum, pos, forever, max_volume, F1_0 * 256 );
}


void digi_kill_sound_linked_to_segment( int segnum, int sidenum, int soundnum )
{
	int i,killed;

	soundnum = digi_xlat_sound(soundnum);

	if (!Digi_initialized) return;

	killed = 0;

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )    {
		if ( (SoundObjects[i].flags & SOF_USED) && (SoundObjects[i].flags & SOF_LINK_TO_POS) )  {
			if ((SoundObjects[i]._segnum == segnum) && (SoundObjects[i].soundnum==soundnum ) && (SoundObjects[i]._sidenum==sidenum) ) {
				if ( SoundObjects[i].flags & SOF_PLAYING )  {
				#ifdef SOUND_DEBUG
					printf("Trying to kill sample\n");
				#endif
					//sosDIGIStopSample( hSOSDigiDriver, SoundObjects[i].handle );
				}
				#ifdef DEBUG_SOUND
				hp("SOF_PLAYING reset on %d");
				#endif
				SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
				ChannelMap[SoundObjects[i].channel] = 0;
				killed++;
			}
		}
	}
	// If this assert happens, it means that there were 2 sounds
	// that got deleted. Weird, get John.
	if ( killed > 1 )   {
		mprintf( (1, "ERROR: More than 1 sounds were deleted from seg %d\n", segnum ));
	}
}

void digi_kill_sound_linked_to_object( int objnum )
{
	int i,killed;
#ifdef DEBUG_SOUND
	HUD_init_message("Killing sound linked to object %d\n", objnum);
#endif

	if (!Digi_initialized) return;

	killed = 0;

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )    {
		if ( (SoundObjects[i].flags & SOF_USED) && (SoundObjects[i].flags & SOF_LINK_TO_OBJ ) ) {
			if (SoundObjects[i]._objnum == objnum)   {
				if ( SoundObjects[i].flags & SOF_PLAYING )  {
				#ifdef SOUND_DEBUG
					printf("Trying to kill sample\n");
				#endif
					//sosDIGIStopSample( hSOSDigiDriver, SoundObjects[i].handle );
				}
				#ifdef DEBUG_SOUND
				hp("SOF_PLAYING reset on %d");
				#endif
				SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
				ChannelMap[SoundObjects[i].channel] = 0;
				killed++;
			}
		}
	}
	// If this assert happens, it means that there were 2 sounds
	// that got deleted. Weird, get John.
	if ( killed > 1 )   {
		mprintf( (1, "ERROR: More than 1 sounds were deleted from object %d\n", objnum ));
	}
}


void digi_sync_sounds()
{
	int i;
	int oldvolume, oldpan;

	if (!Digi_initialized) return;

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )    {
		if ( SoundObjects[i].flags & SOF_USED ) {
			oldvolume = SoundObjects[i].volume;
			oldpan = SoundObjects[i].pan;

			if ( !(SoundObjects[i].flags & SOF_PLAY_FOREVER) )  {
				// Check if its done.
				if (SoundObjects[i].flags & SOF_PLAYING) {
					if (0 == ChannelMap[SoundObjects[i].channel]) {
						SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
						ChannelMap[SoundObjects[i].channel] = 0;
						continue;       // Go on to next sound...
					}
				}
			}           
		
			if ( SoundObjects[i].flags & SOF_LINK_TO_POS )  {
				digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, 
								&SoundObjects[i]._position, SoundObjects[i]._segnum, SoundObjects[i].max_volume,
								&SoundObjects[i].volume, &SoundObjects[i].pan, SoundObjects[i].max_distance );

			} else if ( SoundObjects[i].flags & SOF_LINK_TO_OBJ )   {
				object * objp;
	
				objp = &Objects[SoundObjects[i]._objnum];
		
				if ((objp->type==OBJ_NONE) || (objp->signature!=SoundObjects[i]._objsignature))  {
					// The object that this is linked to is dead, so just end this sound if it is looping.
					if ( (SoundObjects[i].flags & SOF_PLAYING)  && (SoundObjects[i].flags & SOF_PLAY_FOREVER))  {
						AHI_SetSound((UWORD)SoundObjects[i].channel,
							AHI_NOSOUND, 0,0, AudioCtrl, AHISF_IMM);
					}
					SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
					ChannelMap[SoundObjects[i].channel] = 0;
					continue;       // Go on to next sound...
				} else {
					digi_get_sound_loc( &Viewer->orient, &Viewer->pos, Viewer->segnum, 
									&objp->pos, objp->segnum, SoundObjects[i].max_volume,
								   &SoundObjects[i].volume, &SoundObjects[i].pan, SoundObjects[i].max_distance );
				}
			}
			 
			if (oldvolume != SoundObjects[i].volume)    {
				if ( SoundObjects[i].volume < 1 )   {
					// Sound is too far away, so stop it from playing.
					if ((SoundObjects[i].flags & SOF_PLAYING)&&(SoundObjects[i].flags & SOF_PLAY_FOREVER))  {
						AHI_SetSound((UWORD)SoundObjects[i].channel,
							AHI_NOSOUND, 0,0, AudioCtrl, AHISF_IMM);
						SoundObjects[i].flags &= ~SOF_PLAYING;      // Mark sound as not playing
						ChannelMap[SoundObjects[i].channel] = 0;
					}
				} else {
					if (!(SoundObjects[i].flags & SOF_PLAYING)) {
						digi_start_sound_object(i);
					} else {
						//sosDIGISetSampleVolume( hSOSDigiDriver,
						//    SoundObjects[i].handle,
						//    fixmuldiv(SoundObjects[i].volume,
						//        digi_volume,F1_0) );
						AHI_SetVol((UWORD)SoundObjects[i].channel,
							(Fixed)(SoundObjects[i].volume*digi_volume/65535),
							(sposition)SoundObjects[i].pan,
							AudioCtrl, AHISF_IMM);
					}
				}
			}
		}
	}
}


int sound_paused = 0;

void digi_pause_all()
{
	if (!Digi_initialized) return;
	sound_paused++;

	if (sound_paused > 1) return;
	AHI_ControlAudio(AudioCtrl,
		AHIC_Play,  FALSE,
	TAG_DONE);
}

void digi_resume_all()
{
	if (!Digi_initialized) return;
	if (sound_paused > 0) sound_paused--;
	if (sound_paused > 0) return;
	AHI_ControlAudio(AudioCtrl,
		AHIC_Play, TRUE,
	TAG_DONE);
}


void digi_stop_all()
{
	int i;

	if (!Digi_initialized) return;

	for (i=0; i<MAX_SOUND_OBJECTS; i++ )    {
		if ( SoundObjects[i].flags & SOF_USED ) {
			#ifdef DEBUG_SOUND
			hp("SOF_PLAYING reset on %d");
			#endif
			SoundObjects[i].flags = 0;  // Mark as dead, so some other sound can use this sound
		}
	}

	for (i=0; i<ahidigi_max_channels; i++) {
		AHI_SetSound(i, AHI_NOSOUND, 0, 0, AudioCtrl, AHISF_IMM);
		ChannelMap[i] = 0;
	}

}

#ifndef NDEBUG
int verify_sound_channel_free( int channel )
{
	return 0;
}
#endif
