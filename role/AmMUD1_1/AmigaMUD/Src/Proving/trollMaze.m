/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * trollMaze.m - the 3D maze area
 */

define tp_proving tp_trollMaze CreateTable()$
use tp_trollMaze

define tp_trollMaze p_pHasShovel CreateBoolProp()$
define tp_trollMaze p_pMazeX CreateIntProp()$
define tp_trollMaze p_pMazeY CreateIntProp()$
define tp_trollMaze p_pMazeZ CreateIntProp()$
define tp_trollMaze MAZE_MAX_X 15$
define tp_trollMaze MAZE_MAX_Y 9$
define tp_trollMaze MAZE_MAX_Z 9$
define tp_trollMaze MAZE_ENTER_X 8$
define tp_trollMaze MAZE_ENTER_Y 9$
define tp_trollMaze MAZE_ENTER_Z 5$
define tp_trollMaze MAZE_GOAL_X  11$
define tp_trollMaze MAZE_GOAL_Y  3$
define tp_trollMaze MAZE_GOAL_Z  5$
define tp_trollMaze p_rLayerList CreateThingListProp()$
define tp_trollMaze p_rLayer CreateIntListProp()$
define tp_trollMaze MAZE_OPEN	 0b00$
define tp_trollMaze MAZE_NORMAL  0b01$
define tp_trollMaze MAZE_BLOCK	 0b10$
define tp_trollMaze p_oCurrentUser CreateThingProp()$

define tp_trollMaze r_shovelChamber CreateThing(r_provingCave)$
SetupRoomDP(r_shovelChamber, "in a small chamber", "")$
AutoGraphics(r_shovelChamber, AutoOpenRoom)$
Connect(r_doorsExit, r_shovelChamber, D_NORTH)$
r_shovelChamber@p_rNoGenerateMonsters := true$
r_shovelChamber@p_Image := "Proving/shovelRoom"$

define tp_trollMaze o_trollShovel CreateThing(nil)$
SetupObject(o_trollShovel, r_shovelChamber,
    "Shovel;Troll,King's.shovel;troll's,troll,king's,king",
    "The shovel is the same size and shape as a normal garden shovel, but it "
    "seems to be made of silver or some other shiny, whitish metal. There is "
    "a faint greenish glow surrounding it.")$

define tp_trollMaze r_trollMaze CreateThing(nil)$
SetupRoomD(r_trollMaze, "", "")$
HConnect(r_shovelChamber, r_trollMaze, D_NORTH)$
Scenery(r_trollMaze, "chasm.rock.cavity")$
r_trollMaze@p_rHintString := "Explore carefully - there is a route!"$

define tp_trollMaze proc mazeDropCheck(thing what)status:
    Print("You can't drop things here.\n");
    fail
corp;
AddRoomDropChecker(r_trollMaze, mazeDropCheck, false)$

define tp_trollMaze o_drawBridge CreateThing(nil)$
FakeObject(o_drawBridge, r_trollMaze,
    "bridge;wooden,draw.drawbridge;wooden.draw-bridge;wooden", "")$
o_drawBridge@p_oState := 0$
define tp_trollMaze proc drawBridgeDesc()string:
    thing me;

    me := Me();
    if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 3 and
	me@p_pMazeX = MAZE_GOAL_X
    then
	"The drawbridge is quite old, but still in good condition. "
	"It is currently " +
	if o_drawBridge@p_oState = 0 then
	    "drawn up on the far side of the chasm."
	else
	    "lowered into position across the chasm."
	fi
    else
	"There is no drawbridge here."
    fi
corp;
o_drawBridge@p_oDescAction := drawBridgeDesc$

define tp_trollMaze proc mazeNotify()void:

    Print("\n* You were in the troll maze when the database was last backed "
	"up. You have been moved out of the maze. *\n\n");
    DelElement(Me()@p_pEnterActions, mazeNotify);
corp;

/* forward declaration */
define tp_trollMaze proc mazeIdle()void: corp;

define tp_trollMaze proc mazeActive(thing shovel)void:
    thing who;

    who := o_trollShovel@p_oCurrentUser;
    if who ~= nil then
	Log("mazeActive moving " + who@p_pName + " out of the troll maze.\n");
	who -- p_pHasShovel;
	AddTail(r_shovelChamber@p_rContents, o_trollShovel);
	o_trollShovel -- p_oCurrentUser;
	o_drawBridge@p_oState := 0;
	SetCharacterLocation(ThingCharacter(who), r_shovelChamber);
	AddTail(who@p_pEnterActions, mazeNotify);
	DelElement(who@p_pExitActions, mazeIdle);
    fi;
