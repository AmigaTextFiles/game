/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * proving3.m - caves level of the proving grounds.
 */

private tp_proving3 CreateTable().
use tp_proving3

define tp_proving proc monsterSet4(thing room)void:

    InitMonsterModels(room, 500);
    AddPossibleMonster(room, m_hugeRat, 25);
    AddPossibleMonster(room, m_hugeSnake, 25);
    AddPossibleMonster(room, m_fighterGoblin, 25);
    AddPossibleMonster(room, m_hugeSpider, 25);
    AddPossibleMonster(room, m_troll, 25);
    AddPossibleMonster(room, m_largeRat, 25);
    AddPossibleMonster(room, m_largeSnake, 25);
    AddPossibleMonster(room, m_goblin, 25);
corp;

define tp_proving r_provingCave CreateThing(r_tunnel).
r_provingCave@p_rDark := true.
AutoGraphics(r_provingCave, AutoTunnels).
AutoPens(r_provingCave, C_DARK_GREY, C_LIGHT_GREY, C_LIGHT_GREY, C_LIGHT_GREY).
SetThingStatus(r_provingCave, ts_readonly).
monsterSet4(r_provingCave).

define tp_proving3 r_sewerCave1 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave1, "in a rough cave passage leading to the northwest",
    "You can climb a rock up through the cave roof here.").
RoomName(r_sewerCave1, "Cave", "Passage").
HUniConnect(r_sewerChamber2, r_sewerCave1, D_DOWN).
UniConnect(r_sewerCave1, r_sewerChamber2, D_UP).
r_sewerCave1@p_rUpMessage :=
    "It's a bit of a scramble, but you are able to climb up the rock and "
    "through a hole in the cave roof.".
r_sewerCave1@p_rUpOMessage :=
    "scrambles up a rock and through a hole in the cave roof.".

define tp_proving3 r_sewerCave2 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave2, "in a southwest/southeast cave passage corner", "").
Connect(r_sewerCave1, r_sewerCave2, D_NORTHWEST).
RoomName(r_sewerCave2, "Passage", "Corner").

define tp_proving3 r_sewerCave3 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave3, "in a rough cave passage leading to the northeast",
    "A hole in the floor here leads down to a large cavern.").
Connect(r_sewerCave2, r_sewerCave3, D_SOUTHWEST).
RoomName(r_sewerCave3, "Cave", "Passage").
r_sewerCave3@p_rDownMessage := "You drop down through the hole.".
r_sewerCave3@p_rDownOMessage := "drops down through the hole.".

define tp_proving3 PR_CAVERN_ID NextEffectId().
define tp_proving3 proc drawCavern()void:

    if not KnowsEffect(nil, PR_CAVERN_ID) then
	DefineEffect(nil, PR_CAVERN_ID);
	GSetImage(nil, "pr_cavern");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 25, 10);
	    GRDraw(nil, 52, 0);
	    GRDraw(nil, 0, -10);
	    GRDraw(nil, 6, 0);
	    GRDraw(nil, 0, 10);
	    GRDraw(nil, 52, 0);
	    GRDraw(nil, 15, 15);
	    GRDraw(nil, 0, 22);
	    GRDraw(nil, 9, 8);
	    GRDraw(nil, 0, 6);
	    GRDraw(nil, -9, -8);
	    GRDraw(nil, 0, 24);
	    GRDraw(nil, 9, 0);
	    GRDraw(nil, 0, 13);
	    GRDraw(nil, -134, 0);
	    GRDraw(nil, -15, -15);
	    GRDraw(nil, 0, -22);
	    GRDraw(nil, -10, 0);
	    GRDraw(nil, 0, -6);
	    GRDraw(nil, 10, 0);
	    GRDraw(nil, 0, -22);
	    GPolygonEnd(nil);

	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 60, 50);
	    GEllipse(nil, 20, 15, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CAVERN_ID);
corp;

define tp_proving3 CAVERN_MAP_GROUP NextMapGroup().

define tp_proving3 r_cavernModel CreateThing(r_tunnel).
r_cavernModel@p_rName := "in a large cavern".
r_cavernModel@p_rDark := true.
r_cavernModel@p_rName1 := "Large".
r_cavernModel@p_rName2 := "Cavern".
r_cavernModel@p_MapGroup := CAVERN_MAP_GROUP.
r_cavernModel@p_rDrawAction := drawCavern.
r_cavernModel@p_rEnterRoomDraw := EnterRoomDraw.
r_cavernModel@p_rLeaveRoomDraw := LeaveRoomDraw.
Scenery(r_cavernModel, "boulder;large.slope;rock,strewn.rock.").
monsterSet4(r_cavernModel).
SetThingStatus(r_cavernModel, ts_readonly).

define tp_proving3 proc makeCavern(int x, y; string desc)thing:
    thing cavern;

    cavern := CreateThing(r_cavernModel);
    cavern@p_rDesc := desc;
    cavern@p_rContents := CreateThingList();
    cavern@p_rExits := CreateIntList();
    cavern@p_rCursorX := x;
    cavern@p_rCursorY := y;
    SetThingStatus(cavern, ts_wizard);
    cavern
corp;

define tp_proving3 r_largeCavern1 makeCavern(134, 15,
    "You can go down a rough, rock-strewn slope to the west, or along the "
    "top of the slope to the south.").
UniConnect(r_sewerCave3, r_largeCavern1, D_DOWN).
HUniConnect(r_largeCavern1, r_sewerCave3, D_UP).
r_largeCavern1@p_rUpMessage :=
    "You are able to climb up on a rock and through a hole above.".
