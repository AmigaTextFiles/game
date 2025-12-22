/* The thief and treasure room */

/* Link together all the rooms that the thief can visit, so that each
 * time the thief moves, we just look up &nextthiefpos.
 * This is called from preinit().
 */
initThief: function
{
    local o, first, prev;
    first := prev := nil;
    
    for (o := firstobj(room); o; o := nextobj(o, room)) {
	if (o.sacred or o.iswater or isclass(o,endroom))
	    continue;
	o.nextthiefpos := prev;
	prev := o;
	if (first = nil)
	    first := o;
    }
    first.nextthiefpos := prev;	/* link in a ring */
}

treasureRoom: darkroom	// 103
    sdesc = "Treasure Room"
    ldesc = "This is a large room, whose north wall is solid granite.  A number
	    of discarded bags, which crumble at your touch, are scattered about
	    on the floor.  There is an exit down and what appears to be a newly
	    created passage to the east."

    reachable = [granitewall]
    scoreval = 25
    hiddentreasure = []

    /* catch magic word */
    roomAction( a, v, d, p, i ) =
    {
	if ( v = templeVerb ) {
	    a.travelTo(temple);
	    exit;
	}
    }

    enterRoom( a ) =
    {
	if (getfuse(thief, &thiefdaemon) <> nil and not a.isdead) {
	    local anymoved, cur, l;
	    if (thief.location <> self) {
		"You hear a scream of anguish as you violate the robber's
		hideaway.  Using passages unknown to you, he rushes to its
		defense.\n";
		thief.moveInto(self);
	    }
	    thief.pos := self;
	    thief.fighting := true;

	    /* vanish treasures */
	    anymoved := nil;
	    l := self.contents;
	    while ( cur := car(l) ) {
		if (cur <> chalice and not isclass(cur, Actor)) {
		    anymoved := true;
		    cur.moveInto(nil);
		    hiddentreasure += cur;
		}
		l := cdr(l);
	    }
	    if (anymoved)
		"The thief gestures mysteriously, and the treasures in the
		room suddenly vanish.\n";
	}
	pass enterRoom;
    }
    restoreTreasure( verbose ) =
    {
	local cur, f;
	if (verbose and length(hiddentreasure) > 0)
	    "\nAs the thief dies, the power of his magic decreases, and his
	    treasures reappear:\n";
	while( cur := car(hiddentreasure) ) {
	    if (verbose)
		"\t\^<<cur.adesc>>.\n";
	    cur.moveInto(self);
	    hiddentreasure := cdr(hiddentreasure);
	}
    }
    
    // --Exits
    down(a) = cyclopsRoom
    east(a) = squareRoom
;

chalice: treasure,container		//  59
    sdesc = "chalice"
    noun = 'chalice' 'cup' 'goblet'
    adjective = 'silver'
    heredesc = "There is a silver chalice, intricately engraved, here."
    location = treasureRoom
    findscore = 10
    trophyscore = 10
    bulk = 10
    maxbulk = 5

    verDoTake( a ) =
    {
	if (self.isIn(treasureRoom) and
	    thief.isIn(treasureRoom) and thief.fighting)
	{
	    "Realizing just in time that you'd be stabbed in the back if you
	    attempted to take the chalice, you return to the fray. ";
	}
    }
;

granitewall: floater,wall	// 265
    /* in temple, treasureRoom */
    sdesc = "granite wall"
    ldesc = "The north wall is solid granite here. "
    noun = 'wall'
    adjective = 'granite'
    verDoFind( actor ) = ( self.ldesc )
;

