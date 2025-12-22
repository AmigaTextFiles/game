/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * fight.m - add player stats, fighting, etc. to the starter dungeon.
 */

private tp_fight CreateTable()$
use tp_fight

/*
 * NOTE: there is a direct dependency on r_arrivals, to send killed
 *	players there.
 */

define t_fight STEPS_PER_REGAINED_HIT_POINT	25$
define t_fight BLUTOS_AFTER_DYING		25$
define t_fight RANDOM_MONSTER_LIFE		100$
define t_fight FOREVER_LIFE			-1$
define t_fight STANDARD_STRENGTH		5$
define t_fight STANDARD_ACCURACY		5$
define t_fight STANDARD_DAMAGE			5$
define t_fight STANDARD_SPEED			5$

/* first, the new player properties. Note: these are all the effective values,
   which may include modifications from armour, weapons, spells, etc. */

define t_fight p_pInited CreateBoolProp()$	/* player has been set up */
define t_fight p_pFightTerse CreateBoolProp()$
define t_fight p_pFightSuperTerse CreateBoolProp()$
define t_fight p_pHitMax CreateIntProp()$	/* max hit points */
define t_fight p_pHitNow CreateIntProp()$	/* current hit points */
define t_fight p_pHitCount CreateIntProp()$	/* part count for healing */
define t_fight p_pExperience CreateIntProp()$	/* experience */
define t_fight p_pLevel CreateIntProp()$	/* current level */
define t_fight p_pStrength CreateIntProp()$	/* strength */
define t_fight p_pSpeed CreateIntProp()$	/* speed/dexterity */
define t_fight p_pProtection CreateIntProp()$	/* current armour class */
define t_fight p_pWeapon CreateThingProp()$	/* current weapon */
define t_fight p_pShield CreateThingProp()$	/* current shield */
define t_fight p_pArmour CreateThingProp()$	/* current armour */
define t_fight p_pCurrentTarget CreateThingProp()$	/* current opponent */
define t_fight p_pDieNotifyList CreateActionListProp()$
define t_fight p_pNewMonster CreateThingProp()$ /* temp during creation */
define t_fight p_pWieldChecker CreateActionProp()$     /* allow player check */
define t_fight p_pTrackerList CreateThingListProp()$	/* list of trackers */

/* monster-only properties */

define t_fight p_mActions CreateStringProp()$	/* single string of actions */
define t_fight p_mActionIndexes CreateIntListProp()$	/* indices of them */
define t_fight p_mMovesUntilVanish CreateIntProp()$	/* when it leaves */
define t_fight p_mSound CreateStringProp()$		/* name of sample */
define t_fight p_mInitAction CreateActionProp()$	/* startup action */
define t_fight p_mMoveAction CreateActionProp()$	/* step action */
define t_fight p_mAfterMoveAction CreateActionProp()$	/* on enter new room */
define t_fight p_mFightAction CreateActionProp()$	/* fight action */
define t_fight p_mSpecialAction CreateActionProp()$	/* action to do */
define t_fight p_mKillAction CreateActionProp()$	/* action on kill */
define t_fight p_mCreateAction CreateActionProp()$	/* something new */
define t_fight p_mArriveAction CreateActionProp()$	/* something comes */
define t_fight p_mArrivedAction CreateActionProp()$	/* check new loc */
define t_fight p_mExpired CreateBoolProp()$		/* it has "died" */
define t_fight p_mBlocker CreateBoolProp()$		/* it can block */
define t_fight p_mHunting CreateBoolProp()$		/* look for target */
define t_fight p_mTrackerPath CreateIntListProp()$	/* path to target */

/* properties for weapons/shield/armour */

define t_fight p_oHitBonus CreateIntProp()$	/* hitpoints bonus */
define t_fight p_oStrBonus CreateIntProp()$	/* strength bonus */
define t_fight p_oSpeedBonus CreateIntProp()$	/* speed bonus */
define t_fight p_oArmourProt CreateIntProp()$	/* armour protection bonus */
define t_fight p_oShieldProt CreateIntProp()$	/* shield protection bonus */
define t_fight p_oAccuracy CreateIntProp()$	/* base accuracy level */
define t_fight p_oDamage CreateIntProp()$	/* base damage level */
define t_fight p_oHealing CreateIntProp()$	/* strength of heal */
define t_fight p_oWieldChecker CreateActionProp()$    /* when wield a weapon */

/* properties on rooms */

define t_fight p_rNoGenerateMonsters CreateBoolProp()$/* no new baddies */
define t_fight p_rMonsterList CreateThingListProp()$  /* what might turn up */
define t_fight p_rMonsterChance CreateIntListProp()$	/* diff per person */
define t_fight p_rMonsterTotal CreateIntProp()$ /* total of the chances */
define t_fight p_rKillAction CreateActionProp()$      /* when monster killed */

/* this is an ancestor of all generic monsters */

define t_fight GenericMonster CreateThing(nil)$

/*
 * fighterDesc - return additional description for a fighter.
 */

define tp_fight proc fighterDesc()string:
    thing it, weapon, shield, armour;
    string name, s, shieldName, armourName;

    it := It();
    s := "";
    name := Capitalize(CharacterNameS(it));
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
 * AddFighterDesc - add the description about weapons, etc. to the list
 *	of extra descriptions on the passed character, if it is not
 *	already there.
 */

define t_fight proc AddFighterDesc(thing theCharacter)void:
    list action la;

    la := theCharacter@p_pDescMore;
    if la = nil then
	la := CreateActionList();
	theCharacter@p_pDescMore := la;
    fi;
    if FindElement(la, fighterDesc) = -1 then
	AddTail(la, fighterDesc);
    fi;
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
    AddFighterDesc(me);
corp;

/*
 * unUseItem - stop using the given item.
 */

