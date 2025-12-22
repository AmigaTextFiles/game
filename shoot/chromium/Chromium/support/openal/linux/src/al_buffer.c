/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_buffer.c
 *
 * Stuff related to the management and use of buffers.
 *
 */
#include "al_siteconfig.h"

#include <AL/al.h>
#include <AL/alut.h>
#include <AL/alkludge.h>
#include <AL/alext.h>

#include "al_buffer.h"
#include "al_debug.h"
#include "al_error.h"
#include "al_main.h"
#include "al_source.h"
#include "al_types.h"
#include "alc/alc_context.h"
#include "alc/alc_speaker.h"

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#include "audioconvert.h"
#include "mutex/mutexlib.h"

#define AL_FIRST_BUFFER_ID  0x8000
#define MINBUFFERS          20

/*
 * pool structures: bpool_node and bpool_t
 *
 * These structures are used to group buffers in a growable array, so that
 * the relatively small allocations of AL_buffer objects can be combined into
 * a larger structure, in the hopes of reducing the effects of fragmentation.
 *
 * Each AL_buffer manipulated is actually a pointer to a bpool_node->data 
 * object.  The bpool->node inuse flag marks whether the AL_buffer in a bpool_node
 * object is currently "alloced" (in the sense that the application/library is
 * using it) or "dealloced".
 *
 * The bpool_t object is used to collect those variables needed to manage the
 * bpool_node pool, in point of fact the size and the data itself.  Also, a
 * mapping of buffer ids (used internally and by the application) is present
 * to facilitate the easy conversion from buffer ids (which are in essence
 * arbitrary other than their requirement to be unique) and indexes into 
 * the bpool_node pool.
 */
typedef struct {
	AL_buffer data;
	ALboolean inuse;
} bpool_node;

typedef struct {
	bpool_node *pool;
	ALuint size;
	ALuint *map; /* map[index] = bid */
} bpool_t;

/* static data */
static bpool_t buf_pool;             /* pool table of bufferid/buffer pairs */
static MutexID buf_mutex     = NULL; /* mutex for buf_pool */

/* static function prototypes */

/*
 * _alDestroyBuffer(void *buf)
 *
 * _alDestroyBuffer is passed an AL_buffer pointer, masquerading as a void
 * pointer, and frees the data structures internal to the AL_buffer, but
 * not the buffer itself.
 *
 * This is called by bpool_dealloc.
 */
static void _alDestroyBuffer(void *buf);

/*
 * _alBufferInit(AL_buffer *buf, ALuint bid)
 *
 * _alBufferInit initializes the AL_buffer data structure pointed to by
 * buf (buf has obviously already been allocated).
 *
 */
static void _alBufferInit(AL_buffer *buf, ALuint bid);

/*
 * void *_alConvert(void *data,
 *			ALenum f_format, ALuint f_size, ALuint f_freq,
 *			ALenum t_format, ALuint t_freq, ALuint *retsize,
 *			ALenum should_use_passed_data);
 *
 * _alConvert takes the passed data and converts it from it's current
 * format (f_format) to the desired format (t_format), etc, returning
 * the converted data and setting retsize to the new size of the 
 * converted data.  The passed data must either be raw PCM data or
 * must correspond with one of the headered extension formats.
 *
 * If should_use_passed_data is set to AL_TRUE, then _alConvert will
 * attempt to do the conversion in place.  Otherwise, new data will
 * be allocated for the purpose.
 *
 * Returns NULL on error.
 */
static void *_alConvert(void *data,
			ALenum f_format, ALuint f_size, ALuint f_freq,
			ALenum t_format, ALuint t_freq, ALuint *retsize,
			ALenum should_use_passed_data);


static void _alBufferDestroyCallbackBuffer(AL_buffer *buf);

/* buffer pool stuff */
void bpool_init(bpool_t *spool);
static int bpool_alloc(bpool_t *spool);
static void bpool_free(bpool_t *spool, void (*freer_func)(void *));
static int bpool_first_free_index(bpool_t *spool);
static ALboolean bpool_dealloc(bpool_t *spool, ALuint sid,
				void (*freer_func)(void *));
ALboolean bpool_resize(bpool_t *spool, size_t newsize);
static AL_buffer *bpool_index(bpool_t *spool, ALuint indx);

static int bpool_bid_to_index(bpool_t *spool, ALuint bid);
static ALuint bpool_next_bid(void);

/*
 * buffer source state
 */
static void _alBufferAddQueueRef(AL_buffer *buf, ALuint sid);
static void _alBufferAddCurrentRef(AL_buffer *buf, ALuint sid);

static void _alBufferRemoveQueueRef(AL_buffer *buf, ALuint sid);
static void _alBufferRemoveCurrentRef(AL_buffer *buf, ALuint sid);

/*
 * alGenBuffers
 *
 * Perform full allocation of n-1 buffer ids.  Fails and nops
 * if n-1 buffers could not be created.
 *
 * If n is 0, legal nop.  If n < 0, set INVALID_VALUE and nop.
 */
