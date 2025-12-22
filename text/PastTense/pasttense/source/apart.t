
startroom: Room
	noun = 'startroom'
	
	sdesc = "Your bedroom"
	ldesc = {
		I();
		"\^<<t.itis>> a good thing that you <<t.live>> alone; 
		there <<t.is>> barely enough room for the single bed 
		that <<t.is>> crammed into the corner of your tiny bedroom.  
		A small bedside table <<t.takes>> up the rest of the space.  
		The rest of your apartment <<t.is>> to the south.";
	}
	
	goSouth = yourApartment
	goOut = yourApartment
	
	goNowhere( actor ) = {
		"The only exit from your room <<t.is>> to the south. ";
		return;
	}
;


mailLabel: Readable, Part
	partof = package
	
	sdesc = "mailing label on the mysterious package"
	ldesc = {
		"\b\t\t	Secret Agent Pritel
		\n\t\t10487 Groathaus Park, Apt 13B
		\n\t\tLuxford, NY 87241-2395-12AF
		\n";
	}
		
	noun = 'label'
	adjective = 'mailing' 'address'
;

package: Openable, Readable, Item
	isopen = nil
	firstTime = true
	maxbulk = 2
	
	sdesc = "mysterious package"
	ldesc = {
		if (self.firstTime) {
			"A small package wrapped in coarse brown paper, 
			featureless except for a mailing label. ";
		}
		else {
			"A small unwrapped package, 
			featureless except for a mailing label. ";
		}
	}
	readdesc = { mailLabel.readdesc; }
		
	noun = 'package' 'box'
	adjective = 'brown' 'mysterious' 'unwrapped' 'coarse' 'paper'
	
	location = sofa
	locationtype = 'on'
	
	doOpen( actor ) =
	{
		if (self.firstTime) {
			self.firstTime := nil;
		
		
			P(); I();
			"Even as you <<t.rip>> the package open, you <<t.remember>> the 
			voice of your long-dead grandmother warning you about
			opening other people's mail. ";
			P(); I();
			"\"But this is different!\" you <<t.tell>> your grandmother.  
			\"I'm sure that Mr.\ John Steele 
			would want me to open this package for him just in case 
			it turns out to be something dangerous like a mail bomb, or something
			disgusting like a severed finger, or...\" ";

			self.isopen := true;
			P(); I();
			"Opening the package <<t.reveals>> a handwritten note and a green cube. ";
		
			self.makecontentsknownto(actor);
		}
		else { inherited.doOpen(actor); }
	}
;

ransomNote: Readable, Item
	sdesc = "handwritten note"
	ldesc = "The note <<t.reads>>:
	\b
	\t		ATTN Agent Pritel: Our spies have pinpointed 
	\n\t	the location of the evil Dr.\ Wang-Chung's secret 
	\n\t	laboratory. Once you have jumped to the site 
	\n\t	and retrieved the deadly formula, relay it to 
	\n\t	your contact at The Cathedral.  You will 
	\n\t	recognize her by the phrase, \"Canadian geese 
	\n\t	need to fly south in the winter.\" The countersign is 
	\n\t	\"Put the chunky tofu into the river.\" 
	\b
	\t		The fate of the Free World is in your hands, Pritel.
	\n"
	
	noun = 'note' 'message' 'handwriting'
	adjective = 'handwritten' 'ransom'
	
	location = package
	
	verDoEat(actor) = {}
	doEat(actor) = {
		"You hastily cram the note into your mouth and chew vigorously,
		desperate to conceal the evidence of your postal transgression. ";
		self.movein(nil);
	}
;

yourBed: Bed
	sdesc = "your bed"
	ldesc =
	{
		"Well, there probably <<t.arent>> TOO many insects devouring 
		your mattress from the inside out. ";
	}
	
	noun = 'bed' 'mattress' 'insects'
	adjective = 'my'
	thedesc = "your bed"
	adesc = "your bed"
	
	isdetermined = true
	reachsurroundings = true
	location = startroom
;

bedsideTable: Table, Unimportant
	sdesc = "bedside table"
	
	noun = 'table'
	adjective = 'bed' 'side' 'bedside'
	
	location = startroom
;

alarmClock: Unimportant
	sdesc = "alarm clock"
	ldesc = {
		"The cheery red digits on the face of the 
		alarm clock <<t.tells>> you that it <<t.is>> far too
		early to be awake. ";
	}
	
	noun = 'clock' 'alarmclock' 'digits' 'time'
	adjective = 'alarm' 'red'
	
	location = bedsideTable
	locationtype = 'on'
;

