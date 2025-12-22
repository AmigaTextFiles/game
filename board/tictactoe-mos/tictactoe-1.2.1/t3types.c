#include "t3types.h"	/* don't really have to include it */

/*
 * File global variables
 */
static signed char _piece[3] = {'O', '_', 'X'};

/*
 * App global variables
 */
#ifndef _SIZE_
#	define _SIZE_	3
#endif

int SIZE = _SIZE_;
signed char **board;
int **scores;

signed char *piece = &_piece[1];

enum players YOU=NONE;
enum players ME=NONE;
