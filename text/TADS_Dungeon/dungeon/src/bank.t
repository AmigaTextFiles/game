/* The Bank of Zork */

bankEntry: darkroom		// 148
    sdesc = "Bank Entrance"
    ldesc = "This is the large entrance hall of the Bank of Zork, the largest
	    banking institution of the Great Underground Empire.  A partial
	    account of its history is in \"The Lives of the Twelve Flatheads\"
	    with the chapter on J. Pierpont Flathead.  A more detailed history
	    (albeit less objective) may be found in Flathead's outrageous
	    autobiography \"I'm Rich and You Aren't - So There!\".
	    \n\tMost of the furniture has been ravaged by passing scavengers.
	    All that remains are two signs at the northwest and northeast
	    corners of the room, which say
	    \b
	    \t\t<-- WEST VIEWING ROOM\t\tEAST VIEWING ROOM -->"
    
    // --Exits
    nw(a) = wTeller
    ne(a) = eTeller
    south(a) = gallery
;

class tellerRoom: darkroom
    sdesc = "\^<<self.which>> Teller's Room"
    ldesc = "This is a small square room, which was used by a bank officer
	    whose job it was to retrieve safety deposit boxes for the customer.
	    On the north side of the room is a sign which reads
	    \"Viewing Room\".
	    On the <<self.which>> side of the room, above an open door,
	    is a sign reading
	    \b
	    \t\t\tBANK PERSONNEL ONLY"
;

wTeller: tellerRoom		// 149
    which = "west"
    
    // --Exits
    north(a) = wViewing
    south(a) = bankEntry
    west(a) =
    {
	if (a) curtain.dest := wViewing;
	return( depository );
    }
;

eTeller: tellerRoom		// 150
    which = "east"
    
    // --Exits
    north(a) = eViewing
    south(a) = bankEntry
    east(a) =
    {
	if (a) curtain.dest := eViewing;
	return( depository );
    }
;

class viewingRoom: darkroom
    sdesc = "Viewing Room"
    ldesc =
	"This is a room used by holders of safety deposit boxes to view
	their contents.  On the north size of the room is a sign which says
	\b
	\ \ \ REMAIN HERE WHILE THE BANK OFFICER RETRIEVES YOUR DEPOSIT BOX\n
	\ \ \ \ WHEN YOU ARE FINISHED, LEAVE THE BOX, AND EXIT TO THE SOUTH\n
	\ \ \ \ \ AN ADVANCED PROTECTIVE DEVICE PREVENTS ALL CUSTOMERS FROM\n
	\ \ \ \ \ \ REMOVING ANY SAFETY DEPOSIT BOX FROM THIS VIEWING AREA!\n
	\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Thank you for banking at the Zork!\n"
    reachable = [nwall, swall, ewall, wwall]
    
    // --Exits
    south(a) = bankEntry
;

wViewing: viewingRoom		// 151
;

eViewing: viewingRoom		// 152
;

smallRoom1: darkroom	// 153
    sdesc = "Small Room"
    ldesc = "This is a small bare room with no distinguishing features.  There
	    are no exits from this room."
    sacred = true
    reachable = [nwall, swall, ewall, wwall]
;

vault: darkroom		// 154
    sdesc = "Vault"
    ldesc = "This is the Vault of the Bank of Zork, in which there are no
	    doors."
    sacred = true
    reachable = [nwall, swall, ewall, wwall]

    alarm =
    {
	/* Actor must be Me, because we tested earlier in the verDoEnter's */
	if (Me.isIn(self)) {
	    "A metallic voice says, \"Hello, Intruder!  Your unauthorized
	    presence in the vault area of the Bank of Zork has set off all
	    sorts of nasty surprises, several of which seem to have been fatal.
	    This message brought to you by the Frobozz Magic Alarm Company.\"
	    \n";
	    Me.died;
	}
	if ( Me.isIn(smallRoom1) and not gnome.appeared )
	    notify(gnome, &arrival, 5);
    }
;

bills: treasure,readable,burnable		// 148
    sdesc = "stack of zorkmid bills"
    noun = 'pile' 'zorkmid' 'stack' 'bills'
    adjective = '200' 'neat'
    heredesc = "200 neatly stacked zorkmid bills are here."
    origdesc = "On the floor sit 200 neatly stacked zorkmid bills."
    ldesc = "\n
