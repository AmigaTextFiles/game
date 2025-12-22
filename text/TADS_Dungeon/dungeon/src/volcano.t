/* Volcano, glacier, egyptian rooms */

egyptian: darkroom		//  44
    sdesc = "Egyptian Room"
    ldesc = "This is a room which looks like an Egyptian tomb.  There is an
	    ascending staircase in the room as well as doors east and south. "
    // --Exits
    up(a) = glacierRoom
    south(a) = volcanoView
    east(a) =
    {
	if (a and coffin.isIn(a)) {
	    "The passage is too narrow to accomodate coffins. ";
	    return( nil );
	}
	return( rockyCrawl );
    }
;

coffin: treasure,openable		//  33
    sdesc = "gold coffin"
    noun = 'coffin' 'casket'
    adjective = 'gold'
    heredesc =
    {
	if (rope.tiedto = self)
	    "The coil of rope is tied to Ramses II's gold coffin.";
	else
	    "The solid gold coffin used for the burial of Ramses II is here.";
    }
    location = egyptian
    findscore = 3
    trophyscore = 7
    bulk = 55
    maxbulk = 35
    isopen = nil
    sacred = true

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

glacierRoom: darkroom	//  45
    sdesc = "Glacier Room"
    ldesc = {
	"This is a large room with giant icicles hanging from the walls
	and ceiling.  There are passages to the north and east. ";
	if (self.melted = 2)
	    "There is a large passageway leading westward. ";
	else if (self.melted = 1)
	    "Part of the glacier has been melted. ";
    }

    melted = 0			/* how much melting has been done */
    
    // --Exits
    north(a) = streamView
    east(a) = egyptian
    west(a) =
    {
	if (a and melted <> 2)
	    return( "%You% can't go that way. ", nil );
	return( rubyRoom );
    }
;

glacier: immobile		//  30
    sdesc = "glacier"
    noun = 'glacier' 'ice' 'mass'
    heredesc = "A mass of ice fills the western half of the room."
    location = glacierRoom

    verDoAttackWith(a,io) = { }
    doAttackWith(a,io) = "Nothing much happens. "

    ioThrowAt( a, dobj ) =
    {
	if (dobj <> torch)
	    "The glacier is unmoved by %your% ridiculous attempt. ";
	else {
	    "The torch hits the glacier and explodes into a great ball of
	    flame, devouring the glacier.  The water from the melting glacier
	    rushes downstream, carrying the torch with it.  In place of the
	    glacier, there is a passageway leading west.\n";
	    self.moveInto(nil);
	    glacierRoom.melted := 2;
	    torch.moveInto(streamView);
	    torch.islit := nil;	/* permanently out */
	    if (not glacierRoom.islit)
		"The melting glacier seems to have carried the torch away,
		leaving %you% in the dark.\n";
	}
    }

    verDoMeltWith( a, io ) = { }
    doMeltWith( a, io ) =
    {
	if (not io.hasflame)
	    "You won't melt it with <<io.adesc>>. ";
	else {
	    glacierRoom.melted := 1;
	    if (io = torch)
		torch.islit := nil;
	    "Part of the glacier melts, drowning %you% under a torrent
	    of water. ";
	    a.died;
	}
    }
;

rubyRoom: darkroom		//  46
    sdesc = "Ruby Room"
    ldesc = "This is a small chamber behind the remains of the great glacier.
	    To the south and west are small passageways. "
    // --Exits
    west(a) = lavaRoom
    south(a) = glacierRoom
;

ruby: treasure		//  31
    sdesc = "ruby"
    noun = 'ruby'
    adjective = 'moby'
    heredesc = "There is a moby ruby lying here."
    origdesc = "On the floor lies a moby ruby."
    location = rubyRoom
    findscore = 15
    trophyscore = 8
    bulk = 5
;

