/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * proving0.m - surface level of the proving grounds.
 */

use t_streets

/*
 * monsterDrink - used for the drinking troll and the drinking goblin.
 *	Half the time they will try to drink, other half will do normal stuff.
 */

define tp_proving proc monsterDrink()bool:

    if FindName(Here()@p_rContents, p_oName, "water") = succeed and
	Random(2) = 0
    then
	ignore Parse(G, "drink water");
    else
	DoMonsterMove(Me());
    fi;
    MonsterReschedule(Me());
    true
corp;

private tp_proving0 CreateTable().
use tp_proving0

define tp_proving0 proc monsterSet1(thing room)void:

    InitMonsterModels(room, 300);
    AddPossibleMonster(room, m_rat, 25);
    AddPossibleMonster(room, m_snake, 25);
    AddPossibleMonster(room, m_dog, 25);
    AddPossibleMonster(room, m_gremlin, 25);
corp;

define tp_proving0 proc monsterSetP(thing room)void:

    InitMonsterModels(room, 325);
    AddPossibleMonster(room, m_rat, 20);
    AddPossibleMonster(room, m_snake, 35);
    AddPossibleMonster(room, m_dog, 20);
    AddPossibleMonster(room, m_gremlin, 20);
    AddPossibleMonster(room, m_deer, 25);
corp;

define tp_proving0 m_birds CreateMonsterModel("birds;pair,of.pair",
    "The birds sing nicely, but they are nothing special to look at.",
    MonsterInit, RandomMove,
    0, 20, 0, 0, 0, 0).
GNewIcon(m_birds, makeBirdIcon()).
define tp_proving0 proc birdsHit(thing theBirds)void:
    Print("The birds flutter out of reach.\n");
    OPrint(Capitalize(Me()@p_pName) +
	" takes a swipe at the birds, but they flutter out of reach.\n");
corp;
m_birds@p_mFightAction := birdsHit.
/* birds will sing once, then leave */
define tp_proving0 BIRDS_SING_ID NextSoundEffectId().
define tp_proving0 proc birdsSingOnce(thing client)void:
    if SOn(client) then
	SPlaySound(client, "birds", BIRDS_SING_ID);
	IfFound(client);
	Else(client);
	    FailText(client, "The birds sing.");
	Fi(client);
    else
	SPrint(client, "The birds sing.\n");
    fi;
corp;
define tp_proving0 proc birdsSing()bool:
    ForEachAgent(Here(), birdsSingOnce);
    Me()@p_mMovesUntilVanish := 0;
    MonsterReschedule(Me());
    true
corp;
m_birds@p_mSpecialAction := birdsSing.
m_birds@p_Image := "Characters/birds".

define tp_proving0 m_drinkingTroll CreateThing(m_troll).
m_drinkingTroll@p_mSpecialAction := monsterDrink.
m_drinkingTroll@p_Image := "Characters/drinkingTroll".

define tp_proving0 proc monsterSet2(thing room)void:

    InitMonsterModels(room, 400);
    AddPossibleMonster(room, m_wolf, 25);
    AddPossibleMonster(room, m_blackBear, 25);
    AddPossibleMonster(room, m_deer, 25);
    AddPossibleMonster(room, m_moose, 25);
    AddPossibleMonster(room, m_drinkingTroll, 25);
    AddPossibleMonster(room, m_birds, 25);
corp;

define tp_proving0 r_warning CreateThing(r_outdoors).
SetupRoom(r_warning, "on an east-west path", "").
Connect(r_path2, r_warning, D_WEST).
AutoGraphics(r_warning, AutoPaths).
ExtendDesc(r_path2, "A sign reading 'To the Proving Grounds' points along "
    "a path heading west.").
Sign(r_path2, "sign;simple,painted,wooden",
    "The sign is a simple painted wooden sign on a post.",
    "To the Proving Grounds").
Scenery(r_path2, "post").
define tp_proving proc warning()status:
    if not Me()@p_pInited then
	Print(
"\nWARNING: The area to the west of here is a combat zone. If you chose to "
"enter that area, you may be subject to immediate attack. Entering the area "
"will enable combat for your player. Once enabled, combat cannot be "
"disabled.\n\n");
    fi;
    continue
corp;
AddWestChecker(r_path2, warning, false).

/* Some generic rooms for this level of the proving grounds. */

define tp_proving0 r_provingRoad CreateThing(r_road).
SetThingStatus(r_provingRoad, ts_readonly).
AutoGraphics(r_provingRoad, AutoRoads).
AutoPens(r_provingRoad, C_FOREST_GREEN, C_TAN, 0, 0).
monsterSet1(r_provingRoad).

define tp_proving0 r_provingField CreateThing(r_field).
SetThingStatus(r_provingField, ts_readonly).
monsterSet1(r_provingField).

define tp_proving0 r_provingForest CreateThing(r_forest).
SetThingStatus(r_provingForest, ts_readonly).
monsterSet2(r_provingForest).

define tp_proving0 r_entrance CreateThing(r_provingRoad).
SetupRoom(r_entrance, "at the proving grounds entrance",
    "A small, grimy tent is to the north, and a somewhat cleaner tent is "
    "to the south. The path from the east turns into a cobbled road at "
    "this point and continues to the west.").
Connect(r_warning, r_entrance, D_WEST).
r_warning@p_rNoMachines := true.
Scenery(r_entrance,
    "tent;small,grimy,somewhat,clean,cleaner.path,road;cobbled").
define tp_proving0 proc enterProvingGrounds()status:
    if not Me()@p_pInited then
	Print(
	    "Welcome to the proving grounds! You are hereby warned that "
	    "this area is not safe to just wander around in. It contains "
	    "monsters, etc. which will attempt to harm you. You should find "
	    "suitable weapons and armour to help protect yourself. You can "
	    "see your current statistics with the 'status' command.\n");
	InitFighter(Me());
    fi;
    continue
corp;
AddWestChecker(r_warning, enterProvingGrounds, false).
AddEastChecker(r_entrance, LeaveFighting, false).
define tp_proving0 PR_ENTRANCE_ID NextEffectId().
define tp_proving0 proc drawEntrance()void:

    if not KnowsEffect(nil, PR_ENTRANCE_ID) then
	DefineEffect(nil, PR_ENTRANCE_ID);
	GSetImage(nil, "Proving/entrance");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 0, 38);
	    GRectangle(nil, 129, 24, true);
	    GAMove(nil, 130, 46);
	    GRectangle(nil, 29, 8, true);
	    GSetPen(nil, C_DARK_BLUE);
	    GAMove(nil, 20, 0);
	    GRectangle(nil, 119, 33, true);
	    GSetPen(nil, C_LEMON_YELLOW);
	    GAMove(nil, 20, 67);
	    GRectangle(nil, 119, 32, true);
	    GSetPen(nil, C_BRICK_RED);
	    GAMove(nil, 75, 33);
	    HorizontalDoor();
	    GAMove(nil, 75, 67);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_ENTRANCE_ID);
corp;
AutoGraphics(r_entrance, drawEntrance).

/* Add an armoury to buy basic goods at */

