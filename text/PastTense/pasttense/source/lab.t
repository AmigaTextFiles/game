
greenRoom: Room
	noun = 'greenroom'
	
	sdesc = "Store room"
	ldesc = {
		I();
		"The air <<t.is>> filled with dust motes swirling about in a 
		pillar of light that <<t.streams>> down from a skylight far 
		overhead.  There <<t.is>> a stack of wooden crates lurking 
		in one shadowy corner and a shelf running along the wall.  
		An impressive metal door <<t.is>> to the south. ";
	}
	
	goSouth = security
;

shelf: Qsurface, Over
	sdesc = "shelf"
	ldesc = {
		"It <<t.looks>> like an ordinary shelf. ";
		self.doLookon(global.lastactor);
	}
	noun = 'shelf'
	
	location = greenRoom
;

crates: Decoration
	sdesc = "stack of crates"
	ldesc = {
		P(); I();
		"The crates <<t.are>> stacked one on 
		top of the other and <<t.reach>> almost to the ceiling. ";
		if (slip.location = nil) {
			"Returning your gaze to the floor, you <<t.notice>> a scrap of paper
			in the shadows beside the base of the tower. ";
			slip.movein(self.location);
			slip.makeknownto(global.lastactor);
			setit(slip);
		}
	}
	noun = 'stack' 'pile' 'crate' 'box' 'markings' 'tower'
	adjective = 'crates' 'boxes' 'wooden'
	
	location = greenRoom
	
	verDoOpen(actor) = { "You would need a crow-bar for that. "; }
;

class Seekerbot: Obstacle
	sdesc = "seeker-bot"
	ldesc = "It <<t.isnt>> there anymore. "
	
	noun = 'bot' 'robot'
	adjective = 'flying' 'seeker' 'airborne'
;

securityBot: Seekerbot
	
	location = security
	
	destination(actor) = {
		if (not (botSwitch.isactive))
			return archives;
		else if ((popcorn.flying) 
			and ((popcornBag.location = Me) 
				or (popcornBag.location = Me.location))) {
			P(); I();
			if (not (self.tried)) { "A nasty airborne seeker-bot "; }
			else { "The seeker-bot "; }
			"<<t.flies>> out of the wall
			
			and <<t.impales>> one popcorn puff after another
			on its pointy nose with frightening precision.
			The flurry of popcorn in the air <<t.distracts>> it just long enough
			for you to rush into the room beyond the corridor! ";
			
			robotAh.solve; // stop showing robot hints
			
			"\b";
			return archives;
		}
		else if (not (self.tried)){
			self.tried := true;
			P(); I();
			"As soon as you <<t.start>> walking down the hall, an airborne
			seeker-bot <<t.darts>> from
			a concealed wall panel, <<t.locks>> on to your pattern of movement,
			and <<t.proceeds>> to give you a nasty sting with one of its many 
			perilous appendages!  Fortunately, you <<t.are>> able to back out of the
			way before you <<t.are>> mortaly wounded. ";
			P(); I();
			"Sensing that you were no longer a security threat, 
			the 'bot <<t.disappears>> into the wall. ";
			
			robotAh.seen; // start showing hints for the 'bot
			
			return nil;
		}
		else {
			P(); I();
			"Once again the seeker-bot <<t.shoots>> from the wall 
			and immediatly <<t.homes>> in on your
			motion.  After forcing you away from the west end of the corridor, 
			the 'bot <<t.flies>> out of sight. ";
			return nil;
		}
	}
;

vaultBot: Seekerbot
	
	location = archives
	
	destination(actor) = {
		if (not (botSwitch.isactive))
			return security;
		else {
			P(); I();
			"As soon as you <<t.step>> into the corridor the seeker-bot
			 <<t.attacks>> with a vengeance, forcing you back into the room. ";
			return nil;
		}
	}
;

panel: Unimportant
	sdesc = "concealed panel"
	ldesc = "It <<t.is>> very well concealed indeed. "
	noun = 'panel'
	adjective = 'concealed' 'hidden' 'secret' 'wall'
	location = security
;

