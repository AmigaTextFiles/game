/***************************************************************************
                          config.c  -  description
                             -------------------
    begin                : Tue Feb 13 2001
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

#include <SDL.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "sdl.h"
#include "config.h"
#include "parser.h"

Config config;

/* check if config directory exists; if not create it and set config_dir */
void check_config_dir_name()
{
#ifdef DISABLE_INSTALL
    sprintf( config.dir_name, "." );
#else    
    sprintf( config.dir_name, "%s/.lgames", getenv( "HOME" ) );
#endif    
    if ( opendir( config.dir_name ) == 0 ) {

        fprintf( stderr, "Couldn't find/open config directory '%s'\n", config.dir_name );
        fprintf( stderr, "Attempting to create it... " );
#ifdef WIN32
        mkdir( config.dir_name );
#else
        mkdir( config.dir_name, S_IRWXU );
#endif
        if ( opendir( config.dir_name ) == 0 )
            fprintf( stderr, "failed\n" );
        else
            fprintf( stderr, "ok\n" );

    }

}

/* set config to default */
void reset_config()
{
    /* gfx options */
    config.tran = 1;
    config.grid = 0;
    config.show_bar = 1;
    config.width = 640;
    config.height = 480;
    config.fullscreen = 0;
    /* game options */
    config.supply = 1;
    config.weather = 1;
    config.fog_of_war = 1;
    config.show_cpu_turn = 1;
    /* audio stuff */
    config.sound_on = 1;
    config.sound_volume = 96;
    config.music_on = 1;
    config.music_volume = 96;
}

/* load config */
void load_config( )
{
    char file_name[512];
    PData *pd; 
    /* set to defaults */
    check_config_dir_name();
    reset_config();
    /* load config */
    sprintf( file_name, "%s/%s", config.dir_name, "lgeneral.conf" );
    if ( ( pd = parser_read_file( "config", file_name ) ) == 0 ) {
        fprintf( stderr, "%s\n", parser_get_error() );
        return;
    }
    /* assign */
    parser_get_int( pd, "grid", &config.grid );
    parser_get_int( pd, "tran", &config.tran );
    parser_get_int( pd, "bar", &config.show_bar );
    parser_get_int( pd, "width", &config.width );
    parser_get_int( pd, "height", &config.height );
    parser_get_int( pd, "fullscreen", &config.fullscreen );
    parser_get_int( pd, "supply", &config.supply );
    parser_get_int( pd, "weather", &config.weather );
    parser_get_int( pd, "fog_of_war", &config.fog_of_war );
    parser_get_int( pd, "cpu_turn", &config.show_cpu_turn );
    parser_get_int( pd, "sound_on", &config.sound_on );
    parser_get_int( pd, "sound_volume", &config.sound_volume );
    parser_get_int( pd, "music_on", &config.music_on );
    parser_get_int( pd, "music_volume", &config.music_volume );
    parser_free( &pd );
}

/* save config */
void save_config( )
{
    FILE *file = 0;
    char file_name[512];

    sprintf( file_name, "%s/%s", config.dir_name, "lgeneral.conf" );
    if ( ( file = fopen( file_name, "w" ) ) == 0 )
        fprintf( stderr, "Cannot access config file '%s' to save settings\n", file_name );
    else {
        fprintf( file, "@\n" );
        fprintf( file, "grid»%i\n", config.grid );
        fprintf( file, "tran»%i\n", config.tran );
        fprintf( file, "bar»%i\n", config.show_bar );
        fprintf( file, "width»%i\n", config.width );
        fprintf( file, "height»%i\n", config.height );
        fprintf( file, "fullscreen»%i\n", config.fullscreen );
        fprintf( file, "supply»%i\n", config.supply );
        fprintf( file, "weather»%i\n", config.weather );
        fprintf( file, "fog_of_war»%i\n", config.fog_of_war );
        fprintf( file, "cpu_turn»%i\n", config.show_cpu_turn );
        fprintf( file, "sound_on»%i\n", config.sound_on );
        fprintf( file, "sound_volume»%i\n", config.sound_volume );
        fprintf( file, "music_on»%i\n", config.music_on );
        fprintf( file, "music_volume»%i\n", config.music_volume );
        fclose( file );
    }
}