define tp_fight proc unUseItem(thing th, theCharacter)void:

    theCharacter@p_pHitMax := theCharacter@p_pHitMax - th@p_oHitBonus;
    theCharacter@p_pStrength := theCharacter@p_pStrength - th@p_oStrBonus;
    theCharacter@p_pSpeed := theCharacter@p_pSpeed - th@p_oSpeedBonus;
    theCharacter@p_pProtection := theCharacter@p_pProtection -
	th@p_oArmourProt - th@p_oShieldProt;
corp;

/* the wear/use/wield routines for armour/shields/weapons */

define tp_fight proc armourDrop(thing th)status:
    thing theCharacter;

    theCharacter := th@p_oCarryer;
    if theCharacter ~= nil then
	unUseItem(th, theCharacter);
	theCharacter -- p_pArmour;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc shieldDrop(thing th)status:
    thing theCharacter;

    theCharacter := th@p_oCarryer;
    if theCharacter ~= nil then
	unUseItem(th, theCharacter);
	theCharacter -- p_pShield;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc weaponDrop(thing th)status:
    thing theCharacter;

    theCharacter := th@p_oCarryer;
    if theCharacter ~= nil then
	unUseItem(th, theCharacter);
	theCharacter -- p_pWeapon;
	th -- p_oUnGetChecker;
    fi;
    continue
corp;

define tp_fight proc armourWear()status:
    thing th, me, oldArmour;
    string aName;

    th := It();
    me := Me();
    if me@p_pWeapon = th then
	ignore weaponDrop(th);
    fi;
    if me@p_pShield = th then
	ignore shieldDrop(th);
    fi;
    oldArmour := me@p_pArmour;
    if oldArmour ~= nil then
	unUseItem(oldArmour, me);
	oldArmour -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := armourDrop;
    me@p_pArmour := th;
    aName := FormatName(th@p_oName);
    OPrint(Capitalize(CharacterNameS(me)) + AAn(" dons", aName) + ".\n");
    Print("You are now wearing the " + aName + ".\n");
    succeed
corp;

define tp_fight proc shieldUse()status:
    thing th, me, oldShield;
    string sName;

    th := It();
    me := Me();
    if me@p_pWeapon = th then
	ignore weaponDrop(th);
    fi;
    if me@p_pArmour = th then
	ignore armourDrop(th);
    fi;
    oldShield := me@p_pShield;
    if oldShield ~= nil then
	unUseItem(oldShield, me);
	oldShield -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := shieldDrop;
    me@p_pShield := th;
    sName := FormatName(th@p_oName);
    OPrint(Capitalize(CharacterNameS(me)) + AAn(" readies", sName) + ".\n");
    Print("You are now using the " + sName + ".\n");
    succeed
corp;

define tp_fight proc weaponWield()status:
    thing th, me, oldWeapon;
    string wName;

    th := It();
    me := Me();
    if me@p_pShield = th then
	ignore shieldDrop(th);
    fi;
    if me@p_pArmour = th then
	ignore armourDrop(th);
    fi;
    oldWeapon := me@p_pWeapon;
    if oldWeapon ~= nil then
	unUseItem(oldWeapon, me);
	oldWeapon -- p_oUnGetChecker;
    fi;
    useItem(th);
    th@p_oUnGetChecker := weaponDrop;
    me@p_pWeapon := th;
    wName := FormatName(th@p_oName);
    OPrint(Capitalize(CharacterNameS(me)) + AAn(" wields", wName) + ".\n");
    Print("You are now wielding the " + wName + ".\n");
    succeed
corp;

/*
 * SetupWeapon - set up a model object as a weapon.
 */

define t_fight proc public SetupWeapon(thing theModel; int hitBonus, strBonus,
	speedBonus, armourProt, shieldProt, accuracy, damage)void:

    if hitBonus ~= 0 then
	theModel@p_oHitBonus := hitBonus;
    fi;
    if strBonus ~= 0 then
	theModel@p_oStrBonus := strBonus;
    fi;
    if speedBonus ~= 0 then
	theModel@p_oSpeedBonus := speedBonus;
    fi;
    if armourProt ~= 0 then
	theModel@p_oArmourProt := armourProt;
	theModel@p_oWearChecker := armourWear;
    fi;
    if shieldProt ~= 0 then
	theModel@p_oShieldProt := shieldProt;
	theModel@p_oUseChecker := shieldUse;
    fi;
    if accuracy ~= 0 then
	theModel@p_oAccuracy := accuracy;
    fi;
    if damage ~= 0 then
	theModel@p_oDamage := damage;
	theModel@p_oWieldChecker := weaponWield;
    fi;
corp;

/*
 * WeaponSell - companion routine - set up what is for sale.
 */

define t_fight proc public WeaponSell(thing room; string name, desc;
	int price, hitBonus, strBonus, speedBonus,
	    armourProt, shieldProt, accuracy, damage
	)thing:
    thing theModel;

    theModel := AddForSale(room, name, desc, price, nil);
    SetupWeapon(theModel, hitBonus, strBonus, speedBonus, armourProt,
		shieldProt, accuracy, damage);
    theModel
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
    if delta = 0 then
	Print("You didn't need healing. Oh well - easy come, easy go!\n");
    else
	if n > delta then
	    n := delta;
	fi;
	me@p_pHitNow := hits + n;
	if n = 1 then
	    Print("You are healed for one point.\n");
	else
	    Print("You are healed for " + IntToString(n) + " points.\n");
	fi;
    fi;
    if not me@p_pHidden then
	OPrint(Capitalize(CharacterNameG(me)) + " makes a purchase.\n");
    fi;
    /* Tell 'StoreBuy' to destroy the copy, do not add it to our inventory,
       and print no messages, but charge us for it. */
    succeed
