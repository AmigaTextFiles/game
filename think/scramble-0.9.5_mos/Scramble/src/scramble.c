/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: scramble.c
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


#include <string.h>
#include <stdio.h>
#include <time.h>

#include "ShiftyEngine.h"

#ifdef __MORPHOS__
//ULONG __stack = 32768UL;
const char *version_tag = "$VER: scramble 0.9.5 (2005-04-07)";
#endif

/* Forward references */
void timeOver();
void drawClock();

/* external references */
extern void initDictonary(char * letters);
extern char * currentWordSet[500];
extern int numberCurrentWords;

/* Locations of things */
#define ICON_SIZE  32
#define QUIT_X     710
#define QUIT_Y     560
#define SUBMIT_X   350
#define SUBMIT_Y   525
#define HELP_X     710
#define HELP_Y     QUIT_Y - 40
#define LAST_X     210
#define LAST_Y     560
#define BACK_X     LAST_X + 85
#define BACK_Y     560
#define START_X    340
#define START_Y    330
#define SHUFFLE_X  BACK_X + 85
#define SHUFFLE_Y  BACK_Y
#define CLEAR_X    SHUFFLE_X + 120
#define CLEAR_Y    SHUFFLE_Y
#define HELP_LINES 9
#define CLOSE_X    350
#define CLOSE_Y    530
#define CLOSE_W    90
#define CLOSE_H    40
#define PREV_X     200
#define PREV_Y     CLOSE_Y
#define PREV_W     90
#define PREV_H     40
#define NEXT_X     500
#define NEXT_Y     CLOSE_Y
#define NEXT_W     90
#define NEXT_H     40
#define LEVEL_X    530
#define LEVEL_Y    260
#define SCORE_X    LEVEL_X-60
#define SCORE_Y    (LEVEL_Y + 65)
#define HIGHSCORE_X 20
#define HIGHSCORE_Y 260
#define LEFT_X     720
#define LEFT_Y     240
#define RIGHT_X     (LEFT_X + 30)
#define RIGHT_Y     LEFT_Y
#define LEFT_W     30
#define LEFT_H     LEFT_W
#define RIGHT_W     LEFT_W
#define RIGHT_H     LEFT_W

/* Fonts */
TTF_Font * font  = 0;
TTF_Font * font2 = 0;
TTF_Font * font3 = 0;

/* Various Surfaces */
SDL_Surface * littleBox = 0;
SDL_Surface * logo      = 0;
SDL_Surface * text      = 0;

/* Colors */
SDL_Color green     = {0,  160,  0,  255};
//SDL_Color green     = {10,  130,  30,  255};
SDL_Color white     = {255, 255,  255, 255};
SDL_Color darkGreen = {30,  80,   30,  255};
SDL_Color blue      = {156, 236,  255, 255};
SDL_Color red       = {255, 0,    0,   255};

/* Sound Storage */
Mix_Chunk * clickSound     = 0;
Mix_Chunk * overSound      = 0;
Mix_Chunk * shuffleSound   = 0;
Mix_Chunk * hitSound       = 0;
Mix_Chunk * missSound      = 0;
Mix_Chunk * tickSound      = 0;
Mix_Chunk * countdownSound = 0;
Mix_Chunk * warningSound   = 0;

/* Variables */
char lastWord[6];
int  lastSlot[6];
int  lastWordCount = 0;
int  currentLetter = 0;
int  stateChanged  = 0;
int  xFudge        = 0;
int  redrawAll     = 0;
int  timeStart     = 0;
int  myclock       = 0;
int  totalTime     = 0;
int  running       = 0;
int  notrunning    = 1;
int  wordsFound    = 0;
int  nextLevel     = 0;
int  score         = 0;
int  currentLevel  = 0;
int  overClose     = 0;
int  overPrev      = 0;
int  overNext      = 0;
int  offset        = 0;
int  scroll        = 0;
double percentage  = 0.4;

char wordAttempt[6];
char dictionary[512];
char currentWordSetShow[500]; //list of all the words that can be made from these 6 letters

struct {
	char name[16];
	unsigned long score; 
	unsigned long level;
} highscore[10];
char * scorepath;
char * home;
char file[] = "/.scramble";
char usersname[16];

struct {
	int ox, x1, x2, dx;
	int oy, y1, y2, dy;
	int moving, count, played;
	char letter[2];
} letters[6];

