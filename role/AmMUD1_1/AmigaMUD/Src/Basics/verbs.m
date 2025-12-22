/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * verbs.m - define the standard verbs (commands).
 *	This normally follows after 'base.m', 'util1.m' and 'util2.m'.
 */

private tp_verbs CreateTable()$
use tp_verbs

/* All of the separator words that we will use */

ignore Word(G, "to")$
ignore Word(G, "at")$
ignore Word(G, "around")$
ignore Word(G, "from")$
ignore Word(G, "on")$
ignore Word(G, "onto")$
ignore Word(G, "do")$

/* Also used, but are defined as verbs.

    "in"/"into"/"inside"/"inwards", "out"/"outside",
    "up", "down", "with", "off"

*/

/* Need to define 'off' early */

define tp_verbs proc v_quit()bool:
    /* Bit of a nuisance - the server handles the messages for coming and
       going from the world, and it knows nothing of p_pHidden. Oh well. */
    Quit();
    ClearFollowers(Me());
    false
corp;

Verb0(G, "quit", 0, v_quit)$
Synonym(G, "quit", "bye")$
Verb0(G, "off", 0, v_quit)$	/* used separately */

/* routines for going in specific directions (these are actual verbs) */

define tp_verbs proc v_north()bool:
    UserMove(D_NORTH)
corp;
define tp_verbs proc v_south()bool:
    UserMove(D_SOUTH)
corp;
define tp_verbs proc v_east()bool:
    UserMove(D_EAST)
corp;
define tp_verbs proc v_west()bool:
    UserMove(D_WEST)
corp;
define tp_verbs proc v_northEast()bool:
    UserMove(D_NORTHEAST)
corp;
define tp_verbs proc v_northWest()bool:
    UserMove(D_NORTHWEST)
corp;
define tp_verbs proc v_southEast()bool:
    UserMove(D_SOUTHEAST)
corp;
define tp_verbs proc v_southWest()bool:
    UserMove(D_SOUTHWEST)
corp;
define tp_verbs proc v_up()bool:
    UserMove(D_UP)
corp;
define tp_verbs proc v_down()bool:
    UserMove(D_DOWN)
corp;
define tp_verbs proc v_enter()bool:
    UserMove(D_ENTER)
corp;
define tp_verbs proc v_exit()bool:
    UserMove(D_EXIT)
corp;

/* define the actual movement verbs */

Verb0(G, "north", 0, v_north)$
Verb0(G, "south", 0, v_south)$
Verb0(G, "east", 0, v_east)$
Verb0(G, "west", 0, v_west)$
Verb0(G, "northeast", 0, v_northEast)$
Verb0(G, "northwest", 0, v_northWest)$
Verb0(G, "southeast", 0, v_southEast)$
Verb0(G, "southwest", 0, v_southWest)$
Verb0(G, "up", 0, v_up)$
Verb0(G, "down", 0, v_down)$
Verb0(G, "enter", 0, v_enter)$
Verb0(G, "exit", 0, v_exit)$	/* no synonyms - is used elsewhere */

Synonym(G, "north", "n")$
Synonym(G, "south", "s")$
Synonym(G, "east", "e")$
Synonym(G, "west", "w")$
Synonym(G, "northeast", "ne")$
Synonym(G, "northeast", "north-east")$
Synonym(G, "northwest", "nw")$
Synonym(G, "northwest", "north-west")$
Synonym(G, "southeast", "se")$
Synonym(G, "southeast", "south-east")$
Synonym(G, "southwest", "sw")$
Synonym(G, "southwest", "south-west")$
Synonym(G, "up", "u")$
Synonym(G, "down", "d")$
Verb0(G, "in", 0, v_enter)$	/* also used elsewhere */
Synonym(G, "in", "inside")$
Synonym(G, "in", "into")$
Synonym(G, "in", "inwards")$
Verb0(G, "out", 0, v_exit)$	/* also used elsewhere */
Synonym(G, "out", "outside")$
Verb0(G, "leave", 0, v_exit)$

define tp_verbs proc v_go(string where)bool:

    if where = "" then
	Print("You must specify a direction to " + Verb() + ".\n");
	false
    elif DirMatch(where) ~= -1 then
	if Punctuation() ~= " " then
	    where := where + Punctuation();
	fi;
	Parse(G, where) ~= 0
    else
	Print("I don't know how to " + Verb() + " \"" +
	    FormatName(where) + "\".\n");
	false
    fi
corp;

Verb1(G, "go", FindAnyWord(G, "to"), v_go)$
Synonym(G, "go", "walk")$
Synonym(G, "go", "climb")$
Synonym(G, "go", "jump")$
Synonym(G, "go", "move")$
Synonym(G, "go", "head")$
Synonym(G, "go", "run")$
Synonym(G, "go", "crawl")$
Synonym(G, "go", "trot")$	/* canter, gallop, slither, ...? - nah! */


/* This verb is defined early, so we can use "with" for other verbs. */

define tp_verbs proc v_with()bool:
    string what, whatName;
    status st;
    thing object;
    grammar g;

    what := GetNounPhrase(G, GetTail(), FindAnyWord(G, "do"));
    if what = "" then
	Print("You must specify what you want to do something with.\n");
	false
    else
	if GetWord() ~= "do" then
	    Print("Use the form: with <object> do <command>\n");
	    false
	else
	    whatName := FormatName(what);
	    st := FindName(Me()@p_pCarrying, p_oName, what);
	    if st = succeed then
		object := FindResult();
		g := object@p_oSpecialGrammar;
		if g = nil then
		    Print("The " + whatName + " has no special actions.\n");
		    false
		else
		    what := GetTail();
		    if what = "" then
			Print("You must specify what you want to do with the "+
			    whatName + ".\n");
			false
		    else
			/* This is the magic here. Take the remainder of
			   the player's command line ("GetTail()"), and
			   parse it against the grammar retrieved from the
			   special object. */
			SetIt(object);
			what := GetTail();
			if Punctuation() ~= " " then
			    what := what + Punctuation();
			fi;
			Parse(g, what) ~= 0
		    fi
		fi
	    elif st = continue then
		Print(Capitalize(whatName) + " is ambiguous.\n");
		false
	    else
		Print(AAn("You are not carrying", whatName) + ".\n");
		false
	    fi
	fi
    fi
corp;

VerbTail(G, "with", v_with)$

/* create a little toy to test 'with' */

/*
define tp_verbs o_toy CreateThing(nil)$
SetupObject(o_toy, r_arrivals, "toy;with",
    "The toy is here for testing the 'with' command only.")$
o_toy@p_oSpecialGrammar := CreateGrammar()$
define tp_verbs proc tv_hello()bool:
    Print("The toy says hello back.\n");
    true
corp;
define tp_verbs proc tv_hi()bool:
    Print("The toy says hi back.\n");
    true
corp;
define tp_verbs proc tv_echo()bool:
    Print("Toy: " + GetTail() + "\n");
    true
corp;
Verb0(o_toy@p_oSpecialGrammar, "hello", 0, tv_hello)$
Verb0(o_toy@p_oSpecialGrammar, "hi", 0, tv_hi)$
VerbTail(o_toy@p_oSpecialGrammar, "echo", tv_echo)$
*/


/*
 * now some silly verbs for people to play with
 */

define tp_verbs proc doPosition(string what; int pos)bool:
    thing me, here, it;
    status st;
    string s1, s2, whatName;
    property int countProp;
    int n;
    action a;

    me := Me();
    here := Here();
    case pos
    incase POS_SIT_IN:
	s1 := "sit";
	s2 := "in";
	countProp := p_oCanSitIn;
    incase POS_SIT_ON:
	s1 := "sit";
	s2 := "on";
	countProp := p_oCanSitOn;
    incase POS_LIE_IN:
	s1 := "lie";
	s2 := "in";
	countProp := p_oCanLieIn;
    incase POS_LIE_ON:
	s1 := "lie";
	s2 := "on";
	countProp := p_oCanLieOn;
    incase POS_STAND_IN:
	s1 := "stand";
	s2 := "in";
	countProp := p_oCanStandIn;
    incase POS_STAND_ON:
	s1 := "stand";
	s2 := "on";
	countProp := p_oCanStandOn;
    esac;
    if me@p_pPosition ~= POS_NONE then
	Print("You are still " + ShowPosition(me) + "\n");
	false
    elif what = "" or what == "down" then
	Print("You must say what you want to " + s1 + " " + s2 + ".\n");
	false
    else
	whatName := FormatName(what);
	st := FindName(here@p_rContents, p_oName, what);
	if st = succeed then
	    whatName := " the " + whatName;
	    it := FindResult();
	    n := it@countProp;
	    if n = 0 then
		Print("You can't " + s1 + " " + s2 + whatName + ".\n");
		false
	    elif n = 1 then
		Print("There is no room " + s2 + whatName + ".\n");
		false
	    else
		st := continue;
		SetIt(it);
		a := it@p_oPositionChecker;
		if a ~= nil then
		    st := call(a, status)(pos);
		fi;
		if st ~= fail then
		    if st = continue then
			Print("You " + s1 + " " + s2 + whatName + ".\n");
			if not me@p_pHidden and CanSee(here, me) then
			    OPrint(Capitalize(CharacterNameS(me)) + " " +
				s1 + "s " + s2 + whatName + ".\n");
			fi;
		    fi;
		    me@p_pPosition := pos;
		    me@p_pWhere := it;
		    it@countProp := n - 1;
		    true
		else
		    false
		fi
	    fi
	elif st = continue then
	    Print(Capitalize(whatName) + " is ambiguous here.\n");
	    false
	else
	    if MatchName(here@p_rScenery, what) ~= -1 then
		Print("You can't " + s1 + " " + s2 + " the " + whatName+".\n");
	    else
		Print(IsAre("There", "no", whatName, "here.\n"));
	    fi;
	    false
	fi
    fi
corp;

define tp_misc proc PositionProp(int posCode)property int:

    case posCode
    incase POS_SIT_IN:
	p_oCanSitIn
    incase POS_SIT_ON:
	p_oCanSitOn
    incase POS_LIE_IN:
	p_oCanLieIn
    incase POS_LIE_ON:
	p_oCanLieOn
    incase POS_STAND_IN:
	p_oCanStandIn
    incase POS_STAND_ON:
	p_oCanStandOn
    default:
	Print("*** Invalid code to PositionProp ***\n");
	p_oCanSitIn
    esac
corp;

define tp_verbs proc unPos()bool:
    string name, where;
    int pos;
    thing me, it;
    property int prop;
    bool others;

    me := Me();
    pos := me@p_pPosition;
    others := not me@p_pHidden and CanSee(Here(), me);
    name := Capitalize(CharacterNameS(me));
    where := FormatName(me@p_pWhere@p_oName);
    if pos = POS_SIT_IN or pos = POS_STAND_IN or pos = POS_LIE_IN then
	Print("You get out of the " + where + ".\n");
	if others then
	    OPrint(name + " gets out of the " + where + ".\n");
	fi;
    elif pos = POS_SIT_ON or pos = POS_LIE_ON then
	Print("You stand up.\n");
	if others then
	    OPrint(name + " stands up.\n");
	fi;
    else
	Print("You get down from the " + where + ".\n");
	if others then
	    OPrint(name + " gets down from the " + where + ".\n");
	fi;
    fi;
    me@p_pPosition := POS_NONE;
    it := me@p_pWhere;
    me@p_pWhere := me;	    /* free any reference! */
    prop := PositionProp(pos);
    it@(prop) := it@(prop) + 1;
    true
corp;

define tp_verbs proc v_standUp()bool:

    if Me()@p_pPosition = POS_NONE then
	Print("You are already standing up.\n");
	false
    else
	unPos()
    fi
corp;

define tp_verbs proc v_getOff()bool:

    if Me()@p_pPosition = POS_NONE then
	Print("You are not on anything.\n");
	false
    else
	unPos()
    fi
corp;

define tp_verbs proc v_getOut()bool:

    if Me()@p_pPosition = POS_NONE then
	Print("You are not in anything.\n");
	false
    else
	unPos()
    fi
corp;