void alGenBuffers( ALsizei n, ALuint *buffer) {
	ALuint *temp;
	int bindex;
	int i;

	if(n == 0) {
		return; /* silently return */
	}

	if(n < 0) {
		debug(ALD_BUFFER, __FILE__, __LINE__,
		      "alGenBuffers: invalid n %d\n", n);

		_alcDCLockContext();
		_alDCSetError( AL_INVALID_VALUE );
		_alcDCUnlockContext();
		return;
	}

	temp = malloc(n * sizeof *temp);
	if(temp == NULL) {
		/*
		 * Could not reserve memory for temporary
		 * ALuint *buffer.
		 */
		_alcDCLockContext();
		_alDCSetError( AL_OUT_OF_MEMORY );
		_alcDCUnlockContext();
		return;
	}

	_alLockBuffer();

	for(i = 0; i < n; i++) {
		bindex = bpool_alloc(&buf_pool);

		if(bindex == -1) {
			/*
			 * Could not honor request in full.  We
			 * unlock, dealloc, set error, return.
			 *
			 * FIXME: Should we have a non-locking
			 * version of DeleteBuffers and maintain this
			 * lock as long as possible?
			 */
			_alUnlockBuffer();

			if(i > 0) {
				/*
				 * Only delete buffers that have
				 * been created.
				 */
				alDeleteBuffers(i, temp);
			}

			_alcDCLockContext();
			_alDCSetError(AL_OUT_OF_MEMORY);
			_alcDCUnlockContext();

			free(temp);

			return;
		}

		temp[i] = bindex;
	}

	_alUnlockBuffer();

	memcpy(buffer, temp, n * sizeof *buffer);

	free(temp);

	return;
}

/* 
 * alDeleteBuffers
 *
 * Perform full deallocation of buffers[0..n-1].  If a member
 * of buffers[0..n-1] is not a valid buffer id, set INVALID_NAME
 * and return without deallocating any member.
 *
 * If n is 0, legal nop.  If n < 0, set INVALID_VALUE and nop.
 *
 * FIXME: not well tested
 *
 * Well, that's not totally true.  I've tested deleting
 * buffers (obviously!) but there's a whole set of mojo where it
 * becomes possible to delete buffers in playing sources, which 
 * is bad bad bad. 
 *
 * The ref counting system is made to avoid that bad mojo by never
 * deleting buffers associated with playing sources.  *That* is 
 * what is not well tested.
 *
 * Of course, the behaviour of deleting buffers which are currently
 * associated with sources (especially playing sources!) needs to
 * be specified.  It's not at-the-moment.
 */
void alDeleteBuffers(ALsizei n, ALuint *buffers) {
	AL_buffer *buf;
	ALenum bufstate;
	int i;

	if(n == 0) {
		/* silently return */
		return;
	}

	_alLockBuffer();

	if(n < 0) {
		_alUnlockBuffer();

		_alcDCLockContext();
		_alDCSetError( AL_INVALID_VALUE );
		_alcDCUnlockContext();
		return;
	}

	/*
	 * test each buffer to ensure we don't have any
	 * invalid names in there.
	 */
	for(i = 0; i < n; i++) {
		if(_alIsBuffer(buffers[i]) == AL_FALSE) {
			/* not a buffer */
			_alcDCLockContext();
			_alDCSetError( AL_INVALID_NAME );
			_alcDCUnlockContext();

			_alUnlockBuffer();
			return;
		}
	}

	while(n--) {
		bufstate = _alGetBidState(buffers[n]);

		if(bufstate == AL_UNUSED) {
			bpool_dealloc(&buf_pool, buffers[n],
				_alDestroyBuffer);
		} else {
			buf = _alGetBuffer( buffers[n] );
			if(buf == NULL) {
				/* should never happen */
				_alcDCLockContext();
				_alDCSetError( AL_INVALID_NAME );
				_alcDCUnlockContext();

				continue;
			}

			/* still in use */
			buf->flags |= ALB_PENDING_DELETE;
		}
	}
	_alUnlockBuffer();

	return;
}

/*
 * alGenStreamingBuffers
 *
 * Perform full allocation in buffers[0..n-1].  If full allocation
 * is not possible, the appropriate error is set and the function
 * returns.  Each buffer id in a sucessful call can be used with
 * BufferAppendData.
 *
 * If n is 0, legal nop.  If n < 0, set INVALID_VALUE and nop.
 *
 */
