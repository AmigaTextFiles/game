/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * util.m - a bunch of handy utility routines. Also some core routines for
 *	some standard things used in most dungeons.
 */

private tp_util CreateTable().
use tp_util

define tp_util ForwardReference CreateThing(nil).
define tp_util pDoMove CreateActionProp().

/* codes for use with LeaveRoomStuff and EnterRoomStuff */

define t_util MOVE_NORMAL	0.
define t_util MOVE_POOF 	1.
define t_util MOVE_SPECIAL	2.

/* some standard types of rooms */

define t_roomTypes r_indoors CreateThing(nil).
r_indoors@p_rScenery := "floor,wall,ceiling".
AutoGraphics(r_indoors, AutoClosedRoom);
SetThingStatus(r_indoors, ts_readonly).

define t_roomTypes r_outdoors CreateThing(nil).
r_outdoors@p_rScenery := "ground,sky".
AutoGraphics(r_outdoors, AutoPaths);
SetThingStatus(r_outdoors, ts_readonly).

define t_roomTypes r_path CreateThing(r_outdoors).
r_path@p_rScenery := "ground,sky,path,trail,bush,bushes,grass".
AutoGraphics(r_path, AutoPaths);
SetThingStatus(r_path, ts_readonly).

define t_roomTypes r_road CreateThing(r_outdoors).
r_road@p_rScenery := "ground,sky,road,dirt,alley".
AutoGraphics(r_road, AutoRoads);
SetThingStatus(r_road, ts_readonly).

define t_roomTypes r_forest CreateThing(r_outdoors).
r_forest@p_rScenery :=
    "ground,sky,path,trail,grass,bush,bushes,tree,leaf,leaves,foliage".
AutoGraphics(r_forest, AutoPaths);
AutoPens(r_forest, C_FOREST_GREEN, C_DARK_GREEN, 0, 0).
SetThingStatus(r_forest, ts_readonly).

define t_roomTypes r_field CreateThing(r_outdoors).
r_field@p_rScenery := "ground,sky,path,trail,grass,field,pasture.".
AutoGraphics(r_field, AutoOpenSpace);
SetThingStatus(r_field, ts_readonly).

define t_roomTypes r_sidewalk CreateThing(r_outdoors).
r_sidewalk@p_rScenery := "ground,sky,sidewalk,pavement,road".
AutoGraphics(r_sidewalk, AutoPaths);
SetThingStatus(r_sidewalk, ts_readonly).

define t_roomTypes r_park CreateThing(r_outdoors).
r_park@p_rScenery :=
    "ground,sky,sidewalk,fountain,tree,bush,bushes,grass.park".
AutoGraphics(r_park, AutoOpenSpace);
SetThingStatus(r_park, ts_readonly).

define t_roomTypes r_tunnel CreateThing(r_indoors).
r_tunnel@p_rScenery := "floor,ground,wall,side,roof,ceiling,rock,stone".
AutoGraphics(r_tunnel, AutoTunnels);
SetThingStatus(r_tunnel, ts_readonly).

/* some routines to help us build a world */

/*
 * ExtendDesc - add some stuff to a room description - this is used when
 *	adding a room to an already existing setup.
 */

define t_util proc utility public ExtendDesc(thing room; string desc)void:
    string s;

    s := room@p_rDesc;
    if s = "" then
	s := desc;
    else
	s := s + " " + desc;
    fi;
    room@p_rDesc := s;
corp;

/*
 * Scenery - add some names that will be found by 'look', etc., but that
 *	have nothing special about them. Doing it this way saves creating
 *	a lot of extra things.
 */

define t_util proc utility public Scenery(thing room; string newScenery)void:
    string oldScenery;

    oldScenery := room@p_rScenery;
    if oldScenery ~= "" then
	newScenery := oldScenery + "." + newScenery;
    fi;
    room@p_rScenery := newScenery;
corp;

/*
 * Sign - create a dummy sign.
 */

define t_util proc utility public Sign(thing room; string name, desc,text)void:
    thing sign;

    sign := CreateThing(nil);
    sign@p_oName := name;
    if desc ~= "" then
	sign@p_oDesc := desc;
    fi;
    sign@p_oReadString := text;
    sign@p_oNotGettable := true;
    sign@p_oInvisible := true;
    SetThingStatus(sign, ts_readonly);
    AddTail(room@p_rContents, sign);
corp;

/*
 * Several variants for setting up rooms. Note: the 'P' variants are the
 *	same as the non-P forms, except that they make the room public,
 *	i.e. add-to-able by others.
 *	The base variant takes the room, the name string, and an optional
 *	description string.
 */

define t_util proc utility public SetupRoom(thing room; string name, desc)void:

    room@p_rName := name;
    if desc ~= "" then
	room@p_rDesc := desc;
    fi;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_readonly);
corp;

define t_util proc utility public SetupRoomP(thing room;
	string name, desc)void:

    room@p_rName := name;
    if desc ~= "" then
	room@p_rDesc := desc;
    fi;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_wizard);
corp;

define t_util proc utility public SetupRoomD(thing room;
	string name, desc)void:

    room@p_rName := name;
    if desc ~= "" then
	room@p_rDesc := desc;
    fi;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_readonly);
    room@p_rDark := true;
corp;

define t_util proc utility public SetupRoomDP(thing room;
	string name, desc)void:

    room@p_rName := name;
    if desc ~= "" then
	room@p_rDesc := desc;
    fi;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_wizard);
    room@p_rDark := true;
corp;

/* This variant has no description, and a proc to provide the name.
   This is useful with many similar rooms, to avoid duplicating the
   name string. */

define t_util proc utility public SetupRoom2(thing room;
	action nameAction)void:

    room@p_rNameAction := nameAction;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_readonly);
corp;

define t_util proc utility public SetupRoom2P(thing room;
	action nameAction)void:

    room@p_rNameAction := nameAction;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_wizard);
corp;

/* Variant with name action, but a required description string */

define t_util proc utility public SetupRoom3(thing room; action nameAction;
	string desc)void:

    room@p_rNameAction := nameAction;
    room@p_rDesc := desc;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_readonly);
corp;

define t_util proc utility public SetupRoom3P(thing room; action nameAction;
	string desc)void:

    room@p_rNameAction := nameAction;
    room@p_rDesc := desc;
    room@p_rContents := CreateThingList();
    room@p_rExits := CreateIntList();
    SetThingStatus(room, ts_wizard);
corp;

/* Similar utility to set up an object. Takes the object, an optional room
   to put it in and to make its home, the name string, and an optional
   description string. */

define t_util proc utility public SetupObject(thing object, where;
	string name, desc)void:

    object@p_oName := name;
    if desc ~= "" then
	object@p_oDesc := desc;
    fi;
    if where ~= nil then
	AddTail(where@p_rContents, object);
	object@p_oHome := where;
	object@p_oWhere := where;
    fi;
    SetThingStatus(object, ts_wizard);
corp;

/* this one makes a fake, non-gettable object */

define t_util proc utility public FakeObject(thing object, where;
	string name, desc)void:

    object@p_oName := name;
    if desc ~= "" then
	object@p_oDesc := desc;
    fi;
    object@p_oNotGettable := true;
    object@p_oInvisible := true;
    if where ~= nil then
	AddTail(where@p_rContents, object);
    fi;
    SetThingStatus(object, ts_wizard);
corp;

/* this one makes just a model for a fake, non-gettable object */

define t_util proc utility public FakeModel(thing object;
	string name, desc)void:

    object@p_oName := name;
    if desc ~= "" then
	object@p_oDesc := desc;
    fi;
    object@p_oNotGettable := true;
    object@p_oInvisible := true;
    SetThingStatus(object, ts_wizard);
corp;

/*
 * DepositObject - add a clone of an object to the indicated room.
 */

define t_util proc utility public DepositClone(thing room, model)void:
    thing new;

    new := CreateThing(model);
    AddTail(room@p_rContents, new);
    new@p_oCreator := Me();
    new@p_oWhere := room;
    GiveThing(new, SysAdmin);
    SetThingStatus(new, ts_public);
corp;

/* Some utilities for making connections between rooms. 'Connect' is the
   most useful one. */

define t_util proc utility public UniConnect(thing r1, r2; int dir)void:
    list int exits;

    r1@DirProp(dir) := r2;
    exits := r1@p_rExits;
    if exits = nil then
	exits := CreateIntList();
	r1@p_rExits := exits;
    fi;
    AddTail(exits, dir);
corp;

define t_util proc utility public BiConnect(thing r1, r2; int dir1, dir2)void:
    list int exits;

    r1@DirProp(dir1) := r2;
    exits := r1@p_rExits;
    if exits = nil then
	exits := CreateIntList();
	r1@p_rExits := exits;
    fi;
    AddTail(exits, dir1);
    r2@DirProp(dir2) := r1;
    exits := r2@p_rExits;
    if exits = nil then
	exits := CreateIntList();
	r2@p_rExits := exits;
    fi;
    AddTail(exits, dir2);
corp;

define t_util proc utility public Connect(thing r1, r2; int dir)void:
    list int exits;

    r1@DirProp(dir) := r2;
    exits := r1@p_rExits;
    if exits = nil then
	exits := CreateIntList();
	r1@p_rExits := exits;
    fi;
    AddTail(exits, dir);
    dir := DirBack(dir);
    r2@DirProp(dir) := r1;
    exits := r2@p_rExits;
    if exits = nil then
	exits := CreateIntList();
	r2@p_rExits := exits;
    fi;
    AddTail(exits, dir);