define tp_proving0 r_armoury CreateThing(r_indoors).
SetupRoom(r_armoury, "in an armoury",
    "This small establishment is run by a nasty-looking individual who "
    "appears to be his own best customer. He is a short, but very heavyset "
    "man with a dirty beard and greasy hair. He wears armoured boots, heavy "
    "chain gauntlets, plate mail and an iron helm. The handle of a huge "
    "sword can be seen behind his head, and a couple of handy daggers are "
    "tucked into a loose belt. Perhaps he doesn't trust his clientele.").
Connect(r_entrance, r_armoury, D_NORTH).
UniConnect(r_armoury, r_entrance, D_EXIT).
AutoGraphics(r_armoury, AutoOpenRoom).
r_armoury@p_rNoMachines := true.
r_armoury@p_Image := "Proving/armoury".
Scenery(r_armoury,
    "man,individual,shopkeeper,storekeeper;nasty-looking,nasty,looking,short,"
	"but,very,heavyset."
    "beard,hair;dirty,greasy."
    "boot;armoured."
    "gauntlet,glove;heavy,chain."
    "helm,helmet;iron."
    "sword;huge."
    "head."
    "handle;huge,sword."
    "dagger;handy."
    "belt;loose").
MakeStore(r_armoury).
WeaponSell(r_armoury, "dagger",
    "The dagger is nothing special - just a large, heavy knife. The blade "
    "is fairly sharp, and should last.",
    10, 0, 0, 0, 0, 0, 6, 3)@p_Image := "Proving/dagger".
define tp_proving o_stiletto WeaponSell(r_armoury,
    "stiletto,stilleto,stileto,stilletto;fine",
    "The stiletto is like a long dagger with a very narrow blade. It is "
    "ideal for sticking into small places, like between ribs.",
    15, 0, 0, 0, 0, 0, 8, 5).
o_stiletto@p_Image := "Proving/stiletto".
define tp_proving o_shortSword WeaponSell(r_armoury, "sword;short",
    "The short sword is halfway between a dagger and a true sword. It is "
    "just under two feet long, and has a small straight guardpiece separating "
    "the double-edged blade from the cord-wrapped hilt.",
    50, 0, 0, 0, 0, 0, 7, 7).
o_shortSword@p_Image := "Proving/shortSword".
define tp_proving o_longSword WeaponSell(r_armoury, "sword;long",
    "The long sword is nearly three feet long and both edges are sharpened. "
    "The tip is also quite sharp, but not as sharp as those on smaller "
    "weapons. The guardpiece between the blade and the hilt is about four "
    "inches long, providing fair protection to the hand. There is a small "
    "metal pommel on the end of the leather-wrapped grip.",
    200, 0, 0, -1, 0, 0, 8, 11).
o_longSword@p_Image := "Proving/longSword".
define tp_proving o_twoHandedSword WeaponSell(r_armoury,
    "sword;two-handed.sword;two,handed",
    "The two-handed sword is a large, heavy weapon. It is about four feet "
    "long and has a six-inch hand-guard which curves out over the blade, "
    "serving to catch and hold other weapons sliding along the blade. The "
    "hilt is nearly a foot long, and there is a large pommel on the end of "
    "it. The grip area is wrapped in wide leather strips, providing a good "
    "grip.",
    400, 0, 0, -2, 0, 0, 8, 16).
o_twoHandedSword@p_Image := "Proving/twoHandedSword".
WeaponSell(r_armoury, "axe,ax;war",
    "The war axe is much like a chopping axe, except that the blade is much "
    "wider - it only has to chop flesh, not wood. There is a decorative "
    "tassle on the end of the handle.",
    150, 0, 0, -1, 0, 0, 6, 11)@p_Image := "Proving/warAxe".
WeaponSell(r_armoury, "poleaxe,poleax.axe,ax;pole.pole",
    "The poleaxe is an odd-looking but highly effective weapon. It has an "
    "iron head which is a wide axe-blade on one side and a long spike on the "
    "other. Thus it can be used for chopping actions and for spiking through "
    "things. The head is on the end of a long shaft, which has a further "
    "spike on its end.",
    125, 0, 0, 0, 0, 0, 9, 8)@p_Image := "Proving/poleaxe".
define tp_proving o_leatherArmour WeaponSell(r_armoury, "armour;leather",
    "Leather armour provides reasonable protection against small weapons, "
    "but it is little help against larger ones.",
    100, 0, 0, 0, -2, 0, 0, 0).
o_leatherArmour@p_Image := "Proving/leatherArmour".
WeaponSell(r_armoury, "armour;studded",
    "The studded armour is made of boiled leather with many bronze studs "
    "attached to it. The studs server to deflect and catch weapons that are "
    "swung against the armour. The boiled leather is considerable tougher "
    "than normal leather, and hence provides more protection.",
    350, 0, 0, 0, -3, 0, 0, 0)@p_Image := "Proving/studdedArmour".
WeaponSell(r_armoury, "mail;chain.chain",
    "Chain mail consists of a shirtlike contrivance made from small iron "
    "links, much as a chain is made from links. Being metal, it provides "
    "good protection against many weapons. A strong thrust can still break "
    "the links, however.",
    700, 0, 0, 0, -4, 0, 0, 0)@p_Image := "Proving/chainMail".
WeaponSell(r_armoury, "mail;plate.plate",
    "Plate armour is the ultimate in non-magical personal protection. Many "
    "formed metal plates are attached to a leather framework and worn like "
    "a heavy coat. The plates overlap near joints, so that gaps do not "
    "appear when moving.",
    2000, 0, 0, 0, -5, 0, 0, 0)@p_Image := "Proving/plateMail".
define tp_proving o_woodenShield WeaponSell(r_armoury,
    "shield;wooden.shield;wood",
    "The woode shield is made from many strips of wood glued together to "
    "form a rough circle. It is about one inch thick, and has a leather "
    "strap on the back for holding it.",
    75, 0, 0, 0, 0, -2, 0, 0).
o_woodenShield@p_Image := "Proving/woodenShield".
WeaponSell(r_armoury, "shield;bronze",
    "The bronze shield is no heavier than a wooden shield, but provides "
    "much better protection against piercing attacks. It also has a spike "
    "in the middle of its face which can be used to force weapons aside.",
    200, 0, 0, 0, 0, -3, 0, 0)@p_Image := "Proving/bronzeShield".
WeaponSell(r_armoury, "shield;iron",
    "The iron shield is pretty much the same as a bronze shield, except that "
    "it is much heavier, and is strong enough to resist nearly all puncture "
    "attacks.",
    500, 0, 0, 0, 0, -4, 0, 0)@p_Image := "Proving/ironShield".
WeaponSell(r_armoury, "sword;flashing",
    "This sword is a bit out of the ordinary. It has quite pretty scrollwork "
    "on the blade, mostly in the form of lightning bolts; and the pommel "
    "contains a large red gem.",
    1000000, 0, 0, 5, 0, 0, 7, 11)@p_Image := "Proving/flashingSword".
WeaponSell(r_armoury, "Thor;Hammer,of.hammer",
    "The Hammer of Thor appears to be a special weapon. It smashes instead "
    "of slashes, but that is likely to be just as effective. It appears to "
    "be quite heavy and unwieldy, but you seem to have no trouble with it.",
    1000000, 0, 3, 0, 0, 0, 10, 15)@p_Image := "Proving/HammerOfThor".
