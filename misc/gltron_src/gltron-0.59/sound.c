/* AHI sound driver for amiga                              */
/* Written by Jarmo Laakkonen (jami.laakkonen@kolumbus.fi) */
/* Based on the SimplePlay example in AHI archive          */
/*                                                         */
/* TODO: Add WAV support                                   */


#include <devices/ahi.h>
#include <exec/exec.h>
#include <dos/dos.h>
#include <dos/exall.h>
#include <proto/ahi.h>
#include <proto/exec.h>
#include <proto/dos.h>

#include "sound.h"
#include "gltron.h"

#define CHANNELS 8
#define MAXSAMPLES 10

struct	Library				*AHIBase;
struct	MsgPort				*AHImp = NULL;
struct	AHIRequest		*AHIio = NULL;
BYTE		AHIDevice	= 	-1;
struct	AHIAudioCtrl	*actrl = NULL;

LONG mixfreq = 0;

#define NUM_GAME_FX 5
#define NUM_MENU_FX 2

/* These need to be raw 11025Hz samples as wav loading is not supported yet */
static char *game_fx_names[] = {
  "game_engine.raw",
  "game_start.raw",
  "game_crash.raw",
  "game_win.raw",
  "game_lose.raw"
};

static char *menu_fx_names[] = {
  "menu_action.raw",
  "menu_highlight.raw"
};

struct Samples {
	APTR	sample; /* Pointer to the AHI sample in memory */
	UWORD	id;			/* AHI sample id */
};

static struct Samples game_samples[NUM_GAME_FX] = {
	{NULL, 0},
	{NULL, 0},
	{NULL, 0},
	{NULL, 0},
	{NULL, 0}
};

static struct Samples menu_samples[NUM_MENU_FX] = {
	{NULL, 0},
	{NULL, 0}
};

void LoadFX()
{
	int length,i;
	char *path;
	struct AHISampleInfo sample;
	UWORD id = 0;
	BPTR file;

	for(i = 0; i < NUM_GAME_FX; i++) {
		id++;
		if ((path = getFullPath(game_fx_names[i]))) {
			if ((file = Open(path, MODE_OLDFILE))) {
				Seek(file, 0, OFFSET_END);
				length = Seek(file, 0, OFFSET_BEGINNING);
				if ((game_samples[i].sample = AllocVec(length, MEMF_PUBLIC))) {
					Read(file, game_samples[i].sample, length);
					sample.ahisi_Type = AHIST_M16S;
					sample.ahisi_Address = game_samples[i].sample;
					sample.ahisi_Length = length / AHI_SampleFrameSize(AHIST_M16S);
					if (!AHI_LoadSound(id, AHIST_SAMPLE, &sample, actrl)) {
						game_samples[i].id = id;
					}
					else {
						printf("Can't load sound %s!\n", path);
						exit(RETURN_FAIL);
					}
				}
				else {
					printf("Out of memory!\n");
					exit(RETURN_FAIL);
				}
				Close(file);
			}
			else {
				printf("Can't open file %s!\n", path);
				exit(RETURN_FAIL);
			}
			free(path);
		}
	}

	for(i = 0; i < NUM_MENU_FX; i++) {
		id++;
		if ((path = getFullPath(menu_fx_names[i]))) {
			if ((file = Open(path, MODE_OLDFILE))) {
				Seek(file, 0, OFFSET_END);
				length = Seek(file, 0, OFFSET_BEGINNING);
				if ((menu_samples[i].sample = AllocVec(length, MEMF_PUBLIC))) {
					Read(file, menu_samples[i].sample, length);
					sample.ahisi_Type = AHIST_M16S;
					sample.ahisi_Address = menu_samples[i].sample;
					sample.ahisi_Length = length / AHI_SampleFrameSize(AHIST_M16S);
					if (!AHI_LoadSound(id, AHIST_SAMPLE, &sample, actrl)) {
						menu_samples[i].id = id;
					}
					else {
						printf("Can't load sound %s!\n", path);
						exit(RETURN_FAIL);
					}
				}
				else {
					printf("Out of memory!\n");
					exit(RETURN_FAIL);
				}
				Close(file);
			}
			else {
				printf("Can't open file %s!\n", path);
				exit(RETURN_FAIL);
			}
			free(path);
		}
	}
}

