/* A *visible* fixeditem.  Common enough in Dungeon.
 * We inherit item as well (fixeditem doesn't) so we get
 * our showdesc mods, etc.
 */
class immobile: fixeditem, item
    isListed = true
;

/* there's enough of these... */
class deadend: darkroom
    sdesc = "Dead End"
    ldesc = "Dead end."
;

/* Fixed item with a variable location...
 * If it's in room, then that should include the floater in
 * that room's 'reachable' list.
 *
 * A floater will NOT be accessible via "all" (get all won't see it),
 * but that's not a problem for us.
 */
class floater: fixeditem, floatingItem
    location = nil		/* we're nowhere */

    isVisible(actor) =
    {
	return( self.isReachable(actor) );  /* why not? */
    }
;


class weapon: item
    verIoAttackWith( actor ) =
    {
	if (not actor.isCarrying(self))
	    "You're not holding it! ";
    }
    ioAttackWith( actor, dobj ) =
    {
	dobj.doAttackWith( actor, self );
    }
    
    /* play violin with weapon v165 */
    /* open egg with weapon O35 */
;

/* This is not doorway - it works differently, and isn't
 * expected to be returned from a direction method.  Instead,
 * the direction method tests this if it's open or not.
 */
class door: doorway
    /* handles knock, open, close, look in, put under, put */
    isopen = nil
    islocked = nil
    destination = nil

    showstate =
    {
	if (self.isopen)
	    "open";
	else
	    "closed";
    }
    
    verDoOpen( actor ) =
    {
	if (self.isopen)
	    dummy();
	else if (self.islocked)
	    "\^<<self.thedesc>> is locked. ";
    }
    doOpen( actor ) =
    {
	self.openMessage(actor);
	self.isopen := true;
    }
    verDoClose( actor ) =
    {
	if (not self.isopen)
	    dummy();
    }
    doClose( actor ) =
    {
	self.closeMessage(actor);
	self.isopen := nil;
    }
    /* Don't need lock stuff, since only grating uses that, and
     * it defines its own.
     */
    
    openMessage(actor) = "\^<<self.thedesc>> opens. "
    closeMessage(actor) = "\^<<self.thedesc>> closes. "

    verDoKnock( actor ) = "I don't think that anybody is home. "
;

class treasure: item
    plural = 'treasures' 'valuables'
    findscore = 0
    trophyscore = 0
    
    doTake(a) =
    {
	inherited.doTake(a);
	if (Me.isCarrying(self)) {
	    incscore(self.findscore);
	    self.findscore := 0;
	}
    }
;

class lamp: lightsource
    islit = nil

    /* these can light other objects at times */
    verIoBurnWith( actor ) =
    {
	if (not self.hasflame)
	    pass verIoBurnWith;
    }
    ioBurnWith( actor, dobj ) = { dobj.doBurnWith( actor, self); }

    moveInto( dest ) =
    {
	if (dest = nil and islit and self.isIn(Me)) {
	    self.turnoff(Me);
	}
	pass moveInto;
    }
    verDoTurnon( actor ) =
    {
	if (self.islit)
	    "It is already on. ";
	else if (self.turnsleft = nil)
	    "You can't turn that on. ";
    }
    doTurnon( actor ) =
    {
	self.onMessage;
	self.turnon(actor);
    }

    verDoTurnoff( actor ) =
    {
	if (not self.islit)
	    "It is already off. ";
    }
    doTurnoff( actor ) =
    {
	self.offMessage;
	self.turnoff(actor);
    }
    
    turnon(actor) =
    {
	local wasdark;
	if (actor <> nil)
	    wasdark := not actor.location.islit;
	if (datatype(self.turnsleft) <> 7) /* not a list */
	    self.turnsleft := [ self.turnsleft ];
	self.islit := true;
	notify(self, &keepburning, 0);
	if (actor <> nil and wasdark) {
	    "\b";
	    actor.location.lookAround(
		( not actor.location.isseen ) or global.verbose );
	}
    }
    turnoff(actor) =
    {
	self.islit := nil;
	unnotify(self, &keepburning);
	if (actor <> nil and self.isVisible(actor)
	                 and not actor.location.islit)
	    "\nIt is now pitch black. ";
    }
    onMessage = "\^<<self.thedesc>> is now on. "
    offMessage = "\^<<self.thedesc>> is now off. "
    burnoutMessage = "I hope you have more light than from <<self.adesc>>.\n"
    
    keepburning =
    {
	self.turnsleft[1] -= 1;
	if (self.turnsleft[1] > 0) return;
	
	self.turnsleft := cdr(self.turnsleft);

	if (length(self.turnsleft) > 1 and self.isVisible(Me)) {
	    "\n"; self.dimming1;
	} else if (length(self.turnsleft) = 1 and self.isVisible(Me)) {
	    "\n"; self.dimming2;
	} else if (length(self.turnsleft) = 0) {
	    /* sigh, assuming Me is the actor here... */
	    self.turnsleft := nil;
	    if (self.isVisible(Me)) {
		"\n"; self.burnoutMessage;
	    }
	    self.turnoff(Me);
	}
    }
