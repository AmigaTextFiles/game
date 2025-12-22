/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * base.m - standard MUD code for the basic activities and structures.
 */

private tp_base CreateTable().
use tp_base

public MAX_CARRY 7.

/* These properties are made public, so that a non-builder can make code
   to use them in the playpen. These are special in that they are
   referenced by the automatically generated code. We want that code to
   compile properly, even if the builder hasn't @use'd any tables such
   as t_base. */

public p_rName CreateStringProp().		/* the name of a room */
public p_rContents CreateThingListProp().	/* the room's contents */
public p_pCarrying CreateThingListProp().	/* player's inventory */
public p_oName CreateStringProp().		/* encoded name of object */
public p_oCarryer CreateThingProp().		/* who is carrying it */
public p_oCreator CreateThingProp().		/* who "created" it */
public p_oContents CreateThingListProp().	/* contents of an object */

/* some properties for rooms */

define t_base p_rBuyList CreateThingListProp(). /* list of things for sale */
define t_base p_rNameAction CreateActionProp(). /* call proc instead */
define t_base p_rDark CreateBoolProp(). 	/* its dark in here */
define t_base p_rNoMachines CreateBoolProp().	/* keep the machines out */
define t_base p_rLocked CreateBoolProp().	/* only owner can go in */
define t_base p_rDesc CreateStringProp().	/* full description of room */
define t_base p_rDescAction CreateActionProp(). /* call proc instead */
define t_base p_rScenery CreateStringProp().	/* scenery names */
define t_base p_rExits CreateIntListProp().	/* list of obvious exits */
define t_base p_rFurtherDesc CreateActionProp()./* for any extra stuff */
define t_base p_rLastVisit CreateIntProp().	/* useful for timing things */
define t_base p_rNoGoString CreateStringProp(). /* print if cannot go */
define t_base p_rNoGoAction CreateActionProp(). /* call if cannot go */
define t_base p_rBuyAction CreateActionProp().	/* how to buy here */

/* the basic connections between rooms */

define t_base p_rNorth CreateThingProp().	/* actual north connection */
define t_base p_rSouth CreateThingProp().
define t_base p_rEast CreateThingProp().
define t_base p_rWest CreateThingProp().
define t_base p_rNorthEast CreateThingProp().
define t_base p_rNorthWest CreateThingProp().
define t_base p_rSouthEast CreateThingProp().
define t_base p_rSouthWest CreateThingProp().
define t_base p_rUp CreateThingProp().
define t_base p_rDown CreateThingProp().
define t_base p_rEnter CreateThingProp().
define t_base p_rExit CreateThingProp().

define t_base p_rNorthDesc CreateStringProp().	/* special description */
define t_base p_rSouthDesc CreateStringProp().
define t_base p_rEastDesc CreateStringProp().
define t_base p_rWestDesc CreateStringProp().
define t_base p_rNorthEastDesc CreateStringProp().
define t_base p_rNorthWestDesc CreateStringProp().
define t_base p_rSouthEastDesc CreateStringProp().
define t_base p_rSouthWestDesc CreateStringProp().
define t_base p_rUpDesc CreateStringProp().
define t_base p_rDownDesc CreateStringProp().
define t_base p_rEnterDesc CreateStringProp().
define t_base p_rExitDesc CreateStringProp().

define t_base p_rNorthMessage CreateStringProp(). /* to player when go */
define t_base p_rSouthMessage CreateStringProp().
define t_base p_rEastMessage CreateStringProp().
define t_base p_rWestMessage CreateStringProp().
define t_base p_rNorthEastMessage CreateStringProp().
define t_base p_rNorthWestMessage CreateStringProp().
define t_base p_rSouthEastMessage CreateStringProp().
define t_base p_rSouthWestMessage CreateStringProp().
define t_base p_rUpMessage CreateStringProp().
define t_base p_rDownMessage CreateStringProp().
define t_base p_rEnterMessage CreateStringProp().
define t_base p_rExitMessage CreateStringProp().

define t_base p_rNorthOMessage CreateStringProp(). /* to others when go */
define t_base p_rSouthOMessage CreateStringProp().
define t_base p_rEastOMessage CreateStringProp().
define t_base p_rWestOMessage CreateStringProp().
define t_base p_rNorthEastOMessage CreateStringProp().
define t_base p_rNorthWestOMessage CreateStringProp().
define t_base p_rSouthEastOMessage CreateStringProp().
define t_base p_rSouthWestOMessage CreateStringProp().
define t_base p_rUpOMessage CreateStringProp().
define t_base p_rDownOMessage CreateStringProp().
define t_base p_rEnterOMessage CreateStringProp().
define t_base p_rExitOMessage CreateStringProp().

