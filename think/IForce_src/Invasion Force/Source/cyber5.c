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
   cyber5.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with AI Type #5.
*/


#include <math.h>
#include "global.h"

// Local global variables.  not in a .h file for others to use.
extern short  Type;
extern short  Destx;
extern short  Desty;

#define SHOW_AI5_MSG
#ifdef SHOW_AI5_MSG
#define  DEBUG_AI5(string)  if (!rtEZRequestTags(string,"Continue|Abort", \
     NULL,NULL, RTEZ_Flags,EZREQF_CENTERTEXT,RT_Window,map_window, \
     RT_ReqPos,REQPOS_CENTERWIN,RT_LockWindow,TRUE,TAG_END )) \
     { if (AIhandle != NULL)  unpost_it(AIhandle); AIhandle = NULL; \
     clean_exit(0, NULL); }
#endif
#ifndef SHOW_AI5_MSG
#define  DEBUG_AI5(string)
#endif



// And a huge 'extern' section for all the unit type selection lists
extern struct GovPrefs  AI5_CITY_DEF_AIR;
extern struct GovPrefs  AI5_CITY_DEF_SEA;
extern struct GovPrefs  AI5_CITY_SEARCH_FIRST;
extern struct GovPrefs  AI5_CITY_SUPPORT_SEA;
extern struct GovPrefs  AI5_CITY_SUPPORT_LAND;
extern struct GovPrefs  AI5_ISLE_DEF_OWN;
extern struct GovPrefs  AI5_ISLE_DEF_AIR;
extern struct GovPrefs  AI5_ISLE_DEF_SEA;
extern struct GovPrefs  AI5_ISLE_SEARCH_FIRST;
extern struct GovPrefs  AI5_ISLE_SEARCH_OWN;
extern struct GovPrefs  AI5_ISLE_SEARCH_AIR;
extern struct GovPrefs  AI5_ISLE_SUPPORT;
extern struct GovPrefs  AI5_TRANS_ATTACK;
extern struct GovPrefs  AI5_TRANS_DEFEND;
extern struct GovPrefs  AI5_CARR_ATT_SEA;
extern struct GovPrefs  AI5_CARR_ATT_AIR;
extern struct GovPrefs  AI5_BATT_ATTACK;

/***************************************************************
*************** Production Routines  ***************************
***************************************************************/
#define GET_REQ 10
void  AI5_set_gov_prod (struct City *metro, struct GovNode *CityOwner)
{
  // change this to only ask for suggestions IF the city is in Support
  //  mode.  All other times be selfish and produce our own units
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
            AI5_get_gov_req (Gov, metro, CityOwner->type );
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

void  AI5_get_gov_req( struct GovNode* Gov, struct City* metro,
      enum GovType type)
{
  if(( Gov->type == GOV_CITY ) || ( Gov->type == GOV_PORT )) {
      AI5_get_city_req( Gov, metro, type );
  }
  if( Gov->type == GOV_ISLAND ) {
      AI5_get_island_req( Gov, metro, type );
  }
  if( Gov->type == GOV_TRANSPORT ) {
        AI5_get_transport_req( Gov, metro, type );
  }
  if( Gov->type == GOV_CARRIER ) {
        AI5_get_carrier_req( Gov, metro, type );
  }
  if( Gov->type == GOV_BATTLESHIP ) {
        AI5_get_battleship_req( Gov, metro, type );
  }
  if( LastReq.type != -1 ) {
        // We selected a type to build, set our ID as owner
        // This way, one less thing to be set by all the other routines.
        LastReq.req_gov = Gov->ID;
  }
}

void  AI5_get_city_req( struct GovNode* Gov, struct City* metro,
      enum GovType type )
{
    // What mode are we in now?
    switch (Gov->mode) {
    case GOV_TAKEN: {
      // We must have ground troops if they can reach us
      //  Otherwise, AIRCAV
      // if there is a path to this Gov from the city by Infantry,
      //    make Infantry.
      //    If there is a path from this Gov to the city by
      //    Armor AND Armor can manuever,
      //       make Armor instead.
      // else (there is no path for Infantry)
      //    if distance from Gov to city is less than 13
      //       make Aircav instead.
      // This is someone elses city, so let's see what we can get
      int InfAccess;
      int ArmorAccess;
      long dist;
      AI5_CalcPath( RIFLE, Gov->x, Gov->y, metro->col,
           metro->row, AI5_PATH_BEST);
      InfAccess = Path[0];
      dist = AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row );
      if( InfAccess != -1 ) {
         AI5_CalcPath( ARMOR, Gov->x, Gov->y,
            metro->col, metro->row, AI5_PATH_BEST);
          ArmorAccess = Path[0];
         LastReq.priority = 40;
         LastReq.type = RIFLE;
         if( (ArmorAccess != -1) && (wishbook[ARMOR].enabled == TRUE) ) {
           if((Gov->hist.TerrainCounts[HEX_PLAINS] +
              Gov->hist.TerrainCounts[HEX_DESERT] +
              //Gov->hist.TerrainCounts[HEX_ARCTIC] +
              Gov->hist.TerrainCounts[HEX_BRUSH])
                       >
              (Gov->hist.TerrainCounts[HEX_JUNGLE] +
              Gov->hist.TerrainCounts[HEX_PEAKS] +
              Gov->hist.TerrainCounts[HEX_SWAMP] +
              Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
                  LastReq.type = ARMOR;
         }
      }
     else {  // We can't get there with infantry - maybe Aircav?
       if( (dist <= wishbook[AIRCAV].range) &&
          (wishbook[AIRCAV].enabled == TRUE) ) {
               LastReq.priority = 50;
               LastReq.type = AIRCAV;
        }
        // else no request - too far away to help
      }
      break;
    }
    case GOV_DEFEND:
      // Make ground troops if we are at home, place orders for more if
      //   they can reach.  If not, order up aircraft when in range.
      //   Maybe subs and destroyers too?
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     // If this is my city, let's get some troops
     LastReq.priority = 40;
     LastReq.type = RIFLE;
      }
      else {
      int InfAccess;
         int ArmorAccess;
      long dist = AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row );
        AI5_CalcPath( RIFLE, Gov->x, Gov->y, metro->col,
          metro->row, AI5_PATH_BEST);
        InfAccess = Path[0];
          if( InfAccess != -1 ) {
          AI5_CalcPath( ARMOR, Gov->x, Gov->y,
            metro->col, metro->row, AI5_PATH_BEST);
            ArmorAccess = Path[0];
          LastReq.priority = 30;
          LastReq.type = RIFLE;
          if( (ArmorAccess != -1) && (wishbook[ARMOR].enabled == TRUE) ) {
              if((Gov->hist.TerrainCounts[HEX_PLAINS] +
                Gov->hist.TerrainCounts[HEX_DESERT] +
                //Gov->hist.TerrainCounts[HEX_ARCTIC] +
                Gov->hist.TerrainCounts[HEX_BRUSH])
                      >
               (Gov->hist.TerrainCounts[HEX_JUNGLE] +
                Gov->hist.TerrainCounts[HEX_PEAKS] +
                Gov->hist.TerrainCounts[HEX_SWAMP] +
                Gov->hist.TerrainCounts[HEX_MOUNTAINS]) )
                  LastReq.type = ARMOR;
             }
        }
      else {
          if(dist <= wishbook[FIGHTER].range) {
              LastReq.priority = 30;
             LastReq.type = AI5_select_from_prefs
                 ( &AI5_CITY_DEF_AIR, metro->unit_type );
          }
          else {
              if( (type == GOV_ISLAND) || (type == GOV_PORT) ) {
                 // They can build ships too
                  LastReq.type = AI5_select_from_prefs
                      (&AI5_CITY_DEF_SEA, metro->unit_type);
              }
              // Else forget it.
           }
       }
      } // End else this is not my city
      break;
    case GOV_SEARCH:
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     // Only make a request if this is my city
     if( Gov->hist.TotalMyUnits < 1 )  {
         // Make an aircraft first off, then make ground forces.
         LastReq.priority = 20;
         LastReq.type = AI5_select_from_prefs
      (&AI5_CITY_SEARCH_FIRST, metro->unit_type);
     }
     else {
       // Make ground forces
       LastReq.priority = 15;
       LastReq.type = ARMOR;
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
      }
      break;
    case GOV_SUPPORT:
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     // Only make a request if this is my city
     // Make other stuff - Transports, aircraft, destryers + subs, etc.
          //  depending on whether the city is a PORT or not
     LastReq.priority = 1;  // Make the request very low priority so
     // it gets overridden easily by more needy Governors.
     if( type == GOV_PORT ) {
         LastReq.type = AI5_select_from_prefs
      ( &AI5_CITY_SUPPORT_SEA, metro->unit_type );
     }
     else {
         LastReq.type = AI5_select_from_prefs
      ( &AI5_CITY_SUPPORT_LAND, metro->unit_type );
     }
      }
      break;
    } // End switch statement
}