volcanoBot: darkroom	// 126
    sdesc = "Volcano Bottom"
    ldesc = "You are at the bottom of a large dormant volcano.  High above you
	    light may be seen entering from the cone of the volcano.  The only
	    exit here is to the north."

    uproom = volcano1
    upmessage1 = "The balloon rises slowly from the ground."
    upmessage2 = "You watch as the balloon slowly lifts off."
    downroom = nil
    
    // --Exits
    north(a) = lavaRoom
;

balloon: immobile,transport	//  98
    sdesc = "basket"
    noun = 'basket' 'balloon'
    adjective = 'wicker'
    ldesc = ( self.showstate )
    heredesc =
	"There is a very large and extremely heavy wicker basket with a
	cloth bag here.  Inside the basket is a metal receptacle of some
	kind.  Attached to the basket on the outside is a piece of wire.\n"
    lookAround( v ) = {
	inherited.lookAround(v);
	self.showstate;
    }
    showstate =
    {
	if (self.inflated)
	    "The cloth bag is inflated, and there is
	    <<self.fuel.adesc>> burning in the receptacle.\n";
	else
	    "The cloth bag is draped over the basket.\n";
	if (braidedwire.tiedto <> nil)
	    "The balloon is tied to the hook.\n";
    }
    location = volcanoBot
    reachable = ( [] + self + location ) /* can reach outside (the hooks) */
    maxbulk = 100
    
    fuel = nil
    inflated = (fuel <> nil)

    roomAction( a, v, d, p, i) =
    {
	if ((v = inspectVerb or v = readVerb) and d = fuel) {
	    "It is burning. ";
	    exit;
	}
    }

    moveInto( dest ) =
    {
	inherited.moveInto(dest);
	if (dest) {
	    unnotify(self, &float);
	    notify(self, &float, 3);
	}
    }
    
    validdest( dest ) =
    {
	/* allow going from air to land */
	return( dest.isair or self.location.isair );
    }

    noexit( a ) =
    {
	"I'm afraid you can't control the balloon in this way. ";
    }

    verDoLaunch( a ) =
    {
	if (braidedwire.tiedto <> nil)
	    "You are tied to the ledge. ";
	else
	    pass verDoLaunch;
    }
    
    viewable( a ) =
    {
	return( a.isIn(volcanoBot) or a.isIn(wideLedge) or a.isIn(narrowLedge)
	       or a.isIn(volcanoView) );
    }
    float =
    {
	local dest, oldloc;
	notify(self, &float, 3);
	if (inflated and receptacle.isopen) { /* ascend */
	    if (dest := location.uproom) {
		oldloc := location;
		self.moveInto(dest);
		if (Me.isIn(self)) {
		    oldloc.upmessage1; "\b";
		    dest.enterRoom( Me );
		} else if (self.viewable(Me)) {
		    oldloc.upmessage2; "\n";
		}
	    }
	} else {		/* descend */
	    if (dest := location.downroom) {
		oldloc := location;
		self.moveInto(dest);
		if (Me.isIn(self)) {
		    oldloc.downmessage1; "\b";
		    dest.enterRoom( Me );
		} else if (self.viewable(Me)) {
		    oldloc.downmessage2; "\n";
		}
	    }
	}
    }

    burn(ob) =
    {
	"\^<<ob.thedesc>> burns inside the receptacle. ";
	notify(self, &burnout, ob.bulk*20);
	ob.islit := true;
	if (fuel = nil) {	/* when wouldn't it be here? */
	    fuel := ob;
	    unnotify(self, &float);
	    notify(self, &float, 3);
	    if (bluelabel.location = nil and not bluelabel.touched)
		bluelabel.moveInto(self);
	    "The cloth bag inflates as it fills with hot air. ";
	}
    }

    burnout =
    {
	fuel.moveInto(nil);
	fuel := nil;
	if (Me.isIn(self))
	    "You notice that <<self.thedesc>> has burned out, and that
	    the cloth bag is starting to deflate.\n";
    }
;