r_largeCavern1@p_rUpOMessage := "climbs up a rock and disappears above it.".

define tp_proving3 r_largeCavern2 makeCavern(77, 15,
    "You are in the middle of the northern wall of the cavern. The floor "
    "slopes up to the east and down to the west, and you can also go across "
    "the slope to the south. There is a fissure in the wall, into which "
    "you can fit.").
Connect(r_largeCavern1, r_largeCavern2, D_WEST).
HConnect(r_largeCavern1, r_largeCavern2, D_DOWN).
UniConnect(r_crawlway17, r_largeCavern2, D_DOWN).
Scenery(r_largeCavern2, "fissure").

define tp_proving3 r_largeCavern3 makeCavern(21, 15,
    "You are the bottom northwest corner of the cavern.").
Connect(r_largeCavern2, r_largeCavern3, D_WEST).
HConnect(r_largeCavern2, r_largeCavern3, D_DOWN).

define tp_proving3 r_largeCavern4 makeCavern(137, 47,
    "You are in the middle of the upper, east wall of the cavern. A small "
    "crawlway in the wall heads to the southeast.").
Connect(r_largeCavern1, r_largeCavern4, D_SOUTH).
Connect(r_largeCavern2, r_largeCavern4, D_SOUTHEAST).
Scenery(r_largeCavern4, "crawlway").

define tp_proving3 r_largeCavern5 makeCavern(80, 47,
    "You are in the middle of the cavern. From here, you can barely see the "
    "walls, but the roof is clearly visible, since it slopes downward here. "
    "You can climb on a large boulder here to get a better view.").
Connect(r_largeCavern4, r_largeCavern5, D_WEST).
HUniConnect(r_largeCavern4, r_largeCavern5, D_DOWN).
Connect(r_largeCavern2, r_largeCavern5, D_SOUTH).
Connect(r_largeCavern3, r_largeCavern5, D_SOUTHEAST).
Connect(r_largeCavern1, r_largeCavern5, D_SOUTHWEST).

define tp_proving3 r_cavernBoulder makeCavern(58, 47,
    "You have to crouch here since the cavern roof is quite low overhead. "
    "You can't really see much more here than you could from beside the "
    "boulder, but your added height does allow you to see a small passage "
    "leading off from the northeast corner that should be reachable by "
    "climbing a boulder there.").
r_cavernBoulder@p_rName := "on a boulder in a large cavern".
Connect(r_largeCavern5, r_cavernBoulder, D_UP).

define tp_proving3 r_largeCavern6 makeCavern(19, 47,
    "You are in the middle of the lower, west wall of the cavern. A small "
    "crawlway in the wall heads further west.").
Connect(r_largeCavern5, r_largeCavern6, D_WEST).
HConnect(r_largeCavern5, r_largeCavern6, D_DOWN).
Connect(r_largeCavern3, r_largeCavern6, D_SOUTH).
Connect(r_largeCavern2, r_largeCavern6, D_SOUTHWEST).
Scenery(r_largeCavern6, "fissure").

define tp_proving3 r_largeCavern7 makeCavern(137, 80,
    "You are in the upper southeast corner of the cavern. A large tunnel "
    "heads further east.").
Connect(r_largeCavern4, r_largeCavern7, D_SOUTH).
Connect(r_largeCavern5, r_largeCavern7, D_SOUTHEAST).
Scenery(r_largeCavern7, "tunnel;large").

define tp_proving3 r_largeCavern8 makeCavern(77, 80,
    "You are in the middle of the southern wall of the cavern. The floor "
    "slopes up to the east and down to the west and you can also go across "
    "the slope to the north.").
Connect(r_largeCavern7, r_largeCavern8, D_WEST).
HConnect(r_largeCavern7, r_largeCavern8, D_DOWN).
Connect(r_largeCavern5, r_largeCavern8, D_SOUTH).
Connect(r_largeCavern4, r_largeCavern8, D_SOUTHWEST).
Connect(r_largeCavern6, r_largeCavern8, D_SOUTHEAST).

define tp_proving3 r_largeCavern9 makeCavern(21, 80,
    "You are in the lower southwest corner of the cavern.").
Connect(r_largeCavern8, r_largeCavern9, D_WEST).
HConnect(r_largeCavern8, r_largeCavern9, D_DOWN).
Connect(r_largeCavern6, r_largeCavern9, D_SOUTH).
Connect(r_largeCavern5, r_largeCavern9, D_SOUTHWEST).

define tp_proving3 r_sewerCave4 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave4, "in a small crawlway",
    "The crawlway makes a tight bend, going northwest and north.").
Connect(r_largeCavern4, r_sewerCave4, D_SOUTHEAST).

define tp_proving3 r_sewerCave5 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave5, "in a small crawlway",
    "The crawlway makes a slight bend, going northwest and south.").
Connect(r_sewerCave4, r_sewerCave5, D_NORTH).

define tp_proving3 r_sewerCave6 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave6, "at the end of a fissure",
    "The fissue expands to the southwest, and a small crawlway near the "
    "floor heads southeast.").
Connect(r_sewerCave5, r_sewerCave6, D_NORTHWEST).

define tp_proving3 r_sewerCave7 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave7, "in a bend in a fissure",
    "The fissure continues to the northeast and to the south.").
Connect(r_sewerCave6, r_sewerCave7, D_SOUTHWEST).
Connect(r_largeCavern2, r_sewerCave7, D_NORTH).

define tp_proving3 r_sewerCave8 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave8, "at a corner in a large tunnel",
    "The tunnel makes a right-angle bend here, heading west and south.").
Connect(r_largeCavern7, r_sewerCave8, D_EAST).