corp;

/*
 * HConnect is the same as UniConnect, except that the connection is not
 *	added to the list of obvious exits.
 */

define t_util proc utility public HConnect(thing r1, r2; int dir)void:

    r1@DirProp(dir) := r2;
    r2@DirProp(DirBack(dir)) := r1;
corp;

/*
 * HUniConnect - a hidden one-way connection.
 */

define t_util proc utility public HUniConnect(thing r1, r2; int dir)void:

    r1@DirProp(dir) := r2;
corp;

/* some routines useful for verbs */

/*
 * ShowExits - show the obvious exits from the current room.
 */

define t_util proc public ShowExits(thing room)void:
    list int li;
    int count, i, oldIndent;

    li := room@p_rExits;
    if li ~= nil then
	count := Count(li);
	if count = 0 then
	    Print("There are no obvious exits.\n");
	else
	    Print("Obvious exits: ");
	    oldIndent := GetIndent();
	    SetIndent(oldIndent + 2);
	    for i from 0 upto count - 1 do
		Print(ExitName(li[i]));
		if i ~= count then
		    Print(" ");
		fi;
	    od;
	    SetIndent(oldIndent);
	    Print("\n");
	fi;
    else
	Print("There are no obvious exits.\n");
    fi;
corp;

/*
 * ShowList - print out a contents/carrying list. Return 'true' if nothing
 *	was printed.
 */

define t_util proc utility public ShowList(list thing lt; string starter)bool:
    int i;
    thing object;
    string s;
    bool first;

    first := true;
    for i from 0 upto Count(lt) - 1 do
	object := lt[i];
	if not object@p_oInvisible then
	    if first then
		first := false;
		Print(starter);
	    fi;
	    Print("  " + FormatName(object@p_oName) + "\n");
	fi;
    od;
    first
corp;

/*
 * DoAll - do the given proc for each visible thing in the given list. Return
 *	'continue' if at least one is done and all done yield 'true';
 *	return 'succeed' if one does not return 'true', and return 'fail'
 *	if there are none to do.
 */

define t_util proc public DoAll(list thing lt; action a)status:
    int count, i, oldCount;
    thing th;
    bool ok, doneOne;

    count := Count(lt);
    doneOne := false;
    i := 0;
    ok := true;
    while ok and i ~= count do
	th := lt[i];
	if not th@p_oInvisible then
	    doneOne := true;
	    if call(a, bool)(th) then
		oldCount := count;
		count := Count(lt);
		i := i - (oldCount - count) + 1;
	    else
		ok := false;
	    fi;
	else
	    i := i + 1;
	fi;
    od;
    if doneOne then
	if ok then continue else succeed fi
    else
	fail
    fi
corp;

/* NOTE: When a monster is killed, DoDrop is called to drop whatever it is
   carrying. That in turn calls CanSee, with 'thePlayer' set to the monster. */

define t_util proc public CanSee(thing theRoom, thePlayer)bool:

    if not theRoom@p_rDark then
	true
    else
	if thePlayer ~= nil and not thePlayer@p_pStandard then
	    thePlayer := Me();
	fi;
	if thePlayer = nil then
	    FindFlagOnList(theRoom@p_rContents, p_oLight) or
		FindAgentWithFlag(theRoom, p_oLight) ~= nil or
		FindAgentWithFlagOnList(theRoom, p_pCarrying, p_oLight) ~= nil
	elif thePlayer@p_oLight then
	    true
	else
	    FindFlagOnList(thePlayer@p_pCarrying, p_oLight) or
		FindFlagOnList(theRoom@p_rContents, p_oLight) or
		FindAgentWithFlag(theRoom, p_oLight) ~= nil or
		FindAgentWithFlagOnList(theRoom, p_pCarrying, p_oLight) ~= nil
	fi
    fi
corp;

/*
 * LightAt - return 'true' if there is light in the given room, without
 *	the current player being considered to be there.
 */

define t_util proc public LightAt(thing theRoom)bool:

    not theRoom@p_rDark or
	FindFlagOnList(theRoom@p_rContents, p_oLight) or
	FindAgentWithFlag(theRoom, p_oLight) ~= nil or
	FindAgentWithFlagOnList(theRoom, p_pCarrying, p_oLight) ~= nil
corp;

/*
 * HasLight - return 'true' if the given thing (character) supplies light.
 */

define t_util proc public HasLight(thing who)bool:

    who@p_oLight or FindFlagOnList(who@p_pCarrying, p_oLight)
corp;

/*
 * CarryingChild - return any child of the given thing that the given
 *	player is carrying, either directly or indirectly.
 */

define tp_util proc containsChild(list thing lt; thing what)thing:
    int count, i;
    thing th;

    count := Count(lt);
    i := 0;
    while i < count do
	th := lt[i];
	if Parent(th) = what then
	    i := count + 1;
	elif th@p_oContents ~= nil then
	    th := containsChild(th@p_oContents, what);
	    if th ~= nil then
		i := count + 1;
	    else
		i := i + 1;
	    fi;
	else
	    i := i + 1;
	fi;
    od;
    if i > count then th else nil fi
corp;

define t_util proc CarryingChild(thing who, what)thing:
    containsChild(who@p_pCarrying, what)
corp;

/*
 * ChildHere - return any child of the given thing that the given room
 *	contains, either directly or indirectly.
 */

define t_util proc ChildHere(thing room, what)thing:
    containsChild(room@p_rContents, what)
corp;

/*
 * ShowPosition - show the position of the given player/character.
 */

define t_util proc public ShowPosition(thing th)void:
    int pos;

    pos := th@p_pPosition;
    if pos ~= POS_NONE then
	case pos
	incase POS_SIT_IN:
	    Print("sitting in");
	incase POS_SIT_ON:
	    Print("sitting on");
	incase POS_LIE_IN:
	    Print("lying in");
	incase POS_LIE_ON:
	    Print("lying on");
	incase POS_STAND_IN:
	    Print("standing in");
	incase POS_STAND_ON:
	    Print("standing on");
	esac;
	Print(" the " + FormatName(th@p_pWhere@p_oName) + ".\n");
    else
	Print("here.\n");
    fi;
corp;

/*
 * ZapObject - destroy an object, and anything it contains.
 */

define t_util proc public ZapObject(thing object)void:
    list thing lt;
    int count;
    thing th;

    lt := object@p_oContents;
    if lt ~= nil then
	count := Count(lt);
	while count ~= 0 do
	    count := count - 1;
	    th := lt[count];
	    ZapObject(th);
	    DelElement(lt, th);
	od;
    fi;
    ClearThing(object);
corp;

/*
 * SayToList - output a given message to each location on a list.
 */

define t_util proc SayToList(list thing lt; string message)void:
    int i;

    for i from 0 upto Count(lt) - 1 do
	ABPrint(lt[i], nil, nil, message);
    od;
corp;

/*
 * CharacterDescription - return the normal description of the passed character
 */

define t_util proc CharacterDescription(thing who)string:
    string s;
    action a;

    SetIt(who);
    a := who@p_pDescAction;
    if a = nil then
	s := who@p_pDesc;
    else
	s := call(a, string)();
    fi;
    s + DoActionsString(who@p_pDescMore)
corp;

/*
 * LookAtCharacter - take a detailed look at the given player/monster.
 */

define t_util proc LookAtCharacter(thing who)bool:
    action a;
    status st;
    string name, s;

    st := continue;
    a := who@p_pDescCheck;
    if a ~= nil then
	/* if p_pDescCheck returns 'continue', all is well and we
	   will continue looking at the player, and around. If it
	   returns 'succeed', then we are done looking at the
	   player, but can look around. If it returns 'fail', then
	   we cannot look anymore (or some such). */
	SetIt(who);
	st := call(a, status)();
    fi;
    if st = continue then
	s := CharacterDescription(who);
	name := FormatName(who@p_pName);
	if s = "" then
	    s := name + " has no description - bug him/her about it."
	fi;
	Print(s + "\n");
	if who = Me() then
	    s := "You are carrying:\n";
	else
	    s := name + " is carrying:\n";
	fi;
	ignore ShowList(who@p_pCarrying, s);
	true
    else
	st = succeed
    fi
corp;

/* NOTE: for the following sets of routines, the code usually just calls the
   the inner (one/once) routine directly via ForEachAgent, just to save one
   interpreted subroutine call. */

/*
 * ShowAgents - show who/what is in the current room.
 */

define t_util proc public ShowOneAgent(thing th)void:

    if th@p_pName ~= "" and not th@p_pHidden then
	Print(FormatName(th@p_pName) + " is ");
	ShowPosition(th);
	GShowIcon(nil, th, not th@p_pStandard, Parent(th) ~= nil);
    fi;
corp;

define t_util proc public ShowAgents()void:

    ForEachAgent(Here(), ShowOneAgent);
corp;

/*
 * ShowRoomTo - show the room to someone who is in it.
 */

