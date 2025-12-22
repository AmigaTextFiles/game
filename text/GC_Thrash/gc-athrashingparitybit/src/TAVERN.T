/*
 * The Cheez Boar Inn: what a place it is.
 */

tavern: insideroom
	sdesc = "Cheez Boar Inn"
	ldesc = "The Cheez Boar Inn is the social center of the Acme Institute,
		and no wonder: it looks like almost everyone who's anyone is here,
		sitting at the many tables arrayed throughout this comfortable and
		cosy room.  Presiding over the hubbub is Carl, the Cheez Boar Inn's
		owner and bartender, who keeps from behind the large mahogany bar
		stretching down the north side of the room.\b

		To the south lies the Boar's kitchen, providing food for the throngs,
		and a private dining room can be reached through the portal in the
		west wall."

	east = path_intersection
	out = path_intersection
	west = diningroom
	south = kitchen

	tables = [
		goudatable stiltontable brietable 
		gruyeretable swisstable limburgertable ]

	maxnumbertomove = 2

	fireDrill = {

		/* Every turn pick some people to switch tables according
		 * to the connected graph rules, always trying to keep
		 * the numbers of people balanced.
		 */

		local i, source, dest, tmp, sd, dd, person, numbertomove;

		numbertomove := rand(self.maxnumbertomove + 1) - 1;
		for (i := 1; i <= numbertomove; i++) {
			source := randomelement(self.tables);
			dest := randomelement(source.connectedto);

			sd := source.denizenList;
			dd := dest.denizenList;
			if (length(dd) > length(sd)) {
				/* Swap to keep flow towards equality. */
				tmp := source; source := dest; dest := tmp;
				tmp := sd; sd := dd; dd := tmp;
			}
			if (sd <> []) {
				person := randomelement(sd);
				if (person.canmove = true) {
					person.moveInto(dest);
					person.deactivatenpc;
					if (Me.location = dest.mychair) person.activatenpc;
	
					"\n\^<<person.thedesc>> gets up from <<source.thedesc>> and
					moves to <<dest.thedesc>>.";
				}
			}
		}
	}

	enterRoom(actor) = { carl.activatenpc; pass enterRoom; }
	deactivateDenizens(actor) = { if (actor = Me) carl.deactivatenpc; }
;

everyone: ourdecoration
	sdesc = "customers"
	ldesc = "There are many customers here, each engaged in a lively
		conversation.  You'll probably want to look at each table
		individually to find out who's there."
	location = tavern
	noun = 'everyone' 'customers' 'patrons' 'everybody'
;

carl: ourdecoration, inactivenpc, named, male, person
	sdesc = "Carl"
	ldesc = "Carl looks like he's been tending the
		institute's bar for some time now, and in his wizened eyes
		you see the signs of wear.  It's not easy to live in a
		world of Acme products."
	noun = 'carl' 'bartender' 'barkeep' 'keep' 'cgdemarc'
	location = tavern

	bottlemessage = nil
	firsttime = true
	givenbeer = nil

	compute(actor) = {

		/* For no particularly good reason, Carl calls the Chinese Fire Drill */

		if (actor.isIn(tavern) and not self.firsttime) tavern.fireDrill;

		if (self.firsttime = true and self.isVisible(actor)) {
			self.firsttime := nil;
			self.msg := true;

			"\bAs you walk in, the bartender sees you and welcomes you with
			\"Hey, a new face.  Not exactly a pretty one, but come on in and
			sit down anyway.\"";
		}
		if (zenobottle.isVisible(self) and (not self.bottlemessage) and
			self.isVisible(actor)) {
			self.bottlemessage := true;
			self.msg := true;

			"\bThe bartender notices <<zenobottle.thedesc>> and mentions \"Say,
			I could really use a bottle like that.  Bring it to me empty
			and I'll find some suitable recompense.\"";

		}
	}

	verDoAskAbout(actor, iobj) = {}
	verDoAskFor(actor, iobj) = {}
	doAskAbout(actor, iobj) = {
		if (iobj = can or iobj = beer) {
			if (self.givenbeer)
				"Carl glares at you. \"Only one per customer.\"";
			else {
				"Carl responds \"Oh sure- the free special- I've been trying
				to get rid of these things for years.\"\b
				He puts a can of beer on the bar. ";
				can.moveInto(bar);
				self.givenbeer := true;
			}
		}
		else "\"Sorry\", he responds, \"can't help you with that\".";
	}
	doAskFor(actor, iobj) = { self.doAskAbout(actor, iobj); }
	ioGiveTo(actor, dobj) = {
		if (dobj = zenobottle) {
			if (dobj.liquidcontents = nil) {
				"Carl looks up in delight.  \"Hey, thanks a lot.  That
				bottle should improve my business no end.\"  He thinks
				for a bit, and says \"I can't say I have anything you'd
				really want, but here's a bit of advice if you plan on
				sticking around: they're mad about the number
				<<say(desk_dial.combination[1])>> hereabouts.  Truly
				phenomenal- always the first number to pop into anyone's
				head.  Say, does this refractifier here remind you of
				a red fish?\"\b";
				dobj.moveInto(nil);
			}
			else {
				"Carl looks up.  \"Thanks, but it's still full.  How am I
				supposed to use that?\"  He puts <<dobj.thedesc>> back on
				the bar. ";
				dobj.moveInto(bar);
			}
		}
		else if (dobj = faircoin) {
			"Carl picks up <<dobj.thedesc>>, examines it, and puts it back on
			the bar.  \"Thanks, but it doesn't look too fair to me.  Reminds
			me of some play I saw once...\"";
			dobj.moveInto(bar);
		}
		else {
			"Carl picks up <<dobj.thedesc>>, examines it, and puts it back on
			the bar.  \"Thanks, but I don't think I can use that.\"";
			dobj.moveInto(bar);
		}
	}

	messages = [  ]