define tp_proving3 r_sewerCave9 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave9, "in a large north-south tunnel", "").
Connect(r_sewerCave8, r_sewerCave9, D_SOUTH).

define tp_proving3 r_sewerCave10 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave10, "at a bend in a large tunnel",
    "The tunnel leads north and southeast here.").
Connect(r_sewerCave9, r_sewerCave10, D_SOUTH).

define tp_proving3 r_sewerCave11 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave11,
    "in a chamber formed by the meeting of several passages",
    "A large tunnel from the northwest bends back to the northeast here. "
    "A smaller tunnel arrives from the west, and a hole in the floor heads "
    "downward.").
Connect(r_sewerCave10, r_sewerCave11, D_SOUTHEAST).

define tp_proving3 r_sewerCave12 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave12, "at a bend in a large tunnel",
    "The tunnel leads north and southwest here.").
Connect(r_sewerCave11, r_sewerCave12, D_NORTHEAST).

define tp_proving3 r_sewerCave13 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave13, "in a large north-south tunnel", "").
Connect(r_sewerCave12, r_sewerCave13, D_NORTH).

define tp_proving3 r_sewerCave14 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave14, "in a small pit",
    "A very tight tube wanders away to the northwest.").
Connect(r_sewerCave11, r_sewerCave14, D_DOWN).

define tp_proving3 r_sewerCave15 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave15, "at the end of a high, wandering passage",
    "The main passage from the west ends here, but there is very tight tube "
    "wandering away to the southeast.").
Connect(r_sewerCave14, r_sewerCave15, D_NORTHWEST).

define tp_proving3 r_sewerCave16 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave16, "in a high, wandering passage", "").
Connect(r_sewerCave15, r_sewerCave16, D_WEST).

define tp_proving3 r_sewerCave17 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave17, "in a high, wandering passage",
    "Handholds on one wall should allow you to climb up through a hole in "
    "the roof of the passage here.").
Connect(r_sewerCave16, r_sewerCave17, D_NORTHWEST).

define tp_proving3 r_sewerCave18 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave18, "at the end of a high, wandering passage",
    "The main passage from the east ends here, but there is a passable crack "
    "in the north wall, leading roughly northeastwards.").
Connect(r_sewerCave17, r_sewerCave18, D_WEST).

define tp_proving3 r_sewerCave19 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave19, "in a long, narrow crack", "").
Connect(r_sewerCave18, r_sewerCave19, D_NORTHEAST).

define tp_proving3 r_sewerCave20 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave20, "in a long, narrow crack", "").
Connect(r_sewerCave19, r_sewerCave20, D_NORTH).

define tp_proving3 r_sewerCave21 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave21, "at the end of a long, narrow crack",
    "The crack extends a long way to the south, but closes up here. A small "
    "crawlway does lead to the east, however.").
Connect(r_sewerCave20, r_sewerCave21, D_NORTH).
Connect(r_largeCavern6, r_sewerCave21, D_WEST).

define tp_proving3 r_sewerCave22 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave22, "at a bend in a smallish tunnel",
    "A larger area can be seen to the east, but to the south you just see "
    "another corner.").
Connect(r_sewerCave11, r_sewerCave22, D_WEST).

define tp_proving3 r_sewerCave23 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave23, "at a sharp corner in a smallish tunnel", "").
Connect(r_sewerCave22, r_sewerCave23, D_SOUTH).

define tp_proving3 r_sewerCave24 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave24, "in a smallish tunnel running southeast-northwest",
    "A small opening leads directly south.").
Connect(r_sewerCave23, r_sewerCave24, D_NORTHWEST).
RoomName(r_sewerCave24, "Tunnel", "").

define tp_proving3 r_sewerCave25 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave25, "at a bend in a smallish tunnel", "").
Connect(r_sewerCave24, r_sewerCave25, D_NORTHWEST).

define tp_proving3 r_sewerCave26 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave26, "at a bend in a smallish tunnel", "").
Connect(r_sewerCave25, r_sewerCave26, D_NORTH).

define tp_proving3 r_sewerCave27 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave27, "at the east end of a long, wide, low tunnel",
    "A smallish tunnel heads off to the southeast.").
Connect(r_sewerCave26, r_sewerCave27, D_NORTHEAST).

define tp_proving3 r_sewerCave28 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave28, "in a long, wide, low, east-west tunnel", "").
Connect(r_sewerCave27, r_sewerCave28, D_WEST).

define tp_proving3 r_sewerCave29 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave29, "in a long, wide, low, east-west tunnel", "").
Connect(r_sewerCave28, r_sewerCave29, D_WEST).

define tp_proving3 r_sewerCave30 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave30, "at the west end of a long, wide, low tunnel",
    "A narrow passage heads north.").
Connect(r_sewerCave29, r_sewerCave30, D_WEST).

define tp_proving3 r_sewerCave31 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave31, "in a narrow north-south passage",
    "A large crack in the floor leads to a high passage below.").
Connect(r_sewerCave30, r_sewerCave31, D_NORTH).
Connect(r_sewerCave17, r_sewerCave31, D_UP).

define tp_proving3 r_sewerCave32 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave32,"at a south-east-west Tee in the narrow passage","").
Connect(r_sewerCave31, r_sewerCave32, D_NORTH).

define tp_proving3 r_sewerCave33 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave33, "in a narrow east-west passage", "").
Connect(r_sewerCave32, r_sewerCave33, D_EAST).

define tp_proving3 r_sewerCave34 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave34, "at a north to west corner in the narrow passage",
    "").
Connect(r_sewerCave33, r_sewerCave34, D_EAST).