corp;

replace mazeIdle()void:
    thing me;

    me := Me();
    me -- p_pHasShovel;
    DelElement(me@p_pExitActions, mazeIdle);
    SetLocation(r_shovelChamber);
    ABPrint(r_shovelChamber, nil, nil, "Clunk!\n");
    AddTail(r_shovelChamber@p_rContents, o_trollShovel);
    o_trollShovel -- p_oCurrentUser;
    o_drawBridge@p_oState := 0;
    ignore RemoveActiveAction(o_trollShovel, mazeActive);
corp;

define tp_trollMaze proc touchShovel()status:
    thing me;
    action a;

    me := Me();
    if Character(me@p_pName) ~= nil then
	Print(
	    "As you touch the shovel, you feel a sharp shock, as of "
	    "electricity. The shock momentarily clouds your mind, but even so "
	    "you look with bewilderment as the shovel seems to melt into your "
	    "hand. When you recover your senses, the shovel is gone, and you "
	    "feel a strong desire to dig. There is a nagging feeling of "
	    "something tugging at your mind, from somewhere to the northeast."
	    "\n");
	OPrint("As " + me@p_pName +
	    " touches the shovel, it seems to cloud or "
	    "blur, and then it is gone.\n");
	me@p_pHasShovel := true;
	DelElement(r_shovelChamber@p_rContents, o_trollShovel);
	AddTail(me@p_pExitActions, mazeIdle);
	RegisterActiveAction(o_trollShovel, mazeActive);
	o_trollShovel@p_oCurrentUser := me;
	succeed
    else
	fail
    fi
corp;
o_trollShovel@p_oTouchChecker := touchShovel$
define tp_trollMaze proc getShovel(thing shovel)status:
    touchShovel()
corp;
o_trollShovel@p_oGetChecker := getShovel$
o_trollShovel@p_Image := "Proving/trollShovel"$

define tp_trollMaze proc leaveShovel()status:
    thing me;

    me := Me();
    if me@p_pHasShovel then
	me -- p_pHasShovel;
	Print("As you leave this chamber, you experience a momentary feeling "
	    "of loss.\n");
	ABPrint(r_shovelChamber, nil, nil, "Clunk!\n");
	AddTail(r_shovelChamber@p_rContents, o_trollShovel);
	DelElement(me@p_pExitActions, mazeIdle);
	o_trollShovel -- p_oCurrentUser;
	o_drawBridge@p_oState := 0;
	ignore RemoveActiveAction(o_trollShovel, mazeActive);
    fi;
    continue
corp;
AddSouthChecker(r_shovelChamber, leaveShovel, false)$

HUniConnect(r_shovelChamber, r_shovelChamber, D_NORTHWEST)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_WEST)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_SOUTHWEST)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_NORTHEAST)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_EAST)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_SOUTHEAST)$
define tp_trollMaze proc shovelNoGo()status:
    if Me()@p_pHasShovel then
	Print("The stone is much too hard for you to walk through!\n");
    else
	Print("You can't go in that direction.\n");
    fi;
    fail
corp;
AddNorthWestChecker(r_shovelChamber, shovelNoGo, false)$
AddWestChecker(r_shovelChamber, shovelNoGo, false)$
AddSouthWestChecker(r_shovelChamber, shovelNoGo, false)$
AddNorthEastChecker(r_shovelChamber, shovelNoGo, false)$
AddEastChecker(r_shovelChamber, shovelNoGo, false)$
AddSouthEastChecker(r_shovelChamber, shovelNoGo, false)$

HUniConnect(r_shovelChamber, r_shovelChamber, D_UP)$
define tp_trollMaze proc shovelUp()status:
    if Me()@p_pHasShovel then
	Print("The ceiling is too high - you cannot go up that way.\n");
    else
	Print("You can't go in that direction.\n");
    fi;
    fail
corp;
AddUpChecker(r_shovelChamber, shovelUp, false)$
HUniConnect(r_shovelChamber, r_shovelChamber, D_DOWN)$
define tp_trollMaze proc shovelDown()status:
    if Me()@p_pHasShovel then
	Print("The stone of the floor is quite hard - you cannot go down that "
	    "way.\n");
    else
	Print("You can't go in that direction.\n");
    fi;
    fail
