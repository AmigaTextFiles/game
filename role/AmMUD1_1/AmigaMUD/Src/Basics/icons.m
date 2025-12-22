/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * icons.m - code for dealing with icons.
 */

private tp_icons CreateTable()$
use tp_icons

/*
 * ShowIcon - show this machine's icon to anyone here.
 */

define t_icons proc utility public ShowIconOnce(thing th)void:
    thing me;

    if GOn(th) then
	me := Me();
	GShowIcon(th, me, not me@p_pStandard, Parent(me) ~= nil);
    fi;
corp;

define t_icons proc utility public ShowIcon()void:

    ForEachAgent(Here(), ShowIconOnce);
corp;

/*
 * DoShowIcon - handy for ForceAction on an arriving entity.
 */

define t_icons proc utility public DoShowIcon()status:

    ShowIcon();
    continue
corp;

/*
 * UnShowIcon - remove my icon from anyone else here.
 */

define t_icons proc utility UnShowIconOnce(thing th)void:
    thing me;

    if GOn(th) then
	me := Me();
	if (me@p_pIcon ~= nil or me@p_pStandard) and Parent(me) = nil then
	    /* If the player or machine has a specific icon, or this is a
	       player or a "standard" machine (Packrat, etc.), and this is
	       not a cloned entity, then we just tell the client to undisplay
	       the icon, but to remember it for later use. */
	    GRemoveIcon(th, me);
	else
	    /* Otherwise, we tell the client to undisplay the icon, but also
	       to forget it, since the thing associated with it may be reused
	       later for something with a different icon. */
	    GDeleteIcon(th, me);
	fi;
    fi;
corp;

define t_icons proc utility public UnShowIcon()void:

    ForEachAgent(Here(), UnShowIconOnce);
corp;

/*
 * DoUnShowIcon - handy for ForceAction on a leaving entity.
 */

define t_icons proc utility public DoUnShowIcon()status:

    UnShowIcon();
    continue
corp;

/*
 * PrintIcon - print an icon in binary form.
 */

define t_icons proc PrintIcon(list int icon)void:
    int i, bits, j;

    Print("define t_icons proc makeXXXIcon()list int:\n");
    Print("    list int li;\n\n");
    Print("    li := CreateIntArray(8);\n");
    for i from 0 upto 7 do
	Print("    li[" + IntToString(i) + "] := 0b");
	bits := icon[i];
	for j from 0 upto 31 do
	    if bits < 0 then
		Print("1");
	    else
		Print("0");
	    fi;
	    bits := bits << 1;
	od;
	Print(";\n");
    od;
    Print("corp;\n");
corp;

/*
 * some specific icons
 */

define t_icons proc makeCaretakerIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000001100000000000;
    icon[1] := 0b00011000000000000000110000000000;
    icon[2] := 0b00001100000000000000011000000000;
    icon[3] := 0b00000110000000000000001100000000;
    icon[4] := 0b00000011000000000000000110000000;
    icon[5] := 0b00000001111000000000001111100000;
    icon[6] := 0b00000011111100000000000111110000;
    icon[7] := 0b00000001100000000000000000000000;
    icon
corp;

define t_icons proc makePackratIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000000000000000;
    icon[1] := 0b00000000000000000000000100000000;
    icon[2] := 0b00000010100000000001101011100000;
    icon[3] := 0b00100111100100000001111111100000;
    icon[4] := 0b00000111010000000000110110100000;
    icon[5] := 0b00010101011000000010001000000000;
    icon[6] := 0b00100000000000000100000000000000;
    icon[7] := 0b01000000000000000000000000000000;
    icon
corp;

define t_icons proc makePostmanIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000000000000000;
    icon[1] := 0b00000000000000000000000000000000;
    icon[2] := 0b01111111111111100111000000001110;
    icon[3] := 0b01001100001100100100001111000010;
    icon[4] := 0b01000000000000100111111111111110;
    icon[5] := 0b00000000000000000000000000000000;
    icon[6] := 0b00000000000000000000000000000000;
    icon[7] := 0b00000000000000000000000000000000;
    icon
