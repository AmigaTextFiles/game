/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_mixer.c
 *
 * Place where most stuff happens.  The main mixer iteration function
 * is defined here.
 *
 */
#include "al_siteconfig.h"

#include <AL/al.h>
#include <AL/alkludge.h> /* ugh */

#include "al_debug.h"
#include "al_error.h"
#include "al_types.h"
#include "al_main.h"
#include "al_buffer.h"
#include "al_filter.h"
#include "al_mixer.h"
#include "al_mixmanager.h"
#include "al_source.h"
#include "mixaudio16.h"

#include "alc/alc_context.h"
#include "alc/alc_speaker.h"

#include "audioconvert.h"

#include "threads/threadlib.h"
#include "mutex/mutexlib.h"

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

#include "arch/interface/interface_sound.h"

/* extension includes */
#include "extensions/al_ext_capture.h"

ALboolean volatile time_for_mixer_to_die = AL_FALSE;
ThreadID mixthread = NULL; /* our thread ID, if async */

/*
 *  MixSource state info.
 */
typedef enum _mixenum {
	ALM_PLAY_ME        = (1<<0),
	ALM_DESTROY_ME     = (1<<1),
	ALM_STREAMING	   = (1<<2)
} mixenum;

/*
 * Enteries in the mixer.
 */
typedef struct _mix_source {
	ALuint context_id;
	ALuint sid;
	mixenum flags;
} mix_source;

typedef struct {
	mix_source data;
	ALboolean inuse;
} mspool_node;

typedef struct {
	mspool_node *pool;
	unsigned int size;
} mspool_t;

/* capture list */
typedef struct _capnode {
	AL_capture *cap;
	ALuint flags;
	struct _capnode *next;
} capnode;

/* static data */
static ALMixManager MixManager;
static ALMixFunc MixFunc;

static mspool_t mspool; /* pool of mix_sources */

static acAudioCVT s16le;
static MutexID mix_mutex   = NULL;
static MutexID pause_mutex = NULL;
static unsigned long bufsiz = 0;
static void *handle;

static void *capture_buffer = NULL;
static capnode *capture_list = NULL;

static struct {
	void *data;
	ALuint length;
} mixbuf = { NULL, 0 };

/* streaming buffer array */
static struct {
	ALuint *streaming_buffers;
	ALuint size;
	ALuint items;
} sbufs = { NULL, 0, 0 };

/* non static funcs */
int sync_mixer_iterate(void *dummy);
int async_mixer_iterate(void *dummy);

int (*mixer_iterate)(void *dummy) = NULL;

/* static funcs */
static ALuint _alAddDataToMixer(void *dataptr, ALuint bytes_to_write);
static void _alProcessFlags(void);

static void _alDestroyMixSource(void *ms);

static void _alAddBufferToStreamingList(ALuint bid);

static ALboolean _alTryLockMixerPause(void);

static int mspool_alloc(mspool_t *spool);
static ALboolean mspool_resize(mspool_t *spool, size_t newsize);
static ALboolean mspool_dealloc(mspool_t *spool, ALuint sid,
				void (*freer_func)(void *));
static mix_source *mspool_index(mspool_t *spool, int msindex);
static int mspool_first_free_index(mspool_t *spool);
static void mspool_free(mspool_t *spool, void (*freer_func)(void *));

static void _alGetCaptures(void);

