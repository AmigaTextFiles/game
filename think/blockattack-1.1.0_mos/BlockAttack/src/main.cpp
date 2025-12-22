/*
Block Attack - Rise of the Blocks, SDL games, besed on Nintendo's Tetris Attack
Copyright (C) 2005 Poul Sander

    This program is free software; you can redistribute it and/or modify        
    it under the terms of the GNU General Public License as published by        
    the Free Software Foundation; either version 2 of the License, or           
    (at your option) any later version.                                         
                                                                                
    This program is distributed in the hope that it will be useful,       
    but WITHOUT ANY WARRANTY; without even the implied warranty of              
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               
    GNU General Public License for more details.                
                                                                               
    You should have received a copy of the GNU General Public License           
    along with this program; if not, write to the Free Software                 
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   
                                                                                
    Poul Sander
    Rævehøjvej 36, V. 1111                                                    
    2800 Kgs. Lyngby
    DENMARK
    poul.sander@tdcadsl.dk      
*/

#define VERSION_NUMBER "version 1.1.0"

//Macros to convert surfaces (for faster drawing)
#define CONVERT(n) tmp = SDL_DisplayFormat(n); SDL_FreeSurface(n); n = tmp
#define CONVERTA(n) tmp = SDL_DisplayFormatAlpha(n); SDL_FreeSurface(n); n = tmp

//Used then compiling using MS Visual Studio 2003
#ifdef WIN32
#pragma comment(lib, "SDL.lib")
#pragma comment(lib, "SDLmain.lib")
#pragma comment(lib, "sdl_mixer.lib")
#endif

#ifdef __MORPHOS__
const char *version_tag = "$VER: Block Attack - Raise of the Blocks 1.1.0 (2005-06-20)";
#endif

#include <iostream>
#include <stdlib.h>
#include <time.h>           //Used for srand()
#include <sstream>
#include <string>
#include "SDL.h"            //The SDL libary, used for most things
#include <SDL_mixer.h>      //Used for sound & music
#include <SDL_image.h>      //To load PNG images!

#include "SFont.h"          //Used to write on screen
#include "highscore.h"      //Stores highscores
#include "ReadKeyboard.h"   //Reads text from keyboard
#include "joypad.h"         //Used for joypads
#include <vector>

//Some definitions
#define FRAMELENGTH 50
#define HANGTIME 30
#define FALLTIME 16
#define BLOCKFALL 10000
#define BLOCKWAIT 100000
#define BLOCKHANG 1000
#define GARBAGE 1000000
#define CHAINPLACE 10000000
#define NUMBEROFCHAINS 100

//Animation lengths:
    #define READYTIME 500
    #define BOMBTIME 200
    #define CURSORTIME 200


using namespace std;	//remove it if you dare...

//All graphic in the game (as pointers):
SDL_Surface *background;    //Stores background
SDL_Surface *backgroundImage; //Stores the background image
int backgroundImageW, backgroundImageH; //size of background image
SDL_Surface *backBoard;     //Stores the background to the board
SDL_Surface *b1player;
SDL_Surface *b2players;
SDL_Surface *bVsMode;
SDL_Surface *bStageClear;
SDL_Surface *bPuzzle;
SDL_Surface *bNewGame;      //The New Game botton
SDL_Surface *bEndless;      //Endless button (sub to new)
SDL_Surface *bTimeTrial;    //Time trial button (sub to new)
SDL_Surface *bOptions;      //The Options botton
SDL_Surface *bHighScore;    //The High Score botton
SDL_Surface *bExit;         //The Exit botton
SDL_Surface *blackLine;		//The seperator in stage clear
SDL_Surface *stageBobble;	//The bobble instage clear
SDL_Surface *screen;        //The whole screen;
SDL_Surface *iGameOver;     //The gameOver image
SDL_Surface *iWinner;		//the "winner" image
SDL_Surface *iDraw;			//the "draw" image
SDL_Surface *iLoser;		//the "loser" image
//Animations:
SDL_Surface *cursor[2];    //The animated cursor
SDL_Surface *bomb[2];       //Bomb then the bricks should blow
SDL_Surface *ready[2];      //Before the blocks fall
SDL_Surface *explosion[4];   //Then a block explodes
//Animations end
SDL_Surface *counter[3];    //Counts down from 3
SDL_Surface *bricks[7];     //The bricks, saved in an array of pointers
SDL_Surface *crossover;     //Cross the bricks that will be cleared soon
SDL_Surface *balls[7];      //The balls (the small ones that jump around)
SDL_Surface *iBlueFont;      //Contains the blue font used
SDL_Surface *topscoresBack;  //The backgound to the highscore list
SDL_Surface *optionsBack;
SDL_Surface *changeButtonsBack;
SDL_Surface *dialogBox;
SDL_Surface *bOn;
SDL_Surface *bOff;
SDL_Surface *bChange;
SDL_Surface *b1024;
SDL_Surface *b1280;
SDL_Surface *b1400;
SDL_Surface *b1600;
SDL_Surface *iLevelCheck;		//To the level select screen
SDL_Surface *iLevelCheckBox;
SDL_Surface *iCheckBoxArea;
SDL_Surface *boardBackBack;
SDL_Surface *garbageTL;			//the Garbage Blocks
SDL_Surface *garbageT;
SDL_Surface *garbageTR;
SDL_Surface *garbageR;
SDL_Surface *garbageBR;
SDL_Surface *garbageB;
SDL_Surface *garbageBL;
SDL_Surface *garbageL;
SDL_Surface *garbageFill;
SDL_Surface *garbageM;
SDL_Surface *garbageML;
SDL_Surface *garbageMR;
SDL_Surface *mouse;				//The mouse cursor


SDL_Surface *tmp;				//a temporary surface to use DisplayFormat


SFont_Font *fBlueFont;      //Stores the blue font (SFont)

Mix_Music *bgMusic;         //backgroundMusic
Mix_Chunk *boing;           //boing sound when clearing
Mix_Chunk *timesUp;         //whistle when times up
Mix_Chunk *applause;        //Applause, then the player is good
Mix_Chunk *photoClick;      //clickSound
Mix_Chunk *heartBeat;		//heart beat
Mix_Chunk *typingChunk;          //When writing
Mix_Chunk *counterChunk;         //When counting down

Highscore theTopScoresEndless;      //Stores highscores for endless
Highscore theTopScoresTimeTrial;    //Stores highscores for timetrial

bool bMouseUp;              //true if the mouse(1) is unpressed
bool bMouseUp2;             //true if the mouse(2) is unpressed
bool bNewGameOpen;          //show sub menues
bool b1playerOpen;			//show submenu
bool b2playersOpen;			//show submenu
bool showHighscores;        //true if highscores is displayed
bool showEndless;           //if true show endless highscores else timetrial
bool showGame;              //the game is active don't show highscores/options
bool showOptions;           //true if options is open
bool bScreenLocked;			//Don't take input or allow any mouse interaction! Used for dialogbox and warningbox
bool showDialog;
bool MusicEnabled;			//true if background music is enabled
bool SoundEnabled;			//true if sound effects is enabled
bool bFullscreen;			//true if game is running fullscreen
bool puzzleLoaded;          //true if the puzzle levels have been loaded
bool drawBalls;             //if true balls are drawed to the screen, this might lower framerate too much
bool standardBackground;
                            //should be automatically disabled if framerate to low:
const int ballsFpsEnable = 30;     //If framerate higher -> enable balls
const int ballsFpsDisable = 10;    //If framerate lower -> disable balls

//other ball constants:
const double gravity = 200.8; //acceleration
const double startVelocityY = 50.0;
const double VelocityX = 50.0;
const int ballSize = 16;
const double minVelocity = 200.0; 



unsigned long int currentTime;      //contains the current time, so we don't call SDL_GetTickets() too often...

int xsize;

//Stores the players names
char player1name[30];
char player2name[30];

//paths
string stageClearSavePath;
string puzzleSavePath;

const int nrOfStageLevels = 50;		//number of stages in stage Clear
const int maxNrOfPuzzleStages = 50; //Maximum number of puzzle stages
vector<bool> stageCleared(nrOfStageLevels);		//vector that tells if a stage is cleared
vector<bool> puzzleCleared(maxNrOfPuzzleStages); //vector that tells if puzzle cleared
vector<int> nrOfMovesAllowed(maxNrOfPuzzleStages);  //Moves to clear
int puzzleLevels[maxNrOfPuzzleStages][6][12]; //Contains board layout;
int nrOfPuzzles;    //How many are there actually?

//Old mouse position:
int oldMousex, oldMousey, olderMousex,olderMousey;
//Old Stage Clear Buble
int oldBubleX, oldBubleY, olderBubleX,olderBubleY;

bool doublebuf = false; //if true, screen is double buffered
char forceredraw; //If 1: always redraw, if 2: rarely redraw

//frame counter (fps)
unsigned long int Frames, Ticks;
char FPS[10];

//keySetup
int player1keys, player2keys;
bool mouseplay1=false;  //The mouse works on the play field
bool mouseplay2=false;  //Same for player2
bool joyplay1=false;    //Player one uses the joypad
bool joyplay2=false;    //Player two uses the joypad

  //Stores the controls
  struct control
  {
	  SDLKey up;
	  SDLKey down;
	  SDLKey left;
	  SDLKey right;
	  SDLKey change;
	  SDLKey push;
  };

  control keySettings[3];	//array to hold the controls

  void MakeBackground(int,int);



//Load all image files to memory
int InitImages()
{
    if (!((backgroundImage = IMG_Load("gfx/background.jpg"))
    && (background = IMG_Load("gfx/blackBackGround.png")) 
    && (bNewGame = IMG_Load("gfx/bNewGame.png"))
	&& (b1player = IMG_Load("gfx/bOnePlayer.png"))
	&& (b2players = IMG_Load("gfx/bTwoPlayers.png"))
	&& (bVsMode = IMG_Load("gfx/bVsGame.png"))
	&& (bPuzzle = IMG_Load("gfx/bPuzzle.png"))
	&& (bStageClear = IMG_Load("gfx/bStageClear.png"))
    && (bTimeTrial = IMG_Load("gfx/bTimeTrial.png"))
    && (bEndless = IMG_Load("gfx/bEndless.png"))
    && (bOptions = IMG_Load("gfx/bOptions.png"))
    && (bHighScore = IMG_Load("gfx/bHighScore.png"))
    && (bExit = IMG_Load("gfx/bExit.png"))
	&& (blackLine = IMG_Load("gfx/blackLine.png"))
	&& (stageBobble = IMG_Load("gfx/iStageClearLimit.png"))
    && (bricks[0] = IMG_Load("gfx/blue.png"))
    && (bricks[1] = IMG_Load("gfx/green.png"))
    && (bricks[2] = IMG_Load("gfx/purple.png"))
    && (bricks[3] = IMG_Load("gfx/red.png"))
    && (bricks[4] = IMG_Load("gfx/turkish.png"))
    && (bricks[5] = IMG_Load("gfx/yellow.png"))
    && (bricks[6] = IMG_Load("gfx/grey.png"))
    && (crossover = IMG_Load("gfx/crossover.png"))
    && (balls[0] = IMG_Load("gfx/balls/ballBlue.png"))
    && (balls[1] = IMG_Load("gfx/balls/ballGreen.png"))
    && (balls[2] = IMG_Load("gfx/balls/ballPurple.png"))
    && (balls[3] = IMG_Load("gfx/balls/ballRed.png"))
    && (balls[4] = IMG_Load("gfx/balls/ballTurkish.png"))
    && (balls[5] = IMG_Load("gfx/balls/ballYellow.png"))
    && (balls[6] = IMG_Load("gfx/balls/ballGray.png"))
    && (cursor[0] = IMG_Load("gfx/animations/cursor/1.png"))
    && (cursor[1] = IMG_Load("gfx/animations/cursor/2.png"))
    && (bomb[0] = IMG_Load("gfx/animations/bomb/bomb_1.png"))
    && (bomb[1] = IMG_Load("gfx/animations/bomb/bomb_2.png"))
    && (ready[0] = IMG_Load("gfx/animations/ready/ready_1.png"))
    && (ready[1] = IMG_Load("gfx/animations/ready/ready_2.png"))
    && (explosion[0] = IMG_Load("gfx/animations/explosion/0.png"))
    && (explosion[1] = IMG_Load("gfx/animations/explosion/1.png"))
    && (explosion[2] = IMG_Load("gfx/animations/explosion/2.png"))
    && (explosion[3] = IMG_Load("gfx/animations/explosion/3.png"))
    && (counter[0] = IMG_Load("gfx/counter/1.png"))
    && (counter[1] = IMG_Load("gfx/counter/2.png"))
    && (counter[2] = IMG_Load("gfx/counter/3.png"))
    && (backBoard = IMG_Load("gfx/BackBoard.png")) //not used, we just test if it exists :)
    && (iGameOver = IMG_Load("gfx/iGameOver.png"))
	&& (iWinner = IMG_Load("gfx/iWinner.png"))
	&& (iDraw = IMG_Load("gfx/iDraw.png"))
	&& (iLoser = IMG_Load("gfx/iLoser.png"))
    //&& (iBlueFont = IMG_Load("gfx/24P_Copperplate_Blue.png"))
    && (iBlueFont = IMG_Load("gfx/24P_Arial_Blue.png"))
    && (topscoresBack = IMG_Load("gfx/topscores.png"))
	&& (optionsBack = IMG_Load("gfx/options.png"))
	&& (bOn = IMG_Load("gfx/bOn.png"))
	&& (bOff = IMG_Load("gfx/bOff.png"))
	&& (bChange = IMG_Load("gfx/bChange.png"))
	&& (b1024 = IMG_Load("gfx/b1024.png"))
	&& (b1280 = IMG_Load("gfx/b1280.png"))
	&& (b1400 = IMG_Load("gfx/b1400.png"))
	&& (b1600 = IMG_Load("gfx/b1600.png"))
	&& (dialogBox = IMG_Load("gfx/dialogbox.png"))
	&& (iLevelCheck = IMG_Load("gfx/iLevelCheck.png"))
	&& (iLevelCheckBox = IMG_Load("gfx/iLevelCheckBox.png"))
	&& (iCheckBoxArea = IMG_Load("gfx/iCheckBoxArea.png"))
	&& (boardBackBack = IMG_Load("gfx/boardBackBack.png"))
	&& (changeButtonsBack = IMG_Load("gfx/changeButtonsBack.png"))
	&& (garbageTL = IMG_Load("gfx/garbage/garbageTL.png"))
	&& (garbageT = IMG_Load("gfx/garbage/garbageT.png"))
	&& (garbageTR = IMG_Load("gfx/garbage/garbageTR.png"))
	&& (garbageR = IMG_Load("gfx/garbage/garbageR.png"))
	&& (garbageBR = IMG_Load("gfx/garbage/garbageBR.png"))
	&& (garbageB = IMG_Load("gfx/garbage/garbageB.png"))
	&& (garbageBL = IMG_Load("gfx/garbage/garbageBL.png"))
	&& (garbageL = IMG_Load("gfx/garbage/garbageL.png"))
	&& (garbageFill = IMG_Load("gfx/garbage/garbageFill.png"))
	&& (garbageML = IMG_Load("gfx/garbage/garbageML.png"))
	&& (garbageM = IMG_Load("gfx/garbage/garbageM.png"))
	&& (garbageMR = IMG_Load("gfx/garbage/garbageMR.png"))
	&& (mouse = IMG_Load("gfx/mouse.png"))
	))
    //if there was a problem ie. "File not found"
    {
        cout << "Error loading image file: " << SDL_GetError() << endl;
        exit(1);
    }
    

    //Prepare for fast blittering!
	CONVERT(background);
	CONVERT(bNewGame);
	CONVERT(backgroundImage);
	CONVERT(b1player);
	CONVERT(b2players);
	CONVERT(bVsMode);
	CONVERT(bPuzzle);
	CONVERT(bStageClear);
    CONVERT(bTimeTrial);
    CONVERT(bEndless);
    CONVERT(bOptions);
    CONVERT(bHighScore);
	CONVERTA(boardBackBack);
	CONVERT(backBoard);
	CONVERT(blackLine);
	CONVERT(changeButtonsBack);
    CONVERTA(cursor[0]);
	CONVERTA(cursor[1]);
	CONVERTA(counter[0]);
	CONVERTA(counter[1]);
	CONVERTA(counter[2]);
	CONVERT(topscoresBack);
	CONVERT(optionsBack);
	CONVERT(bExit);
	CONVERT(bOn);
	CONVERT(bOff);
	CONVERT(bChange);
	CONVERT(b1024);
	CONVERT(dialogBox);
	CONVERTA(iLevelCheck);
	CONVERT(iLevelCheckBox);
	CONVERTA(iCheckBoxArea);
	for(int i = 0;i<4;i++)
	{
        CONVERTA(explosion[i]);
    }
	for(int i = 0; i<7; i++)
	{
        CONVERTA(bricks[i]);
        CONVERTA(balls[i]);
	}
	CONVERTA(crossover);
	CONVERTA(garbageTL);
	CONVERTA(garbageT);
	CONVERTA(garbageTR);
	CONVERTA(garbageR);
	CONVERTA(garbageBR);
	CONVERTA(garbageB);
	CONVERTA(garbageBL);
	CONVERTA(garbageL);
	CONVERTA(garbageFill);
	CONVERTA(garbageML);
	CONVERTA(garbageMR);
	CONVERTA(garbageM);
	CONVERTA(iWinner);
	CONVERTA(iDraw);
	CONVERTA(iLoser);
	CONVERTA(iBlueFont);
	CONVERTA(iGameOver);
	CONVERTA(mouse);
	CONVERTA(stageBobble);
	
	SDL_SetColorKey(topscoresBack, SDL_SRCCOLORKEY, 
                    SDL_MapRGB(topscoresBack->format, 0, 255, 0));
    SDL_SetColorKey(optionsBack, SDL_SRCCOLORKEY, 
                    SDL_MapRGB(optionsBack->format, 0, 255, 0));


    //Here comes the fonts:
    fBlueFont = SFont_InitFont(iBlueFont);


    //And here the music:
    bgMusic = Mix_LoadMUS("music/bgMusic.ogg");
	//the music... we just hope it exists, else the user won't hear anything
    //Same goes for the sounds
    boing = Mix_LoadWAV("sound/pop.ogg");
    timesUp = Mix_LoadWAV("sound/whistleblow.ogg");
    applause = Mix_LoadWAV("sound/applause.ogg");
    photoClick = Mix_LoadWAV("sound/cameraclick.ogg");
	heartBeat = Mix_LoadWAV("sound/heartbeat3.ogg");
	typingChunk = Mix_LoadWAV("sound/typing.ogg");
	counterChunk = Mix_LoadWAV("sound/counter.ogg");
    return 0;
} //InitImages()


