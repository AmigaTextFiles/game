/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * mall.m - define the minimall in the starter dungeon.
 */

private tp_mall CreateTable().
use tp_mall

/*
 * NOTE: two rooms, r_arrivals and r_lostAndFound, are actually created
 *	in 'util.m'. Since the structure and connections of those rooms are
 *	set up in this file, this file must be sourced by the same player
 *	who sources 'util.m' (normally SysAdmin), or those two rooms must
 *	be public, at least long enough to allow the building here.
 *	We are also dependent on some properties relevant to specific verbs,
 *	p_rRegisterAction and p_rBuyAction, so we need to have 'verbs.m'
 *	sourced first.
 */

/* Most are private since we don't want anybody changing the stuff in the
   minimall area. */

/* All rooms in this area use this routine as their graphics drawing routine.
   It works with the code in 'graphics.m'. */

define tp_mall MINI_MALL_ID NextEffectId().

define tp_mall proc drawMiniMall()void:

    if not KnowsEffect(nil, MINI_MALL_ID) then
	DefineEffect(nil, MINI_MALL_ID);

	GSetImage(nil, "Town/mall");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 16, 16);
	    GRectangle(nil, 129, 68, false);
	    GAMove(nil, 59, 32);
	    GRDraw(nil, 43, 0);
	    GRDraw(nil, 8, 8);
	    GRDraw(nil, 0, 20);
	    GRDraw(nil, -8, 8);
	    GRDraw(nil, -43, 0);
	    GRDraw(nil, -8, -8);
	    GRDraw(nil, 0, -20);
	    GRDraw(nil, 8, -8);
	    GRDraw(nil, 0, -16);
	    GAMove(nil, 102, 16);
	    GRDraw(nil, 0, 16);
	    GAMove(nil, 110, 40);
	    GRDraw(nil, 35, 0);
	    GAMove(nil, 110, 60);
	    GRDraw(nil, 35, 0);
	    GAMove(nil, 102, 68);
	    GRDraw(nil, 0, 16);
	    GAMove(nil, 59, 68);
	    GRDraw(nil, 0, 16);
	    GAMove(nil, 16, 60);
	    GRDraw(nil, 35, 0);
	    GAMove(nil, 16, 40);
	    GRDraw(nil, 35, 0);

	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 110, 41);
	    GRDraw(nil, 0, 18);
	    GAMove(nil, 145, 41);
	    GRDraw(nil, 0, 18);

	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 76, 32);
	    HorizontalDoor();
	    GAMove(nil, 76, 68);
	    HorizontalDoor();
	    GAMove(nil, 51, 46);
	    VerticalDoor();
	    GAMove(nil, 57, 34);
	    NorthWestDoor();
	    GAMove(nil, 53, 62);
	    NorthEastDoor();
	    GAMove(nil, 104, 34);
	    NorthEastDoor();
	    GAMove(nil, 108, 62);
	    NorthWestDoor();

	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 30, 31);
	    GText(nil, "GR");
	    GAMove(nil, 27, 53);
	    GText(nil, "LF");
	    GAMove(nil, 30, 75);
	    GText(nil, "BS");
	    GAMove(nil, 74, 27);
	    GText(nil, "MR");
	    GAMove(nil, 74, 53);
	    GText(nil, "MM");
	    GAMove(nil, 74, 79);
	    GText(nil, "ST");
	    GAMove(nil, 116, 31);
	    GText(nil, "AR");
	    GAMove(nil, 116, 75);
	    GText(nil, "BK");
	Fi(nil);
	
	EndEffect();
    fi;
    CallEffect(nil, MINI_MALL_ID);
corp;

define tp_mall MALL_MAP_GROUP NextMapGroup().

/*
 * The mall entrance room has a bunch of direction specific descriptions and
 * messages. It also contains the 'enter-exit machine', a bench to sit on,
 * and a hidden exit under the plate in the floor.
 */

define tp_mall r_underPlate CreateThing(r_indoors).	/* needed here */

/* r_mallEntrance is in tp_misc, since is used in other files */
define tp_misc r_mallEntrance CreateThing(r_indoors).
SetupRoom(r_mallEntrance, "in a small public passageway", "").
r_mallEntrance@p_rWestDesc := "You can see back into the mini mall.".
r_mallEntrance@p_rWestMessage := "You walk into the mini mall.".
r_mallEntrance@p_rWestOMessage := "walks into the mini mall.".
r_mallEntrance@p_rWestEMessage := "comes from the mini mall.".
r_mallEntrance@p_rEastDesc := "You can see out towards the street.".
r_mallEntrance@p_rEastMessage := "You walk out onto the sunny street.".
r_mallEntrance@p_rEastOMessage := "walks out onto the street.".
r_mallEntrance@p_rEastEMessage := "comes in from the street.".
r_mallEntrance@p_rNoGoString := "You cannot walk through concrete.".
RoomGraphics(r_mallEntrance, "Mall", "Entrance", MALL_MAP_GROUP, 124, 47,
	     drawMiniMall).
define tp_mall o_bench CreateThing(nil).
SetupObject(o_bench, r_mallEntrance, "bench;wooden",
    "The bench is a bit faded, but quite usable. There is room for 3 people "
    "to sit on it.").
o_bench@p_oCanSitOn := 4.	/* one greater than actual capacity */
o_bench@p_oNotGettable := true.
FakeObject(CreateThing(nil), r_mallEntrance, "floor",
    "There is a 3 foot square metal plate set into the floor. It looks like "
    "it can be raised on its hinges.").
r_mallEntrance@p_rDownDesc :=
    "There is a 3 foot square metal plate set into the floor. It looks like "
    "it can be raised on its hinges.".
