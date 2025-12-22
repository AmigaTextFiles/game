/*
 * WorldClass
 * Copyright (C) 1994 by David M. Baggett
 *
 * Please read the license before using this code.
 *
 * Assumed screen format: 50x132+ character screen, 8-space tabs
 *
 * Contributors:
 *
 *	- Paul Francis Gilbert <s9406702@yallara.cs.rmit.oz.au>
 *	  has contributed code, suggested many important
 *	  improvements, and has written a WorldClass manual.
 *
 * Where a contibutor's code has been included, the contributor's
 * name appears in an accompanying comment.
 *
 * When someone reports a bug and I fix it, I now label the explanation
 * of the fix in the modification history with the bug reporter's name.
 *
 * If you have contributed and I have left your name off, send me
 * mail and I'll add you.  I do not intened to slight anyone, but
 * I do make mistakes.
 *
 *----------------------------------------------------------------------------
 *
 * Modification History
 *
 *  9-Nov-93	dmb	Started.
 * 16-Feb-94	dmb	Deemed worthy of "version 1.0" monnicker.
 * 28-Feb-94	dmb	Got rid of vocabulary in classes.  Having them
 *			there confuses the disambiguator, thereby
 *			causing "Which button do you mean, the launch button,
 *			or the launch button?" type problems.
 * 13-Mar-94	dmb	Extended verb requirements to include prep.
 *  1-Jun-94	dmb	Changed listcontentsX -- added "alwaysname" method
 *			to listable sounds, etc. so that things that
 *			don't appear in visual listings can still be
 *			named (instead of being referred to as "something").
 * 22-Aug-94	dmb	A few minor bugs fixed.
 *  5-Sep-94	dmb	Added 'inside' and 'outside' to inPrep and outPrep.
 *			Added doEnter and doExit to Chair and Ledge.
 *			Added _here_ parameter to listcontentsX to fix
 *			bug with Nestedroom.
 *  6-Sep-94	dmb	Changed the definition of doDefault and ioDefault
 *			in Verb to handle Nestedrooms better.
 *			Updated some verb's vocabulary to extend the set of
 *			prepositions allowed.  (E.g.: lookinVerb)
 *  7-Sep-94	dmb	Added global.searchisexamine.
 * 13-Sep-94	dmb	Revised Chair and Stool again.
 * 18-Sep-94	dmb	Moved some code from init to userinit.	This code
 *			handles the standard game start tasks, like 
 *			printing the room description for the player's
 *			initial location.  The old code didn't work with
 *			initial locations that were Nestedrooms -- the
 *			new code does.
 *
 *			As a result, the procedure now is to *replace*
 *			userpreinit and userinit -- before they weren't
 *			provided at all.  Second, there is no requirement
 *			that the starting location be called "startroom";
 *			the default userinit routine just looks at the
 *			location, locationtype, and position fields of
 *			Me to figure out where the player starts out.
 *			[v1.1]
 * 24-Sep-94	dmb	Added doAction = 'Lock' to lockVerb.
 *			Added doAction = 'Unlock' to unlockVerb.
 *			Changed "I can't imagine what you're referring to."
 *			in Verb.cantReach to "You don't know what that is."
 *			Changed Thing.isknownto slightly.
 *			Changed Player.passgen to better handle "actor, take
 *			item from me" and related commands.
 *			Added allowedverbs to Distant.
 *			Added roomdescprop to Ground, Walls, and Ceiling.
 *			Fixed bugs in Attachpoint that prevented plugable
 *			and tieable from working properly.
 *			Put commas in lists where necessary to disambiguate
 *			& operator, for TADS 2.2.
 *			[v1.1.1]
 * 28-Sep-94	dmb	Removed no-longer-needed XOuthide function.
 *			Debugverbs are now disabled unless global.playtesting
 *			is set to true.	 Cleaned up the standard Debugverbs
 *			a bit.
 *			Updated maxinlist and mininlist to return nil when
 *			given an empty list or nil.
 *			Improved comments in the first third of the file.
 *			[v1.1.2]
 *  1-Oct-94	dmb	Added code to print "(trying to ___ the ___ first)"
 *			when a verb requirement fails.	E.g.,:
 *
 *				>eat key
 *				(trying to take the key first)
 *
 *				The key is stuck in the lock.
 *
 *			[v1.1.3]
 * 11-Oct-94	dmb	Separated out most of the code in die and moved
 *			it to end, which is useful for demos, where you
 *			have to end the game, but not because of player 
 *			death.
 * 12-Oct-94	dmb	Spell-checked all double quoted text and fixed
 *			the typos.
 *
 *			Added a check for global.silentincscore to incscore.
 *			By setting global.silentincscore to true, you can
 *			disable the WorldClass default behavior, which is
 *			to tell the player when his score has gone up.
 *
 *			Made changes to allow footnotes with predefined
 *			numbers (i.e., hardcoded footnum values) to
 *			coexist peacefully with footnotes numbered at
 *			run-time.  (Previously, the run-time footnote 
 *			number could assign a number that was already used
 *			by a "hand-numbered" footnote.)
 *
 *			Added methods smellaround, listenaround and
 *			feelaround to Room.  Nestedroom overrides these.
 *			These are called when the player types "smell"
 *			"listen" and "feel" (or "feel around") without
 *			a direct object.  This change fixes a bug, where
 *			listable sounds etc. would not get listed if
 *			the player "listen"'ed while in/on a Nestedroom.
 *
 *			Added new class Floor, for use when you want
 *			to do something fancy with the floor that Ground
 *			can't handle.  Ground now inherits from Floor.
 *			Added roomdescprop to Everywhere.
 *
 *			Nestedroom now passes ground, ceiling, and walls
 *			methods to its parent location.  I.e., Nestedrooms
 *			have the same ground, ceiling, and walls as their
 *			containing Rooms.
 *			[v1.1.4]
 * 16-Oct-94	dmb	Fixed a bug where "if (isclass(obj, Floor))"
 *			was run in verDoTakeX even if obj was nil.
 *			Corrected bogus reference to global.turnsofar.
 *			Changed note function to return the empty
 *			string so it can be used in <<...>> expressions
 *			within double quotes.
 *			[v1.1.5]
 * 25-Oct-94	dmb	Added verDoBreak to Thing.  Fixed a typo in
 *			Thing.verIoCleanwith. [Tom Koelman]
 *			[v1.1.6]
 *  2-Nov-94	dmb	Fixed a typo in Ledge.doEnter. [Duncan Anker]
 *  5-Nov-94	dmb	Added eatdesc to Edible.
 *			Added pullable and moveable to Switch.
 *			Added &cantouch to global.senses -- this is
 *			the list of senses used when an action fails,
 *			so that WorldClass can say "(trying to X the Y)"
 *			to let the player know which "atomic" action
 *			failed.
 *			Added a clause to Item.doTake to allow the 
 *			command "take X" or "take X <prep> Y" when the
 *			actor already has the Item, but the Item is not
 *			in the player's top level contents (i.e., not
 *			merely in a container the actor's carrying).
 *
 *			*** Last version for TADS 2.1 ***
 *
 *			[v1.1.7]
 *  6-Nov-94	dmb	Changed Room.statusLine to elide status lines
 *			that are longer than global.statuslinewidth
 *			with an ellipsis.
 *			Added [ver]DoClose [ver]DoOpen to Desk.
 *			[v1.1.8]
 *  7-Nov-94	dmb	Added check for obj = nil in Thing.blocksreach.
 *			Added actor parameter to Edible.eatdesc.
 *			Further revised Edible, and similarly revised
 *			Drinkable.
 *			Added multisdesc to Thing -- this just prints
 *			the sdesc text highlighted.
 *			Added #pragma C- at top of file.
 *			Added any = either to specialWords.
 *			Added Thing.construct and Thing.destruct to
 *			support dynamic objects.
 *  9-Nov-94	dmb	Removed actor parameter from message printed
 *			by Thing.verDoLookon to eliminate incorrect
 *			reflexives.
 *			Added to comment preceding Desk.
 *			Cleaned up Verb.checkCommon a bit.
 *			Corrected capitalization error in
 *			swVerb. [Paul Gilbert]
 * 11-Nov-94	dmb	Created CASE_INSENSITIVE flag.  (But you can't
 *			actually compile this file in case insensitive
 *			mode yet.)
 *
 *			Added support for indistinguishable objects:
 *			- Thing.listprops ........ created
 *			- Thing.listdesc ......... modified
 *			- Thing.listpluraldesc ... created
 *			- Thing.pluraldesc ....... created
 *			- listcontentsX .......... modified
 *			- indistinguishable ...... created
 *			- saynum ................. created
 *
 *			NOTE: Users must override pluraldesc for
 *			words like "box", "watch", etc. whose plurals
 *			are not formed by appending an "s".
 *			
 *			Two Things are indistinguishable (and will hence
 *			be listed as a unit with prepended number) if
 *			both have the same immediate superclass and
 *			both have isequivalent set to true.  (Actually,
 *			it's not quite this simple -- look at the
 *			indistinguishable function for details.)
 *
 *			NOTE: There seems to be a bug in TADS that prevents
 *			the new code from being very useful.  So don't 
 *			expect it to work right just yet.
 *
 * 			Removed old listcontents code.  (This code is now
 *			archived in the 1.1.7 freeze code.)
 *			Added a comment explaining Thing.seecontX and related
 *			methods.
 *			[v1.2.0]
 * 12-Nov-94	dmb	Added nondeterministic = true to global to make 
 *			the random number functions really random by
 *			default.
 *
 *			New feature: You can now use Thing.movingout and
 *			Thing.movingin to monitor movement of objects
 *			in and out of containers.  This makes it
 *			easy to define, for example, a magic box that
 *			curses every item moved into it (by any means),
 *			or a pedestal that triggers a trap when enough
 *			weight is taken off of it.
 *
 *			Note also that Thing.moveinto now returns a
 *			boolean indicating whether or not it succeeded.
 *			This is just for robustness; you should not
 *			have moveinto fail for any reason but an error.
 *
 *			Implementing this feature involved the following
 *			changes:
 *
 *			- Thing.movingin ............ created
 *			- Thing.movingout ........... created
 *			- Thing.moveinto ............ modifie
 *			- Thing.notifycontainers .... created
 *			- Holder.ioPutX ............. modified
 *			- Attachable.moveinto ....... modified
 *			- Attachable.doAttachto ..... modified
 *			- Clothing.moveinto ......... modified
 *			- Clothing.doWear ........... modified
 *			- Actor.moveinto ............ modified
 *			- Chair, Ledge, Stool:
 *			     doEnter, doGeton ....... modified
 *
 *			Added verDoLock and verDoUnlock to Thing.
 *			Changed the Lockable class to support these
 *			new methods.  IMPORTANT:  Previously, setting
 *			key = nil in Lockable meant that the Lockable
 *			could not be unlocked or locked.  Now this
 *			means that the Lockable *can* be locked and
 *			unlocked, and without any key.
 *			[v1.3.0]
 * 13-Nov-94	dmb	Fixed a bug in Thing.construct. [Mike Roberts]
 * 15-Nov-94	dmb	Fixed verSouthwest -> verGoSouthwest and
 *			verDown -> verGoDown.
 * 19-Nov-94	dmb	Fixed a typo in Actor.speech_handler. [Adam Thornton]
 * 21-Nov-94	dmb	Fixed a serious bug in Thing.moveinto.
 *			[v1.3.1]
 *  7-Jan-95	dmb	Moved meat of preparse into WorldClassPreparse.
 *			[v1.3.2]
 * 10-Feb-95	dmb	Added call to upper() in indistinguishable
 *			to make the comparison ignore case.
 *			[Carl Muckenhoupt].  [v1.3.3]
 */

// #define CASE_INSENSITIVE

//
// Parse this file using normal TADS operators
//
#pragma C-

	/*
	 * Functions the player will probably want to replace:
	 */

version: object;	// for backwards compat with old adv.t

versioninfo: function
{
       if (defined(version, &sdesc))
	       version.sdesc;
       else
	       "\(Generic\): An all-purpose adventure developed with
	       TADS and the \(ADVENTIONS\) WorldClass library. Version 0.\b

	       This product includes portions of WorldClass, a TADS class
	       library developed by David M.\ Baggett for \(ADVENTIONS\).\n
	       WorldClass is Copyright (C) 1994 by David M.\ Baggett.\n";

       classlibrary.info;
}
intro: function
{
       // print the game's intro
	"\b\b\b\b";
	"This is the introduction.  Prepare to play...\b";
	versioninfo(); "\b";
}
initrestart: function(parm)
{
	// initrestart - flag when a restart has occurred by setting a flag
	// in global.
	global.restarting := true;
}
init_statusline: function
{
	// put the status line in some initial state, like "0/0"
	setscore(0, 0);
}
score_statusline: function
{
	// update the status line with the current score.
	// The setscore builtin is useful here.
	setscore(global.score, global.turns);
}
score_and_rank: function
{
	// print current score and (optionally) the implied rank.
	// this default is pretty lame.

	"In a total of "; say(global.turns);
	" turns, you have achieved a score of "; say(global.score);
	" points out of a possible "; say(global.maxscore); ".\n";
}
terminate: function
{
	// called just before the game ends
	// print "thanks for playing ..." here
	"Thanks for playing this game!";
}
pardon: function
{
	"I beg your pardon? ";
}
turncount: function(parm)
{
	incturn();
	global.turns += global.turnspertick;
	global.ticks++;
	score_statusline();
}
incscore: function(amount)
{
	if (not global.silentincscore) {
		"\b";

		if (amount > 1)
			"*** Your score just went up by <<amount>> points. ***";
		else if (amount < -1)
			"*** Your score just went down by <<-amount>> points. ***";
		else if (amount = 1)
			"*** Your score just went up by a point. ***";
		else if (amount = -1)
			"*** Your score just went down by a point. ***";
	}

	global.score += amount;
	score_statusline();
}
savegame: function
{
       local savefile;

       savefile := askfile('File to save game in');
       if (savefile = nil or savefile = '')
	       "Failed. ";
       else if (save(savefile))
	       "Save failed. ";
       else {
	       "Saved. ";
       }
}
//
// Warn the player that he should save if he hasn't recently.
//
warnsave: function
{
	if (global.turns - global.lastsave > 5) {
		"This would probably be a good time to save
		the game.\bWould you like to save? (YES or NO) > ";

		if (yorn() = 1) {
			"\n"; savegame(); "\b";
		}
	}
}

//
// NOTE: DON'T REPLACE OR CHANGE PREINIT!
// Put game-specific preinit stuff in userpreinit.
//
preinit: function
{
	local	o, i;


	// Clear contents lists.  TADS does set them for us, but
	// there are bugs that sometimes cause it to miss some
	// objects.  So we blow away what it's done and do it "by
	// hand".
	for (o := firstobj(); o <> nil; o := nextobj(o))
		o.contents := [];

	// Init global and per-object lists.
	//
	// This includes putting objects in their containers'
	// contents lists.  Floating objects do not generally
	// appear in contents lists.  We handle Part objects
	// specially, though.
	//
	for (o := firstobj(); o <> nil; o := nextobj(o)) {
		// Rooms with no location go in TOP
		if (isclass(o, Room))
			if (not isclass(o, Nestedroom) and o.location = nil)
				o.location := TOP;

		// If non-Floating, put in location's contents list
		if (not isclass(o, Floating))
			if (o.location <> nil)
				o.location.contents += o;

		// Actors
		if (isclass(o, Actor))
			global.actorlist += o;

		// Move Parts into their locations' contents lists
		if (isclass(o, Part)) {
			if (o.partof <> nil) {
				if (o.partof.location <> nil)
					o.partof.location.contents += o;
				o.partof.parts += o;
			}
		}

		// Listable smells, sounds, and touches
		if (isclass(o, Listablesmell))
			global.listablesmelllist += o;
		if (isclass(o, Listablesound))
			global.listablesoundlist += o;
		if (isclass(o, Listabletouch))
			global.listabletouchlist += o;

		// Footnotes
		if (defined(o, &footnote)) {
			global.footnotelist += o;

			if (defined(o, &footnum))
				if (o.footnum <> nil)
					global.footavoid += o.footnum;
		}

		// Lightsources
		if (isclass(o, Lightsource)) {
			global.lightsources += o;
			o.properties += &litprop;
		}

		// Clothing that is worn must be 'in' its location
		if (o.isclothing and o.isworn) {
			o.setlocationtype('in');
			o.properties += &wornprop;
		}

		// Attachables that are already attached need to
		// have &attachedprop in their prop list
		// Also, we make sure the Attachpoints have the
		// object in its own attached list.
		if (isclass(o, Attachable) or isclass(o, Attachpoint)) {
			if (o.attachedto <> []) {
				local	a;

				if (isclass(o, Attachable))
					o.properties += &attachedprop;

				for (i := length(o.attachedto); i > 0; i--) {
					a := o.attachedto[i];
					if (find(a.attachedto, o) = nil)
						a.attachedto += o;
				}
			}
		}

		//
		// Location types
		//
		// If the location type is not given explcitly,
		// we make it 'in'.  We also cache the location
		// type number here for efficiency.
		if (defined(o, &locationtype))
			o.setlocationtype(o.locationtype);
		else if (defined(o, &location))
			o.setlocationtype('in');

		// If object has an initmethod, call it
		if (defined(o, &initmethod))
			o.initmethod;			
	}

	userpreinit();
}

//
// Override this function with the replace command to add your own
// special stuff.
//
userpreinit: function
{
}

//
// NOTE: DON'T REPLACE OR CHANGE INIT!
// Put game-specific preinit stuff in userinit.
//
init: function
{
	local	i, o;

	//
	// Do actor init stuff
	//
	for (i := 1; i <= length(global.actorlist); i++) {
		local	o := global.actorlist[i];

		//
		// Actor's death checks
		//
		// If methods are defined and are code, set
		// them up to be called each turn.
		//
		if (defined(o, &starvationcheck))
			if (proptype(o, &starvationcheck) = 6) {
				notify(o, &starvationcheck, 0);
				o.turnsuntilstarvation := o.mealtime;
			}
		if (defined(o, &dehydrationcheck))
			if (proptype(o, &dehydrationcheck) = 6) {
				notify(o, &dehydrationcheck, 0);
				o.turnsuntildehydration := o.drinktime;
			}
		if (defined(o, &sleepcheck))
			if (proptype(o, &sleepcheck) = 6) {
				notify(o, &sleepcheck, 0);
				o.turnsuntilsleep := o.sleeptime;
			}
	}

	// start the turn counter daemon
	setdaemon(turncount, nil);

	// randomize in 2 turns (this allows us to make a verb that
	// prevents randomization and thereby makes regression testing
	// with scripts much easier).  By default this verb is
	// 'deterministic'.
	notify(global, &randomise, 2);

	userinit();
}

//
// Override this function with the replace command to add your own
// special stuff.
//
userinit: function
{
	//
	// Print the intro unless we're restarting.
	//
	if (global.restarting = nil) {
		"\b\b\b\b\b\b\b\b";
		intro();
	}

	//
	// NOTE: We have to set global.lastactor explicitly here,
	// because no command has been executed yet.  (Normally,
	// global.lastactor is set in the Verb disamiguation code.)
	//
	global.lastactor := Me;

	//
	// Note funny syntax:
	//
	Me.location.enter(Me);
}

//
// Call this to end the game due to player death.
//
die: function
{
	P();
	global.lastactor.diemessage; "\n";
	end();
}

//
// Call this to end the game (without explanation).
//
end: function
{
	P();
	score_and_rank();
	P();
	"You may restore a saved game, start over, quit, or undo the 
	current command.\n";
	for (;;) {
		local resp;

		"\nPlease enter RESTORE, RESTART, QUIT, or UNDO: >";
		resp := upper(input());
		switch (resp) {			
			case 'RESTORE':
				restoreVerb.soloaction(global.lastactor);
				break;
			case 'RESTART':
				restartVerb.soloaction(global.lastactor);
				restart();
				break;
			case 'QUIT':
				terminate();
				quit();
				abort;
				break;
			case 'UNDO':
				undoVerb.soloaction(global.lastactor);
				break;
		}
	}
}

	/*
	 * Utility functions
	 */

//
// Return the maximum of a list of numbers
//
maxinlist: function(l)
{
	local	i, m;

	if (m = nil or m = [])
		return nil;
	else
		m := l[1];

	for (i := length(l); i > 1; i--)
		if (l[i] > m)
			m := l[i];

	return m;
}
mininlist: function(l)
{
	local	i, m;

	if (m = nil or m = [])
		return nil;
	else
		m := l[1];

	for (i := length(l); i > 1; i--)
		if (l[i] < m)
			m := l[i];

	return m;
}

//
// Random number functions.  Proper use of these is important
// for regression testing with scripts.
//
// rnd(n) returns a random number between 1 and n (inclusive).
// rndchance(n) returns true if a random n% probability is satisfied.
//
// When global.nondeterministic is set to nil, these function behave
// differently: rnd(n) always returns 1, while rndchance(n) always
// returns true.
//
rnd: function(n)
{
	if (global.nondeterministic)
		return rand(n);
	else
		return 1;
}
rndchance: function(n)
{
	if (global.nondeterministic)
		return rand(100) <= n ? true : nil;
	else
		return true;
}

	/*
	 * Stuff we need for the parser
	 */

//
// Preparse.  TADS calls before it looks at the input.
// We simply dispatch to our standard preparse routine;
// this makes for users to replace this function with
// their own custom stuff and still retain the standard
// WorldClass behavior.
//
preparse: function(s)
{
	return WorldClassPreparse(s);
}

//
// Preparse routine to extend parser to handle parenthesized lists of numbers.
// This code replaces a list of numbers enclosed in parentheses with the
// string "intlist", which matches the listObj object defined below.  E.g.,
//
//   set widget to (i1, i2, ... , in) ->
//
//     "set widget to intlist"
//     listObj.value := [i1 i2 ... in]
//
// See setVerb for an example of how to update a verb to accept lists like this.
//
WorldClassPreparse: function(s)
{
	local	orig, i, snew, inlist := nil, gotlist := nil, numstr := '';

	listObj.value := [];
	orig := s;
	snew := '';

	for (i := 1; i <= length(s); i++) {
		local c := substr(s, i, 1);

		if (inlist) {
			if (c = ')' or c = ']') {
				inlist := nil;
				gotlist := true;
			}
			else if (c = ',' or c = ' ') {
				if (numstr <> '') {
					listObj.value += cvtnum(numstr);
					numstr := '';
				}
			}
			else {
				numstr += c;
			}
		}
		else {
			if (c = '(' or c = '[') {
				// start getting list if we
				// haven't already seen one.
				if (not gotlist) {
					inlist := true;
					snew += ' intlist ';
					continue;
				}
			}
			else if (c = ')' or c = ']') {
				// error
				return orig;
			}

			snew += c;
		}
	}

	if (numstr <> '') 
		listObj.value += cvtnum(numstr);

	return snew;
}

/*
 *   Define compound prepositions.  Since prepositions that appear in
 *   parsed sentences must be single words, we must define any logical
 *   prepositions that consist of two or more words here.  Note that
 *   only two words can be pasted together at once; to paste more, use
 *   a second step.  For example,  'out from under' must be defined in
 *   two steps:
 *
 *     compoundWord 'out' 'from' 'outfrom';
 *     compoundWord 'outfrom' 'under' 'outfromunder';
 *
 *   Listed below are the compound prepositions that were built in to
 *   version 1.0 of the TADS run-time.
 */
compoundWord 'on' 'to' 'onto';		 /* on to --> onto */
compoundWord 'in' 'to' 'into';		 /* in to --> into */
compoundWord 'in' 'between' 'inbetween'; /* and so forth */
compoundWord 'down' 'in' 'downin';
compoundWord 'down' 'on' 'downon';
compoundWord 'up' 'on' 'upon';
compoundWord 'out' 'of' 'outof';
compoundWord 'off' 'of' 'offof';
compoundWord 'out' 'from' 'outfrom';
compoundWord 'outfrom' 'under' 'outfromunder';
compoundWord 'outfrom' 'underneath' 'outfromunderneath';
compoundWord 'from' 'behind' 'frombehind';
compoundWord 'outfrom' 'behind' 'outfrombehind';

/*
 *  Prep: object
 *
 *  A preposition.  The preposition property specifies the
 *  vocabulary word.
 */
class Prep: object ;

/*
 * PREPOSITIONS
 * 
 * NOTE: Adding to the preposition vocab lists only affects verbs that take
 * indirect objects.  Verbs that have preps stuck in their verb vocab lists
 * don't pick up all the synonyms.  E.g.,
 *
 *	verb = 'look in'
 *
 * will *only* match input commands like
 *
 *	>look in bucket
 *
 * NOT commands like
 *
 *	>look inside bucket
 *	>look into bucket
 *
 * even though we make 'inside' and 'into' synonyms of 'in' for inPrep below.
 */
ofPrep: Prep preposition='of' sdesc="of";	// required for TADS >= 2.2

aboutPrep: Prep
	preposition = 'about'
	sdesc = "about"
;
withPrep: Prep
	preposition = 'with'
	sdesc = "with"
;
toPrep: Prep
	preposition = 'to'
	sdesc = "to"
;
onPrep: Prep
	preposition = 'on' 'onto' 'downon' 'upon'
	sdesc = "on"
;
inPrep: Prep
	preposition = 'in' 'into' 'downin' 'inside'
	sdesc = "in"
;
offPrep: Prep
	preposition = 'off' 'offof'
	sdesc = "off"
;
outPrep: Prep
	preposition = 'out' 'outof' 'outside'
	sdesc = "out"
;
fromPrep: Prep
	preposition = 'from'
	sdesc = "from"
;
betweenPrep: Prep
	preposition = 'between' 'inbetween'
	sdesc = "between"
;
overPrep: Prep
	preposition = 'over'
	sdesc = "over"
;
atPrep: Prep
	preposition = 'at'
	sdesc = "at"
;
upPrep: Prep
	preposition = 'up'
	sdesc = "up"
;
downPrep: Prep
	preposition = 'down'
	sdesc = "down"
;
aroundPrep: Prep
	preposition = 'around'
	sdesc = "around"
;
throughPrep: Prep
	preposition = 'through' 'thru'
	sdesc = "through"
;
underPrep: Prep
	preposition = 'under' 'beneath'
	sdesc = "under"
;
behindPrep: Prep
	preposition = 'behind'
	sdesc = "behind"
;
outfromunderPrep: Prep
	preposition = 'outfromunderneath' 'outfromunder' 'fromunder'
	sdesc = "out from under"
;
outfrombehindPrep: Prep
	preposition = 'outfrombehind' 'frombehind'
	sdesc = "out from behind"
;
forPrep: Prep
	preposition = 'for'
	sdesc = "for"
;

//
// Direction prepositions.  We need these so we can have two-word
// verbs like 'go north' and 'look east'.
//
dirPrep: Prep
	preposition =	'north' 'south' 'east' 'west' 'up' 'down'
			'northeast' 'ne' 'northwest' 'nw' 'southeast'
			'se' 'southwest' 'sw' 'u' 'd' 'upstream'
			'downstream' 'us' 'ups' 'ds'

	sdesc = "north"		// Shouldn't ever need this, but just in case
;

/*
 *  Articles
 */
articles: object
	article = 'the' 'a' 'an'
;

formatstring 'you' fmtYou;

/*
 *   Special Word List: This list defines the special words that the
 *   parser needs for input commands.  If the list is not provided, the
 *   parser uses the old defaults.  The list below is the same as the old
 *   defaults.	Note - the words in this list must appear in the order
 *   shown below.
 */
specialWords
	'of',	/* used in phrases such as "piece of paper" */
	'and',	/* conjunction for noun lists or to separate commands */
	'then',	/* conjunction to separate commands */
	'all' = 'everything',	/* refers to every accessible object */
	'both',	/* used with plurals, or to answer disambiguation questions */
	'but' = 'except',	/* used to exclude items from ALL */
	'one',	/* used to answer questions:  "the red one" */
	'ones',	/* likewise for plurals:  "the blue ones" */
	'it' = 'there',	/* refers to last single direct object used */
	'them',	/* refers to last direct object list */
	'him',	/* refers to last masculine actor mentioned */
	'her',	/* refers to last feminine actor mentioned */
	'any' = 'either' /* pick object arbitrarily from ambiguous list */
;

/*
 * Formatting functions
 */

//
// Paragraph indentation
//
I: function
{
	if (global.indent)
		"\t";
}

//
// Paragraph separator
//
P: function
{
	if (global.paragraphspacing)
		"\b";
	else
		"\n";
}

//
// Output hiding, with state save.
// This version of outhide works properly when nested.
//
Outhide: function(on)
{
	local	state, result := nil;

	if (on) {
		state := outhide(true);
		global.outstate := [state] + global.outstate;
	}
	else {
		result := outhide(car(global.outstate));
		global.outstate := cdr(global.outstate);
	}

	return result;
}

//
// This function returns true if the two objects are indistinguishable
// in contents listings.
//
// The objects are equivalent if:
//
// 1) Both have isequivalent set to true
// 2) Both have the same immediate superclass
// 3) They have identical properties lists
// 4) Properties in prop lists report identically
//
// Number 4 means that two otherwise identical objects will be listed
// separately if, for example, one is lit and the other isn't.
//
indistinguishable: function(a, b)
{
	local	i;
	local	la, lb;
	local	stat;

	if (not a.isequivalent or not b.isequivalent)
		return nil;

	if (firstsc(a) <> firstsc(b))
		return nil;

	if (a.properties <> b.properties)
		return nil;

	stat := outcapture(true);
	a.listdesc;
	la := outcapture(stat);

	stat := outcapture(true);
	b.listdesc;
	lb := outcapture(stat);

	if (upper(la) <> upper(lb))
		return nil;

	return true;
}

//
// Print the text equivalent of the given number.
//
saynum: function(x)
{
	local numbers = [
		'one' 'two' 'three' 'four' 'five'
		'six' 'seven' 'eight' 'nine' 'ten'
		'eleven' 'twelve' 'thirteen' 'fourteen'
		'fifteen' 'sixteen' 'seventeen' 'eighteen'
		'nineteen' 'twenty'
	];

	if (x <= 20)
		"<<numbers[x]>>";
	else
		"<<x>>";

	return '';	// so we can do <<saynum(n)>>
}

