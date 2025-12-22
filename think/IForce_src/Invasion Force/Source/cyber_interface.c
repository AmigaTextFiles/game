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
	cyber_interface.c -- artificial intelligence module for Empire II

*/

/* This file contains all the routines associated with interfacing 
    with the main game engine - basically at two places (1) selecting
    production for new cities (and cities that just built something)
    and (2) the player's mainloop (where all the units get moved, etc.)
    Cleanup (when the game is over) has also been stuck in here. 
*/

#include "global.h"

#define  DEBUG_AI_INT(string)  if (!rtEZRequestTags(string,"Continue|Abort", \
     NULL,NULL, RTEZ_Flags,EZREQF_CENTERTEXT,RT_Window,map_window, \
     RT_ReqPos,REQPOS_CENTERWIN,RT_LockWindow,TRUE,TAG_END )) \
     { if (AIhandle != NULL)  unpost_it(AIhandle); AIhandle = NULL; \
     clean_exit(0, NULL); }

/***************************************************************
*************** Production Interface   *************************
***************************************************************/

/* This routine will set up the needed production for all Governors. */
void  set_automated_production (struct City *metro)
{
    int     AI_type = PLAYER.aggr;
    struct  GovNode*  Gov = NULL;

   /* Now let's explore the hex we start with.  If we just took this
       city, or are starting out with it, this is important. */
    explore_at_hex(player,metro->col,metro->row,INVISIBLE,FALSE);

    /* We do the next in this manner so that other computer opponents
       can be added later, up to the ten maximum. Note we have deliberate
       fall-throughs so that unsupported AI types will default to the 
       'best' supported type. */
    switch( AI_type ) {
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
        //Gov = AI4_locate_gov( metro );
	    /* Let the Gov take a look around */
	    //explore_at_hex( player, metro->col, metro->row, INVISIBLE, FALSE);
	    //AI1_do_one_histogram( Gov );
	    //AI5_set_gov_mode( Gov );
	    //AI5_set_gov_prod( metro, Gov );
	    //if( PLAYER.aggr != 5 ) PLAYER.aggr = 5;
	    //break;
    case 4:
	    Gov = AI4_locate_gov( metro );
	    /* And let the (perhaps new) Gov take a look around */
        explore_at_hex( player, metro->col, metro->row, INVISIBLE, FALSE);
	    AI1_do_one_histogram (Gov);
	    AI3_set_gov_mode (Gov);
	    AI4_set_gov_prod( metro, Gov );
	    if( PLAYER.aggr != 4 ) PLAYER.aggr = 4;
	    break;
    case 3:
	    Gov = AI3_locate_gov( metro );
	    /* And let the (perhaps new) Gov take a look around */
        explore_at_hex( player, metro->col, metro->row, INVISIBLE, FALSE);
	    AI1_do_one_histogram (Gov);
	    AI3_set_gov_mode (Gov);
	    AI3_set_gov_prod( metro, Gov );
	    if( PLAYER.aggr != 3 ) PLAYER.aggr = 3;
	    break;
    //case 1:
    case 2:
        Gov = AI2_locate_gov( metro );
        AI2_set_gov_prod( metro, Gov );
	    if( PLAYER.aggr != 2 ) PLAYER.aggr = 2;
        break;
    case 1:
    	Gov = AI1_locate_gov( metro );
	    AI1_set_gov_prod( metro, Gov );
    	if( PLAYER.aggr != 1 ) PLAYER.aggr = 1;
	    break;
    default:
	    DEBUG_AI("Error in set_automated_prod.  Aggressiveness out of range.")
	    break;
    } /* End switch */
    return;
}


int	do_computer_city_production ()
{
    struct City *metro = (struct City *)city_list.mlh_Head;
    int 		ctr = 0;
    /* This routine will duplicate much of do_cities_production.  These two
    	should be put back together in the future.  For now, this works just
	fine. 
	*/

    for ( ; metro->cnode.mln_Succ; metro = 
          (struct City *)metro->cnode.mln_Succ)
      if (metro->owner==player) {
         metro->unit_wip += (metro->industry*PLAYER.prod)/50;
         explore_at_hex(player,metro->col,metro->row,INVISIBLE,TRUE); 
         if (metro->unit_wip >= wishbook[metro->unit_type].build) {
	     /* We finished a new unit */
	     make_new_unit( metro );
	     /* Now we call set_automated_production to set a new production
		for this city 
		*/
	     ctr++;
	     set_automated_production (metro);
         } /* End if > Wishbook */
      } /* End if owner of city */
    /* End for loop */

    return (ctr);  /* Don't know if this is usefull info or not right now. */
}


