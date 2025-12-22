#include "tetris.h"
#include "layers.h"
#include "pieces.h"
#include "namedv.h"
#include "prefs_file.h"
#include <SDL.h>
#include <SDL_image.h>
#include <vector>
#include <string>
#include <stdio.h>
#include <algorithm>
#include <ctime>
#include <fstream>
#include <cstdlib>

using namespace std;

bool tetris::gameLoop (void)
{
	random(0,1);
	SDL_EnableKeyRepeat(prefs->geti("key_repeat_delay"), prefs->geti("key_repeat_rate"));
	SDL_Event event;
	curPiece = randPiece();
	nextPiece = randPiece();
	updateNextPiece();
	updateLevel();
	updatePoints();
	updateLines();
	updateWin();
	lastStep = SDL_GetTicks();
	bool playing = true;
	bool exit = false;
	while (playing)
	{
		bool udWin = false;
		while (SDL_PollEvent(&event) && playing == true)
		{
			int result = handleEvents(&event);
			if (result == 1) udWin = true;
			if (result == 2) {playing = false;}
			if (result == 3) {playing = false; exit = true;}
		}
		while (lastStep+speed < SDL_GetTicks() && paused == false)
		{
			if (!awaitingGravity)
			{
				if (curPiece.canMove(0,1))
				{
					movePiece(0, 1);
					udWin = true;
				} else {
					if (curPiece.getTop() >= 0)
					{
						dropPiece();
						udWin = true;
					} else {
						playing = false;
					}
				}
			}else{
			gravity();
			udWin = true;
			awaitingGravity = false;
			}
			lastStep += speed;
		}
		if (udWin) updateWin();
		SDL_Delay(1);
	}
	if (!exit) exit = endGame();
	return exit;
}

bool tetris::endGame (void)
{
	SDL_EnableKeyRepeat(0, 0); //disable key repeat
	unsigned int ended = SDL_GetTicks();
	SDL_Rect src, dest;
	SDL_GetClipRect(gameOver, &src);
	dest = src;
	dest.x = (prefs->geti("board_x")+(prefs->geti("board_width")*prefs->geti("block_size"))/2)-src.w/2;
	dest.y = (prefs->geti("board_y")+(prefs->geti("board_height")*prefs->geti("block_size"))/2)-src.h/2;
	SDL_BlitSurface(gameOver, &src, screen, &dest);
	SDL_Flip(screen);
	SDL_Event event;
	while (SDL_PollEvent(&event)) {} //clear events
	while (SDL_WaitEvent(&event) != 0)
	{
		if (event.type == SDL_QUIT)
		{
			return true;
		} else if (event.type == SDL_KEYDOWN)
		{
			SDLKey sym = event.key.keysym.sym;
			if (sym == SDLK_RETURN || sym == SDLK_ESCAPE || (sym == SDLK_SPACE && SDL_GetTicks() > ended+1500))
			{
				return false;
			}
		}
	}
	return "";
}

void tetris::setBoard (int x, int y, int val)
{
	if (x >= 0 && y >= 0 && (unsigned)x < board[0].size() && (unsigned)y < board.size())
	{
		//printf("x: %i | y: %i\n", x, y);
		board[y][x] = val;
	}
}

void tetris::incSpeed (void)
{
	speed = (int)((speed+35)/1.5);
}

void tetris::dropPiece (void)
{
	while (curPiece.canMove(0,1))
	{
		movePiece(0, 1);
	}
	for (int i = 0; i < 4; i++)
	{
		setBoard(curPiece.map[i][0]+curPiece.x, curPiece.map[i][1]+curPiece.y, curPiece.graphic);
	}
	int oldy = curPiece.y;
	curPiece = nextPiece;
	nextPiece = randPiece();
	updateNextPiece();
	int cleared = 0;
	for (int i = 0; i < 4; i++)
	{
		if (checkLine(1, oldy+i))
		{
			for (unsigned int x = 0; x < board[oldy+i].size(); x++)
			{
				setBoard(x, oldy+i, -1);
			}
			cleared++;
			clearedLines++;
			clearedLinesLevel++;
		}
		if (clearedLinesLevel >= 10)
		{
			setLevel(level+1);
			updateLevel();
		}
	}
	points += cleared*cleared*level;
	if (cleared && !checkLine(board.size()-1, 0)) awaitingGravity = true;
	updatePoints();
	updateLines();
}