//
// routines to list the contents of a container.
// the listcontents routine used to be a recursive function, but it proved
// to be much too slow.	 this is an unrolled version that makes more 
// assumptions. it is correspondingly difficult to read and maintain.  ugh!
//
// explanation of parameters to listcontentsx:
//
// cont		the object whose contents are to be listed.
// actor	the actor who's looking.
// md		maximum depth (recursively) to look for objects.
//		not currently used.
// silent	if true, list.	otherwise, just count objects that
//		*would be* listed.
// leadingspace	if true, print a blank line before the first text.
//		if no text is printed (i.e., no contents are listed),
//		no blank line will be printed.
// ird		ird = "in room description"
//		items can specify that they don't want to be listed in room
//		descriptions.  likewise, items can specify that they don't
//		want their contents listed in room descriptions.
// loctype	location type that describes the contents.  ('on', 'in',
//		'under', 'behind').  if nil, all types are considered.
// listfixtures	if true, list items for which item.isfixture is true.
// listactors	if true, list items for which item.isactor is true.
// cansense	which sense to use.  this is a property pointer -- one
//		of the following:
//
//			&cansee
//			&cansmell
//			&canhear
//			&cantouch
//
//		if cansee is specified, the routine will list things
//		the player can see.  if cansmell, the routine will
//		list only things the player can smell.	(often, this
//		is nothing.)  etc.
// here		the location corresponding to "here" in "There is a
//		Cheez Kee here."  This parameter is useful for dealing
//		with a Nestedroom, where "here" is the containing Room,
//		not the Nestedroom itself. (*)
//
//
// (*) Even this solution is tricky. Consider the following scenario:
//
//---------------------------------------------------------------------------  
// >look
//
// There is a cheez kee here.  A sturdy chair stands to one side.
//
// >sit in chair
// >look
//
// There is a cheez kee in the room. [...]
//---------------------------------------------------------------------------  
//
// The problem is that we don't necessarily want to distinguish between
// "here", the containing room, and "here" in the chair.  In fact, we
// may want the contents lister to consider both of these locations
// "here".  A possible solution is to make the _here_ parameter a list.
// For the moment, however, WorldClass always makes _here_ be the containing
// Room, not the Nestedroom.
//
//
listcontentsX: function(cont, actor, md, silent, leadingspace, ird, loctype, listfixtures, listactors, cansense, here)
{
	local	i, j, k, len, l, clen;
	local	see := [], hear := [], smell := [], touch := [];
	local	ltlist;
	local	o;
	local	container, lt;
	local	unlisted := [];
	local	tolist := [], tlen;
	local	indislist := [], indiscount := [], indislen, indistot;
	local	listedhere := [], tot := 0;
	local	Silent := silent;

	//
	// list things the player sees.
	//
	if (not (cansense = nil or cansense = &cansee))
		silent := true;

	//
	// Always see what the player can see so we get a valid
	// list of things that are listedhere.	We need this to
	// decide later if we should say "something is ticking"
	// vs. "the bomb is ticking".
	//
	if (true) {
		//
		// If the actor can't see this container, explain why
		// and exit.
		//
		caps();
		if (not actor.cansee(cont, nil, silent))
			return;

		//
		// Construct the list of location types to look for.
		// If loctype is non-nil, verify that it works.
		// Otherwise, try each locationtype.
		//
		if (loctype = nil)
			ltlist := actor.canseecontents(cont, true, nil);
		else 
			ltlist := [loctype];
		if (ltlist = nil)
			see := [];
		else
			see := cont.seecont(actor, ltlist);

		len := length(see);
		for (i := 1; i <= len; i++) {
			l := see[i];
			container := l[1];
			lt := l[2];
			clen := l[3];

			//
			// If this container doesn't want its contents
			// listed in room descriptions, don't list.
			//
			if (ird and not container.(global.loccont[lt])(nil)) {
				unlisted += container;
				continue;
			}

			//
			// If this is a room description and this container
			// does not want to be listed, don't list its
			// contents either.  Furthermore, we don't want
			// to list the contents of any container whose
			// container doesn't want things listed, etc.
			// So we need to keep a list of containers that
			// don't want things listed.  Since our list
			// of objects is guaranteed to go *down* the
			// containment hierarchy as we progress from 
			// 1 to n, we'll always see containers before
			// we see their contents, so this works.
			//
			// The exception to this is that if the container
			// is this Thing (cont), then it doesn't have
			// have to be listable for its contents to be
			// listed.
			//
			if (ird) {
				if (find(unlisted, container) <> nil)
					continue;
				if (find(unlisted, container.location) <> nil) {
					unlisted += container;
					continue;
				}

#ifdef	NEVER
				//
				// This is the clause that implements the
				// statement "contents of things that
				// aren't listed aren't listed".  This is
				// probably better handled in the listcontents
				// methods themselves.	(The problem:  A desk
				// with things on it isn't listed because it's
				// described "by hand" in the room description.
				// Then contents of the desk won't be listed.
				// This is bad.)
				//
				if (container <> cont and not container.islistable(actor)) {
					unlisted += container;
					continue;
				}
#endif	/* NEVER */
			}

			//
			// If this is a room description, remove
			// any items that don't want to be listed
			// in room descriptions.
			//
			if (ird) for (j := 4; j <= clen; j++) {
				if (not l[j].islistable(actor))
					l[j] := nil;
			}


			//
			// Remove any items that aren't noticeable
			//
			for (j := 4; j <= clen; j++) {
				if (l[j] <> nil)
					if (not l[j].isnoticeable(actor))
						l[j] := nil;
			}

			//
			// Now list all the fixtures, if we're listing
			// fixtures. If we're not listing them, just
			// delete them.
			//
			tolist := [];
			tlen := 0;
			for (j := 4; j <= clen; j++) {
				o := l[j];

				if (o = nil)
					continue;
				if (not o.isfixture and not o.isactor)
					continue;
				l[j] := nil;
				if (not listfixtures)
					continue;
				if (o.isactor) {
					if (not listactors)
						continue;
					if (o = actor)
						continue;
				}
				tolist += o;
				tlen++;
			}
			tot += tlen;
			listedhere += tolist;
			if (not silent and listfixtures) {
				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					if (leadingspace) {
						leadingspace := nil;
						P(); I();
					}
					if (o.isactor) {
						"<<o.actordesc>> ";
						tot++;
						listedhere += o;
					}
					else if (listfixtures) {
						"<<o.heredesc>> ";
						tot++;
						listedhere += o;
					}
				}
			}

			//
			// Now list everything else.
			// We separate out indistinguishables.
			// We move plurals to the front to make the
			// listing more readable.
			//
			tolist := [];
			tlen := 0;
			indislist := [];
			indiscount := [];
			indislen := 0;
			for (j := 4; j <= clen; j++) {
				o := l[j];
				if (o = nil)
					continue;
				if (o.isequivalent) {
					indislist += o;
					indiscount += 1;
					indislen++;
				}
				else {
					if (o.isplural)
						tolist := [o] + tolist;
					else
						tolist += o;
					tlen++;
				}
			}

			//
			// Now merge indistinguishable objects
			//
			for (j := 1; j <= indislen; j++) {
				if (indislist[j] = nil)
					continue;

				for (k := j + 1; k <= indislen; k++) {
					if (indislist[k] = nil)
						continue;

					if (indistinguishable(indislist[j], indislist[k])) {
						indiscount[j]++;
						indislist[k] := nil;
					}
				}
			}

			//
			// Put indistinguishable objects back in tolist
			//
			indistot := 0;
			for (j := 1; j <= indislen; j++) {
				local	o := indislist[j];

				if (o = nil)
					continue;
				
				tolist := [o] + tolist;
				tlen++;
				indistot++;
				indiscount[indistot] := indiscount[j];
			}

			if (tlen = 0)
				continue;

			tot += tlen;
			listedhere += tolist;

			if (silent)
				continue;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			" \^";
			if (container.isactor)
				"<<container.subjthedesc>>
				\ <<container.has>>";

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];

				if (j = 1)
					" ";
				else if (j = tlen) {
					if (tlen > 2)
						",";
						" and ";
				}
				else
					", ";

				if (j <= indistot and indiscount[j] > 1)
					"<<saynum(indiscount[j])>> \v<<o.listpluraldesc>>";
				else
					o.listdesc;
			}

			if (container.isactor) {
				". ";
			}
			else {
				if (tlen > 1 or o.isplural)
					" are ";
				else
					" is ";

				if (container = here and global.loctypes[lt] = 'in')
					" here. ";
				else
					" <<global.loctypes[lt]>>
					\ <<container.objthedesc(nil)>>. ";
			}
		}
		global.listed += listedhere;
	}


	//
	// If we only did the "see" code to get a list of things that
	// the player can see, don't count these items in the total.
	//
	silent := Silent;
	if (not (cansense = nil or cansense = &canseee))
		tot := 0;

	//
	// Now list things the player hears.
	//
	if (cansense = nil or cansense = &canhear) {
		if (global.manysounds) {
			//
			// We have many Listablesounds in the
			// game, so it's faster to recurse and
			// see which of the container's contents are
			// Listablesounds rather than which 
			// of the Listablesounds in the game
			// are in this container.
			//

			//
			// If the actor can't hear this container, explain why
			// and exit.
			//
			caps();
			if (not actor.canhear(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.canhearcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				hear := [];
			else
				hear := cont.hearcont(actor, ltlist);

			len := length(hear);
			for (i := 1; i <= len; i++) {
				l := hear[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.locconthear[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistablesound(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player hears.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listlistendesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listablesoundlist); i > 0; i--) {
				o := global.listablesoundlist[i];
				contained := nil;

				if (not o.islistablesound(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.locconthear[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listablesoundlist[i];
					if (actor.canhear(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break1;

			tot += tlen;

			if (silent)
				goto Break1;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listlistendesc>> ";
			}
Break1:;
		}
	}

	//
	// Now list things the player smells.
	//
	if (cansense = nil or cansense = &cansmell) {
		if (global.manysmells) {
			//
			// If the actor can't smell this container, explain why
			// and exit.
			//
			caps();
			if (not actor.cansmell(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.cansmellcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				smell := [];
			else
				smell := cont.smellcont(actor, ltlist);

			len := length(smell);
			for (i := 1; i <= len; i++) {
				l := smell[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.loccontsmell[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistablesmell(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player smells.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listsmelldesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listablesmelllist); i > 0; i--) {
				o := global.listablesmelllist[i];
				contained := nil;

				if (not o.islistablesmell(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.loccontsmell[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listablesmelllist[i];
					if (actor.cansmell(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break2;

			tot += tlen;

			if (silent)
				goto Break2;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listsmelldesc>> ";
			}
Break2:;
		}
	}

	//
	// Now handle things the player feels
	//
	if (cansense = nil or cansense = &cantouch) {
		if (global.manytouches) {
			//
			// If the actor can't touch this container, explain why
			// and exit.
			//
			caps();
			if (not actor.cantouch(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.cantouchcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				touch := [];
			else
				touch := cont.touchcont(actor, ltlist);

			len := length(touch);
			for (i := 1; i <= len; i++) {
				l := touch[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.locconttouch[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistabletouch(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player feels.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listtouchdesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listabletouchlist); i > 0; i--) {
				o := global.listabletouchlist[i];
				contained := nil;

				if (not o.islistabletouch(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.locconttouch[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listabletouchlist[i];
					if (actor.cantouch(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break3;

			tot += tlen;

			if (silent)
				goto Break3;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listtouchdesc>> ";
			}
Break3:;
		}
	}

	return tot;
}
//
// The front end for contents listing.
//
listcontents: function(cont, actor, md, silent, leadingspace, ird, loctype, listfixtures, listactors, cansense, here)
{
	local	i, l, tot;

	//
	// Nothing listed (visual) yet.
	//
	global.listed := [] + cont;

	//
	// List contents.
	//
	tot := listcontentsX(cont, actor, md, silent, leadingspace, ird, loctype, listfixtures, listactors, cansense, here);

	//
	// Make everything we listed (visual only) known.
	// We have to do this so that things that only become
	// visible after the player enters the room (e.g.,
	// things that are in containers that the player opens
	// after entering a room.) are made known to the actor.
	//
	l := global.listed;
	for (i := length(l); i > 0; i--)
		l[i].makeknownto(actor);

	return tot;
}

//
// The top of the topology.
//
// Every thing has a parent, stored in the location property of the thing.
// Things that are nowhere (location = nil) implicitly have top as
// their parent.
//
// Rooms generally have top as their location.	This means that top is
// the place to put code for inter-room sense passing.	E.g., top
// might find the shortest path between two rooms and pass hearing
// if the two rooms are within a certain distance from each other.
//
// Right now top just refuses to send senses between rooms.
//
// Note that to effect inter-room sense passing you need only
// modify the passcanXacross methods.
//
TOP: Thing		// Thing so it can get sense-passing stuff
	sdesc = "TOP"
	thedesc = "TOP"

	location = nil

	roomAction(a, v, d, p, i) = {}

	//
	// These shouldn't get called.
	//
	passcansee(actor, obj, loctype) = { return nil; }
	passcantouch(actor, obj, loctype) = { return nil; }
	passcantake(actor, obj, loctype) = { return nil; }
	passcansmell(actor, obj, loctype) = { return nil; }
	passcanhear(actor, obj, loctype) = { return nil; }
	passcanspeakto(actor, obj, loctype) = { return nil; }

	//
	// Don't pass sense by default.
	//
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<actor.doesnt>> see
		anything matching that vocabulary here.";
		return nil;
	}
	passcantouchacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't touch anything
		matching that vocabulary here.";
		return nil;
	}
	passcantakeacross(actor, obj, selfloctype, objloctype) = {
		"There is nothing matching that vocabulary here.";
		return nil;
	}
	passcansmellacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't smell anything
		matching that vocabulary here.";
		return nil;
	}
	passcanhearacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't hear anything
		matching that vocabulary here.";
		return nil;
	}
	passcanspeaktoacross(actor, obj, selfloctype, objloctype) = {
		"Nothing matching that vocabulary can hear 
		<<actor.objprodesc(nil)>>.";
		return nil;
	}
;

//
// NIL is similar to TOP.  Everything that is nowhere is taken to be
// in NIL, which is likewise taken to be in TOP.  This is really only here
// to make Thing.blocksreach simpler -- you should never really set
// anything's location to NIL.	(Blocksreach wants every pair of
// objects to have some common ancestor -- we ensure this by putting
// everything under TOP.  Things that are also in nil, are under NIL.)
//
// In theory, you could make things in nil reachable in some circumstances,
// but it's hard to imagine why this would be useful.
//
NIL: Thing		// Thing so it can get sense-passing stuff
	sdesc = "NIL"
	thedesc = "NIL"

	location = TOP

	roomAction(a, v, d, p, i) = {}

	//
	// Don't pass sense by default.
	//
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<actor.doesnt>> see
		anything matching that vocabulary here.";
		return nil;
	}
	passcantouchacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't touch anything
		matching that vocabulary here.";
		return nil;
	}
	passcantakeacross(actor, obj, selfloctype, objloctype) = {
		"There is nothing matching that vocabulary here.";
		return nil;
	}
	passcansmellacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't smell anything
		matching that vocabulary here.";
		return nil;
	}
	passcanhearacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> can't hear anything
		matching that vocabulary here.";
		return nil;
	}
	passcanspeaktoacross(actor, obj, selfloctype, objloctype) = {
		"Nothing matching that vocabulary can hear 
		<<actor.objprodesc(nil)>>.";
		return nil;
	}
;

/*
 * Classes
 */
class Thing: object

#ifndef	CASE_INSENSITIVE
	//
	// Allow specification of isEquivalent in all lower case
	// unless we're already compiling case-insensitive.
	//
	isEquivalent = { return self.isequivalent; }
#endif

	//
	// On dynamic construction, move into location's contents list
	//
	construct = {
		local	loc, loctype;

		//
		// Null out the location field -- moveto
		// won't do anything to objects that
		// are already in the location to be
		// moved to.
		//
		loc := self.location;
		loctype := self.locationtype;

		self.location := nil;
		self.locationtype := nil;

		self.moveto(loc, loctype);
	}


	//
	// On dynamic destruction, move into nowhere.
	//
	destruct = { self.movein(nil); }

#ifdef NEVER
	/* update this code from ADV.T: */

	//
	// Make it so that the player can give a command to an actor only
	// if an actor is reachable in the normal manner.  This method
	// returns true when 'self' can be given a command by the player. 
	//
	validActor = (self.isReachable(Me))
#endif

	//
	// TADS provides visiblity handling for us, but we'll
	// ignore it since we want to do our own stuff instead.
	//
	isVisible(vantage) = { return true; }

	//
	// NOTE: THIS FUNCTION IS NO LONGER USED.
	// As of tads 2.1.2.2, the cantreach function resides
	// in the verb.
	//
	cantReach(actor) = {
		"Warning: This game appears to have been built
		with a pre-2.1.2 version of TADS.  WorldClass
		does not work with such an old version!";
	}

	//
	// These shouldn't ever be called for non-actors, but
	// we'll leave them in just in case.
	//
	aamessage(v, d, p, i) = {
		"\^<<self.subjthedesc>> <<self.isnt>> likely to carry
		out your whims.";
	}
	actorAction(v, d, p, i) = {
		self.aamessage(v, d, p ,i);
		exit;
	}

	//
	// Parts that have this Thing as parent
	//
	parts = []

	location = nil		// this thing is nowhere
	locationtype = 'in'	// this thing is *in* its location by default

	//
	// Methods to set location and locationtype.
	// These check to make sure they're not overwriting code.
	// (E.g., for Floating's that have method locations.)
	//
	setlocation(loc) = {
		if (proptype(self, &location) <> 6)
			self.location := loc;
	}
	setlocationtype(loctype) = {
		if (proptype(self, &locationtype) <> 6) {
			self.locationtype := loctype;
			self.locationtypenum :=	find(global.loctypes, loctype);
		}
	}

	// isplural specifies the number of the thing.
	// NOTE that this is only syntactic!
	isplural = nil

	isdetermined = nil	// true -> doesn't need "a" or "the"
	is = {
		if (self.isplural)
			"are";
		else
			"is";
	}
	isnt = {
		if (self.isplural)
			"aren't";
		else
			"isn't";
	}
	does = {
		if (self.isplural)
			"do";
		else
			"does";
	}
	doesnt = {
		if (self.isplural)
			"don't";
		else
			"doesn't";
	}
	has = {
		if (self.isplural)
			"have";
		else
			"has";
	}
	doesnthave = "<<self.doesnt>> have"
	youll = { "<<self.subjprodesc>>'ll"; }
	youre = {
		if (self.isplural)
			"they're";
		else
			"it's";
	}

	sdesc = {
		if (self.isplural)
			"things";
		else
			"thing";
	}
	multisdesc = { "\(<<self.sdesc>>\)"; }
	ldesc = {
		if (self.isplural)
			"\^<<self.subjprodesc>> look like ordinary
			<<self.objsdesc(nil)>>.";
		else
			"\^<<self.subjprodesc>> looks like an ordinary
			<<self.objsdesc(nil)>>.";
	}

	thedesc = { 
		if (self.isdetermined)
			self.sdesc;
		else
			"the <<self.sdesc>>";
	}
	adesc = {
		if (self.isdetermined or self.isplural)
			self.sdesc;
		else
			"a <<self.sdesc>>";
	}

	// Title -- for things that put text in the status line
	tdesc = { self.sdesc; }	

	// Text printed in a contents listing.
	// This includes extra properties that print things like
	// "(being worn)", "(providing light)" etc.
	//
	// Note that objects that must start out with certain
	// property pointers in the properties list (like Lightsources)
	// have to be have this done in preinit.  (We want to allow
	// for multiple inheritance when more than one inherited class
	// has a special property, so we can't do this with initmethod.)
	//
	properties = []	// list of property pointers
	listprops = {
		local	i;

		for (i := length(self.properties); i > 0; i--)
			" <<self.(self.properties[i])>>";
	}
	listdesc = { "<<self.subjadesc>><<self.listprops>>"; }
	listpluraldesc = { "<<self.pluraldesc>><<self.listprops>>"; }

	//
	// The description types, with case specified.
	//	
	subjsdesc = { self.sdesc; }
	subjthedesc = { self.thedesc; }
	subjadesc = { self.adesc; }
	subjprodesc = {
		if (self.isplural)
			"they";
		else
			"it";
	}
	objsdesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else
			self.sdesc;
	}
	objthedesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else
			self.thedesc;
	}
	objadesc(actor) = { self.adesc; }
	objprodesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else {
			if (self.isplural)
				"them";
			else
				"it";
		}
	}
	possessivedesc = {
		if (self.isplural)
			"their";
		else
			"its";
	}
	reflexivedesc = {
		if (self.isplural)
			"themselves";
		else
			"itself";
	}

	//
	// pluraldesc is only used for indistinguishable objects.
	// For example, two indistinguishable coins may have 
	// sdesc = "coin", but we want to tell the player that
	// there are "two coins here".  The pluraldesc prints
	// the words "coins" in this case.  The default is just
	// tack on an s.  For words like box we'll have to 
	// take care to override this.
	//
	pluraldesc = { "<<self.sdesc>>s"; }

	//
	// Sense descriptions for contents listings (and room descriptions).
	// Note lack of subject.  This is filled in with either
	// <<self.subjthedesc>> or "something in the bag", etc.
	//
	listlistendesc = {
		"<<self.isnt>> making any noise.";
	}
	listsmelldesc = {
		"<<self.doesnt>> smell unusual.";
	}
	listtastedesc = {
		"<<tasteVerb.desc(self)>> normal.";
	}
	listtouchdesc = {
		"<<self.doesnt>> feel unusual.";
	}

	//
	// These get called when an actor says "smell <Thing>"
	// or "taste <Thing>".
	//
	listendesc = {
		"\^<<self.subjthedesc>> <<self.listlistendesc>>";
	}
	smelldesc = {
		"\^<<self.subjthedesc>> <<self.listsmelldesc>>";
	}
	tastedesc = {
		"\^<<self.subjthedesc>> <<self.listtastedesc>>";
	}
	touchdesc = {
		"\^<<self.subjthedesc>> <<self.listtouchdesc>>";
	}

	// General properties
	isfixture = nil		// not furniture we want to describe specially

	// Does the actor know about this thing?
	knownto = []	// not known to any actors yet
	isknownto(actor) = {
		// every Thing starts out knowing about itself
		if (actor = self)
			return true;

		if (actor.knowsall and actor <> Me)
			return self.isknownto(Me);
		else {
			if (find(self.knownto, actor) <> nil)
				return true;
			else
				return nil;
		}
	}

	// Make this Thing known to the given actor
	makeknownto(actor) = {
		if (actor.knowsall and actor <> Me)
			return;

		if (not self.isknownto(actor))
			self.knownto += actor;
	}
	// Make everything in this Thing known to the given actor.
	// This recursively descends the contents lists to a
	// maximum depth of md.
	//
	// We assume that anything that's visible automatically
	// becomes known to the actor.	Things that aren't visible
	// but (for example) make noise will have to be handled
	// with special code.
	makecontentsknownto(actor) = {
		local	i, o, len;

		len := length(self.contents);
		for (i := 1; i <= len; i++) { 
			o := self.contents[i];
			if (not o.isknownto(actor))
				if (actor.cansee(o, nil, true))
					o.makeknownto(actor);

			if (o.contents <> [])
				o.makecontentsknownto(actor);
		}
	}

	//	 
	// The XcontentslistedY functions determine whether the object
	// given as the parameter will be listed in the contents list for
	// this thing in room descriptions when the containment type
	// is X and the sense is Y.
	//
	incontentslisted(obj) = { return true; }
	incontentslistedsmell(obj) = { return true; }
	incontentslistedsound(obj) = { return true; }
	incontentslistedtouch(obj) = { return true; }
	oncontentslisted(obj) = { return true; }
	oncontentslistedsmell(obj) = { return true; }
	oncontentslistedsound(obj) = { return true; }
	oncontentslistedtouch(obj) = { return true; }
	undercontentslisted(obj) = { return true; }
	undercontentslistedsmell(obj) = { return true; }
	undercontentslistedsound(obj) = { return true; }
	undercontentslistedtouch(obj) = { return true; }
	behindcontentslisted(obj) = { return true; }
	behindcontentslistedsmell(obj) = { return true; }
	behindcontentslistedsound(obj) = { return true; }
	behindcontentslistedtouch(obj) = { return true; }

	//
	// islistable(actor) returns true if the object should
	// be listed in room descriptions.
	//
	// islistablesmell, islistablesound, and islistabletouch are like
	// islistable, but determine whether or not the Thing will be listed
	// in the olfactory, audio, or touch contents lists.
	// 
	// isnoticeable is for things like Parts that *never* want to be
	// listed in visual contents listings.	This differs from islistable
	// in that islistable only applies when the contents listing is a
	// room description.
	//
	islistable(actor) = { return nil; }
	islistablesmell(actor) = { return nil; }
	islistablesound(actor) = { return nil; }
	islistabletouch(actor) = { return nil; }
	isnoticeable(actor) = { return true; } 

	//
	// Each of the following methods returns a flattened contents
	// list for this Thing.  The list has the following syntax:
	//
	// 	[ [ container loctype n c1 c2 .. cn-4 cn-3] ... ]
	//
	// This is a list of lists.  Each sublist corresponds to a
	// particular container.  E.g., calling
	//
	//	desk.seecont(Me, ['in' 'on]);
	//
	// might produce the following list:
	//
	// 	[ [ desk 'in' 5 key jar ]
	//	  [ desk 'on' 6 box coin string ]
	//	  [ jar  'in' 3 ]
	//	  [ box  'in' 4 egg ] ]
	//
	// The first three entries in each sublist are the containing
	// object, the location type, and the number of objects in the
	// list (including the 3 header objects).
	//
	// The list is guaranteed to list containers before their
	// contents.
	//
	// We have separate methods for contents flattening to make
	// contents listing more efficient.  By separating the two
	// tasks of listing and flattening, we can make the composite
	// operation more efficient.
	//
	// Note that there is usually no reason to call these methods.
	// Only the contents lister really needs this kind of detailed
	// contents information.
	//
	seecontX(actor, ltlist) = {
		local	master := [];
		local	tl;
		local	i, j;
		local	loctypeslen;
		local	c;
		local	cont;
		local	o;
		local	l;
		local	lt;
		local	len;
		local	cs;

		if (self.contents = [])
			return [];

		cs := [];
		loctypeslen := length(global.loctypes);
		cont := [];
		for (i := 1; i <= loctypeslen; i++) {
			if (ltlist <> nil and find(ltlist, global.loctypes[i]) = nil)
				cs += nil;
			else
				cs += self.passcanseein(actor, nil, global.loctypes[i]);

			cont += [[]];
		}
		c := self.contents;
		for (i := length(c); i > 0; i--) {
			o := c[i];
			lt := o.locationtypenum;
			if (not cs[lt])
				continue;

			cont[lt] += o;
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			if (len = 0)
				continue;

			tl := [] + self;
			tl += i;
			tl += len + 3;	// length, including header
			tl += l;
			master += [tl];
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			for (j := 1; j <= len; j++) {
				o := l[j];
				if (o.isvisible(actor) and o.isnoticeable(actor))
					master += o.seecontX(actor, nil);
			}
		}

		return master;
	}
	seecont(actor, ltlist) = {
		local l;

		Outhide(true);
		l := self.seecontX(actor, ltlist);
		Outhide(nil);
		return l;
	}
	hearcontX(actor, ltlist) = {
		local	master := [];
		local	tl;
		local	i, j;
		local	loctypeslen;
		local	c;
		local	cont;
		local	o;
		local	l;
		local	lt;
		local	len;
		local	cs;

		if (self.contents = [])
			return [];

		cs := [];
		loctypeslen := length(global.loctypes);
		cont := [];
		for (i := 1; i <= loctypeslen; i++) {
			if (ltlist <> nil and find(ltlist, global.loctypes[i]) = nil)
				cs += nil;
			else
				cs += self.passcanhearin(actor, nil, global.loctypes[i]);

			cont += [[]];
		}
		c := self.contents;
		for (i := length(c); i > 0; i--) {
			o := c[i];
			lt := o.locationtypenum;
			if (not cs[lt])
				continue;

			cont[lt] += o;
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			if (len = 0)
				continue;

			tl := [] + self;
			tl += i;
			tl += len + 3;	// length, including header
			tl += l;
			master += [tl];
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			for (j := 1; j <= len; j++) {
				o := l[j];
				master += o.hearcontX(actor, nil);
			}
		}

		return master;
	}
	hearcont(actor, ltlist) = {
		local l;

		Outhide(true);
		l := self.hearcontX(actor, ltlist);
		Outhide(nil);
		return l;
	}
	smellcontX(actor, ltlist) = {
		local	master := [];
		local	tl;
		local	i, j;
		local	loctypeslen;
		local	c;
		local	cont;
		local	o;
		local	l;
		local	lt;
		local	len;
		local	cs;

		if (self.contents = [])
			return [];

		cs := [];
		loctypeslen := length(global.loctypes);
		cont := [];
		for (i := 1; i <= loctypeslen; i++) {
			if (ltlist <> nil and find(ltlist, global.loctypes[i]) = nil)
				cs += nil;
			else
				cs += self.passcansmellin(actor, nil, global.loctypes[i]);

			cont += [[]];
		}
		c := self.contents;
		for (i := length(c); i > 0; i--) {
			o := c[i];
			lt := o.locationtypenum;
			if (not cs[lt])
				continue;

			cont[lt] += o;
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			if (len = 0)
				continue;

			tl := [] + self;
			tl += i;
			tl += len + 3;	// length, including header
			tl += l;
			master += [tl];
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			for (j := 1; j <= len; j++) {
				o := l[j];
				master += o.smellcontX(actor, nil);
			}
		}

		return master;
	}
	smellcont(actor, ltlist) = {
		local l;

		Outhide(true);
		l := self.smellcontX(actor, ltlist);
		Outhide(nil);
		return l;
	}
	touchcontX(actor, ltlist) = {
		local	master := [];
		local	tl;
		local	i, j;
		local	loctypeslen;
		local	c;
		local	cont;
		local	o;
		local	l;
		local	lt;
		local	len;
		local	cs;

		if (self.contents = [])
			return [];

		cs := [];
		loctypeslen := length(global.loctypes);
		cont := [];
		for (i := 1; i <= loctypeslen; i++) {
			if (ltlist <> nil and find(ltlist, global.loctypes[i]) = nil)
				cs += nil;
			else
				cs += self.passcantouchin(actor, nil, global.loctypes[i]);

			cont += [[]];
		}
		c := self.contents;
		for (i := length(c); i > 0; i--) {
			o := c[i];
			lt := o.locationtypenum;
			if (not cs[lt])
				continue;

			cont[lt] += o;
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			if (len = 0)
				continue;

			tl := [] + self;
			tl += i;
			tl += len + 3;	// length, including header
			tl += l;
			master += [tl];
		}
		for (i := 1; i <= loctypeslen; i++) {
			l := cont[i];
			len := length(l);
			for (j := 1; j <= len; j++) {
				o := l[j];
				master += o.touchcontX(actor, nil);
			}
		}

		return master;
	}
	touchcont(actor, ltlist) = {
		local l;

		Outhide(true);
		l := self.touchcontX(actor, ltlist);
		Outhide(nil);
		return l;
	}

	//
	// doListcontents is for debugging only.  It describes
	// the location of every object contained in this Thing.
	//
	verDoListcontents(actor) = {}
	doListcontents(actor) = {
		local	i;

		for (i := 1; i <= length(self.contents); i++) {
			self.contents[i].doLocate(actor);
			"\n";
		}
		for (i := 1; i <= length(self.contents); i++)
			self.contents[i].doListcontents(actor);
	}
	
	//
	// Recursive contents enumeration.
	//
	// This function returns a list of all the contents of this
	// Thing, and all the contents of the contents, etc. subject
	// to the requirement that the containment types are in the
	// list loctypes.  
	//
	// loctypes is only used for the top level items.  (If Z 
	// is (in, on, under, behind) X, and X is *in* Y, then Z is
	// *in* Y too, so we don't need to check Z's loctype.
	//	
	// The topcontents function is just like recursivecontents,
	// but doesn't recurse.
	//
	// itemcontents is like recursivecontents, but only keeps
	// items, and only recurses on objects that aren't Items.
	// (If a container is an Item itself, we don't need to recurse,
	// because the player would likely rather have the whole container
	// than the individual contents.)
	//
	recursivecontents(actor, loctypes) = {
		local	i, l, len, r := [];

		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++)
			if (loctypes = nil or find(loctypes, l[i].locationtype) <> nil) {
				r += l[i];
				r += l[i].recursivecontents(actor, nil);
			}

		return r;
	}
	topcontents(actor, loctypes) = {
		local	i, l, len, r := [];

		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++)
			if (loctypes = nil or find(loctypes, l[i].locationtype) <> nil) {
				r += l[i];
			}

		return r;
	}
	itemcontents(actor, loctypes) = {
		local	i, l, len, r := [];

		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++) {
			if (loctypes = nil or find(loctypes, l[i].locationtype) <> nil) {
				if (isclass(l[i], Item))
					r += l[i];
				else
					r += l[i].itemcontents(actor, nil);
			}
		}

		return r;
	}

	//
	// Methods to deal with computing the weight and bulk of contents:
	//
	// - contentsX returns the total value of all contents with
	//   containment types given in loctypes, where the value of
	//   each contained Thing is given by Thing.(valueprop).  Note
	//   that loctypes is only used for the top level of the
	//   recursion -- lower down, all location types are considered.
	//
	//   (This makes sense -- consider calling this with loctypes
	//   equal to ['in' 'on']: if you have a phone booth with
	//   a mouse *behind* it and a table *inside* it, then the total
	//   weight inside the phone booth does not include the
	//   mouse, but it does include things which are *under* or *behind*
	//   the table.)
	//
	//   If loctypes is nil, we assume that all location types are
	//   allowed.
	//
	//   Contents without the value property defined are counted
	//   as zeroes.
	//
	// - contentsweight returns the total weight of all contents.
	// - contentsbulk returns the total weight of all contents.
	//
	contentsX(actor, valueprop, loctypes) = {
		local	i, l, len, total := 0;

		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++)
			if (loctypes = nil or find(loctypes, l[i].locationtype) <> nil) {
				if (defined(l[i], valueprop))
					total += l[i].(valueprop);

				total += l[i].contentsX(actor, valueprop, nil);
			}

		return total;
	}
	contentsweight(actor, loctypes) = {
		return self.contentsX(actor, &weight, loctypes);
	}
	contentsbulk(actor, loctypes) = {
		return self.contentsX(actor, &bulk, loctypes);
	}

	//
	// By default, Things can't hold anything.  (Use Holders for that.)
	// These defaults get inherited by Holder -- the default mapping
	// from the specific max methods to the general ones (maxbulk and
	// maxweight) are convenient -- the programmer can use the
	// old adv.t names maxbulk and maxweight as long as he doesn't
	// want to make a distinction between, for example, the amount that
	// can fit *in* the Thing and the amount that can fit *on* it.
	//
	maxbulk = 0
	maxweight = 0
	inmaxbulk = { return self.maxbulk; }
	onmaxbulk = { return self.maxbulk; }
	undermaxbulk = { return self.maxbulk; }
	behindmaxbulk = { return self.maxbulk; }
	inmaxweight = { return self.maxweight; }
	onmaxweight = { return self.maxweight; }
	undermaxweight = { return self.maxweight; }
	behindmaxweight = { return self.maxweight; }
		
	//
	// Senses
	//
	// These just determine whether or not the the thing
	// is *inherently* accessable in the various ways.
	//
	// This is very different from whether or not the thing
	// is accessable *at the given time and in its current
	// location relative to the player*.  The canX methods
	// determine the latter.
	//
	// If isvisible is nil here, for example, it means that
	// the object is simply invisible, and can never be seen
	// regardless of where it is relative to the player.
	//
	// In order to maintain backward compatibility with old
	// code, we check the verDo methods for the various
	// senses here.	 This means that you can print explanations
	// of why the object can't be accessed in the verDo methods
	// as in old code.  These message will be printed, however,
	// in many more circumstances than before, since many verbs
	// requires these kinds of access.
	//
	isvisible(actor) = {
		//
		// No corresponding ver method in old code, but
		// we have a reasonable new one.
		//
		Outhide(true);
		self.verDoInspect(actor);
		if (Outhide(nil)) {
			self.verDoInspect(actor);
			return nil;
		}

		return true;
	}
	istouchable(actor) = {
		Outhide(true);
		self.verDoTouch(actor);
		if (Outhide(nil)) {
			self.verDoTouch(actor);
			return nil;
		}

		return true;
	}
	istakeable(actor) = {
		Outhide(true);
		self.verDoTake(actor);
		if (Outhide(nil)) {
			self.verDoTake(actor);
			return nil;
		}

		return true;
	}
	issmellable(actor) = {
		Outhide(true);
		self.verDoSmell(actor);
		if (Outhide(nil)) {
			self.verDoSmell(actor);
			return nil;
		}

		return true;
	}
	isaudible(actor) = {
		//
		// No corresponding ver method in old code, but
		// we have a reasonable new one.
		//
		Outhide(true);
		self.verDoListento(actor);
		if (Outhide(nil)) {
			self.verDoListento(actor);
			return nil;
		}

		return true;
	}
	islistener(actor) = { return nil; }
	// can't put stuff into (on, under, behind) things by default
	acceptsput(actor, loctype) = {
		return nil;
	}
	
	//
	// Sense path determination
	//
	// These methods return true if there is a clear path from
	// this Thing to the given desination object for a particular
	// sense. To determine this, we walk up the containment hierarchy
	// to find the lowest common ancestor between the thing and the
	// object.
	//
	// We have a general method blocksreach that returns the first
	// object in the hierarchy that blocks the given sense from
	// passing through.  (Nil, therefore, indicates that the sense
	// can pass all the way through.)
	//	
	// Note that the Xpath messages should not include initial caps
	// or final punctuation.  When methods that get called indirectly
	// by Xpath methods (like istakeable, or passcanseein, etc.) print
	// things, the Xpath methods set a global flag global.canoutput
	// which Thing.cantReach uses to properly format the explanation of
	// why the action failed.  This is a gross hack, but it works.
	//
	// Also note that blocksreach can print stuff -- this happens
	// when &sensein or &senseout print stuff when they fail.  (At
	// the moment, we don't allow these methods to print things
	// when they succeed.  They should also never change game state.)
	//
	blocksreach(obj, loctype, sensein, senseout, senseacross, outself, inobj) = {
		local selfparents := [], sploctype := [], splen;
		local objparents := [], oploctype := [], oplen;
		local p := nil, lt := nil;
		local i, ci;
		local across := true;
		local lca;
		local lcac_p, lcac_o;

		//
		// Fail if obj = nil
		//
		if (obj = nil) {
			"*** ERROR: <<self.sdesc>>.blocksreach called with obj = nil\n";
			return TOP;	// not quite right, but we need to return some object
		}

		// Find all parents of self
		// If the containment ends (in nil) before reaching
		// TOP, put [NIL TOP] at the end of the list.
		p := self.location;
		lt := self.locationtype;
		while (p <> nil) {
			selfparents += p;
			sploctype += lt;
			lt := p.locationtype;
			p := p.location;
		}
		splen := length(selfparents);
		if (splen = 0 or selfparents[splen] <> TOP) {
			selfparents += [NIL TOP];
			sploctype += ['in' 'in'];
			splen += 2;
		}
	
		// Find all parents of object
		// If the containment ends (in nil) before reaching
		// TOP, put [NIL TOP] at the end of the list.
		p := obj.location;
		lt := obj.locationtype;
		while (p <> nil) {
			objparents += p;
			oploctype += lt;
			lt := p.locationtype;
			p := p.location;
		}
		oplen := length(objparents);
		if (oplen = 0 or objparents[oplen] <> TOP) {
			objparents += [NIL TOP];
			oploctype += ['in' 'in'];
			oplen += 2;
		}

		if (global.debugreach) {
			local z;

			"\bblocksreach: <<self.sdesc>>: [ ";
			for (z := 1; z <= length(selfparents); z++)
				"(<<selfparents[z].sdesc>>) ";
			" ]\nblocksreach: <<obj.sdesc>>: [ ";
			for (z := 1; z <= length(objparents); z++)
				"(<<objparents[z].sdesc>>) ";
			" ]\n";				
		}		

		//
		// Find first differing parent, starting from the
		// ends of the lists and moving backwards.  The
		// element preceding the first differing element
		// is the lowest common ancestor.
		//
		// If all the elements in both lists are the same,
		// there are two cases:
		//
		// 1. There is nothing between the lowest common
		//    ancestor and one of the objects; i.e., one
		//    of the objects is contained directly in the
		//    lowest common ancestor and hence there is
		//    no differing parent.
		//
		// 2. One of the objects is contained in the other
		//    object.
		//
		// In both cases the immediate parent of the object
		// with the short list is the lowest common ancestor.
		// In case 2, we skip the sense ACROSS the common
		// ancestor.
		//
		for (ci := 0; ; ci++) {
			if (ci >= splen and ci >= oplen) {
				// obj = self
				// common ancestor is parent
				ci--;
				lca := selfparents[splen - ci];
				break;
			}
			else if (ci >= splen or ci >= oplen) {
				//
				// If last element in short list
				// is other object, this is case
				// 2 above, where the object with
				// the longer list is contained in
				// the object with the shorter list.
				//
				if (ci >= oplen and selfparents[splen - ci] = obj or
				    ci >= splen and objparents[oplen - ci] = self) {
						across := nil;
				}
				else {
					// Otherwise, case 1
					ci--;
				}
				
				if (ci >= oplen)
					lca := selfparents[splen - ci];
				else
					lca := objparents[oplen - ci];

				break;
			}

			if (selfparents[splen - ci] <> objparents[oplen - ci]) {
				ci--;
				lca := selfparents[splen - ci];
				break;
			}
		}

		//
		// Determine the child of the lowest common ancestor
		// on the self and object sides.  These tell us
		// how the objects are contained (in, on, under, behind)
		// the lowest common ancestor.
		//
		if (splen - ci - 1 < 1)
			lcac_p := self;
		else
			lcac_p := selfparents[splen - ci - 1];
		if (oplen - ci - 1 < 1)
			lcac_o := obj;
		else
			lcac_o := objparents[oplen - ci - 1];
							
		//
		// Run through the whole check if we're debugging.
		//
		if (global.debugreach) {
			"Least common ancestor is <<lca.sdesc>>\n";
			"Child of LCA (self) is <<lcac_p.sdesc>>\n";
			"Child of LCA (obj) is <<lcac_o.sdesc>>\n";
			
			"Reach trace:\b";

			if (outself) {
				" OUT [<<loctype>>] of [<<self.sdesc>>]\n";
				if (not self.(senseout)(self, obj, loctype))
					" (*)\n";
			}
						
			i := 1;
			while (i < splen - ci) {
				p := selfparents[i];
				if (p <> nil) {
					" OUT of [<<p.sdesc>>]\n";
					if (not p.(senseout)(self, obj, sploctype[i]))
						" (*)\n";
				}
				else
					" OUT of [nil] (*)\n";

				i++;			
			}

			if (across) {
				p := lca;
				if (p <> nil) {
					" ACROSS [<<p.sdesc>>]\n";
					if (not p.(senseacross)(self, obj,
						lcac_p.locationtype,
						lcac_o.locationtype))
						" (*)\n";
				}
				else
					" ACROSS [nil] (*)\n";
			}
			
			i := oplen - ci - 1; // (-1): skip common ancestor
			while (i > 0) {
				p := objparents[i];

				if (p <> nil) {
					" IN [<<p.sdesc>>]\n";
					if (not p.(sensein)(self, obj, oploctype[i]))
						" (*)\n";
				}
				else
					" IN [nil] (*)\n";

					i--;
			}
			
			if (inobj) {
				" IN [<<loctype>>] of [<<obj.sdesc>>]\n";
				if (not obj.(sensein)(self, obj, loctype))
					" (*)\n";
			}
			
			"\bEnd of reach trace.\n";
		}

		//
		// If we're to check that we can sense out of
		// ourselves, do so.
		//
		if (outself) {
			if (not self.(senseout)(self, obj, loctype))
				return self;
		}

		//
		// Now we traverse the containment hierarchy up from
		// ourselves to the lowest common ancestor (but not including
		// the ancestor), making sure that each parent allows us
		// to sense OUT.
		//
		i := 1;
		while (i < splen - ci) {
			p := selfparents[i];

			if (not p.(senseout)(self, obj, sploctype[i]))
				return p;

			i++;			
		}		

		//
		// Now check to see that we can sense ACROSS the lowest
		// common ancestor.
		//
		if (across) {
			p := lca;
			if (not p.(senseacross)(self, obj,
				lcac_p.locationtype,
				lcac_o.locationtype))
				return p;
		}
		
		//
		// Now we traverse the containment hierarchy down from 
		// the lowest common ancestor to the object, making sure
		// that each container allows us to sense IN.
		//
		// The order here is crucial, because we want to return
		// the *first* thing that blocks the sense on the
		// containment path from the source to the destination.
		//
		i := oplen - ci - 1; // (-1): skip common ancestor
		while (i > 0) {
			p := objparents[i];

			if (not p.(sensein)(self, obj, oploctype[i]))
				return p;

			i--;
		}

		//
		// If we're to check that we can sense into 
		// the object, do so.
		//	
		if (inobj) {
			if (not obj.(sensein)(self, obj, loctype))
				return obj;
		}

		//
		// Nothing blocks the sense!
		//
		return nil;
	}
	
	// Is there a line of sight to the object?
	seepath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanseein, &passcanseeout, &passcanseeacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanseein, &passcanseeout, &passcanseeacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> blocks
				<<self.possessivedesc>> view of
				<<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	// Is there a clear touch path to the object?
	touchpath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantouchin, &passcantouchout, &passcantouchacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantouchin, &passcantouchout, &passcantouchacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<self.subjprodesc>> can't reach 
				<<obj.objthedesc(self)>> --
				\ <<b.subjthedesc>>
				\ <<b.is>> in the way";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	// Is there a clear take path to the object?
	takepath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantakein, &passcantakeout, &passcantakeacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantakein, &passcantakeout, &passcantakeacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> prevents
				<<self.objprodesc(nil)>> from taking
				<<obj.objthedesc(nil)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	// Is there a clear smell path to the object?
	smellpath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcansmellin, &passcansmellout, &passcansmellacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcansmellin, &passcansmellout, &passcansmellacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> prevents
				<<self.objprodesc(nil)>> from smelling
				<<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	// Is there a clear hear path to the object?
	hearpath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanhearin, &passcanhearout, &passcanhearacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanhearin, &passcanhearout, &passcanhearacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> prevents
				<<self.objprodesc(nil)>> from hearing
				<<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	// Is there a clear speak-to path to the object?
	speaktopath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanspeaktoout, &passcanspeaktoin, &passcanspeaktoacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanspeaktoout, &passcanspeaktoin, &passcanspeaktoacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> prevents
				<<obj.objprodesc(nil)>> from hearing
				<<self.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	
	// Is there a clear put-into path to the object?
	// This is really the same as taking (with the directions
	// reversed) but we want to print different failure reasons.
	putintopath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantakeout, &passcantakein, &passcantakeacross, nil, true);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantakeout, &passcantakein, &passcantakeacross, nil, true);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> prevents
				<<self.objprodesc(nil)>> from putting
				things in <<obj.objthedesc(nil)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}

	//
	// Things can't sense -- use a Sensor if you want these
	// capabilities.
	//
	// Note that the canX messages should not include initial
	// caps.
	//
	cansee(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't see anything.";

		return nil;
	}
	cantouch(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't touch anything.";

		return nil;
	}
	cantake(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't take anything.";

		return nil;
	}
	cansmell(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't smell anything.";

		return nil;
	}
	canhear(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't hear anything.";

		return nil;
	}
	canspeakto(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't say anything.";

		return nil;
	}
	canputinto(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> can't put anything anywhere.";

		return nil;
	}

	//
	// Can this Thing use obj as a topic?
	// I.e., as in
	//
	//	>ask troll about rabbit
	//
	// or
	//
	//	>tell troll about rabbit
	//
	istopic = nil
	isatopic(obj, loctype, silent) = {
		if (obj.istopic)
			return true;

		if (not silent)
			"something tells you <<obj.subjthedesc>> will
			not be a particularly productive topic.";

		return nil;
	}

	//
	// Can this Thing sense the contents of the given object?
	// Although Things can't see, we define these here since
	// they're in terms of the canX methods.
	//
	// If loctype is nil, we return the list of valid loctypes,
	// or nil if no loctype is valid.
	//
	canXcontents(obj, silent, loctype, cansense, sensein, senseout, senseacross, s) = {
		local	i;
		local	selfloctype;
		local	ok := [];
		local	lt;
		local	len := length(global.loctypes);
		local	ret;

		if (not self.(cansense)(obj, nil, silent))
			return nil;
			
		if (loctype <> nil)
			lt := find(global.loctypes, loctype);

		for (i := 1; i <= len; i++)
			ok += nil;

		if (self.iscontained(obj, nil)) {
			selfloctype := self.containmenttype(obj);
			Outhide(true);
			for (i := 1; i <= len; i++)
				ok[i] :=  obj.(senseacross)(self, nil, selfloctype, global.loctypes[i]);
			if (Outhide(nil) and loctype <> nil) {
				if (not silent and not ok[lt]) {
					obj.(senseacross)(self, nil, selfloctype, loctype);
					return nil;
				}
			}
		}
		else {
			Outhide(true);
			for (i := 1; i <= len; i++)
				ok[i] :=  obj.(sensein)(self, obj, global.loctypes[i]);
			if (Outhide(nil) and loctype <> nil) {
				if (not silent and not ok[lt]) {
					obj.(sensein)(self, obj, loctype);
					return nil;
				}
			}
		}
			
		if (loctype <> nil) {
			if (not silent and not ok[lt])
				"\^<<self.subjthedesc>> can't <<s>>
				\ <<obj.objthedesc(self)>>.";

			return ok[lt];
		}
		
		ret := [];
		for (i := 1; i <= length(ok); i++)
			if (ok[i])
				ret += global.loctypes[i];

		return ret;
	}
	canseecontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&cansee,
			&passcanseein,
			&passseeout, 
			&passcanseeacross,
			'see the contents of');
	}
	cantouchcontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&cantouch,
			&passcantouchin,
			&passtouchout, 
			&passcantouchacross,
			'touch the contents of');
	}
	cantakecontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&cantake,
			&passcantakein,
			&passcantakeout,
			&passcantakeacross,
			'take the contents of');
	}
	cansmellcontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&cansmell,
			&passcansmellin,
			&passcansmellout,
			&passcansmellacross,
			'smell the contents of');
	}
	canhearcontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&canhear,
			&passcanhearin,
			&passcanhearout,
			&passcanhearacross,
			'hear the contents of');
	}
	canspeaktocontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&canspeakto,
			&passcanspeaktoout,
			&passcanspeaktoin,
			&passcanspeaktoacross,
			'speak to the contents of');
	}
	canputintocontents(obj, silent, loctype) = {
		return self.canXcontents(obj, silent, loctype,
			&canputinto,
			&cantakeout,
			&cantakein,
			&passcantakeacross,
			'put anything into the contents of');
	}
	
	//
	// Psuedo-sense checks.	 Things can't do anything with numbers
	// or strings, so these always return nil.
	//
	canusealphanum(obj, loctype, silent) = {
	       if (not silent)
		       "that verb requires a double-quoted string or 
		       a number.";

	       return nil;
	}
	canusealpha(obj, loctype, silent) = {
		if (not silent)
		       "that verb requires a double-quoted string.";
	
		return nil;
	}
	canusenumber(obj, loctype, silent) = {
		if (not silent)
		       "that verb requires a number.";

		return nil;
	}
	canusenumberorlist(obj, loctype, silent) = {
		if (not silent)
		       "that verb requires a number or
		       parenthesized list of numbers.";

		return nil;
	}

	//
	// Sense passing
	//
	// These boolean-valued methods determine whether or
	// not this thing allows the various senses to pass
	// through on the way out of and into it.  The reason
	// for the distinction between "out of" and "into" is
	// that we want to be able to implement (for example)
	// one-way mirrors.
	//
	// The obj parameter is the object that's trying to
	// sense through us.  The loctype parameter is the
	// type of containment: 'in', 'on', 'under', 'behind', etc.
	// NOTE: The loctype parameter may be nil, in which case
	// the method should return true if *any* loctype is allowed.
	//
	// The across versions determine whether or not
	// something contained in the thing can sense
	// other things contained in the thing.	 For example,
	// you might not be able to see into a room from
	// outside, or outside the room from inside, but you
	// certainly might be able to see things on the
	// same side of the room.  While this may seem
	// pointless, we put it to good use for dark rooms.
	// Note that the across methods get two location
	// types -- one for self, and one for the object.
	// These are not necessarily the same as self.locationtype
	// and obj.locationtype, however -- there may be other
	// objects intervening between self and obj and the
	// lowest common ancestor between them.
	//
	passcansee(actor, obj, loctype) = { return true; }
	passcanseein(actor, obj, loctype) = {
		return self.passcansee(actor, obj, loctype);
	}
	passcanseeout(actor, obj, loctype) = {
		return self.passcansee(actor, obj, loctype);
	}
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcansee(actor, obj, nil));
	}

	passcantouch(actor, obj, loctype) = { return true; }
	passcantouchin(actor, obj, loctype) = {
		return self.passcantouch(actor, obj, loctype);
	}
	passcantouchout(actor, obj, loctype) = {
		return self.passcantouch(actor, obj, loctype);
	}
	passcantouchacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcantouch(actor, obj, nil));
	}

	// note that passcantakeX is also used for canputinto
	passcantake(actor, obj, loctype) = { return true; }
	passcantakein(actor, obj, loctype) = {
		return self.passcantake(actor, obj, loctype);
	}
	passcantakeout(actor, obj, loctype) = {
		return self.passcantake(actor, obj, loctype);
	}
	passcantakeacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcantake(actor, obj, nil));
	}

	passcansmell(actor, obj, loctype) = { return true; }
	passcansmellin(actor, obj, loctype) = {
		return self.passcansmell(actor, obj, loctype);
	}
	passcansmellout(actor, obj, loctype) = {
		return self.passcansmell(actor, obj, loctype);
	}
	passcansmellacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcansmell(actor, obj, nil));
	}

	passcanhear(actor, obj, loctype) = { return true; }
	passcanhearin(actor, obj, loctype) = {
		return self.passcanhear(actor, obj, loctype);
	}
	passcanhearout(actor, obj, loctype) = {
		return self.passcanhear(actor, obj, loctype);
	}
	passcanhearacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcanhear(actor, obj, nil));
	}

	passcanspeakto(actor, obj, loctype) = { return true; }
	passcanspeaktoin(actor, obj, loctype) = {
		return self.passcanspeakto(actor, obj, loctype);
	}
	passcanspeaktoout(actor, obj, loctype) = {
		return self.passcanspeakto(actor, obj, loctype);
	}
	passcanspeaktoacross(actor, obj, selfloctype, objloctype) = {
		return (selfloctype = objloctype and self.passcanspeakto(actor, obj, nil));
	}

	//
	// Move the Thing into another container.
	// Here we assume that the destination is a container.
	// Calling this on a Thing that has a method location is OK,
	// but the Thing's location won't be changed.
	//
	// lttm is a list of contents' locationtypes to move.
	// Normally when we move something we don't want to move contents
	// that are, for example, behind their containers.  (For example,
	// if the player takes a chair, and there is a mouse under the
	// chair, the player shouldn't get the mouse, even though it
	// is technically "contained in" the chair.  Furthermore, once the
	// chair is moved, we have to change the mouse's location to be
	// the same as the chair's location was.)
	//
	// If lttm is nil, all location types are moved.  (This is almost
	// always wrong, however!)
	//
	// Returns true if the move actually happened, if the move got
	// prevented for some reason.
	//
	moveinto(obj, loctype, lttm) = {
		local	i, l, len := 0, oldloc, oldloctype;
		local	a;

		//
		// If we're already directly contained in the
		// destination object, do nothing.  We need this
		// for Attachables.
		//
		if (self.location = obj and self.locationtype = loctype)
			return nil;
		
		// Sanity check
		if (find(global.loctypes, loctype) = nil) {
			"\^<<self.subjthedesc>>.moveinto(<<obj.subjthedesc>>,
			\ <<loctype>>): loctype unknown\n";

			return nil;
		}

		oldloc := self.location;
		oldloctype := self.locationtype;
		
		//
		// Notify container we're moving out of and container
		// we're moving into that we're moving.
		//
		self.notifycontainers(obj, loctype);

		//
		// Remove ourselves from parent's contents list.
		// Remove our Parts from our previous location's
		// contents list.
		// 
		l := self.parts;
		len := length(l);
		if (self.location) {
			self.location.contents -= self;

			for (i := 1; i <= len; i++)
				self.location.contents -= l[i];
		}
		
		//
		// Now update locations and locationtypes.
		//
		self.setlocation(obj);
		if (obj) {
			obj.contents += self;
			self.setlocationtype(loctype);

			// Add our Parts to the new location's contents list
			for (i := 1; i <= len; i++)
				obj.contents += l[i];
		}
		else {
			// Things are always *in* nil.
			self.setlocationtype('in');
		}

		//
		// Walk up the containment hierarchy.  If we get an
		// actor, make the object and all its contents known
		// to the actor in case they aren't already.  (This
		// is to handle cases where the game will explicitly
		// move something out of nil and into the actor.)
		//
		a := obj;
		while (a <> nil) {
			if (isclass(a, Actor) and not self.isknownto(a)) {
				self.makeknownto(a);
				self.makecontentsknownto(a);
			}

			a := a.location;
		}

		//
		// Now fix locations and locationtypes of contents
		// that do not get moved.
		//

		//
		// If lttm is nil, all contents get moved.
		//
		if (lttm = nil)
			return true;
	
		l := self.contents;
		len := length(l);
		for (i := 1; i <= len; i++) {
			if (find(lttm, l[i].locationtype) = nil) {
				// This thing shouldn't get moved -- fix up
				// its location and locationtype fields.
				self.contents -= l[i];
				l[i].setlocation(oldloc);
				l[i].setlocationtype(oldloctype);
				l[i].location.contents += l[i];
			}
		}

		return true;
	} 
	moveto(obj, loctype) = { return self.moveinto(obj, loctype, global.loctake); }
	movein(obj) = { return self.moveinto(obj, 'in', global.loctake); }
	moveon(obj) = { return self.moveinto(obj, 'on', global.loctake); }
	moveunder(obj) = { return self.moveinto(obj, 'under', global.loctake); }
	movebehind(obj) = { return self.moveinto(obj, 'behind', global.loctake); }

	//
	// Notify container we're moving out of and into that
	// we're moving.
	//
	notifycontainers(obj, loctype) = {
		local	i, l, len;

		//
		// Notify new location that we're moving in and
		// see if it approves.  Also notify current
		// location we're moving out and see if it approves.
		//
		if (self.location)
			self.location.movingout(self, obj, loctype);
		if (obj)
			obj.movingin(self, loctype);

		//
		// Now notify old and new locations about Part
	 	// movements.
		//
		l := self.parts;
		len := length(self.parts);
		for (i := 1; i <= len; i++) {
			if (self.location)
				self.location.movingout(l[i], obj, loctype);
			if (obj)
				obj.movingin(l[i], loctype);
		}

		return true;
	}

	//
	// movingout gets called whenever an object gets moved
	// out of this Thing.  The object's location and locationtype
	// fields will still be set for the old location (this Thing) --
	// the new location and locationtype are given by the 
	// tolocation and toloctype parameters.
	//
	// This routine gets notified about Parts too.
	//
	// WARNING:  Some verbs that intuitively involve taking
	// the direct object do not call moveinto.  For example,
	// shootVerb specifies &cantake as a requirement, but
	// one hardly expects doShoot to actually call moveinto
	// to move the gun into the player's inventory.  So you
	// need to be aware of these "transient grabs".
	//
	movingout(obj, tolocation, toloctype) = { }

	//
	// movingin gets called whenver an object gets moved into
	// this Thing.  obj will still be in its old location and
	// in its old location's contents list. 
	//
	// See comment for movingout above for more info.
	//
	movingin(obj, loctype) = { }

	//
	// Return true if the Thing is contained in the object.
	// Note that unlike the standard TADS isIn method, this
	// doesn't care whether or not the containers pass
	// visibility.	The loctype parameter specifies the kind
	// on containment ('in', 'on', 'under', 'behind', etc.)
	//
	// This is a little tricky.  We say that A is contained *in* B
	// if A is either directly contained *in* B or if A is *in*,
	// *on*, *under*, *behind*, etc. something that is directly
	// contained *in* B.
	//
	// For example, a key *on* a book which is *behind* a table
	// is not contained *in* the table, but it is "contained"
	// *behind* the table.
	//
	// This code also assumes that the location types are all
	// orthogonal and transitive -- i.e., that being "on" something
	// does not have any effect on whether it's "under" (etc.) something
	// else, and that if A is "on" B and B is "on" C, then A is "on" C.
	//
	// While this isn't really true in real life (for example, you can
	// have a key *on* a table which is *under* an umbrella, but the key
	// itself might not be *under* the umbrella), it's probably
	// enough for the level of detail we require here.
	//
	// If loctype is nil, any kind of containment is OK.
	//
	// containmenttype returns the locationtype our ancestor that's
	// contained in obj, or nil if no such ancestor exists.
	//
	// We have to handle the case "iscontainedX(nil ...)" specially,
	// since technically everything has nil as an eventual parent.
	// If we get to TOP before nil, the object is not "in" nil;
	// otherwise it is.
	//
	iscontainedX(obj, loctype, boolean) = {
		local p := self;

		//
		// Find parent (or self) p such that p.location = obj.
		//
		while (p <> nil and p <> TOP) {
//			"iscontainedX: p = \"<<p.sdesc>>\" ";
//			if (p.location <> nil)
//				"p.location = \"<<p.location.sdesc>>\"\n";

			if (p.location = obj)
				break;
			else
				p := p.location;
		}

		if (p = nil) {
			if (obj = nil)
				return true;
			else
				return nil;
		}
		else if (p = TOP) {
			if (obj = TOP)
				return true;
			else
				return nil;
		}
		else if (loctype = nil or p.locationtype = loctype) {
			if (boolean)
				return true;
			else 
				return p.locationtype;
		}
		else
			return nil;
	}
	containmenttype(obj) = { return self.iscontainedX(obj, nil, nil); }
	iscontained(obj, loctype) = {
		return self.iscontainedX(obj, loctype, true);
	}
	isin(obj) = { return self.iscontained(obj, 'in'); }
	ison(obj) = { return self.iscontained(obj, 'on'); }
	isunder(obj) = { return self.iscontained(obj, 'under'); }
	isbehind(obj) = { return self.iscontained(obj, 'behind'); }
	