corp;
AddDownChecker(r_shovelChamber, shovelDown, false)$

define tp_trollMaze proc doShovelDig()void:
    if Me()@p_pHasShovel then
	Print("The stone of the floor is quite hard - you cannot go down that "
	    "way.\n");
    else
	Print("Digging through solid rock is quite difficult.\n");
    fi;
corp;
AddSpecialCommand(r_shovelChamber, "dig,excavate,shovel", doShovelDig)$

define tp_trollMaze o_bridgeSign CreateThing(nil)$
FakeObject(o_bridgeSign, r_trollMaze, "sign", "")$
define tp_trollMaze proc bridgeSignDesc()string:
    thing me;

    me := Me();
    if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 3 and
	me@p_pMazeX = MAZE_GOAL_X
    then
	"You see nothing special about the sign. It reads:\n\n"
	"\tSPEAK THE BOTTOM WORD\n"
    else
	"There is no sign here."
    fi
corp;
o_bridgeSign@p_oDescAction := bridgeSignDesc$
define tp_trollMaze proc bridgeSignRead()string:
    thing me;

    me := Me();
    if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 3 and
	me@p_pMazeX = MAZE_GOAL_X
    then
	"The sign reads:\n\n\tSPEAK THE BOTTOM WORD\n"
    else
	"There is no sign here."
    fi
corp;
o_bridgeSign@p_oReadAction := bridgeSignRead$

define tp_trollMaze proc trollMazeListen(string s)status:
    thing me;
    int xScale, yScale;

    me := Me();
    if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 3 and
	me@p_pMazeX = MAZE_GOAL_X
    then
	SetTail(s);
	while
	    s := GetWord();
	    s ~= ""
	do
	    if s == "LURT" and o_drawBridge@p_oState = 0 then
		o_drawBridge@p_oState := 1;
		Print("With a rumble and a bang, the drawbridge lowers into "
		    "place across the chasm.\n");
		xScale := GCols(nil) / (2 * (MAZE_MAX_X + 1));
		yScale := GRows(nil) / (MAZE_MAX_Y + 1);
		GSetPen(nil, C_BROWN);
		GAMovePixels(nil, MAZE_GOAL_X * xScale + 1,
		    MAZE_GOAL_Y * yScale + 2 * yScale - 1);
		GRectanglePixels(nil, xScale - 2, yScale + 2, true);
	    fi;
	od;
    fi;
    continue
corp;
AddRoomSayChecker(r_trollMaze, trollMazeListen, false)$

define tp_trollMaze proc questHeartDesc()string:
    "Find the heart of the trolls."
corp;
define tp_trollMaze proc questHeartCheck()void:
corp;
define tp_trollMaze proc questHeartHint()string:
    "It lies deep in the rock."
corp;
QuestDirect("Heart", questHeartDesc, questHeartCheck, questHeartHint)$

define tp_trollMaze proc maze(int z, y, x)int:
    if z < 0 or z > MAZE_MAX_Z or
	y < 0 or y > MAZE_MAX_Y or
	x < 0 or x > MAZE_MAX_X
    then
	MAZE_BLOCK
    else
	(r_trollMaze@p_rLayerList[z]@p_rLayer[y] >>
	    ((MAZE_MAX_X - x) * 2)) & 0b11
    fi
corp;

define tp_trollMaze p_rSpaceCount CreateIntProp()$
define tp_trollMaze p_rSpaceVector CreateIntListProp()$
r_trollMaze@p_rSpaceCount := 0$
r_trollMaze@p_rSpaceVector := CreateIntArray(6)$
define tp_trollMaze proc markSpace(int dir)void:
    int count;

    count := r_trollMaze@p_rSpaceCount;
    r_trollMaze@p_rSpaceVector[count] := dir;
    r_trollMaze@p_rSpaceCount := count + 1;