char * helpText[] = {
	"Objective:", 
	" You must find as many of the words as possible. For",
	"each word found you recieve 100 points. Additionally",
	"a bonus is recieved for completing each level. There",
	"are two ways to complete a level. First, by finding",
	"a six letter word, or secondly by finding",
	"percentage of the words for that level. The",   
	"percentage starts at 40% and increases by 10% every",   
	"5 levels to maximum of 80%.",   
	" ",   
	"Dictionary:",
	" The default dictionary is the GNU dictionary.",
	"However, this dictionary is not very complete.",
	"You can pass a -d flag when starting Scramble to",
	"use an alternate dictionary. The current limit",
	"is 512 characters for the pathname. To load you",
	"can us:",
	"scramble -d myDict.txt",
	"fill in myDict.txt with the pathname of your ",
	"dictionary of choice.",
	" ",
	"Volume:",
	"  To adjust the sound volume click on the speaker",
	"icon in the middle right of the screen to toggle",
	"between the high, low and off settings. Or you may",
	"use the hot key.",
	" ",
	"Hotkeys:",
	"F1 - Help",
	"F2 - Toggle fullscreen mode",
	"F7 - Start level",
	"F12 - Quit",
	"TAB - Replace last word",
	"SPACE - Shuffle letters",
	"BACKSPACE - Put back last letter",
	"RETURN - Submit word",
	"ESC - Clear current word",
	"[a-z] - Select letter to add to word"
};


/*****************************************************
 ****************************************************/
void saveScores()
{
	int i;
	FILE * out = fopen(scorepath, "w");
	if(out == 0)
		return;

	for(i = 0; i < 10; i++)
		fprintf(out, "%s %d %d\n", highscore[i].name, highscore[i].level, highscore[i].score);

	fclose(out);
}

/*****************************************************
 ****************************************************/
void loadScores()
{
	
	int i;
	FILE * in = fopen(scorepath, "r");
	if(in == 0)
		return;
	for(i = 0; i < 10; i++) {
		if(feof(in)) return;
		fscanf(in, "%s\n", &highscore[i].name);
		if(feof(in)) return;
		fscanf(in, "%d\n", &highscore[i].level);
		if(feof(in)) return;
		fscanf(in, "%d\n", &highscore[i].score);
		if(feof(in)) return;
	}
	fclose(in);

}


/*****************************************************
 ****************************************************/
void drawText(int x, int y, char * str, int over)
{
	SDL_Rect dest;
	
	if(strlen(str) == 0)
		return;

	if(over) {
		text   = TTF_RenderText_Blended(font, str, white);
		dest.x = x + 2; dest.y = y + 2;
		dest.w = text->w; dest.h = text->h;
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
	} 
	else {
		text   = TTF_RenderText_Blended(font, str, darkGreen);
		dest.x = x + 2; dest.y = y + 2;
		dest.w = text->w; dest.h = text->h;
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
	}

	text   = TTF_RenderText_Blended(font, str, green);
	dest.x = x; 
	dest.y = y;
	dest.w = text->w + 2; 
	dest.h = text->h + 2;

	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_UpdateRect(screen, x, y, text->w + 2, text->h + 2);
	SDL_FreeSurface(text);
}

/*****************************************************
 ****************************************************/
void wordBox(int x, int y, int c)
{
	SDL_Rect dest;
	int i;

	dest.y = y;
	for(i = 0; i < c; i++) {
		dest.x = x + (22 * i) - offset;
		SDL_BlitSurface(littleBox, 0, screen, &dest);
	}
}

/*****************************************************
 ****************************************************/
void putLetter(char * ch, int s)
{
	char ch2[2];
	SDL_Rect dest;

	if(!running)
		return;

	ch2[0] = toupper(ch[0]);
	ch2[1] = 0;


	s--;
	
	if(letters[s].moving) {
		letters[s].count++;
		letters[s].x1 = letters[s].x1 + letters[s].dx;
		letters[s].y1 = letters[s].y1 + letters[s].dy;

		if((letters[s].x1 == letters[s].x2 && 
		    letters[s].y1 == letters[s].y2) || letters[s].count == 5 ) {
			letters[s].moving = 0;
			letters[s].count  = 0;
			letters[s].x1 = letters[s].x2;
			letters[s].y1 = letters[s].y2;
		}
		stateChanged = 1; //needs to draw again
	}

	text = TTF_RenderText_Blended(font2, ch2, darkGreen);
	dest.x = letters[s].x1+3; dest.y = letters[s].y1+3; //+3 is shadow offset
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	text = TTF_RenderText_Blended(font2, ch2, green);
	dest.x =letters[s].x1; dest.y = letters[s].y1;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);
}

/*****************************************************
 ****************************************************/
void back()
{
	int i;
	int minx, maxx, miny, maxy, advance;

	if(!currentLetter) 
		return;

	currentLetter--;

	i = lastSlot[currentLetter];

	wordAttempt[currentLetter] = 0;

	letters[i].y2     = letters[i].oy;
	letters[i].x2     = letters[i].ox;
	letters[i].dx     = (letters[i].x2-letters[i].x1)/5;
	letters[i].dy     = (letters[i].y2-letters[i].y1)/5;
	letters[i].moving = 1;
	letters[i].played = 0;
	stateChanged      = 1;

	TTF_GlyphMetrics(font2,letters[i].letter[0], &minx, &maxx, &miny, &maxy, &advance);
	xFudge -= advance+10;  
}



/*****************************************************
 ****************************************************/
void clear()
{
	while(currentLetter)
		back();
}


