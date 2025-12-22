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
	cyber4.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with AI Type #4.
*/

#include "global.h"
#define SHOW_AI4_MSG
#ifdef SHOW_AI4_MSG
#define  DEBUG_AI4(string)  if (!rtEZRequestTags(string,"Continue|Abort", \
     NULL,NULL, RTEZ_Flags,EZREQF_CENTERTEXT,RT_Window,map_window, \
     RT_ReqPos,REQPOS_CENTERWIN,RT_LockWindow,TRUE,TAG_END )) \
     { if (AIhandle != NULL)  unpost_it(AIhandle); AIhandle = NULL; \
     clean_exit(0, NULL); }
#endif
#ifndef SHOW_AI4_MSG
#define  DEBUG_AI4(string)
#endif



#define GET_REQ 10
void  AI4_set_gov_prod (struct City *metro, struct GovNode *CityOwner)
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
            AI4_get_gov_req (Gov, metro );
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


void  AI4_get_gov_req( struct GovNode* Gov, struct City* metro )
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
					 Gov->x, Gov->y, AI5_PATH_GOOD );
            HaveInfAccess = Path[0];
            if( HaveInfAccess != -1 ) {
            	AI5_CalcPath( ARMOR, metro->col, metro->row,
					 Gov->x, Gov->y, AI5_PATH_GOOD );
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
        	       ((Gov->hist.TerrainCounts[HEX_JUNGLE] + 
            		Gov->hist.TerrainCounts[HEX_PEAKS] + 
	            	Gov->hist.TerrainCounts[HEX_SWAMP] + 
		            Gov->hist.TerrainCounts[HEX_MOUNTAINS]) * 2) )
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
        	       ((Gov->hist.TerrainCounts[HEX_JUNGLE] + 
            		Gov->hist.TerrainCounts[HEX_PEAKS] + 
	            	Gov->hist.TerrainCounts[HEX_SWAMP] + 
		            Gov->hist.TerrainCounts[HEX_MOUNTAINS]) * 2) )
        		    LastReq.type = RIFLE;
        } /* End else can't make AIRCAV */	                
    }
    else {
    	switch( Gov->mode ) {
	    case GOV_DEFEND:
	        /* We're under attack!  Make some ground units to defend 
		       with */
	        LastReq.priority = 20;
	        /* But, let's only change production if it's not ARMOR */
	        if( metro->unit_type == ARMOR ) 
        		LastReq.type = ARMOR;
	        else
    		    LastReq.type = RIFLE;
	        break;
    	case GOV_SEARCH:
	        /* Make aircraft to scout with if we can. */
	        LastReq.priority = 10;
	        if( wishbook[FIGHTER].enabled == TRUE )
		        LastReq.type = FIGHTER;
	        else { 
                if( wishbook[BOMBER].enabled == TRUE ) {
		            LastReq.type = BOMBER;
	            }
	            else {
		            if( LastReq.type == -1 ) {
			            /* No type selected yet, lets get a ground unit */
			            /* Make armor units if we can, if not, 
			                make infantry. */
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
            			   ((Gov->hist.TerrainCounts[HEX_JUNGLE] + 
            			    Gov->hist.TerrainCounts[HEX_PEAKS] + 
			                Gov->hist.TerrainCounts[HEX_SWAMP] + 
            			    Gov->hist.TerrainCounts[HEX_MOUNTAINS]) * 2) )
			                    LastReq.type = RIFLE;
    		        } /* End else no unit type selected yet */
    	    	} /* End else no bombers */
    	    } /* End else no fighters */
    	    /* If we have a bunch of Fighters already, start making
	           some Bombers.  But switch back when the Fighters are
	           all gone (and try to regain air superiority)
    	       */
	        if((LastReq.type == FIGHTER) &&
	           ( wishbook[BOMBER].enabled == TRUE) && 
    	       (Gov->hist.UnitCounts[FIGHTER] >= 5) ) {
	            	LastReq.type = BOMBER;
    	    }
	        break;
    	} /* End switch */
    } /* End else not city-taken */

    /* Attenuate the priority of the request for distance */
    if( LastReq.priority > 0 ) {
	    i = AI5_GetDist (metro->col, metro->row, Gov->x, Gov->y);
    	LastReq.priority -= i / 2;
	    if (LastReq.priority < 1)  LastReq.priority = 1;
    }
    /* And make sure we record who made the request */
    if( LastReq.type != -1 )
    	LastReq.req_gov = Gov->ID;
    else 
        LastReq.priority = 0;

    return;
}