void alGenStreamingBuffers( ALsizei n, ALuint *buffer) {
	AL_buffer *buf;
	ALuint *temp;
	int bindex;
	int i;

	if(n == 0) {
		/* silenlty return */
		return;
	}

	if(n < 0) {
		debug(ALD_BUFFER, __FILE__, __LINE__,
		      "alGenStreamingBuffers: invalid n %d\n", n);

		_alcDCLockContext();
		_alDCSetError( AL_INVALID_VALUE );
		_alcDCUnlockContext();
		return;
	}

	temp = malloc(n * sizeof *temp);
	if(temp == NULL) {
		/*
		 * Could not reserve memory for temporary
		 * ALuint *buffer.
		 */
		_alcDCLockContext();
		_alDCSetError(AL_OUT_OF_MEMORY);
		_alcDCUnlockContext();
		return;
	}

	_alLockBuffer();

	for(i = 0; i < n; i++) {
		bindex = bpool_alloc(&buf_pool);

		if(bindex == -1) {
			/*
			 * Could not honor request in full.  We
			 * unlock, dealloc, set error, return.
			 *
			 * FIXME: Should we have a non-locking
			 * version of DelBuffers and maintain this
			 * lock as long as possible?
			 */
			_alUnlockBuffer();

			alDeleteBuffers(i, temp);

			_alcDCLockContext();
			_alDCSetError( AL_OUT_OF_MEMORY );
			_alcDCUnlockContext();

			free(temp);

			return;
		}

		temp[i] = bindex;

		/* make sure to set the streaming flag */
		buf = bpool_index(&buf_pool, bindex);
		buf->flags |= ALB_STREAMING;
	}

	_alUnlockBuffer();

	memcpy(buffer, temp, n * sizeof *buffer);

	free(temp);

	return;
}

/*
 * Is bid a buffer?  AL_TRUE if it is, AL_FALSE otherwise
 */
ALboolean alIsBuffer(ALuint bid) {
	ALboolean retval;

	_alLockBuffer();

	retval = _alIsBuffer(bid);

	_alUnlockBuffer();

	return retval;
}

/*
 * If bid names a buffer id of a currently valid buffer, return
 * AL_TRUE.  Otherwise, return AL_FALSE.
 *
 * assumes locked buffers
 */
ALboolean _alIsBuffer(ALuint bid) {
	ALboolean retval = AL_TRUE;

	if(_alGetBuffer(bid) == NULL) {
		retval = AL_FALSE;
	}

	return retval;
}

/*
 * _alGetBuffer
 *
 * Internal function that retrieves the buffer associated with
 * the buffer id bid.
 *
 * Returns NULL if there is no buffer associated with bid.
 *
 * assumes that buffers are locked
 */
AL_buffer *_alGetBuffer(ALuint bid) {
	int bindex;

	bindex = bpool_bid_to_index(&buf_pool, bid);
	if(bindex < 0) {
		/* invalid bid */
		return NULL;
	}

	if(bindex >= (int) buf_pool.size) {
		/* buffer id too big */
		return NULL;
	}

	if(buf_pool.pool[bindex].inuse == AL_FALSE) {
		return NULL;
	}

	return bpool_index(&buf_pool, bid);
}

/*
 * _alInitBuffers
 *
 * Performs global initialization of buffer specific data
 * structures.
 *
 * Doesn't do much.  No default size, so we just initialize 
 * the mutex.
 */
ALboolean _alInitBuffers(void) {
	buf_mutex = mlCreateMutex();
	if(buf_mutex == NULL) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"Could not create buffer mutex.");
		return AL_FALSE;
	}

	return AL_TRUE;
}

/**
 *
 * associates data with bid
 */
void alBufferData( ALuint  bid,
		   ALenum  format,
                   void   *data,
		   ALsizei size,
		   ALsizei freq ) {
	AL_buffer *buf;
	ALvoid *cdata;
	ALuint i;
	ALuint retsize;
	ALenum tformat;
	ALint tfreq;

	switch(format) {
#ifdef VORBIS_SUPPORT
		/*
		 * If compiled with the vorbis extension, and we get passed
		 * vorbis data, then pass that to the correct extension.
		 */
		case AL_FORMAT_VORBIS_EXT:
			if(alutLoadVorbis_LOKI(bid, data, size) == AL_FALSE) {
				_alcDCLockContext();
				_alDCSetError(AL_ILLEGAL_COMMAND);
				_alcDCUnlockContext();
			}
			return;
			break;
#endif /* VORBIS_SUPPORT */
		default:
			break;
	}

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		debug(ALD_BUFFER, __FILE__, __LINE__,
		      "alBufferData: buffer id %d not valid",
		      bid);

		_alcDCLockContext();
		_alDCSetError(AL_INVALID_NAME);
		_alcDCUnlockContext();

		_alUnlockBuffer();
		return;
	}

	if(buf->flags & ALB_STREAMING) {
		/* Streaming buffers cannot use alBufferData */
		_alcDCLockContext();
		_alDCSetError(AL_ILLEGAL_COMMAND);
		_alcDCUnlockContext();

		_alUnlockBuffer();

		return;
	}

	if(buf->flags & ALB_CALLBACK) {
		/* If this was previously a callback buffer,
		 * reset it.
		 */
		buf->flags &= ~ALB_CALLBACK;
	}

	tformat = buf->format;
	tfreq   = buf->freq;

	_alUnlockBuffer();

	cdata = _alBufferCanonizeData(format,
				      data,
				      size,
				      freq,
				      tformat,
				      tfreq,
				      &retsize,
				      AL_FALSE);

	if(cdata == NULL) {
		/*  _alBufferCanonize Data should set error */
		return;
	}

	/*
	 * alter buffer's data.
	 */
	_alLockBuffer();

	if(buf->size < retsize) {
		void *temp;

		for(i = 0; i < _alcDCGetNumSpeakers(); i++) {
			temp = realloc(buf->orig_buffers[i], retsize);
			if(temp == NULL) {
				/* FIXME: do something */
			}

			buf->orig_buffers[i] = temp;
		}
	}

	_alMonoify((ALshort **) buf->orig_buffers,
		   cdata,
		   retsize / _al_ALCHANNELS(tformat),
		   buf->num_buffers, _al_ALCHANNELS(tformat));

	buf->size          = retsize / _al_ALCHANNELS(tformat);

	_alUnlockBuffer();

	free(cdata);

	return;
}