;

bar: ourdecoration, surface
	sdesc = "bar"
	location = tavern
	noun = 'bar'
	adjective = 'mahogany'

	ioPutOn(actor, dobj) = { carl.ioGiveTo(actor, dobj); }
;


refractifier: ouritem
	sdesc = "refractifier"
	ldesc = "Light pours into the refractifier, but never out.
		It's almost impossible to make out the refractifier's edges,
		though you can see the bright red oompah button on it."
	noun = 'refractifier'
	location = bar
	verifyRemove(actor) = {
		"As you try to take <<self.thedesc>>, Carl puts his hand on
		it firmly, and says, with just a hint of testiness, \"Not without
		a cheez coupon, you don't.\"";
	}
;

cheez_coupon: ouritem
	sdesc = "cheez coupon"
	ldesc = "The cheez coupon doesn't really exist, and is just a figment
		of your imagination."
	noun = 'coupon'
	adjective = 'cheez'
	location = nil
;

oompah_button: ourdecoration, partitem, buttonitem
	sdesc = "oompah button"
	ldesc = "Light bends around the bright red oompah button, bedeviling your
		visual cortex."
	noun = 'button'
	adjective = 'bright' 'red' 'oompah'
	partof = refractifier
	doPush(actor) = {
		"Just as you are about to push the oompah button, Carl gives you
		a baleful glare that chills you to your very soul.  You opt against
		pushing the button for now.";
	}
;

/*
 * Tables, Chairs, Ashtrays and People
 */

bartables: ourdecoration
	sdesc = "bar tables"
	ldesc = "There are 6 tables distributed around the main room:\b
		\t\^<<goudatable.thedesc>>.\n
		\t\^<<stiltontable.thedesc>>.\n
		\t\^<<brietable.thedesc>>.\n
		\t\^<<gruyeretable.thedesc>>.\n
		\t\^<<swisstable.thedesc>>.\n
		\t\^<<limburgertable.thedesc>>.\b
		Each table has at least one chair free, so there's plenty of room for
		you if you want to sit down and mingle with students and faculty from
		the Institute for the <<instname()>> Sciences.  Each table has an ashtray
		on it."
	location = tavern
	noun = 'tables'
	adjective = 'bar' 'tavern'
;

barchairs: ourdecoration
	sdesc = "bar chairs"
	ldesc = "There are chairs at each of the tables.  For instance, at the Stilton table
		there is a Stilton chair."
	location = tavern
	noun = 'chairs'
	adjective = 'bar' 'tavern'
;

barashtrays: ourdecoration
	sdesc = "ashtrays"
	ldesc = "There are ashtrays on each table.\b
		\t\^<<goudatray.lldesc>>\n
		\t\^<<stiltontray.lldesc>>\n
		\t\^<<brietray.lldesc>>\n
		\t\^<<gruyeretray.lldesc>>\n
		\t\^<<swisstray.lldesc>>\n
		\t\^<<limburgertray.lldesc>>\b"
	location = tavern
	noun = 'trays' 'ashtrays'
	adjective = 'bar' 'tavern' 'table'