define t_base p_rNorthEMessage CreateStringProp(). /* to others when enter */
define t_base p_rSouthEMessage CreateStringProp().
define t_base p_rEastEMessage CreateStringProp().
define t_base p_rWestEMessage CreateStringProp().
define t_base p_rNorthEastEMessage CreateStringProp().
define t_base p_rNorthWestEMessage CreateStringProp().
define t_base p_rSouthEastEMessage CreateStringProp().
define t_base p_rSouthWestEMessage CreateStringProp().
define t_base p_rUpEMessage CreateStringProp().
define t_base p_rDownEMessage CreateStringProp().
define t_base p_rEnterEMessage CreateStringProp().
define t_base p_rExitEMessage CreateStringProp().

/* The various 'checker' lists are private, since they are accessed only
   via the supplied Add/Del Checker routines. */

define tp_base p_rNorthChecks CreateActionListProp().
define tp_base p_rSouthChecks CreateActionListProp().
define tp_base p_rEastChecks CreateActionListProp().
define tp_base p_rWestChecks CreateActionListProp().
define tp_base p_rNorthEastChecks CreateActionListProp().
define tp_base p_rNorthWestChecks CreateActionListProp().
define tp_base p_rSouthEastChecks CreateActionListProp().
define tp_base p_rSouthWestChecks CreateActionListProp().
define tp_base p_rUpChecks CreateActionListProp().
define tp_base p_rDownChecks CreateActionListProp().
define tp_base p_rEnterChecks CreateActionListProp().
define tp_base p_rExitChecks CreateActionListProp().
define tp_base p_rAnyEnterChecks CreateActionListProp().
define tp_base p_rAnyEnterActions CreateActionListProp().
define tp_base p_rAnyLeaveChecks CreateActionListProp().
define tp_base p_rAnyLeaveActions CreateActionListProp().

define tp_base p_rGetChecks CreateActionListProp().	/* passed the object */
define tp_base p_rDropChecks CreateActionListProp().	/* passed the object */

define tp_base p_rSayChecks CreateActionListProp().	/* passed stuff said */
define tp_base p_rLookChecks CreateActionListProp().	/* instead of/with */

/* some properties for players */

define t_base p_pDesc CreateStringProp().	/* the player's description */
define t_base p_pDescCheck CreateActionProp().	/* check to see if look OK */
define t_base p_pDescAction CreateActionProp(). /* call routine instead */
define t_base p_pDescMore CreateActionListProp().	/* more desc stuff */
define t_base p_pMoney CreateIntProp(). 	/* how much money player has */
define t_base p_pVerbose CreateBoolProp().	/* player wants verbose desc */
define t_base p_pSuperBrief CreateBoolProp().	/* player wants superbrief */
define t_base p_pEchoPose CreateBoolProp().	/* echo pose, say to them */
define t_base p_pHidden CreateBoolProp().	/* for special tricks */
define t_base p_pStandard CreateBoolProp().	/* not on fight monsters */
define t_base p_pPosition CreateIntProp().	/* special codes */
define t_base p_pWhere CreateThingProp().	/* e.g. the bench */
define t_base p_pCursor CreateIntListProp().	/* the chosen cursor */
define t_base p_pCursorColour CreateIntProp().	/* what colour they want */
define t_base p_pIconColour CreateIntProp().	/* what colour for these */
define t_base p_pTextColours CreateIntListProp(). /* colours for text window */
define t_base p_pPrivileged CreateBoolProp().
define t_base p_pBuilder CreateBoolProp().	/* used in the 'build' code */
define t_base p_pGivePre CreateActionProp().	/* before object check */
define t_base p_pGivePost CreateActionProp().	/* after object check */
define t_base p_pEnterActions CreateActionListProp().	/* do on startup */
define t_base p_pHiddenList CreateThingListProp().  /* whatever is needed */
define t_base p_pAliases CreateThingListProp(). /* top level aliases */
define t_base p_sAliasKey CreateStringProp().	/* the alias key */
define t_base p_sAliasValue CreateStringProp(). /* the aliased command */
define t_base p_pFollowing CreateThingProp().	/* who I am following */
define t_base p_pFollowers CreateThingListProp()./* those following me */

/* these are set by provided Add/Del routines, so can be private */

define tp_base p_pLeaveChecks CreateActionListProp().
define tp_base p_pEnterChecks CreateActionListProp().

/* some properties for objects */

