/* $Id: z_std.t 1.12 96/04/16 21:56:47 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * z_std.t - Modifications and additions to std.t for Zebulon.
 *
 **********************************************************************
 * 
 * Copyright (c) 1995-96 by Magnus Olsson (mol@df.lth.se).
 * All rights reserved.
 *
 * This source code may be copied and distributed freely as long as the 
 * following conditions are met:
 *   - no fee may be charged for the code (a nominal fee may be charged
 *     to cover distribution costs)
 *   - the code is not modified in any way
 *   - this copyright notice is not removed or modified in any way
 *
 * You may use individual parts of this code in your programs
 * as long as they are attributed to the author. You are not allowed
 * to use the plot, story, characters or text of the game without the
 * written permission of the author.
 *
 ***********************************************************************/

#include <adv.t>
#include <std.t>
#include "intro.t"


/*
 * Modify the ground so "throw ball at ground" doesn't give the
 * embarrassing message "you miss".
 */
modify theFloor
    ioThrowAt(actor, dobj) =
    {
        "OK. ";
        dobj.moveInto(actor.location);
    }
;

modify container 
    verDoEmpty(actor) = {
        "%You% will have to remove things from << self.thedesc >> one
        at a time. ";
    }
;

/*
 * Disallow reading of non-held objects (objects that can be read despite
 * not being held must override this method.
 */    
modify readable
    verDoRead(actor) = {
	if (location <> actor) 
	    "But %you% %are%n't holding << self.thedesc >>. ";
    }
;


replace scoreRank: function
{
    "In a total of "; say(global.turnsofar);
    " turns, you have achieved a score of ";
    say(global.score); " points out of a possible ";
    say(global.maxscore); 
    ", and visited ";
    say(Me.rooms_visited);
    " location";
    if (Me.rooms_visited > 1)
        "s";
    " out of 12";
    ".\n";
}

class indoors : room
    in = {
        "But %you're% already inside! ";
	return nil;
    }
;    

modify room
    enterRoom(actor) = {
  	if (not self.isseen and actor = Me)
	    ++Me.rooms_visited;
	pass enterRoom;
    }
;
    
/* 
 * Introduce the "no_all" property of objects.
 * Each object should have a method called no_all which will be called
 * during disambiguation. If the method returns true, the object will
 * be matched by the word 'all'. 
 */
check_no_all : function(verb, prep, io, list) 
{
    local l := list;
    local i;
    local len := length(list);
	
    for (i := 1; i <= len; ++i)
        if (list[i].no_all(verb, prep, io))
            l -= list[i];
    return l;
}

modify deepverb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;

/*
 * Unfortunately, there are quite a few verbs that override deepverb's
 * doDefault method completely (without calling inherited.doDefault),
 * so we'll have to replace it in many places.
 */
modify dropVerb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;
modify putVerb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;
modify takeVerb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;
modify giveVerb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;
modify showVerb
    doDefault(actor, prep, io) = {
        return check_no_all(self, prep, io, 
		inherited.doDefault(actor, prep, io));
    }
;

/*
 * Fix a bug in thing
 */
modify thing
    verDoTakeOut(actor, io) =
    {
        if (io <> nil and not self.isIn(io)) {
            caps(); self.thedesc; " isn't in "; io.thedesc; ". ";
        }
	else
	    self.verDoTake(actor);   /* ensure object can be taken at all */
    }

    verDoSearch(actor) = {
	self.verDoInspect(actor);
    }
    doSearch(actor) = {
        self.doInspect(actor);
    }
 
    doBreak(actor) = {
  	"Breaking things won't help you at all in this game. ";
    }
;

/*
 * Fix a bug in showcontcont: the test of the isqsurface flag is backwards
 * in the adv.t packaged with TADS 2.2!
 */
