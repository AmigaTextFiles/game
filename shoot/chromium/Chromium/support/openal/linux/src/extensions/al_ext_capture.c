/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_ext_capture.c
 *
 * audio recording extension
 *
 */
#include "al_siteconfig.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "AL/al.h"

#include "al_ext_needed.h"
#include "al_ext_capture.h"

#include "al_buffer.h"
#include "al_complex.h"
#include "al_error.h"
#include "al_debug.h"
#include "al_fft.h"
#include "al_mixer.h"
#include "al_source.h"
#include "alc/alc_context.h"
#include "alc/alc_speaker.h"
#include "al_types.h"

#include <audioconvert.h>

#include "arch/interface/interface_sound.h"
#include "mutex/mutexlib.h"

#define CAPTUREID_START 0x9090

#ifdef OPENAL_EXTENSION

/*
 * we are not being build into the library, therefore define the
 * table that informs openal how to register the extensions upon
 * dlopen.
 */
struct { ALubyte *name; void *addr; } alExtension_03282000 [] = {
	AL_EXT_PAIR(alGenCaptures_EXT),
	AL_EXT_PAIR(alDeleteCaptures_EXT),
	AL_EXT_PAIR(alCapturei_EXT),
	AL_EXT_PAIR(alCaptureStart_EXT),
	AL_EXT_PAIR(alCaptureStop_EXT),
	AL_EXT_PAIR(alIsCapture_EXT),
	AL_EXT_PAIR(alBufferRetrieveData_EXT),
	{ NULL, NULL }
};

/*
 *  We don't need init or fini functions, but we might as well
 *  keep them in place if, in some distant future, they turn out
 *  to be useful.
 */
void alExtInit_03282000(void) {
	fprintf(stderr, "alExtInit_03282000 STUB\n");
	return;
}

void alExtFini_03282000(void) {
	fprintf(stderr, "alExtFini_03282000 STUB\n");
	return;
}
#endif /* OPENAL_EXTENSION */

typedef struct _AL_capnode {
	AL_capture *cap;
	struct _AL_capnode *next;
} AL_capnode;

static MutexID capture_mutex = NULL;

static void _alCaptureDestroy(ALuint cpid);
static ALuint _alCaptureCreate(void);
static void _alCaptureInit(AL_capture *cap);
static AL_capnode *_alCaptureListAdd(AL_capture *retval);
static AL_capnode *_alCaptureListRemove(AL_capture *retval);
static void *_alGetCaptureParam(AL_capture *cap, ALenum param);

static AL_capnode *capture_list = NULL;

void alGenCaptures_EXT(ALsizei n, ALuint *cpids) {
	ALuint *temp;
	int i;

	_alLockCapture();

	temp = malloc(n * sizeof *temp);
	if(temp == NULL) {
		_alcDCLockContext();
		_alDCSetError(AL_OUT_OF_MEMORY);
		_alcDCUnlockContext();

		_alUnlockCapture();
		return;
	}

	/* alloc captures */
	for(i = 0; i < n; i++) {
		temp[i] = _alCaptureCreate();
	}

	/* check captures */
	for(i = 0; i < n; i++) {
		if(_alIsCapture(temp[i]) == AL_FALSE) {
			free(temp);

			_alcDCLockContext();
			_alDCSetError(AL_OUT_OF_MEMORY);
			_alcDCUnlockContext();

			_alUnlockCapture();
			return;
		}
	}

	memcpy(cpids, temp, n * sizeof *cpids);

	free(temp);

	_alUnlockCapture();

	return;
}

void alDeleteCaptures_EXT(ALsizei n, ALuint *cpids) {
	int i;

	_alLockCapture();

	for(i = 0; i < n; i++) {
		if(_alIsCapture(cpids[i] == AL_FALSE)) {
			_alcDCLockContext();
			_alDCSetError(AL_INVALID_NAME);
			_alcDCUnlockContext();

			_alUnlockCapture();

			return;
		}
	}

	for(i = 0; i < n; i++) {
		_alCaptureDestroy(cpids[i]);
	}

	_alUnlockCapture();

	return;
}

