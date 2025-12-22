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
darkTravel: function;

ciao: function
{
    scoreRank();
    terminate();
    quit();
    abort;
}

newdie: function
{
    incscore(-10);
    "\b";
    if (global.endgame) {
	"Normally, I would attempt to rectify your condition, but I'm ashamed
	to say my abilities are not equal to dealing with your present state
	of disrepair.  Please let me express my profoundest regrets.
	\b";
	ciao();
    } else if (global.numdeaths >= 2) {
	"You clearly are a suicidal maniac.  We don't allow psychotics in the
	dungeon, since they may harm other adventurers.  Your remains will be
	installed in the Land of the Living Dead, where your fellow adventurers
	may gloat over them.\b";
	ciao();
    } else {
	local ob, houselocs, mazelocs, hcnt, mcnt, cur;
	
	/* Here we set the player to be dead, so that they can wander around,
	 * but most actions aren't available to them.  They have to get to
	 * the altar and pray to be restored.
	 */
	Me.isdead := true;
	global.numdeaths++;
	"As you take your last breath, you feel relieved of your burdens.  The
	feeling passes as you find yourself before the gates of Hell, where
	the spirits jeer at you and deny you entry.  Your senses are disturbed.
	The objects in the dungeon appear indistinct, bleached of color, even
	unreal.
	\b";

	for (ob := firstobj(villain); ob; ob := nextobj(ob, villain))
	    ob.fighting := nil;

	Me.moveInto(hades);  /* what if blown up? */
	if (coffin.isIn(Me))
	    coffin.moveInto(egyptian);
	trapdoor.touched := nil;
	thelamp.moveInto(livingrm);
	thelamp.turnoff(nil);
	brokenlamp.moveInto(nil);
	
	/* cancel some fuses */
	/* unnotify(balloon, &burnout);   let it burnout - DBJ */
	unnotify(fuse, &ignite);
	unnotify(wideLedge, &collapse);
	unnotify(brick, &munge);
	unnotify(slideRoom, &slip);
	// unnotify(hades, &breakspell);
	// unnotify(hades, &coolbell);

	/* Scatter items about.  First eight non-treasures to the vicinity
	 * of house, the rest into the maze.  (Fortran version kept
	 * incrementing room number starting from maze 1, we just use
	 * a short list instead which seems logical and less of a player
	 * headache).
	 */
	houselocs := [kitchen,clearing,forest5,forest4,southHouse,forest4,
		      southHouse,kitchen,behindHouse];
	mazelocs := [maze1,maze2,maze3,maze4,dead1,maze5,dead2];
	hcnt := mcnt := 1;
	while( cur := car(Me.contents) ) {
	    if (hcnt > 8 or isclass(cur, treasure)) {
		cur.moveInto(mazelocs[mcnt++]);
		if (mcnt > length(mazelocs))
		    mcnt := 1;
	    } else
		cur.moveInto(houselocs[hcnt++]);
	}
	abort;
    }
}

/*
 *   The die() function is called when the player dies.  It tells the
 *   player how well he has done (with his score), and asks if he'd
 *   like to start over (the alternative being quitting the game).
 */
olddie: function
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
	        setscore( global.score, global.turnsofar );
		abort;
	    }
	}
        else if ( resp = 'RESTART' )
	{
	    setscore( 0, 0 );
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
	        setscore(global.score, global.turnsofar);
		abort;
	    }
	    else
		"Sorry, no undo information is available. ";
	}
    }
}

die: function
{
    if (global.complex_death)
	newdie();		/* Dungeon style */
    else
	olddie();		/* TADS style */
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
    local rank, title, eg, max;

    max := global.endgame ? global.emaxscore : global.maxscore;
    if (global.score < 0)
	rank := -1;
    else
	rank := (global.score * 20) / max;
	   
    if (global.endgame) {
	eg := ' in the endgame';
	if (rank >= 20)      title := 'Dungeon Master';
	else if (rank >= 15) title := 'Super Cheater';
	else if (rank >= 10) title := 'Master Cheater';
	else if (rank >= 5)  title := 'Advanced Cheater';
	else if (rank >= 0)  title := 'Cheater';
	else                 title := 'Nebbish';  /* negative */
    } else {
	if (rank >= 20)      title := 'Cheater';
	else if (rank >= 19) title := 'Wizard';
	else if (rank >= 18) title := 'Master';
	else if (rank >= 16) title := 'Winner';
	else if (rank >= 12) title := 'Hacker';
	else if (rank >= 8)  title := 'Adventurer';
	else if (rank >= 4)  title := 'Junior Adventurer';
	else if (rank >= 2)  title := 'Novice Adventurer';
	else if (rank >= 1)  title := 'Amateur Adventurer';
	else if (rank >= 0)  title := 'Beginner';
	else                 title := 'Nebbish';   /* negative */
    }
    "Your score<<eg>> is <<global.score>> [total of <<max>>],
    in <<global.turnsofar>> move<<global.turnsofar=1?'':'s'>>.\n
    This gives you the rank of <<title>>.\n";
}