/*****************************************************
 ****************************************************/
void SE_Redraw()
{
	static SDL_Rect dest;
	static int i, j, x, y, k;
	struct SE_Button * head;
	char str[256];

	stateChanged = 0;
	
	SDL_BlitSurface(background, 0, screen, 0);

	SE_ShowSoundIcon();

	/* Draw score and level */
	sprintf(str, "Level: %d", currentLevel);
	drawText(LEVEL_X, LEVEL_Y, str, 1);
	sprintf(str, "Score: %d", score);
	drawText(SCORE_X, SCORE_Y, str, 1);	

	if(nextLevel)
		drawText(120, 1, "You may progress to the next level!", 1);

	/* Draw the letters */
	for(i = 1; i < 7; i++)
		putLetter(letters[i-1].letter, i);

	/* Draw the buttons */

	if(!running) {
		drawText(START_X, START_Y, "Start", 0);
		drawText(HELP_X,  HELP_Y,  "Help",  0);
		drawText(HIGHSCORE_X,  HIGHSCORE_Y, "Highscores", 0);
	}

	drawText(SHUFFLE_X,    SHUFFLE_Y,   "Shuffle",    0);
	drawText(BACK_X,       BACK_Y,      "Back",       0);
	drawText(LAST_X,       LAST_Y,      "Last",       0);
	drawText(SUBMIT_X,     SUBMIT_Y,    "Submit",     0);
	drawText(CLEAR_X,      CLEAR_Y,     "Clear",      0);

	drawText(QUIT_X,       QUIT_Y,      "Quit",       0);

	/* Draw Word boxes */
	x =  30; y = 20, j = 0;
	for(i = 0; i < numberCurrentWords; i++) {
		if( (i % 9) == 0 && i != 0) {
			x += (strlen(currentWordSet[i]) + 1) * 22;
			j = 0;
		}
		j++; //j == the row
			
		wordBox(x, y + (j * 22), strlen(currentWordSet[i])); 
		if(currentWordSetShow[i]) {
			/* Display to found words */
			for(k = 0; k < strlen(currentWordSet[i]); k++) {
				char str[2];
				str[0] = currentWordSet[i][k];
				str[1] = 0;
				if(currentWordSetShow[i] == 1)
					text = TTF_RenderText_Blended(font3, str, darkGreen);
				else
					text = TTF_RenderText_Blended(font3, str, red);
				dest.x = x + 5 + (k * 22) - offset; 
				dest.y = (y + 2 + (j * 22))-4;
				SDL_BlitSurface(text, 0, screen, &dest);
				SDL_FreeSurface(text);
			}
		}

		if(numberCurrentWords > 54) {
			text = TTF_RenderText_Blended(font3, "<", darkGreen);
			dest.x = LEFT_X;
			dest.y = LEFT_Y;
			SDL_BlitSurface(text, 0, screen, &dest);
			SDL_FreeSurface(text);
			text = TTF_RenderText_Blended(font3, ">", darkGreen);
			dest.x = RIGHT_X;
			dest.y = RIGHT_Y;
			SDL_BlitSurface(text, 0, screen, &dest);
			SDL_FreeSurface(text);
			scroll = 1;
		}
		else
			scroll = 0;
	}
	
	showIcon();

	if(running)
		drawClock();

	SDL_UpdateRect(screen, 0, 0, 0, 0);
}

/*****************************************************
 ****************************************************/
void drawClock()
{
	SDL_Rect dest;
	int x = 10, y = 260;
	char str[16];

	sprintf(str, "%d", myclock);
	
	/* Clear area */
	dest.x = x; 
	dest.y = y;
	dest.h = 80;
	dest.w = 110;
	SDL_BlitSurface(background, &dest, screen, &dest);
	SDL_UpdateRects(screen, 1, &dest);

	/* Back color */
	text   = TTF_RenderText_Blended(font2, str, darkGreen);
	dest.x = x + 2; 
	dest.y = y + 2;
	dest.w = text->w; 
	dest.h = text->h;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	/* Front color */
	text   = TTF_RenderText_Blended(font2, str, blue);
	dest.x = x; 
	dest.y = y;
	dest.w = text->w + 2; 
	dest.h = text->h + 2;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	SDL_UpdateRect(screen, x, y, text->w + 10, text->h + 2);
}

/*****************************************************
 ****************************************************/
void updateClock()
{
        int temp = time(0) - timeStart;

        if(myclock == (totalTime - temp))
                return;

        myclock = totalTime - temp;
        drawClock();

	if(myclock < 30)
		playSound(tickSound);

	if(myclock <= 0) {
		running = 0; 
		notrunning = 1; 
		timeOver();
		return;
	}
	
	if(myclock < 10)
		if(myclock % 3 == 0)
			playSound(countdownSound);

	if(myclock == 10)
		playSound(warningSound);

}

/*****************************************************
 ****************************************************/
