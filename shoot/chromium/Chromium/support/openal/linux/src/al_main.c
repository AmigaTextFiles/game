/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_main.c
 *
 * stuff that doesn't fit anywhere else.  Also, global initialization/
 * finitization.
 *
 */
#include "al_siteconfig.h"

#include <AL/al.h>
#include <AL/alkludge.h>
#include <AL/alc.h>

#include "al_debug.h"
#include "al_types.h"
#include "al_main.h"
#include "al_buffer.h"
#include "al_source.h"
#include "al_mixer.h"
#include "al_ext.h"
#include "al_config.h"
#include "al_complex.h"
#include "al_config.h"
#include "alc/alc_context.h"

#include "threads/threadlib.h"

#include <math.h>

#include <fcntl.h>
#include <signal.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include "audioconvert.h"

/* standard extensions
 *
 * To avoid having these built in (ie, using the plugin arch), don't
 * include these headers and move the files from EXT_OBJS to EXT_DLL_OBJS.
 */
#include "extensions/al_ext_loki.h"
#include "extensions/al_ext_mp3.h"
#include "extensions/al_ext_vorbis.h"
#include "extensions/al_ext_capture.h"

extern ThreadID mixthread; /* mixer thread's ID, if it needs one */

/* pcm buffers that filters act on */
_alDecodeScratch f_buffers;
_alDecodeScratch fft_buffers;

/* display banner */
static AL_extension exts[] = {
	{ (const ALubyte *) "alLokiTest",
	           (void *) alLokiTest },
#if 0
	{ (const ALubyte *) "alGenEnvironmentIASIG",
	           (void *) alGenEnvironmentIASIG    },
	{ (const ALubyte *) "alDeleteEnvironmentIASIG",
		   (void *) alDeleteEnvironmentIASIG },
	{ (const ALubyte *) "alIsEnvironmentIASIG",
		   ( void *) alIsEnvironmentIASIG     },
	{ (const ALubyte *) "alEnvironmentiIASIG",
		   (void *) alEnvironmentiIASIG      },
	{ (const ALubyte *) "alEnvironmentfIASIG",
		   (void *) alEnvironmentfIASIG      },
#endif
#ifdef BUILTIN_EXT_LOKI
	BUILTIN_EXT_LOKI,
#endif /* BUILDIN_EXT_LOKI */
#ifdef BUILTIN_EXT_MP3
	BUILTIN_EXT_MP3,
#endif /* BUILDIN_EXT_MP3 */
#ifdef BUILTIN_EXT_VORBIS
	BUILTIN_EXT_VORBIS,
#endif /* BUILDIN_EXT_VORBIS */
#ifdef BUILTIN_EXT_CAPTURE
	BUILTIN_EXT_CAPTURE,
#endif
	{ NULL, NULL} 
};

/* _alInit is called when the "first" context is created.  If all
 * contexts are deleted, and then one is created, it is called again.
 */
