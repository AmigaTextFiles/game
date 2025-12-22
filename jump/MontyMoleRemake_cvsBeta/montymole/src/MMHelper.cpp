
/*****************************************************************************

	CLASS		: MMHelper
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Surface class handling the HELPER
						Derived from MMObject and imports data from structre MMHELPER

	CREATED	:	27/10/01
	UPDATES	:

*****************************************************************************/

#include "MMHelper.h"



/*****************************************************************************

	NAME	: Init

	DESCR.: Initilise crusher from data structre.

	ENTRY	:

	EXIT	:

*****************************************************************************/


void MMHelper::Init(MMHELPER *helper)
{
	if(helper->index >0)
	{
		rcSrc.x = 0;
		rcSrc.y = (helper->index-1)*MM_HELPER_HEIGHT;
		rcSrc.w = MM_HELPER_WIDTH;
		rcSrc.h = MM_HELPER_HEIGHT;
	
		rcDest.x = MM_X_POS_TO_SDL(helper->x);		
		rcDest.y = MM_Y_POS_TO_SDL(helper->y);								// Position

		index = helper->index;
		mode = MODE_SHOW;
	}
	else
		mode = MODE_HIDE;
}