int moveLetter(int i)
{
	int minx, maxx, miny, maxy, advance;
	i--;

	if(letters[i].played)
		return;

	wordAttempt[currentLetter] = letters[i].letter[0];
	lastSlot[currentLetter] = i;
	currentLetter++;

	letters[i].y2     = 250;
	letters[i].x2     = 250 + xFudge;
	letters[i].dx     = (letters[i].x2-letters[i].x1)/5;
	letters[i].dy     = (letters[i].y2-letters[i].y1)/5;
	letters[i].moving = 1;
	letters[i].played = 1;
	
	TTF_GlyphMetrics(font2,letters[i].letter[0], &minx, &maxx, &miny, &maxy, &advance);

	xFudge += advance+10; 
	stateChanged = 1;
	redrawAll    = 0;
}

/*****************************************************
 ****************************************************/
void start()
{
	int i;
	char scratch[6];
	if(running)
		return;
	
	getWord(scratch);
	for(i = 0; i < 500; i++)
		currentWordSetShow[i] = 0;

	offset = 0;
	myclock = 0;
	timeStart = time(0);
	wordsFound = 0;
	if(nextLevel) {
		nextLevel = 0;
	} else {
		/* new game */
		score = 0;
		currentLevel = 0;
	}
	currentLevel++;

	/* set time based on number of words to find */
	if(numberCurrentWords > 20)
		totalTime = 180;
	else if(numberCurrentWords > 15)
		totalTime = 120;
	else
		totalTime = 90;

	
	clear();

	// move letters from scratch into letters array
	letters[0].letter[0] = scratch[0];
	letters[1].letter[0] = scratch[1];
	letters[2].letter[0] = scratch[2];
	letters[3].letter[0] = scratch[3];
	letters[4].letter[0] = scratch[4];
	letters[5].letter[0] = scratch[5];

	for(i = 0; i < 6; i++) {
		letters[i].count  = 0;
		letters[i].moving = 0;
	}

	running      = 1; 
	notrunning   = 0; 
	stateChanged = 1;
}

/*****************************************************
 ****************************************************/
void shuffle()
{
	int i, a, b;
	char ch;

	if(!running || currentLetter == 6)
		return;

	for(i = 0; i < rand()%50; i++) {
		do { a = rand() % 6; } while( letters[a].played );
		do { b = rand() % 6; } while( letters[b].played );

		ch = letters[a].letter[0];
		letters[a].letter[0] = letters[b].letter[0];
		letters[b].letter[0] = ch;
		
		letters[a].x1 = letters[b].ox;
		letters[a].y1 = letters[b].oy;
		letters[a].x2 = letters[a].ox;
		letters[a].y2 = letters[a].oy;
		letters[a].dx = (letters[a].x2-letters[a].x1) / 5;
		letters[a].dy = (letters[a].y2-letters[a].y1) / 5;
		letters[a].moving = 1;

		letters[b].x1 = letters[a].ox;
		letters[b].y1 = letters[a].oy;
		letters[b].x2 = letters[b].ox;
		letters[b].y2 = letters[b].oy;
		letters[b].dx = (letters[b].x2-letters[b].x1) / 5;
		letters[b].dy = (letters[b].y2-letters[b].y1) / 5;
		letters[b].moving = 1;
	}

	playSound(shuffleSound);	

	stateChanged = 1;
}

/*****************************************************
 ****************************************************/
void last()
{
	int i, j;

	if(!running)
		return;

	clear();

	for(i = 0; i < lastWordCount; i++) {
		for(j = 0; j < 6; j++) {
			if((letters[j].letter[0] == lastWord[i]) && !letters[j].played) {
				moveLetter(j+1);
				break;
			}
		}
	}

	strncpy(wordAttempt, lastWord, 6);
	currentLetter = lastWordCount;
}

/*****************************************************
 ****************************************************/
void submit()
{
	int i;
	double per;

	if(!running)
		return;

	memset(lastWord, 6, 0);
	strncpy(lastWord, wordAttempt, 6);
	lastWordCount = currentLetter;

	for(i = 0; i < numberCurrentWords; i++) {
		if(strcmp(wordAttempt, currentWordSet[i]) == 0 && currentWordSetShow[i] == 0) {
			currentWordSetShow[i] = 1;
			playSound(hitSound);	

			if(currentLetter == 6)
				nextLevel = 1;

			score += (currentLevel * 15) + (currentLetter * 10);

			clear();
			stateChanged = 1;
			redrawAll = 1;
			wordsFound++;
			per = ((double)wordsFound / (double)numberCurrentWords);
			if(per > percentage) {
				nextLevel = 1;
				if(nextLevel % 5 && percentage < .8)
					percentage += .1;
			}

			else if(per == 1.0) {
				myclock = 0;
				nextLevel = 1;
			}

			SE_Redraw();
			memset(lastWord, 6, 0);
			return;
		}
	}

	playSound(missSound);
	clear();	
	memset(lastWord, 6, 0);
}

/*****************************************************
 ****************************************************/
