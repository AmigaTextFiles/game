/* temple, hades, and surrounding environs */

mirrorRoom2: room	//  51
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
    west(a) = windingPassage
    north(a) = narrowCrawl
    east(a) = cave2
;

mirror2: mirror		//  29
    location = mirrorRoom2
    othermirror = mirror1
;

cave2: darkroom		//  53
    sdesc = "Cave"
    ldesc = "This is a tiny cave with entrances west and north, and a dark,
	    forbidding staircase leading down. "

    enterRoom( a ) =
    {
	inherited.enterRoom( a );
	if (a.isCarrying(candles) and candles.islit and prob(50,50)) {
	    "The cave is very windy at the moment, and your candles have
	    blown out.\n";
	    candles.turnoff(a);
	}
    }
    
    // --Exits
    north(a) = narrowCrawl
    west(a) = mirrorRoom2
    down(a) = hades
;

narrowCrawl: darkroom	//  55
    sdesc = "Narrow Crawlway"
    ldesc = "This is a narrow crawlway.  The crawlway leads from north to
	    south.  However, the south passage divides to the south and
	    southwest. "
    // --Exits
    south(a) = cave2
    sw(a) = mirrorRoom2
    north(a) = grailRoom
;

windingPassage: darkroom	//  57
    sdesc = "Winding Passage"
    ldesc = "This is a winding passage.  It seems that there is only an exit
	    on the east end, although the whirring from the round room can be
	    heard faintly to the north. "
    // --Exits
    east(a) = mirrorRoom2
    north(a) =
    {
	"You hear the whir from the round room but can find no entrance. ";
	return( nil );
    }
;

hades: room		//  93
    sdesc = "Entrance to Hades"
    ldesc = {
	"You are outside a large gateway, on which is inscribed:
	\b
	\t\"Abandon every hope, all ye who enter here.\"
	\b
	The gate is open.  Through it you can see a desolation, with a pile of
	mangled corpses in one corner.  Thousands of voices, lamenting some
	hideous fate, can be heard. ";
	if (not self.exorcised)
	    "\nThe way through the gate is barred by evil spirits, who jeer at
	    your attempts to pass.\n";
    }

    exorcised = nil
    done_bell = nil
    done_candles = nil

    ring_bell =
    {
	if (exorcised)
	    return;
	done_bell := true;
	"\nThe bell suddenly becomes white hot and falls to the ground.
	The wraiths, as though paralyzed, stop their jeering and
	slowly turn to face you.  On their ashen faces, the expression
	of a long-forgotten terror takes shape. ";
	bell.moveInto(nil);
	hotbell.moveInto(hades);
	setit(hotbell);
	if (Me.isCarrying(candles) and candles.islit) {
	    "\nIn your confusion, the candles drop to the ground and go out. ";
	    candles.turnoff(Me);
	    candles.moveInto(hades);
	}
	notify(self, &breakspell, 6);
	notify(self, &coolbell, 20);
    }
    light_candles =
    {
	if (not done_bell)
	    return;
	done_candles := true;
	"\nThe flames flicker wildly and appear to dance.  The earth beneath
	your feet trembles, and your legs nearly buckle beneath you.  The
	spirits cower at your unearthly power. ";
	unnotify(self, &breakspell);
	notify(self, &breakspell, 3);
    }
    read_book =
    {
	if (not done_candles)
	    return;
	exorcised := true;
	done_bell := done_candles := nil;
	unnotify(self, &breakspell);
	ghosts.moveInto(nil);
	"\bEach word of the prayer reverberates through the hall in a deafening
	confusion.  As the last word fades, a voice, loud and commanding,
	speaks:  \"Begone, fiends!\"  The spirits, sensing the presence
	of a greater power, flee through the walls. ";
    }
    
    breakspell =
    {
	if (not exorcised and Me.isIn(self))
	    "The tension of your ceremony is broken, and the wraiths, amused
	    but shaken at your clumsy attempt, resume their hideous jeering. ";
	done_bell := nil;
	done_candles := nil;
    }
    
    coolbell =
    {
	if (hotbell.location = self) {
	    bell.moveInto(self);
	    hotbell.moveInto(nil);
	    if (Me.isIn(self))
		"The bell appears to have cooled down. ";
	}
    }
    
    // --Exits
    up(a) = cave2
    east(a) =
    {
	if (a and not self.exorcised) {
	    "Some invisible force prevents you from passing through the
	    gate.\n";
	    return( nil );
	}
	return( landDead );
    }
    in(a) = ( self.east(a) )
