/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * doorsRoom.m - the doors rooms area.
 */

define tp_proving tp_doorsRoom CreateTable()$
use tp_doorsRoom

define tp_doorsRoom DOOR_TIME	 8$
define tp_doorsRoom WINCH_VOLUME_DECREASE	3000$
define tp_doorsRoom DOOR_VOLUME_DECREASE	2000$

define tp_doorsRoom r_tunnelX4 CreateThing(r_provingCave)$
SetupRoomDP(r_tunnelX4, "at the south end of a passage",
    "A large wooden door blocks the south end of the passage.")$
UniConnect(r_tunnelX4, r_chasm6, D_SOUTH)$
r_tunnelX4@p_rNoGenerateMonsters := true$
define tp_doorsRoom PR_TUNNELX4_ID NextEffectId()$
define tp_doorsRoom proc drawTunnelX4()void:

    if not KnowsEffect(nil, PR_TUNNELX4_ID) then
	DefineEffect(nil, PR_TUNNELX4_ID);
	GSetImage(nil, "Proving/tunnelX4");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.5, 1.0, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 0.207, 0.0);
	    GRectangle(nil, 0.087, 0.545, true);
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 0.235, 0.55);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_TUNNELX4_ID);
corp;
AutoGraphics(r_tunnelX4, drawTunnelX4)$

define tp_doorsRoom o_door1 CreateThing(nil)$
FakeObject(o_door1, r_chasm6, "door;sturdy,wooden",
    "The door is made from massive wooden beams, fastened together with thick "
    "iron straps. There is a small keyhole in the door.")$
o_door1@p_oOpenString := "The door is locked."$
o_door1@p_oPushString := "The door is locked."$
o_door1@p_oPullString := "The door is locked."$
o_door1@p_Image := "Proving/doorFromChasm"$

define tp_doorsRoom o_keyHole2 CreateThing(nil)$
FakeObject(o_keyHole2, r_chasm6, "hole,keyhole;small,key", "")$
o_keyHole2@p_oContents := CreateThingList()$
o_keyHole2@p_Image := "Proving/keyhole"$

define tp_doorsRoom proc putInKeyHole2(thing key, keyhole)status:
    string name;
    bool hidden;

    if Parent(key) = o_ironKey then
	name := CharacterNameG(Me());
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
o_keyHole2@p_oPutInMeChecker := putInKeyHole2$
define tp_doorsRoom proc doUnlock2(thing keyhole, key)status:
    putInKeyHole2(key, keyhole)
corp;
o_keyHole2@p_oUnlockMeWithChecker := doUnlock2$
SetThingStatus(o_keyHole2, ts_readonly)$
o_door1@p_oUnlockMeWithChecker := doUnlock2$
SetThingStatus(o_door1, ts_readonly)$

define tp_doorsRoom proc backThroughDoor()status:
    string name;
    bool hidden;

    name := CharacterNameG(Me());
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
define tp_doorsRoom proc doBackThroughDoor()status:
    ignore backThroughDoor();
    fail
corp;
AddSouthChecker(r_tunnelX4, doBackThroughDoor, false)$

define tp_doorsRoom o_door2 CreateThing(nil)$
FakeObject(o_door2, r_tunnelX4, "door;sturdy,wooden", "")$
o_door2@p_oOpenChecker := backThroughDoor$
o_door2@p_oPullChecker := backThroughDoor$
o_door2@p_oPushChecker := backThroughDoor$
o_door2@p_oNotLockable := true$
o_door2@p_Image := "Proving/doorToChasm"$

/* Here for a while is the area beyond the door in the crack in the chasm.
   This is the doorsroom area with the winch. */

define tp_doorsRoom r_tunnelX CreateThing(r_tunnel)$
r_tunnelX@p_rDark := true$
AutoGraphics(r_tunnelX, AutoTunnels)$
AutoPens(r_tunnelX, C_DARK_GREY, C_LIGHT_GREY, C_LIGHT_GREY, C_LIGHT_GREY)$
SetThingStatus(r_tunnelX, ts_readonly)$

define tp_doorsRoom r_tunnelX5 CreateThing(r_tunnelX)$
SetupRoomDP(r_tunnelX5, "in a north-south passage",
    "There is a winch arrangement on the wall here.")$