receptacle: fixeditem,openable	//  99
    sdesc = "receptacle"
    noun = 'receptacle'
    adjective = 'metal'
    location = balloon
    maxbulk = 6
    isopen = nil
    // flags2 = searchable

    verGrab( ob ) =
    {
	if (ob = balloon.fuel)
	    "You don't really want to hold a burning <<ob.sdesc>>. ";
    }
    ioPutIn( actor, dobj ) =
    {
	if (car(contents))
	    "The receptacle is already occupied. ";
	else
	    pass ioPutIn;
    }

    douse( actor ) =
    {
	if (car(contents) and car(contents) = balloon.fuel)
	    "The water enters but cannot stop
	    <<car(contents).thedesc>> from burning. ";
	else
	    pass douse;
    }
;

clothbag: fixeditem	// 100
    sdesc = "cloth bag"
    noun = 'bag'
    adjective = 'cloth'
    location = balloon
;

braidedwire: fixeditem,tieable	// 101
    sdesc = "braided wire"
    noun = 'rope' 'wire'
    adjective = 'braided'
    location = balloon

    doTieTo( actor, io ) =
    {
	if (io = hook1 or io = hook2) {
	    unnotify(balloon, &float);
	    "The balloon is fastened to the hook. ";
	    self.tiedto := io;
	} else
	    "You can't tie <<io.thedesc>> to the hook. ";
    }

    doUntie( actor ) =
    {
	"The wire falls off the hook. ";
	self.tiedto := nil;
	notify(balloon, &float, 3);
    }
;

bluelabel: readable,burnable	// 112
    sdesc = "blue label"
    noun = 'label'
    adjective = 'blue'
    heredesc = "There is a blue label here."
    ldesc =
	"\t!!!! FROBOZZ MAGIC BALLOON COMPANY !!!!
	\b
	Hello, aviator!
	\b
	Instructions for use:
	\b
	\t   To get into the balloon, say 'BOARD'\n
	\t   To leave the balloon, say 'DISEMBARK'\n
	\t   To land, say 'LAND'
	\b
	Warranty:
	\b
	\t No warranty is expressed or implied.  You're on your own, sport.
	\b
	Good luck!"
    bulk = 1
;

brokenballoon: item	// 113
    sdesc = "broken balloon"
    noun = 'basket' 'balloon'
    adjective = 'broken'
    heredesc = "There is a balloon here, broken into pieces."
    bulk = 40
;

class volcanoroom: darkroom
    upmessage1 = "The balloon ascends."
    upmessage2 = "You watch as the balloon slowly ascends."
    downmessage1 = "The balloon descends."
    downmessage2 = "You watch as the balloon slowly descends."
;

volcano1: volcanoroom		// 127
    sdesc = "Volcano Core"
    ldesc = "You are about one hundred feet above the bottom of the volcano.
	    The top of the volcano is clearly visible here."
    sacred = true
    nowalls = true
    isair = true

    uproom = volcano2
    downroom =
    {
	if (Me.isIn(balloon) and not balloon.inflated) {
	    /* hard landing */
	    balloon.moveInto(nil);
	    brokenballoon.moveInto(volcanoBot);
	    Me.moveInto(volcanoBot);
	    "You have landed, but the balloon did not survive.\n";
	    unnotify(balloon, &float);
	    unnotify(balloon, &burnout);
	    return( nil );
	}
	return( volcanoBot );
    }
    downmessage1 = "The balloon has landed."
    downmessage2 = "You watch as the balloon slowly lands."
;

volcano2: volcanoroom		// 128
    sdesc = "Volcano near small ledge"
    ldesc = "You are about two hundred feet above the volcano floor.  Looming
	    above is the rim of the volcano.  There is a small ledge on the
	    west side."
    sacred = true
    nowalls = true
    isair = true

    uproom = volcano3
    downroom = volcano1
    
    // --Exits
    west(a) = narrowLedge
    land(a) = narrowLedge
;

volcano3: volcanoroom		// 129
    sdesc = "Volcano near viewing ledge"
    ldesc = "You are high above the floor of the volcano.  From here the rim of
	    the volcano looks very narrow, and you are very near it.  To the
	    east is what appears to be a viewing ledge, too thin to land on."
    sacred = true
    nowalls = true
    isair = true

    uproom = volcano4
    downroom = volcano2
