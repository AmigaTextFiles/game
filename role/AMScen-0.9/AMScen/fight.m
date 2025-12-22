/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * fight.m - add player stats, fighting, etc. to the starter dungeon.
 */

private tp_fight CreateTable().
use tp_fight

/*
 * NOTE: there is a direct dependency on r_arrivals, to send killed
 *	players there.
 */

define t_fight STEPS_PER_REGAINED_HIT_POINT 25.
define t_fight BLUTOS_AFTER_DYING 25.
define t_fight RANDOM_MONSTER_LIFE 100.
define t_fight FOREVER_LIFE -1.

/* first, the new player properties. Note: these are all the effective values,
   which may include modifications from armour, weapons, spells, etc. */

define t_fight p_pInited CreateBoolProp().	/* player has been set up */
define t_fight p_pFightTerse CreateBoolProp().
define t_fight p_pFightSuperTerse CreateBoolProp().
define t_fight p_pHitMax CreateIntProp().	/* max hit points */
define t_fight p_pHitNow CreateIntProp().	/* current hit points */
define t_fight p_pHitCount CreateIntProp().	/* part count for healing */
define t_fight p_pExperience CreateIntProp().	/* experience */
define t_fight p_pLevel CreateIntProp().	/* current level */
define t_fight p_pStrength CreateIntProp().	/* strength */
define t_fight p_pSpeed CreateIntProp().	/* speed/dexterity */
define t_fight p_pProtection CreateIntProp().	/* current armour class */
define t_fight p_pWeapon CreateThingProp().	/* current weapon */
define t_fight p_pShield CreateThingProp().	/* current shield */
define t_fight p_pArmour CreateThingProp().	/* current armour */
define t_fight p_pCurrentTarget CreateThingProp().	/* current opponent */
define t_fight p_pDieNotifyList CreateActionListProp().
define t_fight p_pNewMonster CreateThingProp(). /* temp during creation */
define t_fight p_pWieldChecker CreateActionProp().     /* allow player check */

/* monster-only properties */

define t_fight p_mActions CreateStringProp().	/* single string of actions */
define t_fight p_mActionIndexes CreateIntListProp().	/* indices of them */
define t_fight p_mMovesUntilVanish CreateIntProp().	/* when it leaves */
define t_fight p_mInitAction CreateActionProp().	/* startup action */
define t_fight p_mMoveAction CreateActionProp().	/* step action */
define t_fight p_mAfterMoveAction CreateActionProp().	/* on enter new room */
define t_fight p_mFightAction CreateActionProp().	/* fight action */
define t_fight p_mSpecialAction CreateActionProp().	/* action to do */
define t_fight p_mKillAction CreateActionProp().	/* action on kill */
define t_fight p_mCreateAction CreateActionProp().	/* something new */
define t_fight p_mArriveAction CreateActionProp().	/* something comes */
define t_fight p_mArrivedAction CreateActionProp().	/* check new loc */
define t_fight p_mExpired CreateBoolProp().		/* it has "died" */
define t_fight p_mBlocker CreateBoolProp().		/* it can block */
define t_fight p_mHunting CreateBoolProp().		/* look for target */

/* properties for weapons/shield/armour */

define t_fight p_oHitBonus CreateIntProp().	/* hitpoints bonus */
define t_fight p_oStrBonus CreateIntProp().	/* strength bonus */
define t_fight p_oSpeedBonus CreateIntProp().	/* speed bonus */
define t_fight p_oArmourProt CreateIntProp().	/* armour protection bonus */
define t_fight p_oShieldProt CreateIntProp().	/* shield protection bonus */
define t_fight p_oAccuracy CreateIntProp().	/* base accuracy level */
define t_fight p_oDamage CreateIntProp().	/* base damage level */
define t_fight p_oHealing CreateIntProp().	/* strength of heal */
define t_fight p_oWieldChecker CreateActionProp().    /* when wield a weapon */

/* properties on rooms */

define t_fight p_rNoGenerateMonsters CreateBoolProp()./* no new baddies */
define t_fight p_rMonsterList CreateThingListProp().  /* what might turn up */
define t_fight p_rMonsterChance CreateIntListProp().	/* diff per person */
define t_fight p_rMonsterTotal CreateIntProp(). /* total of the chances */

/* use these for proc forward references */

define tp_fight for_MonsterMove CreateActionProp().
define tp_fight forwardReference CreateThing(nil).

/*
 * fighterDesc - return additional description for a fighter.
 */

define tp_fight proc fighterDesc()string:
    thing it, weapon, shield, armour;
    string name, s, shieldName, armourName;

    it := It();
    s := "";
    name := FormatName(it@p_pName);
    weapon := it@p_pWeapon;
    shield := it@p_pShield;
    if shield ~= nil then
	shieldName := FormatName(shield@p_oName);
    fi;
    armour := it@p_pArmour;
    if armour ~= nil then
	armourName := FormatName(armour@p_oName);
    fi;
    if weapon = nil then
	if shield = nil then
	    if armour ~= nil then
		s := name + " is wearing " + armourName;
	    fi;
	else
	    s := name + AAn(" is using", shieldName);
	    if armour ~= nil then
		s := s + " and wearing " + armourName;
	    fi;
	fi;
    else
	s := name + AAn(" is wielding", FormatName(weapon@p_oName));
	if shield = nil then
	    if armour ~= nil then
		s := s + " and wearing " + armourName;
	    fi;
	else
	    if armour ~= nil then
		s := s + AAn(", using", shieldName);
		s := s + " and wearing " + armourName;
	    else
		s := s + AAn(" and using", shieldName);
	    fi;
	fi;
    fi;
    if s ~= "" then
	s := " " + s + ".";
    fi;
    s
corp;

/*
 * useItem - start using the given item.
 */

define tp_fight proc useItem(thing th)void:
    thing me;
    list action la;

    me := Me();
    me@p_pHitMax := me@p_pHitMax + th@p_oHitBonus;
    me@p_pStrength := me@p_pStrength + th@p_oStrBonus;
    me@p_pSpeed := me@p_pSpeed + th@p_oSpeedBonus;
    me@p_pProtection := me@p_pProtection + th@p_oArmourProt + th@p_oShieldProt;
    la := me@p_pDescMore;
    if la = nil then
	la := CreateActionList();
	me@p_pDescMore := la;
    fi;
    if FindElement(la, fighterDesc) = -1 then
	AddTail(la, fighterDesc);
    fi;
