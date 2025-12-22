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
 * $Source: /usr/CVS/descent/bios/joyc.c,v $
 * $Revision: 1.4 $
 * $Author: tfrieden $
 * $Date: 1998/04/09 16:10:48 $
 * 
 * Routines for joystick reading.
 * 
 * $Log: joyc.c,v $
 * Revision 1.4  1998/04/09 16:10:48  tfrieden
 * Preparing for pads
 *
 * Revision 1.3  1998/03/13 23:48:40  tfrieden
 * fixed hat problems
 *
 * Revision 1.2  1998/03/13 14:46:28  hfrieden
 * Modified Joystick support for FlighStick
 *
 * Revision 1.1.1.1  1998/03/03 15:11:50  nobody
 * reimport after crash from backup
 *
 * Revision 1.2  1998/02/28 00:26:59  hfrieden
 * Support for Analog Joysticks added
 *
 * 
 */


#pragma off (unreferenced)
static char rcsid[] = "$Id: joyc.c,v 1.4 1998/04/09 16:10:48 tfrieden Exp $";
#pragma on (unreferenced)

#include <stdlib.h>
#include <stdio.h>
/*#include <joystick.h>*/
#include <fcntl.h>

//#define ARCADE 1

#include "types.h"
#include "mono.h"
#include "joy.h"
#include "args.h"
#include "AJoystick.h"
#include "amiga_sega.h"
#include <inline/macros.h>

#ifndef DOS_BASE_NAME
#define DOS_BASE_NAME DOSBase
#endif

extern void *DOSBase;

#define Delay(timeout) \
	LP1NR(0xc6, Delay, long, timeout, d1, \
	, DOS_BASE_NAME)


struct AJoyData *JP;
int NumAxis = 2;

char joy_installed = 0;
char joy_present = 0;

//#define MAX_BUTTONS 16
#define MAX_BUTTONS 30

typedef struct Button_info {
	ubyte       ignore;
	ubyte       state;
	ubyte       last_state;
	int     timedown;
	ubyte       downcount;
	ubyte       upcount;
} Button_info;

typedef struct Joy_info {
	ubyte           present_mask;
	ubyte           slow_read;
	int         max_timer;
	int         read_count;
	ubyte           last_value;
	Button_info buttons[MAX_BUTTONS];
	int         axis_min[4];
	int         axis_center[4];
	int         axis_max[4];
} Joy_info;

Joy_info joystick;

int joy_buttons;

extern int joy_retries;

int joystick_fd0,joystick_fd1;

void myjoy_handler(fix ticks_this_time)
{
	ubyte value;
	int i, state;
	Button_info * button;

	ReadAJoystick(AJOYUNIT1, JP);

	value = 0;
	if (JP->button1) value |= 0x01;
	if (JP->button2) value |= 0x02;
	if (JP->button3) value |= 0x04;
	if (JP->button4) value |= 0x08;

	joy_buttons = value;

	for (i=0; i<MAX_BUTTONS; i++ )  {
		button = &joystick.buttons[i];
		if (!button->ignore) {
			if ( i < 5 )
				state = (value >> i) & 1;
			else if (i==(value+4))
				state = 1;
			else
				state = 0;

			if ( button->last_state == state )  {
				if (state) button->timedown += ticks_this_time;
			} else {
				if (state)  {
					button->downcount += state;
					button->state = 1;
				} else {
					button->upcount += button->state;
					button->state = 0;
				}
				button->last_state = state;
			}
		}
	}
}

void joy_get_cal_vals(int *axis_min, int *axis_center, int *axis_max)
{
	int i;
#ifdef JOY_DEBUG
	printf("joy_get_cal_vals():");
#endif

	for (i=0; i<4; i++)     {
	#ifdef JOY_DEBUG
		printf("min=%d center=%d max=%d\n", joystick.axis_min[i], joystick.axis_center[i], joystick.axis_max[i]);
	#endif
		axis_min[i] = joystick.axis_min[i];
		axis_center[i] = joystick.axis_center[i];
		axis_max[i] = joystick.axis_max[i];
	}
}

void joy_set_cal_vals(int *axis_min, int *axis_center, int *axis_max)
{
	int i;

	for (i=0; i<4; i++)     {
		joystick.axis_min[i] = axis_min[i];
		joystick.axis_center[i] = axis_center[i];
		joystick.axis_max[i] = axis_max[i];
	}
}


ubyte joy_get_present_mask()
{
#ifdef JOY_DEBUG
	printf("Present_Mask = %d\n",
		(NumAxis==4)?JOY_ALL_AXIS:(JOY_1_X_AXIS+JOY_1_Y_AXIS));
#endif

	return (NumAxis==4)?JOY_ALL_AXIS:(JOY_1_X_AXIS+JOY_1_Y_AXIS);
}

void joy_set_timer_rate(int max_value ) {
	joystick.max_timer = max_value;
}

int joy_get_timer_rate()    {
	return joystick.max_timer;
}