corp;

/*
 * HealSell - set up a healing "object".
 */

define t_fight proc public HealSell(thing room; string name;
	int cost, healing)void:
    thing theModel;

    theModel := AddForSale(room, name, "", cost, healBuy);
    theModel@p_oHealing := healing;
corp;

/*
 * showStats - show the statistics of the given thing (monster or player)
 */

define tp_fight proc showStats(thing theCharacter; bool forceLong)void:
    string name;
    int ac;
    thing th;

    name := FormatName(theCharacter@p_pName);
    Print(name);
    Print(": Hit: ");
    IPrint(theCharacter@p_pHitNow);
    Print("/");
    IPrint(theCharacter@p_pHitMax);
    Print(" Exp: ");
    IPrint(theCharacter@p_pExperience);
    Print(" Lvl: ");
    IPrint(theCharacter@p_pLevel);
    Print(" Str: ");
    IPrint(theCharacter@p_pStrength);
    Print(" Spd: ");
    IPrint(theCharacter@p_pSpeed);
    Print(" AC: ");
    ac := theCharacter@p_pProtection;
    if ac > 0 then
	Print("+");
    fi;
    IPrint(ac);
    Print(" Bl: ");
    IPrint(theCharacter@p_pMoney);
    Print("\n");
    if forceLong or not theCharacter@p_pFightTerse or theCharacter ~= Me() then
	th := theCharacter@p_pWeapon;
	if th ~= nil then
	    Print("Weapon: ");
	    Print(FormatName(th@p_oName));
	    Print("\n");
	fi;
	th := theCharacter@p_pShield;
	if th ~= nil then
	    Print("Shield: ");
	    Print(FormatName(th@p_oName));
	    Print("\n");
	fi;
	th := theCharacter@p_pArmour;
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

/* set up monsters which will pick up and use stuff */

define tp_fight proc MonsterUse(thing theMonster, item)void:
    int n;
    thing old;

    n := item@p_oArmourProt;
    old := theMonster@p_pArmour;
    if old = nil and n ~= 0 or old ~= nil and n < old@p_oArmourProt then
	SetIt(item);
	ignore call(item@p_oWearChecker, status)();
	/* make him live forever */
	theMonster@p_mMovesUntilVanish := FOREVER_LIFE;
    else
	n := item@p_oShieldProt;
	old := theMonster@p_pShield;
	if old = nil and n ~= 0 or old ~= nil and n < old@p_oShieldProt then
	    SetIt(item);
	    ignore call(item@p_oUseChecker, status)();
	    theMonster@p_mMovesUntilVanish := FOREVER_LIFE;
	else
	    n := item@p_oDamage;
	    old := theMonster@p_pWeapon;
	    if old = nil and n ~= 0 or old ~= nil and n > old@p_oDamage then
		SetIt(item);
		ignore call(item@p_oWieldChecker, status)();
		theMonster@p_mMovesUntilVanish := FOREVER_LIFE;
	    fi;
	fi;
    fi;
corp;

define tp_fight proc MonsterPickUp()void:
    list thing lt;
    int count, i, carryCount;
    thing here, theMonster, th;

    theMonster := Me();
    here := Here();
    lt := here@p_rContents;
    count := Count(lt);
    carryCount := Count(theMonster@p_pCarrying);
    i := 0;
    while i < count and carryCount < MAX_CARRY do
	th := lt[i];
	if not th@p_oInvisible and not th@p_oNotGettable then
	    if DoGet(here, theMonster, th) ~= fail then
		count := count - 1;
		carryCount := carryCount + 1;
		MonsterUse(theMonster, th);
	    else
		/* something wrong - quit trying to get things */
		i := count;
	    fi;
	else
	    i := i + 1;
	fi;
    od;
corp;

define tp_fight proc MonsterGivePost()status:

    MonsterUse(Me(), It());
    continue
corp;

define tp_fight proc doPickup()status:
    MonsterPickUp();
    continue
corp;

define tp_fight proc monsterGivePre()status:
    SPrint(TrueMe(), "You can't give things to " +
	   CharacterNameS(Me()) + ".\n");
    fail
corp;

define tp_fight proc smartGivePre()status:
    continue
corp;

/*
 * MakeMonsterSmart - call this routine on a monster model to make that
 *	monster "smart" in that it will pick up and use weapons, armour
 *	and shields.
 */

define t_fight proc MakeMonsterSmart(thing monster)void:

    monster@p_mAfterMoveAction := MonsterPickUp;
    monster@p_pGivePre := smartGivePre; 	/* override any from parent */
    monster@p_pGivePost := MonsterGivePost;
corp;

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
    thing theCharacter;

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
    theCharacter := Me();
    theCharacter@p_pMoney := theCharacter@p_pMoney + amount;
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

