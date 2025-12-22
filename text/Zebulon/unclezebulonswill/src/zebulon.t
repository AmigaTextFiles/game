/* $Id: zebulon.t 1.15 96/04/16 21:56:51 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * zebulon.t - Main module
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

/***************************************************************************
 
  To compile this game, you need the TADS compiler version 2.2 or later.
  On most systems, the command to compile it is either
  See the accompanying release notes for more information.
    
  The score is computed as follows:
  
  Reading the letter		 	 5 points
  Finding paper in book		         5 points
  Eating tomato				 5 points
  Fitting first eye of dog  		 5 points
  Turning on the dog  			 5 points
  Opening gate to endgame		15 points
  Putting thing in bottle		 5 points
  Opening mirror			10 points
  Offering final coin			10 points
  Winning				10 points

 ***************************************************************************/

#include "z_std.t"
#include "rooms.t"
#include "sitroom.t"
#include "shed.t"
#include "demon.t"
#include "items.t"
#include "endgame.t"

modify global
    maxscore = 75
;

modify version
    sdesc = "\(Uncle Zebulon's Will\), an Interactive Inheritance.\n
        Release 2.0 / 960416\b
        Copyright (c) 1995, 1996 by Magnus Olsson. 
	All rights reserved.\n
	This game was awarded the first prize in the TADS section of
	the\nFirst Annual IF Competition, 1995\n
        Developed with TADS, the Text Adventure Development System.\b"
;

info : object
    infotext = "\b\(Uncle Zebulon's Will\) was written by Magnus Olsson
        (mol@df.lth.se) for the First Annual IF Competition, 1995.\b
	Copyright (c) 1995, 1996 by Magnus Olsson. All rights reserved.\b
	This program is freeware. It is \(not\) in the public domain.
	You may copy and distribute it as long as it is not modified
	in any way. It may not be sold for profit, though a nominal 
	distribution fee may be charged. Please contact the author
	for more information.\b
	Source code is available - see the release notes for details.\b
	Thanks to play testers Michael Kinyon, Sean Molley and
	Paul David Doherty for
	many valuable suggestions and invaluable bug reports, as well as to 
	Jason Dyer, Kevin Wilson, Darryl O'Neill and Carl D.\ Cravens 
	for their much-appreciated feedback.\b
	Disclaimers:\n
	This game is a piece of fiction. All characters, places and
	situations are figments of the author's imagination. Any similarities
	between characters in the game and real persons, living or
	dead, are purely coincidental.\n
	\"Uncle Zebulon's Will\" was designed to be a short, simple 
	game that fulfils
	the competition rule of being winnable in two hours. Hopefully,
	this doesn't make it too trivial.\b
	Finally, the author would like to apologize for the awful poem
	that appears in the game. Clearly uncle Zebulon was better as a
	wizard than as a poet. "
	
    helptext = "\bThis game was designed to be a simple one. I've
        deliberately not provided any hints, since I think that
	hints spoil a lot of the fun and since I believe that this
	game is so simple that it doesn't need any. If you're  
	stuck, then I was obviously wrong; please accept my apologies.
	If you're really stuck, feel free to email me (mol@df.lth.se) 
	for help. "
;	

/*
 * The following function is called (instead of die, since you can't die
 * int his game) when they player has lost the game.
 */
fail : function
{	
    "\tAfter attending your uncle's funeral, you go back to college and
    complete your education as an accountant, embarking on a successful
    and satisfying career. Sometimes, your thoughts go flashing back
    to uncle Zebulon, and you have a nagging sense that you've missed
    something important. Those feelings soon pass; after all, you have
    more important things to deal with.\b
    ***** You have failed *****\b ";
    game_over();
}

/*
 * Class for treasures. The demon will only let you take one object
 * of this class from the house, and when you do, the inheritance
 * attribute will be set.
 */		
class treasure : item
    inheritance = nil // True if player has accepted it as his inheritance
;

/*
 * Some minor modifications to the player.
 */
modify Me
    noun = 'richard'
    inheritance = nil // Set to the treasure chosen as inheritance.
    wand_effect = {
        " that explode with little popping noises as they strike you.
	They don't seem to hurt you, though the sensation is quite 
	unpleasant. ";
    }
    ioPourOn(actor, dobj) = {
        if (dobj = acid)
	    "Feeling suicidal today? ";
	else
	    pass ioPourOn;
    }
    verDoEat(actor) = {
        "That doesn't seem very productive. ";
    }
;

/*
 * Uncle Zebulon gets his own object, even though he's not around - 
 * this allows the player to refer to him.
 */
uncle : Actor
    noun = 'uncle' 'zebulon' 'zeb' 'wizard' 'sorcerer'
    adjective = 'late' 'uncle'
    article = 'my'
    isHim = true
    sdesc = "Uncle Zebulon"
    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    location = nil // Uncle Zebulon isn't around anymore (but we may want
    		   // to refer to him).
;
    
	