define tp_verbs proc v_sitLieStand()bool:
    string v, w, np;

    v := Verb();
    w := GetWord();
    if w == "down" then
	w := GetWord();
    fi;
    np := GetTail();
    if v == "stand" and w == "up" then
	v_standUp()
    elif np = "" then
	if w = "" then
	    w := "on";
	fi;
	Print("You must say what you want to " + v + " " + w + ".\n");
	false
    else
	np := GetNounPhrase(G, np, 0);
	if w == "in" then
	    if v == "sit" then
		doPosition(np, POS_SIT_IN)
	    elif v == "stand" then
		doPosition(np, POS_STAND_IN)
	    else
		doPosition(np, POS_LIE_IN)
	    fi
	elif w == "on" then
	    if v == "sit" then
		doPosition(np, POS_SIT_ON)
	    elif v == "stand" then
		doPosition(np, POS_STAND_ON)
	    else
		doPosition(np, POS_LIE_ON)
	    fi
	else
	    Print("I don't know how to " + v + " " + w + " something.\n");
	    false
	fi
    fi
corp;

VerbTail(G, "sit", v_sitLieStand)$
VerbTail(G, "lie", v_sitLieStand)$
VerbTail(G, "lay", v_sitLieStand)$
VerbTail(G, "stand", v_sitLieStand)$
Verb0(G, "standup", 0, v_standUp)$
Verb0(G, "get", FindAnyWord(G, "off"), v_getOff)$
Verb0(G, "get", FindAnyWord(G, "down"), v_getOff)$
Verb0(G, "get", FindAnyWord(G, "out"), v_getOut)$


/* some standard verb routines and the corresponding verbs */

/*
 * lookAtObject - common code to do the looking at a normal object.
 */

define tp_verbs proc lookAtObject(thing object)bool:
    status st;
    action a;
    string s;

    st := continue;
    a := object@p_oDescCheck;
    if a ~= nil then
	st := call(a, status)();
    fi;
    if st ~= fail then
	a := object@p_oDescAction;
	if a = nil then
	    s := object@p_oDesc;
	    if s = "" then
		Print("You see nothing special about the " +
		    FormatName(object@p_oName) + ".\n");
	    else
		NPrint(s);
	    fi;
	else
	    SetIt(object);
	    Print(call(a, string)() + "\n");
	fi;
	if object@p_Image ~= "" then
	    ShowImage(object@p_Image);
	fi;
	true
    else
	false
    fi
corp;

define tp_verbs proc v_look(string what)bool:
    thing here, me, object;
    string ambig, name, s;
    action a;
    status st;
    int dir;
    bool wasScenery;

    here := Here();
    me := Me();
    if what = "" then
	Print("You must specify what you want to look at.\n");
	false
    elif not CanSee(here, me) then
	Print("It is dark here.\n");
	false
    elif what == "all" then
	st := DoAll(here@p_rContents, lookAtObject);
	if st = fail then
	    Print("There are no obvious things here to look at.\n");
	    false
	else
	    st = continue
	fi
    else
	object := FindAgent(what);
	if object ~= nil then
	    /* player is examining another player or a monster */
	    LookAtCharacter(object)
	else
	    dir := DirMatch(what);
	    if dir ~= -1 then
		/* looking in a given direction */
		s := here@(DirDesc(dir));
		if s = "" then
		    Print("You see nothing special in that direction.\n");
		else
		    NPrint(s);
		fi;
		s := here@(DirImage(dir));
		if s ~= "" then
		    ShowImage(s);
		fi;
		true
	    else
		/* player is examining an object */
		name := FormatName(what);
		object := nil;
		wasScenery := false;
		ambig := " is ambiguous here.\n";
		st := FindName(me@p_pCarrying, p_oName, what);
		if st = fail then
		    st := FindName(here@p_rContents, p_oName, what);
		    if st = fail and here@p_rBuyList ~= nil then
			st := FindName(here@p_rBuyList, p_oName, what);
		    fi;
		    if st = fail then
			if MatchName(here@p_rScenery, what) ~= -1 then
			    Print("You see nothing special about the " +
				name + ".\n");
			    wasScenery := true;
			else
			    Print(IsAre("There", "no", name, "here.\n"));
			fi;
		    elif st = continue then
			Print(Capitalize(name));
			Print(ambig);
		    else
			object := FindResult();
		    fi;
		elif st = continue then
		    Print(Capitalize(name));
		    Print(ambig);
		else
		    object := FindResult();
		fi;
		if object = nil then
		    wasScenery
		else
		    lookAtObject(object)
		fi
	    fi
	fi
    fi
corp;

define tp_verbs proc v_lookInwards()bool:
    v_look("in")
corp;

/*
 * Note that the code here is very similar to that in EnterRoom in util1.m
 * This is as desired - the same stuff should be seen.
 */

define tp_verbs proc v_lookAround()bool:
    thing me;

    me := Me();
    if not CanSee(Here(), me) then
	Print("It is dark here.\n");
	false
    else
	if ShowRoomToMe(true) then
	    if not me@p_pHidden then
		OPrint(Capitalize(CharacterNameS(me)) + " looks around.\n");
	    fi;
	    true
	else
	    false
	fi
    fi
corp;

define tp_verbs proc v_exits()bool:
    ShowExits(Here());
    true
corp;

Verb1(G, "look", FindAnyWord(G, "at"), v_look)$
/* Do the "around" one first, so that just "look" gets it. */
Verb0(G, "look", FindAnyWord(G, "around"), v_lookAround)$
/* Special case to enable "look inwards" */
Verb0(G, "look", FindAnyWord(G, "in"), v_lookInwards)$
Synonym(G, "look", "examine")$
Synonym(G, "look", "l")$
Verb0(G, "exits", 0, v_exits)$
Synonym(G, "exits", "x")$


define tp_verbs proc readObject(thing object)bool:
    action a;

    SetIt(object);
    a := object@p_oReadAction;
    if a ~= nil then
	Paginate(call(a, string)());
    elif object@p_oReadString ~= "" then
	Paginate(object@p_oReadString);
    else
	Print("There is nothing to read on the " +
	    FormatName(object@p_oName) + ".\n");
    fi;
    true
corp;

define tp_verbs proc doReadObject(thing object)bool:

    ignore readObject(object);
    true
corp;

define tp_verbs proc v_read(string what)bool:
    thing me, here, object;
    status st;
    action a;
    string name, ambig;
    bool wasScenery;

    me := Me();
    here := Here();
    if what = "" then
	Print("You must specify what you want to read.\n");
	false
    elif not CanSee(here, me) then
	Print("It is dark here.\n");
	false
    else
	st := continue;
	a := me@p_pReadChecker;
	if a ~= nil then
	    st := call(a, status)();
	fi;
	if st = continue then
	    if what == "all" then
		st := DoAll(me@p_pCarrying, readObject);
		if st ~= succeed then
		    st := DoAll(here@p_rContents, doReadObject);
		    if st = fail then
			st := continue;
		    fi;
		fi;
		if st = fail then
		    Print("There are no obvious things here to read.\n");
		    false
		else
		    st = continue
		fi
	    else
		name := FormatName(what);
		object := FindAgent(what);
		if object ~= nil then
		    readObject(object)
		else
		    object := nil;
		    wasScenery := false;
		    ambig := " is ambiguous here.\n";
		    st := FindName(me@p_pCarrying, p_oName, what);
		    if st = fail then
			st := FindName(here@p_rContents, p_oName, what);
			if st = fail then
			    if here@p_rBuyList ~= nil and
				FindName(here@p_rBuyList, p_oName,what) ~= fail
			    then
				Print("You should buy the " + name +
				    " before you try to read it.\n");
			    elif MatchName(here@p_rScenery, what) ~= -1 then
				Print("There is nothing to read on the " +
				    name + ".\n");
				wasScenery := true;
			    else
				Print(IsAre("There", "no", name, "here.\n"));
			    fi;
			elif st = continue then
			    Print(Capitalize(name));
			    Print(ambig);
			else
			    object := FindResult();
			fi;
		    elif st = continue then
			Print(Capitalize(name));
			Print(ambig);
		    else
			object := FindResult();
		    fi;
		    if object = nil then
			wasScenery
		    else
			readObject(object)
		    fi
		fi
	    fi
	else
	    st ~= fail
	fi
    fi
corp;
Verb1(G, "read", 0, v_read)$


define tp_verbs proc v_inventory()bool:
    int cash;
    thing me;

    me := Me();
    cash := me@p_pMoney;
    if cash = 0 then
	Print("You are broke.\n");
    else
	Print("You have ");
	IPrint(cash);
	if cash = 1 then
	    Print(" bluto.\n");
	else
	    Print(" blutos.\n");
	fi;
    fi;
    if ShowList(me@p_pCarrying, "You are carrying:\n") then
	Print("You are not carrying anything.\n");
    fi;
    if not me@p_pHidden and CanSee(Here(), me) then
	OPrint(Capitalize(CharacterNameS(me)) + " takes inventory.\n");
    fi;
    true
corp;

Verb0(G, "inventory", 0, v_inventory)$
Synonym(G, "inventory", "inv")$
Synonym(G, "inventory", "i")$


define t_base p_oNotGetString CreateStringProp()$

define t_util proc public DoGet(thing where, who, what)status:
    action a;
    string whatName;
    status st;

    whatName := FormatName(what@p_oName);
    if what@p_oNotGetString ~= "" then
	Print(what@p_oNotGetString + "\n");
	fail
    elif what@p_oNotGettable then
	Print("You cannot get the " + whatName + ".\n");
	fail
    else
	a := what@p_oGetChecker;
	st := continue;
	if a ~= nil then
	    SetIt(what);
	    st := call(a, status)(what);
	fi;
	if st = continue then
	    /* object not chained to floor or anything */
	    st := DoRoomGetChecks(where, what);
	    if st = continue then
		/* room floor isn't a pool of glue or anything */
		if CarryItem(what) then
		    DelElement(where@p_rContents, what);
		    what -- p_oWhere;
		    SPrint(who, whatName + ": taken.\n");
		    if CanSee(where, who) then
			if who@p_pHidden then
			    ABPrint(where, who, who, "The " + whatName +
				    " rises and vanishes from view\n");
			else
			    ABPrint(where, who, who,
				Capitalize(CharacterNameG(who)) +
				" has taken the " + whatName + ".\n");
			fi;
		    fi;
		    succeed
		else
		    fail
		fi
	    else
		st
	    fi
	else
	    st
	fi
    fi
corp;

define tp_verbs proc getAllStub(thing object)bool:

    DoGet(Here(), Me(), object) ~= fail
corp;

define tp_verbs proc v_get(string what)bool:
    string verb, whatName;
    thing me, here, object;
    status st;

    verb := Verb();
    here := Here();
    me := Me();
    if what = "" then
	Print("You must specify what you want to " + Verb() + ".\n");
	false
    elif what == "inventory" and verb == "take" then
	v_inventory()
    elif what == "exit" and verb == "take" then
	v_exit()
    elif what == "entrance" and verb == "take" then
	v_enter()
    elif what == "up" and verb == "get" then
	v_standUp()
    elif what == "all" then
	st := DoAll(here@p_rContents, getAllStub);
	if st = fail then
	    Print("There are no obvious things here to get.\n");
	    false
	else
	    st = continue
	fi
    else
	whatName := FormatName(what);
	st := FindName(here@p_rContents, p_oName, what);
	if st = succeed then
	    object := FindResult();
	    DoGet(here, me, object) ~= fail
	elif st = continue then
	    Print(Capitalize(whatName) + " is ambiguous here.\n");
	    false
	else
	    if here@p_rBuyList ~= nil and
		FindName(here@p_rBuyList, p_oName, what) ~= fail
	    then
		Print("You should buy the " + whatName +
		    " before you take it.\n");
	    elif FindAgent(what) ~= nil then
		Print("You can't get " + whatName + ".\n");
	    else
		if FindName(me@p_pCarrying, p_oName, what) ~= fail then
		    Print("You are already carrying the " + whatName + ".\n");
		else
		    if MatchName(here@p_rScenery, what) ~= -1 then
			Print("You can't get the " + whatName + ".\n");
		    else
			Print(IsAre("There", "no", whatName, "here.\n"));
		    fi;
		fi;
	    fi;
	    false
	fi
    fi