define t_base p_oDesc CreateStringProp().	/* long description of it */
define t_base p_oDescCheck CreateActionProp().	/* check to see if look OK */
define t_base p_oDescAction CreateActionProp(). /* call proc instead */
define t_base p_oInvisible CreateBoolProp().	/* do not show up on look */
define t_base p_oHome CreateThingProp().	/* its home location */
define t_base p_oWhere CreateThingProp().	/* room it is now in */
define t_base p_oLight CreateBoolProp().	/* also on players/machines */
define t_base p_oReadString CreateStringProp(). /* stuff on a sign, etc. */
define t_base p_oReadAction CreateActionProp().
define t_base p_pReadChecker CreateActionProp()./* can he read? */
define t_base p_oState CreateIntProp(). 	/* handy for lots of things */
define t_base p_oCanSitIn CreateIntProp().	/* # + 1 who can sit in it */
define t_base p_oCanSitOn CreateIntProp().	/* # + 1 who can sit on it */
define t_base p_oCanLieIn CreateIntProp().	/* # + 1 who can lie in it */
define t_base p_oCanLieOn CreateIntProp().	/* # + 1 who can lie on it */
define t_base p_oCanStandIn CreateIntProp().	/* # + 1 who can stand in it */
define t_base p_oCanStandOn CreateIntProp().	/* # + 1 who can stand on it */
define t_base p_oPositionChecker CreateActionProp()./* checker for the above */
define t_base p_oGiveChecker CreateActionProp()./* when try to give it */
define t_base p_oPutMeInChecker CreateActionProp().
define t_base p_oPutInMeChecker CreateActionProp().
define t_base p_oTakeMeFromChecker CreateActionProp().
define t_base p_oTakeFromMeChecker CreateActionProp().
define t_base p_oFillMeWithChecker CreateActionProp().
define t_base p_oFillWithMeChecker CreateActionProp().
define t_base p_oUnlockMeWithChecker CreateActionProp().
define t_base p_oUnlockWithMeChecker CreateActionProp().
define t_base p_oNotLocked CreateBoolProp().
define t_base p_oActWord CreateStringProp().	/* word to 'act' an object */
define t_base p_oActString CreateStringProp().	/* simple string to print */
define t_base p_oActAction CreateActionProp().	/* routine to call */
define t_base p_oSpecialGrammar CreateGrammarProp(). /* for specials */
define t_base p_oCapacity CreateIntProp().	/* number of contents */
define t_base p_oConsumer CreateThingProp().	/* for potions */

define tp_misc POS_NONE 0.
define tp_misc POS_SIT_IN 1.
define tp_misc POS_SIT_ON 2.
define tp_misc POS_LIE_IN 3.
define tp_misc POS_LIE_ON 4.
define tp_misc POS_STAND_IN 5.
define tp_misc POS_STAND_ON 6.

define t_base p_oNotGettable CreateBoolProp().	/* stop people getting it */
define t_base p_oGetChecker CreateActionProp(). /* passed the object */
define t_base p_oDropChecker CreateActionProp()./* passed the object */
define t_base p_oUnGetChecker CreateActionProp()./* passed the object */
define t_base p_oBuyChecker CreateActionProp(). /* how to buy item */
define t_base p_oPrice CreateIntProp(). 	/* price of it */

/* properties dealing with the simple graphics stuff */

define t_base p_rEnterRoomDraw CreateActionProp().
define t_base p_rLeaveRoomDraw CreateActionProp().
define t_base p_MapGroup CreateIntProp().

/* kind codes for effects */

define t_base EFFECT_SOUND	0.
define t_base EFFECT_SPEECH	1.
define t_base EFFECT_MUSIC	2.


/*
 * define a unique-id generator for sound-effects id's
 */

define tp_base EffectIdBase CreateThing(nil).
define tp_base eid_nextId CreateIntProp().
EffectIdBase@eid_nextId := 0.

define t_base proc NextSoundEffectId()int:

    EffectIdBase@eid_nextId := EffectIdBase@eid_nextId + 1;
    EffectIdBase@eid_nextId
corp;


/*
 * define a time service for objects.
 */

define tp_base TimeBase CreateThing(nil).
define tp_base tb_first CreateThingProp().
define tp_base tb_lastTime CreateIntProp().
define tp_base tb_afterCount CreateIntProp().

define tp_base tl_next CreateThingProp().
define tp_base tl_delay CreateIntProp().
define tp_base tl_object CreateThingProp().
define tp_base tl_action CreateActionProp().

TimeBase@tb_first := TimeBase.
TimeBase@tb_lastTime := Time().
TimeBase@tb_afterCount := 0.

CreateMachine("TimeKeeper", TimeBase, nil, nil).

define tp_base proc callUserCode(action a; thing object)void:

    SetEffectiveTo(Owner(object));
    call(a, void)(object);
corp;

define tp_base proc timerStep()void:
    int last, now, delta;
    thing tl, next;

    last := TimeBase@tb_lastTime;
    if last ~= 0 then
	/* do not trigger if shutting down */
	TimeBase@tb_afterCount := TimeBase@tb_afterCount - 1;
	now := Time();
	delta := now - last;
	tl := TimeBase@tb_first;
	while tl ~= TimeBase do
	    tl@tl_delay := tl@tl_delay - delta;
	    tl := tl@tl_next;
	od;
	TimeBase@tb_lastTime := now;
	while
	    tl := TimeBase@tb_first;
	    tl ~= TimeBase and tl@tl_delay <= 0
	do
	    callUserCode(tl@tl_action, tl@tl_object);
	    TimeBase@tb_first := tl@tl_next;
	    ClearThing(tl);
	od;
	tl := TimeBase@tb_first;
	if tl ~= TimeBase and TimeBase@tb_afterCount = 0 then
	    delta := tl@tl_delay;
	    TimeBase@tb_afterCount := TimeBase@tb_afterCount + 1;
	    After(delta, timerStep);
	fi;
    fi;
