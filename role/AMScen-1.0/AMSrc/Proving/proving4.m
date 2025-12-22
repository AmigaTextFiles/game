/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * proving4.m - the chasm rooms area.
 */

/* the vertical chimney */

private tp_proving4 CreateTable().
use tp_proving4

define tp_proving4 r_chimneyTop CreateThing(r_provingCave).
SetupRoomP(r_chimneyTop, "at the top of a circular ramp",
    "The ramp slopes steeply but negotiably around a 20 foot diameter "
    "vertical chimney in the stone. The chimney ends not far overhead, but "
    "extends downward out of sight. A narrow passage heads east.").
Connect(r_sewerCaveA2, r_chimneyTop, D_WEST).
Scenery(r_chimneyTop, "chimney;20,foot,diameter,vertical.ramp.passage").
define tp_proving4 proc chimneyDrop(thing th)status:
    thing me, here;
    string name;

    me := Me();
    name := FormatName(th@p_oName);
    if th@p_oCarryer ~= nil and th@p_oCreator = me then
	here := Here();
	ZapObject(th);
	Print("You drop the " + name + " which slides off the ramp and "
	    "disappears down the chimney.\n");
	if not me@p_pHidden and CanSee(here, me) then
	    OPrint(Capitalize(CharacterNameG(me)) +
		AAn(" drops", name) +
		" which slides off the ramp and disappears down the "
		"chimney.\n");
	fi;
	DelElement(me@p_pCarrying, th);
	succeed
    else
	Print("You'd better not drop the " + name + " here!\n");
	fail
    fi
corp;
AddRoomDropChecker(r_chimneyTop, chimneyDrop, false).

define tp_proving4 r_chimneyMiddle CreateThing(r_provingCave).
SetupRoomP(r_chimneyMiddle, "on a ramp in a vertical chimney",
    "The chimney ends just within sight overhead, but extends downward out of "
    "sight. A tunnel heads west.").
Connect(r_chimneyTop, r_chimneyMiddle, D_DOWN).
Scenery(r_chimneyMiddle, "chimney;vertical.ramp.tunnel").
AddRoomDropChecker(r_chimneyMiddle, chimneyDrop, false).

define tp_proving4 r_chimneyBottom CreateThing(r_provingCave).
SetupRoomP(r_chimneyBottom, "on a ramp in a vertical chimney",
    "The chimney extends up and down out of sight.").
Scenery(r_chimneyBottom, "chimney;vertical.ramp").
AddRoomDropChecker(r_chimneyBottom, chimneyDrop, false).
Connect(r_chimneyMiddle, r_chimneyBottom, D_DOWN).

define tp_proving4 p_pChimneyDepth CreateIntProp().

define tp_proving4 r_chimney CreateThing(r_tunnel).
SetupRoomDP(r_chimney, "on a ramp in a vertical chimney",
    "The chimney extends up and down out of sight.").
Scenery(r_chimney, "chimney;vertical.ramp").
AddRoomDropChecker(r_chimney, chimneyDrop, false).
Connect(r_chimneyBottom, r_chimney, D_DOWN).
UniConnect(r_chimney, r_chimney, D_DOWN).
r_chimney@p_rNoMachines := true.

define tp_proving4 proc chimneyDown()status:
    thing me;

    me := Me();
    me@p_pChimneyDepth := me@p_pChimneyDepth + 1;
    LeaveRoomStuff(r_chimney, D_DOWN, MOVE_SPECIAL);
    EnterRoomStuff(r_chimney, D_UP, MOVE_SPECIAL);
    fail
corp;

AddDownChecker(r_chimneyBottom, chimneyDown, false).
AddDownChecker(r_chimney, chimneyDown, false).

define tp_proving4 proc chimneyUp()status:
    thing me;
    int depth;

    me := Me();
    depth := me@p_pChimneyDepth - 1;
    if depth = 0 then
	me -- p_pChimneyDepth;
	LeaveRoomStuff(r_chimneyBottom, D_UP, MOVE_SPECIAL);
	EnterRoomStuff(r_chimneyBottom, D_DOWN, MOVE_SPECIAL);
	continue
    else
	me@p_pChimneyDepth := depth;
	LeaveRoomStuff(r_chimney, D_UP, MOVE_SPECIAL);
	EnterRoomStuff(r_chimney, D_DOWN, MOVE_SPECIAL);
	fail
    fi
