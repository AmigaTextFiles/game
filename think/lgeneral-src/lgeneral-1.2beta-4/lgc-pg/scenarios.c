/***************************************************************************
                          scenarios.c -  description
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "units.h"
#include "misc.h"
#include "scenarios.h"
#include "parser.h"

#include <SDL_endian.h>

/*
====================================================================
Externals
====================================================================
*/
extern char *source_path;
extern char *dest_path;
extern char *custom_name;
extern int  nation_count;
extern char *nations[];
extern char *weather_types[];

int unit_entry_used[UDB_LIMIT];

/*
====================================================================
The scenario result is determined by a list of conditions.
If any of the conditions turn out to be true the scenario ends,
the message is displayed and result is returned (for campaign).
If there is no result after the LAST turn result and message
of the else struct are used.
A condition has two test fields: one is linked with an 
logical AND the other is linkes with an logical OR. Both
fields must return True if the condition is supposed to be
fullfilled. An empty field does always return True.
Struct:
    result {
        check = every_turn | last_turn
        cond {
               and { test .. testX }
               or  { test .. testY }
               result = ...
               message = ... }
        cond { ... }
        else { result = ... message = ... }
    }
Tests:
  control_hex { player x = ... y = ... } 
      :: control a special victory hex
  control_any_hex { player count = ... } 
      :: control this number of victory
         hexes
  control_all_hexes { player }    
      :: conquer everything important
         on the map
  turns_left { count = ... }      
      :: at least so many turns are left
====================================================================
*/
/*
====================================================================
Scenario file names
====================================================================
*/
char *fnames[] = {
    "Poland",
    "Warsaw",
    "Norway",
    "LowCountries",
    "France",
    "Sealion40",
    "NorthAfrica",
    "MiddleEast",
    "ElAlamein",
    "Caucasus",
    "Sealion43",
    "Torch",
    "Husky",
    "Anzio",
    "D-Day",
    "Anvil",
    "Ardennes",
    "Cobra",
    "MarketGarden",
    "BerlinWest",
    "Balkans",
    "Crete",
    "Barbarossa",
    "Kiev",
    "Moscow41",
    "Sevastapol",
    "Moscow42",
    "Stalingrad",
    "Kharkov",
    "Kursk",
    "Moscow43",
    "Byelorussia",
    "Budapest",
    "BerlinEast",
    "Berlin",
    "Washington",
    "EarlyMoscow",
    "SealionPlus"
};

/*
====================================================================
AI modules names
====================================================================
*/
char *ai_modules[] = {
    /* axis, allied -- scenarios as listed above */
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default",
    "default", "default"
};
/*
====================================================================
Per-turn prestige
====================================================================
*/
int prestige_per_turn[] = {
    /* axis, allied -- scenarios as listed above */
    0, 20,
    0, 20,
    0, 40,
    0, 48,
    0, 45,
    0, 84,
    0, 45,
    0, 70,
    0, 63,
    0, 85,
    0, 103,
    0, 0,
    71, 0,
    47, 0,
    70, 0,
    48, 0,
    0, 75,
    48, 0,
    61, 0,
    70, 0,
    0, 101,
    0, 45,
    0, 60,
    0, 80,
    0, 115,
    0, 63,
    0, 105,
    0, 95,
    0, 55,
    0, 115,
    0, 122,
    47, 0, 
    0, 0,
    70, 0,
    82, 0,
    0, 115,
    0, 135,
    0, 85
};

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Random generator
====================================================================
*/
int seed;
void random_seed( int _seed )
{
    seed = _seed;
}
int random_get( int low, int high )
{
    int p1 = 1103515245;
    int p2 = 12345;
    seed = ( seed * p1 + p2 ) % 2147483647;
    return ( ( abs( seed ) / 3 ) % ( high - low + 1 ) ) + low;
}