ALboolean _alInit(void) {
	ALboolean err;
	ALuint i;

	for(i = 0; i < _ALC_MAX_CHANNELS; i++) {
		f_buffers.data[i]   = NULL;
		fft_buffers.data[i] = NULL;
	}

	f_buffers.len = 0;
	fft_buffers.len = 0;

	/* buffer initializations */
	err = _alInitBuffers();
	if(err == AL_FALSE) {
		return AL_FALSE;
	}

	/* extension initilizations */
	err = _alInitExtensions();
	if(err == AL_FALSE) {
		_alDestroyBuffers();

		return AL_FALSE;
	}

	/* Set up mixer thread */
	err = _alInitMixer();
	if(err == AL_FALSE) {
		_alDestroyBuffers();
		_alDestroyExtensions();

		return AL_FALSE;
	}

#ifdef BUILTIN_EXT_LOKI
	/* FIXME: dynamic-ify this */
	/* register extension groups */
	_alRegisterExtensionGroup( (const ALubyte*) "AL_LOKI_attenuation_scale" );
	_alRegisterExtensionGroup( (const ALubyte*) "ALC_LOKI_audio_channel" );
	_alRegisterExtensionGroup( (const ALubyte*) "ALUT_LOKI_buffer_convert_data" );
	_alRegisterExtensionGroup( (const ALubyte*) "AL_LOKI_buffer_data_callback" );
	_alRegisterExtensionGroup( (const ALubyte*) "AL_LOKI_IMA_ADPCM_format" );
	_alRegisterExtensionGroup( (const ALubyte*) "AL_LOKI_play_position" );

#ifdef VORBIS_SUPPORT
	_alRegisterExtensionGroup( (const ALubyte*) "AL_EXT_vorbis" );
#endif /* CAPTURE_SUPPORT */

#ifdef CAPTURE_SUPPORT
	_alRegisterExtensionGroup( (const ALubyte*) "AL_EXT_capture" );
#endif /* CAPTURE_SUPPORT */

#endif /* BUILTIN_EXT_LOKI */

	for(i = 0; exts[i].addr != NULL; i++) {
		_alRegisterExtension(exts[i].name, exts[i].addr);
	}

	/* do builtin extensions initialization */
	BUILTIN_EXT_LOKI_INIT;
	BUILTIN_EXT_CAPTURE_INIT;
	BUILTIN_EXT_MP3_INIT;
	BUILTIN_EXT_VORBIS_INIT;

	return AL_TRUE;
}

void _alExit(void) {
	int i;

#ifndef NO_THREADS
	/* we could be sync, so we check mixthread for a valid ID */
	if(mixthread != NULL) {
		time_for_mixer_to_die = AL_TRUE;
		
		tlWaitThread(mixthread);

		while(time_for_mixer_to_die == AL_TRUE) {
			_alMicroSleep(100000);
		}
	}
#endif /* NO_THREADS */

	for(i = 0; i < _ALC_MAX_CHANNELS; i++) {
		free(f_buffers.data[i]);
		f_buffers.data[i] = NULL;

		free(fft_buffers.data[i]);
		fft_buffers.data[i] = NULL;

	}

	f_buffers.len = 0;
	fft_buffers.len = 0;

	_alDestroyConfig();

	_alDestroyExtensions();
	_alDestroyExtensionGroups( );
	_alDestroyMixer();
	_alDestroyFilters();

	_alcDestroyAll();

	_alDestroyBuffers(); /* buffers after mixer and alc destroy */

	/* do builtin extensions destruction */
	BUILTIN_EXT_LOKI_FINI;
	BUILTIN_EXT_CAPTURE_FINI;
	BUILTIN_EXT_MP3_FINI;
	BUILTIN_EXT_VORBIS_FINI;

	return;
}

int _alStub(UNUSED(const char *str)) {
#ifdef DEBUG_STUB
	return fprintf(stderr, "%s stub function\n", str);
#endif
	
	return 0;
}

#ifdef DEBUG_LOCK
int _alLockPrintf(const char *msg, const char *fn, int ln) {
	char threadstr[2048];
	char blanks[] = "                             ";
	int maxlen = 18 - (strlen(fn) + log10(ln));

	blanks[maxlen] = '\0';

	sprintf(threadstr, "%s[%u]", blanks, tlSelfThread());

	return debug(ALD_LOCK, fn, ln, "%s %s", threadstr, msg);
}
#endif

ALenum  _al_AC2ALFMT(ALuint sdlformat, ALuint channels) {
	switch(sdlformat) {
		case AUDIO_U8:
		  if(channels == 2) {
			  return AL_FORMAT_STEREO8;
		  }
		  if(channels == 1) {
			  return AL_FORMAT_MONO8;
		  }
		  break;
		case AUDIO_S16LSB:
		case AUDIO_S16MSB:
		  if(channels == 2) {
			  return AL_FORMAT_STEREO16;
		  }
		  if(channels == 1)
			  return AL_FORMAT_MONO16;
		  break;
	}

#ifdef DEBUG_CONVERT
	fprintf(stderr, "AC2ALFMT: wtf? format = 0x%x\n", sdlformat);
#endif

	return -1;
}

