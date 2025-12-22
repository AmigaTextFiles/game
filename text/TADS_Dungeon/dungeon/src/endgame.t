/* all the end game */

guardianAttack: function( actor )
{
    "The Guardians awake and, in perfect unison, destroy %you% with
    their stone bludgeons.  Satisfied, they resume their posts.\b";
    actor.died;
}

class endroom: room
    roomCheck( v ) =
    {
	if (v = saveVerb) {
	    "Saves are not permitted during the endgame. ";
	    return( nil );
	}
	return( true );
    }

    /* returns 0 - no mirror in room, 1 - west mirror here, 2 - east mirror */
    /* (west mirror is the one that opens) */
    mirrorHere =
    {
	local dir;
	if (inMirror.angle = 90)
	    dir := 2;
	else if (inMirror.angle = 270)
	    dir := 1;
	else
	    return( 0 );

	if (self.northroom = inMirror.loc)
	    return( dir );
	else if (self.southroom = inMirror.loc)
	    return( 3 - dir );
	else
	    return( 0 );
    }
    
    /* functions used for descriptions */

    hallwaydesc =
    {
	local dirstr, m, b;

	self.northview;
	self.southview;

	"\n";
	
	if (inMirror.loc = self.northroom)
	    dirstr := 'north';
	else if (inMirror.loc = self.southroom)
	    dirstr := 'south';
	else
	    dirstr := nil;
	if (dirstr <> nil) {
	    /* mirror box is here, describe */
	    m := self.mirrorHere;
	    if (m = 0) {	/* facing n-s */
		"The <<dirstr>> side of the room is divided by a wooden
		wall into small hallways to the <<dirstr>>east and
		<<dirstr>>west. ";
	    } else {
		b := inMirror.broken[m];
		"A large <<b ? "panel" : "mirror">> fills the
		<<dirstr>> side of the hallway. ";
		if (m = 1 and redswitch.pushed) {
		    if (b)
			"The panel";
		    else
			"The mirror is mounted on a panel which";
		    " has been opened outward. ";
		}
		if (b)
		    "The shattered pieces of a mirror cover the floor. ";
	    }
	}

	self.hallwaydesc2( dirstr );
    }
    hallwaydesc2( dirstr ) = { }

    /* movement functions */
    
    hallExit( actor, dest ) =
    {
	local m, halldest;
	if (actor = nil)
	    return( dest );
	halldest := isclass(dest, narrow) ? dest.thehall : dest;
	if (inMirror.loc <> halldest) /* nothing blocking */
	    return( halldest );
	m := self.mirrorHere;
	if (m <> 0 or dest = halldest) { /* mirror blocking */
	    "There is a ";
	    if (m = 0)
		"wooden wall";
	    else if (inMirror.broken[m])
		"large broken mirror";
	    else
		"large mirror";
	    " blocking your way. ";
	    return( nil );
	} else {
	    /* ok to move */
	    return( dest );
	}
    }

    enterMirror( actor ) =
    {
	if (actor <> nil) {
	    local m;
	    m := self.mirrorHere;
	    if (m <> 1)
		"The structure blocks your way. ";
	    else if (redswitch.pushed)
		return( inMirror );
	    else
		"The <<inMirror.broken[m] ? "panel" : "mirror">> is closed. ";
	    return( nil );
	}
	return( inMirror );
    }
;

crypt: darkroom		// 157
    sdesc = "Crypt"
    ldesc =
	"Though large and aesthetically pleasing, the marble crypt is empty;
	the sarcophagi, bodies, and rich treasures to be expected in a tomb
	of this magnificence are missing.  Inscribed on the wall is the motto
	of the implementers, \"Feel Free\".  There is a door leading out of the
	crypt to the south.  The door is <<cryptdoor.showstate>>. "
    reachable = [cryptdoor]
    scoreval = 5
    sacred = true

    startend1 =
    {
	if (global.endgame)
	    return;
	"\b
	Suddenly a sinister, wraithlike figure, cloaked and hooded, appears
	seeming to float in the air before you.  In a low, almost inaudible
	voice he says, \"I welcome you to the ranks of the chosen of Zork.  You
	have persisted through many trials and tests and have overcome them
	all.  One such as yourself is fit to join even the implementers!\"
	He then raises his oaken staff and, chuckling, drifts away like a
	wisp of smoke, his laughter fading in the distance.\n";
	global.endgame := true;
	global.score := 0;
	scoreStatus( global.score, global.turnsofar );
    }

    startend2 =
    {
	if (not Me.isIn(self) or self.islit) {
	    notify(self, &startend2, 3); /* check later */
	    return;
	}
	"\b
	Suddenly, as you wait in the dark, you begin to feel somewhat
	disoriented.  The feeling passes, but something seems different.
	As you regain your composure, the cloaked figure appears before you
	and says, \"You are now ready to face the ultimate challenge of
	Zork.  Should you wish to do this somewhat more quickly in the
	future, you will be given a magic phrase which will at any time
	transport you by magic to this point.  To select the phrase, say\n
  	\t\tINCANT \"word\"\n
	and you will be told your own magic phrase to use by saying\n
  	\t\tINCANT \"phrase\"\n
	Good luck, and choose wisely!
	\b";
	self.startend3;
    }

    startend3 =
    {
	local cur, l;

	/* Note, we can come in here via an incant, so there may
	 * be some redundant work done here that was done if the
	 * player got here the hard way.
	 */
	
	global.endgame := true;
	
	/* remove our inventory */
	l := Me.contents;
	while( cur := car(l) ) {
	    cur.moveInto(nil);
	    l := cdr(l);
	}

	/* turn off villain heartbeats */
	for(cur := firstobj(villain); cur<>nil; cur := nextobj(cur,villain))
	    unnotify(cur, &heartbeat);
	unnotify(thief, &thiefdaemon);	
	unnotify(candles, &keepburning);
	
	/* give him lamp and sword */
	thelamp.moveInto(Me);
	thelamp.turnsleft := [350 50 30 20 10 4]; /* brand new */
	thelamp.turnon(nil);
	thelamp.touched := true;
	sword.moveInto(Me);
	sword.touched := true;

	Me.travelTo( topStairs );
    }
    
    // --Exits
    south(a) = ( checkDoor(cryptdoor, tomb, a) )
    out(a) = ( self.south(a) )
