/***************************************************************************
 *   Copyright (C) 2005 by Berislav Kovacki                                *
 *   beca@sezampro.yu                                                      *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#ifndef _MAINMENU_H_
#define _MAINMENU_H_

#define MAINMENU_STARTGAME 0
#define MAINMENU_PASSWORD  1
#define MAINMENU_CREDITS   2
#define MAINMENU_EXITGAME  3

int mainmenu_initialize(SDL_Surface* screen);
int mainmenu_uninitialize(SDL_Surface* screen);
int mainmenu_render(SDL_Surface* screen);
int mainmenu_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key);

#endif /* _MAINMENU_H_ */
