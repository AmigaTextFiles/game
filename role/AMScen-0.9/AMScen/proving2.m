/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * proving2.m - deep sewer level of the proving grounds.
 */

private tp_proving2 CreateTable().
use tp_proving2

define tp_proving2 r_sewerShaft2 CreateThing(r_provingTunnelD).
SetupRoom(r_sewerShaft2, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb up here, and a "
    "small opening heads south.").
Connect(r_sewerShaft1, r_sewerShaft2, D_DOWN).
Scenery(r_sewerShaft2, "wrung;metal.opening;small").

define tp_proving2 r_sewerShaft4 CreateThing(r_provingTunnelD).
SetupRoom(r_sewerShaft4, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb up here, and a "
    "small opening heads north.").
Connect(r_sewerShaft3, r_sewerShaft4, D_DOWN).
Scenery(r_sewerShaft4, "wrung;metal.opening;small").

define tp_proving2 r_sewerChamber1 CreateThing(r_provingTunnelD).
SetupRoom(r_sewerChamber1, "in a large chamber",
    "This chamber is quite large, but fairly low, and the ceiling is held "
    "up by numerous stone pillars. You can see small openings in the "
    "north, south, east and west walls.").
Connect(r_sewerShaft2, r_sewerChamber1, D_SOUTH).
Connect(r_sewerShaft4, r_sewerChamber1, D_NORTH).
AutoGraphics(r_sewerChamber1, AutoTunnelChamber).
Scenery(r_sewerChamber1, "ceiling.pillar;numerous,stone.opening;small.wall").

define tp_proving2 r_sewerTunnel1 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel1, "in a low east-west tunnel", "").
Connect(r_sewerChamber1, r_sewerTunnel1, D_WEST).

define tp_proving2 r_sewerTunnel2 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel2, "in a low east-west tunnel", "").
Connect(r_sewerTunnel1, r_sewerTunnel2, D_WEST).

define tp_proving2 r_sewerTunnel3 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel3, "in a low east-west tunnel", "").
Connect(r_sewerTunnel2, r_sewerTunnel3, D_WEST).

define tp_proving2 r_sewerTunnel4 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel4, "in a low north-south-east tunnel Tee", "").
Connect(r_sewerTunnel3, r_sewerTunnel4, D_WEST).

define tp_proving2 r_sewerTunnel5 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel5, "in a low north-south tunnel", "").
Connect(r_sewerTunnel4, r_sewerTunnel5, D_NORTH).

define tp_proving2 r_sewerTunnel6 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel6, "at a south and east corner in the low tunnel","").
Connect(r_sewerTunnel5, r_sewerTunnel6, D_NORTH).

define tp_proving2 r_sewerTunnel7 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel7, "at a south-east-west Tee in the low tunnel", "").
Connect(r_sewerTunnel6, r_sewerTunnel7, D_EAST).

define tp_proving2 r_sewerTunnel8 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel8, "at a south-east-west Tee in the low tunnel","").
Connect(r_sewerTunnel7, r_sewerTunnel8, D_EAST).

define tp_proving2 r_sewerTunnel8_5 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel8_5, "at a dead-end in the low tunnel",
    "The tunnel ends here in a blank wall. You can only go to the north.").
Connect(r_sewerTunnel8, r_sewerTunnel8_5, D_SOUTH).
Scenery(r_sewerTunnel8_5, "wall;blank").

define tp_proving r_sewerChamber2 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerChamber2, "in a large chamber",
    "The ceiling of this chamber is of medium height, and is held up by "
    "numerous stone columns. There is a small opening in the north wall, and "
    "a dark hole in the floor near a back corner.").
Connect(r_sewerTunnel7, r_sewerChamber2, D_SOUTH).
AutoGraphics(r_sewerChamber2, AutoTunnelChamber).
r_sewerChamber2@p_rDownMessage := "You drop through the small hole.".
r_sewerChamber2@p_rDownOMessage := "drops through the small hole.".
Scenery(r_sewerChamber2,
	"ceiling,floor."
	"column;numerous,stone."
	"opening;small."
	"wall;back,north."
	"hole;dark."
	"corner;back").
define tp_proving2 o_goblinDagger CreateThing(nil).
o_goblinDagger@p_oName := "dagger;goblin".
o_goblinDagger@p_oDesc :=
    "The goblin dagger has some unreadable runes scratched into the hilt, "
    "and is of pretty shoddy workmanship. It is quite serviceable, however.".
o_goblinDagger@p_oHome := r_lostAndFound.
SetupWeapon(o_goblinDagger, 0, 0, 0, 0, 0, 5, 9).
SetThingStatus(o_goblinDagger, ts_readonly).
define tp_proving2 proc daggerQuestDesc()string:
    "Bring me a goblin dagger."
corp;
define tp_proving2 proc daggerQuestGive()status:
    thing dagger;

    dagger := It();
    if Parent(dagger) = o_goblinDagger then
	GiveToQuestor("goblin dagger");
	QuestThing@p_QuestActive := daggerQuestGive;
	succeed
    elif dagger@p_oName = "dagger;goblin" then
	GiveToQuestor("goblin dagger");
	QuestThing@p_QuestActive := daggerQuestGive;
	SPrint(TrueMe(), "Questor is not impressed.\n");
	fail
    else
	continue
    fi
corp;
define tp_proving2 proc daggerQuestHint()string:
    "Don't be afraid of the dark. Look beneath the dirty places."
corp;
QuestGive("Dagger", daggerQuestDesc, daggerQuestGive, daggerQuestHint).
r_sewerChamber2@p_rLastVisit := 0.
define tp_proving2 proc chamber2Enter(thing room)void:
    thing me, monster, dagger;
    int now;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerChamber2@p_rLastVisit >= 300 then
	r_sewerChamber2@p_rLastVisit := now;
	monster := CreateMonster(me, m_goblin, r_sewerChamber2);
	/* This, unfortunately, is not really an adequate test. It is possible
	   to get more than one dagger if the goblin with the dagger is killed
	   outside this chamber, and the dagger is dropped there, but not
	   picked up by the player. I saw it happen. */
	if not DoneQuest(daggerQuestGive) and
	    CarryingChild(me, o_goblinDagger) = nil and
	    ChildHere(r_sewerChamber2, o_goblinDagger) = nil
	then
	    dagger := CreateThing(o_goblinDagger);
	    SetThingStatus(dagger, ts_public);
	    GiveThing(dagger, SysAdmin);
	    dagger@p_oCreator := me;
	    dagger@p_oCarryer := monster;
	    AddTail(monster@p_pCarrying, dagger);
	    monster@p_pWeapon := dagger;
	fi;
	ignore CreateMonster(me, m_goblin, r_sewerChamber2);
    fi;
corp;
AddAnyEnterAction(r_sewerChamber2, chamber2Enter, false).

