/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * sewer.m - shallow sewer level of the proving grounds.
 */

define tp_proving tp_sewer CreateTable()$
use tp_sewer

define tp_sewer m_drinkingGoblin CreateMonsterModel("goblin,gob",
    "The goblin is a small, humanoid creature with pale skin, large eyes, "
    "protruding ears, and sharp teeth. It walks in a perpetual crouch but "
    "is nonetheless quite fast on its feet.",
    MonsterInit, RandomMove,
    10, 8, 9, 6, 5, 40)$
m_drinkingGoblin@p_mBlocker := true$
AddModelAction(m_drinkingGoblin, "slouches around")$
AddModelAction(m_drinkingGoblin, "gibbers")$
AddModelAction(m_drinkingGoblin, "drools")$
AddModelAction(m_drinkingGoblin, "howls")$
MakeMonsterSmart(m_drinkingGoblin)$
m_drinkingGoblin@p_mSpecialAction := monsterDrink$
m_drinkingGoblin@p_Image := "Characters/drinkingGoblin"$
m_drinkingGoblin@p_mSound := "goblin"$
GNewIcon(m_drinkingGoblin, makeGoblinIcon())$

/* also used in proving2.m */

define tp_proving proc monsterSet3(thing room)void:

    InitMonsterModels(room, 275);
    AddPossibleMonster(room, m_rat, 25);
    AddPossibleMonster(room, m_snake, 25);
    AddPossibleMonster(room, m_largeRat, 25);
    AddPossibleMonster(room, m_largeSnake, 25);
    AddPossibleMonster(room, m_drinkingGoblin, 25);
corp;

define tp_sewer proc grateLiftDown(thing sewerRoom)void:

    Print("You lift the grate on hinges and climb down into the sewer.\n");
    if Me()@p_pHidden then
	OPrint("The drainage grate lifts for a moment, then closes.\n");
    else
	OPrint(Capitalize(CharacterNameG(Me())) +
	    " lifts the drainage grate and descends into the sewer below.\n");
    fi;
    LeaveRoomStuff(sewerRoom, D_DOWN, MOVE_SPECIAL);
    EnterRoomStuff(sewerRoom, D_UP, MOVE_NORMAL);
corp;
define tp_sewer proc grateLiftUp(thing theAlley)status:
    string name;
    bool hidden;

    name := CharacterNameG(Me());
    hidden := Me()@p_pHidden;
    Print("You climb up to the grate, open it, and exit to the alley.\n");
    LeaveRoomStuff(theAlley, D_UP, MOVE_NORMAL);
    EnterRoomStuff(theAlley, D_DOWN, MOVE_SPECIAL);
    if hidden then
	OPrint("The drainage grate lifts for a moment, then closes.\n");
    else
	OPrint("The drainage grate lifts and " + name + " emerges.\n");
    fi;
    fail
corp;
define tp_proving o_drainageGrate CreateThing(nil)$
FakeModel(o_drainageGrate,
    "grate,grating;large,drainage."
	"grate,grating;large,drainage,drain,overhead."
	"overhead;large,drainage,drain,grating,grate."
	"frame;wooden.handle.bar;iron",
    "The grate is made of iron bars secured into a wooden frame. It has a "
    "handle on one side.")$
o_drainageGrate@p_oSmellString := "The grate smells of the sewer below."$
o_drainageGrate@p_oTouchString := "The grate is VERY dirty."$
o_drainageGrate@p_oLowerString := "The grate cannot be lowered any further."$
o_drainageGrate@p_oNotLockable := true$
o_drainageGrate@p_Image := "Proving/sewerGrateOutside"$
define tp_proving o_fakeGrate CreateThing(nil)$
FakeModel(o_fakeGrate, "grate,grating,drain;large,drainage", "")$
o_fakeGrate@p_oLiftString := "The grate is out of reach from here."$
o_fakeGrate@p_oOpenString := "The grate is out of reach from here."$
o_fakeGrate@p_oLowerString := "The grate is out of reach from here."$
o_fakeGrate@p_oNotLockable := true$
o_fakeGrate@p_Image := "Proving/sewerGrateInside"$

