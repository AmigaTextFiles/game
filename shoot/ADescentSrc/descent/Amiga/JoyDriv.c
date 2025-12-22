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
/*********************************************************/
/*                                                       */
/* JoyDriv.c                                             */
/*                                                       */
/* Analog joystick interface routines                    */
/*                                                       */
/* This file contains the routines needed to interface   */
/* to an analog joystick.  The routines supplied will    */
/* open, read, and close an analog joystick port.        */
/* Note that in order to use joyport 0 (left mouse port) */
/* the intuition interface will have to be turned off.   */
/*                                                       */
/*********************************************************/

#include "exec/types.h"
#include "exec/memory.h"
#include "exec/interrupts.h"
#include "hardware/custom.h"
#include "hardware/intbits.h"

#include <stdio.h>

#include "AJoystick.h"

#define POTBITS0        0x0F01
#define POTBITS1        0xF001
#define INPUT0          0x0000
#define INPUT1          0x0000
#define INMASK0         0x0A00
#define INMASK1         0xA000




struct joydata {
   struct {
	  unsigned short x;
	  unsigned short y;
	  char b1;
	  char b2;
	  char b3;
	  char b4;
	  char eb1;
	  char eb2;
	  char eb3;
	  char eb4;
   } unit0,unit1;
   APTR pgbase;
   long unitflags;
};




APTR PotgoBase = 0;               /* Library base        */
long gotpotgo = 0;                /* Potgo register bits */
								  /*  we are using       */
struct joydata *JoyData = NULL;   /* Pointer to data     */
								  /*  passing area       */
struct Interrupt *VBRData = NULL; /* Pointer to VERTB    */
								  /*  interrupt node     */
extern VOID vbserver();


/* Open Analog Joystick Routine */

struct joydata *OpenAJoystick(long units)
{
long wantpotgo, AllocPotBits();
long inputbits, inputmask;
APTR OpenResource(), AllocMem();


   /* reject open if already opened. */

	#ifdef JOY_DEBUG
	printf("sizeof(struct joydata)=%d\n", sizeof(struct joydata));
	#endif

   if (JoyData) {
	  return NULL;
   }

   /* Open potgo resource.  The resource controls        */
   /* allocation and writing of the potgo register.      */
   /* Note: There is no corresponding CloseResource call */
   /*       in the Amiga.                                */

   PotgoBase = OpenResource((STRPTR)"potgo.resource");
   if (!PotgoBase) {
	  return NULL;    /* Return error if potgo.resource */
					  /* is not available.              */
   }

   #ifdef JOY_DEBUG
	printf("Opened potgo.resource\n");
   #endif

   /* figure out which bits we need */

   wantpotgo = 0;
   inputbits = 0;
   inputmask = 0;

   if (units & AJOYUNIT0) {
	  wantpotgo |= POTBITS0;
	  inputbits |= INPUT0;
	  inputmask |= INMASK0;
   }

   if (units & AJOYUNIT1) {
	  wantpotgo |= POTBITS1;
	  inputbits |= INPUT1;
	  inputmask |= INMASK1;
   }

   /* Do we want anything?  If not, return error, since */
   /* there is probably an error in the call.           */

   if (!wantpotgo) {
	  return NULL;
   }


   /* Allocate the bits that we need from the potgo  */
   /* resource.                                      */

	/* HACK ALERT !!!!! */
	//FreePotBits(0xFF00);

   gotpotgo = AllocPotBits(wantpotgo);

	#ifdef JOY_DEBUG
	printf("Wanted potgo 0x%X, got 0x%X\n", wantpotgo, gotpotgo);
	#endif

   /* See if we got what we needed. If not, return error */

   if (wantpotgo != gotpotgo) {
	  printf("Wanted 0x%X, but got 0x%X\n", wantpotgo, gotpotgo);
	  FreePotBits(gotpotgo); /* give back allocated bits */
	  return NULL;
   }


   /* Since we don't know what the hardware was set to   */
   /* before we got it, we shall set the analog joystick */
   /* bits to inputs like we want.                       */

   WritePotgo(inputbits,inputmask);

   /* Now that we have the hardware, we shall set up our */
   /* VERTB (vertical blanking) interrupt server routine.*/
   /* We get some Public memory for a shared data area   */
   /* between the server and the ReadAJoystick routine.  */
   /* Then we set up an interrupt structure which allows */
   /* our server to become a part of the Amiga operating */
   /* system.                                            */

   JoyData = (struct joydata *)AllocMem((long)sizeof
			   (struct joydata),MEMF_PUBLIC);
   if (!JoyData) {       /* error if we can't get memory */
	  FreePotBits(gotpotgo); /* give back allocated bits */
	  return NULL;
   }

   JoyData->pgbase = PotgoBase;     /* send potgobase to */
									/*  vertb server     */
   JoyData->unitflags = units;      /* send units to     */
									/*  vertb server     */

   JoyData->unit0.x = 0x8000;       /* fill in some      */
   JoyData->unit0.y = 0x8000;       /*  dummy values     */
   JoyData->unit0.b1 = 0;
   JoyData->unit0.b2 = 0;
   JoyData->unit0.b3 = 0;
   JoyData->unit0.b4 = 0;
   JoyData->unit0.eb1 = 0;
   JoyData->unit0.eb2 = 0;
   JoyData->unit0.eb3 = 0;
   JoyData->unit0.eb4 = 0;
   JoyData->unit1.x = 0x8000;       
   JoyData->unit1.y = 0x8000;
   JoyData->unit1.b1 = 0;
   JoyData->unit1.b2 = 0;
   JoyData->unit1.b3 = 0;
   JoyData->unit1.b4 = 0;
   JoyData->unit1.eb1 = 0;
   JoyData->unit1.eb2 = 0;
   JoyData->unit1.eb3 = 0;
   JoyData->unit1.eb4 = 0;

