/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * monsters.m - define some monster classes and monsters.
 */

private tp_monsters CreateTable().
use tp_monsters

/* a move routine for a simple random moving monster */

/*
 * RandomMove - used for dumb monsters which just wander around.
 */

define t_monsters proc public RandomMove()void:
    thing me;
    int n;
    action a;

    me := Me();
    if MonsterStillMoving(me, nil) then
	a := me@p_mSpecialAction;
	if a ~= nil then
	    if not call(a, bool)() then
		/* something special - give it a new lease on life */
		me@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE + 1;
		MonsterReschedule(me);
	    fi;
	else
	    DoMonsterMove(me);
	    MonsterReschedule(me);
	fi;
    fi;
corp;

/* set up monsters which will pick up and use stuff */

define t_monsters proc public MonsterPickUp()void:
    list thing lt;
    int count, i, carryCount, n;
    thing here, me, th, old;

    me := Me();
    here := Here();
    lt := here@p_rContents;
    count := Count(lt);
    carryCount := Count(me@p_pCarrying);
    i := 0;
    while i < count and carryCount < MAX_CARRY do
	th := lt[i];
	if not th@p_oInvisible and not th@p_oNotGettable then
	    if DoGet(here, me, th) ~= continue then
		/* something wrong - quit trying to get things */
		i := count;
	    else
		count := count - 1;
		carryCount := carryCount + 1;
		n := th@p_oArmourProt;
		old := me@p_pArmour;
		if old = nil and n ~= 0 or
		    old ~= nil and n < old@p_oArmourProt
		then
		    SetIt(th);
		    ignore call(th@p_oWearChecker, status)();
		    /* make him live forever */
		    me@p_mMovesUntilVanish := FOREVER_LIFE;
		else
		    n := th@p_oShieldProt;
		    old := me@p_pShield;
		    if old = nil and n ~= 0 or
			old ~= nil and n < old@p_oShieldProt
		    then
			SetIt(th);
			ignore call(th@p_oUseChecker, status)();
			me@p_mMovesUntilVanish := FOREVER_LIFE;
		    else
			n := th@p_oDamage;
			old := me@p_pWeapon;
			if old = nil and n ~= 0 or
			    old ~= nil and n > old@p_oDamage
			then
			    SetIt(th);
			    ignore call(th@p_oWieldChecker, status)();
			    me@p_mMovesUntilVanish := FOREVER_LIFE;
			fi;
		    fi;
		fi;
	    fi;
	else
	    i := i + 1;
	fi;
    od;
corp;

/* set up trackers */

define t_monsters p_mTrackerPath CreateIntListProp().
define t_monsters p_pTrackerList CreateThingListProp().

/*
 * TrackerDieNotify - called when a player with trackers dies. Return 'true'
 *	to indicate that we want to be removed from the notify list.
 */

define t_monsters proc TrackerDieNotify(thing thePlayer)bool:
    list thing trackers;
    int count;
    thing tracker;
    list int path;

    trackers := thePlayer@p_pTrackerList;
    count := Count(trackers);
    while count ~= 0 do
	count := count - 1;
	tracker := trackers[count];
	tracker -- p_mTrackerPath;
	RemTail(trackers);
    od;
    true
corp

/*
 * TrackerChecker - a player leave checker that records the direction on all
 *	following trackers
 */

define t_monsters proc TrackerChecker(int dir)status:
    list thing lt;
    int count, n, dirCount;
    thing me, tracker;
    list int li;

    me := Me();
    lt := me@p_pTrackerList;
    if lt = nil then
	DelPlayerLeaveChecker(me, TrackerChecker);
	DelElement(me@p_pDieNotifyList, TrackerDieNotify);
    else
	count := Count(lt);
	if count ~= 0 then
	    n := 0;
	    while n ~= count do
		tracker := lt[n];
		if tracker@p_mExpired then
		    DelElement(lt, tracker);
		    DestroyMachine(tracker);
		    count := count - 1;
		else
		    li := tracker@p_mTrackerPath;
		    if li = nil then
			li := CreateIntList();
			tracker@p_mTrackerPath := li;
			dirCount := 0;
		    else
			dirCount := Count(li);
		    fi;
		    if dirCount ~= 0 and li[dirCount - 1] = DirBack(dir) then
			/* two directions cancel out */
			RemTail(li);
		    else
			AddTail(li, dir);
		    fi;
		    n := n + 1;
		fi;
	    od;
	fi;
	if count = 0 then
	    me -- p_pTrackerList;
	    DelPlayerLeaveChecker(me, TrackerChecker);
	    DelElement(me@p_pDieNotifyList, TrackerDieNotify);
	fi;
    fi;
    continue