;

topStairs: endroom		// 158
    sdesc = "Top of Stairs"
    ldesc = "You are standing at the top of a flight of stairs that lead down
	    to a passage below.  Dim light, as from torches, can be seen in the
	    passage.  Behind you the stairs lead into untouched rock. "
    scoreval = 10

    // --Exits
    north(a) = stoneRoom
    down(a) = stoneRoom
    south(a) = { "The wall is solid rock. "; return( nil ); }
;

stoneRoom: endroom		// 159
    sdesc = "Stone Room"
    ldesc = "You are standing near one end of a long dimly lit hall.  To the
	    south, stone stairs ascend.  To the north, the corridor is
	    illuminated by torches set high in the wall, out of reach.  On one
	    wall is a red button. "

    // --Exits
    south(a) = topStairs
    up(a) = topStairs
    north(a) = lightbeamRoom
;

redswitch: buttonitem	// 170
    sdesc = "red button"
    noun = 'switch' 'button'
    adjective = 'red'
    location = stoneRoom

    pushed = nil
    
    doPush( actor ) =
    {
	if (self.pushed)
	    "The button is already depressed.\n";
	else {
	    unnotify(self, &unpush);
	    "The button becomes depressed.\n";
	    if (lightbeam.blocked = nil)
		"The button pops back out.\n";
	    else {
		self.pushed := true;
		notify(self, &unpush, 7);
	    }
	}
    }

    unpush =
    {
	self.pushed := nil;
	if (Me.location = self.location)
	    "\nThe button pops back to its original position. ";
	else if (Me.location = inMirror or Me.location.mirrorHere <> 0)
	    "\nThe mirror quietly swings shut. ";
    }
;

lightbeamRoom: endroom	// 160
    sdesc = "Small Room"
    ldesc =
    {
	local b;
	"This is a small room, with narrow passages exiting to the north and
	south.  A narrow red beam of light crosses the room at the north end,
	inches above the floor. ";
	if ( b := lightbeam.blocked )
	    "The beam is stopped halfway across the room
	    by <<b.adesc>> lying on the floor. ";
	self.hallwaydesc;
    }

    northroom = hallway1

    // --Exits
    north(a) = ( self.hallExit( a, hallway1 ) )
    ne(a) = ( self.hallExit( a, narrow1 ) )
    nw(a) = ( self.hallExit( a, narrow2 ) )
    south(a) = stoneRoom
;

lightbeam: fixeditem	// 171
    sdesc = "red beam of light"
    noun = 'beam'
    adjective = 'red'
    location = lightbeamRoom

    blocked =
    {
	local l;
	l := lightbeamRoom.contents;
	while( car(l) ) {
	    if ( not isclass(car(l), fixeditem) )
		return( car(l) );
	    l := cdr(l);
	}
	return( nil );
    }
    
    verDoTake( actor ) = "No doubt you have a bottle of moonbeams as well. "

    verIoPutIn( actor ) = { }
    ioPutIn( actor, dobj ) =
    {
	if (dobj.location = lightbeamRoom)
	    "\^<<dobj.thedesc>> already breaks the beam. ";
	else if (not Me.isCarrying(dobj))
	    "You can't break the beam with <<dobj.adesc>>. ";
	else {
	    dobj.moveInto(lightbeamRoom);
	    "The beam is now interrupted by <<dobj.adesc>> lying
	    on the floor. ";
	}
    }

    /* break beam with foo */
    verDoBreakWith( actor, io ) = ( io.verifyRemove( actor ) )
    doBreakWith( actor, io ) = ( self.ioPutIn( actor, io ) )
;

class hallway: endroom
    sdesc = "Hallway"
    ldesc =
    {
	local mloc;
	
	"This is part of the long hallway.  The east and west walls are
	dressed stone.  In the center of the hall is a shallow stone channel.
	In the center of the room the channel widens into a large hole around
	which is engraved a compass rose. ";
	self.hallwaydesc;
    }

    hallwaydesc2( dirstr ) =
    {
	if (dirstr <> 'north' and not defined(self,&northview)) {
	    if (dirstr <> 'south' and not defined(self, &southview))
		"The corridor continues north and south. ";
	    else
		"The corridor continues north. ";
	} else if (dirstr <> 'south' and not defined(self, &southview))
	    "The corridor continues south. ";
    }
    
    reachable = [compass channel mirrorbox genpanel]
;

hallway1: hallway		// 161
    southview = "A passage enters from the south. "
    northroom = hallway2
    southroom = lightbeamRoom

    westroom = narrow1
    eastroom = narrow2
    
    // --Exits
    north(a) = ( self.hallExit( a, hallway2 ) )
    ne(a) = ( self.hallExit( a, narrow3 ) )
    nw(a) = ( self.hallExit( a, narrow4 ) )
    south(a) = lightbeamRoom
    in(a) = ( self.enterMirror( a ) )
;

hallway2: hallway		// 162
    northroom = hallway3
    southroom = hallway1
    westroom = narrow3
    eastroom = narrow4    
    
    // --Exits
    north(a) = ( self.hallExit( a, hallway3 ) )
    ne(a) = ( self.hallExit( a, narrow5 ) )
    nw(a) = ( self.hallExit( a, narrow6 ) )
    south(a) = ( self.hallExit( a, hallway1 ) )
    se(a) = ( self.hallExit( a, narrow1 ) )
    sw(a) = ( self.hallExit( a, narrow2 ) )
    in(a) = ( self.enterMirror( a ) )
;

hallway3: hallway		// 163
    reachable = (hallway.reachable + [guardian])

    northview =
	"Somewhat to the north, identical stone statues face each other from
	pedestals on opposite sides of the corridor.  The statues represent
	Guardians of Zork, a military order of ancient lineage.  They are
	portrayed as heavily armored warriors standing at ease, hands clasped
	around formidable bludgeons.\n"
    northroom = hallway4
    southroom = hallway2
    westroom = narrow5
    eastroom = narrow6
    
    // --Exits
    north(a) = ( self.hallExit( a, hallway4 ) )
    ne(a) = ( self.hallExit( a, narrow7 ) )
    nw(a) = ( self.hallExit( a, narrow8 ) )
    south(a) = ( self.hallExit( a, hallway2 ) )
    se(a) = ( self.hallExit( a, narrow3 ) )
    sw(a) = ( self.hallExit( a, narrow4 ) )
    in(a) = ( self.enterMirror( a ) )
