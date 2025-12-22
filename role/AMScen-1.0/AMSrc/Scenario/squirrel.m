/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * squirrel.m - a little quest.
 */

use t_streets

private tp_squirrel CreateTable().
use tp_squirrel

define tp_squirrel r_squirrelValley CreateThing(r_forest).
AutoGraphics(r_squirrelValley, AutoOpenSpace).
AutoPens(r_squirrelValley, C_FOREST_GREEN, C_GREEN, 0, 0).
SetThingStatus(r_squirrelValley, ts_readonly).

define tp_squirrel p_rIsTrunk CreateBoolProp().
define tp_squirrel p_rIsBranch CreateBoolProp().
define tp_squirrel p_rTopTrunk CreateBoolProp().
define tp_squirrel p_rSquirrelPath CreateThingProp().
define tp_squirrel p_objects CreateThingListProp().
define tp_squirrel p_tapes CreateThingListProp().
define tp_squirrel p_rSquirrelUser CreateThingProp().
define tp_squirrel p_mMoving CreateBoolProp().
define tp_squirrel p_pSquirrelWord CreateStringProp().
define tp_squirrel p_rFirstWrap CreateBoolProp().

define tp_squirrel Squirrel CreateThing(nil).
define tp_squirrel squirrelThing CreateThing(nil).
define tp_squirrel r_valley13 CreateThing(r_squirrelValley).
define tp_squirrel r_alcove CreateThing(r_indoors).
define tp_squirrel o_bugTape CreateThing(nil).
define tp_squirrel o_wad CreateThing(nil).
define tp_squirrel o_weed CreateThing(nil).

SetThingStatus(squirrelThing, ts_readonly).
squirrelThing@p_objects := CreateThingList().
squirrelThing@p_tapes := CreateThingList().
squirrelThing@p_rFirstWrap := true.

/* the basic movement routine for the squirrel */

define tp_squirrel proc notifyPlayer(string message)void:
    thing who;

    who := squirrelThing@p_rSquirrelUser;
    if who ~= nil then
	SPrint(who, message);
    fi;
corp;

define tp_squirrel proc squirrelStep()void:
    thing me, here, there, userLoc;
    int dir, firstDir, leapCount;
    bool keepMoving;
    string s;

    me := Me();
    here := Here();
    if squirrelThing@p_rSquirrelUser = nil then
	userLoc := r_alcove;	    /* somewhere she never goes */
    else
	userLoc := AgentLocation(squirrelThing@p_rSquirrelUser);
    fi;
    keepMoving := true;
    if here ~= r_valley13 then
	/* try to move on a branch */
	dir := Random(8);   /* 0 = D_NORTH ... 7 = D_NORTHWEST */
	firstDir := dir;
	while
	    there := here@(DirProp(dir));
	    if there ~= nil and userLoc ~= there and
		not FindChildOnList(there@p_rContents, o_bugTape)
	    then
		SetLocation(there);
		notifyPlayer("The squirrel hops cutely to " +
		    DirName(dir) + " along a branch.\n");
		keepMoving := false;
	    else
		if dir = D_NORTHWEST then
		    dir := D_NORTH;
		else
		    dir := dir + 1;
		fi;
	    fi;
	    keepMoving and dir ~= firstDir
	do
	od;
    fi;
    if keepMoving then
	/* cannot go out on a branch - try going up */
	there := here@p_rUp;
	if there ~= nil and userLoc ~= there and not here@p_rTopTrunk then
	    SetLocation(there);
	    notifyPlayer("The squirrel scampers pertly up the trunk.\n");
	    /* do NOT stop here */
	elif here@p_rSquirrelPath ~= nil then
	    /* Leaping down the tree. Keep going until she hits the
	       ground, or a safe spot. */
	    leapCount := 1;
	    there := here;
	    while
		there := there@p_rSquirrelPath;
		FindChildOnList(there@p_rContents, o_bugTape) or
		    userLoc = there
	    do
		leapCount := leapCount + 1;
	    od;
	    SetLocation(there);
	    if here@p_rIsTrunk then
		s := "The squirrel climbs up to the small topmost branches, "
		    "takes ";
	    else
		s := "The squirrel runs out on the smaller branches, takes ";
	    fi;
	    if leapCount = 1 then
		s := s + "a graceful leap";
	    else
		s := s + IntToString(leapCount) + " graceful leaps";
	    fi;
	    s := s + ", and lands on ";
	    if not there@p_rIsBranch then
		s := s + "the ground. From there, she trots to the base "
		    "of the tree.\n";
		SetLocation(r_valley13);
	    else
		s := s + "a branch lower down.\n";
		SetLocation(there);
	    fi;
	    notifyPlayer(s);
	    /* she does NOT stop in either case */
	else
	    /* she is trapped! */
	    keepMoving := false;
	    SetLocation(nil);
	    s := "";
	    for leapCount from 1 upto 4 + Random(4) do
		s := s + SubString("intrepdulpedardrittolvyeootbik",
				   3 * Random(10), 3);
	    od;
	    squirrelThing@p_rSquirrelUser@p_pSquirrelWord := s;
	    notifyPlayer("You have trapped the squirrel! She looks at you "
		"with evident alarm, whispers '" + s + "' to you and then "
		"takes an impossible leap down the tree and vanishes!\n");
	fi;
    fi;
    Squirrel@p_mMoving := keepMoving;
corp;

define tp_squirrel proc noMove()void:
    thing who, where;

    who := squirrelThing@p_rSquirrelUser;
    if who ~= nil then
	where := AgentLocation(who);
	if where@p_rIsTrunk or where@p_rIsBranch then
	    SPrint(who, "The squirrel chatters at you from her perch.\n");
	fi;
    fi;
    After(20 + Random(30), noMove);
corp;

Squirrel@p_pStandard := true.
Squirrel@p_mMoving := false.
Squirrel@p_Image := "Characters/Squirrel".
SetupMachine(Squirrel).
CreateMachine("Squirrel", Squirrel, r_valley13, noMove).

define tp_squirrel proc doStep()status:
    squirrelStep();
    continue
corp;

/* a leave checker in use in this area */

define tp_squirrel proc squirrelLeaveChecker(int dir)status:
    thing place;

    place := Here();
    if dir = D_UP then
	if AgentLocation(Squirrel) = place@p_rUp then
	    /* climbing up to the squirrel - move her */
	    ignore ForceAction(Squirrel, doStep);
	fi;
	continue
    else
	place := place@(DirProp(dir));
	if FindChildOnList(place@p_rContents, o_bugTape) and place@p_rIsBranch
	then
	    Print("There is no way you are going to crawl onto that sticky "
		"bug tape over there!\n");
	    fail
	else
	    if AgentLocation(Squirrel) = place then
		if place = r_valley13 then
		    Print(
			"As you walk towards the tree, you notice a squirrel "
			"under it watching you. She is the prettiest squirrel "
			"you have ever seen, with a cute nose, innocent blue "
			"eyes and soft, deep fur. Most prominent of all, "
			"however, is her gorgeous tail, rising in a graceful "
			"curve over her back.\n");
		fi;
		/* crawling out to the squirrel - move her */
		ignore ForceAction(Squirrel, doStep);
	    fi;
	    continue
	fi
    fi
corp;

/* an enter checker in use for this area (called AFTER the leave checker) */

define tp_squirrel proc squirrelEnterChecker()status:

    while Squirrel@p_mMoving do
	ignore ForceAction(Squirrel, doStep);
    od;
    continue
corp;

define tp_squirrel proc squirrelIdle()void: corp;	/* replaced later */

/* a proc to reset this quest when the user of it leaves */

define tp_squirrel proc resetSquirrelStuff(thing who)void:
    list thing lt;
    int count, i;
    thing th;

    squirrelThing -- p_rSquirrelUser;
    squirrelThing@p_rFirstWrap := true;
    SetAgentLocation(Squirrel, r_valley13);
    ResetObjects(squirrelThing@p_objects);
    RemoveAllFromInventory(who, o_bugTape);
    RemoveAllFromInventory(who, o_wad);
    RemoveAllFromInventory(who, o_weed);
    lt := squirrelThing@p_tapes;
    count := Count(lt);
    while count ~= 0 do
	count := count - 1;
	th := lt[count];
	if th@p_oWhere ~= nil then
	    /* Could be a weed that was being carried, so we will already
	       have 'ClearThing'ed it, etc. above; just need to delete it
	       from the tapes list. */
	    DelElement(th@p_oWhere@p_rContents, th);
	    ClearThing(th);
	fi;
	DelElement(lt, th);
    od;
    DelPlayerLeaveChecker(who, squirrelLeaveChecker);
    DelPlayerEnterChecker(who, squirrelEnterChecker);
    DelElement(who@p_pExitActions, squirrelIdle);