/*
====================================================================
Read all flags from MAP%i.SET and add them to dest_file.
We need the scenario file as well as the victory hex positions
are saved there.
====================================================================
*/
int scen_add_flags( FILE *dest_file, FILE *scen_file, int id )
{
    FILE *map_file;
    char path[512];
    int width, height, ibuf;
    int x, y, i, obj;
    int vic_hexes[40]; /* maximum if 20 hexes in PG - terminated with -1 */
    int obj_count = 0;
    /* read victory hexes from scen_file */
    memset( vic_hexes, 0, sizeof(int) * 40 );
    fseek( scen_file, 37, SEEK_SET );

    Sint16 dummy16;
    for ( i = 0; i < 20; i++ ) {
        fread( &dummy16, 2, 1, scen_file );

        vic_hexes[i*2] = SDL_SwapLE16( dummy16 );

        fread( &dummy16, 2, 1, scen_file );

        vic_hexes[i*2+1] = SDL_SwapLE16( dummy16 );

        if ( vic_hexes[i * 2] >= 1000 || vic_hexes[i * 2] < 0 )
            break;
        obj_count++;
    }
    /* open set file */
    sprintf( path, "%s/MAP%02i.SET", source_path, id );
    if ( ( map_file = fopen( path, "r" ) ) == 0 ) {
        sprintf( path, "%s/map%02i.set", source_path, id );
        if ( ( map_file = fopen( path, "r" ) ) == 0 ) {
            fprintf( stderr, "%s: file not found\n", path );
            return 0;
        }
    }
    /* read/write map size */
    width = height = 0;
    fseek( map_file, 101, SEEK_SET );
    fread( &dummy16 /*width*/, 2, 1, map_file );

    width = SDL_SwapLE16( dummy16 );

    fseek( map_file, 103, SEEK_SET );
    fread( &dummy16, 2, 1, map_file );

    height = SDL_SwapLE16( dummy16 );

    width++; height++;
    /* owner info */
    fseek( map_file, 123 + 3 * width * height, SEEK_SET );
    for ( y = 0; y < height; y++ ) {
        for ( x = 0; x < width; x++ ) {
            char c;
            ibuf = 0; fread( &c, 1, 1, map_file );
            ibuf = c;
            if ( ibuf > 0 ) {
                obj = 0;
                for ( i = 0; i < obj_count; i++ )
                    if ( vic_hexes[i * 2] == x && vic_hexes[i * 2 + 1] == y ) {
                        obj = 1; break;
                    }
                fprintf( dest_file, "<flag\nx»%i\ny»%i\nnation»%s\nobj»%i\n>\n", x, y, nations[(ibuf - 1) * 3], obj );
            }
        }
    }
    return 1;
}

/*
====================================================================
Panzer General offers two values: weather condition and weather
region which are used to determine the weather throughout the
scenario. As the historical battle did only occur once the weather
may not change from game to game so we compute the weather of a 
scenario depending on three values:
inital condition, weather region, month
Initial Condition:
    1  clear
    0  rain/snow
Regions:
    0  Desert
    1  Mediterranean
    2  Northern Europe
    3  Eastern Europe
====================================================================
*/
void scen_create_weather( FILE *dest_file, FILE *scen_file, int month, int turns, int allow_rain, int ardennes )
{
    float month_mod[13] = { 0, 1.7, 1.6, 1.0, 2.0, 1.2, 0.7, 0.5, 0.6, 1.4, 1.7, 2.2, 1.7 };
    int med_weather[4] = { 0, 16, 24, 36 };
    int bad_weather[4] = { 0, 8, 12, 18 };
    int i, result;
    int init_cond = 0, region = 0;
    int weather[turns];
    memset( weather, 0, sizeof( int ) * turns );

    char c;

    /* get condition and region */
    fseek( scen_file, 16, SEEK_SET );
    fread( &c /*init_cond*/, 1, 1, scen_file ); init_cond = c;
    fread( &c /*region*/, 1, 1, scen_file ); region = c;
    
    /* compute the weather */
    random_seed( month * turns + ( region + 1 ) * ( init_cond + 1 ) );
    for ( i = 0; i < turns; i++ ) {
        result = random_get( 1, 100 );
        if ( allow_rain && result <= (int)( month_mod[month] * bad_weather[region] ) ) 
            weather[i] = 2;
        else
            if ( result <= (int)( month_mod[month] * med_weather[region] ) )
                weather[i] = 1;
    }
    
    /*
     * The Ardennes-scenario uses special ai in pg, hence it can be
     * assumed it uses special weather conditions, too. The ardennes have
     * bad weather until christmas, when it clears up for about four turns.
     * Afterwards, have bad weather again with a probability of 10% for clearing
     * up until the end of the scenario.
     */
    if (ardennes) {
        for (i = 0; i < 16; i++) weather[i] = 2;
	for (; i < 20; i++) weather[i] = random_get( 0, 1 );
	for (; i < turns; i++)
	    weather[i] = random_get( 1, 100 ) < 10 ? random_get( 0, 1 ) : 2;
    }
    
    /* initial condition */
    weather[0] = (init_cond==1)?0:2;
    /* from december to february turn 2 (rain) into 3 (snow) */
    if ( month < 3 || month == 12 ) {
        for ( i = 0; i < turns; i++ )
            if ( weather[i] == 2 )
                weather[i]++;
    }
   
    /* write weather */
    fprintf( dest_file, "weather»" );
    i = 0;
    while ( i < turns ) {
        fprintf( dest_file, "%s", weather_types[weather[i] * 3] );
        if ( i < turns - 1 )
            fprintf( dest_file, "°" );
        i++;
    }
    fprintf( dest_file, "\n" );
}