Connect(r_tunnelX4, r_tunnelX5, D_NORTH)$
Scenery(r_tunnelX5, "hole.rope")$
r_tunnelX5@p_rHintString := "Why do they close so suddenly?"$

define tp_doorsRoom r_tunnelX6 CreateThing(r_tunnelX)$
SetupRoomDP(r_tunnelX6, "in a north-south passage", "")$
Connect(r_tunnelX5, r_tunnelX6, D_NORTH)$

define tp_doorsRoom r_tunnelX7 CreateThing(r_tunnelX)$
SetupRoomDP(r_tunnelX7, "in a north-south passage", "")$
Connect(r_tunnelX6, r_tunnelX7, D_NORTH)$

define tp_doorsRoom PR_DOORS1_ID NextEffectId()$
define tp_doorsRoom proc drawDoors1()void:

    if not KnowsEffect(nil, PR_DOORS1_ID) then
	DefineEffect(nil, PR_DOORS1_ID);
	GSetPen(nil, C_BROWN);
	GAMove(nil, 0.127, 0.66);
	VerticalDoor();
	GAMove(nil, 0.165, 0.48);
	NorthWestDoor();
	GAMove(nil, 0.237, 0.4);
	HorizontalDoor();
	GAMove(nil, 0.339, 0.48);
	NorthEastDoor();
	GAMove(nil, 0.376, 0.66);
	VerticalDoor();
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS1_ID);
corp;

define tp_doorsRoom PR_DOORS2_ID NextEffectId()$
define tp_doorsRoom proc drawDoors2()void:

    if not KnowsEffect(nil, PR_DOORS2_ID) then
	DefineEffect(nil, PR_DOORS2_ID);
	GSetImage(nil, "Proving/doors2");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.5, 1.0, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 0.219, 0.999);
	    GADraw(nil, 0.1875, 0.8);
	    GADraw(nil, 0.129, 0.8);
	    GADraw(nil, 0.129, 0.6);
	    GADraw(nil, 0.1875, 0.405);
	    GADraw(nil, 0.3125, 0.405);
	    GADraw(nil, 0.374, 0.6);
	    GADraw(nil, 0.374, 0.8);
	    GADraw(nil, 0.3125, 0.8);
	    GADraw(nil, 0.28125, 0.999);
	    GPolygonEnd(nil);

	    drawDoors1();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS2_ID);
corp;

define tp_doorsRoom PR_DOORS3_ID NextEffectId()$
define tp_doorsRoom proc drawDoors3()void:

    if not KnowsEffect(nil, PR_DOORS3_ID) then
	DefineEffect(nil, PR_DOORS3_ID);
	GSetImage(nil, "Proving/doors3");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.5, 1.0, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 0.219, 0.999);
	    GADraw(nil, 0.1875, 0.8);
	    GADraw(nil, 0.0625, 0.8);
	    GADraw(nil, 0.0625, 0.2);
	    GADraw(nil, 0.4375, 0.2);
	    GADraw(nil, 0.4375, 0.8);
	    GADraw(nil, 0.3125, 0.8);
	    GADraw(nil, 0.28125, 0.999);
	    GPolygonEnd(nil);
	    GAMove(nil, 0.219, 0.0);
	    GRectangle(nil, 0.0625, 0.2, true);

	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.127, 0.8);
	    GADraw(nil, 0.127, 0.6);
	    GADraw(nil, 0.19, 0.4);
	    GADraw(nil, 0.3125, 0.4);
	    GADraw(nil, 0.375, 0.6);
	    GADraw(nil, 0.375, 0.8);

	    drawDoors1();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_DOORS3_ID);
corp;

define tp_doorsRoom DOORS1_MAP_GROUP NextMapGroup()$
define tp_doorsRoom DOORS2_MAP_GROUP NextMapGroup()$

define tp_doorsRoom r_doorsModel1 CreateThing(r_tunnel)$
r_doorsModel1@p_rDark := true$
r_doorsModel1@p_MapGroup := DOORS1_MAP_GROUP$
r_doorsModel1@p_rDrawAction := drawDoors2$
r_doorsModel1@p_rEnterRoomDraw := EnterRoomDraw$
r_doorsModel1@p_rLeaveRoomDraw := LeaveRoomDraw$
RoomName(r_doorsModel1, "Doors", "Room")$
Scenery(r_doorsModel1, "eye;carved.carving;eye.chamber")$
SetThingStatus(r_doorsModel1, ts_readonly)$