corp;

/* let the player know they left the area */

define tp_squirrel proc squirrelMessage()void:

    DelElement(Me()@p_pEnterActions, squirrelMessage);
    Print("\n* You were inside the Squirrel Quest area when you exited "
	"the MUD. Your character was removed from the "
	"Squirrel Quest area, and the area was reset, so that others "
	"could use it. *\n\n");
corp;

/* an idle handler for this area */

replace squirrelIdle()void:

    resetSquirrelStuff(Me());
    SetLocation(r_alcove);
    AddHead(Me()@p_pEnterActions, squirrelMessage);
corp;

/* let the player know that they were punted from the area */

define tp_squirrel proc squirrelNotify()void:

    DelElement(Me()@p_pEnterActions, squirrelNotify);
    Print("\n* You were inside the Squirrel Quest area when a backup of "
	"the database was made. The server was later restarted from that "
	"backup. At that time, your character was removed from the "
	"Squirrel Quest area, and the area was reset, so that others "
	"could use it. *\n\n");
corp;

/* a 'reset from backup' handler for this area */

define tp_squirrel proc squirrelReset(thing th)void:
    thing who;

    who := squirrelThing@p_rSquirrelUser;
    if who ~= nil then
	resetSquirrelStuff(who);
	SetCharacterLocation(ThingCharacter(who), r_alcove);
	AddHead(who@p_pEnterActions, squirrelNotify);
    fi;
corp;

RegisterActiveAction(squirrelThing, squirrelReset).

/* the squirrel quest */

define tp_squirrel proc checkWord(string word)bool:

    if word == It()@p_pSquirrelWord then
	It() -- p_pSquirrelWord;
	true
    else
	false
    fi
corp;

define tp_squirrel proc squirrelDesc()string:
    "Tell me the secret word that the squirrel knows."
corp;

define tp_squirrel proc squirrelHint()string:
    "Bushes and trees are not always as impassable as they seem."
corp;

QuestTell("Squirrel", squirrelDesc, checkWord, squirrelHint).


/* link us to the pre-existing stuff */

r_ewTrail2@p_rNorthMessage :=
    "You are able to push your way through the trees, and down into a gully.".
r_ewTrail2@p_rNorthOMessage := "heads into the trees.".
r_ewTrail2@p_rNorthEMessage := "comes out of the trees.".

define tp_squirrel proc treesImpassable()status:
    Print("The growth here is too thick for you to get through.\n");
    fail
corp;
AddNorthChecker(r_ewTrail3, treesImpassable, false).
HUniConnect(r_ewTrail3, r_ewTrail3, D_NORTH).

define tp_squirrel r_gully1 CreateThing(r_outdoors).
SetupRoom(r_gully1, "at the west end of a gully",
    "The gully dead-ends here. A vague trail heads east down the gully, but "
    "the west end is completely blocked by a tangle of bushes, trees and "
    "rose thorns. The north bank is similarly blocked, but you might be "
    "able to make it up the south bank.").
r_gully1@p_rNoMachines := true.
HConnect(r_ewTrail2, r_gully1, D_NORTH).
HUniConnect(r_gully1, r_ewTrail2, D_UP).
HUniConnect(r_gully1, r_ewTrail2, D_EXIT).
AutoGraphics(r_gully1, AutoPaths).
Scenery(r_gully1, "trail;vague.thorn,bush,bushes,tree;rose,tangle,of").
r_gully1@p_rSouthMessage :=
    "You are able to push your way through the trees, "
    "and up out of the gully.".
r_gully1@p_rSouthOMessage := "heads up out of the gully.".
r_gully1@p_rSouthEMessage := "comes out of the trees.".
r_gully1@p_rUpMessage :=
    "You are able to push your way through the trees, "
    "and up out of the gully.".
r_gully1@p_rUpOMessage := "heads up out of the gully.".
r_gully1@p_rUpEMessage := "comes out of the trees.".
r_gully1@p_rExitMessage :=
    "You are able to push your way through the trees, "
    "and up out of the gully.".
r_gully1@p_rExitOMessage := "heads up out of the gully.".
r_gully1@p_rExitEMessage := "comes out of the trees.".

define tp_squirrel r_gully2 CreateThing(r_outdoors).
SetupRoom(r_gully2, "on a vague trail in a gully",
    "The trail makes a bend here, heading west and northeast. You can't "
    "really see much of the gully because of the thick bushes and trees "
    "along both sides of the trail.").
Connect(r_gully1, r_gully2, D_EAST).
AddSouthChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_SOUTH).
AddNorthChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_NORTH).
AddEastChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_EAST).
AddNorthWestChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_NORTHWEST).
AddSouthEastChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_SOUTHEAST).
AddSouthWestChecker(r_gully2, treesImpassable, false).
HUniConnect(r_gully2, r_gully2, D_SOUTHWEST).
AutoGraphics(r_gully2, AutoPaths).
Scenery(r_gully2, "bush,bushes,tree;thick").

define tp_squirrel r_gully3 CreateThing(r_outdoors).
SetupRoom(r_gully3, "on a vague trail in a gully",
    "The trail makes a bend here, heading southwest and southeast. You can't "
    "really see much of the gully because of the thick bushes and trees "
    "along both sides of the trail.").
Connect(r_gully2, r_gully3, D_NORTHEAST).
AddSouthChecker(r_gully3, treesImpassable, false).
HUniConnect(r_gully3, r_gully3, D_SOUTH).
AddEastChecker(r_gully3, treesImpassable, false).
HUniConnect(r_gully3, r_gully3, D_EAST).
AddWestChecker(r_gully3, treesImpassable, false).
HUniConnect(r_gully3, r_gully3, D_WEST).
AddNorthWestChecker(r_gully3, treesImpassable, false).
HUniConnect(r_gully3, r_gully3, D_NORTHWEST).
AddNorthEastChecker(r_gully3, treesImpassable, false).
HUniConnect(r_gully3, r_gully3, D_NORTHEAST).
AutoGraphics(r_gully3, AutoPaths).
Scenery(r_gully3, "bush,bushes,tree;thick").
r_gully3@p_rNorthMessage :=
    "You are able to push your way through the undergrowth, "
    "and into a small side gully.".
r_gully3@p_rNorthOMessage := "heads into the undergrowth to the north.".
r_gully3@p_rNorthEMessage := "comes out of the undergrowth to the north.".

define tp_squirrel r_gully4 CreateThing(r_outdoors).
SetupRoom(r_gully4, "at the southeast end of a gully",
    "The trail and the gully end here. This end is also completely blocked "
    "by growth, but you might be able to struggle up to the south.").
Connect(r_gully3, r_gully4, D_SOUTHEAST).
Scenery(r_gully4, "bush,bushes,tree,growth;thick").
define tp_squirrel proc treesAttempt()status:
    if Random(3) = 0 then
	Print("You are able to bull your way through the undergrowth, and "
	    "up out of the gully.\n");
	succeed
    else
	Print("You are unable to penetrate the thick undergrowth. You end "
	    "up back on the trail, but with a few scratches.\n");
	fail
    fi
corp;
AddSouthChecker(r_gully4, treesAttempt, false).
HUniConnect(r_gully4, r_pearField, D_SOUTH).
AutoGraphics(r_gully4, AutoPaths).

define tp_squirrel r_gully5 CreateThing(r_outdoors).
SetupRoom(r_gully5, "on a very vague trail in a side gully",
    "The main gully is through the bushes to the south, and the side "
    "trail continues around a bend to the northeast.").
HUniConnect(r_gully3, r_gully5, D_NORTH).
UniConnect(r_gully5, r_gully3, D_SOUTH).
AutoGraphics(r_gully5, AutoPaths).
Scenery(r_gully5, "bush,bushes,tree,thick").

define tp_squirrel r_gully6 CreateThing(r_outdoors).
SetupRoom(r_gully6, "at the end of the side gully",
    "This side gully ends here in a rocky alcove. You can see what appears "
    "to be a dark cave to the east. The gully trail goes back southwest.").