;

ghosts: fixeditem		//  42
    sdesc = "number of ghosts"
    noun = 'ghost' 'spirit' 'fiend'
    plural = 'ghosts' 'spirits' 'fiends'
    location = hades
    victim = true

    verDoExorcise( a ) =
    {
	if (not (bell.location = a and book.location = a and
		 candles.location = a and candles.islit))
	    "You are not equipped for an exorcism. ";
	else
	    "You must perform the ceremony. ";
    }

    verDoAttackWith( a, io ) =
	"How can you affect a spirit with material objects? "
    ioSynonym('AttackWith') = 'BreakWith'
    verIoThrowAt( a ) = ( self.verDoAttackWith( a, self ) )
    verDoInspect( a ) = { pass verDoInspect; }	/* override dobjGen */
    dobjGen( a, v, i, p ) =
    {
	"You seem unable to affect these spirits. ";
	exit;
    }
    iobjGen( a, v, d, p ) = ( self.dobjGen( a, v, d, p ) )
;

corpses: fixeditem	//  72
    sdesc = "pile of corpses"
    noun = 'pile' 'corpse'
    adjective = 'mangled'
    location = hades
;

damnedgate: fixeditem	//  76
    sdesc = "gate"
    noun = 'gates' 'gate' 'switch'
    location = hades
;

landDead: room		//  94
    sdesc = "Land of the Living Dead"
    ldesc = {
	"You have entered the land of the living dead, a large desolate room.
	Although it is apparently uninhabited, you can hear the sounds of
	thousands of lost souls weeping and moaning.  In the east corner are
	stacked the remains of dozens of previous adventurers who were less
	fortunate than yourself.  To the east is an ornate passage, apparently
	recently constructed.  A passage exits to the west. ";
	if (self.onpole)
	    "Amid the desolation, you spot what appears to be your head,
	    tastefully impaled on the end of a long pole. ";
    }
    scoreval = 30
    onpole = nil
    
    // --Exits
    east(a) = tomb
    out(a) = hades
    west(a) = hades
;

head: fixeditem		//  71
    sdesc = "head on a pole"
    noun = 'head'
    bulk = 5
;

bodies: fixeditem	//  73
    sdesc = "pile of bodies"
    noun = 'pile' 'body' 'corpse' 'bodies' 'remains'
    location = landDead
    bulk = 5

    doBreak( a ) =
    {
	if (landDead.onpole) {
	    "What, trying again? ";
	} else {
	    head.moveInto(landDead);
	    landDead.onpole := true;
	    "The voice of the guardian of the dungeon booms out from the
	    darkness, \"Your disrespect has cost you your life!\" and
	    places your head on a pole.\n";
	    Me.died;
	}
    }
    doBurnWith( a, io ) = ( self.doBreak( a ) )
;

grailRoom: darkroom		//  95
    sdesc = "Grail Room"
    ldesc = "You are standing in a small circular room with a pedestal.  A set
	    of stairs leads up, and passages leave to the east and west. "
    // --Exits
    west(a) = roundRoom
    east(a) = narrowCrawl
    up(a) = temple
;

grail: treasure,container		//  43
    sdesc = "grail"
    noun = 'grail'
    adjective = 'holy'
    heredesc = "There is an extremely valuable (perhaps original) grail here."
    location = grailRoom
    findscore = 2
    trophyscore = 5
    bulk = 10
    maxbulk = 5