/*
 * assumes locked context
 *
 * Retrieves the buffer (not the buffer id) associated with
 * the source with sourceid sid, or NULL on error.
 */
AL_buffer *_alGetBufferFromSid(ALuint cid, ALuint sid) {
	AL_buffer *retval;
	AL_source *src;
	ALuint *buffid;

	src = _alGetSource(cid, sid);
	if(src == NULL) {
		return NULL;
	}

	buffid = _alGetSourceParam(src, AL_BUFFER);
	if(buffid == NULL) {
		return NULL;
	}

	_alLockBuffer();

	retval = _alGetBuffer(*buffid);

	_alUnlockBuffer();

	return retval;
}

/*
 * Put data in canonical format, setting size and returning the
 * data.
 *
 * If should_use_passed_data is set to AL_TRUE, the data will
 * be converted (if needed) in place.
 *
 * Returns NULL on error.
 *
 * assumes locked buffers.
 */
void *_alBufferCanonizeData(ALenum format,
			    void *data, ALuint size, ALuint freq,
			    ALenum t_format, ALuint t_freq,
			    ALuint *retsize,
			    ALenum should_use_passed_data) {
	if(format < 0) {
		return NULL;
	}

	return _alConvert(data, format, size, freq, t_format, t_freq,
			  retsize, should_use_passed_data);
}

/*
 *  Destroy a buffer, free'ing all associated memory with it.
 *
 *  Probably shouldn't be called directly, but passed as an
 *  arguement to a higher level function
 */
static void _alDestroyBuffer(void *bufp) {
	AL_buffer *buf = (AL_buffer *) bufp;
	ALuint i;

	if(_alBufferIsCallback(buf) == AL_TRUE) {
		/*
	 	 * alut decoders need to be informed of
	 	 * buffer destruction
	 	 */
		_alBufferDestroyCallbackBuffer(buf);
		buf->destroy_buffer_callback = NULL;
	}

	for(i = 0; i < buf->num_buffers; i++) {
		free(buf->orig_buffers[i]);
		buf->orig_buffers[i] = NULL;
	}

	/* don't free bufp, let the caller do it if needed */

	return;
}

/*
 *  Destroy all buffers, freeing all data associated with
 *  each buffer.
 */
void _alDestroyBuffers(void) {
	bpool_free(&buf_pool, _alDestroyBuffer);
	bpool_init(&buf_pool);

	mlDestroyMutex(buf_mutex);

	buf_mutex = NULL;

	return;
}
	
/*
 *  Locks buffer
 */
ALboolean FL_alLockBuffer(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alLockBuffer", fn, ln);

	if(buf_mutex == NULL) {
		return AL_FALSE;
	}

	mlLockMutex(buf_mutex);

	return AL_TRUE;
}

/*
 *  Unlocks buffer
 */
ALboolean FL_alUnlockBuffer(UNUSED(const char *fn), UNUSED(int ln)) {
	_alLockPrintf("_alUnlockBuffer", fn, ln);

	if(buf_mutex == NULL) {
		return AL_FALSE;
	}

	mlUnlockMutex(buf_mutex);

	return AL_TRUE;
}

/*
 *  Allocate and initialize a new buffer.  Probably shouldn't
 *  be called directly but from add_bufnod (which subsequently
 *  adds it to the pool data structure, which maintains these
 *  things)
 *
 *  assumes locked buffers
 */
static void _alBufferInit(AL_buffer *buf, ALuint bid) {
	ALuint i;

	if(buf == NULL) {
		return;
	}

	buf->num_buffers = _alcDCGetNumSpeakers();

	for(i = 0; i < buf->num_buffers; i++) {
		buf->orig_buffers[i] = NULL;
	}


	buf->bid            = bid;
	buf->flags          = ALB_NONE;
	buf->streampos      = 0;
	buf->appendpos	    = 0;

	buf->format         = canon_format;
	buf->freq           = canon_speed;
	buf->size           = 0;

	buf->callback                = NULL;
	buf->destroy_source_callback = NULL;
	buf->destroy_buffer_callback = NULL;

	buf->queue_list.sids    = NULL;
	buf->queue_list.size    = 0;
	buf->queue_list.items   = 0;

	buf->current_list.sids    = NULL;
	buf->current_list.size    = 0;
	buf->current_list.items   = 0;

	return;
}