;

volcano4: volcanoroom		// 130
    sdesc = "Volcano near wide ledge"
    ldesc = "You are near the rim of the volcano, which is only about fifteen
	    feet across.  To the west, there is a place to land with a wide
	    ledge."
    sacred = true
    nowalls = true
    isair = true

    uproom =
    {
	unnotify(balloon, &float);
	unnotify(balloon, &burnout);
	brokenballoon.moveInto(volcanoBot);
	balloon.moveInto(nil);
	if (Me.isIn(balloon)) {
	    "Your balloon has hit the rim of the volcano, ripping the
	    cloth and causing you to drop 500 feet.  Did you get your
	    flight insurance? ";
	    Me.moveInto(self);	/* prevent errors with statusLine */
	    Me.died;
	} else if (Me.isIn(volcanoBot)) {
	    "You watch the balloon explode after hitting the rim;
	    its tattered remains land on the ground by your feet. ";
	} else if (balloon.viewable(Me)) {
	    "You hear a boom and notice that the balloon is falling to
	    the ground. ";
	}
	return( nil );
    }
    downroom = volcano3
    
    // --Exits
    land(a) = wideLedge
    west(a) = wideLedge
;

narrowLedge: darkroom	// 131
    sdesc = "Narrow Ledge"
    ldesc = "You are on a narrow ledge overlooking the inside of an old dormant
	    volcano.  This ledge appears to be about in the middle between the
	    floor below and the rim above.  There is an exit here to the
	    south."

    uproom = {
	if (not Me.isIn(balloon))
	    notify(vgnome, &arrival, 10);
	return( self.launch(Me) );
    }
    upmessage1 = "The balloon leaves the ledge."
    upmessage2 = "You watch as the balloon slowly floats away.  It seems to be
		 ascending, due to its light load."
    downroom = ( self.uproom )
    downmessage1 = ( self.upmessage1 )
    downmessage2 = ( self.downmessage2 )
    
    // --Exits
    launch(a) = volcano2
    south(a) = library
    down(a) = { "I wouldn't jump from here."; return( nil ); }
    west(a) =
    {
	if (not vgnome.exitshown)
	    return( self.noexit(a) );
	else
	    return( volcanoBot );
    }
;

hook1: immobile		// 102
    sdesc = "hook"
    noun = 'hook'
    adjective = 'small'
    heredesc = "There is a small hook attached to the rock here."
    location = narrowLedge

    verIoTieTo( actor ) = { }
    ioTieTo( actor, dobj ) = ( dobj.doTieTo( actor, self ) )
;

zorkmid: treasure,readable		// 104
    sdesc = "priceless zorkmid"
    noun = 'zorkmid' 'coin' 'gold'
    adjective = 'gold' 'priceless'
    heredesc = "There is an engraved zorkmid coin here."
    origdesc = "On the floor is a gold zorkmid coin (a valuable collector's
	     item)."
    // YES, this is ugly...
    ldesc = "\n