define t_util proc ShowRoomToMe(bool full)bool:
    thing me, room;
    action a;
    string s;
    status st;

    me := Me();
    room := Here();
    a := room@p_rNameAction;
    if a = nil then
	s := room@p_rName;
    else
	s := call(a, string)();
    fi;
    if s ~= "" then
	Print("You are " + s + ".\n");
    fi;
    /* looking around the room can "fail" or "succeed" */
    st := DoRoomLookChecks(room);
    if st ~= fail then
	if st = continue then
	    if full or me@p_pVerbose then
		/* it may seem redundant to allow for both 'rLookChecks'
		   and 'rDescAction', but what the heck! */
		a := room@p_rDescAction;
		if a = nil then
		    s := room@p_rDesc;
		    if s = "" then
			Print("You see nothing special here.\n");
		    else
			Print(s + "\n");
		    fi;
		    ShowExits(room);
		else
		    Print(call(a, string)() + "\n");
		fi;
	    elif not me@p_pSuperBrief then
		ShowExits(room);
	    fi;
	fi;
	ignore ShowList(room@p_rContents, "Nearby:\n");
	if GOn(nil) then
	    GUndrawIcons(nil);
	    GResetIcons(nil);
	    a := room@p_rEnterRoomDraw;
	    if a ~= nil then
		RemoveCursor();
		call(a, void)();
	    fi;
	fi;
	ForEachAgent(room, ShowOneAgent);
	a := room@p_rFurtherDesc;
	if a ~= nil then
	    call(a, void)();
	fi;
	true
    else
	false
    fi
corp;

define tp_util proc doShowRoom()status:

    ignore ShowRoomToMe(false);
    continue
corp;

define t_util proc ShowRoomToAgent(thing who)void:

    /* no need to do anything for machines */
    if who ~= Me() and ThingCharacter(who) ~= nil then
	ignore ForceAction(who, doShowRoom);
    fi;
corp;

define t_util proc UnShowRoomFromMe()void:
    action a;

    if GOn(nil) then
	GUndrawIcons(nil);
	GResetIcons(nil);
	a := Here()@p_rLeaveRoomDraw;
	if a ~= nil then
	    call(a, void)(nil);
	fi;
    fi;
corp;

define tp_util proc doUnShowRoom()status:

    UnShowRoomFromMe();
    continue
corp;

define t_util proc UnShowRoomFromAgent(thing who)void:

    if who ~= Me() and ThingCharacter(who) ~= nil then
	/* only do it for players */
	ignore ForceAction(who, doUnShowRoom);
    fi;
corp;

/* some code to aid the 'follow' verb. */

define tp_util p_pOldHere CreateThingProp().
define tp_util p_pMeFollowDir CreateIntProp().
define tp_util p_pFollowMeDir CreateIntProp().

define t_util proc Follow(thing leader)void:
    list thing followers;

    followers := leader@p_pFollowers;
    if followers = nil then
	followers := CreateThingList();
	leader@p_pFollowers := followers;
	leader@p_pFollowMeDir := -1;
    fi;
    AddTail(followers, Me());
    Me()@p_pFollowing := leader;
    Me()@p_pMeFollowDir := -1;
corp;

define tp_util proc doFollow()status:
    thing me;
    int dir;

    me := Me();
    dir := me@p_pMeFollowDir;
    Print("You follow " + FormatName(me@p_pFollowing@p_pName) + " to " +
	DirName(dir) + ".\n");
    if call(ForwardReference@pDoMove, bool)(dir) then
	continue
    else
	fail
    fi
corp;

define tp_util proc doCheckFollowers()void:
    list thing followers;
    thing oldHere, leader, follower;
    int dir, i;

    leader := Me();
    followers := leader@p_pFollowers;
    if followers ~= nil then
	oldHere := leader@p_pOldHere;
	dir := leader@p_pFollowMeDir;
	i := Count(followers);
	while i ~= 0 do
	    i := i - 1;
	    follower := followers[i];
	    if follower@p_pFollowing = leader and
		AgentLocation(follower) = oldHere
	    then
		follower@p_pMeFollowDir := dir;
		if ForceAction(follower, doFollow) ~= continue
		then
		    /* the follow failed - remove this follower */
		    /* note that we specifically do not inform the
		       follower! */
		    follower -- p_pFollowing;
		    follower -- p_pMeFollowDir;
		    DelElement(followers, follower);
		fi;
	    else
		/* Again, we do not inform the follower - that could tell
		   him that the one he was following has moved, when he
		   should not normally know that. */
		follower -- p_pFollowing;
		follower -- p_pMeFollowDir;
		DelElement(followers, follower);
	    fi;
	od;
	if Count(followers) = 0 then
	    leader -- p_pFollowers;
	    leader -- p_pFollowMeDir;
	fi;
    fi;
corp;

define t_util proc CheckFollowers(thing here; int dir)void:
    thing me;

    me := Me();
    if me@p_pFollowers ~= nil then
	me@p_pOldHere := here;
	me@p_pFollowMeDir := dir;
	After(0, doCheckFollowers);
    fi;
corp;

define t_util proc ClearFollowers(thing leader)void:
    list thing followers;
    thing follower;
    int i;
    string name;

    followers := leader@p_pFollowers;
    if followers ~= nil then
	name := FormatName(leader@p_pName);
	for i from 0 upto Count(followers) - 1 do
	    follower := followers[i];
	    if follower@p_pFollowing = leader then
		follower -- p_pFollowing;
		follower -- p_pMeFollowDir;
		SPrint(follower,"You are no longer following " + name + ".\n");
	    fi;
	od;
	leader -- p_pFollowers;
	leader -- p_pFollowMeDir;
    fi;
corp;

define t_util proc UnFollow()void:
    list thing followers;
    thing me, leader;

    me := Me();
    leader := me@p_pFollowing;
    if leader ~= nil then
	me -- p_pFollowing;
	me -- p_pMeFollowDir;
	Print("You stop following " + FormatName(leader@p_pName) + ".\n");
	followers := leader@p_pFollowers;
	if followers ~= nil then
	    DelElement(followers, me);
	    if Count(followers) = 0 then
		leader -- p_pFollowers;
		leader -- p_pFollowMeDir;
	    fi;
	fi;
    fi;
corp;

/* general code dealing with entering and exiting rooms, moving, etc. */

define t_util proc EnterRoomStuff(thing dest; int fromDir, moveKind)void:
    thing me;
    bool lightThere;
    string name, s;

    DoRoomAnyEnterActions(dest);
    me := Me();
    lightThere := LightAt(dest);
    SetLocation(dest);
    if lightThere or me@p_oLight or FindFlagOnList(me@p_pCarrying, p_oLight)
    then
	ignore ShowRoomToMe(false);
	/* if I can't see, neither can anyone else */
	if not me@p_pHidden then
	    if lightThere then
		ForEachAgent(dest, ShowIconOnce);
	    fi;
	    name := FormatName(me@p_pName);
	    case moveKind
	    incase MOVE_NORMAL:
		if fromDir >= 0 then
		    s := dest@(DirEMessage(fromDir));
		    if s = "" then
			OPrint(name + " has arrived from " +
				DirName(fromDir) + ".\n");
		    elif s ~= "." then
			OPrint(name + " " + s + "\n");
		    fi;
		fi;
	    incase MOVE_POOF:
		OPrint(name + " *POOFS* in.\n");
	    esac;
	else
	    if moveKind = MOVE_POOF then
		OPrint("*POOF*\n");
	    fi;
	fi;
	if not lightThere then
	    ForEachAgent(dest, ShowRoomToAgent);
	fi;
    else
	Print("It is dark here.\n");
	if dest@p_rEnterRoomDraw ~= nil and GOn(nil) then
	    UnShowRoomFromMe();
	fi;
    fi;
corp;

/*
 * similar stuff for the going out of a room half.
 */

define t_util proc LeaveRoomStuff(thing dest; int dir, moveKind)void:
    thing me, here;
    action a;
    string name, s;
    bool lightHere;

    me := Me();
    here := Here();
    SetLocation(nil);
    lightHere := LightAt(here);
    if lightHere or me@p_oLight or FindFlagOnList(me@p_pCarrying, p_oLight)
    then
	name := FormatName(me@p_pName);
	/* have to use ABPrint, since we have done SetLocation(nil) */
	case moveKind
	incase MOVE_NORMAL:
	    if not me@p_pHidden then
		s := here@(DirOMessage(dir));
		if s = "" then
		    ABPrint(here, me, me,
			name + " has left to " + DirName(dir) + ".\n");
		elif s ~= "." then
		    ABPrint(here, me, me, name + " " + s + "\n");
		fi;
		CheckFollowers(here, dir);
	    fi;
	    /* we keep the rest in case he/she went hidden while here */
	    s := here@(DirMessage(dir));
	    if s ~= "" then
		NPrint(s);
	    fi;
	incase MOVE_POOF:
	    if me@p_pHidden then
		ABPrint(here, me, me, "*POOF*\n");
	    else
		ABPrint(here, me, me, name + " *POOFS* out.\n");
	    fi;
	    Print("*POOF*\n");
	    ClearFollowers(me);
	    UnFollow();
	esac;
	ForEachAgent(here, UnShowIconOnce);
	if GOn(nil) then
	    GUndrawIcons(nil);
	    GResetIcons(nil);
	    a := here@p_rLeaveRoomDraw;
	    if a ~= nil then
		call(a, void)(dest);
	    fi;
	fi;
	if not lightHere then
	    ForEachAgent(here, UnShowRoomFromAgent);
	fi;
    fi;
    /* put the location back to the old room for DoRoomAnyEnterActions */
    SetLocation(here);
corp;

/*
 * EnterRoom - called whenever the player finally enters a given room.
 *	Returns 'true' if all is well and we should continue with commands.
 */

define t_util proc public EnterRoom(thing dest; int dir, moveType)bool:

    LeaveRoomStuff(dest, dir, moveType);
    EnterRoomStuff(dest, DirBack(dir), moveType);
    ignore DoPlayerEnterChecks(Me());
    /* allow for funny things like instant teleports out, etc. */
    DoRoomAnyEnterChecks(dest) ~= fail