   VBRData = (struct Interrupt *)AllocMem((long)sizeof
				(struct Interrupt),MEMF_PUBLIC);
   if (!VBRData) {       /* error if we can't get memory */
	  /* give back memory and allocated potgo bits */
	  FreeMem(JoyData,(long)sizeof(struct joydata));
	  FreePotBits(gotpotgo);        
	  return NULL;
   }


   /* Fill in the blanks of the Interrupt structure */

   VBRData->is_Node.ln_Type = NT_INTERRUPT;
   VBRData->is_Node.ln_Pri = 10;
   VBRData->is_Node.ln_Name = "VERTB for Analog Joystick";
   VBRData->is_Data = (APTR)JoyData;
   VBRData->is_Code = vbserver;

   /* And, finally, add interrupt routine to Operating  */
   /* System.                                           */

   AddIntServer(INTB_VERTB,VBRData);

   /* Return pointer to data, in case user wants to go  */
   /* directly to the data structures.                  */

	#ifdef JOY_DEBUG
	printf("Joysticks set up\n");
	#endif

   return JoyData;

}


/* Close Analog Joystick routine.                       */
/* Note: Since the Units are closely intertwined, I     */
/*       decided to close all open units with one call. */
/*       (since you had to open them with one call      */
/*       anyway).                                       */

long CloseAJoystick(void)
{

   /* Are we actually open? Error if not */

   if (!JoyData) {
	  return 0;
   }

   /* Shut off VERTB routine */

   RemIntServer(INTB_VERTB,VBRData);

   /* Free up memory */

   FreeMem(JoyData,(long)sizeof(struct joydata));  
   FreeMem(VBRData,(long)sizeof(struct Interrupt)); 

   /* Give back allocated potgo bits */

	#ifdef JOY_DEBUG
	printf("Freeing potgo 0x%X\n", gotpotgo);
	#endif

   FreePotBits(gotpotgo);

   /* Set Flag so we don't read bad data */

   JoyData = NULL;

   /* return success */

   return 1;
}


/* Joystick Read routine                                 */
/* Note: Reads values left by last VERTB interrupt.      */
/* Note: Data is stale until first interrupt comes along.*/
/* Note: Only one Unit can be read at a time.            */

struct AJoyData *ReadAJoystick(long unit,struct AJoyData *UserDataPtr)
{

   /* Are we open? Error if not. */

   if (!JoyData) {
	  return NULL;
   }

   /* Is this unit open? Error if not */

   if (!(JoyData->unitflags & unit)) {
	  return NULL;
   }

   /* Get data for unit and place in requestor's data    */
   /* structure. (Should be public memory.)              */

   if (unit == AJOYUNIT0) {

	  UserDataPtr->x = JoyData->unit0.x;
	  UserDataPtr->y = JoyData->unit0.y;

	  if (JoyData->unitflags & U0B1SINGLE) {
		 UserDataPtr->button1 = JoyData->unit0.eb1;
		 JoyData->unit0.eb1 = 0;
	  } else 
		 UserDataPtr->button1 = JoyData->unit0.b1;

	  if (JoyData->unitflags & U0B2SINGLE) {
		 UserDataPtr->button2 = JoyData->unit0.eb2;
		 JoyData->unit0.eb2 = 0;
	  } else 
		 UserDataPtr->button2 = JoyData->unit0.b2;

	  if (JoyData->unitflags & U0B3SINGLE) {
		 UserDataPtr->button3 = JoyData->unit0.eb3;
		 JoyData->unit0.eb3 = 0;
	  } else 
		 UserDataPtr->button3 = JoyData->unit0.b3;

	  if (JoyData->unitflags & U0B4SINGLE) {
		 UserDataPtr->button4 = JoyData->unit0.eb4;
		 JoyData->unit0.eb4 = 0;
	  } else 
		 UserDataPtr->button4 = JoyData->unit0.b4;

   } else if (unit == AJOYUNIT1) {

	  UserDataPtr->x = JoyData->unit1.x;
	  UserDataPtr->y = JoyData->unit1.y;

	  if (JoyData->unitflags & U1B1SINGLE) {
		 UserDataPtr->button1 = JoyData->unit1.eb1;
		 JoyData->unit1.eb1 = 0;
	  } else 
		 UserDataPtr->button1 = JoyData->unit1.b1;

	  if (JoyData->unitflags & U1B2SINGLE) {
		 UserDataPtr->button2 = JoyData->unit1.eb2;
		 JoyData->unit1.eb2 = 0;
	  } else 
		 UserDataPtr->button2 = JoyData->unit1.b2;

	  if (JoyData->unitflags & U1B3SINGLE) {
		 UserDataPtr->button3 = JoyData->unit1.eb3;
		 JoyData->unit1.eb3 = 0;
	  } else 
		 UserDataPtr->button3 = JoyData->unit1.b3;

	  if (JoyData->unitflags & U1B4SINGLE) {
		 UserDataPtr->button4 = JoyData->unit1.eb4;
		 JoyData->unit1.eb4 = 0;
	  } else 
		 UserDataPtr->button4 = JoyData->unit1.b4;

   } else return NULL;  /* Error, not a recognised unit */

   /* return success */

   return UserDataPtr;

}

/* End: JoyDriv.c */
