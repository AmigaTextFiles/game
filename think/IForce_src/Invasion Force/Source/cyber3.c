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
   cyber3.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with AI Type #2.
*/

#include "global.h"

// Local global variables - not in a .h file for others to use
short Destx = -1;
short Desty = -1;
short Type = -1;
int   FirstPath = 0; // False
long  Bounds = BIG_NUMBER;
int   Breakout = -1;

#define   CANT_NAVIGATE     -1
#define   CITY_HERE         -2
#define   UNKNOWN_COST      200

#define SHOW_AI3_MSG
#ifdef SHOW_AI3_MSG
#define  DEBUG_AI3(string)  if (!rtEZRequestTags(string,"Continue|Abort", \
     NULL,NULL, RTEZ_Flags,EZREQF_CENTERTEXT,RT_Window,map_window, \
     RT_ReqPos,REQPOS_CENTERWIN,RT_LockWindow,TRUE,TAG_END )) \
     { if (AIhandle != NULL)  unpost_it(AIhandle); AIhandle = NULL; \
     clean_exit(0, NULL); }
#endif
#ifndef SHOW_AI3_MSG
#define  DEBUG_AI3(string)
#endif
/***************************************************************
*************** Production Routines  ***************************
***************************************************************/

#define GET_REQ 10
void  AI3_set_gov_prod (struct City *metro, struct GovNode *CityOwner)
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    struct GovReqs  allreqs[ GET_REQ ];
    int i, lowest_pri, lowest_ind, total_pri = 0;
    int rand_pri;

    /* Go through the list of Governors.  We find the 10 governors with
       the highest priority requests, and pick one at random based on the
       relative priorities (i.e. a request of priority 5 is 5 times
       more likely to be honored than a request of priority 1) and make
       that requested unit. */

    /* Lets do some error checking */
    CityOwner->req.req_gov = -1;
    CityOwner->req.priority = 0;
    CityOwner->req.type = -1;

    /* Let's initialize the 10 requests */
    for (i=0; i < GET_REQ; i++) {
        allreqs[i].req_gov = -1;
        allreqs[i].priority = 0;
        allreqs[i].type = -1;
    }

    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ) {
      if (Gov->owner == player) {
       LastReq.req_gov = -1;
       LastReq.priority = 0;
       LastReq.type = -1;
            AI3_get_gov_req (Gov, metro );
       if( LastReq.priority > 0 ) {
      /* Add it to the list if it is one of the top whatever */
      lowest_pri = 1000;
      lowest_ind = -1;
      for( i=0; i < GET_REQ; i++ ) {
          if( allreqs[i].priority < lowest_pri ) {
         lowest_ind = i;
         lowest_pri = allreqs[i].priority;
          }
      }
      if( lowest_ind != -1 ) {
          allreqs[lowest_ind].req_gov = LastReq.req_gov;
          allreqs[lowest_ind].priority = LastReq.priority;
          allreqs[lowest_ind].type = LastReq.type;
      }
       }
   }
    } /* End for */
    /* Now go through the list and total up the priorities, then pick a
       random number from 1 to the total */
    for( i=0; i < GET_REQ; i++) {
   total_pri += allreqs[i].priority;
    }
    rand_pri = RangeRand( (long) (total_pri -1) ) + 1;

    /* Now select the random one we picked */
    lowest_ind = -1;
    while( rand_pri > 0 ) {
   rand_pri -= allreqs[++lowest_ind].priority;
    }
    if( (lowest_ind < 0) || (lowest_ind > (GET_REQ -1)) ) {
   /* Error - out of bounds */
   DEBUG_AI("Out of bounds for production selection randomizer")
        /* Well, make another of whatever we were making. */
   CityOwner->req.req_gov = CityOwner->ID;
   if( ( metro->unit_type >=0 ) && (metro->unit_type <= CARRIER) ) {
       CityOwner->req.type = metro->unit_type;
   }
   else {
       /* Need to make sure we have a decent fall-back: make an
          Infantry for the owning governor - we can always use
          Infantry */
       metro->unit_type = RIFLE;
       CityOwner->req.type = RIFLE;
   }
        return;
    }
    else {
   /* Make the selected type of unit */
   CityOwner->req.priority = LastReq.priority;
   CityOwner->req.type = LastReq.type;
   CityOwner->req.req_gov = LastReq.req_gov;
   sprintf(outbuf, "Producing a %s for Governor %ld",
      UnitString[CityOwner->req.type], CityOwner->req.req_gov);
   DEBUG_AI(outbuf)

   /* And we set the city itself to produce this */
   if (metro->unit_type != CityOwner->req.type) {  /*making a new type*/
       metro->unit_type = CityOwner->req.type;
       /*Tooling up penalty */
       metro->unit_wip = -1 * wishbook[metro->unit_type].build/5;
       sprintf (outbuf, "Tooling Up the city to build a %s",
           UnitString[metro->unit_type]);
       DEBUG_AI(outbuf)
   }
   /* unit->wip has been set to zero elsewhere.  Don't zero out
      production that has already been started when we haven't
      changed the type. We have enough handicaps as it is.
      */
    }
    return;
}