define tp_proving3 r_sewerCave35 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave35, "on a narrow ledge",
    "The ledge is about halfway up the south wall of a large cavern. You "
    "can't see the far walls of the cavern from here, but you can make out a "
    "large rock in the middle of it. A narrow passage heads south, but there "
    "are no other exits. You can jump down to the cavern, but you would not "
    "be able to get back up.").
Connect(r_sewerCave34, r_sewerCave35, D_NORTH).
UniConnect(r_sewerCave35, r_largeCavern8, D_DOWN).
Scenery(r_sewerCave35,
    "ledge;narrow.cavern;large.passage;narrow.rock;large").

define tp_proving3 r_spiderDen CreateThing(r_provingCave).
SetupRoomP(r_spiderDen, "in the spider den",
    "This medium-sized chamber is evidently the home of many of the large "
    "spiders that populate the caves hereabouts. Large webs festoon the "
    "walls and ceiling, with many hanging strands lower down. The air here "
    "has a distinctly acidic tang to it. The bones of many small, and a few "
    "not-so-small, animals litter the floor, often to a depth of several "
    "inches.").
Connect(r_sewerCave24, r_spiderDen, D_SOUTH).
AutoGraphics(r_spiderDen, AutoTunnelChamber).
RoomName(r_spiderDen, "Spider", "Den").
Scenery(r_spiderDen,
    "ceiling.wall."
    "web,strand;large,spider,hanging."
    "bone,litter;small,not-so-small,not,so-small").
r_spiderDen@p_oSmellString :=
    "The sharp smell of spiders is predominant here, but there is also a "
    "noticeable component of decay, and another of dust.".
define tp_proving3 o_spiderEgg CreateThing(nil).
o_spiderEgg@p_oName := "egg;spider".
o_spiderEgg@p_oDesc :=
    "The spider egg is a white sphere about a foot in diameter. It is light "
    "in weight, but feels solid inside. It's surface is smooth and shiny - "
    "quite reminiscent of a pearl.".
o_spiderEgg@p_oHome := r_lostAndFound.
o_spiderEgg@p_oEatString :=
    "The egg is too large for you to bite, let alone swallow whole. When "
    "licked, it seems to absorb your saliva, but you notice nothing special "
    "about its taste, which is a mixture of acidity and dust.".
o_spiderEgg@p_oSmellString :=
    "The egg has no strong smell - perhaps a touch of the spider's acid tang.".
SetThingStatus(o_spiderEgg, ts_readonly).
define tp_proving3 proc eggQuestDesc()string:
    "Bring me a spider egg."
corp;
define tp_proving3 proc eggQuestGive()status:
    thing egg;

    egg := It();
    if Parent(egg) = o_spiderEgg then
	GiveToQuestor("spider egg");
	QuestThing@p_QuestActive := eggQuestGive;
	succeed
    elif egg@p_oName = "egg;spider" then
	GiveToQuestor("spider egg");
	QuestThing@p_QuestActive := eggQuestGive;
	SPrint(TrueMe(), "Questor is not impressed.\n");
	fail
    else
	continue
    fi
corp;
define tp_proving3 proc eggQuestHint()string:
    "Look beyond the dagger."
corp;
QuestGive("Egg", eggQuestDesc, eggQuestGive, eggQuestHint).
r_spiderDen@p_rLastVisit := 0.
define tp_proving3 proc spiderEnter(thing room)void:
    thing me, sword;
    int i, now, count;
    list thing lt;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_spiderDen@p_rLastVisit >= 300 then
	r_spiderDen@p_rLastVisit := now;
	/* See the comment about the goblin dagger for why this is not a
	   perfect test. */
	if not DoneQuest(eggQuestGive) and
	    CarryingChild(me, o_spiderEgg) = nil and
	    ChildHere(r_spiderDen, o_spiderEgg) = nil
	then
	    DepositClone(r_spiderDen, o_spiderEgg);
	fi;
	for i from 0 upto Random(3) + 2 do
	    ignore CreateMonster(me, m_trackerSpider, r_spiderDen);
	od;
	lt := me@p_pCarrying;
	count := Count(lt);
	i := 0;
	while i < count do
	    sword := lt[i];
	    if sword@p_oDamage >= o_longSword@p_oDamage then
		i := count + 1;
	    else
		i := i + 1;
	    fi;
	od;
	if i = count then
	    DepositClone(r_spiderDen, o_longSword);
	fi;
    fi;
corp;
AddAnyEnterAction(r_spiderDen, spiderEnter, false).

define tp_proving3 r_sewerCave36 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave36, "in a small chamber",
    "Passages lead off in several directions.").
Connect(r_sewerCave13, r_sewerCave36, D_NORTH).
AutoGraphics(r_sewerCave36, AutoTunnelChamber).

define tp_proving3 r_sewerCave37 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave37, "in a passage junction", "").
Connect(r_sewerCave36, r_sewerCave37, D_NORTHWEST).

define tp_proving3 r_sewerCave38 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave38, "in a northeast/southwest passage", "").
Connect(r_sewerCave37, r_sewerCave38, D_NORTHEAST).

define tp_proving3 r_sewerCave39 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave39, "in a southwest/southeast passage", "").
Connect(r_sewerCave38, r_sewerCave39, D_NORTHEAST).

define tp_proving3 r_sewerCave40 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave40, "in an east/northwest passage", "").
Connect(r_sewerCave39, r_sewerCave40, D_SOUTHEAST).

define tp_proving3 r_sewerCave41 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave41, "in a north/south/west passage Tee", "").
Connect(r_sewerCave40, r_sewerCave41, D_EAST).

