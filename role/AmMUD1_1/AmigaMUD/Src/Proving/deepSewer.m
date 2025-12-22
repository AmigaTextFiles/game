/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * deepSewer.m - deep sewer level of the proving grounds.
 */

define tp_proving tp_deepSewer CreateTable()$
use tp_deepSewer

define tp_deepSewer r_sewerShaft2 CreateThing(r_provingTunnelD)$
SetupRoom(r_sewerShaft2, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb up here, and a "
    "small opening heads south.")$
Connect(r_sewerShaft1, r_sewerShaft2, D_DOWN)$
Scenery(r_sewerShaft2, "wrung;rusty,metal.opening;small")$

define tp_deepSewer r_sewerShaft4 CreateThing(r_provingTunnelD)$
SetupRoom(r_sewerShaft4, "in a vertical shaft",
    "Rusty metal wrungs in the wall allow you to climb up here, and a "
    "small opening heads north.")$
Connect(r_sewerShaft3, r_sewerShaft4, D_DOWN)$
Scenery(r_sewerShaft4, "wrung;rusty,metal.opening;small")$

define tp_deepSewer r_sewerChamber1 CreateThing(r_provingTunnelD)$
SetupRoom(r_sewerChamber1, "in a large chamber",
    "This chamber is quite large, but fairly low, and the ceiling is held "
    "up by numerous stone pillars. You can see small openings in the "
    "north, south, east and west walls.")$
Connect(r_sewerShaft2, r_sewerChamber1, D_SOUTH)$
Connect(r_sewerShaft4, r_sewerChamber1, D_NORTH)$
AutoGraphics(r_sewerChamber1, AutoTunnelChamber)$
Scenery(r_sewerChamber1, "ceiling.pillar;numerous,stone.opening;small.wall")$
r_sewerChamber1@p_Image := "Proving/sewerChamber1"$

define tp_deepSewer r_sewerTunnel1 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel1, "in a low east-west tunnel", "")$
Connect(r_sewerChamber1, r_sewerTunnel1, D_WEST)$

define tp_deepSewer r_sewerTunnel2 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel2, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel1, r_sewerTunnel2, D_WEST)$

define tp_deepSewer r_sewerTunnel3 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel3, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel2, r_sewerTunnel3, D_WEST)$

define tp_deepSewer r_sewerTunnel4 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel4, "in a low north-south-east tunnel Tee", "")$
Connect(r_sewerTunnel3, r_sewerTunnel4, D_WEST)$

define tp_deepSewer r_sewerTunnel5 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel5, "in a low north-south tunnel", "")$
Connect(r_sewerTunnel4, r_sewerTunnel5, D_NORTH)$

define tp_deepSewer r_sewerTunnel6 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel6, "at a south and east corner in the low tunnel","")$
Connect(r_sewerTunnel5, r_sewerTunnel6, D_NORTH)$

define tp_deepSewer r_sewerTunnel7 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel7, "at a south-east-west Tee in the low tunnel", "")$
Connect(r_sewerTunnel6, r_sewerTunnel7, D_EAST)$

define tp_deepSewer r_sewerTunnel8 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel8, "at a south-east-west Tee in the low tunnel","")$
Connect(r_sewerTunnel7, r_sewerTunnel8, D_EAST)$

define tp_deepSewer r_sewerTunnel8_5 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel8_5, "at a dead-end in the low tunnel",
    "The tunnel ends here in a blank wall. You can only go to the north.")$
Connect(r_sewerTunnel8, r_sewerTunnel8_5, D_SOUTH)$
Scenery(r_sewerTunnel8_5, "wall;blank")$

define tp_proving r_sewerChamber2 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerChamber2, "in a large chamber",
    "The ceiling of this chamber is of medium height, and is held up by "
    "numerous stone columns. There is a small opening in the north wall, and "
    "a dark hole in the floor near a back corner.")$
Connect(r_sewerTunnel7, r_sewerChamber2, D_SOUTH)$
AutoGraphics(r_sewerChamber2, AutoTunnelChamber)$
r_sewerChamber2@p_rDownMessage := "You drop through the small hole."$
r_sewerChamber2@p_rDownOMessage := "drops through the small hole."$
Scenery(r_sewerChamber2,
	"ceiling,floor."
	"column;numerous,stone."
	"opening;small."
	"wall;back,north."
	"hole;dark."
	"corner;back")$
define tp_deepSewer o_goblinDagger CreateThing(nil)$
o_goblinDagger@p_oName := "dagger;goblin"$
o_goblinDagger@p_oDesc :=
    "The goblin dagger has some unreadable runes scratched into the hilt, "
    "and is of pretty shoddy workmanship. It is quite serviceable, however."$
o_goblinDagger@p_oHome := r_lostAndFound$
o_goblinDagger@p_Image := "Proving/goblinDagger"$
SetupWeapon(o_goblinDagger, 0, 0, 0, 0, 0, 5, 9)$
SetThingStatus(o_goblinDagger, ts_readonly)$
define tp_deepSewer proc daggerQuestDesc()string:
    "Bring me a goblin dagger."
corp;
define tp_deepSewer proc daggerQuestGive()status:
    thing dagger;

    dagger := It();
    if Parent(dagger) = o_goblinDagger then
	GiveToQuestor("goblin dagger");
	succeed
    elif dagger@p_oName = "dagger;goblin" then
	GiveToQuestor("goblin dagger");
	SPrint(TrueMe(), "Questor is not impressed.\n");
	fail
    else
	continue
    fi
corp;
define tp_deepSewer proc daggerQuestHint()string:
    "Don't be afraid of the dark. Look beneath the dirty places."
corp;
QuestGive("Dagger", daggerQuestDesc, daggerQuestGive, daggerQuestHint)$
r_sewerChamber2@p_rLastVisit := 0$
define tp_deepSewer proc chamber2Enter(thing room)void:
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
AddAnyEnterAction(r_sewerChamber2, chamber2Enter, false)$
r_sewerChamber2@p_Image := "Proving/sewerChamber2"$

define tp_deepSewer r_sewerTunnel9 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel9, "at a north and west corner in the low tunnel","")$
Connect(r_sewerTunnel4, r_sewerTunnel9, D_SOUTH)$

define tp_deepSewer r_sewerTunnel10 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel10,"at a south and east corner in the low tunnel","")$
Connect(r_sewerTunnel9, r_sewerTunnel10, D_WEST)$

define tp_deepSewer r_sewerTunnel10_5 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel10_5, "in a low north-south tunnel", "")$
Connect(r_sewerTunnel10, r_sewerTunnel10_5, D_SOUTH)$

define tp_deepSewer r_sewerTunnel11 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel11, "in a low north-south tunnel", "")$
Connect(r_sewerTunnel10_5, r_sewerTunnel11, D_SOUTH)$

define tp_deepSewer r_sewerTunnel12 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel12,"at a north and east corner in the low tunnel","")$
Connect(r_sewerTunnel11, r_sewerTunnel12, D_SOUTH)$

define tp_deepSewer r_sewerTunnel13 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel13, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel12, r_sewerTunnel13, D_EAST)$

define tp_deepSewer r_sewerTunnel14 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel14,"at a north and west corner in the low tunnel","")$
Connect(r_sewerTunnel13, r_sewerTunnel14, D_EAST)$

