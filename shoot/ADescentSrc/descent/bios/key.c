/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/bios/key.c,v $
 * $Revision: 1.3 $
 * $Author: tfrieden $
 * $Date: 1998/03/13 23:48:44 $
 * 
 * Functions for keyboard handler.
 * 
 * $Log: key.c,v $
 * Revision 1.3  1998/03/13 23:48:44  tfrieden
 * fixed hat problems
 *
 * Revision 1.2  1998/03/13 14:45:07  hfrieden
 * Modified joystick support
 *
 * Revision 1.2  1998/02/28 00:36:00  hfrieden
 * Added joystick handler stuff
 *
 * Revision 1.1.1.1  1998/02/13 20:20:11  hfrieden
 * Initial Import
 *
 * 
 */

//#define PASS_KEYS_TO_BIOS 1           //if set, bios gets keys

#pragma off (unreferenced)
static char rcsid[] = "$Id: key.c,v 1.3 1998/03/13 23:48:44 tfrieden Exp $";
#pragma on (unreferenced)

#include <stdlib.h>
#include <stdio.h>
#include <intuition/intuition.h>
#include <inline/intuition.h>
#include <exec/exec.h>
#include <inline/exec.h>

#include "error.h"
#include "key.h"
#include "timer.h"

#define KEY_BUFFER_SIZE 16

//-------- Variable accessed by outside functions ---------
unsigned char               keyd_buffer_type;       // 0=No buffer, 1=buffer ASCII, 2=buffer scans
unsigned char               keyd_repeat;
unsigned char               keyd_editor_mode;
volatile unsigned char  keyd_last_pressed;
volatile unsigned char  keyd_last_released;
volatile unsigned char  keyd_pressed[256];
volatile int                keyd_time_when_last_pressed;

typedef struct keyboard {
	unsigned short      keybuffer[KEY_BUFFER_SIZE];
	fix                 time_pressed[KEY_BUFFER_SIZE];
	fix                 TimeKeyWentDown[256];
	fix                 TimeKeyHeldDown[256];
	unsigned int        NumDowns[256];
	unsigned int        NumUps[256];
	unsigned int        keyhead, keytail;
	unsigned char       E0Flag;
	unsigned char       E1Flag;
	int                 in_key_handler;
//    void               *(handler());
} keyboard;

static volatile keyboard key_data;

extern struct Library *IntuitionBase;
extern struct Library *SysBase;
#ifndef VIRGIN
extern struct Window *win;
#endif

static unsigned char Installed=0;

unsigned char ascii_table[128] = 
{ '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\\',255 , '0',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 255, '1' , '2', '3',
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',  39, 255, 255, '4',  '5', '6',
  255, 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 255, '.', '7',  '8', '9',
  ' ', 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255};


unsigned char shifted_ascii_table[128] = 
{ '~', '!', '@', '"', '$', '%', '^', '&', '*', '(', ')', '_', '+', '|',255 ,255,
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', 255, '1' , '2', '3',
  'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', 255, 255, '4',  '5', '6',
  255, 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 255, 255, '7',  '8', '9',
  ' ', 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255,
  255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  255, 255};

void keyboard_init(void)
{
}

