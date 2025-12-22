/* Forest and House rooms/objects */

westHouse: room		//   2
    sdesc = "West of House"
    ldesc =
	"This is an open field west of a white house with a boarded
	front door. "
    sacred = true
    nowalls = true
    reachable = [house]

    // --Exits
    north(a) = northHouse
    south(a) = southHouse
    east(a) =
    {
	"The door is locked, and there is evidently no key. ";
	return( nil );
    }
    west(a) = forest1
;

mailbox: immobile, openable	//  53
    sdesc = "mailbox"
    noun = 'box' 'mailbox'
    adjective = 'small'
    heredesc = "There is a small mailbox here."
    location = westHouse
    maxbulk = 10
    isopen = nil
;

leaflet: readable,burnable	//  52
    sdesc = "leaflet"
    noun = 'leaflet' 'advertisement' 'pamphlet' 'booklet'
    adjective = 'small'
    heredesc = "There is a small leaflet here."
    ldesc =
	"\t\t\t\tWelcome to Dungeon!
	\b\t
	Dungeon is a game of adventure, danger, and low cunning.  In it you
	will explore some of the most amazing territory ever seen by mortal
	man. Hardened adventurers have run screaming from the terrors contained
	within.
	\b\t
	In Dungeon, the intrepid explorer delves into the forgotten secrets
	of a lost labyrinth deep in the bowels of the earth, searching for
	vast treasures long hidden from prying eyes, treasures guarded by
	fearsome monsters and diabolical traps!
	\b\t
	No system should be without one!
	\b\t
	Dungeon was created at the Programming Technology Division of the MIT
	Laboratory for Computer Science by Tim Anderson, Marc Blank, Bruce
	Daniels, and Dave Lebling.  It was inspired by the Adventure game of
	Crowther and Woods, and the long tradition of fantasy and science
	fiction games.  The original version was written in MDL (alias MUDDLE).
	The current version was translated from FORTRAN into TADS, a
	pointless act undertaken by someone who should have known better.
	\b\t
	On-line information may be obtained with the commands HELP and INFO."
    location = mailbox
    bulk = 2
;

mat: readable		// 207
    sdesc = "welcome mat"
    noun = 'mat'
    adjective = 'welcome' 'rubber'
    heredesc =
    {
	if (self.underdoor)
	    "The edge of a welcome mat is visible under the door.";
	else
	    "There is a welcome mat here.";
    }
    origdesc = "A rubber mat saying \"Welcome to Dungeon!\"\ lies by the door."
    ldesc = "Welcome to Dungeon!"
    location = westHouse
    contentsVisible = nil
    bulk = 12

    underdoor = nil
    holding = ( car(contents) )

    verDoMove( a ) =
    {
	if (not underdoor)
	    pass verDoMove;
    }
    doMove( a ) =
    {
	if (underdoor) {
	    if (holding <> nil) {
		"As the mat is removed, <<holding.adesc>> falls
		from it onto the floor.\n";
		holding.moveInto(mat.location);
	    } else {
		"The mat is removed from under the door.\n";
	    }
	    underdoor := nil;
	}
    }
    doSynonym('Move') = 'Pull'
    doTake( a ) =
    {
	self.doMove( a );
	pass doTake;
    }
;

class durableDoor: fixeditem
    verDoOpen( actor ) = "The door cannot be opened. "
    verDoClose( actor ) = "The door cannot be closed. "
    verDoBurnWith( actor, io ) = "%You% cannot burn this door. "
    verDoBreak( actor ) = "The door is invulnerable. "
    verIoPutUnder( actor ) = "There is not enough room under this door. "
    verDoKnock( actor ) = "I don't think that anybody is home. "
;

frontdoor: durableDoor	//  68
    sdesc = "door"
    noun = 'door'
    adjective = 'front'
    location = westHouse
;

northHouse: room	//   3
    sdesc = "North of House"
    ldesc = "You are facing the north side of a white house.  There is no door
	    here, and all the windows are barred. "
    reachable = [anotherwindow house]
    sacred = true
    nowalls = true
    
    // --Exits
    west(a) = westHouse
    east(a) = behindHouse
    north(a) = forest3
    south(a) = { "The windows are all barred. "; return( nil ); }
;

southHouse: room	//   4
    sdesc = "South of House"
    ldesc = " You are facing the south side of a white house.  There is no
	    door here, and all the windows are barred. "
    reachable = [anotherwindow house]
    sacred = true
    nowalls = true
    
    // --Exits
    west(a) = westHouse
    east(a) = behindHouse
    south(a) = forest2
    north(a) = { "The windows are all barred. "; return( nil ); }
;

anotherwindow: floater  	// 210
    sdesc = "window"
    ldesc = "The window is barred. "
    noun = 'window' 'barred'

    verDoOpen( actor ) = ( self.ldesc )
    verDoLookin( actor ) = ( self.ldesc )
    verDoEnter( actor ) = ( self.ldesc )
    verDoClose( actor ) = "The window is already closed. "
;

