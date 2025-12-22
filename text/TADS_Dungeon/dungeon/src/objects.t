//
// These are "globals".  Might appear in any room.  Generally just
// to keep appearances up, or to provide an object for some commands
// (ie, 'make wish').
//

sailor: floater		// 255
    sdesc = "sailor"
    noun = 'sailor'
    isReachable( actor ) = true

    hellocnt = 0
    verDoHello( actor ) =
    {
	hellocnt++;
	if (hellocnt = 20) {
	    "You seem to be repeating yourself. ";
	    hellocnt := 0;
	}
	else if (hellocnt = 10)
	    "I think that phrase is getting a bit worn out. ";
	else
	    "Nothing happens here. ";
    }
;

teeth: floater		// 256
    sdesc = "set of teeth"
    noun = 'teeth'
    isReachable( actor ) = true

    verDoClean( actor ) = {}
    doClean( actor ) =
	"Dental hygiene is highly recommended, but I'm not sure what
	you want to brush them with. "
    verDoCleanWith( actor, io ) = { }
    doCleanWith( actor, io ) =
    {
	if (io = gunk) {
	    "Well, you seem to have been brushing your teeth with some sort of
	    glue.  As a result, your mouth gets glued together with your nose,
	    and you die of respiratory failure. ";
	    actor.died;
	} else {
	    "Blech. ";
	}
    }
;

genwall: wall,floatingItem	// 257
    sdesc = "walls"
    noun = 'walls' 'wall'
    ishere(loc) = ( isclass(loc,room) and not loc.nowalls )
    isReachable( actor ) = ( self.ishere( actor.location ) )
    isVisible( actor ) = ( self.ishere( toplocation(actor) ) )

    verDoPush( actor ) =
    {
	if (not global.endgame or actor.location.mirrorHere <> 0)
	    pass verDoPush;
    }
    doPush( actor ) = "The structure won't budge. "
;

grue: floater		// 258
    sdesc = "lurking grue"
    ldesc =
	"The grue is a sinister, lurking presence in the dark places of the
	earth.  Its favorite diet is adventurers, but its insatiable
	appetite is tempered by its fear of light.  No grue has ever been
	seen by the light of day, and few have survived its fearsome jaws
	to tell the tale. "
    noun = 'grue'
    adjective = 'lurking'
    isReachable( actor ) = true
    verDoFind( actor ) =
	"There is no grue here, but I'm sure there is at least one lurking in
	the darkness nearby.  I wouldn't let my light go out if I were you! "
;

hands: floater		// 259
    sdesc = "pair of hands"
    noun = 'hand' 'hands'
    adjective = 'bare'
    istool = true
    isReachable( actor ) = true
;

air: floater		// 260
    sdesc = "breath"
    noun = 'lungs' 'air'
    isReachable( actor ) = true
    
    verIoInflateWith( a ) ="You don't have enough lung power to inflate it. "
;

flyer: floater		// 261
    sdesc = "flyer"
    noun = 'aviator' 'flyer'
    isReachable( actor ) = true

    verDoHello( actor ) = "Here, nothing happens. "
;

wish: floater		// 263
    sdesc = "wish"
    noun = 'wish'
    isReachable( actor ) = true
    
    verDoMake( actor ) = { }
    doMake( actor ) = ( wishVerb.action( actor ) )
;

modify theFloor
    noun = 'earth'
    verDoDigWith( actor, io ) =
    {
	if (actor.location <> sandyBeach)
	    "Your shovel cannot dig into the ground here. ";
	else
	    beach.verDoDigWith( actor, io );
    }
    doDigWith( actor, io ) = ( beach.doDigWith( actor, io ) )
;

/* semi-global */

genwater: floater,water,transparentItem	// 273
    sdesc = "water"
    adesc = ( self.sdesc )
    noun = 'water' 'quantity' 'liquid' 'h2o'
    
    verDoPutIn( actor, io ) = { water.verDoPutIn( actor, io ); }

    /* we're in all iswater and canfill rooms */
    isReachable( actor ) =
    {
	local loc;
	loc := toplocation(actor);
	return( loc.iswater or loc.canfill );
    }
;