define tp_deepSewer r_sewerTunnel15 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel15, "at a south-east-west Tee in the low tunnel", "")$
Connect(r_sewerTunnel14, r_sewerTunnel15, D_NORTH)$

define tp_deepSewer r_sewerChamber3 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerChamber3, "in a large chamber",
    "This high-ceilinged chamber shows signs of animal habitation. The floor "
    "is littered with twigs, grass, bones, and other less pleasant things. "
    "The stone pillars supporting the dimly visible ceiling are rank with "
    "oozing slime. A small passage leads out of the east wall.")$
Connect(r_sewerTunnel15, r_sewerChamber3, D_WEST)$
AutoGraphics(r_sewerChamber3, AutoTunnelChamber)$
Scenery(r_sewerChamber3,
    "ceiling."
    "pillar;numerous,stone."
    "passage;small."
    "wall."
    "sign."
    "floor."
    "slime;oozing,rotting."
    "litter."
    "twig,grass,bone,thing;less,pleasant,dead")$
r_sewerChamber3@p_rLastVisit := 0$
define tp_deepSewer proc chamber3Enter(thing room)void:
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
AddAnyEnterAction(r_sewerChamber3, chamber3Enter, false)$
r_sewerChamber3@p_Image := "Proving/sewerChamber3"$
r_sewerChamber3@p_oSmellString :=
    "It doesn't smell very nice in here - you smell a combination of "
    "rank bodies, dead things and rotting slime."$

define tp_deepSewer r_sewerTunnel16 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel16, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel15, r_sewerTunnel16, D_EAST)$

define tp_deepSewer r_sewerTunnel17 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel17, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel16, r_sewerTunnel17, D_EAST)$

define tp_deepSewer r_sewerTunnel18 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel18, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel17, r_sewerTunnel18, D_EAST)$

define tp_deepSewer r_sewerTunnel19 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel19, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel18, r_sewerTunnel19, D_EAST)$

define tp_deepSewer r_sewerTunnel20 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel20,"at a north and west corner in the low tunnel","")$
Connect(r_sewerTunnel19, r_sewerTunnel20, D_EAST)$

define tp_deepSewer r_sewerTunnel21 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel21,"at a south and west corner in the low tunnel","")$
Connect(r_sewerTunnel20, r_sewerTunnel21, D_NORTH)$

define tp_deepSewer r_sewerTunnel22 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel22, "at a north-east-west Tee in the low tunnel", "")$
Connect(r_sewerTunnel21, r_sewerTunnel22, D_WEST)$

define tp_deepSewer r_sewerTunnel23 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel23, "at an end in the low tunnel",
    "You can go to the east or down a ladder.")$
Connect(r_sewerTunnel22, r_sewerTunnel23, D_WEST)$
Scenery(r_sewerTunnel23, "ladder")$

define tp_deepSewer r_sewerTunnel24 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel24, "in a low north-south tunnel", "")$
Connect(r_sewerTunnel22, r_sewerTunnel24, D_NORTH)$

define tp_deepSewer r_sewerTunnel25 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel25, "at a south and west corner in a low tunnel", "")$
Connect(r_sewerTunnel24, r_sewerTunnel25, D_NORTH)$
Connect(r_sewerTunnel25, r_sewerChamber1, D_WEST)$

define tp_deepSewer r_sewerTunnel26 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel26, "at an end in a very low tunnel",
    "You can go to the north or up a ladder.")$
Connect(r_sewerTunnel23, r_sewerTunnel26, D_DOWN)$
Scenery(r_sewerTunnel26, "ladder")$

define tp_deepSewer r_sewerTunnel27 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel27, "in a very low north-south tunnel",
    "There is a crack in the west wall. You can hear noises coming from it.")$
Connect(r_sewerTunnel26, r_sewerTunnel27, D_NORTH)$
Scenery(r_sewerTunnel27, "crack")$
r_sewerTunnel27@p_oListenString :=
    "You can't really identify the noises, but there seems to be two parts "
    "to them - one soft and fairly continuous, and the other slightly louder "
    "and sporadic."$
r_sewerTunnel27@p_rWestEMessage := "comes out of the crack."$
r_sewerTunnel27@p_rEnterMessage := "comes out of the crack."$
r_sewerTunnel27@p_Image := "Proving/sewerTunnel27"$
r_sewerTunnel27@p_rWestImage := "Proving/sewerTunnel27-W"$
define tp_deepSewer o_snakeCrack CreateThing(nil)$
FakeObject(o_snakeCrack, r_sewerTunnel27, "crack.wall;west",
    "The crack is narrow, but it looks like you could squeeze into it.")$
o_snakeCrack@p_oListenString :=
    "The noises are definitely coming from the crack."$
o_snakeCrack@p_oSmellString :=
    "You smell a faint combination of must and death."$
o_snakeCrack@p_Image := "Proving/crack"$

define tp_deepSewer r_sewerTunnel28 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel28, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel27, r_sewerTunnel28, D_NORTH)$

define tp_deepSewer r_sewerTunnel29 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel29, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel28, r_sewerTunnel29, D_NORTH)$

define tp_deepSewer r_sewerTunnel30 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel30, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel29, r_sewerTunnel30, D_NORTH)$

define tp_deepSewer r_sewerTunnel31 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel31, "at an end in the very low tunnel",
    "You can go to the south or up a ladder.")$
Connect(r_sewerTunnel30, r_sewerTunnel31, D_NORTH)$
Scenery(r_sewerTunnel31, "ladder")$

define tp_deepSewer r_sewerTunnel32 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel32, "at an end in the low tunnel",
    "You can go to the south or down a ladder.")$
Connect(r_sewerTunnel31, r_sewerTunnel32, D_UP)$
Scenery(r_sewerTunnel32, "ladder")$

define tp_deepSewer r_sewerTunnel33 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel33, "at a north-east-west Tee in the low tunnel", "")$
Connect(r_sewerTunnel32, r_sewerTunnel33, D_SOUTH)$

define tp_deepSewer r_sewerTunnel34 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel34, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel33, r_sewerTunnel34, D_WEST)$
Connect(r_sewerTunnel8, r_sewerTunnel34, D_EAST)$

define tp_deepSewer r_sewerTunnel35 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel35, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel33, r_sewerTunnel35, D_EAST)$

define tp_deepSewer r_sewerTunnel36 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel36, "at the end of a crack",
    "There is a hole in floor here, from which the noises are coming. It "
    "sounds like a lot of things quietly rubbing against each other, along "
    "with an occasional hissing.")$
HUniConnect(r_sewerTunnel27, r_sewerTunnel36, D_WEST)$
HUniConnect(r_sewerTunnel27, r_sewerTunnel36, D_ENTER)$
UniConnect(r_sewerTunnel36, r_sewerTunnel27, D_EAST)$
UniConnect(r_sewerTunnel36, r_sewerTunnel27, D_EXIT)$
AutoGraphics(r_sewerTunnel36, AutoPaths)$
AutoPens(r_sewerTunnel36, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
Scenery(r_sewerTunnel36, "crack.hole")$
r_sewerTunnel36@p_oListenString :=
    "The rubbing noise is quite strange - it comes and goes in intensity, "
    "and seems to consist of many quieter noises. The hissing is infrequent "
    "and also varies from soft to loud."$
r_sewerTunnel36@p_rDownEMessage := "crawls out of the pit."$
r_sewerTunnel36@p_rExitEMessage := "crawls out of the pit."$
r_sewerTunnel36@p_Image := "Proving/sewerTunnel36"$
r_sewerTunnel36@p_rDownImage := "Proving/sewerTunnel36-D"$
define tp_deepSewer o_snakeHole CreateThing(nil)$
FakeObject(o_snakeHole, r_sewerTunnel36, "hole.pit",
    "The hole is small, but it looks like you could squeeze into it.")$
o_snakeHole@p_oListenString :=
    "The rubbing noises are definitely coming from the hole."$
o_snakeHole@p_oSmellString :=
    "You smell a combination of must and death."$
o_snakeHole@p_Image := "Proving/sewerTunnel36-D"$

define tp_deepSewer r_sewerSnakePit CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerSnakePit, "in a snake pit",
    "The pit is littered with bones and small bits of eggshell.")$