ALushort _al_AL2ACFMT(ALenum alformat) {
	switch(alformat) {
		case AL_FORMAT_STEREO8:
		case AL_FORMAT_MONO8:
		  return AUDIO_U8;
		case AL_FORMAT_STEREO16:
		case AL_FORMAT_MONO16:
		  return AUDIO_S16;
		default:
		  break;
	}

#ifdef DEBUG_CONVERT
	fprintf(stderr, "AL2ACFMT: wtf? format = 0x%x\n", alformat);
#endif

	return -1;
}

#if 0
/* what's the bit depth of the passed format? */
int _al_formatbits(ALenum format) {
	switch(format) {
		case AL_FORMAT_MONO8:
		case AL_FORMAT_STEREO8:
		  return 8;
		case AL_FORMAT_MONO16:
		case AL_FORMAT_STEREO16:
		  return 16;
		default:
#ifdef DEBUG_CONVERT
		  fprintf(stderr,
		  "_al_formatbits unknown format 0x%x\n", format);
#endif /* DEBUG_CONVERT */
		  break;
	}

	return -1;
}
#endif

ALenum _al_formatscale(ALenum format, ALuint new_channel_num) {
	int fmt_bits = _al_formatbits(format);

	switch(new_channel_num) {
		case 1:
		  switch(fmt_bits) {
			  case 8: return AL_FORMAT_MONO8; break;
			  case 16: return AL_FORMAT_MONO16; break;
			  default: return -1;
		  }
		  break;
		case 2:
		  switch(fmt_bits) {
			  case 8: return AL_FORMAT_STEREO8; break;
			  case 16: return AL_FORMAT_STEREO16; break;
			  default: return -1;
		  }
		  break;
		default:
#ifdef DEBUG_CONVERT
		  fprintf(stderr,
		  	"No support for %d channel AL format, sorry\n",
			new_channel_num);
#endif /* DEBUG_CONVERT */
		  break;
	}

	return -1;
}

/*
 * append nc buffers of len src[0..nc-1] to dsts[0..nc-1] at offset offset.
 */
void _alBuffersAppend(void **dsts, void **srcs, int len, int offset, int nc) {
	char *dstp;
	char *srcp;
	int i;
	int k;

	for(i = 0; i < nc; i++) {
		dstp = dsts[i];
		srcp = srcs[i];

		dstp += offset;

		for(k = 0; k < len; k++) {
			dstp[k] = srcp[k];
		}
	}

	return;
}

void _alBuffersCopy(void **dsts, void **srcs, int len, int nc) {
	ALshort *dstp;
	ALshort *srcp;
	int i;

	len /= sizeof(ALshort);

	for(i = 0; i < nc; i++) {
		dstp = dsts[i];
		srcp = srcs[i];

		memcpy(dstp, srcp, len);
	}

	return;
}

/* FIXME: check my math */
ALfloat vector_magnitude(const ALfloat *v1, const ALfloat *v2) {
	ALfloat lsav[3];
	ALfloat retval;
		
	vector_distance(lsav, v1, v2);

	retval = sqrt(lsav[0] * lsav[0] +
		      lsav[1] * lsav[1] +
		      lsav[2] * lsav[2]);

	return retval;

}

void vector_normalize(ALfloat *d, ALfloat *s) {
	ALfloat mag;
	static const ALfloat zeros[3] = { 0.0, 0.0, 0.0 };

	mag = vector_magnitude(zeros, s);

	if(mag == 0) {
		d[0] = 0.0; d[1] = 0.0; d[2] = 0.0;

		return;
	}

	d[0] = s[0] / mag;
	d[1] = s[1] / mag;
	d[2] = s[2] / mag;

	return;
}

/* FIXME: check my math */
void vector_distance(ALfloat *retref, const ALfloat *v1, const ALfloat *v2) {
	float fi1, fi2;
	int i;

	for(i = 0; i < 3; i++) {
		fi1 = v1[i];
		fi2 = v2[i];

		if(fi1 < fi2) {
			retref[i] = fi2 - fi1;
		} else {
			retref[i] = fi1 - fi2;
		}
	}

	return;
}