corp;

/*
 * unUseItem - stop using the given item.
 */

define tp_fight proc unUseItem(thing th, who)void:

    who@p_pHitMax := who@p_pHitMax - th@p_oHitBonus;
    who@p_pStrength := who@p_pStrength - th@p_oStrBonus;
    who@p_pSpeed := who@p_pSpeed - th@p_oSpeedBonus;
    who@p_pProtection := who@p_pProtection -
	th@p_oArmourProt - th@p_oShieldProt;
corp;

/* the wear/use/wield routines for armour/shields/weapons */

define tp_fight proc armourDrop(thing th)status:
    thing who;

    who := th@p_oCarryer;
    if who ~= nil then
	unUseItem(th, who);
	who -- p_pArmour;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc shieldDrop(thing th)status:
    thing who;

    who := th@p_oCarryer;
    if who ~= nil then
	unUseItem(th, who);
	who -- p_pShield;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc weaponDrop(thing th)status:
    thing who;

    who := th@p_oCarryer;
    if who ~= nil then
	unUseItem(th, who);
	who -- p_pWeapon;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc armourWear()status:
    thing th, me, oldArmour;

    th := It();
    me := Me();
    oldArmour := me@p_pArmour;
    if oldArmour ~= nil then
	unUseItem(oldArmour, me);
	oldArmour -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := armourDrop;
    me@p_pArmour := th;
    Print("You are now wearing the " + FormatName(th@p_oName) + ".\n");
    succeed
corp;

define tp_fight proc shieldUse()status:
    thing th, me, oldShield;

    th := It();
    me := Me();
    oldShield := me@p_pShield;
    if oldShield ~= nil then
	unUseItem(oldShield, me);
	oldShield -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := shieldDrop;
    me@p_pShield := th;
    Print("You are now using the " + FormatName(th@p_oName) + ".\n");
    succeed
corp;

define tp_fight proc weaponWield()status:
    thing th, me, oldWeapon;

    th := It();
    me := Me();
    oldWeapon := me@p_pWeapon;
    if oldWeapon ~= nil then
	unUseItem(oldWeapon, me);
	oldWeapon -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := weaponDrop;
    me@p_pWeapon := th;
    Print("You are now wielding the " + FormatName(th@p_oName) + ".\n");
    succeed
corp;

/*
 * SetupWeapon - set up a model object as a weapon.
 */

define t_fight proc public SetupWeapon(thing model; int hitBonus, strBonus,
	speedBonus, armourProt, shieldProt, accuracy, damage)void:

    if hitBonus ~= 0 then
	model@p_oHitBonus := hitBonus;
    fi;
    if strBonus ~= 0 then
	model@p_oStrBonus := strBonus;
    fi;
    if speedBonus ~= 0 then
	model@p_oSpeedBonus := speedBonus;
    fi;
    if armourProt ~= 0 then
	model@p_oArmourProt := armourProt;
	model@p_oWearChecker := armourWear;
    fi;
    if shieldProt ~= 0 then
	model@p_oShieldProt := shieldProt;
	model@p_oUseChecker := shieldUse;
    fi;
    if accuracy ~= 0 then
	model@p_oAccuracy := accuracy;
    fi;
    if damage ~= 0 then
	model@p_oDamage := damage;
	model@p_oWieldChecker := weaponWield;
    fi;
corp;

/*
 * WeaponSell - companion routine - set up what is for sale.
 */

define t_fight proc public WeaponSell(thing room; string name, desc;
	int price, hitBonus, strBonus, speedBonus,
	    armourProt, shieldProt, accuracy, damage
	)thing:
    thing model;

    model := AddForSale(room, name, desc, price, nil);
    SetupWeapon(model, hitBonus, strBonus, speedBonus, armourProt, shieldProt,
		accuracy, damage);
    model
corp;

define tp_fight proc healBuy()status:
    thing th, me;
    int n, hits, delta;

    th := It();
    me := Me();
    n := th@p_oHealing;
    n := n / 2 + Random(n / 2);
    hits := me@p_pHitNow;
    delta := me@p_pHitMax - hits;
    if n > delta then
	n := delta;
    fi;
    me@p_pHitNow := hits + n;
    if n = 1 then
	Print("You are healed for one point.\n");
    else
	Print("You are healed for " + IntToString(n) + " points.\n");
    fi;
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " makes a purchase.\n");
    fi;
    /* We are going to return 'false' to tell StoreBuy to not buy the
       item, but we do want to pay for it. */
    if not me@p_pPrivileged then
	me@p_pMoney := me@p_pMoney - th@p_oPrice;
    fi;
    fail
corp;

/*
 * HealSell - set up a healing "object".
 */

define t_fight proc public HealSell(thing room; string name;
	int cost, healing)void:
    thing model;

    model := AddForSale(room, name, "", cost, healBuy);
    model@p_oHealing := healing;
corp;

/*
 * showStats - show the statistics of the given thing (monster or player)
 */

define tp_fight proc showStats(thing who; bool forceLong)void:
    int ac;
    thing th;

    Print(FormatName(who@p_pName));
    Print(": Hit: ");
    IPrint(who@p_pHitNow);
    Print("/");
    IPrint(who@p_pHitMax);
    Print(" Exp: ");
    IPrint(who@p_pExperience);
    Print(" Lvl: ");
    IPrint(who@p_pLevel);
    Print(" Str: ");
    IPrint(who@p_pStrength);
    Print(" Spd: ");
    IPrint(who@p_pSpeed);
    Print(" AC: ");
    ac := who@p_pProtection;
    if ac > 0 then
	Print("+");
    fi;
    IPrint(ac);
    Print(" Bl: ");
    IPrint(who@p_pMoney);
    Print("\n");
    if forceLong or not who@p_pFightTerse then
	th := who@p_pWeapon;
	if th ~= nil then
	    Print("Weapon: ");
	    Print(FormatName(th@p_oName));
	    Print("\n");
	fi;
	th := who@p_pShield;
	if th ~= nil then
	    Print("Shield: ");
	    Print(FormatName(th@p_oName));
	    Print("\n");
	fi;
	th := who@p_pArmour;
	if th ~= nil then
	    Print("Armour: ");
	    Print(FormatName(th@p_oName));
	    Print("\n");
	fi;
    fi;