define tp_sewer o_trickle CreateThing(nil)$
SetupObject(o_trickle, nil, "water.stream.trickle", "")$
o_trickle@p_oInvisible := true$
o_trickle@p_oNotGettable := true$
define tp_sewer proc trickleDrink()status:
    thing me;
    string name;
    int current, max;

    me := Me();
    name := Capitalize(CharacterNameG(me));
    if not me@p_pHidden then
	OPrint(name + " takes a drink from the noxious trickle.\n");
    fi;
    current := me@p_pHitNow;
    if Parent(me) = m_drinkingGoblin then
	max := me@p_pHitMax;
	if current ~= max then
	    current := current + Random(3) + 2;
	    if current > max then
		current := max;
	    fi;
	    me@p_pHitNow := current;
	fi;
    else
	Print("ACK!!! It tastes horrible!\n");
	max := Random(3) + 2;
	if max >= current then
	    /* DOOM */
	    if me@p_pStandard then
		Print("You are killed!\n");
		if not me@p_pHidden then
		    OPrint(name + " dies!\n");
		fi;
		KillPlayer(me, me);
	    else
		KillMonster(me);
	    fi;
	else
	    me@p_pHitNow := current - max;
	fi;
    fi;
    succeed
corp;
o_trickle@p_oEatChecker := trickleDrink$
define tp_sewer o_drink CreateThing(nil)$
SetupObject(o_drink, nil, "drink.swallow", "")$
o_drink@p_oInvisible := true$
define tp_sewer proc takeDrink(thing drink)status:
    trickleDrink()
corp;
o_drink@p_oGetChecker := takeDrink$
o_trickle@p_Image := "Proving/trickle"$
o_trickle@p_oListenString := "The trickle of water is too small to hear."$
o_trickle@p_oSmellString := "The trickle of water smells bad."$

/* also used in proving2.m */

define tp_proving r_provingTunnel1 CreateThing(r_tunnel)$
AutoGraphics(r_provingTunnel1, AutoTunnels)$
AutoPens(r_provingTunnel1, C_DARK_GREY,C_LIGHT_GREY,C_LIGHT_GREY,C_LIGHT_GREY)$
SetThingStatus(r_provingTunnel1, ts_readonly)$
monsterSet3(r_provingTunnel1)$

define tp_proving r_provingTunnel2 CreateThing(r_tunnel)$
AutoGraphics(r_provingTunnel2, AutoTunnels)$
AutoPens(r_provingTunnel2, C_DARK_GREY,C_LIGHT_GREY,C_LIGHT_GREY,C_LIGHT_GREY)$
SetThingStatus(r_provingTunnel2, ts_readonly)$

define tp_proving r_provingTunnelD CreateThing(r_tunnel)$
r_provingTunnelD@p_rDark := true$
AutoGraphics(r_provingTunnelD, AutoTunnels)$
AutoPens(r_provingTunnelD, C_DARK_GREY,C_LIGHT_GREY,C_LIGHT_GREY,C_LIGHT_GREY)$
SetThingStatus(r_provingTunnelD, ts_readonly)$
monsterSet3(r_provingTunnelD)$

define tp_sewer r_sewer1 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer1, "in a north-south sewer",
    "This is fairly large tunnel made of wood and stone, with a trickle of "
    "noxious water flowing along the floor. "
    "There is a grating overhead with metal wrungs leading up to it.")$
HUniConnect(r_alley2, r_sewer1, D_DOWN)$
UniConnect(r_sewer1, r_alley2, D_UP)$
r_alley2@p_rDownOMessage := "."$
r_alley2@p_rDownEMessage := "."$
AddTail(r_sewer1@p_rContents, o_trickle)$
AddTail(r_sewer1@p_rContents, o_drink)$
AddTail(r_sewer1@p_rContents, o_fakeGrate)$
Scenery(r_sewer1, "wall.wood.stone.wrung;rusty,metal")$
define tp_sewer o_drainageGrate1 CreateThing(o_drainageGrate)$
AddTail(r_alley2@p_rContents, o_drainageGrate1)$
define tp_sewer proc grateLift1()status:
    grateLiftDown(r_sewer1);
    succeed
corp;
o_drainageGrate1@p_oLiftChecker := grateLift1$
o_drainageGrate1@p_oOpenChecker := grateLift1$
SetThingStatus(o_drainageGrate1, ts_wizard)$
define tp_sewer proc grateLift2()status:
    /* Only players, "standard" monsters (Packrat, etc.) and monsters who
       can reward with money (i.e. intelligent ones) can lift the grate. */
    if Me()@p_pStandard or Me()@p_pMoney ~= 0 then
	grateLiftDown(r_sewer1);
    fi;
    fail
