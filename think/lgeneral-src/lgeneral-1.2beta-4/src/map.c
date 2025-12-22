/***************************************************************************
                          map.c  -  description
                             -------------------
    begin                : Mon Jan 22 2001
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
#include "file.h"
#include "nation.h"
#include "unit.h"
#include "map.h"

/*
====================================================================
Externals
====================================================================
*/
extern Sdl sdl;
extern Terrain_Type *terrain_types;
extern int terrain_type_count;
extern int hex_w, hex_h, hex_x_offset;
extern List *vis_units;
extern int cur_weather;
extern int nation_flag_width, nation_flag_height;
extern Config config;
extern Terrain_Icons *terrain_icons;
extern Unit_Info_Icons *unit_info_icons;
extern Player *cur_player;
extern List *units;
extern int modify_fog;

/*
====================================================================
Map
====================================================================
*/
int map_w = 0, map_h = 0;
Map_Tile **map = 0;
Mask_Tile **mask = 0;

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Check the surrounding tiles and get the one with the highest
in_range value.
====================================================================
*/
static void map_get_next_unit_point( int x, int y, int *next_x, int *next_y )
{
    int high_x, high_y;
    int i;
    high_x = x; high_y = y;
    for ( i = 0; i < 6; i++ )
        if ( get_close_hex_pos( x, y, i, next_x, next_y ) )
            if ( mask[*next_x][*next_y].in_range > mask[high_x][high_y].in_range ) {
                high_x = *next_x;
                high_y = *next_y;
            }
    *next_x = high_x;
    *next_y = high_y;
}

/*
====================================================================
Check if unit may enter this tile and if so return the moving cost
for it (or 0 if impossible).
respect_trsp: true if transport should also be considered
====================================================================
*/
static int unit_check_move( Unit *unit, int x, int y, int respect_trsp )
{
    int cost = terrain_get_mov( map[x][y].terrain, unit->sel_prop->mov_type, cur_weather );
    /* if we have a ground transporter we must use it's mov_type */
    if ( respect_trsp && unit->embark == EMBARK_NONE && unit->trsp_prop.id )
        cost = terrain_get_mov( map[x][y].terrain, unit->trsp_prop.mov_type, cur_weather );
    /* you can move over allied units but then mask::blocked must be set 
     * because you must not stop at this tile 
     */
    if ( ( x != unit->x  || y != unit->y ) && mask[x][y].spot ) {
        if ( map[x][y].a_unit && ( unit->sel_prop->flags & FLYING ) ) {
            if ( !player_is_ally( unit->player, map[x][y].a_unit->player ) )
                return 0;
            else
                map_mask_tile( x, y )->blocked = 1;
        }
        if ( map[x][y].g_unit && !( unit->sel_prop->flags & FLYING ) ) {
            if ( !player_is_ally( unit->player, map[x][y].g_unit->player ) )
                return 0;
            else
                map_mask_tile( x, y )->blocked = 1;
        }
    }
    /* allied bridge engineers on river? */
    if ( map[x][y].terrain->flags[cur_weather] & RIVER )
        if ( map[x][y].g_unit && map[x][y].g_unit->sel_prop->flags & BRIDGE_ENG )
            cost = 1;
    /* entering an influenced tile doubles moving cost; if tile is influenced by
     * two or more enemies it costs ALL moving points to enter it. -1 would mean
     * that in addition to all points the unit may not have moved so far but we
     * don't want this so we take all movement points in the normal way.
     */
    if ( cost > 0 ) { /* pays all movement points already or can't enter anyway */
        if ( unit->sel_prop->flags & FLYING ) {
            /* check influence */
            if ( mask[x][y].vis_air_infl == 1 )
                cost *= 2;
            else
                if ( mask[x][y].vis_air_infl > 1 )
                    cost = unit->cur_mov;
        }
        else {
            /* check influence */
            if ( mask[x][y].vis_infl == 1 )
                cost *= 2;
            else
                if ( mask[x][y].vis_infl > 1 )
                    cost = unit->cur_mov;
        }
    }
    return cost;
}

/*
====================================================================
Add a unit's influence to the (vis_)infl mask.
====================================================================
*/
static void map_add_vis_unit_infl( Unit *unit )
{
    int i, next_x, next_y;
    if ( unit->sel_prop->flags & FLYING ) {
        mask[unit->x][unit->y].vis_air_infl++;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].vis_air_infl++;
    }
    else {
        mask[unit->x][unit->y].vis_infl++;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].vis_infl++;
    }
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Load map.
====================================================================
*/
int map_load( char *fname )
{
    int i, x, y, j, limit;
    PData *pd;
    char path[512];
    char *str, *tile;
    List *tiles, *names;
    sprintf( path, "%s/maps/%s", SRC_DIR, fname );
    if ( ( pd = parser_read_file( fname, path ) ) == 0 ) goto parser_failure;
    /* map size */
    if ( !parser_get_int( pd, "width", &map_w ) ) goto parser_failure;
    if ( !parser_get_int( pd, "height", &map_h ) ) goto parser_failure;
    /* load terrains */
    if ( !parser_get_value( pd, "terrain_db", &str, 0 ) ) goto parser_failure;
    if ( !terrain_load( str ) ) goto failure;
    if ( !parser_get_values( pd, "tiles", &tiles ) ) goto parser_failure;
    /* allocate map memory */
    map = calloc( map_w, sizeof( Map_Tile* ) );
    for ( i = 0; i < map_w; i++ )
        map[i] = calloc( map_h, sizeof( Map_Tile ) );
    mask = calloc( map_w, sizeof( Mask_Tile* ) );
    for ( i = 0; i < map_w; i++ )
        mask[i] = calloc( map_h, sizeof( Mask_Tile ) );
    /* map itself */
    list_reset( tiles );
    for ( y = 0; y < map_h; y++ )
        for ( x = 0; x < map_w; x++ ) {
            tile = list_next( tiles );
            /* default is no flag */
            map[x][y].nation = 0;
            map[x][y].player = 0;
            map[x][y].deploy_center = 0;
            /* default is no mil target */
            map[x][y].obj = 0;
            /* check tile type */
            for ( j = 0; j < terrain_type_count; j++ ) {
                if ( terrain_types[j].id == tile[0] ) {
                    map[x][y].terrain = &terrain_types[j];
                    map[x][y].terrain_id = j;
                }
            }
            /* tile not found, used first one */
            if ( map[x][y].terrain == 0 )
                map[x][y].terrain = &terrain_types[0];
            /* check image id -- set offset */
            limit = map[x][y].terrain->images[0]->w / hex_w - 1;
            if ( tile[1] == '?' )
                /* set offset by random */
                map[x][y].image_offset = RANDOM( 0, limit ) * hex_w;
            else
                map[x][y].image_offset = atoi( tile + 1 ) * hex_w;
            /* set name */
            map[x][y].name = strdup( map[x][y].terrain->name );
        }
    /* map names */
    if ( parser_get_values( pd, "names", &names ) ) {
        list_reset( names );
        for ( i = 0; i < names->count; i++ ) {
            str = list_next( names );
            x = i % map_w;
            y = i / map_w;
            free( map[x][y].name );
            map[x][y].name = strdup( str );
        }
    }
    parser_free( &pd );
    return 1;
parser_failure:        
    fprintf( stderr, "%s\n", parser_get_error() );
failure:
    map_delete();
    if ( pd ) parser_free( &pd );
    return 0;
}