/* FIXME: check my math
 * FIXME: needs to check args
 *
 * angle  - in radians
 * point  - x/y/z
 * axis   - x/y/z (unit vector representing axis)
 */
void rotate_point_about_axis(ALfloat angle, ALfloat *point, ALfloat *axis) {
	ALmatrix *m;
	ALmatrix *pm;
	ALmatrix *rm;

	float s;
	float c;
	float t;

	float x = axis[0];
	float y = axis[1];
	float z = axis[2];
	int i;

	if(angle == 0.0) {
		/* FIXME: use epsilon? */
		return;
	}

	s = sin( angle );
	c = cos( angle );
	t = 1.0 - c;

	m  = _alMatrixAlloc(3, 3);
	pm = _alMatrixAlloc(1, 3);
	rm = _alMatrixAlloc(1, 3);

#if 1
	m->data[0][0] = t * x * x + c;
	m->data[0][1] = t * x * y - s * z;
	m->data[0][2] = t * x * z + s * y;

	m->data[1][0] = t * x * y + s * z;
	m->data[1][1] = t * y * y + c;
	m->data[1][2] = t * y * z - s * x;

	m->data[2][0] = t * x * z - s * y;
	m->data[2][1] = t * y * z + s * x;
	m->data[2][2] = t * z * z + c;
#else
	m->data[0][0] = t * x * x + c;
	m->data[1][0] = t * x * y - s * z;
	m->data[2][0] = t * x * z + s * y;

	m->data[0][1] = t * x * y + s * z;
	m->data[1][1] = t * y * y + c;
	m->data[2][1] = t * y * z - s * x;

	m->data[0][2] = t * x * z - s * y;
	m->data[1][2] = t * y * z + s * x;
	m->data[2][2] = t * z * z + c;
#endif

	for(i = 0; i < 3; i++) {
		pm->data[0][i] = point[i];
		rm->data[0][i] = 0;
	}

	/*
	 * rm = pm * m
	 */
	_alMatrixMul(rm, pm, m);

	for(i = 0; i < 3; i++) {
		point[i] = rm->data[0][i];
	}
	
	_alMatrixFree(m);
	_alMatrixFree(pm);
	_alMatrixFree(rm);

	return;
}

/*
 *  FIXME: please check my math
 */
void _alMatrixMul(ALmatrix *result, ALmatrix *m1, ALmatrix *m2) {
	int m2cols = m2->cols;
	int m1rows = m1->rows;
	int m1cols = m1->cols;
	int i;
	int j;
	int k;

	ALfloat sum;

	for(i = 0; i < m2cols; i++) {
		for(j = 0; j < m1rows; j++) {
			sum = 0.0;

			for(k = 0; k < m1cols; k++) {
				sum += m1->data[j][k] * m2->data[k][i];
			}

			result->data[j][i] = sum;
		}
	}

	return;
}

ALmatrix *_alMatrixAlloc(int rows, int cols) {
	ALmatrix *retval;
	int i;

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		return NULL;
	}

	retval->data = malloc(rows * sizeof *retval->data);
	if(retval->data == NULL) {
		return NULL;
	}

	for(i = 0; i < rows; i++) {
		/* FIXME: clean return on error */
		retval->data[i] = malloc(cols * sizeof *retval->data[i]);
	}

	retval->rows = rows;
	retval->cols = cols;

	return retval;
}

void _alMatrixFree(ALmatrix *m) {
	int i;

	if(m == NULL) {
		return;
	}

	for(i = 0; i < m->rows; i++) {
		if(m->data[i] != NULL) {
			free(m->data[i]);
		}
	}

	free(m->data);
	free(m);

	return;
}


int _alSlurp(const char *fname, void **buffer) {
	struct stat buf;	
	FILE *fh;
	ALint len;

	if((fname == NULL) || (buffer == NULL)) {
		return -1;
	}

	if(stat(fname, &buf) == -1) {
		/* couldn't stat file */
		return -1;
	}

	len = (ALint) buf.st_size;
	if(len <= 0) {
		return -1;
	}

	fh = fopen(fname, "rb");
	if(fh == NULL) {
		/* couldn't open file */
		return -1;
	}

	*buffer = malloc(len);
	if(*buffer == NULL) {
		return -1;
	}

	if(fread(*buffer, len, 1, fh) < 1) {
		free(*buffer);

		return -1;
	}

	return len;
}