define tp_mall proc walkOnPlate()status:
    Print("There is a metallic clanging sound as you get here.\n");
    OPrint("Clang!\n");
    /* walking on the plate can also be heard in the room under the plate */
    ABPrint(r_underPlate, nil, nil, "Clang!\n");
    continue
corp;
AddAnyEnterChecker(r_mallEntrance, walkOnPlate, false).
/* We can operate on the plate from either above it or below it. So, we
   define a generic one, and inherit from it for the ones that are in the
   two rooms. */
define tp_mall o_entrancePlate CreateThing(nil).
FakeModel(o_entrancePlate,
    "plate;metal.plate;dirty,metal,metallic,3,foot,square,hinged",
    "The plate is quite battered, and sags slightly in the middle. There are "
    "hinges on one side, and a small, recessed handle on the opposite side.").
o_entrancePlate@p_oSmellString := "It smells like very dirty metal.".
o_entrancePlate@p_oTouchString := "It feels like very dirty metal.".
o_entrancePlate@p_oLowerString := "The plate cannot be lowered any further.".
o_entrancePlate@p_oCloseString := "The plate is already closed.".
o_entrancePlate@p_oNotLocked := true.
define tp_mall o_entrancePlate1 CreateThing(o_entrancePlate).	/* inherit */
SetThingStatus(o_entrancePlate1, ts_wizard).
AddTail(r_mallEntrance@p_rContents, o_entrancePlate1).
Scenery(r_mallEntrance, "hinge.handle;small,recessed").
define tp_mall proc plateLift1()status:
    thing me;

    me := Me();
    if me@p_pPosition ~= POS_NONE then
	Print("You are still " + ShowPosition(me) + "\n");
	fail
    else
	Print("The plate lifts easily on its hinges. You see a metal ladder "
	    "leading down into a small space under the passageway. You climb "
	    "down the ladder, and the plate closes over you.\n");
	if me@p_pHidden then
	    OPrint("The metal plate lifts for a moment, then closes.\n");
	else
	    OPrint(Capitalize(me@p_pName) +
	     " lifts the metal plate in the floor and descends beneath it.\n");
	fi;
	LeaveRoomStuff(r_underPlate, D_DOWN, MOVE_SPECIAL);
	EnterRoomStuff(r_underPlate, D_UP, MOVE_NORMAL);
	succeed
    fi
corp;
o_entrancePlate1@p_oLiftChecker := plateLift1.
o_entrancePlate1@p_oOpenChecker := plateLift1.
o_entrancePlate1@p_Image := "Town/plateTop".

/* Exercise for the reader: make the plate have an open/closed state, so that
   the player must open the plate, then go down. You should use functions
   dependent on its state for all relevant descriptions, actions, etc. Don't
   forget all the stuff later on for the other side of the plate! */

/* For the central area of the minimall, there is not much, but we continue
   with the direction messages for the mall entrance. */

define tp_mall r_miniMall CreateThing(r_indoors).
SetupRoom(r_miniMall, "in the mini mall",
    "This is a small shopping area which collects together a number of useful "
    "services. The seven individual areas are distributed around the sides "
    "of the mall, and a passageway to the street is to the east.").
Connect(r_mallEntrance, r_miniMall, D_WEST).
Connect(r_mallEntrance, r_miniMall, D_ENTER).
r_miniMall@p_rEastDesc :=
    "A large, gloomy passageway heads to the east. You can see something on "
    "the floor half-way through, and daylight at the far end.".
r_miniMall@p_rEastImage := "Town/mall-E".
r_miniMall@p_rEastMessage := "You head into the passageway.".
r_miniMall@p_rEastOMessage := "heads into the passageway.".
r_miniMall@p_rEastEMessage := "arrives from the passageway.".
r_miniMall@p_rExitDesc :=
    "A large, gloomy passageway heads to the east. You can see something on "
    "the floor half-way through, and daylight at the far end.".
r_miniMall@p_rExitMessage := "You head into the passageway.".
r_miniMall@p_rExitOMessage := "heads into the passageway.".
r_miniMall@p_rExitImage :="Town/mall-E".
RoomGraphics(r_miniMall, "Mini", "Mall", MALL_MAP_GROUP, 78, 47, drawMiniMall).

/* SysAdmin's study is a hidden room, and it's graphic is a random set of
   coloured rectangles (likely different each time). */

define tp_mall r_SysAdminsStudy CreateThing(r_indoors).
SetupRoom(r_SysAdminsStudy, "in SysAdmin's study",
    "The mini mall is magically below you.").
define tp_mall proc drawStudy()void:
    int i, x, y;

    for i from 1 upto Random(20) + 10 do
	GSetPen(nil, Random(32));
	x := Random(159);
	y := Random(99);
	GAMove(nil, x, y);
	GRectangle(nil, Random(160 - x), Random(100 - x), true);
    od;
    /* force a re-draw on look */
    Me()@p_MapGroup := UNKNOWN_MAP_GROUP;
corp;
RoomGraphics(r_SysAdminsStudy, "SysAdmin's", "Study", NextMapGroup(), 0, 0,
	     drawStudy).
HConnect(r_miniMall, r_SysAdminsStudy, D_UP).
HConnect(r_SysAdminsStudy, r_miniMall, D_DOWN).
define tp_mall m_watcher CreateThing(nil).
CreateMachine("", m_watcher, r_miniMall, nil).
define tp_mall proc watchHandler(string message)void:
    SetPrefix("MM: ");
    /* this is dangerous! */
    ABPrint(r_SysAdminsStudy, nil, nil, message);
    SetPrefix("");
corp;
ignore SetMachineOther(m_watcher, watchHandler).

/* arrivals room is created in util.m */
Connect(r_miniMall, r_arrivals, D_NORTHEAST).
UniConnect(r_arrivals, r_miniMall, D_EXIT).
r_arrivals@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_arrivals, "Arrivals", "Room", MALL_MAP_GROUP, 120, 25,
	     drawMiniMall).