/*
====================================================================
Delete map.
====================================================================
*/
void map_delete( )
{
    int i, j;
    terrain_delete();
    if ( map ) {
        for ( i = 0; i < map_w; i++ )
            if ( map[i] ) {
                for ( j = 0; j < map_h; j++ )
                    if ( map[i][j].name )
                        free ( map[i][j].name ); 
                free( map[i] );    
            }
        free( map );
    }
    if ( mask ) {
        for ( i = 0; i < map_w; i++ )
            if ( mask[i] )
                free( mask[i] );
        free( mask );
    }
    map = 0; mask = 0;
    map_w = map_h = 0;
}

/*
====================================================================
Get tile at x,y
====================================================================
*/
Map_Tile* map_tile( int x, int y )
{
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) {
        fprintf( stderr, "map_tile: map tile at %i,%i doesn't exist\n", x, y);
        return 0;
    }
    return &map[x][y];
}
Mask_Tile* map_mask_tile( int x, int y )
{
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) {
        fprintf( stderr, "map_tile: mask tile at %i,%i doesn't exist\n", x, y);
        return 0;
    }
    return &mask[x][y];
}

/*
====================================================================
Clear the passed map mask flags.
====================================================================
*/
void map_clear_mask( int flags )
{
    int i, j;
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ ) {
            if ( flags & F_FOG ) mask[i][j].fog = 1;
            if ( flags & F_INVERSE_FOG ) mask[i][j].fog = 0;
            if ( flags & F_SPOT ) mask[i][j].spot = 0;
            if ( flags & F_IN_RANGE ) mask[i][j].in_range = 0;
            if ( flags & F_MOUNT ) mask[i][j].mount = 0;
            if ( flags & F_SEA_EMBARK ) mask[i][j].sea_embark = 0;
            if ( flags & F_AUX ) mask[i][j].aux = 0;
            if ( flags & F_INFL ) mask[i][j].infl = 0;
            if ( flags & F_INFL_AIR ) mask[i][j].air_infl = 0;
            if ( flags & F_VIS_INFL ) mask[i][j].vis_infl = 0;
            if ( flags & F_VIS_INFL_AIR ) mask[i][j].vis_air_infl = 0;
            if ( flags & F_BLOCKED ) mask[i][j].blocked = 0;
            if ( flags & F_BACKUP ) mask[i][j].backup = 0;
            if ( flags & F_MERGE_UNIT ) mask[i][j].merge_unit = 0;
            if ( flags & F_DEPLOY ) mask[i][j].deploy = 0;
            if ( flags & F_SUPPLY ) mask[i][j].supply = 0;
            if ( flags & F_CTRL_GRND ) mask[i][j].ctrl_grnd = 0;
            if ( flags & F_CTRL_AIR ) mask[i][j].ctrl_air = 0;
            if ( flags & F_CTRL_SEA ) mask[i][j].ctrl_sea = 0;
            if ( flags & F_DISTANCE ) mask[i][j].distance = -1;
        }
}

/*
====================================================================
Insert, Remove unit pointer from map.
====================================================================
*/
void map_insert_unit( Unit *unit )
{
    if ( unit->sel_prop->flags & FLYING ) {
        if ( map_tile( unit->x, unit->y )->a_unit ) {
            fprintf( stderr, "insert_unit_to_map: warning: "
                             "unit %s hasn't been removed properly from %i,%i:"
                             "overwrite it\n",
                     map_tile( unit->x, unit->y )->a_unit->name, unit->x, unit->y );
        }
        map_tile( unit->x, unit->y )->a_unit = unit;
        unit->terrain = map[unit->x][unit->y].terrain;
    }
    else {
        if ( map_tile( unit->x, unit->y )->g_unit ) {
            fprintf( stderr, "insert_unit_to_map: warning: "
                             "unit %s hasn't been removed properly from %i,%i:"
                             "overwrite it\n",
                     map_tile( unit->x, unit->y )->g_unit->name, unit->x, unit->y );
        }
        map_tile( unit->x, unit->y )->g_unit = unit;
        unit->terrain = map[unit->x][unit->y].terrain;
    }
}
void map_remove_unit( Unit *unit )
{
    if ( unit->sel_prop->flags & FLYING )
        map_tile( unit->x, unit->y )->a_unit = 0;
    else
        map_tile( unit->x, unit->y )->g_unit = 0;
}

/*
====================================================================
Get neighbored tiles clockwise with id between 0 and 5.
====================================================================
*/
Map_Tile* map_get_close_hex( int x, int y, int id )
{
    int next_x, next_y;
    if ( get_close_hex_pos( x, y, id, &next_x, &next_y ) )
        return &map[next_x][next_y];
    return 0;
}

