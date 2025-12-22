/* This is the Royal Zork Puzzle Museum */

squareRoom: room	// 188
    sdesc = "Small Square Room"
    ldesc = {
	"This is a small square room, in the middle of which is a recently
	created hole through which you can barely discern the floor some
	ten feet below.  It doesn't seem likely you could climb back up.
	There are exits to the west and south.";
    }
    
    // --Exits
    south(a) = sideRoom
    west(a) = treasureRoom
    down(a) =
    {
	puzzleRoom.setindex(10);	/* set location,etc */
	return(puzzleRoom);
    }
;

sideRoom: darkroom	// 189
    sdesc = "Side Room"
    ldesc = {
	"This is a room with an exit to the north and a ";
	if (puzzleRoom.dooropen)
	    "passage to the east.";
	else
	    "metal door to the east.";
    }
    reachable = [steeldoor]

    north(a) = squareRoom
    east(a) =
    {
	if (a) {
	    if (not puzzleRoom.dooropen) {
		"The steel door bars the way.";
		return(nil);
	    }
	    puzzleRoom.setindex(52);
	}
	return(puzzleRoom);
    }
;

puzzleRoom: room	// 190
    sdesc =
    {
	if (not self.pushed)
	    "Dead End";
	else
	    "Room in a Puzzle";
    }
    ldesc =
    {
	if (not self.pushed) {
	    "This is a small square room bounded to the north and west with
	    marble walls and to the east and south with sandstone walls.";
	    if (warning.viewed)
		"\nIt appears the thief was correct.";
	} else {
	    "Your position is as follows:\n";
	    self.diagram;
	}
    }
    reachable = [steeldoor]
    
    /* we always give long desc, so... */
    enterRoom( actor ) = { self.lookAround(1); }
    
    /* various vars... */
    index = 10
    dooropen = nil
    pushed = nil		/* have we ever had a wall pushed */
    pvec = [1,  1,  1,  1,  1,  1,  1,  1,      //  0 = empty
	    1,  0, -1,  0,  0, -1,  0,  1,      //  1 = marble wall
	    1, -1,  0,  1,  0, -2,  0,  1,      // -1 = sandstone xx
	    1,  0,  0,  0,  0,  1,  0,  1,      // -2 = sandstone + w-ladder
	    1, -3,  0,  0, -1, -1,  0,  1,      // -3 = sandstone + e-ladder
	    1,  0,  0, -1,  0,  0,  0,  1,
	    1,  1,  1,  0,  0,  0,  1,  1,
	    1,  1,  1,  1,  1,  1,  1,  1]

    /* Tell if the grid location is visible or not */
    isvis(offset) =
    {
	local k;
	/* get non-diagonal cases out of the way first */
	if (offset = 1 or offset = -1 or offset = 8 or offset = -8)
	    return( true );
	
	k := (offset < 0) ? -8 : 8 ;
	/* corners visible if an adjecent location is clear */
	if (self.pvec[self.index+k] = 0 or self.pvec[self.index+offset-k] = 0)
	    return( true );
	return( nil );
    }

    /* display the appropriate representation for a grid location */
    showsymbol(offset) = {
	local next;
	if (offset = 0)
	    "..";
	else if (not self.isvis(offset)) {
	    "??";
	} else {
	    next := self.index + offset;
	    if (self.pvec[next] > 0)
		"MM";
	    else if (self.pvec[next] = 0)
		"\ \ ";
	    else
		"SS";
	}
    }
    
    diagram = {
	local i;
	for (i := -8; i <= 8; i+=8) {
	    if (i = 0) {
		"West\ \ |";
	    } else {
		"\ \ \ \ \ \ |";
	    }
	    self.showsymbol(i-1);
	    "\ ";
	    self.showsymbol(i);
	    "\ ";
	    self.showsymbol(i+1);

	    if (i = 0)
		"| \ East\n";
	    else
		"|\n";
	}
	/* special descriptions */
	if (self.index = 10)
	    "In the ceiling above you is a large circular opening.\n";
	else if (self.index = 37)
	    "The center of the floor here is noticeably depressed.\n";
	else if (self.index = 52) {
	    if (self.dooropen)
		"The west wall here has a large opening at its center.  On one
		side of the opening in a small slit.\n";
	    else
		"The west wall here has a large steel door at its center.  On
		one side of the door is a small slit.\n";
	}
	if (self.pvec[self.index+1] = -2)
	    "There is a ladder here, firmly attached to the east wall.\n";
	else if (self.pvec[self.index-1] = -3)
	    "There is a ladder here, firmly attached to the west wall.\n";
    }

    setindex(next) = {
	/* Move objects to/from puzzleStorage, as if we were really
	 * a whole bunch of rooms.
	 */
	
	local list, len, i, cur;

	/* move objects out of this pseudo room */
	list := puzzleRoom.contents;
	len := length(list);
	for (i:=1; i<=len; i++) {
	    cur := list[i];
	    if ((not cur.isactor) and (not (isclass(cur,fixeditem)))) {
		cur.puzzleloc := self.index;
		cur.moveInto(puzzleStorage);
	    }
	}
	
	/* move another set of objects back */
	list := puzzleStorage.contents;
	len := length(list);
	for (i:=1; i<=len; i++) {
	    cur := list[i];
	    if (cur.puzzleloc = next)
		cur.moveInto(self);
	}

	if (self.pvec[next+1] = -2 or self.pvec[next-1] = -3)
	    ladder.moveInto(self);
	else
	    ladder.moveInto(nil);
	
	/* set new pseudo room number */
	self.index := next;
    }

    pushwall(offset) = {
	local next;
    	next := self.index + offset;
	if (self.pvec[next] = 0) { /* no wall there */
	    "There is only a passage in that direction.";
	    return;
	}
	if (self.pvec[next] = 1 or self.pvec[next+offset] <> 0) {
	    /* unmoveable wall or obstructed */
	    "The wall does not budge.";
	    return;
	}
	if (puzzleRoom.pushed) {
	    "The wall slides forward and you follow it to this position:\n";
	} else {
	    puzzleRoom.pushed := true;
	    "The wall slides forward and you follow it.
	    The architecture of this region is getting complex, so that further
	    descriptions will be diagrams of the immediate vicinity in a 3x3
	    grid.  The walls here are rock, but of two different types -
	    sandstone and marble.  The following notations will be used:\n
	    \t\t\t\t\t\t.. \ = current position (middle of grid)\n
	    \t\t\t\t\t\tMM \ = marble wall\n
	    \t\t\t\t\t\tSS \ = sandstone wall\n
	    \t\t\t\t\t\t?? \ = unknown (blocked by walls).\n";
	}
	self.pvec[next+offset] := self.pvec[next];
	self.pvec[next] := 0;
	self.setindex(next);
	self.diagram;
	self.nrmLkAround(0);	/* hack to show contents. */
	
    }

    // --Exits
    tryexit(actor, offset) = {
	local next;

	if (actor = nil)
	    return( nil );  /* it's the sword */
	
	next := self.index + offset;
	if (self.pvec[next] = 0 and self.isvis(offset)) {
	    self.setindex(next);
	    return( self );	/* stay here, but also do 'look' */
	} else {
	    return( self.noexit(actor) );
	}
    }
    north(a) = { return( self.tryexit(a, -8) ); }
    ne(a)    = { return( self.tryexit(a, -7) ); }
    east(a)  = { return( self.tryexit(a, 1) ); }
    se(a)    = { return( self.tryexit(a, 9) ); }
    south(a) = { return( self.tryexit(a, 8) ); }
    sw(a)    = { return( self.tryexit(a, 7) ); }
    west(a)  =
    {
	if (self.index <> 52)
	    return( self.tryexit(a, -1) );
	if (self.dooropen)
	    return( sideRoom );
	"The metal door bars the way.";
	return( nil );
    }
    nw(a)    = { return( self.tryexit(a,-9) ); }
    up(a) =
    {
	if (a = nil)
	    return( nil );
	if (self.index <> 10)
	    return ( self.noexit(a) );
	if (self.pvec[self.index+1] <> -2) {
	    "The exit is too far above your head.";
	    return( nil );
	}
	"With the help of the ladder, you exit the puzzle.\b";
	return( squareRoom );
    }
