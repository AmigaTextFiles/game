/*
 * $Source: /usr/CVS/descent/bios/timer.c,v $
 * $Revision: 1.3 $
 * $Author: tfrieden $
 * $Date: 1998/04/14 23:49:43 $
 * $Id: timer.c,v 1.3 1998/04/14 23:49:43 tfrieden Exp $
 *
 * Routines for timer handling
 *
 * $Log: timer.c,v $
 * Revision 1.3  1998/04/14 23:49:43  tfrieden
 * Added some error checking
 *
 * Revision 1.2  1998/04/13 17:49:52  tfrieden
 * Some bugfixes
 *
 * Revision 1.1.1.1  1998/03/03 15:11:50  nobody
 * reimport after crash from backup
 *
 * Revision 1.1  1998/02/22 13:32:31  tfrieden
 * initial version of timer stuff with timer.device
 *
 *
 */
#include <clib/timer_protos.h>
#include <clib/exec_protos.h>

#include <stdlib.h>
#include <stdio.h>
#include "types.h"
#include "fix.h"

#include <devices/timer.h>
#include <inline/timer.h>
#include <inline/exec.h>

struct Library *TimerBase;
extern struct Library *SysBase;
struct timerequest *tr;

void timer_close(void)
{

	CloseDevice((struct IORequest *)tr);
	free(tr);

}

void timer_init(void)
{

	atexit(timer_close);

	tr = (struct timerequest *)calloc(1, sizeof(struct timerequest));
	if (OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest *) tr, 0L) != 0) {
		printf("Error opening timer.device\n");
		exit(1);
	}
	TimerBase = (struct Library *)tr->tr_node.io_Device;

}


void timer_set_rate(int time)
{
}

fix timer_get_fixed_seconds(void)
{

	struct timeval tv;
	fix time;

	GetSysTime(&tv);

	time = (fix)(tv.tv_secs&0xffff)<<16;
	time = (fix)(((float)tv.tv_micro/1000000.0)*65536.0)+time;

	return(time);
}

fix timer_get_fixed_secondsX(void)
{
	return timer_get_fixed_seconds();
}

fix timer_get_approx_seconds(void)
{
	return timer_get_fixed_seconds();
}