void joy_flush()    {
	int i;
	if (!joy_installed) return;

	for (i=0; i<MAX_BUTTONS; i++ )  {
		joystick.buttons[i].ignore = 0;
		joystick.buttons[i].state = 0;  
		joystick.buttons[i].timedown = 0;   
		joystick.buttons[i].downcount = 0;  
		joystick.buttons[i].upcount = 0;    
	}
}

ubyte joy_read_raw_buttons()    {
	return joy_buttons;
}

void joy_set_slow_reading(int flag)
{
}

ubyte joystick_read_raw_axis( ubyte mask, int * axis )
{
	if (!joy_installed||!joy_present) return 0;

	ReadAJoystick(AJOYUNIT1, JP);
	axis[0] = (int)JP->y;
	axis[1] = (int)JP->x;

	joy_buttons=0;
	if (JP->button1) joy_buttons |= 0x01;
	if (JP->button2) joy_buttons |= 0x02;
	if (JP->button3) joy_buttons |= 0x04;
	if (JP->button4) joy_buttons |= 0x08;

	if (NumAxis>2) {
		ReadAJoystick(AJOYUNIT0, JP);
		axis[2] = (int)JP->y;
		axis[3] = (int)JP->x;

	} else {
		axis[2] = 0/*axis[0]*/; axis[3]=0/*axis[1]*/;
	}
#ifdef JOY_DEBUG
	printf("joystick_read_raw_axis(%d): %d %d %d %d\n", (int)mask,
		axis[0], axis[1], axis[2], axis[3]);
#endif
	return (NumAxis==4)?JOY_ALL_AXIS:(JOY_1_X_AXIS+JOY_1_Y_AXIS);
}

void (*joy_handler)(fix);

int joy_init(void)
{
	int i,t;
	int temp_axis[4];

	mouse_switch_off();
	joy_flush();

	for (i=0; i<MAX_BUTTONS; i++ )  
		joystick.buttons[i].last_state = 0;

	if ( !joy_installed )   {
		atexit(joy_close);
		if ((t = FindArg("-numaxis"))) {
			NumAxis = atoi(Args[t+1]);
		} else NumAxis = 2;
		printf("Allocating %d axis Joystick\n", NumAxis);
		if (!OpenAJoystick(AJOYUNIT1|(NumAxis==2?0:AJOYUNIT0))) {
			printf("Joystick allocation failed\n");
			mouse_switch_on();
			return 0;
		}
		printf("Analog Joystick allocated successfully\n");
		JP = malloc(sizeof(struct AJoyData));
		if (!JP) {
			CloseAJoystick();
			mouse_switch_on();
			return 0;
		}
		bzero(JP, sizeof(struct AJoyData));
		Delay(25L);
		joy_present = 1;
		joy_installed = 1;
		//joystick.max_timer = 65536;
		joystick.slow_read = 0;
		joystick.read_count = 0;
		joystick.last_value = 0;
		joy_handler = myjoy_handler;
	}

	// Do initial cheapy calibration...
	joystick.present_mask = JOY_ALL_AXIS;       // Assume they're all present
	joystick.present_mask = joystick_read_raw_axis( JOY_ALL_AXIS, temp_axis );

	mouse_switch_on();
	return 1;
}

void joy_close()    
{

	if (!joy_installed) return;
	joy_installed = 0;
	if (JP) {
		free(JP); JP=0;
		CloseAJoystick();
	}
}

void joy_set_ul()   
{

	joystick.present_mask = JOY_ALL_AXIS;
		joystick.present_mask = joystick_read_raw_axis( JOY_ALL_AXIS, joystick.axis_min );
	if ( joystick.present_mask & 3 )
		joy_present = 1;
	else
		joy_present = 0;
}

void joy_set_lr()   
{
	joystick.present_mask = JOY_ALL_AXIS;
	joystick.present_mask = joystick_read_raw_axis( JOY_ALL_AXIS, joystick.axis_max );

	if ( joystick.present_mask & 3 )
		joy_present = 1;
	else
		joy_present = 0;
}

void joy_set_cen() 
{
	joystick.present_mask = JOY_ALL_AXIS;
	joystick.present_mask = joystick_read_raw_axis( JOY_ALL_AXIS, joystick.axis_center );

	if ( joystick.present_mask & 3 )
		joy_present = 1;
	else
		joy_present = 0;

}

/*void dead_code_joy_set_cen_fake(int channel)
{
}*/

int joy_get_scaled_reading( int raw, int axn )  
{
	int x, d;

	if ( joystick.axis_center[axn] - joystick.axis_min[axn] < 5 ) return 0;
	if ( joystick.axis_max[axn] - joystick.axis_center[axn] < 5 ) return 0;

	raw -= joystick.axis_center[axn];

	if ( raw < 0 )  {
		d = joystick.axis_center[axn]-joystick.axis_min[axn];
	} else {
		d = joystick.axis_max[axn]-joystick.axis_center[axn];
	}

#ifdef JOY_DEBUG
	printf("raw=%d, d=%d\n", raw, d);
#endif

	if ( d )
		x = (raw << 7) / d;
	else 
		x = 0;

	if ( x < -128 ) x = -128;
	if ( x > 127 ) x = 127;
#ifdef JOY_DEBUG
	printf("joy_get_scaled_reading(%d,%d) = %d\n", raw, axn, x);
#endif

	return x;
}