static void quit()
{
	saveScores();
	SE_Quit();
}

/*****************************************************
 ****************************************************/
void help()
{
	SDL_Event event;
	SDL_Rect src;

	unsigned int i, j = 0, x = 20, y = 60, change = 1;

	if(running)
		return;

	while(1) {
		if(change) {
			y = 60;
			
			if(SDL_BlitSurface(background, 0, screen, 0) != 0)
				SE_Error("A blit failed.");

			for(i = 0; i < HELP_LINES; i++)
				drawText(x, y + (i * 50), helpText[i + j], 1);
			
			drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
			drawText(PREV_X + 10,  PREV_Y,  "Prev",  overPrev);
			drawText(NEXT_X + 10,  NEXT_Y,  "Next",  overNext);

			SDL_UpdateRect(screen, 0, 0, 0, 0);
			change = 0;
		}

		if(SDL_PollEvent(&event)) {
			int x, y;
			switch(event.type) {
			case SDL_KEYDOWN:
				switch(event.key.keysym.sym) {
				case SDLK_F12:
					quit();
					break;
				case SDLK_F2:
					SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
					break;
#ifdef __MORPHOS__
				default:
					break;
#endif
				}
				break;
			case SDL_QUIT:
				quit();
				break;
			case SDL_MOUSEBUTTONDOWN:
				x = event.button.x;
				y = event.button.y;
				if(x > CLOSE_X && x < CLOSE_X + CLOSE_W &&
				   y > CLOSE_Y && y < CLOSE_Y + CLOSE_H) {
					overClose = 0;
					return;
				}
				else if(x > PREV_X && x < PREV_X + PREV_W &&
					y > PREV_Y && y < PREV_Y + PREV_H) {
					if(j == 0) break;
					j--;
					change = 1;
				}
				else if(x > NEXT_X && x < NEXT_X + NEXT_W &&
					y > NEXT_Y && y < NEXT_Y + NEXT_H) {
					j++;
					change = 1;
					if(j > sizeof(helpText) / sizeof(helpText[1]) - HELP_LINES) 
						j = sizeof(helpText) / sizeof(helpText[1]) - HELP_LINES;
					
				}
				break;
			case SDL_MOUSEMOTION:
				SDL_ShowCursor(1);
				if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
				   event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(overSound);
						overClose    = 1;
						stateChanged = 1;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
				}
				else if(event.motion.x > PREV_X && event.motion.x < PREV_X + PREV_W &&
					event.motion.y > PREV_Y && event.motion.y < PREV_Y + PREV_H) {
					if(!overPrev) {
						overPrev     = 1;
						stateChanged = 1;
						playSound(overSound);
						drawText(PREV_X + 10, PREV_Y, "Prev", overPrev);
					}
				}
				else if(event.motion.x > NEXT_X && event.motion.x < NEXT_X + NEXT_W &&
					event.motion.y > NEXT_Y && event.motion.y < NEXT_Y + NEXT_H) {
					if(!overNext) {
						overNext     = 1;
						stateChanged = 1;
						playSound(overSound);
						drawText(NEXT_X + 10, NEXT_Y, "Next", overNext);
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
					else if(overPrev) {
						overPrev = 0;
						drawText(PREV_X + 10, PREV_Y, "Prev", overPrev);
					}
					else if(overNext) {
						overNext = 0;
						drawText(NEXT_X + 10, NEXT_Y, "Next", overNext);
					}
				}
				break;
			}
		}
	}
}

/*****************************************************
 ****************************************************/
void showHighscore()
{
	SDL_Event event;
	SDL_Rect src;

	unsigned int i, j = 0, x = 40, y = 50, change = 1;

	if(running)
		return;

	while(1) {
		if(change) {
			y = 60;
			
			if(SDL_BlitSurface(background, 0, screen, 0) != 0)
				SE_Error("A blit failed.");

			drawText(x, y - 40, "Name -- Level -- Score", 0);
			for(i = 0; i < 10; i++) {
				char str[256];
				sprintf(str, "%s -- %d -- %d", highscore[i].name, highscore[i].level, highscore[i].score);
				drawText(x+10, y + (i * 40), str, 1);
			}

			drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);

			SDL_UpdateRect(screen, 0, 0, 0, 0);
			change = 0;
		}

		if(SDL_PollEvent(&event)) {
			int x, y;
			switch(event.type) {
			case SDL_KEYDOWN:
				switch(event.key.keysym.sym) {
				case SDLK_F12:
					quit();
					break;
				case SDLK_F2:
					SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
					break;
#ifdef __MORPHOS__
				default:
					break;
#endif
				}
				break;
			case SDL_QUIT:
				quit();
				break;
			case SDL_MOUSEBUTTONDOWN:
				x = event.button.x;
				y = event.button.y;
				if(x > CLOSE_X && x < CLOSE_X + CLOSE_W &&
				   y > CLOSE_Y && y < CLOSE_Y + CLOSE_H) {
					overClose = 0;
					return;
				}
				break;
			case SDL_MOUSEMOTION:
				SDL_ShowCursor(1);
				if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
				   event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(overSound);
						overClose    = 1;
						stateChanged = 1;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
				}
				break;
			}
		}
	}
}