;
// more stuff for thing, but the compiler can't handle such a big definition
modify Thing
	//
	// The usual rigamarole -- lots of ver methods that
	// tell the player what he can't do.
	//
	// Many of the ver methods are unnecessary since
	// the requirements in the verbs will catch
	// a lot of stuff.  For example, verDoPutX tells
	// the player he can't put the Thing anywhere
	// (Item overrides this) -- but this should never
	// get called because putVerb requires cantake, which
	// Things will return nil for (because verDoTake
	// prints something).
	//

	//
	// Generic "you can't do that" message.
	//
	verDoX(actor, v) = {
		"%You% can't <<v.sdesc>> <<self.objthedesc(actor)>>.";
	}
	
	//
	// Actions that take only direct objects.
	// These are in alphabetical order.
	//
	verDoBoard(actor) = { self.verDoX(actor, boardVerb); }
	verDoBreak(actor) = { self.verDoX(actor, breakVerb); }
	verDoClean(actor) = {
		"\^<<actor.possessivedesc>> efforts to clean
		<<self.objthedesc(actor)>> have little effect.";
	}
	verDoClimb(actor) = { self.verDoX(actor, climbVerb); }
	verDoClose(actor) = { self.verDoX(actor, closeVerb); }
	verDoDetach(actor) = { self.verDoX(actor, detachVerb); }
	verDoDrink(actor) = { self.verDoX(actor, drinkVerb); }
	
	verDoDrop(actor) = { self.verDoX(actor, dropVerb); }
	verDoEat(actor) = {
		"Now why would %you% want to eat <<self.objthedesc(actor)>>?";
	}
	verDoEnter(actor) = { 
		"%You% can't enter <<self.objthedesc(actor)>>.";
	}
	verDoExit(actor) = {
		"%You% can't exit <<self.objthedesc(actor)>>.";
	}
	verDoFasten(actor) = { self.verDoX(actor, fastenVerb); }
	verDoFlip(actor) = { self.verDoX(actor, flipVerb); }
	
	verDoFollow(actor) = { self.verDoX(actor, followVerb); }
	verDoGetin(actor) = { self.verDoX(actor, getinVerb); }
	verDoGetoff(actor) = { self.verDoX(actor, getoffVerb); }
	verDoGeton(actor) = { self.verDoX(actor, getonVerb); }
	verDoGetout(actor) = { self.verDoX(actor, getoutVerb); }
	verDoGetoutfrombehind(actor) = {
		self.verDoX(actor, getoutfrombehindVerb);
	}
	verDoGetoutfromunder(actor) = {
		self.verDoX(actor, getoutfromunderVerb);
	}
	verDoGetunder(actor) = { self.verDoX(actor, getunderVerb); }
	verDoGetbehind(actor) = { self.verDoX(actor, getbehindVerb); }
	verDoHit(actor) = {
		"There's no reason to get huffy!";
	}	
	verDoInspect(actor) = {}
	doInspect(actor) = { self.ldesc; }

	verDoKick(actor) = {
		"There's no reason to get huffy!";
	}
	verDoLiein(actor) = { self.verDoLieon(actor); }
	doLiein(actor) = { self.doLieon(actor); }
	verDoLieon(actor) = { self.verDoX(actor, lieonVerb); }
	verDoListento(actor) = {}
	doListento(actor) = { self.listendesc; } 
	verDoLookbehind(actor) = {
		"Trying to look behind <<self.objthedesc(actor)>> doesn't
		gain %you% anything.";		
	}
	verDoLookin(actor) = {
		"%You% have no way of looking inside <<self.objthedesc(actor)>>.";
	}
	verDoLookon(actor) = {
		"There's nothing on <<self.objthedesc(nil)>>.";
	}
	verDoLookthrough(actor) = {
		"%You% can't look through <<self.objthedesc(actor)>>.";
	}
	verDoLookunder(actor) = {
		"Trying to look under <<self.objthedesc(actor)>> doesn't
		gain %you% anything.";		
	}
	verDoMove(actor) = { self.verDoX(actor, moveVerb); }
	verDoMoveN(actor) = { self.verDoMove(actor); }
	verDoMoveE(actor) = { self.verDoMove(actor); }
	verDoMoveS(actor) = { self.verDoMove(actor); }
	verDoMoveW(actor) = { self.verDoMove(actor); }
	verDoMoveNE(actor) = { self.verDoMove(actor); }
	verDoMoveNW(actor) = { self.verDoMove(actor); }
	verDoMoveSE(actor) = { self.verDoMove(actor); }
	verDoMoveSW(actor) = { self.verDoMove(actor); }

	verDoOpen(actor) = { self.verDoX(actor, openVerb); }
	verDoPoke(actor) = {
		"Poking <<self.objthedesc(actor)>> doesn't seem to
		have much effect.";
	}
	verDoPull(actor) = {
		"Pulling on <<self.objthedesc(actor)>> doesn't seem to
		have much effect.";
	}
	verDoPush(actor) = {
		"Pushing <<self.objthedesc(actor)>> doesn't seem to
		have much effect.";
	}
	verDoRead(actor) = {
		"\^<<self.subjthedesc>> <<self.doesnt>> have
		any text on <<self.objprodesc(nil)>>.";
	}
	verDoScrew(actor) = { self.verDoX(actor, screwVerb); }
	verDoSearch(actor) = {
		if (global.searchisexamine)
			self.verDoInspect(actor);
	}
	doSearch(actor) = {
		if (global.searchisexamine)
			self.doInspect(actor);
		else {
			"%You% <<searchVerb.desc(actor)>>
			\ <<self.objthedesc(actor)>>, but
			<<actor.doesnt>> find anything.";
		}
	}
	verDoSitin(actor) = { self.verDoX(actor, sitinVerb); }
	verDoSiton(actor) = { self.verDoX(actor, sitonVerb); }
	verDoSmell(actor) = { }
	doSmell(actor) = { self.smelldesc; } 
	verDoStand(actor) = { "%You% can't stand here."; }
	verDoSwitch(actor) = { self.verDoX(actor, switchVerb); }
	verDoTake(actor) = { self.verDoX(actor, XtakeVerb); }
	verDoTaste(actor) = {}
	doTaste(actor) = { self.tastedesc; }
	verDoTieto(actor, io) = { self.verDoX(actor, tieVerb); }
	verDoTouch(actor) = {}
	doTouch(actor) = { self.touchdesc; } 
	verDoTurn(actor) = { self.verDoX(actor, turnVerb); }
	verDoTurnoff(actor) = { self.verDoX(actor, turnoffVerb); }
	verDoTurnon(actor) = { self.verDoX(actor, turnonVerb); }
	verDoUnfasten(actor) = { self.verDoX(actor, unfastenVerb); }
	verDoUnplug(actor) = { self.verDoX(actor, unplugVerb); }
	verDoUntie(actor) = { self.verDoX(actor, untieVerb); }
	verDoUnscrew(actor) = { self.verDoX(actor, unscrewVerb); }
	verDoUnwear(actor) = {
		"%You% <<actor.isnt>> wearing <<self.objthedesc(actor)>>.";
	}
	verDoWear(actor) = { self.verDoX(actor, wearVerb); }

	//
	// Actions that take indirect objects
	// These are in alphabetical order.
	//
	verDoAskabout(actor, io) = {
		"%You% can't ask <<io.objthedesc(actor)>> about
		anything.";
	}
	verIoAskabout(actor) = {}
	ioAskabout(actor, dobj) = { dobj.doAskabout(actor, self); }
	verDoAskfor(actor, io) = {
		"%You% can't ask <<io.objthedesc(actor)>> for
		anything.";
	}
	verIoAskfor(actor) = {}
	ioAskfor(actor, dobj) = { dobj.doAskfor(actor, self); }
	verDoAttachto(actor, io) = {
		"%You% can't attach <<self.objthedesc(actor)>> to anything.";
	}
	verIoAttachto(actor) = {
		"%You% can't attach anything to <<self.objthedesc(actor)>>.";
	}
	verDoAttackwith(actor, io) = {
		"Attacking <<self.objthedesc(actor)>>, while perhaps satisfying,
		would achieve little.";
	}
	verIoAttackwith(actor) = {
		"%You% can't attack anything with <<self.objthedesc(actor)>>.";
	}
	ioAttackwith(actor, dobj) = { dobj.doAttackwith(actor, self); }
	verDoCleanwith(actor, io) = { self.verDoClean(actor); }
	verIoCleanwith(actor) = {
		"\^<<self.subjthedesc>> <<self.isnt>> useful for
		cleaning things.";
	}
	verDoDetachfrom(actor, io) = { self.verDoDetach(actor); }
	verIoDetachfrom(actor) = {
		"There's nothing attached to <<self.objthedesc(actor)>>.";
	}
	verDoDigwith(actor, io) = {
		"%You% can't dig in <<self.objthedesc(actor)>>.";
	}
	verIoDigwith(actor) = {
		"\^<<self.subjthedesc>> <<self.isnt>> useful for digging.";
	}
	verDoGiveto(actor, io) = {
		"%You% can't give <<self.objthedesc(actor)>> to anyone.";
	}
	verIoGiveto(actor) = {
		"%You% can't give things to <<self.objthedesc(actor)>>.";
	}
	ioGiveto(actor, dobj) = { dobj.doGiveto(actor, self); }
	verDoHitwith(actor, io) = { self.verDoHit(actor); }
	verIoHitwith(actor) = {
		"Hitting things with <<self.objthedesc(actor)>> isn't helpful.";
	}
	verDoLock(actor) = { "%You% can't lock <<self.objthedesc(actor)>>."; }
	verDoLockwith(actor, io) = { self.verDoLock(actor); }
	verIoLockwith(actor) = {
		"%You% can't lock things with <<self.objthedesc(actor)>>.";
	}
	verDoMovewith(actor, io) = { self.verDoMove(actor); }
	verIoMovewith(actor) = {
		"%You% can't move things with <<self.objthedesc(actor)>>.";
	}
	verDoPlugin(actor, io) = {
		"%You% can't plug <<self.objthedesc(actor)>> into anything.";
	}
	verIoPlugin(actor) = {
		"%You% can't plug anything into <<self.objthedesc(actor)>>.";
	}

	//
	// Put
	//
	verDoPutX(actor, io, loctype) = {
		"%You% can't put <<self.objthedesc(actor)>> anywhere.";
	}
	verDoPutin(actor, io) = { self.verDoPutX(actor, io, 'in'); }
	verDoPuton(actor, io) = { self.verDoPutX(actor, io, 'on'); }
	verDoPutunder(actor, io) = { self.verDoPutX(actor, io, 'under'); }
	verDoPutbehind(actor, io) = { self.verDoPutX(actor, io, 'behind'); }
	verDoPutthrough(actor, io) = {
		"%You% can't put <<self.objthedesc(actor)>> anywhere.";
	}

	verIoPutin(actor) = {
		"%You% can't put anything in <<self.objthedesc(actor)>>.";
	}
	verIoPuton(actor) = {
		"%You% can't put anything on <<self.objthedesc(actor)>>.";
	}
	verIoPutunder(actor) = {
		"%You% can't put anything under <<self.objthedesc(actor)>>.";
	}
	verIoPutbehind(actor) = {
		"%You% can't put anything behind <<self.objthedesc(actor)>>.";
	}
	verIoPutthrough(actor) = {
		"%You% can't put anything through <<self.objthedesc(actor)>>.";
	}
	
	verDoScrewwith(actor, io) = { self.verDoScrew(actor); }
	verIoScrewwith(actor) = {
		"%You% can't screw anything with <<self.objthedesc(actor)>>.";
	}
	verDoShootat(actor, io) = {
		"%You% can't shoot anything with <<self.objthedesc(actor)>>.";		
	}
	verIoShootat(actor) = {
		"Shooting <<self.objthedesc(actor)>> wouldn't help %you% any.";
	}
	verDoShootwith(actor, io) = {
		"Shooting <<self.objthedesc(actor)>> wouldn't help %you% any.";
	}
	verIoShootwith(actor) = {
		"%You% can't shoot anything with <<self.objthedesc(actor)>>.";		
	}
	verDoShowto(actor, io) = {}
	verIoShowto(actor) = {
		"%You% can't show things to <<self.objthedesc(actor)>>.";
	}

	//
	// Take
	//
	verIoTakefrom(actor) = {
		"%You% can't take anything from <<self.objthedesc(actor)>>.";
	}
	verIoTakeoff(actor) = {
		"%You% can't take anything off <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% can't take anything out of <<self.objthedesc(actor)>>.";
	}
	verIoTakeunder(actor) = {
		"%You% can't take anything out from
		under <<self.objthedesc(actor)>>.";
	}
	verIoTakebehind(actor) = {
		"%You% can't take anything from behind <<self.objthedesc(actor)>>.";
	}

	verDoTellabout(actor, io) = {
		"%You% can't tell <<self.objthedesc(actor)>> about anything.";
	}
	verIoTellabout(actor) = {}
	ioTellabout(actor, dobj) = { dobj.doTellabout(actor, self); }

	verDoTellto(actor, io) = { io.verDoTellabout(actor, self); }
	verIoTellto(actor) = {}
	ioTellto(actor, dobj) = { self.doTellabout(actor, dobj); }

	//
	// Throw
	//
	verDoThrowX(actor, io) = {
		"%You% can't throw <<self.objthedesc(actor)>>.";
	}
	verDoThrowat(actor, io) = { self.verDoThrowX(actor, io); }
	verIoThrowat(actor) = {
		"Throwing things at <<self.objthedesc(actor)>> isn't helpful.";
	}
	verDoThrowbehind(actor, io) = { self.verDoThrowX(actor, io); }
	verIoThrowbehind(actor) = {
		"%You% can't throw things behind <<self.objthedesc(actor)>>.";
	}
	verDoThrowthrough(actor, io) = { self.verDoThrowX(actor, io); }
	verIoThrowthrough(actor) = {
		"%You% can't throw things through <<self.objthedesc(actor)>>.";
	}
	verDoThrowto(actor, io) = { self.verDoThrowX(actor, io); }
	verIoThrowto(actor) = {
		"%You% can't throw things to <<self.objthedesc(actor)>>.";
	}
	verDoThrowunder(actor, io) = { self.verDoThrowX(actor, io); }
	verIoThrowunder(actor) = {
		"%You% can't throw things under <<self.objthedesc(actor)>>.";
	}
	
	verDoTouchwith(actor, io) = { self.verDoTouch(actor); }
	verIoTouchwith(actor) = {}
	ioTouchWith(actor, dobj) = {
		"Nothing unusual happens when you touch
		<<dobj.objthedesc(actor)>> with <<self.objthedesc(actor)>>.";
	}
	verDoTurnto(actor, io) = {
		"%You% can't turn <<self.objthedesc(actor)>> to anything.";
	}
	verIoTurnto(actor) = {
		"%You% can't turn anything to <<self.objthedesc(actor)>>.";
	}
	verIoTypeon(actor) = {
		"%You% can't type anything on <<self.objthedesc(actor)>>.";
	}
	verDoUnlock(actor) = { "%You% can't unlock <<self.objthedesc(actor)>>."; }
	verDoUnlockwith(actor, io) = { self.verDoUnlock(actor); }
	verIoUnlockwith(actor) = {
		"%You% can't unlock things with <<self.objthedesc(actor)>>.";
	}
	verDoUnplugfrom(actor, io) = {
		"%You% can't unplug <<self.objthedesc(actor)>> from anything.";
	}
	verIoUnplugfrom(actor) = {
		"%You% can't unplug anything from <<self.objthedesc(actor)>>.";
	}
	verDoUntiefrom(actor, io) = {
		"%You% can't untie <<self.objthedesc(actor)>> from anything.";
	}
	verIoUntiefrom(actor) = {
		"%You% can't untie anything from <<self.objthedesc(actor)>>.";
	}
	verDoUnscrewwith(actor, io) = { self.verDoUnscrew(actor); }
	verIoUnscrewwith(actor) = {
		"%You% can't unscrew anything with <<self.objthedesc(actor)>>.";
	}
	
	//
	//
	// Testing stuff
	//
	verDoGimme(actor) = {}
	doGimme(actor) = {
		"You cheater!";
		self.movein(actor);
	}
	verDoLocate(actor) = {}
	doLocate(actor) = {
		local	loc, lt;

		self.sdesc; " <<upper(self.locationtype)>> ";

		loc := self.location;
		if (loc = nil) {
			"nil";
			return;
		}
		else
			loc.sdesc;
 
		lt := loc.locationtype;
		loc := loc.location;
		while (loc <> nil and loc <> TOP) {
			" <<upper(lt)>> <<loc.sdesc>>";
			lt := loc.locationtype;
			loc := loc.location;
		}
	
		if (loc = TOP)
			" IN <<TOP.subjthedesc>>";
	}
	verDoWarpto(actor) = {}
	doWarpto(actor) = {
		"You are transported!"; P();
		Me.travelto(self);
	}
	verDoKnow(actor) = {}
	doKnow(actor) = {
		"You get a sudden burst of omniscience!";

		self.makeknownto(actor);
	}
	verDoWeight(actor) = {}
	doWeight(actor) = {
		local tot;
		
		tot := self.contentsweight(actor, ['in' 'on']);
		if (isclass(self, Item))
			tot += self.weight;

		"\^<<self.subjthedesc>> weighs <<tot>> units.";
	}
	verDoBulk(actor) = {}
	doBulk(actor) = {
		local tot;
		
		tot := self.contentsbulk(actor, ['in' 'on']);
		if (isclass(self, Item))
			tot += self.bulk;

		"\^Bulk of <<self.objthedesc(nil)>> is <<tot>> units.";
	}
