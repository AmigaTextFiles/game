/*
 * The stuff in this file basically overrides and replaces what's
 * in adv.t.  This is done so that newer versions of adv.t with
 * bug fixes or improvements can be plugged in easier than otherwise.
 */

/*
 * One big change is that some things, mostly directions, need an
 * actor argument.  This is so that we can peek into neighboring
 * rooms without going through all the checks to see if we can
 * move (ie, the dwarven sword wants to see if enemies are nearby, etc).
 */

/* modified to have 'a' (actor) argument */
replace checkDoor: function( d, r, a )
{
    if (a = nil or d.isopen )
        return( r );
    else
    {
        setit( d );
        "\^<<d.thedesc>> is closed. ";
        return( nil );
    }
}

/* Stuff for listing contents of rooms, objects, etc.
 * Note: I don't show contents of contents of contents like
 * the original Dungeon (ie, containers nested inside oother
 * containers won't have their contents listed).
 *
 * Also, much of the work is done vis the showcontents property.
 * (turns out I didn't use it as much as I thought, but I'll keep it)
 */

/* Trouble is, Dungeon doesn't really have a notion of "long description"
 * and "short description", so a lot of info ended up in the description
 * you got when you first saw the object, and after you picked it up,
 * you couldn't get that info back...  A real "reimplementation" would
 * do a lot of work and creative editing to get appropriate ldescs, and
 * then work perfectly fine with the default adv.t listing stuff.
 */
replace listcont: function( obj )
{
    local list, cur;
    
    list := obj.contents;
    while( cur := car(list) ) {
	if ( cur.isListed ) {
	    cur.showdesc;
	    "\n";
	}
	list := cdr(list);
    }
}

replace listcontcont: function( obj )
{
    mapprop(obj.contents, &showcontents);
}

stdshowcontents: function( obj )
{
    local i, len, list, cur, others;
    "\n";
    /* display things with 'origdesc' first */
    list := obj.contents;
    len := length(list);
    others := [];
    for (i := 1; i <= len; i++) {
	cur := list[i];
	if (cur.isListed) {
	    if (cur.hasorig) {
		cur.origdesc; "\n";	/* print out */
	    } else
		others := others + cur;	/* else store */
	}
    }
    
    /* note: the original did "The # also contains:" instead of
     * "The # contains:" if an origdesc was printed.  Perhaps
     * implement this later?
     */
    
    /* now display other contents normally */
    if (car(others)) {
	obj.containsdesc;	/* customizable "blah contains:" string */
	len := length(others);
	for (i := 1; i <= len; i++) {
	    others[i].showdesc;
	    "\n";
	}
    }
}

/* Customization for items.
 * Note, a lot of stuff here handles new verbs from verbs.t.  This is
 * more efficient than having a zillion 'modify class thing's all over.
							   */
