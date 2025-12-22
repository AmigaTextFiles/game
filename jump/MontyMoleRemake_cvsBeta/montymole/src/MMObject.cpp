/*****************************************************************************

	CLASS		: MMObject
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Creates a surface and loads a bitmap ont it.
						This object can then be blitted, in part as a sprite

	CREATED	:	27/10/01
	UPDATES	: 21/03/02	- 

*****************************************************************************/

#include "MMObject.h"



/*****************************************************************************

	NAME	: Create()

	DESCR.: Creates bitmap image of object from given filename

	ENTRY	: SDL_Surface		parent - surface that object will be blitted to
					const char		filename - filename of bitmap object

	EXIT	:

*****************************************************************************/

bool MMObject::Create(SDL_Surface *parent, const char *filename)
{
	bool		bSuccess = false;

	if(KSurface::Create(parent, filename))
	{
		mode = MODE_SHOW;
		bCopied = false;
		bSuccess = true;
	}

	return bSuccess;
}



/*****************************************************************************

	NAME	: Create()

	DESCR.: Creates object with and existing surface

	ENTRY	: SDL_Surface		parent - surface that object will be blitted to
					SDL_Surface		copy   - existing surface with bitmap on..

	EXIT	:

*****************************************************************************/

bool MMObject::Create(SDL_Surface *parent, SDL_Surface *copy, SDL_Rect *rect /*=NULL*/)
{
	bool		bSuccess = false;

	if(copy != NULL)
	{
		lpSurface = copy;
		mode = MODE_SHOW;
		SDL_SetColorKey(lpSurface, SDL_SRCCOLORKEY , SDL_MapRGB(lpSurface->format, 0, 0, 0xFF));

		lpParent = parent;
		bCopied = true;
		bSuccess = true;

		if(rect != NULL)
		{
			rcDest.x = rect->x;
			rcDest.y = rect->y;
			rcDest.w = rect->w;
			rcDest.h = rect->h;
			rcSrc.x=0;
			rcSrc.y=0;
			rcSrc.w = rect->w;
			rcSrc.h = rect->h;
		}
	}
	return bSuccess;
}


/*****************************************************************************

		NAME	: Get Base Line

		DESCR.: Returns KJLine structure holding two points making up bottom
						line of object...

		ENTRY	: 

		EXIT	: KJLine

	*****************************************************************************/

KJLine MMObject::GetBaseLine()
{
	KJLine	line = {rcDest.x, 
									rcDest.y + rcSrc.h,
									rcDest.x + rcSrc.w,
									rcDest.y + rcSrc.h
									};

	return line;
}



/*****************************************************************************

		NAME	: Under

		DESCR.: See is this object is directly underneath another object.
						This is done by passing the baseline of the object above.

		ENTRY	: KJLine	baseline - Bottom vector of object above...

		EXIT	: bool - TRUE is touching...

	*****************************************************************************/

bool MMObject::Under(KJLine baseline)
{
	bool	bSuccess = false;  // Return result - start as not touching

	// First make sure baseline is within X pos of object...
	if( (baseline.x1 > rcDest.x && baseline.x1 < rcDest.x+rcDest.w) || 
		  (baseline.x2 > rcDest.x && baseline.x2 < rcDest.x+rcDest.w)        )
	{
		// Next see if Y is within the first 4 lines of object
		if(baseline.y1 >= rcDest.y && baseline.y1 <= rcDest.y+4)
			bSuccess = true;
	}

	return bSuccess;
}