behindHouse: room	//   5
    sdesc = "Behind House"
    ldesc =
	"You are behind the white house.  In one corner of the house
	there is a small window which is <<window.showstate>>. "
    reachable = [window house]
    sacred = true
    nowalls = true
    
    // --Exits
    north(a) = northHouse
    south(a) = southHouse
    east(a) = clearing
    west(a) = ( checkDoor(window, kitchen, a) )
    in(a) = ( self.west(a) )
;

window: floater,door	//  63
    sdesc = "window"
    noun = 'window'
    showstate =
    {
	if (self.isopen)
	    "open";
	else
	    "slightly ajar";
    }

    openMessage(a) =
	"With great effort, you open the window far enough to allow entry. "
    closeMessage(a) =
	"The window closes (more easily than it opened). "

    verDoEnter( actor ) = { }
    doEnter( actor ) = { actor.travelTo(behindHouse.west( actor )); }
;

kitchen: room		//   6
    sdesc = "Kitchen"
    ldesc =
	"This is the kitchen of the white house.  A table seems to have been
	used recently for the preparation of food.  A passage leads to the
	west, and a dark staircase can be seen leading upward.  To the east
	is a small window which is <<window.showstate>>. "
    reachable = [window]
    scoreval = 10
    sacred = true
    ishouse = true
    
    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (brochure.sentfor and actor = Me)
	    notify(brochure, &arrival, 3);
    }
    
    // --Exits
    west(a) = livingrm
    up(a) = attic
    down(a) =
    {
	"Only Santa Claus climbs down chimneys. ";
	return( nil );
    }
    east(a) = { return( checkDoor(window, behindHouse, a) ); }
    out(a) = ( self.east(a) )
;

brownsack: openable,burnable	//   1
    sdesc = "brown sack"
    noun = 'bag' 'sack'
    adjective = 'brown' 'elongated'
    heredesc = "A brown sack is here."
    origdesc = "On the table is an elongated brown sack, smelling of hot
	       peppers."
    location = kitchen
    bulk = 3
    maxbulk = 15
    isopen = nil
;

garlic: fooditem	//   2
    sdesc = "clove of garlic"
    noun = 'garlic' 'clove'
    heredesc = "There is a clove of garlic here."
    location = brownsack
    bulk = 5
    foodvalue = 0
;

lunch: fooditem		//   3
    sdesc = "lunch"
    noun = 'food' 'sandwich' 'lunch' 'dinner'
    adjective = 'hot' 'pepper'
    heredesc = "A hot pepper sandwich is here."
    location = brownsack
    bulk = 5
    foodvalue = 0
;

/* it's the only liquid container, so those sorts of funcs are here */
bottle: transparentItem,openable	//  10
    sdesc = "glass bottle"
    noun = 'bottle' 'container'
    adjective = 'clear' 'glass'
    heredesc = "A clear glass bottle is here."
    origdesc = "A bottle is sitting on the table."
    location = kitchen
    bulk = 5
    maxbulk = 4
    isopen = nil

    haswater = ( somewater.isIn(self) )
    
    verDoFillWith( actor, io ) =
    {
	if (not isclass(io, water))
	    pass verDoFillWith;
	else if (length(self.contents) <> 0)
	    "The bottle is already full. ";
	else
	    self.verDoPutIn( actor, io );
    }
    doFillWith( actor, io ) =
    {
	"The bottle is now full of water. ";
	somewater.moveInto(self);
    }
    
    doThrow( a ) =
    {
	/* test if there's really a wall or not */
	"The bottle hits the far wall and is decimated.";
	self.moveInto(nil);
    }
    doThrowAt( a, io ) = ( self.doThrow(a) )
    doThrowTo( a, io ) = ( self.doThrow(a) )
    doBreak( a ) =
    {
	"A brilliant maneuver destroys the bottle.";
	self.moveInto(nil);
    }
;

somewater: water	//  11
    sdesc = "quantity of water"
    noun = 'water' 'quantity' 'liquid' 'h2o'
    adjective = 'small'
    location = bottle
    bulk = 4
    
    verDoEnter( actor ) = "It's a bit small for swimming, eh? "
;

attic: darkroom		//   7
    sdesc = "Attic"
    ldesc = "This is the attic.  The only exit is stairs that lead down. "
    ishouse = true
    down(a) = kitchen
;

rope: tieable, climbable	//  12
    sdesc = "rope"
    noun = 'rope' 'hemp' 'coil'
    adjective = 'large'
    heredesc = "There is a large coil of rope here."
    origdesc = "A large coil of rope is lying in the corner."
    location = attic
    bulk = 10

    /* whenever we're tied to something, we're dropped; become
     * climbable; and have the something deal with descriptions.
     */
    
    isListed = ( self.tiedto = nil )

    verDoClimb( a ) =
    {
	if (self.tiedto = nil)
	    "You can't climb <<self.thedesc>>. ";
    }
    doClimb( a ) = ( self.doClimbdown( a ) )

    doTieTo( a, io ) =
    {
	if (io = rail) {
	    "The rope drops over the side and comes within ten feet of the
	    floor. ";
	} else if (io = timber or io = coffin) {
	    if (a.isCarrying(io)) {
		"%You%'ll have to set down <<io.thedesc>> first. ";
		return;
	    }
	    "The rope is fastened to <<io.adesc>>.\n";
	    if (io.location = squareRoom or io.location = slideRoom)
		"The rope dangles down the slide.\n";
	} else {
	    "You can't tie the rope to that. ";
	    return;
	}
	self.moveInto(io.location);
	pass doTieTo;
    }

    verDoTake( a ) =
    {
	if (tiedto = rail)
	    "The rope is tied to the railing. ";
	else if (tiedto <> nil)
	    "The rope is tied to <<tiedto.adesc>>. ";
	else
	    pass verDoTake;
    }
