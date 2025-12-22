/* The coal mines */

slideRoom: darkroom		//  58
    sdesc = "Slide Room"
    ldesc =
	"This is a small chamber, which appears to have been part of a
	coal mine.  On the south wall of the chamber the letters \"Granite
	Wall\" are etched into the rock.  To the east is a long passage,
	and there is a steep metal slide twisting downward.  To the north
	is a small opening.\n"
    lookAround( verbosity ) =
    {
	inherited.lookAround( verbosity );
	if (self.ropehere)
	    "\nThe rope is dangling down the slide.\n";
	/* Was described by making the coffin/timber invisible, and
	 * saying:
	 * A # is lying on the ground here.  Tied to it is a piece
	 * of rope, which is dangling down the slide.
	 */
    }
    reachable = [chute]
    ropehere = ( rope.tiedto <> nil and rope.tiedto.location = self )

    slip =
    {
	if (Me.location.isslide) {
	    "The rope slips from your grasp and you tumble down into the
	    cellar.\b";
	    Me.travelTo( cellar );
	}
    }
    
    // --Exits
    east(a) = coldPassage
    north(a) = mineEntrance
    down(a) =
    {
	if (a and not a.isdead and self.ropehere) {
	    local tmp;
	    "As you descend, you realize that the rope is slippery from the
	    grime of the coal chute and that your grasp will not last long.\n";
	    tmp := 100 / addbulk(a.contents);
	    if (tmp < 2) tmp := 2;
	    unnotify(self, &slip);
	    notify(self, &slip, tmp);
	    return( slide1 );
	}
	/* else just slide down to cellar */
	return( cellar );
	
    }
;

mineEntrance: darkroom	//  59
    sdesc = "Mine Entrance"
    ldesc = "You are standing at the entrance of what might have been a coal
	    mine.  To the northeast and the northwest are entrances to the
	    mine, and there is another exit on the south end of the room. "
    // --Exits
    south(a) = slideRoom
    nw(a) = squeaky
    ne(a) = shaftRoom
;

squeaky: darkroom		//  60
    sdesc = "Squeaky Room"
    ldesc = "This is a small room.  Strange squeaky sounds may be hear coming
	    from the passage at the west end.  You may also escape to the
	    south. "
    // --Exits
    west(a) = batRoom
    south(a) = mineEntrance
;

shaftRoom: darkroom		//  61
    sdesc = "Shaft Room"
    ldesc = "This is a large room, in the middle of which is a small shaft
	    descending through the floor into darkness below.  To the west and
	    the north are exits from this room.  Constructed over the top of
	    the shaft is a metal framework to which a heavy iron chain is
	    attached. "
    
    // --Exits
    west(a) = mineEntrance
    north(a) = woodTunnel
    down(a) =
    {
	"You wouldn't fit and would die if you could.";
	return( nil );
    }
;

class dumbwaiter: object	/* raise/lower routines for dumbwaiters */
    verDoLift( a ) =
    {
	if (dumbwaiter1.location = shaftRoom)
	    dummy();
    }
    doLift( a ) =
    {
	"The basket is raised to the top of the shaft. ";
	dumbwaiter1.moveInto(shaftRoom);
	dumbwaiter2.moveInto(lowerShaft);
    }
    verDoLower( a ) =
    {
	if (dumbwaiter1.location = lowerShaft)
	    dummy();
    }
    doLower( a ) =
    {
	"The basket is lowered to the bottom of the shaft. ";
	dumbwaiter1.moveInto(lowerShaft);
	dumbwaiter2.moveInto(shaftRoom);
    }
;

dumbwaiter1: dumbwaiter,immobile,container	//  35
    sdesc = "basket"
    noun = 'basket' 'cage' 'dumbwaiter' 'chain'
    heredesc = "At the end of the chain is a basket."
    location = shaftRoom
    maxbulk = 50

    verDoTake( a ) =
	"The cage is securely fastened to the iron chain. "
;