Connect(r_sewerTunnel36, r_sewerSnakePit, D_DOWN)$
UniConnect(r_sewerSnakePit, r_sewerTunnel36, D_EXIT)$
AutoGraphics(r_sewerSnakePit, AutoTunnelChamber)$
Scenery(r_sewerSnakePit,
    "bone,bit,litter,eggshell,shell;shell,small,bits,of,egg.pit;snake.hole")$
r_sewerSnakePit@p_rLastVisit := 0$
define tp_deepSewer proc chamber4Enter(thing room)void:
    thing me, monster;
    int i, now;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerSnakePit@p_rLastVisit >= 300 then
	r_sewerSnakePit@p_rLastVisit := now;
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
	    ignore CreateMonster(me, monster, r_sewerSnakePit);
	od;
	if FindName(me@p_pCarrying, p_oName, "armour") = fail and
	    FindName(me@p_pCarrying, p_oName, "mail") = fail
	then
	    DepositClone(r_sewerSnakePit, o_leatherArmour);
	fi;
    fi;
corp;
AddAnyEnterAction(r_sewerSnakePit, chamber4Enter, false)$
r_sewerSnakePit@p_Image := "Proving/sewerChamber4"$
r_sewerSnakePit@p_oSmellString :=
    "The musty, dry smell is now identified with the snakes, and is quite "
    "strong down here. There are also other smells mixed in, not very "
    "pleasant and vaguely animal-like."$

define tp_deepSewer r_sewerTunnel37 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel37, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel35, r_sewerTunnel37, D_EAST)$

define tp_deepSewer r_sewerTunnel38 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel38, "in a low east-west tunnel", "")$
Connect(r_sewerTunnel37, r_sewerTunnel38, D_EAST)$

define tp_deepSewer PR_CHAMBER_ID NextEffectId()$
define tp_deepSewer proc drawChamber()void:

    if not KnowsEffect(nil, PR_CHAMBER_ID) then
	DefineEffect(nil, PR_CHAMBER_ID);
	GSetImage(nil, "Proving/chamber");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 0.44, 0.0);
	    GRectangle(nil, 0.06, 1.0, true);

	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.43, 1.0, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 0.03, 0.1);
	    GRectangle(nil, 0.37, 0.79, true);
	    GAMove(nil, 0.0, 0.21);
	    GRectangle(nil, 0.43, 0.1, true);
	    GAMove(nil, 0.0, 0.45);
	    GRectangle(nil, 0.43, 0.1, true);
	    GAMove(nil, 0.0, 0.69);
	    GRectangle(nil, 0.43, 0.1, true);
	    GAMove(nil, 0.1, 0.0);
	    GRectangle(nil, 0.03, 1.0, true);
	    GAMove(nil, 0.2, 0.0);
	    GRectangle(nil, 0.03, 1.0, true);
	    GAMove(nil, 0.3, 0.0);
	    GRectangle(nil, 0.03, 1.0, true);

	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 0.12, 0.33);
	    GRectangle(nil, 0.2, 0.34, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER_ID);
corp;

define tp_deepSewer CHAMBER_MAP_GROUP NextMapGroup()$

define tp_deepSewer r_chamberModel CreateThing(r_provingTunnel2)$
RoomName(r_chamberModel, "Large", "Chamber")$
r_chamberModel@p_MapGroup := CHAMBER_MAP_GROUP$
r_chamberModel@p_rDrawAction := drawChamber$
r_chamberModel@p_rEnterRoomDraw := EnterRoomDraw$
r_chamberModel@p_rLeaveRoomDraw := LeaveRoomDraw$
r_chamberModel@p_oSmellString :=
    "The chamber smells a bit musty and a bit dusty, but is surprisingly "
    "fresh, considering how far underground it is."$
r_chamberModel@p_oListenString :=
    "You can't hear much of anything here, but the regular air motion does "
    "indicate that there are several exits."$
Scenery(r_chamberModel,
    "chamber;large,rectangular."
    "rock."
    "passage;open."
    "wall;outer."
    "chamber;middle,of,the."
    "structure;low,building-like,building,like."
    "window;small,horizontal."
    "dust")$
SetThingStatus(r_chamberModel, ts_readonly)$

define tp_deepSewer proc makeChamber(fixed x, y; string name)thing:
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

define tp_deepSewer r_chamberW makeChamber(0.073, 0.495,
    "on the west side of the chamber")$
r_chamberW@p_rDesc :=
    "This is a large rectangular chamber hewn from the rock. There are open "
    "passages on all of the outer walls. The middle of the chamber is filled "
    "with a low building-like structure which has small horizontal windows "
    "but no visible door."$
Connect(r_sewerTunnel38, r_chamberW, D_EAST)$

define tp_deepSewer r_chamberNW makeChamber(0.114, 0.25,
    "in the north-west corner of the chamber")$
Connect(r_chamberW, r_chamberNW, D_NORTH)$
Connect(r_chamberW, r_chamberNW, D_NORTHEAST)$

define tp_deepSewer r_chamberN makeChamber(0.213, 0.215,
    "on the north side of the chamber")$
Connect(r_chamberNW, r_chamberN, D_EAST)$

define tp_deepSewer r_chamberNE makeChamber(0.313, 0.25,
    "in the north-east corner of the chamber")$
Connect(r_chamberN, r_chamberNE, D_EAST)$

define tp_deepSewer r_chamberE makeChamber(0.358, 0.495,
    "on the east side of the chamber")$
Connect(r_chamberNE, r_chamberE, D_SOUTH)$
Connect(r_chamberNE, r_chamberE, D_SOUTHEAST)$

define tp_deepSewer r_chamberSE makeChamber(0.313, 0.74,
    "in the south-east corner of the chamber")$
Connect(r_chamberE, r_chamberSE, D_SOUTH)$
Connect(r_chamberE, r_chamberSE, D_SOUTHWEST)$

define tp_deepSewer r_chamberS makeChamber(0.213, 0.77,
    "on the south side of the chamber")$
Connect(r_chamberSE, r_chamberS, D_WEST)$

define tp_deepSewer r_chamberSW makeChamber(0.114, 0.74,
    "in the south-west corner of the chamber")$
Connect(r_chamberS, r_chamberSW, D_WEST)$
Connect(r_chamberW, r_chamberSW, D_SOUTH)$
Connect(r_chamberW, r_chamberSW, D_SOUTHEAST)$

define tp_deepSewer r_cell CreateThing(r_indoors)$
r_cell@p_rName := "in a small featureless room"$
r_cell@p_rDesc := "There is a small wooden cot against one wall."$
r_cell@p_oSmellString :=
    "The air is fairly close in here, as if the normal occupant hasn't had "
    "a good bath in a very long time."$
