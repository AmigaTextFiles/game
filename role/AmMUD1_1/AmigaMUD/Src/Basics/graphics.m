/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * graphics.m - some stuff to do simple graphics.
 */

private tp_graphics CreateTable()$
use tp_graphics

define t_graphics p_rName1 CreateStringProp()$
define t_graphics p_rName2 CreateStringProp()$
define t_graphics p_rBackGroundPen CreateIntProp()$
define t_graphics p_rForeGroundPen CreateIntProp()$
define t_graphics p_rEdgePen CreateIntProp()$
define t_graphics p_rDoorPen CreateIntProp()$
define t_graphics p_rCursorX CreateFixedProp()$
define t_graphics p_rCursorY CreateFixedProp()$
define t_graphics p_rDrawAction CreateActionProp()$
define t_graphics p_pStandardButtonsNow CreateBoolProp()$

define tp_graphics p_rAutoGraphics CreateBoolProp()$
define tp_graphics p_rAutoDrawAction CreateActionProp()$
define tp_graphics p_pXBase CreateIntProp()$
define tp_graphics p_pYBase CreateIntProp()$

/* first, some names for the standard colours */

define t_graphics C_BLACK	    0$
define t_graphics C_DARK_GREY	    1$
define t_graphics C_MEDIUM_GREY     2$
define t_graphics C_LIGHT_GREY	    3$
define t_graphics C_WHITE	    4$
define t_graphics C_BRICK_RED	    5$
define t_graphics C_RED 	    6$
define t_graphics C_RED_ORANGE	    7$
define t_graphics C_ORANGE	    8$
define t_graphics C_GOLD	    9$
define t_graphics C_CADMIUM_YELLOW 10$
define t_graphics C_LEMON_YELLOW   11$
define t_graphics C_LIME_GREEN	   12$
define t_graphics C_GREEN	   13$
define t_graphics C_LIGHT_GREEN    14$
define t_graphics C_DARK_GREEN	   15$
define t_graphics C_FOREST_GREEN   16$
define t_graphics C_BLUE_GREEN	   17$
define t_graphics C_AQUA	   18$
define t_graphics C_LIGHT_AQUA	   19$
define t_graphics C_SKY_BLUE	   20$
define t_graphics C_LIGHT_BLUE	   21$
define t_graphics C_BLUE	   22$
define t_graphics C_DARK_BLUE	   23$
define t_graphics C_VIOLET	   24$
define t_graphics C_PURPLE	   25$
define t_graphics C_FLESH	   26$
define t_graphics C_PINK	   27$
define t_graphics C_TAN 	   28$
define t_graphics C_BROWN	   29$
define t_graphics C_MEDIUM_BROWN   30$
define t_graphics C_DARK_BROWN	   31$

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
	    "flesh.pink.tan.brown.brown;medium.brown;dark", name)
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
    incase C_FLESH:		"flesh"
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
    int i;

    Print("Known colours are: ");
    for i from C_BLACK upto C_MEDIUM_BROWN do
	Print(ColourName(i));
	Print(", ");
    od;
    Print(ColourName(C_DARK_BROWN));
    Print("\n");
corp;

/* tools for providing unique map group and effect id values */

/* some standard MapGroup values */

define t_graphics UNKNOWN_MAP_GROUP	-1$
define t_graphics NO_MAP_GROUP		0$
define t_graphics AUTO_MAP_GROUP	1$

define tp_graphics GraphicsThing CreateThing(nil)$
define tp_graphics p_NextMapGroup CreateIntProp()$
define tp_graphics p_NextEffectId CreateIntProp()$
GraphicsThing@p_NextMapGroup := AUTO_MAP_GROUP + 1$
GraphicsThing@p_NextEffectId := 1$

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

define tp_graphics ROOM_NAME_BOX_ID NextEffectId()$
define tp_graphics NAME_BOX_COLS 18$

define t_graphics proc public DrawRoomNameBox()void:
    int i, cols;

    if not KnowsEffect(nil, ROOM_NAME_BOX_ID) then
	cols := GCols(nil) / 2;
	DefineEffect(nil, ROOM_NAME_BOX_ID);
	GAMovePixels(nil, cols + (cols - NAME_BOX_COLS * 8 - 12) / 2, 0);
	for i from 0 upto 3 do
	    GSetPen(nil, i + 1);
	    GRectanglePixels(nil, NAME_BOX_COLS * 8 + 12 - 2 * i, 29 - 2 * i,
			     false);
	    GRMovePixels(nil, 1, 1);
	od;
	EndEffect();
    fi;
    CallEffect(nil, ROOM_NAME_BOX_ID);
corp;

