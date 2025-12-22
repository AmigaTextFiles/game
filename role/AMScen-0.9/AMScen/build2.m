/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * build2.m - the mouse/graphics builder interface.
 */

private tp_build2 CreateTable().
use tp_build2

define tp_build2 p_pCurrentTable CreateTableProp().
define tp_build2 p_pIdleSave CreateActionProp().
define tp_build2 p_pButtonEraser CreateActionProp().
define tp_build2 p_pHandlerSave1 CreateActionProp().
define tp_build2 p_pHandlerSave2 CreateActionProp().
define tp_build2 p_pHandlerSave3 CreateActionProp().
define tp_build2 p_pHandlerSave4 CreateActionProp().
define tp_build2 p_pHandlerSave5 CreateActionProp().
define tp_build2 p_pHandlerSave6 CreateActionProp().
define tp_build2 p_pDirectionNext CreateActionProp().
define tp_build2 p_pDirectionWhat CreateStringProp().
define tp_build2 p_pDirectionRoom1 CreateBoolProp().
define tp_build2 p_pSelectedDir CreateIntProp().
define tp_build2 p_pFirstDir CreateIntProp().
define tp_build2 p_pRoomKind CreateIntProp().
define tp_build2 p_pDescKind CreateIntProp().
    define tp_build2 DESC_DIRDESC     0.
    define tp_build2 DESC_DIRMESSAGE  1.
    define tp_build2 DESC_DIROMESSAGE 2.
    define tp_build2 DESC_DIREMESSAGE 3.
define tp_build2 p_pSelectedPen CreateIntProp().
define tp_build2 DummyGrammar CreateGrammar().
define tp_build2 p_pSelectedObject CreateThingProp().

define tp_build2 p_pCurrentObject CreateThingProp().
define tp_build2 p_pSelectedSymbol CreateStringProp().

define tp_build2 BUILD_BUTTON	17.

define tp_build2 EXIT_BUTTON	17.	/* used several places */
define tp_build2 MORE_BUTTON	18.	/* used several places */

define tp_build2 ROOM_BUTTON	19.
define tp_build2 OBJECT_BUTTON	20.
define tp_build2 POOF_BUTTON	21.
define tp_build2 SYMBOLHERE_BUTTON 22.
define tp_build2 TABLES_BUTTON	23.

/* EXIT_BUTTON = 17 */
define tp_build2 NEW_BUTTON	19.	/* used elsewhere also */
define tp_build2 SELECT_BUTTON	20.	/* used elsewhere also */
define tp_build2 USE_BUTTON	21.	/* used elsewhere also */
define tp_build2 UNUSE_BUTTON	22.
define tp_build2 SYMBOLS_BUTTON 23.
define tp_build2 DESCRIBE_BUTTON 24.

/* EXIT_BUTTON = 17 */
/* MORE_BUTTON = 18 */
/* NEW_BUTTON = 19 */
define tp_build2 NAME_BUTTON	21.	/* used elsewhere also */
define tp_build2 DESC_BUTTON	22.	/* used elsewhere also */
define tp_build2 AUTO_BUTTON	23.
define tp_build2 LINK_BUTTON	24.
define tp_build2 UNLINK_BUTTON	25.
define tp_build2 SAME_BUTTON	26.
define tp_build2 HIDE_BUTTON	27.
define tp_build2 SHOP_BUTTON	28.
define tp_build2 SELL_BUTTON	29.
define tp_build2 BANK_BUTTON	30.

/* EXIT_BUTTON = 17 */
/* MORE_BUTTON = 18 */
define tp_build2 DARK_BUTTON	19.
define tp_build2 LOCK_BUTTON	20.
define tp_build2 READONLY_BUTTON 21.
define tp_build2 WIZARD_BUTTON	22.
define tp_build2 PUBLIC_BUTTON	23.
define tp_build2 DD_BUTTON	24.
define tp_build2 DM_BUTTON	25.
define tp_build2 OM_BUTTON	26.
define tp_build2 EM_BUTTON	27.

/* EXIT_BUTTON = 17 */
define tp_build2 HELP_BUTTON	18.

define tp_build2 INDOORS_BUTTON 17.
define tp_build2 OUTDOORS_BUTTON 18.
define tp_build2 FOREST_BUTTON	19.
define tp_build2 FIELD_BUTTON	20.
define tp_build2 PATH_BUTTON	21.
define tp_build2 ROAD_BUTTON	22.
define tp_build2 SIDEWALK_BUTTON 23.
define tp_build2 PARK_BUTTON	24.
define tp_build2 TUNNEL_BUTTON	25.

/* EXIT_BUTTON = 17 */
define tp_build2 AUTO_KIND_BUTTON	18.
define tp_build2 AUTO_BGNDPEN_BUTTON	19.
define tp_build2 AUTO_FGNDPEN_BUTTON	20.
define tp_build2 AUTO_EDGEPEN_BUTTON	21.
define tp_build2 AUTO_DOORPEN_BUTTON	22.
define tp_build2 AUTO_NAME1_BUTTON	23.
define tp_build2 AUTO_NAME2_BUTTON	24.

/* EXIT_BUTTON = 17 */
define tp_build2 AUTO_ROAD_BUTTON	18.
define tp_build2 AUTO_PATH_BUTTON	19.
define tp_build2 AUTO_HALLROOM_BUTTON	20.
define tp_build2 AUTO_DOORROOM_BUTTON	21.
define tp_build2 AUTO_HALLWAY_BUTTON	22.
define tp_build2 AUTO_OPENAREA_BUTTON	23.
define tp_build2 AUTO_TUNNEL_BUTTON	24.
define tp_build2 AUTO_CHAMBER_BUTTON	25.

/* EXIT_BUTTON = 17 */
/* NEW_BUTTON = 19 */
/* SELECT_BUTTON = 20 */
/* DESC_BUTTON = 22 */
/* NAME_BUTTON = 21 */
define tp_build2 GET_BUTTON	23.
define tp_build2 ACT_BUTTON	24.
define tp_build2 CONTAINER_BUTTON 25.
define tp_build2 LIGHT_BUTTON	26.
define tp_build2 INVIS_BUTTON	27.
define tp_build2 POS_BUTTON	28.
define tp_build2 ACTWORD_BUTTON 29.
define tp_build2 ACTSTRING_BUTTON 30.

/* EXIT_BUTTON = 17 */
define tp_build2 SIT_IN_BUTTON	18.
define tp_build2 SIT_ON_BUTTON	19.
define tp_build2 LIE_IN_BUTTON	20.
define tp_build2 LIE_ON_BUTTON	21.
define tp_build2 STAND_IN_BUTTON 22.
define tp_build2 STAND_ON_BUTTON 23.

/* EXIT_BUTTON = 17 */
/* MORE_BUTTON = 18 */
define tp_build2 PLAY_BUTTON	19.
define tp_build2 ERASE_BUTTON	20.
define tp_build2 EAT_BUTTON	22.
/* GET_BUTTON = 23 */
define tp_build2 READ_BUTTON	24.
define tp_build2 OPEN_BUTTON	25.
define tp_build2 CLOSE_BUTTON	26.
define tp_build2 TURN_BUTTON	27.
define tp_build2 LIFT_BUTTON	28.
/* USE_BUTTON = 21 */

/* EXIT_BUTTON = 17 */
/* MORE_BUTTON = 18 */
define tp_build2 ACTIVATE_BUTTON 19.
define tp_build2 LISTEN_BUTTON	20.
define tp_build2 WEAR_BUTTON	21.
define tp_build2 PUSH_BUTTON	22.
define tp_build2 PULL_BUTTON	23.
define tp_build2 LOWER_BUTTON	24.
define tp_build2 TOUCH_BUTTON	25.
define tp_build2 SMELL_BUTTON	26.
define tp_build2 UNLOCK_BUTTON	27.

/*
 * addBuildButton - add the biuld button.
 */

define tp_build2 proc utility addBuildButton()void:

    AddButton(162, 31, BUILD_BUTTON, "@");
corp;