corp;

Verb1(G, "pick", FindAnyWord(G, "up"), v_get)$
Verb1(G, "get", 0, v_get)$
Synonym(G, "get", "pickup")$
Synonym(G, "get", "take")$


/* this is public since it is used in the build code */

public proc public DoDrop(thing where, who, what)status:
    action a;
    string whatName;
    status st;

    /* NOTE: we do any object-specific stuff first. The mixture of the
       fighting stuff and the garbage room relies on this. */
    st := continue;
    a := what@p_oUnGetChecker;
    if a ~= nil then
	SetIt(what);
	st := call(a, status)(what);
    fi;
    if st = continue then
	a := what@p_oDropChecker;
	if a ~= nil then
	    SetIt(what);
	    st := call(a, status)(what);
	fi;
    fi;
    if st = continue then
	/* it wasn't a bomb that blew up or anything */
	st := DoRoomDropChecks(where, what);
	if st = continue then
	    /* nothing funny about dropping things here */
	    AddTail(where@p_rContents, what);
	    DelElement(who@p_pCarrying, what);
	    what -- p_oCarryer;
	    what@p_oWhere := where;
	    whatName := FormatName(what@p_oName);
	    SPrint(who, whatName + ": dropped.\n");
	    if CanSee(where, who) then
		if who@p_pHidden then
		    ABPrint(where, who, who, "The " + whatName +
			    " appears from nowhere and drops.\n");
		else
		    ABPrint(where, who, who,
			    Capitalize(CharacterNameG(who)) +
			    " has dropped the " + whatName + ".\n");
		fi;
	    fi;
	    continue
	else
	    st
	fi
    else
	st
    fi
corp;

define tp_verbs proc dropAllStub(thing object)bool:

    DoDrop(Here(), Me(), object) ~= fail
corp;

define tp_verbs proc v_drop(string what)bool:
    thing me, object;
    string whatName;
    status st;

    me := Me();
    if what = "" then
	Print("You must specify what you want to drop.\n");
	false
    elif what == "all" then
	st := DoAll(me@p_pCarrying, dropAllStub);
	if st = fail then
	    Print("You are not carrying anything obvious to drop.\n");
	    false
	else
	    st = continue
	fi
    else
	whatName := FormatName(what);
	st := FindName(me@p_pCarrying, p_oName, what);
	if st = succeed then
	    object := FindResult();
	    DoDrop(Here(), me, object) ~= fail
	elif st = continue then
	    Print(Capitalize(whatName) + " is ambiguous.\n");
	    false
	else
	    Print(AAn("You are not carrying", whatName) + ".\n");
	    false
	fi
    fi
corp;

Verb1(G, "put", FindAnyWord(G, "down"), v_drop)$
Verb1(G, "drop", 0, v_drop)$


/* the fancy Verb2 ones */

define tp_verbs proc v_give(string what, toWho)bool:
    string whatName, whoName, myName;
    status st;
    thing me, here, item, who;
    action a;
    character ch;
    int len;

    whatName := FormatName(what);
    whoName := FormatName(toWho);
    me := Me();
    here := Here();
    myName := Capitalize(CharacterNameS(me));
    who := FindAgent(toWho);
    if who = me then
	Print("There is no point in giving to yourself.\n");
	false
    elif who = nil then
	if MatchName(here@p_rScenery, toWho) ~= -1 then
	    Print("You can't give things to the scenery!\n");
	else
	    Print(whoName + " is not here!\n");
	fi;
	false
    elif Count(who@p_pCarrying) >= MAX_CARRY then
	Print(whoName + " can't carry anything else.\n");
	false
    else
	st := FindName(me@p_pCarrying, p_oName, what);
	if st = succeed then
	    item := FindResult();
	    SetIt(item);
	    st := continue;
	    a := item@p_oUnGetChecker;
	    if a ~= nil then
		st := call(a, status)(item);
	    fi;
	    if st = continue then
		a := who@p_pGivePre;
		if a ~= nil then
		    st := ForceAction(who, a);
		fi;
	    fi;
	    if st = continue then
		a := item@p_oGiveChecker;
		if a ~= nil then
		    st := call(a, status)(who);
		fi;
	    fi;
	    if st = continue then
		a := who@p_pGivePost;
		if a ~= nil then
		    st := ForceAction(who, a);
		fi;
	    fi;
	    if st = continue then
		/* cannot use CarryItem here - wrong person is running */
		whatName := FormatName(item@p_oName);
		AddTail(who@p_pCarrying, item);
		DelElement(me@p_pCarrying, item);
		item@p_oCarryer := who;
		ch := ThingCharacter(who);
		if item@p_oCreator = me and ch ~= nil then
		    item@p_oCreator := who;
		fi;
		if Owner(item) = MeCharacter() then
		    if ch = nil then
			ch := SysAdmin;
		    fi;
		    GiveThing(item, ch);
		fi;
		Print("You give the " + whatName + " to " + whoName + ".\n");
		if not me@p_pHidden and CanSee(here, who) then
		    SPrint(who, AAn(myName + " gives you", whatName) + ".\n");
		    ABPrint(here, me, who, AAn(myName + " gives", whatName) +
			" to " + whoName + ".\n");
		else
		    SPrint(who, AAn("Someone gives you", whatName) + ".\n");
		fi;
		true
	    else
		st = succeed
	    fi
	elif st = continue then
	    Print(Capitalize(whatName) + " is ambiguous.\n");
	    false
	else
	    if SubString(what, 0, 5) == "bluto" then
		len := Length(what) - 5;
		what := SubString(what, 5, len);
		if SubString(what, 0, 1) == "s" then
		    len := len - 1;
		    what := SubString(what, 1, len);
		fi;
		if SubString(what, 0, 1) == ";" then
		    len := len - 1;
		    what := SubString(what, 1, len);
		fi;
		if len = 0 then
		    Print("You must say how many blutos to give.\n");
		    false
		else
		    len := StringToInt(what);
		    if len < 0 then
			Print("Invalid bluto count.\n");
			false
		    else
			if len > me@p_pMoney then
			    Print("You don't have that many!\n");
			    false
			else
			    if not me@p_pHidden and CanSee(here, who) then
				if len = 1 then
				    Print("You give one bluto to " +
					whoName + ".\n");
				    SPrint(who, myName +
					" gives you one bluto.\n");
				else
				    Print("You give " + IntToString(len) +
					" blutos to " + whoName + ".\n");
				    SPrint(who, myName + " gives you " +
					IntToString(len) + " blutos.\n");
				fi;
				ABPrint(here, me, who,
				    " gives some blutos to " + whoName +
				    ".\n");
			    else
				if len = 1 then
				    SPrint(who,
					"Someone gives you one bluto.\n");
				else
				    SPrint(who, "Someone gives you " +
					IntToString(len) + " blutos.\n");
				fi;
			    fi;
			    me@p_pMoney := me@p_pMoney - len;
			    who@p_pMoney := who@p_pMoney + len;
			    true
			fi
		    fi
		fi
	    else
		Print(AAn("You are not carrying", whatName) + ".\n");
		false
	    fi
	fi
    fi
corp;

Verb2(G, "give", FindAnyWord(G, "to"), v_give)$
Synonym(G, "give", "donate")$
Synonym(G, "give", "grant")$


define tp_verbs proc v_putIn(string itemRaw, containerRaw)bool:
    string itemName, containerName;
    thing me, here, item, container;
    status st;
    list thing lt;
    action a;

    itemName := FormatName(itemRaw);
    containerName := FormatName(containerRaw);
    me := Me();
    st := FindName(me@p_pCarrying, p_oName, itemRaw);
    if st = fail then
	Print(AAn("You aren't carrying", itemName) + ".\n");
	false
    elif st = continue then
	Print(Capitalize(itemName) + " is ambiguous.\n");
	false
    else
	item := FindResult();
	itemName := FormatName(item@p_oName);
	st := FindName(me@p_pCarrying, p_oName, containerRaw);
	if st = fail then
	    st := FindName(Here()@p_rContents, p_oName, containerRaw);
	fi;
	if st = fail then
	    here := Here();
	    if here@p_rBuyList ~= nil and
		FindName(here@p_rBuyList, p_oName, containerRaw) ~= fail
	    then
		Print("You should buy the " + containerName +
		    " before you try to put things into it.\n");
	    elif MatchName(here@p_rScenery, containerRaw) ~= -1 then
		Print("You can't put things into the " +containerName + ".\n");
	    else
		Print("There is no " + containerName + " here.\n");
	    fi;
	    false
	elif st = continue then
	    Print(Capitalize(containerName) + " is ambiguous.\n");
	    false
	else
	    container := FindResult();
	    containerName := FormatName(container@p_oName);
	    lt := container@p_oContents;
	    if lt = nil then
		Print("You can't put things into the " +containerName + ".\n");
		false
	    elif item = container then
		Print("You can't put the " + itemName + " into itself!\n");
		false
	    else
		st := continue;
		a := item@p_oUnGetChecker;
		if a ~= nil then
		    st := call(a, status)(item);
		fi;
		if st = continue then
		    a := item@p_oPutMeInChecker;
		    if a ~= nil then
			st := call(a, status)(item, container);
		    fi;
		fi;
		if st = continue then
		    a := container@p_oPutInMeChecker;
		    if a ~= nil then
			st := call(a, status)(item, container);
		    elif Count(lt) >= container@p_oCapacity then
			Print("There is no room in the " + containerName +
			    " for the " + itemName + ".\n");
			st := fail;
		    fi;
		fi;
		if st = continue then
		    AddTail(lt, item);
		    DelElement(me@p_pCarrying, item);
		    item -- p_oCarryer;
		    item@p_oWhere := container;
		    Print("You put the " + itemName + " into the " +
			containerName + ".\n");
		    true
		else
		    st ~= fail
		fi
	    fi
	fi
    fi
corp;

define tp_verbs proc v_takeFrom(string itemRaw, containerRaw)bool:
    string itemName, containerName;
    thing me, here, item, container;
    status st;
    list thing lt;
    action a;

    itemName := FormatName(itemRaw);
    containerName := FormatName(containerRaw);
    me := Me();
    st := FindName(me@p_pCarrying, p_oName, containerRaw);
    if st = fail then
	st := FindName(Here()@p_rContents, p_oName, containerRaw);
    fi;
    if st = fail then
	here := Here();
	if here@p_rBuyList ~= nil and
	    FindName(here@p_rBuyList, p_oName, containerRaw) ~= fail
	then
	    Print("You should buy the " + containerName +
		" before you try to take things from it.\n");
	elif MatchName(here@p_rScenery, containerRaw) ~= -1 then
	    Print("You can't take things from the " + containerName + ".\n");
	else
	    Print("There is no " + containerName + " here.\n");
	fi;
	false
    elif st = continue then
	Print(Capitalize(containerName) + " is ambiguous.\n");
	false
    else
	container := FindResult();
	containerName := FormatName(container@p_oName);
	lt := container@p_oContents;
	if lt = nil then
	    Print("There is nothing in the " + containerName + ".\n");
	    false
	else
	    st := FindName(container@p_oContents, p_oName, itemRaw);
	    if st = fail then
		Print("There is no " + itemName + " in the " + containerName +
		    ".\n");
		false
	    elif st = continue then
		Print(Capitalize(itemName) + " is ambiguous.\n");
		false
	    elif Count(me@p_pCarrying) >= MAX_CARRY then
		Print("You can't carry anything else.\n");
		false
	    else
		item := FindResult();
		itemName := FormatName(item@p_oName);
		st := continue;
		a := item@p_oTakeMeFromChecker;
		if a ~= nil then
		    st := call(a, status)(item, container);
		fi;
		if st = continue then
		    a := container@p_oTakeFromMeChecker;
		    if a ~= nil then
			st := call(a, status)(item, container);
		    fi;
		fi;
		if st = continue then
		    a := item@p_oGetChecker;
		    if a ~= nil then
			st := call(a, status)(item);
		    fi;
		fi;
		if st = continue then
		    AddTail(me@p_pCarrying, item);
		    DelElement(container@p_oContents, item);
		    item -- p_oWhere;
		    item@p_oCarryer := me;
		    Print("You take the " + itemName + " from the " +
			containerName + ".\n");
		    true
		else
		    st ~= fail
		fi
	    fi
	fi
    fi