//Unload images and fonts and sounds
void UnloadImages()
{
    //Fonts and Sounds needs to be freed
    SFont_FreeFont(fBlueFont);
    Mix_FreeMusic(bgMusic);
    Mix_FreeChunk(boing);
    Mix_FreeChunk(timesUp);
    Mix_FreeChunk(applause);
    Mix_FreeChunk(photoClick);
	Mix_FreeChunk(heartBeat);
	Mix_FreeChunk(counterChunk);
	Mix_FreeChunk(typingChunk);
    //Free surfaces:
        //I think this will crash, at least it happend to me...
    /*SDL_FreeSurface(backgroundImage);
    SDL_FreeSurface(background); 
    SDL_FreeSurface(bNewGame);
	SDL_FreeSurface(b1player);
	SDL_FreeSurface(b2players);
	SDL_FreeSurface(bVsMode);
	SDL_FreeSurface(bPuzzle);
	SDL_FreeSurface(bStageClear);
    SDL_FreeSurface(bTimeTrial);
    SDL_FreeSurface(bEndless);
    SDL_FreeSurface(bOptions);
    SDL_FreeSurface(bHighScore);
    SDL_FreeSurface(bExit);
	SDL_FreeSurface(blackLine);
	SDL_FreeSurface(stageBobble);
    SDL_FreeSurface(bricks[0]);
    SDL_FreeSurface(bricks[1]);
    SDL_FreeSurface(bricks[2]);
    SDL_FreeSurface(bricks[3]);
    SDL_FreeSurface(bricks[4]);
    SDL_FreeSurface(bricks[5]);
    SDL_FreeSurface(bricks[6]);
    SDL_FreeSurface(crossover);
    SDL_FreeSurface(balls[0]);
    SDL_FreeSurface(balls[1]);
    SDL_FreeSurface(balls[2]);
    SDL_FreeSurface(balls[3]);
    SDL_FreeSurface(balls[4]);
    SDL_FreeSurface(balls[5]);
    SDL_FreeSurface(balls[6]);
    SDL_FreeSurface(cursor[0]);
    SDL_FreeSurface(cursor[1]);
    SDL_FreeSurface(backBoard); //not used, we just test if it exists :)
    SDL_FreeSurface(iGameOver);
	SDL_FreeSurface(iWinner);
	SDL_FreeSurface(iDraw);
	SDL_FreeSurface(iLoser);
    SDL_FreeSurface(iBlueFont);
    SDL_FreeSurface(topscoresBack);
	SDL_FreeSurface(optionsBack);
	SDL_FreeSurface(bOn);
	SDL_FreeSurface(bOff);
	SDL_FreeSurface(bChange);
	SDL_FreeSurface(b1024);
	SDL_FreeSurface(b1280);
	SDL_FreeSurface(b1400);
	SDL_FreeSurface(b1600);
	SDL_FreeSurface(dialogBox);
	SDL_FreeSurface(iLevelCheck);
	SDL_FreeSurface(iLevelCheckBox);
	SDL_FreeSurface(iCheckBoxArea);
	SDL_FreeSurface(boardBackBack);
	SDL_FreeSurface(changeButtonsBack);
	SDL_FreeSurface(garbageTL);
	SDL_FreeSurface(garbageT);
	SDL_FreeSurface(garbageTR);
	SDL_FreeSurface(garbageR);
	SDL_FreeSurface(garbageBR);
	SDL_FreeSurface(garbageB);
	SDL_FreeSurface(garbageBL);
	SDL_FreeSurface(garbageL);
	SDL_FreeSurface(garbageFill);
	SDL_FreeSurface(garbageML);
	SDL_FreeSurface(garbageM);
	SDL_FreeSurface(garbageMR);
	SDL_FreeSurface(mouse); 
    */
}    

//Function to convert numbers to string
string itoa(int num)
{
    stringstream converter;
    converter << num;
    return converter.str();
}

/*Loads all the puzzle levels*/
int LoadPuzzleStages()
{
    if(puzzleLoaded)
        return 1;
    ifstream inFile("res/puzzle.levels");
    inFile >> nrOfPuzzles;
    if(nrOfPuzzles>maxNrOfPuzzleStages)
        nrOfPuzzles=maxNrOfPuzzleStages;
    for(int k=0; k<nrOfPuzzles; k++)
    {
        inFile >> nrOfMovesAllowed[k];
        for(int i=11;i>=0;i--)
            for(int j=0;j<6;j++)
            {
                inFile >> puzzleLevels[k][j][i];
            }
    }
    puzzleLoaded = true;
    return 0;
}

/*Draws a image from on a given Surface. Takes source image, destination surface and coordinates*/
inline void DrawIMG(SDL_Surface *img, SDL_Surface *target, int x, int y)
{
  SDL_Rect dest;
  dest.x = x;
  dest.y = y;
  SDL_BlitSurface(img, NULL, target, &dest);
}

/*Draws a part of an image on a surface of choice*/
void DrawIMG(SDL_Surface *img, SDL_Surface * target, int x, int y, int w, int h, int x2, int y2)
{
  SDL_Rect dest;
  dest.x = x;
  dest.y = y;
  SDL_Rect dest2;
  dest2.x = x2;
  dest2.y = y2;
  dest2.w = w;
  dest2.h = h;
  SDL_BlitSurface(img, &dest2, target, &dest);
}

//The small things that are faaling when you clear something
class aBall
{
    private:
        double x;
        double y;
        double velocityY;
        double velocityX;
        int color;
        unsigned long int lastTime;
    public:
               
        aBall()
        {}       
               
        //constructor:
        aBall(int X, int Y, bool right, int coulor)
        {
            double tal = 1.0;
            velocityY = -tal*startVelocityY;
            lastTime = currentTime;
            x = (double)X;
            y = (double)Y;
            color = coulor;
            if(right)
               velocityX = tal*VelocityX;
            else
               velocityX = -tal*VelocityX;
        }  //constructor  
        
        //Deconstructor
        ~aBall()
        {
        }   //Deconstructor
        
        void update()
        {
            double timePassed = (((double)(currentTime-lastTime))/1000.0);  //time passed in seconds
            x = x+timePassed*velocityX;
            y = y+timePassed*velocityY;
            velocityY = velocityY + gravity*timePassed;
            if(y<1.0)
            velocityY=10.0;
            if((velocityY>minVelocity) && (y>(double)(768-ballSize)) && (y<768.0))
            {
                velocityY = -0.70*velocityY;
                y = 768.0-ballSize;
            }    
            lastTime = currentTime;
        }    
        
        int getX()
        {
            return (int)x;
        }    
        
        int getY()
        {
            return (int)y;
        }  
        
        int getColor()
        {
            return color;
        }      
};  //aBall

const int maxNumberOfBalls = 100;

class ballManeger
{
    public:
        aBall ballArray[maxNumberOfBalls];
        bool ballUsed[maxNumberOfBalls];
        //The old ball information is also saved so balls can be deleted!
        aBall oldBallArray[maxNumberOfBalls];
        bool oldBallUsed[maxNumberOfBalls];
        //The even older balls then double buffered!
        aBall olderBallArray[maxNumberOfBalls];
        bool olderBallUsed[maxNumberOfBalls];
        
    ballManeger()
    {
        for(int i=0; i<maxNumberOfBalls; i++)
        {
                ballUsed[i] = false;
                oldBallUsed[i] = false;
                olderBallUsed[i] = false;
        }
    }    
    
    int addBall(int x, int y,bool right,int color)
    {
        //cout << "Tries to add a ball" << endl;
        int ballNumber = 0;
        while((ballUsed[ballNumber])&&(ballNumber<maxNumberOfBalls))
        ballNumber++;
        if(ballNumber==maxNumberOfBalls)
        return -1;
        currentTime = SDL_GetTicks();
        ballArray[ballNumber] = aBall(x,y,right,color);
        ballUsed[ballNumber] = true;
        //cout << "Ball added" << endl;
        return 1;
    }  //addBall  
    
    void update()
    {
        currentTime = SDL_GetTicks();
        for(int i = 0; i<maxNumberOfBalls; i++)
        {
            if(oldBallUsed[i])
            {
               olderBallUsed[i] = true;
               olderBallArray[i] = oldBallArray[i];
            }  
            else
            {
                olderBallUsed[i] = false;
            }
            
            if(ballUsed[i])
            {
               oldBallUsed[i] = true;
               oldBallArray[i] = ballArray[i];
               ballArray[i].update();
               if(ballArray[i].getY()>800)
               {
                   ballArray[i].~aBall();
                   ballUsed[i] = false;
                   //cout << "Ball removed" << endl;
               }    
            }    
            else
            {
                oldBallUsed[i] = false;
            }
        }    
    } //update
    
          
}; //theBallManeger

ballManeger theBallManeger;

//a explosions, non moving
class anExplosion
{
    private:
        int x;
        int y;
        Uint8 frameNumber;
        #define frameLength 80 
        //How long an image in an animation should be showed
        #define maxFrame 4 
        //How many images there are in the animation
        unsigned long int placeTime; //Then the explosion occored
    public:
               
        anExplosion()
        {}       
               
        //constructor:
        anExplosion(int X, int Y)
        {
            placeTime = currentTime;
            x = X;
            y = Y;
            frameNumber=0;
        }  //constructor  
        
        //Deconstructor
        ~anExplosion()
        {
        }   //Deconstructor
        
        //true if animation has played and object should be removed from the screen
        bool removeMe()
        {
            frameNumber = (currentTime-placeTime)/frameLength;
            return (!(frameNumber<maxFrame));
        }
        
        int getX()
        {
            return (int)x;
        }    
        
        int getY()
        {
            return (int)y;
        }  
        
        int getFrame()
        {
            return frameNumber;
        }      
};  //nExplosion

class explosionManeger
{
    public:
        anExplosion explosionArray[maxNumberOfBalls];
        bool explosionUsed[maxNumberOfBalls];
        //The old explosion information is also saved so explosions can be deleted!
        anExplosion oldExplosionArray[maxNumberOfBalls];
        bool oldExplosionUsed[maxNumberOfBalls];
        //The even older explosions then double buffered!
        anExplosion olderExplosionArray[maxNumberOfBalls];
        bool olderExplosionUsed[maxNumberOfBalls];
        
    explosionManeger()
    {
        for(int i=0; i<maxNumberOfBalls; i++)
        {
                explosionUsed[i] = false;
                oldExplosionUsed[i] = false;
                olderExplosionUsed[i] = false;
        }
    }    
    
    int addExplosion(int x, int y)
    {
        //cout << "Tries to add an explosion" << endl;
        int explosionNumber = 0;
        while((explosionUsed[explosionNumber])&&(explosionNumber<maxNumberOfBalls))
        explosionNumber++;
        if(explosionNumber==maxNumberOfBalls)
        return -1;
        currentTime = SDL_GetTicks();
        explosionArray[explosionNumber] = anExplosion(x,y);
        explosionUsed[explosionNumber] = true;
        //cout << "Explosion added" << endl;
        return 1;
    }  //addBall  
    
    void update()
    {
        currentTime = SDL_GetTicks();
        for(int i = 0; i<maxNumberOfBalls; i++)
        {
            if(oldExplosionUsed[i])
            {
               olderExplosionUsed[i] = true;
               olderExplosionArray[i] = oldExplosionArray[i];
            }  
            else
            {
                olderExplosionUsed[i] = false;
            }
            
            if(explosionUsed[i])
            {
               oldExplosionUsed[i] = true;
               oldExplosionArray[i] = explosionArray[i];
               if(explosionArray[i].removeMe())
               {
                   explosionArray[i].~anExplosion();
                   explosionUsed[i] = false;
                   //cout << "Explosion removed" << endl;
               }    
            }    
            else
            {
                oldExplosionUsed[i] = false;
            }
        }    
    } //update
    
          
}; //explosionManeger

explosionManeger theExplosionManeger;

//text pop-up
/*class textMessage
{
    private:
        int x;
        int y;
        string text;
        unsigned long int time;
        unsigned long int placeTime; //Then the text was placed
    public:
               
        textMessage()
        {}       
               
        //constructor:
        textMessage(int X, int Y,string Text,unsigned int Time)
        {
            placeTime = currentTime;
            x = X;
            y = Y;
            text = Text;
            time = Time;
        }  //constructor  
        
        //Deconstructor
        ~textMessage()
        {
        }   //Deconstructor
        
        //true if the text has expired
        bool removeMe()
        {
            return currentTime-placeTime>time;
        }
        
        int getX()
        {
            cout << "Gets X" << endl;
            return x;
        }    
        
        int getY()
        {
            cout << "Gets Y" << endl;
            return y;
        }  
        
        string getText()
        {
            cout << "Gets text" << endl;
            return text;
        }      
};  //text popup

class textManeger
{
    public:
        textMessage textArray[maxNumberOfBalls];
        bool textUsed[maxNumberOfBalls];
        //The old text information is also saved so text can be deleted!
        textMessage oldTextArray[maxNumberOfBalls];
        bool oldTextUsed[maxNumberOfBalls];
        //The even older texts then double buffered!
        textMessage olderTextArray[maxNumberOfBalls];
        bool olderTextUsed[maxNumberOfBalls];
        
    textManeger()
    {
        for(int i=0; i<maxNumberOfBalls; i++)
        {
                textUsed[i] = false;
                oldTextUsed[i] = false;
                olderTextUsed[i] = false;
        }
    }    
    
    int addText(int x, int y,string Text,unsigned int Time)
    {
        //cout << "Tries to add text" << endl;
        int textNumber = 0;
        while((textUsed[textNumber])&&(textNumber<maxNumberOfBalls))
        textNumber++;
        if(textNumber==maxNumberOfBalls)
        return -1;
        currentTime = SDL_GetTicks();
        textArray[textNumber] = textMessage(x,y,Text,Time);
        textUsed[textNumber] = true;
        cout << "Text added" << endl;
        return 1;
    }  //addText  
    
    void update()
    {
        cout << "Running update" << endl;
        currentTime = SDL_GetTicks();
        for(int i = 0; i<maxNumberOfBalls; i++)
        {
            if((oldTextUsed[i])&&(!olderTextUsed[i]))
            {
               olderTextUsed[i] = true;
               if(NULL==&olderTextArray[i]) cout << "Hello!" << endl;
               olderTextArray[i] = oldTextArray[i];
            }  
            else
            if(olderTextUsed[i])
            {
                olderTextUsed[i] = false;
                olderTextArray[i].~textMessage();
                cout << "Older Text removed" << endl;
            }
            
            if(textUsed[i])
            {
                cout << "Her" << endl;
               if(!oldTextUsed[i])
               {
                    oldTextUsed[i] = true;
                    oldTextArray[i] = textArray[i];
               } 
               if(textArray[i].removeMe())
               {
                   textArray[i].~textMessage();
                   textUsed[i] = false;
                   cout << "Text removed" << endl;
               }    
            }    
            else
            if(oldTextUsed[i])
            {
                cout << "Her2" << endl;
                oldTextUsed[i] = false;
                oldTextArray[i].~textMessage();
                cout << "Old Text removed" << endl;
            }
        }    
    } //update
    
          
}; //textManeger

textManeger theTextManeger;*/

////////////////////////////////////////////////////////////////////////////////
//The BloackGame class represents a board, score, time etc. for a single player/
////////////////////////////////////////////////////////////////////////////////
class BlockGame
{
    private:
        int prevTowerHeight;
        bool bGarbageFallLeft;
		bool hasWonTheGame;
		bool bDraw;
		Uint32 nextGarbageNumber;
        int pushedPixelAt;
		int nrPushedPixel, nrFellDown, nrStops;
		bool garbageToBeCleared[7][30];
		bool AI_Enabled;
		Sint16 AI_LineOffset; //how many lines have changed since command
		string strHolder;
		unsigned int hangTicks;    //How many times have hang been decreased?
		//int the two following index 0 may NOT be used
		Uint8 chainSize[NUMBEROFCHAINS]; //Contains the chains
		bool chainUsed[NUMBEROFCHAINS];   //True if the chain is used    

        int firstUnusedChain()
        {
            bool found=false;
            int i = 0;
            while(!found)
            {
                if(!chainUsed[++i])
                    found=true;
                if(i>NUMBEROFCHAINS-2)
                    found=true;
            }
            return i;
        }