corp;

/*
 * DoMove - bottom level routine to attempt to move in the given direction.
 *	Note: not suitable for other than called by the player.
 *	Other Note: it should work indirectly for machines, e.g. when
 *	    someone does 'say Packrat go north'.
 */

define t_util proc public DoMove(int dir)bool:
    thing me, here, dest;
    string s;
    action a;

    me := Me();
    if me@p_pPosition ~= POS_NONE then
	Print("You are still ");
	ShowPosition(me);
	false
    else
	here := Here();
	dest := here@(DirProp(dir));
	if dest = nil then
	    a := here@p_rNoGoAction;
	    if a ~= nil then
		call(a, void)(dir);
	    else
		s := here@p_rNoGoString;
		if s ~= "" then
		    NPrint(s);
		else
		    Print("You can't go in that direction.\n");
		fi;
	    fi;
	    false
	elif dest@p_rLocked and CharacterThing(Owner(dest)) ~= me and
	    me ~= CharacterThing(SysAdmin)
	then
	    Print("The owner of that location has locked it.\n");
	    false
	elif DoPlayerLeaveChecks(me, dir) ~= fail and
	    DoChecks(here@(DirChecks(dir))) ~= fail and
	    DoRoomAnyLeaveChecks(here) ~= fail
	then
	    /* nothing was blocking the exit, nothing abnormal happened
	       when we tried to go through, and nothing funny like player
	       being chained to the floor */
	    EnterRoom(dest, dir, MOVE_NORMAL)
	else
	    false
	fi
    fi
corp;

ForwardReference@pDoMove := DoMove.

/*
 * UserMove - the user is explicitly moving.
 */

define t_util proc UserMove(int dir)bool:

    UnFollow();
    DoMove(dir)
corp;

/*
 * TryToMove - similar to 'DoMove', but intended for machines.
 *	Returns 'true' if it can do the move.
 *	Note: intended only for calling by the machine doing the moving.
 */

define t_util proc public TryToMove(int dir)bool:
    thing here, there, me;

    here := Here();
    me := Me();
    there := here@(DirProp(dir));
    if there = nil then
	false
    else
	not there@p_rNoMachines and not there@p_rLocked and
	    me@p_pPosition = POS_NONE and
	    DoPlayerLeaveChecks(me, dir) ~= fail and
	    DoChecks(here@(DirChecks(dir))) ~= fail and
	    DoRoomAnyLeaveChecks(here) ~= fail
    fi
corp;

/*
 * MachineMove - do the other half of 'DoMove' for machines. This does NOT
 *	use any of the exit checkers. It should be used with 'TryToMove',
 *	and not by itself.
 *	Note: intended only to be called by the machine doing the move.
 */

define t_util proc public MachineMove(int dir)void:
    thing here, me, dest;
    string myName, s;
    bool otherLight, meLight;

    here := Here();
    me := Me();
    myName := FormatName(me@p_pName);
    dest := here@(DirProp(dir));
    if dest ~= nil then
	meLight := me@p_oLight or FindFlagOnList(me@p_pCarrying, p_oLight);
	otherLight := LightAt(here);
	if otherLight or meLight then
	    if not me@p_pHidden then
		s := here@(DirOMessage(dir));
		if s = "" then
		    OPrint(myName + " has left to " + DirName(dir) + ".\n");
		elif s ~= "." then
		    OPrint(myName + " " + s + "\n");
		fi;
		CheckFollowers(here, dir);
	    fi;
	    if not otherLight then
		ForEachAgent(here, UnShowRoomFromAgent);
	    else
		/* we keep this in case it went hidden while here */
		ForEachAgent(here, UnShowIconOnce);
	    fi;
	fi;
	/* The following is a subset of EnterRoom. It is cheaper, since the
	   machine doesn't have to be told about the room and what and who
	   is in it. */
	SetLocation(nil);
	otherLight := LightAt(dest);
	SetLocation(dest);
	if otherLight or meLight then
	    dir := DirBack(dir);
	    s := dest@(DirEMessage(dir));
	    if s = "" then
		OPrint(myName + " has arrived from " + DirName(dir) + ".\n");
	    elif s ~= "." then
		OPrint(myName + " " + s + "\n");
	    fi;
	    if not otherLight then
		ForEachAgent(dest, ShowRoomToAgent);
	    else
		ForEachAgent(dest, ShowIconOnce);
	    fi;
	fi;
	/* allow monster gen, etc. */
	ignore DoPlayerEnterChecks(me);
	/* allow for funny things like instant teleports out, etc. */
	ignore DoRoomAnyEnterChecks(dest);
    else
	OPrint("BUGGY MACHINE " + myName + " IS STUCK HERE.\n");
    fi;
corp;

/*
 * GetAgents - return a string which is a comma separated list of the
 *	names of the agents in the given room.
 */

define tp_util p_pAgentList CreateStringProp().

define tp_util proc addAnAgent(thing agent)void:
    thing me;
    string name, s;

    me := Me();
    name := agent@p_pName;
    if name ~= "" and not agent@p_pHidden then
	s := me@p_pAgentList;
	if s ~= "" then
	    s := s + ", ";
	fi;
	s := s + FormatName(name);
	me@p_pAgentList := s;
    fi;
corp;

define t_util proc GetAgents(thing room)string:
    string s;

    ForEachAgent(room, addAnAgent);
    s := Me()@p_pAgentList;
    Me() -- p_pAgentList;
    s
corp;

/*
 * AddLight - introduce a source of light to the current room.
 */

define t_util proc public AddLight()void:
    if not CanSee(Here(), Me()) then
	ignore ShowRoomToMe(false);
	ForEachAgent(Here(), ShowRoomToAgent);
    fi;
corp;

/*
 * ActiveLightObject - an object is made to now emit light.
 */

define t_util proc public ActiveLightObject()status:
    thing it;
    string name;

    it := It();
    name := FormatName(it@p_oName);
    if it@p_oLight then
	Print("The " + name + " is already lit.\n");
	fail
    else
	Print("You light the " + name + ".\n");
	OPrint(Me()@p_pName + AAn(" lights", name) + ".\n");
	AddLight();
	it@p_oLight := true;
	/* want these to be succeed to allow proper use with VerbHere, etc. */
	succeed
    fi
corp;

/*
 * RemoveLight - remove a source of light from the current room.
 */

define t_util proc public RemoveLight()void:
    if not CanSee(Here(), Me()) then
	UnShowRoomFromMe();
	ForEachAgent(Here(), UnShowRoomFromAgent);
    fi;
corp;

/*
 * ActiveUnLightObject - an object is made to no longer emit light.
 */

define t_util proc public ActiveUnLightObject()status:
    thing it;
    string name;

    it := It();
    name := FormatName(it@p_oName);
    if not it@p_oLight then
	Print("The " + name + " is not lit.\n");
	fail
    else
	Print("You extinguish the " + name + ".\n");
	it@p_oLight := false;
	RemoveLight();
	succeed
    fi
corp;

/*
 * PassiveUnLightObject - an object is going out, independent of any player.
 */

define t_util proc public PassiveUnLightObject(thing object)void:
    thing who, where;
    character ch;

    object@p_oLight := false;
    who := object@p_oCarryer;
    where := object@p_oWhere;
    if who ~= nil then
	SPrint(who, "Your " + FormatName(object@p_oName) + " has gone out.\n");
	ch := Character(who@p_pName);
	if ch ~= nil and CharacterThing(ch) = who then
	    where := CharacterLocation(ch);
	    if not LightAt(where) then
		ForEachAgent(where, UnShowRoomFromAgent);
	    fi;
	fi;
    elif where ~= nil and not LightAt(where) then
	ForEachAgent(where, UnShowRoomFromAgent);
    fi;
corp;

/*
 * CarryItem - try to add an item to the carry list. If too many complain
 *	and return false, else add the item and return true.
 */

define t_util proc CarryItem(thing object)bool:
    thing me;
    list thing carrying;

    me := Me();
    carrying := me@p_pCarrying;
    if Count(carrying) >= MAX_CARRY then
	Print("You can't carry anything else.\n");
	false
    else
	AddTail(carrying, object);
	object@p_oCarryer := me;
	true
    fi
corp;

/*
 * GetDocument - get a long document - e.g. description, letter, etc.
 *	Callable by player or machine - will do nothing for a machine.
 *	There are some things to watch out for here. We want these routines
 *	to be 'utility' so that they can be used properly by the build code.
 */

define tp_util p_pOldDoc CreateStringProp().
define tp_util p_pTempString CreateStringProp().
define tp_util p_pSavePrompt CreateStringProp().
define tp_util p_pSaveAction CreateActionProp().
define tp_util p_pEndAction CreateActionProp().
define tp_util p_pSaveIdleAction CreateActionProp().
define tp_util p_pRawDocument CreateBoolProp().