corp;

define tp_verbs proc v_lookIn(string containerRaw)bool:
    string containerName;
    thing me, here, container;
    status st;
    list thing lt;
    string str;
    action a;

    if containerRaw = "" then
	Print("You must specify what you want to look in.\n");
	false
    else
	me := Me();
	here := Here();
	containerName := FormatName(containerRaw);
	st := FindName(me@p_pCarrying, p_oName, containerRaw);
	if st = fail then
	    st := FindName(here@p_rContents, p_oName, containerRaw);
	fi;
	if st = fail then
	    if here@p_rBuyList ~= nil and
		FindName(here@p_rBuyList, p_oName, containerRaw) ~= fail
	    then
		Print("You should buy the " + containerName + " first.\n");
	    elif MatchName(here@p_rScenery, containerRaw) ~= -1 then
		if not CanSee(here, me) then
		    Print("It is dark.\n");
		else
		    Print("There is nothing to see in the " + containerName +
			".\n");
		fi;
	    else
		Print("There is no " + containerName + " here.\n");
	    fi;
	    false
	elif st = continue then
	    Print(Capitalize(containerName) + " is ambiguous.\n");
	    false
	else
	    /* do this BEFORE calling CanSee! */
	    container := FindResult();
	    if not CanSee(here, me) then
		Print("It is dark.\n");
		false
	    else
		containerName := FormatName(container@p_oName);
		lt := container@p_oContents;
		if lt = nil then
		    str := container@p_oLookInString;
		    if str ~= "" then
			Print(str + "\n");
			true
		    else
			a := container@p_oLookInAction;
			if a ~= nil then
			    Print(call(a, string)(container) + "\n");
			    true
			else
			    Print("There is nothing in the " +
				containerName + ".\n");
			    false
			fi
		    fi
		else
		    if ShowList(lt, "The " + containerName + " contains:\n")
		    then
			Print("The " + containerName + " is empty.\n");
		    fi;
		    true
		fi
	    fi
	fi
    fi
corp;

define tp_verbs proc v_insert0(string what)bool:

    Print("You must say what you want to insert the " + FormatName(what) +
	" into.\n");
    false
corp;

Verb2(G, "put", FindAnyWord(G, "in"), v_putIn)$
Verb2(G, "put", FindAnyWord(G, "on"), v_putIn)$
/* Need to do separate verb for "insert", rather than making it a
   synonym of "put", since you cannot have something be both a synonym
   and a verb in its own right. */
Verb1(G, "insert", 0, v_insert0)$
Verb2(G, "insert", FindAnyWord(G, "in"), v_putIn)$
Verb2(G, "get", FindAnyWord(G, "from"), v_takeFrom)$
Verb2(G, "remove", FindAnyWord(G, "from"), v_takeFrom)$
/* get will use synonyms for the other 'get' */
Verb1(G, "look", FindAnyWord(G, "in"), v_lookIn)$


define tp_verbs proc v_fillFrom(string containerRaw, itemRaw)bool:
    string itemName, containerName;
    thing me, here, item, container;
    status st;
    action a;

    containerName := FormatName(containerRaw);
    itemName := FormatName(itemRaw);
    me := Me();
    st := FindName(me@p_pCarrying, p_oName, containerRaw);
    if st = fail then
	Print(AAn("You aren't carrying", containerName) + ".\n");
	false
    elif st = continue then
	Print(Capitalize(containerName) + " is ambiguous.\n");
	false
    else
	container := FindResult();
	containerName := FormatName(container@p_oName);
	st := FindName(me@p_pCarrying, p_oName, itemRaw);
	if st = fail then
	    st := FindName(Here()@p_rContents, p_oName, itemRaw);
	fi;
	if st = fail then
	    here := Here();
	    if here@p_rBuyList ~= nil and
		FindName(here@p_rBuyList, p_oName, itemRaw) ~= fail
	    then
		Print("You should buy the " + itemName +
		    " before you try to put it into something.\n");
	    elif MatchName(here@p_rScenery, itemRaw) ~= -1 then
		Print("You can't fill the " + containerName + " from the " +
		    itemName + ".\n");
	    else
		Print("There is no " + itemName + " here.\n");
	    fi;
	    false
	elif st = continue then
	    Print(Capitalize(itemName) + " is ambiguous.\n");
	    false
	else
	    item := FindResult();
	    itemName := FormatName(item@p_oName);
	    a := container@p_oFillMeWithChecker;
	    if a = nil then
		Print("You can't fill the " + containerName + ".\n");
		false
	    elif item = container then
		Print("You can't fill the " + itemName + " from itself!\n");
		false
	    else
		st := call(a, status)(container, item);
		if st = continue then
		    a := item@p_oFillWithMeChecker;
		    if a ~= nil then
			st := call(a, status)(container, item);
		    fi;
		fi;
		if st = continue then
		    Print("You fill the " + containerName + " from the " +
			itemName + ".\n");
		    true
		elif st = fail then
		    Print("You can't fill the " + containerName +
			" from the " + itemName + ".\n");
		    false
		else
		    true
		fi
	    fi
	fi
    fi
corp;

Verb2(G, "fill", FindAnyWord(G, "from"), v_fillFrom)$
Verb2(G, "fill", FindAnyWord(G, "with"), v_fillFrom)$

define tp_verbs proc v_empty(string containerRaw)bool:
    string containerName;
    thing me, container;
    status st;
    action a;

    containerName := FormatName(containerRaw);
    me := Me();
    st := FindName(me@p_pCarrying, p_oName, containerRaw);
    if st = fail then
	Print(AAn("You aren't carrying", containerName) + ".\n");
	false
    elif st = continue then
	Print(Capitalize(containerName) + " is ambiguous.\n");
	false
    else
	container := FindResult();
	containerName := FormatName(container@p_oName);
	a := container@p_oEmptyChecker;
	if a = nil then
	    if container@p_oContents ~= nil then
		Print("Empty the " + containerName +
		    " by taking things out of it.\n");
	    else
		Print("You can't empty the " + containerName + ".\n");
	    fi;
	    false
	else
	    st := call(a, status)(container);
	    if st = continue then
		Print("You empty the " + containerName + ".\n");
		true
	    elif st = fail then
		Print("You can't empty the " + containerName + ".\n");
		false
	    else
		true
	    fi
	fi
    fi
corp;

Verb1(G, "empty", 0, v_empty)$


define tp_verbs proc v_unlock(string lockRaw, keyRaw)bool:
    string keyName, lockName, str;
    thing me, here, key, lock;
    status st;
    list thing lt;
    action a;

    lockName := FormatName(lockRaw);
    keyName := FormatName(keyRaw);
    me := Me();
    here := Here();
    st := FindName(here@p_rContents, p_oName, lockRaw);
    if st = fail then
	st := FindName(me@p_pCarrying, p_oName, lockRaw);
    fi;
    if st = fail then
	if here@p_rBuyList ~= nil and
	    FindName(here@p_rBuyList, p_oName, lockRaw) ~= fail
	then
	    Print("You should buy the " + lockName +
		" before you try to unlock it.\n");
	elif MatchName(here@p_rScenery, lockRaw) ~= -1 then
	    Print("You can't unlock the " + lockName + ".\n");
	else
	    Print("There is no " + lockName + " here.\n");
	fi;
	false
    elif st = continue then
	Print(Capitalize(lockName) + " is ambiguous.\n");
	false
    else
	lock := FindResult();
	lockName := FormatName(lock@p_oName);
	if lock@p_oNotLockable then
	    Print("You can't unlock the " + lockName + ".\n");
	    false
	else
	    st := FindName(me@p_pCarrying, p_oName, keyRaw);
	    if st = fail then
		Print(AAn("You aren't carrying", keyName) + ".\n");
		false
	    elif st = continue then
		Print(Capitalize(keyName) + " is ambiguous.\n");
		false
	    else
		key := FindResult();
		keyName := FormatName(key@p_oName);
		a := lock@p_oUnlockMeWithChecker;
		if a = nil then
		    if lock@p_oNotUnlockString ~= "" then
			Print(lock@p_oNotUnlockString + "\n");
		    else
			Print("You can't unlock the " + lockName + ".\n");
		    fi;
		    false
		elif key = lock then
		    Print("You can't unlock the " + lockName +
			" with itself!\n");
		    false
		else
		    st := call(a, status)(lock, key);
		    if st = continue then
			a := key@p_oUnlockWithMeChecker;
			if a ~= nil then
			    st := call(a, status)(lock, key);
			fi;
		    fi;
		    if st = continue then
			if lock@p_oLocked then
			    Print("You unlock the " + lockName + " with the " +
				keyName + ".\n");
			    lock@p_oLocked := false;
			    true
			else
			    Print("The " + lockName+" is already unlocked.\n");
			    false
			fi
		    elif st = fail then
			Print("You can't unlock the " + lockName +
			    " with the " + keyName + ".\n");
			false
		    else
			true
		    fi
		fi
	    fi
	fi
    fi
corp;

Verb2(G, "unlock", FindAnyWord(G, "with"), v_unlock)$

define tp_verbs proc v_lock(string lockRaw, keyRaw)bool:
    string keyName, lockName, str;
    thing me, here, key, lock;
    status st;
    list thing lt;
    action a;

    lockName := FormatName(lockRaw);
    keyName := FormatName(keyRaw);
    me := Me();
    here := Here();
    st := FindName(here@p_rContents, p_oName, lockRaw);
    if st = fail then
	st := FindName(me@p_pCarrying, p_oName, lockRaw);
    fi;
    if st = fail then
	if here@p_rBuyList ~= nil and
	    FindName(here@p_rBuyList, p_oName, lockRaw) ~= fail
	then
	    Print("You should buy the " + lockName +
		" before you try to lock it.\n");
	elif MatchName(here@p_rScenery, lockRaw) ~= -1 then
	    Print("You can't lock the " + lockName + ".\n");
	else
	    Print("There is no " + lockName + " here.\n");
	fi;
	false
    elif st = continue then
	Print(Capitalize(lockName) + " is ambiguous.\n");
	false
    else
	lock := FindResult();
	lockName := FormatName(lock@p_oName);
	if lock@p_oNotLockable then
	    Print("You can't lock the " + lockName + ".\n");
	    false
	else
	    st := FindName(me@p_pCarrying, p_oName, keyRaw);
	    if st = fail then
		Print(AAn("You aren't carrying", keyName) + ".\n");
		false
	    elif st = continue then
		Print(Capitalize(keyName) + " is ambiguous.\n");
		false
	    else
		key := FindResult();
		keyName := FormatName(key@p_oName);
		a := lock@p_oLockMeWithChecker;
		if a = nil then
		    if lock@p_oNotLockString ~= "" then
			Print(lock@p_oNotLockString + "\n");
		    else
			Print("You can't lock the " + lockName + ".\n");
		    fi;
		    false
		elif key = lock then
		    Print("You can't lock the " + lockName +
			" with itself!\n");
		    false
		else
		    st := call(a, status)(lock, key);
		    if st = continue then
			a := key@p_oLockWithMeChecker;
			if a ~= nil then
			    st := call(a, status)(lock, key);
			fi;
		    fi;
		    if st = continue then
			if lock@p_oLocked then
			    Print("The " + lockName + " is already locked.\n");
			    false
			else
			    Print("You lock the " + lockName + " with the " +
				keyName + ".\n");
			    lock@p_oLocked := true;
			    true
			fi
		    elif st = fail then
			Print("You can't lock the " + lockName +
			    " with the " + keyName + ".\n");
			false
		    else
			true
		    fi
		fi
	    fi
	fi
    fi
corp;

Verb2(G, "lock", FindAnyWord(G, "with"), v_lock)$

/* create some stuff to test the above */