;
//
// Floating objects are objects that are in more than one place, either
// at a single time, or over the course of the game.
//
// Note that a Floating is never implicitly made known to an actor by
// the rest of WorldClass, because it never appears in contents lists.
// For this reason, Floatings are known to all actors by default --
// you can disable this by setting known to nil. 
//
class Floating: Thing
	known = true
	isknownto(actor) = {
		if (self.known)
			return true;
		else
			return inherited.isknownto(actor);
	}

	// location is method
	locationOK = true
;
//
// An Everywhere is in every location.
// It can be a container, but you must be careful here, since if
// multiple actors put things in it, they'll all have access to
// all the contained items.  (I.e., even though an Everywhere may
// appear to be multiple copies of the same object, it isn't.)
//
class Everywhere: Floating
	//
	// If the actor's location has the following property,
	// this method will override the Everywhere.  Specifically,
	// if the property is nil, the Everywhere won't appear
	// in the location.
	//
	roomprop = nil
	
	//
	// If the actor's location has the following property,
	// and this Everywhere actually appears in the location
	// (accorindg to roomprop above), this method will be
	// called in place of this Everywhere's ldesc.	This
	// allows you to customize the description of an
	// Everywhere in certain rooms just by defining a method
	// in those rooms.
	//
	roomdescprop = nil

	lastlocation = nil
	location = {
		if (global.lastactor = nil)
			self.lastlocation := nil;
		else if (global.lastactor.location = self)
			; // self.lastlocation stays the same
		else if (global.lastactor.location = nil)
			self.lastlocation := nil;
		else if (self.roomprop and global.lastactor.location.(self.roomprop) <> true)
			self.lastlocation := nil;
		else
			self.lastlocation := global.lastactor.location;

		return self.lastlocation;
	}

	ldesc = {
		local	actor := global.lastactor;

		if (self.roomdescprop and defined(actor.location, self.roomdescprop))
				actor.location.(self.roomdescprop);
		else
			"\^<<actor.subjthedesc>> <<actor.doesnt>> see
			anything unusual about <<self.objthedesc(actor)>>.";
	}
;
//
// Special classes and objects the parser uses.
//
// Note about strObj and numObj: the parser does not call the usual
// methods on the verb to check the validity of these objects, so
// the error messages for these will be different.
//
class String: Thing
	value = ''	// parser magically sets this to value of typed string
	sdesc = "string"
	verDoTypeon(actor, io) = {}
	doTypeon(actor, io) = {
		// This should never get called.
		"\"Tap, tap, tap, tap...\"";
	}
	doSynonym('Typeon') = 'Enteron' 'Enterin' 'Enterwith'

	verDoSave(actor) = {}
	doSave(actor) = {
		if (save(self.value))
			"Save failed.";
		else {
			"Saved.";
			global.lastsave := global.turns;
		}
		abort;
	}
	verDoRestore(actor) = {}
	doRestore(actor) = {
		if (restore(self.value))
			"Restore failed.";
		else {
			"Restored.\b";
			score_statusline();
			actor.location.lookaround(actor, global.verbose);
		}
		abort;
	}
	verDoScript(actor) = {}
	doScript(actor) = {
		logging(self.value);
		"Writing script file.";
		abort;
	}
	verDoSay(actor) = {}
	doSay(actor) = {
		// If the actor has a method that tells us
		// what to do when he says something, call it;
		// otherwise, just say something cute.
		if (defined(actor, &speech_handler))
			actor.speech_handler(self.value);
		else
			"Okay, \"<<self.value>>\".";
	}
;
class Number: Thing
	value = 0	// parser magically sets this to value of typed number
	sdesc = "number"

	verDoPush(actor) = {}
	doPush(actor) = {
		"You need to specify what you want to type the
		number on.";
	}
	verDoTypeon(actor, io) = {}
	doTypeon(actor, io) = {
		// This should never get called.
		"\"Tap, tap, tap, tap...\"";
	}
	doSynonym('Typeon') = 'Enteron' 'Enterin' 'Enterwith'	
	verIoTurnto(actor) = {}
	ioTurnto(actor, dobj) = { dobj.doTurnto(actor, self); }
	verDoUndo(actor) = {}
	doUndo(actor) = { undoVerb.undocommands(actor, self.value); }
	verDoFootnote(actor) = {}
	doFootnote(actor) = {
		printnote(self.value);
	}
;
class Listobj: Thing
	value = []
	sdesc = "list of numbers"
	noun = 'intlist'
	isknownto(actor) = { return true; }

	verIoTurnto(actor) = {}
	ioTurnto(actor, dobj) = { dobj.doTurnto(actor, self); }
;
strObj: String;
numObj: Number;
listObj: Listobj;

//
// Decorations are just Things.
//
class Decoration: Thing
;
//
// Unimportants are Things that aren't important, but that can be
// referred to.
//
class Unimportant: Thing
	//
	// By default, don't let any verbs but 'inspect' give much
	// feedback.
	//
	dobjGen(a, v, i, p) = {
		if (v <> inspectVerb) {
			"\^<<self.subjthedesc>> <<self.isnt>> important.";
			 exit;
		}
	}
	iobjGen(a, v, i, p) = {
		if (v <> inspectVerb) {
			"\^<<self.subjthedesc>> <<self.isnt>> important.";
			 exit;
		}
	}
;
//
// A Distant is an item that is too far away to manipulate, but can be seen.
// The class uses dobjGen and iobjGen to prevent any verbs from being
// used on the object apart from inspectVerb; using any other verb results
// in the message "It's too far away."	Instances of this class should
// provide the normal item properties:	sdesc, ldesc, location,
// and vocabulary.
//
// Note that you can add other verbs to the list of allowed verbs; just
// redefine allowedverbs.
//
class Distant: Decoration
	allowedverbs = [inspectVerb]

	dobjGen(a, v, i, p) = {
		if (find(self.allowedverbs, v) = nil) {
			"\^ <<self.subjthedesc>> <<self.is>> too far away.";
			exit;
		}
	}
	iobjGen(a, v, d, p) = { self.dobjGen(a, v, d, p); }
;

//
// Parts are things that are parts of other things.  These mainly
// provide a way to have decorations that float around with another
// thing.  The partof method specifies what object the Part is
// connected to.
//
// If you change the parent, always use the setpartof method, or
// the parts list of the parent(s) won't get updated properly.
//
class Part: Floating
	partof = nil
	setpartof(p) = {
		if (self.partof <> nil)
			self.partof.parts -= self;
		
		if (p <> nil) {				
			self.partof := p;
			p.parts += self;
		}
	}
	
	// don't ever list this Thing in contents listings
	isnoticeable(actor) = { return nil; }
	
	location = {
		if (self.partof <> nil)
			return self.partof.location;
	}	
	locationtype = {
		if (self.partof <> nil)
			return self.partof.locationtype;
	}
	locationtypenum = {
		if (self.partof <> nil)
			return self.partof.locationtypenum;
	}
	isknownto(actor) = {
		if (self.partof = nil)
			return nil;
		else
			return self.partof.isknownto(actor);
	}
;
//
// The method islistable(actor) returns true if the object should
// be listed in room decriptions.
//
// The Listable class makes this method always return true.
//
class Listable: Thing
	islistable(actor) = { return true; }
;
//
// Listablesmells, Listedablesounds, and Listabletouch's get listed in
// the olfactory and audio contents listings (including room descriptions).
//
class Listablesmell: Thing
	islistablesmell(actor) = { return true; }
;
class Listablesound: Thing
	islistablesound(actor) = { return true; }
;
class Listabletouch: Thing
	islistabletouch(actor) = { return true; }
;
//
// Fixtures are things like furniture that get listed separately (i.e.,
// in a sentence of their own) in room descriptions.
//
// They mainly provide a way to have an object listed in a custom way.
// ("An enormous mahogany desk stands in the center of the room" vs.
// "There is an enormous mahogany desk here.")
//
class Fixture: Listable, Thing
	isfixture = true
	heredesc = {
		if (self.isdetermined)
			"\^<<self.subjsdesc>> <<self.is>> here.";
		else
			"There <<self.is>> <<self.subjadesc>> here.";
	}
;
//
// A Topic is something that an be "asked about" or "told about".
// By default, all Topics are known to all Actors.
//
class Topic: Thing
	istopic = true
;
class Knowntopic: Topic
	//
	// Making all topics known seems like it would be a good idea,
	// but is actually a terrible idea.  The problem with this is
	// that Items are also Topics, so they inherit this, which is
	// bad. 
	//
	// So we have a special class for Topics that are known from
	// the start.
	//
	isknownto(actor) = { return true; }
;

//
// An Item is something an actor can carry.
// By default it's a Topic.
//
class Item: Listable, Topic, Thing
	weight = 0
	bulk = 1

	// have to verify insertion here because verio methods
	// don't get dobj parameter.
	verDoPutX(actor, io, loctype) = {
		if (defined(io, &verIoPutX))
			io.verIoPutX(actor, self, loctype);
	}
	verDoPutin(actor, io) = { self.verDoPutX(actor, io, 'in'); }
	verDoPuton(actor, io) = { self.verDoPutX(actor, io, 'on'); }
	verDoPutunder(actor, io) = { self.verDoPutX(actor, io, 'under'); }
	verDoPutbehind(actor, io) = { self.verDoPutX(actor, io, 'behind'); }

	// "put through" is a bit different since "through" isn't a
	// location type.
	verDoPutthrough(actor, io) = {
		if (defined(io, &verIoPutthrough))
			io.verIoPutthrough(actor);
	}
	
	verDoTakeX(actor, obj, loctype) = {
		//
		// Floor objects (like Ground) are a special case --
		// things are considered to be on the ground if they're
		// in the containing room.
		//
		if (obj <> nil)
			if (isclass(obj, Floor)) {
				obj := actor.location;
				if (obj)
					if (isclass(obj, Floor))
						obj := actor.location.location;
				loctype := nil;
			}

		// Is this Thing contained in the object?
		if (obj <> nil)
		if (not self.iscontained(obj, loctype)) {
			if (obj.isactor)
				"\^<<obj.subjthedesc>>
				<<obj.doesnthave>>
				<<self.subjdesc>>";
			else if (loctype = nil)
				"\^<<self.subjthedesc>> <<self.isnt>>
				\ there";
			else
				"\^<<self.subjthedesc>> <<self.isnt>>
				\ <<loctype>> <<obj.objthedesc(actor)>>";

			if (self.isin(actor))
				"  -- %you% <<actor.has>>
				\ <<self.objprodesc(actor)>>.";
			else
				".";
		
			return;
		}

		// 
		// Clothing is a special case.	The player may say
		// "take off hat" or "remove hat".  We want to
		// map these to verDoUnwear.
		//
		if (self.isclothing and self.isin(actor) and self.isworn)
			self.verDoUnwear(actor);
	}
	verDoTake(actor) = { self.verDoTakeX(actor, nil, nil); }
	verDoTakefrom(actor, io) = { self.verDoTakeX(actor, io, nil); }
	verDoTakeoff(actor, io) = { self.verDoTakeX(actor, io, 'on'); }
	verDoTakeout(actor, io) = { self.verDoTakeX(actor, io, 'in'); }
	verDoTakeunder(actor, io) = { self.verDoTakeX(actor, io, 'under'); }
	verDoTakebehind(actor, io) = { self.verDoTakeX(actor, io, 'behind'); }
	doTake(actor) = {
		local	tot, m;

		// 
		// Clothing is a special case.	The player may say
		// "take off hat" or "remove hat".  We want to
		// map these to verDoUnwear.
		//
		// If the actor has the object, but the object is
		// not in the actor's "top level" possessions, 
		// we interpret "take X" as "move X to my top level".
		// Player's often use this syntax to take things out
		// of containers.
		//
		if (self.isin(actor)) {
			if (self.isclothing and self.isworn) {
				self.doUnwear(actor);
				return;
			}
			else if (self.location = actor) {
				"%You% already <<actor.has>>
				\ <<self.objthedesc(actor)>>.";

				return;
			}
		}

		actor.ioPutX(actor, self, 'in');
	}
	doTakefrom(actor, io) = { self.doTake(actor); }
	doTakeoff(actor, io) = { self.doTake(actor); }
	doTakeout(actor, io) = { self.doTake(actor); }
	doTakeunder(actor, io) = { self.doTake(actor); }
	doTakebehind(actor, io) = { self.doTake(actor); }

	verDoDrop(actor) = {
		// Does the actor have this Thing?
		if (not self.isin(actor))
			"%You% <<actor.doesnthave>> <<self.objthedesc(actor)>>.";
	}
	doDrop(actor) = {
		actor.location.roomdrop(actor, self);
	}

	verDoGiveto(actor, io) = {}
	verDoShowto(actor, io) = {}
	verDoThrowat(actor, io) = {}
	verDoThrowbehind(actor, io) = {}
	verDoThrowthrough(actor, io) = {}
	verDoThrowto(actor, io) = {}
	verDoThrowunder(actor, io) = {}
;
//
// An Edible can be eaten.  When the player eats an Edible, the
// time he can go before he must eat again is increased by the
// foodvalue of the item.  This value defaults to actor.mealtime --
// the number of turns the player can go without eating at the
// beginning of the game.
//
// To disable starvation, make the actor's starvationcheck method nil.
//
class Edible: Item
	foodvalue = { return global.lastactor.mealtime; }
	verDoEat(actor) = {}
	doEat(actor) =	{
		self.eatdesc(actor);
		self.addfoodvalue(actor);
		self.movein(nil);
	}
	addfoodvalue(actor) = { actor.turnsuntilstarvation += self.foodvalue; }
	eatdesc(actor) = "That was delicious!";
;
//
// Drinkables are just like Edibles, but they deal with dehydration.
//
// To disable dehydration, make the actor's dehydration method nil.
//
class Drinkable: Item
	drinkvalue = { return global.lastactor.drinktime; }
	verDoDrink(actor) = {}
	doDrink(actor) = {
		self.drinkdesc(actor);
		self.adddrinkvalue(actor);
		self.movein(nil);
	}
	drinkdesc(actor) = {
		"\^<<self.subjthedesc>> quenches
		<<actor.possessivedesc>> thirst.";
	}
	adddrinkvalue(actor) = { actor.turnsuntildehydration += self.drinkvalue; }
;
//
// Note that the locationtype for Clothing that is
// being worn is 'in'.	Preinit guarantees this.
//
class Clothing: Item
	isclothing = true
	isworn = nil
	wornprop = {
		if (self.isworn)
			"(being worn)";
	}
	
	moveinto(obj, loctype, lttm) = {
		if (self.isworn) {
			"(taking off <<self.objthedesc(nil)>> first)\n";
			Outhide(true);
			self.doUnwear(self.location);
			Outhide(nil);
		}

		return inherited.moveinto(obj, loctype, lttm);
	}

	verDoWear(actor) = {
		if (self.isworn and self.location = actor)
			"\^<<actor.youre>> already
			wearing <<self.objthedesc(actor)>>.";
	}
	doWear(actor) = {
		if (not self.isin(actor)) {
			"(taking <<self.objthedesc(actor)>> first)\n";
			if (not self.movein(actor))
				return;
		}
			
		self.wearmessage(actor);
		self.isworn := true;
		if (find(self.properties, &wornprop) = nil)
			self.properties += &wornprop;
	}
	verDoUnwear(actor) = {}
	doUnwear(actor) = {
		self.unwearmessage(actor);
		self.isworn := nil;
		self.properties -= &wornprop;
	}

	wearmessage(actor) = {
		"%You% <<actor.is>> now wearing <<self.objthedesc(actor)>>.";
	}
	unwearmessage(actor) = {
		"%You% <<unwearVerb.desc(actor)>> <<self.objthedesc(actor)>>.";
	}
;
class Lightsource: Item
	islightsource = true
	islit = true
	litprop = {	// add to properties by preinit
		if (self.islit)
			"(providing light)";
	}
;
class Readable: Thing
	readdesc = { "\^<<self.prodesc>> reads, \"...\""; }
	verDoRead(actor) = {}
	doRead(actor) = { self.readdesc; }
;
//
// Buttons -- can be pressed.  Put action code in doPush.
// Set touchpress = nil to disallow "touch button" = "press button"
//
class Button: Thing
//	noun = 'button'
//	plural = 'buttons'
	sdesc = "button"
	touchpress = true
	verDoPush(actor) = {}
	verDoTouch(actor) = {
		if (self.touchpress)
			self.verDoPush(actor);
		else
			inherited.verDoTouch(actor);
	}
	doTouch(actor) = {
		if (self.touchpress)
			self.doPush(actor);
		else
			inherited.doTouch(actor);
	}
;
//
// Dials -- set minsetting and maxsetting.  dial.setting is current
// setting.
//
class Dial: Thing
	sdesc = "dial"
	minsetting = 1
	maxsetting = 10 // it has settings from 1 to this number
	setting = 1	// the current setting
	ldesc = {
		"\^<<self.subjthedesc>> can be turned to settings 
		numbered from <<self.minsetting>> to 
		<<self.maxsetting>>."; P();

		I(); "It's currently set to <<self.setting>>.";
	}
	verDoTurn(actor) = {}
	doTurn(actor) = { askio(toPrep); }
	verDoTurnto(actor, io) = {}
	doTurnto(actor, io) = {
		if (io = numObj) {
			if (numObj.value < self.minsetting or
			    numObj.value > self.maxsetting) {

				    "There's no such setting.";
			    }
			 else if (numObj.value <> self.setting) {
				 self.setting := numObj.value;
				 "Okay, it's now turned to
				 <<self.setting>>.";
			 }
			 else {
				 "It's already set to <<self.setting>>.";
			 }
		}
		else {
			"%You% can't turn <<self.objthedesc(actor)>>
			\ to that.";
		}
	}
;

//
// Switches can be switched on or off.	The isactive method returns the
// current value.
//
// Set pullable to nil to disallow the syntax "pull switch".
// Set moveable to nil to disallow the syntax "move switch".
//
class Switch: Thing
	isactive = nil
	pullable = true		// is "pull switch" allowable syntax?
	moveable = true		// is "move switch" allowable syntax?
	sdesc = "switch"
	verDoSwitch(actor) = {}
	doSwitch(actor) = {
		self.isactive := not self.isactive;
		"Okay, <<self.subjthedesc>> is now switched ";
		if (self.isactive)
			"on";
		else
			"off";
		".";
	}
	verDoFlip(actor) = {}
	doFlip(actor) = { self.doSwitch(actor); }
	verDoPull(actor) = {
		if (not self.pullable)
			"\^<<actor.subjprodesc>> can't pull
			<<self.objthedesc(actor)>>.";
	}
	doPull(actor) = { self.doSwitch(actor); }
	verDoMove(actor) = {
		if (not self.moveable)
			"\^<<actor.subjprodesc>> can't move
			<<self.objthedesc(actor)>>.";
	}
	verDoTurnon(actor) = {
		if (self.isactive)
			"\^<<self.subjprodesc>> <<self.is>> already
			turned on.";
	}
	doTurnon(actor) = {
		self.isactive := true;
		"Okay, <<self.subjthedesc>> <<self.is>> now turned on.";
	}
	verDoTurnoff(actor) = {
		if (not self.isactive)
			"\^<<self.subjthedesc>> <<self.is>> already
			turned off.";
	}
	doTurnoff(actor) = {
		self.isactive := nil;
		"Okay, <<self.subjthedesc>> <<self.is>> now turned off.";
	}
;
//
// A Transparent is something you can see into and out of.
// Be sure to put this on the left of a multiple inheritance
// list since the pass methods may be defined by other classes
// in the list (like Openable).
//
class Transparent: Thing
	passcanseein(actor, obj, loctype) = { return true; }
	passcanseeout(actor, obj, loctype) = { return true; }
	passcanseeacross(actor, obj, loctype) = { return true; }