;

puzzleStorage: object
    /* Just a dummy holder */
;

warning: readable,burnable	// 186
    sdesc = "note of warning"
    noun = 'piece' 'paper' 'note' 'warning'
    heredesc = "There is a piece of paper on the ground here."
    ldesc = {
	/* fortran used the touched bit, but since it's possible to
	 * pick up the note without reading it, we do it this way.
	 */
	viewed := true;
	"The paper is rather worn;  although the writing is barely legible
	(the author probably had only a used pencil), it is a very elegant
	copperplate.
	\b
	To Whom It May Concern:
	\b\t
	I regret to report that the rumours regarding treasure contained
	in the chamber to which this passage leads have no basis in fact.
	Should you nevertheless be sufficiently foolhardy to enter, it will
	be quite impossible for you to exit.
	\b
	\t\t\t\t\t\tSincerely yours,\n
	\t\t\t\t\t\tThe Thief";
    }
    location = squareRoom
    bulk = 4
    viewed = nil
;

slit: fixeditem, container  // 187
    sdesc = "small slit"
    noun = 'slot' 'slit'
    adjective = 'small'
    bulk = 5
    maxbulk = 4
    location = puzzleStorage
    puzzleloc = 52
    ioPutIn( actor, dobj ) = {
	/* test size, so we don't succeed via "put steel door in slit", etc */
	if (dobj.bulk > self.maxbulk) {
	    "It won't fit.";
	    return;
	}
	if (dobj <> goldcard) {
	    if (dobj.isactor) {
		notlikely();
	    } else {
		"The item vanishes into the slot.  A moment later, a previously
		unseen sign flashes \"Garbage In, Garbage Out\".  The
		<<dobj.sdesc>>, now atomized, spews through the slot.";
		dobj.moveInto(nil);
	    }
	} else {
	    "The card slides easily into the slot and vanishes, and the metal
	    door slides open, revealing a passageway to the west.  A moment
	    later, a previously unseen sign flashes:\n
	    \t\"Unauthorized/Illegal Use of Pass Card -- Card Confiscated\"";
	    dobj.moveInto(nil);
	    puzzleRoom.dooropen := true;
	    /* zap steeldoor */
	    puzzleRoom.reachable -= steeldoor;
	    sideRoom.reachable -= steeldoor;
	}
    }