/*
 *  double expscale(double value, double max)
 *
 *  expscale normalizes the value value to the
 *  domain [0.0-1.0].  It shouldn't scale linearly
 *  but logarithmically, with a large value 
 *  corresponding with a small return value.
 *
 */
double expscale(double value, double max) {
	/*
 	 * table of normalized values, with [0] corresponding to the greatest 
 	 * value and [128] the lowest.
 	 *
 	 * FIXME: needs tweaking.
 	 */
	static const float exptab[] = {
		0.99, 0.97, 0.95, 0.90, 0.85, 0.80, 0.75, 0.70, 0.65, 0.60,
		0.50, 0.43, 0.41, 0.40, 0.39, 0.38, 0.37, 0.36, 0.35, 0.34,
		0.33, 0.32, 0.31, 0.30, 0.30, 0.29, 0.28, 0.27, 0.27, 0.26,
		0.25, 0.25, 0.24, 0.23, 0.23, 0.22, 0.22, 0.21, 0.21, 0.20,
		0.20, 0.19, 0.19, 0.19, 0.18, 0.18, 0.17, 0.17, 0.17, 0.16,
		0.16, 0.16, 0.15, 0.15, 0.15, 0.14, 0.14, 0.14, 0.14, 0.13,
		0.13, 0.13, 0.12, 0.12, 0.12, 0.12, 0.12, 0.11, 0.11, 0.11,
		0.11, 0.10, 0.10, 0.10, 0.10, 0.09, 0.09, 0.09, 0.09, 0.09,
		0.08, 0.08, 0.08, 0.08, 0.08, 0.07, 0.07, 0.07, 0.07, 0.06,
		0.06, 0.06, 0.06, 0.06, 0.05, 0.05, 0.05, 0.05, 0.05, 0.04,
		0.04, 0.04, 0.04, 0.04, 0.03, 0.03, 0.03, 0.03, 0.03, 0.02,
		0.02, 0.02, 0.02, 0.02, 0.02, 0.01, 0.01, 0.01, 0.01, 0.01,
		0.01, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };
	int eindex;
	float retval;

	value /= max;

	if(value == 0.0) {
		return 1.0;
	}

	if((value > 1.0) || ( value < 0.0)) {
		return 0.0;
	}

	eindex  = value * 128;
	retval = exptab[eindex];

	return retval;
}

/*
 *  Ratio of to/from
 */
ALfloat _al_PCMRatio(ALuint ffreq, ALuint tfreq, ALenum ffmt, ALenum tfmt) {
	ALfloat retval;

	switch(tfmt) {
		case AL_FORMAT_MONO8:
			tfreq *= 8;
			break;
		case AL_FORMAT_MONO16:
		case AL_FORMAT_STEREO8:
			tfreq *= 16;
			break;
		case AL_FORMAT_STEREO16:
			tfreq *= 32;
			break;
		default:
			break;
	}

	switch(ffmt) {
		case AL_FORMAT_MONO8:
			ffreq *= 8;
			break;
		case AL_FORMAT_MONO16:
		case AL_FORMAT_STEREO8:
			ffreq *= 16;
			break;
		case AL_FORMAT_STEREO16:
			ffreq *= 32;
			break;
		default:
			break;
	}

	retval = tfreq / ffreq;
	if(retval != 0.0) {
		return retval;
	}

	return (float) tfreq / ffreq;
}

ALfloat _al_WidthRatio(ALenum ffmt, ALenum tfmt) {
	ALfloat retval = 1.0;
	ALfloat width;

	width  = _al_formatbits(tfmt);
	width /=  _al_formatbits(ffmt);

	return retval * width;
}

/* translate s by delta, result in d */
void vector_translate(ALfloat *d, ALfloat *s, ALfloat *delta) {
	d[0] = s[0] + delta[0];
	d[1] = s[1] + delta[1];
	d[2] = s[2] + delta[2];

	return;
}

