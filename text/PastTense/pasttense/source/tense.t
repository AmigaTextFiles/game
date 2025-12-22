#include <world.t>
#include <tensemod.t>
#include <dict.t>
#include <instruct.t>
#include <adhint.T>
#include <hints.T>
#include <me.t>
#include <apart.t>
#include <lab.t>
#include <jmpstick.t>
#include <spystuff.t>


replace userinit: function
{
	"\b\b";
	
	if (global.restarting = nil) {
		intro();
	}

	setit(package);

	notify(magic, &makeMagic, 0);

	notify(spy, &moveDaemon, 0);
	
	global.lastactor := Me;

	Me.location.enter(Me);
	
//	if (global.playtesting) {handwarmer.state := -1;}
}

replace terminate: function
{
	// called just before the game ends
	// print "thanks for playing ..." here
	"Thanks for playing. Comments, questions? <mailto:nault.3@osu.edu>";
}

replace intro: function
{
	// print the game's intro
	"Quiet Room";
	P(); I();
	"All around you monks in red robes sat in deep meditation.  
    Everything was silent except for the breeze moving in the tall grass
    and the stream trickling through the rock garden.  The Master
    struck a tremendous gong with a chicken bone and you became
    enlightened!
	\b
	\t\t\t * * *
	\b";
	I();
	"You cracked open your left eye and peered at your alarm clock:
	 3:37 A.M.  There was your doorbell ringing again.  And again...  
	You fell out of bed and shuffled to the front door of your apartment.  
	There was a man outside on the landing with a clipboard in 
	his hand and a package under his arm. ";
	P(); I();
	"\"The Asian elephant never knew snow,\" the man said.  He looked at you
	expectantly, as if waiting for a reply. ";
	P(); I();
	"\"Erp, those were my grandmother's dieing words!\" you said, wondering how this stranger
	 could have known such an intimate detail about your family history. ";
	P(); I();
	"\"Well, it's actually supposed to be 'Abraham's grandmother flew like a bird', 
	but that's close enough. Special delivery for Agent Pritel.\" He winked at you slyly,
	put the package into your hands, wished you a good day, and disappeared. ";
	P(); I();
	"You had a vague feeling that something was not quite right, 
	but you weren't awake enough to figure out what was 
	bothering you. You  pushed the feeling aside, dropped the package onto your sofa,
	and returned to your bedroom. ";
	P(); I();
	"Wait a minute...  your name wan't Agent Pritel...
	\b";
	versioninfo(); "\b";
	
	"For instructions, type \"instructions\".\n
	Read footnotes "; note(global); " with the note command;
	e.g., type \"note 1.\"\n
	Use the adaptive hint system by typing \"hint\".\b
	Toggle paragraph spacing by typing \"space\".\n
	Toggle paragraph indentation by typing \"indent\".\n
	Toggle score notification by typing \"notify\".\b
	Type \"tense\" to shift the story between the past and the present tense.\b\b";

}


replace versioninfo: function
{
	"\bPAST TENSE:
	An Interactive Intrigue
	\nCopyright (c) 1996 by Dave Nault
	\nDeveloped with TADS, the Text Adventure Development System.\b";

	"This product includes portions of WorldClass, a TADS class
	library developed by David M.\ Baggett for \(ADVENTIONS\).\n
	WorldClass is Copyright (C) 1994 by David M.\ Baggett.\n";

	classlibrary.info;
}

modify global
	indent = true			// indent paragraphs by default
	paragraphspacing = true		// blank between paragraphs by default

	maxscore = 100			// this many points possible
	statuslinewidth = 74		// maximum status line width

	debugreach = nil		// print debugging text in blocksreach?

	silentincscore = nil		// should incscore announce score changes?

	playtesting = true		// allow playtesting commands
	playtestfailtime = -999		// initial value must not be a valid ticks value

	searchisexamine = true		// "search ___" = "examine ___"?

	nondeterministic = true		// be random for real
	
	pasttense = true
	
//	verbose = true

	footnote = {
		"Footnote markers are numbers enclosed in square brackets.";
	}	
;

xyzzyVerb: Soloverb
	sdesc = "xyzzy"
	verb = 'xyzzy'
	soloaction(actor) = { 
		"http://www.users.interport.net/~eileen/design/xyzzynews.html\n";
	}
;

knockonVerb: Verb
	sdesc = "knock on"
	verb = 'knock on' 'knock at' 'knock'
	doAction = 'Knockon'
	requires = [[&cantouch]]
;

rubVerb: Verb
	sdesc = "rub"
	verb = 'rub'
	doAction = 'Rub'
	requires = [[&cantouch]]
;

replace class Readable: Thing
	readdesc = { self.ldesc; }
	verDoRead(actor) = {}
	doRead(actor) = { self.readdesc; }
;

modify spaceVerb	// just fixing a bug in WC where this has no effect
	soloaction(actor) = {
		if (global.paragraphspacing) {
			"Now single-spacing text.";
			global.paragraphspacing := nil;
		}
		else {
			"Now double-spacing text.";
			global.paragraphspacing := true;
		}

		abort;	/* doesn't count as a turn */
	}
;

modify Thing
	verDoKnockon(actor) = { self.verDoX(actor, knockonVerb); }
	verDoRub(actor) = { "Now why would you want to rub that? "; }
	doInspect(actor) = {
		self.ldesc;
		if (self.iswet) {
			" \^<<self.thedesc>> <<t.looks>> as if it <<t.has>> taken a bit of a shower recently. ";
			self.iswet := nil;
		}
	}
	
	itemcontents(actor, loctypes) = {
		local	i, l, len, r := [];

		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++) {
			if (loctypes = nil or find(loctypes, l[i].locationtype) <> nil) {
				if ((isclass(l[i], Item)) and (not (isclass(l[i], Appendage))))
					r += l[i];
				else
					r += l[i].itemcontents(actor, nil);
			}
		}

		return r;
	}