struct GovNode*  AI4_locate_gov( struct City* metro )
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
    AI3_setup_area_of_interest (NewGov, 5, 20);
    return (NewGov);
}

void  AI4_play_turn( int new_units )
{
    int   MaxLooping = 5000;
    /* Here we may want to look around, give out some orders to units,
       and execute orders to units in a loop until we have done all the 
       moves possible for the units.
       */
    AI3_do_all_histograms();
    AI4_give_orders();
    /* We'll add a little failsafe so we don't spend eternity here */
    while( (MaxLooping > 0) && (!DoUnitActions(40,60)) )  MaxLooping--;
    if( MaxLooping <= 0 ) 
	    DEBUG_AI4("Error: Exitting AI player's turn - out of actions!")
    return;
}

int  AI4_do_unit_actions()
{
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    struct GovNode *Gov = NULL;
    int         Done = TRUE;
    static struct Unit* lastunit = NULL;
    static int    times_accessed = 0;
    int           attack_dir;

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
    		/* New for this version - let's use the recommend action
	    	   routine. */
		    //attack_dir = AI4_recommend_action( unit, 75, 20);
		    //if( attack_dir != -1 ) {
		        //move_unit_dir( unit, attack_dir );
		        //return (FALSE);
		    //}
		    if( AI4_look_around ( unit ) )   return (FALSE);
		    /* if we have orders, execute them */
    		if (unit->orders != NULL) {
	    	    AI4_execute_standing_order(unit);
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
            times_accessed = 0;
            lastunit = NULL;
	    }
    } /* End if we own unit and it has moves left */
    /* End for loop */    
    times_accessed = 0;
    lastunit = NULL;
    return (Done);
}

