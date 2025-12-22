/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: hangman.c
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

#include <time.h>

#include "ShiftyEngine.h"

extern void initDictionary();
extern char * getWord();

/* Fonts */
TTF_Font * font  = NULL;
TTF_Font * font2 = NULL;
TTF_Font * font3 = NULL;

/* Surfaces */
SDL_Surface * noose       = NULL;
SDL_Surface * background2 = NULL;
SDL_Surface * text        = NULL;

/* Colors */
SDL_Color black      = {0, 0, 0, 255};
SDL_Color brown      = {134, 113, 81, 255};
SDL_Color lightBrown = {194, 183, 151, 255};
SDL_Color red        = {244, 53, 51, 255};

/* Sounds */
Mix_Chunk * wordMissSound     = NULL;
Mix_Chunk * wordHitSound      = NULL;
Mix_Chunk * clickSound        = NULL;
Mix_Chunk * overSound         = NULL;
Mix_Chunk * nooseDropSound    = NULL;
Mix_Chunk * letterSelectSound = NULL;

/* Button Locations */
#define QUIT_X     680
#define QUIT_Y     540
#define QUIT_H     40
#define QUIT_W     85
#define HELP_X     680
#define HELP_Y     460
#define HELP_W     85
#define HELP_H     40
#define START_X    QUIT_X
#define START_Y    200
#define START_W    85
#define START_H    57
#define ICON_SIZE  40
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


/* Misc. Variables */
int heights[6];
int numberNooses  = 0;
int numberGuesses = 7;
int stateChanged  = 0;
int running       = 0;
int score         = 0;
int size          = 0;
int found         = 0;
int total         = 0;
int correct       = 0;
int overClose     = 0;
int overPrev      = 0;
int overNext      = 0;
char * word       = NULL;
char * attempt    = NULL;

unsigned int longest_word  = 9;
unsigned int shortest_word = 3;

char dictionary[512];

struct Letter {
	int x, y;
	char tried;
} letters[26];

char * helpText[] = {
	"Objective:", 
	" Clicking on start gives you a new word to",
	"guess. Solve the word by selecting letters",
	"by either typing the letter on the keyboard",
	"or clicking on the letter at the bottom of ",
	"the screen with the mouse. Once a letter",
	"has been chosen a red slash goes through",
	"it so you don't select it again. If the",
	"letter is not in the word a noose falls,",
	"if the letter is in the word all instances",
	"of the letter appear. You are allowed seven",
	"misses per word. After these seven misses",
	"are up the word appears and you are ready",
	"to try again with another word.",
	" ",
	"Dictionary:",
	" The default dictionary is the GNU ",
	"dictionary. However, this dictionary is not",
	"very complete. You can pass a -d flag when",
	"starting Hangman to use an alternate",
	"dictionary. The current limit is 512",
	"characters for the pathname. To load you",
	"can us:",
	"hangman -d myDict.txt",
	"fill in myDict.txt with the pathname of",
	"your dictionary of choice.",
	" ",
	"Number of misses:",
	" The default number of misses is 7. You",
	"can raise to a maximum of 12 and lower",
	"to a minimum of 3 by using the up and",
	"down arrows resepectively when not",
	"guessing a word.",
	" ",
	"Volume:",
	"  To adjust the sound volume click on the",
	"speaker icon in the upper right of the",
	"screen to toggle between the high, low and",
	"off settings. Or you may use the hot key.",
	" ",
	"Hotkeys:",
	"F1 - toggle fullscreen mode",
	"ESC - quit game",
	" ",
	"Hotkeys: (When not guessing)",
	"f - toggle fullscreen mode",
	"h - help",
	"s - start game",
	"q - quit game",
	"v - toggle volume"
};

/*****************************************************
 ****************************************************/