void alGetBufferi(ALuint buffer, ALenum param, ALint *value) {
	AL_buffer *buf;
	int retref = 0;

	if(value == NULL) {
		debug(ALD_BUFFER, __FILE__, __LINE__,
			"NULL value passed to alGetBufferi(%d, 0x%x)",
			buffer, param);

		_alcDCLockContext();
		_alDCSetError( AL_INVALID_VALUE );
		_alcDCUnlockContext();
		return;
	}

	_alLockBuffer();
	buf = _alGetBuffer(buffer);

	if(buf == NULL) {
		_alUnlockBuffer();

		debug(ALD_BUFFER, __FILE__, __LINE__,
			"buffer id %d is a bad index", buffer);

		_alcDCLockContext();
		_alDCSetError( AL_INVALID_NAME );
		_alcDCUnlockContext();
		return;
	}

	switch(param) {
		case AL_FREQUENCY:
		  retref = buf->freq;
		  break;
		case AL_BITS:
		  retref = _al_formatbits(buf->format);
		  break;
		case AL_CHANNELS:
		  retref = _al_ALCHANNELS(buf->format);
		  break;
		case AL_SIZE:
		  retref = buf->size;
		  break;
		default:
		  debug(ALD_BUFFER, __FILE__, __LINE__,
			"alGetBufferi bad param 0x%x", param);

		  _alcDCLockContext();
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  _alcDCUnlockContext();
		  break;
	}

	_alUnlockBuffer();

	*value = retref;

	return;
}

void alGetBufferf(ALuint buffer, ALenum param, ALfloat *value) {
	AL_buffer *buf;

	if(value == NULL) {
		return;
	}

	_alLockBuffer();

	buf = _alGetBuffer(buffer);
	if(buf == NULL) {
		_alUnlockBuffer();

		debug(ALD_BUFFER, __FILE__, __LINE__,
			"buffer id %d is a bad index", buffer);

		_alcDCLockContext();
		_alDCSetError(AL_INVALID_NAME);
		_alcDCUnlockContext();
		return;
	}

	switch(param) {
		default:
		  debug(ALD_BUFFER, __FILE__, __LINE__,
			"bad parameter 0x%x", param);

		  _alcDCLockContext();
		  _alDCSetError( AL_ILLEGAL_ENUM );
		  _alcDCUnlockContext();
		  break;
	}

	_alUnlockBuffer();

	return;
}

/*
 *
 *  Resize buf_pool to contain space for at least nb
 *  buffers.  A performance hint best excercised before
 *  creating buffers.
 */
void _alNumBufferHint(ALuint nb) {
	_alLockBuffer();

	bpool_resize(&buf_pool, nb);

	_alUnlockBuffer();
}

/*
 * resize spool to at least newsize buffer pool entries.
 */
ALboolean bpool_resize(bpool_t *spool, size_t newsize) {
	void *temp;
	unsigned int i;

	if(newsize < 1) {
		newsize = 1;
	}

	if(spool->size >= newsize) {
		return AL_TRUE; /* no resize needed */
	}

	/*
	 * Resize buffer pool
	 */
	temp = realloc(spool->pool, newsize * sizeof *spool->pool);
	if(temp == NULL) {
		return AL_FALSE; /* could not realloc */
	}

	spool->pool = temp;

	for(i = spool->size; i < newsize; i++) {
		spool->pool[i].inuse = AL_FALSE;
	}

	/*
	 * resize the sid <-> index map.
	 */
	temp = realloc(spool->map, newsize * sizeof *spool->map);
	if(temp == NULL) {
		return AL_FALSE;
	}
	spool->map = temp;

	for(i = spool->size; i < newsize; i++) {
		spool->map[i] = 0;
	}

	spool->size = newsize;

	return AL_TRUE;
}

static int bpool_alloc(bpool_t *spool) {
	ALuint size = 0;
	int bindex = 0;

	bindex = bpool_first_free_index(spool);
	if(bindex == -1)  {
		size = spool->size + spool->size / 2;

		if(size < MINBUFFERS) {
			size = MINBUFFERS;
		}

		if(bpool_resize(spool, size) == AL_FALSE) {
			return -1;
		}
		
		bindex = bpool_first_free_index(spool);
	}

	spool->pool[bindex].inuse = AL_TRUE;
	spool->map[bindex]        = bpool_next_bid();

	_alBufferInit(&spool->pool[bindex].data, spool->map[bindex]);

	return spool->map[bindex];
}

static AL_buffer *bpool_index(bpool_t *spool, ALuint bid) {
	int bindex;

	bindex = bpool_bid_to_index(spool, bid);
	if(bindex < 0) {
		return NULL;
	}

	if(bindex >= (int) spool->size) {
		return NULL;
	}

	return &spool->pool[bindex].data;
}

static int bpool_first_free_index(bpool_t *spool) {
	unsigned int i;

	for(i = 0; i < spool->size; i++) {
		if(spool->pool[i].inuse == AL_FALSE) {
			return i;
		}
	}

	return -1;
}