archives: Room
	noun = 'archives'
	sdesc = "Archives"
	
	ldesc = {
		I();
		"Rows of empty shelves <<t.suggest>> that this had once been
		a repository for scientific literature, but now the only
		fixtures of note <<t.are>> the switch by the eastern exit
		and the massive safe that <<t.dominates>> the room. ";
	}
	
	goEast = vaultBot
	
	goNowhere(actor) = {
		"The only exit from the room <<t.is>> the security corridor to the east. ";
	}
;

emptyShelves: Unimportant, Surface
	sdesc = "empty shelves"
	
	isplural = true
	noun = 'shelves' 'shelf'
	adjective = 'empty'
	
	location = archives
;

botSwitch: Switch
	isactive = true
	sdesc = "switch"
	
	noun = 'switch'
	
	location = archives
;

ampoule: Item
	sdesc = "ampoule"
	adesc = "an ampoule"
	ldesc = "A small bulbous glass vessel hermetically sealed
		and used to hold a solution for hypodermic injection. "

	noun = 'ampoule' 'ampul' 'vial' 'vessel' 'drug' 'formula' 'medicine' 'flask'
	adjective = 'glass' 'small'
	
	location = safe
;

safe: Openable
	sdesc = "safe"
	
	ldesc = {
		P(); I();
		"The safe <<t.is>> painted bright orange, a clear sign that
		the owner's aesthetic sense <<t.has>> been perverted by
		long years of evil-doing. 
		There <<t.are>> three dials on the face of the safe. ";
		pass ldesc;
	}
	
	
	noun = 'safe' 'vault'

	verDoUnlock(actor) = {
		"That's probably what the three dials on the face of 
		the safe <<t.are>> there for. ";
	}
	verDoLock(actor) = { self.verDoUnlock(actor); }

	verDoOpen(actor) = {
		if (self.isopen)
			"\^<<self.subjthedesc>> <<self.is>> already open. ";
		else if ((not (leftDial.setting = 79))
			or (not (centerDial.setting = 2))
			or (not (rightDial.setting = 30)))
			"The safe <<t.is>> locked. ";
	}
	
	location = archives
;

class Safedial: Dial, Part
	partof = safe
	minsetting = 0
	maxsetting = 99
	plural = 'dials'
	noun = 'dial'
	
	ldesc = {
		"It <<t.is>> currently set to <<self.setting>>. ";
	}

	doTurnto(actor, io) = {
		if (io = numObj) {
			if (numObj.value < self.minsetting or
			    numObj.value > self.maxsetting) {

				    "There <<t.is>> no such setting; 
				    the dials <<t.can>> only be turned to settings 
					numbered from <<self.minsetting>> to 
					 <<self.maxsetting>>. ";
			    }
			 else if (numObj.value <> self.setting) {
				 self.setting := numObj.value;
				 "Okay, <<t.itis>> now turned to
				 <<self.setting>>. ";
			 }
			 else {
				 "\^<<t.itis>> already set to <<self.setting>>. ";
			 }
		}
		else {
			"%You% <<t.cant>> turn <<self.objthedesc(actor)>>
			\ to that. ";
		}
	}
;

leftDial: Safedial
	setting = 5
	sdesc = "left dial"
	adjective = 'left' 'first'
;

centerDial: Safedial
	setting = 47
	sdesc = "center dial"
	adjective = 'center' 'second' 'middle'
;

rightDial: Safedial
	setting = 86
	sdesc = "right dial"
	adjective = 'right' 'third' 'last'
;

lightsDec: Everywhere, Distant, Unimportant
	sdesc = "lights"
	
	isplural = true
	noun = 'lights' 'lighting'
	adjective = 'light' 'flourescent' 'track'
;

security: Room
	sdesc = "Security corridor"
	ldesc = {
		I();
		"You <<t.are>> in a sterile east-west corridor with a door in the north wall.
		The subtle hum of flourescent
		lighting <<t.enters>> on a new dimension in <<t.this>> silent atmosphere. ";
	}

	goNorth = greenRoom
	goEast = lab
	goWest = securityBot
	
	goNowhere(actor) = {
		"The security corridor <<t.runs>> east and west of here, 
		and there <<t.is>> a door to the north. ";
	}
	
;