    public:
		char name[30];
        int gameStartedAt;
        int linesCleared;
        SDL_Surface* sBoard;
		int TowerHeight;
		BlockGame *garbageTarget;
        Sint32 board[7][30];
        int stop;
		int speedLevel;
        int pixels;
        int MovesLeft;
        bool timetrial, stageClear, vsMode, puzzleMode;
		int Level; //Only used in stageClear and puzzle (not implemented)
        int stageClearLimit; //stores number of lines user must clear to win
        int topx,topy;
        int combo;
        int chain;
        int cursorx; //stores cursor position
        int cursory; // -||-
        double speed, baseSpeed; //factor for speed. Lower value = faster gameplay
        unsigned long int score;    
        bool bGameOver;
        int AI_MoveSpeed;   //How often will the computer move? milliseconds
                   

		//Constructor
        BlockGame(int tx, int ty)
        {
           tmp = IMG_Load("gfx/BackBoard.png");
		   sBoard = SDL_DisplayFormat(tmp);
		   SDL_FreeSurface(tmp);
           srand((int)time(NULL));
		   nrFellDown = 0;
		   nrPushedPixel = 0;
		   garbageTarget = this;
		   nrStops=0;
           topx = tx;
           topy = ty;
           cursorx = 2;
           cursory = 3;
           stop = 0;
           pixels = 0;
           score = 0;
           bGameOver = false;
           bDraw = false;
		   timetrial = false;
           stageClear = false;
		   vsMode = false;
		   puzzleMode = false;
		   linesCleared = 0;
		   AI_Enabled = false;
		   hasWonTheGame = false;
           combo=0;                      //counts 
           chain=0;
           hangTicks = 0;
           baseSpeed = 0.5;           //All other speeds are relative to this
           speed = baseSpeed;
		   speedLevel = 1;
           gameStartedAt = SDL_GetTicks();
           pushedPixelAt = gameStartedAt;
		   nextGarbageNumber = 10;
           for(int i=0;i<7;i++)
           for(int j=0;j<30;j++)
           {
              board[i][j] = -1;
           }
           for(int i=0;i<NUMBEROFCHAINS;i++)
           {
                chainUsed[i]=false;
                chainSize[i] = 0;
            }
           showGame = true;              //The game is now active
        }	//Constructor
        
		//Deconstructor, never really used... game used to crash when called, cause of the way sBoard was created
        ~BlockGame()
        {
            SDL_FreeSurface(sBoard);
        }    
        
        //Loads BackBoard again if surface format has changed
        void convertSurface()
        {
            SDL_FreeSurface(sBoard); 
            	cout << "2.1" << endl;
            //tmp = SDL_LoadBMP("gfx/BackBoard.bmp"); Doesnøt exist anymore!
		    sBoard = SDL_DisplayFormat(backBoard);
		    cout << "2.2" << endl;
		    //SDL_FreeSurface(tmp);
        }
        
        //Instead of creating new object new game is called, to prevent memory leaks
        void NewGame(int tx, int ty)
        {
           nrFellDown = 0;
		   nrPushedPixel = 0;
		   nrStops = 0;
		   topx = tx;
           topy = ty;
           cursorx = 2;
           cursory = 3;
           stop = 0;
           pixels = 0;
           score = 0;
           bGameOver = false;
		   bDraw = false;
           timetrial = false;
           stageClear = false;
		   linesCleared = 0;
		   hasWonTheGame = false;
		   vsMode = false;
		   puzzleMode = false;
           combo=0;
           chain=0;
           AI_Enabled = false;
           baseSpeed= 0.5;
           speed = baseSpeed;
		   speedLevel = 1;
           gameStartedAt = SDL_GetTicks()+3000;
           pushedPixelAt = gameStartedAt;
		   nextGarbageNumber = 10;
           for(int i=0;i<7;i++)
           for(int j=0;j<30;j++)
           {
              board[i][j] = -1;
           }
           for(int i=0;i<NUMBEROFCHAINS;i++)
           {
                chainUsed[i]=false;
                chainSize[i] = 0;
            }
           showGame = true;
        }	//NewGame

		//Starts a new stage game, takes level as input!
		void NewStageGame(int level, int tx, int ty)
		{
			if(level > -1)
			{
			NewGame(tx,ty);
			stageClear = true;
			Level = level;
			stageClearLimit = 30+(Level%6)*10;
			baseSpeed = 0.5/((double)(Level*0.5)+1.0);
			speed = baseSpeed;
			}
		}
		
		void NewPuzzleGame(int level, int tx, int ty)
        {
            if(level>-1)
            {
                NewGame(tx,ty);
                puzzleMode = true;
                Level = level;
                MovesLeft = nrOfMovesAllowed[Level];
                for(int i=0;i<6;i++)
                for(int j=0;j<12;j++)
                {
                    board[i][j+1] = puzzleLevels[Level][i][j];
                }
                baseSpeed = 100000;
                speed = 100000;
                
                //Now push the blines up
                for(int i=19;i>0;i--)
                for(int j=0;j<6;j++)
                {
                    board[j][i] = board[j][i-1];
                }
                for(int j=0;j<6;j++)
                {
                    board[j][0] = rand() % 6;
                    if(j > 0)
                    {
                        if(board[j][0] == board[j-1][0])
                            board[j][0] = rand() % 6;
                    }
                    if(board[j][0] == board[j][1])
                        board[j][0] = 6;
                    if(board[j][0] == board[j][1])
                    board[j][0] = 6;

                }
            }
        }

		//Starts new Vs Game (two Player)
		void NewVsGame(int tx, int ty,BlockGame *target)
		{
			NewGame(tx,ty);
			vsMode = true;
			garbageTarget = target;
		}
		
		//Starts new Vs Game (two Player)
		void NewVsGame(int tx, int ty,BlockGame *target,bool AI)
		{
			NewGame(tx,ty);
			vsMode = true;
			AI_Enabled = AI;
			garbageTarget = target;
		}
        
		//Go in Demonstration mode, no movement
        void Demonstration(bool toggle)
        {
            speed=0;
            baseSpeed = 0;
        }    
        
		//Prints "winner" and ends game
		void setPlayerWon()
		{
			bGameOver = true;
			hasWonTheGame = true;
			showGame = false;
			if(SoundEnabled)Mix_PlayChannel(1,applause,0);
		}

		//Prints "draw" and ends the game
		void setDraw()
		{
			bGameOver = true;
			hasWonTheGame = false;
			bDraw = true;
			showGame = false;
			Mix_HaltChannel(1);
		}

		//Test if LineNr is an empty line, returns false otherwise.
		bool LineEmpty(int lineNr)
		{
			bool empty = true;
			for(int i = 0; i <7; i++)
				if(board[i][lineNr] != -1)
					empty = false;
			return empty;
		}

        //Test if the entire board is empty (used for Puzzles)
        bool BoardEmpty()
        {
            bool empty = true;
            for(int i=0;i<6;i++)
            for(int j=1;j<13;j++)
                if(board[i][j] != -1)
                    empty = false;
            return empty;
        }

        

        //decreases hang for all hanging blocks and wait for waiting blocks
        void ReduceStuff()
        {
            unsigned int howMuchHang = (SDL_GetTicks() - FRAMELENGTH*hangTicks)/FRAMELENGTH;
            if (howMuchHang>0)
            {
                for(int i=0; i<7; i++)
                for(int j=0; j<30; j++)
                {
                    if((board[i][j]/BLOCKHANG)%10==1)
                    {
                        unsigned int hangNumber = (board[i][j]/10)%100;
                        if(hangNumber<=howMuchHang)
                        {
                            board[i][j]-=BLOCKHANG;
                            board[i][j]-=hangNumber*10;
                        }
                        else
                        {
                            board[i][j]-=10*howMuchHang;
                        }
                    }
                    if((board[i][j]/BLOCKWAIT)%10==1)
                    {
                        unsigned int hangNumber = (board[i][j]/10)%100;
                        if(hangNumber<=howMuchHang)
                        {
                            //The blocks must be cleared
                            board[i][j]-=hangNumber*10;
                        }
                        else
                        {
                            board[i][j]-=10*howMuchHang;
                        }
                    }
                }
            }
            hangTicks+=howMuchHang;
        }

		//Creates garbage using a given wide and height
		bool CreateGarbage(int wide, int height)
		{
			if(wide>6) wide = 6;
			if(height>12) height = 12;
			int startPosition = 12;
			while((!(LineEmpty(startPosition))) || (startPosition == 29))
				startPosition++;
			if(startPosition == 29) return false; //failed to place blocks
			if(29-startPosition<height) return false;	//not enough space
			int start, end;
			if(bGarbageFallLeft)
			{start=0; end=start+wide;}
			else
			{start=6-wide; end = 6;}
			for(int i = startPosition; i <startPosition+height; i++)
				for(int j = start; j < end; j++)
				{
					board[j][i] = 1000000+nextGarbageNumber;
				}
			nextGarbageNumber++;
			if(nextGarbageNumber>999999) nextGarbageNumber = 10;
			bGarbageFallLeft = !(bGarbageFallLeft);
			return true;
		}

		//Clears garbage, must take one the lower left corner!
		int GarbageClearer(int x,int y, int number, bool aLineToClear,int chain)
		{
			if((board[x][y])%1000000 != number) return -1;
			if(aLineToClear)
            {
                board[x][y] = rand() % 6;
                board[x][y] += 10*HANGTIME+BLOCKHANG+CHAINPLACE*chain;
            }
			garbageToBeCleared[x][y] = false;
			GarbageClearer(x+1,y,number,aLineToClear,chain);
			GarbageClearer(x,y+1,number,false,chain);
			return 1;
		}

		//Marks garbage that must be cleared
		int GarbageMarker(int x, int y)
		{
			if((x>6)||(x<0)||(y<0)||(y>29)) return -1;
			if(((board[x][y])/1000000 == 1)&&(garbageToBeCleared[x][y] == false))
			{
				garbageToBeCleared[x][y] = true;
				//Float fill
				GarbageMarker(x-1,y);
				GarbageMarker(x+1,y);
				GarbageMarker(x,y-1);
				GarbageMarker(x,y+1);
			}
			return 1;
		}

        //Clear Blocks if 3 or more is alligned (naive implemented)
        void ClearBlocks()
        {
            
           bool toBeCleared[7][30]; //true if blok must be removed
		   
           int previus=-1; //the last block checked
           int combo=0;
           for(int i=0;i<30;i++)
           for(int j=0;j<7;j++)
		   {
				toBeCleared[j][i] = false;
				garbageToBeCleared[j][i] = false;
		   }
            for(int i=0;i<7;i++)
            {
                bool faaling = false;
                for(int j=0;j<30;j++)
                {
                    if((faaling)&&(board[i][j]>-1)&&(board[i][j]%10000000<7))
                    {
                        board[i][j]+=BLOCKFALL;
                    }
                    if((!faaling)&&((board[i][j]/BLOCKFALL)%10==1))
                        board[i][j]-=BLOCKFALL;
                    if(!((board[i][j]>-1)&&(board[i][j]%10000000<7)))
                        faaling=true;
                    if(((board[i][j]/1000000)%10==1)||((board[i][j]/BLOCKHANG)%10==1)||((board[i][j]/BLOCKWAIT)%10==1))
                        faaling = false;
                }
            }
            

           for(int j=0;j<7;j++)
           {
                previus = -1;
                combo=0;

                for(int i=1;i<30;i++)
                {
                    if((board[j][i]>-1)&&(board[j][i]%10000000<7))
                    {
                        if (board[j][i]%10000000 == previus)
                        {
                            combo++;
                        }
                        else
                        {
                            if(combo>2)
                                for(int k = i-combo; k<i;k++)
                                {
                                    toBeCleared[j][k] = true;
                                }
                            combo=1;
                            previus = board[j][i]%10000000;
                        }
                    } //if board
                    else
                    {
                        if(combo>2)
                            for(int k = i-combo; k<i;k++)
                            {
                                toBeCleared[j][k] = true;
                            }
                        combo = 0;
                        previus = -1;
                    }
           
                } //for i
            } //for j
            
                   
           combo = 0;
           chain = 0;
           for(int i=0; i<6;i++)
           for(int j=0; j<30;j++)
           {
                //Clears blocks marked for clearing
                Sint32 temp=board[i][j];
                if(1==((temp/BLOCKWAIT)%10))
                if(((temp/10)%100)==0)
                {
                    if(chainSize[chain]<chainSize[board[i][j]/10000000])
                        chain = board[i][j]/10000000;
                    
                    theBallManeger.addBall(topx+40+i*50,topy+600-j*50,true,board[i][j]%10);
                    theBallManeger.addBall(topx+i*50,topy+600-j*50,false,board[i][j]%10);
                    theExplosionManeger.addExplosion(topx-10+i*50,topy+570-j*50);
                    board[i][j]=-2;
                }
            }
            for(int i=0; i<7;i++)
           {
                bool setChain=false;
                for(int j=0; j<30;j++)
                {
                    if(board[i][j]==-1)
                        setChain=false;
                    if(board[i][j]==-2)
                    {
                        board[i][j]=-1;
                        setChain=true;
                        if(SoundEnabled)Mix_PlayChannel(0,boing,0);
                    }
                    if(board[i][j]!=-1)
                    if((setChain)&&((board[i][j]/GARBAGE)%10!=1))
                    {
                        board[i][j]=((board[i][j]%CHAINPLACE)+CHAINPLACE*chain);
                        //somethingsGottaFall = true;
                    }
                    
                }
            } 
            combo=0;
           int startvalue;
           if(pixels == 0)
               startvalue=1;
           else
               startvalue=0;
           for(int i=startvalue;i<30;i++)
           {
                previus=-1;
                combo=0;
                for(int j=0;j<7;j++)
                {
                    if(((board[j][i]>-1)&&(board[j][i]%10000000<7)))
                    {
                        if (board[j][i]%10000000 == previus)
                        {
                            combo++;
                        }
                        else
                        {
                            if(combo>2)
                                for(int k = j-combo; k<j;k++)
                                {
                                    toBeCleared[k][i] = true;
                                }
                            combo=1;
                            previus = board[j][i]%10000000;
                        }
                    } //if board
                    else
                    {
                        if(combo>2)
                            for(int k = j-combo; k<j;k++)
                            {
                                toBeCleared[k][i] = true;
                            }
                        combo = 0;
                        previus = -1;
                    }
           
                } //for j
            } //for i
           bool blockIsFalling[6][30]; //See that is falling
           for(int i=0;i<30;i++)
           for(int j=0;j<6;j++)
                blockIsFalling[j][i] = false; 
            
                 
           combo = 0;
           chain = 0;
           for(int i=0;i<30;i++)
           for(int j=0;j<6;j++)
           if (toBeCleared[j][i])
           {
			   //see if any garbage is around:
				GarbageMarker(j-1,i);
				GarbageMarker(j+1,i);
				GarbageMarker(j,i-1);
				GarbageMarker(j,i+1);
			   //that is checked now :-)
              if((board[j][i]>-1)&&(board[j][i]%10000000<7))
                board[j][i]+=BLOCKWAIT+10*FALLTIME;
                if(chainSize[board[j][i]/10000000]>chainSize[chain])
                    chain=board[j][i]/10000000;
                combo++;
                stop+=60*combo;
                score +=10;
		          if(combo>3)
			     score+=2*combo; //More points if more cleared simontanously
           }
           score+=chainSize[chain]*100;
           /*chain++;
           if(chain>99)
                chain=99;
            if(chain!=0)*/
            if(chain==0)
            {
                chain=firstUnusedChain();
                chainSize[chain]=0;
                chainUsed[chain]=true;
            }
            chainSize[chain]++;
           for(int i=0;i<30;i++)
           for(int j=0;j<6;j++)
           {
                //if(board[j][i]/10==(BLOCKWAIT+10*FALLTIME)/10)
                if(toBeCleared[j][i])
                {
                    board[j][i]=(board[j][i]%10000000)+chain*10000000;
                }
            }           
           
		   if(vsMode)
		   switch(combo)
		   {
		      case 0: case 1: case 2: case 3: break;
		      case 4: garbageTarget->CreateGarbage(3,1); break;
		      case 5: garbageTarget->CreateGarbage(4,1); break;
		      case 6: garbageTarget->CreateGarbage(5,1); break;
		      case 7: garbageTarget->CreateGarbage(6,1); break;
		      case 8: garbageTarget->CreateGarbage(4,1); garbageTarget->CreateGarbage(4,1); break;
		      case 9: garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(4,1); break;
		      case 10: garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(5,1); break;
		      case 11: garbageTarget->CreateGarbage(6,1); garbageTarget->CreateGarbage(5,1); break;
		      case 12: garbageTarget->CreateGarbage(6,1); garbageTarget->CreateGarbage(6,1); break;
		      case 13: garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(4,1); break;
		      default: garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(5,1); garbageTarget->CreateGarbage(4,1); break;
		   }
		   for(int i=0;i<30;i++)
           for(int j=0;j<6;j++)
                if (garbageToBeCleared[j][i])
		          {
			         GarbageClearer(j,i,board[j][i]%1000000,true,chain); //Clears the blocks and all blocks connected to it.
		          }


            chain=0;

            //Break chains (if a block is stable it is resetted to (chain == 0)):
            for(int i=0;i<7;i++)
            {
                bool faaling = false;  //In the beginning we are NOT falling
                for(int j=0;j<30;j++)
                {
                    if((faaling)&&(board[i][j]>-1)&&(board[i][j]<7))
                    {
                        board[i][j]+=BLOCKFALL; 
                    }
                    if((!faaling)&&((board[i][j]/BLOCKFALL)%10==1))
                        board[i][j]-=BLOCKFALL;
                    if((!faaling)&&(board[i][j]>0)&&(board[i][j]/10000000!=0)&&((board[i][j]/BLOCKWAIT)%10!=1)&&((board[i][j]/BLOCKHANG)%10!=1))
                    {
                        if(chainSize[board[i][j]/10000000]>chainSize[chain])
                            chain=board[i][j]/10000000;
                        board[i][j]=board[i][j]%10000000;
                    }
                    if(!((board[i][j]>-1)&&(board[i][j]<7)))
                        faaling=true;
                    if(((board[i][j]/1000000)%10==1)||((board[i][j]/BLOCKHANG)%10==1)||((board[i][j]/BLOCKWAIT)%10==1))
                        faaling = false;
                }
            }
           
	    //Create garbage as a result
	    //if((vsMode)&&(chainSize[chain]>1)) garbageTarget->CreateGarbage(6,chainSize[chain]-1);
	    
	       //Caklculate chain
            chain=0;
            for(int i=0; i<6;i++)
            for(int j=0; j<30;j++)
            {
                if(chainSize[board[i][j]/10000000]>chain)
                    chain=chainSize[board[i][j]/10000000];
            }
            
            //Make space in table for more things
            if(chain==0)
                for(int i=0;i<NUMBEROFCHAINS;i++)
                    if(chainUsed[i]==true)
                    {
                        if((vsMode)&&(chainSize[i]>1)) garbageTarget->CreateGarbage(6,chainSize[i]-1);
                        if((SoundEnabled)&&(chainSize[i]>4))Mix_PlayChannel(1,applause,0);
                        chainUsed[i]=false;
                    }
            
        } //ClearBlocks
   

