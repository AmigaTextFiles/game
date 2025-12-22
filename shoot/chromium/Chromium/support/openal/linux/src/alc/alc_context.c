/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * alc_context.c
 *
 * Context management and application level calls.
 */
#include "al_siteconfig.h"

#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alkludge.h>

#include "al_buffer.h"
#include "al_config.h"
#include "al_debug.h"
#include "al_listen.h"
#include "al_main.h"
#include "al_mixer.h"
#include "al_spool.h"
#include "al_source.h"
#include "al_types.h"
#include "al_filter.h"

#include "alc_context.h"
#include "alc_speaker.h"
#include "alc_error.h"

#include "mutex/mutexlib.h"

#include <fcntl.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <string.h>

#include "arch/interface/interface_sound.h"

#define CONTEXT_BASE   0x9000

/* global data */
const int canon_max = ((1<<(16-1))-1),
	  canon_min = -(1<<(16-1));

/* internal format */
ALenum canon_format   = _ALC_CANON_FMT;
ALuint canon_speed    = _ALC_CANON_SPEED;

/* format of output device */
static int write_format   = _ALC_EXTERNAL_FMT;
static int write_speed    = _ALC_EXTERNAL_SPEED;
static int write_bufsiz   = _ALC_DEF_BUFSIZ;
static void *write_handle = NULL;

static int read_format   = AL_FORMAT_MONO16;
static int read_speed    = _ALC_EXTERNAL_SPEED;
static int read_bufsiz   = _ALC_DEF_BUFSIZ;
static void *read_handle = NULL;

ALuint _alcCCId = (ALuint) -1; /* current context id */

/* static data */
static struct {
	ALuint size;
	ALuint items;

	ALuint *map;
	ALboolean *inuse;
	AL_context *pool;
} al_contexts = { 0, 0, NULL, NULL, NULL };

static MutexID all_context_mutex = NULL;
static MutexID *context_mutexen  = NULL;


/* static function prototypes */
static ALCenum _alcDestroyContext(AL_context *cc);
static void    _alcReallocContexts(ALuint newsize);
static ALuint _alcGenerateNewCid(void);
static ALuint  _alcCidToIndex(ALuint cid);
static ALuint  _alcIndexToCid(int index);

#ifdef JLIB
unsigned int jlib_debug = 0;
#endif

ALCenum alcMakeContextCurrent(void *handle) {
	AL_context *cc;
	int cid;
	static ALboolean ispaused = AL_FALSE;

	if(handle == NULL) {
		/* NULL handle means pause */
		if(ispaused == AL_FALSE) {
			if(al_contexts.items != 0) {
				/* only lock if a context has been
				 * created.  Otherwise, don't.
				 */

				/* Give mixer thread chance to catch up */

				_alLockMixerPause();

				_alcLockAllContexts();

				/*
				 * inform current audio device about
				 * impending stall.
				 */
				cc = _alcGetContext(_alcCCId);
				
				pause_audiodevice(cc->write_handle);
				/* FIXME: handle read? */	

				_alcCCId = (ALuint) -1;
				_alcUnlockAllContexts();
			}

			ispaused = AL_TRUE;
		}

		return ALC_NO_ERROR;
	}

	cid = (ALuint) handle;

	_alcLockAllContexts();

	_alcCCId = cid;

	cc = _alcGetContext(cid);

	if(set_write_audiodevice(cc->write_handle,
			   &cc->write_bufsiz,
			   &cc->write_format,
		           &cc->write_speed) != AL_TRUE) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
				"set_audiodevice failed.");
	}

	debug(ALD_CONVERT, __FILE__, __LINE__,
		"after set_audiodevice, f|c|s|b 0x%x|%d|%d|%d",
		cc->write_format,
		_al_ALCHANNELS(cc->write_format),
		cc->write_speed,
		cc->write_bufsiz);

	write_speed    = cc->write_speed;
	write_format   = cc->write_format;
	write_bufsiz   = cc->write_bufsiz;

	_alSetMixer(cc->should_sync); /* set mixing stats */

	if(ispaused == AL_TRUE) {
		/* someone unpaused us */
		ispaused = AL_FALSE;

		resume_audiodevice(cc->write_handle);
		/* FIXME: handle read_handle? */

		_alcUnlockAllContexts();
		_alUnlockMixerPause();
	} else {
		/* just unlock contexts */
		_alcUnlockAllContexts();
	}

	return ALC_NO_ERROR;
}

