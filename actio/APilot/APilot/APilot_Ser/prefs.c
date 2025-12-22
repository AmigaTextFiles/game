/***************************************************************************
 *
 * prefs.c -- Parse commandline and set user preferences
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)  
 *
 */
	
#include <dos/dos.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <libraries/dos.h>
#include <intuition/intuition.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <proto/exec.h>
#include <proto/dos.h>

#include "common.h"
#include "prefs_protos.h"
#include "main_protos.h"

#define EXTENDED_HELPSTRING "\nAPilot extended help\n"\
  "--------------------------------------------------------------\n"\
  "Authors:\n"\
  "  Casper Gripenberg  (Casper.Gripenberg@hut.fi)\n"\
  "  Kjetil Jacobsen    (kjetilja@stud.cs.uit.no)\n"\
  "==============================================================\n"\
  "Usage: APilot [options]\n"\
  "Where options include:\n"\        
  "      MAPFILE <mapfile>   : Specify a mapfile other than the\n"\ 
  "                            default one.\n"\
  "      SCREENMODE          : Choose screenmode.\n"\
  "                          : (Only available if compiled with DYN_SCR)\n"\
  "      NOSERIAL            : One player only.\n"\
  "      DEVICE <devicename> : Serial device to use.\n"\
  "      UNIT   <unitnumber> : Serial device unit number to use.\n"\
  "      SPEED  <bps>        : Communication speed.\n"\
  "=============================================================\n";

#define PREFS_FAIL FreeArgs(RDArgs);\
  FreeDosObject(DOS_RDARGS, RDArgs);\
  FreeVec(Args);\
  cleanExit( RETURN_WARN,\
             "** Failed to allocate space for argument strings.\n" )

#ifdef DYN_SCR
static const char *Template = "MF=MAPFILE/K,SM=SCREENMODE/S,NS=NOSERIAL/S,DEVICE/K,UNIT/N/K,SPEED/N/K";
enum { MAPFILE_ARG, SCRNMODE_ARG, NOSER_ARG, DEV_ARG, UNIT_ARG, SPEED_ARG, LAST_ARG };
#else
static const char *Template = "MF=MAPFILE/K,NS=NOSERIAL/S,DEVICE/K,UNIT/N/K,SPEED/N/K";
enum { MAPFILE_ARG, NOSER_ARG, DEV_ARG, UNIT_ARG, SPEED_ARG, LAST_ARG };
#endif


void 
set_prefs(void)
{
  APTR    *Args;
  struct  RDArgs  *RDArgs;

  /*
   * Set default prefs.
   */
  prefs.ser_dev        = DEF_SERIALDEVICE;
  prefs.ser_unitnr     = DEF_SERIALUNIT;
  prefs.ser_bps        = DEF_SERIALBPS;
  prefs.noserial       = FALSE;
  prefs.mapname        = MAPFILE;
  prefs.dpy_modeid     = HIRES|LACE;
  prefs.dpy_autoscroll = 0;
  prefs.dpy_oscan      = OSCAN_STANDARD;	
  prefs.dpy_width      = 641; /* Default values (could really be anything) */
  prefs.dpy_height     = 513;
  prefs.native_mode    = TRUE;

	if ((Args = AllocVec((LAST_ARG * sizeof(ULONG)), MEMF_CLEAR))) {
    if ((RDArgs = AllocDosObjectTags(DOS_RDARGS, TAG_DONE))) {
      RDArgs->RDA_ExtHelp = EXTENDED_HELPSTRING;
      if ((ReadArgs((char *)Template, (LONG *)Args, RDArgs))) {

        /*
         * A OK so far, now check which arguments have been used.
         */
#ifdef DYN_SCR
        if (Args[SCRNMODE_ARG])
          prefs.native_mode = FALSE;
#endif
        if (Args[MAPFILE_ARG]) {
          if ((prefs.mapname = (char *)
               malloc(strlen(Args[MAPFILE_ARG]) + 1)) == NULL) {
            PREFS_FAIL;
          }
          strcpy(prefs.mapname, Args[MAPFILE_ARG]);
        }

        if (Args[NOSER_ARG]) {
          printf("** Noserial not implemented yet.\n");
          prefs.noserial = TRUE;
        }

        if (Args[DEV_ARG]) {
          if ((prefs.ser_dev = (char *)
               malloc(strlen(Args[DEV_ARG]) + 1)) == NULL) {
            PREFS_FAIL;
          }
          strcpy(prefs.ser_dev, Args[DEV_ARG]);
        }

        if (Args[UNIT_ARG])
          prefs.ser_unitnr = *((ULONG *)Args[UNIT_ARG]);

        if (Args[SPEED_ARG])
          prefs.ser_bps = *((ULONG *)Args[SPEED_ARG]);

        /*
         * Just for debugging..
         */
        printf("Mapfile: %s\n", prefs.mapname);
        printf("Serdev : %s\n", prefs.ser_dev);
        printf("Serunit: %d\n", prefs.ser_unitnr);
        printf("Serbps : %d\n", prefs.ser_bps);

        FreeArgs(RDArgs);
      }
      FreeDosObject(DOS_RDARGS, RDArgs);
    }
    FreeVec(Args);
  }
}