void tetris::setLevel (int newLevel)
{
	if (newLevel == level+1)
	{
		incSpeed();
		level++;
	} else {
		level = 1;
		speed = baseSpeed;
		while (level < newLevel)
		{
			incSpeed();
			level++;
		}
	}
	clearedLinesLevel = clearedLinesLevel%10;
}

bool tetris::gravity (void)
{
	int moveDown = 0;
	int dropped = 0;
	for (int y = board.size()-1; y >= 0; y--)
	{
		if (checkLine(0, y))
		{
			moveDown++;
		} else if (moveDown > 0) {
			for (unsigned int x = 0; x < board[y].size(); x++)
			{
				if (!curPiece.blockOn(x, y))
				{
					board[y+moveDown][x] = board[y][x];
					board[y][x] = -1;
					dropped++;
					//printf ("%i:%i\n",x,y);
				}
			}
		}
	}
	if (dropped) {awaitingGravity = false; return true;} else {return false;}
}

bool tetris::checkLine (bool type, int line)
{
	if (line < 0 || (unsigned)line >= board.size()) return false;
	for (unsigned int i = 0; i < board[line].size(); i++)
	{
		if (curPiece.blockOn(i, line))
		{
			return false;
		}
		if ((board[line][i] == -1 && type == 1) || (board[line][i] != -1 && type == 0))
		{
			return (false);
		}
	}
	return (true);
}

void tetris::updateNextPiece (void)
{
	SDL_Rect rect;
	SDL_GetClipRect(nextPieceBox, &rect);
	clearSurf(nextPieceBox);
	SDL_Rect src, dest;
	int block_size = prefs->geti("block_size");
	int lx, hx, ly, hy, cx, cy;
	lx = 3;
	ly = 3;
	hx = 0;
	hy = 0;
	for (int i = 0; i < 4; i++)
	{
		if (nextPiece.map[i][0] < lx) lx = nextPiece.map[i][0];
		if (nextPiece.map[i][0] > hx) hx = nextPiece.map[i][0];
		if (nextPiece.map[i][1] < ly) ly = nextPiece.map[i][1];
		if (nextPiece.map[i][1] > hy) hy = nextPiece.map[i][1];
	}
	cx = (int)((float)(lx+(hx-lx+1)/2.0)*block_size - block_size*2);
	cy = (int)((float)(ly+(hy-ly+1)/2.0)*block_size - block_size*2);
	src.w = block_size;
	src.h = block_size;
	src.x = 0;
	src.y = 0;
	dest = src;
	SDL_SetAlpha(blocks[nextPiece.graphic], 0, 0);
	for (int i = 0; i < 4; i++)
	{
		dest.x = nextPiece.map[i][0]*block_size-cx;
		dest.y = nextPiece.map[i][1]*block_size-cy;
		SDL_BlitSurface(blocks[nextPiece.graphic], &src, nextPieceBox, &dest);
	}
	SDL_SetAlpha(blocks[nextPiece.graphic], SDL_SRCALPHA, 0);
	ls.findByName(string("next_piece"))->changed = true;
}

void tetris::clearSurf (SDL_Surface *surf)
{
	SDL_FillRect(surf, NULL, SDL_MapRGBA(surf->format, 0, 0, 0, 0));
}

piece tetris::randPiece (void)
{
	return(piece(pieceSpecs[random(0, pieceSpecs.size()-1)], prefs->geti("board_width")/2-2, -4, &board));
}