;

class burnable: item
    hasflame = ( self.islit )

    verDoBurnWith( actor, io ) = { }
    doBurnWith( actor, io ) =
    {
	if (actor.isCarrying(self)) {
	    "\^<<self.thedesc>> catches fire.\n
	    Unfortunately, you were holding it at the time.\n";
	    actor.died;
	} else if (self.isIn(receptacle)) {
	    balloon.burn(self);
	} else {
	    "\^<<self.thedesc>> catches fire and is consumed. ";
	    self.moveInto(nil);
	}
    }

    /* water poured on us */
    douse( actor ) =
    {
	if (self.hasflame) {
	    if (self.isIn(receptacle)) {
		"The water enters but cannot stop
		<<self.thedesc>> from burning. ";
	    } else {
		"\^<<self.thedesc>> is extinguished. ";
		self.turnoff(actor);  /* in case we're a lamp */
	    }
	    return;
	} else
	    pass douse;
    }
;

class tieable: item
    tiedto = nil
    
    verDoTieTo( actor, io ) =
    {
	if (self.tiedto <> nil)
	    "\^<<self.thedesc>> is already tied to <<io.thedesc>>. ";
    }
    doTieTo( actor, io ) =
    {
	self.tiedto := io;
    }
    verIoTieWith( actor ) = { }
    ioTieWith( actor, dobj ) =
    {
	if (dobj = Me)
	    "You can't tie yourself up. ";
	else if (dobj.isactor)
	    /* they're all him's, so... */
	    "\^<<dobj.thedesc>> struggles and you cannot tie him up. ";
	else
	    "You can't tie that up. ";  /* may never get here */
    }

    verDoUntie( actor ) =
    {
	if (self.tiedto = nil)
	    "\^<<self.thedesc>> is not tied to anything. ";
    }
    verDoUntieFrom( actor, io ) =
    {
	if (io <> self.tiedto)
	    "\^<<self.thedesc>> is not tied to <<io.thedesc>>. ";
    }
    doUntie( actor ) =
    {
	"\^<<self.thedesc>> is now untied. ";
	self.untie;
    }
    untie = { self.tiedto := nil; }

;

/* transforms 'climb' and 'climb down' into 'up' and 'down' */
class climbable: item
    verDoClimb( actor ) = { }
    doClimb( actor ) =
    {
	global.tv := uVerb;
	actor.travelTo( actor.location.up(actor) );
    }
    verDoClimbdown( actor ) = { }
    doClimbdown( actor ) =
    {
	global.tv := dVerb;
	actor.travelTo( actor.location.down(actor) );
    }
;