void  AI5_get_island_req( struct GovNode* Gov, struct City* metro,
      enum GovType type )
{
    switch (Gov->mode) {
    case GOV_TAKEN:
      // Hoo-boy we are in trouble now!  Can we find a city close enough
      //    to send Aircav?
      if( wishbook[AIRCAV].enabled == TRUE ) {
     if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <=
         wishbook[AIRCAV].range ) {
         LastReq.type = AIRCAV;
         LastReq.priority = 50;
     }
      }
      break;
    case GOV_DEFEND:
      // Lets make some aircraft to defend with if this is our city,
      //   else, order aircraft if close enough, else order ships.
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     LastReq.priority = 30;
     LastReq.type = AI5_select_from_prefs
       (&AI5_ISLE_DEF_OWN, metro->unit_type);
      }
      else {
     if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <=
         wishbook[FIGHTER].range ) {
         LastReq.type = AI5_select_from_prefs
      (&AI5_ISLE_DEF_AIR, metro->unit_type);
         LastReq.priority = 40;
     }
     else {
         if( type == GOV_PORT ) {
        LastReq.priority = 30;
        LastReq.type = AI5_select_from_prefs
          (&AI5_ISLE_DEF_SEA, metro->unit_type);
         }
     }
      }
      break;
    case GOV_SEARCH:
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     if( Gov->hist.TotalMyUnits < 1 )  {
         // Make an aircraft first off, then make AIRCAV if we can.
         LastReq.priority = 20;
         LastReq.type = AI5_select_from_prefs
      (&AI5_ISLE_SEARCH_FIRST, metro->unit_type);
     }
     else {
         LastReq.priority = 15;
         LastReq.type = AI5_select_from_prefs
      (&AI5_ISLE_SEARCH_OWN, metro->unit_type);
     }
      }
      else {
     // Ony ask for something if we are close enough to get it.
     if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <=
         wishbook[FIGHTER].range ) {
         LastReq.priority = 15;
         LastReq.type = AI5_select_from_prefs
      (&AI5_ISLE_SEARCH_AIR, metro->unit_type);
     }
      }
      break;
    case GOV_SUPPORT:
      if( (Gov->x == metro->col) && (Gov->y == metro->row) ) {
     // Only make a request if this is our city - makes sure we do
     //    something even if no one esle needs anything
     LastReq.priority = 1;  // of course, make it low pri so others
                            // override it easily.
     LastReq.type = AI5_select_from_prefs
       (&AI5_ISLE_SUPPORT, metro->unit_type);
      }
      break;
    }
}


void  AI5_get_transport_req( struct GovNode* Gov, struct City* metro,
      enum GovType type )
{
    switch (Gov->mode) {
    case GOV_ATTACK:
      // We need troops
      if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <= 25 ) {
     LastReq.priority = 30;
     LastReq.type = AI5_select_from_prefs
       (&AI5_TRANS_ATTACK, metro->unit_type);
      }
      break;
    case GOV_DEFEND:
      // We need escorts
      if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <= 25 ) {
     if( (type == GOV_PORT) || (type == GOV_ISLAND) ) {
         LastReq.priority = 30;
         LastReq.type = AI5_select_from_prefs
      (&AI5_TRANS_DEFEND, metro->unit_type);
     }
      }
      break;
    case GOV_OUTNUMBERED:
      // No request - we're on the run
      break;
    }
}


void  AI5_get_carrier_req( struct GovNode* Gov, struct City* metro,
      enum GovType type )
{
    switch (Gov->mode) {
    case GOV_ATTACK:
    case GOV_DEFEND:
      if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <= 25 ) {
     // Order up some more Destroyers for escorts, more planes, etc.
     if( (type == GOV_PORT) || (type == GOV_ISLAND) ) {
         LastReq.priority = 30;
         LastReq.type = AI5_select_from_prefs
      (&AI5_CARR_ATT_SEA, metro->unit_type);
     }
     else {
         LastReq.priority = 30;
         LastReq.type = AI5_select_from_prefs
      (&AI5_CARR_ATT_AIR, metro->unit_type);
     }
      }
      break;
    case GOV_OUTNUMBERED:
      // No request - we're on the run
      break;
    }
}


void  AI5_get_battleship_req( struct GovNode* Gov, struct City* metro,
      enum GovType type )
{
    switch (Gov->mode) {
    case GOV_ATTACK:
    case GOV_DEFEND:
      // Is the city in range and a PORT or ISLAND?
      if( (type == GOV_PORT) || (type == GOV_ISLAND) ) {
     if( AI5_GetDist( Gov->x, Gov->y, metro->col, metro->row ) <= 25 ) {
         // Order up some more Destroyers for escorts
         LastReq.priority = 30;
         LastReq.type = AI5_select_from_prefs
        (&AI5_BATT_ATTACK, metro->unit_type);
     }
      }
      break;
    case GOV_OUTNUMBERED:
      // No request - we're on the run
      break;
    }
}


int AI5_select_from_prefs( struct GovPrefs* prefs, short CurrProd )
{
    short     rand;
    int       i;

    rand = (short) (RangeRand(100L) + 1); // 1 to 100

    for (i=0; i < MAX_PREFS; i++) {
        // We have to make sure we can make this type of unit
        if (wishbook[prefs->type[i]].enabled == TRUE) {
            rand -= prefs->priority[i];
            if (CurrProd == prefs->type[i])
           rand -= CURRENT_PRODUCT_BONUS;
            if (rand <= 0) return (prefs->type[i]);
        }
        // Else, skip over - we can't build one in this game
    }

    DEBUG_AI5("Preferences Selection fell through - taking first one")
    return (prefs->type[0]);
}

