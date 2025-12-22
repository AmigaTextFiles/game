/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * mail.m - code to handle the mail system and the postman.
 *	NOTE: rooms referenced directly:
 *		r_mailRoom - several things
 *		r_garbageRoom - home for letters
 *		r_neEnd, r_esEnd, r_swEnd, r_wnEnd - mailboxes
 *		r_mallEntrance - so Postman erases the recorder
 *	NOTE: other direct references: recorderErase, o_recorder,
 *		p_oReadString, p_rRegisterAction (both in verbs.m)
 *	NOTE: because the mailroom is actually setup here, this file needs
 *		to be sourced by the same player who owns the mailroom, or
 *		the mailroom needs to be public. Normally, this file is
 *		sourced by SysAdmin.
 *	NOTE: we assume that all mailboxes are in lighted rooms, and that
 *		the mailroom is lighted.
 *	NOTE: MAX_CARRY is ignored for letters. This includes writing them,
 *		the initial REGISTER and picking up new mail.
 */

/*****************************************************************************\
*									      *
*	This stuff here sets up the mail facility			      *
*									      *
\*****************************************************************************/

use t_streets

private tp_mail CreateTable().
use tp_mail

define tp_mail MAX_BULLETINS 20.

define tp_mail p_pMailRegistered CreateBoolProp().
define tp_mail p_pLetterTarget CreateThingProp().   /* also put on letters */
define tp_mail p_oLetterSender CreateThingProp().   /* so can change name */
define tp_mail p_oLettersHere CreateThingListProp()./* on boxes & mailRoom */
define tp_mail p_oPostManRoute CreateStringProp().  /* codes for moves */
define tp_mail p_oPostManIndex CreateIntProp().     /* index into the string */
define tp_mail p_oPostManClearing CreateBoolProp(). /* used to idle him */
define tp_mail p_oPostManCleared CreateBoolProp().  /* ditto */
define tp_mail p_rNewLetter CreateBoolProp().	    /* flag mailroom for new */
define tp_mail p_oPostManDelay CreateIntProp().     /* delay before move */
define tp_mail p_oBulletinDate CreateStringProp().
define tp_mail p_oBulletinNumber CreateIntProp().

define tp_mail o_letter CreateThing(nil).
o_letter@p_oHome := r_garbageRoom.

define tp_mail o_bulletin CreateThing(nil).
o_bulletin@p_oHome := r_garbageRoom.

r_mailRoom@p_oLettersHere := CreateThingList().
r_mailRoom@p_rNewLetter := false.

define tp_mail proc mailboxGet(thing th)status:

    Print("The mailbox is firmly bolted down.\n");
    OPrint(Me()@p_pName + " tries to rip up the mailbox.\n");
    fail
corp;

define tp_mail o_mailbox CreateThing(nil).
SetThingStatus(o_mailbox, ts_readonly).
o_mailbox@p_oName := "mailbox;official.box;mail,official".
o_mailbox@p_oDesc :=
	"The mailbox is bright red, with a slot in the top used for posting "
	"letters. It is locked up tight - only an official representative "
	"of the postal service can get things out of it.".
o_mailbox@p_oGetChecker := mailboxGet.

define tp_mail proc boardGet(thing th)status:

    Print("The bulletin board is firmly attached.\n");
    OPrint(Me()@p_pName + " tries to rip off the bulletin board.\n");
    fail
corp;