;

hallway4: hallway		// 164
    reachable = (hallway.reachable + [guardian])

    enterRoom( actor ) = ( guardianAttack( actor ) )
    swordwarning = true		/* sword glows if you get near */

    northroom = hallway5
    southroom = hallway3
    westroom = narrow7
    eastroom = narrow8

    // --Exits
    north(a) = hallway5
    south(a) = hallway3
;

hallway5: hallway		// 165
    reachable = (hallway.reachable + [guardian])

    southview =
	"Somewhat to the south, identical stone statues face each other from
	pedestals on opposite sides of the corridor.  The statues represent
	Guardians of Zork, a military order of ancient lineage.  They are
	portrayed as heavily armored warriors standing at ease, hands clasped
	around formidable bludgeons.\n"
    northroom = endhall
    southroom = hallway4
    westroom = narrow9
    eastroom = narrow10
    
    // --Exits
    north(a) = endhall
    ne(a) = endhall
    nw(a) = endhall
    south(a) = ( self.hallExit( a, hallway4 ) )
    se(a) = ( self.hallExit( a, narrow7 ) )
    sw(a) = ( self.hallExit( a, narrow8 ) )
;

endhall: endroom		// 166
    sdesc = "Dungeon Entrance"
    ldesc = {
	"This is a north-south hallway which ends in a large wooden door. ";
	self.hallwaydesc;
	"The wooden door has a barred panel in it at about head height.  The
	panel is <<questdoor.asking ? "open" : "closed">>, and
        the door is <<questdoor.showstate>>. ";
    }
    reachable = ( [ questdoor ] +
		 ((questdoor.isopen or questdoor.asking) ? [ master ] : []) )
		 
    enterRoom( actor ) =
    {
	unnotify(master, &follow);
	pass enterRoom;
    }

    roomAction( a, v, d, p, i ) =
    {
	if (v = sayVerb and questdoor.asking and d = strObj) {
	    questdoor.answer(d.value);
	    exit;
	}
    }
    
    scoreval = 15

    southroom = hallway5

    // --Exits
    north(a) = ( checkDoor(questdoor, narrowCorr, a) )
    in(a) = ( self.north(a) )
    south(a) = ( self.hallExit( a, hallway5 ) )
    se(a) = ( self.hallExit( a, narrow9 ) )
    sw(a) = ( self.hallExit( a, narrow10 ) )
;

class narrow: endroom
    sdesc = "Narrow Room"
    ldesc =
    {
	local m;
	m := self.mirrorHere;
	"This is a narrow room whose
	<<self.westroom ? "west" : "east">> wall is a large ";
	if (inMirror.broken[m])
	    "wooden panel which once contained a ";
	"mirror. ";
	if (m = 1 and redswitch.pushed) {
	    if (inMirror.broken[m])
		"The panel";
	    else
		"The mirror is mounted on a panel which";
	    " has been opened outward. ";
	}
	"The opposite wall is solid rock. ";
	self.halldesc;
    }
    reachable = [mirrorbox genpanel]
    
    thehall = nil		/* hallway we're adjecent to  */
    westroom = nil		/* are we the western narrow room? */
    
    mirrorHere =
    {
	local dir;
	if (inMirror.loc <> self.thehall)
	    return( 0 );
	if (inMirror.angle = 0)
	    dir := 2;
	else
	    dir := 1;
	return( westroom ? 3 - dir : dir );
    }

    in(a) = ( self.enterMirror( a ) )
;

narrow1: narrow		// 167
    thehall = hallway1
    halldesc = "To the north is a large hallway. "
    
    // --Exits
    north(a) = hallway2
    south(a) = lightbeamRoom
    west(a) = ( self.in(a) )
;

narrow2: narrow		// 168
    thehall = hallway1
    westroom = true
    halldesc = "To the north is a large hallway. "

    // --Exits
    north(a) = hallway2
    south(a) = lightbeamRoom
    east(a) = ( self.in(a) )
;

narrow3: narrow		// 169
    thehall = hallway2
    halldesc = "To the north and south are large hallways. "
    
    // --Exits
    north(a) = hallway3
    south(a) = hallway1
    west(a) = ( self.in(a) )
;

narrow4: narrow		// 170
    thehall = hallway2
    westroom = true
    halldesc = "To the north and south are large hallways. "
    
    // --Exits
    north(a) = hallway3
    south(a) = hallway1
    east(a) = ( self.in(a) )
;

narrow5: narrow		// 171
    reachable = (narrow.reachable + [guardian])
    thehall = hallway3
    halldesc = ( hallway3.northview )
    
    // --Exits
    north(a) = hallway4
    south(a) = hallway2
    west(a) = ( self.in(a) )
;

narrow6: narrow		// 172
    reachable = (narrow.reachable + [guardian])
    thehall = hallway3
    westroom = true
    halldesc = ( hallway3.northview )

    // --Exits
    north(a) = hallway4
    south(a) = hallway2
    east(a) = ( self.in(a) )
;

narrow7: narrow		// 173
    thehall = hallway4
    enterRoom( actor ) = ( guardianAttack( actor ) )
    swordwarning = true		/* sword glows if you get near */
;

narrow8: narrow		// 174
    thehall = hallway4
    westroom = true
    enterRoom( actor ) = ( guardianAttack( actor ) )
    swordwarning = true		/* sword glows if you get near */
;

/* DBJ, these were just like narrow7/8, changed */
narrow9: narrow		// 175
    reachable = (narrow.reachable + [guardian])
    thehall = hallway5
    halldesc = ( hallway5.southview )

    // --Exits
    north(a) = endhall
    south(a) = hallway4
    west(a) = ( self.in(a) )
;

