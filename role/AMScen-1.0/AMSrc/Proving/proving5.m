/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * proving5.m - the doors rooms area.
 */

private tp_proving5 CreateTable().
use tp_proving5

define tp_proving5 r_tunnelX4 CreateThing(r_provingCave).
SetupRoomDP(r_tunnelX4, "at the south end of a passage",
    "A large wooden door blocks the south end of the passage.").
UniConnect(r_tunnelX4, r_chasm6, D_SOUTH).
r_tunnelX4@p_rNoGenerateMonsters := true.
define tp_proving5 PR_TUNNELX4_ID NextEffectId().
define tp_proving5 proc drawTunnelX4()void:

    if not KnowsEffect(nil, PR_TUNNELX4_ID) then
	DefineEffect(nil, PR_TUNNELX4_ID);
	GSetImage(nil, "Proving/tunnelX4");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 65, 0);
	    GRectangle(nil, 29, 55, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 75, 55);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_TUNNELX4_ID);
corp;
AutoGraphics(r_tunnelX4, drawTunnelX4).

define tp_proving5 o_door1 CreateThing(nil).
FakeObject(o_door1, r_chasm6, "door;sturdy,wooden",
    "The door is made from massive wooden beams, fastened together with thick "
    "iron straps. There is a small keyhole in the door.").
o_door1@p_oOpenString := "The door is locked.".
o_door1@p_oPushString := "The door is locked.".
o_door1@p_oPullString := "The door is locked.".
o_door1@p_Image := "Proving/doorFromChasm".

define tp_proving5 o_keyHole2 CreateThing(nil).
FakeObject(o_keyHole2, r_chasm6, "hole,keyhole;small,key", "").
o_keyHole2@p_oContents := CreateThingList().
o_keyHole2@p_Image := "Proving/keyhole".

define tp_proving5 proc putInKeyHole2(thing key, keyhole)status:
    string name;
    bool hidden;

    if Parent(key) = o_ironKey then
	name := Me()@p_pName;
	hidden := Me()@p_pHidden;
	Print("The iron key slips into the hole and turns easily. The door "
	    "opens and you walk through.\n");
	if hidden then
	    OPrint("The door opens, then quickly closes again.\n");
	else
	    OPrint(Capitalize(name) +
		" unlocks the door and walks through. The door "
		"then closes again before anyone can follow.\n");
	fi;
	LeaveRoomStuff(r_tunnelX4, D_NORTH, MOVE_SPECIAL);
	EnterRoomStuff(r_tunnelX4, D_SOUTH, MOVE_SPECIAL);
	if hidden then
	    OPrint("The door opens, then closes again.\n");
	else
	    OPrint("The door opens and " + name + " enters. " +
		"The door quickly closes again.\n");
	fi;
	succeed
    else
	Print("The " + FormatName(key@p_oName) +
	    " will not fit into the hole.\n");
	fail
    fi
corp;
o_keyHole2@p_oPutInMeChecker := putInKeyHole2.
define tp_proving5 proc doUnlock2(thing keyhole, key)status:
    putInKeyHole2(key, keyhole)
corp;
o_keyHole2@p_oUnlockMeWithChecker := doUnlock2.
SetThingStatus(o_keyHole2, ts_readonly).
o_door1@p_oUnlockMeWithChecker := doUnlock2.
SetThingStatus(o_door1, ts_readonly).

define tp_proving5 proc backThroughDoor()status:
    string name;
    bool hidden;

    name := Me()@p_pName;
    hidden := Me()@p_pHidden;
    Print("The door opens easily from this side. You pass back into the "
	"chasm area and the door closes and locks again.\n");
    if hidden then
	OPrint("The door opens, then quickly closes again.\n");
    else
	OPrint(Capitalize(name) +
	    " opens the door and passes through. The door quickly "
	    "closes again.\n");
    fi;
    LeaveRoomStuff(r_chasm6, D_SOUTH, MOVE_SPECIAL);
    EnterRoomStuff(r_chasm6, D_NORTH, MOVE_SPECIAL);
    if hidden then
	OPrint("The door opens, then quickly closes again.\n");
    else
	OPrint("The door opens and " + name + " emerges. "
	    "The door quickly closes again.\n");
    fi;
    succeed
