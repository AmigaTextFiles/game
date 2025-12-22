/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: torrent.c
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software Foundation,
 *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#include "ShiftyEngine.h"

#ifdef __MORPHOS__
#define random rand
#define srandom srand
#endif
/* Forward References */
void SE_Redraw();

enum Color { BLUE = 0, BLUE_BOMB, RED, RED_BOMB, GREEN, GREEN_BOMB, 
	     PURPLE, PURPLE_BOMB, GOLD, GOLD_BOMB, BLANK };

#define MAX_COLORS      5
#define LEVEL_SIZE_INC  3
#define LEVEL_COLOR_INC 3
#define BOMB_ODDS       20
#define BOTTOM_X        207
#define BOTTOM_Y        512
#define TOP_X           207
#define TOP_Y           (512 - (32 * 12))
#define BOARD_SIZE      384
#define ICON_SIZE       32
#define QUIT_X          635
#define QUIT_Y          500
#define QUIT_H          70
#define QUIT_W          110
#define START_X         630
#define START_Y         200
#define START_H         70
#define START_W         200
#define HELP_X          635
#define HELP_Y          350
#define HELP_W          110
#define HELP_H          70
#define CLOSE_X         350
#define CLOSE_Y         490
#define CLOSE_H         50
#define CLOSE_W         114
#define PREV_X          210
#define PREV_Y          CLOSE_Y
#define PREV_H          50
#define PREV_W          100
#define NEXT_X          500
#define NEXT_Y          CLOSE_Y
#define NEXT_H          50
#define NEXT_W          80
#define HELP_LINES      9

TTF_Font * font  = 0;
TTF_Font * font2 = 0;
TTF_Font * font3 = 0;

SDL_Surface * text           = 0;
SDL_Surface * blueTile       = 0;
SDL_Surface * redTile        = 0;
SDL_Surface * greenTile      = 0;
SDL_Surface * purpleTile     = 0;
SDL_Surface * goldTile       = 0;
SDL_Surface * blueBombTile   = 0;
SDL_Surface * redBombTile    = 0;
SDL_Surface * greenBombTile  = 0;
SDL_Surface * purpleBombTile = 0;
SDL_Surface * goldBombTile   = 0;
SDL_Surface * blankTile      = 0;
SDL_Surface * mask           = 0;

SDL_Color blue   = {13, 103, 142, 255};
SDL_Color green2 = {6, 76, 183, 255};
SDL_Color green  = {13, 225, 142, 255};
SDL_Color black  = {0, 0, 0, 255};
SDL_Color white  = {255, 255, 255, 255};

Mix_Chunk * gameOverSound;
Mix_Chunk * clickSound;
Mix_Chunk * overSound;
Mix_Chunk * bombClickSound;
Mix_Chunk * bonusSound;
Mix_Chunk * levelOverSound;

int gameOver     = 0;
int del          = 0;
int isBomb       = 0;
int overQuit     = 0;
int overStart    = 0;
int overHelp     = 0;
int overNext     = 0;
int overPrev     = 0;
int overClose    = 0;
int stateChanged = 0;
int score        = 0;
int currentLevel = 0;
int level        = 0;
int LEVELSIZE    = 0;
int NR_COLORS    = 0;
int NR_LEVELS    = 0;
int newGame      = 0;
int xBSize       = 12;
int yBSize       = 12;
int tileCount    = 0;
int running      = 0;
int levelEnd     = 0;
int remaining    = 0;
int emptyLevels  = 0;
int scoreAdd     = 0;
int drawing      = 0;

struct scoreText {
	int x, y;
	char str[16];
	struct scoreText * next, * prev;
} * scoreTexts = 0;

struct Tile {
	int x, y;  //screen x and y location
	int checked;
	enum Color color;
	SDL_Surface * tile;
} * board[12][12];

struct LOC {
	int x, y;
} deletions[144];

