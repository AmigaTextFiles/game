/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: ShiftyEngine.c
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

#include "SDL_mixer.h"
#include "SDL_image.h"
#include "SDL_ttf.h"
#include "SDL.h"

#include <stdarg.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "ShiftyEngine.h"

SDL_Surface * screen       = 0;
SDL_Surface * background   = 0;
SDL_Surface * soundControl = 0;

static char * gameName;
static char * backgroundName;
static char * fontName;
static int fontSize;
int volume = 230;

TTF_Font * mainFont;

struct SE_Button * se_buttonList = 0;
int se_true = 0;
int se_false = 1;

extern void SE_CheckEvents();

int SOUND_X = 0;
int SOUND_Y = 0;

/*****************************************************
 ****************************************************/
void SE_SetName(char * name)
{
	int len = strlen(name);
	assert(name);

	gameName = (char *)malloc((sizeof(char) * len) + 1);
	if(!gameName) {
		fprintf(stderr, "Out Of Memory.");
		exit(1);
	}

	strncpy(gameName, name, len);
}

/*****************************************************
 ****************************************************/
void SE_Quit()
{
        SDL_FreeSurface(screen);
        SDL_FreeSurface(background);

        exit(1);
}

/*****************************************************
 ****************************************************/
void SE_SetBackground(char * name)
{
	int len = strlen(name);
	assert(name);

	backgroundName = (char *)malloc((sizeof(char) * len) + 1);
	if(!backgroundName) {
		fprintf(stderr, "Out Of Memory.");
		exit(1);
	}

#ifdef __MORPHOS__
	strcpy(backgroundName, name);
#else
	strncpy(backgroundName, name, len);
#endif
}

/*****************************************************
 ****************************************************/
int SE_Init()
{
#ifndef __MORPHOS__
	putenv("SDL_VIDEO_CENTERED=1");
#endif

	/* Init the system */
	fprintf(stdout, "Initiating SDL...\n");
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER ) != 0) {
		fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
		return 1;
	}

	fprintf(stdout, "Initiating Audio Mixer...\n");
	initMixer();

	SDL_WM_SetCaption(gameName, gameName);

	if(TTF_Init() < 0) {
		fprintf(stderr, "TTF_Init: %s\n", TTF_GetError());
		return 2;
	}

	screen = SDL_SetVideoMode(800, 600, 32, SDL_ANYFORMAT);
	if (screen == NULL) {
		fprintf(stderr, "Unable to set video mode: %s\n", SDL_GetError());
		return 1;
	}

#ifdef __MORPHOS__
	srand(time(0));
#else
	srandom(time(0));
#endif

	atexit(TTF_Quit);
	atexit(SDL_Quit);

	initLogo(screen);

	soundControl = loadPNG("pics/sound_high.png");
	setVolume(volume);

	background = loadPNGDisplay(backgroundName);

	return 0;
}


/*****************************************************
 ****************************************************/
void SE_Error(char * fmt, ...) 
{
	va_list ap;
	int i;
	char buf[1024];
	
	va_start(ap, fmt);
	i = vsprintf(buf, fmt, ap);
	va_end(ap);
	
	fprintf(stderr, "ShiftyEngine Error: %s\n", buf);
}

/*****************************************************
 ****************************************************/
void SE_GameLoop() 
{
	while(1) 
		SE_CheckEvents();
}


/*****************************************************
 ****************************************************/
void SE_RegisterButton(char * name, int x, int y, int w, int h, int * cond, void (*handle)())
{
	struct SE_Button * ph, * head, * t = (struct SE_Button *)malloc(sizeof(struct SE_Button));
	if(t == NULL) {
		fprintf(stderr, "Out of Memory.");
		exit(1);
	}

	strncpy(t->name, name, 16);
	t->x = x;
	t->y = y;
	t->w = w;
	t->h = h;
	t->handle = handle;
	t->over = 0;
	t->cond = cond;
	t->next = NULL;

	if(!se_buttonList) {
		se_buttonList = t;
		return;
	}

	head = se_buttonList;
	while(head) {
		ph = head;
		head = head->next;
	}

	ph->next = t;
}

/*****************************************************
 ****************************************************/
void SE_AdjustSoundLevel()
{
	SDL_FreeSurface(soundControl);

	switch(volume) {
	case 230:
		volume = 50;
		soundControl = loadPNG("pics/sound_medium.png");
		break;
	case 50:
		volume = 1;
		soundControl = loadPNG("pics/sound_low.png");
		break;
	case 1:
		volume = 230;
		soundControl = loadPNG("pics/sound_high.png");
		break;
	}

	setVolume(volume);
}


/*****************************************************
 ****************************************************/
void SE_ShowSoundIcon() 
{
	SDL_Rect dest;

	dest.x = SOUND_X;
	dest.y = SOUND_Y;
	if(SDL_BlitSurface(soundControl, 0, screen, &dest) != 0)
		SE_Error("A blit failed.");
}