/*
 *   The init() function is run at the very beginning of the game.
 *   It should display the introductory text for the game, start
 *   any needed daemons and fuses, and move the player's actor ("Me")
 *   to the initial room, which defaults here to "westHouse".
 */
init: function
{
    local o;
    
#ifndef __DEBUG
    randomize();
#endif

    /* check for a file to restore specified as a startup parameter */
    if (restore(nil) = nil)
    {
	"\b[Restoring saved game]\b";
	scoreStatus(global.score, global.turnsofar);
	Me.location.lookAround(true);
	return;
    }

    /* put introductory text here */
    
    "\b";
    version.sdesc;                 // display the games name and version number
    "\b";
    
    setdaemon( turncount, nil );               // start the turn counter daemon
    
    /* start villain heartbeats */
    o := firstobj(villain);
    while( o ) {
	notify(o, &heartbeat, 0);
	o := nextobj(o, villain);
    }
    
    notify(thief, &thiefdaemon, 0);
    
    Me.location := westHouse;                // move player to initial location
    westHouse.lookAround( true );                    // show player where he is
    westHouse.isseen := true;                 // note that we''ve seen the room
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
    initThief();
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
    /* "I beg your pardon? "; */
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
    doSay( actor ) =
	"No one seems to be listening. "

    /* All the rest here is for incantations (skipping to endgame quickly) */
    
    verDoIncant( actor ) =
    {
	local w1, w2, i, len;
	value := upper(value);

	/* trim leading spaces */
	for (i := 1; substr(value,i,1) = ' '; i++);
	if (i > 1) value := substr(value, i, length(value)-1);

	w2 := '';
	i := find(value, ' ');
	if (i = nil) {
	    w1 := value;
	} else {
	    w1 := substr(value, 1, i-1);
	    i++;
	    /* trim trailing spaces */
	    for(len := length(value); substr(value,len,1) = ' '; len--);
	    
	    /* look for second word */
	    while ( i <= len and substr(value,i,1) = ' ')
		i++;
	    if (i <= len)
		w2 := substr(value, i, len-i+1);
	}

	/* now process the words */
	if (w2 = '') {
	    if (self.gavecode)
		"Sorry, only one incantation to a customer. ";
	    else if (not topStairs.isseen)
		"That spell has no obvious effect. ";
	    else {
		/* we've seen topStairs and haven't given code yet */
		"A hollow voice replies: \"<<w1>> <<self.encrypt(w1)>>\"\n";
		self.gavecode := true;
	    }
	} else {
	    if (topStairs.isseen)
		"Incantations are useless once you have gotten this far. ";
	    else if (w2 <> self.encrypt(w1))
		"That spell doesn't appear to have done anything useful. ";
	    else {
		"As the last syllable of your spell fades into silence,
		darkness envelops you, and the earth shakes briefly.
		Then all is quiet.\b";
		if (crypt.scoreval <> nil) {
		    incscore(crypt.scoreval);
		    crypt.scoreval := nil;
		}
		crypt.startend3;
		self.gavecode := true;
	    }
	}
    }

    gavecode = nil

    encrypt( w ) =
    {
	local i, j, code, map;
	while (length(w) < 8)
	    w := w + w;
	map := 'BPMXKZHSJDOAQTFVUGWICRELYN';
	code := '';
	for (i := 1; i <= 8; i++) {
	    j := find(map, substr(w,i,1));
	    if (j = nil)
		j := 0;
	    j += i;
	    if (j > 26) j-=26;
	    code := code + substr(map, j, 1);
	}
	return code;
    }
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
    maxscore = 616                                    // maximum possible score
    emaxscore = 100                                    // max score for endgame
    verbose = nil                             // we are currently in TERSE mode
    lamplist = []              // list of all known light providers in the game
    lastMealTime = 0       // bogus - not used, but rather than change fooditem
    eatTime = 0				// ditto
    sleepTime = 0			// ditto
    
    badluck = nil		/* affects some probabilities */
    endgame = nil		/* are we in end game or not */
    numdeaths = 0		/* used with global.complex_death */

    tv = nil			/* last travel verb (hack) */
    
    /* game options */
    complex_death = true	/* dungeon/tads death style */
    showscore = nil		/* notify when score changes */
;

/*
 *   The "version" object defines, via its "sdesc" property, the name and
 *   version number of the game.  Change this to a suitable name for your
 *   game.
 */
version: object
    sdesc = "Welcome to Dungeon, the TADS port (0.3 beta).\n
	    Based on Dungeon V3.1, Copyright (C) by Infocom."
    contact =
	"\n
	\tDarin Johnson\n
	\tdjohnson@cs.ucsd.edu
	\n"
;

/*
 *   "Me" is the player's actor.  Pick up the default definition, basicMe,
 *   from "adv.t".
 */
Me: basicMe, fighter
    sdesc = "cretin"
    ldesc = "I see nothing special about the cretin. "
    noun = 'cretin' 'self'
    maxbulk = 100
    
    /* handle rooms that are no longer able to be entered */
    /* (also in movableActor) */
    travelTo( room ) =
    {
	if (room and room.munged <> nil) {
	    /* munged is the object that caused the trouble */
	    room.munged.showmunged;
	    return;
	} else
	    pass travelTo;
    }

    died = ( die() )
    
    isdead = nil

    /* If we're dead, we can see in dark, so make us a lamp */
    islamp = true
    islit = ( self.isdead )
    
    actorAction( verb, dobj, prep, iobj ) =
    {
	global.tv := nil;
	
	if (isdead) {
	    switch(verb) {
	    case attackVerb:
	    case breakVerb:
	    case kickVerb:
		"All such attacks are vain in your position. "; break;
	    case openVerb:
	    case closeVerb:
	    case eatVerb:
	    case drinkVerb:
	    case inflateVerb:
	    case deflateVerb:
	    case turnVerb:
	    case tieVerb:
	    case untieVerb:
	    case burnVerb:
		"Even such a simple action is beyond your capabilities. ";
		break;
	    case turnOnVerb:
		"You need no light to guide you. "; break;
	    case scoreVerb:
		"How can you think of your score in your condition? ";
	    case askVerb:
	    case tellVerb:
		"No one can hear you. "; break;
	    case takeVerb:
		"You hand passes through the object. "; break;
	    case dropVerb:
	    case throwVerb:
	    case iVerb:
		"You have no possessions. "; break;
	    case diagnoseVerb:
		"You are dead. "; break;
	    case prayVerb:
		if (self.isIn(altar)) {
		    self.isdead := nil;
		    "From the distance the sound of a lone trumpet is heard.
		    The room becomes very bright, and you feel disembodied.
		    In a moment, the brightness fades, and you find yourself
		    rising, as if from a long sleep, deep in the woods.
		    In the distance you can faintly hear a song bird and
		    the sounds of the forest. ";
		    location.leaveRoom( self );
		    self.moveInto(forest1);
		} else
		    "Your prayers are not heard. ";
		break;;
	    case lookVerb:
		if (itemcnt(self.location.contents))
		    "The room looks strange and unearthly, and objects appear
		    indistinct.\n";
		else
		    "The room looks strange and unearthly.\n";
		if (not self.location.islit)
		    "Although there is no light, the room seems dimly
		    illuminated.\n";
		return;		/* continue with this verb */
		
	    default:
		if (verb.isTravelVerb or verb.issysverb)
		    return;
		"You can't even do that. ";
	    }
	    exit;
	}
    }

    verDoAttackWith( actor, io ) = { }
    doAttackWith( actor, io ) =
    {
	"If you insist... Poof, you're dead! ";
	self.died;
    }
    doBreak( actor ) = ( self.doAttackWith( actor, nil ) )
;

/*
 *   darkTravel() is called whenever the player attempts to move from a dark
 *   location into another dark location.  By default, it just says "You
 *   stumble around in the dark," but it could certainly cast the player into
 *   the jaws of a grue, whatever that is...
 */
darkTravel: function
{
    "Oh, no!  You walked into the slavering fangs of a lurking grue. ";
    Me.died;
}

/* Just the same, but called when the movement is an invalid exit */
darkTravel2: function
{
    "Oh, no!  A fearsome grue slithered into the room and devoured you. ";
    Me.died;
}

/* modified version of incscore - detects endgame */
replace incscore: function( amount )
{
    local tmp;
    global.score += amount;
    if (global.showscore) {
	if (amount = 1)
	    "\b[Your score just went up by 1 point]\n";
	else if (amount = -1)
	    "\b[Your score just went down by 1 point]\n";
	else if (amount > 0)
	    "\b[Your score just went up by <<amount>> points]\n";
	else if (amount < 0)
	    "\b[Your score just went down by <<-amount>> points]\n";
    }
    scoreStatus( global.score, global.turnsofar );

    tmp := (global.numdeaths = 0) ? 0 : 10;
    if (not global.endgame and global.score + tmp >= global.maxscore)
	notify(crypt, &startend1, 15);
}

/************ Echoing stuff ***************/

preparse: function(line) {
    if (LOUD.echoing)
	return( LOUD.doinput(line) );
    return( true );
}

parseError: function(num, str)
{
    if (LOUD.echoing) {
	LOUD.doecho;
	return( '' );
    }
    return( nil );
}
