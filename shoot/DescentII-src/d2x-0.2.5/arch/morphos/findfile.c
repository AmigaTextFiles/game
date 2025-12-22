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

#include <proto/dos.h>
static int CallMatchEnd = 0;	// not sure, lets stay safe
static struct AnchorPath my_ap;

int FileFindFirst(char *search_str, FILEFINDSTRUCT *ffstruct)
{
	struct AnchorPath *ap = (struct AnchorPath *)&my_ap;
	LONG err;
	int rc = -1;

	ap->ap_Flags = 0;
	ap->ap_Strlen = 0;

	if (CallMatchEnd)
		MatchEnd(ap);

	CallMatchEnd = 1;

	err = MatchFirst(search_str, ap);
	rc = 1;

	if (!err)
	{
		char *p;

		rc = 0;

		p  = strrchr(ap->ap_Info.fib_FileName, '.');
		*p = 0;
		ffstruct->size = ap->ap_Info.fib_Size;
		strcpy(ffstruct->name, ap->ap_Info.fib_FileName);
	}

	return rc;
}

int FileFindNext(FILEFINDSTRUCT *ffstruct)
{
	struct AnchorPath *ap = (struct AnchorPath *)&my_ap;
	LONG err;
	int rc;

	err = MatchNext(ap);
	rc = -1;

	if (!err)
	{
		char *p;

		rc = 0;

		ffstruct->size = ap->ap_Info.fib_Size;
		p  = strrchr(ap->ap_Info.fib_FileName, '.');
		*p = 0;
		strcpy(ffstruct->name, ap->ap_Info.fib_FileName);
	}

	return rc;
}

int FileFindClose(void)
{
	if (CallMatchEnd)
	{
		CallMatchEnd = 0;
		MatchEnd((struct AnchorPath *)&my_ap);
	}

	return 0;
}