corp;

/**************************************************************************\
*									   *
*	Code, etc. for monsters 					   *
*									   *
\**************************************************************************/

/* NOTE: each monster points at the player it is currently attacking, which
   is usually the player which caused it to come into being, but can be
   another, if that other attacked the monster. Players point at the monster
   they most recently created or attacked, but those pointers are subject
   to testing before they are used, since the monsters can leave. */

/* the fighting code */

/*
 * AddExperience - do all needed on an experience gain or loss.
 */

define t_fight proc public AddExperience(thing thePlayer; int n)void:
    int level, value;

    n := n + thePlayer@p_pExperience;
    thePlayer@p_pExperience := n;
    level := 0;
    value := 10;
    while value <= n do
	value := value * 10;
	level := level + 1;
    od;
    value := thePlayer@p_pLevel;
    if level ~= value then
	thePlayer@p_pLevel := level;
	if level > value then
	    SPrint(thePlayer, "You have gained a level!\n");
	    if Random(2) = 0 then
		SPrint(thePlayer, "You gain speed.\n");
		thePlayer@p_pSpeed := thePlayer@p_pSpeed + 1;
	    else
		SPrint(thePlayer, "You gain strength.\n");
		thePlayer@p_pStrength := thePlayer@p_pStrength + 1;
	    fi;
	    thePlayer@p_pHitMax := thePlayer@p_pHitMax + 8 + Random(5);
	else
	    SPrint(thePlayer, "You have lost a level!\n");
	    if thePlayer@p_pSpeed > thePlayer@p_pStrength or
		thePlayer@p_pSpeed = thePlayer@p_pStrength and Random(2) = 0
	    then
		SPrint(thePlayer, "You lose speed.\n");
		thePlayer@p_pSpeed := thePlayer@p_pSpeed - 1;
	    else
		SPrint(thePlayer, "You lose strength.\n");
		thePlayer@p_pStrength := thePlayer@p_pStrength - 1;
	    fi;
	    n := thePlayer@p_pHitMax - 8 - Random(5);
	    if n < 10 then
		n := 10;
	    fi;
	    thePlayer@p_pHitMax := n;
	fi;
    fi;
corp;

/*
 * FindLoot - the player finds loot from a kill.
 */

define t_fight proc public FindLoot(int amount)void:
    thing me;

    if amount = 0 then
	amount := 1;
    fi;
    if amount = 1 then
	Print("You found one bluto of loot.\n");
    else
	Print("You found ");
	IPrint(amount);
	Print(" blutos of loot.\n");
    fi;
    me := Me();
    me@p_pMoney := me@p_pMoney + amount;
corp;

/*
 * part of KillPlayer.
 */

define tp_fight proc showAndLook()status:

    ShowIcon();
    ignore ShowRoomToMe(true);
    continue
corp;

/*
 * KillPlayer - general routine for killing a player. Send him back to the
 *	arrivals room with no belongings and 25 blutos.
 *	NOTE: if a player tells Packrat to go into the proving grounds, she
 *	will be set up to fight, just as if she were a player. Then, if
 *	someone kills her, this routine will be called by her!
 */

define t_fight proc public KillPlayer(thing victim, killer)void:
    list action la;
    list thing lt;
    int count, i;
    action a;
    thing here, item, killerLoc;
    string playerName;

    la := victim@p_pDieNotifyList;
    count := Count(la);
    i := 0;
    while i ~= count do
	a := la[i];
	if call(a, bool)(victim) then
	    DelElement(la, a);
	    count := count - 1;
	else
	    i := i + 1;
	fi;
    od;
    here := AgentLocation(victim);
    lt := victim@p_pCarrying;
    count := Count(lt);
    i := 0;
    while i < count do
	item := lt[i];
	if DoDrop(here, victim, item) = continue then
	    count := count - 1;
	else
	    i := i + 1;
	fi;
    od;

    /* this makes for a non-obvious cheat, but I want it disabled anyway */
    playerName := FormatName(victim@p_pName);
    if playerName ~= "Packrat" then
	victim@p_pMoney := BLUTOS_AFTER_DYING;
    fi;
    victim@p_pHitNow := 10;
    victim@p_pExperience := victim@p_pExperience / 2;
    AddExperience(victim, 0);

    if victim@p_pHidden then
	victim@p_pHidden := false;
	ABPrint(here, victim, victim,
	    "Something fades into view. It is the corpse of " + playerName +
	    "!\n");
    fi;
    ABPrint(here, victim, victim,
	"The corpse just fades away, but you catch a glimpse from the corner "
	"of your eye of a pale cloud floating off.\n");
    ignore ForceAction(victim, DoUnShowIcon);
    SetAgentLocation(victim, r_arrivals);
    SPrint(victim,
"You feel an abrupt tearing of the local continuum as your essence "
"departs from your ravaged body. Looking down, you see your corpse fade "
"away to nothing, leaving little sign of your recent presence. A feeling "
"of lightness pervades your being, and you begin to float away from the "
"scene. The floating quickens and the world becomes a blur of motion. Soon "
"you can again make out your surroundings.\n");
    ABPrint(r_arrivals, victim, victim, "From the corner of your eye "
	"you see a pale cloud float into view, which then solidifies into " +
	FormatName(victim@p_pName) + ".\n");
    ignore ForceAction(victim, showAndLook);

    /* did the killer kill off the only light source? */
    if killer ~= victim and not LightAt(here) then
	/* it may have gotten dark there */
	killerLoc := AgentLocation(killer);
	if killerLoc ~= here or not HasLight(killer) then
	    ForEachAgent(here, UnShowRoomFromAgent);
	    if killerLoc = here then
		if killer = Me() then
		    UnShowRoomFromMe();
		else
		    UnShowRoomFromAgent(killer);
		fi;
	    fi;
	fi;
    fi;