void keyboard_update(void)
{
	struct IntuiMessage *msg = NULL;
	int scancode, newstate;
	static int last_tick, this_tick;
	extern void (*joy_handler)(int);

#ifdef VIRGIN
	extern struct MsgPort *MyViewMsgPort;
	while (msg = (struct IntuiMessage *)GetMsg(MyViewMsgPort)) {
#else
	while (msg = (struct IntuiMessage *)GetMsg(win->UserPort)) {
#endif
		switch (msg->Class) {
			case IDCMP_RAWKEY:
				scancode = (int)(msg->Code)&0x7f;
				newstate = 1-(((msg->Code) & 0x80) >> 7);
				kbd_my_handler(scancode, newstate);
				break;
		}
		ReplyMsg((struct Message *)msg);
	}
	if (joy_handler) {
		this_tick = timer_get_fixed_secondsX();
		joy_handler((this_tick-last_tick));
		last_tick = this_tick;
	}
}

void keyboard_close(void)
{
}

void keyboard_seteventhandler(void *(func(int, int)))
{
//    key_data.handler = (void *)func;
}



extern unsigned char key_to_ascii(int keycode )
{
	int shifted;

	shifted = keycode & KEY_SHIFTED;
	keycode &= 0xFF;

	if ( keycode>=127 || keycode == 0 )
		return 255;

	if (shifted)
		return shifted_ascii_table[keycode];
	else
		return ascii_table[keycode];
}

void key_clear_bios_buffer_all()
{
}

void key_clear_bios_buffer()
{
}

void key_flush()
{
	int i;
	fix CurTime;

	// Clear the BIOS buffer
	key_clear_bios_buffer();

	key_data.keyhead = key_data.keytail = 0;

	//Clear the keyboard buffer
	for (i=0; i<KEY_BUFFER_SIZE; i++ )  {
		key_data.keybuffer[i] = 0;
		key_data.time_pressed[i] = 0;
	}
	
	//Clear the keyboard array

	CurTime =timer_get_fixed_secondsX();

	for (i=0; i<256; i++ )  {
		keyd_pressed[i] = 0;
		key_data.TimeKeyWentDown[i] = CurTime;
		key_data.TimeKeyHeldDown[i] = 0;
		key_data.NumDowns[i]=0;
		key_data.NumUps[i]=0;
	}
}

int add_one( int n )
{
	n++;
	if ( n >= KEY_BUFFER_SIZE ) n=0;
	return n;
}

// Returns 1 if character waiting... 0 otherwise
int key_checkch()
{
	int is_one_waiting = 0;

	keyboard_update();

	key_clear_bios_buffer();

	if (key_data.keytail!=key_data.keyhead)
		is_one_waiting = 1;
	return is_one_waiting;
}

int key_inkey()
{
	int key = 0;

	keyboard_update(); // Ya never know
	
	key_clear_bios_buffer();

	if (key_data.keytail!=key_data.keyhead) {
		key = key_data.keybuffer[key_data.keyhead];
		key_data.keyhead = add_one(key_data.keyhead);
	}
	return key;
}

int key_inkey_time(fix * time)
{
	int key = 0;

	key_clear_bios_buffer();

	if (key_data.keytail!=key_data.keyhead) {
		key = key_data.keybuffer[key_data.keyhead];
		*time = key_data.time_pressed[key_data.keyhead];
		key_data.keyhead = add_one(key_data.keyhead);
	}
	return key;
}



int key_peekkey()
{
	int key = 0;

	key_clear_bios_buffer();

	if (key_data.keytail!=key_data.keyhead) {
		key = key_data.keybuffer[key_data.keyhead];
	}
	return key;
}

// If not installed, uses BIOS and returns getch();
//  Else returns pending key (or waits for one if none waiting).
int key_getch()
{
	int dummy=0;
	
	if (!Installed)
		return getc(stdin);

	while (!key_checkch())
		dummy++;
	return key_inkey();
}

unsigned int key_get_shift_status()
{
	unsigned int shift_status = 0;

	key_clear_bios_buffer();

	if ( keyd_pressed[KEY_LSHIFT] || keyd_pressed[KEY_RSHIFT] )
		shift_status |= KEY_SHIFTED;

	if ( keyd_pressed[KEY_LALT] || keyd_pressed[KEY_RALT] )
		shift_status |= KEY_ALTED;

	if ( keyd_pressed[KEY_LCTRL] || keyd_pressed[KEY_RCTRL] )
		shift_status |= KEY_CTRLED;

#ifndef NDEBUG
	if (keyd_pressed[KEY_DELETE])
		shift_status |=KEY_DEBUGGED;
#endif


	return shift_status;
}

// Returns the number of seconds this key has been down since last call.
fix key_down_time(int scancode) {
	fix time_down, time;

	if ((scancode<0)|| (scancode>255)) return 0;

#ifndef NDEBUG
	if (keyd_editor_mode && key_get_shift_status() )
		return 0;  
#endif

	if ( !keyd_pressed[scancode] )  {
		time_down = key_data.TimeKeyHeldDown[scancode];
		key_data.TimeKeyHeldDown[scancode] = 0;
	} else  {
		time = timer_get_fixed_secondsX();
		time_down =  time - key_data.TimeKeyWentDown[scancode];
		key_data.TimeKeyWentDown[scancode] = time;
	}

	return time_down;
}

// Returns number of times key has went from up to down since last call.
unsigned int key_down_count(int scancode)   {
	int n;

	if ((scancode<0)|| (scancode>255)) return 0;

	n = key_data.NumDowns[scancode];
	key_data.NumDowns[scancode] = 0;

	return n;
}


// Returns number of times key has went from down to up since last call.
unsigned int key_up_count(int scancode) {
	int n;

	if ((scancode<0)|| (scancode>255)) return 0;

	n = key_data.NumUps[scancode];
	key_data.NumUps[scancode] = 0;

	return n;
}

// Use intrinsic forms so that we stay in the locked interrup code.

static void kbd_my_handler(int scancode, int newstate)
{
	int truecode;
	int breakbit,temp,keycode;
	
	/*if (scancode<0||scancode>127){
		fprintf(stderr,"kbd_my_handler: Scancode out of range: %d\n",scancode);
		return;
	}*/
	truecode=scancode+((1-newstate)<<7);
	switch( truecode )  {
/*
	case 0xE0:
		key_data.E0Flag = 0x80;
		break;
*/
	default:
		// Parse truecode and break bit
		/*if (key_data.E1Flag > 0 )   {       // Special code for Pause, which is E1 1D 45 E1 9D C5
			key_data.E1Flag--;
			if ( truecode == 0x1D ) {
				truecode    = KEY_PAUSE;
				breakbit    = 0;
			} else if ( truecode == 0x9d ) {
				truecode    = KEY_PAUSE;
				breakbit    = 1;
			} else {
				break;      // skip this keycode
			}
		} else if ( truecode==0xE1 )    {
			key_data.E1Flag = 2;
			break;
		} else */{
			breakbit    = truecode & 0x80;      // Get make/break bit
			truecode &= 0x7f;                       // Strip make/break bit off of truecode
			//truecode |= key_data.E0Flag;                    // Add in extended key code
		}
		key_data.E0Flag = 0;                                // Clear extended key code

		if (breakbit)   {
			// Key going up
			keyd_last_released = truecode;
			keyd_pressed[truecode] = 0;
			key_data.NumUps[truecode]++;
			temp = 0;
			temp |= keyd_pressed[KEY_LSHIFT] || keyd_pressed[KEY_RSHIFT];
			temp |= keyd_pressed[KEY_LALT] || keyd_pressed[KEY_RALT];
			temp |= keyd_pressed[KEY_LCTRL] || keyd_pressed[KEY_RCTRL];
#ifndef NDEBUG
			temp |= keyd_pressed[KEY_DELETE];
			if ( !(keyd_editor_mode && temp) )
#endif      // NOTICE LINK TO ABOVE IF!!!!
				key_data.TimeKeyHeldDown[truecode] += timer_get_fixed_secondsX() - key_data.TimeKeyWentDown[truecode];
		} else {
			// Key going down
			keyd_last_pressed = truecode;
			keyd_time_when_last_pressed = timer_get_fixed_secondsX();
			if (!keyd_pressed[truecode])    {
				// First time down
				key_data.TimeKeyWentDown[truecode] = timer_get_fixed_secondsX();
				keyd_pressed[truecode] = 1;
				key_data.NumDowns[truecode]++;
#ifndef NDEBUG
				if ( (keyd_pressed[KEY_LSHIFT]) && (truecode == KEY_BACKSP) )   {
					keyd_pressed[KEY_LSHIFT] = 0;
				}
#endif
			} else if (!keyd_repeat) {
				// Don't buffer repeating key if repeat mode is off
				truecode = 0xAA;        
			} 

			if ( truecode!=0xAA ) {
				keycode = truecode;

				if ( keyd_pressed[KEY_LSHIFT] || keyd_pressed[KEY_RSHIFT] )
					keycode |= KEY_SHIFTED;

				if ( keyd_pressed[KEY_LALT] || keyd_pressed[KEY_RALT] )
					keycode |= KEY_ALTED;

				if ( keyd_pressed[KEY_LCTRL] || keyd_pressed[KEY_RCTRL] )
					keycode |= KEY_CTRLED;

#ifndef NDEBUG
				if ( keyd_pressed[KEY_DELETE] )
					keycode |= KEY_DEBUGGED;
#endif
				temp = key_data.keytail+1;
				if ( temp >= KEY_BUFFER_SIZE ) temp=0;

				if (temp!=key_data.keyhead) {
					key_data.keybuffer[key_data.keytail] = keycode;
					key_data.time_pressed[key_data.keytail] = keyd_time_when_last_pressed;
					key_data.keytail = temp;
				}
			}
		}
	}
}

void key_handler_end()  {       // Dummy function to help calculate size of keyboard handler function
}

void key_init()
{
	// Initialize queue
	keyd_time_when_last_pressed = timer_get_fixed_seconds();
	keyd_buffer_type = 1;
	keyd_repeat = 1;
	key_data.in_key_handler = 0;
	key_data.E0Flag = 0;
	key_data.E1Flag = 0;

	// Clear the keyboard array
	key_flush();

	if (Installed) return;
	Installed = 1;

	keyboard_init();
	keyboard_seteventhandler(kbd_my_handler);
	atexit( key_close );
}

void key_close()
{
	if (!Installed) return;
	Installed = 0;

	keyboard_close();
}

