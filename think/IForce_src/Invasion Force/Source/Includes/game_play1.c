/*
   game_play1.c -- game play module for Invasion Force

   This module handles game play: loading and saving games, getting orders
   from the user, moving units, handling combat, and presenting various
   menus for branching to the status reports, message system, etc.

   This source code is free.  You may make as many copies as you like.
*/

#include "global.h"
#include <proto/layers.h>

#define CLEAR_WINDOW() SetRast(rast_port,0);zero_scrollers();display=0;

#define EXIT_GAME 1     // kluge values for flow control
#define GAME_OVER 2
#define UNIT_DONE 3     // I mainly use these to break out of nested functions
#define UNIT_LOST 4
#define GO_SURVEY 5
#define EXIT_SURVEY   6
#define GO_MOVEMENT   7
#define END_TURN      8
#define GAME_RESTORED 9
#define GO_PRODUCTION 10
#define CE_RESTART -17

int control_flag = 0;   // kluge variable to break out of nested funcs

#define INVISIBLE 0
#define VISIBLE 1       // flag values, purely for more readable code

char game_filepath[108], game_filename[108];

struct Menu *move_menu_strip = NULL;
struct Menu *vey_menu_strip = NULL;
struct Menu *prod_menu_strip = NULL;

int PathCost=0;

struct PLayer roster[9];
int player = 0;    // number of the current player
int turn = 0;      // current turn number
BOOL display;      // current status of player display
int cursx, cursy;  // current location of the survey cursor
char id_filetag[5];  // identifies temporary files
struct MinList unit_list;   // master list of active game pieces
struct BattleRecord battle;

char *prefix = "T:EMP2.";   // prefix for all Invasion force temporary files

// set_display_offsets() will set the xoffs and yoffs values to try and
// center the specified col & row map position as closely as possible

void set_display_offsets(col,row)
{
   int overlap=(wrap?WRAP_OVERLAP:0);
   int wd=width+2, ht=height+2;

   xoffs = col-(disp_wd >> 1);
   if (xoffs<(0-overlap))
      xoffs = (0-overlap);
   if (xoffs>(wd-disp_wd+overlap))
      xoffs = (wd-disp_wd+overlap);

   yoffs = row-(disp_ht >> 1);
   if (yoffs<-overlap)
      yoffs = -overlap;
   if (yoffs>ht-disp_ht+overlap)
      yoffs = ht-disp_ht+overlap;

   update_scrollers();
}


/*
   count_units_at() -- return number of units at the specified map sector.
   The AO can call this function to see how many units he has on a specified
   sector, but should only call it for sectors he controls.  Using it to see
   how many units the enemy has in a sector would be cheating!
*/

int count_units_at(col,row)
int col,row;
{
   int ctr = 0;
   struct Unit *unit = (struct Unit *)unit_list.mlh_Head;

   for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
      if (unit->col==col && unit->row==row)
         ctr++;
   return ctr;
}


// this is the case where the player has just seen a city, so we
// must create an icon for it on his map

void add_city_to_player_map(player,metro)
int player;
struct City *metro;
{
   struct MapIcon *icon = AllocVec((long)sizeof(*icon),MEMF_CLEAR);

   if (icon==NULL) return;    // Will this mean Phantom Cities?

   // copy basic information
   icon->col = metro->col;
   icon->row = metro->row;
   icon->type = CITY;
   icon->owner = metro->owner;

   if (metro->owner==player)
      icon->stacked = (count_units_at(icon->col,icon->row)>1);
   else
      icon->stacked = FALSE;
   AddTail((struct List *)&PLAYER.icons,(struct Node *)icon);
}


// similar to function above
// adds an icon to the map, this time for a unit

void add_icon_to_player_map(player,unit)
int player;
struct Unit *unit;
{
   struct MapIcon *icon = AllocVec((long)sizeof(*icon),MEMF_CLEAR);

   if (icon==NULL) return;

   // copy basic information
   icon->col = unit->col;
   icon->row = unit->row;
   icon->type = unit->type;
   icon->owner = unit->owner;
   icon->token = ORDER_NONE;
   if (unit->owner==player && unit->orders!=NULL)
      icon->token = unit->orders->type;

   if (player==unit->owner)
      icon->stacked = (count_units_at(icon->col,icon->row)>1);
   else
      icon->stacked = FALSE;
   AddTail((struct List *)&PLAYER.icons,(struct Node *)icon);
}


/*
   submarines cannot see land or air units
   when a hex is being explored, this function determines whether
   a land or air unit is seen either by a sub or by some other adjacent
   unit or city; returns TRUE if seen, FALSE otherwise
*/
BOOL seenby_subP(player,targ)
int player;
struct Unit *targ;
{
   int col=targ->col, row=targ->row;
   int num_hexes=adjacent(col,row);
   struct City *metro;
   struct Unit *unit;
   int ctr;

   if (targ->owner==player)
      return TRUE;

   if (wishbook[targ->type].ship_flag)  // subs can always see ships
      return TRUE;

   // search adjacent hexes for cities or units that can spot the target
   for (ctr=0; ctr<num_hexes; ctr++) {
      col = hexlist[ctr].col;
      row = hexlist[ctr].row;
      if (metro = city_hereP(col,row))
         if (metro->owner==player)
            return TRUE;
      for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->col==col && unit->row==row && unit->owner==player)
            if (unit->type!=SUB)
               return TRUE;
   OD
   return FALSE;  // nobody spotted him
}


// determine whether a submarine at the given position is visible
// returns TRUE if the unit "sub" can be seen by any cities or other
// units owned by "player", otherwise FALSE

BOOL sub_seenP(player,sub)
int player;    // the player who is exploring
struct Unit *sub;
{
   int col=sub->col, row=sub->row;
   int terrain=get(t_grid,col,row);
   int num_hexes=adjacent(col,row);
   struct City *metro;
   struct Unit *unit;
   int ctr;

   if (sub->owner==player)
      return TRUE;

   if (terrain==HEX_SHALLOWS)   // subs always visible in shallow water
      return TRUE;

   // search adjacent hexes for cities or units that can spot the sub
   for (ctr=0; ctr<num_hexes; ctr++) {
      col = hexlist[ctr].col;
      row = hexlist[ctr].row;
      if (metro = city_hereP(col,row))
         if (metro->owner==player)
            return TRUE;
      for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->col==col && unit->row==row && unit->owner==player)
            if (unit->type==CRUISER || unit->type==DESTROYER || unit->type==SUB)
               return TRUE;
   OD
   return FALSE;  // nobody spotted him
}


/*
   recon() determines if a given city is vulnerable to recon by the current
   player's aircraft (in other words, if the player has a plane in an
   adjacent hex to see what the city is producing); if the city is
   vulnerable to recon, we will store the production type in city.recon[]
*/

void recon(metro)
struct City *metro;
{
   int hexes, ctr;

   if (metro==NULL)
      return;
   if (metro->owner==player || metro->owner==0)
      return;