/***************************************************************
*************** Path Finding Routines  *************************
***************************************************************/
#define REVERSE_DIRECTION(num)  ((num+3)%6)
void  AI5_CalcPath (short type, short orgx, short orgy, short destx,
      short desty, int rigor)
{
  int                i;
  short              targx, targy;
  int                Pickdir;
  long               NewCost;
  struct PathNode*   PNode = NULL;
  struct PathNode*   PNode2 = NULL;
  struct PathNode*   WalkNode;
  int                Found;
  // First, we initialize some stuff and check for input errors
  // Set up the globals
  Type = type;  // One less push and pop on the stack for getting cost
  //PathDiv = rigor;  // Dial up the precision required - 1 to 10
  if (rigor < 1) rigor = 1;
  if (rigor > 10) rigor = 10;
  Destx = destx;
  Desty = desty;
  // Clear the return values
  for( i=0; i<MAX_PATH; i++ )  Path[i] = -1;
  // Check for bad inputs
  if( (orgx >= width)||(orgx < 0)||(orgy >= height)||(orgy < 0) ) return;
  if( (destx >= width)||(destx < 0)||(desty >= height)||(desty < 0) ) return;
  // Now, check the direction map
  if( !PathMap ) {
    // Must be the first time this has been called
    // Allocate PathMap, set PathMapX and PathMapY, initialize the
    //    lists.
    PathMap = (int*) malloc( sizeof(int) * width * height );
    if( !PathMap ) return;  // Abort this!
    PathMapX = width;
    PathMapY = height;
    for(i=0; i< (width*height); i++)  PathMap[i] = -1;
  }
  if( (PathMapX != width) || (PathMapY != height) ) {
    // We have started a new game without exitting - the map changed
    PathMap = (int*) malloc( sizeof(int) * width * height );
    if( !PathMap ) return;  // Abort this!
    PathMapX = width;
    PathMapY = height;
    for(i=0; i< (width*height); i++)  PathMap[i] = -1;
  }
  // Initialize both lists, just to be sure we're starting good.
  NewList ((struct List*)&OpenList);
  NewList ((struct List*)&DoneList);

   // To begin, insert the starting node into the OpenList
  PNode = AllocVec( (long)sizeof(*PNode ), MEMF_CLEAR );
  if( !PNode ) return; // Abort!  Can't get memory!
  // We will start from the destination, so recording the path after
  //   will be easier.
  PNode->x = destx;
  PNode->y = desty;
  PNode->cost = 0;
  // Here we use the rigor to define how well to search for paths
  // Underestimating is best - makes us check more possible paths
  //   but it is slower.  Rigor goes from 1 to 10, with 1 being the
  //   most rigorous and 10 the least (it will settle on less optimal
  //   paths).
  PNode->eta = AI5_GetDist( orgx, orgy, destx, desty ) * 10 * rigor;
  AddHead((struct List *)&OpenList,(struct Node *)PNode);
  // Now, enter the while loop until we are done
  while( !emptylistP( &OpenList ) ) {
    // Change - make a new routine to get the best bet out of OpenList
    PNode = AI5_OpenListGetBest();
    // Put it in the DoneList - we are visiting it now
    AddTail((struct List*)&DoneList,(struct Node*)PNode);
    // Check for destination
    if( (PNode->x == orgx) && (PNode->y == orgy) )  break;
    // Not there yet, so let's look at the hexes around it
    // Pick a random direction to start with
    Pickdir = RangeRand( 6L ); // Gets us 0-5
    i = Pickdir; // To start us off on Pickdir
    do {
      // Get the hex in that direction
      if( AI1_calc_dir (i, PNode->x, PNode->y, &targx, &targy) != -1 ) {
       // Find the cost to get to the new hex
       NewCost = AI5_GetCost( PNode->x, PNode->y);
       // Can we even go here?
       if( NewCost < 0 ) {
          i++;
          if( i > 5 ) i=0;
          continue;
        }

       PNode2 = AllocVec( (long)sizeof(*PNode2 ), MEMF_CLEAR );
       // On memory problem, get out
       if( !PNode2 ) {
          i++;
          if( i > 5 ) i=0;
          continue;
        }
       PNode2->x = targx;
       PNode2->y = targy;
       PNode2->cost = PNode->cost + NewCost;
       // We use the *60 here to estimate that we will spend 60/hex
       PNode2->eta = AI5_GetDist( targx, targy, orgx, orgy )*10*rigor;

       // If not marked on the map already, mark it and place it in OpenList
       if( PathMap[ targy * width + targx ] == -1 ) {
         PathMap[ targy * width + targx ] = REVERSE_DIRECTION(i);
         AddTail( (struct List*)&OpenList, (struct Node*)PNode2 );
       }
       // else, try to find it in the OpenList, and replace it ifs cost
       //    is greater (took more to get there) and mark it again.
       else {
         Found = FALSE;
         WalkNode = (struct PathNode*)OpenList.mlh_Head;
         for(; WalkNode->pnode.mln_Succ; WalkNode =
          (struct PathNode*)WalkNode->pnode.mln_Succ) {
           if( (WalkNode->x == PNode2->x) && (WalkNode->y == PNode2->y) ) {
             // found the matching node
             if( WalkNode->cost > PNode2->cost ) {
              // replace it - classic extraction from a double linked list
             Remove( (struct Node*)WalkNode );
              FreeVec( WalkNode );
         //WalkNode = NULL; // Just to make sure
              Found = TRUE;
              AddTail( (struct List*)&OpenList, (struct Node*)PNode2 );
              // Mark the spot
             PathMap[ targy * width + targx ] = REVERSE_DIRECTION(i);
          goto AI5_CALCPATH_FOUND_MATCH;
             }
           }
         } // End for loop
         // if we didn't find it, forget it.
AI5_CALCPATH_FOUND_MATCH:
         if( Found == FALSE ) FreeVec( PNode2 );
          PNode2 = NULL; // Just to make sure.
       } // End else was already marked
      } // End if there is a hex in this direction
      // increment our direction
      i++;
      if( i > 5 ) i=0;
    } while( i != Pickdir); // End do-while loop of directions
  } // End while OpenList not empty

  PathLength = 0;
  PathCost = -1;
  // OK, now check that we have a path
  if( (PNode->x == orgx) && (PNode->y == orgy) &&
    (PNode->cost > 0) && (PNode->eta == 0) ) {
    // we found a path!
    // Record it.
    targx = orgx;
    targy = orgy;
    // And record the total cost of moving along the path
    PathCost = (int)PNode->cost;
    for(i=0; i<MAX_PATH; i++) {
      // Record the first steps
      Path[i] = PathMap[ targy * width + targx ];
      PathLength++;
      // Look!  This routine even works on its own parameters!
      if( AI1_calc_dir (Path[i], targx, targy, &targx, &targy) == -1 ) {
        break;
      }
      if( (targx == destx) && (targy == desty) ) {
        // we made it! exit!
        break;
      }
    }
  }
  // else nothing - we already cleared the path to nothing

  // Erase the marked up map for the next person
  for( WalkNode = (struct PathNode*)OpenList.mlh_Head; WalkNode->pnode.mln_Succ;
       WalkNode = (struct PathNode*)WalkNode->pnode.mln_Succ ) {
    PathMap[ WalkNode->y * width + WalkNode->x ] = -1;
  }
  // For debugging / timing count the nodes here - easier to see
  i = count_nodes( &OpenList );
  for( WalkNode = (struct PathNode*)DoneList.mlh_Head; WalkNode->pnode.mln_Succ;
       WalkNode = (struct PathNode*)WalkNode->pnode.mln_Succ ) {
    PathMap[ WalkNode->y * width + WalkNode->x ] = -1;
  }

  // Cleanup both lists
  nuke_list( &OpenList );
  nuke_list( &DoneList );

  // And, finally, we check for aircraft, and verify that we have enough
  //   fuel to reach the destination with a full tank.  User will have to
  //   check the path length vs. current fuel - this has to be able to do
  //   what-if calculations so we can't ask for a unit.
  if( (wishbook[Type].range > 0) && (wishbook[Type].range < PathLength ) ) {
      // Not enough fuel! Clear the path we got.
      PathLength = 0;
      for( i=0; i<MAX_PATH; i++ )  Path[i] = -1;
  }
  return;
}