/* The actual mail service is defined later, in 'mail.m' */

/* r_mailRoom is in tp_misc, since it is needed in other files */
define tp_misc r_mailRoom CreateThing(r_indoors).
SetupRoom(r_mailRoom, "in the mail room",
    "This room looks much like all mail rooms. A bank of little "
    "lockable boxes fills one wall. Another is filled by a long counter, "
    "which has a couple of service positions screened with metal bars. "
    "You can REGISTER at the wickets to send and receive mail, and you can "
    "come here to read any mail that people have sent you.").
Connect(r_miniMall, r_mailRoom, D_NORTH).
UniConnect(r_mailRoom, r_miniMall, D_EXIT).
r_mailRoom@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_mailRoom, "Mail", "Room", MALL_MAP_GROUP, 78, 21, drawMiniMall).
Scenery(r_mailRoom,
    "bank.boxes,box;bank,of,little,lockable.lock."
    "counter;long."
    "position,wicket;service."
    "bar;metal").

/*
 * The garbage room. If you drop something you own here, it is destroyed.
 * There is also a slightly persistent bad smell - shows the use of attaching
 * verb-specific stuff to the the player.
 */

/* r_garbageRoom is in tp_misc since it is needed in other files */
define tp_misc r_garbageRoom CreateThing(r_indoors).
SetupRoom(r_garbageRoom, "in the garbage room",
    "Drop things here to dispose of them.").
Connect(r_miniMall, r_garbageRoom, D_NORTHWEST).
UniConnect(r_garbageRoom, r_miniMall, D_EXIT).
/* NOTE: not 'utility' - we want to be able to ClearThing the stuff */
define tp_mall proc garbageDrop(thing th)status:
    thing carryer;
    string name;

    if Owner(th) = SysAdmin or Mine(th) then
	carryer := th@p_oCarryer;
	if carryer ~= nil then
	    if th@p_oCreator = Me() or th@p_oCreator = CharacterThing(SysAdmin)
	    then
		CancelAllDoAfters(th);
		name := FormatName(th@p_oName);
		ZapObject(th);
		if not carryer@p_pHidden then
		    ABPrint(r_garbageRoom, carryer, carryer,
			Capitalize(carryer@p_pName) + AAn(" drops", name) +
			" which vanishes!\n");
		else
		    ABPrint(r_garbageRoom, carryer, carryer,
			Capitalize(AAn("", name)) +
			" appears, drops, and vanishes!\n");
		fi;
		SPrint(carryer, "You drop the " + name + " which vanishes!\n");
		DelElement(carryer@p_pCarrying, th);
		/* we do NOT want to continue with the normal drop actions */
		succeed
	    else
		continue
	    fi
	else
	    continue
	fi
    else
	continue
    fi
corp;
AddRoomDropChecker(r_garbageRoom, garbageDrop, false).
define tp_mall proc garbageSmellDisable()status:
    Print("Your nose is still disabled!\n");
    if Here() ~= r_garbageRoom then
	Me() -- p_oSmellChecker;
    fi;
    succeed
corp;
define tp_mall proc garbageSmell()status:
    if It() = nil then
	Print("This room smells distinctly like a garbage room!\n");
    else
	Print("You can't smell the ");
	Print(FormatName(It()@p_oName));
	Print(" over the smell of this room!\n");
    fi;
    Me()@p_oSmellChecker := garbageSmellDisable;
    succeed
corp;
r_garbageRoom@p_oSmellChecker := garbageSmell.
r_garbageRoom@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_garbageRoom, "Garbage", "Room", MALL_MAP_GROUP, 34, 25,
	     drawMiniMall).

/* lost and found room is created in util.m */
Connect(r_miniMall, r_lostAndFound, D_WEST).
UniConnect(r_lostAndFound, r_miniMall, D_EXIT).
r_lostAndFound@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_lostAndFound, "Lost & Found", "Room", MALL_MAP_GROUP, 31, 47,
	     drawMiniMall).

/*
 * The beauty shop allows a number of additional activities. Non-graphics
 * players can REGISTER to change their description. Graphics players are given
 * a couple of extra on-screen buttons, which call up the icon editor in
 * 'icons.m' to edit their icon or cursor. A third button allows editing
 * their description via the remote client. There is also use of the voice
 * synthesis when you enter the room.
 */

define tp_mall ICON_BUTTON	100.
define tp_mall CURSOR_BUTTON	101.
define tp_mall DESC_BUTTON	102.
define tp_mall BEAUTY_SPEECH_ID NextSoundEffectId().
define tp_mall proc addBeautyButtons()void:
    AddButton(166, 83, ICON_BUTTON, "Icon");
    AddButton(212, 83, CURSOR_BUTTON, "Cursor");
    AddButton(273, 83, DESC_BUTTON, "Desc");
    Me()@p_pStandardButtonsNow := false;
corp;
define tp_mall proc eraseBeautyButtons()void:
    EraseButton(ICON_BUTTON);
    EraseButton(CURSOR_BUTTON);
    EraseButton(DESC_BUTTON);
    Me()@p_pStandardButtonsNow := true;
    AbortEffect(nil, EFFECT_SPEECH, BEAUTY_SPEECH_ID);
corp;
define tp_mall proc beautySpeak()void:
    /* if voice is not on, will not do this */
    VParams(nil, 160, 250, 0, 1, 64);
    VNarrate(nil,
	"GUH4D DEY3. REHJIHSTER TUW CHEY1NCH YOHR DIYSKRIH1PSHUN.",
	BEAUTY_SPEECH_ID);
    VReset(nil);
corp;
define tp_mall r_beautyShop CreateThing(r_indoors).
SetupRoom(r_beautyShop, "in the beauty shop",
    "You can REGISTER here to have your appearance changed.").