Connect(r_gully5, r_gully6, D_NORTHEAST).
AutoGraphics(r_gully6, AutoPaths).
Scenery(r_gully6, "alcove;rocky.cave;dark,floor,walls").

/* the alcove is actually defined above */
SetupRoom(r_alcove, "in a dim rocky alcove",
    "The alcove is quite low, so that you have to stoop slightly. The light "
    "of day is to the west, but more interesting is the stout wooden door "
    "to the east.").
Connect(r_gully6, r_alcove, D_EAST).
Connect(r_gully6, r_alcove, D_ENTER).
Scenery(r_alcove, "day;light,of.alcove;quite,low").
define tp_squirrel SQ_ALCOVE_ID NextEffectId().
define tp_squirrel proc alcoveDraw()void:

    if not KnowsEffect(nil, SQ_ALCOVE_ID) then
	DefineEffect(nil, SQ_ALCOVE_ID);
	GSetImage(nil, "Squirrel/alcove");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 19, 19);
	    GRectangle(nil, 121, 61, false);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 20, 20);
	    GRectangle(nil, 119, 59, true);
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 0, 40);
	    GRectangle(nil, 0, 19, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 0, 40);
	    GRDraw(nil, 19, 0);
	    GAMove(nil, 0, 60);
	    GRDraw(nil, 19, 0);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 0, 41);
	    GRectangle(nil, 20, 18, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 140, 46);
	    VerticalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_ALCOVE_ID);
corp;
AutoGraphics(r_alcove, alcoveDraw).

define tp_squirrel proc gullyDoorEnter()status:
    thing me, who;

    me := Me();
    who := squirrelThing@p_rSquirrelUser;
    if Character(me@p_pName) = nil then
	/* Do not let character force Packrat in */
	OPrint(Capitalize(me@p_pName) + " will not enter.\n");
	fail
    elif who = nil then
	squirrelThing@p_rSquirrelUser := me;
	Print("The door quietly opens and you enter a small antechamber.\n"
	    "NOTE: no-one else can enter this quest area while you are in "
	    "it - please keep your stay as short as possible. Thank-you.\n");
	AddHead(me@p_pExitActions, squirrelIdle);
	AddPlayerLeaveChecker(me, squirrelLeaveChecker, false);
	AddPlayerEnterChecker(me, squirrelEnterChecker, false);
	continue
    else
	Print("The door is locked - you cannot enter. This quest area is "
	    "currently in use by " + who@p_pName + ".\n");
	fail
    fi
corp;

define tp_squirrel proc gullyDoorExit()status:

    Print("You open the door and go outside.\n");
    resetSquirrelStuff(Me());
    Print("This quest area is now available for other players.\n");
    continue
corp;

define tp_squirrel o_alcoveDoor CreateThing(nil).
FakeModel(o_alcoveDoor, "door;stout,wooden",
    "The door is old, but in excellent condition. It appears to have been "
    "hand made with great care.").
o_alcoveDoor@p_oCloseString := "The door is already closed.".
o_alcoveDoor@p_oNotLocked := true.

define tp_squirrel o_alcoveDoor1 CreateThing(o_alcoveDoor).
SetThingStatus(o_alcoveDoor1, ts_readonly).
define tp_squirrel proc openAlcoveDoor1()status:
    ignore Parse(G, "in");
    succeed
corp;
o_alcoveDoor1@p_oOpenChecker := openAlcoveDoor1.
o_alcoveDoor1@p_Image := "Squirrel/AlcoveDoor1".
AddTail(r_alcove@p_rContents, o_alcoveDoor1).

define tp_squirrel r_antechamber CreateThing(r_indoors).
SetupRoom(r_antechamber, "in a small antechamber",
    "The decor here is overwhelmingly woody - the floor is small hardwood "
    "tiles; the baseboard is a very dark, almost black wood; the lower "
    "walls are mahogany panels; the upper walls are of knotty pine "
    "panelling; and the ceiling is cedar boards. A narrow corridor leads "
    "to the north, and a stout wooden door heads out to the west.").
Connect(r_alcove, r_antechamber, D_EAST).
Connect(r_alcove, r_antechamber, D_ENTER).
define tp_squirrel SQ_ANTE_ID NextEffectId().
define tp_squirrel proc antechamberDraw()void:

    if not KnowsEffect(nil, SQ_ANTE_ID) then
	DefineEffect(nil, SQ_ANTE_ID);
	GSetImage(nil, "Squirrel/ante");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 19, 19);
	    GRectangle(nil, 121, 61, false);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 20, 20);
	    GRectangle(nil, 119, 59, true);
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 66, 0);
	    GRectangle(nil, 27, 19, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 65, 0);
	    GRDraw(nil, 0, 19);
	    GAMove(nil, 94, 0);
	    GRDraw(nil, 0, 19);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 66, 0);
	    GRectangle(nil, 27, 19, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 19, 46);
	    VerticalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_ANTE_ID);
corp;
AutoGraphics(r_antechamber, antechamberDraw).
AddEastChecker(r_alcove, gullyDoorEnter, false).
AddEnterChecker(r_alcove, gullyDoorEnter, false).
AddWestChecker(r_antechamber, gullyDoorExit, false).
AddExitChecker(r_antechamber, gullyDoorExit, false).
Scenery(r_antechamber,
    "door;small,stout,wooden."
    "decor;woody."
    "tile,floor;small,hardwood,tile."
    "baseboard,board,wood;very,dark,base,almost,black,wood,wooden."
    "wall,panel,panelling;lower,mahogany,wall."
    "wall,panel,panelling;upper,knotty,pine,wall."
    "ceiling,board;cedar,board."
    "corridor;narrow").
define tp_squirrel o_alcoveDoor2 CreateThing(o_alcoveDoor).
SetThingStatus(o_alcoveDoor2, ts_readonly).
define tp_squirrel proc openAlcoveDoor2()status:
    ignore Parse(G, "out");
    succeed
corp;
o_alcoveDoor2@p_oOpenChecker := openAlcoveDoor2.
o_alcoveDoor2@p_Image := "Squirrel/AlcoveDoor2".
AddTail(r_antechamber@p_rContents, o_alcoveDoor2).
define tp_squirrel o_broom CreateThing(nil).
SetupObject(o_broom, r_antechamber, "broom;straw",
    "Straw brooms are typically used to sweep floors. They can also be used "
    "for removing spiderwebs from ceiling corners. This one is nothing "
    "special.").
o_broom@p_oUseString :=
    "Sweep, sweep, sweep. Hmm. Seems pretty clean around here already.".
o_broom@p_oActWord := "sweep,brush,clean".
o_broom@p_oActString :=
    "Sweep, sweep, sweep. Hmm. Seems pretty clean around here already.".
o_broom@p_Image := "Squirrel/broom".
AddTail(squirrelThing@p_objects, o_broom).
define tp_squirrel o_dustMop CreateThing(nil).
SetupObject(o_dustMop, r_antechamber, "mop;dust",
    "Dust mops are masses of fluffy strings attached to a long wooden handle. "
    "They are good from removing light dust (like flour) from floors.").
o_dustMop@p_oUseString := "There is no dust around here to mop up!".
o_dustMop@p_oActWord := "mop,dust,clean".
o_dustMop@p_oActString := "There is no dust around here to mop up!".
o_dustMop@p_Image := "Squirrel/dustmop".
AddTail(squirrelThing@p_objects, o_dustMop).

define tp_squirrel r_hallSouth CreateThing(r_indoors).
SetupRoom(r_hallSouth, "in a north-south hallway",
    "The hallway slopes down to the north.").
Connect(r_antechamber, r_hallSouth, D_NORTH).
AutoGraphics(r_hallSouth, AutoHalls).

define tp_squirrel r_hallCross CreateThing(r_indoors).
SetupRoom(r_hallCross, "in a joining of hallways", "").
Connect(r_hallSouth, r_hallCross, D_NORTH).
AutoGraphics(r_hallCross, AutoHalls).

define tp_squirrel r_hallNorth CreateThing(r_indoors).
SetupRoom(r_hallNorth, "in a north-south hallway",
    "The hallway slopes down to the north.").
Connect(r_hallCross, r_hallNorth, D_NORTH).
AutoGraphics(r_hallNorth, AutoHalls).

define tp_squirrel r_kitchen CreateThing(r_indoors).
SetupRoom(r_kitchen, "in a small kitchen",
    "This is a very efficient kitchen, with everything within easy reach. "
    "None of the equipment is modern, but it is all well-kept and spotlessly "
    "clean. There is a hallway to the south and a door to the north.").