int  AI4_look_around( struct Unit* unit)
{
    int          i, k;
    short        targx, targy;
    struct City* metro;
    struct GovNode* FoundGov = NULL;
    struct GovNode* my_gov = NULL;
    enum   GovMode  old_mode;

    for (i = 0; i < 6; i++) {
	if (AI1_calc_dir (i, unit->col, unit->row, &targx, &targy) != -1) {
	    if ((metro = city_hereP (targx, targy)) && 
		(metro->owner != player)) {
		/* if there is a city here and we don't own it, this
		   call will create a Governor for it if there isn't
		   one already. 
		   */
		FoundGov = AI4_locate_gov( metro ); 
		/* And let the new Gov take a look around */
		AI1_do_one_histogram (FoundGov);
		AI3_set_gov_mode (FoundGov);
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
		    /* Here's a new experiment - changing our governor's
		       mode on the fly.
		       */
		    my_gov = AI1_FindOwner( unit );
		    if( my_gov) {  /* Just to be safe */
			AI1_do_one_histogram( my_gov );
			old_mode = my_gov->mode;
			AI3_set_gov_mode( my_gov );
			if( old_mode != my_gov->mode ) {
			    /* We need to issue new orders to our units */
			    AI4_give_orders();
			}
		    }
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


void  AI4_execute_standing_order( struct Unit* unit )
{
    int		result;

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
        case C_ORDER_GOTO:
            result = AI4_command_goto(unit);
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
        case  C_ORDER_WALK_COASTLINE:
	        result = AI4_command_walk_coastline( unit );
	        if( (result <= 0) && (AI3_AssertUnit( unit ) ) )
		        clear_orders( unit );  /* problem or done */
	        break;
        default:
            DEBUG_AI("Unknown command type found in execute_standing_order!")
            break;
    }
    return;
}


void  AI4_give_orders( )
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
	        //sprintf(outbuf, 
	        //"Giving initial orders to unit named %s at %ld,%ld", 
            //   unit->name, unit->col, unit->row);
            //   DEBUG_AI(outbuf)
	    AI4_orders_for_unit( unit );
	} /* end if owner and has moves left */
    /* End For */
}

void  AI4_orders_for_unit( struct Unit* unit )
{
    struct GovNode *Gov = AI1_FindOwner (unit);
    if (Gov != NULL) {
        if( IsCityTaken( Gov ) ) {
	    AI4_taken_orders( unit, Gov );
	} /* End if CityTaken */
	else {
	    switch( Gov->mode ) {
	        case GOV_DEFEND:  {
		    AI4_defend_orders( unit, Gov );
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

void  AI4_taken_orders( struct Unit* unit, struct GovNode* Gov )
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
			(unit, C_ORDER_GOTO, icon->col, icon->row, -1, -1,
			 -1);
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


void  AI4_defend_orders( struct Unit* unit, struct GovNode* Gov )
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
	    if( (unit->col == Gov->x) && (unit->row == Gov->y) ) {
		    ComputerGiveOrders 
		        (unit, C_ORDER_RECON, -1, -1, Gov->x, Gov->y, -1 );
            AI3_select_recon_hex( unit, Gov );
        }
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


void AI4_computer_give_orders(struct Unit *unit,int suborder,short destx,
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


int   AI4_command_walk_coastline( struct Unit* unit )
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

    if( (unit->orders->destx < 0) || (unit->orders->destx > 5) ) 
    	return -1;  /* Problem */

    /* Now, figure out where we are headed.  */
    current = AI1_calc_dir( new_dir, unit->col, unit->row, &targx, &targy);
    while(( current != -1) && ( movement_cost_table[unit->type]
	   [get(PLAYER.map, targx, targy)] == -1 )) {
	    if( unit->orders->etc )
	        new_dir++;
    	else
	        new_dir--;
    	/* Wrap around the directions */
	    if( new_dir > 5 ) new_dir = 0;
    	if( new_dir < 0 ) new_dir = 5;
	    /* Check that we haven't come full circle and gotten nowhere */
    	if( new_dir == unit->orders->destx )  return -1;
	    current = AI1_calc_dir( new_dir, unit->col, unit->row, &targx, &targy);
    } // End while
    /* And, make the move */
    result = move_unit_dir( unit, (enum Direction)new_dir );

    /* Examine the result to see if we made a move */
    if( result < -1 )
    	/* We lost the unit moving, but made a move (or failed a chance to) */
	    return 1;

    if( result >= 0 ) {
    	if( !AI3_AssertUnit( unit ) ) return -1;  /* Problem! */
	    /* We made a move, so check for destination and set up for next move */
    	if(unit->orders ) {
	        if( (unit->col == unit->orders->orgx) && 
	            (unit->row == unit->orders->orgy) ) {
	            /* We reached the spot we started from - finished (?) */
    	        return 0;
	        }
	        /* Now we have the direction of the first navagable space 
    	       either CW or CCW from the current spot.  We need to record 
               where to start from next time.
	           */
	        if( unit->orders->etc )
	            unit->orders->destx = new_dir - 2;
    	    else
	            unit->orders->destx = new_dir + 2;
	        if( unit->orders->destx < 0 ) unit->orders->destx += 6;
    	    if( unit->orders->destx > 5 ) unit->orders->destx -= 6;
	     } //End if unit->orders
    } // End if result >= 0
    /* If the result was -1 (maybe stacking or something?) do nothing */
    return 1;
}



int  AI4_command_goto( struct Unit* unit )
{
    int  i;
    int  result;

    /* Check to see if we have arrived */
    if ((unit->col == unit->orders->destx) && 
        (unit->row == unit->orders->desty))  {
        /* We have arrived! */
        /* DEBUG_AI("We have arrived!") */
        return (0);
    }
    /* for now, just ask for the first path we find - after this is sped
       up we can use the optimal path */
    AI5_CalcPath( unit->type, unit->col, unit->row, unit->orders->destx,
		       unit->orders->desty, AI5_PATH_GOOD );
    i = Path[0];
    if( (i >=0) && (i <= 5) ) {
	    /* We have a valid direction, let's try it. */
	    result = move_unit_dir( unit, i );
        if (result == -1)  return -1; // Can't get there from here
	    if (result > -3) {
	        /* We didn't die in an attack, and we didn't crash, so 
	            let's check for destination again. */
	        /*DEBUG_AI("Checking for Destination") */
	        if( unit->orders ) {
	            if ((unit->col == unit->orders->destx) && 
		            (unit->row == unit->orders->desty))  {
        		    /* We have arrived! */
		            /* DEBUG_AI("We have arrived!") */
        		    return (0);
	            }
	            unit->orders->etc--;
    	        if (unit->orders->etc < 0)  {
	        	    DEBUG_AI("Watchdog on HeadTo ran out")
		            return (-2);
    	        }
	        }
    	}
	    return (1);
    } // End if valid direction returned
    else {
        return -1;  /* Can't get there */
    }
}

