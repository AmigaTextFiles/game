/* $Id: findfile.c,v 1.7 2003/03/13 00:20:21 btb Exp $ */
/*
 *
 * Linux findfile functions
 *
 *
 */

#ifdef HAVE_CONFIG_H
#include <conf.h>
#endif

#include <stdlib.h>
#include <string.h>
#include <glob.h>
#include "findfile.h"
#include "u_mem.h"
#include "error.h"

#ifndef __MORPHOS__
/* KLUDGE ALERT: evil globals */
static glob_t glob_a;
static int glob_whichfile;

int FileFindFirst(char *search_str, FILEFINDSTRUCT *ffstruct)
{
  int r;
  char *t;

  Assert(search_str != NULL);
  Assert(ffstruct != NULL);

  r = glob(search_str, 0, NULL, &glob_a);
  if (r) return 1;

  if (! glob_a.gl_pathc) return 1;

  glob_whichfile = 0;
  
  t = strrchr(glob_a.gl_pathv[glob_whichfile], '/');
  if (t == NULL) t = glob_a.gl_pathv[glob_whichfile]; else t++;
  strncpy(ffstruct->name, t, 255);
  ffstruct->size = strlen(ffstruct->name); 
  
  return 0;
}

int FileFindNext(FILEFINDSTRUCT *ffstruct)
{
  char *t;
  
  glob_whichfile++;

  if (glob_whichfile >= glob_a.gl_pathc) return -1;

  t = strrchr(glob_a.gl_pathv[glob_whichfile], '/');
  if (t == NULL) t = glob_a.gl_pathv[glob_whichfile]; else t++;
  strncpy(ffstruct->name, t, 255);
  ffstruct->size = strlen(ffstruct->name); 
  return 0;
}

int FileFindClose(void)
{
 globfree(&glob_a);
 return 0;
}
#else
#include <proto/dos.h>
static struct AnchorPath ap;
static int CallMatchEnd = 0;	// not sure, lets stay safe

int FileFindFirst(char *search_str, FILEFINDSTRUCT *ffstruct)
{
	LONG err;
	int rc = -1;

	ap.ap_Flags = 0;
	ap.ap_Strlen = 0;

	if (CallMatchEnd)
		MatchEnd(&ap);

	CallMatchEnd = 1;

	err = MatchFirst(search_str, &ap);
	rc = 1;

	if (!err)
	{
		rc = 0;

		ffstruct->size = ap.ap_Info.fib_Size;
		strcpy(ffstruct->name, ap.ap_Info.fib_FileName);
	}

	return rc;
}

int FileFindNext(FILEFINDSTRUCT *ffstruct)
{
	LONG err;
	int rc;

	err = MatchNext(&ap);
	rc = -1;

	if (!err)
	{
		ffstruct->size = ap.ap_Info.fib_Size;
		strcpy(ffstruct->name, ap.ap_Info.fib_FileName);
		rc = 0;
	}

	return rc;
}

int FileFindClose(void)
{
	if (CallMatchEnd)
	{
		CallMatchEnd = 0;
		MatchEnd(&ap);
	}

	return 0;
}

#endif