void drawText(const int x, const int y, char * str, const int over)
{
	SDL_Rect dest;

	if(over) {
		/* Clear background and draw lower portion of text */
		text   = TTF_RenderText_Blended(font2, str, lightBrown);
		dest.x = x-2; 
		dest.y = y-2;
		dest.h = text->h + 10; 
		dest.w = text->w + 15;
		SDL_BlitSurface(background, &dest, screen, &dest);
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
		text = TTF_RenderText_Blended(font, str, black);
	}
	else {
		/* Only clear the background */
		text   = TTF_RenderText_Blended(font, str, black);
		dest.x = x-2; 
		dest.y = y-2;
		dest.h = text->h + 10; 
		dest.w = text->w + 15;
		SDL_BlitSurface(background, &dest, screen, &dest);
	}

	dest.x = x; 
	dest.y = y;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	/* Plus a little fudge to cover white background */
	SDL_UpdateRect(screen, x - 4, y - 4, text->w + 20, text->h + 10);
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
	unsigned int i, j = 0, x = 20, y = 60, change = 1;

	if(running)
		return;

	while(1) {
		if(change) {
			y = 60;
			
			if(SDL_BlitSurface(background, 0, screen, 0) != 0)
				SE_Error("A blit failed.");

			for(i = 0; i < HELP_LINES; i++)
				drawText(x, y + (i * 50), helpText[i + j], 0);
			
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
				case SDLK_q:
					quit();
					break;
				case SDLK_f:
					SDL_WM_ToggleFullScreen(screen);
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
						SE_PlaySound(overSound);
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
						SE_PlaySound(overSound);
						drawText(PREV_X + 10, PREV_Y, "Prev", overPrev);
					}
				}
				else if(event.motion.x > NEXT_X && event.motion.x < NEXT_X + NEXT_W &&
					event.motion.y > NEXT_Y && event.motion.y < NEXT_Y + NEXT_H) {
					if(!overNext) {
						overNext     = 1;
						stateChanged = 1;
						SE_PlaySound(overSound);
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
			default:
				break;
			}
		}
	}
}

/*****************************************************
 ****************************************************/
void crossOut(const int i)
{
	SDL_Rect dest;
	
	text = TTF_RenderText_Blended(font2, "/", red);
	dest.x = letters[i].x; 
	dest.y = letters[i].y;
	dest.h = text->h; 
	dest.w = text->w;
	SDL_BlitSurface(text, 0, screen, &dest);
	SDL_FreeSurface(text);

	SDL_UpdateRects(screen, 1, &dest);
}

/*****************************************************
 ****************************************************/
void drawText2(const int x, const int y, char * str)
{
	SE_Print(x, y + 2, str, brown, font2, screen, 0);
	SE_Print(x, y,     str, black, font2, screen, 0);
}

/*****************************************************
 ****************************************************/
void SE_Redraw()
{
	int i, x, y;
	SDL_Rect dest,src;
	char str[16];

	stateChanged = 0;

	SDL_BlitSurface(background, 0, screen, 0);
	
	if(!running) {
		drawText(HELP_X,  HELP_Y,  "Help", 0);
		drawText(START_X, START_Y, "Start", 0);
	}
	drawText(QUIT_X, QUIT_Y, "Quit", 0);

	SE_ShowSoundIcon();
   
	if(attempt) {
		text   = TTF_RenderText_Blended(font3, attempt, black);
		dest.x = (WIDTH - text->w) / 2; 
		dest.y = 280; /* 280 is Y location of score */
		dest.h = text->h; 
		dest.w = text->w;
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);

		text   = TTF_RenderText_Blended(font3, attempt, lightBrown);
		dest.x = (WIDTH - text->w) / 2 - 2; 
		dest.y = 280 - 2;
		dest.h = text->h; 
		dest.w = text->w;
		SDL_BlitSurface(text, 0, screen, &dest);
		SDL_FreeSurface(text);
	}

	
	/* draw Score */
	sprintf(str, "%d/%d", correct, total);
	drawText2(20, 400, str);

	/* draw all the letters */
	drawText2(-1, 400, "A B C D E F G H");
	drawText2(-1, 450, "I J K L M N O P Q");
	drawText2(-1, 500, "R S T U V W X Y Z");

	/* Draw the nooses */
	for(i = 0; i < numberNooses; i++) {
		src.x  = 0;
		src.y  = heights[i];
		src.h  = noose->h;
		src.w  = noose->w;
		dest.x = (WIDTH / numberGuesses) * (i + 1);
		dest.y = 0;
		dest.h = noose->h;
		dest.w = noose->w;
		SDL_BlitSurface(noose, &src, screen, &dest);
	}

	/* mark out tried letters */
	for(i = 0; i < 26; i++) 
		if(letters[i].tried)
			crossOut(i);
		
	SE_ShowIcon();

	SDL_UpdateRect(screen, 0, 0, 0, 0);
}


