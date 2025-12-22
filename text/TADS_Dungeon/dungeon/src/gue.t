/* Miscellaneous caves, caverns, passages, etc, of the G.U.E.
 * Ie, connective tissue, or areas undeserving of their own file.
 */

/**
 ** Cellar area (with troll)
 **/

cellar: darkroom		//   9
    sdesc = "Cellar"
    ldesc = {
	"This is a dark and damp cellar with a narrow passageway leading
	east, and a crawlway to the south.  To the west is the bottom of
	a steep metal ramp which is unclimbable. ";
	if (trapdoor.isopen)
	    "Above you is an open trap door. ";
    }
    scoreval = 25
    reachable = [trapdoor]

    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (trapdoor.isopen and (not trapdoor.touched)) {
	    trapdoor.doClose(actor);
	    trapdoor.touched := true;
	}
    }
    
    // --Exits
    east(a) = trollrm
    south(a) = westChasm
    west(a) =
    {
	"You try to ascend the ramp, but it is impossible, and you
	slide back down. ";
	return( nil );
    }
    up(a) = { return( checkDoor(trapdoor, livingrm, a) ); }
;

trollrm: darkroom		//  10
    sdesc = "Troll Room"
    ldesc = "This is a small room with passages off in all directions.
	    Bloodstains and deep scratches (perhaps made by an axe) mar
	    the walls. "

    // --Exits
    checktroll(a, dest) =
    {
	if (a and troll.isIn(self) and (not troll.unconscious)) {
	    "The troll fends you off with a menacing gesture. ";
	    return( nil );
	}
	return( dest );
    }
    west(a) = cellar
    east(a) = ( self.checktroll(a, nsCrawl ) )
    north(a) = ( self.checktroll(a, ewPassage ) )
    south(a) = ( self.checktroll(a, maze1 ) )
;

troll: troll_messages,villain	//  19
    sdesc = "troll"
    noun = 'troll'
    adjective = 'nasty'
    heredesc =
    {
	if (not unconscious)
	    "A nasty-looking troll, brandishing a bloody axe, blocks all
	    passages out of the room. ";
	else
	    "An unconscious troll is sprawled on the floor.  All passages out
	    of the room are open. ";
    }
    location = trollrm

    bestweap = sword		/* our nemesis */
    strength = 2

    wakeup =
    {
	/* Original hid axe when knocked out, and restored when
	 * recovered, but this is wierd and isn't necessary.
	 */
	inherited.wakeup;
	if (self.isVisible(Me))
	    "The troll stirs, quickly resuming a fighting stance.\n";
    }

    checkfight = ( prob(33, 66) )

    checkweapon =
    {
	if (axe.isIn(self))
	    return( true );	/* we can still fight */
	if ( axe.location <> self.location or prob(25,10) ) {
	    if (self.isVisible(Me))
		"The troll, disarmed, cowers in terror, pleading for his life
		in the guttural tongue of the trolls.\n";
	} else {
	    axe.moveInto(self);
	    if (self.isVisible(Me))
		"The troll, now worried about this encounter, recovers his
		bloody axe.\n";
	}
	return( nil );		/* no combat this round */
    }
    
    checkwake =
    {
	if (unconscious) {
	    "The troll stirs, quickly resuming a fighting stance. ";
	    self.wakeup;
	    return( true );
	}
	return( nil );
    }

    died =
    {
	if (axe.isIn(self) or axe.location = self.location)
	    axe.moveInto(nil);
	pass died;
    }
    
    verDoTake( a ) =
    {
	if (not self.checkwake)
	    "The troll spits in your face, saying \"Better luck next time\".";
    }
    verDoMove( a ) = ( self.verDoTake( a ) )
    verDoBreak( a ) =
    {
	if (not self.checkwake)
	    "The troll laughs at your puny gesture.";
    }
    verDoThrow( a ) = ( self.verDoTake( a ) )

    catchit(dobj) =
    {
	if (dobj = knife) {
	    "and being for the moment sated, throws it back.  Fortunately, the
	    troll has poor control, and the knife falls on the floor.  He does
	    not look pleased. ";
	    self.fighting := true;
	    knife.moveInto(troll.location);
	} else {
	    "and not having the most discriminating tastes,
	    gleefully eats it. ";
	    dobj.moveInto(nil);	/* gulp */
	}
    }
    ioGiveTo( actor, dobj ) =
    {
	self.checkwake;
	"The troll, who is not overly proud, graciously accepts the gift ";
	self.catchit(dobj);
    }
    verIoThrowTo( actor ) = { }
    ioThrowTo( actor, dobj ) =
    {
	self.checkwake;
	"The troll, who is remarkably coordinated, catches <<dobj.thedesc>> ";
	self.catchit(dobj);
    }
    verIoThrowAt( actor ) = { }
    ioThrowAt( actor, dobj ) = ( self.ioThrowTo( actor, dobj ) )

    doHello( actor ) = "Unfortunately, the troll can't hear you. "
;

axe: weapon,weapon_messages		//  20
    sdesc = "bloody axe"
    noun = 'axe'
    adjective = 'bloody'
    heredesc = "There is a bloody axe here."
    location = troll
    bulk = 25

    doTake( a ) =
	"The troll's axe seems white hot.  You can't hold on to it. "