corp;
define tp_proving5 proc doBackThroughDoor()status:
    ignore backThroughDoor();
    fail
corp;
AddSouthChecker(r_tunnelX4, doBackThroughDoor, false).

define tp_proving5 o_door2 CreateThing(nil).
FakeObject(o_door2, r_tunnelX4, "door;sturdy,wooden", "").
o_door2@p_oOpenChecker := backThroughDoor.
o_door2@p_oPullChecker := backThroughDoor.
o_door2@p_oPushChecker := backThroughDoor.
o_door2@p_oNotLocked := true.
o_door2@p_Image := "Proving/doorToChasm".

/* Here for a while is the area beyond the door in the crack in the chasm.
   This is the doorsroom area with the winch. */

define tp_proving5 r_tunnelX CreateThing(r_tunnel).
r_tunnelX@p_rDark := true.
AutoGraphics(r_tunnelX, AutoTunnels).
AutoPens(r_tunnelX, C_DARK_GREY, C_LIGHT_GREY, C_LIGHT_GREY, C_LIGHT_GREY).
SetThingStatus(r_tunnelX, ts_readonly).

define tp_proving5 r_tunnelX5 CreateThing(r_tunnelX).
SetupRoomDP(r_tunnelX5, "in a north-south passage",
    "There is a winch arrangement on the wall here.").
Connect(r_tunnelX4, r_tunnelX5, D_NORTH).
Scenery(r_tunnelX5, "hole.rope").
r_tunnelX5@p_rHintString := "Why do they close so suddenly?".

define tp_proving5 r_tunnelX6 CreateThing(r_tunnelX).
SetupRoomDP(r_tunnelX6, "in a north-south passage", "").
Connect(r_tunnelX5, r_tunnelX6, D_NORTH).

define tp_proving5 r_tunnelX7 CreateThing(r_tunnelX).
SetupRoomDP(r_tunnelX7, "in a north-south passage", "").
Connect(r_tunnelX6, r_tunnelX7, D_NORTH).

define tp_proving5 PR_DOORS1_ID NextEffectId().
define tp_proving5 proc drawDoors1()void:

    if not KnowsEffect(nil, PR_DOORS1_ID) then
	DefineEffect(nil, PR_DOORS1_ID);
	GSetPen(nil, C_BROWN);
	GAMove(nil, 40, 66);
	VerticalDoor();
	GAMove(nil, 52, 48);
	NorthWestDoor();
	GAMove(nil, 76, 40);
	HorizontalDoor();
	GAMove(nil, 108, 48);
	NorthEastDoor();
	GAMove(nil, 120, 66);
	VerticalDoor();
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS1_ID);
corp;

define tp_proving5 PR_DOORS2_ID NextEffectId().
define tp_proving5 proc drawDoors2()void:

    if not KnowsEffect(nil, PR_DOORS2_ID) then
	DefineEffect(nil, PR_DOORS2_ID);
	GSetImage(nil, "Proving/doors2");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 70, 99);
	    GRDraw(nil, -10, -19);
	    GRDraw(nil, -20, 0);
	    GRDraw(nil, 0, -20);
	    GRDraw(nil, 20, -20);
	    GRDraw(nil, 40, 0);
	    GRDraw(nil, 20, 20);
	    GRDraw(nil, 0, 20);
	    GRDraw(nil, -20, 0);
	    GRDraw(nil, -10, 19);
	    GPolygonEnd(nil);

	    drawDoors1();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS2_ID);
corp;

define tp_proving5 PR_DOORS3_ID NextEffectId().
define tp_proving5 proc drawDoors3()void:

    if not KnowsEffect(nil, PR_DOORS3_ID) then
	DefineEffect(nil, PR_DOORS3_ID);
	GSetImage(nil, "Proving/doors3");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 70, 99);
	    GRDraw(nil, -10, -19);
	    GRDraw(nil, -40, 0);
	    GRDraw(nil, 0, -60);
	    GRDraw(nil, 120, 0);
	    GRDraw(nil, 0, 60);
	    GRDraw(nil, -40, 0);
	    GRDraw(nil, -10, 19);
	    GPolygonEnd(nil);
	    GAMove(nil, 70, 0);
	    GRectangle(nil, 20, 20, true);

	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 40, 80);
	    GRDraw(nil, 0, -20);
	    GRDraw(nil, 20, -20);
	    GRDraw(nil, 40, 0);
	    GRDraw(nil, 20, 20);
	    GRDraw(nil, 0, 20);

	    drawDoors1();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS3_ID);