corp;

define tp_base proc timerIdle()void:
    int now, delta;
    thing tl;

    now := Time();
    delta := now - TimeBase@tb_lastTime;
    tl := TimeBase@tb_first;
    while tl ~= TimeBase do
	tl@tl_delay := tl@tl_delay - delta;
	tl := tl@tl_next;
    od;
    /* mark as going idle */
    TimeBase@tb_lastTime := 0;
corp;

ignore SetMachineIdle(TimeBase, timerIdle).

define tp_base proc timerActive()void:
    thing tl;

    TimeBase@tb_lastTime := Time();
    TimeBase@tb_afterCount := 0;
    tl := TimeBase@tb_first;
    if tl ~= TimeBase then
	if tl@tl_delay <= 0 then
	    timerStep();
	else
	    TimeBase@tb_afterCount := 1;
	    After(tl@tl_delay, timerStep);
	fi;
    fi;
corp;

ignore SetMachineActive(TimeBase, timerActive).

define tp_base proc timerSet()status:

    TimeBase@tb_afterCount := TimeBase@tb_afterCount + 1;
    After(TimeBase@tb_first@tl_delay, timerStep);
    continue
corp;

/*
 * DoAfter - set things up so that after 'seconds' seconds, action 'a' will
 *	be called with parameter 'object'. It will be called with the
 *	EffectivePlayer set to the owner of 'object'.
 *
 *	Note that these time actions survive a server shutdown/restart - the
 *	delay interval is considered to be seconds of server up-time. This
 *	makes this facility ideal for timed events in scenario time.
 */

define t_base proc DoAfter(int seconds; thing object; action a)void:
    int now, delta;
    thing tl, tlNew, next;

    if seconds < 0 then
	Print("seconds < 0 in DoAfter\n");
    elif object = nil then
	Print("object = nil in DoAfter\n");
    elif a = nil then
	Print("action = nil in DoAfter\n");
    else
	now := Time();
	delta := now - TimeBase@tb_lastTime;
	tl := TimeBase@tb_first;
	while tl ~= TimeBase do
	    tl@tl_delay := tl@tl_delay - delta;
	    tl := tl@tl_next;
	od;
	TimeBase@tb_lastTime := now;
	tlNew := CreateThing(nil);
	tlNew@tl_delay := seconds;
	tlNew@tl_object := object;
	tlNew@tl_action := a;
	tl := TimeBase@tb_first;
	if tl = TimeBase or seconds < tl@tl_delay then
	    tlNew@tl_next := tl;
	    TimeBase@tb_first := tlNew;
	    ignore ForceAction(TimeBase, timerSet);
	else
	    while
		next := tl@tl_next;
		next ~= TimeBase and next@tl_delay <= seconds
	    do
		tl := next;
	    od;
	    tlNew@tl_next := next;
	    tl@tl_next := tlNew;
	fi;
    fi;
corp;

/*
 * CancelDoAfter - attempt to cancel an action setup by DoAfter. Note that
 *	DoAfter makes no checks for duplicates. This routine will simply
 *	cancel the first event with the matching object/action that it finds.
 *	In the current implementation, that is the earliest one to trigger.
 *	Return 'false' if no matching event found, else return 'true'.
 */

define t_base proc CancelDoAfter(thing object; action a)bool:
    thing tl, next;

    tl := TimeBase@tb_first;
    if tl = TimeBase then
	false
    elif tl@tl_object = object and tl@tl_action = a then
	TimeBase@tb_first := tl@tl_next;
	ClearThing(tl);
	true
    else
	while
	    next := tl@tl_next;
	    next ~= TimeBase and
		(next@tl_object ~= object or next@tl_action ~= a)
	do
	    next := tl;
	    tl := tl@tl_next;
	od;
	if next = TimeBase then
	    false
	else
	    tl@tl_next := next@tl_next;
	    ClearThing(next);
	    true
	fi
    fi
corp;


/* now some general utility routines */

/*
 * InsertCommand - do a command, but display it first.
 */

define t_base proc utility public InsertCommand(string command)void:

    Print(">>> " + command + "\n");
    ignore Parse(G, command);
corp;

/*
 * DoChecks - run through an action list, calling each one. Assume they
 *	all return a status value. Stop if one returns other than continue,
 *	and return the overall result. This will be:
 *		fail - a checker returned fail, i.e. do not proceed
 *		succeed - a checker returned succeed, i.e. this check
 *			overrode all others, but proceed with action
 *		continue - nothing special - proceed with action
 *	The distinction between the last two is only needed if the caller
 *	would also do something similar to the checkers (see the use of
 *	'DoRoomLookChecks' in 'EnterRoom' in 'util.m'.) Otherwise, most
 *	callers will treat the value as yes/no.
 *	Note: we assume that none of the actions modifies the list.
 */

define t_base proc utility public DoChecks(list action la)status:
    int count, i;
    status st;

    st := continue;
    if la ~= nil then
	SetEffectiveToNone();
	count := Count(la);
	i := 0;
	while i < count and st = continue do
	    st := call(la[i], status)();
	    i := i + 1;
	od;
    fi;
    st