;

class bartable: surface, ourdecoration, fooditem
	cheez = nil

	sdesc = { say(self.cheez); " table"; }
	ldesc = {
		self.nrmLkAround(true);
	}
/*	lldesc = "\^<<self.thedesc>> is bustling with activity. " */

	noun = 'table'
	location = tavern

	mychair = nil
	mytray = nil

	denizenList = {
		local l, result, n, i, cur;

        	l := self.contents;
		n := length(l);
		result := [];
		for (i := 1; i <= n; i++) {
			cur := l[i];
			if (isclass(cur, bardenizen))
				result += cur;
		}

		return(result);
	}

	verDoEat(actor) = {
		"Eating <<self.thedesc>> would take a long time, and Carl probably
		wouldn't appreciate it.  Neither would such gluttony make a good
		impression on the 'tuters surrounding you.";
	}
	verDoSitat( actor ) = { self.mychair.verDoSiton(actor); }
	doSitat( actor ) = { self.mychair.doSiton(actor); }
	cantReach( actor ) = {
	        if ( self.location = nil ) {
	            if ( actor.location.location )
	               "%You% can't reach that from <<actor.location.thedesc>>. ";
        	    return;
	        }
		/* You can't reach things on this table if you're sitting at another. */
	        if (not (isclass(actor.location,barchair) and actor.location <> self.mychair))
	            self.location.cantReach( actor );
	        else "%You%'ll have to get up to reach things on <<self.thedesc>>. ";
	}
	contentsReachable = {
		/* You can't reach things on this table if you're sitting at another. */
	        if (isclass(Me.location,barchair) and Me.location <> self.mychair)
			return nil;
		pass contentsReachable;
	}
	contentsVisible = {
		/* You can't see things on this table if you're sitting at another. */
	        if (isclass(Me.location,barchair) and Me.location <> self.mychair)
			return nil;
		pass contentsVisible;
	}
	isReachable(actor) = {
		/* You can't reach things on this table if you're sitting at another. */
	        if (actor.location and isclass(actor.location,barchair) and
			 actor.location <> self.mychair)
			return nil;
		pass isReachable;
	}
	isVisible(actor) = {
		// You can't see things on this table if you're sitting at another.
	        if (actor.location and isclass(actor.location,barchair) and
			 actor.location <> self.mychair)
			return nil;
		pass isVisible;
	}
	lookAround(verbosity) = {
	        self.statusLine;
		self.nrmLkAround(verbosity);
	}
	nrmLkAround( verbosity ) = {     // lookAround without location status
	        local l, cur, i, tot;

		self.mytray.isListed := true;
	        if ( verbosity ) {
	            "\b"; self.lldesc; // DMB

	            l := self.contents;
		    tot := length( l );
		    i := 1;
	            while ( i <= tot ) {
		        cur := l[i];
	                if ( cur.isfixed ) cur.heredesc;
	                i := i + 1;
	            }
        	}
	        if (itemcnt( self.contents )) { // DMB
	            "\b\t";
	            "You see "; listcont( self ); " on the table. ";
		}
	        else {
	            "\n\t";
        	}
	        listcontcont( self ); "\n";

        	l := self.contents;
		tot := length( l );
		i := 1;
	        while ( i <= tot ) {
			cur := l[i];
	        	if ( isclass(cur, bardenizen) or
				(cur.isactor and cur.isListedActor )) {
	                    "\n\t";
	                    cur.actorDesc;
        		}
			i := i + 1;
	        }
		self.mytray.isListed := nil;
	}

;