\t\ \ \ \ \ \ \ --------------------------\n
\t\ \ \ \ \ \ / \ \ \ \ \ \ Gold Zorkmid \ \ \ \ \ \ \ \\\n
\t\ \ \ \ \ / \ T e n \ \ T h o u s a n d \ \ \ \\\n
\t\ \ \ \ / \ \ \ \ \ \ \ Z o r k m i d s \ \ \ \ \ \ \ \\\n
\t\ \ \ / \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \\\n
\t\ \ / \ \ \ \ \ \ \ |||||||||||||||||| \ \ \ \ \ \ \ \ \\\n
\t\ / \ \ \ \ \ \ \ !|||| \ \ \ \ \ \ \ \ \ ||||! \ \ \ \ \ \ \ \\\n
\t| \ \ \ \ \ \ \ \ \ ||| \ \ ^^ \ ^^ \ \ ||| \ \ \ \ \ \ \ \ \ \ |\n
\t| \ \ \ \ \ \ \ \ \ ||| \ \ OO \ OO \ \ ||| \ \ \ \ \ \ \ \ \ \ |\n
\t| In Frobs \ ||| \ \ \ \<< \ \ \ ||| \ We Trust \ |\n
\t| \ \ \ \ \ \ \ \ \ \ \ || (______) || \ \ \ \ \ \ \ \ \ \ \ \ |\n
\t| \ \ \ \ \ \ \ \ \ \ \ \ | \ \ \ \ \ \ \ \ \ | \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
\t| \ \ \ \ \ \ \ \ \ \ \ \ |__________| \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
\t\ \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ /\n
\t\ \ \\ \ \ \ \ -- Lord Dimwit Flathead -- \ \ \ /\n
\t\ \ \ \\ \ \ \ \ -- Beloved of Zorkers -- \ \ \ /\n
\t\ \ \ \ \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ /\n
\t\ \ \ \ \ \\ \ \ \ \ \ \ * 722 G.U.E.\ * \ \ \ \ \ \ \ /\n
\t\ \ \ \ \ \ \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ /\n
\t\ \ \ \ \ \ \ \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ /\n
\t\ \ \ \ \ \ \ \ \ -----------------------"
    location = narrowLedge
    findscore = 10
    trophyscore = 12
    bulk = 10
;

volcanoView: darkroom	// 132
    sdesc = "Volcano View"
    ldesc = "This is a ledge in the middle of a large volcano.  Below you the
	    volcano bottom can be seen and above is the rim of the volcano.
	    A couple of ledges can be seen on the other side of the volcano;
	    it appears that this ledge is intermediate in elevation between
	    those on the other side.  The exit from this room is to the east."
    
    // --Exits
    east(a) = egyptian
    down(a) = { "I wouldn't try that."; return( nil ); }
    cross(a) =
    {
	"It is impossible to cross this distance.";
	return( nil );
    }
;

wideLedge: darkroom		// 133
    sdesc = "Wide Ledge"
    ldesc =
    {
	"You are on a wide ledge high into the volcano.  The rim of the
	volcano is about 200 feet above, and there is a precipitous drop
	below to the floor. ";
	if (dustyRoom.munged = nil)
	    "There is a small door to the south. ";
	else
	    "The way to the south is blocked by rubble. ";
    }

    showmunged = "The ledge has collapsed and cannot be landed on.\n"
    collapse =
    {
	self.munged := self;
	if (Me.isIn(self)) {
	    if (not Me.isIn(balloon)) {
		"The force of the explosion has caused the ledge to collapse
		belatedly. ";
		Me.died;
	    } else if (braidedwire.tiedto <> nil) {
		balloon.moveInto(nil);
		Me.moveInto(volcanoBot);
		unnotify(balloon, &float);
		unnotify(balloon, &burnout);
		brokenballoon.moveInto(volcanoBot);
		braidedwire.tiedto := nil;
		"The ledge collapses, probably as a result of the explosion.
		A large chunk of it, which is attached to the hook, drags you
		down to the ground.  Fatally. ";
		Me.died;
	    } else {
		"The ledge collapses, leaving you with no place to land. ";
	    }
	} else {
	    "The ledge collapses, giving you a narrow escape.\n";
	}
    }

    uproom = {
	if (not Me.isIn(balloon))
	    notify(vgnome, &arrival, 10);
	return( self.launch(Me) );
    }
    upmessage1 = "The balloon leaves the ledge."
    upmessage2 = "You watch as the balloon slowly floats away.  It seems to be
		 ascending, due to its light load."
    downroom = ( self.uproom )
    downmessage1 = ( self.upmessage1 )
    downmessage2 = ( self.downmessage2 )
    
    // --Exits
    launch(a) = volcano4
    south(a) = dustyRoom
    down(a) = { "It's a long way down."; return( nil ); }
    west(a) =
    {
	if (not vgnome.exitshown)
	    return( self.noexit(a) );
	else
	    return( volcanoBot );
    }
;

