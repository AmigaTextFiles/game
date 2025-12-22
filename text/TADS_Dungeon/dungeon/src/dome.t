/* Dome room and below, with Dreary room */

domeRoom: darkroom		//  79
    sdesc = "Dome Room"
    ldesc = {
	"This is the periphery of a large dome, which forms the ceiling of
	another room below.  Protecting you from a precipitous drop is a
	wooden railing which circles the dome. ";
	if (rope.tiedto = rail)
	    "Hanging down from the railing is a rope which ends about ten feet
	    from the floor below. ";
    }

    roomDrop( ob ) =
    {
	if (ob = rope and rope.tiedto = nil) {
	    rope.moveInto( torchRoom );
	    "The rope drops gently to the floor below. ";
	} else
	    pass roomDrop;
    }

    roomAction( a, v, d, i, p ) =
    {
	if (v = jumpVerb and d = nil) {
	    "I'm afraid that the leap %you% attempted has done %you% in. ";
	    a.died;
	    exit;
	}
    }

    // --Exits
    east(a) = rockyCrawl
    down(a) =
    {
	if (rope.tiedto <> rail) {
	    "You cannot go down without fracturing many bones. ";
	    return( nil );
	}
	return( torchRoom );
    }    
;

rail: fixeditem		//  75
    sdesc = "wooden railing"
    noun = 'rail' 'railing'
    adjective = 'wooden'
    location = domeRoom
    bulk = 5

    verIoTieTo( a ) = { }
    ioTieTo( a, dobj ) =
    {
	dobj.doTieTo( a, self );
    }
;

torchRoom: darkroom		//  80
    sdesc = "Torch Room"
    ldesc = {
	"This is a large room with a prominent doorway leading to a down
	staircase.  To the west is a narrow twisting tunnel, covered with
	a thin layer of dust.  Above you is a large dome painted with scenes
	depicting elfin hacking rites.  Up around the edge of the dome (20
	feet up) is a wooden railing.  In the center of the room there is
	a white marble pedestal. ";
	if (rope.tiedto = rail)
	    "A large piece of rope descends from the railing above, ending
	    some five feet above your head. ";
    }

    // --Exits
    down(a) = nsCrawl
    west(a) = tinyRoom
    up(a) = { "You cannot reach the rope."; return( nil ); }
;

torch: treasure,lamp		//  34
    sdesc = ( islit ? "ivory torch" : "burned out ivory torch" )
    adesc =
    {
	if (islit)
	    "an ivory torch";
	else
	    "a burned out ivory torch";
    }
    noun = 'torch' 'ivory'
    adjective = 'ivory'
    heredesc = "There is <<self.adesc>> here."
    origdesc = "Sitting on the pedestal is a flaming torch, made of ivory."
    location = torchRoom
    findscore = 14
    trophyscore = 6
    bulk = 20
    istool = true
    
    hasflame = (self.islit)	/* it's flaming */
    islit = true		/* almost always on */

    verDoTurnoff(a) =
    {
	if (islit)
	    "Your burn your hand as you attempt to extinguish the flame. ";
	else
	    "It's not lit. ";
    }
    verDoTurnon(a) =
    {
	if (islit)
	    "It is already on. ";
	else
	    "It doesn't light. ";
    }
    douse( a ) =
    {
	if (islit)
	    "The water evaporates before it can get close. ";
	else
	    pass douse;
    }
;

/* routines for tinyRoom and drearyRoom */
class td_room: room
    ldesc =
    {
	self.longdesc;
	"On the <<self.doordir>> side of the room is a massive wooden door,
	near the top of which, in the center, is a window barred with iron.
	A formidable bolt lock is set within the door frame.  A keyhole ";
	if (not self.mylid.isopen)
	    "covered by a thin metal lid ";
	"lies within the lock. ";
	if (oakdoor.isopen)
	    "The door is open. ";
	/* Sigh, do this here, so the item doesn't show up if we
	 * look through the window from the other side...
	 */
	if (car(self.mykeyhole.contents))
	    "\n\^<<car(self.mykeyhole.contents).adesc>> is in place
	    within the keyhole. ";
    }
    reachable = [oakdoor barredwindow]
    sacred = true

    enterRoom( actor ) =
    {
	if (mat.underdoor)
	    mat.moveInto(self);	/* it's in both rooms */
	pass enterRoom;
    }