Connect(r_hallNorth, r_kitchen, D_NORTH).
define tp_squirrel SQ_KITCHEN_ID NextEffectId().
define tp_squirrel proc kitchenDraw()void:

    if not KnowsEffect(nil, SQ_KITCHEN_ID) then
	DefineEffect(nil, SQ_KITCHEN_ID);
	GSetImage(nil, "Squirrel/kitchen");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 19, 19);
	    GRectangle(nil, 121, 61, false);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 20, 20);
	    GRectangle(nil, 119, 59, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 65, 80);
	    GRDraw(nil, 0, 19);
	    GAMove(nil, 94, 80);
	    GRDraw(nil, 0, 19);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 66, 80);
	    GRectangle(nil, 27, 19, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 75, 19);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_KITCHEN_ID);
corp;
AutoGraphics(r_kitchen, kitchenDraw).
Scenery(r_kitchen,
    "equipment;well-kept,well,kept,spotlessly,clean."
    "hallway,hall").
define tp_squirrel o_rollingPin CreateThing(nil).
SetupObject(o_rollingPin, r_kitchen, "pin;wooden,rolling",
    "The rolling pin shows signs of much use, but is still perfectly good. "
    "The traces of flour that you can see on it are quite dark, as if it "
    "isn't normally used on grain flour.").
o_rollingPin@p_oUseString :=
    "Seeing as you are not currently making a pie, there is nothing "
    "here for you to use the rolling pin on.".
o_rollingPin@p_oActWord := "roll".
o_rollingPin@p_oActString :=
    "Seeing as you are not currently making a pie, there is nothing "
    "here for you to use the rolling pin on.".
o_rollingPin@p_Image := "Squirrel/rollingPin".
AddTail(squirrelThing@p_objects, o_rollingPin).
define tp_squirrel o_potHolder CreateThing(nil).
SetupObject(o_potHolder, r_kitchen,
    "holder;cloth,pot.potholder,pot-holder;cloth",
    "The pot-holder has an embroidered design showing a brown furry person "
    "sniffing a newly baked pie.").
o_potHolder@p_oUseString :=
    "You can fan yourself with the pretty pot-holder, but since there "
    "aren't any hot pots around here for you to hold, that's about it.".
o_potHolder@p_oActWord := "hold".
o_potHolder@p_oActString :=
    "You can fan yourself with the pretty pot-holder, but since there "
    "aren't any hot pots around here for you to hold, that's about it.".
o_potHolder@p_Image := "Squirrel/potholder".
AddTail(squirrelThing@p_objects, o_potHolder).
define tp_squirrel o_fakeDoor CreateThing(nil).
FakeObject(o_fakeDoor, r_kitchen, "door", "").
o_fakeDoor@p_oNotLocked := true.
o_fakeDoor@p_Image := "Squirrel/kitchendoor".

define tp_squirrel r_hallEast CreateThing(r_indoors).
SetupRoom(r_hallEast, "in an east-west hallway", "").
Connect(r_hallCross, r_hallEast, D_EAST).
AutoGraphics(r_hallEast, AutoHalls).

define tp_squirrel r_livingRoom CreateThing(r_indoors).
SetupRoom(r_livingRoom, "in a pleasant living room",
    "The walls are of diagonal cedar boards here, while the "
    "ceiling is of narrow oak strips and the floor is of smooth pine planks. "
    "Wooden coffee tables hold bowls of nuts and light comes from a set of "
    "diamond willow pole lamps. There is a hallway to the west.").
Connect(r_hallEast, r_livingRoom, D_EAST).
Connect(r_hallEast, r_livingRoom, D_ENTER).
AutoGraphics(r_livingRoom, AutoOpenRoom).
Scenery(r_livingRoom,
    "wall,board;diagonal,cedar,board,wall,walls,of."
    "ceiling,strip;narrow,oak,strip,ceiling,of."
    "floor,plank;smooth,pine,plank,floor,of."
    "table;wooden,wood,coffee."
    "nut,bowl;bowls,of."
    "lamp,set;set,of,diamond,willow,pole."
    "hallway.door").
define tp_squirrel o_couch CreateThing(nil).
SetupObject(o_couch, r_livingRoom, "couch",
    "The couch looks very comfortable and is covered in a soft fabric in "
    "a subdued leaf green colour.").
o_couch@p_oCanSitOn := 2.
o_couch@p_oCanSitIn := 3.
o_couch@p_oNotGettable := true.
o_couch@p_Image := "Squirrel/couch".
define tp_squirrel o_chair CreateThing(nil).
SetupObject(o_chair, r_livingRoom, "chair,armchair,arm-chair;arm",
    "The armchair is a perfect match for the couch, and looks just as "
    "comfortable.").
o_chair@p_oCanSitOn := 2.
o_chair@p_oCanSitIn := 1.
o_chair@p_oNotGettable := true.
o_chair@p_Image := "Squirrel/chair".
define tp_squirrel o_coffeeTable CreateThing(nil).
SetupObject(o_coffeeTable, r_livingRoom, "table;wooden,coffee",
    "The coffee table was carved from a single piece of wood, then smoothed "
    "and varnished. It looks like it will last forever.").
o_coffeeTable@p_oNotGettable := true.
o_coffeeTable@p_Image := "Squirrel/coffeetable".

define tp_squirrel r_hallWest CreateThing(r_indoors).
SetupRoom(r_hallWest, "in an east-west hallway", "").
Connect(r_hallCross, r_hallWest, D_WEST).
AutoGraphics(r_hallWest, AutoHalls).

define tp_squirrel r_bedroom CreateThing(r_indoors).
SetupRoom(r_bedroom, "in a cozy bedroom",
    "A female hand shows itself here in the decor - the wooden four-poster "
    "bed has a fluffy pink bedspread with ruffles, and the nearby dressing "
    "table has a large mirror on top.").
Connect(r_hallWest, r_bedroom, D_WEST).
Connect(r_hallWest, r_bedroom, D_ENTER).
AutoGraphics(r_bedroom, AutoOpenRoom).
Scenery(r_bedroom,
    "decor;female,hand."
    "bedspread,ruffles;fluffy,pink,bedspread,with."
    "table,mirror,top;nearby,dressing,with,mirror,table,on").
define tp_squirrel o_bed CreateThing(nil).
FakeObject(o_bed, r_bedroom,
    "bed;wooden,four-poster.bed;wood,wooden,four-poster,four,poster",
    "The bed looks very soft and inviting.").
o_bed@p_oCanLieOn := 2.
o_bed@p_oCanLieIn := 2.
o_bed@p_oCanSitOn := 2.
o_bed@p_oCanSitIn := 2.
o_bed@p_Image := "Squirrel/bed".
/* Let's be pedantic about the bed! */
define tp_squirrel proc bedSit(int whichPos)status:
    case whichPos
    incase POS_LIE_ON:
	Print("You lie on the bed and almost fall asleep - the bed is VERY "
	    "comfortable.\n");
	succeed
    incase POS_LIE_IN:
	Print("Lying on the bed would be OK, but it isn't very nice to get "
	    "into someone else's bed without their permission.\n");
	fail
    incase POS_SIT_ON:
	continue
    incase POS_SIT_IN:
	Print("You can sit on the bed, but sitting in it would be a neat "
	    "trick.\n");
	fail
    default:
	fail
    esac
corp;
o_bed@p_oPositionChecker := bedSit.
define tp_squirrel o_hairBrush CreateThing(nil).
SetupObject(o_hairBrush, r_bedroom, "brush;hair",
    "The hair brush contains some short light-brown hairs, and also a "
    "few much longer hairs of a reddish hue.").
o_hairBrush@p_oUseString := "Ouch! Those tangles are fighting back!".
o_hairBrush@p_oActWord := "brush,comb".
o_hairBrush@p_oActString := "Ouch! Those tangles are fighting back!".
o_hairBrush@p_Image := "Squirrel/hairbrush".
AddTail(squirrelThing@p_objects, o_hairBrush).
define tp_squirrel o_handMirror CreateThing(nil).
SetupObject(o_handMirror, r_bedroom,
	    "mirror;hand.mirror;self,myself,me,in,hand", "").
define tp_squirrel proc mirrorLook()string:
    thing me;
    action a;
    string s, name;

    me := Me();
    name := me@p_pName;
    a := me@p_pDescAction;
    if a ~= nil then
	s := call(a, string)();
    else
	s := me@p_pDesc;
	if s = "" then
	    s := Capitalize(name) + " has no description - for shame!";
	fi;
    fi;
    "You can see " + name + " in the mirror. " + s