;

knife: weapon, knife_messages		//  13
    sdesc = "knife"
    noun = 'knife' 'blade'
    adjective = 'nasty' 'unrusty' 'plain'
    heredesc = "There is a nasty-looking knife lying here."
    origdesc = "On a table is a nasty-looking knife."
    location = attic
    bulk = 5
;

/* Exploding...  pairs with fuse. */
brick: burnable,container		// 109
    sdesc = "brick"
    noun = 'brick'
    adjective = 'square' 'clay'
    heredesc = "There is a square brick here which feels like clay."
    location = attic
    maxbulk = 2
    ldesc =
    {
	if (length(contents) = 0)
	    "You see nothing special about <<self.thedesc>>. ";
	else
	    pass ldesc;
    }
    
    // flags2 = searchable

    showmunged = "The way is blocked by debris from an explosion.\n"

    dangerous = ( fuse.location = self and getfuse(fuse,&ignite) <> nil )

    explode =
    {
	local meloc, brloc;

	meloc := toplocation(Me);
	brloc := toplocation(brick);
	
	if (brloc = meloc) {
	    brloc.munged := self; /* room unenterable now */
	    self.moveInto(nil);
	    "Now you've done it.  It seems that the brick has other properties
	    than weight, namely the ability to blow you to smithereens.\n";
	    Me.died;
	}
	"There is an explosion nearby. ";
	self.mungerm := brloc;
	if (not self.isforest)
	    notify(self, &munge, 5);
	if (brloc = dustyRoom) {
	    if (self.isIn(safeslot)) {
		safeslot.moveInto(nil);
		safe.isopen := true;
	    }
	} else {
	    local l, cur;
	    /* wrong room, zap contents. oops */
	    l := brloc.contents;
	    while ( cur := car(l) ) {
		if (not cur.isfixed)
		    cur.moveInto(nil);
		l := cdr(l);
	    }
	    if (brloc = livingrm) {
		/* mess up our score as well :-) */
		l := trophycase.contents;
		while ( cur := car(l) ) {
		    if (not cur.isfixed)
			cur.moveInto(nil);
		    l := cdr(l);
		}
		trophycase.calcscore;
	    }
	}
	/* all done, we can go away */
	self.moveInto(nil);
    }

    /* we had an explosion earlier, now mess up room */
    munge =
    {
	/* set room to be unenterable */
	self.mungerm.munged := self;
	if (Me.isIn(self.mungerm)) {
	    if (self.mungerm.ishouse)
		"The house shakes, and the ceiling of the room you're in
		collapses, turning you into a pancake. ";
	    else
		"The room trembles and 50,000 pounds of rock fall on you,
		turning you into a pancake. ";
	    Me.died;
	}
	"You may recall your recent explosion.  Well, probably as a result of
	that, you hear an ominous rumbling, as if one of the rooms in the
	dungeon has collapsed. ";
	if (self.mungerm = dustyRoom)
	    notify(wideLedge, &collapse, 8);
    }
    
    doBurnWith( actor, io ) =
    {
	/* Boom */
	self.moveInto(nil);
	"Now %you've% done it.  It seems that the brick has other properties
	than weight, namely the ability to blow %you% to smithereens.\n";
	actor.died;
    }
;

livingrm: room		//   8
    sdesc = "Living Room"
    ldesc = {
	"This is the living room.  There is a door to the east. ";
	if (cyclopsRoom.hole)
	    "To the west is a cyclops-shaped hole in an old wooden door,
	    above which is some strange gothic lettering. ";
	else
	    "To the west is a wooden door with strange gothic lettering,
	    which appears to be nailed shut. ";
	if (carpet.moved) {
	    if (trapdoor.isopen)
		"There is a rug lying next to an open trap door. ";
	    else
		"In the center of the room is a closed trap door. ";
	} else {
	    if (trapdoor.isopen)
		"In the center of the room is an open trap door. ";//reachable?
	    else
		"In the center of the room is a large oriental rug. ";
	}
    }
    reachable = []		/* trapdoor will be here later */
    sacred = true
    ishouse = true
    
    /* Keep the score updated.  After several tries, roomAction seems
     * the safest way to keep the score correct.  (I tried detecting
     * when items removed/added, etc).  Trouble is, opening and closing
     * containers can change the score!  (ie, a closed egg doesn't
     * count the canary, but an open egg with the canary inside does)
     *
     * Maybe I'm paranoid, but when I played originally, the score
     * got confused and the endgame didn't show up (argh) until I removed
     * everything from the case and put it back again.
     */
    roomAction( a, v, d, p, i ) = { notify(trophycase, &calcscore, 1); }
    
    // --Exits
    east(a) = kitchen
    west(a) =
    {
	if (a = nil or cyclopsRoom.hole)
	    return( strangePass );
	else
	{
	    "The door is nailed shut. ";
	    return( nil );
	}
    }
    down(a) = { return( checkDoor(trapdoor, cellar, a) ); }