define tp_proving2 r_sewerTunnel9 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel9, "at a north and west corner in the low tunnel","").
Connect(r_sewerTunnel4, r_sewerTunnel9, D_SOUTH).

define tp_proving2 r_sewerTunnel10 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel10,"at a south and east corner in the low tunnel","").
Connect(r_sewerTunnel9, r_sewerTunnel10, D_WEST).

define tp_proving2 r_sewerTunnel10_5 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel10_5, "in a low north-south tunnel", "").
Connect(r_sewerTunnel10, r_sewerTunnel10_5, D_SOUTH).

define tp_proving2 r_sewerTunnel11 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel11, "in a low north-south tunnel", "").
Connect(r_sewerTunnel10_5, r_sewerTunnel11, D_SOUTH).

define tp_proving2 r_sewerTunnel12 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel12,"at a north and east corner in the low tunnel","").
Connect(r_sewerTunnel11, r_sewerTunnel12, D_SOUTH).

define tp_proving2 r_sewerTunnel13 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel13, "in a low east-west tunnel", "").
Connect(r_sewerTunnel12, r_sewerTunnel13, D_EAST).

define tp_proving2 r_sewerTunnel14 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel14,"at a north and west corner in the low tunnel","").
Connect(r_sewerTunnel13, r_sewerTunnel14, D_EAST).

define tp_proving2 r_sewerTunnel15 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel15, "at a south-east-west Tee in the low tunnel", "").
Connect(r_sewerTunnel14, r_sewerTunnel15, D_NORTH).

define tp_proving2 r_sewerChamber3 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerChamber3, "in a large chamber",
    "This high-ceilinged chamber shows signs of animal habitation. The floor "
    "is littered with twigs, grass, bones, and other less pleasant things. "
    "The stone pillars supporting the dimly visible ceiling are rank with "
    "oozing slime. A small passage leads out of the east wall.").
Connect(r_sewerTunnel15, r_sewerChamber3, D_WEST).
AutoGraphics(r_sewerChamber3, AutoTunnelChamber).
Scenery(r_sewerChamber3,
    "ceiling."
    "pillar;numerous,stone."
    "passage;small."
    "wall."
    "sign."
    "floor."
    "slime;oozing."
    "litter."
    "twig,grass,bone,thing;less,pleasant").
r_sewerChamber3@p_rLastVisit := 0.
define tp_proving2 proc chamber3Enter(thing room)void:
    thing me;
    int i, now;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerChamber3@p_rLastVisit >= 300 then
	r_sewerChamber3@p_rLastVisit := now;
	for i from 0 upto Random(5) + 4 do
	    ignore CreateMonster(me, m_largeRat, r_sewerChamber3);
	od;
    fi;
corp;
AddAnyEnterAction(r_sewerChamber3, chamber3Enter, false).

define tp_proving2 r_sewerTunnel16 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel16, "in a low east-west tunnel", "").
Connect(r_sewerTunnel15, r_sewerTunnel16, D_EAST).

define tp_proving2 r_sewerTunnel17 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel17, "in a low east-west tunnel", "").
Connect(r_sewerTunnel16, r_sewerTunnel17, D_EAST).

define tp_proving2 r_sewerTunnel18 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel18, "in a low east-west tunnel", "").
Connect(r_sewerTunnel17, r_sewerTunnel18, D_EAST).

define tp_proving2 r_sewerTunnel19 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel19, "in a low east-west tunnel", "").
Connect(r_sewerTunnel18, r_sewerTunnel19, D_EAST).

define tp_proving2 r_sewerTunnel20 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel20,"at a north and west corner in the low tunnel","").
Connect(r_sewerTunnel19, r_sewerTunnel20, D_EAST).

define tp_proving2 r_sewerTunnel21 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel21,"at a south and west corner in the low tunnel","").
Connect(r_sewerTunnel20, r_sewerTunnel21, D_NORTH).

define tp_proving2 r_sewerTunnel22 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel22, "at a north-east-west Tee in the low tunnel", "").
Connect(r_sewerTunnel21, r_sewerTunnel22, D_WEST).

define tp_proving2 r_sewerTunnel23 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel23, "at an end in the low tunnel",
    "You can go to the east or down a ladder.").
Connect(r_sewerTunnel22, r_sewerTunnel23, D_WEST).
Scenery(r_sewerTunnel23, "ladder").

define tp_proving2 r_sewerTunnel24 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel24, "in a low north-south tunnel", "").
Connect(r_sewerTunnel22, r_sewerTunnel24, D_NORTH).

define tp_proving2 r_sewerTunnel25 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel25, "at a south and west corner in a low tunnel", "").
Connect(r_sewerTunnel24, r_sewerTunnel25, D_NORTH).
Connect(r_sewerTunnel25, r_sewerChamber1, D_WEST).

define tp_proving2 r_sewerTunnel26 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel26, "at an end in a very low tunnel",
    "You can go to the north or up a ladder.").
Connect(r_sewerTunnel23, r_sewerTunnel26, D_DOWN).
Scenery(r_sewerTunnel26, "ladder").

define tp_proving2 r_sewerTunnel27 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel27, "in a very low north-south tunnel",
    "There is a crack in the west wall. You can hear noises coming from it.").
Connect(r_sewerTunnel26, r_sewerTunnel27, D_NORTH).
Scenery(r_sewerTunnel27, "crack").
r_sewerTunnel27@p_oListenString :=
    "You can't really identify the noises, but there seems to be two parts "
    "to them - one soft and fairly continuous, and the other slightly louder "
    "and sporadic.".
r_sewerTunnel27@p_rWestEMessage := "comes out of the crack.".
r_sewerTunnel27@p_rEnterMessage := "comes out of the crack.".

define tp_proving2 r_sewerTunnel28 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel28, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel27, r_sewerTunnel28, D_NORTH).

define tp_proving2 r_sewerTunnel29 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel29, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel28, r_sewerTunnel29, D_NORTH).

define tp_proving2 r_sewerTunnel30 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel30, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel29, r_sewerTunnel30, D_NORTH).

define tp_proving2 r_sewerTunnel31 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel31, "at an end in the very low tunnel",
    "You can go to the south or up a ladder.").
Connect(r_sewerTunnel30, r_sewerTunnel31, D_NORTH).
Scenery(r_sewerTunnel31, "ladder").

define tp_proving2 r_sewerTunnel32 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel32, "at an end in the low tunnel",
    "You can go to the south or down a ladder.").
Connect(r_sewerTunnel31, r_sewerTunnel32, D_UP).
Scenery(r_sewerTunnel32, "ladder").

define tp_proving2 r_sewerTunnel33 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel33, "at a north-east-west Tee in the low tunnel", "").
Connect(r_sewerTunnel32, r_sewerTunnel33, D_SOUTH).

