
/*
AI Code for Invasion Force - an Explore/Conquer Strategic Wargame
Copyright (C) 1996  Brannen Hough

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/
/*
   cyber2.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with AI Type #2.
*/

#include "global.h"


/***************************************************************
*************** Production Routines  ***************************
***************************************************************/

void  AI2_set_gov_prod (struct City *metro, struct GovNode *CityOwner)
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;

    // Go through the list of Governors.  We find the one governor with
    //  the highest priority request, and start making that request.

    // Lets do some error checking
    CityOwner->req.req_gov = -1;
    CityOwner->req.priority = 0;
    CityOwner->req.type = -1;

    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ) {
      if (Gov->owner == player) {
            AI2_get_gov_req (Gov, metro);  // request gets returned in LastReq
            sprintf(outbuf, "Gov %ld Request - type %s, req_gov %ld, pri %ld",
                Gov->ID, UnitString[LastReq.type], LastReq.req_gov,
                LastReq.priority);
            DEBUG_AI (outbuf)
            if( LastReq.priority >= CityOwner->req.priority ) {
                CityOwner->req.priority = LastReq.priority;
                CityOwner->req.type = LastReq.type;
                CityOwner->req.req_gov = LastReq.req_gov;
            }  // End if higher priority
        } // end if my governor
    }  // end for loop

    sprintf(outbuf, "Producing a %s for Governor %ld",
        UnitString[CityOwner->req.type], CityOwner->req.req_gov);
    DEBUG_AI(outbuf)

    // And we set the city itself to produce this
    if (metro->unit_type != CityOwner->req.type) {  //making a new type
        metro->unit_type = CityOwner->req.type;
        //Tooling up penalty
        metro->unit_wip = -1 * wishbook[metro->unit_type].build/5;
        sprintf (outbuf, "Tooling Up the city to build a %s",
         UnitString[metro->unit_type]);
        DEBUG_AI(outbuf)
    }
    // unit->wip has been set to zero elsewhere.  Don't zero out production
    //  that has already been started when we haven't changed the type.
   //  We have enough handicaps as it is.

     return;
}