/* assumes that default context and mixbuf are locked */
static void _alMixSources(void) {
	AL_buffer *samp;
	AL_source *src;
	int *sampid;
	int written;
	ALuint bytes_to_write;
	mix_source *itr = NULL;
	ALboolean islooping   = AL_FALSE;
	ALboolean isstreaming = AL_FALSE;
	ALboolean iscallback  = AL_FALSE;
	ALuint pitr; /* pool iterator */
	ALuint nc = 2;
	
	for(pitr = 0; pitr < mspool.size; pitr++) {
		if(mspool.pool[pitr].inuse == AL_FALSE) {
			/* if not in use, can't be played anyway */
			continue;
		}

		itr = mspool_index(&mspool, pitr);

		if(!(itr->flags & ALM_PLAY_ME)) {
			/*
			 * current mix source on the way out, so
			 * ignore it
			 */
			debug(ALD_MIXER, __FILE__, __LINE__,
				"_alMixSources: %d is on the out",
				itr->sid);
			continue;
		}

		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"_alMixSources: currently on source id %d",
			itr->sid);

		/* FIXME: check for paused context here? */
		src    = _alGetSource(itr->context_id, itr->sid);
		if(src == NULL) {
			/* not a valid src */
			itr->flags = ALM_DESTROY_ME;

			continue;
		}

		if(src->state == AL_PAUSED) {
			/* Paused sources don't get mixed */
			continue;
		}

		sampid = _alGetSourceParam(src, AL_BUFFER);
		if(sampid == NULL) {
			/* source added with no buffer associated */
			itr->flags = ALM_DESTROY_ME;

			debug(ALD_MIXER, __FILE__, __LINE__,
				"No bid associated with sid %d", itr->sid);
			continue;
		}

 		samp = _alGetBuffer(*sampid);
		if(samp == NULL) {
			/* source added with no valid buffer associated */
			debug(ALD_MIXER, __FILE__, __LINE__,
				"no such bid [sid|bid] [%d|%d]",
				itr->sid, *sampid);

			itr->flags = ALM_DESTROY_ME;
			continue;
		}

		/* get special needs */
		islooping   = _alSourceIsLooping( src );
		isstreaming = _alBidIsStreaming(*sampid);
		iscallback  = _alBidIsCallback(*sampid);

		/* apply each filter to sourceid sid */
		_alApplyFilters(itr->context_id, itr->sid);

		/*
		 * calculate how many bytes left.  For looping sounds,
		 * we can ignore qualifications of samp->size because
		 * we loop (ie, have infinite length).
		 */
		if( islooping == AL_FALSE ) {
			/* Non looping source */
			bytes_to_write = _alSourceBytesLeft(src, samp);
		} else {
			bytes_to_write = bufsiz;
		}

		/*
		 * set written to either bufsiz or the number of bytes
		 * left in the source.
		 */
		if(bytes_to_write > bufsiz) {
			written = bufsiz;
		} else {
			written = bytes_to_write;
		}

		_alAddDataToMixer(src->srcParams.outbuf, bufsiz);

		if(_alSourceShouldIncrement(src) == AL_TRUE) {
			/*
			 * soundpos is an offset into the original buffer
			 * data, which is most likely mono.  We use nc (the
			 * number of channels in mixer's format) to scale
			 * soundpos
			 */
			_alSourceIncrement(src, written / nc);
		}

		if(_alSourceBytesLeft(src, samp) <= 0) {
			/*
			 * end of sound.  streaming & looping are special
			 * cases.
			 */
			if(islooping == AL_TRUE ) {
				if(iscallback == AL_TRUE) {
					debug(ALD_LOOP, __FILE__, __LINE__,
					"%d callback loop reset ", itr->sid);

					src->srcParams.soundpos = 0;

					/*
					 * we've actually been fudging the
					 * size
					 */
					samp->size /= nc;
				} else {
					debug(ALD_LOOP, __FILE__, __LINE__,
					"%d loop reset", itr->sid);

					/*
					 * Looping buffers are prefed via
					 * SplitSources, so soundpos is
					 * actually bigger than the buffer
					 * size (because they wrap around).
					 */
					src->srcParams.soundpos %= samp->size;
				}
			} else if(isstreaming == AL_FALSE) {
				/*
				 * The source's current buffer is fini.  Do we 
				 * go to the next buffer in the queue?
				 */
				if(src->bid_queue.read_index < src->bid_queue.size - 1) {
					ALuint rindex = src->bid_queue.read_index;
					ALuint bid    = src->bid_queue.queue[rindex];

					/* There *is* another buffer.  We
					 * count on SplitSources to wrap
					 * around buffer queue entries so that
					 * we get to artifact at crossings.
					 */

					/*
					 * Change current state to queue for
					 * this bid/sid pair
					 */
					_alBidRemoveCurrentRef(bid, itr->sid);
					_alBidAddQueueRef(bid, itr->sid);

					src->bid_queue.read_index++;

					src->srcParams.soundpos = 0;
					/* src->srcParams.soundpos -= samp->size; */


				} else {
					/* This buffer is solo */
					itr->flags = ALM_DESTROY_ME;
				}
			}
		}
	}

	/* we've accumulated sources, now mix */
	_alMixManagerMix(&MixManager, &MixFunc, mixbuf.data);

	return;
}

/* assumes that mix_buf and default context are locked */
static ALuint _alAddDataToMixer(void *dataptr, ALuint bytes_to_write) {
	if(dataptr == NULL) {
		/* Most likely, thread is waiting to die */
		return 0;
	}

	if(bytes_to_write > bufsiz) {
		bytes_to_write = bufsiz;
	}

	/* add entry to mix manager */
	_alMixManagerAdd(&MixManager, dataptr, bytes_to_write);

	return bytes_to_write;
}