/*
====================================================================
Add/set spotting of a unit to auxiliary mask
====================================================================
*/
void map_add_unit_spot_mask_rec( Unit *unit, int x, int y, int points )
{
    int i, next_x, next_y;
    /* break if this tile is already spotted */
    if ( mask[x][y].aux >= points ) return;
    /* spot tile */
    mask[x][y].aux = points; 
    /* substract points */
    points -= map[x][y].terrain->spt[cur_weather];
    /* if there are points remaining continue spotting */
    if ( points > 0 )
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( x, y, i, &next_x, &next_y ) )
                if ( !( map[next_x][next_y].terrain->flags[cur_weather] & NO_SPOTTING ) )
                    map_add_unit_spot_mask_rec( unit, next_x, next_y, points );
}
void map_add_unit_spot_mask( Unit *unit )
{
    int i, next_x, next_y;
    if ( unit->x < 0 || unit->y < 0 || unit->x >= map_w || unit->y >= map_h ) return;
    mask[unit->x][unit->y].aux = unit->sel_prop->spt; 
    for ( i = 0; i < 6; i++ )
        if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
            map_add_unit_spot_mask_rec( unit, next_x, next_y, unit->sel_prop->spt );
}
void map_get_unit_spot_mask( Unit *unit )
{
    map_clear_mask( F_AUX );
    map_add_unit_spot_mask( unit );
}

/*
====================================================================
Set movement range of a unit to in_range/sea_embark/mount.
====================================================================
*/
void map_add_unit_move_mask_rec( Unit *unit, int x, int y, int distance, int points, int stage )
{
    int next_x, next_y, i, moves;
// if (strstr(unit->name,"leF")) printf("%s: points=%d stage=%d\n", unit->name, points, stage);
    /* break if this tile is already checked */
    if ( mask[x][y].in_range >= points ) return;
    /* the outter map tiles may not be entered */
    if ( x <= 0 || y <= 0 || x >= map_w - 1 || y >= map_h - 1 ) return;
    /* must mount to come here?
     * Do set mount flag only in stage 1, and only under the condition if
     * the field could not have been reached without the unit having a
     * transport.
     */
    if ( stage == 1 && !mask[x][y].in_range
         && unit->embark == EMBARK_NONE && unit->trsp_prop.id ) {
        if ( unit->cur_mov - points < unit->prop.mov )
            mask[x][y].mount = 0;
        else
            mask[x][y].mount = 1;
    }
    /* mark as reachable */
    mask[x][y].in_range = points; 
    /* remember distance */
    if (mask[x][y].distance==-1||distance<mask[x][y].distance)
        mask[x][y].distance = distance;
    /* substract points */
    moves = unit_check_move( unit, x, y, stage );
    if ( moves == -1 ) {
        /* -1 means that it takes all points and the
           unit must be beside the tile to enter it
           thus it must not have moved before */
        if ( points < ( stage == 0 && unit->cur_mov > unit->sel_prop->mov
			? unit->sel_prop->mov : unit->cur_mov ) )
            mask[x][y].in_range = 0; 
        points = 0;
    }
    else
        points -= moves;
// if (strstr(unit->name,"leF")) printf("moves=%d mask[%d][%d].in_range=%d\n", moves, x, y, mask[x][y].in_range);
    /* go on if points left */
    if ( points > 0 )
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( x, y, i, &next_x, &next_y ) )
                if ( unit_check_move( unit, next_x, next_y, stage ) != 0 )
                    map_add_unit_move_mask_rec( unit, next_x, next_y, distance+1, points, stage );
}
void map_get_unit_move_mask( Unit *unit )
{
    int i, next_x, next_y, stage, distance = 0;

    map_clear_unit_move_mask();
    if ( unit->x < 0 || unit->y < 0 || unit->x >= map_w || unit->y >= map_h ) return;
    if ( unit->cur_mov == 0 ) return;
    mask[unit->x][unit->y].in_range = unit->cur_mov + 1;
    mask[unit->x][unit->y].distance = distance;
    for ( stage = 0; stage < 2; stage++) {
    for ( i = 0; i < 6; i++ )
        if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) ) {
            if ( map_check_unit_embark( unit, next_x, next_y, EMBARK_SEA ) ) {
                /* unit may embark to sea transporter */
                mask[next_x][next_y].sea_embark = 1;
                continue;
            }
            if ( map_check_unit_debark( unit, next_x, next_y, EMBARK_SEA ) ) {
                /* unit may debark from sea transporter */
                mask[next_x][next_y].sea_embark = 1;
                continue;
            }
            if ( unit_check_move( unit, next_x, next_y, stage ) )
                map_add_unit_move_mask_rec( unit, next_x, next_y, distance+1,
			stage == 0 && unit->cur_mov > unit->sel_prop->mov
			? unit->sel_prop->mov : unit->cur_mov, stage );
        }
    }
    mask[unit->x][unit->y].blocked = 1;
}
void map_clear_unit_move_mask()
{
    map_clear_mask( F_IN_RANGE | F_MOUNT | F_SEA_EMBARK | F_BLOCKED | F_AUX | F_DISTANCE );
}

