/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * util1.m - a bunch of handy utility routines. Also some core routines for
 *	some standard things used in most dungeons.
 */

private tp_util1 CreateTable()$
use tp_util1


/***************************************************************************/

/* codes for use with LeaveRoomStuff and EnterRoomStuff */

define t_util MOVE_NORMAL	0$
define t_util MOVE_POOF 	1$
define t_util MOVE_SPECIAL	2$


/***************************************************************************/

/* some standard types of rooms */

define t_roomTypes r_indoors CreateThing(nil)$
r_indoors@p_rScenery :=
    "floor,ceiling,air.wall;north,south,east,west,n,s,e,w"$
AutoGraphics(r_indoors, AutoClosedRoom)$
SetThingStatus(r_indoors, ts_readonly)$

define t_roomTypes r_outdoors CreateThing(nil)$
r_outdoors@p_rScenery := "ground,sky,air,sun,sunlight"$
AutoGraphics(r_outdoors, AutoPaths)$
SetThingStatus(r_outdoors, ts_readonly)$

define t_roomTypes r_path CreateThing(r_outdoors)$
r_path@p_rScenery :=
    "ground,sky,air,sun,sunlight,path,pathway,trail,bush,bushes,grass,dust"$
AutoGraphics(r_path, AutoPaths)$
SetThingStatus(r_path, ts_readonly)$

define t_roomTypes r_road CreateThing(r_outdoors)$
r_road@p_rScenery := "ground,sky,air,sun,sunlight,road,dirt,alley,dust"$
AutoGraphics(r_road, AutoRoads)$
SetThingStatus(r_road, ts_readonly)$

define t_roomTypes r_forest CreateThing(r_outdoors)$
r_forest@p_rScenery :=
    "ground,sky,air,sun,sunlight,grass,bush,bushes,tree,leaf,leaves,foliage"$
AutoGraphics(r_forest, AutoPaths)$
AutoPens(r_forest, C_DARK_GREEN, C_BROWN, 0, 0)$
SetThingStatus(r_forest, ts_readonly)$

define t_roomTypes r_field CreateThing(r_outdoors)$
r_field@p_rScenery :=
    "ground,sky,air,sun,sunlight,grass,field,flower,insect,pasture"$
AutoGraphics(r_field, AutoOpenSpace)$
SetThingStatus(r_field, ts_readonly)$

define t_roomTypes r_sidewalk CreateThing(r_outdoors)$
r_sidewalk@p_rScenery :=
    "ground,sky,air,sun,sunlight,sidewalk,pavement,road,dust"$
AutoGraphics(r_sidewalk, AutoPaths)$
SetThingStatus(r_sidewalk, ts_readonly)$

define t_roomTypes r_park CreateThing(r_outdoors)$
r_park@p_rScenery :=
    "ground,sky,air,sun,sunlight,sidewalk,fountain,tree,bush,"
    "bushes,grass.park.flower"$
AutoGraphics(r_park, AutoOpenSpace)$
SetThingStatus(r_park, ts_readonly)$

define t_roomTypes r_tunnel CreateThing(r_indoors)$
r_tunnel@p_rScenery :=
    "floor,ground,air,roof,ceiling,rock,stone."
    "side,wall;north,south,east,west,n,s,e,w"$
AutoGraphics(r_tunnel, AutoTunnels)$
SetThingStatus(r_tunnel, ts_readonly)$


/***************************************************************************/

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
    int len;

    len := Length(newScenery);
    if len ~= 0 then
	len := len - 1;
	/* Trim any extra final '.' given. */
	if SubString(newScenery, len, 1) = "." then
	    newScenery := SubString(newScenery, 0, len);
	fi;
	oldScenery := room@p_rScenery;
	if oldScenery ~= "" then
	    newScenery := oldScenery + "." + newScenery;
	fi;
	room@p_rScenery := newScenery;
    fi;
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
 * HConnect is the same as Connect, except that the connection is not
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


/***************************************************************************/

/* some routines useful for verbs */

/* a couple of handy utilities */

define t_util proc isYes(string s)bool:

    s == "y" or s == "yes" or s == "t" or s == "true"
corp;

define t_util proc isNo(string s)bool:

    s == "n" or s == "no" or s == "n" or s == "false"
corp;

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
		if i ~= count - 1 then
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
    if lt ~= nil then
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
    fi;
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

    doneOne := false;
    if lt ~= nil then
	count := Count(lt);
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
    fi;
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
	    theRoom@p_rContents ~= nil and
		FindFlagOnList(theRoom@p_rContents, p_oLight) or
	    FindAgentWithFlag(theRoom, p_oLight) ~= nil or
	    FindAgentWithFlagOnList(theRoom, p_pCarrying, p_oLight) ~= nil
	elif thePlayer@p_oLight then
	    true
	else
	    FindFlagOnList(thePlayer@p_pCarrying, p_oLight) or
	    theRoom@p_rContents ~= nil and
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
    theRoom@p_rContents ~= nil and
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

