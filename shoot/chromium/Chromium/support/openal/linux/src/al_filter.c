/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_filter.c
 *
 * Contains filters.
 *
 *
 * Short guide to filters:
 *
 * Filters all have the prefix alf_<something>.  Each filter
 * defined in software_time_filters or software_frequency_filters
 * is applied to each source that finds its way into the mixer.
 *
 * ApplyFilters takes a chunk of data from the original buffer 
 * associated with the passed source.
 *
 * This chunk is understood to be that block of data samp->_orig_buffer
 * offset src->soundpos to src->soundpos + bufsiz, where src is the
 * passed AL_source, samp is the AL_buffer associated with src, and
 * bufsiz is the length of the chunk of data that we want.  It is usually
 * set to _AL_DEF_BUFSIZE, unless specified by ALC_BUFFERSIZE in the
 * application.
 *
 * Applying filters to a source does not (should not) change the original
 * pcm data.  ApplyFilters will split the original pcm data prior to
 * calling each filter, and filters should restrict themselves to 
 * manipulating the passed data.
 *
 * time domain filters (those defines in software_time_filters) are
 * passed:
 *	ALuint cid
 *		identifier for the context that this source belongs to
 *	AL_source *src
 *		source that the filter should be applied to
 *	AL_buffer *samp
 *		buffer that the source is associated with
 *	ALshort **buffers
 *		arrays of points to PCM data, one element per 
 *		channel(left/right/etc)
 *	ALuint nc
 *		number of elements in buffers
 *	ALuint len
 *		byte length of each element in buffers
 *
 * Filters are expected to alter buffers[0..nc-1] in place.  After 
 * the ApplyFilter iteration is over, the resulting data is mixed into
 * the main mix buffer and forgotten.  The data altered is cumulative,
 * that is to say, if two filters alf_f and alf_g occur in sequential
 * order, alf_g will see the pcm data after alf_f has altered it.
 *
 *
 * frequency based filters (those defined in software_freq_filters) 
 * are only available if openal has been configured with --enable-fft.
 * They accept the parameters
 *
 *      ALuint cid
 *		identifier for the context that this source belongs to
 *      AL_source *src
 *		source that the filter should be applied to
 *      AL_buffer *samp
 *		buffer that the source is associated with
 *      ALcomplex **buffers
 *      	buffer that contains complex numbers corresponding to
 *      	a fft-ification of the pcmdata that would normally be
 *      	passed to a time-domain filter.
 *      ALuint nc
 *		number of elements in buffers
 *      ALuint len
 *		*sample* length of each element in buffers.
 *
 * The main caveat here being that len here is sample len, not byte
 * length.  I know it's kludgey.  I'm looking into it.  The same rules
 * that otherwise apply to buffers in time-domain filters apply here
 * as well: data is altered in-place.
 *
 * FINER POINTS:
 *
 * A lot of the filters make effects by modulating amplitude and delay.
 * Because these changes are cumulative, we can reduce the application
 * of amplitude and delay changes to one operation.  This is the point
 * of SourceParamApply --- filters can make changes to srcParams.gain
 * and srcParams.delay in a source and have those changes applied at
 * the end of the ApplyFilters call for the source.  These values are
 * reset to their defaults at the top of the ApplyFilters call.
 *
 */
#include "al_siteconfig.h"

#include <math.h> 
#include <stdlib.h>
#include <string.h>

#include "al_able.h"
#include "al_attenuation.h"
#include "al_buffer.h"
#include "al_debug.h"
#include "al_error.h"
#include "al_filter.h"
#include "al_fft.h"
#include "al_listen.h"
#include "al_main.h"
#include "al_mixer.h"
#include "al_source.h"
#include "al_queue.h"

#include "alc/alc_context.h"
#include "alc/alc_speaker.h"

/* 
 * TPITCH_MAX sets the number of discrete values for AL_PITCH we can have.
 * You can set AL_PITCH to anything, but integer rounding will ensure that
 * it will fall beween MIN_SCALE and 2.0.
 *
 * 2.0 is an arbitrary constant, and likely to be changed.
 */
#define TPITCH_MAX       64

/* static function declarations */
static ALfloat compute_sa(ALfloat *sp, ALfloat *speaker_pos, ALfloat scale);

/* static data */

/*
 * The default software time domain filters.
 *
 * I wish I could say that the order of these does not matter,
 * but it does.  Namely, tdoppler and tpitch must occur in that
 * order, and they must occur before any other filter.
 */
static time_filter_set software_time_filters[] = {
#ifndef FFT
	{ "tdoppler", alf_tdoppler }, 

	/* our hacky, horrible time-domain pitch filter */
	{ "tpitch",   alf_tpitch   }, 
#endif /* FFT */

	{ "gain",   alf_gain },
	{ "da",     alf_da },
	{ "reverb", alf_reverb },
	{ "coning", alf_coning },
	{ "minmax",  alf_minmax },
	{ "listenergain",  alf_listenergain },
	{ { 0 },     NULL }
};

/*
 * The default software frequency domain filters.
 */
static freq_filter_set software_freq_filters[] = {
#ifdef FFT
	{ "pitch",   alf_pitch },
	{ "doppler", alf_doppler },
#endif /* FFT */
	{ { 0 },      NULL },
};