corp;

define tp_proving5 DOORS1_MAP_GROUP NextMapGroup().
define tp_proving5 DOORS2_MAP_GROUP NextMapGroup().

define tp_proving5 r_doorsModel1 CreateThing(r_tunnel).
r_doorsModel1@p_rDark := true.
r_doorsModel1@p_MapGroup := DOORS1_MAP_GROUP.
r_doorsModel1@p_rDrawAction := drawDoors2.
r_doorsModel1@p_rEnterRoomDraw := EnterRoomDraw.
r_doorsModel1@p_rLeaveRoomDraw := LeaveRoomDraw.
RoomName(r_doorsModel1, "Doors", "Room").
Scenery(r_doorsModel1, "eye;carved.carving;eye.chamber").
SetThingStatus(r_doorsModel1, ts_readonly).

define tp_proving5 proc makeDoors1(int x, y; string name)thing:
    thing doors;

    doors := CreateThing(r_doorsModel1);
    doors@p_rName := name;
    doors@p_rContents := CreateThingList();
    doors@p_rExits := CreateIntList();
    doors@p_rCursorX := x;
    doors@p_rCursorY := y;
    SetThingStatus(doors, ts_readonly);
    doors
corp;

define tp_proving5 r_doorsModel2 CreateThing(r_tunnel).
r_doorsModel2@p_rDark := true.
r_doorsModel2@p_MapGroup := DOORS2_MAP_GROUP.
r_doorsModel2@p_rDrawAction := drawDoors3.
r_doorsModel2@p_rEnterRoomDraw := EnterRoomDraw.
r_doorsModel2@p_rLeaveRoomDraw := LeaveRoomDraw.
RoomName(r_doorsModel2, "Doors", "Room").
SetThingStatus(r_doorsModel2, ts_readonly).

define tp_proving5 proc makeDoors2(int x, y; string name)thing:
    thing doors;

    doors := CreateThing(r_doorsModel2);
    doors@p_rName := name;
    doors@p_rContents := CreateThingList();
    doors@p_rExits := CreateIntList();
    doors@p_rCursorX := x;
    doors@p_rCursorY := y;
    SetThingStatus(doors, ts_readonly);
    doors
corp;

define tp_proving5 r_doorsEntrance makeDoors1(78, 67,
    "in the room of many doors").
Connect(r_tunnelX7, r_doorsEntrance, D_NORTH).
Scenery(r_doorsEntrance, "door.passage").	/* adds to default */

define tp_proving5 r_westDoor makeDoors1(43, 67, "by the west door").
Connect(r_doorsEntrance, r_westDoor, D_WEST).

define tp_proving5 r_northwestDoor makeDoors1(52, 51, "by the northwest door").
Connect(r_doorsEntrance, r_northwestDoor, D_NORTHWEST).
Connect(r_westDoor, r_northwestDoor, D_NORTH).

define tp_proving5 r_northDoor makeDoors1(78, 42, "by the north door").
Connect(r_doorsEntrance, r_northDoor, D_NORTH).
Connect(r_northwestDoor, r_northDoor, D_EAST).

define tp_proving5 r_northeastDoor makeDoors1(102,51, "by the northeast door").
Connect(r_doorsEntrance, r_northeastDoor, D_NORTHEAST).
Connect(r_northDoor, r_northeastDoor, D_EAST).

define tp_proving5 r_eastDoor makeDoors1(111, 67, "by the east door").
Connect(r_doorsEntrance, r_eastDoor, D_EAST).
Connect(r_northeastDoor, r_eastDoor, D_SOUTH).

define tp_proving5 r_westDoor2 makeDoors2(31, 67, "by the west door").
Connect(r_westDoor, r_westDoor2, D_WEST).

