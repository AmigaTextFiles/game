#include "_variables.h"

Uint32 timecounter;
Uint32 AnimationCounter = 0;
int StartLevel;
char LevelNumberChar[] = "  ";


void intro()
{
int x;
for(x=0; x<SNOWFLAKES;x++){
SnowPositionX[x] = rand()%320;
SnowPositionY[x] = rand()%240;
}
	StartLevel = 1;
	LEVEL_NUMBER = 0;
	loadLevel();
	getInput();
	int IntroDirection = 1;
	Giana.onground = true;
	getInput();

	//while(Key_ENTER == false && Key_ESCAPE_pressed == false)
	while(Key_ESCAPE_pressed == false)
	{
	if(SDL_GetTicks() - timecounter > 10)
		{
		timecounter = SDL_GetTicks(); 	// reset counter
		drawBackground(LevelBackgroundColour);
		Animation();
		drawTiles();
		Print (8,8,  "jump = B");
		Print (8,219, "Start = Start");
		Print (16,229, "QUIT = Select");
		Print (8,24, "Select Startlevel = ");
//		itoa(StartLevel,LevelNumberChar,10);
        if(StartLevel==1){Print (168,24, "1");}
        if(StartLevel==2){Print (168,24, "2");}
        if(StartLevel==3){Print (168,24, "3");}
        if(StartLevel==4){Print (168,24, "4");}
        if(StartLevel==5){Print (168,24, "5");}
		drawSnow();
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
		if(Giana.x < 0)		{IntroDirection = 1;}
		if(Giana.x > 256*8)	{IntroDirection = 0;}
		if(IntroDirection == 1){Giana.x++;}
		if(IntroDirection == 0){Giana.x--;}
		}
	if(Key_LEFT_pressed == true)   {if(StartLevel>1){StartLevel--;}}
	if(Key_RIGHT_pressed == true)  {if(StartLevel<LASTLEVEL){StartLevel++;}}
	if(Key_ENTER == true)
                 {
                 intLives = 3; intPoints = 0;
                 intBonus = 0;  Giana.weapon = 0;
	             startGame(StartLevel);
                 }
	getInput();
	}
	//else this is the end...
}

void startGame(Uint32 Level)
{
LEVEL_NUMBER = Level;
timecounter = SDL_GetTicks(); 	// reset counter
	while(SDL_GetTicks() - timecounter < 1000)
	{
		drawBlackBackground();
		Print (96,112,  "starting game...");	
		SDL_UpdateRect(DisplaySurface,0,0,0,0);
	}
getInput();
gameLoop();
}