void alCapturei_EXT(ALuint cpid, ALenum param, ALint value) {
	AL_capture *cap;
	AL_buffer *buf;

	_alLockCapture();

	cap = _alGetCapture(cpid);
	if(cap == NULL) {
		/* FIXME: set error */
		fprintf(stderr, "%d not a valid cpid\n", cpid);

		_alUnlockCapture();

		return;
	}

	switch(param) {
		case AL_BUFFER:
			/*
			 * set buffer params here.  Is this right?
			 */
			_alLockBuffer();

			buf = _alGetBuffer( value );
			if(buf == NULL) {
				fprintf(stderr, "%d not a valid bid\n", value);

				_alUnlockBuffer();
				_alUnlockCapture();

				return;
			}

			buf->freq = _alcDCGetReadFreq();
			buf->format = _alcDCGetReadFormat();

			_alUnlockBuffer();

			cap->bid.isset = AL_TRUE;
			cap->bid.data = value;
			break;
		default:
			fprintf(stderr, "tsao: alCapturei(%d, 0x%x, %d)\n",
				cpid, param, value);
			break;
	}

	_alUnlockCapture();

	return;
}

void alCaptureStart_EXT(UNUSED(ALuint cpid)) {
	_alLockCapture();
	_alLockMixBuf();

	_alAddCaptureToMixer(cpid);

	_alUnlockMixBuf();
	_alUnlockCapture();

	return;
}

void alCaptureStop_EXT(UNUSED(ALuint cpid)) {
	_alLockMixBuf();
	_alLockCapture();

	_alRemoveCaptureFromMixer(cpid);

	_alUnlockCapture();
	_alUnlockMixBuf();

	return;
}

ALboolean alIsCapture_EXT(ALuint cpid) {
	ALboolean retval = AL_FALSE;

	_alLockCapture();

	retval = _alIsCapture(cpid);

	_alUnlockCapture();

	return retval;
}

ALboolean _alIsCapture(ALuint cpid) {
	AL_capture *cap = _alGetCapture(cpid);

	if(cap == NULL) {
		return AL_FALSE;
	}

	return AL_TRUE;
}

void FL_alLockCapture(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alLockCapture", fn, ln);

	if(capture_mutex == NULL) {
		capture_mutex = mlCreateMutex();
	}

	mlLockMutex(capture_mutex);

	return;
}

void FL_alUnlockCapture(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alUnlockCapture", fn, ln);

	if(capture_mutex == NULL) {
		return;
	}

	mlUnlockMutex(capture_mutex);

	return;
}

/*
 * assumes locked captures
 */
static ALuint _alCaptureCreate(void) {
	AL_capture *retval;
	static ALuint newid = CAPTUREID_START;

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		return 0;
	}

	_alCaptureInit(retval);

	retval->cpid = newid++;

	capture_list = _alCaptureListAdd(retval);

	return retval->cpid;
}

/*
 * assumes that cpid is a value cpid.
 *
 * assumes locked captures
 */
static void _alCaptureDestroy(ALuint cpid) {
	AL_capture *victim;

	victim = _alGetCapture(cpid);
	if(victim == NULL) {
		/* boo */
		return;
	}

	capture_list = _alCaptureListRemove(victim);

	free(victim);

	return;
}

static void _alCaptureInit(AL_capture *cap) {
	cap->cpid = 0;

	cap->bid.isset = AL_FALSE;
	cap->bid.data  = 0;

	return;
}

AL_capture *_alGetCapture(ALuint cpid) {
	AL_capnode *itr;

	itr = capture_list;
	while(itr) {
		if(itr->cap->cpid == cpid) {
			return itr->cap;
		}

		itr = itr->next;
	}

	return NULL;
}

static AL_capnode *_alCaptureListAdd(AL_capture *cap) {
	AL_capnode *retval;

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		return capture_list;
	}

	retval->cap = cap;
	retval->next = capture_list;

	return retval;
}

static AL_capnode *_alCaptureListRemove(AL_capture *cap) {
	AL_capnode *itr;
	AL_capnode *prev;

	prev = capture_list;
	itr = capture_list;
	while(itr != NULL) {
		if(itr->cap == cap) {
			if(prev == itr) {
				/* both head node, no need to 
				 * remove.
				 */
				return itr->next;
			} else {
				prev->next = itr;

				return capture_list;
			}
		}

		prev = itr;
		itr = itr->next;
	}

	/* not found */
	return capture_list;
}

static void *_alGetCaptureParam(AL_capture *cap, ALenum param) {
	switch(param) {
		case AL_BUFFER:
			if(cap->bid.isset == AL_TRUE) {
				return &cap->bid.data;
			}
			break;
		default:
			break;
	}

	return NULL;
}