/* place inverse of s in d */
void vector_inverse(ALfloat *d, ALfloat *s) {
	d[0] = -s[0];
	d[1] = -s[1];
	d[2] = -s[2];

	return;
}

ALenum _al_AL2FMT(ALuint channels, ALuint bits) {
	switch(channels) {
		case 1:
			if(bits == 8) return AL_FORMAT_MONO8;
			if(bits == 16) return AL_FORMAT_MONO16;
			break;
		case 2:
			if(bits == 16) return AL_FORMAT_STEREO8;
			if(bits == 16) return AL_FORMAT_STEREO16;
			break;
	}

	return -1;
}

unsigned int nextPowerOfTwo(unsigned int n) {
	unsigned int retval = 1;

	while(retval < n) {
		retval <<= 1;
	}

	return retval;

}

#ifdef _WIN32
/* sleep for n microseconds
 *
 * Well, not really.  For Windows, we divide
 * by 10 and sleep for milliseconds
 */
void _alMicroSleep(unsigned int n) {
	Sleep(n / 1000);

	return;
}

#else

/* sleep for n microseconds */
void _alMicroSleep(unsigned int n) {
	struct timeval tv;

	tv.tv_sec = 0;
	tv.tv_usec = n;

	select(0, NULL, NULL, NULL, &tv);

	return;
}

#endif /* _WIN32 */

/*
 *    0       1
 *    2       3
 *
 *    FIXME: we ignore y
 */
ALint vector_quadrant(ALfloat *origin, ALfloat *v1) {
	ALfloat iorigin[3]; /* origin inverse */
	ALfloat v1trans[3]; /* translated v1 */

	vector_inverse(iorigin, origin);
	vector_translate(v1trans, v1, iorigin);

	if(v1[0] <= 0.0) {
		/* x on left */

		if(v1[2] < 0.0) {
			/* z below */
			return 2;
		}

		/* z above */
		return 0;
	}

	/* x right */

	if(v1[2] < 0.0) {
		/* z below */

		return 4;
	}

	/* z above */

	return 1;
}

/*
 * FIXME: please check my math
 */
ALfloat vector_angle_between(ALfloat *origin, ALfloat *v1, ALfloat *v2) {
	ALfloat m1;     /* |v2| */
	ALfloat m2;     /* |v1| */
	ALfloat mt;     /* |v1| * |v2| */
	ALfloat dp;    /*  dot product */
	ALfloat mag;
	ALint q1;       /* quadrant of v1 */
	ALint q2;       /* quadrant of v2 */


	m1  = vector_magnitude(origin, v1);
	m2  = vector_magnitude(origin, v2);
	dp  = vector_dotp(origin, v1, v2);

	mt = m1 * m2;
	if(mt == 0) {
		return 0.0;
	}

	mag = acos(dp / mt);

#if defined(DEBUG_MATH) && 0
	fprintf(stderr,
		"((origin %f %f %f)\n"
		" (1      %f %f %f) (mag %f)\n"
		" (2      %f %f %f) (mag %f)\n"
		" (dp %f))\n"
		" (angle %f))\n",
		origin[0],origin[1],origin[2],
		v1[0],v1[1],v1[2], m1,
		v2[0],v2[1],v2[2], m2,
		dp,
		mag);
#endif /* DEBUG_MATH */

	/* okay, we have the magnitude of the angle but not the sign.
	 * To know this, we will need to know that quadrant the v1 and
	 * v2 fall in.
	 *
	 * If they are in the same quadrant, same sign.
	 *
	 * If one is in quad0 and one is in quad3, same sign.
	 *
	 * Otherwise, negate mag.
	 */
	q1 = vector_quadrant(origin, v1);
	q2 = vector_quadrant(origin, v2);

	if(q1 != q2) {
		/* they are in different quadrant */

	    if(!(((q1 == 0) && (q2 == 2)) ||
 		 ((q1 == 2) && (q2 == 0)))) {

		if(!(((q1 == 1) && (q2 == 3)) ||
		     ((q1 == 3) && (q2 == 1)))) {

			mag *= -1;
		}
	    }
	}

	return mag;
}