define tp_mall proc utility beautyEnd(string s)void:
    string name;
    thing me;

    if s = "" then
	Print("Description not changed.\n");
    else
	me := Me();
	name := Capitalize(me@p_pName);
	OPrint(name + " has just been made over.\n");
	s := name + " " + s;
	me@p_pDesc := s;
	Print("Nip! Tuck! Snip-snip! All done. "
	    "When people look at you now, they will see:\n"
	);
	/* note the use of NPrint! */
	NPrint(s + "\n");
    fi;
    if Here() = r_beautyShop then
	/* Were removed when DESC button hit. No-op if no graphics. */
	addBeautyButtons();
    fi;
corp;
/* this is not 'utility' so that we don't get '@'s on the output */
define tp_mall proc beautyRegister()bool:
    thing me;
    string name;
    int len;
    bool res;

    me := Me();
    name := me@p_pName;
    OPrint(Capitalize(name) + " decides to get a makeover.\n");
    len := Length(name) + 1;
    name := me@p_pDesc;
    name := SubString(name, len, Length(name) - len);
    res := GetDocument("beauty> ", "Enter your new description", name,
		       beautyEnd, false);
    if not res then
	/* Were removed when DESC button hit. No-op if no graphics. */
	addBeautyButtons();
    fi;
    res
corp;
r_beautyShop@p_rRegisterAction := beautyRegister.
Connect(r_miniMall, r_beautyShop, D_SOUTHWEST).
UniConnect(r_beautyShop, r_miniMall, D_EXIT).
r_beautyShop@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_beautyShop, "Beauty", "Shop", MALL_MAP_GROUP, 34, 69,
	     drawMiniMall).
define tp_mall p_pBeautyHandlerSave CreateActionProp().
define tp_mall p_pInIconEdit CreateBoolProp().
define tp_mall proc beautyReset()void: corp;	/* replaced later */
define tp_mall proc beautyRestore()void:
    thing me;

    me := Me();
    me -- p_pInIconEdit;
    me@p_MapGroup := NO_MAP_GROUP;
    EnterRoomDraw();
    if Here() ~= r_beautyShop then
	beautyReset();
    elif me@p_pBeautyHandlerSave ~= nil then
	addBeautyButtons();
    /* otherwise, called from EndIconEdit called from beautyReset */
    fi;
corp;
define tp_mall proc beautyButtonHandler(int whichButton)void:

    if whichButton = ICON_BUTTON then
	eraseBeautyButtons();
	Me()@p_pInIconEdit := true;
	StartIconEdit(beautyRestore);
    elif whichButton = CURSOR_BUTTON then
	eraseBeautyButtons();
	Me()@p_pInIconEdit := true;
	StartCursorEdit(beautyRestore);
    elif whichButton = DESC_BUTTON then
	eraseBeautyButtons();
	ignore beautyRegister();
    else
	call(Me()@p_pBeautyHandlerSave, void)(whichButton);
    fi;
corp;
define tp_mall proc beautyActiveHandler()void:
    action a;

    /* if graphics is not on, will not do the buttons */
    addBeautyButtons();
    a := SetCharacterButtonAction(beautyButtonHandler);
    /* The handler could already have been set if the character was in
       the Beauty Shop when a backup was made, and the server later runs
       from that backup. */
    if a ~= beautyButtonHandler then
	Me()@p_pBeautyHandlerSave := a;
    fi;
    Me() -- p_pInIconEdit;
    beautySpeak();
corp;
define tp_mall proc beautyEnter()status:
    thing me;

    me := Me();
    if me@p_pStandardButtonsNow and not me@p_pInIconEdit then
	if not Editing() then
	    addBeautyButtons();
	fi;
	me@p_pBeautyHandlerSave :=
	    SetCharacterButtonAction(beautyButtonHandler);
	AddHead(me@p_pEnterActions, beautyActiveHandler);
    fi;
    beautySpeak();
    continue
corp;
define tp_mall proc beautyExit()status:
    beautyReset();
    AbortEffect(nil, EFFECT_SPEECH, BEAUTY_SPEECH_ID);
    continue
corp;
replace beautyReset()void:
    thing me;
    action a;

    me := Me();
    a := me@p_pBeautyHandlerSave;
    if a ~= nil then
	/* delete this property *before* calling EndIconEdit */
	me -- p_pBeautyHandlerSave;
	if me@p_pInIconEdit then
	    EndIconEdit();
	else
	    eraseBeautyButtons();
	fi;
	ignore SetCharacterButtonAction(a);
	DelElement(me@p_pEnterActions, beautyActiveHandler);
    fi;
corp;
AddAnyEnterChecker(r_beautyShop, beautyEnter, false).
AddAnyLeaveChecker(r_beautyShop, beautyExit, false).

/*
 * The store in the mall has a number of items for sale. The fanciest is
 * the camera. Also note the universal carryall, which is a container with
 * no restrictions on what you can put into it.
 */

define tp_mall r_mallStore CreateThing(r_indoors).
SetupRoom(r_mallStore, "in a small store",
    "You can SHOP for supplies here.").
AddForSale(r_mallStore, "pen;ballpoint.pen;ball,point",
    "There is nothing special about the ballpoint pen. It will "
    "provide a lifetime of trouble-free writing.",
    1, nil)@p_Image := "Town/pen".
AddForSale(r_mallStore, "pad,paper;writing.paper;pad,of",
    "The writing pad is quite ordinary. It provides an "
    "infinite supply of sheets to write on.",
    1, nil)@p_Image := "Town/pad".
define tp_mall o_carryall AddForSale(r_mallStore, "carryall;universal",
    "The universal carryall is a somewhat magical item. You can put as much "
    "stuff, of any size and shape, as you want into it.",
    1000, nil).