void _alDestroyMixer(void) {
	mlDestroyMutex(mix_mutex);

	/* we may we destroyed while paused, which is bad, but
	 * not horrible.  Try to lock it.  If sucessful, then
	 * we weren't locked before, so we unlock and Destroy.  
	 * Otherwise, just unlock and destroy, since we aren't
	 * going to be need async_mixer_iterate services anytime
	 * soon anyway.
	 */
	_alTryLockMixerPause();
	_alUnlockMixerPause(); /* at this point, we are either locked by
				  the context or by our own doing, so it's
				  okay to unlock.
				*/

	mlDestroyMutex(pause_mutex);

	mspool_free(&mspool, _alDestroyMixSource);
	mspool.size = 0;

	mixthread   = NULL;
	pause_mutex = NULL;
	mix_mutex   = NULL;

	_alMixFuncDestroy(&MixFunc);
	_alMixManagerDestroy(&MixManager);

	if(mixbuf.data != NULL) {
		free(mixbuf.data);

		mixbuf.data   = NULL;
		mixbuf.length = 0;
	}

	if(capture_buffer != NULL) {
		free(capture_buffer);

		capture_buffer = NULL;
	}

	return;
}

static void _alDestroyMixSource(void *ms) {
	mix_source *msrc = (mix_source *) ms;
	AL_source  *src;
	ALuint     *bid;
	ALuint i;

	src = _alDCGetSource(msrc->sid);
	if(src == NULL) {
		/*
		 * source got nuked somewhere, or context was
		 * destroyed while paused.
		 */

		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alDestroyMixSource: source id %d is not valid",
			msrc->sid);

		return;
	}

	/*
	 * state should always be set to stopped by this point.
	 */
	src->state = AL_STOPPED;

	/*
	 * reset read index
	 */
	src->bid_queue.read_index = 0;

	/* clear sid */
	msrc->sid = 0;

	/*
	 * Update buffer state
	 */
	bid = _alGetSourceParam(src, AL_BUFFER);
	if(bid == NULL) {
		/* This shouldn't happend:  The buffer param of this
		 * source is now invalid, but we're stopping it.  This
		 * really is an ugly error: it most likely means that
		 * there's a bug in the refcounting stuff somewhere.
		 */
		debug(ALD_MIXER, __FILE__, __LINE__,
		      "_alDestroyMixSource: no bid for source id %d",
		      src->sid);

		_alDCSetError(AL_ILLEGAL_COMMAND);
		return;
	}

	_alBidRemoveCurrentRef(*bid, src->sid);

	if(src->bid_queue.size != 1) {
		/* This is the last entry in the queue (or the source
		 * was stopped) so we want to change the current state
		 * for this bid/sid to queue
		 */
		_alBidAddQueueRef(*bid, src->sid);
	}

	/*
	 * if we have a callback buffer, call the
	 * destructor on the source (because the source
	 * is over.
	 */
	if(_alBidIsCallback(*bid) == AL_TRUE) {
		_alBidCallDestroyCallbackSource(src->sid);
	}

	/* streaming sources */
	if(_alBidIsStreaming(*bid) == AL_TRUE) {

		for(i = 0; i < sbufs.size; i++) {
			if(sbufs.streaming_buffers[i] == *bid) {
				sbufs.streaming_buffers[i] = 0;
				sbufs.items--;
			}
		}
	}

	return;
}

ALboolean _alInitMixer(void) {
	bufsiz      = _alcDCGetWriteBufsiz();

	mix_mutex   = mlCreateMutex();
	if(mix_mutex == NULL) {
		return AL_FALSE;
	}

	pause_mutex = mlCreateMutex();
	if(pause_mutex == NULL) {
		mlDestroyMutex(mix_mutex);
		mix_mutex = NULL;

		return AL_FALSE;
	}

	/* capture stuff */
	capture_buffer = malloc(bufsiz);
	if(capture_buffer == NULL) {
		mlDestroyMutex(mix_mutex);
		mlDestroyMutex(pause_mutex);
		mix_mutex = NULL;
		pause_mutex = NULL;

		return AL_FALSE;
	}

	/* init Mixer funcs */
	if( _alMixFuncInit(&MixFunc, MAXMIXSOURCES) == AL_FALSE) {
		mlDestroyMutex(mix_mutex);
		mlDestroyMutex(pause_mutex);
		mix_mutex = NULL;
		pause_mutex = NULL;

		free(capture_buffer);
		capture_buffer = NULL;

		return AL_FALSE;
	}

	/* init MixManager */
	if(_alMixManagerInit(&MixManager, MAXMIXSOURCES) == AL_FALSE) {
		mlDestroyMutex(mix_mutex);
		mlDestroyMutex(pause_mutex);
		mix_mutex = NULL;
		pause_mutex = NULL;

		free(capture_buffer);
		capture_buffer = NULL;

		_alMixFuncDestroy(&MixFunc);

		return AL_FALSE;
	}

	mspool.size = 0;

	return AL_TRUE;
}

