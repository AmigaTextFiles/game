
/*****************************************************************************

	CLASS		: KScreen
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Wraps up SDL functions to create a video screen surface.
						Other surfaces are derived from this class

	CREATED	:	08/10/01
	UPDATES	:

*****************************************************************************/


#include "KSurface.h"
#include "KScreen.h"

#ifdef ISS_OS
#include <stdio.h>
#endif


KScreen::KScreen()
{
	lpSurface = NULL;					// start with no surface
	bCopied = false;
	iBgColor = 0x0000;
	lastError = 0;
}

KScreen::~KScreen()
{
	//if(lpSurface != NULL && bCopied == false)							// if surface was created
	//	SDL_FreeSurface(lpSurface);			// end gracefully
}



/*****************************************************************************

	NAME	: Create

	DESCR.: Second pass creation to set up surface and depth etc

	ENTRY	: int			width			-	Width of main screen
					int			height		-	Height of main screen
					int			bitDepth	-	bits per pixel of screen
					Uint32	flags			-	flags used by SDL when creating a video screen
															default to SDL_HWSURFACE | SDL_DOUBLEBUF

	EXIT	: bool							- TRUE = created ok.

*****************************************************************************/

bool KScreen::Create(int width, int height, int bitDepth /*=KSCREEN_DEPTH16*/, Uint32 flags /*= SDL_HWSURFACE | SDL_DOUBLEBUF*/)
{
	bool		bSuccess=false;		// successful?

	lastError = ERR_CANT_CREATE_VIDEO_SCREEN;

	if((lpSurface = SDL_SetVideoMode(width, height, bitDepth, flags)))
	{
		KJSize	chrSize = {16,16};
		textStream.Create("data/ascii.bmp", &chrSize, lpSurface);

		cls();
		lastError = ERR_NO_ERROR;
		bSuccess = true;
	}

	return bSuccess;
}



/*****************************************************************************

	NAME	: Create Child Surface

	DESCR.: Create child surface to be display on this

	ENTRY	: SDL_Rect		rcSize - size of child surface

	EXIT	: bool								TRUE created ok.

*****************************************************************************/

bool KScreen::CreateChildSurface(SDL_Rect rcSize)
{
	bool			bSuccess = false;
  KSurface *lpChild;

#ifdef ISS_OS
  printf("KScreen::CreateChildSurface()\n");
#endif

	if( (lpChild = new KSurface()) != NULL)
		if(lpChild->Create(lpSurface, SDL_HWSURFACE, rcSize.x, rcSize.y, rcSize.w, rcSize.h, lpSurface->format->BitsPerPixel))
		{
			AddPtr((long)lpChild);	// add to array

			bSuccess = true;
		}

	return bSuccess;
}


/*****************************************************************************

	NAME	: Create Child Surface

	DESCR.: Create child surface to be display on this

	ENTRY	: SDL_Rect		rcSize - size of child surface

	EXIT	: bool								TRUE created ok.

*****************************************************************************/

bool KScreen::CreateChildBMP(const char *filename)
{
	bool			bSuccess = false;
  KSurface *lpChild;

	if( (lpChild = new KSurface()) != NULL)
		if(lpChild->Create(lpSurface, filename))
		{
			AddPtr((long)lpChild);	// add to array

			bSuccess = true;
		}


	return bSuccess;
}


/*****************************************************************************

	NAME	: Update

	DESCR.: Updates screen buffer

	ENTRY	:

	EXIT	:

*****************************************************************************/

void KScreen::Update()
{
	int l;

	for(l=0; l<GetSize(); l++)
		((KSurface*)GetAt(l))->Update();

#ifdef ISS_OS
	SDL_Rect	rect = {0,0, lpSurface->w, lpSurface->h};
	SDL_UpdateRects(lpSurface,1,&rect);
#else
	SDL_Flip(lpSurface);
#endif
}


void KScreen::UpdateError()
{
  KJPos  pos = {128,128};

  textStream.Print("ERROR ", &pos);
  textStream.Print(lastError);

  SDL_Flip(lpSurface);
}