corp;

/*
 * TrackerDie - a die action for trackers, as called by MonsterStillMoving
 */

define t_monsters proc TrackerDie(thing me)void:
    list thing lt;
    thing target;

    target := me@p_pCurrentTarget;
    if target ~= nil then
	lt := target@p_pTrackerList;
	if lt ~= nil and FindElement(lt, me) ~= -1 then
	    DelElement(lt, me);
	    if Count(lt) = 0 then
		target -- p_pTrackerList;
		DelPlayerLeaveChecker(target, TrackerChecker);
		DelElement(target@p_pDieNotifyList, TrackerDieNotify);
	    fi;
	fi;
    fi;
corp;

/*
 * TrackerKill - routine to do extra stuff when a tracker is killed.
 *	NOTE: this should be attached to each model of a tracker.
 */

define t_monsters proc TrackerKill(thing me)bool:

    TrackerDie(me);
    KillMonster(me);
    DestroyMachine(me);
    false
corp;

/*
 * TrackerInit - extra init stuff for a tracker.
 */

define t_monsters proc TrackerInit()void:
    thing me, thePlayer;
    list thing trackers;

    me := Me();
    if me@p_mKillAction = nil then
	/* should be on the model, but if not... */
	me@p_mKillAction := TrackerKill;
    fi;
    MonsterInit();
    thePlayer := me@p_pCurrentTarget;
    trackers := thePlayer@p_pTrackerList;
    if trackers = nil then
	trackers := CreateThingList();
	thePlayer@p_pTrackerList := trackers;
	AddPlayerLeaveChecker(thePlayer, TrackerChecker, false);
	AddTail(thePlayer@p_pDieNotifyList, TrackerDieNotify);
    fi;
    AddTail(trackers, me);
corp;

/*
 * TrackerMove - a tracker moves a single step, hopefully on the path
 *	following the target.
 */

define t_monsters proc TrackerMove()void:
    thing me, target, here;
    list int li;
    int dir, count;
    bool followed;

    me := Me();
    here := Here();
    li := me@p_mTrackerPath;
    if li = nil then
	count := 0;
    else
	count := Count(li);
    fi;
    target := me@p_pCurrentTarget;
    if AgentLocation(target) = here then
	ignore MonsterHitPlayer(me, target, here);
	me@p_mTrackerPath := CreateIntList();
	MonsterReschedule(me);
    else
	followed := false;
	if count ~= 0 then
	    dir := li[0];
	    RemHead(li);
	    if MonsterMove(me, dir) then
		followed := true;
	    else
		/* rats! can't follow */
		me -- p_mTrackerPath;
	    fi;
	fi;
	if not followed then
	    /* where did he go, where did he go? */
	    if not MonsterMove(me, Random(12)) then
		if MonsterStillMoving(me, TrackerDie) then
		    MonsterAction(me);
		    MonsterReschedule(me);
		fi;
	    else
		MonsterReschedule(me);
	    fi;
	else
	    MonsterReschedule(me);
	fi;
    fi;
corp;

/* define some "standard" monsters.
   Note: numerics: hitpoints, speed, protection, accuracy, damage, gold */

define t_monsters m_rat CreateMonsterModel("rat",
    "The rat is of average size, and, like most rats, is quite filthy.",
    MonsterInit, RandomMove,
    2, 6, 9, 5, 2, 0).
AddModelAction(m_rat, "runs around").
AddModelAction(m_rat, "chitters").
AddModelAction(m_rat, "squeals").

define t_monsters m_snake CreateMonsterModel("snake",
    "The snake isn't poisonous, but bites pretty well. It has no "
    "distinguishing markings.",
    MonsterInit, RandomMove,
    4, 8, 9, 5, 2, 0).
AddModelAction(m_snake, "slithers around").
AddModelAction(m_snake, "hisses").
AddModelAction(m_snake, "coils and uncoils").