char * helpText[] = {
	"Objective:", 
	" To keep the tiles from reaching",
	"the top of the screen. If they",
	"do then the game is over.",
	"Additional color are added as",
	"the levels increase and the",
	"speed at which new rows",
	"appears also increases. Just to",
	"make things a little harder",
	"'dead' blocks start to appear",
	"after level three, these blocks",
	"can not be removed.",
	"To remove blocks you must",
	"click on groups of three or",
	"more (diagnals do not count) or",
	"you can click on the 'bomb'",
	"tiles (they have a check mark)",
	"which clear all the tiles of",
	"that color.",
	" ",
	"Volume:",
	" To adjust the sound volume",
	"click the icon in the upper",
	"right hand corner to toggle",
	"between high, low and off",
	"settings.",
	" ",
	"Hot Keys:",
	"f: toggle full screen mode",
	"q: quit"
};

/*****************************************************
 ****************************************************/
void quit()
{
	SE_Quit();
}

/*****************************************************
 ****************************************************/
void setTile(struct Tile * tile, const int bomb, const int color)
{
	switch(color) {
	case 0:
		if(bomb) {
			tile->color = RED;
			tile->tile = redTile;
		}
		else {
			tile->color = RED_BOMB;
			tile->tile = redBombTile;
		}
		break;
	case 1:
		if(bomb) {
			tile->color = BLUE;
			tile->tile = blueTile;
		}
		else {
			tile->color = BLUE_BOMB;
			tile->tile = blueBombTile;
		}
		break;
	case 2:
		if(bomb) {
			tile->color = GREEN;
			tile->tile = greenTile;
		}
		else {
			tile->color = GREEN_BOMB;
			tile->tile = greenBombTile;
		}
		break;

	case 3:
		if(bomb) {
			tile->color = PURPLE;
			tile->tile = purpleTile;
		}
		else {
			tile->color = PURPLE_BOMB;
			tile->tile = purpleBombTile;
		}
		break;
	case 4:
		if(bomb) {
			tile->color = GOLD;
			tile->tile = goldTile;
		}
		else {
			tile->color = GOLD_BOMB;
			tile->tile = goldBombTile;
		}
		break;
	case 5:
		tile->color = BLANK;
		tile->tile = blankTile;
		
		break;
	}
}

/*****************************************************
 ****************************************************/
void game_over()
{
	int x, y, i, cont = 1;
	SDL_Rect dest;
	gameOver = 1;

	score += scoreAdd;

	scoreAdd     = 0;
	running      = 0;
	newGame      = 1;

	SDL_Delay(500);
	while(cont) {
		cont = 0;
		dest.x = 200;
		dest.y = 0;
		dest.w = 400;
		dest.h = 600;
		SDL_BlitSurface(background, &dest, screen, &dest);
		
		for(x = 0; x < xBSize; x++) {
			for(y = 0; y < yBSize; y++) {
				if(board[y][x]) {
					board[y][x]->y += random() % 20 + 10;
					if(board[y][x]->y < 600)
						cont = 1;
					dest.x = board[y][x]->x;
					dest.y = board[y][x]->y;
					SDL_BlitSurface(board[y][x]->tile, 0, screen, &dest);
				}
			}
		}
		dest.x = 200;
		dest.y = 540;
		dest.w = 400;
		dest.h = 60;
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_UpdateRect(screen, 0, 0, 0, 0);
		SDL_Delay(30);
	}

	stateChanged = 1;
}

void jiggleBoard()
{

	int i, x, y;
	SDL_Rect dest;

	while(drawing) ;

	drawing = 1;

	for(i = 0; i < 3; i++) {
		for(x = 0; x < xBSize; x++) {
			for(y = 0; y < yBSize; y++) {
				if(board[y][x]) {
					dest.x = board[y][x]->x + random()%5;
					dest.y = board[y][x]->y + random()%5;
					SDL_BlitSurface(board[y][x]->tile, 0, screen, &dest);
				}
			}
		}
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_UpdateRect(screen, 0, 0, 0, 0);
	}
	drawing = 0;
}

/*****************************************************
 ****************************************************/