define tp_util proc utility appendToDocument(string line)void:
    action endAction;
    thing me, letter;
    string s;
    int len;

    me := Me();
    s := me@p_pTempString;
    len := Length(s);
    if line = "." then
	ignore SetCharacterIdleAction(me@p_pSaveIdleAction);
	me -- p_pSaveIdleAction;
	if me@p_pSaveAction ~= nil then
	    ignore SetCharacterInputAction(me@p_pSaveAction);
	    me -- p_pSaveAction;
	    ignore SetPrompt(me@p_pSavePrompt);
	    me -- p_pSavePrompt;
	fi;
	me -- p_pTempString;
	me -- p_pOldDoc;
	endAction := me@p_pEndAction;
	me -- p_pEndAction;
	me -- p_pRawDocument;
	if len >= 4000 then
	    Print("*** Warning - input may have been truncated. ***\n");
	fi;
	/* call this so that, e.g. a normal person using the build code can
	   modify his own objects that are ts_readonly */
	call(endAction, void)(s);
    else
	if len >= 4000 then
	    Print("*** Warning - input has been truncated. ***\n");
	else
	    if me@p_pRawDocument then
		me@p_pTempString := s + line + "\n";
	    else
		if line ~= "" then
		    if s ~= "" then
			s := s + " ";
		    fi;
		    me@p_pTempString := s + line;
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_util proc utility docIdleAction()void:
    action a;

    a := Me()@p_pSaveIdleAction;
    Me()@p_pTempString := Me()@p_pOldDoc;
    appendToDocument(".");
    if a ~= nil then
	call(a, void)();
    fi;
corp;

define tp_util proc utility docEndAction(string s; bool ok)void:

    if ok then
	Me()@p_pTempString := s;
    else
	Me()@p_pTempString := Me()@p_pOldDoc;
    fi;
    appendToDocument(".");
corp;

define t_util proc utility GetDocument(string prompt, intro, oldDoc;
	action endAction; bool isRaw)bool:
    thing me;
    action oldAction;

    me := Me();
    if CanEdit() then
	if Editing() then
	    Print("You are alreadying editing something!\n");
	    false
	else
	    me@p_pTempString := "";
	    me@p_pEndAction := endAction;
	    me@p_pRawDocument := isRaw;
	    oldAction := SetCharacterIdleAction(docIdleAction);
	    if oldAction ~= nil then
		me@p_pSaveIdleAction := oldAction;
	    fi;
	    me@p_pOldDoc := oldDoc;
	    EditString(oldDoc, docEndAction, isRaw, intro);
	    true
	fi
    else
	oldAction := SetCharacterInputAction(appendToDocument);
	if oldAction = nil then
	    /* must have been a machine! */
	    OPrint(FormatName(me@p_pName) + " is confused.\n");
	    false
	else
	    Print(intro +
		". End with a line containing only a single period.\n");
	    me@p_pTempString := "";
	    me@p_pSavePrompt := SetPrompt("* " + prompt);
	    me@p_pSaveAction := oldAction;
	    me@p_pEndAction := endAction;
	    me@p_pRawDocument := isRaw;
	    oldAction := SetCharacterIdleAction(docIdleAction);
	    if oldAction ~= nil then
		me@p_pSaveIdleAction := oldAction;
	    fi;
	    true
	fi
    fi
corp;

/*
 * GetCheckedDescription - variant which lets a routine of the callers handle
 *	each of the input lines.
 */

define t_util proc utility GetCheckedEnd()void:
    thing me;

    me := Me();
    ignore SetCharacterIdleAction(me@p_pSaveIdleAction);
    me -- p_pSaveIdleAction;
    ignore SetCharacterInputAction(me@p_pSaveAction);
    me -- p_pSaveAction;
    ignore SetPrompt(me@p_pSavePrompt);
    me -- p_pSavePrompt;
corp;

define tp_util proc utility checkedDescIdleAction()void:
    thing me;
    action a;

    me := Me();
    a := SetCharacterInputAction(me@p_pSaveAction);
    if a ~= nil then
	me -- p_pSaveAction;
	call(a, void)(".");
    fi;
    ignore SetPrompt(me@p_pSavePrompt);
    me -- p_pSavePrompt;
    a := me@p_pSaveIdleAction;
    if a ~= nil then
	me -- p_pSaveIdleAction;
	call(a, void)();
    fi;
corp;

define t_util proc utility GetCheckedDescription(string prompt;
	action lineHandler)bool:
    thing me;
    action oldAction;

    me := Me();
    oldAction := SetCharacterInputAction(lineHandler);
    if oldAction = nil then
	/* must have been a machine! */
	OPrint(FormatName(me@p_pName) + " is confused.\n");
	false
    else
	me@p_pSaveAction := oldAction;
	me@p_pSavePrompt := SetPrompt("* " + prompt);
	oldAction := SetCharacterIdleAction(checkedDescIdleAction);
	if oldAction ~= nil then
	    me@p_pSaveIdleAction := oldAction;
	fi;
	true
    fi
corp;

/*
 * Paginate - paginate a string within the output screen size.
 */

define tp_util paginateThing CreateThing(nil).
define tp_util p_paginateParse CreateActionProp().
define tp_util p_pPaginateSetup CreateBoolProp().
define tp_util p_pPaginateString CreateStringProp().
define tp_util p_pPaginateLen CreateIntProp().
define tp_util p_pPaginatePrompt CreateStringProp().
define tp_util p_pPaginateHandler CreateActionProp().
define tp_util p_pPaginateIdle CreateActionProp().

define tp_util proc paginateReset(bool goingIdle)void:
    thing me;
    action a;

    me := Me();
    me -- p_pPaginateString;
    me -- p_pPaginateLen;
    if me@p_pPaginateSetup then
	me -- p_pPaginateSetup;
	ignore SetPrompt(me@p_pPaginatePrompt);
	me -- p_pPaginatePrompt;
	ignore SetCharacterInputAction(me@p_pPaginateHandler);
	me -- p_pPaginateHandler;
	a := me@p_pPaginateIdle;
	me -- p_pPaginateIdle;
	ignore SetCharacterIdleAction(a);
	if goingIdle and a ~= nil then
	    call(a, void)();
	fi;
    fi;
corp;

define tp_util proc paginateIdle()void:
    paginateReset(true);
corp;

define tp_util proc paginateShowPage()void:
    thing me;
    string s;
    int len, i, line, height, width;

    me := Me();
    s := me@p_pPaginateString;
    len := me@p_pPaginateLen;
    height := TextHeight(0) - 1;
    width := TextWidth(0);
    line := 1;
    while len > 0 and line <= height do
	i := Index(s, "\n");
	if i = -1 then
	    Print(s);
	    Print("\n");
	    len := 0;
	else
	    Print(SubString(s, 0, i + 1));
	    s := SubString(s, i + 1, len - i - 1);
	    len := len - i - 1;
	    if i <= width then
		line := line + 1;
	    else
		line := line + (i + width - 4) / (width - 9);
	    fi;
	fi;
    od;
    if len = 0 then
	paginateReset(false);
    else
	me@p_pPaginateString := s;
	me@p_pPaginateLen := len;
	if not me@p_pPaginateSetup then
	    me@p_pPaginateSetup := true;
	    me@p_pPaginatePrompt := SetPrompt("[M O R E] ");
	    me@p_pPaginateHandler :=
		SetCharacterInputAction(paginateThing@p_paginateParse);
	    me@p_pPaginateIdle := SetCharacterIdleAction(paginateIdle);
	fi;
    fi;
corp;

define tp_util proc paginateParse(string line)void:

    if line = "" then
	paginateShowPage();
    elif line == "q" then
	paginateReset(false);
    else
	Print("Options are:\n  q - quit\n  empty line - next page\n");
    fi;
corp;

define t_util proc Paginate(string s)void:
    thing me;

    if GType(nil) == "amiga" then
	/* using full MUD client - no reason to paginate */
	Print(s);
    else
	me := Me();
	me@p_pPaginateString := s;
	me@p_pPaginateLen := Length(s);
	paginateShowPage();
    fi;
corp;

paginateThing@p_paginateParse := paginateParse.

/* code, etc. to assist/handle buying things in stores */

/* pre-create the lost and found room, so that we can set the 'home' of
   things that people buy */

define tp_misc r_lostAndFound CreateThing(r_indoors).
SetupRoom(r_lostAndFound, "in the lost and found room",
    "Things lost often end up here.").

/*
 * AddForSale - add an item for sale at the given location.
 *	Note: we WANT this one 'utility' so that it does not execute with
 *	SysAdmin privileges.
 */

define t_util proc utility public AddForSale(thing room; string name, desc;
	int price; action doBuy)thing:
    thing model;
    list thing lt;

    model := CreateThing(nil);
    SetThingStatus(model, ts_readonly);
    /* other players need to read it when shopping or buying */
    model@p_oName := name;
    if desc ~= "" then
	model@p_oDesc := desc;
    fi;
    model@p_oPrice := price;
    if doBuy ~= nil then
	model@p_oBuyChecker := doBuy;
    fi;
    model@p_oHome := r_lostAndFound;
    lt := room@p_rBuyList;
    if lt = nil then
	lt := CreateThingList();
	room@p_rBuyList := lt;
    fi;
    if FindElement(lt, model) = -1 then
	AddTail(lt, model);
    fi;
    model
corp;

/*
 * AddObjectForSale - make an already defined object be for sale.
 */

define t_util proc utility public AddObjectForSale(thing room, model;
	int price; action doBuy)void:
    list thing lt;

    model@p_oPrice := price;
    if doBuy ~= nil then
	model@p_oBuyChecker := doBuy;
    fi;
    lt := room@p_rBuyList;
    if lt = nil then
	lt := CreateThingList();
	room@p_rBuyList := lt;
    fi;
    if FindElement(lt, model) = -1 then
	AddTail(lt, model);
    fi;
corp;

/*
 * SubObjectForSale - make an object no longer for sale.
 */

