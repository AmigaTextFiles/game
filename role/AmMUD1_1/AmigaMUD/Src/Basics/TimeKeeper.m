/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * TimerKeeper.m - code for the timerkeeper machine, used to do time-based
 *	activites for objects, and for startup activities.
 */

private tp_timekeeper CreateTable()$
use tp_timekeeper

/*
 * define a time and system activation service for objects.
 */

define tp_timekeeper TICK_TIME 60$

define tp_timekeeper TimeBase CreateThing(nil)$
define tp_timekeeper tb_first CreateThingProp()$
define tp_timekeeper tb_lastTime CreateIntProp()$
define tp_timekeeper tb_afterCount CreateIntProp()$
define tp_timekeeper tb_firstActive CreateThingProp()$

define tp_timekeeper tl_next CreateThingProp()$
define tp_timekeeper tl_delay CreateIntProp()$
define tp_timekeeper tl_object CreateThingProp()$
define tp_timekeeper tl_action CreateActionProp()$

define tp_timekeeper tb_objectTemp CreateThingProp()$
define tp_timekeeper tb_actionTemp CreateActionProp()$

TimeBase@tb_first := TimeBase$
TimeBase@tb_lastTime := Time()$
TimeBase@tb_afterCount := 0$
/* AfterCount is the number of active 'After's for the timer. There will
   be more than one if a new shorter interval arrives, and causes one to
   be triggered for a shorter interval than the other one(s). */
TimeBase@tb_firstActive := TimeBase$

CreateMachine("TimeKeeper", TimeBase, nil, nil)$

define tp_timekeeper proc callUserCode(thing object; action a)void:

    SetEffectiveTo(Owner(object));
    call(a, void)(object);
corp;

define tp_timekeeper proc timerStep()void:
    int last, now, delta;
    thing tl, object;
    action a;

    TimeBase@tb_afterCount := TimeBase@tb_afterCount - 1;
    last := TimeBase@tb_lastTime;
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
	object := tl@tl_object;
	a := tl@tl_action;
	/* Keep pointers so the call is OK! */
	TimeBase@tb_objectTemp := object;
	TimeBase@tb_actionTemp := a;
	/* This assignment will destroy the 'tl' object. */
	TimeBase@tb_first := tl@tl_next;
	/* Do the call after we have deleted this record. */
	callUserCode(object, a);
	/* This may free them. */
	TimeBase -- tb_objectTemp;
	TimeBase -- tb_actionTemp;
    od;
    if TimeBase@tb_afterCount = 0 then
	tl := TimeBase@tb_first;
	if tl ~= TimeBase and tl@tl_delay < TICK_TIME then
	    delta := tl@tl_delay;
	else
	    delta := TICK_TIME;
	fi;
	TimeBase@tb_afterCount := 1;
	After(IntToFixed(delta), timerStep);
    fi;
corp;

define tp_timekeeper proc timerActive()void:
    thing tl,object;
    action a;
    int delta;

    while
	tl := TimeBase@tb_firstActive;
	tl ~= TimeBase
    do
	object := tl@tl_object;
	a := tl@tl_action;
	TimeBase@tb_objectTemp := object;
	TimeBase@tb_actionTemp := a;
	TimeBase@tb_firstActive := tl@tl_next;
	callUserCode(object, a);
	TimeBase -- tb_objectTemp;
	TimeBase -- tb_actionTemp;
    od;

    TimeBase@tb_afterCount := 1;	/* all cases need this */
    TimeBase@tb_lastTime := Time();

    tl := TimeBase@tb_first;
    if tl ~= TimeBase then
	if tl@tl_delay <= 0 then
	    /* timerStep will decrement, then re-increment, afterCount */
	    timerStep();
	else
	    delta := tl@tl_delay;
	    if delta > TICK_TIME then
		delta := TICK_TIME;
	    fi;
	    After(IntToFixed(delta), timerStep);
	fi;
    else
	After(IntToFixed(TICK_TIME), timerStep);
    fi;
corp;

ignore SetMachineActive(TimeBase, timerActive)$

define tp_timekeeper proc timerSet()status:
    int delay;

    delay := TimeBase@tb_first@tl_delay;
    if delay > TICK_TIME then
	delay := TICK_TIME;
    fi;
    After(IntToFixed(delay), timerStep);
    /* increment counter - we have triggered another 'After' */
    TimeBase@tb_afterCount := TimeBase@tb_afterCount + 1;
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
	true
    else
	while
	    next := tl@tl_next;
	    next ~= TimeBase and
		(next@tl_object ~= object or next@tl_action ~= a)
	do
	    tl := next;
	od;
	if next = TimeBase then
	    false
	else
	    tl@tl_next := next@tl_next;
	    true
	fi
    fi
corp;

/*
 * CancelAllDoAfters - cancel all timer calls for this object. This is
 *	typically done when the object is being destroyed.
 */

define t_base proc CancelAllDoAfters(thing object)void:
    thing prev, tl, next;

    prev := TimeBase;
    tl := TimeBase@tb_first;
    while tl ~= TimeBase do
	next := tl@tl_next;
	if tl@tl_object = object then
	    if prev ~= TimeBase then
		prev@tl_next := next;
	    else
		TimeBase@tb_first := next;
	    fi;
	else
	    prev := tl;
	fi;
	tl := next;
    od;
corp;

/*
 * RegisterActiveAction - register an action and object that is to be called
 *	when the server starts up. This facility is most often used to
 *	try to handle the situation of bringing up a database that was
 *	produced by a backup done while the server is active, and thus
 *	the 'idle' actions on the characters and machines have not been
 *	called. This technique is not perfect, but hopefully it helps.
 */

define t_base proc RegisterActiveAction(thing object; action a)void:
    thing tlNew;

    if object = nil then
	Print("object = nil in RegisterActiveAction\n");
    elif a = nil then
	Print("action = nil in RegisterActiveAction\n");
    else
	tlNew := CreateThing(nil);
	tlNew@tl_object := object;
	tlNew@tl_action := a;
	tlNew@tl_next := TimeBase@tb_firstActive;
	TimeBase@tb_firstActive := tlNew;
    fi;
corp;

/*
 * RemoveActiveAction - cancel an action setup by RegisterActiveAction.
 *	Return 'false' if no matching event found, else return 'true'.
 */

define t_base proc RemoveActiveAction(thing object; action a)bool:
    thing tl, next;

    tl := TimeBase@tb_firstActive;
    if tl = TimeBase then
	false
    elif tl@tl_object = object and tl@tl_action = a then
	TimeBase@tb_firstActive := tl@tl_next;
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
	    true
	fi
    fi
corp;

define tp_timekeeper proc timerStart()status:

    After(IntToFixed(TICK_TIME), timerStep);
    TimeBase@tb_afterCount := 1;
    continue
corp;

ignore ForceAction(TimeBase, timerStart)$

unuse tp_timekeeper