define tp_proving2 r_sewerTunnel34 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel34, "in a low east-west tunnel", "").
Connect(r_sewerTunnel33, r_sewerTunnel34, D_WEST).
Connect(r_sewerTunnel8, r_sewerTunnel34, D_EAST).

define tp_proving2 r_sewerTunnel35 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel35, "in a low east-west tunnel", "").
Connect(r_sewerTunnel33, r_sewerTunnel35, D_EAST).

define tp_proving2 r_sewerTunnel36 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel36, "at the end of a crack",
    "There is a hole in floor here, from which the noises are coming. It "
    "sounds like a lot of things quietly rubbing against each other, along "
    "with an occasional hissing.").
HUniConnect(r_sewerTunnel27, r_sewerTunnel36, D_WEST).
HUniConnect(r_sewerTunnel27, r_sewerTunnel36, D_ENTER).
UniConnect(r_sewerTunnel36, r_sewerTunnel27, D_EAST).
UniConnect(r_sewerTunnel36, r_sewerTunnel27, D_EXIT).
AutoGraphics(r_sewerTunnel36, AutoPaths).
AutoPens(r_sewerTunnel36, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
Scenery(r_sewerTunnel36, "crack.hole").
r_sewerTunnel36@p_oListenString :=
    "The rubbing noise is quite strange - it comes and goes in intensity, "
    "and seems to consist of many quieter noises. The hissing is infrequent "
    "and also varies from soft to loud.".
r_sewerTunnel36@p_rDownEMessage := "crawls out of the pit.".
r_sewerTunnel36@p_rExitEMessage := "crawls out of the pit.".

define tp_proving2 r_sewerChamber4 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerChamber4, "in a snake pit",
    "The pit is littered with bones and small bits of eggshell.").
Connect(r_sewerTunnel36, r_sewerChamber4, D_DOWN).
UniConnect(r_sewerChamber4, r_sewerTunnel36, D_EXIT).
AutoGraphics(r_sewerChamber4, AutoTunnelChamber).
Scenery(r_sewerChamber4, "bone.shell;egg.eggshell.bit;shell,small,bits,of").
r_sewerChamber4@p_rLastVisit := 0.
define tp_proving2 proc chamber4Enter(thing room)void:
    thing me, monster;
    int i, now;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerChamber4@p_rLastVisit >= 300 then
	r_sewerChamber4@p_rLastVisit := now;
	for i from 0 upto Random(10) + 10 do
	    monster :=
		case Random(20)
		incase 0:
		    m_hugeSnake
		incase 1:
		incase 2:
		incase 3:
		    m_largeSnake
		default:
		    m_snake
		esac;
	    ignore CreateMonster(me, monster, r_sewerChamber4);
	od;
	if FindName(me@p_pCarrying, p_oName, "armour") = fail and
	    FindName(me@p_pCarrying, p_oName, "mail") = fail
	then
	    DepositClone(r_sewerChamber4, o_leatherArmour);
	fi;
    fi;
corp;
AddAnyEnterAction(r_sewerChamber4, chamber4Enter, false).

define tp_proving2 r_sewerTunnel37 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel37, "in a low east-west tunnel", "").
Connect(r_sewerTunnel35, r_sewerTunnel37, D_EAST).

define tp_proving2 r_sewerTunnel38 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel38, "in a low east-west tunnel", "").
Connect(r_sewerTunnel37, r_sewerTunnel38, D_EAST).

define tp_proving2 PR_CHAMBER_ID NextEffectId().
define tp_proving2 proc drawChamber()void:

    if not KnowsEffect(nil, PR_CHAMBER_ID) then
	DefineEffect(nil, PR_CHAMBER_ID);
	GSetImage(nil, "pr_chamber");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 140, 0);
	    GRectangle(nil, 19, 99, true);

	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 139, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 10, 10);
	    GRectangle(nil, 119, 79, true);
	    GAMove(nil, 0, 21);
	    GRectangle(nil, 139, 10, true);
	    GAMove(nil, 0, 45);
	    GRectangle(nil, 139, 10, true);
	    GAMove(nil, 0, 69);
	    GRectangle(nil, 139, 10, true);
	    GAMove(nil, 33, 0);
	    GRectangle(nil, 10, 99, true);
	    GAMove(nil, 66, 0);
	    GRectangle(nil, 10, 99, true);
	    GAMove(nil, 99, 0);
	    GRectangle(nil, 10, 99, true);

	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 38, 33);
	    GRectangle(nil, 63, 34, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER_ID);
corp;

define tp_proving2 CHAMBER_MAP_GROUP NextMapGroup().

define tp_proving2 r_chamberModel CreateThing(r_provingTunnel2).
RoomName(r_chamberModel, "Large", "Chamber").
r_chamberModel@p_MapGroup := CHAMBER_MAP_GROUP.
r_chamberModel@p_rDrawAction := drawChamber.
r_chamberModel@p_rEnterRoomDraw := EnterRoomDraw.
r_chamberModel@p_rLeaveRoomDraw := LeaveRoomDraw.
Scenery(r_chamberModel,
    "chamber;large,rectangular."
    "rock."
    "passage;open."
    "wall;outer."
    "chamber;middle,of,the."
    "structure;low,building-like,building,like."
    "window;small,horizontal").
SetThingStatus(r_chamberModel, ts_readonly).

define tp_proving2 proc makeChamber(int x, y; string name)thing:
    thing chamber;

    chamber := CreateThing(r_chamberModel);
    chamber@p_rName := name;
    chamber@p_rContents := CreateThingList();
    chamber@p_rExits := CreateIntList();
    chamber@p_rCursorX := x;
    chamber@p_rCursorY := y;
    SetThingStatus(chamber, ts_wizard);
    chamber
corp;

define tp_proving2 r_chamberW makeChamber(19, 47,
    "on the west side of the chamber").
r_chamberW@p_rDesc :=
    "This is a large rectangular chamber hewn from the rock. There are open "
    "passages on all of the outer walls. The middle of the chamber is filled "
    "with a low building-like structure which has small horizontal windows "
    "but no visible door.".
Connect(r_sewerTunnel38, r_chamberW, D_EAST).

define tp_proving2 r_chamberNW makeChamber(34, 22,
    "in the north-west corner of the chamber").
Connect(r_chamberW, r_chamberNW, D_NORTH).

define tp_proving2 r_chamberN makeChamber(68, 18,
    "on the north side of the chamber").
Connect(r_chamberNW, r_chamberN, D_EAST).

define tp_proving2 r_chamberNE makeChamber(102, 22,
    "in the north-east corner of the chamber").
Connect(r_chamberN, r_chamberNE, D_EAST).

define tp_proving2 r_chamberE makeChamber(113, 47,
    "on the east side of the chamber").
Connect(r_chamberNE, r_chamberE, D_SOUTH).

define tp_proving2 r_chamberSE makeChamber(102, 71,
    "in the south-east corner of the chamber").
