class named: ourthing
	adesc = { self.sdesc; }
	thedesc = { self.sdesc; }
;

class female: ourthing
	fmtYou = "she"
	fmtYour = "her"
	fmtYoure = "she is"
	fmtYouve = "she has"
	fmtYoum = "her"
	fmtHave = "has"
	fmtDo = "does"
	fmtAre = "is"
	fmtYoumself = "herself"

	isHer = true
;

class itthing: ourthing
	fmtYou = "it"
	fmtYour = "its"
	fmtYoure = "it is"
	fmtYouve = "it has"
	fmtYoum = "it"
	fmtHave = "has"
	fmtDo = "does"
	fmtAre = "is"
	fmtYoumself = "itself"
;

class male: ourthing
	fmtYou = "he"
	fmtYour = "his"
	fmtYoure = "he is"
	fmtYouve = "he has"
	fmtYoum = "him"
	fmtHave = "has"
	fmtDo = "does"
	fmtAre = "is"
	fmtYoumself = "himself"

	isHim = true
;

class pluralnpc: ourthing
	fmtYou = "they"
	fmtYour = "their"
	fmtYoure = "they are"
	fmtYouve = "they have"
	fmtYoum = "them"
	fmtHave = "have"
	fmtDo = "do"
	fmtAre = "are"
	fmtYoumself = "themselves"
;

class absorber: container;

class ourthing: thing
	/* TESTVERB methods */

	verDoGimme(actor) = {}
	doGimme(actor) = {
		self.moveInto(actor);
		setit(self);
		"You Cheater!\n";
	}
	verDoGoto(actor) = {
		if ((self.location = nil) or (not isclass(self.location, ourroom)))
			"Location is not room!";
	}
	doGoto(actor) = {
		"Teleported to <<self.location.sdesc>>.\b";
		actor.travelTo(self.location);
	}

	verDoLocate(actor) = {}
	doLocate(actor) = {
		caps();	"<<self.thedesc>> is ";
		if (self.location = nil) "nowhere";
		else {
			"in "; self.location.thedesc;
		}
		".";
	}

	/* Other verb methods */
	verDoDestroy(actor) = { 
		"Wanton destruction won't accomplish anything.  ";
	}
	verDoSitat( actor ) = {
		"I don't know how to sit at "; self.thedesc; ". ";
	}
	verDoSiton(actor) = {
		"\^<<self.thedesc>> wasn't made to be sat on. ";
	}
	verDoPuttWith(actor,iobj) = "\^<<self.adesc>> isn't really something you putt."
	verIoPuttWith(actor) = "You putt with a putter, not <<self.adesc>>."
	verDoSwing(actor) = "It's dangerous to go swinging things without
				thinking about the consequences."
	verIoSwingAt(actor) = "Be careful- you might hurt <<self.thedesc>>."
	verDoSwingAt(actor,iobj) = { self.verDoSwing(actor); }
	verIoAskAbout(actor) = {}
	verIoAskFor(actor) = {}
	ioAskAbout(actor, dobj) = { dobj.doAskAbout(actor, self); } 
	ioAskFor(actor, dobj) = { dobj.doAskFor(actor, self); } 
	verDoAttack(actor) = {
		"Attacking things indiscriminately isn't such a good idea.\n";
	}
	verDoJumpInto(actor) = {
		"\nI don't know how to jump into <<self.thedesc>>.\n";
	}

	/* Other */
	
	containingroom = {
		local loc;
		loc := self.location;
		while (loc and loc.location)
			loc := loc.location;
		return(loc);
	}

	moveInto( obj ) = {
	        local loc;

		/*
		 *   For the object containing me, and its container, and so forth,
		 *   tell it via a Grab message that I'm going away.
		 */
		loc := self.location;

		while ( loc ) {
			loc.Grab( self );
			loc := loc.location;
		}

	        if ( self.location )
        	    self.location.contents := self.location.contents - self;

		if (obj and isclass(obj, absorber)) { /* CHANGE */
			self.location := nil;
			"You hear a ZAP!\n";
			return;
		}
	        self.location := obj;
	        if ( obj ) obj.contents := obj.contents + self;
	}
;

class ouractor: ourthing, Actor
	isactor = true
	isListedActor = true