/*
 * our quick lookup table for our time domain pitch filter.
 *
 *
 * We initialize each element in offsets to be a set of offsets,
 * such that
 *
 * 	offset[x][y] = y * pitch
 *
 * 	Where x is the discrete integer value of pitch, and y is
 * 	any value between 0 and the length of a buffer.
 *
 * What's the point?  To save the pain of float->int conversion at
 * runtime, which is needed to map the original PCM data to a
 * "pitch modified" mapping of the same data.
 *
 */
static struct {
	int *offsets[TPITCH_MAX]; /* use int instead of ALint because
				   * these are array indexes
				   */
	ALuint max;
	ALuint middle; /* the index which pitch == 1.0 corresponds to */
	ALuint len; /* length of offsets[0...TPITCH_MAX] in samples */

	int *raw;     /*
			* raw data.  We actually alloc/dealloc this chunk and
			* assign ->offsets in order to reduce fragmentation.
			*/
} tpitch_lookup = { { NULL }, 0, 0, 0, NULL };

/* func associated with our tpitch lookup */
static void init_tpitch_lookup(ALuint len);

static ALfloat compute_doppler_pitch(ALfloat *object1, ALfloat *o1_vel,
			       ALfloat *object2, ALfloat *o2_vel,
			       ALfloat factor, ALfloat speed);
/*
 *  Default filters.
 */
void _alInitTimeFilters(time_filter_set *tf_ptr_ref) {
	ALuint i = 0;

	do {
		tf_ptr_ref[i] = software_time_filters[i];
	} while(software_time_filters[i++].filter != NULL);

	/*
	 * init tpitch_loopup only if it hasn't been initialized
	 * yet.
	 */
	if(tpitch_lookup.max != TPITCH_MAX) {
		tpitch_lookup.max    = TPITCH_MAX;
		tpitch_lookup.middle = TPITCH_MAX / 2;

		tpitch_lookup.raw = NULL;

		for(i = 0; i < tpitch_lookup.max; i++) {
			tpitch_lookup.offsets[i] = NULL;
		}
	}

	return;
}

void _alInitFreqFilters(freq_filter_set *ff_ptr_ref) {
	int i = 0;

	do {
		ff_ptr_ref[i] = software_freq_filters[i];
	} while(software_freq_filters[i++].filter != NULL);

	return;
}

/*
 * alf_coning
 *
 * Implements the coning filter, which is used when CONE_INNER_ANGLE
 * or CONE_OUTER_ANGLE is set.  This is used for directional sounds.
 *
 * The spec is vague as to the actual requirements of directional sounds,
 * and Carlo has suggested that we maintain the DirectSound meaning for
 * directional sounds, namely (in my interpretation):
 *
 *    The inner, outer cone define three zones: inside inner cone
 *    (INSIDE), between inner and outer cone (BETWEEN, outside outer cone,
 *    (OUTSIDE).
 *
 *    In INSIDE, the gain of the sound is attenuated as a normal
 *    positional source.
 *
 *    In OUTSIDE, the gain is set to some value specified by the user.
 *
 *    In BETWEEN, the gain is transitionally set to some value between
 *    what it would be in INSIDE and OUTSIDE.
 *
 * This requires an additional source paramter, like CONE_OUTSIDE_ATTENUATION,
 * and quite frankly seems goofy.  This implementation implements the
 * following convention:
 *
 *    In INSIDE, the gain of the sound is attenuated as a normal
 *    positional source.
 *
 *    In OUTSIDE, the gain is set to _AL_CUTTOFF_ATTENUATION
 *
 *    In BETWEEN, the gain is transitionally set to some value between
 *    what it would be in INSIDE and OUTSIDE.
 *
 * Well, okay that's still pretty goofy.  Folks who want to set a 
 * minimum attenuation can stil do so using AL_SOURCE_ATTENUATION_MIN.
 *
 * IMPLEMENTATION: 
 * okay, we check the angle between the speaker position and
 * the source's direction vector, using the source's position
 * as the origin.  This angle we call theta.
 *
 * Then, we compare theta with the outer cone angle.  If it's greater,
 * we use the min attenuation.  If it's less, we compare theta with
 * the inner cone angle.  If it's greater, we attenuate as normal.
 * Otherwise, we don't attenuate at all (full volume, pitch etc).
 *
 * FIXME: please check my math.
 *        split min/max distance into another filter?
 */
