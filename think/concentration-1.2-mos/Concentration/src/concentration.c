/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: concentration.c
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

#include "ShiftyEngine.h"

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#ifdef __MORPHOS__
const char *version_tag = "$VER: Concentration 1.2 (18.01.2006)";
#endif

/* Forward Refrerences needed */
void SE_CheckEvents ();
void updateClock    ();
void SE_Redraw      ();

/* Graphics locations */
#define ICON_SIZE  74
#define COUNT_X    750
#define COUNT_Y    500
#define QUIT_X     122
#define QUIT_Y     475
#define QUIT_H     40
#define QUIT_W     100
#define START_X    115
#define START_Y    425
#define START_H    40
#define START_W    120
#define SMALL_X    100
#define SMALL_Y    120
#define SMALL_H    35
#define SMALL_W    115
#define MEDIUM_X   SMALL_X + 10
#define MEDIUM_Y   SMALL_Y + 70
#define MEDIUM_H   35
#define MEDIUM_W   160
#define LARGE_X    SMALL_X - 5
#define LARGE_Y    MEDIUM_Y + 70
#define LARGE_H    35
#define LARGE_W    115
#define HELP_X     321
#define HELP_Y     540
#define HELP_H     35
#define HELP_W     90
#define SELECT_X   HELP_X + 150
#define SELECT_Y   HELP_Y
#define SELECT_H   35
#define SELECT_W   125
#define CLOSE_X    470
#define CLOSE_Y    445
#define CLOSE_H    30
#define CLOSE_W    114
#define PREV_X     317
#define PREV_Y     445
#define PREV_H     30
#define PREV_W     100
#define NEXT_X     641
#define NEXT_Y     445
#define NEXT_H     30
#define NEXT_W     100
#define HELP_LINES 14

/* Color definitions */
SDL_Color purple  = {183, 13, 165, 255};
SDL_Color darkRed = {160,  0,   0, 255};
SDL_Color black   = {90,  10,   0, 255};

/* Board */
struct {
	int icon;
	int x, y;
	int showing;
	int found; 
} Board[6][6];

/* Fonts */
TTF_Font * bigFont    = 0;
TTF_Font * smallFont  = 0;
TTF_Font * smallFont2 = 0;

/* Graphics surfaces */
SDL_Surface * icons[31];
SDL_Surface * icons2[31];
SDL_Surface * icons3[31];
SDL_Surface * mask      = 0;
SDL_Surface * sizeImage = 0;
SDL_Surface * text      = 0;

/* Number Surfaces */
SDL_Surface * zero  = 0;
SDL_Surface * one   = 0;
SDL_Surface * two   = 0;
SDL_Surface * three = 0;
SDL_Surface * four  = 0;
SDL_Surface * five  = 0;
SDL_Surface * six   = 0;
SDL_Surface * seven = 0;
SDL_Surface * eight = 0;
SDL_Surface * nine  = 0;

/* variables for the game loop */
int x1            = 0;
int x2            = 0;
int y1            = 0;
int y2            = 0;
int remaining     = 0;
int hits          = 0;
int misses        = 0;
int running       = 0;
int myclock       = 0;
int start         = 0;
int size          = 4;
int count         = 0;
int stateChanged  = 1;
int overQuit      = 0;
int overHelp      = 0;
int overSelect    = 0;
int overStart     = 0;
int overSmall     = 0;
int overMedium    = 0;
int overLarge     = 0;
int overNext      = 0;
int overPrev      = 0;
int overClose     = 0;
int board_x       = 395;
int board_y       = 119;
int showStats     = 0;
int iconSet       = 1;

/* Sound related variables */
Mix_Chunk * clickSound  = 0;
Mix_Chunk * click2Sound = 0;
Mix_Chunk * flipSound   = 0;
Mix_Chunk * hitSound    = 0;
Mix_Chunk * hit2Sound   = 0;
Mix_Chunk * hit3Sound   = 0;
Mix_Chunk * cheerSound  = 0;
Mix_Chunk * missSound   = 0;
Mix_Chunk * miss2Sound  = 0;
Mix_Chunk * miss3Sound  = 0;
Mix_Chunk * tickSound   = 0;

