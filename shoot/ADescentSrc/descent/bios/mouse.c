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
 * $Source: /usr/CVS/descent/bios/mouse.c,v $
 * $Revision: 1.4 $
 * $Author: tfrieden $
 * $Date: 1998/08/09 23:02:11 $
 * 
 * Functions to access Mouse and Cyberman...
 * 
 * $Log: mouse.c,v $
 * Revision 1.4  1998/08/09 23:02:11  tfrieden
 * Some functions used by the editor
 *
 * Revision 1.3  1998/03/14 13:42:40  hfrieden
 * Fixed merge conflicts
 *
 * Revision 1.2  1998/03/13 23:48:49  tfrieden
 * fixed hat problems
 *
 * Revision 1.1.1.1  1998/03/03 15:11:49  nobody
 * reimport after crash from backup
 *
 */


#pragma off (unreferenced)
static char rcsid[] = "$Id: mouse.c,v 1.4 1998/08/09 23:02:11 tfrieden Exp $";
#pragma on (unreferenced)

#include <clib/timer_protos.h>
#include <inline/intuition.h>
#include <intuition/intuition.h>
#include <inline/exec.h>
#include <exec/exec.h>
#include <exec/interrupts.h>
#include <devices/input.h>
#include <devices/inputevent.h>
#include <clib/alib_protos.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "error.h"
#include "fix.h"
#include "mouse.h"
#include "timer.h"

#define ME_CURSOR_MOVED (1<<0)
#define ME_LB_P             (1<<1)
#define ME_LB_R             (1<<2)
#define ME_RB_P             (1<<3)
#define ME_RB_R             (1<<4)
#define ME_MB_P             (1<<5)
#define ME_MB_R             (1<<6)
#define ME_OB_P             (1<<7)
#define ME_OB_R             (1<<8)
#define ME_X_C          (1<<9)
#define ME_Y_C          (1<<10)
#define ME_Z_C          (1<<11)
#define ME_P_C          (1<<12)
#define ME_B_C          (1<<13)
#define ME_H_C          (1<<14)
#define ME_O_C          (1<<15)

#define MOUSE_MAX_BUTTONS   11

extern int gr_mouse_reported;

typedef struct event_info {
	short x;
	short y;
	short z;
	short pitch;
	short bank;
	short heading;
	ushort button_status;
	ushort device_dependant;
} event_info;

typedef struct mouse_info {
	fix     ctime;
	ubyte       cyberman;
	int     num_buttons;
	ubyte       pressed[MOUSE_MAX_BUTTONS];
	fix     time_went_down[MOUSE_MAX_BUTTONS];
	fix     time_held_down[MOUSE_MAX_BUTTONS];
	uint        num_downs[MOUSE_MAX_BUTTONS];
	uint        num_ups[MOUSE_MAX_BUTTONS];
	event_info *x_info;
	ushort  button_status;
	int x,y;
} mouse_info;

typedef struct cyberman_info {
	ubyte device_type;
	ubyte major_version;
	ubyte minor_version;
	ubyte x_descriptor;
	ubyte y_descriptor;
	ubyte z_descriptor;
	ubyte pitch_descriptor;
	ubyte roll_descriptor;
	ubyte yaw_descriptor;
	ubyte reserved;
} cyberman_info;

static mouse_info Mouse;

extern struct Library *IntuitionBase;
extern struct Library *SysBase;
extern struct Library *TimerBase;
#ifndef VIRGIN
extern struct Screen *scr;
#endif
struct Interrupt *inputHandler;
struct IOStdReq *inputReqBlk;
struct MsgPort *inputPort;
BYTE port = 0;
struct IEPointerPixel NewPixel;
struct InputEvent FakeEvent;

static int Mouse_installed = 0;
char NameString[] = "Descent input handler";

extern int NumAxis;


void mouse_handler_end (void)  // dummy functions
{
}