;
//
// A Holder has contents (things that are on, in, under, behind, ... it)
// Don't use Holders for game objects, though.	Inherit from
// Container, Surface, Over, or Front instead.
//
class Holder: Thing
	isholder = true
	iscontainer = nil
	issurface = nil
	isover = nil
	isfront = nil
	acceptsput(actor, loctype) = {
		switch (loctype) {
			case 'in':
				return self.iscontainer;
				break;
			case 'on':
				return self.issurface;
				break;
			case 'under':
				return self.isover;
				break;
			case 'behind':
				return self.isfront;
				break;
			default:
				return true;
				break;
		}
	}
	contents = []
	
	maxweight = -1		// can support an infinite amount of stuff
	maxbulk = -1		// can hold an infinite amount of stuff

	//
	// Sense passing.  See defaults in Thing for more info.
	//
	passcansee(actor, obj, loctype) = { return true; }
	passcantouch(actor, obj, loctype) = { return true; }
	passcantake(actor, obj, loctype) = { return true; }
	passcansmell(actor, obj, loctype) = { return true; }
	passcanhear(actor, obj, loctype) = { return true; }
	passcanspeakto(actor, obj, loctype) = { return true; }

	//
	// Contents can be removed
	//
	verIoTakefrom(actor) = {}
	ioTakefrom(actor, dobj) = { dobj.doTake(actor); }

	//
	// Look on, in, under, behind, etc.
	//
	doLookX(actor, loctype, emptyquiet) = {
		local	tot;

		//
		// See if the actor can see into the
		// container.  If not, the canX method
		// will explain why not.
		//
		if (not actor.canseecontents(self, nil, loctype))
			return;
				
		tot := listcontents(self, actor, 3, nil, nil, nil, loctype, true, true, nil, actor.location);
		if (tot = 0 and not emptyquiet)
			"There doesn't appear to be anything <<loctype>> <<self.objthedesc(nil)>>.";
	}

	//
	// The general put in/on/under/behind method and accompanying
	// verification method.	 The verify method is actually called
	// by verDoPutX.
	//
	verIoPutX(actor, dobj, loctype) = {
		// dobj = self?
		if (dobj = self) {
			"%You% can't put <<dobj.objthedesc(actor)>> <<loctype>>
			\ <<dobj.reflexivedesc>>!";

			return;
		}
		
		// Is the dobj already in this Holder at the top level?
		if (dobj.location = self and dobj.locationtype = loctype) {
			"\^<<dobj.subjthedesc>> <<dobj.is>> already
			<<loctype>> <<self.objthedesc(nil)>>.";

			return;
		}
	}

	//
	// Verify that the object or list can be inserted into
	// the container without exceeding the container's
	// weight and bulk limits.
	//
	verifyinsertion(actor, obj, loctype, loclist, valprop, check, msg) = {
		local	i;
		local	lt := find(global.loctypes, loctype);
		local	tot, m;
		local	islist;

		if (datatype(obj) = 7)
			islist := true;
		else
			islist := nil;

		m := self.(loclist[lt]);
		if (m <> -1) {
			// get weight of stuff in container
			tot := self.(check)(actor, [loctype]);

			// add weight of stuff to be put into container
			if (islist)
				for (i := 1; i <= length(obj); i++) {
					tot += obj[i].(valprop);
					tot += obj[i].(check)(actor, global.loctake);
				}
			else {
				tot += obj.(valprop);
				tot += obj.(check)(actor, global.loctake);
			}
				
			if (tot > m) {
				if (islist)
					self.(msg)(obj[1], loctype);
				else
					self.(msg)(obj, loctype);

				return nil;
			}
		}

		return true;
	}
	
	//
	// General put method.	Note that dobj can be a list, in
	// which case we want to know if *all* the objects in the
	// can be put in the container together. This is to handle
	// Attachables.
	//
	// If dobj is a single object and has a doPutX method,
	// we call it instead.	(This is so objects can override
	// the normal put behavior, not just the containers.)
	//
	ioPutX(actor, dobj, loctype) = {
		local	i, islist;

		if (datatype(dobj) = 7)
			islist := true;
		else
			islist := nil;

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

	//
	// Message methods for the user to customize as desired.
	//
	weightexceeded(dobj, loctype) = {
		"\^<<self.subjthedesc>> can't hold any more.";
	}
	bulkexceeded(dobj, loctype) = {
		"\^<<dobj.subjthedesc>> won't fit <<loctype>> 
		<<self.objthedesc(nil)>>.";
	}

	putmessage(dobj, loctype) = { "Done."; }
;
//
// A Container has things in it.
//
class Container: Holder
	iscontainer = true

	contdesc(actor) = { self.doLookin(actor); }

	verDoLookin(actor) = {}
	doLookin(actor) = { self.doLookX(actor, 'in', nil); }

	verIoPutin(actor) = {}
	ioPutin(actor, dobj) = { self.ioPutX(actor, dobj, 'in'); }
	verIoTakeout(actor) = {}
	ioTakeout(actor, dobj) = { dobj.doTake(actor); }
;
//
// A QContainer is just a container whose contents are not listed
// in a room description.
//
class Qcontainer: Container
	incontentslisted(obj) = { return nil; }
;
//
// A Surface has things on it.
//
class Surface: Holder
	issurface = true
	
	verDoLookon(actor) = {}
	doLookon(actor) = { self.doLookX(actor, 'on', nil); }

	verIoPuton(actor) = {}
	ioPuton(actor, dobj) = { self.ioPutX(actor, dobj, 'on'); }
	verIoTakeoff(actor) = {}
	ioTakeoff(actor, dobj) = { dobj.doTake(actor); }
;
//
// A Qsurface is just a surface whose contents are not listed
// in a room description.
class Qsurface: Surface
	oncontentslisted(obj) = { return nil; }
;
//
//
// An Over has things under it.
//
class Over: Holder
	isover = true
	
	verDoLookunder(actor) = {}
	doLookunder(actor) = { self.doLookX(actor, 'under', nil); }

	verIoPutunder(actor) = {}
	ioPutunder(actor, dobj) = { self.ioPutX(actor, dobj, 'under'); }
	verIoThrowunder(actor) = {}
	ioThrowunder(actor, dobj) = { self.ioPutunder(actor, dobj); }
	verIoTakeunder(actor) = {}
	ioTakeunder(actor, dobj) = { dobj.doTake(actor); }
;
//
// A Qover is just an Over whose contents are not listed in a room
// description.
class Qover: Over
	undercontentslisted(obj) = { return nil; }
;
//
// A Front has things behind it.
//
class Front: Holder
	isfront = true
	
	verDoLookbehind(actor) = {}
	doLookbehind(actor) = { self.doLookX(actor, 'behind', nil); }

	verIoPutbehind(actor) = {}
	ioPutbehind(actor, dobj) = { self.ioPutX(actor, dobj, 'behind'); }
	verIoThrowbehind(actor) = {}
	ioThrowbehind(actor, dobj) = { self.ioPutbehind(actor); }
	verIoTakebehind(actor) = {}
	ioTakebehind(actor, dobj) = { dobj.doTake(actor); }
;
//
// A Qfront is just a Front whose contents are not listed in a room
// description.
//
class Qfront: Front
	behindcontentslisted(obj) = { return nil; }
;
//
// An openable is a Container that can be either open or closed.
// When closed, it blocks senses.
//
class Openable: Container
	isopen = nil	// starts out closed by default

	ldesc = {
		"\^<<self.subjthedesc>> <<self.is>> currently ";
		if (self.isopen)
			"open.";
		else
			"closed.";
	}

	verDoOpen(actor) = {
		if (self.isopen)
			"\^<<self.subjthedesc>> <<self.is>> already open.";
	}
	doOpen(actor) = {
		self.isopen := true;
		self.openmessage(actor);
		
		// Make all contents known
		self.makecontentsknownto(actor);
	}
	verDoClose(actor) = {
		if (not self.isopen)
			"\^<<self.subjthedesc>> <<self.is>> already closed.";
	}
	doClose(actor) = {
		self.isopen := nil;
		self.closemessage(actor);
	}

	openmessage(actor) = {
		"Opened. ";
		self.doLookX(actor, 'in', nil);
	}
	closemessage(actor) = { "Closed."; }
	
	passgen(actor, obj, loctype, passmethod) = {
		// If not "in" containment or nil, call our parent's method.
		if (loctype <> nil and loctype <> 'in')
			return inherited.(passmethod)(actor, obj, loctype);

		if (self.isopen)
			return true;
		else {
			"\^<<actor.youll>> have to open
			<<self.objthedesc(nil)>> first.";
			return nil;
		}		
	}
	passcanseein(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcansee);
	}
	passcanseeout(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcansee);
	}
	passcantouchin(actor, obj, loctype) = { 
		return self.passgen(actor, obj, loctype, &passcantouch);
	}
	passcantouchout(actor, obj, loctype) = { 
		return self.passgen(actor, obj, loctype, &passcantouch);
	}
	passcantakein(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcantake);
	}
	passcantakeout(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcantake);
	}
	passcansmellin(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcansmell);
	}
	passcansmellout(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcansmell);
	}
	passcanhearin(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcanhear);
	}
	passcanhearout(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcanhear);
	}
	passcanspeaktoin(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcanspeakto);
	}
	passcanspeaktoout(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcanspeakto);
	}
;
//
// A lockable must be unlocked before it can be opened.
// If key is not nil, the object it returns is the key required to
// unlock the Thing.  If the key is nil, the Thing can be locked
// and unlocked without a key.  To make a something impossible to
// unlock (or lock), just set its key to an object the player
// can never get.
//
// This has to go to the left of Openable in a multiple inheritance list.
//
class Lockable: Thing
	islocked = true
	isopen = nil
	key = nil
	
	verDoOpen(actor) = {
		if (self.islocked)
			"\^<<actor.youll>> have to unlock
			<<self.objthedesc(actor)>> first.";
		else if (self.isopen)
			"\^<<self.subjthedesc>> <<self.is>> already open.";

		//
		// We'd like to say
		//
		//	inherited.verDoOpen(actor);
		//
		// here, but the multiple inheritance mechanism
		// causes this not to work.  (It ends up calling
		// Thing's verDoOpen.)
		//
	}
	verDoLock(actor) = {
		if (self.islocked)
			"\^<<self.subjthedesc>> <<self.is>> already locked.";
		else if (self.isopen)
			"\^<<actor.youll>> have to close
			<<self.objthedesc(actor)>> first.";
	}
	doLock(actor) = {
		if (self.key = nil)
			self.doLockwith(actor, nil);
		else
			"\^<<actor.subjprodesc>> need to specify what
			<<actor.objprodesc(nil)>> to lock <<self.objthedesc(actor)>> with.";
	}
	verDoLockwith(actor, io) = {
		if (self.islocked)
			"\^<<self.subjthedesc>> <<self.is>> already locked.";
		else if (self.isopen)
			"\^<<actor.youll>> have to close
			<<self.objthedesc(actor)>> first.";
		else if (self.key = nil)
			"\^<<actor.you>> <<actor.doesnt>> need anything
			to lock <<self.objthedesc(actor)>>.";
		else if (io <> self.key)
			"\^<<io.subjthedesc>> <<io.doesnt>> fit
			the lock.";
	}
	doLockwith(actor, io) = {
		self.islocked := true;
		self.lockmessage(actor);
	}
	verDoUnlock(actor) = {
		if (not self.islocked)
			"\^<<self.subjthedesc>> <<self.is>> already unlocked.";
	}
	doUnlock(actor) = {
		if (self.key = nil)
			self.doUnlockwith(actor, nil);
		else
			"\^<<actor.subjprodesc>> need to specify what
			<<actor.objprodesc(nil)>> to unlock <<self.objthedesc(actor)>> with.";
	}
	verDoUnlockwith(actor, io) = {
		if (not self.islocked)
			"\^<<self.subjthedesc>> <<self.is>> already unlocked.";
		else if (self.key = nil)
			"\^<<actor.you>> <<actor.doesnt>> need anything
			to lock <<self.objthedesc(actor)>>.";
		else if (io <> self.key)
			"\^<<io.subjthedesc>> <<io.doesnt>> fit the lock.";
	}
	doUnlockwith(actor, io) = {
		self.islocked := nil;
		self.unlockmessage(actor);
	}
	lockmessage(actor) = { "Locked."; }
	unlockmessage(actor) = { "Unlocked."; }
;
//
// A Key is something that can be used to lock and unlock things.
//
class Key: Thing
	sdesc = "key"
//	noun = 'key'
	verIoLockwith(actor) = {}
	verIoUnlockwith(actor) = {}
	ioLockwith(actor, dobj) = { dobj.doLockwith(actor, self); }
	ioUnlockwith(actor, dobj) = { dobj.doUnlockwith(actor, self); }
;
//
// An Attachable can be attached to other things.
//
// tieable determines whether "tie" can be used instead of "attach".
// plugable determines whether "plug...into" can be used instead of "attach".
//
// maxattachments specifies the maximum number of Attachpoints this
// thing can be attached to at once.
//
// attachesto lists the Attachpoints this thing can be attached to.
//
// attachedto lists the Attachpoints this thing is currently attached to.
//
// attachedtodesc prints a sentence of the form
//	"The <Thing> is attached to ..."
//
// NOTE: Attachables are Items.	 For Attachables that can't be taken,
// you don't need this class; just override the relevant methods
// in a Thing.
//
class Attachable: Item
	tieable = nil
	plugable = nil
	maxattachments = 1
	attachesto = []
	attachedto = []

	attachedprop = { "(<<self.listattachments>>)"; }
	
	ldesc = { self.attachedtodesc; }
	attachedtodesc = {			
		"\^<<self.subjthedesc>> <<self.is>> <<self.listattachments>>.";
	}
	listattachments = {
		local	i;
		local	len := length(self.attachedto);
		local	attached;
		
		if (self.tieable)
			attached := 'tied';
		else
			attached := 'attached';


		if (len = 0) {
			"not <<attached>> to anything";
			return;
		}
		
		"<<attached>> to ";
		for (i := 1; i <= len; i++) {
			self.attachedto[i].objthedesc(nil);
			if (i = len)
				break;
			else if (i = len - 1) {
				if (len > 2)
					", and ";
				else
					" and ";
			}
			else
				", ";
		}
	}
	verDoAttachto(actor, io) = {
		local	attach, detaching;

		if (self.tieable) {
			attach := 'tie to';
			detaching := 'untying';
		}
		else {
			attach := 'attach to';
			detaching := 'detaching';
		}

		if (find(self.attachesto, io) = nil)
			"%You% can't <<attach>>
			\ <<self.objthedesc(actor)>> to
			<<io.objthedesc(actor)>>.";
		else if (length(self.attachedto) >= self.maxattachments)
			"%You% can't <<attach>>
			\ <<self.objthedesc(actor)>> to
			<<io.objthedesc(actor)>> without
			<<detaching>> it from something else first.";
		else if (length(io.attachedto) >= io.maxattachments)
			"%You% can't <<attach>>
			\ <<io.objthedesc(actor)>> to
			<<self.objthedesc(actor)>> without
			<<detaching>> it from something else first.";
		else if (self.location <> io.location or self.locationtype <> io.locationtype) {
			//
			// If this thing has to be attached to something
			// in a different location, make sure we can
			// put the thing in the new location -- the location
			// where the attachment point is.
			//
			if (not actor.canputinto(io.location, io.locationtype, true))
				actor.canputinto(io.location, io.locationtype, nil);
		}
	}

	doAttachto(actor, io) = {
		//
		// By default, things that are attached must be in
		// the same location as their attachpoints.  Aside
		// from making general sense, this prevents an actor
		// from attaching something to a fixed object and
		// then walking off with the (still attached) item.
		//
		if (self.location <> io.location or self.locationtype <> io.locationtype)
			if (not self.moveto(io.location, io.locationtype))
				return;

		self.attachedto += io;
		if (length(self.attachedto) = 1)
			self.properties += &attachedprop;
		io.attachedto += self;
		if (length(io.attachedto) = 1)
			io.properties += &attachedprop;

		self.attachedmessage(actor, io);
	}
	attachedmessage(actor, obj) = { "Done."; }
	verDoTieto(actor, io) = {
		if (self.tieable or io.tieable)
			self.verDoAttachto(actor, io);
		else
			inherited.verDoTieto(actor, io);
	}
	doTieto(actor, io) = { self.doAttachto(actor, io); }
	verDoPlugin(actor, io) = {
		if (self.plugable or io.plugable)
			self.verDoAttachto(actor, io);
		else
			inherited.verDoPlugin(actor, io);
	}
	doPlugin(actor, io) = { self.doAttachto(actor, io); }

	verDoDetach(actor) = {
		if (length(self.attachedto) = 0)
			"\^<<self.subjthedesc>> <<self.is>> not
			attached to anything.";
		else if (length(self.attachedto) > 1)
			"You'll have to be more specific about what
			you want to detach <<self.objthedesc(actor)>>
			\ from.";
		else
			self.verDoDetachfrom(actor, self.attachedto[1]);
	}
	doDetach(actor) = { self.doDetachfrom(actor, self.attachedto[1]); }
	verDoDetachfrom(actor, io) = {
		if (find(self.attachedto, io) = nil)
			"\^<<self.subjthedesc>> <<self.is>> not attached
			to <<io.objthedesc(nil)>>.";
	}
	doDetachfrom(actor, io) = {
		self.attachedto -= io;
		if (length(self.attachedto) = 0)
			self.properties -= &attachedprop;
		io.attachedto -= self;
		if (length(io.attachedto) = 0)
			io.properties -= &attachedprop;
		self.detachedmessage(actor, io);
	}
	detachedmessage(actor, obj) = {	"Done."; }
	verDoUntiefrom(actor, io) = {
		if (self.tieable or io.tieable)
			self.verDoDetachfrom(actor, io);
		else
			inherited.verDoUntiefrom(actor, io);
	}
	doUntiefrom(actor, io) = { self.doDetachfrom(actor, io); }
	verDoUntie(actor) = { self.verDoDetach(actor); }
	doUntie(actor) = { self.doDetach(actor); }
	verDoUnplugfrom(actor, io) = {
		if (self.plugable or io.plugable)
			self.verDoDetachfrom(actor, io);
		else
			inherited.verDoUnplugfrom(actor, io);
	}
	doUnplugfrom(actor, io) = { self.doDetachfrom(actor, io); }
	verDoUnplug(actor) = { self.verDoDetach(actor); }
	doUnplug(actor) = { self.doDetach(actor); }


	//
	// Construct a list of all things this thing is
	// attached to, and all things the attached things
	// are attached to, etc. to get a list of all the
	// things this thing is connected to.
	//
	connectedto = {
		local	i, j, l;
		
		l := [] + self;
		for (i := 1; i <= length(l); i++) {
			if (length(l[i].attachedto) > 0) {
				for (j := 1; j <= length(l[i].attachedto); j++) {
					if (find(l, l[i].attachedto[j]) = nil)
						l += attachedto[j];
				}
			}				
		}

		return cdr(l);
	}
	
	//
	// When an Attachable is moved, it takes all its attachments
	// with it.
	//
	moveinto(obj, loctype, lttm) = {
		local	i, l;

		//
		// If we're already directly contained in the
		// destination object, do nothing.
		//
		if (self.location = obj and self.locationtype = loctype)
			return nil;

		l := self.connectedto;

		//
		// Move all the stuff.
		//
		inherited.moveinto(obj, loctype, lttm);
		for (i := 1; i <= length(l); i++)
			l[i].inheritedmoveinto(obj, loctype, lttm);

		return true;
	}
	inheritedmoveinto(obj, loctype, lttm) = { return inherited.moveinto(obj, loctype, lttm); }

	//
	// When the player tries to put this thing in a container,
	// we have to make sure that all its attachments will fit
	// as well.  To assure this, we put them in the container
	// in one big lump.
	//
	doPutX(actor, io, loctype) = {
		local	l;

		l := self.connectedto;
		l := ([] + self) + l;
		io.ioPutX(actor, l, loctype);
	}
	
	//
	// Only takeable if not attached to any untakeable things.
	//
	istakeable(actor) = {
		local	i, l;

		//
		// Construct a list of all things this thing is
		// attached to, and all things the attached things
		// are attached to, etc.
		//
		l := self.connectedto;

		//
		// Now verify that each thing in the list can
		// be taken.  We ignore Attachables because those
		// things are assumed to be takeable unless they're
		// attached to something that's not takeable.
		// (Also, if we don't we'll get infinite recursion.)
		//
		for (i := 1; i <= length(l); i++) {
			if (not isclass(l[i], Attachable)) {
				local	r;
				
				Outhide(true);
				r := l[i].istakeable(actor);
				Outhide(nil);
				if (not r) {
					"\^<<actor.youll>> have to
					detach <<self.objthedesc(actor)>>
					\ from <<l[i].objthedesc(actor)>>
					\ first.";

					return nil;
				}
			}
		}

		return true;
	}
;
//
// An Attachpoint can have things attached to it.
// Attachpoints can be Items or plain old (fixed) Things.
//
class Attachpoint: Thing
	maxattachments = 1
	attachedto = []

	//
	// We have the Attachable handle everything.  These
	// methods just pass control along to it.
	//
	verIoAttachto(actor) = {}
	ioAttachto(actor, dobj) = { dobj.doAttachto(actor, self); }
	verIoDetachfrom(actor) = {}
	ioDetachfrom(actor, dobj) = { dobj.doDetachfrom(actor, self); }

	verIoTieto(actor) = { }
	ioTieto(actor, dobj) = { dobj.doTieto(actor, self); }
	verIoUntiefrom(actor) = { }
	ioUntiefrom(actor, dobj) = { dobj.doUntiefrom(actor, self); }

	verIoPlugin(actor) = { }
	ioPlugin(actor, dobj) = { dobj.doPlugin(actor, self); }
	verIoUnplugfrom(actor) = { }
	ioUnplugfrom(actor, dobj) = { dobj.doUnplugfrom(actor, self); }
;
//
// A Connection holds rooms, and knows how to pass (or block)
// senses between them.
//
class Connection: Container
;
//
// A Room holds items and actors.
//
class Room: Container
	//
	// Rooms are generally in top
	// (We handle this in preinit now.)
	//
	//location = TOP

	//
	// Every room has walls, ground, and ceiling unless we say otherwise.
	// If these are set to true, we'll use the standard floating
	// decorations.	 Otherwise those decorations won't be reachable
	// from the room
	//
	walls = true
	ground = true
	ceiling = true

	statusLine = {
		local	stat, str;
		local	i, toprint;

		//
		// Start capturing output
		//
		stat := outcapture(true);
		
		//
		// Print the text for this location
		//
		self.banner;
		
		//
		// If there's extra statusline info to be
		// printed, print it.
		//
		if (proptype(global, &statusline) = 6)
			global.statusline;

		//
		// Stop capturing text; captured text is now in str.
		//
		str := outcapture(stat);

		//
		// If the status line does not exceed the maximum
		// allowable width, print it as usual.  Otherwise,
		// print as much as we can fit, followed by an
		// ellipsis.
		//
		if (length(str) <= global.statuslinewidth) {
			say(str);
		}
		else {
			toprint := substr(str, 1, global.statuslinewidth - 4);
			toprint += ' ...';
			say(toprint);
		}
	}
		
	banner = {
		local	actor := global.lastactor;
		
		self.tdesc; 
		if (actor and not isclass(self, Nestedroom)) {
			if (actor.location = self) {
				switch (actor.position) {
					case 'sitting':
						", sitting down";
						break;
					case 'lying':
						", lying down";
						break;
				}
			}
		}
	}
	describe(actor, verbose) = {
		local l, o, i, len, dark;

		dark := not actor.canseecontents(self, true, 'in');
		
		if (dark) {
			P(); I(); "It's too dark to see.\n";
		}

		// print room description if we're being verbose
		if (verbose and not dark) {
			P();
			self.ldesc; "\n";
		}

		listcontents(self, actor, 2, nil, true, true, nil, true, true, nil, self);
	}
	lookaround(actor, verbose) = {
		self.banner;
		self.describe(actor, verbose);
	}

	//
	// The following three functions are called by
	// smellVerb, listentoVerb, and touchVerb.
	// They're analagous lookaround above (hence the names), and
	// like describe (which lookaround calls) are overridden in
	// Nestedroom.
	//
	// Note that lookaround lists for ll senses.  These three
	// only list for their particular senses.
	//
	smellaround(actor, verbose) = {
		local	tot;

		tot := listcontents(self, actor, 5, nil, nil,
		nil, nil, nil, nil, &cansmell, self);

		if (tot = 0)
			"%You% <<actor.doesnt>> smell anything unusual.";
	}
	listenaround(actor, verbose) = {
		local	tot;

		tot := listcontents(self, actor, 5, nil, nil,
		nil, nil, nil, nil, &canhear, self);

		if (tot = 0)
			"%You% <<actor.doesnt>> hear anything unusual.";
	}
	feelaround(actor, verbose) = {
		local	tot;

		tot := listcontents(self, actor, 5, nil, nil,
		nil, nil, nil, nil, &cantouch, self);

		if (tot = 0)
			"%You% <<actor.doesnt>> feel anything unusual.";
	}

	isseen = nil
	enter(actor) = {
		local	alreadyknown := self.isknownto(actor);

		self.makecontentsknownto(actor);
		self.makeknownto(actor);
		self.lookaround(actor, not alreadyknown	or global.verbose);
		self.isseen := true;
	}
	leave(actor) = {
	}

	//
	// This gets called when an actor drops something in the room.
	//
	roomdrop(actor, obj) = {
		self.ioPutX(actor, obj, 'in');
	}
	
	// Rooms should generally pass all senses across so that 
	// things in the same room can interact with each other.
	//
	// Don't set islit directly -- it's a method that checks
	// to see if any light sources are in the room.	 Instead,
	// call the darken and lighten methods.
	//
	ambientlight = true
	islit = {
		local	i, l;

		if (self.ambientlight)
			return true;

		//
		// If any of the lightsources can "see" the room,
		// the room is lit.
		//
		l := global.lightsources;
		for (i := length(l); i > 0; i--) {
			if (l[i].seepath(self, nil, true))
				return true;
		}
				
		return nil;
	}
	darken = { self.ambientlight := nil; }
	lighten = { self.ambientlight := true; }
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
//		if (obj = self)
//			return true;

		if (selfloctype <> objloctype)
			return nil;
			
		//
		// Things that are themselves lit can see
		// across the room.  This is mainly to
		// prevent infinite recursion in islit.
		//
		if (obj <> nil)
			if (obj.islit)
				return true;
					
		if (self.islit)
			return true;
		else {
			"\^<<actor.subjthedesc>> can't see anything
			-- it's too dark.";
			return nil;
		}
	}

	verDoStand(actor) = {}
	doStand(actor) = {
		actor.position := 'standing';
		"%You% <<actor.is>> now standing.";
	}
	
	// For connections between rooms that senses can pass through,
	// use Connection or define smart sense passing methods in TOP.
;
class Darkroom: Room
	ambientlight = nil
;
class Outside: Room
	walls = nil
	ground = true	// still allows "floor" but who cares...
	ceiling = nil
;
//
// Nestedrooms are things an actor can be in, on, under, or behind.
// The actor is still in the main room, however, and if he looks
// around he'll see the containing room.  Likewise, if he drops things,
// they'll wind up in the containing room, not in the nested room.
//
// This is useful for things like chairs that restrict the player's
// actions, but aren't really separate locations in their own right.
// For totally separate (but contained) locations, just put a room
// inside another room.
//
// We impose the restriction that actors can't touch or take anything
// in the containing room without getting up first.  (This is right
// more often than not.)  You can turn this off by setting
// reachsurroundings to true.  Alternatively, you can make specific
// objects reachable by putting them in the reachable list.  (Things
// in the reachable list can be containers too, in which case all
// the contained items are reachable as well, subject to the container's
// whims.)
//
// NOTE: Making a new Nestedroom class should only be attempted by
// a WorldClass expert!	 There are (unfortunately) many places in
// WorldClass where the class "Nestedroom" is hard-coded.  You'll
// have to be sure to fix all these if you make your own Nestedroom
// substitute.	Nestedroom bugs are very subtle and take a long time
// to find, so proceed with extreme caution!
//
class Nestedroom: Room
	tdesc = {
		if (self.location <> nil)
			"<<self.location.tdesc>>, ";
		else
			caps();

		"<<global.lastactor.locationtype>> <<self.objsdesc(nil)>>";
	}
	describe(actor, verbose) = {
		self.location.describe(actor, verbose);
	}
	smellaround(actor, verbose) = {
		self.location.smellaround(actor, verbose);
	}
	listenaround(actor, verbose) = {
		self.location.listenaround(actor, verbose);
	}
	feelaround(actor, verbose) = {
		self.location.feelaround(actor, verbose);
	}

	reachsurroundings = nil
	reachable = []		// only used if reachsurroundings = nil

	noexit = {
		local actor := global.lastactor;
		
		"\^<<actor.youll>> have to get
		<<global.locopposites[actor.locationtypenum]>>
		\ <<self.objthedesc(actor)>> first.";

		return nil;
	}
	
	//
	// Rooms are Containers.  Nestedrooms may not actually be
	// able to have thing in them, so we disable these
	// methods we've inherited from Container.
	//
	verIoPutin(actor) = {
		"%You% can't put anything in <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% can't take anything out of <<self.objthedesc(actor)>>.";
	}

	//
	// Sense passing
	//	
	passmsg(actor, obj) = {
		"\^<<actor.youll>> have to get
		<<global.locopposites[actor.locationtypenum]>>
		\ <<self.objthedesc(actor)>> to reach
		<<obj.objthedesc(actor)>>.";
	}	
	passreachable(actor, obj, loctype) = {
		local	i;

		if (self.reachsurroundings)
			return true;

		//
		// If the object the actor is trying to reach
		// is self, is in the reachable list, or is contained
		// in an item in the reachable list, allow the
		// sense to pass through.
		//
		if (obj = self)
			return true;
		else for (i := length(self.reachable); i > 0; i--) {
			if (obj = self.reachable[i])
				return true;
			if (obj.iscontained(self.reachable[i], nil))
				return true;
		}
			
		self.passmsg(actor, obj);
		return nil;		
	}
	
	passcantouchout(actor, obj, loctype) = {
		return self.passreachable(actor, obj, loctype);
	}
	passcantakeout(actor, obj, loctype) = {
		return self.passreachable(actor, obj, loctype);
	}

	roomdrop(actor, obj) = { self.location.roomdrop(actor, obj); }
	
	islit = { return self.location.islit; }	
	darken = { self.location.darken; }
	lighten = { self.location.lighten; }

	enter(actor) = { 
		if (self.location <> nil)
			self.location.enter(actor);
	}
	leave(actor) = {
		if (self.location <> nil)
			self.location.leave(actor);
	}

	ground = { return self.location.ground; }
	grounddesc = { return self.location.grounddesc; }

	ceiling = { return self.location.ceiling; }
	ceilingdesc = { return self.location.ceilingdesc; }

	walls = { return self.location.walls; }
	wallsdesc = { return self.location.wallsdesc; }
	
	//
	// Subtle case: If an Actor is in the Nestedroom when
	// the Nestedroom is moved into a new location, the contents
	// of the location must be made known to the actor.
	//
	moveinto(obj, loctype, lttm) = {
		local	o, i, a;

		//
		// Move the Nestedroom.	 (We have to do this
		// first so that the sense reach code will
		// succeed for the Actor.)
		//
		if (inherited.moveinto(obj, loctype, lttm) = nil)
			return nil;

		//
		// Find containing Room
		//
		o := obj;
		while (o <> nil and not isclass(o, Room))
			o := o.location;

		//
		// If the destination is a Room, or is contained
		// in a Room, make that Room's contents known to
		// every actor in this Nestedroom.
		//
		if (o <> nil) {
			if (isclass(o, Room)) {
				for (i := 1; i <= length(self.contents); i++) {
					a := self.contents[i];
					if (isclass(a, Actor)) {
						o.makecontentsknownto(a);
						o.makeknownto(a);
					}
				}
			}
		}
	}
;

//
// A Table is a table.	It can have things on it and under it.
// The contdesc lists the contents.  By default the ldesc just
// lists the contents.	Since we don't generally expect things
// to be under tables, the contdesc doesn't say "there's nothing
// under the table" when that is the case.
//
// If you want actors to be able to sit on the table, inherit
// from Chair as well.
//
class Table: Surface, Over
	sdesc = "table"
	ldesc = { self.contdesc(global.lastactor); }
	contdesc(actor) = {
		// list things on table
		// if nothing, say so
		self.doLookX(actor, 'on', nil);

		" ";
		
		// list things under table
		// if nothing, don't say anything
		self.doLookX(actor, 'under', true);
	}