WeaponSell(r_armoury, "shield;enchanted",
    "There is something magical about the enchanted shield. It is almost as "
    "if some force within it wants to protect you.",
    1000000, 25, 0, 0, 0, -5, 0, 0)@p_Image := "Proving/enchantedShield".

/* add a healer for fixing up players */

define tp_proving0 r_healer CreateThing(r_indoors).
SetupRoom(r_healer, "in a healer's shop",
    "The proprietor is a friendly-looking man wearing loose brown robes and "
    "sandals. Shelves on one wall contain rows of neatly-labelled pottery "
    "jars, and the back of this fairly large tent is filled with curtained "
    "off areas containing simple cots. You can purchase healing here.").
Connect(r_entrance, r_healer, D_SOUTH).
UniConnect(r_healer, r_entrance, D_EXIT).
AutoGraphics(r_healer, AutoOpenRoom).
RoomName(r_healer, "Healer's", "Shop").
r_healer@p_rNoMachines := true.
r_healer@p_Image := "Proving/healer".
Scenery(r_healer,
    "proprietor,man;friendly-looking,friendly,looking."
    "robe;loose,brown."
    "sandal."
    "shelves,shelf,wall."
    "jar,pottery;pottery,neatly-labelled,neatly,labelled."
    "curtains."
    "cot,simple").
HealSell(r_healer, "heal;minor.minor", 10, 6).
HealSell(r_healer, "heal;small.small", 20, 15).
HealSell(r_healer, "heal;medium.medium", 50, 40).
HealSell(r_healer, "heal;large.large", 150, 140).
HealSell(r_healer, "heal;great.great", 500, 500).
r_healer@p_rBuyAction := HealingBuy.

/* and some more locations to play around in */

define tp_proving0 r_road1 CreateThing(r_provingRoad).
SetupRoom(r_road1, "on an east-west cobbled road",
    "Small alleys head north and south. There is a manhole in the middle of "
    "the road.").
Connect(r_entrance, r_road1, D_WEST).
define tp_proving o_manholeCover CreateThing(nil).
SetupObject(o_manholeCover, r_road1,
    "cover,lid;manhole.manhole.hole;man", "").
o_manholeCover@p_oInvisible := true.
o_manholeCover@p_oNotGettable := true.
o_manholeCover@p_Image := "Proving/manholeCover".
define tp_proving0 PR_CROSSROADS_ID NextEffectId().
define tp_proving0 proc crossRoadsDraw()void:

    if not KnowsEffect(nil, PR_CROSSROADS_ID) then
	DefineEffect(nil, PR_CROSSROADS_ID);
	GSetImage(nil, "Proving/crossRoads");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    AutoRoads();
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 5, 4, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_CROSSROADS_ID);
corp;
AutoGraphics(r_road1, crossRoadsDraw).

define tp_proving0 r_road2 CreateThing(r_provingRoad).
SetupRoomP(r_road2, "at the west end of the proving grounds road",
    "A small trail continues to the west. A simple wooden building is to the "
    "north.").
Connect(r_road1, r_road2, D_WEST).
define tp_proving0 PR_ROAD2_ID NextEffectId().
define tp_proving0 proc road2Draw()void:

    if not KnowsEffect(nil, PR_ROAD2_ID) then
	DefineEffect(nil, PR_ROAD2_ID);
	GSetImage(nil, "Proving/road2");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 15, 12, true);
	    GAMove(nil, 0, 46);
	    GRectangle(nil, 80, 8, true);
	    GAMove(nil, 80, 38);
	    GRectangle(nil, 79, 24, true);
	    GSetPen(nil, C_MEDIUM_BROWN);
	    GAMove(nil, 20, 0);
	    GRectangle(nil, 119, 33, true);
	    GSetPen(nil, C_BRICK_RED);
	    GAMove(nil, 75, 33);
	    HorizontalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_ROAD2_ID);
corp;
AutoGraphics(r_road2, road2Draw).

define tp_proving0 r_provingStore CreateThing(r_indoors).
SetupRoom(r_provingStore, "in a store",
    "This simple store isn't much to look at, but you can shop here for a "
    "variety of useful goods.").
Connect(r_road2, r_provingStore, D_NORTH).
UniConnect(r_provingStore, r_road2, D_EXIT).
AutoGraphics(r_provingStore, AutoOpenRoom).
r_provingStore@p_rNoMachines := true.
r_provingStore@p_Image := "Proving/store".
Scenery(r_provingStore, "store;simple.goods;variety,of,useful").
MakeStore(r_provingStore).
WeaponSell(r_provingStore, "wrappings;fur",
    "The fur wrappings can provide minimal protection from attacks with small "
    "weapons, teeth and claws. They also provides an ideal nesting place for "
    "many varieties of insect pests.",
    25, 0, 0, 0, -1, 0, 0, 0)@p_Image := "Proving/furWrappings".
WeaponSell(r_provingStore, "shield;hide",
    "The hide shield is just a piece of tough animal hide fastened over a "
    "light wooden frame. It provides some shielding from light weapons, and "
    "can be used to deflect attacks.",
    40, 0, 0, 0, 0, -1, 0, 0)@p_Image := "Proving/hideShield".
define tp_proving0 o_flint AddForSale(r_provingStore, "lighter;flint.flint",
    "The flint lighter is simply a small piece of flint with an iron striker "
    "tied to it. The combination can be used to light things.",
    10, nil).
o_flint@p_Image := "Proving/flint".

define tp_proving o_oilLamp AddForSale(r_provingStore, "lamp;oil",
    "The oil lamp is made of tin. It is a small round container with a "
    "wick on the top. The lamp can be filled with oil through a cap.",
    100, nil).
o_oilLamp@p_oState := 5 * 60.	/* good for 5 hours of light */
define tp_proving0 proc oilLampTick(thing lamp)void:
    int newState;

    newState := lamp@p_oState - 1;
    lamp@p_oState := newState;
    if newState = 0 then
	PassiveUnLightObject(lamp);
    else
	if newState < 10 then
	    if lamp@p_oCarryer ~= nil then
		SPrint(lamp@p_oCarryer, "Your oil lamp flickers - "
		    "it is nearly out of oil!\n");
	    fi;
	fi;
	DoAfter(60, lamp, oilLampTick);
    fi;
corp;
define tp_proving0 proc oilLampOn()status:
    thing lamp;

    lamp := It();
    if not FindChildOnList(Me()@p_pCarrying, o_flint) then
	Print("You have no lighter to light the lamp with.\n");
	fail
    elif lamp@p_oState = 0 then
	Print("The lamp is empty - you cannot light it.\n");
	fail
    elif lamp@p_oLight then
	Print("The lamp is already lit.\n");
	fail
    else
	ignore ActiveLightObject();
	if lamp@p_oState = 1 then
	    Print("The lamp is virtually empty - it will not last long.\n");
	elif lamp@p_oState <= 10 then
	    Print("The lamp is nearly empty - it will not last long.\n");
	fi;
	DoAfter(60, lamp, oilLampTick);
	succeed
    fi
corp;
o_oilLamp@p_oLightChecker := oilLampOn.
define tp_proving0 proc oilLampOff()status:
    status st;

    st := ActiveUnLightObject();
    if st = succeed then
	ignore CancelDoAfter(It(), oilLampTick);
	succeed
    else
	st
    fi