// The deterrance factor to try and avoid stacking units when there is no
//   need (equal paths otherwise).  Try to avoid dangerous stacks of
//   units that are prime enemy targets.  Increase this later if it does
//   not work well enough. Started with 30 - increased to 60, maybe that
//   will do it.
#define STACKING_COST 60
long  AI5_GetCost( short orgx, short orgy)
{
  // Returns the cost to move into that hex, or -1 if it is not possible
  struct MapIcon*  icon = NULL;

  long cum_cost = movement_cost_table[Type][get(PLAYER.map, orgx, orgy)];
  if( (Type == RIFLE) || (Type == ARMOR) ) {
    // Check for roads
    if( get_flags(PLAYER.map, orgx, orgy)&ROAD ) cum_cost = 30;
  }

  // Check for units - friendly ones we want to try to avoid (less of
  //    a target if not stacked), or will have to if no stacking
  //    allowed.  Enemy units are always avoided (or should that be
  //    ignored?).  Ignored I guess - blast through if you have to!
  //    Changed! Now we will use the same deterence factor to try and
  //    avoid enemy units as well - we should, all things being equal.
  // Search through the player's icons for one located here
  // Lets do some more here - start with the cost for the terrain itself,
  //    then add for each icon found at that location - so that stacks
  //    of units are accounted for.
  for(icon=(struct MapIcon *)PLAYER.icons.mlh_Head;icon->inode.mln_Succ;
    icon = (struct MapIcon *)icon->inode.mln_Succ ) {
       if( (icon->col == orgx) && (icon->row == orgy) ) {
      if( icon->owner != player ) {
               // We assume that the player wants to avoid enemy cities
               //  otherwise, he would have headed for it directly.
               if( icon->type == CITY )  {
                  // Here's a little extra - an enemy city at the destination
                  // is OK - since we are specifically trying to get there.
                  if( (icon->col == Destx) && (icon->row == Desty) )
                    return (10);
                  else
                    return -1;
               }
          // else we have an enemy unit at that location.
          // Need to add a proviso here - don't give a positive cost
          // if we started with a negative one
               if( cum_cost > 0 ) cum_cost += STACKING_COST;
      }
      else {
               // Only costs 10 to enter a city - does end one's turn though.
               if( icon->type == CITY )  {
         // We want to reach a city at the destination always.
         if( (icon->col == Destx) && (icon->row == Desty) ) {
            return( 10 );
         }
         // Else, may not be at the destination.  So, try to avoid
         //  the city unless we waste a lot going around.  Only
         //  for aircraft types though, that can make lots of
         //  moves per turn (include destroyers too they move 3).
         if( (Type == DESTROYER) || (Type == FIGHTER) ||
             (Type == BOMBER) || (Type == AIRCAV) ) {
             return (120);
         }
         // Else
         return 10;
          }
          // Else, must be a unit there...
          if( !opt.stacking )  return( -1 );
          // else, add the stacking cost if we can move there
               if( cum_cost > 0 ) {
         cum_cost += STACKING_COST;
          }
          else {
         // We need to handle special cases here - we may be
         //  sending a ground unit to board a ship which is on
         //  water - we have to allow this.
         if( ((Type == ARMOR) || (Type == RIFLE) ) &&
             (icon->type == TRANSPORT) &&
             ((icon->col == Destx) && (icon->row == Desty)) ) {
             // We have a ground unit trying to get onto a
             //  transport.  So let him.
             return (10);
         }
          }
      } // End else icon is player's
   } // End if icon in this hex
  } // End for loop
  return( cum_cost );
}


#define Floor2(x) (((x) >= 0) ? ((x)>>1) : (((x)-1)>>1))
#define Ceil2(x) (((x) >= 0) ? (((x)+1)>>1) : ((x)>>1))
#define Sign(x) (((x) >= 0) ? (1) : (-1) )
// This next routine calculates distances between hexes.
long  AI5_GetDist( short orgx, short orgy, short destx, short desty)
{
  // Here's Amit's code for getting distance in a hexagonal grid laid
  //   out in a rectangular matrix - short and sweet.
  int x1 = orgx - Floor2(orgy);
  int y1 = orgx + Ceil2(orgy);
  int x2 = destx - Floor2(desty);
  int y2 = destx + Ceil2(desty);
  int dx = x2 - x1;
  int dy = y2 - y1;
  long dist, dist2, dest3;

  if( Sign(dx) == Sign(dy) ) {
    dist = (long) max( abs(dx),abs(dy));
  }
  else {
    dist = (long) abs(dx) + abs(dy);
  }
  if( !wrap ) return dist;

  // Now the code to handle the case of wrapping - this isn't going to
  //   be pretty
  // I'm doing it by taking the distance from the nearest edge (left or
  //   right, top or bottom) to get the separation between the two
  //   points in question, then calculate as normal.

  // Well, maybe not.  Let's see if we can do this by committee, by
  //   taking the best of three - the original one, a second done by
  //   adding width and height to the first coords, and a third done
  //   by adding width and height to the second coords.  I think the
  //   least of the three will be the best dist, and the lesser of
  //   the other two is the wrap distance.
}


struct PathNode* AI5_OpenListGetBest()
{
  // Note: This routine assumes that the OpenList is not empty - which
  //   should be valid when this is called.  This can be made "inline"
  //   in the AI5_CalcPath routine to speed us up a trifle.
  struct PathNode* WalkNode = (struct PathNode*)OpenList.mlh_Head;
  struct PathNode* Best = WalkNode;

  for( ; WalkNode->pnode.mln_Succ; WalkNode =
    (struct PathNode*)WalkNode->pnode.mln_Succ) {
    if( (WalkNode) && ((WalkNode->cost+WalkNode->eta)<(Best->cost+Best->eta)))
      Best = WalkNode;
  }
  // No need to give a list here - it doesn't need to know
  Remove( (struct Node*) Best );
  return Best;
}

/***************************************************************
*************** Action Routines  *******************************
***************************************************************/
void  AI5_set_gov_mode( struct GovNode* Gov )
{
  enum GovMode new_mode;
  struct Unit* unit;

  switch (Gov->type) {
  case GOV_CITY:
  case GOV_PORT:
  case GOV_ISLAND:
    // Start out with the most hopeful
    new_mode = GOV_SUPPORT;

    // If we don't have many units, stay in Search
    if(Gov->hist.TotalMyUnits < 6)
      new_mode = GOV_SEARCH;

    // Now, if we have enemy forces in the area, set to defend
    if(( Gov->hist.TotalEUnits > 0 ) || (Gov->hist.EnemyCounts[CITY] > 0) )
         new_mode = GOV_DEFEND;

    // Real bad news - if we don't even have our city, set TAKEN
    if ((Gov->type == GOV_CITY) || (Gov->type == GOV_PORT)
   || (Gov->type == GOV_ISLAND))
      /* Check to see if we still own our city */
      if (hex_owner(Gov->x, Gov->y) != player) new_mode = GOV_TAKEN;

    break;
  case GOV_TRANSPORT:
    // Start out most hopeful
    new_mode = GOV_ATTACK;
    if( Gov->hist.TotalEUnits > 0 )
      new_mode = GOV_DEFEND;
    if( Gov->hist.TotalEUnits > 5 )
      new_mode = GOV_OUTNUMBERED;
    unit = AI5_LocateUnit( Gov );
    if( (unit) && (unit->damage > 0) )
      new_mode = GOV_OUTNUMBERED;
    break;
  case GOV_CARRIER:
    // Start out most hopeful
    new_mode = GOV_ATTACK;
    if( Gov->hist.TotalEUnits > Gov->hist.TotalMyUnits )
      new_mode = GOV_DEFEND;
    if( Gov->hist.TotalEUnits > 2 * Gov->hist.TotalMyUnits )
      new_mode = GOV_OUTNUMBERED;
    unit = AI5_LocateUnit( Gov );
    if( (unit) && (unit->damage >= wishbook[unit->type].hitpoints / 3) )
      new_mode = GOV_OUTNUMBERED;
    break;
  case GOV_BATTLESHIP:
    // Start out most hopeful
    new_mode = GOV_ATTACK;
    if( Gov->hist.TotalEUnits > 5 )
      new_mode = GOV_OUTNUMBERED;
    unit = AI5_LocateUnit( Gov );
    if( (unit) && (unit->damage >= 2 * wishbook[unit->type].hitpoints / 3) )
      new_mode = GOV_OUTNUMBERED;
    break;
  } // End switch Gov->type

  // If we change modes, have all units await new orders
  if( new_mode != Gov->mode ) {
    Gov->mode = new_mode;
    // clear all orders
    AI1_clear_all_orders( Gov );
  }
  return;
}