;

nsCrawl: darkroom		//  81
    sdesc = "North-South Crawlway"
    ldesc = "This is a north-south crawlway;  a passage also goes to the east.
	    There is a hole above, but it provides no opportunities for
	    climbing. "
    // --Exits
    north(a) = westChasm
    south(a) = studio
    east(a) = trollrm
    up(a) = { "Not even a human fly could get up it."; return( nil ); }
;

westChasm: darkroom		//  82
    sdesc = "West of Chasm"
    ldesc = "You are on the west edge of a chasm, the bottom of which cannot be
	    seen.  The east side is sheer rock, providing no exits.  A narrow
	    passage goes west.  The path you are on continues to the north
	    and south. "
    // --Exits
    west(a) = cellar
    north(a) = nsCrawl
    south(a) = gallery
    down(a) =
    {
	"The chasm probably leads directly to the infernal regions.";
	return( nil );
    }
;

studio: darkroom		// 104
    sdesc = "Studio"
    ldesc = "This is what appears to have been an artist's studio.  The walls
	    and floors are splattered with paints of 69 different colors.
	    Strangely enough, nothing of value is hanging here.  At the north
	    and northwest of the room are open doors (also covered with paint).
	    An extremely dark and narrow chimney leads up from a fireplace.
	    Although you might be able to get up the chimney, it seems unlikely
	    that you could get back down. "
    
    // --Exits
    north(a) = nsCrawl
    nw(a) = gallery
    up(a) =
    {
	local cnt;
	if (a and not a.isdead) {
	    cnt := itemcnt(a.contents);
	    if (cnt > 2)
		"The chimney is too narrow for you and all of your baggage. ";
	    else if (cnt = 0)
		"Going up empty-handed is a bad idea. ";
	    else if (not a.isCarrying(thelamp))
		"Aren't you forgetting something? ";
	    else {
		trapdoor.touched := nil;
		return( kitchen );
	    }
	    return( nil );
	}
	return( kitchen );
    }
;

gallery: room		// 105
    sdesc = "Gallery"
    ldesc = "This is an art gallery.  Most of the paintings which were here
	    have been stolen by vandals with exceptional taste.  The vandals
	    left through the north, south, or west exits. "
    
    // --Exits
    north(a) = westChasm
    south(a) = studio
    west(a) = bankEntry
;

painting: treasure,burnable	//  60
    sdesc =
    {
	if (trophyscore > 0)
	    "painting";
	else
	    "worthless piece of canvas";
    }
    noun = 'painting' 'art' 'canvas' 'picture' 'work' 'masterpiece'
    heredesc =
    {
	if (trophyscore > 0)
	    "A masterpiece by a neglected genius is here.";
	else
	    "There is a worthless piece of canvas here. ";
    }
    origdesc = "Fortunately, there is still one chance for you to be a vandal,
	     for on the far wall is a work of unparalleled beauty."
    location = gallery
    findscore = 4
    trophyscore = 7
    bulk = 15

    doBreak( a ) =
    {
	"Congratulations!  Unlike the other vandals, who merely stole the
	artist's masterpieces, you have destroyed one. ";
	findscore := 0;
	trophyscore := 0;
	touched := true;
    }
;

/**
 ** Misc stuff south of reservoir (Loud room and vicinity, etc.)
 **/

ewPassage: darkroom		//   1
    sdesc = "East-West Passage"
    ldesc = "This is a narrow east-west passageway.  There is a narrow
	    staircase leading down at the north end of the room. "
    scoreval = 5
    
    // --Exits
    east(a) = roundRoom
    west(a) = trollrm
    down(a) = ravine
    north(a) = ravine
;

ravine: darkroom		//  37
    sdesc = "Deep Ravine"
    ldesc = "This is a deep ravine at a crossing with an east-west crawlway.
	    Some stone steps are at the south of the ravine, and a steep
	    staircase descends. "
    // --Exits
    
    south(a) = ewPassage
    down(a) = reservoirSouth
    east(a) = chasm
    west(a) = rockyCrawl
;

rockyCrawl: darkroom	//  38
    sdesc = "Rocky Crawl"
    ldesc = "This is a crawlway with a three foot high ceiling.  Your footing
	    is very unsure here due to the assortment of rocks underfoot.
	    Passages can be seen in the east, west, and northwest corners of
	    the crawlway. "
    
    // --Exits
    west(a) = ravine
    east(a) = domeRoom
    nw(a) = egyptian
;