Connect(r_chamberE, r_chamberSE, D_SOUTH).

define tp_proving2 r_chamberS makeChamber(68, 75,
    "on the south side of the chamber").
Connect(r_chamberSE, r_chamberS, D_WEST).

define tp_proving2 r_chamberSW makeChamber(34, 71,
    "in the south-west corner of the chamber").
Connect(r_chamberS, r_chamberSW, D_WEST).
Connect(r_chamberW, r_chamberSW, D_SOUTH).

define tp_proving2 r_cell CreateThing(r_indoors).
r_cell@p_rName := "in a small featureless room".
r_cell@p_rDesc := "There is a small wooden cot against one wall.".
AutoGraphics(r_cell, AutoOpenRoom).
AutoPens(r_cell, C_DARK_GREY, C_LIGHT_GREY, C_LIGHT_GREY, 0).
Scenery(r_cell, "cot;small,wooden").
SetThingStatus(r_cell, ts_readonly).

define tp_proving2 proc makeCell(thing chamber; int dir)thing:
    thing cell;

    cell := CreateThing(r_cell);
    cell@p_rContents := CreateThingList();
    cell@p_rExits := CreateIntList();
    Connect(chamber, cell, dir);
    UniConnect(cell, chamber, D_EXIT);
    SetThingStatus(cell, ts_wizard);
    cell
corp;

ignore makeCell(r_chamberNW, D_WEST).
ignore makeCell(r_chamberNW, D_NORTH).
ignore makeCell(r_chamberN, D_NORTH).
ignore makeCell(r_chamberNE, D_NORTH).
ignore makeCell(r_chamberNE, D_EAST).
define tp_proving2 r_cell1 makeCell(r_chamberSE, D_EAST).
r_cell1@p_rDesc :=
    "There is a small wooden cot against one wall, and a small hole in the "
    "floor with a ladder leading down.".
Scenery(r_cell1, "cot;small,wooden.ladder.hole;small").
ignore makeCell(r_chamberSE, D_SOUTH).
ignore makeCell(r_chamberS, D_SOUTH).
ignore makeCell(r_chamberSW, D_SOUTH).
ignore makeCell(r_chamberSW, D_WEST).

define tp_proving2 r_sewerTunnel39 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel39, "at the end of a very low tunnel",
    "You can go to the south or up a ladder.").
Connect(r_cell1, r_sewerTunnel39, D_DOWN).
Scenery(r_sewerTunnel39, "ladder").

define tp_proving2 r_sewerTunnel40 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel40, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel39, r_sewerTunnel40, D_SOUTH).

define tp_proving2 r_sewerTunnel41 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel41, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel40, r_sewerTunnel41, D_SOUTH).

define tp_proving2 r_sewerTunnel42 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel42, "in a crossing of very low tunnels", "").
Connect(r_sewerTunnel41, r_sewerTunnel42, D_SOUTH).

define tp_proving2 r_sewerTunnel43 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel43, "in a very low east-west tunnel", "").
Connect(r_sewerTunnel42, r_sewerTunnel43, D_WEST).

define tp_proving2 r_sewerTunnel44 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel44,
    "in a north and east corner in the very low tunnel", "").
Connect(r_sewerTunnel43, r_sewerTunnel44, D_WEST).

define tp_proving2 r_sewerTunnel45 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel45, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel44, r_sewerTunnel45, D_NORTH).

define tp_proving2 r_sewerTunnel46 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel46, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel45, r_sewerTunnel46, D_NORTH).

define tp_proving2 r_sewerTunnel47 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel47, "at the end of a very low tunnel",
    "You can go to the south or up a ladder.").
Connect(r_sewerTunnel46, r_sewerTunnel47, D_NORTH).
Scenery(r_sewerTunnel47, "ladder").

define tp_proving2 r_sewerBuilding CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerBuilding, "in a small doorless room",
    "This stone room has small horizontal windows looking out into a larger "
    "space with many exits. The only exit from here is down a ladder.").
Connect(r_sewerTunnel47, r_sewerBuilding, D_UP).
AutoGraphics(r_sewerBuilding, AutoClosedRoom).
Scenery(r_sewerBuilding,
    "room;stone.window;small,horizontal.space;larger.ladder").
define tp_proving2 proc sewerBuildingEnter(thing room)void:
    if FindName(Me()@p_pCarrying, p_oName, "lamp") = fail then
	DepositClone(r_sewerBuilding, o_oilLamp);
    fi;
corp;
AddAnyEnterAction(r_sewerBuilding, sewerBuildingEnter, false).

define tp_proving2 r_sewerTunnel48 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel48, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel42, r_sewerTunnel48, D_SOUTH).

define tp_proving2 r_sewerTunnel49 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel49, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel48, r_sewerTunnel49, D_SOUTH).

define tp_proving2 r_sewerTunnel50 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel50,
    "in a north and east corner in the very low tunnel", "").
Connect(r_sewerTunnel49, r_sewerTunnel50, D_SOUTH).

define tp_proving2 r_sewerTunnel51 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel51,
    "in a north-south-east Tee in the very low tunnel", "").
Connect(r_sewerTunnel50, r_sewerTunnel51, D_EAST).

define tp_proving2 r_sewerTunnel52 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel52,
    "in a south and east corner in the very low tunnel", "").
Connect(r_sewerTunnel51, r_sewerTunnel52, D_NORTH).

define tp_proving2 r_sewerTunnel53 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel53,
    "in a north and west corner in the very low tunnel", "").
Connect(r_sewerTunnel52, r_sewerTunnel53, D_EAST).

define tp_proving2 r_sewerTunnel54 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel54, "in a very low north-south tunnel", "").
Connect(r_sewerTunnel53, r_sewerTunnel54, D_NORTH).

define tp_proving2 r_sewerTunnel55 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel55,
    "in a south and west corner in the very low tunnel", "").
Connect(r_sewerTunnel54, r_sewerTunnel55, D_NORTH).

define tp_proving2 r_sewerTunnel56 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel56, "in a very low east-west tunnel", "").
Connect(r_sewerTunnel55, r_sewerTunnel56, D_WEST).
Connect(r_sewerTunnel42, r_sewerTunnel56, D_EAST).

define tp_proving2 r_sewerTunnel57 CreateThing(r_provingTunnelD).
SetupRoomP(r_sewerTunnel57, "at the south end of the very low tunnel",
    "A tiny, badly carved crawlway heads off to the southwest.").
