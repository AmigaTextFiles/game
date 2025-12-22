/*
    C-Dogs SDL
    A port of the legendary (and fun) action/arcade cdogs.
    Copyright (C) 1995 Ronny Webster
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

 menu.h - <description here>
 
 Author: $Author: lmartinking $
 Rev:    $Revision: 60 $
 URL:    $HeadURL: svn://svn.icculus.org/cdogs-sdl/tags/cdogs-sdl-0.3/src/include/menu.h $
 ID:     $Id: menu.h 60 2006-08-14 07:30:38Z lmartinking $
 
*/

void ShowControls(void);
void DisplayMenuItem(int x, int y, const char *s, int selected);
void DisplayMenu(int x, const char **table, int count, int index);