void alf_coning(ALuint cid, AL_source *src, UNUSED(AL_buffer *samp),
		 UNUSED(ALshort **buffers), ALuint nc, ALuint len) {
	AL_context *cc;
	ALfloat sa;  /* speaker attenuation */
	ALfloat *sp; /* source position  */
	ALfloat *sd; /* source direction */
	ALfloat *speaker_pos; /* speaker position */
	ALfloat theta; /* angle between listener and source's direction
			* vector, with the source's position as origin.
			*/
	ALfloat srcDir[3];
	ALfloat icone; /* inner cone angle */
	ALfloat ocone; /* outer cone angle */
	ALuint i;
	void *temp;

	if(_alIsEnabled(AL_DISTANCE_ATTENUATION) == AL_FALSE) {
		return;
	}

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		/* ugh.  bad context id */
		return;
	}

	/* If no direction set, return */
	sd = _alGetSourceParam(src, AL_DIRECTION);
	if(sd == NULL) {
		/*
		 * source has no direction (normal).  leave it for alf_da
		 */
		return;
	}

	sp =  _alGetSourceParam(src, AL_POSITION);
	if(sp == NULL) {
		/* If no position set, return */

		return;
	}

	srcDir[0] = sp[0] + sd[0];
	srcDir[1] = sp[1] + sd[1];
	srcDir[2] = sp[2] + sd[2];

	/* Get CONE settings.
	 *
	 * If unset, use 360.0 degrees
	 */
	temp = _alGetSourceParam(src, AL_CONE_INNER_ANGLE);
	if(temp == NULL) {
		icone = _alDegreeToRadian( 360.0 );
	} else {
		icone = _alDegreeToRadian(* (ALfloat *) temp);
	}

	temp = _alGetSourceParam(src, AL_CONE_OUTER_ANGLE);
	if(temp == NULL) {
		ocone = _alDegreeToRadian( 360.0 );
	} else {
		ocone = _alDegreeToRadian(* (ALfloat *) temp);
	}

	len /= sizeof(ALshort); /*  scale len, as we use it as an index
				   into an ALshort buffer */

	debug(ALD_SOURCE, __FILE__, __LINE__,
		"alf_coning: sid %d icone %f ocone %f", src->sid, icone, ocone );

	for(i = 0; i < nc; i++) {
		speaker_pos = _alcGetSpeakerPosition(cid, i);
		theta = fabs( vector_angle_between(sp, speaker_pos, srcDir) );

		if( theta <= (icone / 2.0f) ) {
			/*
			 * INSIDE:
			 *
			 * attenuate normally
			 */
			debug(ALD_SOURCE, __FILE__, __LINE__,
				"alf_coning: sid %d speaker %d theta %f INSIDE", src->sid, i, theta );

			/*
			 * speaker[i] is in inner cone, don't do
			 * anything.
			 */
			sa = compute_sa(sp, speaker_pos, cc->distance_scale);
		} else if( theta <= ( ocone / 2.0f) ) {
			/*
			 * BETWEEN:
			 *
			 * kind of cheesy, but we average the INSIDE
			 * and OUTSIDE attenuation.
			 */
			debug(ALD_SOURCE, __FILE__, __LINE__,
				"alf_coning: sid %d speaker %d theta %f BETWEEN", src->sid, i, theta);

			sa = compute_sa(sp, speaker_pos, cc->distance_scale);

			sa += _AL_CUTTOFF_ATTENUATION;
			sa /= 2;
		} else { 
			/*
			 * OUTSIDE:
			 *
			 * Set to attenuation_min
			 */
			debug(ALD_SOURCE, __FILE__, __LINE__,
				"alf_coning: sid %d speaker %d theta %f OUTSIDE", src->sid, i, theta );

			sa = _AL_CUTTOFF_ATTENUATION;
		}

		/* set gain, to be applied in SourceParamApply */
		src->srcParams.gain[i] *= sa;
	}

	return;
}


/* good thing I kept this around */
void _alDestroyFilters(void) {
	ALuint i;

	if(tpitch_lookup.raw != NULL) {
		free(tpitch_lookup.raw);
	}

	tpitch_lookup.raw = NULL;

	for(i = 0; i < TPITCH_MAX; i++) {
		tpitch_lookup.offsets[i] = NULL;
	}

	return;
}

/* As far as reverb implementations go, this sucks.  Should be
 * frequency based?
 *
 * Should be able to be applied in sequence for second order 
 * approximations.
 *
 * FIXME: this is so ugly!  And consumes a ton of memory.
 */
void alf_reverb(UNUSED(ALuint cid),
		 AL_source *src, AL_buffer *samp,
		 ALshort **buffers,
		 ALuint nc, ALuint len) {
	ALshort *bpt; /* pointer to passed buffers */
	ALshort *rpt; /* pointer to reverb buffers */
	ALuint i;
	ALfloat scale = src->reverb_scale;
	ALuint delay  = src->reverb_delay;
	ALuint k;
	int sample;

	/* with a delay of 0.0, no reverb possible or needed */
	if(!(src->flags & ALS_REVERB)) {
		return;
	}

	/*
	 * initialize persistent reverb buffers if they haven't been
	 * done before
	 */
	for(i = 0; i < nc; i++) {
		if(src->reverb_buf[i] == NULL) {
			src->reverb_buf[i] = malloc(samp->size);
			memset(src->reverb_buf[i], 0, samp->size);
		}
	}

	if(src->srcParams.soundpos > delay) {
		int revoffset = ((src->srcParams.soundpos - delay) / sizeof(ALshort));

		for(i = 0; i < nc; i++) {
			bpt  = buffers[i];
			rpt  = src->reverb_buf[i];
			rpt += revoffset;

			for(k = 0; k < len / sizeof(ALshort); k++) {
				sample = bpt[k] + rpt[k] * scale;

				if(sample > canon_max) {
					sample = canon_max;
				} else if (sample < canon_min) {
					sample = canon_min;
				}

				bpt[k] = sample;
			}
		}
	}

	_alBuffersAppend(src->reverb_buf,
			(void **) buffers, len, src->reverbpos, nc);

	src->reverbpos += len;

	return;
}


/* 
 * _alApplyFilters
 *
 * _alApplyFilters is called from the mixing function, and is passed
 * a source id and the context where this sourceid has meaning.
 *
 * The filters that are applied to the source are determined by the
 * context.  Each context is initialized such that it contains a table
 * of the software filters.  Extensions and plugins can be later loaded
 * to override the default functionality.  The point being, each context's
 * filter "signature" may be different.
 *
 * Because of differences in paramaterization, filters are seperated into
 * two sets: time domain filters and frequency based filers.  frequency
 * base filters are not run unless FFT is enabled.
 *
 * assumes locked context cid
 */
