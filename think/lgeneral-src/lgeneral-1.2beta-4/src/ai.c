/***************************************************************************
                          ai.c  -  description
                             -------------------
    begin                : Thu Apr 11 2002
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
#include "unit.h"
#include "action.h"
#include "map.h"
#include "ai_tools.h"
#include "ai_group.h"
#include "ai.h"

/*
====================================================================
Externals
====================================================================
*/
extern Player *cur_player;
extern List *units, *avail_units;
extern int map_w, map_h;
extern Map_Tile **map;
extern Mask_Tile **mask;
extern int trgt_type_count;

/*
====================================================================
Internal stuff
====================================================================
*/
enum {
    AI_STATUS_INIT = 0, /* initiate turn */
    AI_STATUS_FINALIZE, /* finalize turn */
    AI_STATUS_DEPLOY,   /* deploy new units */
    AI_STATUS_SUPPLY,   /* supply units that need it */
    AI_STATUS_MERGE,    /* merge damaged units */
    AI_STATUS_GROUP,    /* group and handle other units */
    AI_STATUS_END       /* end ai turn */
};
static int ai_status = AI_STATUS_INIT; /* current AI status */
static List *ai_units = 0; /* units that must be processed */
static AI_Group *ai_group = 0; /* for now it's only one group */
static int finalized = 1; /* set to true when finalized */

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Check if unit has low ammo or fuel.
====================================================================
*/
static int unit_low_fuel( Unit *unit )
{
    if ( !unit_check_fuel_usage( unit ) )
        return 0;
    if ( unit->sel_prop->flags & FLYING ) {
        if ( unit->cur_fuel <= 20 )
            return 1;
        return 0;
    }
    if ( unit->cur_fuel <= 10 )
        return 1;
    return 0;
}
static int unit_low_ammo( Unit *unit )
{
    if ( unit->embark == EMBARK_NONE && unit->cur_ammo <= 2 ) return 1;
    return 0;
}

/*
====================================================================
Get the supply level that is needed to get the wanted absolute
values where ammo or fuel 0 means not to check this value.
====================================================================
*/
#ifdef _1
static int unit_get_supply_level( Unit *unit, int abs_ammo, int abs_fuel )
{
    int ammo_level = 0, fuel_level = 0, miss_ammo, miss_fuel;
    unit_check_supply( unit, UNIT_SUPPLY_ANYTHING, &miss_ammo, &miss_fuel );
    if ( abs_ammo > 0 && miss_ammo > 0 ) {
        if ( miss_ammo > abs_ammo ) miss_ammo = abs_ammo;
        ammo_level = 100 * unit->prop.ammo / miss_ammo;
    }
    if ( abs_fuel > 0 && miss_fuel > 0 ) {
        if ( miss_fuel > abs_fuel ) miss_fuel = abs_fuel;
        ammo_level = 100 * unit->prop.fuel / miss_fuel;
    }
    if ( fuel_level > ammo_level ) 
        return fuel_level;
    return ammo_level;
}
#endif

/*
====================================================================
Get the distance of 'unit' and position of object of a special
type.
====================================================================
*/
static int ai_check_hex_type( Unit *unit, int type, int x, int y )
{
    switch ( type ) {
        case AI_FIND_DEPOT:
            if ( map_is_allied_depot( &map[x][y], unit ) )
                return 1;
            break;
        case AI_FIND_ENEMY_OBJ:
            if ( !map[x][y].obj ) return 0;
        case AI_FIND_ENEMY_TOWN:
            if ( map[x][y].player && !player_is_ally( unit->player, map[x][y].player ) )
                return 1;
            break;
        case AI_FIND_OWN_OBJ:
            if ( !map[x][y].obj ) return 0;
        case AI_FIND_OWN_TOWN:
            if ( map[x][y].player && player_is_ally( unit->player, map[x][y].player ) )
                return 1;
            break;
    }
    return 0;
}
int ai_get_dist( Unit *unit, int x, int y, int type, int *dx, int *dy, int *dist )
{
    int found = 0, length;
    int i, j;
    *dist = 999;
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            if ( ai_check_hex_type( unit, type, i, j ) ) {
                length = get_dist( i, j, x, y );
                if ( *dist > length ) {
                    *dist = length;
                    *dx = i; *dy = j;
                    found = 1;
                }
            }
    return found;
}

