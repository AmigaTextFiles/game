/* 
Copyright (C) 1996-1997 Id Software, Inc. 
 
This program is free software; you can redistribute it and/or 
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2 
of the License, or (at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   
 
See the GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program; if not, write to the Free Software 
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. 
 
*/ 

/*
** GetSysTimerPPC emulation for PowerUp by Frank Wille <frank@phoenix.owl.de>
** Bus clock determination code is based on powerpc.library source
** by Sam Jordan. Thanks Sam!
*/

#pragma amig-align
#include <devices/timer.h>
#include <powerup/ppclib/time.h>
#include <powerup/gcclib/powerup_protos.h>
#pragma default-align
#include "sys_timer.h"


static char gap1[32];
static struct ciatimer ctim;
static char gap2[32];
static ULONG TicksPerSec[2];


#ifdef __VBCC__
ULONG mftbu(void) = "\tmftbu\t3";
ULONG mftbl(void) = "\tmftbl\t3";
#else
#error Please write an external assembler module for mftbl/mftbu
#endif



void InitSysTimePPC(void)
{
  static ULONG one[2] = { 1,0 };
  struct Caos MyCaos;
  unsigned long clk;

  PPCCacheFlush(&ctim,sizeof(struct ciatimer));
  MyCaos.caos_Un.Function = (APTR)ReserveCIA;
  MyCaos.a0 = (ULONG)&ctim;
  MyCaos.M68kCacheMode = IF_CACHEFLUSHALL;
  MyCaos.PPCCacheMode = IF_CACHEFLUSHALL;
  if (PPCCallM68k(&MyCaos)) {  /* ReserveCIA() */
    /* This should run in supervisor mode, for a better precision, */
    /* but it seems sufficient for Quake... */
    clk = MeasureBusClock(&ctim);
    MyCaos.caos_Un.Function = (APTR)FreeCIA;
    MyCaos.a0 = (ULONG)&ctim;
    MyCaos.M68kCacheMode = IF_CACHEFLUSHALL;
    MyCaos.PPCCacheMode = IF_CACHEFLUSHALL;
    PPCCallM68k(&MyCaos);  /* FreeCIA() */
  }
  TicksPerSec[0] = 0;
  TicksPerSec[1] = CorrectBusClock(clk) >> 2; /* PPC timer counts every 4th */
}


void GetSysTimePPC(struct timeval *tv)
{
  static ULONG mill[2] = { 0,1000000 };
  ULONG r[2],secs[2];

  secs[0] = r[0] = mftbu();
  secs[1] = r[1] = mftbl();
  PPCDivu64p((int *)secs,(int *)TicksPerSec);
  tv->tv_secs = secs[1];
  PPCModu64p((int *)r,(int *)TicksPerSec);
  PPCMulu64p((int *)r,(int *)mill);
  PPCDivu64p((int *)r,(int *)TicksPerSec);
  tv->tv_micro = r[1];
}
