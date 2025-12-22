#include "fixer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cdplayer.h"
#include "bink.h"


static BOOL cdStarted = FALSE;
static BOOL cdPlaying = FALSE;
int CDPlayerVolume = 127;
int MusicIsEnabled = 1;

#define cdTrackCount 15

const char* cdTrackFilenames[cdTrackCount] =
{
	"FMVs/01 Marine Music 1.bik",
	"FMVs/02 Colony.bik",
	"FMVs/03 Invasion.bik",
	"FMVs/04 Orbital.bik",
	"FMVs/05 Tyrargo.bik",
	"FMVs/06 Waterfall.bik",
	"FMVs/07 Area 52.bik",
	"FMVs/08 Vaults.bik",
	"FMVs/09 Fury 161.bik",
	"FMVs/10 Caverns.bik",
	"FMVs/11 Ferarco.bik",
	"FMVs/12 Temple.bik",
	"FMVs/13 Gateway.bik",
	"FMVs/14 Escape.bik",
	"FMVs/15 Earthbound.bik"
};

BOOL cdTrackAvailable[cdTrackCount] = { TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE };


void CheckCDVolume()
{
}

void CDDA_Start()
{
	if(!cdStarted)
	{
		cdStarted = TRUE;
		cdPlaying = FALSE;
	}
}


void CDDA_End()
{
	CDDA_Stop();
}


void CDDA_ChangeVolume(int volume)
{
}


int CDDA_CheckNumberOfTracks()
{
	return cdTrackCount;
}


int CDDA_IsOn()
{
	return cdStarted;
}


int CDDA_IsPlaying()
{
	return (cdStarted && cdPlaying);
}

void CDDA_InternalPlay(int aTrack, BOOL aLoop)
{
	if(cdStarted)
	{
		CDDA_Stop();
		
		if(aTrack<0 || aTrack>=cdTrackCount)
			return;
			
		if(MusicIsEnabled && cdTrackAvailable[aTrack])
		{
			if(StartMusicBink(cdTrackFilenames[aTrack], aLoop))
				cdPlaying = TRUE;
			else
				cdTrackAvailable[aTrack] = FALSE;
		}
	}
}

void CDDA_Play(int CDDATrack)
{
	CDDA_InternalPlay(CDDATrack-1, FALSE);
}


void CDDA_PlayLoop(int CDDATrack)
{
	CDDA_InternalPlay(CDDATrack-1, TRUE);
}


void CDDA_Stop()
{
	if(cdStarted && cdPlaying)
	{
		EndMusicBink();
		cdPlaying = FALSE;
	}
}


void CDDA_SwitchOn()
{
}


void CDDA_Update()
{
	if(cdStarted && cdPlaying)
	{
		if(!MusicIsEnabled || !PlayMusicBink(CDPlayerVolume))
		{
			EndMusicBink();
			cdPlaying = FALSE;
		}
	}
}