/* transparent ? */
class water: item
    heredesc = "There is some water here."

    verifyRemove( actor ) = "You can't do that. "
    verDoTake( actor ) = "The water slips through %your% fingers. "
    verDoPutOn( actor, io ) = "That would be a good trick. "

    verDoPutIn( actor, io ) =
    {
	if (io <> bottle)
	    self.verDoPourIn( actor, io );
    }
    doPutIn( actor, io ) = ( self.doPourIn( actor, io ) )
    
    verDoPour( actor ) =
    {
	if (not actor.isCarrying(self))
	    "%You're% not carrying <<self.thedesc>>! ";
    }
    doPour( actor ) =
    {
	if (actor.location.isvehicle) {
	    "There is now a puddle in the middle of
	    <<actor.location.thedesc>>. ";
	    somewater.moveInto(actor.location);
	} else {
	    if (actor.location.iswater or actor.location.canfill)
		"The water spills out. ";
	    else
		"The water spills to the floor and evaporates immediately. ";
	    self.moveInto(nil);
	}
    }

    verDoPourOn( actor, io ) = { self.verDoPour( actor ); }
    doPourOn( actor, io ) =
    {
	io.douse( actor );
	self.moveInto(nil);
    }
    
    verDoPourIn( actor, io ) = { self.verDoPour( actor ); }
    doPourIn( actor, io ) =
    {
	/* Not very OO, but it's more localized */
	if (isclass(io, vehicle)) {
	    "There is now a puddle in the middle of <<io.thedesc>>. ";
	    somewater.moveInto(io); /* hmm... */
	} else if (io = receptacle) {
	    io.douse(actor);
	} else if (io <> bottle) {
	    "The water leaks out of <<io.thedesc>> and evaporates
	    immediately. ";
	    self.moveInto(nil);
	} else {
	    io.doFillWith( actor, self );
	}
    }

    verIoFillWith( actor ) = { }
    ioFillWith( actor, dobj ) = { dobj.doFillWith( actor, self); }

    verDoDrink( actor ) = {  self.verifyRemove( actor ); }
    doDrink( actor ) =
    {
	"Thank you very much.  I was rather thirsty, probably from all
	this talking.";
	self.moveInto(nil);
    }
    
    verDoEnter( actor ) = "Swimming is not allowed in this dungeon. "
;

class wall: fixeditem
    verDoClimb( actor ) = "Climbing the walls is of no avail. "
    verDoClimbdown( actor ) = "Climbing the walls is of no avail. "
;

class palantir: treasure
    verDoLookin( actor ) = { }
    doLookin( actor ) =
    {
	local dest;
	dest := toplocation(self.othersphere);
	if (dest <> nil and isclass(dest,room) and dest.islit
	    and self.othersphere.isVisible(dest))
	{
	    "As you peer into the sphere, a strange vision takes shape of
	    a distant room, which can be clearly described...\b";
	    othersphere.isListed := nil;
	    dest.lookAround( true ); "\n";
	    if (actor = Me and Me.isIn(dest))
		"An astonished adventurer is staring into <<self.adesc>>.\n";
	    othersphere.isListed := true;
	} else {
	    "You see only darkness. ";
	}
    }
;

