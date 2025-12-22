#include "_variables.h"

SDL_Rect BGRect;
int LevelBackgroundColour;

void drawBackground(int BGColor)
{
BGRect.x = 0;
BGRect.y = 0;
BGRect.w = 320;
BGRect.h = 240;
//**********************
// set background-colour
	
	if(BGColor == 0)
	{
	BGColor = SDL_MapRGB(DisplaySurface->format,99,132,231);    // orgiginal color
	}

	if(BGColor == 1)
	{
	BGColor = SDL_MapRGB(DisplaySurface->format,1,1,1);    // black
	}

//**********************

//**********************
// draw background
	SDL_FillRect(DisplaySurface, &BGRect, BGColor);
//**********************
}

void drawBlackBackground()
{
BGRect.x = 0;
BGRect.y = 0;
BGRect.w = 320;
BGRect.h = 240;
//**********************
// set background-colour
//BGColor = SDL_MapRGB(DisplaySurface->format,1,1,1);    // black
//**********************

//**********************
// draw background
	SDL_FillRect(DisplaySurface, &BGRect, SDL_MapRGB(DisplaySurface->format,1,1,1));
//**********************
}