struct Unit* AI5_LocateUnit( struct GovNode *Gov )
{
    int GovID, UnitID;
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    for (;unit->unode.mln_Succ;unit=(struct Unit*)unit->unode.mln_Succ) {
        // Check for the Main unit for this Governor
        if( (unit->owner == player) && (unit->name) ) {
       if( scanf( unit->name, "%ld %ld", &GovID, &UnitID ) >= 1 ) {
         if( GovID == Gov->ID ) {
      if((Gov->type == GOV_TRANSPORT)&&(unit->type == TRANSPORT)) {
        // we found it!
        return (unit);
      }
      if((Gov->type == GOV_CARRIER)&&(unit->type == CARRIER)) {
        // we found it!
        return (unit);
      }
      if((Gov->type == GOV_BATTLESHIP)&&(unit->type == BATTLESHIP)) {
        // we found it!
        return (unit);
      }
         }
       } // End if scanf worked
   }
    }      // End for loop
    return NULL;
}


void  AI5_play_turn( int new_units )
{
    int   MaxLooping = 5000;
    /* Here we may want to look around, give out some orders to units,
       and execute orders to units in a loop until we have done all the
       moves possible for the units.
       */
    AI5_do_all_histograms();
    AI5_give_orders();
    /* We'll add a little failsafe so we don't spend eternity here */
    while( (MaxLooping > 0) && (DoUnitActions(40,60)) )  MaxLooping--;
    if( MaxLooping <= 0 )
       DEBUG_AI5("Error: Exitting AI player's turn - out of actions!")
    return;
}


void  AI5_do_all_histograms()
{
    struct GovNode *Gov = (struct GovNode *)GovList.mlh_Head;
    /* First we update the picture for all the Governors */
    for ( ; Gov->gnode.mln_Succ; Gov = (struct GovNode *)Gov->gnode.mln_Succ)
   if (Gov->owner == player) {
       AI3_setup_area_of_interest( Gov, 6, 20 );
       AI1_do_one_histogram (Gov);
       AI5_set_gov_mode (Gov);
   }
    /* End for loop */
}


int  AI5_do_unit_actions()
{
        return 0;
}


/***************************************************************
*************** Reaction Routines  *****************************
***************************************************************/
int  AI5_recommend_action( struct Unit* unit, int OddsLimit, int LowOdds )
{
    /* This routine will evaluate a unit's surroundings and recommend
       a course of action - or no course of action. A "course of action"
       is quite literally that - what direction to move the unit in.

       What it will do is check all six hexes around the unit in question
       - looking for enemy units, cities, etc - then look at all six
       results and make the choice of what to do. Or do nothing if there
       are no enemy units or cities around.

       The OddsLimit is the minimum odds a player will want to go ahead
       with (i.e. to play it very safe a player may go with 60 or 70, and
       to be daring go with 30 or 40) - odds that he will win.

       LowOdds are the lowest odds we will go with to attack a low value
       target (i.e. to be daring is to pick 50 or 60, to be safe is to
       pick 75 or 80 or so), that is, attack an Infantry with a Battleship.
       The Battleship will win almost every time, but the Infantry has a
       finite, if very small, chance of winning as well.
       */
    int                i;
    short              targx, targy;
    struct  HexReport  neighbors[6];
    int                GainDiff = 0;
    int                BestDiff = 0;
    int                BestOdds = 0;
    int                InDanger = FALSE;
    int                Recommend = -1;  // None to start with


    /* Make sure the limits are OK */
    if( OddsLimit > 100 ) OddsLimit = 100;
    if( LowOdds < 0 )  LowOdds = 0;

    for( i=0; i<6; i++) {
   /* Fill in the raw data */
         if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
           AI5_evaluate_hex( unit, targx, targy, &neighbors[i] );
       }
    }

    /* Next, make sense of the six chunks of data */
    for( i=0; i < 6; i++ ) {
        // Can they attack us?
        if (neighbors[i].AtRisk)  InDanger = TRUE;
        if( neighbors[i].CanAttack ) {
       //  We might want to go with this one
       GainDiff = neighbors[i].Gain - neighbors[i].Risk;
       if( neighbors[i].Odds < OddsLimit )
           continue;  /* Too heavy odds */
       if( Recommend == -1 ) {
           // Go with this one for now if we have a minimal gain
           if( GainDiff >= 0 ) {
               Recommend = i;
              BestDiff = GainDiff;
                BestOdds = neighbors[i].Odds;
          }
          else {
              // GainDiff is negative - we are risking more than we
              //  can gain, so are the odds enough in our favor?
              if( neighbors[i].Odds > LowOdds ) {
                  Recommend = i;
                 BestDiff = GainDiff;
                    BestOdds = neighbors[i].Odds;
              }
          }
       }
       else {
           // Go with this if it is better
           if( GainDiff > BestDiff ) {
              BestDiff = GainDiff;
                BestOdds = neighbors[i].Odds;
              Recommend = i;
           }
          else {
                if( GainDiff == BestDiff ) {
                    // Check the odds - which one has higher?
                    if( neighbors[i].Odds > BestOdds ) {
                        BestDiff = GainDiff;
                        Recommend = i;
                        BestOdds = neighbors[i].Odds;
                    }
                }
              // Maybe it is less risky but still profitable ?
              else if( (GainDiff > 0) &&
                 (neighbors[i].Odds > neighbors[Recommend].Odds) ) {
                  BestDiff = GainDiff;
                  Recommend = i;
                    BestOdds = neighbors[i].Odds;
              } // End elseif GainDiff < BestDiff
          }
       } //End else we already have an existing recommendation
   } // End if can attack
    }  // end for loop
    if( Recommend != -1 )  return Recommend;

    if( (neighbors[5].TotalMyUnits > 1) && (InDanger == TRUE) ) {
       /* We have multiple units here - we MUST recommend a move
       as this makes us vulnerable - the enemy WILL attack 'cause
       they can take out a stack.
       */
       /* we need to select the best of the six, if any are valid */
        for( i=0; i < 6; i++ ) {
           if( neighbors[i].CanAttack ) {
               //  We might want to go with this one
               GainDiff = neighbors[i].Gain - neighbors[i].Risk;
              if( Recommend == -1 ) {
                // Go with this one for now
                   Recommend = i;
                BestDiff = GainDiff;
                    BestOdds = neighbors[i].Odds;
            }
              else {
                // Go with this if it is better
                  if( GainDiff > BestDiff ) {
                      BestDiff = GainDiff;
                     Recommend = i;
                        BestOdds = neighbors[i].Odds;
                  }
            } //End else we already have an existing recommendation
           } // End if can attack
      }// End for loop
   // That should give us SOMETHING
    }

    // If we STILL don't have anything, but we are in danger,
    //  then it's time to run!
    //  This needs to be added later.

    /* Default to recommending no action */
    return -1;
}