hook2: immobile		// 103
    sdesc = "hook"
    noun = 'hook'
    adjective = 'small'
    heredesc = "There is a small hook attached to the rock here."
    location = wideLedge

    verIoTieTo( actor ) = { }
    ioTieTo( actor, dobj ) = ( dobj.doTieTo( actor, self ) )
;

library: darkroom		// 134
    sdesc = "Library"
    ldesc = "This is a room which must have been a large library, probably
	    for the royal family.  All of the shelves appear to have been
	    gnawed to pieces by unfriendly gnomes.  To the north is an exit."
    // --Exits
    north(a) = narrowLedge
    out(a) = narrowLedge
;

class libBook: readable,openable
    noun = 'book'
    ldesc = "This book is written in a tongue with which I am unfamiliar."
    location = library
    bulk = 10
    maxbulk = 2
    isopen = nil
;

bluebook: libBook	// 114
    sdesc = "blue book"
    noun = 'book'
    adjective = 'blue'
    heredesc = "There is a blue book here."
;

greenbook: libBook	// 115
    sdesc = "green book"
    noun = 'book'
    adjective = 'green'
    heredesc = "There is a green book here."
;

purplebook: libBook	// 116
    sdesc = "purple book"
    noun = 'book'
    adjective = 'purple'
    heredesc = "There is a purple book here."
;

whitebook: libBook	// 117
    sdesc = "white book"
    noun = 'book'
    adjective = 'white'
    heredesc = "There is a white book here."
;

stamp1: treasure,readable,burnable		// 118
    sdesc = "stamp"
    noun = 'stamp'
    adjective = 'flathead'
    heredesc = "There is a Flathead stamp here."
    ldesc = "\b
