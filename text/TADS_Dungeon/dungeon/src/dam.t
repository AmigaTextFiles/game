/* Dam and reservoir */

reservoirSouth: darkroom	//  39
    sdesc = "Reservoir South"
    ldesc = {
	if (reservoir.lowtide)
	    "This is a long room, to the north of which was formerly a
	    reservoir.   However, with the water level lowered, there is
	    merely a wide stream running through the center of the room. ";
	else
	    "This is a long room on the south shore of a large reservoir. ";
	"There is a western exit, a passageway south, and a steep pathway
	climbing up along the edge of a cliff. ";
    }

    canfill = true

    // --Exits
    launch(a) = reservoir
    north(a) =
    {
	if (a and not reservoir.lowtide) {
	    "You are not equipped for swimming. ";
	    return( nil );
	}
	return( reservoir );
    }
    cross(a) = ( self.north(a) )
    west(a) = streamView
    south(a) =
    {
	if (a and coffin.isIn(a)) {
	    "The coffin will not fit through this passage. ";
	    return( nil );
	}
	return( ravine );
    }
    up(a) =
    {
	if (a and coffin.isIn(a)) {
	    "The stairs are too steep for carrying the coffin. ";
	    return( nil );
	}
	return( canyon );
    }
;

reservoir: darkroom		//  40
    sdesc = "Reservoir"
    ldesc = {
	if (self.lowtide)
	    "You are on what used to be a large reservoir, but which is now a
	    large mud pile.  There are \"shores\" to the north and south. ";
	else
	    "You are on the reservoir.  Beaches can be seen north and south.
	    Upstream a small stream enters the reservoir through a narrow
	    cleft in the rocks.  The dam can be seen downstream. ";
    }
    iswater = ( not self.lowtide )
    canfill = true
    nowalls = true

    lowtide = nil

    submerged = [trunk]		/* items hidden underwater */
    empty =
    {
	local cur;
	"The sluice gates open, and water pours through the dam. ";
	reservoir.lowtide := true;
	self.isseen := nil;
	coffin.sacred := nil;  /* why? */
	while( cur := car(submerged) ) {
	    cur.moveInto(self);
	    submerged := cdr(submerged);
	}
    }
    fill =
    {
	"The sluice gates close, and water starts to collect behind the dam. ";
	reservoir.lowtide := nil;
	/* hide everything under water */
	submerged := contents;
	while( car(contents) <> nil ) {
	    car(contents).moveInto(nil);
	}
    }
    
    // --Exits
    north(a) = reservoirNorth
    south(a) = reservoirSouth
    up(a) = stream
    down(a) = { "The dam blocks your way. "; return( nil ); }
    land(a) =
    {
	"You must specify which direction here. ";
	return( nil );
    }
;

trunk: treasure		//  45
    sdesc = "trunk with jewels"
    noun = 'trunk' 'chest'
    adjective = 'old'
    heredesc = "There is an old trunk here, bulging with assorted jewels."
    origdesc = "Lying half buried in the mud is an old trunk, bulging with
	       jewels."
    /* location = reservoir   not here initially */
    findscore = 15
    trophyscore = 8
    bulk = 35
;

reservoirNorth: darkroom	//  41
    sdesc = "Reservoir North"
    ldesc = {
	if (reservoir.lowtide)
	    "This is a large cavernous room, to the south of which was formerly
	    a reservoir.  However, with the water level lowered, there is
	    merely a wide stream running through the center of the room. ";
	else
	    "This is a large cavernous room, north of a large reservoir. ";
	"There is a tunnel leaving the room to the north. ";
    }
    canfill = true

    // --Exits
    north(a) = atlantis
    launch(a) = reservoir
    south(a) =
    {
	if (a and not reservoir.lowtide) {
	    "You are not equipped for swimming. ";
	    return( nil );
	}
	return( reservoir );
    }
    cross(a) = ( self.south(a) )
;

pump: item		//  89
    sdesc = "hand-held air pump"
    noun = 'pump' 'airpump' 'air-pump'
    adjective = 'small' 'hand-held'
    heredesc = "There is a small pump here."
    location = reservoirNorth
    bulk = 5
    istool = true

    verIoInflateWith( a ) = { }
    ioInflateWith( a, dobj ) = ( dobj.doInflateWith( a, self ) )
;

streamView: darkroom	//  42
    sdesc = "Stream View"
    ldesc = "You are standing on a path beside a gently flowing stream.
	    The path travels to the north and the east. "
    canfill = true

    // --Exits
    launch(a) = stream
    east(a) = reservoirSouth
    north(a) = glacierRoom