Connect(r_sewerTunnel51, r_sewerTunnel57, D_SOUTH).
Scenery(r_sewerTunnel57, "crawlway;tiny,badly,carved").
define tp_proving2 PR_TUNNEL57_ID NextEffectId().
define tp_proving2 proc drawTunnel57()void:

    if not KnowsEffect(nil, PR_TUNNEL57_ID) then
	DefineEffect(nil, PR_TUNNEL57_ID);
	GSetImage(nil, "pr_tunnel57");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 14, 8, true);
	    GAMove(nil, 65, 0);
	    GRectangle(nil, 29, 50, true);
	    GPolygonStart(nil);
	    GAMove(nil, 0, 99);
	    GRDraw(nil, 8, 0);
	    GRDraw(nil, 75, -46);
	    GRDraw(nil, -6, -6);
	    GRDraw(nil, -77, 46);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_TUNNEL57_ID);
corp;
AutoGraphics(r_sewerTunnel57, drawTunnel57).

define tp_proving2 r_sewerTunnel58 CreateThing(r_provingTunnel2).
SetupRoomP(r_sewerTunnel58, "in a well-used tunnel crossing", "").
Connect(r_chamberE, r_sewerTunnel58, D_EAST).

define tp_proving2 PR_CHAMBER6_ID NextEffectId().
define tp_proving2 proc drawChamber2()void:

    if not KnowsEffect(nil, PR_CHAMBER6_ID) then
	DefineEffect(nil, PR_CHAMBER6_ID);
	GSetImage(nil, "pr_chamber6");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 10, 10);
	    GRectangle(nil, 139, 79, true);
	    GAMove(nil, 0, 45);
	    GRectangle(nil, 159, 10, true);
	    GAMove(nil, 33, 0);
	    GRectangle(nil, 10, 99, true);
	    GAMove(nil, 75, 0);
	    GRectangle(nil, 10, 99, true);
	    GAMove(nil, 117, 0);
	    GRectangle(nil, 10, 99, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER6_ID);
corp;

define tp_proving2 CHAMBER6_MAP_GROUP NextMapGroup().

define tp_proving2 r_chamber6Model CreateThing(r_provingTunnel2).
RoomName(r_chamber6Model, "Large", "Chamber").
r_chamber6Model@p_MapGroup := CHAMBER6_MAP_GROUP.
r_chamber6Model@p_rDrawAction := drawChamber2.
r_chamber6Model@p_rEnterRoomDraw := EnterRoomDraw.
r_chamber6Model@p_rLeaveRoomDraw := LeaveRoomDraw.
SetThingStatus(r_chamber6Model, ts_readonly).

define tp_proving2 proc makeChamber2(int x, y; string name)thing:
    thing chamber;

    chamber := CreateThing(r_chamber6Model);
    chamber@p_rName := name;
    chamber@p_rContents := CreateThingList();
    chamber@p_rExits := CreateIntList();
    chamber@p_rCursorX := x;
    chamber@p_rCursorY := y;
    SetThingStatus(chamber, ts_wizard);
    chamber
corp;

define tp_proving2 r_chamber6W makeChamber2(19, 47,
    "on the west side of the chamber").
Connect(r_sewerTunnel58, r_chamber6W, D_EAST).

define tp_proving2 r_chamber6NW makeChamber2(35, 12,
    "in the north-west corner of the chamber").
Connect(r_chamber6W, r_chamber6NW, D_NORTH).

define tp_proving2 r_chamber6N makeChamber2(77, 12,
    "on the north side of the chamber").
Connect(r_chamber6NW, r_chamber6N, D_EAST).
Connect(r_chamber6W, r_chamber6N, D_NORTHEAST).

define tp_proving2 r_chamber6NE makeChamber2(119, 12,
    "in the north-east corner of the chamber").
Connect(r_chamber6N, r_chamber6NE, D_EAST).

define tp_proving2 r_chamber6E makeChamber2(141, 47,
    "on the west side of the chamber").
Connect(r_chamber6NE, r_chamber6E, D_SOUTH).
Connect(r_chamber6N, r_chamber6E, D_SOUTHEAST).

define tp_proving2 r_chamber6SE makeChamber2(119, 81,
    "in the south-east corner of the chamber").
Connect(r_chamber6E, r_chamber6SE, D_SOUTH).

define tp_proving2 r_chamber6S makeChamber2(77, 81,
    "on the south side of the chamber").
Connect(r_chamber6SE, r_chamber6S, D_WEST).
Connect(r_chamber6E, r_chamber6S, D_SOUTHWEST).
Connect(r_chamber6W, r_chamber6S, D_SOUTHEAST).

define tp_proving2 r_chamber6SW makeChamber2(35, 81,
    "in the south-west corner of the chamber").
Connect(r_chamber6S, r_chamber6SW, D_WEST).
Connect(r_chamber6W, r_chamber6SW, D_SOUTH).

define tp_proving2 r_chamber6Center makeChamber2(77, 47,
    "in the middle of the chamber").
Connect(r_chamber6W, r_chamber6Center, D_EAST).
Connect(r_chamber6NW, r_chamber6Center, D_SOUTHEAST).
Connect(r_chamber6N, r_chamber6Center, D_SOUTH).
Connect(r_chamber6NE, r_chamber6Center, D_SOUTHWEST).
Connect(r_chamber6E, r_chamber6Center, D_WEST).
Connect(r_chamber6SE, r_chamber6Center, D_NORTHWEST).
Connect(r_chamber6S, r_chamber6Center, D_NORTH).
Connect(r_chamber6SW, r_chamber6Center, D_NORTHEAST).

define tp_proving2 r_goblinArmoury CreateThing(r_indoors).
SetupRoomP(r_goblinArmoury, "in a goblin armoury",
    "The goblins may not be the friendliest folks when you meet them in "
    "distant tunnels, but they certainly are fine craftsmen. The weapons "
    "and armour for sale here (even to non-goblins!) are all fine items.").
