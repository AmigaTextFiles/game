/***************************************************************************
                          slot.c  -  description
                             -------------------
    begin                : Sat Jun 23 2001
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

#include <math.h>
#include <dirent.h>
#include "lgeneral.h"
#include "date.h"
#include "nation.h"
#include "unit.h"
#include "player.h"
#include "map.h"
#include "scenario.h"
#include "slot.h"
#include "campaign.h"

/*
====================================================================
Externals
====================================================================
*/
extern Config config;
extern Trgt_Type *trgt_types;
extern int trgt_type_count;
extern Mov_Type *mov_types;
extern int mov_type_count;
extern Unit_Class *unit_classes;
extern int unit_class_count;
extern int map_w, map_h;
extern Player *cur_player;
extern int turn;
extern int cur_weather;
extern Scen_Info *scen_info;
extern List *units;
extern List *reinf, *avail_units;
extern List *players;
extern int camp_loaded;
extern char *camp_fname;
extern Camp_Entry *camp_cur_scen;
extern Map_Tile **map;

/*
====================================================================
Slot struct
====================================================================
*/
typedef struct {
    char name[256];  /* displayed name */
    char fname[256]; /* file name */
    int  valid;      /* may load from this slot? */
} Slot;
Slot slots[SLOT_COUNT];

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Return True if this is a saved game and return the slot index.
====================================================================
*/
static int is_saved_game( char *file_name, int *i )
{
    if ( strncmp( file_name, "lg_save_", 8 ) ) return 0;
    (*i) = 0;
    (*i) = (char)file_name[8] - 48;
    return 1;
}

/*
====================================================================
Save/load slot name to/from file.
====================================================================
*/
static void slot_read_name( Slot *slot, FILE *file )
{
    fread( slot->name, sizeof( slot->name ), 1, file );
}
static void slot_write_name( Slot *slot, FILE *file )
{
    fwrite( slot->name, sizeof( slot->name ), 1, file );
}

/*
====================================================================
Save/load a single integer
====================================================================
*/
static void save_int( FILE *file, int i )
{
    fwrite( &i, sizeof( int ), 1, file );
}
static int load_int( FILE *file )
{
    int i;
    fread( &i, sizeof( int ), 1, file );
    return i;
}
/*
====================================================================
Save/load a string to/from file.
====================================================================
*/
static void save_string( FILE *file, char *str )
{
    int length;
    /* save length and then string itself */
    length = strlen( str );
    fwrite( &length, sizeof( int ), 1, file );
    fwrite( str, sizeof( char ), length, file );
}
static char* load_string( FILE *file )
{
    char *str = 0;
    int length;

    fread( &length, sizeof( int ), 1, file );
    str = calloc( length + 1, sizeof( char ) );
    fread( str, sizeof( char ), length, file );
    str[length] = 0;
    return str;
}

