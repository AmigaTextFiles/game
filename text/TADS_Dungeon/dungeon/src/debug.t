#ifdef __DEBUG

// Rooms we can 'pow' to.

modify livingrm		noun = 'livingrm' ;
modify trollrm		noun = 'trollrm' ;
modify clearing		noun = 'clearing' ;
modify squareRoom	noun = 'puzzle' ;
modify westHouse	noun = 'westHouse' 'start' ;
modify maze5		noun = 'maze5' ;
modify cyclopsRoom	noun = 'cyclopsRoom' ;
modify dustyRoom	noun = 'dustyRoom' ;
modify riddleRoom	noun = 'riddleRoom' ;
modify damBase		noun = 'damBase' ;
modify hades		noun = 'hades' ;
modify slideRoom        noun = 'slideRoom' ;
modify LOUD		noun = 'loud';

whereVerb: sysverb
    verb = 'where'
    sdesc = "where"
    action( actor ) =
	"You can go to:\n
	livingrm\n
	trollrm\n
	clearing\n
	puzzle\n
	westHouse\n
	maze5\n
	cyclopsRoom\n
	dustyRoom\n
	riddleRoom\n
	damBase\n
	hades\n
	slideRoom\n
	loud\n"
    doAction = 'WHERE'
    validDo( actor, obj, seqno ) = { return( true ); }
    validDoList = nil
;

// Take any item without checking too much

snarfVerb: deepverb, darkVerb
  verb = 'snarf'
  sdesc = "snarf"
  doAction = 'Take'
      // Call the normal take method.
  validDo( actor, obj, seqno ) = { return( true ); }
      // Any object is valid, even if it is not visible.
  validDoList = nil
;


powVerb: deepverb, darkVerb
  verb = 'pow'
  sdesc = "pow"
  doAction = 'Pow'
  validDo( actor, obj, seqno ) = { return( true ); }
  validDoList( actor, prep, dobj ) = { return( true ); }
;

modify class thing
  verDoPow( actor ) = { }
  doPow( actor ) =
  {
      if (self.location)
	  self.location.doPow( actor );
      else
	  "\^<<self.thedesc>> isn't in a place... ";
  }
  verDoWHERE(a) = { }
  doWHERE(a) =
  {
      if (self.location <> nil)
	  "\^<<self.thedesc>> is in <<self.location.sdesc>>.\n";
      else
	  "\^<<self.thedesc>> is nowhere.\n";
  }
;

modify class room
  doPow( actor ) =
  {
    if ( actor.location.location )
    {
      actor.location.doUnboard( actor );
    }
    // Make player stand up if seated.

    "%You% %are% engulfed in a cloud of orange smoke.
    Coughing and gasping, %you% emerge%s% from the smoke
    and find that %your% surroundings have changed... \b";

    actor.travelTo( self );
  }
;

/* Misc debugging */
cheatVerb: sysverb
    verb = 'cheat'
    sdesc = "cheat"
    action( actor ) = {
	local act;
	"\n: ";
	act := lower(input());
	if (act = 'egg') {
	    egg.isopen := true;
	    "Egg is now open. ";
	} else if (act = 'endgame') {
	    crypt.startend3;
	} else if (act = 'exorcise') {
	    actor.travelTo( hades ); "\b";
	    hades.ring_bell; "\b";
	    hades.light_candles;
	    hades.read_book;
	} else if (act = 'mirror') {
	    local n;
	    "Angle: <<inMirror.angle>>; new angle: ";
	    n := cvtnum(input());
	    inMirror.angle := n;
	} else if (act = 'mirrorn') {
	    if (inMirror.loc.hallnorth)
		inMirror.loc := inMirror.loc.hallnorth;
	} else if (act = 'mirrors') {
	    if (inMirror.loc.hallsouth)
		inMirror.loc := inMirror.loc.hallsouth;
	} else {
	    "Unknown cheat option. ";
	}
    }
;

scoresVerb: sysverb
    verb = 'scores'
    action( a ) =
    {
	local obscr, rmscr;
	local eg_obscr, eg_rmscr;
	local o;
	o := firstobj();
	obscr := rmscr := eg_obscr := eg_rmscr := 0;
	while ( o ) {
	    local os, rs;
	    os := rs := 0;
	    if (o <> brokencanary and o <> brokenegg) {
		if (defined(o, &findscore))
		    os += o.findscore;
		if (defined(o, &trophyscore))
		    os += o.trophyscore;
		if (defined(o, &scoreval))
		    rs := o.scoreval;
		if (isclass(o,endroom) || o = crypt) {
		    eg_obscr += os;
		    eg_rmscr += rs;
		} else {
		    obscr += os;
		    rmscr += rs;
		}
	    }
	    o := nextobj(o);
	}
	"Objects:\t<<obscr>>\nRooms:\t\t<<rmscr>>\b";
	"Endgame,\n\tObjects:\t<<eg_obscr>>\n\tRooms:\t\t<<eg_rmscr>>\n";
	"plus:  10 points for bringing light to shaft.\n";
    }
;

#endif /* debug */