;

class ourmovableactor: ourthing, movableActor
	isactor = true
	isListedActor = true
;

class littleactor: ourmovableactor, ouritem /* An actor that is easily manipulable. */
;

class ouritem: item, ourthing

	/* Other verb methods */

	verDoFly(actor) = { self.verDoThrow(actor); }
	doFly(actor) = { self.doThrow(actor); }

	verIoJoinTo(actor) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
		else
			"%You% can't really expect me to join <<self.adesc>>, can you?";
	}
	verDoJoinTo(actor, iobj) = { self.verIoJoinTo(actor); }

	verDoThrow(actor) = {
		"Throwing <<self.thedesc>> would either break it or break
		%you%.  I think you'd better calm down and think this over.";
	}
	verDoThrowThrough(actor, iobj) = {
		"Throwing <<self.thedesc>> would either break it or break
		%you%.  I think you'd better calm down and think this over.";
	}
	verIoThrowThrough(actor) = {
		"Throwing something through <<self.adesc>> doesn't make any
		sense and you know it!";
	}
	verIoSprayOn(actor) = {}

	ioSprayOn(actor, dobj) = {
		local c;
		c := dobj.findContainer(actor)[1];
		if (self = c) "You can't spray something on itself!";
		else {
			"Spraying <<c.liquidcontents.sdesc>> on <<self.thedesc>> has no
			discernable effect.";
			if (c.liquidcontents.isPoisonous) {
				self.isPoisonous := true;
				self.isGnuEdible := nil;
			}
			c.spray(self);
		}
	}
	verDoSprayWith(actor, io) = { return(self.verIoSprayOn(actor)); }
	doSprayWith(actor, iobj) = { iobj.ioSprayOn(actor, self); }
;

class breakable: ouritem
	verDoThrow(actor) = {
		"Throwing <<self.thedesc>> would certainly break it.  You
		better not do that.";
	}
	verDoThrowThrough(actor, iobj) = {
		"Throwing <<self.thedesc>> would certainly break it.  You
		better not do that.";
	}
;

class ourdecoration: decoration, ouritem
	isdecoration = true
	isListedActor = nil
;

class ourroom: room;
	
class outsideroom: diggingplace, ourroom
	grounddesc = "\nThe ground looks like it could absorb a lot of charge.\n"
;
class insideroom: flooredplace, ourroom
	grounddesc = "\nThe ground looks like it could absorb a lot of charge.\n"
;


/* buriedHider CGDEMARC */

class buriedHider: hider
    buriedCont = []         /* list of items buried in me (set up by initSearch) */
    digHere(actor, implement) = {
	if (self.buriedCont = nil)
	    "Digging here doesn't reveal anything else.";
	else
	    self.buriedCont := self.searchObj(actor, self.buriedCont);
    }
;

class multilocation: floatingItem
	locationOK = true
	location = {
		if (find(self.locations, Me.location))
			return (Me.location);
		else return nil;
	}

	locations = []
;

/* partitem's are used to create floating decorations and other objects
 * that always follow other objects.  These objects should not have a location
 * method and should set the `partof' method equal to the object it is
 * attached to.  The corresponding super object should have this object
 * in its 'component' list.  Calling the 'removeConnection' method of the
 * object will sever the connection between the objects and make the
 * part an independent object.
 */
    
class partitem: ouritem, floatingItem
	locationOK = true
	location = { return self.partof.location; }
	isListed = nil

	/* If someone figures out we're a part and tries to take us, remove
	 * the connection between us and our parent.
	 */
	doTake( actor ) = {
		self.removeConnection;
		pass doTake;
	}
	removeConnection = {
		if (self.partof) {
			self.isListed := true;
			self.location := self.partof.location;
			self.partof := nil;
		}
	}
;

/* Digging Places: CGDEMARC */

class diggingplace: room
	verDoDig(actor) = {}
	verDoDigWith(actor, iobj) = {
		if (not iobj.isdigger)
			"Digging without a tool made for the job is a quick
			way to wear yourself out!";
	}
	digIn(actor, implement) = {
		if (defined(actor.location, &digHere))
			actor.location.digHere(actor, implement);
		else "Digging here doesn't reveal anything.";
	}