;

fuse: burnable		// 110
    sdesc = "wire coil"
    noun = 'coil' 'wire' 'fuse'
    adjective = 'shiny' 'thin'
    heredesc = "There is a coil of thin shiny wire here."
    location = streamView
    bulk = 1

    doBurnWith( actor, io ) =
    {
	"The wire starts to burn. ";
	notify(self, &ignite, 2);
    }
    verDoTurnon( a ) = { }
    doTurnon( a ) = { askio( withPrep ); }
    
    ignite =
    {
	if (self.location <> brick) {
	    if (self.isVisible(Me))
		"The wire rapidly burns into nothingness. ";
	    self.moveInto(nil);
	    return;
	}
	self.moveInto(nil);
	brick.explode;
    }
;

stream: darkroom		//  43
    sdesc = "Stream"
    ldesc = "You are on the gently flowing stream.  The upstream route is too
	    narrow to navigate, and the downstream route is invisible due to
	    twisting walls.  There is a narrow beach to land on. "
    iswater = true
    nowalls = true

    // --Exits
    land(a) = streamView
    down(a) = reservoir
    up(a) = { "The way is too narrow. "; return( nil ); }
;

canyon: darkroom		//  48
    sdesc = "Deep Canyon"
    ldesc = "You are on the south edge of a deep canyon.  Passages lead off
	    to the east, south, and northwest.  You can hear the sound of
	    flowing water below. "
    // --Exits
    nw(a) = reservoirSouth
    east(a) = damRoom
    south(a) = roundRoom
;

damRoom: room		//  98
    sdesc = "Dam"
    ldesc = {
	"You are standing on the top of Flood Control Dam #3, which was
	quite a tourist attraction in times far distant.  There are paths
	to the north, south, east, and down. ";
	if (reservoir.lowtide)
	    "It appears that the dam has been opened, since the water level
	    behind the dam is low and the sluice gate is open.  Water is
	    rushing downstream through the gates. ";
	else
	    "The sluice gates on the dam are closed.  Behind the dam, there can
	    be seen a wide lake.  A small stream is formed by the runoff from
	    the lake. ";
	"There is a control panel here.  There is a large metal bolt on the
	panel.  Above the bolt is a small green plastic bubble. ";
	if (bolt.canturn)
	    "The green bubble is glowing. ";
    }
    canfill = true

    // --Exits
    south(a) = canyon
    down(a) = damBase
    east(a) = dampCave
    north(a) = damLobby
;

controlpanel: fixeditem	// 194
    sdesc = "control panel"
    noun = 'panel'
    adjective = 'control'
    location = damRoom
;

bolt: fixeditem	//  64
    sdesc = "bolt"
    noun = 'bolt' 'nut'
    adjective = 'metal'
    location = damRoom

    canturn = nil

    verDoTurn( actor ) = { askio( withPrep ); }
    verDoTurnWith( actor, io ) = { }
    doTurnWith( actor, io ) =
    {
	if (io <> wrench)
	    "The bolt can't be turned with %your% <<io.sdesc>>. ";
	else if (not canturn)
	    "The bolt won't turn with %your% best effort. ";
	else if (reservoir.lowtide) {
	    reservoir.fill;
	} else {
	    reservoir.empty;
	}
    }
    
    doOilWith( a, io ) =
    {
	if (io = gunk)
	    "Hmm.  It appears that the tube contained glue, not oil.
	    Turning the bolt won't get any easier... ";
	else
	    pass doOilWith;
    }
;

dam: fixeditem		//  74
    sdesc = "dam"
    noun = 'rail' 'railing' 'button' 'dam' 'gates' 'gate' 'fcd'
    location = damRoom
;

bubble: fixeditem		//  77
    sdesc = "green bubble"
    ldesc = { if (bolt.canturn) "It is glowing. "; else pass ldesc; }
    noun = 'bubble'
    adjective = 'green' 'plastic'
    location = damRoom
;

damLobby: room		//  99
    sdesc = "Dam Lobby"
    ldesc = "This room appears to have been the waiting room for groups touring
	    the dam.  There are exits here to the north and east marked
	    \"Private\", though the doors are open, and an exit to the south. "
    // --Exits
    south(a) = damRoom
    north(a) = maintRoom
    east(a) = maintRoom
;