corp;

AddUpChecker(r_chimney, chimneyUp, false).

define tp_proving4 r_tunnelX1 CreateThing(r_provingCave).
SetupRoomP(r_tunnelX1, "in an east-west tunnel", "").
Connect(r_chimneyMiddle, r_tunnelX1, D_WEST).

define tp_proving4 r_tunnelX2 CreateThing(r_provingCave).
SetupRoomP(r_tunnelX2, "in an east-west tunnel",
    "There is a faint greenish light coming from the west.").
Connect(r_tunnelX1, r_tunnelX2, D_WEST).

define tp_proving4 r_tunnelX3 CreateThing(r_provingCave).
SetupRoomP(r_tunnelX3, "in an east-west tunnel",
    "There is a steady greenish light coming from the west.").
Connect(r_tunnelX2, r_tunnelX3, D_WEST).

/* the chasm area */

define tp_proving4 o_chasm CreateThing(nil).
FakeObject(o_chasm, nil, "chasm;deep",
    "The chasm is a deep crack in the earth. It is so deep that you cannot "
    "see the bottom, only blackness. The chasm is far too wide to jump "
    "across.").

define tp_proving4 PR_CHASM1_ID NextEffectId().
define tp_proving4 proc drawChasm1()void:

    if not KnowsEffect(nil, PR_CHASM1_ID) then
	DefineEffect(nil, PR_CHASM1_ID);
	GSetImage(nil, "Proving/chasm1");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 159, 65);
	    GRDraw(nil, -79, 0);
	    GRDraw(nil, -80, 10);
	    GRDraw(nil, 0, -30);
	    GRDraw(nil, 70, -10);
	    GRDraw(nil, 5, -35);
	    GRDraw(nil, 10, 0);
	    GRDraw(nil, 5, 35);
	    GRDraw(nil, 65, 0);
	    GRDraw(nil, 0, 21);
	    GRDraw(nil, 4, 0);
	    GPolygonEnd(nil);

	    GSetPen(nil, C_BLACK);
	    GPolygonStart(nil);
	    GAMove(nil, 155, 55);
	    GRDraw(nil, -75, 0);
	    GRDraw(nil, -80, 10);
	    GRDraw(nil, 0, -10);
	    GRDraw(nil, 80, -10);
	    GRDraw(nil, 75, 0);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHASM1_ID);
corp;

define tp_proving4 CHASM1_MAP_GROUP NextMapGroup().

define tp_proving4 r_chasmModel1 CreateThing(r_tunnel).
r_chasmModel1@p_rName := "on a ledge overlooking a chasm".
r_chasmModel1@p_rName1 := "Chasm".
r_chasmModel1@p_MapGroup := CHASM1_MAP_GROUP.
r_chasmModel1@p_rDrawAction := drawChasm1.
r_chasmModel1@p_rEnterRoomDraw := EnterRoomDraw.
r_chasmModel1@p_rLeaveRoomDraw := LeaveRoomDraw.
Scenery(r_chasmModel1, "minerals;glowing.ledge.glow;green").
monsterSet4(r_chasmModel1).
SetThingStatus(r_chasmModel1, ts_readonly).

define tp_proving4 proc makeChasm1(string desc; int x, y)thing:
    thing chasm;

    chasm := CreateThing(r_chasmModel1);
    if desc ~= "" then
	chasm@p_rDesc := desc;
    fi;
    chasm@p_rContents := CreateThingList();
    chasm@p_rExits := CreateIntList();
    chasm@p_rCursorX := x;
    chasm@p_rCursorY := y;
    AddTail(chasm@p_rContents, o_chasm);
    SetThingStatus(chasm, ts_wizard);
    chasm
corp;

define tp_proving4 r_chasm1 makeChasm1(
    "You are at the east end of a large, narrow cave which is dominated by a "
    "deep chasm running down the center. Glowing minerals in the ceiling of "
    "the cave provide ample light. Narrow ledges on both sides of the chasm "
    "give room for passage. You are on the south side of the chasm and there "
    "is no visible way to get to the north side. The ledge continues to the "
    "west, and a tunnel heads east.", 151, 57).
