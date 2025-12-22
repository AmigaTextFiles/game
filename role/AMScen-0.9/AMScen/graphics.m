/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * graphics.m - some stuff to do simple graphics.
 */

private tp_graphics CreateTable().
use tp_graphics

define t_graphics p_rName1 CreateStringProp().
define t_graphics p_rName2 CreateStringProp().
define t_graphics p_rBackGroundPen CreateIntProp().
define t_graphics p_rForeGroundPen CreateIntProp().
define t_graphics p_rEdgePen CreateIntProp().
define t_graphics p_rDoorPen CreateIntProp().
define t_graphics p_rCursorX CreateIntProp().
define t_graphics p_rCursorY CreateIntProp().
define t_graphics p_rDrawAction CreateActionProp().
define t_graphics p_pStandardButtonsNow CreateBoolProp().

define tp_graphics p_rAutoGraphics CreateBoolProp().
define tp_graphics p_rAutoDrawAction CreateActionProp().

/* first, some names for the standard colours */

define t_graphics C_BLACK	    0.
define t_graphics C_DARK_GREY	    1.
define t_graphics C_MEDIUM_GREY     2.
define t_graphics C_LIGHT_GREY	    3.
define t_graphics C_WHITE	    4.
define t_graphics C_BRICK_RED	    5.
define t_graphics C_RED 	    6.
define t_graphics C_RED_ORANGE	    7.
define t_graphics C_ORANGE	    8.
define t_graphics C_GOLD	    9.
define t_graphics C_CADMIUM_YELLOW 10.
define t_graphics C_LEMON_YELLOW   11.
define t_graphics C_LIME_GREEN	   12.
define t_graphics C_GREEN	   13.
define t_graphics C_LIGHT_GREEN    14.
define t_graphics C_DARK_GREEN	   15.
define t_graphics C_FOREST_GREEN   16.
define t_graphics C_BLUE_GREEN	   17.
define t_graphics C_AQUA	   18.
define t_graphics C_LIGHT_AQUA	   19.
define t_graphics C_SKY_BLUE	   20.
define t_graphics C_LIGHT_BLUE	   21.
define t_graphics C_BLUE	   22.
define t_graphics C_DARK_BLUE	   23.
define t_graphics C_VIOLET	   24.
define t_graphics C_PURPLE	   25.
define t_graphics C_MAGENTA	   26.
define t_graphics C_PINK	   27.
define t_graphics C_TAN 	   28.
define t_graphics C_BROWN	   29.
define t_graphics C_MEDIUM_BROWN   30.
define t_graphics C_DARK_BROWN	   31.

/*
 * ColourMatch - a routine to map name to number at run-time
 */

define t_graphics proc public ColourMatch(string name)int:

    if name == "grey" then
	C_MEDIUM_GREY
    elif name == "red" then
	C_RED
    elif name == "green" then
	C_GREEN
    elif name == "blue" then
	C_BLUE
    else
	MatchName(
	    "black.grey;dark.grey;medium.grey;light.white.red;brick.red."
	    "red-orange.orange.gold.yellow;cadmium.yellow;lemon.green;lime."
	    "green.green;light.green;dark.green;forest.blue-green.aqua."
	    "aqua;light.blue;sky.blue;light.blue.blue;dark.violet.purple."
	    "magenta.pink.tan.brown.brown;medium.brown;dark", name)
    fi
corp;

/*
 * ColourName - map from colour number to colour name
 */

define t_graphics proc public ColourName(int colour)string:

    case colour
    incase C_BLACK:		"black"
    incase C_DARK_GREY: 	"dark grey"
    incase C_MEDIUM_GREY:	"medium grey"
    incase C_LIGHT_GREY:	"light grey"
    incase C_WHITE:		"white"
    incase C_BRICK_RED: 	"brick red"
    incase C_RED:		"red"
    incase C_RED_ORANGE:	"red-orange"
    incase C_ORANGE:		"orange"
    incase C_GOLD:		"gold"
    incase C_CADMIUM_YELLOW:	"cadmium yellow"
    incase C_LEMON_YELLOW:	"lemon yellow"
    incase C_LIME_GREEN:	"lime green"
    incase C_GREEN:		"green"
    incase C_LIGHT_GREEN:	"light green"
    incase C_DARK_GREEN:	"dark green"
    incase C_FOREST_GREEN:	"forest green"
    incase C_BLUE_GREEN:	"blue green"
    incase C_AQUA:		"aqua"
    incase C_LIGHT_AQUA:	"light aqua"
    incase C_SKY_BLUE:		"sky blue"
    incase C_LIGHT_BLUE:	"light blue"
    incase C_BLUE:		"blue"
    incase C_DARK_BLUE: 	"dark blue"
    incase C_VIOLET:		"violet"
    incase C_PURPLE:		"purple"
    incase C_MAGENTA:		"magenta"
    incase C_PINK:		"pink"
    incase C_TAN:		"tan"
    incase C_BROWN:		"brown"
    incase C_MEDIUM_BROWN:	"medium brown"
    incase C_DARK_BROWN:	"dark brown"
    default:			"<BAD-COLOUR>"
    esac
corp;

/*
 * ShowKnownColours - print the colour names that we understand.
 */

define t_graphics proc public ShowKnownColours()void:

    Print("Known colours are: "
	"black, "
	"dark grey, "
	"medium grey, "
	"light grey, "
	"white, "
	"brick red, "
	"red, "
	"red-orange, "
	"orange, "
	"gold, "
	"cadmium yellow, "
	"lemon yellow, "
	"lime green, "
	"green, "
	"light green, "
	"dark green, "
	"forest green, "
	"green-blue, "
	"aqua, "
	"light aqua, "
	"sky blue, "
	"light blue, "
	"blue, "
	"dark blue, "
	"violet, "
	"purple, "
	"magenta, "
	"pink, "
	"tan, "
	"brown, "
	"medium brown, "
	"dark brown\n"
    );
corp;

/* tools for providing unique map group and effect id values */

/* some standard MapGroup values */

define t_graphics UNKNOWN_MAP_GROUP	-1.
define t_graphics NO_MAP_GROUP		0.
define t_graphics AUTO_MAP_GROUP	1.

define tp_graphics GraphicsThing CreateThing(nil).
define tp_graphics p_NextMapGroup CreateIntProp().
define tp_graphics p_NextEffectId CreateIntProp().
GraphicsThing@p_NextMapGroup := AUTO_MAP_GROUP + 1.
GraphicsThing@p_NextEffectId := 1.

