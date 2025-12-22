// Emacs style mode select   -*- C++ -*-
//-----------------------------------------------------------------------------
//
// $Id: i_sound.c,v 1.16 1998/09/07 20:06:36 jim Exp $
//
//  BOOM, a modified and improved DOOM engine
//  Copyright (C) 1999 by
//  id Software, Chi Hoang, Lee Killough, Jim Flynn, Rand Phares, Ty Halderman
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//      System interface for sound.
//
//-----------------------------------------------------------------------------

static const char
rcsid[] = "$Id: i_sound.c,v 1.16 1998/09/07 20:06:36 jim Exp $";

//#include <stdio.h>


#include "doomstat.h"

#include "i_sound.h"
#include "w_wad.h"
#include "g_game.h"     //jff 1/21/98 added to use dprintf in I_RegisterSong
#include "d_main.h"
#include "lprintf.h"  // jff 08/03/98 - declaration of lprintf

// Amiga includes.
#include <proto/exec.h>
#include "amiga_sound_library.h"


// killough 2/21/98: optionally use varying pitched sounds
#define PITCH(x) (pitched_sounds ? ((x)*11025)/128 : 11025)

// This is the number of active sounds that these routines
// can handle at once.
#define NUM_CHANNELS 16




// The actual lengths of all sound effects.
static int lengths[NUMSFX];




static struct Library *DoomSndBase = NULL;

/**********************************************************************/
//
// This function loads the sound data for sfxname from the WAD lump,
// and returns a ptr to the data in fastmem and its length in len.
//
static void *getsfx(char *sfxname, int *len)
{
  unsigned char*      sfx;
  unsigned char*      paddedsfx;
  int                 i;
  int                 size;
  //int                 paddedsize;
  char                name[20];
  int                 sfxlump;

  // Get the sound data from the WAD, allocate lump
  //  in zone memory.
  sprintf(name, "ds%s", sfxname);

  // Now, there is a severe problem with the
  //  sound handling, in it is not (yet/anymore)
  //  gamemode aware. That means, sounds from
  //  DOOM II will be requested even with DOOM
  //  shareware.
  // The sound list is wired into sounds.c,
  //  which sets the external variable.
  // I do not do runtime patches to that
  //  variable. Instead, we will use a
  //  default sound for replacement.
  if (W_CheckNumForName(name) == -1)
    sfxlump = W_GetNumForName("dspistol");
  else
    sfxlump = W_GetNumForName (name);

  size = W_LumpLength (sfxlump);

  // Debug.
  // fprintf( stderr, "." );
  // fprintf( stderr, " -loading  %s (lump %d, %d bytes)\n",
  //         sfxname, sfxlump, size );
  //fflush( stderr );

  sfx = (unsigned char*)W_CacheLumpNum (sfxlump, PU_STATIC);

  // Allocate from zone memory.
  paddedsfx = (unsigned char*)Z_Malloc (size, PU_STATIC, 0);
  // ddt: (unsigned char *) realloc(sfx, paddedsize+8);
  // This should interfere with zone memory handling,
  //  which does not kick in in the soundserver.

  // Now copy and pad.
  for (i = 0; i < size; i++)
    paddedsfx[i] = sfx[i] ^ 0x80;
  /* memcpy (paddedsfx, sfx, size); */

  // Remove the cached lump.
  Z_Free( sfx );

  // Preserve padded length.
  *len = size;

  // Return allocated padded data.
  return (void *) (paddedsfx /* + 8 */);
}






void I_SetChannels()
{
  // no-op.
}


void I_SetSfxVolume(int volume)
{
	// Identical to DOS.
	// Basically, this should propagate
	//  the menu/config file setting
	//  to the state variable used in
	//  the mixing.
	snd_SfxVolume = volume;

	Sfx_SetVol(volume<<3);
}

// jff 1/21/98 moved music volume down into MUSIC API with the rest

//
// Retrieve the raw data lump index
//  for a given SFX name.
//
int I_GetSfxLumpNum(sfxinfo_t* sfx) {
  char namebuf[9];
  sprintf(namebuf, "ds%s", sfx->name);
  return W_CheckNumForName(namebuf);
}




// This function adds a sound to the list of currently
// active sounds, which is maintained as a given number
// of internal channels. Returns a handle.

int I_StartSound(int sfx, int vol, int sep, int pitch, int pri) {
	static int handle;

	// move up one slot, with wraparound
	if (++handle >= NUM_CHANNELS) {
		handle = 0;
	}
	
	// destroy anything still in the slot
	I_StopSound(handle);
	
	// Copy the sound's data into the sound sample slot
	//memcpy(&channel[handle], S_sfx[sfx].data, sizeof(SAMPLE));
	
	// Start the sound
    Sfx_Start(S_sfx[sfx].data, handle, PITCH(pitch), vol<<3, sep, lengths[sfx]);
    
	// Reference for s_sound.c to use when calling functions below
	return handle;
}

// Stop the sound. Necessary to prevent runaway chainsaw,
// and to stop rocket launches when an explosion occurs.

void I_StopSound (int handle) {
	Sfx_Stop(handle);
}

// Update the sound parameters. Used to control volume,
// pan, and pitch changes such as when a player turns.