void _alApplyFilters(ALuint cid, ALuint sid) {
	AL_source *src;
	AL_buffer *samp;
	int ic = _al_ALCHANNELS(_ALC_CANON_FMT);       /* internal (canon) chans   */
	int mc = _alcGetNumSpeakers(cid);              /* mixer chans (==speakers) */
	ALuint mixbuflen = _alcGetWriteBufsiz(cid);    /* byte size of total data
						        * to compose (all channels)
						        */
	ALint len = mixbuflen * ((float) ic / mc); /* byte size of one
						     * channel's worth of data
						     * to compose */
	ALint filterlen = len; /* filterlen is adjusted below to take into
				 * account looping, etc */
	time_filter_set *cc_tfilters = NULL;
	time_filter *tf = NULL;
#ifdef FFT
	freq_filter_set *cc_ffilters = NULL;
	freq_filter *ff = NULL;
#endif
	int i;
	ALboolean *boolp;	/* for determining bool flags */

	samp = _alGetBufferFromSid(cid, sid);
	if(samp == NULL) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"_alFilter: null samp, sid == %d", sid);
		return;
	}

	/*
	 * Allocate scratch space to hold enough data for the source
	 * about to be split.  We allocate more space in case of a
	 * multichannel source.
	 */
	if(f_buffers.len < len / sizeof (ALshort)) {
		void *temp;
		ALuint newlen = len * _al_ALCHANNELS(samp->format);

		for(i = 0; i < mc; i++) {
			temp = realloc(f_buffers.data[i], newlen);
			if(temp == NULL) {
				/* FIXME: do something */
			}

			f_buffers.data[i] = temp;

#ifdef FFT
			temp = realloc(fft_buffers.data[i],
					newlen * sizeof *fft_buffers[i]);
			if(temp == NULL) {
				/* FIXME: do something */
			}

			fft_buffers.data[i] = temp;

			complex_vector_mul(fft_buffers.data[i], newlen, 0.0);
#endif /* FFT */
		}

		f_buffers.len   = newlen;
		fft_buffers.len = newlen * sizeof *fft_buffers.data;
	}

	if(tpitch_lookup.len < len / sizeof (ALshort)) {
		init_tpitch_lookup(len / sizeof (ALshort));
	}

	src  = _alGetSource(cid, sid);
	if(src == NULL) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
			"_alFilter: null src, sid == %d", sid);
		return;
	}

	/* streaming buffer?  set soundpos */
	if(samp->flags & ALB_STREAMING) {
		src->srcParams.soundpos = samp->streampos;

		if(samp->streampos > samp->size) {
			memset(src->srcParams.outbuf, 0, len);

#ifdef DEBUG_MAXIMUS
			fprintf(stderr, "underflow!!!!!!!!!!!!!!!!\n");
#endif
			return; /* underflow */
		}
	}

	_alSourceParamReset(src); /* reset srcParam settings */

	_alSplitSources(cid, sid, mc, len, samp, (ALshort **) f_buffers.data);

	/*
	 * translate head relative sources
	 */
	boolp = _alGetSourceParam(src, AL_SOURCE_RELATIVE);

	if(boolp != NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		"_alApplyFilters: sid %d relative boolp = %d", sid, *boolp );
		if(*boolp == AL_TRUE) {
			/* This is a RELATIVE source, which means we must
			 * translate it before applying any sort of positional
			 * filter to it.
			 */
			AL_context *cc;

			cc = _alcGetContext(cid);
			if(cc != NULL) {
				_alSourceTranslate(src, cc->listener.Position);
			}
		}
	}

	/* 
	 * adjust len to account for end of sample, looping, etc
	 */
	if(filterlen > _alSourceBytesLeft(src, samp)) {
		if(_alSourceIsLooping( src ) == AL_FALSE ) {
			/* Non looping source */
			filterlen = _alSourceBytesLeft(src, samp);
		}
	}

	cc_tfilters = _alcGetTimeFilters(cid);

	/* apply time domain filters */
	for(i = 0; cc_tfilters[i].filter != NULL; i++) {
		tf = cc_tfilters[i].filter;

		tf(cid, src, samp, (ALshort **) f_buffers.data, mc, filterlen);
	}

#ifdef FFT
	if(src->flags & ALS_NEEDFFT) {
		/* apply frequency based filters */
		ALuint fftlen = filterlen / sizeof(ALshort);

		cc_ffilters = _alcGetFreqFilters(cid);

		_alFFTSources(mc, fftlen, f_buffers.data, fft_buffers.data);

		for(i = 0; cc_ffilters[i].filter != NULL; i++) {
			ff = cc_ffilters[i].filter;

			ff(cid, src, samp, fft_buffers.data, mc, fftlen);
		}

		_alDeFFTSources(mc, fftlen, fft_buffers.data, f_buffers.data);
	}
#endif

	/*
	 *  Apply gain and delay for filters that don't actually touch
	 *  the data (alf_gain, alf_da).
	 */
	_alSourceParamApply(src, mc, filterlen, (ALshort **) f_buffers.data);

	/*
	 * Take the resulting pcm data in f_buffers, and mix these into
	 * the source's temporary output buffer.
	 */
	_alCollapseSource(cid, sid, mc, mixbuflen, (ALshort **) f_buffers.data);

	/*
	 * head RELATIVE sources need to be untranslated, lest their
	 * position become weird.
	 */
	if((boolp != NULL) && (*boolp == AL_TRUE)) {
		AL_context *cc;
		ALfloat ipos[3]; /* inverse listener position */

		cc = _alcGetContext(cid);

		if(cc != NULL) {
			vector_inverse(ipos, cc->listener.Position);
			_alSourceTranslate(src, ipos);
		}
	}

	return;
}

