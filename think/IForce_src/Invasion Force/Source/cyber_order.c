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
	cyber_order.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with AI order execution.
*/


#include "global.h"
extern short Type;
void MoveUnitDir( struct Unit*, enum Direction );

int
DoUnitActions( int HighOdds, int LowOdds )
{
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    int         Done = TRUE;
    static struct Unit* lastunit = NULL;
    static int    times_accessed = 0;
    int           attack_dir;
    char          my_buf[120];
    char          play_buf[40] = "";
    char          name_buf[60] = "";
    char          ord_buf[60] = "";
    char          ord_buf2[20] = "";

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

		    // AI information
		    switch( AIDataFlag ) {
		    case 5:
		      // Scroll display to unit and show it
              if (need_to_scrollP(unit->col,unit->row)) {
                  int ox=xoffs, oy=yoffs;
                  set_display_offsets(unit->col,unit->row);
                  GP_smart_scroll(ox,oy);
              }
              start_blinking_unit(unit);
              //plot_icon(unit->type,unit->col,unit->row,
              //    roster[unit->owner].color, ORDER_NONE, 0);
              unit_status_bar(unit);
		      //  A deliberate fall-through
		    case 4:
		      // Add orders
		      if( unit->orders ) {
			switch( unit->orders->reserved ) {
			  case C_ORDER_GOTO:
			    sprintf( ord_buf, "- Orders: Goto %ld,%ld",
				 unit->orders->destx, unit->orders->desty);
			    break;
			  case  C_ORDER_RANDOM:
			    sprintf( ord_buf, "- Orders: Go Random" );
			    break;
			  case  C_ORDER_HUNT:
			    sprintf( ord_buf, "- Orders: Hunting" );
			    break;
			  case  C_ORDER_RECON:
			    sprintf( ord_buf, "- Orders: Recon to %ld, %ld",
				 unit->orders->destx, unit->orders->desty);
			    break;
			  case  C_ORDER_WALK_COASTLINE:
			    sprintf( ord_buf, "- Orders: Walk Coastline" );
			    break;
			}
		      } // End if tell orders too
		      if( (unit->type == FIGHTER) ||
			  (unit->type == BOMBER) ||
			  (unit->type == AIRCAV) ) {
			  sprintf( ord_buf2, "- Fuel: %ld", unit->fuel );
			  strcat( ord_buf, ord_buf2 );
		      }
		      // deliberate fall-through
		    case 3:
		      // Add unit types and names
		      if( unit->name ) {
			sprintf( name_buf, "%s %s", 
				 UnitString[unit->type],unit->name );
		      }
		      else {
			sprintf( name_buf, "a %s",
				 UnitString[unit->type] );
		      }
		      // The general information
		      sprintf( play_buf, 
			       "Player %ld (AI type %ld)", 
			       player, PLAYER.aggr );
		      // print out the message
		      sprintf( my_buf, "%s %s %s", play_buf, name_buf, 
			       ord_buf );
		      // Show the unit being processed.
		      tell_user2( my_buf, FALSE, NULL );
		      break;
		    case 2:
		      // Do Nothing
		      // Deliberate fall-through
		    case 1:
		      // Do Nothing
		      // Deliberate fall-through
		    default: // 0
		      // Do nothing
		      break;
		    } // End switch

    		/* Take a look around us and react to enemy units + cities */
    		/* New for this version - let's use the recommend action
	    	   routine. */
		    attack_dir = AI5_recommend_action(unit,HighOdds,LowOdds);
		    if( attack_dir != -1 ) {
		        MoveUnitDir( unit, attack_dir );
		        return (FALSE);
		    }
		    /* if we have orders, execute them */
    		if (unit->orders != NULL) {
	    	    ExecuteStandingOrder(unit);
    		    return (FALSE);
    		}
	    	else {
		        DEBUG_AI("No orders, no enemy around to attack.")
		        // We have no orders, so have the AI make some 
		        // new orders
		        AIAddLib( unit );
                return (FALSE);
     		} /* End else figure something out */
	    } /* End if the unit is not the same one we accessed 10 times */
	    else {
	    	/* Last unit IS this unit and times accessed >= 10. */
	        /* This should ensure that we never get stuck forever - we
		        will always finish - removes a potential infinite loop
		        when there are TWO units without any moves.  Without
		        this the loop will ping pong between them forever. */
	        unit->move -= 60;
            if( unit->move < 0 ) unit->move = 0;
            
	        if( (unit->type==FIGHTER) || 
		    (unit->type==BOMBER) ||
		    (unit->type==AIRCAV) ) {
		        unit->fuel--;
		        if( unit->fuel <= 0 ) Remove ((struct Node*)unit);
	        }		  
	        times_accessed = 0;
	        lastunit = NULL;
	    }
    } /* End if we own unit and it has moves left */
    /* End for loop */    
    times_accessed = 0;
    lastunit = NULL;
    return (Done);
}