corp;

/*
 * MonsterHitPlayer - have the monster hit the player.
 *	Note: this can be executed by the player or by the monster!
 *	Return 'true' if the player is still alive.
 */

define t_fight proc public MonsterHitPlayer(thing monster,thePlayer,where)bool:
    string monsterName, playerName;
    int n, hits;
    bool alive;

    if thePlayer@p_pCurrentTarget = nil then
	thePlayer@p_pCurrentTarget := monster;
    fi; 
    alive := true;
    n := monster@p_oAccuracy;
    if n ~= 0 and Here()@p_rMonsterList ~= nil then
	/* Special case - if accuracy = 0, the monster never attacks.
	   Also, don't let monsters attack in a non-combat area, since
	   the player can't hit back! */
	monsterName := FormatName(monster@p_pName);
	playerName := FormatName(thePlayer@p_pName);
	if thePlayer@p_pHidden then
	    ABPrint(where, thePlayer, thePlayer,
		monsterName + " attacks something.\n");
	else
	    ABPrint(where, thePlayer, thePlayer,
		monsterName + " attacks " + playerName + ".\n");
	fi;
	/* first, does the attack hit? Note: 5 is "standard". */
	n := n * 3 + monster@p_pSpeed - 5;
	if n ~= 0 then
	    n := Random(60 / n);
	else
	    n := 1;
	fi;
	if n = 0 then
	    /* A hit. Get basic damage done by monster */
	    n := (monster@p_oDamage + 1) * 4;
	    n := (n / 2 + Random(n / 2 + 3)) / 4;
	    /* Modify by player armour class */
	    n := n + thePlayer@p_pProtection - 9;
	    /* and for excessive player strength */
	    n := n - (thePlayer@p_pStrength - 3) / 5;
	    if n > 0 then
		hits := thePlayer@p_pHitNow;
		hits := hits - n;
		SPrint(thePlayer, monsterName + " hits for " +
		    if n = 1 then
			"one point"
		    else
			IntToString(n) + " points"
		    fi +
		    ". [" + IntToString(hits) + "/" +
		    IntToString(thePlayer@p_pHitMax) + "]\n");
		if hits <= 0 then
		    SPrint(thePlayer, "You are killed!\n");
		    if not thePlayer@p_pHidden then
			ABPrint(where, thePlayer, thePlayer,
			    monsterName + " kills " + playerName + "!\n");
		    fi;
		    KillPlayer(thePlayer, monster);
		    alive := false;
		else
		    thePlayer@p_pHitNow := hits;
		fi;
	    else
		if not thePlayer@p_pFightSuperTerse then
		    SPrint(thePlayer,
			monsterName + " hits but does no damage.\n");
		fi;
	    fi;
	else
	    if not thePlayer@p_pFightTerse then
		SPrint(thePlayer, monsterName + " attacks but misses.\n");
	    fi;
	fi;
    fi;
    alive
corp;

/*
 * KillMonster - normal stuff for killing a monster.
 */

define t_fight proc KillMonster(thing monster)void:
    string monsterName;
    thing me, here;
    list thing lt;
    int i;

    me := Me();
    monsterName := FormatName(monster@p_pName);
    Print(monsterName + " is killed!\n");
    if me@p_pHidden then
	OPrint(monsterName + " is killed!\n");
    else
	OPrint(FormatName(me@p_pName) + " kills " + monsterName + "!\n");
    fi;
    me -- p_pCurrentTarget;
    lt := monster@p_pCarrying;
    if lt ~= nil then
	here := Here();
	i := Count(lt);
	while i ~= 0 do
	    i := i - 1;
	    ignore DoDrop(here, monster, lt[i]);
	od;
    fi;
    if monster ~= me then
	i := monster@p_pMoney;
	if i ~= 0 then
	    FindLoot((i + 1) / 2 + Random((i + 1) / 2));
	fi;
    fi;
    ignore ForceAction(monster, DoUnShowIcon);
corp;

/*
 * PlayerHitMonster - the player is attacking the monster.
 *	Return 'true' if the monster is still alive.
 *	Note: this is only ever executed by the player.
 */

define t_fight proc public PlayerHitMonster(thing thePlayer, monster)bool:
    thing weapon, here;
    string monsterName;
    int n, hits;
    list thing lt;
    bool alive;
    action a;

    alive := true;
    monster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    thePlayer@p_pCurrentTarget := monster;
    if monster@p_pCurrentTarget ~= thePlayer then
	/* if multiple people are bashing on a monster, it randomly
	   targets one of them */
	if monster@p_pCurrentTarget = nil or Random(2) = 0 then
	    monster@p_pCurrentTarget := thePlayer;
	fi;
    fi;
    weapon := thePlayer@p_pWeapon;
    monsterName := FormatName(monster@p_pName);
    if thePlayer@p_pHidden then
	OPrint(monsterName + " is attacked.\n");
    else
	OPrint(FormatName(thePlayer@p_pName) + " attacks " + monsterName +
	    ".\n");
    fi;

    /* first, does the attack hit? Note: 5 is "standard". */
    if weapon = nil then
	n := 5;
    else
	n := weapon@p_oAccuracy;
    fi;
    n := (n + thePlayer@p_pLevel) * 3 + thePlayer@p_pSpeed - 5;
    /* weaponless level 0 character has one chance in 4 of hitting */
    /* weaponless level 1 - 4 character has one chance in 3 of hitting */
    /* weaponless level 5 - 10 character has one chance in 2 of hitting */
    /* weaponless level 11 and up character always hits */
    if n ~= 0 then
	n := Random(60 / n);
    else
	n := 1;
    fi;
    if n = 0 then
	/* A hit! How much damage? */
	if weapon = nil then
	    n := 3;
	else
	    n := weapon@p_oDamage;
	fi;
	n := (n + thePlayer@p_pStrength) * 2;
	n := (n / 2 + Random(n / 2 + 3)) / 4;
	/* Modify by monster armour class */
	n := n + monster@p_pProtection - 9;
	if n > 0 then
	    Print("You hit for " + IntToString(n) +
		if n = 1 then " point.\n" else " points.\n" fi);
	    hits := monster@p_pHitNow;
	    if n >= hits then
		/* it is killed */
		a := monster@p_mKillAction;
		if a ~= nil then
		    alive := call(a, bool)(monster);
		else
		    alive := false;
		    KillMonster(monster);
		    DestroyMachine(monster);
		    AddExperience(thePlayer, hits);
		fi;
	    else
		monster@p_pHitNow := hits - n;
		AddExperience(thePlayer, n);
	    fi;
	else
	    if not thePlayer@p_pFightSuperTerse then
		Print("You hit " + monsterName + " but do no damage.\n");
	    fi;
	fi;
    else
	if not thePlayer@p_pFightTerse then
	    Print("You attack " + monsterName + " but miss.\n");
	fi;
    fi;
    alive
