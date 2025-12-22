/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * monsters.m - define some monster classes and monsters.
 */

private tp_monsters CreateTable()$
use tp_monsters

/* a move routine for a simple random moving monster */

/*
 * RandomMove - used for dumb monsters which just wander around.
 */

define t_monsters proc public RandomMove()void:
    thing theMonster;
    int n;
    action a;

    theMonster := Me();
    if MonsterStillMoving(theMonster, nil) then
	a := theMonster@p_mSpecialAction;
	if a ~= nil then
	    if not call(a, bool)() then
		/* something special - give it a new lease on life */
		if theMonster@p_mMovesUntilVanish ~= FOREVER_LIFE then
		    theMonster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
		fi;
		MonsterReschedule(theMonster);
	    fi;
	else
	    DoMonsterMove(theMonster);
	    MonsterReschedule(theMonster);
	fi;
    fi;
corp;

/* set up trackers */

/*
 * TrackerDieNotify - called when a player with trackers dies. Return 'true'
 *	to indicate that we want to be removed from the notify list.
 */

define t_monsters proc TrackerDieNotify(thing thePlayer)bool:
    list thing trackers;
    int count;
    list int path;

    trackers := thePlayer@p_pTrackerList;
    count := Count(trackers);
    while count ~= 0 do
	count := count - 1;
	trackers[count] -- p_mTrackerPath;
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
    thing thePlayer, theTracker;
    list int li;

    thePlayer := Me();
    lt := thePlayer@p_pTrackerList;
    if lt = nil then
	DelPlayerLeaveChecker(thePlayer, TrackerChecker);
	DelElement(thePlayer@p_pDieNotifyList, TrackerDieNotify);
    else
	count := Count(lt);
	if count ~= 0 then
	    n := 0;
	    while n ~= count do
		theTracker := lt[n];
		if theTracker@p_mExpired then
		    DelElement(lt, theTracker);
		    DestroyMachine(theTracker);
		    count := count - 1;
		else
		    li := theTracker@p_mTrackerPath;
		    if li = nil then
			li := CreateIntList();
			theTracker@p_mTrackerPath := li;
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
	    thePlayer -- p_pTrackerList;
	    DelPlayerLeaveChecker(thePlayer, TrackerChecker);
	    DelElement(thePlayer@p_pDieNotifyList, TrackerDieNotify);
	fi;
    fi;
    continue
corp;

/*
 * TrackerDie - a die action for trackers, as called by MonsterStillMoving
 */

define t_monsters proc TrackerDie(thing theTracker)void:
    list thing lt;
    thing theTarget;

    theTarget := theTracker@p_pCurrentTarget;
    if theTarget ~= nil then
	lt := theTarget@p_pTrackerList;
	if lt ~= nil and FindElement(lt, theTracker) ~= -1 then
	    DelElement(lt, theTracker);
	    if Count(lt) = 0 then
		theTarget -- p_pTrackerList;
		DelPlayerLeaveChecker(theTarget, TrackerChecker);
		DelElement(theTarget@p_pDieNotifyList, TrackerDieNotify);
	    fi;
	fi;
    fi;
corp;

/*
 * TrackerKill - routine to do extra stuff when a tracker is killed.
 *	NOTE: this should be attached to each model of a tracker.
 */

define t_monsters proc TrackerKill(thing thePlayer, theMonster)bool:
    int hitsLeft;

    hitsLeft := theMonster@p_pHitNow;
    TrackerDie(theMonster);
    KillMonster(theMonster);
    DestroyMachine(theMonster);
    AddExperience(thePlayer, hitsLeft);
    false
corp;

/*
 * TrackerInit - extra init stuff for a tracker.
 */

define t_monsters proc TrackerInit()void:
    thing theMonster, thePlayer;
    list thing trackers;

    theMonster := Me();
    if theMonster@p_mKillAction = nil then
	/* should be on the model, but if not... */
	theMonster@p_mKillAction := TrackerKill;
    fi;
    MonsterInit();
    thePlayer := theMonster@p_pCurrentTarget;
    trackers := thePlayer@p_pTrackerList;
    if trackers = nil then
	trackers := CreateThingList();
	thePlayer@p_pTrackerList := trackers;
	AddPlayerLeaveChecker(thePlayer, TrackerChecker, false);
	AddTail(thePlayer@p_pDieNotifyList, TrackerDieNotify);
    fi;
    AddTail(trackers, theMonster);
corp;

/*
 * TrackerMove - a tracker moves a single step, hopefully on the path
 *	following the target.
 */