		//prints "Game Over" and ends game
        void SetGameOver()
        {
          bGameOver = true;
          showGame = false;
        }    
   
		//Moves all peaces a spot down if possible
		int FallBlock(int x, int y, int number)
		{
			if(y == 0) return -1;
			if(x>0)
				if(board[x-1][y] == number)
					return -1;
			int i=x;
			bool canFall = true;
			//checks a line of a garbage block and see if something is under it
			while((board[i][y] == number)&&(canFall)&&(i<6))
			{
				if(board[i][y-1] != -1) canFall = false;
				i++;
			}
			if(canFall)
			{
				//cout << "Now falling" << endl;
				for(int j = x;j<i;j++)
				{
					board[j][y-1] = board[j][y];
					board[j][y] = -1;
				}
			}
			return 0;
		}	//FallBlock


		//Makes all Garbage fall one spot
		void GarbageFall()
		{
			for(int i=0;i<30;i++)
			for(int j=0;j<7; j++)
			   {
				  if(((board[j][i]/1000000)%10) == 1)
					  FallBlock(j,i,board[j][i]);
			   }
		}

        //Makes the blocks fall (it doesn't test time, this must be done before hand)
        void FallDown()
        {
           bool falling =false;        //nothing is moving unless proven otherwise
           for(int i=0;i<29;i++)
           for(int j=0;j<6;j++)
           {
                if((board[j][i]==-1) && (board[j][i+1]!=-1) && (board[j][i+1]%BLOCKFALL<7))
                {
                    board[j][i] = board[j][i+1];
                    board[j][i+1] = -1;
                    falling = true;              //something is moving!
                }
                if((board[j][i]/BLOCKWAIT)%10==1)
                    falling=true;
            }
           if(!falling) //If nothing is falling
           {
               if((puzzleMode)&&(!bGameOver)&&(MovesLeft==0)&&(!(BoardEmpty())))
               {
                //Puzzle not won
                bGameOver = true;
                SetGameOver();
                }
           }     
		   GarbageFall();		//Makes the garbage fall
           nrFellDown++;      //Sets number of this fall, so we know then the next will occur
        }
   
           //Moves the cursor, receaves N,S,E or W as a char an moves as desired 
        void MoveCursor(char way)
        {
           if(!bGameOver)        //If game over nothing happends
           {
			if((way == 'N') && ((cursory<10)||(TowerHeight>12) ||(((pixels==50)||(pixels==0)) && (cursory<11))))
              cursory++;
           if((way == 'S') && (cursory>0))
              cursory--;
           if((way == 'W') && (cursorx>0))
              cursorx--;
           if((way == 'E') && (cursorx<4))
              cursorx++;
           }
        }
        
        //switches the two blocks at the cursor position, unless game over
        void SwitchAtCursor()
        {
           if((board[cursorx][cursory+1]<7) && (board[cursorx+1][cursory+1]<7) && (!bGameOver) && (gameStartedAt-(int)SDL_GetTicks()<=0))
           {
              int temp = board[cursorx][cursory+1];
              board[cursorx][cursory+1] = board[cursorx+1][cursory+1];
              board[cursorx+1][cursory+1] = temp;
           }
           if((puzzleMode)&&(gameStartedAt-(int)SDL_GetTicks()<=0)) MovesLeft--;
        }
        
        //Generates a new line and moves the field one block up (restart puzzle mode)
        void PushLine()
        {
        //If not game over, not high tower and not puzzle mode
        if((!bGameOver) && TowerHeight<13 && (!puzzleMode) && (gameStartedAt-(int)SDL_GetTicks()<=0)&&(chain==0))
        {
           for(int i=19;i>0;i--)
           for(int j=0;j<6;j++)
           {
              board[j][i] = board[j][i-1];
           }
           for(int j=0;j<6;j++)
           {
              board[j][0] = rand() % 6;
              if(j > 0)
              {
                   if(board[j][0] == board[j-1][0])
                        board[j][0] = rand() % 6;
               }
              if(board[j][0] == board[j][1])
                 board[j][0] = rand() % 6;
              if(board[j][0] == board[j][1])
                 board[j][0] = rand() % 6;
              while((j>0)&&(board[j][0]==board[j-1][0]))
                board[j][0] = rand() % 6;
           }
           score+=1;
           MoveCursor('N');
           pixels = 0;
		   stop=0;
           pushedPixelAt = SDL_GetTicks();
           linesCleared++;
           AI_LineOffset++;
		   nrPushedPixel=(int)((double)(pushedPixelAt-gameStartedAt)/(1000.0*speed));
        } //if !bGameOver
        
        //Restart Puzzle mode
        if((!bGameOver) && (puzzleMode))
        {
            //Reloads level
            MovesLeft = nrOfMovesAllowed[Level];
                for(int i=0;i<6;i++)
                for(int j=0;j<12;j++)
                {
                    board[i][j+1] = puzzleLevels[Level][i][j];
                }
        }
        
        if((TowerHeight>12) && (!bGameOver))
        {
           bGameOver = true;
           if(theTopScoresEndless.isHighScore(score))
           {
               if(SoundEnabled)Mix_PlayChannel(1,applause,0);
               theTopScoresEndless.addScore(name,score);
               cout << "New high score!" << endl;
           }    
           SetGameOver();
        }
        }//PushLine
        
        //Pushes a single pixel, so it appears to scrool
        void PushPixels()
        {
           nrPushedPixel++;
           if ((pixels < 50) && TowerHeight<13)
           {
              pixels++;
           }
           else
           PushLine();
           if (pixels>50)
              pixels=0;
        }
        
        //See how high the tower is, saved in integer TowerHeight
        /*void FindTowerHeight()
        {
			/
			This function needs to be corrected, if an empty line appears towerheight become to low!
			/
           bool found = false;
		   bool notNew = false;
           TowerHeight = 0;
           for(int i=0; i<19;i++)
           //while(!found)
		   {
              found = true;
              for(int j=0;j<6;j++)
              if(board[j][i] != -1)
				found = false;
			  if((!found) && (notNew))
				  notNew =false;
			  if((found)&&(!notNew))
			  {
              TowerHeight=i;
			  notNew = true;
			  }
           }
           TowerHeight--;
        }*/

        //See how high the tower is, saved in integer TowerHeight
        void FindTowerHeight()
        {
			/*
			Old implementation, used until I find the bug in the other.
			This function has a bug in stage clear! if an empty line appears.
			*/
		   prevTowerHeight = TowerHeight;
           bool found = false;
           TowerHeight = 0;
           while(!found)
           {
              found = true;
              for(int j=0;j<6;j++)
              if(board[j][TowerHeight] != -1)
                 found = false;
              TowerHeight++;
           }
           TowerHeight--;
        }
        
///////////////////////////////////////////////////////////////////////////
/////////////////////////// AI starts here! ///////////////////////////////
///////////////////////////////////////////////////////////////////////////
        //First the helpet functions:
        inline int nrOfType(int line, int type)
        {
            int counter = 0;
            for(int i=0; i<6; i++)
            if(board[i][line]==type)counter++;
            return counter;
        }
        
        int AIcolorToClear;
        int AIlineToClear;
        
        //See if a combo can be made in this line
        int horiInLine(int line)
        {
            int nrOfType[7] = {0,0,0,0,0,0,0};
            int iTemp;
            int max = 0;
            for(int i=0; i<6; i++)
            {
                iTemp = board[i][line];
                if((iTemp>-1)&&(iTemp<7))
                    nrOfType[iTemp]++;
            }
            for(int j=0; j<7; j++)
            {
                if(nrOfType[j]>max)
                {
                    max = nrOfType[j];
                    AIcolorToClear = j;
                }
            }            
            return max;
        }
        
        bool horiClearPossible()
        {
            int i=13;
            bool solutionFound = false;
            do{
                if(horiInLine(i)>2)
                {
                    AI_LineOffset = 0;
                    AIlineToClear = i;
                    solutionFound = true;
                }
            }while((!solutionFound)&&(i>0));
            return solutionFound;
        }
        
        //Types 0..6 in line
        inline int nrOfRealTypes(int line)
        {
            int counter = 0;
            for(int i=0; i<6; i++)
            if((board[i][line]>-1)&&(board[i][line]<7))counter++;
            return counter;
        }
        
        //See if there is a tower
        bool ThereIsATower()
        {
            bool bThereIsATower = false; //Unless proven otherwise!
            bool topReached = false; //If we have reached the top
            int lineNumber = 0;
            bool emptySpacesFound = false;
            do
            {
                if((emptySpacesFound) && (nrOfRealTypes(lineNumber)>0))
                    bThereIsATower = true;
                else
                    emptySpacesFound=false;
                if((!emptySpacesFound)&&(nrOfType(-1,lineNumber)>0))
                    emptySpacesFound = true;
                if(lineNumber<12)
                    lineNumber++;
                else
                    topReached = true;                
            }while((!bThereIsATower)||(!topReached));
            return bThereIsATower;
        }
        
        //The AI will remove tower
        inline void AI_ClearTower()
        {
            AIstatus = 0;
        }
        
        //The AI will try to clear block horisontally
        inline void AI_ClearHori()
        {
            AIstatus = 0;
        }
        
        //The AI will try to clear blocks vertically
        inline void AI_ClearVertical()
        {
            AIstatus = 0;
        }
        
        
        
        short AIstatus;   //Status flags:
            //0: nothing, 2: clear tower, 3: clear horisontal, 4: clear vertical
            //1: make more lines, 5: make 2 lines, 6: make 1 line
        bool firstLineCreated;
        
        void AI_Move()
        {
            switch(AIstatus)
            {
                case 1: if(TowerHeight<8)PushLine(); else AIstatus = 0;
                break;
                case 2: AI_ClearTower();
                break;
                case 3: AI_ClearHori();
                break;
                case 4: AI_ClearVertical();
                break;
                case 5: if(!firstLineCreated){PushLine(); firstLineCreated = true;} 
                    else {PushLine(); AIstatus = 0;}
                break;
                case 6: PushLine(); AIstatus = 0;
                break;
                default:
                    if(TowerHeight<6) AIstatus = 1;
                    else
                    if(ThereIsATower()) AIstatus = 2;
                    else
                    if(horiClearPossible()) AIstatus = 3;
                break;
            }
        }
        
//////////////////////////////////////////////////////////////////////////
///////////////////////////// AI ends here! //////////////////////////////
//////////////////////////////////////////////////////////////////////////
        
        //Draws all the bricks to the board (including garbage)
        inline void PaintBricks()
        {
           for(int i=0;((i<13)&&(i<30));i++)
           for(int j=0;j<6;j++)
		   {
		   if((board[j][i]%10 != -1) && (board[j][i]%10 < 7) && ((board[j][i]/1000000)%10==0))
           {
              DrawIMG(bricks[board[j][i]%10],sBoard,j*50,600-i*50-pixels);      
              if((board[j][i]/BLOCKWAIT)%10==1)
                DrawIMG(bomb[(SDL_GetTicks()/BOMBTIME)%2],sBoard,j*50,600-i*50-pixels);
              if((board[j][i]/BLOCKHANG)%10==1)
                DrawIMG(ready[(SDL_GetTicks()/READYTIME)%2],sBoard,j*50,600-i*50-pixels);
                      
           }
		   if((board[j][i]/1000000)%10)
		   {
			   int left, right, over, under;
			   int number = board[j][i];
			   if(j<1) left = -1; else left = board[j-1][i];
			   if(j>5) right = -1; else right = board[j+1][i];
			   if(i>28) over = -1; else over = board[j][i+1];
			   if(i<1) under = -1; else under = board[j][i-1];
			   if((left == number)&&(right == number)&&(over == number)&&(under == number))
				   DrawIMG(garbageFill,sBoard,j*50,600-i*50-pixels); 
				if((left != number)&&(right == number)&&(over == number)&&(under == number))
				   DrawIMG(garbageL,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right != number)&&(over == number)&&(under == number))
				   DrawIMG(garbageR,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right == number)&&(over != number)&&(under == number))
				   DrawIMG(garbageT,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right == number)&&(over == number)&&(under != number))
				   DrawIMG(garbageB,sBoard,j*50,600-i*50-pixels);
				if((left != number)&&(right == number)&&(over != number)&&(under == number))
				   DrawIMG(garbageTL,sBoard,j*50,600-i*50-pixels);
				if((left != number)&&(right == number)&&(over == number)&&(under != number))
				   DrawIMG(garbageBL,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right != number)&&(over != number)&&(under == number))
				   DrawIMG(garbageTR,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right != number)&&(over == number)&&(under != number))
				   DrawIMG(garbageBR,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right != number)&&(over != number)&&(under != number))
				   DrawIMG(garbageMR,sBoard,j*50,600-i*50-pixels);
				if((left == number)&&(right == number)&&(over != number)&&(under != number))
				   DrawIMG(garbageM,sBoard,j*50,600-i*50-pixels);
				if((left != number)&&(right == number)&&(over != number)&&(under != number))
				   DrawIMG(garbageML,sBoard,j*50,600-i*50-pixels);
		   }
		   }
        }
        
        //Draws everything
        void DoPaintJob()
        {
           DrawIMG(backBoard,sBoard,0,0);
           PaintBricks();
		   if(stageClear) DrawIMG(blackLine,sBoard,0,700+50*(stageClearLimit-linesCleared)-pixels-1);
		   if(puzzleMode&&(!bGameOver))
		   {
                //We need to write nr. of moves left!
                strHolder = "Moves left: " + itoa(MovesLeft);
                    SFont_Write(sBoard,fBlueFont,5,5,strHolder.c_str());
            }
           if(!bGameOver)DrawIMG(cursor[(SDL_GetTicks()/600)%2],sBoard,cursorx*50-4,550-cursory*50-pixels-4);
           if((int)SDL_GetTicks()<gameStartedAt)
                switch(abs((int)SDL_GetTicks()-gameStartedAt)/1000)
                {
                case 2:
                    DrawIMG(counter[2],sBoard,100,250);
                break;
                case 1:
                    DrawIMG(counter[1],sBoard,100,250);
                break;
                case 0:
                    DrawIMG(counter[0],sBoard,100,250);
                break;
                default:
                break;
                }    
           if(bGameOver)
           if(hasWonTheGame)DrawIMG(iWinner,sBoard,0,250);
		   else if(bDraw) DrawIMG(iDraw,sBoard,0,250);
			   else
			   DrawIMG(iGameOver,sBoard,0,250);
        }

        //Updates evrything, if not called nothing happends
        void Update()
        {
          FindTowerHeight();
		  if((linesCleared-TowerHeight>stageClearLimit) && (stageClear) && (!bGameOver))
		  {
			  stageCleared[Level] = true;

			  ofstream outfile;
				outfile.open(stageClearSavePath.c_str(), ios::binary |ios::trunc);
			  if(!outfile)
				{
					cout << "Error writing to file: stageClear.save" << endl;
				}
			  else
			  {
				for(int i=0;i<nrOfStageLevels;i++)
				{
					bool tempBool = stageCleared[i];
					outfile.write(reinterpret_cast<char*>(&tempBool),sizeof(bool));
				}
				outfile.close();
			  }
			  setPlayerWon();
		  }
		  if((TowerHeight>12)&&(prevTowerHeight<13)&&(!puzzleMode))
		  {
			  if(SoundEnabled) Mix_PlayChannel(1,heartBeat,0);
			  stop+=1000;
		  }
          int nowTime = SDL_GetTicks(); //We remember the time, so it don't change during this call
		  while(nowTime-gameStartedAt>nrStops*40) //Increase stops, till we reach nowTime
		  {
			if (stop>0)
			{
			  stop = stop-20;
			  if(stop<=0) nrPushedPixel=(int)((nowTime-gameStartedAt)/(1000.0*speed));
			}
			if (stop<0)
				stop = 0;
			nrStops++;
		  }
		  if((puzzleMode)&&(!bGameOver)&&BoardEmpty())
		  {
              puzzleCleared[Level] = true;

			  ofstream outfile;
				outfile.open(puzzleSavePath.c_str(), ios::binary |ios::trunc);
			  if(!outfile)
				{
					cout << "Error writing to file: puzzleClear.save" << endl;
				}
			  else
			  {
				for(int i=0;i<nrOfPuzzles;i++)
				{
					bool tempBool = puzzleCleared[i];
					outfile.write(reinterpret_cast<char*>(&tempBool),sizeof(bool));
				}
				outfile.close();
			  }
			  setPlayerWon();  
            }
		  //increse speed:
          if ((nowTime-gameStartedAt>20000*speedLevel)&&(speedLevel <99)&&(!bGameOver))
				{ speed = (baseSpeed*0.9)/((double)speedLevel*0.5); speedLevel++; nrPushedPixel=(int)((double)(nowTime-gameStartedAt)/(1000.0*speed));}
		  //To prevent the stack from raising a lot then we stop a chain
          if(chain>0)
			 stop+=1;
		  //Raises the stack
          if ((nowTime-gameStartedAt>nrPushedPixel*1000*speed) && (!bGameOver)&&(!stop))
			  while((nowTime-gameStartedAt>nrPushedPixel*1000*speed)&&(!(puzzleMode)))
                    PushPixels();
          if(!bGameOver)ClearBlocks();
          if(bGameOver) {
                AIstatus = 0;       //Enusres that AI is resetted
            }
          if ((nowTime>gameStartedAt+nrFellDown*140) && (!bGameOver)) FallDown();
          if((nowTime<gameStartedAt)&&(puzzleMode)) {FallDown(); nrFellDown--;}
          ReduceStuff();
          if ((timetrial) && (!bGameOver) && (nowTime-gameStartedAt>2*60*1000))
          {
                    bGameOver = true;
                    if(SoundEnabled) Mix_PlayChannel(1,timesUp,0);
                    if(theTopScoresTimeTrial.isHighScore(score))
                    {
                                   theTopScoresTimeTrial.addScore(name,score);
                                   //new highscore
                    }    
                    SetGameOver();                   
          }
          DoPaintJob();
        }
        
}; //class BlockGame
////////////////////////////////////////////////////////////////////////////////
///////////////////////// BlockAttack class end ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//writeScreenShot saves the screen as a bmp file, it uses the time to get a unique filename
void writeScreenShot()
{
    int rightNow = (int)time(NULL);
	char buf[32];
	sprintf( buf, "screenshot%i.bmp", rightNow );
	SDL_SaveBMP( screen, buf );
	if(SoundEnabled)Mix_PlayChannel(1,photoClick,0);
}    

