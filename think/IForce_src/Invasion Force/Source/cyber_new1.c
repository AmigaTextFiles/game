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
	cyber_new1.c -- artificial intelligence module for Empire II
	This is the second iteration of it.  For "Neutral" players

*/

/* This file contains all the routines associated with AI Type #1A.
*/

#include "global.h"


/***************************************************************
*************** Orders Routines      ***************************
***************************************************************/

void  New_AI1_play_turn ( int new_units )
{
    int   MaxLooping = 1000;
    /* Here we may want to look around, give out some orders to units,
       and execute orders to units in a loop until we have done all the 
       moves possible for the units.
       */
    AI1_do_all_histograms();
    New_AI1_give_orders();
    /* We'll add a little failsafe so we don't spend eternity here */
    while( (MaxLooping > 0) && (!DoUnitActions(40,60)) )  MaxLooping--;
    if( MaxLooping <= 0 ) 
	DEBUG_AI("Error!! Exitting AI player's turn - out of actions")
    return;
}


void  New_AI1_give_orders()
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
	    /* sprintf(outbuf, "Giving initial orders to unit named %s at %ld,%ld", 
               unit->name, unit->col, unit->row);
               DEBUG_AI(outbuf)
	       */
            Gov = AI1_FindOwner (unit);
            if (Gov != NULL) {
		if( IsCityTaken( Gov ) ) {
		    /* Have the unit move to the city's location */
		    ComputerGiveOrders (unit, C_ORDER_GOTO, Gov->x, 
					      Gov->y, -1, -1, -1);
		}
		else {
		    /* Have the unit wander randomly */
		    ComputerGiveOrders (unit, C_ORDER_RANDOM, -1, -1, 
					      -1,-1, -1);
		}
	    }
	} /* end if owner and has moves left */
    /* End For */
}