class barchair: chairitem, ourdecoration, fooditem
	cheez = { return(self.mytable.cheez); }

	sdesc = { say(self.cheez); " chair"; }
	ldesc = { "<<self.sdesc>>"; }
	
	noun = 'chair'
	location = tavern

	mytable = nil
	reachable = [ self.mytable ]

	verDoEat(actor) = {
		"Eating <<self.thedesc>> would take a long time, and the owner probably
		wouldn't appreciate it.  Neither would such gluttony make a good
		impression on the 'tuters surrounding you.";
	}
	roomAction( actor, v, dobj, prep, io ) = {
	        if ( dobj<>nil and not isclass(v,TESTVERB))
	            ourCheckReach( self, actor, v, dobj );
	        if ( io<>nil and v<>askVerb and v<>tellVerb )
	            ourCheckReach( self, actor, v, io );
	}
	enterRoom(actor) = {
		local i, lst, n;
		if (actor = Me) {
			lst := self.mytable.denizenList;
			n := length(lst);
			for (i := 1; i <= n; i++)
				lst[i].activatenpc;
		}
	        if ( self.islit ) {
		    if (not self.isseen) self.firstseen;
		    self.isseen := true;
		    self.mytable.nrmLkAround(true);
		}
	}
	lookAround( verbosity ) = {
	        self.statusLine;
		self.mytable.nrmLkAround( verbosity );
	}
	leaveRoom(actor) = {
		if (actor = Me) {
			local i, lst, n;
			lst := self.mytable.denizenList;
			n := length(lst);
			for (i := 1; i <= n; i++)
				lst[i].deactivatenpc;
		}
		pass leaveRoom;
	}
	up = { self.doUnboard( Me ); return(nil);  }
;

ourCheckReach: function( loc, actor, v, obj ) {
    if ( obj=numObj or obj=strObj ) return;
    if ( not ( actor.isCarrying( obj ) or obj.isIn( actor.location )
	or (obj.isIn(loc.mytable)) or (obj = loc.mytable)))
    {
        "%You% can't reach "; obj.thedesc; " from "; loc.thedesc; ". ";
        exit;
    }
}

class ashtray: ourdecoration, liquidcontainer
	cheez = { return(self.mytable.cheez); }

	sdesc = {
		say(self.cheez); " ashtray";
		if (self.liquidcontents <> nil)
			" (containing <<self.liquidcontents.sdesc>>)";
	}
	ldesc = {
		"\^The "; say(self.cheez); " ashtray is fairly unimpressive, though
		at least it doesn't bear that almost ubiquitous Acme label. ";
		if (self.liquidcontents <> nil)
			"It contains <<self.liquidcontents.sdesc>>. ";
		else "It is empty. ";
	}
	lldesc = {
		"\^The "; say(self.cheez); " ashtray ";
		if (self.liquidcontents <> nil)
			"contains <<self.liquidcontents.sdesc>>. ";
		else "is empty. ";
	}
	
	noun = 'ashtray' 'tray'
	mytable = nil

	/* The graph coloring ashtrays tell what you've done clashes if
	 * either they're filled with non-paint or if their neighbors
	 * contain liquids but aren't different.  Everytime we fill, we
	 * perform a check to see whether all are properly colored.
	 */

	empty(fully) = {
		if (tavern.wascolored = true) {
			tavern.wascolored := nil;
			changescore(-11);
		}
		pass empty;
	}
	fill(liquid) = {
		self.contents := self.contents + liquid;
		caps();	"\n<<self.thedesc>> now contains <<liquid.sdesc>>. ";
		self.liquidcontents := liquid;

		/* Perform check. */
		if (self.clashcheck)
			"\^<<liquid.thedesc>> clashes with the rest of the Cheez Boar Inn's
			decor. ";
		else if (not (goudatray.clashcheck or stiltontray.clashcheck or
				brietray.clashcheck or gruyeretray.clashcheck or
				swisstray.clashcheck or limburgertray.clashcheck)) {
			"Somehow that was just the right touch.  The Cheez Boar Inn's
			ashtrays now blend perfectly into the stochastic transition
			patterns of its clients.  Carl comes over and congratulates
			you!  He says delightedly \"Good thing you didn't get any
			paint on your glasses.  How about a free round of beer?
			No, even better, how about a free number.
			<<say(desk_dial.combination[4])>>.  A great number, the
			denouement, the fourth, of many fine sequences.  I give you authority
			to use it as you see fit. Also, friend, if you
			haven't noticed already, don't put much trust in
			Acme products; they never really work.\"\n";
			changescore(11);
			tavern.wascolored := true;
		}
		else "\^<<liquid.thedesc>> looks wicked cool right there. ";
	}
	clashcheck = {
		local i, n, lst, tmp, liquid;

		liquid := self.liquidcontents;
		if (liquid = nil) return true;
		if (liquid <> redpaint and liquid <> bluepaint and liquid <> greenpaint)
			return true;
		else {
			lst := self.mytable.connectedto;
			n := length(lst);
			for (i := 1; i <= n; i++) {
				tmp := lst[i].mytray.liquidcontents;
				if (tmp and tmp = liquid)
					return true;
			}
			return nil;
		}
	}