corp;

define t_icons proc makeQuestorIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000000000000000;
    icon[1] := 0b00000111111000000001100000011000;
    icon[2] := 0b00100000000001000100000000000010;
    icon[3] := 0b01000000000000100100000000000010;
    icon[4] := 0b01000000000000100100100000000010;
    icon[5] := 0b01000110000000100010000110000100;
    icon[6] := 0b00011000010110000000011111100000;
    icon[7] := 0b00000000000111000000000000000011;
    icon
corp;

define t_icons proc makeMerlinIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000000000000000;
    icon[1] := 0b00000001111110000000001000000100;
    icon[2] := 0b00000100001110100000010000100110;
    icon[3] := 0b00001000000100000000100000010000;
    icon[4] := 0b00010010010010000001000110001000;
    icon[5] := 0b00100111111001000010000110000100;
    icon[6] := 0b01000010010000100100000000000010;
    icon[7] := 0b00111111111111000000000000000000;
    icon
corp;

define t_icons proc makeWandererIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000011111100000;
    icon[1] := 0b00001000000100000001000000001000;
    icon[2] := 0b00100011110001000100010000100010;
    icon[3] := 0b01001000000100100100100110010010;
    icon[4] := 0b01001001100100100100100000010010;
    icon[5] := 0b01000100001000100010001111000100;
    icon[6] := 0b00010000000010000000100000010000;
    icon[7] := 0b00000111111000000000000000000000;
    icon
corp;

/* The icons from here on are absolutely laughable! */

define t_icons proc makeBirdIcon()list int:
    list int icon;

    icon := CreateIntArray(8);
    icon[0] := 0b00000000000000000000011110000000;
    icon[1] := 0b00011111110000000011111111100000;
    icon[2] := 0b00111111111000000111111011111000;
    icon[3] := 0b01111110011111100111111111110000;
    icon[4] := 0b01111111111111100111111111110000;
    icon[5] := 0b00111111111000000011111111000000;
    icon[6] := 0b00011111110000000000011110000000;
    icon[7] := 0b00000000000000000000000000000000;
    icon
corp;

define t_icons proc makeRockPileIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000000000000000000;
    li[2] := 0b00000000000000000000000000000000;
    li[3] := 0b00000000000000000000110001110000;
    li[4] := 0b00010010100010000001101110000100;
    li[5] := 0b00110100101101000010100001001100;
    li[6] := 0b01001011010100100100110010001010;
    li[7] := 0b00110011011101000000000000000000;
    li
corp;

define t_icons proc makeSnakeIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000000000000000000;
    li[2] := 0b00110000000001100111100000011111;
    li[3] := 0b11001100001101001000010000100010;
    li[4] := 0b10000110001000001100011000110000;
    li[5] := 0b01100011000100000000000110110000;
    li[6] := 0b00000000111000000000000000000000;
    li[7] := 0b00000000000000000000000000000000;
    li
corp;

define t_icons proc makeDeerIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000000000000000000;
    li[2] := 0b00000000000000000000000000000000;
    li[3] := 0b00000000000010000000010000011100;
    li[4] := 0b00000011111110000000011111110000;
    li[5] := 0b00000111111000000000010000100000;
    li[6] := 0b00000010001000000000001000010000;
    li[7] := 0b00000000000000000000000000000000;
    li
corp;

define t_icons proc makeRatIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000000011110000000;
    li[2] := 0b00001111111000000011111111110000;
    li[3] := 0b01111111111110000101111111110100;
    li[4] := 0b10011011110111101000100001001000;
    li[5] := 0b10010000001000000100000001000000;
    li[6] := 0b01100000000000000001110000000000;
    li[7] := 0b00000011000000000000000000000000;
    li
corp;

define t_icons proc makeDogIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000000000000000000;
    li[2] := 0b00000010000000000000011000000000;
    li[3] := 0b00000111000000000000110110000000;
    li[4] := 0b00011110111000000011111111110000;
    li[5] := 0b01111111111100001111111001000000;
    li[6] := 0b11111100001000001111110000000000;
    li[7] := 0b11111100000000001111110000000000;
    li
