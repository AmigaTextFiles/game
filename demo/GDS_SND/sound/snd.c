#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include <signal.h>
#include <proto/exec.h>

#include <GameSmith:include/libraries/libraries.h>
#include <GameSmith:include/libraries/libptrs.h>
#include <GameSmith:include/sound/sound.h>
#include <GameSmith:include/proto/all.h>

void ctrl_c(int);

struct sound_struct sample1,sample2;	/* 2 structs in case of stereo sample */
int stop=0;								/* ctrl-C break flag */

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
	int err,echo,temp,old_prio;

	if (argc < 2)
		{
		printf("\nUsage: SND file_name [loop value] [echo divisor] [volume cnt]\n");
		printf("           [volume decrement] [period cnt] [period decrement] [period]\n");
		exit(01);
		}
	signal(SIGINT,&ctrl_c);			/* set up break handler ANSI style */
	sample1.flags=SND_FAST;			/* load sample to Fast RAM if available */
	sample2.flags=SND_FAST;
	if (gs_open_libs(DOS|GRAPHICS,0)) /* need DOS for reading file, and Graphics */
		exit(02);						/* sound sys uses Graphics lib to determine */
											/* whether a PAL or NTSC machine for timing */
	if (err=gs_load_iff_sound(&sample1,&sample2,argv[1]))
		{
		if (err == -4)					/* If not IFF, try to load raw */
			{
			if (err=gs_load_raw_sound(&sample1,argv[1]))
				{
				printf("\nError loading raw sample.  Code = %d\n",err);
				gs_close_libs();
				exit(03);
				}
			else
				printf("\nRaw Sample\n\n");
			}
		else if (err == -7)			/* if couldn't load 2nd channel */
			{
			printf("\nUnable to load 2nd sound channel for stereo play\n");
			}
		else
			{
			printf("\nError loading IFF sample.  Code = %d\n",err);
			gs_close_libs();
			exit(03);
			}
		}
	else
		{
		if (sample2.data)
			printf("\nIFF 8SVX Stereo Sample ({<*>})\n\n");
		else
			printf("\nIFF 8SVX Mono Sample\n\n");
		}
	if (argc >= 3)						/* check for repeat value */
		{
		sample1.repeat=atoi(argv[2]);
		sample2.repeat=atoi(argv[2]);
		}
	if (argc >= 4)						/* check for echo divisor */
		{
		echo=atoi(argv[3]);
		if (echo > 1)
			{
			temp=sample1.length/echo;
			if (temp)
				{
				sample1.loop=sample1.data+((sample1.length-temp)*2);
				sample2.loop=sample2.data+((sample2.length-temp)*2);
				}
			}
		}
	if (argc >= 5)						/* check for volume count */
		{
		sample1.volcnt=atoi(argv[4]);
		sample2.volcnt=atoi(argv[4]);
		}
	if (argc >= 6)						/* check for volume decrement */
		{
		sample1.volfade=atoi(argv[5]);
		sample2.volfade=atoi(argv[5]);
		}
	if (argc >= 7)						/* check for period count */
		{
		sample1.percnt=atoi(argv[6]);
		sample2.percnt=atoi(argv[6]);
		}
	if (argc >= 8)						/* check for period decrement */
		{
		sample1.perfade=atoi(argv[7]);
		sample2.perfade=atoi(argv[7]);
		}
	if (argc >= 9)						/* check for new period value */
		{
		sample1.period=atoi(argv[8]);
		sample2.period=atoi(argv[8]);
		}
	if (gs_open_sound(1,0,0,(4096/2)))	/* open sound system & alloc channels */
		{
		gs_free_sound(&sample1);
		if (sample2.data)
			gs_free_sound(&sample2);
		printf("\nError opening sound system\n");
		gs_close_libs();
		exit(04);
		}
	Disable();					/* in case need to sync 2 channels */
	gs_start_sound(&sample1,CHANNEL0);
	if (sample2.data)			/* check if need to start 2nd channel @ same time */
		gs_start_sound(&sample2,CHANNEL1);
	else
		gs_start_sound(&sample1,CHANNEL1);
	Enable();					/* reenable interrupts */
	old_prio=gs_task_prio(-128);				/* lowest priority while sample plays */
	while ((gs_sound_check()) && (!stop))	/* wait for all channels idle */
		chkabort();									/* and check for abort signal */
	gs_task_prio(old_prio);
	gs_stop_sound(CHANNEL0);					/* stop all sounds (if still active) */
	gs_stop_sound(CHANNEL1);
	gs_close_sound();								/* shut down sound system */
	gs_free_sound(&sample1);					/* release sound data when done */
	if (sample2.data)
		gs_free_sound(&sample2);
	gs_close_libs();								/* close libs and end */
}

/***************************************************************************/

void ctrl_c(signal)			/* ctrl-C handling ANSI fashion (SAS/C 6.xx) */
int signal;

{
	stop=1;						/* set flag to quit */
}