void   make_new_unit( struct City* metro)
{
    struct GovNode *Gov = NULL;
    struct GovNode *Gov2 = NULL;
    int			Done;

    struct Unit *new_unit = AllocVec((int)sizeof(*new_unit),MEMF_CLEAR);

    metro->unit_wip = 0;

    /* build the unit */
    new_unit->col = metro->col;
    new_unit->row = metro->row;
    new_unit->owner = player;
    new_unit->type = metro->unit_type;
    new_unit->move = unit_speed(new_unit);
    new_unit->damage = 0;
    new_unit->attacks = 0;
    new_unit->cargo = 0;
    new_unit->ship = NULL;
    new_unit->orders = NULL;
    new_unit->fuel = wishbook[new_unit->type].range;
    
    /* DEBUG_AI("Built new unit!") */

    /* We need to name the unit so that we can tell what governor 
       owns it. This is done to keep within the unit structures
       as defined and not add any more elements (so far).
       */
    Done = 0;
    if( (new_unit->type == TRANSPORT) || (new_unit->type == CARRIER) ||
	(new_unit->type == BATTLESHIP) ) {
        // These units get their own Governor
        struct GovNode *new_gov = AllocVec((int)sizeof(*new_gov),MEMF_CLEAR);

	new_gov->x = metro->col;
	new_gov->y = metro->row;
	new_gov->targx = -1;
	new_gov->targy = -1;
	new_gov->searchx = -1;
	new_gov->searchy = -1;
	new_gov->mode = GOV_SEARCH;
	new_gov->flags = 0;
	new_gov->owner = player;
	if( new_unit->type == TRANSPORT ) new_gov->type = GOV_TRANSPORT;
	if( new_unit->type == CARRIER )  new_gov->type = GOV_CARRIER;
	if( new_unit->type == BATTLESHIP )  new_gov->type = GOV_BATTLESHIP;
	new_gov->ID = NewGov++;
	// Add a random number to keep from revealing too much to human
	//   players
	NewGov += (int) RangeRand(3L);

	// Note: The AI must initialize this Governor before using it -
	//   it has not had do_one_histogram or set_gov_mode done on it.
	//   These functions are AI dependent, so they are not done here.

	/*sprintf (outbuf, "Creating Governor %ld at %ld,%ld",
		 new_gov->ID, new_gov->x, new_gov->y);
	DEBUG_AI(outbuf) */
    
	/* Add the new governor to the list of governors */
	AddTail((struct List *)&GovList,(struct Node *)new_gov);

	sprintf( outbuf, "%ld / %ld", new_gov->ID, NewUnit++);
	// Add a random number to keep from revealing too much to human
	//   players
	NewUnit += (int) RangeRand(6L);
	name_unit( new_unit, outbuf );
    }
    else {
      for ( Gov = (struct GovNode *)GovList.mlh_Head; (Gov->gnode.mln_Succ) 
	      && (!Done); Gov = (struct GovNode *)Gov->gnode.mln_Succ) {
	/* Check for the right coordinates */
	if ((Gov->x == metro->col) && (Gov->y == metro->row)
	    && (Gov->owner == player)
	    && ((Gov->type == GOV_CITY) || (Gov->type == GOV_PORT)
		|| (Gov->type == GOV_ISLAND) )) {
	        /* We found the right governor, now let's
	        set the name correctly
	        */
	        sprintf (outbuf, "%ld / %ld", Gov->req.req_gov, NewUnit++);
		// Add a random number to keep from revealing too much to human
		//   players
		NewUnit += (int) RangeRand(6L);
		name_unit(new_unit, outbuf);
	        Done = 1;
	        sprintf(outbuf, "Built new %s", UnitString[new_unit->type]);
		DEBUG_AI(outbuf)
	        sprintf(outbuf, "Naming unit '%s' (%ld)", new_unit->name,
		        Gov->req.req_gov);
		DEBUG_AI(outbuf)
		/* And, lets update the data for the owning governor */
		for(Gov2 = (struct GovNode *)GovList.mlh_Head;
		    (Gov2->gnode.mln_Succ);
		    Gov2 = (struct GovNode *)Gov2->gnode.mln_Succ) {
		  if( Gov2->ID == Gov->req.req_gov ) {
		    Gov2->hist.TotalMyUnits++;
		    Gov2->hist.UnitCounts[new_unit->type]++;
		  }
		} /* end for */
        } /* End if right coordinates and owner */
      }  /* End for loop */
    } // End else another type of unit
    if ((!Done) || (new_unit->name == NULL)) {
	name_unit(new_unit, "UNNAMED");
	DEBUG_AI("Problem! Have no name for newly built unit")
	if (!Done) DEBUG_AI("Did not find correct Governor")
	sprintf (outbuf, "%s Unit %s is at %ld, %ld",
		 UnitString[new_unit->type], new_unit->name, new_unit->col,
		 new_unit->row);
	DEBUG_AI(outbuf)
    }
    AddTail((struct List *)&unit_list,(struct Node *)new_unit);
}