define tp_mail proc boardRead()void:
    thing board, bulletin;
    list thing lt;
    string what, what2;
    int count, i, n;

    board := It();
    lt := board@p_oContents;
    count := Count(lt);
    what := GetWord();
    what2 := GetWord();
    if what = "" or what == "bulletins" or what == "contents" or
	what == "notices" or what == "board" or
	what == "bulletin" and what2 == "board"
    then
	if count = 0 then
	    Print("There are no bulletins posted yet.\n");
	else
	    Print("Current bulletins (number, date posted, author):\n");
	    for i from 0 upto count - 1 do
		bulletin := lt[i];
		Print("  " + IntToString(bulletin@p_oBulletinNumber) + "  " +
		    bulletin@p_oBulletinDate + "  " +
		    bulletin@p_oCreator@p_pName + "\n");
	    od;
	fi;
    else
	if what == "bulletin" or what == "notice" then
	    what := what2;
	fi;
	if SubString(what, 0, 1) = "#" then
	    what := SubString(what, 1, Length(what) - 1);
	fi;
	if what = "" then
	    Print("You must say which bulletin you want to read.\n");
	else
	    n := StringToPosInt(what);
	    if n < 0 then
		Print("\"" + what + "\" is not a valid bulletin number.\n");
	    else
		i := 0;
		while i < count and lt[i]@p_oBulletinNumber ~= n do
		    i := i + 1;
		od;
		if i = count then
		    Print("There is no bulletin " + what + " on the board.\n");
		else
		    Print(lt[i]@p_oReadString + "\n");
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_mail proc actualPostBulletin(thing bulletin, board)void:
    thing me, oldNote;
    list thing lt;
    int n;

    me := Me();
    lt := board@p_oContents;
    bulletin@p_oBulletinDate := Date();
    n := board@p_oBulletinNumber;
    board@p_oBulletinNumber := n + 1;
    bulletin@p_oBulletinNumber := n;
    bulletin@p_oName := IntToString(n) + ";bulletin";
    if Count(lt) >= 20 then
	oldNote := lt[0];
	ClearThing(oldNote);
	DelElement(lt, oldNote);
    fi;
    AddTail(lt, bulletin);
    bulletin -- p_oCarryer;
    bulletin@p_oWhere := board;
    bulletin@p_oInvisible := true;
    DelElement(me@p_pCarrying, bulletin);
    Print("Bulletin posted.\n");
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " posts a bulletin.\n");
    else
	OPrint("A new bulletin has been posted.\n");
    fi;
corp;

define tp_mail proc boardPutIn(thing bulletin, board)status:

    if Parent(bulletin) = o_bulletin then
	actualPostBulletin(bulletin, board);
	succeed
    else
	Print("You can't post that on the bulletin board.\n");
	fail
    fi
corp;

define tp_mail proc boardTakeFrom(thing bulletin, board)status:
    thing me;

    me := Me();
    if bulletin@p_oCreator = me or MeCharacter() = SysAdmin then
	AddTail(me@p_pCarrying, bulletin);
	DelElement(board@p_oContents, bulletin);
	bulletin -- p_oWhere;
	bulletin@p_oCarryer := me;
	Print("You take " + FormatName(bulletin@p_oName) +
	    " from the bulletin board.\n");
	if not me@p_pHidden then
	OPrint(me@p_pName +
	    " takes a bulletin from the bulletin board.\n");
	else
	    OPrint("A bulletin has been removed from the bulletin board.\n");
	fi;
	bulletin@p_oName := "bulletin";
	bulletin -- p_oInvisible;
	succeed
    else
	Print("That's not your bulletin.\n");
	fail
    fi
corp;

define tp_mail o_bulletinBoard CreateThing(nil).
SetThingStatus(o_bulletinBoard, ts_readonly).
o_bulletinBoard@p_oName := "board;bulletin".
o_bulletinBoard@p_oDesc :=
    "The bulletin board is a framed corkboard which is used for the posting "
    "of public notices. Anyone can post on it, and anyone can read what is "
    "posted on it. Use 'read notices' to see what notices exist. Use "
    "'read N', where N is the number of a bulletin, to read that bulletin. "
    "Use 'take bulletin N from board' to take a bulletin from the board.".
o_bulletinBoard@p_oGetChecker := boardGet.
o_bulletinBoard@p_oActWord := "read".
o_bulletinBoard@p_oActAction := boardRead.
o_bulletinBoard@p_oPutInMeChecker := boardPutIn.
o_bulletinBoard@p_oTakeFromMeChecker := boardTakeFrom.