;

trophycase: openable, transparentItem, immobile	//   9
    sdesc = "trophy case"
    noun = 'case'
    adjective = 'trophy'
    heredesc = "There is a trophy case here."
    location = livingrm
    bulk = 10000
    maxbulk = 10000
    isopen = nil

    containsdesc = "Your collection of treasures consists of:\n"

    verDoTake( a ) =  "The trophy case is securely fastened to the wall
		      (perhaps to foil any attempt by robbers to remove it)."
    verDoMove( a ) = { self.verDoTake( a ); }

    /* Stuff to calculate the score of stuff in the trophy case.
     * 'Calcscore' is called from livingrm's roomAction.
     */
    curscore = 0
    calcscore =
    {
	local newscore;
	if (global.endgame)
	    return;
	newscore := self.getscore( self.contents );
	incscore( newscore - curscore );
	curscore := newscore;
    }
    getscore( list ) =
    {
	local score, i, len, cur;
	len := length(list);
	score := 0;
	for (i := 1; i <= len; i++) {
	    cur := list[i];
	    if (isclass(cur,treasure))
		score += cur.trophyscore;
	    if (cur.contentsVisible and length(cur.contents) > 0)
		score += self.getscore( cur.contents );
	}
	return( score );
    }
;

sword: weapon,sword_messages		//  14
    sdesc = "sword"
    noun = 'sword' 'blade' 'orchrist' 'glamdring'   // spelling?
    adjective = 'elvish'
    ldesc =
    {
	switch(self.state) {
	case 0: pass ldesc;
	case 1: "The sword is glowing with a faint blue glow. "; break;
	case 2: "The sword is glowing brightly. "; break;
	}
    }
    heredesc = "There is an elvish sword here."
    origdesc = "On hooks above the mantlepiece hangs an elvish sword of great
	       antiquity."
    location = livingrm
    bulk = 30

    moveInto( dest ) =
    {
	inherited.moveInto( dest );
	if ( self.location = Me ) {
	    notify(self, &dangercheck, 0);
	} else {
	    unnotify(self, &dangercheck);
	    self.state := 0;
	}
    }

    state = 0			/* is sword glowing or not */

    danger( loc ) =
    {
	local cur, l;
	if (loc = nil)
	    return nil;
	if (loc.swordwarning)
	    return( true );

	l := loc.contents;
	while( cur := car(l) ) {
	    if (cur.isvillain)
		return( true );
	    l := cdr(l);
	}
	return( nil );
    }
    
    dangercheck =
    {
	local i, len, dirs, loc, dest, newstate, stat;

	/* paranoia check */
	if (self.location <> Me) {
	    unnotify(self, &dangercheck);
	    return;
	}

	loc := toplocation(Me);
	if (self.danger(loc)) {
	    newstate := 2;
	} else  {
	    dirs := [&north, &south, &east, &west,
		     &ne, &nw, &se, &sw,
		     &in, &out, &up, &down, &cross];
	    
	    stat := outhide(true);	// hide any normal output
	    newstate := 0;
	    len := length(dirs);
	    for(i := 1; i <= len; i++) {
		dest := loc.(dirs[i])(nil);
		if (self.danger(dest)) {
		    newstate := 1;
		    break;
		}
	    }
	    outhide(stat);
	}
	
	if (self.state <> newstate) {
	    switch( self.state := newstate ) {
	    case 0: "\nYour sword is no longer glowing.\n"; break;
	    case 1: "\nYour sword is glowing with a faint blue glow.\n"; break;
	    case 2: "\nYour sword has begun to glow very brightly.\n"; break;
	    }
	}
    }
;

thelamp: lamp	//  15
    sdesc = "lamp"
    noun = 'lamp' 'lantern' 'light'
    adjective = 'brass'
    heredesc = "There is a brass lantern (battery-powered) here."
    origdesc = "A battery-powered brass lantern is on the trophy case."
    location = livingrm
    bulk = 15

    dimming1 = "The lamp appears to be getting dimmer. "
    dimming2 = "The lamp is dying. "
    turnsleft = [350 50 30 20 10 4]

    doThrowAt( actor, io ) = { self.doThrow(actor); }
    doThrowTo( actor, io ) = { self.doThrow(actor); }
    doThrow(actor) =
    {
	/* broken... */
	"The lamp has smashed into the floor, and the light has gone out. ";
	self.moveInto(nil);
	brokenlamp.moveInto(actor.location);
    }
;

brokenlamp: item	//  16
    sdesc = "broken lamp"
    noun = 'lamp' 'lantern'
    adjective = 'brass' 'broken'
    heredesc = "There is a broken brass lantern here."
    bulk = 5

    verDoTurnon( actor ) = "It's broken. "
;