modify class thing
    ldesc = "You see nothing special about <<self.thedesc>>. "
    touched = nil		/* set if object ever picked up */
    
    replace doTake( actor ) =
    {
        local totbulk;
	
        totbulk := addbulk( actor.contents ) + self.bulk;
	
        if ( totbulk > actor.maxbulk )
	    "%Your% load is too heavy.  %You% will have to leave something
	    behind. ";
        else
        {
            self.moveInto( actor );
	    touched := true;
            "Taken. ";
        }
    }
    
    doPutIn( actor, io ) =
    {
	touched := true;
	pass doPutIn;
    }
    doPutOn( actor, io ) =
    {
	touched := true;
	pass doPutOn;
    }
    
    /* Customized messages */
    verDoLookin( actor ) = "I don't know how to look inside <<self.adesc>>. "
    verDoLookunder( actor ) = "There is nothing interesting there. "
    verDoAskAbout( actor, io ) =
	"\^<<self.thedesc>> remains mute on that point. "
    verDoTellAbout( actor, io ) =
        "\^<<self.thedesc>> appears unmoved by this. "
    verDoAttackWith( actor, io ) =
        "I've known strange people, but attacking <<self.adesc>>? "
    verDoEat( actor ) =
        "I don't think that <<self.thedesc>> would agree with %youm%. "
    verDoDrink( actor ) =
        "I don't think that <<self.thedesc>> would agree with %youm%. "
    verDoClean( actor ) = "If you wish, but I can't understand why. "
    verDoCleanWith( actor, io ) = "If you wish, but I can't understand why. "
    verDoRead( actor ) = "How can %you% read <<self.adesc>>? "
    verDoTouch( actor ) =
        "Fiddling with <<self.adesc>> doesn't do anything. "
    verDoTurn( actor ) = "%You% can't turn that. "
    verDoTurnWith( actor, io ) =
	"%You% certainly can't turn it with <<io.adesc>>. "
    verIoTurnWith( actor ) =
    {
	if (not self.istool) "%You can't turn anything with <<self.adesc>>. ";
    }
    ioTurnWith( actor, dobj ) = ( dobj.doTurnWith( actor, self ) )
    
    verDoEnter( a ) =
    {
	if (self.isIn(a))
	    "That would involve quite a contortion! ";
	else
	    notlikely();
    }

    /* stuff for lighting/turning-on/burning...  ugly */
    verDoTurnon( actor ) = "%You% can't turn that on. "
    verDoTurnoff( actor ) = "%You% can't turn that off. "
    verDoTurnonWith( actor, io ) = ( self.verDoTurnon(actor) )
    verIoTurnonWith( actor ) = { }
    ioTurnonWith( actor, dobj ) = ( dobj.doTurnonWith( actor, self ) )
    verDoBurnWith( actor, io ) = "I don't think you can burn <<self.adesc>>. "
    verIoBurnWith( actor ) = "With <<self.adesc>>? "

    /* BreakVerb */
    doBreak( actor ) = "Trying to destroy <<self.adesc>> <<useless()>>. "
    verDoBreakWith( actor, iobj ) = self.verDoBreak( actor )
    doBreakWith( actor, io ) = self.doBreak( actor )
    verIoBreakWith( actor ) = { }
    ioBreakWith( actor, dobj ) = ( dobj.doBreakWith( actor, self ) )
    /*
    doSynonym('Break') = 'Poke'
    ioSynonym('BreakWith') = 'PokeWith'
    */
    
    /* fill/pour */
    verDoFillWith( actor, io ) =
	"Sadly, <<self.adesc>> can't be filled with <<io.adesc>>. "
    verIoPourIn( actor ) = { self.verIoPutIn( actor ); }
    verDoPour( actor ) = "You can't pour that. "
    verDoPourIn( actor ) = "You can't pour that on anything. "
    ioPourIn( actor, dobj ) = { dobj.doPourIn( actor, self ); }
    verDoPourOn( actor ) = ( self.verDoPourIn )
    verIoPourOn( actor ) = { }
    ioPourOn( actor, dobj ) = { dobj.doPourOn( actor, self ); }
    douse( actor ) =
	"The water spills over <<self.thedesc>> and to the floor,
	where it evaporates. "

    /* Tie/Untie */
    verDoTieTo( actor, io ) = "How can %you% tie that to anything? "
    verIoTieTo( actor ) = "You can't tie it to <<self.thedesc>>. "
    verDoTieWith( actor, io ) = "Why would you want to tie up <<self.adesc>>? "
    verIoTieWith( actor ) =
	"You certainly can't tie anything up with <<self.adesc>>. "
    verDoUntie( actor ) = "This cannot be tied, so it cannot be untied! "
    verDoUntieFrom( actor, io ) = ( self.verDoUntie( actor ) )
    verIoUntieFrom( actor ) = { }
    ioUntieFrom( actor, dobj ) = ( dobj.doUntie( actor ) )

    /* Misc. verbs */
    verDoSendfor( actor ) = "That doesn't make sense. "
    verDoLift( actor ) =
	"Playing in this way with <<self.adesc>> <<useless()>>. "
    verDoLower( actor ) = 
	"Playing in this way with <<self.adesc>> <<useless()>>. "
    verDoOpenWith( actor, io ) = ( self.verDoOpen( actor ) )
    verIoOpenWith( actor ) = { }
    ioOpenWith( actor, dobj ) = { dobj.doOpenWith( actor, self ); }
    verDoWind( actor ) = "%You% cannot wind up <<self.adesc>>. "
    verDoHello( actor ) =
	"I think that only schizophrenics say \"Hello\" to <<self.adesc>>. "
    verDoWakeup( actor ) =
	"It isn't sleeping. "
    verDoKick( actor ) = "Kicking <<self.adesc>> <<useless()>>. "
    verDoLookThru( actor, io ) = ( self.verDoInspect( actor ) )
    verDoReadThru( actor, io ) = ( self.verDoRead( actor ) )
    verIoLookThru( actor ) = "How can you look through <<self.adesc>>? "
    verIoReadThru( actor ) = "How can you look through <<self.adesc>>? "
    doLookThru( actor, io ) = ( self.doInspect( actor ) )
    doReadThru( actor, io ) = ( self.doRead( actor ) )
    verDoPlugWith( a, io ) = "This seems to have no effect. "
    verIoPlugWith( a ) = { }
    ioPlugWith( a, dobj ) = ( dobj.doPlugWith(a, self) )
    verDoLaunch( a ) = "<<notlikely()>> "
    verDoLand( a ) = "<<notlikely()>> "
    verDoOilWith( a, io ) = { }
    doOilWith( a, io ) = "That's not very useful. "
    verIoOilWith( a ) = "You probably put spinach in your gas tank, too. "
    verDoSqueeze( a ) = "How singularly useless. "
    verDoInflateWith( a, io ) = "How can you inflate that? "
    verIoInflateWith( a ) = "With <<self.adesc>>?  Surely you jest. "
    verDoDeflate( a ) = "Come on, now! "
    verDoWave( a ) = "Waving <<self.adesc>> <<useless()>>. "
    verIoDigWith( a ) =
    {
	if (self.istool)
	    "Digging with <<self.thedesc>> is slow and tedious. ";
	else
	    "Digging with <<self.adesc>> is silly. ";
    }
    verDoMeltWith( a, io ) = "I'm not sure that <<self.adesc>> can be melted. "
    verIoMeltWith( a ) = { }  /* handle checking for this elsewhere */
    ioMeltWith( a, dobj ) = ( dobj.doMeltWith( a, self ) )
    verDoRing( a ) = "How, exactly, can I ring that? "
    verDoRingWith( a, io ) = ( self.verDoRing( a ) )
    verIoRingWith( a ) = { }
    ioRingWith( a, dobj ) = ( dobj.doRingWith( a, self ) )
    verDoJump( a ) = ( jumpVerb.action( a ) )
    verDoPutUnder( a, io ) = { }
    verIoPutUnder( a ) = "You can't do that. "
    verDoKnock( a ) = "Why knock on <<self.adesc>>? "
    verDoShake( a ) = "Nothing happens. "
    verDoPlay( a ) = "Nothing happens. "
    verIoPlayWith( a ) = { }
    ioPlayWith( a, dobj ) = ( dobj.doPlayWith( a, self ) )
    verDoSmell( a ) = "It smells like <<self.adesc>>. "
    
    /* Find verb */
    verDoFind( actor ) =
    {
	if ( actor.isIn(self.location) )
	    "\^<<self.thedesc>> is right here. ";
	else if ( actor.isCarrying(self) )
	    "%You% are carrying <<self.thedesc>>. ";
	else if ( self.location and self.location.iscontainer
		 and self.location.isVisible( actor ) )
	    "\^<<self.thedesc>> is in <<self.location.thedesc>>. ";
	else
	    "\^<<self.thedesc>> must be around here somewhere. ";
    }