/*
define tp_verbs o_testLock1 CreateThing(nil)$
SetupObject(o_testLock1, r_arrivals, "lock;red,test",
    "Use a test key to lock and unlock this lock.\n")$
o_testLock1@p_oNotGettable := true$
o_testLock1@p_oLocked := true$
define tp_verbs o_testLock2 CreateThing(nil)$
SetupObject(o_testLock2, r_arrivals, "lock;blue,test",
    "Use a test key to lock and unlock this lock.\n")$
o_testLock2@p_oNotGettable := true$
o_testLock2@p_oLocked := true$
define tp_verbs o_testKey1 CreateThing(nil)$
SetupObject(o_testKey1, r_arrivals, "key;yellow,test",
    "Use this key to lock and unlock a test lock.")$
define tp_verbs o_testKey2 CreateThing(nil)$
SetupObject(o_testKey2, r_arrivals, "key;green,test",
    "Use this key to lock and unlock a test lock.")$
define tp_verbs proc checkTestLock(thing theLock, theKey)status:
    if theLock = o_testLock1 and theKey = o_testKey1 then
	continue
    elif theLock = o_testLock2 and theKey = o_testKey2 then
	continue
    else
	fail
    fi
corp;
o_testLock1@p_oUnlockMeWithChecker := checkTestLock$
o_testLock1@p_oLockMeWithChecker := checkTestLock$
o_testLock2@p_oUnlockMeWithChecker := checkTestLock$
o_testLock2@p_oLockMeWithChecker := checkTestLock$
define tp_verbs o_otherKey CreateThing(nil)$
SetupObject(o_otherKey, r_arrivals, "key;other", "This key doesn't work.")$
define tp_verbs o_testGizmo CreateThing(nil)$
SetupObject(o_testGizmo, r_arrivals, "gizmo;test",
    "This gizmo cannot be locked or unlocked.")$
o_testGizmo@p_oNotGettable := true$
o_testGizmo@p_oNotLockable := true$
define tp_verbs o_testThingy CreateThing(nil)$
SetupObject(o_testThingy, r_arrivals, "thingy;test",
    "This thingy refuses to be unlocked or locked.")$
o_testThingy@p_oNotGettable := true$
o_testThingy@p_oNotUnlockString :=
    "No matter how hard you try, or what you try with, you cannot manage "
    "to unlock this thingy."$
o_testThingy@p_oNotLockString :=
    "There is nothing that looks even vaguely like a lock on the thingy, "
    "so there is no way you can lock it."$
*/


define tp_verbs proc v_follow(string name)bool:
    thing me, who;

    me := Me();
    if name = "" then
	who := me@p_pFollowing;
	if who ~= nil then
	    name := CharacterNameG(who);
	    Print("You are currently following " + name + ".\n");
	    true
	else
	    Print("You must specify who you want to follow.\n");
	    Print("Use 'unfollow', or just move, to stop following.\n");
	    false
	fi
    else
	who := FindAgent(name);
	name := FormatName(name);
	if who = me then
	    Print("You can't follow yourself.\n");
	    false
	elif who = nil then
	    if MatchName(Here()@p_rScenery, name) ~= -1 then
		Print("You can't follow the scenery!\n");
	    else
		Print(name + " is not here!\n");
	    fi;
	    false
	else
	    UnFollow();
	    Follow(who);
	    Print("You are now following " + name + ".\n");
	    true
	fi
    fi
corp;

Verb1(G, "follow", 0, v_follow)$

define tp_verbs proc v_unfollow()bool:

    if Me()@p_pFollowing = nil then
	Print("You are not following anyone.\n");
	false
    else
	UnFollow();
	true
    fi
corp;

Verb0(G, "unfollow", 0, v_unfollow)$


/* a few utility-type commands */

define tp_verbs proc v_time()bool:
    Print("The time and date at the server is: " + Date() + ".\n");
    true
corp;

Verb0(G, "time", 0, v_time)$
Verb0(G, "date", 0, v_time)$

define tp_verbs proc v_verbose()bool:
    thing me;

    me := Me();
    if me@p_pVerbose then
	Print("You are already getting verbose descriptions!\n");
	false
    else
	me@p_pVerbose := true;
	me@p_pSuperBrief := false;
	Print("Verbose desciptions turned on.\n");
	true
    fi
corp;

Verb0(G, "verbose", 0, v_verbose)$

define tp_verbs proc v_terse()bool:
    thing me;

    me := Me();
    if me@p_pSuperBrief then
	me@p_pSuperBrief := false;
	Print("Superterse mode turned off.\n");
	true
    elif me@p_pVerbose then
	me@p_pVerbose := false;
	Print("Verbose descriptions turned off.\n");
	true
    else
	Print("You are already in terse mode!\n");
	false
    fi
corp;

Verb0(G, "terse", 0, v_terse)$
Synonym(G, "terse", "brief")$

define tp_verbs proc v_superterse()bool:
    thing me;

    me := Me();
    if me@p_pSuperBrief then
	Print("You are already in superterse mode!\n");
	false
    else
	me@p_pVerbose := false;
	me@p_pSuperBrief := true;
	Print("Superterse mode enabled.\n");
	true
    fi
corp;

Verb0(G, "superterse", 0, v_superterse)$
Synonym(G, "superterse", "superbrief")$

define tp_verbs proc v_echo()bool:
    thing me;

    me := Me();
    if me@p_pEchoPose then
	me@p_pEchoPose := false;
	Print("Say/whisper/pose/emits will no longer be echoed to you.\n");
    else
	me@p_pEchoPose := true;
	Print("Say/whisper/pose/emits will now be echoed to you.\n");
    fi;
    true
corp;

Verb0(G, "echo", 0, v_echo)$

define tp_verbs proc v_ats()bool:
    bool oldValue;

    oldValue := PrintNoAts(true);
    if oldValue then
	Print("Non-wizard output will now be identified by leading '@'s.\n");
	ignore PrintNoAts(false);
    else
	Print(
"Non-wizard output will no longer be identified by leading '@'s. You are "
"warned that unscrupulous apprentices may attempt to trick you by printing "
"false messages indistinguishable from normal messages. E.g.\n\n"
"SysAdmin gives you 10000 blutos.\n\n"
"Beware of this type of \"spoofing\".\n");
	ignore PrintNoAts(true);
    fi;
    true
corp;

Verb0(G, "ats", 0, v_ats)$

define tp_verbs proc v_wizard()bool:
    if not WizardMode() then
	Print("Sorry, you can't go into wizard mode.\n");
	false
    else
	true
    fi
corp;

Verb0(G, "wizard", 0, v_wizard)$

define tp_verbs proc v_hide()bool:
    thing me;

    me := Me();
    if IsWizard() then
	if me@p_pHidden then
	    Print("You are now visible to others.\n");
	    me@p_pHidden := false;
	    OPrint(Capitalize(CharacterNameS(me)) + " fades into view.\n");
	    ForEachAgent(Here(), ShowIconOnce);
	else
	    Print("You are no longer visible to others.\n");
	    me@p_pHidden := true;
	    OPrint(Capitalize(CharacterNameS(me)) + " fades out of view.\n");
	    ForEachAgent(Here(), UnShowIconOnce);
	    ClearFollowers(me);
	fi;
	true
    else
	Print("Hide? This isn't a game of hide and seek!\n");
	false
    fi
corp;

Verb0(G, "hide", 0, v_hide)$

define tp_verbs proc v_password()bool:
    NewCharacterPassword();
    true
corp;

Verb0(G, "password", 0, v_password)$

define tp_verbs proc v_prompt()bool:
    string w;

    w := GetWord();
    Print("Setting prompt to " + w + ".\n");
    ignore SetPrompt(w);
    true
corp;

VerbTail(G, "prompt", v_prompt)$

define tp_verbs proc v_name(string newName)bool:
    thing me;
    string oldName, desc;
    int len;

    me := Me();
    if Character(me@p_pName) = nil then
	OPrint(Capitalize(CharacterNameS(me)) + " is confused.\n");
	false
    elif newName = "" then
	Print("You must give the new name you want to use.\n");
	false
    else
	SetTail(newName);
	ignore GetWord();
	if GetWord() ~= "" then
	    Print("Sorry, no spaces in character names.\n");
	    false
	elif Character(newName) ~= nil then
	    Print("Sorry, character name '" + newName +
		"' is already in use.\n");
	    false
	else
	    oldName := Capitalize(me@p_pName);
	    ChangeName(newName);
	    Print("Your name is now " + newName + ".\n");
	    APrint(oldName + " is now called " + newName + ".\n");
	    desc := me@p_pDesc;
	    len := Length(oldName);
	    if SubString(desc, 0, len) == oldName then
		me@p_pDesc := Capitalize(newName) +
		    SubString(desc, len, Length(desc) - len);
	    fi;
	    true
	fi
    fi
corp;

Verb1(G, "name", 0, v_name)$

/*
 * v_say - handler for speaking. Attempt to catch the likely forms.
 *	say hello => hello
 *	say to fred hello => fred hello
 *	tell joe to blah blah => joe blah blah
 */

define tp_verbs proc v_say()bool:
    string word1, word2, tail;

    word1 := GetWord();
    if word1 = "" then
	Print("Put what you want to say after the 'say'.\n");
    else
	word2 := GetWord();
	tail := GetTail();
	if word2 == "to" then
	    if tail = "" then
		DoSay(word1);
	    else
		DoSay(word1 + " " + tail);
	    fi;
	else
	    if tail = "" then
		if word2 = "" then
		    DoSay(word1);
		else
		    DoSay(word1 + " " + word2);
		fi;
	    else
		DoSay(word1 + " " + word2 + " " + tail);
	    fi;
	fi;
    fi;
    true
corp;

VerbTail(G, "say", v_say)$
Synonym(G, "say", "\"")$
Synonym(G, "say", "tell")$

/*
 * showAliases - used in 'v_alias' and in v_aliases.
 */

define tp_verbs proc showAliases(list thing aliases)void:
    thing alias;
    int count;

    if aliases = nil then
	Print("You have no command aliases.\n");
    else
	count := Count(aliases);
	Print("Command aliases:\n");
	while count ~= 0 do
	    count := count - 1;
	    alias := aliases[count];
	    Print("  ");
	    Print(alias@p_sAliasKey);
	    Print(" => ");
	    Print(alias@p_sAliasValue);
	    Print("\n");
	od;
    fi;
corp;

define tp_verbs proc v_aliases()bool:

    showAliases(Me()@p_pAliases);
    true
corp;

define tp_verbs proc v_alias()bool:
    list thing aliases;
    thing alias;
    string word, contents;
    int count;
    bool found;

    word := GetWord();
    aliases := Me()@p_pAliases;
    if word = "" then
	showAliases(aliases);
    else
	Print("Command alias '");
	Print(word);
	Print("' ");
	found := false;
	if aliases ~= nil then
	    count := Count(aliases);
	    while count ~= 0 and not found do
		count := count - 1;
		alias := aliases[count];
		if alias@p_sAliasKey == word then
		    found := true;
		fi;
	    od;
	fi;
	contents := GetTail();
	if contents = "" then
	    if found then
		DelElement(aliases, alias);
		Print("removed.\n");
	    else
		Print("does not exist.\n");
	    fi;
	else
	    if SubString(contents, 0, 1) = "\"" then
		contents := SubString(contents, 1, Length(contents) - 2);
	    fi;
	    if found then
		alias@p_sAliasValue := contents;
		Print("updated.\n");
	    else
		if aliases = nil then
		    aliases := CreateThingList();
		    Me()@p_pAliases := aliases;
		fi;
		alias := CreateThing(nil);
		alias@p_sAliasKey := word;
		alias@p_sAliasValue := contents;
		AddTail(aliases, alias);
		Print("added.\n");
	    fi;
	fi;
    fi;
    true
corp;

Verb0(G, "aliases", 0, v_aliases)$
VerbTail(G, "alias", v_alias)$
Synonym(G, "alias", "a")$


define tp_verbs proc DoBackup(thing obj)void:

    /* We want to schedule the next backup before we actually do this one,
       so that the timekeeper will have us on its list in the backup! */
    if GlobalThing@p_BackupInterval ~= 0 then
	DoAfter(GlobalThing@p_BackupInterval * 60, GlobalThing, DoBackup);
    fi;
    if GlobalThing@p_FlushNeeded then
	/* clear flag *before* doing backup, so are clean after restore */
	GlobalThing@p_FlushNeeded := false;
	Log("Starting automatic backup, interval = " +
	    IntToString(GlobalThing@p_BackupInterval) + " minutes\n");
	APrint("\n * Timed database backup starting - please wait. *\n");
	Flush();
	Execute("copy MUD.#? backup");
	APrint(" * Backup complete. *\n\n");
    fi;