//Draws the highscores
inline void DrawHighscores(int x, int y)
{
    DrawIMG(topscoresBack,screen,x,y);
    if(showEndless) SFont_Write(screen,fBlueFont,x+100,y+100,"Endless:");
    else SFont_Write(screen,fBlueFont,x+100,y+100,"Time Trial:");
    for(int i =0;i<10;i++)
    {
        char playerScore[32];
		char playerName[32];
        if(showEndless) sprintf(playerScore, "%i", theTopScoresEndless.getScoreNumber(i));
        else sprintf(playerScore, "%i", theTopScoresTimeTrial.getScoreNumber(i));
		if(showEndless) strcpy(playerName,theTopScoresEndless.getScoreName(i));
        else strcpy(playerName,theTopScoresTimeTrial.getScoreName(i));
        SFont_Write(screen,fBlueFont,x+420,y+150+i*35,playerScore);
		SFont_Write(screen,fBlueFont,x+60,y+150+i*35,playerName);
    }    
}   

char keyname[11];

//Function to return the name of a key, to be displayed...
char* getKeyName(SDLKey key)
{
	
	char charToPut = '\0';
	switch(key)
	{
	case SDLK_a:	charToPut = 'A'; break;
	case SDLK_b:	charToPut = 'B'; break;
	case SDLK_c:	charToPut = 'C'; break;
	case SDLK_d:	charToPut = 'D'; break;
	case SDLK_e:	charToPut = 'E'; break;
	case SDLK_f:	charToPut = 'F'; break;
	case SDLK_g:	charToPut = 'G'; break;
	case SDLK_h:	charToPut = 'H'; break;
	case SDLK_i:	charToPut = 'I'; break;
	case SDLK_j:	charToPut = 'J'; break;
	case SDLK_k:	charToPut = 'K'; break;
	case SDLK_l:	charToPut = 'L'; break;
	case SDLK_m:	charToPut = 'M'; break;
	case SDLK_n:	charToPut = 'N'; break;
	case SDLK_o:	charToPut = 'O'; break;
	case SDLK_p:	charToPut = 'P'; break;
	case SDLK_q:	charToPut = 'Q'; break;
	case SDLK_r:	charToPut = 'R'; break;
	case SDLK_s:	charToPut = 'S'; break;
	case SDLK_t:	charToPut = 'T'; break;
	case SDLK_u:	charToPut = 'U'; break;
	case SDLK_v:	charToPut = 'V'; break;
	case SDLK_w:	charToPut = 'W'; break;
	case SDLK_x:	charToPut = 'X'; break;
	case SDLK_y:	charToPut = 'Y'; break;
	case SDLK_z:	charToPut = 'Z'; break;
	case SDLK_0:	charToPut = '0'; break;
	case SDLK_1:	charToPut = '1'; break;
	case SDLK_2:	charToPut = '2'; break;
	case SDLK_3:	charToPut = '3'; break;
	case SDLK_4:	charToPut = '4'; break;
	case SDLK_5:	charToPut = '5'; break;
	case SDLK_6:	charToPut = '6'; break;
	case SDLK_7:	charToPut = '7'; break;
	case SDLK_8:	charToPut = '8'; break;
	case SDLK_9:	charToPut = '9'; break;
	case SDLK_KP0:	sprintf(keyname,"NP_0"); break;
	case SDLK_KP1:	sprintf(keyname,"NP_1"); break;
	case SDLK_KP2:	sprintf(keyname,"NP_2"); break;
	case SDLK_KP3:	sprintf(keyname,"NP_3"); break;
	case SDLK_KP4:	sprintf(keyname,"NP_4"); break;
	case SDLK_KP5:	sprintf(keyname,"NP_5"); break;
	case SDLK_KP6:	sprintf(keyname,"NP_6"); break;
	case SDLK_KP7:	sprintf(keyname,"NP_7"); break;
	case SDLK_KP8:	sprintf(keyname,"NP_8"); break;
	case SDLK_KP9:	sprintf(keyname,"NP_9"); break;
	case SDLK_BACKSPACE:	sprintf(keyname,"Backspace"); break;
	case SDLK_TAB:			sprintf(keyname,"Tab"); break;
	case SDLK_CLEAR:	sprintf(keyname,"Clear"); break;
	case SDLK_RETURN:	sprintf(keyname,"Return"); break;
	case SDLK_PAUSE:	sprintf(keyname,"Pause"); break;
	case SDLK_SPACE:	sprintf(keyname,"Space"); break;
	case SDLK_EXCLAIM:	charToPut = '!'; break;
	case SDLK_QUOTEDBL:	sprintf(keyname,"QuoteDBL"); break;
	case SDLK_HASH:	charToPut = '#'; break;
	case SDLK_DOLLAR:	sprintf(keyname,"$"); break;
	case SDLK_ASTERISK:	sprintf(keyname,"Asterisk"); break;
	case SDLK_PLUS:	sprintf(keyname,"Plus"); break;
	case SDLK_COMMA:	sprintf(keyname,"Comma"); break;
	case SDLK_MINUS:	sprintf(keyname,"Minus"); break;
	case SDLK_PERIOD:	sprintf(keyname,"Period"); break;
	case SDLK_SLASH:	charToPut ='/'; break;
	case SDLK_COLON:	sprintf(keyname,"Colon"); break;
	case SDLK_SEMICOLON:	sprintf(keyname,"SemiColon"); break;
	case SDLK_LESS:	charToPut = '<'; break;
	case SDLK_EQUALS:	sprintf(keyname,"Equals"); break;
	case SDLK_DELETE:	sprintf(keyname,"Delete"); break;
	case SDLK_KP_PERIOD:	sprintf(keyname,"NPperiod"); break;
	case SDLK_KP_DIVIDE:	sprintf(keyname,"NPdivide"); break;
	case SDLK_KP_MULTIPLY:	sprintf(keyname,"NPmultiply"); break;
	case SDLK_KP_MINUS:	sprintf(keyname,"NPminus"); break;
	case SDLK_KP_PLUS:	sprintf(keyname,"NPplus"); break;
	case SDLK_KP_ENTER:	sprintf(keyname,"NP_Enter"); break;
	case SDLK_KP_EQUALS:	sprintf(keyname,"NP="); break;
	case SDLK_UP:	sprintf(keyname,"UP"); break;
	case SDLK_DOWN:	sprintf(keyname,"DOWN"); break;
	case SDLK_RIGHT:	sprintf(keyname,"RIGHT"); break;
	case SDLK_LEFT:	sprintf(keyname,"LEFT"); break;
	case SDLK_INSERT:	sprintf(keyname,"Insert"); break;
	case SDLK_HOME:	sprintf(keyname,"Home"); break;
	case SDLK_END:	sprintf(keyname,"End"); break;
	case SDLK_PAGEUP:	sprintf(keyname,"PageUp"); break;
	case SDLK_PAGEDOWN:	sprintf(keyname,"PageDown"); break;
	case SDLK_NUMLOCK:	sprintf(keyname,"NumLock"); break;
	case SDLK_CAPSLOCK:	sprintf(keyname,"CapsLock"); break;
	case SDLK_SCROLLOCK:	sprintf(keyname,"ScrolLock"); break;
	case SDLK_RSHIFT:	sprintf(keyname,"Rshift"); break;
	case SDLK_LSHIFT:	sprintf(keyname,"Lshift"); break;
	case SDLK_RCTRL:	sprintf(keyname,"Rctrl"); break;
	case SDLK_LCTRL:	sprintf(keyname,"Lctrl"); break;
	case SDLK_RALT:	sprintf(keyname,"Ralt"); break;
	case SDLK_LALT:	sprintf(keyname,"Lalt"); break;
	case SDLK_RMETA:	sprintf(keyname,"Rmeta"); break;
	case SDLK_LMETA:	sprintf(keyname,"Lmeta"); break;
	case SDLK_LSUPER:	sprintf(keyname,"Lwin"); break;
	case SDLK_RSUPER:	sprintf(keyname,"Rwin"); break;
	case SDLK_MODE:	sprintf(keyname,"Mode"); break;
	case SDLK_HELP:	sprintf(keyname,"Help"); break;
	default:
        sprintf(keyname,"Unknown"); break;
	}
	if(charToPut != '\0')
		sprintf(keyname,"%c",charToPut);
	return &keyname[0];
}

void MakeBackground(int xsize,int ysize,BlockGame &theGame, BlockGame &theGame2);

int OpenControlsBox(int x, int y, int player)
{
	int mousex, mousey;
	Uint8 *keys;
	bool done =false;
	char *keyname;
	MakeBackground(1024,768);
	while(!done)
	{
		SDL_Delay(10);
		DrawIMG(background, screen, 0, 0);
		DrawIMG(changeButtonsBack,screen,x,y);
		if(player == 0)
			SFont_Write(screen,fBlueFont,x+40,y+2,"Player 1 keys");
		else
			SFont_Write(screen,fBlueFont,x+40,y+2,"Player 2 keys");
		SFont_Write(screen,fBlueFont,x+6,y+50,"Up");
		keyname = getKeyName(keySettings[player].up);
		SFont_Write(screen,fBlueFont,x+200,y+50,keyname);
		SFont_Write(screen,fBlueFont,x+6,y+100,"Down");
		keyname = getKeyName(keySettings[player].down);
		SFont_Write(screen,fBlueFont,x+200,y+100,keyname);
		SFont_Write(screen,fBlueFont,x+6,y+150,"Left");
		keyname = getKeyName(keySettings[player].left);
		SFont_Write(screen,fBlueFont,x+200,y+150,keyname);
		SFont_Write(screen,fBlueFont,x+6,y+200,"Right");
		keyname = getKeyName(keySettings[player].right);
		SFont_Write(screen,fBlueFont,x+200,y+200,keyname);
		SFont_Write(screen,fBlueFont,x+6,y+250,"Push");
		keyname = getKeyName(keySettings[player].push);
		SFont_Write(screen,fBlueFont,x+200,y+250,keyname);
		SFont_Write(screen,fBlueFont,x+6,y+300,"Change");
		keyname = getKeyName(keySettings[player].change);
		SFont_Write(screen,fBlueFont,x+200,y+300,keyname);
		//Ask for mouse play
		SFont_Write(screen,fBlueFont,x+6,y+350,"Mouse play?");
		DrawIMG(iLevelCheckBox,screen,x+220,y+350);
		if(((player==0)&&(mouseplay1))||((player==2)&&(mouseplay2)))
		  DrawIMG(iLevelCheck,screen,x+220,y+350); //iLevelCheck witdh is 42
		//Ask for joypad play
		SFont_Write(screen,fBlueFont,x+300,y+350,"Joypad?");
		DrawIMG(iLevelCheckBox,screen,x+460,y+350);
		if(((player==0)&&(joyplay1))||((player==2)&&(joyplay2)))
		  DrawIMG(iLevelCheck,screen,x+460,y+350); //iLevelCheck witdh is 42
		for(int i=1; i<7; i++)
		DrawIMG(bChange,screen,x+420,y+50*i);
		SDL_Event event;

		while(SDL_PollEvent(&event))
		{
			if ( event.type == SDL_QUIT )  {done = true;}

			if(event.type == SDL_KEYDOWN)
			{
				if (event.key.keysym.sym == SDLK_ESCAPE) 
					done = true;
			}
		}	//PollEvent

		keys = SDL_GetKeyState(NULL);

		SDL_GetMouseState(&mousex,&mousey);    

		// If the mouse button is released, make bMouseUp equal true
		if(!SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(1))
		{
			bMouseUp=true;
		}
  
		if(SDL_GetMouseState(NULL,NULL)&SDL_BUTTON(1) && bMouseUp)
		{
			bMouseUp = false;

			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(50+y)) && (mousey<(90+y)))
			{
				//up
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].up = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //up
			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(100+y)) && (mousey<(140+y)))
			{
				//down
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].down = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //down
			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(150+y)) && (mousey<(190+y)))
			{
				//left
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].left = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //left
			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(200+y)) && (mousey<(240+y)))
			{
				//right
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].right = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //right
			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(250+y)) && (mousey<(290+y)))
			{
				//push
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].push = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //push
			if((mousex>(420+x)) && (mousex<(540+x)) && (mousey>(300+y)) && (mousey<(340+y)))
			{
				//change
				bool finnish = false;
				while(!finnish)
				 while ( SDL_PollEvent(&event) )
				 {
				  if(event.type == SDL_KEYDOWN)
				  {
					 if(event.key.keysym.sym != SDLK_ESCAPE)
						 keySettings[player].change = event.key.keysym.sym;
					 finnish = true;
				  }
				 }
			} //change
			//mouseplay:
            if((mousex>(220+x)) && (mousex<(262+x)) && (mousey>(350+y)) && (mousey<(392+y)))
			{
                if (player==0)
                {
                    mouseplay1 = !mouseplay1;
                }
                else
                {
                    mouseplay2 = !mouseplay2;
                }
            }
            //Joyplay:
            if((mousex>(460+x)) && (mousex<(502+x)) && (mousey>(350+y)) && (mousey<(392+y)))
			{
                if (player==0)
                {
                    joyplay1 = !joyplay1;
                }
                else
                {
                    joyplay2 = !joyplay2;
                }
            }
		}	//get mouse state

		DrawIMG(mouse,screen,mousex,mousey);
		SDL_Flip(screen);
	}	//while !done
	DrawIMG(background, screen, 0, 0);
	return 0;
}


//Dialogbox
bool OpenDialogbox(int x, int y, char *name)
{
	bool done = false;     //We are done!
	bool accept = false;   //New name is accepted! (not Canselled)
    bool repeating = false; //The key is being held (BACKSPACE)
    const int repeatDelay = 200;    //Repeating
	unsigned long time = 0;
	ReadKeyboard rk = ReadKeyboard(name);
	Uint8* keys;
	string strHolder;
	MakeBackground(1024,768);
	DrawIMG(background,screen,0,0);
	if(doublebuf)
    {   
       SDL_Flip(screen);
	   DrawIMG(background,screen,0,0);
    }
	while(!done)
	{
	DrawIMG(dialogBox,screen,x,y);
	SFont_Write(screen,fBlueFont,x+40,y+72,rk.GetString());
	strHolder = rk.GetString();
	strHolder.erase(rk.CharsBeforeCursor());
	if(((SDL_GetTicks()/600)%2)==1)
	SFont_Write(screen,fBlueFont,x+40+SFont_TextWidth(fBlueFont,strHolder.c_str()),y+69,"|");

	SDL_Event event;
    
    while ( SDL_PollEvent(&event) )
    {
      if ( event.type == SDL_QUIT )  {  done = true; accept = false; }

      if ( event.type == SDL_KEYDOWN )
      {
		if ( (event.key.keysym.sym == SDLK_RETURN)||(event.key.keysym.sym == SDLK_KP_ENTER) ) { done = true; accept = true;}
		else 
		if ( (event.key.keysym.sym == SDLK_ESCAPE) ) { done = true; accept = false;}
		else if(!(event.key.keysym.sym == SDLK_BACKSPACE)){if((rk.ReadKey(event.key.keysym.sym))&&(SoundEnabled))Mix_PlayChannel(1,typingChunk,0);}
		else if((event.key.keysym.sym == SDLK_BACKSPACE)&&(!repeating)){if((rk.ReadKey(event.key.keysym.sym))&&(SoundEnabled))Mix_PlayChannel(1,typingChunk,0); repeating = true; time=SDL_GetTicks();}
	  }

	}	//while(event)

    if(SDL_GetTicks()>(time+repeatDelay))
	  {
           time = SDL_GetTicks();
           keys = SDL_GetKeyState(NULL);
	       if( (keys[SDLK_BACKSPACE])&&(repeating) )
           {if((rk.ReadKey(SDLK_BACKSPACE))&&(SoundEnabled))Mix_PlayChannel(1,typingChunk,0);}
           else
           repeating = false;
       }

	SDL_Flip(screen); //Update screen
	}	//while(!done)
	strcpy(name,rk.GetString());
	bScreenLocked = false;
	showDialog = false;
	return accept;
}

