//=========================================================================
//=========================================================================
//
//	AmiSGE - main file
// 
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#define INTUI_V36_NAMES_ONLY

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<ctype.h>

#include	<dos.h>
#include	<exec/types.h>
#include	<exec/memory.h>
#include	<clib/dos_protos.h>
#include	<clib/exec_protos.h>
#include	<pragmas/dos_pragmas.h>
#include	<pragmas/exec_pragmas.h>

#include	"main.h"
#include	"misc.h"
#include	"printf.h"
#include	"file.h"

//=========================================================================
// Version & ID strings
//=========================================================================
static const UBYTE * const msVersion = VERSIONSTRING;
static const UBYTE * const msFullID  = FULLIDSTRING;

//=========================================================================
// Global variable storage
//=========================================================================

//=========================================================================
// Module variables
//=========================================================================
static struct RDArgs *ArgRDArgs   = NULL;
static const  STRPTR  ArgTemplate = "DECODE/S,ENCODE/S,FROM/A,TO/A";
static        LONG    ArgV[]      = { NULL, NULL, NULL, NULL };
static const  STRPTR  ArgExtHelp  = ": DECODE|ENCODE FROM=<input> TO=<output>";

static        UBYTE *mpCloudSpace = NULL;
static        UBYTE *mpClearSpace = NULL;

//========================================================================
// Option variables
//========================================================================
static	ULONG	mOptDecode	= 0;
static	ULONG	mOptEncode	= 0;
static	STRPTR	msOptFrom	= NULL;
static	STRPTR	msOptTo		= NULL;

//========================================================================
// Argument definitions
//========================================================================
#define	ARG_DECODE	0
#define	ARG_ENCODE	1
#define	ARG_FROM	2
#define	ARG_TO		3

//=========================================================================
// Clean up and exit program
//=========================================================================
static
VOID mfCleanExit(
					STRPTR a_errstr
				)
{
	static BOOL aborting = FALSE;
	
	//=====================================================================
	// Avoid recursive aborts!
	//=====================================================================
	if (!aborting)
	{
		aborting = TRUE;

		//=================================================================
		// Output the error message
		//=================================================================
	    if (a_errstr)
		{
			PutStr(APPNAME);
			PutStr(a_errstr);
			PutStr("\n");
	    }

		//=================================================================
		// Free RDArgs structure
		//=================================================================
		if (ArgRDArgs)
		{
			FreeArgs(ArgRDArgs);
			FreeDosObject(DOS_RDARGS, ArgRDArgs);
			ArgRDArgs = NULL;
		}

		//=================================================================
		// Free memory buffers
		//=================================================================
		if (mpCloudSpace) { memset(mpCloudSpace, 0, BUFFER_LENGTH); free(mpCloudSpace); }
		if (mpClearSpace) { memset(mpClearSpace, 0, BUFFER_LENGTH); free(mpClearSpace); }
	}

	//=====================================================================
	// Exit the program!
	//=====================================================================
	exit(a_errstr ? 20 : 0);
}


//=========================================================================
// handleIoErr
//
// Check current IoErr() value and take appropriate action
//=========================================================================
static
VOID handleIoErr(
					STRPTR a_where
				)
{
	       LONG  err;
	static UBYTE errhdr[30];
	static UBYTE errmsg[256];

	err = IoErr();

	if (err != 0 && err != -1)
	{
		gfSprintf(errhdr, "IO error %ld (%s)", err, a_where);
		Fault(err, errhdr, errmsg, 256);
		mfCleanExit(errmsg);
	}
}


//========================================================================
// BOOL mfDecode
//========================================================================
BOOL mfDecode()
{
	BOOL	retval = FALSE;
	ULONG	res;
	ULONG	inlen;

	//====================================================================
	// Load commander file to decode
	//====================================================================
	if (!gfReadFile(msOptFrom, mpCloudSpace, &inlen))
	{
		handleIoErr("input file");
		gfPrintf("%s: could not load input file [%s]\n", APPNAME, msOptFrom);
	}
	else
	{
		//================================================================
		// Decode commander data in buffer
		//================================================================
		res = gfMakeClearBuffer(mpCloudSpace, mpClearSpace, inlen);

		if (res == 1)
		{
			gfPrintf("%s: not a commander file\n", APPNAME);
		}
		else if (res == 2)
		{
			gfPrintf("%s: bad checksum\n", APPNAME);
		}
		else if (res != 0)
		{
			gfPrintf("%s: unknown decode error %ld\n", APPNAME, res);
		}
		else
		{
			//============================================================
			// Write decoded data to output file
			//============================================================
			if (!gfWriteFile(msOptTo, mpClearSpace, BUFFER_LENGTH))
			{
				handleIoErr("output file");
				gfPrintf("%s: could not save output file [%s]\n", APPNAME, msOptTo);
			}
			else
			{
				retval = TRUE;
			}
		}
	}

	return(retval);
}


