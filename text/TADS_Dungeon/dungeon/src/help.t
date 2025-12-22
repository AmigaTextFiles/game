/* lots of text for help/info/etc commands */

helpVerb: sysverb
    verb = 'help'
    action( actor ) = {
	"This is an abbreviated version of what appears as an included
	help file (usually called \"dungeon.doc\").  Please refer to that
	for more details, sample commands, etc.
	\b
	The following commands may prove useful.  They have no side
	effect on the current game, and take no time.
	\b
	\tTERSE: (default) Print short room descriptions for previously\n
	\t\t\tvisited rooms.\n
	\tVERBOSE: Print long room descriptions always.\n
        \tINFO:\tPrints information on what the game is about.\n
        \tHELP:\tPrints this message.\n
        \tQUIT:\tPrints your score, and asks whether you wish to\n
    	\t\t\tcontinue playing.\n
        \tSCORE:\tPrints your score (and deflates your ego).\n
        \tSAVE:\tSaves the current game for future continuation.\n
        \tRESTORE:\tRestores a previous saved game.\n
	\tUNDO:\tBack up a move.  Can be repeated.  Can be abused.\n
	\tSCRIPT:\tStart saving commands and their output to a file.\n
	\tUNSCRIPT:\tTurn off scription.\n
	\b
	These commands will take some fraction of time in the game.
	\b
        \tAGAIN:\tRepeats the last command.  \"G\" is the equivalent.\n
        \tLOOK:\tDescribes the current surroundings; \"L\" is equivalent.\n
	\tINVENTORY:\tPrints a list of your possessions; \"I\" is equivalent.\n
        \tDIAGNOSE:\tPrints your current state of health.\n
        \tWAIT:\tCauses \"time\" to pass.\n
	\b
	Only the first six letters of a command are significant.  The parser
	is sophisticated enough to handle commands such as:
	\b
	\tGET THE RED BALL\n
	\tGET ALL BUT MOUSETRAP\n
	\tPUT ALL TREASURES IN BACK POCKET\n
	\tNORTH.  NORTH.  GET WALLET AND WATCH THEN WEAR WATCH.\n
	\b
	Fighting will be necessary in a few places.  You will need a
	weapon to be effective.  For instance:
	\b
	\tATTACK TAX AGENT WITH ELVISH SWORD\n
	";
    }
;

infoVerb: sysverb
    verb = 'info' 'information'
    action( actor ) =
	"Welcome to Dungeon!
	\b
	\t   You are near a large dungeon, which is reputed to contain vast
	quantities of treasure.   Naturally, you wish to acquire some of it.
	In order to do so, you must of course remove it from the dungeon.  To
	receive full credit for it, you must deposit it safely in the trophy
	case in the living room of the house.
	\b
	\t   In addition to valuables, the dungeon contains various objects
	which may or may not be useful in your attempt to get rich.  You may
	need sources of light, since dungeons are often dark, and weapons,
	since dungeons often have unfriendly things wandering about.  Reading
	material is scattered around the dungeon as well;  some of it
	is rumored to be useful.
	\b
	\t   To determine how successful you have been, a score is kept.
	When you find a valuable object and pick it up, you receive a
	certain number of points, which depends on the difficulty of finding
	the object.  You receive extra points for transporting the treasure
	safely to the living room and placing it in the trophy case.  In
	addition, some particularly interesting rooms have a value associated
	with visiting them.  The only penalty is for getting yourself killed,
	which you may do only twice.
	\b
	\t   Of special note is a thief (always carrying a large bag) who likes
	to wander around in the dungeon (he has never been seen by the light
	of day).  He likes to take things.  Since he steals for pleasure
	rather than profit and is somewhat sadistic, he only takes things which
	you have seen.  Although he prefers valuables, sometimes in his haste
	he may take something which is worthless.  From time to time, he
	examines his take and discards objects which he doesn't like.  He may
	occasionally stop in a room you are visiting, but more often he just
	wanders through and rips you off (he is a skilled pickpocket).
	";
;

historyVerb: sysverb
    verb = 'history'
    action( actor ) =
	"Revision history:
	\b
	03-Jun-94\tFirst TADS version.\n
	Derived from the DECUS Dungeon V3.1A written in FORTRAN (01-Feb-94).\n
	";
;

/* misc */
timeVerb: sysverb
    verb = 'time'
    action( actor ) =
	"You have been playing for <<global.turnsofar>> turns.  For your own
	protection, I won't divulge how much real time you have spent at this.
	However, let me say that if all government employees spent this much
	time daily playing Dungeon, it would be quite an event. "
;