/*************************************************************
***************  Game Play Routines  *************************
*************************************************************/

void  computer_player_moves ()
{
    int          AI_type = PLAYER.aggr;
    int          new_units;
    struct Unit *unit = (struct Unit *)unit_list.mlh_Head;
    struct Unit *FoundUnit = (struct Unit *)unit_list.mlh_Head;
    struct City *FoundCity = (struct City *)city_list.mlh_Head;

    /* This routine is called by the game mechanics to do the computer
    	player's moves, production, repair, etc.
	*/


    /* First, let's put up the appropriate msg to say who we are */
    switch( AIDataFlag ) {
      case 5:
    	// Show the AI players moving
	    PLAYER.show = SHOW_GRP;
	    PLAYER.soundfx = SOUND_NONE;
        // Find a unit or city owned by the player
        while( (FoundCity->cnode.mln_Succ) && (FoundCity->owner != player) )
            FoundCity = (struct City *)FoundCity->cnode.mln_Succ;
        if( !FoundCity->cnode.mln_Succ ) FoundCity = NULL;
        while( (FoundUnit->unode.mln_Succ) && (FoundUnit->owner != player) )
            FoundUnit = (struct Unit *)FoundUnit->unode.mln_Succ;
        if( !FoundUnit->unode.mln_Succ ) FoundUnit = NULL;
        // Create a map display there
        if( FoundCity )  create_player_display( FoundCity->col, 
            FoundCity->row );
        if( FoundUnit )  create_player_display( FoundUnit->row,
            FoundUnit->col );
    	// Deliberate fall-through
      case 4:
        // Set the message delay to 30
        PLAYER.msg_delay = 30;
	    // Deliberate fall-through
      case 3:
        // Set the message delay to 20
	    if( AIDataFlag < 4 ) {
	        PLAYER.msg_delay = 20;
	    }
	    // Add the sticky note
	    sprintf (outbuf, "Player %ld (AI type %ld)", 
		     player, AI_type);
    	AIhandle = post_it (outbuf);
	    // Deliberate fall-through
      case 2:
    	// Add a tell_user call
	    sprintf (outbuf, "Player %ld (AI type %ld)", 
		     player, AI_type);
    	tell_user2( outbuf, FALSE, NULL );
	    // Deliberate fall-through
      case 1: {
	    if( AIDataFlag < 3 ) {
	        // Set the message delay to 10
	        PLAYER.msg_delay = 10;
	    }
        if( AIDataFlag < 5 ) {
    	    PLAYER.show = SHOW_NON;
        }
       	// Show a wait cursor
        SetPointer(map_window,BUSY_POINTER);
	    break;
      }
      default: {
	    PLAYER.msg_delay = 10;
	    PLAYER.show = SHOW_NON;	
    	break;
      }
    } // End switch

    /* update all unit moves and explore around units */
    for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player) {
            unit->move = unit_speed(unit);
            unit->attacks = 0;
            explore_at_hex(player,unit->col,unit->row,INVISIBLE,FALSE); 
         } /* End if my units */
    /* End For Loop */
    /* DEBUG_AI("Updated all units movement points") */

    /* update his production for this turn */
    new_units = do_computer_city_production();
    /* DEBUG_AI("Done with production phase") */

    /* We do the next in this manner so that other computer opponents
       can be added later, up to the ten maximum. Note we have deliberate
       fall-throughs so that unsupported AI types will default to the 
       'best' supported type. */
    switch( AI_type ) {
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
        //AI5_play_turn( new_units );
	    //break;
    case 4:
	    AI4_play_turn( new_units );
	    break;
    case 3:
	    AI3_play_turn( new_units );
	    break;
    //case 1:
    case 2:
        AI2_play_turn( new_units );
        break;
    case 1:
    	New_AI1_play_turn( new_units );
	    break;
    default:
	    DEBUG_AI("Error in computer_player_moves().  Aggressiveness out of range.")
    	break;
    } /* End switch */

    
    /* do some housekeeping at end of turn
       here I want to check for any ships that need repair
       */
    unit=(struct Unit *)unit_list.mlh_Head;
    for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->damage > 0 && unit->move > 50)
            if (unit->owner==player && city_hereP(unit->col,unit->row))
               unit->damage--;
    /* End if, End if, End for */
    /* DEBUG_AI("Done with unit repair") */


    /* All Done.  Let's remove the sticky note */
    switch( AIDataFlag ) {
      case 5:
    	// Hide the AI players moving
	    roster[player].show = SHOW_NON;
    	// Deliberate fall-through
      case 4:
	    // Deliberate fall-through
      case 3:
    	// Deliberate fall-through
	    // Remove the sticky note
    	unpost_it(AIhandle);
	    AIhandle = NULL;
      case 2:
    	// Deliberate fall-through
	    // Nothing to do here
      case 1: {
    	// Remove the wait cursor
        ClearPointer( map_window );
    	break;
      }
      default: {
	    break;
      }
    } // End switch

    return;
}