define t_graphics proc public DrawRoomName(string s1, s2)void:
    int len, cols, col;

    cols := GCols(nil) / 2;
    col := cols + (cols - NAME_BOX_COLS * 8 - 12) / 2;
    GSetPen(nil, C_BLACK);
    GAMovePixels(nil, col + 6, 6);
    GRectanglePixels(nil, NAME_BOX_COLS * 8, 17, true);
    GSetPen(nil, C_GOLD);
    len := Length(s2);
    if len ~= 0 then
	if len > NAME_BOX_COLS then
	    len := NAME_BOX_COLS;
	    s2 := SubString(s2, 0, NAME_BOX_COLS);
	fi;
	GAMovePixels(nil, col + 6 + (NAME_BOX_COLS - len) * 4, 21);
	GText(nil, s2);
	len := Length(s1);
	if len > NAME_BOX_COLS then
	    len := NAME_BOX_COLS;
	    s1 := SubString(s1, 0, NAME_BOX_COLS);
	fi;
	GAMovePixels(nil, col + 6 + (NAME_BOX_COLS - len) * 4, 12);
	GText(nil, s1);
    else
	len := Length(s1);
	if len > NAME_BOX_COLS then
	    len := NAME_BOX_COLS;
	    s1 := SubString(s1, 0, NAME_BOX_COLS);
	fi;
	GAMovePixels(nil, col + 6 + (NAME_BOX_COLS - len) * 4, 17);
	GText(nil, s1);
    fi;
corp;

define tp_graphics HORIZONTAL_DOOR_ID NextEffectId()$
define tp_graphics VERTICAL_DOOR_ID NextEffectId()$
define tp_graphics NORTHWEST_DOOR_ID NextEffectId()$
define tp_graphics NORTHEAST_DOOR_ID NextEffectId()$

define t_graphics proc public HorizontalDoor()void:

    if not KnowsEffect(nil, HORIZONTAL_DOOR_ID) then
	DefineEffect(nil, HORIZONTAL_DOOR_ID);
	GRMove(nil, 0.0, -0.01);
	GRDraw(nil, 0.0, 0.021);
	GRMove(nil, 0.0, -0.01);
	GRDraw(nil, 0.03125, 0.0);
	GRMove(nil, 0.0, -0.01);
	GRDraw(nil, 0.0, 0.021);
	EndEffect();
    fi;
    CallEffect(nil, HORIZONTAL_DOOR_ID);
corp;

define t_graphics proc public VerticalDoor()void:

    if not KnowsEffect(nil, VERTICAL_DOOR_ID) then
	DefineEffect(nil, VERTICAL_DOOR_ID);
	GRMove(nil, -0.003, 0.0);
	GRDraw(nil, 0.007, 0.0);
	GRMove(nil, -0.003, 0.0);
	GRDraw(nil, 0.0, 0.081);
	GRMove(nil, -0.003, 0.0);
	GRDraw(nil, 0.007, 0.0);
	EndEffect();
    fi;
    CallEffect(nil, VERTICAL_DOOR_ID);
corp;

define t_graphics proc public NorthWestDoor()void:

    if not KnowsEffect(nil, NORTHWEST_DOOR_ID) then
	DefineEffect(nil, NORTHWEST_DOOR_ID);
	GRMove(nil, -0.003, -0.012);
	GRDraw(nil, 0.007, 0.021);
	GRMove(nil, -0.003, -0.012);
	GRDraw(nil, -0.013, 0.041);
	GRMove(nil, -0.003, -0.012);
	GRDraw(nil, 0.007, 0.021);
	EndEffect();
    fi;
    CallEffect(nil, NORTHWEST_DOOR_ID);
corp;

define t_graphics proc public NorthEastDoor()void:

    if not KnowsEffect(nil, NORTHEAST_DOOR_ID) then
	DefineEffect(nil, NORTHEAST_DOOR_ID);
	GRMove(nil, 0.003, -0.012);
	GRDraw(nil, -0.007, 0.021);
	GRMove(nil, 0.003, -0.012);
	GRDraw(nil, 0.013, 0.042);
	GRMove(nil, 0.003, -0.012);
	GRDraw(nil, -0.007, 0.021);
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

define t_graphics NW_BUTTON	1$
define t_graphics N_BUTTON	2$
define t_graphics NE_BUTTON	3$
define t_graphics W_BUTTON	4$
define t_graphics L_BUTTON	5$
define t_graphics E_BUTTON	6$
define t_graphics SW_BUTTON	7$
define t_graphics S_BUTTON	8$
define t_graphics SE_BUTTON	9$
define t_graphics D_BUTTON	10$
define t_graphics U_BUTTON	11$
define t_graphics I_BUTTON	12$
define t_graphics O_BUTTON	13$
define t_graphics MOVE_REGION	1000$	/* want it large, so others override */

