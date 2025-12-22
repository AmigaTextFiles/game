/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * machines.m - code to add two simple machines to the world.
 *	NOTE: rooms referenced directly:
 *		r_mallEntrance - 3 times for the entry-exit recorder
 *		r_crossSW - starting point for Caretaker
 *		r_pearField - used in packratStep to force pear picking
 *		r_es2 - starting point for Packrat
 *	We also reference directly: p_oPlayAction, p_oEraseAction
 *	We also require DoGet and DoDrop from verbs.m
 */

use t_streets

private tp_machines CreateTable().
use tp_machines

/*****************************************************************************\
*									      *
*   NOTE: This entry-exit recorder should be commented out if the MUD is      *
*	running on a floppy disk. Since it continually modifies its record    *
*	when the automatic machines go by, it is continually creating	      *
*	database entries that must be written out, hence there will be	      *
*	continual disk I/O even if no-one is playing. A big database cache    *
*	can minimize this effect, but will not stop it completely.	      *
*									      *
\*****************************************************************************/

/* first, stuff in the entry-exit recorder (not a true machine) */

define tp_machines o_recorder CreateThing(nil).
SetThingStatus(o_recorder, ts_readonly).
SetupObject(o_recorder, r_mallEntrance,
    "machine,player,recorder;enter-exit.machine,player,recorder;enter,exit,"
	"enter-exit.exit;enter",
    "This is a very strange machine. It's purpose, as indicated by a small "
    "instruction label, is to record the comings and goings of people. "
    "It will respond to 'play' and 'erase' to play its current record "
    "and to erase it, respectively.").
define tp_machines p_recorderRecord CreateStringProp().
o_recorder@p_recorderRecord := "".
o_recorder@p_Image := "Town/recorder".

/*
 * recorderEnter - the recorder's player enter action.
 */

define tp_machines proc recorderEnter()status:
    string s;

    s := o_recorder@p_recorderRecord;
    if Length(s) >= 3500 then
	/* we are obviously pretty busy, and getting close to the current
	   arbitrary string maximum of 4K, so just nuke the record. */
	s := "";
    else
	s := s + "    " + Capitalize(CharacterNameG(Me())) + " arrived.\n";
    fi;
    o_recorder@p_recorderRecord := s;
    continue
corp;

/*
 * recorderLeave - the recorder's player leave action.
 */

define tp_machines proc recorderLeave()status:
    string s;

    s := o_recorder@p_recorderRecord;
    if Length(s) >= 3500 then
	 s := "";
    else
	s := s + "    " + Capitalize(CharacterNameG(Me())) + " left.\n";
    fi;
    o_recorder@p_recorderRecord := s;
    continue
corp;

/* prevent players from picking up the recorder */

define tp_machines proc recorderGet(thing th)status:
    Print("Sorry, but the machine is bolted to the floor!\n");
    if not Me()@p_pHidden then
	OPrint(Capitalize(CharacterNameG(Me())) +
	       " tries to pick up the enter-exit machine.\n");
    fi;
    fail
corp;

/* play/erase functions */

define tp_machines proc recorderPlay()status:
    string s;

    s := o_recorder@p_recorderRecord;
    if s = "" then
	Print("The machine's record is empty.\n");
    else
	Print("The machine's record contains:\n" + s);
    fi;
    if not Me()@p_pHidden then
	OPrint(Capitalize(CharacterNameG(Me())) +
	    " fiddles with the machine.\n");
    fi;
    succeed
corp;

/* recorderErase is in tp_misc since it is needed by the Postman */
define tp_misc proc recorderErase()status:
    string s;

    s := Capitalize(CharacterNameG(Me()));
    o_recorder@p_recorderRecord := "    " + s + " erased this record.\n";
    Print("OK, the machine's record is erased.\n");
    if not Me()@p_pHidden then
	OPrint(s + " fiddles with the machine.\n");
    fi;
    succeed
corp;

/* attach the functions to the room the recorder is in */

AddAnyEnterChecker(r_mallEntrance, recorderEnter, false).
AddAnyLeaveChecker(r_mallEntrance, recorderLeave, false).