lab: Room
	noun = 'lab'
	
	sdesc = "Laboratory"
	ldesc = {
		I();
		"In the laboratory the air <<t.is>> charged with the 
		heady presence of history in the making.
		The room <<t.is>> filled with evidence of experimentation; scientific 
		paraphernalia <<t.is>> bursting out of cabinets and 
		sprawling over the sizable lab table. 
		A rack of empty cages <<t.lines>> one of the walls, 
		and in one corner of the room there <<t.is>> an alcove 
		where a strange metal thing <<t.protrudes>> from the wall. 
		A smaller room <<t.can>> be entered to the south, and the
		security corridor <<t.runs>> to the west. ";
	}
	
	goWest = security
	goSouth = office
	
	
	goNowhere(actor) = {
		"The security corridor <<t.was>> to the west of here
		and there <<t.is>> another room to the south. ";
	}
;

junk: Unimportant
	sdesc = "scientific equipment"
	ldesc = "Petri dishes, balances, electrolytic spectrum analyzers, 
		echoes of higher-level chemistry courses you vaguely 
		 <<t.remember>> having taken in college. "
	
	noun = 'paraphernalia' 'junk' 'equipment' 'dishes' 'dish'
		'analyzers' 'balances' 'evidence' 'experiments' 'cabinets'
	adjective = 'scientific' 'petri' 'electrolytic' 'spectrum'

	location = lab
;

labTable: Table
	sdesc = "lab table"
	
	noun = 'table'
	adjective = 'lab'
	location = lab
;

cage: Decoration
	sdesc = "cages"
	ldesc = "Empty.  Every single one of the cages <<t.is>> empty.  The
		only evidence that they had once been inhabited <<t.is>> the lingering
		scent of cedar shavings. "
	
	isplural = true
	noun = 'cages' 'cage' 'shavings'
	adjective = 'empty' 'cedar'
	
	location = lab
	
	smelldesc = { "The cages <<t.smell>> faintly of cedar shavings. "; }
;
	

burner: Switch, Surface, Fixture
	isactive = nil
	pullable = nil
	moveable = nil	
	
	sdesc = "Bunsen burner"
	heredesc = "There <<t.is>> a Bunsen burner on the lab table. "
	ldesc = {
		"It <<t.has>> a small switch that <<t.can>> be turned on and off. ";
		self.doLookon(global.lastactor);
	}
	
	noun = 'burner' 'switch'
	adjective = 'bunsen'
	location = labTable
	locationtype = 'on'
	
	doTurnon(actor) = {
		self.isactive := true;
		"Okay, <<self.subjthedesc>> <<self.is>> now turned on. ";
	}
	
	verDoTake(actor) = {
		"The Bunsen burner <<t.is>> firmly affixed to the lab table. ";
	}
	
	putmessage(dobj, loctype) = {
		"You <<t.place>> <<dobj.thedesc>> <<loctype>> the Bunsen burner. ";
	}
	
	ioPutX(actor, dobj, loctype) = {
		local	i, islist;

		if (datatype(dobj) = 7)
			islist := true;
		else
			islist := nil;
		
		if (length(self.contents) > 0) {
			"There <<t.is>> already something on the burner. ";
			return;
		}

		if (not islist)
			if (defined(dobj, &doPutX)) {
				dobj.doPutX(actor, self, loctype);
				return;
			}
		
		// Can this Holder sustain the weight of the dobj?
		if (not self.verifyinsertion(actor, dobj, loctype, global.locmaxweight, &weight, &contentsweight, &weightexceeded))
			return;
		
		// Is there enough room to hold the dobj?
		if (not self.verifyinsertion(actor, dobj, loctype, global.locmaxbulk, &bulk, &contentsbulk, &bulkexceeded))
			return;
		// Move the object(s)
		if (islist) {
			for (i := 1; i <= length(dobj); i++)
				dobj[i].moveinto(self, loctype, global.loctake);

			self.putmessage(dobj[1], loctype);
		}
		else {
			if (dobj.moveinto(self, loctype, global.loctake))
				self.putmessage(dobj, loctype);
		}
	}

	
;