/*
====================================================================
Approximate destination by best move position in range.
====================================================================
*/
static int ai_approximate( Unit *unit, int dx, int dy, int *x, int *y )
{
    int i, j, dist = get_dist( unit->x, unit->y, dx, dy ) + 1;
    *x = unit->x; *y = unit->y;
    map_clear_mask( F_AUX );
    map_get_unit_move_mask( unit );
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            if ( mask[i][j].in_range && !mask[i][j].blocked )
                mask[i][j].aux = get_dist( i, j, dx, dy ) + 1;
    for ( i = 0; i < map_w; i++ )
        for ( j = 0; j < map_h; j++ )
            if ( dist > mask[i][j].aux && mask[i][j].aux > 0 ) {
                dist = mask[i][j].aux;
                *x = i; *y = j;
            }
    return ( *x != unit->x || *y != unit->y );
}

/*
====================================================================
Evaluate all units by not only checking the props but also the 
current values.
====================================================================
*/
static int get_rel( int value, int limit )
{
    return 1000 * value / limit;
}
static void ai_eval_units()
{
    Unit *unit;
    list_reset( units );
    while ( ( unit = list_next( units ) ) ) {
        if ( unit->killed ) continue;
        unit->eval_score = 0;
        if ( unit->prop.ammo > 0 ) {
            if ( unit->cur_ammo >= 5 )
                /* it's extremly unlikely that there'll be more than
                   five attacks on a unit within one turn so we
                   can consider a unit with 5+ ammo 100% ready for 
                   battle */
                unit->eval_score += 1000;
            else
                unit->eval_score += get_rel( unit->cur_ammo, 
                                             MINIMUM( 5, unit->prop.ammo ) );
        }
        if ( unit->prop.fuel > 0 ) {
            if ( (  (unit->sel_prop->flags & FLYING) && unit->cur_fuel >= 20 ) ||
                 ( !(unit->sel_prop->flags & FLYING) && unit->cur_fuel >= 10 ) )
                /* a unit with this range is considered 100% operable */
                unit->eval_score += 1000;
            else {
                if ( unit->sel_prop->flags & FLYING )
                    unit->eval_score += get_rel( unit->cur_fuel, MINIMUM( 20, unit->prop.fuel ) );
                else
                    unit->eval_score += get_rel( unit->cur_fuel, MINIMUM( 10, unit->prop.fuel ) );
            }
        }
        unit->eval_score += unit->exp_level * 250;
        unit->eval_score += unit->str * 200; /* strength is counted doubled */
        /* the unit experience is not counted as normal but gives a bonus
           that may increase the evaluation */
        unit->eval_score /= 2 + (unit->prop.ammo > 0) + (unit->prop.fuel > 0);
        /* this value between 0 and 1000 indicates the readiness of the unit
           and therefore the permillage of eval_score */
        unit->eval_score = unit->eval_score * unit->prop.eval_score / 1000;
    }
}

/*
====================================================================
Set control mask for ground/air/sea for all units. (not only the 
visible ones) Friends give positive and foes give negative score
which is a relative the highest control value and ranges between
-1000 and 1000.
====================================================================
*/
typedef struct {
    Unit *unit;
    int score;
    int op_region; /* 0 - ground, 1 - air, 2 - sea */
} CtrlCtx;
static int ai_eval_ctrl( int x, int y, void *_ctx )
{
    CtrlCtx *ctx = _ctx;
    /* our main function ai_get_ctrl_masks() adds the score
       for all tiles in range and as we only want to add score
       once we have to check only tiles in attack range that
       are not situated in the move range */
    if ( mask[x][y].in_range )
        return 1;
    /* okay, this is fire range but not move range */
    switch ( ctx->op_region ) {
        case 0: mask[x][y].ctrl_grnd += ctx->score; break;
        case 1: mask[x][y].ctrl_air += ctx->score; break;
        case 2: mask[x][y].ctrl_sea += ctx->score; break;
    }
    return 1;
}
void ai_get_ctrl_masks()
{
    CtrlCtx ctx;
    int i, j;
    Unit *unit;
    map_clear_mask( F_CTRL_GRND | F_CTRL_AIR | F_CTRL_SEA );
    list_reset( units );
    while ( ( unit = list_next( units ) ) ) {
        if ( unit->killed ) continue;
        map_get_unit_move_mask( unit );
        /* build context */
        ctx.unit = unit;
        ctx.score = (player_is_ally( unit->player, cur_player ))?unit->eval_score:-unit->eval_score;
        ctx.op_region = (unit->sel_prop->flags&FLYING)?1:(unit->sel_prop->flags&SWIMMING)?2:0;
        /* work through move mask and modify ctrl mask by adding score
           for all tiles in movement and attack range once */
        for ( i  = MAXIMUM( 0, unit->x - unit->cur_mov ); 
              i <= MINIMUM( map_w - 1, unit->x + unit->cur_mov );
              i++ )
            for ( j  = MAXIMUM( 0, unit->y - unit->cur_mov ); 
                  j <= MINIMUM( map_h - 1, unit->y + unit->cur_mov ); 
                  j++ )
                if ( mask[i][j].in_range ) {
                    switch ( ctx.op_region ) {
                        case 0: mask[i][j].ctrl_grnd += ctx.score; break;
                        case 1: mask[i][j].ctrl_air += ctx.score; break;
                        case 2: mask[i][j].ctrl_sea += ctx.score; break;
                    }
                    ai_eval_hexes( i, j, MAXIMUM( 1, unit->sel_prop->rng ), 
                                   ai_eval_ctrl, &ctx );
                }
    }
}