/*
====================================================================
Get a list of way points the unit moves along to it's destination.
This includes check for unseen influence by enemy units (e.g.
Surprise Contact).
====================================================================
*/
Way_Point* map_get_unit_way_points( Unit *unit, int x, int y, int *count, Unit **ambush_unit )
{
    Way_Point *way = 0, *reverse = 0;
    int i;
    int next_x, next_y;
    /* same tile ? */
    if ( unit->x == x && unit->y == y ) return 0;
    /* allocate memory */
    way = calloc( unit->cur_mov + 1, sizeof( Way_Point ) );
    reverse = calloc( unit->cur_mov + 1, sizeof( Way_Point ) );
    /* it's easiest to get positions in reverse order */
    next_x = x; next_y = y; *count = 0;
    while ( next_x != unit->x || next_y != unit->y ) {
        reverse[*count].x = next_x; reverse[*count].y = next_y;
        map_get_next_unit_point( next_x, next_y, &next_x, &next_y );
        (*count)++;
    }
    reverse[*count].x = unit->x; reverse[*count].y = unit->y; (*count)++; 
    for ( i = 0; i < *count; i++ ) {
        way[i].x = reverse[(*count) - 1 - i].x;
        way[i].y = reverse[(*count) - 1 - i].y;
    }
    free( reverse );
    /* debug way points 
    printf( "'%s': %i,%i", unit->name, way[0].x, way[0].y );
    for ( i = 1; i < *count; i++ )
        printf( " -> %i,%i", way[i].x, way[i].y );
    printf( "\n" ); */
    /* check for ambush and influence 
     * if there is a unit in the way it must be an enemy (friends, spotted enemies are not allowed)
     * so cut down way to this way_point and set ambush_unit
     * if an unspotted tile does have influence >0 an enemy is nearby and our unit must stop 
     */
    for ( i = 1; i < *count; i++ ) {
        /* check if on this tile a unit is waiting */
        /* if mask::blocked is set it's an own unit so don't check for ambush */
        if ( !map_mask_tile( way[i].x, way[i].y )->blocked ) {
            if ( map_tile( way[i].x, way[i].y )->g_unit )
                if ( !( unit->sel_prop->flags & FLYING ) ) {
                    *ambush_unit = map_tile( way[i].x, way[i].y )->g_unit;
                    break;
                }
            if ( map_tile( way[i].x, way[i].y )->a_unit )
                if ( unit->sel_prop->flags & FLYING ) {
                    *ambush_unit = map_tile( way[i].x, way[i].y )->a_unit;
                    break;
                }
        }
        /* if we get here there is no unit waiting but maybe close too the tile */
        /* therefore check tile of moving unit if it is influenced by a previously unspotted unit */
        if ( unit->sel_prop->flags & FLYING ) {
            if ( map_mask_tile( way[i - 1].x, way[i - 1].y )->air_infl && !map_mask_tile( way[i - 1].x, way[i - 1].y )->vis_air_infl )
                break;
        }
        else {
            if ( map_mask_tile( way[i - 1].x, way[i - 1].y )->infl && !map_mask_tile( way[i - 1].x, way[i - 1].y )->vis_infl )
                break;
        }
    }
    if ( i < *count ) *count = i; /* enemy in the way; cut down */
    return way;
}

/*
====================================================================
Backup/restore spot mask to/from backup mask.
====================================================================
*/
void map_backup_spot_mask()
{
    int x, y;
    map_clear_mask( F_BACKUP );
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            map_mask_tile( x, y )->backup = map_mask_tile( x, y )->spot;
}
void map_restore_spot_mask()
{
    int x, y;
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ ) 
            map_mask_tile( x, y )->spot = map_mask_tile( x, y )->backup;
    map_clear_mask( F_BACKUP );
}

/*
====================================================================
Get unit's merge partners and set 
mask 'merge'. At maximum MAP_MERGE_UNIT_LIMIT units.
All unused entries in partners are set 0.
====================================================================
*/
void map_get_merge_units( Unit *unit, Unit **partners, int *count )
{
    Unit *partner;
    int i, next_x, next_y;
    *count = 0;
    map_clear_mask( F_MERGE_UNIT );
    memset( partners, 0, sizeof( Unit* ) * MAP_MERGE_UNIT_LIMIT );
    /* check surrounding tiles */
    for ( i = 0; i < 6; i++ )
        if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) ) {
            partner = 0;
            if ( map[next_x][next_y].g_unit && unit_check_merge( unit, map[next_x][next_y].g_unit ) )
                partner = map[next_x][next_y].g_unit;
            else
                if ( map[next_x][next_y].a_unit && unit_check_merge( unit, map[next_x][next_y].a_unit ) )
                    partner = map[next_x][next_y].a_unit;
            if ( partner ) {
                partners[(*count)++] = partner;
                mask[next_x][next_y].merge_unit = partner;
            }
        }
}

/*
====================================================================
Get a list (vis_units) of all visible units by checking spot mask.
====================================================================
*/
void map_get_vis_units( void )
{
    int x, y;
    list_clear( vis_units );
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( mask[x][y].spot || ( cur_player && cur_player->ctrl == PLAYER_CTRL_CPU ) ) {
                if ( map[x][y].g_unit ) list_add( vis_units, map[x][y].g_unit );
                if ( map[x][y].a_unit ) list_add( vis_units, map[x][y].a_unit );
            }
}