int tetris::handleEvents (SDL_Event *event)
{
	string keyname;
	switch (event->type)
	{
		case SDL_KEYDOWN:
		keyname = string(SDL_GetKeyName(event->key.keysym.sym));
		//printf("%s\n", keyname.c_str());
		if (keyname == (*prefs)["pause_key"])
		{
			pause();
			if (!paused)
			{
				return(1);
			} else {
				return(0);
			}
		} else if (paused)
		{
			return (0);
		}else if (awaitingGravity)
		{
			return (0);
		}else if (keyname == (*prefs)["turn_left_key"])
		{
			if (turnPiece(1)) return (1);
		} else if (keyname == (*prefs)["turn_right_key"]) {
			if (turnPiece(0)) return (1);
		} else if (keyname == (*prefs)["move_left_key"]) {
			if (curPiece.canMove(-1,0))
			{
				movePiece(-1, 0);
				return (1);
			}
		} else if (keyname == (*prefs)["move_right_key"]) {
			if (curPiece.canMove(1,0))
			{
				movePiece(1, 0);
				return (1);
			}
		} else if (keyname == (*prefs)["move_down_key"]) {
			if (curPiece.canMove(0,1))
			{
				movePiece(0, 1);
				return (1);
			}
		} else if (keyname == (*prefs)["drop_key"]) {
			if (!curPiece.canMove(0,1) && curPiece.y < 0)
			{
				return (2);
			}
			dropPiece();
			lastStep = SDL_GetTicks();
			return (1);
		}
		break;
		
		case SDL_ACTIVEEVENT:
		if (event->active.state == SDL_APPINPUTFOCUS || event->active.state == SDL_APPACTIVE)
		{
			if (event->active.gain == 0 && paused == false)
			{
				pause();
				return(0);
			}
		}
		break;
		
		case SDL_QUIT:
		return (3);
		break;
		
		default:
		return (0);
		break;
	}
	return (0);
}

void tetris::pause (void)
{
	layer *l;
	if (!paused)
	{
		for (int x = 0; x < prefs->geti("board_width"); x++)
		{
			for (int y = 0; y < prefs->geti("board_height"); y++)
			{
				if (bufboard[y][x] != -1)
				{
					bufboard[y][x] = -1;
					l = ls.findByName(strInt(x)+string(":")+strInt(y));
					l->surf = NULL;
					l->changed = true;
				}
			}
		}
		l = ls.findByName("paused");
		l->surf = pausedImg;
		l->changed = true;
		ls.blit(screen);
		SDL_Flip(screen);
	} else {
		l = ls.findByName("paused");
		l->surf = NULL;
		l->changed = true;
		lastStep = SDL_GetTicks()-(lastStep % speed);
	}
	paused ? paused = false : paused = true;
}

bool tetris::turnPiece (bool direction)
{
	piece oldPiece = curPiece;
	bool result = curPiece.turn(direction);
	if (result)
	{
		for (int i = 0; i < 4; i++)
		{
			setBoard(oldPiece.x+oldPiece.map[i][0], oldPiece.y+oldPiece.map[i][1], -1);
		}
		for (int i = 0; i < 4; i++)
		{
			setBoard(curPiece.x+curPiece.map[i][0], curPiece.y+curPiece.map[i][1], curPiece.graphic);
		}
	}
	return (result);
}

void tetris::movePiece (int xChange, int yChange)
{
	piece oldPiece = curPiece;
	curPiece.x += xChange;
	curPiece.y += yChange;
	for (int i = 0; i < 4; i++)
	{
		setBoard(oldPiece.x+oldPiece.map[i][0], oldPiece.y+oldPiece.map[i][1], -1);
	}
	for (int i = 0; i < 4; i++)
	{
		setBoard(curPiece.x+curPiece.map[i][0], curPiece.y+curPiece.map[i][1], curPiece.graphic);
	}
}

void tetris::updateWin (void)
{
	layer *l;
	for (int y = 0; y < prefs->geti("board_height"); y++)
	{
		for (int x = 0; x < prefs->geti("board_width"); x++)
		{
			if (board[y][x] != bufboard[y][x])
			{
				bufboard[y][x] = board[y][x];
				l = ls.findByName(strInt(x)+string(":")+strInt(y));
				if (board[y][x] != -1)
				{
					l->surf = blocks[board[y][x]];
				} else {
					l->surf = NULL;
				}
				l->changed = true;
			}
		}
	}
	ls.blit(screen);
	SDL_Flip(screen);
}

void tetris::updateLevel (void)
{
	SDL_Rect box, letter, dest;
	SDL_GetClipRect(levelBox, &box);
	SDL_GetClipRect(levelFont, &letter);
	dest = letter;
	letter.h = levelFont->h/10;
	dest.y = (box.h/2)-(letter.h/2);
	dest.x = (box.w/2)-letter.w;
	clearSurf(levelBox);
	if (level >= 10)
	{
		letter.y = (int)(level/10)*letter.h;
		SDL_BlitSurface(levelFont, &letter, levelBox, &dest);
		dest.x += letter.w;
	} else {
		dest.x += letter.w/2;
	}
	letter.y = (int)(level%10)*(letter.h);
	SDL_BlitSurface(levelFont, &letter, levelBox, &dest);
	ls.findByName("level")->changed = true;
}