narrow10: narrow		// 176
    reachable = (narrow.reachable + [guardian])
    thehall = hallway5
    halldesc = ( hallway5.southview )
    westroom = true
    
    // --Exits
    north(a) = endhall
    south(a) = hallway4
    east(a) = ( self.in(a) )
;

inMirror: endroom	// 177
    sdesc = "Inside Mirror"
    ldesc =
    {
	"You are inside a rectangular box of wood whose structure is rather
	complicated.  Four sides and the roof are filled in, and the floor
	is open.
	\n\t   As you face the side opposite the entrance, two short sides of
	carved and polished wood are to your left and right.  The left panel
	is mahogany, the right pine.  The wall you face is red on its left
	half and black on its right.  On the entrance side, the wall is white
	opposite the red part of the wall it faces, and yellow opposite the
	black section.  The painted walls are at least twice the length of
	the unpainted ones.  The ceiling is painted blue.
	\n\t   In the floor is a stone channel about six inches wide and a foot
	deep.  The channel is oriented in a north-south direction.  In the
	exact center of the room the channel widens into a circular
	depression perhaps two feet wide.  Incised in the stone around this
	area is a compass rose.
	\n\t   Running from one short wall to the other at about waist height
	is a wooden bar, carefully carved and drilled.  This bar is pierced
	in two places.  The first hole is in the center of the bar (and thus
	in the center of the room).  The second is at the left end of the room
	(as you face opposite the entrance).  Through each hole runs a wooden
	pole.
	\n\t   The pole at the left end of the bar is short, extending about a
	foot above the bar, and ends in a hand grip. ";

	/* show short pole position */
	if (self.angle = 270 and self.loc = hallway2) {
	    if (shortpole.lifted = 0)
		"The pole has been dropped into a hole carved in the stone
		floor. ";
	    else
		"The pole has been lifted out of a hole carved in the stone
		floor.  There is evidently enough friction to keep the pole
		from dropping back down. ";
	} else if (self.angle = 0 or self.angle = 180) {
	    if (shortpole.lifted = 0)
		"The pole has been dropped into the stone channel incised
		in the floor. ";
	    else
		"The pole is positioned above the stone channel in the
		floor. ";
	} else
	    "The pole is resting on the stone floor. ";
	
	"\n\t  The long pole at the center of the bar extends from the ceiling
	through the bar to the circular area in the stone channel.  The
	bottom end of this pole has a T-bar a bit less than two feet long
	attached to it.  On the T-bar is carved an arrow.  The arrow and
	T-bar are pointing <<self.showdir>>. ";
    }
    scoreval = 15
    reachable = [compass channel guardian]
    
    loc = hallway2		/* the room the mirror is in */
    angle = 270			/* what the orientation of the mirror is */
    
    swordwarning = { return( loc = hallway4); }
    broken = [nil nil]		/* are mirrors broken? */
    
    showdir =
    {
	say(['north' 'northeast' 'east' 'southeast' 'south'
	     'southwest' 'west' 'northwest'][(angle/45)+1]);
    }
    
    // --Exits
    checkExit( a, dir ) =
    {
	local xdir;
	if (a = nil) {
	    /* Handle stuff for elvish sword */
	    switch( dir ) {
	    case 0: return( loc.northroom );
	    case 90: return( loc.eastroom );
	    case 180: return( loc.southroom );
	    case 270: return( loc.westroom );
	    }
	    return( nil );	/* ignore others */
	}

	/* check if we leave via mirror */
	xdir := angle + 270;
	if (xdir >= 360) xdir -= 360;
	if (redswitch.pushed and (dir < 0 or dir = xdir)) {
	    switch(angle) {
	    case 0: return( loc.westroom );
	    case 90: return( loc.northroom );
	    case 180: return( loc.eastroom );
	    case 270: return( loc.southroom );
	    }
	}

	/* check if we leave via pine wall */
	xdir := angle + 180;
	if (xdir >= 360) xdir -= 360;
	if (pinewall.isopen and (dir < 0 or dir = xdir)) {
	    "As you leave, the door swings shut.\n";
	    pinewall.isopen := nil;
	    if (angle = 0)
		return( loc.southroom );
	    else
		return( loc.northroom );
	}

	/* bad exit */
	return( self.noexit(a) );
    }
    
    north(a) = ( self.checkExit( a, 0 ) )
    ne(a) = ( self.checkExit( a, 45 ) )
    east(a) = ( self.checkExit( a, 90 ) )
    se(a) = ( self.checkExit( a, 135 ) )
    south(a) = ( self.checkExit( a, 180 ) )
    sw(a) = ( self.checkExit( a, 225 ) )
    west(a) = ( self.checkExit( a, 270 ) )
    nw(a) = ( self.checkExit( a, 315 ) )
    out(a) = ( self.checkExit( a, -1 ) )
;

class mirrorpanel: fixeditem
    location = inMirror

    verDoPush( actor ) = { }
    doPush( actor ) =
    {
	if (shortpole.lifted = 0) {
	    if (inMirror.angle = 0 or inMirror.angle = 180)
		"The short pole prevents the structure from rotating. ";
	    else
		"The structure shakes slightly but doesn't move. ";
	} else if (inMirror.loc = hallway4) {
	    "The movement of the structure alerts the Guardians.\n";
	    guardianAttack( actor );
	} else {
	    local a;
	    "The structure rotates
	    <<self.delta<0 ? "counter" : ''>>clockwise. ";
	    a := inMirror.angle + self.delta;
	    if (a >= 360) a-=360;
	    if (a < 0) a+=360;
	    inMirror.angle := a;
	    "The arrow on the compass rose now indicates
	    <<inMirror.showdir>>.\n";
	    if (pinewall.isopen) {
		pinewall.isopen := nil;
		"The pine wall closes quietly.\n";
	    }
	}
    }
;

yellowpanel: mirrorpanel	// 159
    sdesc = "yellow panel"
    noun = 'wall' 'panel'
    adjective = 'yellow'

    delta = 45
;

whitepanel: mirrorpanel	// 160
    sdesc = "white panel"
    noun = 'wall' 'panel'
    adjective = 'white'

    delta = -45
;