/*
====================================================================
Draw a map tile terrain to surface. (fogged if mask::fog is set)
====================================================================
*/
void map_draw_terrain( SDL_Surface *surf, int map_x, int map_y, int x, int y )
{
    Map_Tile *tile;
    if ( map_x < 0 || map_y < 0 || map_x >= map_w || map_y >= map_h ) return;
    tile = &map[map_x][map_y];
    /* terrain */
    DEST( surf, x, y, hex_w, hex_h );
    if ( mask[map_x][map_y].fog )
        SOURCE( tile->terrain->images_fogged[cur_weather], tile->image_offset, 0 )
    else
        SOURCE( tile->terrain->images[cur_weather], tile->image_offset, 0 )
    blit_surf();
    /* nation flag */
    if ( tile->nation != 0 ) {
        nation_draw_flag( tile->nation, surf, 
                          x + ( ( hex_w - nation_flag_width ) >> 1 ),
                          y + hex_h - nation_flag_height - 2,
                          tile->obj );
    }
    /* grid */
    if ( config.grid ) {
        DEST( surf, x, y, hex_w, hex_h );
        SOURCE( terrain_icons->grid, 0, 0 );
        blit_surf();
    }
}
/*
====================================================================
Draw tile units. If mask::fog is set no units are drawn.
If 'ground' is True the ground unit is drawn as primary 
and the air unit is drawn small (and vice versa).
If 'select' is set a selection frame is added.
====================================================================
*/
void map_draw_units( SDL_Surface *surf, int map_x, int map_y, int x, int y, int ground, int select )
{
    Unit *unit = 0;
    Map_Tile *tile;
    if ( map_x < 0 || map_y < 0 || map_x >= map_w || map_y >= map_h ) return;
    tile = &map[map_x][map_y];
    /* units */
    if ( MAP_CHECK_VIS( map_x, map_y ) ) {
        if ( tile->g_unit ) {
            if ( ground || tile->a_unit == 0 ) {
                /* large ground unit */
                DEST( surf, 
                      x + ( (hex_w - tile->g_unit->sel_prop->icon_w) >> 1 ),
                      y + ( ( hex_h - tile->g_unit->sel_prop->icon_h ) >> 1 ),
                      tile->g_unit->sel_prop->icon_w, tile->g_unit->sel_prop->icon_h );
                SOURCE( tile->g_unit->sel_prop->icon, tile->g_unit->icon_offset, 0 );
                blit_surf();
                unit = tile->g_unit;
            }
            else {
                /* small ground unit */
                DEST( surf, 
                      x + ( (hex_w - tile->g_unit->sel_prop->icon_tiny_w) >> 1 ),
                      y + ( ( hex_h - tile->g_unit->sel_prop->icon_tiny_h ) >> 1 ) + 4,
                      tile->g_unit->sel_prop->icon_tiny_w, tile->g_unit->sel_prop->icon_tiny_h );
                SOURCE( tile->g_unit->sel_prop->icon_tiny, tile->g_unit->icon_tiny_offset, 0 );
                blit_surf();
                unit = tile->a_unit;
            }
        }
        if ( tile->a_unit ) {
            if ( !ground || tile->g_unit == 0 ) {
                /* large air unit */
                DEST( surf, 
                      x + ( (hex_w - tile->a_unit->sel_prop->icon_w) >> 1 ),
                      y + 6,
                      tile->a_unit->sel_prop->icon_w, tile->a_unit->sel_prop->icon_h );
                SOURCE( tile->a_unit->sel_prop->icon, tile->a_unit->icon_offset, 0 );
                blit_surf();
                unit = tile->a_unit;
            }
            else {
                /* small air unit */
                DEST( surf, 
                      x + ( (hex_w - tile->a_unit->sel_prop->icon_tiny_w) >> 1 ),
                      y + 6,
                      tile->a_unit->sel_prop->icon_tiny_w, tile->a_unit->sel_prop->icon_tiny_h );
                SOURCE( tile->a_unit->sel_prop->icon_tiny, tile->a_unit->icon_tiny_offset, 0 );
                blit_surf();
                unit = tile->g_unit;
            }
        }
        /* unit info icons */
        if ( unit && config.show_bar ) {
            /* strength */
            DEST( surf, 
                  x + ( ( hex_w - unit_info_icons->str_w ) >> 1 ),
                  y + hex_h - unit_info_icons->str_h,
                  unit_info_icons->str_w, unit_info_icons->str_h );
            if ( cur_player && player_is_ally( cur_player, unit->player ) )
                SOURCE( unit_info_icons->str, 0, unit_info_icons->str_h * ( unit->str - 1 + 15 ) )
            else
                SOURCE( unit_info_icons->str, 0, unit_info_icons->str_h * ( unit->str - 1 ) )
            blit_surf();
            /* for current player only */
            if ( unit->player == cur_player ) {
                /* attack */
                if ( unit->cur_atk_count > 0 ) {
                    DEST( surf, x + ( hex_w - hex_x_offset ), y + hex_h - unit_info_icons->atk->h,
                          unit_info_icons->atk->w, unit_info_icons->atk->h );
                    SOURCE( unit_info_icons->atk, 0, 0 );
                    blit_surf();
                }
                /* move */
                if ( unit->cur_mov > 0 ) {
                    DEST( surf, x + hex_x_offset - unit_info_icons->mov->w, y + hex_h - unit_info_icons->mov->h,
                          unit_info_icons->mov->w, unit_info_icons->mov->h );
                    SOURCE( unit_info_icons->mov, 0, 0 );
                    blit_surf();
                }
            }
        }
    }
    /* selection frame */
    if ( select ) {
        DEST( surf, x, y, hex_w, hex_h );
        SOURCE( terrain_icons->select, 0, 0 );
        blit_surf();
    }
}
/*
====================================================================
Draw terrain and units.
====================================================================
*/
void map_draw_tile( SDL_Surface *surf, int map_x, int map_y, int x, int y, int ground, int select )
{
    map_draw_terrain( surf, map_x, map_y, x, y );
    map_draw_units( surf, map_x, map_y, x, y, ground, select );
}

/*
====================================================================
Set/update spot mask by engine's current player or unit.
The update adds the tiles seen by unit.
====================================================================
*/
void map_set_spot_mask()
{
    int i;
    int x, y, next_x, next_y;
    Unit *unit;
    map_clear_mask( F_SPOT );
    map_clear_mask( F_AUX ); /* buffer here first */
    /* get spot_mask for each unit and add to fog */
    /* use map::mask::aux as buffer */
    list_reset( units );
    for ( i = 0; i < units->count; i++ ) {
        unit = list_next( units );
        if ( unit->killed ) continue;
        if ( player_is_ally( cur_player, unit->player ) ) /* it's your unit or at least it's allied... */
            map_add_unit_spot_mask( unit );
    }
    /* check all flags; if flag belongs to you or any of your partners you see the surrounding, too */
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( map[x][y].player != 0 )
                if ( player_is_ally( cur_player, map[x][y].player ) ) {
                    mask[x][y].aux = 1;
                    for ( i = 0; i < 6; i++ )
                        if ( get_close_hex_pos( x, y, i, &next_x, &next_y ) )
                            mask[next_x][next_y].aux = 1;
                }
    /* convert aux to fog */
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( mask[x][y].aux || !config.fog_of_war )
                 mask[x][y].spot = 1;
    /* update the visible units list */
    map_get_vis_units();
}
void map_update_spot_mask( Unit *unit, int *enemy_spotted )
{
    int x, y;
    *enemy_spotted = 0;
    if ( player_is_ally( cur_player, unit->player ) ) {
        /* it's your unit or at least it's allied... */
        map_get_unit_spot_mask( unit );
        for ( x = 0; x < map_w; x++ )
            for ( y = 0; y < map_h; y++ )
                if ( mask[x][y].aux ) {
                    /* if there is an enemy in this auxialiary mask that wasn't spotted before */
                    /* set enemy_spotted true */
                    if ( !mask[x][y].spot ) {
                        if ( map[x][y].g_unit && !player_is_ally( unit->player, map[x][y].g_unit->player ) )
                            *enemy_spotted = 1;
                        if ( map[x][y].a_unit && !player_is_ally( unit->player, map[x][y].a_unit->player ) )
                            *enemy_spotted = 1;
                    }
                    mask[x][y].spot = 1;
                }
    }
}

