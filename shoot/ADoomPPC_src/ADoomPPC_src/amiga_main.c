// Emacs style mode select   -*- C++ -*- 
//-----------------------------------------------------------------------------
//
// $Id:$
//
// Copyright (C) 1993-1996 by id Software, Inc.
//
// This source is available for distribution and/or modification
// only under the terms of the DOOM Source Code License as
// published by id Software. All rights reserved.
//
// The source is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// FITNESS FOR A PARTICULAR PURPOSE. See the DOOM Source Code License
// for more details.
//
// $Log:$
//
// DESCRIPTION:
//	Main program, simply calls D_DoomMain high level loop.
//
//-----------------------------------------------------------------------------

#ifdef WARPUP
const char amigaversion[] = "$VER: ADoomWOS 1.7 (07.11.2000)";
#else
const char amigaversion[] = "$VER: ADoomPPC 1.7 (07.11.2000)";
#endif

long __oslibversion = 38;	/* we require at least OS3.0 for LoadRGB32() */
char __stdiowin[] = "CON:0/20/640/140/ADoomPPC/AUTO/CLOSE/WAIT";

#include <stdio.h>
#include <stdlib.h>

#include <exec/exec.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>
#include <workbench/icon.h>
#ifdef WARPUP
#include <powerpc/powerpc.h>
#include <clib/powerpc_protos.h>
#else
#include <PowerUP/ppclib/ppc.h>
#endif

#include <proto/exec.h>
#include <proto/icon.h>
#include <proto/utility.h>
#include <clib/alib_protos.h>

#include "doomdef.h"

#include "m_argv.h"
#include "d_main.h"
#include "i_system.h"
#include "m_fixed.h"

/**********************************************************************/

int VERSION = 110;

int cpu_type;
int bus_clock;
int bus_MHz;
double tb_scale_lo;
double tb_scale_hi;

/**********************************************************************/
#ifdef __SASC
extern int _WBArgc;
extern char **_WBArgv;
#endif

#ifdef MORPHOS
struct UtilityBase *UtilityBase = NULL;
#endif

#ifdef WARPUP
struct Library *IconBase = NULL;
static UBYTE **ttypes = NULL;
void main_cleanup(void);
#endif

#ifdef __VBCC__
FILE *conout, *oldstderr, *oldstdout;
#endif