/*****************************************************
 ****************************************************/
void showAllWords()
{
	int i;

	for(i = 0; i < 500; i++)
		if(currentWordSetShow[i] == 0)
			currentWordSetShow[i] = 2;

	stateChanged = 1;
	redrawAll    = 1;

	SE_Redraw();
}

/*****************************************************
 ****************************************************/
void getUserName()
{
	SDL_Event event;
	SDL_Rect src;

	unsigned int i = 0, change = 1;

	if(running)
		return;

	while(1) {
		if(change) {
			if(SDL_BlitSurface(background, 0, screen, 0) != 0)
				SE_Error("A blit failed.");

			drawText(80, 70, "Enter name: (16 characters max)", 0);
			drawText(100, 120, usersname, 1);
			drawText(100, 150, "-------------------------------", 1);

			drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);

			SDL_UpdateRect(screen, 0, 0, 0, 0);
			change = 0;
		}

		if(SDL_PollEvent(&event)) {
			int x, y;
			switch(event.type) {
			case SDL_KEYDOWN:
				switch(event.key.keysym.sym) {
				case SDLK_a:
				case SDLK_b:
				case SDLK_c:
				case SDLK_d:
				case SDLK_e:
				case SDLK_f:
				case SDLK_g:
				case SDLK_h:
				case SDLK_i:
				case SDLK_j:
				case SDLK_k:
				case SDLK_l:
				case SDLK_m:
				case SDLK_n:
				case SDLK_o:
				case SDLK_p:
				case SDLK_q:
				case SDLK_r:
				case SDLK_s:
				case SDLK_t:
				case SDLK_u:
				case SDLK_v:
				case SDLK_w:
				case SDLK_x:
				case SDLK_y:
				case SDLK_z:
					if(i < 16) {
						usersname[i] = event.key.keysym.sym;
						i++;
						change = 1;
					}
					break;
				case SDLK_BACKSPACE:
					if(i > 0) {
						usersname[i] = ' ';
						i--;
						change = 1;
					}
					else if(i == 0) {
						usersname[i] = ' ';
						change = 1;
					}
					break;
				case SDLK_RETURN:
					stateChanged = 1;
					return;
					break;
#ifdef __MORPHOS__
				default:
					break;
#endif

				}
				break;
			case SDL_MOUSEBUTTONDOWN:
				x = event.button.x;
				y = event.button.y;
				if(x > CLOSE_X && x < CLOSE_X + CLOSE_W &&
				   y > CLOSE_Y && y < CLOSE_Y + CLOSE_H) {
					overClose = 0;
					stateChanged = 1;
					return;
				}
				break;
			case SDL_MOUSEMOTION:
				SDL_ShowCursor(1);
				if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
				   event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(overSound);
						overClose    = 1;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						drawText(CLOSE_X + 10, CLOSE_Y, "Close", overClose);
					}
				}
				break;
			}
		}
	}
}

/*****************************************************
 ****************************************************/
void timeOver()
{
	int i, scoreLevel = -1;

	showAllWords();

	if(nextLevel)
		score += (int)((double)(currentLevel * 1000) / ((double)wordsFound / (double)numberCurrentWords));
	else {
		SDL_Rect dest;
		int x = 200, y = 180;
	
		/* Back color */
		text   = TTF_RenderText_Blended(font2, "Game Over!", darkGreen);
		dest.x = x + 2; 
		dest.y = y + 2;
		dest.w = text->w; 
		dest.h = text->h;
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);

		/* Front color */
		text   = TTF_RenderText_Blended(font2, "Game Over!", blue);
		dest.x = x; 
		dest.y = y;
		dest.w = text->w + 2; 
		dest.h = text->h + 2;
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);

		SDL_UpdateRect(screen, x, y, text->w + 10, text->h + 2);

		/* Highscores are sorted by score, not by level */
		// Find score slot, if any
		for(i = 9; i >= 0; i--) 
			if(score >= highscore[i].score)
				scoreLevel = i;
		
		if(scoreLevel >= 0) {
			// move down other scores
			for(i = 8; i >= scoreLevel; i--)
				highscore[i+1] = highscore[i];
			
			getUserName();
			
			strncpy(highscore[scoreLevel].name, usersname, 16);
			highscore[scoreLevel].level = currentLevel;
			highscore[scoreLevel].score = score;
		}
		saveScores();
		
	}
	clear();
}


/*****************************************************
 ****************************************************/
void letter(char c)
{
	int i;
	if(!running)
		return;
	for(i = 0; i < 6; i++) {
		if(c == letters[i].letter[0] && !letters[i].played) {
			playSound(clickSound);
			moveLetter(i+1);
			return;
		}
	}
}

/*****************************************************
 ****************************************************/