/*
 *  this filter acts out AL_GAIN.
 *
 *  This would be a simple linear application of some normalized
 *  float (ie, the source's gain parameter), but to avoid pop-off
 *  artifacts we never zero-out source.
 *
 *  Instead, we elect to set the gain to _AL_CUTTOFF_ATTENUATION,
 *  which is some small non-zero value chosen for this purpose.
		
 */
void alf_gain(UNUSED(ALuint cid), AL_source *src, UNUSED(AL_buffer *samp),
	       UNUSED(ALshort **buffers), ALuint nc, UNUSED(ALuint len)) {
	ALfloat *gain = _alGetSourceParam(src, AL_GAIN_LINEAR);
	ALuint i;

	/* if unset, default or invalid, return */
	if(gain == NULL) {
		return;
	}

	if((*gain < 0.0) || (*gain > 1.0)) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
 			"gain out of range: %f", *gain);
		return;
	}

	if(*gain == 0.0) {
		/*
		 * special case: all 0.  So we set it to our minimum.
		 */
		*gain = _AL_CUTTOFF_ATTENUATION;
	}

	for(i = 0; i < nc; i++) {
		src->srcParams.gain[i] *= *gain;
	}

	return;
}

/* 
 *  alf_da implements distance attenuation.  The we measure the
 *  distance because this source and the difference speaker
 *  channels, and then set the source's gain and delay according
 *  to our calculation.  It is not necessary to actually change
 *  the pcm data here, as alSourceParamApply will make all the
 *  accumulated changes for us.
 *
 *  alf_da returns early if we discover that the source has
 *  either CONE_INNER_ANGLE or CONE_OUTER_ANGLE set (ie, is a
 *  directional source).  In those cases, alf_coning should do
 *  the distance attenuation.
 *
 *  FIXME:
 *    What an ugly function.  Remind me to clean this up.
 *
 *    Might be nice to seperate ambient, min/max attenuation, da, etc.
 */
void alf_da(ALuint cid, AL_source *src, UNUSED(AL_buffer *samp),
	     UNUSED(ALshort **buffers), ALuint nc, UNUSED(ALuint len)) {
	AL_context *cc;
	ALfloat ambientpos[3];    /* ambient position */
	ALfloat *sp = ambientpos; /* our default */
	ALfloat *sd;
	ALfloat sa;
	ALfloat *listener_position;
	ALfloat *temp;
	ALuint i;

	if(_alIsEnabled(AL_DISTANCE_ATTENUATION) == AL_FALSE) {
		return;
	}

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		/* ugh.  bad context id */
		return;
	}

	/*
	 * if coning is enabled for this source, then we want to
	 * let the coning filter take care of attenuating since
	 * it has more information then we do.
	 *
	 * We check the direction flag because coning may not
	 * be set (ie, they use defaults)
	 */
	temp = _alGetSourceParam(src, AL_DIRECTION);
	if(temp != NULL) {
		/*
		 * This sound has it's direction set, so leave it
		 * to the coning filter.
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"Directional sound, probably not right");
		return;
	}

	/* ambient near listener */
	listener_position = _alGetListenerParam(cid, AL_POSITION);
	if(listener_position == NULL) {
		/*
		 * The listener position is unset.  This shouldn't
		 * happen.
		 */
		return;
	}

	memcpy(ambientpos, listener_position, SIZEOFVECTOR);

	sp = _alGetSourceParam(src, AL_POSITION);
	if(sp == NULL) {
		/*
		 * no position set, so let it be ambient
		 * We fall through to get the MIN/MAX
		 */
		sp = ambientpos;

		debug(ALD_SOURCE, __FILE__, __LINE__,
			"Default AMBIENT, probably not right");
	}

	for(i = 0; i < nc; i++) {
		sd = _alcGetSpeakerPosition(cid, i);
		sa = compute_sa(sp, sd, cc->distance_scale);

		src->srcParams.gain[i] *= sa;
	}

	return;
}

/*
 *  FIXME: need to implement.
 */
void alf_doppler (ALuint cid, AL_source *src, UNUSED(AL_buffer *samp),
		   ALcomplex **buffers, ALuint nc, ALuint len) {
	ALfloat *vs; /* source velocity */
	ALfloat *vl; /* listener velocity */
	ALfloat ss;  /* speed of source wrt listener */
	ALcomplex *input;
	unsigned int i;
	ALfloat scalefactor;
	ALfloat zeros[] = { 0.0, 0.0, 0.0 };

	vs = _alGetSourceParam(src, AL_VELOCITY);
	vl = _alGetListenerParam(cid, AL_VELOCITY);

	return;

	if((vs == NULL) && (vl == NULL)) {
		/* no velocity set, no doppler effect */
		return;
	}

	if(vs == NULL) {
		vs = zeros;
	}

	if(vl == NULL) {
		vl = zeros;
	}

	ss = vector_magnitude(vs, vl);
	if(ss == 0) {
		/* no relative velocity, no doppler */
		return;
	}

	while(nc--) {
		input = buffers[nc];

		for(i = 0; i < len; i++) {
			scalefactor = ss * i/ (float) len;
			complex_scale(&input[i], scalefactor);
		}
	}

	_alStub("alf_doppler");
	return;
}


