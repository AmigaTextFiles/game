/* The riddle room, well, Alice rooms */
/* (machine room in carousel.t) */

engrCave: darkroom		//  90
    sdesc = "Engravings Cave"
    ldesc = "You have entered a cave with passages leading north and
	    southeast."

    // --Exits
    north(a) = roundRoom
    se(a) = riddleRoom
;

engravings: readable,immobile	//  41
    sdesc = "wall with engravings"
    noun = 'engravings' 'inscriptions'
    adjective = 'old' 'ancient'
    heredesc = "There are old engravings on the walls here."
    ldesc = "The engravings were incised in the living rock of the cave wall
	    by an unknown hand.  They depict, in symbolic form, the beliefs
	    of the ancient peoples of Zork.  Skillfully interwoven with the
	    bas reliefs are excerpts illustrating the major tenets expounded
	    by the sacred texts of the religion of that time.  Unfortunately,
	    a later age seems to have considered them blasphemous and just
	    as skillfully excised them."
    location = engrCave
    sacred = true
;

riddleRoom: darkroom	//  91
    sdesc = "Riddle Room"
    ldesc = "This is a room which is bare on all sides.  There is an exit down.
	    To the east is a great door made of stone.  Above the door, the
	    following words are written:  \"No man shall enter this room
	    without solving this riddle--
	    \b
	    \tWhat is tall as a house,\n
	    \tRound as a cup,\n
	    \tAnd all the king's horses can't draw it up?\".\n
	    \b
	    (Reply via 'ANSWER \"answer\"'.)"

    answered = nil

    roomAction( a, v, d, p, i ) =
    {
	if (not answered and v = sayVerb and d = strObj
	    and upper(d.value) = 'WELL')
	{
	    "There is a clap of thunder, and the east door opens. ";
	    answered := true;
	    exit;
	}
    }
    
    // --Exits
    down(a) = engrCave
    east(a) =
    {
	if (a = nil or answered)
	    return( pearlRoom );
	else
	{
	    "Your way is blocked by an invisible force. ";
	    return( nil );
	}
    }
;

stonedoor: durableDoor	//  69
    sdesc = "stone door"
    noun = 'door'
    adjective = 'stone'
    location = riddleRoom
;

pearlRoom: darkroom		//  92
    sdesc = "Pearl Room"
    ldesc = "This is a former broom closet.  The exits are to the east and
	    west."
    
    // --Exits
    east(a) = circularRoom
    west(a) = riddleRoom
;

necklace: treasure,clothingItem	//  27
    sdesc = "pearl necklace"
    noun = 'necklace' 'pearls'
    adjective = 'pearl'
    heredesc = "There is a pearl necklace here with hundreds of large pearls."
    location = pearlRoom
    findscore = 9
    trophyscore = 5
    bulk = 10
;

wellTop: darkroom		// 142
    sdesc = "Top of Well"
    ldesc = "You are at the top of the well.  Well done.  There are etchings on
	    the side of the well.  There is a small crack across the floor at
	    the entrance to a room on the east, but it can be crossed easily."
    scoreval = 10
    reachable = [well]
    
    roomAction( a, v, d, p, i ) =
    {
	notify(bucket, &checkwater, 1);
    }

    // --Exits
    east(a) = teaRoom
    down(a) = { "It's a long way down."; return( nil ); }
;

circularRoom: darkroom	// 143
    sdesc = "Circular Room"
    ldesc = "This is a damp circular room, whose walls are made of brick and
	    mortar.  The roof of this room is not visible, but there appear to
	    be some etchings on the walls.  There is a passageway to the west."
    reachable = [well]
    
    roomAction( a, v, d, p, i ) =
    {
	notify(bucket, &checkwater, 1);
    }

    // --Exits
    west(a) = pearlRoom
    up(a) = { if (a) "The walls cannot be climbed."; return( nil ); }
;