//draws options:
inline void DrawOptions(int x, int y)
{
	if(MusicEnabled) DrawIMG(bOn,optionsBack,400,120);
	else DrawIMG(bOff,optionsBack,400,120);
	if(SoundEnabled) DrawIMG(bOn,optionsBack,400,170);
	else DrawIMG(bOff,optionsBack,400,170);
	if(bFullscreen) DrawIMG(bOn,optionsBack,400,220);
	else DrawIMG(bOff,optionsBack,400,220);	
	if(xsize==1024) DrawIMG(b1024,optionsBack,340,270);
	if(xsize==1280) DrawIMG(b1280,optionsBack,340,270);
	if(xsize==1400) DrawIMG(b1400,optionsBack,340,270);
	if(xsize==1600) DrawIMG(b1600,optionsBack,340,270);
	DrawIMG(bChange,optionsBack,230,435);
	DrawIMG(bChange,optionsBack,410,435);
	DrawIMG(bChange,optionsBack,230,500);
	DrawIMG(bChange,optionsBack,410,500);
	DrawIMG(optionsBack,screen,x,y);
}  //drawOptions

//Draws the balls and explosions
void DrawBalls()
{
    for(int i = 0; i< maxNumberOfBalls; i++)
    {
        if(theBallManeger.ballUsed[i])
        {
            DrawIMG(balls[theBallManeger.ballArray[i].getColor()],screen,theBallManeger.ballArray[i].getX(),theBallManeger.ballArray[i].getY());
        } //if used    
        if(theExplosionManeger.explosionUsed[i])
        {
            DrawIMG(explosion[theExplosionManeger.explosionArray[i].getFrame()],screen,theExplosionManeger.explosionArray[i].getX(),theExplosionManeger.explosionArray[i].getY());
        }
        /*if(theTextManeger.textUsed[i])
        {
            int x = theTextManeger.textArray[i].getX()-SFont_TextWidth(fBlueFont,theTextManeger.textArray[i].getText().c_str())/2;
            int y = theTextManeger.textArray[i].getY()-SFont_TextHeight(fBlueFont)/2;
            SFont_Write(screen,fBlueFont,x,y,theTextManeger.textArray[i].getText().c_str());
        }*/
    } //for    
}    //DrawBalls

//Removes the old balls
void UndrawBalls()
{
    for(int i = 0; i< maxNumberOfBalls; i++)
    {
        if(theBallManeger.oldBallUsed[i])
        {
            DrawIMG(background,screen,theBallManeger.oldBallArray[i].getX(),theBallManeger.oldBallArray[i].getY(),ballSize,ballSize,theBallManeger.oldBallArray[i].getX(),theBallManeger.oldBallArray[i].getY());
        } //if used    
        if(theExplosionManeger.oldExplosionUsed[i])
        {
            DrawIMG(background,screen,theExplosionManeger.oldExplosionArray[i].getX(),theExplosionManeger.oldExplosionArray[i].getY(),70,120,theExplosionManeger.oldExplosionArray[i].getX(),theExplosionManeger.oldExplosionArray[i].getY());
        }
        /*if(theTextManeger.oldTextUsed[i])
        {
            int x = theTextManeger.oldTextArray[i].getX()-SFont_TextWidth(fBlueFont,theTextManeger.oldTextArray[i].getText().c_str())/2;
            int y = theTextManeger.oldTextArray[i].getY()-SFont_TextHeight(fBlueFont)/2;
            DrawIMG(background,screen,x,y,SFont_TextWidth(fBlueFont,theTextManeger.oldTextArray[i].getText().c_str()),SFont_TextHeight(fBlueFont),x,y);
        }*/
    } //for    
}   //UndrawBalls

//Removes the old balls
void UndrawOlderBalls()
{
    for(int i = 0; i< maxNumberOfBalls; i++)
    {
        if(theBallManeger.olderBallUsed[i])
        {
            DrawIMG(background,screen,theBallManeger.olderBallArray[i].getX(),theBallManeger.olderBallArray[i].getY(),ballSize,ballSize,theBallManeger.olderBallArray[i].getX(),theBallManeger.olderBallArray[i].getY());
        } //if used  
        if(theExplosionManeger.olderExplosionUsed[i])
        {
            DrawIMG(background,screen,theExplosionManeger.olderExplosionArray[i].getX(),theExplosionManeger.olderExplosionArray[i].getY(),70,120,theExplosionManeger.olderExplosionArray[i].getX(),theExplosionManeger.olderExplosionArray[i].getY());
        }  
        /*if(theTextManeger.olderTextUsed[i])
        {
            int x = theTextManeger.olderTextArray[i].getX()-SFont_TextWidth(fBlueFont,theTextManeger.olderTextArray[i].getText().c_str())/2;
            int y = theTextManeger.olderTextArray[i].getY()-SFont_TextHeight(fBlueFont)/2;
            DrawIMG(background,screen,x,y,SFont_TextWidth(fBlueFont,theTextManeger.olderTextArray[i].getText().c_str()),SFont_TextHeight(fBlueFont),x,y);
        }*/
    } //for    
}   //UndrawBalls

//draws everything
void DrawEverything(int xsize, int ysize,BlockGame &theGame, BlockGame &theGame2)
{
  SDL_ShowCursor(0);
  //draw background:
  //DrawIMG(background, screen, 0, 0);
  if(forceredraw != 1)
  {
  if(!doublebuf)
  {
        UndrawBalls();
        DrawIMG(background,screen,oldMousex,oldMousey,32,32,oldMousex,oldMousey);
        DrawIMG(background,screen,oldBubleX,oldBubleY,140,50,oldBubleX,oldBubleY);
  }
  else
  {
        UndrawOlderBalls();
        DrawIMG(background,screen,olderMousex,olderMousey,32,32,olderMousex,olderMousey);
        DrawIMG(background,screen,olderBubleX,olderBubleY,140,50,olderBubleX,olderBubleY);
  }
  
  DrawIMG(background,screen,350,200,120,200,350,200);
  DrawIMG(background,screen,830,200,120,200,830,200);
  DrawIMG(background,screen,800,0,140,50,800,0);
  
  DrawIMG(background,screen,50,60,300,50,50,60);
  DrawIMG(background,screen,510,60,300,50,510,60);
  }
  else
  DrawIMG(background,screen,0,0);
  //draw bottons
  DrawIMG(bNewGame, screen, 0, 0);
  DrawIMG(bOptions, screen, 120,0);
  DrawIMG(bHighScore, screen, 2*120,0);
  DrawIMG(bExit, screen, xsize-120,ysize-120);
  //DrawIMG(boardBackBack,screen,theGame.topx-60,theGame.topy-68);
  DrawIMG(theGame.sBoard,screen,theGame.topx,theGame.topy);
  if(bNewGameOpen)
  {
      DrawIMG(bEndless,screen,0,40);
      DrawIMG(bTimeTrial,screen,0,80);
  }    
  string strHolder;
  strHolder = itoa(theGame.score);
  SFont_Write(screen,fBlueFont,theGame.topx+310,theGame.topy+100,strHolder.c_str());
  SFont_Write(screen,fBlueFont,theGame.topx+10,theGame.topy-40,player1name);
  if(theGame.timetrial)
  {
      int tid = (int)SDL_GetTicks()-theGame.gameStartedAt;
      int minutes;
      int seconds;
      if(tid>=0)
      {
        minutes = (2*60*1000-(abs((int)SDL_GetTicks()-theGame.gameStartedAt)))/60/1000;
        seconds = ((2*60*1000-(abs((int)SDL_GetTicks()-theGame.gameStartedAt)))%(60*1000))/1000;
      }
      else
      {
            minutes = ((abs((int)SDL_GetTicks()-theGame.gameStartedAt)))/60/1000;
            seconds = (((abs((int)SDL_GetTicks()-theGame.gameStartedAt)))%(60*1000))/1000;
        }
      if(theGame.bGameOver) minutes=0;
      if(theGame.bGameOver) seconds=0;
      if(seconds>9) 
      strHolder = itoa(minutes)+":"+itoa(seconds);
      else strHolder = itoa(minutes)+":0"+itoa(seconds);
  	  if((SoundEnabled)&&(tid>0)&&(seconds<5)&&(minutes == 0)&&(seconds>1)&&(!(Mix_Playing(6)))) Mix_PlayChannel(6,heartBeat,0);
	  SFont_Write(screen,fBlueFont,theGame.topx+310,theGame.topy+150,strHolder.c_str());
  }    
  else
  {
      int minutes = ((abs((int)SDL_GetTicks()-theGame.gameStartedAt)))/60/1000;
      int seconds = (((abs((int)SDL_GetTicks()-theGame.gameStartedAt)))%(60*1000))/1000;
      if(theGame.bGameOver) minutes=0;
      if(theGame.bGameOver) seconds=0;
      if(seconds>9) 
      strHolder = itoa(minutes)+":"+itoa(seconds);
      else strHolder = itoa(minutes)+":0"+itoa(seconds);
      SFont_Write(screen,fBlueFont,theGame.topx+310,theGame.topy+150,strHolder.c_str());
  }    
  strHolder = itoa(theGame.chain);
  SFont_Write(screen,fBlueFont,theGame.topx+310,theGame.topy+200,strHolder.c_str());
  //drawspeedLevel:
  strHolder = itoa(theGame.speedLevel);
  SFont_Write(screen,fBlueFont,theGame.topx+310,theGame.topy+250,strHolder.c_str());
  if((theGame.stageClear) &&(theGame.topy+700+50*(theGame.stageClearLimit-theGame.linesCleared)-theGame.pixels-1<600+theGame.topy)) 
  {
    olderBubleX = oldBubleX;
    olderBubleY = oldBubleY;
    oldBubleX = theGame.topx+280;
    oldBubleY = theGame.topy+650+50*(theGame.stageClearLimit-theGame.linesCleared)-theGame.pixels-1;
    DrawIMG(stageBobble,screen,theGame.topx+280,theGame.topy+650+50*(theGame.stageClearLimit-theGame.linesCleared)-theGame.pixels-1);
  }
  //player1 finnish, player2 start
  //DrawIMG(boardBackBack,screen,theGame2.topx-60,theGame2.topy-68);
  DrawIMG(theGame2.sBoard,screen,theGame2.topx,theGame2.topy);
  strHolder = itoa(theGame2.score);
  SFont_Write(screen,fBlueFont,theGame2.topx+310,theGame2.topy+100,strHolder.c_str());
  SFont_Write(screen,fBlueFont,theGame2.topx+10,theGame2.topy-40,player2name);
  if(theGame2.timetrial)
  {
      int tid = (int)SDL_GetTicks()-theGame2.gameStartedAt;
      int minutes; 
      int seconds; 
      if(tid>=0)
      {
        minutes = (2*60*1000-(abs((int)SDL_GetTicks()-theGame2.gameStartedAt)))/60/1000;
        seconds = ((2*60*1000-(abs((int)SDL_GetTicks()-theGame2.gameStartedAt)))%(60*1000))/1000;
      }
      else
      {
            minutes = ((abs((int)SDL_GetTicks()-theGame2.gameStartedAt)))/60/1000;
            seconds = (((abs((int)SDL_GetTicks()-theGame2.gameStartedAt)))%(60*1000))/1000;
        }
      if(theGame2.bGameOver) minutes=0;
      if(theGame2.bGameOver) seconds=0;
      if(seconds>9) 
        strHolder = itoa(minutes)+":"+itoa(seconds);
      else 
        strHolder = itoa(minutes)+":0"+itoa(seconds);
	  if((SoundEnabled)&&(tid>0)&&(seconds<5)&&(minutes == 0)&&(seconds>1)&&(!(Mix_Playing(6)))) Mix_PlayChannel(6,heartBeat,0);
      SFont_Write(screen,fBlueFont,theGame2.topx+310,theGame2.topy+150,strHolder.c_str());
  }    
  else
  {
      int minutes = (abs((int)SDL_GetTicks()-theGame2.gameStartedAt))/60/1000;
      int seconds = (abs((int)SDL_GetTicks()-theGame2.gameStartedAt)%(60*1000))/1000;
      if(theGame2.bGameOver) minutes=0;
      if(theGame2.bGameOver) seconds=0;
      if(seconds>9) 
        strHolder = itoa(minutes)+":"+itoa(seconds);
      else 
        strHolder = itoa(minutes)+":0"+itoa(seconds);
      SFont_Write(screen,fBlueFont,theGame2.topx+310,theGame2.topy+150,strHolder.c_str());
  }    
  strHolder = itoa(theGame2.chain);
  SFont_Write(screen,fBlueFont,theGame2.topx+310,theGame2.topy+200,strHolder.c_str());
  strHolder = itoa(theGame2.speedLevel);
  SFont_Write(screen,fBlueFont,theGame2.topx+310,theGame2.topy+250,strHolder.c_str());

  //player2 finnish
 
  if(bNewGameOpen)
  {
      DrawIMG(b1player,screen,0,40);
      DrawIMG(b2players,screen,0,80);
	  if(b1playerOpen)
	  {
		  DrawIMG(bEndless,screen,120,40);
		  DrawIMG(bTimeTrial,screen,120,80);
		  DrawIMG(bStageClear,screen,120,120);
		  DrawIMG(bPuzzle,screen,120,160);
	  }
	  else
	  if(b2playersOpen)
	  {
		  DrawIMG(bTimeTrial,screen,120,80);
		  DrawIMG(bVsMode,screen,120,120);
	  }
  }    
  if(showHighscores) DrawHighscores(100,100);
  if(showOptions) DrawOptions(100,100);

  DrawBalls();
	
  Frames++;
	if(SDL_GetTicks() >= Ticks + 1000)
	{
		if(Frames > 999) Frames=999;
		sprintf(FPS, "%li fps", Frames);
		Frames = 0;
		Ticks = SDL_GetTicks();
	}

	SFont_Write(screen,fBlueFont,800,4,FPS);
  
  //SDL_Flip(screen); //Update screen, now called outside DrawEvrything, bacause the mouse needs to be painted
  
}

//Generates the standard background
void MakeBackground(int xsize,int ysize)
{
    DrawIMG(backgroundImage,background,0,0);
    standardBackground = true;
}    

//Generates the background with red board backs
void MakeBackground(int xsize,int ysize,BlockGame &theGame, BlockGame &theGame2)
{
    DrawIMG(backgroundImage,background,0,0);
    DrawIMG(boardBackBack,background,theGame.topx-60,theGame.topy-68);
    DrawIMG(boardBackBack,background,theGame2.topx-60,theGame2.topy-68);
    standardBackground = false;
}    


//The function that allows the player to choose PuzzleLevel
int PuzzleLevelSelect()
{
    const int xplace = 200;
	const int yplace = 300;
	Uint8 *keys;
	int levelNr = -1, mousex, mousey;
	bool levelSelected = false;
	bool tempBool;
	
	//Loads the levels, if they havn't been loaded:
    LoadPuzzleStages();
	
	//Keeps track of background;
    int nowTime=SDL_GetTicks();
  
    ifstream puzzleFile(puzzleSavePath.c_str(),ios::binary);
    MakeBackground(1024,768);
    if(puzzleFile)
    {
        for(int i=0;i<nrOfPuzzles; i++)
        {
            puzzleFile.read(reinterpret_cast<char*>(&tempBool),sizeof(bool));
            puzzleCleared[i] = tempBool;
        }
        puzzleFile.close();
    }
    else
    {
        tempBool = false;
        for(int i=0; i<nrOfPuzzles; i++)
            puzzleCleared[i] = tempBool;
    }  
    
    do
	{
		nowTime=SDL_GetTicks();

		
		DrawIMG(background, screen, 0, 0);
		DrawIMG(iCheckBoxArea,screen,xplace,yplace);
		SFont_Write(screen,fBlueFont,xplace+12,yplace+2,"Select Puzzle");
		//Now drow the fields you click in (and a V if clicked):
		for(int i = 0; i < nrOfPuzzles;i++)
		{
            DrawIMG(iLevelCheckBox,screen,xplace+10+(i%10)*50, yplace+60+(i/10)*50);
			if(puzzleCleared[i]==true) DrawIMG(iLevelCheck,screen,xplace+10+(i%10)*50, yplace+60+(i/10)*50);
		}
		
		SDL_Event event;
		while ( SDL_PollEvent(&event) )
		if ( event.type == SDL_KEYDOWN )
		{
			if ( event.key.keysym.sym == SDLK_ESCAPE ) {levelNr = -1; levelSelected = true;}
		}

		keys = SDL_GetKeyState(NULL);

		SDL_GetMouseState(&mousex,&mousey);    

		// If the mouse button is released, make bMouseUp equal true
		if(!SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(1))
		{
			bMouseUp=true;
		}
  
		if(SDL_GetMouseState(NULL,NULL)&SDL_BUTTON(1) && bMouseUp)
		{
			bMouseUp = false;

			int levelClicked = -1;
			int i;
			for(i = 0; (i<nrOfPuzzles/10)||((i<nrOfPuzzles/10+1)&&(nrOfPuzzles%10 != 0)); i++)
			if((60+i*50<mousey-yplace)&&(mousey-yplace<i*50+92))
				levelClicked = i*10;
			i++;
			if(levelClicked != -1)
			for(int j = 0; ((j<nrOfStageLevels%(i*10))&&(j<10)); j++)
			if((10+j*50<mousex-xplace)&&(mousex-xplace<j*50+42))
			{
				levelClicked +=j;
				levelSelected = true;
				levelNr = levelClicked;
			}
		}

		DrawIMG(mouse,screen,mousex,mousey);
		SDL_Flip(screen); //draws it all to the screen

	} while(!levelSelected);
	DrawIMG(background, screen, 0, 0);
	return levelNr;
}