;

temple: room		//  96
    sdesc = "Temple"
    ldesc = "This is the west end of a large temple.  On the south wall is an
	    ancient inscription, probably a prayer in a long-forgotten
	    language.  The north wall is solid granite.  The entrance at the
	    west end of the room is through huge marble pillars. "
    reachable = [granitewall]
    sacred = true

    /* catch magic word */
    roomAction( a, v, d, p, i ) =
    {
	if ( v = treasureVerb ) {
	    a.travelTo(treasureRoom);
	    exit;
	}
    }
    
    // --Exits
    west(a) = grailRoom
    east(a) = altar
;

prayer: readable,fixeditem		//  44
    noun = 'prayer' 'inscription'
    adjective = 'old' 'ancient'
    sdesc = "prayer"
    ldesc = "The prayer is inscribed in an ancient script which is hardly
	    remembered these days, much less understood.  What little of it
	    can be made out seems to be a diatribe against small insects,
	    absent-mindedness, and the picking up and dropping of small
	    objects.  The final verse seems to consign trespassers to the
	    land of the dead.  All evidence indicates that the beliefs of the
	    ancient Zorkers were obscure. "
    location = temple
    bulk = 5
    sacred = true
;

bell: item		//  46
    sdesc = "bell"
    noun = 'bell'
    adjective = 'brass' 'small'
    heredesc = "There is a small brass bell here."
    origdesc = "Lying in the corner of the room is a small brass bell."
    location = temple
    bulk = 5

    verDoRing( a ) = { }
    doRing( a ) =
    {
	"Ding, Dong. ";
	if (a = Me and Me.isCarrying(self) and Me.isIn(hades))
	    hades.ring_bell;
    }
    verDoRingWith( a, io ) = { }
    doRingWith( a, io ) = ( self.doRing( a ) )
;

hotbell: immobile		// 190
    sdesc = "red hot brass bell"
    noun = 'bell'
    adjective = 'hot' 'brass' 'red'
    heredesc = "On the ground is a red hot bell."
    bulk = 5

    verDoTake( a ) = "The bell is very hot and cannot be taken. "
    verDoRing( a ) = "The bell is too hot to reach. "
    verDoRingWith( a, io ) = { }
    doRingWith( a, io ) =
    {
	if (isclass(io, burnable)) {
	    io.doBurnWith( a, self );
	} else if (io = hands) {
	    "The bell is too hot to touch. ";
	} else {
	    "The heat from the bell is too intense. ";
	}
    }

    douse( a ) =
    {
	bell.moveInto(self.location);
	self.moveInto(nil);
	"The water cools the bell and is evaporated. ";
	unnotify(hades, &coolbell);
    }
;

altar: room		//  97
    sdesc = "Altar"
    ldesc = "This is the east end of a large temple.  In front of you is what
	    appears to be an altar. "
    sacred = true
    firstseen =
    {
	/* Candles initially lit, but no timer yet. */
	candles.turnon(nil);
    }

    roomAction( a, v, d, p, i ) =
    {
	if (v = prayVerb) {
	    a.travelTo(forest1);
	    exit;
	}
    }
    
    // --Exits
    west(a) = temple
;