void _alCaptureAppendData(AL_capture *cap, ALvoid *capture_buffer, ALuint bytes) {
	ALuint *bid;
	AL_buffer *buf;
	void *temp;
	ALuint i;

	ALenum format;
	ALuint freq;
	ALsizei size;

	_alLockCapture();

	bid = _alGetCaptureParam(cap, AL_BUFFER);
	if(bid == NULL) {
		fprintf(stderr, "no bid\n");

		/* FIXME: set error? */
		_alUnlockCapture();

		return;
	}

	_alLockBuffer();
	buf = _alGetBuffer(*bid);
	if(buf == NULL) {
		fprintf(stderr, "no buf\n");

		/* FIXME: set error? */
		_alUnlockBuffer();
		_alUnlockCapture();

		return;
	}

	format = buf->format;
	freq   = buf->freq;
	size   = buf->size;

	for(i = 0; i < buf->num_buffers; i++) {
		temp = realloc(buf->orig_buffers[i], size + bytes);
		if(temp == NULL) {
			fprintf(stderr, "no realloc\n");

			/* FIXME: set error? */
			_alUnlockBuffer();
			_alUnlockCapture();

			return;
		}

		buf->orig_buffers[i] = temp;

		/* append the data */
		_alBuffersAppend(&buf->orig_buffers[i], &capture_buffer, bytes, size, 1);
	}

	buf->size += bytes;

	_alUnlockBuffer();
	_alUnlockCapture();

	return;
}

void alInitCapture(void) {
	return;
}

void alFiniCapture(void) {
	return;
}

ALuint alBufferRetrieveData_EXT(UNUSED(ALuint bid),
			    	UNUSED(ALenum format),
			    	UNUSED(ALvoid *buffer),
			    	UNUSED(ALsizei samples),
			    	UNUSED(ALuint freq)) {
	ALuint csamps = 0;
	AL_buffer *buf;
	ALuint psize;  /* predicted size in bytes */
	ALuint orig_csamps;
	ALuint copysize = 0;
	void *temp = NULL;
	int nc;
	ALuint size;

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		fprintf(stderr, "%d not a valid bid\n", bid);

		_alUnlockBuffer();

		return 0;
	}

	/* nc is the number of channels that buf is stored in */
	nc = _al_ALCHANNELS(buf->format);

	/*
	 * Set csamps to the size of samples in bytes.
	 *
	 * make sure that csamps contains an even multiple of
	 * the number of channels
	 */
	csamps  = samples;
	csamps -= (csamps % _al_ALCHANNELS(format));
	csamps *= (_al_formatbits(format) / 8);

	orig_csamps = csamps;

	psize = csamps * _al_PCMRatio(freq, buf->freq, format, buf->format);

	if(buf->streampos < buf->appendpos) {
		/* reader preceeds writer */
		ALuint possible_bytes = buf->appendpos - buf->streampos;

		if(psize > possible_bytes) {
			/* if the requested size is greater than we have
			 * available, return only as much as we can.
			 */
			copysize = possible_bytes;
		} else {
			copysize = psize;
		}

	} else {
		/* writer preceesed reader, so we copy from reader to end */
		ALuint possible_bytes = buf->size - buf->streampos;

		if(psize > possible_bytes) {
			/* if the requested size is greater than we have
			 * available, return only as much as we can.
			 */
			copysize = possible_bytes;
		} else {
			copysize = psize;
		}
	}

	size = copysize;
	temp = malloc( csamps );

	_alChannelifyOffset(temp, buf->streampos,
			    (ALshort **) buf->orig_buffers, size, buf->num_buffers);

	temp = _alBufferCanonizeData(buf->format,
				     temp,
				     size,
				     buf->freq,

				     format,
				     freq,
				     &copysize,
				     AL_TRUE);
	if(temp == NULL) {
		fprintf(stderr, "could not canonize data\n");

		/* FIXME:  do something */
		_alUnlockBuffer();

		return 0;
	}

	memcpy(buffer, temp, copysize);

	free( temp );

	buf->streampos += copysize / nc;
	if(buf->streampos >= buf->size) {
		buf->streampos = 0;
		buf->appendpos = 0;
	}

	_alUnlockBuffer();

	csamps = size * (1.0 / psize);

	return csamps;
}
