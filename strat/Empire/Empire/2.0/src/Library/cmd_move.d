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

/* result type of the various 'xxxOnce' routines: */

type
    Move_t = enum {m_readMore, m_continue, m_drown, m_done};

/*
 * moveDir - get cost and move code from one character of moving.
 */

proc moveDir(**char ptr; *int pRow, pCol; *ulong pCost)Move_t:
    ulong cost;
    register int r, c;
    char ch, ch2;
    Move_t result;

    result := m_continue;
    cost := pCost*;
    r := pRow*;
    c := pCol*;
    ch := ptr**;
    ptr* := ptr* + 1;
    case ch
    incase 'u':
    incase 'd':
    incase 'l':
    incase 'r':
    incase '8':
    incase '4':
    incase '6':
    incase '2':
	case ch
	incase 'u':
	incase '8':
	    r := r - 1;
	incase 'd':
	incase '2':
	    r := r + 1;
	incase 'l':
	incase '4':
	    c := c - 1;
	incase 'r':
	incase '6':
	    c := c + 1;
	esac;
    incase '\\':
    incase '/':
	ch2 := ptr**;
	if ch2 = 'l' or ch2 = 'r' then
	    ptr* := ptr* + 1;
	    cost := cost * 141 / 100;
	    if ch = '\\' then
		if ch2 = 'l' then
		    r := r - 1;
		    c := c - 1;
		else
		    r := r + 1;
		    c := c + 1;
		fi;
	    else
		if ch2 = 'l' then
		    r := r + 1;
		    c := c - 1;
		else
		    r := r - 1;
		    c := c + 1;
		fi;
	    fi;
	else
	    err("illegal direction character after '/' or '\\'");
	    result := m_readMore;
	fi;
    incase '7':
    incase '9':
    incase '1':
    incase '3':
	cost := cost * 141 / 100;
	case ch
	incase '7':
	    r := r - 1;
	    c := c - 1;
	incase '9':
	    r := r - 1;
	    c := c + 1;
	incase '1':
	    r := r + 1;
	    c := c - 1;
	incase '3':
	    r := r + 1;
	    c := c + 1;
	esac;
    incase 'e':
    incase '.':
	result := m_done;
    incase '\e':
	result := m_readMore;
    default:
	err("illegal direction character");
	result := m_readMore;
    esac;
    pRow* := r;
    pCol* := c;
    pCost* := cost;
    result
corp;

/*
 * moveOnce - pull off and execute one move action.
 */

proc moveOnce(**char ptr; *int pRow, pCol; *uint pMob; *bool pPlague;
	      register ulong cost)Move_t:
    register *Sector_t rs;
    ulong costReal;
    register int r, c;
    int rReal, cReal, wea;
    uint mob, mapped;
    Move_t result;
    char ch;
    bool noCheck;

    noCheck := false;
    ch := ptr**;
    r := pRow*;
    c := pCol*;
    mapped := mapSector(r, c);
    mob := pMob*;
    /* scale cost to avoid rounding problems */
    cost := cost * 10;
    if ch = 'v' or ch = '5' then
	result := m_continue;
	server(rt_readSector, mapped);
	userS("Current sector: ", r, c, ": ");
	user(getDesigName(ES*.es_request.rq_u.ru_sector.s_type));
	userNL();
	ptr* := ptr* + 1;
	noCheck := true;
    else
	rReal := r;
	cReal := c;
	costReal := cost;
	result := moveDir(ptr, &rReal, &cReal, &costReal);
	r := rReal;
	c := cReal;
	cost := costReal;
    fi;
    if result = m_continue and not noCheck then
	accessSector(r, c);
	rs := &ES*.es_request.rq_u.ru_sector;
	cost := getTerrainCost(rs, cost);
	wea := weather(rowToAbs(r), colToAbs(c));
	if wea <= HURRICANE_FORCE then
	    cost := cost * 3;
	elif wea <= MONSOON_FORCE then
	    cost := cost * 2;
	elif wea <= STORM_FORCE then
	    cost := cost * 3 / 2;
	fi;
	/* unscale cost back to a mobility cost * 10: */
	cost := (cost + 9) / 10;
	if cost > mob then
	    err("insufficient mobility");
	    result := m_readMore;
	elif rs*.s_owner ~= ES*.es_countryNumber and rs*.s_owner ~= 0 and
	    ES*.es_country.c_status ~= cs_deity
	then
	    if rs*.s_checkPoint ~= 0 then
		if not verifyCheckPoint(r, c, rs) then
		    result := m_readMore;
		fi;
	    elif rs*.s_type ~= s_highway and rs*.s_type ~= s_bridgeSpan then
		userS("Sector ", r, c, " is owned by someone else.\n");
		result := m_readMore;
	    fi;
	fi;
	if result = m_continue then
	    pMob* := mob - cost;
	    pRow* := r;
	    pCol* := c;
	    if rs*.s_type = s_water then
		result := m_drown;
	    else
		if rs*.s_plagueStage = 2 then
		    pPlague* := true;
		elif pPlague* and rs*.s_plagueStage = 0 then
		    server(rt_lockSector, mapped);
		    ES*.es_request.rq_u.ru_sector.s_plagueStage := 1;
		    ES*.es_request.rq_u.ru_sector.s_plagueTime :=
			random(ES*.es_world.w_plagueOneRand) +
			    ES*.es_world.w_plagueOneBase;
		    server(rt_unlockSector, mapped);
		fi;
	    fi;
	fi;
    fi;
    result
corp;

