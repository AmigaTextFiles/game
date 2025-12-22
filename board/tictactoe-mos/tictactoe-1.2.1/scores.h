#include "t3types.h"

#ifndef __SCORES__H__
#define __SCORES__H__

/* 
 * How to score each move.  Depending on which rule is 
 * satisfied, one or more of the following will be awarded.
 */
enum scores {
	WIN_SCORE    = 40, 	/* Winning move */
	BLOCK_SCORE  = 20, 	/* Block opponent's win */
	CENTRE_SCORE = 16, 	/* Capture centre */
	CORNER_SCORE =  4, 	/* Capture corner */
	LOS_SCORE    = 10, 	/* Self line of sight */
	STICKY_SCORE = 14	/* Stick to opponent */
};

int get_winning_position(int who);
int set_scores(int who);

#endif
