/* Copyright (c) 1989, 1991 by Michael J. Roberts.  All Rights Reserved. */
/*
Name
  std.t   - standard default adventure definitions
  Version 1.2
  
  This file is part of TADS:  The Text Adventure Development System.
  Please see the file LICENSE.DOC (which should be part of the TADS
  distribution) for information on using this file.

  This file provides some simple definitions for objects and functions
  that are required by TADS, but not defined in the file "adv.t".
  The definitions in std.t are suitable for use while a game is
  being written, but you will probably find that you will want to
  customize the definitions in this file for your game when the
  game is nearing completion.  This file is intended to help you
  get started more quickly by providing basic definitions for these
  functions and objects.

  When you decide to customize these functions and objects for
  your game, be sure to remove the inclusion of std.t to avoid
  duplicate definitions.
*/

/* parse with normal TADS operators */
#pragma C-

/*
 *   Pre-declare all functions, so the compiler knows they are functions.
 *   (This is only really necessary when a function will be referenced
 *   as a daemon or fuse before it is defined; however, it doesn't hurt
 *   anything to pre-declare all of them.)
 */
die: function;
scoreRank: function;
init: function;
terminate: function;
pardon: function;
sleepDaemon: function;
eatDaemon: function;
darkTravel: function;

/*
 *   The die() function is called when the player dies.  It tells the
 *   player how well he has done (with his score), and asks if he'd
 *   like to start over (the alternative being quitting the game).
 */