/*
 * External called function to destroy a context.
 *
 * Ugh.  This is an ugly looking function.
 */
ALCenum alcDestroyContext(void *handle) {
	AL_context *cc;
	ALCenum retval = ALC_NO_ERROR;
	void *dread_handle; /* device handle */
	void *dwrite_handle; /* device handle */
	int cid;

	if(handle == NULL) {
		return ALC_INVALID_CONTEXT;
	}

	cid = (ALuint) handle;

	_alcLockContext(cid);
	cc = _alcGetContext(cid);
	if(cc == NULL) {
		_alcUnlockContext(cid);
		return ALC_INVALID_CONTEXT;
	}

	/*
	 * If this is the last context, run _alExit()
	 * to clean up the cruft
	 */
	if(al_contexts.items == 1) {
		/* grab device handle, in case we need to release
		 * the device after destroying the context
		 */
		dread_handle = cc->read_handle;
		dwrite_handle = cc->write_handle;

		/* unlock context for final time */
		_alcUnlockContext(cid);

		/* cleanup */
		_alExit();

		/*
		 * Set NumContexts to 0
		 */
		al_contexts.items = 0;

		/*
		 * Destroy the all-locking-contexts
		 */
		mlDestroyMutex(all_context_mutex);
		all_context_mutex = NULL;

		/*
		 * release audio device
		 */
		release_audiodevice(dread_handle);
		release_audiodevice(dwrite_handle);

		return retval;
	}

	/* call internal destroyer */
	retval = _alcDestroyContext(cc);

	al_contexts.items--;
	_alcUnlockContext(cid);

	return retval;
}

void *alcUpdateContext(ALvoid *alcHandle) {
	AL_context *cc;
	int cid;
	ALboolean should_sync;

	if(alcHandle == NULL) {
		/*
		 * invalid name?
		 */
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alcUpdateContext: alcHandle == NULL");

		_alcSetError(ALC_INVALID_CONTEXT);
		return NULL;
	}

	cid = (ALuint) alcHandle;

	/* determine whether we need to sync or not */
	_alcLockAllContexts();

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alcUpdateContext: invalid context id %d",
		      cid);

		_alcSetError(ALC_INVALID_CONTEXT);

		_alcUnlockAllContexts();
		return NULL;
	}

	should_sync = cc->should_sync;
	_alcUnlockAllContexts();

	if(should_sync == AL_TRUE) {
		mixer_iterate(NULL);
	}

	return alcHandle;
}

/*
 * FIXME: not very well tested!
 *
 *
 * What is the greater sin?  converting int to void * or using
 * malloc for sizeof(int) bytes?
 */
void *alcCreateContext(int *attrlist) {
	ALint cid;

	if(al_contexts.items == 0) {
		/* first initialization */
		if(_alParseConfig() == AL_FALSE) {
			debug(ALD_CONTEXT, __FILE__, __LINE__,
				"Couldn't parse config file.");
		}

		/* Set sound device, initializing if needed */
		write_handle = grab_write_audiodevice();
		if(write_handle == NULL) {
			debug(ALD_CONTEXT,
				__FILE__, __LINE__,
				"Couldn't grab audio hardware.");

			return NULL;
		}

#ifdef JLIB
		if(getenv("JLIB_DEBUG")) {
			jlib_debug = atoi(getenv("JLIB_DEBUG"));
		}
#endif

		cid = _alcGetNewContextId();

		_alInit();

		_alcLockContext(cid);
		_alcSetContext(attrlist, cid);
		_alcUnlockContext(cid);

		alcMakeContextCurrent((ALvoid *) cid);

		return (ALvoid *) cid;
	}

	_alcLockAllContexts();
	cid = _alcGetNewContextId();
	if(cid == -1) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
				"alcCreateContext failed.");

		_alcSetError(ALC_INVALID_DEVICE);
		_alcUnlockAllContexts();
		return NULL;
	}

	_alcUnlockAllContexts();

	_alcLockContext(cid);

	_alcSetUse(cid, AL_TRUE);
	_alcSetContext(attrlist, cid);

	_alcUnlockContext(cid);

	return (ALvoid *) cid;
}

