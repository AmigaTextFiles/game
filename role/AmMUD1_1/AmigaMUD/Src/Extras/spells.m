/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * spells.m - some handy wizard spells for use with 'cast'.
 */

use t_base
use t_icons
use t_graphics
use t_util
use t_fight
use t_quests

/* Make sure the sourcer of this file has a spell table. */
if LookupTable(PrivateTable(), "t_spells") = nil then
    ignore DefineTable(PrivateTable(), "t_spells", CreateTable());
fi$

private tp_spellStuff CreateTable()$
use tp_spellStuff

/* a 'spells' spell which lists the spells we have here */

define t_spells proc spells()void:

    Print("Known spells:\n\n");
    Print("find <who> - show what <who> sees\n");
    Print("poofto <who> - teleport to same location as <who>\n");
    Print("look <who> - look at <who>, even if not nearby\n");
    Print("sendto <who> <stuff> - send <stuff> to <who> as mindsend\n");
    Print("heal <who> - heal <who> upto max hitpoints\n");
    Print("enrich <who> <amount> - give <amount> blutos to <who>\n");
    Print("force <who> <what> - force <who> to do <what>\n");
    Print("teleport <who> {here | <dir> | <roomname>} - teleport <who> ...\n");
    Print("showmachines - show machines in entire system\n");
    Print("Words in spell table:\n");
    ShowTable(t_spells);
corp;

define tp_spellStuff proc findMachine(string w1, w2)thing:
    int index;

    index := 1;
    if w2 ~= "" then
	index := StringToInt(w2);
	if index < 0 then
	    Print("Invalid index '" + w2 + "' - 1 assumed.\n");
	    index := 1;
	fi;
    fi;
    FindMachineIndexed(w1, index)
corp;

/* a 'find' spell which will print the location info for the given character */

define t_spells proc find()void:
    string name;
    character ch;
    thing where, agent;
    action a;
    bool found;

    name := GetWord();
    if name = "" then
	Print("Find who?\n");
    else
	found := true;
	ch := Character(name);
	if ch = nil then
	    agent := findMachine(name, GetWord());
	    if agent = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
		found := false;
	    else
		where := AgentLocation(agent);
	    fi;
	else
	    where := CharacterLocation(ch);
	fi;
	if found then
	    if where = nil then
		Print(Capitalize(CharacterNameS(agent)) +
		    " is not currently anywhere.\n");
	    else
		a := where@p_rNameAction;
		if a = nil then
		    Print(name + " is " + where@p_rName + ".\n");
		else
		    Print(name + ": " + call(a, string)() + ".\n");
		fi;
		a := where@p_rDescAction;
		if a = nil then
		    if where@p_rDesc ~= "" then
			Print(where@p_rDesc + "\n");
		    fi;
		    ShowExits(where);
		    ignore ShowList(where@p_rContents, "Nearby:\n");
		else
		    Print(name + ": " + call(a, string)() + ".\n");
		fi;
	    fi;
	fi;
    fi;
corp;

/* a 'poofto' spell which will poof to where the given character is */