AutoGraphics(r_goblinArmoury, AutoOpenRoom).
AutoPens(r_goblinArmoury, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
Connect(r_chamber6NE, r_goblinArmoury, D_NORTH).
UniConnect(r_goblinArmoury, r_chamber6NE, D_EXIT).
MakeStore(r_goblinArmoury).

define tp_proving o_goblinSword WeaponSell(r_goblinArmoury, "sword;goblin",
    "The goblin sword is a good weapon. Its feel is a bit strange, and you "
    "can't read the runes carved into it, but you can handle it just fine.",
    300, 1, 0, 1, 0, 0, 8, 13).

ignore WeaponSell(r_goblinArmoury, "axe;goblin",
    "The goblin axe is not very big, but makes an effective weapon. The "
    "handle is a bit large for you, but the weight of the head and the "
    "length of the handle more than compensate.",
    150, 1, 0, 0, 0, 0, 12, 9).

ignore WeaponSell(r_goblinArmoury, "armour;goblin,leather",
    "The goblins make good armour - this one is made of thick boiled leather "
    "reinforced with numerous tiny rivets, and embellished with strange "
    "carvings and some shoulder spikes. It doesn't fit very well, however.",
    250, 0, 0, -1, -3, 0, 0, 0).

ignore WeaponSell(r_goblinArmoury, "mail;goblin,chain.chain",
    "This is another example of fine goblin workmanship. However, since it "
    "was made for a goblin, it doesn't fit you very well.",
    900, -1, 0, -1, -5, 0, 0, 0).

ignore WeaponSell(r_goblinArmoury, "mail;goblin,plate.plate",
    "This plate mail is fairly adjustable, so even though it was made for a "
    "goblin, it works well for you. There are some runes carved on the "
    "inside of each piece - perhaps they are for luck.",
    4000, 0, 1, 1, -6, 0, 0, 0).

define tp_proving2 r_goblinHealer CreateThing(r_indoors).
SetupRoomP(r_goblinHealer, "in a goblin apothecary",
    "The goblin running this establishment is a rare item indeed - he is "
    "willing, for money, to help others out. He will sell you healing, "
    "just like the fellow aboveground. His establishment is little more "
    "than a literal hole-in-the-wall, but he seems to know his trade.").
AutoGraphics(r_goblinHealer, AutoOpenRoom).
AutoPens(r_goblinHealer, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
Connect(r_chamber6NW, r_goblinHealer, D_NORTH).
UniConnect(r_goblinHealer, r_chamber6NW, D_EXIT).
HealSell(r_goblinHealer, "heal;minor.minor", 20, 6).
HealSell(r_goblinHealer, "heal;small.small", 40, 15).
HealSell(r_goblinHealer, "heal;medium.medium", 100, 40).
HealSell(r_goblinHealer, "heal;large.large", 350, 140).
HealSell(r_goblinHealer, "heal;great.great", 1000, 500).
r_goblinHealer@p_rBuyAction := HealingBuy.

define tp_proving2 r_goblinStore CreateThing(r_indoors).
SetupRoomP(r_goblinStore, "in a goblin store",
    "This store is a medium-sized hole carved out of the rock, with some "
    "wooden shelves holding the merchandise. The stock here is pretty "
    "limited, but there are lots of each item that is for sale.").
AutoGraphics(r_goblinStore, AutoOpenRoom).
AutoPens(r_goblinStore, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
Scenery(r_goblinStore, "shelf,shelves.merchandise.stock").
Connect(r_chamber6SE, r_goblinStore, D_SOUTH).
UniConnect(r_goblinStore, r_chamber6SE, D_EXIT).
MakeStore(r_goblinStore).
AddObjectForSale(r_goblinStore, o_torch, 15, buyTorch).
AddObjectForSale(r_goblinStore, o_sack, 30, nil).
AddObjectForSale(r_goblinStore, o_refill, 75, nil).
ignore WeaponSell(r_goblinStore, "shield;troll-hide.shield;troll,hide",
    "The troll-hide shield, being made from the hide of a cave troll, "
    "is much stronger than a regular hide shield.",
    100, 0, 0, 0, 0, -2, 0, 0).

define tp_proving2 o_mushroom AddForSale(r_goblinStore, "mushroom;healing",
    "", 25, nil).
define tp_proving2 proc mushroomEat()status:
    thing th, me;
    int current, max;

    th := It();
    me := Me();
    Print("You eat the mushroom. It makes you feel better.\n");
    current := me@p_pHitNow;
    max := me@p_pHitMax;
    if current ~= max then
	current := current + Random(10) + 10;
	if current > max then
	    current := max;
	fi;
	me@p_pHitNow := current;
    fi;
    if CanSee(Here(), me) and not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " eats a mushroom.\n");
    fi;
    ClearThing(th);
    DelElement(me@p_pCarrying, th);
    succeed
corp;
o_mushroom@p_oEatChecker := mushroomEat.
o_mushroom@p_oSmellString :=
    "The mushroom smells a lot like a normal mushroom, but there is an "
    "added tang to the odour.".
o_mushroom@p_oTouchString :=
    "The mushroom is a bit past its prime, so it is a little bit soft, "
    "but it is still edible.".

define tp_proving2 r_goblinRoom CreateThing(r_indoors).
SetupRoomP(r_goblinRoom, "in an unused room", "").
AutoGraphics(r_goblinRoom, AutoOpenRoom).
AutoPens(r_goblinRoom, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
Connect(r_chamber6SW, r_goblinRoom, D_SOUTH).
UniConnect(r_goblinRoom, r_chamber6SW, D_EXIT).

define tp_proving2 r_provingTunnel3 CreateThing(r_provingTunnel2).
define tp_proving2 proc drawTunnel3()void:
    thing here;
    list int exits;

    AutoTunnels();
    here := Here();
    exits := here@p_rExits;
    GSetPen(nil, C_BROWN);
    if here@p_rNorth ~= nil and FindElement(exits, D_NORTH) = -1 then
	GAMove(nil, 75, 41);
	HorizontalDoor();
    fi;
    if here@p_rEast ~= nil and FindElement(exits, D_EAST) = -1 then
	GAMove(nil, 95, 46);
	VerticalDoor();
    fi;
    if here@p_rSouth ~= nil and FindElement(exits, D_SOUTH) = -1 then
	GAMove(nil, 75, 59);
	HorizontalDoor();
    fi;
    if here@p_rWest ~= nil and FindElement(exits, D_WEST) = -1 then
	GAMove(nil, 64, 46);
	VerticalDoor();
    fi;
corp;
AutoGraphics(r_provingTunnel3, drawTunnel3).
AutoPens(r_provingTunnel3, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
SetThingStatus(r_provingTunnel3, ts_wizard).

define tp_proving2 r_sewerTunnel59 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel59, "at a tunnel tee", "").
Connect(r_chamber6E, r_sewerTunnel59, D_EAST).

define tp_proving2 r_sewerTunnel60 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel60, "in a north-south tunnel", "").
Connect(r_sewerTunnel59, r_sewerTunnel60, D_NORTH).

define tp_proving2 r_sewerTunnel61 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel61, "at a south/west corner", "").
Connect(r_sewerTunnel60, r_sewerTunnel61, D_NORTH).

define tp_proving2 r_sewerTunnel62 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel62, "in an east-west tunnel", "").
Connect(r_sewerTunnel61, r_sewerTunnel62, D_WEST).

define tp_proving2 r_sewerTunnel63 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel63, "at a tunnel tee", "").
Connect(r_sewerTunnel62, r_sewerTunnel63, D_WEST).
Connect(r_chamber6N, r_sewerTunnel63, D_NORTH).

define tp_proving2 r_sewerTunnel64 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel64, "in an east-west tunnel", "").
Connect(r_sewerTunnel63, r_sewerTunnel64, D_WEST).

define tp_proving2 r_sewerTunnel65 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel65, "at a south/east corner", "").
Connect(r_sewerTunnel64, r_sewerTunnel65, D_WEST).