/*****************************************************
 ****************************************************/
void showWord()
{
	int i;

	for(i = 0; i < size; i++)
		attempt[i * 2] = toupper(word[i]);

	stateChanged = 1;
}

/*****************************************************
 ****************************************************/
void start()
{
	int i;

	if(running)
		return;

	word = getWord();
	size = strlen(word);

	free(attempt);
	attempt = (char *)malloc(size + (size - 1));
	strcpy(attempt, "_");

	/* Show underscores for each letter */
	for(i = 0; i < size - 1; i++)
		strcat(attempt, " _");

	stateChanged = 1;
	found        = 0;
	numberNooses = 0;
	running      = 1;

	/* Select heights of nooses */
	for(i = 0; i < numberGuesses; i++)
		heights[i] = rand() % 25;

	/* Clear tried array */
	for(i = 0; i < 26; i++)
		letters[i].tried = 0;
}


/*****************************************************
 ****************************************************/
void checkLetter(char ch)
{
	int i, f = 0;
	if(!running)
		return;

	if(letters[ch - 'a'].tried)
		return;
	else
		letters[ch - 'a'].tried = 1;

	crossOut(ch - 'a');

	SE_PlaySound(clickSound);
       
	for(i = 0; i < size; i++) {
		if(word[i] == ch) {
			attempt[i * 2] = toupper(word[i]);
			found++; 
			f++;
		}
	}

	if(!f) {
		SDL_Rect src, dest;
		int i;
		SE_PlaySound(nooseDropSound);
		SDL_Delay(500);

		for(i = noose->h - 5; i >= heights[numberNooses - 1] + 5; i -= 10) {
			src.x  = 0;
			src.y  = i;
			src.h  = noose->h;
			src.w  = noose->w;
			dest.x = (WIDTH / numberGuesses) * (numberNooses + 1);
			dest.y = 0;
			dest.h = noose->h;
			dest.w = noose->w;
			SDL_BlitSurface(background, &dest, screen, &dest);
			SDL_BlitSurface(noose, &src, screen, &dest);
			SDL_UpdateRect(screen, 0, 0, 0, 0);
		}
		numberNooses++;
	}

	stateChanged = 1;

	if(found == size) {
		/* found word */
		SE_PlaySound(wordHitSound);
		correct++;
		total++;
		stateChanged = 1;
		running      = 0;
	}

	if(numberNooses == numberGuesses) {
		/* out of guesses */
		SE_PlaySound(wordMissSound);
		showWord();
		total++;
		running      = 0;
		stateChanged = 1;
		numberNooses = 0;
	}
}

/*****************************************************
 ****************************************************/
