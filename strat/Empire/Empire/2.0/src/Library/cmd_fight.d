#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g
#drinc:util.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * defend - allow a sector which is under attack to be defended by any
 *	defending fort. Return the percent damage done.
 *	Convention: the sector under attack is present but not locked.
 */

proc defend(int r, c; int aRow, aCol; uint dFactor)uint:
    register *Sector_t rs;
    int dRow, dCol;
    ulong rangeSq;
    register uint damage, techFactor;
    uint guns, mapped, victim;

    rs := &ES*.es_request.rq_u.ru_sector;
    damage := 0;
    if rs*.s_defender ~= NO_DEFEND then
	getDefender(r, c, rs, &dRow, &dCol);
	mapped := mapSector(dRow, dCol);
	victim := rs*.s_owner;
	techFactor := getTechFactor(victim);
	server(rt_lockSector, mapped);
	updateSector(dRow, dCol);
	guns := umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
	rangeSq := techFactor * guns;
	rangeSq := rangeSq * rangeSq / ES*.es_world.w_rangeDivisor / 100;
	if rs*.s_type = s_fortress and rs*.s_owner = victim and
	    readQuan(rs, it_military) >= 5 and
	    rs*.s_quantity[it_shells] ~= 0 and
	    guns ~= 0 and rs*.s_efficiency >= 60 and
	    rangeSq >= findDistance(aRow, aCol, dRow, dCol)
	then
	    writeQuan(rs, it_shells, readQuan(rs, it_shells) - 1);
	    server(rt_unlockSector, mapped);
	    damage := guns * rs*.s_efficiency / 100 + 10;
	    damage :=
		umin(100, damage * dFactor * ES*.es_world.w_gunScale / 100);
	    userS("Defensive fire from ", dRow, dCol, " inflicts ");
	    userN(damage);
	    user("% damage!!\n");
	    news(n_fire_back, victim, ES*.es_countryNumber);
	else
	    server(rt_unlockSector, mapped);
	fi;
	/* keep the calling convention maintained */
	server(rt_readSector, mapSector(r, c));
    fi;
    damage
corp;

/*
 * fight - general purpose fighting routine. Passed the coordinates and
 *	updated sector under attack, along with pointers to 4 counts of
 *	attackers and their strength bonuses. These counts are updated.
 *	This routine automatically handles any defenders and their strength,
 *	along with checking the attacker's BTU's.
 *	Convention: the sector under attack will be read and written.
 */