define tp_proving2 r_sewerTunnel66 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel66, "in a north-south tunnel", "").
Connect(r_sewerTunnel65, r_sewerTunnel66, D_SOUTH).
Connect(r_sewerTunnel58, r_sewerTunnel66, D_NORTH).

define tp_proving2 r_sewerTunnel67 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel67, "in a north-south tunnel", "").
Connect(r_sewerTunnel58, r_sewerTunnel67, D_SOUTH).

define tp_proving2 r_sewerTunnel68 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel68, "at a north/east corner", "").
Connect(r_sewerTunnel67, r_sewerTunnel68, D_SOUTH).

define tp_proving2 r_sewerTunnel69 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel69, "in an east-west tunnel", "").
Connect(r_sewerTunnel68, r_sewerTunnel69, D_EAST).

define tp_proving2 r_sewerTunnel70 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel70, "at a tunnel tee", "").
Connect(r_sewerTunnel69, r_sewerTunnel70, D_EAST).
Connect(r_chamber6S, r_sewerTunnel70, D_SOUTH).

define tp_proving2 r_sewerTunnel71 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel71, "in an east-west tunnel", "").
Connect(r_sewerTunnel70, r_sewerTunnel71, D_EAST).

define tp_proving2 r_sewerTunnel72 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel72, "at a north/west corner", "").
Connect(r_sewerTunnel71, r_sewerTunnel72, D_EAST).

define tp_proving2 r_sewerTunnel73 CreateThing(r_provingTunnel3).
SetupRoomP(r_sewerTunnel73, "in a north-south tunnel", "").
Connect(r_sewerTunnel72, r_sewerTunnel73, D_NORTH).
Connect(r_sewerTunnel59, r_sewerTunnel73, D_SOUTH).

define tp_proving2 r_shaman CreateThing(r_indoors).
SetupRoomP(r_shaman, "in the shaman's room",
    "The goblin shaman offers a few strange items for sale. His room is "
    "little different from the others around it.").
RoomName(r_shaman, "Shaman's", "room").
AutoGraphics(r_shaman, AutoClosedRoom).
AutoPens(r_shaman, C_DARK_GREY, C_LIGHT_GREY, C_BLACK, C_BROWN).
Scenery(r_shaman,
    "cot;wooden."
    "table;sturdy,wooden."
    "chair;pair,of,unpadded."
    "chest;small clothes."
    "furniture,furnishing;sparse").
HUniConnect(r_sewerTunnel64, r_shaman, D_SOUTH).
UniConnect(r_shaman, r_sewerTunnel64, D_NORTH).
UniConnect(r_shaman, r_sewerTunnel64, D_EXIT).
MakeStore(r_shaman).
define tp_proving2 o_strengthPotion AddForSale(r_shaman, "potion;strength",
    "The strength potion comes in a small red bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil).
define tp_proving2 proc strengthCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pStrength := who@p_pStrength - 1;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_proving2 proc strengthDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pStrength := me@p_pStrength + 1;
    Print("Yuck! That was awful!\n");
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " drinks an unpleasant potion.\n");
    else
	OPrint("You hear a gagging sound.\n");
    fi;
    AddTail(me@p_pHiddenList, it);
    DelElement(me@p_pCarrying, it);
    DoAfter(5 * 60, it, strengthCancel);
    succeed
corp;
o_strengthPotion@p_oEatChecker := strengthDrink.
define tp_proving2 o_speedPotion AddForSale(r_shaman, "potion;speed",
    "The speed potion comes in a small green bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil).
define tp_proving2 proc speedCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pSpeed := who@p_pSpeed - 1;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_proving2 proc speedDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pSpeed := me@p_pSpeed + 1;
    Print("Yech! That was terrible!\n");
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " drinks an unpleasant potion.\n");
    else
	OPrint("You hear a gagging sound.\n");
    fi;
    AddTail(me@p_pHiddenList, it);
    DelElement(me@p_pCarrying, it);
    DoAfter(5 * 60, it, speedCancel);
    succeed
corp;
o_speedPotion@p_oEatChecker := speedDrink.
define tp_proving2 o_excessPotion AddForSale(r_shaman, "potion;excess",
    "The excess potion comes in a small blue bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil).
define tp_proving2 proc excessCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pHitMax := who@p_pHitMax - 10;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_proving2 proc excessDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pHitMax := me@p_pHitMax + 10;
    Print("Ug! That was vile!\n");
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " drinks an unpleasant potion.\n");
    else
	OPrint("You hear a gagging sound.\n");
    fi;
    AddTail(me@p_pHiddenList, it);
    DelElement(me@p_pCarrying, it);
    DoAfter(60 * 60, it, excessCancel);
    succeed
corp;
o_excessPotion@p_oEatChecker := excessDrink.

define tp_proving2 r_cell2 CreateThing(r_indoors).
r_cell2@p_rName := "in a featureless room".
r_cell2@p_rDesc :=
    "The room is sparsely furnished with a wooden cot, a sturdy wooden "
    "table with a pair of unpadded chairs, and a small clothes chest.".
AutoGraphics(r_cell2, AutoClosedRoom).
AutoPens(r_cell2, C_DARK_GREY, C_LIGHT_GREY, C_BLACK, C_BROWN).
Scenery(r_cell2,
    "cot;wooden."
    "table;sturdy,wooden."
    "chair;pair,of,unpadded."
    "chest;small clothes."
    "furniture,furnishing;sparse").
SetThingStatus(r_cell2, ts_readonly).

define tp_proving2 proc makeCell2(thing tunnel; int dir)thing:
    thing cell;

    cell := CreateThing(r_cell2);
    cell@p_rContents := CreateThingList();
    cell@p_rExits := CreateIntList();
    HUniConnect(tunnel, cell, dir);
    UniConnect(cell, tunnel, DirBack(dir));
    UniConnect(cell, tunnel, D_EXIT);
    SetThingStatus(cell, ts_wizard);
    cell
corp;

ignore makeCell2(r_sewerTunnel59, D_EAST).
ignore makeCell2(r_sewerTunnel60, D_EAST).
ignore makeCell2(r_sewerTunnel60, D_WEST).
ignore makeCell2(r_sewerTunnel61, D_EAST).
ignore makeCell2(r_sewerTunnel61, D_NORTH).
ignore makeCell2(r_sewerTunnel62, D_NORTH).
ignore makeCell2(r_sewerTunnel62, D_SOUTH).
ignore makeCell2(r_sewerTunnel63, D_NORTH).
ignore makeCell2(r_sewerTunnel64, D_NORTH).
ignore makeCell2(r_sewerTunnel65, D_NORTH).
ignore makeCell2(r_sewerTunnel65, D_WEST).
ignore makeCell2(r_sewerTunnel66, D_EAST).
ignore makeCell2(r_sewerTunnel66, D_WEST).
ignore makeCell2(r_sewerTunnel67, D_EAST).
ignore makeCell2(r_sewerTunnel67, D_WEST).
ignore makeCell2(r_sewerTunnel68, D_WEST).
ignore makeCell2(r_sewerTunnel68, D_SOUTH).
ignore makeCell2(r_sewerTunnel69, D_NORTH).
ignore makeCell2(r_sewerTunnel69, D_SOUTH).
ignore makeCell2(r_sewerTunnel70, D_SOUTH).
ignore makeCell2(r_sewerTunnel71, D_NORTH).
ignore makeCell2(r_sewerTunnel71, D_SOUTH).
ignore makeCell2(r_sewerTunnel72, D_SOUTH).
ignore makeCell2(r_sewerTunnel72, D_EAST).
ignore makeCell2(r_sewerTunnel73, D_EAST).
ignore makeCell2(r_sewerTunnel73, D_WEST).