corp;

/*
 * PlayerHitPlayer - the current player is attacking the given player.
 */

define t_fight proc public PlayerHitPlayer(thing target)void:
    thing here, thePlayer, weapon;
    string playerName, targetName, points;
    int n, hits;

    here := Here();
    thePlayer := Me();
    playerName := FormatName(thePlayer@p_pName);
    targetName := FormatName(target@p_pName);
    if target@p_pInited then
	if not thePlayer@p_pHidden and not target@p_pHidden then
	    ABPrint(here, target, thePlayer,
		playerName + " attacks " + targetName + ".\n");
	fi;
	weapon := thePlayer@p_pWeapon;

	/* first, does the attack hit? Note: 5 is "standard". */
	if weapon = nil then
	    n := 5;
	else
	    n := weapon@p_oAccuracy;
	fi;
	n := n + thePlayer@p_pLevel;
	if n ~= 0 then
	    n := (Random(200 / n) + 5) / 10;
	else
	    n := 1;
	fi;
	if n = 0 then
	    /* A hit! How much damage? */
	    if weapon = nil then
		n := 5;
	    else
		n := weapon@p_oDamage;
	    fi;
	    n := n + thePlayer@p_pStrength / 5;
	    n := n / 2 + Random(n / 2) + 1;
	    /* Modify by target armour class */
	    n := n + target@p_pProtection - 9;
	    /* and for excessive player strength */
	    n := n - target@p_pStrength / 5;
	    if n > 0 then
		hits := target@p_pHitNow;
		SPrint(target, playerName +
		    " attacks you and hits for " +
		    if n = 1 then
			"one point"
		    else
			IntToString(n) + " points"
		    fi + ". [" + IntToString(hits - n) + "/" +
		    IntToString(hits) + "]\n");
		Print("You hit for " + if n = 1 then "one point" else
		    IntToString(n) + " points" fi + ".\n");
		if n >= hits then
		    /* target is killed */
		    n := hits;
		    if not thePlayer@p_pHidden and not target@p_pHidden then
			ABPrint(here, target, thePlayer,
			    playerName + " kills " + targetName + "!\n");
		    fi;
		    SPrint(target, playerName + " has killed you!\n");
		    Print(targetName + " is killed!\n");
		    if target@p_pMoney ~= 0 then
			FindLoot(target@p_pMoney);
		    fi;
		    KillPlayer(target, thePlayer);
		else
		    target@p_pHitNow := hits - n;
		fi;
		AddExperience(thePlayer, n);
	    else
		if not target@p_pFightSuperTerse then
		    SPrint(target, playerName +
			" attacks you and hits, but does no damage.\n");
		fi;
		if not thePlayer@p_pFightSuperTerse then
		    Print("You hit " + targetName + " but do no damage.\n");
		fi;
	    fi;
	else
	    if not target@p_pFightTerse then
		SPrint(target, playerName + " attacks you but misses.\n");
	    fi;
	    if not thePlayer@p_pFightTerse then
		Print("You attack " + targetName + " but miss.\n");
	    fi;
	fi;
    else
	Print(targetName + " is not set up for fighting.\n");
    fi;
corp;

/*
 * InitMonsterModels - clear a room for a new opponent set.
 */

define t_fight proc public InitMonsterModels(thing room; int initTotal)void:

    room@p_rMonsterList := CreateThingList();
    room@p_rMonsterChance := CreateIntList();
    room@p_rMonsterTotal := initTotal;
corp;

/*
 * AddPossibleMonster - add a monster to a room's opponent list.
 */

define t_fight proc public AddPossibleMonster(thing room, monster;
	int likelihood)void:

    AddTail(room@p_rMonsterList, monster);
    AddTail(room@p_rMonsterChance, likelihood);
    room@p_rMonsterTotal := room@p_rMonsterTotal + likelihood;
corp;

/*
 * doRunAway - part of RunAwaySoon, and hence of RunAway.
 */

define tp_fight proc doRunAway()void:
    int dir;

    dir := Random(12);
    if not call(forwardReference@for_MonsterMove, bool)(Me(), dir) then
	After(1, doRunAway);
    fi;
corp;

/*
 * RunAwaySoon - the current monster panics and tries hard to leave this
 *	location. This routine returns a 'status', so that it can be called
 *	via 'ForceAction'.
 */

define t_fight proc public RunAwaySoon()status:

    OPrint(FormatName(Me()@p_pName) + " panics!\n");
    After(0, doRunAway);
    continue
corp;

/*
 * RunAway - something has happened to cause a monster to want to run away.
 *	Arrange for it to try to do so. This routine is not normally called
 *	by the monster that wants to run away, so we use ForceAction and
 *	After to make it work out right.
 */

define t_fight proc public RunAway(thing who)void:

    ignore ForceAction(who, RunAwaySoon);
corp;

/*
 * MonsterAction - a monster does one of its random "actions".
 */

define t_fight proc public MonsterAction(thing me)void:
    list int li;
    string name, s;
    int pos, n;

    if LightAt(Here()) then
	li := me@p_mActionIndexes;
	name := FormatName(me@p_pName);
	if li = nil then
	    OPrint(name + " runs around.\n");
	else
	    s := me@p_mActions;
	    n := Random(Count(li));
	    if n = 0 then
		pos := 0;
	    else
		pos := li[n - 1];
	    fi;
	    n := li[n];
	    s := SubString(s, pos, n - pos);
	    OPrint(name + " " + s + ".\n");
	fi;
    else
	OPrint("You hear a noise.\n");
    fi;