int main (int argc, char* argv[])
{ 
  int p;
	ULONG i, i2;
  double pll;

#ifdef __SASC
	if (argc == 0) {
		argc = _WBArgc;
		argv = _WBArgv;
		myargc = argc;
		if ((myargv = malloc(sizeof(char *)*MAXARGVS)) == NULL)
			I_Error ("malloc(%d) failed", sizeof(char *)*MAXARGVS);
		memset (myargv, 0, sizeof(char *)*MAXARGVS);
		memcpy (myargv, argv, sizeof(char *)*myargc);
	}
	else {
		myargc = argc;
		myargv = argv;
	}
#else
	if (argc == 0) {
		atexit(main_cleanup);

#ifdef __VBCC__
		if ((conout = fopen(__stdiowin, "wb")) == NULL)
			exit(1);
		oldstderr = stderr;
		oldstdout = stdout;
		stderr = conout;
		stdout = conout;
#endif

		if ((myargv = malloc(sizeof(char *)*MAXARGVS)) == NULL)
			I_Error ("malloc(%d) failed", sizeof(char *)*MAXARGVS);
		memset (myargv, 0, sizeof(char *)*MAXARGVS);
		if ((IconBase = OpenLibrary("icon.library", 0)) == NULL)
			I_Error ("Can't open icon.library v0");
		if ((ttypes = ArgArrayInit(argc, (UBYTE **)argv)) == NULL)
			I_Error ("Can't read tooltypes");
		myargc = 1;
		myargv[0] = "ADoomWOS";
		while(ttypes[myargc-1] != NULL) {
			myargv[myargc] = ttypes[myargc-1];
			myargc++;
		}
	}
	else {
		myargc = argc;
		myargv = argv;
	}
#endif

	printf ("%s\n", &amigaversion[6]);

#ifdef WARPUP
	printf ("\nADoomWOS parameters are:\n\n    ");
#else
  printf ("\nADoomPPC parameters are:\n\n    ");
#endif

  for (i = 1 ; i < myargc; i++)
    printf (" %s", myargv[i]);
  printf ("\n\n");

#if defined(MORPHOS)
	p = M_CheckParm ("-cpu");
	if (p && p < myargc - 1) {
		cpu_type = atoi (myargv[p+1]);
	}
  switch (cpu_type) {
    case 3:
      printf ("\nCPU is PPC603 ");
      break;
    case 4:
      printf ("\nCPU is PPC604 ");
      break;
    case 5:
      printf ("\nCPU is PPC602 ");
      break;
    case 6:
      printf ("\nCPU is PPC603e ");
      break;
    case 7:
      printf ("\nCPU is PPC603e+ ");
      break;
    case 8:
      printf ("\nCPU is PPC604e ");
      break;
    default:
      printf ("\nCPU is PPC ");
      break;
  }
	p = M_CheckParm ("-bus");
  if (p && p < myargc - 1) {
    bus_clock = atoi (myargv[p+1]);
  }
  bus_MHz = bus_clock / 1000000;
  printf("Bus clock is %d MHz.\n\n", bus_MHz);

#elif defined(WARPUP)
	{
    struct TagItem ti_cputype[] = {{GETINFO_CPU, 0}, {TAG_END, 0}};
    struct TagItem ti_cpuclock[] = {{GETINFO_CPUCLOCK, 0}, {TAG_END, 0}};
    struct TagItem ti_busclock[] = {{GETINFO_BUSCLOCK, 0}, {TAG_END, 0}};

    GetInfo (ti_cputype);
    cpu_type = ti_cputype[0].ti_Data;
    switch (cpu_type) {
      case CPUF_603:
        printf ("\nCPU is PPC603 ");
        break;
      case CPUF_604:
        printf ("\nCPU is PPC604 ");
        break;
      case CPUF_603E:
        printf ("\nCPU is PPC603e ");
        break;
      case CPUF_604E:
        printf ("\nCPU is PPC604e ");
        break;
      case CPUF_620:
        printf ("\nCPU is PPC620 ");
        break;
      default:
        printf ("\nCPU is PPC ");
        break;
    }

    GetInfo (ti_cpuclock);
    bus_clock = ti_cpuclock[0].ti_Data;
    printf ("running at %d MHz\n", bus_clock / 1000000);

    GetInfo (ti_busclock);
    bus_clock = ti_busclock[0].ti_Data;
		p = M_CheckParm ("-bus");
  	if (p && p < myargc - 1) {
			bus_clock = atoi (myargv[p+1]);
  	}
    bus_MHz = bus_clock / 1000000;
    printf("Bus clock is %d MHz.\n\n", bus_MHz);
	}
#else /* PowerUP */
  cpu_type = PPCGetAttr(PPCINFOTAG_CPU);
  p = M_CheckParm ("-cpu");
  if (p && p < myargc - 1) {
    cpu_type = atoi (myargv[p+1]);
  }
  switch (cpu_type) {
    case 3:
      printf ("\nCPU is PPC603 ");
      break;
    case 4:
      printf ("\nCPU is PPC604 ");
      break;
    case 5:
      printf ("\nCPU is PPC602 ");
      break;
    case 6:
      printf ("\nCPU is PPC603e ");
      break;
    case 7:
      printf ("\nCPU is PPC603e+ ");
      break;
    case 8:
      printf ("\nCPU is PPC604e ");
      break;
    default:
      printf ("\nCPU is PPC ");
      break;
  }

  bus_clock = PPCGetAttr(PPCINFOTAG_CPUCLOCK);
  printf ("running at %d MHz ", bus_clock);
  if (!bus_clock)
    bus_clock = 50000000;
  else
    bus_clock = bus_clock * 1000000;
  i = PPCGetAttr(PPCINFOTAG_CPUPLL);
  if ((i & 0xf0000000) && !(i & 0x0ffffff0))
    i2 = i >> 28;     /* work around bug in ppc.library */
  else
    i2 = i & 0x0000000f;
  switch (i2) {    /* see http://mx1.xoom.com/silicon/docs/ppc_pll.html */
    case 0:
    case 1:
    case 2:
    case 3:
      pll = 1.0;			// PLL is 1:1 (or bypassed)
      break;
    case 4:
    case 5:
      pll = 2.0;			// PLL is 2:1
      break;
    case 6:
      pll = 2.5;
      break;
    case 7:
      pll = 4.5;
      break;
    case 8:
    case 9:
      pll = 3.0;			// PLL is 3:1
      break;
    case 10:
      pll = 4.0;
      break;
    case 11:
      pll = 5.0;
      break;
    case 12:
      if ((cpu_type == 4) || (cpu_type == 8))
        pll = 1.5;			// PLL is 1.5:1
      else
        pll = 4.0;			// PLL is 4:1
      break;
    case 13:
      pll = 6.0;			// PLL is 6:1
      break;
    case 14:
      pll = 3.5;			// PLL is 3.5:1
      break;
    default:
      pll = 3.0;
      break;
  }

  printf ("using a PLL divisor of %3.1f.\n", pll);

  bus_clock = (int)((double)bus_clock / pll);
  p = M_CheckParm ("-bus");
  if (p && p < myargc - 1) {
    bus_clock = atoi (myargv[p+1]);
  }
  bus_MHz = bus_clock / 1000000;
  printf("Bus clock is %d MHz.\n\n", bus_MHz);
#endif

  tb_scale_lo = ((double)(bus_clock >> 2)) / 35.0;
  tb_scale_hi = (4.294967296E9 / (double)(bus_clock >> 2)) * 35.0;

/* The original fixed point code is faster on GCC */
#if !defined(__GNUC__)
  SetFPMode ();  /* set FPU rounding mode to "trunc towards -infinity" */
#endif

  p = M_CheckParm ("-forceversion");
  if (p && p < myargc - 1)
    VERSION = atoi (myargv[p+1]);

  D_DoomMain ();

  return 0;
}

#ifndef __SASC
void main_cleanup(void)
{
	if (ttypes != NULL) {
		ArgArrayDone();
		ttypes = NULL;
	}

	if (IconBase != NULL) {
		CloseLibrary(IconBase);
		IconBase = NULL;
	}

#ifdef __VBCC__
	if (conout != NULL) {
		stdout = oldstdout;
		stderr = oldstderr;
		fclose(conout);
		conout = NULL;
	}
#endif
}
#endif