drain: Surface, Decoration
	item = drain
	
	sdesc = "drain"
	ldesc = {
		"It <<t.looks>> like an ordinary drain. ";
		if (self.item.location = drain) {
			self.doLookon(global.lastactor);
		}
	}
	
	noun = 'drain'
	
	location = lab
	
	movingout(obj, tolocation, toloctype) = {
		self.item := drain;
	}
	
	putmessage(dobj, loctype) = {
		"You <<t.plcae>> <<dobj.thedesc>> <<loctype>> the drain 
		underneath the metal thing. ";
		self.item := dobj;
	}
	
	ioPutX(actor, dobj, loctype) = {
		local	i, islist;

		if (datatype(dobj) = 7)
			islist := true;
		else
			islist := nil;
			
		if (self.item <> drain) {
			"There <<t.is>> already something on the drain. ";
			return;
		}
		
		if (not islist)
			if (defined(dobj, &doPutX)) {
				dobj.doPutX(actor, self, loctype);
				return;
			}
		
		// Can this Holder sustain the weight of the dobj?
		if (not self.verifyinsertion(actor, dobj, loctype, global.locmaxweight, &weight, &contentsweight, &weightexceeded))
			return;
		
		// Is there enough room to hold the dobj?
		if (not self.verifyinsertion(actor, dobj, loctype, global.locmaxbulk, &bulk, &contentsbulk, &bulkexceeded))
			return;


		// Move the object(s)
		if (islist) {
			for (i := 1; i <= length(dobj); i++)
				dobj[i].moveinto(self, loctype, global.loctake);

			self.putmessage(dobj[1], loctype);
		}
		else {
			if (dobj.moveinto(self, loctype, global.loctake))
				self.putmessage(dobj, loctype);
		}
	}

;

shower: Over, Decoration
	sdesc = "metal thing"
	ldesc = {
		P(); I();
		"It <<t.consists>> of a metal 
		pipe that <<t.terminates>> in what <<t.looks>> like huge shower head.  
		There <<t.is>> a handle hanging from the head, and a drain 
		on the floor underneath it. ";
	}

	noun = 'thing' 'shower' 'pipe' 'alcove'
	adjective = 'emergency' 'chemical' 'metal'

	location = lab
	
	doLookunder(actor) = { drain.doLookX(actor, 'on', nil); }

	verIoPutunder(actor) = { drain.verIoPuton(actor); }
	verIoThrowunder(actor) = { drain.verIoPuton(actor); }
	
	ioPutunder(actor, dobj) = { drain.ioPuton(actor, dobj); }
	ioThrowunder(actor, dobj) = { drain.ioPuton(actor, dobj); }
;

showerHead: Over, Part
	partof = shower

	sdesc = "shower head"

	noun = 'head'
	adjective = 'shower'

	doLookunder(actor) = { drain.doLookX(actor, 'on', nil); }
	
	verIoPutunder(actor) = { drain.verIoPuton(actor); }
	verIoThrowunder(actor) = { drain.verIoPuton(actor); }
	
	ioPutunder(actor, dobj) = { drain.ioPuton(actor, dobj); }
	ioThrowunder(actor, dobj) = { drain.ioPuton(actor, dobj); }
;

handle:	Part
	partof = shower
	
	sdesc = "handle"
	ldesc = "It <<t.looks>> very tempting... "

	noun = 'handle'

	verDoPush(actor) = { "It would be easier to pull the handle. "; }
	verDoTurn(actor) = { self.verDoPush(actor); }
	
	verDoPull(actor) = {}
	doPull(actor) = {
		"A torrent of water <<t.sprays>> from the head of the metal ";
		if (drain.item = drain) {
			"thing into the drain in the floor! ";
		}
		else if (drain.item = beaker) {
			"thing, filling the beaker! ";
			water.movein(beaker);
			water.makeknownto(global.lastactor);
		}
		else {
			"thing, thoroughly drenching <<drain.item.thedesc>>! ";
			drain.item.iswet := true;
		}
	}
;


water: Container, Decoration
	state = 0
	bulk = 0

	sdesc = "quantity of water"
	noun = 'water' 'liquid'
	adjective = 'quantity'
	
	verDoDrink(actor) = { "You <<t.arent>> thirsty enough to drink the water. "; }

	touchdesc = {
		if (water.state > 1) { "OUCH! That water sure <<t.is>> hot!"; }
		else { "The water <<t.feels>> pretty wet. "; }
	}
	
	
	verIoTakefrom(actor) = { beaker.verIoTakefrom(actor); }
	ioTakefrom(actor, dobj) = { beaker.ioTakefrom(actor, dobj); }
	
	doLookX(actor, loctype, emptyquiet) = 
		{ beaker.doLookX(actor, loctype, emptyquiet); }
		
	verIoPutX(actor, dobj, loctype) =
		{ beaker.verIoPutX(actor, dobj, loctype); }
	verifyinsertion(actor, obj, loctype, loclist, valprop, check, msg) =
		{ beaker.verifyinsertion(actor, obj, loctype, loclist, valprop, check, msg); }
	ioPutX(actor, dobj, loctype) = 
		{ beaker.ioPutX(actor, dobj, loctype); }
		
	weightexceeded(dobj, loctype) = { beaker.weightexceeded(dobj, loctype); }
	bulkexceeded(dobj, loctype) = { beaker.bulkexceeded(dobj, loctype); }
	putmessage(dobj, loctype) = { beaker.putmessage(dobj, loctype); }