struct InputEvent *  __saveds __interrupt
mouseHandlerCode(struct InputEvent *oldEventChain __asm("a0"), void *data __asm("a1"))
{
#ifndef VIRGIN
	mouse_info *mouse = (mouse_info *)data;
	struct InputEvent *akt;
	struct timeval *tv;
	fix time;
	int *x = 0;

	tv = &(oldEventChain->ie_TimeStamp);
	time = (fix)(tv->tv_secs&0xffff)<<16;
	time = (fix)(((float)tv->tv_micro/1000000.0)*65536.0)+time;

	mouse->ctime = time;

	for (akt = oldEventChain; akt; akt = akt->ie_NextEvent) {
		if (akt->ie_Class == IECLASS_RAWMOUSE) {
/*            if (akt->ie_Qualifier == IEQUALIFIER_RELATIVEMOUSE) {
				mouse->x += akt->ie_X;
				mouse->y += akt->ie_Y;
			} else {
				mouse->x = akt->ie_X;
				mouse->y = akt->ie_Y;
			}*/
			switch(akt->ie_Code) {
				case IECODE_LBUTTON:
					mouse->pressed[MB_LEFT] = 1;
					mouse->time_went_down[MB_LEFT] = mouse->ctime;
					mouse->num_downs[MB_LEFT] ++;
					break;
				case IECODE_LBUTTON|IECODE_UP_PREFIX:
					mouse->pressed[MB_LEFT] = 0;
					mouse->time_held_down[MB_LEFT] += mouse->ctime - mouse->time_went_down[MB_LEFT];
					mouse->num_ups[MB_LEFT] ++;
					break;
				case IECODE_RBUTTON:
					mouse->pressed[MB_RIGHT] = 1;
					mouse->time_went_down[MB_RIGHT] = mouse->ctime;
					mouse->num_downs[MB_RIGHT] ++;
					break;
				case IECODE_RBUTTON|IECODE_UP_PREFIX:
					mouse->pressed[MB_RIGHT] = 0;
					mouse->time_held_down[MB_RIGHT] += mouse->ctime - mouse->time_went_down[MB_RIGHT];
					mouse->num_ups[MB_RIGHT] ++;
					break;
				case IECODE_MBUTTON:
					mouse->pressed[MB_MIDDLE] = 1;
					mouse->time_went_down[MB_MIDDLE] = mouse->ctime;
					mouse->num_downs[MB_MIDDLE] ++;
					break;
				case IECODE_MBUTTON|IECODE_UP_PREFIX:
					mouse->pressed[MB_MIDDLE] = 0;
					mouse->time_held_down[MB_MIDDLE] += mouse->ctime - mouse->time_went_down[MB_MIDDLE];
					mouse->num_ups[MB_MIDDLE] ++;
					break;
			}
		}
	}

	mouse->button_status = 0;
	if (mouse->pressed[MB_LEFT] != 0)    mouse->button_status |= MOUSE_LBTN;
	if (mouse->pressed[MB_RIGHT] != 0)   mouse->button_status |= MOUSE_RBTN;
	if (mouse->pressed[MB_MIDDLE] != 0)  mouse->button_status |= MOUSE_MBTN;

	return(oldEventChain);
#endif
}


//--------------------------------------------------------
// returns 0 if no mouse
//           else number of buttons
int mouse_init(int enable_cyberman)
{
	atexit( mouse_close );

	memset(&Mouse, 0, sizeof(mouse_info));
#ifndef VIRGIN

#ifdef DEBUG_MOUSE
	fprintf( stderr, "Initialising Mouse handler\n");
#endif

	inputPort = CreatePort(NULL, NULL);
	if (!inputPort) return 0;

#ifdef DEBUG_MOUSE
	fprintf( stderr, "Got port\n");
#endif

	inputHandler = malloc(sizeof(struct Interrupt));
	if (!inputHandler) {
		DeletePort(inputPort);
		return 0;
	}
#ifdef DEBUG_MOUSE
	fprintf( stderr, "Got Interrupt structure\n");
#endif

	inputReqBlk = (struct IOStdReq *)CreateExtIO(inputPort, sizeof(struct IOStdReq));
	if (!inputReqBlk) {
		DeletePort(inputPort);
		free(inputHandler);
		return 0;
	}

#ifdef DEBUG_MOUSE
	fprintf( stderr, "Got ExtIo\n");
#endif

	if (OpenDevice("input.device", NULL, (struct IORequest *)inputReqBlk, NULL)) {
		DeleteExtIO((struct IORequest *)inputReqBlk);
		DeletePort(inputPort);
		free(inputHandler);
		return 0;
	}

#ifdef DEBUG_MOUSE
	fprintf( stderr, "Installing Mouse handler\n");
#endif

/*    Mouse.x = scr->MouseX;
	Mouse.y = scr->MouseY; */

	inputHandler->is_Code = mouseHandlerCode;
	inputHandler->is_Data = (void *)&Mouse;
	inputHandler->is_Node.ln_Pri = 100;
	inputHandler->is_Node.ln_Name = (UBYTE *)NameString;
	inputReqBlk->io_Data = (APTR)inputHandler;
	inputReqBlk->io_Command = IND_ADDHANDLER;
	DoIO((struct IORequest *)inputReqBlk);

	Mouse_installed = 1;

#ifdef DEBUG_MOUSE
	fprintf(stderr, "Setting up fake events\n");
#endif

	FakeEvent.ie_EventAddress = (APTR)&NewPixel;
	FakeEvent.ie_NextEvent = NULL;
	FakeEvent.ie_Class = IECLASS_NEWPOINTERPOS;
	FakeEvent.ie_SubClass = IESUBCLASS_PIXEL;
	FakeEvent.ie_Code = IECODE_NOBUTTON;
	FakeEvent.ie_Qualifier = NULL;


#ifdef DEBUG_MOUSE
	fprintf( stderr, "Done\n");
#endif
#endif
	return 3;

}