corp;

/*
 * DoThingChecks - same, except a thing is passed to each action.
 */

define t_base proc utility public DoThingChecks(list action la;
	thing th)status:
    int count, i;
    status st;

    st := continue;
    if la ~= nil then
	SetEffectiveToNone();
	count := Count(la);
	i := 0;
	while i < count and st = continue do
	    st := call(la[i], status)(th);
	    i := i + 1;
	od;
    fi;
    st
corp;

/*
 * DoStringChecks - same, except each checker is passed a string argument.
 */

define t_base proc utility public DoStringChecks(list action la;
	string s)status:
    int count, i;
    status st;

    st := continue;
    if la ~= nil then
	SetEffectiveToNone();
	count := Count(la);
	i := 0;
	while i < count and st = continue do
	    st := call(la[i], status)(s);
	    i := i + 1;
	od;
    fi;
    st
corp;

/*
 * DoIntChecks - same, except each checker is passed an int argument.
 */

define t_base proc utility public DoIntChecks(list action la; int n)status:
    int count, i;
    status st;

    st := continue;
    if la ~= nil then
	SetEffectiveToNone();
	count := Count(la);
	i := 0;
	while i < count and st = continue do
	    st := call(la[i], status)(n);
	    i := i + 1;
	od;
    fi;
    st
corp;

/*
 * DoList - run through a list of actions, doing all of them.
 *	Note: we assume that none of the actions modifies this list.
 */

define t_base proc utility public DoList(list action la)void:
    int i;

    if la ~= nil then
	SetEffectiveToNone();
	for i from 0 upto Count(la) - 1 do
	    call(la[i], void)();
	od;
    fi;
corp;

/*
 * DoThingActions - these are passed a thing, but return no result.
 */

define t_base proc utility public DoThingActions(list action la; thing th)void:
    int i;

    if la ~= nil then
	SetEffectiveToNone();
	for i from 0 upto Count(la) - 1 do
	    call(la[i], void)(th);
	od;
    fi;
corp;

/*
 * DoActionsString - do some actions, yielding a string.
 */

define t_base proc utility public DoActionsString(list action la)string:
    int i;
    string s;

    s := "";
    if la ~= nil then
	SetEffectiveToNone();
	for i from 0 upto Count(la) - 1 do
	    s := s + call(la[i], string)();
	od;
    fi;
    s
corp;

/*
 * utility routines to yield direction properties, names, etc.
 */

define t_base D_NORTH	  0.
define t_base D_NORTHEAST 1.
define t_base D_EAST	  2.
define t_base D_SOUTHEAST 3.
define t_base D_SOUTH	  4.
define t_base D_SOUTHWEST 5.
define t_base D_WEST	  6.
define t_base D_NORTHWEST 7.
define t_base D_UP	  8.
define t_base D_DOWN	  9.
define t_base D_ENTER	 10.
define t_base D_EXIT	 11.

/*
 * DirBack - return the 'reverse' direction for a given direction.
 */

define t_base proc utility public DirBack(int dir)int:

    if dir < 4 then
	dir + 4
    elif dir < 8 then
	dir - 4
    else
	dir >< 1
    fi
corp;

define t_base proc utility public DirName(int dir)string:
    case dir
    incase D_NORTH:
	"the north"
    incase D_NORTHEAST:
	"the north-east"
    incase D_EAST:
	"the east"
    incase D_SOUTHEAST:
	"the south-east"
    incase D_SOUTH:
	"the south"
    incase D_SOUTHWEST:
	"the south-west"
    incase D_WEST:
	"the west"
    incase D_NORTHWEST:
	"the north-west"
    incase D_UP:
	"above"
    incase D_DOWN:
	"below"
    incase D_ENTER:
	"the inside"
    incase D_EXIT:
	"the outside"
    default:
	""
    esac
corp;

define t_base proc utility public ExitName(int dir)string:
    case dir
    incase D_NORTH:
	"north"
    incase D_NORTHEAST:
	"northeast"
    incase D_EAST:
	"east"
    incase D_SOUTHEAST:
	"southeast"
    incase D_SOUTH:
	"south"
    incase D_SOUTHWEST:
	"southwest"
    incase D_WEST:
	"west"
    incase D_NORTHWEST:
	"northwest"
    incase D_UP:
	"up"
    incase D_DOWN:
	"down"
    incase D_ENTER:
	"in"
    incase D_EXIT:
	"out"
    default:
	""
    esac
corp;

define t_base proc utility public DirProp(int dir)property thing:
    case dir
    incase D_NORTH:
	p_rNorth
    incase D_NORTHEAST:
	p_rNorthEast
    incase D_EAST:
	p_rEast
    incase D_SOUTHEAST:
	p_rSouthEast
    incase D_SOUTH:
	p_rSouth
    incase D_SOUTHWEST:
	p_rSouthWest
    incase D_WEST:
	p_rWest
    incase D_NORTHWEST:
	p_rNorthWest
    incase D_UP:
	p_rUp
    incase D_DOWN:
	p_rDown
    incase D_ENTER:
	p_rEnter
    incase D_EXIT:
	p_rExit
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirProp' ***\n");
	p_rNorth
    esac