Connect(r_tunnelX3, r_chasm1, D_WEST).
Connect(r_tunnelX3, r_chasm1, D_EXIT).
Scenery(r_chasm1, "tunnel").

define tp_proving4 r_chasm2 makeChasm1(
    "The cave bends slightly here, with the west end angling slightly to the "
    "south. Across the chasm, you can see a deep crack leading north from the "
    "ledge on that side.", 80, 57).
Connect(r_chasm1, r_chasm2, D_WEST).
Scenery(r_chasm2, "crack;deep").

define tp_proving4 r_chasm3 makeChasm1("", 3, 67).
Connect(r_chasm2, r_chasm3, D_WEST).

define tp_proving4 r_chasm4 makeChasm1(
    "The ledge on this side of the chasm comes to an end here.", 148, 37).

define tp_proving4 r_chasm5 makeChasm1(
    "A deep crack heads north from here.", 77, 37).
Connect(r_chasm4, r_chasm5, D_WEST).
Scenery(r_chasm5, "crack;deep").

define tp_proving r_chasm6 makeChasm1(
    "The crack comes to an end here in a solid rock wall. There is a sturdy "
    "door in the rock, however.", 77, 1).
r_chasm6@p_rName := "deep in the crack".
Connect(r_chasm5, r_chasm6, D_NORTH).
Scenery(r_chasm6,
    "crack;deep.wall;solid,rock.beam;massive,wooden.strap;thick,iron").
r_chasm6@p_rHintString := "The key is kept a fair ways away from here.".

define tp_proving4 r_chasm7 makeChasm1("", 3, 46).
Connect(r_chasm5, r_chasm7, D_WEST).

define tp_proving4 PR_CHASM2_ID NextEffectId().
define tp_proving4 proc drawChasm2()void:

    if not KnowsEffect(nil, PR_CHASM2_ID) then
	DefineEffect(nil, PR_CHASM2_ID);
	GSetImage(nil, "Proving/chasm2");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 159, 75);
	    GRDraw(nil, -79, 10);
	    GRDraw(nil, -80, 0);
	    GRDraw(nil, 0, -9);
	    GRDraw(nil, 5, 0);
	    GRDraw(nil, 0, -21);
	    GRDraw(nil, 75, 0);
	    GRDraw(nil, 79, -10);
	    GPolygonEnd(nil);

	    GSetPen(nil, C_BLACK);
	    GPolygonStart(nil);
	    GAMove(nil, 159, 65);
	    GRDraw(nil, -79, 10);
	    GRDraw(nil, -80, 0);
	    GRDraw(nil, 0, -10);
	    GRDraw(nil, 80, 0);
	    GRDraw(nil, 79, -10);
	    GPolygonEnd(nil);

	    GSetPen(nil, C_MEDIUM_BROWN);
	    GAMove(nil, 35, 63);
	    GRectangle(nil, 10, 14, false);
	    GSetPen(nil, C_BROWN);
	    GRMove(nil, 1, 0);
	    GRectangle(nil, 8, 14, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHASM2_ID);
corp;

define tp_proving4 CHASM2_MAP_GROUP NextMapGroup().

define tp_proving4 r_chasmModel2 CreateThing(r_tunnel).
r_chasmModel2@p_rName := "on a ledge overlooking a chasm".
r_chasmModel2@p_rName1 := "Chasm".
r_chasmModel2@p_MapGroup := CHASM2_MAP_GROUP.
r_chasmModel2@p_rDrawAction := drawChasm2.
r_chasmModel2@p_rEnterRoomDraw := EnterRoomDraw.
r_chasmModel2@p_rLeaveRoomDraw := LeaveRoomDraw.
Scenery(r_chasmModel2, "minerals;glowing.ledge.glow;green").
monsterSet4(r_chasmModel2).
SetThingStatus(r_chasmModel2, ts_readonly).

