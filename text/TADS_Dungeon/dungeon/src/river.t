/* Notes:
 *   Should we have the rivers be dark rooms??
 */
damBase: room		// 106
    sdesc = "Dam Base"
    ldesc = "This is the base of Flood Control Dam #3, which looms above you
	    and to the north.   The Frigid River is flowing by here.  Across
	    the river are the White Cliffs, which seem to form a giant wall
	    stretching from north to south along the east shore of the river
	    as it winds its way downstream. "
    sacred = true
    canfill = true
    nowalls = true
    reachable = [dummycliff]

    // --Exits
    north(a) = damRoom
    up(a) = damRoom
    launch(a) = river1
;

boat1: burnable		//  87
    sdesc = "plastic inflatable boat"
    noun = 'pile' 'boat' 'plastic'
    adjective = 'plastic'
    heredesc = "There is a folded pile of plastic here which has a small
	       valve attached."
    location = damBase
    bulk = 20

    intact = true
    
    verDoInflateWith( a, io ) = { }
    doInflateWith( a, io ) =
    {
	if (self.location and self.location.location <> nil) {
	    "The boat must be on the ground to be inflated. ";
	} else {
	    magicboat.moveInto(self.location);
	    self.moveInto(nil);
	    "The boat inflates and appears seaworthy. ";
	    setit(magicboat);
	}
    }
;

boat2: burnable		//  88
    sdesc = "holed plastic boat"
    noun = 'pile' 'boat' 'plastic'
    adjective = 'plastic'
    heredesc = "There is a pile of plastic here with a large hole in it."
    bulk = 20

    verDoInflateWith( a, io ) =
	"This boat will not inflate since some moron put a hole in it. "

    verDoPlugWith( a, io ) = { }
    doPlugWith( a, io ) =
    {
	if (io <> gunk)
	    "With <<io.adesc>>? ";
	else {
	    "Well done.  The boat is repaired. ";
	    boat1.moveInto(self.location);
	    self.moveInto(nil);
	    setit(boat1);
	}
    }
;

magicboat: transport,burnable,container	//  90
    sdesc = "magic boat"
    noun = 'boat' 'plastic'
    adjective = 'magic' 'seaworthy' 'plastic'
    heredesc = "There is an inflated boat here."
    bulk = 20
    maxbulk = 100
    
    // what happens if you burn it while inside?

    validdest( dest ) =
    {
	/* allow going from water to land */
	return( dest.iswater or self.location.iswater );
    }
    
    doBoard( a ) =
    {
	if (stick.location = a) {
	    boat2.moveInto(self.location);
	    self.moveInto(nil);
	    "There is a hissing sound, and the boat deflates. ";
	} else
	    pass doBoard;
    }

    verDoDeflate( a ) = { }
    doDeflate( a ) =
    {
	if (a.isIn(self))
	    "%You% can't deflate the boat while %you're% in it. ";
	else {
	    boat1.moveInto(self.location);
	    self.moveInto(nil);
	    "The boat deflates. ";
	    setit(boat1);
	}
    }
    
    verDoInflateWith( a, io ) =
	"Inflating it further would probably burst it. "
    verIoPourIn( a ) = { }	/* override iobjGen */
    verIoPutIn( a ) = { }
;

tanlabel: readable,burnable	//  91
    sdesc = "tan label"
    noun = 'label' 'fineprint' 'print'
    adjective = 'tan' 'fine'
    heredesc = "There is a tan label here."
    ldesc =
	"\t!!!! FROBOZZ MAGIC BOAT COMPANY !!!!
	\b
	Hello, sailor!
	\b
	Instructions for use:
	\b
	\t   To get into the boat, say 'BOARD'\n
	\t   To leave the boat, say 'DISEMBARK'\n
	\t   To get into a body of water, say 'LAUNCH'\n
	\t   To get to shore, say 'LAND'
	\b
	Warranty:
	\b\t
	This boat is guaranteed against all defects in parts and
	workmanship for a period of 76 milliseconds from date of purchase
	or until first used, whichever comes first.
	\b
	Warning:  This boat is made of plastic.
	\b
	Good luck!\n"
    location = magicboat
    bulk = 2
