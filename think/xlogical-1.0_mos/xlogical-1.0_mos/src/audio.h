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



#ifndef _AUDIO_H_
#define _AUDIO_H_

class Caudio
{
public:
	typedef void(*music_finished_func_t)();

	virtual void setup()=0;

	virtual void set_music_finished_func( music_finished_func_t )=0;
	virtual float set_music_volume( float )=0;
	virtual void play_music( const char * )=0;
	virtual void play_current_music()=0;
	virtual void stop_music()=0;
	virtual char * get_current_music_name()=0;
	virtual char * get_current_music_type()=0;

	virtual void load_sound( const char * )=0;
	virtual void unload_sound( const char * )=0;
	virtual float set_sound_volume( float )=0;
	virtual void play_sound( const char * )=0;

#ifndef __MORPHOS__
	virtual void shutdown()=0;
#else
	virtual void audio_shutdown()=0;
#endif

};
extern Caudio *audioDriver;

#endif

// $Log: audio.h,v $
// Revision 1.5  2001/02/16 20:59:52  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2000/10/06 19:29:03  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.3  2000/10/01 21:07:53  tom
// made use of music_finished callback to play next user song or to replay
// current song depending on what state the program is in.
//
// Revision 1.2  2000/10/01 08:08:14  tom
// finished implementing the SDL_mixer audio driver
//
// Revision 1.1  2000/10/01 05:00:24  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