;

modify fixeditem
    verDoEnter( a ) = "%You% hit%s% %your% head against <<self.thedesc>> as
		      %you% attempt%s% this feat. "
    verDoShake( a ) = "%You% can't take it; thus, %you% can't shake it! "
;

modify theFloor
    douse( actor ) = "The water spills onto the ground, where it evaporates. "
;

modify class item
    /* Dungeon-style descriptions - origdesc is given until the object
     * is picked up/moved.  Ie, it may say "Resting in the niche is a foo",
     * but then after being gotten and dropped, it will say "A foo is here"
     */
    showdesc =
    {
	if (self.hasorig)
	{
	    /* Description as originally found */
	    self.origdesc;
	}
	else if (isclass(self.location, room) and
		 self.location.location = nil)
	{
	    /* Description as found lying in a toplevel room */
	    self.heredesc;
	}
	else
	{
	    /* Here, we're part of inventory or container listing,
	     * so indent a little bit.
	     */
	    "\ \ \^"; self.adesc; ".";
	}
    }
    /* Because stdshowcontents will list things with an origdesc
     * first, this detects if such a property exists.  (if we
     * didn't do this, it would be simple enough to just have the
     * default origdesc call heredesc)
     */
    hasorig =
    {
	local x;
	return( not touched and defined(self, &origdesc) );
    }
    
    /* This is here instead of container, because noncontainers can
     * (rarely) contain other items (ie, the stamp on the free brochure).
     */
    showcontents =
    {
	if ( self.contentsVisible and not self.isqcontainer )
	    stdshowcontents(self);
    }
    
    containsdesc = "\^<<self.thedesc>> contains:\n"
