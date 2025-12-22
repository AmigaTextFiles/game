#include "robot.h"
#include <time.h>

#if defined(__OpenBSD__) && !defined(PORTABLE)
#define USE_RANDOM
#else
#include "mt/mt19937ar.h"
#endif

void random_seed(void)
{
#ifdef USE_RANDOM
	srandomdev();
#else
	init_genrand((unsigned long) time(NULL));
#endif
}

int rnd(int range)
{
#ifdef USE_RANDOM
	return random() % range;
#else
	return genrand_int31() % range;
#endif
}