/*
 * dot product between v1 and v2, with origin at origin
 */
ALfloat vector_dotp(ALfloat *origin, ALfloat *v1, ALfloat *v2) {
	ALfloat o_inverse[3];
	ALfloat v1_trans[3];
	ALfloat v2_trans[3];
	ALfloat retval = 0.0;

	vector_inverse(o_inverse, origin);

	vector_translate(v1_trans, v1, o_inverse);
	vector_translate(v2_trans, v2, o_inverse);

	retval += v1_trans[0] * v2_trans[0];
	retval += v1_trans[1] * v2_trans[1];
	retval += v1_trans[2] * v2_trans[2];

	return retval;
}

/*
 * Compute the angle between the vectors describe as having their
 * origin at origin1 and origin2 and their points at point1 and point2,
 * respectively.
 *
 * Define v1 as the vector with origin at origin1 and point at point1
 * Define v2 as the vector with origin at origin2 and point at point2
 * Define d as the line between origin1 and origin2 
 *
 * 1.  compute beta, angle between d and v1
 * 2.  compute alpha, angle between d and v2
 * 3.  return theta, which is alpha + beta
 *
 *
 * RETURNS:
 * 	<  M_PI_2 converging angle at intersection
 *	>= M_PI_2 non converging vectors.
 */
ALfloat vector_intersect_angle(ALfloat *origin1, ALfloat *point1,
			       ALfloat *origin2, ALfloat *point2) {
	ALfloat alpha;
	ALfloat beta;
	ALfloat theta;

	beta  = vector_angle_between(origin1, point1, origin2);
	alpha = vector_angle_between(origin2, origin1, point2);

	theta = beta + alpha;

#ifdef DEBUG_MATH
	fprintf(stderr, "(alpha %f beta %f)\n", alpha, beta);
#endif /* DEBUG_MATH */

	return M_PI - theta;
}

ALfloat _alDegreeToRadian(ALfloat degree) {
	return degree * (M_PI / 180.0);
}

ALboolean _alCheckRangef(ALfloat val, ALfloat min, ALfloat max) {
	ALboolean retval = AL_TRUE;

	if(val < min) {
		retval = AL_FALSE;
	}
	if(val > max) {
		retval = AL_FALSE;
	}

	return retval;
}

ALboolean _alCheckRangeb(ALboolean b) {
	switch(b) {
		case AL_TRUE:
		case AL_FALSE:
		  return AL_TRUE;
		default:
		  break;
	}

	return AL_FALSE;
}

ALboolean _alIsZeroVector(ALfloat *fv) {
	if(fv[0] == 0.0) {
		if(fv[1] == 0.0) {
			if(fv[2] == 0.0) {
				return AL_TRUE;
			}
		}
	}

	return AL_FALSE;
}

ALfloat _alLinearToDB(ALfloat linear) {
	static const float logtab[] = {
		0.00, 0.001, 0.002, 0.003, 0.004, 0.005, 0.01, 0.011,
		0.012, 0.013, 0.014, 0.015, 0.016, 0.02, 0.021, 0.022,
		0.023, 0.024, 0.025, 0.03, 0.031, 0.032, 0.033, 0.034,
		0.04, 0.041, 0.042, 0.043, 0.044, 0.05, 0.051, 0.052,
		0.053, 0.054, 0.06, 0.061, 0.062, 0.063, 0.064, 0.07,
		0.071, 0.072, 0.073, 0.08, 0.081, 0.082, 0.083, 0.084,
		0.09, 0.091, 0.092, 0.093, 0.094, 0.10, 0.101, 0.102,
		0.103, 0.11, 0.111, 0.112, 0.113, 0.12, 0.121, 0.122,
		0.123, 0.124, 0.13, 0.131, 0.132, 0.14, 0.141, 0.142,
		0.143, 0.15, 0.151, 0.152, 0.16, 0.161, 0.162, 0.17,
		0.171, 0.172, 0.18, 0.181, 0.19, 0.191, 0.192, 0.20,
		0.201, 0.21, 0.211, 0.22, 0.221, 0.23, 0.231, 0.24, 0.25,
		0.251, 0.26, 0.27, 0.271, 0.28, 0.29, 0.30, 0.301, 0.31,
		0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.40,
		0.41, 0.43, 0.50, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85,
		0.90, 0.95, 0.97, 0.99 };
	const int logmax = sizeof logtab / sizeof *logtab;

	if(linear <= 0.0) {
		return 0.0;
	}

	if(linear >= 1.0) {
		return 1.0;
	}

	return logtab[(int) (logmax * linear)];
}