/* and to the recorder itself */

o_recorder@p_oGetChecker := recorderGet.
o_recorder@p_oPlayChecker := recorderPlay.
o_recorder@p_oEraseChecker := recorderErase.

/* Exercise for the reader: remove the limitation of the recorder not
   being portable. Do it without leaving a lot of properties hanging around
   that aren't being used. */



/* Now the true machines */


define tp_machines p_mLastDir CreateIntProp().
define tp_machines p_mWantDelay CreateBoolProp().
define tp_machines p_mArrived CreateBoolProp().
define tp_machines p_mCommand CreateStringProp().
define tp_machines p_mWho CreateStringProp().
define tp_machines p_mStepCount CreateIntProp().
define tp_machines MAX_STEPS 100.


/* First, Caretaker */

define tp_machines Caretaker CreateThing(nil).

/* caretakerGreet - let the caretaker greet everyone in a room he enters. */

define tp_machines proc caretakerGreet(thing who)void:
    string name;

    name := who@p_pName;
    if name ~= "Caretaker" then
	DoSay("Good day " + name + "!");
    fi;
corp;

/* caretakerStep - the central action routine for the caretaker */

define tp_machines proc caretakerStep()void:
    thing here, me, object, home;
    list thing lt;
    int dir, firstNum, count, n;
    bool found, lost;

    me := Me();
    if not ClientsActive() then
	/* no clients (humans) are playing - do little */
	count := me@p_mStepCount + 1;
	if count = MAX_STEPS then
	    SetLocation(r_crossSW);
	    me@p_mStepCount := 0;
	else
	    me@p_mStepCount := count;
	fi;
	After(60, caretakerStep);
    else
	me@p_mStepCount := 0;
	if me@p_mArrived then
	    /* this phase - greet everyone */
	    me@p_mArrived := false;
	    ForEachAgent(Here(), caretakerGreet);
	    After(20, caretakerStep);
	else
	    /* this phase - move */
	    me@p_mArrived := true;
	    firstNum := me@p_mLastDir;
	    if Random(3) ~= 0 then
		dir := firstNum;
	    else
		firstNum := DirBack(firstNum);
		while
		    dir := Random(12);
		    dir = firstNum
		do
		od;
		firstNum := dir;
	    fi;
	    found := false;
	    lost := false;
	    while not found do
		if TryToMove(dir) then
		    found := true;
		else
		    dir := (dir + 1) % 12;
		    if dir = firstNum then
			lost := true;
			found := true;
		    fi;
		fi;
	    od;
	    if lost then
		Log("Caretaker stuck, " + Here()@p_rName + "\n");
		Say("", "I'm stuck! Heeeeelp!!");
		SetLocation(r_crossSW);
		After(60, caretakerStep);
	    else
		me@p_mLastDir := dir;
		MachineMove(dir);
		here := Here();

		/* Go through the objects in the room we just entered. Pick
		   each normal object up. If the object is not where it
		   "belongs", then keep it, otherwise drop it right away. */
		lt := here@p_rContents;
		count := Count(lt);
		n := 0;
		while n < count do
		    object := lt[n];
		    if not object@p_oInvisible and not object@p_oNotGettable
		    then
			/* DoGet removes an object from the list */
			count := count - 1;
			if DoGet(here, me, object) ~= continue then
			    /* something happened - abort out */
			    n := count;
			else
			    home := object@p_oHome;
			    if home = here or home = nil then
				/* object belongs here - drop it right away */
				if DoDrop(here, me, object) ~= continue then
				    /* something happened - abort out */
				    n := count;
				fi;
				/* otherwise, object is put on the end of the
				   contents list, and we do not need to look at
				   it again. */
			    fi;
			    /* otherwise, he just keeps it for now */
			fi;
		    else
			n := n + 1;
		    fi;
		od;

		/* Go through the list of stuff he is carrying. If anything
		   in that list "belongs" here, then drop it. */
		lt := me@p_pCarrying;
		count := Count(lt);
		n := 0;
		while n < count do
		    object := lt[n];
		    if object@p_oHome = here then
			count := count - 1;
			if DoDrop(here, me, object) ~= continue then
			    n := count;
			fi;
		    else
			n := n + 1;
		    fi;
		od;

		After(20, caretakerStep);
	    fi;
	fi;
    fi;