define tp_mail o_postalService CreateThing(nil).
o_postalService@p_pName := "the postal service".

define tp_mail proc mailRoomRegister()bool:
    thing me, th;
    string name;
    list thing lt;

    me := Me();
    name := FormatName(me@p_pName);
    if me@p_pMailRegistered then
	Print("Only one registration per customer, sir!\n");
	if not me@p_pHidden then
	    OPrint(name + " walks up to the counter, but is turned away.\n");
	fi;
	false
    else
	lt := me@p_pCarrying;
	th := CreateThing(o_letter);
	SetThingStatus(th, ts_public);
	GiveThing(th, SysAdmin);
	AddTail(lt, th);
	th@p_oName := "service;letter,from,the,postal.letter";
	th@p_oHome := r_garbageRoom;
	th@p_oReadString := "Date: " + Date() +
"\nFrom: the postal service\n\n    Welcome to the mail system. You can use "
"any of the mailboxes scattered around to mail letters to people, but you "
"must go to the mail room to pick up new letters from others to you.\n";
	th@p_pLetterTarget := me;
	th@p_oLetterSender := o_postalService;
	th@p_oCarryer := me;
	th@p_oCreator := me;
	me@p_pMailRegistered := true;
	Print(
"You walk up to the counter to register. A clerk comes up to the wicket and "
"helps you fill out all of the forms in triplicate. He then gives you a "
"letter, says goodbye, and leaves.\n");
	if not me@p_pHidden then
	    OPrint(name +
		" walks up to the counter and is given something.\n");
	else
	    OPrint("The clerk at the counter hads something to thin air.\n");
	fi;
	true
    fi
corp;
r_mailRoom@p_rRegisterAction := mailRoomRegister.

define tp_mail r_postmanHidden CreateThing(nil).

define tp_mail proc postmanStep()void:
    list thing ltMan, ltHere;
    thing here, me, mailbox, letter;
    string route;
    int index, count;
    status st;
    bool idling;

    me := Me();
    here := Here();
    idling := false;
    if ClientsActive() then
	/* someone is playing */
	me@p_oPostManClearing := false;
	me@p_oPostManCleared := false;
    else
	/* no active players, and we have collected all mail - go idle */
	if me@p_oPostManCleared then
	    idling := true;
	fi;
    fi;
    if idling then
	After(60, postmanStep);
    elif here = r_postmanHidden then
	SetLocation(r_mailRoom);
	OPrint("Postman comes out from the private areas of the mailroom.\n");
	me@p_oPostManRoute := "";
	me@p_oPostManIndex := 0;
	if r_mailRoom@p_rNewLetter then
	    /* make sure we deliver that last letter */
	    r_mailRoom@p_rNewLetter := false;
	    me@p_oPostManClearing := false;
	    me@p_oPostManCleared := false;
	fi;
	SetLocation(r_mailRoom);
	ForEachAgent(r_mailRoom, ShowIconOnce);
	After(20, postmanStep);
    else
	route := me@p_oPostManRoute;
	index := me@p_oPostManIndex;
	if index = Length(route) then
	    st := FindName(here@p_rContents, p_oName, "mailbox");
	    if st = fail then
		Say("", "AAAAAARRRRRRGGGGGHHHHH! I'm lost!!!!");
		Log("Postman is lost! Route = '" + route + "', index = " +
		    IntToString(index) + ", " + here@p_rName + "\n");
	    else
		/* collect the mail from this mailbox, and get new route */
		mailbox := FindResult();
		ltHere := mailbox@p_oLettersHere;
		if ltHere = nil then
		    Say("", "AAAAARRRRGGGGGHHHH! Fake mailbox!");
		else
		    ltMan := me@p_oLettersHere;
		    count := Count(ltHere);
		    if count = 0 then
			OPrint("Postman looks, but there is no mail in the "
				"mailbox.\n");
		    else
			OPrint(
			    "Postman collects the mail from the mailbox.\n");
		    fi;
		    while count ~= 0 do
			count := count - 1;
			letter := ltHere[count];
			AddTail(ltMan, letter);
			DelElement(ltHere, letter);
		    od;
		    if here = r_mailRoom and route ~= "" then
			/* deliver the mail (plunk it down right here) */
			ltMan := me@p_oLettersHere;
			ltHere := here@p_oLettersHere;
			count := Count(ltMan);
			while count ~= 0 do
			    count := count - 1;
			    letter := ltMan[count];
			    AddTail(ltHere, letter);
			    DelElement(ltMan, letter);
			od;
			OPrint("Postman disappears into the private "
				"areas of the mailroom.\n");
			ForEachAgent(r_mailRoom, UnShowIconOnce);
			SetLocation(r_postmanHidden);
			/* a two-step process to make sure that he has
			   collected and delivered all mail before he goes
			   idle */
			if me@p_oPostManClearing then
			    me@p_oPostManCleared := true;
			else
			    me@p_oPostManClearing := true;
			fi;
			After(300, postmanStep);
		    else
			me@p_oPostManRoute := mailbox@p_oPostManRoute;
			me@p_oPostManIndex := 0;
			After(20, postmanStep);
		    fi;
		fi;
	    fi;
	else
	    ignore Parse(G, SubString(route, index, 1));
	    index := index + 1;
	    me@p_oPostManIndex := index;
	    /* Here() is AFTER the call to Parse! */
	    if Here() = r_mallEntrance then
		ignore recorderErase();
	    fi;
	    After(20, postmanStep);
	fi;
    fi;
