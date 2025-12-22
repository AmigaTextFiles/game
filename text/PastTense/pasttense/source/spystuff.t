spy: Female, Actor
	sdesc = "animal rights activist"
	noun = 'spy' 'contact' 'woman' 'lady' 'girl' 'activist' 'agent'
	adjective = 'animal' 'rights' 'secret'
	location = blueRoom
	actordesc = {
		"There <<t.is>> some kind of animal rights activist preaching here.";
	}
	listendesc = {
		"\"Canadian geese need to fly south in the winter.\" ";
	}
	moveDaemon = {}
	actorAction(v, d, p, i) = {
		if ((v = putVerb) and (d = tofu) and (p = inPrep) and (i = river)) {
			self.spyMsg;
			exit;
		}
		else
		{
			self.aamessage(v, d, p ,i);
			exit;
		}
	}
	spyMsg = {
		if (Me.location = spy.location) {
			P(); I();
			if (not (spy.knows)) {
				"The animal rights activist <<t.winks>> and <<t.says>>, 
				\"I almost didn't recognize you; that's a pretty good disguise you're
				wearing.  If I didn't know better I'd say that you just got out of bed.
				Haha! Give me the formula and we can get out of here.\" ";
				spy.knows := true;
			}
			else "The animal rights activists <<t.winks>> at you slyly. ";
		}
	}
	
	verIoGiveto(actor) =  {}
	ioGiveto(actor, dobj) = {
		if ((dobj = ampoule) and (spy.knows)) {
			ampoule.movein(nil);
			"The animal rights activist quickly <<t.pockets>> the ampoule and <<t.whispers>>, 
			
			\"Good job, Pritel.\" ";
			spy.movein(nil);
			
			
			
		incscore( 10 );
		"\b\b";
		I();
	    "You <<t.follow>> the twisty maze of urban streets that <<t.leads>> to your apartment
	    complex, secure in the knowledge that thanks to the work of honorary secret agents like you,
	    the citizens of the free world <<t.can>> breath easily.  Half an hour later you
	    <<t.are>> at home in bed, catching up on much needed sleep. ";
	    "\b\b";
	    
	    terminate();
	    quit();
	    abort;

			
			
		}
		else {
			"In a loud voice the woman <<t.says>>, 
			\"I'm sorry, I'm not authorized to accept donations for our organization.\" ";
		}
		
	}

	verDoAskabout(actor, io) = {}
	doAskabout(actor, io) = {
		if (spy.knows) {
			if (io = ampoule)
				"\"Our spies say that Dr.\ Wang-Chung has created some sort
				of disease that has the potential to destroy all human life on the continent.\" ";
			else
				"The woman mumbles that she isn't much interested in 
				talking about <<io.objthedesc(actor)>>. ";
		}
		else
			"The woman ignores you pointedly. ";
	}

	verDoTellabout(actor, io) = {}
	doTellabout(actor, io) = {
		if (io = ampoule)
			"\"Our spies say that Dr.\ Wang-Chung has created some sort
			of disease that has the potential to destroy all human life on the continent.";
		else
			"The woman ignores you pointedly. ";
	}

	verIoShowto(actor) = {}
	ioShowto(actor, dobj) = { self.doAskabout(actor, dobj); }

	doSmell(actor) = { "Don't be rude."; }
	verDoRub(ator) = { "Don't be rude."; }
	
	verDoAttackwith(actor, io)  = {}
	
	doAttackwith(actor, io) = { "Don't be rude."; }

	
	
;

blueRoom: Room
	sdesc = "The Cathedral"
	ldesc = "You <<t.are>> in a dance club. "
	noun = 'blueroom'
;

tofu: Appendage, Item
	sdesc = "chunky tofu"
	noun = 'tofu'
	adjective = 'chunky'
	isknownto(actor) = {return true;}
	location = spy
;

river: Appendage, Container
	sdesc = "river"
	noun = 'river'
	isknownto(actor) = {return true;}
	location = spy
;