define tp_proving2 r_crawlway CreateThing(r_tunnel).
AutoGraphics(r_crawlway, AutoPaths).
AutoPens(r_crawlway, C_DARK_GREY, C_LIGHT_GREY, 0, 0).
r_crawlway@p_rName := "in a winding crawlway".
r_crawlway@p_rDark := true.
SetThingStatus(r_crawlway, ts_readonly).
monsterSet3(r_crawlway).

define tp_proving2 proc makeCrawlway(thing previous; int dir)thing:
    thing crawlway;

    crawlway := CreateThing(r_crawlway);
    crawlway@p_rContents := CreateThingList();
    crawlway@p_rExits := CreateIntList();
    Connect(previous, crawlway, dir);
    SetThingStatus(crawlway, ts_wizard);
    crawlway
corp;

define tp_proving2 r_crawlway1 makeCrawlway(r_sewerTunnel57, D_SOUTHWEST).

define tp_proving2 r_crawlway2 makeCrawlway(r_crawlway1, D_WEST).

define tp_proving2 r_crawlway3 makeCrawlway(r_crawlway2, D_SOUTHWEST).
r_crawlway3@p_rDesc := "You can smell something bad nearby.".
r_crawlway3@p_oSmellString := "Yes, definitely something rotten around here.".

define tp_proving2 r_sewerChamber5 CreateThing(r_crawlway).
SetupRoomP(r_sewerChamber5, "in a goblin hideout",
    "The hideout is littered with just about every unmentionable thing you "
    "can think of. Small crawlways lead off in several directions.").
Connect(r_crawlway3, r_sewerChamber5, D_WEST).
define tp_proving2 PR_CHAMBER5_ID NextEffectId().
define tp_proving2 proc drawChamber5()void:

    if not KnowsEffect(nil, PR_CHAMBER5_ID) then
	DefineEffect(nil, PR_CHAMBER5_ID);
	GSetImage(nil, "pr_chamber5");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    DrawTunnelChamber(C_DARK_GREY, C_LIGHT_GREY);
	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 159, 0);
	    GRDraw(nil, 0, 6);
	    GRDraw(nil, -76, 47);
	    GRDraw(nil, -6, -6);
	    GRDraw(nil, 74, -47);
	    GPolygonEnd(nil);
	    GAMove(nil, 80, 46);
	    GRectangle(nil, 79, 8, true);
	    GAMove(nil, 75, 50);
	    GRectangle(nil, 10, 49, true);
	    GAMove(nil, 0, 46);
	    GRectangle(nil, 80, 8, true);
	    GPolygonStart(nil);
	    GAMove(nil, 0, 0);
	    GRDraw(nil, 8, 0);
	    GRDraw(nil, 75, 47);
	    GRDraw(nil, -6, 6);
	    GRDraw(nil, -77, -47);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER5_ID);
corp;
AutoGraphics(r_sewerChamber5, drawChamber5).
Scenery(r_sewerChamber5, "thing;unmentionable").
r_sewerChamber5@p_oSmellString :=
    "The smell of rotten meat, rotten vegetables, rotten breath and rotten "
    "bodies is nearly overpowering!".
r_sewerChamber5@p_rLastVisit := 0.
define tp_proving2 proc chamber5Enter(thing room)void:
    thing me, monster, shield;
    int i, now, count;
    list thing lt;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerChamber5@p_rLastVisit >= 300 then
	r_sewerChamber5@p_rLastVisit := now;
	for i from 0 upto Random(5) + 4 do
	    monster := if Random(10) = 0 then m_fighterGoblin else m_goblin fi;
	    ignore CreateMonster(me, monster, r_sewerChamber5);
	od;
	lt := me@p_pCarrying;
	count := Count(lt);
	i := 0;
	while i < count do
	    shield := lt[i];
	    if shield@p_oShieldProt <= o_woodenShield@p_oShieldProt then
		i := count + 1;
	    else
		i := i + 1;
	    fi;
	od;
	if i = count then
	    DepositClone(r_sewerChamber5, o_woodenShield);
	fi;
    fi;
corp;
AddAnyEnterAction(r_sewerChamber5, chamber5Enter, false).

define tp_proving2 r_crawlway4 makeCrawlway(r_sewerChamber5, D_NORTHEAST).

define tp_proving2 r_crawlway5 makeCrawlway(r_sewerChamber5, D_SOUTH).

define tp_proving2 r_crawlway6 makeCrawlway(r_crawlway5, D_WEST).

define tp_proving2 r_crawlway7 makeCrawlway(r_crawlway5, D_SOUTHWEST).

define tp_proving2 r_crawlway8 makeCrawlway(r_crawlway7, D_SOUTH).

define tp_proving2 r_crawlway9 makeCrawlway(r_crawlway8, D_NORTHWEST).

define tp_proving2 r_crawlway10 makeCrawlway(r_crawlway9, D_NORTH).

define tp_proving2 r_crawlway11 makeCrawlway(r_crawlway10, D_NORTHEAST).
Connect(r_sewerChamber5, r_crawlway11, D_WEST).

define tp_proving2 r_crawlway12 makeCrawlway(r_sewerChamber5, D_NORTHWEST).

define tp_proving2 r_crawlway13 makeCrawlway(r_crawlway12, D_WEST).

define tp_proving2 r_crawlway14 makeCrawlway(r_crawlway13, D_NORTHWEST).

define tp_proving2 r_crawlway15 makeCrawlway(r_crawlway14, D_SOUTHWEST).

define tp_proving2 r_crawlway16 makeCrawlway(r_crawlway15, D_SOUTHWEST).

define tp_proving r_crawlway17 CreateThing(r_crawlway).
SetupRoomP(r_crawlway17, "at the end of a crawlway",
    "You are high up on the north wall of a large cavern. You can drop down "
    "to the cavern floor, but you would not be able to get back up.").
Connect(r_crawlway16, r_crawlway17, D_SOUTH).
Scenery(r_crawlway17, "cavern;large.wall;north.floor;cavern").

unuse tp_proving2
