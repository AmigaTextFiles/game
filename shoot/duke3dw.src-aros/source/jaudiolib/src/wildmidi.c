/*
 Copyright (C) 2012 Szilárd Biró
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
 See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 
 */

/**
 * WildMidi source support for MultiVoc
 */

#ifdef HAVE_WILDMIDI

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include "pitch.h"
#include "multivoc.h"
#include "_multivc.h"
#include <wildmidi_lib.h>

#define min(x,y) ((x) < (y) ? (x) : (y))
#define max(x,y) ((x) > (y) ? (x) : (y))


typedef struct {
	void * ptr;
	size_t length;
	size_t pos;
	
	void *mf;
	
	char block[0x1000];
	//int lastbitstream;
} midi_data;

/*---------------------------------------------------------------------
Function: MV_GetNextMIDIBlock

Controls playback of MIDI data
---------------------------------------------------------------------*/

static playbackstatus MV_GetNextMIDIBlock
(
 VoiceNode *voice
 )

{
	midi_data * md = (midi_data *) voice->extra;
	int bytes = 0, bytesread = 0;
	int err = 0;
    const unsigned long int beginning = 0;
    
	
	voice->Playing = TRUE;
	
	bytesread = 0;
	do {
		bytes = WildMidi_GetOutput (md->mf, md->block + bytesread, sizeof(md->block) - bytesread);
		if (bytes == 0)
        {
			if (voice->LoopStart) {
				err = WildMidi_FastSeek(md->mf, &beginning);
				if (err != 0) {
					fprintf(stderr, "MV_GetNextMIDIBlock WildMidi_FastSeek: err %d\n", err);
                    return NoMoreData;
				} else {
					continue;
				}
			} else {
				break;
			}
		} else if (bytes < 0) {
			fprintf(stderr, "MV_GetNextMIDIBlock WildMidi_GetOutput: err %d\n", bytes);
			voice->Playing = FALSE;
			return NoMoreData;
		}

		bytesread += bytes;
	} while (bytesread < sizeof(md->block));

	if (bytesread == 0) {
		voice->Playing = FALSE;
		return NoMoreData;
	}
		
	bytesread /= 2 * voice->channels;
	
	voice->position		= 0;
	voice->sound		= md->block;
	voice->BlockLength	= 0;
	voice->length		= bytesread << 16;
	
	return( KeepPlaying );
}


/*---------------------------------------------------------------------
Function: MV_PlayMIDI3D

Begin playback of sound data at specified angle and distance
from listener.
---------------------------------------------------------------------*/

int MV_PlayMIDI3D
(
 char *ptr,
 unsigned int ptrlength,
 int  pitchoffset,
 int  angle,
 int  distance,
 int  priority,
 unsigned int callbackval
 )

{
	int left;
	int right;
	int mid;
	int volume;
	int status;
	
	if ( !MV_Installed )
	{
		MV_SetErrorCode( MV_NotInstalled );
		return( MV_Error );
	}
	
	if ( distance < 0 )
	{
		distance  = -distance;
		angle	 += MV_NumPanPositions / 2;
	}
	
	volume = MIX_VOLUME( distance );
	
	// Ensure angle is within 0 - 31
	angle &= MV_MaxPanPosition;
	
	left  = MV_PanTable[ angle ][ volume ].left;
	right = MV_PanTable[ angle ][ volume ].right;
	mid	= max( 0, 255 - distance );
	
	status = MV_PlayMIDI( ptr, ptrlength, pitchoffset, mid, left, right, priority,
									callbackval );
	
	return( status );
}


/*---------------------------------------------------------------------
Function: MV_PlayMIDI

Begin playback of sound data with the given sound levels and
priority.
---------------------------------------------------------------------*/

int MV_PlayMIDI
(
 char *ptr,
 unsigned int ptrlength,
 int	pitchoffset,
 int	vol,
 int	left,
 int	right,
 int	priority,
 unsigned int callbackval
 )

{
	int status;
	
	status = MV_PlayLoopedMIDI( ptr, ptrlength, -1, -1, pitchoffset, vol, left, right,
											priority, callbackval );
	
	return( status );
}


/*---------------------------------------------------------------------
Function: MV_PlayLoopedMIDI

Begin playback of sound data with the given sound levels and
priority.
---------------------------------------------------------------------*/

int MV_PlayLoopedMIDI
(
 char *ptr,
 unsigned int ptrlength,
 int	loopstart,
 int	loopend,
 int	pitchoffset,
 int	vol,
 int	left,
 int	right,
 int	priority,
 unsigned int callbackval
 )

{
	VoiceNode	*voice;
    int status;
	midi_data * md = 0;	
	//_WM_Info * mi = 0;

	md = (midi_data *) malloc( sizeof(midi_data) );
	if (!md) {
		MV_SetErrorCode( MV_InvalidMIDIFile );
		return MV_Error;
	}
	
	memset(md, 0, sizeof(midi_data));
	md->ptr = ptr;
	md->pos = 0;
	md->length = ptrlength;

	md->mf = WildMidi_OpenBuffer (md->ptr, md->length);
	if (status < 0) {
		fprintf(stderr, "MV_PlayLoopedMIDI: err %d\n", status);
		MV_SetErrorCode( MV_InvalidMIDIFile );
		return MV_Error;
	}

	/*mi = WildMidi_GetInfo(md->mf);
	if (!mi) {
		free(md);
		MV_SetErrorCode( MV_InvalidMIDIFile );
		return MV_Error;
	}*/
	
	if ( !MV_Installed )
	{
		MV_SetErrorCode( MV_NotInstalled );
		return( MV_Error );
	}
	
	// Request a voice from the voice pool
	voice = MV_AllocVoice( priority );
	if ( voice == NULL )
	{
		free(md);
		MV_SetErrorCode( MV_NoVoices );
		return( MV_Error );
	}

	voice->wavetype		= MIDI;
	voice->bits			= 16;
	voice->channels		= 2;
	voice->extra		= (void *) md;
	voice->GetSound		= MV_GetNextMIDIBlock;
	voice->NextBlock	= md->block;
	voice->DemandFeed	= NULL;
	voice->LoopCount	= 0;
	voice->BlockLength	= 0;
	voice->PitchScale	= PITCH_GetScale( pitchoffset );
	voice->length		= 0;
	voice->next			= NULL;
	voice->prev			= NULL;
	voice->priority		= priority;
	voice->callbackval	= callbackval;
	voice->LoopStart	= (char *) (loopstart >= 0 ? TRUE : FALSE);
	voice->LoopEnd		= 0;
	voice->LoopSize		= 0;
	voice->Playing		= TRUE;
	voice->Paused		= FALSE;
	voice->SamplingRate = MV_MixRate; // hack: WildMIDI provides no information about the mixing rate
	voice->RateScale	 = ( voice->SamplingRate * voice->PitchScale ) / MV_MixRate;
	voice->FixedPointBufferSize = ( voice->RateScale * MixBufferSize ) - voice->RateScale;
	MV_SetVoiceMixMode( voice );

	MV_SetVoiceVolume( voice, vol, left, right );
	MV_PlayVoice( voice );
	
	return( voice->handle );
}


void MV_ReleaseMIDIVoice( VoiceNode * voice )
{
	midi_data  * md = (midi_data *) voice->extra;
	
	if (voice->wavetype != MIDI) {
		return;
	}

    if (md->mf != NULL)
        WildMidi_Close(md->mf);
	
	free(md);
	
	voice->extra = 0;
}

#endif //HAVE_WILDMIDI