book: readable,burnable		//  47
    sdesc = "book"
    noun = 'book' 'prayer' 'bible' 'goodbook'
    adjective = 'large' 'black'
    heredesc = "There is a large black book here."
    origdesc = "On the altar is a large black book, open to page 569."
    ldesc = "\t\t\tCommandment #12592\n
	    Oh ye who go about saying unto each other:  \"Hello sailor\":\n
	    Dost thou know the magnitude of thy sin before the gods?\n
	    Yea, verily, thou shalt be ground between two stones.\n
	    Shall the angry gods cast thy body into the whirlpool?\n
	    Surely, thy eye shall be put out with a sharp stick!\n
	    Even unto the ends of the earth shalt thou wander and\n
	    unto the land of the dead shalt thou be sent at last.\n
	    Surely thou shalt repent of thy cunning."
    location = altar
    bulk = 10

    verDoOpen( a ) = "The book is open to page 569. "
    verDoClose( a ) = "As hard as you try, the book cannot be closed. "
    doBurnWith( a, io ) =
    {
	self.moveInto(nil);
	"A booming voice says, \"Wrong, cretin!\", and %you% notice%s% that
	%you% %have% turned into a pile of dust. ";
	a.died;
    }

    doRead( a ) =
    {
	inherited.doRead(a);
	if (a = Me and Me.isCarrying(self) and Me.isIn(hades))
	    hades.read_book;
    }
;

candles: lamp,burnable	//  48
    sdesc = "pair of candles"
    noun = 'candles' 'pair'
    heredesc = "There are two candles here."
    origdesc =
	"On the two ends of the altar are <<islit ? "burning" : "">> candles."
    location = altar
    bulk = 10
    islit = true		/* initially on */

    turnsleft = [50 50 20 10 5]
    verDoTurnon( actor ) = { askio( withPrep ); }
    doSynonym('TurnonWith') = 'BurnWith'
    verDoTurnonWith( actor, io ) =
    {
	if (io = torch and self.islit)
	    "You realize just in time that the candles are already lit. ";
	else if (self.islit)
	    "The candles are already lit. ";
	else if (self.turnsleft = nil)
	    "Alas, there's not much left of the candles.  Certainly not enough
	    to burn.";
	else if (not io.hasflame)
	    "You have to light them with something that's burning, you know.";
    }
    /* called from the io, not the parser */
    doTurnonWith( actor, io ) =
    {
	if (io = torch) {
	    "The heat from the torch is so intense that the candles are
	    vaporized. ";
	    self.moveInto(nil);
	} else {
	    inherited.doTurnon( actor );
	    if (actor = Me and Me.isCarrying(self) and Me.isIn(hades))
		hades.light_candles;
	}
    }
    doSynonym('TurnonWith') = 'BurnWith'
    
    verDoTurnoff(actor) =
    {
	if (not self.islit)
	    "The candles are not lit. ";
    }
    dimming1 = "The candles grow short. "
    dimming2 = "The candles are very short. "
    offMessage = "The flame is extinguished. "
;

// perhaps an addition here
translators: darkroom	// 119
    sdesc = "Translator's Annex"
    ldesc = "This is the Translator's Annex to the Tomb of the Unknown
	    Implementor.  Incised in the wall is the the obscure slogan,
	    \"Muddle through with fort(ran)itude\".  There is an exit to the
	    north and, to the south, a wooden arch labeled \"Entrance To
	    MLO-6B\".\n"
    // --Exits
    north(a) = tomb
    south(a) = { "You are not wearing your badge."; return( nil ); }
;

tomb: darkroom		// 137
    sdesc = "Tomb of the Unknown Implementer"
    ldesc =
	"This is the Tomb of the Unknown Implementer.\n
	A hollow voice	says, \"That's not a bug, it's a feature!\"\n
	In the north wall of the room is the Crypt of the Implementers.  It
	is made of the finest marble and is apparently large enough for four
	headless corpses.  The crypt is <<cryptdoor.showstate>>.
	Above the entrance is the cryptic inscription:
	\b
 	\t\t\"Feel Free\".
	\b
	To the south is a small opening, apparently of recent origin. "
    reachable = [cryptdoor]
    
    // --Exits
    west(a) = landDead
    south(a) = translators
    north(a) = ( checkDoor(cryptdoor, crypt, a ) )
    in(a) = ( self.north(a) )
;