;

modify class Door
	verDoKnockon(actor) = {}
	doKnockon(actor)= { "Knock Knock Knock!"; }
;

replace sleepVerb: Soloverb
	sdesc = "sleep"
	verb = 'sleep'
	soloaction(actor) = {
		"%You% <<t.are>> too exited to sleep. ";
	}
;

notifyVerb: Soloverb
	verb = 'notify'
	sdesc = "notify"

	soloaction(actor) = {
		"Ok, you will ";
		if (global.silentincscore = true) {
			"now";
			global.silentincscore := nil;
		}
		else {
			"not";
			global.silentincscore := true;
		}
		" be notified when you score changes. ";
		abort;
	}
;
tenseVerb: Soloverb
	verb = 'tense'
	sdesc = "tense"

	soloaction(actor) = {
		"Ok, the story will now be told in the ";
		if (global.pasttense = true) {
			"present";
			global.pasttense := nil;
		}
		else {
			"past";
			global.pasttense := true;
		}
		" tense. ";
		abort;
	}
;
infoVerb: Soloverb
	verb = 'info' 'information' 'help'
	sdesc = "information"

	soloaction(actor) = {
		"\bFor instructions, type \"instructions\".\n
		Read footnotes "; note(global); " with the note command;
		e.g., type \"note 1.\"\n
		Use the adaptive hint system by typing \"hint\".\b
		Toggle paragraph spacing by typing \"space\".\n
		Toggle paragraph indentation by typing \"indent\".\n
		Toggle score notification by typing \"notify\".\b
		Type \"tense\" to change the story between the past and present tense.\n";
	}
	
;

magic: Thing
	makeMagic = {
	
		// deal with the handwarmer in relation to the popcorn
	
		popcorn.flying := nil;
		
		if ((2 < handwarmer.state) and (handwarmer.state < 7)) {
			handwarmer.temp := 'hot';
		}
		else if (handwarmer.state > 0) {
			handwarmer.temp := 'warm';
		}
		else handwarmer.temp := 'cool';
		
		if ((handwarmer.iscontained((Me.location), 'in'))
					and (handwarmer.temp = 'hot')) {
			P(); I(); "The handwarmer <<t.is>> radiating a 
			tremendous amount of heat. ";
		}
	
		if (handwarmer.temp <> 'cool') {
			if (handwarmer.location = Me) {
				
				if (handwarmer.state = 9) {
					"\bThe handwarmer <<t.is>> getting VERY hot! ";
				}
				else if (handwarmer.state = 8) {
					"\bThe handwarmer <<t.is>> scorching hot! 
					You <<t.arent>> going to be able to hold it too much longer! ";
				}
				else if (handwarmer.state = 7) {
					"\bYEEEAAOOOOWWW!  The handwarmer <<t.is>> too hot to handle!
					\b Dropped.\n";
					handwarmer.movein((Me.location));
				}
			}
			
			else if ((handwarmer.location = popcornBag) 
					and (kernels.location = popcornBag)) {
				if (handwarmer.temp = 'hot') {
				
					if (popcornBag.isopen) {
						if ((Me.location = popcornBag.location)
						or (popcornBag.location = Me)) {
							"\bPop! pOP! pOp! POP! pop! 
							The air <<t.is>> filled with a storm of flying popcorn! ";
							popcorn.movein(Me.location);
						}
						else {
							popcorn.movein(popcornBag.location);
						}
						popcorn.flying := true;
						kernels.movein(nil);
					}
					else {
						if ((Me.location = popcornBag.location)
						or (popcornBag.location = Me)) {
							"\bPop! pOP! pOp! POP! pop! 
							You <<t.hear>> the sound of popping corn 
							inside the bag. ";
						}
						kernels.movein(nil);
						popcorn.movein(popcornBag);
					}
				}
			}
			handwarmer.state := handwarmer.state - 1;
		}
		
		// deal with the water in relation to the burner
		
		if (water.location = beaker) {
		
			if (Me.location = lab) {
				// display text
				if (water.state = 2) {
					P(); I();
					"The water in the beaker <<t.is>> simmering. ";
				}
				else if (water.state = 3) {
					P(); I();
					"The water in the beaker <<t.is>> boiling. ";
				}
			}
			
			if ((handwarmer.location = beaker) and (water.state = 3)) {
				// recharge handwarmer
				handwarmer.state := -1;
			}
			
			if ((beaker.iscontained(burner, 'on')) and (burner.isactive)) {
				
				// water heats up
				if (water.state < 3) {
					water.state := water.state + 1;
				}
			}
			
			else {
				// beaker not on burner, etc. so water cools off
				if (water.state > 0) {
					water.state := water.state - 1;
				}
			}
		}
		
		// deal with the popcorn bag in relation to the burner
		
		if ((popcornBag.iscontained(burner, 'on')) and (burner.isactive)) {
				
			"The bag of microwave popcorn <<t.bursts>> into flames! ";
			if (kernels.iscontained(popcornBag, 'in')) {
				"\bPop! pOP! pOp! POP! pop! 
				The air <<t.is>> filled with a storm of flying popcorn! ";
				popcorn.movein(Me.location);
				kernels.movein(nil);
				if (length(popcornBag.contents)) {
					popcornBag.contents[1].moveon(burner);
				}
				popcornBag.movein(nil);
			}
		}
		
		// deal with misc flamable items
		
		if ((length(burner.contents)) and (burner.isactive)) {
			if (burner.contents[1].isflamable) {
				"\^<<burner.contents[1].thedesc>> <<t.bursts>> into flames! ";
				burner.contents[1].movein(nil);
			}
		}
	}
;