corp;

/*
 * checkMonsterArrival - a monster has moved somewhere - inform each other
 *	monster that cares.
 */

define tp_fight proc checkMonsterArrival(thing target)void:
    action a;

    a := target@p_mArriveAction;
    if a ~= nil then
	call(a, void)(target, Me());
    fi;
corp;

/*
 * PickNewTarget - the monster has no target here. Randomly pick one.
 */

define tp_fight proc huntTarget(thing who)void:
    thing me;

    me := Me();
    if me@p_mHunting and who@p_pStandard then
	me -- p_mHunting;
	me@p_pCurrentTarget := who;
	ignore MonsterHitPlayer(me, who, Here());
    fi;
corp;

define t_fight proc public PickNewTarget()void:

    Me()@p_mHunting := true;
    ForEachAgent(Here(), huntTarget);
corp;

/*
 * MonsterMove - try to move in given direction and fight attacker.
 */

define t_fight proc public MonsterMove(thing me; int dir)bool:
    thing target, here;
    action a;

    if TryToMove(dir) then
	MachineMove(dir);
	a := me@p_mArrivedAction;
	if a ~= nil then
	    call(a, void)();
	fi;
	here := Here();
	ForEachAgent(here, checkMonsterArrival);
	target := me@p_pCurrentTarget;
	/* if our current target is here - attack! */
	if target ~= nil and AgentLocation(target) = here then
	    if LightAt(here) then
		ignore MonsterHitPlayer(me, target, here);
	    else
		OPrint("You hear a noise.\n");
	    fi;
	elif Random(5) = 0 then
	    PickNewTarget();
	fi;
	true
    else
	false
    fi
corp;

forwardReference@for_MonsterMove := MonsterMove.

/*
 * DoMonsterMove - attack target, move in random direction or do "action"
 */

define t_fight proc public DoMonsterMove(thing me)void:
    thing target, here;
    action a;

    here := Here();
    if Random(3) = 0 then
	target := me@p_pCurrentTarget;
	if target ~= nil and AgentLocation(target) = here then
	    if LightAt(here) then
		ignore MonsterHitPlayer(me, target, here);
	    else
		OPrint("You hear a noise.\n");
	    fi;
	elif Random(5) = 0 then
	    PickNewTarget();
	fi;
    else
	if MonsterMove(me, Random(12)) then
	    a := me@p_mAfterMoveAction;
	    if a ~= nil then
		call(a, void)();
	    fi;
	else
	    MonsterAction(me);
	fi;
    fi;
corp;

/*
 * MonsterStillMoving - see if monster leaves, and if so, nuke it.
 */

define t_fight proc public MonsterStillMoving(thing me; action dieAction)bool:
    thing obj, target;
    int n, count;
    list thing lt;

    n := me@p_mMovesUntilVanish;
    if n = FOREVER_LIFE then
	true
    elif n <= 0 then
	me@p_mExpired := true;
	if dieAction ~= nil then
	    call(dieAction, void)(me);
	fi;
	if LightAt(Here()) then
	    OPrint(FormatName(me@p_pName) + " leaves.\n");
	    ForEachAgent(Here(), UnShowIconOnce);
	fi;
	target := me@p_pCurrentTarget;
	if target ~= nil then
	    if target@p_pCurrentTarget = me then
		target -- p_pCurrentTarget;
	    fi;
	fi;
	lt := me@p_pCarrying;
	if lt ~= nil then
	    count := Count(lt);
	    while count ~= 0 do
		count := count - 1;
		obj := lt[count];
		ZapObject(obj);
		DelElement(lt, obj);
	    od;
	fi;
	/* After this point, the monster has no properties */
	DestroyMachine(me);
	/* At this point, the monster does not exist, so this routine must
	   do nothing but exit. In particular, OPrint is a no-no. */
	/* NOTE: because of a possible reference from a player who attacked
	   the monster and therefore has a reference to its thing as that
	   player's p_pCurrentTarget, the thing, although emptied out,
	   will not go away until all such players delete their reference. */
	false
    else
	me@p_mMovesUntilVanish := n - 1;
	true
    fi
corp;

/*
 * MonsterReschedule - setup to do his step again.
 */

define t_fight proc public MonsterReschedule(thing monster)void:
    int n;

    n := monster@p_pSpeed;
    if n = 0 then
	n := 100;
    else
	n := 100 / n;
    fi;
    After(Random(n) + 1, monster@p_mMoveAction);
corp;

/*
 * DummyMonsterInit - init routine that just does the Reschedule.
 */

define t_fight proc public DummyMonsterInit()void:

    MonsterReschedule(Me());
corp;

/*
 * MonsterInit - initialization of a random moving monster.
 */

define t_fight proc public MonsterInit()void:
    thing me;

    me := Me();
    ignore SetMachineActive(me, me@p_mMoveAction);
    if LightAt(Here()) then
	OPrint(FormatName(me@p_pName) + " has appeared.\n");
	ForEachAgent(Here(), ShowIconOnce);
    fi;
    MonsterReschedule(me);
corp;

/*
 * MonsterNoNo - standard monster response to many actions.
 */

define t_fight proc public MonsterNoNo()status:

    Print("You don't want to do that!\n");
    fail
corp;

define t_fight GenericMonster CreateThing(nil).
GenericMonster@p_pName := "MONSTER;GENERIC".
GenericMonster@p_oTouchChecker := MonsterNoNo.
GenericMonster@p_oSmellChecker := MonsterNoNo.
GenericMonster@p_oPushChecker := MonsterNoNo.
GenericMonster@p_oPullChecker := MonsterNoNo.
GenericMonster@p_oTurnChecker := MonsterNoNo.
GenericMonster@p_oLiftChecker := MonsterNoNo.
GenericMonster@p_oLowerChecker := MonsterNoNo.
GenericMonster@p_oEatChecker := MonsterNoNo.
SetThingStatus(GenericMonster, ts_readonly).

/*
 * CreateMonsterModel - create a new model monster.
 */