corp;

define t_base proc utility DirChecks(int dir)property list action:
    case dir
    incase D_NORTH:
	p_rNorthChecks
    incase D_NORTHEAST:
	p_rNorthEastChecks
    incase D_EAST:
	p_rEastChecks
    incase D_SOUTHEAST:
	p_rSouthEastChecks
    incase D_SOUTH:
	p_rSouthChecks
    incase D_SOUTHWEST:
	p_rSouthWestChecks
    incase D_WEST:
	p_rWestChecks
    incase D_NORTHWEST:
	p_rNorthWestChecks
    incase D_UP:
	p_rUpChecks
    incase D_DOWN:
	p_rDownChecks
    incase D_ENTER:
	p_rEnterChecks
    incase D_EXIT:
	p_rExitChecks
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirChecks' ***\n");
	p_rNorthChecks
    esac
corp;

define t_base proc utility public DirDesc(int dir)property string:
    case dir
    incase D_NORTH:
	p_rNorthDesc
    incase D_NORTHEAST:
	p_rNorthEastDesc
    incase D_EAST:
	p_rEastDesc
    incase D_SOUTHEAST:
	p_rSouthEastDesc
    incase D_SOUTH:
	p_rSouthDesc
    incase D_SOUTHWEST:
	p_rSouthWestDesc
    incase D_WEST:
	p_rWestDesc
    incase D_NORTHWEST:
	p_rNorthWestDesc
    incase D_UP:
	p_rUpDesc
    incase D_DOWN:
	p_rDownDesc
    incase D_ENTER:
	p_rEnterDesc
    incase D_EXIT:
	p_rExitDesc
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirDesc' ***\n");
	p_rNorthDesc
    esac
corp;

define t_base proc utility public DirMessage(int dir)property string:
    case dir
    incase D_NORTH:
	p_rNorthMessage
    incase D_NORTHEAST:
	p_rNorthEastMessage
    incase D_EAST:
	p_rEastMessage
    incase D_SOUTHEAST:
	p_rSouthEastMessage
    incase D_SOUTH:
	p_rSouthMessage
    incase D_SOUTHWEST:
	p_rSouthWestMessage
    incase D_WEST:
	p_rWestMessage
    incase D_NORTHWEST:
	p_rNorthWestMessage
    incase D_UP:
	p_rUpMessage
    incase D_DOWN:
	p_rDownMessage
    incase D_ENTER:
	p_rEnterMessage
    incase D_EXIT:
	p_rExitMessage
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirMessage' ***\n");
	p_rNorthMessage
    esac
corp;

define t_base proc utility public DirOMessage(int dir)property string:
    case dir
    incase D_NORTH:
	p_rNorthOMessage
    incase D_NORTHEAST:
	p_rNorthEastOMessage
    incase D_EAST:
	p_rEastOMessage
    incase D_SOUTHEAST:
	p_rSouthEastOMessage
    incase D_SOUTH:
	p_rSouthOMessage
    incase D_SOUTHWEST:
	p_rSouthWestOMessage
    incase D_WEST:
	p_rWestOMessage
    incase D_NORTHWEST:
	p_rNorthWestOMessage
    incase D_UP:
	p_rUpOMessage
    incase D_DOWN:
	p_rDownOMessage
    incase D_ENTER:
	p_rEnterOMessage
    incase D_EXIT:
	p_rExitOMessage
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirOMessage' ***\n");
	p_rNorthOMessage
    esac
corp;

define t_base proc utility public DirEMessage(int dir)property string:
    case dir
    incase D_NORTH:
	p_rNorthEMessage
    incase D_NORTHEAST:
	p_rNorthEastEMessage
    incase D_EAST:
	p_rEastEMessage
    incase D_SOUTHEAST:
	p_rSouthEastEMessage
    incase D_SOUTH:
	p_rSouthEMessage
    incase D_SOUTHWEST:
	p_rSouthWestEMessage
    incase D_WEST:
	p_rWestEMessage
    incase D_NORTHWEST:
	p_rNorthWestEMessage
    incase D_UP:
	p_rUpEMessage
    incase D_DOWN:
	p_rDownEMessage
    incase D_ENTER:
	p_rEnterEMessage
    incase D_EXIT:
	p_rExitEMessage
    default:
	Print("*** invalid direction number ");
	IPrint(dir);
	Print(" to 'DirEMessage' ***\n");
	p_rNorthEMessage
    esac
corp;

/*
 * DirMatch - turn a string into a direction number. Return -1 if the string
 *	is not a valid direction name.
 */

define t_base proc utility public DirMatch(string name)int:

    MatchName(
	"north,n.northeast,north-east,ne.east,e.southeast,south-east,se."
	"south,s.southwest,south-west,sw.west,w.northwest,north-west,nw."
	"up,u.down,d.enter,in,inside.exit,out,outside,leave", name)