corp;
o_handMirror@p_oDescAction := mirrorLook.
define tp_squirrel proc mirrorUse()status:
    Print(mirrorLook() + "\n");
    succeed
corp;
o_handMirror@p_oUseChecker := mirrorUse.
o_handMirror@p_Image := "Squirrel/mirror".
AddTail(squirrelThing@p_objects, o_handMirror).

define tp_squirrel r_valley1 CreateThing(r_forest).
SetupRoom(r_valley1, "at the south end of a narrow valley",
    "The valley is quite narrow here, and the sides are too steep to climb. "
    "There is a pretty wooden door in the very end of the valley.").
Connect(r_kitchen, r_valley1, D_NORTH).
AddTail(r_valley1@p_rContents, o_fakeDoor).
define tp_squirrel SQ_VALLEY1_ID NextEffectId().
define tp_squirrel proc valley1Draw()void:

    if not KnowsEffect(nil, SQ_VALLEY1_ID) then
	DefineEffect(nil, SQ_VALLEY1_ID);
	GSetImage(nil, "Squirrel/valley1");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_GREEN);
	    GAMove(nil, 20, 0);
	    GRectangle(nil, 119, 79, true);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 19, 99, true);
	    GAMove(nil, 140, 0);
	    GRectangle(nil, 19, 99, true);
	    GAMove(nil, 20, 80);
	    GRectangle(nil, 119, 19, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 75, 80);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_VALLEY1_ID);
corp;
AutoGraphics(r_valley1, valley1Draw).
Scenery(r_valley1,
    "door;pretty,wooden,wood."
    "valley,side;end,steep,sides,of,the").

define tp_squirrel o_oakTree CreateThing(nil).
FakeModel(o_oakTree, "tree;magnificent,old,oak.oak;magnificent,old",
    "The oak is obviously very old, but is still in excellent health. It "
    "has many large branches full of luxuriant foliage. You can, however, "
    "glimpse a broken branch up near the top.").
o_oakTree@p_Image := "Squirrel/oaktree".

define tp_squirrel r_valley2 CreateThing(r_squirrelValley).
SetupRoom(r_valley2, "in a grassy valley",
    "The valley widens here to the northeast and northwest, while a narrow "
    "end goes south. The center of the valley contains a magnificent old "
    "oak tree.").
Connect(r_valley1, r_valley2, D_NORTH).
AddTail(r_valley2@p_rContents, o_oakTree).

define tp_squirrel r_valley3 CreateThing(r_squirrelValley).
SetupRoom(r_valley3, "in the southwest corner of the valley",
    "The narrow southern end is to the southeast and the oak is northeast.").
Connect(r_valley2, r_valley3, D_NORTHWEST).
AddTail(r_valley3@p_rContents, o_oakTree).

define tp_squirrel r_valley4 CreateThing(r_squirrelValley).
SetupRoom(r_valley4, "in the southern part of the valley", "").
Connect(r_valley2, r_valley4, D_NORTH).
Connect(r_valley3, r_valley4, D_EAST).
AddTail(r_valley4@p_rContents, o_oakTree).

define tp_squirrel r_valley5 CreateThing(r_squirrelValley).
SetupRoom(r_valley5, "in the southeast corner of the valley",
    "The narrow southern end is to the southwest and the oak is northwest.").
Connect(r_valley2, r_valley5, D_NORTHEAST).
Connect(r_valley4, r_valley5, D_EAST).
AddTail(r_valley5@p_rContents, o_oakTree).

define tp_squirrel r_valley6 CreateThing(r_squirrelValley).
SetupRoom(r_valley6, "in the valley, west of the old oak", "").
Connect(r_valley3, r_valley6, D_NORTH).
Connect(r_valley4, r_valley6, D_NORTHWEST).
RoomName(r_valley5, "Valley", "").
AddTail(r_valley6@p_rContents, o_oakTree).

define tp_squirrel r_valley7 CreateThing(r_squirrelValley).
SetupRoom(r_valley7, "in the valley, east of the magnificent oak", "").
RoomName(r_valley7, "Valley", "").
Connect(r_valley5, r_valley7, D_NORTH).
Connect(r_valley4, r_valley7, D_NORTHEAST).
AddTail(r_valley7@p_rContents, o_oakTree).

define tp_squirrel r_valley8 CreateThing(r_squirrelValley).
SetupRoom(r_valley8, "in the northwest corner of the valley",
    "The narrow northern end is to the northeast and the oak is southeast.").
Connect(r_valley6, r_valley8, D_NORTH).
AddTail(r_valley8@p_rContents, o_oakTree).

define tp_squirrel r_valley9 CreateThing(r_squirrelValley).
SetupRoom(r_valley9, "in the northern part of the valley", "").
Connect(r_valley6, r_valley9, D_NORTHEAST).
Connect(r_valley8, r_valley9, D_EAST).
Connect(r_valley7, r_valley9, D_NORTHWEST).
AddTail(r_valley9@p_rContents, o_oakTree).

define tp_squirrel r_valley10 CreateThing(r_squirrelValley).
SetupRoom(r_valley10, "in the northeast corner of the valley",
    "The narrow northern end is to the northwest and the oak is southwest.").
Connect(r_valley7, r_valley10, D_NORTH).
Connect(r_valley9, r_valley10, D_EAST).
AddTail(r_valley10@p_rContents, o_oakTree).

define tp_squirrel r_valley11 CreateThing(r_squirrelValley).
SetupRoom(r_valley11, "in the northern branch of the valley",
    "The valley opens out to the southeast and southwest, but to the north "
    "is only a very narrow portion.").
Connect(r_valley8, r_valley11, D_NORTHEAST).
Connect(r_valley9, r_valley11, D_NORTH).
Connect(r_valley10, r_valley11, D_NORTHWEST).
Scenery(r_valley11, "branch,valley;north,northern,branch,of,the").
AddTail(r_valley11@p_rContents, o_oakTree).

define tp_squirrel r_valley12 CreateThing(r_forest).
SetupRoom(r_valley12, "at the north end of the valley",
    "There is a small shed tucked into the end of the valley.").
Connect(r_valley11, r_valley12, D_NORTH).
Scenery(r_valley12, "shed;small.valley,end;north,northern,end,of,the").
AddTail(r_valley12@p_rContents, o_fakeDoor).
define tp_squirrel SQ_VALLEY12_ID NextEffectId().
define tp_squirrel proc valley12Draw()void:

    if not KnowsEffect(nil, SQ_VALLEY12_ID) then
	DefineEffect(nil, SQ_VALLEY12_ID);
	GSetImage(nil, "Squirrel/valley12");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_GREEN);
	    GAMove(nil, 20, 20);
	    GRectangle(nil, 119, 79, true);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 19, 99, true);
	    GAMove(nil, 140, 0);
	    GRectangle(nil, 19, 99, true);
	    GAMove(nil, 20, 0);
	    GRectangle(nil, 119, 19, true);
	    GSetPen(nil, C_DARK_BLUE);
	    GAMove(nil, 70, 25);
	    GRectangle(nil, 20, 15, true);
	    GSetPen(nil, C_RED);
	    GAMove(nil, 75, 40);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_VALLEY12_ID);
corp;
AutoGraphics(r_valley12, valley12Draw).

/* o_weed is created earlier */
o_weed@p_oName := "weed;ugly,dead".
o_weed@p_oDesc :=
    "The weed looks freshly hoed up - it is still quite green and there is "
    "a lump of dirt stuck on its roots.".
o_weed@p_oEatString := "Yuck! The weed might be poisonous!".
o_weed@p_oSmellString := "The weed smells slightly minty, and mostly dirty.".
o_weed@p_oPullString := "The weed is already pulled!".
o_weed@p_oUseString := "Most weeds are considered to be useless.".
o_weed@p_oActWord := "smoke".
o_weed@p_oActString := "Sorry, its not that kind of weed!".
o_weed@p_Image := "Squirrel/weed".
SetThingStatus(o_weed, ts_readonly).

define tp_squirrel r_shed CreateThing(r_indoors).
SetupRoom(r_shed, "in the garden shed",
    "This small wooden structure is used for storage of various garden tools. "
    "It is lined with shelves and hooks and things.").