define t_spells proc poofto()void:
    string name;
    character ch;
    thing who, where;

    name := GetWord();
    if name = "" then
	Print("Poofto who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    who := findMachine(name, GetWord());
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    where := AgentLocation(who);
	    if where = nil then
		Print(Capitalize(CharacterNameS(who)) +
		    " is not currently active or anywhere.\n");
	    else
		LeaveRoomStuff(where, 0, MOVE_POOF);
		EnterRoomStuff(where, 0, MOVE_POOF);
	    fi;
	fi;
    fi;
corp;

/* a 'look' spell which will look at a given character */

define t_spells proc look()void:
    string name, s;
    character ch;
    thing who;
    action a;

    name := GetWord();
    if name = "" then
	Print("Look who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    who := findMachine(name, GetWord());
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    if LookAtCharacter(who) then
		if who@p_pMoney ~= 0 then
		    Print(Capitalize(CharacterNameS(who)) + " has " +
			IntToString(who@p_pMoney) + " blutos.\n");
		fi;
		ignore ShowQuests(who, true);
	    fi;
	fi;
    fi;
corp;

/* a 'sendto' spell which will say something to the given character */

define t_spells proc sendto()void:
    string name;
    character ch;
    thing who;

    name := GetWord();
    if name = "" then
	Print("Sendto who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    if findMachine(name, GetWord()) = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
		SPrint(who, Me()@p_pName + " mindsends: " + GetTail());
	    fi;
	fi;
    fi;
corp;

/* a 'heal' spell to heal someone up */

define t_spells proc heal()void:
    string name;
    character ch;
    thing who;
    int max;

    name := GetWord();
    if name = "" then
	Print("Heal who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    who := findMachine(name, GetWord());
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    max := who@p_pHitMax;
	    if max = 0 then
		Print(name + " has no maximum hitpoints.\n");
	    elif who@p_pHitNow = max then
		Print(name + " needs no healing.\n");
	    else
		who@p_pHitNow := max;
		Print(name + " healed.\n");
		SPrint(who, "You suddenly feel better!\n");
	    fi;
	fi;
    fi;
corp;

/* an 'enrich' spell to give someone some blutos */

define t_spells proc enrich()void:
    string name, s;
    character ch;
    thing who;
    int amount;

    name := GetWord();
    if name = "" then
	Print("Enrich who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    who := findMachine(name, GetWord());
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    s := GetWord();
	    if s = "" then
		Print("You must specify an amount to enrich by.\n");
	    else
		amount := StringToInt(s);
		if amount <= 0 then
		    Print("Invalid amount - must be positive integer.\n");
		else
		    who@p_pMoney := who@p_pMoney + amount;
		    Print(name + " enriched - now has " +
			  IntToString(who@p_pMoney) + " blutos.\n");
		    SPrint(who, "You suddenly feel richer!\n");
		fi;
	    fi;
	fi;
    fi;
corp;

/* a 'force' spell which will make someone do something */

define tp_spellStuff p_pForceAction CreateStringProp()$

define tp_spellStuff proc doForceAction()void:
    string s;

    s := Me()@p_pForceAction;
    if s ~= "" then
	Me() -- p_pForceAction;
	ignore Parse(G, s);
    fi;
corp;

define tp_spellStuff proc forceAnAction()status:
    After(0.0, doForceAction);
    continue
corp;

define tp_spellStuff proc forceCharacter(thing who; string what)void:
    who@p_pForceAction := what;
    ignore ForceAction(who, forceAnAction);
corp;

define t_spells proc force()void:
    string name, w, what;
    character ch;
    thing who;
    int n;

    name := GetWord();
    if name = "" then
	Print("Force who?\n");
    else
	w := GetWord();
	what := GetTail();
	ch := Character(name);
	if ch = nil then
	    n := StringToInt(w);
	    if n < 0 then
		what := w + " " + what;
		w := "";
	    fi;
	    who := findMachine(name, w);
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    what := w + " " + what;
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    if what = "" then
		Print("You must say what you want " + name + " to do.\n");
	    else
		SPrint(who, "***\n" + Me()@p_pName + " forces you: " +
		    what + "\n***\n");
		forceCharacter(who, what);
	    fi;
	fi;
    fi;
corp;

/* a 'teleport' spell which will send a character to a given location */

define tp_spellStuff p_pForceMove CreateThingProp()$

define tp_spellStuff proc doForceMove()status:
    thing me, dest;
    string name;
    action a;

    me := Me();
    dest := me@p_pForceMove;
    if dest ~= nil then
	me -- p_pForceMove;
	LeaveRoomStuff(dest, 0, MOVE_POOF);
	EnterRoomStuff(dest, 0, MOVE_POOF);
    fi;
    continue
corp;

define t_spells proc teleport()void:
    string name, w, location;
    character ch;
    thing me, here, who, where, there;
    action a;
    int dir, n;
    property thing dirProp;

    name := GetWord();
    w := GetWord();
    location := GetWord();
    n := StringToInt(w);
    if n < 0 then
	location := w;
	w := "";
    fi;
    if location = "" then
	Print("Teleport who where?\n");
    else
	me := Me();
	here := Here();
	if name == "me" then
	    ch := ThingCharacter(me);
	else
	    ch := Character(name);
	fi;
	if ch = nil then
	    who := findMachine(name, w);
	    if who = nil then
		Print("There is no character or machine called '" +
		      name + "'.\n");
	    fi;
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    fi;
	fi;
	if who ~= nil then
	    where := AgentLocation(who);
	    if where = nil then
		Print(Capitalize(CharacterNameS(who)) +
		    " is not currently active or anywhere.\n");
	    else
		dir := DirMatch(location);
		if dir ~= -1 then
		    there := here@DirProp(dir);
		    if there = nil then
			Print("That direction does not go anywhere.\n");
		    fi;
		else
		    if location == "here" then
			there := here;
		    else
			there := LookupThing(nil, location);
			if there ~= nil then
			    if there@p_rName = "" and
				there@p_rNameAction = nil
			    then
				Print(location + " is not a location.\n");
				there := nil;
			    fi;
			else
			    Print(location + " is not defined.\n");
			fi;
		    fi;
		fi;
		if there ~= nil then
		    if who = me then
			LeaveRoomStuff(there, 0, MOVE_POOF);
			EnterRoomStuff(there, 0, MOVE_POOF);
		    else
			SPrint(who, "***\n" +
			    me@p_pName + " teleports you! \n***\n");
			who@p_pForceMove := there;
			ignore ForceAction(who, doForceMove);
		    fi;
		fi;
	    fi;
	fi;
    fi;
corp;

/* A 'tick' spell that just ticks every minute. */

define tp_spellStuff p_pTicking CreateBoolProp()$
define tp_spellStuff TICK_ID NextEffectId()$

define tp_spellStuff proc doTick()void:

    if Me()@p_pTicking then
	VSpeak(nil, "Beep", TICK_ID);
	After(60.0, doTick);
    fi;
corp;

define t_spells proc tick()void:

    if Me()@p_pTicking then
	Me() -- p_pTicking;
	Print("Ticking stopped.\n");
    else
	Me()@p_pTicking := true;
	After(60.0, doTick);
	Print("Ticking started.\n");
    fi;
corp;

/* A 'showmachines' spell that shows you all the machines currently active. */

define tp_spellStuff p_mThing CreateThingProp()$
define tp_spellStuff p_mCount CreateIntProp()$
define tp_spellStuff p_pMachineList CreateThingListProp()$

define tp_spellStuff proc visitAgent(thing theAgent)void:
    list thing lt;
    int count, i;
    thing entry, parent;

    if ThingCharacter(theAgent) = nil then
	/* ignore player characters */
	parent := Parent(theAgent);
	if parent ~= nil and parent@p_pName ~= "" and
	    (parent@p_pName = theAgent@p_pName or parent@p_pName = "WANDERER")
	then
	    /* Handle generic monsters and wanderers. */
	    theAgent := parent;
	fi;
	lt := Me()@p_pMachineList;
	count := Count(lt);
	i := 0;
	while i ~= count and lt[i]@p_mThing ~= theAgent do
	    i := i + 1;
	od;
	if i ~= count then
	    lt[i]@p_mCount := lt[i]@p_mCount + 1;
	else
	    entry := CreateThing(nil);
	    entry@p_mThing := theAgent;
	    entry@p_mCount := 1;
	    AddTail(lt, entry);
	fi;
    fi;
corp;

define t_spells proc showmachines()void:
    list thing lt;
    int count, i, total;
    thing entry;

    lt := CreateThingList();
    Me()@p_pMachineList := lt;
    ForEachAgent(nil, visitAgent);
    total := 0;
    count := Count(lt);
    for i from 0 upto count - 1 do
	entry := lt[i];
	Print("  " + FormatName(entry@p_mThing@p_pName) + ": " +
	    IntToString(entry@p_mCount) + "\n");
	total := total + entry@p_mCount;
    od;
    /* This should throw the whole thing away. */
    Me() -- p_pMachineList;
    Print("Total: " + IntToString(total) + ".\n");
corp;

/* An 'edit' routine to allow use of the builtin editor for editing strings.
   Note that this isn't a spell. There isn't any way outside of wizard mode
   to get a value into your p_pEditString property, so it may as well just
   be a wizard-mode callable routine. It's not just 'edit' since that
   conflicts with the 'edit' wizard-mode command. */

define tp_spellStuff p_pEditString CreateStringProp()$

define tp_spellStuff proc editHandler(string s; bool ok)void:

    if ok then
	Me()@p_pEditString := s;
    fi;
corp;

define tp_spellStuff proc editstring()void:

    if CanEdit() then
	if Editing() then
	    Print("You are already editing something.\n");
	else
	    EditString(Me()@p_pEditString, editHandler, EDIT_CODE, "String");
	fi;
    else
	Print("You do not have access to a remote editor.\n");
    fi;
corp;

unuse tp_spellStuff
unuse t_quests
unuse t_fight
unuse t_util
unuse t_graphics
unuse t_icons
unuse t_base