void mouse_switch_on()
{

	if (Mouse_installed == 0 || NumAxis <= 2) return;

	port = 0;
	inputReqBlk->io_Data = &port;
	inputReqBlk->io_Flags = IOF_QUICK;
	inputReqBlk->io_Length = 1;
	inputReqBlk->io_Command = IND_SETMPORT;
	BeginIO((struct IORequest *)inputReqBlk);
	if (inputReqBlk->io_Error == 0)
		printf("Mouse on\n");
}


void mouse_switch_off()
{

	if (Mouse_installed == 0 || NumAxis <= 2) return;

	port = -1;
	inputReqBlk->io_Data = &port;
	inputReqBlk->io_Flags = IOF_QUICK;
	inputReqBlk->io_Length = 1;
	inputReqBlk->io_Command = IND_SETMPORT;
	BeginIO((struct IORequest *)inputReqBlk);
	if (inputReqBlk->io_Error == 0)
		printf("Mouse off\n");
}


void mouse_close()
{

	mouse_switch_on();

	Mouse_installed = 0;
#ifndef VIRGIN
	inputReqBlk->io_Data = (APTR) inputHandler;
	inputReqBlk->io_Command = IND_REMHANDLER;
	DoIO((struct IORequest *)inputReqBlk);

	CloseDevice((struct IORequest *)inputReqBlk);
	DeleteExtIO((struct IORequest *)inputReqBlk);
	DeletePort(inputPort);
	free(inputHandler);
#endif
}

int mouse_set_limits( int x1, int y1, int x2, int y2 )
{
	return 0;
}

void mouse_center()
{
#ifndef VIRGIN

	if (Mouse_installed == 0) return;
	if (gr_mouse_reported == 1) return;

	NewPixel.iepp_Screen = scr;
	NewPixel.iepp_Position.X = scr->Width / 2;
	NewPixel.iepp_Position.Y = scr->Height / 2;

	inputReqBlk->io_Data = (APTR)&FakeEvent;
	inputReqBlk->io_Length = sizeof(struct InputEvent);
	inputReqBlk->io_Command = IND_WRITEEVENT;
	DoIO((struct IORequest *)inputReqBlk);
#endif
}

void mouse_get_pos( int *x, int *y)
{
#ifndef VIRGIN
	if (Mouse_installed) {
		*x = scr->MouseX;
		*y = scr->MouseY;
	} else {
		*x = 0;
		*y = 0;
	}
#else
	*x=0; *y=0;
#endif
}

void mouse_get_delta( int *dx, int *dy )
{
#ifndef VIRGIN
	if (Mouse_installed) {
		*dx = -(Mouse.x  - scr->MouseX);
		*dy = -(Mouse.y  - scr->MouseY);
		mouse_center();
		Mouse.x = scr->MouseX;
		Mouse.y = scr->MouseY;
	} else {
		*dx = 0;
		*dy = 0;
	}
#else
	*dx=0;
	*dy=0;
#endif
}

int mouse_get_btns()
{
	int status = 0;

	return Mouse.button_status;
}

void mouse_set_pos( int x, int y)
{
}




void mouse_flush()
{
	int i;
	fix CurTime;

	if (Mouse_installed == 0) return;

	memset(&Mouse, 0, sizeof(mouse_info));
	return;

	if (!Mouse_installed)
		return;

	CurTime = timer_get_fixed_seconds();

	for (i = 0; i < MOUSE_MAX_BUTTONS; i++) {
		Mouse.pressed[i] = 0;
		Mouse.time_went_down[i] = 0; //CurTime;
		Mouse.time_held_down[i] = 0;
		Mouse.num_downs[i] = 0;
		Mouse.num_ups[i] = 0;
	}
	Mouse.button_status = 0;
}


// Returns how many times this button has went down since last call.
int mouse_button_down_count(int button) 
{
	int count;

	count = Mouse.num_downs[button];
	Mouse.num_downs[button] = 0;

	return count;
}

// Returns 1 if this button is currently down
int mouse_button_state(int button)  
{
	return Mouse.pressed[button];
}



// Returns how long this button has been down since last call.
fix mouse_button_down_time(int button)  
{
	return Mouse.time_held_down[button];
}

void mouse_get_cyberman_pos( int *x, int *y )
{
}