/*
 * FIXME: should assume that *all contexts* are locked?
 */
ALCenum _alcDestroyContext(AL_context *cc) {
	_alDestroyListener(&cc->listener);
	_alDestroySources(&cc->source_pool);

  	return ALC_NO_ERROR;
}

/*
 * Lock context numbered by cid.
 */
void FL_alcLockContext(ALuint cid, UNUSED(const char *fn), UNUSED(int ln)) {
	int cindex;

	_alLockPrintf("_alcLockContext", fn, ln);

	cindex = _alcCidToIndex(cid);

	ASSERT(cindex >= 0);

	_alcLockAllContexts();

	mlLockMutex(context_mutexen[cindex]);

	_alcUnlockAllContexts();

	return;
}

void FL_alcUnlockContext(ALuint cid, UNUSED(const char *fn), UNUSED(int ln)) {
	int cindex;

	_alLockPrintf("_alcUnlockContext", fn, ln);

	cindex = _alcCidToIndex(cid);

	ASSERT(cindex >= 0);

	mlUnlockMutex(context_mutexen[cindex]);

	return;
}

AL_context *_alcGetContext(ALuint cid) {
	ALuint cindex;

	cindex = _alcCidToIndex(cid);

	if(cindex >= al_contexts.size) {
		return NULL;
	}

	if(al_contexts.inuse[cindex] == AL_FALSE) {
		return NULL;
	}

	return &al_contexts.pool[cindex];
}


/*
 * FIXME: mostly untested!
 *
 */
void _alcSetContext(int *attrlist, ALuint cid ) {
	AL_context *cc;
	ALboolean reading_keys = AL_TRUE;
	struct {
		int key;
		int val;
	} rdr;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return;
	}

	/* Set our preferred mixer stats */
	cc->write_speed    = write_speed;
	cc->write_format   = write_format;
	cc->write_bufsiz   = write_bufsiz;

	cc->read_speed     = read_speed;
	cc->read_format    = read_format;
	cc->read_bufsiz    = read_bufsiz;

	while(attrlist && (reading_keys == AL_TRUE)) {
		rdr.key = *attrlist++;

		switch(rdr.key) {
			case ALC_FREQUENCY:
				rdr.val = *attrlist++;
				cc->write_speed    = rdr.val;
				canon_speed        = rdr.val;
				debug(ALD_CONTEXT,
					__FILE__, __LINE__,
					"cc->external_speed = %d",
					rdr.val);
				break;
			case ALC_RESOLUTION:
				rdr.val = *attrlist++;
				switch(rdr.val) {
					case 8:
					  cc->write_format = AL_FORMAT_STEREO8;
					  break;
					case 16:
					  cc->write_format = AL_FORMAT_STEREO16;
					  break;
					default:
					debug(ALD_CONTEXT,
						__FILE__, __LINE__,
						"unsupported resolution");
					break;
				}
				break;
			case ALC_CHANNELS:
				rdr.val = *attrlist++;
				_alStub("ALC_CHANNELS stub'ed");
				break;
			case ALC_REFRESH:
				rdr.val = *attrlist++;
				_alStub("ALC_REFRESH stub'ed");
				break;
			case ALC_MIXAHEAD:
				rdr.val = *attrlist++;
				_alStub("ALC_MIXAHEAD stub'ed");
				break;
			case ALC_BUFFERSIZE:
				rdr.val = *attrlist++;
				cc->write_bufsiz = rdr.val;
				cc->read_bufsiz  = rdr.val;

				debug(ALD_CONTEXT, __FILE__, __LINE__,
					"new bufsiz = %d", rdr.val);

				break;
			case ALC_SOURCES:
				rdr.val = *attrlist++;
				spool_resize(&cc->source_pool, rdr.val);
								
				debug(ALD_CONTEXT,
					__FILE__, __LINE__,
					"ALC_SOURCES (%d)", rdr.val);
				break;
			case ALC_BUFFERS:
				rdr.val = *attrlist++;

				_alNumBufferHint(rdr.val);
				break;
			case ALC_SYNC:
				rdr.val = *attrlist++;

				if(rdr.val == AL_TRUE) {
					cc->should_sync = AL_TRUE;
				} else {
					cc->should_sync = AL_FALSE;
				}
				break;
			case 0:
				reading_keys = AL_FALSE;
				break;
			default:
				reading_keys = AL_FALSE;
				break;
				debug(ALD_CONTEXT,
					__FILE__, __LINE__,
					"unsupported context attr %d",
					rdr.key);
				break;
		}
	}

	return;
}