define t_graphics proc public NextMapGroup()int:
    int g;

    g := GraphicsThing@p_NextMapGroup;
    GraphicsThing@p_NextMapGroup := g + 1;
    g
corp;

define t_graphics proc public NextEffectId()int:
    int id;

    id := GraphicsThing@p_NextEffectId;
    GraphicsThing@p_NextEffectId := id + 1;
    id
corp;

/* next, some general titling stuff */

define tp_graphics ROOM_NAME_BOX_ID NextEffectId().

define t_graphics proc public DrawRoomNameBox()void:
    int i;

    if not KnowsEffect(nil, ROOM_NAME_BOX_ID) then
	DefineEffect(nil, ROOM_NAME_BOX_ID);
	for i from 0 upto 3 do
	    GSetPen(nil, i + 1);
	    GAMove(nil, 162 + i, i);
	    GRectangle(nil, 155 - 2 * i, 29 - 2 * i, false);
	od;
	EndEffect();
    fi;
    CallEffect(nil, ROOM_NAME_BOX_ID);
corp;

define t_graphics proc public DrawRoomName(string s1, s2)void:
    int len;

    GSetPen(nil, C_BLACK);
    GAMove(nil, 168, 6);
    GRectangle(nil, 143, 17, true);
    GSetPen(nil, C_GOLD);
    len := Length(s2);
    if len ~= 0 then
	if len > 18 then
	    len := 18;
	    s2 := SubString(s2, 0, 18);
	fi;
	GAMove(nil, 240 - len * 4, 22);
	GText(nil, s2);
	len := Length(s1);
	if len > 18 then
	    len := 18;
	    s1 := SubString(s1, 0, 18);
	fi;
	GAMove(nil, 240 - len * 4, 12);
	GText(nil, s1);
    else
	len := Length(s1);
	if len > 18 then
	    len := 18;
	    s1 := SubString(s1, 0, 18);
	fi;
	GAMove(nil, 240 - len * 4, 17);
	GText(nil, s1);
    fi;
corp;

define tp_graphics HORIZONTAL_DOOR_ID NextEffectId().
define tp_graphics VERTICAL_DOOR_ID NextEffectId().
define tp_graphics NORTHWEST_DOOR_ID NextEffectId().
define tp_graphics NORTHEAST_DOOR_ID NextEffectId().

define t_graphics proc public HorizontalDoor()void:

    if not KnowsEffect(nil, HORIZONTAL_DOOR_ID) then
	DefineEffect(nil, HORIZONTAL_DOOR_ID);
	GRMove(nil, 0, -1);
	GRDraw(nil, 0, 2);
	GRMove(nil, 0, -1);
	GRDraw(nil, 10, 0);
	GRMove(nil, 0, -1);
	GRDraw(nil, 0, 2);
	EndEffect();
    fi;
    CallEffect(nil, HORIZONTAL_DOOR_ID);
corp;

define t_graphics proc public VerticalDoor()void:

    if not KnowsEffect(nil, VERTICAL_DOOR_ID) then
	DefineEffect(nil, VERTICAL_DOOR_ID);
	GRMove(nil, -1, 0);
	GRDraw(nil, 2, 0);
	GRMove(nil, -1, 0);
	GRDraw(nil, 0, 8);
	GRMove(nil, -1, 0);
	GRDraw(nil, 2, 0);
	EndEffect();
    fi;
    CallEffect(nil, VERTICAL_DOOR_ID);
corp;

define t_graphics proc public NorthWestDoor()void:

    if not KnowsEffect(nil, NORTHWEST_DOOR_ID) then
	DefineEffect(nil, NORTHWEST_DOOR_ID);
	GRMove(nil, -1, -1);
	GRDraw(nil, 2, 2);
	GRMove(nil, -1, -1);
	GRDraw(nil, -4, 4);
	GRMove(nil, -1, -1);
	GRDraw(nil, 2, 2);
	EndEffect();
    fi;
    CallEffect(nil, NORTHWEST_DOOR_ID);
corp;

define t_graphics proc public NorthEastDoor()void:

    if not KnowsEffect(nil, NORTHEAST_DOOR_ID) then
	DefineEffect(nil, NORTHEAST_DOOR_ID);
	GRMove(nil, 1, -1);
	GRDraw(nil, -2, 2);
	GRMove(nil, 1, -1);
	GRDraw(nil, 4, 4);
	GRMove(nil, 1, -1);
	GRDraw(nil, -2, 2);
	EndEffect();
    fi;
    CallEffect(nil, NORTHEAST_DOOR_ID);
corp;

/* a proc to yield the standard cursor for a character */

define t_graphics proc public MakeCursor()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b01111100000000001100011000000000;
    li[1] := 0b10101010000000001000001000000000;
    li[2] := 0b10111010000000001100011000000000;
    li[3] := 0b01111100000000000000000000000000;
    li[4] := 0b00000000000000000000000000000000;
    li[5] := 0b00000000000000000000000000000000;
    li[6] := 0b00000000000000000000000000000000;
    li[7] := 0b00000000000000000000000000000000;
    li
corp;

/* proc that can be attached to things, and which zaps all buttons. */
/* We need this since we cannot attach builtins to things. */

define t_graphics proc EraseAllButtons()void:

    ClearButtons();
corp;

/* create the standard set of movement buttons and region */

define t_graphics NW_BUTTON	1.
define t_graphics N_BUTTON	2.
define t_graphics NE_BUTTON	3.
define t_graphics W_BUTTON	4.
define t_graphics L_BUTTON	5.
define t_graphics E_BUTTON	6.
define t_graphics SW_BUTTON	7.
define t_graphics S_BUTTON	8.
define t_graphics SE_BUTTON	9.
define t_graphics D_BUTTON	10.
define t_graphics U_BUTTON	11.
define t_graphics I_BUTTON	12.
define t_graphics O_BUTTON	13.
define t_graphics MOVE_REGION	1000.	/* want it large, so others override */

define tp_graphics ADD_DIRECTION_BUTTONS_ID NextEffectId().
define tp_graphics ERASE_DIRECTION_BUTTONS_ID NextEffectId().

define t_graphics proc public AddDirectionButtons()void:

    if not KnowsEffect(nil, ADD_DIRECTION_BUTTONS_ID) then
	DefineEffect(nil, ADD_DIRECTION_BUTTONS_ID);
	AddButton(206, 31, NW_BUTTON, "NW");
	AddButton(231, 31, N_BUTTON, "N");
	AddButton(248, 31, NE_BUTTON, "NE");
	AddButton(210, 48, W_BUTTON, "W");
	AddButton(252, 48, E_BUTTON, "E");
	AddButton(206, 65, SW_BUTTON, "SW");
	AddButton(231, 65, S_BUTTON, "S");
	AddButton(248, 65, SE_BUTTON, "SE");
	AddButton(273, 39, U_BUTTON, "U");
	AddButton(273, 57, D_BUTTON, "D");
	AddButton(189, 39, I_BUTTON, "I");
	AddButton(189, 57, O_BUTTON, "O");
	EndEffect();
    fi;
    CallEffect(nil, ADD_DIRECTION_BUTTONS_ID);