/*
====================================================================
Set mask::fog (which is the actual fog of the engine) to either
spot mask, in_range mask (covers sea_embark), merge mask,
deploy mask.
====================================================================
*/
void map_set_fog( int type )
{
    int x, y;
    for ( y = 0; y < map_h; y++ )
        for ( x = 0; x < map_w; x++ )
            switch ( type ) {
                case F_SPOT: mask[x][y].fog = !mask[x][y].spot; break;
                case F_IN_RANGE: mask[x][y].fog = ( (!mask[x][y].in_range && !mask[x][y].sea_embark) || mask[x][y].blocked ); break;
                case F_MERGE_UNIT: mask[x][y].fog = !mask[x][y].merge_unit; break;
                case F_DEPLOY: mask[x][y].fog = !mask[x][y].deploy; break;
                default: mask[x][y].fog = 0; break;
            }
}

/*
====================================================================
Set the fog to players spot mask by using mask::aux (not mask::spot)
====================================================================
*/
void map_set_fog_by_player( Player *player )
{
    int i;
    int x, y, next_x, next_y;
    Unit *unit;
    map_clear_mask( F_AUX ); /* buffer here first */
    /* units */
    list_reset( units );
    for ( i = 0; i < units->count; i++ ) {
        unit = list_next( units );
        if ( unit->killed ) continue;
        if ( player_is_ally( player, unit->player ) ) /* it's your unit or at least it's allied... */
            map_add_unit_spot_mask( unit );
    }
    /* check all flags; if flag belongs to you or any of your partners you see the surrounding, too */
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( map[x][y].player != 0 )
                if ( player_is_ally( player, map[x][y].player ) ) {
                    mask[x][y].aux = 1;
                    for ( i = 0; i < 6; i++ )
                        if ( get_close_hex_pos( x, y, i, &next_x, &next_y ) )
                            mask[next_x][next_y].aux = 1;
                }
    /* convert aux to fog */
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( mask[x][y].aux || !config.fog_of_war )
                 mask[x][y].fog = 0;
            else
                 mask[x][y].fog = 1;
}

/*
====================================================================
Modify the various influence masks.
====================================================================
*/
void map_add_unit_infl( Unit *unit )
{
    int i, next_x, next_y;
    if ( unit->sel_prop->flags & FLYING ) {
        mask[unit->x][unit->y].air_infl++;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].air_infl++;
    }
    else {
        mask[unit->x][unit->y].infl++;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].infl++;
    }
}
void map_remove_unit_infl( Unit *unit )
{
    int i, next_x, next_y;
    if ( unit->sel_prop->flags & FLYING ) {
        mask[unit->x][unit->y].air_infl--;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].air_infl--;
    }
    else {
        mask[unit->x][unit->y].infl--;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].infl--;
    }
}
void map_remove_vis_unit_infl( Unit *unit )
{
    int i, next_x, next_y;
    if ( unit->sel_prop->flags & FLYING ) {
        mask[unit->x][unit->y].vis_air_infl--;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].vis_air_infl--;
    }
    else {
        mask[unit->x][unit->y].vis_infl--;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &next_x, &next_y ) )
                mask[next_x][next_y].vis_infl--;
    }
}
void map_set_infl_mask()
{
    Unit *unit = 0;
    map_clear_mask( F_INFL | F_INFL_AIR );
    /* add all hostile units influence */
    list_reset( units );
    while ( ( unit = list_next( units ) ) )
        if ( !unit->killed && !player_is_ally( cur_player, unit->player ) )
            map_add_unit_infl( unit );
    /* visible influence must also be updated */
    map_set_vis_infl_mask();
}
void map_set_vis_infl_mask()
{
    Unit *unit = 0;
    map_clear_mask( F_VIS_INFL | F_VIS_INFL_AIR );
    /* add all hostile units influence */
    list_reset( units );
    while ( ( unit = list_next( units ) ) )
        if ( !unit->killed && !player_is_ally( cur_player, unit->player ) )
            if ( map_mask_tile( unit->x, unit->y )->spot )
                map_add_vis_unit_infl( unit );
}

