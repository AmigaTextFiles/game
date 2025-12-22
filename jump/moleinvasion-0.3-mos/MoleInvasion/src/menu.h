/* MoleInvasion 0.3 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.\n"); */

#ifndef MENU_H
#define MENU_H

#include "editor_texts.h"
#include "events.h"
#include "font.h"
#include "level.h"
#include "edit_keys.h"

/* used for init the graphics functions */
#define DO_INIT	0
#define DO_DRAW 1
#define DO_FREE 2
mySprite * draw_backgrnd(char action, void * element);

int main_menu(Uint8 show_FPS,char ** worldname);

#endif
