#include "t3types.h"
#ifndef __T3VISUAL__H__
#define __T3VISUAL__H__

/*
 * These functions carry out the display logic
 * show_scores is generally used for debugging
 *
 * show_board displays the current board
 *
 * show_result displays who has won or lost
 *
 * this file, along with messages control how
 * things are displayed.  To make a gui frontend
 * only these two need to be changed.  the API
 * remains the same
 */

void show_scores();
void show_board(); 
void show_result(enum players result);
#endif