/*
 *  Initialize the tpitch lookup table.  See declaration of
 *  tpitch_lookup for more info.
 *
 */
static void init_tpitch_lookup(ALuint len) {
	ALfloat step;
	ALfloat scale;
	void *temp;
	ALuint i;
	ALint j;

	if(tpitch_lookup.len >= len) {
		/* We only go through the main loop if we
		 * haven't been initialized, or have been
		 * initialized with less memory than needed.
		 */
		return;
	}
	tpitch_lookup.len = len;

	/*
	 * initialize time domain pitch filter lookup table
	 */

	/* get big chunk of data here, parcel it out in loop.
	 * resize offsets to fit at least len elements.
	 *
	 * len is the number of samples that we process for
	 * each source in our trip through ApplyFilters.
	 */
	temp = realloc(tpitch_lookup.raw,
				     len *
				     tpitch_lookup.max *
				     sizeof **tpitch_lookup.offsets);
	if(temp == NULL) {
		perror("malloc");
		_alDCSetError(AL_OUT_OF_MEMORY);

		return;
	}

	tpitch_lookup.raw = temp;

	/*
	 * For pitch < 1.0, we lower the frequency such that a pitch of
	 * 0.5 corresponds to 1 octave drop.  Is this just a linear
	 * application of the step?
	 */
	for(i = 0; i < tpitch_lookup.max; i++) {
		temp = tpitch_lookup.raw + i * len;

		tpitch_lookup.offsets[i] = temp;

		/* set iterate step */
		step = 2.0 * i / tpitch_lookup.max;
		if(step == 0.0) {
			/* step = TPITCH_MIN_STEP; FIXME */
		}

		/* initialize offset table */
		scale = 0;

		for(j = 0; j < (ALint) len; j++, scale += step) {
			tpitch_lookup.offsets[i][j] = scale;
		}
	}

	return;
}

/*
 * computes distance attenuation with respect to a speaker position.
 *
 * This is some normalized value which gets expotenially closer to 1.0
 * as the source approaches the listener.  The minimum attenuation is
 * AL_CUTTOFF_ATTENUATION, which approached when the source approaches
 * AL_MAX_DISTANCE.
 *
 * sp == source position          [x/y/z]
 * speaker_pos = speaker position [x/y/z]
 *
 * assumes locked context
 */
static ALfloat compute_sa(ALfloat *sp, ALfloat *speaker_pos, ALfloat scale) {
	double distance;
	double retval;

	distance = vector_magnitude(sp, speaker_pos);
	retval = expscale(distance, scale * ALMAXDISTANCE);

	if(retval > 1.0) {
		/* funny error case: we flip */
		return _AL_CUTTOFF_ATTENUATION;
	} 

	if(retval < _AL_CUTTOFF_ATTENUATION) {
		return _AL_CUTTOFF_ATTENUATION;
	}
	
	return retval;
}

/*
 *  this filter acts out the doppler effects, in the time domain as
 *  opposed to frequency domain.
 *
 *  assumes locked context
 */
void alf_tdoppler(ALuint cid,
		  UNUSED(AL_source *src),
		  UNUSED(AL_buffer *samp),
		  UNUSED(ALshort **buffers),
		  UNUSED(ALuint nc),
		  UNUSED(ALuint len)) {
	AL_context *cc;
	ALfloat *sv; /* source velocity */
	ALfloat *sp; /* source position */
	ALfloat *lv; /* listener velocity */
	ALfloat *lp; /* listener position */
	ALfloat relative_velocity;  /* speed of source wrt listener */
	ALfloat zeros[] = { 0.0, 0.0, 0.0 };
	AL_sourcestate *srcstate;

	cc = _alcGetContext(cid);
	sp = _alGetSourceParam(src, AL_POSITION);
	sv = _alGetSourceParam(src, AL_VELOCITY);
	lv = _alGetListenerParam(cid, AL_VELOCITY);
	lp = _alGetListenerParam(cid, AL_POSITION);

	if(_alIsEnabled(AL_DOPPLER_SHIFT) == AL_FALSE) {
		/*
		 * If AL_DOPPLER_SHIFT is not enabled, we don't do
		 * velocity based doppler and we skip this step.
		 */
		return;
	}

	if((sp == NULL) || (lp == NULL)) {
		return;
	}

	if((sv == NULL) && (lv == NULL)) {
		/* no velocity set, no doppler effect */
		return;
	}

	if(sv == NULL) {
		/*
		 * if unset, set to the velocity to the
		 * zero vector.
		 */
		sv = zeros;
	}

	if(lv == NULL) {
		/*
		 * if unset, set to the velocity to the
		 * zero vector.
		 */
		lv = zeros;
	}

	relative_velocity = vector_magnitude(sv, lv);
	if(relative_velocity == 0.0) {
		/*
		 * no relative velocity, no doppler
		 *
		 * FIXME: use epsilon
		 */
		src->pitch.data = 1.0;
		
		return;
	}


	srcstate = _alSourceQueueGetCurrentState(src);
	if(srcstate == NULL) {
		fprintf(stderr, "weird\n");
	}

	src->pitch.data = compute_doppler_pitch(lp, lv, sp, sv,
				cc->doppler_factor, cc->propagation_speed);

	return;
}

/*
 * Implements min/max gain.
 */
