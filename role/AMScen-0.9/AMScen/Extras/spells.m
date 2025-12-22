/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * spells.m - some handy wizard spells for use with 'cast'.
 */

use t_base
use t_icons
use t_graphics
use t_util
use t_fight

/* a 'spells' spell which lists the spells we have here */

private proc spells()void:

    Print("Known spells:\n\n");
    Print("find <who> - show what <who> sees\n");
    Print("poofto <who> - teleport to same location as <who>\n");
    Print("look <who> - look at <who>, even if not nearby\n");
    Print("sendto <who> <stuff> - send <stuff> to <who> as mindsend\n");
    Print("heal <who> - heal <who> upto max hitpoints\n");
    Print("force <who> <what> - force <who> to do <what>\n");
    Print("teleport <who> {here | <dir> | <roomname>} - teleport <who> ...\n");
corp;

/* a 'find' spell which will print the location info for the given character */

private proc find()void:
    string name;
    character ch;
    thing where;
    action a;

    name := GetWord();
    if name = "" then
	Print("Find who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
	else
	    where := CharacterLocation(ch);
	    if where = nil then
		Print(name + " is not currently anywhere.\n");
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

private proc poofto()void:
    string name;
    character ch;
    thing who, where;

    name := GetWord();
    if name = "" then
	Print("Poofto who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
		where := AgentLocation(who);
		if where = nil then
		    Print(name + " is not currently active or anywhere.\n");
		else
		    LeaveRoomStuff(where, 0, MOVE_POOF);
		    EnterRoomStuff(where, 0, MOVE_POOF);
		fi;
	    fi;
	fi;
    fi;
corp;

/* a 'look' spell which will look at a given character */

private proc look()void:
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
	    Print("There is no character called '" + name + "'.\n");
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
		if LookAtCharacter(who) then
		    ignore ShowQuests(who);
		fi;
	    fi;
	fi;
    fi;
corp;

/* a 'sendto' spell which will say something to the given character */

private proc sendto()void:
    string name;
    character ch;
    thing who;

    name := GetWord();
    if name = "" then
	Print("Sendto who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
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

private proc heal()void:
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
	    Print("There is no character called '" + name + "'.\n");
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
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
    fi;
corp;

/* a 'force' spell which will make someone do something */

private p_pForceAction CreateStringProp().

private proc doForceAction()status:
    string s;

    s := Me()@p_pForceAction;
    if s ~= "" then
	Me() -- p_pForceAction;
	ignore Parse(G, s);
    fi;
    continue
corp;

private proc forceAnAction()void:
    After(0, doForceAction);
corp;

define t_util proc forceCharacter(thing who; string what)void:
    who@p_pForceAction := what;
    ignore ForceAction(who, forceAnAction);
corp;

private proc force()void:
    string name, what;
    character ch;
    thing who;

    name := GetWord();
    if name = "" then
	Print("Force who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
		what := GetTail();
		if what = "" then
		    Print("You must say what you want " + name + " to do.\n");
		else
		    SPrint(who, "***\n" + Me()@p_pName + " forces you: " +
			what + "\n***\n");
		    forceCharacter(who, what);
		fi;
	    fi;
	fi;
    fi;
corp;

/* a 'teleport' spell which will send a character to a given location */

private p_pForceMove CreateThingProp().

private proc doForceMove()status:
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

private proc teleport()void:
    string name, location;
    character ch;
    thing me, here, who, where, there;
    action a;
    int dir;
    property thing dirProp;

    name := GetWord();
    location := GetWord();
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
	    Print("There is no character called '" + name + "'.\n");
	else
	    who := CharacterThing(ch);
	    if who = nil then
		Print(name + " has no thing????\n");
	    else
		where := AgentLocation(who);
		if where = nil then
		    Print(name + " is not currently active or anywhere.\n");
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
				    there := nil;
				fi;
			    fi;
			    if there = nil then
				Print(location +
				    " is not a defined location.\n");
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
    fi;
corp;


unuse t_fight
unuse t_util
unuse t_graphics
unuse t_icons
unuse t_base