void
ExecuteStandingOrder( struct Unit *unit )
{
    if ((unit->orders == NULL) || (unit->orders->type != ORDER_NONE)) {
	DEBUG_AI("Big problem in execute_standing_order - no orders!")
	sprintf (outbuf, "%s %s has no standing orders to execute - aborting",
		 UnitString[unit->type], unit->name);
	DEBUG_AI(outbuf)
	return;
    }
    
    switch (unit->orders->reserved) {
        case C_ORDER_GOTO:
            CommandGoto(unit);
	    break;
        case  C_ORDER_RANDOM:
            CommandRandom(unit);
            break;
        case  C_ORDER_HUNT:
    	    CommandHunt(unit);
	    break;
        case  C_ORDER_RECON:
            CommandRecon(unit);
            break;
        case  C_ORDER_WALK_COASTLINE:
	    CommandWalkCoastline( unit );
	    break;
        default:
            DEBUG_AI("Unknown command type found in execute_standing_order!")
            break;
    }
    return;
}


void
CommandGoto( struct Unit* unit )
{
  // Check the orders for the destination
  if( (unit->col == unit->orders->destx) && 
      (unit->row == unit->orders->desty) ) {
      // Clear the orders
      clear_orders( unit );
  }
  else {
      // If we are not at the destination, can we get there?
      AI5_CalcPath( unit->type, unit->col, unit->row, unit->orders->destx,
		    unit->orders->desty, AI5_PATH_GOOD );
      if( Path[0] >= 0 ) {
	  // Check aircraft for fuel
	  if( (wishbook[ unit->type ].range > 0) && PathLength > unit->fuel ) {
	      // We have an aircraft and it can't make it
	      clear_orders( unit );
	  }
	  else {
	      // If so, take the first step.
	      MoveUnitDir( unit, Path[0] );
	      return;
	  }
      }
      else {
	  clear_orders( unit );
      }
  }
  return;
}


void
CommandRandom( struct Unit* unit )
{
  // Check that we have a space we can move into ahead of us
  short targx, targy;
  int newrand;
  int ret = AI1_calc_dir( (enum Direction)unit->orders->etc, unit->col, 
			  unit->row, &targx, &targy);
  if( ret != -1 ) {
    Type = unit->type;  // Need to use this global variable to talk to
                        //  AI5_GetCost
    // The space exists on the map, can we move there?
    if( AI5_GetCost(targx, targy) > 0 ) {
      // Make the move
      MoveUnitDir( unit, (enum Direction)unit->orders->etc );
      return;
    }
  }
  // If we are here, we couldn't move in that direction
  newrand = unit->orders->etc;
  // if we can't move, pick a different direction
  while( newrand == unit->orders->etc ) {
    newrand = (int) RangeRand( 6L );
  }
  unit->orders->etc = newrand;
}


void
CommandHunt( struct Unit* unit )
{
  // We need to find the closest enemy unit within unit->orders->etc
  //   of this unit that we can reach, then take a step towards him
  struct MapIcon* closest = FindClosestEnemyIcon( unit, unit->orders->etc );
  if( closest ) {
    // recalculate a path to get there
    AI5_CalcPath( unit->type, unit->col, unit->row, closest->col,
		  closest->row, AI5_PATH_GOOD );
    if( Path[0] != -1 ) {
      // Take a step
      MoveUnitDir( unit, Path[0] );
      return;
    }
  }
  // Can't find anyone to hunt!
  clear_orders( unit );
  return;
}

struct MapIcon* FindClosestEnemyIcon( struct Unit* unit, int limit )
{
    int  closest = BIG_NUMBER;
    int  i;
    struct MapIcon *closestEnemy = NULL;
    struct MapIcon *icon = (struct MapIcon *) PLAYER.icons.mlh_Head;

    for (; icon->inode.mln_Succ; icon = (struct MapIcon *) 
      icon->inode.mln_Succ) {
        if( (icon->owner != player) && (icon->type != CITY) ) {
	    i = AI5_GetDist( unit->col, unit->row, icon->col, icon->row );
	    // Check on a path to get there
	    AI5_CalcPath( unit->type, unit->col, unit->row, icon->col,
			  icon->row, AI5_PATH_GOOD );
	    if( (i < limit) && (i < closest) && (Path[0] != -1) ) {
		closest = i;
		closestEnemy = icon;
	    }
	}
    }
    return( closestEnemy );
}