corp;

define t_icons proc makeGremlinIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000001111100000;
    li[1] := 0b00000111111100000000111000111000;
    li[2] := 0b00001100000110000001100000000000;
    li[3] := 0b00011000000000000001100000111100;
    li[4] := 0b00011000001111000001110000011000;
    li[5] := 0b00001110000110000000011111111000;
    li[6] := 0b00000011111100000000000000000000;
    li[7] := 0b00000000000000000000000000000000;
    li
corp;

define t_icons proc makeBearIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000110000000;
    li[1] := 0b00000011011000000001001111100000;
    li[2] := 0b00011001110000000001100110001100;
    li[3] := 0b00001111110110000000011111110000;
    li[4] := 0b00000111111000000000011111100000;
    li[5] := 0b00000011111000000000001111000000;
    li[6] := 0b00000011110000000000011001000000;
    li[7] := 0b00000100001000000000010000100000;
    li
corp;

define t_icons proc makeMooseIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000010010100000000001001010;
    li[1] := 0b00000010110001110000011100100100;
    li[2] := 0b00000000001011000000000111010000;
    li[3] := 0b00000000100100000000000001111100;
    li[4] := 0b00000011111111100000011111111011;
    li[5] := 0b00001111111111110001111111100110;
    li[6] := 0b01111111100000001111111100000000;
    li[7] := 0b11111111000000001111111000000000;
    li
corp;

define t_icons proc makeTrollIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000000000000000000;
    li[1] := 0b00000000000000000011111111110000;
    li[2] := 0b00111111111100000011001100110000;
    li[3] := 0b00000011000000000000001100000000;
    li[4] := 0b00000011000000000000001100000000;
    li[5] := 0b00000011000000000000001100000000;
    li[6] := 0b00000111100000000000011110000000;
    li[7] := 0b00000000000000000000000000000000;
    li
corp;

define t_icons proc makeWolfIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00001000000000000001100000000000;
    li[1] := 0b00011000000000000011110000000000;
    li[2] := 0b00111010000000000111100100000110;
    li[3] := 0b11111001100111111111111111111111;
    li[4] := 0b11111111111111111111111111100101;
    li[5] := 0b11111111111100001111111111110101;
    li[6] := 0b11111111111111111111100000001111;
    li[7] := 0b11110000000000001110000000000000;
    li
corp;

define t_icons proc makeGoblinIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000111110000000000111111100000;
    li[1] := 0b00001110011100000001110000110000;
    li[2] := 0b00011100001100000011100000000000;
    li[3] := 0b00111000000000000011100000000000;
    li[4] := 0b00111000000000000011100000000000;
    li[5] := 0b00111000011110000001100001111000;
    li[6] := 0b00011100001100000000110000110000;
    li[7] := 0b00001111111000000000011111000000;
    li
corp;

define t_icons proc makeSpiderIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000100100010010000;
    li[1] := 0b01001000100100000100100010010000;
    li[2] := 0b00100101001000000001111111100100;
    li[3] := 0b00111011011111100011110110111100;
    li[4] := 0b00111101101111000011101101111110;
    li[5] := 0b00011111111001000010010100100000;
    li[6] := 0b01001000100100000100100010010000;
    li[7] := 0b01001000100100000000000000000000;
    li
corp;

define t_icons proc makeTSpiderIcon()list int:
    list int li;

    li := CreateIntArray(8);
    li[0] := 0b00000000000000000100100010010000;
    li[1] := 0b01001000100100000100100010010000;
    li[2] := 0b00100101001000000001111011100100;
    li[3] := 0b00110011011111100011100010111100;
    li[4] := 0b00110011011111000011111011111110;
    li[5] := 0b00011111111001000010010100100000;
    li[6] := 0b01001000100100000100100010010000;
    li[7] := 0b01001000100100000000000000000000;
    li
corp;


/* routines for the icon editor */

