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

SDL_Surface * screen       = NULL;
SDL_Surface * background   = NULL;
SDL_Surface * soundControl = NULL;

static char * gameName       = NULL;
static char * backgroundName = NULL;

int volume         = 230;
static int sound_x = 0;
static int sound_y = 0;

struct SE_Button * se_buttonList = 0;
int se_true  = 0;
int se_false = 1;

extern void SE_CheckEvents();

/*****************************************************
 ****************************************************/
void SE_SetName(char * name)
{
	int len = strlen(name);
	assert(name);

	gameName = (char *)malloc((sizeof(char) * len) + 1);
	if(!gameName) {
		SE_Error("Out Of Memory.");
		SE_Quit();
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
	assert(len >= 1);

	backgroundName = (char *)malloc((sizeof(char) * len) + 1);
	if(!backgroundName) {
		SE_Error("Out Of Memory.");
		SE_Quit();
	}

	strncpy(backgroundName, name, len);
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
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) != 0) {
		fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
		return 1;
	}

	fprintf(stdout, "Initiating Audio Mixer...\n");
	SE_InitMixer();

	SDL_WM_SetCaption(gameName, gameName);

	if(TTF_Init() < 0) {
		fprintf(stderr, "TTF_Init: %s\n", TTF_GetError());
		return 2;
	}

	screen = SDL_SetVideoMode(800, 600, 32, SDL_ANYFORMAT);
	if (screen == NULL) {
		SE_Error("Unable to set video mode: %s\n", SDL_GetError());
		return 1;
	}

#ifndef __MORPHOS__
	srandom(time(0));
#else
	srand(time(0));
#endif

	atexit(TTF_Quit);
	atexit(SDL_Quit);

	SE_InitLogo(screen);

	soundControl = SE_LoadPNG("pics/sound_high.png");
	SE_SetVolume(volume);

#ifndef __MORPHOS__
	background = SE_LoadPNGDisplay(backgroundName);
#else
	background = SE_LoadPNGDisplay("pics/background.png");
#endif

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
	struct SE_Button * ph = NULL, * head = NULL, * t = (struct SE_Button *)malloc(sizeof(struct SE_Button));
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
		soundControl = SE_LoadPNG("pics/sound_medium.png");
		break;
	case 50:
		volume = 1;
		soundControl = SE_LoadPNG("pics/sound_low.png");
		break;
	case 1:
		volume = 230;
		soundControl = SE_LoadPNG("pics/sound_high.png");
		break;
	}

	SE_SetVolume(volume);
}


/*****************************************************
 ****************************************************/
void SE_ShowSoundIcon() 
{
	SDL_Rect dest;

	dest.x = sound_x;
	dest.y = sound_y;
	if(SDL_BlitSurface(soundControl, 0, screen, &dest) != 0)
		SE_Error("A blit failed.");
}

/*****************************************************
 ****************************************************/
void SE_Print(int x, int y, char * str, SDL_Color color, TTF_Font * font, SDL_Surface * surface, int clear)
{
	SDL_Rect dest;
	SDL_Surface * text = NULL;

	text = TTF_RenderText_Blended(font, str, color);
	if(!text)
		printf("Text render failed!\n");

	if(x == -1)
		dest.x = (surface->w/2) - (text->w/2); 
	else
		dest.x = x; 

	if(y == -1)
		dest.y = (surface->h/2) - (text->h/2); 
	else
		dest.y = y;

	dest.h = text->h;
	dest.w = text->w;

	if(clear)
		SDL_BlitSurface(background, &dest, surface, &dest);


	SDL_BlitSurface(text, 0, surface, &dest);
	SDL_UpdateRect(surface, dest.x, dest.y, text->w, text->h);

	SDL_FreeSurface(text);
}

/*****************************************************
 ****************************************************/
void SE_SetSoundX(int x)
{
	sound_x = x;
}

/*****************************************************
 ****************************************************/
void SE_SetSoundY(int y)
{
	sound_y = y;
}

/*****************************************************
 ****************************************************/
int SE_GetSoundX()
{
	return sound_x;
}

/*****************************************************
 ****************************************************/
int SE_GetSoundY()
{
	return sound_y;
}