corp;

define tp_mail proc postmanDesc()string:

"The postman, dressed in official postal service blue and carrying the "
"standard satchel for letters, is not actually delivering mail. Rather, he is "
"picking mail up at the various mailboxes and taking it in for delivery. " +
    if Count(It()@p_oLettersHere) = 0 then
	"The postman's satchel appears to be empty."
    else
	"The postman's satchel appears to contain some letters."
    fi
corp;

define tp_mail proc postmanHear(string what)void:
    string word;

    word := SetSay(what);
    if word ~= "" and word ~= "Packrat" then
	if GetWord() == "Postman" then
	    OPrint("Postman mutters something about dogs and hailstones.\n");
	fi;
    fi;
corp;

define tp_mail proc postmanPre()status:

    SPrint(TrueMe(), "Postman refuses the gift.\n");
    fail
corp;

define tp_mail proc postmanStart()void:
    thing me;
    int delay;

    me := Me();
    delay := me@p_oPostManDelay;
    me -- p_oPostManDelay;
    After(delay, postmanStep);
corp;

define tp_mail proc postmanCreate(int delay)void:
    thing postman;

    postman := CreateThing(nil);
    SetupMachine(postman);
    postman@p_pStandard := true;
    postman@p_oLettersHere := CreateThingList();
    postman@p_pDescAction := postmanDesc;
    postman@p_oPostManClearing := false;
    postman@p_oPostManCleared := false;
    postman@p_oPostManDelay := delay;
    postman@p_pGivePre := postmanPre;
    CreateMachine("Postman", postman, r_postmanHidden, postmanStart);
    ignore SetMachineActive(postman, postmanStep);
    ignore SetMachineSay(postman, postmanHear);
    GNewIcon(postman, makePostmanIcon());
corp;

postmanCreate(0).
/* postmanCreate(300). */
/* postmanCreate(600). */
ignore DeleteSymbol(tp_mail, "postmanCreate").