BOOL AllocAudio()
{
  struct AHIAudioModeRequester *req;
  BOOL   rc = FALSE;
	STRPTR buf = NULL;
	STRPTR buf2 = NULL;
	LONG	 len, len2;

	if ((buf = malloc(256)) == NULL || (buf2 = malloc(256)) == NULL) {
		printf("Out of memory!\n");
		return rc;
	}

	len = GetVar("GLTRON_AHIMODE", buf, 256, GVF_GLOBAL_ONLY);
	len2 = GetVar("GLTRON_AHIFREQ", buf2, 256, GVF_GLOBAL_ONLY);

	if ((len !=-1) && (len2 !=-1)) {
		actrl = AHI_AllocAudio(
					AHIA_AudioID, atoi((const char*)buf),
					AHIA_MixFreq, atoi((const char*)buf2),
					AHIA_Channels, CHANNELS,
					AHIA_Sounds, MAXSAMPLES,
					TAG_DONE);
		if (actrl)
			rc = TRUE;
	}
	else {
  	req = AHI_AllocAudioRequest(
      	AHIR_PubScreenName, NULL,
      	AHIR_TitleText,     (ULONG)"Select a mode and rate",
      	AHIR_DoMixFreq,     TRUE,
      	TAG_DONE);

  	if(req) {
    	if(AHI_AudioRequest(req, TAG_DONE)) {
      	actrl = AHI_AllocAudio(
          	AHIA_AudioID,         req->ahiam_AudioID,
          	AHIA_MixFreq,         req->ahiam_MixFreq,
          	AHIA_Channels,        CHANNELS,
          	AHIA_Sounds,          MAXSAMPLES,
          	TAG_DONE);
      	if(actrl) {
					AHI_ControlAudio(actrl, AHIC_MixFreq_Query, (ULONG)&mixfreq, TAG_DONE);
					sprintf((char *)buf, "%ld", req->ahiam_AudioID);
					SetVar("ENVARC:GLTron_AHIMODE", buf, -1, GVF_GLOBAL_ONLY);
					SetVar("ENV:GLTron_AHIMODE", buf, -1, GVF_GLOBAL_ONLY);
					sprintf((char *)buf, "%ld", req->ahiam_MixFreq);
					SetVar("ENVARC:GLTron_AHIFREQ", buf, -1, GVF_GLOBAL_ONLY);
					SetVar("ENV:GLTron_AHIFREQ", buf, -1, GVF_GLOBAL_ONLY);
        	rc = TRUE;
      	}
    	}
    	AHI_FreeAudioRequest(req);
  	}
	}
	free(buf);
	free(buf2);
  return rc;
}

int initSound(void)
{
	atexit(shutdownSound);

	if((AHImp = CreateMsgPort())) {
		if((AHIio = (struct AHIRequest *)CreateIORequest(AHImp,
								sizeof(struct AHIRequest)))) {
			AHIio->ahir_Version = 4;
			AHIDevice = OpenDevice("ahi.device", AHI_NO_UNIT, (struct IORequest *)AHIio, NULL);
			if (!AHIDevice) {
				AHIBase = (struct Library *)AHIio->ahir_Std.io_Device;
				if(AllocAudio() == FALSE) {
					printf("Can't allocate audio!\n");
					exit(RETURN_FAIL);
				}
				LoadFX();
				if(AHI_ControlAudio(actrl, AHIC_Play, TRUE, TAG_DONE)) {
					printf("Can't start audio playback!\n");
					exit(RETURN_FAIL);
				}
			}
			else {
				printf("Can't open ahi.device v4!\n");
				exit(RETURN_FAIL);
			}
		}
		else {
			printf("Can't create io request!\n");
			exit(RETURN_FAIL);
		}
	}
	else {
		printf("Can't create message port!\n");
		exit(RETURN_FAIL);
	}

	return 0;
}

void shutdownSound()
{
	int i;

	if (actrl)
		AHI_ControlAudio(actrl, AHIC_Play, FALSE, TAG_DONE);

	for(i = 0; i < NUM_MENU_FX; i++) {
		if (menu_samples[i].sample) {
			AHI_UnloadSound(menu_samples[i].id, actrl);
			FreeVec(menu_samples[i].sample);
			menu_samples[i].sample = NULL;
		}
	}

	for(i = 0; i < NUM_GAME_FX; i++) {
		if (game_samples[i].sample) {
			AHI_UnloadSound(game_samples[i].id, actrl);
			FreeVec(game_samples[i].sample);
			game_samples[i].sample = NULL;
		}
	}

	if (actrl) {
  	AHI_FreeAudio(actrl);
  	actrl = NULL;
	}

  if(!AHIDevice) {
    CloseDevice((struct IORequest *)AHIio);
  	AHIDevice=-1;
	}

	if (AHIio) {
  	DeleteIORequest((struct IORequest *)AHIio);
  	AHIio=NULL;
	}

	if (AHImp) {
  	DeleteMsgPort(AHImp);
  	AHImp=NULL;
	}
}

int loadSound(char *name)
{
	return 0;
}

int playSound()
{
	return 0;
}

int stopSound()
{
	return 0;
}

void soundIdle()
{
}

void playGameFX(int fx)
{
	AHI_Play(actrl, AHIP_BeginChannel, fx, AHIP_Freq, 11025, AHIP_Vol, 0x10000,
									AHIP_Pan, 0x8000, AHIP_Sound, game_samples[fx].id,
									AHIP_LoopSound, AHI_NOSOUND, AHIP_EndChannel, NULL,
									TAG_DONE);
}

void playMenuFX(int fx)
{
	AHI_Play(actrl, AHIP_BeginChannel, NUM_GAME_FX + fx, AHIP_Freq, 11025,
									AHIP_Vol, 0x10000, AHIP_Pan, 0x8000,
									AHIP_Sound, menu_samples[fx].id,
									AHIP_LoopSound, AHI_NOSOUND, AHIP_EndChannel, NULL,
									TAG_DONE);
						
}

void playEngine()
{
	AHI_Play(actrl, AHIP_BeginChannel, 0, AHIP_Freq, 11025, AHIP_Vol, 0x10000,
									AHIP_Pan, 0x8000, AHIP_Sound, game_samples[0].id,
									AHIP_EndChannel, NULL, TAG_DONE);
}

void stopEngine()
{
	AHI_SetSound(0, AHI_NOSOUND, 0, 0, actrl, AHISF_IMM);
}

void setMusicVolume(float volume)
{
}

void setFxVolume(float volume)
{
/* How to convert float to fixed for AHI? */
}
