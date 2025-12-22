//-------------------------------------------------------------------------
/*
Copyright (C) 2010 EDuke32 developers and contributors

This file is part of EDuke32.

EDuke32 is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License version 2
as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/
//-------------------------------------------------------------------------

/*
 * A reimplementation of Jim Dose's FX_MAN routines, using  SDL_mixer 1.2.
 *   Whee. FX_MAN is also known as the "Apogee Sound System", or "ASS" for
 *   short. How strangely appropriate that seems.
 */

// Stripped down version, removed external timidity support - BSz 
 
#include <stdio.h>
#include <errno.h>

/*#include "duke3d.h"
#include "cache1d.h"*/

#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

#include "music.h"

#define TRUE  ( 1 == 1 )
#define FALSE ( !TRUE )

#define min(x,y) ((x) < (y) ? (x) : (y))
#define max(x,y) ((x) > (y) ? (x) : (y))

int MUSIC_ErrorCode = MUSIC_Ok;

static char warningMessage[80];
static char errorMessage[80];

static int music_initialized = 0;
static int music_context = 0;
static int music_loopflag = MUSIC_PlayOnce;
static Mix_Music *music_musicchunk = NULL;

/*static inline char *Bstrncpyz(char *dst, const char *src, bsize_t n)
{
    strncpy(dst, src, n);
    dst[n-1] = 0;
    return dst;
}*/
static void Bstrncpyz(char *dst, const char *src, size_t n)
{
    strncpy(dst, src, n);
    dst[n-1] = 0;
    //return dst;
}

static void setErrorMessage(const char *msg)
{
    Bstrncpyz(errorMessage, msg, sizeof(errorMessage));
}

// The music functions...

const char *MUSIC_ErrorString(int ErrorNumber)
{
    switch (ErrorNumber)
    {
    case MUSIC_Warning:
        return(warningMessage);

    case MUSIC_Error:
        return(errorMessage);

    case MUSIC_Ok:
        return("OK; no error.");

    /*case MUSIC_ASSVersion:
        return("Incorrect sound library version.");

    case MUSIC_SoundCardError:
        return("General sound card error.");*/

    case MUSIC_InvalidCard:
        return("Invalid sound card.");

    case MUSIC_MidiError:
        return("MIDI error.");

    /*case MUSIC_MPU401Error:
        return("MPU401 error.");

    case MUSIC_TaskManError:
        return("Task Manager error.");*/

        //case MUSIC_FMNotDetected:
        //    return("FM not detected error.");

    /*case MUSIC_DPMI_Error:
        return("DPMI error.");*/

    default:
        return("Unknown error.");
    } // switch

    return(NULL);
} // MUSIC_ErrorString

int MUSIC_Init(int SoundCard, int Address)
{
    if (music_initialized)
    {
        setErrorMessage("Music system is already initialized.");
        return(MUSIC_Error);
    } // if

    music_initialized = 1;
    return(MUSIC_Ok);
} // MUSIC_Init


int MUSIC_Shutdown(void)
{
    // TODO - make sure this is being called from the menu -- SA
    MUSIC_StopSong();
    music_context = 0;
    music_initialized = 0;
    music_loopflag = MUSIC_PlayOnce;

    return(MUSIC_Ok);
} // MUSIC_Shutdown


void MUSIC_SetMaxFMMidiChannel(int channel)
{
  //  UNREFERENCED_PARAMETER(channel);
} // MUSIC_SetMaxFMMidiChannel


void MUSIC_SetVolume(int volume)
{
    volume = max(0, volume);
    volume = min(volume, 255);

    Mix_VolumeMusic(volume >> 1);  // convert 0-255 to 0-128.
} // MUSIC_SetVolume


void MUSIC_SetMidiChannelVolume(int channel, int volume)
{
//    UNREFERENCED_PARAMETER(channel);
//    UNREFERENCED_PARAMETER(volume);
} // MUSIC_SetMidiChannelVolume


void MUSIC_ResetMidiChannelVolumes(void)
{
} // MUSIC_ResetMidiChannelVolumes


int MUSIC_GetVolume(void)
{
    return(Mix_VolumeMusic(-1) << 1);  // convert 0-128 to 0-255.
} // MUSIC_GetVolume


void MUSIC_SetLoopFlag(int loopflag)
{
    music_loopflag = loopflag;
} // MUSIC_SetLoopFlag


int MUSIC_SongPlaying(void)
{
    return((Mix_PlayingMusic()) ? TRUE : FALSE);
} // MUSIC_SongPlaying


