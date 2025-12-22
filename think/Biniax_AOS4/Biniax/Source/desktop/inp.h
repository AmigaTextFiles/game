/******************************************************************************
BINIAX INPUT-RELATED DEFINITIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

#ifndef _BNX_INP_H
#define _BNX_INP_H

/******************************************************************************
INCLUDES
******************************************************************************/

#include "inc.h"

/******************************************************************************
LOCAL INPUT DATA (KEY FLAGS, POINTERS, ETC.)
******************************************************************************/

typedef struct BNX_INP
{

	BNX_BOOL	keyUp;
	BNX_BOOL	keyDown;
	BNX_BOOL	keyLeft;
	BNX_BOOL	keyRight;
	BNX_BOOL	keyA;
	BNX_BOOL	keyB;

} BNX_INP;

BNX_INP _Inp;

/******************************************************************************
FUNCTIONS
******************************************************************************/

BNX_BOOL inpInit();

void inpUpdate();

BNX_BOOL inpKeyLeft();
BNX_BOOL inpKeyRight();
BNX_BOOL inpKeyUp();
BNX_BOOL inpKeyDown();
BNX_BOOL inpKeyA();
BNX_BOOL inpKeyB();

#endif