define t_util proc utility public SubObjectForSale(thing room, model)bool:
    list thing lt;

    lt := room@p_rBuyList;
    if lt ~= nil then
	if FindElement(lt, model) ~= -1 then
	    DelElement(lt, model);
	    model -- p_oPrice;
	    model -- p_oBuyChecker;
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * ShowForSale - show the things for sale at a player's current location.
 */

define t_util proc public ShowForSale()void:
    list thing lt;
    int count, n, price;
    thing model;

    lt := Here()@p_rBuyList;
    if lt = nil then
	Print("There is nothing for sale here.\n");
    else
	if not Me()@p_pHidden then
	    OPrint(FormatName(Me()@p_pName) + " examines the merchandise.\n");
	fi;
	Print("For sale here:\n");
	count := Count(lt);
	n := 0;
	while n ~= count do
	    model := lt[n];
	    Print(FormatName(model@p_oName));
	    Print(" - ");
	    price := model@p_oPrice;
	    if price = 0 then
		Print("free");
	    elif price = 1 then
		Print("1 bluto");
	    else
		IPrint(price);
		Print(" blutos");
	    fi;
	    Print("\n");
	    n := n + 1;
	od;
    fi;
corp;

/*
 * StoreBuy - let the user buy something at a store. This is used as the
 *	'buy' action at the store location.
 *	Note: this is NOT a utility proc, since we want the object to
 *	      be owned by SysAdmin, and since we use OPrint.
 *	Note: intended only to be called by the player doing the buy.
 *	      Looks like it would work for machines too, however.
 */

define t_util proc public StoreBuy(string what)bool:
    thing here, model, me, th;
    string name;
    int price, money;
    action buyAction;
    status st;

    here := Here();
    if here@p_rBuyList = nil then
	Print("There is nothing for sale here.\n");
	false
    else
	name := FormatName(what);
	st := FindName(here@p_rBuyList, p_oName, what);
	if st = fail then
	    Print(AAn("You cannot buy", name) + " here.\n");
	    false
	elif st = continue then
	    Print(name + " is ambiguous here.\n");
	    false
	else
	    model := FindResult();
	    me := Me();
	    price := model@p_oPrice;
	    money := me@p_pMoney;
	    name := FormatName(model@p_oName);
	    if price > money and not me@p_pPrivileged then
		Print(AAn("You cannot afford", name) + ".\n");
		false
	    else
		th := CreateThing(model);
		/* We want the thing public so that anyone can do things to
		   it. ts_readonly would work not bad, but that prevents
		   a builder from modifying it. We want it owned by SysAdmin
		   so that all the code that is setuid SysAdmin has no
		   trouble with it. We have to do the SetThingStatus BEFORE
		   we give it away, else we will not have access to do so. */
		SetThingStatus(th, ts_public);
		GiveThing(th, SysAdmin);
		if model@p_oContents ~= nil then
		    th@p_oContents := CreateThingList();
		fi;
		th@p_oCreator := me;
		buyAction := model@p_oBuyChecker;
		st := continue;
		if buyAction ~= nil then
		    SetIt(th);
		    st := call(buyAction, status)();
		fi;
		if st ~= fail and CarryItem(th) then
		    if not me@p_pPrivileged then
			me@p_pMoney := money - price;
		    fi;
		    if st = continue then
			Print(AAn("You have just bought", name) + ".\n");
			if not me@p_pHidden then
			    OPrint(FormatName(me@p_pName) +
				   " makes a purchase.\n");
			fi;
		    fi;
		else
		    ClearThing(th);
		fi;
		true
	    fi
	fi
    fi
corp;

/*
 * MakeStore - make a room a store.
 */

define t_util proc utility public MakeStore(thing room)void:

    room@p_rBuyAction := StoreBuy;
corp;

/*
 * IsStore - ask if room is a store.
 */

define t_util proc utility public IsStore(thing room)bool:

    room@p_rBuyAction = StoreBuy
corp;

/*
 * UnmakeStore - make a room no longer a store.
 */

define t_util proc utility public UnmakeStore(thing room)void:

    room -- p_rBuyList;
    room -- p_rBuyAction;
corp;

/*
 * AddSpecialCommand - set things up to add a special this-room-only
 *	command. Note: allowing the use of this procedure is a fairly large
 *	security hole, since the commands thus added take precedence OVER
 *	the normal ones, thus this routine can be used to invoke arbitrary
 *	action when a player uses a presumed safe command. See 'parseInput'
 *	for the actual use of these values.
 */

define tp_util p_rSpecialWords CreateStringProp().
define tp_util p_rSpecialActions CreateActionListProp().

define t_util proc utility public AddSpecialCommand(thing room; string command;
	action a)void:
    list action la;

    la := room@p_rSpecialActions;
    if la = nil then
	la := CreateActionList();
	room@p_rSpecialActions := la;
    fi;
    room@p_rSpecialWords := room@p_rSpecialWords + command + ".";
    AddTail(la, a);
corp;

define t_util proc utility public RemoveSpecialCommand(thing room;
	string command; action a)bool:
    list action la;
    string s;
    int pos, len;

    la := room@p_rSpecialActions;
    if la ~= nil then
	s := room@p_rSpecialWords;
	command := command + ".";
	pos := Index(s, command);
	if pos ~= -1 then
	    len := Length(command);
	    room@p_rSpecialWords := SubString(s, 0, pos) +
		SubString(s, pos + len, Length(s) - pos - len);
	    DelElement(la, a);
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * DoSay - bottom level of saying - here since 'parseInput' uses it.
 *	Needs to be not 'utility' in order to use 'Say'.
 */

define t_util proc public DoSay(string what)void:
    thing me, here;

    here := Here();
    if DoRoomSayChecks(here, what) = continue then
	me := Me();
	if me@p_pEchoPose then
	    Print("You say: " + what + "\n");
	fi;
	Say(if me@p_pHidden or not CanSee(me, here) then "Someone" else "" fi,
	    what);
    fi;
corp;

/*
 * checkAlias - check for and handle an alias on the character. This is
 *	a separate routine so that it is NOT 'utility', but is owned by
 *	SysAdmin. This lets folks other than SysAdmin read the alias
 *	things!
 */

define tp_util proc checkAlias(string s)string:
    list thing aliases;
    thing alias;
    string word;
    int count;
    bool doneIt;

    SetTail(s);
    word := GetWord();
    aliases := Me()@p_pAliases;
    if aliases ~= nil then
	count := Count(aliases);
	doneIt := false;
	while count ~= 0 and not doneIt do
	    count := count - 1;
	    alias := aliases[count];
	    if alias@p_sAliasKey == word then
		s := alias@p_sAliasValue + " " + GetTail();
		doneIt := true;
	    fi;
	od;
    fi;
    s
corp;

/*
 * parseInput - the normal input command handler.
 *	NOTE: we want this to be 'utility', so that the build commands can
 *	be run by the real player. The problem with this is that any message
 *	from 'Parse' will have an '@' in front if it is run by a non-wizard.
 *	I'll kluge that by having 'Parse' force wizard-mode if it needs to
 *	print an error message. Sigh.
 *	Another '@' problem surfaces: if the whole result of the user command
 *	is to print a 'p_oActString', then that output will be prefixed with
 *	'@' when a non-wizard is running. I have implemented 'NPrint' to
 *	hopefully get around this.
 */

define tp_util proc utility parseInput(string s)void:
    action a;
    thing here, it, me;
    string word, specials;
    int which, count;
    bool doneIt;

    if s ~= "" then
	if SubString(s, 0, 1) = "\"" then
	    DoSay(SubString(s, 1, Length(s) - 1));
	else
	    here := Here();
	    me := Me();
	    s := checkAlias(s);
	    SetTail(s);
	    word := GetWord();
	    if FindName(me@p_pCarrying, p_oActWord, word) = fail and
		FindName(here@p_rContents, p_oActWord, word) = fail
	    then
		doneIt := false;
		specials := here@p_rSpecialWords;
		if specials ~= "" then
		    which := MatchName(specials, word);
		    if which >= 0 then
			call(here@p_rSpecialActions[which], void)();
			doneIt := true;
		    fi;
		fi;
		if not doneIt then
		    /* most commands are done right here */
		    ignore Parse(G, s);
		fi;
	    else
		it := FindResult();
		a := it@p_oActAction;
		if a ~= nil then
		    SetIt(it);
		    call(a, void)();
		else
		    NPrint(it@p_oActString);
		fi;
	    fi;
	fi;
    fi;
corp;

/*
 * define constants for the various raw-key codes.
 */

define t_util KEY_HELP		0x0020.
define t_util KEY_KP_UL 	0x0001.
define t_util KEY_KP_U		0x0002.
define t_util KEY_KP_UR 	0x0003.
define t_util KEY_KP_L		0x0004.
define t_util KEY_KP_C		0x0005.
define t_util KEY_KP_R		0x0006.
define t_util KEY_KP_DL 	0x0007.
define t_util KEY_KP_D		0x0008.
define t_util KEY_KP_DR 	0x0009.
define t_util KEY_KP_PLUS	0x000a.
define t_util KEY_KP_MINUS	0x000b.

/*
 * handleRawKey - handle a raw special key-hit.
 *	We want this routine NOT utility, so that there is not an '@' in
 *	front of the command when 'InsertCommand' prints it.
 */