corp;

define t_graphics proc public EraseDirectionButtons()void:

    if not KnowsEffect(nil, ERASE_DIRECTION_BUTTONS_ID) then
	DefineEffect(nil, ERASE_DIRECTION_BUTTONS_ID);
	EraseButton(NW_BUTTON);
	EraseButton(N_BUTTON);
	EraseButton(NE_BUTTON);
	EraseButton(W_BUTTON);
	EraseButton(E_BUTTON);
	EraseButton(SW_BUTTON);
	EraseButton(S_BUTTON);
	EraseButton(SE_BUTTON);
	EraseButton(U_BUTTON);
	EraseButton(D_BUTTON);
	EraseButton(I_BUTTON);
	EraseButton(O_BUTTON);
	EndEffect();
    fi;
    CallEffect(nil, ERASE_DIRECTION_BUTTONS_ID);
corp;

define t_graphics proc public AddStandardButtons()void:

    AddDirectionButtons();
    AddButton(231, 48, L_BUTTON, "L");
    Me()@p_pStandardButtonsNow := true;
corp;

define t_graphics proc public AddStandardRegions()void:

    AddRegion(0, 0, 159, 99, MOVE_REGION);
corp;

define t_graphics proc public EraseStandardButtons()void:

    EraseDirectionButtons();
    EraseButton(L_BUTTON);
corp;

define t_graphics proc public EraseStandardRegions()void:

    EraseRegion(MOVE_REGION);
corp;

/* a standard button handler for the above buttons */

define t_graphics proc public StandardButtonHandler(int whichButton)void:

    case whichButton
    incase NW_BUTTON:
	InsertCommand("northwest");
    incase N_BUTTON:
	InsertCommand("north");
    incase NE_BUTTON:
	InsertCommand("northeast");
    incase W_BUTTON:
	InsertCommand("west");
    incase L_BUTTON:
	InsertCommand("look");
    incase E_BUTTON:
	InsertCommand("east");
    incase SW_BUTTON:
	InsertCommand("southwest");
    incase S_BUTTON:
	InsertCommand("south");
    incase SE_BUTTON:
	InsertCommand("southeast");
    incase U_BUTTON:
	InsertCommand("up");
    incase D_BUTTON:
	InsertCommand("down");
    incase I_BUTTON:
	InsertCommand("in");
    incase O_BUTTON:
	InsertCommand("out");
    default:
	Print("Unknown button ");
	IPrint(whichButton);
	Print(" hit!\n");
    esac;
corp;

/* a standard region hit handler for the above region */

define t_graphics proc public StandardMouseDownHandler(int region, x, y)void:
    thing here;
    int cursorX, cursorY, deltaX, deltaY;

    if region = MOVE_REGION then
	here := Here();
	cursorX := here@p_rCursorX;
	cursorY := here@p_rCursorY;
	if cursorX = 0 and cursorY = 0 and here@p_rAutoGraphics then
	    /* pick the middle of the mapping region */
	    cursorX := 80;
	    cursorY := 50;
	else
	    /* adjust to center of 7 x 7 cursor pattern */
	    cursorX := cursorX + 3;
	    cursorY := cursorY + 3;
	fi;
	if cursorX < x then
	    deltaX := x - cursorX;
	else
	    deltaX := cursorX - x;
	fi;
	if cursorY < y then
	    deltaY := y - cursorY;
	else
	    deltaY := cursorY - y;
	fi;
	if deltaY * 10 <= deltaX * 4 then
	    if x < cursorX then
		InsertCommand("west");
	    else
		InsertCommand("east");
	    fi;
	elif deltaX * 10 <= deltaY * 4 then
	    if y < cursorY then
		InsertCommand("north");
	    else
		InsertCommand("south");
	    fi;
	else
	    if x < cursorX then
		if y < cursorY then
		    InsertCommand("northwest");
		else
		    InsertCommand("southwest");
		fi;
	    else
		if y < cursorY then
		    InsertCommand("northeast");
		else
		    InsertCommand("southeast");
		fi;
	    fi;
	fi;
    else
	Print("Unknown region ");
	IPrint(region);
	Print(" hit!\n");
    fi;
corp;

/* set up the standard graphics stuff. */

define t_graphics p_pStandardGraphicsDone CreateBoolProp().

define t_graphics proc public InitStandardGraphics()void:
    thing me;

    me := Me();
    GClear(nil);
    DrawRoomNameBox();
    AddStandardButtons();
    AddStandardRegions();
    SetCursorPen(me@p_pCursorColour);
    SetCursorPattern(me@p_pCursor);
    GSetIconPen(nil, me@p_pIconColour);
    me@p_pStandardGraphicsDone := true;
corp;

define tp_graphics CLEAR_GRAPHICS_ID NextEffectId().
define t_graphics proc public ClearGraphics()void:

    if not KnowsEffect(nil, CLEAR_GRAPHICS_ID) then
	DefineEffect(nil, CLEAR_GRAPHICS_ID);
	GSetPen(nil, C_BLACK);
	GAMove(nil, 0, 0);
	GRectangle(nil, 159, 99, true);
	EndEffect();
    fi;
    CallEffect(nil, CLEAR_GRAPHICS_ID);
corp;

/* these are used when entering and exiting a room using this scheme. */