/*
 *
 *   assumes locked context
 *
 *   Sets mixer to current context default.
 */
void _alSetMixer(ALboolean synchronous) {
	AL_context *dc;
	ALuint ex_format;
	ALuint ex_speed;
	int len;

	dc =  _alcDCGetContext();
	if(dc == NULL) {
		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alSetMixer with no default context?  weird");
		return;
	}

	ex_format      = dc->write_format;
	ex_speed       = dc->write_speed;

	len         = dc->write_bufsiz;
	bufsiz      = dc->write_bufsiz;
	handle      = dc->write_handle;

	debug(ALD_CONVERT, __FILE__, __LINE__,
		"_alSetMixer f|c|s [0x%x|%d|%d] -> [0x%x|%d|%d]",
		/* from */
		canon_format,
		_al_ALCHANNELS(ex_format), /* ignore channel settings.  We handle this */
		canon_speed,
		/* to */
		ex_format,
		_al_ALCHANNELS(ex_format),
		ex_speed);

	if(acBuildAudioCVT(&s16le,
		/* from */
		_al_AL2ACFMT(canon_format),
		_al_ALCHANNELS(ex_format), /* ignore channel settings.  We handle this */
		canon_speed,

		/* to */
		_al_AL2ACFMT(ex_format),
		_al_ALCHANNELS(ex_format),/* ignore channel settings.  We handle this */
		ex_speed) < 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"Couldn't build audio convertion data structure.");
	}

	mixbuf.length = bufsiz * s16le.len_ratio;
	mixbuf.data   = realloc(mixbuf.data, mixbuf.length);
	s16le.buf     = mixbuf.data;
	s16le.len     = len;

	/* capture stuff */
	capture_buffer = realloc(capture_buffer, bufsiz);

	if(synchronous == AL_TRUE) {
		mixer_iterate = sync_mixer_iterate;
	} else {
		mixer_iterate = async_mixer_iterate;

		if(mixthread == NULL) {
			mixthread = tlCreateThread(mixer_iterate, NULL);
		}
	}

	return;
}

/*
 *  Assumes locked context
 */
static ALboolean _alAllocMixSource(ALuint sid) {
	AL_source *src;
	ALuint *bid;
	mix_source *msrc;
	int msindex;
	ALuint context_id = _alcCCId; /* current context id */

	src = _alGetSource(context_id, sid);
	if(src == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "_alAllocMixSource: source id %d is not valid", sid);

		_alSetError(context_id, AL_INVALID_NAME);
		return AL_FALSE;
	}

	/*
	 *  Make sure that the source isn't already playing.
	 */
	if(src->state == AL_PLAYING) {
		/*
		 * The source in question is already playing.
		 *
		 * Legal NOP
		 */
		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alAllocMixSource: source id %d already playing", sid);

		return AL_FALSE;
	}

	/*
	 *  Add reference for buffer
	 */
	_alLockBuffer();

	bid = _alGetSourceParam(src, AL_BUFFER);
	if(bid == NULL) {
		_alUnlockBuffer();

		/*
		 * The source in question does not have the BUFFER
		 * attribute set.
		 */
		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alAllocMixSource: source id %d has BUFFER unset",sid);

		_alSetError(context_id, AL_ILLEGAL_COMMAND);

		return AL_FALSE;
	}

	if(_alIsBuffer(*bid) == AL_FALSE) {
		/*
		 * The source in question has a buffer id, but it is not
		 * valid.
		 */
		_alUnlockBuffer();

		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alAllocMixSource: source %d has invalid BUFFER %d:%d",
			sid, src->bid_queue.read_index, bid);

		_alSetError(context_id, AL_INVALID_NAME);

		return AL_FALSE;
	}

	_alUnlockBuffer();

	/* streaming buffers added to increment list */
	if(_alBidIsStreaming(*bid) == AL_TRUE) {
		_alAddBufferToStreamingList(*bid);
	}

	if(src->bid_queue.read_index < src->bid_queue.size - 1) {
		_alBidRemoveQueueRef(*bid, sid);
	}

	_alBidAddCurrentRef(*bid,  sid);

	/*
	 *  Allocate space.
	 */
	msindex = mspool_alloc(&mspool);
	if(msindex == -1) {
		return AL_FALSE;
	}

	/*
	 *  Initialization mojo.
	 *
	 *  set sid to source's id, flags to ALM_PLAY_ME, and
	 *  set the source's flags so that we know it's playing,
	 *  and reset soundpos.
	 */
	msrc = mspool_index(&mspool, msindex);

	/* set mixsource information */
	msrc->context_id    = context_id;
	msrc->sid           = sid;
	msrc->flags         = ALM_PLAY_ME;

	/* set source information */
	src->state		      = AL_PLAYING;
	src->srcParams.soundpos       = 0;
	src->bid_queue.read_index     = 0;

	return AL_TRUE;
}