char * helpText[] = {
	"Objective:", 
	"  Click on an icon to see what is",
	"behind it, then click on another",
	"to reveal what it is hiding.",
	"Remember what you see and",
	"try to find all the matching",
	"pairs as quickly as possible.",
	" ",
	"Board sizes:",
	"  There are three board sizes to",
	"choose from depending on your",
	"skill level. To change the size",
	"click on the Small, Medium or",
	"Large buttons on the side.",
	" ",
	"Icons Sets:",
	"  There are also three icon sets",
	"to choose from. To change the",
	"icon set click on Select at the",
	"bottom of your screen and",
	"choose which set you wish to",
	"play with.",
	" ",
	"Volume:",
	"  To adjust the sound volume",
	"click on the speaker icon at",
	"the top of the screen to toggle",
	"between the high, low and off",
	"settings.",
	" ",
	"Hot keys:",
	"e - Select",
	"f - Toggle full screen mode",
	"h - Help",
	"s - Start a new game",
	"q - Quit",
	"v - Toggle volume settings",
	"1 - Small board",
	"2 - Medium board",
	"3 - Large board"
};

/*****************************************************
 ****************************************************/
inline void drawText(char * str, SDL_Color color, int x, int y, TTF_Font * font)
{
	static SDL_Rect dest;
	
	text = TTF_RenderText_Blended(font, str, color);
	
	dest.x = x; 
	dest.y = y;
	dest.h = text->h - 6; 
	dest.w = text->w;

	if(SDL_BlitSurface(background, &dest, screen, &dest) != 0) 
		SE_Error("A blit failed.");
	if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
		SE_Error("A blit failed.");
	SDL_UpdateRect(screen, dest.x, dest.y, dest.w, dest.h);
	SDL_FreeSurface(text);
}

/*****************************************************
 ****************************************************/
void quit()
{
	SE_Quit();
}

/*****************************************************
 ****************************************************/
