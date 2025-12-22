#include "_variables.h"

void gameLoop()
{
loadLevel();
GianaDied = false;
timecounter = SDL_GetTicks();	// reset counter
AnimationCounter = 0;			// reset counter
Giana.onground = 0;
EnemyAnimationCounter = 0;

/*********************************/
// BEGIN NORMAL GAMELOOP
while(Key_ESCAPE_pressed == false && intLives >= 0)
{
	if(GianaDied == true) {killedScreen(LEVEL_NUMBER);}
	if(exitReached == 1){LEVEL_NUMBER++; loadNextLevelScreen(LEVEL_NUMBER);}

	if(SDL_GetTicks() - timecounter > 13)
	{
	timecounter = SDL_GetTicks(); 	// reset counter
	Animation();
	getInput();
		if(Giana.jumpcounter <= 10 && Giana.jumpcounter > 0){Giana.jumpcounter--;}
		if(Giana.jumpcounter > 10){jumpUp();}
		if(Giana.jumpcounter <= 0){addGravity();}
	checkTileCollission();
	checkLevelEnd();
	checkDiamondCollision();
	checkLethalTile();
	checkGoodieCollision();
	moveEnemies();
	moveBling();
	drawBackground(LevelBackgroundColour);
	drawTiles();
	drawBling();
	drawGiana();
	drawEnemy();
	drawWeapon();
	drawStats();
	drawSnow();
	Print(8,0, "Select  =  QUIT");

	SDL_UpdateRect(DisplaySurface,0,0,0,0);
	}// end of timed loop
} // end of while... (=end of GAMELOOP)
getInput();
GoToIntroScreen();
}

void GoToIntroScreen()
{
timecounter = SDL_GetTicks(); 	// reset counter
	while(SDL_GetTicks() - timecounter < 500)
	{
		drawBlackBackground();
		if(intLives >= 0){Print (96,16,  "   Quitter!?!   ");}
		if(intLives < 0) {Print (96,16,  "    GAME OVER   ");}
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
	}
LEVEL_NUMBER = 0;
loadLevel();
getInput();
}


void loadNextLevelScreen(Uint32 Level)
{
exitReached = 0; 

timecounter = SDL_GetTicks(); 	// reset counter
	while(SDL_GetTicks() - timecounter < 500)
	{
		drawBlackBackground();
		Print (56,112,  "cool dude, next level is on!");
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
	}
loadLevel();
getInput();
}

void killedScreen(Uint32 Level)
{
GianaDied = false;
SDL_Rect GianaDeadRect;
GianaDeadRect.x = LEVEL_XPos + Giana.x;
GianaDeadRect.y = Giana.y+1;
GianaDeadRect.w = GianaDeadSrcRect.w;
GianaDeadRect.h = GianaDeadSrcRect.h;
Giana.weapon = 0;

LEVEL_NUMBER = Level;
intLives--;
int GianaMoveCounter;
GianaMoveCounter = 0;
timecounter = SDL_GetTicks(); 	// reset counter
while(GianaMoveCounter < 30)
{
	if(SDL_GetTicks() - timecounter > 10)
		{
		timecounter = SDL_GetTicks(); 	// reset counter
		drawBackground(LevelBackgroundColour);
		Animation();
		drawTiles();
		GianaDeadRect.y -=3;
		GianaMoveCounter++;
		if(intLives >= 0){Print (96,16,  "oi! you died !!!");}
		if(intLives < 0) {Print (96,16,  "    GAME OVER   ");}
		SDL_BlitSurface(GianaSpritesSurface,&GianaDeadSrcRect,DisplaySurface,&GianaDeadRect);
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
		}
}


while(GianaDeadRect.y < 350)
{
	if(SDL_GetTicks() - timecounter > 10)
		{
		timecounter = SDL_GetTicks(); 	// reset counter
		drawBackground(LevelBackgroundColour);
		Animation();
		drawTiles();
		GianaDeadRect.y +=3;
		if(intLives >= 0){Print (96,16,  "oi! you died !!!");}
		if(intLives < 0) {Print (96,16,  "    GAME OVER   ");}
		SDL_BlitSurface(GianaSpritesSurface,&GianaDeadSrcRect,DisplaySurface,&GianaDeadRect);
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
		}
}

loadLevel();
getInput();
}

