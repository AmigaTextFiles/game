/***************************************************************************
                          units.c -  description
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
#include "shp.h"
#include "units.h"

#include <SDL_endian.h>

/*
====================================================================
Externals
====================================================================
*/
extern char *source_path;
extern char *dest_path;
extern char *custom_name;
extern int unit_entry_used[UDB_LIMIT];

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Write a line to file.
====================================================================
*/
#define WRITE( file, line ) fprintf( file, "%s\n", line )
#define DWRITE( line ) fprintf( file, "%s\n", line )

/*
====================================================================
Icon indices that must be mirrored terminated by -1
====================================================================
*/
int mirror_ids[] = {
    83, 84, 85, 86, 87, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
    102, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114,
    115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126,
    127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138,
    139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
    151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162,
    163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174,
    175, 176, 177, 178, 179, 180, 181 ,182, 183, 184, 185, 186, 
    187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198,
    199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 221,
    232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243,
    244, 250, -1
};


/*
====================================================================
Unit entries are saved to this struct.
====================================================================
*/
typedef struct {     
    char name[20];   
    int  class;
    int  atk_soft;   
    int  atk_hard;   
    int  atk_air;    
    int  atk_naval;  
    int  def_ground; 
    int  def_air;    
    int  def_close;  
    int  target_type;
    int  aaf;        /* air attack flag */
    int  init;        
    int  range;      
    int  spot;       
    int  agf;        /* air ground flag */
    int  move_type;  
    int  move;       
    int  fuel;       
    int  ammo;       
    int  cost;       
    int  pic_id;    
    int  month;      
    int  year;       
    int  last_year; 
} PG_UnitEntry;
/*
====================================================================
Panzer General Definitions.
====================================================================
*/
#define TARGET_TYPE_COUNT 4
char *target_types[] = { 
    "soft",  "Soft", 
    "hard",  "Hard", 
    "air",   "Air", 
    "naval", "Naval" };
enum { 
    INFANTRY = 0,
    TANK, RECON, ANTI_TANK,
    ARTILLERY, ANTI_AIRCRAFT,
    AIR_DEFENSE, FORT, FIGHTER,
    TACBOMBER, LEVBOMBER, SUBMARINE,
    DESTROYER, CAPITAL, CARRIER, 
    LAND_TRANS, AIR_TRANS, SEA_TRANS,
    UNIT_CLASS_COUNT
};
char *unit_classes[] = {
    "inf",      "Infantry",         "infantry",                         
    "tank",     "Tank",             "low_entr_rate°tank",                             
    "recon",    "Recon",            "recon°tank",                            
    "antitank", "Anti-Tank",        "anti_tank",                             
    "art",      "Artillery",        "artillery°suppr_fire°attack_first",                        
    "antiair",  "Anti-Aircraft",    "low_entr_rate",
    "airdef",   "Air-Defense",      "air_defense°attack_first",                      
    "fort",     "Fortification",    "low_entr_rate°suppr_fire",                             
    "fighter",  "Fighter",          "interceptor°carrier_ok°flying",    
    "tacbomb",  "Tactical Bomber",  "bomber°carrier_ok°flying",         
    "levbomb",  "Level Bomber",     "flying°suppr_fire°turn_suppr",                           
    "sub",      "Submarine",        "swimming°diving",                  
    "dest",     "Destroyer",        "destroyer°swimming°suppr_fire",               
    "cap",      "Capital Ship",     "swimming°suppr_fire",                         
    "carrier",  "Aircraft Carrier", "carrier°swimming",                 
    "landtrp",  "Land Transport",   "transporter",                      
    "airtrp",   "Air Transport",    "transporter°flying",               
    "seatrp",   "Sea Transport",    "transporter°swimming",             
};
int move_type_count = 8;
char *move_types[] = {
    "tracked",     "Tracked",       "pg/tracked.wav",
    "halftracked", "Halftracked",   "pg/tracked.wav",
    "wheeled",     "Wheeled",       "pg/wheeled.wav",
    "leg",         "Leg",           "pg/leg.wav",
    "towed",       "Towed",         "pg/leg.wav",
    "air",         "Air",           "pg/air.wav",
    "naval",       "Naval",         "pg/sea.wav",
    "allterrain",  "All Terrain",   "pg/wheeled.wav"
};
/*
====================================================================
Additional flags for special units.
====================================================================
*/
char *add_flags[] = {
    "47",  "ignore_entr",
    "108", "parachute",
    "109", "parachute",
    "214", "bridge_eng",
    "215", "parachute",
    "226", "parachute",
    "270", "parachute",
    "275", "bridge_eng",
    "329", "bridge_eng",
    "382", "parachute",
    "383", "parachute",
    /* 385, 386 ??? */
    "387", "bridge_eng",
    "415", "parachute",
    "X"
};