static ALboolean bpool_dealloc(bpool_t *spool, ALuint bid,
				void (*freer_func)(void *)) {
	AL_buffer *src;
	int bindex;

	bindex = bpool_bid_to_index(spool, bid);
	if(bindex < 0) {
		/* invalid bid */
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"bid %d is a bad index", bid);

		return AL_FALSE;
	}

	if(bindex >= (int) spool->size) {
		return AL_FALSE;
	}

	src = bpool_index(spool, bid);
	if(src == NULL) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"bid %d is a bad index", bid);
		return AL_FALSE;
	}

	if(spool->pool[bindex].inuse == AL_FALSE) {
		/* already deleted */
		return AL_FALSE;
	}

	debug(ALD_MEM, __FILE__, __LINE__, "freer_func'ing %d", bid);

	freer_func(src);

	spool->pool[bindex].inuse = AL_FALSE;

	return AL_TRUE;
}


static void bpool_free(bpool_t *bpool, void (*freer_func)(void *)) {
	ALuint bid;
	unsigned int i;

	for(i = 0; i < bpool->size; i++) {
		if(bpool->pool[i].inuse == AL_TRUE) {
			bid = bpool->map[i];

			bpool_dealloc(bpool, bid, freer_func);
		}
	}

	if(bpool->pool != NULL) {
		free(bpool->pool);
		bpool->pool = NULL;
	}

	if(bpool->map != NULL) {
		free(bpool->map);
		bpool->map = NULL;
	}

	bpool->size = 0;

	/* let the caller free spool itself */
	return;
}

void bpool_init(bpool_t *spool) {
	spool->size = 0;
	spool->pool = NULL;
	spool->map  = NULL;

	return;
}

/*
 * Convert the bid to an index in bpool's pool.  This is
 * to enable unique bids but reuse the indexes.
 *
 * FIXME: use binary search.
 */
static int bpool_bid_to_index(bpool_t *bpool, ALuint bid) {
	unsigned int i;

	for(i = 0; i < bpool->size; i++) {
		if(bpool->map[i] == bid) {
			return i;
		}
	}

	return -1;
}

/*
 * Get unique id.
 */
static ALuint bpool_next_bid(void) {
	static ALuint id = AL_FIRST_BUFFER_ID;

	return ++id;
}

/* assumes locked buffer */
ALboolean _alBidIsStreaming(ALuint bid) {
	AL_buffer *buf;
	ALboolean retval = AL_FALSE;

	buf = _alGetBuffer(bid);
	if(buf != NULL) {
		if(buf->flags & ALB_STREAMING) {
			retval = AL_TRUE;
		}
	}

	return retval;
}

/* assumes locked buffer */
ALboolean _alBidIsCallback(ALuint bid) {
	AL_buffer *buf;

	buf = _alGetBuffer(bid);

	return _alBufferIsCallback(buf);
}

/* assumes locked buffer */
ALboolean _alBufferIsCallback(AL_buffer *buf) {
	ALboolean retval = AL_FALSE;

	if(buf != NULL) {
		if(buf->flags & ALB_CALLBACK) {
			retval = AL_TRUE;
		}
	}

	return retval;
}

/*
 *  Callbacks handled by al (or alu, or alut) need to be informed of
 *  source/buffer destruction
 */
void _alBufferDataWithCallback_LOKI(ALuint bid,
					int (*callback)(ALuint sid, 
							ALuint bid,
							ALshort *outdata,
							ALenum format,
							ALint freq,
							ALint samples),
					DestroyCallback_LOKI d_sid,
					DestroyCallback_LOKI d_bid) {
	AL_buffer *buf;
	ALuint i;

	_alLockBuffer();
	buf = _alGetBuffer(bid);

	if(buf == NULL) {
		/* bid was invalid */
		debug(ALD_BUFFER, __FILE__, __LINE__,
			"Invalid buffer id %d", bid);

		_alcDCLockContext();
		_alDCSetError(AL_INVALID_NAME);
		_alcDCUnlockContext();

		_alUnlockBuffer();

		return;
	}

	for(i = 0; i < buf->num_buffers; i++) {
		if(buf->orig_buffers[i] != NULL) {
			free(buf->orig_buffers[i]);
			buf->orig_buffers[i] = NULL;
		}
	}

	buf->size     = 0;
	buf->callback = callback;
	buf->flags    |= ALB_CALLBACK;

	buf->destroy_buffer_callback = d_bid;
	buf->destroy_source_callback = d_sid;

	_alUnlockBuffer();

	return;
}

/* assumes locked buffers */
static void _alBufferDestroyCallbackBuffer(AL_buffer *buf) {
	if(buf == NULL) {
		return;
	}

	if(buf->destroy_buffer_callback != NULL) {
		buf->destroy_buffer_callback(buf->bid);
	}

	return;
}

/* assumes locked context */
void _alBidCallDestroyCallbackSource(ALuint sid) {
	AL_buffer *buf;
	AL_source *src;
	ALuint *bid;

	src = _alDCGetSource(sid);
	if(src == NULL) {
		return;
	}

	bid = _alGetSourceParam(src, AL_BUFFER);
	if(bid == NULL) {
		return;
	}

	_alLockBuffer();

	buf = _alGetBuffer(*bid);
	if(buf == NULL) {
		_alUnlockBuffer();
		return;
	}

	if(buf->destroy_source_callback != NULL) {
		buf->destroy_source_callback(sid);
	}

	_alUnlockBuffer();

	return;
}