define tp_util proc handleRawKey(int n)void:

    case n
    incase KEY_HELP:
	InsertCommand("help");
    incase KEY_KP_UL:
	InsertCommand("northwest");
    incase KEY_KP_U:
	InsertCommand("north");
    incase KEY_KP_UR:
	InsertCommand("northeast");
    incase KEY_KP_L:
	InsertCommand("west");
    incase KEY_KP_C:
	InsertCommand("look");
    incase KEY_KP_R:
	InsertCommand("east");
    incase KEY_KP_DL:
	InsertCommand("southwest");
    incase KEY_KP_D:
	InsertCommand("south");
    incase KEY_KP_DR:
	InsertCommand("southeast");
    incase KEY_KP_PLUS:
	InsertCommand("up");
    incase KEY_KP_MINUS:
	InsertCommand("down");
    esac;
corp;

/*
 * idleAction - the action that is executed when the player leaves.
 *	These are NOT utility - do not want '@' in front of any output.
 */

define tp_util proc idleAction()void:
    thing here;

    here := Here();
    SetLocation(nil);
    if LightAt(here) then
	ForEachAgent(here, UnShowIconOnce);
    else
	if HasLight(Me()) then
	    ForEachAgent(here, UnShowRoomFromAgent);
	fi;
    fi;
    SetLocation(here);
    Me()@p_MapGroup := NO_MAP_GROUP;
    Me()@p_pStandardGraphicsDone := false;
    OPrint(Me()@p_pName + " has exited the world.\n");
corp;

/*
 * activeAction - the action that is executed when the player re-enters.
 */

define tp_util proc activeAction()void:
    thing here, me;

    here := Here();
    me := Me();
    if GOn(nil) then
	GSetTextColour(nil, 0, me@p_pTextColours[0]);
	GSetTextColour(nil, 1, me@p_pTextColours[1]);
	GSetTextColour(nil, 2, me@p_pTextColours[2]);
	GSetTextColour(nil, 3, me@p_pTextColours[3]);
	InitStandardGraphics();
    else
	me@p_pStandardGraphicsDone := false;
    fi;
    DoList(me@p_pEnterActions);
    ignore Parse(G, "look around");
    ignore ShowClients(false);
    SetLocation(nil);
    if LightAt(here) then
	SetLocation(here);
	ForEachAgent(here, ShowIconOnce);
    else
	SetLocation(here);
	if HasLight(me) then
	    ForEachAgent(here, ShowRoomToAgent);
	fi;
    fi;
    OPrint(me@p_pName + " has entered the world.\n");
corp;

/* Some stuff to implement banks. Note that these properties are private,
   so no-one else can change bank accounts. Note also that the routines are
   NOT utility routines, since we want the things created to represent the
   accounts to not be owned by the player. */

define tp_util p_rBankAccounts CreateThingListProp().	/* bank account list */
define tp_util p_oAccountValue CreateIntProp(). 	/* value in account */
define tp_util p_oAccountOwner CreateThingProp().	/* who owns account */

define tp_util proc bankDeposit()void:
    list thing lt;
    int money, amount, count, i;
    thing me, account;
    string st;

    st := GetWord();
    if st = "" then
	Print("You must say how many blutos you wish to deposit.\n");
    else
	amount := StringToPosInt(st);
	if amount < 0 then
	    Print("Invalid amount - must be a number.\n");
	else
	    lt := Here()@p_rBankAccounts;
	    if lt = nil then
		Print("*** no account list found ***\n");
	    else
		me := Me();
		money := me@p_pMoney;
		if amount > money then
		    Print("You do not have that much money on you.\n");
		else
		    count := Count(lt);
		    i := 0;
		    while
			if i = count then
			    false
			else
			    account := lt[i];
			    account@p_oAccountOwner ~= me
			fi
		    do
			i := i + 1;
		    od;
		    if i = count then
			Print("Setting up a new account for \"");
			Print(me@p_pName);
			Print("\". ");
			account := CreateThing(nil);
			account@p_oAccountOwner := me;
			AddTail(lt, account);
			i := 0;
		    else
			i := account@p_oAccountValue;
		    fi;
		    me@p_pMoney := money - amount;
		    amount := amount + i;
		    account@p_oAccountValue := amount;
		    Print("Thank you for your deposit. Your account now has "
			"a balance of ");
		    if amount = 1 then
			Print("one bluto.\n");
		    else
			IPrint(amount);
			Print(" blutos.\n");
		    fi;
		    if not me@p_pHidden and CanSee(Here(), me) then
			OPrint(FormatName(me@p_pName) +
			    " makes a transaction.\n");
		    fi;
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_util proc bankWithdraw()void:
    list thing lt;
    int amount, count, i;
    thing me, account;
    string st;

    st := GetWord();
    if st = "" then
	Print("You must say how many blutos you wish to withdraw.\n");
    else
	amount := StringToPosInt(st);
	if amount < 0 then
	    Print("Invalid amount - must be a number.\n");
	else
	    lt := Here()@p_rBankAccounts;
	    if lt = nil then
		Print("*** no account list found ***\n");
	    else
		me := Me();
		count := Count(lt);
		i := 0;
		while
		    if i = count then
			false
		    else
			account := lt[i];
			account@p_oAccountOwner ~= me
		    fi
		do
		    i := i + 1;
		od;
		if i = count then
		    Print("I'm sorry, this bank has no account for \"");
		    Print(me@p_pName);
		    Print("\".\n");
		else
		    i := account@p_oAccountValue;
		    if amount > i then
			Print("I'm sorry, you do not have that much in "
			    "your account.\n");
		    else
			me@p_pMoney := me@p_pMoney + amount;
			amount := i - amount;
			account@p_oAccountValue := amount;
			if amount = 0 then
			    Print("Withdrawal made. Your account is now "
				  "empty and has been closed.\n");
			    ClearThing(account);
			    DelElement(lt, account);
			else
			    Print("Withdrawal made. Your account now has a "
				"balance of ");
			    if amount = 1 then
				Print("one bluto.\n");
			    else
				IPrint(amount);
				Print(" blutos.\n");
			    fi;
			fi;
		    fi;
		    if not me@p_pHidden and CanSee(Here(), me) then
			OPrint(FormatName(me@p_pName) +
			    " makes a transaction.\n");
		    fi;
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_util proc bankBalance()void:
    list thing lt;
    int amount, count, i;
    thing me, account;

    lt := Here()@p_rBankAccounts;
    if lt = nil then
	Print("*** no account list found ***\n");
    else
	me := Me();
	count := Count(lt);
	i := 0;
	while
	    if i = count then
		false
	    else
		account := lt[i];
		account@p_oAccountOwner ~= me
	    fi
	do
	    i := i + 1;
	od;
	if i = count then
	    Print("I'm sorry, this bank has no account for \"");
	    Print(me@p_pName);
	    Print("\".\n");
	else
	    amount := account@p_oAccountValue;
	    Print("Your account has a balance of ");
	    if amount = 1 then
		Print("one bluto.\n");
	    else
		IPrint(amount);
		Print(" blutos.\n");
	    fi;
	    if not me@p_pHidden and CanSee(Here(), me) then
		OPrint(FormatName(me@p_pName) + " makes a transaction.\n");
	    fi;
	fi;
    fi;
corp;

/*
 * make this one utility, so people can only do it to their own rooms.
 */

define t_util proc utility public MakeBank(thing room)void:

    room@p_rBankAccounts := CreateThingList();
    AddSpecialCommand(room, "deposit", bankDeposit);
    AddSpecialCommand(room, "withdraw", bankWithdraw);
    AddSpecialCommand(room, "balance", bankBalance);
corp;

define t_util proc utility public IsBank(thing room)bool:

    room@p_rBankAccounts ~= nil
corp;

define t_util proc utility public UnmakeBank(thing room)status:
    list thing accounts;

    accounts := room@p_rBankAccounts;
    if accounts = nil then
	continue
    elif Count(accounts) ~= 0 then
	fail
    else
	room -- p_rBankAccounts;
	ignore RemoveSpecialCommand(room, "deposit", bankDeposit);
	ignore RemoveSpecialCommand(room, "withdraw", bankWithdraw);
	ignore RemoveSpecialCommand(room, "balance", bankBalance);
	succeed
    fi
corp;

/* a couple of handy utilities */

define t_util proc isYes(string s)bool:

    s == "y" or s == "yes" or s == "t" or s == "true"
corp;

define t_util proc isNo(string s)bool:

    s == "n" or s == "no" or s == "n" or s == "false"
corp;

/* Some general routines for setting up verbs that do things to things.
   'VerbCarry' requires that the player be carrying the object in order to
   do whatever to it. 'VerbHere' allows it to be either carried or in the
   room the player is in. It would also be possible to look at things that
   are carried by other players/machines, but I chose not to. Note that
   I check the player, then the room, then the specific object.
   Return 'false' if we were not able to do the action on the requested
   thing, because the thing is not available, or the action fails.
*/

/* A problem has cropped up with the drinking monsters. The code below
   looks for the same properties on the player, the room and the object.
   So, if you try to drink the drinking troll, it will execute the drink
   action on the troll and say that you shouldn't do that. Unfortunately,
   that action is also done when the troll's special action gets the troll
   to 'drink water'. Proper solution is two more properties, sigh. This
   has been done for the indirect case with 'actorCheck'. Thus we do not
   allow the case of attaching a string to the player which is the entire
   result of trying to do that action. */