void I_UpdateSoundParams(int handle, int vol, int sep, int pitch) {
	Sfx_Update(handle, PITCH(pitch), vol<<3, sep);
}

// We can pretend that any sound that we've associated a handle
// with is always playing.

int I_SoundIsPlaying(int handle) {
	return Sfx_Done(handle) ? 1 : 0;
}

// This function loops all active (internal) sound
//  channels, retrieves a given number of samples
//  from the raw sound data, modifies it according
//  to the current (internal) channel parameters,
//  mixes the per channel samples into the global
//  mixbuffer, clamping it to the allowed range,
//  and sets up everything for transferring the
//  contents of the mixbuffer to the (two)
//  hardware channels (left and right, that is).


void I_UpdateSound( void )
{
}

// This would be used to write out the mixbuffer
//  during each game loop update.
// Updates sound buffer and audio device at runtime.
// It is called during Timer interrupt with SNDINTR.

void I_SubmitSound(void)
{

}

void I_ShutdownSound(void) {
    
	if (DoomSndBase != NULL) {
		CloseLibrary(DoomSndBase);
		DoomSndBase = NULL;
	}
}

void I_InitSound(void) {
	int i;
  
	// Secure and configure sound device first.
	//jff 8/3/98 use logical output routine
	lprintf(LO_INFO,"I_InitSound\n");

	DoomSndBase = OpenLibrary ("doomsound.library", 37);
	
	if (DoomSndBase == NULL) {
		//jff 8/3/98 use logical output routine
		lprintf(LO_ERROR, "Could not open doomsound.library!\n");
		//jff 1/22/98 on error, disable sound this invocation
		//in future - nice to detect if either sound or music might be ok
		nosfxparm = true;
		nomusicparm = true;
	} else {
		//Sfx_SetVol(64);
		//Mus_SetVol(64);
		
		// Initialize external data (all sounds) at start, keep static.
		for (i = 1; i < NUMSFX; i++) {
			// Alias? Example is the chaingun sound linked to pistol.
			if (!S_sfx[i].link) {
			  // Load data from WAD file.
			  S_sfx[i].data = getsfx (S_sfx[i].name, &lengths[i]);
			} else {
			  // Previously loaded already?
			  S_sfx[i].data = S_sfx[i].link->data;
			  lengths[i] = lengths[(S_sfx[i].link - S_sfx)/sizeof(sfxinfo_t)];
			}
		}
	
		// Finished initialization.
		//jff 8/3/98 use logical output routine
		lprintf(LO_CONFIRM,"I_InitSound: sound module ready\n");	

		atexit(I_ShutdownSound);
	}
}






///
// MUSIC API.
//




// jff 1/18/98 changed interface to make mididata destroyable

void I_PlaySong(int handle, int looping) {

	if (handle >= 0) {
		Mus_Play(handle, looping);
	}
}

void I_SetMusicVolume(int volume) {

	// Internal state variable.
	snd_MusicVolume = volume;
	
	// Now set volume on output device.
    Mus_SetVol(volume<<3);
}

void I_PauseSong (int handle)
{
	if (handle >= 0) {
		Mus_Pause(handle);
	}
}

void I_ResumeSong (int handle)
{
	if (handle >= 0) {
		Mus_Resume(handle);
	}
}

void I_StopSong(int handle)
{
	if (handle >= 0) {
		Mus_Stop(handle);
	}
}

void I_UnRegisterSong(int handle)
{
	if (handle >= 0) {
		Mus_Unregister(handle);
	}
}



int I_RegisterSong(void *data)
{
	int handle;

	Mus_Register(data);

	handle= 0;

	return handle;                        // 0 if successful, -1 otherwise
}



//----------------------------------------------------------------------------
//
// $Log: i_sound.c,v $
// Revision 1.16  1998/09/07  20:06:36  jim
// Added logical output routine
//
// Revision 1.15  1998/05/03  22:32:33  killough
// beautification, use new headers/decls
//
// Revision 1.14  1998/03/09  07:11:29  killough
// Lock sound sample data
//
// Revision 1.13  1998/03/05  00:58:46  jim
// fixed autodetect not allowed in allegro detect routines
//
// Revision 1.12  1998/03/04  11:51:37  jim
// Detect voices in sound init
//
// Revision 1.11  1998/03/02  11:30:09  killough
// Make missing sound lumps non-fatal
//
// Revision 1.10  1998/02/23  04:26:44  killough
// Add variable pitched sound support
//
// Revision 1.9  1998/02/09  02:59:51  killough
// Add sound sample locks
//
// Revision 1.8  1998/02/08  15:15:51  jim
// Added native midi support
//
// Revision 1.7  1998/01/26  19:23:27  phares
// First rev with no ^Ms
//
// Revision 1.6  1998/01/23  02:43:07  jim
// Fixed failure to not register I_ShutdownSound with atexit on install_sound error
//
// Revision 1.4  1998/01/23  00:29:12  killough
// Fix SSG reload by using frequency stored in lump
//
// Revision 1.3  1998/01/22  05:55:12  killough
// Removed dead past changes, changed destroy_sample to stop_sample
//
// Revision 1.2  1998/01/21  16:56:18  jim
// Music fixed, defaults for cards added
//
// Revision 1.1.1.1  1998/01/19  14:02:57  rand
// Lee's Jan 19 sources
//
//----------------------------------------------------------------------------