proc cmd_move()bool:
    [100] char buf;
    register *Sector_t rs;
    ulong cost;
    ItemType_t what;
    SectorType_t desig, desigNew;
    int r, c, r0, c0;
    register uint quan;
    uint mappedOld, mappedNew, n, max, returns, workForce, f, mobility;
    Sector_t s;
    Move_t result;
    bool desert, plague, continue, tookNew;

    if reqCmsgpob(&what, "Enter type of thing to move: ") and
	doSkipBlanks() and
	reqSector(&r, &c, "Enter sector to move from: ")
    then
	rs := &ES*.es_request.rq_u.ru_sector;
	r0 := r;
	c0 := c;
	mappedOld := mapSector(r0, c0);
	server(rt_readSector, mappedOld);
	if rs*.s_owner ~= ES*.es_countryNumber and
	    ES*.es_country.c_status ~= cs_deity
	then
	    err("you don't own that sector");
	    false
	else
	    accessSector(r, c);
	    desig := rs*.s_type;
	    f := getBundleSize(desig, what);
	    ignore skipBlanks();
	    quan := readQuan(rs, what) / f * f;
	    userN3("Enter amount to move (max ", quan, "): ");
	    getPrompt(&buf[0]);


	    /* NOTE: As in other similar cases, we have to be very careful
	       here. Another user could be doing something to the source
	       sector at the same time. This could result in it changing
	       while we wait for this user to type something in response to
	       a prompt here. Thus, we must check the sector again, after
	       we have all of the user's input. If, however, prompting from
	       the user wraps around a half-hour, the sector could be updated
	       under us by someone else. That case is ignored.

	       In this particular case, I have chosen to let this user take
	       stuff away from the sector, even though he may not own it
	       anymore. The final target sector can also be changed on us.
	       Here, I have chosen to allow this user to just dump stuff into
	       it, but not to take it over. */

	    if reqPosRange(&n, quan, &buf[0]) and n / f ~= 0 then
		ignore skipBlanks();

		if desig = s_sanctuary then
		    user("You are breaking sanctuary!!!\n");
		    news(n_broke_sanctuary, ES*.es_countryNumber, NOBODY);
		fi;

		if n / f * f ~= n then
		    n := n / f * f;
		    userN3("Bundling has reduced your amount to ", n, "\n");
		fi;

		ES*.es_noWrite := true;
		server(rt_lockSector, mappedOld);
		quan := readQuan(rs, what);
		if quan < n then
		    n := quan / f * f;
		    userN3("Sudden attack has reduced your quantity to ",
			   n, "!!\n");
		fi;
		plague := s.s_plagueStage = 2;
		/* scale mobility by 10 to keep one decimal place */
		mobility := make(rs*.s_mobility, uint) * 10;
		/* cost as well, to keep units the same */
		cost := getTransportCost(desig, what, n) * 10;
		/* take the full quan away initially, and also all mobility */
		writeQuan(rs, what, quan - n);
		rs*.s_mobility := 0;
		if desig = s_sanctuary then
		    /* other users can't mess this up since a sanctuary
		       cannot be attacked, etc. */
		    rs*.s_type := s_capital;
		fi;
		desert := false;
		if rs*.s_quantity[it_civilians] = 0 and
		    rs*.s_quantity[it_military] = 0 and
		    rs*.s_owner = ES*.es_countryNumber
		then
		    desert := true;
		    rs*.s_owner := 0;
		    rs*.s_defender := NO_DEFEND;
		    rs*.s_checkPoint := 0;
		fi;
		server(rt_unlockSector, mappedOld);
		s := rs*;

		if desert then
		    userS("You are deserting sector ", r0, c0, "\n");
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_sectorCount :=
			ES*.es_request.rq_u.ru_country.c_sectorCount - 1;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    /* in the middle of the moving, he could be shown as
		       having no sectors, but still be active */
		    ES*.es_country.c_sectorCount :=
			ES*.es_request.rq_u.ru_country.c_sectorCount;
		fi;
		ES*.es_noWrite := false;
		uFlush();

		while
		    while
			result := moveOnce(&ES*.es_textInPos, &r, &c,
					   &mobility, &plague, cost);
			result = m_continue
		    do
		    od;
		    result = m_readMore
		do
		    userN3("<", mobility / 10, ".");
		    userN(mobility % 10);
		    userS(":", r, c, "> ");
		    uFlush();
		    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
			ES*.es_textInPos := "e";  /* kludge, kludge!!!!! */
		    else
			ignore skipBlanks();
		    fi;
		od;

		returns := 0;
		if result = m_done then
		    mappedNew := mapSector(r, c);
		    tookNew := false;

		    /* hold off the messages while we have it locked */
		    ES*.es_noWrite := true;
		    server(rt_lockSector, mappedNew);
		    if rs*.s_owner = 0 and
			(what = it_civilians or what = it_military)
		    then
			tookNew := true;
			userS("You now own sector ", r, c, "\n");
			rs*.s_owner := ES*.es_countryNumber;
			rs*.s_defender := NO_DEFEND;
			rs*.s_checkPoint := 0;
			/* don't let the new owner take advantage of the
			   time since the last update as a god sector */
			rs*.s_lastUpdate := timeNow();
		    fi;
		    quan := readQuan(rs, what);
		    desigNew := rs*.s_type;
		    f := getBundleSize(desigNew, what);
		    max := f * 127;
		    if n > max - quan then
			returns := n - (max - quan);
			userN3("No room for ", n, ", ");
			userN(returns);
			user(" sent back\n");
			n := n - returns;
		    elif n % f ~= 0 then
			returns := n % f;
			userN3("Incorrect packaging, ",returns," sent back\n");
			n := n - returns;
		    fi;
		    writeQuan(rs, what, quan + n);
		    if what = it_civilians or what = it_military then
			adjustForNewWorkers(rs, what, quan / f);
		    fi;
		    server(rt_unlockSector, mappedNew);
		    ES*.es_noWrite := false;
		    uFlush();		/* release any messages */

		    if tookNew then
			server(rt_lockCountry, ES*.es_countryNumber);
			ES*.es_request.rq_u.ru_country.c_sectorCount :=
			    ES*.es_request.rq_u.ru_country.c_sectorCount+1;
			server(rt_unlockCountry, ES*.es_countryNumber);
			ES*.es_country.c_sectorCount :=
			    ES*.es_request.rq_u.ru_country.c_sectorCount;
			news(n_took_unoccupied, ES*.es_countryNumber,
			     NOBODY);
		    fi;

		else
		    if what = it_civilians or what = it_military then
			userN3("You just drowned ", n,
			      if what = it_civilians then
				  " civilians"
			      else
				  " military"
			      fi);
		    else
			userN3("You just dumped ", n, " units of ");
			user2(getItemName(what), " into the water");
		    fi;
		    userS(" at sector ", r, c, "\n");
		fi;

		server(rt_lockSector, mappedOld);
		/* put back the remaining mobility and goods */
		rs*.s_mobility := min(rs*.s_mobility + mobility / 10, 127);
		writeQuan(rs, what, readQuan(rs, what) + returns);
		server(rt_unlockSector, mappedOld);

		if desert and ES*.es_country.c_sectorCount = 0 then
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_status := cs_quit;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    ES*.es_country.c_status := cs_quit;
		    user("You just committed national suicide!\n");
		    news(n_dissolve, ES*.es_countryNumber, NOBODY);
		fi;
		true
	    else
		false
	    fi
	fi
    else
	false
    fi
corp;

/*
 * checkFlak - check for and handle flak aimed at our planes.
 */

