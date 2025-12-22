/***************************************************************************
                          unit.c  -  description
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
#include "unit.h"

/*
====================================================================
Externals
====================================================================
*/
extern Sdl sdl;
extern Config config;
extern int trgt_type_count;
extern List *vis_units; /* units known zo current player */
extern int cur_weather;
extern Weather_Type *weather_types;
extern Unit *cur_target;

/*
====================================================================
Locals
====================================================================
*/

//#define DEBUG_ATTACK

/*
====================================================================
Update unit's bar info according to strength.
====================================================================
*/
static void update_bar( Unit *unit )
{
    /* bar width */
    unit->damage_bar_width = unit->str * BAR_TILE_WIDTH;
    if ( unit->damage_bar_width == 0 && unit->str > 0 )
        unit->damage_bar_width = BAR_TILE_WIDTH;
    /* bar color is defined by vertical offset in map->life_icons */
    if ( unit->str > 4 )
        unit->damage_bar_offset = 0;
    else
        if ( unit->str > 2 )
            unit->damage_bar_offset = BAR_TILE_HEIGHT;
        else
            unit->damage_bar_offset = BAR_TILE_HEIGHT * 2;
}

/*
====================================================================
Get the current unit strength which is:
  max { 0, unit->str - unit->suppr - unit->turn_suppr }
====================================================================
*/
static int unit_get_cur_str( Unit *unit )
{
    int cur_str = unit->str - unit->suppr - unit->turn_suppr;
    if ( cur_str < 0 ) cur_str = 0;
    return cur_str;
}

/*
====================================================================
Apply suppression and damage to unit. Return the remaining 
actual strength.
If attacker is a bomber the suppression is counted as turn
suppression.
====================================================================
*/
static int unit_apply_damage( Unit *unit, int damage, int suppr, Unit *attacker )
{
    unit->str -= damage;
    if ( unit->str < 0 ) {
        unit->str = 0;
        return 0;
    }
    if ( attacker && attacker->sel_prop->flags & TURN_SUPPR ) {
        unit->turn_suppr += suppr;
        if ( unit->str - unit->turn_suppr < 0 ) {
            unit->turn_suppr = unit->str;
            return 0;
        }
    }
    else {
        unit->suppr += suppr;
        if ( unit->str - unit->turn_suppr - unit->suppr < 0 ) {
            unit->suppr = unit->str - unit->turn_suppr;
            return 0;
        }
    }
    return unit_get_cur_str( unit );
}