corp;
o_oilLamp@p_oExtinguishChecker := oilLampOff.
define tp_proving0 proc oilLampPutIn(thing lamp, container)status:
    if lamp@p_oLight then
	Print("You'd better extinguish the lamp before putting it into the " +
	    FormatName(container@p_oName) + ".\n");
	fail
    else
	continue
    fi
corp;
o_oilLamp@p_oPutMeInChecker := oilLampPutIn.
define tp_proving0 proc oilLampLookIn(thing lamp)string:
    int timeLeft;

    timeLeft := lamp@p_oState;
    if timeLeft = 0 then
	"The lamp is currently empty."
    elif timeLeft < 15 then
	"The lamp is nearly empty."
    else
	"The lamp currently has enough fuel for about " +
	if timeLeft >= 105 then
	    IntToString((timeLeft + 15) / 60) + " hours."
	elif timeLeft >= 55 then
	    "an hour."
	else
	    IntToString(timeLeft / 15 * 15) + " minutes."
	fi
    fi
corp;
o_oilLamp@p_oLookInAction := oilLampLookIn.
define tp_proving0 proc oilLampEmptyChecker(thing lamp)status:
    lamp@p_oState := 0;
    continue
corp;
o_oilLamp@p_oEmptyChecker := oilLampEmptyChecker.
o_oilLamp@p_Image := "Proving/oilLamp".

define tp_proving0 proc refillBuy()status:
    thing me, lamp;

    me := Me();
    if FindName(me@p_pCarrying, p_oName, "lamp;oil") = fail then
	lamp := nil;
    else
	lamp := FindResult();
	if Parent(lamp) ~= o_oilLamp then
	    lamp := nil;
	fi;
    fi;
    if lamp = nil then
	Print("You have no oil lamp to refill.\n");
	/* Cancel the entire purchase. */
	fail
    else
	lamp -- p_oState;
	Print("Your lamp is now refilled.\n");
	if not me@p_pHidden then
	    OPrint(Capitalize(me@p_pName) + " makes a purchase.\n");
	fi;
	/* Cancel message, adding to inventory; destroy the copy. */
	succeed
    fi
corp;
define tp_proving o_refill AddForSale(r_provingStore, "refill;oil,lamp",
    "", 25, refillBuy).

define tp_proving0 o_oilCan AddForSale(r_provingStore,
    "oil;can,of.oilcan.oil-can.can;oil",
    "The can of oil is a small tin container with a pouring spout.",
    100, nil).
o_oilCan@p_oState := 5.
define tp_proving0 proc oilCanDrop(thing can)status:
    if can@p_oState = 0 then
	if LightAt(Here()) then
	    if can@p_oCarryer = Me() then
		Print("You discard the empty oil can. It vanishes in a puff "
		    "of neatness.\n");
	    fi;
	    OPrint(Capitalize(CharacterNameG(Me())) +
		" discards an empty oil can.\n");
	fi;
	ClearThing(can);
	DelElement(Me()@p_pCarrying, can);
	succeed
    else
	continue
    fi
corp;
o_oilCan@p_oDropChecker := oilCanDrop.
define tp_proving0 proc oilLampFillWith(thing lamp, source)status:
    int oilLeft;

    if Parent(source) = o_oilCan then
	oilLeft := source@p_oState;
	if oilLeft = 0 then
	    Print("The oil can is empty.\n");
	    succeed
	else
	    lamp -- p_oState;	/* inherit full time from parent */
	    oilLeft := oilLeft - 1;
	    source@p_oState := oilLeft;
	    if oilLeft = 0 then
		Print("You fill the lamp, but the oil can is now empty.\n");
		succeed
	    else
		continue
	    fi
	fi
    else
	fail
    fi
corp;
o_oilLamp@p_oFillMeWithChecker := oilLampFillWith.
define tp_proving0 proc oilCanLookIn(thing oilCan)string:
    int oilLeft;

    oilLeft := oilCan@p_oState;
    if oilLeft = 0 then
	"The oil can is empty."
    elif oilLeft = 1 then
	"The oil can has enough oil for one more lamp refill."
    else
	"The oil can has enough oil in it for about " + IntToString(oilLeft) +
	" refills of an oil lamp."
    fi
corp;
o_oilCan@p_oLookInAction := oilCanLookIn.
define tp_proving0 proc oilCanEmptyChecker(thing oilCan)status:
    oilCan@p_oState := 0;
    continue
corp;
o_oilCan@p_oEmptyChecker := oilCanEmptyChecker.
o_oilCan@p_Image := "Proving/oilcan".

/* This next one is also needed in proving2.m, in the goblin city store. */
define tp_proving o_torch AddForSale(r_provingStore, "torch;reed", "",
    5, nil).
define tp_proving0 proc torchDesc()string:
    int timeLeft;

    timeLeft := It()@p_oState;
    if timeLeft = 0 then
	"The torch is completely burned out."
    else
	"The reed torch is a simple bundle of dried reeds tied together, its "
	"top coated with pitch. " +
	if It()@p_oLight then
	    "It will continue to burn brightly for about "
	else
	    "Although not now lit, it will burn brightly for about "
	fi +
	if timeLeft = 1 then
	    "one more minute."
	else
	    IntToString(timeLeft) + " minutes."
	fi
    fi
corp;
o_torch@p_oDescAction := torchDesc.
o_torch@p_oState := 10.
define tp_proving0 proc torchTick(thing torch)void:
    int newState;

    newState := torch@p_oState - 1;
    torch@p_oState := newState;
    if newState = 0 then
	PassiveUnLightObject(torch);
    else
	if newState < 3 then
	    if torch@p_oCarryer ~= nil then
		SPrint(torch@p_oCarryer, "Your torch splutters - "
		    "it is nearly burned out!\n");
	    fi;
	fi;
	DoAfter(60, torch, torchTick);
    fi;
corp;
define tp_proving0 proc torchOn()status:
    thing torch;

    torch := It();
    if FindName(Me()@p_pCarrying, p_oName, "lighter;flint") = fail or
	Parent(FindResult()) ~= o_flint
    then
	Print("You have no lighter to light the torch with.\n");
	fail
    elif torch@p_oState = 0 then
	Print("The torch is burned out - you cannot light it.\n");
	fail
    elif torch@p_oLight then
	Print("The torch is already lit.\n");
	fail
    else
	ignore ActiveLightObject();
	if torch@p_oState = 1 then
	    Print("The torch is virtually gone - it will not last long.\n");
	elif torch@p_oState <= 3 then
	    Print("The torch is nearly gone - it will not last long.\n");
	fi;
	DoAfter(60, torch, torchTick);
	succeed
    fi
corp;
o_torch@p_oLightChecker := torchOn.
define tp_proving0 proc torchOff()status:
    status st;

    st := ActiveUnLightObject();
    if st = succeed then
	ignore CancelDoAfter(It(), torchTick);
	succeed
    else
	st
    fi
corp;
o_torch@p_oExtinguishChecker := torchOff.
define tp_proving0 proc torchDrop(thing torch)status:
    if torch@p_oState = 0 then
	if LightAt(Here()) then
	    if torch@p_oCarryer = Me() then
		Print("You discard the burned-out torch. It vanishes in a "
		    "puff of neatness.\n");
	    fi;
	    OPrint(Capitalize(CharacterNameG(Me())) +
		" discards a burned out torch.\n");
	fi;
	ClearThing(torch);
	DelElement(Me()@p_pCarrying, torch);
	succeed
    else
	continue
    fi