void  AI5_evaluate_hex( struct Unit* unit, short targx, short targy,
         struct HexReport* rep )
{
    /* For enemies, and for friendly units, we will use the unit list
       and pick out our own so we can get a full picture (with units
       on board other units, etc).
       */
    struct Unit* lookunit = (struct Unit *)unit_list.mlh_Head;
    struct City* metro = city_hereP (unit->col, unit->row);
    struct City* enemy_city = city_hereP (targx, targy);
    struct Unit* enemy = NULL;

    // Zero out all the fields in the report we are to ship back
    rep->TotalEUnits = 0;
    rep->TotalMyUnits = 0;
    rep->AtRisk = FALSE;
    rep->CanAttack = TRUE;
    rep->Gain = 0;
    rep->Risk = 0;
    rep->Odds = -1;

    // We need to check that the possible "enemy_city" is in fact an
    //    enemy city.
    if ((enemy_city)&&(enemy_city->owner==player))  enemy_city=NULL;

    for ( ;lookunit->unode.mln_Succ; lookunit = (struct Unit*)
      lookunit->unode.mln_Succ) {
       if(( lookunit->owner == player ) && (lookunit->col == unit->col ) &&
         ( lookunit->row == unit->row ) ) {
           // We have identified our units, but this will only have meaning
           //   if the enemy can attack us.  We use the unit list here instead
           //   of icons since we want to be sure we account for all our
           //   units, and loaded units or units in cities don't show as icons.
           rep->TotalMyUnits++;
           rep->Risk += AI5_unit_value( lookunit->type );
       } /* End if own unit in right spot */
       if(( lookunit->owner != player ) && (lookunit->col == targx) &&
         (lookunit->row == targy) && (lookunit->ship == NULL) &&
          (enemy_city == NULL) ) {
           //   Note: Exclude enemy units on ships - we 'can't see them'.
            //   Note2: Exclude enemy units in cities - we can't see them
            //      either.
           rep->TotalEUnits++;
           // can we attack? Assume we can, and cancel it if we cannot.
           if( !AI5_can_attack( unit->type, lookunit->type, targx, targy ) ) {
               rep->CanAttack = FALSE;
           }
           // can they attack us?
           if(AI5_can_attack(lookunit->type,unit->type,unit->col,unit->row)) {
               rep->AtRisk = TRUE;
           }
            else {
                // Check for a city
                if( (metro) &&
                  (AI5_can_attack(lookunit->type,CITY,unit->col,unit->row)) ) {
                        rep->AtRisk = TRUE;
                }
            }
           // What's the gain?
           rep->Gain += AI5_unit_value( lookunit->type );
       } // End if enemy unit in right spot
    } /* End for loop */
    // OK, now we handle the case where we didn't have any enemy units around
    if( rep->TotalEUnits <= 0 ) {
        rep->CanAttack = FALSE;
    }
    // If we have a city at our location, add that into the mix
    if( metro ) {
        rep->Risk += AI5_unit_value( CITY );
    }
    // And if there is an enemy city at the target, add that also
    if( enemy_city ) {
        rep->Gain += AI5_unit_value( CITY );
        if( AI5_can_attack(unit->type, CITY, targx, targy) ) {
            rep->CanAttack = TRUE;
            rep->TotalEUnits++;
        }
        else {
            rep->CanAttack = FALSE;
        }
    }
    // Now we figure the odds
    if( rep->CanAttack ) {
        if( enemy_city ) {
            if( enemy_city->owner == 0 ) {
                // Neutral cities don't play by the rules, so I have
                //  to wing it here
                rep->Odds = AI5_evaluate_odds
                    ( unit, RIFLE, targx, targy, player );
            }
            else {
                rep->Odds = AI5_evaluate_odds
                    ( unit, RIFLE, targx, targy, enemy_city->owner );
            }
            if( unit->type == BOMBER ) {
                // If we have a bomber, reduce the Gain by to 20% of the
                //   city's value - we don't want to encourage bombarding
                //   enemy cities to the exclusion of all else.
                rep->Gain -= (AI5_unit_value( CITY ) * 0.8);
            }
        }
        else {
            enemy = choose_defender(unit,targx,targy);
            if( enemy ) {
               rep->Odds = AI5_evaluate_odds
                   ( unit, enemy->type, targx, targy, enemy->owner );
            }
        } // End else no enemy city
    }
}