define t_graphics proc public EnterRoomDraw()void:
    thing me, here;
    int g, len, pos;
    string name;
    action a;

    me := Me();
    here := Here();
    g := me@p_MapGroup;
    if here@p_rAutoGraphics and here@p_rDrawAction = nil then
	if g ~= AUTO_MAP_GROUP then
	    if not me@p_pStandardGraphicsDone then
		InitStandardGraphics();
	    else
		ClearGraphics();
	    fi;
	    me@p_MapGroup := AUTO_MAP_GROUP;
	fi;
	a := here@p_rAutoDrawAction;
	if a ~= nil then
	    call(a, void)();
	fi;
	if here@p_rName1 ~= "" then
	    DrawRoomName(here@p_rName1, here@p_rName2);
	else
	    name := here@p_rName;
	    len := Length(name);
	    pos := len - 1;
	    while pos ~= 0 and SubString(name, pos, 1) ~= " " do
		pos := pos - 1;
	    od;
	    if SubString(name, pos, 1) = " " then
		pos := pos + 1;
	    fi;
	    DrawRoomName(Capitalize(SubString(name, pos, len - pos)), "");
	fi;
	PlaceCursor(77, 47);
    else
	if g = NO_MAP_GROUP then
	    /* The place the character was previously at did not use room
	       graphics, so start it up */
	    if not me@p_pStandardGraphicsDone then
		InitStandardGraphics();
	    else
		ClearGraphics();
	    fi;
	fi;
	if g ~= here@p_MapGroup then
	    /* The current room (the character has just entered it, or is doing
	       a 'look'), uses room graphics, and the map group for the room
	       is different from that which was last shown to the player.
	       Remember the new group in the player, clear the room graphics
	       area, and call the room's display function. */
	    me@p_MapGroup := here@p_MapGroup;
	    ClearGraphics();
	    a := here@p_rDrawAction;
	    if a ~= nil then
		call(a, void)();
	    fi;
	fi;
	DrawRoomName(here@p_rName1, here@p_rName2);
	if here@p_rCursorX ~= 0 or here@p_rCursorY ~= 0 then
	    PlaceCursor(here@p_rCursorX, here@p_rCursorY);
	fi;
    fi;
corp;

define t_graphics proc public LeaveRoomDraw(thing dest)void:

    RemoveCursor();
    if dest = nil or dest@p_rEnterRoomDraw = nil then
	/* No room graphics in destination - clear the display area, etc. */
	ClearGraphics();
	DrawRoomName("", "");
	Me()@p_MapGroup := NO_MAP_GROUP;
    fi;
corp;

/*
 * RoomGraphics - set up a room for standard form custom graphics.
 */

define t_graphics proc public RoomGraphics(thing room; string name1, name2;
	int group, x, y; action drawAction)void:

    room -- p_rAutoGraphics;
    if name1 ~= "" then
	room@p_rName1 := name1;
    fi;
    if name2 ~= "" then
	room@p_rName2 := name2;
    fi;
    room@p_MapGroup := group;
    if x ~= 0 then
	room@p_rCursorX := x;
    fi;
    if y ~= 0 then
	room@p_rCursorY := y;
    fi;
    if drawAction ~= nil then
	room@p_rDrawAction := drawAction;
    fi;
    room@p_rEnterRoomDraw := EnterRoomDraw;
    room@p_rLeaveRoomDraw := LeaveRoomDraw;
corp;

/* the following few are 'utility' so they can be used in build code */

/*
 * AutoGraphics - set up a room to use auto graphics.
 */

define t_graphics proc utility AutoGraphics(thing room; action drawAction)void:

    room@p_rAutoGraphics := true;
    room@p_rEnterRoomDraw := EnterRoomDraw;
    room@p_rLeaveRoomDraw := LeaveRoomDraw;
    room@p_rAutoDrawAction := drawAction;
corp;

/*
 * AutoRedraw - redraw the room for the current user.
 */

define t_graphics proc utility AutoRedraw()void:
    action a;

    if Here()@p_rDrawAction = nil then
	a := Here()@p_rAutoDrawAction;
	if a ~= nil then
	    GUndrawIcons(nil);
	    RemoveCursor();
	    call(a, void)();
	    PlaceCursor(77, 47);
	    GRedrawIcons(nil);
	fi;
    fi;
corp;

/*
 * AutoPens - set the pens for auto graphics.
 */

define t_graphics proc utility AutoPens(thing room;
	int back, fore, edge, door)void:

    if back ~= 0 then
	room@p_rBackGroundPen := back;
    else
	room -- p_rBackGroundPen;
    fi;
    if fore ~= 0 then
	room@p_rForeGroundPen := fore;
    else
	room -- p_rForeGroundPen;
    fi;
    if edge ~= 0 then
	room@p_rEdgePen := edge;
    else
	room -- p_rEdgePen;
    fi;
    if door ~= 0 then
	room@p_rDoorPen := door;
    else
	room -- p_rDoorPen;
    fi;
corp;

/*
 * RoomName - set the graphics name of the room.
 */

define t_graphics proc utility RoomName(thing room; string name1, name2)void:

    room@p_rName1 := name1;
    if name2 ~= "" then
	room@p_rName2 := name2;
    else
	room -- p_rName2;
    fi;
corp;

define tp_graphics GOLD_UP_ARROW_ID NextEffectId().
define tp_graphics GOLD_DOWN_ARROW_ID NextEffectId().

/*
 * DrawUpArrow - draw the up arrow.
 */

define t_graphics proc DrawUpArrow(int pen)void:

    if pen = C_GOLD then
	if not KnowsEffect(nil, GOLD_UP_ARROW_ID) then
	    DefineEffect(nil, GOLD_UP_ARROW_ID);
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 86, 45);
	    GRDraw(nil, 5, -5);
	    GRDraw(nil, 5, 5);
	    GRMove(nil, -5, -5);
	    GRDraw(nil, 0, 20);
	    EndEffect();
	fi;
	CallEffect(nil, GOLD_UP_ARROW_ID);
    else
	GSetPen(nil, pen);
	GAMove(nil, 86, 45);
	GRDraw(nil, 5, -5);
	GRDraw(nil, 5, 5);
	GRMove(nil, -5, -5);
	GRDraw(nil, 0, 20);
    fi;
corp;

/*
 * DrawDownArrow - draw the down arrow.
 */

define t_graphics proc DrawDownArrow(int pen)void:

    if pen = C_GOLD then
	if not KnowsEffect(nil, GOLD_DOWN_ARROW_ID) then
	    DefineEffect(nil, GOLD_DOWN_ARROW_ID);
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 64, 55);
	    GRDraw(nil, 5, 5);
	    GRDraw(nil, 5, -5);
	    GRMove(nil, -5, 5);
	    GRDraw(nil, 0, -20);
	    EndEffect();
	fi;
	CallEffect(nil, GOLD_DOWN_ARROW_ID);
    else
	GSetPen(nil, pen);
	GAMove(nil, 64, 55);
	GRDraw(nil, 5, 5);
	GRDraw(nil, 5, -5);
	GRMove(nil, -5, 5);
	GRDraw(nil, 0, -20);
    fi;
corp;

/*
 * DrawUpDown - draw up/down arrows for any of the auto graphics.
 */

