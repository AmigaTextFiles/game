
/*****************************************************************************

	CLASS		: MMCoal
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Surface class handling the COAL objects
						Derived from MMObject and imports data from structure PCCOAL

	CREATED	:	02/11/01
	UPDATES	:						

*****************************************************************************/

#include "MMCoal.h"


/*****************************************************************************

	NAME	: Init

	DESCR.: Initilise coal from data structre.

	ENTRY	:

	EXIT	:

*****************************************************************************/


void MMCoal::Init(PCCOAL *coal, int room)
{
	if(coal->x == 0 && coal->y == 0)
	{
		mode = MODE_HIDE;
		index = 0xFF;
	}
	else
	{
		mode = MODE_SHOW;

		x = coal->x;
		y = coal->y;
		index = coal->index;

		rcSrc.x = 0;
		rcSrc.y = room * MM_TILE_HEIGHT;
		rcSrc.w = MM_TILE_WIDTH;
		rcSrc.h = MM_TILE_HEIGHT;

		rcDest.x = (x<<4)+MM_SCREEN_POS_X;
		rcDest.y = ((y-2)<<4)+MM_SCREEN_POS_Y;
	}
		
}




