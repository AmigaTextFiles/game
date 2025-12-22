/* Random Analysis program.  Test random function for good spread. */

#include <stdio.h>
#include <stdlib.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/libraries/libptrs.h"
#include "GameSmith:include/proto/all_regargs.h"

#define ITERATIONS	1000000	/* get 1 million random numbers */

main(argc,argv)
int argc;
char *argv[];

{
	unsigned long cnt,*sample;
	unsigned short sample_size,num;

	if (argc < 2)
		{
		printf("\nUSAGE: ra [number range]\n");
		exit(01);
		}
	sample_size=atoi(argv[1]);
	printf("\nSample Range: 0 to %d\n",sample_size-1);
	if (!(sample=malloc(sample_size*sizeof(long))))
		printf("\ninsufficient memory for sample array\n");
	for (cnt=0; cnt < sample_size; cnt++)
		sample[cnt]=0;			/* clear sample count */
	for (cnt=0; cnt < ITERATIONS; cnt++)
		{
		num=_gs_random(sample_size);		/* get random # in specified range */
		sample[num]++;			/* increment count for that number */
		}
	printf("\nCount of Random Number Values:");
	for (cnt=0; cnt < sample_size; cnt++)
		printf("\n%d\t=%d",cnt,sample[cnt]);
	printf("\n");
	free(sample);
}