define t_monsters proc TrackerMove()void:
    thing theMonster, theTarget, here;
    list int li;
    int dir, count;
    bool followed;

    theMonster := Me();
    here := Here();
    li := theMonster@p_mTrackerPath;
    if li = nil then
	count := 0;
    else
	count := Count(li);
    fi;
    theTarget := theMonster@p_pCurrentTarget;
    if AgentLocation(theTarget) = here then
	ignore MonsterHitPlayer(theMonster, theTarget, here);
	theMonster@p_mTrackerPath := CreateIntList();
	MonsterReschedule(theMonster);
    else
	followed := false;
	if count ~= 0 then
	    dir := li[0];
	    RemHead(li);
	    if MonsterMove(theMonster, dir) then
		followed := true;
	    else
		/* rats! can't follow */
		theMonster -- p_mTrackerPath;
	    fi;
	fi;
	if not followed then
	    /* where did he go, where did he go? */
	    if not MonsterMove(theMonster, Random(12)) then
		if MonsterStillMoving(theMonster, TrackerDie) then
		    MonsterAction(theMonster);
		    MonsterReschedule(theMonster);
		fi;
	    else
		MonsterReschedule(theMonster);
	    fi;
	else
	    MonsterReschedule(theMonster);
	fi;
    fi;
corp;

/* define some "standard" monsters.
   Note: numerics: hitpoints, speed, protection, accuracy, damage, gold */

define t_monsters m_rat CreateMonsterModel("rat",
    "The rat is of average size, and, like most rats, is quite filthy.",
    MonsterInit, RandomMove,
    2, 6, 9, 5, 2, 0)$
AddModelAction(m_rat, "runs around")$
AddModelAction(m_rat, "chitters")$
AddModelAction(m_rat, "squeals")$
m_rat@p_Image := "Characters/rat"$
m_rat@p_mSound := "rat"$
GNewIcon(m_rat, makeRatIcon())$

define t_monsters m_snake CreateMonsterModel("snake,snak,sna",
    "The snake isn't poisonous, but bites pretty well. It has no "
    "distinguishing markings.",
    MonsterInit, RandomMove,
    4, 8, 9, 5, 2, 0)$
AddModelAction(m_snake, "slithers around")$
AddModelAction(m_snake, "hisses")$
AddModelAction(m_snake, "coils and uncoils")$
m_snake@p_Image := "Characters/snake"$
m_snake@p_mSound := "snake-hiss"$
GNewIcon(m_snake, makeSnakeIcon())$

define t_monsters m_dog CreateMonsterModel("dog;wild", "",
    MonsterInit, RandomMove,
    6, 5, 9, 5, 4, 0)$
m_dog@p_mBlocker := true$
AddModelAction(m_dog, "runs around")$
AddModelAction(m_dog, "barks")$
AddModelAction(m_dog, "growls")$
AddModelAction(m_dog, "snarls")$
m_dog@p_Image := "Characters/dog"$
m_dog@p_mSound := "dog-growl"$
GNewIcon(m_dog, makeDogIcon())$

define t_monsters m_gremlin CreateMonsterModel("gremlin,gre,grem;nasty",
    "The gremlin, like all of its kind, is quite dirty. It also comes "
    "equipped with sharp teeth and claws.",
    MonsterInit, RandomMove,
    5, 5, 9, 5, 4, 15)$
AddModelAction(m_gremlin, "runs in circles around you")$
AddModelAction(m_gremlin, "shrieks loudly")$
AddModelAction(m_gremlin, "curses")$
AddModelAction(m_gremlin, "picks its nose")$
AddModelAction(m_gremlin, "thumbs its nose")$
AddModelAction(m_gremlin, "spits at you")$
MakeMonsterSmart(m_gremlin)$
m_gremlin@p_Image := "Characters/gremlin"$
m_gremlin@p_mSound := "gremlin"$
GNewIcon(m_gremlin, makeGremlinIcon())$

/* and now some bigger stuff for forests, etc. */

define t_monsters m_wolf CreateMonsterModel("wolf,wol,wuf,wolve", "",
    MonsterInit, RandomMove,
    10, 5, 9, 7, 6, 0)$
m_wolf@p_mBlocker := true$
AddModelAction(m_wolf, "runs around")$
AddModelAction(m_wolf, "snarls")$
AddModelAction(m_wolf, "howls")$
m_wolf@p_Image := "Characters/wolf"$
m_wolf@p_mSound := "wolf"$
GNewIcon(m_wolf, makeWolfIcon())$

define t_monsters m_troll CreateMonsterModel("troll,tro", "",
    MonsterInit, RandomMove,
    13, 4, 8, 6, 7, 40)$