;

beaker: Transparent, Container, Item
	maxbulk = 1
	isactive = nil

	sdesc = "beaker"
	ldesc = {
	P(); I();
		"A wide cylindrical glass vessel with a pouring lip, 
		normally used as a laboratory container or mixing jar. ";
		
		self.contdesc(global.lastactor);
	}
	
	noun = 'beaker' 'vessel' 'flask'
	adjective = 'glass' 'wide' 'cylindrical'
	
	location = shelf
	locationtype = 'on'
	
	putmessage(dobj, loctype) = {
		if (water.iscontained(beaker, 'in')) {
			"Sploosh!  \^<<dobj.thedesc>> <<t.is>> now in the beaker. ";
		}
		else inherited.putmessage(dobj, loctype);
	}
	
	doPutX(actor, io, loctype) = {
		if (water.state > 0) {
			"OUCH! The beaker <<t.is>> too hot for that! ";
			return;
		}
		// Can this Holder sustain the weight of the dobj?
		if (not io.verifyinsertion(actor, self, loctype, global.locmaxweight, &weight, &contentsweight, &weightexceeded))
			return;
		
		// Is there enough room to hold the dobj?
		if (not io.verifyinsertion(actor, self, loctype, global.locmaxbulk, &bulk, &contentsbulk, &bulkexceeded))
			return;

		if (self.moveinto(io, loctype, global.loctake))
			io.putmessage(self, loctype);

	}
	passgen(actor, obj, loctype, passmethod) = {
		// If not "in" containment or nil, call our parent's method.
		if (loctype <> nil and loctype <> 'in')
			return inherited.(passmethod)(actor, obj, loctype);

		if (water.state = 0)
			return true;
		else {
			"AAIEEEEE! The water <<t.is>> too hot to do that! ";
			return nil;
		}		
	}
	passcantouchin(actor, obj, loctype) = { 
		return self.passgen(actor, obj, loctype, &passcantouch);
	}
	passcantakein(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcantake);
	}
	passcansmellin(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcansmell);
	}

;

office: Room
	sdesc = "Office"
	ldesc = {
		I();
		"You <<t.are>> in a cozy nook just south of the laboratory,
		with several framed holographs hanging above an ancient writing desk. ";
	}

	goNorth = lab
	goNowhere(actor) = { "The laboratory <<t.is>> to the north. "; }
;

holographs: Unimportant
	sdesc = "holographs"
	ldesc = {
		P(); I();
		"Several of the holographs <<t.show>> a young girl of unsurpassed
		beauty; her elegant features <<t.are>> framed by waves of
		glossy black hair. In the largest picture, she <<t.is>> 
		smiling and waving to the camera from the railing of
		a land cruiser. 
		In some of the scenes she <<t.appears>> beside a handsome
		young man with a round face and penetrating eyes.
		The two <<t.seem>> to be quite good friends. ";
		P(); I();
		"Amidst the holos there <<t.is>> 
		old-fashioned print of The Periodic
		Table of the Elements"; note(periodicTable); ". ";
	}
	
	isplural = true
	noun = 'photos' 'photo' 'holo' 'holos' 'photographs' 'pictures' 
		'girl' 'man' 'holographs' 'holograms'
	adjective = 'framed' 'frames'
	
	location = office
;


periodicTable: Decoration
	sdesc = "print"
	ldesc = {
		P(); I();
		"\^<<t.itis>> an archaic rendition of the 
		Periodic Table of the Elements";
		note(self); ". ";
	}
	footnote = {
		"There is a copy of the print included in your archive. ";
	}
	noun = 'table' 'picture' 'artwork' 'print'
	adjective = 'periodic' 'elements'
	
	location = office