corp;
define tp_trollMaze proc dumpSpaces()bool:
    list int spaces;
    int count, i;

    count := r_trollMaze@p_rSpaceCount;
    spaces := r_trollMaze@p_rSpaceVector;
    if count ~= 0 then
	if count = 1 then
	    Print("There is open space ");
	else
	    Print("There are open spaces ");
	fi;
	for i from 0 upto count - 1 do
	    if i ~= 0 then
		if i = count - 1 then
		    Print(" and ");
		else
		    Print(", ");
		fi;
	    fi;
	    Print(
		case spaces[i]
		incase D_NORTH:
		    "to the north"
		incase D_SOUTH:
		    "to the south"
		incase D_EAST:
		    "to the east"
		incase D_WEST:
		    "to the west"
		incase D_UP:
		    "above you"
		incase D_DOWN:
		    "below you"
		default:
		    "?"
		esac);
	od;
	Print(".");
	r_trollMaze@p_rSpaceCount := 0;
	true
    else
	false
    fi
corp;

define tp_trollMaze proc drawFloor(int x, y, z)void:
    int kind, xScale, yScale;

    kind := maze(z - 1, y, x);
    if kind = MAZE_NORMAL then
	GSetPen(nil, C_GOLD);
    elif kind = MAZE_BLOCK then
	GSetPen(nil, C_LIGHT_GREY);
    else
	GSetPen(nil, C_DARK_GREY);
    fi;
    xScale := GCols(nil) / (2 * (MAZE_MAX_X + 1));
    yScale := GRows(nil) / (MAZE_MAX_Y + 1);
    GAMovePixels(nil, x * xScale, y * yScale);
    GRectanglePixels(nil, xScale, yScale, true);
corp;

define tp_trollMaze proc drawBlock(int x, y, kind)void:
    int xScale, yScale;

    if kind = MAZE_NORMAL then
	GSetPen(nil, C_ORANGE);
    else
	GSetPen(nil, C_MEDIUM_GREY);
    fi;
    xScale := GCols(nil) / (2 * (MAZE_MAX_X + 1));
    yScale := GRows(nil) / (MAZE_MAX_Y + 1);
    GAMovePixels(nil, x * xScale, y * yScale);
    GRectanglePixels(nil, xScale, yScale, true);
corp;