corp;

define tp_verbs proc v_backup(string arg)bool:
    int n;

    if Me() ~= CharacterThing(SysAdmin) then
	Print("Only SysAdmin can use the 'backup' command.\n");
	false
    else
	if arg = "" then
	    /* do it unconditionally */
	    Print("Doing one-shot backup.\n");
	    APrint("\n * Database being backed up - please wait. *\n");
	    Flush();
	    Execute("copy MUD.#? backup");
	    APrint(" * Backup complete. *\n\n");
	    true
	else
	    n := StringToInt(arg);
	    if n = 0 then
		GlobalThing@p_BackupInterval := 0;
		ignore CancelDoAfter(GlobalThing, DoBackup);
		Print("Automated backups cancelled.\n");
		true
	    elif n > 0 then
		if n > 0x7fffffff / 60 then
		    n := 0x7fffffff / 60;
		fi;
		GlobalThing@p_BackupInterval := n;
		Print("Backup interval set to " + IntToString(n) +
		    " minutes.\n");
		ignore CancelDoAfter(GlobalThing, DoBackup);
		DoAfter(n * 60, GlobalThing, DoBackup);
		Print("Next backup will occur that interval from now.\n");
		true
	    else
		Print("Expecting minute count with 'backup'.\n");
		false
	    fi
	fi
    fi
corp;

Verb1(G, "backup", 0, v_backup)$


define tp_verbs proc v_shutdown()bool:
    string message, m;

    if Me() ~= CharacterThing(SysAdmin) then
	Print("Only SysAdmin can use the 'shutdown' command.\n");
	false
    else
	message := "\n\n**** ";
	m := GetTail();
	if m ~= "" then
	    message := message + m + "\n";
	fi;
	message := message +
	    "SysAdmin has started shutdown of the MUD. ****\n\n\n";
	APrint(message);
	ignore ShutDown(true);
	true
    fi
corp;

VerbTail(G, "shutdown", v_shutdown)$


define tp_verbs proc v_freeposes()bool:
    string errorMessage, yesNo;

    if Me() ~= CharacterThing(SysAdmin) then
	Print("Only SysAdmin can use the 'freeposes' command.\n");
	false
    else
	yesNo := GetWord();
	if yesNo = "" then
	    yesNo := "y";
	fi;
	errorMessage := "Use is: freeposes [y|n]\n";
	if GetWord() ~= "" then
	    Print(errorMessage);
	    false
	elif isYes(yesNo) then
	    GlobalThing@p_FreePoses := true;
	    Print("Free user poses enabled.\n");
	    true
	elif isNo(yesNo) then
	    GlobalThing@p_FreePoses := false;
	    Print("Free user poses disabled.\n");
	    true
	else
	    Print(errorMessage);
	    false
	fi
    fi
corp;

define tp_verbs proc v_freebuilding()bool:
    string errorMessage, yesNo;

    if Me() ~= CharacterThing(SysAdmin) then
	Print("Only SysAdmin can use the 'freebuilding' command.\n");
	false
    else
	yesNo := GetWord();
	if yesNo = "" then
	    yesNo := "y";
	fi;
	errorMessage := "Use is: freebuilding [y|n]\n";
	if GetWord() ~= "" then
	    Print(errorMessage);
	    false
	elif isYes(yesNo) then
	    GlobalThing@p_FreeBuilding := true;
	    Print("All new characters will now be builders.\n");
	    true
	elif isNo(yesNo) then
	    GlobalThing@p_FreeBuilding := false;
	    Print("New characters will no longer be builders.\n");
	    true
	else
	    Print(errorMessage);
	    false
	fi
    fi
corp;

define tp_verbs proc v_makeapprentice()bool:
    string name;
    character who;

    if Me() ~= CharacterThing(SysAdmin) then
	Print("Only SysAdmin can use the 'makeapprentice' command.\n");
	false
    else
	name := GetWord();
	if name = "" or GetWord() ~= "" then
	    Print("Use is: makeapprentice <player-name>\n");
	    false
	else
	    who := Character(name);
	    if who = nil then
		Print("'" + name + "' is not a character.\n");
		false
	    else
		MakeApprentice(who, false);
		Print("'" + name + "' is now an apprentice.\n");
		true
	    fi
	fi
    fi
corp;

VerbTail(G, "freeposes", v_freeposes)$
VerbTail(G, "freebuilding", v_freebuilding)$
VerbTail(G, "makeapprentice", v_makeapprentice)$


define tp_verbs proc v_characters(string form)bool:

    if form == "long" or form == "l" then
	ignore ShowCharacters(true);
	true
    elif form = "" or form == "short" or form == "s" then
	ignore ShowCharacters(false);
	true
    else
	Print("You must use either \"short\" or \"long\".\n");
	false
    fi
corp;

Verb1(G, "characters", 0, v_characters)$
Synonym(G, "characters", "chars")$
Synonym(G, "characters", "ch")$
Synonym(G, "characters", "players")$
Synonym(G, "characters", "pl")$

define tp_verbs proc v_clients(string form)bool:

    if form == "long" or form == "l" then
	ignore ShowClients(true);
	true
    elif form = "" or form == "short" or form == "s" then
	ignore ShowClients(false);
	true
    else
	Print("You must use either \"short\" or \"long\".\n");
	false
    fi
corp;

Verb1(G, "clients", 0, v_clients)$
Synonym(G, "clients", "cl")$

define tp_verbs proc v_character(string who)bool:
    character ch;

    if who = "" then
	Print("You must specify a character to check on.\n");
	false
    else
	ch := Character(who);
	if ch = nil then
	    ch := Character(Capitalize(who));
	fi;
	if ch = nil then
	    Print(who + " is not a character. Make sure you have the spelling "
		"and capitalization correct.\n");
	else
	    ShowCharacter(ch);
	fi;
	true
    fi
corp;

Verb1(G, "character", 0, v_character)$
Synonym(G, "character", "player")$
Synonym(G, "character", "char")$

define tp_verbs proc v_who()bool:
    Print("Use 'characters [long|short]' to see existing characters.\n"
	"Use 'clients [long|short]' to see current clients.\n"
	"Use 'character <name>, ...' to see given characters.\n");
    true
corp;

Verb0(G, "who", 0, v_who)$

define tp_verbs proc v_width(string newWidth)bool:
    int width;

    if newWidth = "" then
	width := TextWidth(0);
	Print("Current display width is " + IntToString(width) + ".\n");
    else
	Print("Old width was " +
		IntToString(TextWidth(StringToInt(newWidth))) + ".\n");
    fi;
    true
corp;

Verb1(G, "width", 0, v_width)$

define tp_verbs proc v_height(string newHeight)bool:
    int height;

    if newHeight = "" then
	height := TextHeight(0);
	Print("Current display height is " + IntToString(height) + ".\n");
    else
	Print("Old height was " +
		IntToString(TextHeight(StringToInt(newHeight))) + ".\n");
    fi;
    true
corp;

Verb1(G, "height", 0, v_height)$

define tp_verbs proc v_volume()bool:
    string error, which, volString;
    int newVolume;

    error := "Use is: volume {sound | voice | music} <value:0-100>\n";
    which := GetWord();
    volString := GetWord();
    newVolume := StringToInt(volString);
    if newVolume >= 0 and newVolume <= 100 then
	newVolume := newVolume * 100;
	if which == "sound" then
	    SVolume(nil, newVolume);
	    true
	elif which == "voice" then
	    VVolume(nil, newVolume);
	    true
	elif which == "music" then
	    MVolume(nil, newVolume);
	    true
	else
	    Print(error);
	    false
	fi
    else
	Print(error);
	false
    fi
corp;

VerbTail(G, "volume", v_volume)$

define tp_verbs proc showHelpHelp()void:
    Print(
"Use 'help <topic>' or '? <topic>' for specific help.\n"
"(Do not type the apostrophes (') or the < and >.)\n\n"
"Help topics: mouse, move, graphics, objects\n"
    );
corp;

define tp_verbs proc v_helphelp()bool:

    showHelpHelp();
    true
corp;

Verb0(G, "helphelp", 0, v_helphelp)$
Synonym(G, "helphelp", "??")$

define tp_verbs proc v_help(string what)bool:

    if what = "" then
	Print(
"Use 'help help' or '??' to see more help topics.\n\n"
"Standard commands available in this starter game:\n"
"    [go] north/south.../n/s/...enter/exit/up/down...\n"
"    look [around]; look at XXX, YYY, ...; examine XXX; look <direction>\n"
"    inventory/inv/i\n"
"    pick up XXX, YYY, ...; get/g XXX, YYY, ...\n"
"    put/p [down] XXX, YYY, ...; drop XXX, YYY, ...\n"
"    say XXX; \"xxx; smile, wave, ...; quests [who]\n"
"    quit; verbose; terse; password; prompt; name; who; height; width;\n"
"    play; erase; eat; use; wear; read; touch; smell; open; close;\n"
"    push; pull; turn; chat; pose; echo; follow; etc.\n"
"plus others as the game features require.\n"
	);
    elif what == "help" or what = "?" or what == "topics" or what == "topic"
    then
	showHelpHelp();
    elif what == "mouse" then
	if GOn(nil) then
	    Print(
"The mouse can be used instead of typing to enter some commands. The right "
"half of the graphics area usually contains a number of \"buttons\" that you "
"can click on. For example, clicking on the 'L' button is equivalent to "
"typing \"look around\" or just \"l\". You can also click in the left hand "
"half of the graphics area. Doing so will attempt to generate a command to "
"move your character one room towards where you click. Note that you can only "
"move in the 8 compass directions doing this. You cannot drag your character "
"around - you must move in single-room steps, in order to properly allow "
"interaction with other characters in the game. You also cannot just point to "
"something on the display and try to move to it - the movement is only in "
"single-room steps in the compass direction closest to what you select.\n"
	    );
	else
	    Print(
"Since you do not currently have graphics enabled, it is likely that you are "
"not using the custom AmigaMUD client program. In that case, you cannot use "
"your mouse for anything specific to playing in AmigaMUD, other than normal "
"use within your normal user interface.\n"
	    );
	fi;
    elif what == "move" then
	if GOn(nil) then
	    Print(
"There are several ways to move around. The quickest, once you get used to "
"it, is to use the numeric keypad. If you imagine your character cursor on "
"top of the '5' key, then the 1, 2, 3, 4, 6, 7, 8, and 9 keys will try to "
"move your character one room in the corresponding compass direction. For "
"example, typing the '7' key on the numeric keypad will attempt to move your "
"character one room to the north-west. This is equivalent to typing the "
"command   northwest   or just   nw. Typing the '5' key itself is the same as "
"using the   look around   command. You can also use '+' and '-' keys if you "
"have them, to move up and down.\n\n"
"Movement in this game is through a set of distinct \"rooms\". You cannot "
"move to arbitrary positions, only to the few positions that the game has "
"predefined. The graphics you see on your screen are only pictures - they do "
"not define what you can do. To see how the simpler graphics work, try going "
"into the playpen in the Builder's Guild, and building your own rooms. You "
"can do this by clicking on the '@' button that will appear, and then on the "
"'Rooms' button that will appear.\n"
	    );
	else
	    Print(
"Since you do not currently have graphics enabled, it is likely that you are "
"not using the custom AmigaMUD client program. In that case, you must move "
"around by typing individual movement commands. These commands are the eight "
"compass directions: north, northeast, east, southeast, south, southwest, "
"west and northwest, or their abbreviations: n, ne, e, se, s, sw, w, nw. You "
"can also move up (u) or down (d) and in or out.\n"
	    );
	fi;
    elif what == "graphics" or what == "graphic" then
	if GOn(nil) then
	    Print(
"The graphics displayed by AmigaMUD should not be interpreted literally. They "
"are sketches only. Even when you see a bitmap image, it is only meant to "
"guide your imagination as to what your character can currently see. The fact "
"that the picture shows a tree or fountain or road, does not mean that the "
"game has such a thing that you can do things to. In a game of this type, you "
"can only move among a fixed set of \"rooms\" - you cannot walk up to "
"everything you see in pictures, since some of them are scenery only. Pay "
"close attention to the textual description of things - it will more "
"accurately show what things have actually been built in the world, and will "
"also contains hints about things you can do. The words are the key to the "
"game - the pictures and sounds are usually only decorations.\n"
	    );
	else
	    Print(
"Since you do not currently have graphics enabled, graphics is not relevant "
"to you. Graphics are only available when you are using the custom AmigaMUD "
"client program.\n"
	    );
	fi;
    elif what == "objects" or what == "object" then
	Print(
"Objects are very important in games of this type. When the text you see when "
"you enter a room shows something being there, it is a good idea to look at "
"that object and remember where you saw it - it may be important to you. You "
"can carry objects around with you, but only so many of them. Also, some "
"objects cannot be picked up. When you see an object named, you can refer to "
"it in commands by that name, but you can also usually leave off the "
"adjectives - they are only needed if you have to choose from more than one "
"object of the same kind. Some commands useful with objects include get, "
"drop, look at, look in, fill, empty, read, etc. For example, if the room "
"you have just walked into contains a universal carryall and a delicious red "
"apple, you can probably do:\n\n"
"    get carryall\n"
"    g apple\n"
"    l in carryall\n"
"    put apple in carryall\n\n"
"etc. The game accepts simple abbreviations for most command words, and can "
"also handle longer, more grammatically correct forms of commands. It can "
"also work with multiple objects at once. For example:\n\n"
"    Pick up the universal carryall and the delicious red apple.\n"
"    Look inside the univeral carryall.\n"
"    Put the delicious red apple into the universal carryall.\n\n"
"Most people don't have the patience for such long forms, however!\n\n"
"Sometimes, the objects in a room will be \"hidden\" from you, in that they "
"will not explicitly show up. You have to read the room description, and find "
"out what is real, and what is just scenery.\n"
	);
    else
	Print("Unknown help topic. Type 'help help' or '??' for topics.\n");
    fi;
    true
