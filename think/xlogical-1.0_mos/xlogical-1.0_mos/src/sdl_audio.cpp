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

#ifndef USE_HASH_MAP
#include <map>
#else
#include <hash_map>
#endif

#include <iostream>
#include <stdlib.h>

#include <SDL.h>
#include <SDL_mixer.h>

#include "defs.h"
#include "exception.h"
#include "properties.h"
#include "sdl_audio.h"

#ifndef USE_HASH_MAP
typedef map<const char *, Mix_Chunk *> sound_cache_t;
#else
typedef hash_map<const char *, Mix_Chunk *> sound_cache_t;
#endif

bool gAudioEnabled				= false;
bool gAudioInitialized			= false;

sound_cache_t	gSoundCache;
Mix_Music *		gCurrMusicPtr	= NULL;
string			gCurrMusicName;
string			gCurrMusicType;

void
get_music_info(
	char *aPath, string& aMusicName, string& aMusicType )
{
	char *start, *end;
	int len = strlen( aPath );

	for( end=aPath+len; end >= 0; end-=1 )
	{
		if (*end == '.') break;
	}
	for( start=end; start >= 0; start-=1 )
	{
		if (*start == *PATHSEP) break;
	}
	char *buf = new char[len+1];
	strncpy( buf, start+1, end-start-1 );
	buf[end-start-1] = '\0';
	gCurrMusicName = buf;
	strncpy( buf, end+1, strlen( end ) - 1);
	buf[strlen( end )-1] = '\0';
	gCurrMusicType = buf;
	delete [] buf;
}

Csdl_audio::Csdl_audio() :
	fMusicFinishedFunc( NULL ),
	fMusicVolume( 0.7 ),
	fSoundVolume( 0.7 )
{
}

Csdl_audio::~Csdl_audio()
{
}

void
Csdl_audio::setup()
{
	gAudioEnabled = atoi( properties::instance().get( "audio.enabled" ).c_str() ) > 0;
	if (gAudioEnabled && !gAudioInitialized)
	{
		fMusicVolume = atof( properties::instance().get( "music.volume" ).c_str() );
		fSoundVolume = atof( properties::instance().get( "sound.volume" ).c_str() );

		int channels = atoi( properties::instance().get( "audio.channels").c_str() );
		int frequency = atoi( properties::instance().get( "audio.frequency").c_str() );
		int chunksize = atoi( properties::instance().get( "audio.chunksize").c_str() );
		int format = atoi( properties::instance().get( "audio.format" ).c_str() );
		switch( format )
		{
			case 1:
				format = AUDIO_U8;
				break;
			case 2:
				format = AUDIO_S8;
				break;
			case 3:
				format = AUDIO_U16LSB;
				break;
			case 4:
				format = AUDIO_S16LSB;
				break;
			case 5:
				format = AUDIO_U16MSB;
				break;
			case 6:
				format = AUDIO_S16MSB;
				break;
			default:
				char buf[100];
				sprintf( buf, "audio.format=%d unsupported", format );
cout << "xxxsaudioErrorxxx" << endl;
				ThrowEx( buf );
				break;
		}
		if (SDL_InitSubSystem( SDL_INIT_AUDIO ) < 0)
		{
cout << "xxxsaudioErrorxxx" << endl;
			ThrowEx( string( "Failed to initialize audio" ) );
		}

		if (Mix_OpenAudio( frequency, format, channels, chunksize ) != 0)
		{
cout << "xxxsaudioErrorxxx" << endl;
			ThrowEx( string( "Mix_OpenAudio: " ) + Mix_GetError() );
		}
		gAudioInitialized = true;
	}
}

void
Csdl_audio::set_music_finished_func( music_finished_func_t aCallback )
{
	if (!gAudioEnabled)
	{
		return;
	}

	fMusicFinishedFunc = aCallback;
	Mix_HookMusicFinished( fMusicFinishedFunc );
}

float
Csdl_audio::set_music_volume( float aVolumePercent )
{
	if (aVolumePercent >= 0.0)
	{
		fMusicVolume = aVolumePercent;
		if (gAudioEnabled)
		{
			Mix_VolumeMusic( static_cast<int>( fMusicVolume * MIX_MAX_VOLUME ) );
		}
	}
	return( fMusicVolume );
}

void
Csdl_audio::play_current_music()
{
	if (!gAudioEnabled)
	{
		return;
	}

	if (gCurrMusicPtr)
	{
		if (Mix_PlayMusic( gCurrMusicPtr, 1 ) != 0)
		{
			cerr << "Mix_PlayMusic: " << Mix_GetError() << endl;
			return;
		}
		Mix_VolumeMusic( static_cast<int>( fMusicVolume * MIX_MAX_VOLUME ) );
	}
}