dumbwaiter2: dumbwaiter,fixeditem	//  36
    sdesc = "lowered basket"
    noun = 'basket' 'cage' 'dumbwaiter' 'chain'
    adjective = 'lowered'
    location = lowerShaft

    dobjGen( a, v, i, p ) =
    {
	if (v <> liftVerb and v <> lowerVerb) {
	    "The basket is at the other end of the chain. ";
	    exit;
	}
    }
    iobjGen( a, v, d, p ) = ( self.dobjGen( a, v, d, p ) )
;

woodTunnel: darkroom	//  62
    sdesc = "Wooden Tunnel"
    ldesc = "This is a narrow tunnel with large wooden beams running across
	    the ceiling and around the walls.  A path from the south splits
	    into paths running west and northeast. "
    // --Exits
    south(a) = shaftRoom
    west(a) = smellyRoom
    ne(a) = coalmine1
;

smellyRoom: darkroom	//  63
    sdesc = "Smelly Room"
    ldesc = "This is a small non-descript room.  However, from the direction
	    of a small descending staircase a foul odor can be detected.  To
	    the east is a narrow path. "
    
    // --Exits
    down(a) = gasRoom
    east(a) = woodTunnel
;

gasRoom: darkroom		//  64
    sdesc = "Gas Room"
    ldesc = "This is a small room which smells strongly of coal gas. "
    sacred = true

    enterRoom( actor ) =
    {
	local ob;
	ob := self.findflame( actor );
	if (ob <> nil) {
	    "\nOh, dear.  It appears that the smell coming from this room was
	    coal gas.  I would have thought twice about carrying
	    <<ob.adesc>> in here.\n";
	    "\t\t\t\tBOOOOOOOOOM\n";
	    actor.died;
	}
	unnotify(self, &checkflame);
	notify(self, &checkflame, 0);
	pass enterRoom;
    }

    checkflame =
    {
	local ob;
	/* assume actor is Me */
	if (not Me.isIn(self)) {
	    unnotify(self, &checkflame);
	    return;
	}
	ob := self.findflame( Me );
	if ( ob <> nil ) {
	    "\nI didn't realize that adventurers are stupid enough to light
    	    <<ob.adesc>> in a room which reeks of coal gas.  Fortunately,
    	    there is still justice in the world.";
	    "\t\t\t\tBOOOOOOOOOM\n";
	    Me.died;
	}
    }
    
    findflame( ob ) =
    {
	/* simplified, since only 3 things can have flames */
	if (matches.isIn( ob ) and matches.hasflame)
	    return( matches );
	if (candles.isIn( ob ) and candles.hasflame)
	    return( candles );
	if (torch.isIn( ob ) and torch.hasflame)
	    return( torch );
	return( nil );
    }
    
    // --Exits
    up(a) = smellyRoom
;

sapphire: treasure	//  37
    sdesc = "sapphire bracelet"
    noun = 'sapphire' 'bracelet' 'jewel'
    adjective = 'sapphire'
    heredesc = "There is a sapphire-encrusted bracelet here."
    location = gasRoom
    findscore = 5
    trophyscore = 3
    bulk = 10
;

ladderTop: darkroom		//  65
    sdesc = "Ladder Top"
    ldesc = "This is a very small room.  In the corner is a rickety wooden
	    ladder, leading downward.  It might be safe to descend.  There is
	    also a staircase leading upward. "
    // --Exits
    down(a) = ladderBot
    up(a) = coalmine7
;

class coalmine: darkroom
    sdesc = "Coal Mine"
    ldesc = "This is a non-descript part of a coal mine. "
;

coalmine1: coalmine		//  66
    north(a) = coalmine4
    sw(a) = coalmine2
    east(a) = woodTunnel
;

coalmine2: coalmine		//  67
    south(a) = coalmine1
    west(a) = coalmine5
    up(a) = coalmine3
    ne(a) = coalmine4
;

coalmine3: coalmine		//  68
    west(a) = coalmine2
    ne(a) = coalmine5
    east(a) = coalmine5
;

coalmine4: coalmine		//  69
    up(a) = coalmine5
    ne(a) = coalmine6
    south(a) = coalmine1
    west(a) = coalmine2