redpanel: mirrorpanel	// 161
    sdesc = "red panel"
    noun = 'wall' 'panel'
    adjective = 'red'

    delta = 45
;

blackpanel: mirrorpanel	// 162
    sdesc = "black panel"
    noun = 'wall' 'panel'
    adjective = 'black'

    delta = -45
;

mahoganywall: fixeditem	// 163
    sdesc = "mahogany wall"
    noun = 'wall' 'panel'
    adjective = 'mahogany'
    location = inMirror

    verDoPush( actor ) = { }
    doPush( actor ) =
    {
	local a, dest, dir;
	a := inMirror.angle;
	if (a <> 0 and a <> 180) {
	    "The structure rocks back and forth slightly but doesn't move. ";
	    return;
	}

	if (a = 0) {
	    dest := inMirror.loc.northroom;
	    dir := 'north';
	} else {
	    dest := inMirror.loc.southroom;
	    dir := 'south';
	}
	if (dest = nil or not isclass(dest, hallway)) {
	    "The structure has reached the end of the stone channel and won't
	    budge. ";
	} else {
	    local how;
	    how := (shortpole.lifted = 0) ? 'slides' : 'wobbles';
	    "The structure <<how>> <<dir>> and stops over another
	    compass rose. ";
	    inMirror.loc := dest;
	    if (dest <> hallway4)
		return;
	    /* see if we're noticed */
	    if (shortpole.lifted > 0)
		"The structure wobbles as it moves, alerting the Guardians.\n";
	    else if (pinewall.isopen or redswitch.pushed)
		"A Guardian notices the open side of the structure, and his
		suspicions are aroused.\n";
	    else if (inMirror.broken[1] or inMirror.broken[2])
		"A Guardian notices a wooden structure creeping by, and his
		suspicions are aroused.\n";
	    else
		return;
	    "Suddenly, the Guardians realize that someone is trying to sneak by
	    them in the structure.  They awake and, in perfect unison, hammer
	    the box and its contents (including you) to a pulp.  Satisfied,
	    they then resume their posts. ";
	    actor.died;
	}
    }
;

pinewall: fixeditem,door	// 164
    sdesc = "pine wall"
    noun = 'door' 'wall' 'panel'
    adjective = 'pine'
    location = inMirror

    isopen = nil

    verDoPush( actor ) = { }
    doPush( actor ) =
    {
	local a;
	a := inMirror.angle;
	if (a <> 0 and a <> 180) {
	    "The structure rocks back and forth slightly but doesn't move. ";
	    return;
	}
	if ((inMirror.loc = hallway3 and a = 180) or
	    (inMirror.loc = hallway5 and a = 0) or
	    inMirror.loc = hallway4)
	{
	    "The pine door opens into the field of view of the Guardians.\n";
	    guardianAttack( actor );
	}

	/* succeeds */
	"The pine wall swings open. ";
	self.isopen := true;
	notify(self, &closeme, 5);
    }

    closeme =
    {
	if (self.isopen) {
	    "\nThe pine wall closes quietly. ";
	    self.isopen := nil;
	}
    }
;

crossbar: fixeditem	// 165
    sdesc = "wooden bar"
    noun = 'bar'
    adjective = 'wooden' 'wood' 'cross'
    location = inMirror
;

longpole: fixeditem	// 166
    sdesc = "long pole"
    noun = 'post' 'pole'
    adjective = 'long' 'center'
    location = inMirror
;

shortpole: fixeditem	// 167
    sdesc = "short pole"
    noun = 'post' 'pole' 'grip' 'handgrip'
    adjective = 'short'
    location = inMirror

    lifted = 0			/* 0 in hole, 1 floor level, 2 above floor */
    
    verDoLift( actor ) =
    {
	if (lifted = 2) "The pole cannot be raised further. ";
    }
    doLift( actor ) =
    {
	"The pole is now slightly above the floor. ";
	lifted := 2;
    }

    verDoLower( actor ) =
    {
	if (lifted = 0) "The pole cannot be lowered further. ";
    }
    doLower( actor ) =
    {
	if (inMirror.angle = 0 or inMirror.angle = 180) {
	    "The pole is lowered into the channel. ";
	    lifted := 0;
	} else if (inMirror.angle = 270 and inMirror.loc = hallway2) {
	    "The pole is lowered into the stone hole. ";
	    lifted := 0;
	} else {
	    if (lifted = 1)
		"The pole is already resting on the floor. ";
	    else
		"The pole now rests on the stone floor. ";
	    lifted := 1;
	}
    }
    doSynonym('Lower') = 'Push'
;

tbar: fixeditem		// 168
    sdesc = "T-bar"
    noun = 'bar' 'tbar' 't-bar'
    adjective = 't'
    location = inMirror
;

arrow: fixeditem		// 169
    sdesc = "compass arrow"
    ldesc = "The arrow on the compass rose indicates <<inMirror.showdir>>. "
    noun = 'arrow' 'point'
    adjective = 'compass'
    location = inMirror
;