;
//
// Chairs can be sat in or on and stood on.
// By default you have to get out/off of the chair to reach anything
// in the containing room.  You can turn this off by setting reachsurroundings
// to true, or by putting specific objects in the reachable list.
//
// Disable standing by setting standable = nil.
//
// NOTE: Might want to make an "enterable" class for Nestedrooms that
// can be entered and exited.  This class would map "enter ___", 
/// "get in ___", "get on ___", etc. to a single method, which subclasses
// could deal with simply.
//
// NOTE: We map all the "enter" verbs to "enter ___" so that users only have
// to override verDoEnter and and doEnter not have to worry about the myriad
// other methods.  Ditto for doExit and verDoExit.
//
// Note that if this Chair is standable, (ver)doGeton will be different from
// (ver)doEnter.
//
class Chair: Nestedroom
	standable = nil

	sdesc = "chair"
//	noun = 'chair'
	tdesc = {
		if (self.location)
			self.location.tdesc;
		else
			caps();

		", <<global.lastactor.position>>
		\ <<global.lastactor.locationtype>>
		\ <<self.objthedesc(nil)>>";
	}

	verGoOut(actor) = { self.verGoUp(actor); }
	goOut(actor) = { return self.goUp(actor); }
	verGoUp(actor) = {}
	goUp(actor) = {
		// check for old-style "up" method
		if (defined(self, &up))
			self.up;
		else
			self.doGetoff(actor);

		return nil;
	}
		
	verDoEnter(actor) = {}
	verDoSiton(actor) = { self.verDoEnter(actor); }
	verDoSitin(actor) = { self.verDoEnter(actor); }
	verDoLieon(actor) = { self.verDoEnter(actor); }
	verDoLiein(actor) = { self.verDoEnter(actor); }
	verDoGetin(actor) = { self.verDoEnter(actor); }
	verDoGeton(actor) = { self.verDoEnter(actor); }

	verDoExit(actor) = {
		if (not actor.iscontained(self, 'in'))
			"\^<<actor.youre>> not in <<self.objthedesc(actor)>>.";
	}
	verDoGetoff(actor) = { self.verDoExit(actor); }
	verDoGetout(actor) = { self.verDoExit(actor); }
	verDoStand(actor) = {}

	doEnter(actor) = {
		if (actor.movein(self)) {
			actor.position := 'sitting';
			"\^<<actor.youre>> now sitting in <<self.objthedesc(actor)>>.";
		}
	}
	doSiton(actor) = { self.doEnter(actor); }
	doSitin(actor) = { self.doEnter(actor); }
	doLiein(actor) = { self.doEnter(actor); }
	doLieon(actor) = { self.doEnter(actor); }
	doGetin(actor) = { self.doEnter(actor); }
	doGeton(actor) = {
		if (not self.standable) {
			self.doEnter(actor);
			return;
		}

		if (actor.moveon(self)) {
			actor.position := 'standing';
			"\^<<actor.youre>> now standing on
			<<self.objthedesc(actor)>>.";
		}
	}
	doExit(actor) = {
		if (actor.moveto(self.location, self.locationtype)) {
			actor.position := 'standing';
			"%You% <<actor.is>> now standing.";
		}	
	}
	doGetout(actor) = { self.doExit(actor); }
	doStand(actor) = { self.doExit(actor); }
	doGetoff(actor) = { self.doExit(actor); }
;
//
// Stools can be sat on and stood on.
// By default you have to get off of the stool to reach anything
// in the containing room.  You can turn this off by setting reachsurroundings
// to true, or by putting specific objects in the reachable list.
//
// Disable standing by setting standable = nil.
//
// NOTE: We map all the "enter" verbs to "enter ___" so that users only have
// to override verDoEnter and and doEnter not have to worry about the myriad
// other methods.  Ditto for doExit and verDoExit.
//
// Note that if this Stool is standable, (ver)doGeton will be different from
// (ver)doEnter.
//
class Stool: Nestedroom
	standable = true

	sdesc = "stool"
//	noun = 'stool'
	tdesc = {
		if (self.location)
			self.location.tdesc;
		else
			caps();

		", <<global.lastactor.position>>
		\ <<global.lastactor.locationtype>>
		\ <<self.objthedesc(nil)>>";
	}

	verGoUp(actor) = {}
	goUp(actor) = {
		// check for old-style "up" method
		if (defined(self, &up))
			self.up;
		else
			self.doGetoff(actor);

		return nil;
	}

	verDoEnter(actor) = {}
	verDoSiton(actor) = { self.verDoEnter(actor); }
	verDoSitin(actor) = { self.verDoEnter(actor); }
	verDoGetin(actor) = { self.verDoEnter(actor); }
	verDoGeton(actor) = { self.verDoEnter(actor); }

	verDoExit(actor) = {
		if (not actor.iscontained(self, 'on'))
			"\^<<actor.youre>> not on <<self.objthedesc(actor)>>.";
	}
	verDoGetoff(actor) = { self.verDoExit(actor); }
	verDoGetout(actor) = { self.verDoExit(actor); }

	verDoStand(actor) = {}
	doEnter(actor) = {
		if (actor.moveon(self)) {
			actor.position := 'sitting';
			"\^<<actor.youre>> now sitting on <<self.objthedesc(actor)>>.";
		}
	}
	doSitin(actor) = { self.doEnter(actor); }
	doGetin(actor) = { self.doEnter(actor); }
	doSiton(actor) = { self.doEnter(actor); }
	doGeton(actor) = {
		if (not self.standable) {
			self.doEnter(actor);
			return;
		}		
		
		if (actor.moveon(self)) {
			actor.position := 'standing';
			"\^<<actor.youre>> now standing on
			<<self.objthedesc(actor)>>.";
		}
	}
	doExit(actor) = {
		if (actor.moveto(self.location, self.locationtype)) {
			actor.position := 'standing';
			"%You% <<actor.is>> now standing.";
		}
	}
	doGetout(actor) = { self.doExit(actor); }
	doStand(actor) = { self.doExit(actor); }
	doGetoff(actor) = { self.doExit(actor); }
;
//
// A Ledge is any flat surface you can sit, stand, or lie on.
// A ledge can also hold things.
//
// As in Chair and Stool, we map many ver methods to verDoEnter,
// verDoExit, and doExit so only these two need to be overridden.
// However, since there are many ways to "enter" a ledge, you'll
// have to handle each of these methods separately.
//
class Ledge: Surface, Nestedroom
	sdesc = "ledge"
//	noun = 'ledge'
	tdesc = {
		if (self.location)
			self.location.tdesc;
		else
			caps();

		", <<global.lastactor.position>>
		\ <<global.lastactor.locationtype>>
		\ <<self.objthedesc(nil)>>";
	}

	verGoUp(actor) = {}
	goUp(actor) = {
		// check for old-style "up" method
		if (defined(self, &up))
			self.up;
		else
			self.doGetoff(actor);

		return nil;
	}

	//
	// Map all the "enter" verbs to "enter ___"
	// so that users only have to override 
	// verDoEnter and not have to worry about
	// the myriad other methods.
	//
	verDoEnter(actor) = {}
	verDoSiton(actor) = { self.verDoEnter(actor); }
	verDoSitin(actor) = { self.verDoEnter(actor); }
	verDoLieon(actor) = { self.verDoEnter(actor); }
	verDoLiein(actor) = { self.verDoEnter(actor); }
	verDoGetin(actor) = { self.verDoEnter(actor); }
	verDoGeton(actor) = { self.verDoEnter(actor); }

	verDoExit(actor) = {
		if (not actor.iscontained(self, 'on'))
			"\^<<actor.youre>> not on <<self.objthedesc(actor)>>.";
	}
	verDoGetoff(actor) = { self.verDoExit(actor); }
	verDoGetout(actor) = { self.verDoExit(actor); }

	verDoStand(actor) = {}
	doSiton(actor) = {
		if (actor.moveon(self)) {
			actor.position := 'sitting';
			"\^<<actor.youre>> now sitting on
			<<self.objthedesc(actor)>>.";
		}
	}
	doSitin(actor) = { self.doSiton(actor); }
	doGetin(actor) = { self.doSiton(actor); }
	doLieon(actor) = {
		if (actor.moveon(self)) {
			actor.position := 'lying';
			"\^<<actor.youre>> now lying on
			<<self.objthedesc(actor)>>.";
		}
	}
	doLiein(actor) = { self.doLieon(actor); }
	doGeton(actor) = {
		if (actor.moveon(self)) {
			actor.position := 'standing';
			"\^<<actor.youre>> now standing on
			<<self.objthedesc(actor)>>.";
		}
	}

	//
	// Disallow "enter ledge" -- ask the player what he
	// really means.
	//
	doEnter(actor) = {
		"Please be more specific.  \^<<actor.subjthedesc>> can
		sit, stand or lie on <<self.objthedesc(actor)>>.";
	}

	doExit(actor) = {
		if (actor.moveto(self.location, self.locationtype)) {
			actor.position := 'standing';
			"%You% <<actor.is>> now standing.";
		}
	}
	doGetout(actor) = { self.doExit(actor); }
	doStand(actor) = { self.doExit(actor); }
	doGetoff(actor) = { self.doExit(actor); }
;
//
// A Bed is a bed.  You can sit, lie, or stand on it.
// It can also have things under it.
//
class Bed: Ledge, Qover
	sdesc = "bed"
	tdesc = {
		if (self.location)
			self.location.tdesc;
		else
			caps();

		", <<global.lastactor.position>>
		\ <<global.lastactor.locationtype>>
		\ <<self.objthedesc(nil)>>";
	}
//	noun = 'bed'
;
//
// A desk can have things on it or in it.
//
// Note that Openable and Qcontainer work as expected with Desks.
// E.g.,
//
// 	mydesk: Openable, Qcontainer, Desk ;
//
// Defines a desk that does not list its "in" contents in room
// descriptions, and which must be open for its "in" contents
// to be visible.
//
class Desk: Surface, Container
	sdesc = "desk"
	ldesc = { self.contdesc(global.lastactor); }
	contdesc(actor) = {
		// list things on desk
		// if nothing, say so
		self.doLookX(actor, 'on', nil);
	}
	
	//
	// Pretend we care about open/closed status
	//
	verDoOpen(actor) = {}
	doOpen(actor) = { "Open."; }
	verDoClose(actor) = {}
	doClose(actor) = { "Closed."; }
;
//
// A Shelf can have things on it.
//
class Shelf: Surface
	sdesc = "shelf"
	ldesc = { self.contdesc(global.lastactor); }
	contdesc(actor) = {
		// list things on shelves
		// if nothing, say so
		self.doLookX(actor, 'on', nil);
	}	
;

//
// Obstacle and Door are old stuff from adv.t, updated slightly
// but largely unchanged.
//
class Obstacle: Thing
	isobstacle = true
;

//
// A Door is an obstacle that impedes progress when it is closed.
// When the door is open (isopen is true), the user ends up in
// the room specified in the destination property upon going through
// the door.  Since a Door is an obstacle, use the door object for
// a direction property of the room containing the door.  (The
// travelto Actor method handles this.)
// 
// If noautoopen is not set to true, the door will automatically
// be opened when the player tries to walk through the door, unless the
// door is locked (islocked = true).  If the door is locked,
// it can be unlocked simply by typing "unlock door", unless the
// mykey property is set, in which case the object specified in
// mykey must be used to unlock the door.  Note that the door can
// only be relocked by the player under the circumstances that allow
// unlocking, plus the property islockable must be set true.
// By default, the door is closed; set isopen to true if the door
// is to start out open (and be sure to open the other side as well).
// 
// otherside specifies the corresponding Door object in the
// destination room (doordest), if any.	 If otherside is
// specified, its isopen and islocked properties will be
// kept in sync automatically.
//
Door: Obstacle
	isdoor = true
	ldesc = { self.opendesc; }
	opendesc = {
		"\^<<self.subjprodesc>> <<self.is>> ";
		
		if (self.isopen)
			"open";
		else {
			"closed";
			
			if (self.islocked)
				" and locked";
		}

		".";
	}
	
	destination(actor) = {
		if (self.isopen)
			return self.doordest;
		else if (not self.islocked and not self.noautoopen) {
			self.isopen := true;
			if (self.otherside)
				self.otherside.isopen := true;
			"(Opening <<self.objthedesc(nil)>>)\n";
			return self.doordest;
		}
		else {
			"\^<<actor.youll>> have to open
			<<self.objthedesc(actor)>> first.";
			
			setit(self);
			return nil;
		}
	}
	verDoOpen(actor) = {
		if (self.isopen)
			"\^<<self.subjprodesc>> <<self.is>> already open.";
		else if (self.islocked)
			"\^<<self.subjprodesc>> <<self.is>> locked.";
	}
	doOpen(actor) = {
		"Opened. ";
		self.isopen := true;
		if (self.otherside)
			self.otherside.isopen := true;
	}
	verDoClose(actor) = {
		if (not self.isopen)
			"\^<<self.subjprodesc>> <<self.is>> already closed.";
	}
	doClose(actor) = {
		"Closed. ";
		self.isopen := nil;
		if (self.otherside)
			self.otherside.isopen := nil;
	}
	verDoLock(actor) = {
		if (self.islocked)
			"\^<<self.subjprodesc>> <<self.is>> already locked.";
		else if (not self.islockable)
			"\^<<self.subjprodesc>> can't be locked.";
		else if (self.isopen)
			"\^<<actor.youll>> have to close
			<<self.objprodesc>> first.";
	}
	doLock(actor) = {
		if (self.mykey = nil) {
			"Locked.";
			self.islocked := true;
			if (self.otherside)
				self.otherside.islocked := true;
		}
		else
			askio(withPrep);
	}
	verDoUnlock(actor) = {
		if (not self.islocked)
			"\^<<self.subjprodesc>> <<self.is>> not locked.";
	}
	doUnlock(actor) = {
		if (self.mykey = nil) {
			"Unlocked. ";
			self.islocked := nil;
			if (self.otherside)
				self.otherside.islocked := nil;
		}
		else
			askio(withPrep);
	}
	verDoLockwith(actor, io) = {
		if (self.islocked)
			"\^<<self.subjthedesc>> <<self.is>> already locked.";
		else if (not self.islockable)
			"\^<<self.subjprodesc>> can't be locked.";
		else if (self.mykey = nil)
			"\^<<actor.subjthedesc>> <<actor.doesnt>> need
			anything to lock <<self.objprodesc(actor)>>.";
		else if (self.isopen)
			"\^<<actor.youll>> have to close
			<<self.objprodesc(actor)>> first.";
	}
	doLockwith(actor, io) = {
		if (io = self.mykey) {
			"Locked.";
			self.islocked := true;
			if (self.otherside)
				self.otherside.islocked := true;
		}
		else
			"\^<<io.subjprodesc>> <<io.doesnt>> fit the lock.";
	}
	verDoUnlockwith(actor, io) = {
		if (not self.islocked)
			"\^<<self.subjprodesc>> <<self.is>> not locked.";
		else if (self.mykey = nil)
			"\^<<actor.subjprodesc>> <<actor.doesnt>> need
			anything to unlock it. ";
	}
	doUnlockwith(actor, io) = {
		if (io = self.mykey) {
			"Unlocked. ";
			self.islocked := nil;
			if (self.otherside)
				self.otherside.islocked := nil;
		}
		else
			"\^<<io.subjprodesc>> <<io.doesnt>> fit the lock.";
	}
;

//
// A Floor is the floor or ground in a location.  It handles 
// things like "put ___ on floor" nicely.
//
// The ground is a special case of Floor.  You only need to 
// used Floor if you want to do something unusual with the ground,
// like making it a Listabletouch, for example, for an area where
// the floor is trembling or vibrating.
//
// NOTE: If you make your own special ground in a room using
// Floor, don't forget to set the room's ground property to the
// special ground object.  If you don't do this, some normal
// ground funtions (like "lie on ground") won't work for your
// customized ground.
//
// The ground is in every room that does not have ground = nil.
// Putting stuff on the ground is equivalent to dropping it in
// the room.  Getting on the ground is equivalent to standing
// up in the room.  (This only makes sense if the player is
// currently in a Nestedroom.)
//
// The ground does not allow actors to sit, lie, or stand on it.
// Instead, it leaves the actor where he is and sets his position
// to 'sitting', 'lying', or 'standing'.
//
// You can customize the ldesc by defining grounddesc in the Room.
// If this method exists, Ground will print it instead of the
// standard ldesc.  (Everywhere provides this functionality generally.)
//
class Floor: Everywhere, Ledge
	verDoLookon(actor) = {}
	doLookon(actor) = { actor.location.lookaround(actor, true); }

	verIoPuton(actor) = {}
	ioPuton(actor, dobj) = { dobj.doDrop(actor); }
	verIoTakeoff(actor) = { actor.location.verIoTakefrom(actor); }
	ioTakeoff(actor, dobj) = { actor.location.ioTakefrom(actor, dobj); }

	roomdrop(actor, obj) = { self.location.roomdrop(actor, obj); }

	verDoSiton(actor) = {}
	verDoLieon(actor) = {}
	doSiton(actor) = {
		actor.position := 'sitting';
		"\^<<actor.subjthedesc>> <<actor.is>> now sitting down.";
	}
	doLieon(actor) = {
		actor.position := 'lying';
		"\^<<actor.subjthedesc>> <<actor.is>> now lying down.";
	}

	//
	// ...Geton will be called when the player says "get on ground"
	// or "stand on ground".  This usually means he wants to just
	// be standing in the room -- i.e., that he wants to get
	// out of whatever nested room he's in.
	//
	verDoGeton(actor) = { actor.location.verDoGetoff(actor); }
	doGeton(actor) = { actor.location.doGetoff(actor); }
;
Ground: Floor
	reachsurroundings = true

	sdesc = "ground"
	noun = 'ground' 'floor'
	roomprop = &ground
	roomdescprop = &grounddesc
;

//
// The walls are purely decorative.
// They're in every room which doesn't have walls = nil.
//
Walls: Everywhere
	sdesc = "walls"
	noun = 'walls' 'wall'
	roomprop = &walls
	roomdescprop = &wallsdesc
;
//
// The ceiling is purely decorative.
// It's in every room which doesn't have ceiling = nil.
//
Ceiling: Everywhere
	sdesc = "ceiling"
	noun = 'ceiling'
	roomprop = &ceiling
	roomdescprop = &ceilingdesc
;
//
// A Sensor is a Thing that can sense other objects.
// Actors are the most common types of Sensors.
//
class Sensor: Thing	
	// Can this thing see the object?
	cansee(obj, loctype, silent) = {
		local	i;

		// Is there a clear line of sight to the object?
		if (not self.seepath(obj, loctype, silent))
			return nil;

		// Is the object visible?
		Outhide(true);
		i := obj.isvisible(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.isvisible(self);
				else
					"<<self.subjprodesc>> can't see
					<<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;			
	}

	// Can this thing touch the object?
	cantouch(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.touchpath(obj, loctype, silent))
			return nil;
		
		// Is the object touchable?
		Outhide(true);
		i := obj.istouchable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.istouchable(self);
				else
					"<<self.subjprodesc>> can't touch
					<<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}
	
	// Can this thing take the object?
	cantake(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.takepath(obj, loctype, silent))
			return nil;
		
		// Is the object takeable?
		Outhide(true);
		i := obj.istakeable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.istakeable(self);
				else
					"<<self.subjprodesc>> can't take
					<<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing smell the object?
	cansmell(obj, loctype, silent) = {
		local	i;

		// Is there a clear line of sight to the object?
		if (not self.smellpath(obj, loctype, silent))
			return nil;
		
		// Is the object smellable?
		Outhide(true);
		i := obj.issmellable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.issmellable(self);
				else
					"<<self.subjprodesc>> can't smell
					<<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}
	
	// Can this thing hear the object?
	canhear(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.hearpath(obj, loctype, silent))
			return nil;
		
		// Is the object audible?
		Outhide(true);
		i := obj.isaudible(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.isaudible(self);
				else
					"<<self.subjprodesc>> can't hear
					<<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing speak to the object?
	canspeakto(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.speaktopath(obj, loctype, silent))
			return nil;
		
		// Can the object hear anything?
		Outhide(true);
		i := obj.islistener(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.islistener(self);
				else
					"<<obj.subjprodesc>> can't hear
					<<self.objthedesc(obj)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing put something into the object?
	canputinto(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.putintopath(obj, loctype, silent))
			return nil;
		
		// Can the object accept things?
		Outhide(true);
		i := obj.acceptsput(self, loctype);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.acceptsput(self, loctype);
				else
					"<<self.subjprodesc>> can't put
					anything <<loctype>>
					\ <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}

	// Pseudo-senses for use of strings and numbers.
	// Things can only use an object as a string or number if
	// that thing is a string or number.  (Makes sense.)
	//
	// Note that these methods should not include initial caps
	// or final punctuation.
	canusealphanum(obj, loctype, silent) = {
		if (not isclass(obj, String) and not isclass(obj, Number)) {
			if (not silent)
			       "that verb requires a double-quoted 
			       string or a number.";
		
			return nil;
		}
		else
			return true;
	}
	canusealpha(obj, loctype, silent) = {
		if (not isclass(obj, String)) {
			if (not silent)
			       "that verb requires a double-quoted 
			       string.";
		
			return nil;
		}
		else
			return true;
	}
	canusenumber(obj, loctype, silent) = {
		if (not isclass(obj, Number)) {
			if (not silent)
			       "that verb requires a number.";
		
			return nil;
		}
		else
			return true;
	}
	canusenumberorlist(obj, loctype, silent) = {
		if (not isclass(obj, Number) and not isclass(obj, Listobj)) {
			if (not silent)
			       "that verb requires a number or 
			       a parenthesized list of numbers.";
		
			return nil;
		}
		else
			return true;
	}
;

//
// The general Actor class
//
// Set travelhook to a list of the form
//
//	[object1 &method1 object2 &method2 ... objectn &methodn]
//
// and the travelto method will call 
//
//	object1.(method1)(self, oldloc, oldloctype, newloc, newloctype)
//	object2.(method2)(self, oldloc, oldloctype, newloc, newloctype)
//	...
//	objectn.(methodn)(self, oldloc, oldloctype, newloc, newloctype)
//
// in order, where oldloc is the actor's location prior to the
// travel, and newloc is the actor's location after the travel.	 oldloctype
// and newloctype are the location types ('in', 'on', etc.) for the old
// and new locations respectively.  This works properly with obstacles too.
// Note that these actually get called from inside the newlocation method.
//
class Actor: Fixture, Sensor, Topic, Container
	isactor = true
	position = 'standing'	// currently standing up

	//
	// Don't normally check for any deaths due to lack
	// of food, drink, sleep, etc.
	//
	starvationcheck = nil
	turnsuntilstarvation = 0

	dehydrationcheck = nil
	turnsuntildehydration = 0

	sleepcheck = nil
	turnsuntilsleep = 0

	//
	// If the following flag is set, this actor knows 
	// about everything the player actor (Me) knows about,
	// and nothing more.  
	//
	// If the flag is not set, only things for which 
	// obj.isknownto(actor) returns true will be known.
	// This means you'll have to do lots of explicit
	// makeknownto's, which is almost never actually worth it.
	//
	knowsall = true

	actordesc = { "\^<<self.subjadesc>> <<self.is>> here."; }

	// roomCheck is true if the verb is valid in the room.	This
	// is a first pass.
	roomCheck(v) = { return true; }

	fmtYou = { self.subjprodesc; }

	reflexivedesc = {
		if (self.isplural)
			"themselves";
		else
			"<<self.objprodesc(nil)>>self";
	}

	aamessage(v, d, p, i) = {
		"\^<<self.subjthedesc>> <<self.doesnt>> seem interested.";
	}
	actorAction(v, d, p, i) = {
		if (v <> helloVerb) {
			self.aamessage(v, d, p ,i);
			exit;
		}
	}

	//
	// No travelto hooks by default
	//
	travelhook = []

	//
	// Move the actor into the given room.
	//
	travelto(room) = {
		if (room = nil) {
			// shouldn't happen
			"You can't travel to nowhere!";			
			return;
		}
		else {
			//
			// If the room parameter is actually
			// an obstacle like a door, recurse
			// on the destination behind the obstacle.
			//
			if (room.isobstacle) {
				local dest;

				dest := room.destination(self);
				if (dest <> nil)
					self.travelto(dest);
				return;
			}
			
			if (self.position <> 'standing') {
				"(\^<<self.subjprodesc>> <<standVerb.desc(self)>>
				\ up)\b";

				self.position := 'standing';
			}

			self.newlocation(room, 'in');
		}
	}

	//
	// Do all the things we need to do when the actor is in a
	// new location, but don't do travel-related things.  This
	// one also allows us to specify a location type.
	//
	newlocation(room, loctype) = {
		local oldloc, oldloctype, i, l;

		//
		// If the room parameter is actually
		// an obstacle like a door, recurse
		// on the destination behind the obstacle.
		//
		if (room.isobstacle) {
			local dest;

			dest := room.destination(self);
			if (dest <> nil)
				self.newlocation(dest, loctype);
			return;
		}

		if (self.location <> nil)
			self.location.leave(self);

		oldloc := self.location;
		oldloctype := self.locationtype;
		self.moveto(room, loctype);

		//
		// Call the travelhooks, if any.
		//
		l := self.travelhook;
		for (i := 1; i <= length(l); i += 2)
			l[i].(l[i + 1])(self, oldloc, oldloctype, room, loctype);

		room.enter(self);
	}			
		
	//
	// Actors can hear things.
	//
	islistener(actor) = { return true; }

	//
	// This method is called when the actor gets a speech command, like
	//
	//	floyd, say "hello"
	//
	// Player inherits this.  This is called by strObj.doSay.
	//
	speech_handler(s) = {
		"\^<<self.subjthedesc>> <<sayVerb.desc(self)>>\ 
		\"<<s>>\".";
	}

	//
	// The following method is called by die() when the
	// actor is killed.
	//
	diemessage = {
		"*** \^<<self.subjthedesc>> <<self.has>> died ***";
	}

	//
	// Message methods for doTake.
	//
	weightexceeded(dobj, loctype) = {
		"\^<<self.possessivedesc>> load is too heavy.";
	}
	bulkexceeded(dobj, loctype) = {
		"\^<<self.subjthedesc>> can't carry any more.";
	}

	verDoLookin(actor) = {
		"%You% can't look inside <<self.objthedesc(actor)>>.";
	}

	verIoPutin(actor) = { self.verIoGiveto(actor); }
	ioPutin(actor, dobj) = { self.ioGiveto(actor, dobj); }
	verIoTakeout(actor) = { self.verIoTakefrom(actor); }
	ioTakeout(actor, dobj) = { self.ioTakefrom(actor, dobj); }

	verIoGiveto(actor) = {}
	ioGiveto(actor, dobj) = {
		"\^<<self.subjthedesc>> <<self.doesnt>>
		\ seem interested in <<dobj.objthedesc(actor)>>.";
	}
	verIoShowto(actor) = {}
	ioShowto(actor, dobj) = {
		"\^<<self.subjthedesc>> <<self.doesnt>>
		\ seem interested in <<dobj.objthedesc(actor)>>.";
	}
	verIoThrowat(actor) = { self.verIoGiveto(actor); }
	ioThrowat(actor, dobj) = { self.ioGiveto(actor, dobj); }
	verIoThrowto(actor) = { self.verIoGiveto(actor); }
	ioThrowto(actor, dobj) = { self.ioGiveto(actor, dobj); }

	verIoTakefrom(actor) = {}
	ioTakefrom(actor, dobj) = {
		"\^<<self.subjthedesc>> <<self.has>> 
		<<dobj.objthedesc(actor)>> and won't let
		<<actor.objprodesc(self)>> have <<dobj.prodesc>>.";
	}
	verDoAskabout(actor, io) = {
		"\^<<self.subjthedesc>> <<self.doesnt>> have much
		to say about <<io.objthedesc(self)>>.";
	}

	acceptsput(actor, loctype) = { return true; }

	passgen(actor, obj, loctype, passmethod) = {
		"\^<<actor.youll>> have to convince
		<<self.objthedesc(nil)>> to give ";

		if (obj = nil)
			"that to <<actor.objprodesc(nil)>>";
		else
			"<<actor.objprodesc(nil)>> <<obj.objthedesc(nil)>>";

		" first.";

		return nil;
	}
	passcantouchin(actor, obj, loctype) = { 
		return self.passgen(actor, obj, loctype, &passcantouch);
	}
	passcantakein(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcantake);
	}
;
//
// Itemactors are just like Actors except that they can be
// taken (i.e., they are Items).  The Itemactor's isactor method
// is only true (and hence the actordesc is only used) when
// the actor's location is a Room.
//
class Itemactor: Item, Actor
	isactor = {
		if (isclass(self.location, Room))
			return true;
		else
			return nil;
	}
	isfixture = nil
;

//
// Follower -- should probably redesign this
//
class Follower: Actor
    sdesc = { self.myactor.sdesc; }
    isfollower = true
    ldesc = { caps(); self.thedesc; " is no longer here. "; }
    actorAction(v, d, p, i) = { self.ldesc; exit; }
    actordesc = {}
    myactor = nil   // set to the Actor to be followed
    verDoFollow(actor) = {}
    doFollow(actor) =
    {
	actor.travelto(self.myactor.location);
    }
    dobjGen(a, v, i, p) =
    {
	if (v <> followVerb)
	{
	    "\^<< self.myactor.thedesc >> is no longer here.";
	    exit;
	}
    }
    iobjGen(a, v, d, p) =
    {
	"\^<< self.myactor.thedesc >> is no longer here.";
	exit;
    }
;
//
// Classes to inherit from to mark gender
//
class Male: Thing
	// note: can be plural!

	isHim = true	// can call this "him"
			// NOTE: the run-time checks this, not our code

	youre = {
		if (self.isplural)
			"they're";
		else
			"he's";
	}
	subjprodesc = {
		if (self.isplural)
			"they";
		else
			"he";
	}
	objprodesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else {
			if (self.isplural)
				"them";
			else
				"him";
		}
	}
	possessivedesc = {
		if (self.isplural)
			"their";
		else
			"his";
	}
;
class Female: Thing
	// note: can be plural!

	isHer = true	// can call this "her"
			// NOTE: the run-time checks this, not our code

	youre = {
		if (self.isplural)
			"they're";
		else
			"she's";
	}
	subjprodesc = {
		if (self.isplural)
			"they";
		else
			"she";
	}
	objprodesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else {
			if (self.isplural)
				"them";
			else
				"her";
		}
	}
	possessivedesc = {
		if (self.isplural)
			"their";
		else
			"her";
	}
;
//
// The player class is strictly for the main character in a game
// with only one player-controlled actor, as is typical.
//
class Player: Actor
	// don't list contents in room descriptions
	incontentslisted(obj) = { return nil; }

	isplural = true		// remember, this is only syntactic!
	isdetermined = true