o_carryall@p_oContents := CreateThingList().
o_carryall@p_oCapacity := 1000000.
o_carryall@p_Image := "Town/carryall".

define tp_mall o_lamp AddForSale(r_mallStore,
    "lamp;everlight.switch;push-button,push,button,on-off,on,off",
    "The everlight lamp is a small ovoid made of some indeterminate material. "
    "It has an opening on the front through which soft white light is "
    "emitted. There seems to be no identifiable power source. There is a "
    "push-button on-off switch in the middle of it.",
    5000, nil).
o_lamp@p_oActivateChecker := ActiveLightObject.
o_lamp@p_oLightChecker := ActiveLightObject.
o_lamp@p_oDeActivateChecker := ActiveUnLightObject.
o_lamp@p_oExtinguishChecker := ActiveUnLightObject.
o_lamp@p_Image := "Town/lamp".
define tp_mall proc lampPutIn(thing lamp, container)status:
    if lamp@p_oLight then
	lamp@p_oLight := false;
	RemoveLight();
	lamp@p_oLight := true;
    fi;
    continue
corp;
o_lamp@p_oPutMeInChecker := lampPutIn.
define tp_mall proc lampTakeFrom(thing lamp, container)status:
    if lamp@p_oLight then
	AddLight();
    fi;
    continue
corp;
o_lamp@p_oTakeMeFromChecker := lampTakeFrom.

define tp_mall p_oShotsLeft CreateIntProp().
define tp_mall proc cameraBuy()status:
    It()@p_oShotsLeft := 12;
    continue
corp;
define tp_mall proc cameraDesc()string:
    int n;

    n := It()@p_oShotsLeft;
    "The instant camera is an ugly box-like contraption with a small lens on "
    "one side and a big slot for the pictures at the bottom. There is a "
    "flash attachment on top. It appears to be quite functional. "
    "You can use it with the 'photograph' or 'snap' commands. "
    "You can take pictures of the current location, of objects, or of "
    "people/animals. The little indicator shows that the camera has " +
	if n = 1 then
	    "one shot"
	elif n = 0 then
	    "no shots"
	else
	    IntToString(n) + " shots"
	fi +
    " left."
corp;
define tp_mall o_camera AddForSale(r_mallStore, "camera;instant", "", 50,
    cameraBuy).
o_camera@p_oDescAction := cameraDesc.
o_camera@p_Image := "Town/camera".
MakeStore(r_mallStore).
Connect(r_miniMall, r_mallStore, D_SOUTH).
UniConnect(r_mallStore, r_miniMall, D_EXIT).
r_mallStore@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_mallStore, "Small", "Store", MALL_MAP_GROUP, 78, 73,
	     drawMiniMall).

/*
 * Code to implement photographs and photography. This code should really
 * go elsewhere, but I'm not sure where.
 */

/* o_photograph is in tp_misc since it is used in bguild.m */
define tp_misc o_photograph CreateThing(nil).
o_photograph@p_oHome := r_garbageRoom.
o_photograph@p_Image := "Town/photo".
define tp_mall proc createPhotograph(string name, desc)thing:
    string noun, adj;
    thing photo, me;
    int i;

    if name = "" then
	name := "photograph.photo.picture.snapshot";
    else
	name := FormatName(name);
	name := GetNounPhrase(G, name, 0);
	i := Index(name, ";");
	if i = -1 then
	    name := name + ";photograph,of." + name + ";photo,of." +
		    name + ";picture,of." + name + ";snapshot,of." +
		    "photograph.photo.picture.snapshot";
	else
	    noun := SubString(name, 0, i);
	    adj := SubString(name, i + 1, Length(name) - i - 1);
	    name := noun + ";photograph,of," + adj + "." +
		    noun + ";picture,of," + adj + "." +
		    noun + ";photo,of," + adj + "." +
		    noun + ";snapshot,of," + adj +
		    ".photograph.photo.picture.snapshot";
	fi;
    fi;
    me := Me();
    Print("Click - FLASH!!\n");
    OPrint("FLASH! - " + me@p_pName + " takes a photograph.\n");
    photo := CreateThing(o_photograph);
    photo@p_oCarryer := me;
    photo@p_oCreator := me;
    photo@p_oName := name;
    photo@p_oDesc := desc;
    SetThingStatus(photo, ts_public);
    GiveThing(photo, SysAdmin);
    AddTail(me@p_pCarrying, photo);
    photo
corp;

