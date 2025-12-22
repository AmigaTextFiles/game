#include <math.h>

#define M 2147483647
#define Q 44488
#define A 48271
#define	R 3399

static long seed = 1;

void
RandomSeed(long s)
{
	seed = s;
}

long
Random(long scale)
{
	long q, r, t;

	q = seed / Q;
	r = seed % Q;

	if((t = A * r - R * q) > 0) {
		seed = t;
	} else {
		seed = t + M;
	}

	/* If you got long long (64-bit int), use it instead of float */
#if 1
	return (long) (((float)seed * (float)scale) / (float)M);
#else
	return ((long)((long long)seed * (long long)scale) / (long long)M));
#endif
}