inline void SE_CheckEvents()
{

	SDL_Event event;

	if(running)
		updateClock();

	if(stateChanged)
		SE_Redraw();

	if(stateChanged ? SDL_PollEvent( &event ) : SDL_WaitEvent(&event)) {
		struct SE_Button * head;
		register int x;
		register int y;

		switch (event.type) {
		case SDL_QUIT:
			exit(0);
			break;
		case SDL_KEYDOWN:
			switch(event.key.keysym.sym) {
			case SDLK_a:
			case SDLK_b:
			case SDLK_c:
			case SDLK_d:
			case SDLK_e:
			case SDLK_f:
			case SDLK_g:
			case SDLK_h:
			case SDLK_i:
			case SDLK_j:
			case SDLK_k:
			case SDLK_l:
			case SDLK_m:
			case SDLK_n:
			case SDLK_o:
			case SDLK_p:
			case SDLK_q:
			case SDLK_r:
			case SDLK_s:
			case SDLK_t:
			case SDLK_u:
			case SDLK_v:
			case SDLK_w:
			case SDLK_x:
			case SDLK_y:
			case SDLK_z:
				letter(event.key.keysym.sym);
				break;
			case SDLK_F2:
				SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
				break;
			case SDLK_F1:
				playSound(clickSound);
				help();
				break;
			case SDLK_TAB:
				playSound(clickSound);
				last();
				break;
			case SDLK_SPACE:
				playSound(clickSound);
				shuffle();
				break;
			case SDLK_F7:
				playSound(clickSound);
				start();
				break;
			case SDLK_F12:
				quit();
				break;
			case SDLK_BACKSPACE:
				playSound(clickSound);
				back();
				break;
			case SDLK_RETURN:
				playSound(clickSound);
				submit();
				break;
			case SDLK_ESCAPE:
				playSound(clickSound);
				clear();
				break;
			case SDLK_LEFT:
				if(scroll) {
					offset += 40;
					SE_Redraw();
				}
				break;
			case SDLK_RIGHT:
				if(scroll) {
					offset -= 40;
					if(offset < 0)
						offset = 0;
					SE_Redraw();
				}
				break;
#ifdef __MORPHOS__
			default:
				break;
#endif
			}
			break;
		case SDL_MOUSEBUTTONDOWN:
			x = event.button.x;
			y = event.button.y;

			for(head = se_buttonList; head; head = head->next) {
				if(x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					if(!*head->cond) {
						playSound(clickSound);
						head->handle();
						return;
					}
				}
			}

			if(!running && y > ICON_Y && x < ICON_W) {
				redrawAll = 1;
				logoClicked();
			}
			else if(x > SOUND_X && x < SOUND_X + ICON_SIZE &&
				y > SOUND_Y && y < SOUND_Y + ICON_SIZE) {
				playSound(clickSound);
				SE_AdjustSoundLevel();
				stateChanged = 1;
			}
			else if(x > LEFT_X && x < LEFT_X + LEFT_W &&
				y > LEFT_Y && y < LEFT_Y + LEFT_H) {
				if(scroll) {
					offset += 40;
					SE_Redraw();
				}
			}
			else if(x > RIGHT_X && x < RIGHT_X + RIGHT_W &&
				y > RIGHT_Y && y < RIGHT_Y + RIGHT_H) {
				if(scroll) {
					offset -= 40;
					if(offset < 0)
						offset = 0;
					SE_Redraw();
				}
			}
			

			// These are the 6 letters on the boards
			else if(x > 44 && x < 140 && y > 422 && y < 481) {
				playSound(clickSound);
				moveLetter(1);
			}
			else if(x > 183 && x < 268 && y > 385 && y < 437) {
				playSound(clickSound);
				moveLetter(2);
			}
			else if(x > 300 && x < 399 && y > 419 && y < 477) {
				playSound(clickSound);
				moveLetter(3);
			}
			else if(x > 435 && x < 521 && y > 398 && y < 453) {
				playSound(clickSound);
				moveLetter(4);
			}
			else if(x > 551 && x < 651 && y > 447 && y < 502) {
				playSound(clickSound);
				moveLetter(5);
			}
			else if(x > 674 && x < 765 && y >  397 && y < 457) {
				playSound(clickSound);
				moveLetter(6);
			}
			break;
		case SDL_MOUSEMOTION:
			x = event.motion.x;
			y = event.motion.y;

			if(x > SOUND_X-5 && x < SOUND_X + ICON_SIZE - 15 &&
				y > SOUND_Y-2 && y < SOUND_Y + ICON_SIZE - 15) {
				SDL_SetCursor(getHandCursor());
				break;
			}
			
			// for going over a button
			for(head = se_buttonList; head; head = head->next) {
				if(x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					if(head->over == 0) {
						head->over = 1;
						if(running && (!strncmp("Start", head->name, 5) || 
							       !strncmp("Highscores", head->name, 10) || 
							       !strncmp("Help", head->name, 4)))
						   return;
						playSound(overSound);
						SDL_SetCursor(getHandCursor());
						drawText(head->x, head->y, head->name, head->over);
					}
					return;

				}
			}
		
			// for coming out of a button
			for(head = se_buttonList; head; head = head->next) {
				if(head->over == 1) {
					head->over = 0;
					if(running && (!strncmp("Start", head->name, 5) || 
						       !strncmp("Highscores", head->name, 10) || 
						       !strncmp("Help", head->name, 4)))
					   return;
					SDL_SetCursor(getArrowCursor());
					drawText(head->x, head->y, head->name, head->over);
					return;
				}
			}
			
			SDL_SetCursor(getArrowCursor());
			break;
		}
	}
}

