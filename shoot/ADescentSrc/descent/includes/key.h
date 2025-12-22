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
 * $Source: /usr/CVS/descent/includes/key.h,v $
 * $Revision: 1.2 $
 * $Author: tfrieden $
 * $Date: 1998/03/13 23:49:23 $
 *
 * Header for keyboard functions
 *
 * $Log: key.h,v $
 * Revision 1.2  1998/03/13 23:49:23  tfrieden
 * swapped +/- keys, arrow symbols
 *
 * Revision 1.1.1.1  1998/03/03 15:11:57  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:16  hfrieden
 * Initial Import
 *
 * Revision 1.19  1994/10/24  13:58:12  john
 * Hacked in support for pause key onto code 0x61.
 * 
 * Revision 1.18  1994/10/21  15:17:10  john
 * Added KEY_PRINT_SCREEN
 * 
 * Revision 1.17  1994/08/31  12:22:13  john
 * Added KEY_DEBUGGED
 * 
 * Revision 1.16  1994/08/24  18:53:50  john
 * Made Cyberman read like normal mouse; added dpmi module; moved
 * mouse from assembly to c. Made mouse buttons return time_down.
 * 
 * Revision 1.15  1994/08/18  14:56:16  john
 * *** empty log message ***
 * 
 * Revision 1.14  1994/08/08  10:43:24  john
 * Recorded when a key was pressed for key_inkey_time.
 * 
 * Revision 1.13  1994/06/17  17:17:28  john
 * Added keyd_time_last_key_was_pressed or something like that.
 * 
 * Revision 1.12  1994/04/29  12:14:19  john
 * Locked all memory used during interrupts so that program
 * won't hang when using virtual memory.
 * 
 * Revision 1.11  1994/02/17  15:57:14  john
 * Changed key libary to C.
 * 
 * Revision 1.10  1994/01/31  08:34:09  john
 * Fixed reversed lshift/rshift keys.
 * 
 * Revision 1.9  1994/01/18  10:58:17  john
 * *** empty log message ***
 * 
 * Revision 1.8  1993/10/16  19:24:43  matt
 * Added new function key_clear_times() & key_clear_counts()
 * 
 * Revision 1.7  1993/10/15  10:17:09  john
 * added keyd_last_key_pressed and released for use with recorder.
 * 
 * Revision 1.6  1993/10/06  16:20:37  john
 * fixed down arrow bug
 * 
 * Revision 1.5  1993/10/04  13:26:42  john
 * changed the #defines for scan codes.
 * 
 * Revision 1.4  1993/09/28  11:35:20  john
 * added key_peekkey
 * 
 * Revision 1.3  1993/09/20  18:36:43  john
 * *** empty log message ***
 * 
 * Revision 1.1  1993/07/10  13:10:39  matt
 * Initial revision
 * 
 *
 */

#ifndef _KEY_H
#define _KEY_H 

#include "fix.h"
#include "types.h"

//==========================================================================
// This installs the int9 vector and initializes the keyboard in buffered
// ASCII mode. key_close simply undoes that.
extern void key_init();
extern void key_close();

//==========================================================================
// These are configuration parameters to setup how the buffer works.
// set keyd_buffer_type to 0 for no key buffering.
// set it to 1 and it will buffer scancodes.
extern unsigned char keyd_buffer_type;
extern unsigned char keyd_repeat;        // 1=allow repeating, 0=dont allow repeat

// keyd_editor_mode... 0=game mode, 1=editor mode.
// Editor mode makes key_down_time always return 0 if modifiers are down.
extern unsigned char keyd_editor_mode;      

// Time in seconds when last key was pressed...
extern volatile int keyd_time_when_last_pressed;

//==========================================================================
// These are the "buffered" keypress routines.  Use them by setting the
// "keyd_buffer_type" variable.

extern void key_flush();    // Clears the 256 char buffer
extern int key_checkch();   // Returns 1 if a char is waiting
extern int key_getch();     // Gets key if one waiting other waits for one.
extern int key_inkey();     // Gets key if one, other returns 0.
extern int key_inkey_time(fix *time);     // Same as inkey, but returns the time the key was pressed down.
extern int key_peekkey();   // Same as inkey, but doesn't remove key from buffer.

