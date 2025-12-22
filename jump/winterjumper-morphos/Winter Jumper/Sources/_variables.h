#include "sdl/sdl.h"	// include SDL stuff
#include "_keys.h"		// key variables
#include <stdlib.h>				// include ability to exit program
#include <stdio.h>				// ***include ability to read/write files
#include <string.h>

#define FULLSCREEN 1	 //0 = windowed, 1 = fullscreen
#define SCREENWIDTH 320  //screen dimensions (pixel)
#define SCREENHEIGHT 240 //screen dimensions (pixel)
#define LASTLEVEL 5      //number of levels...
#define POINTSPERBLING 25 //number of points per bling...
#define POINTSPERENEMY 50 //number of points per enemy...
#define SNOWFLAKES 50

// FUNCTIONS
	void getInput();
	void intro();
	void initSDL();
	void setSurfaces();
	void loadLevel();
	void drawTiles();
	void defineTiles();
	void drawBackground(int BGColor);
	void drawBlackBackground();
	void gameLoop();
	void defineEnemies();
	void defineGiana();
	void drawGiana();
	void drawEnemy();
	void checkLevelEnd();
	void checkDiamondCollision();
	void checkTileCollission();
	void checkLethalTile();
	void getCurrentTile();
	void addGravity();
	void jumpUp();
	void Animation();
	void startGame(Uint32 Level);
	void killedScreen(Uint32 Level);
	void loadNextLevelScreen(Uint32 Level);
	void EnemyPosition(int EnemyNumber);
	void moveEnemies();
	void resetEnemies();
	void drawStats();
	void drawBling();
	void setBling(int setBlingX, int setBlingY);
	void defineBling();
	void moveBling();
	void GoToIntroScreen();
	void defineGoodies();
	void drawWeapon();
	void checkGoodieCollision();
	void drawSnow();
// FUNCTIONS

// SURFACES
	extern SDL_Surface* DisplaySurface;			//display surface
	extern SDL_Surface* TilesSurface;			//tiles surface
	extern SDL_Surface* GianaSpritesSurface;	//Giana's sprites surface
	extern SDL_Surface* EnemySpritesSurface;	//enemy-sprites surface
	extern SDL_Surface* FontSurface;			//the font surface
	extern SDL_Surface* GoodiesSurface;			//the font surface
// SURFACES

// EVENT STUFF
	extern SDL_Event sdlEvent;				//event structure
// EVENT STUFF

// GOODIES STUFF
	extern SDL_Rect GoodieSrcRect[10];
	extern int GoodieX;
	extern int GoodieY;
// GOODIES STUFF

// INPUT STUFF
    extern SDL_Joystick* pStick;
	extern int nStickButtons;
	extern int StickAxis[2];
	extern int JoyButtonIndex;
	extern Uint8 *keys;
// INPUT STUFF

// TEXT ENGINE
	void DrawChar(int left, int top, char letter);
	void Print(int left, int top, char *str);
// TEXT ENGINE

// LEVEL STUFF
	extern int TileArray[256][30];
	extern int TOTAL_TILES;
	extern int LEVEL_WIDTH;
	extern int LEVEL_HEIGHT;
	extern int LEVEL_NUMBER;
	extern int LEVEL_XPos;
	extern int TopLeft_Tile_X;
	extern int TopRight_Tile_X;
// LEVEL STUFF

// TILES STUFF
	extern SDL_Rect TileSrcRect[10000];
// TILES STUFF

// GIANA STUFF
	extern SDL_Rect GianaRightSrcRect[4];
	extern SDL_Rect GianaLeftSrcRect[4];
	extern SDL_Rect GianaJumpRightSrcRect;
	extern SDL_Rect GianaJumpLeftSrcRect;
	extern SDL_Rect GianaTurnRightSrcRect;
	extern SDL_Rect GianaTurnLeftSrcRect;
	extern SDL_Rect GianaDeadSrcRect;
	extern SDL_Rect GianaPunkRightSrcRect[4];
	extern SDL_Rect GianaPunkLeftSrcRect[4];
	extern SDL_Rect GianaPunkJumpRightSrcRect;
	extern SDL_Rect GianaPunkJumpLeftSrcRect;
	extern SDL_Rect GianaPunkTurnRightSrcRect;
	extern SDL_Rect GianaPunkTurnLeftSrcRect;
	extern int WalkAnimationCounter;
	extern int WalkAnimationNumber;
	extern bool GianaDied;
	extern int CurrentTileTopX[5];
	extern int CurrentTileTopY[5];
	extern int CurrentTileBottomX[5];
	extern int CurrentTileBottomY[5];
	extern int CurrentTileRightX[6];
	extern int CurrentTileRightY[6];
	extern int CurrentTileLeftX[6];
	extern int CurrentTileLeftY[6];
	extern int exitReached;
	extern int intLives;
	extern int intPoints;
	extern int intBonus;
	extern int intTime;
// GIANA STUFF

// GAMESPEED STUFF
	extern Uint32 timecounter;
// GAMESPEED STUFF

// ANIMATION STUFF
	extern Uint32 AnimationCounter;
	extern Uint32 EnemyAnimationCounter;
	extern Uint32 EnemyAnimationNumber;
// ANIMATION STUFF

// BACKGROUND STUFF
	extern int LevelBackgroundColour;
// BACKGROUND STUFF

extern int RepeatCounter;
extern SDL_Rect SrcRect,DstRect;		//source and destination rectangles

typedef struct {
	Sint16 x, y;
	Sint16 xold, yold;
	Uint16 w, h;
	Uint16 jumpcounter;
	bool onground;
	Sint16 accelleration;
	Uint16 direction;
	Uint16 weapon;
} PlayableCharacter;

extern PlayableCharacter Giana;

typedef struct {
	Sint16 x, y;
	Uint16 w, h;
	Uint16 solid;		// values 0,1		(0 = non-solid, 1 = solid)
	Uint16 lethal;		// values 0,1		(0 = non-lethal, 1 = lethal)
	Uint16 action;		// values 0,1,2,3	(0 = nothing, 1 = 1 diamond, 2 = 5 diamonds, 3 = token)
	Sint16 speed;		// values -x...+x	(1 = normal speed)
	Uint16 isexit;		// values 0,1		(1 = end of stage)
	Uint16 breakable;	// values 0,1		(0 = unbreakable, 1 = breakable)
} TileTypesDefinition;

extern TileTypesDefinition TileTypes[1000];

typedef struct {
	Uint16 animated;
	Uint16 nexttile;
} AnimationDefinition;

extern AnimationDefinition TileAnimation[1000];


// BLING STUFF
typedef struct {
	Sint16 active;
	Sint16 x, y;
} BlingDefinition;

extern BlingDefinition Bling[6];
extern int BlingCounter;

// BLING STUFF



// ENEMY STUFF
	typedef struct {
		Sint16 x, y;		//
		Uint16 w, h;		//
		Uint16 alive;		//
		Uint16 direction;	// 0 = Left, 1 = Right
		Uint16 inUse;		// up to 20 enemies can be used per level
		Uint16 type;		//
	} EnemyDefinition;
	extern EnemyDefinition Enemy[20];
	extern Uint16 EnemyPath[10];
	extern Uint16 EnemyFlying[10];
	extern SDL_Rect EnemySrcRightRect[10][6];	//[EnemyType][AnimationFrame]
	extern SDL_Rect EnemySrcLeftRect[10][6];	//[EnemyType][AnimationFrame]
// ENEMY STUFF

extern int MovementSpeed;

extern int SnowPositionX[SNOWFLAKES];
extern int SnowPositionY[SNOWFLAKES];