m_troll@p_mBlocker := true$
AddModelAction(m_troll, "lumbers around")$
AddModelAction(m_troll, "bellows")$
AddModelAction(m_troll, "raises its fists and roars")$
m_troll@p_Image := "Characters/troll"$
m_troll@p_mSound := "troll"$
GNewIcon(m_troll, makeTrollIcon())$

define t_monsters m_blackBear CreateMonsterModel("bear,bea,beer;black", "",
    MonsterInit, RandomMove,
    15, 5, 8, 6, 7, 0)$
m_blackBear@p_mBlocker := true$
AddModelAction(m_blackBear, "lumbers around")$
AddModelAction(m_blackBear, "roars")$
AddModelAction(m_blackBear, "stands upright and waves its paws")$
m_blackBear@p_Image := "Characters/blackBear"$
m_blackBear@p_mSound := "blackBear"$
GNewIcon(m_blackBear, makeBearIcon())$

define t_monsters m_deer CreateMonsterModel("deer,dee,dear;mule", "",
    MonsterInit, RandomMove,
    8, 7, 9, 0, 0, 0)$
AddModelAction(m_deer, "leaps around")$
AddModelAction(m_deer, "screams silently")$
AddModelAction(m_deer, "snorts")$
define tp_monsters proc deerArrivalCheck(thing theDeer, theArrival)void:

    if IsAncestor(theArrival, m_wolf) or IsAncestor(theArrival, m_troll) then
	RunAway(theDeer);
    fi;
corp;
m_deer@p_mArriveAction := deerArrivalCheck$
define tp_monsters proc deerCreationCheck(thing theDeer, theNew)void:

    if IsAncestor(theNew, m_wolf) or IsAncestor(theNew, m_troll) then
	RunAway(theDeer);
    fi;
corp;
m_deer@p_mCreateAction := deerCreationCheck$
define tp_monsters proc deerArrivedCheck()void:
    thing here;

    here := Here();
    if FindAgentAsDescendant(here, m_wolf) ~= nil or
	FindAgentAsDescendant(here, m_troll) ~= nil
    then
	ignore RunAwaySoon();
    fi;
corp;
m_deer@p_mArrivedAction := deerArrivedCheck$
m_deer@p_Image := "Characters/deer"$
m_deer@p_mSound := "deer"$
GNewIcon(m_deer, makeDeerIcon())$

define t_monsters m_moose CreateMonsterModel("moose,moo", "",
    MonsterInit, RandomMove,
    18, 4, 7, 6, 7, 0)$
m_moose@p_mBlocker := true$
AddModelAction(m_moose, "wades around")$
AddModelAction(m_moose, "snorts")$
AddModelAction(m_moose, "bellows")$
m_moose@p_Image := "Characters/moose"$
m_moose@p_mSound := "moose"$
GNewIcon(m_moose, makeMooseIcon())$

/* larger stuff for the sewers */

define t_monsters m_largeRat CreateMonsterModel("rat;large",
    "The rat is of above average size and is quite filthy.",
    MonsterInit, RandomMove,
    4, 6, 9, 5, 4, 0)$
AddModelAction(m_largeRat, "runs around")$
AddModelAction(m_largeRat, "chitters loudly")$
AddModelAction(m_largeRat, "squeals loudly")$
m_largeRat@p_Image := "Characters/largeRat"$
m_largeRat@p_mSound := "largeRat"$
GNewIcon(m_largeRat, makeRatIcon())$

define t_monsters m_largeSnake CreateMonsterModel("snake,snak,sna;large",
    "The snake isn't poisonous, but bites pretty well. It has pretty "
    "red and yellow stripes running down its length.",
    MonsterInit, RandomMove,
    8, 8, 9, 5, 4, 0)$
AddModelAction(m_largeSnake, "slithers around")$
AddModelAction(m_largeSnake, "hisses")$
AddModelAction(m_largeSnake, "coils and uncoils")$
m_largeSnake@p_Image := "Characters/largeSnake"$
m_largeSnake@p_mSound := "largeSnake"$
GNewIcon(m_largeSnake, makeSnakeIcon())$

define t_monsters m_goblin CreateMonsterModel("goblin,gob",
    "The goblin is a small, humanoid creature with pale skin, large eyes, "
    "protruding ears, and sharp teeth. It walks in a perpetual crouch but "
    "is nonetheless quite fast on its feet.",
    MonsterInit, RandomMove,
    10, 8, 9, 6, 5, 30)$
m_goblin@p_mBlocker := true$
AddModelAction(m_goblin, "slouches around")$
AddModelAction(m_goblin, "gibbers")$
AddModelAction(m_goblin, "drools")$
AddModelAction(m_goblin, "howls")$
MakeMonsterSmart(m_goblin)$
m_goblin@p_Image := "Characters/goblin"$
m_goblin@p_mSound := "goblin"$
GNewIcon(m_goblin, makeGoblinIcon())$