void  AI3_get_gov_req( struct GovNode* Gov, struct City* metro )
{
    int  HaveInfAccess = 0;
    int  HaveArmAccess = 0;
    int  i;

    /* We assume we get the global LastReq structure with all invalid
       fields, so no request is made if we don't fill them in.
       */
    if( IsCityTaken(Gov) ) {
      /* We need ground troops if they can reach us, else Air Cav if
          they are available and can reach us, else skip this city -
         it's too far away and we don't do ships yet. */
        if( wishbook[AIRCAV].enabled == TRUE) {
          AI5_CalcPath( RIFLE, metro->col, metro->row,
                Gov->x, Gov->y, AI5_PATH_BEST );
            HaveInfAccess = Path[0];
            if( HaveInfAccess != -1 ) {
               AI5_CalcPath( ARMOR, metro->col, metro->row,
                Gov->x, Gov->y, AI5_PATH_BEST );
                HaveArmAccess = Path[0];
            }
            else {
                HaveArmAccess = -1;
            }
          if( HaveInfAccess != -1 ) {  /* Access by ground forces */
               LastReq.priority = 30;
              /* No type selected yet, lets get a ground unit */
               /* Make armor units if we can, if not, make infantry. */
              LastReq.type = ARMOR;

             /* Now, change back if we can't make an armor or they can't
                  reach the destination. */
               if( (wishbook[ARMOR].enabled != TRUE) ||
                (HaveArmAccess == -1)) {
                  LastReq.type = RIFLE;
               }
             /* And, change it back if the area of interest is
                  not good for armor
                  */
              if((Gov->hist.TerrainCounts[HEX_PLAINS] +
               Gov->hist.TerrainCounts[HEX_DESERT] +
                //Gov->hist.TerrainCounts[HEX_ARCTIC] +
               Gov->hist.TerrainCounts[HEX_BRUSH])
                          <
                (Gov->hist.TerrainCounts[HEX_JUNGLE] +
                  Gov->hist.TerrainCounts[HEX_PEAKS] +
                  Gov->hist.TerrainCounts[HEX_SWAMP] +
                  Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
                LastReq.type = RIFLE;
           }
          else { /* No access by ground forces */
               if( (AI5_GetDist( metro->col, metro->row, Gov->x,
              Gov->y ) <= 12) && (wishbook[AIRCAV].enabled == TRUE) ) {
                    /* distance is <= 12 AND we can make AirCav */
              LastReq.type = AIRCAV;
            LastReq.priority = 30;
               }
              /* Else, no request at all */
         }
        } /* End if we can make AIRCAV */
        else {
                LastReq.type = ARMOR;
             /* Now, change back if we can't make an armor or they can't
                  reach the destination. */
               if( wishbook[ARMOR].enabled != TRUE)
                  LastReq.type = RIFLE;

             /* And, change it back if the area of interest is
                  not good for armor
                  */
              if((Gov->hist.TerrainCounts[HEX_PLAINS] +
               Gov->hist.TerrainCounts[HEX_DESERT] +
                //Gov->hist.TerrainCounts[HEX_ARCTIC] +
               Gov->hist.TerrainCounts[HEX_BRUSH])
                          <
                (Gov->hist.TerrainCounts[HEX_JUNGLE] +
                  Gov->hist.TerrainCounts[HEX_PEAKS] +
                  Gov->hist.TerrainCounts[HEX_SWAMP] +
                  Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
                LastReq.type = RIFLE;
        } /* End else can't make AIRCAV */
    }
    else {
      switch( Gov->mode ) {
       case GOV_DEFEND:
           /* We're under attack!  Make some ground units to defend with */
          LastReq.priority = 20;
           /* But, let's only change production if it's not ARMOR */
           if( metro->unit_type == ARMOR )
            LastReq.type = ARMOR;
           else
         LastReq.type = RIFLE;
           break;
      case GOV_SEARCH:
           /* If we have no units, make a fighter to scout with, else
              make some ground troops
             */
           LastReq.priority = 10;
          if( (Gov->hist.UnitCounts[FIGHTER] +
                Gov->hist.UnitCounts[BOMBER] < 1 ) ||
                (Gov->hist.TotalMyUnits > 10) ) {
            /* if we can make fighters, make one - else make a bomber if
               we can make those, else, make ground units (No Air!).
                 Not going to bother with Air Cav - too slow to scout
               with.
             */
            if( wishbook[FIGHTER].enabled == TRUE )
                LastReq.type = FIGHTER;
              else if( wishbook[BOMBER].enabled == TRUE )
                  LastReq.type = BOMBER;
             }
               /* else, make some ground pounders */
               if( LastReq.type == -1 ) {
             /* No type selected yet, lets get a ground unit */
            /* Make armor units if we can, if not, make infantry. */
             LastReq.type = ARMOR;

            /* Now, change back if we can't make an armor */
             if (wishbook[ARMOR].enabled != TRUE) {
                  LastReq.type = RIFLE;
            }
            /* And, change it back if the area of interest is
                 not good for armor
                */
            if((Gov->hist.TerrainCounts[HEX_PLAINS] +
                 Gov->hist.TerrainCounts[HEX_DESERT] +
                  //Gov->hist.TerrainCounts[HEX_ARCTIC] +
                 Gov->hist.TerrainCounts[HEX_BRUSH])
                            <
               (Gov->hist.TerrainCounts[HEX_JUNGLE] +
                 Gov->hist.TerrainCounts[HEX_PEAKS] +
                  Gov->hist.TerrainCounts[HEX_SWAMP] +
                 Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
                 LastReq.type = RIFLE;
           }
          break;
      } /* End switch */
    }

    /* Attenuate the priority of the request for distance */
    if( LastReq.priority > 0 ) {
       i = AI5_GetDist (metro->col, metro->row, Gov->x, Gov->y);
      LastReq.priority -= i / 2;
       if (LastReq.priority < 1)  LastReq.priority = 1;
    }
    /* And make sure we record who made the request */
    if( LastReq.type != -1 )
      LastReq.req_gov = Gov->ID;

    return;
}


// This is the routine called to calculate the best
//  path - it will return the direction to go in. Unless
//  there is not a path - in which case it will return -1.
int   AI3_calc_path( short type, short orgx, short orgy, short destx,
           short desty, int ReturnFirst, int breakout )
{
    // This calculates the best direction to move in to get
    //  from an origin to a destination based on the unit
    //  type.  The map from the current player is used for
    //  reference.  Unknown terrain costs more, but is still
    //  considered traversable.  Time will tell if this works
    //  well enough.  It is an adaptation of the A* search.
    //  It is kind of slow, but not too horrific.  This is
    //  just being used to calculate access for unit types
    //  right now.

    struct     MapIcon *icon = (struct MapIcon *)PLAYER.icons.mlh_Head;
    long        length;
    long        sub_calc_move (short, short, long);

    // check that we have a valid destination
    if( (destx > width) || (destx < 0) || (desty > height)
        || (desty < 0) )  return (-1);  // Not on Map

    // check that we have a valid origin
    if( (orgx > width) || (orgx < 0) || (orgy > height) || (orgy < 0) )
        return (-1);  // Not on Map

    // check for start and end identical, just for yucks
    if( (orgx == destx) && (orgy == desty) )  return (-1);

    if( MoveMap != NULL ) free (MoveMap);
    // A realloc will be just as fast as clearing a memory page
    //  to all zeros myself, and this makes sure there is never
    //  a problem with synching up to a newly loaded map with
    //  a different size.
    // Try realloc instead of free and calloc later if we need
    //  to get more performance.
    MoveMap = (int*) calloc( width * height, sizeof (int) );

    // Check for the calloc working
    if( MoveMap != NULL ) {
        // First, set up the globals
   FirstPath = ReturnFirst;
        Destx = orgx;
        Desty = orgy;
        Type = type;
        Bounds = BIG_NUMBER;
        if( breakout > 0 ) Breakout = breakout;
        else Breakout = -1;

        // Do some more initialization of the MoveMap to mark
        //  the cities.
        for (; icon->inode.mln_Succ; icon = (struct MapIcon *)
          icon->inode.mln_Succ)  {
             if( icon->type == CITY )  {
                if( icon->owner == player )
                    MoveMap[icon->row * width + icon->col] = CITY_HERE;
                else MoveMap[icon->row * width + icon->col] = CANT_NAVIGATE;
             }
             else {
                // Icon type is NOT a city
                if( (icon->owner == player) && (opt.stacking == FALSE) )
                    MoveMap[icon->row * width + icon->col] = CANT_NAVIGATE;
             }
        }   // End for loop

        // Now we make sure that an enemy city (or whatever) at the
        //  destination hex will allow us to move - we assume the caller
        //  knows what they are doing and wants to move into an enemy
        //  city.
        if( MoveMap[desty * width + destx] == CANT_NAVIGATE )
            MoveMap[desty * width + destx] = CITY_HERE;

        // Now we call the recursive routine to help us out
        // but reverse the origin and destination, so we work
        // from the dest to the source, and not the reverse.
        // Should make finding the path much easier.
        length = sub_calc_move( destx, desty, 0);

        // Well, figure out the path and return it.  If the
        //  routine returned -1, forget it.
        if( length > 0 ) {
            // Look at the origin - the six hexes around it.
            //  the lowest value > 0 is the start of the
            //  shortest path.
            int  i, k = 0;
            int  least = BIG_NUMBER;
            int  dir = -1;
            short newx, newy;

            if (destx - orgx < 0)  k = 3;
            if (destx == orgx)     k = 6;
            if (desty - orgy < 0)  k += 1;
            if (desty == orgy)     k += 2;
            for (i=0; i < 6; i++) {
                if( AI1_calc_dir(DirArray[k][i], orgx, orgy,
                  &newx, &newy) > 0 ) {
                    if( (MoveMap[newy * width + newx] > 0) &&
                        (MoveMap[newy * width + newx] < least) ) {
                            least = MoveMap[newy * width + newx];
                            dir = DirArray[k][i];
                    } // End if
                } // End if we have a hex in that dir
            } // End for
            // If we have a best direction, return it
            if (dir != -1)  return dir;
        }
    }

    // And if all else fails, return fails.
    return (-1);
}


long   sub_calc_move( short orgx, short orgy, long CumCost )
{
    // Here we recurse - expanding each one of the six hexes
    //  around the starting hex - but only if it is a zero
    //  in the MoveMap.  Thus we cover each hex once only.

    int     i;
    int     j = -1;
    int     index = orgy * width + orgx;    // Done once for
                                            // efficiency
    int     cost;
    long    lowest = BIG_NUMBER;

    // First, did we make it?  If so set the bounds if this is the
    //  shortest path so far.
    if( (orgx == Destx) && (orgy == Desty) )  {
        if( CumCost < Bounds ) Bounds = CumCost;
        return CumCost;
    }

    // Check if we have already been here and determined we
    //  can't move here
    if( MoveMap[index] == CANT_NAVIGATE )  return (-1);

    if( Breakout == 0 ) return -1;
    if( Breakout != -1 ) {
        if(--Breakout == 0) return (-1);
    }
    // Next we check for the hex being navagable by the unit
    //  type.  Note that an unknown hex is not unnavagable
    if( get(PLAYER.map, orgx, orgy) == HEX_UNEXPLORED )  {
        cost = UNKNOWN_COST;
    }
    else {
        // A friendly city here is navagable, regardless of
        //  the underlying terrain.
        if( MoveMap[index] == CITY_HERE ) {
                cost = 10;
        }
        else {
                // Get cost based on terrain
                cost = movement_cost_table[Type][get(PLAYER.map, orgx, orgy)];
       }
    }

    // If we can't move here mark the space
    if( cost == CANT_NAVIGATE ) {
        MoveMap[index] = cost;
        return (-1);
    }

    // Now that we know we CAN move here, we can add this space to the
    //  running total
    CumCost += cost;

    // Check the Bounds - no use expanding from here if we already have
    //  a longer path than the shortest path found so far.
    if( CumCost >= Bounds )  {
   // Mark the space as unnavagable - no use checking here again
        //MoveMap[index] = CANT_NAVIGATE;
   return (-1);
    }

    // Check the MoveMap space.  If it is zero OR positive and greater
    //  than the new total (so that the new total is a shorter path to
    //  get there) then record the new total in that space
    if( (MoveMap[index] == 0) || (MoveMap[index] > CumCost)
        || (MoveMap[index] == CITY_HERE) ) {
        // Need extra variables for new location
        short   newx, newy;
        int     k = 0;

        // Replace the value here
        MoveMap[index] = CumCost;

        // Now expand, calling this routine recursively
        if (Destx - orgx < 0)  k = 3;
        if (Destx == orgx)     k = 6;
        if (Desty - orgy < 0)  k += 1;
        if (Desty == orgy)     k += 2;
       for (i=0; i < 6; i++) {
         //check each direction from here
         if ( AI1_calc_dir
           (DirArray[k][i], orgx, orgy, &newx, &newy) > 0) {
              j = sub_calc_move( newx, newy, CumCost);
                // Record the shortest path of the six
              if( (j > 0) && ( FirstPath ) ) return( j );
                        if( (j > 0) && (j < lowest) ) lowest = j;
                } // End if
       } // End for loop

        // If we have a good path, return it
        if( lowest < BIG_NUMBER )  return lowest;
   } // End if we want to expand from this hex

    // Else, return no path
    return (-1);
}


struct GovNode*  AI3_locate_gov( struct City* metro )
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    struct GovNode *NewGov = NULL;

    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ) {
   if ((Gov->owner == player) &&
       ((Gov->type == GOV_CITY) || (Gov->type == GOV_PORT) ||
      (Gov->type == GOV_ISLAND))
       && (Gov->x == metro->col) && (Gov->y == metro->row)) {
       /* We found the right city governor. */
       return( Gov );
   }  /* End if */
    } /* End for loop */

    DEBUG_AI("Couldn't find the governor, making one")
    /* Never found it */
    NewGov = AI3_add_gov( metro );
    /* And, let's set up the governors area of interest */
    AI3_setup_area_of_interest (NewGov, 5, 9);
    return (NewGov);
}


struct GovNode*  AI3_add_gov( struct City* metro )
{
    struct GovNode *new_gov = AllocVec((int)sizeof(*new_gov),MEMF_CLEAR);
    int i;
    short terrain;
    short targx, targy;
    struct MapIcon* icon;

    new_gov->x = metro->col;
    new_gov->y = metro->row;
    new_gov->searchx = -1;
    new_gov->searchy = -1;
    new_gov->targx = -1;
    new_gov->targy = -1;
    new_gov->mode = GOV_SEARCH;
    new_gov->flags = 0;
    new_gov->owner = player;
    if (port_cityP(metro)) {
   new_gov->type = GOV_PORT;
   /* Next, we need to check if we are an island city */
   /* Check all six hexes around us - if there is no land or
      city in any of the six, then we are an island */
   for( i=0; i<6; i++ ) {
       /* Check each direction for a city or land hex */
       if (AI1_calc_dir (i, metro->col, metro->row, &targx,
          &targy) != -1) {
      /* Check for a land hex, or a city icon there */
      terrain = get(PLAYER.map, targx, targy);
      if( (terrain >= 1) && (terrain <= 11) ) {
          /* its a land */
          goto EXIT_ISLAND_SEARCH;
      }
      icon = (struct MapIcon *)PLAYER.icons.mlh_Head;
      for (; icon->inode.mln_Succ; icon = (struct MapIcon *)
          icon->inode.mln_Succ)
          if ((icon->type == CITY) &&
         (icon->col == targx) &&
         (icon->row == targy))  goto EXIT_ISLAND_SEARCH;
       }
   }
   new_gov->type = GOV_ISLAND;
      EXIT_ISLAND_SEARCH: new_gov->ID = NewGov;
    }
    else {
       new_gov->type = GOV_CITY;
       new_gov->ID = NewGov;
    }
    NewGov += RangeRand(3L); // Just to mix up the numbers a little

    sprintf (outbuf, "Creating Governor %ld at %ld,%ld",
        new_gov->ID, new_gov->x, new_gov->y);
    DEBUG_AI(outbuf)


    /* Add the new governor to the list of governors */
    AddTail((struct List *)&GovList,(struct Node *)new_gov);
    return( new_gov );
}


void  AI3_setup_area_of_interest( struct GovNode* Gov, int inner, int outer )
{
    /* Set up the immediate area of interest */
    Gov->startx = Gov->x - inner;
    Gov->starty = Gov->y - inner;
    Gov->endx = Gov->x + inner;
    Gov->endy = Gov->y + inner;
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
    Gov->Estartx = Gov->x - outer;
    Gov->Estarty = Gov->y - outer;
    Gov->Eendx = Gov->x + outer;
    Gov->Eendy = Gov->y + outer;
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


void  AI3_play_turn( int new_units )
{
    int   MaxLooping = 5000;
    /* Here we may want to look around, give out some orders to units,
       and execute orders to units in a loop until we have done all the
       moves possible for the units.
       */
    AI3_do_all_histograms();
    AI3_give_orders();
    /* We'll add a little failsafe so we don't spend eternity here */
    while( (MaxLooping > 0) && (!DoUnitActions(40,60)) )  MaxLooping--;
    if( MaxLooping <= 0 )
   DEBUG_AI3("Error: Exitting AI player's turn - out of actions!")
    return;
}


void  AI3_do_all_histograms()
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    /* First we update the picture for all the Governors */
    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ)
   if (Gov->owner == player) {
       AI1_do_one_histogram (Gov);
        AI3_set_gov_mode (Gov);
   }
    /* End for loop */
}


void  AI3_set_gov_mode( struct GovNode* Gov )
{
    enum GovMode new_mode = GOV_SEARCH;

    // Now, if we have enemy forces in the area, set to defend
    if(( Gov->hist.TotalEUnits > 0 ) || (Gov->hist.EnemyCounts[CITY] > 0) )
         new_mode = GOV_DEFEND;

    if( new_mode != Gov->mode ) {
        Gov->mode = new_mode;
        // clear all orders
        AI1_clear_all_orders( Gov );
    }
    // And if we lost the city, set the taken flag - this will also
    // clear orders if the taken flag gets set.
    AI1_set_gov_mode( Gov );

    return;
}



void  AI3_give_orders( )
{
    struct  Unit   *unit = (struct Unit *)unit_list.mlh_Head;

    for (;unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
        if ((unit->owner == player) && (unit->move > 0) &&
            (unit->orders == NULL)) {
            /* No orders yet, let's set some
          Ok, we own the unit, and it has moves left, and has a Governor
          owner, and has no standing orders
          Don't just stand there, do something!
          */
            AI3_orders_for_unit( unit );
       } /* end if owner and has moves left */
    /* End For */
}

void  AI3_orders_for_unit( struct Unit* unit )
{
    struct GovNode *Gov = NULL;

    Gov = AI1_FindOwner (unit);
    if (Gov != NULL) {
         if( IsCityTaken( Gov ) ) {
          AI3_taken_orders( unit, Gov );
        } /* End if CityTaken */
        else {
          switch( Gov->mode ) {
               case GOV_DEFEND:  {
               AI3_defend_orders( unit, Gov );
               break;
               } /* End if mode = defend */
               case GOV_SEARCH: {
               AI3_search_orders( unit, Gov );
               break;
               }
             default: {
               AI3_default_orders( unit, Gov );
               break;
             }
          } /* End switch */
        } /* End else city is not taken */
    } /* End if Gov is not equal to NULL */
    else {
      /* Can't find owner */
      AI3_default_orders( unit, Gov );
    }
}

void  AI3_taken_orders( struct Unit* unit, struct GovNode* Gov )
{
    char outbuf[20];
    struct GovNode* Gov2 = NULL;
    struct MapIcon* icon = NULL;
    /* For taken cities, we want the air units to retreat to another
       city (if possible) or else attack any enemy in sight.  Aircav
       should try to retake the city if they can.  Armor and Infantry
       should also retake the city like AI #2.
       */
    switch( unit->type ) {
    case FIGHTER:
   /* Deliberate fall through */
    case BOMBER:
   Gov2 = AI3_FindClosestCityGov( unit, unit->fuel );
   if( Gov2 ) {
       ComputerGiveOrders
      (unit, C_ORDER_GOTO, Gov2->x, Gov2->y, -1, -1, -1);
       /* And defect to that Governor */
       sprintf (outbuf, "%ld / %ld", Gov->ID, NewUnit++);
       name_unit( unit, outbuf);
   }
   else {
       /* No one else in range - try to take someone with us */
       ComputerGiveOrders
      (unit, C_ORDER_HUNT, -1, -1, -1, -1, 6);
   }
   break;
    case AIRCAV:
   if( AI5_GetDist( unit->col, unit->row, Gov->x, Gov->y )
       <= unit->fuel ) {
       /* We are in range of our own Governor, so go retake it.
          Do or die! */
       ComputerGiveOrders
      (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
   }
   else {
       /* Too far to reach it */
       /* Find nearest city to hole up in */
       Gov2 = AI3_FindClosestCityGov( unit, unit->fuel );
       if( Gov2 ) {
      ComputerGiveOrders
          (unit, C_ORDER_GOTO, Gov2->x, Gov2->y, -1, -1, -1);
      /* And defect to that Governor */
      sprintf (outbuf, "%ld / %ld", Gov->ID, NewUnit++);
      name_unit( unit, outbuf);
       }
       else {
      /* What now ? I must be out here for some reason... */
      icon = AI3_FindClosestEnemyCity( unit, unit->fuel );
      if( icon ) {
          /* Go get it! */
          ComputerGiveOrders
         (unit, C_ORDER_GOTO, icon->col, icon->row, -1, -1, -1);
      }
       }
   }
    case RIFLE:
   /* Deliberate fall through */
    case ARMOR:
   /* Come and retake the city */
   ComputerGiveOrders
       (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
   break;
    default:
   DEBUG_AI("Unknown unit type - ignoring")
   break;
    }
}

void  AI3_defend_orders( struct Unit* unit, struct GovNode* Gov )
{
    struct MapIcon* icon = NULL;
    /* On defense, we have the fighters and bombers seek out enemy units
       and attack them - within their fuel constraints.  Units with less
       than half their fuel will return to their city for fueling before
       assaulting enemy units - unless, of course, they run into them on
       the way.  Aircav will still try to go for the nearest enemy city
       to try and take it (it may be why we are in defend mode).  Ground
       units will try to attack enemy units or enemy cities (if they are
       closer). This may need some more thought!
          How about this - we make the defining factor whether there are
       enemy units about.  For fighter and bomber aircraft, if there were
       no enemy units, then go back to recon (they certainly can't help
       take enemy cities).
       */
    switch( unit->type ) {
    case FIGHTER:
   /* Deliberate fall through */
    case BOMBER:
   if( Gov->hist.TotalEUnits > 0 ) {
       if( unit->fuel > (wishbook[unit->type].range / 2) ) {
      /* Go hunting */
      ComputerGiveOrders
          (unit, C_ORDER_HUNT, -1, -1, -1, -1, 6);
       }
       else {
      /* Return for more fuel */
      ComputerGiveOrders
          (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
       }
   }
   else {
       /* Must be another city we saw - go back to recon */
       if( (unit->col == Gov->x) && (unit->row == Gov->y) )
      ComputerGiveOrders
          (unit, C_ORDER_RECON, -1, -1, Gov->x, Gov->y, -1 );
       else
      ComputerGiveOrders
          (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
   }
   break;
    case AIRCAV:
   icon = AI3_FindClosestEnemyCity( unit, unit->fuel );
   if( icon ) {
       /* Enemy city in range. Go get it! */
       ComputerGiveOrders
      (unit, C_ORDER_GOTO, icon->col, icon->row, -1, -1, -1);
   }
   else {
       /* None in range - must be enemy units about */
       /* This may not be smart - these are expensive units. */
       if( Gov->hist.TotalEUnits > 0 ) {
      ComputerGiveOrders
          (unit, C_ORDER_HUNT, -1, -1, -1, -1, 6);
       }
       else {
      /* No one around to attack.  Put in storage */
      if(( unit->col == Gov->x) && ( unit->row == Gov->y) ) {
          ComputerGiveOrders
         (unit, C_ORDER_SENTRY, -1, -1, -1, -1, -1);
      }
      else {
          /* Return for more fuel */
          ComputerGiveOrders
         (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
      }
       }
   }
   break;
    case RIFLE:
   /* Deliberate fall through */
    case ARMOR:
   if( Gov->hist.TotalEUnits > 0 ) {
       if( (unit->col > Gov->Estartx) &&
          (unit->col < Gov->Eendx ) &&
          (unit->row > Gov->Estarty) &&
         (unit->row < Gov->Eendy) ) {
         DEBUG_AI("Put 'em on the hunt")
          ComputerGiveOrders
              (unit, C_ORDER_HUNT, -1, -1, -1, -1, 6);
       } /* End of if unit in governors extended zone */
       else {
         /* Maybe there is a city nearby to attack? */
         icon = AI3_FindClosestEnemyCity
             ( unit, 10 );
         if( icon ) {
             ComputerGiveOrders
                (unit, C_ORDER_GOTO, icon->col, icon->row,
              -1, -1, -1);
         }
         else {
              ComputerGiveOrders
                 (unit, C_ORDER_GOTO, Gov->x, Gov->y,
             -1, -1, -1);
         }
       } /* End else not in governors extended range */
   }
   else {
       /* No enemy units - must be a city to attack */
       icon = AI3_FindClosestEnemyCity( unit, 100 );
       if( icon ) {
         ComputerGiveOrders
              (unit, C_ORDER_GOTO, icon->col, icon->row, -1,
          -1, -1);
       }
       else {
         /* Go back to random wandering - nothing better to do */
            ComputerGiveOrders
            (unit, C_ORDER_RANDOM, -1, -1, -1, -1, -1);
       }
   }
   break;
    default:
      DEBUG_AI("Unknown unit type - ignoring")
       break;
    } /* End switch */
}

void  AI3_search_orders( struct Unit* unit, struct GovNode* Gov )
{
    struct GovNode* Gov2 = NULL;
    struct MapIcon* icon = NULL;
    /* Here we want the aircraft to search for new cities to take,
       the ground units just wander around randomly like before.
       */
    switch( unit->type ) {
    case FIGHTER:
   /* Deliberate fall through */
    case BOMBER:
   /* Let's go exploring */
   if( (unit->col == Gov->x) && (unit->row == Gov->y) ) {
       ComputerGiveOrders
      (unit, C_ORDER_RECON, -1, -1, Gov->x, Gov->y, -1 );
   }
   else {
       /* return for fuel */
       ComputerGiveOrders
      (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
   }
   break;
    case AIRCAV:
   /* Except for AirCav - put them in storage until needed */
   if( city_hereP( unit->col, unit->row ) != NULL ) {
       /* We are in a city, so go to sentry */
       ComputerGiveOrders
      (unit, C_ORDER_SENTRY, -1, -1, -1, -1, -1);
   }
   else {
       /* Try to get to a city */
       if( AI5_GetDist (unit->col, unit->row, Gov->x, Gov->y)
      > unit->fuel ) {
      /* Need to get to the nearest city-gov and get put in
         storage there */
      Gov2 = AI3_FindClosestCityGov( unit, unit->fuel );
      if( Gov2 ) {
          ComputerGiveOrders
         (unit, C_ORDER_GOTO, Gov2->x, Gov2->y,
          -1, -1, -1);
      }
      else {
          /* Now what ?  Try to take an enemy city of course ..*/
          icon = AI3_FindClosestEnemyCity( unit, unit->fuel );
          if( icon ) {
         /* Go get it! */
         ComputerGiveOrders
             (unit, C_ORDER_GOTO, icon->col, icon->row,
              -1, -1, -1);
          }
          else {
         /* How can this be?  Why are we out here? We never
            leave the nest unless attacking a city. */
         DEBUG_AI3("AirCav movement problem - can't reach any city")
          }
      }
       }
       else {
      /* go home */
      ComputerGiveOrders
          (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
       }
   }
   break;
    case RIFLE:
   /* Deliberate fall through */
    case ARMOR:
   /* Let's do some self preservation - check if we are hurt */
   if( unit->damage > 0 ) {
       /* We're damaged - head for home to get repaired */
       ComputerGiveOrders
      ( unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1 );
   }
   else {
       /* Wander around like a drunken sailer! */
       ComputerGiveOrders
      (unit, C_ORDER_RANDOM, -1, -1, -1, -1, -1);
   }
   break;
    default:
   DEBUG_AI("Unknown unit type - ignoring")
   break;
    }
}

void  AI3_default_orders( struct Unit* unit, struct GovNode* Gov )
{
    struct GovNode* Gov2;
    char outbuf[20];
    /* Should never be called - ever.  This is a failsafe in case the mode
       for the Governor gets set to something really strange.  So, anyway,
       in order to keep everything moving smoothly we will have default
       orders set up for each type of unit - have aircraft go to the nearest
       city and go on sentry there, and have the ground units wander about
       randomly.
       */
    if( Gov ) {
   DEBUG_AI3("Error!  Calling default orders - problem in Governor mode?")
    }
    else {
   DEBUG_AI3("Error!  Calling default orders - unit has no Governor!")
    }
    switch( unit->type ) {
    case FIGHTER:
   /* Deliberate fall through */
    case BOMBER:
   /* Deliberate fall through */
    case AIRCAV:
   /* Find the closest city and go there, or if in a city already
      then just go to sentry mode */
   if( city_hereP( unit->col, unit->row ) != NULL )
       ComputerGiveOrders
      (unit, C_ORDER_SENTRY, -1, -1, -1,-1, -1);
   else {
       /* Find owner city and go there */
       Gov2 = AI1_FindOwner (unit);
       if( Gov2 ) {
      /* The failsafe is set to the unit's fuel - either make
         it there or die trying! */
      ComputerGiveOrders
          (unit, C_ORDER_GOTO, Gov2->x, Gov2->y, -1, -1, -1);
       }
       else {
      /* Can't find owner - go to closest city Governor and set
         that as the unit's owner */
      Gov2 = AI3_FindClosestCityGov( unit, unit->fuel );
      if( Gov2 ) {
          ComputerGiveOrders
         (unit, C_ORDER_GOTO, Gov2->x, Gov2->y,
          -1, -1, -1);
          /* And make this Governor the owner of the unit */
          sprintf (outbuf, "%ld / %ld", Gov2->ID, NewUnit++);
          name_unit( unit, outbuf);
      }
      else {
          /* else all is lost - have it try to pound on enemies
             until it drops */
          ComputerGiveOrders
         (unit, C_ORDER_HUNT, -1, -1, -1, -1, 20);
      }
       }
   }
   break;
    case RIFLE:
   /* Deliberate fall through */
    case ARMOR:
   ComputerGiveOrders (unit, C_ORDER_RANDOM, -1, -1, -1,-1, -1);
   /* Make sure we have an owning Governor */
   Gov = AI1_FindOwner (unit);
   if( Gov == NULL ) {
       /* No owner - set it to the closest city Governor */
       Gov = AI3_FindClosestCityGov( unit, 100 );
       sprintf (outbuf, "%ld / %ld", Gov->ID, NewUnit++);
       name_unit( unit, outbuf);
   }
   break;
    default:
   DEBUG_AI("Unknown unit type - ignoring")
   break;
    }
}


struct MapIcon* AI3_FindClosestEnemyCity( struct Unit* unit, int limit )
{
    /* Modifying this routine to yield the closest enemy city that the
       unit can actually REACH - it's no good telling an infantry unit
       that the closest enemy city is across the bay...
       */
    int  closest = BIG_NUMBER;
    int  i;
    struct MapIcon *closestEnemy = NULL;
    struct MapIcon *icon = (struct MapIcon *) PLAYER.icons.mlh_Head;

    for (; icon->inode.mln_Succ; icon = (struct MapIcon *)
      icon->inode.mln_Succ) {
        if( (icon->owner != player) && (icon->type == CITY) ) {
           i = AI5_GetDist ( unit->col, unit->row, icon->col,
                icon->row );
            AI5_CalcPath( unit->type, unit->col, unit->row, icon->col,
                icon->row, AI5_PATH_BEST );
           if( (i < limit) && (i < closest) &&
              (Path[0] != -1 ) ) {
                  closest = i;
                  closestEnemy = icon;
           }
       }
    }
    return( closestEnemy );
}


struct GovNode* AI3_FindClosestCityGov( struct Unit* unit, int limit )
{
    int  closest = BIG_NUMBER;
    int  i;
    struct GovNode *closestCity = NULL;
    struct GovNode *gov = (struct GovNode*) GovList.mlh_Head;

    for (; gov->gnode.mln_Succ; gov = (struct GovNode*)gov->gnode.mln_Succ) {
        if( (gov->owner == player) &&
       ((gov->type == GOV_CITY) || (gov->type == GOV_PORT) ||
      (gov->type == GOV_ISLAND) )) {
       i = AI5_GetDist( unit->col, unit->row, gov->x, gov->y );
       if( (i < limit) && (i < closest) ) {
      closest = i;
      closestCity = gov;
       }
   }
    }
    return( closestCity );
}



int  AI3_do_unit_actions()
{
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    struct GovNode *Gov = NULL;
    int         Done = TRUE;
    static struct Unit* lastunit = NULL;
    static int    times_accessed = 0;

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
          if ((unit->orders != NULL) &&
              (unit->orders->reserved == C_ORDER_SENTRY))
              continue;
         /* Take a look around us and react to enemy units + cities */
         if( AI3_look_around ( unit ) )   return (FALSE);
          /* if we have orders, execute them */
         if (unit->orders != NULL) {
             AI3_execute_standing_order(unit);
              return (FALSE);
         }

         else {
                /* We don't have orders, so try to wing it! */
              Gov = AI1_FindOwner (unit);
              if (Gov != NULL) {
                 DEBUG_AI("No orders, no enemy around. Huh?")
                /* Just skip this unit this turn - the
                    governor willgive new orders next turn. */
                unit->move = 0;
             } /* End if Gov != NULL */
             else {
                DEBUG_AI("Cannot find unit owner to ad lib turn")
                 DEBUG_AI("For Now, Forget IT!")
                 sprintf (outbuf, "%s Unit %s at %ld,%ld",
                   UnitString[unit->type], unit->name,
                   unit->col, unit->row);
                 DEBUG_AI(outbuf)
                unit->move = 0;
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
         unit->move-=10;
       }
    } /* End if we own unit and it has moves left */
    /* End for loop */
    times_accessed = 0;
    lastunit = NULL;
    return (Done);
}



void AI3_computer_give_orders(struct Unit *unit,int suborder,short destx,
    short desty,short orgx,short orgy,int etc)
{
    struct GovNode* Gov = NULL;
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
      case C_ORDER_HEADTO:
       /* Standard stuff only */
        sprintf (outbuf, "%s %s C_ORDER_HEADTO from %ld,%ld to %ld,%ld",
        UnitString[unit->type], unit->name, order->orgx,
        order->orgy, order->destx, order->desty);
        DEBUG_AI(outbuf)

       break;
      case C_ORDER_RECON:
       /* We need to figure out where to recon to - based on the Gov's
          current status of recon elements. */
       Gov = AI1_FindOwner( unit );
       if( Gov ) {
         AI3_select_recon_hex( unit, Gov );
         /* And let's set a failsafe of 1/2 our fuel -1 */
         /* And if this is not an aircraft for some reason
       (a screwup) this will just get set to -1 anyway */
         order->etc = wishbook[unit->type].range / 2 - 1;
       }
       else {
         /* Can't find the owner - will get sorted out next turn */
       }
       break;
      case C_ORDER_GOTO:
       /* Standard stuff only */
            break;
      case C_ORDER_RANDOM:
       /* Standard stuff only */
       break;
      case C_ORDER_HUNT:
       /* Standard stuff only */
       break;
      case C_ORDER_SENTRY:
       /* Standard stuff only */
       break;
      }
   }
}


void AI3_select_recon_hex( struct Unit* unit, struct GovNode* Gov )
{
    /* The recon command is special - each Governor will search out
       it's edges in a particular pattern.  There are two variables
       in the GovNode struct - searchx and searchy - that record
       where the governor is searching to currently.  Thus, the next
       available recon resource can be given the next destination
       in turn, and they recyle when all have been exhausted, so that
       the explorers turn into patrollers automatically.
       */
    BOOL    UseNext = FALSE;
    int      Reach;
    int      i;
    short   targx,  targy;

    if ((Gov->x == unit->col) && (Gov->y == unit->row)) {
   /* We have an aircraft, fueled, at home city
      Let's use them to keep on exploring
      */
   Reach = wishbook[unit->type].range / 2 - 1;
   if( Reach <= 0 ) {
       /* Something awry here - not a plane */
       clear_orders(unit);
       return;
   }
   if( Gov->searchx == -1) {
       /* No searches done yet, start with the first */
       UseNext = TRUE;
   }
   for (i = 0; i < 21; i++) {
       switch (i) {
      /* These are the short range ones */
       case 20:    /* Wrap around to zero again! */
      /* Deliberate fall through */
       case 0:
      targx = Gov->endx;
      targy = Gov->starty;
      break;
       case 1:
      targx = Gov->startx;
      targy = Gov->endy;
      break;
       case 2:
      targx = Gov->endx;
      targy = Gov->endy;
      break;
       case 3:
      targx = Gov->startx;
      targy = Gov->starty;
      break;
      /* And these are the long ranged ones. */
      /* Mixed them up to cover more ground faster */
       case 15:     /* North */
         targx = Gov->x;
         targy = Gov->y - Reach;
          break;
       case 4:     /* NorthNorthEast */
         targx = Gov->x + 5;
         targy = Gov->y - Reach + 2;
          break;
       case 8:     /* EastNorthEast */
         targx = Gov->x + Reach - 2;
         targy = Gov->y - 4;
          break;
       case 12:     /* East */
         targx = Gov->x + Reach;
         targy = Gov->y;
          break;
       case 5:     /* EastSouthEast */
         targx = Gov->x + Reach - 2;
         targy = Gov->y + 4;
          break;
       case 9:     /* SouthSouthEast */
         targx = Gov->x + 5;
         targy = Gov->y + Reach - 2;
          break;
       case 13:     /* South */
         targx = Gov->x;
         targy = Gov->y + Reach;
          break;
       case 6:     /* SouthSouthWest */
         targx = Gov->x - 5;
         targy = Gov->y + Reach - 2;
          break;
       case 10:     /* WestSouthWest */
         targx = Gov->x - Reach + 2;
         targy = Gov->y + 4;
          break;
       case 14:    /* West */
         targx = Gov->x - Reach;
         targy = Gov->y;
          break;
       case 7:     /* WestNorthWest */
         targx = Gov->x - Reach + 2;
         targy = Gov->y - 4;
          break;
       case 11:     /* NorthNorthWest */
         targx = Gov->x - 5;
         targy = Gov->y - Reach + 2;
          break;
       case 16:    /* NorthPlus */
         targx = Gov->x - 2;
         targy = Gov->y - Reach;
          break;
       case 18:    /* NorthMinus */
         targx = Gov->x + 2;
         targy = Gov->y - Reach;
          break;
       case 17:    /* SouthPlus */
         targx = Gov->x - 2;
         targy = Gov->y + Reach;
          break;
       case 19:    /* SouthMinus */
         targx = Gov->x + 2;
         targy = Gov->y + Reach;
          break;
       default:
      DEBUG_AI("Unknown case in select_search_pattern")
                break;
       } /* End switch (i) */
       /* Let's make sure the target point is on the map */
       if (targx < 0) {
         if (!wrap) targx = 0;
         else targx = targx + (width - 1);
       }
       if (targx > (width -1)) {
          if (!wrap) targx = width - 1;
         else targx = targx - (width - 1);
       }
       if (targy < 0) {
         if (!wrap) targy = 0;
          else targy = targy + (height - 1);
       }
       if (targy > (height - 1)) {
         if (!wrap) targy = height - 1;
         else targy = targy - (height - 1);
       }
       /* If we have been told to UseNext, then do it */
       if( UseNext == TRUE ) {
         unit->orders->destx = targx;
         unit->orders->desty = targy;
            Gov->searchx = targx;
            Gov->searchy = targy;
            return;
       }
       /* Now, check for the current search target */
       if( ( Gov->searchx == targx ) && (Gov->searchy == targy ) ) {
      /* we found the last one sent out - use the next one */
          UseNext = TRUE;
       }
   } /* end for loop */
   /* If we get here, there is a problem */
   clear_orders(unit);
   return;
    } /* End if at home  */
    else {
   /* Deliver selves to home city */
   DEBUG_AI("Search or Conquer, unit delivering to owner")
            ComputerGiveOrders (unit, C_ORDER_GOTO, Gov->x,
              Gov->y, -1, -1, -1);
    } /* End else */
}


int  AI3_look_around( struct Unit* unit)
{
    int          i, k;
    short        targx, targy;
    struct City* metro;
    struct GovNode *FoundGov = NULL;

    for (i = 0; i < 6; i++) {
   if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
       if ((metro = city_hereP (targx, targy)) &&
      (metro->owner != player)) {
      /* if there is a city here and we don't own it, this
         call will create a Governor for it if there isn't
         one already.
         */
      //FoundGov = AI3_locate_gov( metro );
      /* And let the new Gov take a look around */
      //AI1_do_one_histogram (FoundGov);
      //AI3_set_gov_mode (FoundGov);
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
      if( (unit->type == BOMBER) && (metro->owner != 0)) {
          if( (!unit->orders) ||
         (unit->orders->reserved != C_ORDER_RECON)) {
         /* if we can't take it - bomb it! But it is no use
            bombing a neutral city. Also, if we are on recon,
            don't bomb either.
            */
         move_unit_xy (unit, targx, targy);
         return (1);
          }
      }
       } /* End if city here and it ain't ours! */
   } /* End if hex here */
    } /* End For loop */
    for (i = 0; i < 6; i++) {
   if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
       if (((k = hex_owner(targx,targy)) > 0)&&(k!=player)) {
      if((!unit->orders) ||
         (unit->orders->reserved != C_ORDER_RECON) ) {
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
            if( !AI3_AssertUnit(unit) ) return (1);
      }
      /* Else, try a different enemy unit */
       }  /* End if bad guy here */
   } /* End if hex here */
    } /* End for loop */
    return (0);
}

void  AI3_execute_standing_order( struct Unit* unit )
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
        case  C_ORDER_HEADTO:
            result = AI1_command_headto(unit);
            if( (result <= 0) && (AI3_AssertUnit(unit)) )
                clear_orders(unit);   /* problem or done */
            break;
        case  C_ORDER_RANDOM:
            AI3_command_random(unit);
            break;
        case  C_ORDER_HUNT:
          result = AI2_command_hunt(unit);
           if( (result < 0) && (AI3_AssertUnit(unit)) )
                clear_orders(unit);  /* wouldn't work */
           break;
        case  C_ORDER_RECON:
            result = AI3_command_recon(unit);
            if( (result <= 0) && (AI3_AssertUnit(unit)) )
                 clear_orders(unit);  /* problem */
            break;
        default:
            DEBUG_AI("Unknown command type found in execute_standing_order!")
            break;
    }
    return;
}


void  AI3_command_random( struct Unit* unit )
{
    if( unit->orders->destx >= 0 ) {
        /* destx has the last direction we were headed */
        if( move_unit_dir(unit,(enum Direction) unit->orders->destx) != -1 )
            return;
    }
    /* Pick a new random direction to head in */
    if( unit->orders )
        unit->orders->destx = RangeRand(6L);
}




int   AI3_command_recon( struct Unit* unit )
{
    int  result;

    /* With this order we go out to the destination, then, once we
       reach it or hit 1/2 fuel, replace the destination with the
       origin (home) and head for it.
       */
    /* Very first thing is to check that if we are on the last half
       of our fuel, we are headed home.  If not, start heading home.
       */
    if( (wishbook[unit->type].range > 0) &&
       (unit->fuel <= wishbook[unit->type].range / 2) &&
       ((unit->orders->destx != unit->orders->orgx) ||
       (unit->orders->desty != unit->orders->orgy)) ) {
           unit->orders->destx = unit->orders->orgx;
           unit->orders->desty = unit->orders->orgy;
          unit->orders->etc = unit->fuel;
    }
    /* Next, we'll use the AI1_command_headto routine to do the grunt
       work for us (since this command is really two of those commands
       back to back).
       */
    result = AI1_command_headto( unit );
    if( result < 0 ) {
      /* problem - check where we are, and head home if not there */
       /* -1 blocked, just can't get there */
       /* -2 watchdog ran out */
       if( result == -1 ) return result;  /* report the problem */
       /* else watchdog. Head for home */

       if( (AI3_AssertUnit(unit)) && (unit->orders) &&
            ((unit->orders->destx != unit->orders->orgx) ||
           (unit->orders->desty != unit->orders->orgy)) ) {
              unit->orders->destx = unit->orders->orgx;
               unit->orders->desty = unit->orders->orgy;
               unit->orders->etc = unit->fuel;
               return 1;
        }
    }
    if( result == 0 ) {
       /* Done - check for which leg it was on */
       if( (AI3_AssertUnit(unit)) && (unit->orders) &&
            ((unit->orders->destx != unit->orders->orgx) ||
           (unit->orders->desty != unit->orders->orgy)) ) {
              /* Now head for home */
               unit->orders->destx = unit->orders->orgx;
               unit->orders->desty = unit->orders->orgy;
               unit->orders->etc = unit->fuel;
              return 1;  /* Don't clear orders yet */
       }
    }
    return result;
}


int  AI3_AssertUnit( struct Unit* CheckUnit )
{
    /* Let's take a page from C++ now and create an
       assertion function to test that a unit still
       exists before we operate on it after a move
       */
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    for( ; unit->unode.mln_Succ; unit = (struct Unit *) unit->unode.mln_Succ)
        if( CheckUnit == unit )  return TRUE;
    //End for loop
    (void)rtEZRequestTags ( "Error: Unit assertion failed", "Dang!",NULL,NULL,
         RT_DEFAULT,TAG_END);
    return FALSE;
}


void  AI3_Add_Lib( struct Unit* unit )
{
    // This routine sets orders for units that have no orders in the middle
    //   of a turn.  Without this aircraft will be 'skipped' for a turn,
    //   which usually runs them out of fuel and crashes them.

    struct GovNode* Gov = AI1_FindOwner( unit );
    // For ground units, the default is OK.  For air units we need to send
    //   them back to a landing spot.
    switch( unit->type ) {
      case FIGHTER:
      case BOMBER:
      case AIRCAV: {
   if( Gov ) {
     // Go home
     ComputerGiveOrders
      (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
   }
   else {
     Gov = AI3_FindClosestCityGov( unit, unit->fuel );
     if( Gov ) {
       // Land at the closest
     ComputerGiveOrders
      (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, -1);
     }
     else {
       // Forget it, we're toast
       unit->fuel -= unit->move / 60;
       unit->move = 0;
       if( unit->fuel <= 0 ) Remove ((struct Node*)unit);
       return;
     }
   }
   break;
      }
      default: {
   unit->move = 0;
   break;
      }
    }
}