;

goldcard: treasure,readable	// 188
    sdesc = "gold card"
    noun = 'card'
    adjective = 'gold' 'engraved'
    heredesc = "There is a solid gold engraved card here."
    origdesc = "Nestled inside the niche is an engraved gold card."
    ldesc = "\n
\ __________________________________________________________\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ FROBOZZ MAGIC SECURITY SYSTEMS \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ Door Pass \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Royal Zork Puzzle Museum \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ #632-988-496-XTHF \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ USE OF THIS PASS BY UNAUTHORIZED PERSONS OR AFTER \ \ \ \ |\n
| \ EXPIRATION DATE WILL RESULT IN IMMEDIATE CONFISCATION \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (approved) \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Will Weng \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 789 G.U.E.\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ |\n
| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Expires 792 G.U.E.\ |\n
|__________________________________________________________|"
    findscore = 15
    trophyscore = 10
    bulk = 4
    location = puzzleStorage
    puzzleloc = 37
;


steeldoor: floater	// 189
    sdesc = "steel door"
    noun = 'door'
    adjective = 'steel'
    isReachable(actor) = {
	/* we're only accessible in location 52 */
	if (actor.isIn(puzzleRoom) and puzzleRoom.index <> 52)
	    return( nil );
	return(inherited.isReachable( actor ));
    }
    bulk = 5
    verIoPutUnder( a ) = "There is not enough room under this door. "
;

class puzzleWall: wall
    location = puzzleRoom
    verDoPush( actor ) = { } /* do all testing in puzzleRoom.pushwall */
    doPush( actor ) = { puzzleRoom.pushwall(self.offset); }
;

npuzzwall: puzzleWall		// 269
    sdesc = "northern wall"
    noun = 'wall' 'northwall'
    adjective = 'northern'
    offset = -8
;

spuzzwall: puzzleWall		// 270
    sdesc = "southern wall"
    noun = 'wall' 'southwall'
    adjective = 'southern'
    offset = 8
;

epuzzwall: puzzleWall		// 271
    sdesc = "eastern wall"
    noun = 'wall' 'eastwall'
    adjective = 'eastern'
    offset = 1
;

wpuzzwall: puzzleWall		// 272
    sdesc = "western wall"
    noun = 'wall' 'westwall'
    adjective = 'western'
    offset = -1
;

ladder: fixeditem,climbable		// 280
    sdesc = "ladder"
    noun = 'ladder'
    puzzlefixed = true
    verDoClimb(a) =
    {
	if (puzzleRoom.index <> 10)
	    "You hit your head on the ceiling and fall off the ladder.";
    }
;