Uint32 mytimer(Uint32 interval, void * param)
{
	int x, y;

	if(++level > LEVELSIZE) {
		level--; //to keep from showing -1 on board
		playSound(levelOverSound);
		stateChanged = 1;
		running      = 0;
		levelEnd     = 1;
		score += scoreAdd;
		scoreAdd = 0;
		remaining   = 0; 
		emptyLevels = 0;
		

		// Count number of empty layers and remaining blocks
#ifndef __MORPHOS__
		for(int y = 0; y < yBSize; y++) {
#else
		for(y = 0; y < yBSize; y++) {
#endif
			int start = remaining;
			
#ifndef __MORPHOS__
			for(int x = 0; x < xBSize; x++) {
#else
			for(x = 0; x < xBSize; x++) {
#endif
				if(board[y][x])
					remaining++;
			}
			
			if(remaining == start)
				emptyLevels++;
		}
		
		return 0;
	}

	// Check if Tiles have reached the top
	for(x = 0; x < xBSize; x++) {
		if(board[yBSize - 1][x]) {
			playSound(gameOverSound);
			game_over();
			return 0;
		}
	}

	//Shift everything up one
	for(x = 0; x < xBSize; x++) {
		for(y = yBSize - 1; y > 0; y--) {
			board[y][x] = board[y - 1][x];
			if(board[y][x]) {
				board[y][x]->y -= ICON_SIZE;
				board[y - 1][x] = NULL;
			}
		}
	}

	// Put new row at the bottom
	y = 0;
	for(x = 0; x < xBSize; x++) {
		board[y][x] = (struct Tile *)malloc(sizeof(struct Tile));
		if(!board[y][x]) {
			SE_Error("Out of Memory!");
			quit();
		}

		if((random() % (1000 / currentLevel) == 0) && currentLevel > 3)
			setTile(board[y][x], 0, 5);
		else
			setTile(board[y][x], random() % BOMB_ODDS, random() % NR_COLORS);

		board[y][x]->x       = BOTTOM_X + (x * ICON_SIZE);
		board[y][x]->y       = BOTTOM_Y - (y * ICON_SIZE);
		board[y][x]->checked = 0;

		tileCount++;
	}

	stateChanged = 1;

	return interval;
}

/*****************************************************
 ****************************************************/
void newBoard()
{
	int x, y;

	srand(time(0));

	tileCount = 0;
	level     = 0;
	levelEnd  = 0;

	/* Initiate new game values */
	if(newGame) {
		LEVELSIZE    = 5;
		NR_COLORS    = 2;
		NR_LEVELS    = 3;
		newGame      = 0;
		currentLevel = 0;
		score        = 0;
	}

	if(currentLevel % LEVEL_COLOR_INC == 0) {
		NR_LEVELS++;
		if(NR_LEVELS > 11) 
			NR_LEVELS = 11;
		if(NR_COLORS < MAX_COLORS)
			NR_COLORS++;
	}

	LEVELSIZE += LEVEL_SIZE_INC;

	/* Delete old board */
	for(x = 0; x < xBSize; x++) {
		for(y = 0; y < yBSize; y++) {
			if(board[y][x]) 
				free(board[y][x]);
			board[y][x] = NULL;
		}
	}

	/* Create New Board */
	for(x = 0; x < xBSize; x++) {
		for(y = 0; y < NR_LEVELS; y++) {
			board[y][x] = (struct Tile *)malloc(sizeof(struct Tile));
			if(!board[y][x]) {
				SE_Error("Out of Memory!");
				quit();
			}

			setTile(board[y][x], rand() % BOMB_ODDS, rand() % NR_COLORS);

			board[y][x]->x       = BOTTOM_X + (x * ICON_SIZE);
			board[y][x]->y       = BOTTOM_Y - (y * ICON_SIZE);
			board[y][x]->checked = 0;

			tileCount++;
		}
	}

	currentLevel++;
}

/*****************************************************
 ****************************************************/
void start()
{
	if(running)
		return;

	running      = 1;
	stateChanged = 1;
	gameOver     = 0;

	newBoard();
	srandom(time(0));
	SDL_AddTimer(2500 - (currentLevel * 150), mytimer, 0);
}

/*****************************************************
 ****************************************************/
void drawNumber(int num, int x, int y, char * text2)
{
	SDL_Rect dest;
	char str[32];
	
	text = TTF_RenderText_Blended(font3, text2, black);
	dest.x = x; 
	dest.y = y;
	dest.h = text->h; 
	dest.w = text->w;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	sprintf(str, "%d", num);	
	text = TTF_RenderText_Blended(font2, str, green2);
	dest.x = x; 
	dest.y = y + 30;
	dest.h = text->h; 
	dest.w = text->w;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);
}

/*****************************************************
 ****************************************************/
void drawText(int x, int y, char * str, TTF_Font * font, int over)
{
	SDL_Rect dest;

	if(over == 1) {
		text = TTF_RenderText_Blended(font, str, black);
		if(x == -1)
			dest.x = ((WIDTH - text->w)/2) + 2; 
		else			
			dest.x = x+2; 
		dest.y = y+2;
		dest.h = text->h; 
		dest.w = text->w;
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
		text = TTF_RenderText_Blended(font, str, green2);
	}
	else if(over == 2) {
		text = TTF_RenderText_Blended(font, str, black);
		if(x == -1)
			dest.x = ((WIDTH - text->w)/2) + 2; 
		else			
			dest.x = x+2; 
		dest.y = y+2;
		dest.h = text->h; 
		dest.w = text->w;
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
		text = TTF_RenderText_Blended(font, str, white);
	}
	else {
		text = TTF_RenderText_Blended(font, str, green2);
		if(x == -1)
			dest.x = (WIDTH - text->w)/2 + 2; 
		else			
			dest.x = x+2; 		
		dest.y = y+2;
		dest.h = text->h; 
		dest.w = text->w;
		SDL_BlitSurface(background, &dest, screen, &dest);
	}

	if(x == -1)
		dest.x = (WIDTH - text->w)/2; 
	else			
		dest.x = x; 		
	dest.y = y;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	if(drawing) 
		return;
	drawing = 1;

	SDL_UpdateRect(screen, dest.x, dest.y, dest.w + 4, dest.h + 4);
	drawing = 0;
}



/*****************************************************
 ****************************************************/
void help()
{
	SDL_Event event;
	SDL_Rect src;
	unsigned int i, j = 0, x = 210, y = 0, change = 1;

	SDL_SetAlpha(mask, SDL_SRCALPHA, 180);
	if(SDL_BlitSurface(mask, 0, screen, 0) != 0)
		SE_Error("A blit failed.");

	while(1) {
		if(change) {
			y = 164;
			
			src.x = x-3; src.y = y-3;
			src.h = src.w = 384;
			if(SDL_BlitSurface(background, &src, screen, &src) != 0)
				SE_Error("A blit failed.");

			for(i = 0; i < HELP_LINES - 1; i++)
				drawText(x, y + (i * 38), helpText[i + j], font3, 2);
			
			drawText(PREV_X + 10, PREV_Y, "Prev", font2, overPrev);
			drawText(CLOSE_X + 10, PREV_Y, "Close", font2, overClose);
			drawText(NEXT_X + 10, NEXT_Y, "Next", font2, overNext);

			SDL_UpdateRect(screen, 0, 0, 0, 0);
			change = 0;
		}
		if(SDL_PollEvent(&event)) {
			int x, y;
			switch(event.type) {
			case SDL_KEYDOWN:
				switch(event.key.keysym.sym) {
				case SDLK_q:
					quit();
					break;
				case SDLK_f:
					SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
					break;
				default:
					break;
				}
				break;
			case SDL_QUIT:
				quit();
				break;
			case SDL_MOUSEBUTTONDOWN:
				x = event.button.x;
				y = event.button.y;
				if(x > PREV_X && x < PREV_X + PREV_W &&
				   y > PREV_Y && y < PREV_Y + PREV_H) {
					if(j == 0) break;
					j--;
					change = 1;
				}
				else if(x > NEXT_X && x < NEXT_X + NEXT_W &&
					y > NEXT_Y && y < NEXT_Y + NEXT_H) {
					j++;
					change = 1;
					if(j > sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1) 
						j = sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1;
				}
				else if(x > CLOSE_X && x < CLOSE_X + CLOSE_W &&
					y > CLOSE_Y && y < CLOSE_Y + CLOSE_H) {
					overClose = 0;
					SE_Redraw();
					return;
				}
				break;
			case SDL_MOUSEMOTION:
				if(event.motion.x > PREV_X && event.motion.x < PREV_X + PREV_W &&
				   event.motion.y > PREV_Y && event.motion.y < PREV_Y + PREV_H) {
					if(!overPrev) {
						playSound(clickSound);
						overPrev = 1;
						drawText(PREV_X + 10, PREV_Y, "Prev", font2, overPrev);
					}
 
				}
				else if(event.motion.x > NEXT_X && event.motion.x < NEXT_X + NEXT_W &&
					event.motion.y > NEXT_Y && event.motion.y < NEXT_Y + NEXT_H) {
					if(!overNext) {
						playSound(clickSound);
						overNext = 1;
						drawText(NEXT_X + 10, NEXT_Y, "Next", font2, overNext);
					}

				}
				else if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
					event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(clickSound);
						overClose = 1;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", font2, overClose);
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", font2, overClose);
					}
					else if(overNext) {
						overNext = 0;
						drawText(NEXT_X + 10, NEXT_Y, "Next", font2, overNext);
					}
					else if(overPrev) {
						overPrev = 0;
						drawText(PREV_X + 10, PREV_Y, "Prev", font2, overNext);
					}
				}
				break;
			default:
				break;
			}
		}
	}
}