;

desk: Surface
	sdesc = "writing desk"
	ldesc = "\^<<t.itis>> a wooden desk with a long drawer in the front
		for storing writing materials. There <<t.seems>> to be a slot
		in the top of the desk with some buttons next to it."
	
	noun = 'desk' 'table'
	adjective = 'writing' 'old' 'wooden' 'ancient'
	
	location = office
	
	verDoOpen(actor) = {drawer.verDoOpen(actor);}
	doOpen(actor) = {drawer.doOpen(actor);}
;

drawer: Openable, Part
	maxbulk = 2
	partof = desk

	sdesc = "drawer"
	
	noun = 'drawer'
	adjective = 'desk' 'long'
;

slip: Readable, Item
	isflamable = true // can be destroyed by bunsen burner
	
	sdesc = "scrap of paper"
	ldesc = "The words \"gold helium zinc\" <<t.are>> hastily
		scrawled on the scrap of paper. "
		
	noun = 'slip' 'writing' 'scrap'
	adjective = 'paper'
	
	location = nil
;

handwarmer: Item, Readable
	state = 0
	
	sdesc = "small packet"
	ldesc = "A palm-sized packet with instructions printed on one side. "
	readdesc = { heatInstructions.readdesc; }
	
	noun = 'pack' 'pouch' 'handwarmer' 'warmer' 'packet'
	adjective = 'heat' 'hot' 'neatheat' 'hand'
	
	location = drawer
	
	verDoRub(actor) = {}
	doRub(actor) = {
		if (handwarmer.state = 0) {
			warmerAh.see; // start showing hints
			"Nothing <<t.happens>>.  Perhaps it <<t.has>> already been used. ";
		}
		if (handwarmer.state = -1) {
			"Waves of heat <<t.radiate>> from the pouch. ";
			handwarmer.state := 10;
			warmerAh.solve; // stop showing hints
		}
	}
	
	touchdesc = { "The handwarmer <<t.feels>> pretty <<self.temp>>. "; }
	
	doPutX(actor, io, loctype) = {
		if (handwarmer.temp = 'hot') {
			"The handwarmer <<t.is>> too hot to handle! ";
		}
		else {
			if (handwarmer.temp = 'warm') {
				"The handwarmer <<t.is>> warm to the touch. ";	
			}
			// Can this Holder sustain the weight of the dobj?
			if (not io.verifyinsertion(actor, self, loctype, global.locmaxweight, &weight, &contentsweight, &weightexceeded))
				return;
			
			// Is there enough room to hold the dobj?
			if (not io.verifyinsertion(actor, self, loctype, global.locmaxbulk, &bulk, &contentsbulk, &bulkexceeded))
				return;

				if (self.moveinto(io, loctype, global.loctake))
					io.putmessage(self, loctype);

		}
	}
;

heatInstructions: Readable, Part
	partof = handwarmer
	
	sdesc = "instructions on the heat pack"
	ldesc = {
		"\b\tNeatHEAT(tm) Handwarmer
		\b
		\tIntructions:
		Just RUB HANDWARMER to release heat!
		\b
		\tYour handwarmer is reusable!
		\n\tSimply place it in boiling 
		\n\twater for a full recharge!
		\n";
	}
	
	noun = 'instructions'
	adjective = 'handwarmer'
;

popcornBag: Openable, Item, Readable
	maxbulk = 2

	sdesc = "microwave popcorn bag"
	ldesc = {
		"There <<t.is>> a warning label on it. ";
		inherited.ldesc;
	}
	readdesc = { warningLabel.readdesc; }
	
	noun = 'bag'
	adjective = 'microwave' 'instant' 'popcorn'
	
	location = sofa
	locationtype = 'on'
;

warningLabel: Part, Readable
	partof = popcornBag
	
	sdesc = "warning label on the microwave popcorn bag"
	ldesc = {
		"\b\tDO NOT cook with bag open.
		\n\tDO NOT overcook, as popcorn may scorch.
		\n\tDO NOT leave microwave unattended while popping corn.\n";
	}
	
	noun = 'label'
	adjective = 'warning'
;

kernels: Decoration
	sdesc = "popcorn kernels"
	
	isplural = true
	noun = 'kernels' 'seeds'
	adjective = 'popcorn' 'corn' 'unpopped'
	
	location = popcornBag
