/***************************************************************************
                          terrain.c -  description
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
 
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "shp.h"
#include "terrain.h"

/*
====================================================================
Externals
====================================================================
*/
extern char *source_path;
extern char *dest_path;
extern char *move_types[];
extern int   move_type_count;

/*
====================================================================
Weather types.
====================================================================
*/
#define WEATHER_TYPE_COUNT 4
char *weather_types[] = {
    "fair",   "Fair",   "none", 
    "clouds", "Clouds", "none", 
    "rain",   "Rain",   "no_air_attack°cut_strength°bad_sight", 
    "snow",   "Snow",   "no_air_attack°double_fuel_cost°cut_strength°bad_sight"
};
/*
====================================================================
Terrain definitions.
====================================================================
*/
#define TERRAIN_TYPE_COUNT 15
#define TERRAIN_ENTRY_COUNT 49
char *terrain_types[] = {
    "c",  "Clear",
    /* picture - for each weather type */
    "pg/clear.bmp", "default", "pg/clear_rain.bmp", "pg/clear_snow.bmp",
    /* spotting */
    "1", "1", "2", "2",
    /* movement */
        "1", "1", "2", "1",
        "1", "1", "3", "2",
        "2", "2", "3", "2",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "2", "2",
    /* min,max entrenchment */
    "0", "5",
    /* initiative mod */
    "99",
    /* flags */
    "none", "none", "none", "none",
    
    "r", "Road",
    "pg/road.bmp", "default", "pg/road_rain.bmp", "pg/road_snow.bmp",
    "1", "1", "2", "2",
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "1", "1", "2", "2",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "1", "1",
    "0", "5",
    "99",
    "none", "none", "none", "none",

    "#", "Fields",
    "pg/fields.bmp", "default", "pg/fields_rain.bmp", "pg/fields_snow.bmp",
    "1", "1", "2", "2",
        "4", "4", "A", "A",
        "A", "A", "A", "A",
        "A", "A", "A", "A",
        "2", "2", "2", "2",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "3", "3", "A", "3",
    "0", "5",
    "3",
    "none", "none", "none", "none",

    "~", "Rough",
    "pg/rough.bmp", "default", "pg/rough_rain.bmp", "pg/rough_snow.bmp",
    "1", "1", "2", "2",
        "2", "2", "3", "2",
        "2", "2", "4", "3",
        "4", "4", "A", "A",
        "2", "2", "2", "3",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "3", "3", "A", "3",
    "1", "6",
    "5",
    "none", "none", "none", "none",
    
    "R", "River",
    "pg/river.bmp", "default", "pg/river_rain.bmp", "pg/river_snow.bmp",
    "1", "1", "2", "2",
        "A", "A", "X", "2",
        "A", "A", "X", "2",
        "A", "A", "X", "3",
        "A", "A", "A", "2",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "A", "A", "X", "2",
    "0", "5",
    "99",
    "river", "river", "river", "none",
    
    "f", "Forest",
    "pg/forest.bmp", "default", "pg/forest_rain.bmp", "pg/forest_snow.bmp",
    "2", "2", "2", "2",
        "2", "2", "3", "2",
        "2", "2", "3", "2",
        "3", "3", "A", "A",
        "2", "2", "2", "2",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "3", "3", "4", "4",
    "2", "7",
    "3",
    "inf_close_def", "inf_close_def", "inf_close_def", "inf_close_def",
    
    "F", "Fortification",
    "pg/fort.bmp", "default", "pg/fort_rain.bmp", "pg/fort_snow.bmp",
    "1", "1", "2", "2",
        "1", "1", "2", "1",
        "1", "1", "2", "1",
        "2", "2", "4", "3",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "3", "2",
    "2", "7",
    "3",
    "none", "none", "none", "none",
    
    "a", "Airfield",
    "pg/airfield.bmp", "default", "pg/airfield_rain.bmp", "pg/airfield_snow.bmp",
    "1", "1", "2", "2",
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "1", "1", "2", "2",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "1", "1",
    "2", "7",
    "99",
    "supply_air°supply_ground", "supply_air°supply_ground", "supply_air°supply_ground", "supply_air°supply_ground",
    
    "t", "Town",
    "pg/town.bmp", "default", "pg/town_rain.bmp", "pg/town_snow.bmp",
    "2", "2", "2", "2",
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "1", "1", "2", "2",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "1", "1",
    "3", "8",
    "1",
    "inf_close_def°supply_ground", "inf_close_def°supply_ground", "inf_close_def°supply_ground", "inf_close_def°supply_ground",
    
    "o", "Ocean",
    "pg/ocean.bmp", "default", "pg/ocean_rain.bmp", "pg/ocean_snow.bmp",
    "1", "1", "2", "2", 
        "X", "X", "X", "X", 
        "X", "X", "X", "X", 
        "X", "X", "X", "X", 
        "X", "X", "X", "X", 
        "X", "X", "X", "X", 
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
    "0", "0",
    "99",
    "none", "none", "none", "none",
    
    "m", "Mountain",
    "pg/mountain.bmp", "default", "pg/mountain_rain.bmp", "pg/mountain_snow.bmp",
    "2", "2", "2", "2",
        "A", "A", "A", "A",
        "A", "A", "A", "A",
        "A", "A", "A", "A",
        "A", "A", "A", "A",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "A", "A", "A", "A",
    "1", "6", 
    "8",
    "inf_close_def", "inf_close_def", "inf_close_def", "inf_close_def",
    
    "s", "Swamp",
    "pg/swamp.bmp", "default", "pg/swamp_rain.bmp", "pg/swamp_snow.bmp",
    "1", "1", "2", "2",
        "4", "4", "X", "2",
        "4", "4", "X", "2",
        "A", "A", "X", "3",
        "2", "2", "A", "1",
        "X", "X", "X", "X",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "A", "A", "X", "3",
    "0", "3",
    "4",
    "swamp", "swamp", "swamp", "none",
    
    "d", "Desert",
    "pg/desert.bmp", "default", "pg/desert_rain.bmp", "pg/desert_snow.bmp",
    "1", "1", "2", "2",
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "3", "3", "3", "3",
        "2", "2", "2", "2",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "2", "2", "2", "2",
    "0", "5",
    "99",
    "none", "none", "none", "none",
    
    "D", "Rough Desert",
    "pg/rough_desert.bmp", "default", "pg/rough_desert_rain.bmp", "pg/rough_desert_snow.bmp",
    "1", "1", "2", "2",
        "2", "2", "3", "2", 
        "2", "2", "4", "3", 
        "4", "4", "A", "A", 
        "2", "2", "2", "3",
        "A", "A", "A", "A", 
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "3", "3", "3", "3", 
    "1", "6",
    "99",
    "none", "none", "none", "none",
    
    "h", "Harbor",
    "pg/harbor.bmp", "default", "pg/harbor_rain.bmp", "pg/harbor_snow.bmp",
    "1", "1", "2", "2",
        "1", "1", "1", "1",
        "1", "1", "1", "1",
        "1", "1", "2", "2",
        "1", "1", "1", "1",
        "A", "A", "A", "A",
        "1", "1", "1", "1",
        "X", "X", "X", "X", 
        "1", "1", "1", "1",
    "3", "8",
    "5",
    "inf_close_def°supply_ground°supply_ships", "inf_close_def°supply_ground°supply_ships", 
    "inf_close_def°supply_ground°supply_ships", "inf_close_def°supply_ground°supply_ships"
    
};
/*
====================================================================
Terrain tile types.
====================================================================
*/
int terrain_tile_count = 237;
char tile_type[] = {
    'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 
    'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'c',
    'c', 'o', 'o', 'o', 'h', 'h', 'h', 'h', 'r', 'o', 'r',
    'c', 'c', 'c', 'c', 'r', 'c', 'c', 'r', 'r', 'o', 'c',
    'c', 'c', 'c', 'r', 'r', 'r', 'o', 'o', 'R', 'R', 'R',
    'R', 'r', 'r', 'r', 'r', 'r', 'R', 'R', 'R', 'R', 'R',
    'r', 'r', 'r', 'r', 'r', 'R', 'R', 'o', 'r', 'm', 'm',
    'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 
    'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 
    'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 
    'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 
    'm', 'm', 'm', 's', 't', 't', 't', 'a', 'c', 'c', '~',
    '~', 's', 's', 'f', 'f', 'f', 'f', 'c', '~', '~', '~',
    '~', 's', 'f', 'f', 'f', 'c', 'c', 'c', 'F', 'F', 'F',
    'r', 'r', 'r', '#', 'F', 'F', 'F', 'F', 'R', 'F', 'r',
    'R', 'r', '#', 'F', 'F', 'F', 'F', 'F', 'F', 'r', 'r',
    'r', '#', 'F', 'F', 'F', 'm', 'm', 'd', 'm', 'm', 'd',
    'm', 'm', 'm', 'd', 'm', 'm', 'm', 'd', 'd', 'm', 'm',
    'm', 'm', 'D', 'D', 'D', 'D', 'D', 't', 'F', 
    /* ??? -- really mountains ??? */
    'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'm',
    'm', 'm', 'm', 'm', 'm', 'm',
    /* ??? */
    'r', 'r', 'r', 'r', 'R', 'R', 'R', 'c', 'h', 'h', 'd',
    'd', 'd', 'd'
};

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Convert map tiles belonging to terrain type 'id'
from TACMAP.SHP into one bitmap called 'fname'.
====================================================================
*/
static int terrain_convert_tiles( char id, PG_Shp *shp, char *fname )
{
    Uint32 grass_pixel, snow_pixel, mud_pixel;
    int i, j, pos;
    SDL_Rect srect, drect;
    SDL_Surface *surf;
    char path[512];
    int count = 0;
    SDL_Surface *fixed_road;
    int is_road = !strcmp( fname, "road" );
    /* count occurence */
    for ( i = 0; i < terrain_tile_count; i++ )
        if ( tile_type[i] == id )
            count++;
    /* create surface */
    surf = SDL_CreateRGBSurface( SDL_SWSURFACE, 60 * count, 50, shp->surf->format->BitsPerPixel,
                                 shp->surf->format->Rmask, shp->surf->format->Gmask, shp->surf->format->Bmask,
                                 shp->surf->format->Amask );
    if ( surf == 0 ) {
        fprintf( stderr, "error creating surface: %s\n", SDL_GetError() );
        goto failure;
    }
    /* modified colors */
    grass_pixel = SDL_MapRGB( surf->format, 192, 192, 112 );
    snow_pixel = SDL_MapRGB( surf->format, 229, 229, 229 );
    mud_pixel = SDL_MapRGB( surf->format, 206, 176, 101 );
    /* copy pics */
    srect.w = drect.w = 60;
    srect.h = drect.h = 50;
    srect.x = drect.y = 0;
    pos = 0; count = 0;
    for ( i = 0; i < terrain_tile_count; i++ )
        if ( tile_type[i] == id ) {
            /* the third road tile is buggy so we need to copy the fixed one */
            if ( is_road && count == 2 ) {
                sprintf( path, "%s/convdata/road2.bmp", SRC_DIR );
                if ( ( fixed_road = SDL_LoadBMP( path ) ) == 0 ) {
                    fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
                    return 0;
                }
                srect.y = 0; drect.x = pos;
                SDL_BlitSurface( fixed_road, &srect, surf, &drect );
            }
            else {
                srect.y = i * 50;
                drect.x = pos;
                SDL_BlitSurface( shp->surf, &srect, surf, &drect );
            }
            pos += 60;
            count++;
        }
    /* default terrain */
    sprintf( path, "%s/gfx/terrain/pg/%s.bmp", dest_path, fname );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    /* snow terrain */
    for ( j = 0; j < surf->h; j++ )
            for ( i = 0; i < surf->w; i++ )
                if ( grass_pixel == get_pixel( surf, i, j ) )
                    set_pixel( surf, i, j, snow_pixel );
    sprintf( path, "%s/gfx/terrain/pg/%s_snow.bmp", dest_path, fname );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    /* rain terrain */
    for ( j = 0; j < surf->h; j++ )
            for ( i = 0; i < surf->w; i++ )
                if ( snow_pixel == get_pixel( surf, i, j ) )
                    set_pixel( surf, i, j, mud_pixel );
    sprintf( path, "%s/gfx/terrain/pg/%s_rain.bmp", dest_path, fname );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    return 1;
failure:
    if ( surf ) SDL_FreeSurface( surf );
    return 0;
}