define tp_trollMaze proc showMaze()void:
    thing me;
    int x, y, z, dx, dy, dz, x0, y0, kind, xScale, yScale;
    bool needNewLine;

    me := Me();
    if me@p_oLight or FindFlagOnList(me@p_pCarrying, p_oLight) then
	x := me@p_pMazeX;
	y := me@p_pMazeY;
	z := me@p_pMazeZ;
	dx := x - MAZE_GOAL_X;
	dy := y - MAZE_GOAL_Y;
	dz := z - MAZE_GOAL_Z;
	if dz = 0 and dy = 0 and dx = 0 then
	    Print("You are in the heart of the trolls.\n");
	elif dz = 0 and dy = 2 and dx = 0 then
	    Print("You are on a drawbridge.\n");
	elif maze(z, y, x) = MAZE_NORMAL then
	    Print("You are in solid rock.\n");
	else
	    Print("You are in a cavity in the rock.\n");
	fi;
	if maze(z + 1, y, x) = MAZE_OPEN then
	    markSpace(D_UP);
	fi;
	if maze(z - 1, y, x) = MAZE_OPEN then
	    markSpace(D_DOWN);
	fi;
	if maze(z, y - 1, x) = MAZE_OPEN then
	    markSpace(D_NORTH);
	fi;
	if maze(z, y + 1, x) = MAZE_OPEN then
	    markSpace(D_SOUTH);
	fi;
	if maze(z, y, x - 1) = MAZE_OPEN then
	    markSpace(D_WEST);
	fi;
	if maze(z, y, x + 1) = MAZE_OPEN then
	    markSpace(D_EAST);
	fi;
	needNewLine := dumpSpaces();
	if z = MAZE_GOAL_Z and y = MAZE_GOAL_Y + 3 and x = MAZE_GOAL_X then
	    if o_drawBridge@p_oState = 0 then
		Print(" There is a drawbridge drawn up on the other side of "
		    "the chasm, and there is a small sign on this side.");
	    else
		Print(" There is a drawbridge across the chasm, and there "
		    "is a small sign on this side.");
	    fi;
	fi;
	if needNewLine then
	    Print("\n");
	fi;
	if dx ~= 0 or dy ~= 0 or dz ~= 0 then
	    if dx > -2 and dx < 2 then
		dx := 0;
	    fi;
	    if dy > -2 and dy < 2 then
		dy := 0;
	    fi;
	    if dz > -2 and dz < 2 then
		dz := 0;
	    fi;
	    if dx = 0 and dy = 0 and dz = 0 then
		Print("Whatever has been leading you around is very close.\n");
	    else
		Print("The tugging is coming from ");
		if dz ~= 0 then
		    if dz < 0 then
			Print("above");
		    elif dz > 0 then
			Print("below");
		    fi;
		    if dx ~= 0 or dy ~= 0 then
			Print(" and from ");
		    fi;
		fi;
		if dx ~= 0 or dy ~= 0 then
		    Print("the ");
		    if dx < 0 then
			if dy < 0 then
			    Print("southeast");
			elif dy = 0 then
			    Print("east");
			else
			    Print("northeast");
			fi;
		    elif dx = 0 then
			if dy < 0 then
			    Print("south");
			elif dy > 0 then
			    Print("north");
			fi;
		    else
			if dy < 0 then
			    Print("southwest");
			elif dy = 0 then
			    Print("west");
			else
			    Print("northwest");
			fi;
		    fi;
		fi;
		Print(".\n");
	    fi;
	fi;
	if GOn(nil) then
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 0.0, 0.0);
	    GRectangle(nil, 0.5, 1.0, true);
	    kind := maze(z, y, x);
	    if kind = MAZE_OPEN then
		drawFloor(x, y, z);
	    else
		drawBlock(x, y, kind);
	    fi;
	    if y > 0 then
		kind := maze(z, y - 1, x);
		if kind = MAZE_OPEN then
		    drawFloor(x, y - 1, z);
		    if y > 1 then
			kind := maze(z, y - 2, x);
			if kind = MAZE_OPEN then
			    drawFloor(x, y - 2, z);
			else
			    drawBlock(x, y - 2, kind);
			fi;
		    fi;
		else
		    drawBlock(x, y - 1, kind);
		fi;
		if x < MAZE_MAX_X then
		    kind := maze(z, y - 1, x + 1);
		    if kind = MAZE_OPEN then
			drawFloor(x + 1, y - 1, z);
		    else
			drawBlock(x + 1, y - 1, kind);
		    fi;
		fi;
	    fi;
	    if x < MAZE_MAX_X then
		kind := maze(z, y, x + 1);
		if kind = MAZE_OPEN then
		    drawFloor(x + 1, y, z);
		    if x < MAZE_MAX_X - 1 then
			kind := maze(z, y, x + 2);
			if kind = MAZE_OPEN then
			    drawFloor(x + 2, y, z);
			else
			    drawBlock(x + 2, y, kind);
			fi;
		    fi;
		else
		    drawBlock(x + 1, y, kind);
		fi;
		if y < MAZE_MAX_Y then
		    kind := maze(z, y + 1, x + 1);
		    if kind = MAZE_OPEN then
			drawFloor(x + 1, y + 1, z);
		    else
			drawBlock(x + 1, y + 1, kind);
		    fi;
		fi;
	    fi;
	    if y < MAZE_MAX_Y then
		kind := maze(z, y + 1, x);
		if kind = MAZE_OPEN then
		    drawFloor(x, y + 1, z);
		    if y < MAZE_MAX_Y - 1 then
			kind := maze(z, y + 2, x);
			if kind = MAZE_OPEN then
			    drawFloor(x, y + 2, z);
			else
			    drawBlock(x, y + 2, kind);
			fi;
		    fi;
		else
		    drawBlock(x, y + 1, kind);
		fi;
		if x > 0 then
		    kind := maze(z, y + 1, x - 1);
		    if kind = MAZE_OPEN then
			drawFloor(x - 1, y + 1, z)
		    else
			drawBlock(x - 1, y + 1, kind);
		    fi;
		fi;
	    fi;
	    if x > 0 then
		kind := maze(z, y, x - 1);
		if kind = MAZE_OPEN then
		    drawFloor(x - 1, y, z);
		    if x > 1 then
			kind := maze(z, y, x - 2);
			if kind = MAZE_OPEN then
			    drawFloor(x - 2, y, z);
			else
			    drawBlock(x - 2, y, kind);
			fi;
		    fi;
		else
		    drawBlock(x - 1, y, kind);
		fi;
		if y > 0 then
		    kind := maze(z, y - 1, x - 1);
		    if kind = MAZE_OPEN then
			drawFloor(x - 1, y - 1, z);
		    else
			drawBlock(x - 1, y - 1, kind);
		    fi;
		fi;
	    fi;
	    xScale := GCols(nil) / (2 * (MAZE_MAX_X + 1));
	    yScale := GRows(nil) / (MAZE_MAX_Y + 1);
	    if z = MAZE_GOAL_Z and
		x >= MAZE_GOAL_X - 1 and x <= MAZE_GOAL_X + 1 and
		y >= MAZE_GOAL_Y and y <= MAZE_GOAL_Y + 3
	    then
		x0 := MAZE_GOAL_X * xScale;
		y0 := MAZE_GOAL_Y * yScale;
		/* Draw the sign */
		GSetPen(nil, C_RED_ORANGE);
		GAMovePixels(nil, x0 + xScale + 1, y0 + yScale * 3 + 1);
		GRectanglePixels(nil, xScale / 10, yScale / 10, true);
		/* Draw the drawbridge */
		GSetPen(nil, C_BROWN);
		GAMovePixels(nil, x0 + 1, y0 + yScale * 2 - 1);
		if o_drawBridge@p_oState = 0 then
		    GRectanglePixels(nil, xScale - 2, yScale / 5, true);
		else
		    GRectanglePixels(nil, xScale - 2, yScale + yScale / 5,
			true);
		fi;
	    fi;
	    PlaceCursorPixels(x * xScale + (xScale - 7) / 2,
			      y * yScale + (yScale - 7) / 2);
	fi;
    else
	Print("It is dark.\n");
    fi;
