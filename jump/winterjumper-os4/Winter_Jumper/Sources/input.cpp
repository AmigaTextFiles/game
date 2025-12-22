#include "variables.h"
/*
int Key_ESCAPE;
int Key_UP;
int Key_DOWN;
int Key_LEFT;
int Key_RIGHT;
int Button_0;
int Button_1;
int Button_2;
int Button_3;


void getInput()
{
	void SDL_PumpEvents(void);
	if(SDL_PollEvent(&sdlEvent)==0) //IS NEDDED! (WHY?)
	{
	keys = SDL_GetKeyState(NULL);
	Key_ESCAPE = 0;
	Key_UP = 0;
	Key_DOWN = 0;
	Key_LEFT = 0;
	Key_RIGHT = 0;
	Button_0 = 0;
	Button_1 = 0;
	Button_2 = 0;
	Button_3 = 0;

	if (keys[SDLK_ESCAPE] == 1)		{Key_ESCAPE	=	1;}
	if (keys[SDLK_LEFT] == 1)		{Key_LEFT	=	1;}
	if (keys[SDLK_RIGHT] == 1)		{Key_RIGHT	=	1;}
	if (keys[SDLK_DOWN] == 1)		{Key_DOWN	=	1;}
	if (keys[SDLK_UP] == 1)			{Key_UP		=	1;}
	if (keys[SDLK_RSHIFT] == 1)		{Button_1	=	1;}
	
	if(SDL_JoystickGetAxis(SDL_JoystickOpen(0),1) < -100) {Key_UP		=	1;}
	if(SDL_JoystickGetAxis(SDL_JoystickOpen(0),0) < -100) {Key_LEFT		=	1;}
	if(SDL_JoystickGetAxis(SDL_JoystickOpen(0),0) > 100)  {Key_RIGHT	=	1;}
	if(SDL_JoystickGetAxis(SDL_JoystickOpen(0),1) > 100)  {Key_DOWN		=	1;}

	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),0)) {Button_0 = 1;}	// BUTTON 0 IS PRESSED
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),1)) {Button_1 = 1;}	// BUTTON 1 IS PRESSED
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),2)) {Button_2 = 1;}	// BUTTON 2 IS PRESSED
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),3)) {Button_3 = 1;}	// BUTTON 3 IS PRESSED
	}
}

*/