//	noun = 'me' 'myself' 'self'
	
	is = "are"
	isnt = "aren't"
	does = "do"
	doesnt = "don't"
	has = "have"
	doesnthave = "don't have"
	youre = "you're"
	
	// shouldn't need the following three
	sdesc = "you"
	thedesc = "you"
	adesc = "you"
	ldesc = {
		"You are <<self.position>>";
		if (self.position = 'lying' or self.position = 'sitting')
			" down.";
		else
			".";
	}
	
	subjsdesc = "you"
	subjthedesc = "you"
	subjadesc = "you"
	subjprodesc = "you"
	objprodesc(actor) = {
		if (actor = self)
			self.reflexivedesc;
		else
			"you";
	}
	
	possessivedesc = "your"
	reflexivedesc = "yourself"

	// Total weight player can carry
	maxweight = 20

	// Total number of items player can carry
	maxbulk = 20

	// "You" can give "yourself" commands.
	//
	actorAction(verb, dobj, prep, iobj) = {}

	//
	// When things get put into the player,
	// we say "Taken" instead of "Done."
	// 
	putmessage(dobj, loctype) = { "Taken."; }
	
	//
	// roomAction is mainly for nested rooms
	//
	roomAction(a, v, d, p, i) = {
		if (self.location <> nil)
			self.location.roomAction(a, v, d, p, i);
	}

	//
	// Inventory.
	//
	inventory = {
		local	tot;

		//
		// Make sure the Player can see himself.
		//
		caps();
		if (not self.cansee(self, nil, nil))
			return;
		
		tot := listcontents(self, self, 3, nil, nil, nil, nil, true, true, nil, nil);
		if (tot = 0)
			"You don't appear to be carrying anything.";
	}

	verIoPutin(actor) = {
		"%You% can't put things in <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% can't take things out of <<self.objthedesc(actor)>>.";
	}
	verIoGiveto(actor) = {
		"%You% can't give things to <<self.objthedesc(actor)>>.";
	}
	verIoShowto(actor) = {
		"%You% can't show things to <<self.objthedesc(actor)>>.";
	}
	verIoThrowat(actor) = {
		"%You% can't throw things at <<self.objthedesc(actor)>>.";
	}
	verIoThrowto(actor) = {
		"%You% can't throw things to <<self.objthedesc(actor)>>.";
	}
	verIoTakefrom(actor) = {
		"%You% can't take things from <<self.objthedesc(actor)>>.";
	}

	//
	// Check for starvation, dehydration, and death due to lack
	// of sleep.
	//
	mealtime = 240
	starvationcheck = {
		local t;
		
		self.turnsuntilstarvation--;
		t := self.turnsuntilstarvation;
		self.starvationmessage(t);
		if (t < 1)
			die();
	}
	//
	// starvationmessage gets passed the number of turns remaining
	// until the actor dies of malnutrition.  It should print
	// messages based on the turn count to warn the player of
	// the impending death.	 This method must at the very least
	// tell the player the actor has dies when t = 0 because
	// starvationcheck calls die() when this is the case.
	//
	starvationmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> simply can't go on any
				longer without food. \^<<self.subprodesc>> ";
				
				if (self.isplural)
					"perish";
				else
					"perishes";
					
				" from lack of nutrition.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> can't go much
				longer without food. ";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very hungry.	\^<<self.subjprodesc>>
				\ better find some food soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit peckish.  Perhaps it would
				be a good idea to find something to eat.";
				break;
		}
	}
	
	drinktime = 140
	dehydrationcheck = {
		local t;
		
		self.turnsuntildehydration--;
		t := self.turnsuntildehydration;
		self.dehydrationmessage(t);
		if (t < 1)
			die();
	}
	dehydrationmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> simply can't go on any
				longer without water. \^<<self.subprodesc>> ";
				
				if (self.isplural)
					"die";
				else
					"dies";
					
				" of thirst.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> can't go much
				longer without water. ";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very thirsty.	 \^<<self.subjprodesc>>
				\ better find something to drink soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit thirsty.  Perhaps it would
				be a good idea to find something to drink.";
				break;
		}
	}
	sleeptime = 440
	sleepcheck = {
		local t;
		
		self.turnsuntilsleep--;
		t := self.turnsuntilsleep;
		self.sleepmessage(t);
		if (t < 1) {
			//
			// When the player collapses from lack we call
			// self.sleep.	By default this doesn't do
			// anything.  It could change the turn counter,
			// cause the player to be killed, make him lose
			// some of his possessions, etc.
			//
			self.sleep;
		}
	}
	sleep = {
		P(); I(); "\^<<self.subjthedesc>> ";
		if (self.isplural)
			"wake";
		else
			"wakes";
		" up later with a headache.";
		self.turnsuntilsleep := self.sleeptime;
	}
	sleepmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> ";

				if (self.isplural)
					"pass out";
				else
					"passes out";

				" from exhaustion.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>> so
				tired, <<self.subjprodesc>> can barely keep
				<<self.possessivedesc>> eyes open.";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very sleepy.	\^<<self.subjprodesc>>
				\ better find a place to rest soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit sleepy.	 Perhaps it would
				be a good idea to a place to sleep.";
				break;
		}
	}

	//
	// Normally, an Actor does not allow things to be removed
	// from itself.	 This is to prevent the player form taking
	// stuff that actors are carrying.
	//
	// However, we assume that an Actor will never try to take
	// something from a Player unless this is a result of a 
	// player to actor command like
	//
	//	>salesperson, take credit card [from me]
	//
	// We want this to either work (i.e., get mapped to
	// 
	//	>give credit card to saleperson
	//
	// or print a helpful eror message.  Since the first option
	// is quite difficult to get right, we'll take the easy way
	// out and just print an informative message.
	//
	passgen(actor, obj, loctype, passmethod) = {
		"If you want to give another character access to
		<<self.possessivedesc>> belongings, you'll have
		to be more direct about it.  For example, \"give
		item to actor\".";

		return nil;
	}
	passcantouchin(actor, obj, loctype) = { 
		return self.passgen(actor, obj, loctype, &passcantouch);
	}
	passcantakein(actor, obj, loctype) = {
		return self.passgen(actor, obj, loctype, &passcantake);
	}
;

	/*
	 * Verbs
	 */
//
// The following function gets called when the parser needs the player
// to fill in the direct or indirect object.  E.g.,
//
//	>unlock
//	Unlock what?
//
//	>unlock door
//	With what?
//
// These messages are a bit snappy, but we want to avoid saying "it"
// since the subject may actually be plural (and we have no way
// of telling what the object is).
//
parseAskobj: function(v, ...)
{
	caps();
	
	if (argcount = 2) {
		local p := getarg(2);

		if (p <> nil)
			p.sdesc;
		else
			"to";
	}
	else
		"<<v.sdesc>>";

	" what?";
}
//
// The following function gets called when there's a parse error.
// We complain about "all" when it's not allowed.
//
parseError: function(str, num)
{
	if (global.allerror) {
		global.allerror := nil;
		return 'You can\'t use all with that verb.';
	}
	else
		return nil;
}
class Verb: object
	sdesc = "verb"

	//
	// This method prints the verb, marked according to the 
	// object that is the subject.	E.g.,
	//
	//	"\^<<actor.thedesc>> <<openVerb.desc(actor)>> the book.";
	//
	// would become
	//
	//	"The troll opens the book.";
	//
	// if the actor is singular, but
	//
	//	"The trolls open the book.";
	//
	// if the actor is plural.
	//
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"<<self.sdesc>>s";
	}

	//
	// Properties of the actor that must be true for this verb and object.
	//
	// The properties are called with parameters obj and silent,
	// where obj is the object, and silent is a boolean indicating
	// whether or not the error message (if any) should be printed.
	// The properties must return nil if the access is not allowed;
	// true otherwise.
	//
	// By default direct objects require the same methods as indirect
	// objects, but this isn't be true for all verbs.
	//
	requires = [[]]
	dorequires = { return self.requires; }
	iorequires = { return self.requires; }

	//
	// If this boolean is true, we'll print an explanation of why
	// the verb could not be applied to the object when a requirement
	// is not satisified.  We don't want this on for verbs whose
	// only action is to satisfy the requirement.
	//
	// For example, the verb "take" requires &cantake, but we
	// don't want to print
	//
	//	You can't do that, because you can't take the ...
	//
	// Since all the player is trying to do is take the thing, we'd
	// rather just get
	//
	//	You can't take the ...
	//
	// For verbs whose action needs but is not equivalent to the
	// requirements, we want a full explanation:
	//
	//	>eat kee
	//	You can't do that, because you can't take the cheez kee.
	//
	longexplanation = true
	dolongexplanation = { return self.longexplanation; }
	iolongexplanation = { return self.longexplanation; }

	//
	// This function is called when nothing matched by the do/io
	// vocabulary is accessible.
	//
	cantReach(actor, dolist, iolist, prep) = {
		local	i, lbase, l, isdo;

		if (global.playtestfailtime = global.ticks) {
			"That command is only for playtesting!";
			return;
		}

		if (iolist <> nil) {
			lbase := iolist;
			isdo := nil;
		}
		else {
			lbase := dolist;
			isdo := true;
		}

		//
		// Remove things that aren't known to the actor.
		//
		l := [];
		for (i := 1; i <= length(lbase); i++) {
			if (lbase[i].isknownto(actor)) {
				l += lbase[i];
			}
		}

		//
		// If there are no objects left, pretend we don't know
		// what the player's talking about.
		//
		// If there's a single object in the list, print a
		// full explanation.
		//
		// If there are any objects in the list that are in
		// the actor's current location, print full explanations
		// for these objects.
		//
		// If all else fails, tell the player that no objects
		// with this vocabulary are acceptable in this context.
		//
		if (l = []) {
			"\^<<actor.subjprodesc>> <<actor.doesnt>> know
			what that is.";

			// "I can't imagine what you're referring to.";

			return;
		}
		else if (length(l) = 1) {
			self.invalidobject(actor, l[1], isdo);
			setit(l[1]);
		}
		else {
			local	l2;

			l2 := [];
			for (i := 1; i <= length(l); i++)
				if (l[i].iscontained(actor.location, nil))
					l2 += l[i];

			if (l2 = [])
				"There is nothing here matching that 
				vocabulary that <<actor.subjprodesc>> can
				do that to.";
			else if (length(l2) = 1) {
				self.invalidobject(actor, l2[1], isdo);
				setit(l2[1]);
			}
			else for (i := 1; i <= length(l2); i++)
				"<<l2[i].multisdesc>>: <<self.invalidobject(actor, l2[i], isdo)>>\n";
		}
	}

	//
	// A hack is that we sometimes want to say "you can't
	// do that because <blah blah blah>," whereas other times 
	// we just want to print the message that the checkDo
	// method printed.  The global flag global.canoutput, if
	// true tells us to do the latter.  this is set by the canX
	// methods in sensor.
	//
	// When global.canoutput is true (i.e., when we're not printing
	// a generic message), we usually still want to explain which 
	// action failed.  So for the methods listed in global.senses,
	// we print "(trying to ____ the ____ first)".	E.g.,
	//
	//	>eat papers
	//	(trying to take the papers first)
	//
	//	There are too many papers to carry.
	//
	// (It's clear from this example that we have to be a bit
	// careful about what failure messages we put in verDoTake!)
	//
	invalidobject(actor, o, isdo) = {
		local	v := self;
		
		//
		// If the actor's not really an actor, call the
		// actor's message.  (This is for fools who try stuff
		// like "cheez kee, examine sword")
		//
		if (not isclass(actor, Actor)) {
			actor.aamessage(v, o, nil, nil);
			return;
		}

		if (isdo)
			v.checkDo(actor, o, true);
		else
			v.checkIo(actor, o, true);

		if (isdo and v.dolongexplanation or not isdo and v.iolongexplanation) {
			if (not global.canoutput) {
				"%You% can't do that, because ";
			}
			else {
				local	pos;

				pos := find(global.senses, global.failedsense);
				if (pos <> nil)
					"(trying to <<global.senses[pos+1]>>
					\ <<o.objthedesc(actor)>> first)\b";

				caps();
			}
		}
		else	
			caps();

		if (isdo)
			v.checkDo(actor, o, nil);
		else
			v.checkIo(actor, o, nil);
	}

	//
	// Check object requirements common to both do and io cases.
	//
	// The actor must know about an object to do anything to it,
	// unless this verb is a Systemverb.
	//
	checkCommon(actor, obj, silent) = {
		//
		// Disallow room vocabulary unless we're using a 
		// system verb.	 We don't want room nouns and adjectives
		// to interfere with manipulable objects.
		//
		if (isclass(obj, Room))
			if (not isclass(obj, Nestedroom))
				if (not isclass(self, Systemverb)) {
					if (not silent)
						"I don't know what you're referring to.";

					global.canoutput := true;
					return nil;
				}

		if (not obj.isknownto(actor) and not isclass(self, Systemverb)) {
			//
			// If an object that the actor is carrying
			// is not known to the actor, make it known
			// to him.  (This can happen when an actor
			// "finds" an object and the game automatically
			// moves it into his inventory without the
			// player actually seeing the object.)
			//
			// This is no longer needed, since we take care
			// of this in Thing.makecontentsknown, but I've
			// left it in here in case I wanted to put it
			// back the way it was someday.
			//
#ifdef NEVER
			if (obj.isin(actor)) {
				obj.makeknownto(actor);
				return true;
			}
#endif

			if (not silent)
				"I can't imagine what you're referring to.";

			global.canoutput := true;
			return nil;
		}
		else
			return true;
	}

	//
	// Check requirements in our requirements list.
	//
	checkReq(actor, obj, silent, requirements) = {
		local i, j, len, loctype, prep, req;

		//
		// See if lastprep is from this turn.
		// If not, it's stale, which means that
		// this command has no prep.
		//
		if (global.lastpreptime <> global.ticks) {
//			"lastpreptime = <<global.lastpreptime>>\n";
//			"ticks = <<global.ticks>>\n";

			prep := nil;
		}
		else
			prep := global.lastprep;

		if (prep = nil)
			loctype := nil;
		else switch (prep) {
			case inPrep:
				loctype := 'in';
				break;
			case onPrep:
				loctype := 'on';
				break;
			case underPrep:
				loctype := 'under';
				break;
			case behindPrep:
				loctype := 'behind';
				break;
			default:
				loctype := nil;
				break;
		}

		//
		// Get list of requirements for this prep.
		// Use first list in requirements list if prep not found or nil.
		//
		// The format for the requirements list is as follows:
		//
		// [ [&cantake ...] fromPrep withPrep [&cansee ...] toPrep [...] ]
		//
		if (prep = nil) {
			req := requirements[1];
		}
		else {
			for (i := 1; i <= length(requirements); i++)
				if (requirements[i] = prep)
					break;
			
			if (i > length(requirements)) {
				req := requirements[1];
			}
			else {
				// Find next element that is a list
				for (j := i + 1; j <= length(requirements); j++)
					if (datatype(requirements[j]) = 7) {
						req := requirements[j];
						break;
					}
			}
		}

		len := length(req);
		for (i := 1; i <= length(req); i++)
			if (not actor.(req[i])(obj, loctype, silent)) {
				global.failedsense := req[i];
				return nil;
			}

		return true;
	}

	checkDo(actor, obj, silent) = {
		local i;

//		"checkDo(self = <<self.sdesc>>, obj = <<obj.sdesc>>)\n";

		if (not self.checkCommon(actor, obj, silent))
			return nil;

//		"checkDo: self.checkReq\n";

		if (not self.checkReq(actor, obj, silent, self.dorequires))
			return nil;

		return true;
	}

	//
	// Check to see if we're in playtesting mode.  If not, don't
	// allow Debugverbs to work.  (We send a message to Verb.cantReach
	// via global.playtestfailtime so that a message to this effect will
	// be printed.)
	//
	playtestcheck = {
		if (isclass(self, Debugverb) and not global.playtesting) {
			global.playtestfailtime := global.ticks;
			return true;
		}
		else
			return nil;
	}

	validDo(actor, obj, seqno) = {
		local ret;

		global.lastverb := self;
		global.lastactor := actor;
		global.lastdo := obj;

//		if (not isclass(actor, Actor))
//			return nil;

		if (self.playtestcheck)
			return nil;

		ret := self.checkDo(actor, obj, true);
/*
		if (ret = nil)
			"validDo: return nil for
			 <<self.sdesc>>(<<obj.objthedesc(nil)>>).";
		else
			"validDo: return true for
			 <<self.sdesc>>(<<obj.objthedesc(nil)>>).";
*/
		return ret;
	}

	// The following method returns a list of validDo objects.
	// This speeds up parsing.  All objects in the list returned
	// are submitted to validDo, so this can return too much.
	validDoList(actor, prep, iobj) = {
		global.lastprep := prep;
		global.lastpreptime := global.ticks;
		return nil;
	}

	checkIo(actor, obj, silent) = {
		local i;

//		"checkIo(self = <<self.sdesc>>, obj = <<obj.sdesc>>)\n";

		if (not self.checkCommon(actor, obj, silent))
			return nil;

		if (not self.checkReq(actor, obj, silent, self.iorequires))
			return nil;

		return true;
	}
	validIo(actor, obj, seqno) = {
		local ret;

		global.lastverb := self;
		global.lastactor := actor;
		global.lastio := obj;

//		if (not isclass(actor, Actor))
//			return nil;

		ret := self.checkIo(actor, obj, true);
/*
		if (ret = nil)
			"validIo: return nil for
			 <<self.sdesc>>(<<obj.objthedesc(nil)>>).";
		else
			"validIo: return true for
			 <<self.sdesc>>(<<obj.objthedesc(nil)>>).";
*/
		return ret;
	}

	// The following method returns a list of validIo objects.
	// This speeds up parsing.  All objects in the list returned
	// are submitted to validIo, so this can return too much.
	validIoList(actor, prep, dobj) = {
		global.lastprep := prep;
		global.lastpreptime := global.ticks;
		return nil;
	}

	//
	// The parser calls this method when it can't find a
	// ver... method for the specified object.  This generally
	// indicates the programmer has omitted something.
	//
	invalidObj(actor, obj, name) = {
		"%You% can't <<self.sdesc>> <<obj.objthedesc(actor)>>.";
	}

	//
	// For most verbs we don't want to allow multiple direct
	// objects (including "all").  Verbs for which multiple
	// direct objects are to be allowed should have allok = true
	//
	allok = nil

	//
	// These methods return the list of objects for "all"
	// and for defaulting when do's and io's are omitted.
	//
	doDefault(actor, prep, io) = {
		local i, l, r, loc;

		if (not self.allok) {
			if (objwords(1) = ['A']) {
				global.allerror := true;
				return [];
			}
		}

		//
		// Get list of objects in this location.
		// If the location is a Nestedroom, add parent
		// location's contents as well.
		//
		// Keep doing this until we get to a Room or nil
		// or TOP.
		//
		loc := actor.location;
		l := [];
		for (;;) {
			l += loc.contents;

			if (not isclass(loc, Nestedroom))
				break;
			else if (loc.location = nil or loc.location = TOP)
				break;
			else
				loc := loc.location;
		}

		// keep only things that satisfy dobj requirements
		r := [];
		for (i := length(l); i > 0; i--)
			if (self.checkDo(actor, l[i], true))
				r += l[i];

		return r;
	}
	ioDefault(actor, prep) = {
		local i, l, r, loc;

		//
		// Get list of objects in this location.
		// If the location is a Nestedroom, add parent
		// location's contents as well.
		//
		// Keep doing this until we get to a Room or nil
		// or TOP.
		//
		loc := actor.location;
		l := [];
		for (;;) {
			l += loc.contents;

			if (not isclass(loc, Nestedroom))
				break;
			else if (loc.location = nil or loc.location = TOP)
				break;
			else
				loc := loc.location;
		}

		// keep only things that satisfy dobj requirements
		r := [];
		for (i := length(l); i > 0; i--)
			if (self.checkIo(actor, l[i], true))
				r += l[i];

		return r;
	}

/*
	//
	// This method rejects not only "all," but multiple direct
	// objects of any kind (e.g., plurals).	 Usually,
	// this is not what we want to do.
	// 
	rejectMultiDobj(prep) = {
		if (self.allok)
			return nil;

		"You can't use multiple direct objects with that verb.";

		abort;
		return true;
	}
 */
;
//
// Verbs that can be used with no objects.
//
class Soloverb: Verb
	action(actor) = {
		if (isclass(self, Debugverb) and not global.playtesting) {
			"That verb is only for playtesting!";
			abort;
			return;
		}

		global.lastverb := self;
		global.lastactor := actor;
		global.lastdo := nil;
		global.lastio := nil;
		self.soloaction(actor);
	}
;

// againVerb is required by the parser, which fills in the action itself.
againVerb: Verb
    verb = 'again' 'g' 'repeat'
;

//
// Incredible hack from hell.
// TADS uses the verb "takeVerb" as a placeholder whenever there
// isn't actually a verb.  The only place this seems to matter is
// when you give an actor a commnd, as in
//
//	troll, eat rabbit
//
// In this case, takeVerb.validDo will get called because the parser
// doesn't find a verb in the first part of the command (before the
// comma).  The parser needs to do this to disambiguate the actor
// who's being commanded.  (Which troll?)
//
// To hack around this, we define takeVerb to be a verb that's
// never actually used by the player.  Its only function is to
// field the disambiguation queries for actors.	 We return true
// for an object if the actor can speak to that object.
//
takeVerb: Verb
	sdesc = "takeVerb"
	verb = 'takeVerb'
	action = { "No verb here."; }
	validDo(actor, obj, seqno) = {
		return actor.canspeakto(obj, nil, true);
	}
	validIo(actor, obj, seqno) = { return nil; }

	cantReach(actor, dolist, iolist, prep) = {
		tellVerb.cantReach(actor, dolist, nil, toPrep);
	}
;
XtakeVerb: Verb
	sdesc = "take"
	verb = 'get' 'take' 'grab' 'remove'
	doAction = 'Take'
	ioAction(fromPrep) = 'Takefrom'
	ioAction(offPrep) = 'Takeoff'
	ioAction(outPrep) = 'Takeout'
	ioAction(inPrep) = 'Takeout'
	ioAction(onPrep) = 'Takeoff'
	ioAction(underPrep) = 'Takeunder'
	ioAction(outfromunderPrep) = 'Takeunder'
	ioAction(behindPrep) = 'Takebehind'
	ioAction(outfrombehindPrep) = 'Takebehind'

	dorequires = [[&cantake]]
	iorequires = [[&cansee]]

	longexplanation = nil

	// allow multiple direct objects
	allok = true

	//
	// Return a list of all Items contained in the io
	// that match the preposition.
	//
	doDefault(actor, prep, io) = {
		local i, loctypes, l, r;

		if (io = nil)
			io := actor.location;

		//
		// The player wants to take everything out of
		// a specific object.  First we convert the prep
		// to a location type (in, on, under, behind) if
		// possible.  Then we get all the contents of the
		// indirect object and prune out the ones that
		// the player can't take.
		//
		switch (prep) {
		    case offPrep:
		    case onPrep:
			loctypes := ['on'];
			break;
		    case outPrep:
		    case inPrep:
			loctypes := ['in'];
			break;
		    case underPrep:
		    case outfromunderPrep:
			loctypes := ['under'];
		    case behindPrep:
		    case outfrombehindPrep:
			loctypes := ['behind'];
			break;
		    case fromPrep:
			loctypes := global.loctake;
			break;
		    default:
			loctypes := nil;
			break;
		}


		l := io.itemcontents(actor, loctypes) - 
			actor.itemcontents(actor, nil);

		// keep only things that satisfy dobj requirements
		r := [];
		for (i := length(l); i > 0; i--)
			if (self.checkDo(actor, l[i], true))
				r += l[i];

		return r;
	}
;
dropVerb: Verb
	sdesc = "drop"
	verb = 'drop' 'put down'
	ioAction(onPrep) = 'Puton'
	ioAction(inPrep) = 'Putin'
	ioAction(underPrep) = 'Putunder'
	ioAction(behindPrep) = 'Putbehind'
	ioAction(outPrep) = 'Putthrough'	// for windows
	ioAction(throughPrep) = 'Putthrough'	// ditto
	doAction = 'Drop'
	dorequires = [[&cantake]]
	iorequires = [[&cansee]]

	allok = true

	doDefault(actor, prep, io) = {
		return actor.itemcontents(actor, nil);
	}
;
tasteVerb: Verb
	sdesc = "taste"
	verb = 'taste' 'lick'
	doAction = 'Taste'
	requires = [[&cantouch]]
;
inspectVerb: Verb
	sdesc = "inspect"
	verb = 'inspect' 'examine' 'look at' 'l at' 'x' 'ex'
	doAction = 'Inspect'
	requires = [[&cansee]]
	longexplanation = nil

	allok = nil
;
lookVerb: Soloverb
	sdesc = "look at"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks at";
	}
	verb = 'look' 'l' 'look around' 'l around'
	soloaction(actor) = {
		actor.location.lookaround(actor, true);
	}
	doAction = 'Inspect'
	requires = [[&cansee]]
	longexplanation = nil
;
inventoryVerb: Soloverb
	sdesc = "take inventory of"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"takes inventory of";
	}
	verb = 'inventory' 'i'
	soloaction(actor) = { actor.inventory; }
;
touchVerb: Soloverb
	sdesc = "touch"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"touches";
	}
	verb = 'touch' 'feel' 'feel around'
	soloaction(actor) = {
		actor.location.feelaround(actor, true);
	}
	doAction = 'Touch'
	ioAction(withPrep) = 'Touchwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
	dolongexplanation = nil
	iolongexplanation = true
;
smellVerb: Soloverb
	sdesc = "smell"
	verb = 'smell' 'sniff' 'waft'	
	soloaction(actor) = {
		actor.location.smellaround(actor, true);
	}
	doAction = 'Smell'
	requires = [[&cansmell]]
	longexplanation = nil
;
listentoVerb: Soloverb
	sdesc = "listen to"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"listen to";
	}
	verb = 'listen' 'listen to' 'hear'
	soloaction(actor) = {
		actor.location.listenaround(actor, true);
	}
	doAction = 'Listento'
	requires = [[&canhear]]
	longexplanation = nil
;
eatVerb: Verb
	sdesc = "eat"
	verb = 'eat' 'consume' 'swallow'
	doAction = 'Eat'
	requires = [[&cantake]]
;
askaboutVerb: Verb
	sdesc = "ask about"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"asks about";
	}
	verb = 'ask' 'inquire' 'enquire' 'question' 'query'
	prepDefault = aboutPrep
	ioAction(aboutPrep) = 'Askabout'
	ioAction(forPrep) = 'Askfor'
	dorequires = [[&canspeakto, &canhear]]
	iorequires = [[&isatopic]]
;
sayVerb: Verb
	sdesc = "say"
	verb = 'say' 'speak' 'utter' 'answer'
	doAction = 'Say'
	requires = [[&canusealpha]]
;
// yell does the same thing as say by default
yellVerb: Verb
	sdesc = "yell"
	verb = 'yell' 'shout' 'scream'
	doAction = 'Say'
	requires = [[&canusealpha]]
;
lookinVerb: Verb
	sdesc = "look in"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks in";
	}
	verb =	'look in' 'look into' 'look inside' 'look downin'
		'l in' 'l into' 'l inside' 'l downin'
	
	doAction = 'Lookin'
	requires = [[&cansee]]
;
lookonVerb: Verb
	sdesc = "look at what's on"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks at what's on";
	}
	verb =	'look on' 'look onto' 'look downon' 'look upon'
		'l on' 'l onto' 'l downon' 'l upon'
	doAction = 'Lookon'
	requires = [[&cansee]]
;
lookunderVerb: Verb
	sdesc = "look under"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks under";
	}
	verb =	'look under' 'look beneath'
		'l under' 'l beneath'
	doAction = 'Lookunder'
	requires = [[&cansee]]
;
lookbehindVerb: Verb
	sdesc = "look behind"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks behind";
	}
	verb =	'look behind'
		'l behind'
	doAction = 'Lookbehind'
	requires = [[&cansee]]
;
lookthroughVerb: Verb
	sdesc = "look through"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"looks through";
	}
	verb =	'look through' 'look thru'
		'l through' 'l thru'
	doAction = 'Lookthrough'
	requires = [[&cansee]]
;
putVerb: Verb
	sdesc = "put"
	verb = 'put' 'place' 'position' 'insert' // 'set' resolved in turnVerb

	prepDefault = inPrep	
	ioAction(inPrep) = 'Putin'
	ioAction(onPrep) = 'Puton'
	ioAction(underPrep) = 'Putunder'
	ioAction(behindPrep) = 'Putbehind'
	ioAction(throughPrep) = 'Putthrough'

	dorequires = [[&cantake]]
	iorequires = [[&canputinto]]

	dolongexplanation = true
	iolongexplanation = nil

	allok = true
	doDefault(actor, prep, io) = {
		return actor.itemcontents(actor, nil);
	}
;
tellVerb: Verb
	sdesc = "tell"
	verb = 'tell'
	prepDefault = aboutPrep
	ioAction(aboutPrep) = 'Tellabout'
	ioAction(toPrep) = 'Tellto'
	dorequires = [
			[&canspeakto]
		toPrep	[&isatopic]
	]
	iorequires = [
			[&isatopic]
		toPrep	[&canspeakto]
	]
;
followVerb: Verb
	sdesc = "follow"
	verb = 'follow'
	doAction = 'Follow'
	requires = [[&cansee]]	// potential problem here...
;
digVerb: Verb
	sdesc = "dig in"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"digs in";
	}
	verb =	'dig' 'dig in' 'dig into' 'dig inside' 'dig downin'
		'excavate' 'exhume'
	prepDefault = withPrep
	ioAction(withPrep) = 'Digwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
pushVerb: Verb
	sdesc = "push"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"pushes";
	}
	verb = 'push' 'press' 'depress'
	doAction = 'Push'
	ioAction(onPrep) = 'Typeon'

	dorequires = [
			[&cantouch]
		onPrep	[&canusealphanum]
	]
	iorequires = [
			[]
		onPrep	[&cantouch]
	]
;
attachVerb: Verb
	sdesc = "attach"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"attaches";
	}
	verb = 'attach' 'connect'
	prepDefault = toPrep
	ioAction(toPrep) = 'Attachto'
	dorequires = [[&cantake]]
	iorequires = [[&cantouch]]
;
tieVerb: Verb
	sdesc = "tie"
	verb = 'tie' 'lash'
	prepDefault = toPrep
	ioAction(toPrep) = 'Tieto'
	ioAction(onPrep) = 'Tieto'
	dorequires = [[&cantake]]
	iorequires = [[&cantouch]]
;
wearVerb: Verb
	sdesc = "wear"
	verb = 'wear' 'put on' 'don'
	doAction = 'Wear'
	requires = [[&cantake]]
;
unwearVerb: Verb
	sdesc = "take off"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"takes off";
	}
	verb = 'take off' 'doff'
	doAction = 'Unwear'
	ioAction(fromPrep) = 'Takefrom'
	dorequires = [[&cantake]]
	iorequires = [[&cansee]]
;
openVerb: Verb
	sdesc = "open"
	verb = 'open'
	doAction = 'Open'
	requires = [[&cantouch]]
;
closeVerb: Verb
	sdesc = "close"
	verb = 'close'
	doAction = 'Close'
	requires = [[&cantouch]]
;
plugVerb: Verb
	sdesc = "plug"
	verb = 'plug'
	prepDefault = inPrep
	ioAction(inPrep) = 'Plugin'
	requires = [[&cantouch]]
;
screwVerb: Verb
	sdesc = "screw"
	verb = 'screw'
	doAction = 'Screw'
	ioAction(withPrep) = 'Screwwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
unscrewVerb: Verb
	sdesc = "unscrew"
	verb = 'unscrew'
	doAction = 'Unscrew'
	ioAction(withPrep) = 'Unscrewwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
setVerb: Verb
	sdesc = "set"
	verb = 'set'
	doAction = 'Turn'
	ioAction(toPrep) = 'Turnto'
	ioAction(inPrep) = 'Putin'
	ioAction(onPrep) = 'Puton'
	ioAction(underPrep) = 'Putunder'
	ioAction(behindPrep) = 'Putbehind'
	ioAction(throughPrep) = 'Putthrough'

	dorequires = [[&cantouch]]
	iorequires = [
			[&canputinto]
		toPrep	[&canusenumberorlist]
	]
;
turnVerb: Verb
	sdesc = "turn"
	verb = 'turn' 'rotate' 'twist' 'dial' 'tune'
	doAction = 'Turn'
	ioAction(toPrep) = 'Turnto'

	dorequires = [[&cantouch]]
	iorequires = [[&canusenumberorlist]]
;
switchVerb: Verb
	sdesc = "switch"
	verb = 'switch'
	doAction = 'Switch'
	dorequires = [[&cantouch]]
;
flipVerb: Verb
	verb = 'flip' 'flick'
	sdesc = "flip"
	doAction = 'Flip'
	requires = [[&cantouch]]
;
turnonVerb: Verb
	sdesc = "turn on"
	verb = 'activate' 'turn on' 'switch on' 'enable' 'start' 'start up'
	doAction = 'Turnon'
	requires = [[&cansee]]
;
turnoffVerb: Verb
	sdesc = "turn off"
	verb = 'turn off' 'deactivate' 'switch off' 'disable'
	doAction = 'Turnoff'
	requires = [[&cansee]]
;
sitVerb: Soloverb
	sdesc = "sit"
	verb = 'sit' 'sit down'
	soloaction(actor) = {
		local	o;

		o := actor.location.ground;
		if (o = true or o = nil)
			o := Ground;

		if (sitonVerb.validDo(actor, o, 0)) {
			Outhide(true);
			o.verDoSiton(actor);
			if (Outhide(nil))
				"You'll have to	be more specific.";
			else
				o.doSiton(actor);
		}
		else
			"You'll have to be more specific.";
	}
;
sitonVerb: Verb
	sdesc = "sit on"
	verb = 'sit on' 'sit downon' 'sit upon'
	doAction = 'Siton'
	requires = [[&cantouch]]
;
sitinVerb: Verb
	sdesc = "sit in"
	verb = 'sit in' 'sit downin'
	doAction = 'Sitin'
	requires = [[&cantouch]]
;
lieVerb: Soloverb
	sdesc = "lie"
	verb = 'lie' 'lie down'
	soloaction(actor) = {
		local	o;

		o := actor.location.ground;
		if (o = true or o = nil)
			o := Ground;

		if (lieonVerb.validDo(actor, o, 0)) {
			Outhide(true);
			o.verDoLieon(actor);
			if (Outhide(nil))
				"You'll have to	be more specific.";
			else
				o.doLieon(actor);
		}
		else
			"You'll have to be more specific.";
	}
;
lieinVerb: Verb
	sdesc = "lie in"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"lies in";
	}
	verb = 'lie in' 'lie downin'
	doAction = 'Liein'
	requires = [[&cantouch]]