define tp_graphics ADD_DIRECTION_BUTTONS_ID NextEffectId()$
define tp_graphics ERASE_DIRECTION_BUTTONS_ID NextEffectId()$

define t_graphics proc public AddDirectionButtons()void:
    int xBase, yBase;

    xBase := GCols(nil) * 3 / 4;
    yBase := GRows(nil) / 2;
    if not KnowsEffect(nil, ADD_DIRECTION_BUTTONS_ID) then
	DefineEffect(nil, ADD_DIRECTION_BUTTONS_ID);
	AddButtonPixels(xBase - 34, yBase - 19, NW_BUTTON, "NW");
	AddButtonPixels(xBase -  9, yBase - 19,  N_BUTTON, "N" );
	AddButtonPixels(xBase +  8, yBase - 19, NE_BUTTON, "NE");
	AddButtonPixels(xBase - 30, yBase -  2,  W_BUTTON, "W" );
	AddButtonPixels(xBase + 12, yBase -  2,  E_BUTTON, "E" );
	AddButtonPixels(xBase - 34, yBase + 15, SW_BUTTON, "SW");
	AddButtonPixels(xBase -  9, yBase + 15,  S_BUTTON, "S" );
	AddButtonPixels(xBase +  8, yBase + 15, SE_BUTTON, "SE");
	AddButtonPixels(xBase + 33, yBase - 11,  U_BUTTON, "U" );
	AddButtonPixels(xBase + 33, yBase +  7,  D_BUTTON, "D" );
	AddButtonPixels(xBase - 51, yBase - 11,  I_BUTTON, "I" );
	AddButtonPixels(xBase - 51, yBase +  7,  O_BUTTON, "O" );
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
    AddButtonPixels(GCols(nil) * 3 / 4 - 9, GRows(nil) / 2 - 2, L_BUTTON, "L");
    Me()@p_pStandardButtonsNow := true;
corp;

define t_graphics proc public AddStandardRegions()void:

    AddRegion(0.0, 0.0, 0.5, 1.0, MOVE_REGION);
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
    fixed fracX, fracY;
    int rows, cols, cursorX, cursorY, deltaX, deltaY;

    if region = MOVE_REGION then
	here := Here();
	fracX := here@p_rCursorX;
	fracY := here@p_rCursorY;
	if fracX = 0.0 and fracY = 0.0 and here@p_rAutoGraphics then
	    /* pick the middle of the mapping region */
	    fracX := 0.25;
	    fracY := 0.5;
	fi;
	rows := GRows(nil);
	cols := GCols(nil);
	cursorX := FixedToInt(fracX * IntToFixed(cols));
	cursorY := FixedToInt(fracY * IntToFixed(rows));
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

define t_graphics p_pStandardGraphicsDone CreateBoolProp()$

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

/* Simply display the currently set image file. Using this routine keeps
   all of the magic "GShowImage" parameters all in one place. */

define t_graphics proc public ShowCurrentImage()void:

    GShowImage(nil, "", 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.5, 1.0);
corp;

define t_graphics proc public ShowImage(string name)void:

    GSetImage(nil, name);
    IfFound(nil);
	RemoveCursor();
	GResetIcons(nil);
	ShowCurrentImage();
    Fi(nil);
    Me()@p_MapGroup := NO_MAP_GROUP;
corp;

define t_graphics proc public ShowImageAndRefresh(string name)void:

    GSetImage(nil, name);
    IfFound(nil);
	RemoveCursor();
	GResetIcons(nil);
	ShowCurrentImage();
	GRedrawIcons(nil);
	PlaceCursor(0.253 - 3.0 / IntToFixed(GCols(nil)),
		    0.499  - 3.0 / IntToFixed(GRows(nil)));
    Fi(nil);
    Me()@p_MapGroup := NO_MAP_GROUP;
corp;

define tp_graphics CLEAR_GRAPHICS_ID NextEffectId()$

define t_graphics proc public ClearGraphics()void:

    if not KnowsEffect(nil, CLEAR_GRAPHICS_ID) then
	DefineEffect(nil, CLEAR_GRAPHICS_ID);
	GSetPen(nil, C_BLACK);
	GAMove(nil, 0.0, 0.0);
	GRectangle(nil, 0.5, 1.0, true);
	EndEffect();
    fi;
    CallEffect(nil, CLEAR_GRAPHICS_ID);
corp;

/* these are used when entering and exiting a room using this scheme. */