void alf_minmax(UNUSED(ALuint cid),
		AL_source *src,
		UNUSED(AL_buffer *samp),
		UNUSED(ALshort **buffers),
		ALuint nc,
		UNUSED(ALuint len)) {
	ALfloat *amaxp = _alGetSourceParam(src, AL_MAX_GAIN);
	ALfloat *aminp = _alGetSourceParam(src, AL_MIN_GAIN);
	ALfloat attenuation_min = _AL_CUTTOFF_ATTENUATION;
	ALfloat attenuation_max = 1.0;
	ALuint i;

	/*
	 * if min or max are set, use them.  Otherwise, keep defaults
	 */
	if(aminp != NULL) {
		attenuation_min = _alDBToLinear(*aminp);
	}

	if(amaxp != NULL) {
		attenuation_max = _alDBToLinear(*amaxp);
	}

	for(i = 0; i < nc; i++) {
		if(src->srcParams.gain[i] > attenuation_max) {
			src->srcParams.gain[i] = attenuation_max;
		} else if(src->srcParams.gain[i] < attenuation_min) {
			src->srcParams.gain[i] = attenuation_min;
		}
	}

	return;
}

/*
 * Implements min/max gain.
 */
void alf_listenergain(ALuint cid,
		AL_source *src,
		UNUSED(AL_buffer *samp),
		UNUSED(ALshort **buffers),
		ALuint nc,
		UNUSED(ALuint len)) {
	ALuint i;
	ALfloat *lgain, gain;

	lgain = _alGetListenerParam(cid, AL_GAIN_LINEAR);
	if(lgain == NULL) {
		gain = 1.0;
	} else {
		gain = *lgain;
	}

	for(i = 0; i < nc; i++) {
		src->srcParams.gain[i] *= gain;
	}

	return;
}

/*
 * compute_doppler_pitch is meant to return a value spanning 0.5 to 1.5,
 * which is meant to simulate the frequency shift undergone by sources
 * in relative movement wrt the listener.
 *
 */
static ALfloat compute_doppler_pitch(ALfloat *object1, ALfloat *o1_vel,
				     ALfloat *object2, ALfloat *o2_vel,
				     ALfloat factor,  /* doppler_factor */
                                     ALfloat speed) { /* propagation_speed */

        ALfloat between[3];       /* Unit vector pointing in the direction
                                   * from one object to the other
                                   */
        ALfloat obj1V, obj2V;     /* Relative scalar velocity components */
        ALfloat ratio;            /* Ratio of relative velocities */
	ALfloat retval;           /* final doppler shift */

        /* 
         * Set up the "between" vector which points from one object to the
         * other
         */
        between[0] = object2[0] - object1[0];
        between[1] = object2[1] - object1[1];
        between[2] = object2[2] - object1[2];
        vector_normalize(between, between);

        /*
         * Compute the dot product of the velocity vector and the "between"
         * vector.
         *
         * The vector_dotp function is not set up for computing dot products
         * for actual vectors (it works for three points that define two 
         * vectors from a common origin), so I'll do it here.
         */
        obj1V  = o1_vel[0] * between[0];
        obj1V += o1_vel[1] * between[1];
        obj1V += o1_vel[2] * between[2];

        /* Now compute the dot product for the second object */
        obj2V  = o2_vel[0] * between[0];
        obj2V += o2_vel[1] * between[1];
        obj2V += o2_vel[2] * between[2];

        /* 
         * Now compute the obj1/obj2 velocity ratio, taking into account
         * the propagation speed.  This formula is straight from the spec.
         */
        obj1V = speed + obj1V;
        obj2V = speed - obj2V;
        ratio = obj1V/obj2V;

        /* Finally, scale by the doppler factor */
	retval = factor * ratio;

	return retval;
}

/*
 *  FIXME: 
 *
 *  I give up.  I can't get the pitch filter right and I don't know
 *  what I'm doing wrong.  I'm going to wait until I have a better
 *  info to do this, and stick with tpitch for now.
 */
void alf_pitch(UNUSED(ALuint cid), AL_source *src, UNUSED(AL_buffer *samp),
		   ALcomplex **buffers, ALuint nc, UNUSED(ALuint len)) {
	ALfloat *pitch;
	ALcomplex *input;
	ALuint i;

	pitch = _alGetSourceParam(src, AL_PITCH);
	if(pitch == NULL) {
		/*
		 * no pitch
		 */
		return;
	}

	while(nc--) {
		input = buffers[nc];

		for(i = 0; i < len; i++) {
			input[i].i *= *pitch;
		}
	}

	return;
}

/*
 *  this filter acts out AL_PITCH.
 *
 *  This filter is implements AL_PITCH, but - oh-ho! - in the 
 *  time domain.  All that good fft mojo going to waste.
 *
 *  This filter is going to have a very short time table.  I'm
 *  going to get rid of this as soon as possible.  After futzing
 *  with this filter, I'm pretty clear that the artifacts introduced
 *  by it aren't going to go away without some sort of comb, so 
 *  problem 1) of using an fft based implementation is gone.
 *
 *  I've got some ideas of how to solve problem 2) of a frequency
 *  based implementation --- do the fft at load time, and store it
 *  alongside of _orig_buffer.  Make sure frequency based filters
 *  get called first, and use the de-ffted data instead of hitting
 *  the original buffer.
 */
