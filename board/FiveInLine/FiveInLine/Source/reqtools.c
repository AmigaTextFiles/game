#include <exec/exec.h>
#include <proto/exec.h>

#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <libraries/reqtools.h>
#include <proto/reqtools.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include <stdio.h>

#include "fil.h"

extern struct Screen	*Scr;
extern struct Window	*mwWnd;
extern UWORD			offx;
extern UWORD			offy;
extern int				scoreboxheight;
extern int				boardsize;

int openreqtools ( void )
{
	if ( ! ( ReqToolsBase = ( struct ReqToolsBase * ) OpenLibrary ( REQTOOLSNAME, 38 ) ) ) {
		printf ( "reqtools.library V38 or higher not found\n" );
		return ( 10 );
	}
}

void closereqtools ( void )
{
	if ( ReqToolsBase != NULL ) 
		CloseLibrary ( ( struct Library * ) ReqToolsBase );	
}

BOOL reqbegin ( void )
{
	BOOL startplayer;

	startplayer = rtEZRequestTags ( "Do you want to begin?", "Yes|No",
		NULL, NULL,
		RTEZ_ReqTitle, "FiveInLine 2.2",
		TAG_END );

	return( startplayer );
}

void showresult ( char * reqtext )
{

	rtEZRequestTags ( reqtext , "Ok",
		NULL, NULL,
		RT_ReqPos, REQPOS_TOPLEFTWIN,
		RT_LeftOffset, offx + 2 * INTERWIDTH + boardsize * BOXSIZE,
		RT_TopOffset, offy + 2 * INTERHEIGHT + scoreboxheight + 50,
		RT_Window, mwWnd,
		RT_LockWindow, TRUE, 
		RTEZ_ReqTitle, "Game over",
		TAG_END );
}

int showabout ( void )
{

	rtEZRequestTags ( "Written by Njål Fisketjøn using...\n\n"
					"SAS C++ 6.5\n"
					"(C) Copyright(1992) SAS Institute,Inc.\n\n"
					"GadToolsBoxV2.0b\n"
					"(C)Copyright 1991-93 Jaba Development\n\n"
					"reqtools.library\n(C) Copyright Nico François\n",
					"OK", NULL, NULL,
					RTEZ_ReqTitle, "FiveInLine version 2.2 (1994)",
					RT_ReqPos, REQPOS_CENTERWIN,
					RTEZ_Flags, EZREQF_CENTERTEXT, 
					RT_Window, mwWnd, 
					RT_LockWindow, TRUE,
					TAG_END );

	return ( TRUE );
}