/*****************************************************
 ****************************************************/
Uint32 updateScore(Uint32 interval, void * param)
{
#ifdef __MORPHOS__
	struct scoreText * t;
#endif
	static char odd = 0;
	if((scoreAdd || scoreTexts) && !drawing) {
		odd = !odd;
		drawing = 1;
		/* draw the text scores */
#ifndef __MORPHOS__
		struct scoreText * t = scoreTexts;
#else
		t = scoreTexts;
#endif
		while(t && odd) {
			SE_Redraw();
			drawing = 0;
			drawText(t->x, t->y, t->str, font2, 2);
			drawing = 1;

			t->y -= 30;
			if(t->y < 200) {
				free(scoreTexts);
				scoreTexts = t = 0;
			}
			if(t)
				t = t->next;
		}
		if(scoreAdd) {
			SDL_Rect dest;
			dest.x = 20;
			dest.y = 320;
			dest.w = 180;
			dest.h = 80;
			
			if(scoreAdd > 10 * currentLevel) {
				scoreAdd -= 10 + (5 * currentLevel);
				score += 10 +(5 * currentLevel);
			}
			else {
				score += scoreAdd;
				scoreAdd = 0;
			}
			       
			SDL_BlitSurface(background, &dest, screen, &dest);
			drawNumber(score, 20, 320, "Score");
			SDL_UpdateRects(screen, 1, &dest);
		}
		drawing = 0;
		return interval;
	}
	return interval;
}




