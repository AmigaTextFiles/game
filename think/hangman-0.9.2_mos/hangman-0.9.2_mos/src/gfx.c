/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: gfx.c
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

#ifndef sg_data_path
#define sg_data_path ""
#endif

/*****************************************************
 ****************************************************/
SDL_Surface * SE_LoadPNG(const char * name)
{
	SDL_Surface * temp = NULL;
	int len1 = strlen(sg_data_path), len2 = strlen(name);

	char * newname = (char*)malloc(len1 + len2 + 1);
	if(!newname) {
		SE_Error("Out of memory.");
		SE_Quit();
	}

	strcpy(newname, sg_data_path);
	strcat(newname, name);

	temp = IMG_Load(newname);
	if (temp == NULL) {
		SE_Error("Unable to load: %s", newname);
		free(newname);
		SE_Quit();
	}

	free(newname);
	return temp;
}

/*****************************************************
 ****************************************************/
SDL_Surface * SE_LoadPNGDisplay(const char * name)
{
	SDL_Surface * temp = NULL, * temp2 = NULL;
	int len1 = strlen(sg_data_path);
	int len2 = strlen(name);

	char * newname = (char*)malloc(len1 + len2 + 1);
	if(!newname) {
		SE_Error("Out of memory.");
		SE_Quit();
	}

	strcpy(newname, sg_data_path);
	strcat(newname, name);

	temp = IMG_Load(newname);
	if (temp == NULL) {
		SE_Error("Unable to load: %s", newname);
		free(newname);
		exit(1);
	}

	free(newname);

	temp2 = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);

	return temp2;
}

/*****************************************************
 ****************************************************/
TTF_Font * SE_LoadFont(const char * name, const int size)
{
	TTF_Font * temp = NULL;
	int len1 = strlen(sg_data_path);
	int len2 = strlen(name);

	char * newname = (char*)malloc(len1 + len2 + 1);
	if(!newname) {
		SE_Error("Out of memory.");
		SE_Quit();
	}

	strcpy(newname, sg_data_path);
	strcat(newname, name);

	temp = TTF_OpenFont(newname, size);
	if (temp == NULL) {
		SE_Error("Unable to load: %s", newname);
		free(newname);
		SE_Quit();
	}

	free(newname);
	return temp;
}