define t_monsters m_dog CreateMonsterModel("dog;wild", "",
    MonsterInit, RandomMove,
    6, 5, 9, 5, 3, 0).
m_dog@p_mBlocker := true.
AddModelAction(m_dog, "runs around").
AddModelAction(m_dog, "barks").
AddModelAction(m_dog, "growls").
AddModelAction(m_dog, "snarls").

define t_monsters m_gremlin CreateMonsterModel("gremlin;nasty",
    "The gremlin, like all of its kind, is quite dirty. It also comes "
    "equipped with sharp teeth and claws.",
    MonsterInit, RandomMove,
    5, 5, 9, 5, 3, 15).
AddModelAction(m_gremlin, "runs in circles around you").
AddModelAction(m_gremlin, "shrieks loudly").
AddModelAction(m_gremlin, "curses").
AddModelAction(m_gremlin, "picks its nose").
AddModelAction(m_gremlin, "thumbs its nose").
AddModelAction(m_gremlin, "spits at you").

/* and now some bigger stuff for forests, etc. */

define t_monsters m_wolf CreateMonsterModel("wolf", "",
    MonsterInit, RandomMove,
    10, 5, 9, 7, 6, 0).
m_wolf@p_mBlocker := true.
AddModelAction(m_wolf, "runs around").
AddModelAction(m_wolf, "snarls").
AddModelAction(m_wolf, "howls").

define t_monsters m_troll CreateMonsterModel("troll", "",
    MonsterInit, RandomMove,
    13, 4, 8, 6, 6, 40).
m_troll@p_mBlocker := true.
AddModelAction(m_troll, "lumbers around").
AddModelAction(m_troll, "bellows").
AddModelAction(m_troll, "raises its fists and roars").

define t_monsters m_blackBear CreateMonsterModel("bear;black", "",
    MonsterInit, RandomMove,
    15, 5, 8, 6, 6, 0).
m_blackBear@p_mBlocker := true.
AddModelAction(m_blackBear, "lumbers around").
AddModelAction(m_blackBear, "roars").
AddModelAction(m_blackBear, "stands upright and waves its paws").

define t_monsters m_deer CreateMonsterModel("deer;mule", "",
    MonsterInit, RandomMove,
    8, 7, 9, 0, 0, 0).
AddModelAction(m_deer, "leaps around").
AddModelAction(m_deer, "screams silently").
AddModelAction(m_deer, "snorts").
define tp_monsters proc deerArrivalCheck(thing theDeer, theArrival)void:

    if IsAncestor(theArrival, m_wolf) or IsAncestor(theArrival, m_troll) then
	RunAway(theDeer);
    fi;
corp;
m_deer@p_mArriveAction := deerArrivalCheck.
define tp_monsters proc deerCreationCheck(thing theDeer, theNew)void:

    if IsAncestor(theNew, m_wolf) or IsAncestor(theNew, m_troll) then
	RunAway(theDeer);
    fi;
corp;
m_deer@p_mCreateAction := deerCreationCheck.
define tp_monsters proc deerArrivedCheck()void:
    thing here;

    here := Here();
    if FindAgentAsDescendant(here, m_wolf) ~= nil or
	FindAgentAsDescendant(here, m_troll) ~= nil
    then
	ignore RunAwaySoon();
    fi;
corp;
m_deer@p_mArrivedAction := deerArrivedCheck.

define t_monsters m_moose CreateMonsterModel("moose", "",
    MonsterInit, RandomMove,
    18, 4, 7, 6, 4, 0).
m_moose@p_mBlocker := true.
AddModelAction(m_moose, "wades around").
AddModelAction(m_moose, "snorts").
AddModelAction(m_moose, "bellows").

/* larger stuff for the sewers */

define t_monsters m_largeRat CreateMonsterModel("rat;large",
    "The rat is of above average size and is quite filthy.",
    MonsterInit, RandomMove,
    4, 6, 9, 5, 4, 0).
AddModelAction(m_largeRat, "runs around").
AddModelAction(m_largeRat, "chitters loudly").
AddModelAction(m_largeRat, "squeals loudly").