define tp_doorsRoom proc makeDoors1(fixed x, y; string name)thing:
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

define tp_doorsRoom r_doorsModel2 CreateThing(r_tunnel)$
r_doorsModel2@p_rDark := true$
r_doorsModel2@p_MapGroup := DOORS2_MAP_GROUP$
r_doorsModel2@p_rDrawAction := drawDoors3$
r_doorsModel2@p_rEnterRoomDraw := EnterRoomDraw$
r_doorsModel2@p_rLeaveRoomDraw := LeaveRoomDraw$
RoomName(r_doorsModel2, "Doors", "Room")$
SetThingStatus(r_doorsModel2, ts_readonly)$

define tp_doorsRoom proc makeDoors2(fixed x, y; string name)thing:
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

define tp_doorsRoom r_doorsEntrance makeDoors1(0.253, 0.7,
    "in the room of many doors")$
Connect(r_tunnelX7, r_doorsEntrance, D_NORTH)$
Scenery(r_doorsEntrance, "door.passage")$	/* adds to default */

define tp_doorsRoom r_westDoor makeDoors1(0.144, 0.7, "by the west door")$
Connect(r_doorsEntrance, r_westDoor, D_WEST)$

define tp_doorsRoom r_northwestDoor makeDoors1(0.172, 0.54,
    "by the northwest door")$
Connect(r_doorsEntrance, r_northwestDoor, D_NORTHWEST)$
Connect(r_westDoor, r_northwestDoor, D_NORTH)$
Connect(r_westDoor, r_northwestDoor, D_NORTHEAST)$

define tp_doorsRoom r_northDoor makeDoors1(0.253, 0.45, "by the north door")$
Connect(r_doorsEntrance, r_northDoor, D_NORTH)$
Connect(r_northwestDoor, r_northDoor, D_EAST)$
Connect(r_northwestDoor, r_northDoor, D_NORTHEAST)$

define tp_doorsRoom r_northeastDoor makeDoors1(0.328, 0.54,
    "by the northeast door")$
Connect(r_doorsEntrance, r_northeastDoor, D_NORTHEAST)$
Connect(r_northDoor, r_northeastDoor, D_EAST)$
Connect(r_northDoor, r_northeastDoor, D_SOUTHEAST)$

define tp_doorsRoom r_eastDoor makeDoors1(0.356, 0.7, "by the east door")$
Connect(r_doorsEntrance, r_eastDoor, D_EAST)$
Connect(r_northeastDoor, r_eastDoor, D_SOUTH)$
Connect(r_northeastDoor, r_eastDoor, D_SOUTHEAST)$

define tp_doorsRoom r_westDoor2 makeDoors2(0.106, 0.7, "by the west door")$
Connect(r_westDoor, r_westDoor2, D_WEST)$

define tp_doorsRoom r_northwestDoor2 makeDoors2(0.144, 0.46,
    "by the northwest door")$
Connect(r_northwestDoor, r_northwestDoor2, D_NORTHWEST)$
Connect(r_westDoor2, r_northwestDoor2, D_NORTHEAST)$
Connect(r_westDoor2, r_northwestDoor2, D_NORTH)$

define tp_doorsRoom r_northDoor2 makeDoors2(0.253, 0.35, "by the north door")$
Connect(r_northDoor, r_northDoor2, D_NORTH)$
Connect(r_northwestDoor2, r_northDoor2, D_NORTHEAST)$
UniConnect(r_northwestDoor2, r_northDoor2, D_NORTH)$
Connect(r_northDoor2, r_northwestDoor2, D_WEST)$

define tp_doorsRoom r_northeastDoor2 makeDoors2(0.356, 0.46,
    "by the northeast door")$
Connect(r_northeastDoor, r_northeastDoor2, D_NORTHEAST)$
Connect(r_northeastDoor2, r_northDoor2, D_NORTHWEST)$
UniConnect(r_northeastDoor2, r_northDoor2, D_NORTH)$
Connect(r_northDoor2, r_northeastDoor2, D_EAST)$