define tp_mall proc v_photograph(string what)bool:
    thing here, camera, object;
    action a;
    string name, desc, ambig, read;
    int count, dir;
    status st;
    bool wasScenery;

    here := Here();
    if FindChildOnList(Me()@p_pCarrying, o_camera) then
	camera := FindResult();
	count := camera@p_oShotsLeft;
	if count = 0 then
	    Print("The camera has no shots left.\n");
	    false
	elif what = "" then
	    /* taking a picture of the current location */
	    a := here@p_rNameAction;
	    if a ~= nil then
		name := call(a, string)();
	    else
		name := here@p_rName;
	    fi;
	    name := name + ".";
	    a := here@p_rDescAction;
	    if a ~= nil then
		name := name + "\n";
		desc := call(a, string)();
	    elif here@p_rDesc ~= "" then
		name := name + "\n";
		desc := here@p_rDesc;
	    else
		desc := "";
	    fi;
	    camera@p_oShotsLeft := count - 1;
	    ignore createPhotograph("",
		"This photograph was taken " + name + desc);
	    true
	else
	    object := FindAgent(what);
	    if object ~= nil then
		a := object@p_pDescAction;
		if a ~= nil then
		    SetIt(object);
		    desc := call(a, string)();
		elif object@p_pDesc ~= "" then
		    desc := object@p_pDesc;
		else
		    desc := name + "is a nondescript adventurer.";
		fi;
		camera@p_oShotsLeft := count - 1;
		ignore createPhotograph(object@p_pName, desc);
		true
	    else
		dir := DirMatch(what);
		if dir ~= -1 then
		    desc := here@(DirDesc(dir));
		    if desc = "" then
			desc := "The photograph shows nothing special.";
		    else
			desc := desc;
		    fi;
		    camera@p_oShotsLeft := count - 1;
		    ignore createPhotograph("", desc);
		    true
		else
		    /* player is photographing an object */
		    name := FormatName(what);
		    object := nil;
		    wasScenery := false;
		    ambig := " is ambiguous here.\n";
		    st := FindName(Me()@p_pCarrying, p_oName, what);
		    if st = fail then
			st := FindName(here@p_rContents, p_oName, what);
			if st = fail then
			    if MatchName(here@p_rScenery, what) ~= -1 then
				wasScenery := true;
			    else
				Print(IsAre("There", "no", name, "here.\n"));
			    fi;
			elif st = continue then
			    Print(name);
			    Print(ambig);
			else
			    object := FindResult();
			fi;
		    elif st = continue then
			Print(name);
			Print(ambig);
		    else
			object := FindResult();
		    fi;
		    if object = nil then
			if wasScenery then
			    camera@p_oShotsLeft := count - 1;
			    ignore createPhotograph(what,
				"The photograph shows nothing special.");
			    true
			else
			    false
			fi
		    elif object = camera then
			Print("No matter how you twist or turn it, you "
			    "cannot get the camera to take a picture of "
			    "itself.\n");
			false
		    else
			a := object@p_oDescAction;
			if a ~= nil then
			    SetIt(object);
			    desc := call(a, string)();
			elif object@p_oDesc ~= "" then
			    desc := object@p_oDesc;
			else
			    desc := "The photograph shows nothing special.";
			fi;
			a := object@p_oReadAction;
			if a ~= nil then
			    read := call(a, string)();
			elif object@p_oReadString ~= "" then
			    read := object@p_oReadString;
			else
			    read := "";
			fi;
			camera@p_oShotsLeft := count - 1;
			object := createPhotograph(what, desc);
			if read ~= "" then
			    object@p_oReadString := read;
			fi;
			true
		    fi
		fi
	    fi
	fi
    else
	Print("You don't have a camera!\n");
	false
    fi
corp;

Verb1(G, "photograph", 0, v_photograph).
Synonym(G, "photograph", "photo").
Synonym(G, "photograph", "snap").

/*
 * The bank in the minimall uses the bank code from 'util.m', and uses
 * speech when you enter it.
 */

define tp_mall BANK_SPEECH_ID NextSoundEffectId().
define tp_mall r_mallBank CreateThing(r_indoors).
SetupRoom(r_mallBank, "in a small local bank",
    "You can use the commands 'deposit <amount>', 'withdraw <amount>' and "
    "'balance' here.").
Connect(r_miniMall, r_mallBank, D_SOUTHEAST).
UniConnect(r_mallBank, r_miniMall, D_EXIT).
MakeBank(r_mallBank).
r_mallBank@p_rNoGoString := "You must go through the doors.".
RoomGraphics(r_mallBank, "Bank", "", MALL_MAP_GROUP, 120, 69, drawMiniMall).
define tp_mall proc bankSay()status:
    if VOn(nil) then
	VParams(nil, 150, 120, 0, 0, 64);
	VNarrate(nil,
	    "WEH5LKAHM KAH4STAHMER. DIH4PAAZIHT MAH4NIY TUWDEY1.",
	    BANK_SPEECH_ID);
	VReset(nil);
    fi;
    continue
corp;
AddAnyEnterChecker(r_mallBank, bankSay, false).
define tp_mall proc bankExit()status:
    if VOn(nil) then
	AbortEffect(nil, EFFECT_SPEECH, BANK_SPEECH_ID);
    fi;
    continue
corp;
AddAnyLeaveChecker(r_mallBank, bankExit, false).

/*
 * The service tunnels under the plate in the mall entrance are mostly
 * description and scenery, although there is a door to open, and you get
 * 100 blutos at the far end.
 */

/* actual room thing created earlier */

SetupRoom(r_underPlate, "in a small, cramped space under the passageway",
    "Immediately over your head is a metal plate which can be lifted to "
    "allow you to exit. The walls of this chamber are of stained concrete "
    "blocks. The floor is of cracked, dirty concrete. A round shaft heads "
    "down into darkness. There are rusty metal rungs embedded in one side "
    "of the shaft.").
Scenery(r_underPlate,
    "floor,concrete;cracked,dirty,concrete,of."
    "wall,block;stained,concrete,block."
    "shaft;round."
    "rung;rusty,metal."
    "hinge."
    "handle;small,recessed").
AutoGraphics(r_underPlate, AutoTunnels).
AutoPens(r_underPlate, C_DARK_BROWN, C_LIGHT_GREY, 0, 0).
define tp_mall o_entrancePlate2 CreateThing(o_entrancePlate).	/* inherit */
SetThingStatus(o_entrancePlate2, ts_wizard).
AddTail(r_underPlate@p_rContents, o_entrancePlate2).
r_underPlate@p_rUpDesc :=
    "There is a 3 foot square metal plate in the ceiling. It looks like "
    "it can be raised on its hinges.".
define tp_mall proc plateLift3()status:
    Print("You lift the plate, climb up to the passageway, and lower the "
	"plate back into place.\n");
    LeaveRoomStuff(r_mallEntrance, D_UP, MOVE_NORMAL);
    EnterRoomStuff(r_mallEntrance, D_DOWN, MOVE_SPECIAL);
    if Me()@p_pHidden then
	OPrint("The metal plate in the floor lifts up,"
	    " then lowers back into place.\n");
    else
	OPrint("The metal plate in the floor lifts up and " +
	    Capitalize(Me()@p_pName) +
	    " emerges and lowers the plate back into place.\n");
    fi;
    succeed