/*
 * FIXME: So kludgey.
 */
ALfloat _alDBToLinear(ALfloat dBs) {
	static const float logtab[] = {
		0.00, 0.001, 0.002, 0.003, 0.004, 0.005, 0.01, 0.011,
		0.012, 0.013, 0.014, 0.015, 0.016, 0.02, 0.021, 0.022,
		0.023, 0.024, 0.025, 0.03, 0.031, 0.032, 0.033, 0.034,
		0.04, 0.041, 0.042, 0.043, 0.044, 0.05, 0.051, 0.052,
		0.053, 0.054, 0.06, 0.061, 0.062, 0.063, 0.064, 0.07,
		0.071, 0.072, 0.073, 0.08, 0.081, 0.082, 0.083, 0.084,
		0.09, 0.091, 0.092, 0.093, 0.094, 0.10, 0.101, 0.102,
		0.103, 0.11, 0.111, 0.112, 0.113, 0.12, 0.121, 0.122,
		0.123, 0.124, 0.13, 0.131, 0.132, 0.14, 0.141, 0.142,
		0.143, 0.15, 0.151, 0.152, 0.16, 0.161, 0.162, 0.17,
		0.171, 0.172, 0.18, 0.181, 0.19, 0.191, 0.192, 0.20,
		0.201, 0.21, 0.211, 0.22, 0.221, 0.23, 0.231, 0.24, 0.25,
		0.251, 0.26, 0.27, 0.271, 0.28, 0.29, 0.30, 0.301, 0.31,
		0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.40,
		0.41, 0.43, 0.50, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85,
		0.90, 0.95, 0.97, 0.99 };
	const int logmax = sizeof logtab / sizeof *logtab;
	int max = logmax;
	int min = 0;
	int mid;
	int last = -1;

	if(dBs <= 0.0) {
		return 0.0;
	}

	if(dBs >= 1.0) {
		return 1.0;
	}


	mid = (max - min) / 2;
	do {
		last = mid;

		if(logtab[mid] == dBs) {
			break;
		}

		if(logtab[mid] < dBs) {
			/* too low */
			min = mid;
		} else { 
			/* too high */
			max = mid;
		}

		mid = min + ((max - min) / 2);
	} while(last != mid);

	return ((float) mid / logmax);
}

ALboolean _al_RAWFORMAT(ALenum format) {
	switch(format) {
		case AL_FORMAT_MONO16:
		case AL_FORMAT_MONO8:
		case AL_FORMAT_STEREO16:
		case AL_FORMAT_STEREO8:
			return AL_TRUE;
		default:
			break;
	}

	return AL_FALSE;
}

ALbyte _al_formatbits(ALenum format) {
	switch(format) {
		case AL_FORMAT_MONO16:
		case AL_FORMAT_STEREO16:
		case AL_FORMAT_IMA_ADPCM_MONO16_EXT:
		case AL_FORMAT_IMA_ADPCM_STEREO16_EXT:
			return 16;
			break;
		case AL_FORMAT_MONO8:
		case AL_FORMAT_STEREO8:
			return 8;
			break;
	}

	ASSERT(0);

	return -1;
}

void vector_crossp(ALfloat *d, UNUSED(ALfloat *origin), ALfloat *v1, ALfloat *v2) {
	/* FIXME: take into account shared origin */

	d[0] = (v1[1] * v2[2] - v1[2] * v2[1]);
	d[1] = (v1[2] * v2[0] - v1[0] * v2[2]);
	d[2] = (v1[0] * v2[1] - v1[1] * v2[0]);

	return;
}