proc checkFlak(int r, c; *uint pPlanes)void:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register uint i, planes, killed;
    Sector_t saveSector;
    Ship_t saveShip @ saveSector;
    uint guns, shells, aRow, aCol, mapped;

    planes := pPlanes*;
    accessSector(r, c);
    rs := &ES*.es_request.rq_u.ru_sector;
    if rs*.s_type = s_water or rs*.s_type = s_harbour or
	rs*.s_type = s_bridgeSpan
    then
	if rs*.s_shipCount ~= 0 then
	    aRow := rowToAbs(r);
	    aCol := colToAbs(c);
	    i := 0;
	    while i ~= ES*.es_world.w_shipNext and planes ~= 0 do
		server(rt_readShip, i);
		saveShip := rsh*;
		server(rt_readCountry, saveShip.sh_owner);
		if ES*.es_request.rq_u.ru_country.c_relations[
		    ES*.es_countryNumber] = r_war and
		    saveShip.sh_row = aRow and saveShip.sh_col = aCol
		then
		    accessShip(i);
		    if rsh*.sh_owner ~= 0 and
			rsh*.sh_efficiency >= 60 and rsh*.sh_guns ~= 0 and
			rsh*.sh_shells ~= 0 and
			rsh*.sh_type ~= st_freighter and
			rsh*.sh_type ~= st_submarine
		    then
			user("Bang!! BOOM!!! Bang!! Flak encountered!\n");
			server(rt_lockShip, i);
			guns :=
			    if rsh*.sh_type = st_tender then
				1
			    else
				readShipQuan(rsh, it_guns)
			    fi;
			guns := umin(guns, readShipQuan(rsh, it_shells));
			killed := guns * rsh*.sh_efficiency * planes / 100;
			killed := random(killed) / ES*.es_world.w_flakFactor;
			if killed = 0 and
			    random(ES*.es_world.w_flakFactor + 1) < guns
			then
			    killed := 1;
			fi;
			killed := umin(umin(killed, planes), guns);
			writeShipQuan(rsh, it_shells,
			    readShipQuan(rsh, it_shells) - guns);
			server(rt_unlockShip, i);
			if killed ~= 0 then
			    userN3("You lost ", killed, " plane(s)\n");
			    planes := planes - killed;
			fi;
			ES*.es_noWrite := true;
			user2("Your ", getShipName(saveShip.sh_type));
			userN3(" \#", i, " shot at overflying plane(s) from ");
			user2(&ES*.es_country.c_name[0], ".");
			if killed ~= 0 then
			    userN2("\n", killed);
			    user(" plane(s) were shot down!");
			fi;
			notify(saveShip.sh_owner);
			ES*.es_noWrite := false;
			news(n_flak, saveShip.sh_owner, ES*.es_countryNumber);
		    fi;
		fi;
		i := i + 1;
	    od;
	fi;
    elif (rs*.s_type = s_fortress or rs*.s_type = s_airport or
	  rs*.s_type = s_capital or rs*.s_type = s_bank) and
	rs*.s_quantity[it_shells] ~= 0 and rs*.s_quantity[it_guns] ~= 0 and
	rs*.s_efficiency >= 60 and rs*.s_quantity[it_military] >= 5
    then
	server(rt_readCountry, rs*.s_owner);
	if ES*.es_request.rq_u.ru_country.c_relations[ES*.es_countryNumber] =
	    r_war
	then
	    user("Bang!! BOOM!!! Bang!! Flak encountered!\n");
	    mapped := mapSector(r, c);
	    server(rt_lockSector, mapped);
	    guns := readQuan(rs, it_guns);
	    guns := umin(guns, ES*.es_world.w_gunMax);
	    shells := readQuan(rs, it_shells);
	    guns := umin(guns, shells);
	    guns := umin(guns, rs*.s_quantity[it_military] / 5);
	    guns := umin(guns, planes * 3);
	    killed := make(guns, ulong) * rs*.s_efficiency * planes / 100;
	    killed := random(killed) / ES*.es_world.w_flakFactor;
	    if killed = 0 and random(ES*.es_world.w_flakFactor + 1) < guns then
		killed := 1;
	    fi;
	    killed := umin(umin(killed, planes), guns);
	    writeQuan(rs, it_shells, readQuan(rs, it_shells) - guns);
	    server(rt_unlockSector, mapped);
	    if killed ~= 0 then
		userN3("You lost ", killed, " plane(s)\n");
		planes := planes - killed;
	    fi;
	    saveSector := rs*;
	    ES*.es_noWrite := true;
	    user2("Your ", getDesigName(saveSector.s_type));
	    userTarget(saveSector.s_owner, " at ", r, c,
		       " shot at overflying plane(s) from ");
	    user2(&ES*.es_country.c_name[0], ".");
	    if killed ~= 0 then
		userN3("\n", killed, " plane(s) were shot down!");
	    fi;
	    notify(saveSector.s_owner);
	    ES*.es_noWrite := false;
	    news(n_flak, saveSector.s_owner, ES*.es_countryNumber);
	fi;
    fi;
    pPlanes* := planes;
corp;

/*
 * landOnShip - try to land some planes on a ship.
 */

proc landOnShip(uint planes; int wea, r, c; uint bombs, fuel)void:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    register uint quan, live, killed;
    uint shipNumber, absRow, absCol, capacity;
    bool shipHere, ditched, redo;

    rsh := &ES*.es_request.rq_u.ru_ship;
    absRow := rowToAbs(r);
    absCol := colToAbs(c);
    shipHere := false;
    shipNumber := 0;
    while not shipHere and shipNumber ~= ES*.es_world.w_shipNext do
	server(rt_readShip, shipNumber);
	if rsh*.sh_owner = ES*.es_countryNumber and
	    rsh*.sh_type = st_carrier and
	    absRow = rsh*.sh_row and absCol = rsh*.sh_col then
	    shipHere := true;
	fi;
	shipNumber := shipNumber + 1;
    od;
    ditched := false;
    if shipHere then
	ignore skipBlanks();
	redo := true;
	while redo do
	    if reqShip(&shipNumber, "Land on which carrier? ") then
		server(rt_readShip, shipNumber);
		if rsh*.sh_owner ~= ES*.es_countryNumber then
		    err("you don't own that ship");
		elif rsh*.sh_type ~= st_carrier then
		    err("that ship isn't a carrier");
		elif rsh*.sh_row ~= absRow or rsh*.sh_col ~= absCol then
		    err("that ship isn't here");
		else
		    accessShip(shipNumber);
		    if rsh*.sh_owner ~= 0 then
			ES*.es_noWrite := true;
			server(rt_lockShip, shipNumber);
			redo := false;
			live := damageUnit(planes, 100 - rsh*.sh_efficiency);
			if wea <= HURRICANE_FORCE then
			    live := damageUnit(live, random(101));
			elif wea <= MONSOON_FORCE then
			    live := damageUnit(live, random(51));
			elif wea <= STORM_FORCE then
			    live := damageUnit(live, random(34));
			fi;
			/* live is now the number that landed */
			killed := planes - live;
			/* killed is now the number that crashed */
			planes := umin(live,127 - readShipQuan(rsh,it_planes));
			/* planes is now the number that landed */
			userN(planes);
			userN3(" plane(s) landed successfully on carrier \#",
			       shipNumber, "\n");
			if killed ~= 0 then
			    killed := umin(100, killed *
				(random(ES*.es_world.w_planeRand) +
					ES*.es_world.w_planeBase) *
				ES*.es_world.w_shipDamage[st_carrier]);
			    userN3("Crashing planes did ", killed,
				   "% damage!\n");
			    damageShip(shipNumber, killed);
			fi;
			quan := readShipQuan(rsh, it_planes) + planes;
			capacity :=
			    ES*.es_world.w_shipCapacity[it_planes][st_carrier];
			if quan > capacity then
			    userN(quan - capacity);
			    user(" planes fell overboard!\n");
			    planes := planes - (quan - capacity);
			    quan := capacity;
			fi;
			writeShipQuan(rsh, it_planes, quan);
			quan := readShipQuan(rsh, it_shells) + planes * bombs;
			capacity :=
			    ES*.es_world.w_shipCapacity[it_shells][st_carrier];
			if quan > capacity then
			    userN(quan - capacity);
			    user(" shells fell overboard!\n");
			    quan := capacity;
			fi;
			writeShipQuan(rsh, it_shells, quan);
			quan := readShipQuan(rsh, it_military) + planes * 2;
			capacity :=
			  ES*.es_world.w_shipCapacity[it_military][st_carrier];
			if quan > capacity then
			    userN(quan - capacity);
			    user(" pilots stumbled overboard!\n");
			    quan := capacity;
			fi;
			writeShipQuan(rsh, it_military, quan);
			fuel :=
			    fuel * 10 / getTechFactor(ES*.es_countryNumber) /
				    ES*.es_world.w_fuelRichness * planes;
			rsh*.sh_mobility := min(127, rsh*.sh_mobility + fuel);
			server(rt_unlockShip, shipNumber);
			ES*.es_noWrite := false;
			uFlush();
		    fi;
		fi;
	    else
		redo := false;
		ditched := true;
	    fi;
	od;
    else
	ditched := true;
    fi;
    if ditched and planes ~= 0 then
	userN2("You just ditched ", planes);
	userS(" plane(s) into the water at ", r, c, "!\n");
    fi;
