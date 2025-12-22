
/*****************************************************************************

	CLASS		: MMCrusher
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Surface class handling the CRUSHER
						Derived from MMObject and imports data from structre MMCRUSHER

	CREATED	:	27/10/01
	UPDATES	:						- Add MMObject instead of KSurface.

*****************************************************************************/

#include "MMCrusher.h"
#include "stdlib.h"



/*****************************************************************************

	NAME	: Init

	DESCR.: Initilise crusher from data structre.

	ENTRY	:

	EXIT	:

*****************************************************************************/

#define MM_CRUSHER_END_HEIGHT	0x0A

void MMCrusher::Init(MMCRUSHER *crusher)
{
	if(crusher->x == 0 && crusher->y == 0)
	{
		mode = MODE_HIDE;			// don't draw
	}
	else
	{
		mode = MODE_SHOW;
		rcSrc.x = 0;
		rcSrc.y = lpSurface->h - MM_CRUSHER_END_HEIGHT;
		rcSrc.w = lpSurface->w;
		rcSrc.h = MM_CRUSHER_END_HEIGHT;
	
		rcDest.x = (crusher->x<<4)+MM_SCREEN_POS_X;		
		rcDest.y = MM_Y_POS_TO_SDL((crusher->y-2));								// Position

		y=crusher->y;
		x=crusher->x;
		lowY= crusher->lowY;								// Y pos when at lowest
		countdown= crusher->countdown;			// count down to next crush
		direction= crusher->direction;			// direction of movement
		startY= crusher->startY;						// Y start position
	}
}


/*****************************************************************************

	NAME	: Move

	DESCR.: Handles crusher movement & timings

	ENTRY	:

	EXIT	:

*****************************************************************************/

void MMCrusher::Move()
{
	if(countdown == 0)
	{
		if(direction == UP)
		{
			rcSrc.y+=4;
			rcSrc.h-=8;
			y+=2;
			if(y >= startY)
			{
					direction = !direction;
					countdown = rand() & 0x7F;
			}
		}
		else
		{
			rcSrc.y-=4;
			rcSrc.h+=8;
			y-=2;
			if(y <= lowY)
			{
				direction = !direction;
			}
		}
	}
	else
		countdown--;

}