/*
 * void *_alConvert(void *data,
 *			ALenum f_format, ALuint f_size, ALuint f_freq,
 *			ALenum t_format, ALuint t_freq, ALuint *retsize,
 *			ALenum should_use_passed_data);
 *
 * _alConvert takes the passed data and converts it from it's current
 * format (f_format) to the desired format (t_format), etc, returning
 * the converted data and setting retsize to the new size of the 
 * converted data.  The passed data must either be raw PCM data or
 * must correspond with one of the headered extension formats.
 *
 * If should_use_passed_data is set to AL_TRUE, then _alConvert will
 * attempt to do the conversion in place.  Otherwise, new data will
 * be allocated for the purpose.
 *
 * Returns NULL on error.
 */
static void *_alConvert(void *data,
	ALenum f_format, ALuint f_size, ALuint f_freq,
	ALenum t_format, ALuint t_freq, ALuint *retsize,
	ALenum should_use_passed_data) {
	ALvoid *compressed = NULL;
	ALvoid *retval = NULL;
	acAudioCVT s16le;

	/*
	 * no conversion needed.  Just copy data
	 */
	if((f_format   == t_format)   &&
	   (f_freq     == t_freq)) {
		if(should_use_passed_data == AL_TRUE) {
			debug(ALD_CONVERT, __FILE__, __LINE__,
				"_alConvert: no conversion needed: %p");

			*retsize = f_size;
			return data;
		}

		retval = malloc(f_size);
		memcpy(retval, data, f_size);

		*retsize = f_size;
	
		return retval;
	}

	/*
	 * Compressed auto formats like IMA_ADPCM get converted in
	 * full here.
	 */
	if(_al_RAWFORMAT(f_format) == AL_FALSE) {
		ALushort acfmt;
		ALushort achan;
		ALushort acfreq;

		switch(f_format) {
			case AL_FORMAT_IMA_ADPCM_MONO16_EXT:
			case AL_FORMAT_IMA_ADPCM_STEREO16_EXT:
			case AL_FORMAT_WAVE_EXT:
				acLoadWAV(data, &f_size, &retval, &acfmt, &achan, &acfreq);

				f_format = _al_AC2ALFMT(acfmt, achan);
				f_freq   = acfreq;
				break;
			default:
			break;
		}

		compressed = data = retval;
	}

	debug(ALD_CONVERT, __FILE__, __LINE__,
		"_alConvert [f_size|f_channels|f_freq] [%d|%d|%d]",
		f_size, _al_ALCHANNELS(f_format), f_freq);

	if(_al_ALCHANNELS(f_format) != 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"_alConvert [t_channels|f_channels|t/f] [%d|%d|%d]",
			_al_ALCHANNELS(t_format),
			_al_ALCHANNELS(f_format),
			_al_ALCHANNELS(t_format) /
			_al_ALCHANNELS(f_format));
	}

	if(f_freq != 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"_alConvert [t_freq|f_freq|t/f] [%d|%d|%d]",
			t_freq, f_freq, t_freq/f_freq);
	}

	if(f_format != 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"_alConvert [t_bits|f_bits|t/f] [%d|%d|%d]",
			_al_formatbits(t_format),
			_al_formatbits(f_format),
			(_al_formatbits(t_format) / _al_formatbits(f_format)));
	}

	debug(ALD_CONVERT, __FILE__, __LINE__,
		"_alConvert f|c|s [0x%x|%d|%d] -> [0x%x|%d|%d]",
		/* from */
		f_format, _al_ALCHANNELS(f_format), f_freq,
		/* to */
		t_format,
		_al_ALCHANNELS(t_format),
		t_freq);

	if(acBuildAudioCVT(&s16le,
		/* from */
		_al_AL2ACFMT(f_format),
		_al_ALCHANNELS(f_format),
		f_freq,

		/* to */
		_al_AL2ACFMT(t_format),
		_al_ALCHANNELS(t_format),
		t_freq) < 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"Couldn't build audio convertion data structure.");

		free(compressed);

		return NULL;
	}

	debug(ALD_CONVERT, __FILE__, __LINE__,
		"_alConvert [len|newlen] [%d|%d]",
		f_size, f_size * s16le.len_mult);

	if(should_use_passed_data == AL_TRUE) {
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"Converting with passed data = %p", data);
		debug(ALD_CONVERT, __FILE__, __LINE__,
			"len_multi = %d", s16le.len_mult);

		s16le.buf = retval = data;
	} else {
		/* alloc space for buffer if we aren't using the original */

		s16le.buf = retval = malloc(f_size * s16le.len_mult);
		if(retval == NULL) {
			_alDCSetError(AL_OUT_OF_MEMORY);

			free( compressed );
			return NULL;
		}
		memcpy(retval, data, f_size);
	}

	s16le.len = f_size;

	if(acConvertAudio(&s16le) < 0) {
		debug(ALD_CONVERT, __FILE__, __LINE__, "Couldn't execute conversion into canon.");

		free( compressed );

		return NULL;
	}

	/* set return size */
	*retsize = s16le.len_cvt;

	debug(ALD_CONVERT, __FILE__, __LINE__, "f_size = %d\tretsize = %d", f_size, *retsize);

	if(s16le.buf != compressed) {
		/*
		 * this comparison is false iff we are using a
		 * compressed/headered format that requires us to allocate
		 * a temporary buffer.
		 */
		free( compressed );
	}

	return s16le.buf;
}