r_cell@p_oListenString := "It is pretty quiet in here."$
AutoGraphics(r_cell, AutoOpenRoom)$
AutoPens(r_cell, C_DARK_GREY, C_LIGHT_GREY, C_LIGHT_GREY, 0)$
Scenery(r_cell, "cot;small,wooden")$
SetThingStatus(r_cell, ts_readonly)$

define tp_deepSewer proc makeCell(thing chamber; int dir)thing:
    thing cell;

    cell := CreateThing(r_cell);
    cell@p_rContents := CreateThingList();
    cell@p_rExits := CreateIntList();
    Connect(chamber, cell, dir);
    UniConnect(cell, chamber, D_EXIT);
    SetThingStatus(cell, ts_wizard);
    cell
corp;

ignore makeCell(r_chamberNW, D_WEST)$
ignore makeCell(r_chamberNW, D_NORTH)$
ignore makeCell(r_chamberN, D_NORTH)$
ignore makeCell(r_chamberNE, D_NORTH)$
ignore makeCell(r_chamberNE, D_EAST)$
define tp_deepSewer r_cell1 makeCell(r_chamberSE, D_EAST)$
r_cell1@p_rDesc :=
    "There is a small wooden cot against one wall, and a small hole in the "
    "floor with a ladder leading down."$
Scenery(r_cell1, "cot;small,wooden.ladder.hole;small")$
r_cell1@p_oListenString :=
    "You can hear faint dripping noises coming up from the hole, but other "
    "than that it is fairly quiet in here."$
r_cell1@p_oSmellString :=
    "There is the usual smell of an unwashed body in here, but it isn't as "
    "strong as in the other cells, likely because of the slight breeze "
    "coming through the hole in the floor."$
ignore makeCell(r_chamberSE, D_SOUTH)$
ignore makeCell(r_chamberS, D_SOUTH)$
ignore makeCell(r_chamberSW, D_SOUTH)$
ignore makeCell(r_chamberSW, D_WEST)$

define tp_deepSewer r_sewerTunnel39 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel39, "at the end of a very low tunnel",
    "You can go to the south or up a ladder.")$
Connect(r_cell1, r_sewerTunnel39, D_DOWN)$
Scenery(r_sewerTunnel39, "ladder.hole")$

define tp_deepSewer r_sewerTunnel40 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel40, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel39, r_sewerTunnel40, D_SOUTH)$

define tp_deepSewer r_sewerTunnel41 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel41, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel40, r_sewerTunnel41, D_SOUTH)$

define tp_deepSewer r_sewerTunnel42 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel42, "in a crossing of very low tunnels", "")$
Connect(r_sewerTunnel41, r_sewerTunnel42, D_SOUTH)$

define tp_deepSewer r_sewerTunnel43 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel43, "in a very low east-west tunnel", "")$
Connect(r_sewerTunnel42, r_sewerTunnel43, D_WEST)$

define tp_deepSewer r_sewerTunnel44 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel44,
    "in a north and east corner in the very low tunnel", "")$
Connect(r_sewerTunnel43, r_sewerTunnel44, D_WEST)$

define tp_deepSewer r_sewerTunnel45 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel45, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel44, r_sewerTunnel45, D_NORTH)$

define tp_deepSewer r_sewerTunnel46 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel46, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel45, r_sewerTunnel46, D_NORTH)$

define tp_deepSewer r_sewerTunnel47 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel47, "at the end of a very low tunnel",
    "You can go to the south or up a ladder.")$
Connect(r_sewerTunnel46, r_sewerTunnel47, D_NORTH)$
Scenery(r_sewerTunnel47, "ladder")$

define tp_deepSewer r_sewerBuilding CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerBuilding, "in a small doorless room",
    "This stone room has small horizontal windows looking out into a larger "
    "space with many exits. The only exit from here is down a ladder.")$
Connect(r_sewerTunnel47, r_sewerBuilding, D_UP)$
AutoGraphics(r_sewerBuilding, AutoClosedRoom)$
Scenery(r_sewerBuilding,
    "room;stone.window;small,horizontal.space;larger.ladder")$
define tp_deepSewer proc sewerBuildingEnter(thing room)void:
    if FindName(Me()@p_pCarrying, p_oName, "lamp") = fail then
	DepositClone(r_sewerBuilding, o_oilLamp);
    fi;
corp;
AddAnyEnterAction(r_sewerBuilding, sewerBuildingEnter, false)$

define tp_deepSewer r_sewerTunnel48 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel48, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel42, r_sewerTunnel48, D_SOUTH)$

define tp_deepSewer r_sewerTunnel49 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel49, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel48, r_sewerTunnel49, D_SOUTH)$

define tp_deepSewer r_sewerTunnel50 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel50,
    "in a north and east corner in the very low tunnel", "")$
Connect(r_sewerTunnel49, r_sewerTunnel50, D_SOUTH)$

define tp_deepSewer r_sewerTunnel51 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel51,
    "in a north-south-east Tee in the very low tunnel", "")$
Connect(r_sewerTunnel50, r_sewerTunnel51, D_EAST)$

define tp_deepSewer r_sewerTunnel52 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel52,
    "in a south and east corner in the very low tunnel", "")$
Connect(r_sewerTunnel51, r_sewerTunnel52, D_NORTH)$

define tp_deepSewer r_sewerTunnel53 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel53,
    "in a north and west corner in the very low tunnel", "")$
Connect(r_sewerTunnel52, r_sewerTunnel53, D_EAST)$

define tp_deepSewer r_sewerTunnel54 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel54, "in a very low north-south tunnel", "")$
Connect(r_sewerTunnel53, r_sewerTunnel54, D_NORTH)$

define tp_deepSewer r_sewerTunnel55 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel55,
    "in a south and west corner in the very low tunnel", "")$
Connect(r_sewerTunnel54, r_sewerTunnel55, D_NORTH)$

define tp_deepSewer r_sewerTunnel56 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel56, "in a very low east-west tunnel", "")$
Connect(r_sewerTunnel55, r_sewerTunnel56, D_WEST)$
Connect(r_sewerTunnel42, r_sewerTunnel56, D_EAST)$

define tp_deepSewer r_sewerTunnel57 CreateThing(r_provingTunnelD)$
SetupRoomP(r_sewerTunnel57, "at the south end of the very low tunnel",
    "A tiny, badly carved crawlway heads off to the southwest.")$
Connect(r_sewerTunnel51, r_sewerTunnel57, D_SOUTH)$
Scenery(r_sewerTunnel57, "crawlway;tiny,badly,carved")$
define tp_deepSewer PR_TUNNEL57_ID NextEffectId()$
define tp_deepSewer proc drawTunnel57()void:

    if not KnowsEffect(nil, PR_TUNNEL57_ID) then
	DefineEffect(nil, PR_TUNNEL57_ID);
	GSetImage(nil, "Proving/tunnel57");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.5, 1.0, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 0.25, 0.497);
	    GEllipse(nil, 0.04375, 0.08, true);
	    GAMove(nil, 0.208, 0.0);
	    GRectangle(nil, 0.086, 0.5, true);
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.999);
	    GADraw(nil, 0.022, 0.999);
	    GADraw(nil, 0.261, 0.53);
	    GADraw(nil, 0.244, 0.465);
	    GADraw(nil, 0.0, 0.94);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_TUNNEL57_ID);