corp;

define tp_trollMaze proc mazeLookChecker()status:
    showMaze();
    succeed
corp;
AddRoomLookChecker(r_trollMaze, mazeLookChecker, false)$

define tp_trollMaze proc enterMaze()status:
    thing me;

    me := Me();
    if me@p_pHasShovel then
	me@p_pMazeX := MAZE_ENTER_X;
	me@p_pMazeY := MAZE_ENTER_Y;
	me@p_pMazeZ := MAZE_ENTER_Z;
	o_drawBridge@p_oState := 0;
	Print("Amazingly enough, you are able to walk right into the wall. "
	    "The stone seems to be soft, and it opens in front of you and "
	    "closes behind you.\n");
	SetLocation(r_trollMaze);
	if LightAt(r_shovelChamber) then
	    if not me@p_pHidden then
		OPrint(me@p_pName + " walks into the rock and disappears!\n");
		ForEachAgent(r_shovelChamber, UnShowIconOnce);
	    fi;
	else
	    ForEachAgent(r_shovelChamber, UnShowRoomFromAgent);
	fi;
	SetLocation(r_trollMaze);
	if GOn(nil) then
	    RemoveCursor();
	    GUndrawIcons(nil);
	    GResetIcons(nil);
	    DrawRoomName("Solid Rock", "");
	else
	    Print("Warning! This puzzle area is MUCH easier if you have "
		"a graphics display!\n\n");
	fi;
	succeed
    else
	Print("You can't go in that direction.\n");
	fail
    fi
corp;
AddNorthChecker(r_shovelChamber, enterMaze, false)$

define tp_trollMaze proc mazeMove(int xDelta, yDelta, zDelta)status:
    thing me;
    int x, y, z, oldKind, kind;

    me := Me();
    x := me@p_pMazeX;
    y := me@p_pMazeY;
    z := me@p_pMazeZ;
    oldKind := maze(z, y, x);
    if oldKind = MAZE_OPEN and zDelta = 1 then
	Print("The ceiling is too high - you cannot go up that way.\n");
    else
	x := x + xDelta;
	y := y + yDelta;
	z := z + zDelta;
	kind := maze(z, y, x);
	if kind = MAZE_BLOCK then
	    Print("That rock is too hard for you to dig into.\n");
	else
	    if oldKind ~= MAZE_OPEN or kind ~= MAZE_OPEN then
		Print("You dig ");
		if zDelta = -1 then
		    Print("downwards ");
		elif zDelta = 1 then
		    Print("upwards ");
		fi;
		if kind = MAZE_OPEN then
		    Print("into a cavity in the rock.\n");
		else
		    Print("through the rock.\n");
		fi;
	    fi;
	    if kind = MAZE_OPEN then
		while maze(z - 1, y, x) = MAZE_OPEN do
		    Print("There is a cavity beneath you - you fall.\n");
		    z := z - 1;
		od;
	    fi;
	    me@p_pMazeX := x;
	    me@p_pMazeY := y;
	    me@p_pMazeZ := z;
	    if GOn(nil) then
		RemoveCursor();
	    fi;
	    showMaze();
	fi;
    fi;
    fail
