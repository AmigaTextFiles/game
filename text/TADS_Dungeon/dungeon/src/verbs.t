modify withPrep
    preposition = 'using'
;

modify lookVerb
    doAction = 'Inspect'

;
modify lookThruVerb
    /* Do this instead of 'Lookthru', since we want a synonym in all
     * cases (plus it's confusing with 'LookThru' below)
     */
    doAction = 'Lookin'
;

modify inspectVerb
    ioAction( thruPrep ) = 'LookThru'
    ioAction( withPrep ) = 'LookThru'
;
modify readVerb
    ioAction( thruPrep ) = 'ReadThru'
    ioAction( withPrep ) = 'ReadThru'
;

modify yellVerb
    replace action( actor ) = "Aaaarrrrrrgggggggghhhhhhhhhh!\n"
;
	
/* has ioaction and some more synonyms */
replace breakVerb: deepverb
    verb = 'break' 'ruin' 'destroy' 'damage' 'mung'
    sdesc = "break"
    doAction = 'Break'
    ioAction( withPrep ) = 'BreakWith'
;

replace sleepVerb: deepverb
    verb = 'sleep'
    action( actor ) = "What, am I boring %youm%?"
;
/* sigh... it's never called, except by the OLD sleepVerb.action... */
goToSleep: function { }

modify iVerb
    action( actor ) =
    {
	if (itemcnt( actor.contents ))
	{
	    "%You% %are% carrying:\n";
	    listcont( actor );
	    listcontcont( actor );
	}
	else
	    "%You% %are% empty-handed.\n";
    }
;

modify turnOnVerb
    ioAction( withPrep ) = 'TurnonWith'
;

modify climbVerb
    verb = 'climb up'
;

modify openVerb
    ioAction( withPrep ) = 'OpenWith'
;

/* Alias for 'turn on', 'burn with'.
 * Hack, since using doSynonyms with this was causing headaches. */
lightVerb: deepverb, darkVerb
    verb = 'light'
    sdesc = "light"
    doAction = 'Turnon'
    ioAction( withPrep ) = 'BurnWith'
;

/* alias for 'turn off' */
extinguishVerb: deepverb
    verb = 'extinguish' 'douse'
    sdesc = "extinguish"
    doAction = 'Turnoff'
;

burnVerb: deepverb, darkVerb
    verb = 'burn' 'ignite' 'incinerate'
    sdesc = "burn"
    prepDefault = withPrep
    ioAction( withPrep ) = 'BurnWith'
;

sendforVerb: deepverb
    validDo( actor, obj, seqno ) =
    {
	return( inherited.validDo( actor, obj, seqno ) or obj = brochure );
    }
    validDoList( actor, prep, iobj ) =
    {
	return( inherited.validDoList( actor, prep, iobj ) + [brochure] );
    }
    verb = 'send for'
    sdesc = "send for"
    doAction = 'Sendfor'
;

findVerb: deepverb
    verb = 'find' 'where is' 'seek'
    sdesc = "find"
    validDo( actor, obj, seqno ) =
    {
        return( obj.isVisible( actor ));
    }
    doAction = 'Find'
;

fillVerb: deepverb
    verb = 'fill'
    sdesc = "fill"
    prepDefault = withPrep
    ioAction( withPrep ) = 'FillWith'
    /* sigh, no ioDefault - would be nice so we could do "fill bottle" */
;

pourVerb: deepverb
    verb = 'pour' 'spill'
    sdesc = "pour"
    doAction = 'Pour'
    ioAction( inPrep ) = 'PourIn'
    ioAction( thruPrep ) = 'PourIn'
    ioAction( onPrep ) = 'PourOn'
;

/* used so that sendForVerb will parse */
forPrep: Prep
    preposition = 'for'
    sdesc = "for"
;

tieVerb: deepverb
    verb = 'tie' 'fasten'
    sdesc = "tie"
    prepDefault = toPrep
    ioAction( toPrep ) = 'TieTo'
    ioAction( withPrep ) = 'TieWith'
;

untieVerb: deepverb
  verb = 'untie' 'free' 'unfasten'
    sdesc = "untie"
    doAction = 'Untie'
    ioAction( fromPrep ) = 'UntieFrom'
;

liftVerb: deepverb
    verb = 'lift' 'lift up' 'raise'
    sdesc = "lift"
    doAction = 'Lift'
;

lowerVerb: deepverb
    verb = 'lower'
    sdesc = "lower"
    doAction = 'Lower'
;

climbdownVerb: deepverb
    verb = 'climb down'
    preposition = 'down'
    sdesc = "climb down"
    doAction = 'Climbdown'
;

windVerb: deepverb
    verb = 'wind' 'wind up'
    sdesc = "wind"
    doAction = 'Wind'
;

compoundWord 'what' 'is' 'whatis';
modify inspectVerb
    verb = 'whatis'
;

modify helloVerb
    action( actor ) = "Hello. "
    doAction = 'Hello'
;

modify attackVerb
    verb = 'stab' 'slay'
;