void alf_tpitch(UNUSED(ALuint cid),
		AL_source *src,
		AL_buffer *samp,
		ALshort **buffers,
		ALuint nc,
		ALuint len) {
	ALfloat *pitch   = _alGetSourceParam(src, AL_PITCH);
	ALshort *obufptr = NULL; /* pointer to unmolested buffer data */
	ALshort *bufptr  = NULL;  /* pointer to buffers[0..nc-1] */
	ALuint l_index;   /* index into lookup table */
	ALint ipos = 0;   /* used to store offsets temporarily */
	ALint clen = 0;   /* len, adjusted to avoid overrun due to resampling */
	ALuint i;
	int *offsets = NULL; /* pointer to set of offsets in lookup table */
	int bufchans = _al_ALCHANNELS(samp->format); /* we need bufchans to
						      * scale our increment
						      * of the soundpos,
						      * because of
						      * multichannel format
						      * buffers.
						      */

	/*
	 * if pitch is unset, default or invalid, return.
	 */
	if(pitch == NULL) {
		return;
	}

	/*
	 * if pitch is out of range, return.
	 */
	if((*pitch <= 0.0) || (*pitch > 2.0)) {
		debug(ALD_MAXIMUS, __FILE__, __LINE__,
 			"pitch out of range: %f", *pitch);
		return;
	}

	if(_alBufferIsCallback(samp) == AL_TRUE) {
		/* just debugging here, remove this block */

		debug(ALD_BUFFER, __FILE__, __LINE__,
		      "No tpitch support for callbacks yet");

		_alSetError(cid, AL_ILLEGAL_COMMAND);
		return;
	}

	/*
	 *  We need len in samples, not bytes.
	 */
	len /= sizeof(ALshort);

	/* convert pitch into index in our lookup table */
	l_index = (*pitch / 2.0) * tpitch_lookup.max;

	/*
	 * sanity check.
	 */
	if(l_index >= tpitch_lookup.max) {
		l_index = tpitch_lookup.max - 1;
	}

	/*
	 * offsets is out set of pitch-scaled offsets, 0...pitch * len.
	 * 
	 * Well, sort of.  0...pitch * len, but with len scaled such
	 * that we don't suffer a overrun if the buffer's original
	 * data is too short.
	 */
	offsets = tpitch_lookup.offsets[l_index];

	/*
	 *  adjust clen until we can safely avoid an overrun.
	 */
	clen = len;

	while(offsets[clen - 1] * sizeof(ALshort)
		+ src->srcParams.soundpos >= samp->size) {
		/* decrement clen until we won't suffer a buffer
		 * overrun.
		 */
		clen--;
	}

	/*
	 * Iterate over each buffers[0..nc-1]
	 */
	for(i = 0; i < nc; i++) {
		int j;

		/*
		 * Kind of breaking convention here and actually using
		 * the original buffer data instead of just resampling
		 * inside the passed buffer data.  This is because we
		 * won't have enough data to resample pitch > 1.0.
		 *
		 * We offset our original buffer pointer by the source's
		 * current position, but in samples, not in bytes
		 * (which is what src->srcParams.soundpos is in).
		 */
		obufptr  = samp->orig_buffers[i];
		obufptr += src->srcParams.soundpos / sizeof *obufptr;

		if(l_index == tpitch_lookup.middle) {
			/* when this predicate is true, the pitch is
			 * equal to 1, which means there is no change.
			 * Therefore, we short circuit.
			 *
			 * Because we're incrementing the soundpos here,
			 * we can't just return.
			 */

			continue;
		}

		/*
		 * set bufptr to the pcm channel that we
		 * are about to change in-place.
		 */
		bufptr = buffers[i];

		/*
		 * We mess with offsets in the loop below, so reset it
		 * after each iteration.
		 */
		offsets = tpitch_lookup.offsets[l_index];

		/*
		 * this is where the "resampling" takes place.  We do a
		 * very little bit on unrolling here, and it shouldn't
		 * be necessary, but seems to improve performance quite
		 * a bit.
		 */
		for(j = 0; j < clen - 1; j += 2) {
			bufptr[0] = obufptr[offsets[0]];
			bufptr[1] = obufptr[offsets[1]];

			bufptr  += 2;
			offsets += 2;
		}
	}

	/*
	 *  Set offsets to a known good state.
	 */
	offsets = tpitch_lookup.offsets[l_index];

	/*
	 *  AL_PITCH (well, alf_tpitch actually) require that the
	 *  main mixer func does not increment the source's soundpos,
	 *  so we must increment it here.  If we detect an overrun, we
	 *  must reset the src's soundpos to something reasonable.
	 */
	ipos = offsets[clen - 1] + offsets[1];
	
	src->srcParams.soundpos += bufchans * ipos * sizeof(ALshort);

	if(clen < (ALint) len) {
		/*
		 * we've reached the end of this sample.
		 *
		 * Since we're handling the soundpos incrementing for
		 * this source (usually done in _alMixSources), we have
		 * to handle all the special cases here instead of 
		 * delegating them.
		 *
		 * These include callback, looping, and streaming 
		 * sources.  For now, we just handle looping and
		 * normal sources, as callback sources will probably 
		 * require added some special case logic to _alSplitSources 
		 * to give up a little more breathing room.
		 */
		if(_alSourceIsLooping( src ) == AL_TRUE ) {
			/*
			 * looping source
			 *
			 * FIXME: artifact.  We should check to see if the
			 *        source is looping, and then set to some offset
			 *        depending on the modulo of the samp size and
			 *        buffer size.
			 */

			src->srcParams.soundpos = 0;
		} else {
			/*
			 * let _alMixSources know it's time for this source
			 * to die.
			 */
			src->srcParams.soundpos = samp->size;
		}
	}

	return;
}