;

class flooredplace: diggingplace
	verDoDig(actor) = "You can't dig through a floor!"
	verDoDigWith(actor, iobj) = "You can't dig through a floor!"
;

/* This is mainly used by "the ground" to pass digging on to the room location. */
class passdigging: object
	verDoDig(actor) = { return actor.location.verDoDig(actor); }
	verDoDigWith(actor, iobj) = { return actor.location.verDoDigWith(actor, iobj); }
	digIn(actor, implement) = { return actor.location.digIn(actor, implement); }
;
	
class potentialdigger: item
	verIoDigWith(actor) = {}
	ioDigWith(actor, dobj) = { dobj.digIn(actor, self); }
;

class digger: potentialdigger
	isdigger = true
;

class throwable: ouritem
	verDoThrowThrough(actor, iobj) = {}
	verDoThrow(actor) = {}
;

class enterable: object
	verDoEnter(actor) = {}
	doEnter(actor) = { actor.travelTo(self.location.(self.enterdir)); }
;

class exitable: object
	verDoExit(actor) = {}
	doExit(actor) = { actor.travelTo(self.location.(self.exitdir)); }
;

class desk: decoration, surface, searchHider
	sdesc = "desk"
	ldesc = "It appears to be the basic Acme mark V desk, so common
		throughout the Acme institute."
	noun = 'desk'
	adjective = 'Acme' 'mark' 'v'

	verDoOpen(actor) = { self.verDoSearch(actor); }
	doOpen(actor) = { self.doSearch(actor); }
;

class ourchair: chairitem, unlisted
	sdesc = "chair"
	noun = 'chair'
;

class sprayingitem: ouritem, liquidcontainer
	verDoSprayOn(actor, iobj) = { return(self.verIoSprayWith(actor)); }
	verIoSprayWith(actor) = {
		if (self.liquidcontents = nil)
			"There is no spray in <<self.thedesc>>. ";
	}
	ioSprayWith(actor, dobj) = { dobj.ioSprayOn(actor, self); }

	spray(recipient) = {
		self.empty(nil);
	}
	isSprayer = true
;

class whiteboard: ourdecoration, readable
	sdesc = "whiteboard"
	ldesc = { if (self.isclean) "The whiteboard is spotlessly clean and ready for use.";
		else if (self.isgrimy) "The whiteboard is almost undescribably filthy and
					stinks awfully.";
		else "The whiteboard has been written on- perhaps you should read it.";
		}
	readdesc = { if (self.isclean) "There is nothing on the board to read.";
			else if (self.isgrimy)
				"Anything you might once have read on the board is now
					buried under grime.";
			else say(self.writing);
	}

	noun = 'whiteboard' 'board' 'blackboard'
	adjective = 'dirty' 'clean' 'white'
	
	isclean = nil
	isgrimy = nil /* Has Acme cleaner been applied? */

	ioSprayOn(actor, dobj) = {
		local c;
		c := dobj.findContainer(actor)[1];

		"You spray the <<c.liquidcontents.sdesc>> on <<self.thedesc>>. ";

		if (c.liquidcontents.iscleaner <> nil) {
			if (self.isclean) "It remains prim and spotless.";
			else { "The grime and dirty writing on the whiteboard slowly
				drips away to reveal a shining white substrate.";
				self.isgrimy := nil;
				self.isclean := true;
				self.writing := 'THIS SHOULDN\'T APPEAR';
			}
		}
		else if (c.liquidcontents.isgrimifier <> nil) {
			"The putrid, tarry and quite likely poisonous substance that sputters
			out covers the board and destroys all trace of whatever might have
			been on the board.";
			self.isgrimy := true;
			self.writing := 'THIS SHOULDN\'T APPEAR';
		}
		else "It has no effect.";
		c.empty(true);
	}
	verDoClean( actor ) = {
        	if (self.isgrimy = true) "\^<<self.thedesc>> looks just as grimy as before. ";
		else if (self.isclean = true) "\^It was already spotless. ";
		else "The writing on the board remains unsmudged. ";
	}
	verDoCleanWith(actor, iobj) = { self.verDoClean(actor); }
;

class radioactiveobject: ouritem
	isradioactive = true