/*************************************************************
*************** Initialization and Cleanup *******************
*************************************************************/

// This routine is to deallocate the memory for computer opponents
void    cleanup_computer()
{
	//calc_move (MOVE_CLEANUP, NULL, 0, 0, 0, 0);

	// We need to clean out and delete all the Governors
	nuke_list (&GovList);
 
    // Take out Post-it if up
    if (AIhandle != NULL)  unpost_it(AIhandle);
    AIhandle = NULL;

    // And just for the heck of it, reset the numbering scheme
    NewGov = 12;
    NewUnit = 1000;

    return;
}


/*************************************************************
***************  Saving and Restoring Files  *****************
*************************************************************/


int  SaveAIPlayers( BPTR file, char* err )
{
  // the governor list
   {
      struct GovNode *gov = ( struct GovNode* ) GovList.mlh_Head;
      int num_govs = count_nodes( &GovList );

      Write( file, &num_govs, (long) sizeof( num_govs ) );
      for (; gov->gnode.mln_Succ; gov = ( struct GovNode* )gov->gnode.mln_Succ)
         // We want to save everything in each governor node except the cnode
         // so that has to stay in the front, and this needs to point to the
         // first item of data AFTER the cnode, which is the type for the
         // governors
         Write( file, &gov->type, (long)(sizeof( *gov )-sizeof(gov->gnode)) );
   }

  return 0;
}


int  LoadAIPlayers( BPTR file, char*err )
{
   int  ctr;

   // restore the AI players' governors list
   int num_govs;

   (void)Read( file, &num_govs, sizeof( num_govs ) );
   if ( num_govs > 0 ) {
      struct GovNode *gov;

      for( ctr=1; ctr <= num_govs; ctr++ ) {
         gov = AllocVec( sizeof( *gov ), MEMF_CLEAR );
         if ( gov == NULL ) {
            strcpy( err, "Unable to allocate RAM for governors." );
            return -1;
         } // end if
         (void)Read( file, &gov->type, sizeof( *gov )- sizeof( gov->gnode ));
         AddTail( (struct List* )&GovList, (struct Node *)gov );
     } // End for
   } // end if
   return 0;
}


