corp;
AutoGraphics(r_sewerTunnel57, drawTunnel57)$

define tp_deepSewer r_goblinCityTunnel CreateThing(r_provingTunnel2)$
r_goblinCityTunnel@p_oListenString := "You can't hear much of anything here."$
r_goblinCityTunnel@p_oSmellString := "You can't smell much of anything here."$
SetThingStatus(r_goblinCityTunnel, ts_readonly)$

define tp_deepSewer r_sewerTunnel58 CreateThing(r_goblinCityTunnel)$
SetupRoomP(r_sewerTunnel58, "in a well-used tunnel crossing", "")$
Connect(r_chamberE, r_sewerTunnel58, D_EAST)$

define tp_deepSewer PR_CHAMBER6_ID NextEffectId()$
define tp_deepSewer proc drawChamber6()void:

    if not KnowsEffect(nil, PR_CHAMBER6_ID) then
	DefineEffect(nil, PR_CHAMBER6_ID);
	GSetImage(nil, "Proving/chamber6");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.499, 1.0, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 0.03125, 0.1);
	    GRectangle(nil, 0.434, 0.79, true);
	    GAMove(nil, 0.0, 0.45);
	    GRectangle(nil, 0.499, 0.1, true);
	    GAMove(nil, 0.103, 0.0);
	    GRectangle(nil, 0.03125, 1.0, true);
	    GAMove(nil, 0.234, 0.0);
	    GRectangle(nil, 0.03125, 1.0, true);
	    GAMove(nil, 0.366, 0.0);
	    GRectangle(nil, 0.03125, 1.0, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER6_ID);
corp;

define tp_deepSewer CHAMBER6_MAP_GROUP NextMapGroup()$

define tp_deepSewer r_chamber6Model CreateThing(r_provingTunnel2)$
RoomName(r_chamber6Model, "Large", "Chamber")$
r_chamber6Model@p_MapGroup := CHAMBER6_MAP_GROUP$
r_chamber6Model@p_rDrawAction := drawChamber6$
r_chamber6Model@p_rEnterRoomDraw := EnterRoomDraw$
r_chamber6Model@p_rLeaveRoomDraw := LeaveRoomDraw$
r_chamber6Model@p_oSmellString :=
    "You smell nothing special here, other than the usual tang of "
    "unwashed bodies."$
r_chamber6Model@p_oListenString :=
    "It is fairly quiet here, but again there is evidence of good airflow "
    "through this chamber."$
SetThingStatus(r_chamber6Model, ts_readonly)$

define tp_deepSewer proc makeChamber2(fixed x, y; string name)thing:
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

define tp_deepSewer r_chamber6W makeChamber2(0.117, 0.495,
    "on the west side of the chamber")$
Connect(r_sewerTunnel58, r_chamber6W, D_EAST)$

define tp_deepSewer r_chamber6NW makeChamber2(0.117, 0.17,
    "in the north-west corner of the chamber")$
Connect(r_chamber6W, r_chamber6NW, D_NORTH)$

define tp_deepSewer r_chamber6N makeChamber2(0.247, 0.17,
    "on the north side of the chamber")$
Connect(r_chamber6NW, r_chamber6N, D_EAST)$
Connect(r_chamber6W, r_chamber6N, D_NORTHEAST)$

define tp_deepSewer r_chamber6NE makeChamber2(0.38, 0.17,
    "in the north-east corner of the chamber")$
Connect(r_chamber6N, r_chamber6NE, D_EAST)$

define tp_deepSewer r_chamber6E makeChamber2(0.38, 0.495,
    "on the west side of the chamber")$
Connect(r_chamber6NE, r_chamber6E, D_SOUTH)$
Connect(r_chamber6N, r_chamber6E, D_SOUTHEAST)$

define tp_deepSewer r_chamber6SE makeChamber2(0.38, 0.81,
    "in the south-east corner of the chamber")$
Connect(r_chamber6E, r_chamber6SE, D_SOUTH)$

define tp_deepSewer r_chamber6S makeChamber2(0.247, 0.81,
    "on the south side of the chamber")$
Connect(r_chamber6SE, r_chamber6S, D_WEST)$
Connect(r_chamber6E, r_chamber6S, D_SOUTHWEST)$
Connect(r_chamber6W, r_chamber6S, D_SOUTHEAST)$

define tp_deepSewer r_chamber6SW makeChamber2(0.117, 0.81,
    "in the south-west corner of the chamber")$
Connect(r_chamber6S, r_chamber6SW, D_WEST)$
Connect(r_chamber6W, r_chamber6SW, D_SOUTH)$

define tp_deepSewer r_chamber6Center makeChamber2(0.247, 0.495,
    "in the middle of the chamber")$
Connect(r_chamber6W, r_chamber6Center, D_EAST)$
Connect(r_chamber6NW, r_chamber6Center, D_SOUTHEAST)$
Connect(r_chamber6N, r_chamber6Center, D_SOUTH)$
Connect(r_chamber6NE, r_chamber6Center, D_SOUTHWEST)$
Connect(r_chamber6E, r_chamber6Center, D_WEST)$
Connect(r_chamber6SE, r_chamber6Center, D_NORTHWEST)$
Connect(r_chamber6S, r_chamber6Center, D_NORTH)$
Connect(r_chamber6SW, r_chamber6Center, D_NORTHEAST)$

ignore DeleteSymbol(tp_deepSewer, "makeChamber")$

define tp_deepSewer r_goblinArmoury CreateThing(r_indoors)$
SetupRoomP(r_goblinArmoury, "in a goblin armoury",
    "The goblins may not be the friendliest folks when you meet them in "
    "distant tunnels, but they certainly are fine craftsmen. The weapons "
    "and armour for sale here (even to non-goblins!) are all fine items.")$