define t_fight proc public KillPlayer(thing theVictim, theKiller)void:
    list action la;
    list thing lt;
    int count, i;
    action a;
    thing here, item, killerLoc;
    string victimName;

    la := theVictim@p_pDieNotifyList;
    count := Count(la);
    i := 0;
    while i ~= count do
	a := la[i];
	if call(a, bool)(theVictim) then
	    DelElement(la, a);
	    count := count - 1;
	else
	    i := i + 1;
	fi;
    od;
    here := AgentLocation(theVictim);
    lt := theVictim@p_pCarrying;
    count := Count(lt);
    i := 0;
    while i < count do
	item := lt[i];
	if DoDrop(here, theVictim, item) = continue then
	    count := count - 1;
	else
	    i := i + 1;
	fi;
    od;

    /* this makes for a non-obvious cheat, but I want it disabled anyway */
    victimName := CharacterNameG(theVictim);
    if victimName ~= "Packrat" then
	theVictim@p_pMoney := BLUTOS_AFTER_DYING;
    fi;
    theVictim@p_pHitNow := 10;
    theVictim@p_pExperience := theVictim@p_pExperience / 2;
    AddExperience(theVictim, 0);

    if theVictim@p_pHidden then
	theVictim@p_pHidden := false;
	ABPrint(here, theVictim, theVictim,
	    "Something fades into view. It is the corpse of " + victimName +
	    "!\n");
    fi;
    ABPrint(here, theVictim, theVictim,
	"The corpse just fades away, but you catch a glimpse from the corner "
	"of your eye of a pale cloud floating off.\n");
    ignore ForceAction(theVictim, DoUnShowIcon);
    SetAgentLocation(theVictim, r_arrivals);
    SPrint(theVictim,
"You feel an abrupt tearing of the local continuum as your essence "
"departs from your ravaged body. Looking down, you see your corpse fade "
"away to nothing, leaving little sign of your recent presence. A feeling "
"of lightness pervades your being, and you begin to float away from the "
"scene. The floating quickens and the world becomes a blur of motion. Soon "
"you can again make out your surroundings.\n");
    ABPrint(r_arrivals, theVictim, theVictim, "From the corner of your eye "
	"you see a pale cloud float into view, which then solidifies into " +
	victimName + ".\n");
    ignore ForceAction(theVictim, showAndLook);

    /* did the killer kill off the only light source? */
    if theKiller ~= theVictim and not LightAt(here) then
	/* it may have gotten dark there */
	killerLoc := AgentLocation(theKiller);
	if killerLoc ~= here or not HasLight(theKiller) then
	    ForEachAgent(here, UnShowRoomFromAgent);
	    if killerLoc = here then
		if theKiller = Me() then
		    UnShowRoomFromMe();
		else
		    UnShowRoomFromAgent(theKiller);
		fi;
	    fi;
	fi;
    fi;
corp;

/*
 * AttackHits - whether or not an attack will hit.
 */

define t_fight proc public AttackHits(thing attacker; bool isPlayer)bool:
    thing weapon;
    int n;

    weapon := attacker@p_pWeapon;
    if weapon ~= nil then
	n := weapon@p_oAccuracy;
    else
	if isPlayer then
	    n := STANDARD_ACCURACY;
	else
	    n := attacker@p_oAccuracy;
	fi;
    fi;
    if isPlayer then
	/* weaponless level 0 character has one chance in 4 of hitting */
	/* weaponless level 1 - 4 character has one chance in 3 of hitting */
	/* weaponless level 5 - 10 character has one chance in 2 of hitting */
	/* weaponless level 11 and up character always hits */
	n := n + attacker@p_pLevel;
    fi;
    n := n * 3 + attacker@p_pSpeed - STANDARD_SPEED;
    if n ~= 0 then
	n := Random(60 / n);
    else
	n := 1;
    fi;
    n = 0
corp;

/*
 * AttackPoints - the strength of an attack.
 */

define t_fight proc public AttackPoints(thing attacker; bool aIsPlayer;
					thing target; bool tIsPlayer)int:
    thing weapon;
    int n;

    weapon := attacker@p_pWeapon;
    if weapon ~= nil then
	n := weapon@p_oDamage;
    else
	if aIsPlayer then
	    n := STANDARD_DAMAGE;
	else
	    n := attacker@p_oDamage;
	fi;
    fi;
    if aIsPlayer then
	n := n + attacker@p_pStrength;
    fi;
    n := n * 2;
    n := (n / 2 + Random(n / 2 + 3)) / 4;
    /* Modify by target armour class */
    n := n + target@p_pProtection - 9;
    /* and for excessive target player strength */
    if tIsPlayer then
	n := n - (target@p_pStrength - STANDARD_STRENGTH) / 5;
    fi;
    n
corp;

/*
 * MonsterHitPlayer - have the monster hit the player.
 *	Note: this can be executed by the player or by the monster!
 *	Return 'true' if the player is still alive.
 */

define t_fight proc public MonsterHitPlayer(
	thing theMonster, thePlayer, where)bool:
    string monsterName, playerName;
    int n, hits;
    bool alive;

    if thePlayer@p_pCurrentTarget = nil then
	thePlayer@p_pCurrentTarget := theMonster;
    fi; 
    alive := true;
    if theMonster@p_oAccuracy ~= 0 and Here()@p_rMonsterList ~= nil then
	/* Special case - if accuracy = 0, the monster never attacks.
	   Also, don't let monsters attack in a non-combat area, since
	   the player can't hit back! */
	monsterName := Capitalize(CharacterNameG(theMonster));
	playerName := CharacterNameG(thePlayer);
	if thePlayer@p_pHidden then
	    ABPrint(where, thePlayer, thePlayer,
		monsterName + " attacks something.\n");
	else
	    ABPrint(where, thePlayer, thePlayer,
		monsterName + " attacks " + playerName + ".\n");
	fi;
	/* first, does the attack hit? */
	if AttackHits(theMonster, false) then
	    /* A hit. Get basic damage done by monster */
	    n := AttackPoints(theMonster, false, thePlayer, true);
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
		    AddExperience(theMonster, thePlayer@p_pHitNow);
		    theMonster@p_pMoney :=
			theMonster@p_pMoney + thePlayer@p_pMoney;
		    KillPlayer(thePlayer, theMonster);
		    if theMonster@p_mAfterMoveAction = MonsterPickUp then
			ignore ForceAction(theMonster, doPickup);
		    fi;
		    alive := false;
		else
		    thePlayer@p_pHitNow := hits;
		    AddExperience(theMonster, n);
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

