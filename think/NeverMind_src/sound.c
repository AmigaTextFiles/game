/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
/* This program loads a module, and plays it. Uses medplayer.library, and
   was modified to fit NeverMind :) */
#include <exec/types.h>
#include <libraries/dos.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <stdio.h>
#include "libproto.h"
#include "proplayer.h"
#include "sound.h"
#include "setup.h"

struct MMD0 *sng=NULL;
int nm_music=1;

void nmplaysong(void)
{
	long count,midi = 0;

	sng = LoadModule("data/mod.Never_Surrender");
	if(!sng)	endmessage("Can't load data/mod.Never_Surrender");
		
	for(count = 0; count < 63; count++)
	if(sng->song->sample[count].midich) midi = 1;
	if(GetPlayer(midi))
	{
		printf("Resource allocation failed.\n");
		nmstopsong(); return;
	}
	PlayModule(sng);
	nm_music=1;
}

void nmstopsong(void)
{
	FreePlayer();
	if(sng) UnLoadModule(sng);
	nm_music=0;
}
