/* The maze (curses) and cyclops */

/* How to get from where to where.

TR - M5; s,s,e,u      M5 - TR; n,w,s,w
M5 - GR; sw,u,e,ne    GR - M5; sw,d,e,n,d
M5 - CY; sw,e,s,ne    CY - M5; w,s,w,d

*/

class mazeroom: darkroom
    ismaze = true
    sdesc = "Maze"
    ldesc = "This is part of a maze of twisty little passages, all alike."
;

class mazedeadend: deadend
    ismaze = true
;

maze1: mazeroom		//  11
    west(a) = trollrm
    north(a) = maze1
    south(a) = maze2
    east(a) = maze4
;

maze2: mazeroom		//  12
    south(a) = maze1
    north(a) = maze4
    east(a) = maze3
;		   
		   
maze3: mazeroom	        //  13
    west(a) = maze2
    north(a) = maze4
    up(a) = maze5  
;		   
		   
maze4: mazeroom	        //  14
    west(a) = maze3
    north(a) = maze1
    east(a) = dead1
;		   
		   
dead1: mazedeadend	        //  15
    south(a) = maze4
;		   
		   
maze5: mazeroom	        //  16
    east(a) = dead2
    north(a) = maze3
    sw(a) = maze6
;

skeleton: immobile	//  21
    sdesc = "skeleton"
    noun = 'skeleton' 'bones' 'body'
    heredesc = "A skeleton, probably the remains of a luckless adventurer,
	       lies here."
    location = maze5
    bulk = 5

    dobjGen(a, v, i, p) =
    {
	if (isclass(v,sysverb) or v = inspectVerb)
	    return;
	"A ghost appears in the room and is appalled by your desecration
	of the remains of a fellow adventurer.  He casts a curse on
	all of your valuables and orders them banished to the land of
	the living dead.  The ghost leaves, muttering obscenities. ";
	stealtreasures(a, 100, landDead);
	exit;
    }
    iobjGen(a, v, i, p) = { self.dobjGen(a, v, i, p); }
    verDoInspect( a ) = { pass verDoInspect; }  /* allow looking */
;

deadlantern: item	//  22
    sdesc = "burned-out lantern"
    noun = 'lamp' 'lantern'
    adjective = 'broken' 'burned-out' 'dead' 'useless'
    heredesc = "There is a burned-out lantern here."
    origdesc = "The deceased adventurer's useless lantern is here."
    location = maze5
    bulk = 20

    verDoTurnon(a) = "It's broken. "
    verDoTurnoff(a) = "It's permanently extinguished. "
;

keys: keyItem		//  23
    sdesc = "set of skeleton keys"
    noun = 'keys' 'key' 'set'
    adjective = 'skeleton'
    heredesc = "There is a set of skeleton keys here."
    location = maze5
    bulk = 10
    istool = true
;

rustyknife: weapon	//  24
    sdesc = "rusty knife"
    noun = 'knife'
    adjective = 'rusty'
    heredesc = "There is a rusty knife here."
    origdesc = "Beside the skeleton is a rusty knife."
    location = maze5
    bulk = 20

    doTake(a) =
    {
	inherited.doTake(a);
	if (self.isIn(a) and sword.isIn(a))
	    "As you pick up the rusty knife, your sword gives a single pulse
	    of blinding blue light. ";
    }
    ioAttackWith( actor, dobj ) = 
    {
	/* oops */
	self.moveInto(nil);
	"As the knife approaches its victim, your mind is submerged by an
	overmastering will.  Slowly, your hand turns, until the rusty blade
	is an inch from your neck.  The knife seems to sing as it savagely
	cuts your throat.";
	actor.died;
    }
;

coins: treasure		//  25
    sdesc = "bag of coins"
    noun = 'bag' 'coins'
    adjective = 'old' 'leather'
    heredesc = "An old leather bag, bulging with coins, is here."
    location = maze5
    findscore = 10
    trophyscore = 5
    bulk = 15
;

dead2: mazedeadend		//  17
    west(a) = maze5
;

maze6: mazeroom		//  18
    down(a) = maze5
    east(a) = maze7
    west(a) = maze6
    up(a) = maze9
;

maze7: mazeroom		//  19
    up(a) = maze14
    west(a) = maze6
    ne(a) = dead1
    east(a) = maze8
    south(a) = maze15