define tp_mail proc mailMakeLetter(string s)void:
    thing me, target, letter;
    string myName;

    me := Me();
    myName := FormatName(me@p_pName);
    target := me@p_pLetterTarget;
    me -- p_pLetterTarget;
    letter := CreateThing(o_letter);
    AddTail(me@p_pCarrying, letter);
    letter@p_oName := FormatName(target@p_pName) + ";letter,for.letter";
    letter@p_oReadString :=
	"Date: " + Date() + "\nFrom: " + myName + "\n\n" + s;
    letter@p_pLetterTarget := target;
    letter@p_oLetterSender := me;
    letter@p_oCarryer := me;
    letter@p_oCreator := me;
    SetThingStatus(letter, ts_public);
    GiveThing(letter, SysAdmin);
    if not me@p_pHidden and CanSee(Here(), me) then
	OPrint(myName + " finishes writing.\n");
    else
	OPrint("The quiet scratching noise stops.\n");
    fi;
    Print("Letter finished. Now all you need to do is post it.\n");
corp;

define tp_mail proc makeBulletin(string s)void:
    thing me, bulletin;
    string myName;

    me := Me();
    myName := me@p_pName;
    bulletin := CreateThing(o_bulletin);
    AddTail(me@p_pCarrying, bulletin);
    bulletin@p_oName := "bulletin,note";
    bulletin@p_oReadString :=
	"Date: " + Date() + "\nBy: " + myName + "\n\n" + s;
    bulletin@p_oLetterSender := me;
    bulletin@p_oCarryer := me;
    bulletin@p_oCreator := me;
    SetThingStatus(bulletin, ts_public);
    GiveThing(bulletin, SysAdmin);
    if not me@p_pHidden and CanSee(Here(), me) then
	OPrint(myName + " finishes writing.\n");
    else
	OPrint("The quiet scratching noise stops.\n");
    fi;
    Print("Bulletin finished. Now all you need to do is post it.\n");
corp;

define tp_mail proc writeNote(thing targetThing)bool:
    thing me;

    me := Me();
    if FindName(me@p_pCarrying, p_oName, "pad;writing") = fail then
	Print("You have no pad to write on.\n");
	false
    elif FindName(me@p_pCarrying, p_oName, "pen;ballpoint") = fail then
	Print("You have no ballpoint pen to write with.\n");
	false
    elif not CanSee(Here(), me) then
	Print("You can't write in the dark.\n");
	false
    else
	if targetThing ~= nil then
	    me@p_pLetterTarget := targetThing;
	    if GetDocument("mail> ", "Enter body of letter",
			   "", mailMakeLetter, false)
	    then
		if not me@p_pHidden and CanSee(Here(), me) then
		    OPrint(FormatName(me@p_pName) + " starts writing.\n");
		else
		    OPrint("You hear a quiet scratching noise start.\n");
		fi;
		true
	    else
		false
	    fi
	else
	    if GetDocument("bulletin> ", "Enter body of bulletin",
			   "", makeBulletin, false)
	    then
		if not me@p_pHidden and CanSee(Here(), me) then
		    OPrint(FormatName(me@p_pName) + " starts writing.\n");
		else
		    OPrint("You hear a quiet scratching noise start.\n");
		fi;
		true
	    else
		false
	    fi
	fi
    fi
corp;

define tp_mail proc mailTo(string who)bool:
    character targetPlayer;
    thing targetThing, me;

    me := Me();
    if who == "me" then
	who := me@p_pName;
    fi;
    targetPlayer := Character(who);
    if targetPlayer = nil then
	targetPlayer := Character(Capitalize(who));
    fi;
    if targetPlayer = nil then
	targetThing := FindAgent(who);
	if targetThing = nil then
	    Print("Character \"" + FormatName(who) +
		"\" does not exist. Make sure you have the spelling and "
		"capitalization right.\n");
	else
	    /* must have been a machine in the same location! */
	    Print("Sorry, " + who + " hasn't registered for mail yet.\n");
	fi;
	false
    else
	targetThing := CharacterThing(targetPlayer);
	if not targetThing@p_pMailRegistered then
	    Print("Sorry, " + who + " hasn't registered for mail yet.\n");
	    false
	else
	    writeNote(targetThing)
	fi
    fi
