
/***************************************************************************
                          file.c  -  description
                             -------------------
    begin                : Thu Jan 18 2001
    copyright            : (C) 2001 by Michael Speck
    email                : kulkanie@gmx.net
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include "misc.h"
#include "list.h"
#include "file.h"

//#define FILE_DEBUG

/*
====================================================================
Swap these two pointers.
====================================================================
*/
void swap( char **str1, char **str2 )
{
    char *dummy;
    dummy = *str1;
    *str1 = *str2;
    *str2 = dummy;
}

/*
====================================================================
Return a list (autodeleted strings)
with all accessible files and directories in path
with the extension ext (if != 0). Don't show hidden files or
Makefile stuff.
The directoriers are marked with an asteriks.
====================================================================
*/
List* dir_get_entries( char *path, char *root, char *ext )
{
    Text *text = 0;
    int i, j;
    DIR *dir;
    DIR *test_dir;
    struct dirent *dirent = 0;
    List *list;
    struct stat fstat;
    char file_name[512];
    FILE *file;
    int len;
    /* open this directory */
    if ( ( dir = opendir( path ) ) == 0 ) {
        fprintf( stderr, "get_file_list: can't open parent directory '%s'\n", path );
        return 0;
    }
    text = calloc( 1, sizeof( Text ) );
    /* use dynamic list to gather all valid entries */
    list = list_create( LIST_AUTO_DELETE, LIST_NO_CALLBACK );
    /* read each entry and check if its a valid entry, then add it to the dynamic list */
    while ( ( dirent = readdir( dir ) ) != 0 ) {
        /* hiden stuff is not displayed */
        if ( dirent->d_name[0] == '.' && dirent->d_name[1] != '.' ) continue;
        if ( STRCMP( dirent->d_name, "Makefile" ) ) continue;
        if ( STRCMP( dirent->d_name, "Makefile.in" ) ) continue;
        if ( STRCMP( dirent->d_name, "Makefile.am" ) ) continue;
        /* check if it's the root directory */
        if ( root )
            if ( dirent->d_name[0] == '.' ) {
                if ( STRCMP( path, root ) )
                    continue;
            }
        /* get stats */
        sprintf( file_name, "%s/%s", path, dirent->d_name );
        if ( stat( file_name, &fstat ) == -1 ) continue;
        /* check directory */
        if ( S_ISDIR( fstat.st_mode ) ) {
            if ( ( test_dir = opendir( file_name ) ) == 0  ) continue;
            closedir( test_dir );
            sprintf( file_name, "*%s", dirent->d_name );
            list_add( list, strdup( file_name ) );
        }
        else
        /* check regular file */
        if ( S_ISREG( fstat.st_mode ) ) {
            /* test it */
            if ( ( file = fopen( file_name, "r" ) ) == 0 ) continue;
            fclose( file );
            /* check if this file has the proper extension */
            if ( ext )
                if ( !STRCMP( dirent->d_name + ( strlen( dirent->d_name ) - strlen( ext ) ), ext ) )
                    continue;
            list_add( list, strdup( dirent->d_name ) );
        }
    }
    /* close dir */
    closedir( dir );
    /* convert to static list */
    text->count = list->count;
    text->lines = calloc( list->count, sizeof( char* ));
    list_reset( list );
    for ( i = 0; i < text->count; i++ )
        text->lines[i] = strdup( list_next( list ) );
    list_delete( list );
    /* sort this list: directories at top and everything in alphabetical order */
    if ( text->count > 0 )
        for ( i = 0; i < text->count - 1; i++ )
            for ( j = i + 1; j < text->count; j++ ) {
                /* directory comes first */
                if ( text->lines[j][0] == '*' ) {
                    if ( text->lines[i][0] != '*' )
                        swap( &text->lines[i], &text->lines[j] );
                    else {
                        /* do not exceed buffer size of smaller buffer */
                        len = strlen( text->lines[i] );
                        if ( strlen( text->lines[j] ) < len ) len = strlen( text->lines[j] );
                        if ( strncmp( text->lines[j], text->lines[i], len ) < 0 )
                            swap( &text->lines[i], &text->lines[j] );
                    }
                }
                else {
                    /* do not exceed buffer size of smaller buffer */
                    len = strlen( text->lines[i] );
                    if ( strlen( text->lines[j] ) < len ) len = strlen( text->lines[j] );
                    if ( strncmp( text->lines[j], text->lines[i], len ) < 0 )
                        swap( &text->lines[i], &text->lines[j] );
                }
            }
    /* return as dynamic list */
    list = list_create( LIST_AUTO_DELETE, LIST_NO_CALLBACK );
    for ( i = 0; i < text->count; i++ )
        list_add( list, strdup( text->lines[i] ) );
    delete_text( text );
    return list;
}
