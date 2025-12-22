/*
 * Me
 */

Me: basicMe, ourthing
	noun = 'Kluuless' 'self' 'me'
	maxweight = 30
	maxbulk = 30

	hurt1 = {
		"\bUuungh!  A pain is wracking your abdomen.";
	}
	hurt2 = {
		"\bAaaaauugh!  I don't think you're going to make it, unless you can
		do something to quell the pain in your belly soon.";
	}
	dieNow = {
		"\b\bAs your stomach disolves, you realize that you ate something
		you probably shouldn't have...";
		die();
	}

	ldesc = "You are an unimpressive looking young student, hair poorly parted and
		kept out of the duct tape on your glasses only by its own stickiness.
		Certainly you'll never win any beauty contests, but perhaps there's
		something in you that your exterior belies.  Probably not, though."


    verIoSprayOn(actor) = { "Ooh.  That would be messy.  Perhaps 
			     you'd better not.\n"; }
    verDoSprayWith(actor, iobj) = { "Ooh.  That would be messy.  Perhaps 
			     you'd better not.\n"; }
;

/*
 * NPCs
 */

philosophers: ourdecoration, messagingnpc, activenpc, pluralnpc, person
	sdesc = "dining philosophers"
	adesc = { self.sdesc; }
	saydesc = "a philosopher"
	ldesc = {
		if (self.aredeadlocked)
			"The philosophers are ignoring their food for the moment,
			deadlocked over whose forks and knives are whose.  It seems
			that some of these great thinkers have decided to pick up
			their fork first, and others their knife, and the shortage
			of both has resulted in chaos.  None can eat until they
			get both utensils, but since each has only one implement and can't
			convince another colleague to give up his, all are starving.
			The only reason an all-out fight hasn't begun is that each
			is too protective of their tool to budge an inch.";
		else
			"The philosophers seem to be short of utensils, and are
			taking turns releasing and acquiring knives and forks as
			they eat.  The general atmosphere seems to be one of guarded,
			grudging cooperation.";
	}
	noun = 'philosophers' 'philosopher'
	adjective = 'dining' '12'
	location = diningroom

	aredeadlocked = true

	ioGiveTo(actor, dobj) = {
		if (dobj = fork) {
			"A philosopher who already
			had a knife leaps for the fork, grabs it, and immediately starts
			gorging himself on the ham.  Within seconds the rest begin
			arguing about
			whether assymetry is repugnant to reason and whether an assymetric
			universe in which one eats and another doesn't is a refutation of the
			very concept of divine right...";

			philosophers.aredeadlocked := nil;
			dobj.moveInto(self);

      			changescore(7);
		}
		else {
			"The philosophers are too busy fighting with each other to
			pay any attention to your gift.  It falls to the floor.";
			dobj.moveInto(actor.location);
		}
	}

;

marvin: messagingnpc, movingnpc, named, person
	sdesc = "Marvin Minsky"
	ldesc = "Marvin Minsky looks remarkably similar to the picture on the dustjacket
		of that New York Times runner-up \"The Turing Option\"."
	noun = 'marvin' 'minsky'
	adjective = 'marvin'

 	cycle = [ 0-5 garden_entrance 2 &east 1 &north
 		1 &north 1 &east 1 &north 1 &sw 1 &south 1 &east 1
 		&west 1 &south 1 &west 1 nil ]

	messageN = 1
	messageD = 2

	compute(actor) = {
		if (self.location <> nil and youridea.isVisible(self)) {
			if (actor.isVisible(self))
				"\n\^<<self.saydesc>> mentions \"I knew a good idea;
				a good idea was a friend of mine; and that, sir, is
				no good idea.\".\n";
			badidea.moveInto(youridea.location);
			youridea.moveInto(nil);
			changescore(-2);
		}
	}

;

graphtheorist1: messagingnpc, movingnpc, named, person, male
	sdesc = "Hoch"
	ldesc = "Hoch looks like one of those theory types.  Sinister, sort of."
	noun = 'hoch'

	location = lecturehall
	cycle = [ 1 &west 1 &sw 1 nil 4 south_courtyard 2 &north 2 &north 3
		&nw 2 &se 1 &south 3 &nw 1 &west 2 &east 1
		&se 1 nil 0-5 north_courtyard 2 &east 1 &north 2 &east ]

	messageD = 3
;

graphtheorist2: messagingnpc, followingnpc, named, person, male
	sdesc = "Konigsberg"
	ldesc = "Konigsberg is disheveled enough to be a graduate student, probably
		from the Acme Institute's disreputable mathematics department.  His
		T-shirt says \"Burn the Bridges!\""
	noun = 'konigsberg'

	leader = graphtheorist1

	location = lecturehall

	messageD = 3

	foundboard = nil

	compute(actor) = {
		// If there is a whiteboard here, write useful stuff on
		// the board.
	    	local i, lst, len, obj, board;
		board := nil;

		if (self.foundboard = nil and self.location <> nil) {
			lst := self.location.contents;
			len := length(lst);
			for (i := 1 ; i <= len ; ++i) {
				obj := lst[i];
				if (isclass(obj,whiteboard) and obj.isclean)
					board := obj;
			}
		}
		if (board <> nil) {
			if (self.isVisible(Me))
				"\bHoch shouts \"A clean whiteboard!  My god, we're saved!\"
				and starts furiously scribbling on the whiteboard as he
				relates to Konigsberg an intricate theory of Klein mazes
				and strange attractors.  Tossed in the discussion
				you hear bits about Fibonacci distances, Whitehead disjuncts,
				the institute's garden, and other topics you would presumably
				learn about if you were ever admitted into the prestigious
				graduate program in the Less-Convincing Sciences.\b

				Lost to the world for the moment, Hoch and Konigsberg seem
				to rejoice in their newfound writing space.\n";

			graphtheorist1.msg := true;
			graphtheorist2.msg := true;

			board.writing :=
				'The whiteboard is almost covered again in graphs, with scrawls
				about Wigner spinors, drunken walks, Fibonacci distances,
				von Neumann archipelagos, cold fusion and psychometrics. 
				The most comprehensible portion of the board seems to be a
				section discussing directed graphs and emphasizing the
				directional sequence West, South, West, South, West, North.';
			board.isclean := nil;
			changescore(6);
			self.foundboard := true;
		}
	}
;

robot: inactivenpc, npc, messagingnpc, uninterestednpc
	sdesc = { say(self.states[self.statenumber]); " robot"; }
	ldesc = {
		"The robot is small and dumpy, but looks pretty strong.  A logo
		on the side reads \"Turing Machine Repair Company\", the only
		reputable company that still ships to Unnkulia.
		There is a small slot in its side, which ";
		if (self.myplanner = nil) "is empty. ";
		else "currently contains <<self.myplanner.adesc>>. ";
		if (self.myplanner = nil)
			"The robot is immobile, apparently confused. ";
		else
			"The robot seems to be playing with the blocks. ";
	}
	noun = 'robot'
	adjective = 'cheerful' 'mirthy' 'happy' 'ambivalent' 'perturbed' 'sad' 'dejected'
			'depressed' 'suicidal'
	location = bananaplace

	statenumber = 1
	states = [ 'cheerful' 'mirthy' 'happy' 'ambivalent' 'perturbed' 'sad' 'dejected'
			'depressed' 'despondant' 'suicidal' ]
	incstate = {
		if (self.statenumber < length(self.states))
			self.statenumber += 1;
	}
	messageD = 2

	contents = [ robot_slot ]

	myplanner = {
		if (robot_slot.contents = [])
			return nil;
		return robot_slot.contents[1];
	}

	compute(actor) = {
		local source, dest, sourcelist, destlist;

		/* If the blocks are unstable, they always come crashing down. */
		if (blocks.height = 3 and (blockR.isunstable or blockS.isunstable or
						blockT.isunstable)) {
			self.incstate;
			"\bThe blocks come crashing down just as <<self.thedesc>> gets out of
			the way.\n";
			blockR.putOn(self, theFloor, nil);
			blockS.putOn(self, theFloor, nil);
			blockT.putOn(self, theFloor, nil);
			return;
		}
		/* If there is no planner, the robot can not function. */
		if (self.myplanner = nil) {
			self.msg := true;
			return;
		}

		/* Computer possible things to move. */
		sourcelist := [];
		if (blockR.isclear) sourcelist += blockR;
		if (blockS.isclear) sourcelist += blockS;
		if (blockT.isclear) sourcelist += blockT;

		/* If there is nothing we can move, express message. */
		if (sourcelist = []) {
			self.msg := robot_happymsg;
			return;
		}

		/* Compute possible blocks to move. */
	
		source := nil;

		if (self.myplanner = nonlinear_planner) {
			/* First, try to clear R. */
			if (blockS.ison = blockR and blockS.isclear) {
				source := blockS; dest := theFloor; }
			else if (blockT.ison = blockR and blockT.isclear) {
				source := blockT; dest := theFloor; }
			/* And try to clear S. */
			else if (blockT.ison = blockS and blockT.isclear) {
				source := blockT; dest := theFloor; }
			else if (blockR.ison = blockS and blockR.isclear) {
				source := blockR; dest := theFloor; }
			/* And try to clear T. */
			else if (blockR.ison = blockT and blockR.isclear) {
				source := blockR;
				if (blockS.ison = blockT) dest := blockS;
				else dest := theFloor;
			}
			/* Then try to put S on T. */
			else if (blockS.ison <> blockT and blockS.isclear) {
				source := blockS; dest := blockT; }
			/* Then try to put R on S. */
			else if (blockR.ison <> blockS and blockR.isclear) {
				source := blockR; dest := blockS; }
		}

		/* If dumb, or if intelligent algorithm was blocked, try random things. */
		if (source = nil) {

			source := randomelement(sourcelist);
			destlist := ((blocks.allblocks + theFloor) - source) - source.ison;

			/* Do not actually solve puzzle if dumb. */
			if (blockS.ison = blockT and source = blockR)
				destlist -= blockS;

			dest := randomelement(destlist);
		}

		source.putOn(self, dest, true);
		if (blockR.ison = blockS and blockS.ison = blockT) {
			"\bThe robots steps back and looks at the structure it
			has created in absolute amazement.  For 25 years it has been
			working on this problem, and it doesn't know why.  And now
			it's solved it.  What else is there for it to do in this
			world?\b

			The cheerful robot decides to make other parts of the world a
			better place, by building block structures for humanity,
			and heads off into the woods singing to itself...\b";

			changescore(8);
			self.deactivatenpc;
			self.moveInto(nil);
		}
	}
	verIoPutIn(actor) = { robot_slot.verIoPutIn(actor); }
	ioPutIn(actor, dobj) = { robot_slot.ioPutIn(actor, dobj); }
	verIoTakeOut(actor) = {}
	ioTakeOut(actor, dobj) = { dobj.doTake(actor); }
;

robot_slot: partitem, qcontainer
	sdesc = "robot's slot"
	ldesc = {
		"The slot looks like a fine place to put a planner. ";
		showcontcont(self);
	}
	noun = 'slot'
	adjective = 'robot' 'robots' 'robot\'s'
	partof = robot
	isListed = nil

	verDoOpen( actor ) = "I don't know how to open <<self.thedesc>>. "
	verDoClose( actor ) = "I don't know how to close <<self.thedesc>>. "

	verIoPutIn(actor) = {
		if (self.contents <> [])
			"You can't put more than one thing in the slot at a time.\n";
	}
	ioPutIn( actor, dobj ) = {
		if (not isclass(dobj,plannr))
			"\^<<dobj.thedesc>> does not fit in the slot, which is meant
			for a planner.\n";
		else {
			dobj.moveInto(self);
			"\bAs <<dobj.thedesc>> falls into the robot's slot,
			the robot begins to take charge of the block situation.\n";
		}
	}
	
	Grab(obj) = {
		"Removing <<obj.thedesc>> from the robot immediately confuses it!\n";
	}
;

lemur: movingnpc, messagingnpc, animal
	sdesc = "lemur"
	ldesc = {
		if (self.isintree)
			"\^<<self.thedesc>> is too far away to get a good look at, but he seems
			to be carrying something yellow.  At a guess, the robot below scares
			him too much to come down. ";
		else {
			"\^<<self.thedesc>> is laughing at you. ";
			if (self.isCarrying(banana))
				"The lemur is carrying <<banana.adesc>>. ";
		}
	}
	location = bananaplace
	noun = 'lemur'

	cycle = [ 1 &nw 1 &west 1 &north 1 &west 1 &west 1 &west 1 &north 1 &north
		1 &west 5 nil 0 ]

	count = 0

	compute(actor) = {
		if ((self.location = specialmaze) and (banana.location = self)) {
			if (self.isVisible(actor))
				"The lemur has just dropped the banana on the ground.";
			banana.moveInto(self.location);
		}
		if (self.isintree and robot.location = nil) {
			count += 1;
			if (count = 3) {
				self.isintree := nil;
				if (self.isVisible(actor))
					"The robot's absence seems to have calmed the lemur down
					a bit.  It cautiously ventures down from the tree,
					on its way to the secret lemur resting and banana
					dropping spot. ";
			}
		}
		if (self.location <> bananaplace and fruitflies.exist) {
			fruitflies.exist := nil;
			fruitflies.moveInto(nil);
		}
	}

	actorDesc = {
		if (self.isintree)
			"There is <<self.adesc>> here, high up in the branches of the tree. ";
		else {
			"\^<<self.adesc>> is prancing about";
			if (self.isCarrying(banana)) ", carrying <<banana.adesc>>";
			". ";
		}
	}

	isintree = true
	
	isReachable(actor) = {
		if (self.isintree) return nil;
		pass isReachable;
	}
	contentsVisible = {
		if (self.isintree) return nil;
		pass contentsVisible;
	}
	cantReach(actor) = {
		if (self.isintree)
			"%You% can't possibly reach <<self.thedesc>> from here. ";
		pass cantReach;
	}
	computemove = {
		if (self.isintree = true) self.move := self.location;
		else pass computemove;
	}
	verIoGiveTo(actor) = { "What would <<self.adesc>> want with your goods? "; }

	leaveword = "bounds out"
	enterword = "bounds in"
	comeword = "bounds"
	goword = "bounds"

	verDoRub(actor) = {}
	doRub(actor) = {"\^<<self.thedesc>> is prancing about too quickly for you to pet him.";}
;

timeflies: movingnpc, animal
        sdesc = "large cloud of flies"
        ldesc = { 
		"The fat white time flies are fluttering to and fro so 
                fast that just looking at them makes you want to run around in circles. ";
		if (self.followingarrow = nil) {
			if (self.isVisible(arrow)) {
				"They are clustered around the arrow and fluttering 
				their wings in delight. ";
			}
			else {
				"They seem to be lacking a purpose in life,
				and are just fluttering about randomly. ";
			}
		}
	}
        noun = 'flies' 'fly'
        adjective = 'time' 'cloud' 'of' 'large'

        location = loft
        
        followingarrow = nil

	computemove = {
		// Time flies like an arrow
		if (self.followingarrow) self.move := arrow.containingroom;
		else self.move := self.location;
	}

	leaveword = "flutters away"
	enterword = "flutters in"
	comeword = "flutters"
	goword = "flutters"
;


humblebee: movingnpc, messagingnpc, joinable, animal
	sdesc = "humble bee"
	ldesc = "The humble bee is, if anything, below average in stature,
		and not flying about nearly so well as some other bees it
		knows. But at least it always tries. "
	noun = 'bee' 'humblebee'
	adjective = 'humble'

	location = lumenberrypatch

	hasseenlemondrop = nil

	actorDesc = {
		"There is <<self.adesc>> buzzing about.";
	}
	dosting = nil

	computemove = {

		// Bee follows lemon drop if ever exposed to it.

		if (self.hasseenlemondrop) self.move := lemondrop.containingroom;
		else if (self.isVisible(lemondrop)) {
			self.hasseenlemondrop := true;
			self.move := lemondrop.containingroom;
		}
		else self.move := self.location;
	}
	compute(actor) = {
		if (self.dosting <> nil) {
			self.sting(self.dosting);
			self.msg := true;
		}
	}

	ioJoinTo(actor, dobj) = { deadbee.ioJoinTo(actor, dobj); }

	verDoAttackWith(actor, iobj) = { self.vermethod(actor); }
	verDoMoveTo(actor, iobj) = { self.vermethod(actor); }
	verIoThrowAt(actor) = { self.vermethod(actor); }
	verIoThrowTo(actor) = { self.vermethod(actor); }
	verIoShowTo(actor) = { self.vermethod(actor); }
	verIoGiveTo(actor) = { self.vermethod(actor); }
	verDoEat(actor) = { self.vermethod(actor); }
	verDoPoke(actor) = { self.vermethod(actor); }
	verDoPush(actor) = { self.vermethod(actor); }
	verDoTake(actor) = { self.vermethod(actor); }
	verDoDrink(actor) = { self.vermethod(actor); }
	verDoRub(actor) = { self.vermethod(actor); }
	verDoAttack(actor) = { self.vermethod(actor); }
	verifyRemove(actor) = { self.vermethod(actor); }

	vermethod(actor) = {
		"I don't think that's a very good idea...\b";
		self.dosting := actor;
	}

	sting(actor) = {
		"Annoyed by %your% actions, <<self.thedesc>> darts towards you,
		stings you, and drops dead.\b
		\t\t\"Yowwza!\", you yell.\b";

		self.deactivatenpc;
		deadbee.moveInto(self.location);
		self.moveInto(nil);
		changescore(-5);
	}

	leaveword = "flies away"
	enterword = "flies in"
	comeword = "flies"
	goword = "flies"
;

louis: messagingnpc, movingnpc, named, person
	sdesc = "Louis Reasoner"
	ldesc = "Prof.\ Reasoner looks just as you always imagined him- a bumbling, portly,
		Falstaff-like jovial sort, perhaps led astray by his own inability to
		grasp the deeper issues of a problem."
	noun = 'louis' 'reasoner'
	adjective = 'louis' 'professor' 'prof'

	location = louisoffice
	origlocation = louisoffice /* So cycle can be reset. */

	/* ARPA man must have same length cycle as Louis, and arrive and stay in Machine
	 * Room for the same amount of time.  They can both turn their cycling off to
	 * stay there for a while, if need be.  Cycle length is 18.
	 */
 	cycle = [ 3 easthall 2 &west 2 &down 1 &south 1 &east 3 &west 1 &north 1 &up
		 2 &east 2 louisoffice ]

	iscycling = true
	foundtimes = 0

	computemove = {
		/* If following normal cycle, do so. */
		if (self.iscycling) pass computemove;
		/* Otherwise sit still. */
	}

	/* If Louis ever finds you in the machine room, or finds you in the
	 * machine with the door open, or finds you in the machine and the
	 * machine isn't lit and humming, he makes you drop all your stuff
	 * and kicks you out.
	 *
	 * If he ever finds the machine off and not humming and blinking,
	 * he turns the machine back on.  If he ever finds the door open
	 * he closes it.
	 *
	 */

	justinoffice = true

	compute(actor) = {
		if (self.location = louisoffice) {
			if (actor.location = louisoffice) {
				"\b\t\"What are you doing here?  
				I don't have an appointment with you!\"\b";
				if (thep.location = actor) { 
					"\t\"And give me my `P' back!\"\b";
					thep.moveInto(louisoffice);	
				}
				"\nLouis, not a small man, picks you up,
				carries you out of his office,
				and dumps you unceremoniously in the hallway.
				You land with a thud on your rump, nursing a grudge 
				against this intemperate researcher.\b";

				actor.travelTo(easthall);
			}
			louisdoor_1.isopen := nil;
			louisdoor_1.islocked := true;
			self.justinoffice := true;
			unnotify(louisclock, &checkClock);
		}
		// Important that Louis does not leave his office without
		// coming through easthall, as this is what unlocks his
		// door.
		if (self.location = easthall) {
			if (self.justinoffice = true) {
				louisdoor_1.isopen := true;
				louisdoor_1.islocked := nil;
				self.justinoffice := nil;
			}
		}
		if (self.location = computer_room) {
			/* Kick you if you're in the computer room. */
			if (actor.location = computer_room) {
				"\b\tDespite his reputation for genial hospitality, Louis seems
				mighty upset about something, and that something is apparently
				you.\b";

				self.eject(actor);
			}
			else if (actor.location = in_computer and cmdoor_1.isopen) {
				"\b\t\"Hey, what's this?!\", Louis exclaims.  \"Somebody left
				the machine's panel open.\"  He walks over to shut it, and
				despite cowering in the corner you can not evade his glance.\b

				\t\"What the hell are you doing in there?\", he asks, and
				without	waiting for an answer pulls you forcibly from the
				machine's interior.\b";

				self.eject(actor);
			}
			else if (actor.location = in_computer and
					((not cm8.ishumming) and cmlights.appearblinking) or
					((not cmlights.appearblinking) and cm8.ishumming)) {
				"\b\t\"Hmm\", you hear Louis ponder, \"There must be something
				wrong with the machine.\b

				\tAs he opens the panel to examine the CM-8, he notices
				you huddled inside.\b

				\t\"What the hell are you doing in there?\", he asks, and
				without	waiting for an answer pulls you forcibly from the
				machine's interior.\b";

				self.eject(actor);
			}
			else if (actor.location = in_computer and
				 (not cm8.ishumming) and (not cmlights.appearblinking)) {

				"\b\t\"I thought I left the machine on.\", you hear Louis say.
				\"What's going on here?!\"\b

				\tAs he opens the machine up to turn it on, he notices you
				hiding inside.\b

				\t\"What the hell are you doing in there?\", he asks, and
				without	waiting for an answer pulls you forcibly from the
				machine's interior.\b";

				self.eject(actor);
			}
			/* Turn computer on if it doesn't appear to be. */
			if (not (cm8.ishumming and cmlights.appearblinking))
				powerswitch.isActive := true;
			/* Shut panel door if it's open. */
			if (cmdoor_1.isopen) cmdoor_1.shut;

			/* If you're inside, you should hear Louis (unless the
			 * Turing test is going on.)
			 */
			if (actor.location = in_computer and arpa.turingstate = 0)
				"\n\tYou hear the sounds of someone moving about in
				the machine room.\n";
		}
	}
	actorSaid(actor, string) = {
		if (actor.location = in_computer and self.location = computer_room) {
			if (arpa.turingstate <> 4) {
				"\b\t\Louis jumps, startled.  \"Who said that?!\"\b

				\tHe comes over to the CM8, suspicious, and opens the panel
				to find you crouching inside.\b

				\t\"What the hell are you doing in there?\", he asks, and
				without	waiting for an answer pulls you forcibly from the
				machine's interior.\b";

				self.eject(actor);
			}
			else arpa.playeranswered := string;
		}
	}

	eject(actor) = {
		local i,n,toremove;
		self.foundtimes++;
		if (self.iscycling)  /* Not in real test. */
		switch (self.foundtimes) {
		case 4: {
			"\t\"That's was the last time.  You obviously never learn.\"\b
			Louis picks you up and throws you violently against the CM-8.\b";
			die();
			break; }
		case 3: {
			"\t\"This is the last time I'm going to tell you- we're running
			tests in here today and you're not wanted.\"\b";
			break; }
		case 2: {
			"\t\"You again?  Get the hell out and stay out!\"\b";
			break; }
		case 1: {
			"\t\"Get out of here!\" Louis screams in a rage.  \"Can't you
				see we've got a big demo scheduled for today!?\"\b";
			break; }				
		}
		else  /* During test. */
		switch (self.foundtimes) {
		case 4: {
			"\t\"That's the last time you interfere.  You obviously never
			learn.\"\b
			Louis picks you up and throws you violently against the CM-8.\b";
			die();
			break; }
		case 3: {
			"\t\"I can't believe you're in here!  Are you trying to ruin my
			credibility?\"\b";
			break; }
		case 2: {
			"\t\"You again?  Vile cur! Get the hell out and stay out!\"\b";
			break; }
		case 1: {
			"\t\"Get out of here!\" Louis screams in purple rage.  \"Do
			you think the Turing Test is a big joke or something?\"\b";
			break; }				
		}

		"Louis, not a small man, picks you up, carries you from the machine
		room into the courtyard, and literally throws you out into the grass.
		You land with a thud on your rump, nursing a grudge against this
		intemperate researcher, and leaving your belongings behind.";
	
		n := length(actor.contents);
		toremove := [];
		for (i := 1; i<=n; i++)
			if (not actor.contents[i].isworn)
				toremove += actor.contents[i];
		n := length(toremove);
		for (i := 1; i<=n; i++) toremove[i].moveInto(self.location);

		changescore(-7);
		actor.travelTo(north_courtyard);

		/* If Louis and ARPA were in the middle of an evaluation, quit it
		 * and let them wander for a bit.
		 */

		arpa.iscycling := true;
		louis.iscycling := true;
	}
;

gnu: inactivenpc, animal
	sdesc = "gnu"
	ldesc = "The gnu lurking in the AI Lab has a long mane, 
                short tail, and spectacularly curving horns.  This is a 
                particularly scraggly example of the species, and its mangy 
                fur probably hasn't seen a bath in many years.  It looks like it might
		be hungry."
	noun = 'gnu'
	location = ai

	eatenbrownie = nil
	lasteaten = 0
  
	compute(actor) = {
	     if (self.isVisible(brownie)) {
		"\bThe gnu notices that you have the brownie and its
		eyes bug out as it grabs the brownie from you and devours it.
		The gnu has a serious sweet tooth (witness its rotting teeth
		and rank breath), but that seems to have satisfied it for
		today.\n";
		brownie.moveInto(nil);
		eatenbrownie := true;
		lasteaten := 4;
	     }
	     if ((self.isVisible(lemondrop)) and (eatenbrownie = nil)) {
		"\bThe gnu notices that you have the lemon drop and its 
		eyes bug out as it grabs the lemon drop from you and devours it.  
		The gnu has a serious sweet tooth (witness its rotting teeth
		and rank breath).\n";
		lasteaten := 2;
		lemondrop.moveInto(nil);
	     }
	     if (self.isVisible(apple)) {
		"\b\"No, no, no!\" screams the enraged gnu as it sees the apple.
		The gnu grabs the apple
		away from you, muttering something about filthy capitalists.
		It gnashes its terrible teeth and stomps the apple into 
		a pulp before kicking it outside.\n";
		apple.moveInto(nil);
	     }
	     if (self.isVisible(lotus_flower)) {
		"\bThe gnu turns purple in the face as it sees the lotus flower and grabs
		it away from you, muttering something about filthy capitalists.
		Heedless of the ethereal beauty and lingering perfume of the flower,
		the gnu gnashes its terrible teeth and stomps the lotus flower into 
		a pulp.\n";
		lotus_flower.moveInto(nil);
	     }
	     if (existsfood(actor.contents) and (lasteaten = 0)) {
		"\bThe gnu notices that you have <<grabfood(actor.contents).adesc>> 
                 and its eyes bug out.\n  The gnu steals it while you're not 
                 looking and quickly devours it.\n";
		lasteaten := 1;
	     }
	     else if (lasteaten > 0) lasteaten--;
	}

        verDoAttack(actor) = {}
        doAttack(actor) = {
	  "The gnu, its reflexes honed by a lifetime of scrounging on the thin
           edge of life, deftly evades you.\n";
	}
        verDoRub(actor) = {}
        doRub(actor) = "The gnu's filthy matted fur discourages you from attempting
                        to touch it."
;		


arpa: messagingnpc, movingnpc, person
	sdesc = "ARPA evaluator"
	adesc = "an ARPA evaluator"
	ldesc = "The Acme Representative for the Proliferation of Acme is a gangly, emaciated
		man with beady little eyes.  At a guess, if he was found
		dead with a small silver dagger protruding from his chest, an awful
		lot of people would fall under suspicion."
	noun = 'evaluator'
	adjective = 'arpa'

	location = tavern

	/* ARPA man must have same length cycle as Louis, and arrive and stay in Machine
	 * Room for the same ammount of time.  They can both turn their cycling off to
	 * stay there for a while, if need be.  Cycle length is 18.
	 */
 	cycle = [ 4 &east 2 &north 1 &north 1 &north 1 &east 1 &east 1 &west 1 &west
		 1 &south 1 &west 1 &east 1 &south 1 &south 1 &west ]

	iscycling = true
	haseaten = nil

	messageD = 1 /* Messages are frequent until he's eaten. */

	computemove = {
		/* If following normal cycle, do so. */
		if (self.iscycling) pass computemove;
		/* Otherwise sit still. */
	}

	/* If ARPA person hasn't eaten his toast, he's not going to do
	 * much but complain.  Once he's eaten his toast, he'll lay off
	 * the nasty messages.  By only having ARPA person in Machine Room
	 * when Louis is, we get around problem of dealing with you and
	 * ARPA together there.  Aren't we clever!
	 *
	 * If ARPA person finds toast in same location he's in, he'll
	 * take it (so long as it's not in your posession).
	 */

	turingstate = 0
	compute(actor) = {
		/* ARPA has toast nearby, and its not in your posession. */
		if (self.isVisible(slicebread) and slicebread.location <> actor)
			self.findbread(actor);
		/* If ARPA person hasn't had breakfast yet, and is talking to
		 * Louis in machine room, with you inside machine (you hear),
		 * he says he's not starting contest.
		 */
		if (self.location = computer_room and actor.location = in_computer and
			self.haseaten = nil)
			"\nYou hear \"You understand, Louis, that I'm still not going to
			test your program.  Not until I get my breakfast.\"\n";
		
		/*
		 * Turing Evaluation
		 */

		if (self.location <> computer_room) self.turingstate := 0;
		if (self.location = computer_room and self.haseaten and self.iscycling
			and self.turingstate = 0) {

			/* Stop Louis and ARPA guy from running around for a bit. */

			self.iscycling := nil;
			louis.iscycling := nil;

			self.turingstate := 1; /* We're just starting the test. */
		}
		if (self.iscycling = nil) {

			/* All Right!  We're in the middle of the turing test. */

			switch (self.turingstate) {
			case 0: { "\nCase 0 Error\n"; break; }
			
			/* First, ARPA person says he's about to start and Louis says yes. */
			case 1: {
				if (actor.location = in_computer) {
					"\bYou hear a raspy voice ask \"Louis, are you
					ready to start?\"\b";

					"\tLouis responds \"";
					say(randomelement(self.louisresponses));
					"\"\b";
				}
				self.turingstate++;
			break; }
			/* Then ARPA guy reads story out loud. */
			case 2: {
				self.story := randomelement(self.stories);
				if (actor.location = in_computer) {
					"\b\t\"Then here we go.\"\bThe ARPA 
					evaluator takes great pains to enunciate:\b";
					say(self.story.text);
					"\b";
				}
				self.turingstate++;
			break; }
			/* ARPA guy asks computer for response.  Player must respond
			 * between now and next period.
			 */
			case 3: {
				self.quest := randomelement(self.story.questions);

				if (actor.location = in_computer) {
					"\bFinally, the evaluator asks the contraption
					machine: \"";
					say(self.quest.text); "\"\b";
				}
				/* Waiting for answer. */
				self.playeranswered := '';
				self.machineanswered := nil;
				self.machineexploded := nil;
				self.turingstate++;
			break; }
			/* Denouement */
			case 4: {
				/* If computer is on, computer responds or blows up. */
				if (powerswitch.isActive = true) {
				   if (myrand(2) = 1) self.machineanswered := true;
				   else self.machineexploded := true;
				   if (actor.location = in_computer) {
					if (self.machineanswered = true) {
					    /* Computer answers question. */
					    "\nA booming speaker next to you responds \(";
					    say(randomelement(self.quest.computeranswers));
					    "\)\b";
					}
					if (self.machineexploded = true) {
					    /* Computer had big problems. */
					    "\n"; say(randomelement(self.machineproblems));
					    "\b";
					}
				    }
				}
				/* If computer blows up or responds and player has
				 * also responded, Louis gets suspicious. */
				if ((self.machineexploded or self.machineanswered) and
				    (not (self.playeranswered = '')) and
				    actor.location = in_computer) {
				   if (self.machineanswered)
					"Louis says \"There's no way it should have said
					two things. ";
				   else if (self.machineexploded)
					"Louis explains \"There's no way it should have
					 said anything with that kind of glitch. ";
				   "What's going on here?\"\b";

				   "He storms over to the machine, throws open the panel,
				   and exclaims \"Aha! Another virus in the machine!\".\b";
				   louis.eject(actor);
				}
				/* If no one answers, Louis is suspicious. */
				else if ((not self.machineexploded) and
					 (not self.machineanswered) and
				   	 (self.playeranswered = '')) {
				   if (actor.location = in_computer) {
				   	"Louis thinks aloud \"But the CM
					was on. That shouldn't have happened.\"\b

				   	He ambles towards the machine, slides back the panel,
				   	and exclaims \"Aha! A large bug!\".\b";
				   	louis.eject(actor);
				   }
				   /* Or turns the machine back on and quits. */
				   else {
					powerswitch.isActive := true;
					self.iscycling := true;
					louis.iscycling := true;
				   }
				}
				/* Or if player got question right... */
				else if (self.quest.iscorrect(self.playeranswered)) {
					"\bYou hear cries of elation from Louis:\b

					\t\"It works!\ It works!\ I've never made anything
					that works in my entire life!\ I'm a genius!\ Huzzah!
					Huzzah!\ Blessings and honor, glory and power be unto
					me!\ Alyssa can go suck eggs ...\"\b";

					"The ARPA evaluator interrupts, \"Yes, yes, you passed. So
					what? Here's your damn `P'.  I'm leaving.\"";
	
					thep.moveInto(louisoffice);

					/* To get Louis out of here, and prevent him
					 * from seeing you get out of the machine.
					 */
					louis.resetcycle;
					louis.iscycling := true;
					self.moveInto(nil);
					self.deactivatenpc;
					changescore(12);
				}
				/* Failed test again. */
				else {
					if (actor.location = in_computer) {
					   "\bLouis mulls the situation over, and says: \"";
					   say(randomelement(self.louisfixes)); "\"\b";
					   "The ARPA evaluator wearily responds
					   \"Well, Louis, you failed again.  What a surprise.
					   Here's your `F'- add it to the stockpile. ";
					}
					self.story.questions -= self.quest;
					if (self.story.questions = [])
						self.stories -= self.story;
					if (self.stories = []) {
					   if (actor.location = in_computer)
						"I'm out of stories and sick of your incompetence.
						I'm leaving.\"\b";
					   self.moveInto(nil);
					   self.deactivatenpc;
					   changescore(-60);
					}
					else
					   if (actor.location = in_computer)
						"Back in 20 minutes or so for the usual.\"\b";
					self.iscycling := true;
					louis.iscycling := true;
				}
			break; }
			}
		}
	}

	verIoGiveTo(actor) = {}
	ioGiveTo(actor, dobj) = {
		if (dobj = slicebread and (slicebread.istoast or not self.foundbreadbefore))
			self.findbread(actor);
		else {
			"\t\^\"Peasants!\", the evaluator screams. ";
			if (self.haseaten) "\"What do I want with such things?!\"";
			else "\"I need breakfast and they bring me <<dobj.adesc>>!\"";
			"\n\tThe ARPA evaluator has manifestly refused your offering.\b";
		}
	}

	foundbreadbefore = nil
	findbread(actor) = {
		local youarenearby;
		youarenearby := self.isVisible(actor) or
				 (self.location = computer_room and
				  actor.location = in_computer);
		if (slicebread.isburnt) {
			if (youarenearby) {
				"\b\t\"Burnt toast!  Burnt toast!  I come all this way
				and all I can find is burnt toast!\"\b

				\tObviously, the ARPA Evaluator is not happy with the
				toast situation.\b";

				if (self.isVisible(actor))
					"\tThe evaluator throws the charred remains of the
					toast down and storms out in disgust.  Not the
					friendly type, you see, and exceptionally unlikely
					to return.\b";
			}
			slicebread.moveInto(self.location);
			self.moveInto(nil);
			self.deactivatenpc;
			changescore(-4);
		}
		else if (not slicebread.istoast and not self.foundbreadbefore) {
			if (youarenearby) {
				"\b\t\"Uncooked bread. Raw. Exposed. Primeval. Probably
				covered with germs. What sort of uncultured slobs
				work here anyway?\"\b

				\tObviously, the ARPA Evaluator is not happy with the
				bread situation.\b

				\t\"I'll be damned if I'm going to start any evaluation
				without getting a decent breakfast first.\"\b";

				if (self.isVisible(actor))
					"\tThe evaluator throws the not-obviously inedible
					bread down.\b";
			}
			slicebread.moveInto(self.location);
			self.foundbreadbefore := true;
		}
		else if (slicebread.istoast) {
			if (youarenearby) {
				"\b\t\"At last. I finally find breakfast.\"\b

				\tObviously, the ARPA Evaluator was not particularly
				pleased with the breakfast service the Cheez Boar Inn
				provides.\b";

				if (self.isVisible(actor))
					"\tThe evaluator scarfs the toast down in a
					blinding flash of motion.\b";

				"\t\"That's the last time I'm staying at any place called
				`Cheez Boar'.  Fuzzy toasters.  What a flimsy excuse.\"\b";
			}
			slicebread.moveInto(nil);
			self.haseaten := true;
			changescore(4);
			messageD := 4; /* Messages less frequent after breakfast. */
		}
	}
;

/* Arpa stories have the text, then a list of questions that can be asked.
 * For each question, there is a list of correct answers, and then a list
 * of possible computer responses (which should never contain the correct
 * answer).  The goodanswers MUST be in lower case.
 */

class arpastory: object
	text = '\(This should have been filled in\)'
	questions = []
;
class arpaquestion: object
	text = '\(This should have been filled in\)'
	computeranswers = []
	goodanswers = []

	iscorrect(answer) = {
		return(find(self.goodanswers, lower(answer)) <> nil);
	}
;
	
cat: inactivenpc, movingnpc, named, animal
	sdesc = "Schroedinger's cat"
	ldesc = "Schroedinger's cat is a motley calico, each of the colors equally
		likely to occur at any space at any time."
	noun = 'cat'
	adjective = 'schroedingers' 'schroedinger\'s' 'schroedinger'

	actorDesc = {
		"\^<<self.thedesc>> is here, ";
		say(randomelement(self.actions));
					
		". ";
	}

	actions = ['PROBLEM IN CAT']

	location = nil /* In box */

	cycle = [ 2 physics_office 1 tavern 1 halles_office 1 gps1 1 fib1
		  1 in_computer 1 alyssaoffice 1 bananaplace 1 horsefall 1 deans_office
		  1 barn 1 wind_tunnel 1 cheezroom 1 mazeattractor ]

	verDoRub(actor) = {}
	doRub(actor) = "Your fingers experience an eerie sensation as you attempt to touch
			the cat; it's hard to tell if you're actually feeling its fur or not."
	
	leaveword = "tunnels away"
	enterword = "tunnels in"
	comeword = "walks"
	goword = "walks"
;

dean: messagingnpc, named, person
	sdesc = "Dean Chiquita"
	ldesc = "The dean of the university looks vaguely simian, which may
		explain his predilection for bananas."
	actorDesc = {
		"Dean Chiquita is here, sitting in his chair.\n";
	}

	noun = 'dean' 'chiquita'
	adjective = 'dean'

	location = deans_office

	hasseenme = nil
	haseaten = nil
	state = 0
	messageD = 3
	compute(actor) = {
		if (self.hasseenme = nil) {
			self.msg := dean_hello_msg;
			self.hasseenme := true;
		}
		if (self.state > 0) {
			/* Don't put out random message just after dean has eaten
			 * banana. */
			self.msg := true;
			self.state++;

			switch (self.state) {
			case 3: {
				if (self.isVisible(actor))
					"\nThe dean throws the remains of his banana
					on the floor.\n";
				self.haseaten := true;
				bananapeel.moveInto(deans_office);
				self.msg := dean_nodegree_msg; /* Try to kick player out. */
				break;
			}
			case 5: {
				if (self.isVisible(actor))
					"\nThe dean stares at you blankly.\n";
				self.msg := dean_nodegree_msg; /* Try to kick player out. */
				break;
			}
			case 6: {
			
				self.state := 0; /* No longer in special mode. */

				if (self.isVisible(actor)) {
				"\b\t\"Oh!\", the dean cries. You must want a degree.
				I'm always forgetting that rule. No problem. Even if
				the journey is the reward, I guess that shouldn't
				prohibit a gesture of my appreciation.\"\b

				He walks over to the filing cabinet, and, pulling a kee
				from his pocket, unlocks and opens it.  After rummaging
				through a drawer for a bit, he pulls out a small diploma.\b

				\t\"What did you say your name was again? Well, never mind,
				this is good enough.\"\b

				He hands you the diploma and, in a moderately pompous voice,
				proclaims:\b

				\t\"I hereby confer upon you the degree of Bachelor of, um,
				Bananalogical Science.\"\b

				You are overcome with tears.\n";

				diploma.moveInto(actor);
				Me.havedegree := true;
				changescore(13);
				}
			}
			}
		}
	}

	verIoGiveTo(actor) = {}
	ioGiveTo(actor, dobj) = {
		if (dobj = banana) {
			"The dean, eyes wide, snatches the banana from your hands and
			immediately begins peeling it. \"Thanks [chomp], I don't often
			[mmm] get these around [aaah] here.\"\n";
			banana.moveInto(nil);
			self.state := 1; /* Start dean into special eating banana mode. */
		}
		else {
			"The dean glances at your gift and says \"I appreciate your
			offer, but I honestly can't accept this. Please, I have
			friends to make and important people to influence.\"\n";
		}			
	}
	verDoAskFor(actor, iobj) = {}
	doAskFor(actor, iobj) = {
		if (iobj = diploma) {
			if (Me.havedegree)
				"\nThe dean says \"I already gave you a degree.  How many
				do you want?\"\n";
			else if (self.state = 0)
				"\nThe dean explains \"No one gets a degree until they
				please me.\"\n";
			else "\n\t\"Right, the degree.  I'm getting to that.\"\n";
		}
		else 
			"\n\t\"Want something for free, eh?  Forget it.\"\n";
	}
	verDoAskAbout(actor, iobj) = {}
	doAskAbout(actor, iobj) = {
		if (iobj = banana) {
			if (self.state > 0 and not self.haseaten)
				"\nThe dean responds \"I'm eating it, as you can plainly
				see.\"\n";
			else if (self.haseaten)
				"\n\t\"The banana is gone, and isn't coming back.\"\n";
			else
				"\nThe dean says \"I'd love a banana, if that's what you
				mean.\"\n";
		}
		else if (iobj = diploma) {
			if (Me.havedegree)
				"\nThe dean says \"I already gave you a degree.  How many
				do you want?\"\n";
			else if (self.state = 0)
				"\nThe dean explains \"My standard policy is to award a
				degree to anyone that pleases me.\"\n";
			else "\n\t\"Right, the degree.  I'm getting to that.\"\n";
		}
		else 
			"\^<<self.thedesc>> doesn't feal like answering silly questions.";
	}
;

horse: inactivenpc, uninterestednpc, animal
	sdesc = "fallen horse"
	ldesc = {
		"The horse is lying on the ground, breathing heavily";
		if (mobiusbow.partof = horse)
			" but wearing a pretty red bow";
		". ";
		if (horses_tag.partof = horse) "Around the horse's neck is a small tag. ";
		"It is unclear why the horse raced past the barn fell. ";
	}
	verDoRub(actor) = {}
	doRub(actor) = "The horse feels hot and sweaty, and is unresponsive to your touch."

	location = nil
	noun = 'horse'
	adjective = 'fallen'

	leaveword = "trots out"
	enterword = "trots in"
	comeword = "trots in"
	goword = "trots away"
;

horses_mouth: ourdecoration, partitem, searchHider
	sdesc = "horse's mouth"
	ldesc = {
		"The horse's mouth is rather slobbery";
		if (not (self.searchCont = [] or self.searchCont = nil))
			" and seems to contain something.  Perhaps you should look
			inside it. ";
		else ", but that's hardly surprising. ";
	}
	noun = 'mouth'
	adjective = 'horse\'s'
	partof = horse
;

horses_neck: ourdecoration, partitem
	sdesc = "horse's neck"
	ldesc = {
		"The horse's neck is uninteresting";
		if (horses_tag.partof = horse) ", save for the tag attached around it.";
		else ".";
	}
	noun = 'neck'
	adjective = 'horse\'s'
	partof = horse
;

bunny: inactivenpc, animal
	sdesc = "bunny"
	ldesc = "The small white rabbit looks undisturbed by your presence,
		and is happily hopping about, perhaps joyful at the thought
		of this season's forthcoming harvest."
	noun = 'rabbit' 'bunny' 'hare'
	adjective = 'small' 'white' 'hopping' 'vorpal'

	/* If you have the carrot, the vorpal bunny will be incensed, and
	 * will most certainly kill you for it.  If there is lettuce nearby,
	 * the vorpal bunny will eat it.
	 */
	actorDesc = {
		"There is <<self.adesc>> here, ";
		if (self.els=0) "hopping about.";
		else if (self.els=1) "eyeing the lettuce.";
		else "nibbling on the lettuce.";
	}

	els = 0

	ioGiveTo(actor, dobj) = {
		if (dobj = lettuce) {
			self.els += 1;
			if (self.els=1 and actor.isVisible(self))
				"\nThe bunny hops over to the lettuce and eyes it carefully.\n";
			dobj.moveInto(self.location);
		}
		else {
			"\^<<self.thedesc>> doesn't seem interested in <<dobj.thedesc>>.";
		}
	}

	compute(actor) = {
		if (carrot.location = actor and self.location = actor.location) {
			"\bThe vorpal bunny is incensed!  You have stolen a carrot
			from the patch he had to kill to get!  Neither 2 nor 4 seconds
			does it wait before lunging for your throat, and in a single
			swipe of its powerful, protruding teeth it severs your neck
			from your body.\b

			Then it eats the carrot.\b";

			die();
		}
		if (lettuce.location <> nil and lettuce.location <> carrotpatch and
			self.els > 1) {
			"\bThe vorpal bunny is not about to stand for its lettuce
			disappearing.  Without a moment's pause it leaps for your
			jugular.  The resulting scene is probably a bit too vivid
			to describe here, but suffice it to say that that was probably
			not a wise move, taking lettuce from a bunny.\b";

			die();
		}
		if (lettuce.location = carrotpatch) {
			self.els += 1;
			if (self.els=1 and actor.isVisible(self))
				"\nThe bunny hops over to the lettuce and eyes it carefully.\n";
			else if (self.els=2 and actor.isVisible(self))
				"\nThe bunny begins to eat the lettuce.\n";
			if (self.els=5) {
				if (actor.isVisible(self))
					"\nThe bunny has finished eating the lettuce.\n";
				lettuce.moveInto(nil);
				if (lettuce.isPoisonous) {
					"It keels over dead.\n";
					bunny.moveInto(nil);
					deadbunny.moveInto(carrotpatch);
					changescore(6);
				}
				self.els := 0;
			}
		}
		else self.els := 0;
	}

	verDoRub(actor) = {}
	doRub(actor) = "The vorpal bunny backs away, suddenly looking a lot meaner.  
			You notice its evil-looking buck teeth for the first time 
			as it bares them and lays its ears back."
	
	location = carrotpatch
;

deadbunny: ouritem, throwable
	sdesc = "dead bunny"
	ldesc = "The small white, and very deceased rabbit looks so beautiful,
		even in death, that the dwarves are unwilling to bury it."
	noun = 'rabbit' 'bunny' 'hare' 'ex-bunny' 'vorpal'
	adjective = 'small' 'white' 'hopping' 'dead' 'deceased'
	
	location = nil
;

hamster: male, littleactor, animal
	sdesc = "hamster"
	adesc = {
		"a hamster";
		if (self.isrunning) {
			if (self.foodenergy > 4) ", running rapidly";
			else if (self.foodenergy > 0) ", walking slowly";
		}
	}
	ldesc = {
		"Corduroy, your childhood playmate and only friend, is a brown and white
		striped hamster someone once found swimming in a swamp.  He's very
		energetic when he gets his favorite food.  As far as you know,
		he's always been governed by continuum mechanics.  ";
		if (self.isrunning) {
			if (self.foodenergy > 4)
				"He's running rapidly in place in the cylinder.";
			else if (self.foodenergy > 0)
				"He's walking slowly in place inside the cylinder.";
		}
	}
        actorAction( verb, dobj, prep, iobj ) = 
	{
	"A pity you never taught Corduroy to respond to your commands.
	Well, it's too late to teach an old hamster new tricks now.  ";
	exit;
	}

	actorDesc = {
		caps(); "<<self.adesc>> is here";
		if (self.isrunning) {
			if (self.foodenergy > 4) ", running rapidly in a cylinder";
			else ", walking slowly in place inside a cylinder";
		}
		". ";
	}
	noun = 'hamster' 'corduroy'
	adjective = 'brown' 'white' 'striped'
	location = startroom

	foodenergy = 0

	notifyInTreadmill = {
		if (not (self.location = treadmill)) {
			if (self.foodenergy > 0) {
				"As you put Corduroy in the cylinder, he starts
				 running in place as hard as he can";
				if (self.foodenergy < 3)
					" (which isn't very hard given his
					 undernourished state)";
				", and the cylinder spins around him.";
				self.isrunning := true;
				notify(self, &decreaseEnergy, 0);
			}
			else
				"You put Corduroy in the cylinder.  He stares back,
				confusedly.";
		}
	}
	notifyNotInTreadmill = {
		self.isrunning := nil;
		unnotify(self, &decreaseEnergy);
	}

	verDoRub(actor) = {}
	doRub(actor) = "Corduroy relaxes as you pet his silky fur."

	verIoGiveTo(actor) = {}
	ioGiveTo(actor, dobj) = {
		if (isclass(dobj,fooditem)) {
		    if (dobj.isPoisonous = true) {
			"Corduroy snuffles at <<dobj.thedesc>>, but refuses
			to eat it. ";
		    }
		    else {
			"Corduroy is only too happy to take <<dobj.thedesc>>, and
			promptly eats it. ";
			if (dobj = carrot) "Carrots are his favorite, you know. ";
			else "Too bad it wasn't his favorite food. ";
			if (defined(dobj,&newenergy)) {
				if (dobj.newenergy > self.foodenergy) {
					self.foodenergy := dobj.newenergy;
					if (self.foodenergy > 7)
						"He seems phenomenally energetic now!";
					else if (self.foodenergy > 4)
						"He seems a lot more energetic now.";
					else
						"He is a bit more energetic now.";
				}
			}
			dobj.moveInto(nil);

			/* If Corduroy is in the treadmill and wasn't already running,
			 * he should start.
			 */

			if (self.foodenergy > 0 and self.isrunning = nil and
					self.location = treadmill) {
				self.isrunning := true;
				notify(self, &decreaseEnergy, 0);
				"\nBeing a health-conscious hamster, Corduroy has decided to
				run off his new energy in the cylinder.";
			}
		    }
		}
		else
			"Corduroy doesn't seem too interested in <<dobj.thedesc>>.";
	}

	bulk = 5
	weight = 5

	isrunning = nil

	decreaseEnergy() = {
		if (self.isrunning = true) {
			self.foodenergy := self.foodenergy - 1;
			if (self.foodenergy = 0) {
				self.isrunning := nil;
				unnotify(self, &decreaseEnergy);
				if (Me.location = wind_tunnel)
					"Corduroy seems pooped out, and has stopped moving.";
			}
			else {
				chamber.spinPropeller(foodenergy);
			}
		}
	}

;

chicken: littleactor, animal
	sdesc = "chicken"
	ldesc = "The chicken is wondering whether to cross the information
		highway."
	noun = 'chicken'
	location = chickenpen

	moved = nil

	moveme = {
		"Moving the chicken reveals an egg.\n";
		self.moved := true;
		egg.moveInto(self.location);
	}
	moveInto(loc) = {
		if (self.moved = nil) self.moveme;
		pass moveInto;
	}
	verDoMove( actor ) = {
		if (self.moved) "Moving <<self.thedesc>> doesn't reveal anything. ";
	}
	doMove(actor) = { self.moveme; }
	verDoMoveTo( actor ) = {
		if (self.moved) "Moving <<self.thedesc>> doesn't reveal anything. ";
	}
	verDoMoveWith( actor ) = {
		if (self.moved) "Moving <<self.thedesc>> doesn't reveal anything. ";
	}
;

mobots: inactivenpc, uninterestednpc, pluralnpc
	sdesc = "mobots"
	adesc = "mobots"
	ldesc = "The mobots are behaving strangely, squirting from place to place."
	verDoRub(actor) = {}
	doRub(actor) = "The mobots are twitching too quickly for you to touch them."

	location = ai
	noun = 'mobot' 'mobots'

	isListedActor = nil
;

salesman: movingnpc, messagingnpc, person
	sdesc = "salesman"
	ldesc = "The salesman looks like quite a shady character.
		His cloak is dusty and rumpled; no wonder, as he has been 
		travelling extensively in his quest for filthy lucre."
	location = inst_entrance

	noun = 'salesman'
	adjective = 'travelling' 'traveling' 

	cycle = [ 2 &north 2 &north 2 &south 2 &east 2 
		&west 2 &south 2 &west 2 clearing 2 &west 2 &north]
	messageD = 2
;