define t_graphics proc public EnterRoomDraw()void:
    thing me, here;
    int g, len, pos;
    fixed xAdj, yAdj;
    string name;
    action a;

    xAdj := 3.0 / IntToFixed(GCols(nil));
    yAdj := 3.0 / IntToFixed(GRows(nil));
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
	if here@p_Image ~= "" then
	    /* Use key 0 - this is a temporary effect only. */
	    DefineEffect(nil, 0);
	    GSetImage(nil, here@p_Image);
	    IfFound(nil);
		ShowCurrentImage();
	    Else(nil);
		if a ~= nil then
		    call(a, void)();
		fi;
	    Fi(nil);
	    EndEffect();
	    CallEffect(nil, 0);
	else
	    if a ~= nil then
		call(a, void)();
	    fi;
	fi;
	if here@p_rName1 ~= "" then
	    DrawRoomName(here@p_rName1, here@p_rName2);
	else
	    a := here@p_rNameAction;
	    if a ~= nil then
		name := call(a, string)();
	    else
		name := here@p_rName;
	    fi;
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
	PlaceCursor(0.253 - xAdj, 0.499 - yAdj);
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
	if here@p_rCursorX ~= 0.0 or here@p_rCursorY ~= 0.0 then
	    /* Location specifies center of cursor. Adjust for the standard
	       7x7 cursor pattern. */
	    PlaceCursor(here@p_rCursorX - xAdj, here@p_rCursorY - yAdj);
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
	int group; fixed x, y; action drawAction)void:

    room -- p_rAutoGraphics;
    if name1 ~= "" then
	room@p_rName1 := name1;
    fi;
    if name2 ~= "" then
	room@p_rName2 := name2;
    fi;
    room@p_MapGroup := group;
    if x ~= 0.0 then
	room@p_rCursorX := x;
    fi;
    if y ~= 0.0 then
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

define t_graphics proc public utility AutoGraphics(thing room;
    action drawAction)void:

    room@p_rAutoGraphics := true;
    room@p_rEnterRoomDraw := EnterRoomDraw;
    room@p_rLeaveRoomDraw := LeaveRoomDraw;
    room@p_rAutoDrawAction := drawAction;
corp;

/*
 * AutoRedraw - redraw the room for the current user.
 */

define t_graphics proc public utility AutoRedraw()void:
    action a;

    if Here()@p_rDrawAction = nil then
	a := Here()@p_rAutoDrawAction;
	if a ~= nil then
	    GUndrawIcons(nil);
	    RemoveCursor();
	    call(a, void)();
	    GRedrawIcons(nil);
	    PlaceCursor(0.253 - 3.0 / IntToFixed(GCols(nil)),
			0.499  - 3.0 / IntToFixed(GRows(nil)));
	fi;
    fi;
corp;

/*
 * AutoPens - set the pens for auto graphics.
 */

define t_graphics proc public utility AutoPens(thing room;
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

define t_graphics proc public utility RoomName(thing room;
    string name1, name2)void:

    room@p_rName1 := name1;
    if name2 ~= "" then
	room@p_rName2 := name2;
    else
	room -- p_rName2;
    fi;
corp;

/*
 * TextBox - draw, as the complete graphics for a room, a pretty box
 *	containing 1, 2, or 3 lines of text. Heavy assumption of using
 *	an 8 x 8 fixed font.
 */

define t_graphics proc TextBox(string s1, s2, s3)void:
    int rows, cols, maxChars, xOffset, yOffset, len1, len2, len3,
	width, height, i;

    rows := GRows(nil);
    cols := GCols(nil) / 2;
    maxChars := (cols - 10) / 8;
    len1 := Length(s1);
    if len1 > maxChars then
	len1 := maxChars;
    fi;
    len2 := Length(s2);
    if len2 > maxChars then
	len2 := maxChars;
    fi;
    len3 := Length(s3);
    if len3 > maxChars then
	len3 := maxChars;
    fi;
    maxChars := len1;
    if len2 > maxChars then
	maxChars := len2;
    fi;
    if len3 > maxChars then
	maxChars := len3;
    fi;
    xOffset := (cols - 10 - maxChars * 8) / 2;
    width := 10 + maxChars * 8;
    if s3 = "" then
	if s2 = "" then
	    yOffset := (rows - 10 - 1 * 8) / 2;
	    height := 10 + 1 * 8;
	else
	    yOffset := (rows - 10 - 2 * 8) / 2;
	    height := 11 + 2 * 8;
	fi;
    else
	yOffset := (rows - 10 - 3 * 8) / 2;
	height := 12 + 3 * 8;
    fi;
    GAMovePixels(nil, xOffset, yOffset);
    for i from 0 upto 3 do
	GSetPen(nil, i + 1);
	GRectanglePixels(nil, width, height, false);
	GRMovePixels(nil, 1, 1);
	width := width - 2;
	height := height - 2;
    od;
    xOffset := xOffset + 5;
    GSetPen(nil, C_GOLD);
    GAMovePixels(nil, xOffset + (maxChars - len1) * 4, yOffset + 11);
    GText(nil, s1);
    if s2 ~= "" then
	GAMovePixels(nil, xOffset + (maxChars - len2) * 4, yOffset + 20);
	GText(nil, s2);
	if s3 ~= "" then
	    GAMovePixels(nil, xOffset + (maxChars - len3) * 4, yOffset + 29);
	    GText(nil, s3);
	fi;
    fi;
corp;


define tp_graphics GOLD_UP_ARROW_ID NextEffectId()$
define tp_graphics GOLD_DOWN_ARROW_ID NextEffectId()$

/*
 * DrawUpArrow - draw the up arrow.
 */

define t_graphics proc public DrawUpArrow(int pen)void:

    if pen = C_GOLD then
	if not KnowsEffect(nil, GOLD_UP_ARROW_ID) then
	    DefineEffect(nil, GOLD_UP_ARROW_ID);
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 0.26874, 0.45);
	    GRDraw(nil, 0.01563, -0.05);
	    GRDraw(nil, 0.01563, 0.05);
	    GRMove(nil, -0.01563, -0.05);
	    GRDraw(nil, 0.0, 0.2);
	    EndEffect();
	fi;
	CallEffect(nil, GOLD_UP_ARROW_ID);
    else
	GSetPen(nil, pen);
	GAMove(nil, 0.26874, 0.45);
	GRDraw(nil, 0.01563, -0.05);
	GRDraw(nil, 0.01563, 0.05);
	GRMove(nil, -0.01563, -0.05);
	GRDraw(nil, 0.0, 0.20);
    fi;