corp;

/*
 * PairToDir - decode a character pair to a direction number.
 */

define t_base proc utility public PairToDir(string ch)int:

    if ch == "n " then
	D_NORTH
    elif ch == "ne" then
	D_NORTHEAST
    elif ch == "e " then
	D_EAST
    elif ch == "se" then
	D_SOUTHEAST
    elif ch == "s " then
	D_SOUTH
    elif ch == "sw" then
	D_SOUTHWEST
    elif ch == "w " then
	D_WEST
    elif ch == "nw" then
	D_NORTHWEST
    elif ch == "u " then
	D_UP
    elif ch == "d " then
	D_DOWN
    elif ch == "in" then
	D_ENTER
    elif ch == "ex" then
	D_EXIT
    else
	-1
    fi
corp;

/*
 * AddChecker - utility for adding checkers to checker lists.
 */

define tp_base proc utility AddChecker(thing th; property list action pla;
				       action a; bool front)void:
    list action la;

    la := th@pla;
    if la = nil then
	/* there was no list yet - create one */
	la := CreateActionList();
	th@pla := la;
	AddTail(la, a);
    else
	if front then
	    AddHead(la, a);
	else
	    AddTail(la, a);
	fi;
    fi;
corp;

/*
 * delChecker - utility for deleting checkers and removing the list if
 *	it is now empty.
 */

define tp_base proc utility delChecker(thing th; property list action pla;
				       action a)void:
    list action la;

    la := th@pla;
    if la ~= nil then
	DelElement(la, a);
	if Count(la) = 0 then
	    th -- pla;
	fi;
    fi;
corp;

/* Routines for adding direction checkers. Note that there could easily be
   routines to delete the checkers, but I don't believe there should be any
   checkers on rooms that need to be deleted. The checker can check some
   state somewhere to make its effects conditional. It is NOT a good idea
   to have to modify and write out rooms as people wander through them.
   Later: people want them via the build facilites, so I've added them. */

define t_base proc utility AddNorthChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rNorthChecks, a, front);
corp;

define t_base proc utility DelNorthChecker(thing room; action a)void:
    delChecker(room, p_rNorthChecks, a);
corp;

define t_base proc utility AddSouthChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rSouthChecks, a, front);
corp;

define t_base proc utility DelSouthChecker(thing room; action a)void:
    delChecker(room, p_rSouthChecks, a);
corp;

define t_base proc utility AddEastChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rEastChecks, a, front);
corp;

define t_base proc utility DelEastChecker(thing room; action a)void:
    delChecker(room, p_rEastChecks, a);
corp;

define t_base proc utility AddWestChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rWestChecks, a, front);
corp;

define t_base proc utility DelWestChecker(thing room; action a)void:
    delChecker(room, p_rWestChecks, a);
corp;

define t_base proc utility AddNorthEastChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rNorthEastChecks, a, front);
corp;

define t_base proc utility DelNorthEastChecker(thing room; action a)void:
    delChecker(room, p_rNorthEastChecks, a);
corp;

define t_base proc utility AddNorthWestChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rNorthWestChecks, a, front);
corp;

define t_base proc utility DelNorthWestChecker(thing room; action a)void:
    delChecker(room, p_rNorthWestChecks, a);
corp;

define t_base proc utility AddSouthEastChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rSouthEastChecks, a, front);
corp;

define t_base proc utility DelSouthEastChecker(thing room; action a)void:
    delChecker(room, p_rSouthEastChecks, a);
corp;

define t_base proc utility AddSouthWestChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rSouthWestChecks, a, front);
corp;

define t_base proc utility DelSouthWestChecker(thing room; action a)void:
    delChecker(room, p_rSouthWestChecks, a);
corp;

define t_base proc utility AddUpChecker(thing room; action a; bool front)void:
    AddChecker(room, p_rUpChecks, a, front);
corp;

define t_base proc utility DelUpChecker(thing room; action a)void:
    delChecker(room, p_rUpChecks, a);
corp;

define t_base proc utility AddDownChecker(thing room; action a;bool front)void:
    AddChecker(room, p_rDownChecks, a, front);
corp;

define t_base proc utility DelDownChecker(thing room; action a)void:
    delChecker(room, p_rDownChecks, a);
corp;

define t_base proc utility AddEnterChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rEnterChecks, a, front);
corp;

define t_base proc utility DelEnterChecker(thing room; action a)void:
    delChecker(room, p_rEnterChecks, a);
corp;

define t_base proc utility AddExitChecker(thing room; action a;bool front)void:
    AddChecker(room, p_rExitChecks, a, front);
corp;

define t_base proc utility DelExitChecker(thing room; action a)void:
    delChecker(room, p_rExitChecks, a);
corp;

define t_base proc utility AddDirChecker(thing room; int dir; action a;
	bool front)void:
    AddChecker(room, DirChecks(dir), a, false);