;

stick: item		//  92
    sdesc = "broken sharp stick"
    noun = 'stick'
    adjective = 'broken' 'sharp'
    heredesc = "There is a sharp broken stick here."
    origdesc = "A sharp stick, which appears to have been broken at one end,
	       is here."
    location = damBase
    bulk = 3

    verDoWave( a ) = { }
    doWave( a ) =
    {
	if (a.isIn(rainbowRoom)) {
	    rainbowRoom.solid := nil;
	    "The structural integrity of the rainbow seems to have declined
	    precipitously, leaving %you% about 450 feet in the air, supported
	    by water vapor. ";
	    a.died;
	} else if (a.isIn(rainbowEnd) or a.isIn(falls)) {
	    if (potofgold.location = nil and not potofgold.touched)
		potofgold.moveInto(rainbowEnd);
	    rainbowRoom.solid := not rainbowRoom.solid;
	    if (rainbowRoom.solid)
		"Suddenly, the rainbow appears to become solid and,
		I venture, walkable (I think the giveaway was the stairs
		and banister). ";
	    else
		"The rainbow seems to have become somewhat run of the mill. ";
	} else
	    "Very good. ";
    }
;

river1: darkroom		// 107
    sdesc = "Frigid River"
    ldesc = "You are on the Frigid River in the vicinity of the dam.  The river
	    flows quietly here.  There is a landing on the west shore. "
    iswater = true
    sacred = true
    nowalls = true

    // --Exits
    west(a) = damBase
    land(a) = damBase
    down(a) = river2
    up(a) =
    {
	"You cannot go upstream due to the strong currents.";
	return( nil );
    }
    east(a) =
    {
	"The White Cliffs prevent you from landing here.";
	return( nil );
    }
;

river2: darkroom		// 108
    sdesc = "Frigid River"
    ldesc = "The river turns a corner here making it impossible to see the
	    dam.  The White Cliffs loom on the east bank, and large rocks
	    prevent landing on the west. "
    reachable = [dummycliff]
    sacred = true
    iswater = true
    nowalls = true

    // --Exits
    down(a) = river3
    up(a) =
    {
	"You cannot go upstream due to the strong currents.";
	return( nil );
    }
    east(a) =
    {
	"The White Cliffs prevent you from landing here.";
	return( nil );
    }
;

river3: darkroom		// 109
    sdesc = "Frigid River"
    ldesc = "The river descends here into a valley.  There is a narrow beach
	    on the east below the cliffs, and there is some shore on the west
	    which may be suitable.  In the distance a faint rumbling can be
	    heard. "
    reachable = [dummycliff]
    sacred = true
    iswater = true
    nowalls = true

    // --Exits
    down(a) = river4
    east(a) = beach1
    west(a) = rockyShore
    up(a) =
    {
	"You cannot go upstream due to the strong currents.";
	return( nil );
    }
    land(a) =
    {
	"You must specify which direction here.";
	return( nil );
    }
;

beach1: darkroom		// 110
    sdesc = "White Cliffs Beach"
    ldesc = "This is a narrow strip of beach which runs along the base of the
	    White Cliffs.  The only path here is a narrow one, heading south
	    along the cliffs. "
    reachable = [whitecliff]
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    launch(a) = river3
    south(a) =
    {
	if (a and magicboat.isIn(a)) {
	    "The path is too narrow. ";
	    return( nil );
	}
	return( beach2 );
    }
;

beach2: darkroom		// 111
    sdesc = "White Cliffs Beach"
    ldesc = "This is a rocky, narrow strip of beach beside the cliffs.  A
	    narrow path leads north along the shore. "

    reachable = [whitecliff]
    sacred = true
    canfill = true
    nowalls = true

    enterRoom( a ) =
    {
	if (not buoy.hinted and buoy.location = a)
	    buoy.hint;
	pass enterRoom;
    }
    
    // --Exits
    launch(a) = river4
    north(a) =
    {
	if (a and magicboat.isIn(a)) {
	    "The path is too narrow. ";
	    return( nil );
	}
	return( beach1 );
    }