void
Csdl_audio::play_music( const char *aMusicName )
{
	if (!gAudioEnabled)
	{
		return;
	}

	if (gCurrMusicPtr)
	{
		Mix_HaltMusic();
		Mix_FreeMusic( gCurrMusicPtr );
		gCurrMusicPtr = NULL;
	}

	Mix_Music * musicPtr	= NULL;

	musicPtr = Mix_LoadMUS( aMusicName );
	if (!musicPtr)
	{
		cerr << "Mix_LoadMUS: " << Mix_GetError() << endl;
		return;
	}

	gCurrMusicPtr = musicPtr;
	if (Mix_PlayMusic( gCurrMusicPtr, 1 ) != 0)
	{
		cerr << "Mix_PlayMusic: " << Mix_GetError() << endl;
		return;
	}
	Mix_VolumeMusic( static_cast<int>( fMusicVolume * MIX_MAX_VOLUME ) );
	get_music_info(
		const_cast<char *>(aMusicName), gCurrMusicName, gCurrMusicType );
}

void
Csdl_audio::stop_music()
{
	if (!gAudioEnabled || !gCurrMusicPtr)
	{
		return;
	}

	(void) Mix_HaltMusic();
	Mix_FreeMusic( gCurrMusicPtr );
	gCurrMusicPtr = NULL;
}

char *
Csdl_audio::get_current_music_name()
{
	if (!gAudioEnabled)
	{
		return( NULL );
	}
	if (gCurrMusicName.length() > 0)
	{
		return( const_cast<char *>(gCurrMusicName.c_str()) );
	}
	return( NULL );
}

char *
Csdl_audio::get_current_music_type()
{
	if (!gAudioEnabled)
	{
		return( NULL );
	}
	if (gCurrMusicType.length() > 0)
	{
		return( const_cast<char *>(gCurrMusicType.c_str()) );
	}
	return( NULL );
}

float
Csdl_audio::set_sound_volume( float aVolumePercent )
{
	if (aVolumePercent >= 0.0)
	{
		fSoundVolume = aVolumePercent;
	}
	return( fSoundVolume );
}

void
Csdl_audio::load_sound( const char *aSoundName )
{
	if (!gAudioEnabled)
	{
		return;
	}

	Mix_Chunk * soundPtr	= NULL;

	sound_cache_t::iterator iter = gSoundCache.find( aSoundName );
	if (iter != gSoundCache.end())
	{
		Mix_FreeChunk( iter->second );
		gSoundCache.erase( iter );
	}
	soundPtr = Mix_LoadWAV( aSoundName );
	if (!soundPtr)
	{
cout << "xxxsaudioErrorxxx" << endl;
		ThrowEx( string( "Mix_LoadWAV: " ) + Mix_GetError() );
	}
	gSoundCache[aSoundName] = soundPtr;
}

void
Csdl_audio::unload_sound( const char *aSoundName )
{
	if (!gAudioEnabled)
	{
		return;
	}

	sound_cache_t::iterator iter = gSoundCache.find( aSoundName );
	if (iter != gSoundCache.end())
	{
		Mix_FreeChunk( iter->second );
		gSoundCache.erase( iter );
	}
}

void
Csdl_audio::play_sound( const char *aSoundName )
{
	if (!gAudioEnabled)
	{
		return;
	}

	Mix_Chunk * soundPtr	= NULL;

	sound_cache_t::iterator iter = gSoundCache.find( aSoundName );
	if (iter == gSoundCache.end())
	{
		soundPtr = Mix_LoadWAV( aSoundName );
		if (!soundPtr)
		{
cout << "xxxsaudioErrorxxx" << endl;
			ThrowEx( string( "Mix_LoadWAV: " ) + Mix_GetError() );
		}
		gSoundCache[aSoundName] = soundPtr;
	} else {
		soundPtr = iter->second;
	}

	// play sound on next available channel - we don't care if it fails
	Mix_VolumeChunk( soundPtr, static_cast<int>( fSoundVolume * MIX_MAX_VOLUME ) );
	(void) Mix_PlayChannel( -1, soundPtr, 0 );
}

void
#ifdef __MORPHOS__
Csdl_audio::audio_shutdown()
#else
Csdl_audio::shutdown()
#endif
{
	if (gAudioInitialized)
	{
		(void) Mix_HaltMusic();
		if (gCurrMusicPtr)
		{
			Mix_FreeMusic( gCurrMusicPtr );
			gCurrMusicPtr = NULL;
		}
		for( sound_cache_t::iterator iter = gSoundCache.begin();
			  iter != gSoundCache.end();
			  ++iter )
		{
			Mix_FreeChunk( iter->second );
		}
		Mix_CloseAudio();
		gSoundCache.clear();
		gAudioInitialized = false;

		(void) SDL_QuitSubSystem( SDL_INIT_AUDIO );
	}
}