/*****************************************************
 ****************************************************/
void empty()
{
	if(!scoreTexts) {
		struct scoreText * t;
		t = (struct scoreText *)malloc(sizeof(struct scoreText));
		if(!t) {
			SE_Error("Out of Memory.");
			quit();
		}
		t->x = 350;
		t->y = 500;
		t->next = 0;
		t->prev = 0;
		strcpy(t->str, "BONUS !\0");
		scoreTexts = t;
	}

	playSound(bonusSound);
	scoreAdd += 300 * currentLevel;
}

/*****************************************************
 ****************************************************/
void SE_Redraw()
{
	int x, y;
	SDL_Rect dest;
	char str[16];
	drawing = 1;
	stateChanged = 0;

	SDL_BlitSurface(background, 0, screen, 0);
	
	SE_ShowSoundIcon();

	for(x = 0; x < xBSize; x++) {
		for(y = 0; y < yBSize; y++) {
			if(board[y][x]) {
				dest.x = board[y][x]->x;
				dest.y = board[y][x]->y;
				SDL_BlitSurface(board[y][x]->tile, 0, screen, &dest);
			}
		}
	}

	if(levelEnd) {
		char str[32];
		sprintf(str, "Level %d Completed.", currentLevel);
		drawText(-1, 250, str, font2, 2);
		if(levelEnd == 1) {
			SDL_UpdateRect(screen, 0, 0, 0, 0);
			SDL_Delay(750);
		}

		sprintf(str, "%d rows empty", emptyLevels);
		drawText(-1, 300, str, font2, 2);
		if(levelEnd == 1) {
			SDL_UpdateRect(screen, 0, 0, 0, 0);
			SDL_Delay(750);
		}

		sprintf(str, "Bonus of %d", emptyLevels * level * 100);
		drawText(-1, 350, str, font2, 2);
	if(levelEnd == 1) {
			score += emptyLevels * level * 100;
			SDL_UpdateRect(screen, 0, 0, 0, 0);
			SDL_Delay(1000);
		}

		if(remaining == 1)
			sprintf(str, "1 tile remained");
		else if(remaining == 0)
			sprintf(str, "Clean Sweep of Tiles");
		else
			sprintf(str, "%d tiles remained", remaining);
		drawText(-1, 400, str, font2, 2);
		if(levelEnd == 1) {
			SDL_UpdateRect(screen, 0, 0, 0, 0);
			SDL_Delay(750);
		}
		levelEnd = 2;
	}

	//Draw Current Level
	drawNumber(currentLevel, 20, 220, "Level");
	
	//Draw score
	drawNumber(score, 20, 320, "Score");
	
	// Draw Remaing rows
	drawNumber(LEVELSIZE - level, 20, 420, "Rows left");

	// Quit button
	drawText(QUIT_X, QUIT_Y, "Quit", font, overQuit);
	
	if(!running) {
		// Start Button
		drawText(START_X, START_Y, "Start", font, overStart);

		// Help button
		drawText(HELP_X, HELP_Y, "Help", font, overHelp);
	}
	showIcon();

	if(gameOver)
		drawText(-1, 300, "Game Over", font2, 2);

	SDL_UpdateRect(screen, 0, 0, 0, 0);
	drawing = 0;
}

