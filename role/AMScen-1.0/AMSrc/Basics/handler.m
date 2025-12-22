/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * handler.m - define and install the new-player handler. This is done
 *	last in sourcing the scenario, so that it can use anything from
 *	any of the pieces of the scenario, including optional parts.
 */

/*
 * newPlayer - this is the routine which we set up to be called when a
 *	new player is created.
 */

define tp_misc proc newPlayer()void:
    string name;
    thing me;

    me := Me();
    name := me@p_pName;
    me@p_pCarrying := CreateThingList();
    me@p_pHiddenList := CreateThingList();
    if me@p_pDesc = "" then
	/* not SysAdmin */
	me@p_pDesc := Capitalize(name) + " is a nondescript adventurer.";
    fi;
    /* Do this carefully. We have set SysAdmin up with these lists already,
       and some code, e.g. the build2 code, has added routines to these
       lists, which we want to execute after all normal setup is done. */
    if me@p_pEnterActions = nil then
	me@p_pEnterActions := CreateActionList();
    fi;
    if me@p_pExitActions = nil then
	me@p_pExitActions := CreateActionList();
    fi;
    me@p_pMoney := 75;
    me@p_pVerbose := true;
    me@p_pSuperBrief := false;
    me@p_pEchoPose := false;
    me@p_pStandard := true;
    me@p_pPosition := POS_NONE;
    me@p_pWhere := me;
    me@p_pCursor := MakeCursor();
    me@p_pCursorColour := C_RED;
    me@p_pIconColour := C_WHITE;
    me@p_pTextColours := CreateIntList();
    AddTail(me@p_pTextColours, 0x000);
    AddTail(me@p_pTextColours, 0xb80);
    AddTail(me@p_pTextColours, 0xa60);
    AddTail(me@p_pTextColours, 0xda0);
    me@p_MapGroup := NO_MAP_GROUP;
    SetLocation(r_arrivals);
    ignore SetCharacterInputAction(parseInput);
    ignore SetCharacterRawKeyAction(handleRawKey);
    ignore SetCharacterButtonAction(StandardButtonHandler);
    ignore SetCharacterMouseDownAction(StandardMouseDownHandler);
    ignore SetCharacterIdleAction(idleAction);
    ignore SetCharacterActiveAction(activeAction);
    if GOn(nil) then
	InitStandardGraphics();
    else
	me@p_pStandardGraphicsDone := false;
    fi;
    /* This will cause SysAdmin to become a builder. */
    DoList(me@p_pEnterActions);
    note - we assume the arrivals room is not dark;
    ForEachAgent(r_arrivals, ShowIconOnce);
    OPrint("New player " + name + " has appeared.\n");
    Print("Welcome to the sample V" + IntToString(ServerVersion() / 10) + "." +
	 IntToString(ServerVersion() % 10) + " MUD world, " + name +
	"! Your character has been created, but it is quite minimal - "
	"you are not carrying anything, and your appearance is dull. "
	"You will soon be able to remedy these conditions. Some of the "
	"commands available: quit, north, n, up, enter, northeast, verbose, "
	"terse, inventory, get, drop, look, examine, etc. Have fun!\n");
    ignore ShowClients(false);
    ignore ShowRoomToMe(true);
corp;

ignore SetNewCharacterAction(newPlayer).