define tp_proving5 r_northwestDoor2 makeDoors2(43, 43,"by the northwest door").
Connect(r_northwestDoor, r_northwestDoor2, D_NORTHWEST).
Connect(r_westDoor2, r_northwestDoor2, D_NORTHEAST).
UniConnect(r_westDoor2, r_northwestDoor2, D_NORTH).

define tp_proving5 r_northDoor2 makeDoors2(78, 32, "by the north door").
Connect(r_northDoor, r_northDoor2, D_NORTH).
Connect(r_northwestDoor2, r_northDoor2, D_NORTHEAST).
UniConnect(r_northwestDoor2, r_northDoor2, D_NORTH).
UniConnect(r_northDoor2, r_northwestDoor2, D_WEST).

define tp_proving5 r_northeastDoor2 makeDoors2(111,43,"by the northeast door").
Connect(r_northeastDoor, r_northeastDoor2, D_NORTHEAST).
Connect(r_northeastDoor2, r_northDoor2, D_NORTHWEST).
UniConnect(r_northeastDoor2, r_northDoor2, D_NORTH).
UniConnect(r_northDoor2, r_northeastDoor2, D_EAST).

define tp_proving5 r_eastDoor2 makeDoors2(123, 67, "by the east door").
Connect(r_eastDoor, r_eastDoor2, D_EAST).
Connect(r_eastDoor2, r_northeastDoor2, D_NORTHWEST).
UniConnect(r_eastDoor2, r_northeastDoor2, D_NORTH).

define tp_proving r_doorsExit makeDoors2(77, 2,
    "in the room of many doors").
Connect(r_northDoor2, r_doorsExit, D_NORTH).

ignore DeleteSymbol(tp_proving5, "makeDoors2").
ignore DeleteSymbol(tp_proving5, "makeDoors1").

define tp_proving5 o_doorModel1 CreateThing(nil).
FakeObject(o_doorModel1, nil, "door;sturdy,wooden", "").
define tp_proving5 proc door1Desc()string:
    if It()@p_oState = 0 then
	"The door looks like it opens by sliding upwards, but it is currently "
	"closed and you can see no way to open it, nor any sign of a keyhole "
	"or other mechanism."
    else
	/* this cannot ever happen */
	"The door is currently slid upwards out of the way."
    fi
corp;
o_doorModel1@p_oDescAction := door1Desc.
define tp_proving5 proc door1Unlock(thing door, key)status:
    Print("You can see no lock mechanism on the door.\n");
    succeed
corp;
o_doorModel1@p_oUnlockMeWithChecker := door1Unlock.
o_doorModel1@p_Image := "Proving/doorOutside".
SetThingStatus(o_doorModel1, ts_readonly).

define tp_proving5 o_winch CreateThing(nil).
FakeObject(o_winch, r_tunnelX5, "winch.arrangement;winch.crank", "").
o_winch@p_oState := 0.
define tp_proving5 proc winchDesc()string:
    "The winch is a hand turned mechanism used for lifting things. A rope "
    "transmits the force from the winch through a hole in the ceiling. It is "
    "not obvious what purpose the winch serves. " +
    if o_winch@p_oState = 0 then
	"The winch is currently fully unwound."
    elif o_winch@p_oState = 5 then
	"The winch is currently fully wound."
    else
	"The winch is currently partly wound."
    fi
corp;
o_winch@p_oDescAction := winchDesc.
o_winch@p_Image := "Proving/winch".

define tp_proving5 p_oOtherDoor CreateThingProp().
define tp_proving5 p_oSound CreateStringProp().
define tp_proving5 p_oDoorName CreateStringProp().
define tp_proving5 p_oSoundList CreateThingListProp().

define tp_proving5 o_doorModel2 CreateThing(nil).
FakeObject(o_doorModel2, nil, "door;sturdy,wooden", "").
define tp_proving5 proc door2Desc()string:
    if It()@p_oOtherDoor@p_oState = 0 then
	"The door looks like it opens by sliding upwards. There is a handy "
	"handle on it for lifting with."
    else
	/* Hmm. should never see this! */
	"The door is currently slid upwards out of the way."
    fi