corp;

/* have the caretaker do the command we want him to do */

define tp_machines proc caretakerCommand()void:
    thing me;
    string command;

    me := Me();
    command := me@p_mCommand;
    me -- p_mCommand;
    ignore Parse(G, command);
corp;

/* the caretaker's "understanding" of things told to him */

define tp_machines proc caretakerTold()void:
    thing me;
    string w, np;

    me := Me();
    w := GetTail();
    SetTail(w);
    w := GetWord();
    if w == "drop" or w == "put" or w == "p" then
	/* someone is telling the caretaker to drop something */
	w := GetTail();
	np := GetNounPhrase(G, w, 0);
	if np = "" or FindName(me@p_pCarrying, p_oName, np) ~= succeed then
	    /* he is not carrying something matching what they want him to
	       drop */
	    if MatchName("flashlight.light;flash", np) >= 0 then
		/* there really isn't any such thing */
		DoSay("No way! It's mine!");
	    else
		OPrint("Caretaker shakes his head in confusion.\n");
	    fi;
	else
	    /* He is carrying something that matches. Say 'Certainly' and
	       try to drop it after 1 second. */
	    DoSay("Certainly.");
	    me@p_mCommand := "drop " + w;
	    After(1, caretakerCommand);
	fi;
    elif w == "work" or w == "clean" or w == "sweep" then
	DoSay("I will, if you'll let me get back to my work!");
    else
	/* Dropping things is the only thing he will do */
	DoSay("Sorry, I've got my work to see to.");
    fi;
corp;

define tp_machines proc caretakerHear(string what)void:
    string word;

    word := SetSay(what);
    if word ~= "" and word ~= "Packrat" and word ~= "Caretaker" then
	/* ignore things said by the packrat or by himself */
	word := GetWord();
	if word == "Caretaker" or word == "Caretaker," or word == "Caretaker:"
	then
	    /* only act if the speech started with his name */
	    caretakerTold();
	elif word == "hello" or word == "hi" then
	    /* minimal conversationalist! */
	    OPrint("Caretaker grunts an acknowledgement.\n");
	fi;
    fi;
corp;

/* called by the system when someone whispers to him */

define tp_machines proc caretakerWhispered(string what)void:

    if SetWhisperMe(what) ~= "" then
	caretakerTold();
    fi;
corp;

/* called as the first step of someone giving something to him */

define tp_machines proc caretakerPre()status:

    SPrint(TrueMe(), "Caretaker accepts the gift.\n");
    continue
corp;

/* used for several other possible actions */

define tp_machines proc caretakerNoNo()status:

    DoSay("Watch it!");
    fail
corp;

define tp_machines proc caretakerCreate()void:

    Caretaker@p_pStandard := true;
    Caretaker@p_mLastDir := D_SOUTH;
    Caretaker@p_mArrived := true;
    Caretaker@p_mStepCount := 0;
    SetupMachine(Caretaker);
    Caretaker@p_pDesc :=
"The caretaker is a simple soul. He wears faded overalls, a green check "
"shirt, heavy work boots and a grimy cap, on backwards. His goal in life is "
"to put things back where they belong. One of his most prized possessions is "
"a small handheld flashlight, which he keeps securely hidden in an inside "
"pocket until he needs it.";
    Caretaker@p_oLight := true;
    CreateMachine("Caretaker", Caretaker, r_crossSW, caretakerStep);
    ignore SetMachineActive(Caretaker, caretakerStep);
    ignore SetMachineSay(Caretaker, caretakerHear);
    ignore SetMachineWhisperMe(Caretaker, caretakerWhispered);
    GNewIcon(Caretaker, makeCaretakerIcon());
    Caretaker@p_pGivePre := caretakerPre;
    Caretaker@p_oTouchChecker := caretakerNoNo;
    Caretaker@p_oSmellChecker := caretakerNoNo;
    Caretaker@p_oPushChecker := caretakerNoNo;
    Caretaker@p_oPullChecker := caretakerNoNo;
    Caretaker@p_oTurnChecker := caretakerNoNo;
    Caretaker@p_oLiftChecker := caretakerNoNo;
    Caretaker@p_oLowerChecker := caretakerNoNo;
    Caretaker@p_oEatChecker := caretakerNoNo;
    Caretaker@p_Image := "Characters/Caretaker";