/*
====================================================================
Check if unit may air/sea embark/debark at x,y
====================================================================
*/
int map_check_unit_embark( Unit *unit, int x, int y, int type )
{
    int i, nx, ny;
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    if ( type == EMBARK_AIR ) {
        if ( unit->sel_prop->flags & FLYING ) return 0;
        if ( unit->sel_prop->flags & SWIMMING ) return 0;
        if (! ( unit->sel_prop->flags & AIR_TRSP_OK ) ) return 0;
        if ( cur_player->air_trsp == 0 ) return 0;
        if ( unit->embark != EMBARK_NONE ) return 0;
        if ( map[x][y].a_unit ) return 0;
        if ( unit->player->air_trsp_used >= unit->player->air_trsp_count ) return 0;
        if ( !unit->unused ) return 0;
        if ( !( map[x][y].terrain->flags[cur_weather] & SUPPLY_AIR ) ) return 0;
        if ( !( unit->sel_prop->flags & AIR_TRSP_OK ) ) return 0;
        return 1;
    }
    if ( type == EMBARK_SEA ) {
        if ( unit->sel_prop->flags & FLYING ) return 0;
        if ( unit->sel_prop->flags & SWIMMING ) return 0;
        if ( cur_player->sea_trsp == 0 ) return 0;
        if ( unit->embark != EMBARK_NONE || unit->sel_prop->mov == 0 ) return 0;
        if ( map[x][y].g_unit ) return 0;
        if ( unit->player->sea_trsp_used >= unit->player->sea_trsp_count ) return 0;
        if ( !unit->unused ) return 0;
        if ( terrain_get_mov( map[x][y].terrain, unit->player->sea_trsp->mov_type, cur_weather ) == 0 ) return 0;
        /* basically we must be close to an harbor but a town that is just
           near the water is also okay because else it would be too
           restrictive. */
        if ( map[x][y].terrain->flags[cur_weather] & SUPPLY_GROUND )
            return 1;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( x, y, i, &nx, &ny ) )
                if ( map[nx][ny].terrain->flags[cur_weather] & SUPPLY_GROUND )
                    return 1;
        return 0;
    }
    return 0;
}
int map_check_unit_debark( Unit *unit, int x, int y, int type )
{
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    if ( type == EMBARK_SEA ) {
        if ( unit->embark != EMBARK_SEA ) return 0;
        if ( map[x][y].g_unit ) return 0;
        if ( !unit->unused ) return 0;
        if ( terrain_get_mov( map[x][y].terrain, unit->prop.mov_type, cur_weather ) == 0 ) return 0;
        return 1;
    }
    if ( type == EMBARK_AIR ) {
        if ( unit->embark != EMBARK_AIR ) return 0;
        if ( map[x][y].g_unit ) return 0;
        if ( !unit->unused ) return 0;
        if ( terrain_get_mov( map[x][y].terrain, unit->prop.mov_type, cur_weather ) == 0 ) return 0;
        if ( !( map[x][y].terrain->flags[cur_weather] & SUPPLY_AIR ) && !( unit->prop.flags & PARACHUTE ) )
            return 0;
        return 1;
    }
    return 0;
}

/*
====================================================================
Embark/debark unit and return if an enemy was spotted.
====================================================================
*/
void map_embark_unit( Unit *unit, int x, int y, int type, int *enemy_spotted )
{
    if ( type == EMBARK_AIR ) {
        /* action taken */
        unit->unused = 0;
        /* abandon ground transporter */
        memset( &unit->trsp_prop, 0, sizeof( Unit_Lib_Entry ) );
        /* set and change to air_tran_prop */
        memcpy( &unit->trsp_prop, cur_player->air_trsp, sizeof( Unit_Lib_Entry ) );
        unit->sel_prop = &unit->trsp_prop;
        unit->embark = EMBARK_AIR;
        /* unit now flies */
        map[x][y].a_unit = unit;
        map[unit->x][unit->y].g_unit = 0;
        /* set full move range */
        unit->cur_mov = unit->trsp_prop.mov;
        /* cancel attacks */
        unit->cur_atk_count = 0;
        /* no entrenchment */
        unit->entr = 0;
        /* adjust pic offset */
        unit_adjust_icon( unit );
        /* another air_tran in use */
        cur_player->air_trsp_used++;
        /* in any case your spotting must be updated */
        map_update_spot_mask( unit, enemy_spotted );
        return;
    }
    if ( type == EMBARK_SEA ) {
        /* action taken */
        unit->unused = 0;
        /* abandon ground transporter */
        memset( &unit->trsp_prop, 0, sizeof( Unit_Lib_Entry ) );
        /* set and change to sea_tran_prop */
        memcpy( &unit->trsp_prop, cur_player->sea_trsp, sizeof( Unit_Lib_Entry ) );
        unit->sel_prop = &unit->trsp_prop;
        unit->embark = EMBARK_SEA;
        /* update position */
        map[unit->x][unit->y].g_unit = 0;
        unit->x = x; unit->y = y;
        map[x][y].g_unit = unit;
        /* set full move range */
        unit->cur_mov = unit->trsp_prop.mov;
        /* cancel attacks */
        unit->cur_atk_count = 0;
        /* no entrenchment */
        unit->entr = 0;
        /* adjust pic offset */
        unit_adjust_icon( unit );
        /* another air_tran in use */
        cur_player->sea_trsp_used++;
        /* in any case your spotting must be updated */
        map_update_spot_mask( unit, enemy_spotted );
        return;
    }
}
void map_debark_unit( Unit *unit, int x, int y, int type, int *enemy_spotted )
{
    if ( type == EMBARK_SEA ) {
        /* action taken */
        unit->unused = 0;
        /* change back to unit_prop */
        memset( &unit->trsp_prop, 0, sizeof( Unit_Lib_Entry ) );
        unit->sel_prop = &unit->prop;
        unit->embark = EMBARK_NONE;
        /* set position */
        map[unit->x][unit->y].g_unit = 0;
        unit->x = x; unit->y = y;
        map[x][y].g_unit = unit;
        if ( map[x][y].nation ) {
            map[x][y].nation = unit->nation;
            map[x][y].player = unit->player;
        }
        /* no movement allowed */
        unit->cur_mov = 0;
        /* cancel attacks */
        unit->cur_atk_count = 0;
        /* no entrenchment */
        unit->entr = 0;
        /* adjust pic offset */
        unit_adjust_icon( unit );
        /* free occupied sea transporter */
        cur_player->sea_trsp_used--;
        /* in any case your spotting must be updated */
        map_update_spot_mask( unit, enemy_spotted );
        return;
    }
    if ( type == EMBARK_AIR ) {
        /* action taken */
        unit->unused = 0;
        /* change back to unit_prop */
        memset( &unit->trsp_prop, 0, sizeof( Unit_Lib_Entry ) );
        unit->sel_prop = &unit->prop;
        unit->embark = EMBARK_NONE;
        /* get down to earth */
        map[unit->x][unit->y].a_unit = 0;
        map[unit->x][unit->y].g_unit = unit;
        /* no movement allowed */
        unit->cur_mov = 0;
        /* cancel attacks */
        unit->cur_atk_count = 0;
        /* no entrenchment */
        unit->entr = 0;
        /* adjust pic offset */
        unit_adjust_icon( unit );
        /* free occupied sea transporter */
        cur_player->air_trsp_used--;
        /* in any case your spotting must be updated */
        map_update_spot_mask( unit, enemy_spotted );
        return;
    }
}