corp;
AddDownChecker(r_alley2, grateLift2, false)$
define tp_sewer proc grateLift3()status:
    if Me()@p_pStandard or Me()@p_pMoney ~= 0 then
	grateLiftUp(r_alley2)
    else
	fail
    fi
corp;
AddUpChecker(r_sewer1, grateLift3, false)$

define tp_sewer r_sewer2 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer2, "in a north-south sewer",
    "You can barely see by natural light here. A dark opening heads west.")$
AddTail(r_sewer2@p_rContents, o_trickle)$
AddTail(r_sewer2@p_rContents, o_drink)$
Connect(r_sewer1, r_sewer2, D_SOUTH)$
Scenery(r_sewer2, "opening;dark")$

define tp_sewer r_sewer3 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer3, "in a north-south sewer",
    "Light comes down from a manhole above, casting a dim light on the "
    "scummy water covering your feet.")$
AddTail(r_sewer3@p_rContents, o_trickle)$
AddTail(r_sewer3@p_rContents, o_drink)$
Connect(r_sewer2, r_sewer3, D_SOUTH)$
AddTail(r_sewer3@p_rContents, o_manholeCover)$

define tp_sewer r_sewer4 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer4, "in a north-south sewer",
    "You can barely see by natural light here. A dark opening heads east.")$
AddTail(r_sewer4@p_rContents, o_trickle)$
AddTail(r_sewer4@p_rContents, o_drink)$
Connect(r_sewer3, r_sewer4, D_SOUTH)$
Scenery(r_sewer4, "opening;dark")$

define tp_sewer r_sewer5 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer5, "in a north-south sewer",
    "This is fairly large tunnel made of wood and stone, with a trickle of "
    "noxious water flowing along the floor. "
    "There is a grating overhead with metal wrungs leading up to it.")$
Connect(r_sewer4, r_sewer5, D_SOUTH)$
HUniConnect(r_alley4, r_sewer5, D_DOWN)$
UniConnect(r_sewer5, r_alley4, D_UP)$
r_alley4@p_rDownOMessage := "."$
r_alley4@p_rDownEMessage := "."$
AddTail(r_sewer5@p_rContents, o_trickle)$
AddTail(r_sewer5@p_rContents, o_drink)$
AddTail(r_sewer5@p_rContents, o_fakeGrate)$
Scenery(r_sewer5, "wall.wood.stone.wrung;metal")$
define tp_sewer o_drainageGrate2 CreateThing(o_drainageGrate)$
AddTail(r_alley4@p_rContents, o_drainageGrate2)$
define tp_sewer proc grateLift4()status:
    grateLiftDown(r_sewer5);
    succeed
corp;
o_drainageGrate2@p_oLiftChecker := grateLift4$
o_drainageGrate2@p_oOpenChecker := grateLift4$
SetThingStatus(o_drainageGrate2, ts_wizard)$
define tp_sewer proc grateLift5()status:
    if Me()@p_pStandard or Me()@p_pMoney ~= 0 then
	grateLiftDown(r_sewer5);
    fi;
    fail
corp;
AddDownChecker(r_alley4, grateLift5, false)$
define tp_sewer proc grateLift6()status:
    if Me()@p_pStandard or Me()@p_pMoney ~= 0 then
	grateLiftUp(r_alley4)
    else
	fail
    fi
corp;
AddUpChecker(r_sewer5, grateLift6, false)$

define tp_sewer r_sewer0 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer0, "in a north-south sewer",
    "This appears to be the north end of the sewer. A trickle of water "
    "comes down the walls and heads south, but there are no other exits.")$
AddTail(r_sewer0@p_rContents, o_trickle)$
AddTail(r_sewer0@p_rContents, o_drink)$
Connect(r_sewer1, r_sewer0, D_NORTH)$
Scenery(r_sewer0, "wall")$

define tp_proving r_sewerShaft1 CreateThing(r_provingTunnelD)$
SetupRoom(r_sewerShaft1, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb down here, and a "
    "small opening heads east.")$
Connect(r_sewer2, r_sewerShaft1, D_WEST)$
Scenery(r_sewerShaft1, "wrung;rusty,metal.opening;small")$