define tp_icons EDIT_DONE_BUTTON     14$
define tp_icons EDIT_CANCEL_BUTTON   15$
define tp_icons EDIT_CLEAR_BUTTON    16$
define tp_icons EDIT_REGION	     2$

define tp_icons p_pEIRestoreAction CreateActionProp()$
define tp_icons p_pEIEditIcon CreateIntListProp()$
define tp_icons p_pEISaveButtonAction CreateActionProp()$
define tp_icons p_pEISaveMouseAction CreateActionProp()$
define tp_icons p_pEIIsCursor CreateBoolProp()$

define tp_icons proc showIconPixel(int x, y)void:
    int rows, cols, xScale, yScale, xOffset, yOffset;
    int n;

    rows := GRows(nil);
    cols := GCols(nil);
    xScale := (cols / 2 - 30) / 16;
    yScale := (rows - 8) / 16;
    xOffset := (cols / 2 - 30 - 16 * xScale) / 2;
    yOffset := (rows - 8 - 16 * yScale) / 2;

    n := y * 16 + x;
    if (Me()@p_pEIEditIcon[n >> 5] >> (31 - n & 0x1f)) & 1 ~= 0 then
	GSetPen(nil, C_WHITE);
    else
	GSetPen(nil, C_BLACK);
    fi;
    GAMovePixels(nil, xOffset + x * xScale + 4, yOffset + y * yScale + 4);
    GRectanglePixels(nil, xScale, yScale, true);
    GAMovePixels(nil, cols / 2 - 20 + x, rows - 20 + y);
    GPixel(nil);
corp;

define tp_icons proc showWholeIcon()void:
    int x, y;

    for x from 0 upto 15 do
	for y from 0 upto 15 do
	    showIconPixel(x, y);
	od;
    od;
corp;

define tp_icons proc iconEditMouseHandler(int n, x, y)void:

    if n = EDIT_REGION then
	x := x / ((GCols(nil) / 2 - 30) / 16);
	y := y / ((GRows(nil) - 8) / 16);
	n := y * 16 + x;
	Me()@p_pEIEditIcon[n >> 5] := Me()@p_pEIEditIcon[n >> 5] ><
	    (1 << (31 - n & 0x1f));
	GUndrawIcons(nil);
	showIconPixel(x, y);
	GRedrawIcons(nil);
    fi;
    /* do not complain about other regions hit - MOVE_REGION is all around
       EDIT_REGION, and we just want to ignore hits there. */
corp;

define tp_icons proc iconEditReset()void: corp;

define tp_icons proc iconEditActiveAction()void:

    Print("\n* You were editing your icon or cursor when a backup was "
	  "made. The system is now running from that backup. Your edit "
	  "changes have been lost. *\n\n");
    iconEditReset();
corp;

replace iconEditReset()void:
    thing me;

    me := Me();
    DelElement(me@p_pEnterActions, iconEditActiveAction);
    DelElement(me@p_pExitActions, iconEditReset);
    me -- p_pEIIsCursor;
    me -- p_pEIEditIcon;
    ignore SetCharacterButtonAction(me@p_pEISaveButtonAction);
    me -- p_pEISaveButtonAction;
    ignore SetCharacterMouseDownAction(me@p_pEISaveMouseAction);
    me -- p_pEISaveMouseAction;
    me -- p_pEIRestoreAction;
corp;

define t_icons proc EndIconEdit()void:
    action a;

    a := Me()@p_pEIRestoreAction;
    iconEditReset();
    EraseButton(EDIT_DONE_BUTTON);
    EraseButton(EDIT_CANCEL_BUTTON);
    EraseButton(EDIT_CLEAR_BUTTON);
    EraseRegion(EDIT_REGION);
    GUndrawIcons(nil);
    GSetPen(nil, C_BLACK);
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.5, 1.0, true);
    if a ~= nil then
	call(a, void)();
    fi;
    GRedrawIcons(nil);
corp;