corp;
caretakerCreate().
ignore DeleteSymbol(tp_machines, "caretakerCreate").


/* Now Packrat */

define tp_machines Packrat CreateThing(nil).

/* packratStep - the central action routine for the packrat */

define tp_machines proc packratStep()void:
    thing here, me, object;
    list thing lt;
    int dir, firstNum, n;
    bool found, lost;

    me := Me();
    if not ClientsActive() then
	n := me@p_mStepCount + 1;
	if n = MAX_STEPS then
	    me@p_mStepCount := 0;
	    SetLocation(r_es2);
	else
	    me@p_mStepCount := n;
	fi;
	After(60, packratStep);
    else
	if me@p_mWantDelay then
	    me@p_mWantDelay := false;
	    After(10 + Random(20), packratStep);
	    me@p_mArrived := true;
	elif me@p_pPosition ~= 0 then
	    ignore Parse(G, "stand up");
	    After(10 + Random(20), packratStep);
	elif me@p_mArrived then
	    me@p_mArrived := false;
	    if Here() = r_pearField then
		if FindName(me@p_pCarrying, p_oName, "pear") ~= fail then
		    ignore Parse(G, "eat pear");
		else
		    ignore Parse(G, "pick pear");
		    me@p_mArrived := true;
		fi;
	    fi;
	    After(10 + Random(20), packratStep);
	else
	    me@p_mArrived := true;
	    firstNum := me@p_mLastDir;
	    if Random(2) ~= 0 then
		dir := firstNum;
	    else
		firstNum := DirBack(firstNum);
		while
		    dir := Random(12);
		    dir = firstNum
		do
		od;
		firstNum := dir;
	    fi;
	    found := false;
	    lost := false;
	    while not found do
		if TryToMove(dir) then
		    found := true;
		else
		    dir := (dir + 1) % 12;
		    if dir = firstNum then
			lost := true;
			found := true;
		    fi;
		fi;
	    od;
	    if lost then
		Log("Packrat is stuck, " + Here()@p_rName + "\n");
		Say("", "I'm stuck! Waaaahhhh!!");
		SetLocation(r_es2);
		After(60, packratStep);
	    else
		me@p_mLastDir := dir;
		MachineMove(dir);
		here := Here();
		lt := here@p_rContents;
		n := Count(lt);
		if n ~= 0 then
		    object := lt[Random(n)];
		    if not object@p_oInvisible and not object@p_oNotGettable
		    then
			if DoGet(here, me, object) = continue then
			    lt := me@p_pCarrying;
			    n := Count(lt);
			    if n = 4 then
				ignore DoDrop(here, me, lt[Random(3)]);
			    fi;
			fi;
		    fi;
		else
		    lt := me@p_pCarrying;
		    n := Count(lt);
		    if n ~= 0 and Random(20) = 0 then
			ignore DoDrop(here, me, lt[Random(n)]);
		    fi;
		fi;
		After(10 + Random(20), packratStep);
	    fi;
	fi;
    fi;
corp;

/*
 * This kind of delay is a wise thing to do, since it avoids many possible
 *	cases of recursion that could be troublesome. Consider the possibility
 *	of multiple packrat's in one room, and someone waves...
 */

define tp_machines proc packratCommand()void:
    thing me;
    string command, who;

    me := Me();
    who := me@p_mWho;
    if who ~= "" then
	SetMeString(who);
	me -- p_mWho;
    fi;
    command := me@p_mCommand;
    me -- p_mCommand;
    SetTail(command);
    if GetWord() == "pose" then
	Pose("", GetTail());
    else
	if Parse(G, command) = 0 then
	    DoSay("Sorry luv, you've confused me.");
	fi;
    fi;