corp;

Verb1(G, "help", 0, v_help)$
Synonym(G, "help", "?")$

define tp_verbs proc v_words()bool:
    ShowWords(G);
    true
corp;

Verb0(G, "words", 0, v_words)$


/* use the generic verb stuff for some typical verbs */

define t_base p_oPlayString CreateStringProp()$
define t_base p_oPlayChecker CreateActionProp()$
define t_base p_pPlayChecker CreateActionProp()$
define t_base p_oEraseString CreateStringProp()$
define t_base p_oEraseChecker CreateActionProp()$
define t_base p_pEraseChecker CreateActionProp()$
define t_base p_oEatString CreateStringProp()$
define t_base p_oEatChecker CreateActionProp()$
define t_base p_pEatChecker CreateActionProp()$
define t_base p_oUseString CreateStringProp()$
define t_base p_oUseChecker CreateActionProp()$
define t_base p_pUseChecker CreateActionProp()$
define t_base p_oActivateString CreateStringProp()$
define t_base p_oActivateChecker CreateActionProp()$
define t_base p_pActivateChecker CreateActionProp()$
define t_base p_oDeActivateString CreateStringProp()$
define t_base p_oDeActivateChecker CreateActionProp()$
define t_base p_pDeActivateChecker CreateActionProp()$
define t_base p_oLightString CreateStringProp()$
define t_base p_oLightChecker CreateActionProp()$
define t_base p_pLightChecker CreateActionProp()$
define t_base p_oExtinguishString CreateStringProp()$
define t_base p_oExtinguishChecker CreateActionProp()$
define t_base p_pExtinguishChecker CreateActionProp()$
define t_base p_oWearString CreateStringProp()$
define t_base p_oWearChecker CreateActionProp()$
define t_base p_pWearChecker CreateActionProp()$
define t_base p_oTouchString CreateStringProp()$
define t_base p_oTouchChecker CreateActionProp()$
define t_base p_pTouchChecker CreateActionProp()$
define t_base p_oSmellString CreateStringProp()$
define t_base p_oSmellChecker CreateActionProp()$
define t_base p_pSmellChecker CreateActionProp()$
define t_base p_oListenString CreateStringProp()$
define t_base p_oListenChecker CreateActionProp()$
define t_base p_pListenChecker CreateActionProp()$
define t_base p_oOpenString CreateStringProp()$
define t_base p_oOpenChecker CreateActionProp()$
define t_base p_pOpenChecker CreateActionProp()$
define t_base p_oCloseString CreateStringProp()$
define t_base p_oCloseChecker CreateActionProp()$
define t_base p_pCloseChecker CreateActionProp()$
define t_base p_oPushString CreateStringProp()$
define t_base p_oPushChecker CreateActionProp()$
define t_base p_pPushChecker CreateActionProp()$
define t_base p_oPullString CreateStringProp()$
define t_base p_oPullChecker CreateActionProp()$
define t_base p_pPullChecker CreateActionProp()$
define t_base p_oTurnString CreateStringProp()$
define t_base p_oTurnChecker CreateActionProp()$
define t_base p_pTurnChecker CreateActionProp()$
define t_base p_oLiftString CreateStringProp()$
define t_base p_oLiftChecker CreateActionProp()$
define t_base p_pLiftChecker CreateActionProp()$
define t_base p_oLowerString CreateStringProp()$
define t_base p_oLowerChecker CreateActionProp()$
define t_base p_pLowerChecker CreateActionProp()$

define t_base proc utility public GetVerbStringProp(string verb)
	property string:
    case MatchName(
	"play."
	"erase."
	"eat,lick,taste,drink,quaff,imbibe."
	"use,apply."
	"activate."
	"deactivate."
	"light."
	"extinguish."
	"wear."
	"touch,feel,pet."
	"smell,sniff."
	"listen."
	"open."
	"close,shut."
	"push,shove."
	"pull,yank,jerk,tug."
	"turn,twist,rotate,spin."
	"lift,raise."
	"lower."
	"get,take."
	"unlock"
	, verb)
    incase 0:
	p_oPlayString
    incase 1:
	p_oEraseString
    incase 2:
	p_oEatString
    incase 3:
	p_oUseString
    incase 4:
	p_oActivateString
    incase 5:
	p_oDeActivateString
    incase 6:
	p_oLightString
    incase 7:
	p_oExtinguishString
    incase 8:
	p_oWearString
    incase 9:
	p_oTouchString
    incase 10:
	p_oSmellString
    incase 11:
	p_oListenString
    incase 12:
	p_oOpenString
    incase 13:
	p_oCloseString
    incase 14:
	p_oPushString
    incase 15:
	p_oPullString
    incase 16:
	p_oTurnString
    incase 17:
	p_oLiftString
    incase 18:
	p_oLowerString
    incase 19:
	p_oNotGetString
    incase 20:
	p_oNotUnlockString
    default:
	nil
    esac
corp;

define t_base proc utility public GetVerbCheckerProp(string verb)
	property action:
    case MatchName(
	"play."
	"erase."
	"eat,lick,taste,drink,quaff,imbibe."
	"use,apply."
	"activate."
	"deactivate."
	"light."
	"extinguish."
	"wear."
	"touch,feel,pet."
	"smell,sniff."
	"listen."
	"open."
	"close,shut."
	"push,shove."
	"pull,yank,jerk,tug."
	"turn,twist,rotate,spin."
	"lift,raise."
	"lower"
	, verb)
    incase 0:
	p_oPlayChecker
    incase 1:
	p_oEraseChecker
    incase 2:
	p_oEatChecker
    incase 3:
	p_oUseChecker
    incase 4:
	p_oActivateChecker
    incase 5:
	p_oDeActivateChecker
    incase 6:
	p_oLightChecker
    incase 7:
	p_oExtinguishChecker
    incase 8:
	p_oWearChecker
    incase 9:
	p_oTouchChecker
    incase 10:
	p_oSmellChecker
    incase 11:
	p_oListenChecker
    incase 12:
	p_oOpenChecker
    incase 13:
	p_oCloseChecker
    incase 14:
	p_oPushChecker
    incase 15:
	p_oPullChecker
    incase 16:
	p_oTurnChecker
    incase 17:
	p_oLiftChecker
    incase 18:
	p_oLowerChecker
    default:
	nil
    esac
corp;

define tp_verbs proc v_play(string what)bool:
    VerbHere("play", p_oPlayString, p_oPlayChecker, p_pPlayChecker,
	     "You cannot play", what)
corp;
define tp_verbs proc v_erase(string what)bool:
    VerbHere("erase", p_oEraseString, p_oEraseChecker, p_pEraseChecker,
	     "You cannot erase", what)
corp;
/* want eat/drink to be VerbHere so can drink from streams, etc. */
define tp_verbs proc v_eat(string what)bool:
    VerbHere("eat", p_oEatString, p_oEatChecker, p_pEatChecker,
	     "YECH! You cannot eat", what)
corp;
define tp_verbs proc v_drink(string what)bool:
    VerbHere("drink", p_oEatString, p_oEatChecker, p_pEatChecker,
	     "YUCK! You cannot drink", what)
corp;
define tp_verbs proc v_use(string what)bool:
    VerbCarry("use", p_oUseString, p_oUseChecker, p_pUseChecker,
	      "You cannot use", what)
corp;
define tp_verbs proc v_activate(string what)bool:
    VerbHere("activate", p_oActivateString, p_oActivateChecker,
	     p_pActivateChecker, "You cannot activate", what)
corp;
define tp_verbs proc v_deactivate(string what)bool:
    VerbHere("deactivate", p_oDeActivateString, p_oDeActivateChecker,
	     p_pDeActivateChecker, "You cannot deactivate", what)
corp;
define tp_verbs proc v_light(string what)bool:
    VerbHere("light", p_oLightString, p_oLightChecker, p_pLightChecker,
	     "You cannot light", what)
corp;
define tp_verbs proc v_extinguish(string what)bool:
    VerbHere("extinguish", p_oExtinguishString, p_oExtinguishChecker,
	     p_pExtinguishChecker, "You cannot extinguish", what)
corp;
define tp_verbs proc v_wear(string what)bool:
    VerbCarry("wear", p_oWearString, p_oWearChecker, p_pWearChecker,
	      "You cannot wear", what)
corp;
define tp_verbs proc v_touch(string what)bool:
    VerbHere("touch", p_oTouchString, p_oTouchChecker, p_pTouchChecker,
	     "You feel nothing special about", what)
corp;
define tp_verbs proc v_smell(string what)bool:
    VerbHere("smell", p_oSmellString, p_oSmellChecker, p_pSmellChecker,
	     "You smell nothing special about", what)
corp;
r_indoors@p_oSmellString :=
    "The air here is not bad, but not as good as outdoors air."$
r_tunnel@p_oSmellString := "The tunnel air is somewhat stale."$
r_outdoors@p_oSmellString := "The air here is fairly fresh and pleasant."$
r_path@p_oSmellString := "There is a very faint dusty smell here."$
r_road@p_oSmellString := "There is a faint dusty smell here."$
r_forest@p_oSmellString := "The air here smells of growing plants."$
r_field@p_oSmellString := "The air here smells of grass and flowers."$
r_sidewalk@p_oSmellString := "The air here smells a bit from the nearby road."$
r_park@p_oSmellString := "The park air is fresher than typical outdoors air."$
define tp_verbs proc v_listen(string what)bool:
    VerbHere("listen to", p_oListenString, p_oListenChecker, p_pListenChecker,
	     "You hear nothing special from", what)
corp;
r_indoors@p_oListenString := "You hear nothing special here."$
r_outdoors@p_oListenString := "You hear nothing special here."$
r_path@p_oListenString :=
    "You hear the gentle sound of a breeze in the greenery."$
r_forest@p_oListenString :=
    "You hear the gentle rustle of a breeze in the trees."$
r_field@p_oListenString :=
    "You hear the murmur of a breeze and occasional insect sounds."$
r_park@p_oListenString :=
    "You can hear the sound of a breeze in the greenery."$
r_tunnel@p_oListenString :=
    "You hear nothing here but the slight murmur of air moving, and an "
    "occasional drop of water falling."$
