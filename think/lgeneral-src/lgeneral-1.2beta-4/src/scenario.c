/***************************************************************************
                          scenario.c  -  description
                             -------------------
    begin                : Fri Jan 19 2001
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

#include "lgeneral.h"
#include "parser.h"
#include "date.h"
#include "nation.h"
#include "unit.h"
#include "file.h"
#include "map.h"
#include "scenario.h"

/*
====================================================================
Externals
====================================================================
*/
extern Sdl sdl;
extern Config config;
extern Nation *nations;
extern int nation_count;
extern int nation_flag_width, nation_flag_height;
extern Trgt_Type *trgt_types;
extern int trgt_type_count;
extern Mov_Type *mov_types;
extern int mov_type_count;
extern Unit_Class *unit_classes;
extern int unit_class_count;
extern Map_Tile **map;
extern Mask_Tile **mask;
extern int map_w, map_h;
extern Weather_Type *weather_types;
extern int weather_type_count;
extern List *players;
extern Font *log_font;
extern Setup setup;

/*
====================================================================
Scenario data.
====================================================================
*/
Setup setup;            /* engine setup with scenario information */
Scen_Info *scen_info = 0;
int *weather = 0;       /* weather type for each turn as id to weather_types */
int cur_weather;        /* weather of current turn */
int turn;               /* current turn id */
List *units = 0;        /* active units */
List *vis_units = 0;    /* all units spotted by current player */
List *avail_units = 0;  /* available units for current player to deploy */
List *reinf = 0;        /* reinforcements -- units with a delay (if delay is 0
                           a unit is made available in avail_units if the player
                           controls it. */