define t_graphics proc public DrawUpDown(thing here; list int exits)void:
    int pen;

    pen := here@p_rEdgePen;
    if pen = 0 or pen = here@p_rBackGroundPen or pen = here@p_rForeGroundPen
    then
	pen := C_GOLD;
    fi;
    if FindElement(exits, D_UP) ~= -1 then
	DrawUpArrow(pen);
    fi;
    if FindElement(exits, D_DOWN) ~= -1 then
	DrawDownArrow(pen);
    fi;
corp;

/*
 * AutoRoads - autodraw a roads view.
 */

define t_graphics proc public AutoRoads()void:
    thing here;
    int background, foreground;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    if background = 0 and foreground = 0 then
	background := C_DARK_GREEN;
	foreground := C_TAN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, foreground);
    GAMove(nil, 80, 50);
    GEllipse(nil, 15, 12, true);
    if FindElement(exits, D_NORTH) ~= -1 then
	GAMove(nil, 65, 0);
	GRectangle(nil, 30, 50, true);
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 0);
	GRDraw(nil, 0, 16);
	GRDraw(nil, -70, 44);
	GRDraw(nil, -16, -21);
	GRDraw(nil, 62, -39);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GAMove(nil, 80, 38);
	GRectangle(nil, 79, 24, true);
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 99);
	GRDraw(nil, 0, -16);
	GRDraw(nil, -71, -43);
	GRDraw(nil, -16, 20);
	GRDraw(nil, 63, 39);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GAMove(nil, 65, 50);
	GRectangle(nil, 30, 49, true);
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 99);
	GRDraw(nil, 24, 0);
	GRDraw(nil, 67, -41);
	GRDraw(nil, -17, -19);
	GRDraw(nil, -74, 44);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GAMove(nil, 0, 38);
	GRectangle(nil, 80, 24, true);
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 0);
	GRDraw(nil, 24, 0);
	GRDraw(nil, 64, 40);
	GRDraw(nil, -16, 20);
	GRDraw(nil, -72, -44);
	GPolygonEnd(nil);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoPaths - autodraw a paths view.
 */

define t_graphics proc public AutoPaths()void:
    thing here;
    int background, foreground;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    if background = 0 and foreground = 0 then
	background := C_FOREST_GREEN;
	foreground := C_TAN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, foreground);
    GAMove(nil, 80, 50);
    GEllipse(nil, 5, 4, true);
    if FindElement(exits, D_NORTH) ~= -1 then
	GAMove(nil, 75, 0);
	GRectangle(nil, 10, 50, true);
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 0);
	GRDraw(nil, 0, 6);
	GRDraw(nil, -76, 47);
	GRDraw(nil, -6, -6);
	GRDraw(nil, 74, -47);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GAMove(nil, 80, 46);
	GRectangle(nil, 79, 8, true);
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 99);
	GRDraw(nil, 0, -6);
	GRDraw(nil, -76, -46);
	GRDraw(nil, -6, 6);
	GRDraw(nil, 74, 46);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GAMove(nil, 75, 50);
	GRectangle(nil, 10, 49, true);
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 99);
	GRDraw(nil, 8, 0);
	GRDraw(nil, 75, -46);
	GRDraw(nil, -6, -6);
	GRDraw(nil, -77, 46);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GAMove(nil, 0, 46);
	GRectangle(nil, 80, 8, true);
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 0);
	GRDraw(nil, 8, 0);
	GRDraw(nil, 75, 47);
	GRDraw(nil, -6, 6);
	GRDraw(nil, -77, -47);
	GPolygonEnd(nil);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoTunnels - autodraw a tunnels view.
 */

define t_graphics proc public AutoTunnels()void:
    thing here;
    int background, foreground;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    if background = 0 and foreground = 0 then
	background := C_DARK_GREY;
	foreground := C_LIGHT_GREY;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, foreground);
    GAMove(nil, 80, 50);
    GEllipse(nil, 14, 8, true);
    if FindElement(exits, D_NORTH) ~= -1 then
	GAMove(nil, 65, 0);
	GRectangle(nil, 29, 50, true);
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 0);
	GRDraw(nil, 0, 13);
	GRDraw(nil, -71, 44);
	GRDraw(nil, -15, -15);
	GRDraw(nil, 69, -42);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GAMove(nil, 80, 42);
	GRectangle(nil, 79, 16, true);
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 99);
	GRDraw(nil, 0, -13);
	GRDraw(nil, -70, -42);
	GRDraw(nil, -16, 13);
	GRDraw(nil, 69, 42);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GAMove(nil, 65, 50);
	GRectangle(nil, 29, 49, true);
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 99);
	GRDraw(nil, 14, 0);
	GRDraw(nil, 74, -42);
	GRDraw(nil, -15, -14);
	GRDraw(nil, -73, 43);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GAMove(nil, 0, 42);
	GRectangle(nil, 80, 16, true);
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 0);
	GRDraw(nil, 14, 0);
	GRDraw(nil, 75, 44);
	GRDraw(nil, -17, 13);
	GRDraw(nil, -72, -44);
	GPolygonEnd(nil);
    fi;
    DrawUpDown(here, exits);
corp;

define tp_graphics GREYS_TUNNEL_CHAMBER_ID NextEffectId().

/*
 * DrawTunnelChamber - draw the non-exit part of a tunnel chamber.
 */

define t_graphics proc DrawTunnelChamber(int background, foreground)void:

    if background = C_DARK_GREY and foreground = C_LIGHT_GREY then
	if not KnowsEffect(nil, GREYS_TUNNEL_CHAMBER_ID) then
	    DefineEffect(nil, GREYS_TUNNEL_CHAMBER_ID);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GPolygonStart(nil);
	    GAMove(nil, 40, 20);
	    GRDraw(nil, 79, 0);
	    GRDraw(nil, 20, 15);
	    GRDraw(nil, 0, 29);
	    GRDraw(nil, -20, 15);
	    GRDraw(nil, -79, 0);
	    GRDraw(nil, -20, -15);
	    GRDraw(nil, 0, -29);
	    GPolygonEnd(nil);
	    EndEffect();
	fi;
	CallEffect(nil, GREYS_TUNNEL_CHAMBER_ID);
    else
	GSetPen(nil, background);
	GAMove(nil, 0, 0);
	GRectangle(nil, 159, 99, true);
	GSetPen(nil, foreground);
	GPolygonStart(nil);
	GAMove(nil, 40, 20);
	GRDraw(nil, 79, 0);
	GRDraw(nil, 20, 15);
	GRDraw(nil, 0, 29);
	GRDraw(nil, -20, 15);
	GRDraw(nil, -79, 0);
	GRDraw(nil, -20, -15);
	GRDraw(nil, 0, -29);
	GPolygonEnd(nil);
    fi;