/*
====================================================================
Read unit data from scen_file, convert and write it to dest_file.
====================================================================
*/
void scen_create_unit( FILE *dest_file, FILE *scen_file )
{
    int id = 0, nation = 0, x = 0, y = 0, str = 0, entr = 0, exp = 0, trsp_id = 0, org_trsp_id = 0;

    char c;

    /* read unit -- 14 bytes */
    /* icon id */
    Sint16 dummy16;
    fread( &dummy16, 2, 1, scen_file ); /* icon id */

    id = SDL_SwapLE16( dummy16 );

    fread( &dummy16, 2, 1, scen_file ); /* transporter of organic unit */

    org_trsp_id = SDL_SwapLE16( dummy16 );

    fread( &c /*nation*/, 1, 1, scen_file );
    nation = c - 1; /* nation + 1 */

    fread( &dummy16, 2, 1, scen_file ); /* sea/air transport */

    trsp_id = SDL_SwapLE16( dummy16 );

    fread( &dummy16, 2, 1, scen_file ); /* x */

    x = SDL_SwapLE16( dummy16 );

    fread( &dummy16, 2, 1, scen_file ); /* y */

    y = SDL_SwapLE16( dummy16 );

    fread( &c /*str*/, 1, 1, scen_file ); /* strength */
    str = c;

    fread( &c /*entr*/, 1, 1, scen_file ); /* entrenchment */
    entr = c;

    fread( &c /*exp*/, 1, 1, scen_file ); /* experience */
    exp = c;

    /* mark id */
    unit_entry_used[id - 1] = 1;
    if ( trsp_id ) 
        unit_entry_used[trsp_id - 1] = 1;
    else
        if ( org_trsp_id ) 
            unit_entry_used[org_trsp_id - 1] = 1;
    /* write unit */
    fprintf( dest_file, "<unit\n" );
    fprintf( dest_file, "id»%i\nnation»%s\n", id - 1, nations[nation * 3] );
    fprintf( dest_file, "x»%i\ny»%i\n", x, y );
    fprintf( dest_file, "str»%i\nentr»%i\nexp»%i\n", str, entr, exp );
    if ( trsp_id == 0 && org_trsp_id == 0 )
        fprintf( dest_file, "trsp»none\n" );
    else {
        if ( trsp_id ) 
            fprintf( dest_file, "trsp»%i\n", trsp_id - 1 );
        else
            fprintf( dest_file, "trsp»%i\n", org_trsp_id - 1 );
    }
    fprintf( dest_file, ">\n" );
}