/*
 *  FIXME: O(n) search.  This is a pain because other functions
 *         use the sid to index into source but we use the offset
 *         into the mixsource pool.  So we need to do a linear
 *         search each time through.  
 *
 *         Would probably not be too bad just to sort mspool on
 *         additions, skipping inuse = FALSE?
 */
ALboolean _alRemoveSourceFromMixer(ALuint sid) {
	AL_source *src;
	unsigned int i;

	src = _alDCGetSource(sid);
	if(src == NULL) {
		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alRemoveSourceFromMixer: %d is an invalid source id",
			sid);

		_alDCSetError(AL_INVALID_NAME);

		return AL_FALSE;
	}

	/*
	 *  We are stopping now.  Which means we set the state:
	 *
	 *  active  -> stopped
	 *  paused  -> stopped
	 *  initial -> NOP
	 *  stopped -> NOP
	 *
	 */
	switch(src->state) {
		case AL_INITIAL:
		case AL_STOPPED:
		  /* Stop on a non active source is a legal NOP */
		  debug(ALD_MIXER, __FILE__, __LINE__,
			"_alRemoveSourceFromMixer(%d): source is not playing",
			sid);

		  return AL_FALSE;
		  break;
		default:
		  /* We're okay, otherwise */
		  break;
	}

	for(i = 0; i < mspool.size; i++) {
		if((mspool.pool[i].data.sid == sid) &&
		   (mspool.pool[i].inuse == AL_TRUE)) {
			mspool_dealloc(&mspool, i, _alDestroyMixSource);

			debug(ALD_MIXER, __FILE__, __LINE__,
			"_alRemoveSourceFromMixer: removed sid %d",
			sid);

			return AL_TRUE;
		}
	}

	/*
	 * We really shouldn't end up here.  It means that the ->flags
	 * attribute got weird somewhere.
	 */
	debug(ALD_MIXER, __FILE__, __LINE__,
		"_alRemoveSourceFromMixer(%d): Could not remove source",
		sid);

	return AL_FALSE;
}

/*
 * assumes that context is locked
 * assumes that mixbuf is locked
 */
void _alAddSourceToMixer(ALuint sid) {
	AL_source *src;

	src = _alDCGetSource(sid);
	if(src == NULL) {
		/* invalid name */
		debug(ALD_MIXER, __FILE__, __LINE__,
		      "_alAddSourceToMixer: source id %d is not valid",
		      sid);

		_alDCSetError(AL_INVALID_NAME);
		return;
	}

	/*
	 * Now, we are going to set the state:
	 *
	 * initial -> active
	 * paused  -> active
	 * stopped -> active
	 * active  -> nop
	 *
	 * Paused sources are already in the mixer, but being
	 * ignored, so we just "turn them on."  initial and stopped
	 * sources need to have new mixsources alloced for them.
	 */
	switch(src->state) {
		case AL_PAUSED:
		  /* Paused sources, when played again, resume
		   * at their old location.  We don't need to
		   * alloc a new mixsource.
		   */
		  src->state = AL_PLAYING;
		  return;
		case AL_PLAYING:
		  /* This source is already playing.
		   *
		   * Legal NOP
		   */
		  debug(ALD_MIXER, __FILE__, __LINE__,
			"_alAddSourceToMixer: source %d already active",
			sid);
		  
		  return;
		default:
		  /* alloc a mix source */
		  break;
	}

	if(_alAllocMixSource(sid) == AL_FALSE) {
		/* most likely, the buffer associated with the
		 * source in question has been deleted.  Return
		 * asap.
		 *
		 * We shouldn't set the error because _alAllocMixSource
		 * will actually be better aware of what the problem is,
		 * and so will set the error accordingly.
		 */
		debug(ALD_MIXER, __FILE__, __LINE__,
			"_alAddSourceToMixer: Could not add source sid %d",
			sid);

		return;
	}

	debug(ALD_MIXER, __FILE__, __LINE__,
		"_alAddSourceToMixer: added sid %d", sid);

	return;
}