define tp_util1 proc containsChild(list thing lt; thing what)thing:
    int count, i;
    thing th;

    if lt = nil then
	nil
    else
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
    fi
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
 * ShowPosition - return the position of the given player/character.
 */

define t_util proc public ShowPosition(thing th)string:
    int pos;

    pos := th@p_pPosition;
    if pos ~= POS_NONE then
	case pos
	incase POS_SIT_IN:
	    "sitting in"
	incase POS_SIT_ON:
	    "sitting on"
	incase POS_LIE_IN:
	    "lying in"
	incase POS_LIE_ON:
	    "lying on"
	incase POS_STAND_IN:
	    "standing in"
	incase POS_STAND_ON:
	    "standing on"
	default:
	    "relative to"
	esac +
	" the " + FormatName(th@p_pWhere@p_oName) + "."
    else
	"here."
    fi
corp;

/*
 * ZapObject - destroy an object, and anything it contains.
 */

define t_util proc public ZapObject(thing object)void:
    list thing lt;
    int count;
    thing th;

    CancelAllDoAfters(object);
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

    if lt ~= nil then
	for i from 0 upto Count(lt) - 1 do
	    ABPrint(lt[i], nil, nil, message);
	od;
    fi;
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
    if st ~= fail then
	if who@p_Image ~= "" then
	    ShowImage(who@p_Image);
	fi;
    fi;
    if st = continue then
	s := CharacterDescription(who);
	name := Capitalize(CharacterNameS(who));
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


/***************************************************************************/

/* some code to aid the 'follow' verb. */

define tp_util1 p_pOldHere CreateThingProp()$
define tp_util1 p_pMeFollowDir CreateIntProp()$
define tp_util1 p_pFollowMeDir CreateIntProp()$

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

define t_util proc public DoMove(int dir)bool: false corp;	/* replaced */

define tp_util1 proc doFollow()status:
    thing me;
    int dir;

    me := Me();
    dir := me@p_pMeFollowDir;
    Print("You follow " + CharacterNameS(me@p_pFollowing) + " to " +
	DirName(dir) + ".\n");
    if DoMove(dir) then
	continue
    else
	fail
    fi
corp;

define tp_util1 proc doCheckFollowers()void:
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
	After(0.0, doCheckFollowers);
    fi;
corp;

define t_util proc ClearFollowers(thing leader)void:
    list thing followers;
    thing follower;
    int i;
    string name;

    followers := leader@p_pFollowers;
    if followers ~= nil then
	name := CharacterNameS(leader);
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
	Print("You stop following " + CharacterNameS(leader) + ".\n");
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


/* NOTE: for the following sets of routines, the code usually just calls the
   the inner (one/once) routine directly via ForEachAgent, just to save one
   interpreted subroutine call. */

/*
 * ShowAgents - show who/what is in the current room.
 */

define t_util proc public ShowOneAgent(thing th)void:

    if th@p_pName ~= "" and not th@p_pHidden then
	Print(Capitalize(CharacterNameG(th)) + " is " + 
		ShowPosition(th) + "\n");
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
	    elif room@p_Image ~= "" then
		ShowImage(room@p_Image);
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

define tp_util1 proc doShowRoom()status:

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

define tp_util1 proc doUnShowRoom()status:

    UnShowRoomFromMe();
    continue
corp;

define t_util proc UnShowRoomFromAgent(thing who)void:

    if who ~= Me() and ThingCharacter(who) ~= nil then
	/* only do it for players */
	ignore ForceAction(who, doUnShowRoom);
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
	    name := Capitalize(CharacterNameG(me));
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
	name := Capitalize(CharacterNameG(me));
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
 * DoMove - top level routine to attempt to move in the given direction.
 *	Note: not suitable for other than called by the player.
 *	Other Note: it should work indirectly for machines, e.g. when
 *	    someone does 'say Packrat go north'.
 */

replace DoMove(int dir)bool:
    thing me, here, dest;
    string s;
    action a;
    property list action checks;

    me := Me();
    if me@p_pPosition ~= POS_NONE then
	Print("You are still " + ShowPosition(me) + "\n");
	false
    else
	here := Here();
	dest := here@(DirProp(dir));
	checks := DirChecks(dir);
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
	elif (dest@p_rName = "" and dest@p_rNameAction = nil or
	    dest@p_rExits = nil or dest@p_rContents = nil) and
	    (here@checks = nil or Count(here@checks) = 0)
	then
	    Print("The location in that direction is not usable.\n");
	    false
	elif DoPlayerLeaveChecks(me, dir) ~= fail and
	    DoChecks(here@checks) ~= fail and
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
    if there = nil or
	there@p_rName = "" and there@p_rNameAction = nil or
	there@p_rExits = nil or there@p_rContents = nil
    then
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
    myName := Capitalize(CharacterNameG(me));
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

define tp_util1 p_pAgentList CreateStringProp()$