corp;

/*
 * landOnLand - attempt to land planes on a land sector.
 *	Convention: the sector is updated and in the request.
 */

proc landOnLand(uint planes; int wea, r, c; uint bombs, fuel)void:
    register *Sector_t rs;
    register uint live, killed, owner, mapped;
    uint chances, oldMil;

    rs := &ES*.es_request.rq_u.ru_sector;
    owner := rs*.s_owner;
    mapped := mapSector(r, c);
    chances :=
	if rs*.s_type = s_airport then
	    if rs*.s_efficiency >= 60 then
		100
	    else
		make(rs*.s_efficiency, uint) * 100 / 60
	    fi
	elif rs*.s_type = s_highway or rs*.s_type = s_bridgeSpan then
	    make(rs*.s_efficiency, uint) / 3 + 40
	else
	    50 - (make(rs*.s_efficiency, uint) * 40 / 100)
	fi;
    chances := chances * ES*.es_world.w_landScale / 100;
    if chances > 100 then
	chances := 100;
    fi;
    live := damageUnit(planes, 100 - chances);
    if wea <= HURRICANE_FORCE then
	live := damageUnit(live, random(101));
    elif wea <= MONSOON_FORCE then
	live := damageUnit(live, random(51));
    elif wea <= STORM_FORCE then
	live := damageUnit(live, random(34));
    fi;
    /* live is now the number that landed */
    killed := planes - live;
    /* killed is now the number that crashed */
    planes := umin(live, 127 - readQuan(rs, it_planes));
    /* planes is now the number that lived */
    userN(planes);
    userS(" plane(s) landed successfully at ", r, c, "\n");
    if killed ~= 0 then
	if rs*.s_owner ~= ES*.es_countryNumber then
	    userN(killed);
	    user3(" plane(s) from ", &ES*.es_country.c_name[0],
		  " crashed into your ");
	    user(getDesigName(rs*.s_type));
	    userTarget(owner, " at ", r, c, "!");
	    notify(owner);
	fi;
	server(rt_lockSector, mapped);
	damageSector(mapped, umin(100, killed *
	    (random(ES*.es_world.w_planeRand) + ES*.es_world.w_planeBase)),
	    ES*.es_countryNumber);
	server(rt_unlockSector, mapped);
    fi;
    if planes ~= 0 then
	if owner = 0 then
	    userS("You now own sector ", r, c, "\n");
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_sectorCount :=
		ES*.es_request.rq_u.ru_country.c_sectorCount + 1;
	    /* just in case! */
	    ES*.es_request.rq_u.ru_country.c_status := cs_active;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    news(n_took_unoccupied, ES*.es_countryNumber, NOBODY);
	elif owner ~= ES*.es_countryNumber then
	    userN(planes);
	    user3(" plane(s) from ", &ES*.es_country.c_name[0],
		  " landed on your ");
	    user(getDesigName(rs*.s_type));
	    userTarget(owner, " at ", r, c, "!");
	    notify(owner);
	fi;
	server(rt_lockSector, mapped);
	writeQuan(rs, it_planes, readQuan(rs, it_planes) + planes);
	writeQuan(rs, it_shells,
		  umin(127, readQuan(rs, it_shells) + planes * bombs));
	oldMil := readQuan(rs, it_military);
	writeQuan(rs, it_military, umin(127, oldMil + planes * 2));
	adjustForNewWorkers(rs, it_military, oldMil);
	fuel := fuel * 10 / getTechFactor(ES*.es_countryNumber) /
		    ES*.es_world.w_fuelRichness * planes;
	rs*.s_mobility := min(127, rs*.s_mobility + fuel);
	if owner = 0 then
	    rs*.s_owner := ES*.es_countryNumber;
	    rs*.s_defender := NO_DEFEND;
	    rs*.s_checkPoint := 0;
	    rs*.s_lastUpdate := ES*.es_request.rq_time;
	fi;
	server(rt_unlockSector, mapped);
    fi;
corp;

/*
 * bombLand - drop bombs on a land sector.
 *	Convention: the sector is updated and is in the request.
 */

proc bombLand(uint planes; int r, c)void:
    uint owner, mapped;

    user("Bombs away...\n");
    user3(&ES*.es_country.c_name[0], " bombed your ",
	  getDesigName(ES*.es_request.rq_u.ru_sector.s_type));
    owner := ES*.es_request.rq_u.ru_sector.s_owner;
    userTarget(owner, " at ", r, c, "!");
    notify(owner);
    news(n_bomb_sector, ES*.es_countryNumber, owner);
    mapped := mapSector(r, c);
    server(rt_lockSector, mapped);
    damageSector(mapped, umin(100, planes *
	    (random(ES*.es_world.w_bombRand) + ES*.es_world.w_bombBase)),
	    ES*.es_countryNumber);
    server(rt_unlockSector, mapped);
corp;

/*
 * bombShip - drop bombs on a ship.
 *	Convention: the sector is updated and is in the request.
 */

proc bombShip(uint planes; int r, c)void:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    uint shipNumber, row, col;

    rs := &ES*.es_request.rq_u.ru_sector;
    if rs*.s_shipCount = 0 then
	user("There are no ships here - nothing bombed.\n");
    else
	row := rowToAbs(r);
	col := colToAbs(c);
	while
	    ignore skipBlanks();
	    if reqShip(&shipNumber, "Bomb which ship? ") then
		server(rt_readShip, shipNumber);
		if rsh*.sh_owner = 0 then
		    err("that ship is a rusting hulk");
		    true
		elif rsh*.sh_row ~= row or rsh*.sh_col ~= col then
		    err("that ship isn't below you");
		    true
		elif rsh*.sh_type = st_submarine then
		    err("that ship isn't visible below you");
		    true
		else
		    user("Bombs away...\n");
		    attackShip(shipNumber,
			       make(planes, ulong) *
				    (random(ES*.es_world.w_bombRand) +
				     ES*.es_world.w_bombBase),
			       at_bomb, &ES*.es_country.c_name[0]);
		    false
		fi
	    else
		user("OK, nothing bombed.\n");
		false
	    fi
	do
	od;
    fi;