;

popcorn: Edible, Item
	sdesc = "popcorn"
	adesc = "some popcorn"
	ldesc = "\^<<t.itis>> a bit scorched, but by all means edible. "
	
	noun = 'popcorn'
	adjective = 'some' 'popped' 
	
	isknownto(actor) = { return true; }
;

discPlayer: Container
	maxbulk = 1
	disc = discPlayer
	
	sdesc = "slot"
	ldesc = "A slot approximately three and a half inches wide. "
	
	noun = 'slot'
	
	ioPutin(actor, dobj) = 
	{	
		if (not (dobj.isdisc) ) {
			"\^<<dobj.thedesc>> <<t.wont>> fit into the slot. ";
		}
		else {
			"You <<t.place>> <<dobj.thedesc>> into the slot. ";
			self.disc := dobj;
			self.disc.movein(nil);
		}
	}
	location = office
;

ejectButton: Button, Part
	partof = discPlayer
	
	sdesc = "red button"
	
	plural = 'buttons'
	noun = 'button'
	adjective = 'eject' 'red'
	
	doPush(actor) = {
		if (discPlayer.disc = discPlayer) {
			"<beep>\n";
		}
		else {
			discPlayer.disc.moveon(desk);
			discPlayer.disc.marker := 1;
			"\^<<discPlayer.disc.thedesc>> <<t.pops>> out of the slot and <<t.lands>> 
				on the writing desk. ";
			setit(discPlayer.disc);
			discPlayer.disc := discPlayer;
		}
	}
;

playButton: Button, Part
	partof = discPlayer
	sdesc = "green button"
	
	plural = 'buttons'
	noun = 'button'
	adjective = 'play' 'green'
	
	doPush(actor) = {
		if (discPlayer.disc = discPlayer) {
			"<beep>\n"; // \"Please insert disc.\" 
		}
		else {
			if (discPlayer.disc.marker = 1) {
				discPlayer.disc.firstMsg;
			}
			P(); I();
			"\"";
			say (discPlayer.disc.entries[(discPlayer.disc.marker)]);
			"\"";
			discPlayer.disc.marker := discPlayer.disc.marker + 1;
			if ((discPlayer.disc.marker) > (length( discPlayer.disc.entries ))) {
				discPlayer.disc.marker := 1;
//			"\b<end>\n";
			}
			else "\b<blink>\n";
		}
	}
;

journalDisc: Readable, Item
	marker = 1
	isdisc = true
	sdesc = "disc"
	location = drawer
	ldesc =
	{
	//	P(); I();
		"\^<<t.itis>> a standard 3.5\" audio disc 
		labeled \"Private Musings.\" ";
	}
	
	noun = 'disc' 'disk' 'record' 'diary'
	adjective = 'audio' 'private' 'musings'
	
	readdesc = "\"Private Musings.\" "
	
	firstMsg = "A thin, reedy voice <<t.issues>> from the slot:"
	
	entries = [
		'Ben made a wonderful discovery today.
		His studies with our test subjects have revealed a
		frightening side-effect of the Kytol infusion;
		two of the animals in the experimental group 
		are cataleptic, and three others are beginning to
		exhibit psychotic behavior.'
		
		'During luch today we discussed the results of Ben\'s
		experiments.  My darling Lee is going to
		take some tissue samples from the afflicted test subjects.'
	
		'I had a frightening dream last night;  in the dream 
		it was Araqaba, which I imagined to be a great holy 
		day, and I was visiting a retreat with Nob-Himan.  
		At first I was comfortable discussing my research 
		with my soul brother, but then Himan changed.  His 
		face turned inside out and I could see Lee\'s 
		reflection in his inverted retinas. Nob-Himan 
		lept at me and scarred my face with steely claws.  
		Hot blood flowed down my cheeks, and in the wake of 
		the red river I saw a gross figure draped in 
		black robes devouring Lee\'s flesh.'

		'We have worked long and hard at our little pet project,
		and at noon tomorrow we shall reap the rewards.
		The formula has been perfected, and with it we shall
		hold the Free World as our hostage.  If the Prime Executor does
		not bend to our every whim, we shall sow the seeds of
		our new plague!  MUHAHAHAHA!'
		
	]
;




