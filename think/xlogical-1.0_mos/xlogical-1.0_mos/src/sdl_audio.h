//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////



#ifndef _sdl_audio_h_
#define _sdl_audio_h_

#include "audio.h"

class Csdl_audio : public Caudio
{
public:
	Csdl_audio();
	virtual ~Csdl_audio();

	void setup();

	void set_music_finished_func( music_finished_func_t aCallback );
	float set_music_volume( float aVolumePercent );
	void play_music( const char *aMusicName );
	void play_current_music();
	void stop_music();
	char *get_current_music_name();
	char *get_current_music_type();

	void load_sound( const char *aSoundName );
	void unload_sound( const char *aSoundName );
	float set_sound_volume( float aVolumePercent );
	void play_sound( const char *aSoundName );

#ifndef __MORPHOS__
	void shutdown();
#else
	void audio_shutdown();
#endif


private:

	music_finished_func_t	fMusicFinishedFunc;
	float							fMusicVolume;
	float							fSoundVolume;
};

#endif

// $Log: sdl_audio.h,v $
// Revision 1.5  2001/02/16 21:00:04  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2000/10/06 19:29:11  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.3  2000/10/01 21:07:53  tom
// made use of music_finished callback to play next user song or to replay
// current song depending on what state the program is in.
//
// Revision 1.2  2000/10/01 08:08:15  tom
// finished implementing the SDL_mixer audio driver
//
// Revision 1.1  2000/10/01 05:00:26  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