Connect(r_valley12, r_shed, D_NORTH).
Connect(r_valley12, r_shed, D_ENTER).
AutoGraphics(r_shed, AutoClosedRoom).
Scenery(r_shed, "shelves,shelf,hook,thing,tool;various,garden").
AddTail(r_shed@p_rContents, o_fakeDoor).
define tp_squirrel o_hoe CreateThing(nil).
SetupObject(o_hoe, r_shed, "hoe;garden",
    "This implement is generally used for tilling a garden. It's angled "
    "blade can cut the roots of weeds a couple of inches under the surface, "
    "thus releasing the weed, and hopefully killing it.").
define tp_squirrel proc hoeUse()status:
    thing here, weed;

    here := Here();
    if Parent(here) = r_indoors then
	Print("Bashing the nice floor with that hoe will likely get someone "
	    "very upset!\n");
	fail
    elif here@p_rIsTrunk then
	Print("You are not going to be able to chop down the magnificent oak "
	      "tree with a garden hoe!\n");
	fail
    elif here@p_rIsBranch then
	Print("Hacking on the branch with the hoe will accomplish little "
	      "besides damaging the bark.\n");
	fail
    elif FindChildOnList(here@p_rContents, o_weed) or
	FindChildOnList(Me()@p_pCarrying, o_weed)
    then
	Print("This area already looks pretty well hoed over.\n");
	fail
    else
	Print("Chop, chop. Tug, tug. You have uprooted a weed!\n");
	weed := CreateThing(o_weed);
	weed@p_oWhere := here;
	SetThingStatus(weed, ts_public);
	AddTail(here@p_rContents, weed);
	AddTail(squirrelThing@p_tapes, weed);
	succeed
    fi
corp;
o_hoe@p_oUseChecker := hoeUse.
define tp_squirrel proc doHoeUse()void:
    ignore hoeUse();
corp;
o_hoe@p_oActWord := "hoe,chop,tug".
o_hoe@p_oActAction := doHoeUse.
o_hoe@p_Image := "Squirrel/hoe".
AddTail(squirrelThing@p_objects, o_hoe).
define tp_squirrel o_rake CreateThing(nil).
SetupObject(o_rake, r_shed, "rake;garden",
    "This rake is a wooden one, complete with wooden tines. The rake is "
    "used mainly for collecting the fallen leaves in the fall, but can also "
    "be used on a garden, to break up the pieces of sod.").
define tp_squirrel proc rakeUse()status:
    if Parent(Here()) = r_indoors then
	Print("No way! You would badly scratch the floor.\n");
	fail
    elif FindChildOnList(Here()@p_rContents, o_weed) then
	Print("OK, everything is now in a neat pile.\n");
	succeed
    else
	Print("There isn't much here to rake up.\n");
	succeed
    fi
corp;
o_rake@p_oUseChecker := rakeUse.
define tp_squirrel proc doRakeUse()void:
    ignore rakeUse();
corp;
o_rake@p_oActWord := "rake".
o_rake@p_oActAction := doRakeUse.
o_rake@p_Image := "Squirrel/rake".
AddTail(squirrelThing@p_objects, o_rake).
define tp_squirrel o_fork CreateThing(nil).
SetupObject(o_fork, r_shed, "fork;garden",
    "The garden fork is used to dig over a garden. The long, widely separated "
    "tines can go deep into the ground, missing the roots of the vegetables "
    "being grown, and loosen the soil, thus allowing better aeration and "
    "moisture penetration.").
define tp_squirrel proc forkUse()status:
    if Parent(Here()) = r_indoors then
	Print("No forking indoors! It would chip the floor.\n");
    else
	Print("Quit forking around!\n");
    fi;
    fail
corp;
o_fork@p_oUseChecker := forkUse.
define tp_squirrel proc doForkUse()void:
    ignore forkUse();
corp;
o_fork@p_oActWord := "fork".
o_fork@p_oActAction := doForkUse.
o_fork@p_Image := "Squirrel/fork".
AddTail(squirrelThing@p_objects, o_fork).
define tp_squirrel o_tapeDispenser CreateThing(nil).
SetupObject(o_tapeDispenser, r_shed, "dispenser;bug,tape",
    "The bug tape dispenser is attached to the back wall of the shed. It "
    "holds a roll of wide tape which is covered in a sticky insect repellant. "
    "The tape is usually wrapped around tree trunks to keep bugs like "
    "caterpillars and ants from climbing up them and doing damage.").
o_tapeDispenser@p_oSmellString :=
    "The dispenser has no smell, but the tape itself smells icky.".
o_tapeDispenser@p_oTouchString :=
   "You feel nothing special about the dispenser, but the bug tape is sticky.".
/* o_bugTape is defined earlier */
SetThingStatus(o_bugTape, ts_readonly).
o_bugTape@p_oName := "tape;short,piece,of,sticky,bug".
o_bugTape@p_oDesc :=
    "The piece of bug tape is quite tricky to handle - it seems to want to "
    "wrap itself all around you!".
define tp_squirrel proc tapeDrop(thing th)status:
    Print("Dropping the bug tape here would just make a mess. Try using it "
	"somewhere appropriate.\n");
    fail
corp;
o_bugTape@p_oDropChecker := tapeDrop.
define tp_squirrel proc tapePutIn(thing tape, container)status:
    Print("You would really make a mess if you tried to put the tape "
	"into the " + FormatName(container@p_oName) + ".\n");
    fail
corp;
o_bugTape@p_oPutMeInChecker := tapePutIn.
define tp_squirrel proc tapeUse()status:
    thing here, it, me, there;
    int dir, foundDir;

    here := Here();
    it := It();
    me := Me();
    if here@p_rIsTrunk then
	Print("The piece of bug tape that you have is not long enough to "
	    "reach around the trunk. You struggle against gravity to wrap "
	    "it partly around the trunk, but it begins to get the best of "
	    "you and starts sticking to you. After a valiant struggle, you "
	    "get it off of yourself, but you have turned it into a useless, "
	    "sticky wad.\n");
	ClearThing(it);
	DelElement(me@p_pCarrying, it);
	it := CreateThing(o_wad);
	SetThingStatus(it, ts_public);
	GiveThing(it, SysAdmin);
	AddTail(me@p_pCarrying, it);
	succeed
    elif here@p_rIsBranch then
	AddTail(here@p_rContents, it);
	it -- p_oCarryer;
	it@p_oWhere := here;
	DelElement(me@p_pCarrying, it);
	AddTail(squirrelThing@p_tapes, it);
	if squirrelThing@p_rFirstWrap then
	    Print("The bug tape is not long enough to go all of the way "
		"around the branch, but it is long enough to cover the top "
		"of the branch and go part way down the sides. Aided by "
		"gravity, it looks like it will stay there for a while. "
		"In applying the bug tape to the branch, you back up towards "
		"the trunk of the tree.\n");
	    squirrelThing@p_rFirstWrap := false;
	else
	    Print("You apply the bug tape to the branch here and back up "
		"towards the trunk.\n");
	fi;
	/* This code KNOWS that a branch location will either have only one
	   direction to go from it, or will be 1 away from the trunk. This
	   could just be a 'for' loop, but we speed it up a bit in the
	   case of being next to the trunk by exiting as soon as we have
	   found the direction to go. */
	dir := D_NORTH;
	foundDir := D_UP;
	while
	    there := here@(DirProp(dir));
	    if there ~= nil then
		if there@p_rIsTrunk then
		    foundDir := dir;
		    false
		elif foundDir = D_UP then
		    foundDir := dir;
		    dir ~= D_NORTHWEST
		else
		    dir ~= D_NORTHWEST
		fi
	    else
		dir ~= D_NORTHWEST
	    fi
	do
	    dir := dir + 1;
	od;
	/* do not just use EnterRoom - want the leave checker done */
	ignore Parse(G, "go " + ExitName(foundDir));
	succeed
    else
	Print("There is nothing here that you can usefully wrap the bug "
	    "tape around.\n");
	fail
    fi
corp;
o_bugTape@p_oUseChecker := tapeUse.
define tp_squirrel proc doTapeUse()void:
    ignore tapeUse();
