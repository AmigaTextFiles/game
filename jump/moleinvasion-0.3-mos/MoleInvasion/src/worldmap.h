/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef WORLDMAP_H
#define WORLDMAP_H

#include "level.h"
#include "level_file.h"

typedef struct
{	unsigned int X,Y;
}road_element;

/* retourne 0 si le niveau est fini gagnant */
int main_worlmap(char * level_file_name, int show_FPS);

/* on stocke ici toutes les datas evoluant relatives au monde en cours */
#ifdef MAIN_WORLDMAP
#define EXTERN_WLD extern
#else
#define EXTERN_WLD
#endif

EXTERN_WLD struct {
	/* combinaison de player */
	unsigned int combi;
	unsigned int coins;
} static_world_datas;

#endif