corp;
o_torch@p_oDropChecker := torchDrop.
define tp_proving0 proc torchPutIn(thing torch, container)status:
    if torch@p_oLight then
	Print("You'd better extinguish the torch before putting it into the " +
	    FormatName(container@p_oName) + ".\n");
	fail
    else
	continue
    fi
corp;
o_torch@p_oPutMeInChecker := torchPutIn.

define tp_proving o_sack AddForSale(r_provingStore, "sack;canvas",
    "The canvas sack is strong and reliable, but not very large.", 10, nil).
o_sack@p_oContents := CreateThingList().
o_sack@p_oCapacity := 5.
o_sack@p_Image := "Proving/sack".

define tp_proving0 r_alley1 CreateThing(r_provingRoad).
SetupRoom(r_alley1, "in a north-south alley",
    "Piles of rusted metal, moldy leather and rotted wood litter the side "
    "of the armoury tent, which is even dirtier on this side than on the "
    "front. Across the alley from it is the remains of another tent, which "
    "burned down long ago.").
Connect(r_road1, r_alley1, D_NORTH).
Scenery(r_alley1,
    "metal;piles,of,rusted."
    "leather;moldy."
    "wood;rotted."
    "litter."
    "tent;dirty,armoury."
    "tent,remains;burned,tent.").
r_alley1@p_Image := "Proving/alley1".

define tp_proving r_alley2 CreateThing(r_provingRoad).
SetupRoomP(r_alley2, "at the north end of an alley",
    "The alley ends here, although you can duck around the armoury "
    "to the east, and a path heads north to a pasture. "
    "There is a large drainage grate in the ground.").
Connect(r_alley1, r_alley2, D_NORTH).
UniConnect(r_alley2, r_entrance, D_EAST).
define tp_proving0 PR_ALLEY2_ID NextEffectId().
define tp_proving0 proc alley2Draw()void:

    if not KnowsEffect(nil, PR_ALLEY2_ID) then
	DefineEffect(nil, PR_ALLEY2_ID);
	GSetImage(nil, "Proving/alley2");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 15, 12, true);
	    GAMove(nil, 65, 50);
	    GRectangle(nil, 30, 49, true);
	    GAMove(nil, 75, 0);
	    GRectangle(nil, 10, 50, true);
	    GAMove(nil, 80, 46);
	    GRectangle(nil, 79, 8, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_ALLEY2_ID);
corp;
AutoGraphics(r_alley2, alley2Draw).

define tp_proving0 r_gateSouth CreateThing(r_provingField).
SetupRoom(r_gateSouth, "just outside the pasture",
    "Immediately to your north is a gate into the pasture. The gate is wide "
    "open, but the fence running east-west is quite sturdy.").
Connect(r_alley2, r_gateSouth, D_NORTH).
AutoGraphics(r_gateSouth, AutoPaths).
AutoPens(r_gateSouth, C_FOREST_GREEN, C_TAN, 0, 0).
RoomName(r_gateSouth, "Outside", "Pasture").
Scenery(r_gateSouth, "gate.fence").
r_gateSouth@p_Image := "Proving/gateSouth".

define tp_proving0 r_pasture CreateThing(r_field).
AutoGraphics(r_pasture, AutoOpenSpace).
SetThingStatus(r_pasture, ts_readonly).
monsterSetP(r_pasture).

define tp_proving0 r_gateNorth CreateThing(r_pasture).
SetupRoom(r_gateNorth, "just inside the pasture",
    "The gate in the fence is to your south, and the pasture is all around "
    "you.").
Connect(r_gateSouth, r_gateNorth, D_NORTH).
Scenery(r_gateNorth, "gate.fence").
r_gateNorth@p_Image := "Proving/gateNorth".

define tp_proving0 r_pasture1 CreateThing(r_pasture).
SetupRoom(r_pasture1, "in the pasture", "The fence is to the south.").
Connect(r_gateNorth, r_pasture1, D_EAST).
Scenery(r_pasture1, "fence").

define tp_proving0 r_pasture2 CreateThing(r_pasture).
SetupRoom(r_pasture2, "in the south-east corner of the pasture",
    "The fence prevents you from going further east or further south.").
Connect(r_pasture1, r_pasture2, D_EAST).
Scenery(r_pasture2, "fence").

define tp_proving0 r_pasture3 CreateThing(r_pasture).
SetupRoom(r_pasture3, "in the pasture", "The fence is to the east.").
Connect(r_pasture2, r_pasture3, D_NORTH).
Connect(r_pasture1, r_pasture3, D_NORTHEAST).
Scenery(r_pasture3, "fence").

define tp_proving0 r_pasture4 CreateThing(r_pasture).
SetupRoom(r_pasture4, "in the pasture", "There is a bog to the north.").
Connect(r_pasture3, r_pasture4, D_WEST).
Connect(r_pasture1, r_pasture4, D_NORTH).
Connect(r_gateNorth, r_pasture4, D_NORTHEAST).
Connect(r_pasture2, r_pasture4, D_NORTHWEST).
Scenery(r_pasture4, "bog").

define tp_proving0 o_cowpie CreateThing(nil).
SetupObject(o_cowpie, r_pasture4, "pie;cow.cow-pie.dung",
    "The cow pie looks to be a few days old - it is dry on the surface, but "
    "you can see moisture further in. Closer investigation is not warranted.").
define tp_proving0 proc getCowPie(thing th)status:
    Print("YUCK!!! You'd need a sooper dooper pooper scooper to pick up the "
	  "cow pie!\n");
    succeed
corp;
o_cowpie@p_oGetChecker := getCowPie.
o_cowpie@p_oSmellString := "WHEW! It's not as old as it looks!".
o_cowpie@p_Image := "Proving/cowpie".

define tp_proving0 r_pasture5 CreateThing(r_pasture).
SetupRoom(r_pasture5, "in the pasture", "There is a bog to the north.").
Connect(r_pasture4, r_pasture5, D_WEST).
Connect(r_gateNorth, r_pasture5, D_NORTH).
Connect(r_pasture1, r_pasture5, D_NORTHWEST).
Scenery(r_pasture5, "bog").

define tp_proving0 r_pasture6 CreateThing(r_pasture).
SetupRoom(r_pasture6, "in the pasture", "There is a bog to the north.").
Connect(r_pasture5, r_pasture6, D_WEST).
Connect(r_gateNorth, r_pasture6, D_NORTHWEST).
Scenery(r_pasture6, "bog").

define tp_proving0 r_pasture7 CreateThing(r_pasture).
SetupRoom(r_pasture7, "in the pasture", "The fence is to the south.").
Connect(r_pasture6, r_pasture7, D_SOUTH).
Connect(r_gateNorth, r_pasture7, D_WEST).
Connect(r_pasture5, r_pasture7, D_SOUTHWEST).
Scenery(r_pasture7, "fence").

define tp_proving0 r_pasture8 CreateThing(r_pasture).
SetupRoomP(r_pasture8, "in the south-west corner of the pasture",
    "Fences keep your from going further south or west.").