corp;
o_bugTape@p_oActWord := "tape,wrap,stick,attach".
o_bugTape@p_oActAction := doTapeUse.
define tp_squirrel proc dispenserGet(thing tape)status:

    if FindChildOnList(Me()@p_pCarrying, o_bugTape) then
	Print("Trying to deal with two pieces of the sticky bug tape at a "
	    "time would just result in you getting yourself all stuck up. "
	    "Use your first piece before getting another.\n");
	fail
    else
	Print("You can't get the tape dispenser, since it is fastened to the "
	    "wall, but you do manage to tear off a short piece of the "
	    "bug tape.\n");
	tape := CreateThing(o_bugTape);
	SetThingStatus(tape, ts_public);
	GiveThing(tape, SysAdmin);
	tape@p_oCarryer := Me();
	AddTail(Me()@p_pCarrying, tape);
	succeed
    fi
corp;
o_bugTape@p_oSmellString := "The bug tape smells icky.".
o_bugTape@p_oTouchString := "The bug tape is sticky.".
o_bugTape@p_Image := "Squirrel/bugTape".
o_tapeDispenser@p_oGetChecker := dispenserGet.
o_tapeDispenser@p_oUseChecker := dispenserGet.
define tp_squirrel proc doDispenserUse()void:
    ignore dispenserGet(It());
corp;
o_tapeDispenser@p_oActWord := "dispense".
o_tapeDispenser@p_oActAction := doDispenserUse.
o_tapeDispenser@p_Image := "Squirrel/tapeDispenser".
define tp_squirrel proc fakeTapeGet(thing tape)status:
    thing me;
    list thing carrying;

    me := Me();
    carrying := me@p_pCarrying;
    if FindChildOnList(carrying, o_bugTape) then
	Print("Trying to deal with two pieces of the sticky bug tape at a "
	    "time would just result in you getting yourself all stuck up. "
	    "Use your first piece before getting another.\n");
	fail
    elif HasAdjective(ItName(), "long") or HasAdjective(ItName(), "longer")
    then
	Print("You tear off a long piece of the bug tape. Unfortunately, it "
	    "is longer than you can easily handle, and it starts to stick "
	    "to you. After a lengthy battle you subdue it, but you have "
	    "reduced it to a sticky wad.\n");
	tape := CreateThing(o_wad);
	SetThingStatus(tape, ts_public);
	GiveThing(tape, SysAdmin);
	tape@p_oCarryer := me;
	AddTail(carrying, tape);
	succeed
    else
	tape := CreateThing(o_bugTape);
	SetThingStatus(tape, ts_public);
	if CarryItem(tape) then
	    Print("You tear off a short piece of the bug tape.\n");
	    succeed
	else
	    ClearThing(tape);
	    fail
	fi
    fi
corp;
define tp_squirrel o_fakeTape CreateThing(nil).
FakeObject(o_fakeTape, r_shed,
    "tape;piece,of,sticky,bug.tape;short,long,longer,piece,of,sticky,bug",
    "The bug tape is neatly wrapped up in the dispenser.").
o_fakeTape -- p_oNotGettable;
o_fakeTape@p_oGetChecker := fakeTapeGet.
o_fakeTape@p_oSmellString := "The bug tape smells icky.".
o_fakeTape@p_oTouchString := "The bug tape is sticky.".
/* o_wad is defined earlier */
define tp_squirrel proc wadDrop(thing it)status:
    thing here;

    here := Here();
    if Parent(here) = r_indoors then
	Print("Don't drop it here! You'll just make an awful mess!\n");
	fail
    else
	AddTail(here@p_rContents, it);
	DelElement(Me()@p_pCarrying, it);
	it -- p_oCarryer;
	it@p_oWhere := here;
	AddTail(squirrelThing@p_tapes, it);
	if here@p_rIsTrunk or here@p_rIsBranch then
	    Print("You drop the sticky wad, which immediately sticks to the "
		"tree and stays put. It doesn't block passage, however.\n");
	    succeed
	else
	    Print("You drop the sticky wad onto the ground. It hits with a "
		"sodden thump and looks to be there forever.\n");
	    succeed
	fi
    fi
corp;
define tp_squirrel proc wadGet(thing wad)status:
    if Here()@p_rIsTrunk or Here()@p_rIsBranch then
	Print("The sticky wad is stuck tightly to the tree. You cannot pry "
	    "it loose.\n");
    else
	Print("The sticky wad is stuck tightly to the ground. You cannot "
	    "pry it up.\n");
    fi;
    fail
corp;
SetThingStatus(o_wad, ts_readonly).
o_wad@p_oName := "wad;sticky".
o_wad@p_oDesc :=
    "The sticky wad is roughly spherical, and about two inches across. It "
    "is brown, smells icky, and tends to stick to everything, including you.".
o_wad@p_oDropChecker := wadDrop.
o_wad@p_oGetChecker := wadGet.
o_wad@p_oUseString :=
    "The sticky wad used to have a use, before you got it all wadded up, "
    "but now it is pretty useless.".
o_wad@p_oActWord := "tape,wrap,stick,attach".
o_wad@p_oActString :=
    "The sticky wad used to have a use, before you got it all wadded up, "
    "but now it is pretty useless.".
o_wad@p_oSmellString := "The sticky wad smells icky.".
o_wad@p_oTouchString := "The sticky wad is sticky.".
o_wad@p_Image := "Squirrel/wad".
define tp_squirrel o_bugSpray CreateThing(nil).
SetupObject(o_bugSpray, r_shed, "squirter,sprayer;bug",
    "The bug squirter is a hand operated aerosol device which sprays a mist "
    "of insecticide wherever it is pointed. The jar of insecticide attached "
    "to it is full.").
o_bugSpray@p_oUseString := "Squirt! Squirt!".
o_bugSpray@p_oActWord := "squirt,spray".
o_bugSpray@p_oActString := "Squirt! Squirt!".
o_bugSpray@p_oEatString := "NO! It's almost certainly poisonous!".
o_bugSpray@p_oSmellString :=
    "The sprayer itself smells slightly metallic, but the insecticide in "
    "the jar has a strong chemical smell.".
o_bugSpray@p_Image := "Squirrel/bugspray".
AddTail(squirrelThing@p_objects, o_bugSpray).

define tp_squirrel o_oakTree2 CreateThing(o_oakTree).
o_oakTree2@p_oDesc :=
    "From this close up, the oak tree is somewhat overwhelming. The trunk is "
    "about four feet thick at this point, and the branches just overhead "
    "are nearly two feet thick. The ridges in the bark here are a couple "
    "of inches deep, and there is a lot of thick moss covering one side "
    "of the trunk. It is quite peaceful here.".
o_oakTree2@p_Image := "Squirrel/oaktree2".
/* r_valley13 defined earlier */
SetupRoom(r_valley13, "in the shade of the magnificent old oak",
    "Very little light hits this cool spot in the middle of the valley. The "
    "oak is right beside you and it looks like even you could climb up it.").
Connect(r_valley3, r_valley13, D_NORTHEAST).
Connect(r_valley4, r_valley13, D_NORTH).
Connect(r_valley5, r_valley13, D_NORTHWEST).
Connect(r_valley6, r_valley13, D_EAST).
Connect(r_valley7, r_valley13, D_WEST).
Connect(r_valley8, r_valley13, D_SOUTHEAST).
Connect(r_valley9, r_valley13, D_SOUTH).
Connect(r_valley10, r_valley13, D_SOUTHWEST).
Scenery(r_valley13, "trunk;tree.branches.ridges;bark.bark.moss;thick").
define tp_squirrel SQ_VALLEY13_ID NextEffectId().
define tp_squirrel proc valley13Draw()void:

    if not KnowsEffect(nil, SQ_VALLEY13_ID) then
	DefineEffect(nil, SQ_VALLEY13_ID);
	GSetImage(nil, "Squirrel/valley13");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    AutoOpenSpace();
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 70, 40, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SQ_VALLEY13_ID);
corp;
AutoGraphics(r_valley13, valley13Draw).
AddTail(r_valley13@p_rContents, o_oakTree2).
r_valley13@p_rIsTrunk := true.


/* And now the tree */

define tp_squirrel proc treeDrop(thing object)status:

    Print("You drop the " + FormatName(object@p_oName) +
	" which disappears out of sight.\n");
    /* Note that this will result in two calls of any drop action on the
       object itself. This presumeably will not matter, since the call
       that has already happened returned 'continue' for us to get here. */
    ignore DoDrop(r_valley13, Me(), object);
    succeed
corp;

define tp_squirrel r_trunk CreateThing(r_outdoors).
SetThingStatus(r_trunk, ts_readonly).
r_trunk@p_rName := "holding on to the tree trunk".
r_trunk@p_rIsTrunk := true.
r_trunk@p_rNoGoString := "It would be a long, bumpy fall to the ground!".
r_trunk@p_Image := "Squirrel/trunk".
AddRoomDropChecker(r_trunk, treeDrop, false).
AutoGraphics(r_trunk, AutoPaths).
AutoPens(r_trunk, C_FOREST_GREEN, C_BROWN, 0, 0).