define tp_proving4 proc makeChasm2(string desc; int x, y)thing:
    thing chasm;

    chasm := CreateThing(r_chasmModel2);
    if desc ~= "" then
	chasm@p_rDesc := desc;
    fi;
    chasm@p_rContents := CreateThingList();
    chasm@p_rExits := CreateIntList();
    chasm@p_rCursorX := x;
    chasm@p_rCursorY := y;
    AddTail(chasm@p_rContents, o_chasm);
    SetThingStatus(chasm, ts_wizard);
    chasm
corp;

define tp_proving4 r_chasm8 makeChasm2("", 153, 68).
Connect(r_chasm3, r_chasm8, D_WEST).

define tp_proving4 r_chasm9 makeChasm2(
    "The cave takes another slight bend here, with the west end now going "
    "pretty well straight west. You can see a bridge over the chasm just to "
    "the west of here.", 79, 77).
Connect(r_chasm8, r_chasm9, D_WEST).
Scenery(r_chasm9, "bridge").

define tp_proving4 r_chasm10 makeChasm2(
    "There is a bridge heading north across the chasm here. There are also "
    "a lot of bones lying around here, some of them quite fresh, and some of "
    "them quite large.", 37, 78).
Connect(r_chasm9, r_chasm10, D_WEST).
Scenery(r_chasm10, "bones;quite,large,fresh").

define tp_proving4 o_bridge CreateThing(nil).
FakeObject(o_bridge, r_chasm10, "bridge;wooden",
    "The bridge is built from wood and is fairly old, but it looks like it "
    "should be able to support your weight.").
o_bridge@p_Image := "Proving/chasmBridge".

define tp_proving4 r_chasm11 makeChasm2(
    "The ledge on the other side of the chasm ends at this point in the cave, "
    "but the one on this side leads right up to a tunnel opening. You can "
    "smell some bad smells coming out of the tunnel.", 2, 78).
Connect(r_chasm10, r_chasm11, D_WEST).
Scenery(r_chasm11, "tunnel.opening;tunnel").
r_chasm11@p_oSmellString :=
    "The rank odour is quite strong. One component seems to be rotten meat, "
    "and another unwashed bodies.".

define tp_proving4 r_chasm12 makeChasm2("", 151, 47).
Connect(r_chasm7, r_chasm12, D_WEST).

define tp_proving4 r_chasm13 makeChasm2(
    "The cave takes another slight bend here, with the west end now going "
    "pretty well straight west. You can see a bridge over the chasm just to "
    "the west of here.", 80, 56).
Connect(r_chasm12, r_chasm13, D_WEST).
Scenery(r_chasm13, "bridge").

define tp_proving4 r_chasm14 makeChasm2(
    "There is a bridge heading south across the chasm here. There are also "
    "a lot of bones lying around here, some of them quite fresh, and some of "
    "them quite large.", 37, 56).
Connect(r_chasm13, r_chasm14, D_WEST).
AddTail(r_chasm14@p_rContents, o_bridge).
Scenery(r_chasm14, "bones;quite,large,fresh,old").

define tp_proving4 r_chasm15 makeChasm2(
    "The ledge along this side of the chasm comes to an end here. You cannot "
    "go any further to the west.", 7, 56).
Connect(r_chasm14, r_chasm15, D_WEST).

define tp_proving4 r_bridge makeChasm2("", 37, 67).
r_bridge@p_rName := "on a bridge over a chasm".
RoomName(r_bridge, "Bridge", "").
Connect(r_chasm10, r_bridge, D_NORTH).
Connect(r_chasm14, r_bridge, D_SOUTH).
AddTail(r_bridge@p_rContents, o_bridge).

ignore DeleteSymbol(tp_proving4, "makeChasm2").
ignore DeleteSymbol(tp_proving4, "makeChasm1").

/* here for a while is the stuff for the guardian troll */

define tp_proving4 TROLL_HITS 39.
define tp_proving4 p_mTrollActive CreateBoolProp().
define tp_proving4 p_pPlayerTryCross CreateBoolProp().

define tp_proving4 proc trollBridgeStepOn()status:
    Me()@p_pPlayerTryCross := true;
    continue
corp;
AddNorthChecker(r_chasm10, trollBridgeStepOn, false).

