#ifndef _AL_MAIN_H_
#define _AL_MAIN_H_

#include "al_siteconfig.h"
#include "alc/alc_context.h"

#include <math.h>

#include <AL/altypes.h>

#ifndef M_PI
#define M_PI		3.14159265358979323846	/* pi */
#endif

#ifndef M_PI_2
#define M_PI_2 (M_PI / 2)
#endif

#ifndef M_PI_4
#define M_PI_4 (M_PI / 4)
#endif 

/* If compiling with gcc, then we can use attributes. */
#ifdef __GNUC__
#define UNUSED(x) x __attribute((unused))
#else
#define UNUSED(x) x 
#endif /* GNU_C_ */

#ifndef DEBUG_LOCK
#define _alLockPrintf(x, f, l)
#else
int _alLockPrintf(const char *str, const char *fn, int line);
#endif /* DEBUG_LOCK */

#ifdef BOMB
#define bomb()	(*(char *)0 = 0);
#else
#define bomb()
#endif /* BOMB */

/* some macros */

/* what's the bit depth of the passed format? */
#define _al_ACformatbits(fmt) (fmt & 0x00FF)

/* what's the width of a format? */
#define _al_ALCHANNELS(f) ((f==AL_FORMAT_MONO16)? 1 : ((f==AL_FORMAT_MONO8)?1:2))

/* string stuff with casts for ALubyte *
 *
 * FIXME: this can't be the right way to do this.
 */
#define ustrcmp(s1, s2)     strcmp((const char *) s1, (const char *) s2)
			       

#define ustrncmp(s1, s2, n) strncmp((const char *) s1, \
				    (const char *) s2, \
				    n)
#define ustrncpy(s1, s2, n) strncpy((char *) s1, \
				    (const char *) s2, \
				    n)

/* memcpy to dst + offset (for void * + char offset) */
#define offset_memcpy(d,o,s,l) memcpy(((char *)d) + o, s, l)

/* memcpy from src + offset */
#define memcpy_offset(d,s,o,l) memcpy(d, (char *) s + o, l)

/* vector macros */
#define vector_equal(v1, v2) (((v1[0]==v2[0])&&(v1[1]==v2[1])&&(v1[2]==v2[2]))?AL_TRUE:AL_FALSE)

typedef struct _ALmatrix {
	ALfloat **data;
	ALint rows;
	ALint cols;
} ALmatrix;

/* publicly accessible functions */
int  _alStub(const char *str);
ALboolean _alInit(void);
void _alExit(void);

/* format specifier conversion stuff */
ALbyte  _al_formatbits(ALenum format);
ALenum   _al_AL2FMT(ALuint channels, ALuint bits);
ALenum   _al_AC2ALFMT(ALuint sdlformat, ALuint channels);
ALushort _al_AL2ACFMT(ALenum alfmt);
ALenum   _al_formatscale(ALenum format, ALuint new_channel_num);
ALfloat  _al_PCMRatio(ALuint ffreq, ALuint tfreq, ALenum ffmt, ALenum tfmt);
ALfloat  _al_WidthRatio(ALenum ffmt, ALenum tfmt);
ALboolean _al_RAWFORMAT(ALenum format);

/*
 * multiply each short in bpt (len bytes long) by sa, clamped above
 * by max and below by min.  Only suitable for 0.0 <= sa <= 1.0
 */
void float_mul(ALshort *bpt, ALfloat sa, ALuint len, ALint min, ALint max);

/* kludgey matrix multiplication */
ALmatrix *_alMatrixAlloc(int rows, int cols);
void _alMatrixFree(ALmatrix *m);
void _alMatrixMul(ALmatrix *result, ALmatrix *m1, ALmatrix *m2);

/* kludgey vector math stuff */
ALfloat vector_magnitude(const ALfloat *v1, const ALfloat *v2);
void vector_distance(ALfloat *d, const ALfloat *s1, const ALfloat *s2);
void rotate_point_about_axis(ALfloat angle, ALfloat *point, ALfloat *axis);
ALfloat vector_angle_between(ALfloat *origin, ALfloat *v1, ALfloat *v2);
ALfloat vector_dotp(ALfloat *origin, ALfloat *v1, ALfloat *v2);
ALfloat vector_intersect_angle(ALfloat *origin1, ALfloat *point1,
			 ALfloat *origin2, ALfloat *point2);
void vector_translate(ALfloat *d, ALfloat *s, ALfloat *delta);
void vector_inverse(ALfloat *d, ALfloat *s);
void vector_normalize(ALfloat *d, ALfloat *s);
ALint vector_quadrant(ALfloat *origin, ALfloat *v1);
void vector_crossp(ALfloat *d, ALfloat *origin, ALfloat *v1, ALfloat *v2);

void _alStartMixerThread(void);
void _alWaitForMixerThreadToDie(void);

void _alBuffersCopy(void **dsts, void **srcs, int len, int nc);
void _alBuffersAppend(void **dsts, void **srcs, int len, int offset, int nc);

/* slurp file named by fname to into *buffer, mallocing memory. */
int _alSlurp(const char *fname, void **buffer);

/* expotential scale */
double expscale(double value, double max);

/* to and from dB conversion funcs */
ALfloat _alDBToLinear(ALfloat dBs);
ALfloat _alLinearToDB(ALfloat linear);

/* power of two funcs */
#define ISPOWEROFTWO(n)     (((n & (n-1)) == 0) ? AL_TRUE : AL_FALSE)

unsigned int nextPowerOfTwo(unsigned int n);

/* sleep for n microseconds */
void _alMicroSleep(unsigned int n);

/*
 * Convert degree arguement to radians
 */
ALfloat _alDegreeToRadian(ALfloat degree);

/*
 * Functions for verifying values fall between min and max,
 * inclusive.
 */
ALboolean _alCheckRangef(ALfloat val, ALfloat min, ALfloat max);
ALboolean _alCheckRangeb(ALboolean val);

/*
 * Returns true if fv1 == { 0.0, 0.0, 0.0 }
 */
ALboolean _alIsZeroVector(ALfloat *fv1);

/* the buffers that sources are split into in SplitSources and
 * Collapsed from in CollapseSources.  Filters work on these
 * intermediate buffers, each of which contains one mono channel of
 * the source data.
 *
 * f_buffers contain PCM data
 * fft_buffers contain fft stuff
 */

extern _alDecodeScratch f_buffers;
extern _alDecodeScratch fft_buffers;

#endif