void
CommandRecon( struct Unit* unit )
{
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
    // Have we reached the destination?
    if( (unit->orders->destx == unit->col) && 
	(unit->orders->desty == unit->row) ) {
      // We have reached the destination, but is it the final one?
      // If so, clear orders and return, otherwise, put in the new
      //    destination for our second leg
      if( (unit->orders->destx != unit->orders->orgx) ||
	  (unit->orders->desty != unit->orders->orgy) ) {
	      unit->orders->destx = unit->orders->orgx;
	      unit->orders->desty = unit->orders->orgy;
	      unit->orders->etc = unit->fuel;
      }
      else {
	  clear_orders( unit );
	  return;
      }
    }
    // Take a step towards our goal
    AI5_CalcPath( unit->type, unit->col, unit->row, unit->orders->destx,
		  unit->orders->desty, AI5_PATH_GOOD );
    if( Path[0] == -1 ) {
        // Can't get there
        clear_orders( unit );
        return;
    }
    MoveUnitDir( unit, Path[0]);
}



void
CommandWalkCoastline( struct Unit* unit )
{
    /* This command will cause the unit (hopefully a ground or naval
       unit) to walk along the coastline, either clockwise (etc = 0)
       or counterclockwise (etc != 0).  Useful for exploring.
       Current direction to start from is kept in destx. The space 
       we started from is kept in orgx, orgy - when we move and end
       up back there we have completed the walk.
       */
    short targx, targy;
    int   current;
    int   new_dir = unit->orders->destx;
    int   result;

    if( (unit->orders->destx < 0) || (unit->orders->destx > 5) ) {
    	clear_orders( unit );  /* Problem */
	return;
    }
    // Now, figure out the next step to take
    Type = unit->type; // Set a global to talk to the GetCost routine
    current = AI1_calc_dir( new_dir, unit->col, unit->row, &targx, &targy);
    while( ( current != -1) && ( AI5_GetCost( targx, targy ) > 0 ) ) {
        if( unit->orders->etc )
	        new_dir++;
    	else
	        new_dir--;
    	/* Wrap around the directions */
	if( new_dir > 5 ) new_dir = 0;
    	if( new_dir < 0 ) new_dir = 5;
	/* Check that we haven't come full circle and gotten nowhere */
    	if( new_dir == unit->orders->destx )  {
	    clear_orders( unit );
	    return;
	}
	current = AI1_calc_dir( new_dir, unit->col, unit->row, &targx, &targy);
    } // End while
    // Record the new direction (or the old one if we didn't change it.
    unit->orders->destx = new_dir;

    // And, finally, take the step
    MoveUnitDir( unit, new_dir );
    return;
}


void
ComputerGiveOrders( struct Unit* unit, int suborder, short destx,
		    short desty, short orgx, short orgy, int etc )
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
	    /* Standard stuff only */
            break;
      case C_ORDER_RECON:
	    order->etc = wishbook[unit->type].range / 2 - 1;
	    break;
      case C_ORDER_RANDOM:
	    /* We need to make sure we have a valid initial direction */
	    if( (order->etc > 5) || (order->etc < 0) )
	      order->etc = (int) RangeRand( 6L );
	    break;
      case C_ORDER_HUNT:
	    /* Standard stuff only */
	    break;
      case C_ORDER_WALK_COASTLINE:
	    /* etc contains clockwise or counter-clockwise */
	    order->destx = 0; /* Initial direction */
	    order->orgx = unit->col;
	    order->orgy = unit->row;
	    break;
      case C_ORDER_SENTRY:
	    /* Standard stuff only */
	    break;
      }
   }
}


void
AIAddLib( struct Unit* unit )
{
    switch( PLAYER.aggr ) {
      // Do not include cases for AI1 and AI2 - the default action is
      //   enough
      case 3: {
	    AI3_orders_for_unit( unit );
	    break;
      }
      case 4: {
	    AI4_orders_for_unit( unit );
	    break;
      }
      default: {
	    // This used to be in the DoUnitActions routine
	    /* Just skip this unit this turn - the 
	        governor will give new orders next turn. */
	    if( (unit->type==FIGHTER) || 
	        (unit->type==BOMBER) ||
	        (unit->type==AIRCAV) ) {
	        unit->fuel -= unit->move / 60;
	        unit->move = 0;
	        if( unit->fuel <= 0 ) Remove ((struct Node*)unit);
	        return;
	    }
	    unit->move = 0;
	    break;
      }
    }
}


void
MoveUnitDir( struct Unit* unit, enum Direction dir )
{
    short x, y;
    int result = AI1_calc_dir( dir, unit->col, unit->row, &x, &y );
    if( AIDataFlag >= 5 ) {
        restore_hex_graphics(unit->col,unit->row,0);        
    }
    move_unit_dir( unit, dir );
    if( (result != -1) && (AIDataFlag >= 5) )
        GP_update_hex_display( x, y );
}