define tp_doorsRoom r_eastDoor2 makeDoors2(0.394, 0.7, "by the east door")$
Connect(r_eastDoor, r_eastDoor2, D_EAST)$
Connect(r_eastDoor2, r_northeastDoor2, D_NORTHWEST)$
Connect(r_eastDoor2, r_northeastDoor2, D_NORTH)$

define tp_proving r_doorsExit makeDoors2(0.25, 0.23,
    "in the room of many doors")$
Connect(r_northDoor2, r_doorsExit, D_NORTH)$

ignore DeleteSymbol(tp_doorsRoom, "makeDoors2")$
ignore DeleteSymbol(tp_doorsRoom, "makeDoors1")$

define tp_doorsRoom o_doorModel1 CreateThing(nil)$
FakeObject(o_doorModel1, nil, "door;sturdy,wooden", "")$
define tp_doorsRoom proc door1Desc()string:
    if It()@p_oState = 0 then
	"The door looks like it opens by sliding upwards, but it is currently "
	"closed and you can see no way to open it, nor any sign of a keyhole "
	"or other mechanism."
    else
	/* this cannot ever happen */
	"The door is currently slid upwards out of the way."
    fi
corp;
o_doorModel1@p_oDescAction := door1Desc$
define tp_doorsRoom proc door1Unlock(thing door, key)status:
    Print("You can see no lock mechanism on the door.\n");
    succeed
corp;
o_doorModel1@p_oUnlockMeWithChecker := door1Unlock$
o_doorModel1@p_Image := "Proving/doorOutside"$
SetThingStatus(o_doorModel1, ts_readonly)$

define tp_doorsRoom o_winch CreateThing(nil)$
FakeObject(o_winch, r_tunnelX5, "winch.arrangement;winch.crank", "")$
o_winch@p_oState := 0$
define tp_doorsRoom proc winchDesc()string:
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
o_winch@p_oDescAction := winchDesc$
o_winch@p_Image := "Proving/winch"$

define tp_doorsRoom p_oOtherDoor CreateThingProp()$
define tp_doorsRoom p_oSound CreateStringProp()$
define tp_doorsRoom p_oDoorName CreateStringProp()$

    /* The locations actually in the doors room: */
define tp_doorsRoom p_oSoundList CreateThingListProp()$
o_winch@p_oSoundList := CreateThingList()$
AddTail(o_winch@p_oSoundList, r_westDoor)$
AddTail(o_winch@p_oSoundList, r_northwestDoor)$
AddTail(o_winch@p_oSoundList, r_northDoor)$
AddTail(o_winch@p_oSoundList, r_northeastDoor)$
AddTail(o_winch@p_oSoundList, r_eastDoor)$
AddTail(o_winch@p_oSoundList, r_westDoor2)$
AddTail(o_winch@p_oSoundList, r_northwestDoor2)$
AddTail(o_winch@p_oSoundList, r_northDoor2)$
AddTail(o_winch@p_oSoundList, r_northeastDoor2)$
AddTail(o_winch@p_oSoundList, r_eastDoor2)$
AddTail(o_winch@p_oSoundList, r_doorsExit)$

    /* The corridor, in order going away from the doors room: */
define tp_doorsRoom p_oSoundList2 CreateThingListProp()$
o_winch@p_oSoundList2 := CreateThingList()$
AddTail(o_winch@p_oSoundList2, r_tunnelX7)$
AddTail(o_winch@p_oSoundList2, r_tunnelX6)$
AddTail(o_winch@p_oSoundList2, r_tunnelX5)$
AddTail(o_winch@p_oSoundList2, r_tunnelX4)$

    /* The corridor, in order of distance from winch: (with cheats!) */
define tp_doorsRoom p_oSoundList3 CreateThingListProp()$
o_winch@p_oSoundList3 := CreateThingList()$
AddTail(o_winch@p_oSoundList3, r_tunnelX5)$
AddTail(o_winch@p_oSoundList3, r_tunnelX4)$
AddTail(o_winch@p_oSoundList3, r_tunnelX6)$
AddTail(o_winch@p_oSoundList3, r_tunnelX7)$