wakeVerb: deepverb
    verb = 'wake' 'wake up' 'startle' 'surprise'
    sdesc = "wake up"
    doAction = 'Wakeup'
;

kickVerb: deepverb
    verb = 'kick'
    sdesc = "kick"
    doAction = 'Kick'
;

walkVerb: deepverb
    verb = 'walk through' 'walk thru' 'walk into' 'walk inside'
    verb = 'go through' 'go thru' 'go into' 'go inside'
    sdesc = "walk through"
    doAction = 'Enter'
;

modify touchVerb
    verb = 'rub' 'feel' 'caress' 'fondle'
;

modify putVerb
    verb = 'insert'
    ioAction( underPrep ) = 'PutUnder'
;

modify sayVerb
    verb = 'answer' 'respond'
    action( a ) = "No one seems to be listening. "
;

modify plugVerb
    prepDefault = withPrep
    ioAction( withPrep ) = 'PlugWith'
;
patchVerb: deepverb
    verb = 'patch' 'glue'
    sdesc = "patch"
    prepDefault = withPrep
    ioAction( withPrep ) = 'PlugWith'
;

disembarkVerb: deepverb
    verb = 'disembark'
    sdesc = "disembark"
    doAction = 'Disembark'	/* used only as synonym for Unboard */
;

launchVerb: deepverb
    verb = 'launch'
    sdesc = "launch"
    doAction = 'Launch'
    doDefault(a, p, i) = ( inherited.doDefault(a, p, i) + a.location )
;
landVerb: deepverb
    verb = 'land'
    sdesc = "land"
    doAction = 'Land'
    doDefault(a, p, i) = ( inherited.doDefault(a, p, i) + a.location )
;

oilVerb: deepverb
    verb = 'oil' 'grease' 'lubricate'
    sdesc = "oil"
    prepDefault = withPrep
    ioAction( withPrep ) = 'OilWith'
;

squeezeVerb: deepverb
    verb = 'squeeze'
    sdesc = "squeeze"
    doAction = 'Squeeze'
;

inflateVerb: deepverb
    verb = 'inflate' 'blow up' 'pump up'
    sdesc = "inflate"
    prepDefault = withPrep
    ioAction( withPrep ) = 'InflateWith'
;
deflateVerb: deepverb
    verb = 'deflate'
    sdesc = "deflate"
    doAction = 'Deflate'
;

waveVerb: deepverb
    verb = 'wave' 'flaunt' 'brandish'
    sdesc = "wave"
    doAction = 'Wave'
;

meltVerb: deepverb
    verb = 'melt'
    sdesc = "melt"
    prepDefault = withPrep
    ioAction( withPrep ) = 'MeltWith'
;

ringVerb: deepverb
    verb = 'ring' 'peal'
    sdesc = "ring"
    doAction = 'Ring'
    ioAction( withPrep ) = 'RingWith'
;

exorciseVerb: deepverb
    verb = 'exorcise'
    sdesc = "exorcise"
    doAction = 'Exorcise'
;

modify jumpVerb
    verb = 'leap'
    action( a ) =
    {
	// Hmm, this should check for a 'down' exit, which is sometimes fatal.
	switch(rand(3)) {
	case 1: "Have you tried hopping around the dungeon, too? "; break;
	case 2: "Are you enjoying yourself? "; break;
	case 3: "Wheeeeee! "; break;
	}
    }
;

modify flipVerb
    ioAction( withPrep ) = 'TurnonWith' /* for machineswitch */
;

/* should be a darkverb, so we can wait around in the dark crypt */
replace waitVerb: deepverb, darkVerb
    verb = 'wait' 'z'
    action( actor ) =
    {
        "Time passes...\n";
    }
;

knockVerb: deepverb
    verb = 'knock' 'rap' 'knock on' 'rap on'
    sdesc = "knock on"
    doAction = 'Knock'
;

modify followVerb
    action( actor ) = "Ok. "
;
stayVerb: deepverb
    verb = 'stay'
    action( actor ) = "You would be lost without me. "
;

slideverb: deepverb
    verb = 'slide'
    sdesc = "slide"
    prepDefault = underPrep
    ioAction( underPrep ) = 'PutUnder'
;

/*
 * Magic words.
 */

class magicVerb: deepverb, darkVerb
    action( a ) = "Nothing happens.\n" /* default action */
;

templeVerb: magicVerb
    verb = 'temple'
;

treasureVerb: magicVerb
    verb = 'treasure'
;

incantVerb: magicVerb
    verb = 'incant'
    sdesc = "incant"
    action( a ) = "That incantation seems to have been a failure. "
    doAction = 'Incant'
;

shakeVerb: deepverb
    verb = 'shake'
    sdesc = "shake"
    doAction = 'Shake'
;

modify cleanVerb
    verb = 'brush'
;

playverb: deepverb
    verb = 'play'
    sdesc = "play"
    doAction = 'Play'
    ioAction( withPrep ) = 'PlayWith'
;

smellVerb: deepverb
    verb = 'smell' 'sniff'
    sdesc = "smell"
    doAction = 'Smell'