proc fight(int r, c; bool isAssault;
	   *uint pCTop	; uint sTop;
	   *uint pCLeft ; uint sLeft;
	   *uint pCRight; uint sRight;
	   *uint pCBot	; uint sBot)void:
    register *Sector_t rs;
    register *Country_t rc @ rs;
    register uint damage, cDef, attackers;
    uint defenders, cTop, cLeft, cRight, cBot, sDef, guns, mapped, victim;
    int btus;
    char ch;

    mapped := mapSector(r, c);
    server(rt_readSector, mapped);
    rs := &ES*.es_request.rq_u.ru_sector;
    victim := rs*.s_owner;
    cTop := pCTop*;
    cLeft := pCLeft*;
    cRight := pCRight*;
    cBot := pCBot*;
    cDef := readQuan(rs, it_military);
    sDef :=
	if isAssault then
	    case rs*.s_type
	    incase s_fortress:
		(ES*.es_world.w_assFortAdv - 1) * rs*.s_efficiency / 100 + 1
	    incase s_capital:
		(ES*.es_world.w_assCapAdv - 1) * rs*.s_efficiency / 100 + 1
	    incase s_bank:
		(ES*.es_world.w_assBankAdv - 1) * rs*.s_efficiency / 100 + 1
	    default:
		1
	    esac
	else
	    case rs*.s_type
	    incase s_fortress:
		(ES*.es_world.w_attFortAdv - 1) * rs*.s_efficiency / 100 + 1
	    incase s_capital:
		(ES*.es_world.w_attCapAdv - 1) * rs*.s_efficiency / 100 + 1
	    incase s_bank:
		(ES*.es_world.w_attBankAdv - 1) * rs*.s_efficiency / 100 + 1
	    default:
		1
	    esac
	fi;
    /* defensive fire from this sector if it is a fortress */
    guns := umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
    if rs*.s_type = s_fortress and readQuan(rs, it_military) >= 5 and
	readQuan(rs, it_shells) ~= 0 and guns ~= 0 and rs*.s_efficiency >= 60
    then
	damage := guns * rs*.s_efficiency / 100 + 10;
	damage := umin(100, damage * ES*.es_world.w_gunScale / 100);
	server(rt_lockSector, mapped);
	if readQuan(rs, it_shells) ~= 0 then
	    writeQuan(rs, it_shells, readQuan(rs, it_shells) - 1);
	    server(rt_unlockSector, mapped);
	    userS("Defensive fire from ", r, c, " inflicts ");
	    userN(damage);
	    user("% damage!!\n");
	    cTop := damageUnit(cTop, damage);
	    cLeft := damageUnit(cLeft, damage);
	    cRight := damageUnit(cRight, damage);
	    cBot := damageUnit(cBot, damage);
	else
	    server(rt_unlockSector, mapped);
	fi;
    fi;
    /* defensive fire from any defending fortress */
    damage := defend(r, c, r, c, 1);
    cTop := damageUnit(cTop, damage);
    cLeft := damageUnit(cLeft, damage);
    cRight := damageUnit(cRight, damage);
    cBot := damageUnit(cBot, damage);
    /* scale BTU's to get required accuracy */
    btus := ES*.es_country.c_btu * 100;
    while
	attackers := cTop   * sTop   + cLeft * sLeft +
		     cRight * sRight + cBot  * sBot;
	defenders := cDef * sDef;
	if isAssault then
	    defenders := defenders * ES*.es_world.w_assAdv / 100;
	fi;
	btus > 0 and attackers ~= 0 and defenders ~= 0
    do
	if random(attackers + defenders) >= attackers then
	    /* an attacker has bit the bullet */
	    btus := btus - ES*.es_world.w_deathFactor;
	    ch := '@';
	    damage := random(attackers);
	    if damage < cTop * sTop then
		cTop := cTop - 1;
		if cTop = 0 then
		    ch := '*';
		fi;
	    elif damage < cTop * sTop + cLeft * sLeft then
		cLeft := cLeft - 1;
		if cLeft = 0 then
		    ch := '*';
		fi;
	    elif damage < cTop * sTop + cLeft * sLeft + cRight * sRight then
		cRight := cRight - 1;
		if cRight = 0 then
		    ch := '*';
		fi;
	    else
		if cBot = 0 then
		    user("!!! fight mucked up - tell system owner !!!\n");
		    cBot := 1;
		fi;
		cBot := cBot - 1;
		if cBot = 0 then
		    ch := '*';
		fi;
	    fi;
	else
	    /* a defender has bit the bullet */
	    cDef := cDef - 1;
	    ch := '!';
	fi;
	sleep(random(20));
	userC(ch);
	uFlush();
    od;
    userNL();
    userTarget(victim, "Your sector ", r, c, " has been ");
    user(if isAssault then "assault" else "attack" fi);
    if cDef = 0 then
	user3("ed and taken over by ", &ES*.es_country.c_name[0], "!");
	notify(victim);
	user("You have won the sector!\n");
	server(rt_readCountry, victim);
	if ES*.es_request.rq_u.ru_country.c_status ~= cs_deity then
	    news(n_won_sector, ES*.es_countryNumber, victim);
	fi;
	/* the attacker gets NONE of any pending work in the taken-over sector.
	   If you want him to, you should only do the following line if the
	   sector WAS owned by the Deity, and you should call
	   adjustForNewWorkers after putting military into the sector. */
	server(rt_lockSector, mapped);
	rs*.s_lastUpdate := timeNow();		/* this kills the work */
	rs*.s_owner := ES*.es_countryNumber;
	rs*.s_defender := NO_DEFEND;
	rs*.s_checkPoint := 0;
	/* the taken-over sector should be occupied - we apportion up to 127
	   troops from the various attacking sectors, in proportion to the
	   number left from each attacking sector */
	attackers := 0;
	while attackers ~= 127 and cTop + cLeft + cRight + cBot ~= 0 do
	    attackers := attackers + 1;
	    damage := random(cTop + cLeft + cRight + cBot);
	    if damage < cTop then
		cTop := cTop - 1;
	    elif damage < cTop + cLeft then
		cLeft := cLeft - 1;
	    elif damage < cTop + cLeft + cRight then
		cRight := cRight - 1;
	    else
		if cBot = 0 then
		    /* printed while sector locked, but I've never seen this
		       message, so this code must work. */
		    user("!!! fight blew it, tell system owner !!!\n");
		    cBot := 1;
		fi;
		cBot := cBot - 1;
	    fi;
	od;
	writeQuan(rs, it_military, attackers);
	server(rt_unlockSector, mapped);
	if victim ~= 0 then
	    server(rt_lockCountry, victim);
	    rc*.c_sectorCount := rc*.c_sectorCount - 1;
	    if rc*.c_sectorCount = 0 and victim ~= ES*.es_countryNumber then
		/* the target country is kaput!!!! */
		rc*.c_status := cs_dead;
		server(rt_unlockCountry, victim);
		user3("Country ", &rc*.c_name[0], " has been destroyed!!!\n");
		news(n_destroyed, ES*.es_countryNumber, victim);
	    else
		server(rt_unlockCountry, victim);
	    fi;
	fi;
	server(rt_lockCountry, ES*.es_countryNumber);
	rc*.c_sectorCount := rc*.c_sectorCount + 1;
	server(rt_unlockCountry, ES*.es_countryNumber);
	ES*.es_country.c_sectorCount := rc*.c_sectorCount;
    else
	user3("ed by ", &ES*.es_country.c_name[0], "!");
	notify(victim);
	if cTop + cLeft + cRight + cBot = 0 then
	    news(n_lost_sector, ES*.es_countryNumber, victim);
	    user("You have been defeated!\n");
	else
	    user3("You ran out of BTU's - ",
		  if isAssault then "assault" else "attack" fi,
		  " aborted!\n");
	fi;
	server(rt_lockSector, mapped);
	writeQuan(rs, it_military, cDef);
	server(rt_unlockSector, mapped);
    fi;
    ES*.es_country.c_btu := btus / 100;
    server(rt_lockCountry, ES*.es_countryNumber);
    rc*.c_btu := ES*.es_country.c_btu;
    server(rt_unlockCountry, ES*.es_countryNumber);
    pCTop* := cTop;
    pCLeft* := cLeft;
    pCRight* := cRight;
    pCBot* := cBot;
