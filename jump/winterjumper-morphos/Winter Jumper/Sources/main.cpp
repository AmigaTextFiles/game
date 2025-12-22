/* 
GameBase	->	
Code		->	Roman Hoegg, 2004
License		->	BSD License
*/

#include "_variables.h"			// include shared variables, definitions, etc.

int intLives;
int intPoints;
int intBonus;
int intTime;

int main(int argc, char* argv[])
{
	initSDL();
	SDL_ShowCursor(SDL_DISABLE);
	defineTiles();
    defineEnemies();
	defineGoodies();
	defineGiana();
	setSurfaces();
	intro();
	
	drawBackground(0);
	Print (0,0,  "You may now turn your GP2X off.");
	Print (0,16,  "The next Version will quit to the menu.");
	Print (0,32,  "Promised!");
	SDL_UpdateRect(DisplaySurface,0,0,0,0);
	
	//*********************************
	// terminate program
	//SDL_JoystickClose(pStick);
	fprintf(stdout,"\nprogramm terminated properly!\ngood bye & thanks for playing!\n"); 	//normal termination
	exit(1);
	//*********************************
	return(0);
}