Connect(r_pasture7, r_pasture8, D_WEST).
Connect(r_pasture6, r_pasture8, D_SOUTHWEST).
Scenery(r_pasture8, "fence.hedge").

define tp_proving0 r_pasture9 CreateThing(r_pasture).
SetupRoomP(r_pasture9, "in the pasture by the fence", "").
Connect(r_pasture8, r_pasture9, D_NORTH).
Connect(r_pasture6, r_pasture9, D_WEST).
Connect(r_pasture7, r_pasture9, D_NORTHWEST).
Scenery(r_pasture9, "hedge").

define tp_proving0 r_pasture10 CreateThing(r_pasture).
SetupRoomP(r_pasture10, "in the pasture",
    "A narrow spit of solid ground heads out into the bog to the east.").
Connect(r_pasture9, r_pasture10, D_NORTH).
Scenery(r_pasture10, "hedge.bog.ground;narrow,spit,of,solid").

define tp_proving0 r_pasture11 CreateThing(r_pasture).
SetupRoomP(r_pasture11, "on a spit of land in the bog",
    "Safe ground leads to the west.").
Connect(r_pasture10, r_pasture11, D_EAST).
Scenery(r_pasture11, "bog").

define tp_proving0 r_pasture12 CreateThing(r_pasture).
SetupRoom(r_pasture12, "in the pasture",
    "The fence is to the east and the bog is to the west.").
Connect(r_pasture3, r_pasture12, D_NORTH).
Scenery(r_pasture12, "fence.bog").

define tp_proving0 r_pasture13 CreateThing(r_pasture).
SetupRoom(r_pasture13, "in the pasture",
    "The fence is to the east and the bog is to the west.").
Connect(r_pasture12, r_pasture13, D_NORTH).
Scenery(r_pasture13, "fence.bog").

define tp_proving0 r_pasture14 CreateThing(r_pasture).
SetupRoom(r_pasture14, "in the north-east corner of the pasture",
    "Fences prevent further progress north or east.").
Connect(r_pasture13, r_pasture14, D_NORTH).
Scenery(r_pasture14, "fence.bog").

define tp_proving0 r_pasture15 CreateThing(r_pasture).
SetupRoom(r_pasture15, "in the pasture",
    "The fence is to the north and the bog is to the south.").
Connect(r_pasture14, r_pasture15, D_WEST).
Scenery(r_pasture15, "fence.bog").

define tp_proving0 r_pasture16 CreateThing(r_pasture).
SetupRoom(r_pasture16, "in the pasture", "The fence is to the north.").
Connect(r_pasture15, r_pasture16, D_WEST).
Scenery(r_pasture16, "fence").

define tp_proving0 r_pasture17 CreateThing(r_pasture).
SetupRoomP(r_pasture17, "in the pasture",
    "The fence is to the north and the bog is both west and south.").
Connect(r_pasture16, r_pasture17, D_WEST).
Scenery(r_pasture17, "fence.bog").

/* For the next little while is the apple tree, which can do healing. */

define tp_proving0 p_pAppleEatCount CreateIntProp().
define tp_proving0 p_pAppleEatTime CreateIntProp().

define tp_proving0 r_pasture18 CreateThing(r_pasture).
SetupRoom(r_pasture18, "in the pasture",
    "The bog is everywhere except north. There is a fine apple tree here, "
    "loaded with juicy red apples.").
Connect(r_pasture16, r_pasture18, D_SOUTH).
Scenery(r_pasture18, "bog").
r_pasture18@p_Image := "Proving/pasture18".

define tp_proving0 o_appleTree CreateThing(nil).
SetupObject(o_appleTree, r_pasture18, "tree;fine,apple",
    "The tree is only medium sized, but holds an impressive quantity of "
    "apples, many of which are in easy reach.").
o_appleTree@p_oInvisible := true.
o_appleTree@p_oSmellString := "The apple tree smells somewhat woody.".
o_appleTree@p_Image := "Proving/appleTree".

define tp_proving0 o_appleOnTree CreateThing(nil).
SetupObject(o_appleOnTree, r_pasture18, "apple;juicy,red",
    "The apples on the tree look quite delicious.").
o_appleOnTree@p_oInvisible := true.
o_appleOnTree@p_oEatString := "You should pick an apple from the tree first.".
o_appleOnTree@p_oSmellString := o_appleOnTree@p_oEatString.
o_appleOnTree@p_oTouchString := o_appleOnTree@p_oEatString.

define tp_proving0 proc appleDrop(thing apple)status:
    thing carryer, here;

    carryer := apple@p_oCarryer;
    ClearThing(apple);
    SPrint(carryer, "The apple drops and is pulped!\n");
    here := Here();
    if CanSee(here, carryer) and not carryer@p_pHidden then
	ABPrint(here, carryer, carryer,
	    Capitalize(CharacterNameG(carryer)) +
	    " drops an apple which is pulped.\n");
    else
	ABPrint(here, carryer, carryer, "You hear a smack! sound.\n");
    fi;
    DelElement(carryer@p_pCarrying, apple);
    /* we have just destroyed the apple and already dropped it, we do NOT
       want to continue with normal drop processing */
    succeed
corp;

define tp_proving0 proc appleEat()status:
    thing th, me;
    int now, current, max;

    th := It();
    me := Me();
    if th@p_oCreator = me then
	now := Time();
	if now - me@p_pAppleEatTime > 60 * 60 then
	    me@p_pAppleEatCount := 0;
	fi;
	if me@p_pAppleEatCount >= 3 then
	    Print("You'd better not eat any more apples for a while. Too many "
		"of them will make you sick!\n");
	    fail
	else
	    Print("You eat the apple. It was really good.\n");
	    current := me@p_pHitNow;
	    max := me@p_pHitMax;
	    if current ~= max then
		current := current + Random(5) + 5;
		if current > max then
		    current := max;
		fi;
		me@p_pHitNow := current;
	    fi;
	    if CanSee(Here(), me) and not me@p_pHidden then
		OPrint(Capitalize(CharacterNameG(me)) + " eats an apple.\n");
	    else
		OPrint("You hear some crunching noises.\n");
	    fi;
	    ClearThing(th);
	    DelElement(me@p_pCarrying, th);
	    if me@p_pAppleEatCount = 0 then
		me@p_pAppleEatCount := 1;
		me@p_pAppleEatTime := now;
	    else
		me@p_pAppleEatCount := me@p_pAppleEatCount + 1;
	    fi;
	    succeed
	fi
    else
	Print("That's not your apple!\n");
	succeed
    fi
corp;

define tp_proving0 proc appleGive(thing target)status:
    thing me, apple;

    me := Me();
    apple := It();
    if apple@p_oCreator = me then
	Print("You fumble when trying to give away the apple, and drop it!\n");
	if CanSee(Here(), me) and not me@p_pHidden then
	    OPrint(Capitalize(CharacterNameG(me)) +
		" drops an apple which is pulped.\n");
	else
	    OPrint("You hear a smack! sound.\n");
	fi;
	ClearThing(apple);
	DelElement(me@p_pCarrying, apple);
    else
	Print("That's not your apple!\n");
    fi;
    /* the give never works */
    fail
corp;