AutoGraphics(r_goblinArmoury, AutoOpenRoom)$
AutoPens(r_goblinArmoury, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
Connect(r_chamber6NE, r_goblinArmoury, D_NORTH)$
UniConnect(r_goblinArmoury, r_chamber6NE, D_EXIT)$
MakeStore(r_goblinArmoury)$
r_goblinArmoury@p_Image := "Proving/goblinArmoury"$

define tp_proving o_goblinSword WeaponSell(r_goblinArmoury, "sword;goblin",
    "The goblin sword is a good weapon. Its feel is a bit strange, and you "
    "can't read the runes carved into it, but you can handle it just fine.",
    300, 1, 0, 1, 0, 0, 8, 13)$
o_goblinSword@p_Image := "Proving/goblinSword"$

WeaponSell(r_goblinArmoury, "axe;goblin",
    "The goblin axe is not very big, but makes an effective weapon. The "
    "handle is a bit large for you, but the weight of the head and the "
    "length of the handle more than compensate.",
    150, 1, 0, 0, 0, 0, 12, 9)@p_Image := "Proving/goblinAxe"$

WeaponSell(r_goblinArmoury, "armour;goblin,leather",
    "The goblins make good armour - this one is made of thick boiled leather "
    "reinforced with numerous tiny rivets, and embellished with strange "
    "carvings and some shoulder spikes. It doesn't fit very well, however.",
    250, 0, 0, -1, -3, 0, 0, 0)@p_Image := "Proving/goblinLeatherArmour"$

WeaponSell(r_goblinArmoury, "mail;goblin,chain.chain",
    "This is another example of fine goblin workmanship. However, since it "
    "was made for a goblin, it doesn't fit you very well.",
    900, -1, 0, -1, -5, 0, 0, 0)@p_Image := "Proving/goblinChainMail"$

WeaponSell(r_goblinArmoury, "mail;goblin,plate.plate",
    "This plate mail is fairly adjustable, so even though it was made for a "
    "goblin, it works well for you. There are some runes carved on the "
    "inside of each piece - perhaps they are for luck.",
    4000, 0, 1, 1, -6, 0, 0, 0)@p_Image := "Proving/goblinPlateMail"$

define tp_deepSewer r_goblinHealer CreateThing(r_indoors)$
SetupRoomP(r_goblinHealer, "in a goblin apothecary",
    "The goblin running this establishment is a rare item indeed - he is "
    "willing, for money, to help others out. He will sell you healing, "
    "just like the fellow aboveground. His establishment is little more "
    "than a literal hole-in-the-wall, but he seems to know his trade.")$
AutoGraphics(r_goblinHealer, AutoOpenRoom)$
AutoPens(r_goblinHealer, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
Connect(r_chamber6NW, r_goblinHealer, D_NORTH)$
UniConnect(r_goblinHealer, r_chamber6NW, D_EXIT)$
HealSell(r_goblinHealer, "heal;minor.minor", 20, 6)$
HealSell(r_goblinHealer, "heal;small.small", 40, 15)$
HealSell(r_goblinHealer, "heal;medium.medium", 100, 40)$
HealSell(r_goblinHealer, "heal;large.large", 350, 140)$
HealSell(r_goblinHealer, "heal;great.great", 1000, 500)$
r_goblinHealer@p_rBuyAction := HealingBuy$
r_goblinHealer@p_Image := "Proving/goblinHealer"$

define tp_deepSewer r_goblinStore CreateThing(r_indoors)$
SetupRoomP(r_goblinStore, "in a goblin store",
    "This store is a medium-sized hole carved out of the rock, with some "
    "wooden shelves holding the merchandise. The stock here is pretty "
    "limited, but there are lots of each item that is for sale.")$
AutoGraphics(r_goblinStore, AutoOpenRoom)$
AutoPens(r_goblinStore, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
Scenery(r_goblinStore, "shelf,shelves.merchandise.stock")$
r_goblinStore@p_Image := "Proving/goblinStore"$
Connect(r_chamber6SE, r_goblinStore, D_SOUTH)$
UniConnect(r_goblinStore, r_chamber6SE, D_EXIT)$
MakeStore(r_goblinStore)$
AddObjectForSale(r_goblinStore, CreateThing(o_torch), 15, nil)$
AddObjectForSale(r_goblinStore, CreateThing(o_sack), 30, nil)$
AddObjectForSale(r_goblinStore, CreateThing(o_refill), 75, nil)$
WeaponSell(r_goblinStore, "shield;troll-hide.shield;troll,hide",
    "The troll-hide shield, being made from the hide of a cave troll, "
    "is much stronger than a regular hide shield.",
    100, 0, 0, 0, 0, -2, 0, 0)@p_Image := "Proving/troll-hideShield"$

define tp_deepSewer o_mushroom AddForSale(r_goblinStore, "mushroom;healing",
    "", 25, nil)$
define tp_deepSewer proc mushroomEat()status:
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
	OPrint(Capitalize(CharacterNameG(me)) + " eats a mushroom.\n");
    fi;
    ClearThing(th);
    DelElement(me@p_pCarrying, th);
    succeed
corp;
o_mushroom@p_oEatChecker := mushroomEat$
o_mushroom@p_oSmellString :=
    "The mushroom smells a lot like a normal mushroom, but there is an "
    "added tang to the odour."$
o_mushroom@p_oTouchString :=
    "The mushroom is a bit past its prime, so it is a little bit soft, "
    "but it is still edible."$
o_mushroom@p_Image := "Proving/mushroom"$

define tp_deepSewer p_oMapImage CreateStringProp()$
define tp_deepSewer proc readMap()string:
    if GOn(nil) then
	ShowImage(It()@p_oMapImage);
    else
	Print("With graphics enabled, you would see the map itself.\n");
    fi;
    "The map has some lines and dots drawn on it."
corp;

define tp_deepSewer o_map1 AddForSale(r_goblinStore, "map;lower",
    "The map is a piece of parchment with lines and dots drawn on it.",
    100, nil)$
o_map1@p_oMapImage := "Proving/map1"$
o_map1@p_oReadAction := readMap$

define tp_deepSewer o_map2 AddForSale(r_goblinStore, "map;upper",
    "The map is a piece of parchment with lines and dots drawn on it.",
    100, nil)$
o_map2@p_oMapImage := "Proving/map2"$
o_map2@p_oReadAction := readMap$

define tp_deepSewer r_goblinRoom CreateThing(r_indoors)$
SetupRoomP(r_goblinRoom, "in an unused room", "")$
AutoGraphics(r_goblinRoom, AutoOpenRoom)$
AutoPens(r_goblinRoom, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
Connect(r_chamber6SW, r_goblinRoom, D_SOUTH)$
UniConnect(r_goblinRoom, r_chamber6SW, D_EXIT)$

define tp_deepSewer r_provingTunnel3 CreateThing(r_goblinCityTunnel)$
define tp_deepSewer proc drawTunnel3()void:
    thing here;
    list int exits;

    AutoTunnels();
    here := Here();
    exits := here@p_rExits;
    GSetPen(nil, C_BROWN);
    if here@p_rNorth ~= nil and FindElement(exits, D_NORTH) = -1 then
	GAMove(nil, 0.237, 0.42);
	HorizontalDoor();
    fi;
    if here@p_rEast ~= nil and FindElement(exits, D_EAST) = -1 then
	GAMove(nil, 0.295, 0.46);
	VerticalDoor();
    fi;
    if here@p_rSouth ~= nil and FindElement(exits, D_SOUTH) = -1 then
	GAMove(nil, 0.237, 0.58);
	HorizontalDoor();
    fi;
    if here@p_rWest ~= nil and FindElement(exits, D_WEST) = -1 then
	GAMove(nil, 0.206, 0.46);
	VerticalDoor();
    fi;
corp;
AutoGraphics(r_provingTunnel3, drawTunnel3)$
AutoPens(r_provingTunnel3, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
SetThingStatus(r_provingTunnel3, ts_wizard)$

define tp_deepSewer r_sewerTunnel59 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel59, "at a tunnel tee", "")$
Connect(r_chamber6E, r_sewerTunnel59, D_EAST)$

define tp_deepSewer r_sewerTunnel60 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel60, "in a north-south tunnel", "")$
Connect(r_sewerTunnel59, r_sewerTunnel60, D_NORTH)$

define tp_deepSewer r_sewerTunnel61 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel61, "at a south/west corner", "")$
Connect(r_sewerTunnel60, r_sewerTunnel61, D_NORTH)$

define tp_deepSewer r_sewerTunnel62 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel62, "in an east-west tunnel", "")$
Connect(r_sewerTunnel61, r_sewerTunnel62, D_WEST)$

define tp_deepSewer r_sewerTunnel63 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel63, "at a tunnel tee", "")$
Connect(r_sewerTunnel62, r_sewerTunnel63, D_WEST)$
Connect(r_chamber6N, r_sewerTunnel63, D_NORTH)$