void FL_alLockMixBuf(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alLockMixbuf", fn, ln);

	mlLockMutex(mix_mutex);
}

void FL_alUnlockMixBuf(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alUnlockMixbuf", fn, ln);

	mlUnlockMutex(mix_mutex);
}


int sync_mixer_iterate(UNUSED(void *dummy)) {
	ALshort *dataptr = mixbuf.data;
	int bytes_to_write = 0;

	/* clear buffer */
	memset(dataptr, 0, bufsiz);

	_alcDCLockContext();

	_alLockMixBuf();
	_alMixSources();
	_alProcessFlags();
	_alUnlockMixBuf();
	_alcDCUnlockContext();

	if(acConvertAudio(&s16le) < 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"Couldn't execute conversion from canon.");
		return -1;
	}

	bytes_to_write = s16le.len_cvt;

	if(handle != NULL) {
		blitbuffer(handle, dataptr, bytes_to_write);
	}

	return 0;
}

/* threaded version */
int async_mixer_iterate(UNUSED(void *dummy)) {
	ALuint bytes_to_write = 0;

	/* clear buffer */
	memset(mixbuf.data, 0, mixbuf.length);

	do {
		if(_alTryLockMixerPause() == AL_TRUE) {
			_alcDCLockContext();

			_alLockMixBuf();

			_alMixSources();

			_alGetCaptures();

			_alProcessFlags();

			_alUnlockMixBuf();
			_alcDCUnlockContext();

			if(acConvertAudio(&s16le) < 0) {
				debug(ALD_MAXIMUS, __FILE__, __LINE__,
				"Couldn't execute conversion from canon.");
				/*
				 * most likely we're just early.
				 * Don't sweat it.
				 */
				continue;
			}

			bytes_to_write = s16le.len_cvt;

			if(handle != NULL) {
				ASSERT(bytes_to_write <= mixbuf.length);

				blitbuffer(handle, mixbuf.data, bytes_to_write);
			}

			/* clear buffer */
			memset(mixbuf.data, 0, mixbuf.length);

			_alUnlockMixerPause();
		} else {
			/*
			 * Why do we still write data, even though the
			 * current context is paused?  Because some
			 * audio devices don't like to ever be starved,
			 * apparently.
			 *
			 * FIXME: dangerous, device could be closed or missing
			 */
			blitbuffer(handle, mixbuf.data, mixbuf.length);
		}
	} while(time_for_mixer_to_die == AL_FALSE);

	time_for_mixer_to_die = AL_FALSE;

	tlExitThread(0);
	
	return 0;
}

/*
 *  Resize spool to at least newsize units.
 */
static ALboolean mspool_resize(mspool_t *spool, size_t newsize) {
	mspool_node *temp;
	unsigned int i;

	if(newsize < 1) {
		newsize = 1;
	}

	if(spool->size >= newsize) {
		return AL_TRUE; /* no resize needed */
	}

	if(spool->pool == NULL) {
		spool->pool = malloc(newsize * sizeof *spool->pool);
	} else  {
		temp = realloc(spool->pool, newsize * sizeof(mspool_node));
		if(temp == NULL) {
			return AL_FALSE; /* could not realloc */
		}

		spool->pool = temp;
	}

	for(i = spool->size; i < newsize; i++) {
		spool->pool[i].inuse = AL_FALSE;
	}

	spool->size = newsize;

	return AL_TRUE;
}

/*
 *  Allocate space, return index.
 */
static int mspool_alloc(mspool_t *spool) {
	int msindex;

	msindex = mspool_first_free_index(spool);
	if(msindex == -1) {
		if(mspool_resize(spool, spool->size * 2) == AL_FALSE) {
			return -1;
		}
		
		msindex = mspool_first_free_index(spool);
	}

	spool->pool[msindex].inuse = AL_TRUE;

	return msindex;
}