/*
====================================================================
Exports
====================================================================
*/

/*
====================================================================
Initiate turn
====================================================================
*/
void ai_init( void )
{
    List *list; /* used to speed up the creation of ai_units */
    Unit *unit;
#ifdef DEBUG_AI
    printf( "AI Turn: %s\n", cur_player->name );
#endif
    if ( ai_status != AI_STATUS_INIT ) {
#ifdef DEBUG_AI
    printf( "Aborted: Bad AI Status: %i\n", ai_status );
#endif
        return;
    }
    finalized = 0;
    /* get all cur_player units, those with defensive fire come first */
    list = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
    list_reset( units );
    while ( ( unit = list_next( units ) ) )
        if ( unit->player == cur_player )
            list_add( list, unit );
    ai_units = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
    list_reset( list );
    while ( ( unit = list_next( list ) ) )
        if ( unit->sel_prop->flags & ARTILLERY || unit->sel_prop->flags & AIR_DEFENSE ) {
            list_add( ai_units, unit );
            list_delete_item( list, unit );
        }
    list_reset( list );
    while ( ( unit = list_next( list ) ) ) {
#ifdef DEBUG_AI
        if ( unit->killed ) fprintf( stderr, "!!Unit %s is dead!!\n", unit->name );
#endif
        list_add( ai_units, unit );
    }
    list_delete( list );
    list_reset( ai_units );
#ifdef DEBUG_AI
    printf( "Units: %i\n", ai_units->count );
#endif
    /* evaluate all units for strategic computations */
#ifdef DEBUG_AI
    printf( "Evaluating units...\n" );
#endif
    ai_eval_units();
    /* build control masks */
#ifdef DEBUG_AI
    printf( "Building control mask...\n" );
#endif
    //ai_get_ctrl_masks();
    /* check new units first */
    ai_status = AI_STATUS_DEPLOY; 
    list_reset( avail_units );
#ifdef DEBUG_AI
    printf( "AI Initialized\n" );
    printf( "*** DEPLOY ***\n" );
#endif
}

