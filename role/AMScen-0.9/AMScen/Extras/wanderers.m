/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * wanderers.m - create some fake players to stress test things.
 */

use t_base
use t_util
use t_icons
use t_fight

private tp_wanderer CreateTable().
use tp_wanderer

define tp_wanderer p_pCarryTarget CreateIntProp().
define tp_wanderer p_pHitHereCount CreateIntProp().
define tp_wanderer p_wLastDir CreateIntProp().

define tp_wanderer proc tryMove(int dir)bool:
    thing here, there, me;

    here := Here();
    me := Me();
    there := here@(DirProp(dir));
    if there = nil then
	false
    else
	not there@p_rLocked and
	    DoPlayerLeaveChecks(me, dir) ~= fail and
	    DoDirChecks(here, dir) ~= fail and
	    DoRoomAnyLeaveChecks(here) ~= fail
    fi
corp;

define tp_wanderer proc attackAgent(thing who)void:
    thing me, oldLoc;

    me := Me();
    if (not who@p_pStandard or Random(me@p_pHitHereCount * 2 + 1) = 0) and
	not who@p_pHidden and who@p_pName ~= ""
    then
	oldLoc := Here();
	StandardAttack(me, who, oldLoc);
	me@p_pHitHereCount := me@p_pHitHereCount + 1;
	if Here() ~= oldLoc then
	    /* we died, kludge to avoid still attacking */
	    me@p_pHitHereCount := 1000000;
	fi;
    fi;
corp;

define tp_wanderer proc wandererStep()void:
    thing here, me, object, home;
    list thing lt;
    int dir, firstNum, n, count, pickedUp;
    bool found, lost;
    status st;

    me := Me();
    lost := false;
    if Random(4) = 0 and FindName(Here()@p_rContents, p_oName, "grate") ~= fail
    then
	ignore Parse(G, "lift grate");
    else
	firstNum := me@p_wLastDir;
	if Random(3) ~= 0 then
	    dir := firstNum;
	else
	    firstNum := DirBack(firstNum);
	    while
		dir := Random(12);
		dir = firstNum
	    do
	    od;
	    firstNum := dir;
	fi;
	found := false;
	while not found do
	    if tryMove(dir) then
		found := true;
	    else
		dir := (dir + 1) % 12;
		if dir = firstNum then
		    lost := true;
		    found := true;
		fi;
	    fi;
	od;
    fi;
    if not lost then
	/* cannot get upset if 'lost', since that can happen if all directions
	   we try in the proving grounds are blocked by monsters. */
	me@p_wLastDir := dir;
	MachineMove(dir);
	me@p_pHitHereCount := 0;
	ForEachAgent(Here(), attackAgent);
	/* grab this after the attacks - we may have died! */
	here := Here();
	lt := here@p_rContents;
	count := Count(lt);
	pickedUp := 0;
	n := 0;
	while n < count do
	    object := lt[n];
	    n := n + 1;
	    if not object@p_oInvisible then
		if Random(pickedUp + 1) = 0 then
		    st := DoGet(here, me, object);
		    if st = continue then
			count := count - 1;
			n := n - 1;
			pickedUp := pickedUp + 1;
		    elif st = succeed then
			/* do not really know the state of things - skip one */
			count := count - 1;
		    fi;
		fi;
	    fi;
	od;
	lt := me@p_pCarrying;
	count := Count(lt);
	if count ~= 0 then
	    if count <= me@p_pCarryTarget then
		count := 0;
	    else
		count := Random(count - me@p_pCarryTarget);
	    fi;
	fi;
	while count ~= 0 do
	    object := lt[0];
	    count := count - 1;
	    if DoDrop(here, me, object) ~= continue then
		count := 0;
	    fi;
	od;
    fi;
    After(3 + Random(6), wandererStep);
corp;