define t_monsters m_largeSnake CreateMonsterModel("snake;large",
    "The snake isn't poisonous, but bites pretty well. It has pretty "
    "red and yellow stripes running down its length.",
    MonsterInit, RandomMove,
    8, 8, 9, 5, 4, 0).
AddModelAction(m_largeSnake, "slithers around").
AddModelAction(m_largeSnake, "hisses").
AddModelAction(m_largeSnake, "coils and uncoils").

define t_monsters m_goblin CreateMonsterModel("goblin",
    "The goblin is a small, humanoid creature with pale skin, large eyes, "
    "protruding ears, and sharp teeth. It walks in a perpetual crouch but "
    "is nonetheless quite fast on its feet.",
    MonsterInit, RandomMove,
    10, 8, 9, 6, 5, 30).
m_goblin@p_mBlocker := true.
AddModelAction(m_goblin, "slouches around").
AddModelAction(m_goblin, "gibbers").
AddModelAction(m_goblin, "drools").
AddModelAction(m_goblin, "howls").
m_goblin@p_mAfterMoveAction := MonsterPickUp.

define t_monsters m_hugeRat CreateMonsterModel("rat;huge",
    "The rat is quite large, but not totally filthy.",
    MonsterInit, RandomMove,
    8, 6, 10, 5, 8, 0).
m_hugeRat@p_mBlocker := true.
AddModelAction(m_hugeRat, "runs around").
AddModelAction(m_hugeRat, "chitters loudly").
AddModelAction(m_hugeRat, "squeals loudly").

define t_monsters m_hugeSnake CreateMonsterModel("snake;huge",
    "The snake isn't poisonous, but bites pretty well. It has a very striking "
    "checkerboard pattern.",
    MonsterInit, RandomMove,
    16, 8, 10, 5, 8, 0).
m_hugeSnake@p_mBlocker := true.
AddModelAction(m_hugeSnake, "slithers around").
AddModelAction(m_hugeSnake, "hisses").
AddModelAction(m_hugeSnake, "coils and uncoils").

define t_monsters m_fighterGoblin CreateMonsterModel("goblin;fighter",
    "The goblin is a small, humanoid creature with pale skin, large eyes, "
    "protruding ears, and sharp teeth. It walks in a perpetual crouch but "
    "is nonetheless quite fast on its feet.",
    MonsterInit, RandomMove,
    20, 8, 10, 6, 10, 50).
m_fighterGoblin@p_mBlocker := true.
AddModelAction(m_fighterGoblin, "slouches around").
AddModelAction(m_fighterGoblin, "gibbers").
AddModelAction(m_fighterGoblin, "drools").
AddModelAction(m_fighterGoblin, "howls").
m_fighterGoblin@p_mAfterMoveAction := MonsterPickUp.

define t_monsters m_hugeSpider CreateMonsterModel("spider;huge",
    "The spider's body is almost as large as yours, and it's long legs give "
    "it good mobility and a long reach.",
    MonsterInit, RandomMove,
    16, 12, 15, 8, 12, 0).
m_hugeSpider@p_mBlocker := true.
AddModelAction(m_hugeSpider, "dances around").
AddModelAction(m_hugeSpider, "clashes its fangs").
AddModelAction(m_hugeSpider, "drips saliva").
AddModelAction(m_hugeSpider, "waves its front legs menacingly").

define t_monsters m_trackerSpider CreateMonsterModel("spider;tracker",
    "The spider's body is almost as large as yours, and it's long legs give "
    "it good mobility and a long reach.",
    TrackerInit, TrackerMove,
    16, 12, 15, 8, 12, 0).
m_trackerSpider@p_mBlocker := true.
m_trackerSpider@p_mKillAction := TrackerKill.
AddModelAction(m_trackerSpider, "dances around").
AddModelAction(m_trackerSpider, "clashes its fangs").
AddModelAction(m_trackerSpider, "drips saliva").
AddModelAction(m_trackerSpider, "waves its front legs menacingly").

define t_monsters m_largeTroll CreateMonsterModel("troll;large", "",
    MonsterInit, RandomMove,
    26, 4, 7, 6, 12, 80).
m_troll@p_mBlocker := true.
AddModelAction(m_troll, "lumbers around").
AddModelAction(m_troll, "bellows").
AddModelAction(m_troll, "raises its fists and roars").

unuse tp_monsters