/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Convert terrain database.
====================================================================
*/
int terrain_convert_database( void )
{
    int i, j, k;
    FILE *file = 0;
    char path[512];
    printf( "  terrain database...\n" );
    sprintf( path, "%s/maps/pg.tdb", dest_path );
    if ( ( file = fopen( path, "w" ) ) == 0 ) {
        fprintf( stderr, "%s: access denied\n", path );
        return 0;
    }
    /* weather types */
    fprintf( file, "@\n" );
    fprintf( file, "<weather\n" );
    for ( i = 0; i < WEATHER_TYPE_COUNT; i++ )
        fprintf( file, "<%s\nname»%s\nflags»%s\n>\n", 
                 weather_types[i * 3], weather_types[i * 3 + 1], weather_types[i * 3 + 2] );
    fprintf( file, ">\n" );
    /* additional graphics and sounds */
    fprintf( file, "hex_width»60\nhex_height»50\nhex_x_offset»45\nhex_y_offset»25\n" );
    fprintf( file, "fog»pg/fog.bmp\ngrid»pg/grid.bmp\nframe»pg/select_frame.bmp\n" );
    fprintf( file, "crosshair»pg/crosshair.bmp\nexplosion»pg/explosion.bmp\ndamage_bar»pg/damage_bars.bmp\n" );
    fprintf( file, "explosion_sound»pg/explosion.wav\nselect_sound»pg/select.wav\n" );
    /* terrain types */
    fprintf( file, "<terrain\n" );
    for ( i = 0; i < TERRAIN_TYPE_COUNT; i++ ) {
        fprintf( file, "<%s\n", terrain_types[i * TERRAIN_ENTRY_COUNT] );
        fprintf( file, "name»%s\n", terrain_types[i * TERRAIN_ENTRY_COUNT + 1] );
        fprintf( file, "<image\n" );
        for ( j = 0; j < WEATHER_TYPE_COUNT; j++ )
            fprintf( file, "%s»%s\n", weather_types[j * 3], terrain_types[i * TERRAIN_ENTRY_COUNT + 2 + j] );
        fprintf( file, ">\n" );
        fprintf( file, "<spot_cost\n" );
        for ( j = 0; j < WEATHER_TYPE_COUNT; j++ )
            fprintf( file, "%s»%s\n", weather_types[j * 3], 
                     terrain_types[i * TERRAIN_ENTRY_COUNT + 2 + WEATHER_TYPE_COUNT + j] );
        fprintf( file, ">\n" );
        fprintf( file, "<move_cost\n" );
        for ( k = 0; k < move_type_count; k++ ) {
            fprintf( file, "<%s\n", move_types[k * 3] );
                for ( j = 0; j < WEATHER_TYPE_COUNT; j++ )
                    fprintf( file, "%s»%s\n", weather_types[j * 3], 
                             terrain_types[i * TERRAIN_ENTRY_COUNT + 2 + WEATHER_TYPE_COUNT * ( 2 + k ) + j] );
            fprintf( file, ">\n" );
        }
        fprintf( file, ">\n" );
        fprintf( file, "min_entr»%s\nmax_entr»%s\n",
                 terrain_types[i * TERRAIN_ENTRY_COUNT + 2 + WEATHER_TYPE_COUNT * ( 2 + move_type_count )],
                 terrain_types[i * TERRAIN_ENTRY_COUNT + 3 + WEATHER_TYPE_COUNT * ( 2 + move_type_count )]);
        fprintf( file, "max_init»%s\n", terrain_types[i * TERRAIN_ENTRY_COUNT + 4 + WEATHER_TYPE_COUNT * ( 2 + move_type_count )] );
        fprintf( file, "<flags\n" );
        for ( j = 0; j < WEATHER_TYPE_COUNT; j++ )
            fprintf( file, "%s»%s\n", weather_types[j * 3],
                     terrain_types[i * TERRAIN_ENTRY_COUNT + 5 + WEATHER_TYPE_COUNT * ( 2 + move_type_count ) + j] );
        fprintf( file, ">\n" );
        fprintf( file, ">\n" );
    }
    fprintf( file, ">" );
    fclose( file );
    return 1;
}