;

modify class room
    /* take care of scoring for certain rooms */
    enterRoom( actor ) =
    {
	inherited.enterRoom( actor );
	if (self.scoreval <> nil and actor = Me and not actor.isdead) {
	    incscore(self.scoreval);
	    self.scoreval := nil;
	}
    }

    /* our own style of looking around here */
    
    replace nrmLkAround( verbosity ) =
    {
        if ( verbosity )
	    self.ldesc;
	else {
	    self.statusLine;
	}
        "\n";

	if ( isclass(Me.location, vehicle) )
	    "You are in <<Me.location.thedesc>>.\n";
	self.showcontents;
    }
    replace lookAround( verbosity ) =
    {
	self.nrmLkAround( verbosity );
    }
    replace statusLine =
    {
        self.sdesc;
    }
    showcontents =
    {
	local i, len, list, cur;
	listcont( self );
	listcontcont( self );

	/* list actors */
	list := self.contents;
	len := length(list);
	for (i := 1; i <= len; i++) {
	    cur := list[i];
	    if ( cur.isactor )
		cur.actorDesc;
	}
	"\n";
    }

    /* these all take an argument that the original didn't have */
    
    replace north(a) = { return( self.noexit(a) ); }
    replace south(a) = { return( self.noexit(a) ); }
    replace east(a)  = { return( self.noexit(a) ); }
    replace west(a)  = { return( self.noexit(a) ); }
    replace up(a)    = { return( self.noexit(a) ); }
    replace down(a)  = { return( self.noexit(a) ); }
    replace ne(a)    = { return( self.noexit(a) ); }
    replace nw(a)    = { return( self.noexit(a) ); }
    replace se(a)    = { return( self.noexit(a) ); }
    replace sw(a)    = { return( self.noexit(a) ); }
    replace in(a)    = { return( self.noexit(a) ); }
    replace out(a)   = { return( self.noexit(a) ); }
    cross(a)         = { return( self.noexit(a) ); }

    /* A smarter noexit.  Relies upon global.tv being set to the
     * current travelVerb.
     */
    replace noexit(a) = 
    {
	if (a) {
	    if (global.tv = nil)
		"%You% can't go that way. ";
	    else if (not a.location.nowalls and global.tv.wallverb)
		"There is a wall there. ";
	    else if (global.tv = uVerb)
		"There is no way up. ";
	    else if (global.tv = dVerb)
		"There is no way down. ";
	    else		
		"%You% can't go that way. ";
	}
	return( nil );
    }
;