---V----V----V----V----V----V----V----V---\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ |||||||||| \ \ \ \ \ \ \ LORD \ \ \ \ \ \ \ |\n
> \ \ \ \ \ \ \ \ !|||| \ \ \ \ \ | \ \ \ \ \ DIMWIT \ \ \ \ \ \ <\n
| \ \ \ \ \ \ \ \ |||| \ \ \ ---| \ \ \ \ FLATHEAD \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ |||C \ \ \ \ CC \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
> \ \ \ \ \ \ \ \ \ |||| \ \ \ \ \ \ _\\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <\n
| \ \ \ \ \ \ \ \ \ \ ||| (____| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ || \ \ \ \ \ | \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
> \ \ \ \ \ \ \ \ \ \ \ \ |______| \ \ \ \ \ \ Our \ \ \ \ \ \ \ \ <\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ / \ \ \\ \ \ \ \ Excessive \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ / \ \ \ \ \\ \ \ \ \ \ Leader \ \ \ \ \ \ |\n
> \ \ \ \ \ \ \ \ \ \ \ \ | \ \ \ \ \ \ | \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <\n
| \ \ \ \ \ \ \ \ \ \ \ \ | \ \ \ \ \ \ | \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
> \ \ \ G.U.E.\ POSTAGE \ \ \ \ \ \ \ 3 Zorkmids \ \ \ <\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
---^----^----^----^----^----^----^----^---"
    location = purplebook
    findscore = 4
    trophyscore = 10
    bulk = 1
;

dustyRoom: room		// 135
    sdesc = "Dusty Room"
    ldesc =
    {
	"This is a dusty old room which is virtually featureless, except
	for an exit on the north side. ";
	if (safe.isopen)
	    "On the far wall is a rusty box, whose door has been blown off. ";
	else
	    "Embedded in the far wall is a rusty old box.  It appears that
	    the box is somewhat damaged, since an oblong hole has been
	    chipped out of the front of it. ";
    }

    // --Exits
    north(a) = wideLedge
;

safe: immobile,openable		// 105
    sdesc = "box"
    noun = 'safe' 'box'
    adjective = 'steel'
    location = dustyRoom
    bulk = 10000
    maxbulk = 15
    isopen = nil
    
    verDoTake( a ) = "The box is embedded in the wall. "
    verDoBlast( a ) = "What do you expect, BOOM? "
    
    /* The only way we open is by blasting */
    verDoOpen( a ) =
    {
	if (self.isopen)
	    "The box has no door! ";
	else
	    "The box is rusted and will not open. ";
    }
    verDoClose( a ) =
    {
	if (self.isopen)
	    "The box has no door! ";
	else
	    "The box is not open, chomper! ";
    }
;

card: readable,burnable		// 106
    sdesc = "card"
    noun = 'card' 'note'
    heredesc = "There is a card with writing on it here."
    ldesc = "Warning:\n
	    \tThis room was constructed over very weak rock strata.
	    Detonation of explosives in this room is strictly prohibited!\n
	    \t\t\t\t\t\t Frobozz Magic Safe Company\n
	    \t\t\t\t\t\t per M.\ Agrippa, foreman\n"
    location = safe
    bulk = 1
;

safeslot: fixeditem,container		// 107
    sdesc = "hole"
    noun = 'hole' 'slot'
    location = dustyRoom
    bulk = 10000
    maxbulk = 10
;

crown: treasure,clothingItem	// 108
    sdesc = "crown"
    noun = 'crown'
    adjective = 'gaudy'
    heredesc = "Lord Dimwit's crown is here."
    origdesc = "The excessively gaudy crown of Lord Dimwit Flathead is here."
    location = safe
    findscore = 15
    trophyscore = 10
    bulk = 10
;

lavaRoom: darkroom		// 136
    sdesc = "Lava Room"
    ldesc = "This is a small room, whose walls are formed by an old lava flow.
	    There are exits here to the west and the south."
    // --Exits
    south(a) = volcanoBot
    west(a) = rubyRoom
;

vgnome: Actor		// 111
    sdesc = "Volcano Gnome"
    noun = 'gnome'   /* 'troll' ?? */
    adjective = 'volcano'
    heredesc = "There is a nervous Volcano Gnome here."

    dobjGen(a, v, i, p) =
    {
	"The gnome appears increasingly nervous.\n";
	if (getfuse(self, &vanish) = nil)
	    notify(self, &vanish, 5);
    }
    iobjGen(a, v, d, p) = ( self.dobjGen(a, v, d, p) )

    ioGiveTo( a, dobj ) =
    {
	if (isclass(dobj, treasure)) {
	    "\"Thank you very much,\" he says.  \"I don't believe I've seen
	    <<dobj.adesc>> as beautiful.  Follow me.\"  A door appears on the
	    west end of the ledge.  Through the door, you can see a narrow
	    chimney sloping downward.  The gnome moves quickly, and he
	    disappears from sight.\n";
	    dobj.moveInto(nil);
	    self.moveInto(nil);
	    self.exitshown := true;
	    unnotify(self, &vanish);
	} else if (dobj = brick and brick.dangerous) {
	    "\"That certainly wasn't what I had in mind,\" he says,
	    and disappears.\n";
	    brick.moveInto(self.location);
	    self.moveInto(nil);
	    unnotify(self, &vanish);
	} else {
	    "\"That wasn't quite what I had in mind,\" he says, crunching
	    <<dobj.thedesc>> in his rock hard hands.\n";
	    dobj.moveInto(nil);
	}
    }
    ioSynonym('GiveTo') = 'ThrowTo'


    arrival =
    {
	if (Me.isIn(narrowLedge) or Me.isIn(wideLedge)) { /* on ledge? */
	    self.moveInto(toplocation(Me));
	    "\bA volcano gnome seems to walk straight out of the wall and says,
	    \"I have a very busy appointment schedule and little time to waste
	    on trespassers, but for a small fee, I'll show you the way out.\"
	    You notice that the gnome is nervously glancing at his watch.\n";
	} else {
	    /* keep trying until they get to ledge (or give up) */
	    notify(self, &arrival, 1);
	}
    }

    vanish =
    {
	if (Me.isIn(self.location))
	    "The gnome glances at his watch.  \"Oops!  I'm late for an
	    appointment.\"  He disappears, leaving you alone on the ledge.\n";
	self.moveInto(nil);
    }
;