;

coalmine5: coalmine		//  70
    down(a) = coalmine6
    north(a) = coalmine7
    west(a) = coalmine2
    south(a) = coalmine3
    up(a) = coalmine3
    east(a) = coalmine4
;

coalmine6: coalmine		//  71
    se(a) = coalmine4
    up(a) = coalmine5
    nw(a) = coalmine7
;

coalmine7: coalmine		//  72
    east(a) = coalmine1
    west(a) = coalmine5
    down(a) = ladderTop
    south(a) = coalmine6
;

ladderBot: darkroom		//  73
    sdesc = "Ladder Bottom"
    ldesc = "This is a rather wide room.  On one side is the bottom of a narrow
	    wooden ladder.  To the northeast and the south are passages leaving
	    the room. "
    // --Exits
    ne(a) = dead5
    south(a) = timberRoom
    up(a) = ladderTop
;

dead5: deadend		//  74
    south(a) = ladderBot
    sw(a) = ladderBot		/* DBJ */
;

coal: burnable		//   5
    sdesc = "small pile of coal"
    noun = 'coal' 'pile' 'heap'
    adjective = 'small'
    heredesc = "There is a small heap of coal here."
    location = dead5
    bulk = 20
;

timberRoom: darkroom	//  75
    sdesc = "Timber Room"
    ldesc = "This is a long and narrow passage, which is cluttered with broken
	    timbers.  A wide passage comes from the north and turns at the
	    southwest corner of the room into a very narrow passageway. "
    sacred = true

    // --Exits
    north(a) = ladderBot
    sw(a) =
    {
	if (a <> nil) {
	    if (a.isdead)
		return( self.noexit( a ) );
	    if (itemcnt(a.contents) > 0) {
		"You cannot fit through this passage with that load. ";
		return( nil );
	    }
	}
	return( lowerShaft );
    }
;

timber: item		//  38
    sdesc = "broken timber"
    noun = 'timber' 'pile'
    adjective = 'broken' 'wooden' 'wood'
    heredesc =
    {
	if (rope.tiedto = self)
	    "The coil of rope is tied to the wooden timber.";
	else
	    "There is a wooden timber on the ground here.";
    }
    location = timberRoom
    bulk = 50

    verIoTieTo( a ) = { }
    ioTieTo( a, dobj ) =
    {
	dobj.doTieTo( a, self );
    }

    doTake( a ) =
    {
	if (rope.tiedto = self) {
	    "The rope comes loose as you take <<self.thedesc>>.\n";
	    rope.untie;
	}
	pass doTake;
    }
;

lowerShaft: darkroom	//  76
    sdesc = "Lower Shaft"
    ldesc = "This is a small square room which is at the bottom of a long shaft
	    To the east is a passageway and to the northeast a very narrow
	    passage.  In the shaft can be seen a heavy iron chain. "
    sacred = true
    
    firstseen = { incscore(10); } /* only score if there's light */
    
    // --Exits
    east(a) = machineRoom1
    up(a) = { if (a) "The chain is not climbable."; return( nil ); }
    ne(a) =
    {
	if (a and itemcnt(a.contents) > 0) {
	    "You cannot fit through this passage with that load. ";
	    return( nil );
	}
	return( timberRoom );
    }
    out(a) = ( self.ne(a) )
;

machineRoom1: darkroom	//  77
    sdesc = "Machine Room"
    ldesc =
	"This is a large room which seems to be air conditioned.  In one
	corner there is a machine (?) which is shaped somewhat like a clothes
	dryer.  On the \"panel\" there is a switch which is labeled in an
	obscure dialect of Swahili.  Fortunately, I know this dialect, and
	the label translates to START.  The switch does not appear to be
	manipulable by any human hand (unless the fingers are about 1/16 by
	1/4 inch).  On the front of the machine is a large lid, which is
	<<machine.isopen ? "open" : "closed">>. "
    
    // --Exits
    nw(a) = lowerShaft
    west(a) = lowerShaft	/* DBJ */
;