corp;
o_doorModel2@p_oDescAction := door2Desc.
o_doorModel2@p_oNotLocked := true.
o_doorModel2@p_Image := "Proving/doorInside".
SetThingStatus(o_doorModel2, ts_readonly).

define tp_proving5 proc door1Checker()status:

    if Here()@p_rContents[0]@p_oState = 0 then
	Print("You cannot go that way - the door is closed.\n");
	fail
    else
	continue
    fi
corp;

define tp_proving5 proc door2Checker()status:
    thing otherDoor;

    otherDoor := Here()@p_rContents[0]@p_oOtherDoor;
    if otherDoor@p_oState = 0 then
	Print("You lift the door by the handle and pass through.\n");
	if CanSee(Here(), Me()) then
	    OPrint(Capitalize(Me()@p_pName) +
		" lifts the door and passes through.\n");
	fi;
	SayToList(o_winch@p_oSoundList, otherDoor@p_oSound + "\n");
	/* The enter checker for the other room will shut all the doors if
	   the player has a light. */
    fi;
    continue
corp;

define tp_proving5 o_door1W CreateThing(o_doorModel1).
o_door1W@p_oState := 0.
o_door1W@p_oSound := "Thump!".
o_door1W@p_oDoorName := "west".
AddTail(r_westDoor@p_rContents, o_door1W).
AddWestChecker(r_westDoor, door1Checker, false).
define tp_proving5 o_door2W CreateThing(o_doorModel2).
o_door2W@p_oOtherDoor := o_door1W.
AddTail(r_westDoor2@p_rContents, o_door2W).
AddEastChecker(r_westDoor2, door2Checker, false).

define tp_proving5 o_door1NW CreateThing(o_doorModel1).
o_door1NW@p_oState := 0.
o_door1NW@p_oSound := "Thud!".
o_door1NW@p_oDoorName := "north-west".
AddTail(r_northwestDoor@p_rContents, o_door1NW).
AddNorthWestChecker(r_northwestDoor, door1Checker, false).
define tp_proving5 o_door2NW CreateThing(o_doorModel2).
o_door2NW@p_oOtherDoor := o_door1NW.
AddTail(r_northwestDoor2@p_rContents, o_door2NW).
AddSouthEastChecker(r_northwestDoor2, door2Checker, false).

define tp_proving5 o_door1N CreateThing(o_doorModel1).
o_door1N@p_oState := 0.
o_door1N@p_oSound := "Boom!".
o_door1N@p_oDoorName := "north".
AddTail(r_northDoor@p_rContents, o_door1N).
AddNorthChecker(r_northDoor, door1Checker, false).
define tp_proving5 o_door2N CreateThing(o_doorModel2).
o_door2N@p_oOtherDoor := o_door1N.
AddTail(r_northDoor2@p_rContents, o_door2N).
AddSouthChecker(r_northDoor2, door2Checker, false).

define tp_proving5 o_door1NE CreateThing(o_doorModel1).
o_door1NE@p_oState := 0.
o_door1NE@p_oSound := "Crash!".
o_door1NE@p_oDoorName := "north-east".
AddTail(r_northeastDoor@p_rContents, o_door1NE).
AddNorthEastChecker(r_northeastDoor, door1Checker, false).
define tp_proving5 o_door2NE CreateThing(o_doorModel2).
o_door2NE@p_oOtherDoor := o_door1NE.
AddTail(r_northeastDoor2@p_rContents, o_door2NE).
AddSouthWestChecker(r_northeastDoor2, door2Checker, false).

define tp_proving5 o_door1E CreateThing(o_doorModel1).
o_door1E@p_oState := 0.
o_door1E@p_oSound := "Bang!".
o_door1E@p_oDoorName := "east".
AddTail(r_eastDoor@p_rContents, o_door1E).
AddEastChecker(r_eastDoor, door1Checker, false).
define tp_proving5 o_door2E CreateThing(o_doorModel2).
o_door2E@p_oOtherDoor := o_door1E.
AddTail(r_eastDoor2@p_rContents, o_door2E).
AddWestChecker(r_eastDoor2, door2Checker, false).