define tp_deepSewer r_sewerTunnel64 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel64, "in an east-west tunnel", "")$
Connect(r_sewerTunnel63, r_sewerTunnel64, D_WEST)$

define tp_deepSewer r_sewerTunnel65 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel65, "at a south/east corner", "")$
Connect(r_sewerTunnel64, r_sewerTunnel65, D_WEST)$

define tp_deepSewer r_sewerTunnel66 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel66, "in a north-south tunnel", "")$
Connect(r_sewerTunnel65, r_sewerTunnel66, D_SOUTH)$
Connect(r_sewerTunnel58, r_sewerTunnel66, D_NORTH)$

define tp_deepSewer r_sewerTunnel67 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel67, "in a north-south tunnel", "")$
Connect(r_sewerTunnel58, r_sewerTunnel67, D_SOUTH)$

define tp_deepSewer r_sewerTunnel68 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel68, "at a north/east corner", "")$
Connect(r_sewerTunnel67, r_sewerTunnel68, D_SOUTH)$

define tp_deepSewer r_sewerTunnel69 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel69, "in an east-west tunnel", "")$
Connect(r_sewerTunnel68, r_sewerTunnel69, D_EAST)$

define tp_deepSewer r_sewerTunnel70 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel70, "at a tunnel tee", "")$
Connect(r_sewerTunnel69, r_sewerTunnel70, D_EAST)$
Connect(r_chamber6S, r_sewerTunnel70, D_SOUTH)$

define tp_deepSewer r_sewerTunnel71 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel71, "in an east-west tunnel", "")$
Connect(r_sewerTunnel70, r_sewerTunnel71, D_EAST)$

define tp_deepSewer r_sewerTunnel72 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel72, "at a north/west corner", "")$
Connect(r_sewerTunnel71, r_sewerTunnel72, D_EAST)$

define tp_deepSewer r_sewerTunnel73 CreateThing(r_provingTunnel3)$
SetupRoomP(r_sewerTunnel73, "in a north-south tunnel", "")$
Connect(r_sewerTunnel72, r_sewerTunnel73, D_NORTH)$
Connect(r_sewerTunnel59, r_sewerTunnel73, D_SOUTH)$

define tp_deepSewer r_shaman CreateThing(r_indoors)$
SetupRoomP(r_shaman, "in the shaman's room",
    "The goblin shaman offers a few strange items for sale. His room is "
    "little different from the others around it.")$
RoomName(r_shaman, "Shaman's", "Room")$
AutoGraphics(r_shaman, AutoClosedRoom)$
AutoPens(r_shaman, C_DARK_GREY, C_LIGHT_GREY, C_BLACK, C_BROWN)$
Scenery(r_shaman,
    "cot;wooden."
    "table;sturdy,wooden."
    "chair;pair,of,unpadded."
    "chest;small,clothes."
    "furniture,furnishing;sparse")$
r_shaman@p_Image := "Proving/shaman"$
HUniConnect(r_sewerTunnel64, r_shaman, D_SOUTH)$
UniConnect(r_shaman, r_sewerTunnel64, D_NORTH)$
UniConnect(r_shaman, r_sewerTunnel64, D_EXIT)$
MakeStore(r_shaman)$
define tp_deepSewer proc drinkPotion(thing me, it; string reaction)void:

    Print(reaction + "! That was awful!\n");
    if not me@p_pHidden then
	OPrint(Capitalize(CharacterNameG(me)) +
	    " drinks an unpleasant potion.\n");
    else
	OPrint("You hear a gagging sound.\n");
    fi;
    AddTail(me@p_pHiddenList, it);
    DelElement(me@p_pCarrying, it);