/*
====================================================================
Copy file
====================================================================
*/
void copy( char *sname, char *dname )
{
    int size;
    char *buffer;
    FILE *source, *dest;
    if ( ( source = fopen( sname, "r" ) ) == 0 ){
        fprintf( stderr, "%s: file not found\n", sname );
        return;
    }
    if ( ( dest = fopen( dname, "w" ) ) == 0 ) {
        fprintf( stderr, "%s: write access denied\n", dname );
        return;
    }
    fseek( source, 0, SEEK_END ); 
    size = ftell( source );
    fseek( source, 0, SEEK_SET );
    buffer = calloc( size, sizeof( char ) );

    fread( buffer, sizeof( char ), size, source );
    fwrite( buffer, sizeof( char ), size, dest );
    free( buffer );
    fclose( source );
    fclose( dest );
}

/*
====================================================================
Load PG unit entry from file position.
DOS entry format (50 bytes):
 NAME   0
 CLASS 20
 SA    21
 HA    22
 AA    23
 NA    24
 GD    25
 AD    26
 CD    27
 TT    28
 AAF   29
 ???   30
 INI   31
 RNG   32
 SPT   33
 GAF   34    
 MOV_TYPE 35
 MOV   36
 FUEL  37
 AMMO  38
 ???   39
 ???   40
 COST  41    
 BMP   42
 ???   43
 ???   44
 ???   45
 MON   46
 YR    47
 LAST_YEAR 48 
 ???   49
 ====================================================================
*/
static int units_read_entry( FILE *file, PG_UnitEntry *entry )
{
    char dummy[24], c;
    if ( feof( file ) ) return 0;

    memset( entry, 0, sizeof( PG_UnitEntry ) );

    fread( entry->name, 1, 20, file );

    fread( &c, 1, 1, file );
    entry->class = c;

    fread( &c, 1, 1, file );
    entry->atk_soft = c;

    fread( &c, 1, 1, file );
	entry->atk_hard = c;

    fread( &c, 1, 1, file );
	entry->atk_air = c;

    fread( &c, 1, 1, file );
	entry->atk_naval = c;

    fread( &c, 1, 1, file );
	entry->def_ground = c;

    fread( &c, 1, 1, file );
	entry->def_air = c;

    fread( &c, 1, 1, file );
	entry->def_close = c;

    fread( &c, 1, 1, file );
	entry->target_type = c;

    fread( &c, 1, 1, file );
	entry->aaf = c;

    fread( dummy, 1, 1, file );

    fread( &c, 1, 1, file );
	entry->init = c;

    fread( &c, 1, 1, file );
	entry->range = c;

    fread( &c, 1, 1, file );
	entry->spot = c;

    fread( &c, 1, 1, file );
	entry->agf = c;

    fread( &c, 1, 1, file );
	entry->move_type = c;

    fread( &c, 1, 1, file );
	entry->move = c;

    fread( &c, 1, 1, file );
	entry->fuel = c;

    fread( &c, 1, 1, file );
	entry->ammo = c;

    fread( dummy, 2, 1, file );

    fread( &c, 1, 1, file );
	entry->cost = c * 10;

    fread( &c, 1, 1, file );
	entry->pic_id = c;

    fread( dummy, 3, 1, file );

    fread( &c, 1, 1, file );
	entry->month = c;

    fread( &c, 1, 1, file );
	entry->year = c;

    fread( &c, 1, 1, file );
	entry->last_year = c;

    fread( dummy, 1, 1, file );

    //printf("target %d move %d\n", entry->target_type, entry->move_type);
    return 1;
}

/*
====================================================================
Replace a " with Inches and return the new string in buf.
====================================================================
*/
void string_replace_quote( char *source, char *buf )
{
    int i;
    int length = strlen( source );
    for ( i = 0; i < length; i++ )
        if ( source[i] == '"' ) {
            source[i] = 0;
            sprintf( buf, "%s Inches%s", source, source + i + 1 );
            return;
        }
    strcpy( buf, source );
}