/*
 * _alcInitContext initializes the context with id cid, and
 * returns the AL_context associated with that id.
 *
 * assumes locked context
 */
AL_context *_alcInitContext(ALuint cid) {
	AL_context *cc;
	int i;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		/* invalid context */
		return NULL;
	}

	_alInitTimeFilters(cc->time_filters);
	_alInitFreqFilters(cc->freq_filters);

	cc->alErrorIndex   = AL_NO_ERROR;

	cc->distance_scale    = 1.0;
	cc->doppler_factor    = 1.0;
	cc->propagation_speed = 1.0;

	_alInitListener(&cc->listener);

        _alcSpeakerInit(cid);

	cc->write_handle = write_handle;
	cc->read_handle  = read_handle;

	/* nothing is enabled by default */
	cc->enable_flags = 0;
	cc->enable_flags |= ALE_DISTANCE_ATTENUATION;
	cc->enable_flags |= ALE_DOPPLER_SHIFT;

	/* Source initializations */
	spool_init(&cc->source_pool);

	/* Set our preferred mixer stats */
	cc->write_speed   = write_speed;
	cc->write_format  = write_format;
	cc->write_bufsiz  = write_bufsiz;

	cc->read_speed    = read_speed;
	cc->read_format   = read_format;
	cc->read_bufsiz   = read_bufsiz;

	/* set devices */
	for(i = 0; i < _ALC_NUM_DEVICES; i++) {
		cc->devices[i] = AL_FALSE;
	}

	/*
	 * should_sync:
	 * 	AL_FALSE:
	 * 		we use async_mixer_iterate, and don't need
	 * 		to have alcUpdateContext called to actually
	 * 		mix the audio.
	 * 	AL_TRUE:
	 * 		we use sync_mixer_iterate, and need to have
	 * 		alcUpdateContext called to actually mix the
	 * 		audio.
	 */
	cc->should_sync = AL_FALSE;

	return cc;
}

/* Assumes context is locked
 *
 * Can't use alcGetContext, because that checks the use flag,
 * which maybe set to false, which is what this function seeks
 * to correct.
 *
 */
ALboolean _alcSetUse(ALuint cid, ALboolean val) {
	ALuint cindex;

	cindex = _alcCidToIndex(cid);

	if(cindex >= al_contexts.size) {
		return !val;
	}

	return al_contexts.inuse[cindex] = val;
}

ALboolean _alcInUse(ALuint cid) {
	ALuint cindex;

	cindex = _alcCidToIndex(cid);

	if(cindex >= al_contexts.size) {
		return AL_FALSE;
	}

	return al_contexts.inuse[cindex];
}

void FL_alcLockAllContexts(UNUSED(const char *fn), UNUSED(int ln)) {
	if( all_context_mutex == NULL ) {
		return;
	}

	_alLockPrintf("_alcLockAllContexts", fn, ln);
	mlLockMutex(all_context_mutex);
}