corp;

/*
 * getCount - get a number of attackers from the given sector, charge mobility
 *	for them (and limit the number by that mobility), and update the
 *	military count.
 *	Convention: the sector will be read and written here.
 */

proc getCount(int r, c; SectorType_t targetDesig;
	      *uint pSoldiers, pStrengthFactor)bool:
    register *Sector_t rs;
    ulong cost;
    uint count1, mapped, mil;
    register uint count;
    [100] char buffer;
    bool shrank;

    pSoldiers* := 0;
    pStrengthFactor* := 1;

    mapped := mapSector(r, c);
    server(rt_readSector, mapped);
    rs := &ES*.es_request.rq_u.ru_sector;
    mil := readQuan(rs, it_military);
    cost := ES*.es_world.w_attackMobilityCost[
		case targetDesig
		incase s_highway:
		    0
		incase s_wilderness:
		    2
		incase s_mountain:
		    3
		default:
		    1
		esac,
		case rs*.s_type
		incase s_highway:
		    0
		incase s_wilderness:
		    2
		incase s_mountain:
		    3
		default:
		    1
		esac];
    count := make(rs*.s_mobility, ulong) * 1000 / cost;
    if rs*.s_owner = ES*.es_countryNumber and mil ~= 0 then
	if count = 0 then
	    userS("Not enough mobility in ", r, c, ".\n");
	    true
	else
	    if count > mil then
		count := mil;
	    fi;
	    userN(mil);
	    userS(" military in ", r, c, "; how many attack (max ");
	    userN(count);
	    user(")? ");
	    getPrompt(&buffer[0]);
	    if reqPosRange(&count1, count, &buffer[0]) and count1 >= 0 then
		count := count1;
		shrank := false;
		server(rt_lockSector, mapped);
		updateSector(r, c);
		mil := readQuan(rs, it_military);
		if mil < count then
		    shrank := true;
		    count := mil;
		fi;
		if count * cost / 1000 > rs*.s_mobility then
		    shrank := true;
		    count := make(rs*.s_mobility, ulong) * 1000 / cost;
		fi;
		rs*.s_mobility := rs*.s_mobility - count * cost / 1000;
		writeQuan(rs, it_military, mil - count);
		server(rt_unlockSector, mapped);
		if shrank then
		    userN3("Actions have reduced the count to ", count, "!\n");
		fi;
		pSoldiers* := count;
		pStrengthFactor* :=
		    if rs*.s_type = s_fortress then
			(ES*.es_world.w_fortAdv - 1) * rs*.s_efficiency / 100
			    + 1
		    else
			1
		    fi;
		if count ~= 0 and rs*.s_type = s_sanctuary then
		    user("You are breaking sanctuary!!!\n");
		    server(rt_lockSector, mapped);
		    rs*.s_type := s_capital;
		    server(rt_unlockSector, mapped);
		    news(n_broke_sanctuary, ES*.es_countryNumber, NOBODY);
		fi;
		true
	    else
		false
	    fi
	fi
    else
	true
    fi
corp;

proc aTestSec(int r, c)uint:

    server(rt_readSector, mapSector(r, c));
    if ES*.es_request.rq_u.ru_sector.s_owner = ES*.es_countryNumber then
	accessSector(r, c);
	1
    else
	0
    fi
corp;

