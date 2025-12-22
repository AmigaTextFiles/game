/*
 * Your starting note
 */

momnote: ouritem, readable
	sdesc = "note"
	ldesc = "The note is to you from your mother, and has been tattered and
		torn during the long bus trip from your home in Western Unnkulia."
	noun = 'note'
	adjective = 'tattered' 'torn' 'worn'

	location = Me
	readdesc =
		"The worn note reads:\b\b

		Dear Kluuless,\b\b

		\tI know you're scared of leaving home, but eventually someone
		in our family has to rise above the mediocrity and subsistence
		your grandparents and father were so proud of. \"What's good
		enough for the squirrels is good enough for us,\" they used to
		say, but the fact is that in this era of programmable toasters
		and argumentative elevators, our way of life is near its end,
		and you must take us on.\b

		\tThe Acme Institute is supposed to be the best technical school
		in all of Unnkulia.  You'll do fine there, and so will Corduroy.
		I've saved and stolen all my life to pay for your bus fare; make
		me proud.\b

		\t\t\t\t\t\t Love,\b

		\t\t\t\t\t\t\t\t\t\t Mom.\b

		\tP.S.\ Remember- the admissions department's number is 253-6567.\b"

	verDoAttack(actor) = "You never were a good singer."
;

/*
 * Rooms
 */