;

class ourdoorway: doorway
	verIoThrowThrough(actor) = {
		if (not self.isopen) {
			caps();
			"You can't through something through <<self.thedesc>>-
			it's closed.";
		}
	}
	ioThrowThrough(actor, dobj) = {
		"You throw <<dobj.thedesc>> through <<self.thedesc>>, and watch it fly
		 away from you.";
		dobj.moveInto(self.doordest);
	}

	verDoKnock(actor) = { "%You% knock, but no one answers.  "; }
	throwotherside(thrownobject) = { return(self.doordest); }
;

/* windows provide functionality for both passable and impassable windows.
 * A window with a thrudesc method will use this instead of the doordest
 * method for looking through it.
 */
 
/* lockedwindow's are locked with an unknown key, and therefore are merely decorations.
 * shutwindow's are unopenable windows, and therefore are merely decorations.
 */

class window: ourdoorway
	sdesc = "window"
	ldesc = { pass ldesc; }
	noun = 'window'
	adjective = 'office'
	verDoLookin( actor ) = {}
	verDoLookthru( actor ) = {}
	doLookin(actor) = { self.doLookthru(actor); }
	doLookthru(actor) = {
		"Looking through <<self.thedesc>>, you see <<doordest.adesc>>.\n";
	}
	isopen = nil
;

class shutwindow: window
    ldesc = "The window is not one that can be opened."
    isopen = nil
    islockable = nil
    verDoOpen( actor ) = "This window can not be opened."
    verDoUnlock( actor ) = "The window is permanently shut."
    verDoLockWith( actor, io ) = "The window is permanently shut."
    verDoUnlockWith( actor, io ) = "The window is permantly shut."
;

class lockedwindow: window
    isopen = nil
    islocked = true
    mykey = missingKey
;

missingKey: keyItem, ouritem
	location = nil
;

class endjoinable: ouritem
	verIoJoinTo(actor) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
	}
	verDoJoinTo(actor, iobj) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
		else "\^<<self.thedesc>> doesn't join well on that side.";
	}
;

class startjoinable: ouritem
	verDoJoinTo(actor, iobj) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
	}
	verIoJoinTo(actor) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
		else "\^<<self.thedesc>> doesn't join well on that side.";
	}
;

class joinable: ouritem
	verDoJoinTo(actor, iobj) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
	}
	verIoJoinTo(actor) = {
		if ( not ( actor.isCarrying( join ) or join.isIn( actor.location )))
			"%You% can't join things unless you have a joiner.";
	}
;

/* Liquid items (and drink items) may occur in several containers.  Drinking
 * one of them SHOULD NOT manipulate the liquid- the liquid container is
 * manipulated elsewhere (in the liquidcontainer class).
 */

class liquid: ouritem
	adesc = { self.sdesc; }

	isListed = nil

	/* DOESN'T WORK */

	verifyRemove(actor) = {
		"You can't just play around with liquids- try mentioning a container.";
	}

	verDoDrink(actor) = {
		"I don't think you want to be drinking <<self.sdesc>>.";
	}
	verDoDrinkFrom(actor, iobj) = {
		self.verDoDrink(actor);
	}
	verDoEmpty(actor) = {
		local containers;
		containers := self.findContainer(actor);
		if (length(containers)>1)
			"Please specify which container you want to empty.";
		else containers[1].verDoEmpty(actor);
	}
	doEmpty(actor) = {
		self.findContainer(actor)[1].doEmpty(actor);
	}
	verDoEmptyFrom(actor, iobj) = {}
	verDoEmptyInto(actor, iobj) = {}
	verIoFillWith(actor) = {
		self.verDoEmpty(actor);
	}
	ioFillWith(actor, dobj) = { dobj.ioEmptyInto(actor, self); }

	doEat( actor ) = {
		"I don't think you want to be eating <<self.sdesc>>.  Not even
		drinking it.";
	}

	verIoSprayWith(actor) = {
		local c;
		c := self.findContainer(actor)[1];
		if (not c.isSprayer) "\^<<self.thedesc>> must be in a sprayer first!";
	}
	verDoSprayOn(actor, iobj) = { self.verIoSprayWith(actor); }
	ioSprayWith(actor, dobj) = { dobj.ioSprayOn(actor, self); }

	verIoCleanWith(actor) = {
		"You can't use <<self.sdesc>> to clean unless you spray it on something.";
	}


	locationOK = true
	location = {
		local tmp;
		tmp := self.findContainer(Me);
		if (tmp = []) return nil;
		else return (tmp[1]);
	}

	isVisible(vantage) = {
		return(self.findContainer(Me) <> []);
	}

	findContainer(vantage) = {
		local loc, tmp;

		loc := vantage;
		while (loc <> nil) {
			tmp := self.findContainerDown(loc);
			if (tmp <> []) return tmp;
			loc := loc.location;
		}
		return([]);
	}
	findContainerDown(obj) = {
	    	local i, lst, len, result;
		result := [];
	    	if (not isclass(obj, openable)
			or (isclass(obj, openable) and obj.isopen)
			or obj.contentsVisible) {

			lst := obj.contents;
			len := length(lst);

			for (i := 1 ; i <= len ; ++i) {
				if (lst[i] = self) result+= obj;
				else result += self.findContainerDown(lst[i]);
			}
		}
		return (result);
	}