;

whitecliff: floater,climbable	// 147
    sdesc = "white cliff"
    noun = 'cliff'
    adjective = 'white'

    verDoClimb( actor ) = "The cliff is too steep for climbing. "
    verDoClimbdown( actor ) = ( self.verDoClimb( actor ) )

    isReachable( a ) =
    {
	/* We can be reached from inside magic boat */
	if (find( a.location.location.reachable, self ) <> nil )
	    return( true );
	pass isReachable;
    }
;

dummycliff: whitecliff	// just to be able to refer to in some places
    noun = 'cliff'
    adjective = 'white'
    verDoClimb( actor ) = "The cliffs are too far away. "
;

river4: darkroom		// 112
    sdesc = "Frigid River"
    ldesc = "The river is running faster here, and the sound ahead appears to
	    be that of rushing water.  On the west shore is a sandy beach.
	    A small area of beach can also be seen below the cliffs. "
    enterRoom( a ) =
    {
	if (not buoy.hinted and buoy.location = a)
	    buoy.hint;
	pass enterRoom;
    }
    sacred = true
    iswater = true
    nowalls = true
    reachable = [dummycliff]

    // --Exits
    down(a) = river5
    east(a) = beach2
    west(a) = sandyBeach
    land(a) =
    {
	"You must specify which direction here.";
	return( nil );
    }
    up(a) =
    {
	"You cannot go upstream due to the strong currents.";
	return( nil );
    }
;

buoy: openable		//  94
    sdesc = "red buoy"
    ldesc =
    {
	if (not isopen)
	    "It's reddish. ";	/* so we don't make it obviously openable */
	else
	    pass ldesc;
    }
    noun = 'buoy'
    adjective = 'red'
    heredesc = "There is a red buoy here (probably a warning)."
    location = river4
    bulk = 10
    maxbulk = 20
    isopen = nil

    hinted = nil
    hint =
    {
	hinted := true;
	"Something seems funny about the feel of the buoy.\n";	
    }
    
    isReachable( a ) =
    {
	/* We can be reached from inside vehicles (ie, magic boat) */
	if (a.isIn(self.location))
	    return( true );
	pass isReachable;
    }
;

emerald: treasure		//  95
    sdesc = "large emerald"
    noun = 'emerald'
    adjective = 'large'
    heredesc = "There is a large emerald here."
    location = buoy
    findscore = 5
    trophyscore = 10
    bulk = 5
;

river5: darkroom		// 113
    sdesc = "Frigid River"
    ldesc = "The sound of rushing water is nearly unbearable here.  On the west
	    shore is a large landing area. "
    sacred = true
    iswater = true
    nowalls = true

    // --Exits
    down(a) = mobyLossage
    west(a) = shore
    land(a) = shore
    up(a) =
    {
	"You cannot go upstream due to the strong currents.";
	return( nil );
    }
;

mobyLossage: darkroom	// 114
    sdesc = "Moby Lossage"
    sacred = true
    enterRoom( a ) =
    {
	"Unfortunately, a rubber raft doesn't provide much protection from
	the unfriendly sorts of rocks and boulders one meets at the bottom
	of many waterfalls.  Including this one. ";
	a.died;
    }
;

shore: darkroom		// 115
    sdesc = "Shore"
    ldesc = "This is the shore of the river.  The river here seems somewhat
	    treacherous.  A path travels from north to south here, the south
	    end quickly turning around a sharp corner. "
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    launch(a) = river5
    north(a) = sandyBeach
    south(a) = falls
;

sandyBeach: darkroom	// 116
    sdesc = "Sandy Beach"
    ldesc = "This is a large sandy beach at the shore of the river, which is
	    flowing quickly by.  A path runs beside the river to the south
	    here. "
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    launch(a) = river4
    south(a) = shore
;

statue: treasure		//  86
    sdesc = "statue"
    noun = 'statue' 'sculpture' 'rock'
    adjective = 'beautiful'
    heredesc = "There is a beautiful statue here."
    /* location = sandyBeach   not here initially */
    findscore = 10
    trophyscore = 13
    bulk = 8