modify class darkroom
    replace noexit(a) =
    {
	if (a = nil)
	    return( nil );
        if ( self.islit ) pass noexit;
	else
	{
	    /* we assume a = Me here (sigh) */
	    darkTravel2();
	    return( nil );
	}
    }
    replace roomAction( actor, v, dobj, prep, io ) =
    {
        if ( not self.islit and not v.isDarkVerb )
	{
	    "It is too dark in here to see. ";
	    exit;
	}
	else pass roomAction;
    }
    replace lookAround( verbosity ) =
    {
        if ( self.islit ) pass lookAround;
	else "It's pitch black. You are likely to be eaten by a grue. ";
    }
    /* NOTE: Change this for customized dark messages!!! (see darkness.t) */
    replace roomCheck( v ) =
    {
        if ( self.islit or v.isDarkVerb ) return( true );
	else
	{
	    "It is too dark in here to see.\n";
	    return( nil );
	}
    }
;

modify class movableActor
    ldesc =
    {
	if (itemcnt(self.contents) > 0)
	    stdshowcontents(self);
	else
	    "You see nothing special about <<self.thedesc>>. ";
    }
    actorDesc = ( self.heredesc )
    containsdesc = "\^<<self.thedesc>> is carrying:\n"

    /* handle rooms that are no longer able to be entered */
    travelTo( room ) =
    {
	if (room and room.munged <> nil) {
	    /* munged is the object that caused the trouble */
	    room.munged.showmunged;
	    return;
	} else if (room)
	    pass travelTo;
    }

    died =
    {
	"\^<<self.thedesc>> has died.\n";
	self.moveInto(nil);
    }
    
    verDoTieWith( actor, io ) = { }
    verDoSendFor( actor ) = "Why would %you% send for <<self.thedesc>>? "
    verDoHello( actor ) = {}
    doHello( actor ) =
	"\^<<self.thedesc>> bows his head to you in greeting. "
    ioGiveTo( actor, dobj ) = ( dobj.doGiveTo( actor, self ) )
;

modify class vehicle
    isListed = ( not Me.isIn(self) )
    statusLine =
    {
	"<<self.location.sdesc>>, <<self.statusPrep>> <<self.thedesc>>\n";
    }
    
    replace verDoTake(actor) =
    {
        if (actor.isIn(self))
	    "%You% are in it, loser! ";
	else
	    pass verDoTake;
    }
    
    noexit(a) =
    {
        if (a <> nil)
	    "%You're% not going anywhere until %you% get%s% out of
	    <<self.thedesc>>. ";
        return( nil );
    }

    out(a) = ( self.location )
;

modify class surface
    ldesc =
    {
	if (itemcnt( self.contents ))
        {
	    self.containsdesc;
	    listcont( self );
	    listcontcont( self );
        }
        else
        {
            "There's nothing on "; self.thedesc; ". ";
        }
    }
    containsdesc = "On <<self.thedesc>> %you% see:\n"
;

modify class container
    ldesc =
    {
        if ( self.contentsVisible and itemcnt( self.contents ) <> 0 )
        {
	    stdshowcontents(self);
        }
        else
        {
	    "\^<<self.thedesc>> is empty. ";
        }
    }

    verDoShake( actor ) = { }
    doShake( actor ) =
    {
	if (itemcnt( contents ) = 0)
	    "Nothing happens. ";
	else if (not isopen)
	    "It sounds like there is something inside <<self.thedesc>>. ";
	else {
	    local cur;
	    "The contents of <<self.thedesc>> spill out.\n";
	    while (cur := car(contents)) {
		cur.touched := true;
		if (cur = somewater) {
		    cur.moveInto(nil);
		    "The water spills to the floor and evaporates
		    immediately. ";
		} else {
		    cur.moveInto(actor.location);
		}
	    }
	}
    }
;

modify class openable
    doOpen( actor ) =
    {
        if (itemcnt( self.contents ))
	{
	    "Opening <<self.thedesc>> reveals:\n";
	    listcont( self );
	}
	else self.openMessage( actor );
	self.isopen := true;
    }
    doOpenWith( actor, io ) = ( self.doOpen( actor ) )
    doClose( actor ) =
    {
	self.closeMessage( actor );
	self.isopen := nil;
    }

    /* These are here for customization */
    openMessage(actor) = "Opened. "
    closeMessage(actor) = "Closed. "
;

