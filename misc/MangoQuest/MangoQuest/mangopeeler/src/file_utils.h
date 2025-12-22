/*  The Blue Mango Quest
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifndef _FILE_UTILS_H
#define _FILE_UTILS_H

#define BUILTIN_MAPS SHXMAN_DATA "maps/"

#ifdef WIN32 
#  define CONFIG_DIR "."
#  define CUSTOM_MAPS_DIR "customs"
#  define CONFIG_FILE "mangopeeler.ini"
#else
#  define CONFIG_DIR ".mangoquest"
#  define CUSTOM_MAPS_DIR ".mangoquest"
#  define CONFIG_FILE "editor_options"
#endif /* WIN32 */

#ifndef MAX_PATH
#  define MAX_PATH 4096
#endif

#define MAX_FILE_NAME 256

int get_private_dir_name( char *buff, int len );
int get_private_map_file_name( char *buff, char *map_name, int len );
int search_map_file(char *buff, char *map_name, int len);
void convert_path( char *new_path, char *orig_path ) ;
char dir_exists( char *dirname );
void check_private_dir();
int file_exists(char *filename);

int get_config_file_name( char *buff, int len);
FILE * open_config_file(char *flags);
#endif