/* A drivable vehicle.  (magic boat and balloon) */
class transport: vehicle
    isdroploc = true
    nowalls = true
    
    noexit(a) =
    {
	if (a <> nil) "%You% can't go that way. ";
	return( nil );
    }

    /* This is Bogus!  'out' and 'get out of' should be the SAME THING,
     * but 'out' is a travelverb and 'get out of' goes through verDoUnboard
     * and doUnboard - and the two don't reconcile.
     */
    doUnboard(a) =
    {
	if (self.location.iswater or self.location.isair) {
	    "You realize, just in time, that disembarking here
	    would probably be fatal. ";
	} else
	    pass doUnboard;
    }
    out(a) =
    {
	if (self.location.iswater or self.location.isair) {
	    if (a<>nil)
            "You realize, just in time, that disembarking here
	    would probably be fatal. ";
	    return( nil );
	}
	return( self.location );
    }
    doSynonym('Unboard') = 'Disembark'

    travelTo( actor, dest ) =
    {
	if (dest) {
	    if (dest.munged <> nil) {
		dest.munged.showmunged;
	    } else {
		self.moveInto(dest);
		dest.enterRoom( actor );
	    }
	}
    }
    
    /* sigh, these won't do for land vehicles, but we don't have any... */
    verDoLaunch( a ) =
    {
	if (not a.isIn(self))
	    "It would work better with %you% on board. ";
    }
    doLaunch( a ) =
    {
	/* Note, we test with defined(), because there might be
	 * something that uses launch/land to print a message and
	 * return nil (see reservoir).
	 */
	local dest;
	if (self.validdest(self))
	    "%You've% already launched it! ";
	else if (not defined(self.location, &launch) or
		 not self.validdest(dest := self.location.launch(a)) )
	    "%You% can't launch <<self.thedesc>> here. ";
	else
	    self.travelTo(a, dest);
    }
    verDoLand( a ) =
    {
	if (not a.isIn(self))
	    "It would work better with %you% on board. ";
    }
    doLand( a ) =
    {
	if (not self.validdest(self))
	    "%You're% already on land. ";
	else if (not defined(self.location, &land))
	    "%You% can't land here. ";
	else
	    self.travelTo(a, self.location.land(a));
    }
    
    /* Now we cheat.  Most of the directions are allowed here, but
     * are passed on to self.travel().
     */
    validdest( dest ) = true	/* override for water/air craft */
    travel(a, dirp) =
    {
	local dest;
        if (self.location = nil)
            return( nil );
	dest := self.location.(dirp)(a);
	if (dest = nil)
	    return( nil );
	if (not self.validdest(dest)) {
	    if (a<>nil)
            "You can't go there in <<self.adesc>>. ";
	    return( nil );
	}

	/* now do the actual move */
        self.travelTo( a, dest );
	exit;			/* don't return to the travelVerb */
    }
    
    north(a) = ( self.travel(a, &north) )
    south(a) = ( self.travel(a, &south) )
    east(a)  = ( self.travel(a, &east) )
    west(a)  = ( self.travel(a, &west) )
    up(a)    = ( self.travel(a, &up) )
    down(a)  = ( self.travel(a, &down) )
    ne(a)    = ( self.travel(a, &ne) )
    nw(a)    = ( self.travel(a, &nw) )
    se(a)    = ( self.travel(a, &se) )
    sw(a)    = ( self.travel(a, &sw) )
    cross(a) = ( self.travel(a, &cross) )
;

class mirror: fixeditem
    sdesc = "mirror"
    noun = 'mirror'
    ldesc =
    {
	if (self.broken)
	    "The mirror is broken into many pieces. ";
	else
	    "There is an ugly person staring at you. ";
    }
    broken = nil
    othermirror = nil
    
    verDoTouch( a ) = { if (self.broken) pass verDoTouch; }
    doTouch( a ) =
    {
	local cur, l, loc1, loc2;
	/* swap contents of rooms */
	loc1 := location;
	loc2 := othermirror.location;
	l := loc1.contents + loc2.contents;
	while( cur := car(l) ) {
	    if (cur.location = loc1)
		cur.moveInto(loc2);
	    else
		cur.moveInto(loc1);
	    l := cdr(l);
	}
	a.moveInto(loc2);
	"There is a rumble from deep within the earth, and the room shakes.\n";
    }

    doSynonym('Inspect') = 'Lookin'

    verDoTake( a ) =
	"Nobody but a greedy surgeon would allow you to attempt that trick. "

    doBreak( a ) =
    {
	if (not broken)
	    "You have broken the mirror.  I hope you have a seven years supply
	    of good luck handy. ";
	else
	    "Haven't you done enough already? ";
	global.badluck := true;	/* oops */
	broken := true;
	othermirror.broken := true;
    }
    verDoAttackWith( a, io ) = { }
    doAttackWith( a, io ) = ( self.doBreak( a ) )
    ioThrowAt( a, dobj ) = ( self.doBreak( a ) )
;