/* Note: this is NOT a container by default */
modify class transparentItem
    ldesc =
    {
        if ( self.contentsVisible and itemcnt( self.contents ) <> 0 )
        {
	    "\^<<self.thedesc>> contains:\n";
	    listcont(self);
        }
        else
        {
	    "\^<<self.thedesc>> is empty. ";
        }
    }
    verIoLookThru( actor ) = { }
    ioLookThru( actor, dobj ) = ( dobj.doLookThru( actor, self ) )
    verIoReadThru( actor ) = { }
    ioReadThru( actor, dobj ) = ( dobj.doReadThru( actor, self ) )
;

modify class chairitem
    noexit(a) =
    {
	if (a)
	    "%You're% not going anywhere until %you%
	    get%s% <<outOfPrep>> <<thedesc>>. ";
       return( nil );
    }
;

/* Change the travel verbs to handle extra argument, and to rely upon
 * travelVerb.action so we can change all of them more simply.
 */
modify class travelVerb
    action( actor ) =
    {
	global.tv := self;	/* save for use in noexit */
	actor.travelTo( self.travelDir( actor ));
    }
;

replace eVerb: travelVerb
    verb = 'e' 'east' 'go east'
    travelDir( actor ) = { return( actor.location.east(actor) ); }
    wallverb = true
;
replace sVerb: travelVerb
    verb = 's' 'south' 'go south'
    travelDir( actor ) = { return( actor.location.south(actor) ); }
    wallverb = true
;
replace nVerb: travelVerb
    verb = 'n' 'north' 'go north'
    travelDir( actor ) = { return( actor.location.north(actor) ); }
    wallverb = true
;
replace wVerb: travelVerb
    verb = 'w' 'west' 'go west'
    travelDir( actor ) = { return( actor.location.west(actor) ); }
    wallverb = true
;
replace neVerb: travelVerb
    verb = 'ne' 'northeast' 'go ne' 'go northeast'
    travelDir( actor ) = { return( actor.location.ne(actor) ); }
    wallverb = true
;
replace nwVerb: travelVerb
    verb = 'nw' 'northwest' 'go nw' 'go northwest'
    travelDir( actor ) = { return( actor.location.nw(actor) ); }
    wallverb = true
;
replace seVerb: travelVerb
    verb = 'se' 'southeast' 'go se' 'go southeast'
    travelDir( actor ) = { return( actor.location.se(actor) ); }
    wallverb = true
;
replace swVerb: travelVerb
    verb = 'sw' 'southwest' 'go sw' 'go southwest'
    travelDir( actor ) = { return( actor.location.sw(actor) ); }
    wallverb = true
;
modify inVerb
    replace travelDir( actor ) = { return( actor.location.in(actor) ); }
    replace action( actor ) = ( inherited.action( actor ) )
;
replace outVerb: travelVerb
    verb = 'out' 'go out' 'exit' 'leave'
    travelDir( actor ) = { return( actor.location.out(actor) ); }
;
replace dVerb: travelVerb
    verb = 'd' 'down' 'go down'
    travelDir( actor ) = { return( actor.location.down(actor) ); }
;
replace uVerb: travelVerb
    verb = 'u' 'up' 'go up'
    travelDir( actor ) = { return( actor.location.up(actor) ); }
;

/* cross is a new travelVerb */
crossVerb: travelVerb
    verb = 'cross'
    travelDir( actor ) = { return( actor.location.cross(actor) ); }
;

modify throwVerb
    doAction = 'Throw'		/* this was left out of the 2.2 adv.t */
;

/* these conflict with our tie verb, so hide them */
replace fastenVerb: deepverb ;
replace unfastenVerb: deepverb ;

modify debugVerb
    enterDebugger(actor) =
    {
        if (debugTrace())
	    "A horde of nearly invisible jump off of you and flee.";
    }
;

/* Ugly hack to get 'north wall' etc, to work */
/* Tads 2.2 fixed part of the problem so that 'north' can be an adjective
 * for a wall, but still if you do "robot, east" it will think "east" is
 * an adjective and not work there.
 */
compoundWord 'north' 'wall' 'northwall';
compoundWord 'south' 'wall' 'southwall';
compoundWord 'east' 'wall' 'eastwall';
compoundWord 'west' 'wall' 'westwall';
