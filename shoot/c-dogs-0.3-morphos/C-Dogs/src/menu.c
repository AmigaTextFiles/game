/*
    C-Dogs SDL
    A port of the legendary (and fun) action/arcade cdogs.
    Copyright (C) 1995 Ronny Wester
    Copyright (C) 2003 Jeremy Chin 
    Copyright (C) 2003 Lucas Martin-King 

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

-------------------------------------------------------------------------------

 menu.c - menu misc functions 
 
 Author: $Author: lmartinking $
 Rev:    $Revision: 61 $
 URL:    $HeadURL: svn://svn.icculus.org/cdogs-sdl/tags/cdogs-sdl-0.3/src/menu.c $
 ID:     $Id: menu.c 61 2006-08-14 07:35:20Z lmartinking $
 
*/

#include "grafx.h"
#include "text.h"
#include "actors.h"


void ShowControls(void)
{
	TextStringAt(50, 190, "(use player 1 controls or arrow keys + Enter/Backspace)");
}

void DisplayMenuItem(int x, int y, const char *s, int selected)
{
	if (selected)
		TextStringWithTableAt(x, y, s, tableFlamed);
	else
		TextStringAt(x, y, s);
		
	return;
}

#define MENU_OFFSET_Y	50

void DisplayMenu(int x, const char **table, int count, int index)
{
	int i;

	for (i = 0; i < count; i++) {
		DisplayMenuItem(x, MENU_OFFSET_Y + i * TextHeight(), table[i], i == index);
	}
	
	return;
}