\ _______________________________________________________________\n
| 1 \ 0 \ \ 0 \ \ \ \ \ \ \ \ GREAT UNDERGROUND EMPIRE \ \ \ \ \ \ \ \ \ \ 1 \ 0 \ \ 0 \ |\n
| 1 0 0 0 0 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1 0 0 0 0 |\n
| 1 0 0 0 0 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1 0 0 0 0 |\n
| 1 \ 0 \ \ 0 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ DIMWIT \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1 \ 0 \ \ 0 \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |||||||||||||||| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ || \ \ __ \ __ \ \ || \ \ \ \ \ \ \ \ \ \ \ \ \ B30332744D |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ || \ -OO \ OO- \ || \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ IN FROBS \ \ \ \ \ \ \\|| \ \ \ >> \ \ \ ||/ \ \ \ \ \ \ WE TRUST \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ || \ ______ \ || \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| B30332744D \ \ \ \ \ \ \ \ \ \ \ \ | \ ------ \ | \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \\\\________// \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| 1 \ 0 \ \ 0 \ \ \ Series \ \ \ \ \ \ FLATHEAD \ \ \ \ LD Flathead \ \ 1 \ 0 \ \ 0 \ |\n
| 1 0 0 0 0 \ \ 719GUE \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Treasurer \ \ \ 1 0 0 0 0 |\n
| 1 0 0 0 0 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1 0 0 0 0 |\n
| 1 \ 0 \ \ 0 \ \ \ \ \ \ \ One Hundred Royal Zorkmids \ \ \ \ \ \ \ \ \ 1 \ 0 \ \ 0 \ |\n
|_______________________________________________________________|"
    location = vault
    findscore = 10
    trophyscore = 15
    bulk = 10

    verDoEat( a ) = "Talk about eating rich foods! "
    verDoBurnWith( a, io ) = "Nothing like having money to burn! "
;

depository: room	// 155
    sdesc = "Safety Depository"
    ldesc = "This is a large rectangular room.  The east and west walls here
	    were used for storing safety deposit boxes.  As might be expected,
	    all have been carefully removed by evil persons.  To the east,
	    west, and south of the room are large doorways.  The northern
	    \"wall\" of the room is a shimmering curtain of light.  In the
	    center of the room is a large stone cube, about 10 feet on a side.
	    Engraved on the side of the cube is some lettering."
    reachable = [swall, ewall, wwall] /* for consistency, DBJ */
    
    // --Exits
    checktheft( a, dest ) =
    {
	if (a and (bills.isIn(a) or portrait.isIn(a))) {
	    "An alarm rings briefly, and an invisible force prevents you
	    from leaving. ";
	    return( nil );
	}
	return( dest );
    }
    north(a) = { "There is a curtain of light there."; return( nil ); }
    west(a) = ( self.checktheft(a, wTeller) )
    east(a) = ( self.checktheft(a, eTeller) )
    south(a) = office
;


stonecube: readable,fixeditem	// 150
    sdesc = "large stone cube"
    noun = 'vault' 'cube' 'lettering'
    adjective = 'large' 'stone'
    ldesc = "\t\t\t\ Bank of Zork\n
	    \t\t\t\tVAULT\n
	    \t\t\t\ \ *722 GUE*\n
	    \t\ \ \ Frobozz Magic Vault Company"
    location = depository
    bulk = 5
;

/* stuff shared by curtain of light and walls */
class magicwall: wall
    verDoPush( a ) =
    {
	if (self.ismagic(a))
	    "As you try, your hand seems to go through it. ";
	else
	    pass verDoPush;
    }
    verDoMove( a ) =
    {
	if (self.ismagic(a))
	    "As you try, your hand seems to go through it. ";
	else
	    pass verDoMove;
    }
    verDoTake( a ) =
    {
	if (self.ismagic(a))
	    "As you try, your hand seems to go through it. ";
	else
	    pass verDoTake;
    }
    verDoTouch( a ) =
    {
	if (self.ismagic(a))
	    "As you try, your hand seems to go through it. ";
	else
	    pass verDoTouch;
    }
    verDoAttackWith( a, io ) =
    {
	if (self.ismagic(a))
	    "\^<<io.thedesc>> goes through it. ";
	else
	    pass verDoAttackWith;
    }