corp;

/*
 * flyOnce - fly a group of planes for one unit.
 */

proc flyOnce(**char ptr; *int pRow, pCol; *uint pPlanes, pBombs, pFuel;
	     bool gotEnemy)Move_t:
    Sector_t saveSector;
    register *Sector_t rs;
    int r, c, wea;
    ulong cost;
    uint planes, fuel, bombs, live, killed, mapped, owner;
    char ch;
    Move_t result;
    bool noCheck;

    noCheck := false;
    planes := pPlanes*;
    bombs := pBombs*;
    fuel := pFuel*;
    ch := ptr**;
    r := pRow*;
    c := pCol*;
    rs := &ES*.es_request.rq_u.ru_sector;
    mapped := mapSector(r, c);
    wea := weather(rowToAbs(r), colToAbs(c));
    /* scale cost by 100 to avoid rounding problems */
    cost := (bombs + 2) / 3 * 100 + bombs * 20 + 100;
    if ch = 'v' or ch = '5' then
	/* snoop down at the sector below */
	result := m_continue;
	noCheck := true;
	ptr* := ptr* + 1;
	if gotEnemy then
	    checkFlak(r, c, &planes);
	fi;
	server(rt_readSector, mapped);
	userS("Current sector: ", r, c, ": ");
	userN(rs*.s_efficiency / 10 * 10);
	user3("% ", getDesigName(rs*.s_type), "\n");
    elif ch = 'b' or ch = '0' then
	/* drop some bombs */
	result := m_continue;
	noCheck := true;
	ptr* := ptr* + 1;
	if gotEnemy then
	    checkFlak(r, c, &planes);
	fi;
	if planes = 0 then
	    err("you have no planes left");
	elif bombs = 0 then
	    err("you have no bombs");
	else
	    accessSector(r, c);
	    if rs*.s_type = s_water then
		bombShip(planes, r, c);
	    elif rs*.s_type = s_harbour or rs*.s_type = s_bridgeSpan then
		ptr** := '\e';
		if ask("Attempt to bomb a ship? ") then
		    bombShip(planes, r, c);
		else
		    bombLand(planes, r, c);
		fi;
	    else
		bombLand(planes, r, c);
	    fi;
	    bombs := bombs - 1;
	    pBombs* := bombs;
	    if rs*.s_type = s_bridgeHead and rs*.s_efficiency < 20 then
		collapseSpans(r, c);
	    fi;
	fi;
    elif ch = 'e' or ch = '.' then
	/* try to land here */
	result := m_done;
	ptr* := ptr* + 1;
	accessSector(r, c);
	if rs*.s_type = s_water then
	    landOnShip(planes, wea, r, c, bombs, fuel);
	elif rs*.s_type = s_harbour or rs*.s_type = s_bridgeSpan then
	    ptr** := '\e';
	    if ask("Attempt to land on a carrier? ") then
		landOnShip(planes, wea, r, c, bombs, fuel);
	    else
		landOnLand(planes, wea, r, c, bombs, fuel);
	    fi;
	else
	    landOnLand(planes, wea, r, c, bombs, fuel);
	fi;
	planes := 0;
    else
	result := moveDir(ptr, &r, &c, &cost);
    fi;
    if result = m_continue and not noCheck then
	/* add to cost for bad weather */
	if wea <= HURRICANE_FORCE then
	    cost := cost * 3;
	elif wea <= MONSOON_FORCE then
	    cost := cost * 2;
	elif wea <= STORM_FORCE then
	    cost := cost * 3 / 2;
	fi;
	/* unscale cost back to the way fuel is scaled: */
	cost := (cost + 9) / 10;
	if cost > fuel then
	    err("insufficient fuel");
	    result := m_readMore;
	else
	    server(rt_readSector, mapped);
	    if wea <= HURRICANE_FORCE then
		live := damageUnit(planes, random(51));
		killed := planes - live;
		if killed ~= 0 then
		    accessSector(r, c);
		    owner := rs*.s_owner;
		    if owner ~= ES*.es_countryNumber then
			userN(killed);
			user3(" plane(s) from ", &ES*.es_country.c_name[0],
			      " crashed into your ");
			user(getDesigName(rs*.s_type));
			userTarget(owner, " at ", r, c, "!");
			notify(owner);
		    fi;
		    owner := umin(100,
				  killed * (random(ES*.es_world.w_planeRand) +
					    ES*.es_world.w_planeBase));
		    if owner ~= 0 then
			server(rt_lockSector, mapped);
			damageSector(mapped, owner, ES*.es_countryNumber);
			server(rt_unlockSector, mapped);
		    fi;
		    userN(killed);
		    user(" planes crashed due to hurricane winds!\n");
		    planes := live;
		fi;
	    fi;
	    if planes ~= 0 then
		accessSector(r, c);
		if rs*.s_type = s_water or rs*.s_type = s_bridgeSpan or
		    rs*.s_type = s_harbour
		then
		    if gotEnemy then
			checkFlak(r, c, &planes);
		    fi;
		else
		    saveSector := rs*;
		    server(rt_readCountry, saveSector.s_owner);
		    if saveSector.s_owner ~= ES*.es_countryNumber and
			saveSector.s_owner ~= 0 and
			ES*.es_country.c_status ~= cs_deity and
			(saveSector.s_type = s_fortress or
			 saveSector.s_type = s_airport or
			 saveSector.s_type = s_capital or
			 saveSector.s_type = s_bank) and
			saveSector.s_quantity[it_shells] ~= 0 and
			saveSector.s_quantity[it_guns] ~= 0 and
			saveSector.s_efficiency >= 60 and
			saveSector.s_quantity[it_military] >= 5 and
			ES*.es_request.rq_u.ru_country.c_relations[
			    ES*.es_countryNumber] = r_war
		    then
			if saveSector.s_checkPoint ~= 0 then
			    ptr** := '\e';
			    if not verifyCheckPoint(r, c, &saveSector) then
				checkFlak(r, c, &planes);
			    fi;
			else
			    if gotEnemy then
				checkFlak(r, c, &planes);
			    fi;
			fi;
		    fi;
		fi;
	    fi;
	fi;
	if result = m_continue then
	    pFuel* := fuel - cost;
	    pRow* := r;
	    pCol* := c;
	fi;
    fi;
    pPlanes* := planes;
    if planes = 0 then
	m_done
    else
	result
    fi
corp;

/*
 * doFly - common code for flying.
 */