corp;

define tp_machines proc packratTold()void:
    thing me;
    string command;
    int direction;

    me := Me();
    /* need to save the tail, since doing 'DoSay' can change it! */
    command := GetTail();
    me@p_mWantDelay := true;
    DoSay("Right you are luv.");
    direction := DirMatch(command);
    if direction ~= -1 then
	me@p_mLastDir := direction;
    fi;
    me@p_mCommand := command;
    After(1, packratCommand);
corp;

define tp_machines proc packratHear(string what)void:
    string word;

    word := SetSay(what);
    if word ~= "" and word ~= "Packrat" and word ~= "Caretaker" then
	Me()@p_mWho := word;
	word := GetWord();
	if word == "Packrat" or word == "Packrat," or word == "Packrat:" then
	    packratTold();
	elif word == "hello" or word == "hi" or word == "greetings" then
	    DoSay(word + " to you too, luv!");
	elif word == "good" or word == "nice" then
	    word := GetWord();
	    DoSay("You have a good'n too luv!");
	fi;
    fi;
corp;

define tp_machines proc packratWhispered(string what)void:
    string who;

    who := SetWhisperMe(what);
    if who ~= "" then
	Me()@p_mWho := who;
	packratTold();
    fi;
corp;

define tp_machines proc packratOverhear(string what)void:
    string who, target;

    who := SetWhisperOther(what);
    if who ~= "" then
	target := GetWord();
	if target ~= "" then
	    what := GetTail();
	    if what ~= "" then
		DoSay("Luv, if you want " + target + " to " + what +
		    ", you'd better speak up!");
	    fi;
	fi;
    fi;
corp;

define tp_machines proc packratSaw(string what)void:

    SetTail(what);
    ignore GetWord();
    what := GetTail();
    Me()@p_mCommand := "pose " + what;
    After(1, packratCommand);
corp;

define tp_machines proc packratNoNo()status:

    DoSay("'ere now - don't get fresh w' me!");
    fail
corp;

/* This is needed so that Packrat can thank you AFTER you have seen the
   message about giving. */

define tp_machines proc packratThank()void:

    DoSay("ta, luv!");
corp;

define tp_machines proc packratPost()status:

    After(1, packratThank);
    continue
corp;

define tp_machines proc packratCreate()void:

    Packrat@p_pStandard := true;
    Packrat@p_mLastDir := D_SOUTH;
    Packrat@p_mArrived := false;
    Packrat@p_mStepCount := 0;
    SetupMachine(Packrat);
    Packrat@p_pDesc :=
"The packrat is a small woman with a wizened face, stringy brown hair, and "
"beady little eyes. She is wearing a very old blue dress and an indeterminate "
"number of sweaters. A battered felt hat with a drab daisy perches "
"precariously on her head.";
    CreateMachine("Packrat", Packrat, r_es2, packratStep);
    ignore SetMachineActive(Packrat, packratStep);
    ignore SetMachineSay(Packrat, packratHear);
    ignore SetMachineWhisperMe(Packrat, packratWhispered);
    ignore SetMachineWhisperOther(Packrat, packratOverhear);
    ignore SetMachinePose(Packrat, packratSaw);
    GNewIcon(Packrat, makePackratIcon());
    Packrat@p_pGivePost := packratPost;
    Packrat@p_oTouchChecker := packratNoNo;
    Packrat@p_oSmellChecker := packratNoNo;
    Packrat@p_oPushChecker := packratNoNo;
    Packrat@p_oPullChecker := packratNoNo;
    Packrat@p_oTurnChecker := packratNoNo;
    Packrat@p_oLiftChecker := packratNoNo;
    Packrat@p_oLowerChecker := packratNoNo;
    Packrat@p_oEatChecker := packratNoNo;
    Packrat@p_Image := "Characters/Packrat";
corp;
packratCreate().
ignore DeleteSymbol(tp_machines, "packratCreate").

unuse tp_machines
unuse t_streets