/*
====================================================================
Save/load a unit from/to file.
Save the unit struct itself afterwards the id strings of
prop, trsp_prop, player, nation. sel_prop can be rebuild by 
checking embark. As we may merge units prop and trsp_prop
may not be overwritten with original data. Instead all
pointers are resolved by the id string.
====================================================================
*/
static void save_unit( FILE *file, Unit *unit )
{
    fwrite( unit, sizeof( Unit ), 1, file );
    save_string( file, unit->prop.id );
    if ( unit->trsp_prop.id )
        save_string( file, unit->trsp_prop.id );
    else
        save_string( file, "none" );
    save_string( file, unit->player->id );
    save_string( file, unit->nation->id );
}
Unit* load_unit( FILE *file )
{
    Unit_Lib_Entry *lib_entry;
    Unit *unit = 0;
    char *str;
    
    unit = calloc( 1, sizeof( Unit ) );
    /* unit */
    fread( unit, sizeof( Unit ), 1, file );
    unit->backup = calloc( 1, sizeof( Unit ) );
    /* sel_prop */
    if ( unit->embark == EMBARK_NONE )
        unit->sel_prop = &unit->prop;
    else
        unit->sel_prop = &unit->trsp_prop;
    /* props */
    str = load_string( file );
    lib_entry = unit_lib_find( str );
    unit->prop.id = lib_entry->id;
    unit->prop.name = lib_entry->name;
    unit->prop.icon = lib_entry->icon;
    unit->prop.icon_tiny = lib_entry->icon_tiny;
#ifdef WITH_SOUND
    unit->prop.wav_move = lib_entry->wav_move;
#endif
    free( str );
    /* transporter */
    str = load_string( file );
    lib_entry = unit_lib_find( str );
    if ( lib_entry ) {
        unit->trsp_prop.id = lib_entry->id;
        unit->trsp_prop.name = lib_entry->name;
        unit->trsp_prop.icon = lib_entry->icon;
        unit->trsp_prop.icon_tiny = lib_entry->icon_tiny;
#ifdef WITH_SOUND
        unit->trsp_prop.wav_move = lib_entry->wav_move;
#endif
    }
    free( str );
    /* player */
    str = load_string( file );
    unit->player = player_get_by_id( str );
    free( str );
    /* nation */
    str = load_string( file );
    unit->nation = nation_find( str );
    free( str );
    
    return unit;
}
/*
====================================================================
Save/load player structs.
The order of players in the scenario file must not have changed.
It is assumed to be kept so only some values are saved.
====================================================================
*/
static void save_player( FILE *file, Player *player )
{
    /* control, air/sea trsp used */
    save_int( file, player->ctrl );
    save_int( file, player->air_trsp_used );
    save_int( file, player->sea_trsp_used );
    save_string( file, player->ai_fname );
}
static void load_player( FILE *file, Player *player )
{
    /* control, air/sea trsp used */
    player->ctrl = load_int( file );
    player->air_trsp_used = load_int( file );
    player->sea_trsp_used = load_int( file );
    free( player->ai_fname );
    player->ai_fname = load_string( file );
}
/*
====================================================================
Save indices in scen::units of ground and air unit on this tile.
====================================================================
*/
static void save_map_tile_units( FILE *file, Map_Tile *tile )
{
    int i;
    int index;
    index = -1;
    /* ground */
    list_reset( units );
    if ( tile->g_unit )
        for ( i = 0; i < units->count; i++ )
            if ( tile->g_unit == list_next( units ) ) {
                index = i;
                break;
            }
    save_int( file, index );
    /* air */
    index = -1;
    list_reset( units );
    if ( tile->a_unit )
        for ( i = 0; i < units->count; i++ )
            if ( tile->a_unit == list_next( units ) ) {
                index = i;
                break;
            }
    save_int( file, index );
}
/* load map tile units assuming that scen::units is set to the correct units */
static void load_map_tile_units( FILE *file, Unit **unit, Unit **air_unit )
{
    int index;
    index = load_int( file );
    if ( index == -1 ) *unit = 0;
    else
        *unit = list_get( units, index );
    index = load_int( file );
    if ( index == -1 ) *air_unit = 0;
    else
        *air_unit = list_get( units, index );
}
/*
====================================================================
Save map flags: nation id and player id strings
====================================================================
*/
static void save_map_tile_flag( FILE *file, Map_Tile *tile )
{
    if ( tile->nation )
        save_string( file, tile->nation->id );
    else
        save_string( file, "none" );
    if ( tile->player )
        save_string( file, tile->player->id );
    else
        save_string( file, "none" );
}
static void load_map_tile_flag( FILE *file, Nation **nation, Player **player )
{
    char *str;
    str = load_string( file );
    *nation = nation_find( str );
    free( str );
    str = load_string( file );
    *player = player_get_by_id( str );
    free( str );
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Check the save directory for saved games and add them to the 
slot list else setup a new entry: '_index_ <empty>'
====================================================================
*/
void slots_init()
{
    int i;
    DIR *dir = 0;
    struct dirent *entry = 0;
    FILE *file = 0;
    /* set all slots empty */
    for ( i = 0; i < SLOT_COUNT; i++ ) {
        sprintf( slots[i].name, "<emtpy>" );
        slots[i].fname[0] = 0;
        slots[i].valid = 0;
    }
    /* open directory */
    if ( ( dir = opendir( config.dir_name ) ) == 0 ) {
        fprintf( stderr, "init_slots: can't open directory '%s' to read saved games\n",
                 config.dir_name );
        return;
    }
    /* read all directory entries */
    while ( ( entry = readdir( dir ) ) != 0 ) {
        if ( is_saved_game( entry->d_name, &i ) ) {
            sprintf( slots[i].fname, "%s/%s", config.dir_name, entry->d_name );
            if ( ( file = fopen( slots[i].fname, "r" ) ) == 0 ) {
                fprintf( stderr, "'%s': file not found\n", slots[i].fname );
                break;
            }
            /* read slot::name saved there */
            slot_read_name( &slots[i], file );
            fclose( file );
            slots[i].valid = 1;
        }
    }
}

/*
====================================================================
Get full slot name from id.
====================================================================
*/
char *slot_get_name( int id )
{
    if ( id >= SLOT_COUNT ) id = 0;
    return slots[id].name;
}

/*
====================================================================
Get slot's file name. This slot name may be passed to
slot_load/save().
====================================================================
*/
char *slot_get_fname( int id )
{
    if ( id >= SLOT_COUNT ) id = 0;
    return slots[id].fname;
}

/*
====================================================================
Save/load game to/from file.
====================================================================
*/
int slot_save( int id, char *name )
{
    FILE *file = 0;
    char path[512];
    int i, j;
    /* layout:
        slot_name
        campaign loaded
        campaign name (optional)
        campaign scenario id (optional)
        scenario file name
        fog_of_war
        supply
        weather
        current turns
        current player_id
        player info
        unit count
        units
        reinf count
        reinf
        map width
        map height
        map tile units
        map tile flags
    */
    /* get file name */
    sprintf( path, "%s/lg_save_%i", config.dir_name, id );
    /* open file */
    if ( ( file = fopen( path, "w" ) ) == 0 ) {
        fprintf( stderr, "%s: not found\n", path );
        return 0;
    }
    /* update slot name */
    strcpy( slots[id].name, name );
    /* write slot identification */
    slot_write_name( &slots[id], file );
    /* if campaing is set some campaign info follows */
    fwrite( &camp_loaded, sizeof( int ), 1, file );
    if ( camp_loaded ) {
        save_string( file, camp_fname );
        save_string( file, camp_cur_scen->id );
    }
    /* basic data */
    save_string( file, scen_info->fname );
    save_int( file, config.fog_of_war );
    save_int( file, config.supply );
    save_int( file, config.weather );
    save_int( file, turn );
    save_int( file, player_get_index( cur_player ) );
    /* players */
    list_reset( players );
    for ( i = 0; i < players->count; i++ )
        save_player( file, list_next( players ) );
    /* units */
    list_reset( units );
    save_int( file, units->count );
    for ( i = 0; i < units->count; i++ )
        save_unit( file, list_next( units ) );
    /* reinforcements */
    list_reset( reinf );
    save_int( file, reinf->count );
    for ( i = 0; i < reinf->count; i++ )
        save_unit( file, list_next( reinf ) );
    list_reset( avail_units );
    save_int( file, avail_units->count );
    for ( i = 0; i < avail_units->count; i++ )
        save_unit( file, list_next( avail_units ) );
    /* map stuff */
    save_int( file, map_w );
    save_int( file, map_h );
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            save_map_tile_units( file, map_tile( i, j ) );
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            save_map_tile_flag( file, map_tile( i, j ) );
    fclose( file );
    /* is valid now */
    slots[id].valid = 1;
    return 1;
}
int slot_load( int id )
{
    FILE *file = 0;
    char path[512];
    int camp_saved;
    int i, j;
    char *scen_file_name = 0;
    int unit_count;
    char *str;
    /* get file name */
    sprintf( path, "%s/lg_save_%i", config.dir_name, id );
    /* open file */
#ifdef WIN32
    if ( ( file = fopen( path, "rb" ) ) == 0 ) {
#else
    if ( ( file = fopen( path, "r" ) ) == 0 ) {
#endif
        fprintf( stderr, "%s: not found\n", path );
        return 0;
    }
    /* read slot identification -- won't change anything but the file handle needs to move */
    slot_read_name( &slots[id], file );
    /* if campaing is set some campaign info follows */
    fread( &camp_saved, sizeof( int ), 1, file );
    camp_delete();
    if ( camp_saved ) {
        /* reload campaign and set to current scenario id */
        str = load_string( file );
        camp_load( str );
        free( str );
        str = load_string( file );
        camp_set_cur( str );
        free( str );
    }
    /* the scenario that is loaded now is the one that belongs to the scenario id of the campaign above */
    /* read scenario file name */
    scen_file_name = load_string( file );
    if ( !scen_load( scen_file_name ) ) {
        free( scen_file_name );
        return 0;
    }
    free( scen_file_name );
    /* basic data */
    config.fog_of_war = load_int( file );
    config.supply = load_int( file );
    config.weather = load_int( file );
    turn = load_int( file );
    cur_player = player_get_by_index( load_int( file ) );
    cur_weather = scen_get_weather();
    /* players */
    list_reset( players );
    for ( i = 0; i < players->count; i++ )
        load_player( file, list_next( players ) );
    /* unit stuff */
    list_clear( units );
    unit_count = load_int( file );
    for ( i = 0; i < unit_count; i++ )
        list_add( units, load_unit( file ) );
    list_clear( reinf );
    unit_count = load_int( file );
    for ( i = 0; i < unit_count; i++ )
        list_add( reinf, load_unit( file ) );
    list_clear( avail_units );
    unit_count = load_int( file );
    for ( i = 0; i < unit_count; i++ )
        list_add( avail_units, load_unit( file ) );
    /* map stuff */
    map_w = load_int( file );
    map_h = load_int( file );
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ ) {
            load_map_tile_units( file, &map[i][j].g_unit, &map[i][j].a_unit );
            if ( map[i][j].g_unit )
                map[i][j].g_unit->terrain = map[i][j].terrain;
            if ( map[i][j].a_unit )
                map[i][j].a_unit->terrain = map[i][j].terrain;
        }
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            load_map_tile_flag( file, &map[i][j].nation, &map[i][j].player );
    fclose( file );
    return 1;
}

/*
====================================================================
Return True if slot is loadable.
====================================================================
*/
int slot_is_valid( int id )
{
    return slots[id].valid;
}
