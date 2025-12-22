

/*********************************************************/
/*                                                       */
/* Copyright (c) 1989, David Kinzer, All Rights Reserved */
/*                                                       */
/* Permission hereby granted to redistribute this        */
/* program in unmodified form in a not for profit manner.*/
/*                                                       */
/* Permission hereby granted to use this software freely */
/* in programs, commercial or not.                       */
/*                                                       */
/*                                                       */
/*********************************************************/
/*                                                       */
/* AJoystick.h                                           */
/*                                                       */
/* Include file for using Analog Joystick Routines       */
/* AJOYUNITx is used for OpenAJoystick and ReadAJoystick */
/* read calls                                            */
/*                                                       */
/*********************************************************/


#define AJOYUNIT0   1L
#define AJOYUNIT1   2L

/* UxBySINGLE is used for OpenAJoystick calls to specify */
/*            single trigger on the button press         */

#define U0B1SINGLE  0x0100L
#define U0B2SINGLE  0x0200L
#define U0B3SINGLE  0x0400L
#define U0B4SINGLE  0x0800L
#define U1B1SINGLE  0x1000L
#define U1B2SINGLE  0x2000L
#define U1B3SINGLE  0x4000L
#define U1B4SINGLE  0x8000L


/* Data from ReadAJoystick is returned to an AJoyData   */
/* structure                                            */

struct AJoyData {
   unsigned short x;
   unsigned short y;
   unsigned char button1;
   unsigned char button2;
   unsigned char button3;
   unsigned char button4;
};

/* button data will be one of the following             */

#define BUTTONDOWN  -1
#define BUTTONUP    0

long CloseAJoystick(void);
struct joydata *OpenAJoystick(long units);
struct AJoyData *ReadAJoystick(long unit, struct AJoyData *UserDataPtr);


/* End: AJoystick.h                                     */