define tp_proving r_sewerShaft3 CreateThing(r_provingTunnelD)$
SetupRoom(r_sewerShaft3, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb down here, and a "
    "small opening heads west.")$
Connect(r_sewer4, r_sewerShaft3, D_EAST)$
Scenery(r_sewerShaft3, "wrung;metal.opening;small")$

define tp_proving r_sewer6 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer6, "in a north-south sewer",
    "On the west wall there is a small iron grill. There appears to be "
    "open space behind it, but you can find no way to get into it.")$
AddTail(r_sewer6@p_rContents, o_trickle)$
AddTail(r_sewer6@p_rContents, o_drink)$
Connect(r_sewer5, r_sewer6, D_SOUTH)$
Scenery(r_sewer6, "grill;small,iron.space;open")$

define tp_sewer r_sewer7 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewer7, "in a north-south sewer", "")$
AddTail(r_sewer7@p_rContents, o_trickle)$
AddTail(r_sewer7@p_rContents, o_drink)$
Connect(r_sewer6, r_sewer7, D_SOUTH)$

define tp_sewer r_sewer8 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewer8, "in a north-south sewer", "")$
AddTail(r_sewer8@p_rContents, o_trickle)$
AddTail(r_sewer8@p_rContents, o_drink)$
Connect(r_sewer7, r_sewer8, D_SOUTH)$

define tp_sewer r_sewer9 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewer9, "at a north and southwest corner in the sewer", "")$
AddTail(r_sewer9@p_rContents, o_trickle)$
AddTail(r_sewer9@p_rContents, o_drink)$
Connect(r_sewer8, r_sewer9, D_SOUTH)$
r_sewer9@p_StreamSoundVolume := 625$
AddAnyEnterChecker(r_sewer9, startStreamSound, false)$
AddNorthChecker(r_sewer9, stopStreamSound, false)$

define tp_sewer r_sewer10 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewer10, "in a sewer running northeast to southwest", "")$
AddTail(r_sewer10@p_rContents, o_trickle)$
AddTail(r_sewer10@p_rContents, o_drink)$
Connect(r_sewer9, r_sewer10, D_SOUTHWEST)$
r_sewer10@p_StreamSoundVolume := 1250$
AddAnyEnterChecker(r_sewer10, startStreamSound, false)$

define tp_sewer r_sewer11 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewer11, "at a northeast and west corner in the sewer", "")$
AddTail(r_sewer11@p_rContents, o_trickle)$
AddTail(r_sewer11@p_rContents, o_drink)$
Connect(r_sewer10, r_sewer11, D_SOUTHWEST)$
r_sewer11@p_StreamSoundVolume := 2500$
AddAnyEnterChecker(r_sewer11, startStreamSound, false)$

define tp_sewer r_sewer12 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer12, "in an east-west sewer",
    "You can see an opening to the west.")$
AddTail(r_sewer12@p_rContents, o_trickle)$
AddTail(r_sewer12@p_rContents, o_drink)$
Connect(r_sewer11, r_sewer12, D_WEST)$
r_sewer12@p_StreamSoundVolume := 5000$
AddAnyEnterChecker(r_sewer12, startStreamSound, false)$

define tp_sewer r_sewer13 CreateThing(r_provingTunnel1)$
SetupRoomP(r_sewer13, "at the end of the sewer",
    "This is fairly large tunnel made of wood and stone, with a trickle of "
    "noxious water flowing along the floor. "
    "The sewer extends into the darkness to the east. The west end of the "
    "tunnel is blocked by an iron bar grating. Through the bars you can see "
    "that the sewer drains into a small stream in a forest.")$
AddTail(r_sewer13@p_rContents, o_trickle)$
AddTail(r_sewer13@p_rContents, o_drink)$
Connect(r_sewer12, r_sewer13, D_WEST)$
Scenery(r_sewer13,
    "sewer.stream;small.forest.darkness.stonework.work;stone.stone."
    "wood.mouth;tunnel.tunnel;wood,and,stone")$
r_sewer13@p_StreamSoundVolume := 7500$
AddAnyEnterChecker(r_sewer13, startStreamSound, false)$
AddTail(r_sewer13@p_rContents, o_barGrating)$
AddTail(r_sewer13@p_rContents, o_gratingLatch)$
define tp_sewer proc showAgent1(thing agent)void:
    if agent@p_pName ~= "" and not agent@p_pHidden then
	Print(Capitalize(CharacterNameG(agent)) +" is outside the grating.\n");
    fi;