void MUSIC_Continue(void)
{
    if (Mix_PausedMusic())
        Mix_ResumeMusic();
} // MUSIC_Continue


void MUSIC_Pause(void)
{
    Mix_PauseMusic();
} // MUSIC_Pause

int MUSIC_StopSong(void)
{
    //if (!fx_initialized)
    if (!Mix_QuerySpec(NULL, NULL, NULL))
    {
        setErrorMessage("Need FX system initialized, too. Sorry.");
        return(MUSIC_Error);
    } // if

    if ((Mix_PlayingMusic()) || (Mix_PausedMusic()))
        Mix_HaltMusic();

    if (music_musicchunk)
        Mix_FreeMusic(music_musicchunk);

    music_musicchunk = NULL;

    return(MUSIC_Ok);
} // MUSIC_StopSong

// Duke3D-specific.  --ryan.
// void MUSIC_PlayMusic(char *_filename)
int MUSIC_PlaySong(unsigned char *song, unsigned int length, int loopflag)
{
    char magic[5];

    printf("sdlmusic.c MUSIC_PlaySong()\n");
    MUSIC_StopSong();

    Bstrncpyz(magic, song,5);
    printf("Music length: %d\nMagic number: %s\n",length,magic);

    
    /*printf("Writing tmp.mid... ");
    FILE* fd = fopen("tmp.mid","wb");
    
    if (fd != NULL) {
      printf("%d bytes written.\n",fwrite(song,1,length,fd));
      fclose(fd);
    } else {
      printf("FAILED.\n");
    }
    music_musicchunk = Mix_LoadMUS("tmp.mid");*/
    
    SDL_RWops *rw = SDL_RWFromMem((char *) song, length);

    if (rw == NULL) {
       printf("ERROR: rw == NULL\n");
    } else {
       SDL_RWread(rw,magic,1,4);
       printf("SDL_RWops magic number: %s\n",magic);
    }

    music_musicchunk = Mix_LoadMUS_RW(rw);
    
    if (music_musicchunk == NULL) {
       printf("ERROR: music_musicchunk == NULL\nMix_GetError: %s\n",Mix_GetError());
    }
        
    if (music_musicchunk != NULL) {
        printf("Playing music...\n");
        if (Mix_PlayMusic(music_musicchunk, (loopflag == MUSIC_LoopSong)?-1:0) == -1)
            printf("Mix_PlayMusic: %s\n", Mix_GetError());
    }
   
    printf("MUSIC_PlaySong() done.\n");

    return MUSIC_Ok;
}


void MUSIC_SetContext(int context)
{
    music_context = context;
} // MUSIC_SetContext


int MUSIC_GetContext(void)
{
    return(music_context);
} // MUSIC_GetContext


void MUSIC_SetSongTick(unsigned long PositionInTicks)
{
//    UNREFERENCED_PARAMETER(PositionInTicks);
} // MUSIC_SetSongTick


void MUSIC_SetSongTime(unsigned long milliseconds)
{
//    UNREFERENCED_PARAMETER(milliseconds);
}// MUSIC_SetSongTime


void MUSIC_SetSongPosition(int measure, int beat, int tick)
{
/*    UNREFERENCED_PARAMETER(measure);
    UNREFERENCED_PARAMETER(beat);
    UNREFERENCED_PARAMETER(tick);*/
} // MUSIC_SetSongPosition


void MUSIC_GetSongPosition(songposition *pos)
{
//    UNREFERENCED_PARAMETER(pos);
} // MUSIC_GetSongPosition


void MUSIC_GetSongLength(songposition *pos)
{
  //  UNREFERENCED_PARAMETER(pos);
} // MUSIC_GetSongLength


int MUSIC_FadeVolume(int tovolume, int milliseconds)
{
    //UNREFERENCED_PARAMETER(tovolume);
    Mix_FadeOutMusic(milliseconds);
    return(MUSIC_Ok);
} // MUSIC_FadeVolume


int MUSIC_FadeActive(void)
{
    return((Mix_FadingMusic() == MIX_FADING_OUT) ? TRUE : FALSE);
} // MUSIC_FadeActive


void MUSIC_StopFade(void)
{
} // MUSIC_StopFade


void MUSIC_RerouteMidiChannel(int channel, int (*function)(int, int, int))
{
/*    UNREFERENCED_PARAMETER(channel);
    UNREFERENCED_PARAMETER(function);*/
} // MUSIC_RerouteMidiChannel


void MUSIC_RegisterTimbreBank(unsigned char *timbres)
{
//    UNREFERENCED_PARAMETER(timbres);
} // MUSIC_RegisterTimbreBank


void MUSIC_Update(void)
{}