define tp_doorsRoom o_doorModel2 CreateThing(nil)$
FakeObject(o_doorModel2, nil, "door;sturdy,wooden", "")$
define tp_doorsRoom proc door2Desc()string:
    if It()@p_oOtherDoor@p_oState = 0 then
	"The door looks like it opens by sliding upwards. There is a handy "
	"handle on it for lifting with."
    else
	/* Hmm. should never see this! */
	"The door is currently slid upwards out of the way."
    fi
corp;
o_doorModel2@p_oDescAction := door2Desc$
o_doorModel2@p_oNotLockable := true$
o_doorModel2@p_Image := "Proving/doorInside"$
SetThingStatus(o_doorModel2, ts_readonly)$

define tp_doorsRoom proc door1Checker()status:

    if Here()@p_rContents[0]@p_oState = 0 then
	Print("You cannot go that way - the door is closed.\n");
	fail
    else
	continue
    fi
corp;

define tp_doorsRoom p_oSoundName CreateStringProp()$
define tp_doorsRoom p_oSoundVolume CreateIntProp()$

define tp_doorsRoom proc makeOneSound(thing client)void:

    if SOn(client) then
	SVolume(client, o_winch@p_oSoundVolume);
	SPlaySound(client, o_winch@p_oSoundName, 1, 0);
	SVolume(client, 10000);
    fi;
corp;

define tp_doorsRoom proc doDoorSound(string sound; thing room; int volume)void:
    o_winch@p_oSoundName := sound;
    o_winch@p_oSoundVolume := volume;
    /* Doing this test makes the player hear the sound also, regardless
       of whether we are called by a direct player action. */
    if Here() = room then
	makeOneSound(Me());
    fi;
    ForEachAgent(room, makeOneSound);
corp;

define tp_doorsRoom proc makeDoorSound(string sound)void:
    list thing lt;
    int i, volume;

    volume := 10000;
    lt := o_winch@p_oSoundList;
    for i from 0 upto Count(lt) - 1 do
	doDoorSound(sound, lt[i], volume);
    od;
    doDoorSound(sound, r_doorsEntrance, volume);
    lt := o_winch@p_oSoundList2;
    for i from 0 upto Count(lt) - 1 do
	volume := volume - DOOR_VOLUME_DECREASE;
	doDoorSound(sound, lt[i], volume);
    od;
corp;

define tp_doorsRoom proc doWinchSound(string sound;thing room; int volume)void:
    o_winch@p_oSoundName := sound;
    o_winch@p_oSoundVolume := volume;
    if Here() = room then
	makeOneSound(Me());
    fi;
    ForEachAgent(room, makeOneSound);
corp;

define tp_doorsRoom proc makeWinchSound(string sound)void:
    list thing lt;
    int i, volume;

    volume := 10000;
    lt := o_winch@p_oSoundList3;
    for i from 0 upto Count(lt) - 1 do
	doWinchSound(sound, lt[i], volume);
	if i ~= 1 then
	    volume := volume - WINCH_VOLUME_DECREASE;
	fi;
    od;
    doWinchSound(sound, r_doorsEntrance, volume);
    volume := volume - WINCH_VOLUME_DECREASE;
    lt := o_winch@p_oSoundList;
    for i from 0 upto Count(lt) - 1 do
	doWinchSound(sound, lt[i], volume);
    od;
corp;

define tp_doorsRoom proc door2Checker()status:
    thing otherDoor;

    otherDoor := Here()@p_rContents[0]@p_oOtherDoor;
    if otherDoor@p_oState = 0 then
	Print("You lift the door by the handle and pass through.\n");
	if CanSee(Here(), Me()) then
	    OPrint(Capitalize(CharacterNameG(Me())) +
		" lifts the door and passes through.\n");
	fi;
	SayToList(o_winch@p_oSoundList, otherDoor@p_oSound + "!\n");
	makeDoorSound(otherDoor@p_oSound);
	/* The enter checker for the other room will shut all the doors if
	   the player has a light. */
    fi;
    continue
corp;