/*
 * eraseBuildButton - erase the build button.
 */

define tp_build2 proc utility eraseBuildButton()void:

    EraseButton(BUILD_BUTTON);
corp;

/*
 * addTopButtons - add the top-level build buttons.
 */

define tp_build2 ADD_TOP_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addTopButtons()void:

    if not KnowsEffect(nil, ADD_TOP_BUTTONS_ID) then
	DefineEffect(nil, ADD_TOP_BUTTONS_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(212, 32, ROOM_BUTTON, "Room");
	AddButton(263, 32, OBJECT_BUTTON, "Object");
	AddButton(161, 49, POOF_BUTTON, "Poof");
	AddButton(223, 49, SYMBOLHERE_BUTTON, "Symbol Here");
	AddButton(161, 66, TABLES_BUTTON, "Tables");
	EndEffect();
    fi;
    CallEffect(nil, ADD_TOP_BUTTONS_ID);
corp;

/*
 * addTableButtons - add the buttons for table operations.
 */

define tp_build2 ADD_TABLE_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addTableButtons()void:

    if not KnowsEffect(nil, ADD_TABLE_BUTTONS_ID) then
	DefineEffect(nil, ADD_TABLE_BUTTONS_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(216, 32, NEW_BUTTON, "New");
	AddButton(263, 32, SELECT_BUTTON, "Select");
	AddButton(161, 49, USE_BUTTON, "Use");
	AddButton(271, 49, UNUSE_BUTTON, "UnUse");
	AddButton(161, 66, SYMBOLS_BUTTON, "Symbols");
	AddButton(247, 66, DESCRIBE_BUTTON, "Describe");
	EndEffect();
    fi;
    CallEffect(nil, ADD_TABLE_BUTTONS_ID);
corp;

/*
 * addRoomButtons - add the buttons for room building.
 */

define tp_build2 ADD_ROOM_BUTTONS1_ID NextEffectId().
define tp_build2 proc utility addRoomButtons1()void:

    if not KnowsEffect(nil, ADD_ROOM_BUTTONS1_ID) then
	DefineEffect(nil, ADD_ROOM_BUTTONS1_ID);
	AddButton(160, 32, EXIT_BUTTON, "EXIT");
	AddButton(280, 32, MORE_BUTTON, "MORE");
	AddButton(160, 49, NEW_BUTTON, "New");
	AddButton(208, 49, LINK_BUTTON, "Link");
	AddButton(264, 49, UNLINK_BUTTON, "Unlink");
	AddButton(160, 66, SAME_BUTTON, "Same");
	AddButton(200, 66, HIDE_BUTTON, "Hide");
	AddButton(240, 66, SHOP_BUTTON, "Shop");
	AddButton(280, 66, SELL_BUTTON, "Sell");
	AddButton(160, 83, BANK_BUTTON, "Bank");
	AddButton(200, 83, NAME_BUTTON, "Name");
	AddButton(240, 83, DESC_BUTTON, "Desc");
	AddButton(280, 83, AUTO_BUTTON, "Auto");
	EndEffect();
    fi;
    CallEffect(nil, ADD_ROOM_BUTTONS1_ID);
corp;

define tp_build2 ADD_ROOM_BUTTONS2_ID NextEffectId().
define tp_build2 proc utility addRoomButtons2()void:

    if not KnowsEffect(nil, ADD_ROOM_BUTTONS2_ID) then
	DefineEffect(nil, ADD_ROOM_BUTTONS2_ID);
	AddButton(160, 32, EXIT_BUTTON, "EXIT");
	AddButton(280, 32, MORE_BUTTON, "MORE");
	AddButton(160, 49, DARK_BUTTON, "Dark");
	AddButton(204, 49, LOCK_BUTTON, "Lock");
	AddButton(248, 49, READONLY_BUTTON, "Readonly");
	AddButton(160, 66, WIZARD_BUTTON, "Wizard");
	AddButton(264, 66, PUBLIC_BUTTON, "Public");
	AddButton(160, 83, DD_BUTTON, "DD");
	AddButton(205, 83, DM_BUTTON, "DM");
	AddButton(251, 83, OM_BUTTON, "OM");
	AddButton(296, 83, EM_BUTTON, "EM");
	EndEffect();
    fi;
    CallEffect(nil, ADD_ROOM_BUTTONS2_ID);
corp;

/*
 * addDirButtons - add the buttons for getting a direction.
 */

define tp_build2 proc utility addDirButtons()void:

    AddDirectionButtons();
    AddButton(187, 82, EXIT_BUTTON, "EXIT");
    AddButton(253, 82, HELP_BUTTON, "HELP");
corp;

/*
 * eraseDirButtons - erase the buttons for getting a direction.
 */

define tp_build2 proc utility eraseDirButtons()void:

    EraseDirectionButtons();
    EraseButton(HELP_BUTTON);
    EraseButton(EXIT_BUTTON);
corp;

/*
 * addRoomKindButtons - add the new room kind buttons.
 */

define tp_build2 ADD_ROOM_KIND_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addRoomKindButtons()void:

    if not KnowsEffect(nil, ADD_ROOM_KIND_BUTTONS_ID) then
	DefineEffect(nil, ADD_ROOM_KIND_BUTTONS_ID);
	AddButton(161, 32, INDOORS_BUTTON, "Indoors");
	AddButton(247, 32, OUTDOORS_BUTTON, "Outdoors");
	AddButton(161, 49, FOREST_BUTTON, "Forest");
	AddButton(224, 49, FIELD_BUTTON, "Field");
	AddButton(279, 49, PATH_BUTTON, "Path");
	AddButton(161, 66, ROAD_BUTTON, "Road");
	AddButton(204, 66, SIDEWALK_BUTTON, "Sidewalk");
	AddButton(279, 66, PARK_BUTTON, "Park");
	AddButton(161, 83, TUNNEL_BUTTON, "Tunnel");
	EndEffect();
    fi;
    CallEffect(nil, ADD_ROOM_KIND_BUTTONS_ID);
corp;

/*
 * addAutoButtons - add the autographics buttons.
 */

define tp_build2 ADD_AUTO_BUTTONS NextEffectId().
define tp_build2 proc utility addAutoButtons()void:

    if not KnowsEffect(nil, ADD_AUTO_BUTTONS) then
	DefineEffect(nil, ADD_AUTO_BUTTONS);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(279, 32, AUTO_KIND_BUTTON, "Kind");
	AddButton(161, 49, AUTO_BGNDPEN_BUTTON, "Bgnd Pen");
	AddButton(247, 49, AUTO_FGNDPEN_BUTTON, "Fgnd Pen");
	AddButton(161, 66, AUTO_EDGEPEN_BUTTON, "Edge Pen");
	AddButton(247, 66, AUTO_DOORPEN_BUTTON, "Door Pen");
	AddButton(161, 83, AUTO_NAME1_BUTTON, "Name1");
	AddButton(271, 83, AUTO_NAME2_BUTTON, "Name2");
	EndEffect();
    fi;
    CallEffect(nil, ADD_AUTO_BUTTONS);
corp;

/*
 * addAutoKindButtons - add the autographics kind buttons.
 */

define tp_build2 ADD_AUTO_KIND_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addAutoKindButtons()void:

    if not KnowsEffect(nil, ADD_AUTO_KIND_BUTTONS_ID) then
	DefineEffect(nil, ADD_AUTO_KIND_BUTTONS_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(220, 32, AUTO_ROAD_BUTTON, "Road");
	AddButton(279, 32, AUTO_PATH_BUTTON, "Path");
	AddButton(161, 49, AUTO_HALLROOM_BUTTON, "HallRoom");
	AddButton(247, 49, AUTO_DOORROOM_BUTTON, "DoorRoom");
	AddButton(161, 66, AUTO_HALLWAY_BUTTON, "Hallway");
	AddButton(247, 66, AUTO_OPENAREA_BUTTON, "OpenArea");
	AddButton(161, 83, AUTO_TUNNEL_BUTTON, "Tunnel");
	AddButton(255, 83, AUTO_CHAMBER_BUTTON, "Chamber");
	EndEffect();
    fi;
    CallEffect(nil, ADD_AUTO_KIND_BUTTONS_ID);
corp;

/*
 * addObjectButtons - add the buttons for making objects.
 */

define tp_build2 ADD_OBJECT_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addObjectButtons()void:

    if not KnowsEffect(nil, ADD_OBJECT_BUTTONS_ID) then
	DefineEffect(nil, ADD_OBJECT_BUTTONS_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(216, 32, NEW_BUTTON, "New");
	AddButton(263, 32, SELECT_BUTTON, "Select");
	AddButton(161, 49, DESC_BUTTON, "Desc");
	AddButton(203, 49, NAME_BUTTON, "Name");
	AddButton(245, 49, ACT_BUTTON, "Act");
	AddButton(279, 49, CONTAINER_BUTTON, "Cont");
	AddButton(161, 66, GET_BUTTON, "Get");
	AddButton(195, 66, LIGHT_BUTTON, "Lite");
	AddButton(237, 66, INVIS_BUTTON, "Invis");
	AddButton(287, 66, POS_BUTTON, "Pos");
	AddButton(161, 83, ACTWORD_BUTTON, "ActWord");
	AddButton(239, 83, ACTSTRING_BUTTON, "ActString");
	EndEffect();
    fi;
    CallEffect(nil, ADD_OBJECT_BUTTONS_ID);
corp;

/*
 * addPositionButtons - add the buttons for object character positions.
 */

define tp_build2 ADD_POSITION_BUTTONS_ID NextEffectId().
define tp_build2 proc utility addPositionButtons()void:

    if not KnowsEffect(nil, ADD_POSITION_BUTTONS_ID) then
	DefineEffect(nil, ADD_POSITION_BUTTONS_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(204, 32, SIT_IN_BUTTON, "Sit In");
	AddButton(263, 32, SIT_ON_BUTTON, "Sit On");
	AddButton(161, 49, LIE_IN_BUTTON, "Lie In");
	AddButton(263, 49, LIE_ON_BUTTON, "Lie On");
	AddButton(161, 66, STAND_IN_BUTTON, "Stand In");
	AddButton(247, 66, STAND_ON_BUTTON, "Stand On");
	EndEffect();
    fi;
    CallEffect(nil, ADD_POSITION_BUTTONS_ID);
corp;

/*
 * addObjectActionButtons - add the action word buttons.
 */

define tp_build2 ADD_OBJECT_ACTION_BUTTONS1_ID NextEffectId().
define tp_build2 proc utility addObjectActionButtons1()void:

    if not KnowsEffect(nil, ADD_OBJECT_ACTION_BUTTONS1_ID) then
	DefineEffect(nil, ADD_OBJECT_ACTION_BUTTONS1_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(224, 32, GET_BUTTON, "Get");
	AddButton(279, 32, MORE_BUTTON, "MORE");
	AddButton(161, 49, PLAY_BUTTON, "Play");
	AddButton(220, 49, ERASE_BUTTON, "Erase");
	AddButton(287, 49, EAT_BUTTON, "Eat");
	AddButton(161, 66, READ_BUTTON, "Read");
	AddButton(216, 66, OPEN_BUTTON, "Open");
	AddButton(271, 66, CLOSE_BUTTON, "Close");
	AddButton(161, 83, TURN_BUTTON, "Turn");
	AddButton(224, 83, LIFT_BUTTON, "Lift");
	AddButton(287, 83, USE_BUTTON, "Use");
	EndEffect();
    fi;
    CallEffect(nil, ADD_OBJECT_ACTION_BUTTONS1_ID);
corp;

define tp_build2 ADD_OBJECT_ACTION_BUTTONS2_ID NextEffectId().
define tp_build2 proc utility addObjectActionButtons2()void:

    if not KnowsEffect(nil, ADD_OBJECT_ACTION_BUTTONS2_ID) then
	DefineEffect(nil, ADD_OBJECT_ACTION_BUTTONS2_ID);
	AddButton(161, 32, EXIT_BUTTON, "EXIT");
	AddButton(212, 32, UNLOCK_BUTTON, "Unlock");
	AddButton(279, 32, MORE_BUTTON, "MORE");
	AddButton(161, 49, ACTIVATE_BUTTON, "Activate");
	AddButton(263, 49, LISTEN_BUTTON, "Listen");
	AddButton(161, 66, WEAR_BUTTON, "Wear");
	AddButton(220, 66, PUSH_BUTTON, "Push");
	AddButton(279, 66, PULL_BUTTON, "Pull");
	AddButton(161, 83, LOWER_BUTTON, "Lower");
	AddButton(216, 83, TOUCH_BUTTON, "Touch");
	AddButton(271, 83, SMELL_BUTTON, "Smell");
	EndEffect();
    fi;
    CallEffect(nil, ADD_OBJECT_ACTION_BUTTONS2_ID);
corp;

/*
 * roomNameHandler - final step of creating a new room.
 */

define tp_build2 proc utility roomNameHandler(string s; bool ok)void:
    thing me;

    me := Me();
    if ok then
	doCreateRoom(me@p_pSelectedDir, me@p_pRoomKind, s);
	AutoRedraw();
    else
	Print("Room creation cancelled.\n");
    fi;
    me -- p_pRoomKind;
    me -- p_pSelectedDir;
    addRoomButtons1();
    me@p_pButtonEraser := EraseAllButtons;
corp;

/*
 * roomKindHandler - handler for the user selecting a new room kind.
 */

define tp_build2 proc utility roomKindHandler(int whichButton)void:
    thing me;

    me := Me();
    me@p_pRoomKind := whichButton - INDOORS_BUTTON;
    ClearButtons();
    ignore SetCharacterButtonAction(me@p_pHandlerSave5);
    me -- p_pHandlerSave5;
    me -- p_pDirectionRoom1;
    GetString("", roomNameHandler, "Name of room, e.g. 'in the pawnshop':");
corp;

/*
 * newRoom - called when the user selects a direction for a new room.
 */

define tp_build2 proc utility newRoom()void:
    thing me;

    me := Me();
    if Here()@(DirProp(me@p_pSelectedDir)) ~= nil then
	Print("That direction is already in use.\n");
	me -- p_pSelectedDir;
	addRoomButtons1();
	me@p_pButtonEraser := EraseAllButtons;
	ignore SetCharacterButtonAction(me@p_pHandlerSave5);
	me -- p_pHandlerSave5;
	me -- p_pDirectionRoom1;
    else
	addRoomKindButtons();
	me@p_pButtonEraser := EraseAllButtons;
	ignore SetCharacterButtonAction(roomKindHandler);
    fi;
corp;

/*
 * directionHandler - handler for buttons when getting a direction.
 */

define tp_build2 proc utility directionHandler(int whichButton)void:
    thing me;
    int dir;
    action a;

    me := Me();
    if whichButton = EXIT_BUTTON then
	eraseDirButtons();
	if me@p_pDirectionRoom1 then
	    addRoomButtons1();
	    me@p_pButtonEraser := EraseAllButtons;
	else
	    addRoomButtons2();
	    me@p_pButtonEraser := EraseAllButtons;
	fi;
	me -- p_pDirectionRoom1;
	ignore SetCharacterButtonAction(me@p_pHandlerSave5);
	me -- p_pHandlerSave5;
	me -- p_pDirectionNext;
	me -- p_pDirectionWhat;
    elif whichButton = HELP_BUTTON then
	Print("Select direction for " + me@p_pDirectionWhat + ".\n");
    else
	case whichButton
	incase NW_BUTTON:
	    dir := D_NORTHWEST;
	incase N_BUTTON:
	    dir := D_NORTH;
	incase NE_BUTTON:
	    dir := D_NORTHEAST;
	incase W_BUTTON:
	    dir := D_WEST;
	incase E_BUTTON:
	    dir := D_EAST;
	incase SW_BUTTON:
	    dir := D_SOUTHWEST;
	incase S_BUTTON:
	    dir := D_SOUTH;
	incase SE_BUTTON:
	    dir := D_SOUTHEAST;
	incase D_BUTTON:
	    dir := D_DOWN;
	incase U_BUTTON:
	    dir := D_UP;
	incase I_BUTTON:
	    dir := D_ENTER;
	incase O_BUTTON:
	    dir := D_EXIT;
	esac;
	me@p_pSelectedDir := dir;
	me -- p_pDirectionWhat;
	a := me@p_pDirectionNext;
	me -- p_pDirectionNext;
	eraseDirButtons();
	if a ~= newRoom then
	    if me@p_pDirectionRoom1 then
		addRoomButtons1();
		me@p_pButtonEraser := EraseAllButtons;
	    else
		addRoomButtons2();
		me@p_pButtonEraser := EraseAllButtons;
	    fi;
	    me -- p_pDirectionRoom1;
	    ignore SetCharacterButtonAction(me@p_pHandlerSave5);
	    me -- p_pHandlerSave5;
	fi;
	call(a, void)();
    fi;
corp;

/*
 * getDirection - get a direction as part of a room building command.
 */

define tp_build2 proc utility getDirection(action nextStep; string what;
	bool room1)void:
    thing me;

    me := Me();
    me@p_pDirectionNext := nextStep;
    me@p_pDirectionWhat := what;
    me@p_pDirectionRoom1 := room1;
    ClearButtons();
    addDirButtons();
    me@p_pHandlerSave5 := SetCharacterButtonAction(directionHandler);
    me@p_pButtonEraser := eraseDirButtons;
corp;

/*
 * renameRoom - handler for supplying a new room name.
 */

define tp_build2 proc utility renameRoom(string name; bool ok)void:

    if ok then
	Here()@p_rName := name;
	Print("New name entered.\n");
    else
	Print("Name not changed.\n");
    fi;
corp;

/*
 * makeLinkHandler - attempt to link to named room.
 */

define tp_build2 proc utility makeLinkHandler(string symbol; bool ok)void:

    if ok then
	ignore doMakeLink(symbol, Me()@p_pSelectedDir);
	Me() -- p_pSelectedDir;
	AutoRedraw();
    else
	Print("No link made.\n");
    fi;
corp;

/*
 * makeLink - called when the user selects a direction for a new link.
 */

define tp_build2 proc utility makeLink()void:

    if Here()@(DirProp(Me()@p_pSelectedDir)) ~= nil then
	Print("That direction is already in use.\n");
	Me() -- p_pSelectedDir;
    else
	GetString("", makeLinkHandler, "Enter symbol of room to link to:");
    fi;
corp;

/*
 * deleteLink - called when the user selects a direction to delete a link from.
 */

define tp_build2 proc utility deleteLink()void:

    ignore brv_unlink(ExitName(Me()@p_pSelectedDir));
    Me() -- p_pSelectedDir;
    AutoRedraw();
corp;

/*
 * linkSame2 - second part of duplicating a link.
 */

define tp_build2 proc utility linkSame2()void:
    thing me, here;
    int newDir;

    me := Me();
    here := Here();
    newDir := me@p_pSelectedDir;
    if here@(DirProp(newDir)) ~= nil then
	Print("That new direction is already in use.\n");
    else
	UniConnect(here, here@(DirProp(me@p_pFirstDir)), newDir);
	Print("Link made.\n");
	AutoRedraw();
	changeDone("made a new link");
    fi;
    me -- p_pSelectedDir;
    me -- p_pFirstDir;
corp;

/*
 * linkSame1 - called when the user selects a direction whose link is to be
 *	copied to another direction.
 */

define tp_build2 proc utility linkSame1()void:
    thing me;

    me := Me();
    if Here()@(DirProp(me@p_pSelectedDir)) = nil then
	Print("That old direction does not go anywhere.\n");
	me -- p_pSelectedDir;
    else
	me@p_pFirstDir := me@p_pSelectedDir;
	getDirection(linkSame2, "new link", true);
    fi;
corp;

/*
 * autoKindHandler - handler for picking autographics kind.
 */

define tp_build2 proc utility autoKindHandler(int whichButton)void:
    thing here, me;

    here := Here();
    me := Me();
    case whichButton
    incase EXIT_BUTTON:
	ClearButtons();
	addAutoButtons();
	ignore SetCharacterButtonAction(me@p_pHandlerSave6);
	me -- p_pHandlerSave6;
	me@p_pButtonEraser := EraseAllButtons;
    incase AUTO_ROAD_BUTTON:
	AutoGraphics(here, AutoRoads);
    incase AUTO_PATH_BUTTON:
	AutoGraphics(here, AutoPaths);
    incase AUTO_HALLROOM_BUTTON:
	AutoGraphics(here, AutoOpenRoom);
    incase AUTO_DOORROOM_BUTTON:
	AutoGraphics(here, AutoClosedRoom);
    incase AUTO_HALLWAY_BUTTON:
	AutoGraphics(here, AutoHalls);
    incase AUTO_OPENAREA_BUTTON:
	AutoGraphics(here, AutoOpenSpace);
    incase AUTO_TUNNEL_BUTTON:
	AutoGraphics(here, AutoTunnels);
    incase AUTO_CHAMBER_BUTTON:
	AutoGraphics(here, AutoTunnelChamber);
    esac;
    if whichButton ~= EXIT_BUTTON then
	Print("Autographics entered.\n");
	AutoRedraw();
    fi;
corp;

/*
 * colourHandler - handler user choice of a new colour.
 */

define tp_build2 proc utility colourHandler(string name; bool ok)void:
    int colour;

    if ok then
	colour := ColourMatch(GetNounPhrase(DummyGrammar, name, 0));
	if colour = -1 then
	    Print("Invalid colour name. ");
	    ShowKnownColours();
	else
	    Here()@(
		case Me()@p_pSelectedPen
		incase AUTO_BGNDPEN_BUTTON:
		    p_rBackGroundPen
		incase AUTO_FGNDPEN_BUTTON:
		    p_rForeGroundPen
		incase AUTO_EDGEPEN_BUTTON:
		    p_rEdgePen
		default:
		    p_rDoorPen
		esac) := colour;
	    Print("New colour entered.\n");
	    AutoRedraw();
	fi;
    else
	Print("No colour entered.\n");
    fi;
    Me() -- p_pSelectedPen;
corp;

/*
 * getColour - utility to get an autopen colour.
 */

define tp_build2 proc utility getColour(int button)void:
    int oldColour;

    oldColour := Here()@(
	case button
	incase AUTO_BGNDPEN_BUTTON:
	    p_rBackGroundPen
	incase AUTO_FGNDPEN_BUTTON:
	    p_rForeGroundPen
	incase AUTO_EDGEPEN_BUTTON:
	    p_rEdgePen
	default:
	    p_rDoorPen
	esac);
    Me()@p_pSelectedPen := button;
    GetString(ColourName(oldColour), colourHandler,
	"Enter name of new colour:");
corp;

/*
 * roomName1Handler - handler for entering first part of name.
 */

define tp_build2 proc utility roomName1Handler(string n; bool ok)void:

    n := Trim(n);
    if ok and n ~= "" then
	Here()@p_rName1 := n;
	Print("Name entered.\n");
    else
	if Here()@p_rName1 = "" then
	    Print("Name not entered.\n");
	else
	    Here() -- p_rName1;
	    Print("Name deleted.\n");
	fi;
    fi;
corp;

/*
 * roomName2Handler - handler for entering second part of name.
 */

define tp_build2 proc utility roomName2Handler(string n; bool ok)void:

    n := Trim(n);
    if ok and n ~= "" then
	Here()@p_rName2 := n;
	Print("Name entered.\n");
    else
	if Here()@p_rName2 = "" then
	    Print("Name not entered.\n");
	else
	    Here() -- p_rName2;
	    Print("Name deleted.\n");
	fi;
    fi;
corp;

/*
 * autoHandler - handle an autographics button hit.
 */

define tp_build2 proc utility autoHandler(int whichButton)void:
    thing me, here;

    me := Me();
    here := Here();
    case whichButton
    incase EXIT_BUTTON:
	ClearButtons();
	addRoomButtons1();
	ignore SetCharacterButtonAction(me@p_pHandlerSave5);
	me -- p_pHandlerSave5;
	me@p_pButtonEraser := EraseAllButtons;
    incase AUTO_KIND_BUTTON:
	ClearButtons();
	addAutoKindButtons();
	me@p_pHandlerSave6 := SetCharacterButtonAction(autoKindHandler);
	me@p_pButtonEraser := EraseAllButtons;
    incase AUTO_BGNDPEN_BUTTON:
    incase AUTO_FGNDPEN_BUTTON:
    incase AUTO_EDGEPEN_BUTTON:
    incase AUTO_DOORPEN_BUTTON:
	getColour(whichButton);
    incase AUTO_NAME1_BUTTON:
	GetString(here@p_rName1, roomName1Handler,
	    "Enter first or only part of graphics room name:");
    incase AUTO_NAME2_BUTTON:
	GetString(here@p_rName2, roomName2Handler,
	    "Enter second part of graphics room name:");
    esac;
corp;

/*
 * endSetDirDesc - handler after edit of direction description.
 */

define tp_build2 proc utility endSetDirDesc(string s)void:
    thing me, here;
    int dir;

    me := Me();
    here := Here();
    dir := me@p_pSelectedDir;
    s := Trim(s);
    if s = "" then
	case me@p_pDescKind
	incase DESC_DIRDESC:
	    here -- DirDesc(dir);
	    Print("Direction description deleted.\n");
	incase DESC_DIRMESSAGE:
	    here -- DirMessage(dir);
	    Print("Direction message deleted.\n");
	incase DESC_DIROMESSAGE:
	    here -- DirOMessage(dir);
	    Print("Direction message deleted.\n");
	incase DESC_DIREMESSAGE:
	    here -- DirEMessage(dir);
	    Print("Direction message deleted.\n");
	esac;
    else
	case me@p_pDescKind
	incase DESC_DIRDESC:
	    here@(DirDesc(dir)) := s;
	    Print("Direction decorated.\n");
	incase DESC_DIRMESSAGE:
	    here@(DirMessage(dir)) := s;
	    Print("Direction message entered.\n");
	incase DESC_DIROMESSAGE:
	    here@(DirOMessage(dir)) := s;
	    Print("Direction message entered.\n");
	incase DESC_DIREMESSAGE:
	    here@(DirEMessage(dir)) := s;
	    Print("Direction message entered.\n");
	esac;
    fi;
    me -- p_pSelectedDir;
    me -- p_pDescKind;
    changeDone("done some detailing");
corp;

/*
 * setDirDesc - set one of the direction descriptions in the room.
 */

define tp_build2 proc utility setDirDesc()void:
    int dir;
    thing here;

    dir := Me()@p_pSelectedDir;
    here := Here();
    case Me()@p_pDescKind
    incase DESC_DIRDESC:
	ignore GetDocument("room dirdesc> ", "Enter direction description",
	    here@(DirDesc(dir)), endSetDirDesc, false);
    incase DESC_DIRMESSAGE:
	ignore GetDocument("room dirmessage> ", "Enter direction message",
	    here@(DirMessage(dir)), endSetDirDesc, false);
    incase DESC_DIROMESSAGE:
	ignore GetDocument("room diromessage> ",
	    "Enter entering direction message",
	    here@(DirOMessage(dir)), endSetDirDesc, false);
    incase DESC_DIREMESSAGE:
	ignore GetDocument("room diremessage> ",
	    "Enter exiting direction message",
	    here@(DirEMessage(dir)), endSetDirDesc, false);
    esac;
corp;

/*
 * sellHandler2 - second step in making something for sale here.
 */

define tp_build2 proc utility sellHandler2(string s; bool ok)void:
    thing th;
    int price;

    if ok then
	price := StringToPosInt(s);
	if price <= 0 then
	    Print("Invalid price.\n");
	else
	    th := Me()@p_pSelectedObject;
	    AddObjectForSale(Here(), th, price, nil);
	    Print(FormatName(th@p_oName) + " is now for sale here.\n");
	fi;
    else
	Print("Nothing added for sale.\n");
    fi;
    Me() -- p_pSelectedObject;
corp;

/*
 * sellHandler1 - first step in making something for sale here.
 */

define tp_build2 proc utility sellHandler1(string symbol; bool ok)void:
    thing th;

    if ok then
	th := objNameCheck(symbol);
	if th ~= nil then
	    Me()@p_pSelectedObject := th;
	    GetString("0", sellHandler2, "Enter price in blutos:");
	fi;
    else
	Print("Nothing added for sale.\n");
    fi;
corp;

/*
 * hideLink - called when the user selects a direction to make hidden.
 */

define tp_build2 proc utility hideLink()void:
    list int exits;
    int dir;

    exits := Here()@p_rExits;
    dir := Me()@p_pSelectedDir;
    Me() -- p_pSelectedDir;
    if Here()@(DirProp(dir)) = nil then
	Print("There is no link in that direction.\n");
    elif FindElement(exits, dir) = -1 then
	AddTail(exits, dir);
	Print("Link unhidden.\n");
	AutoRedraw();
    else
	DelElement(exits, dir);
	Print("Link hidden.\n");
	AutoRedraw();
    fi;
corp;

/*
 * roomHandler - handler for room building button hits.
 */

define tp_build2 proc utility roomHandler2(int whichButton)void:
    thing me, here;
    string s;

    me := Me();
    here := Here();
    if whichButton ~= EXIT_BUTTON and whichButton ~= MORE_BUTTON and
	not Mine(here) and MeCharacter() ~= SysAdmin and
	(GetThingStatus(here) = ts_readonly or
	 GetThingStatus(here) = ts_wizard and not IsWizard())
    then
	Print("The owner of this room has not permitted it.\n");
    else
	case whichButton
	incase EXIT_BUTTON:
	    ClearButtons();
	    addTopButtons();
	    ignore SetCharacterButtonAction(me@p_pHandlerSave3);
	    me -- p_pHandlerSave3;
	    me -- p_pHandlerSave4;
	    me@p_pButtonEraser := EraseAllButtons;
	incase MORE_BUTTON:
	    ClearButtons();
	    addRoomButtons1();
	    ignore SetCharacterButtonAction(me@p_pHandlerSave4);
	    me -- p_pHandlerSave4;
	    me@p_pButtonEraser := EraseAllButtons;
	incase DARK_BUTTON:
	    if here@p_rDark then
		ignore brv_dark("no");
	    else
		ignore brv_dark("yes");
	    fi;
	incase LOCK_BUTTON:
	    if here@p_rLocked then
		ignore brv_lock("no");
	    else
		ignore brv_lock("yes");
	    fi;
	incase READONLY_BUTTON:
	    if GetThingStatus(here) = ts_readonly then
		Print("This room is already read-only.\n");
	    else
		SetThingStatus(here, ts_readonly);
		Print("This room is now changeable by its owner only.\n");
	    fi;
	incase WIZARD_BUTTON:
	    if GetThingStatus(here) = ts_wizard then
		Print("This room is already wizard-only.\n");
	    else
		SetThingStatus(here, ts_wizard);
		Print("This room is now changeable by wizards only.\n");
	    fi;
	incase PUBLIC_BUTTON:
	    if GetThingStatus(here) = ts_public then
		Print("This room is already public.\n");
	    else
		SetThingStatus(here, ts_public);
		Print(
	"This room is now changeable by wizards, apprentices and builders.\n");
	    fi;
	incase DD_BUTTON:
	    me@p_pDescKind := DESC_DIRDESC;
	    getDirection(setDirDesc, "specific description", false);
	incase DM_BUTTON:
	    me@p_pDescKind := DESC_DIRMESSAGE;
	    getDirection(setDirDesc, "character message", false);
	incase OM_BUTTON:
	    me@p_pDescKind := DESC_DIROMESSAGE;
	    getDirection(setDirDesc, "bystander exit message", false);
	incase EM_BUTTON:
	    me@p_pDescKind := DESC_DIREMESSAGE;
	    getDirection(setDirDesc, "bystander enter message", false);
	esac;
    fi;
corp;

define tp_build2 proc utility roomHandler1(int whichButton)void:
    thing me, here;
    string s;

    me := Me();
    here := Here();
    if whichButton ~= EXIT_BUTTON and whichButton ~= MORE_BUTTON and
	not Mine(here) and MeCharacter() ~= SysAdmin and
	(GetThingStatus(here) = ts_readonly or
	 GetThingStatus(here) = ts_wizard and not IsWizard())
    then
	Print("The owner of this room has not permitted it.\n");
    else
	case whichButton
	incase EXIT_BUTTON:
	    ClearButtons();
	    addTopButtons();
	    ignore SetCharacterButtonAction(me@p_pHandlerSave3);
	    me -- p_pHandlerSave3;
	    me@p_pButtonEraser := EraseAllButtons;
	incase MORE_BUTTON:
	    ClearButtons();
	    addRoomButtons2();
	    me@p_pHandlerSave4 := SetCharacterButtonAction(roomHandler2);
	    me@p_pButtonEraser := EraseAllButtons;
	incase NEW_BUTTON:
	    getDirection(newRoom, "new room", true);
	incase LINK_BUTTON:
	    getDirection(makeLink, "new link", true);
	incase UNLINK_BUTTON:
	    getDirection(deleteLink, "link to delete", true);
	incase SAME_BUTTON:
	    getDirection(linkSame1, "old link", true);
	incase HIDE_BUTTON:
	    getDirection(hideLink, "link to hide", true);
	incase SHOP_BUTTON:
	    ignore brv_makestore();
	incase SELL_BUTTON:
	    if not Mine(here) then
		Print("Can only modify your own stores.\n");
	    elif here@p_rBuyAction ~= StoreBuy then
		Print("This room is not a store.\n");
	    else
		/* default to the 'current' object */
		s := "";
		if me@p_pCurrentObject ~= nil then
		    s := FindThingSymbol(PrivateTable(), me@p_pCurrentObject);
		fi;
		GetString(s, sellHandler1, "Symbol for object to sell here?");
	    fi;
	incase BANK_BUTTON:
	    ignore brv_makebank();
	incase DESC_BUTTON:
	    ignore brv_newdesc();
	incase AUTO_BUTTON:
	    ClearButtons();
	    addAutoButtons();
	    me@p_pHandlerSave5 := SetCharacterButtonAction(autoHandler);
	    me@p_pButtonEraser := EraseAllButtons;
	incase NAME_BUTTON:
	    GetString(here@p_rName, renameRoom,
		"Name of room, e.g. 'in the pawnshop':");

	esac;
    fi;
corp;

/*
 * newObjectHandler2 - second step in creating a new object.
 */

define tp_build2 proc utility newObjectHandler2(string name; bool ok)void:
    thing me;

    me := Me();
    if ok then
	ignore createNewObject(name, me@p_pCurrentTable, me@p_pSelectedSymbol);
    else
	Print("No object created.\n");
    fi;
    me -- p_pSelectedSymbol;
corp;

/*
 * newObjectHandler1 - first step in creating a new object.
 */

define tp_build2 proc utility newObjectHandler1(string symbol; bool ok)void:

    if ok then
	if IsDefined(Me()@p_pCurrentTable, symbol) then
	    Print("Symbol \"" + symbol + "\" is already defined.\n");
	else
	    Me()@p_pSelectedSymbol := symbol;
	    GetString("", newObjectHandler2,
		"Object name, eg. 'vase;blue,glass'?");
	fi;
    else
	Print("No object created.\n");
    fi;
corp;

/*
 * selectObjectHandler - select a new current object.
 */

define tp_build2 proc utility selectObjectHandler(string symbol; bool ok)void:
    thing th;

    if ok then
	th := objNameCheck(symbol);
	if th ~= nil then
	    Me()@p_pCurrentObject := th;
	    Print("'" + symbol + "' is now the current object.\n");
	fi;
    else
	Print("Current object not changed.\n");
    fi;
corp;

/*
 * nameObjectHandler - give a new name to the object.
 */

define tp_build2 proc utility nameObjectHandler(string name; bool ok)void:

    if ok then
	Me()@p_pCurrentObject@p_oName := name;
	Print("Object renamed.\n");
    else
	Print("Object not renamed.\n");
    fi;
corp;

/*
 * actionsHandler - handler for button picks on special actions.
 */

define tp_build2 proc utility actions2Handler(int whichButton)void:
    thing me;

    me := Me();
    if whichButton = EXIT_BUTTON then
	ClearButtons();
	addObjectButtons();
	ignore SetCharacterButtonAction(me@p_pHandlerSave4);
	me -- p_pHandlerSave4;
	me -- p_pHandlerSave5;
	me@p_pButtonEraser := EraseAllButtons;
    elif whichButton = MORE_BUTTON then
	ClearButtons();
	addObjectActionButtons1();
	ignore SetCharacterButtonAction(me@p_pHandlerSave5);
	me -- p_pHandlerSave5;
	me@p_pButtonEraser := EraseAllButtons;
    else
	ignore doSetVerbString(
	    case whichButton
	    incase UNLOCK_BUTTON:
		"unlock"
	    incase ACTIVATE_BUTTON:
		"activate"
	    incase LISTEN_BUTTON:
		"listen"
	    incase WEAR_BUTTON:
		"wear"
	    incase PUSH_BUTTON:
		"push"
	    incase PULL_BUTTON:
		"pull"
	    incase LOWER_BUTTON:
		"lower"
	    incase TOUCH_BUTTON:
		"touch"
	    incase SMELL_BUTTON:
		"smell"
	    default:
		"???"
	    esac, me@p_pCurrentObject);
    fi;
corp;

define tp_build2 proc utility actions1Handler(int whichButton)void:
    thing me;

    me := Me();
    if whichButton = EXIT_BUTTON then
	ClearButtons();
	addObjectButtons();
	ignore SetCharacterButtonAction(me@p_pHandlerSave4);
	me -- p_pHandlerSave4;
	me@p_pButtonEraser := EraseAllButtons;
    elif whichButton = MORE_BUTTON then
	ClearButtons();
	addObjectActionButtons2();
	me@p_pHandlerSave5 := SetCharacterButtonAction(actions2Handler);
	me@p_pButtonEraser := EraseAllButtons;
    elif whichButton = READ_BUTTON then
	ignore doObjectRead(me@p_pCurrentObject);
    else
	ignore doSetVerbString(
	    case whichButton
	    incase GET_BUTTON:
		"get"
	    incase PLAY_BUTTON:
		"play"
	    incase ERASE_BUTTON:
		"erase"
	    incase EAT_BUTTON:
		"eat"
	    incase OPEN_BUTTON:
		"open"
	    incase CLOSE_BUTTON:
		"close"
	    incase TURN_BUTTON:
		"turn"
	    incase LIFT_BUTTON:
		"lift"
	    incase USE_BUTTON:
		"use"
	    default:
		"???"
	    esac, me@p_pCurrentObject);
    fi;
corp;

/*
 * capacityHandler - set a new capacity on a container.
 */

define tp_build2 proc utility capacityHandler(string s; bool ok)void:
    thing object;
    int n;

    object := Me()@p_pCurrentObject;
    if ok then
	n := StringToPosInt(s);
	if n < 0 then
	    Print("Invalid capacity.\n");
	elif n = 0 then
	    if object@p_oContents ~= nil then
		object -- p_oContents;
		object -- p_oCapacity;
		Print("Current object marked as not being a container.\n");
	    else
		Print("Current object not marked as being a container.\n");
	    fi;
	else
	    if object@p_oContents ~= nil then
		Print("Capacity set.\n");
	    else
		object@p_oContents := CreateThingList();
		Print("Current object marked as being a container.\n");
	    fi;
	    object@p_oCapacity := n;
	fi;
    else
	if object@p_oContents ~= nil then
	    Print("Capacity not changed.\n");
	else
	    Print("Current object not marked as being a container.\n");
	fi;
    fi;
corp;

/*
 * routines for dealing with positions characters can occupy WRT objects.
 */

define tp_build2 proc utility positionCountHandler(string s; bool ok)void:
    thing object;
    int n;
    property int prop;

    if ok then
	object := Me()@p_pCurrentObject;
	prop := PositionProp(Me()@p_pSelectedDir);
	n := StringToPosInt(s);
	if n < 0 then
	    Print("Invalid occupant maximum.\n");
	elif n = 0 then
	    object -- prop;
	    Print("Occupation capacity removed.\n");
	else
	    object@(prop) := n + 1;
	    Print("Occupation capacity entered.\n");
	fi;
    else
	Print("Occupation capacity not changed.\n");
    fi;
    Me() -- p_pSelectedDir;
corp;

define tp_build2 proc utility objectPositionHandler(int whichButton)void:
    thing me;
    int valueNow;

    me := Me();
    if whichButton = EXIT_BUTTON then
	ClearButtons();
	addObjectButtons();
	ignore SetCharacterButtonAction(me@p_pHandlerSave4);
	me -- p_pHandlerSave4;
	me@p_pButtonEraser := EraseAllButtons;
    else
	whichButton := whichButton - SIT_IN_BUTTON + POS_SIT_IN;
	valueNow := me@p_pCurrentObject@(PositionProp(whichButton));
	if valueNow = 0 then
	    valueNow := 2;
	fi;
	me@p_pSelectedDir := whichButton;
	GetString(IntToString(valueNow - 1), positionCountHandler,
	    "Maximum number of occupants:");
    fi;
corp;

/*
 * actwordObjectHandler - supply actions words for this object.
 */

define tp_build2 proc utility actwordObjectHandler(string s; bool ok)void:

    if ok then
	Me()@p_pCurrentObject@p_oActWord := s;
	Print("Special action words entered.\n");
    else
	if Me()@p_pCurrentObject@p_oActWord = "" then
	    Print("No special actions words entered.\n");
	else
	    Print("Special actions words not changed.\n");
	fi;
    fi;
corp;

/*
 * objectHandler - handler for top level object building commands.
 */

define tp_build2 proc utility objectHandler(int whichButton)void:
    thing me, currentObject;

    me := Me();
    currentObject := me@p_pCurrentObject;
    if currentObject = nil and
	whichButton ~= EXIT_BUTTON and whichButton ~= NEW_BUTTON and
	whichButton ~= SELECT_BUTTON
    then
	Print("You must select an object first.\n");
    else
	case whichButton
	incase EXIT_BUTTON:
	    ClearButtons();
	    addTopButtons();
	    ignore SetCharacterButtonAction(me@p_pHandlerSave3);
	    me -- p_pHandlerSave3;
	    me@p_pButtonEraser := EraseAllButtons;
	incase NEW_BUTTON:
	    GetString("", newObjectHandler1, "Symbol for new object?");
	incase SELECT_BUTTON:
	    GetString("", selectObjectHandler, "Object to select?");
	incase DESC_BUTTON:
	    ignore doObjectDesc(currentObject);
	incase NAME_BUTTON:
	    GetString(currentObject@p_oName, nameObjectHandler,
		"New name, eg. 'vase;blue,glass'?");
	incase ACT_BUTTON:
	    ClearButtons();
	    addObjectActionButtons1();
	    me@p_pHandlerSave4 := SetCharacterButtonAction(actions1Handler);
	    me@p_pButtonEraser := EraseAllButtons;
	incase CONTAINER_BUTTON:
	    GetString(IntToString(currentObject@p_oCapacity), capacityHandler,
		"Capacity of object?");
	incase GET_BUTTON:
	    if currentObject@p_oNotGettable then
		currentObject -- p_oNotGettable;
		Print("Current object is now gettable.\n");
	    else
		currentObject@p_oNotGettable := true;
		Print("Current object is now not gettable.\n");
	    fi;
	incase LIGHT_BUTTON:
	    if currentObject@p_oLight then
		currentObject -- p_oLight;
		Print("Current object marked as not emitting light.\n");
	    else
		currentObject@p_oLight := true;
		Print("Current object marked as emitting light.\n");
	    fi;
	incase INVIS_BUTTON:
	    if currentObject@p_oInvisible then
		currentObject -- p_oInvisible;
		Print("Current object marked as not invisible.\n");
	    else
		currentObject@p_oInvisible := true;
		Print("Current object marked as invisible.\n");
	    fi;
	incase POS_BUTTON:
	    ClearButtons();
	    addPositionButtons();
	    me@p_pHandlerSave4 :=
		SetCharacterButtonAction(objectPositionHandler);
	    me@p_pButtonEraser := EraseAllButtons;
	incase ACTWORD_BUTTON:
	    GetString(currentObject@p_oActWord, actwordObjectHandler,
		"Special act word, eg. 'dust,clean,sweep'?");
	incase ACTSTRING_BUTTON:
	    ignore enterActString(currentObject);
	esac;
    fi;
corp;

/*
 * poofHandler - the poof button
 */

define tp_build2 proc utility poofHandler(string symbol; bool ok)void:

    if ok then
	ignore bv_poof(symbol);
    else
	Print("*Poof* cancelled.\n");
    fi;
corp;

/*
 * namehereHandler - the name here button
 */

define tp_build2 proc utility namehereHandler(string symbol; bool ok)void:

    if ok then
	if DefineThing(Me()@p_pCurrentTable, symbol, Here()) then
	    Print("New symbol defined.\n");
	fi;
    else
	Print("No new symbol defined.\n");
    fi;
corp;

/*
 * newTableHandler - define a new table.
 */

define tp_build2 proc utility newTableHandler(string symbol; bool ok)void:
    thing me;
    table tb;

    if ok then
	me := Me();
	if IsDefined(me@p_pCurrentTable, symbol) then
	    Print("Symbol already defined.\n");
	else
	    tb := CreateTable();
	    if DefineTable(me@p_pCurrentTable, symbol, tb) then
		me@p_pCurrentTable := tb;
		Print("New table defined and made the current table.\n");
	    fi;
	fi;
    else
	Print("No new table defined.\n");
    fi;
corp;

/*
 * selectTableHandler - select a table as the current table.
 */

define tp_build2 proc utility selectTableHandler(string symbol; bool ok)void:
    table tb;

    if ok then
	if symbol == "private" then
	    Me()@p_pCurrentTable := PrivateTable();
	    Print("Your private table is now the current table.\n");
	elif symbol == "public" then
	    Me()@p_pCurrentTable := PublicTable();
	    Print("The public table is now the current table.\n");
	else
	    tb := checkTable(symbol);
	    if tb ~= nil then
		Me()@p_pCurrentTable := tb;
		Print("Table '" + symbol + "' is now the current table.\n");
	    fi;
	fi;
    else
	Print("No new table selected.\n");
    fi;
corp;

/*
 * useTableHandler - use the given table.
 */

define tp_build2 proc utility useTableHandler(string symbol; bool ok)void:
    table tb;

    if ok then
	tb := checkTable(symbol);
	if tb ~= nil then
	    if UseTable(tb) then
		Print("Table added to in-use list.\n");
	    fi;
	fi;
    fi;
corp;

/*
 * unuseTableHandler - unuse the given table.
 */

define tp_build2 proc utility unuseTableHandler(string symbol; bool ok)void:
    table tb;

    if ok then
	tb := checkTable(symbol);
	if tb ~= nil then
	    if UnUseTable(tb) then
		Print("Table removed from in-use list.\n");
	    fi;
	fi;
    fi;
corp;

/*
 * describeHandler - describe the given symbol.
 */

define tp_build2 proc utility describeHandler(string symbol; bool ok)void:

    if ok then
	DescribeSymbol(Me()@p_pCurrentTable, symbol);
    fi;
corp;

/*
 * tablesHandler - handler for the tables buttons.
 */

define tp_build2 proc utility tablesHandler(int whichButton)void:
    thing me;

    me := Me();
    case whichButton
    incase EXIT_BUTTON:
	ClearButtons();
	addTopButtons();
	ignore SetCharacterButtonAction(me@p_pHandlerSave3);
	me -- p_pHandlerSave3;
	me@p_pButtonEraser := EraseAllButtons;
    incase NEW_BUTTON:
	GetString("", newTableHandler, "Symbol for new table?");
    incase SELECT_BUTTON:
	GetString("", selectTableHandler, "Table to select?");
    incase USE_BUTTON:
	GetString("", useTableHandler, "Table to use?");
    incase UNUSE_BUTTON:
	GetString("", unuseTableHandler, "Table to unuse?");
    incase SYMBOLS_BUTTON:
	ShowTable(me@p_pCurrentTable);
    incase DESCRIBE_BUTTON:
	GetString("", describeHandler, "Symbol to describe?");
    esac;
corp;

/*
 * topHandler - handler for the top level build choices.
 */

define tp_build2 proc utility topHandler(int whichButton)void:
    thing me;

    me := Me();
    case whichButton
    incase EXIT_BUTTON:
	ClearButtons();
	AddStandardButtons();
	addBuildButton();
	ignore SetCharacterButtonAction(me@p_pHandlerSave2);
	me -- p_pHandlerSave2;
	me@p_pButtonEraser := eraseBuildButton;
    incase ROOM_BUTTON:
	ClearButtons();
	addRoomButtons1();
	me@p_pHandlerSave3 := SetCharacterButtonAction(roomHandler1);
	me@p_pButtonEraser := EraseAllButtons;
    incase OBJECT_BUTTON:
	ClearButtons();
	addObjectButtons();
	me@p_pHandlerSave3 := SetCharacterButtonAction(objectHandler);
	me@p_pButtonEraser := EraseAllButtons;
    incase POOF_BUTTON:
	GetString("", poofHandler, "Symbol of room to *poof* to?");
    incase SYMBOLHERE_BUTTON:
	GetString("", namehereHandler, "Symbol to name this room?");
    incase TABLES_BUTTON:
	ClearButtons();
	addTableButtons();
	me@p_pHandlerSave3 := SetCharacterButtonAction(tablesHandler);
	me@p_pButtonEraser := EraseAllButtons;
    esac;
corp;

/*
 * buildButtonHandler - top level handler for the build button.
 */

define tp_build2 proc utility buildButtonHandler(int whichButton)void:
    thing me;

    me := Me();
    if whichButton = BUILD_BUTTON then
	if me@p_pStandardButtonsNow then
	    EraseStandardButtons();
	    EraseButton(BUILD_BUTTON);
	    addTopButtons();
	    me@p_pButtonEraser := EraseAllButtons;
	    me@p_pHandlerSave2 := SetCharacterButtonAction(topHandler);
	    me@p_pStandardButtonsNow := false;
	fi;
    else
	call(me@p_pHandlerSave1, void)(whichButton);
    fi;
corp;

/*
 * buildIdle - character has build active, then exits game - reset things.
 */

define tp_build2 proc utility buildIdle()void:
    thing me;
    action a;

    me := Me();
    me -- p_pButtonEraser;
    me -- p_pHandlerSave3;
    me -- p_pHandlerSave2;
    /* clear the top level one as well - it is put back on character entry */
    ignore SetCharacterButtonAction(me@p_pHandlerSave1);
    me -- p_pHandlerSave1;
    /* want to do this last, to preserve the stack of idle action calls */
    a := me@p_pIdleSave;
    ignore SetCharacterIdleAction(a);
    me@p_pStandardButtonsNow := true;
    me -- p_pIdleSave;
    if a ~= nil then
	call(a, void)();
    fi;
corp;

/*
 * setupBuild - setup for mouse building.
 */

define tp_build proc utility setupBuild()void:
    thing me;

    me := Me();
    if me@p_pHandlerSave1 = nil then
	/* could have been nuked out while build enabled */
	me@p_pCurrentTable := PrivateTable();
	me@p_pHandlerSave1 := SetCharacterButtonAction(buildButtonHandler);
	me@p_pIdleSave := SetCharacterIdleAction(buildIdle);
	me@p_pButtonEraser := eraseBuildButton;
    fi;
    addBuildButton();
corp;

/*
 * clearBuild - remove the build buttons - used on exit from playpen.
 */

define tp_build proc utility clearBuild()void:
    thing me;
    action a;

    me := Me();
    a := me@p_pIdleSave;
    if a ~= nil then
	/* he could have last exited while in playpen, so would not be set
	   up yet. */
	ignore SetCharacterIdleAction(a);
	me -- p_pIdleSave;
	me -- p_pHandlerSave4;
	me -- p_pHandlerSave3;
	me -- p_pHandlerSave2;
	ignore SetCharacterButtonAction(me@p_pHandlerSave1);
	me -- p_pHandlerSave1;
	a := me@p_pButtonEraser;
	me -- p_pButtonEraser;
	call(a, void)();
	if a ~= eraseBuildButton then
	    AddStandardButtons();
	fi;
    fi;
corp;

/*
 * checkBuildButton - check for adding the build button. Called when the
 *	character is starting up.
 */

define tp_build proc utility checkBuildButton()void:

    if Me()@p_pBuilder or Here()@p_rPlayPen then
	setupBuild();
    fi;
corp;

AddTail(CharacterThing(SysAdmin)@p_pEnterActions, checkBuildButton).

/*
 * makebuilder - a spell to make someone a builder.
 */

define tp_build2 proc doMakeBuilder()status:
    list action la;

    la := Me()@p_pEnterActions;
    if FindElement(la, checkBuildButton) = -1 then
	AddTail(la, checkBuildButton);
    fi;
    setupBuild();
    continue
corp;

/* This is put into SysAdmin's private table so that he can use it as
   a spell with "cast". On the V0.5 release it was "public", which meant
   that ANYONE could cast it! */

private proc makebuilder()void:
    string name;
    character ch;
    thing th, loc;

    name := GetWord();
    if name = "" then
	Print("makebuilder who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
	else
	    th := CharacterThing(ch);
	    if th@p_pBuilder then
		Print(name + " is already a builder.\n");
	    else
		loc := CharacterLocation(ch);
		if loc ~= nil and not loc@p_rPlayPen then
		    th@p_pBuilder := true;
		    if AgentLocation(th) ~= nil then
			ignore ForceAction(th, doMakeBuilder);
			SPrint(th, Me()@p_pName +
			    " has just made you a builder.\n");
		    fi;
		    Print(name + " is now a builder.\n");
		else
		    Print("Can't do that right now.\n");
		fi;
	    fi;
	fi;
    fi;
corp;

/*
 * unmakebuilder - a spell to make someone not a builder.
 */

define tp_build2 proc doUnmakeBuilder()status:

    DelElement(Me()@p_pEnterActions, checkBuildButton);
    clearBuild();
    continue
corp;

private proc unmakebuilder()void:
    string name;
    character ch;
    thing th, loc;

    name := GetWord();
    if name = "" then
	Print("unmakebuilder who?\n");
    else
	ch := Character(name);
	if ch = nil then
	    Print("There is no character called '" + name + "'.\n");
	else
	    th := CharacterThing(ch);
	    if not th@p_pBuilder then
		Print(name + " is already not a builder.\n");
	    else
		loc := CharacterLocation(ch);
		if loc ~= nil and not loc@p_rPlayPen and
		    th@p_pHandlerSave2 = nil
		then
		    th@p_pBuilder := false;
		    if AgentLocation(th) ~= nil then
			ignore ForceAction(th, doUnmakeBuilder);
			SPrint(th, Me()@p_pName +
			    " has just made you not a builder.\n");
		    fi;
		    Print(name + " is now not a builder.\n");
		else
		    Print("Can't do that right now.\n");
		fi;
	    fi;
	fi;
    fi;
corp;

unuse tp_build2
