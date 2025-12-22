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


/* Some parts of these functions have been taken from Tux Racer */

#ifdef WIN32
#include <windows.h>
#endif
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include <stdarg.h>
#include <sys/stat.h>
#include <limits.h>

#ifndef WIN32
#   include <unistd.h>
#   include <sys/types.h>
#   include <pwd.h>
#   include <dirent.h>
#   include <sys/time.h>
#   include <sys/types.h>
#   include <dirent.h>
#   include <errno.h>
#else
#   include "shxedit_win32.h"
#endif

#include "file_utils.h"


int get_private_dir_name( char *buff, int len )
{
#if defined( WIN32 ) 
    if ( strlen( CUSTOM_MAPS_DIR ) +1 > (unsigned)len ) {
	return 1;
    }
    strcpy( buff, CUSTOM_MAPS_DIR );
    return 0;
#else
    struct passwd *pwent;

    pwent = getpwuid( getuid() );
    if ( pwent == NULL ) {
	perror( "getpwuid" );
	return 1;
    }

    if ( strlen( pwent->pw_dir ) + strlen( CUSTOM_MAPS_DIR) + 2 > (unsigned)len ) {
	return 1;
    }

    sprintf( buff, "%s/%s", pwent->pw_dir, CUSTOM_MAPS_DIR );
    return 0;
#endif /* defined( WIN32 ) */
}

int get_private_map_file_name( char *buff, char *map_name, int len )
{
    if (get_private_dir_name( buff, len ) != 0) {
	return 1;
    }
    if ( strlen( buff ) + strlen( "maps" ) +4+ strlen( map_name )> (unsigned)len ) {
	return 1;
    }

#if defined( WIN32 ) 
    strcat( buff, "\\" );
#else
    strcat( buff, "/" );
#endif /* defined( WIN32 ) */

    strcat( buff, "maps");

#if defined( WIN32 ) 
    strcat( buff, "\\" );
#else
    strcat( buff, "/" );
#endif /* defined( WIN32 ) */

    strcat( buff, map_name);
    return 0;
}

int search_map_file(char *buff, char *map_name, int len)
{
  char *search_buff = 0;
  char *map_name_bmq = 0;

  search_buff = (char *)calloc(len, sizeof(char));
  memset (buff,0,(len-1)*sizeof(char));
  memset (search_buff,0,(len-1)*sizeof(char));

  // we first search using the given filename

  int tFichier = strlen(map_name);
  if ((map_name[tFichier - 1] == 'q') && (map_name[tFichier - 2] == 'm')
      && (map_name[tFichier - 3] == 'b') && (map_name[tFichier - 4] == '.'))
    {
      map_name_bmq = (char *)calloc(tFichier, sizeof(char));
      strncpy(map_name_bmq, map_name, tFichier);
    }

  else {
    map_name_bmq = (char *)calloc(tFichier+5, sizeof(char));
    strncpy(map_name_bmq, map_name, tFichier);
    map_name_bmq[tFichier+4]='\0';
    map_name_bmq[tFichier+3]='q';
    map_name_bmq[tFichier+2]='m';
    map_name_bmq[tFichier+1]='b';
    map_name_bmq[tFichier]='.';

    printf("File name is now %s\n",map_name_bmq);
    //strncpy(map_name, map_name_bmq, tFichier);
  }

 // map_name = map_name_bmq;

  printf("looking for %s\n", map_name_bmq);

  printf("  using specified path...");
  if (file_exists (map_name_bmq)) 
    {
      printf(" found.\n");
      strncpy(buff, map_name_bmq, len);
      return 0;
    }
  else printf(" not found.\n");

  // then we search in user's private maps directory
  get_private_map_file_name(search_buff, map_name_bmq, MAX_PATH);
  printf("  for %s ...", search_buff);
  if (file_exists (search_buff)) 
    {
      printf(" found.\n");
      strncpy(buff, search_buff, len);
      return 0;
    }
  else printf(" not found.\n");

  // we have found nothing
  printf("File does not exist.\n  We'll use %s for saving your new map.\n", search_buff);
  strncpy(buff, search_buff, len);
  return 0;
}

char dir_exists( char *dirname )
{
#if defined( WIN32 ) && !defined( __CYGWIN__ )

    /* Win32 */

    //char curdir[MAX_PATH];
    //char dir_exists = 0;

    /*if ( getcwd( curdir, MAX_PATH - 1 ) == NULL ) {
      exit(1);
    }

    if ( chdir( dirname ) == -1 ) {
	return False;
    }

    if ( chdir( curdir ) == -1 ) {
      exit(1);
    }*/
    return 1;

#else

    /* Unix/Linux/Cygwin */

    char *dir_copy =0;
    dir_copy = (char *)calloc(MAX_PATH, sizeof(char));
    DIR *d;

    convert_path( dir_copy, dirname );

    if ( ( d = opendir( dir_copy ) ) == NULL ) {
	return ((errno != ENOENT) && (errno != ENOTDIR));
    } 

    if ( closedir( d ) != 0 ) {
      exit(1);
    }

    return 1;

#endif /* defined( WIN32 ) && !defined( __CYGWIN__ ) */
}

void convert_path( char *new_path, char *orig_path ) 
{
#if defined( __CYGWIN__ )
    cygwin_conv_to_posix_path( orig_path, new_path );
#else
    strcpy( new_path, orig_path );
#endif /* defined( __CYGWIN__ ) */
}

void check_private_dir()
{
#ifndef WIN32
  char *config_dir=0;
  config_dir = (char *)calloc(MAX_PATH, sizeof(char));

  if ( get_private_dir_name( config_dir, sizeof( config_dir ) ) != 0 ) {
    return;
  }
  
  if ( !dir_exists( config_dir ) ) {
    if (mkdir( config_dir, 0775) != 0) {
      return;
	}
  }

    strcat( config_dir, "/" );
    strcat( config_dir, "maps");
    strcat( config_dir, "/" );

  if ( !dir_exists( config_dir ) ) {
    
    if (mkdir( config_dir, 0775) != 0) {
      return;
    }
    
  } 
#endif
  
}

int file_exists(char *filename)
{
  FILE *testFile;

  if (!(testFile = fopen(filename, "rb")))
  {
    return 0;
  }
  else
  {
    if (fclose(testFile) != 0)
      {
	fprintf(stderr,"Error: can't close file %s", filename);
	exit(1);
      }
    return 1;
  }
}

int get_config_file_name( char *buff, int len)
{
#ifndef WIN32
    if (get_private_dir_name( buff, len ) != 0) {
	return 1;
    }
    if ( strlen( buff ) + strlen(CONFIG_FILE) +2  > (unsigned)len ) {
	return 1;
    }

   strcat( buff, "/" );
#endif /* not defined( WIN32 ) */
   /* on win32, config.txt is stored in the main game directory */
    strcat( buff, CONFIG_FILE);
    return 0;
}

FILE * open_config_file(char *flags)
{
  FILE *thefile;
  char *config_file_name =0;
  config_file_name = (char *)calloc(MAX_PATH, sizeof(char));

  if (get_config_file_name(config_file_name, MAX_PATH) != 0) {
    return NULL;
  }
  thefile = fopen(config_file_name, flags);

  return thefile;
}