corp;

define tp_mail proc v_write()bool:
    string error, help, word;

    error := "You must specify who you want to write a letter to.\n";
    help :=
	    "Use 'post' to post a letter or bulletin, "
	    "'mail <who>' or 'write <who>' to write a letter, "
	    "and 'write bulletin' to write a bulletin.\n";
    word := GetWord();
    if word == "a" then
	word := GetWord();
    fi;
    if word == "to" then
	word := GetWord();
	if word = "" then
	    Print(error);
	    false
	else
	    mailTo(word)
	fi
    elif word == "letter" then
	word := GetWord();
	if word = "" then
	    if FindName(Me()@p_pCarrying, p_oName, "letter") ~= fail then
		Print(help);
	    else
		Print(error);
	    fi;
	    false
	elif word == "to" then
	    mailTo(GetWord())
	else
	    mailTo(word)
	fi
    elif word == "bulletin" then
	word := GetWord();
	if word = "" then
	    writeNote(nil)
	elif word == "to" then
	    Print("You can't write bulletins to individuals. You can write "
		  "letters to people, or you can write public bulletins.\n");
	    false
	else
	    Print("I don't understand what you want to write. ");
	    Print(help);
	    false
	fi
    elif Character(word) ~= nil then
	mailTo(word)
    elif word = "" then
	Print(error);
	false
    else
	Print("I don't understand who you want to write to. "
	      "Make sure you have the spelling and "
	      "capitalization of the name right. If you are trying to "
	      "write a bulletin, use 'write bulletin'.\n");
	false
    fi
corp;

VerbTail(G, "write", v_write).
Synonym(G, "write", "mail").

define tp_mail o_mail CreateThing(nil).
SetupObject(o_mail, r_mailRoom, "mail,letters;my,new", "").
o_mail@p_oInvisible := true.
o_mail@p_oReadString :=
    "Use 'get mail' or something similar to pick up your new mail first.".
define tp_mail proc mailGet(thing letter)status:
    list thing letters, carrying;
    thing me;
    int count, n;
    bool gotOne;

    me := Me();
    carrying := me@p_pCarrying;
    letters := r_mailRoom@p_oLettersHere;
    count := Count(letters);
    gotOne := false;
    n := 0;
    while n ~= count do
	letter := letters[n];
	if letter@p_pLetterTarget = me then
	    Print("You have a " + FormatName(letter@p_oName) + ".\n");
	    DelElement(letters, letter);
	    count := count - 1;
	    AddTail(carrying, letter);
	    letter@p_oCarryer := me;
	    letter@p_oCreator := me;
	    gotOne := true;
	else
	    n := n + 1;
	fi;
    od;
    if gotOne then
	if not me@p_pHidden then
	    OPrint(FormatName(me@p_pName) + " picks up some new mail.\n");
	fi;
    else
	Print("You have no mail.\n");
	if not me@p_pHidden then
	    OPrint(FormatName(me@p_pName) + " looks, but has no mail.\n");
	fi;
    fi;
    succeed
corp;
o_mail@p_oGetChecker := mailGet.

define tp_mail proc doPostLetter(thing letter)bool:
    thing me, sender, mailbox;
    list thing lt;
    status st;

    st := FindName(Here()@p_rContents, p_oName, "mailbox");
    if st = fail then
	Print("There is no mailbox here.\n");
	false
    else
	mailbox := FindResult();
	lt := mailbox@p_oLettersHere;
	if Parent(mailbox) ~= o_mailbox or lt = nil then
	    Print("Sorry, the mailbox here isn't official.\n");
	    false
	else
	    me := Me();
	    sender := letter@p_oLetterSender;
	    if sender ~= o_postalService then
		letter@p_oName := FormatName(sender@p_pName) +
			";letter,from.letter";
	    fi;
	    AddTail(lt, letter);
	    letter -- p_oCarryer;
	    DelElement(me@p_pCarrying, letter);
	    /* force Postman to deliver it before idling */
	    r_mailRoom@p_rNewLetter := true;
	    Print("Letter posted.\n");
	    if not me@p_pHidden then
		OPrint(FormatName(me@p_pName) +
		    " posts a letter.\n");
	    fi;
	    true
	fi
    fi