;

beach: fixeditem		// 192
    sdesc = "sandy beach"
    noun = 'sand' 'beach'
    adjective = 'sandy'
    location = sandyBeach
    bulk = 5

    dug = 0			/* how much digging has been done */
    verDoDigWith( a, io ) = { }
    doDigWith( a, io ) =
    {
	dug++;
	switch(dug) {
	case 1: "You seem to be digging a hole here. "; break;
	case 2: "The hole is getting deeper, but that's about it. "; break;
	case 3: "You are surrounded by a wall of sand on all sides. "; break;
	case 4:
		if (statue.location = nil) {
		    statue.moveInto(sandyBeach);
		    "You can see a small statue in the sand. ";
		}
		break;
	case 5:
		/* oops */
		dug := 0;
		if (statue.location = sandyBeach)
		    statue.moveInto(nil);
		"The wall collapses, smothering you. ";
		a.died;
		break;
	}
    }
;

rockyShore: darkroom	// 117
    sdesc = "Rocky Shore"
    ldesc = "This is the west shore of the river.  An entrance to a cave is
	    to the northwest.  The shore is very rocky here. "
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    launch(a) = river3
    nw(a) = smallCave
;

smallCave: darkroom		// 118
    sdesc = "Small Cave"
    ldesc = "This is a small cave whose exits are on the south and northwest. "
    
    // --Exits
    south(a) = rockyShore
    nw(a) = ancientChasm
;

shovel: item		//  96
    sdesc = "shovel"
    noun = 'shovel'
    adjective = 'large'
    heredesc = "There is a large shovel here."
    location = smallCave
    bulk = 15
    istool = true

    verIoDigWith( a ) = { }
    ioDigWith( a, dobj ) = ( dobj.doDigWith( a, self ) )
;

guano: item		//  97
    sdesc = "hunk of bat guano"
    noun = 'guano' 'crap' 'shit' 'hunk'
    heredesc = "There is a hunk of bat guano here."
    location = smallCave
    bulk = 20

    cnt = 0
    verDoDigWith( a, io ) = { }
    doDigWith( a, io ) =
    {
	switch(cnt++) {
	case 0: "You are digging into a pile of bat guano. "; break;
	case 1: "You seem to be getting knee deep in guano. "; break;
	case 2: "You are covered with bat turds, cretin. "; break;
	default: "This is getting you nowhere. "; break;
	}
    }
;

falls: darkroom		// 120
    sdesc = "Aragain Falls"
    ldesc =
    {
	"You are at the top of Aragain Falls, an enormous waterfall with a
	drop of about 450 feet.  The only path here is on the north end. ";
	if (rainbowRoom.solid)
	    "A solid rainbow spans the falls. ";
	else
	    "A beautiful rainbow can be seen over the falls and to the east. ";
    }
    reachable = [rainbow]
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    down(a) = { "It's a long way..."; return( nil ); }
    north(a) = shore
    east(a) =
    {
	if (not rainbowRoom.solid)
	    return( self.noexit(a) );
	else
	    return( rainbowRoom );
    }
    up(a) = ( self.east(a) )
;

barrel: immobile,vehicle,burnable	//  93
    sdesc = "wooden barrel"
    noun = 'barrel'
    adjective = 'wooden' 'man-size'
    heredesc = "There is a man-sized barrel here, which you might be able to
	       enter."
    ldesc =
    {
	/* cheat and assume only Me can get inside */
	if (Me.isIn(self))
	    "You are inside a barrel.  Congratulations.  Etched into the side
	    of the barrel is the word \"Geronimo!\".  From your position, you
	    cannot see the falls. ";
	else
	    pass ldesc;
    }
    location = falls
    bulk = 70
    maxbulk = 100

    roomAction( a, v, d, p, i ) =
    {
	if (v = travelVerb) {
	    "You cannot move the barrel. ";
	    exit;
	} else if (v = geronimoVerb) {
	    "I didn't think you would REALLY try to go over the falls in a
	    barrel.  It seems that some 450 feet below, you were met by a
	    number of unfriendly rocks and boulders, causing your immediate
	    demise.  Is this what \"Over a barrel\" means? ";
	    a.died;
	}
    }

    /* don't do normal nested room look around */
    lookAround(verbosity) =
    {
	self.statusLine;
	self.nrmLkAround(verbosity);
    }

    verDoBurnWith( a, io ) = "The barrel is damp and cannot be burned. "