define t_fight proc public CreateMonsterModel(string name, desc;
	action initAction, moveAction;
	int hits, speed, protection, accuracy, damage, money)thing:
    thing model;

    model := CreateThing(GenericMonster);
    SetThingStatus(model, ts_readonly);
    model@p_pName := name;
    if desc ~= "" then
	model@p_pDesc := desc;
    else
	model@p_pDesc := "This is an ordinary " + FormatName(name) + ".";
    fi;
    if initAction ~= nil then
	model@p_mInitAction := initAction;
    fi;
    model@p_mMoveAction := moveAction;
    model@p_pHitMax := hits;
    model@p_pSpeed := speed;
    model@p_pProtection := protection;
    model@p_oAccuracy := accuracy;
    model@p_oDamage := damage;
    if money ~= 0 then
	model@p_pMoney := money;
    fi;
    model
corp;

/*
 * AddModelAction - add a 'moves around' action to a model monster.
 *	Note: keep in mind that these messages are seen by both the player
 *	involved and by any bystanders. (So don't use 'you'!).
 */

define t_fight proc public AddModelAction(thing model; string a)void:
    list int li;
    int len;

    li := model@p_mActionIndexes;
    if li = nil then
	li := CreateIntList();
	model@p_mActionIndexes := li;
	model@p_mActions := a;
    else
	a := model@p_mActions + a;
	model@p_mActions := a;
    fi;
    AddTail(li, Length(a));
corp;

/*
 * checkMonsterCreation - a new monster has arrived. Tell all who care.
 */

define tp_fight proc checkMonsterCreation(thing target)void:
    action a;

    a := target@p_mCreateAction;
    if a ~= nil then
	call(a, void)(target, Me()@p_pNewMonster);
    fi;
corp;

/*
 * CreateMonster - create a new monster with random hitpoints.
 *	Note: this routine assumes it is called by a player.
 */

define t_fight proc public CreateMonster(thing creator, model, where)thing:
    thing monster;
    int hits;

    monster := CreateThing(model);
    SetupMachine(monster);
    hits := model@p_pHitMax;
    hits := hits / 2 + Random(hits / 2) + 1;
    monster@p_pHitMax := hits;
    monster@p_pHitNow := hits;
    monster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    monster@p_pCurrentTarget := creator;
    monster@p_mExpired := false;
    CreateMachine(model@p_pName, monster, where, model@p_mInitAction);
    creator@p_pCurrentTarget := monster;
    Me()@p_pNewMonster := monster;
    ForEachAgent(where, checkMonsterCreation);
    Me() -- p_pNewMonster;
    monster
corp;

/*
 * CreateSpecificMonster - create a copy of a model monster.
 */

define t_fight proc public CreateSpecificMonster(
	thing creator, model, where)thing:
    thing monster;

    monster := CreateThing(model);
    SetupMachine(monster);
    monster@p_pHitNow := model@p_pHitMax;
    monster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    monster@p_pCurrentTarget := creator;
    CreateMachine(model@p_pName, monster, where, model@p_mInitAction);
    creator@p_pCurrentTarget := monster;
    Me()@p_pNewMonster := monster;
    ForEachAgent(where, checkMonsterCreation);
    Me() -- p_pNewMonster;
    monster
corp;

/*
 * PickNewMonster - pick a new monster for the player to fight.
 *	Return the thing of the generated monster, if any.
 */

define t_fight proc public PickNewMonster(thing creator, where)thing:
    list thing lt;
    list int li;
    int choice, count;

    lt := where@p_rMonsterList;
    if lt ~= nil then
	li := where@p_rMonsterChance;
	choice := Random(where@p_rMonsterTotal);
	count := Count(li);
	while count ~= 0 and choice >= li[count - 1] do
	    choice := choice - li[count - 1];
	    count := count - 1;
	od;
	if count ~= 0 then
	    CreateMonster(creator, lt[count - 1], where)
	else
	    nil
	fi
    else
	nil
    fi
corp;

/* a 'checker' for healing and generating random monsters */

define tp_fight proc monsterEnterCheck()status:
    thing me, monster;
    int i;

    me := Me();
    i := me@p_pHitCount;
    i := i + 1;
    if i = STEPS_PER_REGAINED_HIT_POINT then
	i := me@p_pHitNow;
	if i < me@p_pHitMax then
	    me@p_pHitNow := i + 1;
	fi;
	i := 0;
    fi;
    me@p_pHitCount := i;
    monster := me@p_pCurrentTarget;
    if monster = nil and not Here()@p_rNoGenerateMonsters then
	monster := PickNewMonster(me, Here());
    fi;
    continue
corp;

/* a 'checker' to let monsters try to hit fleeing players */

define tp_fight proc monsterLeaveCheck(int dir)status:
    thing me, monster, here;
    int n;
    status result;

    result := continue;
    me := Me();
    monster := me@p_pCurrentTarget;
    if monster ~= nil then
	here := Here();
	if AgentLocation(monster) = here then
	    /* the monster I was fighting is still here with me */
	    n := Random(3);
	    if n = 0 and monster@p_mBlocker then
		if LightAt(here) then
		    Print(FormatName(monster@p_pName) + " blocks you.\n");
		else
		    Print("Something blocks you.\n");
		fi;
		result := fail;
	    else
		if n = 1 and LightAt(here) then
		    if not MonsterHitPlayer(monster, me, here) then
			/* player has died - fail the move */
			result := fail;
		    fi;
		fi;
		me -- p_pCurrentTarget;
	    fi;
	else
	    me -- p_pCurrentTarget;
	fi;
    fi;
    result
corp;

/*
 * StandardAttack - standard code for player attack something.
 */

define t_fight proc public StandardAttack(thing thePlayer, target, where)void:
    int mSpeed;

    if target@p_pStandard then
	/* a monster set up like a player, e.g. Packrat after being forced
	   into the proving grounds */
	if target@p_pInited then
	    PlayerHitPlayer(target);
	else
	    Print(FormatName(target@p_pName) +
		  " is not set up for fighting.\n");
	fi;
    else
	mSpeed := target@p_pSpeed;
	if Random(thePlayer@p_pSpeed + mSpeed) < mSpeed then
	    /* monster hits first */
	    if MonsterHitPlayer(target, thePlayer, where) then
		ignore PlayerHitMonster(thePlayer, target);
	    fi;
	else
	    /* player hits first */
	    if PlayerHitMonster(thePlayer, target) then
		ignore MonsterHitPlayer(target, thePlayer, where);
	    fi;
	fi;
    fi;