/*****************************************************
 ****************************************************/
int clickBomb(enum Color color, enum Color bombColor)
{
#ifdef __MORPHOS__
	int c, x, y;
#endif
	playSound(bombClickSound);
	isBomb = 1;
#ifndef __MORPHOS__
	int c = 0, x, y;
#else
	c = 0;
#endif
	for(y = 0; y < yBSize; y++) {
		for(x = 0; x < xBSize; x++) {
			if(board[y][x] && (board[y][x]->color == color ||
					   board[y][x]->color == bombColor)) {
				deletions[del].x = x; 
				deletions[del].y = y;
				del++;
				c++;
			}
		}
	}

	return c;
}

/*****************************************************
 ****************************************************/
int rec_clicked(const int y, const int x, const enum Color orig, const enum Color origbomb)
{
	int count = 0;

	/* Check if going off the edge of the board */
	if(x < 0 || x >= xBSize || y < 0 || y >= yBSize) {
		return count;
	}

	/* Check if the piece if valid, i.e. not null */
	if(board[y][x] == NULL || board[y][x]->checked) {
		return count;
	}

	/* Check if the piece is the same color as the original */
	if(board[y][x]->color == orig || board[y][x]->color == origbomb) {
		deletions[del].x = x; 
		deletions[del].y = y;
		del++;

		board[y][x]->checked = 1;

		count++;                               

		count += rec_clicked(y - 1, x,     orig, origbomb);  // Recursively call for the for sides,
		count += rec_clicked(y + 1, x,     orig, origbomb);  // angles are not done
		count += rec_clicked(y,     x - 1, orig, origbomb);
		count += rec_clicked(y,     x + 1, orig, origbomb);
	}

	return count;
}

/*****************************************************
 ****************************************************/
void slide_over()
{
	int x, y, i;
	for(x = 0; x < xBSize - 1; x++) {
		if(board[0][x] == NULL) {
			int _x;
			for(_x = x + 1; _x < xBSize; _x++) {
				if(board[0][_x])
					break;
			}
			
			if(_x >= xBSize)  
				continue;
			
			for(y = 0; y < yBSize; y++) { // for each tile in column, move over
				if(board[y][_x])
					board[y][_x]->x -= ((_x-x) * ICON_SIZE);

				board[y][x]  = board[y][_x];
				board[y][_x] = NULL;
			}
		}
	}
}


/*****************************************************
 ****************************************************/