questdoor: floater,door	// 173
    sdesc = "wooden door"
    noun = 'door'
    adjective = 'wooden' 'wood'
    location = endhall

    asking = ( getfuse(self, &inquire) <> nil )
    asked = nil
    qnum = 0
    numright = 0
    numwrong = 0
    
    verDoOpen( actor ) = "The door does not budge. "
    verDoClose( actor ) = "The door does not budge. "
    verIoPutUnder( actor ) = "There is not enough room under this door. "

    verDoKnock( actor ) = { }
    doKnock( actor ) =
    {
	if (asked) {
	    "There is no answer. ";
	    return;
	}
	asked := true;
	qnum := rand(8);
	"The knock reverberates along the hall.  For a time it seems there
	will be no answer.  Then you hear someone unlatching the small wooden
	panel.  Through the bars of the great door, the wrinkled face of an
	old man appears.  He gazes down at you and intones as follows:
	\n\t   \"I am the master of the dungeon, whose task it is to insure
	that none but the most scholarly and masterful adventurers are
	admitted into the secret realms of the dungeon.  To ascertain whether
	you meet the stringent requirements laid down by the Great
	Implementers, I will ask three questions which should be easy for
	one of your reputed excellence to answer.  You have undoubtedly
	discovered the answers during your travels through the dungeon.
	Should you answer each of these questions correctly within five
	attempts, then I am obliged to acknowledge your skill and daring and
	admit you to these regions.
	\t\n   \"All answers should be in the form 'ANSWER \"answer\"'.\" ";
	self.inquire;
    }

    questions =
	[
	'From which room can one enter the robber\'s hideaway without passing
		through the cyclops room?'
	'Beside the Temple, to which room is it possible to go from the Altar?'
	'What is the absolute minimum specified value of the Zorkmid
		treasures, in Zorkmids?'
	'What object is of use in determining the function of the iced cakes?'
	'What can be done to the mirror that is useful?'
	'The taking of which object offends the ghosts?'
	'What object in the dungeon is haunted?'
	'In which room is the phrase \'Hello sailor\' useful?'
	]
    answers =
	[[ 'temple' ]
	 [ 'forest' ]
	 [ '30003' ]
	 [ 'flask' ]
	 [ 'rub' 'touch' 'feel' 'fondle' 'caress' ]
	 [ 'bones' 'body' 'skeleton' ]
	 [ 'rusty knife' ]
	 [ 'none' 'nowhere' ]]
	
    inquire =
    {
	if (Me.location <> endhall)
	    return;
	"\nThe booming voice asks:\n\t";
	say(questions[qnum]);
	notify(self, &inquire, 2);
    }

    answer(str) =
    {
	if (find(answers[qnum], str)) {
	    numright++;
	    numwrong := 0;
	    "The dungeon master says, \"Excellent.\"\n";
	    if (numright < 3) {
		/* ask next question */
		qnum += 3;
		if (qnum > 8) qnum -= 8;
		unnotify(self, &inquire);
		inquire;
	    } else {
		"The dungeon master, obviously pleased, says, \"You are indeed
		a master of lore.  I am proud to be at your service.\"  The
		massive wooden door swings open, and the master motions for you
		to enter.\n";
		unnotify(self, &inquire);
		self.isopen := true;
	    }
	} else {
	    numwrong++;
	    if (numwrong >= 5) {
		"The dungeon master says, \"You are wrong.\"  The dungeon
		master, obviously disappointed in your lack of knowledge,
		shakes his head and mumbles, \"I guess they'll let anyone
		in the dungeon these days.\"  With that, he departs.\n";
		unnotify(self, &inquire);
	    } else {
		"The dungeon master says, \"You are wrong.  You have
		<<['four' 'three' 'two' 'one'][numwrong]>> more chance";
		if (numwrong <> 4) "s";
		".\"\n";
	    }
	}
    }
;

questpanel: fixeditem		/* added, DBJ */
    sdesc = "panel"
    noun = 'panel'
    location = endhall

    doKnock -> questdoor
;

narrowCorr: endroom	// 178
    sdesc = "Narrow Corridor"
    ldesc =
	"This is a narrow north-south corridor.  At the south end is a door
	and at the north end is an east-west corridor.  The door is
	<<questdoor.showstate>>. "
    scoreval = 20
    reachable = [questdoor]
    enterRoom( actor ) =
    {
	unnotify(master, &follow);
	notify(master, &follow, 0);
	master.seen := true;
	pass enterRoom;
    }
    
    // --Exits
    north(a) = southCorr
    south(a) = ( checkDoor(questdoor, endhall, a) )
;

southCorr: endroom		// 179
    sdesc = "South Corridor"
    ldesc =
    {
	"This is an east-west corridor which turns north at its eastern
	and western ends.  The walls of the corridor are marble.  An
	additional passage leads south at the center of the corridor. ";
	if (cell1.thecell = 4)
	    "In the center of the north wall of the passage is a bronze door
	    which is <<bronzedoor.showstate>>. ";
    }
    reachable = ( cell1.thecell = 4 ? [bronzedoor] : [] )

    // --Exits
    north(a) =
    {
	if (cell1.thecell <> 4)
	    return( self.noexit(a) );
	else
	    return( checkDoor(bronzedoor, cell1, a) );
    }
    south(a) = narrowCorr
    west(a) = westCorr
    east(a) = eastCorr
;

bronzedoor: floater,door	// 172
    sdesc = "bronze door"
    noun = 'door'
    adjective = 'bronze'

    verIoPutUnder( a ) = "There is not enough room under this door. "

    doOpen( actor ) =
    {
	inherited.doOpen( actor );
	if (isopen and actor.location = cell3)
	    "\nOn the other size of the door is a narrow passage which opens
	    out into a larger area. ";
    }
;

class sideCorr: endroom
    sdesc = "\^<<self.side>> Corridor"
    ldesc = "This is a corridor with polished marble walls.  The corridor
	    widens into larger areas as it turns <<self.otherside>> at its
	    northern and southern ends. "

    // --Exits
    south(a) = southCorr
    north(a) = northCorr
;

westCorr: sideCorr		// 180
    side = 'west'
    otherside = 'east'
;

eastCorr: sideCorr		// 181
    side = 'east'
    otherside = 'west'
;

northCorr: endroom		// 182
    sdesc = "North Corridor"
    ldesc =
	"This is a large east-west corridor which opens out to a northern
	parapet at its center.  You can see flames and smoke as you peer
	towards the parapet.  The corridor turns south at its east and west
	ends, and due south is a massive wooden door.  In the door is a small
	window barred with iron.  The door is <<celldoor.showstate>>. "
    reachable = [celldoor master]

    // --Exits
    east(a) = eastCorr
    west(a) = westCorr
    north(a) = parapet
    south(a) = ( checkDoor(celldoor, cell1, a) )
    in(a) = ( self.south(a) )
;

celldoor: floater,door	// 175
    sdesc = "wooden door"
    noun = 'door'
    adjective = 'wooden' 'wood' 'cell'
    location = northCorr
    
    verIoPutUnder( a ) = "There is not enough room under this door. "
;