//The function that allows the player to choose Level number
int StageLevelSelect()
{
	const int xplace = 200;
	const int yplace = 300;
	Uint8 *keys;
	int levelNr = -1, mousex, mousey;
	bool levelSelected = false;
	bool tempBool;

  //Keeps track of background;
  int nowTime=SDL_GetTicks();

  MakeBackground(1024,768);
  ifstream stageFile(stageClearSavePath.c_str(),ios::binary);
  if(stageFile)
  {
	  for(int i = 0; i<nrOfStageLevels; i++)
	  {
		  stageFile.read(reinterpret_cast<char*>(&tempBool),sizeof(bool));
		  stageCleared[i]=tempBool;
	  }
	  stageFile.close();
  }
  else
  {
	  for(int i=0; i<nrOfStageLevels; i++)
		  stageCleared[i]= false;
  }


	do
	{
		nowTime=SDL_GetTicks();
		DrawIMG(background, screen, 0, 0);
		DrawIMG(iCheckBoxArea,screen,xplace,yplace);
		SFont_Write(screen,fBlueFont,xplace+12,yplace+2,"Stage Clear Level Select");
		for(int i = 0; i < nrOfStageLevels;i++)
		{
            DrawIMG(iLevelCheckBox,screen,xplace+10+(i%10)*50, yplace+60+(i/10)*50);
			if(stageCleared[i]==true) DrawIMG(iLevelCheck,screen,xplace+10+(i%10)*50, yplace+60+(i/10)*50);
		}
		
		SDL_Event event;
		while ( SDL_PollEvent(&event) )
		if ( event.type == SDL_KEYDOWN )
		{
			if ( event.key.keysym.sym == SDLK_ESCAPE ) {levelNr = -1; levelSelected = true;}
		}

		keys = SDL_GetKeyState(NULL);

		SDL_GetMouseState(&mousex,&mousey);    

		// If the mouse button is released, make bMouseUp equal true
		if(!SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(1))
		{
			bMouseUp=true;
		}
  
		if(SDL_GetMouseState(NULL,NULL)&SDL_BUTTON(1) && bMouseUp)
		{
			bMouseUp = false;

			int levelClicked = -1;
			int i;
			for(i = 0; (i<nrOfStageLevels/10)||((i<nrOfStageLevels/10+1)&&(nrOfStageLevels%10 != 0)); i++)
			if((60+i*50<mousey-yplace)&&(mousey-yplace<i*50+92))
				levelClicked = i*10;
			i++;
			if(levelClicked != -1)
			for(int j = 0; ((j<nrOfStageLevels%(i*10))&&(j<10)); j++)
			if((10+j*50<mousex-xplace)&&(mousex-xplace<j*50+42))
			{
				levelClicked +=j;
				levelSelected = true;
				levelNr = levelClicked;
			}
		}

		DrawIMG(mouse,screen,mousex,mousey);
		SDL_Flip(screen); //draws it all to the screen

	} while(!levelSelected);
	DrawIMG(background, screen, 0, 0);
	return levelNr;
}


//The main function, quite big... too big
int main(int argc, char *argv[])
{
    //We first create the folder there we will save (only o UNIX systems)
    //we call the external command "mkdir"... the user might have renamed this, but we hope he hasn't
  #if defined(__unix__)
  system("mkdir ~/.gamesaves");
  system("mkdir ~/.gamesaves/blockattack");
  #endif
	bool highPriority = false;	//if true the game will take most resources, but increase framerate.
	bFullscreen = false;
  if(argc > 1)
  {
  int argumentNr = 1;
  forceredraw = 2;
  while(argc>argumentNr)
  {
	  char helpString[] = "-h";
	  char priorityString[] = "-priority";
	  char forceRedrawString[] = "-forceredraw";
	  char forcepartdrawString[] = "-forcepartdraw";
	  if(!(strncmp(argv[argumentNr],helpString,2)))
	  {
		  cout << "Block Attack Help" << endl << "-help Display this message" << 
          endl << "-priority  Starts game in high priority" << endl <<
          "-forceredraw  Redraw the whole screen every frame, prevents garbage" << endl <<
          "-forcepartdraw  Only draw what is changed, sometimes cause garbage" << endl;
		  system("Pause");
		  return 0;
	  }
	  if(!(strncmp(argv[argumentNr],priorityString,9)))
	  {
		  cout << "Priority mode" << endl;
			highPriority = true;
	  }
	  if(!(strncmp(argv[argumentNr],forceRedrawString,12)))
	  {
            forceredraw = 1;
        }
      if(!(strncmp(argv[argumentNr],forcepartdrawString,14)))
	  {
            forceredraw = 2;
        }
	  argumentNr++;
  }   //while		  
  }   //if

  SoundEnabled = true;
  MusicEnabled = true;
  xsize = 1024;     //screen size x
  int ysize = 768;      //screen size y
  int mousex, mousey;   //Mouse coordinates
  showHighscores = false;
  showEndless = true;
  showOptions = false;
  b1playerOpen = false;
  b2playersOpen = false;
  bScreenLocked = false;
  bool twoPlayers = false;	//true if two players splitscreen
  bool vsMode = false;
  theTopScoresEndless = Highscore(1);
  theTopScoresTimeTrial = Highscore(2);
  drawBalls = true;
  puzzleLoaded = false;
  
  theBallManeger = ballManeger();
  theExplosionManeger = explosionManeger();
  //theTextManeger = textManeger();


//We now set the paths were we are saving, we are using the keyword __unix__ . I hope that all UNIX systems has a home folder
  #if defined(__unix__)
  string home = getenv("HOME");
  string optionsPath = home+"/.gamesaves/blockattack/options.dat";
  #else
  string optionsPath = "options.dat";
  #endif
  
  #if defined(__unix__)
  stageClearSavePath = home+"/.gamesaves/blockattack/stageClear.save";
  puzzleSavePath = home+"/.gamesaves/blockattack/puzzleClear.save";
  #else
  stageClearSavePath = "stageClear.save";
  puzzleSavePath = "puzzleClear.save";
  #endif
  
  Uint8 *keys;
  
  //Init SDL
  if ( SDL_Init(SDL_INIT_VIDEO) < 0 )
  {
    cout << "Unable to init SDL: " << SDL_GetError() << endl;
    exit(1);
  }
  atexit(SDL_Quit);		//quits SDL when the game stops for some reason (like you hit exit or Esc)
  
  Joypad_init();    //Prepare the joysticks
  
  Joypad joypad1 = Joypad();    //Creates a joypad
  Joypad joypad2 = Joypad();    //Creates a joypad
  
  //Open Audio
  if(Mix_OpenAudio(44100, AUDIO_S16SYS, 2, 2048) < 0)
  {
    cout << "Warning: Couldn't set 44100 Hz 16-bit audio - Reason: " << SDL_GetError() << endl;
  }
  
  SDL_WM_SetCaption("Block Attack - Rise of the Blocks", NULL); //Sets title line
  //Now sets the icon:
  SDL_Surface *icon = IMG_Load("gfx/icon.png");
  SDL_WM_SetIcon(icon,NULL);
  SDL_FreeSurface(icon);
  
  //Copyright notice:
  cout << "Block Attack - Rise of the Blocks (" << VERSION_NUMBER << ")" << endl << "Copyright 2004-2005 Poul Sander" << endl <<
          "A SDL based game (see www.libsdl.org)" << endl;
  #if defined(_WIN32)
    cout << "Windows build" << endl;
    #elif defined(__linux__)
    cout << "Linux build" <<  endl;
    #elif defined(__unix__)
    cout << "Unix build" <<  endl;
    #else
    cout << "Alternative build" << endl;
    #endif        
  cout << "-------------------------------------------" << endl;

  keySettings[0].up= SDLK_UP;
  keySettings[0].down = SDLK_DOWN;
  keySettings[0].left = SDLK_LEFT;
  keySettings[0].right = SDLK_RIGHT;
  keySettings[0].change = SDLK_KP_ENTER;
  keySettings[0].push = SDLK_KP0;

  keySettings[2].up= SDLK_w;
  keySettings[2].down = SDLK_s;
  keySettings[2].left = SDLK_a;
  keySettings[2].right = SDLK_d;
  keySettings[2].change = SDLK_LCTRL;
  keySettings[2].push = SDLK_LSHIFT;

  player1keys=0;
  player2keys=2;

  strcpy(player1name, "Poul Sander                 \0");
  strcpy(player2name, "Soeren                      \0");
  
  //Reads options from file:
  ifstream optionsFile(optionsPath.c_str(), ios::binary);
  if(optionsFile)
  {
	  //reads data: xsize,ysize,fullescreen, player1keys, player2keys, MusicEnabled, SoundEnabled,player1name,player2name
	  optionsFile.read(reinterpret_cast<char*>(&xsize), sizeof(int));
	  optionsFile.read(reinterpret_cast<char*>(&ysize), sizeof(int));
	  optionsFile.read(reinterpret_cast<char*>(&bFullscreen), sizeof(bool));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].up), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].down), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].left), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].right), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].change), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[0].push), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].up), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].down), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].left), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].right), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].change), sizeof(SDLKey));
	  optionsFile.read(reinterpret_cast<char*>(&keySettings[2].push), sizeof(SDLKey));	  
	  optionsFile.read(reinterpret_cast<char*>(&MusicEnabled), sizeof(bool));
	  optionsFile.read(reinterpret_cast<char*>(&SoundEnabled), sizeof(bool));
	  optionsFile.read(player1name, 30*sizeof(char));
	  optionsFile.read(player2name, 30*sizeof(char));
	  //mouseplay?
	  if(!optionsFile.eof())
	  {
         optionsFile.read(reinterpret_cast<char*>(&mouseplay1), sizeof(bool));
         optionsFile.read(reinterpret_cast<char*>(&mouseplay2), sizeof(bool));
         optionsFile.read(reinterpret_cast<char*>(&joyplay1),sizeof(bool));
         optionsFile.read(reinterpret_cast<char*>(&joyplay2),sizeof(bool));
      }
	  optionsFile.close();
	  cout << "Data loaded from options file" << endl;
  }
  else
  {
	  cout << "Unable to load options file, using default values" << endl;
  }

  //Open video
  //|SDL_RLEACCEL|SDL_HWACCEL|SDL_DOUBLEBUF
#ifdef __MORPHOS__
  if(bFullscreen) screen=SDL_SetVideoMode(xsize,ysize,32,SDL_SWSURFACE|SDL_FULLSCREEN);
  else screen=SDL_SetVideoMode(xsize,ysize,32,SDL_SWSURFACE);
#else
  if(bFullscreen) screen=SDL_SetVideoMode(xsize,ysize,32,SDL_HWSURFACE|SDL_HWPALETTE|SDL_DOUBLEBUF|SDL_FULLSCREEN|SDL_HWACCEL|SDL_ANYFORMAT);
  else screen=SDL_SetVideoMode(xsize,ysize,32,SDL_HWSURFACE|SDL_DOUBLEBUF|SDL_HWPALETTE|SDL_ANYFORMAT);