proc aFixSec(int r, c; uint milBack)void:
    register *Sector_t rs;
    register *Country_t rc @ rs;
    uint mapped;

    mapped := mapSector(r, c);
    server(rt_lockSector, mapped);
    writeQuan(rs, it_military, readQuan(rs, it_military) + milBack);
    if rs*.s_quantity[it_civilians] = 0 and rs*.s_quantity[it_military] = 0
    then
	rs*.s_owner := 0;
	server(rt_unlockSector, mapped);
	userS("You have deserted sector ", r, c, "!\n");
	server(rt_lockCountry, ES*.es_countryNumber);
	rc*.c_sectorCount := rc*.c_sectorCount - 1;
	server(rt_unlockCountry, ES*.es_countryNumber);
	ES*.es_country.c_sectorCount := rc*.c_sectorCount;
	if rc*.c_sectorCount = 0 then
	    user("You have committed national suicide!!\n");
	    server(rt_lockCountry, ES*.es_countryNumber);
	    rc*.c_status := cs_dead;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    ES*.es_country.c_status := cs_dead;
	fi;
    else
	server(rt_unlockSector, mapped);
    fi;
corp;

proc cmd_attack()bool:
    register *Sector_t rs;
    uint mobilityCost, mobility, mTop, mBot, mLeft, mRight;
    uint cTop, cBot, cLeft, cRight, sTop, sBot, sLeft, sRight;
    register int r, c;
    int n, rReal, cReal, r1, c1;
    uint targetMil, targetEffic, victim;
    SectorType_t tDes;
    bool aTop, aLeft, aRight, aBot, attacking;

    if reqSector(&rReal, &cReal, "Attack which sector? ") then
	r := rReal;
	c := cReal;
	accessSector(r, c);
	rs := &ES*.es_request.rq_u.ru_sector;
	tDes := rs*.s_type;
	targetMil := readQuan(rs, it_military) / 10 * 10;
	targetEffic := rs*.s_efficiency;
	victim := rs*.s_owner;
	if aTestSec(r - 1, c) + aTestSec(r, c - 1) + aTestSec(r, c + 1) +
		aTestSec(r + 1, c) = 0
	then
	    err("you don't have any neighbouring sectors");
	elif tDes = s_sanctuary then
	    err("can't attack sanctuaries");
	elif tDes = s_water then
	    err("can't attack water");
	else
	    userS("Sector ", r, c, " is a ");
	    userN(targetEffic);
	    user2("% ", getDesigName(tDes));
	    userN3(" with ", targetMil, " military or so.\n");
	    ES*.es_textInPos* := '\e';
	    aLeft := false;
	    aRight := false;
	    aBot := false;
	    attacking := getCount(r - 1, c, tDes, &cTop, &sTop);
	    aTop := cTop ~= 0;
	    if attacking then
		attacking := getCount(r, c - 1, tDes, &cLeft, &sLeft);
		aLeft := cLeft ~= 0;
	    fi;
	    if attacking then
		attacking := getCount(r, c + 1, tDes, &cRight, &sRight);
		aRight := cRight ~= 0;
	    fi;
	    if attacking then
		attacking := getCount(r + 1, c, tDes, &cBot, &sBot);
		aBot := cBot ~= 0;
	    fi;
	    if attacking then
		if cTop + cLeft + cRight + cBot = 0 then
		    err("no soldiers to attack with");
		else
		    fight(r, c, false,
			  &cTop  , sTop  , &cLeft, sLeft,
			  &cRight, sRight, &cBot , sBot );
		fi;
	    else
		user(&ES*.es_country.c_name[0]);
		userTarget(victim, " attempted to attack sector ", r, c, "!");
		notify(victim);
	    fi;
	    if aTop then
		aFixSec(r - 1, c, cTop);
	    fi;
	    if aLeft then
		aFixSec(r, c - 1, cLeft);
	    fi;
	    if aRight then
		aFixSec(r, c + 1, cRight);
	    fi;
	    if aBot then
		aFixSec(r + 1, c, cBot);
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_fire()bool:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    [100] char buf;
    register uint damage, aGuns, aShells;
    uint aMapped, dMapped, dTech;
    uint dShNum, aShNum, aMil, aRange, temp, aEffic,
	dGuns, dShells, dRange, dEffic, distance, defender;
    int dRow, dCol, aRow, aCol;
    ShipType_t aType;
    bool dIsShip, aIsShip, aborting, dIsSub, sank;

    if reqSectorOrShip(&dRow, &dCol, &dShNum, &dIsShip,
		       "Sector or ship to fire on? ") and
	doSkipBlanks() and
	reqSectorOrShip(&aRow, &aCol, &aShNum, &aIsShip,
			"Sector or ship to fire from? ")
    then
	aborting := false;
	rs := &ES*.es_request.rq_u.ru_sector;
	if aIsShip then
	    server(rt_readShip, aShNum);
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
		aborting := true;
	    else
		accessShip(aShNum);
		aType := rsh*.sh_type;
		aEffic := rsh*.sh_efficiency;
		aGuns := rsh*.sh_guns;
		aShells := rsh*.sh_shells;
		if aType = st_freighter then
		    err("freighters can't fire guns");
		    aborting := true;
		elif aType = st_submarine then
		    err("submarines can't fire guns");
		    aborting := true;
		elif aGuns = 0 then
		    user("No guns available, captain!\n");
		    aborting := true;
		elif aShells = 0 then
		    user("Click!\n");
		    aborting := true;
		elif aEffic < 60 then
		    err("ship not efficient enough to fire");
		    aborting := true;
		else
		    aRow := rowToMe(rsh*.sh_row);
		    aCol := colToMe(rsh*.sh_col);
		    aMapped := mapAbsSector(rsh*.sh_row, rsh*.sh_col);
		    aRange := ES*.es_world.w_shipShRange[aType] *
			getShipTechFactor(rsh) / 2;
		    if aType = st_tender then
			aGuns := 1;
		    fi;
		fi;
	    fi;
	else
	    aMapped := mapSector(aRow, aCol);
	    accessSector(aRow, aCol);
	    aMil := readQuan(rs, it_military);
	    aGuns := umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
	    aShells := readQuan(rs, it_shells);
	    aEffic := rs*.s_efficiency;
	    if rs*.s_owner ~= ES*.es_countryNumber then
		err("you don't own that sector");
		aborting := true;
	    elif rs*.s_type ~= s_fortress then
		err("that sector isn't a fortress");
		aborting := true;
	    elif aEffic < 60 then
		err("fortress not efficient enough to fire");
		aborting := true;
	    elif aGuns = 0 then
		user("We have no guns to fire, sir!\n");
		aborting := true;
	    elif aMil < 5 then
		user("We have no firing crew, sir!\n");
		aborting := true;
	    elif aShells = 0 then
		user("Click!!\n");
		aborting := true;
	    else
		aRange := aGuns * getTechFactor(ES*.es_countryNumber);
	    fi;
	fi;
	if not aborting then
	    if dIsShip then
		server(rt_readShip, dShNum);
		dIsSub := rsh*.sh_type = st_submarine;
		defender := rsh*.sh_owner;
		if defender = 0 then
		    userN3("Ship \#", dShNum,
			   " lies arusting at the bottom of deep blue sea!\n");
		    aborting := true;
		else
		    dRow := rowToMe(rsh*.sh_row);
		    dCol := colToMe(rsh*.sh_col);
		fi;
	    else
		accessSector(dRow, dCol);
		defender := rs*.s_owner;
		dEffic := rs*.s_efficiency;
		if rs*.s_type = s_sanctuary then
		    if aIsShip then
			server(rt_lockShip, aShNum);
			aShells := rsh*.sh_shells;
			aGuns := rsh*.sh_guns;
			if aShells < aGuns then
			    aGuns := aShells;
			fi;
			rsh*.sh_shells := aShells - aGuns;
			server(rt_unlockShip, aShNum);
		    else
			server(rt_lockSector, aMapped);
			aShells := readQuan(rs, it_shells);
			aGuns :=
			    umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
			if aShells = 0 then
			    aGuns := 0;
			fi;
			if aGuns ~= 0 then
			    writeQuan(rs, it_shells, aShells - 1);
			fi;
			server(rt_unlockSector, aMapped);
		    fi;
		    if aGuns ~= 0 then
			user("Bounce!!\n");
			news(n_shell_sector, ES*.es_countryNumber, defender);
		    fi;
		    aborting := true;
		fi;
	    fi;
	fi;
	if not aborting then
	    distance := findDistance(aRow, aCol, dRow, dCol);
	fi;
	if aborting then
	    ;
	elif distance > make(aRange, ulong) * aRange /
		    ES*.es_world.w_rangeDivisor / 100
	then
	    err("out of range");
	    aborting := true;
	else
	    if aIsShip and aGuns > 1 then
		aGuns := umin(aGuns, aShells);
		ignore skipBlanks();
		userN3("Fire how many guns (max ", aGuns, ")? ");
		getPrompt(&buf[0]);
		aborting := not reqPosRange(&temp, aGuns, &buf[0]);
		aGuns := temp;
	    fi;
	fi;
	if not aborting and dIsShip then
	    accessShip(dShNum);
	    defender := rsh*.sh_owner;
	    if defender = 0 then
		user("The hurricane sank that ship for you!\n");
		aborting := true;
	    fi;
	fi;
	if not aborting then
	    if aIsShip then
		server(rt_lockShip, aShNum);
		aShells := rsh*.sh_shells;
		if aGuns > aShells then
		    aGuns := aShells;
		fi;
		if aGuns > rsh*.sh_guns then
		    aGuns := rsh*.sh_guns;
		fi;
		rsh*.sh_shells := aShells - aGuns;
		server(rt_unlockShip, aShNum);
		if aType = st_battleship then
		    aGuns := aGuns * 4;
		elif aType = st_carrier or aType = st_destroyer then
		    aGuns := aGuns * 2;
		fi;
	    else
		server(rt_lockSector, aMapped);
		aShells := readQuan(rs, it_shells);
		aGuns := umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
		if aShells ~= 0 then
		    writeQuan(rs, it_shells, aShells - 1);
		fi;
		server(rt_unlockSector, aMapped);
	    fi;
	    damage := aGuns * aEffic / 100 + if aIsShip then 5 else 10 fi;
	    damage := umin(100, damage * ES*.es_world.w_gunScale / 100);
	    user("Kaboom!!\n");
	    if dIsShip then
		sank := false;
		if dIsSub then
		    user("Splash!\n");
		else
		    user(&ES*.es_country.c_name[0]);
		    if aIsShip then
			user3(" ", getShipName(aType), " ");
			userN(aShNum);
		    else
			userTarget(defender, " fortress at ", aRow, aCol, "");
		    fi;
		    getPrompt(&buf[0]);
		    attackShip(dShNum, damage, at_shell, &buf[0]);
		fi;

		/* defensive fire from all ships nearby! */

		dShNum := 0;
		while dShNum ~= ES*.es_world.w_shipNext and not aborting do
		    server(rt_readShip, dShNum);
		    if rsh*.sh_owner = defender and
			rsh*.sh_type ~= st_freighter and
			rsh*.sh_type ~= st_submarine
		    then
			dRow := rowToMe(rsh*.sh_row);
			dCol := colToMe(rsh*.sh_col);
			dRange := ES*.es_world.w_shipShRange[rsh*.sh_type] *
			    getShipTechFactor(rsh) / 2;
			if rsh*.sh_guns ~= 0 and rsh*.sh_shells ~= 0 and
			    findDistance(aRow, aCol, dRow, dCol) <=
				make(dRange, ulong) * dRange /
				ES*.es_world.w_rangeDivisor / 100
			then
			    server(rt_lockShip, dShNum);
			    updateShip(dShNum);
			    dEffic := rsh*.sh_efficiency;
			    dGuns := rsh*.sh_guns;
			    dShells := rsh*.sh_shells;
			    if dEffic >= 60 and dGuns ~= 0 and dShells ~= 0
			    then
				/* account for strength of guns, but the
				   defending ships only fire a single gun */
				dGuns :=
				    case rsh*.sh_type
				    incase st_battleship:
					4
				    incase st_carrier:
				    incase st_destroyer:
					2
				    default:
					1
				    esac;
				rsh*.sh_shells := rsh*.sh_shells - 1;
				server(rt_unlockShip, dShNum);
				damage := dGuns * dEffic / 100 + 5;
				damage :=
				    damage * ES*.es_world.w_gunScale / 100;
				if aIsShip then
				    damage :=
				       ES*.es_world.w_shipDamage[aType] *
					    damage;
				fi;
				damage := umin(100, damage);
				user2("Defensive fire from ",
				      getShipName(rsh*.sh_type));
				userN2(" \#", dShNum);
				userS(" at ", dRow, dCol, " does ");
				userN(damage);
				user("% damage!\n");
				if aIsShip then
				    server(rt_lockShip, aShNum);
				    damageShip(aShNum, damage);
				    if rsh*.sh_owner = 0 then
					aborting := true;
				    fi;
				    server(rt_unlockShip, aShNum);
				else
				    server(rt_lockSector, aMapped);
				    damageSector(aMapped, damage, defender);
				    server(rt_unlockSector, aMapped);
				    if rs*.s_owner = 0 then
					user("Fortress destroyed!!\n");
					aborting := true;
				    fi;
				fi;
				news(n_fire_back, defender,
				     ES*.es_countryNumber);
			    else
				server(rt_unlockShip, dShNum);
			    fi;
			fi;
		    fi;
		    dShNum := dShNum + 1;
		od;
	    else
		news(n_shell_sector, ES*.es_countryNumber, defender);
		user(&ES*.es_country.c_name[0]);
		userTarget(defender, " shelled your sector ", dRow, dCol, "!");
		notify(defender);
		/* this requires reading the country record */
		dTech := getTechFactor(defender);
		dMapped := mapSector(dRow, dCol);
		userN3("Shell does ", damage, "% damage.\n");
		server(rt_lockSector, dMapped);
		damageSector(dMapped, damage, ES*.es_countryNumber);
		dEffic := rs*.s_efficiency;
		dGuns := umin(ES*.es_world.w_gunMax, readQuan(rs, it_guns));
		dShells := readQuan(rs, it_shells);
		dRange := dGuns * dTech;

		/* Now try to fire back. Note: the sector is locked. */

		if rs*.s_type = s_fortress and dGuns ~= 0 and
		    rs*.s_quantity[it_military] >= 5 and
		    dShells ~= 0 and dEffic >= 60 and
		    distance <= make(dRange, ulong) * dRange /
				    ES*.es_world.w_rangeDivisor / 100
		then
		    writeQuan(rs, it_shells, dShells - 1);
		    server(rt_unlockSector, dMapped);
		    news(n_fire_back, defender, ES*.es_countryNumber);
		    damage := dGuns * dEffic / 100 + 10;
		    damage := damage * ES*.es_world.w_gunScale / 100;
		    if aIsShip then
			damage := ES*.es_world.w_shipDamage[aType] * damage;
			damage := umin(100, damage);
			userN3("Return fire does ", damage, "% damage!\n");
			server(rt_lockShip, aShNum);
			damageShip(aShNum, damage);
			server(rt_unlockShip, aShNum);
		    else
			damage := umin(100, damage);
			userN3("Return fire does ", damage, "% damage!\n");
			server(rt_lockSector, aMapped);
			damageSector(aMapped, damage, defender);
			server(rt_unlockSector, aMapped);
		    fi;
		    /* read it back so 'defend' can work */
		    server(rt_readSector, dMapped);
		else
		    server(rt_unlockSector, dMapped);
		fi;
		if rs*.s_type = s_bridgeHead and rs*.s_efficiency < 20 then
		    collapseSpans(dRow, dCol);
		    server(rt_readSector, dMapped);
		fi;
		if aIsShip then
		    damage := defend(dRow, dCol, aRow, aCol,
				     ES*.es_world.w_shipDamage[aType]);
		    server(rt_lockShip, aShNum);
		    damageShip(aShNum, damage);
		    server(rt_unlockShip, aShNum);
		else
		    damage := defend(dRow, dCol, aRow, aCol, 1);
		    server(rt_lockSector, dMapped);
		    damageSector(aMapped, damage, defender);
		    server(rt_unlockSector, dMapped);
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_board()bool:
    [100] char buf;
    Fleet_t f;
    register *[2]Ship_t rp;
    register *Ship_t rsh @ rp;
    register uint attackers, defenders;
    uint aCrew, dShNum, aShNum, temp, victim, aRow, aCol;
    int btus;
    ShipType_t dType;
    char ch;
    bool defended;

    if reqShip(&dShNum, "Board which ship? ") and
	doSkipBlanks() and
	reqShip(&aShNum, "Board from which ship? ")
    then
	server2(rt_readShipPair, aShNum, dShNum);
	rp := &ES*.es_request.rq_u.ru_shipPair;
	aRow := rp*[0].sh_row;
	aCol := rp*[0].sh_col;
	if rp*[0].sh_owner ~= ES*.es_countryNumber then
	    err("you don't own that ship");
	elif rp*[0].sh_type = st_freighter then
	    err("you can't board from a freighter");
	elif weather(rp*[0].sh_row, rp*[0].sh_col) <= STORM_FORCE then
	    err("weather is too bad for boarding");
	elif rp*[0].sh_crew = 0 then
	    err("attacking ship has no crew on board");
	elif rp*[0].sh_efficiency < 60 then
	    err("attacking ship isn't efficient enough");
	elif rp*[1].sh_owner = 0 then
	    err("target ship is sunk");
	elif rp*[1].sh_row ~= aRow or rp*[1].sh_col ~= aCol then
	    err("target ship is too far away");
	else
	    accessShip(aShNum);
	    aCrew := rsh*.sh_crew;
	    accessShip(dShNum);
	    victim := rsh*.sh_owner;
	    dType := rsh*.sh_type;
	    defended := false;
	    if dType = st_freighter and rsh*.sh_fleet ~= '*' then
		temp := fleetPos(rsh*.sh_fleet);
		server(rt_readCountry, victim);
		server(rt_readFleet,
		       ES*.es_request.rq_u.ru_country.c_fleets[temp]);
		f := ES*.es_request.rq_u.ru_fleet;
		temp := 0;
		while temp ~= f.f_count and not defended do
		    server(rt_readShip, f.f_ship[temp]);
		    if rsh*.sh_row = aRow and rsh*.sh_col = aCol and
			rsh*.sh_type ~= st_freighter
		    then
			defended := true;
			userN3("Freighter \#", dShNum,
			       " is protected by its fleet.\n");
		    fi;
		    temp := temp + 1;
		od;
	    fi;
	    if not defended then
		ignore skipBlanks();
		userN3("Board with how many (max ", aCrew, ")? ");
		getPrompt(&buf[0]);
		if reqPosRange(&temp, aCrew, &buf[0]) and temp ~= 0 then
		    server(rt_lockShip, aShNum);
		    aCrew := rsh*.sh_crew;
		    rsh*.sh_crew := aCrew - temp;
		    server(rt_unlockShip, aShNum);
		    attackers := temp;
		    if dType = st_freighter then
			defenders := 0;
		    else
			server(rt_lockShip, dShNum);
			defenders := rsh*.sh_crew;
			rsh*.sh_crew := 0;
			server(rt_unlockShip, dShNum);
		    fi;
		    btus := ES*.es_country.c_btu * 100;
		    while attackers ~= 0 and defenders ~= 0 and btus > 0 do
			if random(attackers +
			    defenders * ES*.es_world.w_boardAdv / 100) >=
				attackers
			then
			    /* an attacker has died */
			    ch := '@';
			    attackers := attackers - 1;
			    btus := btus - ES*.es_world.w_deathFactor;
			else
			    ch := '!';
			    defenders := defenders - 1;
			fi;
			sleep(random(20));
			userC(ch);
			uFlush();
		    od;
		    userNL();
		    if defenders = 0 then
			user2("You have taken ", getShipName(dType));
			userN3(" \#", dShNum, "!\n");
			user("You have taken the ship!\n");
			server(rt_lockShip, dShNum);
			removeFromFleet(victim, dShNum);
			rsh*.sh_owner := ES*.es_countryNumber;
			if dType = st_freighter then
			    server(rt_unlockShip, dShNum);
			    server(rt_lockShip, aShNum);
			else
			    defenders := ES*.es_world.w_shipCapacity
				    [it_military][rsh*.sh_type];
			    if attackers < defenders then
				defenders := attackers;
			    fi;
			    attackers := attackers - defenders;
			    rsh*.sh_crew := defenders;
			    server(rt_unlockShip, dShNum);
			    server(rt_lockShip, aShNum);
			fi;
			rsh*.sh_crew := rsh*.sh_crew + attackers;
			server(rt_unlockShip, aShNum);
			news(n_board_ship, ES*.es_countryNumber, victim);
			user3(&ES*.es_country.c_name[0], " boarded your ",
			      getShipName(dType));
			userN3(" \#", dShNum, "!");
			notify(victim);
		    else
			server(rt_lockShip, dShNum);
			rsh*.sh_crew := defenders;
			server(rt_unlockShip, dShNum);
			if attackers = 0 then
			    news(n_failed_board, ES*.es_countryNumber, victim);
			    user("You were repelled!\n");
			else
			    user("You ran out of BTUs - boarding aborted.\n");
			fi;
			user3(&ES*.es_country.c_name[0],
			      " attempted to board your ",
			      getShipName(dType));
			userN3(" \#", dShNum, ".");
			notify(victim);
		    fi;
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_btu := btus / 100;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    ES*.es_country.c_btu :=
			ES*.es_request.rq_u.ru_country.c_btu;
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_assault()bool:
    [100] char buf;
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    uint shipNumber, crew, attackers, z;
    int r, c, sRow, sCol;
    bool reduced;

    if reqSector(&r, &c, "Assault which sector? ") and
	doSkipBlanks() and
	reqShip(&shipNumber, "Assault from which ship? ")
    then
	accessShip(shipNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	crew := readShipQuan(rsh, it_military);
	sRow := rowToMe(rsh*.sh_row);
	sCol := colToMe(rsh*.sh_col);
	if rsh*.sh_owner ~= ES*.es_countryNumber then
	    err("you don't own that ship");
	else
	    if rsh*.sh_type = st_freighter then
		err("can't assault from a freighter");
	    elif rsh*.sh_efficiency < 60 then
		err("ship not efficient enough to assault");
	    elif weather(rsh*.sh_row, rsh*.sh_col) <= STORM_FORCE then
		err("weather is too bad for assaulting");
	    elif crew = 0 then
		err("no crew to assault with");
	    elif |(sRow - r) > 1 or |(sCol - c) > 1 then
		err("that ship isn't adjacent to that sector");
	    else
		accessSector(r, c);
		if rs*.s_type = s_sanctuary then
		    err("can't assault sanctuaries");
		elif rs*.s_type = s_water then
		    err("can't assault water");
		else
		    ignore skipBlanks();
		    userN3("Assault with how many marines (max ", crew, ")? ");
		    getPrompt(&buf[0]);
		    if reqPosRange(&attackers, crew, &buf[0]) and
			attackers ~= 0
		    then
			server(rt_lockShip, shipNumber);
			crew := readShipQuan(rsh, it_military);
			reduced := false;
			if attackers > crew then
			    reduced := true;
			    attackers := crew;
			fi;
			writeShipQuan(rsh, it_military, crew - attackers);
			server(rt_unlockShip, shipNumber);
			if reduced then
			    userN3("Actions reduced your force to ", attackers,
				   "!\n");
			fi;
			z := 0;
			fight(r, c, true, &attackers, 1, &z, 0, &z, 0, &z, 0);
		    fi;
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;