yourApartment: Room
	sdesc = "Your apartment"
	ldesc = {
		I();
		"Thanks to the annual housing lottery, 
		you <<t.live>> in a run-down termite farm with
		no ventilation and no kitchen to speak of.
		It <<t.isnt>> much, but at least <<t.itis>> better than
		the squalid coffin that you were assigned last year. ";
		P(); I();
		"The walls <<t.are>> plastered with posters of your
		favorite celebrities, primarily to conceal the
		garish wallpaper underneath.
		The only sub-room, the place where you <<t.fight>> a nightly battle
		with insomnia, <<t.is>> to the north, and the front door
		of your apartment <<t.is>> to the east.";
		P(); I();
		"The previous occupant left behind a sofa and 
		a VidNet receiver, both of which <<t.are>> seriously outdated.
		The receiver only <<t.picks>> up 176 channels and the 
		sofa <<t.has>> so many broken springs that it <<t.creaks>> before you
		even <<t.sit>> down on it, but they <<t.doH>> make your place
		feel like \"home.\"";
	}

	wallsdesc = { posters.ldesc; }
	
	goNorth = startroom
	goIn = startroom
	goOut = yourFrontDoor2
	goEast = yourFrontDoor2
	
	goNowhere( actor ) = {
		"Your apartment <<t.is>> really a rat-trap; you <<t.can>> only go north
		into the bedroom or exit the flat through the door to the east.";
		return;
	}
;

posters: Unimportant
	sdesc = "posters"
	ldesc = {
		P(); I();
		"Most of the posters <<t.are>> of Spenk Fizzleheim, 
		the bigger than big, ultra-famous daytime VidNet star 
		who revolutionized the medium in 2063 with the first 
		live broadcast of his drug-induced psychotic visions. ";
	}
	
	isplural = true
	noun = 'Fizzleheim' 'star' 'celebrities' 'stars' 'posters' 'wallpaper'
	adjective = 'Spenk' 'movie'
	
	location = yourApartment
;

VNreceiver: Unimportant
	sdesc = "VidNet receiver"
	ldesc = "A standard entertainment unit. "
	
	noun = 'receiver' 'television'
	adjective = 'vidnet'
	
	location = yourApartment
	
	verDoTurnon(actor) = {
		"You <<t.have>> better things to do than watch the Net. ";
	}
	verDoTurnoff(actor) = {
		"It <<t.isnt>> turned on. ";
	}
;

sofa: Bed, Decoration
	sdesc = "sofa"
	
	noun = 'sofa' 'couch' 'divan' 'furniture'
	adjective = 'comfortably' 'comfy'
	
	location = yourApartment
;

yourFrontDoor1: Door
	isopen = nil
	doordest = yourApartment
	otherside = yourFrontDoor2
	
	sdesc = "front door"
	ldesc = {
		"The door to your apartment. ";
		inherited.ldesc;
	}
	
	noun = 'door'
	adjective = 'front' 'apartment'
	
	location = firstLanding
;

yourFrontDoor2: Door
	isopen = nil
	doordest = firstLanding
	otherside = yourFrontDoor1
	
	sdesc = "front door"
	
	noun = 'door'
	adjective = 'front'
	
	location = yourApartment
;

firstLanding: Room
	sdesc = "Outside apartment 13A"
	ldesc = {
		I();
		"The stairwell outside your apartment <<t.is>> one
		of those places that you just <<t.dont>> want to spend
		too much time in.  The crumbling cement walls 
		 <<t.are>> scarred with cryptic graphitti, 
		and the sharp odor of stale urine
		 <<t.mingles>> with the smell of rancid garbage to create
		a distinctively repulsive bouquet.
		Your apartment <<t.is>> to the west and the door 
		to the street <<t.is>> to the south.  
		A flight of stairs <<t.goes>> up to the second floor.
		";
	}
	
	wallsdesc = { graffiti.ldesc; }
	
	goIn = yourFrontDoor1
	goWest = yourFrontDoor1
	goUp = secondLanding
	goSouth(actor) = { fakeDoor.noSouth; return nil; }
	goOut(actor) = { fakeDoor.noSouth; return nil; }
	
	goNowhere( actor ) = 
	{
		"Your apartment <<t.is>> to the west and the door 
		to the street <<t.is>> to the south.  You <<t.can>> also go up
		the stairs to the second floor. ";
	}
;

stairs1: Decoration
	sdesc = "flight of stairs"
	
	noun = 'stair' 'stairs' 'stairwell'
	
	location = firstLanding
	
	verDoClimb(actor) = {}
	doClimb(actor) = { actor.travelto(secondLanding); }