parapet: endroom		// 183
    sdesc = "Parapet"
    ldesc =
	"You are standing behind a stone retaining wall which rims a large
	parapet overlooking a fiery pit.  It is difficult to see through the
	smoke and flame which fills the pit, but it seems to be more or less
	bottomless.  It also extends upwards out of sight.  The pit itself
	is of roughly dressed stone and is circular in shape.  It is about
	two hundred feet in diameter.  The flames generate considerable heat,
	so it is rather uncomfortable standing here.
	\n\t   There is an object here which looks like a sundial.  On it are
	an indicator arrow and (in the center) a large button.  On the face
    	of the dial are numbers \"one\" through \"eight\".  The indicator
	points to the number \"<<sundial.setting>>\". "
    
    // --Exits
    south(a) = northCorr
    north(a) =
    {
	"You would be burned to a crisp in no time. ";
	return( nil );
    }
    down(a) = ( self.north(a) )
;

largebutton: buttonitem	// 176
    sdesc = "large button"
    noun = 'button'
    adjective = 'large'
    location = parapet

    doPush( actor ) =
    {
	"The button depresses with a slight click and pops back.\n";
	if (celldoor.isopen)
	    "The cell door is now closed. ";
	if (sundial.setting = cell1.thecell)
	    return;
	cell1.changeroom(sundial.setting);
    }
;

sundial: dialItem	// 177
    sdesc = "sundial"
    noun = 'dial' 'sundial'
    adjective = 'sun'
    location = parapet

    maxsetting = 8
    setting = 1
;

cell1: endroom		// 184
    sdesc = "Prison Cell"
    ldesc = {
	if (celldoor.isopen)
	    "This is a featureless prison cell.  You can see the east-west
	    corridor outside the open wooden door in front of you. ";
	else
	    "This is a featureless prison cell.  You can see only the flames
	    and smoke of the pit out of the small window in a closed wooden
	    door in front of you. ";
	if (self.thecell = 4) {
	    "Behind you is a bronze door which seems to be
	    <<bronzedoor.showstate>>. ";
	}
    }
    thecell = 1

    reachable = ( [celldoor master] + (thecell = 4 ? [bronzedoor] : []) )
    
    holders = [ [] [] [] [] [] [] [] [] ]
    changeroom( newcell ) =
    {
	local l, cur, tmp;

	/* move items in/out of virtual rooms */
	tmp := self.contents;

	l := holders[thecell];
	while( cur := car(l) ) {
	    cur.moveInto(self);
	    l := cdr(l);
	}

	l := tmp;
	while( cur := car(l) ) {
	    if (not isclass(cur, fixeditem)) {
		cur.moveInto(nil);
		holders[newcell] += cur;
	    }
	    l := cdr(l);
	}

	bronzedoor.isopen := nil;
	celldoor.isopen := nil;

	if (Me.isIn(self)) {
	    if (thecell = 4)	/* *old* value */
		Me.moveInto(cell3);
	    else
		Me.moveInto(cell2);
	}

	thecell := newcell;
    }
    
    // --Exits
    south(a) =
    {
	if (thecell <> 4)
	    return( self.noexit(a) );
	else
	    return( checkDoor(bronzedoor, southCorr, a) );
    }
    north(a) = ( checkDoor(celldoor, northCorr, a) )
    out(a) = ( self.north(a) )
;

cell2: endroom		// 185
    sdesc = "Prison Cell"
    ldesc = "This is a featureless prison cell.  Its wooden door is securely
	    fastened, and you can see only the flames and smoke of the pit
	    out its small window. "
    reachable = [lockeddoor master]

    // --Exits
    out(a) = { "The door is securely fastened. "; return( nil ); }
;

lockeddoor: floater,door	// 174
    sdesc = "locked door"
    noun = 'door' 'light'
    adjective = 'wooden' 'wood' 'cell' 'locked'
    location = cell2

    verDoOpen( actor ) = "The door is securely fastened. "
    verIoPutUnder( actor ) = "There is not enough room under this door. "
;

cell3: endroom		// 186
    sdesc = "Prison Cell"
    ldesc =
	"This is a featureless prison cell.  Its wooden door is securely
	fastened, and you can see only the flames and smoke of the pit
	out its small window.  On the other side of the cell is a bronze
	door which seems to be <<bronzedoor.showstate>>. "
    reachable = [bronzedoor lockeddoor master]

    // --Exits
    south(a) = { "The door is securely fastened. "; return( nil ); }
    north(a) = ( checkDoor(bronzedoor, nirvana, a) )
    out(a) = ( self.north(a) )
;

nirvana: endroom		// 187
    sdesc = "Nirvana"
    ldesc = "This is a room of large size, richly appointed and decorated
	    in a style that bespeaks exquisite taste.  To judge from its
	    contents, it is the ultimate storehouse of the treasures of Zork.
	    \n\t  There are chests here containing precious jewels, mountains
	    of zorkmids, rare paintings, ancient statuary, and beguiling
	    curios.
	    \n\t  In one corner of the room is a bookcase boasting such volumes
	    as \"The History of the Great Underground Empire\", \"The Lives of
	    the Twelve Flatheads\", \"The Wisdom of the Implementers\", and
	    other informative and inspiring works.
	    \n\t  On one wall is a completely annotated map of the Dungeon of
	    Zork, showing points of interest and various troves of treasure,
	    and indicating the locations of several superior scenic view.
	    \n\t  On the desk at the far end of the room may be found stock
	    certificates representing a controlling interest in FrobozzCo
	    International, the multinational conglomerate and parent company
	    of the Frobozz Magic Boat Co., etc.\n"

    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );

	"\b
	As you gleefully examine your new-found riches, the dungeon
	master himself materializes beside you and says, \"Now that you have
	solved all the mysteries of the dungeon, it is time for you to assume
	your rightfully-earned place in the scheme of things.  Long have I
	waited for one capable of releasing me from my burden!\"  He taps you
	lightly on the head with his staff and mumbles a few well-chosen
	spells.  You feel yourself changing, growing older and more stooped.
	For a moment there are two identical mages staring at each other among
	the treasures, then you watch as your counterpart dissolves into a mist
	and disappears, a sardonic grin on his face.
	\b";
	ciao();
    }
    
    scoreval = 35
;

