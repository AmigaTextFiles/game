/* Carousel and machine room */

roundRoom: darkroom		//  83
    sdesc = "Round Room"
    ldesc = {
	"This is a circular room with passages off in eight directions.\n";
	if (self.ison and not Me.isdead)
	    "Your compass needle spins wildly, and you cannot get your
	    bearings. ";
    }

    ison = true			/* are we turned on? */
    spedup = nil		/* have we been sped up? */

    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (self.spedup and not actor.isdead) {
	    "According to Prof. TAA of MIT Tech, the rapidly changing magnetic
	    fields in the room are so intense as to cause %you% to be
	    electrocuted.  I really don't know, but in any event, something
	    just killed %you%. ";
	    actor.died;
	}
    }

    exits = [engrCave,engrCave,grailRoom,ewPassage,canyon,nsPass,
	     windingPassage,maze1]
	     
    // --Exits
    randleave = ( self.exits[rand(length(exits))] )
    leave(a,dest) =
    {
	if (a and ison) {
	    "Unfortunately, it is impossible to tell directions in here.\b";
	    return( self.randleave );
	}
	return( dest );
    }
    north(a) = ( self.leave(a, engrCave) )
    south(a) = ( self.leave(a, engrCave) )
    east(a) = ( self.leave(a, grailRoom) )
    west(a) = ( self.leave(a, ewPassage) )
    nw(a) = ( self.leave(a, canyon) )
    ne(a) = ( self.leave(a, nsPass) )
    se(a) = ( self.leave(a, windingPassage) )
    sw(a) = ( self.leave(a, maze1) )
    out(a) = ( a = nil ? coldPassage: self.randleave )
;

dentedbox: openable	//  39
    sdesc = "steel box"
    noun = 'box'
    adjective = 'steel' 'dented'
    heredesc = "There is a dented steel box here."
    /* location = roundRoom    not here initially! */
    bulk = 40
    maxbulk = 20
    isopen = nil
;

violin: treasure		//  40
    sdesc = "fancy violin"
    noun = 'violin' 'stradivarius'
    adjective = 'fancy'
    heredesc = "There is a Stradivarius here."
    location = dentedbox
    findscore = 10
    trophyscore = 10
    bulk = 10

    verDoPlay( actor ) = { }
    doPlay( actor ) = "An amazingly offensive noise issues from the violin. "
    verDoPlayWith( actor, io ) = { }
    doPlayWith( actor, io ) =
    {
	if (isclass(io, weapon)) {
	    self.trophyscore := 0;
	    "Very good.  The violin is now worthless. ";
	} else {
	    self.doPlay(actor);
	}
    }
;

lowRoom: darkroom		// 138
    sdesc = "Low Room"
    ldesc =
	"This is a room with a low ceiling which is circular in shape.
	There are exits to the east and southeast.\n"

    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (self.ison and not actor.isdead) {
	    if (roundRoom.spedup) {
		if (actor <> Me)
		    "According to Prof. TAA of MIT Tech, the rapidly changing
		    magnetic fields in the room are so intense as to fry all
		    the delicate innards of the robot.  I really don't know,
		    but in any event, smoke is coming out of its ears, and it
		    has stopped moving. ";
		else
		    "According to Prof. TAA of MIT Tech, the rapidly changing
		    magnetic fields in the room are so intense as to cause you
		    to be electrocuted.  I really don't know, but in any event,
		    something just killed you. ";
		actor.died;
	    } else
		"As you enter, your compass starts spinning wildly. ";
	}
    }

    ison = ( not roundRoom.ison )
    
    leave(a, dest) =
    {
	if (a and self.ison) {
	    "Unfortunately, it is impossible to tell directions in here.\b";
	    return( (rand(2) = 1) ? machineRoom2 : teaRoom );
	}
	return( dest <> nil ? dest : self.noexit(a) );
    }
    
    // --Exits
    north(a) = ( self.leave(a, nil) )
    south(a) = ( self.leave(a, nil) )
    east(a) = ( self.leave(a, machineRoom2) )
    west(a) = ( self.leave(a,nil) )
    ne(a) = ( self.leave(a, nil) )
    se(a) = ( self.leave(a, teaRoom) )
    sw(a) = ( self.leave(a, nil) )
    nw(a) = ( self.leave(a, nil) )
    out(a) = ( self.leave(a, teaRoom) )