etchings1: readable,fixeditem	// 130
    sdesc = "wall with etchings"
    noun = 'walls' 'wall' 'etchings'
    ldesc = "\n
	    \t\t\t\to \ b \ o\n
	    \b
	    \t\t\t\tA \ G \ I\n
	    \t\t\t\t\ E \ \ L
	    \b
	    \t\t\t\tm \ p \ a"
    location = circularRoom
;

etchings2: readable,fixeditem	// 131
    sdesc = "wall with etchings"
    noun = 'walls' 'wall' 'etchings'
    ldesc = "\n
	    \t\t\ \ \ \ \ \ \ \ o \ b \ o\n
	    \t\t\ \ \ \ r \ \ \ \ \ \ \ \ \ \ \ \ z\n
	    \t\t\ f \ \ M \ A \ G \ I \ C \ \ z\n
	    \t\t\ c \ \ \ W \ E \ \ L \ L \ \ \ y\n
	    \t\t\ \ \ \ o \ \ \ \ \ \ \ \ \ \ \ \ n\n
	    \t\t\ \ \ \ \ \ \ \ m \ p \ a"
    location = wellTop
;

bucket: immobile,vehicle,container	// 137
    sdesc = "wooden bucket"
    noun = 'bucket'
    adjective = 'wooden' 'wood'
    heredesc = "There is a wooden bucket here, three feet in diameter and three
	       feet high."
    location = circularRoom
    bulk = 100
    maxbulk = 100		/* just a guess */

    /* fixeditem overrode this, sigh */
    verDoEnter( a ) = ( self.verDoBoard( a ) )
    
    roomAction( a, v, d, p, i ) =
    {
	notify(self, &checkwater, 1);
    }

    checkwater =
    {
	if (somewater.location = self) {
	    if (location = circularRoom) {
		self.moveInto(wellTop);
		notify(self, &reset, 100);
		"\nThe bucket rises and comes to a stop.\n";
		if ( Me.isIn(self) ) {
		    "\b";
		    wellTop.enterRoom( Me );
		}
	    }
	} else {		/* no water */
	    if (location = wellTop) {
		self.moveInto(circularRoom);
		unnotify(self, &reset);
		"\nThe bucket descends and comes to a stop.\n";
		if ( Me.isIn(self) ) {
		    "\b";
		    circularRoom.enterRoom( Me );
		}
	    }
	}
    }

    reset =
    {
	if (somewater.location = self) {
	    somewater.moveInto(nil);  /* leaks out */
	    self.checkwater;
	}
    }
    
    verDoBurnWith( a, io ) = "The bucket is fireproof and won't burn. "
    verDoKick( a ) =
	"Amazingly, nothing fatal happened! "	/* I couldn't resist, DBJ */

    verIoPourIn( a ) = { }	/* override iobjGen */
    verIoPutIn( a ) = { }
;

well: floater		// 281
    sdesc = "well"
    noun = 'well'
    adjective = 'magic'

    verIoPutIn( a ) = { }
    ioPutIn( a, dobj ) =
    {
	dobj.moveInto(circularRoom);
	"\^<<dobj.thedesc>> is now sitting at the bottom of the well. ";
    }
;