;

class drink: liquid
	verDoDrink(actor) = {
		self.verDoEmpty(actor);
	}
	doDrink(actor) = {
		self.findContainer(actor)[1].ioDrinkFrom(actor, self);
	}
	drinkme(actor) = {
		"Mmmm.  That was delicious.\n";
	}
	verDoDrinkFrom(actor, iobj) = {
		if (iobj.liquidcontents <> self) {
			"But there is no <<self.sdesc>> in <<iobj.thedesc>>.  You must be
			terribly confused.";
		}
	}
	doEat( actor ) = {
		"You should drink <<self.sdesc>>, not eat it.";
	}
;

class poisonousdrink: drink
	isPoisonous = true
	drinkme(actor) = {
		"\^But <<self.thedesc>> is terribly poisonous.  Don't you ever pay any
		attention to what your mother told you?  I guess you'll never learn.\b";

		die();
	}
;

class liquidcontainer: ouritem
	sdesc = {
		self.bdesc;
		if (self.liquidcontents) {
			" of ";
			self.liquidcontents.sdesc;
		}
	}
	thebdesc = { "the <<self.bdesc>>"; }
	abdesc = { "a <<self.bdesc>>"; }
	ldesc = { self.lldesc; }
	lldesc = {  
		"\^<<self.thebdesc>> ";
		if (self.liquidcontents) "contains <<self.liquidcontents.sdesc>>. ";
		else "is empty. ";
	}

	liquidcontents = nil

	findContainer(actor) = { return( [] + self);}

	verIoDrinkFrom(actor) = {
		if (self.liquidcontents = nil)
			"You can't drink from an empty container!";
	}
	ioDrinkFrom(actor, dobj) = {
		self.liquidcontents.drinkme(actor);
		self.empty(nil);
	}
	verDoDrink(actor) = {
		if (self.liquidcontents=nil)
			"You can't drink from an empty container!";
		else
			self.liquidcontents.verDoDrinkFrom(actor, self);
	}
	doDrink(actor) = {
		self.ioDrinkFrom(actor, self.liquidcontents);
	}
	verDoEmpty(actor) = {
		if (self.liquidcontents = nil)
			"\^<<self.thedesc>> is already empty.";
	}
	doEmpty(actor) = {
		"You pour <<self.liquidcontents.thedesc>> onto the ground, and it
		is quickly absorbed. ";
		self.empty(nil);
	}
	empty(fully) = {
		self.contents := self.contents - self.liquidcontents;
		self.liquidcontents := nil;
		caps();	"\n<<self.thedesc>> is now empty. ";
	}
	emptyquietly(fully) = {
		self.contents := self.contents - self.liquidcontents;
		self.liquidcontents := nil;
	}
	verIoEmptyFrom(actor) = {
		self.verDoEmpty(actor);
	}
	ioEmptyFrom(actor, dobj) = {
		self.doEmpty(actor);
	}
	verDoEmptyInto(actor, iobj) = {
		if (self.liquidcontents = nil)
			"There's nothing in <<self.thedesc>> to empty out.";
	}
	verDoFillWith(actor, iobj) = { self.verIoEmptyInto(actor); }
	verIoEmptyInto(actor) = {
		if (self.liquidcontents <> nil) {
			"You can't pour anything into <<self.thedesc>> until you
			empty it.";
		}
	}
	ioEmptyInto(actor, dobj) = {
		local origcontainer;
		origcontainer := dobj.findContainer(actor)[1];

		self.fill(origcontainer.liquidcontents);
		origcontainer.empty(nil);
	}
	fill(liquid) = {
		self.contents := self.contents + liquid;
		caps();	"\n<<self.thedesc>> now contains <<liquid.sdesc>>. ";
		self.liquidcontents := liquid;
	}
	doEat( actor ) = {
		"Eating a container?  Come, now. ";
	}
