// g_sounds.c

#include "g_8svx.h"
#include "g_headers.h"

char sample_list[NUM_SAMPLES][32] = {"step1",
									"dirt1",
									"gem1",
									"boulder1",
									"key1",
									"trap1",
									"death1",
									"poof1",
									"water1",
									"spider1",
									"explode1",
									"snake1"};

struct sample_struct sample[NUM_SAMPLES];

int load_samples()
{
	int i;
	char fname[48];

	for(i = 0; i < NUM_SAMPLES; i++) {
		sprintf(fname, "data/s_%s.8svx", sample_list[i]);
		if(!load_sample(fname, &sample[i])) return 0;
	}

	return 1;
}

void free_samples()
{
	int i;

	for(i = 0; i < NUM_SAMPLES; i++) free_sample(&sample[i]);
}