define t_util proc public commonVerbTail(property string direct;
	property action indirect, actorCheck; thing object;
	string failHeader, verbName, name)bool:
    thing me, here;
    action a;
    string directString;
    status st;
    bool doneOne;

    /* Note: the status values returned by the handler routines are
       interpreted as follows:
	  continue - nothing special - keep looking for something special
	  succeed - successfully handled this case
	  fail - this case is handled, but cease cases and parsing
       The presence of a 'direct' string property is taken to be the same
       as a routine which prints that string and returns 'succeed', with
       the exception that something on a given object will override a
       direct string on a location.
    */

    me := Me();
    here := Here();
    doneOne := false;
    if actorCheck ~= nil then
	a := me@actorCheck;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and indirect ~= nil then
	a := here@indirect;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and direct ~= nil then
	directString := here@direct;
	if directString ~= "" and
	    (object = nil or object@direct = "" and object@indirect = nil)
	then
	    doneOne := true;
	    Print(directString + "\n");
	    st := continue;
	fi;
    fi;
    if not doneOne and object ~= nil and indirect ~= nil then
	a := object@indirect;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and object ~= nil and direct ~= nil then
	directString := object@direct;
	if directString ~= "" then
	    doneOne := true;
	    Print(directString + "\n");
	    st := continue;
	fi;
    fi;
    if doneOne then
	st ~= fail
    elif object = nil then
	Print("You must specify what you want to " + verbName + ".\n");
	false
    else
	Print(failHeader + " the " + name + ".\n");
	true
    fi
corp;

define t_util proc public VerbCarry(string verbName; property string direct;
	property action indirect, actorCheck; string failHeader, what)bool:
    thing object;
    string name;
    status st;
    bool done, ok;
    list thing lt;
    int i, count, oldCount;

    done := false;
    if what = "" then
	object := nil;
    elif what == "all" then
	lt := Me()@p_pCarrying;
	count := Count(lt);
	i := 0;
	ok := true;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck,
		    object, failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	if not done then
	    done := true;
	    Print("You are not carrying anything obvious to " + verbName +
		  ".\n");
	    ok := false;
	fi;
    else
	name := FormatName(what);
	st := FindName(Me()@p_pCarrying, p_oName, what);
	if st = fail then
	    Print(AAn("You are not carrying", name) + ".\n");
	    ok := false;
	    done := true;
	elif st = continue then
	    Print(name + " is ambiguous here.\n");
	    ok := false;
	    done := true;
	else
	    object := FindResult();
	fi;
    fi;
    if done then
	ok
    else
	commonVerbTail(direct, indirect, actorCheck,
		       object, failHeader, verbName, name)
    fi
corp;

define t_util proc public VerbHere(string verbName; property string direct;
	property action indirect, actorCheck; string failHeader, what)bool:
    thing here, object;
    list thing lt;
    int count, i, oldCount;
    string ambig, name;
    status st;
    bool done, ok;

    here := Here();
    done := false;
    object := nil;
    if what == "all" then
	lt := Me()@p_pCarrying;
	count := Count(lt);
	i := 0;
	ok := true;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck, object,
		    failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	lt := here@p_rContents;
	count := Count(lt);
	i := 0;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck,
		    object, failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	if not done then
	    done := true;
	    Print("There is nothing obvious here to " + verbName + ".\n");
	    ok := false;
	fi;
    elif what ~= "" then
	name := FormatName(what);
	ambig := " is ambiguous here.\n";
	st := FindName(Me()@p_pCarrying, p_oName, what);
	if st = fail then
	    st := FindName(here@p_rContents, p_oName, what);
	    if st = fail then
		object := FindAgent(what);
		if object = nil then
		    if MatchName(here@p_rScenery, what) ~= -1 then
			done := true;
			ok := false;
			Print(failHeader + " the " + name + ".\n");
		    fi;
		fi;
	    elif st = continue then
		Print(name);
		Print(ambig);
		ok := false;
		done := true;
	    else
		object := FindResult();
	    fi;
	elif st = continue then
	    Print(name);
	    Print(ambig);
	    ok := false;
	    done := true;
	else
	    object := FindResult();
	fi;
	if object = nil and not done then
	    Print(IsAre("There", "no", name, "here.\n"));
	    done := true;
	    ok := false;
	fi;
    fi;
    if done then
	ok
    else
	commonVerbTail(direct, indirect, actorCheck,
		       object, failHeader, verbName, name)
    fi
corp;

/*
 * ResetObjects - go through a list of objects and put them back where they
 *	belong. This is useful for single-user-at-a-time quests.
 */

define t_util proc utility public ResetObjects(list thing lt)void:
    int count;
    thing object, home, now;

    count := Count(lt);
    while count ~= 0 do
	count := count - 1;
	object := lt[count];
	home := object@p_oHome;
	if home ~= nil then
	    now := object@p_oWhere;
	    if now ~= nil then
		if now ~= home then
		    AddTail(home@p_rContents, object);
		    if now@p_rContents ~= nil then
			DelElement(now@p_rContents, object);
		    else
			DelElement(now@p_oContents, object);
		    fi;
		    object@p_oWhere := home;
		fi;
	    else
		now := object@p_oCarryer;
		if now = nil then
		    Print("An object being reset isn't anywhere!\n"
			"Please inform the owner of this quest.\n");
		else
		    AddTail(home@p_rContents, object);
		    DelElement(now@p_pCarrying, object);
		    object -- p_oCarryer;
		    object@p_oWhere := home;
		    /* Specifically SPrint, so that other players won't see
		       the objects, perhaps secret to the quest, go away.
		       Not just 'Print' in case the quest allows the object
		       to be given to someone else. */
		    SPrint(now, FormatName(object@p_oName) + " vanishes.\n");
		fi;
	    fi;
	fi;
    od;
corp;

/*
 * RemoveAllFromInventory - remove all occurrences of the given object
 *	from the given characters inventory, including inside containers.
 */

define tp_util proc scanList(thing who;list thing lt;thing what;bool top)void:
    int count, i;
    thing th;

    count := Count(lt);
    i := 0;
    while i ~= count do
	th := lt[i];
	if Parent(th) = what then
	    if top then
		SPrint(who, FormatName(what@p_oName) + " vanishes.\n");
	    fi;
	    ClearThing(th);
	    DelElement(lt, th);
	    count := count - 1;
	else
	    if th@p_oContents ~= nil then
		scanList(who, th@p_oContents, what, false);
	    fi;
	    i := i + 1;
	fi;
    od;
corp;
	
define t_util proc RemoveAllFromInventory(thing who, what)void:

    scanList(who, who@p_pCarrying, what, true);
corp;

/* create the arrivals room */

public r_arrivals CreateThing(r_indoors).
SetupRoom(r_arrivals, "in the arrivals room",
    "This room is where new players enter the game.").

/* set up 'SysAdmin' */

CharacterThing(SysAdmin)@p_pDesc :=
    "SysAdmin is the mighty creator of the entire known universe. "
    "His least whim is law. "
    "Nothing is beyond his power. "
    "Beware lest you antagonize him!".
CharacterThing(SysAdmin)@p_pMoney := 10000.
CharacterThing(SysAdmin)@p_pPrivileged := true.
/* do this right away so we can add checkers as they are defined */
CharacterThing(SysAdmin)@p_pEnterActions := CreateActionList().

/*
 * newPlayer - this is the routine which we set up to be called when a
 *	new player is created.
 */

define tp_util proc newPlayer()void:
    string thePlayer;
    thing me;

    me := Me();
    thePlayer := me@p_pName;
    me@p_pCarrying := CreateThingList();
    me@p_pHiddenList := CreateThingList();
    if me@p_pDesc = "" then
	/* not SysAdmin */
	me@p_pDesc := thePlayer + " is a nondescript adventurer.";
    fi;
    if me@p_pEnterActions = nil then
	me@p_pEnterActions := CreateActionList();
    fi;
    me@p_pMoney := 75;
    me@p_pVerbose := true;
    me@p_pSuperBrief := false;
    me@p_pEchoPose := false;
    me@p_pStandard := true;
    me@p_pPosition := POS_NONE;
    me@p_pWhere := me;
    me@p_pCursor := MakeCursor();
    me@p_pCursorColour := C_RED;
    me@p_pIconColour := C_WHITE;
    me@p_pTextColours := CreateIntList();
    AddTail(me@p_pTextColours, 0x000);
    AddTail(me@p_pTextColours, 0xb80);
    AddTail(me@p_pTextColours, 0xa60);
    AddTail(me@p_pTextColours, 0xda0);
    me@p_MapGroup := NO_MAP_GROUP;
    SetLocation(r_arrivals);
    ignore SetCharacterInputAction(parseInput);
    ignore SetCharacterRawKeyAction(handleRawKey);
    ignore SetCharacterButtonAction(StandardButtonHandler);
    ignore SetCharacterMouseDownAction(StandardMouseDownHandler);
    ignore SetCharacterIdleAction(idleAction);
    ignore SetCharacterActiveAction(activeAction);
    if GOn(nil) then
	InitStandardGraphics();
    else
	me@p_pStandardGraphicsDone := false;
    fi;
    DoList(me@p_pEnterActions);
    note - we assume the arrivals room is not dark;
    ForEachAgent(r_arrivals, ShowIconOnce);
    OPrint("New player " + thePlayer + " has appeared.\n");
    Print("Welcome to the sample MUD world, " + thePlayer +
	"! Your character has been created, but it is quite minimal - "
	"you are not carrying anything, and your appearance is dull. "
	"You will soon be able to remedy these conditions. Some of the "
	"commands available: quit, north, n, up, enter, northeast, verbose, "
	"terse, inventory, get, drop, look, examine, etc. Have fun!\n");
    ignore ShowClients(false);
    ignore ShowRoomToMe(true);
corp;

ignore SetNewCharacterAction(newPlayer).

unuse tp_util
