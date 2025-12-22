/******************************************************************************
BINIAX SOUND-RELATED IMPLEMENTATIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

/******************************************************************************
INCLUDES
******************************************************************************/

#include <stdlib.h>
#include <SDL_mixer.h>

#include "inc.h"

/******************************************************************************
LOCALS
******************************************************************************/

BNX_SND _Snd;

/******************************************************************************
FUNCTIONS
******************************************************************************/

BNX_BOOL sndInit()
{
	BNX_INT32	audio_rate		= 22000;
	BNX_UINT16	audio_format	= AUDIO_S16;
	BNX_INT32	audio_channels	= 2;

	if ( Mix_OpenAudio( audio_rate, audio_format, audio_channels, 2048 ) < 0 )
	{
		return BNX_FALSE;
	}
	else
	{
		Mix_QuerySpec( &audio_rate, &audio_format, &audio_channels );
	}

	_Snd.sounds[ 1 ] = Mix_LoadWAV("data/sfx1.wav");
	_Snd.sounds[ 2 ] = Mix_LoadWAV("data/sfx2.wav");
	_Snd.sounds[ 3 ] = Mix_LoadWAV("data/sfx3.wav");
	_Snd.sounds[ 4 ] = Mix_LoadWAV("data/sfx4.wav");


	return BNX_TRUE;
}

void sndUpdate()
{
	return;
}

void sndPlay( BNX_GAME *game )
{
	BNX_UINT32 snd		= 0;
	BNX_UINT32 sndmask	= 1;

	while ( game->sounds != cSndNone && snd <= cSndLast )
	{
		sndmask = 1 << snd;
		if ( (game->sounds & sndmask) != cSndNone )
		{
			if ( _Snd.sounds[ snd ] != NULL )
			{
				Mix_PlayChannel( snd % 2, _Snd.sounds[ snd ], 0 );
			}
		}
		game->sounds &= ~sndmask;
		snd ++;
	}
}