void tetris::updatePoints (void)
{
	blitNums(points, pointsBox, smallNumFont);
	ls.findByName("points")->changed = true;
}

void tetris::updateLines (void)
{
	blitNums(clearedLines, linesBox, smallNumFont);
	ls.findByName("lines")->changed = true;
}

void tetris::blitNums (int num, SDL_Surface *destSurf, SDL_Surface *font)
{
	string numStr = strInt(num);
	SDL_Rect letter, box, dest;
	SDL_GetClipRect(font, &letter);
	SDL_GetClipRect(destSurf, &box);
	clearSurf(destSurf);
	letter.h = letter.h/10;
	dest = letter;
	dest.x = destSurf->w;
	dest.y = (destSurf->h/2)-(dest.h/2);
	for (int i = numStr.size()-1; i > -1; i--)
	{
		dest.x -= dest.w;
		letter.y = (atoi(numStr.substr(i, 1).c_str()))*dest.h;
		SDL_BlitSurface(font, &letter, destSurf, &dest);
	}
}

tetris::tetris (namedv *prefsPtr)
{
	srand(static_cast<unsigned>(time(0)));
	screen = SDL_GetVideoSurface();
	paused = false;
	awaitingGravity = false;
	level = 1;
	points = 0;
	clearedLines = 0;
	clearedLinesLevel = 0;
	speed = baseSpeed;
	prefs = prefsPtr;
	loadPieces();
	loadSurfs();
	initBoard();
	initLayers();
}

tetris::~tetris (void)
{
	SDL_FreeSurface(background);
	SDL_FreeSurface(levelFont);
	SDL_FreeSurface(smallNumFont);
	SDL_FreeSurface(gameOver);
	SDL_FreeSurface(levelBox);
	SDL_FreeSurface(pointsBox);
	SDL_FreeSurface(linesBox);
	SDL_FreeSurface(nextPieceBox);
	SDL_FreeSurface(pausedImg);
	for (int i = 0; i < 7; i++)
	{
		SDL_FreeSurface(blocks[i]);
	}
}

void tetris::loadPieces (void)
{
	ifstream file((*prefs)["pieces_file"].c_str());
	string line;
	while (getline(file, line) != 0)
	{
		pieceSpecs.push_back(line);
	}
}

void tetris::initBoard (void)
{
	vector<signed char> temp;
	for (int i = 0; i < prefs->geti("board_width"); i++)
	{
		temp.push_back(-1);
	}
	for (int y = 0; y < prefs->geti("board_height"); y++)
	{
		bufboard.push_back(temp);
		board.push_back(temp);
	}
}

void tetris::loadSurfs (void)
{
	background = loadSurf((*prefs)["background_img"], 0, "background image");
	levelFont = loadSurf((*prefs)["level_font"], 1, "level font");
	smallNumFont = loadSurf((*prefs)["small_num_font"], 1, "small number font");
	gameOver = loadSurf((*prefs)["game_over_img"], 2, "game over image");
	pausedImg = loadSurf((*prefs)["paused_img"], 2, "paused image");
	allBlocks = loadSurf((*prefs)["blocks_img"], 1, "blocks image");
	
	SDL_Surface *temp;
	SDL_Rect src, dest;
	src.x = 0;
	src.y = 0;
	src.w = prefs->geti("block_size");
	src.h = src.w;
	dest = src;
	for (int i = 0; i < 7; i++)
	{
		temp = create_compatible_surface(screen, prefs->geti("block_size"), prefs->geti("block_size"));
		dieSurf(temp, "a block (temp)");
		blocks[i] = SDL_DisplayFormatAlpha(temp);
		dieSurf(blocks[i], "a block");
		SDL_FreeSurface(temp);
		SDL_BlitSurface(allBlocks, &src, blocks[i], &dest);
		SDL_SetAlpha(blocks[i], SDL_SRCALPHA, 0);
		src.y += src.h;
	}
	SDL_FreeSurface(allBlocks);
	
	nextPieceBox = loadSurf(prefs->geti("block_size")*4, prefs->geti("block_size")*4, "next piece box");
	pointsBox = loadSurf(prefs->geti("points_w"), prefs->geti("points_h"), "points box");
	linesBox = loadSurf(prefs->geti("lines_w"), prefs->geti("lines_h"), "lines box");
	levelBox = loadSurf(prefs->geti("level_w"), prefs->geti("level_h"), "level box");
}