/* update this! */
newspaper: readable,burnable	//  50
    sdesc = "newspaper"
    noun = 'paper' 'newspaper' 'issue' 'report' 'magazine' 'news'
    heredesc = "There is an issue of US NEWS & DUNGEON REPORT here."
    ldesc =
	"\t\tUS NEWS & DUNGEON REPORT\n
	03-Jun-94\t\t\t\t\t\t\t\tLate Dungeon Edition
	\b
	\t\t--- LATE NEWS FLASH!! ---
	\b
	With the port to TADS, things may be more fragile than before.
	We apologize for adding new bugs, and removing your
	old favorites.
	\b
	As always, aspiring adventurers should make avail themselves of every
	opportunity to broaden their intellectual horizons and increase their
	perspicacity.
	\b
	\t\t--- BACKGROUND INFORMATION ---
	\b
	If you encounter problems, please report them to:
	\b
	<<version.contact>>
	\b
	Do NOT address them to the Digital Equipment Computer
	Users Society (DECUS)."
    location = livingrm
    bulk = 2
;

carpet: fixeditem		//  17
    sdesc = "carpet"
    noun = 'carpet' 'rug'
    adjective = 'oriental'
    location = livingrm
    bulk = 10000

    moved = nil			/* have we been moved? */

    verDoLift( actor ) =
    {
	if (self.moved)
	    "The rug is too heavy to lift. ";
	else
	    "The rug is too heavy to lift, but in trying to raise it you
	    notice an irregularity beneath it. ";
    }
    verDoTake( actor ) = "The rug is extremely heavy and cannot be carried. "
    verDoLookunder( actor ) =
    {
	if (self.moved)
	    pass verDoLookunder;
	else {
	    "Underneath the rug is a closed trap door. ";
	    trapdoor.moveInto( livingrm );
	}
    }
    verDoMove( actor ) =
    {
	if (self.moved)
	    "Having moved the carpet previously, you find it impossible
	    to move it again. ";
    }
    doMove( actor ) =
    {
	"With a great effort, the rug is moved to one side of the room.
	With the rug moved, the dusty cover of a closed trap door appears. ";
	self.moved := true;
	trapdoor.moveInto( livingrm );
    }
;

trapdoor: floater, door	//  66
    sdesc = "trap door"
    noun = 'door' 'trap-door'
    adjective = 'trap'

    verDoOpen( actor ) =
    {
	if (actor.isIn(cellar))
	    "The door is locked from above. ";
	else if (not carpet.moved)
	    "The trap door is still covered by the carpet. ";
    }
    openMessage( actor ) =
	"The door reluctantly opens to reveal a rickety staircase descending
	into darkness."
    closeMessage( actor ) =
    {
	if (actor.isIn(cellar))
	    "The door crashes shut, and you hear someone barring it. ";
	else
	    "The door swings shut and closes. ";
    }
;

wooddoor: readable,durableDoor	//  67
    sdesc = "wooden door"
    noun = 'door' 'lettering'
    adjective = 'wooden' 'wood'
    ldesc = "The engravings translate to,
	    \"This space intentionally left blank\"."
    location = livingrm
;

/* forest daemon... */

class forest: room
    isforest = true
    sdesc = "Forest"
    sacred = true
    nowalls = true
    reachable = [house bird atree]
    
    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (actor = Me)
	    notify(self, &chirps, 0);
    }
    leaveRoom( actor ) =
    {
	unnotify(self, &chirps);
	pass leaveRoom;
    }

    chirps =
    {
	if (not Me.isIn(self))
	    unnotify(self, &chirps);
	if (prob(10,10))
	    "\nYou hear in the distance the chirping of a song bird. ";
    }

    up(a) =
    {
	if (a) "There is no tree here suitable for climbing. ";
	return( nil );
    }
;

forest1: forest		//  31
    ldesc = "This is a forest, with trees in all directions around you. "

    // --Exits
    north(a) = forest1
    east(a) = forest3
    south(a) = forest2
    west(a) = forest1
;

forest2: forest		//  32
    ldesc = "This is a dimly lit forest, with large trees all around.  To the
	    east, there appears to be sunlight. "

    // --Exits
    north(a) = southHouse
    east(a) = clearing
    south(a) = forest4
    west(a) = forest1
;

forest3: forest		//  33
    ldesc = "This is a dimly lit forest, with large trees all around.  One
	    particularly large tree with some low branches stands here. "

    reachable = ( forest.reachable - atree + largetree )  /* sigh */
    
    // --Exits
    north(a) = forest2
    east(a) = clearing
    south(a) = clearing
    west(a) = northHouse
    up(a) = upTree
;

largetree: floater,climbable		// 145
    sdesc = "large tree"
    noun = 'tree'
    adjective = 'large'
    // in forest3, uptree
;

forest4: forest		//  34
    ldesc = "This is a large forest, with trees obstructing all views except
	    to the east, where a small clearing may be seen through the trees."

    // --Exits
    east(a) = canyonView
    north(a) = forest5
    south(a) = forest4
    west(a) = forest2
;

forest5: forest		//  35
    ldesc = "This is a forest, with trees in all directions around you. "

    // --Exits
    north(a) = forest5
    se(a) = canyonView
    south(a) = forest4
    west(a) = forest2