//========================================================================
// BOOL mfEncode
//========================================================================
BOOL mfEncode()
{
	BOOL	retval = FALSE;
	ULONG	len;
	ULONG	inlen;

	//====================================================================
	// Load file to encode as a Frontier commander file
	//====================================================================
	if (!gfReadFile(msOptFrom, mpClearSpace, &inlen))
	{
		handleIoErr("input file");
		gfPrintf("%s: could not load input file [%s]\n", APPNAME, msOptFrom);
	}
	else
	{
		//================================================================
		// Encode commander data in buffer
		//================================================================
		len = gfMakeCloudBuffer(mpClearSpace, mpCloudSpace);

		//================================================================
		// Write encoded data to output file
		//================================================================
		if (!gfWriteFile(msOptTo, mpCloudSpace, len))
		{
			handleIoErr("output file");
			gfPrintf("%s: could not save output file [%s]\n", APPNAME, msOptTo);
		}
		else
		{
			retval = TRUE;
		}
	}

	return(retval);
}


//========================================================================
//========================================================================
//  MAIN FUNCTION
//========================================================================
//========================================================================
ULONG main(
			ULONG	a_argc,
			STRPTR	*a_argv
		  )
{
	STRPTR	pTmp;

	//=====================================================================
	// Parse arguments with RDArgs
	//=====================================================================
	if ((ArgRDArgs = AllocDosObject(DOS_RDARGS, NULL)) == NULL)
	{
		mfCleanExit("could not allocate RDArgs structure!");
	}

	ArgRDArgs->RDA_ExtHelp = ArgExtHelp;

	if ((ReadArgs(ArgTemplate, ArgV, ArgRDArgs)) == NULL)
	{
		mfCleanExit(ArgRDArgs->RDA_ExtHelp);
	}

	//=====================================================================
	// Allocate buffers for encoded and decoded data
	//=====================================================================
	mpClearSpace = (UBYTE *)calloc(BUFFER_LENGTH, 1);
	mpCloudSpace = (UBYTE *)calloc(BUFFER_LENGTH, 1);

	if ((mpClearSpace == NULL) || (mpCloudSpace == NULL))
	{
		mfCleanExit("failed to allocate buffers\n");
	}

	//=====================================================================
	// Deal with DECODE,ENCODE parameters
	//=====================================================================
	mOptDecode = (ULONG)ArgV[ARG_DECODE];
	mOptEncode = (ULONG)ArgV[ARG_ENCODE];

	if (mOptDecode && mOptEncode)
	{
		mfCleanExit("only one of DECODE,ENCODE allowed");
	}

	if (!mOptDecode && !mOptEncode)
	{
		mfCleanExit("one of DECODE,ENCODE must be given");
	}

	//=====================================================================
	// Deal with FROM parameter
	//=====================================================================
	if (!(msOptFrom = (STRPTR)ArgV[ARG_FROM]))
	{
		mfCleanExit("FROM must be given");
	}

	//=====================================================================
	// Deal with TO parameter
	//=====================================================================
	if (!(msOptTo = (STRPTR)ArgV[ARG_TO]))
	{
		mfCleanExit("TO must be given");
	}

	//=====================================================================
	// Do requested operation
	//=====================================================================
	if (mOptDecode)
	{
		if (!mfDecode())
		{
			mfCleanExit("decode operation failed");
		}
	}
	else if (mOptEncode)
	{
		if (!mfEncode())
		{
			mfCleanExit("encode operation failed");
		}
	}

	//=====================================================================
	// All done!
	//=====================================================================
	mfCleanExit(NULL);
}