int last_reading[4] = { 0, 0, 0, 0 };

void joy_get_pos( int *x, int *y )  
{
	ubyte flags;
	int axis[4];

	if ((!joy_installed)||(!joy_present)) { *x=*y=0; return; }

	flags=joystick_read_raw_axis( JOY_1_X_AXIS+JOY_1_Y_AXIS, axis );

	last_reading[0] = axis[0];
	last_reading[1] = axis[1];

	if ( flags & JOY_1_X_AXIS )
		*x = joy_get_scaled_reading( axis[0], 0 );
	else
		*x = 0;

	if ( flags & JOY_1_Y_AXIS )
		*y = joy_get_scaled_reading( axis[1], 1 );
	else
		*y = 0;

#ifdef JOY_DEBUG
	printf("joy_get_pos(%d,%d)\n", *x, *y);
#endif

}

ubyte joy_read_stick( ubyte masks, int *axis )  
{
	ubyte flags;
	int raw_axis[4];

	if ((!joy_installed)||(!joy_present)) { 
		axis[0] = 0; axis[1] = 0;
		axis[2] = 0; axis[3] = 0;
		return 0;  
	}

	flags=joystick_read_raw_axis( masks, raw_axis );

		last_reading[0] = axis[0];
		last_reading[1] = axis[1];
		last_reading[2] = axis[2];
		last_reading[3] = axis[3];

	if ( flags & JOY_1_X_AXIS )
		axis[0] = joy_get_scaled_reading( raw_axis[0], 0 );
	else
		axis[0] = 0;

	if ( flags & JOY_1_Y_AXIS )
		axis[1] = joy_get_scaled_reading( raw_axis[1], 1 );
	else
		axis[1] = 0;

	if ( flags & JOY_2_X_AXIS )
		axis[2] = joy_get_scaled_reading( raw_axis[2], 2 );
	else
		axis[2] = 0;

	if ( flags & JOY_2_Y_AXIS )
		axis[3] = joy_get_scaled_reading( raw_axis[3], 3 );
	else
		axis[3] = 0;
#ifdef JOY_DEBUG
	printf("joy_read_stick: %d %d %d %d flags=%d\n",
		axis[0], axis[1], axis[2], axis[3], flags);
#endif
	return flags;
}


int joy_get_btns()  
{
	if ((!joy_installed)||(!joy_present)) return 0;

	 return joy_read_raw_buttons();
}

void joy_get_btn_down_cnt( int *btn0, int *btn1 ) 
{
	if ((!joy_installed)||(!joy_present)) { *btn0=*btn1=0; return; }

	*btn0 = joystick.buttons[0].downcount;
	joystick.buttons[0].downcount = 0;
	*btn1 = joystick.buttons[1].downcount;
	joystick.buttons[1].downcount = 0;
}

int joy_get_button_state( int btn ) 
{
	int count;

	if ((!joy_installed)||(!joy_present)) return 0;

	if ( btn >= MAX_BUTTONS ) return 0;

	count = joystick.buttons[btn].state;

	return  count;
}

int joy_get_button_up_cnt( int btn ) 
{
	int count;

	if ((!joy_installed)||(!joy_present)) return 0;

	if ( btn >= MAX_BUTTONS ) return 0;

	count = joystick.buttons[btn].upcount;
	joystick.buttons[btn].upcount = 0;

	return count;
}

int joy_get_button_down_cnt( int btn ) 
{
	int count;

	if ((!joy_installed)||(!joy_present)) return 0;
	if ( btn >= MAX_BUTTONS ) return 0;

	count = joystick.buttons[btn].downcount;
	joystick.buttons[btn].downcount = 0;
	return count;
}

	
fix joy_get_button_down_time( int btn ) 
{
	fix count;

	if ((!joy_installed)||(!joy_present)) return 0;
	if ( btn >= MAX_BUTTONS ) return 0;

	count = joystick.buttons[btn].timedown;
	joystick.buttons[btn].timedown = 0;

//    return fixmuldiv(count, 65536, 1193180 );
	return count;
}

void joy_get_btn_up_cnt( int *btn0, int *btn1 ) 
{
	if ((!joy_installed)||(!joy_present)) { *btn0=*btn1=0; return; }

	*btn0 = joystick.buttons[0].upcount;
	joystick.buttons[0].upcount = 0;
	*btn1 = joystick.buttons[1].upcount;
	joystick.buttons[1].upcount = 0;

}

void joy_set_btn_values( int btn, int state, fix timedown, int downcount, int upcount )
{

	joystick.buttons[btn].ignore = 1;
	joystick.buttons[btn].state = state;
	joystick.buttons[btn].timedown = fixmuldiv( timedown, 1193180, 65536 );
	joystick.buttons[btn].downcount = downcount;
	joystick.buttons[btn].upcount = upcount;
}

void joy_poll()
{
#ifdef JOY_DEBUG
	printf("joy_poll()\n");
#endif
/*
	if ( joystick.slow_read & JOY_BIOS_READINGS )   
		joystick.last_value = joy_read_buttons_bios();
	*/
}