;

rainbowRoom: room	// 121
    sdesc = "Rainbow Room"
    ldesc = "You are on top of a rainbow (I bet you never thought you would
	    walk on a rainbow), with a magnificent view of the falls.  The
	    rainbow travels east-west here. "
    sacred = true
    nowalls = true

    solid = nil
    
    // --Exits
    east(a) = rainbowEnd
    west(a) = falls
;

rainbow: floater, climbable	//  84
    sdesc = "rainbow"
    noun = 'rainbow'
;

rainbowEnd: room	// 122
    sdesc = "End of rainbow"
    ldesc = "You are on a small beach on the continuation of the Frigid River
	    past the falls.  The beach is narrow due to the presence of the
	    White Cliffs.  The river canyon opens here, and sunlight shines in
	    from above.  A rainbow crosses over the falls to the west, and a
	    narrow path continues to the southeast. "
    reachable = [rainbow dummycliff]
    canfill = true
    nowalls = true

    // --Exits
    se(a) = canyonBot
    west(a) =
    {
	if (not rainbowRoom.solid)
	    return( self.noexit(a) );
	else
	    return( rainbowRoom );
    }
    northwest(a) = ( self.west(a) )
    up(a) = ( self.west(a) )
;

potofgold: treasure	//  85
    sdesc = "pot of gold"
    noun = 'pot' 'gold'
    adjective = 'gold'
    heredesc = "There is a pot of gold here."
    origdesc = "At the end of the rainbow is a pot of gold."
    /* location = rainbowEnd   not here initially */
    findscore = 10
    trophyscore = 10
    bulk = 15
;

canyonBot: room		// 123
    sdesc = "Canyon Bottom"
    ldesc = "You are beneath the walls of the river canyon, which may be
	    climbable here.  There is a small stream here, which is the lesser
	    part of the runoff of Aragain Falls.  To the north is a narrow
	    path. "
    reachable = [cliff]
    sacred = true
    canfill = true
    nowalls = true

    // --Exits
    north(a) = rainbowEnd
    up(a) = rockyLedge
;

rockyLedge: room	// 124
    sdesc = "Rocky Ledge"
    ldesc = "You are on a ledge about halfway up the wall of the river canyon.
	    You can see from here that the main flow from Aragain Falls twists
	    along a passage which it is impossible to enter.  Below you is the
	    canyon bottom.  Above you is more cliff, which still appears
	    climbable. "
    reachable = [cliff]
    sacred = true
    nowalls = true

    // --Exits
    up(a) = canyonView
    down(a) = canyonBot
;

canyonView: room	// 125
    sdesc = "Canyon View"
    ldesc = "You are at the top of the great canyon on its south wall. From
	    here there is a marvelous view of the canyon and parts of the
	    Frigid River upstream.  Across the canyon, the walls of the White
	    Cliffs still appear to loom far above.  Following the canyon
	    upstream (north and northwest), Aragain Falls may be seen,
	    complete with rainbow.  Fortunately, my vision is better than
	    average, and I can discern the top of Flood Control Dam #3 far to
	    the distant north.  To the west and south can be seen an immense
	    forest, stretching for miles around.  It is possible to climb down
	    into the canyon from here. "
    reachable = [cliff]
    sacred = true
    nowalls = true

    // --Exits
    down(a) = rockyLedge
    south(a) = forest4
    west(a) = forest5
;

cliff: floater,climbable		// 146
    sdesc = "cliff"
    noun = 'cliff' 'ledge' 'cliffs'
    adjective = 'rocky' 'sheer'
;