define tp_verbs proc v_open(string what)bool:
    VerbHere("open", p_oOpenString, p_oOpenChecker, p_pOpenChecker,
	     "You cannot open", what)
corp;
define tp_verbs proc v_close(string what)bool:
    VerbHere("close", p_oCloseString, p_oCloseChecker, p_pCloseChecker,
	     "You cannot close", what)
corp;
define tp_verbs proc v_push(string what)bool:
    VerbHere("push", p_oPushString, p_oPushChecker, p_pPushChecker,
	     "You cannot push", what)
corp;
define tp_verbs proc v_pull(string what)bool:
    VerbHere("pull", p_oPullString, p_oPullChecker, p_pPullChecker,
	     "You cannot pull", what)
corp;
define tp_verbs proc v_turn(string what)bool:
    VerbHere("turn", p_oTurnString, p_oTurnChecker, p_pTurnChecker,
	     "You cannot turn", what)
corp;
define tp_verbs proc v_lift(string what)bool:
    VerbHere("lift", p_oLiftString, p_oLiftChecker, p_pLiftChecker,
	     "You cannot lift", what)
corp;
define tp_verbs proc v_lower(string what)bool:
    VerbHere("lower", p_oLowerString, p_oLowerChecker, p_pLowerChecker,
	     "You cannot lower", what)
corp;

Verb1(G, "play", 0, v_play)$
Verb1(G, "erase", 0, v_erase)$
Verb1(G, "eat", 0, v_eat)$
Synonym(G, "eat", "lick")$
Synonym(G, "eat", "taste")$
Verb1(G, "drink", 0, v_drink);
Synonym(G, "drink", "quaff")$
Synonym(G, "drink", "imbibe")$
Verb1(G, "use", 0, v_use)$
Synonym(G, "use", "apply")$
Verb1(G, "activate", 0, v_activate)$
Verb1(G, "turn", FindAnyWord(G, "on"), v_activate)$
Verb1(G, "deactivate", 0, v_deactivate)$
Synonym(G, "deactivate", "inactivate")$
Verb1(G, "turn", FindAnyWord(G, "off"), v_deactivate)$
Verb1(G, "light", 0, v_light)$
Synonym(G, "light", "ignite")$
Verb1(G, "extinguish", 0, v_extinguish)$
Synonym(G, "extinguish", "douse")$
Verb1(G, "wear", 0, v_wear)$
Verb1(G, "touch", 0, v_touch)$
Synonym(G, "touch", "feel")$
Synonym(G, "touch", "pet")$
Verb1(G, "smell", 0, v_smell)$
Synonym(G, "smell", "sniff")$
Verb1(G, "listen", FindAnyWord(G, "to"), v_listen)$
Verb1(G, "listen", FindAnyWord(G, "at"), v_listen)$
Verb1(G, "open", 0, v_open)$
Verb1(G, "close", 0, v_close)$
Synonym(G, "close", "shut")$
Verb1(G, "push", FindAnyWord(G, "on"), v_push)$
Synonym(G, "push", "shove")$
Verb1(G, "pull", FindAnyWord(G, "on"), v_pull)$
Synonym(G, "pull", "yank")$
Synonym(G, "pull", "jerk")$
Synonym(G, "pull", "tug")$
Verb1(G, "turn", 0, v_turn)$
Synonym(G, "turn", "rotate")$
Synonym(G, "turn", "twist")$
Synonym(G, "turn", "spin")$
Synonym(G, "turn", "crank")$
Synonym(G, "turn", "wind")$
Verb1(G, "lift", FindAnyWord(G, "up"), v_lift)$
Synonym(G, "lift", "raise")$
Verb1(G, "lower", 0, v_lower)$


/* properties associated with specific commands ('register', 'buy') */

define t_base p_rRegisterAction CreateActionProp()$
define t_base p_rHintAction CreateActionProp()$
define t_base p_rHintString CreateStringProp()$
define t_base p_rInfoAction CreateActionProp()$
define t_base p_rInfoString CreateStringProp()$

/* and other verbs that use actions attached to locations */

define tp_verbs proc v_register()bool:
    action a;

    a := Here()@p_rRegisterAction;
    if a = nil then
	Print("There is nothing to register at here.\n");
	false
    else
	call(a, bool)()
    fi
corp;

Verb0(G, "register", 0, v_register)$
Synonym(G, "register", "reg")$
Synonym(G, "register", "r")$

define tp_verbs proc v_buy(string what)bool:
    action a;

    if what = "" then
	Print("You must specify what you want to buy.\n");
	false
    else
	a := Here()@p_rBuyAction;
	if a = nil then
	    Print("There is nothing here to buy.\n");
	    false
	else
	    call(a, bool)(what)
	fi
    fi
corp;

Verb1(G, "buy", 0, v_buy)$
Synonym(G, "buy", "purchase")$

define tp_verbs proc v_shop()bool:
    ShowForSale();
    true
corp;

Verb0(G, "shop", 0, v_shop)$
Synonym(G, "shop", "price")$
Synonym(G, "shop", "prices")$
Synonym(G, "shop", "cost")$


define tp_verbs proc v_hint(string what)bool:
    action a;
    string st;

    a := Here()@p_rHintAction;
    if a = nil then
	st := Here()@p_rHintString;
	if st = "" then
	    Print("There are no hints here.\n");
	    false
	else
	    Print(st + "\n");
	    true
	fi
    else
	call(a, bool)(what)
    fi
corp;

Verb1(G, "hint", 0, v_hint)$

define tp_verbs proc v_info(string what)bool:
    action a;
    string st;

    a := Here()@p_rInfoAction;
    if a = nil then
	st := Here()@p_rInfoString;
	if st = "" then
	    Print("There is no info to give here.\n");
	    false
	else
	    Print(st + "\n");
	    true
	fi
    else
	call(a, bool)(what)
    fi
corp;

Verb1(G, "info", 0, v_hint)$
Synonym(G, "info", "information")$

/* some commands for folks to complain to SysAdmin */

define tp_verbs proc complain(string kind)bool:

    Log(kind + ": '" + Here()@p_rName + "' owner " +
	CharacterThing(Owner(Here()))@p_pName + ": " +
	GetTail() + "\n");
    Print(kind + " logged.\n");
    true
corp;

define tp_verbs proc v_typo()bool:
    complain("Typo")
corp;

define tp_verbs proc v_bug()bool:
    complain("Bug")
corp;

define tp_verbs proc v_gripe()bool:
    complain("Gripe")
corp;

VerbTail(G, "typo", v_typo)$
VerbTail(G, "bug", v_bug)$
VerbTail(G, "gripe", v_gripe)$
Synonym(G, "gripe", "complain")$
Synonym(G, "gripe", "bitch")$


/* In order to use this 'cast' verb (as in casting magic spells), the
   character must have the verbs defined in his/her private table. They
   are looked up there and executed. Source file 'st:extras/spells.m'
   will give some handy spells to whatever wizard sources it. There is
   a "spells" spell there which lists the ones it creates. The build
   code also creates spells 'makebuilder' and 'unmakebuilder' for
   SysAdmin. */

define tp_verbs proc v_cast()bool:
    table tb;
    string what;
    action a;

    tb := LookupTable(PrivateTable(), "t_spells");
    if tb = nil then
	Print("You have no spells to cast.\n");
	false
    else
	what := GetWord();
	if what = "" then
	    Print("You must specify the spell you want to cast.\n");
	    false
	else
	    a := LookupAction(tb, what);
	    if a = nil then
		Print("You know no spell by that name.\n");
		false
	    else
		call(a, void)();
		true
	    fi
	fi
    fi
corp;

VerbTail(G, "cast", v_cast)$


define tp_verbs proc setTextColours(int colour0, colour1, colour2,colour3)bool:
    thing me;

    me := Me();
    me@p_pTextColours[0] := colour0;
    me@p_pTextColours[1] := colour1;
    me@p_pTextColours[2] := colour2;
    me@p_pTextColours[3] := colour3;
    GSetTextColour(nil, 0, colour0);
    GSetTextColour(nil, 1, colour1);
    GSetTextColour(nil, 2, colour2);
    GSetTextColour(nil, 3, colour3);
    true
corp;

define tp_verbs proc v_brightGold()bool:
    setTextColours(0x000, 0xda0, 0xb80, 0xfc0)
corp;

define tp_verbs proc v_normalGold()bool:
    setTextColours(0x000, 0xb80, 0xa60, 0xda0)
corp;

define tp_verbs proc v_dimGold()bool:
    setTextColours(0x000, 0xa60, 0x850, 0xb80)
corp;

define tp_verbs proc v_brightGrey()bool:
    setTextColours(0x000, 0xddd, 0xbbb, 0xeee)
corp;

define tp_verbs proc v_normalGrey()bool:
    setTextColours(0x000, 0xbbb, 0x999, 0xddd)
corp;

define tp_verbs proc v_dimGrey()bool:
    setTextColours(0x000, 0x999, 0x777, 0xbbb)
corp;

define tp_verbs proc v_blueGrey()bool:
    setTextColours(0xbbb, 0x06b, 0x03a, 0x000)
corp;

define tp_verbs proc v_reverseGrey()bool:
    setTextColours(0xddd, 0x999, 0x777, 0x000)
corp;

define tp_verbs proc v_textcolours()bool:
    int colour0, colour1, colour2, colour3;
    thing me;

    colour0 := StringToInt(GetWord());
    colour1 := StringToInt(GetWord());
    colour2 := StringToInt(GetWord());
    colour3 := StringToInt(GetWord());
    if colour0 < 0 or colour1 < 0 or colour2 < 0 or colour3 < 0 or
	GetWord() ~= ""
    then
	me := Me();
	Print("Use is: textcolours <colour> <colour> <colour> <colour>\n");
	Print("  <colour> values are for pens 0, 1, 2, and 3 respectively.\n");
	Print("  <colour> values must be positive decimal numbers.\n");
	Print("  Current values are: " +
	    IntToString(me@p_pTextColours[0]) + " " +
	    IntToString(me@p_pTextColours[1]) + " " +
	    IntToString(me@p_pTextColours[2]) + " " +
	    IntToString(me@p_pTextColours[3]) + "\n");
	false
    else
	setTextColours(colour0, colour1, colour2, colour3)
    fi
corp;

Verb0(G, "brightgold", 0, v_brightGold)$
Verb0(G, "normalgold", 0, v_normalGold)$
Verb0(G, "dimgold", 0, v_dimGold)$
Verb0(G, "brightgrey", 0, v_brightGrey)$
Verb0(G, "normalgrey", 0, v_normalGrey)$
Verb0(G, "dimgrey", 0, v_dimGrey)$
Verb0(G, "bluegrey", 0, v_blueGrey)$
Verb0(G, "reversegrey", 0, v_reverseGrey)$
VerbTail(G, "textcolours", v_textcolours)$

define tp_verbs proc v_cursor(string colour)bool:
    int which;

    if colour = "" then
	Print("Use is: cursor <colour-name>\n");
	ShowKnownColours();
	false
    else
	which := ColourMatch(colour);
	if which = -1 then
	    Print("Colour " + FormatName(colour) + " not known.\n");
	    false
	else
	    Me()@p_pCursorColour := which;
	    SetCursorPen(which);
	    true
	fi
    fi	
corp;

define tp_verbs proc v_icons(string colour)bool:
    int which;

    if colour = "" then
	Print("Use is: icons <colour-name>\n");
	ShowKnownColours();
	false
    else
	which := ColourMatch(colour);
	if which = -1 then
	    Print("Colour " + FormatName(colour) + " not known.\n");
	    false
	else
	    Me()@p_pIconColour := which;
	    GSetIconPen(nil, which);
	    true
	fi
    fi
corp;

Verb1(G, "cursor", 0, v_cursor)$
Verb1(G, "icon", 0, v_icons)$
Synonym(G, "icon", "icons")$

define tp_verbs proc v_colours()bool:
    Print("Commands relating to colours: brightgold, normalgold, dimgold,\n"
	"    brightgrey, normalgrey, dimgrey, bluegrey, reversegrey,\n"
	"    textcolours, cursor, icons\n");
    true
corp;

Verb0(G, "colour", 0, v_colours)$
Synonym(G, "colour", "colours")$


unuse tp_verbs