void help()
{
	SDL_Event event;
	SDL_Rect src;
	int i = 0, j = 0, x = 321, y = 45, change = 1;
	
	SDL_SetAlpha(mask, SDL_SRCALPHA, 130);
	if(SDL_BlitSurface(mask, 0, screen, 0) != 0)
		SE_Error("A blit failed.");
			
	while(1) {
		if(change) {
			y = 45;
			
			src.x = x-3; src.y = y-3;
			src.h = src.w = 440;
			if(SDL_BlitSurface(background, &src, screen, &src) != 0)
				SE_Error("A blit failed.");

			for(i = 0; i < HELP_LINES - 1; i++)
				drawText(helpText[i + j], black, x, y + (i * 30), smallFont2);

			if(overPrev)
				drawText("Prev", purple, PREV_X + 10, PREV_Y, smallFont);
			else
				drawText("Prev", darkRed, PREV_X + 10, PREV_Y, smallFont);
			if(overClose)
				drawText("Close", purple, CLOSE_X + 10, CLOSE_Y, smallFont);
			else
				drawText("Close", darkRed, CLOSE_X + 10, CLOSE_Y, smallFont);
			if(overNext)
				drawText("Next", purple, NEXT_X + 10, NEXT_Y, smallFont);
			else
				drawText("Next", darkRed, NEXT_X + 10, NEXT_Y, smallFont);

			SDL_UpdateRect(screen, 0, 0, 0, 0);
			change = 0;
		}
		if(SDL_PollEvent(&event)) {
			int x, y;
			switch(event.type) {
			case SDL_QUIT:
				quit();
				break;
			case SDL_KEYDOWN:
				switch(event.key.keysym.sym) {
				case SDLK_PAGEUP:
					if(j == 0) break;
					j -= 5;
					if(j < 0)
						j = 0;
					change = 1;
					break;
				case SDLK_PAGEDOWN:
					j += 5;
					if(j > sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1) 
						j = sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1;
					change = 1;
					break;

				case SDLK_p:
				case SDLK_UP:
					if(j == 0) break;
					j--;
					change = 1;
					break;
				case SDLK_n:
				case SDLK_DOWN:
					j++;
					change = 1;
					if(j > sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1) 
						j = sizeof(helpText)/sizeof(helpText[1]) - HELP_LINES + 1;
					break;
				case SDLK_q:
					quit();
					break;
				case SDLK_f:
					SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
					SDL_Flip(screen);
#endif
					break;
				case SDLK_c:
					overClose = 0;
					SE_Redraw();
					return;
				default:
					break;
				}
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
						drawText("Prev", purple, PREV_X + 10, PREV_Y, smallFont);
					}
 
				}
				else if(event.motion.x > NEXT_X && event.motion.x < NEXT_X + NEXT_W &&
					event.motion.y > NEXT_Y && event.motion.y < NEXT_Y + NEXT_H) {
					if(!overNext) {
						playSound(clickSound);
						overNext = 1;
						drawText("Next", purple, NEXT_X + 10, NEXT_Y, smallFont);
					}

				}
				else if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
					event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(clickSound);
						overClose = 1;
						drawText("Close", purple, CLOSE_X + 10, CLOSE_Y, smallFont);
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						drawText("Close", darkRed, CLOSE_X + 10, CLOSE_Y, smallFont);
					}
					else if(overNext) {
						overNext = 0;
						drawText("Next", darkRed, NEXT_X + 10, NEXT_Y, smallFont);
					}
					else if(overPrev) {
						overPrev = 0;
						drawText("Prev", darkRed, PREV_X + 10, PREV_Y, smallFont);
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
void Select()
{
	SDL_Event event;
	SDL_Rect dest, src;
	int x = 321, y = 45, change = 1;

	SDL_SetAlpha(mask, SDL_SRCALPHA, 130);
	if(SDL_BlitSurface(mask, 0, screen, 0) != 0)
		SE_Error("A blit failed.");

	while(1) {
		if(change) {
			src.x = x-3; src.y = y-3;
			src.h = src.w = 440;
			if(SDL_BlitSurface(background, &src, screen, &src) != 0)
				SE_Error("A blit failed.");

			/* set 1 */
			dest.x = 350;
			dest.y = 60;
			if(SDL_BlitSurface(icons[7], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			
			dest.x = 424;
			if(SDL_BlitSurface(icons[19], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			dest.x = 498;
			if(SDL_BlitSurface(icons[22], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");

			/* set 2 */
			dest.x = 350;
			dest.y = 210;
			if(SDL_BlitSurface(icons2[18], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			dest.x = 424;
			if(SDL_BlitSurface(icons2[22], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			dest.x = 498;
			if(SDL_BlitSurface(icons2[23], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");

			/* set3 */
			dest.x = 350;
			dest.y = 360;
			if(SDL_BlitSurface(icons3[7], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			dest.x = 424;
			if(SDL_BlitSurface(icons3[24], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			dest.x = 498;
			if(SDL_BlitSurface(icons3[30], 0, screen, &dest) != 0)
				SE_Error("A blit failed.");

			if(overClose)
				drawText("Close", purple, CLOSE_X + 10, CLOSE_Y, smallFont);
			else
				drawText("Close", darkRed, CLOSE_X + 10, CLOSE_Y, smallFont);

			text   = TTF_RenderText_Blended(smallFont2, "Selected", black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = 580;
			switch(iconSet) {
			case 0:
				dest.y = 78;
				break;
			case 1:
				dest.y = 228;
				break;
			case 2:
				dest.y = 378;
				break;
			}
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);

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
				if(x > CLOSE_X && x < CLOSE_X + CLOSE_W &&
				   y > CLOSE_Y && y < CLOSE_Y + CLOSE_H) {
					overClose = 0;
					SE_Redraw();
					return;
				}
				else if(x > 346 && x < 546 &&
					y > 58 && y < 122) {
					playSound(click2Sound);
					iconSet = 0;
					change = 1;
				}
				else if(x > 346 && x < 546 &&
					y > 210 && y < 274) {
					playSound(click2Sound);
					iconSet = 1;
					change = 1;
				}
				else if(x > 346 && x < 546 &&
					y > 360 && y < 424) {
					playSound(click2Sound);
					iconSet = 2;
					change = 1;
				}
				break;
			case SDL_MOUSEMOTION:
				if(event.motion.x > CLOSE_X && event.motion.x < CLOSE_X + CLOSE_W &&
				   event.motion.y > CLOSE_Y && event.motion.y < CLOSE_Y + CLOSE_H) {
					if(!overClose) {
						playSound(clickSound);
						overClose = 1;
						change = 1;
					}
				}
				else {
					if(overClose) {
						overClose = 0;
						change = 1;
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
void fade(int x, int y, int x2, int y2)
{
	int i;
	SDL_Rect dest, dest2;

	dest.x  = board_x + (ICON_SIZE * (x));
	dest.y  = board_y + (ICON_SIZE * (y));
	dest2.x = board_x + (ICON_SIZE * (x2));
	dest2.y = board_y + (ICON_SIZE * (y2));

	dest.w = dest2.w = dest.h = dest2.h = ICON_SIZE;

	for(i = SDL_ALPHA_TRANSPARENT; i <= 185; i += 5) {
		updateClock();
		SE_CheckEvents();
		SDL_Delay(10); /* small delay for the animation */

		SDL_SetAlpha(background, SDL_SRCALPHA, i);

		if(SDL_BlitSurface(background, &dest, screen, &dest) != 0)
			SE_Error("A blit failed.");
		if(SDL_BlitSurface(background, &dest2, screen, &dest2) != 0)
			SE_Error("A blit failed.");

		SDL_UpdateRect(screen, dest2.x, dest2.y, dest2.w, dest2.h);
		SDL_UpdateRect(screen, dest.x, dest.y, dest.w, dest.h);
	}
	SDL_SetAlpha(background, SDL_SRCALPHA, SDL_ALPHA_OPAQUE);
	if(SDL_BlitSurface(background, &dest, screen, &dest) != 0)
		SE_Error("A blit failed.");
	if(SDL_BlitSurface(background, &dest2, screen, &dest2) != 0)
		SE_Error("A blit failed.");
		
	SDL_UpdateRect(screen, dest2.x, dest2.y, dest2.w, dest2.h);
	SDL_UpdateRect(screen, dest.x, dest.y, dest.w, dest.h);
}


/*****************************************************
 ****************************************************/
void drawClock()
{
	SDL_Surface * surface_temp = 0;
	SDL_Rect src, dest;
	int temp = 0;
	int currentCountX = COUNT_X;

	/* Clear count */
	src.x = dest.x = 400;
	src.y = dest.y = 500;
	src.w = dest.w = 400;
	src.h = dest.h = 100;
	if(SDL_BlitSurface(background, &src, screen, &dest) != 0)
		SE_Error("A blit failed.");


	src.x  = 0;
	src.y  = 0;
	dest.y = COUNT_Y;
	temp   = myclock;
	while(temp) {
		int t = temp % 10;
		temp /= 10;
		currentCountX -= zero->w;

		dest.x = currentCountX;
		switch(t) {
		case 1:
			dest.x += one->w - 10;
			surface_temp = one;
			break;
		case 2:
			surface_temp = two;
			break;
		case 3:
			surface_temp = three;
			break;
		case 4:
			surface_temp = four;
			break;
		case 5:
			surface_temp = five;
			break;
		case 6:
			surface_temp = six;
			break;
		case 7:
			surface_temp = seven;
			break;
		case 8:
			surface_temp = eight;
			break;
		case 9:
			surface_temp = nine;
			break;
		case 0:
			surface_temp = zero;
			break;
		}

		src.w  = dest.w = surface_temp->w;
		src.h  = dest.h = surface_temp->h;
		if(SDL_BlitSurface(surface_temp, &src, screen, &dest) != 0)
			SE_Error("A blit failed.");
	}

	SDL_UpdateRect(screen, 400, 500, 350, 100);
}

/*****************************************************
 ****************************************************/
void updateClock()
{
	int temp = time(0) - start;
	if(myclock == temp)
		return;

	playSound(tickSound);

	myclock = temp;
	drawClock();
}

/*****************************************************
 ****************************************************/
void copy(int x, int y, int slot)
{
	SDL_Rect src, dest;

	src.x  = src.y = 0;
	src.w  = src.h = ICON_SIZE;
	dest.x = board_x + (ICON_SIZE * (x));
	dest.y = board_y + (ICON_SIZE * (y));
	dest.w = dest.h = ICON_SIZE;
	switch(iconSet) {
	case 0:
		if(SDL_BlitSurface(icons[slot], &src, screen, &dest) != 0)
			SE_Error("A blit failed.");
		break;
	case 1:
		if(SDL_BlitSurface(icons2[slot], &src, screen, &dest) != 0)
			SE_Error("A blit failed.");
		break;
	case 2:
		if(SDL_BlitSurface(icons3[slot], &src, screen, &dest) != 0)
			SE_Error("A blit failed.");
		break;
	}
}



/*****************************************************
 ****************************************************/
void initBoard()
{
	int x, y;

#ifndef __MORPHOS__
	srandom(time(0));
#else
	srand(time(0));
#endif

	for(x = 0; x < size; x++) {
		for(y = 0; y < size; y++) {
			Board[x][y].icon    = 0;
			Board[x][y].x       = 0;
			Board[x][y].y       = 0;
			Board[x][y].showing = 0;
			Board[x][y].found   = 0;
		}
	}
}

/*****************************************************
 ****************************************************/
void SE_Redraw()
{
	static SDL_Rect dest;
	int x;
	int y;

	stateChanged = 0;

	/* Draw Background */
	if(SDL_BlitSurface(background, 0, screen, 0) != 0)
		SE_Error("A blit failed.");

	/* Draw icons */
	for(x = 0; x < size; x++) {
		for(y = 0; y < size; y++) {
			if(!Board[x][y].found) {
				if(Board[x][y].showing)
					copy(x, y, Board[x][y].icon);
				else
					copy(x, y, 0);
			}
		}
	}

	/* Draw text */
	if(overQuit)
		drawText("Quit", purple, QUIT_X, QUIT_Y, bigFont);
	else
		drawText("Quit", darkRed, QUIT_X, QUIT_Y, bigFont);

	if(running) {
		drawClock();

		if(overStart)
			drawText("Stop", purple, START_X, START_Y, bigFont);
		else
			drawText("Stop", darkRed, START_X, START_Y, bigFont);
	}

	if(!running) {
		if(overStart)
			drawText("Start", purple, START_X, START_Y, bigFont);
		else
			drawText("Start", darkRed, START_X, START_Y, bigFont);

		if(overHelp)
			drawText("Help", purple, HELP_X, HELP_Y, smallFont);
		else
			drawText("Help", darkRed, HELP_X, HELP_Y, smallFont);

		if(overSelect)
			drawText("Select", purple, SELECT_X, SELECT_Y, smallFont);
		else
			drawText("Select", darkRed, SELECT_X, SELECT_Y, smallFont);

		if(overSmall)
			drawText("Small", purple, SMALL_X, SMALL_Y, smallFont);
		else {
			if(size == 2)
				drawText("Small", black, SMALL_X, SMALL_Y, smallFont);
			else 
				drawText("Small", darkRed, SMALL_X, SMALL_Y, smallFont);
		}

		if(overMedium)
			drawText("Medium", purple, MEDIUM_X, MEDIUM_Y, smallFont);
		else {
			if(size == 4)
				drawText("Medium", black, MEDIUM_X, MEDIUM_Y, smallFont);
			else 
				drawText("Medium", darkRed, MEDIUM_X, MEDIUM_Y, smallFont);
		}

		if(overLarge)
			drawText("Large", purple, LARGE_X, LARGE_Y, smallFont);
		else {
			if(size == 6)
				drawText("Large", black, LARGE_X, LARGE_Y, smallFont);
			else 
				drawText("Large", darkRed, LARGE_X, LARGE_Y, smallFont);
		}

 
		if(showStats) {
			char str[256];
			int x = 315, y = 50;
			text   = TTF_RenderText_Blended(smallFont, "Congratulations!", black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
			
			text   = TTF_RenderText_Blended(smallFont, "You completed in", black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y + 60;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
			
			sprintf(str, "%d seconds", myclock);
			text   = TTF_RenderText_Blended(smallFont, str, black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y + 100;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
			
			text   = TTF_RenderText_Blended(smallFont, "and in", black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y + 140;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
			
			sprintf(str, "%d trys", hits + misses);
			text   = TTF_RenderText_Blended(smallFont, str, black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y + 180;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
			
			sprintf(str, "Total pairs: %d", (size == 2) ? 2 : (size == 4) ? 8 : 36);
			text   = TTF_RenderText_Blended(smallFont, str, black);
			if(!text)
				SE_Error("A render failed.");
			dest.x = x + ((444 - text->w)/2); dest.y = y + 240;
			if(SDL_BlitSurface(text, 0, screen, &dest) != 0)
				SE_Error("A blit failed.");
			SDL_FreeSurface(text);
		}
	}

	showIcon();
	SE_ShowSoundIcon();
		
	SDL_UpdateRect(screen, 0, 0, 0, 0);
}


/*****************************************************
 ****************************************************/
void hit()
{
	switch(rand() % 3) {
	case 0:
		playSound(hitSound);
		break;
	case 1:
		playSound(hit2Sound);
		break;
	case 2:
		playSound(hit3Sound);
		break;
	}
	 hits++;
}

/*****************************************************
 ****************************************************/
void miss()
{
	switch(rand() % 3) {
	case 0:
		playSound(missSound);
		break;
	case 1:
		playSound(miss2Sound);
		break;
	case 2:
		playSound(miss3Sound);
		break;
	}
	misses++;
}

/*****************************************************
 ****************************************************/
void completed()
{
	playSound(cheerSound);

	running      = 0;
	showStats    = 1;
	stateChanged = 1;
}

/*****************************************************
 ****************************************************/
int whereClicked(int x, int y, int * x_, int * y_)
{
	int bx = 0, by = 0;
	x -= board_x;
	y -= board_y;

	if(x < 0 || x > 444) return -1;
	if(y < 0 || y > 444) return -1;

	while(x >= 0) { x -= ICON_SIZE; bx++; }
	while(y >= 0) { y -= ICON_SIZE; by++; }

	*x_ = bx - 1; *y_ = by - 1;

	return 0;
}


/*****************************************************
 ****************************************************/
void flip(int x, int y)
{
	SDL_Rect dest;
	int bx = x, by = y;

	if(Board[bx][by].found == 1) return;

	dest.x = board_x + (ICON_SIZE * (x));
	dest.y = board_y + (ICON_SIZE * (y));
	dest.w = dest.h = ICON_SIZE;
	if(SDL_BlitSurface(background, &dest, screen, &dest) != 0)
		SE_Error("A blit failed.");

	if(Board[bx][by].showing){
		copy(x, y, 0);
		Board[bx][by].showing = 0;
	}
	else {
		copy(x, y, Board[bx][by].icon);
		Board[bx][by].showing = 1;
	}

	playSound(flipSound);

	stateChanged = 1;
	SDL_UpdateRect(screen, dest.x, dest.y, dest.w, dest.h);
}

/*****************************************************
 ****************************************************/
void gameLoop()
{
	int curTiles[18];
	int x, y;

	if(running)
		running = 0;
	else
		running = 1;

	initBoard();

	/* Select the 18 tiles to use */
	for(x = 0; x < (size * size) / 2; x++) {
#ifndef __MORPHOS__
		int s = random() % 30 + 1;
#else
		int s = rand() % 30 + 1;
#endif

		/* Check if the number has been selected */
		for(y = 0; y < x; y++)
			if(curTiles[y] == s) { x--; s = 0;}

		if(s)
			curTiles[x] = s;
	}

	/* Assign the 18 tiles to the size*size slots */
	count = 0;
	while(count < size * size) {
#ifndef __MORPHOS__
		x = random() % size;
		y = random() % size;
#else
		x = (rand() / 9) % size;    // otherwise the random function is not random enough
		y = (rand() / 9) % size;    // and loops endlessly on my PegII/G4
#endif
		if(Board[x][y].icon == 0) {
			Board[x][y].icon = curTiles[(count % ((size * size) / 2))];
			count++;
		}
	}

	count     = 0;
	remaining = size * size / 2;
	hits      = 0;
	misses    = 0;
	myclock   = 0;
	start     = time(0);
	showStats = 0;

	/* Actual game loop */
	while(running) {
		SE_CheckEvents();
		updateClock();
	}
}


/*****************************************************
 ****************************************************/
void adjustBoardSize(int x)
{
	switch(x) {
	case 2:
		board_x = 469;
		board_y = 193;
		size = 2;
		break;
	case 4:
		board_x = 395;
		board_y = 119;
		size = 4;
		break;
	case 6:
		board_x = 321;
		board_y = 45;
		size = 6;
		break;
	}
	
	showStats    = 0;
	stateChanged = 1;

	initBoard();
}

/*****************************************************
 ****************************************************/
void SE_CheckEvents()
{
	SDL_Event event;
	int x, y, bx, by;
		
	if(SDL_PollEvent(&event)) {
		if(stateChanged)
			SE_Redraw();
		switch (event.type) {
		case SDL_MOUSEMOTION:
			x = event.motion.x;
			y = event.motion.y;

			if(!running && y > ICON_Y && x < ICON_W) {
				SDL_SetCursor(getHandCursor());
			}
			else if(logoShowing) {
				SDL_SetCursor(getArrowCursor());
				break;
			}
			else if(running && x > board_x && x < board_x + 444 &&
				y > board_y && y < board_y + 444) {
				whereClicked(event.button.x, event.button.y, &bx, &by);
				if(!Board[bx][by].found && bx < size && by < size)
					SDL_SetCursor(getHandCursor());
				else
					SDL_SetCursor(getArrowCursor());
			}
			else if(x > SOUND_X-5 && x < SOUND_X + ICON_SIZE/2 &&
				y > SOUND_Y-2 && y < SOUND_Y + ICON_SIZE/2) {
				SDL_SetCursor(getHandCursor());
			}


			else if(x > QUIT_X && x < QUIT_X + QUIT_W &&
				y > QUIT_Y && y < QUIT_Y + QUIT_H) {
				if(!overQuit) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overQuit = 1;
					drawText("Quit", purple, QUIT_X, QUIT_Y, bigFont);
				}
			}
			else if(!running && x > HELP_X && x < HELP_X + HELP_W &&
				y > HELP_Y && y < HELP_Y + HELP_H) {
				if(!overHelp) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overHelp = 1;
					drawText("Help", purple, HELP_X, HELP_Y, smallFont);
				}
			}
			else if(!running && x > SELECT_X && x < SELECT_X + SELECT_W &&
				y > SELECT_Y && y < SELECT_Y + SELECT_H) {
				if(!overSelect) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overSelect = 1;
					drawText("Select", purple, SELECT_X, SELECT_Y, smallFont);
				}
			}
			else if(x > START_X && x < START_X + START_W &&
				y > START_Y && y < START_Y + START_H) {
				if(!overStart) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overStart = 1;
					if(!running)
						drawText("Start", purple, START_X, START_Y, bigFont);
					else
						drawText("Stop", purple, START_X, START_Y, bigFont);
				}
			}
			else if(!running && x > SMALL_X && x < SMALL_X + SMALL_W &&
				y > SMALL_Y && y < SMALL_Y + SMALL_H) {
				if(!overSmall) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overSmall = 1;
					drawText("Small", purple, SMALL_X, SMALL_Y, smallFont);
				}
			}
			else if(!running && x > MEDIUM_X && x < MEDIUM_X + MEDIUM_W &&
				y > MEDIUM_Y && y < MEDIUM_Y + MEDIUM_H) {
				if(!overMedium) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overMedium = 1;
					drawText("Medium", purple, MEDIUM_X, MEDIUM_Y, smallFont);
				}
			}
			else if(!running && x > LARGE_X && x < LARGE_X + LARGE_W &&
				y > LARGE_Y && y < LARGE_Y + LARGE_H) {
				if(!overLarge) {
					playSound(clickSound);
					SDL_SetCursor(getHandCursor());
					overLarge = 1;
					drawText("Large", purple, LARGE_X, LARGE_Y, smallFont);
				}
			}
			else {
				if(overQuit) {
					overQuit = 0;
					drawText("Quit", darkRed, QUIT_X, QUIT_Y, bigFont);
				}
				else if(overStart) {
					overStart = 0;
					if(!running)
						drawText("Start", darkRed, START_X, START_Y, bigFont);
					else
						drawText("Stop", darkRed, START_X, START_Y, bigFont);
				}
				else if(overHelp) {
					overHelp = 0;
					drawText("Help", darkRed, HELP_X, HELP_Y, smallFont);
				}
				else if(overSelect) {
					overSelect = 0;
					drawText("Select", darkRed, SELECT_X, SELECT_Y, smallFont);
				}
				else if(overSmall) {
					overSmall = 0;
					if(size == 2)
						drawText("Small", black, SMALL_X, SMALL_Y, smallFont);
					else 
						drawText("Small", darkRed, SMALL_X, SMALL_Y, smallFont);

				}
				else if(overMedium) {
					overMedium = 0;
					if(size == 4)
						drawText("Medium", black, MEDIUM_X, MEDIUM_Y, smallFont);
					else 
						drawText("Medium", darkRed, MEDIUM_X, MEDIUM_Y, smallFont);
				}
				else if(overLarge) {
					overLarge = 0;
					if(size == 6)
						drawText("Large", black, LARGE_X, LARGE_Y, smallFont);
					else 
						drawText("Large", darkRed, LARGE_X, LARGE_Y, smallFont);
				}
				SDL_SetCursor(getArrowCursor());
			}
			break;
		case SDL_MOUSEBUTTONDOWN:
			x = event.button.x;
			y = event.button.y;
			if(!running && y > ICON_Y && x < ICON_W) {
				playSound(click2Sound);
				
				logoClicked();
			}
			else if(logoShowing)
				break;
			else if(running && whereClicked(x, y, &bx, &by) == 0) {
				if(bx >= size || by >= size || bx < 0 || by < 0 || Board[bx][by].found)
					break;

				if(count == 0) {
					x1 = bx;
					y1 = by;
					count = 1;
					flip(bx, by);
				} 
				else {
					x2 = bx;
					y2 = by;

					if(x1 == x2 && y1 == y2) 
						break;

					flip(bx, by);

					count = 0;

					if(Board[x1][y1].icon == Board[x2][y2].icon) {
						hit();
						Board[x1][y1].found = 1;
						Board[x2][y2].found = 1;
						fade(x1, y1, x2, y2);
						if(--remaining == 0)
							completed();
						SE_Redraw();
						break;
					}
					else {
						miss();
						updateClock();
						SDL_Delay(500); /* Pause to see the icons */
						updateClock();
						flip(x1, y1);
						flip(x2, y2);
					}
				}
			}
			else if(x > QUIT_X && x < QUIT_X + QUIT_W &&
				y > QUIT_Y && y < QUIT_Y + QUIT_H) {
				playSound(click2Sound);
				quit();
			}
			else if(x > SOUND_X && x < SOUND_X + ICON_SIZE/2 &&
				y > SOUND_Y && y < SOUND_Y + ICON_SIZE/2) {
				playSound(click2Sound);
				SE_AdjustSoundLevel();
				stateChanged = 1;
			}
			else if(!running && x > HELP_X && x < HELP_X + ICON_SIZE &&
				y > HELP_Y && y < HELP_Y + ICON_SIZE) {
				playSound(click2Sound);
				help();
			}
			else if(!running && x > SELECT_X && x < SELECT_X + ICON_SIZE &&
				y > SELECT_Y && y < SELECT_Y + ICON_SIZE) {
				playSound(click2Sound);
				Select();
			}
			else if(!running && x > SMALL_X && x < SMALL_X + SMALL_W &&
				y > SMALL_Y && y < SMALL_Y + SMALL_H) {
				playSound(click2Sound);
				adjustBoardSize(2);
			}
			else if(!running && x > MEDIUM_X && x < MEDIUM_X + MEDIUM_W &&
				y > MEDIUM_Y && y < MEDIUM_Y + MEDIUM_H) {
				playSound(click2Sound);
				adjustBoardSize(4);
			}
			else if(!running && x > LARGE_X && x < LARGE_X + LARGE_W &&
				y > LARGE_Y && y < LARGE_Y + LARGE_H) {
				playSound(click2Sound);
				adjustBoardSize(6);
			}
			else if(x > START_X && x < START_X + START_W &&
				y > START_Y && y < START_Y + START_H) {
				playSound(click2Sound);
				stateChanged = 1;
				gameLoop();
			}
			break;
		case SDL_KEYDOWN:
			switch(event.key.keysym.sym) {
			case SDLK_e:
				Select();
				break;
			case SDLK_f:
				SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
				SDL_Flip(screen);
#endif
				break;
			case SDLK_h:
				help();
				break;
			case SDLK_s:
				stateChanged = 1;
				gameLoop();
				break;
			case SDLK_q:
				quit();
				break;
			case SDLK_v:
				SE_AdjustSoundLevel();
				stateChanged = 1;
				break;
			case SDLK_1:
				playSound(click2Sound);
				adjustBoardSize(2);
				break;
			case SDLK_2:
				playSound(click2Sound);
				adjustBoardSize(4);
				break;
			case SDLK_3:
				playSound(click2Sound);
				adjustBoardSize(6);
				break;
			default:
				break;
			}
			break;
		case SDL_QUIT:
			quit();
			break;
		}
	}
}

/*****************************************************
 ****************************************************/
int main(int argc , char * argv[])
{
	int x, makeFullScreen = 0;

	char name[16];
	
	SE_SetName("Concentration 1.2");
	SE_SetBackground("pics/background.png");
	SOUND_X = 750;
	SOUND_Y = 550;

       /* Check for arguments */
        if(argc != 1) {
                if(strncmp(argv[1], "-f", 2) == 0 || strncmp(argv[1], "--fullscreen", 12) == 0)
                        makeFullScreen = 1;
        }


	if(SE_Init() != 0)
		SE_Quit();

	SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
	
	if(makeFullScreen) {
		SDL_WM_ToggleFullScreen(screen);
#ifdef __MORPHOS__
		SDL_Flip(screen);
#endif
	}

	/* Load Fonts */
	bigFont    = loadFont("fonts/bluestone.ttf", 40);
	smallFont  = loadFont("fonts/bluestone.ttf", 32);
	smallFont2 = loadFont("fonts/bluestone.ttf", 20);

	/* Load Sounds */
	flipSound   = loadSound("sounds/flip-piece.ogg");
	hitSound    = loadSound("sounds/hit.ogg");
	hit2Sound   = loadSound("sounds/hit2.ogg");
	hit3Sound   = loadSound("sounds/hit3.ogg");
	missSound   = loadSound("sounds/miss.ogg");
	miss2Sound  = loadSound("sounds/miss2.ogg");
	miss3Sound  = loadSound("sounds/miss3.ogg");
	tickSound   = loadSound("sounds/tick.ogg");
	cheerSound  = loadSound("sounds/cheering.ogg");
	clickSound  = loadSound("sounds/click.ogg");
	click2Sound = loadSound("sounds/click2.ogg");

	/* Load Images */
	mask = SDL_CreateRGBSurface (SDL_SWSURFACE, 
				     background->w, 
				     background->h, 
				     background->format->BitsPerPixel, 
				     background->format->Rmask, 
				     background->format->Gmask, 
				     background->format->Bmask, 
				     background->format->Amask);
	SDL_FillRect(mask, 0, 0);

	one          = loadPNG("pics/one.png");
	two          = loadPNG("pics/two.png");
	three        = loadPNG("pics/three.png");
	four         = loadPNG("pics/four.png");
	five         = loadPNG("pics/five.png");
	six          = loadPNG("pics/six.png");
	seven        = loadPNG("pics/seven.png");
	eight        = loadPNG("pics/eight.png");
	nine         = loadPNG("pics/nine.png");
	zero         = loadPNG("pics/zero.png");
	icons[0]     = loadPNG("pics/cover.png");
	icons2[0]    = icons[0];
	icons3[0]    = icons[0];

	/* load icon set 1 */
	for(x = 1; x <= 30; x++) {
		sprintf(name, "pics/set1/%d.png", x);
		icons[x] = loadPNG(name);

		sprintf(name, "pics/set2/%d.png", x);
		icons2[x] = loadPNG(name);

		sprintf(name, "pics/set3/%d.png", x);
		icons3[x] = loadPNG(name);
	}

	fprintf(stdout, "Initiatization Complete. Starting Game.\n");

	/* Start the Game */
	initBoard();

	SE_GameLoop();

	quit();

	return 0;
}