   hexes = adjacent(metro->col,metro->row);   // build list of adjacent hexes
   for (ctr=0;ctr<hexes;ctr++) {
      struct Unit *unit = (struct Unit *)unit_list.mlh_Head;

      // search this hex for recon aircraft (currently only fighters)
      for (;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->col==hexlist[ctr].col && unit->row==hexlist[ctr].row)
            if (unit->owner==player && unit->type==FIGHTER) {
               metro->recon[player] = metro->unit_type;
               return;
            FI
   }
}


// very important -- function to explore a hex for a certain player

void explore_hex(player,col,row,visible,forced)
int player, col, row, visible, forced;
{ // explore an individual hex

   // try wrapping the value around onto the map
   wrap_coords(&col,&row);

   // now see what terrain is here
   put(PLAYER.map,col,row,get(t_grid,col,row));

   // also roads
   if (get_flags(t_grid,col,row)&ROAD)
      put_flags(PLAYER.map,col,row,get_flags(PLAYER.map,col,row)|ROAD);
   else
      put_flags(PLAYER.map,col,row,get_flags(PLAYER.map,col,row)&(~ROAD));

   /* clear any outdated icons from the player's map, this position */
   {
      BOOL zapped;

      do {
         struct MapIcon *icon = (struct MapIcon *)PLAYER.icons.mlh_Head;

         zapped = FALSE;
         for (; icon->inode.mln_Succ; icon = (struct MapIcon *)icon->inode.mln_Succ) {
            if (icon->col==col && icon->row==row) {
               Remove((struct Node *)icon);
               FreeVec(icon);
               zapped = TRUE;
               break;
            FI
         OD
      } while (zapped);
   }

   // update any city that might be here
   {
      struct City *metro = (struct City *)city_list.mlh_Head;
      for ( ; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ)
         if (metro->col==col && metro->row==row) {
            add_city_to_player_map(player,metro);
            recon(metro);   // try to recon the city
            goto eh_final_update;  /* don't display military units if a city is here */
         FI
   }

   // finally, search for new up-to-date pieces and map them
   {
      struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
      BOOL mapped=FALSE;

      for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
         if (unit->row==row && unit->col==col) { // found one!
            if (unit->owner!=player)
               clear_orders(unit);  // enemy units come off sentry now
            if (unit->ship)  continue;    /* don't map units on board ships */
            if (unit->type==SUB)    // subs sometimes not visible, of course
               if (sub_seenP(player,unit)==FALSE)
                  continue;
            if (seenby_subP(player,unit)==FALSE && forced==FALSE)
               continue;
            if (mapped==FALSE) {
               mapped = TRUE;  // only map the first one
               add_icon_to_player_map(player,unit);
            FI
         FI
   }

 eh_final_update:
   if (visible)  //NOTE: this is now a BOOLEAN value!
      GP_update_hex_display(col,row);
}


/*
   given a hex, explore_at_hex() will explore it and everyplace
   directly adjacent -- this is the normal way that exploration happens
   in Invasion Force
*/
void explore_at_hex(player,col,row,visible,forced)
int player, col, row, visible, forced;
{ // explore everything in and adjacent to a given hex
   explore_hex(player,col,row,visible,forced);
   explore_hex(player,col-1,row,visible,forced);
   explore_hex(player,col+1,row,visible,forced);
   explore_hex(player,col,row-1,visible,forced);
   explore_hex(player,col,row+1,visible,forced);
   if (row%2) {  /* i.e. if it's an odd-numbered column */
      explore_hex(player,col+1,row-1,visible,forced);
      explore_hex(player,col+1,row+1,visible,forced);
   } else {
      explore_hex(player,col-1,row-1,visible,forced);
      explore_hex(player,col-1,row+1,visible,forced);
   FI
}


// gives the city to a player, either his home city at the start of the game,
// or else a city he has conquered with a military unit -- and includes a
// call to examine_city() in the "status.c" module

void conquer_city(taken_city)
struct City *taken_city;
{  // take a city
   int prior_owner=taken_city->owner;
   BOOL vis=Bool(PLAYER.show&SHOW_GRP);  // visibility

   /*
      When this function is called, the map should *already* be displayed
      and scrolled to the proper location, so the city is positioned on the
      screen; conquer_city() does NOT do this automatically.
   */
   taken_city->owner = player;   // city mine now!
   // update the map icons for both old and new owners
   if (prior_owner!=0)     // no prior owner of neutral cities
      explore_hex(prior_owner,taken_city->col,taken_city->row,INVISIBLE,TRUE);
   explore_at_hex(player,taken_city->col,taken_city->row,vis,TRUE);
   if (vis) {
      // do this so the user can see which city he is looking at
      save_hex_graphics(taken_city->col,taken_city->row,0);    // blit the background to a safe place
      plot_mapobject(taken_city->col,taken_city->row,MAP_MARKER);
   FI
   // set production to -1 to show that we will be restarting
   // production from zilch
   taken_city->unit_type = -1;
   taken_city->unit_wip = 0;
   if (ISHUMAN(PLAYER.type)) {
      // create requester -- let him select production
      examine_city(taken_city);
      // unmark the city on screen
      restore_hex_graphics(taken_city->col,taken_city->row,0);
   FI
   if (NONHUMAN(PLAYER.type)) {
      // we call the computer player version of selecting production
      set_automated_production(taken_city);
   FI
}


// return the player who controls the specified hex, or 0 if nobody does
int hex_owner(col,row)
int col,row;
{
   struct City *metro;
   struct Unit *unit=(struct Unit *)unit_list.mlh_Head;

   // search the cities
   if (metro = city_hereP(col,row))
      return (int)metro->owner;

   // search the military units
   for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
      if (unit->col==col && unit->row==row)
         return (int)unit->owner;

   return 0;
}


// quick macro to see if a unit has been killed
#define ALIVE(a) (a->damage<wishbook[a->type].hitpoints)


/***
   choose_defender() == select a unit to defend a hex that has come under attack
   This is supposed to handle the complexities of combat that were introduced
   when I implemented stacking rules, particularly when different kinds of
   units are stacked in the hex that is under attack
***/

struct Unit *choose_defender(attacker,targx,targy)
struct Unit *attacker;
int targx, targy;
{
   struct Unit *unit, *defender=NULL;
   static int aapt[] = { 4, 5, 3,  2,  1, 6, 7, 8, 10, 11, 9, 99, 99 };
   static int sapt[] = { 1, 2, 3, 11, 10, 4, 5, 6,  8,  9, 7, 99, 99 };
   int *table = sapt;
   int priority = 99;
   int terrain = get(t_grid,targx,targy);

   // first determine if I should use the AAPT or the SAPT
   if (attacker->type==FIGHTER)
      table = aapt;

   for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
      if (unit->col==targx && unit->row==targy)
         if (table[unit->type]<priority) {
            // I have to throw out any ground units that are on board a ship
            if (OCEAN_P(terrain) && (unit->type==RIFLE || unit->type==ARMOR))
               continue;
            // also throw out any fighters that are landed (not overflying)
            if (unit->ship)
               continue;
            defender = unit;
            priority = table[unit->type];
         FI

   if (defender==NULL)
      print("ERROR: choose_defender() failed to find defending unit for combat!\n");

   return defender;
}


/***
   attack_hex() == universal attack function
   All attacks in the game are targetted against a hex, not against specific
   enemy units.  This function calculates the defensive strength of the target
   hex and resolves the conflict.  The outcome is stored in "control_flag" and
   in the combat report.
***/

void attack_hex(attacker,targx,targy)
struct Unit *attacker;
int targx, targy;
{
   int att_player=attacker->owner, def_player=0;// attacking and defending players
   int def_terrain;
   int attfact, deffact, movement_cost;
   struct Unit *defender=NULL;
   struct Unit militia;
   BOOL bombardment=FALSE;
   BOOL white_flag=FALSE;
   ULONG num_blows, bit_blows;
   struct City *captured=NULL;

   clear_orders(attacker);    // just to make sure

   /*
      First part of this function is devoted to detecting various kinds of
      invalid attacks and weeding them out before we get to the good stuff.
   */

   // has the unit already attacked something this turn?
   // fighters can make multiple attacks per turn; other cannot
// I have disabled this until I get a beter idea how it should work
//   if (attacker->type!=FIGHTER && attacker->attacks>0) {
//      tell_user2("That unit has already attacked once this turn.",FALSE,DONK_SOUND);
//      return;     // other units cannot
//   FI

   if (city_hereP(targx,targy))
      switch (attacker->type) {
         case BOMBER:   // bomber can attack city, but not capture it
            bombardment = TRUE;
         case ARMOR:
         case RIFLE:
         case AIRCAV:
            break;      // these units can attack cities
         default:       // other units cannot
            if (PLAYER.show&SHOW_REQ) {
               playSound(DONK_SOUND,PLAYER.snd_vol);
               alert(map_window,"Information...","That unit cannot attack a city.","Okay");
            }
            return;
      };

   // bombers and aircav cannot attack any hex containing airborne craft
   // aircraft on carriers or in cities or airfields are not considered airborne
   if (attacker->type==BOMBER || attacker->type==AIRCAV)
      if (city_hereP(targx,targy)==NULL) {
         struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
         for (;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
            if (unit->ship==NULL && unit->col==targx && unit->row==targy)
               switch (unit->type) {
                  case FIGHTER:
                  case BOMBER:
                  case AIRCAV:
                     if (PLAYER.show&SHOW_REQ) {
                        playSound(DONK_SOUND,PLAYER.snd_vol);
                        alert(map_window,"Information...","Bombers or air cav cannot attack other aircraft.","Okay");
                     }
                     return;
               }
      FI

   def_terrain = get(t_grid,targx,targy);
   if (city_hereP(targx,targy)) {
      def_terrain = HEX_CITY;
      // create a dummy "militia unit" to defend the city
      militia.col = targx;
      militia.row = targy;
      militia.owner = city_hereP(targx,targy)->owner;
      militia.type = RIFLE;
      militia.damage = 0;
      militia.orders = NULL;
      defender = &militia;
      def_player = city_hereP(targx,targy)->owner;
      // set flag to show we are using a militia unit
      white_flag = TRUE;
   };

   /* find the defending UNIT in the hex -- the unit we are using to */
   /* determine the defender's strength, etc. */
   if (defender==NULL)
      defender = choose_defender(attacker,targx,targy);

   if (defender) {
      clear_orders(defender);    // just to make sure
      if( def_player == 0 )
          def_player = defender->owner;
   } else {
      print("Error finding defender for combat!\n");
      return;
   FI

   // when a fighter attacks a hex containing both aircraft and other units,
   // I set the bombardment flag to show the fighter should not enter the
   // hex, even if victorious
   if (attacker->type==FIGHTER) {
      BOOL air=FALSE, surface=FALSE;
      struct Unit *unit;
      for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->col==targx && unit->row==targy) {
            if (wishbook[unit->type].range>0)   // aircraft
               air=TRUE;
            else
               surface=TRUE;
            if (air==TRUE && surface==TRUE) {
               bombardment = TRUE;
               break;
            FI
         FI
   FI

   // most ships cannot attack ground forces; only cruisers and battleships can
   if (movement_cost_table[attacker->type][def_terrain]<0)
      switch (attacker->type) {
         case TRANSPORT:
         case SUB:
         case DESTROYER:
         case CARRIER:
            if (PLAYER.show&SHOW_REQ) {
               playSound(DONK_SOUND,PLAYER.snd_vol);
               sprintf(foo,"The %s cannot bombard land targets.",
                  wishbook[attacker->type].name);
               (void)rtEZRequestTags(foo,"Oops!",NULL,NULL,
                  RT_Window,        map_window,
                  RT_ReqPos,        REQPOS_CENTERSCR,
                  RT_LockWindow,    TRUE,
                  RTEZ_Flags,       EZREQF_CENTERTEXT,
                  TAG_DONE );
               }
            return;
         case CRUISER:
         case BATTLESHIP:
            bombardment = TRUE;
      }

   // riflemen or armor can bombard ships unless aircraft are protecting them
   if (OCEAN_P(def_terrain))
      if (attacker->type==RIFLE || attacker->type==ARMOR) {
         /*
            At this point we might have ground forces trying to attack something
            in a HEX_SHALLOWS terrain with a bridge over it.

            Otherwise the ground forces must be trying to bombard an ocean hex.
            This would mean it's attacking a hex with ships or aircraft or both.
         */
         BOOL ship_here=FALSE, aircraft_here=FALSE, bridge_here=FALSE;
         struct Unit *sunit;

         // check for roads first
         if (get_flags(t_grid,attacker->col,attacker->row)& \
         get_flags(t_grid,defender->col,defender->row)&ROAD)
            bridge_here = TRUE;

         for (sunit=(struct Unit *)unit_list.mlh_Head;sunit->unode.mln_Succ;sunit=(struct Unit *)sunit->unode.mln_Succ)
            if (wishbook[sunit->type].ship_flag && sunit->col==targx && sunit->row==targy) {
               ship_here = TRUE;
               break;
            FI
         for (sunit=(struct Unit *)unit_list.mlh_Head;sunit->unode.mln_Succ;sunit=(struct Unit *)sunit->unode.mln_Succ)
            if (wishbook[sunit->type].range>0 && sunit->col==targx && sunit->row==targy) {
               aircraft_here = TRUE;
               break;
            FI
         /*
            There are three possibilities for the target ocean hex.  It could have
            ships, aircraft, or both ships and aircraft.  Each calls for a slightly
            different response.
         */
         if (aircraft_here && ship_here) {
            if (PLAYER.show & SHOW_REQ) {
                playSound(DONK_SOUND,PLAYER.snd_vol);
                (void)rtEZRequestTags(\
                   "Enemy air cover prevents your ground forces\nfrom bombarding ships there.",
                   "Drat!",NULL,NULL,
                   RT_Window,        map_window,
                   RT_ReqPos,        REQPOS_CENTERSCR,
                   RT_LockWindow,    TRUE,
                   RTEZ_Flags,       EZREQF_CENTERTEXT,
                   TAG_DONE );
                }
            return;
         FI
         if (aircraft_here) {
            if (PLAYER.show & SHOW_REQ) {
                playSound(DONK_SOUND,PLAYER.snd_vol);
                (void)rtEZRequestTags(\
                   "Ground forces cannot attack aircraft that are over water.",
                   "Drat!",NULL,NULL,
                   RT_Window,        map_window,
                   RT_ReqPos,        REQPOS_CENTERSCR,
                   RT_LockWindow,    TRUE,
                   RTEZ_Flags,       EZREQF_CENTERTEXT,
                   TAG_DONE );
                }
            return;
         FI
         // if weve made it this far, there must only be ships
         if (wishbook[defender->type].ship_flag)
            bombardment = TRUE;
      FI

   // determine whether the attacking unit has enough movement value left
   // to carry out the assault, i.e. enough to enter the enemy hex area
   if (def_terrain==HEX_CITY || bombardment==TRUE)
      movement_cost = 60;
   else
      movement_cost = movement_cost_table[attacker->type][def_terrain];

   if (movement_cost < attacker->move) {
      attacker->move -= movement_cost;
      if (attacker->move<11) {
         attacker->move = 0;
         control_flag = UNIT_DONE;
      }
   } else {    // he only has enough movement for a /chance/ at this
      int chance = attacker->move;

      attacker->move = 0;
      control_flag = UNIT_DONE;
      if (RangeRand(movement_cost)>chance) {
         if( PLAYER.soundfx == SOUND_ALL ) {
             // Only play the sound if the player wants stuff shown
             playSound(SMASH_SOUND,PLAYER.snd_vol);
         }
         return;     // his movement attempt failed
      FI
   }

   /*
      Bombardment, in the context of this game, means that a unit is attacking
      a hex area that it cannot move onto, such as a cruiser firing upon rifle
      units.  The only difference between bombardment and normal combat is that
      the victorious attacking unit does not move.
   */

   /*
      Now we take time out to initialize and record basic information
      into the structure for the combat report.
   */
   battle.turn = turn;
   battle.att_x = attacker->col;
   battle.att_y = attacker->row;
   battle.att_owner = attacker->owner;
   battle.att_type = attacker->type;
   battle.def_x = defender->col;
   battle.def_y = defender->row;
   battle.def_owner = defender->owner;
   battle.white_icon = white_flag;
   battle.def_type = defender->type;
   battle.winner = 0;
   battle.casualties = 0;
   battle.bombardment = bombardment;
   // always seen by defender; we can add others flags later
   battle.seen_by = mask(battle.def_owner);
   battle.blows = 0L;

   // track number of attacks made by this unit
   attacker->attacks++;

   // move the unit
   if (bombardment==FALSE) {
      attacker->col = targx;
      attacker->row = targy;
   FI
   // keep survey mode up to date
   cursx = attacker->col;  cursy = attacker->row;
   if (attacker->ship) {     // he must be attacking from on board a ship
      attacker->ship->cargo--;
      attacker->ship->weight -= cargo_weight(attacker->type);
      if (attacker->ship->type==TRANSPORT)
         attacker->move = 0;   // unloading from a transport expends movement
      attacker->ship=NULL;  // so we unlink him from it
   FI
   if (attacker->type==TRANSPORT && attacker->cargo>0) {   // ship moves, cargo moves
      struct Unit *cargo=(struct Unit *)unit_list.mlh_Head;
      for (; cargo->unode.mln_Succ; cargo=(struct Unit *)cargo->unode.mln_Succ)
         if (cargo->ship==attacker) {
            cargo->col=targx;  cargo->row=targy;
            clear_orders(cargo);
         }
   }
   if (wishbook[attacker->type].range>0)   // units that need fuel, i.e. aircraft
      attacker->fuel--;

   /*
      This function looks at an attacking unit and a defending unit and adds up
      various modifiers based on the types of units, the terrain, the handicap
      of the players, etc.  It sticks the results in attfact and deffact.
   */
   NCS_combat_mods(attacker,defender,&attfact,&deffact);

   /*
      battle actually takes place; calculate attacks, damage
      record combat reports, display battle action and sounds
      NOTE: battle always begins with two visible blows that have no game
      effect, but serve to establish visually who is attacking who
   */
   num_blows = 2L;    bit_blows = 2L;
   while (ALIVE(attacker) && ALIVE(defender)) {
      int attval, defval;
      static int strength[] = { 1, 1, 1, 2, 1, 1, 3, 1, 2, 3, 1, 1 };

      /*
         strength is the amount of damage done by a hit from the unit
         infantry --- 1
         armor ------ 1
         aircav ----- 1
         bomber ----- 2
         fighter ---- 1
         transport -- 1
         sub -------- 3
         destroyer -- 1
         cruiser ---- 2
         battleship - 3
         carrier ---- 1
      */

      /*
         Here is the NCS (New Combat System) which is based on simulated roll of
         three six-sided dice (3d6) for each player.

            attval = 3d6 + attfact
            defval = 3d6 + deffact

         And whoever's total is higher wins the round of combat.
      */

      do {
         attval = 3 + RangeRand(6L) + RangeRand(6L) + RangeRand(6L) + attfact;
         defval = 3 + RangeRand(6L) + RangeRand(6L) + RangeRand(6L) + deffact;
      } while (attval==defval);     // we don't allow draws

      if (num_blows<24L) {
         num_blows++;
         bit_blows <<= 1;  // make way for the bit
         if (attval>defval)
            bit_blows |= 1L;   // this bit shows who was hit
      FI
      if (attval>defval)
         defender->damage += strength[attacker->type];
      else {
         attacker->damage += strength[defender->type];

         /*
            If the attacker is a ship, and it's taken enough damage to slow its
            speed, then I want to go back and retro-actively reduce its rate for
            THIS turn.  In other words, if my destroyer (speed 3) attacks on its
            first move of this turn, and it takes two points of damage, it's
            speed should be *immediately* reduced to one -- and that one has
            already been expended in the attack!
         */
         if (unit_speed(attacker)<wishbook[attacker->type].speed)
            attacker->move = 0;
      FI
   OD
   battle.blows = (num_blows<<24) | bit_blows;

   if (ALIVE(defender)) {   // defeat first; its easier
      if (attacker->ship) {  // he could be attacking from on board a ship!
         attacker->ship->cargo--;
         attacker->ship->weight -= cargo_weight(attacker->type);
      FI
      Remove((struct Node *)attacker);
      // increment Units Lost in Combat
      roster[attacker->owner].ulc[attacker->type]++;
      roster[defender->owner].eud[attacker->type]++;
      control_flag = UNIT_LOST;
      /* record the event for posterity */
      battle.winner = battle.def_owner;
   } else {    // victory here
      // go down the list for defending units to destroy
      // we must do multiple searches, because destroying a unit messes
      // up the list structure
      BOOL unit_found;
      struct Unit *unit;
      do {
         unit_found = FALSE;
         for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
            if (unit->col==targx && unit->row==targy && unit->owner!=attacker->owner) {
               if (attacker->type==FIGHTER && bombardment==TRUE)
                  if (wishbook[unit->type].range<=0)  // not an aircraft
                     continue;
               Remove((struct Node *)unit);
               roster[unit->owner].ulc[unit->type]++;    // inc. Units Lost in Combat
               roster[attacker->owner].eud[unit->type]++;   // inc. Enemy Units Destroyed
               battle.casualties++;
               destruct_unit(unit);
               unit_found = TRUE;
               break;
            FI
      } while (unit_found);
      // if theres a city here, attacker conquers it
      captured = city_hereP(targx,targy);
      if (captured)
         if (captured->owner)    // a non-neutral city is taken
            battle.seen_by |= mask(captured->owner);
      if (captured!=NULL && bombardment==FALSE) {
         // attacking unit is dispersed to hold the city
         Remove((struct Node *)attacker);
         roster[attacker->owner].ulc[attacker->type]++;   // inc. Units Lost in Combat
         control_flag = UNIT_LOST;
      FI
      battle.winner = battle.att_owner;
   FI

   // display the battle
   if (PLAYER.show & SHOW_GRP)  show_battle();
   if (captured!=NULL && bombardment==FALSE)
      conquer_city(captured);
      // BSH 1/10 - Removed the check for human player -
      //        always call conquer_city - it checks inside
      //        for human player and calls AI when needed

   // clean up some things left over after movement & battle
   if (control_flag!=UNIT_LOST)
      if (wishbook[attacker->type].range>0 && attacker->fuel<=0) {
         // aircraft out of fuel, crashes
         Remove((struct Node *)attacker);
         roster[attacker->owner].ulc[attacker->type]++;
         control_flag = UNIT_LOST;
      FI
   if (control_flag==UNIT_LOST)
      destruct_unit(attacker);   // destruct and free RAM
   {
      BOOL vis=Bool(roster[att_player].show&SHOW_GRP);
      explore_at_hex(att_player,targx,targy,vis,TRUE);
   }
   if (def_player>0)    // neutral cities never explore
      explore_at_hex(def_player,targx,targy,INVISIBLE,TRUE);

   if (control_flag!=UNIT_LOST)
      if (roster[attacker->owner].show & SHOW_GRP)
         unit_status_bar(attacker);

   {  // write the combat report file
      BPTR outfile;

      strcpy(foo,prefix);
      strcat(foo,id_filetag);
      strcat(foo,".CR");
      if (outfile = Open(foo,MODE_OLDFILE)) {
         Seek(outfile,0L,OFFSET_END);
         Write(outfile,&battle,sizeof(battle));
         Close(outfile);
      FI
   }
}


/*
   This is part of the NCS (New Combat System).

   This NCS function will accept the information about a combat event and
   calculate the attack and defense modifiers for both units -- taking into
   account unit types, terrain, stacking, and the global handicap values of
   the two players.
*/

void NCS_combat_mods(attacker, defender, att_mod, def_mod)
struct Unit *attacker, *defender;
int *att_mod, *def_mod;
{
   int terrain = get(t_grid,defender->col,defender->row);
   int atype = attacker->type;
   int dtype = defender->type;

   // I can do this shortcut because airfields defend like infantry in
   // every respect; of course it is only changed locally in this function!
   if (dtype==AIRFIELD)
      dtype = RIFLE;

   // start with the global handicap values of the players
   *att_mod = roster[attacker->owner].att;
   *def_mod = roster[defender->owner].def;

   // transports always have a -4 on defense
   if (dtype==TRANSPORT)
      *def_mod -= 4;

   // transports and carriers have a -4 on attack
   if (atype==TRANSPORT || atype==CARRIER)
      *att_mod -= 4;

   // carriers have a -2 defense and -1 for every 2 fighters on board
   if (dtype==CARRIER) {
      *def_mod -= 2;
      {      // count units on board
         int ctr = 0;
         struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
         for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
            if (unit->ship==defender) ctr++;
         *def_mod -= ctr/2;
      }
   }

   // submarines have a basic -3 defense
   if (dtype==SUB)
      *def_mod -= 3;

   // fighters & bombers have a +3 defending against ships
   if (dtype==FIGHTER || dtype==BOMBER)
      if (wishbook[atype].ship_flag)
         *def_mod += 3;

   // fighters have a +3 attack against bombers or aircav
   if (dtype==BOMBER || dtype==AIRCAV)
      if (atype==FIGHTER)
         *att_mod += 3;

   /*
      ground units defending:
         -3 against naval bombardment
         -2 against bombers
         -1 against other aircraft
   */
   if (dtype==RIFLE || dtype==ARMOR) {
      switch (dtype) {
         case CRUISER:
         case BATTLESHIP:
            *def_mod--;
         case BOMBER:
            *def_mod--;
         case FIGHTER:
         case AIRCAV:
            *def_mod--;
      }
   }

   /* That takes care of the unit-based modifiers.  Now the terrain stuff! */
   switch (terrain) {

      case HEX_DESERT:
         // ground forces -2 defense against aircraft
         if (dtype==RIFLE || dtype==ARMOR)
            if (wishbook[atype].range>0)
               *def_mod -= 2;
         // infantry -2 defense against armor
         if (dtype==RIFLE && atype==ARMOR)
            *def_mod -= 2;
         break;

      case HEX_BRUSH:
         // ground forces +1 defense against fighters or bombers
         if (dtype==RIFLE || dtype==ARMOR)
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod++;
         break;

      case HEX_FOREST:
         // ground forces +2 defense against fighters or bombers
         if (dtype==RIFLE || dtype==ARMOR)
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod += 2;
         // infantry +2 defense against armor
         if (dtype==RIFLE && atype==ARMOR)
            *def_mod += 2;
         // armor -2 defense against infantry
         if (dtype==ARMOR && atype==RIFLE)
            *def_mod -= 2;
         break;

      case HEX_JUNGLE:
         // ground forces +3 defense against fighters or bombers
         if (dtype==RIFLE || dtype==ARMOR)
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod += 3;
         // infantry +3 defense against armor
         if (dtype==RIFLE && atype==ARMOR)
            *def_mod += 3;
         // armor -3 defense against infantry
         if (dtype==ARMOR && atype==RIFLE)
            *def_mod -= 3;
         break;

      case HEX_SWAMP:
         // ground forces +1 defense against aircraft
         if (dtype==RIFLE || dtype==ARMOR)
            if (wishbook[atype].range>0)
               *def_mod++;
         // infantry +2 defense against armor shelling
         if (dtype==RIFLE && atype==ARMOR)
            *def_mod += 2;
         break;

      case HEX_RUGGED:
         // ground forces, +1 defending against fighter or bomber
         if (dtype==RIFLE || dtype==ARMOR)
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod++;
         break;

      case HEX_HILLS:
         // ground forces, +2 defending against fighter or bomber
         // ground forces, +1 defending against cruiser or battleship
         if (dtype==RIFLE || dtype==ARMOR) {
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod += 2;
            if (atype==CRUISER || atype==BATTLESHIP)
               *def_mod += 1;
         }
         break;

      case HEX_MOUNTAINS:
         // ground forces, +3 defending against fighter or bomber
         // ground forces, +2 defending against air cavalry
         // ground forces, +2 defending against cruiser or battleship
         if (dtype==RIFLE || dtype==ARMOR) {
            if (atype==FIGHTER || atype==BOMBER)
               *def_mod += 3;
            if (atype==AIRCAV)
               *def_mod += 2;
            if (atype==CRUISER || atype==BATTLESHIP)
               *def_mod += 2;
         }
         // infantry defending +3 against armor shelling
         if (dtype==RIFLE && atype==ARMOR)
            *def_mod += 3;
         break;

      case HEX_SHALLOWS:
         // subs attack -3 against ships
         if (atype==SUB && wishbook[dtype].ship_flag)
            *att_mod -= 3;
         // subs defend -2 (on top of the -3 they already have!)
         if (dtype==SUB)
            *def_mod -= 2;
         // all other ships defend at -1 in shallows
         if (wishbook[dtype].ship_flag && dtype!=SUB)
            *def_mod--;
         break;

      case HEX_DEPTH:
         // sub defends at +3 in depths
         if (dtype==SUB)
            *def_mod += 3;
         break;
   }
}


/* This routine determines the basic attack values.  I'm just passing in
   values instead of unit pointers so I can use this later for the AI
   player(s) to do "what if" scenarios and determine what is risky/not
   risky attack.
   */
void   get_attack_values ( short att_type, int att_terrain, int att_player,
       short def_type, int def_terrain, int def_player,
       int* attfact, int* deffact)
{
    /*was attfact = 100; */
   // Now we use the attack factor from the start game setting for the player
   *attfact = roster[att_player].att;
   if (att_type==TRANSPORT || att_type==CARRIER)
      *attfact /= 2;

   /*was deffact = 100; */
   // Now we use the defense factor from the start game settings
   *deffact = roster[def_player].def;
   if (def_type==TRANSPORT || def_type==SUB)
      *deffact *= 6/10;
   if (def_type==RIFLE && (att_type==CRUISER || att_type==BATTLESHIP))
      *deffact *= 6/10;
   if (def_type==BOMBER && att_type==FIGHTER)
      *deffact *= 6/10;

   // terrain effects modify attack and defense factors
   switch (att_type) {
      case ARMOR:
      case BOMBER:
         if (def_terrain==HEX_DESERT)
            *attfact += 25;
         break;
      case AIRCAV:
         if (def_terrain==HEX_FOREST)
            *attfact += 10;
         if (def_terrain==HEX_JUNGLE)
            *attfact += 20;
         break;
   }
   if (def_type==RIFLE) {
      if (def_terrain==HEX_FOREST)
         *deffact += 10;
      if (def_terrain==HEX_JUNGLE)
         *deffact += 20;
   }

   // altitude affects odds between ground units (never ships or planes)
   if (att_type==RIFLE || att_type==ARMOR)
      if (def_type==RIFLE || def_type==ARMOR) {
         switch (att_terrain) {
            case HEX_MOUNTAINS:   // these are cumulative
               *attfact += 10;    // neat, huh?
            case HEX_HILLS:
               *attfact += 10;
            case HEX_RUGGED:
               *attfact += 10;
         }
         switch (def_terrain) {
            case HEX_MOUNTAINS:
               *deffact += 10;
            case HEX_HILLS:
               *deffact += 10;
            case HEX_RUGGED:
               *deffact += 10;
         }
      FI
   /* End if */
}


// this is where each player starts the game; it selects the home city, sets
// initial production, etc.
//  Broken up into two routines so that the player will not be surprised
void create_initial_city()
{  // put a player on the map!

   struct City *home_city;    /* this player's starting city */

   // STEP ONE: locate a home city for him
   do {
      struct City *metro = (struct City *)city_list.mlh_Head;
      long num_cities = count_nodes(&city_list);
      int home_city_index = RangeRand(num_cities)+1;
      int ctr;

      for ( ctr = 1; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ, ctr++)
         if (ctr == home_city_index) {
            home_city = metro;
            break;
         FI
   } while (home_city->owner);  /* make sure it's a neutral city */

   // Make him the owner
   home_city->owner = player;

   return;
}
void jumpstart_player()
{
    /* Find the player's home city */
   struct City* metro = (struct City*)city_list.mlh_Head;
   while( (metro->cnode.mln_Succ) && (metro->owner != player) )
      metro = (struct City*)metro->cnode.mln_Succ;

   // create his map display, all spaces unknown
   if (alloc_map(&PLAYER.map)==FALSE)
      clean_exit(2,"ERROR: Fatal RAM allocation disaster!\n");

   // put his city and surrounding area on the map
   explore_at_hex(player,metro->col,metro->row,INVISIBLE,TRUE);

   // If File-Mail play create passwords
   //if(fmail)
   //     create_passlock();
        
   // call him to the console and show the map
   create_player_display(metro->col,metro->row);

   // initialize his city production
   conquer_city(metro);
}


void unit_name_request(metro,unit)
struct City *metro;
struct Unit *unit;
{
   BOOL exam=FALSE, ship=wishbook[unit->type].ship_flag;
   char *name;
   struct Window *name_window=NULL;
   struct Gadget *context, *name_gad, *cont_gad, *prod_gad;
   struct NewGadget button = {
      77,66,      // leftedge, topedge
      98,16,   // width, height
      "_Continue",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   }, strfield = {
      173,40,      // leftedge, topedge
      200,16,   // width, height
      "Ship _Name:", // text label
      NULL,    // font
      3,       // gadget ID
      PLACETEXT_LEFT,
      NULL,NULL
   };

   /* make sure user doesn't play with the map window now */
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the [Continue] and [Production] buttons
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   cont_gad = CreateGadget(BUTTON_KIND,context,&button,
      GT_Underscore, '_',
      TAG_END);
   button.ng_LeftEdge = 221;
   button.ng_GadgetText = "_Production";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   prod_gad = CreateGadget(BUTTON_KIND,cont_gad,&button,
      GT_Underscore, '_',
      TAG_END);

   // randomly select a name for this unit
   name = random_name(unit->type);

   // create the name field
   strfield.ng_VisualInfo = vi;
   strfield.ng_TextAttr = &topaz11;
   if (ship)
   name_gad = CreateGadget(STRING_KIND,prod_gad,&strfield,
      GTST_String,            name,
      GTST_MaxChars,          19L,
      STRINGA_Justification,  GACT_STRINGCENTER,
      GT_Underscore,          '_',
      TAG_END);

   // do the window itself
   {
      int x, y, wd=414, ht=88;

      // I need to do some pixelly math to figure out the most
      // aesthetically pleasing place to put the requester
      // It must be near the city in question, yet not hide it from view.
      log_to_abs(metro->col,metro->row,&x,&y);
      x -= 30;
      y += 45;
      if (y>map_window->Height-ht)
         y -= (90+ht);

      name_window = OpenWindowTags(NULL,
         WA_Gadgets,       context,
         WA_Title,         "New unit produced...",
         WA_CustomScreen,  map_screen,
         WA_Top,y,         WA_Left,x,
         WA_Height,ht,     WA_Width,wd,
         WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY,
         WA_Flags,         NOCAREREFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
         TAG_END );
   }
   if (name_window==NULL)
      clean_exit(1,"ERROR: Unable to open production requester!");

   // render in some text and a little picture
   rast_port = name_window->RPort;
   sprintf(foo,"%s produced a %s.",metro->name,wishbook[unit->type].name);
   plot_text(10,21,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   px_plot_icon(unit->type,45,39,PLAYER.color,0,FALSE);
   if (!ship) {
      sprintf(foo,"%s %s",name,wishbook[unit->type].name);
      plot_text(125,43,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   FI

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(name_window->UserPort);
         while (message = GT_GetIMsg(name_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  case 13:
                  case 'c':    // default for CONTINUE
                     // show the button depressed
                     show_depress(cont_gad,name_window->RPort);
                     Delay(10L);
                     goto exit_name_window;
                  case 'p':   // default for PRODUCTION
                     show_depress(prod_gad,name_window->RPort);
                     Delay(10L);
                     exam = TRUE;
                     goto exit_name_window;
                  case 'n':   // activate the NAME string
                     ActivateGadget(name_gad,name_window,NULL);
               }
            FI
            if (class==IDCMP_GADGETUP) {
               if (object==cont_gad) {
                  goto exit_name_window;
               FI
               if (object==prod_gad) {
                  exam = TRUE;
                  goto exit_name_window;
               FI
            FI
         OD
      OD
   }
   exit_name_window:

   // fetch new name string from the gadget
   if (ship)
      name_unit(unit,((struct StringInfo *)name_gad->SpecialInfo)->Buffer);
   else
      name_unit(unit,name);

   // now close up everything with the mapsize_window
   CloseWindow(name_window);
   rast_port = map_window->RPort;
   name_window = NULL;
   FreeGadgets(context);
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
   if (exam)
      examine_city(metro);
}


// go through the production of all cities owned by the current player, and
// do this turn's production of military units, etc.
// it returns the number of units produced

int do_cities_production()
{
   struct City *metro = (struct City *)city_list.mlh_Head;
   int ctr = 0;

   /*
        The map wasn't updating correctly sometimes, so I decided to make
        two passes on the city list.  Now it goes through the list once to
        update the WIP and the map area around the cities, then a second
        pass for actual production of units.
   */

   for( ; metro->cnode.mln_Succ; metro=(struct City*)metro->cnode.mln_Succ)
      if( metro->owner == player) {
         metro->unit_wip += (metro->industry*PLAYER.prod)/50;
         explore_at_hex(player,metro->col,metro->row,INVISIBLE,TRUE);
      }

   metro = (struct City*)city_list.mlh_Head;
   for ( ; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ)
      if (metro->owner==player) {
        if (metro->unit_wip >= wishbook[metro->unit_type].build) {
            struct Unit *new_unit = AllocVec((int)sizeof(*new_unit),MEMF_CLEAR);

            metro->unit_wip = 0;

            // build the unit
            new_unit->col = metro->col;
            new_unit->row = metro->row;
            new_unit->owner = player;
            new_unit->type = metro->unit_type;
            new_unit->move = unit_speed(new_unit);
            new_unit->damage = 0;

            // Added by BSH
            new_unit->attacks = 0;
            new_unit->cargo = 0;
            new_unit->ship = NULL;
            new_unit->orders = NULL;
            // End Added BSH

            new_unit->fuel = wishbook[new_unit->type].range;
            name_unit(new_unit,"UNNAMED");

            AddTail((struct List *)&unit_list,(struct Node *)new_unit);
            ctr++;

            // now inform the user and let him reset the production
            if (wishbook[new_unit->type].ship_flag || PLAYER.show_production) {
               if (display==FALSE)
                  create_player_display(metro->col,metro->row);
               if (need_to_scrollP(metro->col,metro->row)) {
                  int ox=xoffs, oy=yoffs;

                  set_display_offsets(metro->col,metro->row);
                  GP_smart_scroll(ox,oy);
               FI

               // do this so the user can see which city he is looking at
               save_hex_graphics(metro->col,metro->row,0);    // blit the background to a safe place
               plot_mapobject(metro->col,metro->row,MAP_MARKER);
               unit_name_request(metro,new_unit);

               // unmark the city on screen
               GP_update_hex_display(metro->col,metro->row);
            FI
         FI
      FI
   return ctr;
}


void unit_status_bar(unit)
struct Unit *unit;
{
    char foo2[30];
   /*
      With ships, the unit type goes first, like for example...
         Battleship Texas
      ...but with other units the name goes first, then the type...
         101st Infantry
   */
   if (wishbook[unit->type].ship_flag)
      sprintf(foo,"%s %s",wishbook[unit->type].name,unit->name);
   else
      sprintf(foo,"%s %s",unit->name,wishbook[unit->type].name);
   if (wishbook[unit->type].hitpoints>1) {
      sprintf(bar,"  hits:%ld/%ld",unit->damage,wishbook[unit->type].hitpoints);
      strcat(foo,bar);
   FI
   if (wishbook[unit->type].range>0) {
      sprintf(bar,"  fuel:%ld/%ld",unit->fuel,wishbook[unit->type].range);
      strcat(foo,bar);
   FI
   if (unit->type==TRANSPORT || unit->type==CARRIER) {
      sprintf(bar,"  cargo:%ld/%ld",unit->cargo,(unit->type==TRANSPORT)?6:8);
      strcat(foo,bar);
   FI
   if (unit->orders)
      switch (unit->orders->type) {
         case ORDER_LOAD:
            strcat(foo,"   orders: Load Ship");
            break;
         case ORDER_SENTRY:
            strcat(foo,"   orders: Sentry Duty");
            break;
         case ORDER_FORTIFY:
            strcat(foo,"   orders: Dig In");
            break;
         case ORDER_UNLOAD:
           strcat(foo,"   status: Unloading Units");
           break;
         case ORDER_FORTIFIED:
           strcat(foo,"   status: In Fortified Position");
           break;
         case ORDER_GOTO:
           if( !unit->orders->dest_unit ) {
             if( unit->orders->etc >= 0 ) {
                strcat(foo,"   orders: Goto Hex: ");
                sprintf(foo2, "%ld, %ld", unit->orders->destx,
                     unit->orders->desty);
                strcat(foo, foo2);
             }
             else {
                strcat(foo,"   orders: Patrol Between: ");
                sprintf(foo2, "%ld, %ld and %ld, %ld",
                    unit->orders->destx, unit->orders->desty,
                    unit->orders->orgx, unit->orders->orgy);
                strcat(foo, foo2);
             }
           }
           else {
             strcat(foo,"   orders: Rendevous with Ship: ");
             if( AI3_AssertUnit( unit->orders->dest_unit ) )
                strcat(foo, unit->orders->dest_unit->name);
           }
           break;
      } // end switch

   strncpy(win_title,foo,79L);
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);

   // now do the unit movement bar
   {
      int barleft, barright;
      int bartop, barbottom, barheight;
      int amplitude, ctr;

      InstallClipRegion(map_window->WLayer,bar_region);
      SetRast(rast_port,BLACK);

      // preliminary calculations before I do the graphics
      bartop = map_window->BorderTop+4;
      barbottom = map_window->Height-map_window->BorderBottom-15;
      barleft = map_window->BorderLeft+4;
      barright = barleft+5;
      barheight = barbottom-bartop+1;
      amplitude = (unit->move*barheight)/wishbook[unit->type].speed;

      // draw the green color bar
      SetAPen(rast_port,GREEN);
      if (wishbook[unit->type].range>0) // i.e. an aircraft
         SetAPen(rast_port,LT_BLUE);
      if (wishbook[unit->type].ship_flag)
         SetAPen(rast_port,DK_BLUE);

      RectFill(rast_port,barleft,barbottom-amplitude,barright,barbottom);

      // draw the graduation markers
      SetAPen(rast_port,WHITE);
      for (ctr=0; ctr<=wishbook[unit->type].speed; ctr+=60) {
            amplitude = (ctr*barheight)/wishbook[unit->type].speed;
            Move(rast_port,barleft,barbottom-amplitude);
            Draw(rast_port,barright,barbottom-amplitude);
      OD

      InstallClipRegion(map_window->WLayer,map_region);
   }
}


void hex_status_bar(col,row)
int col, row;
{
   struct Unit *unit;
   struct MapIcon *icon;
   struct City *metro;
   // static char *terrain[]={
   //   "Unexplored Area",
   //   "Forbidden",
   //   "Plains",
   //   "Desert",
   //   "Scrubland",
   //   "Forest",
   //   "Jungle",
   //   "Rough Country",
   //   "Hills",
   //   "Mountains",
   //   "Mountain Peaks",
   //   "Swamp",
   //   "Shallow Waters",
   //   "Ocean",
   //   "Deep Ocean",
   //   "Pack Ice"
   //};

   clear_movebar();
   // look for a city
   if (metro=city_hereP(col,row)) {
      strncpy(win_title,metro->name,79L);
      SetWindowTitles(map_window,win_title,(UBYTE *)~0);
      return;
   FI
   // look for FRIENDLY units (units on ships dont count)
   for (unit = (struct Unit *)unit_list.mlh_Head; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
      if (unit->col==col && unit->row==row)
         if (unit->owner==player && unit->ship==NULL) {
            // unit belongs to me; let unit_status_bar() handle it
            unit_status_bar(unit);
            return;
         FI
   // look for HOSTILE units
   for (icon=(struct MapIcon *)PLAYER.icons.mlh_Head;icon->inode.mln_Succ;icon=(struct MapIcon *)icon->inode.mln_Succ)
      if (icon->col==col && icon->row==row && icon->owner!=player) {
         sprintf(foo,"HOSTILE: %s's %s",roster[icon->owner].name,wishbook[icon->type].name);
         strncpy(win_title,foo,79L);
         SetWindowTitles(map_window,win_title,(UBYTE *)~0);
         return;
      FI

   strncpy(win_title,terrain_name_table[get(PLAYER.map,col,row)],79L);
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
}


/*
   unit "cargo" is attempting to load onto a transport or carrier at this
   location; note that there may be multiple ships in this hex; we must
   try to find one that can accept the unit
   The return value is TRUE if a suitable ship was found.  This does not
   mean the ship was actually boarded, because it may have been full.
   The calling function should check the cargo->ship value to find out.
*/

BOOL board_ship(cargo,col,row)
struct Unit *cargo;
int col, row;
{
   struct Unit *ship=NULL;
   int shiptype=NULL;
   BOOL result = FALSE;
   int weight=cargo_weight(cargo->type);

   // determine what kind of ship we need to look for: TRANSPORT for ground
   // units, or CARRIER for aircraft
   switch (cargo->type) {
      case ARMOR:
      case RIFLE:
         shiptype=TRANSPORT;
         break;
      case FIGHTER:
//      case BOMBER:
//      case AIRCAV:
         shiptype=CARRIER;
         break;
      default:
         return result;
   };

   /*
      search for ships of the appropriate type in this hex
      we don't need to check who they belong to, the hex must be friendly
      or this function wouldn't have been called (I hope!)
   */
   ship=(struct Unit *)unit_list.mlh_Head;
   for (; ship->unode.mln_Succ; ship=(struct Unit *)ship->unode.mln_Succ)
      if (ship->type==shiptype && ship->col==col && ship->row==row) {
         result = TRUE;
         // see if there is room on the ship to accept this unit
         if (weight<=cargo_capacity(ship)-ship->weight) {
            ship->cargo++;     // take up a cargo slot on the ship
            ship->weight += weight;
            cargo->ship=ship;  /* set the cargo unit's new location */
            cargo->col=ship->col;   cargo->row=ship->row;
            cargo->move=0;     /* cargo unit's movement this turn is expended */
            if (shiptype==TRANSPORT)
               give_orders(cargo,ORDER_SENTRY,0,0,-1);   // auto-sentry them
            if (shiptype==CARRIER)
               cargo->fuel = wishbook[cargo->type].range;  // refuel aircraft
            control_flag=UNIT_DONE;    // so that movement_mode() will know
            // if this ship is under orders to load units and is now full,
            // then we should clear the orders for it, like so...
            if (ship->orders)
               if (ship->orders->type==ORDER_LOAD && ship->weight>=cargo_capacity(ship))
                  clear_orders(ship);
            explore_at_hex(player,col,row,VISIBLE,FALSE);   // update map
            return result;
         FI
      FI
   return result;
}


/*
   This function determines the cargo capacity of a ship.  It returns the
   maximum number of units the ship can carry in its current condition
   (taking damage into account), NOT the amount of free space on the ship.

   Depending on the value you want, use the formulas:
      free_space=cargo_capacity(ship)-ship->cargo;
   or
      free_space=cargo_capacity(ship)-ship->weight;  // taking heavy armor into account

   The function also returns a -1 if the unit specified is not a cargo vessel,
   so it can be used to quickly check that as well.
*/
int cargo_capacity(ship)
struct Unit *ship;
{
   int capacity;

   switch (ship->type) {
      case TRANSPORT:
         capacity = 6;
         break;
      case CARRIER:
         capacity = 8;
         break;
      default:
         return -1;
   }
   capacity -= ship->damage*2;   // each hit reduces capacity by two units
   return capacity;
}


/*
   This function returns the weight (for loading/unloading purposes) of a given
   type of cargo.  It appears simple to the point of redundancy right now, but it
   could easily become more complex as the stacking & transporting rules are
   tinkered with.
*/

int cargo_weight(type)
int type;
{
   int weight;

   switch (type) {
      case RIFLE:
      case FIGHTER:
         weight = 1;
         break;
      case ARMOR:
         weight = 2;
         break;
      default:
         weight = 100;  // an impossibly high value
   }
   return weight;
}


/*
   When a ship has been given ORDER_LOAD, it should be referred here.  This
   function will search for loadable cargo units in the same hex (as in a
   city, for example) or in surrounding hexes and attempt to load them on
   the ship.     When  the  ship  is  filled,  load_ship()  will  clear  its
   orders.  Until that happens, however, load_ship() should be called every
   turn for it.
*/

void load_ship(ship)
struct Unit *ship;
{
   struct Unit *cargo;
   int numhexes = adjacent(ship->col,ship->row);
   int index, access;
   int units_loaded=0, weight;
   BOOL valid_cargo;

   if (cargo_capacity(ship)<0)
      return;    // not a cargo vessel
   if (ship->cargo>=cargo_capacity(ship) || ship->weight>=cargo_capacity(ship)) {
      clear_orders(ship);  // ship already full; clear orders
      return;
   }

   // this gives me an index of all hexes I can load units from
   hexlist[numhexes++].col = ship->col;
   hexlist[numhexes++].row = ship->row;
   cargo = (struct Unit *)unit_list.mlh_Head;
   for (;cargo->unode.mln_Succ;cargo=(struct Unit *)cargo->unode.mln_Succ)
      if (unit_readiness(cargo)&UNIT_READY) {
         // search to see if its in an accessible hex
         access = FALSE;
         for (index=numhexes;index>=0;index--)
            if (cargo->col==hexlist[index].col && cargo->row==hexlist[index].row)
               access = TRUE;
         if (access==FALSE)
            continue;   // too far away; try next unit
         if (cargo->ship)
            continue;   // unit is already on a ship!
         // try to determine whether this is the right kind of cargo
         if (ship->type==TRANSPORT)
            valid_cargo = (cargo->type==RIFLE || cargo->type==ARMOR);
         else
            valid_cargo = (cargo->type==FIGHTER);  // only fighters in v0.14+
//            valid_cargo = (wishbook[cargo->type].range>0);

         // see if armor is too heavy
         weight = cargo_weight(cargo->type);
         if (cargo_capacity(ship)-ship->weight < weight)
            valid_cargo = FALSE;

         if (valid_cargo) {
            units_loaded++;
            clear_orders(cargo);
            cargo->move = 0;  // loading expends movement
            cargo->ship = ship;
            cargo->col = ship->col;
            cargo->row = ship->row;
            if (ship->type==TRANSPORT)
               give_orders(cargo,ORDER_SENTRY,0,0,-1);
            ship->cargo++;
            ship->weight += weight;

            if (ship->cargo>=cargo_capacity(ship) || ship->weight>=cargo_capacity(ship)) {
               clear_orders(ship);
               break;
            FI
         FI
      FI
   if (units_loaded>0) {
      if (PLAYER.show&SHOW_GRP)
         explore_at_hex(player,ship->col,ship->row,VISIBLE,FALSE);
      if (PLAYER.show&SHOW_REQ) {
         sprintf(foo,"Your %s %s has taken on board %ld units.",
            wishbook[ship->type].name, ship->name, units_loaded);
         if (ship->cargo>=cargo_capacity(ship)) {
            sprintf(bar,"\nThe ship is now fully loaded.");
            strcat(foo,bar);
         FI
         (void)rtEZRequestTags(foo,"Okay",NULL,NULL,
            RT_Window,        map_window,
            RT_ReqPos,        REQPOS_CENTERSCR,
            RT_LockWindow,    TRUE,
            RTEZ_Flags,       EZREQF_CENTERTEXT,
            TAG_DONE );
      FI
   FI
}



/* When a unit has been given the GOTO order it will move
   towards the hex recorded in it's orders, clear it's
   orders if it hits any impediment (move result = -1),
   check when it reaches it's destination, and turn
   around and head back if it is doing a PATROL order.
   Of course it may have died moving, so we need to do all
   checks at the beginning of the routine.
   */
void  do_goto( struct Unit* unit )
{
    int    result;
    char   foo[128];

    if( unit->orders->dest_unit ) {
        if( !AI3_AssertUnit( unit->orders->dest_unit ) ) {
              clear_orders( unit );
              return;
        }
        AI5_CalcPath( unit->type, unit->col, unit->row,
            unit->orders->dest_unit->col,
            unit->orders->dest_unit->row, AI5_PATH_GOOD );
	    // Check our fuel supply
	    if( (wishbook[unit->type].range > 0) && (unit->fuel < PathLength) ) {
	      clear_orders( unit );
	      return;
        }
    }
    else {
        AI5_CalcPath( unit->type, unit->col, unit->row,
            unit->orders->destx, unit->orders->desty, AI5_PATH_GOOD );
	    // Check our fuel supply
	    if( (wishbook[unit->type].range > 0) && (unit->fuel < PathLength) ) {
	      clear_orders( unit );
	      return;
        }
    }
    if( Path[0] == -1 ) {
        // No path! Or we got there already.
        clear_orders( unit );
        return;
    }
    else {
        while( (unit->move > 0) && (unit->orders) && (Path[0] != -1) ) {
            result = move_unit_dir( unit, Path[0] );
            // Check if we couldn't move, missed a chance, attacked a unit
            //   or city, etc.
            if( result <= -1 ) return;
            // Else we did move and nothing bad happened, so let's look.
            if( unit->orders ) {
                if( !unit->orders->dest_unit ) {
                    if( (unit->col == unit->orders->destx) &&
                        (unit->row == unit->orders->desty) ) {
                        // We reached a destination
                        if( unit->orders->etc >= 0 ) {
                            // Simple GOTO
                            clear_orders( unit );
                            return;
                        }
                        else {
                            // Patrol order - swap 'em.
                            short temp = unit->orders->destx;
                            unit->orders->destx = unit->orders->orgx;
                            unit->orders->orgx = temp;
                            temp = unit->orders->desty;
                            unit->orders->desty = unit->orders->orgy;
                            unit->orders->orgy = temp;
                            //return;
			    // Calculate a new path BACK.
			    AI5_CalcPath( unit->type, unit->col, unit->row,
					  unit->orders->destx, 
					  unit->orders->desty, AI5_PATH_GOOD );
                        }
                    } // End if we arrived
		            else {
		                // Create a new path for the next loop
		                AI5_CalcPath( unit->type, unit->col, unit->row,
			                unit->orders->destx, 
			                unit->orders->desty, AI5_PATH_GOOD );
			            // Check our fuel supply
			            if( (wishbook[unit->type].range > 0) && 
			                (unit->fuel < PathLength) ) {
			                clear_orders( unit );
			                return;
			            }
				        // Check our path, see if it got longer
				        if( unit->orders->etc > 0 ) {
				            unit->orders->etc--;
				            if( PathLength - unit->orders->etc > 3 ) {
					            // we have a major obstacle
					            if( unit->name ) {
					                sprintf 
					                    (foo, 
                					     "Major obstacle detected for %s %s\nmoving from %ld to %ld",
				                	     UnitString[unit->type],
                					     unit->name,
				                	     unit->col, unit->row,
                					     unit->orders->destx,
				                	     unit->orders->desty);
            					} // End if unit->name
            					else {
			                		sprintf 
                					    (foo, 
				                	     "Major obstacle detected for %s\nmoving from %ld to %ld",
                					     UnitString[unit->type],
				                	     unit->col, unit->row,
                					     unit->orders->destx,
				                	     unit->orders->desty);
            					} // End else no unit->name
            					if( rtEZRequestTags
			            		    (foo,
					                 "Clear Orders|Continue Anyway",
            					     NULL,NULL,
			            		     RT_Window,     map_window,
					                 RT_ReqPos,     REQPOS_CENTERSCR,
            					     RT_LockWindow, TRUE,
			            		     RTEZ_Flags,    EZREQF_CENTERTEXT,
					                 TAG_DONE ) ) {
                					    clear_orders( unit );
				                } // End if user wants to clear orders
				            } // End if major obstacle
		                } // End if unit->orders->etc >=0
                    } // End else we have not yet arrived
                } // End if not a goto-unit
		        else {
		            if( AI3_AssertUnit( unit->orders->dest_unit ) ) {
		                // check for reaching our destination unit
		                if( (unit->col == unit->orders->dest_unit->col) &&
			                (unit->row == unit->orders->dest_unit->row) ) {
			                clear_orders(unit);
			                return;
		                }
		                else {
			                // Create a new path for the next loop
			                AI5_CalcPath( unit->type, unit->col, unit->row,
			                    unit->orders->dest_unit->col,
			                    unit->orders->dest_unit->row, 
			                    AI5_PATH_GOOD );
			                // Check our fuel supply
			                if( (wishbook[unit->type].range > 0) && 
			                    (unit->fuel < PathLength) ) {
			                    clear_orders( unit );
			                    return;
			                }
					        // Check our path, see if it got longer
        					if( unit->orders->etc > 0 ) {
		            			unit->orders->etc--;
        					    if( PathLength - unit->orders->etc > 3 ) {
            					    // we have a major obstacle
			            		    if( unit->name ) {
					                  sprintf 
                						(foo, 
				                		 "Major obstacle detected for %s %s\nmoving from %ld to %ld",
                						 UnitString[unit->type],
				                		 unit->name,
                						 unit->col, unit->row,
				                		 unit->orders->destx,
                						 unit->orders->desty);
				            	    } // End if unit->name
            					    else {
			            		      sprintf 
						                (foo, 
                						 "Major obstacle detected for %s\nmoving from %ld to %ld",
				                		 UnitString[unit->type],
                						 unit->col, unit->row,
				                		 unit->orders->destx,
                						 unit->orders->desty);
				            	    } // End else no unit->name
            					    if( rtEZRequestTags
			            			    (foo,
    						             "Clear Orders|Continue Anyway",
                						 NULL,NULL,
		    	            			 RT_Window,     map_window,
			    			             RT_ReqPos,     REQPOS_CENTERSCR,
            	    					 RT_LockWindow, TRUE,
			                			 RTEZ_Flags,    EZREQF_CENTERTEXT,
						                 TAG_DONE ) ) {
                    					      clear_orders( unit );
					                }
					            } // End if major obstacle
                            } // end if unit->orders->etc >= 0
			            } // End else we did not reach our destination unit
		            }// end if we still HAVE a destination unit
		        } // end else we are trying to reach a unit not a location
            } // End if we still have orders
        }// end while
    } // end else we have a path.
    return;
}

// this is where a unit is moving on the map, checking all the movment
// rules, possible combat and such as we go

int move_unit_dir(unit,dir)
struct Unit *unit;
enum Direction dir;
{
   int targx = unit->col, targy = unit->row;

   switch (dir) {
      case EAST:
         targx++;
         break;
      case WEST:
         targx--;
         break;
      case NORTHEAST:
         targy--;
         if (unit->row%2) // odd number
            targx++;
         break;
      case NORTHWEST:
         targy--;
         if (!(unit->row%2)) // even number
            targx--;
         break;
      case SOUTHEAST:
         targy++;
         if (unit->row%2) // odd number
            targx++;
         break;
      case SOUTHWEST:
         targy++;
         if (!(unit->row%2)) // even number
            targx--;
         break;
      default:
         return (-8);
   }
   return (move_unit_xy(unit,targx,targy));
}


int move_unit_xy(unit,targx,targy)
struct Unit *unit;
int targx, targy;
{
        //BSH
        // This routine will now return integer values for results
        //              -6 - Attack on City (successful - but still lose unit)
        //              -5 - Attack on City (failed)
        //              -4 - Attack on enemy unit(s) (failed)
        //              -3 - Unit ran out of fuel and crashed
        //              -2 - Unit failed to move this turn (missed chance)
        //              -1 - Unit cannot move to target hex
        //              0 - Move occurred
        //              1 - Moved - Attacked enemy unit(s) (won)
        //              2 - Moved - Overflew carrier
        //              3 - Moved - Boarded ship
        //              4 - Unit moved, but unit(s) on board were lost
        // To use the unit over again, check for return > -3

   BOOL cargo_killed=FALSE;
   int terrain, movement_cost=(-1);
   struct City *city=city_hereP(targx,targy);  // so I don't call it over and over

   // correct values for wrap, if it's active
   if (wrap) {
      if (targx<0)
         targx += width;
      if (targx>=width)
         targx -= width;
      if (targy<0)
         targy += height;
      if (targy>=height)
         targy -= height;
   }

   /* he certainly can't move off the map! */
   //  *************  Adding disable for non-users ***************
   if (targx<0 || targx>=width || targy<0 || targy>=height) {
      if (PLAYER.show & SHOW_REQ)
         tell_user2("You cannot move off the map.",FALSE,DONK_SOUND);
      return (-1);
   FI

   /***
      Now I want to branch out.  I already know the user is trying to move
      a unit onto another hex.  I need to analyze the contents of that hex
      and see if he is attacking a city, attacking an enemy unit, boarding
      a ship, or just maneuvering normally.  I will branch out to various
      functions for each of these cases, except maneuvering which I can
      handle here.
   ***/

   // check for a destination city
   if (city)
      if (city->owner==player)  /* it's his own city */
         goto normal_movement;
   else {
      // if this unit can attack a city
      attack_hex(unit,targx,targy);  // attacking another city
      if ((unit->type == ARMOR) || (unit->type == RIFLE) || (unit->type == AIRCAV) || (unit->type == BOMBER)) {
         if (hex_owner(targx, targy)!=player)
            return -5;
         else
            return -6;
      } else
         return -1;
   }

   // check for hostile military units to attack
   {
      struct Unit *target = (struct Unit *)unit_list.mlh_Head;
      for (; target->unode.mln_Succ; target=(struct Unit *)target->unode.mln_Succ)
         if (target->col==targx && target->row==targy && target->owner!=player) {
            attack_hex(unit,targx,targy);
            if (hex_owner(targx, targy)!=player)
               return (-4);
            else
               return 1;
         FI
   }

   // check for friendly ship to board
   if (board_ship(unit,targx,targy)) {
      if (unit->ship==NULL) {    /* i.e. if unit failed to board the ship */
    /* if it's an aircraft, ask if they want to overfly the hex anyhow */
         if (wishbook[unit->type].range>0) {
            int choice;
            // If we have a human, ask him
            if (PLAYER.show & SHOW_REQ) {
                if(PLAYER.soundfx == SOUND_ALL)
                     playSound(DONK_SOUND,PLAYER.snd_vol);
                choice = rtEZRequestTags(\
                        "The carrier cannot accept your unit.\nDo you wish to overfly it?",
                        "Overfly|Abort", NULL, NULL,
                        RT_Window,        map_window,
                        RT_ReqPos,        REQPOS_CENTERSCR,
                        RT_LockWindow,    TRUE,
                        RT_ShareIDCMP,    TRUE,
                        RTEZ_Flags,       EZREQF_CENTERTEXT,
                        TAG_DONE );
            }
            // Otherwise, just do the overfly
                else  choice = 1;
            if (choice==0)  return (-1);
         } else {
                if (PLAYER.show & SHOW_REQ)
                tell_user2("No ship in that hex can accept your troops.",FALSE,DONK_SOUND);
            return (-1);
         FI
      } else   // unit successfully boarded the ship
         return (3);
   FI

 normal_movement:
   // check to see if stacking rules allow him to enter this hex
   if (opt.stacking==FALSE && city==NULL) {
      BOOL valid = TRUE;
      struct Unit *target = (struct Unit *)unit_list.mlh_Head;

      for (; target->unode.mln_Succ; target=(struct Unit *)target->unode.mln_Succ)
         if (target->col==targx && target->row==targy) {
            int weight=cargo_weight(unit->type);

            valid = FALSE;

            if (unit->type==ARMOR || unit->type==RIFLE)
               if (target->type==TRANSPORT && target->weight<=(cargo_capacity(target)-weight)) {
                  valid = TRUE;
                  break;
               FI
            if (wishbook[unit->type].range>0)   // aircraft
               if (target->type==CARRIER && target->weight<(cargo_capacity(target)-weight)) {
                  valid = TRUE;
                  break;
               FI
         FI
      if (valid==FALSE) {   // cannot enter this hex
         if (PLAYER.show & SHOW_REQ)
                tell_user2("Your unit cannot stack in that hex.",FALSE,DONK_SOUND);
         return (-1);
      FI
   FI

   terrain = get(t_grid,targx,targy);
   movement_cost = movement_cost_table[unit->type][terrain];

   if (city)
      movement_cost = 10;  // always easy to enter a friendly city!

   // is he on the road?
   if (unit->type==RIFLE || unit->type==ARMOR)
      if (get_flags(t_grid,unit->col,unit->row)&get_flags(t_grid,targx,targy)&ROAD)
         movement_cost = 30;

   if (terrain==HEX_FORBID) { /* Just in case a road is here! *ELS* */
      if (PLAYER.show & SHOW_REQ)
        tell_user2("Your unit cannot traverse that kind of terrain.",FALSE,DONK_SOUND);
      return (-1);
   FI

   if (movement_cost<0) { /* it must be a terrain this unit can't traverse */
      if (PLAYER.show & SHOW_REQ)
        tell_user2("Your unit cannot traverse that kind of terrain.",FALSE,DONK_SOUND);
      return (-1);
   FI

   if (city)
      movement_cost = 10;  // yes, even if there is a road here

   if (unit->ship)
      movement_cost = 60;  // this is always true when unloading from a ship

   /* if a unit's remaining movement points drop to 10 or less (which is 1/6 of
   ** a "standard" one hex move, then I round it down to zero; this is also the
   ** minimum for attacking, loading onto ships, entering cities, etc.
   */
   if (movement_cost<unit->move) {   // he definitely has enough movement for this
      unit->move -= movement_cost;
      if (unit->move<10) {
         unit->move = 0;
         control_flag = UNIT_DONE;
      FI
   } else {    // he only has enough movement for a /chance/ at this
      int chance = unit->move;

      unit->move = 0;
      control_flag = UNIT_DONE;
      if (RangeRand(movement_cost)>chance) {
        //BSH
         if (PLAYER.soundfx == SOUND_ALL)
                 playSound(SMASH_SOUND,PLAYER.snd_vol);
         return (-2);     // his movement attempt failed
      FI
   FI

   // follow him with scrolling, if necessary
   //BSH
   if (PLAYER.show & SHOW_GRP) {
      if (need_to_scrollP(targx,targy)) {
         int ox = xoffs, oy = yoffs;

         set_display_offsets(targx,targy);
         GP_smart_scroll(ox,oy);
      FI
      // animated movement
      anim_move(unit,unit->col,unit->row,targx,targy);
   FI

   // move the unit
   unit->col = targx;
   unit->row = targy;
   if (unit->ship) {     // he must be unloading from a ship
      unit->ship->cargo--;
      unit->ship->weight -= cargo_weight(unit->type);
      if (unit->ship->type==TRANSPORT) {
         unit->move = 0;   // unloading from a transport expends movement
         control_flag = UNIT_DONE;
      FI
      unit->ship=NULL;  // so we unlink him from it
   FI
   if (unit->cargo>0) {   // ship moves, cargo moves
      int ctr, capacity, num_hexes=adjacent(targx,targy);
      struct Unit *cargo;     BOOL unsentry=FALSE;

      /*
         If the ship has been damaged, it may no longer be able to carry all
         the troops or aircraft on board it.  If that is the case, here is
         where we kill off the extra ones, when the ship moves.  Of course,
         they can survive if the ship has just moved into a city!
      */
      capacity = 6;
      if (unit->type==CARRIER)
         capacity = 8;
      capacity -= unit->damage*2;
      /*
         kill units until capacity == cargo
         multiple searches may be required because the destruction of units
         messes up the list structure
      */
      ctr = 0;
      while (unit->cargo>capacity)
         for (cargo=(struct Unit *)unit_list.mlh_Head;cargo->unode.mln_Succ;cargo=(struct Unit *)cargo->unode.mln_Succ)
            if (cargo->ship==unit) {
               unit->cargo--;
               if (city)   // cargo is merely unloaded into the city
                  cargo->ship = NULL;
               else {      // cargo is lost at sea
                  ctr++;
                  Remove((struct Node *)cargo);
                  destruct_unit(cargo);
                  break;
               FI
            FI
      if (ctr) {
         cargo_killed = TRUE;
         if (PLAYER.show & SHOW_REQ) {
            // I must tell the user the bad news!  Number of units lost == ctr.
            sprintf(foo,"Because of battle damage, the ship is overloaded.\nYou lost %ld cargo to the sea!",ctr);
            (void)rtEZRequestTags(foo,
               "Drat!",NULL,NULL,
               RT_Window,        map_window,
               RT_ReqPos,        REQPOS_CENTERSCR,
               RT_LockWindow,    TRUE,
               RTEZ_Flags,       EZREQF_CENTERTEXT,
               TAG_DONE );
         FI
      FI

      /*
         Find out if there is a hostile unit or city, or neutral city
         in a hex adjacent to this one; if so, un-sentry RIFLE, ARMOR or AIRCAV.
         The "unsentry" flag will determine this.
      */
      for (ctr=0; ctr<num_hexes; ctr++) {
         int owner=hex_owner(hexlist[ctr].col,hexlist[ctr].row);
         struct City *metro=city_hereP(hexlist[ctr].col,hexlist[ctr].row);

         if (owner>0 && owner!=player)
            unsentry=TRUE;
         if (metro)     // check for neutral cities
            if (metro->owner!=player)
               unsentry=TRUE;
      OD
      for (cargo=(struct Unit *)unit_list.mlh_Head;cargo->unode.mln_Succ;cargo=(struct Unit *)cargo->unode.mln_Succ)
         if (cargo->ship==unit) {
            cargo->col=targx;    cargo->row=targy;
            if (unsentry)
               switch (cargo->type) {
                  case RIFLE:
                  case ARMOR:
                  case AIRCAV:
                     clear_orders(cargo);
               }
         FI
   FI
   // units entering into cities get repaired
   if (city) {
      if (unit->damage>0)
         unit->damage--;
      unit->move = 0;
      control_flag = UNIT_DONE;
   FI
   if (wishbook[unit->type].range>0) {   // units that need fuel, i.e. aircraft
      if( unit->ship == NULL ) unit->fuel--; // Added this if statement here,
      //  was just unit->fuel--, trying to fix bug where aircraft on carrier
      // lose fuel as carrier moves.
      if (city) {  // refuel
         unit->fuel = wishbook[unit->type].range;
         unit->move = 0;  /* after entering a city, the plane's turn is over */
         control_flag = UNIT_DONE;
      FI
      if (unit->fuel<=0) {
         // aircraft out of fuel, crashes!
         if (PLAYER.show & SHOW_REQ) {
            plot_mapobject(targx,targy,154,30);    // draw explosion
            context_sound(BOOM_SOUND);              // kaboomy!
            // now tell the player the awful news
            sprintf(foo,"Your %s has run out of fuel and crashed!",wishbook[unit->type].name);
            (void)rtEZRequestTags(foo,"Oh no!",NULL,NULL,
               RT_Window,     map_window,
               RT_ReqPos,     REQPOS_CENTERWIN,
               RT_LockWindow, TRUE,
               TAG_DONE);
         FI
         Remove((struct Node *)unit);           // kill the plane
         roster[unit->owner].ulc[unit->type]++;
         control_flag = UNIT_LOST;
         destruct_unit(unit);
         if (PLAYER.show & SHOW_GRP)
            explore_at_hex(player,targx,targy,VISIBLE,FALSE);
         else
            explore_at_hex(player,targx,targy,INVISIBLE,FALSE);
         return (-3);
      FI
   FI
   if (PLAYER.show & SHOW_GRP) {
      unit_status_bar(unit);
      explore_at_hex(player,targx,targy,VISIBLE,FALSE);
   } else {
      explore_at_hex(player,targx,targy,INVISIBLE,FALSE);
   FI
   if (cargo_killed==TRUE)
      return (4);
   return (0);
}


void build_move_menu()
{  // prepare the movement-mode menu for use
   struct NewMenu new_menu_strip[]  = {
      { NM_TITLE, "Project", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Save Game", "S", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Save As...", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Exit Game", "X", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Quit Program", "Q", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Reports", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "World Map", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Status", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Combat Report", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Unit Info", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Production Map", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Ship Report", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Advisor's Recommendation", "Z", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Orders", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Go Home       H", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Go Direction  *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Go Random     *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Move To       *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Patrol To     *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Sentry        S", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Clear Orders  O", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Load Ship     L", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Unload Ship   U", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Skip Move [SPC]", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Escort Ship   *", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Commands", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Survey Mode    V", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Wait           W", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Cycle Stack    5", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Flight Paths   *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Center Screen  C", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Other", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Prefs", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Commanders", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "View", NULL, ITEMTEXT, NULL, NULL },
      { NM_END, NULL, NULL, NULL, NULL, NULL }
   };
   if (!(move_menu_strip = CreateMenus(new_menu_strip,GTMN_FrontPen,BLACK,TAG_END)))
      clean_exit(1,"ERROR: Unable to create menu strip for movement mode!");
   if (!(LayoutMenus(move_menu_strip,vi,TAG_END)))
      clean_exit(1,"ERROR: Unable to layout movement menus!");
}


void build_survey_menu()
{  // prepare the survey-mode menu for use
   struct NewMenu new_menu_strip[]  = {
      { NM_TITLE, "Project", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Save Game", "S", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Save As...", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Exit Game", "X", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Quit Program", "Q", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Reports", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "World Map", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Status", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Combat Report", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Hex Info", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Production Map", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Ship Report", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Orders", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Clear Orders  O", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Cycle Stack   5", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Activate      A", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Commands", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Move Mode      M", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Group Survey   *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Flight Paths   *", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Center Screen  C", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Other", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Prefs", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Commanders", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "View", NULL, ITEMTEXT, NULL, NULL },
      { NM_END, NULL, NULL, NULL, NULL, NULL }
   };
   if (!(vey_menu_strip = CreateMenus(new_menu_strip,GTMN_FrontPen,BLACK,TAG_END)))
      clean_exit(1,"ERROR: Unable to create menu strip for survey mode!");
   if (!(LayoutMenus(vey_menu_strip,vi,TAG_END)))
      clean_exit(1,"ERROR: Unable to layout survey menus!");
}


void build_production_menu()
{  // prepare the production-mode menu for use
   struct NewMenu new_menu_strip[]  = {
      { NM_TITLE, "Project", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Save Game", "S", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Save As...", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Exit Game", "X", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Quit Program", "Q", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Reports", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "World Map", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Status", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Ship Report", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Commands", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Examine City [Enter]", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Move Mode      M", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Survey Mode        V", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Center Screen  C", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Other", NULL, NM_MENUDISABLED, NULL, NULL },
      { NM_ITEM, "Prefs", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Commanders", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "View", NULL, ITEMTEXT, NULL, NULL },
      { NM_END, NULL, NULL, NULL, NULL, NULL }
   };
   if (!(prod_menu_strip = CreateMenus(new_menu_strip,GTMN_FrontPen,BLACK,TAG_END)))
      clean_exit(1,"ERROR: Unable to create menu strip for production mode!");
   if (!(LayoutMenus(prod_menu_strip,vi,TAG_END)))
      clean_exit(1,"ERROR: Unable to layout production menus!");
}


/*
   Give orders to a unit.  Note that some of these values (namely destx, desty
   and etc) may be set by the calling function or may be set by give_orders(),
   depending on the specifics of the order being given.
   This function does NOT actually process the order, but leaves that to the
   order manager to take care of later.
*/

void give_orders(unit,token,destx,desty,etc)
struct Unit *unit;
int token, destx, desty, etc;
{
   struct Order *order=AllocVec((long)sizeof(*order),MEMF_CLEAR);
   struct City* metro = (struct City *)city_list.mlh_Head;
   struct City* closest = NULL;
   struct Unit* lookunit = (struct Unit *)unit_list.mlh_Head;
   struct Unit* nearest = NULL;
   char   askstring[80];

   clear_orders(unit);
   if (order) {
      unit->orders = order;
      order->type = token;
      order->orgx = unit->col;
      order->orgy = unit->row;
      order->processed = FALSE;
      switch (token) {
         case ORDER_SENTRY:
         case ORDER_LOAD:
            order->destx = unit->col;
            order->desty = unit->row;
            order->etc = -1;
            break;
         case ORDER_GOTO:
            // Check for an aircraft and a possible target carrier
    	    // Only FIGHTERS can land on carriers now.
	       if( (unit->type == FIGHTER) //||
	           //(unit->type == BOMBER) ||
    	       //(unit->type == AIRCAV) 
	           ) {
               for (; lookunit->unode.mln_Succ; lookunit =
                 (struct Unit *)lookunit->unode.mln_Succ)
                    if( (lookunit->owner==player) &&
                         (lookunit->type == CARRIER) &&
                        (lookunit->col == destx) &&
                        (lookunit->row == desty) ) {
                        // Ask user if he wants it to land on the carrier
                        sprintf( askstring, "Land aircraft on Carrier %s?",
                            lookunit->name);
                        if (rtEZRequestTags(askstring,"Yes|No",
                            NULL,NULL, RTEZ_Flags,EZREQF_CENTERTEXT,
                            RT_Window,map_window,RT_ReqPos,
                            REQPOS_CENTERWIN,RT_LockWindow,TRUE,TAG_END )) {
                                order->dest_unit = lookunit;
                                order->etc = etc;
                                break;
                        }
                    }
                // End for loop
            }
            order->destx = destx;
            order->desty = desty;
            order->etc = etc;
            break;
         case ORDER_PATROL:
            order->destx = destx;
            order->desty = desty;
            order->etc = -etc;
            order->type = ORDER_GOTO; /* Important - no token for PATROL */
            break;
         case ORDER_HOME:
           /* Need to find the closest city or carrier we can land on */
            for ( ; metro->cnode.mln_Succ; metro =
                (struct City *)metro->cnode.mln_Succ)
                if(metro->owner==player) {
                  if( !closest )  closest = metro;
                  else {
                 if( AI5_GetDist ( unit->col, unit->row,
                            metro->col, metro->row ) < AI5_GetDist
                            (unit->col, unit->row, closest->col,
                            closest->row) )  closest = metro;
                  }
              }
             /* End for */
               /* Verify the vs. our fuel if applicable, then look for a
                carrier. */
                if( (unit->type == FIGHTER) || (unit->type == BOMBER) ||
                  (unit->type == AIRCAV) ) {
                  /* if the city is too far away, forget it */
                  if( (closest) &&( AI5_GetDist
                      (unit->col, unit->row, closest->col, closest->row) >
                      unit->fuel ) )   closest = NULL;
                     /* Look for the closest carrier */
                    for (; lookunit->unode.mln_Succ; lookunit =
                        (struct Unit *)lookunit->unode.mln_Succ)
                        if( (lookunit->owner==player) &&
                           (lookunit->type == CARRIER) ) {
                        if( !nearest )  nearest = lookunit;
                        else {
                            if( AI5_GetDist ( unit->col, unit->row,
                                    lookunit->col, lookunit->row ) <
                                    AI5_GetDist (unit->col, unit->row,
                                    nearest->col, nearest->row) )
                                    nearest = lookunit;
                           }
                      }
                     /* End for */
                     /* Do we have a carrier? If so, is it in range? If not,
                        forget it. */
                     if( (nearest) && (AI5_GetDist
                         (unit->col, unit->row, nearest->col, nearest->row) >
                         unit->fuel ) )    nearest = NULL;
                  /* Any place to land? */
                  if( (nearest == NULL) && (closest == NULL) ) {
                      clear_orders( unit );
                      break;
                  }
                  /* Now, do we have a carrier that is closer? If not, forget
                     it and go with the city. */
                  if( (nearest ) && (closest) ) {
                      if( AI5_GetDist
                     (unit->col, unit->row, nearest->col, nearest->row) >=
                     AI5_GetDist
                     (unit->col, unit->row, closest->col, closest->row) )
                        nearest = NULL;
                  }
               }
               /* Check them for fuel vs. aircraft - no sense heading for
                  someplace we can't reach. */
                //order->etc = etc;
                order->type = ORDER_GOTO;  /* Important - no token for HOME */
               /* Go for the carrier first */
               if( nearest ) {
                  order->dest_unit = nearest;
                  order->etc = AI5_GetDist(unit->col, unit->row,
                    order->dest_unit->col, order->dest_unit->row);
               }
               else {
                  if( closest) {
                      order->destx = closest->col;
                      order->desty = closest->row;
                      order->etc = AI5_GetDist(unit->col, unit->row,
                        order->destx, order->desty);
                  }
                  else {
                      /* Nowhere to go */
                      clear_orders( unit );
                  }
               }
               break;
         }
   }
}


/*
   the purpose of shuffle_units() is to shuffle the current unit in a hex
   to the bottom of the pile, and activate the next valid one beneath it
   parameter is the current top unit; return value is the new top unit
*/
struct Unit *shuffle_units(topunit, survey)
struct Unit *topunit;
BOOL survey;   // indicates whether we are in survey mode
{
   struct Unit *newunit = (struct Unit *)unit_list.mlh_Head;
   int col=topunit->col, row=topunit->row;

   for (; newunit->unode.mln_Succ; newunit=(struct Unit *)newunit->unode.mln_Succ)
      if (newunit->col==col && newunit->row==row && newunit!=topunit)
         if (Bool(unit_readiness(newunit)&UNIT_READY) || survey) {
            // move this unit to the beginning of list
            Remove((struct Node *)newunit);
            AddHead((struct List *)&unit_list,(struct Node *)newunit);
            // move the old unit to the end of the list
            Remove((struct Node *)topunit);
            AddTail((struct List *)&unit_list,(struct Node *)topunit);
            return newunit;
         FI
   return topunit;
}



void start_blinking_unit(unit)
struct Unit *unit;
{  // display the unit to be moved, set up blinking graphics
   int col = unit->col, row = unit->row;
   struct City *metro = (struct City *)city_list.mlh_Head;
   BOOL stacked=(count_units_at(unit->col,unit->row)>1);
   int token;

   // draw in the background terrain
   plot_hex(col,row,get(t_grid,col,row));

   if (get_flags(PLAYER.map,col,row)&ROAD)
      GP_draw_roads(col,row);

   // if there is a city here, draw it
   for ( ; metro->cnode.mln_Succ; metro = (struct City*)metro->cnode.mln_Succ)
      if (metro->col==col && metro->row==row)
         plot_city(col,row,roster[metro->owner].color,FALSE);

   // if the unit is on board a ship, draw the ship as background
   if (unit->ship) {
      token = ORDER_NONE;
      if (unit->ship->orders)
         token=unit->ship->orders->type;
      plot_icon(unit->ship->type,col,row,roster[unit->owner].color,token,TRUE);
   FI

   // store this background in a safe place (buffer 0)
   save_hex_graphics(col,row,0);

   // plot the unit icon
   token = ORDER_NONE;
   if (unit->orders)
      token = unit->orders->type;
   plot_icon(unit->type,col,row,roster[unit->owner].color,token,stacked);

   // just make sure the map icon matches what I'm displaying
   // otherwise things like order tokens might disappear or be wrong
   explore_hex(unit->owner,unit->col,unit->row,INVISIBLE,TRUE);
}


void movement_mode(current_unit)
struct Unit **current_unit;
{
   struct IntuiMessage *message; // the message the IDCMP sends us
   struct Unit *unit = *current_unit;
   unsigned int ticks = 1;
   BOOL blink_on = TRUE;
   BOOL stacked;

   // useful for interpreting IDCMP messages
   UWORD code;
   ULONG class;
   APTR object;

   if (unit)
      stacked = (count_units_at(unit->col,unit->row)>1);

   /*
      If there is no map display, this is the right time to create one.
      but first set COL and ROW to default values, searching for a city
      belonging to the player...
   */
   if (unit==NULL && display==FALSE) {
      struct City *metro=(struct City *)city_list.mlh_Head;
      for (; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ)
         if (metro->owner==player) {
            cursx=metro->col;   cursy=metro->row;
            create_player_display(cursx,cursy);
            break;
         FI
   } else if (unit)
      create_player_display(unit->col,unit->row);

   /*
      If the value "unit" passed to movement_mode() is NULL, this signifies that
      the player has no more units left to move.  So, we must ask him if he wants
      to continue, then dump him back to the mode manager.  If he wants to
      continue, we set GO_SURVEY so he is sent to survey mode.  Otherwise we
      set END_TURN so the manager knows to exit out.
   */
   if (unit==NULL) {
      control_flag = (rtEZRequestTags(\
         "All your units have moved.\nDo you wish to continue?",
         " End Turn |Review Map", NULL, NULL,
         RT_Window,        map_window,
         RT_ReqPos,        REQPOS_CENTERSCR,
         RT_LockWindow,    TRUE,
         RT_ShareIDCMP,    TRUE,
         RTEZ_Flags,       EZREQF_CENTERTEXT,
         TAG_DONE
         )?END_TURN:GO_SURVEY);
      return;
   FI

   if (display==FALSE) {
      set_display_offsets(unit->col,unit->row);
      GP_draw_map();
   } else if (need_to_scrollP(unit->col,unit->row)) {
      int ox=xoffs, oy=yoffs;

      set_display_offsets(unit->col,unit->row);
      GP_smart_scroll(ox,oy);
   FI

   // clear orders
   if (unit->orders) {
      clear_orders(unit);
      GP_update_hex_display(unit->col,unit->row);
   FI

   start_blinking_unit(unit);
   unit_status_bar(unit);

   // activate IDCMP event input
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);

   // attach the menu to my window
   SetMenuStrip(map_window,move_menu_strip);

   // Enable menus
   OnMenu(map_window,FULLMENUNUM(0,NOITEM,0));
   OnMenu(map_window,FULLMENUNUM(1,NOITEM,0));
   OnMenu(map_window,FULLMENUNUM(2,NOITEM,0));
   OnMenu(map_window,FULLMENUNUM(3,NOITEM,0));
   OnMenu(map_window,FULLMENUNUM(4,NOITEM,0));

   control_flag = 0;    // flag lets me know when unit is done

   /*
      This is the most important user input loop of the whole game, where
      I get the movement of the current unit, let the user scroll around,
      select various options from the drop-down menus, etc.
   */

   while (TRUE) {
      WaitPort(map_window->UserPort);
      while (message = GT_GetIMsg(map_window->UserPort)) {
         code = message->Code;  // MENUNUM
         object = message->IAddress;  // Gadget
         class = message->Class;
         GT_ReplyIMsg(message);
         if ( class == MENUPICK ) { // MenuItems
            ClearMenuStrip(map_window);
            switch (MENUNUM(code)) {
               case 0:  // Project menu
                  switch (ITEMNUM(code)) {
                     case 0:  // save game
                        {
                           char pan[216];
                           build_pan(pan,game_filepath,game_filename);
                           save_game(pan);
                        }
                        break;
                     case 1:  // save as...
                        (void)rt_loadsave_game(TRUE);
                        break;
                     case 3:  // exit game
                        if (alert(map_window,"Exit this game.","Are you sure you want to abandon this game now?","Exit|Cancel")) {
                           control_flag = EXIT_GAME;
                           return;
                        FI
                        break;
                     case 4:  // quit program
                        if (alert(map_window,"Exit Invasion Force.","You have a game in progress.\nAre you sure you want to leave Invasion Force now?","Exit|Cancel"))
                           clean_exit(0,NULL);
                        break;
                     default:
                        (void)rtEZRequestTags("That function is not yot implemented.","Drat!",NULL,NULL,
                           RT_DEFAULT,TAG_END);
                  }
                  break;
               case 1:  // Reports menu
                  switch (ITEMNUM(code)) {
                     case 0:  // World Map
                        GP_world_view();
                        break;
                     case 1:  // Status report
                        status_report(player);
                        break;
                     case 2:  // Combat Report
                        restore_hex_graphics(unit->col,unit->row,0);
                        show_combat_report(FALSE);
                        if (need_to_scrollP(unit->col,unit->row)) {
                           int ox=xoffs, oy=yoffs;

                           set_display_offsets(unit->col,unit->row);
                           GP_smart_scroll(ox,oy);
                        FI
                        start_blinking_unit(unit);
                        break;
                     case 4:  // Production Map
                        control_flag = GO_PRODUCTION;
                        break;
           case 6: // Advisor's Recommendation
              class = IDCMP_VANILLAKEY;
              code = 'z';
              break;
                     }
                  break;
               case 2:  // Orders menu
                  switch (ITEMNUM(code)) {
           case 0:  // Home
         class = IDCMP_VANILLAKEY;
              code = 'h';
              break;
                     case 5:  // Sentry
                        class = IDCMP_VANILLAKEY;
                        code = 's';
                        break;
                     case 6:  // Clear Orders
                        class = IDCMP_VANILLAKEY;
                        code = 'o';
                        break;
                   case 7:  // Load Ship
                        class = IDCMP_VANILLAKEY;
                        code = 'l';
                        break;
                     case 8:  // Unload Ship
                        class = IDCMP_VANILLAKEY;
                        code = 'u';
                        break;
                     case 9:  // Skip Move
                        class = IDCMP_VANILLAKEY;
                        code = ' ';
                        break;
                     default:
                        (void)rtEZRequestTags("That function is not yot implemented.","Drat!",NULL,NULL,
                           RT_DEFAULT,TAG_END);
                  }
                  break;
               case 3:  // Commands Menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Survey Mode
                        class = IDCMP_VANILLAKEY;
                        code = 'v';
                        break;
                     case 1:  // Wait
                        class = IDCMP_VANILLAKEY;
                     code = 'w';
                     break;
                     case 2:  // Cycle Stack
                        class = IDCMP_VANILLAKEY;
                        code = '5';
                        break;
                     case 4:  // Center Screen
                        class = IDCMP_VANILLAKEY;
                        code = 'c';
                        break;
                  }
                  break;
               case 4:  // Other Menu
                  if (ITEMNUM(code)==0)
                     player_preferences();
            };
         FI
         // following are key commands available in movement mode
         if (class==IDCMP_VANILLAKEY) {
            switch (code) {
               int direction;
	       case 'q':
		 { // Special function to turn on and off AI information
		   ToggleAIDataFlag();
		   break;
		 }
               case 'z':
                  {  // New Military Advisor function
		            int response1 = 0, response2 = 0;
     		        int recommend = AI5_recommend_action( unit, 40, 60 );
		            if( (recommend >= 0) && (recommend <= 5) ) {
		                sprintf( foo, "Advisor recommends a move %s",
			                    DirString[recommend] );
		                response1 = rtEZRequestTags
                			(foo,"Do it|Show Details|Cancel",
				         NULL,NULL,
	    		             RT_Window,        map_window,
                			 RT_ReqPos,        REQPOS_CENTERSCR,
			                 RT_LockWindow,    TRUE,
            	    		 RTEZ_Flags,       EZREQF_CENTERTEXT,
			                 TAG_DONE ); 
		            } // End if we have a recommendation
        		    else {
		              response2 = rtEZRequestTags
            			("The Advisor has no recommended move for that unit.",
            			 "Show Details|OK",NULL,NULL, RT_DEFAULT,TAG_END);
		            }
            		    if ( response1 == 1) {
                			// Taking the advice.  Let's do it then
                			direction = recommend;
                			goto mm_moving;
            		    }
         		    if ( (response1 == 2) || (response2 == 1) ) {
                			// Go through each hex in turn and give him raw data
                			int index;
                			struct HexReport rep;
                			for( index=0; index<6; index++ ) {
                			    /* Fill in the raw data */
                			    short targx, targy;
                			    if (AI1_calc_dir (index, unit->col, unit->row, 
            					    &targx, &targy) != -1) {
			                        AI5_evaluate_hex( unit, targx, targy, 
                                        &rep );
			                    }
                			    if( rep.CanAttack || rep.AtRisk ) {
                    			    if( unit->name ) {
                    			        sprintf( foo, 
 "%s of %s %s\nAre %ld enemy unit(s) valued at %ld\nThe value of your %ld unit(s) is %ld\nThe odds of winning are %ld  %%", 
                    				      DirString[index], unit->name, 
						                  wishbook[unit->type].name,
						                  rep.TotalEUnits, rep.Gain,
						                  rep.TotalMyUnits, rep.Risk, 
						                  rep.Odds );
						                (void) rtEZRequestTags
						                    (foo,"OK",
						                    NULL,NULL,
						                    RT_Window,      map_window,
						                    RT_ReqPos,      REQPOS_CENTERSCR,
						                    RT_LockWindow,  TRUE,
						                    RTEZ_Flags,     EZREQF_CENTERTEXT,
						                    TAG_DONE );
                    			    }
					                else {
                    			        sprintf( foo, 
 "%s of your %s\nAre %ld enemy unit(s) valued at %ld\nThe value of your %ld unit(s) is %ld\nThe odds of winning are %ld %%", 
                    				      DirString[index], 
						                  wishbook[unit->type].name,
						                  rep.TotalEUnits, rep.Gain,
						                  rep.TotalMyUnits, rep.Risk, 
						                  rep.Odds );
						                (void) rtEZRequestTags
						                    (foo,"OK",
                    					    NULL,NULL,
                						   RT_Window,      map_window,
				                		   RT_ReqPos,      REQPOS_CENTERSCR,
                						   RT_LockWindow,  TRUE,
				                		   RTEZ_Flags,     EZREQF_CENTERTEXT,
                						   TAG_DONE );
				            	    } // End else no name
                    			} // End if CanAttack or AtRisk
			                } // End for loop
		                } // End if response
                  } // End case 'z'  
                  break;
               case 'c':
                  {  // center the display on the current unit icon
                     int ox = xoffs, oy = yoffs;

                     restore_hex_graphics(unit->col,unit->row,0);
                     set_display_offsets(unit->col,unit->row);
                     GP_smart_scroll(ox,oy);
                     if (blink_on)
                        plot_icon(unit->type,unit->col,unit->row,roster[unit->owner].color,ORDER_NONE,stacked);
                  }
                  break;
             case 'w': // Wait for unit (put at end of unit list
              Remove((struct Node*)unit);
                 AddTail((struct List*)&unit_list,(struct Node*)unit);
            /* And set the control flag so we don't try to do
          anything else with this unit. */
                  restore_hex_graphics(unit->col,unit->row,0);
                  plot_icon(unit->type,unit->col,unit->row,
                    roster[unit->owner].color,ORDER_NONE,stacked);
                control_flag = UNIT_LOST;
                break;
               case ' ':   // skip this turn
                  // airplanes not moving still use fuel!
                  if( (wishbook[unit->type].range>0 ) && (
                    !(city_hereP(unit->col,unit->row))) &&
                    (unit->ship == NULL) )  { // added last factor trying to
                    // fix bug - when carrier moves with aircraft on board
                    // the aircraft lose fuel.
        		    unit->fuel -= unit->move/60;
		            // Add a check for out of fuel
        		    if (unit->fuel<=0) {
		              // aircraft out of fuel, crashes!
        		      if (PLAYER.show & SHOW_REQ) {
		        	    plot_mapobject(unit->col,unit->row,154,30); // explosion
          			    context_sound(BOOM_SOUND);              // kaboomy!
         			    // now tell the player the awful news
        			    sprintf(foo,"Your %s has run out of fuel and crashed!",
        				    wishbook[unit->type].name);
		         	    (void)rtEZRequestTags(foo,"Oh no!",NULL,NULL,
					      RT_Window,     map_window,
					      RT_ReqPos,     REQPOS_CENTERWIN,
					      RT_LockWindow, TRUE,
					      TAG_DONE);
		              }
        		      Remove((struct Node *)unit);           // kill the plane
		              roster[unit->owner].ulc[unit->type]++;
        		      control_flag = UNIT_LOST;
		              destruct_unit(unit);
                     if (PLAYER.show & SHOW_REQ)
                        explore_at_hex(player,unit->col,unit->row,VISIBLE,FALSE);
                     else
                        explore_at_hex(player,unit->col,unit->row,INVISIBLE,FALSE);
    		       } // End if fuel out
		          }
                  // damaged units in a city may be repaired
                  if (unit->damage>0 && unit->move>50 && city_hereP(unit->col ,unit->row))
                        unit->damage--;
                  unit->move = 0;
                  control_flag = UNIT_DONE;
                  break;
               case 'n':   // move on to next unit
                  // move unit to the tail end of the master unit list
                  Remove((struct Node *)unit);
                  AddTail((struct List *)&unit_list,(struct Node *)unit);
                  *current_unit = choose_default_unit(unit);
                  control_flag = UNIT_DONE;
                  break;
               case 'h':   /* head for home */
                  restore_hex_graphics(unit->col,unit->row,0);
                  plot_icon(unit->type,unit->col,unit->row,
                      roster[unit->owner].color,ORDER_GOTO,stacked);
                  give_orders(unit, ORDER_HOME, 0, 0, -1);
                  if( unit->orders)
                    unit->orders->processed = FALSE;
                  else
                      plot_icon(unit->type,unit->col,unit->row,
                          roster[unit->owner].color,ORDER_NONE,stacked);
                  control_flag = UNIT_DONE;
                  break;
               case 's':   /* unit for sentry duty */
                  // units that need fuel (i.e. aircraft) cannot sentry,
                  // except in cities or on aircraft carriers
                  if (wishbook[unit->type].range>0)
                     if (unit->ship==NULL && city_hereP(unit->col,unit->row)==NULL) {
                        playSound(DONK_SOUND,PLAYER.snd_vol);
                        break;   // we bail
                     FI
                  give_orders(unit,ORDER_SENTRY,0,0,-1);
                  explore_hex(player,unit->col,unit->row,VISIBLE,FALSE);
                  control_flag = UNIT_DONE;
                  break;
               case 'l':   // load ship
                  if (cargo_capacity(unit)<0) {
                     tell_user2("That unit is not a cargo vessel.",FALSE,DONK_SOUND);
                     break;
                  FI
                  if (unit->cargo>=cargo_capacity(unit) ||
		      unit->weight>=cargo_capacity(unit)) {
                     playSound(DONK_SOUND,PLAYER.snd_vol);
                     (void)rtEZRequestTags("That ship seems to be full,\nand cannot load more units.",
                        "Okay",NULL,NULL,
                        RT_Window,        map_window,
                        RT_ReqPos,        REQPOS_CENTERSCR,
                        RT_LockWindow,    TRUE,
                        RTEZ_Flags,       EZREQF_CENTERTEXT,
                        TAG_DONE );
                     break;
                  FI
                  give_orders(unit,ORDER_LOAD,0,0,0);
                  load_ship(unit);     // do it right away, if possible
                  start_blinking_unit(unit);    //***  so icon in buffer is
						// updated ***/
                  if (unit->orders) {  // unit still not full
                     unit->orders->processed = TRUE;
                     control_flag = UNIT_DONE;
                  }                  break;
               case 'u':   // unload ship (clears orders of anything on board)
                  if (unit->cargo>0) {
                     struct Unit *cargo=(struct Unit *)unit_list.mlh_Head;
                     for (;cargo->unode.mln_Succ;cargo=(struct Unit *)cargo->unode.mln_Succ)
                        if (cargo->ship==unit)
                           clear_orders(cargo);
                  FI
                  break;
               case 'v':
                  control_flag = GO_SURVEY;
                  break;
               case '5':   // cycle or shuffle stack to next unit
                  {
                     struct Unit *newunit=shuffle_units(unit,FALSE);

                     if (newunit!=unit) {
                        *current_unit = newunit;
                        control_flag = UNIT_DONE;
                        break;
                     } else
                        if( PLAYER.soundfx == SOUND_ALL )
                           playSound(DONK_SOUND,PLAYER.snd_vol);
                  }
                  break;
               // following is a sort of movement table, translates
               // keypad numbers into movement directions
               case '6':
                  direction = EAST;
                  goto mm_moving;
               case '4':
                  direction = WEST;
                  goto mm_moving;
               case '7':
                  direction = NORTHWEST;
                  goto mm_moving;
               case '9':
                  direction = NORTHEAST;
                  goto mm_moving;
               case '1':
                  direction = SOUTHWEST;
                  goto mm_moving;
               case '3':
                  direction = SOUTHEAST;
               mm_moving:
                  {
                     int orgx=unit->col, orgy=unit->row;
                     // use orgx and orgy to track actual (not requested) movement
                     // of unit, so we can keep the blinking icon working right
                     restore_hex_graphics(unit->col,unit->row,0);
                     move_unit_dir(unit,direction);
                     // if the control flag is set for any reason, it means
                     // we are outta here; no need to reinstate blinking
                     if (control_flag)
                        break;
                     // if the unit has actually moved, we certainly
                     // need to reinstate the blinking icon
                     if (orgx!=unit->col || orgy!=unit->row) {
                        stacked = (count_units_at(unit->col,unit->row)>1);
                        start_blinking_unit(unit);
                     } else
                        if (blink_on)  /* didn't move: continue blinking normally */
                           plot_icon(unit->type,unit->col,unit->row,roster[unit->owner].color,ORDER_NONE,stacked);
                  }
                  break;
               default:
                  (void)rtEZRequestTags("That key has no defined function.\nPlease try one of the many other keys.",
                     "Okay",NULL,NULL,
                     RT_Window,        map_window,
                     RT_ReqPos,        REQPOS_CENTERSCR,
                     RT_LockWindow,    TRUE,
                     RTEZ_Flags,       EZREQF_CENTERTEXT,
                     TAG_DONE );
            } // end switch
         FI
         if (class==IDCMP_MOUSEBUTTONS && code==SELECTDOWN) {
            int x, y, ctr=0, orgx=unit->col, orgy=unit->row;
            int num_hexes=adjacent(unit->col,unit->row);

            abs_to_log(message->MouseX,message->MouseY,&x,&y);
            for (; ctr<num_hexes; ctr++)
               if (hexlist[ctr].col==x && hexlist[ctr].row==y) {
                  // use orgx and orgy to track actual (not requested) movement
                  // of unit, so we can keep the blinking icon working right
                  restore_hex_graphics(unit->col,unit->row,0);
                  move_unit_xy(unit,x,y);
                  // if the control flag is set for any reason, it means
                  // we are outta here; no need to reinstate blinking
                  if (control_flag)
                     break;
                  // if the unit has actually moved, we certainly
                  // need to reinstate the blinking icon
                  if (orgx!=unit->col || orgy!=unit->row) {
                     stacked = (count_units_at(unit->col,unit->row)>1);
                     start_blinking_unit(unit);
                  } else
                     if (blink_on)  /* didn't move: continue blinking normally */
                        plot_icon(unit->type,unit->col,unit->row,roster[unit->owner].color,ORDER_NONE,stacked);
                  break;   // no need for extra iterations after we found our hex
               FI
            //ROF
            if( ctr == num_hexes ) {
          /* There was not a match for the hexes immediately around
          **    the unit.  So, let's invoke a GOTO command for that
               **    unit. x and y contain the coordinates of the hex
               **    the user selected.
          */
   	       AI5_CalcPath( unit->type, unit->col, unit->row, x, y, 
	        	    AI5_PATH_GOOD);
	           if( Path[0] != -1 ) {
		          if( (wishbook[unit->type].range > 0) && 
		            (unit->fuel < PathLength) ) {
		            // We haven't got enough fuel to reach it
		            sprintf( foo, 
		                "Can't reach from %ld,%ld to %ld,%ld, %s .",
		                unit->col, unit->row, x, y,
		                "\nNot enough fuel!");
		            (void)rtEZRequestTags
		                (foo,"Darn!",NULL,NULL,
		                RT_Window,        map_window,
		                RT_ReqPos,        REQPOS_CENTERSCR,
           		        RT_LockWindow,    TRUE,
        	    	    RTEZ_Flags,       EZREQF_CENTERTEXT,
		                TAG_DONE );
                  } // End if we haven't enough fuel
		          else {
    			    int response;
	    		    int ETA = 1;
		            // We have a path, so verify the orders
		            // *** Add path drawing here ***
		    	    PathCost -= unit->move;
			        while (PathCost > 0) {
			            ETA++;
			            PathCost -= unit_speed(unit);
			        }
		            if( unit->name ) {
		                sprintf( foo,
		                  "Move %s %s from %ld,%ld to %ld,%ld\nDistance is %ld\nPath length is %ld\nETA is %ld turns",
                          UnitString[unit->type],
			              unit->name, unit->col, unit->row, x, y, 
                          AI5_GetDist(unit->col, unit->row, x, y),
				      PathLength,ETA);
		            }
		            else {
		                sprintf( foo,
		                  "Move %s from %ld,%ld to %ld,%ld\nDistance is %ld\nPath length is %ld\nETA is %ld turns",
                          UnitString[unit->type],
			              unit->col, unit->row, x, y, 
                          AI5_GetDist(unit->col, unit->row, x, y),
				          PathLength,ETA);
		            }
			        response = rtEZRequestTags
		                (foo,"OK|Patrol|Cancel",NULL,NULL,
		                RT_Window,        map_window,
		                RT_ReqPos,        REQPOS_CENTERSCR,
		                RT_LockWindow,    TRUE,
		                RTEZ_Flags,       EZREQF_CENTERTEXT,
		                TAG_DONE ); 
			        if (response == 1) {
                            restore_hex_graphics(unit->col,unit->row,0);
                            plot_icon(unit->type,unit->col,unit->row,
                                roster[unit->owner].color,ORDER_GOTO,stacked);
 		                    give_orders(unit,ORDER_GOTO,x,y,PathLength);
		                    unit->orders->processed = FALSE;
		                    control_flag = UNIT_DONE;
		            }
			        if (response == 2) {
			            // Patrol looks the same except the order type
                        plot_icon(unit->type,unit->col,unit->row,
                            roster[unit->owner].color,ORDER_GOTO,stacked);
  		                give_orders(unit,ORDER_PATROL,x,y,PathLength);
		                unit->orders->processed = FALSE;
		                control_flag = UNIT_DONE;
		            }
		            // *** Erase path drawn here ***
		          } // End else we have a path and enough fuel
	           } // End if we have a path
	           else {
		          // No path at all
		          sprintf( foo, 
		            "Can't find a path from %ld,%ld to %ld,%ld .",
		            unit->col, unit->row, x, y);
		          if( wishbook[unit->type].range > 0 ) {
		             strcat( foo, 
		                "\nOr path length exceeds range of aircraft." );
		          }
		          (void)rtEZRequestTags
		             (foo,"Darn!",NULL,NULL,
		             RT_Window,        map_window,
		             RT_ReqPos,        REQPOS_CENTERSCR,
		             RT_LockWindow,    TRUE,
		             RTEZ_Flags,       EZREQF_CENTERTEXT,
		             TAG_DONE );
	           } // End else no path at all
               break;
            FI
         FI
         if (class==IDCMP_GADGETUP) {
            int ox = xoffs, oy = yoffs;

            restore_hex_graphics(unit->col,unit->row,0);
            if (scrolly(object,code)) {
               GP_smart_scroll(ox,oy);
            FI
            if (blink_on)
               plot_icon(unit->type,unit->col,unit->row,roster[unit->owner].color,ORDER_NONE,stacked);
         FI
         if (class == IDCMP_INTUITICKS)  // intuiticks control blinking
            if ((++ticks % 5) == 0) {
               blink_on = !blink_on;
               if (blink_on)
                  plot_icon(unit->type,unit->col,unit->row,roster[unit->owner].color,ORDER_NONE,stacked);
               else
                  restore_hex_graphics(unit->col,unit->row,0);
            FI
         ResetMenuStrip(map_window,move_menu_strip);

         switch (control_flag) {
            case UNIT_DONE:
            case UNIT_LOST:
            case GO_SURVEY:
            case GO_PRODUCTION:
               goto xyzzy;   // this should be "break 3;" but C makes it hard
         } // end switch
      OD
   OD
 xyzzy:
   // here is everything I need to clean up leaving movement mode
   if (control_flag==UNIT_LOST)
      unit=NULL;
   if (unit)
      GP_update_hex_display(unit->col,unit->row);

   // deactivate IDCMP event input
   ModifyIDCMP(map_window,NULL);

   // so that survey mode can pick up in the same spot
   if (unit) {
      cursx = unit->col;
      cursy = unit->row;
   FI

   // always clear the unit movement bar
   clear_movebar();

   /* return to my "generic" title bar, so no outdated information is */
   /* seen when it shouldn't be -- especially by the next player! */
   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);
}


void plot_cursor(x,y)
int x,y;
{
   int px, py;

   // plot the cursor; grafx_bitmap coords 242,30
   log_to_abs(x,y,&px,&py);
   px += 5;   py += 8;  // centering it in the hexagon
   BltBitMapRastPort(&grafx_bitmap,242,30,rast_port,px,py,21,17,0x0C0);
}


// move cursor in the specified direction, if possible
void move_cursor_dir(dir)
int dir;
{
   int targx = cursx, targy = cursy;

   switch (dir) {
      case EAST:
         targx++;
         break;
      case WEST:
         targx--;
         break;
      case NORTHEAST:
         targy--;
         if (cursy%2) // odd number
            targx++;
         break;
      case NORTHWEST:
         targy--;
         if (!(cursy%2)) // even number
            targx--;
         break;
      case SOUTHEAST:
         targy++;
         if (cursy%2) // odd number
            targx++;
         break;
      case SOUTHWEST:
         targy++;
         if (!(cursy%2)) // even number
            targx--;
         break;
      default:
         return;
   }

   /* correct values for wrap, if it's active */
   if (wrap) {
      if (targx<0)
         targx += width;
      if (targx>width)
         targx -= width;
      if (targy<0)
         targy += height;
      if (targy>height)
         targy -= height;
   }

   if (targx<0 || targx>(width-1))
      return;
   if (targy<0 || targy>(height-1))
      return;

   cursx = targx;
   cursy = targy;
}


// end of listing


