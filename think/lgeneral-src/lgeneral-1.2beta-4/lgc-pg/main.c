/***************************************************************************
                          main.c -  description
                             -------------------
    begin                : Tue Mar 12 2002
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

#ifdef HAVE_CONFIG_H
#include "../config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "units.h"
#include "shp.h"
#include "nations.h"
#include "terrain.h"
#include "maps.h"
#include "scenarios.h"

char *source_path = 0;
char *dest_path = 0;
char *custom_name = 0;
char tacicons[128];
int custom_scen = 0;
int custom_id = 0;
int use_def_pal = 0;
int convert_all_shps = 0;

void print_help()
{
    printf( 
    "Usage:\n  lgc-pg -s <PG DATA DIR> -d <LGENERAL DIR> [--defpal] [--custom -n <NAME> [-i <ID>] [-t <TACICONS>]]\n"\
    "Example: lgc-pg -s /mnt/cdrom/DAT -d /usr/local/share/games/lgeneral\n"\
    "See the README for more information.\n" );
    exit( 0 );
}

/* parse command line. if all options are okay return True
   else False */
int parse_args( int argc, char **argv )
{
    int i;
    tacicons[0] = 0;
    for ( i = 1; i < argc; i++ ) {
        if ( !strcmp( "-s", argv[i] ) )
            source_path = argv[i + 1];
        if ( !strcmp( "-d", argv[i] ) )
            dest_path = argv[i + 1];
        if ( !strcmp( "-n", argv[i] ) )
            custom_name = argv[i + 1];
        if ( !strcmp( "-i", argv[i] ) )
            custom_id = atoi( argv[i + 1] );
        if ( !strcmp( "-t", argv[i] ) )
            strcpy( tacicons, argv[i + 1] );
        if ( !strcmp( "--custom", argv[i] ) )
            custom_scen = 1;
        if ( !strcmp( "--defpal", argv[i] ) )
            use_def_pal = 1;
        if ( !strcmp( "--shps", argv[i] ) )
            convert_all_shps = 1;
    }
    if ( source_path == 0 ) {
        fprintf( stderr, "ERROR: You must specifiy the source directory which contains either a custom scenario of the original data.\n" );
        return 0;
    }
    if ( dest_path == 0 ) {
        fprintf( stderr, "ERROR: You must specify the destination path which provides the LGeneral directory struct.\n" );
        return 0;
    }
    if ( custom_scen && custom_name == 0 ) {
        fprintf( stderr, "ERROR: You must specify the target name of the custom scenario.\n" );
        return 0;
    }
    if ( tacicons[0] == 0 )
        sprintf( tacicons, "%s.bmp", custom_name );
    printf( "Settings:\n" );
    printf( "  Source: %s\n  Destination: %s\n", source_path, dest_path );
    if ( custom_scen ) {
        printf( "  Custom Scenario: %s (from game%03i.scn)\n", custom_name, custom_id );
        if ( units_find_tacicons() )
            printf( "  Target TacticalIcons: %s\n", tacicons );
    }
    if ( use_def_pal )
        printf( "  Use Default Palette\n" );
    else
        printf( "  Use Individual Palettes\n" );
    return 1;
}

int main( int argc, char **argv )
{
    int tacicons_used;
    /* SDL required for graphical conversion */
    SDL_Init( SDL_INIT_VIDEO | SDL_INIT_TIMER ); SDL_SetVideoMode( 20, 20, 16, SDL_SWSURFACE ); atexit( SDL_Quit );
    /* info */
    printf( "LGeneral Converter for Panzer General (DOS version) v%s\nCopyright 2002-2005 Michael Speck\nReleased under GNU GPL\n---\n", VERSION );
    if ( !parse_args( argc, argv ) ) {
        print_help();
        exit( 1 );
    }
    printf( "Converting:\n" );
    if ( custom_scen ) {
        tacicons_used = 0;
        if ( !scenarios_convert( custom_id ) ) return 0;
        if ( !maps_convert( custom_id ) ) return 0;
        if ( units_find_panzequp() )  {
            if ( units_find_tacicons() ) {
                if ( !units_convert_graphics( tacicons ) ) return 0;
                if ( !units_convert_database( tacicons ) ) return 0;
                tacicons_used = 1;
            }
            else
                if ( !units_convert_database( "pg.bmp" ) ) 
                    return 0;
        }
        printf( "Note: You must setup description, authors, victory conditions and\n"\
                "reinforcements manually. (default victory condition: attacker must\n"\
                "capture all victory hexes; default reinforcements: none)\n" );
    }
    else {
        /* convert all data */
        if ( !nations_convert() ) return 0;
        if ( !units_convert_database( "pg.bmp" ) ) return 0;
        if ( !units_convert_graphics( "pg.bmp" ) ) return 0;
        if ( !terrain_convert_database() ) return 0;
        if ( !terrain_convert_graphics() ) return 0;
        if ( !maps_convert( -1 ) ) return 0;
        if ( !scenarios_convert( -1 ) ) return 0;
    }
    printf( "Done!\n" );
	return 0;
}