corp;

/*
 * AutoTunnelChamber - autodraw a large tunnel chamber.
 */

define t_graphics proc public AutoTunnelChamber()void:
    thing here;
    int background, foreground;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    if background = 0 and foreground = 0 then
	background := C_DARK_GREY;
	foreground := C_LIGHT_GREY;
    fi;
    exits := here@p_rExits;
    DrawTunnelChamber(background, foreground);
    if FindElement(exits, D_NORTH) ~= -1 then
	GAMove(nil, 65, 0);
	GRectangle(nil, 29, 20, true);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GAMove(nil, 65, 79);
	GRectangle(nil, 29, 20, true);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GAMove(nil, 139, 42);
	GRectangle(nil, 20, 15, true);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GAMove(nil, 0, 42);
	GRectangle(nil, 20, 15, true);
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 119, 20);
	GRDraw(nil, 20, -20);
	GRDraw(nil, 20, 0);
	GRDraw(nil, 0, 15);
	GRDraw(nil, -20, 20);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 119, 79);
	GRDraw(nil, 20, 20);
	GRDraw(nil, 20, 0);
	GRDraw(nil, 0, -15);
	GRDraw(nil, -20, -20);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 40, 20);
	GRDraw(nil, -20, -20);
	GRDraw(nil, -20, 0);
	GRDraw(nil, 0, 15);
	GRDraw(nil, 20, 20);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GPolygonStart(nil);
	GAMove(nil, 40, 79);
	GRDraw(nil, -20, 20);
	GRDraw(nil, -20, 0);
	GRDraw(nil, 0, -15);
	GRDraw(nil, 20, -20);
	GPolygonEnd(nil);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoOpenSpace - autodraw an open space with edges.
 */

define t_graphics proc public AutoOpenSpace()void:
    thing here;
    int background, foreground;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    if background = 0 and foreground = 0 then
	foreground := C_DARK_GREEN;
	background := C_DARK_BROWN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, foreground);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, background);
    if FindElement(exits, D_NORTH) = -1 then
	GAMove(nil, 40, 0);
	GRectangle(nil, 79, 19, true);
    fi;
    if FindElement(exits, D_NORTHEAST) = -1 then
	GPolygonStart(nil);
	GAMove(nil, 119, 0);
	GRDraw(nil, 40, 0);
	GRDraw(nil, 0, 29);
	GRDraw(nil, -19, 0);
	GRDraw(nil, 0, -10);
	GRDraw(nil, -21, 0);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_EAST) = -1 then
	GAMove(nil, 140, 30);
	GRectangle(nil, 19, 39, true);
    fi;
    if FindElement(exits, D_SOUTHEAST) = -1 then
	GPolygonStart(nil);
	GAMove(nil, 159, 70);
	GRDraw(nil, 0, 29);
	GRDraw(nil, -39, 0);
	GRDraw(nil, 0, -19);
	GRDraw(nil, 20, 0);
	GRDraw(nil, 0, -10);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_SOUTH) = -1 then
	GAMove(nil, 40, 80);
	GRectangle(nil, 79, 19, true);
    fi;
    if FindElement(exits, D_SOUTHWEST) = -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 70);
	GRDraw(nil, 0, 29);
	GRDraw(nil, 39, 0);
	GRDraw(nil, 0, -19);
	GRDraw(nil, -20, 0);
	GRDraw(nil, 0, -10);
	GPolygonEnd(nil);
    fi;
    if FindElement(exits, D_WEST) = -1 then
	GAMove(nil, 0, 30);
	GRectangle(nil, 19, 39, true);
    fi;
    if FindElement(exits, D_NORTHWEST) = -1 then
	GPolygonStart(nil);
	GAMove(nil, 0, 29);
	GRDraw(nil, 0, -29);
	GRDraw(nil, 39, 0);
	GRDraw(nil, 0, 19);
	GRDraw(nil, -20, 0);
	GRDraw(nil, 0, 10);
	GPolygonEnd(nil);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoOpenRoom - autodraw a room with corridors.
 */

define t_graphics proc public AutoOpenRoom()void:
    thing here;
    int background, foreground, edge;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    edge := here@p_rEdgePen;
    if background = 0 and foreground = 0 and edge = 0 then
	foreground := C_BLACK;
	background := C_MEDIUM_GREY;
	edge := C_TAN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, edge);
    GAMove(nil, 19, 19);
    GRectangle(nil, 121, 61, false);
    GSetPen(nil, foreground);
    GAMove(nil, 20, 20);
    GRectangle(nil, 119, 59, true);
    if FindElement(exits, D_NORTH) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 66, 0);
	GRectangle(nil, 27, 19, true);
	GSetPen(nil, edge);
	GAMove(nil, 65, 0);
	GRDraw(nil, 0, 19);
	GAMove(nil, 94, 0);
	GRDraw(nil, 0, 19);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 66, 79);
	GRectangle(nil, 27, 20, true);
	GSetPen(nil, edge);
	GAMove(nil, 65, 80);
	GRDraw(nil, 0, 19);
	GAMove(nil, 94, 80);
	GRDraw(nil, 0, 19);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 140, 40);
	GRectangle(nil, 19, 19, true);
	GSetPen(nil, edge);
	GAMove(nil, 140, 40);
	GRDraw(nil, 19, 0);
	GAMove(nil, 140, 60);
	GRDraw(nil, 19, 0);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 0, 40);
	GRectangle(nil, 19, 19, true);
	GSetPen(nil, edge);
	GAMove(nil, 0, 40);
	GRDraw(nil, 19, 0);
	GAMove(nil, 0, 60);
	GRDraw(nil, 19, 0);
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 121, 0);
	GRectangle(nil, 38, 24, true);
	GSetPen(nil, edge);
	GAMove(nil, 120, 0);
	GRDraw(nil, 0, 19);
	GAMove(nil, 140, 25);
	GRDraw(nil, 19, 0);
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 0, 0);
	GRectangle(nil, 39, 24, true);
	GSetPen(nil, edge);
	GAMove(nil, 39, 0);
	GRDraw(nil, 0, 19);
	GAMove(nil, 0, 25);
	GRDraw(nil, 19, 0);
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 120, 74);
	GRectangle(nil, 39, 25, true);
	GSetPen(nil, edge);
	GAMove(nil, 120, 80);
	GRDraw(nil, 0, 19);
	GAMove(nil, 140, 74);
	GRDraw(nil, 19, 0);
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GSetPen(nil, foreground);
	GAMove(nil, 0, 74);
	GRectangle(nil, 40, 25, true);
	GSetPen(nil, edge);
	GAMove(nil, 40, 80);
	GRDraw(nil, 0, 19);
	GAMove(nil, 0, 74);
	GRDraw(nil, 19, 0);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoHalls - a simple horizontal/vertical hallway set.
 */