;

robot: Actor		// 142
    sdesc = "robot"
    noun = 'robot' 'robby' 'c3po' 'r2d2'
    heredesc = "There is a robot here."
    location = lowRoom
    bulk = 0

    goodverbs =
	[takeVerb,dropVerb,putVerb,pushVerb,throwVerb,turnVerb,jumpVerb]
    actorAction( v, d, p, i ) =
    {
	if (Me.isdead) {
	    "You are ignored. ";
	    exit;
	}
	if (v = liftVerb and d = cage) {
	    cage.raise(self);
	} else if (v = drinkVerb or v = eatVerb) {
	    "\"I am sorry but that action is difficult for a being with
	    no mouth.\"";
	} else if (v = readVerb) {
	    "\"My vision is not sufficiently acute to read such small type.\"";
	} else if (v.isTravelVerb or find(goodverbs, v)) {
	    "\"Whirr, buzz, click!\"\n";
	    return;		/* allow to proceed */
	} else {
	    "\"I am only a stupid robot and cannot perform that command.\" ";
	}
	exit;
    }

    verGrab( item ) = { }	/* robot is cooperative :-) */
    
    ioGiveTo( actor, dobj ) =
    {
	dobj.moveInto(self);
	"The robot gladly takes <<dobj.thedesc>> and nods his head-like
	appendage in thanks. ";
    }
    doBreak( actor ) =
    {
	"The robot is injured (being of shoddy construction) and falls to the
	floor in a pile of garbage, which disintegrates before your eyes. ";
	self.moveInto(nil);
    }
    ioThrowAt( actor, dobj ) =
    {
	dobj.moveInto(actor.location);
	self.doBreak( actor );
    }
;

greenpaper: readable,burnable	// 143
    sdesc = "green piece of paper"
    noun = 'piece' 'paper'
    adjective = 'green'
    heredesc = "There is a green piece of paper here."
    ldesc = "\t!!!! FROBOZZ MAGIC ROBOT COMPANY !!!!
	    \b
	    Hello, master!
	    \b\t
	    I am a late-model robot, trained at MIT Tech to perform various
	    simple housekeeping functions.
	    \b
	    Instructions for use:
	    \b
	    \tTo activate me, use the following formula--\n
	    \tROBOT, <something to do> (cr)\n
	    \b
	    Warranty:
	    \b\t
	    No warranty is expressed or implied.
	    \b
	    At your service!"
    
    // Earlier had:
    //     To activate me, use the following formula--
    //     TELL ROBOT "something to do"(cr)
    //     The quotation marks are mandatory.

    location = lowRoom
    bulk = 3
;

machineRoom2: darkroom	// 139
    sdesc = "Machine Room"
    ldesc = "This is a large room full of assorted heavy machinery.  The room
	    smells of burned resistors.  The room is noisy from the whirring
	    sounds of the machines.  Along one wall of the room are three
	    buttons which are, respectively, round, triangular, and square.
	    Naturally, above the buttons are instructions written in EBCDIC.
	    A large sign above all the buttons says in English:
	    \b
	    \t\t	    DANGER:  HIGH VOLTAGE
	    \b
	    There are exits to the west and the south."
    
    // --Exits
    west(a) = lowRoom
    south(a) = closet
;

squareb: buttonitem		// 127
    sdesc = "square button"
    adjective = 'square'
    location = machineRoom2

    doPush( a ) =
    {
	if (a = Me) {
	    "There is a giant spark, and you are fried to a crisp. ";
	    Me.died;
	} else {
	    if (roundRoom.spedup) {
		"Nothing seems to happen. ";
	    } else {
		"The whirring increases in intensity slightly. ";
		roundRoom.spedup := true;
	    }
	}
    }
;

roundb: buttonitem	// 128
    sdesc = "round button"
    adjective = 'round'
    location = machineRoom2

    doPush( a ) =
    {
	if (a = Me) {
	    "There is a giant spark, and you are fried to a crisp. ";
	    Me.died;
	} else {
	    if (roundRoom.spedup) {
		"The whirring decreases in intensity slightly. ";
		roundRoom.spedup := nil;
	    } else {
		"Nothing seems to happen. ";
	    }
	}
    }