inline void SE_CheckEvents()
{
	SDL_Event event;
	int x, y, i;
	char temp[64];

	if(stateChanged)
		SE_Redraw();

	if(SDL_PollEvent(&event)) {
		struct SE_Button * head;
		switch (event.type) {
		case SDL_QUIT:
			quit();
			break;
		case SDL_KEYDOWN:
			SDL_ShowCursor(0);
			if(!running) {
				switch(event.key.keysym.sym) {
				case SDLK_f:
					SDL_WM_ToggleFullScreen(screen);
					break;
				case SDLK_h:
					help();
					break;
				case SDLK_q:
					quit();
					break;
				case SDLK_s:
					SE_PlaySound(clickSound);
					start();
					break;
				case SDLK_v:
					SE_AdjustSoundLevel();
					SE_PlaySound(clickSound);
					stateChanged = 1;
					break;
				case SDLK_UP:
					numberGuesses++;
					if(numberGuesses > 12)
						numberGuesses = 12;
					
					SE_Redraw();
					sprintf(temp, "Raised number of misses to %d.", numberGuesses);
					SE_Print(-1, 70, temp, black, font2, screen, 0);
					break;
				case SDLK_DOWN:
					numberGuesses--;
					if(numberGuesses < 3)
						numberGuesses = 3;
				
					SE_Redraw();
					sprintf(temp, "Lowered number of misses to %d.", numberGuesses);
					SE_Print(-1, 70, temp, black, font2, screen, 0);
					break;
				}
			}

			/* key shortcuts while guessing word */
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
				checkLetter(event.key.keysym.sym);
				break;
			case SDLK_F1:
				SDL_WM_ToggleFullScreen(screen);
				break;
			case SDLK_ESCAPE:
				quit();
				break;
			}
			
		case SDL_MOUSEBUTTONDOWN:
			x = event.button.x;
			y = event.button.y;

			for(head = se_buttonList; head; head = head->next) {
				if(x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					if(!*head->cond) {
						SE_PlaySound(clickSound);
						head->handle();
						return;
					}
				}
			}
			
			/* Check if a letter is clicked */
			if(y > 406 && y < 444) {
				for(i = 0; i < 8; i++) {
					if(x > letters[i].x && x < letters[i].x + 30)
						checkLetter(i + 'a');
				}
			}

			else if(y > 456 && y < 494) {
				for(i = 8; i < 17; i++) {
					if(x > letters[i].x && x < letters[i].x + 30)
						checkLetter(i + 'a');
				}
			}

			else if(y > 506 && y < 544) {
				for(i = 17; i < 26; i++) {
					if(x > letters[i].x && x < letters[i].x + 30)
						checkLetter(i + 'a');
				}
			}

			/* Check if sound icon clicked */
			else if(x > SE_GetSoundX() && x < SE_GetSoundX() + ICON_SIZE &&
				y > SE_GetSoundY() && y < SE_GetSoundY() + ICON_SIZE) {
				SE_PlaySound(clickSound);
				SE_AdjustSoundLevel();
				stateChanged = 1;
			}
			else if(y > ICON_Y && x < ICON_W) {
				SE_LogoClicked();
			}
			break;
		case SDL_MOUSEMOTION:
			x = event.motion.x;
			y = event.motion.y;

			SDL_ShowCursor(1);

			/* Check if over SG icon */
			if(y > ICON_Y && x < ICON_W) {
				SDL_SetCursor(SE_GetHandCursor());
			}
			
			/* Check if over sound icon */
			else if(x > SE_GetSoundX() - 5 && x < SE_GetSoundX() + ICON_SIZE - 15 &&
				y > SE_GetSoundY() - 2 && y < SE_GetSoundY() + ICON_SIZE - 15) {
				SDL_SetCursor(SE_GetHandCursor());
			}

			/* check if moved onto a button */
			for(head = se_buttonList; head; head = head->next) {
				if(!(*head->cond) && x > head->x && x < (head->x + head->w) &&
				   y > head->y && y < (head->y + head->h)) {
					if(head->over == 0) {
						head->over = 1;
						SE_PlaySound(overSound);
						SDL_SetCursor(SE_GetHandCursor());
						drawText(head->x, head->y, head->name, head->over);
					}
					return;
				}
			}

			/* Check if moved off a button */
			for(head = se_buttonList; head; head = head->next) {
				if(head->over == 1) {
					head->over = 0;
					if(!(*head->cond)) {
						drawText(head->x, head->y, head->name, head->over);
						SDL_SetCursor(SE_GetArrowCursor());
					}
					return;
				}
			}
				
			/* Not over anything so make sure the arrow is showing */
			SDL_SetCursor(SE_GetArrowCursor());
			break;
		}
	}
}


/*****************************************************
 ****************************************************/