proc doFly(int r, c; uint planes, bombs, fuel)void:
    register uint i;
    Move_t result;
    bool gotEnemy;

    gotEnemy := false;
    i := ES*.es_world.w_currCountries - 1;
    while not gotEnemy and i ~= 0 do
	server(rt_readCountry, i);
	if ES*.es_request.rq_u.ru_country.c_relations[ES*.es_countryNumber] =
	    r_war and ES*.es_request.rq_u.ru_country.c_status = cs_active
	then
	    gotEnemy := true;
	fi;
	i := i - 1;
    od;

    ignore skipBlanks();
    /* fuel is scaled by a factor of 10 */
    fuel := getTechFactor(ES*.es_countryNumber) * fuel / 10;
    while
	while
	    result :=
		flyOnce(&ES*.es_textInPos, &r, &c, &planes, &bombs, &fuel,
			gotEnemy);
	    result = m_continue
	do
	od;
	result = m_readMore
    do
	userN3("<", fuel / 10, ".");
	userN(fuel % 10);
	userN3(":", planes, ":");
	userN(bombs);
	userS(":", r, c, "> ");
	uFlush();
	if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
	    ES*.es_textInPos := "e";	/* force an end */
	else
	    ignore skipBlanks();
	fi;
    od;
corp;

proc cmd_fly()bool:
    [100] char buf1, buf2;
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register *Country_t rc @ rs;
    uint shipNumber, planes, shells, crew, bombs, fuel, quan, newPlanes;
    uint mapped;
    int r, c;
    bool isShip, deserted;

    if reqSectorOrShip(&r, &c, &shipNumber, &isShip,
		       "Sector/ship to fly from? ")
    then
	ignore skipBlanks();
	if isShip then
	    /* we have a ship number - flying from a carrier */
	    server(rt_readShip, shipNumber);
	    rsh := &ES*.es_request.rq_u.ru_ship;
	    planes := readShipQuan(rsh, it_planes);
	    crew := readShipQuan(rsh, it_military);
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
	    elif rsh*.sh_type ~= st_carrier then
		err("that ship isn't a carrier");
	    elif planes = 0 then
		err("no planes on board");
	    elif crew < 2 then
		err("there is no plane crew on board");
	    elif rsh*.sh_efficiency < 60 then
		err("ship not efficient enough to take off from");
	    else
		/* At this point, and later, we may not even own the ship.
		   I figure that's OK. If things are happening that close
		   together in time, then we may get what we can describe
		   as more interesting behavior. E.g. the crew didn't like
		   us selling the carrier out from under them, so they sort-
		   of rebelled by flying off a bunch of the planes. They
		   will not, of course, be allowed to land again! */
		accessShip(shipNumber);
		planes := readShipQuan(rsh, it_planes);
		crew := readShipQuan(rsh, it_military);
		quan := umin(planes, crew / 2);
		shells := readShipQuan(rsh, it_shells);
		userN(planes);
		userN3(" planes on board, fly how many (max ", quan, ")? ");
		getPrompt(&buf1[0]);
		userN(shells);
		user(" bombs on board, carry how many per plane? ");
		getPrompt(&buf2[0]);
		if reqPosRange(&planes, quan, &buf1[0]) and
		    planes ~= 0 and doSkipBlanks() and
		    reqPosRange(&bombs, shells / planes, &buf2[0])
		then
		    /* if the ship is now a sunken wreck, we don't much care,
		       as these numbers are all likely to be 0 or very small */
		    ES*.es_noWrite := true;
		    server(rt_lockShip, shipNumber);
		    newPlanes := planes;
		    crew := readShipQuan(rsh, it_military);
		    if crew < newPlanes * 2 then
			newPlanes := crew / 2;
		    fi;
		    quan := readShipQuan(rsh, it_planes);
		    if quan < newPlanes then
			newPlanes := quan;
		    fi;
		    writeShipQuan(rsh, it_military, crew - newPlanes * 2);
		    writeShipQuan(rsh, it_planes, quan - newPlanes);
		    if newPlanes ~= planes then
			planes := newPlanes;
			userN3("Sudden events have reduced your force to ",
			       planes, " plane(s)!!\n");
		    fi;
		    shells := readShipQuan(rsh, it_shells);
		    if shells < bombs * planes then
			bombs := shells / planes;
			userN3("Sudden events have reduced your force to ",
			       bombs, " bomb(s) per plane!!\n");
		    fi;
		    writeShipQuan(rsh, it_shells, shells - bombs * planes);
		    fuel := rsh*.sh_mobility / planes;
		    fuel := umin(fuel * ES*.es_world.w_fuelRichness,
				ES*.es_world.w_fuelTankSize);
		    rsh*.sh_mobility := rsh*.sh_mobility -
			fuel / ES*.es_world.w_fuelRichness * planes;
		    server(rt_unlockShip, shipNumber);
		    ES*.es_noWrite := false;
		    uFlush();
		    doFly(rowToMe(rsh*.sh_row), colToMe(rsh*.sh_col),
			  planes, bombs, fuel)
		fi;
	    fi;
	else
	    /* we have a sector specification - flying from an airport */
	    mapped := mapSector(r, c);
	    server(rt_readSector, mapped);
	    rs := &ES*.es_request.rq_u.ru_sector;
	    if rs*.s_owner = ES*.es_countryNumber then
		accessSector(r, c);
	    fi;
	    planes := readQuan(rs, it_planes);
	    crew := readQuan(rs, it_military);
	    if rs*.s_owner ~= ES*.es_countryNumber then
		err("you don't own that sector");
	    elif rs*.s_type ~= s_airport then
		err("can only take off from an airport");
	    elif planes = 0 then
		err("there are no planes there");
	    elif crew < 2 then
		err("there is no plane crew there");
	    elif rs*.s_efficiency < 60 then
		err("airport not efficient enough to take off from");
	    else
		quan := umin(planes, crew / 2);
		shells := readQuan(rs, it_shells);
		userN(planes);
		userN3(" planes available, fly how many (max ", quan, ")? ");
		getPrompt(&buf1[0]);
		userN(shells);
		user(" bombs available, carry how many per plane? ");
		getPrompt(&buf2[0]);
		if reqPosRange(&planes, quan, &buf1[0]) and
			planes ~= 0 and doSkipBlanks() and
			reqPosRange(&bombs, shells / planes, &buf2[0])
		then
		    ES*.es_noWrite := true;
		    server(rt_lockSector, mapped);
		    newPlanes := planes;
		    quan := readQuan(rs, it_planes);
		    if newPlanes > quan then
			newPlanes := quan;
		    fi;
		    crew := readQuan(rs, it_military);
		    if newPlanes > crew / 2 then
			newPlanes := crew / 2;
		    fi;
		    if newPlanes ~= planes then
			planes := newPlanes;
			userN3("Sudden events have reduced your force to ",
			       planes, " plane(s)!!\n");
		    fi;
		    writeQuan(rs, it_planes, quan - planes);
		    writeQuan(rs, it_military, crew - planes * 2);
		    shells := readQuan(rs, it_shells);
		    if shells < bombs * planes then
			bombs := shells / planes;
			userN3("Sudden events have reduced your force to ",
			       bombs, " bomb(s) per plane!!\n");
		    fi;
		    writeQuan(rs, it_shells, shells - bombs * planes);
		    fuel := rs*.s_mobility / planes;
		    fuel := umin(fuel * ES*.es_world.w_fuelRichness,
				 ES*.es_world.w_fuelTankSize);
		    rs*.s_mobility := rs*.s_mobility - fuel /
				ES*.es_world.w_fuelRichness * planes;
		    deserted := false;
		    if rs*.s_quantity[it_military] = 0 and
			rs*.s_quantity[it_civilians] = 0
		    then
			deserted := true;
			rs*.s_owner := 0;
			rs*.s_defender := NO_DEFEND;
			rs*.s_checkPoint := 0;
		    fi;
		    server(rt_unlockSector, mapped);
		    ES*.es_noWrite := false;
		    uFlush();
		    if deserted then
			userS("You have deserted sector ", r, c, "!\n");
			server(rt_lockCountry, ES*.es_countryNumber);
			rc*.c_sectorCount := rc*.c_sectorCount - 1;
			ES*.es_country.c_sectorCount := rc*.c_sectorCount;
			if rc*.c_sectorCount = 0 then
			    rc*.c_status := cs_quit;
			    ES*.es_country.c_status := cs_quit;
			fi;
			server(rt_unlockCountry, ES*.es_countryNumber);
			if rc*.c_status = cs_quit then
			    user("You just committed national suicide!\n");
			    news(n_dissolve, ES*.es_countryNumber, NOBODY);
			fi;
		    fi;
		    doFly(r, c, planes, bombs, fuel);
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