Player *player = 0;     /* current player */
int log_x, log_y;       /* position where to draw log info */
/* VICTORY CONDITIONS */
char scen_result[64] = "";  /* the scenario result is saved here */
char scen_message[128] = ""; /* the final scenario message is saved here */
int vcond_check_type = 0;   /* test victory conditions this turn */
VCond *vconds = 0;          /* victory conditions */
int vcond_count = 0;

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Check if subcondition is fullfilled.
====================================================================
*/
static int subcond_check( VSubCond *cond )
{
    Unit *unit;
    int x,y,count;
    if ( cond == 0 ) return 0;
    switch ( cond->type ) {
        case VSUBCOND_CTRL_ALL_HEXES:
            for ( x = 0; x < map_w; x++ )
                for ( y = 0; y < map_h; y++ )
                    if ( map[x][y].player && map[x][y].obj )
                        if ( !player_is_ally( cond->player, map[x][y].player ) )
                            return 0;
            return 1;
        case VSUBCOND_CTRL_HEX:
            if ( map[cond->x][cond->y].player )
                if ( player_is_ally( cond->player, map[cond->x][cond->y].player ) )
                    return 1;
            return 0;
        case VSUBCOND_TURNS_LEFT:
            if ( scen_info->turn_limit - turn > cond->count )
                return 1;
            else
                return 0;
        case VSUBCOND_CTRL_HEX_NUM:
            count = 0;
            for ( x = 0; x < map_w; x++ )
                for ( y = 0; y < map_h; y++ )
                    if ( map[x][y].player && map[x][y].obj )
                        if ( player_is_ally( cond->player, map[x][y].player ) )
                            count++;
            if ( count >= cond->count )
                return 1;
            return 0;
        case VSUBCOND_UNITS_KILLED:
            /* as long as there are units out using this tag this condition
               is not fullfilled */
            list_reset( units );
            while ( ( unit = list_next( units ) ) )
                if ( !unit->killed && !player_is_ally( cond->player, unit->player ) )
                    if ( unit->tag[0] != 0 && STRCMP( unit->tag, cond->tag ) )
                        return 0;
            return 1;
        case VSUBCOND_UNITS_SAVED:
            /* we counted the number of units with this tag so count again
               and if one is missing: bingo */
            list_reset( units ); count = 0;
            while ( ( unit = list_next( units ) ) )
                if ( player_is_ally( cond->player, unit->player ) )
                    if ( unit->tag[0] != 0 && STRCMP( unit->tag, cond->tag ) )
                        count++;
            if ( count == cond->count )
                return 1;
            return 0;
    }
    return 0;
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Load a scenario.
====================================================================
*/
int scen_load( char *fname )
{
    char log_str[256];
    int unit_ref = 0;
    int i, j, x, y, obj;
    Nation *nation;
    PData *pd, *sub, *flag, *subsub;
    PData *pd_vcond, *pd_bind, *pd_vsubcond;
    List *entries, *values, *flags = NULL;
    char path[512];
    char aux[128];
    char *str, *lib;
    Player *player = 0;
    Unit_Lib_Entry *unit_prop = 0, *trsp_prop = 0;
    Unit *unit;
    Unit unit_base; /* used to store values for unit */
    scen_delete();
    sprintf( path, "%s/scenarios/%s", SRC_DIR, fname );
    if ( ( pd = parser_read_file( fname, path ) ) == 0 ) goto parser_failure;
    SDL_FillRect( sdl.screen, 0, 0x0 );
    log_font->align = ALIGN_X_LEFT | ALIGN_Y_TOP;
    log_x = 2; log_y = 2;
    sprintf( log_str, "*** Loading scenario '%s' ***", fname );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    /* get scenario info */
    sprintf( log_str, "Loading Scenario Info");
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    scen_info = calloc( 1, sizeof( Scen_Info ) );
    scen_info->fname = strdup( fname );
    if ( !parser_get_string( pd, "name", &scen_info->name ) ) goto parser_failure;
    if ( !parser_get_string( pd, "desc", &scen_info->desc ) ) goto parser_failure;
    if ( !parser_get_string( pd, "authors", &scen_info->authors ) ) goto parser_failure;
    if ( !parser_get_value( pd, "date", &str, 0 ) ) goto parser_failure;
    str_to_date( &scen_info->start_date, str );
    if ( !parser_get_int( pd, "turns", &scen_info->turn_limit ) ) goto parser_failure;
    if ( !parser_get_int( pd, "turns_per_day", &scen_info->turns_per_day ) ) goto parser_failure;
    if ( !parser_get_int( pd, "days_per_turn", &scen_info->days_per_turn ) ) goto parser_failure;
    if ( !parser_get_entries( pd, "players", &entries ) ) goto parser_failure;
    scen_info->player_count = entries->count;
    /* nations */
    sprintf( log_str, "Loading Nations" );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    if ( !parser_get_value( pd, "nation_db", &str, 0 ) ) goto parser_failure;
    if ( !nations_load( str ) ) goto failure;
    /* unit libs */
    if ( !parser_get_pdata( pd, "unit_db", &sub ) ) {
        /* check the scenario file itself but only for the main entry */
        sprintf(path, "../scenarios/%s", fname); 
        str = path;
        sprintf( log_str, "Loading Main Unit Library '%s'", str );
        write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
        if ( !unit_lib_load( str, UNIT_LIB_MAIN ) ) goto parser_failure;
    }
    else {
        if ( !parser_get_value( sub, "main", &str, 0 ) ) goto parser_failure;
        sprintf( log_str, "Loading Main Unit Library '%s'", str );
        write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
        if ( !unit_lib_load( str, UNIT_LIB_MAIN ) ) goto parser_failure;
        if ( parser_get_values( sub, "add", &values ) ) {
            list_reset( values );
            while ( ( lib = list_next( values ) ) ) {
                sprintf( log_str, "Loading Additional Unit Library '%s'", lib );
                write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
                if ( !unit_lib_load( lib, UNIT_LIB_ADD ) )
                    goto failure;
            }
        }
    }
    /* map and weather */
    if ( !parser_get_value( pd, "map", &str, 0 ) ) {
        sprintf(path, "../scenarios/%s", fname); /* check the scenario file itself */
        str = path;
    }
    sprintf( log_str, "Loading Map '%s'", str );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    if ( !map_load( str ) ) goto failure;
    weather = calloc( scen_info->turn_limit, sizeof( int ) );
    if ( parser_get_values( pd, "weather", &values ) ) {
        list_reset( values ); i = 0;
        while ( ( str = list_next( values ) ) ) {
            if ( i == scen_info->turn_limit ) break;
            for ( j = 0; j < weather_type_count; j++ )
                if ( STRCMP( str, weather_types[j].id ) ) {
                    weather[i] = j;
                    break;
                }
            i++;
        }
    }
    /* players */
    sprintf( log_str, "Loading Players" );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    if ( !parser_get_entries( pd, "players", &entries ) ) goto parser_failure;
    list_reset( entries );
    while ( ( sub = list_next( entries ) ) ) {
        /* create player */
        player = calloc( 1, sizeof( Player ) );
        player->id = strdup( sub->name );
        if ( !parser_get_string( sub, "name", &player->name ) ) goto parser_failure;
        if ( !parser_get_values( sub, "nations", &values ) ) goto parser_failure;
        player->nation_count = values->count;
        player->nations = calloc( player->nation_count, sizeof( Nation* ) );
        list_reset( values );
        for ( i = 0; i < values->count; i++ )
            player->nations[i] = nation_find( list_next( values ) );
        if ( !parser_get_value( sub, "orientation", &str, 0 ) ) goto parser_failure;
        if ( STRCMP( str, "right" ) ) /* alldirs not implemented yet */
            player->orient = UNIT_ORIENT_RIGHT;
        else
            player->orient = UNIT_ORIENT_LEFT;
        if ( !parser_get_value( sub, "control", &str, 0 ) ) goto parser_failure;
        if ( STRCMP( str, "cpu" ) )
            player->ctrl = PLAYER_CTRL_CPU;
        else
            player->ctrl = PLAYER_CTRL_HUMAN;
        if ( !parser_get_string( sub, "ai_module", &player->ai_fname ) )
            player->ai_fname = strdup( "default" );
        if ( !parser_get_int( sub, "strategy", &player->strat ) ) goto parser_failure;
        if ( parser_get_pdata( sub, "transporters/air", &subsub ) ) {
            if ( !parser_get_value( subsub, "unit", &str, 0 ) ) goto parser_failure;
            player->air_trsp = unit_lib_find( str );
            if ( !parser_get_int( subsub, "count", &player->air_trsp_count ) ) goto parser_failure;
        }
        if ( parser_get_pdata( sub, "transporters/sea", &subsub ) ) {
            if ( !parser_get_value( subsub, "unit", &str, 0 ) ) goto parser_failure;
            player->sea_trsp = unit_lib_find( str );
            if ( !parser_get_int( subsub, "count", &player->sea_trsp_count ) ) goto parser_failure;
        }
        /* PURCHASE: 
           set starting prestige to 200 as default if no entry found,
           set prestige_per_turn to 0 as default */
        player->prestige = 200;  parser_get_int( sub, "start_prestige", &player->prestige );
        player->prestige_per_turn = 0; parser_get_int( sub, "prestige_per_turn", &player->prestige_per_turn ); 
        player_add( player ); player = 0;
    }
    /* set alliances */
    list_reset( players );
    for ( i = 0; i < players->count; i++ ) {
        player = list_next( players );
        player->allies = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
        sprintf( path, "players/%s/allied_players", player->id );
        if ( parser_get_values( pd, path, &values ) ) {
            list_reset( values );
            for ( j = 0; j < values->count; j++ )
                list_add( player->allies, player_get_by_id( list_next( values ) ) );
        }
        player = 0; // .. fixes crash in delete_player()/free() if flags fail to load..
    }
    /* flags */
    sprintf( log_str, "Loading Flags" );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    if ( !parser_get_entries( pd, "flags", &flags ) ) goto parser_failure;
    list_reset( flags );
    while ( ( flag = list_next( flags ) ) ) {
        if ( !parser_get_int( flag, "x", &x ) ) goto parser_failure;
        if ( !parser_get_int( flag, "y", &y ) ) goto parser_failure;
        obj = 0; parser_get_int( flag, "obj", &obj );
        if ( !parser_get_value( flag, "nation", &str, 0 ) ) goto parser_failure;
        nation = nation_find( str );
        map[x][y].nation = nation;
        map[x][y].player = player_get_by_nation( nation );
        if ( map[x][y].nation )
            map[x][y].deploy_center = 1;
        map[x][y].obj = obj;
    }

    /* victory conditions */
    scen_result[0] = 0;
    sprintf( log_str, "Loading Victory Conditions" );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    /* check type */
    vcond_check_type = VCOND_CHECK_EVERY_TURN;
    if ( parser_get_value( pd, "result/check", &str, 0 ) ) {
        if ( STRCMP( str, "last_turn" ) )
            vcond_check_type = VCOND_CHECK_LAST_TURN;
    }
    if ( !parser_get_entries( pd, "result", &entries ) ) goto parser_failure;
    /* reset vic conds may not be done in scen_delete() as this is called
       before the check */
    scen_result[0] = 0;
    scen_message[0] = 0;
    /* count conditions */
    list_reset( entries ); i = 0;
    while ( ( pd_vcond = list_next( entries ) ) )
        if ( STRCMP( pd_vcond->name, "cond" ) ) i++;
    vcond_count = i + 1;
    /* create conditions */
    vconds = calloc( vcond_count, sizeof( VCond ) );
    list_reset( entries ); i = 1; /* the very first condition is the else condition */
    while ( ( pd_vcond = list_next( entries ) ) ) {
        if ( STRCMP( pd_vcond->name, "cond" ) ) {
            /* result & message */
            if ( parser_get_value( pd_vcond, "result", &str, 0 ) )
                strcpy_lt( vconds[i].result, str, 63 );
            else
                strcpy( vconds[i].result, "undefined" );
            if ( parser_get_value( pd_vcond, "message", &str, 0 ) )
                strcpy_lt( vconds[i].message, str, 127 );
            else
                strcpy( vconds[i].message, "undefined" );
            /* and linkage */
            if ( parser_get_pdata( pd_vcond, "and", &pd_bind ) ) {
                vconds[i].sub_and_count = pd_bind->entries->count;
                /* create subconditions */
                vconds[i].subconds_and = calloc( vconds[i].sub_and_count, sizeof( VSubCond ) );
                list_reset( pd_bind->entries ); j = 0;
                while ( ( pd_vsubcond = list_next( pd_bind->entries ) ) ) {
                    /* get subconds */
                    if ( STRCMP( pd_vsubcond->name, "control_all_hexes" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_CTRL_ALL_HEXES;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_and[j].player = player_get_by_id( str );
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "control_hex" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_CTRL_HEX;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_and[j].player = player_get_by_id( str );
                        if ( !parser_get_int( pd_vsubcond, "x", &vconds[i].subconds_and[j].x ) ) goto parser_failure;
                        if ( !parser_get_int( pd_vsubcond, "y", &vconds[i].subconds_and[j].y ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "turns_left" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_TURNS_LEFT;
                        if ( !parser_get_int( pd_vsubcond, "count", &vconds[i].subconds_and[j].count ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "control_hex_num" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_CTRL_HEX_NUM;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_and[j].player = player_get_by_id( str );
                        if ( !parser_get_int( pd_vsubcond, "count", &vconds[i].subconds_and[j].count ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "units_killed" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_UNITS_KILLED;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_and[j].player = player_get_by_id( str );
                        if ( !parser_get_value( pd_vsubcond, "tag", &str, 0 ) ) goto parser_failure;
                        strcpy_lt( vconds[i].subconds_and[j].tag, str, 31 );
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "units_saved" ) ) {
                        vconds[i].subconds_and[j].type = VSUBCOND_UNITS_SAVED;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_and[j].player = player_get_by_id( str );
                        if ( !parser_get_value( pd_vsubcond, "tag", &str, 0 ) ) goto parser_failure;
                        strcpy_lt( vconds[i].subconds_and[j].tag, str, 31 );
                        vconds[i].subconds_and[j].count = 0; /* units will be counted */
                    }
                    j++;
                }
            }
            /* or linkage */
            if ( parser_get_pdata( pd_vcond, "or", &pd_bind ) ) {
                vconds[i].sub_or_count = pd_bind->entries->count;
                /* create subconditions */
                vconds[i].subconds_or = calloc( vconds[i].sub_or_count, sizeof( VSubCond ) );
                list_reset( pd_bind->entries ); j = 0;
                while ( ( pd_vsubcond = list_next( pd_bind->entries ) ) ) {
                    /* get subconds */
                    if ( STRCMP( pd_vsubcond->name, "control_all_hexes" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_CTRL_ALL_HEXES;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_or[j].player = player_get_by_id( str );
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "control_hex" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_CTRL_HEX;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_or[j].player = player_get_by_id( str );
                        if ( !parser_get_int( pd_vsubcond, "x", &vconds[i].subconds_or[j].x ) ) goto parser_failure;
                        if ( !parser_get_int( pd_vsubcond, "y", &vconds[i].subconds_or[j].y ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "turns_left" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_TURNS_LEFT;
                        if ( !parser_get_int( pd_vsubcond, "count", &vconds[i].subconds_or[j].count ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "control_hex_num" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_CTRL_HEX_NUM;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_or[j].player = player_get_by_id( str );
                        if ( !parser_get_int( pd_vsubcond, "count", &vconds[i].subconds_or[j].count ) ) goto parser_failure;
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "units_killed" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_UNITS_KILLED;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_or[j].player = player_get_by_id( str );
                        if ( !parser_get_value( pd_vsubcond, "tag", &str, 0 ) ) goto parser_failure;
                        strcpy_lt( vconds[i].subconds_or[j].tag, str, 31 );
                    }
                    else
                    if ( STRCMP( pd_vsubcond->name, "units_saved" ) ) {
                        vconds[i].subconds_or[j].type = VSUBCOND_UNITS_SAVED;
                        if ( !parser_get_value( pd_vsubcond, "player", &str, 0 ) ) goto parser_failure;
                        vconds[i].subconds_or[j].player = player_get_by_id( str );
                        if ( !parser_get_value( pd_vsubcond, "tag", &str, 0 ) ) goto parser_failure;
                        strcpy_lt( vconds[i].subconds_or[j].tag, str, 31 );
                        vconds[i].subconds_or[j].count = 0; /* units will be counted */
                    }
                    j++;
                }
            }
            /* no sub conditions at all? */
            if ( vconds[i].sub_and_count == 0 && vconds[i].sub_or_count == 0 ) {
                fprintf( stderr, "No subconditions specified!\n" );
                goto failure;
            }
            /* next condition */
            i++;
        }
    }
    /* else condition (used if no other condition is fullfilled and scenario ends) */
    strcpy( vconds[0].result, "defeat" );
    strcpy( vconds[0].message, "Defeat" );
    if ( parser_get_pdata( pd, "result/else", &pd_vcond ) ) {
        if ( parser_get_value( pd_vcond, "result", &str, 0 ) )
            strcpy_lt( vconds[0].result, str, 63 );
        if ( parser_get_value( pd_vcond, "message", &str, 0 ) )
            strcpy_lt( vconds[0].message, str, 127 );
    }
    /* units */
    sprintf( log_str, "Loading Units" );
    write_line( sdl.screen, log_font, log_str, log_x, &log_y ); refresh_screen( 0, 0, 0, 0 );
    units = list_create( LIST_AUTO_DELETE, unit_delete );
    reinf = list_create( LIST_AUTO_DELETE, unit_delete );
    avail_units = list_create( LIST_AUTO_DELETE, unit_delete );
    vis_units = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
    if ( !parser_get_entries( pd, "units", &entries ) ) goto parser_failure;
    list_reset( entries );
    while ( ( sub = list_next( entries ) ) ) {
        /* unit type */
        if ( !parser_get_value( sub, "id", &str, 0 ) ) goto parser_failure;
        if ( ( unit_prop = unit_lib_find( str ) ) == 0 ) {
            fprintf( stderr, "%s: unit entry not found\n", str );
            goto failure;
        }
        memset( &unit_base, 0, sizeof( Unit ) );
        /* nation & player */
        if ( !parser_get_value( sub, "nation", &str, 0 ) ) goto parser_failure;
        if ( ( unit_base.nation = nation_find( str ) ) == 0 ) {
            fprintf( stderr, "%s: not a nation\n", str );
            goto failure;
        }
        if ( ( unit_base.player = player_get_by_nation( unit_base.nation ) ) == 0 ) {
            fprintf( stderr, "%s: no player controls this nation\n", unit_base.nation->name );
            goto failure;
        }
        /* name */
        switch ( ( unit_ref + 1 ) % 10 ) {
            case 1: sprintf( aux, "%ist %s", unit_ref + 1, unit_prop->name ); break;
            case 2: sprintf( aux, "%ind %s", unit_ref + 1, unit_prop->name ); break;
            case 3: sprintf( aux, "%ird %s", unit_ref + 1, unit_prop->name ); break;
            default: sprintf( aux, "%ith %s", unit_ref + 1, unit_prop->name ); break;
        }
        strcpy_lt( unit_base.name, aux, 20 );
        /* delay */
        parser_get_int( sub, "delay", &unit_base.delay );
        /* position */
        if ( !parser_get_int( sub, "x", &unit_base.x ) && !unit_base.delay ) goto parser_failure;
        if ( !parser_get_int( sub, "y", &unit_base.y ) && !unit_base.delay ) goto parser_failure;
        if ( !unit_base.delay && ( unit_base.x <= 0 || unit_base.y <= 0 || unit_base.x >= map_w - 1 || unit_base.y >= map_h - 1 ) ) {
            fprintf( stderr, "%s: out of map: ignored\n", unit_base.name );
            continue;  
        }
        /* strengt, entrenchment, experience */
        if ( !parser_get_int( sub, "str", &unit_base.str ) ) goto parser_failure;
        if ( !parser_get_int( sub, "entr", &unit_base.entr ) ) goto parser_failure;
        if ( !parser_get_int( sub, "exp", &unit_base.exp_level ) ) goto parser_failure;
        /* transporter */
        trsp_prop = 0;
        if ( parser_get_value( sub, "trsp", &str, 0 ) && !STRCMP( str, "none" ) )
            trsp_prop = unit_lib_find( str );
        /* orientation */
        unit_base.orient = unit_base.player->orient;
        /* tag if set */
        unit_base.tag[0] = 0;
        if ( parser_get_value( sub, "tag", &str, 0 ) ) {
            strcpy_lt( unit_base.tag, str, 31 );
            /* check all subconds for UNITS_SAVED and increase the counter
               if this unit is allied */
            for ( i = 1; i < vcond_count; i++ ) {
                for ( j = 0; j < vconds[i].sub_and_count; j++ )
                    if ( vconds[i].subconds_and[j].type == VSUBCOND_UNITS_SAVED )
                        if ( STRCMP( unit_base.tag, vconds[i].subconds_and[j].tag ) )
                            vconds[i].subconds_and[j].count++;
                for ( j = 0; j < vconds[i].sub_or_count; j++ )
                    if ( vconds[i].subconds_or[j].type == VSUBCOND_UNITS_SAVED )
                        if ( STRCMP( unit_base.tag, vconds[i].subconds_or[j].tag ) )
                            vconds[i].subconds_or[j].count++;
            }
        }
        /* actual unit */
        unit = unit_create( unit_prop, trsp_prop, &unit_base );
        /* put unit to active or reinforcements list */
        if ( unit->delay == 0 ) {
            list_add( units, unit );
            /* add unit to map */
            map_insert_unit( unit );
        }
        else 
            list_add( reinf, unit );
        /* adjust transporter count */
        if ( unit->embark == EMBARK_SEA ) {
            unit->player->sea_trsp_count++;
            unit->player->sea_trsp_used++;
        }
        else
            if ( unit->embark == EMBARK_AIR ) {
                unit->player->air_trsp_count++;
                unit->player->air_trsp_used++;
            }
        unit_ref++;
    }
    parser_free( &pd );
    return 1;
parser_failure:        
    fprintf( stderr, "%s\n", parser_get_error() );
failure:
    terrain_delete();
    scen_delete();
    if ( player ) player_delete( player );
    if ( pd ) parser_free( &pd );
    return 0;
}

/*
====================================================================
Load a scenario description.
====================================================================
*/
char* scen_load_info( char *fname )
{
    PData *pd, *sub;
    char path[512];
    List *entries;
    char *name, *desc, *turns, count[4], *str;
    char *info = 0;
    int i;
    sprintf( path, "%s/scenarios/%s", SRC_DIR, fname );
    if ( ( pd = parser_read_file( fname, path ) ) == 0 ) goto parser_failure;
    /* title and description */
    if ( !parser_get_value( pd, "name", &name, 0 ) ) goto parser_failure;
    if ( !parser_get_value( pd, "desc", &desc, 0 ) ) goto parser_failure;
    if ( !parser_get_entries( pd, "players", &entries ) ) goto parser_failure;
    if ( !parser_get_value( pd, "turns", &turns, 0 ) ) goto parser_failure;
    sprintf( count, "%i",  entries->count );
    if ( ( info = calloc( strlen( name ) + strlen( desc ) + strlen( count ) + strlen( turns ) + 30, sizeof( char ) ) ) == 0 ) {
        fprintf( stderr, "Out of memory\n" );
        goto failure;
    }
    sprintf( info, "%s##%s##%s Turns#%s Players", name, desc, turns, count );
    /* set setup */
    scen_clear_setup();
    strcpy( setup.fname, fname );
    setup.player_count = entries->count;
    setup.ctrl = calloc( setup.player_count, sizeof( int ) );
    setup.names = calloc( setup.player_count, sizeof( char* ) );
    setup.modules = calloc( setup.player_count, sizeof( char* ) );
    /* load the player ctrls */
    list_reset( entries ); i = 0;
    while ( ( sub = list_next( entries ) ) ) {
        if ( !parser_get_string( sub, "name", &setup.names[i] ) ) goto parser_failure;
        if ( !parser_get_value( sub, "control", &str, 0 ) ) goto parser_failure;
        if ( STRCMP( str, "cpu" ) )
            setup.ctrl[i] = PLAYER_CTRL_CPU;
        else
            setup.ctrl[i] = PLAYER_CTRL_HUMAN;
        if ( !parser_get_string( sub, "ai_module", &setup.modules[i] ) )
            setup.modules[i] = strdup( "default" );
        i++;
    }
    parser_free( &pd );
    return info;
parser_failure:        
    fprintf( stderr, "%s\n", parser_get_error() );
failure:
    if ( pd ) parser_free( &pd );
    if ( info ) free( info );
    return 0;
}

/*
====================================================================
Fill the scenario part in 'setup' with the loaded player 
information.
====================================================================
*/
void scen_set_setup()
{
    int i;
    Player *player;
    scen_clear_setup();
    setup.player_count = players->count;
    setup.ctrl = calloc( setup.player_count, sizeof( int ) );
    setup.names = calloc( setup.player_count, sizeof( char* ) );
    setup.modules = calloc( setup.player_count, sizeof( char* ) );
    list_reset( players );
    for ( i = 0; i < setup.player_count; i++ ) {
        player = list_next( players );
        setup.ctrl[i] = player->ctrl;
        setup.names[i] = strdup( player->name );
        setup.modules[i] = strdup( player->ai_fname );
    }
}

/*
====================================================================
Clear the pointers in 'setup' which were loaded by scen_load_info()
====================================================================
*/
void scen_clear_setup()
{
    int i;
    if ( setup.ctrl ) {
        free( setup.ctrl ); 
        setup.ctrl = 0;
    }
    if ( setup.names ) {
        for ( i = 0; i < setup.player_count; i++ )
            if ( setup.names[i] ) free( setup.names[i] );
        free( setup.names ); setup.names = 0;
    }
    if ( setup.modules ) {
        for ( i = 0; i < setup.player_count; i++ )
            if ( setup.modules[i] ) free( setup.modules[i] );
        free( setup.modules ); setup.modules = 0;
    }
    setup.player_count = 0;
}

/*
====================================================================
Delete scenario
====================================================================
*/
void scen_delete()
{
    int i;
    turn = 0;
    cur_weather = 0;
    if ( scen_info ) {
        if ( scen_info->fname ) free( scen_info->fname );
        if ( scen_info->name ) free( scen_info->name );
        if ( scen_info->desc ) free( scen_info->desc );
        if ( scen_info->authors ) free( scen_info->authors );
        free( scen_info ); scen_info = 0;
    }
    if ( weather ) {
        free( weather ); weather = 0;
    }
    if ( vconds ) {
        for ( i = 0; i < vcond_count; i++ ) {
            if ( vconds[i].subconds_and )
                free( vconds[i].subconds_and );
            if ( vconds[i].subconds_or )
                free( vconds[i].subconds_or );
        }
        free( vconds ); vconds = 0;
        vcond_count = 0;
    }
    if ( units ) {
        list_delete( units );
        units = 0;
    }
    if ( vis_units ) {
        list_delete( vis_units );
        vis_units = 0;
    }
    if ( avail_units ) {
        list_delete( avail_units );
        avail_units = 0;
    }
    if ( reinf ) {
        list_delete( reinf );
        reinf = 0;
    }
    nations_delete();
    unit_lib_delete();
    players_delete();
    map_delete();
}

/*
====================================================================
Check if unit is destroyed, set the current attack and movement.
If SCEN_PREP_UNIT_FIRST is passed the entrenchment is not modified.
====================================================================
*/
void scen_prep_unit( Unit *unit, int type )
{
    int min_entr, max_entr;
    /* unit may not be undeployed */
    unit->fresh_deploy = 0;
    /* crash air planes */
    if ( unit_check_fuel_usage( unit ) && unit->cur_fuel == 0 && unit->sel_prop->flags & FLYING ) 
        unit->killed = 1;
    /* supply -- aircrafts are handled extra!!! */
    if (!(unit->prop.flags & FLYING))
    if ( unit->unused && unit->supply_level > 0 )
        unit_supply( unit, UNIT_SUPPLY_ALL );
    /* remove turn suppression */
    unit->turn_suppr = 0;
    /* allow actions */
    unit->unused = 1;
    unit->cur_mov = unit->sel_prop->mov;
    if ( unit_check_ground_trsp( unit ) )
        unit->cur_mov = unit->trsp_prop.mov;
    /* if we have bad weather the relation between mov : fuel is 1 : 2 */
    if ( weather_types[scen_get_weather()].flags & DOUBLE_FUEL_COST ) {
        if ( unit_check_fuel_usage( unit ) && unit->cur_fuel < unit->cur_mov * 2 )
            unit->cur_mov = unit->cur_fuel / 2;
    }
    else
        if ( unit_check_fuel_usage( unit ) && unit->cur_fuel < unit->cur_mov )
            unit->cur_mov = unit->cur_fuel;
    unit_unmount( unit );
    unit->cur_atk_count = unit->sel_prop->atk_count;
    /* if unit is preparded normally check entrenchment */
    if ( type == SCEN_PREP_UNIT_NORMAL && !(unit->sel_prop->flags & FLYING) ) {
        min_entr = map_tile( unit->x, unit->y )->terrain->min_entr;
        max_entr = map_tile( unit->x,unit->y )->terrain->max_entr;
        if ( unit->entr < min_entr )
            unit->entr = min_entr;
        else
            if ( unit->entr >= max_entr )
                unit->entr = max_entr;
            else
                unit->entr++;
    }
}

/*
====================================================================
Check if the victory conditions are fullfilled and if so
return True. 'result' is used then
to determine the next scenario in the campaign.
If 'after_last_turn' is set this is the check called by end_turn().
If no condition is fullfilled the else condition is used (very 
first one).
====================================================================
*/
int scen_check_result( int after_last_turn )
{
    int i, j, and_okay, or_okay;
    if ( vcond_check_type == VCOND_CHECK_EVERY_TURN || after_last_turn ) {
        for ( i = 1; i < vcond_count; i++ ) {
            /* AND binding */
            and_okay = 1;
            for ( j = 0; j < vconds[i].sub_and_count; j++ )
                if ( !subcond_check( &vconds[i].subconds_and[j] ) ) {
                    and_okay = 0;
                    break;
            }
            /* OR binding */
            or_okay = 0;
            for ( j = 0; j < vconds[i].sub_or_count; j++ )
                if ( subcond_check( &vconds[i].subconds_or[j] ) ) {
                    or_okay = 1;
                    break;
                }
            if ( vconds[i].sub_or_count == 0 ) 
                or_okay = 1;
            if ( or_okay && and_okay ) {
                strcpy( scen_result, vconds[i].result );
                strcpy( scen_message, vconds[i].message );
                return 1;
            }
        }
    }
    if ( after_last_turn ) {
        strcpy( scen_result, vconds[0].result );
        strcpy( scen_message, vconds[0].message );
        return 1;
    }
    return 0;
}
/*
====================================================================
Return True if scenario is done.
====================================================================
*/
int scen_done()
{
    return scen_result[0] != 0;
}
/*
====================================================================
Return result string.
====================================================================
*/
char *scen_get_result()
{
    return scen_result;
}
/*
====================================================================
Return result message
====================================================================
*/
char *scen_get_result_message()
{
    return scen_message;
}
/*
====================================================================
Clear result and message
====================================================================
*/
void scen_clear_result()
{
    scen_result[0] = 0;
    scen_message[0] = 0;
}

/*
====================================================================
Check the supply level of a unit. (hex tiles with SUPPLY_GROUND
have 100% supply)
====================================================================
*/
int is_close_to_harbor( Unit *unit )
{
    int i;
    if ( map_is_allied_depot( &map[unit->x][unit->y], unit ) )
        return 1;
    for ( i = 0; i < 6; i++ )
        if ( map_is_allied_depot( map_get_close_hex( unit->x, unit->y, i ), unit ) )
            return 1;
    return 0;
}
int is_close_to_airfield( Unit *unit )
{
    int i;
    if ( map_is_allied_depot( &map[unit->x][unit->y], unit ) )
        return 1;
    for ( i = 0; i < 6; i++ )
        if ( map_is_allied_depot( map_get_close_hex( unit->x, unit->y, i ), unit ) )
            return 1;
    return 0;
}
void scen_adjust_unit_supply_level( Unit *unit )
{
    int x, y, w, h, i, j;
    int flag_supply_level;
    /* flying and swimming units get a 100% supply if near an airfield or a harbour */
    if ( unit->sel_prop->flags & SWIMMING ) {
        unit->supply_level = 0;
        if ( is_close_to_harbor( unit ) ) unit->supply_level = 100;
    }
    else
    if ( unit->sel_prop->flags & FLYING ) {
        unit->supply_level = 0;
        if ( is_close_to_airfield( unit ) ) unit->supply_level = 100;
    }
    else {
        /* ground units get a 100% close to a flag and looses about 10% for each title it gets away */
        /* test all flags within a region x-10,y-10,20,20 about their distance */
        /* get region first */
        x = unit->x - 10; y = unit->y - 10; w = 20; h = 20;
        if ( x < 0 ) { w += x; x = 0; }
        if ( y < 0 ) { h += y; y = 0; }
        if ( x + w > map_w ) w = map_w - x;
        if ( y + h > map_h ) h = map_h - y;
        /* now check flags */
        unit->supply_level = 0;
        for ( i = x; i < x + w; i++ )
            for ( j = y; j < y + h; j++ )
                if ( map[i][j].player && player_is_ally( unit->player, map[i][j].player ) ) {
                    flag_supply_level = get_dist( unit->x, unit->y, i, j );
                    if ( flag_supply_level < 2 ) flag_supply_level = 100;
                    else {
                        flag_supply_level = 100 - ( flag_supply_level - 1 ) * 10;
                        if ( flag_supply_level < 0 ) flag_supply_level = 0;
                    }
                    if ( flag_supply_level > unit->supply_level )
                        unit->supply_level = flag_supply_level;
                }
    }
    /* if hostile influence is 1 supply's cut in half if influence >1 no supply possible */
    if ( unit->sel_prop->flags & FLYING ) {
        if ( mask[ unit->x][ unit->y ].air_infl > 1 || mask[ unit->x][ unit->y ].infl > 1 )
            unit->supply_level = 0;
        else
            if ( mask[ unit->x][unit->y ].air_infl == 1 || mask[ unit->x][ unit->y ].infl == 1 )
                unit->supply_level /= 2;
    }
    else {
        if ( mask[ unit->x][ unit->y ].infl == 1 )
            unit->supply_level /= 2;
        else
            if ( mask[ unit->x][ unit->y ].infl > 1 )
                unit->supply_level = 0;
    }
}

/*
====================================================================
Get current weather/forecast
====================================================================
*/
int scen_get_weather( void )
{
    if ( turn < scen_info->turn_limit && config.weather )
        return weather[turn];
    else
        return 0;
}
int scen_get_forecast( void )
{
    if ( turn + 1 < scen_info->turn_limit )
        return weather[turn + 1];
    else
        return 0;
}

/*
====================================================================
Get date string of current date.
====================================================================
*/
void scen_get_date( char *date_str )
{
    int hour;
    int phase;
    char buf[256];
    Date date = scen_info->start_date;
    if ( scen_info->days_per_turn > 0 ) {
        date_add_days( &date, scen_info->days_per_turn * turn );
        date_to_str( date_str, date, FULL_NAME_DATE );
    }
    else {
        date_add_days( &date, turn / scen_info->turns_per_day );
        date_to_str( buf, date, FULL_NAME_DATE );
        phase = turn % scen_info->turns_per_day;
        hour = 8 + phase * 6;
        sprintf( date_str, "%s %02i:00", buf, hour );
    }
}