/*****************************************************
 ****************************************************/
Uint32 TimerFunc( Uint32 interval, void *p ) 
{
    SDL_UserEvent user;

    user.type = SDL_USEREVENT;

    SDL_PushEvent( (SDL_Event *) &user );

    return 1000;
}

/*****************************************************
 ****************************************************/
int main(int argc, char * argv[])
{
	int i;

	SE_SetName("Scramble 0.9.5");
	SE_SetBackground("pics/background.png");
	SOUND_X = 20;
	SOUND_Y = 350;
	
	/* Check for arguments */
	if(argc != 1) {
		if(strncmp(argv[1], "-d", 2) == 0)
			strncpy(dictionary, argv[2], 511);
	}
	else
#if __MORPHOS__
		strcpy(dictionary, "Progdir:web2.txt");
#else
		strcpy(dictionary, "/usr/share/dict/words");
#endif

	if(SE_Init() != 0)
		exit(1);

	font  = loadFont("fonts/keiserso.ttf", 36);
	font2 = loadFont("fonts/keiserso.ttf", 80);
	font3 = loadFont("fonts/arial.ttf",    16); /* For found words */

	littleBox  = loadPNG("pics/little_box.png");
	background = loadPNG("pics/background.png");

	clickSound     = loadSound("sounds/click.ogg");
	overSound      = loadSound("sounds/over.ogg");
	shuffleSound   = loadSound("sounds/shuffle.ogg");
	hitSound       = loadSound("sounds/hit.ogg");
	missSound      = loadSound("sounds/miss.ogg");
	tickSound      = loadSound("sounds/tick.ogg");
	warningSound   = loadSound("sounds/warning.ogg");
	countdownSound = loadSound("sounds/countdown.ogg");

	fprintf(stdout, "Initializing Dictionary...\n");

	initDictionary(dictionary);

	letters[0].x1 = letters[0].ox = 66;  letters[0].y1 = letters[0].oy = 413;
	letters[1].x1 = letters[1].ox = 197; letters[1].y1 = letters[1].oy = 374;
	letters[2].x1 = letters[2].ox = 321; letters[2].y1 = letters[2].oy = 411;
	letters[3].x1 = letters[3].ox = 458; letters[3].y1 = letters[3].oy = 387;
	letters[4].x1 = letters[4].ox = 566; letters[4].y1 = letters[4].oy = 434;
	letters[5].x1 = letters[5].ox = 681; letters[5].y1 = letters[5].oy = 390;
		
	SE_RegisterButton("Help",       HELP_X,      HELP_Y,      70,  30, &running, help);
	SE_RegisterButton("Quit",       QUIT_X,      QUIT_Y,      70,  30, &se_true, quit);
	SE_RegisterButton("Submit",     SUBMIT_X,    SUBMIT_Y,    100, 30, &notrunning, submit);
	SE_RegisterButton("Shuffle",    SHUFFLE_X,   SHUFFLE_Y,   100, 30, &notrunning, shuffle);
	SE_RegisterButton("Clear",      CLEAR_X,     CLEAR_Y,     100, 30, &notrunning, clear); 
	SE_RegisterButton("Back",       BACK_X,      BACK_Y,      70,  30, &notrunning, back);
	SE_RegisterButton("Last",       LAST_X,      LAST_Y,      70,  30, &notrunning, last);
	SE_RegisterButton("Start",      START_X,     START_Y,     100, 30, &running, start);
	SE_RegisterButton("Highscores", HIGHSCORE_X, HIGHSCORE_Y, 230, 30, &running, showHighscore);


	for(i = 0; i < 10; i++) {
		strcat(highscore[i].name, "Nobody"); highscore[i].score = 0; highscore[i].level = 0;
	}

	// Create high scores file if it does not exist
	home = getenv("HOME");
	scorepath = (char*)malloc(strlen(home) + strlen(file) + 1);
	strcpy(scorepath, home);
	strcat(scorepath, file);

	loadScores();

	notrunning = 1;
	running    = 0;
	redrawAll = 1;

	SE_Redraw();

	fprintf(stdout, "Initialization Complete. Starting game.\n");

	SDL_AddTimer( 1000, TimerFunc, NULL );

	SE_GameLoop();
	SE_Quit();
}