/*
 * navOnce - inner part of cmd_navigate.
 */

proc navOnce(**char ptr; *int pRow, pCol; *int pFlagMobil, pMinMobil)Move_t:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register *Nav_t nav;
    *char ptrSave, ptrTemp;
    register uint i, damage;
    uint mines, mapped;
    int r, c, oldR, oldC, flagMobil, minMobil, wea;
    ulong cost;
    char ch;
    Move_t result;
    SectorType_t desig;
    bool noCheck, continuing;

    noCheck := false;
    ch := ptr**;
    r := pRow*;
    c := pCol*;
    flagMobil := pFlagMobil*;
    minMobil := pMinMobil*;
    rs := &ES*.es_request.rq_u.ru_sector;
    if ch = 'v' or ch = '5' then
	/* snoop at the sector we're in - not much use here */
	result := m_continue;
	noCheck := true;
	ptr* := ptr* + 1;
	accessSector(r, c);
	userS("Current sector: ", r, c, ": ");
	user2(getDesigName(rs*.s_type), "\n");
    elif ch = 'e' or ch = '.' then
	/* stop here */
	result := m_done;
	ptr* := ptr* + 1;
    else
	server(rt_readShip, ES*.es_movingShips[0].n_ship);
	cost := getNavCost(rsh);
	ptrSave := ptr*;
	result := moveDir(ptr, &r, &c, &cost);
    fi;
    if result = m_continue and not noCheck then
	/* add to cost for bad weather */
	wea := weather(rowToAbs(r), colToAbs(c));
	if wea <= HURRICANE_FORCE then
	    cost := cost * 3;
	elif wea <= MONSOON_FORCE then
	    cost := cost * 2;
	elif wea <= STORM_FORCE then
	    cost := cost * 3 / 2;
	fi;
	if make(cost, long) > flagMobil then
	    err("insufficient mobility");
	    result := m_readMore;
	else
	    accessSector(r, c);
	    if rs*.s_type = s_harbour then
		if rs*.s_owner ~= ES*.es_countryNumber and rs*.s_owner ~= 0 and
		    ES*.es_country.c_status ~= cs_deity
		then
		    if rs*.s_checkPoint ~= 0 then
			if not verifyCheckPoint(r, c, rs) then
			    result := m_readMore;
			fi;
		    else
			err("can't go there");
			result := m_readMore;
		    fi;
		fi;
	    elif rs*.s_type ~= s_water and rs*.s_type ~= s_bridgeSpan then
		err("can't go there");
		result := m_readMore;
	    fi;
	fi;
	if result = m_continue then
	    pRow* := r;
	    pCol* := c;
	    for i from 0 upto ES*.es_movingShipCount - 1 do
		nav := &ES*.es_movingShips[i];
		if nav*.n_active then
		    continuing := true;
		    server(rt_readShip, nav*.n_ship);
		    cost := getNavCost(rsh);
		    ptrTemp := ptrSave;
		    r := rowToMe(rsh*.sh_row);
		    oldR := r;
		    c := colToMe(rsh*.sh_col);
		    oldC := c;
		    ignore moveDir(&ptrTemp, &r, &c, &cost);
		    if make(cost, long) > nav*.n_mobil then
			continuing := false;
		    else
			accessSector(r, c);
			if rs*.s_type ~= s_water and
			    rs*.s_type ~= s_bridgeSpan and
			    (rs*.s_type ~= s_harbour or
			     r ~= pRow* or c ~= pCol*)
			then
			    continuing := false;
			    server(rt_readShip, nav*.n_ship);
			fi;
		    fi;
		    if continuing then
			mines := rs*.s_quantity[it_shells];
			desig := rs*.s_type;
			if desig ~= s_water then
			    mines := 0;
			fi;
			server(rt_lockShip, nav*.n_ship);
			rsh*.sh_row := rowToAbs(r);
			rsh*.sh_col := colToAbs(c);
			mapped := mapAbsSector(rsh*.sh_row, rsh*.sh_col);
			if rsh*.sh_type ~= st_submarine and
			    weather(rsh*.sh_row, rsh*.sh_col) <=
				    HURRICANE_FORCE
			then
			    doShipDamage(nav*.n_ship);
			    nav*.n_mobil := rsh*.sh_mobility * 10;
			fi;
			nav*.n_mobil := nav*.n_mobil - cost;
			server(rt_unlockShip, nav*.n_ship);
			if rsh*.sh_owner = 0 then
			    nav*.n_active := false;
			elif rsh*.sh_efficiency < MIN_SHIP_EFFIC then
			    user(getShipName(rsh*.sh_type));
			    userN3(" \#", nav*.n_ship,
				   " can no longer navigate.\n");
			    nav*.n_active := false;
			    incrShipCount(mapSector(oldR, oldC));
			elif rsh*.sh_type = st_mineSweeper then
			    user("Sweep sweep...\n");
			    if mines ~= 0 then
				server(rt_lockSector, mapped);
				mines := readQuan(rs, it_shells);
				damage := umin(mines, 5);
				writeQuan(rs, it_shells, mines - damage);
				server(rt_unlockSector, mapped);
				userN3("Deactivated ", damage, " mines\n");
			    fi;
			elif desig = s_water and
			    rsh*.sh_type ~= st_submarine and
			    random(100) < umin(make(mines, uint) * 5, 100)
			then
			    news(n_hit_mine, rsh*.sh_owner, NOBODY);
			    user("Boooommmm!\n");
			    server(rt_lockSector, mapped);
			    writeQuan(rs, it_shells,
				      readQuan(rs, it_shells) - 1);
			    server(rt_unlockSector, mapped);
			    server(rt_lockShip, nav*.n_ship);
			    damage := random(ES*.es_world.w_mineRand) +
					ES*.es_world.w_mineBase;
			    damage := umin(100, damage *
				    ES*.es_world.w_shipDamage[rsh*.sh_type]);
			    ES*.es_noWrite := true;
			    userS("Mine at ", r, c, "");
			    userN3(" does ", damage, "% damage to ");
			    user(getShipName(rsh*.sh_type));
			    userN3(" \#", nav*.n_ship, "!\n");
			    damageShip(nav*.n_ship, damage);
			    server(rt_unlockShip, nav*.n_ship);
			    ES*.es_noWrite := false;
			    uFlush();
			    nav*.n_mobil :=
				nav*.n_mobil * (100 - damage) / 100;
			    if rsh*.sh_owner = 0 then
				nav*.n_active := false;
				/* undo the decrement that 'damageShip' did */
				incrShipCount(mapped);
			    elif rsh*.sh_efficiency < MIN_SHIP_EFFIC then
				user(getShipName(rsh*.sh_type));
				userN3(" \#", nav*.n_ship,
				       " can no longer navigate.\n");
				nav*.n_active := false;
				incrShipCount(mapped);
			    fi;
			fi;
		    else
			user(getShipName(rsh*.sh_type));
			userN2(" \#", nav*.n_ship);
			userS(" stops at ", oldR, oldC, "\n");
			nav*.n_active := false;
			incrShipCount(mapSector(oldR, oldC));
		    fi;
		    if not nav*.n_active then
			server(rt_lockShip, nav*.n_ship);
			rsh*.sh_mobility := nav*.n_mobil / 10;
			server(rt_unlockShip, nav*.n_ship);
		    fi;
		fi;
	    od;
	    minMobil := ES*.es_movingShips[0].n_mobil;
	    for i from 0 upto ES*.es_movingShipCount - 1 do
		if ES*.es_movingShips[i].n_active and
		    ES*.es_movingShips[i].n_mobil < minMobil
		then
		    minMobil := ES*.es_movingShips[i].n_mobil;
		fi;
	    od;
	    pFlagMobil* := ES*.es_movingShips[0].n_mobil;
	    pMinMobil* := minMobil;
	    if not ES*.es_movingShips[0].n_active then
		result := m_done;
	    fi;
	fi;
    fi;
    result