define t_monsters m_hugeRat CreateMonsterModel("rat;huge",
    "The rat is quite large, but not totally filthy.",
    MonsterInit, RandomMove,
    8, 6, 10, 5, 8, 0)$
m_hugeRat@p_mBlocker := true$
AddModelAction(m_hugeRat, "runs around")$
AddModelAction(m_hugeRat, "chitters loudly")$
AddModelAction(m_hugeRat, "squeals loudly")$
m_hugeRat@p_Image := "Characters/hugeRat"$
m_hugeRat@p_mSound := "hugeRat"$
GNewIcon(m_hugeRat, makeRatIcon())$

define t_monsters m_hugeSnake CreateMonsterModel("snake,snak,sna;huge",
    "The snake isn't poisonous, but bites pretty well. It has a very striking "
    "checkerboard pattern.",
    MonsterInit, RandomMove,
    16, 8, 10, 5, 8, 0)$
m_hugeSnake@p_mBlocker := true$
AddModelAction(m_hugeSnake, "slithers around")$
AddModelAction(m_hugeSnake, "hisses")$
AddModelAction(m_hugeSnake, "coils and uncoils")$
m_hugeSnake@p_Image := "Characters/hugeSnake"$
m_hugeSnake@p_mSound := "hugeSnake"$
GNewIcon(m_hugeSnake, makeSnakeIcon())$

define t_monsters m_fighterGoblin CreateMonsterModel("goblin,gob;fighter",
    "The goblin is a small, humanoid creature with pale skin, large eyes, "
    "protruding ears, and sharp teeth. It walks in a perpetual crouch but "
    "is nonetheless quite fast on its feet.",
    MonsterInit, RandomMove,
    20, 8, 10, 6, 10, 50)$
m_fighterGoblin@p_mBlocker := true$
AddModelAction(m_fighterGoblin, "slouches around")$
AddModelAction(m_fighterGoblin, "gibbers")$
AddModelAction(m_fighterGoblin, "drools")$
AddModelAction(m_fighterGoblin, "howls")$
MakeMonsterSmart(m_fighterGoblin)$
m_fighterGoblin@p_Image := "Characters/fighterGoblin"$
m_fighterGoblin@p_mSound := "fighterGoblin"$
GNewIcon(m_fighterGoblin, makeGoblinIcon())$

define t_monsters m_hugeSpider CreateMonsterModel("spider,spi;huge",
    "The spider's body is almost as large as yours, and it's long legs give "
    "it good mobility and a long reach.",
    MonsterInit, RandomMove,
    16, 12, 15, 8, 12, 0)$
m_hugeSpider@p_mBlocker := true$
AddModelAction(m_hugeSpider, "dances around")$
AddModelAction(m_hugeSpider, "clashes its fangs")$
AddModelAction(m_hugeSpider, "drips saliva")$
AddModelAction(m_hugeSpider, "waves its front legs menacingly")$
m_hugeSpider@p_Image := "Characters/hugeSpider"$
m_hugeSpider@p_mSound := "hugeSpider"$
GNewIcon(m_hugeSpider, makeSpiderIcon())$

define t_monsters m_trackerSpider CreateMonsterModel("spider,spi;tracker",
    "The spider's body is almost as large as yours, and it's long legs give "
    "it good mobility and a long reach.",
    TrackerInit, TrackerMove,
    16, 12, 15, 8, 12, 0)$
m_trackerSpider@p_mBlocker := true$
m_trackerSpider@p_mKillAction := TrackerKill$
AddModelAction(m_trackerSpider, "dances around")$
AddModelAction(m_trackerSpider, "clashes its fangs")$
AddModelAction(m_trackerSpider, "drips saliva")$
AddModelAction(m_trackerSpider, "waves its front legs menacingly")$
m_trackerSpider@p_Image := "Characters/trackerSpider"$
m_trackerSpider@p_mSound := "trackerSpider"$
GNewIcon(m_trackerSpider, makeTSpiderIcon())$

define t_monsters m_largeTroll CreateMonsterModel("troll,tro;large", "",
    MonsterInit, RandomMove,
    35, 4, 7, 6, 18, 80)$
m_largeTroll@p_mBlocker := true$
AddModelAction(m_largeTroll, "lumbers around")$
AddModelAction(m_largeTroll, "bellows")$
AddModelAction(m_largeTroll, "raises its fists and roars")$
m_largeTroll@p_Image := "Characters/largeTroll"$
m_largeTroll@p_mSound := "largeTroll"$
GNewIcon(m_largeTroll, makeTrollIcon())$

unuse tp_monsters
