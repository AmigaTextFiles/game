/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef FONT_H
#define FONT_H

////#define FONT_NAME  "font/Anke_Print.ttf"
//#define FONT_NAME  "font/babelfish.ttf"
//#define FONT_NAME  "font/betadance.ttf"
//#define FONT_NAME  "font/flubber.ttf"
//#define FONT_NAME  "font/jenkins.ttf"
#define FONT_NAME  "font/Minv.ttf"

#include <locale.h>
#include "sprite.h"
#include "SDL_ttf.h"

int font_init();

TTF_Font * font_select(char * file_ttf,int size, SDL_Color fg, SDL_Color bg, Uint8 alpha);

mySprite font_text(char * txt,int x, int y);

mySprite font_long_text(char * id,int x, int y);

int font_render_integer(unsigned int value,int x, int y);

#endif