void drop_down()
{
	int x, y, i;
	for(y = 0; y < yBSize; y++) {
		for(x = 0; x < xBSize; x++) {
			if(board[y][x] == NULL) {
				int _y;
				for(_y = y + 1; _y < yBSize; _y++) {
					if(board[_y][x])
						break;
				}

				if(_y >= yBSize)  
					continue;

				for(i = 0; i < _y - y; i++)
					board[_y][x]->y += ICON_SIZE;

				board[y][x]  = board[_y][x];
				board[_y][x] = NULL;
			}
		}
	}
}



/*****************************************************
 ****************************************************/
int clicked(const int y, const int x)
{
	if(!running || !board[y][x])
		return 0;

	del = 0;

	if(board[y][x]->color == BLANK)
		return 0;
	else if(board[y][x]->color == RED_BOMB)
		return clickBomb(RED, RED_BOMB);
	else if(board[y][x]->color == GREEN_BOMB)
		return clickBomb(GREEN, GREEN_BOMB);
	else if(board[y][x]->color == BLUE_BOMB)
		return clickBomb(BLUE, BLUE_BOMB);
	else if(board[y][x]->color == GOLD_BOMB)
		return clickBomb(GOLD, GOLD_BOMB);
	else if(board[y][x]->color == PURPLE_BOMB)
		return clickBomb(PURPLE, PURPLE_BOMB);
	else
		return rec_clicked(y, x, board[y][x]->color, board[y][x]->color + 1);
}

/*****************************************************
 ****************************************************/
void tileClick(const int x, const int y) 
{
	int i = clicked(y, x);

	if(i > 2 || isBomb) {
		playSound(clickSound);
		if(isBomb)
			jiggleBoard();
		isBomb = 0;


		scoreAdd += i * currentLevel * 10;
		tileCount -= i;
		if(tileCount == 0)
			empty();

		while (i--){
			SDL_Rect dest;
			dest.x = TOP_X + (deletions[i].x * 32);
			dest.y = TOP_Y + (deletions[i].y * 32);
			dest.w = dest.h = 32;

			drawing = 1;
			SDL_BlitSurface(background, &dest, screen, &dest);
			SDL_UpdateRects(screen, 1, &dest);
			drawing = 0;

			// FADE HERE
			free(board[deletions[i].y][deletions[i].x]);
			board[deletions[i].y][deletions[i].x] = NULL;
		}

		// If tiles were taken then drop them down first and slide over if needed
		drop_down();  // Despite timer do this, becasue timer events time will change by level
		slide_over(); // and therefore will not update until that levels timer goes off

		stateChanged = 1;
		del = 0;
	}
	else {
		int x, y;
		for(y = 0; y < yBSize; y++)
			for(x = 0; x < xBSize; x++)
				if(board[y][x])
					board[y][x]->checked = 0;

	}
}

/*****************************************************
 ****************************************************/