;

/*
 * Game options
 */

notifyVerb: sysverb
    verb = 'notify'
    action( actor ) =
    {
	global.showscore := not global.showscore;
	if (global.showscore)
	    "You will not be notified when your score changes.\n";
	else
	    "Score notification off.\n";
	abort;
    }
;

diemodeVerb: sysverb
    verb = 'diemode'
    action( actor ) =
    {
	global.complex_death := not global.complex_death;
	if (global.complex_death)
	    "Now using Dungeon-style death.\n";
	else
	    "Now using TADS-style death.\n";
	abort;
    }
;

/* Misc joke verbs and stuff.  Some may have real uses somewhere. */

mumbleVerb: deepverb
    verb = 'mumble' 'sigh'
    action( actor ) = "You'll have to speak up if you expect me to hear you. "
;
loseVerb: deepverb
    verb = 'lose' 'chomp' 'barf'
    action( actor ) = "I don't know how to do that.  I win in all cases. "
;
dungeonVerb: deepverb
    verb = 'dungeon'
    action( actor ) = "At your service! "
;
frobozzVerb: deepverb
    verb = 'frobozz'
    action( actor ) =
	"The Frobozz Company, Ltd., created, owns, and operates this dungeon. "
;
fooVerb: deepverb
    verb = 'foo' 'bletch' 'bar'
    action( actor ) = "Well, FOO, BAR, and BLETCH to you too! "
;
repentVerb: deepverb
    verb = 'repent'
    action( actor ) = "It could very well be too late. "
;
hoursVerb: deepverb
    verb = 'hours' 'schedule'
    action( actor ) = "The dungeon is ALWAYS open (always room for one more). "
;

winVerb: deepverb
    verb = 'win'
    action( actor ) = "Naturally! "
;
curseVerb: deepverb
    verb = 'curse' 'shit' 'damn' 'fuck'
    action( actor ) =
    {
	switch(rand(5)) {
	case 1: "Such language in a high-class establishment like this! ";
		break;
	case 2: "You ought to be ashamed of yourself. "; break;
	case 3: " It's not so bad.  You could have been killed already. ";
		break;
	case 4: "Tough shit, asshole. "; break;
	case 5: "Oh, dear.  Such language from a supposedly winning
		adventurer! ";
		break;
	}
    }
;
zorkVerb: deepverb
    verb = 'zork'
    action( actor ) = "That word is henceforth replaced with DUNGEON. "
;
xyzzyVerb: deepverb
    verb = 'xyzzy' 'plugh'
    action( a ) = "A hollow voice says, \"Cretin.\"\n"
;
odysseusVerb: deepverb		/* makes no sense in dark */
    verb = 'odysseus' 'ulysses'
    action( a ) = "Wasn't he a sailor? "
;
geronimoVerb: magicVerb
    verb = 'geronimo'
    action( a ) = "Wasn't he an Indian? "
;
prayVerb: magicVerb
    verb = 'pray'
    action( actor ) = "If you pray enough, your prayers may be answered. "
;

swimVerb: deepverb
    verb = 'swim' 'bathe' 'wade'
    action( actor ) =
    {
	if (actor.location.iswater or actor.location.canfill)
	    "Swimming is not allowed in this dungeon. ";
	else switch(rand(3)) {
	case 1: "I don't really see how. "; break;
	case 2: "I think that swimming is best performed in water. "; break;
	case 3: "Perhaps it is your head that is swimming. "; break;
	}
    }
;
blastVerb: deepverb
    verb = 'blast'
    sdesc = "blast"
    action( actor ) = "I don't really know how to do that. "
    doAction = 'Blast'
;
wishVerb: magicVerb
    verb = 'wish'
    action( actor ) =
    {
	if (actor.location = circularRoom) {
	    local o;
	    if (coins.isIn(circularRoom))
		o := coins;
	    else if (zorkmid.isIn(circularRoom))
		o := zorkmid;
	    if (o <> nil) {
		o.moveInto(nil);
		"A whispering voice replies, \"Water makes the bucket go.\" ";
		return;
	    }
	}
	"No one is listening. ";
    }
;
makeVerb: deepverb
    verb = 'make'
    sdesc = "make"
    action( actor ) = "make: 'dungeon.gam' is up to date. "
    doAction = 'Make'
;
bugVerb: deepverb
    verb = 'bug' 'gripe' 'comment' 'feature' 'idea'
    action( actor ) =
	"Send bugs, complaints, or zorkmids to: <<version.contact>> "
;

/* verbs used on the river */
upstreamVerb: travelVerb
    verb = 'upstream'
    travelDir( actor ) = { return( actor.location.up(actor) ); }
    // only work if we're on water
    action ( actor ) =
    {
        if ( actor.location.iswater or
              ( actor.location.isvehicle and actor.location.location.iswater ) )
	    pass action;
	else
	    "You can't do that.  ";
    }
;
downstreamVerb: upstreamVerb
    verb = 'downstream'
    travelDir( actor ) = { return( actor.location.down(actor) ); }
;