corp;
define tp_deepSewer o_strengthPotion AddForSale(r_shaman, "potion;strength",
    "The strength potion comes in a small red bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil)$
define tp_deepSewer proc strengthCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pStrength := who@p_pStrength - 1;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_deepSewer proc strengthDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pStrength := me@p_pStrength + 1;
    drinkPotion(me, it, "Yuck");
    DoAfter(10 * 60, it, strengthCancel);
    succeed
corp;
o_strengthPotion@p_oEatChecker := strengthDrink$
o_strengthPotion@p_Image := "Proving/strengthPotion"$
define tp_deepSewer o_speedPotion AddForSale(r_shaman, "potion;speed",
    "The speed potion comes in a small green bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil)$
define tp_deepSewer proc speedCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pSpeed := who@p_pSpeed - 1;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_deepSewer proc speedDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pSpeed := me@p_pSpeed + 1;
    drinkPotion(me, it, "Yech");
    DoAfter(10 * 60, it, speedCancel);
    succeed
corp;
o_speedPotion@p_oEatChecker := speedDrink$
o_speedPotion@p_Image := "Proving/speedPotion"$
define tp_deepSewer o_excessPotion AddForSale(r_shaman, "potion;excess",
    "The excess potion comes in a small blue bottle. It appears to contain "
    "enough of the potion for one dose.",
    1000, nil)$
define tp_deepSewer proc excessCancel(thing th)void:
    thing who;

    who := th@p_oConsumer;
    who@p_pHitMax := who@p_pHitMax - 10;
    ClearThing(th);
    DelElement(who@p_pHiddenList, th);
    SPrint(who, "You suddenly feel let down.\n");
corp;
define tp_deepSewer proc excessDrink()status:
    thing me, it;

    me := Me();
    it := It();
    it@p_oConsumer := me;
    me@p_pHitMax := me@p_pHitMax + 10;
    drinkPotion(me, it, "Ug");
    DoAfter(60 * 60, it, excessCancel);
    succeed
corp;
o_excessPotion@p_oEatChecker := excessDrink$
o_excessPotion@p_Image := "Proving/excessPotion"$

define tp_deepSewer r_cell2 CreateThing(r_indoors)$
r_cell2@p_rName := "in a featureless room"$
r_cell2@p_rDesc :=
    "The room is sparsely furnished with a wooden cot, a sturdy wooden "
    "table with a pair of unpadded chairs, and a small clothes chest."$
r_cell2@p_oListenString := "It is nicely quiet in here."$
r_cell2@p_oSmellString :=
    "It is a bit close and stuffy in here, but not too bad."$
AutoGraphics(r_cell2, AutoClosedRoom)$
AutoPens(r_cell2, C_DARK_GREY, C_LIGHT_GREY, C_BLACK, C_BROWN)$
Scenery(r_cell2,
    "cot;wooden,wood."
    "table;sturdy,wooden,wood."
    "chair;pair,of,unpadded."
    "chest;small clothes."
    "furniture,furnishing;sparse")$
SetThingStatus(r_cell2, ts_readonly)$

define tp_deepSewer proc makeCell2(thing tunnel; int dir)thing:
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

ignore makeCell2(r_sewerTunnel59, D_EAST)$
ignore makeCell2(r_sewerTunnel60, D_EAST)$
ignore makeCell2(r_sewerTunnel60, D_WEST)$
ignore makeCell2(r_sewerTunnel61, D_EAST)$
ignore makeCell2(r_sewerTunnel61, D_NORTH)$
ignore makeCell2(r_sewerTunnel62, D_NORTH)$
ignore makeCell2(r_sewerTunnel62, D_SOUTH)$
ignore makeCell2(r_sewerTunnel63, D_NORTH)$
ignore makeCell2(r_sewerTunnel64, D_NORTH)$
ignore makeCell2(r_sewerTunnel65, D_NORTH)$
ignore makeCell2(r_sewerTunnel65, D_WEST)$
ignore makeCell2(r_sewerTunnel66, D_EAST)$
ignore makeCell2(r_sewerTunnel66, D_WEST)$
ignore makeCell2(r_sewerTunnel67, D_EAST)$
ignore makeCell2(r_sewerTunnel67, D_WEST)$
ignore makeCell2(r_sewerTunnel68, D_WEST)$
ignore makeCell2(r_sewerTunnel68, D_SOUTH)$
ignore makeCell2(r_sewerTunnel69, D_NORTH)$
ignore makeCell2(r_sewerTunnel69, D_SOUTH)$
ignore makeCell2(r_sewerTunnel70, D_SOUTH)$
ignore makeCell2(r_sewerTunnel71, D_NORTH)$
ignore makeCell2(r_sewerTunnel71, D_SOUTH)$
ignore makeCell2(r_sewerTunnel72, D_SOUTH)$
ignore makeCell2(r_sewerTunnel72, D_EAST)$
ignore makeCell2(r_sewerTunnel73, D_EAST)$
ignore makeCell2(r_sewerTunnel73, D_WEST)$

ignore DeleteSymbol(tp_deepSewer, "makeCell2")$

define tp_deepSewer r_crawlway CreateThing(r_tunnel)$
AutoGraphics(r_crawlway, AutoPaths)$
AutoPens(r_crawlway, C_DARK_GREY, C_LIGHT_GREY, 0, 0)$
r_crawlway@p_rName := "in a winding crawlway"$
r_crawlway@p_rDark := true$
r_crawlway@p_oListenString := "It is very quiet in this little crawlway!"$
r_crawlway@p_oSmellString :=
    "There is a fairly strong smell of unwashed bodies, mixed with other "
    "less pleasant things, here."$
SetThingStatus(r_crawlway, ts_readonly)$
monsterSet3(r_crawlway)$

define tp_deepSewer proc makeCrawlway(thing previous; int dir)thing:
    thing crawlway;

    crawlway := CreateThing(r_crawlway);
    crawlway@p_rContents := CreateThingList();
    crawlway@p_rExits := CreateIntList();
    Connect(previous, crawlway, dir);
    SetThingStatus(crawlway, ts_wizard);
    crawlway
corp;

define tp_deepSewer r_crawlway1 makeCrawlway(r_sewerTunnel57, D_SOUTHWEST)$

define tp_deepSewer r_crawlway2 makeCrawlway(r_crawlway1, D_WEST)$

define tp_deepSewer r_crawlway3 makeCrawlway(r_crawlway2, D_SOUTHWEST)$
r_crawlway3@p_rDesc := "You can smell something bad nearby."$
r_crawlway3@p_oSmellString := "Yes, definitely something rotten around here."$

define tp_deepSewer r_sewerChamber5 CreateThing(r_crawlway)$
SetupRoomP(r_sewerChamber5, "in a goblin hideout",
    "The hideout is littered with just about every unmentionable thing you "
    "can think of. Small crawlways lead off in several directions.")$
Connect(r_crawlway3, r_sewerChamber5, D_WEST)$
define tp_deepSewer PR_CHAMBER5_ID NextEffectId()$
define tp_deepSewer proc drawChamber5()void:

    if not KnowsEffect(nil, PR_CHAMBER5_ID) then
	DefineEffect(nil, PR_CHAMBER5_ID);
	GSetImage(nil, "Proving/chamber5");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    DrawTunnelChamber(C_DARK_GREY, C_LIGHT_GREY);
	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.06);
	    GADraw(nil, 0.33, 0.55);
	    GADraw(nil, 0.28, 0.57);
	    GADraw(nil, 0.478, 0.0);
	    GPolygonEnd(nil);
	    GAMove(nil, 0.252, 0.46);
	    GRectangle(nil, 0.248, 0.08, true);
	    GAMove(nil, 0.234, 0.5);
	    GRectangle(nil, 0.03125, 0.499, true);
	    GAMove(nil, 0.0, 0.46);
	    GRectangle(nil, 0.25, 0.08, true);
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.0);
	    GADraw(nil, 0.025, 0.0);
	    GADraw(nil, 0.2, 0.5);
	    GADraw(nil, 0.175, 0.55);
	    GADraw(nil, 0.0, 0.06);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CHAMBER5_ID);
corp;
AutoGraphics(r_sewerChamber5, drawChamber5)$
Scenery(r_sewerChamber5, "thing;unmentionable")$
r_sewerChamber5@p_oSmellString :=
    "The smell of rotten meat, rotten vegetables, rotten breath and rotten "
    "bodies is nearly overpowering!"$
r_sewerChamber5@p_oListenString :=
    "The loudest sounds here are those of your breathing and of your "
    "stomache objecting to the stench!"$
r_sewerChamber5@p_rLastVisit := 0$
define tp_deepSewer proc chamber5Enter(thing room)void:
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
AddAnyEnterAction(r_sewerChamber5, chamber5Enter, false)$

define tp_deepSewer r_crawlway4 makeCrawlway(r_sewerChamber5, D_NORTHEAST)$

define tp_deepSewer r_crawlway5 makeCrawlway(r_sewerChamber5, D_SOUTH)$

define tp_deepSewer r_crawlway6 makeCrawlway(r_crawlway5, D_WEST)$

define tp_deepSewer r_crawlway7 makeCrawlway(r_crawlway5, D_SOUTHWEST)$

define tp_deepSewer r_crawlway8 makeCrawlway(r_crawlway7, D_SOUTH)$

define tp_deepSewer r_crawlway9 makeCrawlway(r_crawlway8, D_NORTHWEST)$

define tp_deepSewer r_crawlway10 makeCrawlway(r_crawlway9, D_NORTH)$

define tp_deepSewer r_crawlway11 makeCrawlway(r_crawlway10, D_NORTHEAST)$
Connect(r_sewerChamber5, r_crawlway11, D_WEST)$

define tp_deepSewer r_crawlway12 makeCrawlway(r_sewerChamber5, D_NORTHWEST)$

define tp_deepSewer r_crawlway13 makeCrawlway(r_crawlway12, D_WEST)$

define tp_deepSewer r_crawlway14 makeCrawlway(r_crawlway13, D_NORTHWEST)$

define tp_deepSewer r_crawlway15 makeCrawlway(r_crawlway14, D_SOUTHWEST)$

define tp_deepSewer r_crawlway16 makeCrawlway(r_crawlway15, D_SOUTHWEST)$

ignore DeleteSymbol(tp_deepSewer, "makeCrawlway")$

define tp_proving r_crawlway17 CreateThing(r_crawlway)$
SetupRoomP(r_crawlway17, "at the end of a crawlway",
    "You are high up on the north wall of a large cavern. You can drop down "
    "to the cavern floor, but you would not be able to get back up.")$
r_crawlway17@p_oSmellString :=
    "The usual smell of these crawlways has finally faded out."$
r_crawlway17@p_oListenString := "You can hear water dripping below."$
Connect(r_crawlway16, r_crawlway17, D_SOUTH)$
Scenery(r_crawlway17, "cavern;large.wall;north.floor;cavern")$

unuse tp_deepSewer
