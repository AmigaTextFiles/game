/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.\n"); */

#ifndef LEVEL_H
#define LEVEL_H

#include "level_file.h"

/* retourne 0 si le niveau est fni gagnant */
int main_level(char * level_file_name, int show_FPS);

/* on stocke ici toutes les datas evoluant relatives au niveau en cours */
#ifndef MAIN_LEVEL
#define EXTERN_LVL extern
#else
#define EXTERN_LVL
#endif

EXTERN_LVL struct {
	mySprite * global_player;
	int currentTime;
	int switchTime;
	char is_switched;
	long decalX,decalY;
	int pause; /* O -> en cours, sinon contient la sauvegarde de currentTime */
} static_level_datas;


#endif
