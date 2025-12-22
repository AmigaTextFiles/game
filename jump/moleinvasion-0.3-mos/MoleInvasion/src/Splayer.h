/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef SPLAYER_H
#define SPLAYER_H

# include "sprite.h"

char initPlayer(mySprite * player);
int performPlayer(mySprite *player,myList * level_walls,myList * level_sprites);

#endif