;

curtain: magicwall	// 151
    sdesc = "shimmering curtain of light"
    /* this is also the north wall... */
    noun = 'curtain' 'light' 'screen'      'wall' 'northwall'
    adjective = 'shimmering'               'northern'
    location = depository
    bulk = 5

    ismagic( a ) = true		/* can always walk through */
    
    dest = nil			/* where things that pass through end up */
    activeroom = nil		/* room that has an active magic wall */
    
    doSynonym('Push') = 'Open'  /* makes sense, DBJ */

    ioThrowAt( a, dobj ) =
    {
	if (self.dest = nil) {
	    "You can't do that! ";
	    return;
	}
	dobj.moveInto(self.dest);
	"The curtain dims slightly as <<dobj.thedesc>> passes through. ";
	unnotify(vault, &alarm); /* cancel alarm */
	self.dest := nil;
    }
    
    verDoEnter( a ) =
    {
	if (self.dest = nil or a <> Me)
	    "%You% can't go more than part way through the curtain. ";
    }
    doEnter( a ) =
    {
	self.activeroom := self.dest;
	"You feel somewhat disoriented as you pass through...\n";
	a.travelTo(self.dest);
	notify(vault, &alarm, 6); /* start alarm! */
    }
;

office: darkroom		// 156
    sdesc = "Chairman's Office"
    ldesc = "This room was the office of the Chairman of the Bank of Zork.
	    Like the other rooms here, it has been extensively vandalized.
	    The lone exit is to the north."
    // --Exits
    north(a) =
    {
	if (a) curtain.dest := smallRoom1;
	return( depository );
    }
;

portrait: treasure,readable,burnable	// 149
    sdesc = "portrait of J. Pierpont Flathead"
    noun = 'painting' 'art' 'portrait'
    heredesc = "A portrait of J. Pierpont Flathead is here."
    origdesc = "A portrait of J. Pierpont Flathead hangs on the wall."
    ldesc = "\b
\t\t\t\ \ \ ||||||||||||||\n
\t\t\t\ \ || \ \ __ \ __ \ \ ||\n
\t\t\t\ \ || \ \ $$ \ $$ \ \ ||\n
\t\t\t\ \\|| \ \ \ \ >> \ \ \ \ ||/\n
\t\t\t\ \ || \ ________ \ ||\n
\t\t\t\ \ \ | \ -//----- \ |\n
\t\t\t\t\\\_//_______/\n
\t\t\t\ \ ___// | \ |\n
\t\t\t\ /__// \ | \ |\n
\t\t\t\t\ \ \ \ | \ |\n
\t\t\ __________// \ \\\\__________\n
\t\t/ $ / \ \ \ \ \ \ **** \ \ \ \ \ \ \\ $ \\\n
\t\ \ \ / \ \ / \ \ \ \ \ \ \ \ ** \ \ \ \ \ \ \ \ \\ \ \ \\\n
\t\ \ / \ \ /| \ \ \ \ \ \ \ \ ** \ \ \ \ \ \ \ \ |\\ \ \ \\\n
\t\ / \ \ / | \ \ \ \ \ \ \ \ ** \ \ \ \ \ \ \ \ | \\ \ \ \\\n
\t/ \ \ / \ | \ \ \ \ \ \ \ \ ** \ \ \ \ \ \ \ \ | \ \\ \ \ \\\n
\t^ \ \ ^__|______$Z$**$Z$______|__^ \ \ ^\n
\t\\ \ \ \ \ \ \ \ \ * \ \ $Z$**$Z$ \ \ * \ \ \ \ \ \ \ \ /\n
\t\ \\________*___$Z$**$Z$___*________/\n
\t\t\ \ \ | \ \ \ \ \ $Z$**$Z$ \ \ \ \ \ |\n
\b
\t\t\ \ \ J.  PIERPONT \ FLATHEAD\n
\t\t\t\t\ \ CHAIRMAN"
    location = office
    findscore = 10
    trophyscore = 5
    bulk = 25
;

