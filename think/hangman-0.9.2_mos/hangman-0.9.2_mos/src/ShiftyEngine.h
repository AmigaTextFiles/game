/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: ShiftyEngine.h
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

#ifndef __SHIFTYENGINE__H__
#define __SHIFTYENGINE__H__

#define SE_VERSION 0.2

#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <ctype.h>

//#include "SDL_rotozoom.h"
#include "SDL_image.h"
#include "SDL_mixer.h"
#include "SDL_ttf.h"
#include "SDL.h"

#include "pointer.h"
#include "sound.h"
#include "logo.h"
#include "gfx.h"

#define WIDTH     800
#define HEIGHT    600

extern SDL_Surface * screen;
extern SDL_Surface * background;

struct SE_Button {
	char name[16];
	int x, y, w, h;
	void (*handle)();
	char over;
	int * cond;
	struct SE_Button * next;
};

extern struct SE_Button * se_buttonList;
extern int se_true;
extern int volume;

int  SE_Init             ();
void SE_Quit             ();

void SE_SetBackground    (char * filename);
void SE_SetName          (char * name);

//void SE_CheckEvents      ();
void SE_GameLoop         ();
void SE_Print            (int x, int y, char * text, SDL_Color color, TTF_Font * font, 
			  SDL_Surface * surface, int clear);
void SE_RegisterButton   (char * name, int x, int y, int w, int h, int * cond, void (*handler)());
//void SE_UnregisterButton (char * name);

void SE_AdjustSoundLevel ();
void SE_ShowSoundIcon    ();
void SE_SetSoundX        (int x);
void SE_SetSoundY        (int y);
int  SE_GetSoundX        ();
int  SE_GetSoundY        ();

void SE_Error            (char * fmt, ...);

#endif