die: function
{
    "\b*** You have died ***\b";
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

/*
 *   The scoreRank() function displays how well the player is doing.
 *   This default definition doesn't do anything aside from displaying
 *   the current and maximum scores.  Some game designers like to
 *   provide a ranking that goes with various scores ("Novice Adventurer,"
 *   "Expert," and so forth); this is the place to do so if desired.
 *
 *   Note that "global.maxscore" defines the maximum number of points
 *   possible in the game; change the property in the "global" object
 *   if necessary.
 */
scoreRank: function
{
    "In a total of "; say( global.turnsofar );
    " turns, you have achieved a score of ";
    say( global.score ); " points out of a possible ";
    say( global.maxscore ); ".\n";
}

/*
 *   The init() function is run at the very beginning of the game.
 *   It should display the introductory text for the game, start
 *   any needed daemons and fuses, and move the player's actor ("Me")
 *   to the initial room, which defaults here to "startroom".
 */
init: function
{
    // put introductory text here
    
    version.sdesc;                // display the game's name and version number

    setdaemon( turncount, nil );               // start the turn counter daemon
    setdaemon( sleepDaemon, nil );                    // start the sleep daemon
    setdaemon( eatDaemon, nil );                     // start the hunger daemon
    Me.location := startroom;                // move player to initial location
    startroom.lookAround( true );                    // show player where he is
    startroom.isseen := true;                  // note that we've seen the room
    scoreStatus(0, 0);                          // initialize the score display
}

/*
 *   preinit() is called after compiling the game, before it is written
 *   to the binary game file.  It performs all the initialization that can
 *   be done statically before storing the game in the file, which speeds
 *   loading the game, since all this work has been done ahead of time.
 *
 *   This routine puts all lamp objects (those objects with islamp = true) into
 *   the list global.lamplist.  This list is consulted when determining whether
 *   a dark room contains any light sources.
 */
preinit: function
{
    local o;
    
    global.lamplist := [];
    o := firstobj();
    while( o <> nil )
    {
        if ( o.islamp ) global.lamplist := global.lamplist + o;
        o := nextobj( o );
    }
    initSearch();
}

/*
 *   The terminate() function is called just before the game ends.  It
 *   generally displays a good-bye message.  The default version does
 *   nothing.  Note that this function is called only when the game is
 *   about to exit, NOT after dying, before a restart, or anywhere else.
 */
terminate: function
{
}

/*
 *   The pardon() function is called any time the player enters a blank
 *   line.  The function generally just prints a message ("Speak up" or
 *   some such).  This default version just says "I beg your pardon?"
 */
pardon: function
{
    "I beg your pardon? ";
}

/*
 *   This function is a daemon, started by init(), that monitors how long
 *   it has been since the player slept.  It provides warnings for a while
 *   before the player gets completely exhausted, and causes the player
 *   to pass out and sleep when it has been too long.  The only penalty
 *   exacted if the player passes out is that he drops all his possessions.
 *   Some games might also wish to consider the effects of several hours
 *   having passed; for example, the time-without-food count might be
 *   increased accordingly.
 */
sleepDaemon: function( parm )
{
    local a, s;

    global.awakeTime := global.awakeTime + 1;
    a := global.awakeTime;
    s := global.sleepTime;

    if ( a = s or a = s+10 or a = s+20 )
        "\bYou're feeling a bit drowsy; you should find a
        comfortable place to sleep. ";
    else if ( a = s+25 or a = s+30 )
        "\bYou really should find someplace to sleep soon, or
        you'll probably pass out from exhaustion. ";
    else if ( a >= s+35 )
    {
      global.awakeTime := 0;
      if ( Me.location.isbed or Me.location.ischair )
      {
        "\bYou find yourself unable to stay awake any longer.
        Fortunately, you are << Me.location.statusPrep >> <<
	Me.location.adesc >>, so you gently slip off into
        unconsciousness.
        \b* * * * *
        \bYou awake some time later, feeling refreshed. ";
      }
      else
      {
        local itemRem, thisItem;

        "\bYou find yourself unable to stay awake any longer.
        You pass out, falling to the ground.
        \b* * * * *
        \bYou awaken, feeling somewhat the worse for wear.
        You get up and dust yourself off. ";
        itemRem := Me.contents;
        while (car( itemRem ))
        {
            thisItem := car( itemRem );
            if ( not thisItem.isworn )
	        thisItem.moveInto( Me.location );
            itemRem := cdr( itemRem );
        }
      }
    }
}

/*
 *   This function is a daemon, set running by init(), which monitors how
 *   long it has been since the player has had anything to eat.  It will
 *   provide warnings for some time prior to the player's expiring from
 *   hunger, and will kill the player if he should go too long without
 *   heeding these warnings.
 */
eatDaemon: function( parm )
{
    local e, l;

    global.lastMealTime := global.lastMealTime + 1;
    e := global.eatTime;
    l := global.lastMealTime;

    if ( l = e or l = e+5 or l = e+10 )
        "\bYou're feeling a bit peckish. Perhaps it would be a good
        time to find something to eat. ";
    else if ( l = e+15 or l = e+20 or l = e+25 )
        "\bYou're feeling really hungry. You should find some food
        soon or you'll pass out from lack of nutrition. ";
    else if ( l=e+30 or l = e+35 )
        "\bYou can't go much longer without food. ";
    else if ( l >= e+40 )
    {
        "\bYou simply can't go on any longer without food. You perish from
        lack of nutrition. ";
        die();
    }
}

/*
 *   The numObj object is used to convey a number to the game whenever
 *   the player uses a number in his command.  For example, "turn dial
 *   to 621" results in an indirect object of numObj, with its "value"
 *   property set to 621.
 */
numObj: basicNumObj  // use default definition from adv.t
;

/*
 *   strObj works like numObj, but for strings.  So, a player command of
 *     type "hello" on the keyboard
 *   will result in a direct object of strObj, with its "value" property
 *   set to the string 'hello'.
 *
 *   Note that, because a string direct object is used in the save, restore,
 *   and script commands, this object must handle those commands.
 */
strObj: basicStrObj     // use default definition from adv.t
;

/*
 *   The "global" object is the dumping ground for any data items that
 *   don't fit very well into any other objects.  The properties of this
 *   object that are particularly important to the objects and functions
 *   are defined here; if you replace this object, but keep other parts
 *   of this file, be sure to include the properties defined here.
 *
 *   Note that awakeTime is set to zero; if you wish the player to start
 *   out tired, just move it up around the sleepTime value (which specifies
 *   the interval between sleeping).  The same goes for lastMealTime; move
 *   it up to around eatTime if you want the player to start out hungry.
 *   With both of these values, the player only starts getting warnings
 *   when the elapsed time (awakeTime, lastMealTime) reaches the interval
 *   (sleepTime, eatTime); the player isn't actually required to eat or
 *   sleep until several warnings have been issued.  Look at the eatDaemon
 *   and sleepDaemon functions for details of the timing.
 */
global: object
    turnsofar = 0                            // no turns have transpired so far
    score = 0                            // no points have been accumulated yet
    maxscore = 100                                    // maximum possible score
    verbose = nil                             // we are currently in TERSE mode
    awakeTime = 0               // time that has elapsed since the player slept
    sleepTime = 400     // interval between sleeping times (longest time awake)
    lastMealTime = 0              // time that has elapsed since the player ate
    eatTime = 200         // interval between meals (longest time without food)
    lamplist = []              // list of all known light providers in the game
;

/*
 *   The "version" object defines, via its "sdesc" property, the name and
 *   version number of the game.  Change this to a suitable name for your
 *   game.
 */
version: object
    sdesc = "A TADS Adventure
      \n Developed with TADS, the Text Adventure Development System.\n"
;

/*
 *   "Me" is the player's actor.  Pick up the default definition, basicMe,
 *   from "adv.t".
 */
Me: basicMe
;

/*
 *   darkTravel() is called whenever the player attempts to move from a dark
 *   location into another dark location.  By default, it just says "You
 *   stumble around in the dark," but it could certainly cast the player into
 *   the jaws of a grue, whatever that is...
 */
darkTravel: function
{
    "You stumble around in the dark, and don't get anywhere. ";
}

/*
 *   goToSleep - carries out the task of falling asleep.  We just display
 *   a message to this effect.
 */
goToSleep: function
{
    "***\bYou wake up some time later, feeling refreshed. ";
    global.awakeTime := 0;
}