#endif
  
  if ( screen == NULL )
  {
    cout << "Unable to set " << xsize << "x" << ysize << " video: " << SDL_GetError() << endl;
    exit(1);
  }
  if(((screen->flags)&SDL_DOUBLEBUF)==SDL_DOUBLEBUF)
    doublebuf = true;
  cout << "Screen set, doublebuf: " << doublebuf << endl;

  //Loading all images into memory
  InitImages();

  cout << "Images loaded" << endl;

  BlockGame theGame = BlockGame(50,100);			//creates game objects
  BlockGame theGame2 = BlockGame(xsize-500,100);
  theGame.DoPaintJob();			//Makes sure what there is something to paint
  theGame2.DoPaintJob();
  theGame.SetGameOver();		//sets the game over in the beginning
  theGame2.SetGameOver();
  

    //Takes names from file instead
  strcpy(theGame.name, player1name);
  strcpy(theGame2.name, player2name);

  //Keeps track of background;
  //int nowTime=SDL_GetTicks();
 

  
  //Draws everything to screen
  MakeBackground(xsize,ysize,theGame,theGame2);
  DrawIMG(background, screen, 0, 0);
  DrawEverything(xsize,ysize,theGame,theGame2);
  SDL_Flip(screen);
  DrawIMG(background, screen, 0, 0);
  DrawEverything(xsize,ysize,theGame,theGame2);
  SDL_Flip(screen);
  
  //game loop
  int done = 0;
  cout << "Starting game loop" << endl;
  while(done == 0)
  {
    if(!(highPriority)) SDL_Delay(10);
    
    if(standardBackground)
    {
        MakeBackground(xsize,ysize,theGame,theGame2);
        DrawIMG(background, screen, 0, 0);
    }
          
    //updates the balls and explosions:
    theBallManeger.update();
    theExplosionManeger.update();
    //theTextManeger.update();
        
	if(!bScreenLocked)
	{
    SDL_Event event;
    
    while ( SDL_PollEvent(&event) )
    {
      if ( event.type == SDL_QUIT )  {  done = 1;  }

      if ( event.type == SDL_KEYDOWN )
      {
		  if ( event.key.keysym.sym == SDLK_ESCAPE ) 
          { 
                if(showHighscores)
                {
                    showHighscores = false;
                }
                else 
                    if(showOptions)
                    {
                        showOptions = false;
                    } 
                    else 
                        done=1; 
            DrawIMG(background, screen, 0, 0);
            
            
            if(doublebuf)	
            {
                SDL_Flip(screen);
                DrawIMG(background, screen, 0, 0);
                //SDL_Flip(screen); //draws it all to the screen
            }
        }
        //player1:
		if ( event.key.keysym.sym == keySettings[player1keys].up ) { theGame.MoveCursor('N'); }
        if ( event.key.keysym.sym == keySettings[player1keys].down ) { theGame.MoveCursor('S'); }
        if ( (event.key.keysym.sym == keySettings[player1keys].left) && (showGame) ) { theGame.MoveCursor('W'); }
        if ( (event.key.keysym.sym == keySettings[player1keys].right) && (showGame) ) { theGame.MoveCursor('E'); }
		if ( event.key.keysym.sym == keySettings[player1keys].push ) { theGame.PushLine(); }
        if ( event.key.keysym.sym == keySettings[player1keys].change ) { theGame.SwitchAtCursor();}
		//player2:
		if ( event.key.keysym.sym == keySettings[player2keys].up ) { theGame2.MoveCursor('N'); }
        if ( event.key.keysym.sym == keySettings[player2keys].down ) { theGame2.MoveCursor('S'); }
        if ( (event.key.keysym.sym == keySettings[player2keys].left) && (showGame) ) { theGame2.MoveCursor('W'); }
        if ( (event.key.keysym.sym == keySettings[player2keys].right) && (showGame) ) { theGame2.MoveCursor('E'); }
		if ( event.key.keysym.sym == keySettings[player2keys].push ) { theGame2.PushLine(); }
        if ( event.key.keysym.sym == keySettings[player2keys].change ) { theGame2.SwitchAtCursor();}
        //common:
		if ( ((event.key.keysym.sym == SDLK_LEFT)||(event.key.keysym.sym == SDLK_RIGHT)) && (showHighscores) ) {showEndless = !showEndless;}
        
        if ( event.key.keysym.sym == SDLK_F2 ) {if((!showHighscores)&&(!showOptions)){theGame.NewGame(50,100); theGame.timetrial = false; bNewGameOpen = false; twoPlayers =false; theGame2.SetGameOver(); showGame = true; vsMode = false;}}
        if ( event.key.keysym.sym == SDLK_F3 ) {if((!showHighscores)&&(!showOptions)){theGame.NewGame(50,100); theGame.timetrial = true; bNewGameOpen = false; twoPlayers =false; theGame2.SetGameOver(); showGame = true; vsMode = false;}}
		if ( event.key.keysym.sym == SDLK_F5 ) 
        {
            if((!showHighscores)&&(!showOptions))
            { 
                int myLevel = StageLevelSelect(); 
                theGame.NewStageGame(myLevel,50,100); 
                MakeBackground(xsize,ysize,theGame,theGame2); 
                DrawIMG(background, screen, 0, 0); 	
                if(doublebuf)	
                    {
                        SDL_Flip(screen); //draws it all to the screen
                        DrawIMG(background, screen, 0, 0);
                    }
                bNewGameOpen = false; 
                twoPlayers =false; 
                theGame2.SetGameOver(); 
                showGame = true; 
                vsMode = false;
            }
        }
		if ( event.key.keysym.sym == SDLK_F6 ) 
		{
			if((!showHighscores)&&(!showOptions))
			{
				theGame.NewVsGame(50,100,&theGame2); 
				theGame2.NewVsGame(xsize-500,100,&theGame); 
                bNewGameOpen = false;
				vsMode = true;
				twoPlayers = true;
			}
		}
		if ( event.key.keysym.sym == SDLK_F4 ) 
		{
			if((!showHighscores)&&(!showOptions))
			{
				theGame.NewGame(50,100); 
				theGame2.NewGame(xsize-500,100); 
				theGame.timetrial = true;
				theGame2.timetrial = true;
				bNewGameOpen = false;
				twoPlayers = true;
			} 
		}
		if ( event.key.keysym.sym == SDLK_F7 ) 
        {
            if((!showHighscores)&&(!showOptions))
            {
                int myLevel = PuzzleLevelSelect(); 
                theGame.NewPuzzleGame(myLevel,50,100); 
                MakeBackground(xsize,ysize,theGame,theGame2); 
                DrawIMG(background, screen, 0, 0); 	
                if(doublebuf)	
                    {
                        SDL_Flip(screen); //draws it all to the screen
                        DrawIMG(background, screen, 0, 0);
                    }
                bNewGameOpen = false; 
                twoPlayers = false; 
                theGame2.SetGameOver(); 
                showGame = true; 
                vsMode = false;
            }
        }
        if ( event.key.keysym.sym == SDLK_F8 ) 
        {
            if((!showGame)&&(!showOptions)) 
            if(!showHighscores)
            {
                showHighscores = true; 
                bNewGameOpen = false;
            } 
            else 
            {
                showEndless = !showEndless;
            }
        }
        if ( event.key.keysym.sym == SDLK_F9 ) {writeScreenShot();}
        if ( event.key.keysym.sym == SDLK_F11 ) {/*Insert test here*/}
        if ( event.key.keysym.sym == SDLK_F12 ) {done=1;}
      }
    } //while event PollEvent - read keys

/**********************************************************************
***************************** Joypad start ****************************
**********************************************************************/

    if(joyplay1||joyplay2)
    {
    if(joypad1.working)
        if(joyplay1)
        {
            joypad1.update();
            if(joypad1.up)
                theGame.MoveCursor('N');
            if(joypad1.down)
                theGame.MoveCursor('S');
            if(joypad1.left)
                theGame.MoveCursor('W');
            if(joypad1.right)
                theGame.MoveCursor('E');
            if(joypad1.but1)
                theGame.SwitchAtCursor();
            if(joypad1.but2)
                theGame.PushLine();
        }
        else
        {
            joypad1.update();
            if(joypad1.up)
                theGame2.MoveCursor('N');
            if(joypad1.down)
                theGame2.MoveCursor('S');
            if(joypad1.left)
                theGame2.MoveCursor('W');
            if(joypad1.right)
                theGame2.MoveCursor('E');
            if(joypad1.but1)
                theGame2.SwitchAtCursor();
            if(joypad1.but2)
                theGame2.PushLine();
        }
    if(joypad2.working)
        if(!joyplay2)
        {
            joypad2.update();
            if(joypad2.up)
                theGame.MoveCursor('N');
            if(joypad2.down)
                theGame.MoveCursor('S');
            if(joypad2.left)
                theGame.MoveCursor('W');
            if(joypad2.right)
                theGame.MoveCursor('E');
            if(joypad2.but1)
                theGame.SwitchAtCursor();
            if(joypad2.but2)
                theGame.PushLine();
        }
        else
        {
            joypad2.update();
            if(joypad2.up)
                theGame2.MoveCursor('N');
            if(joypad2.down)
                theGame2.MoveCursor('S');
            if(joypad2.left)
                theGame2.MoveCursor('W');
            if(joypad2.right)
                theGame2.MoveCursor('E');
            if(joypad2.but1)
                theGame2.SwitchAtCursor();
            if(joypad2.but2)
                theGame2.PushLine();
        }
    }

/**********************************************************************
***************************** Joypad end ****************************
**********************************************************************/


    keys = SDL_GetKeyState(NULL);
  
  SDL_GetMouseState(&mousex,&mousey);    

  /********************************************************************
  **************** Here comes mouse play ******************************
  ********************************************************************/
  
    if(mouseplay1) //player 1
    if((mousex > 50)&&(mousey>100)&&(mousex<50+300)&&(mousey<100+600))
    {
        int yLine, xLine;
        yLine = ((100+600)-(mousey-100+theGame.pixels))/50;
        xLine = (mousex-50+25)/50;
        yLine-=2;
        xLine-=1;
        if((yLine>10)&&(theGame.TowerHeight<12))
            yLine=10;
        if(((theGame.pixels==50)||(theGame.pixels==0)) && (yLine>11))
            yLine=11;
        if(yLine<0)
            yLine=0;
        if(xLine<0)
            xLine=0;
        if(xLine>4)
            xLine=4;
        theGame.cursorx=xLine;
        theGame.cursory=yLine;
    }
    
    if(mouseplay2) //player 2
    if((mousex > xsize-500)&&(mousey>100)&&(mousex<xsize-500+300)&&(mousey<100+600))
    {
        int yLine, xLine;
        yLine = ((100+600)-(mousey-100+theGame2.pixels))/50;
        xLine = (mousex-(xsize-500)+25)/50;
        yLine-=2;
        xLine-=1;
        if((yLine>10)&&(theGame2.TowerHeight<12))
            yLine=10;
        if(((theGame2.pixels==50)||(theGame2.pixels==0)) && (yLine>11))
            yLine=11;
        if(yLine<0)
            yLine=0;
        if(xLine<0)
            xLine=0;
        if(xLine>4)
            xLine=4;
        theGame2.cursorx=xLine;
        theGame2.cursory=yLine;
    }
  
  /********************************************************************
  **************** Here ends mouse play *******************************
  ********************************************************************/

  // If the mouse button is released, make bMouseUp equal true
  if(!SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(1))
  {
    bMouseUp=true;
  }
  
  // If the mouse button 2 is released, make bMouseUp2 equal true
  if((SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(3))!=SDL_BUTTON(3))
  {
    bMouseUp2=true;
  }
  
  //read mouse events
  if(SDL_GetMouseState(NULL,NULL)&SDL_BUTTON(1) && bMouseUp)
  {
    bMouseUp = false;
    DrawIMG(background, screen, 0, 0);
    if(doublebuf)
    {
        SDL_Flip(screen);
        DrawIMG(background,screen,0,0);
    }
    if((0<mousex) && (mousex<120) && (0<mousey) && (mousey<40))
    {
        //New game clicked
        bNewGameOpen = (!bNewGameOpen); //theGame.NewGame(50,100);
        showOptions = false;
        showHighscores = false;
    }
	else
	if((0<mousex) && (mousex<120) && (40<mousey) && (mousey<80) && (bNewGameOpen))
    {
		//1player
        b1playerOpen = (!b1playerOpen);
		b2playersOpen = false;
    }
	else
	if((0<mousex) && (mousex<120) && (80<mousey) && (mousey<120) && (bNewGameOpen))
    {
		//2player
        b2playersOpen = (!b2playersOpen);
		b1playerOpen = false;
    }
	else
    if((0<mousex) && (mousex<120) && (80<mousey) && (mousey<120) && (bNewGameOpen))
    {
        //2players
        b1playerOpen = false;
		b2playersOpen = true;
    }
    else
    if((120<mousex) && (mousex<240) && (40<mousey) && (mousey<80) && (b1playerOpen))
    {
        //1 player - endless
        theGame.NewGame(50,100);
        bNewGameOpen = false;
		b1playerOpen = false;
        twoPlayers =false; theGame2.SetGameOver(); showGame = true;
    }
    else
    if((120<mousex) && (mousex<240) && (80<mousey) && (mousey<120) && (b1playerOpen))
    {
        //1 player - time trial
        theGame.NewGame(50,100); theGame.timetrial=true;
        bNewGameOpen = false;
		b1playerOpen = false;
		twoPlayers =false; theGame2.SetGameOver(); showGame = true;
    }
	else
    if((120<mousex) && (mousex<240) && (120<mousey) && (mousey<160) && (b1playerOpen))
    {
        //1 player - stage clear
        bNewGameOpen = false;
		b1playerOpen = false;
		int myLevel = StageLevelSelect(); 
		theGame.NewStageGame(myLevel,50,100); 
		MakeBackground(xsize,ysize,theGame,theGame2); 
        DrawIMG(background, screen, 0, 0); 	
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
		twoPlayers =false; theGame2.SetGameOver(); showGame = true;
		vsMode = false;
    }
    	else
    if((120<mousex) && (mousex<240) && (160<mousey) && (mousey<2000) && (b1playerOpen))
    {
        //1 player - puzzle
        bNewGameOpen = false;
		b1playerOpen = false;
		int myLevel = PuzzleLevelSelect(); 
		theGame.NewPuzzleGame(myLevel,50,100); 
		MakeBackground(xsize,ysize,theGame,theGame2);
		DrawIMG(background, screen, 0, 0);
		if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
		twoPlayers =false; theGame2.SetGameOver(); showGame = true;
		vsMode = false;
    }
	else
    if((120<mousex) && (mousex<240) && (80<mousey) && (mousey<120) && (b2playersOpen))
    {
        //2 player - time trial
        theGame.NewGame(50,100); theGame.timetrial=true;
        bNewGameOpen = false;
		b2playersOpen = false;
		theGame.NewGame(50,100); 
		theGame2.NewGame(xsize-500,100); 
		theGame.timetrial = true;
		theGame2.timetrial = true;
		twoPlayers = true;
    }
    else
	if((120<mousex) && (mousex<240) && (120<mousey) && (mousey<160) && (b2playersOpen))
    {
        //2 player - VsMode
		theGame.NewVsGame(50,100,&theGame2); 
		theGame2.NewVsGame(xsize-500,100,&theGame); 
		bNewGameOpen = false;
		vsMode = true;
		twoPlayers = true;
		b2playersOpen = false;
    }
	else
    if((120<mousex) && (mousex<2*120) && (0<mousey) && (mousey<40))
    {
		//options button clicked
		if(!showOptions) { showOptions = true; showHighscores = false; }
		else showOptions = false;
        bNewGameOpen = false;
        DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
    }
    else
    if((120*2<mousex) && (mousex<3*120) && (0<mousey) && (mousey<40))
    {
		//highscore button clicked
        bNewGameOpen = false;
        if(!showHighscores) {showHighscores = true; showOptions = false;}
        else showHighscores = false;
        DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
    }
    else
    if((xsize-120<mousex) && (xsize-20>mousex) && (ysize-120<mousey) && (ysize-20>mousey))
    {
        //Exit clicked
        done=1;
    }
	else
	if((showOptions) && (mousex>500) && (mousex<560) && (mousey>220) && (mousey<260))
	{
		MusicEnabled = !MusicEnabled;
		if(!MusicEnabled) Mix_FadeOutMusic(500);
	}
	if((showOptions) && (mousex>500) && (mousex<560) && (mousey>270) && (mousey<310))
	{
		SoundEnabled = !SoundEnabled;
	}
	if((showOptions) && (mousex>500) && (mousex<560) && (mousey>320) && (mousey<360))
	{
		//Fullscreen
		bFullscreen = !bFullscreen;
		SDL_WM_ToggleFullScreen(screen); //Will only work in Linux
#ifdef __MORPHOS__
		SDL_Flip(screen);
#endif
		SDL_ShowCursor(SDL_DISABLE);
	}
	
	if((showOptions) && (mousex>330) && (mousex<470) && (mousey>535) && (mousey<585))
	{
		//change name
		bScreenLocked = true;
		showDialog = true;
		if(OpenDialogbox(200,100,player1name))
		strcpy(theGame.name, player1name);
		else
		strcpy(player1name,theGame.name);
		bScreenLocked = false;
		showDialog = false;
		MakeBackground(xsize,ysize,theGame,theGame2);
		DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
	}
	if((showOptions) && (mousex>330) && (mousex<470) && (mousey>600) && (mousey<640))
	{
		//change name
		bScreenLocked = true;
		showDialog = true;
		if(OpenDialogbox(200,100,player2name))
		strcpy(theGame2.name, player2name);
		else
		strcpy(player2name,theGame2.name);
		bScreenLocked = false;
		showDialog = false;
		MakeBackground(xsize,ysize,theGame,theGame2);
		DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
	}
	if((showOptions) && (mousex>510) && (mousex<630) && (mousey>535) && (mousey<585))
	{
		//changeControls
		OpenControlsBox(200,100,0);
		MakeBackground(xsize,ysize,theGame,theGame2);
		DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
	}
	if((showOptions) && (mousex>510) && (mousex<630) && (mousey>600) && (mousey<640))
	{
		//changeControls
		OpenControlsBox(200,100,2);
		MakeBackground(xsize,ysize,theGame,theGame2);
		DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
	}
	if((showHighscores)&&(((mousex>150)&&(mousex<173))||((mousex>628)&&(mousex<650)))&&(mousey<652)&&(mousey>630))
	{
        //small arrors on Highscore board clicked!
        showEndless = !showEndless;
        DrawIMG(background, screen, 0, 0);
        if(doublebuf)	
        {
            SDL_Flip(screen); //draws it all to the screen
            DrawIMG(background, screen, 0, 0);
        }
    }
  /********************************************************************
  **************** Here comes mouse play ******************************
  ********************************************************************/
  if((!showOptions)&&(!showHighscores))
  {
    if(mouseplay1) //player 1
    if((mousex > 50)&&(mousey>100)&&(mousex<50+300)&&(mousey<100+600))
    {
        theGame.SwitchAtCursor();
    }
    if(mouseplay2) //player 2
    if((mousex > xsize-500)&&(mousey>100)&&(mousex<xsize-500+300)&&(mousey<100+600))
    {
        theGame2.SwitchAtCursor();
    }
  } 
    /********************************************************************
    **************** Here ends mouse play *******************************
    ********************************************************************/
    
    //cout << "Mouse x: " << mousex << ", mouse y: " << mousey << endl;
  }
  
  //Mouse button 2:
    if((SDL_GetMouseState(NULL,NULL)&SDL_BUTTON(3))==SDL_BUTTON(3) && bMouseUp2)
    {
        bMouseUp2=false; //The button is pressed
        /********************************************************************
        **************** Here comes mouse play ******************************
        ********************************************************************/
        if((!showOptions)&&(!showHighscores))
        {
            if(mouseplay1) //player 1
            if((mousex > 50)&&(mousey>100)&&(mousex<50+300)&&(mousey<100+600))
            {
                theGame.PushLine();
            }
            if(mouseplay2) //player 2
            if((mousex > xsize-500)&&(mousey>100)&&(mousex<xsize-500+300)&&(mousey<100+600))
            {
                theGame2.PushLine();
            }
        }  
        /********************************************************************
        **************** Here ends mouse play *******************************
        ********************************************************************/
    }
  
  } //if !bScreenBocked;

  
  //Sees if music is stopped and if music is enabled
  if((!Mix_PlayingMusic())&&(MusicEnabled))
    {
      // then starts playing it.
      Mix_PlayMusic(bgMusic, 0); //music loop
    }
  
  //Updates the objects
  theGame.Update();
  theGame2.Update();

 //see if anyone has won (two players only)
  if(twoPlayers)
  {
	  if((theGame.bGameOver) && (theGame2.bGameOver))
	  {
		  if(theGame.score>theGame2.score)
			  theGame.setPlayerWon();
		  else
		    if(theGame.score<theGame2.score)
			  theGame2.setPlayerWon();
			else {theGame.setDraw(); theGame2.setDraw();}
		  twoPlayers = false;
	  }
	  if((theGame.bGameOver) && (!theGame2.bGameOver))
	  {
		  theGame2.setPlayerWon();
		  twoPlayers = false;
	  }
	  if((!theGame.bGameOver) && (theGame2.bGameOver))
	  {
		  theGame.setPlayerWon();
		  twoPlayers = false;
	  }
  }

  //Once evrything has been checked, update graphics
  DrawEverything(xsize,ysize,theGame, theGame2);
  SDL_GetMouseState(&mousex,&mousey);
  //Remember mouse placement
  olderMousex = oldMousex;
  olderMousey = oldMousey;
  oldMousex = mousex;
  oldMousey = mousey;
  //Draw the mouse: 
  DrawIMG(mouse,screen,mousex,mousey);
  SDL_Flip(screen);
  } //game loop
  
  

  //Saves options
  ofstream optionsFileOut;
  optionsFileOut.open(optionsPath.c_str(),ios::binary|ios::trunc);
  if(optionsFileOut)
  {
	//writes data: xsize,ysize,fullescreen, player1keys, player2keys, MusicEnabled, SoundEnabled,player1name,player2name
    optionsFileOut.write(reinterpret_cast<char*>(&xsize),sizeof(int));
	optionsFileOut.write(reinterpret_cast<char*>(&ysize),sizeof(int));
	optionsFileOut.write(reinterpret_cast<char*>(&bFullscreen),sizeof(bool));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].up), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].down), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].left), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].right), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].change), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[0].push), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].up), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].down), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].left), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].right), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].change), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&keySettings[2].push), sizeof(SDLKey));
	optionsFileOut.write(reinterpret_cast<char*>(&MusicEnabled),sizeof(bool));
	optionsFileOut.write(reinterpret_cast<char*>(&SoundEnabled),sizeof(bool));
	optionsFileOut.write(player1name,30*sizeof(char));
	optionsFileOut.write(player2name,30*sizeof(char));
	optionsFileOut.write(reinterpret_cast<char*>(&mouseplay1),sizeof(bool));
	optionsFileOut.write(reinterpret_cast<char*>(&mouseplay2),sizeof(bool));
	optionsFileOut.write(reinterpret_cast<char*>(&joyplay1),sizeof(bool));
	optionsFileOut.write(reinterpret_cast<char*>(&joyplay2),sizeof(bool));
	optionsFileOut.close();
	cout << "options written to file" << endl;
  }
  else
  {
	  cout << "Failed to write options" << endl;
  }


  //Frees memory from music and fonts
  //This is done after writing of options since it's often crashing the program :(
  UnloadImages(); 

  //calculate uptime:
  int hours, mins, secs, time;
  time = SDL_GetTicks();
  hours = time/(1000*60*60);
  time = time % (1000*60*60);
  mins = time/(1000*60);
  time = time % (1000*60);
  secs = time/1000;
  
  cout << "Block Attack - Rise of the Blocks run for: " << hours << " hours " << mins << " mins and " << secs << " secs" << endl;         
          	
  return 0;
}