/*
====================================================================
Add the victory conditions
====================================================================
*/
int major_limits[] = {
    /* if an entry is not -1 it's a default axis offensive 
       and this is the turn number that must remain for a major
       victory when all flags where captured */
    -1, /* UNUSED */
    3, /* POLAND */
    7, /* WARSAW */
    5, /* NORWAY */
    6, /* LOWCOUNRTIES */
    13, /* FRANCE */
    3, /* SEALION 40 */
    4, /* NORTH AFRICA */
    5, /* MIDDLE EAST */
    3, /* EL ALAMEIN */
    12, /* CAUCASUS */
    3, /* SEALION 43 */
    -1, /* TORCH */
    -1, /* HUSKY */
    -1, /* ANZIO */
    -1, /* D-DAY */
    -1, /* ANVIL */
    -1, /* ARDENNES */
    -1, /* COBRA */
    -1, /* MARKETGARDEN */
    -1, /* BERLIN WEST */
    3, /* BALKANS */
    2, /* CRETE */
    10, /* BARBAROSSA */
    8, /* KIEV */
    4, /* MOSCOW 41 */
    3, /* SEVASTAPOL */
    6, /* MOSCOW 42 */
    13, /*STALINGRAD */
    4, /* KHARKOV */
    -1, /*KURSK */
    5, /* MOSCOW 43*/
    -1, /* BYELORUSSIA */
    5, /* BUDAPEST */
    -1, /* BERLIN EAST */
    -1, /* BERLIN */
    7, /* WASHINGTON */
    5, /* EARLY MOSCOW */
    3, /* SEALION PLUS */
};
#define COND_BEGIN fprintf( file, "<cond\n" )
#define COND_END   fprintf( file, ">\n" )
#define COND_RESULT( str ) fprintf( file, "result»%s\n", str )
#define COND_MESSAGE( str ) fprintf( file, "message»%s\n", str )
void scen_add_vic_conds( FILE *file, int id )
{
    /* for panzer general the check is usually run every turn.
     * exceptions:
     *   ardennes: major/minor victory depends on whether bruessel
     *     can be taken
     *   d-day: axis must hold its initial three objectives until
     *     the end
     *  anvil: axis must hold its initial five objectives until
     *    the end 
     */
    if ( id == 15 || id == 16 || id == 17 )
        fprintf( file, "<result\ncheck»last_turn\n" );
    else
        fprintf( file, "<result\ncheck»every_turn\n" );
    /* add conditions */
    if ( major_limits[id] != -1 ) {
        COND_BEGIN;
        fprintf( file, "<and\n<control_all_hexes\nplayer»axis\n>\n<turns_left\ncount»%i\n>\n>\n", major_limits[id] );
        COND_RESULT( "major" ); 
        COND_MESSAGE( "Axis Major Victory" );
        COND_END;
        COND_BEGIN;
        fprintf( file, "<and\n<control_all_hexes\nplayer»axis\n>\n>\n" );
        COND_RESULT( "minor" ); 
        COND_MESSAGE( "Axis Minor Victory" );
        COND_END;
        fprintf( file, "<else\n" );
        COND_RESULT( "defeat" ); 
        COND_MESSAGE( "Axis Defeat" );
        COND_END;
    }
    else
    if ( id == 17 ) {
        /* ardennes is a special axis offensive */
        COND_BEGIN;
        fprintf( file, "<and\n"\
                       "<control_hex\nplayer»axis\nx»16\ny»16\n>\n"\
                       "<control_hex\nplayer»axis\nx»26\ny»4\n>\n"\
                       "<control_hex\nplayer»axis\nx»27\ny»21\n>\n"\
                       "<control_hex\nplayer»axis\nx»39\ny»21\n>\n"\
                       "<control_hex\nplayer»axis\nx»48\ny»8\n>\n"\
                       "<control_hex\nplayer»axis\nx»54\ny»14\n>\n"\
                       "<control_hex\nplayer»axis\nx»59\ny»18\n>\n"\
                       ">\n" );
        COND_RESULT( "minor" );
        COND_MESSAGE( "Axis Minor Victory" ); 
        COND_END;
        /* major victory */
        COND_BEGIN;
        fprintf( file, "<or\n<control_all_hexes\nplayer»axis\n>\n>\n" );
        COND_RESULT( "major" );
        COND_MESSAGE( "Axis Major Victory" );
        COND_END;
        /* defeat otherwise */
        fprintf( file, "<else\n" );
        COND_RESULT( "defeat" ); 
        COND_MESSAGE( "Axis Defeat" );
        COND_END;
    }
    else {
        /* allied offensives */
        COND_BEGIN;
        switch ( id ) {
            case 12: /* TORCH */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»27\ny»5\n>\n<control_hex_num\nplayer»allies\ncount»6\n>\n>\n" );
                break;
            case 13: /* HUSKY */
                fprintf( file, "<or\n<control_hex_num\nplayer»allies\ncount»14\n>\n>\n" );
                break;
            case 14: /* ANZIO */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»13\ny»17\n>\n<control_hex_num\nplayer»allies\ncount»5\n>\n>\n" );
                break;
            case 15: /* D-DAY */
                fprintf( file, "<or\n<control_hex_num\nplayer»allies\ncount»4\n>\n>\n" );
                break;
            case 16: /* ANVIL */
                fprintf( file, "<or\n<control_hex_num\nplayer»allies\ncount»5\n>\n>\n" );
                break;
            case 18: /* COBRA */
                fprintf( file, "<or\n<control_hex_num\nplayer»allies\ncount»5\n>\n>\n" );
                break;
            case 19: /* MARKET-GARDEN */
                fprintf( file, "<and\n<control_hex\nplayer»allies\nx»37\ny»10\n>\n>\n" );
                break;
            case 20: /* BERLIN WEST */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»36\ny»14\n>\n<control_hex_num\nplayer»allies\ncount»5\n>\n>\n" );
                break;
            case 30: /* KURSK */
                fprintf( file, "<or\n<control_all_hexes\nplayer»allies\n>\n>\n" );
                break;
            case 32: /* BYELORUSSIA */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»3\ny»12\n>\n>\n" );
                break;
            case 34: /* BERLIN EAST */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»36\ny»14\n>\n<control_hex_num\nplayer»allies\ncount»8\n>\n>\n" );
                break;
            case 35: /* BERLIN */
                fprintf( file, "<or\n<control_hex\nplayer»allies\nx»36\ny»14\n>\n>\n" );
                break;
        }
        COND_RESULT( "defeat" );
        COND_MESSAGE( "Axis Defeat" );
        COND_END;
        /* axis major victory condition */
        COND_BEGIN;
        if ( id == 15 )
        {
            /* D-DAY */
            fprintf( file, "<and\n"\
                           "<control_hex\nplayer»axis\nx»11\ny»7\n>\n"\
                           "<control_hex\nplayer»axis\nx»22\ny»28\n>\n"\
                           "<control_hex\nplayer»axis\nx»43\ny»27\n>\n"\
                           ">\n" );
        }
        else if ( id == 16 )
        {
            /* ANVIL */
            fprintf( file, "<and\n"\
                           "<control_hex\nplayer»axis\nx»7\ny»3\n>\n"\
                           "<control_hex\nplayer»axis\nx»15\ny»4\n>\n"\
                           "<control_hex\nplayer»axis\nx»5\ny»22\n>\n"\
                           "<control_hex\nplayer»axis\nx»12\ny»27\n>\n"\
                           "<control_hex\nplayer»axis\nx»31\ny»21\n>\n"\
                           ">\n" );
        }
        else
        {
            /* capture all */
            fprintf( file, "<or\n<control_all_hexes\nplayer»axis\n>\n>\n" );
        }
        COND_RESULT( "major" );
        COND_MESSAGE( "Axis Major Victory" );
        COND_END;
        fprintf( file, "<else\n" );
        COND_RESULT( "minor" ); 
        COND_MESSAGE( "Axis Minor Victory" );
        COND_END;
    }
    /* end result struct */
    fprintf( file, ">\n" );
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
If scen_id == -1 convert all scenarios found in 'source_path'.
If scen_id >= 0 convert single scenario from current working 
directory.
====================================================================
*/
int scenarios_convert( int scen_id )
{
    int i, j;
    char unsigned dummy[256];
    int  day, month, year, turns, turns_per_day, days_per_turn, ibuf;
    int  unit_offset, unit_count;
    int  axis_orient, axis_strat, allied_strat;
    int  prest_bucket[2], prest_int[2], prest_start[2], prest_per_turn[2]; /* axis=0, allied=1 */
    char path[512];
    FILE *dest_file = 0, *scen_file = 0, *aux_file = 0;
    PData *pd = 0, *reinf, *nation, *unit;
    int def_str, def_exp, def_entr;
    char *str, c;

    Sint16 dummy16;

    printf( "  scenarios...\n" );
    sprintf( path, "%s/scenarios/pg", dest_path );
    mkdir( path, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH );
    /* get the reinforcements which are used later */
    if ( scen_id == -1 ) {
        sprintf( path, "%s/convdata/reinf", SRC_DIR );
        if ( ( pd = parser_read_file( "reinforcements", path ) ) == 0 ) {
            fprintf( stderr, "%s\n", parser_get_error() );
            goto failure;
        }
    }
    /* go */
    for ( i = (( scen_id == -1 ) ? 1 : scen_id); 
          i < (( scen_id == -1 ) ? 38 : scen_id) + 1; i++ ) {
        /* open dest file */
        if ( scen_id == -1 )
            sprintf( path, "%s/scenarios/pg/%s", dest_path, fnames[i - 1] );
        else
            sprintf( path, "%s/scenarios/pg/%s", dest_path, custom_name );
        if ( ( dest_file = fopen( path, "w" ) ) == 0 ) {
            fprintf( stderr, "%s: access denied\n", path );
            goto failure;
        }
        /* scenario name and description */
        fprintf( dest_file, "@\n" );
        if ( scen_id == -1 ) {
            if ( ( aux_file = open_file( "SCENSTAT.BIN" ) ) == 0 )
                goto failure;
            fseek( aux_file, 40 + (i - 1) * 14, SEEK_SET );
            fread( dummy, 14, 1, aux_file );
            fprintf( dest_file, "name»%s\n", dummy );
            fseek( aux_file, 600 + (i - 1) * 160 , SEEK_SET );
            fread( dummy, 160, 1, aux_file );
            fprintf( dest_file, "desc»%s\n", dummy );
            fprintf( dest_file, "authors»Strategic Simulation Inc.\n" );
            fclose( aux_file );
        }
        else {
            fprintf( dest_file, "name»%s\n", custom_name );
            fprintf( dest_file, "desc»none\n" );
            fprintf( dest_file, "authors»nobody\n" );
        }
        /* open scenario file */
        sprintf( path, "GAME%03i.SCN", i );
        if ( ( scen_file = open_file( path ) ) == 0 )
            goto failure;
        /* date */
        fseek( scen_file, 22, SEEK_SET );
        day = 0; fread( &c /*day*/, 1, 1, scen_file ); day = c;
        month = 0; fread( &c /*month*/, 1, 1, scen_file ); month = c;
        year = 0; fread( &c /*year*/, 1, 1, scen_file ); year = c;
        fprintf( dest_file, "date»%02i.%02i.19%i\n", day, month, year );
        /* turn limit */
        fseek( scen_file, 21, SEEK_SET );
        turns = 0; fread( &c /*turns*/, 1, 1, scen_file ); turns = c;
        fprintf( dest_file, "turns»%i\n", turns );
        fseek( scen_file, 25, SEEK_SET );
        turns_per_day = 0; fread( &c /*turns_per_day*/, 1, 1, scen_file ); turns_per_day = c;
        fprintf( dest_file, "turns_per_day»%i\n", turns_per_day );
        days_per_turn = 0; fread( &c /*days_per_turn*/, 1, 1, scen_file ); days_per_turn = c;
        if ( turns_per_day == 0 && days_per_turn == 0 )
            days_per_turn = 1;
        fprintf( dest_file, "days_per_turn»%i\n", days_per_turn );
        /* nations */
        fprintf( dest_file, "nation_db»pg.ndb\n" );
        /* units */
        if ( scen_id == -1 || !units_find_panzequp() )
            fprintf( dest_file, "<unit_db\nmain»pg.udb\n>\n" );
        /* if there modified units they are added to the 
           scenario file. lgeneral loads from the scenario file
           if no unit_db was specified. */
        /* map:
           a custom scenario will have the map added to the same file which
           will be checked when no map was specified.
           */
        if ( scen_id == -1 )
            fprintf( dest_file, "map»pg/map%02i\n", i );
        /* weather */
        scen_create_weather( dest_file, scen_file, month, turns,
	                     i != 1 && i != 2, i == 17 );
        /* flags */
        fprintf( dest_file, "<flags\n" );
        if ( !scen_add_flags( dest_file, scen_file, i ) ) goto failure;
        fprintf( dest_file, ">\n" );
        /* get unit offset */
        fseek( scen_file, 117, SEEK_SET );
        ibuf = 0; fread( &c /*ibuf*/, 1, 1, scen_file ); ibuf = c;
        unit_offset = ibuf * 4 + 135;
        /* get prestige data */
        if ( scen_id == -1 )
        {
            fseek( scen_file, 27, SEEK_SET ); fread( &dummy, 6, 1, scen_file );
            prest_bucket[0] = dummy[0] + 256*dummy[1];
            prest_bucket[1] = dummy[2] + 256*dummy[3];
            prest_int[0] = dummy[4]; 
            prest_int[1] = dummy[5];
            fseek( scen_file, 0x75, SEEK_SET ); fread( &dummy, 1, 1, scen_file );
            fseek( scen_file, dummy[0]*4+0x77, SEEK_SET ); fread( &dummy, 4, 1, scen_file );
            prest_start[0] = dummy[0] + 256 * dummy[1];
            prest_start[1] = dummy[2] + 256 * dummy[3];
            /*printf( "%s:\n  axis: %d, %d, %d\n  allies: %d, %d, %d\n",
                    fnames[i-1],
                    prest_start[0], prest_bucket[0], prest_int[0], 
                    prest_start[1], prest_bucket[1], prest_int[1] );*/
            /* use hardcoded prestige_per_turn values */
            prest_per_turn[0] = prestige_per_turn[(i-1)*2];
            prest_per_turn[1] = prestige_per_turn[(i-1)*2+1];
            /* add one per_turn to start as PG does so */
            prest_start[0] += prest_per_turn[0];
            prest_start[1] += prest_per_turn[1];
        }
        else
        {
            prest_bucket[0] = prest_bucket[1] = 0;
            prest_int[0] = prest_int[1] = 0;
            prest_start[0] = prest_start[1] = 0;
            prest_per_turn[0] = prest_per_turn[1] = 0;
        }
        /* players */
        fprintf( dest_file, "<players\n" );
        /* axis */
        fseek( scen_file, 12, SEEK_SET );
        /* orientation */
        axis_orient = 0; fread( &c/*axis_orient*/, 1, 1, scen_file ); axis_orient = c;
        if ( axis_orient == 1 ) 
            sprintf( dummy, "right" );
        else
            sprintf( dummy, "left" );
        /* strategy: -2 (very defensive) to 2 (very aggressive) */
        fseek( scen_file, 15, SEEK_SET );
        axis_strat = 0; fread( &c /*axis_strat*/, 1, 1, scen_file ); axis_strat = c;
        if ( axis_strat == 0 ) 
            axis_strat = 1;
        else
            axis_strat = -1;
        /* definition */
        fprintf( dest_file, "<axis\nname»Axis\n" );
        fprintf( dest_file, "nations»ger°aus°it°hun°bul°rum°fin°esp\n" );
        fprintf( dest_file, "allied_players»\n" );
        fprintf( dest_file, "orientation»%s\ncontrol»human\nstrategy»%i\n", dummy, axis_strat );
        fprintf( dest_file, "start_prestige»%d\nprestige_per_turn»%d\n", prest_start[0], prest_per_turn[0] );
        if ( scen_id == -1 )
            fprintf( dest_file, "ai_module»%s\n", ai_modules[i*2] );
        else
            fprintf( dest_file, "ai_module»default\n" );
        /* transporter */
        fprintf( dest_file, "<transporters\n" );
        /* air */
        fseek( scen_file, unit_offset - 8, SEEK_SET );
        ibuf = 0; fread( &dummy16, 2, 1, scen_file );

        ibuf = SDL_SwapLE16( dummy16 );

        if ( ibuf )
            fprintf( dest_file, "<air\nunit»%i\ncount»50\n>\n", ibuf - 1 );
        /* sea */
        fseek( scen_file, unit_offset - 4, SEEK_SET );
        ibuf = 0; fread( &dummy16, 2, 1, scen_file );

        ibuf = SDL_SwapLE16( dummy16 );

        if ( ibuf )
            fprintf( dest_file, "<sea\nunit»%i\ncount»50\n>\n", ibuf - 1 );
        fprintf( dest_file, ">\n" );
        fprintf( dest_file, ">\n" );
        /* allies */
        if ( axis_orient == 1 )
            sprintf( dummy, "left" );
        else
            sprintf( dummy, "right" );
        if ( axis_strat == 1 )
            allied_strat = -1;
        else
            allied_strat = 1;
        fprintf( dest_file, "<allies\nname»Allies\n" );
        fprintf( dest_file, "nations»bel°lux°den°fra°gre°usa°tur°net°nor°pol°por°so°swe°swi°eng°yug\n" );
        fprintf( dest_file, "allied_players»\n" );
        fprintf( dest_file, "orientation»%s\ncontrol»cpu\nstrategy»%i\n", dummy, allied_strat );
        fprintf( dest_file, "start_prestige»%d\nprestige_per_turn»%d\n", prest_start[1], prest_per_turn[1] );
        if ( scen_id == -1 )
            fprintf( dest_file, "ai_module»%s\n", ai_modules[i*2 + 1] );
        else
            fprintf( dest_file, "ai_module»default\n" );
        /* transporter */
        fprintf( dest_file, "<transporters\n" );
        /* air */
        fseek( scen_file, unit_offset - 6, SEEK_SET );
        ibuf = 0; fread( &dummy16, 2, 1, scen_file );

        ibuf = SDL_SwapLE16( dummy16 );

        if ( ibuf )
            fprintf( dest_file, "<air\nunit»%i\ncount»50\n>\n", ibuf - 1 );
        /* sea */
        fseek( scen_file, unit_offset - 2, SEEK_SET );
        ibuf = 0; fread( &dummy16, 2, 1, scen_file );

        ibuf = SDL_SwapLE16( dummy16 );

        if ( ibuf )
            fprintf( dest_file, "<sea\nunit»%i\ncount»50\n>\n", ibuf - 1 );
        fprintf( dest_file, ">\n" );
        fprintf( dest_file, ">\n" );
        fprintf( dest_file, ">\n" );
        /* victory conditions */
        if ( scen_id == -1 )
            scen_add_vic_conds( dest_file, i );
        else {
            /* and the default is that the attacker must capture
               all targets */
            fprintf( dest_file, "<result\ncheck»every_turn\n" );
            fprintf( dest_file, "<cond\n" );
            fprintf( dest_file, "<and\n<control_all_hexes\nplayer»%s\n>\n>\n",
                     (axis_strat > 0) ? "axis" : "allies" );
            fprintf( dest_file, "result»victory\n" );
            fprintf( dest_file, "message»%s\n", 
                     (axis_strat > 0) ? "Axis Victory" : "Allied Victory" );
            fprintf( dest_file, ">\n" );
            fprintf( dest_file, "<else\n" );
            fprintf( dest_file, "result»defeat\n" );
            fprintf( dest_file, "message»%s\n", 
                     (axis_strat > 0) ? "Axis Defeat" : "Allied Defeat" );
            fprintf( dest_file, ">\n" );
            fprintf( dest_file, ">\n" );
        }
        /* units */
        /* mark all id's that will be used from PANZEQUP.EQP
           for modified unit database */
        memset( unit_entry_used, 0, sizeof( unit_entry_used ) );
        /* count them */
        fseek( scen_file, 33, SEEK_SET );
        ibuf = 0; fread( &c /*ibuf*/, 1, 1, scen_file ); ibuf = c;
        unit_count = ibuf; /* core */
        ibuf = 0; fread( &c /*ibuf*/, 1, 1, scen_file ); ibuf = c;
        unit_count += ibuf; /* allies */
        ibuf = 0; fread( &c /*ibuf*/, 1, 1, scen_file ); ibuf = c;
        unit_count += ibuf; /* auxiliary */
        /* build them */
        fseek( scen_file, unit_offset, SEEK_SET );
        fprintf( dest_file, "<units\n" );
        for ( j = 0; j < unit_count; j++ )
            scen_create_unit( dest_file, scen_file );
        /* reinforcements -- only for original PG scenarios */
        if ( scen_id == -1 ) {
            if ( parser_get_pdata( pd, fnames[i - 1], &reinf ) ) {
                /* there are units stored for this scenario grouped
                   for each nation */
                list_reset( reinf->entries );
                while ( ( nation = list_next( reinf->entries ) ) ) {
                    /* get defaults */
                    def_str = 10; def_exp = 0; def_entr = 0;
                    parser_get_int( nation, "str", &def_str );
                    parser_get_int( nation, "exp", &def_exp );
                    parser_get_int( nation, "entr", &def_entr );
                    /* get units */
                    list_reset( nation->entries );
                    while ( ( unit = list_next( nation->entries ) ) )
                        if ( !strcmp( "unit", unit->name ) ) {
                            /* add unit */
                            fprintf( dest_file, "<unit\n" );
                            fprintf( dest_file, "nation»%s\n", nation->name );
                            if ( !parser_get_int( unit, "id", &ibuf ) )
                                goto failure;
                            fprintf( dest_file, "id»%i\n", ibuf );
                            ibuf = def_str;  parser_get_int( unit, "str", &ibuf );
                            fprintf( dest_file, "str»%i\n", ibuf );
                            ibuf = def_exp;  parser_get_int( unit, "exp", &ibuf );
                            fprintf( dest_file, "exp»%i\n", ibuf );
                            fprintf( dest_file, "entr»0\n" );
                            if ( parser_get_value( unit, "trsp", &str, 0 ) )
                                fprintf( dest_file, "trsp»%s\n", str );
                            if ( !parser_get_int( unit, "delay", &ibuf ) )
                                goto failure;
                            fprintf( dest_file, "delay»%i\n", ibuf );
                            fprintf( dest_file, ">\n" );
                        }
                }
            }
        }
        fprintf( dest_file, ">\n" );
        fclose( scen_file );
        fclose( dest_file );
    }
    parser_free( &pd );
    return 1;
failure:
    parser_free( &pd );
    if ( aux_file ) fclose( aux_file );
    if ( scen_file ) fclose( scen_file );
    if ( dest_file ) fclose( dest_file );
    return 0;
}