;

stairs2: Decoration
	sdesc = "flight of stairs"
	
	noun = 'stair' 'stairs' 'stairwell'
	
	location = secondLanding
	
	verDoClimb(actor) = {}
	doClimb(actor) = { actor.travelto(firstLanding); }
;

fakeDoor: Door
	isopen = nil
	
	sdesc = "door to the street"
	ldesc = "The door to the street. "
	
	noun = 'door'
	adjective = 'to' 'street'
	
	location = firstLanding
	
	doOpen(actor) = { self.noSouth; }
	noSouth = {
		if (not fakeDoor.tried) {
			P(); I();
			"You <<t.begin>> to head outside but then <<t.reconsider>>;
			the last time you went for a walk this early in the
			morning you were picked up by a patrol cruiser
			and sealed in a containment tank for three days
			for violating the curfew. Not fun. ";
			
			fakeDoor.tried := true;
		}
		else { 
			P(); I();
			"No, you'd better not go outside.  \^<<t.itis>> too early, 
			and you <<t.dont>> really feel like breaking the 
			curfew again. ";
		}
	}
;

graffiti: Decoration
	sdesc = "graffiti"
	ldesc = "Lord only knows which gang <<t.has>> claimed your 
		front porch as their territory. "
		
	noun = 'graffiti' 'paint'
	adjective = 'gang' 'spray'
	
	location = firstLanding
;

secondLanding: Room
	sdesc = "Outside apartment 13B"
	ldesc = {
		I();
		"The second story landing <<t.is>> much the same as 
		the first, with the exception that the offensive odors 
		that <<t.originate>> below <<t.have>> risen and coalesced 
		into an asphyxiating miasma"; note(self); ". ";
		P(); I();
		"The door to apartment 13B <<t.is>> to the west. ";
	}
	
	goUp(actor) = { 
		P(); I();
		"You <<t.walk>> up a few more stairs, but a stench several 
		times more offensive than anything
		at the lower levels <<t.encourages>> you to return to the second
		story landing. There probably <<t.isnt>> anything
		exciting up there anyway. ";
		return nil;
	}
	footnote = {
		"One of these days you really <<t.are>> going to have to talk
		to the landlord about getting a ventilation
		system installed in the building. 
		The only reason you <<t.havent>> done so already
		 <<t.is>> an awareness of the fact that nothing shy of blackmail
		or homicide <<t.is>> likely to convince the old fart to loosen his
		purse strings. ";
	}
	goIn = frontDoor1
	goWest = frontDoor1
	goDown = firstLanding
	
	goNowhere( actor ) = 
	{
		"Apartment 13B <<t.is>> to the west, and you <<t.can>> always
		risk walking up or down the stairs. ";
		return;
	}
;


frontDoor1: Door
	isopen = nil
	islocked = nil
	islockable = true
	doordest = wangApartment
	otherside = frontDoor2
	
	sdesc = "door"
	ldesc = "You <<t.size>> up the door to apartment 13B. "
	
	noun = 'door'
	adjective = 'front' 'apartment'
	
	location = secondLanding
	
	destination(actor) = {
		if (self.isopen) {
			self.sneakMsg;
			return self.doordest;
		}
		else if (not self.islocked and not self.noautoopen) {
			self.isopen := true;
			if (self.otherside)
				self.otherside.isopen := true;
			"(Opening <<self.objthedesc(nil)>>)\n";
			self.sneakMsg;
			return self.doordest;
		}
		else {
			"\^<<actor.youll>> have to open
			 <<self.objthedesc(actor)>> first.";
			
			setit(self);
			return nil;
		}
	}
	
	doKnockon(actor)= {
		"You <<t.knock>> on the door and <<t.wait>> for a response,
		but it <<t.is>> soon evident that you <<t.werent>> going to get one. ";
	}
	
	sneakMsg = {
		P(); I();
		"Looking over your shoulder to make sure that there 
		 <<t.is>> no one to witness your intrusion, you <<t.enter>> 
		the apartment. \b ";
	}
;

frontDoor2: Door
	isopen = nil
	islocked = nil
	islockable = true
	doordest = secondLanding
	otherside = frontDoor1
	
	sdesc = "front door"
	
	noun = 'door'
	adjective = 'front' 'apartment'
	
	location = wangApartment
;

