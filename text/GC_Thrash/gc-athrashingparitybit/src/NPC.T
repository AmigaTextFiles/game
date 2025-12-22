
/*
 * NPC Classes
 */

/*
 * npc: The basic NPC.
 *
 * Every turn each active npc is given a chance to compute a move, make that
 * move, compute (other things), and say something to a user.  An npc can be
 * deactivated and reactivated at any time, and is only deactivated as an
 * efficiency aid.  By default nonmoving npc's start the game inactive,
 * movingnpc's start the game active.
 *
 * Special subclasses exist, movingnpc's and messagingnpc's.  movingnpc's
 * have special facilities for computing a move to make based on a
 * predetermined cycle, and messagingnpc's have special facilities for
 * displaying messages at random times.
 *
 * Each turn, the 'computemove' method will be called on every active npc.
 * This should set the 'move' slot to either a location or 'true' (don't move).
 * The slot is by default true, so if the method does not exist the npc
 * remains stationary.  Actual movement takes place when the 'movenpc(actor)'
 * method is called with the actor (Me) that needs to be around for a movement
 * message to be displayed.
 *
 * After all npc's have been moved, the 'compute(actor)' method is called on
 * each of them, and then the 'displaymessages(actor)' method.
 */

class npc: ouractor
	saydesc = { self.thedesc; }
	movenpc(actor) = {
		if (self.move <> true and self.move <> self.location) {
			if (self.isVisible(actor))
				if (self.tostring = nil)
					"\n\t\^<<self.thedesc>> <<self.leaveword>>. ";
				else
		 "\n\t\^<<self.thedesc>> <<self.goword>> <<self.tostring>>. ";
			self.moveInto(self.move);
			if (self.isVisible(actor))
				if (self.fromstring = nil)
					"\n\t\^<<self.thedesc>> <<self.enterword>>. ";
				else
		 "\n\t\^<<self.thedesc>> <<self.comeword>> <<self.fromstring>>. ";
		}
	}

	leaveword = "leaves"
	enterword = "just showed up"
	comeword = "comes"
	goword = "goes"

	move = true

	compute(actor) = {}
	displaymessages(toactor) = {}

	isactive = nil
	deactivatenpc = {
		if (self.isactive) {
			self.isactive := nil;
			global.npclist -= self;
		}
	}
	activatenpc = {
		if (not self.isactive) {
			self.isactive := true;
			global.npclist += self;
		}
	}
;

person: npc
	verDoRub(actor) = {}
	doRub(actor) = {
		"\n\t\"Get your hands off of me!\"\n";
	}

	verDoKiss(actor) = {}
	doKiss(actor) = {
		"\^<<self.thedesc>> looks eminently unkissable.";
	}

	verIoGiveTo(actor) = {}
	ioGiveTo(actor, dobj) = {
		"\^<<self.thedesc>> thanks you for <<dobj.thedesc>>, and takes it.";
		/* Kill object, so, for instance, ARPA doesn't find toast that
		 * you've given to Marvin. */
		dobj.moveInto(nil);
			
	}
	verDoAskAbout(actor, iobj) = {
		"\^<<self.thedesc>> doesn't feel like answering silly questions.";
	}
	verDoAskFor(actor, iobj) = {
		"\n\t\"Want something for free, eh?  Forget it.\"\n";
	}
;

animal: ourthing
	verDoFeed(actor) = {}
	doFeed(actor) = {
		"Please don't feed the animals.  You could give some food
		to <<self.thedesc>> and let it decide whether or not it's hungry.";
	}
	verIoFeedTo(actor) = {}
	ioFeedTo(actor,dobj) = {
		"Please don't feed the animals.  You could give <<dobj.thedesc>> 
		to <<self.thedesc>> and let it decide whether or not it's hungry.";
	}
	verDoAskAbout(actor, iobj) = {
		"\^<<self.thedesc>> isn't very smart, and can't answer
		your question.";
	}
	verDoAskFor(actor, iobj) = {
		"\nSurely you jest.  Begging from animals?\n";
	}
	verIoGiveTo(actor) = {}
	ioGiveTo(actor, dobj) = {
		"\^<<self.thedesc>> does not appear interested in burdening
		itself with material possessions. ";
	}
;

uninterestednpc: npc
	ioGiveTo(actor,dobj) = {
		"\^<<self.thedesc>> doesn't seem interested in <<dobj.thedesc>>.";
	}
;

class activenpc: npc
	isactive = true
;
class inactivenpc: npc
	isactive = nil
;