;

class ourfooditem: ouritem, fooditem
    isPoisonous = nil
    isGnuEdible = true
    doEat( actor ) = {
	if (self.isPoisonous) {
		"\n\^<<self.thedesc>> did not agree with you at all.  In fact,
		it seems to have created several new holes in your stomach, that,
		you suspect (during those last fleeting moments of your life),
		shouldn't be there.\b";
		die();
	}
	else {
	        self.eatme(actor);
	        global.lastMealTime := global.lastMealTime - self.foodvalue;
	        self.moveInto( nil );
	}
    }
    eatme(actor) = { "That was delicious! "; }
    foodvalue = { return( global.eatTime ); }
    verDoFeedTo(actor, io) = {}

    newenergy = 2
;

class ourswitchitem: switchItem, ouritem
	verDoFlip(actor) = {}
	doFlip(actor) = {
		self.isActive := (not self.isActive);
		"You flip <<self.thedesc>> to ";
		if (self.isActive) "on"; else "off";
		".\n";
	}
;

strObj: basicStrObj
	verDoSay(actor) = {}
	doSay(actor) = {
		"\bYou say \""; say(self.value); "\".\n";
		louis.actorSaid(actor,self.value); /* Tell Louis sound came from computer. */
	}
;

class decorativetree: ourdecoration
	sdesc = "tree"
	noun = 'tree'
	verDoClimb(actor) = {
		"Your sheltered life in the plains of Western Unnkulia never prepared
		you for climbing trees, and it would be a bad idea to start learning
		such dangerous sports this late in life.";
	}
;

class unreachable: object
	isReachable(actor) = { return nil; }
;

class unlisted: ourthing
	isListed = nil
	doTake( actor ) = {
		self.isListed := true;
		pass doTake;
	}
;

/*
 *	Procedures
 */

changescore: function( delta ) {
	incscore(delta);
	if (delta < 0)
		"\b*** Your score has just gone down! ***\b";
	else
		"\b*** Your score has just gone up! ***\b";
}

/* TADS own random number generator will never generate the same answer
 * to rand(2) twice in a row.  Maybe its higher order bits are better?
 */

myrand: function(x) {
		return (((rand(16 * x) - 1) / 16) + 1);
}

randomelement: function (l) {
	local r;

	if (length(l) > 0) {
		r := myrand(length(l));
		/* say(r); */
		return (l[r]);
	}
	else return nil;
}

modulo: function(x,y) {
	return(x-y*(x/y));
}

existsfood: function(l) {
	local i;

	i := length(l);
        for(i; i>0; i--) {
	   if (l[i].isGnuEdible) return true;
	}
	return nil;
}

	
grabfood: function(l) {
	local i, food, foodlist;

	foodlist := [];
	i := length(l);
        for(i; i>0; i--) {
	   if (l[i].isGnuEdible) foodlist += l[i];
	}
	food := randomelement(foodlist);
	food.moveInto(nil);	
	return(food);
}

instname: function () {
	local lst, l, n;
	lst := [
		'Less Convincing'
		'Legislatively Corrupted'
		'Logically Confused'
		'Lab Culture'
		'Low Calorie'
		'Lesser Criminal'
		'Largely Carnivorous'
		'Legally Challenged'
		'Lamentably Crippled'
		'Ludicrously Cheezy'
		'Laughably Crude'
	];
	n := 1 + modulo(global.turnsofar, length(lst));
	say(lst[n]);
}