wangApartment: Room
	noun = 'apartment'
	
	sdesc = "Apartment 13B"
	ldesc =
	{
		I();
		"The apartment <<t.is>> elegantly appointed with exquisite
		wall hangings and designer furniture.  Green plants,
		exotic sculptures, and a huge video tank <<t.fill>> the room.
		There <<t.are>> signs of chaos amidst the finery; 
		a mirror spattered with blood <<t.lies>> shattered 
		on the floor next to an overturned coffee table. ";
		P(); I();
		"Aside from the unorthadox interior decoration, 
		the apartment <<t.is>> just like your own, 
		with a small bedroom to the north. ";
	}
	
	goEast = frontDoor2
	goOut = frontDoor2
	goIn = bedroom
	goNorth = bedroom
	
	goNowhere( actor ) = {
		"The bedroom <<t.is>> to the north
		and the front door <<t.is>> to the east. ";
		return;
	}
;

videoTank: Unimportant
	sdesc = "video tank"
	ldesc = "The video tank <<t.has>> a projection area unrivaled by that
		of your own puny receiver.  "
	noun = 'tank' 'receiver' 'tv'
	adjective = 'video' 'vid'
	location = wangApartment
;

plants: Unimportant
	sdesc = "plants"
	ldesc = "What a disgusting waste of water. "
	
	isplural = true
	noun = 'plants' 'plant'
	adjective = 'green'
	
	location = wangApartment
;

sculpture: Unimportant
	sdesc = "sculptures"
	ldesc = "The sculptures <<t.look>> very expensive. "
	
	isplural = true
	noun = 'sculptures' 'statues'
	adjective = 'exotic'
	location = wangApartment
;

hangings: Unimportant
	sdesc = "wall hangings"
	ldesc = "They <<t.are>> finely woven rugs in a variety of muted patterns. "

	isplural = true
	noun = 'rugs' 'hangings' 'patterns' 'rug'
	adjective = 'wall' 'muted'

	location = wangApartment
;

furniture: Unimportant
	sdesc = "furniture"
	ldesc = "It <<t.is>> better than anything you'll ever own. "

	noun = 'furnishings' 'decor'

	location = wangApartment
;

mirror: Unimportant
	sdesc = "shattered mirror"
	ldesc = {
		"You <<t.gaze>> into the mirror but hardly <<t.recognize>> your own
		reflection cracked and smeared with blood. ";
	}
	
	noun = 'mirror' 'blood' 'reflection'
	adjective = 'broken' 'my' 'full' 'length' 'shattered' 'cracked'
	
	location = wangApartment
;

coffeeTable: Unimportant
	sdesc = "coffee table"
	ldesc = "The table <<t.is>> like a dead animal lying on its back 
		with stubby legs erect. "
		
	noun = 'table' 'legs'
	adjective = 'coffee' 'overturned'
	
	location = wangApartment
;

bedroom: Room
	noun = 'bedroom'
	
	sdesc = "Bedroom"
	ldesc = {
		I();
		"The ascetic simplicity of the stark cubicle <<t.is>> 
		quite a contrast to the indulgent display in the outer room. 
		A cot <<t.is>> situated against the far wall 
		and a sleeping mat <<t.lies>> on the foor. ";
	}
	
	wallsdesc = { holographs.ldesc; }
	
	goOut = wangApartment
	goSouth = wangApartment

	goNowhere(actor)= {
		"The rest of the apartment <<t.is>> to the south. ";
		return;
	}
;

sleepingMat: Bed
	sdesc = "sleeping mat"
	ldesc = "A length of blue cushioning securely 
		affixed to the floor. "
		
	noun = 'mat' 'cushioning'
	adjective = 'blue' 'sleeping'
	
	location = bedroom
;

cot: Bed
	sdesc = "cot"
	ldesc = {
		if (jumpStick.location = nil) {
			jumpStick.moveunder(self);
			jumpStick.makeknownto(global.lastactor);
			jumpStick.makecontentsknownto(global.lastactor);
		}
		if ((jumpStick.location = self) and 
			(jumpStick.locationtype = 'under')) {
			"A black cylinder <<t.seems>> to have rolled underneath the cot. ";
			setit(jumpStick);
		}
		else "A green canvas cot. ";
	}
	
	noun = 'cot' 'bed'
	adjective = 'green' 'canvas' 'army'
	
	location = bedroom
	
	doLookunder(actor) = {
		if (jumpStick.location = nil) {
			jumpStick.moveunder(self);
			setit(jumpStick);
			jumpStick.makeknownto(global.lastactor);
			jumpStick.makecontentsknownto(global.lastactor);
		}
		if (jumpStick.location = self) {
			"A black cylinder <<t.seems>> to have rolled underneath the cot. ";
			setit(jumpStick);
		}
		else inherited.doLookUnder(actor);
	}
;