corp;

proc cmd_navigate()bool:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    register *Nav_t nav;
    Fleet_t fl;
    register uint i;
    uint shipNumber, msc;
    register int r, c;
    int flagRow, flagCol, flagMobil, minMobil;
    Move_t result;
    char fleet;
    bool gotOne, tooMany;

    if reqShipOrFleet(&shipNumber, &fleet, "Ship or fleet to navigate? ") then
	rsh := &ES*.es_request.rq_u.ru_ship;
	tooMany := false;
	gotOne := false;
	ES*.es_movingShipCount := 0;
	msc := 0;
	ignore skipBlanks();
	if fleet = ' ' then
	    server(rt_readShip, shipNumber);
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
	    else
		accessShip(shipNumber);
		if rsh*.sh_efficiency < MIN_SHIP_EFFIC then
		    if rsh*.sh_owner ~= 0 then
			/* hurricane might have sank it! */
			err("that ship isn't efficient enough to sail");
		    fi;
		else
		    ES*.es_movingShipCount := 1;
		    msc := 1;
		    nav := &ES*.es_movingShips[0];
		    nav*.n_ship := shipNumber;
		    nav*.n_mobil := make(rsh*.sh_mobility, int) * 10;
		    nav*.n_active := true;
		    flagMobil := rsh*.sh_mobility;
		    minMobil := rsh*.sh_mobility;
		    flagRow := rowToMe(rsh*.sh_row);
		    flagCol := colToMe(rsh*.sh_col);
		    decrShipCount(mapAbsSector(rsh*.sh_row, rsh*.sh_col));
		fi;
	    fi;
	else
	    i := fleetPos(fleet);
	    if fleet = '*' then
		err("can't navigate fleet '*'")
	    elif ES*.es_country.c_fleets[i] = NO_FLEET then
		err("you have no such fleet");
	    else
		server(rt_readFleet, ES*.es_country.c_fleets[i]);
		fl := ES*.es_request.rq_u.ru_fleet;
		if fl.f_count = 0 then
		    err("fleet has no ships");
		else
		    gotOne := true;
		    for i from 0 upto fl.f_count - 1 do
			shipNumber := fl.f_ship[i];
			accessShip(shipNumber);
			if rsh*.sh_efficiency < MIN_SHIP_EFFIC then
			    if rsh*.sh_owner ~= 0 then
				/* hurricane might have sank it */
				user(getShipName(rsh*.sh_type));
				userN3(" \#", shipNumber,
				     " isn't efficient enough to navigate.\n");
			    fi;
			else
			    gotOne := true;
			    if msc = 0 then
				flagMobil := rsh*.sh_mobility;
				minMobil := rsh*.sh_mobility;
				flagRow := rowToMe(rsh*.sh_row);
				flagCol := colToMe(rsh*.sh_col);
			    fi;
			    if msc = MAX_NAV_SHIPS then
				if not tooMany then
				    tooMany := true;
				    err("too many ships to navigate at once");
				fi;
			    else
				nav := &ES*.es_movingShips[msc];
				nav*.n_ship := shipNumber;
				nav*.n_mobil := make(rsh*.sh_mobility, int)*10;
				nav*.n_active := true;
				msc := msc + 1;
				ES*.es_movingShipCount := msc;
				if rsh*.sh_mobility < minMobil then
				    minMobil := rsh*.sh_mobility;
				fi;
				decrShipCount(mapAbsSector(rsh*.sh_row,
							   rsh*.sh_col));
			    fi;
			fi;
		    od;
		fi;
	    fi;
	fi;
	if msc = 0 then
	    if gotOne then
		err("no ships in that fleet can navigate");
	    fi;
	elif flagMobil < 0 then
	    err("no mobility");
	elif not tooMany then
	    /* scale mobilities by 10 */
	    flagMobil := flagMobil * 10;
	    minMobil := minMobil * 10;
	    while
		while
		    result := navOnce(&ES*.es_textInPos, &flagRow, &flagCol,
				      &flagMobil, &minMobil);
		    result = m_continue
		do
		od;
		result = m_readMore
	    do
		userN2("<", flagMobil / 10);
		userN2(".", | flagMobil % 10);
		userN2(":", minMobil / 10);
		userN2(".", | minMobil % 10);
		userS(": ", flagRow, flagCol, "> ");
		uFlush();
		if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		    ES*.es_textInPos := "e";	/* force an end */
		else
		    ignore skipBlanks();
		fi;
	    od;
	    for i from 0 upto ES*.es_movingShipCount - 1 do
		nav := &ES*.es_movingShips[i];
		if nav*.n_active then
		    shipNumber := nav*.n_ship;
		    server(rt_lockShip, shipNumber);
		    rsh*.sh_mobility := nav*.n_mobil / 10;
		    server(rt_unlockShip, shipNumber);
		    incrShipCount(mapAbsSector(rsh*.sh_row, rsh*.sh_col));
		fi;
	    od;
	fi;
	true
    else
	false
    fi
corp;