guardian: Actor, floatingItem	// 274
    sdesc = "Guardian of Zork"
    noun = 'guard' 'guardian'

    verDoAttackWith( actor, io ) = { }
    doAttackWith( actor, io ) = ( self.doBreak( actor ) )
    doBreak( actor ) =
    {
	"Attacking the Guardians is about as useless as attacking a stone wall.
	Unfortunately for you, your futile blow attracts their attention, and
	they manage to dispatch you effortlessly. ";
	actor.died;
    }

    verDoHello( actor ) = "The statues are impassive. "
;

compass: floater		// 275
    sdesc = "compass rose"
    noun = 'rose'
    adjective = 'compass'
;

class mirpan: floater
    isReachable( actor ) =
    {
	if (actor.location.mirrorHere = 0)
	    return( nil );
	pass isReachable;
    }

    isbroken( a ) =
    {
	local m;
	m := a.location.mirrorHere;
	if (m > 0)
	    return(inMirror.broken[m]);
	return( nil );
    }

    verDoOpen( actor ) = "I don't see a way to open the <<self.sdesc>> here. "
    verDoMove( actor ) = ( self.verDoOpen( actor ) )

    verDoEnter( actor ) = { }
    doEnter( actor ) = ( actor.travelTo(actor.location.in(actor)) )
;

genpanel: mirpan	// 277
    sdesc = "panel"
    noun = 'panel'

    doBreak( actor ) =
    {
	if (self.isbroken(actor))
	    "The panel is not that easily destroyed. ";
	else
	    "To break the panel you would have to break the mirror first. ";
    }

    verDoPush( actor ) = { }
    doPush( actor ) =
    {
	if (actor.location.mirrorHere = 1)
	    "The wooden panel moves slightly inward as you push and back out
	    when you let go. ";
	else
	    "The panel is unyielding. ";
    }
;

mirrorbox: mirpan	// 276
    sdesc = "mirror"
    ldesc =
    {
	local m, b;
	if (self.isbroken(Me))
	    "The mirror is broken into little pieces. ";
	else
	    "A disheveled adventurer stares back at you. ";
    }
    noun = 'mirror' 'structure'

    verDoLookin( actor ) = { }
    doLookin( actor ) = ( self.ldesc )

    doBreak( actor ) =
    {
	if (self.isbroken(actor))
	    "The mirror has already been broken. ";
	else {
	    "The mirror breaks, revealing a wooden panel behind it. ";
	    inMirror.broken[actor.location.mirrorHere] := true;
	}
    }
    
    verDoPush( actor ) = { }
    doPush( actor ) =
    {
	if (self.isbroken(actor))
	    "Shards of a broken mirror are dangerous to play with. ";
	else if (actor.location.mirrorHere = 1)
	    "The mirror is mounted on a wooden panel which moves slightly
	    inward as you push and back out as you let go.  The mirror feels
	    fragile. ";
	else
	    "The mirror is unyielding but seems rather fragile. ";
    }

    dobjGen( a, v, i, p ) =
    {
	if (self.isbroken(a)) {
	    "Shards of a broken mirror are dangerous to play with. ";
	    exit;
	}
    }
;

channel: floater		// 278
    sdesc = "stone channel"
    noun = 'channel'
    adjective = 'stone'
;

master: Actor, floater		// 279
    sdesc = "dungeon master"
    noun = 'keeper' 'master'
    adjective = 'dungeon'
    heredesc = "The dungeon master is quietly leaning on his staff here."
    location = narrowCorr

    /* Note: master is added to the reachable lists of
     * northCorr, parapet, and the cells - this way, if we've
     * told him to stay, we can still give commands.
     * Minor nit with this (and Fortran version) is that it
     * isn't consistent (make him stay in narrowCorr and we can
     * see him from the parapet, but not vice versa).
     */

    goodverbs = [takeVerb, dropVerb, putVerb, throwVerb, pushVerb, turnVerb,
		 openVerb, closeVerb,]
    
    actorAction( v, d, p, i ) =
    {
	if (v = stayVerb) {
	    "The dungeon master says, \"I will stay.\" ";
	    unnotify(self, &follow);
	} else if (v = followVerb and Me.location <> endhall) {
	    "The dungeon master says, \"I will follow.\" ";
	    unnotify(self, &follow);
	    notify(self, &follow, 0);
	} else if (v.isTravelVerb) {
	    if ((v = nVerb and location = southCorr and cell1.thecell = 4) or
		((v = sVerb or v = inVerb) and location = northCorr))
		"\"I am not permitted to enter the prison cell.\" ";
	    else
		"\"I prefer to stay where I am, thank you.\" ";
	} else if (find(goodverbs, v) <> nil) {
	    return;  /* allowed verbs */
	} else
	    "\"I cannot perform that action for you.\" ";
	exit;
    }
    
    seen = nil
    following = true		/* this is just a useful "global" */
    
    follow =
    {
	local dirs, i, stat;
	if (location = Me.location)
	    return;
	if (Me.location = cell1 or Me.location = cell2) {
	    if (following)
		"\nYou notice that the dungeon master does not follow.\n";
	    following := nil;
	    return;
	}
	following := true;
	dirs := [&north, &south, &east, &west, &ne, &nw, &se, &sw,
		 &in, &out, &up, down];
	stat := outhide(true);  // turn off any possible movement messages
	for (i := 1; i <= 12; i++) {
	    if (self.location.(dirs[i])(nil) = Me.location)
		break;
	}
	outhide(stat);
	"\nThe dungeon master <<(i<=12)? "follows" : "catches up to">> you.\n";
	self.moveInto(Me.location);
    }

    verDoTake( actor ) =
	"\"I'm willing to accompany you but not to ride in your pocket!\" "
    
    verDoAttackWith( actor, io ) = { }
    doAttackWith( actor, io ) =
    {
	"The dungeon master is taken momentarily by surprise.  He dodges your
	blow and then, with a disappointed expression on his face, he raises
	his staff and traces a complicated pattern in the air.  As it
	completes you crumble into dust. ";
	actor.died;
    }
    verDoAttack( actor ) = { }
    doAttack( actor ) = ( self.doAttackWith( actor, nil ) )
    doSynonym('Attack') = 'Break'
;