;

clearing: room		//  36
    sdesc = "Clearing"
    ldesc =
    {
	"This is a clearing, with a forest to the west and south. ";
	if (leaves.moved) {
	    if (grating.isopen)
		"There is an open grating descending into darkness. ";
	    else
		"There is a grating securely fastened into the ground. ";
	}
    }
    reachable = [house bird]   /* grating may be here later on */
    isforest = true
    sacred = true
    nowalls = true

    moveleaves( actor ) =
    {
	if (not leaves.moved) {
	    leaves.moved := true;
	    reachable := [grating];
	    if (actor.isIn(self))
		"\nA grating appears on the ground. ";
	}
    }
    
    // --Exits
    down(a) =
    {
	if (a = nil or grating.isopen) {
	    return( gratingRoom );
	} else {
	    "You can't go down. ";
	    return( nil );
	}
    }
    sw(a) = behindHouse
    se(a) = forest5
    north(a) = clearing
    east(a) = clearing
    west(a) = forest3
    south(a) = forest2
;

leaves: burnable		//  18
    sdesc = "pile of leaves"
    noun = 'pile' 'leaves' 'leaf'
    heredesc = "There is a pile of leaves on the ground."
    location = clearing
    bulk = 25

    moved = nil
    doBurnWith( actor, io ) =
    {
	if (Me.isCarrying(self)) {
	    "The sight of someone carrying a pile of burning leaves so offends
	    the neighbors that they come over and put you out. ";
	    Me.died;
	} else {
	    clearing.moveleaves(actor);
	    "The leaves burn, and the neighbors start to complain. ";
	    self.moveInto(nil);
	}
    }
    verDoMove( actor ) =
    {
	if (self.moved)
	    pass verDoMove;
    }
    doMove( actor ) = { clearing.moveleaves(actor); }
    doTake( actor ) =
    {
	inherited.doTake( actor );
	if (actor.isCarrying(self))
	    clearing.moveleaves(actor);
    }
    verDoLookunder( actor ) =
    {
	if (self.moved)
	    pass verDoLookunder;
    }
    doLookunder( actor ) = "Underneath the pile of leaves is a grating. "
;

grating: floater, door	//  65
    sdesc = "grating"
    noun = 'grate' 'grating'

    islocked = true
    islockable = true
    mykey = keys
    openMessage(a) =
    {
	if (a.isIn(gratingRoom)) {
	    if (leaves.location = clearing and not leaves.moved) {
		"A pile of leaves fall down from the open grating. ";
		clearing.moveleaves(a);
		leaves.moveInto(gratingRoom);
	    } else {
		"The grating opens to reveal trees above you. ";
	    }
	} else
	    "The grating opens. ";
    }
    doUnlockWith( actor, io ) =
    {
	if (io = keys) {
	    "The grating is unlocked. ";
	    self.islocked := nil;
	} else
	    "Can you unlock a grating with <<io.adesc>>? ";
    }
    doLock(actor) =
    {
	"The grating is locked. ";
	self.islocked := true;
    }
    doLockWith(actor, io) = { self.doLock(actor); }
;

upTree: room		// 147
    sdesc = "Up a Tree"
    ldesc =
	"You are about ten feet above the ground nestled among some large
	branches.  The nearest branch above you is beyond your reach. "
    isforest = true
    sacred = true
    nrmLkAround( verbosity ) =
    {
	inherited.nrmLkAround( verbosity );
	if (verbosity and  itemcnt(forest3.contents)) {
	    local list;
	    "\nOn the ground below you can see:\n";
	    list := forest3.contents;
	    while (list <> []) {
		if (car(list).isListed) {
		    "\ \ "; car(list).adesc; "\n";
		}
		list := cdr(list);
	    }
	}
    }
    nowalls = true
    reachable = [house bird largetree]
    
    roomDrop( obj ) =
    {
	if ( obj = nest ) {
	    /* nest just gets put back on branch */
	    obj.touched := nil;  /* get orig desc back */
	    pass roomDrop;
	} else if (obj = egg) {
	    /* egg breaks */
	    "The egg falls to the ground and is seriously damaged. ";
	    egg.moveInto(nil);
	    brokenegg.moveInto(forest3);
	    if (canary.isIn(egg))
		brokencanary.moveInto(brokenegg);
	} else {
	    /* falls to ground */
	    "\^<<obj.thedesc>> falls to the ground. ";
	    obj.moveInto(forest3);
	}
    }
    
    // --Exits
    down(a) = forest3
    up(a) = { "You cannot climb any higher."; return( nil ); }
;

//tree1: fixeditem,climbable	// 144
//    sdesc = "large tree"
//    noun = 'tree'
//    adjective = 'large'
//    location = upTree
//;

nest: container,burnable		// 153
    sdesc = "birds nest"
    noun = 'nest'
    adjective = 'small' 'birds'
    heredesc = "There is a small birds nest here."
    origdesc = "On the branch is a small birds nest."
    location = upTree
    bulk = 20
    maxbulk = 20
;