void   AI2_get_gov_req (struct GovNode *Gov, struct City *metro)
{
    int     i;

    // Mark who has placed this request
    LastReq.req_gov = Gov->ID;

    // Set priority based on the mode of the city
    switch( Gov->mode ) {
        case GOV_SEARCH:
            LastReq.priority = 10;
            break;
        case GOV_DEFEND:
            LastReq.priority = 20;
            break;
        default:
            LastReq.priority = 5;
            break;
    }
    if( IsCityTaken(Gov) )  LastReq.priority = 25;
    // Attenuate for distance
    i = AI5_GetDist (metro->col, metro->row, Gov->x, Gov->y);
    LastReq.priority -= i / 2;
    if (LastReq.priority < 1)  LastReq.priority = 1;

    if( (Gov->mode == GOV_SEARCH) && (!IsCityTaken(Gov)) ) {
        // The heat is off, let's see what's best to build
        // Make armor units if we can, if not, make infantry.
        LastReq.type = ARMOR;

        // Now, change back if we can't make an armor
        if (wishbook[ARMOR].enabled != TRUE) {
            LastReq.type = RIFLE;
        }
        // And, change it back if the area of interest is not good for armor
        if((Gov->hist.TerrainCounts[HEX_PLAINS] +   // Sum total of all the
            Gov->hist.TerrainCounts[HEX_DESERT] +   // terrain armor is very
            //Gov->hist.TerrainCounts[HEX_ARCTIC] +   // fast on
            Gov->hist.TerrainCounts[HEX_BRUSH])
                        <
           (Gov->hist.TerrainCounts[HEX_JUNGLE] +   // Sum total of all the
            Gov->hist.TerrainCounts[HEX_PEAKS] +     //  terrain armor is
            Gov->hist.TerrainCounts[HEX_SWAMP] +    // very slow in.
            Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
            LastReq.type = RIFLE;
    }
    else {
        // Things are hairy - build infantry until they get better
        LastReq.type = RIFLE;
    }

    return;
}


/* Just a stop gap for now - I have a much better routine to replace
   this one with */
int   AI2_calc_distance (short orgx, short orgy, short destx, short desty)
{
    short   deltx,
            delty;

    int     result;

   // This seems to work on my graphs - We'll see in
    //   real life - needed some adjustment - still nothing for
   // wrap.  Wrap will need to adjust the deltx and delty I think
   //  Returns the distance in hexes.
   deltx = (destx >= orgx) ? (destx - orgx) : (orgx - destx);
   delty = (desty >= orgy) ? (desty - orgy) : (orgy - desty);
   if (delty == 0)  return (deltx);
   if (deltx == 0)  return (delty);
   // Takes care of the easy cases, now we do 'diagonals'
   result = delty;
   if (orgy % 2) {
      if (destx > orgx) {  result += (deltx - delty / 2); }
      else   result += (deltx - (delty + 1)/2);
   }
   else {
      if (destx > orgx) {  result += (deltx - (delty + 1)/2); }
      else   result += (deltx - delty / 2);
   }
    return  (result);
}


void  AI2_play_turn( int new_units )
{
    int   MaxLooping = 1000;
    /* Here we may want to look around, give out some orders to units,
       and execute orders to units in a loop until we have done all the
       moves possible for the units.
       */
    AI2_do_all_histograms();
    AI2_give_orders();
    /* We'll add a little failsafe so we don't spend eternity here */
    while( (MaxLooping > 0) && (!DoUnitActions(40,60)) )  MaxLooping--;
    if( MaxLooping <= 0 )
   DEBUG_AI("Exitting AI player's turn - out of actions")
    return;
}


struct GovNode*  AI2_locate_gov( struct City* metro )
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    struct GovNode *NewGov = NULL;

    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ) {
   if ((Gov->owner == player) &&
       ((Gov->type == GOV_CITY) || (Gov->type == GOV_PORT))
       && (Gov->x == metro->col) && (Gov->y == metro->row)) {
       /* We found the right city governor. */
       return( Gov );
   }  /* End if */
    } /* End for loop */

    DEBUG_AI("Couldn't find the governor, making one")
    /* Never found it */
    NewGov = AI1_add_gov( metro );
    /* And, let's set up the governors area of interest */
    AI2_setup_area_of_interest (NewGov);
    return (NewGov);
}


void  AI2_setup_area_of_interest( struct GovNode* Gov )
{
    /* Set up the immediate area of interest */
    Gov->startx = Gov->x - 2;
    Gov->starty = Gov->y - 2;
    Gov->endx = Gov->x + 2;
    Gov->endy = Gov->y + 2;
    if (!wrap) {
        if (Gov->startx < 0) Gov->startx = 0;
        if (Gov->starty < 0) Gov->starty = 0;
        if (Gov->endx > width - 1) Gov->endx = width - 1;
        if (Gov->endy > height - 1) Gov->endy = height - 1;
    }
    else {
   if (Gov->startx < 0) Gov->startx += width;
   if (Gov->starty < 0) Gov->starty += height;
   if (Gov->endx > width - 1) Gov->endx -= width;
   if (Gov->endy > height - 1) Gov->endy -= height;
    }
    /* Set up the Extended area of interest */
    Gov->Estartx = Gov->x - 5;
    Gov->Estarty = Gov->y - 5;
    Gov->Eendx = Gov->x + 5;
    Gov->Eendy = Gov->y + 5;
    if (!wrap) {
        if (Gov->Estartx < 0) Gov->Estartx = 0;
        if (Gov->Estarty < 0) Gov->Estarty = 0;
        if (Gov->Eendx > width - 1) Gov->Eendx = width - 1;
        if (Gov->Eendy > height - 1) Gov->Eendy = height - 1;
    }
    else {
   if (Gov->Estartx < 0) Gov->Estartx += width;
   if (Gov->Estarty < 0) Gov->Estarty += height;
   if (Gov->Eendx > width - 1) Gov->Eendx -= width;
   if (Gov->Eendy > height - 1) Gov->Eendy -= height;
    }

    /* sprintf (outbuf,
       "For Gov %ld, Startx:%ld, Starty:%ld, Endx:%ld, Endy:%ld",
       Gov->ID, Gov->startx, Gov->starty, Gov->endx, Gov->endy);
       DEBUG_AI(outbuf)
       */
    return;
}