define tp_proving0 o_appleInHand CreateThing(nil).
o_appleInHand@p_oName := "apple;juicy,red".
o_appleInHand@p_oDesc := "The apple looks quite delicious!".
o_appleInHand@p_oEatChecker := appleEat.
o_appleInHand@p_oDropChecker := appleDrop.
o_appleInHand@p_oGiveChecker := appleGive.
o_appleInHand@p_oSmellString := "The apple smells like an apple.".
o_appleInHand@p_oTouchString := "Surprise! The apple feels like an apple.".
o_appleInHand@p_Image := "Proving/apple".
SetThingStatus(o_appleInHand, ts_wizard).

define tp_proving0 proc appleGet(thing th)status:
    thing me;

    me := Me();
    if FindName(me@p_pCarrying, p_oName, "apple;juicy,red") ~= fail then
	Print("Don't be greedy! You already have an apple.\n");
    else
	/* will be owned by the real player */
	th := CreateThing(o_appleInHand);
	th@p_oCreator := me;
	SetThingStatus(th, ts_public);
	if CarryItem(th) then
	    Print("You pick an apple from the tree.\n");
	    /* assume it is not dark */
	    if not me@p_pHidden then
		OPrint(Capitalize(CharacterNameG(me)) +
		       " picks an apple from the tree.\n");
	    fi;
	else
	    ClearThing(th);
	fi;
    fi;
    /* do not want to continue with normal get processing */
    succeed
corp;

o_appleOnTree@p_oGetChecker := appleGet.

define tp_proving0 proc appleTreeGet(thing th)status:
    Print("The tree is far too large for you to carry, and in any event, "
	    "it is securely rooted to the ground.\n");
    if Me()@p_pHidden then
	OPrint("The tree shakes slightly.\n");
    else
	OPrint(Capitalize(CharacterNameG(Me())) +
	       " seems to be embracing the tree.\n");
    fi;
    succeed
corp;

o_appleTree@p_oGetChecker := appleTreeGet.

/* Note that we do NOT prevent people from getting several apples and putting
them in containers. */

/* End of apple tree stuff */

define tp_proving0 r_alley3 CreateThing(r_provingRoad).
SetupRoom(r_alley3, "in an alley",
    "The alley runs north-south between the healer's tent and a vacant spot.").
Connect(r_road1, r_alley3, D_SOUTH).
Scenery(r_alley3, "tent;healer's,healer.spot;vacant").
r_alley3@p_Image := "Proving/alley3".

define tp_proving r_alley4 CreateThing(r_provingRoad).
SetupRoom(r_alley4, "at the south end of an alley",
    "You can go behind the healer's tent to the east, and a trail continues "
    "south. A vacant spot is west. There is a large drainage grate in the "
    "ground.").
Connect(r_alley3, r_alley4, D_SOUTH).
Scenery(r_alley4, "tent;healer's,healer.spot;vacant").
define tp_proving0 PR_ALLEY4_ID NextEffectId().
define tp_proving0 proc alley4Draw()void:

    if not KnowsEffect(nil, PR_ALLEY4_ID) then
	DefineEffect(nil, PR_ALLEY4_ID);
	GSetImage(nil, "Proving/alley4");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 80, 50);
	    GEllipse(nil, 15, 12, true);
	    GAMove(nil, 65, 0);
	    GRectangle(nil, 30, 50, true);
	    GAMove(nil, 80, 46);
	    GRectangle(nil, 79, 8, true);
	    GAMove(nil, 75, 50);
	    GRectangle(nil, 10, 49, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_ALLEY4_ID);
corp;
AutoGraphics(r_alley4, alley4Draw).

define tp_proving0 r_behindHealer CreateThing(r_provingRoad).
SetupRoom(r_behindHealer, "behind the healer's tent",
    "Even back here the tent is quite clean, and the garbage, consisting of "
    "empty clay jugs, small skeletons and assorted unrecognizeable objects, "
    "is piled neatly in several wooden bins. "
    "The alley is west and you can slip around the tent to the east.").
Connect(r_alley4, r_behindHealer, D_EAST).
UniConnect(r_behindHealer, r_entrance, D_EAST).
RoomName(r_behindHealer, "Behind", "Healer's").
Scenery(r_behindHealer,
    "tent;clean,healer's,healer."
    "garbage."
    "jug;empty,clay."
    "skeleton;small."
    "object;assorted,unrecognizeable."
    "bin;wooden,wood").
AutoGraphics(r_behindHealer, AutoPaths).
AutoPens(r_behindHealer, C_FOREST_GREEN, C_TAN, 0, 0).
r_behindHealer@p_Image := "Proving/behindHealer".

define tp_proving0 r_fTrail0 CreateThing(r_provingField).
SetupRoomP(r_fTrail0, "at a north and west bend in the trail", "").
Connect(r_alley4, r_fTrail0, D_SOUTH).
AutoGraphics(r_fTrail0, AutoPaths).

define tp_proving0 r_fTrail1 CreateThing(r_provingField).
SetupRoomP(r_fTrail1, "on an east-west trail",
    "You can see forest to the west.").
Connect(r_fTrail0, r_fTrail1, D_WEST).
AutoGraphics(r_fTrail1, AutoPaths).

define tp_proving0 r_forest1 CreateThing(r_provingForest).
SetupRoomP(r_forest1, "in a forest",
    "You can see open space to the east, and paths in several directions.").
Connect(r_fTrail1, r_forest1, D_WEST).

define tp_proving0 r_forest2 CreateThing(r_provingForest).
SetupRoomP(r_forest2, "in a forest",
    "You can skirt around a hill to the northwest and go straight south.").
Connect(r_forest1, r_forest2, D_NORTH).
Scenery(r_forest2, "hill").
define tp_proving0 PR_FOREST2_ID NextEffectId().
define tp_proving0 proc forest2Draw()void:

    if not KnowsEffect(nil, PR_FOREST2_ID) then
	DefineEffect(nil, PR_FOREST2_ID);
	GSetImage(nil, "Proving/forest2");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    AutoPaths();
	    GSetPen(nil, C_MEDIUM_BROWN);
	    GPolygonStart(nil);
	    GAMove(nil, 25, 0);
	    GRDraw(nil, 45, 30);
	    GRDraw(nil, 20, 0);
	    GRDraw(nil, 45, -30);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_FOREST2_ID);
corp;
AutoGraphics(r_forest2, forest2Draw).

define tp_proving0 r_forest3 CreateThing(r_provingForest).
SetupRoomP(r_forest3, "in a forest beside a stream",
    "The stream blocks further progress to the west, but you can go "
    "northeast and north.").
Connect(r_forest1, r_forest3, D_SOUTHWEST).
define tp_proving0 o_stream CreateThing(nil).
SetupObject(o_stream, r_forest3, "water.stream.creek.brook", "").
o_stream@p_oInvisible := true.
o_stream@p_oNotGettable := true.
define tp_proving0 proc streamDrink()status:
    thing me;
    int current, max;

    me := Me();
    if not me@p_pHidden then
	OPrint(Capitalize(CharacterNameG(me)) +
	    " takes a drink from the stream.\n");
    else
	OPrint("You hear a slurping sound.\n");
    fi;
    Print("Ahh! That was very refreshing!\n");
    current := me@p_pHitNow;
    max := me@p_pHitMax;
    if current ~= max then
	current := current + Random(3) + 2;
	if current > max then
	    current := max;
	fi;
	me@p_pHitNow := current;
    fi;
    succeed