machine: fixeditem,openable		//   7
    sdesc = "machine"
    noun = 'machine' 'pdp10' 'vax' 'dryer' 'lid'
    location = machineRoom1
    bulk = 10000
    maxbulk = 50
    isopen = nil
    
    openMessage(a) = "The lid opens. "
    closeMessage(a) = "The lid closes. "

    verDoTurnon( a ) = { askio( withPrep ); }
    verDoTurnonWith( a, io ) = { }
    doTurnonWith( a, io ) =
    {
	if (io <> screwdriver)
	    "It seems that <<io.adesc>> won't do. ";
	else if (machine.isopen)
	    "The machine doesn't seem to want to do anything. ";
	else {
	    local l, cur;
	    "The machine comes to life (figuratively) with a dazzling display
	    of colored lights and bizarre noises.  After a few moments, the
	    excitement fades.\n";
	    l := machine.contents;
	    while( cur := car(l) ) {
		if (cur = coal) {
		    cur.moveInto(nil);
		    diamond.moveInto(self);
		} else if (cur <> diamond) {
		    cur.moveInto(nil);
		    slag.moveInto(self); /* may be moved multiple times... */
		}
		l := cdr(l);
	    }
	}
    }
;

machineswitch: fixeditem		//  70
    sdesc = "switch"
    noun = 'switch'
    location = machineRoom1
    bulk = 5

    doTurnon -> machine
    doTurnonWith -> machine
    doFlip -> machine
;


diamond: treasure		//   8
    sdesc = "huge diamond"
    noun = 'diamond'
    adjective = 'huge' 'enormous'
    heredesc = "There is an enormous diamond (perfectly cut) here."
    findscore = 10
    trophyscore = 6
    bulk = 5
;

slag: item		//   4
    sdesc = "piece of vitreous slag"
    noun = 'slag' 'piece' 'gunk'
    adjective = 'vitreous'
    heredesc = "There is a small piece of vitreous slag here."
    bulk = 10

    /* The slag crumbles if we do *anything* to it */
    dobjGen( a, v, i, p ) = {
	"The slag turns out to be rather insubstantial and crumbles into dust
	at your touch.  It must not have been very valuable.\n";
	self.moveInto( nil );
	exit;			/* end of command */
    }
    iobjGen( a, v, i, p ) = { self.dobjGen( a, v, i, p ); }
;

batRoom: darkroom		//  78
    sdesc = "Bat Room"
    ldesc = {
	"This is a small room that has only one door, to the east. ";
	if (garlic.isIn(self))
	    "In the corner of the room on the ceiling is a large vampire bat
	    who is obviously deranged and holding his nose. ";
    }

    enterRoom( actor ) =
    {
	if (not (actor.isdead or actor.isCarrying(garlic))) {
	    bat.swoop( actor );
	    return;
	}
	pass enterRoom;
    }
    sacred = true
		
    // --Exits
    east(a) = squeaky
;

figurine: treasure	//   6
    sdesc = "jade figurine"
    noun = 'figurine' 'jade'
    adjective = 'jade'
    heredesc = "There is an exquisite jade figurine here."
    location = batRoom
    findscore = 5
    trophyscore = 5
    bulk = 10
;

bat: fixeditem		//  83
    sdesc = "bat"
    noun = 'bat'
    adjective = 'vampire'
    location = batRoom
    bulk = 5
    
    droplocs = [ladderTop,coalmine1,coalmine2,coalmine3,coalmine4,
		coalmine5,coalmine6,coalmine7,ladderBot]
		
    swoop( actor ) =
    {
	"A deranged giant vampire bat (a reject from WUMPUS) swoops down
	from the ceiling and lifts you away...\b";
	actor.travelTo(self.droplocs[rand(9)]);
    }

    verDoInspect( a ) = { pass verDoInspect; }	// not allowed in Fortran vers
    dobjGen( a, v, i, p ) = { self.swoop( a ); exit; }
    iobjGen( a, v, d, p ) = { self.swoop( a ); exit; }
;