guidebook: readable,burnable	//  49
    sdesc = "tour guidebook"
    noun = 'book' 'guidebook' 'guide'
    adjective = 'tour'
    heredesc = "There is a tour guidebook here."
    origdesc = "A guidebook entitled \"Flood Control Dam #3\" is on the
	       reception desk."
    ldesc =
	"\t\t\t\ \ Guide Book To\n
	\t\t\ \ \ Flood Control Dam #3
	\b\t
	Flood control dam #3 (FCD #3) was constructed in year 783 of the
	Great Underground Empire to harness the destructive power of the
	Frigid River.  This work was supported by a grant of 37 million
	zorkmids from the central bureaucracy and your own omnipotent local
	tyrant Lord Dimwit Flathead the Excessive.  This impressive structure
	is composed of 3.7 cubic feet of concrete, is 256 feet tall at the
	center, and 193 feet wide at the top.  The reservoir created behind
	the dam has a volume of 37 billion cubic feet, an area of 12 million
	square feet, and a shore line of 36 thousand feet.
	\b\t
	The construction of FCD #3 took 112 days from ground breaking to
	the dedication.  It required a work force of 384 slaves, 34 slave
	drivers, 12 engineers, 2 turtle doves, and a partridge in a pear
	tree.  The work was managed by a command team composed of 234
	bureaucrats, 2347 secretaries (at least two of whom could type),
	12,256 paper shufflers, 52,469 rubber stampers, 245,193 red tape
	processors, and nearly one million dead trees.
	\b\t
	We will now point out some of the more interesting features of
	FCD #3 as we conduct you on a guided tour of the facilities.
	\b\t
	1)\tYou start your tour here in the dam lobby.\n
	\t\tYou will notice on your right that ...........\n"
    location = damLobby
    bulk = 5
;

matches: lamp,burnable,readable		//  51
    sdesc = "matchbook"
    noun = 'matchbook' 'match' 'matches' 'flint'
    heredesc = "There is a matchbook whose cover says
	       \"Visit Beautiful FCD #3\" here."
    ldesc =
	"\t\t[Close cover before striking BKD]
	\b
	\tYou too can make BIG MONEY in the exciting field of\n
	\t\t\t\t\ \ PAPER SHUFFLING!
	\b
	Mr.\ TAA of Muddle, Mass. says:  \"Before I took this course I used
	to be a lowly bit twiddler.  Now with what I learned at MIT Tech
	I feel really important and can obfuscate and confuse with the best.\"
	\b
	Mr.\ MARC had this to say:  \"Ten short days ago all I could look
	forward to was a dead-end job as a engineer.  Now I have a promising
	future and make really big Zorkmids.\"
	\b
	MIT Tech can't promise these fantastic results to everyone, but when
	you earn your MDL degree from MIT Tech your future will be brighter.
	\b
	\t\tSend for our free brochure today!\n"
    location = damLobby
    bulk = 2

    nummatches = 4
    verDoTurnon( actor ) =
    {
	if (self.nummatches <= 0)
	    "I'm afraid you have run out of matches. ";
	/* don't call lamp's verDoTurnon! */
    }
    doTurnon( actor ) =
    {
	self.nummatches--;
	self.turnsleft := 2;  /* reset each time */
	pass doTurnon;
    }
    onMessage = "One of the matches starts to burn. "
    offMessage = "The match is out. "
    burnoutMessage = "The match has gone out. "
;

maintRoom: darkroom		// 100
    sdesc = "Maintenance Room"
    ldesc = "This is what appears to have been the maintenance room for Flood
	    Control Dam #3, judging by the assortment of tool chests around the
	    room.  Apparently, this room has been ransacked recently, for most
	    of the valuable equipment is gone.  On the wall in front of you is
	    a panel of buttons, which are labeled in EBCDIC.  However, they
	    are of different colors:  blue, yellow, brown, and red.  The doors
	    to this room are in the west and south ends. "
    
    // --Exits
    south(a) = damLobby
    west(a) = damLobby
;

tube: openable		//  54
    sdesc = "tube"
    noun = 'tube' 'toothpaste'
    heredesc = "There is an object which looks like a tube of toothpaste here."
    ldesc = "---> Frobozz Magic Gunk Company <---\n
	    \t\t\ All Purpose Gunk\n"
    location = maintRoom
    bulk = 10
    maxbulk = 7
    isopen = nil

    verIoPutIn( actor ) = "The tube refuses to accept anything. "
    verDoSqueeze( actor ) = {}
    doSqueeze( actor ) =
    {
	if (not self.isopen)
	    "The tube is closed. ";
	else if (gunk.isIn(self)) {
	    gunk.moveInto(actor);
	    "The viscous material oozes into %your% hand. ";
	} else
	    "The tube is apparently empty. ";
    }