void  AI2_do_all_histograms()
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    /* First we update the picture for all the Governors */
    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ)
   if (Gov->owner == player) {
       AI1_do_one_histogram (Gov);
        AI2_set_gov_mode (Gov);
   }
    /* End for loop */

}


void  AI2_set_gov_mode( struct GovNode* Gov )
{
    enum GovMode new_mode = GOV_SEARCH;

    // Now, if we have enemy forces in the area, set to defend
    if( Gov->hist.TotalEUnits > 0 )  new_mode = GOV_DEFEND;

    if( new_mode != Gov->mode ) {
        Gov->mode = new_mode;
        // clear all orders
        AI1_clear_all_orders( Gov );
    }
    // And if we lost the city, set the taken flag
    AI1_set_gov_mode( Gov );

    return;
}


void  AI2_give_orders( )
{
    struct  Unit   *unit = (struct Unit *)unit_list.mlh_Head;
    struct GovNode *Gov = NULL;

    for (;unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
        if ((unit->owner == player) && (unit->move > 0) &&
            (unit->orders == NULL)) {
            /* No orders yet, let's set some
          Ok, we own the unit, and it has moves left, and has a Governor
          owner, and has no standing orders
          Don't just stand there, do something!
          */
           //sprintf(outbuf,
           //"Giving initial orders to unit named %s at %ld,%ld",
            //   unit->name, unit->col, unit->row);
            //   DEBUG_AI(outbuf)

            Gov = AI1_FindOwner (unit);
            if (Gov != NULL) {
            if( IsCityTaken( Gov ) ) {
                  /* Have the unit move to the city's location */
                    DEBUG_AI("City Taken! Home Boys!")
                  ComputerGiveOrders (unit, C_ORDER_GOTO, Gov->x,
                     Gov->y, -1, -1, -1);
              } /* End if CityTaken */
              else {
                  if( Gov->mode == GOV_DEFEND ) {
                        DEBUG_AI("Defend mode boys! Repel invaders!")
                     /* We need to get back to help defend the homeland
                         if needed.  Head for the city if far, head for
                         an enemy if close (inside the AOI)
                         */
                     if( (unit->col > Gov->Estartx) &&
                         (unit->col < Gov->Eendx ) &&
                         (unit->row > Gov->Estarty) &&
                         (unit->row < Gov->Eendy) ) {
                            DEBUG_AI("Put 'em on the hunt")
                         ComputerGiveOrders (unit, C_ORDER_HUNT,
                            -1, -1, -1, -1, 6);
                     } /* End of if unit in governors extended zone */
                     else {
                         /* Just head for the city */
                            DEBUG_AI("Too Far! Just head for the city")
                         ComputerGiveOrders (unit, C_ORDER_GOTO,
                            Gov->x, Gov->y, -1, -1, -1);
                     } /* End else not in governors extended range */
                  } /* End if mode = defend */
                  else {
                     /* Have the unit wander randomly */
                        DEBUG_AI("Wander randomly")
                     ComputerGiveOrders (unit, C_ORDER_RANDOM,
                         -1, -1, -1,-1, -1);
                  }
              } /* End else city is not taken */
           } /* End if Gov is not equal to NULl */
            else {
                /* If we can't find it, just wander randomly */
                DEBUG_AI("Can't locate owner - wander randomly anyway")
             ComputerGiveOrders (unit, C_ORDER_RANDOM,
                  -1, -1, -1,-1, -1);
            }
       } /* end if owner and has moves left */
    /* End For */
}


struct MapIcon* AI2_FindClosestEnemyUnit( short orgx, short orgy, int limit )
{
    int  closest = BIG_NUMBER;
    int  i;
    struct MapIcon *closestEnemy = NULL;
    struct MapIcon *icon = (struct MapIcon *) PLAYER.icons.mlh_Head;

    for (; icon->inode.mln_Succ; icon = (struct MapIcon *)
      icon->inode.mln_Succ) {
        if (icon->owner != player) {
       i = AI5_GetDist( orgx, orgy, icon->col, icon->row );
       if( (i < limit) && (i < closest) ) {
      closest = i;
      closestEnemy = icon;
       }
   }
    }
    return( closestEnemy );
}


int  AI2_do_unit_actions()
{
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    struct GovNode *Gov = NULL;
    int         Done = TRUE;
    struct Unit* lastunit = NULL;
    int         times_accessed = 0;

    for ( ; unit->unode.mln_Succ; unit = (struct Unit *) unit->unode.mln_Succ)
        if ((unit->owner==player) && (unit->move > 0)) {
       /* Added this last to only give any one unit 10 chances to
          move - if it hasn't by then, skip over it and go to the
          next.  This has the pleasant effect that the unit that
          couldn't move in 10 tries will get another 10 tries to
          move, and so on, until it finally gets skipped for this
          turn. */
     if ( (lastunit != unit) || (times_accessed < 10) )  {
       if( lastunit != unit ) {
          lastunit = unit;
          times_accessed = 0;
       }
       else {
           times_accessed++;
        }
        /* Skip Sentry units */
        if ((unit->orders == NULL) ||
          (unit->orders->reserved != C_ORDER_SENTRY))   continue;

       /* Take a look around us and react to enemy units + cities */
       if( AI2_look_around ( unit ) )   return (FALSE);

        /* if we have orders, execute them */
        if (unit->orders != NULL) {
            AI2_execute_standing_order(unit);
            return (FALSE);
        }
        else {
            Gov = AI1_FindOwner (unit);
            if (Gov != NULL) {
             DEBUG_AI("No orders, no enemy around. Huh?")
             /* Just skip this unit this turn - the governor will
                 give new orders next turn. */
              unit->move = 0;
              continue;
            } /* End if Gov != NULL */
            else {
              DEBUG_AI("Cannot find unit owner to ad lib turn")
                DEBUG_AI("For Now, Forget IT!")
                sprintf (outbuf, "%s Unit %s at %ld,%ld",
                 UnitString[unit->type], unit->name, unit->col,
                  unit->row);
              DEBUG_AI(outbuf)
                unit->move = 0;
              continue;
            } /* End else Gov == NULL */
       } /* End else figure something out */
     } /* End if the unit is not the same one we accessed 10 times */
     else {
       /* Last unit IS this unit and times accessed >= 10. */
       /* This should ensure that we never get stuck forever - we
          will always finish - removes a potential infinite loop
          when there are TWO enemy planes, over water, that can be
          attacked by ground troops.  They will ping pong between
          them forever. */
       unit->move--;
      }
    } /* End if we own unit and it has moves left */
    /* End for loop */

    return (Done);
}


void AI2_computer_give_orders(struct Unit *unit,int suborder,short destx,
    short desty,short orgx,short orgy,int etc)
{
   struct Order *order=AllocVec((long)sizeof(*order),MEMF_CLEAR);

   clear_orders(unit);
   if (order) {
      order->destx = destx;
      order->desty = desty;
      unit->orders = order;
      order->type = ORDER_NONE;
      if (orgx == -1)  order->orgx = unit->col;
      else  order->orgx = orgx;
      if (orgy == -1)  order->orgy = unit->row;
      else  order->orgy = orgy;
      order->processed = FALSE;
      order->etc = etc;
      order->reserved = suborder;       /* using reserved for computer
                                  orders so I don't tread on the human
                                  player's tokens. */

      /* This is set up to be in the order they are used most often,
         and set up so that more order types can be added as needed.
    */
      switch (suborder) {
      case C_ORDER_GOTO:
     /* sprintf (outbuf, "%s %s C_ORDER_GOTO from %ld,%ld to %ld,%ld",
        UnitString[unit->type], unit->name, order->orgx,
        order->orgy, order->destx, order->desty);
        DEBUG_AI(outbuf)
        */
     break;
      case C_ORDER_RANDOM:
     /* Standard stuff only */
     break;
      case C_ORDER_HUNT:
     /* Standard stuff only */
     break;
      }
   }
}


int  AI2_look_around( struct Unit* unit)
{
    int          i, k;
    short        targx, targy;
    struct City* metro;

    for (i = 0; i < 6; i++) {
   if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
       if ((metro = city_hereP (targx, targy)) &&
      (metro->owner != player)) {
      /* if there is a city here and we don't own it */
      (void) AI2_locate_gov( metro );
      /* Make a governor for it if there isn't one already */
      /* Then, try to take it */
        if ((unit->type == RIFLE) || (unit->type == ARMOR)
          || (unit->type == AIRCAV)) {
          /* Go for it! */
          /* DEBUG_AI("Jumping enemy city") */
          /* We can check here that we can GET to the city
             and at least tried to take it, bogged down, etc.
             */
          if( move_unit_xy (unit, targx, targy) <= -2) {
             return (1);
          }
          /* Else, look around for something else to attack -
           another city, an enemy unit, etc.
           */
        } /* End if can take city */
       } /* End if city here and it ain't ours! */
   } /* End if hex here */
    } /* End For loop */
    for (i = 0; i < 6; i++) {
   if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
       if (((k = hex_owner(targx,targy)) > 0)&&(k!=player)) {
          /* Somebody there - for now just jump 'em */
          /*DEBUG_AI("Jumping enemy unit") */
          /* Add the if statement so that we keep trying to attack
              an enemy until we succeed or have tried each direction
              once.  There are cases (like an aircraft over water
              attacked by a ground unit) where attacks can't take
              place. */
          if( move_unit_xy (unit, targx, targy) <= -2 ) {
              /* We successfully attacked, ran out of gas, couldn't
                  move, etc. */
              return (1);
          }
          /* Else, try a different enemy unit */
       }  /* End if bad guy here */
   } /* End if hex here */
    } /* End for loop */
    return (0);
}


