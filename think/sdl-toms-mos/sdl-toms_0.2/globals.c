/* ==== globals.c ==== */
/*  Part of the source of the program "SDL-Toms", a puzzle game.
    Copyright (C) 2002-2003  Tom Barnes-Lawrence
    Current web address: www.angelfire.com/super2/duologue/#sdl-toms
    Current email address: tomble@usermail.com

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
 */



#include "sdl-toms.h"

int cells[160];
int pcell[160];

int players=2;
int in_game[5]; /* Don't use player 0 */

double gamma=2.4;
int fullscreen=0;