teaRoom: darkroom		// 144
    sdesc = "Tea Room"
    ldesc = "This is a small square room, in the center of which is a large
	    oblong table, no doubt set for afternoon tea.  It is clear from the
	    objects on the table that the users were indeed mad.  In the
	    eastern corner of this room is a small hole no more than four
	    inches high.  There are passageways leading away to the west and
	    the northwest."

    enlarge =			/* shrink player */
    {
	local l, cur;
	"Suddenly, the room appears to have become very large.\n";
	l := self.contents;
	while ( cur := car(l) ) {
	    if (not cur.isfixed) {
		cur.moveInto(postsRoom);
		cur.bulk *= 64;	/* make it heavy */
	    }
	    l := cdr(l);
	}
	/* Fortran version didn't display change, so we don't either. */
	Me.moveInto(postsRoom);
    }
    shrink =			/* enlarge player */
    {
	/* already printed out first message */
	local l, cur;
	l := postsRoom.contents;
	while ( cur := car(l) ) {
	    if (not cur.isfixed) {
		cur.moveInto(teaRoom);
		cur.bulk /= 64;
		/* ok, really this should make some items completely
		 * useless if they weren't expanded to begin with
		 * (ie, an inch long knife), but the original didn't worry
		 * about it...
		 */
	    }
	    l := cdr(l);
	}
	/* Fortran version didn't display change, so we don't either. */
	Me.moveInto(teaRoom);
    }
    
    // --Exits
    west(a) = wellTop
    nw(a) = lowRoom
    east(a) = { "Only a mouse could get in there."; return( nil ); }
;

largetable: fixeditem,surface	// 135
    sdesc = "large oblong table"
    noun = 'table'
    adjective = 'large' 'oblong'
    location = teaRoom
;

class icing: readable
    readdesc =
	"The only writing visible is a capital E.  The rest is too small to
	be clearly visible. "

    doReadThru( actor, io ) = ( self.doLookThru( actor, io ) )
    doLookThru( actor, io ) =
    {
	if (io = bottle) {
	    "The letters appear larger but are still too small to read. ";
	} else if (io = flask) {
	    self.magnified;
	} else {
	    self.doInspect(actor);
	}
    }
;

cake1: fooditem, readable		// 138
    sdesc = "piece of \"Eat-Me\" cake"
    noun = 'cake'
    adjective = 'eat-me' 'eatme'
    heredesc = "There is a piece of cake here with the words \"Eat-Me\" on it."
    location = teaRoom
    bulk = 10

    readdesc = "\"Eat-Me\""

    doEat( a ) =
    {
	if (a.isIn(teaRoom)) {
	    self.moveInto(nil);
	    teaRoom.enlarge;
	} else
	    pass doEat;
    }
;

cake2: fooditem, icing		// 139
    sdesc = "piece of cake with orange icing"
    noun = 'cake' 'icing'
    adjective = 'orange'
    heredesc = "There is a piece of cake with orange icing here."
    location = teaRoom
    bulk = 4

    magnified = "The icing, now visible, says \"Explode\". "

    showmunged =
	"The door to the room seems to be blocked by sticky orange rubble
	from an explosion.  Probably some careless adventurer was playing
	with blasting cakes. "
    explode(a) =
    {
	toplocation(a).munged := self;
	"%You% %have% been blasted to smithereens (whatever they are). ";
	a.died;
    }
    inalice(a) =
    {
	return (a.isIn(teaRoom) or a.isIn(postsRoom) or a.isIn(poolRoom));
    }
    doEat( a ) =
    {
	if (self.inalice(a))
	    self.explode(a);
	pass doEat;
    }
    doThrow( a ) =
    {
	if (self.inalice(a))
	    self.explode(a);
	pass doThrow;
    }
    doThrowAt( a ) =
    {
	if (self.inalice(a))
	    self.explode(a);
	pass doThrowAt;
    }
    doThrowTo( a ) =
    {
	if (self.inalice(a))
	    self.explode(a);
	pass doThrowTo;
    }
;

cake3: fooditem, icing		// 140
    sdesc = "piece of cake with red icing"
    noun = 'cake' 'icing'
    adjective = 'red'
    heredesc = "There is a piece of cake with red icing here."
    location = teaRoom
    bulk = 4

    magnified = "The icing, now visible, says \"Evaporate\". "

    doThrowAt( actor, io ) =
    {
	if (io = sewage) {
	    sewage.evaporate;
	    self.moveInto(poolRoom);
	} else
	    pass doThrowAt;
    }
;