corp;
o_entrancePlate2@p_oLiftChecker := plateLift3.
o_entrancePlate2@p_oOpenChecker := plateLift3.
o_entrancePlate2@p_Image := "Town/plateBottom".

define tp_mall r_underMall CreateThing(r_indoors).
SetThingStatus(r_underMall, ts_readonly).
AutoGraphics(r_underMall, AutoTunnels).
AutoPens(r_underMall, C_DARK_BROWN, C_LIGHT_GREY, 0, 0).

define tp_mall r_underMall1 CreateThing(r_underMall).
SetupRoomD(r_underMall1, "at the end of a passageway",
    "A low, narrow passageway from the northwest ends here. A round shaft "
    "with metal wrungs on one side leads upward.").
Connect(r_underPlate, r_underMall1, D_DOWN).
Scenery(r_underMall1, "shaft;round.wrung;rusty,metal").

define tp_mall r_underMall2 CreateThing(r_underMall).
SetupRoomD(r_underMall2, "at a corner in a passageway", "").
Connect(r_underMall1, r_underMall2, D_NORTHWEST).

define tp_mall r_underMall3 CreateThing(r_underMall).
SetupRoomD(r_underMall3, "at the end of a passageway",
    "The passage extends to the east, and a steep staircase leads downwards.").
Connect(r_underMall2, r_underMall3, D_WEST).
Scenery(r_underMall3, "stair,staircase;steep").

define tp_mall r_underMall5 CreateThing(r_indoors).
define tp_mall UTILITY_TUNNEL_ID NextEffectId().
define tp_mall proc drawUtilityTunnel()void:

    if not KnowsEffect(nil, UTILITY_TUNNEL_ID) then
	DefineEffect(nil, UTILITY_TUNNEL_ID);
	GSetImage(nil, "Town/utilityTunnel");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_BROWN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 65, 0);
	    GRectangle(nil, 30, 99, true);
	    GSetPen(nil, C_RED_ORANGE);
	    GAMove(nil, 97, 0);
	    GRectangle(nil, 1, 99, true);
	    GSetPen(nil, C_DARK_GREEN);
	    GAMove(nil, 62, 0);
	    GRectangle(nil, 1, 99, true);
	    GSetPen(nil, C_BLUE);
	    GAMove(nil, 60, 0);
	    GRectangle(nil, 1, 99, true);
	    GSetPen(nil, C_CADMIUM_YELLOW);
	    GAMove(nil, 100, 0);
	    GRDraw(nil, 0, 99);
	    GAMove(nil, 102, 0);
	    GRDraw(nil, 0, 99);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, UTILITY_TUNNEL_ID);
corp;

define tp_mall r_underMall4 CreateThing(r_indoors).
SetupRoomD(r_underMall4, "at the bottom of some steep stairs",
    "The stairs head up to the east, but the west is blocked by a heavy "
    "metal door. The door has a sign reading \"Authorized Personnel Only\", "
    "but it does not appear to be locked.").
Connect(r_underMall3, r_underMall4, D_DOWN).
Connect(r_underMall3, r_underMall4, D_WEST).
Sign(r_underMall4, "sign;security,door",
    "The sign is red with white lettering, and is firmly attached to the "
    "door.",
    "\"Authorized Personnel Only\"").
define tp_mall o_securityDoor CreateThing(nil).
FakeModel(o_securityDoor, "door;heavy,metal,security",
    "The door is painted grey, but many scratches and dents show the metal "
    "underneath.").
o_securityDoor@p_oCloseString := "The door is already open.".
o_securityDoor@p_oNotLocked := true.
define tp_mall o_securityDoor1 CreateThing(o_securityDoor).
AddTail(r_underMall4@p_rContents, o_securityDoor1).
Scenery(r_underMall4, "lettering,letter;white.scratch.scratches.dent.metal").
o_securityDoor1@p_oListenString :=
    "You hear machine-like noises coming through the door.".
o_securityDoor1@p_Image := "Town/SecurityDoor1".
define tp_mall proc openSecurityDoor1()status:
    Print("You open the door and pass through. As you do, you are hit with a "
	"blast of warm air, light and noise.\n");
    ignore EnterRoom(r_underMall5, D_WEST, MOVE_NORMAL);
    succeed
corp;
o_securityDoor1@p_oOpenChecker := openSecurityDoor1.
define tp_mall SECURITY_DOOR_ID NextEffectId().
define tp_mall proc drawOutsideDoor()void:

    if not KnowsEffect(nil, SECURITY_DOOR_ID) then
	DefineEffect(nil, SECURITY_DOOR_ID);
	GSetImage(nil, "Town/securityDoor");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_BROWN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 66, 41);
	    GRectangle(nil, 93, 18, true);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 66, 46);
	    VerticalDoor();
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, SECURITY_DOOR_ID);
corp;
AutoGraphics(r_underMall4, drawOutsideDoor).

SetupRoom(r_underMall5, "in a pit in the tunnel floor",
    "Above you is the metal floor of the utility tunnel. Steep metal stairs "
    "lead up to a trapdoor in the floor. To your east is a metal security "
    "door.").
define tp_mall o_securityDoor2 CreateThing(o_securityDoor).
AddTail(r_underMall5@p_rContents, o_securityDoor2).
define tp_mall proc openSecurityDoor2()status:
    Print("You open the door and pass through.\n");
    ignore EnterRoom(r_underMall4, D_EAST, MOVE_NORMAL);
    succeed
corp;
o_securityDoor2@p_oOpenChecker := openSecurityDoor2.
o_securityDoor2@p_Image := "Town/SecurityDoor2".
Scenery(r_underMall5, "stair,floor,grill,grillwork;steep,metal."
	"dent.scratch.scratches.metal").
