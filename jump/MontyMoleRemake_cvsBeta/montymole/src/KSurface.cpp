
/*****************************************************************************

	CLASS		: KSurface
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Derived from KScreen, this creates a blank surface for 
						manipulation

	CREATED	:	08/10/01
	UPDATES	: 27/10/01 - Decided to set surface to automitacally have pure 
											 blue as colorkey.

*****************************************************************************/

#include <SDL/SDL.h>
#include "KSurface.h"

#ifdef ISS_OS
#include <stdio.h>
#endif

/*****************************************************************************

	NAME	: Create

	DESCR.: Create a blank surface and attatch to parent window

	ENTRY	: SDL_Surface		*parent	-	parent surface to blit to
					Uint32				flags		-	flags required when creating surface
					int						x,y			-	position of screen on parent
					int						w,h			- size of surface
					int						bitDepth- bits per pixel

	EXIT	:	bool										TRUE - created

*****************************************************************************/

bool KSurface::Create(SDL_Surface *parent, Uint32 flags, int x, int y, int w, int h, int bitDepth)
{
	bool		bSuccess = false;

#ifdef ISS_OS
	printf("KSurface::Create(%d, %d)\n", w,h);
#endif
	if(lpSurface = SDL_CreateRGBSurface(flags, w, h, bitDepth, 0,0,0,0))
	{
		rcDest.x = x;								// Destination bounding blit
		rcDest.y = y;

		rcSrc.x = 0;	// Area of surface to be blitted
		rcSrc.y = 0;
		rcSrc.w = w;
		rcSrc.h = h;

		mode = MODE_SHOW;
		SDL_SetColorKey(lpSurface, SDL_SRCCOLORKEY , SDL_MapRGB(lpSurface->format, 0, 0, 0xFF));

		lpParent = parent;
		bSuccess = true;
	}

	return bSuccess;
}



/*****************************************************************************

	NAME	: Create (From BMP)

	DESCR.: Create a surface from a given bitmap file

	ENTRY	: SDL_Surface		*parent		- parent surface
					const char		*filename - filename of BMP file

	EXIT	: bool

*****************************************************************************/

bool KSurface::Create(SDL_Surface *parent, const char *filename, int x /*=0*/, int y /*=0*/)
{
	bool		bSuccess = false;

	if(lpSurface = SDL_LoadBMP(filename))
	{
		rcDest.x = x;								// Destination bounding blit
		rcDest.y = y;

		rcSrc.x = 0;	// Area of surface to be blitted
		rcSrc.y = 0;
		rcSrc.w = lpSurface->w;
		rcSrc.h = lpSurface->h;

		//lpSurface = SDL_DisplayFormat(lpSurface);

		mode = MODE_SHOW;
		SDL_SetColorKey(lpSurface, SDL_SRCCOLORKEY , SDL_MapRGB(lpSurface->format, 0, 0, 0xFF));

		lpParent = parent;
		bSuccess = true;
	}

	return bSuccess;

}		
/*****************************************************************************

	NAME	: Update

	DESCR.: Update to blit to parent surface

	ENTRY	:

	EXIT	:

*****************************************************************************/
#include <stdio.h>
void KSurface::Update()
{
	if(mode != MODE_HIDE)
		if(SDL_BlitSurface(lpSurface, &rcSrc, lpParent, &rcDest) == -1)
		  printf("Failed blit\n");
}




/*****************************************************************************

		NAME	: In Rect

		DESCR.: Test to see is object(x,y) is within given Rect

		ENTRY	: static SDL_Rect		*lpRect	-	Rect we wish to compare with

		EXIT	: bool												TRUE it is within

	*****************************************************************************/

bool KSurface::InRect(SDL_Rect *lpRect)
{
	
	return ( (lpRect->x+lpRect->w)>=rcDest.x && lpRect->y <= (rcDest.y+rcDest.h) &&
		       lpRect->x <= (rcDest.x+rcDest.w) && (lpRect->y+lpRect->h) >= rcDest.y &&
					 mode == MODE_SHOW);
}