/* Each movingnpc needs to provide a cyclic map of where they are.
 * Each step in the cycle consists of a time to wait and a transition
 * direction or location.  If the time till next transition is
 * a negative number x, it is interpreted as a 1/(-x) probability
 * of performing the transition.  This makes it east to do single
 * time cameos with low probability.  A time of 0 means stay forever.
 * If the direction is `true', then no movement takes place.
 *
 * samples:
 *
 *	cycle = [ 5 garden_entrance 2 &east 1 &north
 *		1 &north 1 &east 1 &north 1 &sw 1 &south 1 &east 1
 *		&west 1 &south 1 &west 1 nil ]
 *
 *	cycle = [ 0-10 south_courtyard 2 nil ] // Tads won't let you write -10.  Use 0-10.
 */

class movingnpc: activenpc
	origlocation = nil
	resetcycle = { self.cyclecounter := 1; self.moveInto(self.origlocation); }
	advancecycle = {
		self.cyclecounter += 2;
		if (self.cyclecounter > length(self.cycle))
			self.cyclecounter := 1;
	}
	computemove = {
		local c, mv, dest, transtime;

		c := self.cyclecounter;
		transtime := self.cycle[c];
		self.delaycounter += 1;

		if ((transtime < 0 and (transtime + myrand(-transtime)) = 0) or
		    (transtime > 0 and (self.delaycounter >= transtime))) {
			self.delaycounter := 0;

			mv := self.cycle[c + 1];
			if (datatype(mv) = 13) { /* Property pointer. */
				outhide(true);
				if (self.location = nil) {
					"\n\^<<self.sdesc>> is attempting a directional move
					out of nil, on cycle "; say((c + 1)/2); ".\n";
					dest := nil;
				}
				else
					dest := self.location.(mv);
				outhide(nil);
				if (dest and isclass(dest, ourroom)) {
					self.move := dest;
					self.advancecycle;

					switch(mv) {
					case &north:
						self.tostring := 'to the north';
						self.fromstring := 'from the south';
						break;
					case &south:
						self.tostring := 'to the south';
						self.fromstring := 'from the north';
						break;
					case &east:
						self.tostring := 'to the east';
						self.fromstring := 'from the west';
						break;
					case &west:
						self.tostring := 'to the west';
						self.fromstring := 'from the east';
						break;
					case &ne:
						self.tostring := 'to the northeast';
						self.fromstring := 'from the southwest';
						break;
					case &sw:
						self.tostring := 'to the southwest';
						self.fromstring := 'from the northeast';
						break;
					case &nw:
						self.tostring := 'to the northwest';
						self.fromstring := 'from the southeast';
						break;
					case &se:
						self.tostring := 'to the southeast';
						self.fromstring := 'from the northwest';
						break;
					case &up:
						self.tostring := 'up';
						self.fromstring := 'from below';
						break;
					case &down:
						self.tostring := 'down';
						self.fromstring := 'from above';
						break;
					case &in:
						self.tostring := 'in';
						self.fromstring := 'from outside';
						break;
					case &out:
						self.tostring := 'out';
						self.fromstring := 'out';
						break;
					}
				}
				else {
					"\b*** <<self.thedesc>> can't move out of
					 <<self.location.sdesc>> in state";
					say((c+1) / 2); ". ***\n";
					self.move := self.location;
				}
			}
			else {
				self.move := mv;
				self.advancecycle;
			}
			if (self.cyclecounter > length(self.cycle))
				self.cyclecounter := 1;
		}
		else self.move := self.location;
	}
	cycle = [ 1 nil ]
	cyclecounter = 1
	delaycounter = 0
;

/*
 * followingnpc's always follow some other npc.  That npc should be set with
 * 'leader = XX'.  Their location must be set identically at the start.
 */

class followingnpc: movingnpc
	computemove = {
		self.move := self.leader.move;
		self.tostring := self.leader.tostring;
		self.fromstring := self.leader.fromstring;
	}
;

/* messagingnpc's randomly print messages, unless the npc sets the 'msg' slot to
 * a certain message during the compute cycle.  The messages are taken from the
 * 'messages' method (which much return a list), and the number to print per turn
 * is in 'messagesperturn'.  The fraction of the time that any messages are printed
 * is determined by 'messageN'/'messageD', which defaults to 1/1 (every turn).
 * If the 'compute(actor)' cycle sets 'msg' to true, no message is displayed.
 */

