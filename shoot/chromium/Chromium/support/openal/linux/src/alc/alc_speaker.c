/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * alc_speaker.c
 *
 * functions related to the position of the speakers in the alc world.
 *
 */
#include <AL/alctypes.h>

#include <stdio.h>

#include "AL/altypes.h"

#include "al_main.h"
#include "al_types.h"
#include "al_debug.h"
#include "al_state.h"
#include "al_siteconfig.h"

#include "alc_context.h"
#include "alc_error.h"
#include "alc_speaker.h"


/*
 * assumes context cid is locked
 *
 * FIXME: please check my math
 */
void _alcSpeakerMove(ALuint cid) {
	AL_context *cc;
	ALfloat zeros[] = { 0.0, 0.0,  0.0 };
	ALfloat oldat[] = { 0.0, 0.0, -1.0 };
	ALfloat oldup[] = { 0.0, 1.0, 0.0 };
	ALfloat newat[3];
	ALfloat newup[3];
	ALfloat angle;   /* angle to rotate at vector by */
	ALfloat upangle; /* angle to rotate up vector by */
	ALfloat *pos;    /* listener position */
	ALfloat ipos[3]; /* inverse listener position */
	unsigned int i;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "_alcSpeakerMove: invalid context id %d", cid);

		_alcSetError(ALC_INVALID_CONTEXT);
		return;
	}

	pos = cc->listener.Position;

	vector_normalize(newat, cc->listener.Orientation );
	vector_normalize(newup, &cc->listener.Orientation[3] );

	angle   = vector_angle_between( zeros, newat, oldat );
	upangle = vector_angle_between( zeros, newup, oldup );

	debug(ALD_MATH, __FILE__, __LINE__, "( oldat %f %f %f) ( newat %f %f %f )",
		oldat[0], oldat[1], oldat[2], newat[0], newat[1], newat[2] );
	debug(ALD_MATH, __FILE__, __LINE__, "( oldup %f %f %f) ( newup %f %f %f )",
		oldup[0], oldup[1], oldup[2], newup[0], newup[1], newup[2] );

	debug(ALD_MATH, __FILE__, __LINE__, "( angle %f )", angle );
	debug(ALD_MATH, __FILE__, __LINE__, "( upangle %f) ", upangle );

	/* reset speaker position */
	_alcSpeakerInit(cid);

	vector_inverse( ipos, cc->listener.Position );

	/* rotate about at and up vectors */
	for(i = 0; i < _alcDCGetNumSpeakers(); i++) {
		vector_translate(cc->_speaker_pos[i].pos,
				 cc->_speaker_pos[i].pos, ipos);

		rotate_point_about_axis( angle, cc->_speaker_pos[i].pos, oldup );
		rotate_point_about_axis( upangle, cc->_speaker_pos[i].pos, oldat );

		vector_translate(cc->_speaker_pos[i].pos,
				 cc->_speaker_pos[i].pos, pos);
	}

	debug(ALD_MATH, __FILE__, __LINE__,
		"SpAdj: l/r [%f|%f|%f] [%f|%f|%f]",
		cc->_speaker_pos[0].pos[0],
		cc->_speaker_pos[0].pos[1],
		cc->_speaker_pos[0].pos[2],

		cc->_speaker_pos[1].pos[0],
		cc->_speaker_pos[1].pos[1],
		cc->_speaker_pos[1].pos[2]);

	return;
}

/*
 * assumes locked context
 *
 * Initialize position wrt listener, w/o rt orientation.
 */
void _alcSpeakerInit(ALuint cid) {
	AL_context  *cc;
	AL_listener *lis;
	ALfloat *lpos;
	ALfloat sdis; /* scaled distance */

	cc  = _alcGetContext(cid);
	lis = _alcGetListener(cid);
	if(cc == NULL) {
		/* invalid cid */
		return;
	}

	if(lis == NULL) {
		/* weird */
		return;
	}

	lpos = lis->Position;

	sdis = _ALC_SPEAKER_DISTANCE * _alGetFloat(AL_DISTANCE_SCALE);

	debug(ALD_CONTEXT, __FILE__, __LINE__,
		"_alcSpeakerInit: (sfactor %f sdis %f)",
		sdis,
		_alGetFloat(AL_DISTANCE_SCALE)
		);

	/* left */
	cc->_speaker_pos[ALS_LEFT].pos[0]   = lpos[0] - sdis;
	cc->_speaker_pos[ALS_LEFT].pos[1]   = lpos[1];
	cc->_speaker_pos[ALS_LEFT].pos[2]   = lpos[2];

	/* right */
	cc->_speaker_pos[ALS_RIGHT].pos[0]  =  lpos[0] + sdis;
	cc->_speaker_pos[ALS_RIGHT].pos[1]  =  lpos[1];
	cc->_speaker_pos[ALS_RIGHT].pos[2]  =  lpos[2];

	/* left rear */
	cc->_speaker_pos[ALS_LEFTS].pos[0]  =  lpos[0] - sdis;
	cc->_speaker_pos[ALS_LEFTS].pos[1]  =  lpos[1] + sdis;
	cc->_speaker_pos[ALS_LEFTS].pos[2]  =  lpos[2] - sdis;

	/* right rear */
	cc->_speaker_pos[ALS_RIGHTS].pos[0] =  lpos[0] + sdis;
	cc->_speaker_pos[ALS_RIGHTS].pos[1] =  lpos[1] + sdis;
	cc->_speaker_pos[ALS_RIGHTS].pos[2] =  lpos[2] + sdis;

	return;
}

/* assumes locked context */
ALuint _alcGetNumSpeakers(ALuint cid) {
	AL_context *cc = _alcGetContext(cid);

	if(cc == NULL) {
		return 0;
	}

	return _al_ALCHANNELS(cc->write_format);
}

/* assumes locked context */
ALfloat *_alcGetSpeakerPosition(ALuint cid, ALuint speaker_num) {
	AL_context *cc = _alcGetContext(cid);
	ALuint nc;

	if(cc == NULL) {
		return NULL;
	}

	nc = _al_ALCHANNELS(cc->write_format);

	if(speaker_num >= nc) {
		return NULL;
	}

	return cc->_speaker_pos[speaker_num].pos;
}