cake4: fooditem, icing		// 141
    sdesc = "piece of cake with blue icing"
    noun = 'cake' 'icing'
    adjective = 'blue' 'ecch'
    heredesc = "There is a piece of cake with blue (ecch) icing here."
    location = teaRoom
    bulk = 4

    magnified = "The icing, now visible, says \"Enlarge\". "

    doEat( a ) =
    {
	self.moveInto(nil);
	"The room around you seems to be getting smaller.\n";
	if (not a.isIn(postsRoom)) {
	    "The room seems to have become too small to hold %you%.  It seems
	    that the walls are not as compressible as %your% body, which is
	    more or less demolished.\n";
	    a.died;
	} else {
	    teaRoom.shrink;
	}
    }
;

postsRoom: darkroom		// 145
    sdesc = "Posts Room"
    ldesc = "This is an enormous room, in the center of which are four wooden
	    posts delineating a rectangular area, above which is what appears
	    to be a wooden roof.  In fact, all objects in this room appear to
	    be abnormally large.  To the east is a passageway.  There is a
	    large chasm on the west and the northwest."
    // --Exits
    east(a) = poolRoom
    nw(a) = { return( self.down(a) ); }
    west(a) = { return( self.down(a) ); }
    down(a) = { "There is a chasm too wide to jump across."; return( nil ); }
;

posts: fixeditem	// 136
    sdesc = "group of wooden posts"
    noun = 'post' 'posts'
    adjective = 'wooden' 'wood'
    location = postsRoom
;

poolRoom: darkroom		// 146
    sdesc = "Pool Room"
    ldesc = "This is a large room, one half of which is depressed.  There is a
	    large leak in the ceiling through which brown colored goop is
	    falling.  The only exit from this room is to the west."
    // --Exits
    out(a) = postsRoom
    west(a) = postsRoom
;

largeleak: fixeditem	// 191
    sdesc = "leak"
    noun = 'leak'
    adjective = 'large'
    location = poolRoom

    verDoTake( a ) = ( notlikely() )
    verDoPlugWith(a, io) = "The leak is too high above you to reach. "
;

flask: item,transparentItem		// 132
    sdesc = "glass flask"
    noun = 'flask'
    adjective = 'glass'
    heredesc = "A stoppered glass flask with skull-and-crossbones markings is
	     here.  The flask is filled with some clear liquid."
    location = poolRoom
    bulk = 10
    maxbulk = 5

    showmunged = "Noxious vapors prevent your entry. "

    verDoOpen( a ) = { if (a <> Me) "It refuses. "; }
    doOpen( a ) =
    {
	toplocation(a).munged := self;
	"Just before you pass out, you notice that the vapors from the
	flask's contents are fatal. ";
	a.died;
    }
    doBreak( a ) =
    {
	self.moveInto(nil);
	"The flask breaks into pieces. ";
	self.doOpen(a);
    }
;

sewage: immobile		// 133
    sdesc = "pool of sewage"
    noun = 'pool' 'sewage' 'goop'
    adjective = 'brown' 'large'
    heredesc = "The leak has submerged the depressed area in a pool of sewage."
    location = poolRoom

    evaporate =
    {
	self.moveInto(nil);
	"The pool of water evaporates, revealing a tin of rare spices. ";
	spices.moveInto(poolRoom);
    }

    /* added to make it a bit easier, DBJ */
    verIoPutIn( a ) = { }
    ioPutIn( a, dobj ) =
    {
	if (dobj = cake3) {
	    self.evaporate;
	    dobj.moveInto(poolRoom);
	} else
	    inherited.verIoPutIn( a );
    }
;

spices: treasure		// 134
    sdesc = "tin of spices"
    noun = 'tin' 'saffron' 'spices'
    adjective = 'rare'
    heredesc = "There is a tin of rare spices here."
    /* location = poolRoom    not here initially, hidden in sewage */
    findscore = 5
    trophyscore = 5
    bulk = 8
;