corp;

/*
 * DrawDownArrow - draw the down arrow.
 */

define t_graphics proc public DrawDownArrow(int pen)void:

    if pen = C_GOLD then
	if not KnowsEffect(nil, GOLD_DOWN_ARROW_ID) then
	    DefineEffect(nil, GOLD_DOWN_ARROW_ID);
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 0.2, 0.55);
	    GRDraw(nil, 0.01563, 0.05);
	    GRDraw(nil, 0.01563, -0.05);
	    GRMove(nil, -0.01563, 0.05);
	    GRDraw(nil, 0.0, -0.2);
	    EndEffect();
	fi;
	CallEffect(nil, GOLD_DOWN_ARROW_ID);
    else
	GSetPen(nil, pen);
	GAMove(nil, 0.2, 0.55);
	GRDraw(nil, 0.01563, 0.05);
	GRDraw(nil, 0.01563, -0.05);
	GRMove(nil, -0.01563, 0.05);
	GRDraw(nil, 0.0, -0.2);
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.25, 0.5);
    GEllipse(nil, 0.04688, 0.12, true);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GAMove(nil, 0.20313, 0.0);
	    GRectangle(nil, 0.09375, 0.5, true);
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.16);
	    GADraw(nil, 0.28, 0.595);
	    GADraw(nil, 0.22, 0.425);
	    GADraw(nil, 0.43, 0.0);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GAMove(nil, 0.25, 0.39);
	    GRectangle(nil, 0.25, 0.24, true);
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.999);
	    GADraw(nil, 0.499, 0.83);
	    GADraw(nil, 0.276, 0.405);
	    GADraw(nil, 0.226, 0.6);
	    GADraw(nil, 0.43, 0.999);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GAMove(nil, 0.20313, 0.5);
	    GRectangle(nil, 0.09375, 0.499, true);
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.999);
	    GADraw(nil, 0.067, 0.999);
	    GADraw(nil, 0.285, 0.58);
	    GADraw(nil, 0.232, 0.405);
	    GADraw(nil, 0.0, 0.83);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GAMove(nil, 0.0, 0.39);
	    GRectangle(nil, 0.25, 0.24, true);
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.0);
	    GADraw(nil, 0.075, 0.0);
	    GADraw(nil, 0.276, 0.405);
	    GADraw(nil, 0.226, 0.6);
	    GADraw(nil, 0.0, 0.16);
	    GPolygonEnd(nil);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.252, 0.499);
    GEllipse(nil, 0.01563, 0.05, true);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GAMove(nil, 0.2376, 0.0);
	    GRectangle(nil, 0.029, 0.5, true);
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.05);
	    GADraw(nil, 0.257, 0.536);
	    GADraw(nil, 0.24, 0.475);
	    GADraw(nil, 0.475, 0.0);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GAMove(nil, 0.25, 0.455);
	    GRectangle(nil, 0.25, 0.095, true);
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.999);
	    GADraw(nil, 0.499, 0.94);
	    GADraw(nil, 0.26, 0.465);
	    GADraw(nil, 0.24, 0.52);
	    GADraw(nil, 0.475, 0.999);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GAMove(nil, 0.2376, 0.5);
	    GRectangle(nil, 0.029, 0.5, true);
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.999);
	    GADraw(nil, 0.022, 0.999);
	    GADraw(nil, 0.261, 0.53);
	    GADraw(nil, 0.244, 0.465);
	    GADraw(nil, 0.0, 0.94);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GAMove(nil, 0.0, 0.455);
	    GRectangle(nil, 0.252, 0.095, true);
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.0);
	    GADraw(nil, 0.022, 0.0);
	    GADraw(nil, 0.26, 0.465);
	    GADraw(nil, 0.24, 0.525);
	    GADraw(nil, 0.0, 0.05);
	    GPolygonEnd(nil);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.25, 0.497);
    GEllipse(nil, 0.04375, 0.08, true);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GAMove(nil, 0.207, 0.0);
	    GRectangle(nil, 0.087, 0.5, true);
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.13);
	    GADraw(nil, 0.267, 0.575);
	    GADraw(nil, 0.22, 0.454);
	    GADraw(nil, 0.445, 0.0);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GAMove(nil, 0.25, 0.425);
	    GRectangle(nil, 0.25, 0.155, true);
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.999);
	    GADraw(nil, 0.499, 0.86);
	    GADraw(nil, 0.276, 0.44);
	    GADraw(nil, 0.226, 0.56);
	    GADraw(nil, 0.445, 0.999);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GAMove(nil, 0.207, 0.5);
	    GRectangle(nil, 0.087, 0.5, true);
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.999);
	    GADraw(nil, 0.043, 0.999);
	    GADraw(nil, 0.276, 0.56);
	    GADraw(nil, 0.227, 0.435);
	    GADraw(nil, 0.0, 0.86);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GAMove(nil, 0.0, 0.425);
	    GRectangle(nil, 0.25, 0.155, true);
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.0);
	    GADraw(nil, 0.043, 0.0);
	    GADraw(nil, 0.276, 0.435);
	    GADraw(nil, 0.228, 0.56);
	    GADraw(nil, 0.0, 0.13);
	    GPolygonEnd(nil);
	fi;
	DrawUpDown(here, exits);
    fi;