define tp_proving4 proc guardianTrollStep()void:
    int hits;
    thing me, target;

    /* m_guardianTroll not defined yet! */
    me := Me();
    hits := me@p_pHitNow + 5;
    if hits > TROLL_HITS then
	hits := TROLL_HITS;
    fi;
    me@p_pHitNow := hits;
    if me@p_mTrollActive then
	target := me@p_pCurrentTarget;
	if target ~= nil then
	    if AgentLocation(target) ~= r_bridge then
		me -- p_pCurrentTarget;
		if FindAgentWithFlag(r_bridge, p_pStandard) = nil then
		    /* nobody here - go back to bed */
		    me@p_mTrollActive := false;
		    SetAgentLocation(me, nil);
		fi;
	    else
		if Random(2) = 0 then
		    ignore MonsterHitPlayer(me, target, r_bridge);
		else
		    MonsterAction(me);
		fi;
	    fi;
	else
	    if FindAgentWithFlag(r_bridge, p_pStandard) ~= nil then
		/* someone here - dance for them */
		MonsterAction(me);
	    fi;
	fi;
    fi;
    MonsterReschedule(me);
corp;

define tp_proving4 proc guardianTrollKill(thing thePlayer, troll)bool:

    Print("You have defeated the guardian troll! Nursing its wounds, it "
	"climbs back under the bridge. You quickly take the opportunity to "
	"dash the rest of the way across the bridge.\n");
    OPrint(Capitalize(Me()@p_pName) + " has defeated the guardian troll!. "
	"Nursing its wounds, it climbs back unde the bridge.\n");
    troll@p_mTrollActive := false;
    troll -- p_pCurrentTarget;
    ignore ForceAction(troll, DoUnShowIcon);
    SetAgentLocation(troll, nil);
    thePlayer -- p_pPlayerTryCross;
    ignore EnterRoom(r_chasm14, D_NORTH, MOVE_NORMAL);
    false
corp;

/* want the PLAYER to cross the bridge, not the troll! */

define tp_proving4 proc doCrossBridge()status:
    ignore EnterRoom(r_chasm14, D_NORTH, MOVE_NORMAL);
    continue
corp;

/* called by ForceAction, so done by troll */
define tp_proving4 proc guardianTrollGivePre()status:
    thing it, trueMe;
    string name;

    trueMe := TrueMe();
    it := It();
    name := FormatName(it@p_oName);
    if it@p_oCarryer ~= nil and it@p_oCreator = trueMe then
	if MatchName(it@p_oName, "apple") ~= -1 then
	    /* troll is not too bright, any apple-ish thing is good enough! */
	    if trueMe@p_pPlayerTryCross then
		SPrint(trueMe,
		    "The troll sniffs the apple and looks happy (or at "
		    "least as happy as a troll can look!). With an expression "
		    "something like delight, it takes a bite of the apple. "
		    "Seeing that it is preoccupied, you make a dash for the "
		    "far side. The troll notices and tries to stop you, "
		    "but you are able to duck under its arm and cross to "
		    "the other side. It turns and glares at you, but does "
		    "not pursue you.\n");
		ABPrint(r_bridge, trueMe, trueMe,
		    Capitalize(trueMe@p_pName) +
		    " somehow gets past the troll and is "
		    "able to cross to the other side.\n");
		trueMe -- p_pPlayerTryCross;
		ignore ForceAction(trueMe, doCrossBridge);
	    else
		SPrint(trueMe,
		  "The troll sniffs the apple and happily gobbles it down!\n");
	    fi;
	else
	    SPrint(trueMe,
		"The troll sniffs the " + name + " but isn't impressed. "
		"It tosses the " + name + " over the side of the bridge.\n");
	    ABPrint(r_bridge, trueMe, trueMe,
		"The troll tosses something over the side of the bridge.\n");
	fi;
	ZapObject(it);
	DelElement(trueMe@p_pCarrying, it);
	succeed
    else
	SPrint(trueMe,
	    "The troll sniffs the " + name + " but isn't impressed. " +
	    "It tosses the " + name + " back to you.\n");
	fail
    fi
corp;