;

tinyRoom: td_room		// 192
    sdesc = "Tiny Room"
    longdesc = "This is a tiny room, which has an exit to the east. "
    doordir = 'north'
    mylid = keylid1
    mykeyhole = keyhole1
    
    // --Exits
    east(a) = torchRoom
    north(a) = ( checkDoor(oakdoor, drearyRoom, a) )
    in(a) = ( self.north(a) )
;

drearyRoom: td_room	// 193
    sdesc = "Dreary Room"
    longdesc =
	"This is a small and rather dreary room, which is eerily illuminated
	by a red glow emanating from a crack in one of the walls.  The light
	appears to focus on a dusty wooden table in the center of the room. "
    doordir = 'south'
    mylid = keylid2
    mykeyhole = keyhole2
    
    // --Exits
    south(a) = ( checkDoor(oakdoor, tinyRoom, a) )
    out(a) = ( self.south(a) )
;

oakdoor: floater,door		// 197
    sdesc = "door made of oak"
    noun = 'door'
    adjective = 'wooden' 'oak'
    ldesc =
    {
	if (mat.underdoor)
	    "The welcome mat is under the door. ";
	else
	    pass ldesc;
    }
    islocked = true
    islockable = true
    mykey = rustykey

    verDoLookunder( a ) = { }
    doLookunder( a ) = ( self.ldesc )

    verIoPutUnder( a ) = { }
    ioPutUnder( a, dobj ) =
    {
	/* sigh, is this more efficient than adding 'issmallpaper' all over? */
	if (find([tanlabel,bluelabel,card,greenpaper,warning], dobj)) {
	    "The paper is very small and vanishes under the door. ";
	    dobj.moveInto(a.isIn(tinyRoom) ? drearyRoom : tinyRoom);
	} else if (dobj = mat) {
	    mat.moveInto(a.location);
	    mat.underdoor := true;
	    "Done. ";
	} else {
	    "There is not enough room under this door. ";
	}
    }

    blocked =
    {
	local c1, c2;
	c1 := car(keyhole1.contents);
	c2 := car(keyhole2.contents);
	return( (c1 <> nil and c1 <> rustykey)
	        or
	        (c2 <> nil and c2 <> rustykey) );
    }
    doLockWith( a, io ) =
    {
	if (self.blocked)
	    "The keyhole is blocked. ";
	else
	    pass doLockWith;
    }
    doUnlockWith( a, io ) =
    {
	if (self.blocked)
	    "The keyhole is blocked. ";
	else
	    pass doUnlockWith;
    }

    doOpen( a ) =
    {
	inherited.doOpen(a);
	if (mat.underdoor and mat.holding <> nil) {
	    /* so we don't have to worry about "the key is on the mat" msgs */
	    "You knock something off of the mat as you open the door. ";
	    mat.holding.moveInto(a.isIn(tinyRoom) ? drearyRoom : tinyRoom);
	}
    }
;

barredwindow: floater	// 198
    sdesc = "barred window"
    noun = 'window' 'barred'

    verDoEnter( a ) = "Perhaps if you were diced... "
    verDoLookin( a ) = { }
    doLookin( a ) =
    {
	if (oakdoor.isopen) {
	    "The door is open, dummy. ";
	} else {
	    local dest;
	    dest := a.isIn(tinyRoom) ? drearyRoom : tinyRoom;
	    dest.longdesc;
	    "\n";
	    dest.showcontents;
	}
    }
;