define tp_proving5 p_oDoors CreateThingListProp().
define tp_proving5 p_oMapping CreateIntListProp().
o_winch@p_oDoors := CreateThingList().
AddTail(o_winch@p_oDoors, o_door1W).
AddTail(o_winch@p_oDoors, o_door1NW).
AddTail(o_winch@p_oDoors, o_door1N).
AddTail(o_winch@p_oDoors, o_door1NE).
AddTail(o_winch@p_oDoors, o_door1E).
o_winch@p_oMapping := CreateIntArray(5).

define tp_proving5 proc doorsEntranceDesc()string:
    string str, doorName;
    int openCount, i, openOne;
    list thing doors;

    doors := o_winch@p_oDoors;
    openCount := 0;
    for i from 0 upto 4 do
	if doors[i]@p_oState = 1 then
	    openOne := i;
	    openCount := openCount + 1;
	fi;
    od;
    if openCount = 0 then
	str := "All of the doors are closed."
    elif openCount = 1 then
	str := "The " + doors[openOne]@p_oDoorName + " door is open.";
    elif openCount = 2 then
	str := "";
	for i from 0 upto 4 do
	    if doors[i]@p_oState = 1 then
		doorName := doors[i]@p_oDoorName;
		if str = "" then
		    str := "The " + doorName + " and ";
		else
		    str := str + doorName + " doors are open.";
		fi;
	    fi;
	od;
    else
	/* openCount = 3, other values should not be possible */
	for i from 0 upto 4 do
	    if doors[i]@p_oState = 1 then
		doorName := doors[i]@p_oDoorName;
		case openCount
		incase 3:
		    str := "The " + doorName + ", ";
		incase 2:
		    str := str + doorName + " and ";
		incase 1:
		    str := str + doorName + " doors are open.";
		esac;
		openCount := openCount - 1;
	    fi;
	od;
    fi;
    "This small chamber has 5 doors in it, heading east, northeast, north, "
    "northwest and west. Over each door is a carved eye, and a similar but "
    "larger carving fills much of the floor. " + str + " There is also a "
    "passage leading south, which you are currently in front of."
corp;
r_doorsEntrance@p_rDescAction := doorsEntranceDesc.

o_winch@p_oSoundList := CreateThingList().
AddTail(o_winch@p_oSoundList, r_westDoor).
AddTail(o_winch@p_oSoundList, r_northwestDoor).
AddTail(o_winch@p_oSoundList, r_northDoor).
AddTail(o_winch@p_oSoundList, r_northeastDoor).
AddTail(o_winch@p_oSoundList, r_eastDoor).
AddTail(o_winch@p_oSoundList, r_westDoor2).
AddTail(o_winch@p_oSoundList, r_northwestDoor2).
AddTail(o_winch@p_oSoundList, r_northDoor2).
AddTail(o_winch@p_oSoundList, r_northeastDoor2).
AddTail(o_winch@p_oSoundList, r_eastDoor2).
AddTail(o_winch@p_oSoundList, r_doorsExit).

define tp_proving5 DOOR_TIME	8.

define tp_proving5 proc dropDoor(thing door; bool lightThere)void:
    string sound, sound2;

    sound := door@p_oSound;
    sound2 := sound + "\n";
    SayToList(o_winch@p_oSoundList, sound2);
    ABPrint(r_doorsEntrance, nil, nil,
	if lightThere then
	    sound + " The " + door@p_oDoorName + " door slams closed!\n"
	else
	    sound2
	fi);
    ABPrint(r_tunnelX7, nil, nil, sound2);
    ABPrint(r_tunnelX6, nil, nil, sound2);
    ABPrint(r_tunnelX5, nil, nil, "Rattle-rattle-clang! " + sound +
	if o_winch@p_oState = 0 then
	    " The winch releases the rest of the way.\n"
	else
	    " The winch releases part way.\n"
	fi);
    door@p_oState := 0;
corp;

define tp_proving5 proc doorsDrop(thing winch)void:
    int state;

    state := o_winch@p_oState;
    if state ~= 0 then
	state := state - 1;
	o_winch@p_oState := state;
	dropDoor(o_winch@p_oDoors[o_winch@p_oMapping[state]], false);
	if state ~= 0 then
	    DoAfter(DOOR_TIME, winch, doorsDrop);
	fi;
    fi;