corp;

define tp_trollMaze proc mazeMoveNorth()status:
    thing me;

    me := Me();
    if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 3 and
	me@p_pMazeX = MAZE_GOAL_X and o_drawBridge@p_oState = 1
    then
	if GOn(nil) then
	    RemoveCursor();
	fi;
	me@p_pMazeY := MAZE_GOAL_Y + 2;
	showMaze();
	fail
    else
	if me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 1 and
	    me@p_pMazeX = MAZE_GOAL_X
	then
	    Print("You enter the heart of the trolls - their most sacred "
		"place. Congratulations on finding it!\n");
	    DoQuest(questHeartCheck);
	fi;
	mazeMove(0, -1, 0)
    fi
corp;
define tp_trollMaze proc mazeMoveEast()status:
    mazeMove(1, 0, 0)
corp;
define tp_trollMaze proc mazeMoveSouth()status:
    thing me;

    me := Me();
    if me@p_pMazeX = MAZE_ENTER_X and
	me@p_pMazeY = MAZE_ENTER_Y and
	me@p_pMazeZ = MAZE_ENTER_Z
    then
	continue
    elif me@p_pMazeZ = MAZE_GOAL_Z and me@p_pMazeY = MAZE_GOAL_Y + 1 and
	me@p_pMazeX = MAZE_GOAL_X
    then
	if GOn(nil) then
	    RemoveCursor();
	fi;
	me@p_pMazeY := MAZE_GOAL_Y + 2;
	showMaze();
	fail
    else
	mazeMove(0, 1, 0)
    fi
corp;
define tp_trollMaze proc mazeMoveWest()status:
    mazeMove(-1, 0, 0)
corp;
define tp_trollMaze proc mazeMoveUp()status:
    mazeMove(0, 0, 1)
corp;
define tp_trollMaze proc mazeMoveDown()status:
    mazeMove(0, 0, -1)
corp;

HUniConnect(r_trollMaze, r_trollMaze, D_NORTH)$
HUniConnect(r_trollMaze, r_trollMaze, D_EAST)$
HUniConnect(r_trollMaze, r_shovelChamber, D_SOUTH)$
HUniConnect(r_trollMaze, r_trollMaze, D_WEST)$
HUniConnect(r_trollMaze, r_trollMaze, D_DOWN)$
HUniConnect(r_trollMaze, r_trollMaze, D_UP)$
AddNorthChecker(r_trollMaze, mazeMoveNorth, false)$
AddEastChecker(r_trollMaze, mazeMoveEast, false)$
AddSouthChecker(r_trollMaze, mazeMoveSouth, false)$
AddWestChecker(r_trollMaze, mazeMoveWest, false)$
AddUpChecker(r_trollMaze, mazeMoveUp, false)$
AddDownChecker(r_trollMaze, mazeMoveDown, false)$

define tp_trollMaze proc shovelDig()void:
    ignore mazeMove(0, 0, -1);
corp;
AddSpecialCommand(r_trollMaze, "dig,excavate,shovel", shovelDig)$

r_trollMaze@p_rLayerList := CreateThingList()$

define tp_trollMaze proc makeRow(string r)int:
    int row, i;
    string ch;

    row := 0;
    for i from 0 upto MAZE_MAX_X do
	row := row << 2;
	ch := SubString(r, i, 1);
	if ch = "B" then
	    row := row | MAZE_BLOCK;
	elif ch = "N" then
	    row := row | MAZE_NORMAL;
	elif ch = "." then
	    row := row | MAZE_OPEN;
	else
	    Print("Illegal character in maze row: '" + ch + "'.\n");
	fi;
    od;
    row
corp;

define tp_trollMaze proc makeLayer(string y0,y1,y2,y3,y4,y5,y6,y7,y8,y9)void:
    thing th;
    list int li;

    li := CreateIntArray(10);
    li[0] := makeRow(y0);
    li[1] := makeRow(y1);
    li[2] := makeRow(y2);
    li[3] := makeRow(y3);
    li[4] := makeRow(y4);
    li[5] := makeRow(y5);
    li[6] := makeRow(y6);
    li[7] := makeRow(y7);
    li[8] := makeRow(y8);
    li[9] := makeRow(y9);
    th := CreateThing(nil);
    th@p_rLayer := li;
    AddTail(r_trollMaze@p_rLayerList, th);
corp;

/* must be given from the bottom up */