startroom: outsideroom
	sdesc = "Path"
	ldesc = { "You are on the infrequently-traveled path that leads from
			the Unnkulian bus terminal to the Acme Institute for the
			<<instname()>> Sciences.  To the north you see the path
			continue toward the distant buildings that make up the
			Institute.  On the east side of the path is a public
			phone booth, and to the south the depressing view of a
			bus station the	local government has preferred to ignore.";
		}
	south = { "Going south starts you off on the long road home again,
			back to the tedium and ignorance that have haunted
			your entire menial existance.  Isn't it time to improve
			your pathetic status?  Or are you scared of what lies
			ahead?  Chicken.";
		return( nil );
		}
	in = phonebooth
	east = phonebooth
	north = path_intersection
	west = { "Off into the wild west without a refractifier?  Doesn't sound
		too smart to me."; return(nil); }
;

start_path: ourdecoration	
	sdesc = "path"
	ldesc = "The dirt of the path has been tamped down until it resembles
		concrete by the feet of untold generations of hapless students."
	location = startroom
	noun = 'path'
;

busstation: ourdecoration
	sdesc = "bus station"
	ldesc = "The view of the bus station depresses you.  It stimulates some
		neural pathways, then shuts them down just a bit too quickly.
		Its symbolic link to your past depletes your brain of the
		few dopamine transmitters it has.
		The view marches your life's army of failures in front of your mind's eye,
		the sound of each soldier's step melding to create a mournful dirge
		of ego-crushing harmonies.
		It leaves you the same shattered shell of a simplistic soul that
		you have always been."
	noun = 'station' 'terminal'
	adjective = 'bus'
	location = startroom
;

buildings: ourdecoration
	sdesc = "buildings"
	adesc = "buildings"
	ldesc = "The buildings are too far away to make out any details."
	noun = 'buildings' 'building'
	adjective = 'distant'
	location = startroom
;

phonebooth: insideroom
	sdesc = "Public Phone Booth"
	ldesc = "You are in a cramped phone booth, slightly bigger than a breadbox but
		built to the usual poor Acme standards.  Not surprisingly, there isn't
		anywhere you can go but out."
	out = startroom
	west = startroom
;

path_intersection: outsideroom
	sdesc = "Path Intersection"
	ldesc = "The path that winds from the Unnkulian bus station in the south
		towards the famous institute in the north passes the
		Cheez Boar Inn, one of the most popular campus haunts, on the west
		side of the path.  On the other side of the path a smaller trail
		leads into the pleasant woods that surround the local campus."
	south = startroom
	east = clearing
	west = tavern
	in = tavern
	north = inst_entrance
;

path_intersect_path: ourdecoration	
	sdesc = "path"
	ldesc = "The dirt of the path has been tamped down until it resembles
		concrete by the feet of untold generations of hapless students."
	location = path_intersection
	noun = 'path'
;

class woods: ourdecoration
	sdesc = "woods"
	ldesc = "The woods surrounding the Acme Institute are a beautiful
		mixture of deciduous trees; oaks, maples, cherries, birch,
		and many others abound.  It's a far cry from the treeless,
		barren plains of Western Unnkulia."
	noun = 'woods' 'wood' 'trees'
;

path_woods: woods
	location = path_intersection
;

inn: ourdecoration
	sdesc = "Cheez Boar Inn"
	ldesc = "The Cheez Boar Inn is charmingly rustic, much like a gentleman's
		country cottage.  Quite a few old trees must have gone into its
		construction."
	noun = 'inn' 'tavern' 'bar'
	adjective = 'cheez' 'boar'
	location = path_intersection
;

clearing: outsideroom
	sdesc = "Clearing"
	ldesc =
		"This clearing in the woods surrounding the institute looks
		like it would be a good spot for a picnic, especially with the
		small cave in the north to explore.  The path from the west
		winds towards the southeast.  Where, you think to yourself,
		is the grate?  What sort of lousy adventure game would omit
		a grate in a clearing? "
	west = path_intersection
	se = bananaplace
	north = cave
	in = cave
;

clearing_cave: ourdecoration
	sdesc = "cave"
	ldesc = "It doesn't look like much of a cave from here; just a rough
		opening hewn into the rock of the hillside, almost hidden
		by the surrounding trees.  "
	noun = 'cave'
	adjective = 'small'
	location = clearing
;

clearing_woods: woods
	location = clearing
;

bananaplace: outsideroom
	sdesc = "Large Tree"
	ldesc = {
		"The intemperate clime of Unnkulia doesn't seem to impede the growth
		of vegetation.  A giant cherry tree dominates this section of the woods;
		its first branches start far, far over your head.  ";
		if (fruitflies.exist) "A small cloud of flies surrounds the tree.\b";
		else "\b";

		"As if the giant tree weren't enough of an oddity, near the base of
		the tree are 3 giant blocks, labeled on all sides with giant roman
		letters.\b

		The path from the northwest seems to end here, and probably exists
		only so that the institute's students can witness the absurdities
		around the tree.";

	}
	nw = clearing

	enterRoom(actor) = {
		if (robot.location = self) robot.activatenpc;
		if (lemur.isintree) lemur.activatenpc;
		pass enterRoom;
	}
	leaveRoom(actor) = {
		if (robot.location = self) robot.deactivatenpc;
		if (lemur.isintree) lemur.deactivatenpc;
		pass leaveRoom;
	}
;

banana_woods: woods
	location = bananaplace
;

cave: insideroom, darkroom
	sdesc = "Cave"
	ldesc = {
		"This small cave doesn't look like it would be part
		of a larger complex, but in the east corner you do see ";
		if (cheezdoor_1.isopen)
			"a small corridor leading past the open cheez door.  ";
		else
			"a closed door.  ";
		"The cave exit lies to the south.  ";
	}
	walldesc = "The limestone rock walls are wet and slimy."
	ceilingdesc = "The limestone ceiling is wet and slimy.  As you look
			up, a drop of moisture oozes off and hits you on 
			the forehead.  Ugh."
	east = cheezdoor_1
	south = clearing
;

cheezroom: darkroom, insideroom
	sdesc = "Cheez Room"
	ldesc = "It's unclear what civilization in the history of Unnkulia went
		through the trouble of hollowing out this small extension
		to the cave, and why they then decided to lock it up.  There really
		isn't anything to see here, but then, there are probably stranger
		things than this oddity of a vacuum elsewhere in your new world.
		The only way out is back west into the main chamber."
	walldesc = "This room was probably once used as a treasure house for
		vast quantities of cheez, as you can guess from the telltale
		smears on the walls, but now nothing is left of its former glory."
	west = cheezdoor_2
;

class cheezdoor: lockableDoorway, ourfooditem, ourdoorway
	sdesc = "cheez door"
	ldesc = { "The cheez door is green and pungent, and the smell reminds you fondly
		of the cheez cellar you and your brother played in as children.
		You can just make out some small chew marks on the bottom of
		the door- looks like some rodent has been nibbling on the cheez
		door.  "; pass ldesc; }
	noun = 'door'
	adjective = 'cheez' 'cheese' 'pungent' 'green' 'smelly'
	mykey = cheez_kee


	doEat(actor) = {
		"Yuck.  The cheez door doesn't taste very good.  In fact, you're
		starting to wonder why you ate a door that sat next to a glowing
		green rock for several hundred years.  You stop eating the rancid
		door.";
	
		notify(Me, &hurt1, 2);
		notify(Me, &hurt2, 4);
		notify(Me, &dieNow, 6);
	}
;

cheezdoor_1: cheezdoor
	otherside = cheezdoor_2
	doordest = cheezroom
	location = cave
;

cheezdoor_2: cheezdoor
	otherside = cheezdoor_1
	doordest = cave
	location = cheezroom
;

inst_entrance: outsideroom
	sdesc = "Institute Entrance"
	ldesc = "You are standing before the grand entrance to the Acme
		Institute for the <<instname()>> Sciences.  To the north is the
		campus courtyard, surrounded by great stone buildings.
		To your west is what appears to be a garden.  The
		overwhelming splendor of the institute makes you loath to return
		south towards the bus station."
	south = path_intersection
	north = south_courtyard
	west = garden_entrance
	east = { "There's construction going on\; a new biology building or some such.  
		At any rate, your path is blocked.";
		return(nil); }
;

instbuildings: ourdecoration
	sdesc = "buildings"
	adesc = "buildings"
	ldesc = "The stone buildings are splendid and imposing,
		 beautifully laid out around a grassy courtyard.  
		To someone from Western Unnkulia, this might well
		seem like Paradise."
	noun = 'building' 'courtyard'
	plural = 'buildings'
	adjective = 'stone' 'great'
	location = inst_entrance
;

instgarden: ourdecoration
	sdesc = "garden"
	ldesc = "All you can make out from here are some tall hedges."
	noun = 'garden' 'hedges'
	location = inst_entrance
;

south_courtyard: outsideroom
	sdesc = "South Courtyard"
	ldesc = "The south courtyard of the Acme Institute is a pleasant, grassy
		area surrounded by a tall stone building in the west and another
		structure further to the east, and
		criss-crossed by well-worn paths.  A large statue towers over
		the grass in one corner of the yard.
		To the north is the remainder of the courtyard, and the institute
		entrance lies to the south."
	west = deans_office
	east = wind_tunnel_path
	north = north_courtyard
	south = inst_entrance
	in = deans_office
;

south_grass: ourdecoration
	sdesc = "grass"
	ldesc = "The lush Kentucky bluegrass blanketing the courtyard
		must require a legion of groundskeepers to maintain,
		although here and there tufts of fescue rear their ugly stalks."
	noun = 'grass' 'fescue' 'bluegrass'
	location = south_courtyard
;
		
deanbuilding: ourdecoration
	sdesc = "building"
	ldesc = "The tall stone building is swathed in the finest Italian marble,
		a bizarre apparition in an era of budget cuts.  It has a
		peculiarly administrative look to it."
	noun = 'building'
	adjective = 'stone' 'tall'
	location = south_courtyard
;

structure: ourdecoration
	sdesc = "structure"
	ldesc = "It's hard to see the structure to the east from here, but it
		doesn't look particularly impressive."
	noun = 'structure'
	location = south_courtyard
;

statue: ourdecoration
	sdesc = "statue"
	ldesc = "The statue seems to be a likeness of the great benefactor of the institute,
		Fibonacci.  A gold plaque in Fibonacci's honor is at the base of
		the statue."
	location = south_courtyard
	noun = 'statue'
	adjective = 'fibonacci' 'fibonaccis' 'fibonacci\'s' 'large'
;

plaque: behindHider, ourdecoration, readable
	sdesc = "gold plaque"
	ldesc = "The gold plaque describes the generosity of Fibonacci in
		paying for the institute's new mathematics department and
		garden, and discusses his famous sequence 0, 1, 1, 2, 3, 5...  
		There seems to be some room behind the plaque."
	location = south_courtyard
	noun = 'plaque'
	adjective = 'gold' 'fibonacci'
;

kitchen: insideroom
	sdesc = "Kitchen"
	ldesc = "The Cheez Boar Inn, sure to its name, contains a large
		cheez cabinet along one wall.  An aerodynamic toaster sits
		on the cabinet.  An enormous black stove in the far corner
		is surely the source of the tempting 
		treats that have lured generations of students away from 
		the Acme Institute's dining halls.  Pots, pans, and all
		the cooking supplies a chef might desire have been carefully arranged
		around the stove like offerings around an altar.
		The door back to the bar is to the north.  "
	walldesc = "The walls here gleam with the grease spatterings of
		many years of deep-frying chicken wings and french fries.  "
	ceilingdesc = "The ceiling is dark with soot.  "

	north = tavern
;

stove: ourdecoration
	sdesc = "stove"
	ldesc = "The gigantic black cast-iron stove looks like it might have
		been fashioned by Hephaestus himself, so ancient and wondrous it is.
		This monster surely was installed long before the Acme Company was even
		a twinkling in its founder's eye.  Usually Janey, the cook,
		is to be found tending to the stove, but today must be her day off.  "
	noun = 'stove'
	adjective = 'black'
	location = kitchen

	verDoTake(actor) = { "Surely you jest.  You might find it easier to
			raise the Titanic than to take this stove.  "; }

	verDoTurnon(actor) = { "The stove stands before you, black and inscrutable.
				Your feeble attempts to bring to life its roaring flames
				have no effect.  ";}
	verDoLight(actor) = self.verDoTurnon(actor)
	verDoTurnoff(actor) = { "The stove is already off.  "; }
;

kitchen_stuff: ourdecoration
	sdesc = "kitchen supplies"
	ldesc = "The huge stainless steel pots and pans, utensils, spices, and 
		other kitchen supplies have been lovingly arranged around 
		the stove by Janey, the cook.  "
	noun = 'pots' 'pans' 'pot' 'pan' 'supplies' 'spices' 'utensils'
	adjective = 'kitchen'
	location = kitchen

	verDoTake(actor) = { "The thought of Janey suddenly returning
			and finding you messing with the tools of her trade is more 
			than enough to deter you from desecrating her altar.  "; }
;

diningroom: insideroom
	sdesc = "Cheez Boar Dining Room"
	ldesc = { "The Cheez Boar didn't skimp on their dining room.  The walls
		are red cedar, the floor a heavy oak.  High up in the rafters are
		oil lanterns- their glow adding to the rustic, fecund atmosphere.
		The doorway leading east to the bar is exquisitely carved.
		But these details come to you only on a second glance, as your
		senses are overwhelmed by the food and sound emanating from the
		refectory table in the center of the room.\b
		Around the table are 12 philosophers, engaged in what could be
		called an extremely heated debate.  In their center is an untouched
		feast.\b";

		if (philosophers.aredeadlocked)
			"The philosophers are ignoring their food for the moment,
			deadlocked over the Cheez Boar's limited collection of knives
			and forks.  It seems that when their food was brought in,
			some of these great thinkers decided to pick their
			fork up first, and others their knife, and the shortage
			of both has resulted in chaos.  None can eat until they
			get both utensils, but since each has only one implement and can't
			convince another colleague to give up theirs, all are starving.
			The only reason an all-out brawl hasn't broken out is that each
			is too busy shielding their own implement to budge an inch.";
		else
			"The philosophers seem to be short of utensils, and are
			taking turns releasing and acquiring knives and forks as
			they eat.  The general atmosphere seems to be one of guarded,
			grudging cooperation.";
	}
	walldesc = "The walls are made of the finest red cedar boards.  "
	ceilingdesc = "The ceiling rafters soar high above your head.  "
	east = tavern
;

rafters: ourdecoration
	sdesc = "rafters"
	ldesc = "The heavy wooden rafters soar far above your head.  "
	noun = 'rafter' 'rafters'
	location = diningroom
;

dining_doorway: ourdecoration
	sdesc = "doorway"
	ldesc = "The doorway is carved with a scene of
		people sitting around a lavishly spread feast table.  "
	noun = 'doorway' 'door'
	location = diningroom
;

lanterns: ourdecoration
	sdesc = "oil lanterns"
	ldesc = "The oil lanterns add a romantic air to the dining room.  They
		are hung from the rafters and remain enticingly out of reach."
	noun = 'lantern' 'lanterns' 'lamp' 'lamps'
	adjective = 'oil'
	location = diningroom
	verDoTake(actor) = "The oil lanterns are too far above your head
				for you to reach.  "
;

wind_tunnel_path:outsideroom, buriedHider
	sdesc = "Path"
	ldesc = "You're on a dirt path that leads from the courtyard
		on the west to the large toroidal building with its
		entrance in the east."
	west = south_courtyard
	east = wind_tunnel
	south = { "Wander off the path to your almost certain death?  I don't think so."; 
		return(nil); }
	north = { "Wander off the path to your almost certain death?  I don't think so."; 
		return(nil); }
	in = south_courtyard

	serialSearch = true
;

wind_path: ourdecoration
	sdesc = "path"
	ldesc = "The dirt of the path is loose and friable."
	location = wind_tunnel_path
	noun = 'path'
	adjective = 'dirt'
;

windbuilding: ourdecoration
	sdesc = "building"
	ldesc = "The toroidal building looks like something Dunkin' Donuts might
		serve if it catered to a giant metal-eating alien clientele."
	noun = 'building'
	adjective = 'toroidal'
	location = wind_tunnel_path
;

wind_tunnel: insideroom
	sdesc = "Wind Tunnel Building"
	ldesc = "The Acme VeryKool Wind Tunnel is the pride of the institute's
		Engineering department.  The doorway into the main tunnel
		chamber is on the south side of the room, while the exit to the
		outside world is on the west.  The east wall contains
		a small cylindrical depression, a tube about a foot long extending
		horizontally into the wall."
	walldesc = "The metal walls are shiny and polished, unblemished save for
		the depression in the east wall."

	west = wind_tunnel_path
	out = wind_tunnel_path
	in = chamberdoorout
	south = chamberdoorout
;

ridges: ourdecoration
	sdesc = "wire ridges"
	adesc = "ridges"
	ldesc = "The wire ridges run the length of the cylinder, and have no obvious
		purpose."
	location = wind_tunnel
	noun = 'ridges'
	adjective = 'wire'
;

chamber: insideroom
	sdesc = "Tunnel Chamber"
	ldesc = "The cylindrical metal chamber has a platform rising from the
		middle of the floor to the center of the chamber.  Either end of
		the chamber is covered with an impenetrable mesh, and the only
		way out is back through the door to the north."
	walldesc = "The metal walls curve smoothly around you."
	out = chamberdoorin
	north = chamberdoorin

	spinPropeller(foodenergy) = {
		/* If you're inside the cylinder, you should feel wind if the hamster
		* is unenergetic.  If his energy is > 7 (which only the carrot can
		* make him) any person in the cylinder will die, and anything else
		* will be blown through the mesh and destroyed. [ Of course, the
		* unaspirated "P" is an exception ].  
		*/
		local i, list, tot, cur, ripped;

		if (Me.location = wind_tunnel) {
			if (foodenergy > 7)
				"\bThe entire wind tunnel is shaking wildly under Corduroy's
				tremendous exertions.";
			else if (foodenergy > 4)
				"\bThe wind tunnel is vibrating significantly.";
			else if (foodenergy > 0) {
				"\bA humming noise comes from the tunnel.";
			}
		}

		if (Me.location = chamber) {
			if (foodenergy > 7) {
				"The tremendous velocity of the wind inside the
				chamber blows you violently against the mesh
				on one side of the tunnel chamber, smooshing small
				parts of your body through the wires and killing
				you not quite instantly enough to be painless.";
				die();
			}
			else if (foodenergy > 4)
				"\bThe tunnel wind is almost too strong for you to stand in.";
			else if (foodenergy > 0)
				"\bThere is a mild breeze in the tunnel.";
		}

		list := chamber.contents + chamber_platform.contents;
 		tot := length( list );
		ripped := nil;
 		i := 1;
		while ( i <= tot ) {
			cur := list[i];
			if (not cur.isfixed) {
				if (cur = thep) {
					if (thep.location = chamber_platform and
						foodenergy > 7)
						thep.aspirate;
				}
				else if (foodenergy > 4) {
					if (Me.location = chamber) {
						caps();
						"<<cur.thedesc>> goes flying through
						the mesh, ripped to pieces.";
					}
					cur.moveInto(nil);
					ripped := true;
				}
			}
		i := i + 1;
		}
		if (ripped and Me.location = wind_tunnel)
			"\bYou hear a crinkling and crashing sound from within the chamber.";
	}
;

class chamberdoor: ourdoorway
	sdesc = "chamber doorway"
	ldesc = { "It is a diminutive metal doorway.  "; pass ldesc; }
	noun = 'door' 'doorway'
	adjective = 'chamber' 'metal'
;

chamberdoorin: chamberdoor
	otherside = chamberdoorout
	doordest = wind_tunnel
	location = chamber
;

chamberdoorout: chamberdoor
	otherside = chamberdoorin
	doordest = chamber
	location = wind_tunnel
;

chamber_mesh: ourdecoration
	sdesc = "mesh"
	ldesc = "The impenetrable mesh runs from floor to ceiling to prevent
		access to the deadly tunnel propeller."
	location = chamber
	noun = 'mesh'
	adjective = 'impenetrable'
;

chamber_platform: ourdecoration, surface
	sdesc = "platform"
	ldesc = "The platform rises from the floor to about shoulder level,
		and is about a square foot at the top."
	location = chamber
	noun = 'platform' 'pedestal'
	adjective = 'chamber'
;

chamber_propeller: ourdecoration
	sdesc = "propeller"
	ldesc = "The propeller is out of sight around a corner of the tunnel."
	location = chamber
	noun = 'prop' 'propeller'
;

deans_office: insideroom
	sdesc = "Dean Chiquita's Office"
	ldesc = "The dean's office has a large picture window in the west providing
		a pretty but not particularly clear view of the verdant garden outside.
		The Acme Insitute's administrators must have singularly dull imaginations,
		as there is no whiteboard here. On the other hand, the plush office
		chair may be an indication that overhead considerations do not
		affect certain parts of the institute's budget.  In front of you
		is the dean's
		impressive desk, and placed against one wall of the office is a
		filing cabinet.  The only exit is out to the courtyard in the east."
	out = south_courtyard
	east = south_courtyard

	enterRoom(actor) = {
		dean.activatenpc;
		pass enterRoom;
	}
	leaveRoom(actor) = {
		dean.deactivatenpc;
		pass leaveRoom;
	}
;

deans_window: shutwindow
	location = deans_office
	doLookthru(actor) = {
		"Outside the dean's office you see the sprawling garden
		path maze the 'tute's so proud of.  On this side of the maze
		is a large red barn, presumably the insitute's stable, and
		between the barn and the window seems to be a small path.";
	}
	doordest = horsefall // Not really.
	adjective = 'west' 'large' 'picture'
;

deans_desk: desk
	sdesc = "dean's desk"
	adesc = { self.sdesc; }
	ldesc = "The large cherry desk reminds you of the one you once saw
		in a famous cryptographer's office, and seems a bit excessive
		in an era of reduced Unnkulian expectations."
	adjective = 'large' 'impressive' 'dean' 'dean\'s' 'deans' 'cherry'
	location = deans_office
;

north_courtyard:outsideroom
	sdesc = "North Courtyard"
	ldesc = "The large, grassy commons area of the courtyard continues to
		the south, but despite its large size the surrounding buildings cast
		shadows over the area that only several oak trees can clear.
		The Acme Institute's mathematics and artificial
		intelligence departments are housed in a large structure to the east
		that continues north.  The famed Acme linguistics department
		commands the more decrepit building to the immediate north,
		and the school's physics department (reknown for their innovative
		melding of philosophy and quantum mechanics) can be reached by
		following a short path to the northwest."
	nw = physics
	north = linguistics
	ne = mathematics
	east = ai
	south = south_courtyard
;

north_grass: ourdecoration
	sdesc = "grass"
	ldesc = "The lush Kentucky bluegrass blanketing the courtyard
		must require a legion of groundskeepers to maintain,
		although here and there tufts of fescue rear their ugly stalks."
	noun = 'grass' 'fescue' 'bluegrass'
	location = north_courtyard
;

physics_building: ourdecoration
	sdesc = "physics building"
	ldesc = "The physics department's massive red sandstone building gives little
		clue as to what discoveries about the fundamental building
		blocks of the universe might be making history inside."
	noun = 'building' 'department' 'structure'
	plural = 'buildings'
	adjective = 'physics'
	location = north_courtyard
;

math_building: ourdecoration
	sdesc = "math building"
	ldesc = "The mathematics and artificial intelligence departments' building
		is magnificent and new, as befits their status at the Acme Institute.
		The structure is a masterpiece of modern art, but to your untrained
		eye looks vaguely like the interior of a department store bathroom
		you once visited."
	noun = 'building' 'department' 'structure'
	plural = 'buildings'
	adjective = 'math' 'mathematics' 'artificial' 'intelligence' 'ai'
	location = north_courtyard
;

ling_building: ourdecoration
	sdesc = "linguistics building"
	ldesc = "Despite the excellence of the linguistics faculty at the Acme
		Institute, they have been relegated to a building that looks
		depressingly like an old army barracks."
	noun = 'building' 'department' 'structure'
	plural = 'buildings'
	adjective = 'linguistics'
	location = north_courtyard
;

physics: insideroom
	sdesc = "Physics Building"
	ldesc = "This is the lobby of the physics building.  Inlaid in the plancks
		on the floor is a giant letter h with a bar through the vertical stroke.  The
		most remarkable item in the room is a large funnel mounted on a
		stand in the middle of the floor. A room lies
		to the west, and the campus courtyard is to the southeast."
	west = physics_office
	se = north_courtyard
;

h: ourdecoration
	sdesc = "letter h"
	ldesc = "The inlaid letter h has a bar through the vertical stroke."
	noun = 'h' 'plancks' 'planks'
	adjective = 'letter' 'giant'
	location = physics
;

physics_office: insideroom
	sdesc = "Physicist's Office"
	ldesc = "This unkempt physics office shows signs of wear.  The curtains around
		the north window have been shredded, and the office's carpet looks
		well worn.  Even the chair and desk under the whiteboard 
		have been carved up.
		The only door lies in the east,	back to the main part of the physics building."
	east = physics
	out = window1in
	north = window1in
;

physics_chair: ourchair
	ldesc = "The wooden chair has been heavily gouged and scratched."
	location = physics_office
;

physics_desk: desk
	sdesc = "desk"
	ldesc = "The desk has had several destructive operations performed on it,
		including the carving of \"set!\"\ and \"CDF\" into its otherwise
		unnoteworthy surface."
	adjective = 'carved'
	location = physics_office
;

curtains: ourdecoration /* For now */
	sdesc = "curtains"
	ldesc = "The crimson curtains have obviously been subjected to significant
		abuse.  It looks like a cat has been clawing at them."
	location = physics_office
	noun = 'curtains' 'curtain'
	adjective = 'clawed' 'abused' 'shredded' 'crimson'
;

carpet: ourdecoration
	sdesc = "carpet"
	ldesc = {
		"The carpet is quite worn, and scratched up too. ";
		if (self.moved) "It has been moved to one side of the room.";
	}
	location = physics_office
	noun = 'carpet'
	adjective = 'worn' 'scratched'

	moved = nil
	verDoMove(actor) = {}
	doMove(actor) = {
		if (self.moved) {
			"You carefully spread the carpet back into a neat position
			on the floor.";
			self.moved := nil;
		}
		else {
			"Moving the carpet reveals no trapdoor. <<note(self)>>";
			self.moved := true;
		}
	}
	footnote = {
		"There was to be a trapdoor, with a wonderful physics laboratory
		under it, but there was no time left to build the trapdoor.  The same
		could be said of the game's plot.";
	}
	verDoPush(actor) = {}
	doPush(actor) = { self.doMove(actor); }
;

window1in: window
	otherside = window1out
	doordest = lumenberrypatch
	location = physics_office
	adjective = 'north'
;

window1out: window
	otherside = window1in
	doordest = physics_office
	location = lumenberrypatch
	adjective = 'south'
;

lumenberrypatch: outsideroom
	sdesc = "Berry Patch"
	ldesc = {
		"Apparently the physicists are fond of lumenberries, because they've
		planted a nice patch here. ";
		if (berries.ispicked)
			"It looks like all of the berries have been picked, though. ";
		"The physics building lies to
		your south, with a window overlooking the patch.  Other directions
		are blocked by large hedges.";
	}
	in = window1out
	south = window1out
;

lumen_building: ourdecoration
	sdesc = "building"
	ldesc = "The physics building from this vantage point is an imposing
		wall of red sandstone, featureless except for the window you just
		climbed out of."
	adjective = 'physics'
	location = lumenberrypatch
;

lumen_hedges: ourdecoration
	sdesc = "hedges"
	ldesc = "The hedges are gnarled and impenetrable."
	noun = 'hedges' 'hedge'
	adjective = 'gnarled' 'impenetrable' 'large'
	location = lumenberrypatch
;

linguistics: insideroom
	sdesc = "Building 20"
	ldesc = { "You are in Building 20, the home of the infamous Acme Linguistics
		Consortium.  Posters and a picture adorn the walls, and the view over
		the courtyard
		to the south reminds you of a book you read recently.  In the northwest
		corner of the building is the office of Noam Chomsky, the noted rationalist,
		and in the northeast, the office of Morris Halle, the noted phonologist.  ";
		if (not halle_office_door_1.isopen)
			"Halle's door is closed.";
	}
	walldesc = "The walls here are a lovely shade of institutional off-white,
		and have clearly seen many coats of paint.  They could use a 
		touchup, though, as the surface is beginning to fade and peel in
		places.  The walls are gaily decorated with posters and a picture."

	nw = chomskys_office
	ne = halle_office_door_1
	south = north_courtyard
	out = north_courtyard
;

linguistics_posters: ourdecoration, behindHider
	sdesc = "poster"
	ldesc = "One poster in particular catches your eye- it is of a returned letter,
		labeled by the Unnkulian Postal Service: \"Palestine: address
		does not exist.\""
	location = linguistics
	noun = 'poster' 'posters'
	adjective = 'linguistic' 'linguistics'
;

linguistics_picture: ourdecoration
	sdesc = "picture"
	ldesc = "The picture shows Morris and Noam on a recent hunting trip, standing
		over several dead empiricists and proudly displaying a Skinner box they
		trashed."
	location = linguistics
	noun = 'picture'
;

chomskys_office: insideroom
	sdesc = "Noam Chomsky's Office"
	ldesc = "Chomsky's office is cluttered with innateness and his whiteboard
		dominates the small, windowless room, the only exit from which lies
		to the southeast.  His chair and desk stand in a corner.  
		The professor does not seem to be in today."
	south = linguistics
	se = linguistics
;

chomskys_chair: ourchair
	ldesc = "The chair of the great linguist is a 1960s vintage vinyl-and-metal
		swiveling model."
	location = chomskys_office
	adjective = 'chomsky' 'chomskys' 'chomsky\'s'
;

chomskys_desk: desk, named
	sdesc = "Chomsky's desk"
	ldesc = "The desk of the great linguist Noam Chomsky is unremarkable,
		with the exception of scrawls about Unnkulian political involvement
		in central Bogosity, and a few incomprehensible parasitic sentences about
		John and Mary, and some raves about the wondrous new TMRC
		Garden Path Sequencing unit."
	location = chomskys_office
	adjective = 'chomsky' 'chomskys' 'chomsky\'s'
;

halles_office: insideroom
	sdesc = "Morris Halle's Office"
	ldesc = "Halle's office is built in the traditional Building 20 architectural
		style: ugly and unfunctional.  Its only furnishings are a chair and
		a desk, and its only exit is southwest."
	south = halle_office_door_2
	sw = halle_office_door_2
;

halles_chair: ourchair
	ldesc = "Halle's chair looks ugly and uncomfortable, and the vinyl
		seat is cracked."
	location = halles_office
	verDoSiton(actor) = "Halle's chair is so uncomfortable, with the cracked
		vinyl digging cruelly into your tender flesh, that you
		immediately stand up again."
;

halles_desk: desk, named
	sdesc = "Halle's desk"
	ldesc = "Halle's desk is unremarkable."
	location = halles_office
	adjective = 'halle' 'halles' 'halle\'s'
;

class halledoor: lockableDoorway, ourdoorway
	sdesc = "office door"
	mykey = glottal_kee
	noun = 'door'
	adjective = 'office' 'halle' 'halles' 'halle\'s'
;

halle_office_door_1: halledoor
	otherside = halle_office_door_2
	doordest = halles_office
	location = linguistics
;

halle_office_door_2: halledoor
	otherside = halle_office_door_1
	doordest = linguistics
	location = halles_office
;

mathematics: insideroom
	sdesc = "Mathematics Department"
	ldesc = "The Acme Mathematics Department, known for its fundamental research
		in graph coloring, likes to think of itself as the only math department
		in the world that is almost totally corrupt.  In this, the departmental
		headquarters, several postings line the walls.  The main departmental
		lecture hall is to the east, an exit to the courtyard is to the southwest,
		a hallway goes south, and a curving staircase leads up to the north."

	walldesc = "The walls are beautifully tiled with figures of strange beasts
		 that march around and dissolve into one another.  
		 Several postings taped to the walls mar the beauty of
		 their intricate dance."

	east = lecturehall
	out = north_courtyard
	south = ai
	sw = north_courtyard
	north = westhall
	up = westhall
;

staircaseup: ourdecoration
	sdesc = "curving staircase"
	ldesc = "The curving staircase leads up."
	noun = 'staircase'
	adjective = 'curving'
	location = mathematics
;

westhall: insideroom
	sdesc = "West Hallway"
	ldesc = "The hallway is unadorned, save for the pedestal leaning against the north wall.
		There is an office entrance opposite it, and the hallway continues east.
		A curving staircase leads down to the north."
	south = alyssaoffice
	in = alyssaoffice
	east = easthall
	north = mathematics
	down = mathematics
;

staircasedown: ourdecoration
	sdesc = "curving staircase"
	ldesc = "The curving staircase leads down."
	noun = 'staircase'
	adjective = 'curving'
	location = westhall
;

easthall: insideroom
	sdesc = "East Hallway"
	ldesc = "The hallway is unadorned, save for the pedestal standing against the east wall.
		There is an office entrance to the south, and the hallway continues west."
	south = louisdoor_1
	in = louisdoor_1
	west = westhall
;

alyssaoffice: insideroom
	sdesc = "Alyssa P.\ Hacker's Office"
	ldesc = "The window in the west wall of Alyssa's corner office looks
		over the courtyard, and its not hard to see why she, the department
		chair, chose this location; the airy, clean room is bright and
		pleasant. Her desk and chair are in a corner, 
		and the exit is to the north."
	out = westhall
	north = westhall
;

alyssa_trees: ourdecoration
	sdesc = "trees"
	ldesc = "The huge oak trees are green and leafy, blocking most of
		the view of the courtyard from Alyssa's window."
	location = alyssaoffice
	noun = 'tree' 'trees' 'leaves'
	adjective = 'oak'
;

alyssa_chair: ourchair
	ldesc = "Alyssa's chair is stylishly modern, one of those newfangled
		plastic-and-fabric concoctions that adjusts to the user's body
		in every conceivable way."
	location = alyssaoffice
;

alyssa_window: window
	location = alyssaoffice
	adjective = 'west'
	doLookthru(actor) = {
		"Alyssa's window overlooks the entire courtyard, though much
		of the view is hidden by the leaves of the oak trees that
		stand below.";
	}
	doordest = north_courtyard
	checktravel(actor) = {
		"What?  And risk defenestration?  Surely you jest.\n";
		return nil;
	}
	ioThrowThrough(actor, dobj) = {
		if (dobj <> paperplane) {
			"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch it fly
			 away from you.";
			dobj.moveInto(self.doordest);
		}
		else {
			"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch
			it fly.  The plane darts to and fro in the strange courtyard winds";
			if (raven.location = north_courtyard) {
				", catching a courtyard raven's eye and startling the
				raven enough to make it drop something and fly away.
				The plane makes	a final loop";
				raven.startle;
			}
			" before settling in the yard. ";
			dobj.moveInto(self.doordest);
		}
	}
;

louisoffice: insideroom
	sdesc = "Louis Reasoner's Office"
	ldesc = "Louis' untidy desk dominates the center of the room.  
		A pile of F's is precariously perched atop the reams of 
		scribbled notes and clutter on his desk.
		His chair is nearly invisible among the junk and 
		broken machinery which lie scattered about everywhere. 
		In the east wall is a window, and the doorway through which
		you entered is to the north.
		The one device that actually appears to be working is a big
		old grandfather clock (heavily remodeled) near the door."
	north = louisdoor_2
	out = louisdoor_2
	trapped = nil

	enterRoom(actor) = {
		if (actor = Me) {
			notify(louisclock, &checkClock, 0); 
			louisdoor_2.isopen := nil;
			louisdoor_2.islocked := true;
			louisclock.counter := 0;
			"The door swings shut behind you.\b";
			pass enterRoom;
		}
	}
;

louis_notes: ourdecoration, underHider, readable
	sdesc = "notes"
	ldesc = "The notes and other clutter on Louis' desk are piled up
		so high that you can barely see the desk at all.
		Who knows what might be under that mess.  "
	readdesc = "Louis' handwriting is practically illegible,
		but his feverish scribbles are obviously describing
		some new invention. "
	noun = 'notes' 'clutter' 'mess'
	adjective = 'scribbled'
	location = louisoffice
;

louischair: ourchair
	location = louisoffice
	ldesc = "Louis' chair is old and battered, perhaps a reflection of
		his inability to find research funding after his long
		string of failed inventions."
	adjective = 'louis' 'louis\''
	verDoSiton(actor) = "Louis' chair is old and creaky and doesn't look
		like it would hold your weight, let alone his."
;	


brownie: ourfooditem, hiddenItem
	sdesc = "stale brownie"
	ldesc = "The muddy-colored square is vaguely recognizable as a brownie,
		but it's unclear what century it was first baked in."
	underLoc = louis_notes
	noun = 'brownie'
	adjective = 'stale'
	doEat(actor) = { "Only the high sugar content of this rocklike and 
		incredibly stale brownie must have preserved it through the ages.
		You choke it down, but with great difficulty.";
		changescore(-3);
		brownie.moveInto(nil);
	}
	newenergy = 2
;

louis_desk: desk, named, searchHider
	location = louisoffice
	sdesc = "Louis' desk"
	ldesc = "The desk is amazingly untidy.  Anything could be buried
		under the clutter and you'd never know."
	adjective = 'louis' 'louis\'' 'louis\'s'
;

louisjunk: ourdecoration
	location = louisoffice
	sdesc = "junk"
	ldesc = "It's impossible to tell where one broken-down machine
		ends and the next starts.  A veritable sea of cogs, gears,
		metal parts, plastic, wire, and other industrial detritus
		fills Louis' office."
	noun = 'junk' 'machinery' 'wire' 'plastic' 'cogs' 'gears' 'parts' 'detritus' 'metal'
	
	adjective = 'broken'
	verDoTake(actor) = "The junk really is just junk, and completely
			worthless to boot."
;

f_pile: ourdecoration
	location = louisoffice
	sdesc = "pile of F's"
	ldesc = "The pile of F's is appallingly large and jumbled;
		Palatino, Times Roman, AvantGarde Demi-Bold, New York... 
		all mixed in together with no regard for style.
		You shudder at the thought of the gigantic quantities of
		failed effort that it represents."
	noun = 'pile' 'f' 'f\'s'
	verDoTake(actor) = { "You reach out towards the pile of F's, but then 
			reconsider.  Do you really want to be associated with 
			this magnitude of failure?"; }
;

louisclock: ourdecoration
	location = louisoffice
	sdesc = "clock"
	ldesc = {
		"The Talking Time C-lock has been lovingly re-engineered by
		a UROP Louis tricked into working for him.  Once upon a
		time it was probably
		a beautiful antique oak grandfather clock, but now it is
		a mere shadow of its former self.  ";
		if (self.speedup = true)
			"The hands are racing around at a dizzying rate. ";
		else
			"Its hands are moving painfully slowly.";
	}
	noun = 'clock'
	adjective = 'grandfather' 'big' 'old'

	speedup = nil
	counter = 0

	checkClock = {
		counter++;
      		if (counter = 1)
			"\bThe clock chirrups brightly at you, \"Welcome to Professor 
			Reasoner's office!  Louis is out right now, but he'll be back 
			in a few minutes, and he'd love to see you.  Feel free to twiddle
			your thumbs to pass the time while you wait.\"\b";
		else if (modulo(counter,5) = 0)
			"\n\"Just a few more minutes!\"\ chirps the clock.\n";
		if (timeflies.location = louisoffice and counter = 4) {
			speedup := true;
			"\bThe time flies flutter into the grandfather clock.
			You can see its hands turning visibly faster now.";
			timeflies.deactivatenpc;
			timeflies.moveInto(nil);
			changescore(3);
		}
		if ((speedup = true and counter > 6) or counter > 20) {
			"\nAfter a while, the clock says in a puzzled voice, 
			\"Hmm.  Professor Reasoner ought to have been back by now.
			Perhaps he's gone out for coffee.  I guess I shouldn't
			keep you waiting any longer.\"\b
			The door swings open.\n";
			louisdoor_2.islocked := nil;
			louisdoor_2.isopen := true;
			unnotify(self, &checkClock);
		}
	}
;


class louisdoor: lockableDoorway, ourdoorway
	sdesc = "office door"
	noun = 'door'
	isopen = true
	islocked = nil
	
	doUnlock(actor) = "Louis, ever the aspiring inventor, has so tampered
			with the locking mechanism of his office door that 
			it's impossible to figure out how to unlock it."
	
	doLock(actor) = "Louis, ever the aspiring inventor, has so tampered
			with the locking mechanism of his office door that 
			it's impossible to figure out how to lock it."
	
;

louisdoor_1: louisdoor
	otherside = louisdoor_2
	doordest = louisoffice
	location = easthall
;

louisdoor_2: louisdoor
	otherside = louisdoor_1
	doordest = easthall
	location = louisoffice
;

louis_window: window
	location = louisoffice
	adjective = 'east'
	doLookthru(actor) =
		"Louis's second story window overlooks a small pond to the east
		of the mathematics and artificial intelligence building.  The
		reflecting sun on the water prevents a good look, but you think
		you see the flashing scales of some red fish in the water."
	doordest = nil
	checktravel(actor) = {
		"What?  And risk defenestration?  Surely you jest.\n";
		return nil;
	}
	ioThrowThrough(actor, dobj) = {
		if (dobj <> paperplane) {
			"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch it fly
			 away from you.";
			dobj.moveInto(self.doordest);
		}
		else {
			"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch
			it fly.  <<dobj.thedesc>> circles gently down until it comes to rest
			at surface of the pond, at which point a red fish lunges
			towards it, takes one giant gulp, and swallows it whole before
			submerging. ";
			dobj.moveInto(self.doordest);
		}
	}
;

pond: ourdecoration
	sdesc = "pond"
	ldesc = "You can't see the small pond very well from here."
	noun = 'pond'
	adjective = 'small'
	location = louisoffice
;

fish: ourdecoration
	sdesc = "fish"
	ldesc = "The glistening red fish is submerged beneath the waters of the pond,
		and is very difficult to see. "
	noun = 'fish' 'herring'
	adjective = 'red'
	location = louisoffice
;


lecturehall: insideroom
	sdesc = "Lecture Hall"
	ldesc = "This is the main lecture hall for the mathematics and artificial
		intelligence departments.  A doorway to the west returns you to the department.  
		In the front of the amphitheatre-like
		arrangement of seats is a large whiteboard."
	west = mathematics
;

lecturehall_seats: ourdecoration, underHider
	sdesc = "seats"
	adesc = "seats"
	ldesc = "The seats are regulation Acme: the backs are just hard enough
		to hurt and not quite contoured enough to let students relax and
		sit still.  It's
		no wonder most Institute students spend their time in
		labs doing research.  On the back of one of the seats you find
		the scratched words \"RMS luvs Amanda\"."
	noun = 'seat' 'seats' 'chair' 'chairs'
	location = lecturehall
	adjective = 'acme'
	verDoSiton(actor) =
		"Come, come. Time's a wastin'. You've got to get a degree
		as fast as you can, not sit around waiting for the next
		lecture."
;
	

ai: insideroom
	sdesc = "Artificial Intelligence Laboratory"
	ldesc = "The artificial intelligence laboratory is nearly empty.  The
		book covers you've heard so much about are gone, and an apparent
		paucity of funding has left the publications shelves threadbare.
		No new ideas are anywhere in sight, and most likely the
		brightest upcoming students will be studying elsewhere in the
		institute, philosophy or biology or home economics or some other
		more active field.  To leave artificial intelligence for other
		fields, as so many others have done, you might travel west back
		into the courtyard, or east or north into other portions of the
		building.  There is a warning sign posted over the east exit.
		\n\tSome cockroaches are scurrying about."

	walldesc = "The carpeted orange walls are speckled with mysterious dark brown
		blotches that look suspiciously like bloodstains, perhaps from
		disillusioned graduate students banging their heads into the
		walls one time too many."

	east = computer_room
	out = north_courtyard
	north = mathematics
	west = north_courtyard
	
	enterRoom(actor) = {
		if (actor = Me) gnu.activatenpc;
		pass enterRoom;
	}
	leaveRoom(actor) = {
		if (actor = Me) gnu.deactivatenpc;
		pass leaveRoom;
	}
;

warningsign: ourdecoration, readable
	sdesc = "warning sign"
	ldesc = "The orange sign reads \"Keep out.  Important demo scheduled!\""
	noun = 'sign'
	adjective = 'warning' 'orange'
	location = ai
;

cockroaches: ourdecoration
	sdesc = "cockroaches"
	adesc = "cockroaches"
	ldesc = "Oh, my mistake.  They're not cockroaches, they're mobots."
	noun = 'cockroaches' 'cockroach'
	location = ai
;

shelves: ourdecoration, surface
	sdesc = "shelves"
	adesc = "shelves"
	ldesc = "The once-crowded shelves reflect a distant era, an era of
		Reagonomics and DARPA largesse, of vibrant discussions and
		innovative concepts, of cabbages and kings.  Sadly, no more."
	location = ai
	noun = 'shelf' 'shelves'
	adjective = 'publication' 'publications'
;

class cmdoor: lockableDoorway, ourdoorway
	sdesc = "Contraption Machine sliding panel"
	ldesc = { "The clear plastic Contraption Machine sliding panel is ";
			if (self.isopen) "open."; else "shut.";
		}
	noun = 'panel'
	adjective = 'contraption' 'machine' 'sliding' 'plastic' 'clear'
	isopen = nil
	islocked = nil

	shut = {
		self.isopen := nil;
		if ( self.otherside ) self.otherside.isopen := nil;
	}
;

cmdoor_1: cmdoor
	otherside = cmdoor_2
	doordest = in_computer
	location = computer_room
;

cmdoor_2: cmdoor
	otherside = cmdoor_1
	doordest = computer_room
	location = in_computer
;

compdoor: lockableDoorway, ourdoorway
	sdesc = "grey door"
	ldesc = "The matte grey door is closed and locked."
	mykey = true // Unopenable!
	doordest = nil
	otherside = nil
	noun = 'door'
	adjective = 'east' 'matte' 'gray' 'grey'
	location = computer_room
;

greykee: keyItem, throwable, ouritem, hiddenItem
	sdesc = "matte grey kee"
	ldesc = "The kee is a matte grey."
	location = nil
	underLoc = lecturehall_seats
	noun = 'key' 'kee'
	adjective = 'matte' 'grey' 'gray'
;

computer_room: insideroom
	sdesc = "Contraption Machine Room"
	ldesc = {
		"This "; if (cm8.ishumming) "humming"; else "quiet";
		" room is dominated by a large Acme Contraption Machine (CM-8)
		in the middle of the floor.  An exit to the west leads back to the AI Lab,
		and on the east side of the room is a door, which is closed. ";
	}
	west = ai
	east = compdoor
	in = cmdoor_1


	enterRoom(actor) = {
		if (actor = Me and louis.location = self)
			louis.eject(actor);
		else pass enterRoom;
	}
;

in_computer: insideroom
	sdesc = "Inside Contraption Machine"
	ldesc = {
		"The inside of the Contraption Machine is a tight fit, what with
		all the lights and electronics and switches.  The large sliding panel
		you got in through is now ";
		if (cmdoor_2.isopen) "open."; else "shut. ";
		"  The only way out seems to be through the panel. ";
	}
	out = cmdoor_2

	hummingmessage = {
		/* Don't use ishumming inside machine- the player would hear
		 * the bee explicitly.
		 */
		if (powerswitch.isActive) "\n\tThe CM-8 is humming loudly.\n";
	}
	enterRoom(actor) = {
		notify(self, &hummingmessage, 0);
		pass enterRoom;
	}
	leaveRoom(actor) = {
		unnotify(self, &hummingmessage);
		pass leaveRoom;
	}
;

/* Maze is set up with three complicated sequences- one that moves you to
 * the barn & horse (as per the TMRC GPS unit), another that gets
 * you to the carrot patch (Fibonacci- 0w 1s 1w 2s 3w 5n), and a third
 * that gets you to the special room (can follow the lemur).  Most other
 * moves transport you back to a room one west of the entrance.
 * The GPS unit behaves mostly randomly when not on the special barn &
 * horse garden path.
 *
 * Things dropped in maze move randomly to other places person has
 * visited, after the person leaves the room.
 */

class gardenpart: outsideroom
	sdesc = "Garden Maze"
	ldesc = { self.basicdesc; }
	basicdesc = {
		"You are in the Acme Institute for the <<instname()>> Sciences garden
	maze.  The ";
		say(randomelement(['dense' 'thick'])); " ";
		say(randomelement(['green' 'dark'])); " hedges here are as ";
		say(randomelement(['twisted' 'entangled' 'convoluted']));
		" as they are in the rest of this ";
		say(randomelement(['hellish' 'diabolical' 'devilish']));
		" maze. Garden paths lead off in all the cardinal directions. ";
	}
	south = mazeattractor
	north = mazeattractor
	east = mazeattractor
	west = mazeattractor
	gps_forward = { return(randomelement(['north' 'south' 'east' 'west'])); }
	gps_backward = { return(randomelement(['north' 'south' 'east' 'west'])); }

	isinmaze = true
	movethings = true

	enterRoom( actor ) = {   // sent to room as actor is entering it
	        self.lookAround(( not self.isseen ) or global.verbose );
		gps_unit.provideNotice; 
		if (not self.hasbeenseen) {
		    	self.hasbeenseen := true;
			garden_entrance.visited += self;
		}
		if (horse.location = nil) {
			if (self = gps3) {
				"\bAs you walk you hear the pounding noise grow suddenly
				and have to dive towards one of the hedges to avoid being
				trampled by a horse, which runs by to the north.";
				horse.moveInto(horsefall);
			}
			else if (myrand(3) = 1 or self = gps2)
				"\bYou hear the pounding of a horse's hooves somewhere
				nearby.\n";
		}
	}
	leaveRoom(actor) = {
		/* Move dropped items to random places. */
		local i, n, lst, tmp, vst;
		if (self.movethings = true) {
			lst := self.contents;
			vst := garden_entrance.visited;
			n := length(lst);
			if (length(vst) > 1) vst -= self;
			for (i := 1; i <= n; i++) {
				tmp := lst[i];
				if (not (isclass(tmp, ouractor) or isclass(tmp, littleactor)
						or isclass(tmp, fixeditem)))
					tmp.moveInto(randomelement(vst));
			}
		}
		pass leaveRoom;
	}
	mazehit = { "You crash into the thick hedge of the maze, with nothing but
			some scratches for your reckless efforts.";
			return( nil );
		}
;

garden_entrance: gardenpart
	sdesc = "Garden Entrance"
	ldesc = "This is the entrance to the great garden of the Acme Institute.
		A large wood sign hangs overhead, casting a shadow over the
		stones of the well under it.
		Tall green hedges stretch out in front of you, forming the maze the
		institute's graph-theorists are so fond of discussing.  To your
		east is the institute's entrance, and to the north, south
		and west are other parts of the garden."
	east = inst_entrance
	north = maze1
	south = fib1
	west = mazeattractor
	gps_forward = 'west'
	gps_backward = 'east'

	down = { well.verDoClimb(Me); return(nil); }
	visited = []
;

gardensign: ourdecoration, readable
	location = garden_entrance
	sdesc = "garden sign"
	ldesc = "The wood sign stretching overhead reads \"Welcome to the Acme
		Institute for the <<instname()>> Sciences Garden Path Maze.  If
		you explore this maze, please make a donation at the front office,
		as our benefactor Fibonacci's endowment does not cover garden
		maintenance.\""
	noun = 'sign'
	adjective = 'garden' 'path' 'wood' 'large'
;

mazeattractor: gardenpart
	north = gps1
	gps_forward = 'north'
	gps_backward = 'east'
	west = maze3
	east = garden_entrance
	south = wrongfib1
;

wrongfib1: gardenpart
	west = wrongfib2
;

wrongfib2: gardenpart
	south = wrongfib3
;

wrongfib3: gardenpart
	west = wrongfib4
;

wrongfib4: gardenpart
	north = wrongfib5
;

wrongfib5: gardenpart
;

wrongwaysign: ourdecoration, readable
	sdesc = "wood sign"
	ldesc = "The wood sign has been pounded into the ground, and reads
		\"Oooh.  So you think you're so smart, do you?  You found a
		sign.  Whoop de doop.  Try again, and pay attention to my
		name this time!  What trying times are these, when great minds
		like mine have to coexist with those of fools!\" At
		the bottom of the sign is the scrawled signature of Leonardo Fibonacci."
	location = wrongfib5
	noun = 'sign'
	adjective = 'small' 'wood'
	
	isListed = true
;

maze1: gardenpart
	west = maze2 /* Non Topological */
	south = garden_entrance
	north = maze1 /* Non Topological */
;

maze2: gardenpart
	east = maze1 /* Non Topological */
	south = maze3
	north = maze4
;

maze3: gardenpart
	north = maze2
	south = fib2
;

maze4: gardenpart
	west = specialmaze
	south = maze2
;

gps1: gardenpart
	north = gps2
	west = maze2 /* One way */
	east = maze1 /* One way */
	gps_forward = 'north'
	gps_backward = 'south'
;

gps2: gardenpart
	south = gps1
	north = gps1 /* Non Topological */
	east = gps3
	gps_forward = 'east'
	gps_backward = 'south'
;
	
gps3: gardenpart
	ldesc = {
		basicdesc;
		if (arrow.taken = nil) "\bThere is an arrow here pointing east 
					  towards a great red barn.";
		else "\bTo the east is a great red barn.";
	}
	in = barn
	east = barn
	west = gps2
	north = gps4
	gps_forward = 'north'
	gps_backward = 'west'
	movethings = nil
;

gps4: gardenpart
	north = horsefall
	south = gps3
	gps_forward = 'north'
	gps_backward = 'south'
;

horsefall: outsideroom
	sdesc = "Hedge Opening"
	ldesc = "You have stumbled across a small open area in the convoluted
		garden path maze, surrounded on all sides but the south by the
		rank hedges that form the maze walls."
	south = gps4
	north = gardenpart.mazehit
	east = gardenpart.mazehit
	west = gardenpart.mazehit
	gps_backward = 'south'
;

specialmaze: outsideroom
	sdesc = "Special Lemur Resting Spot"
	ldesc = "You have stumbled across a small open area in the convoluted
		garden path maze, surrounded on all sides but the east by the
		rank hedges that form the maze walls."
	east = maze4
	north = gardenpart.mazehit
	south = gardenpart.mazehit
	west = gardenpart.mazehit
;

theHedges: floatingItem, ourdecoration
    sdesc = "hedges"
    adesc = "the hedges"
    ldesc = { "The ";
		say(randomelement(['dense' 'thick'])); " ";
		say(randomelement(['green' 'dark'])); 
		" bayberry hedges that form the maze are gnarled and impenetrable, 
	        and look like they may well have been growing since the 18th century.\n";
    }

    noun = 'hedges' 'hedge' 'maze'
	adjective = 'bayberry' 'dense' 'thick' 'green' 'dark' 'gnarled' 'impenetrable'

    location = {
	if (isclass(Me.location, gardenpart)) {
		return(Me.location);
	}
	else return(nil); 
    }

    locationOK = true        // suppress warning about location being a method
;



/*
 * The Big Red Barn
 */

barn: insideroom
	sdesc = "Big Red Barn"
	ldesc = {
		"The barn is probably where the institute keeps its horses,
		and undoubtedly serves as a convenient hideaway for romantically
		inclined undergraduates.  A pleasant scent of manure permeates the
		atmosphere, and in one corner of the barn is a small chicken pen.
		A large hay loft provides a second floor over half of the barn.
		The only egress is the large, open doorway you entered through from
		the west.";
		if (ladder.location = self and ladder.israised) {
			"\b\tThere is <<ladder.adesc>> here, raised up against the loft.";
		}
	}
	walldesc = "The walls have been crudely fashioned from roughcut pine planks."
		
	west = gps3
	out = gps3
	up = {
		if (ladder.location=self and ladder.israised) {
			ladder.doClimb(Me);
			return(nil);
		}
		else {
			"You'd need to raise a ladder before you could climb
			up- the loft is well over your head.";
			return(nil);
		}
	}

	laddermessage = "It is raised into position against
				the loft."
	ladderdest = loft
;

manure: ourdecoration
	sdesc = "manure"
	ldesc = "A few small piles of horse manure are scattered about the barn,
		permeating the place with a delightful aroma."
	noun = 'manure'
	location = barn
	
	verDoSmell(actor) = {}
	doSmell(actor) = "Ah, the rich smell of a good fresh pile of horse manure.
			It brings tears to your eyes as you remember your
			misspent youth in Western Unnkulia."
	verDoTake(actor) = "You've moved up in the world now, and shouldn't
			play with your former toys."
;

barn_loft: ourdecoration
	sdesc = "loft"
	ldesc = "It's difficult to see anything of the hayloft except its floor
		from this vantage point.  Perhaps you ought to go up there. "
	location = barn
	noun = 'loft'
	adjective = 'hay'
;

chickenpen: ourdecoration, container
	sdesc = "chicken pen"
	ldesc = "The chicken pen is just a small fenced-in area in one corner
		of the barn."
	location = barn
	noun = 'pen' 'coop'
	adjective = 'chicken'
;

loft: insideroom
	sdesc = "Hay Loft"
	ldesc = {
		if (haystack.location <> self)
			"The hay loft is spacious but bare, with a window at one end of the barn.
			The absence of a suitable path of descent to the barn floor
			below is fairly striking.  On the floor beneath the loft
			is a large pile of hay. ";
		else
			"The hay loft is spacious and full of hay, 
			with a window at one end of the barn.  The absence
			of a suitable path of descent is fairly striking, as is the large
			haystack in the middle of the loft's floor.";
	}
	down = {
		if (addbulk(Me.contents)>4) {
			"You could probably climb down, but not while carrying so much.\n";
			return(nil);
		}
		else {
			if (arrow.location = Me) {
				"You could probably climb down, but not while carrying
				something so dangerous and unwieldy as the arrow.\n";
				return(nil);
			}
			else 
			"It's a tough scramble down from the loft, but you manage to
			make it without hurting yourself too much.\b";
			return(barn);
		}
	}
	visibleconnection = barn
;

loft_window: window
	location = loft
	adjective = 'loft'
	isopen = true
	doLookthru(actor) = {
		"The loft window overlooks the twisty passages of the garden maze.
		In the distance you can see the buildings of the Acme Institute.";
	}
	doordest = wind_tunnel_path
	checktravel(actor) = {
		"Trying to go through the window would be suicidal- it looks like you'd
		land in the middle of a hedge, and never be able to get out again.\n";
		return nil;
	}

	ioThrowThrough(actor, dobj) = {
		"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch it fall
		into the tangled branches of the hedge below.  You'll never find it now.";
		dobj.moveInto(nil);
	}

	verDoClose( actor ) = "The window has not been used in quite some time, and
			      is stuck in its tracks.";
;

fib1: gardenpart
	north = garden_entrance
	west = fib2
;

fib2: gardenpart
	west = maze3
	east = fib1
	south = fib3
;

fib3: gardenpart
	south = fib4
	north = fib2
	east = fib1 /* Non topological, One way */
	west = maze3 /* Non topological, One way */
;

fib4: gardenpart
	west = fib5
	north = fib3
	east = fib3 /* Non topological, One way */
	south = fib4 /* Non topological, One way */
;

fib5: gardenpart
	east = fib4
	west = fib6
	north = fib1 /* Non topological, One way */
	south = fib3  /* Non topological, One way */
;

fib6: gardenpart
	west = fib7
	east = fib5
;

fib7: gardenpart
	north = fib8
	east = fib6
;

fib8: gardenpart
	north = fib9
	south = fib7
;

fib9: gardenpart
	north = fib10
	south = fib8
;

fib10: gardenpart
	north = fib11
	south = fib9
;

fib11: gardenpart
	north = carrotpatch
	south = fib10
;

/*
 * Vegetable Garden
 */

carrotpatch: outsideroom, buriedHider
	sdesc = "Vegetable Garden"
	ldesc = {
		"You have stumbled across a modest clearing in the convoluted
		garden path maze, surrounded on all sides but the south by the
		rank hedges that form the maze walls.  It appears some opportunistic
		herbivore has chosen to use this rarely-visited portion of
		the garden path maze to plant a vegetable patch.\b

		There doesn't seem to be anything growing here right now, but
		perhaps it's just not the right season yet. ";
		if (carrotsign.partof = vegetableplot)
			"A sign stuck into one part of the plot proudly proclaims the
			gardener's intended crop.";
	}
	north = gardenpart.mazehit
	east = gardenpart.mazehit
	west = gardenpart.mazehit
	south = fib11

	enterRoom(actor) = {
		if (bunny.location = self) bunny.activatenpc;
		pass enterRoom;
	}
	leaveRoom(actor) = {
		if (bunny.location = self) bunny.deactivatenpc;
		pass leaveRoom;
	}
	grounddesc = "The ground is well tended and raked."
	serialSearch = true
;

vegetableplot: ourdecoration, passdigging
	sdesc = "plot"
	ldesc = {
		"The plot is not very big, being constrained by the tight maze
		walls, though it does look well cared for.  The dirt has been
		raked";
		if (carrotsign.partof = vegetableplot)
			" and a small seed sign has been carefully placed in the dirt";
		".";
	}
	noun = 'plot' 'patch' 'garden'
	adjective = 'vegetable'
	location = carrotpatch
;

carrotsign: ouritem, throwable, partitem, readable
	sdesc = "seed sign"
	ldesc = "The sign says \"Peas and carrots, carrots and peas.\""
	noun = 'sign' 'sign'
	adjective = 'sign'

	partof = vegetableplot
;

/*
 * Objects
 */

gps_unit: ouritem, hiddenItem
	sdesc = "GPS unit"
	ldesc = { "It is a TMRC Garden Path Sequencing unit, one of the finest
		products ever to come out of the giant Turing Machine Repair Company
		plant, just a little bit too far away from Unnkulia for you to ever
		get a job there.
		On the front are 4 lights, labelled North, South, East and West. ";
		if (self.islit) self.provideNotice;
		else "None of them are on.";
	}
		
	location = nil
	searchLoc = chomskys_desk
	noun = 'unit'
	adjective = 'gps' 'tmrc' 'sequencing'

	bulk = 8

	islit = { return (self.containingroom.isinmaze); }
	provideNotice = {
		local rm;
		rm := self.containingroom;
		if (rm and rm.isinmaze and Me.isVisible(self)) {
			"\bThe GPS unit's "; say(rm.gps_forward);
			" light is green and its ";
			say(rm.gps_backward); " light is red. ";
			return true;
		}
	}
;

gps_lights: ourdecoration, partitem
	sdesc = "GPS lights"
	ldesc = {
		"The GPS unit's lights are fairly unremarkable.  ";
		if (gps_unit.islit) gps_unit.provideNotice;
		else "None of them are on.";
	}
	noun = 'lights' 'light'
	adjective = 'gps' 'unit\'s' 'units' 'north' 'south' 'east' 'west'

	partof = gps_unit
;

cheez_kee: keyItem, ourfooditem, throwable, ouritem
	sdesc = "cheez kee"
	ldesc = {
		"This pungent and finely-wrought cheez kee looks delectable.  ";
		if (self.nibbled)
			"Part of the kee seems to have been gnawed on, and it doesn't
			look like the kee will be very effective now.";
	}
	
	location = kitchen
	noun = 'key' 'kee'
	adjective = 'cheez' 'cheese' 'pungent'

	newenergy = 7
	nibbled = nil

	verIoUnlockWith( actor ) = {
		if (self.nibbled) {
			"The now-deformed cheez kee doesn't fit very well in the door.";
		}
	}

	ioUnlockWith( actor, dobj ) = {
		if (self.checkMouse(actor))
		        dobj.doUnlockWith( actor, self );
	}
	verIoLockWith( actor ) = { return self.verIoUnlockWith(actor); }
	ioLockWith( actor, dobj ) = {
		if (self.checkMouse(actor))
		        dobj.doLockWith( actor, self );
    	}

	checkMouse(actor) = {
		if ((actor.location = cave) and (not self.nibbled)) {
			if (cat.location <> cave) {
				self.nibbled := true;
				"As you reach for <<self.thedesc>> Heisenberg's mouse tunnels
				to its favorite food, as quantum animals are wont to do,
				and nibbles a bit of the kee before you can chase it back
				into phase-space. ";
				return nil;
			}
			else {
				"As you reach for <<self.thedesc>> Heisenberg's mouse tunnels
				nearby, sees <<cat.thedesc>>, and high-tails it into
				phase space with <<cat.thedesc>> right on its heels.  ";
				cat.moveInto(nil);
				changescore(10);
				return true;
			}
		}
		return true;
	}
;

/* The cheez cabinet is just a red herring. */

cheez_cabinet: ourdecoration, surface, lockableDoorway
	sdesc = "cheez cabinet"
	ldesc = "The cheez cabinet smells like it must contain some wonderful
		cheezes.  And you know how much Corduroy likes cheez.  The
		cabinet door is closed."
	location = kitchen
	noun = 'cabinet'
	adjective = 'cheez'
	mykey = missingKey
;

cabinet_door: lockableDoorway, ourdoorway
	sdesc = "cheez cabinet door"
	ldesc = "The cheez cabinet door looks quite sturdy and very closed."
	noun = 'door'
	adjective = 'cheez' 'cabinet'
	mykey = missingKey
	location = kitchen
	doordest = barn /* Anything- who cares? */
;

glottal_kee: keyItem, ouritem, hiddenItem, throwable
	sdesc = "glottal kee"
	ldesc = "It is a relatively plain kee, though somewhat glottalized."
	noun = 'key' 'kee'
	adjective = 'glottal' 'glottalized'
	behindLoc = linguistics_posters
	location = nil
;

shovel: ouritem, digger
	sdesc = "shovel"
	ldesc = "It is a common garden shovel, and seems well enough constructed that
		it's probably not an Acme product."
	location = cheezroom
	noun = 'shovel' 'spade' 'hoe'
	adjective = 'garden'
;

philosophy_paper: readable, ouritem, throwable
	sdesc = "philosophy paper"
	ldesc = "It appears to be a paper by Penrose, Drescher and Searle."
	readdesc = "The paper, by Penrose, Drescher and Searle, is titled
		\"Why AI is mired in a search for bananas: Alternative
		formulations from religion, art	history, and Abelian projections of
		tilings into manifold groups.\"
		The paper, though too long for you to do much more than check for
		citations of your work, seems to have some fuzzy bits in its
		arguments."
	location = table
	noun = 'paper' 'article'
	adjective = 'philosophy'
;

phonology_paper: readable, ouritem, throwable
	sdesc = "phonology paper"
	ldesc = "The phonology paper is titled \"Molecular Phonology and Berber\",
		by Baggett, Halle, and Kenstowicz."
	readdesc =
		"The paper is titled \"Molecular Phonology and Berber\",
		by Baggett, Halle and Kenstowicz.  It is terribly confusing, what
		with its thousands of diacritics and penchant for citing
		unpublished manuscripts and meetings in the hall.\b

		Among the passages from MPB that stand out on your casual
		reading are:\b

		\t\"The Berber culture frowns upon the users of vowels as being
		rude and uncultured, and instead uses words like `tmsxt'.
		Pronunciation of such words seems almost magical to non-native
		speakers.\b

		\t\"In Berber, as in most languages, the facts are that /p/'s must
		be aspirated, but since the Berber nuclear family generally 
		lacks the powerful wind tunnel necessary to aspirate /p/'s,
		the Berber stand mute, and are often incorrectly taken by 
		social psychologists to be reclusive.\b

		\t\"In contrast, English words must use aspirated /p/'s 
		word initially unless preceded by /s/; the energy required
		to aspirate a consonant is extraordinary, though.\b

		\t\"Glottalize or Die!\"\b

		After becoming totally confused, you stop reading."

	location = halles_desk
	noun = 'paper' 'article' 'mpb'
	adjective = 'phonology'
	footnote = {
		"In a stupefyingly subtle and mystifying way. Almost
		undetectable, really.";
	}
;

mathpostings: ourdecoration, readable
	sdesc = "postings"
	ldesc = "There are a variety of mathematical postings, one of which is
		connected, one tangential, and one incongruent."
	readdesc = "Please specify which posting you wish to read.\n"
	noun = 'postings'
	location = mathematics
;

mathposting1: ourdecoration, readable
	sdesc = "tangential posting"
	ldesc = "The tangential posting is made from recycled bananas."
	readdesc = "The tangential says \"Think!\""
	noun = 'posting'
	adjective = 'tangential'
	location = mathematics
;

mathposting2: ourdecoration, readable
	sdesc = "connected posting"
	ldesc = "The connected posting is made from recycled lumenberries."
	readdesc =
		"The connected posting reads:\b\b

		\t\t\ Acme Institute Distinguished Lecturer Series\b
		\t\t\t\t\t\t\ \ \ presents\b
		\t\t\t\t\t\ Prof.\ Louis Reasoner\n
		\t\t\tDepartment of Artificial Intelligence\b

		Prof.\ Reasoner will present his recent work in constructing\n
		intelligent programs for the Acme CM-8, which use a unique\n
		combination of genetic algorithms, neural networks, expert\n
		systems, hyperbolic string theory, and the cosine function.\b

		His work is scheduled for ARPA Turing Test evaluation, using\n
		the standard set of real-world scenarios that ARPA personnel\n
		have settled on as requiring intelligence `at or above the\n
		level we are qualified to gauge'.\b

		Says Prof.\ Reasoner, \"Shouldn't be any problem to pass the\n
		Turing Test.\ I expect to get the final bugs out of the code\n
		tonight.\"\b"
	noun = 'posting'
	adjective = 'connected'
	location = mathematics
;

mathposting3: ourdecoration, readable
	sdesc = "incongruent posting"
	ldesc = "Just kidding.  There isn't really an incongruent posting."
	noun = 'posting'
	adjective = 'incongruent'
	location = mathematics
;

class plannr: ouritem;

Acme_planner: plannr, hiddenItem
	sdesc = "Acme planner"
	adesc = "an Acme planner"
	ldesc = "It is a genuine Acme All-Purpose Planner, with inferior frobosity."
	location = nil
	behindLoc = plaque
	noun = 'planner'
	adjective = 'Acme'

	verDoTakeOut(actor, iobj) = {
		if (iobj = robot) self.verDoTakeOut(actor, robot_slot);
		else pass verDoTakeOut;
	}
;

nonlinear_planner: plannr
	sdesc = "nonlinear planner"
	ldesc = "It is a common nonlinear planner, of the sort generally
			produced by the Turing Machine Repair Company."
	noun = 'planner'
	adjective = 'nonlinear' 'tmrc' 'turing' 'machine' 'repair' 'company'
;

nonlinear_lanner: ouritem, hiddenItem, endjoinable
	sdesc = "nonlinear lanner"
	ldesc = "It is a common nonlinear lanner, of the sort generally
			produced by the Turing Machine Repair Company in
			the glorious days when Ben Bitdiddle was still chief programmer.
			Something seems to be missing from it, though."
	noun = 'lanner'
	adjective = 'nonlinear'
	location = nil

	said_planner = nil
	said_lead = nil
	ioJoinTo(actor, dobj) = {
		if (dobj = pea) {
			if (said_lead = nil) {
				"The join pushes and shoves, but try as it might it can
				not join <<self.thedesc>> and <<dobj.thedesc>>.  As the join
				is about to give up, what to your wondering eye should appear
				but Morris Halle.  He sizes you up, looks you straight in the
				eye, and says:\b
	
				\t\"I don't think I've ever met anyone so singularly ill at
				ease with human language before.  Not only are you an utter
				fool, but you deny the most basic and inviolable of facts.\b

				\tThat's not a /p/, is it?  \"pealanner\"?!?  What the hell
				is a pealanner?\b

				Please, don't make me come back again.\"\n";
				said_lead := true;
			}
			else "They don't fit.";
		}
		else if (dobj = thep) {
			if (thep.aspirated) {
				"The aspirated \"P\" and the nonlinear lanner fit
				together like two nibbles in a byte.  The result is
				a beautiful new TMRC Nonlinear Planner!\n";

				nonlinear_planner.moveInto(self.location);
				thep.moveInto(nil);
				nonlinear_lanner.moveInto(nil);

				changescore(10);
			}
			else {
				if (said_planner = nil) {
				"You try joining the \"P\" and the nonlinear lanner, but
				they just don't seem to fit.\b

				As you contemplate, perplexed, Morris Halle walks by,
				notices your problem, and says\b
				\t\"You fool!  Can you persist in ignoring the facts?  You
				can't join that kind of \"P\" there.  You'll have to aspirate
				it first.  I've got a paper on that somewhere-  stop by my
				office and I'll let you copy it.  You can page me at
				253-2483.\"\b

				Prof.\ Halle leaves in a state of haughty disgust.";
				said_planner := true;
				}
				else "They don't seem to join well.";
			}
		}
		else "They don't seem to join well.\n";
	};

qual_calculator: ouritem, hiddenItem, throwable
	sdesc = "qualitative calculator"
	ldesc = "The solar-powered Ronco (tm) <<note(self)>> qualitative calculator
		is a wonderful product of late night advertising acumen.  Not only
		is it available	in a variety of neon and pastel colors (this one is
		a tasteful green), but it is also guaranteed to provide at least
		1.58 bits of output information.  This, Ronco's top-of-the-line model,
		uses transverse-Romanian notation.  The calculator has 9 buttons:
		ZERO, POSITIVE, NEGATIVE, ADD, SUBTRACT, MULTIPLY, DIVIDE, Clear
		and deClear. The readout currently shows <<self.sayreadout>>."
	noun = 'calculator'
	adjective = 'ronco' 'qualitative' 'solar' 'powered' 'solar-powered' 'bright' 'green'
	location = nil
	searchLoc = alyssa_desk

	footnote = { "Respects to Walter Hamscher."; }
	stack = []
	secondstack = []
	saynewreadout = { "\nThe readout now shows <<self.sayreadout>>.\n"; }
	sayreadout = {
		local v;
		if (length(stack)<1) v:=0;
		else v:= stack[1];

		if (v=-1) "[[\ -\ ]]";
		else if (v=0) "[[\ 0\ ]]";
		else if (v=1) "[[\ +\ ]]";
		else "[[\ ?\ ]]";
	}
	pop = {
		local v;
		if (length(stack)<1) v := 0;
		else { v := car(stack); stack := cdr(stack); }
		return(v);
	}
;

readout: ourdecoration, partitem
	sdesc = "readout"
	ldesc = { qual_calculator.saynewreadout; }
	partof = qual_calculator
	noun = 'readout'
	adjective = 'calculator'
;

qualbutton: ourdecoration, buttonitem, partitem
	ldesc = "There is nothing special about <<self.thedesc>>."
	noun = 'button'
	partof = qual_calculator
;

clear: qualbutton
	sdesc = "Clear button"
	adjective = 'clear' 'kleer'
	doPush(actor) = {
		qual_calculator.secondstack := qual_calculator.stack;
		qual_calculator.stack := [];
		qual_calculator.saynewreadout;
	}
;

declear: qualbutton
	sdesc = "Clear button"
	adjective = 'declear' 'dekleer'
	doPush(actor) = {
		local tmp;
		tmp := qual_calculator.stack;
		qual_calculator.stack := qual_calculator.secondstack;
		qual_calculator.secondstack := tmp;
		qual_calculator.saynewreadout;
	}
;

zerobutton: qualbutton
	sdesc = "ZERO button"
	adjective = 'zero'
	doPush(actor) = {
		qual_calculator.stack := [ 0 ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

positivebutton: qualbutton
	sdesc = "POSITIVE button"
	adjective = 'positive'
	doPush(actor) = {
		qual_calculator.stack := [ 1 ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

negativebutton: qualbutton
	sdesc = "NEGATIVE button"
	adjective = 'negative'
	doPush(actor) = {
		qual_calculator.stack := [ -1 ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

addbutton: qualbutton
	sdesc = "ADD button"
	adjective = 'add'
	doPush(actor) = {
		local v, v1, v2;
		v1 := qual_calculator.pop;
		v2 := qual_calculator.pop;
		if (v1=2 or v2=2) v := 2;
		else if ((v1=1 and v2=-1) or (v1=-1 and v2=1)) v := 2;
		else if (v1=1 or v2=1) v := 1;
		else if (v1=-1 or v2=-1) v := -1;
		else v := 0;
		qual_calculator.stack := [ v ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

subtractbutton: qualbutton
	sdesc = "SUBTRACT button"
	adjective = 'subtract'
	doPush(actor) = {
		local v, v1, v2;
		v1 := qual_calculator.pop;
		v2 := qual_calculator.pop;
		if (v1=2 or v2=2) v := 2;
		else if ((v1=1 and v2=1) or (v1=-1 and v2=-1)) v := 2;
		else if (v2<>0) v := v2;
		else v := -v1;
		qual_calculator.stack := [ v ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

multiplybutton: qualbutton
	sdesc = "MULTIPLY button"
	adjective = 'multiply'
	doPush(actor) = {
		local v, v1, v2;
		v1 := qual_calculator.pop;
		v2 := qual_calculator.pop;
		if (v1=2 or v2=2) v := 2;
		else if (v1=0 or v2=0) v:= 0;
		else if (v1=v2) v := 1;
		else v := -1;
		qual_calculator.stack := [ v ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

dividebutton: qualbutton
	sdesc = "DIVIDE button"
	adjective = 'divide'
	doPush(actor) = {
		local v, v1, v2;
		v1 := qual_calculator.pop;
		v2 := qual_calculator.pop;
		if (v1=2 or v2=2 or v1=0) v := 2;
		else if (v2=0) v := 0;
		else if (v1=v2) v := 1;
		else v := -1;
		qual_calculator.stack := [ v ] + qual_calculator.stack; 
		qual_calculator.saynewreadout;
	}
;

/* Just for the words. */
battery: ouritem
	sdesc = "battery"
	noun = 'battery' 'batteries' 'energizer'
	location = nil
;

lambda_calculator: ouritem, throwable
	sdesc = "lambda kalkulator"
	ldesc = "It is an Acme lambda kalkulator, capable, their advertisements claim,
		of kurrying, beta-reducing, and even klosure-kreating.  There are
		8 buttons on the front, marked LAMBDA, OPENPAREN, CLOSEPAREN, PERIOD,
		X, Y, APPLY and EVAL.  Unfortunately, like most results of the Acme
		manufacturing process, it is unfunctional, in this case because it has
		no batteries.  The display screen is blank."
	location = mathematics
	noun = 'calculator' 'kalkulator' 'lambda'
	adjective = 'lambda' 'Acme'
;

display_screen: ourdecoration, partitem
	sdesc = "kalkulator display screen"
	ldesc = "The display screen is blank."
	noun = 'screen'
	adjective = 'kalkulator' 'display' 'lambda'
	partof = lambda_calculator
;

lambdacalc_button: ourdecoration, buttonitem, partitem
	ldesc = "There is nothing special about <<self.thedesc>>."
	partof = lambda_calculator
	noun = 'button'
	doPush(actor) = {
		"Pushing <<self.thedesc>> has no effect, as the kalkulator is batteryless.\n";
	}
;

lambda_button: lambdacalc_button
	sdesc = "LAMBDA button"
	adjective = 'lambda'
;	

eval_button: lambdacalc_button
	sdesc = "EVAL button"
	adjective = 'eval'
;	

apply_button: lambdacalc_button
	sdesc = "APPLY button"
	adjective = 'apply'
;	

x_button: lambdacalc_button
	sdesc = "X button"
	adjective = 'x'
;	

y_button: lambdacalc_button
	sdesc = "Y button"
	adjective = 'y'
;	

openparen_button: lambdacalc_button
	sdesc = "OPENPAREN button"
	adjective = 'openparen'
;	

closeparen_button: lambdacalc_button
	sdesc = "CLOSEPAREN button"
	adjective = 'closeparen'
;	

period_button: lambdacalc_button
	sdesc = "PERIOD button"
	adjective = 'period'
;	

toaster: ouritem, unlisted
	sdesc = "aerodynamic toaster"
	adesc = "an aerodynamic toaster"
	ldesc = {
		"The Acme aerodynamic toaster has large red wings and advertises itself
		as the only aerodynamic toaster made with fuzzy logic.  On the
		side of the toaster is a lever, and the top has a slot.  ";
		if (not toaster_slot.isopen) "The lever is depressed.  ";
		if (not self.fixed)
			"Upon detailed inspection you notice that the toaster does not
			actually contain any fuzzy logic. ";
		self.doLookin(Me);
	}
	noun = 'toaster'
	adjective = 'aerodynamic' 'Acme'
	location = cheez_cabinet

	fixed = nil

	verIoPutIn(actor) = { return toaster_slot.verIoPutIn(actor); }
	ioPutIn( actor, dobj ) = { return toaster_slot.ioPutIn(actor,dobj); }

	verDoLookin(actor) = {}
	doLookin(actor) = {
		if (toaster_slot.isopen) {
			if (itemcnt( toaster_slot.contents)) {
				"\b\The toaster seems to contain ";
				listcont(toaster_slot); ". ";
			}
			else "The toaster is empty.  ";
		}
		else { "The toaster slot cover hides the inside of the toaster from
			%your% gaze.  "; }
	}

	verDoTake(actor) = {
		"As you attempt to take the toaster, Carl, the owner of the Cheez Boar
		Inn, comes in, throttles you for a moment or two, and shouts obscenities
		in an unknown language.  You put the toaster back down again. ";
		changescore(-5);
	}
	poptoast = {
		toaster_slot.isopen := true;
		"\nThe toaster lever has just popped up. ";
		if (slicebread.location = toaster_slot) {
			if (slicebread.istoast or slicebread.isburnt or
				(not self.fixed)) {
				if (not slicebread.isburnt)
					changescore(-6);
				slicebread.isburnt := true;
			}
			else {
				slicebread.istoast := true;
				changescore(6);
			}
		}
	}
;

/* If you make the toaster_slot be a partitem, it no longer
 * works correctly, so don't.
 */

toaster_slot: ourdecoration, qcontainer
	sdesc = "toaster slot"
	ldesc = {
		"The toaster slot is where you put the bread.  ";
		if (not self.isopen) "A retractable cover has sprung into place to
			prevent you from burning your fingers while the
			toaster is operating.  ";
		else toaster.doLookin(Me);
	}
	noun = 'slot'
	adjective = 'toaster'
	location = kitchen

	verDoOpen( actor ) = "I don't know how to open <<self.thedesc>>. "
	verDoClose( actor ) = "I don't know how to close <<self.thedesc>>. "

	maxbulk = 0

	verIoPutIn(actor) = {
		if (not self.isopen)
			"You can't put anything in the toaster while it's toasting.";
		else
			pass verIoPutIn;
	}
	ioPutIn( actor, dobj ) = {
		if (dobj = fuzzybits) {
			"You hear a sort of soft, squishy sound as you put the fuzzy bits
			 in the toaster.";
			toaster.fixed := true;
			changescore(2);
			dobj.moveInto(nil);
		}
		else
			pass ioPutIn;
	}
;

toaster_cover: ourdecoration, partitem
	sdesc = "toaster cover"
	ldesc = "The retractable toaster slot cover, 
		the hallmark of an Acme Kid-Safe product,
		is designed to prevent children from burning their fingers
		while the toaster is in operation.  "
	noun = 'cover'
	adjective = 'toaster' 'slot'
	partof = toaster
;

toaster_wings: ourdecoration, partitem
	sdesc = "toaster wings"
	ldesc = "The wings looks really mod, like something out of Buck Rogers.  "
	noun = 'wing' 'wings'
	adjective = 'toaster' 'red'
	partof = toaster
;

toaster_lever: ourdecoration, partitem
	sdesc = "toaster lever"
	ldesc = {
		"The toaster lever is exactly the sort of cheap plastic
		lever you'd expect to find on an Acme product.  ";
		if (not toaster_slot.isopen) "  The lever is depressed.  ";
	}
	noun = 'lever' 'button'
	adjective = 'toaster' 'plastic' 'cheap'
	partof = toaster

	verDoPush(actor) = {
		if (not toaster_slot.isopen) "The lever is already depressed.  ";
	}
	doPush(actor) = {
		toaster_slot.isopen := nil;
		notify(toaster, &poptoast, 5);
		"You have depressed <<self.thedesc>>.";
	}
;

carrot: ouritem, ourfooditem, hiddenItem, throwable
	sdesc = "carrot"
	ldesc = "The carrot is orange and nutritious.  Maybe eating it will improve
		your vision."
	location = nil
	buriedLoc = carrotpatch
	noun = 'carrot'
	adjective = 'orange' 'nutritious'

	newenergy = 12 /* Enough for the wind tunnel! */
;

pea: ouritem, ourfooditem, hiddenItem, throwable, joinable
	sdesc = "pea"
	ldesc = "The pea is green and nutritious, perfectly spherical and rich in
		chlorophyll."
	location = nil
	buriedLoc = carrotpatch
	noun = 'pea'
	adjective = 'green' 'nutritious' 'spherical'

	newenergy = 6

	ioJoinTo(actor, dobj) = {
		if (dobj = humblebee or dobj = deadbee) {
			"The scent of petroleum lingers in the air.";
			self.moveInto(nil);
			dobj.moveInto(nil);
			humblebee.deactivatenpc;
		}
		else "They don't seem to join well.\n";
	}
;

telephone: ouritem, throwable
	sdesc = "telephone"
	ldesc = { "The blood-red Acme telephone <<note(self)>> is constructed of
		the finest linoleum";
		if (self.broken) ", and appears to be broken";
		".";
		}
	location = phonebooth
	noun = 'phone' 'telephone' 'cord'
	adjective = 'Acme' 'red' 'blood-red' 'broken'

	bulk = 6

	broken = nil
	rotated = true
	scored = nil

	footnote = {
		"To use the phone to call a number, such as 253-5659, you would
		\"dial 2535659\".";
	}

	doTake(actor) = {
		if (not self.broken)
			"Removing the telephone results in a broken phone, not an uncommon
			state for Acme products to be in.\b";
		self.broken := true;
		pass doTake;
		}
	verDoTurn(actor) = nil
	doTurn(actor) = {
		if (self.rotated) {
			"You rotate the telephone ninety degrees right, out of the
			 imaginary plane.";
			rotated := nil;
			if (self.scored = nil) {
				self.scored := true;
				changescore(1);
			}
		}
		else {
			"You rotate the telephone ninety degrees left, into the
			imaginary plane.";
			rotated := true;
		}
	}
	verIoCallOn(actor) = {}
	ioCallOn(actor, dobj) = {
		if (dobj <> numObj) {
			"You must dial a telephone number.";
			return(nil);
		}
		if (actor.location = specialmaze) {
			"Just as you are about to dial the number, the telephone tunnels
			out of your presence, dancing through probability space.";
			self.moveInto(phonebooth);
		}
		else if (self.broken) "You don't even get a dial tone- the phone is broken,
				remember?";
		else if (self.rotated)
			"You dial the number, and after a short wait hear:\b
			\t\"This is your Acme personal operator.  The number you have
			dialed is imaginary.  Please check your number and try
			again.  And get a clue!\"";
		else if (dobj.value = 2538170) {
			"Just as you are about to dial the number, the telephone tunnels
			out of your presence, damaging its cord while prancing through
			probability space.";
			self.broken := true;
			self.moveInto(specialmaze);
		}
		else if (dobj.value = 2532483) {
			"You dial the number, and after a short wait hear the recorded
			message:\b

			\t\"Morris is out checking on some facts today, but if you need to
			get into his office, he usually keeps a key behind a poster.
			Have a nice day, and remember, Glottalize or Die!\"

			Thank you for using the Acme paging service, where every message
			comes from the heart.";
		}
		else if (dobj.value = 2536567) {
			"You dial the number, and after a short wait hear the recorded
			message:\b

			\t\"Hi, You've reached the Acme Institute for the <<instname()>>\ 
			Sciences admissions department.  Our beautiful institute grounds
			lie just a bit north of the bus station in the Eastern Unnkulian
			valley.\b

			\tThe institute believes that education is to be found in the
			experience of life itself, and not in the classroom.  Our professors
			merely provide learning experiences.  The only formal requirement
			we have	for awarding a degree is the delivery of a single banana to Dean
			Chiquita.\b

			\tFor further information on the institute, call 253-8170.  Thank you,
			and have a cheezy day.\"\b";
			}
		else
			"You dial the number, and after a short wait hear:\b

			\t\"This is your Acme personal operator.  The number you have
			dialed does not exist, and is not likely to exist in the near
			future.  Ha, you consumer slime!\"";
	}
;

flask: ouritem, liquidcontainer, throwable, hiddenItem
	bdesc = "flask"
	ldesc = { self.lldesc; "It has few other distinguishing characteristics. "; }
	noun = 'flask'
	adjective = 'small'
	location = nil
	searchLoc = horses_mouth

	liquidcontents = lemonjuice
	contents = [ lemonjuice ]
;

water: drink
	sdesc = "water"
	ldesc = "Surely you know what water looks like pretty well by now."
	noun = 'water'
;

lemonjuice: drink
	sdesc = "lemon juice"
	ldesc = "Lemon juice clears your complexion."
	noun = 'juice'
	adjective = 'lemon'

	iscleaner = true
	drinkme(actor) = "A bit sour, but you purse your lips and take it like a man."
;

spritzer: ouritem, sprayingitem, throwable
	bdesc = "spritzer"
	ldesc = {
		"This is your pretty standard university-issue whiteboard
		spritzer <<note(self)>>.  ";
		self.lldesc;
	}
	noun = 'spritzer'
	adjective = 'university' 'whiteboard'

	footnote = {
		"To spray something with the spritzer, you would \"spray X with spritzer\",
		or \"spray spritzer on X\".";
	}
	liquidcontents = Acme_cleaner
	contents = [ Acme_cleaner ]

	location = physics_office
;

Acme_cleaner: poisonousdrink
	sdesc = "Acme whiteboard cleaner"
	ldesc = "This is the genuine Acme original, black and tarry and quite likely
		poisonous."
	noun = 'cleaner'
	adjective = 'whiteboard' 'acme'

	isgrimifier = true
;

chomskyboard: whiteboard
	location = chomskys_office
	writing = 'The entire whiteboard is devoted to the derivation of a single grammatical
		sentence, \"John ran\", and the writer seems to have been cramming to make
		it all fit.  The use of a paging file for the board might help, you think.
		Yes, that\'d be a quick PhD- \"Paging Files for Whiteboards.\"'
;

lectureboard: whiteboard
	location = lecturehall
	writing = 'The whiteboard is a mess.  So many people have written on it
		in different inks and different handwriting styles that any sense
		of the original discussions is long gone.  Quite obviously the institute
		has a serious lack of good whiteboard cleaner.  Either that or
		everybody here just loves a mess.'
;

ourphonebooth: ourdecoration, multilocation, enterable, exitable
	sdesc = "phone booth"
	ldesc = "The blue phone booth looks just a bit too small to be comfortable,
		and reminds you of the cramped bus that got you
		from the Unnkulian backwater to this place.  Somehow, you suspect,
		the Acme corporation probably had something to do with the ergonomics
		of this small structure."
	noun = 'booth' 'phonebooth'
	adjective = 'phone' 'blue' 'small'
	locations = [ startroom phonebooth ]
	enterdir = &in
	exitdir = &out
;

physicsboard: whiteboard
	location = physics_office
	writing = 'Most of the equations on the whiteboard are far beyond the ken
		of one whose previous education has mainly consisted of being beaten
		at regular intervals. From what you can tell, however, the last person
		to add to the blackboard was interested in probability distributions.'
;

cm8: ourdecoration, multilocation, enterable, exitable
	sdesc = "CM-8"
	ldesc = {
		"The octagonal Acme Contraption Machine (a CM-8) ";
		if (cmlights.appearblinking) {
			"has ";
			if (powerswitch.isActive) "thousands of ";
			"blinking lights and ";
		}
		if (self.ishumming) {
			"is humming loudly";
			if (powerswitch.isActive) " and insistently";
			". Being an Acme machine, you suspect it may soon explode. ";
		}
		else
			"is unusually quiet for an Acme machine.  In fact, it seems
			to be off.  ";
		"Like all Contraption Machines, the black exterior, sliding panel";
		if (cmdoor_1.isopen) " (now open)";
		", lights, and other whimsical extravagances seem to be the result of
		an overactive Acme marketing organization.";
	}
	locations = [ computer_room in_computer]
	enterdir = &in
	exitdir = &out

	noun = 'cm-8' 'cm8' 'machine' 'computer' 'cm'
	adjective = 'Acme' 'contraption'

	ishumming = {
		 return(powerswitch.isActive or
			 humblebee.containingroom = in_computer);
	}

	verDoOpen( actor ) = { cmdoor_1.verDoOpen(actor); }
	doOpen( actor ) = { cmdoor_1.doOpen(actor); }
	verDoClose( actor ) = { cmdoor_1.verDoClose(actor); }
	doClose( actor ) = { cmdoor_1.doClose(actor); }
	verDoLookin(actor) = {
		if (not cmdoor_1.isopen) "You'll have to open the panel first.\n";
	}
	doLookin(actor) =
		"There is probably enough space inside the contraption
		machine for you to fit.\n"
;

cmholes: ourdecoration, partitem, qcontainer
	sdesc = "holes"
	ldesc = {
		"The thousands of holes cover the sides of the Contraption Machine,
		most of them filled with lights.  ";
		if (berries.location = self)
			"Upon close inspection you also see some berries that
			have been stuffed into the holes. ";
	}
	partof = cm8
	noun = 'hole' 'holes' 'depressions'
	adjective = 'contraption' 'machine'

	ioPutIn(actor, dobj) = {
		if (dobj = berries) {
			"The berries just fit in the holes, and you manage to
			populate a fair number of the depressions before running
			out of berries.";
			dobj.moveInto(self);
		}
		else "\^<<dobj.thedesc>> doesn't fit in <<self.thedesc>>.";
	}
;

cmlights: ourdecoration, partitem
	sdesc = "lights"
	ldesc = {
		"The lights are your standard garden-variety Acme red LEDs,
		each one nestled in a hole in the black exterior. ";
		if (self.appearblinking) "They are currently blinking. ";
	}
	noun = 'lights' 'light' 'LED' 'LEDs'
	adjective = 'red' 'blinking' 'computer' 'machine' 'cm8' 'cm-8'
	partof = cm8

	appearblinking = {
		return (powerswitch.isActive or (berries.location = cmholes
				 and berries.isblinking));
	}
		
;

electronics: ourdecoration
	sdesc = "electronics"
	ldesc = "The electronics are far too complex for a simpleton like you to
			fathom.  But they look really cool."
	location = in_computer
	noun = 'electronics' 'hardware'
;

switches: ourdecoration
	sdesc = "switches"
	ldesc = "There are many, many switches, most of which you would be an absolute
			fool to touch.  One in particular catches your eye, though, the
			power switch."
	location = in_computer
	noun = 'switches'
;

powerswitch: ourswitchitem, ourdecoration
	sdesc = "power switch"
	ldesc = { "The big red power switch is currently in the ";
			if (self.isActive) "on"; else "off";
		" position.\n"; }
	location = in_computer
	noun = 'switch' 'power'
	adjective = 'red' 'power'
	isActive = true;
;

fork: ouritem, throwable
	sdesc = "fork"
	ldesc = "The fork looks curiously like the sort of fork you
		would expect to find inside a powerful, multiprocessing
		contraption."
	location = in_computer
	noun = 'fork'

	doPutOn( actor, iobj ) = {
		if (iobj <> table) return self.moveInto(iobj);

		"As you put the fork down on the table, a philosopher who already
		had a knife leaps for it, grabs it, and immediately starts
		gorging himself on the ham.  Within seconds the rest begin arguing about
		whether asymmetry is repugnant to reason and whether an asymmetric
		universe in which one eats and another doesn't is a refutation of the
		very concept of divine right...";

		philosophers.aredeadlocked := nil;
		self.moveInto(philosophers);

		changescore(7);
	}
;

join: ouritem, throwable
	sdesc = "join"
	ldesc = "If you had this fine join, you could probably join two things with
		`join X to Y', but maybe not.  It's hard to tell until you try
		things."
	location = in_computer
	noun = 'join'
;

table: ourdecoration, surface
	sdesc = "refectory table"
	ldesc = "The refectory table is a dark oak, but this is difficult
		to tell, what with the enormous feast laid upon it."
	noun = 'table'
	adjective = 'oak' 'dark' 'refectory'
	location = diningroom

	contentsReachable = {
		if ( philosophers.aredeadlocked ) {
			"The arms of the philosophers are firmly locked together
			on each other's eating utensils,
			and it proves impossible to get anywhere near the middle
			of the table.  ";
			return nil;
		}
		else return true;
	}
;

food: ourdecoration
	sdesc = "food"
	ldesc = "There is more food than 12 philosophers would ever need.  Gluttony, that's
		what it is."
	noun = 'food' 'feast' 'dinner'
	location = table

        verDoTake( actor ) = "There is too much food for you to take all at once."
;

slicebread: ouritem, ourfooditem, throwable
	sdesc = {
		if (self.istoast) "slice of toast";
		else if (self.isburnt) "burnt toast";
		else "slice of bread";
	}
	adesc = {
		if (self.istoast) "a slice of toast";
		else if (self.isburnt) "burnt toast";
		else "a slice of bread";
	}
	ldesc = {
		if (self.isburnt)
			"The <<self.sdesc>> seems a bit charred.";
		else if (self.istoast)
			"The <<self.sdesc>> looks delectable.";
		else "Wheat, it looks like.";
	}

	bulk = 0

	noun = 'bread' 'slice' 'toast'
	adjective = 'wheat' 'burnt'
	location = table

	isburnt = nil
	istoast = nil

	newenergy = 3
;;

ham: ourfooditem
	sdesc = "piece of ham"
	ldesc = "The piece of ham looks like a philosopher already got a bite of it."
	noun = 'ham' 'piece'
	location = table

        verDoTake( actor ) =
		"As you try to take <<self.thedesc>>, one of the philosophers grabs it
		back, saying \"Let not the ham fall to the heathens.\""
;

lettuce: ourfooditem, throwable
	sdesc = "head of lettuce"
	ldesc = "The lettuce looks perfect for feeding small rodents."
	noun = 'lettuce' 'head'
	location = table

	newenergy = 7
;;

fuzzybits: ouritem, throwable, partitem
	sdesc = "fuzzy bits"
	adesc = "some fuzzy bits"
	ldesc = "They are very, very fuzzy bits."
	noun = 'bit' 'bits' 'logic'
	adjective = 'fuzzy'

	partof = philosophy_paper
;

uranium: ouritem, lightsource, radioactiveobject, throwable
	sdesc = "glowing rock"
	ldesc = "The mottled rock is glowing a bright green."
	noun = 'rock'
	adjective = 'glowing'
	location = cave

	/* Have to get rid of "on/off" properties */

	islit = true

	verDoTurnon(actor) = "Are you trying to arouse a rock?"
	verDoTurnoff(actor) = "You can't switch a rock off!"
;

blackbox: ouritem
	sdesc = "black box"
	ldesc = "The black box's dimensions are about 1x1x3 feet, and you find it very
		difficult to determine whether there is anything in it."
	location = physics_office
	noun = 'box'
	adjective = 'black'

	bulk = 10
	iscatinside = true

	checkForRadiationAndCream = {
		if (self.isVisible(uranium) and self.iscatinside) {
			if (self.isVisible(Me))
				"\b\tYou hear a fast clicking noise.";
			iscatinside := nil;
			unnotify(self, &checkForRadiationAndCream);
		}
		else if (self.isVisible(saucer) and (saucer.liquidcontents = milk)
				 and self.iscatinside) {
			cat.moveInto(saucer.containingroom);
			cat.activatenpc;
			if (cat.isVisible(Me))
				"\b\t<<cat.thedesc>> tunnels in from nowhere and begins
				lapping at the milk in the saucer.";
			changescore(7);
			iscatinside := nil;
			saucer.emptyquietly(nil);
			unnotify(self, &checkForRadiationAndCream);
		}
	}
   	verDoLookin( actor ) = {
        	"%You% stare as hard as you can, but still remain completely 
		unable to make out anything in "; self.thedesc; ". ";
	}
;

/* Red herring */

golfball: ouritem, hiddenItem, throwable
	sdesc = "golf ball"
	ldesc = "A blue label on the dimpled, white ball reads \"Blue Bart's Golf Emporium\"."
	location = nil
	buriedLoc = wind_tunnel_path
	noun = 'ball' 'golfball'
	adjective = 'blue' 'white' 'golf' 'dimpled'

	verDoPuttWith(actor,iobj) = {
		if (self.location <> westhall and self.location <> easthall)
			"You can't putt <<self.thedesc>> unless it's on a suitable surface.";
	}
	verDoAttackWith(actor,iobj) = {
		if (self.location <> westhall and self.location <> easthall)
			"You can't hit <<self.thedesc>> unless it's on a suitable surface.";
	}
	verIoSwingAt(actor) = {
		if (self.location <> westhall and self.location <> easthall)
			"You can't putt <<self.thedesc>> unless it's on a suitable surface.";
	}
	ioSwingAt(actor,dobj) = { dobj.ioPuttWith(actor,self); }
;

treadmill: ourdecoration, container
	sdesc = "cylindrical depression"
	ldesc = {
		"The depression extends into the wall about a foot and has small
		wire ridges around the perimeter that extend the length of the cylinder.";
		if (itemcnt( treadmill.contents )) { "\b"; showcontcont(treadmill); }
	}
	
	location = wind_tunnel
	noun = 'depression' 'cylinder' 'tube' 'treadmill' 'hole'
	adjective = 'cylindrical' 'wall'

	/* When the hamster gets put in the treadmill, it will start to run,
	 * providing it has the energy.  When it is taken out, it will stop.
	 */

	ioPutIn(actor, dobj) = {
		if (defined(dobj, &notifyInTreadmill)) {
			dobj.notifyInTreadmill;
			dobj.moveInto(self);
		}
		else
			pass ioPutIn;
	}
	Grab(obj) = {
		obj.notifyNotInTreadmill;
		pass Grab;
	}

	maxbulk = 5;
;

thep: ouritem, joinable, throwable
	sdesc = "P"
	ldesc = {
		"The \"P\" seems to be Times Roman";
		if (self.aspirated = true) ", and highly aspirated.";
		else ", and unaspirated.";
	}
	location = nil
	noun = 'p'
	adjective = 'unaspirated' 'aspirated'

	aspirated = nil

	verDoAspirate(actor) = {}
	doAspirate(actor) = { self.aspirate; }

	aspirate = { 
		if (self.aspirated = nil) {
			self.aspirated := true;
			changescore(5);
		}
	}

	ioJoinTo(actor, dobj) = {
		if (dobj = humblebee or dobj = deadbee) {
			"In a deafening celestial fanfare, a ctrl-G shakes the skies.";
			self.moveInto(nil);
			dobj.moveInto(nil);
			humblebee.deactivatenpc;
		}
		else "They don't seem to join well.\n";
	}
;

youridea: ouritem, throwable
	sdesc = "idea"
	adesc = "an idea"
	ldesc = "As ideas go, it's pretty good."
	location = nil
	noun = 'idea'
	adjective = 'good'
;

badidea: ouritem, throwable
	sdesc = "bad idea"
	ldesc = "As ideas go, it stinks. No good at all. Truly, destined for ignominy."
	location = nil
	noun = 'idea' 
	adjective = 'bad' 'crushed'
;

paperplane: ouritem, readable, throwable
	sdesc = "paper airplane"
	ldesc = "The paper airplane was probably put together in a hurry
		during a lecture, and doesn't look like it would be capable of
		flying too far.  Apparently it was made out of a flyer someone
		got during a class."
	noun = 'plane' 'airplane' 'flyer'
	adjective = 'air' 'paper'
	location = chamber_platform

	readdesc =
		"The flyer reads:\b

		\t\t\t \(*** The Cheez Boar Inn ***\)\b

		\tProudly presents a happy hour special:\n
		\tStop by now and ask Carl, our bartender, for a Bud Lite.\n
		\tThey're free for a limited time only!\b

		\tBring a cheez coupon and get a free refractifier.\n
		\tFinish coloring our bar and win a big prize!\n"

	doThrow(actor) = {
		"The plane doesn't fly very well; perhaps they hadn't finished
		testing it in the wind tunnel.  It goes a few feet and lands
		at your feet.";
	        self.moveInto(actor.location);
	}
;

lambda_manuscript: readable, ouritem, throwable
	sdesc = "manuscript"
	ldesc = "The manuscript is titled \"Lambda: The Ultimate Pejorative\",
		by A.\ P.\ Hacker and B.\ Bitdiddle."
	readdesc =
		"The manuscript, a draft of A.\ P.\ Hacker and B.\ Bitdiddle's upcoming
		slasher-thriller, discusses the extension of Scheme with two new special
		forms,\b

		\t\t call-with-unexpected-continuation and\n
		\t\t call-with-nondeterministic-continuation.\b

		The \(cwuc\) form evaluates an expression in an environment where a symbol
		is bound to the continuation the programmer will least expect the symbol
		to be bound to.  The \(cwnc\) form is similar, but non-deterministically
		evaluates the expression with an arbitrary number of unusual continuations.
		They note that the effects of these new special forms can be reproduced
		with ease in most Unix environments."
	location = lecturehall /* Move into an office eventually. */
	noun = 'manuscript' 'draft'
	adjective = 'lambda'
;

milk: drink
	sdesc = "milk"
	ldesc = "The milk looks fresh-squeezed."
	noun = 'cream' 'milk'

	drinkme(actor) = { "The fresh milk packs quite a kick.\n"; }
;

brokenglass: ouritem, throwable, hiddenItem, named
	sdesc = "some broken glass"
	ldesc = "The glass looks like it might once have made up a bottle."
	noun = 'glass'
	adjective = 'broken'
	location = nil
;

zenobottle: ouritem, liquidcontainer, breakable, named, hiddenItem
	bdesc = "Zeno's bottle"
	ldesc = {
		"The bottle is ";
		if (self.liquidcontents) {
			 if (self.emptiness <> 1) {
				if (self.emptiness > 1000000000) "not very ";
				else { "now 1/"; say(self.emptiness); " ";}
			}
			"full of <<self.liquidcontents.sdesc>>. ";
		}
		else " empty. ";
	}
	searchLoc = haystack
	bulk = 5
	noun = 'bottle'
	adjective = 'zeno' 'zeno\'s' 'zenos'

	contents = [ milk ]
	liquidcontents = milk

	previously_emptied = nil

	emptiness = 1
	empty(fully) = {
		if (fully = nil) {
			if (self.emptiness < 1000000000)
				self.emptiness := self.emptiness * 2;
			caps();	self.ldesc;
		}
		else {
			"As the countably infinite meets the indenumerable, a natural
			victor emerges.\n";
			emptiness := 1;
			if (not self.previously_emptied) {
				changescore(5);
				self.previously_emptied := true;
			}
			pass empty;
		}
	}
;

arrow: unlisted, ouritem	
	sdesc = "arrow"
	adesc = "an arrow"
	ldesc = "It is an ordinary arrow, with a flint head and feathered butt."
	noun = 'arrow'

	location = gps3

	taken = nil

	moveInto(location) = {
		self.isListed := true;
		self.taken := true; 
		pass moveInto;
	}
	verDoShootWith(actor, iobj) = {}
	verDoThrow(actor) = {}
	verDoThrowAt(actor,iobj) = {}
	verDoThrowThrough(actor,iobj) = {}
	verDoThrowTo(actor,iobj) = {}
	doThrowAt(actor, iobj) = { self.doThrow(actor); }
	doThrowTo(actor, iobj) = { self.doThrow(actor); }
	doThrowThrough(actor, iobj) = { self.doThrow(actor); }
	doThrow(actor) = {
		"You throw the Acme Kid-Safe arrow.  It has been carefully designed by the
		engineers at Acme to prevent children from using it improperly and accidentally
		hurting themselves, so it disintegrates into thousands of microscopic slivers.";
		arrow.moveInto(nil);
	}
;

beer: drink, lightsource
	sdesc = {
		"Bud Lite";
		if (self.islit) " (lit)";
	}
	ldesc = {
		"So few people at the <<instname()>> Institute are willing to drink
		Bud Lite that the Cheez Boar Inn has been trying to get rid of their
		case for 27 years now.  The Bud Lite is ";
		if (not self.islit) "not "; "currently lit. ";
	}
	noun = 'beer' 'bud' 'lite' 'lite' 'lamp' 'lantern' 'light'
	adjective = 'bud'

	verDoTurnon(actor) = {
		if (self.islit)
			"It's already on.";
	}
	doTurnon(actor) = {
		"Your Bud Lite is now on, and emiting a stale, beer-like glow.";
		self.islit := true;
	}
	verDoTurnoff(actor) = {
		if (not self.islit)
			"It's already off.";
	}
	doTurnoff(actor) = {
		"Your Bud Lite is now off.";
		self.islit := nil;
	}
	verDoLight(actor) = { self.verDoTurnon(actor); }
	doLight(actor) = { self.doTurnon(actor); }

	drinkme(actor) = { "The Budweiser has a watery and domestic taste
			about it.  You're taste buds aren't impressed.\n";
			changescore(-3);
	}
;

can: ouritem, liquidcontainer, throwable
	bdesc = "can"
	ldesc = {
		"\^The can holds the usual 12 ounces. ";
		self.lldesc;
	}
	noun = 'can'
	location = nil

	contents = [ beer ]
	liquidcontents = beer
;

saucer: ouritem, liquidcontainer, breakable
	bdesc = "saucer"
	ldesc = {
		"There is nothing unusual about this china saucer, except perhaps the lack
		of a teacup. "; self.lldesc;
	}
	location = physics_office
	noun = 'saucer'

	verDoFly(actor) = {}
	doFly(actor) = {
		"The saucer flies off into the netherworld, headed for some other
		destination.  Being china, Beijing probably.";
		self.moveInto(nil);
		changescore(3);
	}
;

flagon: ouritem, liquidcontainer, breakable
	bdesc = "flagon"
	ldesc = {
		"This is one of Unkle Unnkul's best flagons. ";
		self.lldesc;
	}
	noun = 'flagon'
	location = table

	liquidcontents = wine
	contents = [ wine ]
;

wine: drink
	sdesc = "red wine"
	ldesc = "The wine is from Unkle Unnkul's cellar, and a quick sniff
		reveals it to be an excellent Chianti."
	noun = 'wine'
	adjective = 'red'

	drinkme(actor) = {
		"The wine is a bit presumptuous, and asks you for a fiver.\n";
	}
;

devnull: ouritem, absorber, liquidcontainer, throwable
	sdesc = "dev null"
	ldesc = "Nobody really understands /dev/null."
	location = in_computer
	noun = 'dev' 'null'
	adjective = 'dev' 'null'

	ioEmptyInto(actor, dobj) = {
		"You hear a ZAP!\n";
		dobj.findContainer(actor)[1].empty(true);
	}
;

class block: ouritem, surface, named
	sdesc = { "block "; say(self.name); }
	lldesc = { caps(); self.sdesc; " is on "; self.ison.thedesc; ". "; }
	lldescit = "It is on <<self.ison.thedesc>>. "
	location = bananaplace
	ison = theFloor
	adjective = 'block'

	isclear = { return(self.contents = []); }
	isunstable = {
		return((self.ison <> theFloor) and (self.size > self.ison.size or
			self.ison.isunstable));
	}

	verifyRemove(actor) = {
		if (actor <> robot)
			"The block is far too heavy for anyone but a robot to move.";
	}
	verDoMove(actor) = "The block is far too heavy for anyone but a robot to move.  "
	verDoMoveTo(actor,io) = self.verDoMove
	verDoMoveWith(actor,io) = self.verDoMove
	doPutOn(actor, io) = { self.putOn(actor, io, true); }
	putOn(actor, surf, loud) = {
		ison := surf;
		if (surf = theFloor) self.moveInto(actor.location);
		else self.moveInto(surf);
		if (loud) "\n\^<<actor.thedesc>> puts <<self.sdesc>> on <<surf.thedesc>>. ";
		if (self.isunstable) "It teeters precariously.";
	}
	verDoClimb(actor) = { blocks.verDoClimb(actor); }
;

blocks: ourdecoration
	sdesc = "blocks"
	adesc = { self.sdesc; }
	ldesc = {
		"The three blocks are pretty big.  None of them on its own is very
		high, but they look heavy.  Right now, \b";
		"\t<<blockR.lldesc>>\n";
		"\t<<blockS.lldesc>>\n";
		"\t<<blockT.lldesc>>\b";
	}
	noun = 'blocks'
	location = bananaplace

	height = {
		local count;
		count := 1;
		if (blockS.ison <> blockR.ison) count++;
		if (blockT.ison <> blockR.ison and blockT.ison <> blockS.ison) count++;
		return(count);
	}


	allblocks = [ blockR blockS blockT ]

	verifyRemove(actor) = {
		"The blocks are far too heavy for anyone but a robot to move.";
	}
	verDoClimb(actor) = {
		"Climbing the blocks would be quite dangerous.  You never know
		when ";
		if (robot.location = nil) "the robot might come back and start moving them. ";
		else "the robot might move them. ";
	}
;

blockR: block
	name = 'R'
	ldesc = {
		"Block R is the smallest of the blocks, but it is still
		pretty big.  Be glad you don't have to move it. ";
		self.lldescit;
	}
	noun = 'r'
	size = 1
;

blockS: block
	name = 'S'
	ldesc = {
		"Block S is the middle sized block. ";
		self.lldescit;
	}
	noun = 's'
	size = 2
;

blockT: block
	name = 'T'
	ldesc = {
		"Block T is the biggest of the blocks, and there is no way
		you could ever move it on your own. "; self.lldescit;
	}
	noun = 't'
	size = 3
;

banana: ourfooditem, throwable
	sdesc = "banana"
	ldesc = "It is an ordinary yellow banana."
	location = lemur
	noun = 'banana'
	adjective = 'yellow'

	newenergy = 4
;

fruitflies: ourdecoration
	sdesc = "small cloud of flies"
	ldesc = "The tiny black fruit flies are flying around contentedly."
	location = bananaplace
	noun = 'flies' 'fly'
	adjective = 'tiny' 'black' 'fruit' 'small' 'cloud' 'of'
	
	exist = true
;

berries: unlisted, ourfooditem, throwable
	sdesc = "bunch of lumenberries"
	ldesc = {
		"The small red lumenberries are ";
		if (not self.ispicked) "ripe for the picking";
		else "fresh-picked";
		" and look delicious. ";
		if (self.isblinking = true)
			"Their color is rapidly shifting from dull to bright red and
			back again. ";
	}
	noun = 'berries' 'berry' 'lumenberry' 'lumenberries' 'bunch'
	adjective = 'fresh' 'blinking' 'small' 'red' 'bunch'
	location = lumenberrypatch

	ispicked = nil
	isblinking = nil
	isGnuEdible = nil

	checkForRadiationAndBerries = {
		if (self.isVisible(uranium) and not self.isblinking) {
			self.isblinking := true;
			if (self.isVisible(Me))
				"\b\tThe lumenberries have started rapidly shifting
				color from dull to bright red and back again.
				How very strange! ";
			unnotify(self, &checkForRadiationAndBerries);
		}
	}

	verDoPick(actor) = {
		if (self.ispicked = true) "You've already picked the berries.";
	}
	verifyRemove(actor) = {
		if (self.ispicked = nil)
			"Perhaps you should pick the berries first.\n";
	}
	doPick(actor) = {
		"It takes a while, but %you% manage to pick most of the
		lumenberries from the bushes.";
		self.moveInto(actor);
		self.isListed := true;
		self.ispicked := true;
	}
;

deadbee: ourfooditem, throwable, joinable
	sdesc = "dead bee"
	ldesc = "The humble bee lies dead, wishing it had taken you with it."
	noun = 'bee'
	adjective = 'dead' 'humble'
	location = nil

	ioJoinTo(actor, dobj) = {
		if (dobj = pea) {
			"\bShazam!  Kapwing!  Tadaah!\b
			As the smoke clears, you see <<lead_sphere.adesc>>.\n";
			humblebee.deactivatenpc;
			dobj.moveInto(nil);
			self.moveInto(nil);
			lead_sphere.moveInto(actor.location);
			changescore(9);
		}
		else "They don't seem to join well.\n";
	}
;

lemondrop: ourfooditem, throwable
	sdesc = "lemon drop"
	ldesc = "The lemon drop looks good enough to eat."
	noun = 'drop' 'lemondrop'
	adjective = 'lemon'
	location = chomskys_desk

	verDoEat(actor) = {
		if (self.isVisible(humblebee)) humblebee.sting(actor);
	}
	isGnuEdible = nil
;

filingcabinet: ourdecoration, lockableDoorway
	sdesc = "filing cabinet"
	ldesc = {
		"The grey and red filing cabinet doesn't look particularly out
		of the ordinary. ";
		if (self.isopen) "It is open. "; else "It is closed. ";
	}
	noun = 'cabinet'
	adjective = 'red' 'grey' 'filing'
	location = deans_office
	mykey = missingKey
;

deanschair: ourchair
	sdesc = "plush chair"
	ldesc = "The dean's large leather chair looks like it was especially
		built to hold his rather, um, corpulent frame."
	noun = 'chair'
	adjective = 'large' 'plush' 'deans' 'dean\'s' 'office'
	location = deans_office

	verDoSiton(actor) = { "Dean Chiquita probably wouldn't take kindly
			to the idea of your sitting on his chair."; }
;

diploma: ouritem, readable, throwable
	sdesc = "diploma"
	ldesc = "The small diploma is printed on recycled papaya paper and embossed with
		silver lettering."
	readdesc = 
		"\nThe diploma reads:\b\b

		\t\t\t\ \ \ The Acme Institute for\n
		\t\t\ \ \ \ the Less-Convincing Sciences\b
		\t\t\t\t\t\ confers on\b
		\t\t\t\ \ Portnoy 'Pip' Prunejuice\b
		\t\t\t\t\ \ \ the degree of\b
		\t\t\ Bachelor of Bananalogical Science\b
		\t\t\t\t\tJune 7, 1873\b"

	noun = 'diploma' 'degree'
	adjective = 'small'
	location = nil
;

bananapeel: ouritem, throwable
	sdesc = "banana peel"
	ldesc = "The banana peel looks slippery."
	noun = 'peel'
	adjective = 'banana'
	location = nil

	verDoDrop(actor) = "%You% can't drop <<self.thedesc>>; someone might slip on it."
;

cherrytree: decorativetree
	sdesc = "cherry tree"
	ldesc = "The tall cherry tree rising in this clearing has various blocks by
		its base.  Its lowest branches look pretty high, so it'd be difficult
		to climb."
	adjective = 'cherry' 'tall'
	location = bananaplace
;

oaktrees: decorativetree
	sdesc = "oak trees"
	ldesc = {
		"The north courtyard's trees are well enough placed that they don't block
		out all the light descending on the courtyard: the buildings do that. ";
		if (raven.location = north_courtyard) {
			"Near the top of one of the trees you see a raven. ";
		}
	}
		
	noun = 'tree' 'trees' 'oaks'
	adjective = 'oak'
	location = north_courtyard
;

raven: ourdecoration, unreachable
	sdesc = "raven"
	ldesc = "The raven is perched high atop one of the oak trees, and seems to be
		carrying a small shiny object of some type.  You can't quite see what
		it is."
	noun = 'raven'
	location = north_courtyard

	startle = {
		self.moveInto(nil);
		nerdpridebutton.moveInto(north_courtyard);
	}
;	

shinyobject: ourdecoration, partitem, unreachable
	sdesc = "shiny object"
	ldesc = "You can't see the shiny object well enough to recognize it, though
		it is small and round."
	noun = 'object'
	adjective = 'small' 'round' 'shiny'

	partof = raven
;

nerdpridebutton: ouritem, clothingItem, throwable
	sdesc = "nerd pride button"
	ldesc = "This shiny new nerd pride button, adorned with lambdas, would be a
		 prized possession of any scientist or engineer."
	noun = 'button'
	adjective = 'shiny' 'nerd' 'pride' 'nerd-pride' 'nerdpride' 'new'
	location = nil

	doWear( actor ) = {
	        "Okay, %you're% now wearing "; self.thedesc; ". ";

		if (not self.isworn) changescore(6);
	        self.isworn := true;
	}
	doUnwear( actor ) = {
		"Okay, %you're% no longer wearing "; self.thedesc; ". ";
		if (self.isworn) changescore(-6);
		self.isworn := nil;
	}
	checkDrop = {
		if (self.isworn) changescore(-6);
		pass checkDrop;
	}
	moveInto( obj ) = {
		if (self.isworn) changescore(-6);
		self.isworn := nil;
		pass moveInto;
	}
;

mobiusbow: partitem
	sdesc = "Mobius bow"
	ldesc = "The red bow is a topological oddity: it has been twisted
		and folded over onto itself.  It is, in fact, a Mobius bow."
	partof = horse
	noun = 'bow'
	adjective = 'pretty' 'red' 'mobius' 'infinite'

	verIoShootWith(actor) = {}
	ioShootWith(actor,dobj) = {
	   if (dobj <> arrow) "<<dobj.thedesc>> doesn't fit in the mobius bow
		particularly well.  Perhaps something designed to be shot would
		do better.";
	   else {
		switch(actor.location) {
		case loft:  {
		   "The arrow goes sailing out the loft window,
		   across the garden maze, and comes to rest somewhere amidst the
		   buildings of the 'Tute, you know not where.  The cloud of time
		   flies flutters rapidly off in its wake.";
		   timeflies.followingarrow := true;
		   timeflies.moveInto(wind_tunnel_path);
		   arrow.moveInto(wind_tunnel_path);
		   break;  }
		case louisoffice: {
		   if (louis_window.isopen) {
		      "The arrow speeds out the window and towards the surface of the pond,
		      impaling and probably killing a big red fish that just happened 
                      to leap out of the water.";
		      arrow.moveInto(nil);
		   }
		   else "Perhaps you ought to open the window before shooting the arrow.";
		   break;  }
		case alyssaoffice: {
		   if (alyssa_window.isopen) {
		      "The arrow defenestrates into the dense foliage of
			the oak trees, disappearing from your view.  ";
		      arrow.moveInto(nil);
		   }
		   break;
		}
		default: {
		   "The arrow flies for a short distance and then drops back to earth.";
		   arrow.moveInto(actor.location);
		   }
		}
	      }
	 }
;

horses_tag: partitem, readable
	sdesc = "tag"
	ldesc = "The tag reads \"To Alice, from the White Queen.  Happy Birthday!\""
	partof = horse
	noun = 'tag'
	adjective = 'small'
;

noclue: ouritem
	sdesc = "no clue"
	adesc = { self.sdesc; }
	thedesc = { self.sdesc; }
	ldesc = {
		if (self.location=Me)
			"You are clueless.";
		else
			"Wouldn't you like to have a clue?";
	}
	noun = 'specialnoclue' /* Can't directly reference clue. */
	location = Me
	bulk = 0
;

clue: ouritem
	sdesc = "clue"
	ldesc = "You shouldn't be able to read this!!!"
	noun = 'clue'
	adjective = 'no'
	location = nil
;


ladder: ouritem
	sdesc = { if (self.isbroken) "broken ladder"; else "shiny new Acme ladder"; }
	ldesc = {
		if (self.isbroken)
			"The Acme ladder, once a shining testament to the virtues of
			capitalism, is now exhibiting the fundamental characteristic of
			all Acme products: a stable and attractive failure mode.
			Almost every rung is broken, and it would be hopeless to attempt
			to use the ladder. ";
		else
			"The Acme ladder is a highly polished aluminum testament to
			the legendary quality of the Acme product line. ";
		if (self.israised) self.location.laddermessage;
	}
	noun = 'ladder'
	adjective = 'shiny' 'new' 'broken' 'acme' 'polished' 'aluminum' 'highly'
	location = barn
	isbroken = nil
	israised = true
	isListed = { return(not self.israised); }
	verDoRaise(actor) = {
		if (self.israised) "The ladder is already raised.";
		else if (actor.location = diningroom)
			"As you try to raise the ladder, one of the
			philosophers, his knife tucked securely under one arm,
			reminds you that they are in the middle of a meal and
			that construction work would be best saved for later.";
		else if (not defined(actor.location,&ladderdest))
			"I don't see where to raise the ladder here.";
	}
	doRaise(actor) = {
		self.moveInto(actor.location);
		self.israised := true;
		"OK. ";
		self.location.laddermessage;
	}
	verDoClimb(actor) = {
		if (not self.israised)
			"You can't climb the ladder until you raise it.";
	}
	doClimb(actor) = {
		if (self.isbroken)
			"You start climbing the ladder, and make it up almost half
			a step before falling through the broken rungs back to the
			ground.";
		else {
			"Not fully realizing the dangers involved in using Acme products
			as life-supporting devices, you begin ascending the ladder.
			Almost as soon as you set foot on the first rung it breaks,
			and you end up scurrying up the ladder as fast as you can just
			to keep ahead of the cracks.  You do indeed make it up, but
			the newly decrepit ladder collapses back to the ground with a bang.";
			self.israised := nil;
			self.isbroken := true;
			"\b";
			actor.travelTo(self.location.ladderdest);
			return(nil);
		}
	}
	moveInto(location) = {
		self.israised := nil;
		pass moveInto;
	}
;

rung: ourdecoration, partitem
	sdesc = "rung"
	ldesc = {
		if (ladder.isbroken)
			"Hard as it may be to believe that an aluminum ladder's
			rungs have cracked, Acme is never one to skimp when it
			comes to destruction.";
		else
			"The ladder's rungs are totally rad.";
	}
	noun = 'rung' 'rungs'
	adjective = 'ladder' 'ladder\'s' 'ladders' 'shiny' 'broken' 'new'
	partof = ladder
;

haystack: searchHider, fixeditem, ouritem
	sdesc = "haystack"
	ldesc = "The hay is piled 3 or 4 feet high in a mound in the middle
		of the floor."
	noun = 'haystack' 'stack' 'hay'
	adjective = 'hay'
	location = loft

	verDoTake( actor ) = {
	        "The haystack is too big to take.  You can barely push it. ";
	}
	verDoMove( actor ) = {
		"You'll have to be more specific about how you want to move the hay.";
	}
	verDoPop(actor) = {
		"The top of the stack starts twitching and even levitates
		a couple of inches into the air.  Unfortunately, this 
		is reality, not a computer model, so the hay soon falls
		down again.\n" ;
	}
	verDoPush(actor) = {
		if (self.location <> loft)
		        "Pushing <<self.thedesc>> doesn't do anything. ";
	}
	doPush(actor) = {
		"The hay is heavy, but you manage to push the pile towards the
		edge of the loft, and it sluggishly falls with a thud onto the
		barn floor below.\n";
		self.isListed := true;
		self.moveInto(barn);

		/* Bottle breaks if hay is pushed off. */
		if (self.searchCont <> nil and find(self.searchCont, zenobottle) <> nil) {
			self.searchCont -= zenobottle;
			self.searchCont += brokenglass;
		}
	}
	serialSearch = true
    	doSearch(actor) = {
		if (self.searchCont = nil)
		    "There's nothing else in <<self.thedesc>>, not even a needle. ";
		else
		    self.searchCont := self.searchObj(actor, self.searchCont);
	}
	isVisible(vantage) = {
		if (vantage = loft and self.location = barn) return(true);
		else pass isVisible;
	}
	verDoJumpInto(actor) = {}
	doJumpInto(actor) = {
		if (self.location=actor.location)
			"\nYou take a good running start, jump high, and land laughing
			in the haystack.  What fun!  Sheer joy!  Standing up and brushing
			the hay out of your grimy hair, you wonder why you didn't do that
			more often as a kid.\n";
		else if (self.location=barn) {
			if (arrow.location = Me) {
				"\nGlancing dubiously at the haystack far below you,
				you close your eyes and step gingerly off of the loft,
				falling quickly into the hay below.  Unfortunately,
				jumping while holding sharp objects is not a good idea,
				and you land on the arrow, impaling yourself and causing
				your early demise.";
				die();
			}
			else {				
  			  "\nGlancing dubiously at the haystack far below you, you close
			  your eyes and step gingerly off of the loft, falling quickly
			  into the hay below.  Although you bruise yourself lightly, the
			  hay cushions your landing and you stand up little worse for the
			  wear.\b";
			
			  changescore(3);
			  actor.travelTo(self.location);
			}
		}
	}
	cantReach(actor) = "You can't reach <<self.thedesc>>."
;

egg: ourfooditem, breakable
	sdesc = "egg"
	adesc = "an egg"
	ldesc = "The egg is an off white, and doesn't appear too different than
		other eggs you've encountered during your life, with perhaps the
		exception of one very unusual egg you read about once."
	noun = 'egg'
	adjective = 'off' 'white' 'off-white'
	location = nil

	verDoEat(actor) = {
		"Eat a raw egg?  Surely you jest.";
	}
;

fried_egg: ourfooditem
	sdesc = "fried egg"
	ldesc = "The fried egg is yellow in the middle, white on the edges, and would
		go wonderfully with some ham."
	noun = 'egg'
	adjective = 'fried'
	location = nil

	doEat(actor) = {
		"You eat the fried egg, apparently unaware of the dangers
		of eating things cooked with aluminum.  Still, it does taste
		good.";
		self.moveInto(nil);
	}
;

well: liquidcontainer, container, ourdecoration
	sdesc = "well"
	ldesc = {
		"The well in the middle of the garden is surrounded by a circle
		of mossy rocks about waist high.  It isn't obvious how the gardeners
		draw water from the well, as there are no buckets to be seen";
		if (self.water_level<7)	" and the water's surface is well out of reach";
		". ";
		if (self.water_level<3)
			"You can see something floating in the water. ";
		else if ( itemcnt( self.contents ) <> 0 ) {
	            "Floating on the water %you% see%s% "; listcont( self ); ". ";
		}
        }
	noun = 'well'
	adjective = 'stone' 'garden'

	location = garden_entrance
	water_level = 0
	see_level = 3
	take_level = 6
	liquidcontents = water
	contents = []

	// contentsVisible = { return( self.water_level >= see_level ); }
	verGrab(obj) = {
		if (self.water_level <> take_level )
			"You can't reach <<obj.thedesc>>- the water level is too low.\n";
	}

	verDoClimb(actor) = "The well's walls are far too slippery to climb."
	verDoThru(actor) = { self.verDoClimb(actor); }

	/* This is dependent on see_level = 3 and take_level = 6 */
	doLookin(actor) = {
		switch(self.water_level) {
		case 0: 
		case 1:
		case 2: {
			"You can see something floating in the water, but it's
			too far below and just a bit too hidden in the shadows
			for you to make out what it is. ";
			"There is also a dried-up bulb of some sort growing
			on the side of the well, below your reach.";
			break;
		}
		case 3:
		case 4: 
		case 5: {
			"Floating on the water below, you see "; listcont(self); ". ";
			break;
		}
		default: {
			 "The well is full of water. ";
			if (self.contents <> []) {
	            		"Floating on the surface of the water 
				%you% see%s% "; listcont( self ); ". ";
			}
		}
		}
	}

	ioPutIn( actor, dobj ) = {
		if (dobj = faircoin)
			"\nYou make a wish, a wish for fish, but you lack
			the dish of Ish to swish. <<note(self)>>\n";
		else
			"\nYou drop <<dobj.thedesc>> into the well, and it quickly sinks
			out of sight.\n";
		dobj.moveInto(nil);
	}
	footnote = "Perhaps you've read \"One Fish, Two Fish, Red Fish, Blue Fish\"?"

	verIoDrinkFrom(actor) = {
		"The well's water is out of your reach.\n";
	}
	verDoDrink(actor) = self.verIoDrinkFrom(actor)
	verDoEmpty(actor) = {
		"The well's water is still out of your reach.\n";
	}
	verIoEmptyFrom(actor) = self.verDoEmpty(actor)
	verDoEmptyInto(actor, iobj) = self.verIoEmptyFrom(actor)
	verDoFillWith(actor, iobj) = { self.verIoEmptyInto(actor); }
	verIoEmptyInto(actor) = {}
	ioEmptyInto(actor, dobj) = {
		local origcontainer, liquid;
		origcontainer := dobj.findContainer(actor)[1];
		liquid := origcontainer.liquidcontents;

		if (self.water_level=take_level) {
			"Pouring <<liquid.thedesc>> into the well causes an
			overflow drainage path to open up, and the excess
			liquid flows into the ground. ";
		}
		else if (self.water_level<(see_level-1)) {
			"Ah, that seems to have raised the water level a few inches.  
			It'll take a few more pours to bring the water 
			within reach, though. ";
			self.water_level++;
		}
		else if (self.water_level=(see_level-1)) {
			nonlinear_lanner.moveInto(self);
			"Now the water's almost high enough for you to reach, and you can
			see "; listcont( self ); " floating in it. ";
			self.water_level++;
		}
		else if (self.water_level<(take_level-1)) {
			"Just a bit more; you can almost reach the thing in the water. ";
			self.water_level++;
		}
		else {
			"\^The item floating on the water's surface is now within reach, though
			the water still seems to remain furtively below your fingertips. ";
			self.water_level++;
			notify(lotus, &grow, 10);
		}
		origcontainer.empty(nil);
	}
;

lotus: ourdecoration
	sdesc = "bulb"
	ldesc = "The bulb is desiccated into a shriveled lump, 
		and it's hard to believe that it could still be alive."
	noun = 'bulb' 
	location = garden_entrance

	grow = {
		lotus_flower.moveInto(well);
	}
	verDoTake(actor) = "The bulb is growing too deep in the well for you to reach."
;	

lotus_flower: ouritem
	sdesc = "lotus flower"
	ldesc = "The lotus flower is singularly beautiful."
	noun = 'flower'
	adjective = 'lotus'
	location = nil
	
	verDoSmell(actor) = {}
	doSmell(actor) = "A heavenly perfume emanates from the lotus flower."
;
		

acme_decrypter: ouritem, breakable, hiddenItem, container
	sdesc = "Acme decrypter"
	adesc = "an Acme decrypter"
	ldesc = {
		"The Relatively Successful Acme decrypter claims to be able to
		decipher any coded message, no matter how it is encrypted,
		in constant time.  And cheap enough for even the
		smallest government!  The decrypter has a small slot for
		messages and a display. ";
		if (self.contents <> [])
			acme_decrypter_slot.ldesc;
	}
	noun = 'decrypter'
	adjective = 'acme' 'relatively' 'secure'

	searchLoc = halles_desk

	verIoPutIn(actor) = {
		if (not (self.contents = []))
			"The decrypter slot has already got <<self.contents[1].adesc>> in it.";
	}
	ioPutIn( actor, dobj ) = {
		if (not isclass(dobj, encryptedmessage))
			"\^<<dobj.thedesc>> does not fit in <<self.thedesc>>.";
		else {
			dobj.moveInto(self);
			acme_decrypter_display.ldesc;
		}
	}
;

acme_decrypter_display: partitem, ourdecoration, readable
	sdesc = "decrypter display"
	ldesc = {
		if (partof.contents = []) "\^<<self.thedesc>> is blank.";
		else "\^<<self.thedesc>> reads \"<<partof.contents[1].acme>>\".\n";
	}
	noun = 'display' 'screen'
	adjective = 'decrypter' 'acme' 'decrypter\'s'
	partof = acme_decrypter
;

acme_decrypter_slot: container, partitem, ourdecoration
	sdesc = "decrypter slot"
	ldesc = {
		if (self.partof.contents = [])
			"The slot is empty.";
		else showcontcont(self.partof);
	}
	noun = 'slot'
	adjective = 'decrypter'
	partof = acme_decrypter

	verIoPutIn(actor) = { partof.verIoPutIn(actor); }
	ioPutIn(actor, dobj) = { partof.ioPutIn(actor, dobj); }
;

alyssa_desk: desk, named
	sdesc = "Alyssa's desk"
	ldesc = "Alyssa, being the department chair, commands a desk with a slot in it.
		There is also a small flat-panel display embedded in the desk and a
		dial next to it [with numbers from 1 to 42, skipping 9 through 16 and all the
		primes and 22, and, of course, 30.  Oh, all the primes but 41.]."
	noun = 'desk'
	adjective = 'alyssa' 'alyssa\'s' 'alyssas'
	location = alyssaoffice
;

/* Clues for the 4-number combination of the desk are found in several locations.
 * Carl will give you the first when you give him the bottle, and the last when
 * you've colored the maze.  The 2nd pops into your head, and the 3rd is told to
 * you by the philosophers once you've given them the fork, if you wait long
 * enough.
 */

desk_dial: dialItem, ourdecoration
	sdesc = "dial"
	ldesc = "The dial can be turned to any number between 1 and 42, except 9 through
		16 and all the primes, and, of course, 30.  Oh, all the primes but 41.
		41 is fine, though 22 isn't.  It is currently set to <<say(self.setting)>>."
	adjective = 'desk'
	noun = 'dial'
	location = alyssaoffice

	solved = nil
	count = 1
	setting = 545
	combination = [ 6 28 41 24 ]
	points = nil

	doTurnTo(actor, iobj) = {
		local v;
		v := iobj.value;
		if (v < 1 or v > 42 or (v >= 9 and v <= 16) or v = 30 or v = 22 or
			find([2,3,5,7,11,13,17,19,23,29,31,37],v) <> nil) {
			"\nCan't follow directions, can you?  Well, you'll have
			to pay for your insolence.\n";
			changescore(-1);
		}
		else {
	                self.setting := v;
	                "Okay, it's now turned to "; say( self.setting ); ". ";

			if (v = combination[1]) count := 2;
			else if (v = combination[count]) count++;
			else count := 1;

			if (count > length(combination)) {
				count := 1;
				solved := true;
				if (points = nil) {
					points := true;
					changescore(4);
				}
			}
			else solved := nil;

			desk_display.ldesc;
		}
	}
	have_vision = {
		if (global.turnsofar = 102)
			"\bThe number <<say(combination[2] - 1)>> appears before you in
			a vision.\b";
		else if (global.turnsofar = 135)
			"\bThe number <<say(combination[2] - 1)>> again appears before you in
			a vision, but is wiped out by a giant cosmic eraser, and replaced with
			a calligraphic <<say(combination[2]+1)>>.\b"; 
		else if (global.turnsofar = 165)
			"\bThe number <<say(combination[2]-2)>> makes a brief appearance
			in your frontal lobes
			before changing into a flock of canaries and vanishing into the
			recesses of your psyche.\b"; 
		else if (global.turnsofar = 190)
			"\bThe number <<say(combination[2])>> jumps out of the shadows
			of your ego, grabs your thoughts, and ties them up for a bit.
			It unties them later but refuses to go away.";
		else if (global.turnsofar = 193) {
			"\bThe number <<say(combination[2])>> doesn't seem ready to
			be gc'ed yet, and continues to dominate your thoughts.
			Indeed, this number must have some grand
			secondary purpose, in addition to being the product of four
			and seven.";
			unnotify(self,&have_vision);
		}
	}
;

desk_slot: container, ourdecoration
	sdesc = "desk slot"
	ldesc = {
		if (desk_slot.contents = []) "\^<<self.thedesc>> is blank.";
		else "\^<<self.thedesc>> reads \"<<desk_slot.contents[1].acme>>\".\n";
	}
	noun = 'slot'
	adjective = 'desk'
	location = alyssaoffice

	verIoPutIn(actor) = {
		if (not (self.contents = []))
			"The slot has already got <<self.contents[1].adesc>> in it.";
	}
	ioPutIn( actor, dobj ) = {
		if (not isclass(dobj, encryptedmessage))
			"\^<<dobj.thedesc>> does not fit in <<self.thedesc>>.";
		else {
			dobj.moveInto(self);
			desk_display.ldesc;
		}
	}
;

desk_display: partitem, ourdecoration, readable
	sdesc = "desk display"
	ldesc = {
		if (desk_dial.solved) {
			if (desk_slot.contents = []) "The desk display is blank.";
			else "The desk's display reads \"<<desk_slot.contents[1].decrypted>>\"\n";
		}
		else "The display is a most foul and unpleasant hue.";
	}
	noun = 'display'
	adjective = 'desk' 'desk\'s' 'desks' 'flat' 'panel' 'flat-panel'
	partof = alyssa_desk
;

class encryptedmessage: ouritem, readable, hiddenItem
	sdesc = "message"
	ldesc = "\^<<self.thedesc>> reads \"<<self.encrypted>>\""
	noun = 'message'
	plural = 'messages'
;

encryptedmessage1: encryptedmessage
	sdesc = "clipped message"
	adjective = 'clipped'
	searchLoc = halles_desk

	encrypted = "Zip znotdp znhitkp zyhtellp zveerp zabkerp zourp zocdep zmoisrrp-
		 zistp zawyp zootp zoodgp."
	decrypted = "Meet me out by the pond at 4:00- Noam."
	acme = "Hoo hoo. What za whiffle goodly companink is this bork bork bork
		acme company. Zee makink the ping acme jurgen dekriptinger."
;

encryptedmessage2: encryptedmessage
	sdesc = "obtuse message"
	adesc = "an obtuse message"
	adjective = 'obtuse'
	searchLoc = chomskys_desk

	encrypted = "Zip zaeegrp. Znistp znoocyhteglp znowudefrlp zhtep zawyp zwep znacp
			zekepp znoysp zmabisselllp zaawyp zmofrp zuorp zaimlp?"
	decrypted = "Should I bring the refractifier? We'll never catch anything without one."
	acme = "Here, chikky chikky chikky.  Go in da nice Acme pot like a good
		chikky.  Dats a good chikky; dis an Acme chikky for da pot."
;

encryptedmessage3: encryptedmessage
	sdesc = "strange message"
	adjective = 'strange'
	searchLoc = alyssa_desk

	encrypted = "Zawstp zbiigrllp, znadp zhtep zyhistlp zostvep ziddp zyegrp znadp zmbieglp
			 znip zhtep zabwep."
	decrypted = "Alyssa, do you think we could go out for a picnic round 3:45?
			I'll meet you by the grey door- Ben."
	acme = "O, Acme stuff dats good for me, Acme produks cancha see,
		I'm an Acme spokes-per-swede, dats cause dey pey meeee."
;

encryptedmessage4: encryptedmessage
	sdesc = "weird message"
	adjective = 'weird'
	searchLoc = louis_desk

	encrypted =
		"Zip znotdp znawtp zotp zatklp zotp zoyup znop zmoerp, zoyup
		zmytepp zahddeep zmnaailp zoodfp zohtugrp ziwerpp! Zip zatfrp
		znip zoyurp znaeegrlp znociitderp! Zoyurp zmohterp zawsp zap zmahsterp
		znadp zoyurp zahtefrp zmssellp zofp zbisdeeeerrrlp!"
	decrypted = {
		"You wouldn't believe how fun physics can be!  There are all
		sorts of opportunities for people with my background, Louis. 
		I'm so glad I switched. Destructive operations everywhere! 
		You've got to check it out sometime. I've got a great lab set up. Cy ";
		note(encryptedmessage4); ".";
	}
	acme = "Mmmmmm, dats da veritable shmorgasbork of good Acme produks.  We
		gocher pots, we gocher spat-u-laaaa, dis a good seto produks."

	footnote = { "Get an extra 5 points by typing in Cy's full middle name."; }
;

pedestal1: ourdecoration, surface
	sdesc = "pedestal"
	ldesc = {
		"The shoulder-height wood pedestal seems a bit incongruent at the
		Acme Institute.  It would be much more appropriate in a museumish
		has-been school like the one not far upriver from the 'tute. ";
		showcontcont(self);
	}
	
	noun = 'pedestal'
	adjective = 'wood' 'shoulder' 'height' 'shoulder-height'
	location = westhall

	verIoPutOn(actor) = {
		if (self.contents <> [])
			"Two things on a single pedestal.  That wouldn't look
			good at all now, would it?";
		else pass verIoPutOn;
	}
;

pedestal2: ourdecoration, surface
	sdesc = "pedestal"
	ldesc = {
		"This rad, anodyzed-purple aluminum pedestal is the hottest
		looking platform you've ever seen. Must be a new acquisition
		that Aussie assistant-director found somewhere, you think.
		Wicked! ";
		showcontcont(self);
	}

	noun = 'pedestal' 'platform'
	adjective = 'rad' 'anodyzed' 'purple' 'anodyzed-purple' 'aluminum'
	location = easthall

	verIoPutOn(actor) = {
		if (self.contents <> [])
			"Two things on a single pedestal.  That wouldn't look
			good at all now, would it?";
		else pass verIoPutOn;
	}
	ioPutOn(actor, dobj) = {
		if (dobj = egg) {
			"The hard surface cracks the egg open, and the egg sizzles
			loudly on the hot pedestal, quickly frying itself.";
			egg.moveInto(nil);
			fried_egg.moveInto(pedestal2);
			changescore(1);
		}
		else pass ioPutOn;
	}
;

crystal_skull: ouritem, breakable
	sdesc = "crystal skull"
	ldesc = "The crystal skull looks exceedingly delicate and twinkles
		exquisitely in the light."
	noun = 'skull'
	adjective = 'crystal'
	location = pedestal1

	verIoEmptyInto(actor) = {}
	ioEmptyInto(actor, dobj) = {
		local origcontainer;
		origcontainer := dobj.findContainer(actor)[1];

		"You pour <<origcontainer.liquidcontents.thedesc>> into the skull,
		but it runs out the eye sockets onto the ground, and is quickly
		absorbed.";
		origcontainer.empty(nil);
	}
;

wicker_cage: ouritem, container, breakable
	sdesc = "wicker cage"
	ldesc = "The small wicker bird cage could well be a valuable historical artifact."
	noun = 'cage' 'birdcage'
	adjective = 'wicker' 'bird'
	location = pedestal2

	verIoPutIn(actor) = "The cage has no opening."
;

canary: ouritem
	sdesc = "small yellow bird"
	ldesc = "The little bird looks unhappy in the cage."
	noun = 'bird' 'canary'
	adjective = 'small' 'yellow' 'little' 'unhappy'
	location = wicker_cage

	verDoFeed(actor) = {}
	doFeed(actor) = {
		"It's not hungry. (It's merely pinin' for the fjords). 
		 Besides, you have no bird seed.";
	}
	verIoGiveTo(actor) = {
		"I suspect it would prefer bird seed.";
	}
	verifyRemove(actor) = "The cage has no opening through which to remove the bird."
	verDoAttack(actor) = "Oh, leave the poor unhappy bird alone."
	verDoRub(actor) = {}
	doRub(actor) = { "The bird chirps merrily while you pet it."; }
;

glasses: ouritem, clothingItem, breakable
	sdesc = "glasses"
	adesc = { self.sdesc; }
	ldesc = {
		"Your glasses are heavy and black rimmed, and have been repaired
		with duct tape more times than you'd care to mention. ";
		if (isworn) "You are currently wearing them.";
	}
	noun = 'glasses' 'eyeglasses'
	adjective = 'eye' 'black' 'rimmed' 'heavy'

	location = Me
	isworn = true

	isListed = { return(not self.isworn); }
;

ducttape: ourdecoration, partitem
	sdesc = "duct tape"
	ldesc = "Duct tape is one of nature's most sought-after materials. Your father,
		before he was fired, used to work in one of the Unnkulian duct tape mines."
	noun = 'tape' 'ducttape' 'duct-tape'
	adjective = 'duct' 'duck'
	partof = glasses

	verifyRemove(actor) = "The duct tape is firmly stuck to the glasses."
	verDoTake(actor) = { self.verifyRemove(actor); }
;

stand: ourdecoration
	sdesc = "wood stand"
	ldesc = "The wood stand holds a large silver funnel upright, with enough
		clearance for objects passing through the funnel to roll out
		onto the floor.  Around the edge of the stand someone has carefully
		engraved the four words \"Earth, Fire, Water and Air\"."
	noun = 'stand'
	adjective = 'wood' 'funnel'
	location = physics

	verDoTake(actor) = { self.verifyRemove(actor); }
	verifyRemove(actor) = "The heavy funnel prevents you from moving the stand."
;

funnel: ourdecoration
	sdesc = "silver funnel"
	ldesc = "The silver funnel's rim is about 3 feet in diameter, and maybe
		4 feet off the floor.  The outside of the palladium throat is surrounded by
		yttrium bands.  Looking down through the throat you see not the floor,
		but its reflected image.  A small plaque has been tacked to the outside
		of the funnel, which is resting on a wood stand."
	noun = 'funnel'
	adjective = 'silver'
	location = physics

	verDoTake(actor) = { self.verifyRemove(actor); }
	verifyRemove(actor) = "The funnel is far too heavy for you to lift."

	verIoPutIn(actor) = {}
	ioPutIn(actor, dobj) = {
		if (dobj = lead_sphere) {
			"The sphere rolls around the funnel several times before
			dropping through the throat.  In a flash of light, the
			sphere is transformed!\n";
			dobj.moveInto(nil);
			pyrite_sphere.moveInto(funnel.location);
			changescore(3);
		}
		else {
			"\^<<dobj.thedesc>> slides down the funnel into the throat,
			at which point it seems to be grabbed by an invisible force
			field.  It oscillates up and down ever more rapidly until
			it is flung out the top of the funnel and across the room.\n";
			dobj.moveInto(funnel.location);
		}
	}
	verIoThrowThrough(actor) = { self.verIoPutIn(actor); }
	ioThrowThrough(actor, dobj) = { self.ioPutIn(actor, dobj); }
;

funnel_rim: ourdecoration, readable, partitem
	sdesc = "funnel rim"
	ldesc = "Written on the funnel rim is the enscription \"To the Acme Institute,
		for all you've taught us- Pons and Fleischman, Senior Acme Scientists.\""
	noun = 'rim'
	adjective = 'funnel' 'silver'
	partof = funnel
;

funnel_throat: ourdecoration, partitem
	sdesc = "palladium throat"
	ldesc = "The throat is about 5 inches in diameter and surrounded by yttrium
		bands."
	noun = 'throat'
	adjective = 'funnel' 'palladium'
	partof = funnel

	verIoPutIn(actor) = { partof.verIoPutIn(actor); }
	ioPutIn(actor, dobj) = { partof.ioPutIn(actor, dobj); }
	verIoThrowThrough(actor) = { self.verIoPutIn(actor); }
	ioThrowThrough(actor, dobj) = { self.ioPutIn(actor, dobj); }
;
	
funnel_rods: ourdecoration, partitem
	sdesc = "yttrium bands"
	ldesc = "The yttrium bands surround the throat as a sort of constricting neckband,
		and are exceedingly cold to the touch."
	noun = 'bands'
	adjective = 'funnel' 'throat' 'yttrium'
	partof = funnel
;

funnel_plaque: ourdecoration, partitem, readable
	sdesc = "small plaque"
	ldesc = "The small plaque reads \"The Transmuter Machine: Lead to Gold,
		Cold Fusion's Legacy.\""
	noun = 'plaque'
	adjective = 'funnel' 'small'
	partof = funnel
;

lead_sphere: ouritem, throwable
	sdesc = "lead sphere"
	ldesc = "The lead sphere is quite heavy, a dull grey, and is slowly
		destroying your lifestyle."
	noun = 'sphere'
	adjective = 'lead'
	location = nil

	weight = 25
;

pyrite_sphere: ouritem, throwable
	sdesc = "pyrite sphere"
	ldesc = "The pyrite sphere looks surprisingly like it was made of gold."
	noun = 'sphere'
	adjective = 'pyrite'
	location = nil
;

apple: ouritem, ourfooditem, throwable
	sdesc = "apple"
	adesc = "an apple"
	ldesc = "The polychromatic apple looks like someone has already
		taken a bite out of it.  Perhaps it is a leftover from some
		students' picnic.  "
	noun = 'apple'
	adjective = 'polychromatic'
	location = clearing
	newenergy = 3
	isGnuEdible = nil
;

/* If you want the ceiling of a room to look different, define its ceilingdesc. */
theCeiling: floatingItem, ourdecoration
    sdesc = "ceiling"
    adesc = "the ceiling"
    ldesc = {
        if (defined(Me.location,&ceilingdesc)) Me.location.ceilingdesc;
	else "The ceiling is unremarkable.\n";
    } 

    noun = 'ceiling'
    location = {
	if (isclass(Me.location, insideroom)) {
		return(Me.location);
	}
	else return(nil); 
    }

    locationOK = true        // suppress warning about location being a method
;

/* If you want the wall of a room to look different, define its walldesc. */
theWall: floatingItem, ourdecoration
    sdesc = "walls"
    adesc = "the walls"
    ldesc = {
        if (defined(Me.location,&walldesc)) Me.location.walldesc;
	else "The walls here are perfectly ordinary.\n";
    } 

    noun = 'walls' 'wall'

    location = {
	if (isclass(Me.location, insideroom)) {
		return(Me.location);
	}
	else return(nil); 
    }

    locationOK = true        // suppress warning about location being a method
    verDoKnock(actor) = "Nothing happens.  \n"
;

/* Another totally useless, inane object. */

faircoin: ouritem, throwable
	sdesc = "fair coin"
	ldesc = {
		"The coin is showing ";
		if (self.heads = true) "heads.";
		else "tails.";
	}
	noun = 'coin'
	adjective = 'fair'

	prevfibnum = 0
	fibnum = 1
	fibc = 1
	heads = true

	verDoFlip(actor) = {}
	doFlip(actor) = {
		fibc--;
		if (fibc = 0) {
			fibc := prevfibnum + fibnum;
			prevfibnum := fibnum;
			fibnum := fibc;
			heads := (not heads);
		}
		if (heads = true) "\nThe coin comes up heads.\n";
		else "\nThe coin comes up tails.\n";
	        actor.location.roomDrop(self);
	}
    	doThrow(actor) = { self.doFlip(actor); }

	location = wrongfib2
;

golfclub: ouritem, throwable
	sdesc = "putter"
	ldesc = "The putter doesn't look unusual.  For instance, it doesn't have
		chrome fenders and isn't wearing an itsy-bitsy, teeny-weenie, yellow
		polka-dot bikini. <<note(self)>>"
	noun = 'putter' 'club'
	adjective = 'golf'
	location = deans_office

	/* Putter is used to hit golf ball in hallway. */
	verIoPuttWith(actor) = {}
	verIoAttackWith(actor) = {}
	verDoSwingAt(actor,iobj) = {
		if (iobj <> golfball) "Be careful, you might hurt <<iobj.thedesc>>.";
	}

	ioPuttWith(actor,dobj) = {
		if (dobj <> golfball) "You can't putt <<dobj.thedesc>>.";
		"\nYou putt <<dobj.thedesc>> into the other end of the hallway,
		scoring a hole-in-one for your Olympic team.  Congratulations!";
		if (dobj.location = westhall) dobj.moveInto(easthall);
		else dobj.moveInto(westhall);
		if (self.scored <> true) {
			self.scored := true;
			changescore(3);		
		}
	}
	ioAttackWith(actor,dobj) = {
		if (dobj <> golfball)
			"A golf club is far too dangerous an object to swing wildly.";
		else self.ioPuttWith(actor,dobj);
	}
	footnote = "Of course, before you can use the club you'll have to dig up a
			golf ball somewhere."
;