define tp_squirrel o_fakeTrunk CreateThing(nil).
FakeModel(o_fakeTrunk,
    "trunk,tree,oak;big,rough,brown,magnificent,old,oak,tree",
    "With your nose almost pressed into it, the tree trunk just looks "
    "very big, very brown, and very rough.").

define tp_squirrel o_fakeBranch CreateThing(nil).
FakeModel(o_fakeBranch, "branch,branche;brown,woody,leafy,high,tree",
    "From this close up, the branches just look rough, brown, woody and "
    "a long way from the ground.").

define tp_squirrel proc makeTrunk(string desc)thing:
    thing trunk;

    trunk := CreateThing(r_trunk);
    trunk@p_rDesc := desc;
    trunk@p_rContents := CreateThingList();
    SetThingStatus(trunk, ts_readonly);
    AddTail(trunk@p_rContents, o_fakeTrunk);
    AddTail(trunk@p_rContents, o_fakeBranch);
    trunk
corp;

define tp_squirrel r_trunk1 makeTrunk("Large branches go east and west.").
HUniConnect(r_valley13, r_trunk1, D_UP).
UniConnect(r_trunk1, r_valley13, D_DOWN).

define tp_squirrel r_trunk2 makeTrunk(
    "A large branch goes south and smaller ones go northeast and northwest.").
Connect(r_trunk1, r_trunk2, D_UP).

define tp_squirrel r_trunk3 makeTrunk(
    "A large branch goes north and smaller ones go west, southwest and "
    "southeast.").
Connect(r_trunk2, r_trunk3, D_UP).

define tp_squirrel r_trunk4 makeTrunk(
    "You are now quite high up the tree. Someone has managed to wrap some "
    "bug tape completely around the tree here, so progress higher is blocked. "
    "Large branches go east and west, and a smaller one goes northeast.").
Connect(r_trunk3, r_trunk4, D_UP).
r_trunk4@p_rTopTrunk := true.
define tp_squirrel o_tape2 CreateThing(nil).
FakeObject(o_tape2, r_trunk4,
    "tape;long,piece,of,sticky,bug.tape;longer,piece,of,sticky,bug",
    "This long piece of bug tape is wrapped securely around the tree trunk.").
define tp_squirrel proc tapeGet2(thing tape)status:
    Print("The bug tape is firmly wrapped around the trunk - you cannot "
	"remove it.\n");
    fail
corp;
o_tape2@p_oGetChecker := tapeGet2.

define tp_squirrel r_trunk5 CreateThing(nil).
r_trunk4@p_rUp := r_trunk5.
define tp_squirrel proc noClimb()status:
    Print("There is no way you are going to climb up over that "
	"sticky bug tape!\n");
    fail
corp;
AddUpChecker(r_trunk4, noClimb, false).

define tp_squirrel r_branch CreateThing(r_outdoors).
SetThingStatus(r_branch, ts_readonly).
r_branch@p_rName := "crawling along a branch".
r_branch@p_rDesc := "The branch ends here.".
r_branch@p_rIsBranch := true.
r_branch@p_rNoGoString := "Walking on air is not your strong point!".
r_branch@p_Image := "Squirrel/branch".
AddRoomDropChecker(r_branch, treeDrop, false).
AutoGraphics(r_branch, AutoPaths).
AutoPens(r_branch, C_FOREST_GREEN, C_BROWN, 0, 0).

define tp_squirrel o_fakeTrunk2 CreateThing(nil).
FakeModel(o_fakeTrunk2,
    "trunk,tree,oak;big,rough,brown,magnificent,old,oak,tree",
    "From out here, the tree trunk looks very inviting.").

define tp_squirrel proc makeBranch(string desc; thing escape)thing:
    thing branch;

    branch := CreateThing(r_branch);
    if desc ~= "" then
	branch@p_rDesc := desc;
    fi;
    branch@p_rContents := CreateThingList();
    if escape ~= nil then
	branch@p_rSquirrelPath := escape;
    fi;
    SetThingStatus(branch, ts_readonly);
    AddTail(branch@p_rContents, o_fakeBranch);
    AddTail(branch@p_rContents, o_fakeTrunk2);
    branch
corp;

define tp_squirrel r_branch1 makeBranch(
    "This large branch is west of the trunk. Smaller branches lead "
    "north and southwest.", r_valley13).
Connect(r_trunk1, r_branch1, D_WEST).

define tp_squirrel r_branch2 makeBranch("", r_valley13).
Connect(r_branch1, r_branch2, D_SOUTHWEST).

define tp_squirrel r_branch3 makeBranch("", r_valley13).
Connect(r_branch1, r_branch3, D_NORTH).

define tp_squirrel r_branch4 makeBranch(
    "This large branch is east of the trunk. Smaller branches lead "
    "northeast and southeast.", r_valley13).
Connect(r_trunk1, r_branch4, D_EAST).

define tp_squirrel r_branch5 makeBranch("", r_valley13).
Connect(r_branch4, r_branch5, D_SOUTHEAST).

define tp_squirrel r_branch6 makeBranch("", r_valley13).
Connect(r_branch4, r_branch6, D_NORTHEAST).

define tp_squirrel r_branch7 makeBranch("", r_branch3).
Connect(r_trunk2, r_branch7, D_NORTHWEST).

define tp_squirrel r_branch8 makeBranch(
    "The branch bends here, with the trunk back to the southwest and more "
    "branch to the east.", r_branch6).
Connect(r_trunk2, r_branch8, D_NORTHEAST).

define tp_squirrel r_branch9 makeBranch("", r_branch6).
Connect(r_branch8, r_branch9, D_EAST).

define tp_squirrel r_branch10 makeBranch(
    "This large branch is south of the trunk. Smaller branches lead "
    "southeast and southwest.", r_branch2).
Connect(r_trunk2, r_branch10, D_SOUTH).

define tp_squirrel r_branch11 makeBranch("", r_branch2).
Connect(r_branch10, r_branch11, D_SOUTHWEST).

define tp_squirrel r_branch12 makeBranch("", r_branch5).
Connect(r_branch10, r_branch12, D_SOUTHEAST).

define tp_squirrel r_branch13 makeBranch(
    "The branch bends here, with the trunk back to the northeast and more "
    "branch to the south.", r_branch11).
Connect(r_trunk3, r_branch13, D_SOUTHWEST).

define tp_squirrel r_branch14 makeBranch("", r_branch2).
Connect(r_branch13, r_branch14, D_SOUTH).

define tp_squirrel r_branch15 makeBranch("", r_branch7).
Connect(r_trunk3, r_branch15, D_WEST).

define tp_squirrel r_branch16 makeBranch("", r_branch12).
Connect(r_trunk3, r_branch16, D_SOUTHEAST).

define tp_squirrel r_branch17 makeBranch(
    "This large branch is north of the trunk. Smaller branches lead "
    "northwest and east.", r_branch7).
Connect(r_trunk3, r_branch17, D_NORTH).

define tp_squirrel r_branch18 makeBranch("", r_branch7).
Connect(r_branch17, r_branch18, D_NORTHWEST).

define tp_squirrel r_branch19 makeBranch("", r_branch9).
Connect(r_branch17, r_branch19, D_EAST).

define tp_squirrel r_branch20 makeBranch(
    "The branch bends here, with the trunk back to the east and more branch "
    "to the southwest.", r_branch15).
Connect(r_trunk4, r_branch20, D_WEST).

define tp_squirrel r_branch21 makeBranch("", r_branch15).
Connect(r_branch20, r_branch21, D_SOUTHWEST).

define tp_squirrel r_branch22 makeBranch("", r_branch19).
Connect(r_trunk4, r_branch22, D_NORTHEAST).
r_trunk4@p_rSquirrelPath := r_branch22.

define tp_squirrel r_branch23 makeBranch(
    "This very long branch runs east-west at this point.", r_branch19).
Connect(r_trunk4, r_branch23, D_EAST).

define tp_squirrel r_branch24 makeBranch(
    "The branch has been broken off here - there are no other branches nearby "
    "and you can only go back west towards the trunk.", nil).
Connect(r_branch23, r_branch24, D_EAST).

unuse tp_squirrel
unuse t_streets