/*
 *  Return data structure at index, if it has been flagged in use.
 */
static mix_source *mspool_index(mspool_t *spool, int msindex) {
	if(spool->pool[msindex].inuse == AL_FALSE) {
		return NULL;
	}

	return &spool->pool[msindex].data;
}

/*
 *  Return first not in use index.
 */
static int mspool_first_free_index(mspool_t *spool) {
	ALuint i;

	for(i = 0; i < spool->size; i++) {
		if(spool->pool[i].inuse == AL_FALSE) {
			return i;
		}
	}

	return -1;
}

/*
 *  mark data at index as not in use
 */
static ALboolean mspool_dealloc(mspool_t *spool, ALuint msindex,
				void (*freer_func)(void *)) {
	mix_source *src;

	src = mspool_index(spool, msindex);
	if(src == NULL) {
		debug(ALD_MIXER, __FILE__, __LINE__,
			"%d is a bad index", msindex);
		return AL_FALSE;
	}

	if(spool->pool[msindex].inuse == AL_FALSE) {
		debug(ALD_MIXER, __FILE__, __LINE__,
			"index %d is not in use", msindex);

		/* already deleted */
		return AL_FALSE;
	}

	spool->pool[msindex].inuse = AL_FALSE;

	freer_func(src);

	return AL_TRUE;
}

static void mspool_free(mspool_t *spool, void (*freer_func)(void *)) {
	unsigned int i;

	for(i = 0; i < spool->size; i++) {
		if(spool->pool[i].inuse == AL_TRUE) {
			mspool_dealloc(spool, i, freer_func);
		}
	}

	if(spool->pool != NULL) {
		free(spool->pool);
		spool->pool = NULL;
	}

	spool->size = 0;

	/* let the caller free spool itself */

	return;
}

/*
 *  FIXME: need to free sbufs.stremaing_buffers on exit.
 */
static void _alAddBufferToStreamingList(ALuint bid) {
	void *temp;
	int offset;
	ALuint newsize;
	ALuint i;

	if(sbufs.items >= sbufs.size) {
		/* realloc */
		newsize = sbufs.size + 1;

		temp = realloc(sbufs.streaming_buffers,
				newsize * sizeof *sbufs.streaming_buffers);
		if(temp == NULL) {
			/* what a bummer */
			return;
		}
		sbufs.streaming_buffers = temp;

		for(i = sbufs.size; i < newsize; i++) {
			sbufs.streaming_buffers[i] = 0;
		}

		sbufs.size = newsize;
	}

	/* add bid to streaming list */
	for(i = 0, offset = sbufs.items; i < sbufs.size; i++) {
		offset = (offset + 1) % sbufs.size;

		if(sbufs.streaming_buffers[offset] == 0) {
			sbufs.streaming_buffers[offset] = bid;

			sbufs.items++;

			return;
		}
	}
	
	return;
}

/*
 * The function that alcMakeContextCurrent calls to pause
 * asynchronous mixers
 */
static ALboolean _alTryLockMixerPause(void) {
	if(mlTryLockMutex(pause_mutex) == 0) {
		return AL_TRUE;
	}
	
	return AL_FALSE;
}

/*
 * The function that alcMakeContextCurrent calls to pause
 * asynchronous mixers
 */
void _alLockMixerPause(void) {
	mlLockMutex(pause_mutex);
}

/*
 * The function that alcMakeContextCurrent calls to resume
 * asynchronous mixers
 */
void _alUnlockMixerPause(void) {
	mlUnlockMutex(pause_mutex);
}


/* capture stuff */

/*
 * "start" a capture
 *
 * assumes locked mixer, captures
 */
void _alAddCaptureToMixer(ALuint cpid) {
	AL_capture *cap;
	capnode *newnode;
	capnode *itr;

	cap = _alGetCapture(cpid);
	if(cap == NULL) {
		return;
	}

	newnode = malloc(sizeof *newnode);
	if(newnode == NULL) {
		return;
	}

	newnode->cap = cap;
	newnode->next = NULL;

	if(capture_list == NULL) {
		/* This is the first addition */
		capture_list = newnode;
		return;
	}

	itr = capture_list;
	while(itr && itr->next) {
		itr = itr->next;
	}

	itr->next = newnode;

	return;
}