/*
====================================================================
Execute a single fight (no defensive fire check) with random
values. (only if 'luck' is set)
If 'force_rugged is set'. Rugged defense will be forced.
====================================================================
*/
enum { 
    ATK_BOTH_STRIKE = 0,
    ATK_UNIT_FIRST,
    ATK_TARGET_FIRST,
    ATK_NO_STRIKE
};
static int unit_attack( Unit *unit, Unit *target, int type, int real, int force_rugged )
{
    int unit_old_ini = unit->sel_prop->ini, target_old_ini = target->sel_prop->ini;
    int unit_dam = 0, unit_suppr = 0, target_dam = 0, target_suppr = 0;
    int rugged_chance, rugged_def = 0;
    int exp_mod;
    int ret = AR_NONE; /* clear flags */
    int strike;
    /* check if rugged defense occurs */
    if ( real && type == UNIT_ACTIVE_ATTACK )
        if ( unit_check_rugged_def( unit, target ) || ( force_rugged && unit_is_close( unit, target ) ) ) {
            rugged_chance = unit_get_rugged_def_chance( unit, target );
            if ( RANDOM( 1, 100 ) <= rugged_chance || force_rugged )
                rugged_def = 1;
        }
    /* PG's formula for initiative is
       min { base initiative, terrain max initiative } +
       ( exp_level + 1 ) / 2 + D3 */
    if ( !(unit->sel_prop->flags & FLYING) )
        unit->sel_prop->ini = MINIMUM( unit->sel_prop->ini, unit->terrain->max_ini );
    unit->sel_prop->ini += ( unit->exp_level + 1  ) / 2;
    if ( !(target->sel_prop->flags & FLYING) )
        target->sel_prop->ini = MINIMUM( target->sel_prop->ini, target->terrain->max_ini );
    target->sel_prop->ini += ( target->exp_level + 1  ) / 2;
    /* special initiative rules:
       antitank inits attack tank|recon: atk 0, def 99
       defensive fire: atk 99, def 0
       submarine attacks: atk 99, def 0
       ranged attack: atk 99, def 0
       rugged defense: atk 0
       air unit attacks air defense: atk = def */
    if ( unit->sel_prop->flags & ANTI_TANK )
        if ( target->sel_prop->flags & TANK ) {
            unit->sel_prop->ini = 0;
            target->sel_prop->ini = 99;
        }
    if ( unit->sel_prop->flags & ( DIVING | ARTILLERY | AIR_DEFENSE ) || 
         type == UNIT_DEFENSIVE_ATTACK
    ) {
        unit->sel_prop->ini = 99;
        target->sel_prop->ini = 0;
    }
    if ( unit->sel_prop->flags & FLYING )
        if ( target->sel_prop->flags & AIR_DEFENSE ) 
            unit->sel_prop->ini = target->sel_prop->ini;
    if ( rugged_def )
        unit->sel_prop->ini = 0;
    if ( force_rugged )
        target->sel_prop->ini = 99;
    /* the dice is rolled after these changes */
    if ( real ) {
        unit->sel_prop->ini += RANDOM( 1, 3 );
        target->sel_prop->ini += RANDOM( 1, 3 );
    }
#ifdef DEBUG_ATTACK
    if ( real ) {
        printf( "%s Initiative: %i\n", unit->name, unit->sel_prop->ini );
        printf( "%s Initiative: %i\n", target->name, target->sel_prop->ini );
        if ( unit_check_rugged_def( unit, target ) )
            printf( "\nRugged Defense: %s (%i%%)\n",
                    rugged_def ? "yes" : "no",
                    unit_get_rugged_def_chance( unit, target ) );
    }
#endif
    /* in a real combat a submarine may evade */
    if ( real && type == UNIT_ACTIVE_ATTACK && ( target->sel_prop->flags & DIVING ) ) { 
        if ( RANDOM( 1, 10 ) <= 7 + ( target->exp_level - unit->exp_level ) / 2 )
            strike = ATK_NO_STRIKE;
        else
            strike = ATK_UNIT_FIRST;
        printf ( "\nSubmarine Evasion: %s (%i%%)\n", 
                 (strike==ATK_NO_STRIKE)?"yes":"no",
                 10 * (7 + ( target->exp_level - unit->exp_level ) / 2) );
    }
    else
    /* who is first? */
    if ( unit->sel_prop->ini == target->sel_prop->ini )
        strike = ATK_BOTH_STRIKE;
    else
        if ( unit->sel_prop->ini > target->sel_prop->ini )
            strike = ATK_UNIT_FIRST;
        else
            strike = ATK_TARGET_FIRST;
    /* the one with the highest initiative begins first if not defensive fire or artillery */
    if ( strike == ATK_BOTH_STRIKE ) {
        /* both strike at the same time */
        unit_get_damage( unit, unit, target, type, real, rugged_def, &target_dam, &target_suppr );
        if ( unit_check_attack( target, unit, UNIT_PASSIVE_ATTACK ) )
            unit_get_damage( unit, target, unit, UNIT_PASSIVE_ATTACK, real, rugged_def, &unit_dam, &unit_suppr );
        unit_apply_damage( target, target_dam, target_suppr, unit );
        unit_apply_damage( unit, unit_dam, unit_suppr, target );
    }
    else
        if ( strike == ATK_UNIT_FIRST ) {
            /* unit strikes first */
            unit_get_damage( unit, unit, target, type, real, rugged_def, &target_dam, &target_suppr );
            if ( unit_apply_damage( target, target_dam, target_suppr, unit ) )
                if ( unit_check_attack( target, unit, UNIT_PASSIVE_ATTACK ) && type != UNIT_DEFENSIVE_ATTACK ) {
                    unit_get_damage( unit, target, unit, UNIT_PASSIVE_ATTACK, real, rugged_def, &unit_dam, &unit_suppr );
                    unit_apply_damage( unit, unit_dam, unit_suppr, target );
                }
        }
        else 
            if ( strike == ATK_TARGET_FIRST ) {
                /* target strikes first */
                if ( unit_check_attack( target, unit, UNIT_PASSIVE_ATTACK ) ) {
                    unit_get_damage( unit, target, unit, UNIT_PASSIVE_ATTACK, real, rugged_def, &unit_dam, &unit_suppr );
                    if ( !unit_apply_damage( unit, unit_dam, unit_suppr, target ) )
                        ret |= AR_UNIT_ATTACK_BROKEN_UP;
                }
                if ( unit_get_cur_str( unit ) > 0 ) {
                    unit_get_damage( unit, unit, target, type, real, rugged_def, &target_dam, &target_suppr );
                    unit_apply_damage( target, target_dam, target_suppr, unit );
                }
            }
    /* check return value */
    if ( unit->str == 0 )
        ret |= AR_UNIT_KILLED;
    else
        if ( unit_get_cur_str( unit ) == 0 )
            ret |= AR_UNIT_SUPPRESSED;
    if ( target->str == 0 )
        ret |= AR_TARGET_KILLED;
    else
        if ( unit_get_cur_str( target ) == 0 )
            ret |= AR_TARGET_SUPPRESSED;
    if ( rugged_def )
        ret |= AR_RUGGED_DEFENSE;
    if ( real ) {
        /* cost ammo */
        if ( config.supply ) {
            unit->cur_ammo--;
            if ( unit_check_attack( target, unit, UNIT_PASSIVE_ATTACK ) && target->cur_ammo > 0 )
                target->cur_ammo--;
        }
        /* costs attack */
        if ( unit->cur_atk_count > 0 ) unit->cur_atk_count--;
        /* loose entrenchment */
        if ( target->entr > 0 ) target->entr--;
        /* gain experience */
        exp_mod = target->exp_level - unit->exp_level;
        if ( exp_mod < 1 ) exp_mod = 1;
        unit_add_exp( unit, exp_mod * target_dam + unit_dam );
        exp_mod = unit->exp_level - target->exp_level;
        if ( exp_mod < 1 ) exp_mod = 1;
        unit_add_exp( target, exp_mod * unit_dam + target_dam );
        if ( unit_is_close( unit, target ) ) {
            unit_add_exp( unit, 10 );
            unit_add_exp( target, 10 );
        }
        /* adjust life bars */
        update_bar( unit );
        update_bar( target );
    }
    unit->sel_prop->ini = unit_old_ini;
    target->sel_prop->ini = target_old_ini;
    return ret;
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Create a unit by passing a Unit struct with the following stuff set:
  name, x, y, str, entr, exp_level, delay, orient, nation, player.
This function will use the passed values to create a Unit struct
with all values set then.
====================================================================
*/
Unit *unit_create( Unit_Lib_Entry *prop, Unit_Lib_Entry *trsp_prop, Unit *base )
{
    Unit *unit = 0;
    if ( prop == 0 ) return 0;
    unit = calloc( 1, sizeof( Unit ) );
    /* shallow copy of properties */
    memcpy( &unit->prop, prop, sizeof( Unit_Lib_Entry ) );
    unit->sel_prop = &unit->prop; 
    unit->embark = EMBARK_NONE;
    /* assign the passed transporter without any check */
    if ( trsp_prop && !( prop->flags & FLYING ) && !( prop->flags & SWIMMING ) ) {
        memcpy( &unit->trsp_prop, trsp_prop, sizeof( Unit_Lib_Entry ) );
        /* a sea/air ground transporter is active per default */
        if ( trsp_prop->flags & SWIMMING ) {
            unit->embark = EMBARK_SEA;
            unit->sel_prop = &unit->trsp_prop;
        }
        if ( trsp_prop->flags & FLYING ) {
            unit->embark = EMBARK_AIR;
            unit->sel_prop = &unit->trsp_prop;
        }
    }
    /* copy the base values */
    unit->delay = base->delay;
    unit->x = base->x; unit->y = base->y;
    unit->str = base->str; unit->entr = base->entr;
    unit->player = base->player;
    unit->nation = base->nation;
    strcpy_lt( unit->name, base->name, 20 );
    unit_add_exp( unit, base->exp_level * 100 );
    unit->orient = base->orient;
    unit_adjust_icon( unit );
    unit->unused = 1;
    unit->supply_level = 100;
    unit->cur_ammo = unit->prop.ammo;
    unit->cur_fuel = unit->prop.fuel;
    if ( unit->cur_fuel == 0 && unit->trsp_prop.id && unit->trsp_prop.fuel > 0 )
        unit->cur_fuel = unit->trsp_prop.fuel;
    strcpy_lt( unit->tag, base->tag, 31 );
    /* update life bar properties */
    update_bar( unit );
    /* allocate backup mem */
    unit->backup = calloc( 1, sizeof( Unit ) );
    return unit;
}

/*
====================================================================
Delete a unit. Pass the pointer as void* to allow usage as 
callback for a list.
====================================================================
*/
void unit_delete( void *ptr )
{
    Unit *unit = (Unit*)ptr;
    if ( unit == 0 ) return;
    if ( unit->backup ) free( unit->backup );
    free( unit );
}

/*
====================================================================
Update unit icon according to it's orientation.
====================================================================
*/
void unit_adjust_icon( Unit *unit )
{
    unit->icon_offset = unit->sel_prop->icon_w * unit->orient;
    unit->icon_tiny_offset = unit->sel_prop->icon_tiny_w * unit->orient;
}

/*
====================================================================
Adjust orientation (and adjust icon) of unit if looking towards x,y.
====================================================================
*/
void unit_adjust_orient( Unit *unit, int x, int y )
{
    if ( unit->prop.icon_type == UNIT_ICON_SINGLE ) {
        if ( x < unit->x )  {
            unit->orient = UNIT_ORIENT_LEFT;
            unit->icon_offset = unit->sel_prop->icon_w;
            unit->icon_tiny_offset = unit->sel_prop->icon_tiny_w;
        }
        else
            if ( x > unit->x ) {
                unit->orient = UNIT_ORIENT_RIGHT;
                unit->icon_offset = 0;
                unit->icon_tiny_offset = 0;
            }
    }
    else {
        /* not implemented yet */
    }
}

/*
====================================================================
Check if unit can supply something (ammo, fuel, anything) and 
return the amount that is supplyable.
====================================================================
*/
int unit_check_supply( Unit *unit, int type, int *missing_ammo, int *missing_fuel )
{
    int ret = 0;
    int max_fuel = unit->sel_prop->fuel;
    if ( missing_ammo )
        *missing_ammo = 0;
    if ( missing_fuel )
        *missing_fuel = 0;
    /* no supply near all already moved? */
    if ( unit->embark == EMBARK_SEA || unit->embark == EMBARK_AIR ) return 0;
    if ( unit->supply_level == 0 ) return 0;
    if ( !unit->unused ) return 0;
    /* supply ammo? */
    if ( type == UNIT_SUPPLY_AMMO || type == UNIT_SUPPLY_ANYTHING )
        if ( unit->cur_ammo < unit->prop.ammo ) {
            ret = 1;
            if ( missing_ammo )
                *missing_ammo = unit->prop.ammo - unit->cur_ammo;
        }
    if ( type == UNIT_SUPPLY_AMMO ) return ret;
    /* if we have a ground transporter assigned we need to use it's fuel as max */
    if ( unit_check_fuel_usage( unit ) && max_fuel == 0 )
        max_fuel = unit->trsp_prop.fuel;
    /* supply fuel? */
    if ( type == UNIT_SUPPLY_FUEL || type == UNIT_SUPPLY_ANYTHING )
        if ( unit->cur_fuel < max_fuel ) {
            ret = 1;
            if ( missing_fuel )
                *missing_fuel = max_fuel - unit->cur_fuel;
        }
    return ret;
}

/*
====================================================================
Supply percentage of maximum fuel/ammo/both.
_intern does not block movement etc.
Return True if unit was supplied.
====================================================================
*/
int unit_supply_intern( Unit *unit, int type )
{
    int amount_ammo, amount_fuel, max, supply_amount;
    int supplied = 0;
    /* ammo */
    if ( type == UNIT_SUPPLY_AMMO || type == UNIT_SUPPLY_ALL )
    if ( unit_check_supply( unit, UNIT_SUPPLY_AMMO, &amount_ammo, &amount_fuel ) ) {
        max = unit->cur_ammo + amount_ammo ;
        supply_amount = unit->supply_level * max / 100;
        if ( supply_amount == 0 ) supply_amount = 1; /* at least one */
        unit->cur_ammo += supply_amount;
        if ( unit->cur_ammo > max ) unit->cur_ammo = max;
        supplied = 1;
    }
    /* fuel */
    if ( type == UNIT_SUPPLY_FUEL || type == UNIT_SUPPLY_ALL )
    if ( unit_check_supply( unit, UNIT_SUPPLY_FUEL, &amount_ammo, &amount_fuel ) ) {
        max = unit->cur_fuel + amount_fuel ;
        supply_amount = unit->supply_level * max / 100;
        if ( supply_amount == 0 ) supply_amount = 1; /* at least one */
        unit->cur_fuel += supply_amount;
        if ( unit->cur_fuel > max ) unit->cur_fuel = max;
        supplied = 1;
    }
    return supplied;
}
int unit_supply( Unit *unit, int type )
{
    int supplied = unit_supply_intern(unit,type);
    if (supplied) {
        /* no other actions allowed */
        unit->unused = 0; unit->cur_mov = 0; unit->cur_atk_count = 0;
    }
    return supplied;
}

/*
====================================================================
Check if a unit uses fuel in it's current state (embarked or not).
====================================================================
*/
int unit_check_fuel_usage( Unit *unit )
{
    if ( unit->embark == EMBARK_SEA || unit->embark == EMBARK_AIR ) return 0;
    if ( unit->prop.fuel > 0 ) return 1;
    if ( unit->trsp_prop.id && unit->trsp_prop.fuel > 0 ) return 1;
    return 0;
}

/*
====================================================================
Add experience and compute experience level.
Return True if levelup.
====================================================================
*/
int unit_add_exp( Unit *unit, int exp )
{
    int old_level = unit->exp_level;
    unit->exp += exp;
    if ( unit->exp >= 500 ) unit->exp = 500;
    unit->exp_level = unit->exp / 100;
    return ( old_level != unit->exp_level );
}

/*
====================================================================
Mount/unmount unit to ground transporter.
====================================================================
*/
void unit_mount( Unit *unit )
{
    if ( unit->trsp_prop.id == 0 || unit->embark != EMBARK_NONE ) return;
    /* set prop pointer */
    unit->sel_prop = &unit->trsp_prop;
    unit->embark = EMBARK_GROUND;
    /* adjust pic offset */
    unit_adjust_icon( unit );
    /* no entrenchment when mounting */
    unit->entr = 0;
}
void unit_unmount( Unit *unit )
{
    if ( unit->embark != EMBARK_GROUND ) return;
    /* set prop pointer */
    unit->sel_prop = &unit->prop;
    unit->embark = EMBARK_NONE;
    /* adjust pic offset */
    unit_adjust_icon( unit );
    /* no entrenchment when mounting */
    unit->entr = 0;
}

/*
====================================================================
Check if units are close to each other. This means on neighbored
hex tiles.
====================================================================
*/
int unit_is_close( Unit *unit, Unit *target )
{
    return is_close( unit->x, unit->y, target->x, target->y );
}

/*
====================================================================
Check if unit may activly attack (unit initiated attack) or
passivly attack (target initated attack, unit defenses) the target.
====================================================================
*/
int unit_check_attack( Unit *unit, Unit *target, int type )
{
    if ( target == 0 || unit == target ) return 0;
    if ( player_is_ally( unit->player, target->player ) ) return 0;
    if ( unit->sel_prop->flags & FLYING && !( target->sel_prop->flags & FLYING ) )
        if ( unit->sel_prop->rng == 0 )
            if ( unit->x != target->x || unit->y != target->y )
                return 0; /* range 0 means above unit for an aircraft */
    /* if the target flys and the unit is ground with a range of 0 the aircraft
       may only be harmed when above unit */
    if ( !(unit->sel_prop->flags & FLYING) && ( target->sel_prop->flags & FLYING ) )
        if ( unit->sel_prop->rng == 0 )
            if ( unit->x != target->x || unit->y != target->y )
                return 0;
    /* only destroyers may harm submarines */
    if ( target->sel_prop->flags & DIVING && !( unit->sel_prop->flags & DESTROYER ) ) return 0;
    if ( weather_types[cur_weather].flags & NO_AIR_ATTACK ) {
        if ( unit->sel_prop->flags & FLYING ) return 0;
        if ( target->sel_prop->flags & FLYING ) return 0;
    }
    if ( type == UNIT_ACTIVE_ATTACK ) {
        /* agressor */
        if ( unit->cur_ammo <= 0 ) return 0;
        if ( unit->sel_prop->atks[target->sel_prop->trgt_type] <= 0 ) return 0;
        if ( unit->cur_atk_count == 0 ) return 0;
        if ( !unit_is_close( unit, target ) && get_dist( unit->x, unit->y, target->x, target->y ) > unit->sel_prop->rng ) return 0;
    }
    else
    if ( type == UNIT_DEFENSIVE_ATTACK ) {
        /* defensive fire */
        if ( unit->sel_prop->atks[target->sel_prop->trgt_type] <= 0 ) return 0;
        if ( unit->cur_ammo <= 0 ) return 0;
        if ( ( unit->sel_prop->flags & ( INTERCEPTOR | ARTILLERY | AIR_DEFENSE ) ) == 0 ) return 0;
        if ( target->sel_prop->flags & ( ARTILLERY | AIR_DEFENSE | SWIMMING ) ) return 0;
        if ( unit->sel_prop->flags & INTERCEPTOR ) {
            /* the interceptor is propably not beside the attacker so the range check is different
             * can't be done here because the unit the target attacks isn't passed so 
             *  unit_get_df_units() must have a look itself 
             */
        }
        else
            if ( get_dist( unit->x, unit->y, target->x, target->y ) > unit->sel_prop->rng ) return 0;
    }
    else {
        /* counter-attack */
        if ( !unit_is_close( unit, target ) && get_dist( unit->x, unit->y, target->x, target->y ) > unit->sel_prop->rng ) return 0;
        if ( unit->sel_prop->atks[target->sel_prop->trgt_type] == 0 ) return 0;
        /* artillery may only defend against close units */
        if ( unit->sel_prop->flags & ARTILLERY )
            if ( !unit_is_close( unit, target ) )
                return 0;
        /* you may defend against artillery only when close */
        if ( target->sel_prop->flags & ARTILLERY )
            if ( !unit_is_close( unit, target ) )
                return 0;
    }
    return 1;
}

/*
====================================================================
Compute damage/supression the target takes when unit attacks
the target. No properties will be changed. If 'real' is set
the dices are rolled else it's a stochastical prediction. 
'aggressor' is the unit that initiated the attack, either 'unit'
or 'target'. It is not always 'unit' as 'unit' and 'target are 
switched for get_damage depending on whether there is a striking
back and who had the highest initiative.
====================================================================
*/
void unit_get_damage( Unit *aggressor, Unit *unit, Unit *target, 
                      int type, 
                      int real, int rugged_def,
                      int *damage, int *suppr )
{
    int atk_strength, max_roll;
    int atk_grade, def_grade, diff, result;
    float suppr_chance, kill_chance;
    /* use PG's formula to compute the attack/defense grade*/
    /* basic attack */
    atk_grade = abs( unit->sel_prop->atks[target->sel_prop->trgt_type] );
#ifdef DEBUG_ATTACK
    if ( real ) printf( "\n%s attacks:\n", unit->name );
    if ( real ) printf( "  base:   %2i\n", atk_grade );
    if ( real ) printf( "  exp:    +%i\n", unit->exp_level);
#endif
    /* experience */
    atk_grade += unit->exp_level;
    /* target on a river? */
    if ( !(target->sel_prop->flags & FLYING ) )
    if ( target->terrain->flags[cur_weather] & RIVER ) {
        atk_grade += 4;
#ifdef DEBUG_ATTACK
        if ( real ) printf( "  river:  +4\n" );
#endif
    }
    /* counterattack of rugged defense unit? */
    if ( type == UNIT_PASSIVE_ATTACK && rugged_def ) {
        atk_grade += 4;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  rugdef: +4\n" );
#endif
    }
#ifdef DEBUG_ATTACK
    if ( real ) printf( "---\n%s defends:\n", target->name );
#endif
    /* basic defense */
    if ( unit->sel_prop->flags & FLYING )
        def_grade = target->sel_prop->def_air;
    else {
        def_grade = target->sel_prop->def_grnd;
        /* apply close defense? */
        if ( unit->sel_prop->flags & INFANTRY )
            if ( !( target->sel_prop->flags & INFANTRY ) )
                if ( !( target->sel_prop->flags & FLYING ) )
                    if ( !( target->sel_prop->flags & SWIMMING ) )
                    {
                        if ( target == aggressor )
                        if ( unit->terrain->flags[cur_weather]&INF_CLOSE_DEF )
                            def_grade = target->sel_prop->def_cls;
                        if ( unit == aggressor )
                        if ( target->terrain->flags[cur_weather]&INF_CLOSE_DEF )
                            def_grade = target->sel_prop->def_cls;
                    }
    }
#ifdef DEBUG_ATTACK
    if ( real ) printf( "  base:   %2i\n", def_grade );
    if ( real ) printf( "  exp:    +%i\n", target->exp_level );
#endif
    /* experience */
    def_grade += target->exp_level;
    /* attacker on a river or swamp? */
    if ( !(unit->sel_prop->flags & FLYING) )
    if ( !(unit->sel_prop->flags & SWIMMING) )
    if ( !(target->sel_prop->flags & FLYING) )
    {
        if ( unit->terrain->flags[cur_weather] & SWAMP ) 
        {
            def_grade += 4;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  swamp:  +4\n" );
#endif
        } else
        if ( unit->terrain->flags[cur_weather] & RIVER ) {
            def_grade += 4;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  river:  +4\n" );
#endif
        }
    }
    /* rugged defense? */
    if ( type == UNIT_ACTIVE_ATTACK && rugged_def ) {
        def_grade += 4;
#ifdef DEBUG_ATTACK
        if ( real ) printf( "  rugdef: +4\n" );
#endif
    }
    /* entrenchment */
    if ( unit->sel_prop->flags & IGNORE_ENTR )
        def_grade += 0;
    else {
        if ( unit->sel_prop->flags & INFANTRY )
            def_grade += target->entr / 2;
        else
            def_grade += target->entr;
#ifdef DEBUG_ATTACK
        if ( real ) printf( "  entr:   +%i\n", 
                (unit->sel_prop->flags & INFANTRY) ? target->entr / 2 : target->entr );
#endif
    }
    /* naval vs ground unit */
    if ( !(unit->sel_prop->flags & SWIMMING ) )
        if ( !(unit->sel_prop->flags & FLYING) )
            if ( target->sel_prop->flags & SWIMMING ) {
                def_grade += 8;
#ifdef DEBUG_ATTACK
                if ( real ) printf( "  naval: +8\n" );
#endif
            }
    /* bad weather? */
    if ( unit->sel_prop->rng > 0 )
        if ( weather_types[cur_weather].flags & BAD_SIGHT ) {
            def_grade += 3;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  sight: +3\n" );
#endif
        }
    /* initiating attack against artillery? */
    if ( type == UNIT_PASSIVE_ATTACK )
        if ( unit->sel_prop->flags & ARTILLERY ) {
            def_grade += 3;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  artdef: +3\n" );
#endif
        }
    /* infantry versus anti_tank? */
    if ( target->sel_prop->flags & INFANTRY )
        if ( unit->sel_prop->flags & ANTI_TANK ) {
            def_grade += 2;
#ifdef DEBUG_ATTACK
            if ( real ) printf( "  antitnk:+3\n" );
#endif
        }
    /* attacker strength */
    atk_strength = unit_get_cur_str( unit );
    if ( weather_types[cur_weather].flags & CUT_STRENGTH )
        atk_strength /= 2;
    else
    if ( unit_check_fuel_usage( unit ) && unit->cur_fuel == 0 )
        atk_strength /= 2;
    else {
        if ( type == UNIT_DEFENSIVE_ATTACK )
            if ( !(unit->sel_prop->flags & INTERCEPTOR) )
                if ( !(unit->sel_prop->flags & ARTILLERY) || unit->sel_prop->rng > 1 )
                    atk_strength /= 2;
    }
#ifdef DEBUG_ATTACK
    if ( real && atk_strength != unit_get_cur_str( unit ) )
        printf( "---\n%s with half strength\n", unit->name );
#endif
    /*  PG's formula:
        get difference between attack and defense
        strike for each strength point with 
          if ( diff <= 4 ) 
              D20 + diff
          else
              D20 + 4 + 0.4 * ( diff - 4 )
        suppr_fire flag set: 1-10 miss, 11-18 suppr, 19+ kill
        normal: 1-10 miss, 11-12 suppr, 13+ kill */
    diff = atk_grade - def_grade; if ( diff < -7 ) diff = -7;
    *damage = 0; *suppr = 0;
#ifdef DEBUG_ATTACK
    if ( real ) {
        printf( "---\n%i x %i --> %i x %i\n", 
                atk_strength, atk_grade, unit_get_cur_str( target ), def_grade );
    }
#endif
    /* get the chances for suppression and kills (computed here
       to use also for debug info */
    max_roll = 20 + ( diff <= 4 ? diff : 4 + 2 * ( diff - 4 ) / 5 );
    /* get chances for suppression and kills */
    if ( unit->sel_prop->flags & SUPPR_FIRE ) {
        if ( max_roll >= 18 )
            suppr_chance = 8.0 / max_roll;
        else
            suppr_chance = 1 - 10.0 / max_roll;
        if ( suppr_chance < 0 ) suppr_chance = 0;
        kill_chance  = 1 - 18.0 / max_roll;
        if ( kill_chance < 0 ) kill_chance = 0;
    }
    else {
        if ( max_roll >= 12 )
            suppr_chance = 2.0 / max_roll;
        else
            suppr_chance = 1 - 10.0 / max_roll;
        if ( suppr_chance < 0 ) suppr_chance = 0;
        kill_chance  = 1 - 12.0 / max_roll;
        if ( kill_chance < 0 ) kill_chance = 0;
    }
    if ( real ) {
#ifdef DEBUG_ATTACK
        printf( "Roll: D20 + %i (Kill: %i%%, Suppr: %i%%)\n", 
                diff <= 4 ? diff : 4 + 2 * ( diff - 4 ) / 5,
                (int)(100 * kill_chance), (int)(100 * suppr_chance) );
#endif
        while ( atk_strength-- > 0 ) {
            if ( diff <= 4 )
                result = RANDOM( 1, 20 ) + diff;
            else
                result = RANDOM( 1, 20 ) + 4 + 2 * ( diff - 4 ) / 5;
            if ( unit->sel_prop->flags & SUPPR_FIRE ) {
                if ( result >= 11 && result <= 18 )
                    (*suppr)++;
                else
                    if ( result >= 19 )
                        (*damage)++;
            }
            else {
                if ( result >= 11 && result <= 12 )
                    (*suppr)++;
                else
                    if ( result >= 13 )
                        (*damage)++;
            }
        }
#ifdef DEBUG_ATTACK
        printf( "Kills: %i, Suppression: %i\n\n", *damage, *suppr );
#endif
    }
    else {
        *suppr = (int)(suppr_chance * atk_strength);
        *damage = (int)(kill_chance * atk_strength);
    }
}

/*
====================================================================
Execute a single fight (no defensive fire check) with random values.
unit_surprise_attack() handles an attack with a surprising target
(e.g. Out Of The Sun)
If a rugged defense occured in a normal fight (surprise_attack is
always rugged) 'rugged_def' is set.
====================================================================
*/
int unit_normal_attack( Unit *unit, Unit *target, int type )
{
    return unit_attack( unit, target, type, 1, 0 );
}
int unit_surprise_attack( Unit *unit, Unit *target )
{
    return unit_attack( unit, target, UNIT_ACTIVE_ATTACK, 1, 1 );
}

/*
====================================================================
Go through a complete battle unit vs. target including known(!)
defensive support stuff and with no random modifications.
Return the final damage taken by both units.
As the terrain may have influence the id of the terrain the battle
takes place (defending unit's hex) is provided.
====================================================================
*/
void unit_get_expected_losses( Unit *unit, Unit *target, int *unit_damage, int *target_damage )
{
    int damage, suppr;
    Unit *df;
    List *df_units = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
#ifdef DEBUG_ATTACK
    printf( "***********************\n" );
#endif    
    unit_get_df_units( unit, target, vis_units, df_units );
    unit_backup( unit ); unit_backup( target );
    /* let defensive fire go to work (no chance to defend against this) */
    list_reset( df_units );
    while ( ( df = list_next( df_units ) ) ) {
        unit_get_damage( unit, df, unit, UNIT_DEFENSIVE_ATTACK, 0, 0, &damage, &suppr );
        if ( !unit_apply_damage( unit, damage, suppr, 0 ) ) break;
    }
    /* actual fight if attack has strength remaining */
    if ( unit_get_cur_str( unit ) > 0 )
        unit_attack( unit, target, UNIT_ACTIVE_ATTACK, 0, 0 );
    /* get done damage */
    *unit_damage = unit->str;
    *target_damage = target->str;
    unit_restore( unit ); unit_restore( target );
    *unit_damage = unit->str - *unit_damage;
    *target_damage = target->str - *target_damage;
    list_delete( df_units );
}

/*
====================================================================
This function checks 'units' for supporters of 'target'
that will give defensive fire to before the real battle
'unit' vs 'target' takes place. These units are put to 'df_units'
(which is not created here)
====================================================================
*/
void unit_get_df_units( Unit *unit, Unit *target, List *units, List *df_units )
{
    Unit *entry;
    list_clear( df_units );
    if ( unit->sel_prop->flags & FLYING ) {
        list_reset( units );
        while ( ( entry = list_next( units ) ) ) {
            if ( entry->killed ) continue;
            if ( entry == target ) continue;
            if ( entry == unit ) continue;
            /* bombers -- intercepting impossibly covered by unit_check_attack() */
            if ( !(target->sel_prop->flags & INTERCEPTOR) )
                if ( unit_is_close( target, entry ) )
                    if ( entry->sel_prop->flags & INTERCEPTOR )
                        if ( player_is_ally( entry->player, target->player ) )
                            if ( entry->cur_ammo > 0 ) {
                                list_add( df_units, entry );
                                continue;
                            }
            /* air-defense */
            if ( entry->sel_prop->flags & AIR_DEFENSE )
                /* FlaK will not give support when an air-to-air attack is
                 * taking place. First, in reality it would prove distastrous,
                 * second, Panzer General doesn't allow it, either.
                 */
                if ( !(unit->sel_prop->flags & FLYING) || !(target->sel_prop->flags & FLYING) )
                    if ( unit_check_attack( entry, unit, UNIT_DEFENSIVE_ATTACK ) )
                        list_add( df_units, entry );
        }
    }
    else  {
        /* artillery for ground units */
        list_reset( units );
        while ( ( entry = list_next( units ) ) ) {
            if ( entry->killed ) continue;
            if ( entry == target ) continue;
            if ( entry == unit ) continue;
            /* sturmgeschuetze (assault tanks?) will support all friendly
               units standing beside them although the target may be 
               out of range: and this is done with FULL strength in 
               opposite to other artillery */
            if ( entry->sel_prop->flags & ARTILLERY && entry->sel_prop->rng == 1 )
                if ( unit_is_close( target, entry ) )
                    if ( player_is_ally( entry->player, target->player ) )
                        if ( entry->cur_ammo > 0 ) {
                            list_add( df_units, entry );
                            continue;
                        }
            /* normal artillery */
            if ( entry->sel_prop->flags & ARTILLERY )
                if ( unit_check_attack( entry, unit, UNIT_DEFENSIVE_ATTACK ) )
                    list_add( df_units, entry );
        }
    }
}

/*
====================================================================
Check if these two units are allowed to merge with each other.
====================================================================
*/
int unit_check_merge( Unit *unit, Unit *source )
{
    /* units must not be sea/air embarked */
    if ( unit->embark != EMBARK_NONE || source->embark != EMBARK_NONE ) return 0;
    /* same class */
    if ( unit->prop.class != source->prop.class ) return 0;
    /* same player */
    if ( !player_is_ally( unit->player, source->player ) ) return 0;
    /* first unit must not have moved so far */
    if ( !unit->unused ) return 0;
    /* both units must have same movement type */
    if ( unit->prop.mov_type != source->prop.mov_type ) return 0;
    /* the unit strength must not exceed limit */
    if ( unit->str + source->str > 13 ) return 0;
    /* fortresses (unit-class 7) could not merge */
    if ( unit->prop.class == 7 ) return 0;
    /* not failed so far: allow merge */
    return 1;
}

/*
====================================================================
Merge these two units: unit is the new unit and source must be
removed from map and memory after this function was called.
====================================================================
*/
void unit_merge( Unit *unit, Unit *source )
{
    /* units relative weight */
    float weight1, weight2, total;
    int i, neg;
    /* compute weight */
    weight1 = unit->str; weight2 = source->str;
    total = unit->str + source->str;
    /* adjust so weight1 + weigth2 = 1 */
    weight1 /= total; weight2 /= total;
    /* no other actions allowed */
    unit->unused = 0; unit->cur_mov = 0; unit->cur_atk_count = 0;
    /* repair damage */
    unit->str += source->str;
    /* reorganization costs all entrenchment */
    unit->entr = 0;
    /* update experience */
    i = (int)( weight1 * unit->exp + weight2 * source->exp );
    unit->exp = 0; unit_add_exp( unit, i );
    /* update unit::prop */
    /* related initiative */
    unit->prop.ini = (int)( weight1 * unit->prop.ini + weight2 * source->prop.ini );
    /* minimum movement */
    if ( source->prop.mov < unit->prop.mov )
        unit->prop.mov = source->prop.mov;
    /* maximum spotting */
    if ( source->prop.spt > unit->prop.spt )
        unit->prop.spt = source->prop.spt;
    /* maximum range */
    if ( source->prop.rng > unit->prop.rng )
        unit->prop.rng = source->prop.rng;
    /* relative attack count */
    unit->prop.atk_count = (int)( weight1 * unit->prop.atk_count + weight2 * source->prop.atk_count );
    if ( unit->prop.atk_count == 0 ) unit->prop.atk_count = 1;
    /* relative attacks */
    /* if attack is negative simply use absolute value; only restore negative if both units are negative */
    for ( i = 0; i < trgt_type_count; i++ ) {
        neg = ( unit->prop.atks[i] < 0 && source->prop.atks[i] < 0 );
        unit->prop.atks[i] = (int)( weight1 * abs( unit->prop.atks[i] ) + weight2 * ( source->prop.atks[i] ) );
        if ( neg ) unit->prop.atks[i] *= -1;
    }
    /* relative defence */
    unit->prop.def_grnd = (int)( weight1 * unit->prop.def_grnd + weight2 * source->prop.def_grnd );
    unit->prop.def_air = (int)( weight1 * unit->prop.def_air + weight2 * source->prop.def_air );
    unit->prop.def_cls = (int)( weight1 * unit->prop.def_cls + weight2 * source->prop.def_cls );
    /* relative ammo */
    unit->prop.ammo = (int)( weight1 * unit->prop.ammo + weight2 * source->prop.ammo );
    unit->cur_ammo = (int)( weight1 * unit->cur_ammo + weight2 * source->cur_ammo );
    /* relative fuel */
    unit->prop.fuel = (int)( weight1 * unit->prop.fuel + weight2 * source->prop.fuel );
    unit->cur_fuel = (int)( weight1 * unit->cur_fuel + weight2 * source->cur_fuel );
    /* merge flags */
    unit->prop.flags |= source->prop.flags;
    /* sounds, picture are kept */
    /* unit::trans_prop isn't updated so far: */
    /* transporter of first unit is kept if any else second unit's transporter is used */
    if ( unit->trsp_prop.id == 0 && source->trsp_prop.id ) {
        memcpy( &unit->trsp_prop, &source->trsp_prop, sizeof( Unit_Lib_Entry ) );
        /* as this must be a ground transporter copy current fuel value */
        unit->cur_fuel = source->cur_fuel;
    }
    update_bar( unit );
}

/*
====================================================================
Return True if unit uses a ground transporter.
====================================================================
*/
int unit_check_ground_trsp( Unit *unit )
{
    if ( unit->trsp_prop.id == 0 ) return 0;
    if ( unit->trsp_prop.flags & FLYING ) return 0;
    if ( unit->trsp_prop.flags & SWIMMING ) return 0;
    return 1;
}

/*
====================================================================
Backup unit to its backup pointer (shallow copy)
====================================================================
*/
void unit_backup( Unit *unit )
{
    memcpy( unit->backup, unit, sizeof( Unit ) );
}
void unit_restore( Unit *unit )
{
    if ( unit->backup->prop.id != 0 ) {
        memcpy( unit, unit->backup, sizeof( Unit ) );
        memset( unit->backup, 0, sizeof( Unit ) );
    }
    else
        fprintf( stderr, "%s: can't restore backup: not set\n", unit->name );
}

/*
====================================================================
Check if target may do rugged defense
====================================================================
*/
int unit_check_rugged_def( Unit *unit, Unit *target )
{
    if ( ( unit->sel_prop->flags & FLYING ) || ( target->sel_prop->flags & FLYING ) )
        return 0;
    if ( ( unit->sel_prop->flags & SWIMMING ) || ( target->sel_prop->flags & SWIMMING ) )
        return 0;
    if ( !unit_is_close( unit, target ) ) return 0;
    if ( target->entr == 0 ) return 0;
    return 1;
}

/*
====================================================================
Compute the targets rugged defense chance.
====================================================================
*/
int unit_get_rugged_def_chance( Unit *unit, Unit *target )
{
    /* PG's formula is
       5% * def_entr * 
       ( (def_exp_level + 2) / (atk_exp_level + 2) ) *
       ( (def_entr_rate + 1) / (atk_entr_rate + 1) ) */
    return (int)( 5.0 * target->entr *
           ( (float)(target->exp_level + 2) / (unit->exp_level + 2) ) *
           ( (float)(target->sel_prop->entr_rate + 1) / (unit->sel_prop->entr_rate + 1) ) );
}