define tp_proving3 r_sewerCave42 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave42, "at a west/south passage corner", "").
Connect(r_sewerCave41, r_sewerCave42, D_NORTH).

define tp_proving3 r_sewerCave43 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave43, "at a passage dead-end", "").
Connect(r_sewerCave42, r_sewerCave43, D_WEST).

define tp_proving3 r_sewerCave44 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave44, "in a passage crossing", "").
Connect(r_sewerCave41, r_sewerCave44, D_SOUTH).

define tp_proving3 r_sewerCave45 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave45, "in a south/east/west passage Tee", "").
Connect(r_sewerCave44, r_sewerCave45, D_WEST).

define tp_proving3 r_sewerCave46 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave46, "at a north/west passage corner", "").
Connect(r_sewerCave45, r_sewerCave46, D_SOUTH).

define tp_proving3 r_sewerCave47 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave47, "in an east/west passage", "").
Connect(r_sewerCave46, r_sewerCave47, D_WEST).
Connect(r_sewerCave36, r_sewerCave47, D_EAST).

define tp_proving3 r_sewerCave48 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave48, "in an east/northwest passage", "").
Connect(r_sewerCave36, r_sewerCave48, D_SOUTHEAST).

define tp_proving3 r_sewerCave49 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave49, "in a west/northeast passage", "").
Connect(r_sewerCave48, r_sewerCave49, D_EAST).

define tp_proving3 r_sewerCave50 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave50, "in a north/south/southwest passage Tee", "").
Connect(r_sewerCave49, r_sewerCave50, D_NORTHEAST).
Connect(r_sewerCave44, r_sewerCave50, D_SOUTH).

define tp_proving3 r_sewerCave51 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave51, "in a north/east/southwest passage Tee", "").
Connect(r_sewerCave50, r_sewerCave51, D_SOUTH).

define tp_proving3 r_sewerCave52 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave52, "in an east/west passage", "").
Connect(r_sewerCave51, r_sewerCave52, D_EAST).

define tp_proving3 r_sewerCave53 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave53, "at a west/north passage corner", "").
Connect(r_sewerCave52, r_sewerCave53, D_EAST).

define tp_proving3 r_sewerCave54 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave54, "in a northwest/south passage", "").
Connect(r_sewerCave53, r_sewerCave54, D_NORTH).

define tp_proving3 r_sewerCave55 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave55, "in a west/northeast/southeast Tee", "").
Connect(r_sewerCave54, r_sewerCave55, D_NORTHWEST).
Connect(r_sewerCave44, r_sewerCave55, D_EAST).

define tp_proving3 r_sewerCave56 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave56, "in a north/southwest passage", "").
Connect(r_sewerCave55, r_sewerCave56, D_NORTHEAST).

define tp_proving3 r_sewerCave57 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave57, "in a south/east passage junction",
	   "The east passage slopes gently upwards.").
Connect(r_sewerCave56, r_sewerCave57, D_NORTH).

define tp_proving3 r_sewerCave58 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave58, "at a northeast/west passage corner", "").
Connect(r_sewerCave51, r_sewerCave58, D_SOUTHWEST).

define tp_proving3 r_sewerCave59 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave59, "at the end of an east/west passage",
    "A ladder leads upwards through a small hole").
Connect(r_sewerCave58, r_sewerCave59, D_WEST).
Scenery(r_sewerCave59, "ladder.hole;small").

define tp_proving3 r_sewerCave60 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave60, "in an east/west passage",
    "A ladder leads downwards through a small hole.").
Connect(r_sewerCave59, r_sewerCave60, D_UP).
Scenery(r_sewerCave60, "ladder.hole;small").

define tp_proving3 r_sewerCave61 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave61, "in an east/west passage", "").
Connect(r_sewerCave60, r_sewerCave61, D_WEST).

define tp_proving3 r_sewerCave62 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave62, "in an east/north-west bend in the passage",
    "A ladder leads downwards through a small hole.").
Connect(r_sewerCave61, r_sewerCave62, D_WEST).
Scenery(r_sewerCave60, "ladder.hole;small").

define tp_proving3 r_sewerCave63 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave63, "at the end of a north/south passage",
    "A ladder leads upwards through a small hole.").
Connect(r_sewerCave62, r_sewerCave63, D_DOWN).
Scenery(r_sewerCave59, "ladder.hole;small").

define tp_proving3 r_sewerCave64 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave64, "at an east/south passage corner", "").
Connect(r_sewerCave63, r_sewerCave64, D_NORTH).
Connect(r_sewerCave36, r_sewerCave64, D_WEST).

define tp_proving3 r_sewerCave65 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave65, "in an north/east/southwest passage Tee", "").
Connect(r_sewerCave36, r_sewerCave65, D_NORTHEAST).
Connect(r_sewerCave45, r_sewerCave65, D_WEST).

define tp_proving3 r_sewerCave66 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave66, "at the end of a north/south passage",
    "A stone staircase leads upwards.").
Connect(r_sewerCave65, r_sewerCave66, D_NORTH).
Scenery(r_sewerCave66, "staircase;stone.stair;stone").

define tp_proving3 r_sewerCave67 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave67, "on a stone staircase", "").
Connect(r_sewerCave66, r_sewerCave67, D_UP).
Scenery(r_sewerCave67, "staircase;stone.stair;stone").

define tp_proving3 r_sewerCave68 CreateThing(r_provingTunnel1).
SetupRoomDP(r_sewerCave68, "at the top of a stone staircase",
    "There is a small iron grill on the west wall, through which you can see "
    "a glimmer of light and a tunnel. You can see no way to get there, "
    "but you do see a small hole in the stone, just below the grill. It "
    "is too small to put your finger into, and it doesn't look like a "
    "natural hole.").