define t_fight proc KillMonster(thing theMonster)void:
    string monsterName;
    thing theKiller, other, here;
    list thing lt;
    int i;

    theKiller := Me();
    monsterName := CharacterNameS(theMonster);
    Print(Capitalize(monsterName) + " is killed!\n");
    if theKiller@p_pHidden then
	OPrint(Capitalize(monsterName) + " is killed!\n");
    else
	OPrint(Capitalize(CharacterNameS(theKiller)) + " kills " +
	    monsterName +"!\n");
    fi;
    theKiller -- p_pCurrentTarget;
    other := theMonster@p_pCurrentTarget;
    if other ~= nil and other ~= theKiller then
	if other@p_pCurrentTarget = theMonster then
	    other -- p_pCurrentTarget;
	fi;
    fi;
    lt := theMonster@p_pCarrying;
    if lt ~= nil then
	here := Here();
	i := Count(lt);
	while i ~= 0 do
	    i := i - 1;
	    ignore DoDrop(here, theMonster, lt[i]);
	od;
    fi;
    if theMonster ~= theKiller then
	i := theMonster@p_pMoney;
	if i ~= 0 then
	    FindLoot((i + 1) / 2 + Random((i + 1) / 2));
	fi;
    fi;
    ignore ForceAction(theMonster, DoUnShowIcon);
corp;

/*
 * PlayerHitMonster - the player is attacking the monster.
 *	Return 'true' if the monster is still alive.
 *	Note: this is only ever executed by the player.
 */

define t_fight proc public PlayerHitMonster(thing thePlayer, theMonster)bool:
    thing target, weapon, here, theModel;
    string monsterName;
    int n, hits;
    list thing lt;
    bool alive;
    action a;

    alive := true;
    if theMonster@p_mMovesUntilVanish ~= FOREVER_LIFE then
	theMonster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    fi;
    thePlayer@p_pCurrentTarget := theMonster;
    target := theMonster@p_pCurrentTarget;
    if target ~= thePlayer then
	if target ~= nil then
	    /* Remove reference to monster */
	    target -- p_pCurrentTarget;
	fi;
	/* If multiple people are bashing on a monster, it randomly
	   targets one of them. Trackers do not switch if they have a
	   partial path, however. */
	if target = nil or Random(2) = 0 and target@p_mTrackerPath = nil then
	    theMonster@p_pCurrentTarget := thePlayer;
	fi;
    fi;
    weapon := thePlayer@p_pWeapon;
    monsterName := CharacterNameG(theMonster);
    if thePlayer@p_pHidden then
	OPrint(Capitalize(monsterName) + " is attacked.\n");
    else
	OPrint(Capitalize(CharacterNameG(thePlayer)) + " attacks " +
	    monsterName + ".\n");
    fi;

    /* first, does the attack hit? */
    if AttackHits(thePlayer, true) then
	/* A hit! How much damage? */
	n := AttackPoints(thePlayer, true, theMonster, false);
	if n > 0 then
	    Print("You hit for " + IntToString(n) +
		if n = 1 then " point.\n" else " points.\n" fi);
	    hits := theMonster@p_pHitNow;
	    if n >= hits then
		/* it is killed */
		theModel := Parent(theMonster);
		a := theMonster@p_mKillAction;
		if a ~= nil then
		    alive := call(a, bool)(thePlayer, theMonster);
		else
		    alive := false;
		    KillMonster(theMonster);
		    DestroyMachine(theMonster);
		    AddExperience(thePlayer, hits);
		fi;
		a := Here()@p_rKillAction;
		if a ~= nil then
		    call(a, void)(thePlayer, theModel);
		fi;
	    else
		theMonster@p_pHitNow := hits - n;
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