void FL_alcUnlockAllContexts(UNUSED(const char *fn), UNUSED(int ln)) {
	if( all_context_mutex == NULL ) {
		return;
	}

	_alLockPrintf("_alcUnlockAllContexts", fn, ln);
	mlUnlockMutex(all_context_mutex);
}

/* assumes locked context */
AL_listener *_alcGetListener(ALuint cid) {
	AL_context *cc;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return NULL;
	}

	return &cc->listener;
}

/* assumes locked context */
ALuint _alcGetWriteBufsiz(ALuint cid) {
	AL_context *cc = _alcGetContext(cid);

	if(cc == NULL) {
		return 0;
	}

	return cc->write_bufsiz;
}

ALuint _alcGetReadBufsiz(ALuint cid) {
	AL_context *cc = _alcGetContext(cid);

	if(cc == NULL) {
		return 0;
	}

	return cc->read_bufsiz;
}

void _alcDestroyAll(void) {
	AL_context *freer;
	ALuint i;
	ALuint cid;

	for(i = 0; i < al_contexts.items; i++) {
		cid = _alcIndexToCid(i);

		if(context_mutexen[i] != NULL) {
			mlDestroyMutex(context_mutexen[i]);
			context_mutexen[i] = NULL;
		}

		if(_alcInUse(cid) == AL_TRUE) {
			freer = _alcGetContext(cid);

			if(freer != NULL) {
				_alcDestroyContext(freer);
			}
		}
	}

	free(context_mutexen);
	context_mutexen = NULL;

	free(al_contexts.map);
	free(al_contexts.pool);
	free(al_contexts.inuse);

	al_contexts.map   = NULL;
	al_contexts.pool  = NULL;
	al_contexts.inuse = NULL;
	al_contexts.items = 0;
	al_contexts.size  = 0;

	return;
}

/*
 * _alcGetNewContextId finds the first unused context, sets its
 * use flag to AL_TRUE, and returns it.
 *
 * If there are no unused contexts, at least one more is created,
 * and it is modified and returned in the manner described above.
 *
 * assumes locked contexts
 */
ALint _alcGetNewContextId(void) {
	ALuint i;
	ALuint cid;
	ALuint cindex;

	for(i = 0; i < al_contexts.size; i++) {
		if(al_contexts.inuse[i] == AL_TRUE) {
			continue;
		}

		al_contexts.items++;
		al_contexts.inuse[i] = AL_TRUE;
		return al_contexts.map[i] = _alcGenerateNewCid();
	}

	_alcReallocContexts(al_contexts.size + 1);

	cindex = al_contexts.size - 1;
	cid = _alcGenerateNewCid();

	ASSERT(al_contexts.inuse[cindex] == AL_FALSE);

	al_contexts.inuse[cindex] = AL_TRUE;
	al_contexts.map[cindex]   = cid;

	if(al_contexts.items == 0) {
		/* sigh */
		_alcCCId = cid;
	}

	if(_alcInitContext(cid) == NULL) {
		ASSERT(0);
		return -1;
	}

	al_contexts.items++;

	/*
	 *  We create contexts at the end, so the context id
	 *  will be the last valid element index (al_contexts.items - 1)
	 */
	return cid;
}

/*
 * _alcReallocContexts resizes the context pool to at least
 * newsize contexts, and creates mutex such that the new
 * contexts can be locked.
 *
 * assumes locked contexts
 *
 */