define tp_doorsRoom o_door1W CreateThing(o_doorModel1)$
o_door1W@p_oState := 0$
o_door1W@p_oSound := "Thump"$
o_door1W@p_oDoorName := "west"$
AddTail(r_westDoor@p_rContents, o_door1W)$
AddWestChecker(r_westDoor, door1Checker, false)$
define tp_doorsRoom o_door2W CreateThing(o_doorModel2)$
o_door2W@p_oOtherDoor := o_door1W$
AddTail(r_westDoor2@p_rContents, o_door2W)$
AddEastChecker(r_westDoor2, door2Checker, false)$

define tp_doorsRoom o_door1NW CreateThing(o_doorModel1)$
o_door1NW@p_oState := 0$
o_door1NW@p_oSound := "Thud"$
o_door1NW@p_oDoorName := "north-west"$
AddTail(r_northwestDoor@p_rContents, o_door1NW)$
AddNorthWestChecker(r_northwestDoor, door1Checker, false)$
define tp_doorsRoom o_door2NW CreateThing(o_doorModel2)$
o_door2NW@p_oOtherDoor := o_door1NW$
AddTail(r_northwestDoor2@p_rContents, o_door2NW)$
AddSouthEastChecker(r_northwestDoor2, door2Checker, false)$

define tp_doorsRoom o_door1N CreateThing(o_doorModel1)$
o_door1N@p_oState := 0$
o_door1N@p_oSound := "Boom"$
o_door1N@p_oDoorName := "north"$
AddTail(r_northDoor@p_rContents, o_door1N)$
AddNorthChecker(r_northDoor, door1Checker, false)$
define tp_doorsRoom o_door2N CreateThing(o_doorModel2)$
o_door2N@p_oOtherDoor := o_door1N$
AddTail(r_northDoor2@p_rContents, o_door2N)$
AddSouthChecker(r_northDoor2, door2Checker, false)$

define tp_doorsRoom o_door1NE CreateThing(o_doorModel1)$
o_door1NE@p_oState := 0$
o_door1NE@p_oSound := "Crash"$
o_door1NE@p_oDoorName := "north-east"$
AddTail(r_northeastDoor@p_rContents, o_door1NE)$
AddNorthEastChecker(r_northeastDoor, door1Checker, false)$
define tp_doorsRoom o_door2NE CreateThing(o_doorModel2)$
o_door2NE@p_oOtherDoor := o_door1NE$
AddTail(r_northeastDoor2@p_rContents, o_door2NE)$
AddSouthWestChecker(r_northeastDoor2, door2Checker, false)$

define tp_doorsRoom o_door1E CreateThing(o_doorModel1)$
o_door1E@p_oState := 0$
o_door1E@p_oSound := "Bang"$
o_door1E@p_oDoorName := "east"$
AddTail(r_eastDoor@p_rContents, o_door1E)$
AddEastChecker(r_eastDoor, door1Checker, false)$
define tp_doorsRoom o_door2E CreateThing(o_doorModel2)$
o_door2E@p_oOtherDoor := o_door1E$
AddTail(r_eastDoor2@p_rContents, o_door2E)$
AddWestChecker(r_eastDoor2, door2Checker, false)$

define tp_doorsRoom p_oDoors CreateThingListProp()$
define tp_doorsRoom p_oMapping CreateIntListProp()$
o_winch@p_oDoors := CreateThingList()$
AddTail(o_winch@p_oDoors, o_door1W)$
AddTail(o_winch@p_oDoors, o_door1NW)$
AddTail(o_winch@p_oDoors, o_door1N)$
AddTail(o_winch@p_oDoors, o_door1NE)$
AddTail(o_winch@p_oDoors, o_door1E)$
o_winch@p_oMapping := CreateIntArray(5)$

define tp_doorsRoom proc doorsEntranceDesc()string:
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
r_doorsEntrance@p_rDescAction := doorsEntranceDesc$

define tp_doorsRoom proc dropDoor(thing door; bool lightThere)void:
    string sound, sound2;

    sound := door@p_oSound;
    sound2 := sound + "!\n";
    SayToList(o_winch@p_oSoundList, sound2);
    makeDoorSound(sound);
    makeWinchSound("winch-down");
    ABPrint(r_doorsEntrance, nil, nil,
	if lightThere then
	    sound + "! The " + door@p_oDoorName + " door slams closed!\n"
	else
	    sound2
	fi);
    ABPrint(r_tunnelX7, nil, nil, sound2);
    ABPrint(r_tunnelX6, nil, nil, sound2);
    ABPrint(r_tunnelX5, nil, nil, "Rattle-rattle-clang! " + sound +
	if o_winch@p_oState = 0 then
	    "! The winch releases the rest of the way.\n"
	else
	    "! The winch releases part way.\n"
	fi);
    ABPrint(r_tunnelX4, nil, nil, sound2);
    door@p_oState := 0;