define t_fight proc public PlayerHitPlayer(thing theTarget)void:
    thing here, theAttacker, weapon;
    string attackerName, targetName, points;
    int n, hits;

    here := Here();
    theAttacker := Me();
    attackerName := Capitalize(CharacterNameS(theAttacker));
    targetName := theTarget@p_pName;
    if theTarget@p_pInited then
	if not theAttacker@p_pHidden and not theTarget@p_pHidden then
	    ABPrint(here, theTarget, theAttacker,
		attackerName + " attacks " + targetName + ".\n");
	fi;
	weapon := theAttacker@p_pWeapon;

	/* first, does the attack hit? */
	if AttackHits(theAttacker, true) then
	    /* A hit! How much damage? */
	    n := AttackPoints(theAttacker, true, theTarget, true);
	    if n > 0 then
		hits := theTarget@p_pHitNow;
		SPrint(theTarget, attackerName +
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
		    if not theAttacker@p_pHidden and not theTarget@p_pHidden
		    then
			ABPrint(here, theTarget, theAttacker,
			    attackerName + " kills " + targetName + "!\n");
		    fi;
		    SPrint(theTarget, attackerName + " has killed you!\n");
		    Print(Capitalize(targetName) + " is killed!\n");
		    if theTarget@p_pMoney ~= 0 then
			FindLoot(theTarget@p_pMoney);
		    fi;
		    KillPlayer(theTarget, theAttacker);
		else
		    theTarget@p_pHitNow := hits - n;
		fi;
		AddExperience(theAttacker, n);
	    else
		if not theTarget@p_pFightSuperTerse then
		    SPrint(theTarget, attackerName +
			" attacks you and hits, but does no damage.\n");
		fi;
		if not theAttacker@p_pFightSuperTerse then
		    Print("You hit " + targetName + " but do no damage.\n");
		fi;
	    fi;
	else
	    if not theTarget@p_pFightTerse then
		SPrint(theTarget, attackerName + " attacks you but misses.\n");
	    fi;
	    if not theAttacker@p_pFightTerse then
		Print("You attack " + targetName + " but miss.\n");
	    fi;
	fi;
    else
	Print(Capitalize(targetName) + " is not set up for fighting.\n");
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

define t_fight proc public AddPossibleMonster(thing room, theMonster;
	int likelihood)void:

    AddTail(room@p_rMonsterList, theMonster);
    AddTail(room@p_rMonsterChance, likelihood);
    room@p_rMonsterTotal := room@p_rMonsterTotal + likelihood;
corp;

define t_fight proc public MonsterMove(thing theMonster; int dir)bool:
    false
corp;

/*
 * doRunAway - part of RunAwaySoon, and hence of RunAway.
 */

define tp_fight proc doRunAway()void:
    int dir;

    dir := Random(12);
    if not MonsterMove(Me(), dir) then
	/* failed to move - try again real soon */
	After(1.0, doRunAway);
    fi;
corp;

/*
 * RunAwaySoon - the current monster panics and tries hard to leave this
 *	location. This routine returns a 'status', so that it can be called
 *	via 'ForceAction'.
 */

define t_fight proc public RunAwaySoon()status:

    OPrint(Capitalize(CharacterNameG(Me())) + " panics!\n");
    After(0.0, doRunAway);
    continue
corp;

/*
 * RunAway - something has happened to cause a monster to want to run away.
 *	Arrange for it to try to do so. This routine is not normally called
 *	by the monster that wants to run away, so we use ForceAction and
 *	After to make it work out right.
 */

define t_fight proc public RunAway(thing theCoward)void:

    ignore ForceAction(theCoward, RunAwaySoon);
corp;

/*
 * MonsterAction - a monster does one of its random "actions".
 */

define t_fight proc public MonsterAction(thing theMonster)void:
    list int li;
    string monsterName, s;
    int pos, n;

    if LightAt(Here()) then
	li := theMonster@p_mActionIndexes;
	monsterName := Capitalize(CharacterNameG(theMonster));
	if li = nil then
	    OPrint(monsterName + " runs around.\n");
	else
	    s := theMonster@p_mActions;
	    n := Random(Count(li));
	    if n = 0 then
		pos := 0;
	    else
		pos := li[n - 1];
	    fi;
	    n := li[n];
	    s := SubString(s, pos, n - pos);
	    OPrint(monsterName + " " + s + ".\n");
	fi;
    else
	OPrint("You hear a noise.\n");
    fi;
corp;

/*
 * checkMonsterArrival - a monster has moved somewhere - inform each other
 *	monster that cares.
 */

define tp_fight proc checkMonsterArrival(thing theTarget)void:
    action a;

    a := theTarget@p_mArriveAction;
    if a ~= nil then
	call(a, void)(theTarget, Me());
    fi;
corp;

/*
 * PickNewTarget - the monster has no target here. Randomly pick one.
 */

define tp_fight proc huntTarget(thing theTarget)void:
    thing me;

    me := Me();
    if me@p_mHunting and theTarget@p_pStandard then
	me -- p_mHunting;
	me@p_pCurrentTarget := theTarget;
	ignore MonsterHitPlayer(me, theTarget, Here());
    fi;
corp;

define t_fight proc public PickNewTarget()void:

    Me()@p_mHunting := true;
    ForEachAgent(Here(), huntTarget);
corp;

/*
 * MonsterMove - try to move in given direction and fight attacker.
 */

replace MonsterMove(thing theMonster; int dir)bool:
    thing theTarget, here;
    action a;

    if TryToMove(dir) then
	MachineMove(dir);
	a := theMonster@p_mArrivedAction;
	if a ~= nil then
	    call(a, void)();
	fi;
	here := Here();
	ForEachAgent(here, checkMonsterArrival);
	theTarget := theMonster@p_pCurrentTarget;
	/* if our current target is here - attack! */
	if theTarget ~= nil and AgentLocation(theTarget) = here then
	    if LightAt(here) then
		ignore MonsterHitPlayer(theMonster, theTarget, here);
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

define t_fight MONSTER_SOUND_ID NextSoundEffectId()$
define t_fight SoundThing CreateThing(nil)$
define t_fight p_tCurrentSound CreateStringProp()$

/*
 * monsterSoundOnce - play the sound for a client.
 */

define tp_fight proc monsterSoundOnce(thing client)void:
    if SOn(client) then
	SPlaySound(client, SoundThing@p_tCurrentSound, 1, MONSTER_SOUND_ID);
    fi;
corp;

/*
 * playMonsterSound - play the sound associated with a monster.
 */

define t_fight proc PlayMonsterSound(thing theMonster, me)void:
    string sound;

    sound := theMonster@p_mSound;
    if sound ~= "" then
	SoundThing@p_tCurrentSound := sound;
	ForEachAgent(Here(), monsterSoundOnce);
	if me ~= nil then
	    monsterSoundOnce(me);
	fi;
	SoundThing -- p_tCurrentSound;
    fi;
corp;

/*
 * DoMonsterMove - attack target, move in random direction or do "action"
 */

define t_fight proc public DoMonsterMove(thing theMonster)void:
    thing theTarget, here;
    action a;

    here := Here();
    if Random(3) = 0 then
	theTarget := theMonster@p_pCurrentTarget;
	if theTarget ~= nil and AgentLocation(theTarget) = here then
	    PlayMonsterSound(theMonster, nil);
	    if LightAt(here) then
		ignore MonsterHitPlayer(theMonster, theTarget, here);
	    else
		OPrint("You hear a noise.\n");
	    fi;
	elif Random(5) = 0 then
	    PickNewTarget();
	fi;
    else
	if MonsterMove(theMonster, Random(12)) then
	    a := theMonster@p_mAfterMoveAction;
	    if a ~= nil then
		call(a, void)();
	    fi;
	else
	    PlayMonsterSound(theMonster, nil);
	    MonsterAction(theMonster);
	fi;
    fi;
corp;

/*
 * MonsterStillMoving - see if monster leaves, and if so, nuke it.
 */

define t_fight proc public MonsterStillMoving(thing theMonster;
	action dieAction)bool:
    thing obj, theTarget;
    int n, count;
    list thing lt;

    n := theMonster@p_mMovesUntilVanish;
    if n = FOREVER_LIFE then
	true
    elif n <= 0 then
	theMonster@p_mExpired := true;
	if dieAction ~= nil then
	    call(dieAction, void)(theMonster);
	fi;
	if LightAt(Here()) then
	    OPrint(Capitalize(CharacterNameG(theMonster)) + " leaves.\n");
	    ForEachAgent(Here(), UnShowIconOnce);
	fi;
	theTarget := theMonster@p_pCurrentTarget;
	if theTarget ~= nil then
	    if theTarget@p_pCurrentTarget = theMonster then
		theTarget -- p_pCurrentTarget;
	    fi;
	fi;
	lt := theMonster@p_pCarrying;
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
	DestroyMachine(theMonster);
	/* At this point, the monster does not exist, so this routine must
	   do nothing but exit. In particular, OPrint is a no-no. */
	/* NOTE: because of a possible reference from a player who attacked
	   the monster and therefore has a reference to its thing as that
	   player's p_pCurrentTarget, the thing, although emptied out,
	   will not go away until all such players delete their reference. */
	false
    else
	theMonster@p_mMovesUntilVanish := n - 1;
	true
    fi
corp;

/*
 * MonsterReschedule - setup to do his step again.
 */

define t_fight proc public MonsterReschedule(thing theMonster)void:
    thing me;
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
    i := theMonster@p_pSpeed;
    if i = 0 then
	i := 100;
    else
	i := 100 / i;
    fi;
    After(IntToFixed(Random(i) + 1), theMonster@p_mMoveAction);
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
    thing theMonster;

    theMonster := Me();
    ignore SetMachineActive(theMonster, theMonster@p_mMoveAction);
    if LightAt(Here()) then
	OPrint(Capitalize(CharacterNameG(theMonster)) + " has appeared.\n");
	ForEachAgent(Here(), ShowIconOnce);
    fi;
    MonsterReschedule(theMonster);
corp;

/*
 * MonsterNoNo - standard monster response to many actions.
 */

define t_fight proc public MonsterNoNo()status:

    Print("You don't want to do that!\n");
    fail
corp;

GenericMonster@p_pName := "MONSTER;GENERIC"$
GenericMonster@p_oTouchChecker := MonsterNoNo$
GenericMonster@p_oSmellChecker := MonsterNoNo$
GenericMonster@p_oPushChecker := MonsterNoNo$
GenericMonster@p_oPullChecker := MonsterNoNo$
GenericMonster@p_oTurnChecker := MonsterNoNo$
GenericMonster@p_oLiftChecker := MonsterNoNo$
GenericMonster@p_oLowerChecker := MonsterNoNo$
GenericMonster@p_oEatChecker := MonsterNoNo$
GenericMonster@p_pGivePre := monsterGivePre$
SetThingStatus(GenericMonster, ts_readonly)$

/*
 * CreateMonsterModel - create a new model monster.
 */

define t_fight proc public CreateMonsterModel(string name, desc;
	action initAction, moveAction;
	int hits, speed, protection, accuracy, damage, money)thing:
    thing theModel;

    theModel := CreateThing(GenericMonster);
    SetThingStatus(theModel, ts_readonly);
    theModel@p_pName := name;
    if desc ~= "" then
	theModel@p_pDesc := desc;
    else
	theModel@p_pDesc := "This is an ordinary " + FormatName(name) + ".";
    fi;
    if initAction ~= nil then
	theModel@p_mInitAction := initAction;
    fi;
    theModel@p_mMoveAction := moveAction;
    theModel@p_pHitMax := hits;
    theModel@p_pSpeed := speed;
    theModel@p_pProtection := protection;
    theModel@p_oAccuracy := accuracy;
    theModel@p_oDamage := damage;
    if money ~= 0 then
	theModel@p_pMoney := money;
    fi;
    /* Note that we put this extra description on the model, rather than
       on the individual monsters. This saves time and space, but can mess
       up if some code ends up wanting to add description stuff to
       monsters created this way. */
    AddFighterDesc(theModel);
    theModel
corp;

/*
 * AddModelAction - add a 'moves around' action to a model monster.
 *	Note: keep in mind that these messages are seen by both the player
 *	involved and by any bystanders. (So don't use 'you'!).
 */

define t_fight proc public AddModelAction(thing theModel; string a)void:
    list int li;
    int len;

    li := theModel@p_mActionIndexes;
    if li = nil then
	li := CreateIntList();
	theModel@p_mActionIndexes := li;
	theModel@p_mActions := a;
    else
	a := theModel@p_mActions + a;
	theModel@p_mActions := a;
    fi;
    AddTail(li, Length(a));
corp;

/*
 * checkMonsterCreation - a new monster has arrived. Tell all who care.
 */

define tp_fight proc checkMonsterCreation(thing theOther)void:
    action a;

    a := theOther@p_mCreateAction;
    if a ~= nil then
	call(a, void)(theOther, Me()@p_pNewMonster);
    fi;
corp;

/*
 * CreateMonster - create a new monster with random hitpoints.
 *	Note: this routine assumes it is called by a player.
 */

define t_fight proc public CreateMonster(thing theCreator,theModel,where)thing:
    thing theMonster, me;
    int hits;

    me := Me();
    theMonster := CreateThing(theModel);
    SetupMachine(theMonster);
    hits := theModel@p_pHitMax;
    hits := hits / 2 + Random(hits / 2) + 1;
    theMonster@p_pHitMax := hits;
    theMonster@p_pHitNow := hits;
    theMonster@p_pHitCount := 0;
    theMonster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    theMonster@p_pCurrentTarget := theCreator;
    theMonster@p_mExpired := false;
    CreateMachine(theModel@p_pName, theMonster, where, theModel@p_mInitAction);
    theCreator@p_pCurrentTarget := theMonster;
    me@p_pNewMonster := theMonster;
    ForEachAgent(where, checkMonsterCreation);
    me -- p_pNewMonster;
    PlayMonsterSound(theModel, me);
    theMonster
corp;

/*
 * CreateSpecificMonster - create a copy of a model monster.
 */

define t_fight proc public CreateSpecificMonster(
	thing theCreator, theModel, where)thing:
    thing theMonster, me;

    me := Me();
    theMonster := CreateThing(theModel);
    SetupMachine(theMonster);
    theMonster@p_pHitNow := theModel@p_pHitMax;
    theMonster@p_pHitCount := 0;
    theMonster@p_mMovesUntilVanish := RANDOM_MONSTER_LIFE;
    theMonster@p_pCurrentTarget := theCreator;
    CreateMachine(theModel@p_pName, theMonster, where, theModel@p_mInitAction);
    theCreator@p_pCurrentTarget := theMonster;
    me@p_pNewMonster := theMonster;
    ForEachAgent(where, checkMonsterCreation);
    me -- p_pNewMonster;
    PlayMonsterSound(theModel, me);
    theMonster
corp;

/*
 * PickNewMonster - pick a new monster for the player to fight.
 *	Return the thing of the generated monster, if any.
 */

define t_fight proc public PickNewMonster(thing theCreator, where)thing:
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
	    CreateMonster(theCreator, lt[count - 1], where)
	else
	    nil
	fi
    else
	nil
    fi
corp;

/* a 'checker' for healing and generating random monsters */

define tp_fight proc monsterEnterCheck()status:
    thing me, theMonster;
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
    theMonster := me@p_pCurrentTarget;
    if theMonster = nil and not Here()@p_rNoGenerateMonsters then
	theMonster := PickNewMonster(me, Here());
    fi;
    continue
corp;

/* a 'checker' to let monsters try to hit fleeing players */

define tp_fight proc monsterLeaveCheck(int dir)status:
    thing me, theMonster, here;
    int n;
    status result;

    result := continue;
    me := Me();
    theMonster := me@p_pCurrentTarget;
    if theMonster ~= nil then
	here := Here();
	if AgentLocation(theMonster) = here then
	    /* the monster I was fighting is still here with me */
	    n := Random(3);
	    if n = 0 and theMonster@p_mBlocker then
		if LightAt(here) then
		    Print(Capitalize(CharacterNameG(theMonster)) +
			" blocks you.\n");
		else
		    Print("Something blocks you.\n");
		fi;
		result := fail;
	    else
		if n = 1 and LightAt(here) then
		    if not MonsterHitPlayer(theMonster, me, here) then
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

define t_fight proc public StandardAttack(
	thing thePlayer, theTarget, where)void:
    int mSpeed;

    if theTarget@p_pStandard then
	/* a monster set up like a player, e.g. Packrat after being forced
	   into the proving grounds */
	if theTarget@p_pInited then
	    PlayerHitPlayer(theTarget);
	else
	    Print(Capitalize(CharacterNameS(theTarget)) +
		  " is not set up for fighting.\n");
	fi;
    else
	mSpeed := theTarget@p_pSpeed;
	if Random(thePlayer@p_pSpeed + mSpeed) < mSpeed then
	    /* monster hits first */
	    if MonsterHitPlayer(theTarget, thePlayer, where) then
		ignore PlayerHitMonster(thePlayer, theTarget);
	    fi;
	else
	    /* player hits first */
	    if PlayerHitMonster(thePlayer, theTarget) then
		ignore MonsterHitPlayer(theTarget, thePlayer, where);
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
	fighter@p_pStrength := STANDARD_STRENGTH;
	fighter@p_pSpeed := STANDARD_SPEED;
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
    thing me, theTarget, here;
    action a;

    me := Me();
    here := Here();
    if not me@p_pInited then
	Print("You are not yet set up for fighting.\n");
	false
    elif not CanSee(here, me) then
	Print("You can't see to fight.\n");
	false
    elif here@p_rMonsterList = nil then
	Print("This is a non-combat area.\n");
	false
    elif what = "" then
	Print("You flail around at nothing in particular.\n");
	if not me@p_pHidden then
	    OPrint(Capitalize(CharacterNameG(me)) + " flails around.\n");
	fi;
	true
    else
	theTarget := FindAgent(what);
	if theTarget = nil then
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
	    if ThingCharacter(theTarget) ~= nil then
		if theTarget = me then
		    Print("Masochism is not implemented.\n");
		else
		    /* attacking another player */
		    PlayerHitPlayer(theTarget);
		fi;
	    else
		/* attacking a monster */
		a := theTarget@p_mFightAction;
		if a ~= nil then
		    call(a, void)(theTarget);
		else
		    StandardAttack(me, theTarget, here);
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

Verb1(G, "status", 0, v_status)$
Synonym(G, "status", "st")$
Verb1(G, "wield", 0, v_wield)$
Verb1(G, "hit", 0, v_hit)$
Synonym(G, "hit", "fight")$
Synonym(G, "hit", "attack")$
Synonym(G, "hit", "kill")$
Synonym(G, "hit", "h")$
Synonym(G, "hit", "k")$
Verb0(G, "fightterse", 0, v_fightterse)$
Synonym(G, "fightterse", "fightbrief")$
Verb0(G, "fightsuperterse", 0, v_fightsuperterse)$
Synonym(G, "fightsuperterse", "fightsuperbrief")$
Verb0(G, "fightverbose", 0, v_fightverbose)$

unuse tp_fight