;

triangularb: buttonitem	// 129
    sdesc = "triangular button"
    adjective = 'triangular'
    location = machineRoom2

    doPush( a ) =
    {
	if (a = Me) {
	    "There is a giant spark, and you are fried to a crisp. ";
	    Me.died;
	} else {
	    roundRoom.ison := not roundRoom.ison;
	    if (not roundRoom.ison)
		roundRoom.isseen := nil;
	    if (dentedbox.location = nil)
		dentedbox.moveInto(roundRoom);
	    else if (dentedbox.location = roundRoom)
		dentedbox.moveInto(nil);
	    else {
		"Click. ";
		return;
	    }
	    "A dull thump is heard in the distance. ";
	}
    }
;

closet: room		// 140
    sdesc = "Dingy Closet"
    ldesc = "This is a dingy closet adjacent to the machine room.  On one wall
	    is a small sticker which reads:
	    \b
	    \t\t\tProtected by\n
	    \t\t\t\ \ FROBOZZ\n
	    \t\t\ Magic Alarm Company\n
	    \t\t\ \ (Hello, footpad!).\n"
    // --Exits
    north(a) = machineRoom2
;

palantir1: palantir	// 126
    sdesc = "white crystal sphere"
    noun = 'sphere' 'ball' 'palantir' 'stone'
    adjective = 'crystal' 'glass' 'white' 'seeing'
    heredesc = "There is a beautiful white crystal sphere here."
    location = closet
    findscore = 6
    trophyscore = 6
    bulk = 10
    sacred = true

    othersphere = palantir2
    
    takeable = nil
    doTake( a ) =
    {
	if (takeable)
	    pass doTake;
	else
	    cage.drop(a);
    }
;

/* Unused, we made cage a nested room */
insideCage: fixeditem, nestedroom	// 141
    sdesc = "Cage"
    ldesc = "You are trapped inside a steel cage."
    
;

mangledcage: item	// 124
    sdesc = "steel cage"
    noun = 'cage'
    adjective = 'steel' 'mangled'
    heredesc = "There is a mangled steel cage here."
    bulk = 60
;

cage: immobile, nestedroom		// 125
    sdesc = "steel cage"
    noun = 'cage'
    adjective = 'steel'
    heredesc = "There is a steel cage in the middle of the room."

    /* nested (trapped) room stuff */
    statusPrep = "trapped in"
    reachable = ([robot] + self) /* can give robot commands */
    roomAction( actor, v, dobj, prep, io ) =
    {
        if ( dobj<>nil and v<>inspectVerb )
            checkReach( self, actor, v, dobj );
        if ( io<>nil and v<>askVerb and v<>tellVerb )
            checkReach( self, actor, v, io );
	pass roomAction;
    }
    enterRoom( actor ) = {}
    noexit(a) =
    {
        if (a <> nil)
            "You're trapped in the cage, remember? ";
	return( nil );
    }

    /* raise/drop stuff */
    showmunged = "You are stopped by a cloud of poisonous gas. "
    
    drop(a) =
    {
	if (a = robot) {
	    "As the robot reaches for sphere, a steel cage falls from the
	    ceiling.  The robot attempts to fend it off but is trapped below
	    it.  Alas, the robot short circuits in his vain attempt to escape
	    and crushes the sphere beneath him as he falls to the floor. ";
	    palantir1.moveInto(nil);
	    robot.moveInto(nil);
	    mangledcage.moveInto(closet);
	} else {
	    "As you reach for the sphere, a steel cage falls from the ceiling
	    to entrap you.  To make matters worse, poisonous gas starts coming
	    into the room.\n";
	    if (not robot.isIn(closet)) {
		self.poison;
	    } else {
		Me.moveInto(self);
		self.moveInto(closet);
		notify(self, &poison, 10);
	    }
	}
    }
    raise(a) =
    {
	unnotify(self, &poison);
	Me.moveInto(closet);
	"The cage shakes and is hurled across the room.\n";
	self.moveInto(nil);
	palantir1.takeable := true;
    }

    poison =
    {
	closet.munged := self;
	"Time passes... and you die from some obscure poisoning. ";
	Me.died;
    }

    verDoUnboard( a ) = "You'll have to try harder than that! "
    verDoLift( a ) = "It can't be moved! "
;