inline void SE_CheckEvents()
{
	SDL_Event event;
	int x, y;

	if(stateChanged)
		SE_Redraw();

	if(SDL_PollEvent(&event)) {
		struct SE_Button * head;
		switch (event.type) {
		case SDL_QUIT:
			quit();
			break;
		case SDL_KEYDOWN:
			switch(event.key.keysym.sym) {
			case SDLK_q:
				quit();
				break;
			case SDLK_f:
				SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
				break;
			default:
				break;
			}
			break;
		case SDL_MOUSEBUTTONDOWN:
			x = event.button.x;
			y = event.button.y;

			for(head = se_buttonList; head; head = head->next) {
				if(x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					playSound(clickSound);
					head->handle();
					return;
				}
			}

			if(!running && y > ICON_Y && x < ICON_W) {
				logoClicked();
			}
			else if(x > SOUND_X && x < SOUND_X + ICON_SIZE &&
				y > SOUND_Y && y < SOUND_Y + ICON_SIZE) {
				playSound(clickSound);
				SE_AdjustSoundLevel();
				stateChanged = 1;
			}

			else if(running && x > BOTTOM_X  && x < BOTTOM_X + BOARD_SIZE &&
				y > BOTTOM_Y - BOARD_SIZE + ICON_SIZE && y < BOTTOM_Y + ICON_SIZE) {
				int x1, y1;
				x1 = ((x - BOTTOM_X) / ICON_SIZE);
				y1 = (BOTTOM_Y + ICON_SIZE - y) / ICON_SIZE;
				tileClick(x1, y1);
				
			}
			break;
		case SDL_MOUSEMOTION:
			x = event.motion.x;
			y = event.motion.y;

			for(head = se_buttonList; head; head = head->next) {
				if(!(*head->cond) && x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					if(head->over == 0) {
						SDL_SetCursor(getHandCursor());
						playSound(overSound);
						head->over = 1;
						drawText(head->x, head->y, head->name, font, head->over);
					}
					return;

				}
			}
		
			for(head = se_buttonList; head; head = head->next) {
				if(head->over == 1) {
					SDL_SetCursor(getArrowCursor());
					head->over = 0;
					if(!(*head->cond))
					   drawText(head->x, head->y, head->name, font, head->over);
					return;
				}
			}
			
			if(x > SOUND_X-5 && x < SOUND_X + ICON_SIZE - 15 &&
				y > SOUND_Y-2 && y < SOUND_Y + ICON_SIZE - 15) {
				SDL_SetCursor(getHandCursor());
			}

			else if(!running && y > ICON_Y && x < ICON_W)
				SDL_SetCursor(getHandCursor());
			else
				SDL_SetCursor(getArrowCursor());
			break;

		}
	}
}


/*****************************************************
 ****************************************************/
int main(int argc, char * argv[])
{
	SE_SetName("Torrent 0.8.2");
	SE_SetBackground("pics/main.png");
	SOUND_X = 770;
	SOUND_Y = 10;

	if(SE_Init() != 0)
		SE_Quit();

	SDL_InitSubSystem(SDL_INIT_TIMER);

	font  = loadFont("fonts/amerdreams.ttf", 80);
	font2 = loadFont("fonts/amerdreams.ttf", 50);
	font3 = loadFont("fonts/amerdreams.ttf", 32);

	blueTile       = loadPNG("pics/set1/blue.png");
	redTile        = loadPNG("pics/set1/red.png");
	greenTile      = loadPNG("pics/set1/green.png");
	purpleTile     = loadPNG("pics/set1/purple.png");
	goldTile       = loadPNG("pics/set1/gold.png");

	blueBombTile   = loadPNG("pics/set1/blue_bomb.png");
	redBombTile    = loadPNG("pics/set1/red_bomb.png");
	greenBombTile  = loadPNG("pics/set1/green_bomb.png");
	purpleBombTile = loadPNG("pics/set1/purple_bomb.png");
	goldBombTile   = loadPNG("pics/set1/gold_bomb.png");

	blankTile      = loadPNG("pics/set1/blank.png");

	mask = SDL_CreateRGBSurface (SDL_SWSURFACE, 
				     background->w, 
				     background->h, 
				     background->format->BitsPerPixel, 
				     background->format->Rmask, 
				     background->format->Gmask, 
				     background->format->Bmask, 
				     background->format->Amask);
	SDL_FillRect(mask, 0, 0);


	gameOverSound  = loadSound("sounds/gameover.ogg");
	clickSound     = loadSound("sounds/click.ogg");
	bombClickSound = loadSound("sounds/bomb.ogg");
	bonusSound     = loadSound("sounds/bonus.ogg");
	levelOverSound = loadSound("sounds/levelover.ogg");
	overSound      = loadSound("sounds/over.ogg");

	SE_RegisterButton("Help",  HELP_X,  HELP_Y,  HELP_W,  HELP_H,  &running, help);
	SE_RegisterButton("Start", START_X, START_Y, START_W, START_H, &running, start);
	SE_RegisterButton("Quit",  QUIT_X,  QUIT_Y,  QUIT_W,  QUIT_H,  &se_true, quit);

	stateChanged = 1;
	newGame      = 1;
	running      = 0;

	
	if(!SDL_AddTimer(40, updateScore, 0)) {
		SE_Error("Score timer failed to start.");
		quit();
	}

	fprintf(stdout, "Initialization Complete. Starting game.\n");

	SE_GameLoop();

	SE_Quit();
}