/*
====================================================================
Queue next actions (if these actions were handled by the engine
this function is called again and again until the end_turn
action is received).
====================================================================
*/
void ai_run( void )
{
    Unit *partners[MAP_MERGE_UNIT_LIMIT];
    int partner_count;
    int i, j, x, y, dx, dy, dist, found;
    Unit *unit = 0, *best = 0;
    switch ( ai_status ) {
        case AI_STATUS_DEPLOY:
            /* deploy unit? */
            if ( avail_units->count > 0 && ( unit = list_next( avail_units ) ) ) {
                map_clear_mask( F_AUX );
                for ( i = 0; i < map_w; i++ )
                    for ( j = 0; j < map_h; j++ )
                        if ( map_check_deploy( unit, i, j ) )
                            if ( ai_get_dist( unit, i, j, AI_FIND_ENEMY_OBJ, &x, &y, &dist ) )
                                mask[i][j].aux = dist + 1;
                dist = 1000; found = 0;
                for ( i = 0; i < map_w; i++ )
                    for ( j = 0; j < map_h; j++ )
                        if ( mask[i][j].aux > 0 && mask[i][j].aux < dist ) {
                            dist = mask[i][j].aux;
                            x = i; y = j;
                            found = 1; /* deploy close to enemy */
                        }
                if ( found ) {
                    action_queue_deploy( unit, x, y );
                    list_reset( avail_units );
                    list_add( ai_units, unit );
#ifdef DEBUG_AI
                    printf( "%s deployed to %i,%i\n", unit->name, x, y );
#endif
                    return;
                }
            }
            else {
                ai_status = AI_STATUS_MERGE;
                list_reset( ai_units );
#ifdef DEBUG_AI
                printf( "*** MERGE ***\n" );
#endif
            }
            break;
        case AI_STATUS_SUPPLY:
            /* get next unit */
            if ( ( unit = list_next( ai_units ) ) == 0 ) {
                ai_status = AI_STATUS_GROUP;
                /* build a group with all units, -1,-1 as destination means it will
                   simply attack/defend the nearest target. later on this should
                   split up into several groups with different target and strategy */
                ai_group = ai_group_create( cur_player->strat, -1, -1 );
                list_reset( ai_units );
                while ( ( unit = list_next( ai_units ) ) )
                    ai_group_add_unit( ai_group, unit );
#ifdef DEBUG_AI
                printf( "*** MOVE & ATTACK ***\n" );
#endif
            }
            else {
                /* check if unit needs supply and remove 
                   it from ai_units if so */
                if ( ( unit_low_fuel( unit ) || unit_low_ammo( unit ) ) ) {
                    if ( unit->supply_level > 0 ) {
                        action_queue_supply( unit );
                        list_delete_item( ai_units, unit );
#ifdef DEBUG_AI
                        printf( "%s supplies\n", unit->name );
#endif
                        break;
                    }
                    else {
#ifdef DEBUG_AI
                        printf( "%s searches depot\n", unit->name );
#endif
                        if ( ai_get_dist( unit, unit->x, unit->y, AI_FIND_DEPOT,
                                          &dx, &dy, &dist ) )
                            if ( ai_approximate( unit, dx, dy, &x, &y ) ) {
                                action_queue_move( unit, x, y );
                                list_delete_item( ai_units, unit );
#ifdef DEBUG_AI
                                printf( "%s moves to %i,%i\n", unit->name, x, y );
#endif
                                break;
                            }
                    }
                }
            }
            break;
        case AI_STATUS_MERGE:
            if ( ( unit = list_next( ai_units ) ) ) {
                map_get_merge_units( unit, partners, &partner_count );
                best = 0; /* merge with the one that has the most strength points */
                for ( i = 0; i < partner_count; i++ )
                    if ( best == 0 )
                        best = partners[i];
                    else
                        if ( best->str < partners[i]->str )
                            best = partners[i];
                if ( best ) {
#ifdef DEBUG_AI
                    printf( "%s merges with %s\n", unit->name, best->name );
#endif
                    action_queue_merge( unit, best );
                    /* both units are handled now */
                    list_delete_item( ai_units, unit );
                    list_delete_item( ai_units, best ); 
                }
            }
            else {
                ai_status = AI_STATUS_SUPPLY;
                list_reset( ai_units );
#ifdef DEBUG_AI
                printf( "*** SUPPLY ***\n" );
#endif
            }
            break;
        case AI_STATUS_GROUP:
            if ( !ai_group_handle_next_unit( ai_group ) ) {
                ai_group_delete( ai_group );
                ai_status = AI_STATUS_END;
#ifdef DEBUG_AI
                printf( "*** END TURN ***\n" );
#endif
            }
            break;
        case AI_STATUS_END:
            action_queue_end_turn();
            ai_status = AI_STATUS_FINALIZE;
            break;
    }
}

/*
====================================================================
Undo the steps (e.g. memory allocation) made in ai_init()
====================================================================
*/
void ai_finalize( void )
{
printf( "%s\n", __FUNCTION__);
    if ( finalized )
        return;
printf("Really finalized\n");
    list_delete( ai_units );
#ifdef DEBUG_AI
    printf( "AI Finalized\n" );
#endif
    ai_status = AI_STATUS_INIT;
    finalized = 1;
}
