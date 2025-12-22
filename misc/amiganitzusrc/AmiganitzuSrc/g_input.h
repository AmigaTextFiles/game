/* g_input.h */


#ifndef _G_INPUT_H_
#define _G_INPUT_H_

#include <exec/types.h>

/* input state struct */
struct input_state
{
	WORD b1;
	WORD b2;
	WORD mx;
	WORD my;
	UWORD key;
	UWORD keys[128];
};

void set_mouse_pos(WORD, WORD);
int init_input(void);
void close_input(void);


#endif