replace showcontcont : function(obj)
{
    if (itemcnt(obj.contents)) {
        if (obj.issurface) {
	    if (not obj.isqsurface) 
		"On << obj.thedesc >> you see << listcont(obj) >>. ";
 	}
        else if (obj.contentsVisible and not obj.isqcontainer) 
            "\^ << obj.thedesc >> seems to contain << listcont(obj) >>. ";
    }
    if (obj.contentsVisible and not obj.isqcontainer)
        listfixedcontcont(obj);
}
   
/*
 * New die() function that calls game_over.
 * The player can't actually die in this game, but we may want to
 * write other games where she can.
 */
replace die : function
{
    "\b*** You have died ***\b";
    game_over();
}

/*
 *  The game_over function takes over most of the functionality
 *  of die(), for cases where the game ends without the player's
 *  actually dying.
 */
game_over : function
{
    scoreRank();
    "\bYou may restore a saved game, start over, quit, or undo
    the current command.\n";
    while ( 1 )
    {
        local resp;

	"\nPlease enter RESTORE, RESTART, QUIT, or UNDO: >";
        resp := upper(input());
        if ( resp = 'RESTORE' )
	{
	    resp := askfile( 'File to restore' );
	    if ( resp = nil ) "Restore failed. ";
	    else if ( restore( resp )) "Restore failed. ";
	    else
	    {
	        Me.location.lookAround(true);
	        scoreStatus( global.score, global.turnsofar );
		abort;
	    }
	}
        else if ( resp = 'RESTART' )
	{
	    scoreStatus( 0, 0 );
            restart();
	}
	else if ( resp = 'QUIT' )
        {
   	    "\b";
	    terminate();
            quit();
	    abort;
        }
	else if (resp = 'UNDO')
	{
	    if (undo())
	    {
		"(Undoing one command)\b";
		Me.location.lookAround(true);
	        scoreStatus(global.score, global.turnsofar);
		abort;
	    }
	    else
		"Sorry, no undo information is available. ";
	}
    }
}

replace incscore: function(amount)
{
    "\b[Your score just went << amount > 0 ? "up" : "down" >> ";
    say(amount);
    " points]\n";
    
    global.score += amount;
    scoreStatus( global.score, global.turnsofar );
}

intro : function; // This function will be called by init

/*
 *   Modified version of init() - doesn't start sleep and hunger daemons,
 *   calls intro() to print introduction, etc.
 */
replace init : function
{
    intro();
    version.sdesc;         // display the game's name and version number
    if (global.wizard)
        "Compiled in WIZARD mode";
    "\bPlease type \(INFO\) for credits and general release 
    information.\b\b";

    setdaemon(turncount, nil);         // start the turn counter daemon
    randomize();
    
    Me.location := startroom;          // move player to initial location
    Me.location.lookAround(true);      // show player where he is
    Me.location.isseen := true;        // note that we've seen the room
    
    scoreStatus(0, 0);
}


/*
 * Change the doGiveTo method of thing so that we don't get the
 * "Done" message by default; instead, we'll let the receiver
 * handle that.
 */
modify thing
    doGiveTo(actor, io) = {
        self.moveInto(io);
    }
;


/*
 * A class of fixed items that can be accessed by the player if he's in
 * any of a list of locations.
 */
class fixedfloater : floatingItem, fixeditem
    llist = [] // List of possible locations
    locationOK = true
    location = {
	if (find(llist, Me.location))
	    return Me.location;
	else
	    return nil;
    }
;

modify class decoration
    isplural = nil
    not_important = "\^<< self.thedesc >> << isplural ? "are" : "is" >>n't 
    	important. "
    ldesc = {
        self.not_important;
    }
    dobjGen(a, v, i, p) = {
        if (v <> inspectVerb) {
            self.not_important;
	    exit;
	}
    }
    iobjGen(a, v, d, p) = {
        if (v <> askVerb and v <> tellVerb) {
            self.not_important;
 	    exit;
	}
    }
;

modify movableActor
    rooms_visited = 1
    verDoSearch(actor) = {
        "I don't think << self.thedesc >> would agree to that. ";
    }
;
   
#include "z_verbs.t"
