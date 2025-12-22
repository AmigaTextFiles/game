/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef LEVEL_FILE_H
#define LEVEL_FILE_H

# include <stdio.h>
# include <sys/types.h>
# include <sys/stat.h>
#ifndef WIN32
	# include <pwd.h>
#endif
# include "Sother.h"
# include "Splayer.h"

/* fichiers niveaux */
typedef struct{
	char level_name[128];
	char author_name[128];
	char music_file[128];
	char background[128];
	char wall_gfx_dir[128];
#define FRGRND_NONE	0
#define FRGRND_CLOUDS	1
#define FRGRND_RAIN	2
#define FRGRND_NIGHT	3
	char foreground;
	int time_limit;
	int autoscroll; /* auto scrolling speed (0=noauto) */
}level_info;

int load_levelinfos(char* file, level_info * infos);
int load_levelfile(char* file, myList ** sp_wall_list, myList ** sp_sprite_list, myList ** sp_foreground_list);
int save_levelfile(char* file, myList * sp_list, level_info infos);

/* fichiers worldmap */
typedef struct
{	char world_name[128];
	char music_file[128];
	char next_world[128];
	char backgrnd_image[128];
}worldmap;

typedef enum {CLOSE,OPEN,DONE} statuslevel;
typedef struct
{	unsigned int level_id;
	char level_name[128];
	char fic_name[128];
	unsigned int posX, posY;
	unsigned int move_up,move_down,move_left,move_right;
	statuslevel level_status;
}level_desc;

level_desc * GetPosListById(myList * list,unsigned int id);

int load_worldfile(char* file, myList ** lvl_list, worldmap * infos);

#define APP_NAME  ".MoleInvasion"
#define SAVE_FILE "save_game"

/* fichiers de sauvegarde */
statuslevel read_level_status(myList * open_list, worldmap world, level_desc level);

int is_level_in_open_list(myList * lvl_list, worldmap world, level_desc level);

int load_all_open_levels(myList * open_level_list);

int save_all_open_levels(myList * lvl_list, worldmap world,myList * open_list);

#endif