egg: treasure,openable	// 154
    sdesc = "jewel-encrusted egg"
    noun = 'egg'
    adjective = 'birds' 'encrusted'
    heredesc = "There is a jewel-encrusted egg here."
    origdesc = "In the bird's nest is a large egg encrusted with precious
	       jewels, apparently scavenged somewhere by a childless songbird.
	       The egg is covered with fine gold inlay and ornamented in lapis
	       lazuli and mother-of-pearl.  Unlike most eggs, this one is
	       hinged and has a delicate looking clasp holding it closed.  The
	       egg appears extremely fragile."
    location = nest
    findscore = 5
    trophyscore = 5
    bulk = 6
    maxbulk = 6
    isopen = nil

    funky = nil
    
    verDoClose( actor ) =
    {
	inherited.verDoClose( actor );
	if (self.isopen)
	    "What?  With all the work it took to open it? ";  /* :-) */
    }
    verDoOpen( actor ) =
    {
	inherited.verDoOpen( actor );
	if (not self.isopen)
	    "There is no obvious way to open the egg. ";
    }
    verDoOpenWith( actor, io ) = { inherited.verDoOpen( actor ); }
    doOpenWith( actor, io ) =
    {
	if (io = hands) {
	    "I doubt you could do that without damaging it. ";
	} else if (isclass(io, weapon) or io.istool) {
	    self.doBreak( actor );
	} else if (not self.funky or io.funky) {
	    "The concept of using <<io.adesc>> is certainly original. ";
	    funky := true;
	    io.funky := true;
	} else {
	    "Not to say that using <<io.adesc>> isn't original too... ";
	}
    }
    
    doBreak( actor ) =
    {
	"Your rather indelicate handling of the egg has caused it some damage.
	\nThe egg is now open. ";
	brokenegg.moveInto(self.location);
	self.moveInto(nil);
	if (canary.isIn(egg))
	    brokencanary.moveInto(brokenegg);
	setit(brokenegg);
    }
    doBreakWith( actor, io ) = ( self.doBreak( actor ) )
;

brokenegg: item,container,treasure	// 155
    sdesc = "broken jewel-encrusted egg"
    noun = 'egg'
    adjective = 'broken' 'birds' 'encrusted'
    heredesc = "There is a somewhat ruined egg here."
    bulk = 6
    maxbulk = 6
    trophyscore = 2
;

bauble: treasure		// 156
    sdesc = "beautiful brass bauble"
    noun = 'bauble'
    adjective = 'brass' 'beautiful'
    heredesc = "There is a beautiful brass bauble here."
    findscore = 1
    trophyscore = 1
    bulk = 5
;

canary: treasure		// 157
    sdesc = "clockwork canary"
    noun = 'canary'
    adjective = 'gold' 'clockwork' 'mechanical' 'golden'
    heredesc = "There is a golden clockwork canary here."
    origdesc = "There is a golden clockwork canary nestled in the egg.  It has
	     ruby eyes and a silver beak.  Through a crystal window below its
	     left wing you can see intricate machinery inside.  It appears to
	     have wound down."
    location = egg
    findscore = 6
    trophyscore = 2
    bulk = 5

    sung = nil

    verDoWind( actor ) = { }
    doWind( actor ) =
    {
	if (sung or not actor.location.isforest) {
	    "The canary chirps blithely, if somewhat tinnily,
	    for a short time. ";
	    return;
	}
	sung := true;
	"The canary chirps, slightly off key, an aria from a forgotten opera.
	From out of the greenery flies a lovely song bird.  It perches on a
	limb just over your head and opens its beak to sing.  As it does so,
	a beautiful brass bauble drops from its mouth, bounces off the top
	of your head, and lands glimmering in the grass.  As the canary winds
	down, the song bird flies away. ";
	bauble.moveInto(actor.location = upTree ? forest3 : actor.location);
    }
;

brokencanary: treasure	// 158
    sdesc = "broken clockwork canary"
    noun = 'canary'
    adjective = 'broken' 'gold' 'clockwork' 'mechanical' 'golden'
    heredesc = "There is a non-functional canary here."
    origdesc =
	"There is a golden clockwork canary nestled in the egg.  It seems
	to have recently had a bad experience.  The mountings for its
	jewel-like eyes are empty, and its silver beak is crumpled.
	Through a cracked crystal window below its left wing you can see
	the remains of intricate machinery.  It is not clear what result
	winding it would have, as the mainspring appears sprung."
    bulk = 5
    trophyscore = 1

    verDoWind( actor ) =
	"There is an unpleasant grinding noise from inside the canary. "
;

/*
 * Floating objects
 */