define tp_proving4 m_guardianTroll CreateMonsterModel("troll;guardian",
    "The guardian troll is quite large, standing about 7 feet tall and nearly "
    "that much around. It has small beady eyes, a piglike snout and huge "
    "tusks. Its arms are like tree-trunks, and its fingers have knifelike "
    "claws. The guardian troll isn't wearing any armour, but its scales and "
    "skin look thick enough to ward off all but the best sword thrusts.",
    nil, guardianTrollStep, TROLL_HITS, 4, 6, 7, 18, 0).
AddModelAction(m_guardianTroll, "bellows").
AddModelAction(m_guardianTroll, "raises its fists and roars").
AddModelAction(m_guardianTroll, "rumbles ominously").
AddModelAction(m_guardianTroll, "glares threateningly").
AddModelAction(m_guardianTroll, "grins nastily").
AddModelAction(m_guardianTroll, "beckons encouragingly").
AddModelAction(m_guardianTroll, "rubs its hands expectantly").
m_guardianTroll@p_mTrollActive := false.
m_guardianTroll@p_mKillAction := guardianTrollKill.
m_guardianTroll@p_pGivePre := guardianTrollGivePre.
m_guardianTroll@p_Image := "Characters/guardianTroll".
SetupMachine(m_guardianTroll).
CreateMachine("troll;guardian", m_guardianTroll, nil, DummyMonsterInit).
ignore SetMachineActive(m_guardianTroll, guardianTrollStep).

define tp_proving4 proc trollBridgeCross()status:

    if Me()@p_pPlayerTryCross then
	if m_guardianTroll@p_mTrollActive then
	    Print("The guardian troll blocks your path.\n");
	else
	    m_guardianTroll@p_mTrollActive := true;
	    Print("As you try to walk the rest of the way across the bridge, "
		"there is a roar from somewhere underneath, and the "
		"guardian troll quickly climbs out and blocks your way "
		"across the bridge.\n");
	    /* could be someone crossing back and standing here */
	    OPrint("There is a roar from underneath the bridge, and the "
		"guardian troll climbs out and confronts " +
		Me()@p_pName + ".\n");
	    SetAgentLocation(m_guardianTroll, r_bridge);
	    ignore ForceAction(m_guardianTroll, DoShowIcon);
	fi;
	fail
    else
	if m_guardianTroll@p_mTrollActive then
	    Print("Luckily, the guardian troll is occupied and doesn't "
		"notice you messing around behind its back!\n");
	fi;
	continue
    fi
corp;
AddNorthChecker(r_bridge, trollBridgeCross, false).

define tp_proving4 proc bridgeClimb()void:
    if m_guardianTroll@p_mTrollActive then
	Print("There is no way the troll is going to let you climb down into "
	    "its hidey-hole!\n");
    else
	Print("Climbing down into the hidey-hole of a troll is not a "
	    "good idea!\n");
    fi;
corp;
AddSpecialCommand(r_bridge, "climb", bridgeClimb).

define tp_proving4 r_trollRoom CreateThing(r_provingCave).
SetupRoomP(r_trollRoom, "in a squalid cave",
    "This cave is quite large and is clearly home to a large number of "
    "trolls. There are piles of bones and half-eaten meat everywhere, along "
    "with other refuse not to be mentioned. The exit to the east admits a "
    "steady green glow.").
r_trollRoom@p_rDark := false.	/* override r_provingCave */
Connect(r_chasm11, r_trollRoom, D_WEST).
Connect(r_chasm11, r_trollRoom, D_ENTER).
Scenery(r_trollRoom,
  "cave.bone;piles,pile,of.pile.meat;half-eaten,half,eaten.refuse.glow;green").
r_trollRoom@p_oSmellString := "WHEW! The stink is indescribable!".
r_trollRoom@p_rLastVisit := Time().
r_trollRoom@p_Image := "Proving/trollRoom".

define tp_proving4 proc trollEnter(thing room)void:
    thing me;
    int now, i;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_trollRoom@p_rLastVisit >= 300 then
	r_trollRoom@p_rLastVisit := now;
	for i from 0 upto Random(4) + 3 do
	    ignore CreateMonster(me, m_largeTroll, r_trollRoom);
	od;
    fi;
corp;
AddAnyEnterAction(r_trollRoom, trollEnter, false).

unuse tp_proving4