;

gunk: item		//  55
    sdesc = "viscous material"
    noun = 'gunk' 'putty' 'material' 'glue'
    adjective = 'viscous'
    heredesc = "There is some gunk here."
    location = tube
    bulk = 6
    istool = true

    verIoOilWith( a ) = { }
    ioOilWith( a, dobj ) = ( dobj.doOilWith( a, self ) )

    verIoCleanWith( a ) = { }
;

wrench: item		//  56
    sdesc = "wrench"
    noun = 'wrench'
    heredesc = "There is a wrench here."
    location = maintRoom
    bulk = 10
    istool = true
;

screwdriver: item	//  57
    sdesc = "screwdriver"
    noun = 'screwdriver'
    heredesc = "There is a screwdriver here."
    location = maintRoom
    bulk = 5
    istool = true
;

leak: fixeditem		//  78
    sdesc = "leak"
    noun = 'leak' 'drip' 'hole'
    /* location = maintRoom    not here initially */
    bulk = 5

    level = 0
    showmunged = "The room is full of water and cannot be entered. "
    drip =			/* ok, it's more than a mere drip... */
    {
	if (Me.isIn(maintRoom)) {
	    switch(level/2) {
	    case 0: "The water level is now up to your ankles. "; break;
	    case 1: "The water level is now up to your shins. "; break;
	    case 2: "The water level is now up to your knees. "; break;
	    case 3: "The water level is now up to your hips. "; break;
	    case 4: "The water level is now up to your waist. "; break;
	    case 5: "The water level is now up to your chest. "; break;
	    case 6: "The water level is now up to your neck. "; break;
	    case 7: "The water level is now up to your head. "; break;
	    case 8: "The water level is now high in your lungs. "; break;
	    }
	}
	level++;
	if (level > 16) {
	    unnotify(self, &drip); /* full, so turn off */
	    maintRoom.munged := self;
	    if (Me.isIn(maintRoom)) {
		"\nI'm afraid you have done drowned yourself. ";
		Me.died;
	    }
	}
    }

    verDoPlugWith( a, io ) = { }
    doPlugWith( a, io ) =
    {
	if (io <> gunk)
	    "With <<io.adesc>>? ";
	else {
	    level := -1;
	    unnotify(self, &drip);
	    "By some miracle of elven technology, you have managed to
	    stop the leak in the dam. ";
	}
    }
;

redbutton: buttonitem	//  79
    sdesc = "red button"
    noun = 'switch' 'button'
    adjective = 'red'
    location = maintRoom
    bulk = 5

    doPush( a ) =
    {
	maintRoom.lightsOn := not maintRoom.lightsOn;
	if (maintRoom.lightsOn)
	    "The lights within the room come on.\n";
	else {
	    "The lights within the room shut off.\n";
	    if (not maintRoom.islit)
		"It is now pitch black. ";
	}
    }
;

yellowbutton: buttonitem	//  80
    sdesc = "yellow button"
    noun = 'switch' 'button'
    adjective = 'yellow'
    location = maintRoom
    bulk = 5

    doPush( a ) =
    {
	bolt.canturn := true;
	"Click. ";
    }
;

brownbutton: buttonitem	//  81
    sdesc = "brown button"
    noun = 'switch' 'button'
    adjective = 'brown'
    location = maintRoom
    bulk = 5

    doPush( a ) =
    {
	bolt.canturn := nil;
	"Click. ";
    }
;

bluebutton: buttonitem	//  82
    sdesc = "blue button"
    noun = 'switch' 'button'
    adjective = 'blue'
    location = maintRoom
    bulk = 5

    doPush( a ) =
    {
	if (leak.level = 0) {
	    "There is a rumbling sound, and a stream of water appears to burst
	    from the east wall of the room (apparently, a leak has occurred
	    in a pipe). ";
	    leak.moveInto(maintRoom);
	    notify(leak, &drip, 0);
	    maintRoom.canfill := true;
	} else {
	    "The blue button appears to be jammed. ";
	}
    }
;

toolchests: fixeditem	// 193
    sdesc = "group of tool chests"
    noun = 'chest'
    adjective = 'tool'
    ldesc = "The chests are all empty. "
    location = maintRoom
    bulk = 5
    verDoTake( a ) = "The chests are all fastened to the wall. "
;