void  AI2_execute_standing_order( struct Unit* unit )
{
    int     result;

    if ((unit->orders == NULL) || (unit->orders->type != ORDER_NONE)) {
   DEBUG_AI("Big problem in execute_standing_order - no orders!")
   sprintf (outbuf, "%s %s has no standing orders to execute - aborting",
       UnitString[unit->type], unit->name);
   DEBUG_AI(outbuf)
   return;
    }

    switch (unit->orders->reserved) {
        case  C_ORDER_GOTO:
            result = AI1_command_headto(unit);
            if (result < 0) clear_orders(unit);   /* problem */
            if (result == 0) clear_orders(unit);  /* done */
            break;
        case  C_ORDER_RANDOM:
       /* Let's break the mold and use a more advanced AI routine */
            AI3_command_random(unit);
            break;
        case  C_ORDER_HUNT:
          result = AI2_command_hunt(unit);
           if (result < 0) clear_orders(unit);  /* wouldn't work */
           break;
        default:
            DEBUG_AI("Unknown command type found in execute_standing_order!")
            break;
    }
    return;
}


int   AI2_command_hunt( struct Unit* unit )
{
    int i, j;
    int result;
    /* We find the closest enemy unit to us and move towards it */
    struct MapIcon *icon = AI2_FindClosestEnemyUnit( unit->col, unit->row, 6 );

    if( icon ) {
      /* We see one! Move towards him */
       /* Select the correct direction to look in */
      i = 0;
       if (icon->col - unit->col <= 0)  i = 3;
      if( (icon->col == unit->col) && (unit->col%2 == 0) ) i = 0;
       if (icon->row - unit->row < 0)  i += 1;
      if (icon->row == unit->row)     i += 2;

       /* Let's move in the three most likely directions only */
      for (j = 0; j < 3; j++) {
           /* -1 is the only return value where a move might still be possible
              We must be sure we only do ONE move - ever */
            result = move_unit_dir( unit, DirArray[i][j] );
          if( result != -1 )  {
             /*sprintf (outbuf, "Moved %s, result %ld",
               DirString[DirArray[i][j]], result);
              DEBUG_AI(outbuf)
              */
             return (0);  /* Made a move */
          }
           else {
                // Could not move in that direction - try another
             sprintf (outbuf,
                 "%s %s Tried to move in direction %s, result %ld",
                   UnitString[unit->type], unit->name,
                  DirString[DirArray[i][j]], result);
               DEBUG_AI(outbuf)
          }
      } /* End for loop */

        // All three directions did not pan out
       return -1;
    }
    // else
    return -1;  /* No one nearby to chase */
}


