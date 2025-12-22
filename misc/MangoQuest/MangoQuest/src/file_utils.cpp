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
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include <stdarg.h>
#include <sys/stat.h>
#include <limits.h>

#include <errno.h>

#ifndef WIN32
#   include <unistd.h>
#   include <sys/types.h>
#   include <pwd.h>
#   include <dirent.h>
#   include <sys/time.h>
#   include <sys/types.h>
#   include <dirent.h>
#   if defined (_MSC_VER)
#     include <io.h>
#   endif
#endif

#include "file_utils.h"

#if defined(WIN32) || defined(__MORPHOS__)
#   define SHXMAN_DATA "game_data/"
#endif

int get_private_dir_name( char *buff, int len )
{
#if defined( WIN32 ) || defined(__MORPHOS__)
    if ( strlen( CUSTOM_MAPS_DIR ) +1 > (unsigned)len ) {
	//return 1;
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
	//return 1;
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
	//return 1;
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
  search_buff = (char *)calloc(len, sizeof(char));
  memset (buff,0,(len-1)*sizeof(char));
  memset (search_buff,0,(len-1)*sizeof(char));

  // we first search using the given filename
  printf("looking for %s\n", map_name);

  printf("  using specified path...");
  if (file_exists (map_name)) 
    {
      printf(" found.\n");
      strncpy(buff, map_name, len);
      return 0;
    }
  printf(" not found.\n");

#ifndef WIN32
  // then we search in current directory
  if ( getcwd( search_buff, len - 1 ) == NULL ) {
	fprintf(stderr, "Error: getcwd failed");
	exit(1);
    }

  if ( strlen( search_buff ) + strlen(map_name ) +2> (unsigned)len ) {
	return 1;
    }

  printf("  in %s ...", search_buff);
	 
    strcat( search_buff, "/" );
#endif
  strcat(search_buff, map_name);

  if (file_exists (search_buff)) 
    {
      printf(" found.\n");
      strncpy(buff, search_buff, len);
      return 0;
    }
  printf( " not found.\n");
  memset (search_buff,0,len*sizeof(char));

  // then we search in general (public) (buit-in) maps directory
  strcat(search_buff, BUILTIN_MAPS);
  printf("  in %s ...", search_buff);
  strcat(search_buff, map_name);

  if (file_exists (search_buff)) 
    {
      printf(" found.\n");
      strncpy(buff, search_buff, len);
      return 0;
    }
  printf(" not found.\n");
  memset (search_buff,0,len*sizeof(char));

  // then we search in user's private maps directory
  get_private_map_file_name(search_buff, map_name, MAX_PATH);
  printf("  for %s ...", search_buff);
  if (file_exists (search_buff)) 
    {
      printf(" found.\n");
      strncpy(buff, search_buff, len);
      return 0;
    }
  printf(" not found.\n");
  // we have found nothing
  return 1;
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
#if !defined(WIN32) && !defined(__MORPHOS__)
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
#if !defined(WIN32) && !defined(__MORPHOS__)
    if (get_private_dir_name( buff, len ) != 0) {
	return 1;
    }
//    printf("%d",strlen(buff));
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

  if (*flags == 'r')
    printf("Opening configuration file for reading: %s\n",config_file_name);
  else if (*flags == 'w')
    printf("Opening configuration file for writing: %s\n",config_file_name);
  else 
    printf("Opening configuration file with unknown flag: %s\n",config_file_name);

  thefile = fopen(config_file_name, flags);

  // NULL check has to be done later

  return thefile;
}