corp;

define t_base proc utility DelDirChecker(thing room; int dir; action a)void:
    delChecker(room, DirChecks(dir), a);
corp;

/* routines for inserting checkers in rooms for specific verbs */

define t_base proc utility AddAnyEnterChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rAnyEnterChecks, a, front);
corp;

define t_base proc utility DelAnyEnterChecker(thing room; action a)void:
    delChecker(room, p_rAnyEnterChecks, a);
corp;

define t_base proc utility AddAnyEnterAction(thing room; action a;
	bool front)void:
    AddChecker(room, p_rAnyEnterActions, a, front);
corp;

define t_base proc utility DelAnyEnterAction(thing room; action a)void:
    delChecker(room, p_rAnyEnterActions, a);
corp;

define t_base proc utility AddAnyLeaveChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rAnyLeaveChecks, a, front);
corp;

define t_base proc utility DelAnyLeaveChecker(thing room; action a)void:
    delChecker(room, p_rAnyLeaveChecks, a);
corp;

define t_base proc utility AddAnyLeaveAction(thing room; action a;
	bool front)void:
    AddChecker(room, p_rAnyLeaveActions, a, front);
corp;

define t_base proc utility DelAnyLeaveAction(thing room; action a)void:
    delChecker(room, p_rAnyLeaveActions, a);
corp;

define t_base proc utility AddRoomGetChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rGetChecks, a, front);
corp;

define t_base proc utility DelRoomGetChecker(thing room; action a)void:
    delChecker(room, p_rGetChecks, a);
corp;

define t_base proc utility AddRoomDropChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rDropChecks, a, front);
corp;

define t_base proc utility DelRoomDropChecker(thing room; action a)void:
    delChecker(room, p_rDropChecks, a);
corp;

define t_base proc utility AddRoomSayChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rSayChecks, a, front);
corp;

define t_base proc utility DelRoomSayChecker(thing room; action a)void:
    delChecker(room, p_rSayChecks, a);
corp;

define t_base proc utility AddRoomLookChecker(thing room; action a;
	bool front)void:
    AddChecker(room, p_rLookChecks, a, front);
corp;

define t_base proc utility DelRoomLookChecker(thing room; action a)void:
    delChecker(room, p_rLookChecks, a);
corp;

/* routines to add/delete checkers on players */

define t_base proc utility AddPlayerEnterChecker(thing player;
	action a; bool front)void:
    AddChecker(player, p_pEnterChecks, a, front);
corp;

define t_base proc utility DelPlayerEnterChecker(thing player; action a)void:
    delChecker(player, p_pEnterChecks, a);
corp;

define t_base proc utility AddPlayerLeaveChecker(thing player;
	action a; bool front)void:
    AddChecker(player, p_pLeaveChecks, a, front);
corp;

define t_base proc utility DelPlayerLeaveChecker(thing player; action a)void:
    delChecker(player, p_pLeaveChecks, a);
corp;

/* Some routines to actually do some special room checks. These are here
   so that the properties holding the checkers can be private */

define t_base proc utility DoDirChecks(thing room; int dir)status:
    DoChecks(room@DirChecks(dir))
corp;

define t_base proc utility DoRoomAnyEnterChecks(thing room)status:
    DoChecks(room@p_rAnyEnterChecks)
corp;

define t_base proc utility DoRoomAnyEnterActions(thing dest)void:
    DoThingActions(dest@p_rAnyEnterActions, dest);
corp;

define t_base proc utility DoRoomAnyLeaveChecks(thing room)status:
    DoChecks(room@p_rAnyLeaveChecks)
corp;

define t_base proc utility DoRoomAnyLeaveActions(thing here, dest)void:
    DoThingActions(here@p_rAnyLeaveActions, dest);
corp;

define t_base proc utility DoRoomSayChecks(thing room; string said)status:
    DoStringChecks(room@p_rSayChecks, said)
corp;

define t_base proc utility DoRoomLookChecks(thing room)status:
    DoChecks(room@p_rLookChecks)
corp;

define t_base proc utility DoRoomGetChecks(thing room, object)status:
    DoThingChecks(room@p_rGetChecks, object)
corp;

define t_base proc utility DoRoomDropChecks(thing room, object)status:
    DoThingChecks(room@p_rDropChecks, object)
corp;

/* routines to do some of the private player checks */

define t_base proc utility DoPlayerLeaveChecks(thing who; int dir)status:
    DoIntChecks(who@p_pLeaveChecks, dir)
corp;

define t_base proc utility DoPlayerEnterChecks(thing who)status:
    DoChecks(who@p_pEnterChecks)
corp;

/* This is used to allow creation of a carrying list on machines - it does
   it carefully. */

define t_base proc utility public SetupMachine(thing machine)void:

    if machine@p_pCarrying = nil then
	machine@p_pCarrying := CreateThingList();
    fi;
    if machine@p_pHiddenList = nil then
	machine@p_pHiddenList := CreateThingList();
    fi;
corp;

unuse tp_base