corp;

define tp_proving5 proc clearWinch(bool lightThere)void:
    int state;
    list int li;
    list thing lt;

    state := o_winch@p_oState;
    li := o_winch@p_oMapping;
    lt := o_winch@p_oDoors;
    while state ~= 0 do
	state := state - 1;
	o_winch@p_oState := state;
	dropDoor(lt[li[state]], lightThere);
    od;
corp;

define tp_proving5 proc doorsEnter()status:

    if o_winch@p_oState ~= 0 then
	ignore CancelDoAfter(o_winch, doorsDrop);
	doorsDrop(o_winch);
    fi;
    continue
corp;
AddAnyEnterChecker(r_tunnelX5, doorsEnter, false).
AddAnyEnterChecker(r_tunnelX6, doorsEnter, false).
AddAnyEnterChecker(r_tunnelX7, doorsEnter, false).

define tp_proving5 proc doorsLightEnter()status:

    if o_winch@p_oState ~= 0 then
	ignore CancelDoAfter(o_winch, doorsDrop);
	if HasLight(Me()) then
	    clearWinch(true);
	else
	    doorsDrop(o_winch);
	fi;
    fi;
    continue
corp;
AddAnyEnterChecker(r_doorsEntrance, doorsLightEnter, false).
AddAnyEnterChecker(r_westDoor, doorsLightEnter, false).
AddAnyEnterChecker(r_northwestDoor, doorsLightEnter, false).
AddAnyEnterChecker(r_northDoor, doorsLightEnter, false).
AddAnyEnterChecker(r_northeastDoor, doorsLightEnter, false).
AddAnyEnterChecker(r_eastDoor, doorsLightEnter, false).
AddAnyEnterChecker(r_doorsExit, doorsLightEnter, false).
AddAnyEnterChecker(r_westDoor2, doorsLightEnter, false).
AddAnyEnterChecker(r_northwestDoor2, doorsLightEnter, false).
AddAnyEnterChecker(r_northDoor2, doorsLightEnter, false).
AddAnyEnterChecker(r_northeastDoor2, doorsLightEnter, false).
AddAnyEnterChecker(r_eastDoor2, doorsLightEnter, false).

define tp_proving5 proc turnWinch()status:
    int i, j, temp;
    list int li;
    list thing lt;

    if o_winch@p_oState ~= 0 then
	Print("Before you can crank up the winch, you first release it from "
	    "its current position. ");
	ignore CancelDoAfter(o_winch, doorsDrop);
	clearWinch(false);
    fi;
    Print("The winch turns easily and you quickly crank it up all the way.\n");
    if CanSee(r_tunnelX5, Me()) then
	OPrint(Capitalize(Me()@p_pName) + " cranks the winch up.\n");
    else
	OPrint("You hear someone cranking the winch.\n");
    fi;
    li := o_winch@p_oMapping;
    lt := o_winch@p_oDoors;
    for i from 0 upto 4 do
	li[i] := i;
	lt[i]@p_oState := 1;
    od;
    for i from 0 upto 4 do
	j := Random(5 - i);
	temp := li[i + j];
	li[i + j] := li[i];
	li[i] := temp;
    od;
    o_winch@p_oState := 5;
    if LightAt(r_doorsEntrance) or LightAt(r_westDoor) or
	LightAt(r_northwestDoor) or LightAt(r_northDoor) or
	LightAt(r_northeastDoor) or LightAt(r_eastDoor) or
	LightAt(r_doorsExit) or LightAt(r_westDoor2) or
	LightAt(r_northwestDoor2) or LightAt(r_northDoor2) or
	LightAt(r_northeastDoor2) or LightAt(r_eastDoor2)
    then
	SayToList(o_winch@p_oSoundList, "The door smoothly rises up.\n");
	ABPrint(r_doorsEntrance, nil, nil,"The doors all smoothly rise up.\n");
	clearWinch(true);
    else
	SayToList(o_winch@p_oSoundList, "You hear something moving.\n");
	DoAfter(DOOR_TIME, o_winch, doorsDrop);
    fi;
    succeed
corp;
o_winch@p_oTurnChecker := turnWinch.

unuse tp_proving5