/*
 * "stop" a capture
 *
 * assumes locked mixer, captures
 */
void _alRemoveCaptureFromMixer(ALuint cpid) {
	AL_capture *cap;
	capnode *itr;
	capnode *prev;

	cap = _alGetCapture(cpid);
	if(cap == NULL) {
		return;
	}

	prev = capture_list;
	itr = capture_list;

	while(itr != NULL) {
		if(itr->cap == cap) {
			if(itr == prev) {
				/* root note */
				free(itr);

				capture_list = NULL;
				return;
			} else {
				prev->next = itr->next;
				free(itr);

				return;
			}
		}

		prev = itr;
		itr = itr->next;
	}

	return;

}

/*
 * _alProcessFlags
 *
 *
 * The mixing function (_alMixSources), in the course of it's job marks the
 * mixsource nodes with commands that need to be executed after the completion
 * of the mixsource's iteration through the loop.  This is the function where
 * such things are done.
 *
 * Also, we process streaming buffers here because they need to be visited
 * once per call to _alMixSources, but the presence of multiple sources
 * refering to the same buffer precludes us from doing the processing in
 * _alMixSources.
 *
 *  assumes locked context
 *  assumes locked mixbuf
 */
void _alProcessFlags(void) {
	mix_source *itr = NULL;
	AL_buffer *bitr; /* buffer iterator */
	ALuint i;
	ALuint k;

	for(i = 0; i < mspool.size; i++) {
		if(mspool.pool[i].inuse == AL_FALSE) {
			/* skip mixsources not in use */
			continue;
		}

		itr = mspool_index(&mspool, i);
		if(itr == NULL) {
			/* shouldn't happen */
			continue;
		}

		if(itr->flags & ALM_DESTROY_ME) {
			/* this source associated with this mixsource
			 * has expired (either because it has been stopped
			 * or just run out.  Remove it.
			 */
			if(_alIsSource(itr->sid) == AL_FALSE) {
				/* sanity check */
				continue;
			}

			/* deallocated mixsource */
			mspool_dealloc(&mspool, i, _alDestroyMixSource);
		}
	}

	_alLockBuffer();

	/* process streaming buffers */
	i = sbufs.items;
	k = sbufs.size - 1;

	while(i--) {
		int nc;

		while(sbufs.streaming_buffers[k] == 0) {
			/*
			 * We don't worry about underflow because
			 * we are keying off of the number of sbuf
			 * items.
			 */
			k--;
		}

		bitr = _alGetBuffer(sbufs.streaming_buffers[k]);
		if(bitr == NULL) {
			debug(ALD_STREAMING, __FILE__, __LINE__,
				"invalid buffer id %d",
				sbufs.streaming_buffers[k]);

			/* invalid buffer
			 *
			 * Most likely, the buffer got deleted at some
			 * point.  We remove here, decrement the items
			 * count and get on with life.
			 */
			sbufs.streaming_buffers[k] = 0;
			sbufs.items--;

			continue;
		}

		/* get the buffer's number of channels, so multichannel
		 * streaming sounds work properly.
		 */
		nc = _alcDCGetNumSpeakers();

		if(nc <= 0) {
			nc = 1;
		}

		if(_alGetBufferState(bitr) == AL_UNUSED) {
			/* refcount 0?  Don't bother. */
			sbufs.streaming_buffers[k] = 0;
			sbufs.items--;

			continue;
		}

		bitr->streampos += bufsiz/nc;

		if(bitr->streampos >= bitr->size) {
			if(bitr->flags & ALB_STREAMING_WRAP) {
				/* If we have the wrap flag, wrap.
				 * Otherwise, what?  End the source?
				 * Loop forever?
				 */

				debug(ALD_STREAMING, __FILE__, __LINE__,
					"Wrapping\n");

				bitr->streampos = 0;
				bitr->flags &= ~ALB_STREAMING_WRAP;
			}
		}
	}

	_alUnlockBuffer();

	return;
}

static void _alGetCaptures(void) {
	AL_capture *cap;
	capnode *itr;

	if(capture_list == NULL) {
		/* no captures?  return */
		return;
	}

	capture_audiodevice(handle, capture_buffer, bufsiz);	

	itr = capture_list;
	while(itr != NULL) {
		cap = itr->cap;

		if(itr->flags & ALM_DESTROY_ME) {

			itr = itr->next;
			continue;
		}

		itr = itr->next;

		_alCaptureAppendData( cap, capture_buffer, bufsiz );
	}

	return;
}