corp;

define tp_doorsRoom proc doorsDrop(thing winch)void:
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

define tp_doorsRoom proc clearWinch(bool lightThere)void:
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

define tp_doorsRoom proc doorsEnter()status:

    if o_winch@p_oState ~= 0 then
	ignore CancelDoAfter(o_winch, doorsDrop);
	doorsDrop(o_winch);
    fi;
    continue
corp;
AddAnyEnterChecker(r_tunnelX5, doorsEnter, false)$
AddAnyEnterChecker(r_tunnelX6, doorsEnter, false)$
AddAnyEnterChecker(r_tunnelX7, doorsEnter, false)$

define tp_doorsRoom proc doorsLightEnter()status:

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
AddAnyEnterChecker(r_doorsEntrance, doorsLightEnter, false)$
AddAnyEnterChecker(r_westDoor, doorsLightEnter, false)$
AddAnyEnterChecker(r_northwestDoor, doorsLightEnter, false)$
AddAnyEnterChecker(r_northDoor, doorsLightEnter, false)$
AddAnyEnterChecker(r_northeastDoor, doorsLightEnter, false)$
AddAnyEnterChecker(r_eastDoor, doorsLightEnter, false)$
AddAnyEnterChecker(r_doorsExit, doorsLightEnter, false)$
AddAnyEnterChecker(r_westDoor2, doorsLightEnter, false)$
AddAnyEnterChecker(r_northwestDoor2, doorsLightEnter, false)$
AddAnyEnterChecker(r_northDoor2, doorsLightEnter, false)$
AddAnyEnterChecker(r_northeastDoor2, doorsLightEnter, false)$
AddAnyEnterChecker(r_eastDoor2, doorsLightEnter, false)$

define tp_doorsRoom proc checkAddLight()status:

    if o_winch@p_oState ~= 0 then
	ignore CancelDoAfter(o_winch, doorsDrop);
	clearWinch(true);
    fi;
    continue
corp;

AddRoomLightChecker(r_doorsEntrance, checkAddLight, true)$
AddRoomLightChecker(r_westDoor, checkAddLight, true)$
AddRoomLightChecker(r_northwestDoor, checkAddLight, true)$
AddRoomLightChecker(r_northDoor, checkAddLight, true)$
AddRoomLightChecker(r_northeastDoor, checkAddLight, true)$
AddRoomLightChecker(r_eastDoor, checkAddLight, true)$
AddRoomLightChecker(r_doorsExit, checkAddLight, true)$
AddRoomLightChecker(r_westDoor2, checkAddLight, true)$
AddRoomLightChecker(r_northwestDoor2, checkAddLight, true)$
AddRoomLightChecker(r_northDoor2, checkAddLight, true)$
AddRoomLightChecker(r_northeastDoor2, checkAddLight, true)$
AddRoomLightChecker(r_eastDoor2, checkAddLight, true)$

define tp_doorsRoom proc turnWinch()status:
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
    ABPrint(r_tunnelX4, nil, nil, "Rattle-rattle.\n");
    if CanSee(r_tunnelX5, Me()) then
	OPrint(Capitalize(CharacterNameG(Me())) + " cranks the winch up.\n");
    else
	OPrint("You hear someone cranking the winch.\n");
    fi;
    ABPrint(r_tunnelX6, nil, nil, "Rattle-rattle.\n");
    ABPrint(r_tunnelX7, nil, nil, "Rattle-rattle.\n");
    makeWinchSound("winch-up");
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
	ABPrint(r_doorsExit, nil, nil, "The north door smoothly rises up.\n");
	clearWinch(true);
    else
	SayToList(o_winch@p_oSoundList, "You hear something moving.\n");
	DoAfter(DOOR_TIME, o_winch, doorsDrop);
    fi;
    succeed
corp;
o_winch@p_oTurnChecker := turnWinch$

unuse tp_doorsRoom