SDL_Surface *tetris::loadSurf (string imgPath, int alpha, const char *name)
{
	SDL_Surface *temp = IMG_Load(imgPath.c_str());
	SDL_Surface *surf;
	dieSurf(temp, name);
	if (alpha)
	{
		surf = SDL_DisplayFormatAlpha(temp);
	} else {
		surf = SDL_DisplayFormat(temp);
	}
	dieSurf(surf, name);
	if (alpha > 1)
	{
		SDL_SetAlpha(surf, SDL_SRCALPHA | SDL_RLEACCEL, 0);
	} else {
		SDL_SetAlpha(surf, 0, 0);
	}
	SDL_FreeSurface(temp);
	return(surf);
}

SDL_Surface *tetris::loadSurf (int width, int height, const char *name)
{
	SDL_Surface *temp = create_compatible_surface(screen, width, height);
	dieSurf(temp, name);
	SDL_Surface *surf = SDL_DisplayFormatAlpha(temp);
	dieSurf(surf, name);
	SDL_SetAlpha(surf, SDL_SRCALPHA, 0);
	return(surf);
}

void tetris::dieSurf (SDL_Surface *surf, const char *name)
{
	if (surf == NULL)
	{
		printf("couldn't load \"%s\", gotta go!\n", name);
		exit(1);
	}
}

SDL_Surface *tetris::create_compatible_surface(SDL_Surface* surf, int width, int height)
{
	//copied from Wesnoth - thanks Sirp :)
	if(width == -1)
		width = surf->w;
	if(height == -1)
		height = surf->h;
	return SDL_CreateRGBSurface(SDL_SWSURFACE,width,height,surf->format->BitsPerPixel,surf->format->Rmask,surf->format->Gmask,surf->format->Bmask,surf->format->Amask);
}

void tetris::initLayers (void)
{
	ls.add(layer("background", background, 0, 0));
	ls.add(layer("next_piece", nextPieceBox, prefs->geti("next_piece_x"), prefs->geti("next_piece_y")));
	ls.add(layer("level", levelBox, prefs->geti("level_x"), prefs->geti("level_y")));
	ls.add(layer("points", pointsBox, prefs->geti("points_x"), prefs->geti("points_y")));
	ls.add(layer("lines", linesBox, prefs->geti("lines_x"), prefs->geti("lines_y")));
	SDL_Rect rect;
	rect.x = 0;
	rect.y = 0;
	rect.w = prefs->geti("block_size");
	rect.h = prefs->geti("block_size");
	for (int y = 0; y < prefs->geti("board_height"); y++)
	{
		for (int x = 0; x < prefs->geti("board_width"); x++)
		{
			
			ls.add(layer(strInt(x)+string(":")+strInt(y), NULL, prefs->geti("board_x")+x*prefs->geti("block_size"), prefs->geti("board_y")+y*prefs->geti("block_size"), rect));
		}
	}
	ls.add(layer(string("paused"), NULL, (prefs->geti("board_x")+(prefs->geti("board_width")*prefs->geti("block_size"))/2)-pausedImg->w/2, (prefs->geti("board_y")+(prefs->geti("board_height")*prefs->geti("block_size"))/2)-pausedImg->h/2));
}

void tetris::reset (void)
{
	paused = false;
	awaitingGravity = false;
	level = 1;
	points = 0;
	clearedLines = 0;
	clearedLinesLevel = 0;
	speed = baseSpeed;
	for (int y = 0; y < prefs->geti("board_height"); y++)
	{
		for (int x = 0; x < prefs->geti("board_width"); x++)
		{
			board[y][x] = -1;
			bufboard[y][x] = -1;
			ls.findByName(strInt(x)+string(":")+strInt(y))->surf = NULL;
		}
	}
	for (unsigned int i = 0; i < ls.layers.size(); i++)
	{
		ls.layers[i].changed = true;
	}
}

string tetris::strInt (int n)
{
	char chr[sizeof(int)*8+1];
	sprintf(chr, "%i", n);
	return(string(chr));
}

int tetris::random(int min, int max)
{
	if (min > max)
	{
    	swap(min, max);
    }
	int range = max - min + 1;
	int rando = rand();
	int ret = min + int(range * (rando/(RAND_MAX + 1.0)));
	return ret;
}