corp;

define tp_graphics GREYS_TUNNEL_CHAMBER_ID NextEffectId()$

define tp_graphics proc chamberStrokes(int background, foreground)void:

    GSetPen(nil, background);
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GPolygonStart(nil);
    GAMove(nil, 0.125, 0.2);
    GADraw(nil, 0.373, 0.2);
    GADraw(nil, 0.435, 0.35);
    GADraw(nil, 0.435, 0.65);
    GADraw(nil, 0.373, 0.8);
    GADraw(nil, 0.125, 0.8);
    GADraw(nil, 0.062,0.65);
    GADraw(nil, 0.062, 0.35);
    GPolygonEnd(nil);
corp;

/*
 * DrawTunnelChamber - draw the non-exit part of a tunnel chamber.
 */

define t_graphics proc public DrawTunnelChamber(int background,foreground)void:

    if background = C_DARK_GREY and foreground = C_LIGHT_GREY then
	if not KnowsEffect(nil, GREYS_TUNNEL_CHAMBER_ID) then
	    DefineEffect(nil, GREYS_TUNNEL_CHAMBER_ID);
	    chamberStrokes(C_DARK_GREY, C_LIGHT_GREY);
	    EndEffect();
	fi;
	CallEffect(nil, GREYS_TUNNEL_CHAMBER_ID);
    else
	chamberStrokes(background, foreground);
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
    DrawTunnelChamber(background, foreground);
    exits := here@p_rExits;
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GAMove(nil, 0.20313, 0.0);
	    GRectangle(nil, 0.09063, 0.2, true);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GAMove(nil, 0.20313, 0.79);
	    GRectangle(nil, 0.09063, 0.299, true);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GAMove(nil, 0.4373, 0.42);
	    GRectangle(nil, 0.0645, 0.15, true);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GAMove(nil, 0.0, 0.42);
	    GRectangle(nil, 0.0625, 0.15, true);
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.374, 0.2);
	    GADraw(nil, 0.435, 0.0);
	    GADraw(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.15);
	    GADraw(nil, 0.436, 0.35);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.374, 0.8);
	    GADraw(nil, 0.436, 0.999);
	    GADraw(nil, 0.499, 0.999);
	    GADraw(nil, 0.499, 0.84);
	    GADraw(nil, 0.436, 0.64);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.125, 0.2);
	    GADraw(nil, 0.065, 0.0);
	    GADraw(nil, 0.0, 0.0);
	    GADraw(nil, 0.0, 0.15);
	    GADraw(nil, 0.063, 0.35);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.125, 0.8);
	    GADraw(nil, 0.063, 0.999);
	    GADraw(nil, 0.0, 0.999);
	    GADraw(nil, 0.0, 0.84);
	    GADraw(nil, 0.063, 0.64);
	    GPolygonEnd(nil);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, background);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) = -1 then
	    GAMove(nil, 0.125, 0.0);
	    GRectangle(nil, 0.25, 0.19, true);
	fi;
	if FindElement(exits, D_NORTHEAST) = -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.373, 0.0);
	    GADraw(nil, 0.499, 0.0);
	    GADraw(nil, 0.499, 0.295);
	    GADraw(nil, 0.439, 0.295);
	    GADraw(nil, 0.439, 0.19);
	    GADraw(nil, 0.373, 0.19);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_EAST) = -1 then
	    GAMove(nil, 0.438, 0.3);
	    GRectangle(nil, 0.062, 0.39, true);
	fi;
	if FindElement(exits, D_SOUTHEAST) = -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.499, 0.69);
	    GADraw(nil, 0.499, 0.999);
	    GADraw(nil, 0.376, 0.999);
	    GADraw(nil, 0.376, 0.8);
	    GADraw(nil, 0.439, 0.8);
	    GADraw(nil, 0.439, 0.69);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_SOUTH) = -1 then
	    GAMove(nil, 0.125, 0.8);
	    GRectangle(nil, 0.25, 0.21, true);
	fi;
	if FindElement(exits, D_SOUTHWEST) = -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.69);
	    GADraw(nil, 0.0, 0.999);
	    GADraw(nil, 0.125, 0.999);
	    GADraw(nil, 0.125, 0.8);
	    GADraw(nil, 0.059, 0.8);
	    GADraw(nil, 0.059, 0.69);
	    GPolygonEnd(nil);
	fi;
	if FindElement(exits, D_WEST) = -1 then
	    GAMove(nil, 0.0, 0.3);
	    GRectangle(nil, 0.05938, 0.39, true);
	fi;
	if FindElement(exits, D_NORTHWEST) = -1 then
	    GPolygonStart(nil);
	    GAMove(nil, 0.0, 0.295);
	    GADraw(nil, 0.0, 0.0);
	    GADraw(nil, 0.125, 0.0);
	    GADraw(nil, 0.125, 0.19);
	    GADraw(nil, 0.059, 0.19);
	    GADraw(nil, 0.059, 0.295);
	    GPolygonEnd(nil);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.059, 0.2);
    GRectangle(nil, 0.38, 0.616, true);
    GSetPen(nil, edge);
    GAMove(nil, 0.059, 0.2);
    GRectangle(nil, 0.38, 0.616, false);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.206, 0.0);
	    GRectangle(nil, 0.084, 0.2, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.206, 0.0);
	    GADraw(nil, 0.206, 0.2);
	    GAMove(nil, 0.289, 0.0);
	    GADraw(nil, 0.289, 0.2);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.206, 0.805);
	    GRectangle(nil, 0.084, 0.205, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.206, 0.806);
	    GADraw(nil, 0.206, 0.999);
	    GAMove(nil, 0.289, 0.806);
	    GADraw(nil, 0.289, 0.999);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.435, 0.4);
	    GRectangle(nil, 0.065, 0.2, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.436, 0.4);
	    GADraw(nil, 0.499, 0.4);
	    GAMove(nil, 0.436, 0.6);
	    GADraw(nil, 0.499, 0.6);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.0, 0.4);
	    GRectangle(nil, 0.059, 0.2, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.0, 0.4);
	    GADraw(nil, 0.059, 0.4);
	    GAMove(nil, 0.0, 0.6);
	    GADraw(nil, 0.059, 0.6);
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.39, 0.0);
	    GRectangle(nil, 0.111, 0.27, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.39, 0.0);
	    GADraw(nil, 0.39, 0.2);
	    GAMove(nil, 0.437, 0.275);
	    GADraw(nil, 0.499, 0.275);
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.118, 0.27, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.118, 0.0);
	    GADraw(nil, 0.118, 0.2);
	    GAMove(nil, 0.0, 0.275);
	    GADraw(nil, 0.059, 0.275);
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.39, 0.74);
	    GRectangle(nil, 0.111, 0.27, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.39, 0.806);
	    GADraw(nil, 0.39, 0.999);
	    GAMove(nil, 0.437, 0.735);
	    GADraw(nil, 0.499, 0.735);
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.0, 0.74);
	    GRectangle(nil, 0.118, 0.27, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.118, 0.806);
	    GADraw(nil, 0.118, 0.999);
	    GAMove(nil, 0.0, 0.735);
	    GADraw(nil, 0.059, 0.735);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.21, 0.41);
    GRectangle(nil, 0.084, 0.195, true);
    GSetPen(nil, edge);
    GAMove(nil, 0.21, 0.41);
    GRectangle(nil, 0.084, 0.197, false);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.21, 0.0);
	    GRectangle(nil, 0.0837, 0.41, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.21, 0.0);
	    GADraw(nil, 0.21, 0.41);
	    GAMove(nil, 0.293, 0.0);
	    GADraw(nil, 0.293, 0.41);
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.21, 0.59);
	    GRectangle(nil, 0.0837, 0.42, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.21, 0.59);
	    GADraw(nil, 0.21, 0.999);
	    GAMove(nil, 0.293, 0.59);
	    GADraw(nil, 0.293, 0.999);
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.293, 0.41);
	    GRectangle(nil, 0.208, 0.195, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.293, 0.41);
	    GADraw(nil, 0.499, 0.41);
	    GAMove(nil, 0.293, 0.596);
	    GADraw(nil, 0.499, 0.596);
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GSetPen(nil, foreground);
	    GAMove(nil, 0.0, 0.41);
	    GRectangle(nil, 0.211, 0.195, true);
	    GSetPen(nil, edge);
	    GAMove(nil, 0.0, 0.41);
	    GADraw(nil, 0.21, 0.41);
	    GAMove(nil, 0.0, 0.596);
	    GADraw(nil, 0.21, 0.596);
	fi;
	DrawUpDown(here, exits);
    fi;
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
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    GSetPen(nil, foreground);
    GAMove(nil, 0.059, 0.2);
    GRectangle(nil, 0.38, 0.606, true);
    GSetPen(nil, edge);
    GAMove(nil, 0.059, 0.2);
    GRectangle(nil, 0.38, 0.606, false);
    GSetPen(nil, door);
    if exits ~= nil then
	if FindElement(exits, D_NORTH) ~= -1 then
	    GAMove(nil, 0.235, 0.2);
	    HorizontalDoor();
	fi;
	if FindElement(exits, D_SOUTH) ~= -1 then
	    GAMove(nil, 0.235, 0.8);
	    HorizontalDoor();
	fi;
	if FindElement(exits, D_EAST) ~= -1 then
	    GAMove(nil, 0.436, 0.46);
	    VerticalDoor();
	fi;
	if FindElement(exits, D_WEST) ~= -1 then
	    GAMove(nil, 0.059, 0.46);
	    VerticalDoor();
	fi;
	if FindElement(exits, D_NORTHEAST) ~= -1 then
	    GSetPen(nil, background);
	    GPolygonStart(nil);
	    GAMove(nil, 0.42, 0.19);
	    GADraw(nil, 0.436, 0.19);
	    GADraw(nil, 0.436, 0.24);
	    GPolygonEnd(nil);
	    GSetPen(nil, door);
	    GAMove(nil, 0.422, 0.2);
	    NorthEastDoor();
	fi;
	if FindElement(exits, D_NORTHWEST) ~= -1 then
	    GSetPen(nil, background);
	    GPolygonStart(nil);
	    GAMove(nil, 0.0735, 0.19);
	    GADraw(nil, 0.059, 0.19);
	    GADraw(nil, 0.059, 0.24);
	    GPolygonEnd(nil);
	    GSetPen(nil, door);
	    GAMove(nil, 0.072, 0.2);
	    NorthWestDoor();
	fi;
	if FindElement(exits, D_SOUTHEAST) ~= -1 then
	    GSetPen(nil, background);
	    GPolygonStart(nil);
	    GAMove(nil, 0.42, 0.81);
	    GADraw(nil, 0.436, 0.81);
	    GADraw(nil, 0.436, 0.76);
	    GPolygonEnd(nil);
	    GSetPen(nil, door);
	    GAMove(nil, 0.435, 0.76);
	    NorthWestDoor();
	fi;
	if FindElement(exits, D_SOUTHWEST) ~= -1 then
	    GSetPen(nil, background);
	    GPolygonStart(nil);
	    GAMove(nil, 0.0735, 0.81);
	    GADraw(nil, 0.059, 0.81);
	    GADraw(nil, 0.059, 0.76);
	    GPolygonEnd(nil);
	    GSetPen(nil, door);
	    GAMove(nil, 0.059, 0.76);
	    NorthEastDoor();
	fi;
	DrawUpDown(here, exits);
    fi;
corp;

unuse tp_graphics