define tp_icons proc iconEditButtonHandler(int whichButton)void:
    thing me;
    int i;
    list int icon;

    me := Me();
    case whichButton
    incase EDIT_CLEAR_BUTTON:
	icon := me@p_pEIEditIcon;
	for i from 0 upto 7 do
	    icon[i] := 0b0;
	od;
	GUndrawIcons(nil);
	showWholeIcon();
	GRedrawIcons(nil);
    incase EDIT_DONE_BUTTON:
	if me@p_pEIIsCursor then
	    me@p_pCursor := me@p_pEIEditIcon;
	    SetCursorPattern(me@p_pCursor);
	else
	    GNewIcon(me, me@p_pEIEditIcon);
	fi;
	EndIconEdit();
    incase EDIT_CANCEL_BUTTON:
	EndIconEdit();
    default:
	call(me@p_pEISaveButtonAction, void)(whichButton);
    esac;
corp;

define tp_icons proc copyIcon(list int old)list int:
    list int new;
    int i;

    new := CreateIntArray(8);
    for i from 0 upto 7 do
	new[i] := old[i];
    od;
    new
corp;

define tp_icons EDIT_BOX_ID NextEffectId()$

define tp_icons proc startEdit()void:
    thing me;
    action a;
    int i;
    int rows, cols, xBase, yBase, xScale, yScale, xOffset, yOffset;

    me := Me();
    if Character(me@p_pName) ~= nil then
	/* Keep NPC's out of this. */
	a := SetCharacterButtonAction(iconEditButtonHandler);
	if a ~= nil then
	    me@p_pEISaveButtonAction := a;
	fi;
	a := SetCharacterMouseDownAction(iconEditMouseHandler);
	if a ~= nil then
	    me@p_pEISaveMouseAction := a;
	fi;
	AddHead(me@p_pEnterActions, iconEditActiveAction);
	AddHead(me@p_pExitActions, iconEditReset);

	if not KnowsEffect(nil, EDIT_BOX_ID) then
	    rows := GRows(nil);
	    cols := GCols(nil);
	    xBase := cols * 3 / 4;
	    yBase := rows / 2;
	    xScale := (cols / 2 - 30) / 16;
	    yScale := (rows - 8) / 16;
	    xOffset := (cols / 2 - 30 - 16 * xScale) / 2;
	    yOffset := (rows - 8 - 16 * yScale) / 2;

	    DefineEffect(nil, EDIT_BOX_ID);
	    AddButtonPixels(xBase - 76, yBase + 33, EDIT_DONE_BUTTON, "Done");
	    AddButtonPixels(xBase - 32, yBase + 33,
		EDIT_CANCEL_BUTTON, "Cancel");
	    AddButtonPixels(xBase + 28, yBase + 33, EDIT_CLEAR_BUTTON,"Clear");
	    AddRegionPixels(xOffset + 4, yOffset + 4,
			    xScale * 16, yScale * 16,
			    EDIT_REGION);
	    GUndrawIcons(nil);
	    RemoveCursor();
	    ClearGraphics();
	    for i from 0 upto 3 do
		GSetPen(nil, i + 1);
		GAMovePixels(nil, xOffset + i, yOffset + i);
		GRectanglePixels(nil, xScale * 16 + 8 - 2 * i,
				      yScale * 16 + 8 - 2 * i, false);
	    od;
	    EndEffect();
	fi;
	CallEffect(nil, EDIT_BOX_ID);
	showWholeIcon();
	GRedrawIcons(nil);
    fi;
corp;

define t_icons proc public StartIconEdit(action restoreAction)void:
    list int icon;
    thing me;

    me := Me();
    if restoreAction ~= nil then
	me@p_pEIRestoreAction := restoreAction;
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
    me@p_pEIEditIcon := icon;
    me@p_pEIIsCursor := false;
    startEdit();
corp;

define t_icons proc public StartCursorEdit(action restoreAction)void:
    thing me;

    me := Me();
    if restoreAction ~= nil then
	me@p_pEIRestoreAction := restoreAction;
    fi;
    me@p_pEIEditIcon := copyIcon(me@p_pCursor);
    me@p_pEIIsCursor := true;
    startEdit();
corp;

unuse tp_icons