;

maze8: mazeroom		//  20
    ne(a) = maze7
    west(a) = maze8
    se(a) = dead3
;

dead3: mazedeadend		//  21
    north(a) = maze8
;

maze9: mazeroom		//  22
    north(a) = maze6
    east(a) = maze11
    down(a) = maze10
    south(a) = maze13
    west(a) = maze12
    nw(a) = maze9
;

maze10: mazeroom		//  23
    east(a) = maze9
    west(a) = maze13
    up(a) = maze11
;

maze11: mazeroom		//  24
    ne(a) = gratingRoom
    down(a) = maze10
    nw(a) = maze13
    sw(a) = maze12
;

gratingRoom: darkroom	//  25
    sdesc = "Grating Room"
    ldesc = {
	"This is a small room near the maze.  There are twisty
	passages in the immediate vicinity. ";
	/* hmm, clean up this gratingitem stuff? */
	if (not grating.islocked)
	    "Above you is a grating.";
	else if (grating.isopen)
	    "Above you is an open grating with sunlight pouring in.";
	else
	    "Above you is a grating locked with a skull-and-crossbones lock.";
    }
    lightsOn = { return( grating.isopen ); }
    reachable = [grating]
    
    // --Exits
    sw(a) = maze11
    up(a) =
    {
	if (a = nil or grating.isopen)
	    return( clearing );
	else
	    "The grating is closed. ";
    }
;

maze12: mazeroom		//  26
    west(a) = maze5
    sw(a) = maze11
    east(a) = maze13
    up(a) = maze9
    north(a) = dead4
;

dead4: mazedeadend		//  27
    south(a) = maze12
;

maze13: mazeroom		//  28
    east(a) = maze9
    down(a) = maze12
    south(a) = maze10
    west(a) = maze11
;

maze14: mazeroom		//  29
    west(a) = maze15
    nw(a) = maze14
    ne(a) = maze7
    south(a) = maze7
;

maze15: mazeroom		//  30
    west(a) = maze14
    south(a) = maze7
    ne(a) = cyclopsRoom
;

cyclopsRoom: darkroom	// 101
    sdesc = "Cyclops Room"
    ldesc =
    {
	"This is a room with an exit on the west side, and a staircase
	leading up. ";
	if (self.hole)
	    "On the north of the room is a wall which used to be solid, but
	    which now has a cyclops-shaped hole in it. ";
    }

    hole = nil			/* is there a cyclops shaped hole? */

    roomAction( a, v, d, p, i ) =
    {
	if (v = odysseusVerb and cyclops.isIn(self)) {
	    "The cyclops, hearing the name of his father's deadly nemesis,
	    flees the room by knocking down the wall on the north side of the
	    room. ";
	    /* drop all (so it isn't a pain if we give him glass bottle) */
	    while( car(cyclops.contents) )
		car(cyclops.contents).moveInto(self);
	    cyclops.moveInto(nil);
	    unnotify(cyclops, &heartbeat);
	    hole := true;
	    exit;
	}
	pass roomAction;
    }

    // --Exits
    west(a) = maze15
    north(a) =
    {
	if (a = nil or self.hole)
	    return( strangePass );
	"The north wall is solid rock. ";
	return( nil );
    }
    up(a) =
    {
	if (a = nil or self.hole or cyclops.sleeping)
	    return( treasureRoom );
	"The cyclops doesn't look like he'll let you pass. ";
	return( nil );
    }
;

