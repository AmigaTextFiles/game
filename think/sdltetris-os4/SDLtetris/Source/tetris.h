#ifndef TETRIS_H
#define TETRIS_H

#include <SDL.h>
#include <vector>
#include <string>
#include "namedv.h"
#include "layers.h"
#include "pieces.h"

using namespace std;

class tetris
{
	public:
	vector< vector<signed char> > board;
	vector< vector<signed char> > bufboard;
	namedv *prefs;
	piece curPiece, nextPiece;
	vector<string> pieceSpecs;
	SDL_Surface *screen;
	SDL_Surface *allBlocks;
	SDL_Surface *blocks[7];
	SDL_Surface *levelFont;
	SDL_Surface *smallNumFont;
	SDL_Surface *gameOver;
	SDL_Surface *pausedImg;
	SDL_Surface *levelBox;
	SDL_Surface *pointsBox;
	SDL_Surface *linesBox;
	SDL_Surface *background;
	SDL_Surface *nextPieceBox;
	layerset ls;
	int level;
	int points;
	enum {baseSpeed = 500};
	unsigned int speed;
	int clearedLines;
	int clearedLinesLevel;
	bool paused;
	bool awaitingGravity;
	unsigned long lastStep;
	tetris (namedv *prefsPtr);
	~tetris (void);
	string strInt (int n);
	void loadSurfs (void);
	SDL_Surface *loadSurf (string imgPath, int alpha, const char *name);
	SDL_Surface *loadSurf (int width, int height, const char *name);
	void dieSurf (SDL_Surface *surf, const char *name);
	void pause (void);
	void initBoard (void);
	void initLayers (void);
	void loadPieces (void);
	int handleEvents (SDL_Event *event);
	void updateWin (void);
	void dropPiece (void);
	bool checkLine (bool type, int line);
	bool gravity (void);
	int random (int min, int max);
	void incSpeed (void);
	void setLevel (int newLevel);
	piece randPiece (void);
	void setBoard (int x, int y, int val);
	bool turnPiece (bool direction);
	void movePiece (int xChange, int yChange);
	void updateLevel (void);
	void updatePoints (void);
	void updateLines (void);
	void blitNums (int num, SDL_Surface *destSurf, SDL_Surface *font);
	void updateNextPiece (void);
	void clearSurf (SDL_Surface *surf);
	bool gameLoop (void);
	bool endGame (void);
	void reset (void);
	SDL_Surface *create_compatible_surface(SDL_Surface* surf, int width, int height);
};

#endif