static void _alcReallocContexts(ALuint newsize) {
	void *temp;
	ALuint i;

	if(al_contexts.size >= newsize) {
		return;
	}

	/* resize context pool */	
	temp = realloc(al_contexts.pool, sizeof *al_contexts.pool * newsize);
	if(temp == NULL) {
		perror("_alcReallocContexts malloc");
		exit(4);
	}
	al_contexts.pool = temp;

	/* resize inuse flags */	
	temp = realloc(al_contexts.inuse, sizeof *al_contexts.inuse * newsize);
	if(temp == NULL) {
		perror("_alcReallocContexts malloc");
		exit(4);
	}
	al_contexts.inuse = temp;

	/* resize context map */	
	temp = realloc(al_contexts.map, sizeof *al_contexts.map * newsize);
	if(temp == NULL) {
		perror("_alcReallocContexts malloc");
		exit(4);
	}
	al_contexts.map = temp;

	temp = realloc(context_mutexen, sizeof *context_mutexen * newsize);
	if(temp == NULL) {
		perror("_alcReallocContexts malloc");
		exit(4);
	}
	context_mutexen = temp;

	/* initialize new data */
	for(i = al_contexts.items; i < newsize; i++) {
		al_contexts.inuse[i] = AL_FALSE;
		al_contexts.map[i] = 0;
		context_mutexen[i] = mlCreateMutex();
	}

	if(al_contexts.items == 0) {
		/* If al_contexts.items is <= 0, then were are creating
		 * the contexts for the first time, and must create the
		 * "lock all contexts" mutex as well.
		 */

		all_context_mutex = mlCreateMutex();
		if(all_context_mutex == NULL) {
			perror("CreateMutex");
			exit(2);
		}
	}

	al_contexts.size = newsize;

	return;
}

/* assumes locked context cid */
time_filter_set *_alcGetTimeFilters(ALuint cid) {
	AL_context *cc;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return NULL;
	}

	return cc->time_filters;
}

/* assumes locked context cid */
freq_filter_set *_alcGetFreqFilters(ALuint cid) {
	AL_context *cc;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return NULL;
	}

	return cc->freq_filters;
}

static ALuint _alcCidToIndex(ALuint cid) {
	ALuint i;

	for(i = 0; i < al_contexts.size; i++) {
		if(al_contexts.map[i] == cid) {
			return i;
		}
	}

	ASSERT(0);

	return -1;
}

static ALuint _alcIndexToCid(int index) {
	ASSERT(index < (int) al_contexts.size);

	return al_contexts.map[index];
}

static ALuint _alcGenerateNewCid(void) {
	static ALuint base = CONTEXT_BASE;

	return base++;
}

/*
 * Returns context handle suitable associated with current context,
 * suitable for use with every function that takes a context handle,
 * or NULL if there is no current context.
 */
void *alcGetCurrentContext(void) {
	if(al_contexts.items == 0) {
		return NULL;
	}

	if(_alcCCId == (ALuint) -1) {
		/* We are paused */
		return NULL;
	}

	return (void *) _alcCCId;
}

/*
 *
 * assumes locked context
 */
ALboolean _alcEnableCapture(ALuint cid) {
	AL_context *cc;

#ifndef CAPTURE_SUPPORT
	return AL_FALSE;
#endif

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return AL_FALSE;
	}

	if(read_handle == NULL) {
		/* only aquire if missing */

		read_handle = grab_read_audiodevice();
		if(read_handle == NULL) {
			debug(ALD_CONTEXT,
				__FILE__, __LINE__,
				"Couldn't grab audio hardware.");

			return AL_FALSE;
		}

		if(set_read_audiodevice(read_handle,
				   &cc->read_bufsiz,
				   &cc->read_format,
				   &cc->read_speed) != AL_TRUE) {
			debug(ALD_CONTEXT, __FILE__, __LINE__,
					"set_audiodevice failed.");

			return AL_FALSE;
		}
	}

	cc->read_handle = read_handle;

	read_speed    = cc->read_speed;
	read_format   = cc->read_format;
	read_bufsiz   = cc->read_bufsiz;

	return AL_TRUE;
}

/*
 *
 * assumes locked context
 */
void _alcDisableCapture(ALuint cid) {
	AL_context *cc;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		return;
	}

	release_audiodevice(cc->read_handle);

	cc->read_handle = NULL;

	return;
}

/* assumed locked context */
ALuint _alcGetReadFreq(ALuint cid) {
	AL_context *cc;

	cc = _alcGetContext( cid );
	if(cc == NULL) {
		return 0;
	}

	return cc->read_speed;
}

/* assumes locked context */
ALenum _alcGetReadFormat( ALuint cid ) {
	AL_context *cc;

	cc = _alcGetContext( cid );
	if(cc == NULL) {
		return 0;
	}

	return cc->read_format;
}
