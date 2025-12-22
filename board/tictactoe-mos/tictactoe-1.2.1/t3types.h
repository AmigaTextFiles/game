#ifndef __T3TYPES__H__
#define __T3TYPES__H__

/* Type declarations */

/*
 * Identifies who the current player is, as well
 * as who the winner is.
 * Selecting -1 and +1 allows me to use the player
 * value as an index into a -1 anchored array of
 * moves.  The array contains function pointers
 * that carry out the actual move.
 */
enum players {
	O    = -1, 
	X    =  1, 
	DRAW = 99, 
	NONE =  0
};

/* Global variables */

extern int SIZE;	/* defaults to 3, can be set at run or compile time */

extern signed char *piece;	/* array of O, _, X. index starts at -1 */
extern signed char **board;	/* the current state of the board */
extern int **scores;		/* scores for every possible move
				   this should possibly be private */

/* Identify who is X and who is O */
extern enum players YOU;
extern enum players ME;

#endif
