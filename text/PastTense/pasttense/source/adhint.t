/*	This program is Copyright (c) 1994 David Allen.  It may be freely
	distributed as long as you leave my name and copyright notice on it.
	I'd really like your comments and feedback; send e-mail to
	allen@viewlogic.com, or send us-mail to David Allen, 10 O'Moore Ave,
	Maynard, MA 01754.
	
	Changes/additions to this file have been made by Stephen Granade, and all
	such changes are documented with comments ending in my initials.  The
	copyright still belongs to David Allen; I release any rights I might have
	to him.  I, too, would appreciate comments at sgranade@obu.arknet.edu. 

	This is an "adaptive hint" system.  This file contains the general code
	needed for a hint system which looks at the game state to find the best
	hint to give.  See the file "adhint.doc" for more detailed information. 

	Puzzle, hint and clue classes 

	The puzzle is the most important object.  Calls in the main code can mark
	a puzzle as seen (to begin its life) or as solved (to end its life).  
	Before a puzzle's life begins, all of the puzzles listed in its "prereqs"
	list must be solved.  During its life, a request for hints may offer a 
	hint on the puzzle.  If this puzzle might be "solvable" when other 
	puzzles are also solvable, the function ahPromptHint, below, asks the
	user to select the puzzle for hinting; the puzzle object must define a
	method called title to print the name of the puzzle. 
	
	For the new version of the "review" verb, a title MUST be defined for all
	puzzles.  The variable reviewflag is used for the "review" verb, and is
	further explained below.  SG
*/
	
class ahPuzzle: object
	solved = nil
	seen = nil
	prereqs = []
	reviewflag = nil
	value = 1
	solve = {
		if ((global.playtesting) and (not self.solved))
			"(You have solved the <<self.ahDesc>> puzzle)\n";
		self.solved := true;
		incscore(self.value);
	}
	see = {
		if ((global.playtesting) and (not self.seen))
			"(You are aware of the <<self.ahDesc>> puzzle)\n";
		self.seen := true;
	}
		
//	Normally, a puzzle becomes solvable for hinting when all of its
//	prerequisites are solved, that is, an AND relationship.
	
	ahAvail = {
		local len := length (self.prereqs), i;
		if (len > 0) for (i:=1; i<=len; i++)
			if (not (self.prereqs[i].solved)) return (nil);
		return (true);
	}
;

//	The "clue" object is used to remember whether a particular event has
//	occurred.  For example, when an object is seen, or when a particular
//	mistake is made.

class ahClue: object
	seen = nil 
	see = {
		if ((global.playtesting) and (not self.seen))
			"(You see the <<self.ahDesc>> clue)\n";
		self.seen := true;
	}
;

//	The "hint" object is the actual text of a hint.  It must have an owner
//	set to the puzzle for which it is a hint.  If some condition besides 
//	having the puzzle "solvable" must be satisfied before the hint is given,
//	the ahAvail function must be used to return true if the hint is available
//	and nil otherwise.  Finally, the "ahTell" method must be defined; it must
//	print the text of the hint.
//
//	iHintNum is set for compatibility with the new class ahHintList.  ahGive
//	has been altered so that it sets its owner puzzle's reviewflag.  SG
	
class ahHint: object
	seen = nil
	owner = nil
	iHintNum = 1
	ahAvail = {
		return (true);
	}
	ahGive = {
		self.seen := true;
		self.iHintNum++;
		owner.reviewflag := true;
		self.ahTell;
	}
;


//	The "hintlist" object is actually a combination of several hints which are
//	designed to be given in a particular order, preventing the necessity of
//	having several separate hint objects.  ahTell should be set to an array
//	of hints.  SG

class ahHintList: ahHint
	ahTell = []
	ahGive = {
		owner.reviewflag := true;
		say(self.ahTell[self.iHintNum]);
		"\n";
		self.iHintNum++;
		if (self.iHintNum > length(self.ahTell))
			self.seen := true;
	}
;


//	Hint verb and auxilliary functions

//	A function to list all the titles of a list of puzzles, then input a
//	selection.  It returns the chosen selection.  SG

ahListTitles: function (puzzles) {
	local i, len := length(puzzles);
	for (i := 1; i <= len; i++) {
		if (i < 10) "\ ";
		"<<i>>.\ \ <<puzzles[i].title>>\n";
	}
	do {
		"#\ ";
		i := cvtnum(input());
		if ((i < 1) or (i > len)) "That was not a valid topic.\n";
	} while ((i < 1) or (i > len));
	return (i);
}


