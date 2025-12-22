//=========================================================================
//=========================================================================
//
//	Daleks - game & level init & free routines
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	"Daleks.h"

//=========================================================================
// void newGame(void)
//
// Initialise for a new game
//=========================================================================
void newGame(
				void
			)
{
	StateInfo.gs_level = 1;
	StateInfo.gs_score = 0;
}


//=========================================================================
// void newLevel(void)
//
// Initialise for a new level
//=========================================================================
void newLevel(
				void
			 )
{
	StateInfo.gs_ndal  = 2;
	StateInfo.gs_count = 0;

	setGameState(GS_LEVELINTRO);
	levelIntro();
}