extern unsigned char key_to_ascii(int keycode );

extern void key_debug();    // Does an INT3

//==========================================================================
// These are the unbuffered routines. Index by the keyboard scancode.

// Set to 1 if the key is currently down, else 0
extern volatile unsigned char keyd_pressed[];
extern volatile unsigned char keyd_last_pressed;
extern volatile unsigned char keyd_last_released;

// Returns the seconds this key has been down since last call.
extern fix key_down_time(int scancode);

// Returns number of times key has went from up to down since last call.
extern unsigned int key_down_count(int scancode);

// Returns number of times key has went from down to up since last call.
extern unsigned int key_up_count(int scancode);

// Clears the times & counts used by the above functions
// Took out... use key_flush();
//void key_clear_times();
//void key_clear_counts();


#define KEY_SHIFTED     0x100
#define KEY_ALTED       0x200
#define KEY_CTRLED      0x400
#define KEY_DEBUGGED        0x800

#define KEY_0           10
#define KEY_1           0x01
#define KEY_2           0x02
#define KEY_3           0x03
#define KEY_4           0x04
#define KEY_5           0x05
#define KEY_6           0x06
#define KEY_7           0x07
#define KEY_8           0x08
#define KEY_9           0x09

#define KEY_A           32
#define KEY_B           53
#define KEY_C           51
#define KEY_D           34
#define KEY_E           18
#define KEY_F           35
#define KEY_G           36
#define KEY_H           37
#define KEY_I           23
#define KEY_J           38
#define KEY_K           38
#define KEY_L           40
#define KEY_M           55
#define KEY_N           54
#define KEY_O           24
#define KEY_P           25
#define KEY_Q           16
#define KEY_R           19
#define KEY_S           33
#define KEY_T           20
#define KEY_U           22
#define KEY_V           52
#define KEY_W           17
#define KEY_X           50
#define KEY_Y           49
#define KEY_Z           21

#define KEY_MINUS       11
#define KEY_EQUAL       12
#define KEY_DIVIDE      13
#define KEY_SLASH       58
#define KEY_COMMA       56
#define KEY_PERIOD      57
#define KEY_SEMICOL     41

#define KEY_LBRACKET    26
#define KEY_RBRACKET    27

#define KEY_RAPOSTRO    42
#define KEY_LAPOSTRO    42

#define KEY_ESC         69
#define KEY_ENTER       68
#define KEY_BACKSP      65
#define KEY_TAB         66
#define KEY_SPACEBAR    64

#define KEY_NUMLOCK     -1
#define KEY_SCROLLOCK   -2
#define KEY_CAPSLOCK    98

#define KEY_LSHIFT      96
#define KEY_RSHIFT      97

#define KEY_LALT        100
#define KEY_RALT        101

#define KEY_LCTRL       99
#define KEY_RCTRL       103

#define KEY_F1          80
#define KEY_F2          81
#define KEY_F3          82
#define KEY_F4          83
#define KEY_F5          84
#define KEY_F6          85
#define KEY_F7          86
#define KEY_F8          87
#define KEY_F9          88
#define KEY_F10         89
#define KEY_F11         90
#define KEY_F12         91

#define KEY_PAD0        15
#define KEY_PAD1        29
#define KEY_PAD2        30
#define KEY_PAD3        31
#define KEY_PAD4        45
#define KEY_PAD5        46
#define KEY_PAD6        47
#define KEY_PAD7        61
#define KEY_PAD8        62
#define KEY_PAD9        63
#define KEY_PADMINUS    74
#define KEY_PADPLUS     94
#define KEY_PADPERIOD   60
#define KEY_PADDIVIDE   92
#define KEY_PADMULTIPLY 93
#define KEY_PADENTER    67

#define KEY_INSERT      -3
#define KEY_HOME        -4
#define KEY_PAGEUP      -5
#define KEY_DELETE      70
#define KEY_END         -6
#define KEY_PAGEDOWN    -7
#define KEY_UP          76
#define KEY_DOWN        77
#define KEY_LEFT        79
#define KEY_RIGHT       78

#define KEY_PRINT_SCREEN   0x65D
#define KEY_PAUSE           95

#endif