cyclops: cyclops_messages,villain	//  58
    sdesc = "cyclops"
    noun = 'cyclops' 'monster'
    adjective = 'one-eyed'
    location = cyclopsRoom
    heredesc =
    {
	if (self.sleeping)
	    "The cyclops is sleeping blissfully at the foot of the stairs.";
	else if (self.thirsty)
	    "The cyclops, having eaten the hot peppers, appears to be gasping.
	    His inflamed tongue protrudes from his man-sized mouth.";
	else if (self.rvcyc = 0)
	    "A cyclops, who looks prepared to eat horses (much less mere
	    adventurers), blocks the staircase.  From his state of health
	    and the bloodstains on the walls, you gather that he is not very
	    friendly, though he likes people.";
	else
	    "The cyclops is standing in the corner, eyeing you closely.  I
	    don't think he likes you very much.  He looks extremely hungry,
	    even for a cyclops.";
    }
    
    strength = 10000		/* owwie */
    
    sleeping = nil
    thirsty = nil
    rvcyc = 0
    
    heartbeat =
    {
	if (sleeping or Me.isdead)
	    return;		/* nothing happens if we're asleep */
	if (rvcyc <> 0 and Me.isIn(cyclopsRoom)) {
	    switch (rvcyc++) {
	    case 1:
		"\nThe cyclops seems somewhat agitated.\n"; break;
	    case 2:
		"\nThe cyclops appears to be getting more agitated.\n"; break;
	    case 3:
		"\nThe cyclops is moving about the room,
		looking for something.\n"; break;
	    case 4:
		"\nThe cyclops was looking for salt and pepper.  I think he is
		gathering condiments for his upcoming snack.\n"; break;
	    case 5:
		"\nThe cyclops is moving toward you in an unfriendly
		manner.\n"; break;
	    case 6:
		"\nYou have two choices:  1. Leave  2. Become dinner.\n";
		break;
	    default:
		"\n
		The cyclops, tired of all your games and trickery, eats you.\n
		The cyclops says, \"Mmm mmm!  Just like mom used to make 'em.\"
		\n";
		rvcyc := 0;
		Me.died;
	    }
	}
	pass heartbeat;
    }
    
    /* verbs for disturbing our slumber */
    verDoWakeup( actor ) =
    {
	if (not sleeping)
	    pass verDoWakeup;
    }
    doWakeup( actor ) =
    {
	"The cyclops yawns and stares at the thing that woke him.\n";
	fighting := true;	/* anger him */
	rvcyc := 0;		/* so we don't get other messages */
	sleeping := nil;
    }
    doAttackWith( actor, io ) =
    {
	if (sleeping)
	    self.doWakeup( actor );
	else {
	    "The cyclops ignores all injuries to his body with a shrug.\n";
	    /* No real attack - it can hit you, but...  */
	    if (fighting = nil and rvcyc = 0) rvcyc := 1;
	}
    }
    verDoPoke( actor ) =
    {
	if (not sleeping)
	    "\"Do you think I'm as stupid as my father?\" he says, dodging. ";
    }
    doPoke( actor ) = { self.doWakeup( actor ); }
    verDoKick( actor ) = { if (not sleeping) pass verDoKick; }
    doKick( actor ) = { self.doWakeup( actor ); }
    doBurnWith( actor, io ) =
    {
	if (sleeping)
	    self.doWakeup( actor );
	else
	    pass doBurnWith;
    }

    /* feed me! */
    ioGiveTo( actor, dobj ) =
    {
	if (dobj = garlic) {
	    "The cyclops is not so stupid as to eat that! ";
	} else if (dobj = lunch) {
	    /* feed him hot peppers */
	    "The cyclops says, \"Mmm mmm!  I love hot peppers!  But oh,
	    could I use a drink.  Perhaps I could drink the blood of that
	    thing.\"  From the gleam in his eye, it could be surmised that
	    you are \"that thing\". ";
	    dobj.moveInto(nil);
	    thirsty := true;
	    rvcyc := 1;  /* start getting anxious to eat player */
	} else if (dobj = somewater or (dobj = bottle and bottle.haswater)) {
	    if (thirsty) {
		/* drink water and put us to sleep */
		"The cyclops looks tired and quickly falls fast asleep
		(what did you put in that drink, anyway?). ";
		dobj.moveInto(self);
		somewater.moveInto(nil);
		sleeping := true;
		thirsty := nil;
		fighting := nil;
	    } else {
		"The cyclops is apparently not thirsty and refuses your
		generosity. ";
	    }
	} else {
	    "The cyclops may be hungry, but there is a limit. ";
	}
    }

    verDoTake( actor ) = "The cyclops doesn't take kindly to being grabbed. "
    verDoTieWith( actor, io ) =
	"You cannot tie the cyclops, although he is fit to be tied. "
;

strangePass: darkroom	// 102
    sdesc = "Strange Passage"
    ldesc = "This is a long passage.  To the south is one entrance.  On the
	    east there is an old wooden door with a large hole in it (about
	    cyclops sized)."
    scoreval = 10
    
    // --Exits
    south(a) = cyclopsRoom
    east(a) = livingrm
;