int main(int argc, char * argv[])
{
	int i, x, minx, maxx, miny, maxy, advance;
	SDL_Rect dest;

	/* Check for arguments */
	if(argc != 1) {
		if(strcmp(argv[1], "-d") == 0)
			strncpy(dictionary, argv[2], 511);
	}
	else
		strcpy(dictionary, "/usr/share/dict/words");

	/* Set up and intialize SDL */
	SE_SetName("Hangman 0.9.2");
	SE_SetBackground("pics/background.png");
	SE_SetSoundX(770);
	SE_SetSoundY(10);

	if(SE_Init() != 0)
		SE_Quit();

	/* show background, there is a pause when building the dictionary */
	SDL_BlitSurface(background2, 0, screen, 0);
	SDL_UpdateRect(screen, 0, 0, 0, 0);

	/* Load fonts */
	font  = SE_LoadFont("fonts/washing.ttf", 40);
	font2 = SE_LoadFont("fonts/washing.ttf", 44);
	font3 = SE_LoadFont("fonts/washing.ttf", 80);

	/* Load images */
	noose       = SE_LoadPNG("pics/noose.png");
	background2 = SE_LoadPNGDisplay("pics/background2.png");

	/* Load sound effects */
	clickSound        = SE_LoadSound("sounds/click.ogg");
	overSound         = SE_LoadSound("sounds/over.ogg");
	wordMissSound     = SE_LoadSound("sounds/wordMissSound.ogg");
	wordHitSound      = SE_LoadSound("sounds/wordHitSound.ogg");
	nooseDropSound    = SE_LoadSound("sounds/nooseDropSound.ogg");
	letterSelectSound = SE_LoadSound("sounds/letterSelectSound.ogg");

	/* Register used buttons */
	SE_RegisterButton("Help",  HELP_X,  HELP_Y,  HELP_W,  HELP_H,  &running, help);
	SE_RegisterButton("Quit",  QUIT_X,  QUIT_Y,  QUIT_W,  QUIT_H,  &se_true, quit);
	SE_RegisterButton("Start", START_X, START_Y, START_W, START_H, &running, start);

	/* Set up location (x and y values) of the clickable letters */
	/* a through h */
	x = 247;
	for(i = 0; i < 8; i++) {
		letters[i].x     = x;
		letters[i].y     = 400;
		letters[i].tried = 0;
		TTF_GlyphMetrics(font2, i + 'A', &minx, &maxx, &miny, &maxy, &advance);
		x += advance + 11;
	}

	/* i through q */
	x = 239;
	for(i = 8; i < 17; i++) {
		letters[i].x     = x;
		letters[i].y     = 450;
		letters[i].tried = 0;
		TTF_GlyphMetrics(font2, i + 'A', &minx, &maxx, &miny, &maxy, &advance);
		x += advance + 11;
	}
	
	/* r through z */
	x = 226;
	for(i = 17; i < 26; i++) {
		letters[i].x     = x;
		letters[i].y     = 500;
		letters[i].tried = 0;
		TTF_GlyphMetrics(font2, i + 'A', &minx, &maxx, &miny, &maxy, &advance);
		x += advance + 11;
	}
	
	initDictionary(dictionary);

	/* Introduction fade */
	/* Causes some stutter in events becuase there
	   are so many updates??? */
	for(i = 0; i < 255; i += 5) {
		SE_CheckEvents();
		SDL_BlitSurface(background2, 0, screen, 0);
		SDL_SetAlpha(background, SDL_SRCALPHA, i);
		SDL_BlitSurface(background, 0, screen, 0);
		SE_ShowIcon();
		SDL_UpdateRect(screen, 0, 0, 0, 0);
	}
	SDL_SetAlpha(background, SDL_SRCALPHA, 255);
	SDL_BlitSurface(background, 0, screen, 0);
	SDL_UpdateRect(screen, 0, 0, 0, 0);
	SDL_FreeSurface(background2);

	fprintf(stdout, "Initialization Complete. Starting game.\n");
	
	/* Set initial game variables */
	total        = 0;
	correct      = 0;
	stateChanged = 1;

	printf("running = %d\n", running);
	SE_GameLoop();

	SE_Quit();
}