makeLayer(	/* 0 */
    "NNNNNNNNNNNNNNNN",
    "NNNNNNNNNNNNNNNN",
    "BNNNBNBNBBNNBBBN",
    "BNNNBNBNBNBNNBNN",
    "BNNNBNBNBBNNNBNN",
    "BNNNBNBNBNBNNBNN",
    "BBBNNBBNBNBNNBNN",
    "NNNNNNNNNNNNNNNN",
    "NNNNNNNNNNNNNNNN",
    "BBBNBBBNBBBNBBBN")$

makeLayer(	/* 1 */
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBNBBBNBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBBBBBBB",
    "BBBBBBBBBBNBBBBB",
    "BBBBBBBBBBBBBBBB")$

makeLayer(	/* 2 */
    "BBBBNN..B..NN..N",
    "...B....B...BBBN",
    ".B.BBB..B...BBBN",
    ".....NN.B...BBBN",
    ".B.BBBBBBBBBBBBB",
    "...BNNNBBBBBBBBB",
    ".B.BNBNBBBBBBBBN",
    "...BNBNBBB.....N",
    ".B.BNBNB.B.BBBBB",
    "...BNBN..BBBNNNB")$

makeLayer(	/* 3 */
    "BBBB.NN...NN....",
    "BBBB........BBB.",
    "BBBBBB......B...",
    "BBBBBBN.B...B.BB",
    "BBBBBBBBBBBBB.BB",
    "BBBB.B.B.B....BN",
    "BBBB.B.B.BBBBBBN",
    "BBBB...B.B......",
    "BBBB...B.B......",
    "BBBB..NNNNNNNNBB")$

makeLayer(	/* 4 */
    ".NBB..NNNNN...BB",
    "..NN........BBBB",
    "BBBBB.....BBBBBB",
    "BBB.NNN...BBBBBB",
    "BBBBBBBBBBBBBBBN",
    "N....BBB.B...BBN",
    "BBBB.BBBBBBBBBB.",
    "......BB.BBBBBB.",
    ".NNNNNNBBB..BBBB",
    "......NNN..NBBBB")$

makeLayer(	/* 5 */
    ".NNB............",
    "...B............",
    ".........BBBB.B.",
    "NBBN....BBB.B.NN",
    "NBBBBBBBBBB.BBNN",
    "NBBB..B..B...BBB",
    "BBBB..B......BBB",
    "......BB.BBBBB.B",
    "......NBBB.....B",
    "......NNNN.NNNNN")$

makeLayer(	/* 6 */
    "..BB.......B.BBB",
    "..BB.......B..BB",
    "BBBB...B.NBBB.BB",
    "BBBN...BBNBBB.BB",
    "BBBBBBBBBNBBBBNB",
    "BBBB..B.BBBBBBNB",
    "BBBB..BBBBBBBBNB",
    "BBBBBBBBBBBBBBBB",
    "BBBB...BBB......",
    "BBBB........BBBB")$

makeLayer(	/* 7 */
    "BBB..BBBBBBB....",
    "BBB....BBBB...B.",
    "BBNN...NNNN...B.",
    "...N...NBBBB..B.",
    "BBBBBBBBBNB..BN.",
    "NNNN..B..NB.BBN.",
    "N.....BBBBB.....",
    "N.......B...BBB.",
    "N...............",
    "NNNN........BBBB")$

makeLayer(	/* 8 */
    "BB.....NNNNNN.BB",
    "BBN....NBBBBB.B.",
    ".......NNNNBB.B.",
    "BBBBBB.NBBBBB.BB",
    "BBBBBBBBBBBBBBB.",
    "BBBB..BBBBBBBBB.",
    "BBBB..BBBBBBBBB.",
    "BBBB...BBBBBBBBB",
    "BBBB...BBBB.BBBB",
    "BBBB...BBBB.BBBB")$

makeLayer(	/* 9 */
    "B......NBBBB.B..",
    "....BBBBBBBB....",
    "........NBBB.B..",
    "BBBBBB..B....B..",
    "........BB.B.B..",
    "NNNN..B.BB.B.B..",
    "N..........B.B..",
    "N.NN...BB.BB.B..",
    "N..N....B.B..BB.",
    "NNNN............")$

ignore DeleteSymbol(tp_trollMaze, "makeLayer")$
ignore DeleteSymbol(tp_trollMaze, "makeRow")$

unuse tp_trollMaze