corp;
o_stream@p_oEatChecker := streamDrink.
o_stream@p_Image := "Proving/stream".
define tp_proving0 o_drink CreateThing(nil).
SetupObject(o_drink, r_forest3, "drink.swallow", "").
o_drink@p_oInvisible := true.
define tp_proving0 proc takeDrink(thing drink)status:
    streamDrink()
corp;
o_drink@p_oGetChecker := takeDrink.
define tp_proving0 proc streamDraw()void:

    AutoPaths();
    GSetPen(nil, C_BLUE);
    GAMove(nil, 40, 0);
    GRectangle(nil, 20, 99, true);
corp;
AutoGraphics(r_forest3, streamDraw).
RoomName(r_forest3, "Forest", "").

define tp_proving0 r_forest4 CreateThing(r_provingForest).
SetupRoomP(r_forest4, "in a forest beside a stream",
    "The stream blocks further progress to the west, but you can go "
    "north, south, and east.").
Connect(r_forest1, r_forest4, D_WEST).
Connect(r_forest3, r_forest4, D_NORTH).
AddTail(r_forest4@p_rContents, o_stream).
AddTail(r_forest4@p_rContents, o_drink).
AutoGraphics(r_forest4, streamDraw).
RoomName(r_forest4, "Forest", "").

define tp_proving r_forestByStream CreateThing(r_provingForest).
SetupRoomP(r_forestByStream, "down by the stream in the forest",
    "There is a large sewer draining into the stream here. The trickle of "
    "water coming from it manages to not pollute the stream. An iron grating "
    "covers the entrance to the sewer. You can climb up the bank to the "
    "trail.").
Connect(r_forest4, r_forestByStream, D_DOWN).
AddTail(r_forestByStream@p_rContents, o_stream).
AddTail(r_forestByStream@p_rContents, o_drink).
AutoGraphics(r_forestByStream, streamDraw).
RoomName(r_forestByStream, "Down By", "Stream").
Scenery(r_forestByStream,
    "trickle.bank.stonework.stone.work;stone.mouth;tunnel.tunnel."
    "sewer;large").
define tp_proving o_barGrating CreateThing(nil).
SetupObject(o_barGrating, r_forestByStream, "grating;iron,bar.bar;iron.iron",
    "The grating is solidly built, and is firmly mounted into stonework "
    "around the tunnel mouth. It appears to be held closed by some "
    "kind of latch mechanism.").
o_barGrating@p_oInvisible := true.
o_barGrating@p_oNotLocked := true.
define tp_proving proc barGratingGet(thing it)status:
    Print("The grating is held quite firmly in the stonework - you cannot "
	"break it free.\n");
    OPrint(Capitalize(CharacterNameG(Me())) + " rattles the grating.\n");
    fail
corp;
o_barGrating@p_oGetChecker := barGratingGet.
o_barGrating@p_oOpenString :=
    "The grating is held closed by the latch mechanism.".
o_barGrating@p_Image := "Proving/barGrating".
define tp_proving o_gratingLatch CreateThing(nil).
SetupObject(o_gratingLatch, r_forestByStream, "mechanism;latch.latch",
    "The mechanism is quite simple. It can be released by pulling on it, "
    "but it appears that it will latch again as soon as it is released.").
o_gratingLatch@p_oInvisible := true.
o_gratingLatch@p_oNotLocked := true.
define tp_proving proc gratingLatchGet(thing it)status:
    Print("The latch mechanism is part of the grating - "
	"you cannot remove it.\n");
    OPrint(Capitalize(CharacterNameG(Me())) + " fiddles with the grating.\n");
    fail
corp;
o_gratingLatch@p_oGetChecker := gratingLatchGet.
o_gratingLatch@p_Image := "Proving/gratingLatch".

define tp_proving0 r_forest5 CreateThing(r_provingForest).
SetupRoomP(r_forest5, "in a forest beside a stream",
    "The stream blocks further progress to the west, but you can go "
    "north, south and southeast.").
Connect(r_forest1, r_forest5, D_NORTHWEST).
Connect(r_forest4, r_forest5, D_NORTH).
AddTail(r_forest5@p_rContents, o_stream).
AddTail(r_forest5@p_rContents, o_drink).
AutoGraphics(r_forest5, streamDraw).
RoomName(r_forest5, "Forest", "").

define tp_proving0 r_forest6 CreateThing(r_provingForest).
SetupRoomP(r_forest6, "in a forest between a stream and a hill",
    "The stream blocks further progress to the west, and the hill presents "
    "a barrier to the east. You can go northeast, south and southeast.").
Connect(r_forest2, r_forest6, D_NORTHWEST).
Connect(r_forest5, r_forest6, D_NORTH).
AddTail(r_forest6@p_rContents, o_stream).
AddTail(r_forest6@p_rContents, o_drink).
Scenery(r_forest6, "hill.barrier").
define tp_proving0 PR_FOREST6_ID NextEffectId().
define tp_proving0 proc forest6Draw()void:

    if not KnowsEffect(nil, PR_FOREST6_ID) then
	DefineEffect(nil, PR_FOREST6_ID);
	GSetImage(nil, "Proving/forest6");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    streamDraw();
	    GSetPen(nil, C_MEDIUM_BROWN);
	    GPolygonStart(nil);
	    GAMove(nil, 159, 15);
	    GRDraw(nil, -46, 27);
	    GRDraw(nil, 0, 16);
	    GRDraw(nil, 46, 26);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_FOREST6_ID);
corp;
AutoGraphics(r_forest6, forest6Draw).
RoomName(r_forest6, "Forest", "").

define tp_proving0 r_forest7 CreateThing(r_provingForest).
SetupRoomP(r_forest7, "in a forest, north of a small hill",
    "You can go deeper into the forest to the southwest, or get out of the "
    "woods to the southeast.").
Connect(r_forest6, r_forest7, D_NORTHEAST).
Scenery(r_forest7, "hill;small.wood").
define tp_proving0 PR_FOREST7_ID NextEffectId().
define tp_proving0 proc forest7Draw()void:

    if not KnowsEffect(nil, PR_FOREST7_ID) then
	DefineEffect(nil, PR_FOREST7_ID);
	GSetImage(nil, "Proving/forest7");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    AutoPaths();
	    GSetPen(nil, C_MEDIUM_BROWN);
	    GPolygonStart(nil);
	    GAMove(nil, 25, 99);
	    GRDraw(nil, 45, -29);
	    GRDraw(nil, 20, 0);
	    GRDraw(nil, 45, 29);
	    GPolygonEnd(nil);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, PR_FOREST7_ID);
corp;
AutoGraphics(r_forest7, forest7Draw).
RoomName(r_forest7, "Forest", "").

define tp_proving0 r_fTrail2 CreateThing(r_provingField).
SetupRoomP(r_fTrail2, "on a trail",
    "The trail bends here, heading east to a cobbled road, and northwest "
    "towards a forest.").
Connect(r_forest7, r_fTrail2, D_SOUTHEAST).
Connect(r_road2, r_fTrail2, D_WEST).
Scenery(r_fTrail2, "forest.trail.road;cobbled").
AutoGraphics(r_fTrail2, AutoPaths).

unuse tp_proving0

unuse t_streets
