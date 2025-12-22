/*

	SnakeMe 1.0 GPL
	Copyright (C) 2000 Stephane Magnenat/Ysagoon

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/


#ifndef __SNAKEME_H
#define __SNAKEME_H

// version file
#include "smver.h"
#include "SDL.h"

//#define NOSOUND

#ifndef HIWORD
//#define HIWORD(l)   ((WORD) (((DWORD) (l) >> 16) & 0xFFFF)) 
#endif
#ifndef LOWORD
//#define LOWORD(l)   ((WORD) (l)) 
#endif

typedef struct
{
	SDLKey Aright;
	SDLKey Aup;
	SDLKey Aleft;
	SDLKey Adown;
	SDLKey Rright;
	SDLKey Rleft;
	SDLKey Uaction;
} SButtonMap;

typedef struct
{
	int speed;

	int deflng;
	int inclng;

	int nbmeal;
	int mealchangetime;
	int nbbonus;
	int bonuschangetime;
	
	int maxpoint;
	int ptgetmeal;
	int ptgethit;
	int ptgetsnake;
	int ptloosecrash;
	int ptloosehit;
} SAdvancedOptions;

#endif