corp;
define tp_sewer proc extraDesc1()void:
    ForEachAgent(r_forestByStream, showAgent1);
corp;
r_sewer13@p_rFurtherDesc := extraDesc1$
define tp_sewer proc showAgent2(thing agent)void:
    if agent@p_pName ~= "" and not agent@p_pHidden then
	Print(Capitalize(CharacterNameG(agent)) + " is inside the grating.\n");
    fi;
corp;
define tp_sewer proc extraDesc2()void:
    ForEachAgent(r_sewer13, showAgent2);
corp;
r_forestByStream@p_rFurtherDesc := extraDesc2$

define tp_sewer p_rGratingSpecial CreateBoolProp()$

define tp_sewer proc barGratingOpen()status:
    thing me;
    bool hidden;
    string name;

    r_sewer13@p_rGratingSpecial := true;
    me := Me();
    hidden := me@p_pHidden;
    if hidden then
	OPrint("The grating opens, then closes again.\n");
    fi;
    name := Capitalize(CharacterNameG(me));
    if Here() = r_sewer13 then
	Print("You pull on the latch mechanism. It is rusty and hard to move "
	    "but you are able to release it and open the grating. You step "
	    "out of the sewer beside the stream and close the grating.\n");
	if not hidden then
	    OPrint(name +
		" opens the grating, goes outside and closes the grating.\n");
	fi;
	LeaveRoomStuff(r_forestByStream, D_EXIT, MOVE_SPECIAL);
	EnterRoomStuff(r_forestByStream, D_ENTER, MOVE_SPECIAL);
	ignore DoRoomAnyEnterChecks(r_forestByStream);
	if not hidden then
	    OPrint(name + " opens the grating and climbs out of the sewer.\n");
	fi;
    else
	Print("You pull on the latch mechanism. It is rusty and hard to move "
	    "but you are able to release it and open the grating. You climb "
	    "into the sewer and the grating bangs shut behind you.\n");
	if not hidden then
	    OPrint(name + " opens the grating and climbs into the sewer."
		" The grating bangs shut.\n");
	fi;
	LeaveRoomStuff(r_sewer13, D_ENTER, MOVE_SPECIAL);
	EnterRoomStuff(r_sewer13, D_EXIT, MOVE_SPECIAL);
	ignore DoRoomAnyEnterChecks(r_sewer13);
	if not hidden then
	    OPrint(name + " opens the grating and climbs into the sewer.\n");
	fi;
    fi;
    if hidden then
	OPrint("The grating opens, then closes again.\n");
    fi;
    r_sewer13@p_rGratingSpecial := false;
    succeed
corp;
o_gratingLatch@p_oOpenChecker := barGratingOpen$
o_gratingLatch@p_oPullChecker := barGratingOpen$
define tp_sewer proc doBarGratingOpen()void:
    ignore barGratingOpen();
corp;
o_gratingLatch@p_oActWord := "unlatch"$
o_gratingLatch@p_oActAction := doBarGratingOpen$
o_barGrating@p_oActWord := "unlatch"$
o_barGrating@p_oActAction := doBarGratingOpen$

define tp_sewer m_watcher1 CreateThing(nil)$
CreateMachine("", m_watcher1, r_forestByStream, nil)$
define tp_sewer proc watch1(string s)void:
    if not r_sewer13@p_rGratingSpecial and
	SubString(s, 0, 20) ~= "Inside the grating, "
    then
	ABPrint(r_sewer13, nil, nil, "Outside the grating, " + s + "\n");
    fi;
corp;
ignore SetMachineOther(m_watcher1, watch1)$

define tp_sewer m_watcher2 CreateThing(nil)$
CreateMachine("", m_watcher2, r_sewer13, nil)$
define tp_sewer proc watch2(string s)void:
    if not r_sewer13@p_rGratingSpecial and
	SubString(s, 0, 21) ~= "Outside the grating, "
    then
	ABPrint(r_forestByStream, nil, nil, "Inside the grating, " + s + "\n");
    fi;
corp;
ignore SetMachineOther(m_watcher2, watch2)$

unuse tp_sewer