house: floater		// 266
    sdesc = "white house"
    ldesc =
	"The house is a beautiful colonial house which is painted white.  It
	is clear that the previous owners must have been extremely wealthy. "
    noun = 'house'
    adjective = 'white'

    /* if in forest, it's not really here */
    dobjGen( a, v, i, p ) =
    {
	if ( a.location.isforest ) {
	    "You're not at the house. ";
	    exit;
	}
    }

    verDoFind( actor ) =
    {
	if (actor.isIn(clearing))
	    "It seems to be to the southwest. ";
	else if (actor.location.isforest)
	    "It was just here a minute ago... ";
	else
	    "It's right in front of you.  Are you blind? ";
    }
    verDoBurnWith( actor, io ) =
    {
	if (actor.location.isforest)
	    "You're not at the house. ";
	else
	    "You must be joking. ";
    }
    verDoEnter( actor ) =
    {
	if (actor.location.isforest)
	    "You're not at the house. ";
	else if ( not actor.isIn(behindHouse) )
	    "I can't see how to get in from here. ";
    }
    doEnter( actor ) = { actor.travelTo(behindHouse.west( actor )); }
;

bird: floater		// 267
    sdesc = "bird"
    ldesc = "I don't see any song bird here. "
    noun = 'bird' 'songbird'
    adjective = 'song'
    verDoFind( actor ) =
	"The song bird is not here, but it is probably nearby. "
;

atree: floater,climbable	// 268
    sdesc = "tree"
    noun = 'tree'
;

/* not a container, but initially contains stamp2 */
brochure: readable,burnable	// 195
    sdesc = "free brochure"
    noun = 'brochure'
    adjective = 'free'
    ldesc =
    {
	"The mailing label on this glossy brochure from MIT Tech reads
	\b
	\t\t\t\tIntrepid Adventurer\n
	\t\t\t\tc/o Local Dungeon Master\n
	\t\t\t\tWhite House, GUE
	\b
	From the Introduction:
	\b
	The brochure describes, for the edification of the prospective
	student, the stringent but wide-ranging curriculum of MIT Tech.
	Required courses are offered in Ambition, Distraction, Uglification,
	and Derision.  The Humanities are not slighted at this institution,
	as the student may register for Reeling and Writhing, Mystery
	(Ancient and Modern), Seaography, and Drawling (which includes
	Stretching and Fainting in Coils).  Advanced students are expected
	to learn Laughing and Grief.
	\b
	\t\t\t\t\t\t\tWilliam Barton Flathead, Founder
	\b
	(The brochure continues in this vein for a few hundred more pages.)\n";
	if (stamp2.location = self)
	    "Affixed loosely to the brochure is a small stamp. ";
    }
    heredesc = "There is a large brochure here."
    origdesc = "In the mailbox is a large brochure."
    
    bulk = 30

    sentfor = nil
    arrived = nil

    // won't work, since it's only found by sendforVerb until it arrives.
    //verDoFind( actor ) =
    //{
    //	if (self.sentfor) "It's probably on the way. ";
    //	else pass verDoFind;
    //}
    
    verDoSendfor( actor ) =
    {
	if (self.arrived)
	    "Why? Do you need another one? ";
	else if (self.sentfor)
	    "It's probably on the way. ";
    }
    doSendfor( actor ) =
    {
	"Ok, but you know the postal service...";
	self.sentfor := true;
    }

    arrival =
    {
	self.sentfor := nil;
	self.arrived := true;
	self.moveInto(mailbox);

	/* OK, you can hear this from anywhere, but you can't
	 * get too far in 2 moves.
	 */
	"\bThere is a knocking sound from the front of the house. ";
    }
;

stamp2: treasure,readable,burnable		// 196
    sdesc = "Don Woods stamp"
    noun = 'stamp'
    adjective = 'don' 'woods'
    heredesc = "There is a Don Woods stamp here."
    ldesc = "\b
+--v----v----v----v----v--+\n
| \ \ \ \ \ \ \ \ _______ \ \ \ \ \ \ \ \ |\n
> \ One \ \ / \ \ \ \ \ \ \\ \ \ \ \ G \ <\n
| Lousy / \ \ \ \ \ \ \ \ \\ \ \ \ U \ |\n
> Point | \ \ ___ \ \ | \ \ \ E \ <\n
| \ \ \ \ \ \ | \ (___) \ | \ \ \ \ \ \ |\n
> \ \ \ \ \ \ <--)___(--> \ \ \ P \ <\n
| \ \ \ \ \ \ / / \ \ \ \ \\ \\ \ \ \ o \ |\n
> \ \ \ \ \ / / \ \ \ \ \ \ \\ \\ \ \ s \ <\n
| \ \ \ \ |-|---------|-| \ t \ |\n
> \ \ \ \ | | \ \\ _ / \ | | \ a \ <\n
| \ \ \ \ | | --(_)-- | | \ g \ |\n
> \ \ \ \ | | \ /| |\\ \ | | \ e \ <\n
| \ \ \ \ |-|---|_|---|-| \ \ \ \ |\n
> \ \ \ \ \ \\ \\__/_\\__/ / \ \ \ \ \ <\n
| \ \ \ \ \ \ _/_______\\_ \ \ \ \ \ \ |\n
> \ \ \ \ \ | \ f.m.i.c.\ | \ \ \ \ \ <\n
| \ \ \ \ \ ------------- \ \ \ \ \ |\n
> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <\n
| \ \ Donald Woods, Editor \ |\n
> \ \ \ \ Spelunker Today \ \ \ \ <\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
+--^----^----^----^----^--+"
    location = brochure
    findscore = 0
    trophyscore = 1
    bulk = 1
;