/*
====================================================================
Set the deploy list for this unit.
====================================================================
*/
void map_get_deploy_mask( Unit *unit )
{
    int x, y;
    map_clear_mask( F_DEPLOY );
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( map_check_deploy( unit, x, y ) )
                mask[x][y].deploy = 1;
}

/*
====================================================================
Check if unit may be deployed to mx, my or return undeployable unit
there.
====================================================================
*/
int map_check_deploy( Unit *unit, int mx, int my )
{
    int i, next_x, next_y;
    if ( unit->sel_prop->flags & FLYING ) {
        if ( map[mx][my].a_unit ) return 0;
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( mx, my, i, &next_x, &next_y ) )
                if ( map[next_x][next_y].player )
                    if ( player_is_ally( map[next_x][next_y].player, unit->player ) )
                        if ( map[next_x][next_y].terrain->flags[cur_weather] & SUPPLY_AIR )
                            if ( map[next_x][next_y].deploy_center )
                                return 1;
        if ( map[mx][my].player )
            if ( player_is_ally( map[mx][my].player, unit->player ) )
                if ( map[mx][my].terrain->flags[cur_weather] & SUPPLY_AIR )
                    if ( map[mx][my].deploy_center )
                        return 1;
        return 0;
    }
    if ( map[mx][my].g_unit ) return 0;
    for ( i = 0; i < 6; i++ )
        if ( get_close_hex_pos( mx, my, i, &next_x, &next_y ) )
            if ( map[next_x][next_y].player )
                if ( player_is_ally( map[next_x][next_y].player, unit->player ) )
                    if ( map[next_x][next_y].deploy_center )
                        return 1;
    if ( map[mx][my].player )
        if ( player_is_ally( map[mx][my].player, unit->player ) )
            if ( map[mx][my].deploy_center )
                return 1;
    return 0;
}
Unit* map_get_undeploy_unit( int x, int y, int air_mode )
{
    if ( air_mode ) {
        /* check air first */
        if ( map[x][y].a_unit &&  map[x][y].a_unit->fresh_deploy )
            return  map[x][y].a_unit;
        else
            if ( map[x][y].g_unit &&  map[x][y].g_unit->fresh_deploy )
                return  map[x][y].g_unit;
            else
                return 0;
    }
    else {
        /* check ground first */
        if ( map[x][y].g_unit &&  map[x][y].g_unit->fresh_deploy )
            return  map[x][y].g_unit;
        else
            if ( map[x][y].a_unit &&  map[x][y].a_unit->fresh_deploy )
                return  map[x][y].a_unit;
            else
                return 0;
    }
}

/*
====================================================================
Check if this map tile is a supply point for the given unit.
====================================================================
*/
int map_is_allied_depot( Map_Tile *tile, Unit *unit )
{
    if ( tile == 0 ) return 0;
    /* maybe it's an aircraft carrier */
    if ( tile->g_unit )
        if ( tile->g_unit->sel_prop->flags & CARRIER )
            if ( player_is_ally( tile->g_unit->player, unit->player ) )
                if ( unit->sel_prop->flags & CARRIER_OK )
                    return 1;
    /* check for depot */
    if ( tile->player == 0 ) return 0;
    if ( !player_is_ally( unit->player, tile->player ) ) return 0;
    if ( unit->sel_prop->flags & FLYING ) {
        if ( !(tile->terrain->flags[cur_weather] & SUPPLY_AIR) ) 
            return 0;
    }
    else
        if ( unit->sel_prop->flags & SWIMMING ) {
            if ( !(tile->terrain->flags[cur_weather] & SUPPLY_SHIPS) ) 
                return 0;
        }
    return 1;
}

/*
====================================================================
Set the supply mask for this unit.
====================================================================
*/
void map_get_supply_mask_rec( int x, int y, int points )
{
    int i, nx, ny;
    if ( mask[x][y].supply >= points * 10 ) return;
    mask[x][y].supply = points * 10;
    points--;
    if ( points > 0 )
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( x, y, i, &nx, &ny ) )
                map_get_supply_mask_rec( nx, ny, points );
}
void map_get_supply_mask( Unit *unit )
{
    int x, y, nx, ny, i;
    map_clear_mask( F_SUPPLY );
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( map_is_allied_depot( &map[x][y], unit ) ) {
                mask[x][y].supply = 100;
                if ( unit->sel_prop->flags & FLYING || unit->sel_prop->flags & SWIMMING ) {
                    /* flying and swimming units must be close to depot */
                    for ( i = 0; i < 6; i++ )
                        if ( get_close_hex_pos( x, y, i, &nx, &ny ) )
                            mask[nx][ny].supply = 100;
                }
                else {
                    /* surrounding of towns is also available to ground units by loosing 10% per hex */
                    for ( i = 0; i < 6; i++ )
                        if ( get_close_hex_pos( x, y, i, &nx, &ny ) )
                            map_get_supply_mask_rec( nx, ny, 10 );
                }
            }
    for ( x = 0; x < map_w; x++ )
        for ( y = 0; y < map_h; y++ )
            if ( mask[x][y].supply > 0 ) {
                /* if hostile influence is 1 supply's cut in half if influence >1 no supply possible */
                if ( unit->sel_prop->flags & FLYING ) {
                    if ( mask[x][y ].air_infl > 1 || mask[x][y ].infl > 1 )
                        mask[x][y].supply = 0;
                    else
                        if ( mask[x][y].air_infl == 1 || mask[x][y ].infl == 1 )
                            mask[x][y].supply /= 2;
                }
                else {
                    if ( mask[x][y ].infl == 1 )
                        mask[x][y].supply /= 2;
                    else
                        if ( mask[x][y ].infl > 1 )
                            mask[x][y].supply = 0;
                }
            }
}