/*
 *
 * assumes locked context
 */
void _alBidRemoveQueueRef(ALuint bid, ALuint sid) {
	AL_buffer *buf;

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		/* invalid name */
		_alUnlockBuffer();
		return;
	}

	_alBufferRemoveQueueRef(buf, sid);

	_alUnlockBuffer();

	return;
}

void _alBidRemoveCurrentRef(ALuint bid, ALuint sid) {
	AL_buffer *buf;

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		/* invalid name */
		_alUnlockBuffer();
		return;
	}

	_alBufferRemoveCurrentRef(buf, sid);

	_alUnlockBuffer();

	return;
}

/*
 *
 * assumes locked context
 */
void _alBidAddQueueRef(ALuint bid, ALuint sid) {
	AL_buffer *buf;

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		/* invalid name, set error elsewhere? */
		_alUnlockBuffer();

		return;
	}

	_alBufferAddQueueRef(buf, sid);

	_alUnlockBuffer();

	return;
}

void _alBidAddCurrentRef(ALuint bid, ALuint sid) {
	AL_buffer *buf;

	_alLockBuffer();

	buf = _alGetBuffer(bid);
	if(buf == NULL) {
		/* invalid name */
		_alUnlockBuffer();
		return;
	}

	_alBufferAddCurrentRef(buf, sid);

	_alUnlockBuffer();
	return;
}

/*
 *
 * assumes locked context, buffer
 */
static void _alBufferAddQueueRef(AL_buffer *buf, ALuint sid) {
	ALvoid *temp;
	ALuint newsize = buf->queue_list.size;

	if(buf->queue_list.size <= buf->queue_list.items) {
		/* resize */
		newsize *= 2;
		newsize += 1;
		temp = realloc(buf->queue_list.sids, newsize * sizeof *buf->queue_list.sids);
		if(temp == NULL) {
			/* well la-di-da */
			return;
		}

		buf->queue_list.sids = temp;
		buf->queue_list.size = newsize;
	}

	buf->queue_list.sids[buf->queue_list.items++] = sid;

	return;
}

/*
 *
 * assumes locked context, buffer
 */
static void _alBufferAddCurrentRef(AL_buffer *buf, ALuint sid) {
	ALvoid *temp;
	ALuint newsize = buf->current_list.size;

	if(buf->current_list.size <= buf->current_list.items) {
		/* resize */
		newsize *= 2;
		newsize += 1;

		temp = realloc(buf->current_list.sids, newsize * sizeof *buf->current_list.sids);
		if(temp == NULL) {
			/* well la-di-da */
			return;
		}

		buf->current_list.sids = temp;
		buf->current_list.size = newsize;
	}

	buf->current_list.sids[buf->current_list.items++] = sid;

	return;
}

/*
 *
 * assumes locked context, buffer
 */
static void _alBufferRemoveQueueRef(AL_buffer *buf, ALuint sid) {
	ALuint i;

	for(i = 0; i < buf->queue_list.size; i++) {
		if(buf->queue_list.sids[i] == sid) {
			buf->queue_list.sids[i] = 0;
			buf->queue_list.items--;

			return;
		}
	}

	return;
}

/*
 * _alBufferRemoveCurrentRef
 *
 * assumes locked context, buffer
 */
static void _alBufferRemoveCurrentRef(AL_buffer *buf, ALuint sid) {
	ALuint i;

	for(i = 0; i < buf->current_list.size; i++) {
		if(buf->current_list.sids[i] == sid) {
			buf->current_list.sids[i] = 0;
			buf->current_list.items--;

			return;
		}
	}

	return;
}

/*
 * _alGetBidState
 *
 * Returns the state (one of AL_UNUSED, AL_CURRENT, AL_QUEUED) associated
 * with a buffer.
 *
 * assumes locked buffers
 */
ALenum _alGetBidState(ALuint bid) {
	ALenum retval = AL_UNUSED;
	AL_buffer *buf;

	buf = _alGetBuffer(bid);
	if(buf != NULL) {
		retval = _alGetBufferState( buf );
	}

	return retval;
}

/*
 *
 * assumes locked buffers
 */
ALenum _alGetBufferState(AL_buffer *buffer) {
	if(buffer->current_list.items > 0) {
		return AL_CURRENT;
	}

	if(buffer->queue_list.items > 0) {
		return AL_QUEUED;
	}

	return AL_UNUSED;
}

/* binary compatibility functions */
ALsizei alBufferAppendData( ALuint   buffer,
                            ALenum   format,
                            void*    data,
		            ALsizei  osamps,
                            ALsizei  freq);

ALsizei alBufferAppendData( ALuint   buffer,
                            ALenum   format,
                            void*    data,
		            ALsizei  osamps,
                            ALsizei  freq) {
	return alBufferAppendData_LOKI(buffer, format, data, osamps, freq);
}
