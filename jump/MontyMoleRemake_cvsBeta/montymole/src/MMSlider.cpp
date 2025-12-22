
/*****************************************************************************

	CLASS		: MMSlider
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Surface class handling the SLIDER objects
						Derived from MMObject and imports data from structre MMSLIDER

	CREATED	:	01/11/01
	UPDATES	:						

*****************************************************************************/

#include "MMSlider.h"


#define		MM_SLIDER_WIDTH		0x100
#define		MM_SLIDER_HEIGHT	0x0E
#define		MM_SLIDER_MIDWAY	0x080

/*****************************************************************************

	NAME	: Init

	DESCR.: Initilise slider from data structre.

	ENTRY	:

	EXIT	:

*****************************************************************************/


void MMSlider::Init(PCSLIDER *slider)
{
	if(slider->leftX == 0 && slider->leftY == 0)
	{
		mode = MODE_HIDE;
	}
	else
	{
		mode = MODE_SHOW;
		leftX = slider->leftX;
		leftY = slider->leftY;
		leftStartX = slider->leftStartX;
		leftEndX = slider->leftEndX;
		rightX = slider->rightX;
		rightY = slider->rightY;
		rightStartX = rightX;
		direction = slider->direction;
	}
}


/*****************************************************************************

	NAME	: Move

	DESCR.: Handles sliders movement & timings

	ENTRY	:

	EXIT	:	

*****************************************************************************/

void MMSlider::Move()
{
	if(mode == MODE_SHOW)
	{
		rcSrc.x = MM_SLIDER_WIDTH - (leftX<<1);
		rcSrc.y = 0;
		rcSrc.w = (leftX-leftStartX)<<1;
		rcSrc.h = MM_SLIDER_HEIGHT;

		rcDest.x = MM_X_POS_TO_SDL(leftStartX);
		rcDest.y = MM_Y_POS_TO_SDL(leftY);

		rcSrcR.x = 0;
		rcSrcR.y = 0;
		rcSrcR.w = (rightStartX-rightX)<<1;
		rcSrcR.h = MM_SLIDER_HEIGHT;

		rcDestR.x = MM_X_POS_TO_SDL(rightX);
		rcDestR.y = MM_Y_POS_TO_SDL(rightY);

		if(direction == MM_SLIDER_CLOSING)
		{
			rightX--;
			leftX++;
		}
		else
		{
			rightX++;
			leftX--;
		}

		if(leftX == leftStartX || leftX == leftEndX)
			direction ^= MM_SLIDER_OPENING;		// reverse direction
	}
}



/*****************************************************************************

		NAME	: Collision

		DESCR.: Check to see if basline is within objects rect

		ENTRY	: KJLine		baseLine	-	line for test

		EXIT	: bool								- true of collision occured

	*****************************************************************************/

bool MMSlider::Collision(KJLine baseLine)
{
	return (
					( baseLine.x1 >= rcDest.x && baseLine.x1 <= rcDest.x+rcSrc.w &&
					  baseLine.y1 >= rcDest.y-2 && baseLine.y1 <= rcDest.y+1          )
					||
					( baseLine.x2 >= rcDest.x && baseLine.x2 <= rcDest.x+rcSrc.w &&
					  baseLine.y2 >= rcDest.y-2 && baseLine.y2 <= rcDest.y+1          )
					||
					( baseLine.x1 >= rcDestR.x && baseLine.x1 <= rcDestR.x+rcSrcR.w &&
					  baseLine.y1 >= rcDestR.y-2 && baseLine.y1 <= rcDestR.y+1            )
					||
					( baseLine.x2 >= rcDestR.x && baseLine.x2 <= rcDestR.x+rcSrcR.w &&
					  baseLine.y2 >= rcDestR.y-2 && baseLine.y2 <= rcDestR.y+1           )
					);
}



/*****************************************************************************

	NAME	: Update

	DESCR.: Update to blit to parent surface, this one needs two blits
					for left and right platforms...

	ENTRY	:

	EXIT	:

*****************************************************************************/

void MMSlider::Update()
{
	if(mode != MODE_HIDE)
	{
		SDL_BlitSurface(lpSurface, &rcSrc, lpParent, &rcDest);
		SDL_BlitSurface(lpSurface, &rcSrcR, lpParent, &rcDestR);
	}
}



