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

#ifndef __PASSWORD_H__
#define __PASSWORD_H__

int password_initialize(SDL_Surface* screen);
int password_uninitialize(SDL_Surface* screen);
int password_render(SDL_Surface* screen);
int password_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key);
const char* password_get_level_password(int level);

#endif /* __PASSWORD_H__ */