int  AI5_can_attack ( short attacker, short defender, short def_col, short def_row )
{
  // This is going to be a long laundry list of unit types, circumstances,
  //   etc. - mirroring the code in game_play1.c for attacking.
  short def_terrain = get( PLAYER.map, def_col, def_row );
  short def_road = get_flags( PLAYER.map, def_col, def_row ) & ROAD;
  switch( attacker ) {
        case RIFLE:
        case ARMOR:
        case MILITIA:
            // These three act the same
            switch( defender ) {
                // We can always attack ships (bombardment) unless they
                //   have air cover, but we resolve that elsewhere.
                case TRANSPORT:
                case DESTROYER:
                case CRUISER:
                case BATTLESHIP:
                case CARRIER:
                    return 1;
                    break;
                case MILITIA:
                case ARMOR:
                case RIFLE:
                    // We can always attack other ground troops - armor will
                    //   just bombard if it can't get there
                    return 1;
                    break;
                case CITY:
                case AIRBASE:
                    return 1;
                    break;
                case FIGHTER:
                case BOMBER:
                case AIRCAV:
                    // We can only attack these if we can go on it's
                    //   terrain.
                    if((movement_cost_table[attacker][def_terrain]>0)||def_road )
                        return 1;
                    else
                        return 0;
                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case FIGHTER:
            switch( defender ) {
                case MILITIA:
                case ARMOR:
                case RIFLE:
                case FIGHTER:
                case BOMBER:
                case AIRCAV:
                case TRANSPORT:
                case SUB:
                case DESTROYER:
                case BATTLESHIP:
                case CRUISER:
                case CARRIER:
                    // We can attack anyone
                    return 1;
                    break;
                default:
                    // Except cities, mines, airfields...
                    return 0;
                    break;
            }
            break;
        case BOMBER:
            switch( defender ) {
                case CITY:
                case AIRBASE:
                case MILITIA:
                case ARMOR:
                case RIFLE:
                case BOMBER:
                case AIRCAV:
                case TRANSPORT:
                case SUB:
                case DESTROYER:
                case BATTLESHIP:
                case CRUISER:
                case CARRIER:
                    // We can attack anyone
                    return 1;
                    break;
                default:
                    // Except fighters, mines
                    return 0;
                    break;
            }
            break;
        case AIRCAV:
            switch( defender ) {
                case CITY:
                case AIRBASE:
                case MILITIA:
                case ARMOR:
                case RIFLE:
                case BOMBER:
                case AIRCAV:
                case TRANSPORT:
                case SUB:
                case DESTROYER:
                case BATTLESHIP:
                case CRUISER:
                case CARRIER:
                    // We can attack anyone
                    return 1;
                    break;
                default:
                    // Except mines
                    return 0;
                    break;
            }
            break;
        case TRANSPORT:
        case DESTROYER:
        case SUB:
        case CARRIER:
            switch( defender ) {
                // We can always attack ships
                case TRANSPORT:
                case DESTROYER:
                case CRUISER:
                case BATTLESHIP:
                case CARRIER:
                    return 1;
                    break;
                case RIFLE:
                case ARMOR:
                case MILITIA:
                    // We cannot attack ground units
                    return 0;
                    break;
                case FIGHTER:
                case BOMBER:
                case AIRCAV:
                    // We can attack these if we can go there
                    if( movement_cost_table[ attacker ][ def_terrain ] > 0 )
                        return 1;
                    else
                        return 0;
                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case CRUISER:
        case BATTLESHIP:
            switch( defender ) {
                // We can always attack ships
                case TRANSPORT:
                case DESTROYER:
                case CRUISER:
                case BATTLESHIP:
                case CARRIER:
                    return 1;
                    break;
                case RIFLE:
                case ARMOR:
                case MILITIA:
                    // We can always bombard ground units
                    return 1;
                    break;
                case FIGHTER:
                case BOMBER:
                case AIRCAV:
                    // for aircraft we need to make sure we
                    //  can go there.
                    if( movement_cost_table[ attacker ][ def_terrain ] > 0 )
                        return 1;
                    else
                        return 0;
                    break;
                default:
                    return 0;
                    break;
             }
            break;
        default:
            // Covers city, airbase, mine, etc.
            // They can never attack.
            return 0;
            break;
  }
  // Should never get here unless I slip a case
  return 0;
}


int  AI5_unit_value ( short type )
{
    int value = 0;
    /* For now we will keep the value equal to the amount of effort
       needed to build one of them.  This can be expanded later to
       take different production efficiencies into account (since
       if your enemy can make something 'cheaper' than you can, it
       will not be as valuable to him as it is to you - e.g. if you
       both have an ARMOR unit, and his only tool him 8 turns to
       make rather than the 12 it took you, his ARMOR unit means
       less to him - is more quickly replaced - than yours)as well
       as other factors I haven't thought of yet.
       */
    if (type == CITY) return 10000;

    value = wishbook[type].build;
    /* Add extra amounts to Transport and Carrier to reflect 1/2 load
       of the most expensive units each can hold.
       */
    if (type == CARRIER) value += 2 * wishbook[ARMOR].build;
    if (type == TRANSPORT) value += 4 * wishbook[FIGHTER].build;
    return (value);
}


int  AI5_evaluate_odds ( struct Unit* unit, short type, short x, short y,
          int enemy_player)
{
    /* This returns the chances out of 100 that we will win in an
       attack (i.e. the odds we will be left and the enemy unit will be
       destroyed) - a 99 would be almost certain victory, while a 5 would
       be almost certain destruction.  NOTE: my methods here may not be
       statistically or mathematically correct, but should give an
       interesting result anyway.
       */
    /* This needs to take into account the attack efficiencies of both
       players, the damages to this players unit (if any), the terrain
       factors (if any), and whether the attack can take place at all.
       */

    struct Unit Enemy;  // A dummy enemy unit for using the
                         //NCS_combat_mods routine
    int     att_value,  def_value;
    double  att_to_hit, def_to_hit;
    double  results;
    //double  att_hit_percentage, def_hit_percentage;
    static  int strength[] = { 1, 1, 1, 2, 1, 1, 3, 1, 2, 3, 1, 1 };

    /*
         strength is the amount of damage a hit from the unit does
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

    // Can we attack at all?  If not, return -1
    if( !AI5_can_attack( unit->type, type, x, y ) )  return -1;

    /* First, let's get the raw numbers on the combat */

    /* But before we do that we need to create a 'dummy' unit to use
       in our call to the NCS routine. */
    Enemy.type = type;
    Enemy.col = x;
    Enemy.row = y;
    Enemy.owner = enemy_player;
    Enemy.name = NULL;
    Enemy.orders = NULL;

    NCS_combat_mods( unit, &Enemy, &att_value, &def_value );

    // Let's limit these so we don't crash anything
    if( att_value < -8 ) att_value = -8;
    if( att_value > 8 ) att_value = 8;
    if( def_value < -8 ) def_value = -8;
    if( def_value > 8 ) def_value = 8;
    /* Now, we can get an idea of the chance for each to hit the other
       each round. */
    //att_hit_percentage = 51 + ( att_value * 6.25);
    //def_hit_percentage = 51 + ( def_value * 6.25);
    // These will be numbers from 1 to 101 at the extremes.

    // Now we need to ratio them, as only the relative is used (someone
    //   always hits someone every 'round' of combat)
    //att_to_hit = att_hit_percentage/(att_hit_percentage + def_hit_percentage);
    //def_to_hit = def_hit_percentage/(att_hit_percentage + def_hit_percentage);
    att_to_hit = AI5_CalcOddsAdjust( att_value - def_value );

    // Now we call my handy-dandy recursive odds calculating routine
    results = AI5_CalcWinOdds( 1.0, // was 1.0
        (wishbook[unit->type].hitpoints - unit->damage),
        (wishbook[type].hitpoints), strength[unit->type],
        strength[type], att_to_hit);

    /* As a check, these two should sum to 1.0 +/- a trifle. WARNING -
       if the defender to hit chance is zero we are in trouble as we'll
       divide by zero in a moment. */
    //if( def_to_hit == 0.0 ) return 100; /* No chance to lose */
    //if( att_to_hit == 0.0 ) return 0; /* No chance to win */

    /* Next, using those numbers we find out a number of rounds each needs
       to kill the other based on their to-hit chance, the amount of damage
       each does with a hit, and the hits it takes to kill each one */
    //att_rtk = ((float)wishbook[type].hitpoints) / (att_to_hit *
   //      ((float)strength[unit->type]) );
    //def_rtk = ((float)(wishbook[unit->type].hitpoints - unit->damage)) /
   //       (def_to_hit * ((float)strength[type]) );
    /* Here we gave the enemy the benefit of the doubt and count him at full
       strength, and for our unit be realistic and use our current hits.
       */

    /* Return the chance we have to LOSE the fight, expressed as a ratio
       of the attackers rounds to kill over the total - should go from
       a limit of 99 down to 0. */
    // for example, if it will take the enemy 16 rounds to kill us (say we
    //   are a carrier), and it takes 4 rounds for us to kill them (they
    //   are a fighter) all things being equal, then we return 16/(16+4) *100
    //   = 80, or an 80% chance to win.
    return ( (int) (results * 100.0) );
}

double   AI5_CalcWinOdds( double Prob, int Hits, int EHits,
   int Damage, int EDamage, double ToHit)
{
   double Win;
   double Lost;
   // This is done from the point of view of the attacker
   // If we are dead, we lost - return 0.  If the enemy is
   //   dead we win, so return 1.0
   if( Hits <= 0 ) return 0.0;
   if( EHits <= 0 ) return (1.0); // tried 1.0 * ToHit
   // Now we call the routine recursively to get the results of
   //   our winning and losing this round.
   Win = Prob * ToHit * AI5_CalcWinOdds  // Tried taking out the *ToHit
      ( Prob, Hits, (EHits - Damage), Damage, EDamage, ToHit );
        // Was Prob*ToHit in call
   Lost = Prob * (1.0 - ToHit) * AI5_CalcWinOdds // Tried taking out *(1.0-ToHit)
      ( Prob, (Hits - EDamage), EHits, Damage, EDamage, ToHit );
        // Was Prob*(1.0-ToHit) in call
   return (Win + Lost);
}

double  AI5_CalcOddsAdjust( int att_adj )
{
    switch (att_adj * 2) {  // I think the *2 will more accurately show odds
        case 15:
            return 0.9975;
        case 14:
            return 0.9954;
        case 13:
            return 0.9885;
        case 12:
            return 0.9815;
        case 11:
            return 0.9676;
        case 10:
            return 0.9537;
        case 9:
            return 0.9306;
        case 8:
            return 0.9075;
        case 7:
            return 0.8727;
        case 6:
            return 0.8380;
        case 5:
            return 0.7890;
        case 4:
            return 0.7401;
        case 3:
            return 0.6825;
        case 2:
            return 0.6250;
        case 1:
            return 0.5625;
        case 0:
            return 0.5000;
        case -1:
            return 0.4375;
        case -2:
            return 0.3750;
        case -3:
            return 0.3170;
        case -4:
            return 0.2590;
        case -5:
            return 0.2105;
        case -6:
            return 0.1620;
        case -7:
            return 0.1273;
        case -8:
            return 0.0926;
        case -9:
            return 0.0695;
        case -10:
            return 0.0463;
        case -11:
            return 0.0324;
        case -12:
            return 0.0185;
        case -13:
            return 0.0115;
        case -14:
            return 0.0046;
        case -15:
            return 0.0023;
        default:
            if(att_adj >= 16)  return 1.0;
            else  return 0.0;
    }
}


/***************************************************************
*************** Decision Routines  *****************************
***************************************************************/



void  AI5_give_orders( )
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
           // Issue orders depending on the Governor type
           switch( Gov->type ) {
        case GOV_CITY:
          AI5_city_orders( Gov, unit );
          break;
        case GOV_PORT:
          AI5_port_orders( Gov, unit );
          break;
        case GOV_ISLAND:
          AI5_island_orders( Gov, unit );
          break;
        case GOV_TRANSPORT:
          AI5_transport_orders( Gov, unit );
          break;
        case GOV_CARRIER:
          AI5_carrier_orders( Gov, unit );
          break;
        case GOV_BATTLESHIP:
          AI5_battleship_orders( Gov, unit );
          break;
      }
       }
       else {
           AI5_default_orders( unit );
       }
   }
    // End for loop
}


