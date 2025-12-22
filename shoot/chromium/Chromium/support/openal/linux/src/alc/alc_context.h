/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * alc_context.h
 *
 * Prototypes, defines etc for context aquisition and management.
 */
#ifndef _ALC_CONTEXT_H_
#define _ALC_CONTEXT_H_

#include "AL/altypes.h"
#include "AL/alkludge.h"

#include "../al_types.h"
#include "../al_attenuation.h"

#include "audioconvert.h"

#define _ALC_DEF_FREQ        44100
#define _ALC_DEF_BUFSIZ       2048

/*
 * Canonical stuff
 */
#define _ALC_CANON_FMT        AL_FORMAT_MONO16
#define _ALC_CANON_SPEED      _ALC_DEF_FREQ

#define _ALC_EXTERNAL_FMT        AL_FORMAT_STEREO16
#define _ALC_EXTERNAL_SPEED      _ALC_DEF_FREQ

/* public stuff */
void  alcParamater1f   (void *cih, ALenum param, ALfloat datum);

/* globally accesible data */
extern ALuint _alcCCId; /* Current Context Id */
extern const int canon_max, canon_min; /* max/min values for PCM data in
				 	* our canonical format
					*/

extern ALenum canon_format; /* the canonical format that we represent data
			       data internally as */
extern ALuint canon_speed;  /* the sampling rate at which we represent data
			       internally */

/* openal specific function prototypes */

/* do global initialization for all contexts */
void         _alcInitContexts(void);

/* initialize context with id cid with default values */
AL_context * _alcInitContext(ALuint cid);

/* retrieve context with id cid, or NULL if cid is invalid */
AL_context * _alcGetContext(ALuint cid);

/* retrieve context by index, or NULL if cindex is >= the number of
 * available contexts
 */
AL_context *_alcGetContextByIndex(ALuint cindex);

/* set context id paramaters according to an attributive list */
void         _alcSetContext(int *attrlist, ALuint cid );

/* allocate a new id for a context */
ALint        _alcGetNewContextId(void);

/* test whether the context with id cid is in use */
ALboolean    _alcInUse(ALuint cid);

/* set use flag of context with id cid */
ALboolean    _alcSetUse(ALuint cid, ALboolean value);

/* get read/write buffersize associated with context with id cid */
ALuint       _alcGetReadBufsiz(ALuint cid);
ALuint       _alcGetWriteBufsiz(ALuint cid);

/* get listener associated with context with id cid */
AL_listener *_alcGetListener(ALuint cid);

/* global destruction and cleanup */
void         _alcDestroyAll(void);

/* enable capture for context cid */
ALboolean _alcEnableCapture(ALuint cid);
void _alcDisableCapture(ALuint cid);

time_filter_set *_alcGetTimeFilters(ALuint cid);
freq_filter_set *_alcGetFreqFilters(ALuint cid);

ALuint _alcGetReadFreq(ALuint cid);
ALenum _alcGetReadFormat(ALuint cid);

void FL_alcUnlockContext(ALuint cid, const char *fn, int ln);
void FL_alcLockContext(ALuint cid, const char *fn, int ln);
void FL_alcUnlockAllContexts(const char *fn, int ln);
void FL_alcLockAllContexts(const char *fn, int ln);

#define alcDCParamater1f()        _alcParamater1f(_alcCCId, p, d)
#define _alcDCGetContext()        _alcGetContext(_alcCCId)
#define _alcDCGetReadBufsiz()     _alcGetReadBufsiz(_alcCCId)
#define _alcDCGetWriteBufsiz()    _alcGetWriteBufsiz(_alcCCId)
#define _alcDCGetTimeFilters()    _alcGetTimeFilters(_alcCCId)
#define _alcDCGetFreqFilters()    _alcGetFreqFilters(_alcCCId)
#define _alcDCGetListener()       _alcGetListener(_alcCCId)
#define _alcDCGetScalingFactor()  _alcGetScalingFactor(_alcCCId)
#define _alcDCEnableCapture()     _alcEnableCapture(_alcCCId)
#define _alcDCDisableCapture()    _alcDisableCapture(_alcCCId)
#define _alcDCGetReadFreq()       _alcGetReadFreq(_alcCCId)
#define _alcDCGetReadFormat()     _alcGetReadFormat(_alcCCId)

#define _alcDCLockContext()     FL_alcLockContext(_alcCCId, __FILE__, __LINE__)
#define _alcDCUnlockContext()   FL_alcUnlockContext(_alcCCId,__FILE__, __LINE__)
#define _alcUnlockContext(c)    FL_alcUnlockContext(c, __FILE__, __LINE__)
#define _alcLockContext(c)      FL_alcLockContext(c, __FILE__, __LINE__)
#define _alcUnlockAllContexts() FL_alcUnlockAllContexts(__FILE__, __LINE__)
#define _alcLockAllContexts()   FL_alcLockAllContexts(__FILE__, __LINE__)

#endif /* _ALC_CONTEXT_H_ */
