/***************************************************************************
 *
 * cmdline.c -- Parse commandline and set user preferences
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)  
 *
 */
	
#include <exec/types.h>
#include <libraries/dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common.h"
#include "cmdline_protos.h"
#include "main_protos.h"


void cmdline(int argc, char **argv)
{
  int i;

  for (i=1; i<argc; i++) {
    if (argv[i][0] == '?' || (strncmp("-help",argv[i],2) == 0)) {
      printf("Usage:\t%s [options] [-map mapfile]\n\nWhere options include:\n",argv[0]);
      printf("        ? or -help : This text\n");
      printf("        -scrm      : Select screenmode at startup\n\n");
      printf("NOTE: The mapfile option *must* be the last one\n");	
      exit(0);
    } 
    else 
      if (strncmp("-scrm",argv[i],4) == 0) {
	prefs.native_mode = 0;	
      }
      else
	if (strncmp("-map",argv[i],3) == 0) {
	  if (argc > i+1)
	    prefs.mapname = argv[i+1];
	  else
	    printf("** No mapname specified, option ignored\n");
	  break;
	}
	else
	  cleanExit( RETURN_WARN, "** Unknown option, try -help or ?\n" );
  }
}
