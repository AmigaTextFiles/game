#include "_variables.h"

SDL_Event sdlEvent;				//event structure
SDL_Rect SrcRect,DstRect;		//source and destination rectangles

SDL_Joystick* pStick;	// define the Joystick
int nStickButtons;
int StickAxis[2];


void initSDL()
{
	//*********************************
	// initialize SDL
	if (SDL_Init(SDL_INIT_VIDEO)==-1)
	{fprintf(stderr,"SDL fucked up!\n");exit(1);}
	else
	{fprintf(stdout,"SDL initialized properly!\n");atexit(SDL_Quit);}
	//*********************************

	//*********************************
	// initialize joystick
	SDL_Init(SDL_INIT_JOYSTICK);
	pStick = SDL_JoystickOpen(0);
	nStickButtons = SDL_JoystickNumButtons(pStick);
	SDL_JoystickEventState(SDL_ENABLE);
	//*********************************
}