/*
====================================================================
Copy to dest from source horizontally mirrored.
====================================================================
*/
void copy_surf_mirrored( SDL_Surface *source, SDL_Rect *srect, SDL_Surface *dest, SDL_Rect *drect )
{
    int mirror_i, i, j;
    for ( j = 0; j < srect->h; j++ )
        for ( i = 0, mirror_i = drect->x + drect->w - 1; i < srect->w; i++, mirror_i-- )
            set_pixel( dest, mirror_i, j + drect->y, get_pixel( source, i + srect->x, j + srect->y ) );
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Check if 'source_path' contains a file PANZEQUP.EQP
====================================================================
*/
int units_find_panzequp()
{
    FILE *file;
    char path[512];
    sprintf( path, "%s/PANZEQUP.EQP", source_path );
    if ( ( file = fopen( path, "r" ) ) ) {
        fclose( file );
        return 1;
    }
    sprintf( path, "%s/panzequp.eqp", source_path );
    if ( ( file = fopen( path, "r" ) ) ) {
        fclose( file );
        return 1;
    }
    return 0;
}

/*
====================================================================
Check if 'source_path' contains a file TACICONS.SHP
====================================================================
*/
int units_find_tacicons()
{
    FILE *file;
    char path[512];
    sprintf( path, "%s/TACICONS.SHP", source_path );
    if ( ( file = fopen( path, "r" ) ) ) {
        fclose( file );
        return 1;
    }
    sprintf( path, "%s/tacicons.shp", source_path );
    if ( ( file = fopen( path, "r" ) ) ) {
        fclose( file );
        return 1;
    }
    return 0;
}

/*
====================================================================
Write unitclasses, target types, movement types to file.
====================================================================
*/
void units_write_classes( FILE *file )
{
    int i;
    fprintf( file, "<target_types\n" );
    for ( i = 0; i < TARGET_TYPE_COUNT; i++ )
        fprintf( file, "<%s\nname»%s\n>\n", target_types[i * 2], target_types[i * 2 + 1] );
    fprintf( file, ">\n" );
    fprintf( file, "<move_types\n" );
    for ( i = 0; i < move_type_count; i++ )
        fprintf( file, "<%s\nname»%s\nsound»%s\n>\n", 
                 move_types[i * 3], move_types[i * 3 + 1], move_types[i * 3 + 2] );
    fprintf( file, ">\n" );
    fprintf( file, "<unit_classes\n" );
    for ( i = 0; i < UNIT_CLASS_COUNT; i++ )
        fprintf( file, "<%s\nname»%s\n>\n", unit_classes[i * 3], unit_classes[i * 3 + 1] );
    fprintf( file, ">\n" );
}

/*
====================================================================
Convert unit database.
'tac_icons' is file name of the tactical icons.
====================================================================
*/
int units_convert_database( char *tac_icons )
{
    int id = 0, ini_bonus;
    short entry_count;
    char path[512];
    char flags[256];
    char buf[256];
    char mode[2];
    int i;
    PG_UnitEntry entry;
    FILE *source_file = 0, *dest_file = 0;
    printf( "  unit data base...\n" );
    /* open dest file */
    if ( custom_name )
        sprintf( path, "%s/scenarios/pg/%s", dest_path, custom_name );
    else
        sprintf( path, "%s/units/pg.udb", dest_path );
    if ( custom_name )
        strcpy( mode, "a" );
    else
        strcpy( mode, "w" );
    if ( ( dest_file = fopen( path, mode ) ) == 0 ) {
        fprintf( stderr, "%s: write access denied\n", path );
        goto failure;
    }
    /* open file 'panzequp.eqp' */
    sprintf( path, "%s/PANZEQUP.EQP", source_path );
    if ( ( source_file = fopen( path, "r" ) ) == 0 ) {
        sprintf( path, "%s/panzequp.eqp", source_path );
        if ( ( source_file = fopen( path, "r" ) ) == 0 ) {
            fprintf( stderr, "%s: can't read file\n", path );
            goto failure;
        }
    }
    /* DOS format:
     * count ( 2 bytes )
     * entries ( 50 bytes each ) 
     */
    fread( &entry_count, 2, 1, source_file );

    entry_count = SDL_SwapLE16( entry_count );
//printf("EC %d\n", entry_count);
    if ( custom_name == 0 )
        fprintf( dest_file, "@\n" ); /* only a new file needs this magic */
    fprintf( dest_file, "icons»%s\nicon_type»single\n", tac_icons );
    fprintf( dest_file, "strength_icons»pg_strength.bmp\n" );
    fprintf( dest_file, "strength_icon_width»16\nstrength_icon_height»12\n" );
    fprintf( dest_file, "attack_icon»pg_attack.bmp\n" );
    fprintf( dest_file, "move_icon»pg_move.bmp\n" );
    units_write_classes( dest_file );
    fprintf( dest_file, "<unit_lib\n" );
    /* first entry is RESERVED */
    entry_count--;

    units_read_entry( source_file, &entry );
    /* convert */
    while ( entry_count-- > 0 ) {

        // cleared in units_read_entry()...
        //memset( &entry, 0, sizeof( PG_UnitEntry ) );
        if ( !units_read_entry( source_file, &entry ) ) {
            fprintf( stderr, "%s: unexpected end of file\n", path );
            goto failure;
        }
        /* if this is a custom PANZEQUP skip all entries
           that are not used */
        if ( custom_name && !unit_entry_used[id] ) {
            id++;
            continue;
        }
        /* sometimes a unit class seems to be screwed */
        if ( entry.class >= UNIT_CLASS_COUNT )
            entry.class = 0;
        /* adjust attack values according to unit class (add - for defense only) */
        switch ( entry.class ) {
            case INFANTRY:
            case TANK:
            case RECON:
            case ANTI_TANK:
            case ARTILLERY:
	        case FORT:
            case SUBMARINE:
            case DESTROYER:
            case CAPITAL:
	        case CARRIER:  
                entry.atk_air = -entry.atk_air;
                break;
            case AIR_DEFENSE:
                entry.atk_soft = -entry.atk_soft;
                entry.atk_hard = -entry.atk_hard;
                entry.atk_naval = -entry.atk_naval;
                break;
            case TACBOMBER:
            case LEVBOMBER:
                if ( entry.aaf )
                    entry.atk_air = -entry.atk_air;
                break;
        }
        /* all russian tanks get an initiative bonus of 3 */
        ini_bonus = 3;
        if ( entry.class == 1 && strncmp( entry.name, "ST ", 3 ) == 0 ) 
        {
            entry.init += ini_bonus;
            printf( "%s gets initiative bonus +%i\n", entry.name,
                    ini_bonus );
        }
        /* get flags */
        i = 0;
        sprintf( flags, unit_classes[entry.class * 3 + 2] );
        while ( add_flags[i*2][0] != 'X' ) {
            if ( atoi( add_flags[i * 2] ) == id ) {
                strcat( flags, "°" );
                strcat( flags, add_flags[i * 2 + 1] );
                i = -1; break;
            }
            i++;
        }
        if ( entry.move_type == 3 || entry.move_type == 4 )
            strcat( flags, "°air_trsp_ok" );
        /* write entry */

        fprintf( dest_file, "<%i\n", id++ );
        string_replace_quote( entry.name, buf );

        fprintf( dest_file, "name»%s\n", buf );

        fprintf( dest_file, "class»%s\n", unit_classes[entry.class * 3] );

        fprintf( dest_file, "target_type»%s\n", target_types[entry.target_type * 2] );

        fprintf( dest_file, "initiative»%i\n", entry.init );

        fprintf( dest_file, "spotting»%i\n", entry.spot );

        fprintf( dest_file, "movement»%i\n", entry.move );

        fprintf( dest_file, "move_type»%s\n", move_types[entry.move_type * 3] );

        fprintf( dest_file, "fuel»%i\n", entry.fuel );

        fprintf( dest_file, "range»%i\n", entry.range );

        fprintf( dest_file, "ammo»%i\n", entry.ammo );

        fprintf( dest_file, "<attack\ncount»1\nsoft»%i\nhard»%i\nair»%i\nnaval»%i\n>\n",
                 entry.atk_soft, entry.atk_hard, entry.atk_air, entry.atk_naval );

        fprintf( dest_file, "def_ground»%i\n", entry.def_ground );
        fprintf( dest_file, "def_air»%i\n", entry.def_air );
        fprintf( dest_file, "def_close»%i\n", entry.def_close );
        fprintf( dest_file, "flags»%s\n", flags );
        fprintf( dest_file, "icon_id»%i\n", entry.pic_id );
        fprintf( dest_file, "cost»%i\n", entry.cost );
        fprintf( dest_file, "start_year»19%i\n", entry.year );
        fprintf( dest_file, "start_month»%i\n", entry.month );
        fprintf( dest_file, "last_year»19%i\n", entry.last_year );
        fprintf( dest_file, ">\n" );
    }
    fprintf( dest_file, ">\n" );
    fclose( source_file );
    fclose( dest_file );
    return 1;
failure:
    if ( source_file ) fclose( source_file );
    if ( dest_file ) fclose( dest_file );
    return 0;
}

/*
====================================================================
Convert unit graphics.
'tac_icons' is file name of the tactical icons.
====================================================================
*/
int units_convert_graphics( char *tac_icons )
{
    int mirror;
    char path[512], path2[512];
    int i, height = 0, j;
    SDL_Rect srect, drect;
    PG_Shp *shp = 0;
    SDL_Surface *surf = 0;
    Uint32 ckey = MAPRGB( CKEY_RED, CKEY_GREEN, CKEY_BLUE ); /* transparency key */
    Uint32 mkey = MAPRGB( 0x0, 0xc3, 0xff ); /* size measurement key */
    printf( "  unit graphics...\n" );
    /* load tac icons */
    if ( ( shp = shp_load( "TACICONS.SHP" ) ) == 0 ) return 0;
    /* create new surface */
    for ( i = 0; i < shp->count; i++ )
        if ( shp->headers[i].valid )
            height += shp->headers[i].actual_height + 2;
        else
            height += 10;
    surf = SDL_CreateRGBSurface( SDL_SWSURFACE, shp->surf->w, height, shp->surf->format->BitsPerPixel,
                                 shp->surf->format->Rmask, shp->surf->format->Gmask, shp->surf->format->Bmask,
                                 shp->surf->format->Amask );
    if ( surf == 0 ) {
        fprintf( stderr, "error creating surface: %s\n", SDL_GetError() );
        goto failure;
    }
    SDL_FillRect( surf, 0, ckey );
    height = 0;
    for ( i = 0; i < shp->count; i++ ) {
        if ( !shp->headers[i].valid ) {
            set_pixel( surf, 0, height, mkey );
            set_pixel( surf, 9, height, mkey );
            set_pixel( surf, 0, height + 9, mkey );
            height += 10;
            continue;
        }
        srect.x = shp->headers[i].x1;
        srect.w = shp->headers[i].actual_width;
        srect.y = shp->headers[i].y1 + shp->offsets[i];
        srect.h = shp->headers[i].actual_height;
        drect.x = 0;
        drect.w = shp->headers[i].actual_width;
        drect.y = height + 1;
        drect.h = shp->headers[i].actual_height;
        j = 0; mirror = 0;
        while ( mirror_ids[j] != -1 ) {
            if ( mirror_ids[j] == i )
                mirror = 1;
            j++;
        }
        if ( mirror )
            copy_surf_mirrored( shp->surf, &srect, surf, &drect );
        else
            SDL_BlitSurface( shp->surf, &srect, surf, &drect );
        set_pixel( surf, drect.x, drect.y - 1, mkey );
        set_pixel( surf, drect.x + ( drect.w - 1 ) + ( ( drect.w - 1 ) & 1 ), drect.y - 1, mkey );
        set_pixel( surf, drect.x, drect.y + drect.h, mkey );
        height += shp->headers[i].actual_height + 2;
    }
    sprintf( path, "%s/gfx/units/%s", dest_path, tac_icons );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    shp_free( &shp );
    /* strength icons */
    sprintf( path, "%s/convdata/strength.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/units/pg_strength.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* attack symbol */
    sprintf( path, "%s/convdata/attack.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/units/pg_attack.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    /* move symbol */
    sprintf( path, "%s/convdata/move.bmp", SRC_DIR );
    if ( ( surf = SDL_LoadBMP( path ) ) == 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    sprintf( path, "%s/gfx/units/pg_move.bmp", dest_path );
    if ( SDL_SaveBMP( surf, path ) != 0 ) {
        fprintf( stderr, "%s: %s\n", path, SDL_GetError() );
        goto failure;
    }
    SDL_FreeSurface( surf );
    shp_free( &shp );
    /* sounds */
    sprintf( path, "%s/sounds/pg", dest_path );
    mkdir( path, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH );
    sprintf( path, "%s/convdata/air2.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/air2.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/air.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/air.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/battle.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/explosion.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/leg.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/leg.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/sea.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/sea.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/select.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/select.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/tracked.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/tracked.wav", dest_path );
    copy( path, path2 );
    sprintf( path, "%s/convdata/wheeled.wav", SRC_DIR );
    sprintf( path2, "%s/sounds/pg/wheeled.wav", dest_path );
    copy( path, path2 );
    return 1;
failure:
    if ( surf ) SDL_FreeSurface( surf );
    if ( shp ) shp_free( &shp );
    return 0;
}