class keyhole: fixeditem
    sdesc = "keyhole"
    noun = 'keyhole' 'hole'
    bulk = 5
    maxbulk = 12
    contentsVisible = nil	/* room handles this */
    
    otherkeyhole = nil
    mylid = nil
    
    verDoLookin( a ) = { }
    doLookin( a ) =
    {
	if (not mylid.isopen)
	    "The lid is in the way. ";
	else if (car(contents))
	    "\^<<car(contents).adesc>> is in the keyhole. ";
	else if (car(otherkeyhole.contents) <> nil
		 or not otherkeyhole.mylid.isopen)
	    "No light can be seen though the keyhole. ";
	else
	    "You can barely make out a lighted room at the other end. ";
    }

    /* Hmm, I guess I'll leave the lids up for now, since the
     * Fortran code is buggy here, and I'm not sure what the
     * intended effect for "the lid falls to cover the keyhole" was.
     */
    
    verIoPutIn( a ) =
    {
	if ( not mylid.isopen )
	    "The lid is in the way. ";
	else if (car(contents))
	    "The keyhole is blocked. ";
    }
    ioPutIn( a, dobj ) =
    {
	if (find([screwdriver,rustykey,stick,keys], dobj)) {
	    local tmp;
	    tmp := car(otherkeyhole.contents);
	    if ( tmp ) {
		"There is a faint noise from behind the door, and a small
		cloud of dust arises from beneath it.\n";
		if (mat.underdoor and mat.holding = nil)
		    tmp.moveInto(mat);
		else
		    tmp.moveInto(a.isIn(tinyRoom) ? drearyRoom : tinyRoom);
	    }
	    dobj.doPutIn( a, self );
	} else
	    "\^<<dobj.thedesc>> doesn't fit. ";
    }
;

keyhole1: keyhole	// 202
    location = tinyRoom
    otherkeyhole = keyhole2
    mylid = keylid1
;

keyhole2: keyhole	// 203
    location = drearyRoom
    otherkeyhole = keyhole1
    mylid = keylid2
;

class keylid: fixeditem
    sdesc = "metal lid"
    noun = 'lid'
    adjective = 'metal'

    isopen = nil
    mykeyhole = nil
    
    verDoOpen( a ) = { }
    doOpen( a ) =
    {
	"The lid is open. ";
	isopen := true;
    }
    verDoClose( a ) = { }
    doClose( a ) =
    {
	if (car(mykeyhole.contents))
	    "The keyhole is occupied. ";
	else {
	    "The lid covers the keyhole. ";
	    isopen := nil;
	}
    }
    doSynonym('Open') = 'Lift'
    doSynonym('Close') = 'Lower'
;

keylid1: keylid		// 200
    location = tinyRoom
    mykeyhole = keyhole1
;

keylid2: keylid		// 201
    location = drearyRoom
    mykeyhole = keyhole2
    isopen = true
;

crack: fixeditem		// 199
    sdesc = "narrow crack"
    noun = 'crack'
    adjective = 'narrow'
    location = drearyRoom
;

rustykey: keyItem	// 205
    sdesc = "rusty iron key"
    noun = 'key'
    adjective = 'rusty' 'iron'
    heredesc = "There is a rusty iron key here."
    location = keyhole2
    bulk = 5
    istool = true

    verDoTurn( a ) =
    {
	if (location = nil or not isclass(location, keyhole))
	    pass verDoTurn;
    }
    doTurn( a ) =
    {
	if (oakdoor.islocked)
	    oakdoor.doUnlockWith( a, self );
	else
	    oakdoor.doLockWith( a, self );
    }
;

table: fixeditem	// 204
    sdesc = "table"
    noun = 'table'
    adjective = 'wooden' 'dusty'
    location = drearyRoom
;

palantir2: palantir	// 206
    sdesc = "blue crystal sphere"
    noun = 'sphere' 'palantir' 'stone'
    adjective = 'crystal' 'glass' 'blue' 'seeing'
    heredesc = "There is a blue crystal sphere here."
    origdesc = "In the center of the table sits a blue crystal sphere."
    location = drearyRoom
    findscore = 10
    trophyscore = 5
    bulk = 5

    othersphere = palantir3
;