class inslide: darkroom
    sdesc = "Slide"
    sacred = true
    isslide = true
    reachable = [ropepiece chute]

    roomDrop( obj ) =
    {
	"\^<<obj.thedesc>> falls down the slide and is gone. ";
	obj.moveInto( cellar );
    }
;

slide1: inslide		// 194
    ldesc = "This is an uncomfortable spot within the coal chute.  The rope to
	    which you are clinging can be seen rising into the darkness above.
	    There is more rope dangling below you. "

    // --Exits
    down(a) = slide2
    up(a) = slideRoom
;

slide2: inslide		// 195
    ldesc = "This is another spot within the coal chute.  Above you the rope
	    climbs into the darkness.  The end of the rope is dangling five
	    feet beneath you. "

    // --Exits
    down(a) = slide3
    up(a) = slide1
;

slide3: inslide		// 196
    ldesc = "You have reached the end of your rope.  Below you is darkness as
	    the chute makes a sharp turn.  On the east here is a small ledge
	    which you might be able to stand on. "

    // --Exits    // --Exits
    down(a) = cellar
    up(a) = slide2
    east(a) = slideLedge
;

slideLedge: darkroom	// 197
    sdesc = "Slide Ledge"
    ldesc = "This is a narrow ledge abutting the coal chute, in which a rope
	    can be seen passing downward.  Behind you, to the south, is a
	    small room. "

    enterRoom( actor ) =
    {
	unnotify(slideRoom, &slip);
	pass enterRoom;
    }
    sacred = true
    reachable = [ropepiece chute]
    
    // --Exits
    down(a) = cellar
    up(a) = slide2
    south(a) = sootyRoom
;

ropepiece: floater,climbable	// 282
    sdesc = "piece of rope"
    noun = 'piece' 'rope'

    verDoTake( a ) = "What do you think is suspending %you% in mid air? "
    verDoDrop( a ) = { }
    doDrop( a ) =
    {
	"%You% tumble%s% down the chute to the cellar. ";
	a.travelTo( cellar );
    }
    verDoInspect( a ) = { pass verDoInspect; }
    verDoClimb( a ) = { pass verDoClimb; }
    verDoClimbdown( a ) = { pass verDoClimbdown; }
    dobjGen( a, v, i, p ) =
    {
	"It's not easy to play with the rope in your position. ";
	exit;
    }
    iobjGen( a, v, d, p ) = ( self.dobjGen( a, v, d, p ) )
;

chute: floater		// 283
    sdesc = "chute"
    noun = 'slide' 'chute'

    verIoPutIn( a ) = { }
    ioPutIn( a, dobj ) =
    {
	"\^<<dobj.thedesc>> falls down the slide and is gone. ";
	if (dobj = rope.tiedto) {
	    rope.untie;
	    rope.moveInto( cellar );
	}
	dobj.moveInto( cellar );
    }
;

sootyRoom: room		// 191
    sdesc = "Sooty Room"
    ldesc = "This is a small room with rough walls, and a ceiling which slopes
	    steeply from north to south.  There is coal dust covering almost
	    everything, and little bits of coal are scattered around the only
	    exit, which is a narrow passage to the north.  In one corner of the
	    room is an old coal stove which lights the room with a cherry red
	    glow.  There is a very narrow crack on the north wall. "
    sacred = true
    
    // --Exits
    north(a) = slideLedge
;

stove: fixeditem		// 208
    sdesc = "old coal stove"
    noun = 'stove'
    adjective = 'old'
    location = sootyRoom

    dobjGen( a, v, i, p ) =
    {
	"The intense heat of the stove keeps you away. ";
	exit;
    }
    iobjGen( a, v, d, p ) = ( self.dobjGen( a, v, d, p ) )
;

palantir3: palantir	// 209
    sdesc = "red crystal sphere"
    noun = 'sphere' 'palantir' 'stone'
    adjective = 'crystal' 'glass' 'red' 'seeing'
    heredesc = "There is a red crystal sphere here."
    origdesc = "On the floor sits a red crystal sphere."
    location = sootyRoom
    findscore = 10
    trophyscore = 5
    bulk = 5

    othersphere = palantir1
;
