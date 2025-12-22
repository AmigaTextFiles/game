/*

Mures
Copyright (C) 2001 Adam D'Angelo

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

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#include "game.h"
#include "go_sdl.h"
#include "go_gl.h"

void game_output_init(game *g, int type)
{
  switch(type) {
  case SDL:
    go_sdl_init(g);
    break;
  case GL:
#ifdef HAVE_GL
    go_gl_init(g);
#else
    fprintf(stderr, "Trying to use GL game output without GL compiled in!");
    exit(1);
#endif
    break;
  }
}