define tp_util1 proc addAnAgent(thing agent)void:
    thing me;
    string name, s;

    me := Me();
    name := agent@p_pName;
    if name ~= "" and not agent@p_pHidden then
	name := FormatName(name);
	s := me@p_pAgentList;
	if s ~= "" then
	    s := s + ", ";
	fi;
	s := s + name;
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


/***************************************************************************/

/* Stuff relating to top-level things in the scenario */

/*
 * AddSpecialCommand - set things up to add a special this-room-only
 *	command. Note: allowing the use of this procedure is a fairly large
 *	security hole, since the commands thus added take precedence OVER
 *	the normal ones, thus this routine can be used to invoke arbitrary
 *	action when a player uses a presumed safe command. See 'parseInput'
 *	for the actual use of these values.
 */

define tp_util1 p_rSpecialWords CreateStringProp()$
define tp_util1 p_rSpecialActions CreateActionListProp()$

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

define tp_util1 proc checkAlias(string s)string:
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

define tp_misc proc utility parseInput(string s)void:
    action a;
    thing here, it, me;
    string word, specials;
    int which, count;
    bool doneIt;

    while SubString(s, 0, 1) = ";" do
	s := SubString(s, 1, Length(s) - 1);
    od;
    if s ~= "" then
	GlobalThing@p_FlushNeeded := true;
	if SubString(s, 0, 1) = "\"" or SubString(s, 0, 1) = "'" then
	    DoSay(SubString(s, 1, Length(s) - 1));
	else
	    here := Here();
	    me := Me();
	    s := checkAlias(s);
	    SetTail(s);
	    word := GetWord();
	    if FindName(me@p_pCarrying, p_oActWord, word) = fail and
		(here@p_rContents = nil or
		 FindName(here@p_rContents, p_oActWord, word) = fail)
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

define t_util KEY_HELP		0x0020$
define t_util KEY_KP_UL 	0x0001$
define t_util KEY_KP_U		0x0002$
define t_util KEY_KP_UR 	0x0003$
define t_util KEY_KP_L		0x0004$
define t_util KEY_KP_C		0x0005$
define t_util KEY_KP_R		0x0006$
define t_util KEY_KP_DL 	0x0007$
define t_util KEY_KP_D		0x0008$
define t_util KEY_KP_DR 	0x0009$
define t_util KEY_KP_PLUS	0x000a$
define t_util KEY_KP_MINUS	0x000b$

/*
 * handleRawKey - handle a raw special key-hit.
 *	We want this routine NOT utility, so that there is not an '@' in
 *	front of the command when 'InsertCommand' prints it.
 */

define tp_misc proc handleRawKey(int n)void:

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

define tp_misc proc idleAction()void:
    thing me, here;

    me := Me();
    DoList(me@p_pExitActions);

    here := Here();
    SetLocation(nil);
    if LightAt(here) then
	ForEachAgent(here, UnShowIconOnce);
    else
	if HasLight(me) then
	    ForEachAgent(here, UnShowRoomFromAgent);
	fi;
    fi;
    SetLocation(here);
    OPrint(Capitalize(me@p_pName) + " has exited the world.\n");
    GlobalThing@p_FlushNeeded := true;
corp;

/*
 * activeAction - the action that is executed when the player re-enters.
 */

define tp_misc proc activeAction()void:
    thing here, me;

    here := Here();
    me := Me();
    me@p_MapGroup := NO_MAP_GROUP;
    if GOn(nil) then
	GSetTextColour(nil, 0, me@p_pTextColours[0]);
	GSetTextColour(nil, 1, me@p_pTextColours[1]);
	GSetTextColour(nil, 2, me@p_pTextColours[2]);
	GSetTextColour(nil, 3, me@p_pTextColours[3]);
	InitStandardGraphics();
    else
	me@p_pStandardGraphicsDone := false;
    fi;

    OPrint(Capitalize(me@p_pName) + " has entered the world.\n");

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
corp;


/***************************************************************************/

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

define tp_util1 proc scanList(thing who;list thing lt;thing what;bool top)void:
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


/***************************************************************************/

/* create the arrivals room */

public r_arrivals CreateThing(r_indoors)$
SetupRoom(r_arrivals, "in the arrivals room",
    "This room is where new players enter the game.")$

/* set up 'SysAdmin' */

CharacterThing(SysAdmin)@p_pDesc :=
    "SysAdmin is the mighty creator of the entire known universe. "
    "His least whim is law. "
    "Nothing is beyond his power. "
    "Beware lest you antagonize him!"$
CharacterThing(SysAdmin)@p_pMoney := 10000$
CharacterThing(SysAdmin)@p_pPrivileged := true$
/* do this right away so we can add checkers as they are defined */
CharacterThing(SysAdmin)@p_pEnterActions := CreateActionList()$
CharacterThing(SysAdmin)@p_pExitActions := CreateActionList()$


unuse tp_util1