thief: thief_messages,villain		//  61
    sdesc = "thief"
    noun = 'thief' 'robber' 'criminal' 'bandit' 'crook' 'gent' 'gentleman'
           'man' 'individual' 'bagman'
    adjective = 'shady' 'suspicious'
    heredesc =
    {
	if (not unconscious)
	    "There is a suspicious-looking individual, holding a bag,
	    leaning against one wall.  He is armed with a vicious-looking
	    stiletto.";
	else
	    "There is a suspicious-looking individual lying unconscious on the
	    ground.  His bag and stiletto seem to have vanished. ";
    }
    location = nil
    pos = puzzleRoom
    
    strength = 5
    bestweap = knife		/* our nemesis */
    engrossed = nil
    seen = nil
    
    outcold =
    {
	inherited.outcold;
	unnotify(self, &thiefdaemon);
    }
    
    wakeup =
    {
	inherited.wakeup;
	notify(self, &thiefdaemon, 0);
	if (self.isVisible(Me))
	    "The robber revives, briefly feigning continued unconsciousness,
	    and when he sees his moment, scrambles away from you.\n";
    }

    checkfight = ( prob(20,75) )
    checkweapon =
    {
	if (stiletto.isIn(self))
	    return( true );	/* we can still fight */
	if ( stiletto.location <> self.location ) {
	    self.moveInto(nil);	/* run away! */
	    if (self.isVisible(Me))
		"Annoyed to be left unarmed in such an obviously dangerous
		neighborhood, the thief slips off into the shadows.\n";
	} else {
	    stiletto.moveInto(self);
	    if (self.isVisible(Me))
		"The robber, somewhat surprised by this turn of events, nimbly
		recovers his stiletto.\n";
	}
	return( nil );		/* no combat this round */
    }

    died =
    {
	local cur, l, f;
	unnotify(self, &thiefdaemon);
	
	/* bring back hidden treasures */
	treasureRoom.restoreTreasure( Me.isIn(treasureRoom) );

	/* bring back booty */
	f := nil;
	l := thiefBag.contents;
	while( cur := car(l) ) {
	    if (not f) {
		f := true;
		"\nThe booty from his bag remains:\n";
	    }
	    "\t\^<<cur.adesc>>.\n";
	    cur.moveInto(self.location);
	    l := cdr(l);
	}
	inherited.died;
    }

    vanish =
    {
	self.moveInto(nil);
	if (stiletto.isIn(pos) or stiletto.isIn(thiefBag))
	    stiletto.moveInto(thief);
    }

    winning =
    {
	local vs, ps;
	vs := self.strength;
	ps := vs - Me.attackstr(nil);
	if (ps > 3)		/* margin of +3 => 90% */
	    return( prob(90, 100) );
	if (ps > 0)		/* margin > 0 => 75% */
	    return( prob(75, 85) );
	if (ps = 0)		/* margin = 0 => 50% */
	    return( prob(50, 30) );
	if (vs > 1)		/* any str at all => 25% */
	    return( prob(25, 25) );
	return( prob(10, 0) );
    }

    steal( ob ) =
    {
	ob.touched := true;
	ob.moveInto(thiefBag);
	if (ob = rope)
	    ob.untie;
    }

    robplayer =
    {
	local waslit;
	waslit := Me.location.islit;
	
	seen := true;
	if (stealtreasures(pos, 100, thiefBag)) {
	    if (location = nil)
		"A seedy-looking individual with a large bag just wandered
		through the room.  On the way, he quietly abstracted all
		valuables from the room and from your possession, mumbling
		something about, \"Do unto others before...\".\n";
	    else
		"The other occupant just left carrying his large bag.  You
		may not have noticed that he robbed you blind first.\n";
	} else {
	    if (location = nil)
		"A \"lean and hungry\" gentleman just wandered through.
		Finding nothing of value, he left disgruntled.\n";
	    else
		"The other occupant (he of the large bag), finding nothing of
		value, left disgusted.\n";
	}
	self.vanish;
	if (waslit and not Me.location.islit)
	    "\nThe thief seems to have left you in the dark.\n";
    }
    robroom =
    {
	/* look for things to snarf in the room */

	local l, cur;

	/*
	"(Thief looks for treasure in <<pos.sdesc>>";
	if (not pos.isseen) " (unseen)";
        ")\n";
	*/
	
	self.vanish;
	if (pos.isseen) {
	    stealtreasures(pos, 75, thiefBag);
	    /* Thief may also steal non treasure left on ground.
	     * (remember, we only rob visited rooms)
	     */
	    if (pos.ismaze and Me.location.ismaze) {
		/* both in maze, be obnoxious */
		l := pos.contents;
		while ( cur := car(l) ) {
		    if (prob(60,60) and not cur.isfixed) {
			"You hear, off in the distance, someone saying,
			\"My, I wonder what this fine <<cur.sdesc>> is
			doing here?\"\n";
			if (prob(40,20))
			    break;
			self.steal(cur);
		    }
		    l := cdr(l);
		}
	    } else {
		l := pos.contents;
		while ( cur := car(l) ) {
		    if (not isclass(cur, treasure) and prob(20,40)
			and not cur.isfixed)
		    {
			self.steal(cur);
			if (pos = Me.location and not Me.isdead)
			    "You suddenly notice that <<cur.thedesc>> has
			    vanished.\n";
			return;	/* only steal 1 item */
		    }
		    l := cdr(l);
		}
	    }
	}
    }
    droploot =
    {
	if (location) {
	    self.vanish;
	    treasureRoom.restoreTreasure( nil );
	}
	/* leave valuables behind */
	if (egg.isIn(thiefBag))
	    egg.isopen := true; /* nimble fingers */
	stealtreasures(thiefBag, 100, treasureRoom);
    }
    harryplayer =
    {
	/* thief is in player's room.  If we return true, we also
	 * return right away from thiefdaemon (ie, so we don't try
	 * getting a new pos).
	 */
	if (not seen) {
	    if (location <> nil) { /* visible */
		if (fighting) {
		    if (not self.winning) {
			"Your opponent, determining discretion to be the
			better part of valor, decides to terminate this little
			contretemps.  With a rueful nod of his head, he steps
			backward into the gloom and disappears.\n";
			fighting := nil;
			self.vanish;
			return( true );
		    }
		    if (prob(90,90))
			return( nil );
		}
		if (prob(30,30)) {
		    "The holder of the large bag just left, looking
		    disgusted.  Fortunately, he took nothing.\n";
		    self.vanish;
		    return( true );
		}
	    } else if (prob(30,30)) {
		if (not stiletto.isIn(self))
		    return( nil );
		thief.moveInto(pos);
		"Someone carrying a large bag is casually leaning against
		one of the walls here.  He does not speak, but it is clear
		from his aspect that the bag will be taken only over his
		dead body.\n";
		seen := true;
		return( true );
	    }  /* else no introduction for now */
	} else if (location = nil) {
	    return( nil );
	}
	
	if (prob(70,70))
	    return( true );
	self.robplayer;
	return( nil );
    }
    
    thiefdaemon =
    {
	local once, waslit;

	once := nil;
	
    uglyhack:
	
	if (location)
	    pos := location;

	"\n";
	if (pos = treasureRoom)
	{
	    if (pos <> Me.location)
		droploot;
	}
	else if (Me.isIn(pos) and isclass(pos,darkroom) and not Me.isdead)
	{
	    /* Player is here, and room normally dark */
	    if (self.harryplayer)
		return;
	}
	else
	{
	    /* not in players room or treas room, or in light room */
	    self.robroom;
	}
	
	if (not once) {
	    once := true;
	    seen := nil;

	    pos := pos.nextthiefpos;

	    /* loop a second time (sigh) */
	    goto uglyhack;
	}

	if (pos <> treasureRoom) {
	    /* maybe drop non treasure items */
	    local l, cur, f;
	    l := thiefBag.contents;
	    f := nil;
	    while ( cur := car(l) ) {
		if (not isclass(cur, treasure) and prob(30,70)) {
		    cur.moveInto(pos);
		    f := true;
		}
		l := cdr(l);
	    }
	    if (f and Me.isIn(pos))
		"\nThe shadowy figure rummages through his large bag and dump
		some items on the ground. ";
	}
    }

    verDoTake( actor ) = "Once you got him, what would you do with him? "

    verDoHello( actor ) = {}
    doHello( actor ) =
    {
	if (unconscious)
	    "The thief, being temporarily incapacitated, is unable to
	    acknowledge your greeting with his usual graciousness. ";
	else
	    inherited.doHello( actor );
    }

    checkwake =
    {
	if (unconscious) {
	    "Your proposed victim suddenly recovers consciousness. ";
	    self.wakeup;
	    return( true );
	}
	return( nil );
    }
    
    ioGiveTo( actor, dobj ) =
    {
	self.checkwake;
	if (isclass(dobj, treasure)) {
	    /* engross the thief */
	    engrossed := true;
	    "The thief is taken aback by your unexpected generosity but
	    accepts <<dobj.thedesc>> and stops to admire its beauty.\n";
	    dobj.moveInto(thiefBag);
	} else if ( dobj = brick and brick.dangerous ) {
	    "The thief seems rather offended by your offer.  Do you think
	    he's as stupid as you are?\n";
	} else {
	    "The thief places <<dobj.thedesc>> in his bag and thanks
	    you politely.\n";
	    dobj.moveInto(thiefBag);
	}
    }
    
    verIoThrowTo( actor ) = { }
    ioThrowTo( actor, dobj ) =
    {
	self.checkwake;
	if (not fighting and dobj = knife) {
	    dobj.moveInto(self.location);
	    if (prob(10,10)) {
		"You evidently frightened the robber, although you missed him.
		He flees";
		if (car(thiefBag.contents)) {
		    local cur;
		    ", but the contents of his bag fall on the floor.\n";
		    while( cur := car(thiefBag.contents) )
			cur.moveInto(self.location);
		} else {
		    ".\n";
		}
		self.moveInto(nil); /* vanish */
	    } else {
		"You missed.  The thief makes no attempt to take the knife,
		although it would be a fine addition to the collection in
		his bag.  He does seem angered by your attempt.\n";
		fighting := true;
	    }
	} else {		/* not the knife */
	    self.ioGiveTo( actor, dobj );
	}
    }
    verIoThrowAt( actor ) = { }
    ioThrowAt( actor, dobj ) = ( self.ioThrowTo( actor, dobj ) )
;

stiletto: weapon,weapon_messages	//  62
    sdesc = "stiletto"
    noun = 'stiletto'
    adjective = 'vicious'
    heredesc = "There is a vicious-looking stiletto here."
    location = thief
    bulk = 10
;

thiefBag: object		/* dummy holder */ 
    sdesc = "Thieve's bag"	/* debugging */
;