LOUD: darkroom		//  49
    sdesc = "Loud Room"
    ldesc = "This is a large room with a ceiling which cannot be detected from
	    the ground.  There is a narrow passage from east to west and a
	    stone stairway leading upward.  The room is extremely noisy.  In
	    fact, it is difficult to hear yourself think. "

    enterRoom( a ) =
    {
	inherited.enterRoom( a );
	if (not (self.fixed or a.isdead)) {
	    self.echoing := true;
	    notify(self, &checkleave, 0);
	}
    }
    checkleave =
    {
	/* Can't use leaveRoom, because if we die and are moved
	 * to Hades (if option set); then leaveRoom isn't called - sigh.
	 */
	if (Me.location <> self or Me.isdead or self.fixed) {
	    self.echoing := nil;
	    self.saveline := nil;
	    unnotify(self, &checkleave);
	}
    }
    
    roomCheck( v ) =
    {
	/* also, allow BUG/FEATURE if implemented */
	if (self.echoing and not v.isTravelVerb and v <> lookVerb) {
	    self.doecho;
	    return( nil );
	} else
	    pass roomCheck;
    }

    echoing = nil
    fixed = nil
    saveline = nil
    
    doinput( line ) =
    {
	line := upper(line);
	if (line = 'ECHO') {
	    fixed := true;
	    echoing := nil;
	    saveline := nil;
	    "ECHO\nThe acoustics of the room change subtly. ";
	    platinum.sacred := nil;  /* can be stolen now */
	    return( nil );
	} else {
	    self.saveline := line;
	    return( true );
	}
    }
    doecho =
    {
	if (self.saveline) {
	    say( self.saveline ); "\n";
	}
	self.saveline := nil;
    }
    
    // --Exits
    east(a) = ancientChasm
    west(a) = nsPass
    up(a) = dampCave
;

platinum: treasure	//  26
    sdesc = "platinum bar"
    noun = 'bar' 'platinum'
    adjective = 'large' 'platinum'
    heredesc = "There is a large platinum bar here."
    location = LOUD
    findscore = 12
    trophyscore = 10
    bulk = 20
    sacred = true		/* don't have thief steal, bypassing puzzle */
;

nsPass: darkroom		//  84
    sdesc = "North-South Passage"
    ldesc =
	"This is a high north-south passage, which forks to the northeast. "
    
    // --Exits
    north(a) = chasm
    ne(a) = LOUD
    south(a) = roundRoom
;

chasm: darkroom		//  85
    sdesc = "Chasm"
    ldesc = "A chasm runs southwest to northeast.  You are on the south edge.
	    The path exits to the south and to the east. "
    
    // --Exits
    south(a) = ravine
    east(a) = nsPass
    down(a) = { "Are you out of your mind?"; return( nil ); }
;

dampCave: darkroom		//  86
    sdesc = "Damp Cave"
    ldesc = "This is a cave.  Passages exit to the south and to the east, but
	    the cave narrows to a crack to the west.  The earth is particularly
	    damp here. "
    // --Exits
    south(a) = LOUD
    east(a) = damRoom
    west(a) =
    {
	"It is too narrow even for most insects.";
	return( nil );
    }
;

ancientChasm: darkroom	//  87
    sdesc = "Ancient Chasm"
    ldesc = "A chasm, evidently produced by an ancient river, runs through the
	    cave here.  Passages lead off in all directions. "
    // --Exits
    south(a) = LOUD
    east(a) = smallCave
    north(a) = dead6
    west(a) = dead7
;

dead6: deadend		//  88
    sw(a) = ancientChasm
;

dead7: deadend		//  89
    east(a) = ancientChasm
;

/**
 ** North of reservoir
 **/

atlantis: darkroom		//  47
    sdesc = "Atlantis Room"
    ldesc = "This is an ancient room, long underwater.
	    There are exits here to the southeast and upward. "

    // --Exits
    se(a) = reservoirNorth
    up(a) = cave1
;

/* can this be a weapon? */
trident: treasure		//  32
    sdesc = "crystal trident"
    noun = 'trident' 'fork'
    adjective = 'crystal'
    heredesc = "Poseiden's own crystal trident is here."
    origdesc = "On the shore lies Poseiden's own crystal trident."
    location = atlantis
    findscore = 4
    trophyscore = 11
    bulk = 20
;

mirrorRoom1: darkroom	//  50
    sdesc = "Mirror Room"
    ldesc = {
	"This is a large square room with tall ceilings.  On the south wall
	is an enormous mirror which fills the entire wall.  There are exits
	on the other three sides of the room. ";
	if (mirror1.broken)
	    "Unfortunately, you have managed to destroy it by your reckless
	    actions. ";
    }
    // --Exits
    west(a) = coldPassage
    north(a) = steepCrawl
    east(a) = cave1
;

mirror1: mirror		//  28
    location = mirrorRoom1
    othermirror = mirror2
;

cave1: darkroom		//  52
    sdesc = "Cave"
    ldesc = "This is a small cave with an entrance to the north and a stairway
	    leading down. "
    // --Exits
    north(a) = mirrorRoom1
    down(a) = atlantis
;

steepCrawl: darkroom	//  54
    sdesc = "Steep Crawlway"
    ldesc = "This is a steep and narrow crawlway.  There are two exits nearby
	    to the south and southwest. "
    // --Exits
    south(a) = mirrorRoom1
    sw(a) = coldPassage
;

coldPassage: darkroom	//  56
    sdesc = "Cold Passage"
    ldesc = "This is a cold and damp corridor where a long east-west passageway
	    intersects with a northward path. "
    // --Exits
    east(a) = mirrorRoom1
    west(a) = slideRoom
    north(a) = steepCrawl
;