Connect(r_sewerCave67, r_sewerCave68, D_UP).
Scenery(r_sewerCave68,
    "staircase;stone.stair;stone."
    "light;glimmer,of.glimmer."
    "tunnel.").
define tp_proving3 o_grill CreateThing(nil).
FakeModel(o_grill, "grill;small,iron", "").
define tp_proving3 proc grillDescribe()string:
    string s;

    s := GetAgents(r_sewer6);
    if s ~= "" then
	"Through the grill you can see: " + GetAgents(r_sewer6)
    else
	"You can currently see nothing through the grill."
    fi
corp;
o_grill@p_oDescAction := grillDescribe.
AddTail(r_sewerCave68@p_rContents, o_grill).
define tp_proving o_ironKey CreateThing(nil).
o_ironKey@p_oName := "key;large,iron".
o_ironKey@p_oDesc :=
    "The key is of simple construction, consisting of a long round shaft, a "
    "crosspiece at one end for turning it, and 3 finger rods at the other.".
SetThingStatus(o_ironKey, ts_readonly).
o_ironKey@p_oHome := r_garbageRoom.
define tp_proving3 o_keyHole1 CreateThing(nil).
FakeObject(o_keyHole1, r_sewerCave68, "hole,keyhole;small,round", "").
o_keyHole1@p_oContents := CreateThingList().
define tp_proving3 proc putInKeyHole1(thing key, keyhole)status:
    string name;
    bool hidden;

    if Parent(key) = o_ironKey then
	name := Me()@p_pName;
	hidden := Me()@p_pHidden;
	Print("The iron key slips into the hole and turns easily. A section "
	    "of the wall pivots out of the way and you walk through "
	    "into the sewer.\n");
	if hidden then
	    OPrint("A section of the east wall pivots open, then quickly "
		"closes again.\n");
	else
	    OPrint(name + " does something to the east wall, and a section of "
		"it opens up, and " + name + " walks through. The wall "
		"then closes again before anyone can follow.\n");
	fi;
	LeaveRoomStuff(r_sewer6, D_EAST, MOVE_SPECIAL);
	EnterRoomStuff(r_sewer6, D_WEST, MOVE_SPECIAL);
	if hidden then
	    OPrint("A section of the west wall pivots open, then quickly "
		"closes again.\n");
	else
	    OPrint("A section of the west wall pivots open and " + name +
		"emerges. The wall quickly closes again.\n");
	fi;
	succeed
    else
	Print("The " + FormatName(key@p_oName) +
	    " will not fit into the hole.\n");
	fail
    fi
corp;
o_keyHole1@p_oPutInMeChecker := putInKeyHole1.
define tp_proving3 proc doUnlock1(thing keyhole, key)status:
    putInKeyHole1(key, keyhole)
corp;
o_keyHole1@p_oUnlockMeWithChecker := doUnlock1.
SetThingStatus(o_keyHole1, ts_readonly).

define tp_proving3 p_mPath CreateStringProp().
define tp_proving3 p_mPathIndex CreateIntProp().
define tp_proving3 p_mWasForced CreateBoolProp().

define tp_proving3 RockPile CreateThing(nil).

RockPile@p_mPath := "nwnenesee s w w swsee nes e e n nww w s w w ".
RockPile@p_mPathIndex := 0.
RockPile@p_mWasForced := false.
RockPile@p_pHitMax := 10.
RockPile@p_pHitNow := 10.

define tp_proving3 proc rockPileStep()void:
    thing here, me;
    int now, max, index, dir, i, d;
    string path;
    list int exits;

    me := Me();
    if not me@p_mWasForced then
	now := me@p_pHitNow;
	max := me@p_pHitMax;
	if now >= max - 1 then
	    here := Here();
	    path := me@p_mPath;
	    index := me@p_mPathIndex;
	    if index = Length(path) then
		index := 0;
	    fi;
	    dir := PairToDir(SubString(path, index, 2));
	    path := DirName(dir);
	    if LightAt(here) then
		OPrint("With a loud grinding noise, the rock pile leaves to " +
		    path + ".\n");
		ForEachAgent(here, UnShowIconOnce);
	    else
		OPrint("A loud grinding noise starts and receeds to " + path +
		    ".\n");
	    fi;
	    exits := here@p_rExits;
	    for i from 0 upto Count(exits) - 1 do
		d := exits[i];
		if d ~= dir then
		    ABPrint(here@(DirProp(d)), nil, nil,
			"You hear a grinding sound coming from " +
			DirName(DirBack(d)) + ".\n");
		fi;
	    od;
	    here := here@(DirProp(dir));
	    SetLocation(here);
	    dir := DirBack(dir);
	    path := DirName(dir);
	    if LightAt(here) then
		OPrint(
		    "With a loud grinding noise, the rock pile arrives from " +
		    path + ".\n");
		ForEachAgent(here, ShowIconOnce);
	    else
		OPrint("A loud grinding noise starts from " + path +
		    ", comes quite close, then stops.\n");
	    fi;
	    exits := here@p_rExits;
	    for i from 0 upto Count(exits) - 1 do
		d := exits[i];
		if d ~= dir then
		    ABPrint(here@(DirProp(d)), nil, nil,
			"You hear a grinding sound coming from " +
			DirName(DirBack(d)) + ".\n");
		fi;
	    od;
	    me@p_mPathIndex := index + 2;
	fi;
	if now < max then
	    me@p_pHitNow := now + 1;
	fi;
	After(60, rockPileStep);
    fi;
    me@p_mWasForced := false;