class messagingnpc: npc
	messagesperturn = 1
	messages = []
	msg = nil

	/* Fraction of time to give a random message. */
	messageN = 1
	messageD = 1

	displaymessages(toactor) = {
		local m, validmessages, i, n, totalweight, tmp, j;
		if (self.isVisible(toactor)) {
			if ((self.msg <> nil and self.msg <> true) and
			    (self.msg.vfymessage(self, toactor))) {
				"\n\b";
				self.msg.print(self, toactor);
			}
			else if (self.msg <> true and myrand(self.messageD) <= self.messageN) {
				validmessages := [];
				n := length(self.messages);
				totalweight := 0;
				for (i := 1; i <= n; i++) {
					tmp := self.messages[i];
					if (tmp.vfymessage(self, toactor)) {
						validmessages += tmp;
						totalweight += tmp.weight;
					}
				}
				for (i := 1; ((i <= self.messagesperturn)
						 and (validmessages <> [])); i++) {
					tmp := myrand(totalweight);
					j := 1;
					while(tmp > 0) {
						tmp -= validmessages[j].weight;
						j++;
					}
					m := validmessages[j-1];
					m.print(self,toactor);
					totalweight -= m.weight;
				}
			}
		}

		self.msg := nil;
	}
;

/* Before a message is displayed, its vfgmessage(speaker,toactor) must return true.
 * Then, the probability that a message is displayed is determined by its relative
 * weight ('weight = 100' is the default).
 */

class messagebase: object
	print(speaker, actor) = {
		if (messagebase.printedany = nil) {
			"\b"; messagebase.printedany := true;
		}
		"\n"; caps(); self.alltext(speaker,actor); "\n";
	}
	alltext(speaker, actor) = { "Your message could appear here."; }
	vfymessage(speaker,actor) = { return true; }
	weight = 100
	printedmessages = []
	printedany = nil
	
;

class message: messagebase
	printed = []
	types = [
		&texts [0]
		&statements ['says' 'utters' 'mentions']
		&questions ['queries' 'ponders' 'asks' 'questions']
		&exclamations ['ejaculates' 'yells' 'explodes' 'exclaims' 'shouts']
		&mutters ['mutters']
		&ponders ['mutters' 'ponders' 'reflects']
		&requests ['requests' 'asks' 'inquires']
	]
	alltext(speaker, actor) = {
		local i, sayword;
		i := myrand(self.numberofmessages);

		if (find(self.printed, i)=nil) {
			self.printed += i;
			messagebase.printedmessages += self;			
		
			sayword := randomelement(self.types[self.allmessages[i*2-1]]);
			if (sayword = 0)
				say(self.allmessages[i*2]);
			else {
				"\^<<speaker.saydesc>> ";
				say(sayword); " \"";
				say(self.allmessages[i*2]); "\"";
			}
		}
	}
	setup = {
		local i, j, tmpmsglist;

		self.allmessages := [];
		self.weight := 0;
		self.numberofmessages := 0;
		for (i := 1; i <= length(self.types); i += 2)
			if (defined(self,types[i])) {
				tmpmsglist := self.(self.types[i]);
				for (j := 1; j <= length(tmpmsglist); j++) {
					self.allmessages += (i + 1);
					self.allmessages += tmpmsglist[j];
					self.weight += 100;
					self.numberofmessages++;
				}
			}
	}
;
	
/*
 * Init npc list.
 */

initNPC: function() {

	local o;

	global.npclist := [];
	o := firstobj();
	while( o <> nil ) {
        	if (isclass(o,npc) and not isclass(o,followingnpc) and o.isactive)
			 global.npclist := global.npclist + o;
	        o := nextobj( o );
	}
	o := firstobj();
	while( o <> nil ) {
        	if (isclass(o,npc) and isclass(o,followingnpc) and o.isactive)
			 global.npclist := global.npclist + o;
	        o := nextobj( o );
	}

	o := firstobj();
	while( o <> nil ) {
        	if (isclass(o,messagebase))
			 o.setup;
	        o := nextobj( o );
	}
}

/*
 * handleNPCs is executed every turn.
 */

handleNPCs: function(g) {
	local i,n,npc,l,mn,ml;

	l := g.npclist;

	n := length(l);
	for (i := 1; i <= n; i++) {
		npc := l[i];
		npc.tostring := nil;
		npc.fromstring := nil;
		npc.move := true;
		npc.computemove;
		npc.movenpc(Me);
	}
	for (i := 1; i <= n; i++) {
		npc := l[i];
		npc.msg := nil;
		npc.compute(Me);
	}
	ml := messagebase.printedmessages;
	messagebase.printedany := nil;
	mn := length(ml);
	for (i := 1; i <= mn; i++)
		ml[i].printed := [];

	for (i := 1; i <= n; i++) {
		l[i].displaymessages(Me);
	}
}