/*
====================================================================
Convert terrain graphics
====================================================================
*/
int terrain_convert_graphics( void )
{
    int i;
    SDL_Rect srect, drect;
    PG_Shp *shp;
    char path[512];
    SDL_Surface *surf;
    sprintf( path, "%s/gfx/terrain/pg", dest_path );
    mkdir( path, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH );
    printf( "  terrain graphics...\n" );
    /* explosion */
    if ( ( shp = shp_load( "EXPLODE.SHP" ) ) == 0 ) return 0;
    surf = SDL_CreateRGBSurface( SDL_SWSURFACE, 60 * 5, 50, shp->surf->format->BitsPerPixel,
                                 shp->surf->format->Rmask, shp->surf->format->Gmask, shp->surf->format->Bmask,
                                 shp->surf->format->Amask );
    if ( surf == 0 ) {
        fprintf( stderr, "error creating surface: %s\n", SDL_GetError() );
        goto failure;
    }
    srect.w = drect.w = 60;
    srect.h = drect.h = 50;
    srect.x = drect.y = 0;
    for ( i = 0; i < 5; i++ ) {
        srect.y = i * srect.h;
        drect.x = i * srect.w;
        SDL_BlitSurface( shp->surf, &srect, surf, &drect );
    }
    sprintf( path, "%s/gfx/terrain/pg/explosion.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    shp_free(&shp);
    /* fog */
    sprintf( path, "%s/convdata/fog.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/terrain/pg/fog.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* grid */
    sprintf( path, "%s/convdata/grid.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/terrain/pg/grid.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    SDL_FreeSurface( surf );
    }
    /* select frame */
    sprintf( path, "%s/convdata/select_frame.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/terrain/pg/select_frame.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* crosshair */
    sprintf( path, "%s/convdata/crosshair.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/terrain/pg/crosshair.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* damage bars */
    sprintf( path, "%s/convdata/damage_bars.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/terrain/pg/damage_bars.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* terrain graphics */
    if ( ( shp = shp_load( "TACMAP.SHP" ) ) == 0 ) goto failure;
    if ( !terrain_convert_tiles( 'c', shp, "clear" ) ) goto failure;
    if ( !terrain_convert_tiles( 'r', shp, "road" ) ) goto failure;
    if ( !terrain_convert_tiles( '#', shp, "fields" ) ) goto failure;
    if ( !terrain_convert_tiles( '~', shp, "rough" ) ) goto failure;
    if ( !terrain_convert_tiles( 'R', shp, "river" ) ) goto failure;
    if ( !terrain_convert_tiles( 'f', shp, "forest" ) ) goto failure;
    if ( !terrain_convert_tiles( 'F', shp, "fort" ) ) goto failure;
    if ( !terrain_convert_tiles( 'a', shp, "airfield" ) ) goto failure;
    if ( !terrain_convert_tiles( 't', shp, "town" ) ) goto failure;
    if ( !terrain_convert_tiles( 'o', shp, "ocean" ) ) goto failure;
    if ( !terrain_convert_tiles( 'm', shp, "mountain" ) ) goto failure;
    if ( !terrain_convert_tiles( 's', shp, "swamp" ) ) goto failure;
    if ( !terrain_convert_tiles( 'd', shp, "desert" ) ) goto failure;
    if ( !terrain_convert_tiles( 'D', shp, "rough_desert" ) ) goto failure;
    if ( !terrain_convert_tiles( 'h', shp, "harbor" ) ) goto failure;
    shp_free(&shp);
    return 1;
failure:
    if ( surf ) SDL_FreeSurface( surf );
    if ( shp ) shp_free( &shp );
    return 0;
}
