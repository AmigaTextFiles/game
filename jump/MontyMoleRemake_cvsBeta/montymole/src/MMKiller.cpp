
/*****************************************************************************

	CLASS		: MMKiller
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Surface class handling the KILLER objects
						Derived from MMObject and imports data from structre MMKILLER

	CREATED	:	27/10/01
	UPDATES	:						- Add MMObject instead of KSurface.
						15/03/02	- Added GetStatus() function for testing if killer
												is still alive.
						19/03/02	- Added bit to status to allow animation to be disabled.

*****************************************************************************/

#include "MMKiller.h"


/*****************************************************************************

	NAME	: Init

	DESCR.: Initilise crusher from data structre.

	ENTRY	:

	EXIT	:

*****************************************************************************/


void MMKiller::Init(PCKILLER *killer)
{
	if(killer->x != 0 && killer->x != 0)
	{
		mode = MODE_SHOW;
	}
	else
		mode = MODE_HIDE;

		direction = killer->direction;					// Direction of movement
		status = killer->status;								// Status of object
		x=killer->x;														// x pos
		y=killer->y;														// y pos
		startX = killer->x;											// keep record of starting positions
		startY=killer->y;
		animCounter = killer->animCounter;			// keep count of animation frame
		velocity = killer->velocity;						// the speed of movement
		counter= killer->counter;								// overall counter.. 
		countStart = killer->countStart;				// amount to count
		linkObj = killer->linkObj;							// other object tied in
																						// Graphc frame index...
		frame[MM_KILLERS_UP] = killer->frame[MM_KILLERS_UP];
		frame[MM_KILLERS_DN] = killer->frame[MM_KILLERS_DN];
		frame[MM_KILLERS_LEFT] = killer->frame[MM_KILLERS_LEFT];
		frame[MM_KILLERS_RIGHT] = killer->frame[MM_KILLERS_RIGHT];

}


/*****************************************************************************

	NAME	: Move

	DESCR.: Handles crusher movement & timings

	ENTRY	:

	EXIT	:	int							- index of linked killer.
														If a value is returned then linked killer needs
														to be enabled with same value...
														MM_KILLER_NO_LINK - no killer

*****************************************************************************/

int MMKiller::Move()
{
	int linked = MM_KILLER_NO_LINK;
	Uint8		stat = status & STATUS_MASK;

	if(stat == STATUS_DISABLED)
	{
		rcSrc.x=0;
		rcSrc.y=0;
		rcSrc.w=0;
		rcSrc.h=0;
	}
	else
	{
		rcSrc.x= ((animCounter>>2) & 0x03)<<MM_KILLER_WIDTH_SHIFT;
		rcSrc.y= frame[direction]*MM_KILLER_HEIGHT;
		rcSrc.w=MM_KILLER_WIDTH;
		rcSrc.h=MM_KILLER_HEIGHT;

		rcDest.x =  MM_X_POS_TO_SDL((Sint16)x);		
		rcDest.y =  MM_Y_POS_TO_SDL((Sint16)y);								// Position

		switch(direction)
		{
		case MM_KILLERS_LEFT:
			x=x-velocity;
		break;

		case MM_KILLERS_RIGHT:
			x=x+velocity;
		break;

		case MM_KILLERS_UP:
			y=y+velocity;
		break;

		case MM_KILLERS_DN:
			y=y-velocity;
		break;
		}

		if(--counter == 0)
			counter = countStart;

		if( (status & STATUS_NO_ANIM) == 0)
		  animCounter = (animCounter+1)&0x7F;

		if(stat == STATUS_BASIC && counter == countStart)
		{
			direction = direction ^0x01;	// change to opposite direction
		}

		if(stat == STATUS_LINKED && counter == countStart)
		{
			Kill();
			linked = linkObj;
		}

	}

	return linked;
}




void MMKiller::SetStatus(int newStatus)
{
	status = (status & STATUS_ATTR_MASK) | (Uint8)newStatus;  // change the status
}



/*****************************************************************************

		NAME	: Kill

		DESCR.: Get rid of killer

		ENTRY	: 

		EXIT	: 

	*****************************************************************************/

void	MMKiller::Kill()
{
		x = startX;
		y= startY;
		status = (status & STATUS_ATTR_MASK) | STATUS_DISABLED;
}