;

redpaint: liquid
	sdesc = "red paint"
	ldesc = "The paint is almost exactly the same color that your childhood
		house wasn't."
	noun = 'paint'
	adjective = 'red'
;

bluepaint: liquid
	sdesc = "blue paint"
	ldesc = "The paint looks like it would be a good background color."
	noun = 'paint'
	adjective = 'blue'
;
greenpaint: liquid
	sdesc = "green paint"
	ldesc = "The paint is part of the Rainbow coalition."
	noun = 'paint'
	adjective = 'green'
;

goudatable: bartable
	lldesc = "\^<<self.thedesc>> is a big ball of the best
		 Dutch Gouda cheez.  The red protective
	         wax is abraded from many years of drunkards slamming
	         their beer steins into it, and offers tempting glimpses
                 of the luscious yellow cheez inside."
	cheez = 'Gouda'
	adjective = 'Gouda'
	mychair = goudachair
	mytray = goudatray

	connectedto = [ stiltontable brietable gruyeretable limburgertable ]
;

stiltontable: bartable
	lldesc = "\^<<self.thedesc>> is a rich Stilton cheez.
                 Its wrinkled rind has been sliced in half, revealing
		 blue veins running through the creamy whiteness of
                 the cheez."
	cheez = 'Stilton'
	adjective = 'Stilton'
	mychair = stiltonchair
	mytray = stiltontray

	connectedto = [ goudatable gruyeretable swisstable ]
;

brietable: bartable
	lldesc = "\^<<self.thedesc>> is a little bit squishy to the touch,
	         and perfectly at room temperature, just as one might expect 
		 a triple creme Brie to be served."
	cheez = 'Brie'
	adjective = 'Brie'
	mychair = briechair
	mytray = brietray

	connectedto = [ goudatable gruyeretable swisstable ]
;

gruyeretable: bartable
	lldesc = "\^<<self.thedesc>> is a pale yellow cheez that has been
                 cut into a hexagonal table.  Its nutty aroma makes you 
		 salivate as you fondly remember an excellent cheez fondue
		 that you once tasted."
	cheez = 'Gruyere'
	adjective = 'Gruyere'
	mychair = gruyerechair
	mytray = gruyeretray

	connectedto = [ goudatable stiltontable brietable swisstable limburgertable ]
;

swisstable: bartable
	lldesc = "\^<<self.thedesc>> is full of holes, now mostly filled in
		with many years' worth of dried beer and food scraps.
		A hodgepodge of initials and graffiti has been carved into 
		its surface."
	cheez = 'Swiss'
	adjective = 'Swiss'
	mychair = swisschair
	mytray = swisstray

	connectedto = [ stiltontable brietable gruyeretable ]
;

limburgertable: bartable
	lldesc = "\^<<self.thedesc>> emits a pungent odor that almost makes
		you gag.  However, even humble mold cells deserve to 
		live and be fed, so you refrain from taking more 
		drastic action."
	cheez = 'Limburger'
	adjective = 'Limburger'
	mychair = limburgerchair
	mytray = limburgertray

	connectedto = [ goudatable gruyeretable ]
;

goudachair: barchair
	ldesc = "The Gouda chair is a delicate filigree of red wax shavings.
		It looks like it might have been the senior project of 
		some art major at the 'Tute, and it's a miracle it hasn't 
		fallen apart or melted by now.\b"
	adjective = 'Gouda'
	mytable = goudatable;

stiltonchair: barchair
	ldesc = "The Stilton chair is a hollowed-out cheez rind.  Scraps of
		cheez have been strategically placed to fill in its wrinkles
		and make it more comfortable.\b"
	adjective = 'Stilton'
	mytable = stiltontable;

briechair: barchair
	ldesc = "The Brie chair used to be creamy white once upon a time,
		but is now stained and soiled to the point that not
		even a good soaking in bleach would have much effect.\b"
	adjective = 'Brie'
	mytable = brietable;

gruyerechair: barchair
	ldesc = "The Gruyere chair looks like a respectable bar stool,	
		except that all its component pieces have been fashioned
		from hexagons.\b"
	adjective = 'Gruyere'
	mytable = gruyeretable;