;
lieonVerb: Verb
	sdesc = "lie on"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"lies on";
	}
	verb = 'lie on' 'lie downon' 'lie upon'
	doAction = 'Lieon'
	requires = [[&cantouch]]
;
getoutVerb: Verb
	sdesc = "get out of"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets out of";
	}
	verb = 'get out' 'get outof'
	doAction = 'Getout'
	requires = [[&cantouch]]
;
getoffVerb: Verb
	sdesc = "get off of"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets off of";
	}
	verb = 'get off' 'get offof'
	doAction = 'Getoff'
	requires = [[&cantouch]]
;
getoutfrombehindVerb: Verb
	sdesc = "get out from behind"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets out from behind";
	}
	verb = 'get outfrombehind'
	doAction = 'Getoutfrombehind'
	requires = [[&cantouch]]
;
getoutfromunderVerb: Verb
	sdesc = "get out from under"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets out from under";
	}
	verb = 'get outfromunder'	// TADS >= 2.2: add 'get outfromunderneath'
	doAction = 'Getoutfromunder'
	requires = [[&cantouch]]
;
getinVerb: Verb
	sdesc = "get in"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets in";
	}
	verb = 'get in' 'get into' 'get inside' 'get downin'
	doAction = 'Getin'
	requires = [[&cantouch]]
;
getonVerb: Verb
	sdesc = "get on"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets on";
	}
	verb = 'get on' 'get onto' 'stand on' 'go on' 'get downon'
	doAction = 'Geton'
	requires = [[&cantouch]]
;
getunderVerb: Verb
	sdesc = "get under"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets under";
	}
	verb = 'get under' 'get underneath' 'stand under' 'stand underneath'
		'go under' 'go underneath'
	doAction = 'Getunder'
	requires = [[&cantouch]]
;
getbehindVerb: Verb
	sdesc = "get behind"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets behind";
	}
	verb = 'get behind' 'stand behind' 'go behind'
	doAction = 'Getbehind'
	requires = [[&cantouch]]
;
boardVerb: Verb
	verb = 'board'
	sdesc = "board"
	doAction = 'Board'
	requires = [[&cantouch]]
;
waitVerb: Soloverb
	sdesc = "wait for"
	verb = 'wait' 'z' 'pause'
	soloaction(actor) = {
		"Time passes...\n";
	}
;
attackVerb: Verb
	verb = 'attack' 'kill'
	sdesc = "attack"
	prepDefault = withPrep
	ioAction(withPrep) = 'Attackwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
hitVerb: Verb
	sdesc = "hit"
	verb =	'hit' 'punch' 'beat' 'pound' 'bang'
		'bang on' 'bang upon' 'bang downon' 'bang onto'
		'hit on' 'hit upon' 'hit downon' 'hit onto'
		'punch on' 'punch upon' 'punch downon' 'punch onto'
		'beat on' 'beat upon' 'beat downon' 'beat onto'
		'pound on' 'pound upon' 'pound downon' 'pound onto'
	doAction = 'Hit'
	ioAction(withPrep) = 'Hitwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
kickVerb: Verb
	sdesc = "kick"
	verb = 'kick' 'boot'
	doAction = 'Kick'
	requires = [[&cantouch]]
;
breakVerb: Verb
	sdesc = "break"
	verb = 'break' 'destroy' 'damage' 'bust' 'mangle' 'smash' 'shatter'
	doAction = 'Break'
	ioAction(withPrep) = 'Hitwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
climbVerb: Verb
	sdesc = "climb"
	verb =	'climb' 'scale' 'clamber' 'clamber up' 'climb up' 'scale up'

	// Might want to consider 'climb into', 'climb onto' etc.

	doAction = 'Climb'
	requires = [[&cantouch]]
;
drinkVerb: Verb
	sdesc = "drink"
	verb = 'drink' 'quaff' 'imbibe'
	doAction = 'Drink'
	requires = [[&cantouch]]
;
giveVerb: Verb
	sdesc = "give"
	verb = 'give' 'offer'
	prepDefault = toPrep
	ioAction(toPrep) = 'Giveto'
	dorequires = [[&cantake]]
	iorequires = [[&cantouch, &canputinto]]
;
pullVerb: Verb
	sdesc = "pull"
	verb = 'pull' 'yank' 'pull on' 'yank on' 'pull upon' 'yank upon'
	doAction = 'Pull'
	requires = [[&cantouch]]
;
readVerb: Verb
	sdesc = "read"
	verb = 'read'
	doAction = 'Read'
	requires = [[&cansee]]
;
throwVerb: Verb
	sdesc = "throw"
	verb = 'throw' 'toss'
	prepDefault = atPrep
	ioAction(atPrep) = 'Throwat'
	ioAction(toPrep) = 'Throwto'
	ioAction(throughPrep) = 'Throwthrough'
	ioAction(underPrep) = 'Throwunder'
	ioAction(behindPrep) = 'Throwbehind'
	ioAction(inPrep) = 'Putin'
	ioAction(onPrep) = 'Puton'

	dorequires = [[&cantake]]
	iorequires = [
				[&cansee]
		inPrep onPrep	[&canputinto]
	]
;
standVerb: Soloverb
	sdesc = "stand"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"stands";
	}
	verb = 'stand' 'stand up' 'get up'
	soloaction(actor) = {
		if (actor.position = 'standing')
			"\^<<actor.youre>> already standing.";
		else {
			Outhide(true);
			actor.location.verDoStand(actor);
			if (Outhide(nil))
				actor.location.verDoStand(actor);
			else
				actor.location.doStand(actor);
		}
	}
;
helloVerb: Soloverb
	sdesc = "say hello"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"says hello";
	}
	verb = 'hello' 'hi' 'greetings' 'howdy'
	soloaction(actor) = {
		if (actor = Me)
			"Talking to yourself won't help matters.";
		else
			"\^<<actor.subjthedesc>> nods.";
	}
;
showVerb: Verb
	sdesc = "show"
	verb = 'show'
	prepDefault = toPrep
	ioAction(toPrep) = 'Showto'
	dorequires = [[&cantake]]
	iorequires = [[&cansee]]
;
cleanVerb: Verb
	sdesc = "clean"
	verb =	'clean' 'polish' 'shine' 'buff' 'scrub'
		'clean up' 'polish up' 'shine up' 'buff up' 'scrub up'
	doAction = 'Clean'
	ioAction(withPrep) = 'Cleanwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
moveVerb: Verb
	sdesc = "move"
	verb = 'move'
	doAction = 'Move'
	ioAction(withPrep) = 'Movewith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
fastenVerb: Verb
	sdesc = "fasten"
	verb = 'fasten' 'buckle' 'buckle up'
	doAction = 'Fasten'
	requires = [[&cantouch]]
;
unfastenVerb: Verb
	sdesc = "unfasten"
	verb = 'unfasten' 'unbuckle'
	doAction = 'Unfasten'
	requires = [[&cantouch]]
;
unplugVerb: Verb
	verb = 'unplug'
	sdesc = "unplug"
	doAction = 'Unplug'
	ioAction(fromPrep) = 'Unplugfrom'
	dorequires = [[&cantouch]]
	iorequires = [[&cantouch]]
;
typeVerb: Verb
	sdesc = "type"
	verb = 'type'
	prepDefault = onPrep
	ioAction(onPrep) = 'Typeon'
	dorequires = [[&canusealphanum]]
	iorequires = [[&cantouch]]
;
lockVerb: Verb
	sdesc = "lock"
	verb = 'lock'
	prepDefault = withPrep
	doAction = 'Lock'
	ioAction(withPrep) = 'Lockwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
unlockVerb: Verb
	sdesc = "unlock"
	verb = 'unlock'
	prepDefault = withPrep	
	doAction = 'Unlock'
	ioAction(withPrep) = 'Unlockwith'
	dorequires = [[&cantouch]]
	iorequires = [[&cantake]]
;
detachVerb: Verb
	sdesc = "detach"
	verb = 'detach' 'disconnect'
	ioAction(fromPrep) = 'Detachfrom'
	doAction = 'Detach'
	dorequires = [[&cantouch]]
	iorequires = [[&cantouch]]
;
untieVerb: Verb
	sdesc = "untie"
	verb = 'untie' 'unlash'
	ioAction(fromPrep) = 'Untiefrom'
	doAction = 'Untie'
	dorequires = [[&cantouch]]
	iorequires = [[&cantouch]]
;
sleepVerb: Soloverb
	sdesc = "sleep"
	verb = 'sleep'
	soloaction(actor) = {
		"%You% <<self.desc(actor)>>.";
		self.sleep;
	}
;
pokeVerb: Verb
	sdesc = "poke"
	verb = 'poke' 'jab'
	doAction = 'Poke'
	ioAction(withPrep) = 'Pokewith'
	dorequires = [[&cantouch]]
	iorequres = [[&cantake]]
	dolongexplanation = nil
	iolongexplanation = nil
;
searchVerb: Verb
	sdesc = "search"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"searches";
	}
	verb = 'search'
	doAction = 'Search'
	requires = [[&cansee, &cantouch]]
;
shootVerb: Verb
	sdesc = "shoot"
	verb = 'shoot' 'blast' 'fire'
	prepDefault = withPrep
	ioAction(withPrep) = 'Shootwith'
	ioAction(atPrep) = 'Shootat'
	
	dorequires = [
			[&cansee]
		atPrep	[&cantake]
	]
	iorequires = [
			[&cantake]
		atPrep	[&cansee]
	]
;

//
// Movement direction verbs
//
moveNVerb: Verb
	sdesc = "move north"
	verb = 'move north' 'move n' 'push north' 'push n'
	doAction = 'MoveN'
;
moveSVerb: Verb
	sdesc = "move south"
	verb = 'move south' 'move s' 'push south' 'push s'
	doAction = 'MoveS'
;
moveEVerb: Verb
	sdesc = "move east"
	verb = 'move east' 'move e' 'push east' 'push e'
	doAction = 'MoveE'
;
moveWVerb: Verb
	sdesc = "move west"
	verb = 'move west' 'move w' 'push west' 'push w'
	doAction = 'MoveW'
;
moveNEVerb: Verb
	sdesc = "move northeast"
	verb = 'move northeast' 'move ne' 'push northeast' 'push ne'
	doAction = 'MoveNE'
;
moveNWVerb: Verb
	sdesc = "move northwest"
	verb = 'move northwest' 'move nw' 'push northwest' 'push nw'
	doAction = 'MoveNW'
;
moveSEVerb: Verb
	sdesc = "move southeast"
	verb = 'move southeast' 'move se' 'push southeast' 'push se'
	doAction = 'MoveSE'
;
moveSWVerb: Verb
	sdesc = "move southwest"
	verb = 'move southwest' 'move sw' 'push southwest' 'push sw'
	doAction = 'MoveSW'
;

//
// Travel verbs.
// We play some games here to make the syntax for the verify methods
// the same as it is for direct objects of other verbs.
//
// Note that the old noexit syntax is still supported, but the
// new goNowhere(actor) (no parallel ver method) is preferred.
//
class Travelverb: Soloverb
//	verprop = &verGo<Direction>	// verify method
//	doprop = &go<Direction>		// actually do it
//	oldprop = &<Direction>		// backward compat with old adv.t
	
	soloaction(actor) = {
		local	dest := nil, lose := nil;

		//
		// Basic sanity checks
		//
		if (not defined(self, &verprop)) {
			"Verb has no verprop.";
			return;
		}
		if (not defined(self, &doprop)) {
			"Verb has no doprop.";
			return;
		}
		
		//
		// Can't travel out of nowhere
		//
		if (actor.location = nil) {
			"\^<<actor.subjthedesc>> <<actor.is>> nowhere!";
			return;
		}

		//
		// Can't travel without a travelto method.
		//
		if (not defined(actor, &travelto)) {
			"\^<<actor.subjthdesc>> can't go anywhere on
			<<actor.possessivedesc>> own!";
			return;
		}
		
		//
		// First call the verify method, if there is one.
		// If it prints anything, the move is not allowed.
		//
		if (defined(actor.location, self.verprop)) {
			Outhide(true);	// suppress output of ver method
			actor.location.(self.verprop)(actor);
			if (Outhide(nil)) {	// true -> output printed
				actor.location.(self.verprop)(actor);
				return;
			}
		}

		//
		// Here we see what the travel method evaluates to.
		// Since we want to allow the programmer to say
		//
		//	goNorth = hill
		//
		// as a shorthand for
		//
		//	goNorth(actor) = { return hill; }
		//
		// we have the check the property type of the method
		// before evaluating it.
		//
		// If the travel method evaluates to non-nil, we
		// move the actor to that location.  Otherwise the
		// move is not allowed.
		//
		// If no travel method is defined, try the old-style
		// method.  (This is for backwards compatbility with
		// old TADS games.)
		//
		// NOTE: DO NOT put nil goDirection intializers in any
		// base classes!  This will prevent the old-style methods
		// from ever getting checked.
		//
		// If you need to define a goDirection method, you'll have
		// to check for the old method directly.
		//
		if (defined(actor.location, self.doprop)) {
			local	t;

			t := proptype(actor.location, self.doprop);
			if (t = 2) {
				// simple object
				dest := actor.location.(self.doprop);
			}
			else if (t = 5) {
				// nil
			}
			else if (t = 6) {
				// method
				dest := actor.location.(self.doprop)(actor);
			}
			// might want to allow list here (t = 7)
			// might want to allow a property pointer here
			// for double indirection. (t = 13)
			else {
				// something else
				"\nERROR: Travelverb can't evaluate property!";
				return;
			}
		}
		else if (self.oldprop <> nil) {
			if (defined(actor.location, self.oldprop))
				dest := actor.location.(self.oldprop);
			else 
				lose := true;
		}
		else
			lose := true;

		//
		// If we've found no method for this direction, try
		// to call the noexit method.  If no such exit exists,
		// try the goNowhere method.  If that doesn't exist
		// either, print a default "You can't go that way" message.
		//
		// Note that since noexit is sometimes used to mean
		// "all exits" we need to try its return value as
		// a possible destination.
		//
		if (lose) {
			if (defined(actor.location, &noexit))
				dest := actor.location.noexit;
			else if (defined(actor.location, &goNowhere))
				dest := actor.location.goNowhere(actor);
			else {
				"\^<<actor.subjthedesc>> can't go that way.";
				return;
			}
		}
		
		//
		// Travel to destination unless it's nil.
		//
		if (dest = nil) {
			return;
		}
		else if (datatype(dest) <> 2) {
			"\nERROR: travel method (<<self.sdesc>>) does not
			return an object or nil.";
		}
		// might want to allow other types here; e.g., lists
		else
			actor.travelto(dest);			
	}
;
northVerb: Travelverb
	sdesc = "go north"
	verb = 'north' 'go north' 'n' 'go n'
	verprop = &verGoNorth
	doprop = &goNorth
	oldprop = &north
;
southVerb: Travelverb
	sdesc = "go south"
	verb = 'south' 'go south' 's' 'go s'
	verprop = &verGoSouth
	doprop = &goSouth
	oldprop = &south
;
eastVerb: Travelverb
	sdesc = "go east"
	verb = 'east' 'go east' 'e' 'go e'
	verprop = &verGoEast
	doprop = &goEast
	oldprop = &east
;
westVerb: Travelverb
	sdesc = "go west"
	verb = 'west' 'go west' 'w' 'go w'
	verprop = &verGoWest
	doprop = &goWest
	oldprop = &west
;
neVerb: Travelverb
	sdesc = "go northeast"
	verb = 'northeast' 'go northeast' 'ne' 'go ne'
	verprop = &verGoNortheast
	doprop = &goNortheast
	oldprop = &ne
;
nwVerb: Travelverb
	sdesc = "go northwest"
	verb = 'northwest' 'go northwest' 'nw' 'go nw'
	verprop = &verGoNorthwest
	doprop = &goNorthwest
	oldprop = &nw
;
seVerb: Travelverb
	sdesc = "go southeast"
	verb = 'southeast' 'go southeast' 'se' 'go se'
	verprop = &verGoSoutheast
	doprop = &goSoutheast
	oldprop = &se
;
swVerb: Travelverb
	sdesc = "go southwest"
	verb = 'southwest' 'go southwest' 'sw' 'go sw'
	verprop = &verGoSouthwest
	doprop = &goSouthwest
	oldprop = &sw
;
upVerb: Travelverb
	sdesc = "go up"
	verb = 'up' 'go up' 'u' 'go u'
	verprop = &verGoUp
	doprop = &goUp
	oldprop = &up
;
downVerb: Travelverb
	sdesc = "go down"
	verb = 'down' 'go down' 'd' 'go d'
	verprop = &verGoDown
	doprop = &goDown
	oldprop = &down
;
inVerb: Travelverb
	sdesc = "go in"
	verb = 'in' 'go in' 'enter' 'go inside' 'go into' 'go downin'
	verprop = &verGoIn
	doprop = &goIn
	oldprop = &in
	doAction = 'Enter'
	requires = [[&cantouch]]
;
outVerb: Travelverb
	sdesc = "go out"
	verb = 'out' 'go out' 'exit' 'go outof'
	verprop = &verOut
	doprop = &goOut
	oldprop = &out
	doAction = 'Exit'
	requires = [[&cantouch]]
;
upstreamVerb: Travelverb
	sdesc = "go upstream"
	verb = 'upstream' 'go upstream' 'us' 'go us' 'ups' 'go ups'
	verprop = &verGoUpstream
	doprop = &goUpstream
	oldprop = nil
;
downstreamVerb: Travelverb
	sdesc = "go downstream"
	verb = 'downstream' 'go downstream' 'ds' 'go ds'
	verprop = &verDownstream
	doprop = &goDownstream
	oldprop = nil
;
jumpVerb: Travelverb
	sdesc = "jump"
	verb = 'jump' 'jump over' 'jump off'
	
	// Others to consider: jump out, jump in, jump behind, etc.

	verprop = &verJump
	doprop = &goJump
	oldprop = nil
;

/*
 * System verbs.
 * These can be used even when normal verbs are disabled.
 */
class Systemverb: Verb
;
quitVerb: Systemverb, Soloverb
	verb = 'quit'
	soloaction(actor) = {
		local yesno;

		score_and_rank();
		"\bDo you really want to quit? (YES or NO) > ";
		yesno := yorn();
		"\b";
		if (yesno = 1) {
			terminate();	// allow user good-bye message
			quit();
		}
		else
			"Okay. ";

		abort;
	}
;
verboseVerb: Systemverb, Soloverb
	verb = 'verbose' 'wordy'
	soloaction(actor) = {
		"Okay, now in VERBOSE mode.\n";
		global.verbose := true;
		actor.location.lookaround(actor, true);
		abort;
	}
;
terseVerb: Systemverb, Soloverb
	verb = 'brief' 'terse'
	soloaction(actor) = {
		"Okay, now in TERSE mode.\n";
		global.verbose := nil;
		abort;
	}
;
scoreVerb: Systemverb, Soloverb
	verb = 'score' 'status'
	soloaction(actor) = {
		score_and_rank();
		abort;
	}
;
saveVerb: Systemverb, Soloverb
	verb = 'save'
	sdesc = "save"
	doAction = 'Save'
	requires = [[&canusealpha]]
	soloaction(actor) = {
		savegame();
		abort;
	}
;
restoreVerb: Systemverb, Soloverb
	verb = 'restore' 'load'
	sdesc = "restore"
	doAction = 'Restore'
	requires = [[&canusealpha]]
	soloaction(actor) = {
		local savefile;
	
		savefile := askfile('File to restore game from');
		if (savefile = nil or savefile = '')
			"Failed. ";
		else if (restore(savefile))
			"Restore failed. ";
		else {
			score_statusline();
			"Restored.\b";
			actor.location.lookaround(actor, true);
		}
		abort;
	}
;
scriptVerb: Systemverb, Soloverb
	verb = 'script'
	sdesc = "script"
	doAction = 'Script'
	requires = [[&canusealpha]]
	soloaction(actor) = {
		local scriptfile;
			
		scriptfile := askfile('File to write transcript to');
		if (scriptfile = nil or scriptfile = '')
			"Failed. ";
		else {
			logging(scriptfile);

			"All text will now be saved to the script
			file.  Type UNSCRIPT at any time to discontinue
			scripting.";
		}
		abort;
	}
;
unscriptVerb: Systemverb, Soloverb
	verb = 'unscript'
	soloaction(actor) = {
		logging(nil);
		"Script closed.\n";
		abort;
	}
;
restartVerb: Systemverb, Soloverb
	verb = 'restart'
	soloaction(actor) = {
		local yesno;
		while (true) {
			"Are you sure you want to start over? (YES or NO) > ";
			yesno := yorn();
			if (yesno = 1) {
				"\n";
				init_statusline();
				score_statusline();
				restart(initrestart, global.restarting);
				abort;
			 }
			 else if (yesno = 0) {
				 "\nOkay.\n";
				 abort;
			 }
	       }
	}
;
versionVerb: Systemverb, Soloverb
	verb = 'version'
	soloaction(actor) = {
		versioninfo();
		abort;
	}
;
debugtraceVerb: Systemverb, Soloverb
	on = nil

	verb = 'debugtrace'
	soloaction(actor) = {
		if (self.on) {
			"debugTrace is now OFF.\n";

			debugTrace(1, nil);
		}
		else {
			"debugTrace is now ON.\n";

			debugTrace(1, true);
		}

		self.on := not self.on;

		abort;
	}
;
debugVerb: Systemverb, Soloverb
	verb = 'debug'
	soloaction(actor) = {
		if (debugTrace()) // TADS exports this name
			"I don't see any bugs here.";
		abort;
	}
;
undoVerb: Systemverb, Soloverb
	verb = 'undo'
	sdesc = "undo"
	soloaction(actor) = {
		self.undocommands(actor, 1);
	}
	doAction = 'Undo' // for "undo 12"
	requires = [[&canusenumber]]

	undocommands(actor, turns) = {
		local	i;

		if (turns < 1) {
			"Please specify the number of turns you
			want to undo, or just type \"undo\" to
			undo a single turn.";

			abort;
			return;
		}
		else if (turns > global.undowarning) {
			"You cannot redo turns that you undo.\nAre
			you sure you want to undo that many
			commands? (YES or NO) > ";

			if (yorn() = 0) {
				"Okay, never mind.";
				abort;
				return;
			}
		}

		//
		// We have to do an extra undo to undo the "undo"
		// command itself.
		//
		for (i := 0; i <= turns; i++) {
			if (not undo())
				break;
		}

		if (i = 2)
			"One command undone. ";
		else if (i > 2)
			"<<i-1>> commands undone. ";

		if (i <= turns)
			"There is not enough undo information to
			undo any more commands.";

		if (i > 1) {
			"\b";
			actor.location.lookaround(actor, true);
			score_statusline();
		}

		abort;
	}
;
spaceVerb: Systemverb, Soloverb
	sdesc = "space"
	verb = 'space'
	soloaction(actor) = {
		if (global.doublespace) {
			"Now single-spacing text.";
			global.doublespace := nil;
		}
		else {
			"Now double-spacing text.";
			global.doublespace := true;
		}

		abort;	/* doesn't count as a turn */
	}
;
indentVerb: Systemverb, Soloverb
	sdesc = "indent"
	verb = 'indent'
	soloaction(actor) = {
		if (global.indent) {
			"Paragraph indentation now off.";
			global.indent := nil;
		}
		else {
			"Paragraph indentation now on.";
			global.indent := true;
		}
		
		abort;	/* doesn't count as a turn */
	}
;
deterministicverb: Systemverb, Soloverb	// for regression testing
	verb = 'deterministic'
	soloaction(actor) = {
		"(Deterministic mode)\n";
		global.nondeterministic := nil;
		abort;
	}
;

/*
 * Footnoting stuff
 */
footnoteVerb: Verb
	sdesc = "get footnote information for"
	desc(obj) = {
		if (obj.isplural)
			self.sdesc;
		else
			"gets footnote information for";
	}
	verb = 'footnote' 'note'
	doAction = 'Footnote'
	requires = [[&canusenumber]]
;
printnote: function(num)
{
	local i, o, notes, len;

	notes := global.footnotelist;
	len := length(notes);
	for (i := 1; i <= len; i++) {
		o := notes[i];
		if (o.footnum = num) {
			"[\(<<num>>\)]:\ <<o.footnote>>";
			return;
		}
	}

	// No footnote found with that number.
	"No such footnote.";
}
note: function(o)
{
	if (o.footnum = nil) {
		//
		// Keep trying footnote numbers until we
		// get one that's not already used.  (This
		// is to allow footnotes with predefined numbers
		// to coexist with footnotes that get their
		// numbers assigned at run-time.)
		//
		//Note that if you change footnote numbering
		// at run-time, you will have to update the
		// footavoid list appropriately.  (The footavoid
		// list contains the list of footnote numbers that
		// should not be assigned to new footnotes.)
		//
		for (;;) {
			o.footnum := global.footnumber;
			global.footnumber++;

			if (find(global.footavoid, o.footnum) = nil)
				break;
		}
	}

	"[\(<<o.footnum>>\)]";

	return '';	/* so we can use inside << ... >> */
}

/*
 * Playtesting verbs
 *
 * Code in Verb and Soloverb guarantees that no Debugverb
 * will work at run-time.  However, the vocab for these
 * verbs will still be recognized, so be careful to avoid
 * conflicts with real verbs!
 */
class Debugverb: Verb
	allok = true
;
qVerb: Systemverb, Soloverb	// not a Debugverb; we handle the non-playtesting case below
	sdesc = "fastquit"
	verb = 'q'
	soloaction(actor) = { 
		if (global.playtesting)
			quit();
		else
			quitVerb.soloaction(actor);
	}
;
locateVerb: Debugverb, Systemverb
	sdesc = "locate"
	verb = 'locate'
	doAction = 'Locate'
;
listcontentsVerb: Soloverb, Debugverb, Systemverb
	sdesc = "list contents"
	verb = 'listcontents' 'contents' 'list'
	doAction = 'Listcontents'
	soloaction(actor) = {
		actor.location.doListcontents(actor);
	}
;
dieVerb: Debugverb, Systemverb, Soloverb
	sdesc = "commit suicide"
	verb = 'die'
	soloaction(actor) = { die(); }
;
hungryVerb: Debugverb, Systemverb, Soloverb
	sdesc = "become (un)hungry"
	verb = 'hungry'
	soloaction(actor) = {
		if (actor.turnsuntilstarvation < 40)
			actor.turnsuntilstarvation := actor.mealtime;
		else
			actor.turnsuntilstarvation := 40;
	}
;
thirstyVerb: Debugverb, Systemverb, Soloverb
	sdesc = "become (un)thirsty"
	verb = 'thirsty'
	soloaction(actor) = {
		if (actor.turnsuntildehydration < 40)
			actor.turnsuntildehydration := actor.drinktime;
		else
			actor.turnsuntildehydration := 40;
	}
;
sleepyVerb: Debugverb, Systemverb, Soloverb
	sdesc = "become (un)sleepy"
	verb = 'sleepy'
	soloaction(actor) = {
		if (actor.turnsuntilsleep < 40)
			actor.turnsuntilsleep := actor.sleeptime;
		else
			actor.turnsuntilsleep := 40;
	}
;
gimmeVerb: Debugverb, Systemverb
	sdesc = "gimme"
	verb = 'gimme'
	doAction = 'Gimme'
;
warptoVerb: Debugverb, Systemverb
	sdesc = "warpto"
	verb = 'warp to'
	doAction = 'Warpto'
	validDo(actor, obj, seqno) = {
		if (self.playtestcheck)
			return nil;
		else
			return isclass(obj, Room) ? true : nil;
	}
	validIo(actor, obj, seqno) = {
		return isclass(obj, Room) ? true : nil;
	}	
;
knowVerb: Debugverb, Systemverb
	sdesc = "know"
	verb =	'know'
	doAction = 'Know'
;
lightroomVerb: Debugverb, Systemverb, Soloverb
	sdesc = "light room"
	verb = 'lightroom'
	soloaction(actor) = {
		"Let there be light!";
		actor.location.lighten;
		"\b";
		actor.location.lookaround(actor, true);
	}
;
darkroomVerb: Debugverb, Systemverb, Soloverb
	sdesc = "dark room"
	verb = 'darkroom'
	soloaction(actor) = {
		"Let there be dark!";
		actor.location.darken;
		"\b";
		actor.location.lookaround(actor, true);
	}
;
debugreachVerb: Systemverb, Soloverb	// allowed in production version for remote debugging
	sdesc = "debug reach"
	verb = 'debugreach' 'reachdebug'
	soloaction(actor) = {
		global.debugreach := not global.debugreach;

		"Reach debugging is now ";
		say(global.debugreach ? 'ON' : 'OFF');
		".";

		abort;
	}
;
weightVerb: Debugverb, Systemverb
	sdesc = "weigh"
	verb = 'weight'	// 'weigh' would conflict with a real verb!
	doAction = 'Weight'
;
bulkVerb: Debugverb, Systemverb
	sdesc = "bulk"
	verb = 'bulk'
	doAction = 'Bulk'
;

//
// The global object.
//
global: object
	outstate = []

	// how things can be contained in their locations
	loctypes = ['in' 'on' 'under' 'behind']
	// opposites of these, for descriptions of actions
	locopposites = ['out of' 'off of' 'out from under' 'out from behind']
	loccont = [
		// order must match loctypes
		&incontentslisted,
		&oncontentslisted,
		&undercontentslisted,
		&behindcontentslisted
	]
	locconthear = [
		// order must match loctypes
		&incontentslistedsound,
		&oncontentslistedsound,
		&undercontentslistedsound,
		&behindcontentslistedsound
	]
	loccontsmell = [
		// order must match loctypes
		&incontentslistedsmell,
		&oncontentslistedsmell,
		&undercontentslistedsmell,
		&behindcontentslistedsmell
	]
	locconttouch = [
		// order must match loctypes
		&incontentslistedtouch,
		&oncontentslistedtouch,
		&undercontentslistedtouch,
		&behindcontentslistedtouch
	]
	locmaxweight = [
		// order must match loctypes
		&inmaxweight,
		&onmaxweight,
		&undermaxweight,	// of dubious value
		&behindmaxweight	// ditto
	]
	locmaxbulk = [
		// order must match loctypes
		&inmaxbulk,
		&onmaxbulk,
		&undermaxbulk,
		&behindmaxbulk
	]
	loctake = ['in' 'on']		// only get things on and in a Thing
					// when you take it

	turns = 0			// no turns have elapsed yet
	lastsave = -999			// turn when player last saved
	turnspertick = 1		// how much to add to turns each time
	ticks = 0			// like turns, but used by WorldClass
	score = 0			// no points have been amassed yet
	maxscore = 100			// this many points possible
	undowarning = 10		// warn about undoing more than
					// this many turns
	statuslinewidth = 74		// maximum status line width

	//
	// We use the following occassionally to avoid passing parameters.
	// (For example, we don't want ldesc to get an actor parameter,
	// but sometimes we need to know who's doing the looking.)
	//
	lastactor = nil
	lastprep = nil
	lastpreptime = -999		// lastprep time stamp (so we know
					// if it's stale)
	lastio = nil
	lastdo = nil
	lastverb = nil			// hack for cantReach
	canoutput = nil			// hack for cantReach
	listed = []			// used by listcontentsX
	debugreach = nil		// print debugging text in blocksreach?

	// failedsense and senses are used by checkReq and invalidobject
	// in Verb
	failedsense = nil
	senses = [
		  &cantake 'take',
		  &cansee 'see',
		  &canhear 'hear',
		  &cansmell 'smell',
		  &cantouch 'reach'
	]


	restarting = nil		// starting fresh?
	
	footnumber = 1			// start numbering footnotes at 1
	footnotelist = []
	footavoid = []			// set by preinit (see note function)

	actorlist = []
	lightsources = []

	listablesmelllist = []
	listablesoundlist = []
	listabletouchlist = []

	manysounds = nil
	manysmells = nil
	manytouches = nil

	silentincscore = nil		// should incscore announce score changes?

	indent = true			// indent paragraphs by default
	paragraphspacing = true		// blank between paragraphs by default

	playtesting = true		// allow playtesting commands
	playtestfailtime = -999		// initial value must not be a valid ticks value

	searchisexamine = true		// "search ___" = "examine ___"?

	nondeterministic = true		// be random for real

	// called by init:
	randomise = {
		if (global.nondeterministic)
			randomize();
	}
;

//
// Info about this library
//
classlibrary: object
	majorversion = 1
	minorversion = 3
	patchlevel = 3
	info = { self.sdesc; }	// synonym
	sdesc = {
		"WorldClass library version <<self.versiondesc>>.";
	}
	versiondesc = {
		say(self.majorversion);
		".";
		say(self.minorversion);
		".";
		say(self.patchlevel);
	}
;