corp;

define tp_mail proc doPostBulletin(thing bulletin)bool:
    thing board, oldNote;
    list thing lt;
    status st;
    int n;

    st := FindName(Here()@p_rContents, p_oName, "board;bulletin");
    if st = fail then
	Print("There is no bulletin board here.\n");
	false
    else
	board := FindResult();
	lt := board@p_oContents;
	if Parent(board) ~= o_bulletinBoard or lt = nil then
	    Print("Sorry, the bulletin board here isn't official.\n");
	    false
	else
	    actualPostBulletin(bulletin, board);
	    true
	fi
    fi
corp;

define tp_mail proc v_post(string what)bool:
    thing me, letter;
    string name;
    status st;

    if what = "" then
	Print("You must specify what you want to post.\n");
	false
    else
	me := Me();
	name := FormatName(what);
	st := FindName(me@p_pCarrying, p_oName, what);
	if st = fail then
	    Print(AAn("You are not carrying", name) + ".\n");
	    false
	elif st = continue then
	    Print(name + " is ambiguous here.\n");
	    false
	else
	    letter := FindResult();
	    if Parent(letter) = o_letter then
		if letter@p_oCreator ~= me and MeCharacter() ~= SysAdmin then
		    Print("That's not your letter.\n");
		    false
		else
		    doPostLetter(letter)
		fi
	    elif Parent(letter) = o_bulletin then
		if letter@p_oCreator ~= me and MeCharacter() ~= SysAdmin then
		    Print("That's not your bulletin.\n");
		    false
		else
		    doPostBulletin(letter)
		fi
	    else
		Print("The " + name + " is not something you can post.\n");
		false
	    fi
	fi
    fi
corp;

Verb1(G, "post", 0, v_post).

define tp_mail proc mailRoomDrop(thing th)status:

    if Parent(th) = o_letter then
	Print("The letter somehow wafts its way into the mailbox.\n");
	if Me()@p_pHidden then
	    OPrint("A letter appears and wafts into the mailbox.\n");
	else
	    OPrint(Me()@p_pName +
		" drops a letter, which wafts into the mailbox.\n");
	fi;
	if doPostLetter(th) then
	    succeed
	else
	    continue
	fi
    else
	continue
    fi
corp;
AddRoomDropChecker(r_mailRoom, mailRoomDrop, false).

define tp_mail proc makeMailBox(thing room; string route)void:
    thing mailbox;

    mailbox := CreateThing(o_mailbox);
    SetThingStatus(mailbox, ts_readonly);
    AddTail(room@p_rContents, mailbox);
    mailbox@p_oPostManRoute := route;
    mailbox@p_oLettersHere := CreateThingList();
corp;

makeMailBox(r_mailRoom, "seene").
makeMailBox(r_ne3, "ssseees").
makeMailBox(r_es4, "wwwwssw").
makeMailBox(r_sw3, "nnnwwwn").
makeMailBox(r_wn3, "eeennwwn").

define t_util proc MakeBulletinBoard(thing room)void:
    thing board;

    board := CreateThing(o_bulletinBoard);
    board@p_oBulletinNumber := 1;
    board@p_oContents := CreateThingList();
    SetThingStatus(board, ts_readonly);
    AddTail(room@p_rContents, board);
corp;

MakeBulletinBoard(r_wn2).

CharacterThing(SysAdmin)@p_pMailRegistered := true.

unuse tp_mail
unuse t_streets