corp;

define tp_proving3 proc forceStep()status:
    rockPileStep();
    Me()@p_mWasForced := true;
    After(60, rockPileStep);
    continue
corp;

define tp_proving3 proc rockPileFight(thing rockPile)void:
    thing attacker, here, weapon, key;
    string weaponName;
    int hitMax, hitNow;

    attacker := Me();
    here := Here();
    weapon := attacker@p_pWeapon;
    weaponName := FormatName(weapon@p_oName);
    if IsAncestor(weapon, o_stiletto) then
	hitMax := rockPile@p_pHitMax;
	hitNow := rockPile@p_pHitNow;
	Print("The stiletto is able to slip between a pair of the close "
	    "fitting rocks making up the rock pile. ");
	if hitNow >= hitMax - 1 then
	    ignore ForceAction(rockPile, forceStep);
	    rockPile@p_pHitNow := hitNow - 2;
	    if not FindChildOnList(here@p_rContents, o_ironKey) and
		not FindChildOnList(attacker@p_pCarrying, o_ironKey)
	    then
		Print("Tinkle.\n");
		OPrint("Tinkle.\n");
		key := CreateThing(o_ironKey);
		SetThingStatus(key, ts_wizard);
		GiveThing(key, SysAdmin);
		AddTail(here@p_rContents, key);
		key@p_oCreator := attacker;
		key@p_oWhere := here;
	    fi;
	elif hitNow >= hitMax / 2 then
	    rockPile@p_pHitNow := hitNow - 1;
	    Print("The rock pile shakes violently.\n");
	elif hitNow ~= 0 then
	    rockPile@p_pHitNow := hitNow - 1;
	    Print("The rock pile quivers gently.\n");
	else
	    Print("The rock pile does not react.\n");
	fi;
    elif IsAncestor(weapon, o_shortSword) or
	IsAncestor(weapon, o_longSword) or
	IsAncestor(weapon, o_twoHandedSword)
    then
	if Parent(weapon) = nil or
	    weapon@p_oDamage < Parent(weapon)@p_oDamage / 2
	then
	    Print("You bang away at the rock pile with your " + weaponName +
		", but nothing much happens.\n");
	else
	    weapon@p_oDamage := weapon@p_oDamage - 1;
	    Print("Banging on rocks with your " + weaponName +
		" is not a good idea - you have blunted it!\n");
	fi;
    else
	Print("You pound on the rock pile with your " + weaponName +
	    ", but there is no noticeable effect.\n");
    fi;
    OPrint(attacker@p_pName + " attacks the rock pile.\n");
corp;

RockPile@p_mFightAction := rockPileFight.

define tp_proving3 proc rockPilePre()status:

    SPrint(TrueMe(), "You can't give things to the rock pile.\n");
    fail
corp;

define tp_proving3 proc rockPileCreate()void:

    SetupMachine(RockPile);
    RockPile@p_pDesc :=
"The rock pile looks to be just that - a pile of rocks. The individual rocks "
"do fit together quite well however - there is barely room for a small blade "
"between any of them. Overall, it is about 3 feet high and 4 feet across, in "
"a generally rocky grey colour.";
    CreateMachine("pile;rock.rockpile", RockPile, r_sewerCave36, rockPileStep);
    ignore SetMachineActive(RockPile, rockPileStep);
    GNewIcon(RockPile, makeRockPileIcon());
    RockPile@p_pGivePre := rockPilePre;
corp;
rockPileCreate().
ignore DeleteSymbol(tp_proving3, "rockPileCreate").

define tp_proving3 r_sewerCaveA1 CreateThing(r_provingCave).
SetupRoomP(r_sewerCaveA1, "in a narrow east-west passage", "").
Connect(r_sewerCave32, r_sewerCaveA1, D_WEST).

define tp_proving r_sewerCaveA2 CreateThing(r_provingCave).
SetupRoomP(r_sewerCaveA2, "in a narrow east-west passage", "").
Connect(r_sewerCaveA1, r_sewerCaveA2, D_WEST).

define tp_proving3 r_sewerCave70 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave70, "at a sharp west/north-west corner", "").
Connect(r_sewerCave60, r_sewerCave70, D_EAST).

define tp_proving3 r_sewerCave71 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave71, "at a north/west/south-east junction", "").
Connect(r_sewerCave70, r_sewerCave71, D_NORTHWEST).

define tp_proving3 r_sewerCave72 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave72, "at a north-east/north-west/south junction", "").
Connect(r_sewerCave71, r_sewerCave72, D_NORTH).

define tp_proving3 r_sewerCave73 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave73, "at a north/east/south-west junction", "").
Connect(r_sewerCave72, r_sewerCave73, D_NORTHEAST).

define tp_proving3 r_sewerCave74 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave74, "at a tight west/north-west bend", "").
Connect(r_sewerCave73, r_sewerCave74, D_EAST).

define tp_proving3 r_sewerCave75 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave75, "at an east/north-west passage bend", "").
Connect(r_sewerCave71, r_sewerCave75, D_WEST).

define tp_proving3 r_sewerCave76 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave76, "at a north/west/south-east passage junction", "").
Connect(r_sewerCave75, r_sewerCave76, D_NORTHWEST).

define tp_proving3 r_sewerCave77 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave77, "at a dead-end", "").
Connect(r_sewerCave76, r_sewerCave77, D_WEST).

define tp_proving3 r_sewerCave78 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave78, "at a north-east/south passage bend",
	   "A side passage heads south-west.").