define tp_mall o_trapDoor CreateThing(nil).
FakeObject(o_trapDoor, r_underMall5, "door;trap.trapdoor", "").
o_trapDoor@p_oOpenString := "The trapdoor is already open.".
o_trapDoor@p_oCloseString := "The trapdoor cannot be closed.".
o_trapDoor@p_oNotLocked := true.
o_trapDoor@p_Image := "Town/trapdoor".
define tp_mall UTILITY_PIT_ID NextEffectId().
define tp_mall proc drawInsideDoor()void:

    if not KnowsEffect(nil, UTILITY_PIT_ID) then
	DefineEffect(nil, UTILITY_PIT_ID);
	GSetImage(nil, "Town/utilityPit");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_BROWN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 65, 41);
	    GRectangle(nil, 30, 18, true);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 95, 46);
	    VerticalDoor();
	    DrawUpArrow(C_GOLD);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, UTILITY_PIT_ID);
corp;
AutoGraphics(r_underMall5, drawInsideDoor).
RoomName(r_underMall5, "Pit", "").

define tp_mall r_underMall6 CreateThing(r_indoors).
SetupRoom(r_underMall6, "in a north-south utility tunnel",
    "Large pipes and cable trays line both walls of the tunnel. It is quite "
    "warm and fairly noisy in here. The floor here is a metal grillwork over "
    "a small pit. There is a trapdoor in the grillwork and you can make out "
    "a staircase going down beneath it.").
Connect(r_underMall5, r_underMall6, D_UP).
Scenery(r_underMall6,
    "grill;metal.grillwork;metal."
    "pipe;large."
    "tray;cable,large."
    "floor,grill,grillwork,stair,staircase;steep,metal,grill,grillwork."
    "wall;both."
    "pit;small").
AddTail(r_underMall6@p_rContents, o_trapDoor).
define tp_mall UTILITY_START_ID NextEffectId().
define tp_mall proc drawAbovePit()void:
    int i;

    if not KnowsEffect(nil, UTILITY_START_ID) then
	DefineEffect(nil, UTILITY_START_ID);
	GSetImage(nil, "Town/utilityStart");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    drawUtilityTunnel();
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 65, 41);
	    GRectangle(nil, 30, 18, false);
	    GAMove(nil, 68, 42);
	    for i from 0 upto 8 do
		GRDraw(nil, 0, 16);
		GRMove(nil, 3, -16);
	    od;
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, UTILITY_START_ID);
corp;
AutoGraphics(r_underMall6, drawAbovePit).
RoomName(r_underMall6, "Utility", "Tunnel").

define t_mall r_underMall7 CreateThing(r_indoors).
SetupRoomP(r_underMall7, "in a north-south utility tunnel",
    "You can go north, but the way south is blocked by a metal grill across "
    "the tunnel. The grill apparently divides the tunnel into separate "
    "sections.").
Connect(r_underMall6, r_underMall7, D_SOUTH).
Scenery(r_underMall7, "grill,grillwork;metal.pipe;large.tray;large,cable").
define tp_mall UTILITY_SOUTH_ID NextEffectId().
define tp_mall proc drawSouthEnd()void:

    if not KnowsEffect(nil, UTILITY_SOUTH_ID) then
	DefineEffect(nil, UTILITY_SOUTH_ID);
	GSetImage(nil, "Town/utilitySouth");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    drawUtilityTunnel();
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 65, 59);
	    GRDraw(nil, 30, 0);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, UTILITY_SOUTH_ID);
corp;
AutoGraphics(r_underMall7, drawSouthEnd).
RoomName(r_underMall7, "Utility", "Tunnel").

define t_mall r_underMall8 CreateThing(r_indoors).
SetupRoomP(r_underMall8, "in a north-south utility tunnel",
    "This large concrete tunnel is used to carry utility services such as "
    "steam, hot and cold water, electricity, communications, etc.").
Connect(r_underMall6, r_underMall8, D_NORTH).
Scenery(r_underMall8, "pipe;large.tray;large,cable").
AutoGraphics(r_underMall8, drawUtilityTunnel).
RoomName(r_underMall8, "Utility", "Tunnel").

define t_mall r_underMall9 CreateThing(r_indoors).
SetupRoomP(r_underMall9, "in a north-south utility tunnel",
    "You can go south, but the way north is blocked by a metal grill across "
    "the tunnel. The grill apparently divides the tunnel into separate "
    "sections.").
Connect(r_underMall8, r_underMall9, D_NORTH).
Scenery(r_underMall9, "grill,grillwork;metal.pipe;large.tray;large,cable").
define tp_mall giftGivenList CreateThingListProp().
r_underMall9@giftGivenList := CreateThingList().
define tp_mall proc checkForGift()status:
    thing me;

    me := Me();
    if FindElement(r_underMall9@giftGivenList, me) = -1 then
	AddTail(r_underMall9@giftGivenList, me);
	Print("You find 100 blutos!\n");
	me@p_pMoney := me@p_pMoney + 100;
    fi;
    continue
corp;
AddAnyEnterChecker(r_underMall9, checkForGift, false).
define tp_mall UTILITY_NORTH_ID NextEffectId().
define tp_mall proc drawNorthEnd()void:

    if not KnowsEffect(nil, UTILITY_NORTH_ID) then
	DefineEffect(nil, UTILITY_NORTH_ID);
	GSetImage(nil, "Town/utilityNorth");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    drawUtilityTunnel();
	    GSetPen(nil, C_MEDIUM_GREY);
	    GAMove(nil, 65, 41);
	    GRDraw(nil, 30, 0);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, UTILITY_NORTH_ID);
corp;
AutoGraphics(r_underMall9, drawNorthEnd).
RoomName(r_underMall9, "Utility", "Tunnel").

unuse tp_mall
