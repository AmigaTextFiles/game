class TESTVERB: deepverb
    validDo( actor, obj, seqno ) = { return true; }
    validDoList(actor, prep, iobj) = { return nil; }
;

/*
 * OTHER VERBS
 */

pickVerb: deepverb
	verb = 'pick' 'gather'
	sdesc = "pick"
	doAction = 'Pick'
;

sitatVerb: deepverb
    verb = 'sit at' 'sit downat'
    sdesc = "sit at"
    doAction = 'Sitat'
;

drinkVerb: deepverb
	verb = 'drink' 'sip' 'quaff' 'swallow'
	sdesc = "drink"
	ioAction(fromPrep) = 'DrinkFrom'
	doAction = 'Drink'
	prepDefault = fromPrep
;

emptyVerb: deepverb
	verb = 'pour out' 'empty out' 'empty' 'pour'
	sdesc = "empty out"
	doAction = 'Empty'
	ioAction(fromPrep) = 'EmptyFrom'
	ioAction(inPrep) = 'EmptyInto'
	ioAction(onPrep) = 'EmptyInto'
	prepDefault = fromPrep
;

fillVerb: deepverb
	verb = 'fill'
	sdesc = "fill"
	ioAction(withPrep) = 'FillWith'
	prepDefault = withPrep
;

smellVerb: deepverb
	sdesc = "smell"
	verb = 'smell' 'sniff' 'waft'
	doAction = 'Smell'
;

rubVerb: deepverb
	sdesc = "rub"
	verb = 'rub' 'caress' 'fondle' 'pat' 'pet' 'hug' 'cuddle' 'squeeze'
	doAction = 'Rub'
;

lightVerb: deepverb
	sdesc = "light"
	verb = 'light'
	doAction = 'Light'
;

callVerb: deepverb
	verb = 'call' 'dial'
	sdesc = "call"
	ioAction( onPrep ) = 'CallOn'
	ioDefault(actor, onPrep) = {
		if ( actor.isCarrying(telephone) or telephone.isIn( actor.location ))
			 return([ telephone ]);
		else return(nil);
	}
	prepDefault = onPrep
;

sprayVerb: deepverb
	verb = 'spray' 'spritz'
	sdesc = "spray"
	ioAction( onPrep ) = 'SprayOn'
	ioAction( atPrep ) = 'SprayOn'
	ioAction( withPrep ) = 'SprayWith'
	prepDefault = withPrep
;

tmsxtVerb: deepverb
	verb = 'tmsxt'
	sdesc = "tmsxt"
	action(actor) = {
		"In a flash of light, you are transformed! <<note(phonology_paper)>>\n";
	}
;

flyVerb: deepverb
	verb = 'fly'
	sdesc = "fly"
	doAction = 'Fly'
	action(actor) = {
		 "Don't you wish.  Flying.  Ha- wait until you graduate at least.\n";
	}
;

lambdaVerb: deepverb
	verb = 'lambda'
	sdesc = "lambda"
	action(actor) = {
			"Thou vilest of curs!  Utter not the Lambda until
			thou understandest its powers!\n";
	}
;

thinkVerb: deepverb
	verb = 'think'
	sdesc = "think"
	action(actor) = {
		if (not self.hasthought) {
			"After thinking hard, you have an idea.";
			changescore(2);
			youridea.moveInto(Me);
			self.hasthought := true;
		}
		else
			"Thinking any more makes your head hurt.";
	}

	hasthought = nil;
;

joinVerb: deepverb
	verb = 'join' 'connect'
	sdesc = "join"
	ioAction(toPrep) = 'JoinTo'
	prepDefault = toPrep
;

raiseVerb: deepverb
	verb = 'raise' 'put up' 'lift'
	sdesc = "raise"
	doAction = 'Raise'
;

jumpVerb: deepverb
	verb = 'jump' 'jump over' 'jump off'
	sdesc = "jump"
	doAction = 'Jump'
	action(actor) = {
		if (actor.location <> loft)
			"Wheeee!";
		else if (haystack.location = barn)
			haystack.doJumpInto(actor);
		else {
			"You foolishly try to jump down more than 15 feet,
			hit your head on the chicken pen, and die a mercifully
			quick death.\b";
			die();
		}
	}
;

jumpIntoVerb: deepverb
	verb = 'jump into' 'jump in'
	sdesc = "jump into"
	doAction = 'JumpInto'
	validDo( actor, obj, seqno ) = {
	        return( obj.isVisible( actor ));
	}
;

shootVerb: deepverb
	verb = 'shoot' 'fire' 'launch'
	sdesc = "shoot"
	ioAction(withPrep) = 'ShootWith'
	prepDefault = withPrep		
;
puttVerb: deepverb
	verb = 'putt'
	sdesc = "putt"
	ioAction(withPrep) = 'PuttWith'
	prepDefault = withPrep
;
swingVerb: deepverb
	verb = 'swing'
	sdesc = "swing"
	ioAction(atPrep) = 'SwingAt'
	prepDefault = atPrep
	doAction = 'Swing'
	action(actor) = { "\nand a miss.\n"; }
;
kissVerb: deepverb
	verb = 'kiss' 'smooch'
	sdesc = "kiss"
	doAction = 'Kiss'
;

profaneVerb: deepverb
    sdesc = "<CENSORED>"
    verb = 'shit' 'crap' 'damn' 'hell' 'fuck'
    action(actor) = { "Now, now - there's no need for such language. "; }
;

destroyVerb: deepverb
	sdesc = "destroy"
	verb = 'damage' 'break' 'destroy' 'smash' 'rip' 'tear'
	doAction = 'Destroy'
;

knockVerb: deepverb
	sdesc = "knock on"
	verb = 'knock' 'rap' 'tap' 'knock on' 'rap on' 'tap on'
	doAction = 'Knock'
;

popVerb: deepverb
	sdesc = "pop"
	verb = 'pop'
	doAction = 'Pop'
;

feedVerb: deepverb
	sdesc = "feed"
	verb = 'feed'
	ioAction(toPrep) = 'FeedTo'
	prepDefault = toPrep
;

xyzzyVerb: deepverb
	sdesc = "xyzzy"
	verb = 'xyzzy'
	action(actor) = {
		"You speak an ancient word of power.  It starts raining.
		Then it stops.";
	}
;

plughVerb: deepverb
	sdesc = "plugh"
	verb = 'plugh'
	action(actor) = {
		"You speak an ancient word of power.  It starts snowing.
		Then it stops.";
	}
;

abraVerb: deepverb
	sdesc = "abracadabra"
	verb = 'abracadabra'
	action(actor) = {
		"You speak an ancient word of power.  It starts hailing.
		Then it stops.";
	}
;

ploverVerb: deepverb
	sdesc = "plover"
	verb = 'plover'
	action(actor) = {
		if ( self.done = true )
			"A hollow voice intones \"No eggs today. Try again tomorrow.\"";
		else {
			"Suddenly, a plover's egg drops at your feet!  Then, just
			as unexpectedly, a short, wizened monk appears and snatches
	        	up the egg.  \"If cooked it be, it's dam tastee,\" he mutters
			before vanishing in a puff of smoke. ";
			note(self);
			self.done := true;
	        };
	}
	footnote = { "Oooh, he's the kuulest!"; }
;

/*
 * Preps
 */

forPrep: Prep
    preposition = 'for'
    sdesc = "for"
;