define tp_wanderer proc createMarble(thing who; string colour)void:
    thing it;

    it := CreateThing(nil);
    it@p_oName := "marble;" + colour;
    it@p_oHome := Here();
    it@p_oCarryer := who;
    it@p_oCreator := Me();	/* whoever creates the wanderers */
    SetThingStatus(it, ts_readonly);
    AddTail(who@p_pCarrying, it);
corp;

define tp_wanderer proc wandererStart()void:

    OPrint(Me()@p_pName + " has appeared.\n");
    ForEachAgent(Here(), ShowIconOnce);
    After(3 + Random(6), wandererStep);
corp;

define tp_wanderer proc wandererPre()status:

    SPrint(TrueMe(), Me()@p_pName + " accepts the gift.\n");
    continue
corp;

define tp_wanderer proc wandererNoNo()status:

    DoSay("Watch it!");
    fail
corp;

define tp_wanderer genericWanderer CreateThing(nil).
genericWanderer@p_pStandard := true.
genericWanderer@p_pProtection := 5.	 /* armour class +5 */
genericWanderer@p_pHitMax := 50.
genericWanderer@p_pStrength := 7.
genericWanderer@p_pGivePre := wandererPre.
genericWanderer@p_oTouchChecker := wandererNoNo.
genericWanderer@p_oSmellChecker := wandererNoNo.
genericWanderer@p_oPushChecker := wandererNoNo.
genericWanderer@p_oPullChecker := wandererNoNo.
genericWanderer@p_oTurnChecker := wandererNoNo.
genericWanderer@p_oLiftChecker := wandererNoNo.
genericWanderer@p_oLowerChecker := wandererNoNo.
genericWanderer@p_oEatChecker := wandererNoNo.
GNewIcon(genericWanderer, makeWandererIcon()).

define tp_wanderer proc makeWanderer(string name; int carryTarget;
	thing where)void:
    thing me, marble;
    int i;

    me := CreateThing(genericWanderer);
    me@p_wLastDir := Random(12);
    me@p_pDesc := name + ", created " + where@p_rName +
	", is wandering around and stress-testing the MUD system.";
    SetupMachine(me);
    if carryTarget % 2 = 0 then
	me@p_oLight := true;
    fi;
    me@p_pCarryTarget := carryTarget;
    createMarble(me, "red");
    createMarble(me, "blue");
    createMarble(me, "green");
    createMarble(me, "white");
    createMarble(me, "black");
    InitFighter(me);
    /* override 'InitFighter' by inheriting from 'genericWanderer' */
    me -- p_pProtection;
    me -- p_pHitMax;
    me@p_pHitNow := 50;
    me -- p_pStrength;
    CreateMachine(name, me, where, wandererStart);
    ignore SetMachineActive(me, wandererStep);
corp;

define tp_wanderer proc createWanderers()void:
    thing here;

    here := Here();
    makeWanderer("Arnold",    1, here);
    makeWanderer("Betty",     2, here);
    makeWanderer("Charles",   3, here);
    makeWanderer("Diana",     4, here);
    makeWanderer("Eugene",    5, here);
    makeWanderer("Farrah",    6, here);
    makeWanderer("Gregory",   7, here);
    makeWanderer("Hannah",    1, here);
    makeWanderer("Irving",    2, here);
    makeWanderer("Joan",      3, here);
    makeWanderer("Keith",     4, here);
    makeWanderer("Lucille",   5, here);
    makeWanderer("Martin",    6, here);
    makeWanderer("Nancy",     7, here);
    makeWanderer("Orville",   1, here);
    makeWanderer("Penelope",  2, here);
    makeWanderer("Quint",     3, here);
    makeWanderer("Rhonda",    4, here);
    makeWanderer("Samuel",    5, here);
    makeWanderer("Teresa",    6, here);
    makeWanderer("Ulysses",   7, here);
    makeWanderer("Veronica",  1, here);
    makeWanderer("William",   2, here);
    makeWanderer("Xaviera",   3, here);
    makeWanderer("Yves",      4, here);
    makeWanderer("Zenda",     5, here);
corp;