Connect(r_sewerCave76, r_sewerCave78, D_NORTH).

define tp_proving3 r_sewerCave79 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave79, "at a dead-end", "").
Connect(r_sewerCave78, r_sewerCave79, D_SOUTHWEST).
r_sewerCave79@p_rLastVisit := 0.
define tp_proving3 proc cave79Enter(thing room)void:
    thing me, weapon;
    int i, now;

    now := Time();
    me := Me();
    if me@p_pStandard and now - r_sewerCave79@p_rLastVisit >= 300 then
	r_sewerCave79@p_rLastVisit := now;
	for i from 0 upto 2 do
	    ignore CreateMonster(me, m_hugeSpider, r_sewerCave79);
	od;
	weapon := me@p_pWeapon;
	if weapon ~= nil and weapon@p_oDamage < o_goblinSword@p_oDamage then
	    DepositClone(r_sewerCave79, o_goblinSword);
	fi;
    fi;
corp;
AddAnyEnterAction(r_sewerCave79, cave79Enter, false).

define tp_proving3 r_sewerCave80 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave80, "at a south-east/south-west passage corner", "").
Connect(r_sewerCave78, r_sewerCave80, D_NORTHEAST).
Connect(r_sewerCave74, r_sewerCave80, D_NORTHWEST).

define tp_proving3 r_sewerCave81 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave81, "in a north-west/south-east passage",
	   "A branch passage heads south.").
Connect(r_sewerCave72, r_sewerCave81, D_NORTHWEST).

define tp_proving3 r_sewerCave82 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave82, "at a dead-end", "").
Connect(r_sewerCave81, r_sewerCave82, D_SOUTH).

define tp_proving3 r_sewerCave83 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave83, "in a north/south passage", "").
Connect(r_sewerCave73, r_sewerCave83, D_NORTH).

define tp_proving3 r_sewerCave84 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave84, "at an east/west/south passage tee", "").
Connect(r_sewerCave83, r_sewerCave84, D_NORTH).

define tp_proving3 r_sewerCave85 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave85, "at a north/west passage corner",
	   "The north passage slopes gently downwards.").
Connect(r_sewerCave84, r_sewerCave85, D_EAST).

define tp_proving3 r_sewerCave86 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave86, "at a south/west corner in the sloping passage", "").
Connect(r_sewerCave85, r_sewerCave86, D_NORTH).
Connect(r_sewerCave85, r_sewerCave86, D_DOWN).
Connect(r_sewerCave57, r_sewerCave86, D_EAST).
Connect(r_sewerCave57, r_sewerCave86, D_UP).
RoomName(r_sewerCave86, "Sloping", "Corner").

define tp_proving3 r_sewerCave87 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave87, "in an east-west tunnel passage",
	   "A branch passage heads to the north-west.").
Connect(r_sewerCave84, r_sewerCave87, D_WEST).

define tp_proving3 r_sewerCave88 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave88, "at a south/east passage corner", "").
Connect(r_sewerCave87, r_sewerCave88, D_WEST).

define tp_proving3 r_sewerCave89 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave89, "at a junction of several passages", "").
Connect(r_sewerCave81, r_sewerCave89, D_NORTHWEST).
Connect(r_sewerCave88, r_sewerCave89, D_SOUTH).
r_sewerCave89@p_rName1 := "Junction".

define tp_proving3 r_sewerCave90 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave90, "at a gentle north-east/south passage corner", "").
Connect(r_sewerCave89, r_sewerCave90, D_SOUTHWEST).

define tp_proving3 r_sewerCave91 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave91, "in a north-south tunnel passage",
	   "A branch passage heads to the west.").
Connect(r_sewerCave90, r_sewerCave91, D_SOUTH).

define tp_proving3 r_sewerCave92 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave92, "at a gentle north/south-east passage corner", "").
Connect(r_sewerCave62, r_sewerCave92, D_NORTHWEST).
Connect(r_sewerCave91, r_sewerCave92, D_SOUTH).

define tp_proving3 r_sewerCave93 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave93, "at a north/east tunnel passage corner",
	   "The north passage slopes gently downwards.").
Connect(r_sewerCave91, r_sewerCave93, D_WEST).

define tp_proving3 r_sewerCave94 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave94, "at a hairpin bend in the tunnel passage",
	   "Both passages lead south, but one slopes upwards and one slopes "
	   "downwards.").
Connect(r_sewerCave93, r_sewerCave94, D_DOWN).
UniConnect(r_sewerCave93, r_sewerCave94, D_NORTH).
r_sewerCave94@p_rName1 := "Hairpin".

define tp_proving3 r_sewerCave95 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave95, "at a north/east passage corner",
	   "The north passage slopes gently upwards.").
Connect(r_sewerCave94, r_sewerCave95, D_DOWN).
Connect(r_sewerCave37, r_sewerCave95, D_WEST).
UniConnect(r_sewerCave95, r_sewerCave94, D_NORTH).

define tp_proving3 r_sewerCave96 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave96, "at a north/east passage corner", "").
Connect(r_sewerCave89, r_sewerCave96, D_WEST).

define tp_proving3 r_sewerCave97 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave97, "at a gentle south/north-east passage bend", "").
Connect(r_sewerCave96, r_sewerCave97, D_NORTH).

define tp_proving3 r_sewerCave98 CreateThing(r_provingCave).
SetupRoomP(r_sewerCave98, "at a south-west/south-east passage corner", "").
Connect(r_sewerCave97, r_sewerCave98, D_NORTHEAST).
Connect(r_sewerCave87, r_sewerCave98, D_NORTHWEST).

unuse tp_proving3