swisschair: barchair
	ldesc = "The Swiss chair was originally upholstered in a nice jacquard, but
		it is now tattered and torn and full of holes.\b"
	adjective = 'Swiss'
	mytable = swisstable;

limburgerchair: barchair
	ldesc = "The Limburger chair is big and soft and cozy, 
		and has been snuggled in by so many students that 
		it is beginning to smell rather rank.\b"
	adjective = 'Limburger'
	mytable = limburgertable;

goudatray: ashtray
	adjective = 'Gouda'
	location = goudatable
	mytable = goudatable;

stiltontray: ashtray
	adjective = 'Stilton'
	location = stiltontable
	mytable = stiltontable

	liquidcontents = bluepaint
	contents = [ bluepaint ]
;

brietray: ashtray
	adjective = 'Brie'
	location = brietable
	mytable = brietable;

gruyeretray: ashtray
	adjective = 'Gruyere'
	location = gruyeretable
	mytable = gruyeretable

	liquidcontents = redpaint
	contents = [ redpaint ]
;

swisstray: ashtray
	adjective = 'Swiss'
	location = swisstable
	mytable = swisstable;

limburgertray: ashtray
	adjective = 'Limburger'
	location = limburgertable
	mytable = limburgertable

	liquidcontents = greenpaint
	contents = [ greenpaint ]
;

/*
 * People
 */

class bardenizen: ourdecoration, npc, messagingnpc, person

	ldesc = "There is nothing, absolutely nothing, interesting about <<self.sdesc>>."

	isListedActor = nil
	actorDesc = {
		"\^<<self.thedesc>> is at <<self.location.thedesc>>, ";
		self.sayaction; ".";
	}
	canmove = true
	messageD = 3
	sayaction = {
		local r;
		r := myrand(23);
		switch (r) {
		case 1: "gesticulating wildly"; break;
		case 2: "muttering"; break;
		case 3: "drinking a beer"; break;
		case 4: "quaffing a rootbeer"; break;
		case 5: "acting drunk"; break;
		case 6: "drowning <<self.fmtYour>> sorrows"; break;
		case 7: "looking for a date"; break;
		case 8: "trying to remember <<self.fmtYour>> password"; break;
		case 9: "looking confused"; break;
		case 10: "pretending to think"; break;
		case 11: "avoiding <<self.fmtYour>> thesis"; break;
		case 12: "contemplating <<self.fmtYour>> glass"; break;
		case 13: "slandering other universities"; break;
		case 14: "crying"; break;
		case 15: "laughing"; break;
		case 16: "avoiding <<self.fmtYour>> life"; break;
		case 17: "having a nervous breakdown"; break;
		case 18: "and why shouldn't <<self.fmtYou>> be"; break;
		case 19: "living life to its fullest"; break;
		case 20: "deluding <<self.fmtYoumself>>"; break;
		case 21: "exactly"; break;
		case 22: "but is thinking about leaving"; break;
		case 23: "reducing <<self.fmtYour>> Tarjan number"; break;
		}
	}
	coremessages = [ bar_msg fire_msg ]
	indmessages = []
	messages = { return(self.coremessages + self.indmessages); }
;

phw: male, bardenizen, named
	sdesc = "Patrick Winston"
	ldesc = "Patrick Winston seems to be avoiding responsibility."
	noun = 'winston' 'phw'
	adjective = 'patrick'
	location = goudatable
;

cog: itthing, bardenizen, named
	sdesc = "Cog"
	ldesc = "Cog seems a little stiff, almost robotic in its movements."
	noun = 'cog'
	location = goudatable

	canmove = nil
	coremessages = []
;

jcma: male, bardenizen, named
	sdesc = "John Mallery"
	ldesc = "JCMA is wearing a t-shirt with \"Just call me abstraction.\" on it."
	noun = 'mallery' 'jcma'
	adjective = 'john'
	location = goudatable
;

berwick: male, bardenizen, named
	sdesc = "Robert Berwick"
	ldesc = "Bob is wearing a t-shirt with Noam Chomsky's picture on it, from
		his last tour."
	noun = 'berwick'
	adjective = 'bob' 'robert'
	location = goudatable
;

steele: male, bardenizen, named
	sdesc = "Guy Steele"
	ldesc = "Guy Steele is lisping."
	noun = 'steele'
	adjective = 'guy'
	location = brietable
;

einstein: male, bardenizen, named
	sdesc = "Albert Einstein"
	ldesc = "Einstein is looking resplendent, having recently combed his hair."
	noun = 'einstein'
	adjective = 'albert' 'al'
	location = brietable