define t_graphics proc public AutoHalls()void:
    thing here;
    list int exits;
    int background, foreground, edge;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    edge := here@p_rEdgePen;
    if background = 0 and foreground = 0 and edge = 0 then
	foreground := C_BLACK;
	background := C_MEDIUM_GREY;
	edge := C_TAN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, edge);
    GAMove(nil, 65, 40);
    GRectangle(nil, 29, 20, false);
    GSetPen(nil, foreground);
    GAMove(nil, 66, 41);
    GRectangle(nil, 27, 18, true);
    if FindElement(exits, D_NORTH) ~= -1 then
	GSetPen(nil, edge);
	GAMove(nil, 65, 0);
	GRDraw(nil, 0, 39);
	GAMove(nil, 94, 0);
	GRDraw(nil, 0, 39);
	GSetPen(nil, foreground);
	GAMove(nil, 66, 0);
	GRectangle(nil, 27, 40, true);
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GSetPen(nil, edge);
	GAMove(nil, 65, 61);
	GRDraw(nil, 0, 38);
	GAMove(nil, 94, 61);
	GRDraw(nil, 0, 38);
	GSetPen(nil, foreground);
	GAMove(nil, 66, 60);
	GRectangle(nil, 27, 39, true);
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GSetPen(nil, edge);
	GAMove(nil, 95, 40);
	GRDraw(nil, 64, 0);
	GAMove(nil, 95, 60);
	GRDraw(nil, 64, 0);
	GSetPen(nil, foreground);
	GAMove(nil, 94, 41);
	GRectangle(nil, 65, 18, true);
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GSetPen(nil, edge);
	GAMove(nil, 0, 40);
	GRDraw(nil, 64, 0);
	GAMove(nil, 0, 60);
	GRDraw(nil, 64, 0);
	GSetPen(nil, foreground);
	GAMove(nil, 0, 41);
	GRectangle(nil, 65, 18, true);
    fi;
    DrawUpDown(here, exits);
corp;

/*
 * AutoClosedRoom - autodraw a room with doors.
 */

define t_graphics proc public AutoClosedRoom()void:
    thing here;
    int background, foreground, edge, door;
    list int exits;

    here := Here();
    background := here@p_rBackGroundPen;
    foreground := here@p_rForeGroundPen;
    edge := here@p_rEdgePen;
    door := here@p_rDoorPen;
    if background = 0 and foreground = 0 and edge = 0 and door = 0 then
	background := C_MEDIUM_GREY;
	foreground := C_BLACK;
	edge := C_TAN;
	door := C_BROWN;
    fi;
    exits := here@p_rExits;
    GSetPen(nil, background);
    GAMove(nil, 0, 0);
    GRectangle(nil, 159, 99, true);
    GSetPen(nil, edge);
    GAMove(nil, 19, 19);
    GRectangle(nil, 121, 61, false);
    GSetPen(nil, foreground);
    GAMove(nil, 20, 20);
    GRectangle(nil, 119, 59, true);
    GSetPen(nil, door);
    if FindElement(exits, D_NORTH) ~= -1 then
	GAMove(nil, 75, 19);
	HorizontalDoor();
    fi;
    if FindElement(exits, D_SOUTH) ~= -1 then
	GAMove(nil, 75, 80);
	HorizontalDoor();
    fi;
    if FindElement(exits, D_EAST) ~= -1 then
	GAMove(nil, 140, 46);
	VerticalDoor();
    fi;
    if FindElement(exits, D_WEST) ~= -1 then
	GAMove(nil, 19, 46);
	VerticalDoor();
    fi;
    if FindElement(exits, D_NORTHEAST) ~= -1 then
	GSetPen(nil, background);
	GPolygonStart(nil);
	GAMove(nil, 136, 19);
	GRDraw(nil, 4, 0);
	GRDraw(nil, 0, 4);
	GPolygonEnd(nil);
	GSetPen(nil, door);
	GAMove(nil, 136, 19);
	NorthEastDoor();
    fi;
    if FindElement(exits, D_NORTHWEST) ~= -1 then
	GSetPen(nil, background);
	GPolygonStart(nil);
	GAMove(nil, 23, 19);
	GRDraw(nil, -4, 0);
	GRDraw(nil, 0, 4);
	GPolygonEnd(nil);
	GSetPen(nil, door);
	GAMove(nil, 23, 19);
	NorthWestDoor();
    fi;
    if FindElement(exits, D_SOUTHEAST) ~= -1 then
	GSetPen(nil, background);
	GPolygonStart(nil);
	GAMove(nil, 136, 80);
	GRDraw(nil, 4, 0);
	GRDraw(nil, 0, -4);
	GPolygonEnd(nil);
	GSetPen(nil, door);
	GAMove(nil, 140, 76);
	NorthWestDoor();
    fi;
    if FindElement(exits, D_SOUTHWEST) ~= -1 then
	GSetPen(nil, background);
	GPolygonStart(nil);
	GAMove(nil, 23, 80);
	GRDraw(nil, -4, 0);
	GRDraw(nil, 0, -4);
	GPolygonEnd(nil);
	GSetPen(nil, door);
	GAMove(nil, 19, 76);
	NorthEastDoor();
    fi;
    DrawUpDown(here, exits);
corp;

/* routines for the icon editor */

define tp_graphics EDIT_DONE_BUTTON	14.
define tp_graphics EDIT_CANCEL_BUTTON	15.
define tp_graphics EDIT_CLEAR_BUTTON	16.
define tp_graphics EDIT_REGION		2.

define tp_graphics p_pEditRestoreAction CreateActionProp().
define tp_graphics p_pEditIcon CreateIntListProp().
define tp_graphics p_pEISaveButtonAction CreateActionProp().
define tp_graphics p_pEISaveMouseAction CreateActionProp().
define tp_graphics p_pEISaveIdleAction CreateActionProp().
define tp_graphics p_pEIIsCursor CreateBoolProp().

define tp_graphics proc showIconPixel(int x, y)void:
    int n;

    n := y * 16 + x;
    if (Me()@p_pEditIcon[n >> 5] >> (31 - n & 0x1f)) & 1 ~= 0 then
	GSetPen(nil, C_WHITE);
    else
	GSetPen(nil, C_BLACK);
    fi;
    GAMove(nil, 30 + x * 6, 20 + y * 4);
    GRectangle(nil, 5, 3, true);
    GAMove(nil, 140 + x, 80 + y);
    GPixel(nil);