gnome: Actor		// 152
    sdesc = "Gnome of Zurich"
    noun = 'gnome'
    adjective = 'zurich'
    heredesc = "There is a Gnome of Zurich here."
    bulk = 5

    appeared = nil

    arrival =
    {
	if (appeared or not Me.isIn(smallRoom1))
	    return;
	appeared := true;
	self.moveInto(smallRoom1);
	"An epicene Gnome of Zurich, wearing a three-piece suit and carrying a
	safety deposit box, materializes in the room.  \"You seem to have
	forgotten to deposit your valuables,\" he says, tapping the lid of the
	box impatiently.  \"We don't usually allow customers to use the boxes
	here, but we can make this ONE exception, I suppose...\"  He looks
	askance at you over his wire-rimmed bifocals.\n";
	notify(self, &departure, 12);
    }
    departure =
    {
	if (self.isVisible(Me))
	    "The gnome looks impatient:  \"I may have another customer waiting;
	    you'll just have to fend for yourself, I'm afraid.\"
	    He disappears, leaving you alone in the bare room.\n";
	self.moveInto(nil);
    }

    ioGiveTo( a, dobj ) =
    {
	if (isclass(dobj, treasure)) {
	    "The gnome carefully places <<dobj.thedesc>> in the
	    deposit box.  \"Let me show you the way out,\" he says, making it
	    clear that he will be pleased to see the last of you.  Then, you
	    are momentarily disoriented, and when you recover, you are back
	    at the Bank Entrance.\b";
	    dobj.moveInto(nil);	/* ah well... */
	    self.moveInto(nil);
	    Me.travelTo(bankEntry);
	    unnotify(self, &departure);
	} else if (dobj = brick and brick.dangerous) {
	    "\"Surely you jest\", he says.  He tosses the brick over his
	    shoulder and disappears with an understated \"pop\".\n";
	    dobj.moveInto(smallRoom1); /* oops */
	    self.moveInto(nil);
	    unnotify(self, &departure);
	} else {
	    "\"I wouldn't put THAT in a safety deposit box,\" remarks the gnome
	    with disdain, tossing it over his shoulder, where it disappears
	    with an understated \"pop\".\n";
	    dobj.moveInto(nil);
	}
    }
    ioSynonym('GiveTo') = 'ThrowTo'

    verDoAttackWith( a, io ) = { }
    doAttackWith( a, io ) =
    {
	"The gnome says, \"Well, I never!\" and disappears with a snap of his
	fingers, leaving you alone.\n";
	self.moveInto(nil);
	unnotify(self, &departure);
    }
    
    /* Might be nice here to set up so we can ask Gnome about
     * deposit box, bank, etc.
     */
    dobjGen(a, v, i, p) = {
	"The gnome appears increasingly impatient.\n";
	exit;
    }
    iobjGen(a, v, d, p) = ( self.dobjGen(a, v, d, p)  )
;

class bankwall: floater, magicwall
    ismagic( a ) =
	( a.isIn(curtain.activeroom) and a.isIn(self.magicroom) )

    ioThrowAt( a, dobj ) =
    {
	if (not self.ismagic(a))
	    pass ioThrowAt;
	dobj.moveInto(depository);
	"\^<<dobj.thedesc>> passes through the wall and vanishes. ";
	unnotify(vault, &alarm); /* cancel alarm */
	curtain.dest := nil;
    }

    verDoEnter( a ) =
    {
	if (not self.ismagic(a) or a <> Me)
	    pass verDoEnter;
    }
    doEnter( a ) =
    {
	curtain.dest := self.nextdest;
	unnotify(vault, &alarm); /* cancel alarm */
	"You feel somewhat disoriented as you pass through...\n";
	a.travelTo( depository );
    }
;

nwall: bankwall		// 269
    sdesc = "northern wall"
    noun = 'wall' 'northwall'
    adjective = 'northern'

    magicroom = vault		/* room we might be magic in */
    nextdest = smallRoom1	/* when we enter, set curtain dest to this */
;

swall: bankwall		// 270
    sdesc = "southern wall"
    noun = 'wall' 'southwall'
    adjective = 'southern'

    magicroom = smallRoom1
    nextdest = vault
;

ewall: bankwall		// 271
    sdesc = "eastern wall"
    noun = 'wall' 'eastwall'
    adjective = 'eastern'

    magicroom = wViewing
    nextdest = eViewing
;

wwall: bankwall		// 272
    sdesc = "western wall"
    noun = 'wall' 'westwall'
    adjective = 'western'

    magicroom = eViewing
    nextdest = wViewing
;