void AI5_city_orders( struct GovNode* Gov, struct Unit* unit )
{
    struct GovNode* Gov2;
    struct MapIcon* icon;
    switch (Gov->mode) {
       case GOV_SUPPORT:
     // Here we want to evaluate the situation and load units to
     //  other Govs if they are in need (and close enough).
          switch( unit->type ) {
        case RIFLE:
          break;
        case ARMOR:
          break;
        case FIGHTER:
          break;
        case BOMBER:
          break;
        case AIRCAV:
          break;
        default:
            break;
     }
          break;
       case GOV_SEARCH:
     // We want to scout around us - find new cities to conquer
          switch( unit->type ) {
        case RIFLE:
          //break  Fall through
        case ARMOR:
          /* Let's do some self preservation - check if we are hurt */
          if( unit->damage > 0 ) {
       /* We're damaged - head for home to get repaired */
       AI4_computer_give_orders
         ( unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, 10 );
          }
          else {
       /* let's try to find something! */
       if( RangeRand(10L) >= 5 )
         AI4_computer_give_orders
           (unit, C_ORDER_RANDOM, -1, -1, -1, -1, -1);
       else {
         if( RangeRand(10L) >= 5 )
           AI4_computer_give_orders
             (unit, C_ORDER_WALK_COASTLINE, 0, 0, -1, -1, 0);
         else
           AI4_computer_give_orders
             (unit, C_ORDER_WALK_COASTLINE, 0, 0, -1, -1, 1);
       }
          }
          break;
        case FIGHTER:
          //break;  Fall through
        case BOMBER:
          /* Let's go exploring */
          if( (unit->col == Gov->x) && (unit->row == Gov->y) ) {
       AI4_computer_give_orders
         (unit, C_ORDER_RECON, -1, -1, Gov->x, Gov->y, -1 );
          }
          else {
       /* return for fuel */
       AI4_computer_give_orders
         (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, unit->fuel);
          }
          break;
        case AIRCAV:
          /* Except for AirCav - put them in storage until needed */
          if( city_hereP( unit->col, unit->row ) != NULL ) {
       /* We are in a city, so go to sentry */
       AI4_computer_give_orders
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
           AI4_computer_give_orders
             (unit, C_ORDER_GOTO, Gov2->x, Gov2->y,
         -1, -1, unit->fuel);
         }
         else {
           /* Now what ?  Try to take an enemy city of course ..*/
           icon = AI3_FindClosestEnemyCity( unit, unit->fuel );
           if( icon ) {
             /* Go get it! */
             AI4_computer_give_orders
          (unit, C_ORDER_GOTO, icon->col, icon->row,
           -1, -1, unit->fuel);
           }
           else {
             /* How can this be?  Why are we out here? We never
           leave the nest unless attacking a city. */
             DEBUG_AI5
          ("AirCav movement problem - can't reach any city")
           }
         }
       }
       else {
         /* go home */
         AI4_computer_give_orders
           (unit, C_ORDER_GOTO, Gov->x, Gov->y, -1, -1, unit->fuel);
       }
          }
          break;
        default:
            break;
     }
     break;
       case GOV_DEFEND:
     // We have enemy units or cities nearby - go after them.
          switch( unit->type ) {
        case RIFLE:
          break;
        case ARMOR:
          break;
        case FIGHTER:
          break;
        case BOMBER:
          break;
        case AIRCAV:
          break;
        default:
            break;
     }
     break;
       case GOV_TAKEN:
     // We lost our city.  Try to retake it.
          switch( unit->type ) {
        case RIFLE:
          break;
        case ARMOR:
          break;
        case FIGHTER:
          break;
        case BOMBER:
          break;
        case AIRCAV:
          break;
        default:
            break;
     }
     break;
       default:
     break;
    }
}

void AI5_port_orders( struct GovNode* Gov, struct Unit* unit )
{
    switch (Gov->mode) {
       case GOV_SUPPORT:
          break;
       case GOV_SEARCH:
     break;
       case GOV_DEFEND:
     break;
       case GOV_TAKEN:
     break;
       default:
     break;
    }
}

void AI5_island_orders( struct GovNode* Gov, struct Unit* unit )
{
    switch (Gov->mode) {
       case GOV_SUPPORT:
          break;
       case GOV_SEARCH:
     break;
       case GOV_DEFEND:
     break;
       case GOV_TAKEN:
     break;
       default:
     break;
    }
}

void AI5_transport_orders( struct GovNode* Gov, struct Unit* unit )
{
    switch (Gov->mode) {
       case GOV_ATTACK:
     break;
       case GOV_DEFEND:
     break;
       case GOV_OUTNUMBERED:
     break;
       default:
     break;
    }
}

void AI5_carrier_orders( struct GovNode* Gov, struct Unit* unit )
{
    switch (Gov->mode) {
       case GOV_ATTACK:
     break;
       case GOV_DEFEND:
     break;
       case GOV_OUTNUMBERED:
     break;
       default:
     break;
    }
}

void AI5_battleship_orders( struct GovNode* Gov, struct Unit* unit )
{
    switch (Gov->mode) {
       case GOV_ATTACK:
     break;
       case GOV_DEFEND:
     break;
       case GOV_OUTNUMBERED:
     break;
       default:
     break;
    }
}

void AI5_default_orders( struct Unit* unit )
{
}

/***************************************************************
*************** Orders Routines  *******************************
***************************************************************/


void AI5_command_goto( struct Unit* unit )
{
}