cryptdoor: floater,readable,door	// 119
    sdesc = "crypt door"
    noun = 'door' 'tomb' 'crypt' 'grave'
    adjective = 'marble'
    ldesc = "Here lie the implementers, whose heads were placed on poles by
	    the Keeper of the Dungeon for amazing untastefulness."

    verDoOpen( a ) =
    {
	if (not global.endgame)
	    "\^<<self.thedesc>> cannot be opened. ";
	else if (self.isopen)
	    "\^<<self.thedesc>> is already open. ";
    }
    verDoClose( a ) =
    {
	if (not self.isopen)
	    "\^<<self.thedesc>> is already closed. ";
    }
    doClose( a ) =
    {
	"The crypt is closed. ";
	self.isopen := nil;
	if (a.isIn(crypt))
	    notify(crypt, &startend2, 3);
    }
    openMessage( a ) =
	"The door of the crypt is extremely heavy, but it opens easily. "
    
    doBreak -> heads
    doKick -> heads
    verDoAttackWith( a, io ) = { }
    doAttackWith( a, io ) = ( heads.doBreak(a) )

    verIoPutUnder( a ) = "There is not enough room under this door. "
;

heads: immobile		// 120
    sdesc = "set of poled heads"
    noun = 'head' 'heads' 'poles' 'implementors' 'losers' 'pole'
    heredesc = "There are four heads here, mounted securely on poles."
    location = tomb
    sacred = true

    verDoHello( a ) =
	"The implementers are dead;  therefore, they do not respond. "

    doBreak( a ) =
    {
	"Although the implementers are gone, they foresaw that some cretin
	would tamper with their remains.  Therefore, they took steps to
	prevent this.\n";
	stealtreasures(a, 100, largecase);
	stealtreasures(a.location, 100, largecase);
	if (car(largecase.contents))
	    largecase.moveInto(livingrm);
	"Unfortunately, we've run out of poles.  Therefore, in punishment for
	your transgression, we shall deprive you of all your valuables, and
	of your life.\n";
	a.died;
    }
    doSynonym('Break') = 'Kick'
    
    verDoAttackWith( a, io ) = { }
    doAttackWith( a, io ) = ( self.doBreak(a) )
;

cokes: item		// 121
    sdesc = "bunch of Coke bottles"
    noun = 'bottles' 'cokes' 'bunch'
    adjective = 'coke' 'empty'
    heredesc =
	"Many empty Coke bottles are here.  Alas, they can't hold water."
    origdesc = "There is a large pile of empty Coke bottles here, evidently
	     produced by the implementers during their long struggle to win
	     totally."
    location = tomb
    bulk = 15

    doBreak( a ) =
    {
	"Congratulations!  %You've% managed to break all the bottles.
	Fortunately for %your% feet, they were made of magic glass and
	disappear immediately. ";
	self.moveInto(nil);
    }
    verDoThrowAt( a, io ) = { }
    doThrowAt( a, io ) = ( self.doBreak( a ) )
    doSynonym('ThrowAt') = 'ThrowTo'
;

printouts: readable,burnable	// 122
    sdesc = "stack of listings"
    noun = 'pile' 'paper' 'listings' 'stack' 'printout' 'print'
    adjective = 'enormous' 'gigantic' 'line-printer'
    heredesc = "There is an enormous stack of line-printer paper here.  It is
	     barely readable and totally unintelligible."
    origdesc = "There is a gigantic pile of line-printer output here.
	     Although the paper once contained useful information, almost
	     nothing can be distinguished now."
    ldesc = "<DEFINE FEEL-FREE (LOSER)\n
	    \t<TELL \"FEEL FREE, CHOMPER!\">\n
	    \t<MEMQ ......\n
	    The rest is, alas, unintelligible (as were the implementers)."
    location = tomb
    bulk = 70
;

largecase: immobile,transparentItem	// 123
    sdesc = "large case"
    noun = 'case'
    adjective = 'large'
    heredesc = "There is a large case here, containing objects which you used
	       to possess."
    maxbulk = 10000
;