corp;

define tp_graphics proc showWholeIcon()void:
    int x, y;

    for x from 0 upto 15 do
	for y from 0 upto 15 do
	    showIconPixel(x, y);
	od;
    od;
corp;

define tp_graphics proc iconEditMouseHandler(int n, x, y)void:

    if n = EDIT_REGION then
	x := x / 6;
	y := y / 4;
	n := y * 16 + x;
	Me()@p_pEditIcon[n >> 5] := Me()@p_pEditIcon[n >> 5] ><
	    (1 << (31 - n & 0x1f));
	GUndrawIcons(nil);
	showIconPixel(x, y);
	GRedrawIcons(nil);
    fi;
    /* do not complain about other regions hit - MOVE_REGION is all around
       EDIT_REGION, and we just want to ignore hits there. */
corp;

define tp_graphics proc iconEditButtonHandler(int whichButton)void:
    thing me;
    action a;
    int i;
    list int icon;

    me := Me();
    if whichButton = EDIT_CLEAR_BUTTON then
	icon := Me()@p_pEditIcon;
	for i from 0 upto 7 do
	    icon[i] := 0b0;
	od;
	GUndrawIcons(nil);
	showWholeIcon();
	GRedrawIcons(nil);
    else
	if whichButton = EDIT_DONE_BUTTON then
	    if me@p_pEIIsCursor then
		me@p_pCursor := me@p_pEditIcon;
		SetCursorPattern(me@p_pCursor);
	    else
		GNewIcon(me, me@p_pEditIcon);
	    fi;
	fi;
	me -- p_pEIIsCursor;
	me -- p_pEditIcon;
	ignore SetCharacterButtonAction(me@p_pEISaveButtonAction);
	me -- p_pEISaveButtonAction;
	ignore SetCharacterMouseDownAction(me@p_pEISaveMouseAction);
	me -- p_pEISaveMouseAction;
	ignore SetCharacterIdleAction(me@p_pEISaveIdleAction);
	me -- p_pEISaveIdleAction;
	EraseButton(EDIT_DONE_BUTTON);
	EraseButton(EDIT_CANCEL_BUTTON);
	EraseButton(EDIT_CLEAR_BUTTON);
	EraseRegion(EDIT_REGION);
	GUndrawIcons(nil);
	GSetPen(nil, C_BLACK);
	GAMove(nil, 0, 0);
	GRectangle(nil, 159, 99, true);
	a := me@p_pEditRestoreAction;
	if a ~= nil then
	    me -- p_pEditRestoreAction;
	    call(a, void)();
	fi;
	GRedrawIcons(nil);
    fi;
corp;

define tp_graphics proc iconEditIdleHandler()void:
    thing me;
    action a;

    me := Me();
    me -- p_pEIIsCursor;
    me -- p_pEditIcon;
    ignore SetCharacterButtonAction(me@p_pEISaveButtonAction);
    me -- p_pEISaveButtonAction;
    ignore SetCharacterMouseDownAction(me@p_pEISaveMouseAction);
    me -- p_pEISaveMouseAction;
    a := me@p_pEISaveIdleAction;
    ignore SetCharacterIdleAction(a);
    me -- p_pEISaveIdleAction;
    me -- p_pEditRestoreAction;
    call(a, void)();
corp;

define tp_graphics proc copyIcon(list int old)list int:
    list int new;
    int i;

    new := CreateIntArray(8);
    for i from 0 upto 7 do
	new[i] := old[i];
    od;
    new
corp;

define tp_graphics EDIT_BOX_ID NextEffectId().

define tp_graphics proc startEdit()void:
    thing me;
    action a;
    int i;

    me := Me();
    a := SetCharacterButtonAction(iconEditButtonHandler);
    if a ~= nil then
	me@p_pEISaveButtonAction := a;
    fi;
    a := SetCharacterMouseDownAction(iconEditMouseHandler);
    if a ~= nil then
	me@p_pEISaveMouseAction := a;
    fi;
    a := SetCharacterIdleAction(iconEditIdleHandler);
    if a ~= nil then
	me@p_pEISaveIdleAction := a;
    fi;
    if not KnowsEffect(nil, EDIT_BOX_ID) then
	DefineEffect(nil, EDIT_BOX_ID);
	AddButton(164, 83, EDIT_DONE_BUTTON, "Done");
	AddButton(208, 83, EDIT_CANCEL_BUTTON, "Cancel");
	AddButton(268, 83, EDIT_CLEAR_BUTTON, "Clear");
	AddRegion(30, 20, 125, 83, EDIT_REGION);
	GUndrawIcons(nil);
	RemoveCursor();
	ClearGraphics();
	for i from 0 upto 3 do
	    GSetPen(nil, i + 1);
	    GAMove(nil, 26 + i, 16 + i);
	    GRectangle(nil, 103 - 2 * i, 71 - 2 * i, false);
	od;
	EndEffect();
    fi;
    CallEffect(nil, EDIT_BOX_ID);
    showWholeIcon();
    GRedrawIcons(nil);
corp;

define t_graphics proc public StartIconEdit(action restoreAction)void:
    list int icon;
    thing me;

    me := Me();
    if restoreAction ~= nil then
	me@p_pEditRestoreAction := restoreAction;
    fi;
    icon := me@p_pIcon;
    if icon = nil then
	icon := CreateIntArray(8);
	/* fill in the default smiley-face icon */
	icon[0] := 0b00000000000000000000000000000000;
	icon[1] := 0b00000011110000000000110000110000;
	icon[2] := 0b00010000000010000001000000001000;
	icon[3] := 0b00100110011001000010000000000100;
	icon[4] := 0b00100000000001000010010000100100;
	icon[5] := 0b00010011110010000001000000001000;
	icon[6] := 0b00001100001100000000001111000000;
	icon[7] := 0b00000000000000000000000000000000;
    else
	/* lists are true database objects - we cannot do a 'cancel' if we
	   just edit the original! */
	icon := copyIcon(icon);
    fi;
    me@p_pEditIcon := icon;
    me@p_pEIIsCursor := false;
    startEdit();
corp;

define t_graphics proc public StartCursorEdit(action restoreAction)void:
    thing me;

    me := Me();
    if restoreAction ~= nil then
	me@p_pEditRestoreAction := restoreAction;
    fi;
    me@p_pEditIcon := copyIcon(me@p_pCursor);
    me@p_pEIIsCursor := true;
    startEdit();
corp;

unuse tp_graphics