;

meyer: male, bardenizen, named
	sdesc = "Albert Meyer"
	ldesc = "Albert Meyer seems omniscient, omnipotent, and omnivorous to your small eyes."
	noun = 'meyer'
	adjective = 'albert' 'al'
	location = brietable
;

barbie: female, bardenizen, named
	sdesc = "Barbie"
	ldesc = "Barbie looks a bit stiff."
	noun = 'doll'
	adjective = 'barbie'
	location = brietable
;

dally: male, bardenizen, named
	sdesc = "Bill Dally"
	ldesc = "Bill Dally is wearing a sopping-wet red v-neck sweater.  Either he\'s just
		been promoted or he\'s been flying over the Long Island Sound."
	noun = 'dally'
	adjective = 'bill' 'william'
	location = stiltontable
;

brooks: male, bardenizen, named
	sdesc = "Rod Brooks"
	ldesc = "Rod Brooks is outdrinking everyone else, armed as he is with an
		Australian heritage."
	noun = 'brooks' 'rab'
	adjective = 'rod' 'rodney'
	location = stiltontable
;

tk: male, bardenizen, named
	sdesc = "Tom Knight"
	ldesc = "Tom Knight is carrying a large Kendall Square sign he
		stole from the T."
	noun = 'knight' 'tk' 
	adjective = 'tom' 'thomas'
	location = stiltontable
;

mcallester: male, bardenizen, named
	sdesc = "David McAllester"
	ldesc = "David McAllester is dressed in formal evening wear."
	noun = 'mcallester' 'dam'
	adjective = 'david'
	location = stiltontable
;

halgerry: male, bardenizen, named
	sdesc = "Halgerry"
	ldesc = "Halgerry seems to have two indistinguishable personalities."
	noun = 'halgerry' 'sussman' 'abelson'
	location = gruyeretable
;

ziggy: male, bardenizen, named
	sdesc = "Ziggy"
	ldesc = "Ziggy is dressed in sieve-like goalie pads."
	noun = 'ziggy' 'blair'
	adjective = 'michael' 'mike'
	location = gruyeretable
;

gore: male, bardenizen, named
	sdesc = "Al Gore"
	ldesc = "Al Gore is wearing an impenetrable mask of stoicism today."
	noun = 'gore' 'vice-president'
	adjective = 'al'
	location = gruyeretable
;

ellen: female, bardenizen, named
	sdesc = "Ellen Spertus"
	ldesc = "Ellen Spertus's hair is out of control."
	noun = 'spertus'
	adjective = 'ellen'
	location = gruyeretable
;

lenat: male, bardenizen, named
	sdesc = "Doug Lenat"
	ldesc = "Doug Lenat is busy automating a mathematician."
	noun = 'lenat'
	adjective = 'doug' 'douglas'
	location = swisstable
;

businessman: male, bardenizen
	sdesc = "businessman"
	noun = 'businessman'
	ldesc = "The businessman is wearing a suit, and is obviously out of place in
		the bar."
	location = swisstable
;

hal: male, bardenizen, named
	sdesc = "Hal"
	ldesc = "Hal remains an ominous, pervasive entity."
	noun = 'hal' '2000'
	location = swisstable
;

knuth: male, bardenizen, named
	sdesc = "Donald Knuth"
	ldesc = "Donald Knuth is busy writing vol. 22, \"The Art of User Interfaces\"."
	noun = 'knuth'
	adjective = 'don' 'knuth'
	location = swisstable
;

witty: male, bardenizen, named
	sdesc = "Carl Witty"
	noun = 'witty'
	ldesc = "Carl Witty is studying a book of geometric poetry."
	adjective = 'carl'
	location = limburgertable
;

oracle: female, bardenizen
	sdesc = "oracle"
	ldesc = "The oracle is a small floating orb."
	noun = 'oracle'
	location = limburgertable
;

gates: male, bardenizen, named
	sdesc = "Bill Gates"
	ldesc = "Bill Gates looks ready to steal an idea from you."
	noun = 'gates'
	location = limburgertable
;

weizenbaum: male, bardenizen, named
	sdesc = "Joe Weizenbaum"
	ldesc = "Joe Weizenbaum looks like a responsible computer professional."
	noun = 'weizenbaum'
	adjective = 'joe'
	location = limburgertable
;

