/******************************************************************************
BINIAX GAME-RELATED DEFINITIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

#ifndef _BNX_GAME_H
#define _BNX_GAME_H

/******************************************************************************
INCLUDES
******************************************************************************/

#include "types.h"

/******************************************************************************
DEFINITIONS
******************************************************************************/

/******************************************************************************
CONSTANTS
******************************************************************************/

#define cGridX			5		/* X size of the grid */
#define cGridY			7		/* Y size of the grid */
#define cMaxElements	4		/* Maximum num. of elements */
#define cInitLines		3		/* Lines to add on start... */
#define cDeltaTime		60		/* Time for game step in ms */
#define cMaxScroll		70		/* Slowest scroll in steps. */
#define cMinScroll		18		/* Fastest scroll in steps. */
#define cScoreStep		10		/* How to increas the score */
#define cShakeAfter		8		/* Shake after X remainig ticks to scroll  */
#define cElCorrect		15		/* Elements to take to speed-up the game   */
#define cMaxSpeedScore	5000	/* Score, at each the max speed is reached */

enum _BNX_Messages 
{
	cTextIngameScore = 0,
	cTextGameOver,
	cTextBestScore
};

enum _BNX_Options 
{
	cOptionContinue = 0,
	cOptionNew,
	cOptionQuit,
	cMaxOptions
};

/******************************************************************************
GAME DATA
******************************************************************************/

/* Player definition */
typedef struct BNX_PLAYER 
{
	BNX_INT8	x;								/* X position in grid */
	BNX_INT8	y;								/* Y position in grid */
	BNX_INT8	e;								/* Element index */
} BNX_PLAYER;

/* Game definition */
typedef struct BNX_GAME
{
	BNX_PLAYER	player;							/* The player */

	BNX_UINT8	grid[ cGridX ][ cGridY ];		/* Game field / grid */

	BNX_INT32	score;							/* Score */
	BNX_INT32	best;							/* Best score */

	BNX_INT16	scroll;							/* Current scroll step */
	BNX_INT16	speed;							/* Current game speed */

	BNX_BOOL	ingame;							/* Game is running */

	BNX_UINT32	sounds;							/* Flag with sounds to play */

	BNX_UINT8	message;						/* Type of message to show */

} BNX_GAME;
/******************************************************************************
For the grid definition assume, that indexes in grid are as follows :
........[ cGridX-1][ cGridY-1 ]
...............................
...............................
[ 0 ][ 0 ].....................
The scroll down removes the first row (with index 0).

Pairs are coded in the BYTE as xxxxyyyy. You can get left element of the
pair with (PAIR >> 4) and the right one with (PAIR & 0xf)
"Legal" pairs consists of two DIFFERENT elements !
Pair 0-0 (or just 0) is an empty space.
******************************************************************************/

#define pairLeft( pair )	( (pair) >> 4 )
#define pairRight( pair )	( (pair) & 0xf )

#define soundMask( index )	( 1 << ( index ) )

#endif