//	Called from several places, this function prints a random hint related
//	to the puzzle passed in to it.  Because the puzzle was selected, there
//	must be at least one available hint which hasn't been given yet.

ahGiveHint: function (puzzle) {
	local h, hints:=[];
	for (h:=firstobj (ahHint); h<>nil; h:=nextobj(h,ahHint))
		if ((h.owner = puzzle) and (not h.seen) and (h.ahAvail))
			hints += h;
	hints [rand (length (hints))].ahGive;
}


//	Called from the hint verb, below, when there is more than one puzzle
//	"solvable", this function prompts the user to choose one of the
//	solvable puzzles.  The title method of the puzzle object is used to
//	display the name of the puzzle so the user can select.  The function
//	simply exits without displaying a hint if an out of range selection
//	is made from the numbered list.
//
//	This function has been simplified with the addition of the ahListTitles
//	function.  SG

ahPromptHint: function (puzzles) {
	"For which puzzle would you like a hint?\n";
	ahGiveHint (puzzles[ahListTitles(puzzles)]);
}


//	This is the verb that makes it all happen.  The action routine checks to
//	see how many puzzles are solvable.  If none, it prints a message to that
//	effect.  If there are solvable puzzles, but none have available clues,
//	it prints a message to that effect.  If there is one puzzle with available
//	clues, it prints one.  If multiple puzzles have available hints, it builds
//	a list for the player to choose from.

hintVerb: Systemverb, Soloverb
	verb = 'hint' 'hints'
	sdesc = "hint"
	issysverb = true
	firstever = true
	
	soloaction(actor) = {
		local len, o, p:=[], h, i, somesolvable := nil;

		if (self.firstever) {
			"(You can use the \"review\" command to see hints you have already
			gotten)\n";
			self.firstever := nil; }

//	Add puzzle o to list p if solvable and has hints available

		for (o:=firstobj (ahPuzzle); o<>nil; o:=nextobj(o,ahPuzzle))
			if ((not o.solved) and (o.seen) and (o.ahAvail)) {
				somesolvable := true;
				for (h:=firstobj (ahHint); h<>nil; h:=nextobj(h,ahHint))
					if ((h.owner = o) and (not h.seen) and (h.ahAvail)) {
						p += o; break; } }

//	If no puzzles or all used, say so; if one, give a hint; if more 
//	than one, ask which topic to hint about

		len := length (p);
		if (len = 0) {
			if (not somesolvable) "Pay attention to everything around you 
				and be sure to examine everything in room descriptions. ";
			else "You have used all the hints which are available right now. ";
		}
//		else if (len = 1) ahGiveHint (p[1]);
		else ahPromptHint (p);

//	Using this command does not count as a turn

		abort;
	}
;


//	The "review" verb lets a player look back at the hints already received.
//
//	This verb no longer prints out all the hints given; instead, it prompts the
//	player for a particular puzzle.  If a puzzle's reviewflag has been set,
//	then a hint to that puzzle has been given, and it can be included in the
//	review list.  SG

reviewVerb: Systemverb, Soloverb
	verb = 'review'
	sdesc = "review"
	
	soloaction(actor) = {
		local h, puzzles := [], final_puzzle, i;
		for (h:=firstobj (ahPuzzle); h<>nil; h:=nextobj (h, ahPuzzle))
			if (h.reviewflag) puzzles += h;
		if (length(puzzles) = 0) {
			"You have not received any hints yet.";
			abort;
		}
		"Which hints do you want to review?\n";
		final_puzzle := puzzles[ahListTitles(puzzles)];
		"\b\nYou have received the following hints for that puzzle:\n\b\n";
		for (h:=firstobj (ahHint); h<>nil; h:=nextobj (h, ahHint))
			if (h.iHintNum > 1 and h.owner = final_puzzle) {
				if (isclass(h, ahHintList) and h.iHintNum > 1) {
					for (i := 1; i < h.iHintNum; i++) {
						say(h.ahTell[i]); "\n\b\n";
					}
				}
				else if (h.seen) { h.ahTell; "\n\b\n"; }
			}
		abort; };


//	Auxilliary function for scoring: display the number of hints used

ahScoreRank: function (x) {
	local count := 0, h;
	for (h:=firstobj (ahHint); h<>nil; h:=nextobj (h, ahHint)) {
		count += h.iHintNum - 1;
	}
	if (count = 1) "You have used one hint to achieve this score. ";
	if (count > 1) "You have used <<count>> hints to achieve this score. ";
}

