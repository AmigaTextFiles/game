// Generic control stuff (keyboard+joystick)

#include <stdio.h>		// kbhit, getch
#include <stdlib.h>
#include "control.h"

#include "syscall.h"



// Key names

static const char *joynames[] = {
	"",
	"[]",
	"/\\",
	"O",
	"X",
	"Up",
	"Down",
	"Left",
	"Right",
	"Start",
	"Select",
	"L trigger",
	"R trigger",
	"Hold",
};

static int joybits[] = {
	0,
	CTRL_SQUARE,
	CTRL_TRIANGLE,
	CTRL_CIRCLE,
	CTRL_CROSS,
	CTRL_UP,
	CTRL_DOWN,
	CTRL_LEFT,
	CTRL_RIGHT,
	CTRL_START,
	CTRL_SELECT,
	CTRL_LTRIGGER,
	CTRL_RTRIGGER,
	CTRL_HOLD,
};

static int usejoy;

static int flag_to_index(unsigned long flag){
	int index = 0;
	unsigned long bit = 1;

	while(!((bit<<index)&flag) && index<31) ++index;
	return index;
}

void control_exit(void)
{
}



void control_init(int joy_enable)
{
	usejoy = joy_enable;
}



int control_usejoy(int enable)
{
	usejoy = enable;
	return 0;
}


int control_getjoyenabled(void)
{
	return usejoy;
}




void control_setkey(s_playercontrols * pcontrols, unsigned int flag, int key){
	if(!pcontrols) return;
	pcontrols->settings[flag_to_index(flag)] = key;
	pcontrols->keyflags = pcontrols->newkeyflags = 0;
}

static int lastkey;
int keyboard_getlastkey(void)
{
	int ret = lastkey;
	lastkey = 0;
}


// Scan input for newly-pressed keys.
// Return value:
// 0  = no key was pressed
// >0 = key code for pressed key
// <0 = error
int control_scankey(void)
{
	static int ready = 0;
	int b=0;
	int i;

	b = g_getpad();

	if(ready && b){
		ready = 0;
		for(i=1;i<sizeof(joybits)/sizeof(joybits[0]);i++) {
			if (b & joybits[i]) return i;
		}
		return -1;
	}
	ready = (!(b));
	return 0;
}


char * control_getkeyname(unsigned int keycode)
{
	if (keycode<sizeof(joynames)/sizeof(joynames[0])) return joynames[keycode];
	return "..";
}







void control_update(s_playercontrols ** playercontrols, int numplayers){

	unsigned long k;
	unsigned long i;
	int player;
	int t;
	s_playercontrols * pcontrols;
	int kb_break = 0; //keyboard_checkbreak();

	int buttons = g_getpad();
	
	for(player=0; player<numplayers; player++){

		pcontrols = playercontrols[player];

		k = 0;
		pcontrols->kb_break = 0;

		for(i=0;i<32;i++) {
			t = pcontrols->settings[i];
			if (buttons & joybits[t]) k |= (1<<i);
		}

		pcontrols->newkeyflags = k & (~pcontrols->keyflags);
		pcontrols->keyflags = k;
	}
}