corp;

/*
 * InitFighter - set up a player for fighting. Can be called repeatedly,
 *	since it checks for duplicates.
 */

define t_fight proc public InitFighter(thing fighter)void:

    if not fighter@p_pInited then
	fighter@p_pInited := true;
	fighter@p_pHitMax := 10;
	fighter@p_pHitNow := 10;
	fighter@p_pHitCount := 0;
	fighter@p_pExperience := 0;
	fighter@p_pStrength := 5;	/* "standard" strength */
	fighter@p_pSpeed := 5;		/* "standard" speed */
	fighter@p_pProtection := 9;	/* armour class +9 */
	fighter@p_pLevel := 0;
	fighter@p_pDieNotifyList := CreateActionList();
	AddPlayerEnterChecker(fighter, monsterEnterCheck, false);
	AddPlayerLeaveChecker(fighter, monsterLeaveCheck, false);
	SPrint(fighter, "\nCombat initialized!\n\n");
    fi;
corp;

/*
 * LeaveFighting - utility to call when leaving a fighting area. It returns
 *	'fail' for monsters, to keep them in, 'succeed' for players. Is
 *	suitable for a regular move checker.
 */

define t_fight proc public LeaveFighting()status:
    thing fighter;

    fighter := Me();
    if fighter@p_pInited then
	/* a player or someone like Packrat */
	continue
    else
	/* must be a monster - don't let them out */
	fail
    fi
corp;

/*
 * HealingBuy - routine to buy healing at a healer.
 */

define t_fight proc public HealingBuy(string what)bool:
    thing me;

    me := Me();
    if me@p_pHitNow >= me@p_pHitMax then
	Print("The proprietor looks at you for a moment, and then frowns "
	    "in puzzlement and says: 'But you are in perfect health!'\n");
	false
    else
	StoreBuy(what)
    fi
corp;

/************************\
*			 *
* The new commands added *
*			 *
\************************/

define tp_fight proc v_status(string who)bool:
    thing me;

    me := Me();
    if who == "full" then
	if me@p_pInited then
	    showStats(me, true);
	    true
	else
	    Print("There is no combat status to show you.\n");
	    false
	fi
    elif who ~= "" and IsWizard() then
	me := FindAgent(who);
	if me ~= nil then
	    showStats(me, true);
	    true
	else
	    Print("There is no " + who + " here.\n");
	    false
	fi
    else
	if me@p_pInited then
	    showStats(me, false);
	    true
	else
	    Print("There is no combat status to show you.\n");
	    false
	fi
    fi
corp;

define tp_fight proc v_wield(string what)bool:
    VerbCarry("wield", nil, p_oWieldChecker, p_pWieldChecker,
	      "You cannot wield", what)
corp;

/*
 * v_hit - the basic attacking verb.
 */

define tp_fight proc v_hit(string what)bool:
    thing me, target, here;
    action a;

    me := Me();
    here := Here();
    if what = "" then
	Print("You must specify who or what you want to attack.\n");
	false
    elif not me@p_pInited then
	Print("You are not yet set up for fighting.\n");
	false
    elif not CanSee(here, me) then
	Print("You can't see to fight.\n");
	false
    elif here@p_rMonsterList = nil then
	Print("This is a non-combat area.\n");
	false
    else
	target := FindAgent(what);
	if target = nil then
	    if FindName(here@p_rContents, p_oName, what) ~= fail or
		FindName(me@p_pCarrying, p_oName, what) ~= fail or
		MatchName(here@p_rScenery, what) ~= -1
	    then
		Print("You can only attack players or monsters.\n");
	    else
		Print(IsAre("There", "no", FormatName(what), "here.\n"));
	    fi;
	    false
	else
	    if ThingCharacter(target) ~= nil then
		if target = me then
		    Print("Masochism is not implemented.\n");
		else
		    /* attacking another player */
		    PlayerHitPlayer(target);
		fi;
	    else
		/* attacking a monster */
		a := target@p_mFightAction;
		if a ~= nil then
		    call(a, void)(target);
		else
		    StandardAttack(me, target, here);
		fi;
	    fi;
	    true
	fi
    fi
corp;

/*
 * verbs to allow briefer output during combat.
 */

define tp_fight proc v_fightterse()bool:
    thing me;

    me := Me();
    if me@p_pFightTerse and not me@p_pFightSuperTerse then
	Print("You are already in fightterse mode.\n");
	false
    else
	me -- p_pFightSuperTerse;
	me@p_pFightTerse := true;
	Print("fightterse mode set.\n");
	true
    fi
corp;

define tp_fight proc v_fightsuperterse()bool:
    thing me;

    me := Me();
    if me@p_pFightSuperTerse then
	Print("You are already in fightsuperterse mode.\n");
	false
    else
	me@p_pFightTerse := true;
	me@p_pFightSuperTerse := true;
	Print("fightsuperterse mode set.\n");
	true
    fi
corp;

define tp_fight proc v_fightverbose()bool:
    thing me;

    me := Me();
    if not me@p_pFightTerse then
	Print("You are already in fightverbose mode.\n");
	false
    else
	me -- p_pFightTerse;
	me -- p_pFightSuperTerse;
	Print("fightverbose mode set.\n");
	true
    fi
corp;

Verb1(G, "status", 0, v_status).
Synonym(G, "status", "st").
Verb1(G, "wield", 0, v_wield).
Verb1(G, "hit", 0, v_hit).
Synonym(G, "hit", "fight").
Synonym(G, "hit", "attack").
Synonym(G, "hit", "kill").
Synonym(G, "hit", "h").
Synonym(G, "hit", "k").
Verb0(G, "fightterse", 0, v_fightterse).
Synonym(G, "fightterse", "fightbrief").
Verb0(G, "fightsuperterse", 0, v_fightsuperterse).
Synonym(G, "fightsuperterse", "fightsuperbrief").
Verb0(G, "fightverbose", 0, v_fightverbose).

unuse tp_fight
