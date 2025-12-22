/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * waveout.c
 *
 * WAVE file output.  Context writes, we save and sleep.
 *
 */
#include "al_siteconfig.h"

#include <AL/altypes.h>
#include <AL/alkludge.h>

#include "al_siteconfig.h"

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include "al_main.h"
#include "al_debug.h"

#include "arch/waveout/waveout.h"
#include "arch/interface/interface_sound.h"

#define WAVEOUT_NAMELEN 16
#define RIFFMAGIC       0x46464952
#define WAVEMAGIC       0x45564157
#define FMTMAGIC        0x20746D66
#define DATAMAGIC	0x61746164
#define HEADERSIZE      28
#define DATAADJUSTMENT  44

#define MAXNAMELEN      1024

typedef struct waveout_s {
	FILE *fh;

	ALuint format;
	ALuint speed;
	ALuint channels;

	ALuint length;

	ALushort bitspersample;

	char name[WAVEOUT_NAMELEN];
} waveout_t;

static ALuint sleep_usec(ALuint speed, ALuint chunk);
static void apply_header(waveout_t *wave);
static const char *waveout_unique_name(char *template);

void *grab_write_waveout(void) {
	FILE *fh;
	waveout_t *retval = NULL;
	char template[MAXNAMELEN] = "openal-";

	if(waveout_unique_name(template) == NULL) {
		perror("tmpnam");
	}

	fh = fopen(template, "w+b");
	if(fh == NULL) {
		fprintf(stderr,
			"waveout grab audio %s failed\n", template);
		return NULL;
	}

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		fclose(fh);
		return NULL;
	}

	memset(retval, 0, sizeof *retval);

	/* set to return params */
	retval->fh = fh;
	strncpy(retval->name, template, WAVEOUT_NAMELEN);

	blitbuffer = waveout_blitbuffer;

	retval->length = 0;

	fprintf(stderr, "waveout grab audio %s\n", template);
		
	debug(ALD_CONTEXT, __FILE__, __LINE__,
		"waveout grab audio ok");

	fseek(retval->fh, SEEK_SET, HEADERSIZE); /* leave room for header */
        return retval;
}

void *grab_read_waveout(void) {
	return NULL;
}

void waveout_blitbuffer(void *handle, void *dataptr, int bytes_to_write)  {
	waveout_t *whandle = NULL;
	
	if(handle == NULL) {
		return;
	}
	
	whandle = handle;

	if(whandle->fh == NULL) {
		return;
	}

	whandle->length += bytes_to_write;

	fwrite(dataptr, 1, bytes_to_write, whandle->fh);

	_alMicroSleep(sleep_usec(whandle->speed, bytes_to_write));
	
        return;
}

/*
 *  close file, free data
 */
void release_waveout(void *handle) {
	waveout_t *closer;

	if(handle == NULL) {
		return;
	}

	closer = handle;

	fprintf(stderr, "releasing waveout file %s\n",
		closer->name);

	fflush(closer->fh);
	apply_header(closer);

	fclose(closer->fh);
	free(closer);

	return;
}

static ALuint sleep_usec(ALuint speed, ALuint chunk) {
	ALuint retval;

	retval = 1000000.0 * chunk / speed;

#if 0
	fprintf(stderr,
		"(speed %d chunk %d retval = %d)\n",
		speed,
		chunk,
		retval);
#endif 

	return retval;
}

/*
 *  FIXME: make endian correct
 */
static void apply_header(waveout_t *wave) {
	ALushort writer16;
	ALuint   writer32;

	/* go to beginning */
	if(fseek(wave->fh, SEEK_SET, 0) != 0) {
		fprintf(stderr,
			"Couldn't reset %s\n", wave->name);
	}

        /* 'RIFF' */
	writer32 = RIFFMAGIC;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

	/* total length */
	fwrite(&wave->length, 1, sizeof wave->length, wave->fh);

        /* 'WAVE' */
	writer32 = WAVEMAGIC;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

        /* 'fmt ' */
	writer32 = FMTMAGIC;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

        /* fmt chunk length */
	writer32 = 16;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

        /* ALushort encoding */
	writer16 = 1;
	fwrite(&writer16, 1, sizeof writer16, wave->fh);

	/* Alushort channels */
	writer16 = wave->channels;
	fwrite(&writer16, 1, sizeof writer16, wave->fh);

	/* ALuint frequency */
	writer32 = wave->speed;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

	/* ALuint byterate  */
	writer32 = wave->speed / sizeof (ALshort); /* FIXME */
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

	/* ALushort blockalign */
	writer16 = 0;
	fwrite(&writer16, 1, sizeof writer16, wave->fh);

	/* ALushort bitspersample */
	writer16 = wave->bitspersample;
	fwrite(&writer16, 1, sizeof writer16, wave->fh);

        /* 'data' */
	writer32 = DATAMAGIC;
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

	/* data length */
	writer32 = wave->length - DATAADJUSTMENT; /* samples */
	fwrite(&writer32, 1, sizeof writer32, wave->fh);

	fprintf(stderr, "waveout length %d\n", wave->length);

	return;
}

static const char *waveout_unique_name(char *template) {
	static char retval[MAXNAMELEN];
	int template_offset;
	static int sequence = 0;
	struct stat buf;

	strncpy(retval, template, MAXNAMELEN - 2);
	retval[MAXNAMELEN - 1] = '\0';

	template_offset = strlen(retval);

	if(template_offset >= MAXNAMELEN - 28) { /* kludgey */
		/* template too big */
		return NULL;
	}

	do {
		/* repeat until we have a unique name */
		sprintf(&retval[template_offset], "%d.wav", sequence++);
		strncpy(template, retval, MAXNAMELEN);
	} while(stat(retval, &buf) == 0);

	return retval;
}

ALboolean set_write_waveout(void *handle,
		  UNUSED(ALuint *bufsiz),
		  ALuint *fmt,
		  ALuint *speed) {
	waveout_t *whandle;
	ALuint chans = _al_ALCHANNELS(*fmt);

	if(handle == NULL) {
		return AL_FALSE;
	}

	whandle = handle;

	whandle->speed    = *speed;
	whandle->format   = *fmt;
	whandle->channels = chans; 
	whandle->bitspersample = _al_formatbits(*fmt);

        return AL_TRUE;
}

ALboolean set_read_waveout(UNUSED(void *handle),
		  UNUSED(ALuint *bufsiz),
		  UNUSED(ALuint *fmt),
		  UNUSED(ALuint *speed)) {

	return AL_FALSE;
}
