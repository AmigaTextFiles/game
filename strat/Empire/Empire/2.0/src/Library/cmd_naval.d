#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g
#Scan.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * shipReport - report on the passed ship structure.
 */

proc shipReport(uint shipNumber; register *Ship_t sh;)void:
    Ship_t saveShip;
    register *char p;
    register uint length;
    register int col;

    if sh*.sh_owner = ES*.es_countryNumber then
	server(rt_lockShip, shipNumber);
	updateShip(shipNumber);
	server(rt_unlockShip, shipNumber);
	saveShip := ES*.es_request.rq_u.ru_ship;
	sh := &saveShip;
    fi;
    server(rt_readCountry, sh*.sh_owner);
    userF(shipNumber, 3);
    userC(
	if ES*.es_request.rq_u.ru_country.c_status = cs_deity then
	    '*'
	else
	    ' '
	fi);
    p := getShipName(sh*.sh_type);
    length := 12;
    while p* ~= '\e' do
	userC(p*);
	p := p + sizeof(char);
	length := length - 1;
    od;
    while length ~= 0 do
	length := length - 1;
	userSp();
    od;
    col := colToMe(sh*.sh_col);
    userF(rowToMe(sh*.sh_row), 4);
    userN2(",", col);
    if col < 0 then
	if col > -10 then
	    user("  ");
	elif col > -100 then
	    userSp();
	fi;
    else
	userSp();
	if col < 10 then
	    user("  ");
	elif col < 100 then
	    userSp();
	fi;
    fi;
    userSp();
    userC(sh*.sh_fleet);
    userF(sh*.sh_efficiency, 4);
    userC('%');
    userF(sh*.sh_techLevel, 5);
    userF(sh*.sh_crew, 4);
    userF(sh*.sh_shells, 4);
    userF(sh*.sh_guns, 4);
    userF(sh*.sh_planes, 4);
    userF(sh*.sh_ore, 4);
    userF(sh*.sh_bars, 5);
    userF(sh*.sh_mobility, 4);
    userNL();
corp;

proc cmd_ships()bool:
    ShipScan_t shs;
    bool continue;

    if ES*.es_textInPos* = '\e' then
	shs.shs_shipPatternType := shp_none;
	shs.shs_cs.cs_conditionCount := 0;
	continue := true;
    else
	continue := reqShips(&shs, "Ships to report on: ");
    fi;
    if continue then
	user(
      "  \#   type         r,c    f  eff   tl c/m  sh gun pln ore bars  mu\n");
	dash(66);
	if scanShips(&shs, shipReport) = 0 then
	    err("no ships matched");
	else
	    userNL();
	fi;
	true
    else
	false
    fi
corp;

/*
 * doLoad - part of cmd_load
 *	Convention: the sector and ship are in the request as a pair.
 */

proc doLoad(ItemType_t what; uint mapped,shipNumber,percent; bool askQuan)void:
    register *SectorShipPair_t rp;
    register uint capacity, present, loaded;
    uint amount, maxLoad, amountOrig;
    [80] char buf;

    rp := &ES*.es_request.rq_u.ru_sectorShipPair;
    capacity := ES*.es_world.w_shipCapacity[what][rp*.p_sh.sh_type];
    present := readQuan(&rp*.p_s, what);
    loaded := readShipQuan(&rp*.p_sh, what);
    if capacity = 0 and present ~= 0 and askQuan then
	user3(getShipName(rp*.p_sh.sh_type), " can't carry ",
	      getItemName(what));
	userNL();
    elif present = 0 and capacity ~= 0 and capacity ~= loaded and askQuan then
	user3("No ", getItemName(what), " here to load\n");
    elif present ~= 0 and capacity = loaded and askQuan then
	user3("No room for more ", getItemName(what), "\n");
    elif capacity ~= 0 and present ~= 0 and capacity ~= loaded then
	maxLoad := umin(capacity - loaded, present);
	if askQuan then
	    ES*.es_textInPos* := '\e';
	    userN(present);
	    user2(" ", getItemName(what));
	    userN2(" here, ", loaded);
	    userN3(" on board, load how many (max ", maxLoad, ")? ");
	    getPrompt(&buf[0]);
	    if not reqPosRange(&amount, maxLoad, &buf[0]) then
		amount := 0;
	    fi;
	else
	    amount := umin(capacity * percent / 100, maxLoad);
	    userN3("Loading ", amount, " ");
	    user2(getItemName(what), ".\n");
	fi;
	if amount ~= 0 then
	    amountOrig := amount;
	    server2(rt_lockSectorShipPair, mapped, shipNumber);
	    present := readQuan(&rp*.p_s, what);
	    if amount > present then
		amount := present;
	    fi;
	    loaded := readShipQuan(&rp*.p_sh, what);
	    if amount > capacity - loaded then
		amount := capacity - loaded;
	    fi;
	    writeQuan(&rp*.p_s, what, present - amount);
	    writeShipQuan(&rp*.p_sh, what, loaded + amount);
	    server2(rt_unlockSectorShipPair, mapped, shipNumber);
	    if amount ~= amountOrig then
		userN3("Events have reduced amount to ", amount, " units.\n");
	    fi;
	fi;
    fi;
corp;

proc cmd_load()bool:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    register *Country_t rc @ rsh;
    register *SectorShipPair_t rp @ rsh;
    Ship_t saveShip;
    uint shipNumber, percent, mapped, owner;
    int r, c;
    ItemType_t it;
    bool askQuan, aborting;

    if reqShip(&shipNumber, "Ship to load? ") then
	ignore skipBlanks();
	aborting := false;
	askQuan := false;
	if ES*.es_textInPos* = '\e' then
	    askQuan := true;
	elif getNumber(&r) and r > 0 then
	    percent := r;
	else
	    err("load cancelled");
	    aborting := true;
	fi;
	if not aborting then
	    server(rt_readShip, shipNumber);
	    rsh := &ES*.es_request.rq_u.ru_ship;
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
	    else
		server(rt_lockShip, shipNumber);
		updateShip(shipNumber);
		server(rt_unlockShip, shipNumber);
		r := rowToMe(rsh*.sh_row);
		c := colToMe(rsh*.sh_col);
		saveShip := rsh*;
		accessSector(r, c);
		if weather(saveShip.sh_row,saveShip.sh_col) <= STORM_FORCE then
		    err("weather is too bad for loading");
		    aborting := true;
		elif rs*.s_type = s_water or rs*.s_type = s_bridgeSpan then
		    err("ship is at sea");
		    aborting := true;
		elif rs*.s_owner ~= ES*.es_countryNumber then
		    if rs*.s_checkPoint = 0 then
			userS("Sector ", r, c, " is owned by someone else\n");
			aborting := true;
		    else
			if not verifyCheckPoint(r, c, rs) then
			    aborting := true;
			fi;
		    fi;
		fi;
		if not aborting then
		    if rs*.s_type ~= s_harbour then
			userS("Sector ", r, c, " is not a harbour\n");
		    else
			mapped := mapSector(r, c);
			/* the sector is in the request already */
			rp*.p_sh := saveShip;
			doLoad(
			    if saveShip.sh_type = st_freighter then
				it_civilians
			    else
				it_military
			    fi,
			    mapped, shipNumber, percent, askQuan);
			for it from it_shells upto it_bars do
			    doLoad(it, mapped, shipNumber, percent, askQuan);
			od;
			owner := rp*.p_s.s_owner;
			if owner ~= 0 and
			    rp*.p_s.s_quantity[it_civilians] = 0 and
			    rp*.p_s.s_quantity[it_military] = 0
			then
			    server(rt_lockSector, mapped);
			    rs*.s_owner := 0;
			    rs*.s_defender := NO_DEFEND;
			    rs*.s_checkPoint := 0;
			    server(rt_unlockSector, mapped);
			    server(rt_lockCountry, owner);
			    rc*.c_sectorCount := rc*.c_sectorCount - 1;
			    if rc*.c_sectorCount = 0 then
				rc*.c_status := cs_dead;
				server(rt_unlockCountry, owner);
				if owner = ES*.es_countryNumber then
				    user(
				       "You just committed national suicide!\n"
				    );
				    news(n_dissolve, ES*.es_countryNumber,
					 NOBODY);
				else
				    user3("You have just destroyed ",
					  &rc*.c_name[0], "!\n");
				    news(n_destroyed, ES*.es_countryNumber,
					 owner);
				fi;
			    else
				server(rt_unlockCountry, owner);
			    fi;
			    if owner = ES*.es_countryNumber then
				ES*.es_country := rc*;
			    fi;
			fi;
		    fi;
		fi;
	    fi;
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * doUnload - part of cmd_unload
 */

proc doUnload(ItemType_t what; uint mapped, shipNumber, percent;
	      bool askQuan)void:
    register *SectorShipPair_t rp;
    register uint capacity, present, loaded;
    uint amount, maxUnload, amountOrig;
    [80] char buf;

    rp := &ES*.es_request.rq_u.ru_sectorShipPair;
    capacity := getBundleSize(rp*.p_s.s_type, what) * 127;
    present := readQuan(&rp*.p_s, what);
    loaded := readShipQuan(&rp*.p_sh, what);
    if capacity = present and loaded ~= 0 then
	user3("No room to unload ", getItemName(what), "\n");
    elif loaded = 0 and
	ES*.es_world.w_shipCapacity[what][rp*.p_sh.sh_type] ~= 0
    then
	user3("No ", getItemName(what), " on board\n");
    elif loaded ~= 0 and capacity ~= present then
	maxUnload := umin(capacity - present, loaded);
	if askQuan then
	    ES*.es_textInPos* := '\e';
	    userN(present);
	    user2(" ", getItemName(what));
	    userN2(" here, ", loaded);
	    userN3(" on board, unload how many (max ", maxUnload, ")? ");
	    getPrompt(&buf[0]);
	    if not reqPosRange(&amount, maxUnload, &buf[0]) then
		amount := 0;
	    fi;
	else
	    amount := umin(loaded * percent / 100, maxUnload);
	    userN3("Unloading ", amount, " ");
	    user2(getItemName(what), ".\n");
	fi;
	if amount ~= 0 then
	    amountOrig := amount;
	    server2(rt_lockSectorShipPair, mapped, shipNumber);
	    present := readQuan(&rp*.p_s, what);
	    loaded := readShipQuan(&rp*.p_sh, what);
	    if amount > loaded then
		amount := loaded;
	    fi;
	    if amount > capacity - present then
		amount := capacity - present;
	    fi;
	    writeQuan(&rp*.p_s, what, present + amount);
	    writeShipQuan(&rp*.p_sh, what, loaded - amount);
	    adjustForNewWorkers(&rp*.p_s, what, present);
	    server2(rt_unlockSectorShipPair, mapped, shipNumber);
	    if amount ~= amountOrig then
		userN3("Actions reduced the amount to ", amount, " units\n");
	    fi;
	fi;
    fi;
corp;

proc cmd_unload()bool:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    register *Country_t rc @ rsh;
    register *SectorShipPair_t rp @ rsh;
    Ship_t saveShip;
    register uint percent;
    uint shipNumber, mapped, owner;
    int r, c;
    ItemType_t it;
    bool askQuan, aborting, wasDeserted;

    if reqShip(&shipNumber, "Ship to unload? ") then
	ignore skipBlanks();
	aborting := false;
	askQuan := false;
	if ES*.es_textInPos* = '\e' then
	    askQuan := true;
	elif getNumber(&r) and r > 0 then
	    percent := r;
	else
	    err("unload cancelled");
	    aborting := true;
	fi;
	if not aborting then
	    server(rt_readShip, shipNumber);
	    rsh := &ES*.es_request.rq_u.ru_ship;
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
	    else
		server(rt_lockShip, shipNumber);
		updateShip(shipNumber);
		server(rt_unlockShip, shipNumber);
		r := rowToMe(rsh*.sh_row);
		c := colToMe(rsh*.sh_col);
		saveShip := rsh*;
		accessSector(r, c);
		if weather(saveShip.sh_row,saveShip.sh_col) <= STORM_FORCE then
		    err("weather is too bad for unloading");
		    aborting := true;
		elif rs*.s_type = s_water or rs*.s_type = s_bridgeSpan then
		    err("ship is at sea");
		    aborting := true;
		elif rs*.s_owner ~= ES*.es_countryNumber and rs*.s_owner ~= 0
		then
		    if rs*.s_checkPoint = 0 then
			userS("Sector ", r, c, " is owned by someone else\n");
			aborting := true;
		    else
			if not verifyCheckPoint(r, c, rs) then
			    aborting := true;
			fi;
		    fi;
		fi;
		if not aborting then
		    if rs*.s_type ~= s_harbour then
			userS("Sector ", r, c, " is not a harbour\n");
		    else
			wasDeserted := rs*.s_quantity[it_civilians] = 0 and
				       rs*.s_quantity[it_military] = 0;
			rp*.p_sh := saveShip;
			mapped := mapSector(r, c);
			doUnload(
				if saveShip.sh_type = st_freighter then
				    it_civilians
				else
				    it_military
				fi,
				mapped, shipNumber, percent, askQuan);
			for it from it_shells upto it_bars do
			    doUnload(it, mapped, shipNumber, percent, askQuan);
			od;
			if wasDeserted and (
			    rs*.s_quantity[it_civilians] ~= 0 or
			    rs*.s_quantity[it_military] ~= 0)
			then
			    server(rt_lockSector, mapped);
			    rs*.s_owner := ES*.es_countryNumber;
			    server(rt_unlockSector, mapped);
			    server(rt_lockCountry, ES*.es_countryNumber);
			    rc*.c_sectorCount := rc*.c_sectorCount + 1;
			    server(rt_unlockCountry, ES*.es_countryNumber);
			    ES*.es_country.c_sectorCount := rc*.c_sectorCount;
			    news(n_took_unoccupied, ES*.es_countryNumber,
				 NOBODY);
			    user("The harbour is now yours!\n");
			fi;
		    fi;
		fi;
	    fi;
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * doTend - part of cmd_tend.
 */

proc doTend(uint tenderNumber, otherNumber; ItemType_t what)void:
    register *[2]Ship_t rp;
    [100] char buf;
    register uint available, loaded, capacity, maxTransfer;
    uint amount, amountOrig;

    rp := &ES*.es_request.rq_u.ru_shipPair;
    available := readShipQuan(&rp*[0], what);
    loaded := readShipQuan(&rp*[1], what);
    capacity := ES*.es_world.w_shipCapacity[what][rp*[1].sh_type];
    if available = 0 then
	user3("No ", getItemName(what), " on board tender\n");
    elif available ~= 0 and loaded = capacity then
	user3("No room for more ", getItemName(what), "\n");
    else
	ES*.es_textInPos* := '\e';
	maxTransfer := umin(capacity - loaded, available);
	user2("Transfer how many ", getItemName(what));
	userN3(" (max ", maxTransfer, ")? ");
	getPrompt(&buf[0]);
	if reqPosRange(&amount, maxTransfer, &buf[0]) then
	    server2(rt_lockShipPair, tenderNumber, otherNumber);
	    available := readShipQuan(&rp*[0], what);
	    loaded := readShipQuan(&rp*[1], what);
	    amountOrig := amount;
	    if available < amount then
		amount := available;
	    fi;
	    if capacity - loaded < amount then
		amount := capacity - loaded;
	    fi;
	    writeShipQuan(&rp*[0], what, available - amount);
	    writeShipQuan(&rp*[1], what, loaded + amount);
	    server2(rt_unlockShipPair, tenderNumber, otherNumber);
	    if amount ~= amountOrig then
		userN3("Actions reduced the amount to ", amount, " units\n");
	    fi;
	fi;
    fi;
corp;

proc cmd_tend()bool:
    register *[2]Ship_t rp;
    register *Ship_t rsh @ rp;
    uint tenderNum, otherNum;
    Ship_t saveShip;

    if reqShip(&otherNum, "Ship to tend? ") and
	doSkipBlanks() and
	reqShip(&tenderNum, "Tender to transfer from? ")
    then
	server2(rt_readShipPair, tenderNum, otherNum);
	rp := &ES*.es_request.rq_u.ru_shipPair;
	if rp*[1].sh_owner ~= ES*.es_countryNumber then
	    userN3("You don't own ship \#", otherNum, "\n");
	elif rp*[0].sh_owner ~= ES*.es_countryNumber then
	    userN3("You don't own ship \#", tenderNum, "\n");
	else
	    server(rt_lockShip, otherNum);
	    updateShip(otherNum);
	    server(rt_unlockShip, otherNum);
	    saveShip := ES*.es_request.rq_u.ru_ship;
	    server(rt_lockShip, tenderNum);
	    updateShip(tenderNum);
	    server(rt_unlockShip, tenderNum);
	    if saveShip.sh_type = st_carrier then
		err("can't tend carriers");
	    elif saveShip.sh_type = st_freighter then
		err("can't tend freighters");
	    elif saveShip.sh_type = st_submarine then
		err("can't tend submarines");
	    elif saveShip.sh_type = st_tender then
		err("can't tend other tenders");
	    elif rsh*.sh_type ~= st_tender then
		userN3("Ship \#", tenderNum, " is a ");
		user2(getShipName(rsh*.sh_type), ", not a tender\n");
	    elif tenderNum = otherNum then
		err("tender can't tend itself");
	    elif rsh*.sh_row ~= saveShip.sh_row or
		rsh*.sh_col ~= saveShip.sh_col
	    then
		err("ships aren't in same sector");
	    elif weather(rsh*.sh_row, rsh*.sh_col) <= STORM_FORCE then
		err("weather is too bad for tending");
	    else
		/* set up the ship pair */
		rp*[1] := saveShip;
		doTend(tenderNum, otherNum, it_military);
		doTend(tenderNum, otherNum, it_guns);
		doTend(tenderNum, otherNum, it_shells);
	    fi;
	fi;
	true
    else
	false
    fi
corp;

/*
 * doFleet - part of cmd_fleet
 */

proc doFleet(register uint shipNumber; register *Ship_t sh)void:
    register *Ship_t rsh;
    register *Fleet_t rf @ rsh;

    if sh*.sh_owner = ES*.es_countryNumber then
	server(rt_lockShip, shipNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	updateShip(shipNumber);
	removeFromFleet(ES*.es_countryNumber, shipNumber);
	if not ES*.es_bool1 then
	    /* putting the ship into a fleet */
	    if rsh*.sh_price ~= 0 then
		server(rt_unlockShip, shipNumber);
		userN3("ship ", shipNumber,
		       " is for sale - cannot put it into a fleet\n");
	    else
		rsh*.sh_fleet := ES*.es_uint2 + '\e';
		server(rt_unlockShip, shipNumber);
		server(rt_lockFleet, ES*.es_uint1);
		if rf*.f_count ~= FLEET_MAX then
		    rf*.f_ship[rf*.f_count] := shipNumber;
		    rf*.f_count := rf*.f_count + 1;
		    server(rt_unlockFleet, ES*.es_uint1);
		else
		    /* oops - it wouldn't fit in the fleet */
		    server(rt_unlockFleet, ES*.es_uint1);
		    server(rt_lockShip, shipNumber);
		    rsh*.sh_fleet := '*';
		    server(rt_unlockShip, shipNumber);
		fi;
	    fi;
	else
	    server(rt_unlockShip, shipNumber);
	fi;
    fi;
corp;

proc cmd_fleet()void:
    register *Ship_t rsh;
    register *Fleet_t rf @ rsh;
    ShipScan_t shs;
    register uint i, pos;
    char fleetChar;
    bool headerDone;
	
    if reqChar(&fleetChar,
	       "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ*",
	       "Display which fleet? ", "illegal fleet character")
    then
	rsh := &ES*.es_request.rq_u.ru_ship;
	ignore skipBlanks();
	if ES*.es_textInPos* = '\e' then
	    headerDone := false;
	    if fleetChar = '*' then
		if ES*.es_world.w_shipNext ~= 0 then
		    for i from 0 upto ES*.es_world.w_shipNext - 1 do
			server(rt_readShip, i);
			if rsh*.sh_owner = ES*.es_countryNumber and
			    rsh*.sh_fleet = '*'
			then
			    if not headerDone then
				headerDone := true;
				user("Ships not in any fleet: ");
			    else
				userC('/');
			    fi;
			    userN(i);
			fi;
		    od;
		fi;
		if headerDone then
		    userNL();
		else
		    user("You have no ships not in a fleet.\n");
		fi;
	    else
		pos := fleetPos(fleetChar);
		if ES*.es_country.c_fleets[pos] = NO_FLEET then
		    user("You have no fleet ");
		    userC(fleetChar);
		    userNL();
		else
		    server(rt_readFleet, ES*.es_country.c_fleets[pos]);
		    if rf*.f_count = 0 then
			user("You have no ships in fleet ");
			userC(fleetChar);
			userNL();
		    else
			user("Ships in fleet ");
			userC(fleetChar);
			user(": ");
			for i from 0 upto rf*.f_count - 1 do
			    if i ~= 0 then
				userC('/');
			    fi;
			    userN(rf*.f_ship[i]);
			od;
			userNL();
		    fi;
		fi;
	    fi;
	elif getShips(&shs) then
	    if fleetChar = '*' then
		/* taking ships out of specific fleets */
		ES*.es_bool1 := true;
	    else
		ES*.es_bool1 := false;
		ES*.es_uint2 := fleetChar - '\e';
		pos := fleetPos(fleetChar);
		ES*.es_uint1 := ES*.es_country.c_fleets[pos];
		if ES*.es_uint1 = NO_FLEET then
		    /* creating a new fleet */
		    server(rt_lockWorld, 0);
		    ES*.es_uint1 := ES*.es_request.rq_u.ru_world.w_fleetNext;
		    ES*.es_request.rq_u.ru_world.w_fleetNext := ES*.es_uint1+1;
		    server(rt_unlockWorld, 0);
		    ES*.es_world.w_fleetNext := ES*.es_uint1 + 1;
		    rf*.f_count := 0;
		    server(rt_createFleet, ES*.es_uint1);
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_fleets[pos] :=
			ES*.es_uint1;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    ES*.es_country.c_fleets[pos] := ES*.es_uint1;
		fi;
	    fi;
	    if scanShips(&shs, doFleet) = 0 then
		err("no ships matched");
	    fi;
	fi;
    fi;
corp;

proc cmd_mine()bool:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    [100] char buf;
    register uint mapped;
    uint shipNumber, shells, drop;

    if reqShip(&shipNumber, "Ship to mine from? ") then
	server(rt_readShip, shipNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	if rsh*.sh_owner ~= ES*.es_countryNumber then
	    err("you don't own that ship");
	else
	    accessShip(shipNumber);
	    if rsh*.sh_type ~= st_destroyer then
		err("that ship isn't a destroyer");
	    elif rsh*.sh_shells = 0 then
		err("no shells on board");
	    else
		shells := readShipQuan(rsh, it_shells);
		mapped := mapAbsSector(rsh*.sh_row, rsh*.sh_col);
		server(rt_readSector, mapped);
		if rs*.s_type ~= s_water then
		    err("can only mine open water");
		else
		    ignore skipBlanks();
		    userN2("Destroyer \#", shipNumber);
		    userN3(" is carrying ", shells," shells, drop how many? ");
		    getPrompt(&buf[0]);
		    if reqPosRange(&drop, shells, &buf[0]) then
			server(rt_lockShip, shipNumber);
			shells := readShipQuan(rsh, it_shells);
			if drop > shells then
			    drop := shells;
			fi;
			writeShipQuan(rsh, it_shells, shells - drop);
			server(rt_unlockShip, shipNumber);
			server(rt_lockSector, mapped);
			writeQuan(rs,it_shells, readQuan(rs,it_shells) + drop);
			server(rt_unlockSector, mapped);
			while drop ~= 0 do
			    drop := drop - 1;
			    user("Splash! ");
			    uFlush();
			od;
			userNL();
		    fi;
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc doTorp(uint subNumber, victimNumber)void:
    register *Ship_t rsh;
    register *char name;
    register uint distance, i, damage;
    Fleet_t fleet;
    [20] char buf;
    uint defender, mapped, aRow, aCol;
    int sRow, sCol, vRow, vCol;
    bool killed, underSea;
    char fleetChar;

    server(rt_lockShip, subNumber);
    torpCost();
    server(rt_unlockShip, subNumber);
    rsh := &ES*.es_request.rq_u.ru_ship;
    aRow := rsh*.sh_row;
    aCol := rsh*.sh_col;
    sRow := rowToMe(rsh*.sh_row);
    sCol := colToMe(rsh*.sh_col);
    server(rt_readShip, victimNumber);
    defender := rsh*.sh_owner;
    underSea := rsh*.sh_type = st_submarine;
    vRow := rowToMe(rsh*.sh_row);
    vCol := colToMe(rsh*.sh_col);
    fleetChar := rsh*.sh_fleet;
    distance := findDistance(sRow, sCol, vRow, vCol);
    if distance > ES*.es_world.w_torpRange then
	distance := ES*.es_world.w_torpRange + 2;
    fi;
    user("FWHOOSH");
    uFlush();
    for i from 0 upto random(5) + distance * 2 do
	sleep(10);
	userC('.');
	uFlush();
    od;
    if distance > ES*.es_world.w_torpRange then
	user("out of range!\n");
    elif random(100) <
	if distance = 0 then
	    ES*.es_world.w_torpAcc0
	elif distance = 1 then
	    ES*.es_world.w_torpAcc1
	elif distance = 2 then
	    ES*.es_world.w_torpAcc2
	else
	    ES*.es_world.w_torpAcc3
	fi
    then
	user("BOOM!\n");
	damage := (random(ES*.es_world.w_torpRand) + ES*.es_world.w_torpBase) *
			ES*.es_world.w_shipDamage[rsh*.sh_type];
	attackShip(victimNumber, damage, at_torp, "A submarine");
    else
	user("missed.\n");
    fi;
    mapped := mapAbsSector(sRow, sCol);
    server(rt_readShip, victimNumber);
    if underSea then
	/* undersea fight - the victim sub can fire back */
	if rsh*.sh_efficiency >= 60 and rsh*.sh_guns ~= 0 and
	    readShipQuan(rsh, it_shells) >= ES*.es_world.w_torpCost
	then
	    server(rt_lockShip, victimNumber);
	    torpCost();
	    server(rt_unlockShip, victimNumber);
	    user("Approaching torpedo!!");
	    uFlush();
	    for i from 0 upto random(5) + distance * 2 do
		sleep(10);
		userC('.');
		uFlush();
	    od;
	    if random(100) <
		if distance = 0 then
		    ES*.es_world.w_torpAcc0
		elif distance = 1 then
		    ES*.es_world.w_torpAcc1
		elif distance = 2 then
		    ES*.es_world.w_torpAcc2
		else
		    ES*.es_world.w_torpAcc3
		fi
	    then
		user("BOOM!\n");
		damage := (random(ES*.es_world.w_torpRand) +
			    ES*.es_world.w_torpBase) *
			    ES*.es_world.w_shipDamage[st_submarine];
		userN3("Torpedo does ", damage, "% damage!\n");
		server(rt_lockShip, subNumber);
		damageShip(subNumber, damage);
		server(rt_unlockShip, subNumber);
	    else
		user("missed.\n");
	    fi;
	fi;
    elif fleetChar ~= '*' then
	/* victim on surface - destroyers in same fleet can depth charge */
	killed := false;
	server(rt_readCountry, defender);
	server(rt_readFleet,
	       ES*.es_request.rq_u.ru_country.c_fleets[fleetPos(fleetChar)]);
	fleet := ES*.es_request.rq_u.ru_fleet;
	i := 0;
	while i ~= fleet.f_count and not killed do
	    victimNumber := fleet.f_ship[i];
	    server(rt_readShip, victimNumber);
	    if rsh*.sh_row = aRow and rsh*.sh_col = aCol and
		rsh*.sh_type = st_destroyer and rsh*.sh_efficiency >= 60 and
		readShipQuan(rsh, it_shells) >= ES*.es_world.w_chargeCost
	    then
		server(rt_lockShip, victimNumber);
		updateShip(victimNumber);
		if rsh*.sh_owner ~= 0 then
		    dropCost();
		    server(rt_unlockShip, victimNumber);
		    damage := (random(ES*.es_world.w_chargeRand) +
				    ES*.es_world.w_chargeBase) *
				ES*.es_world.w_shipDamage[st_submarine];
		    damage := umin(100, damage);
		    userN3("Kawhoomph! Depth charge does ",
			   damage, "% damage!\n");
		    server(rt_lockShip, subNumber);
		    damageShip(subNumber, damage);
		    server(rt_unlockShip, subNumber);
		    if rsh*.sh_owner = 0 then
			killed := true;
		    fi;
		else
		    server(rt_unlockShip, victimNumber);
		fi;
	    fi;
	    i := i + 1;
	od;
    fi;
corp;

proc cmd_torpedo()bool:
    register *Ship_t rsh;
    uint subNumber, victimNumber;

    if reqShip(&victimNumber, "Ship to torpedo? ") and
	doSkipBlanks() and
	reqShip(&subNumber, "Submarine to launch torpedo? ")
    then
	server(rt_readShip, subNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	if rsh*.sh_owner ~= ES*.es_countryNumber then
	    userN3("You don't own ship \#", subNumber, "\n");
	else
	    accessShip(subNumber);
	    if rsh*.sh_type ~= st_submarine then
		userN3("Ship \#", subNumber, " isn't a submarine\n");
	    elif rsh*.sh_guns = 0 then
		user("No torpedo tubes (guns) available\n");
	    elif readShipQuan(rsh, it_shells) < ES*.es_world.w_torpCost then
		userN3("No torpedos (", ES*.es_world.w_torpCost,
		       " shells each) on board\n");
	    elif rsh*.sh_efficiency < 60 then
		user("Submarine not efficient enough to fire torpedos\n");
	    elif victimNumber = subNumber then
		err("submarines can't torpedo themselves");
	    else
		server(rt_readShip, victimNumber);
		if rsh*.sh_owner = 0 then
		    userN3("Ship \#", victimNumber,
		      " lies a-rusting at the bottom of the deep blue sea!\n");
		else
		    doTorp(subNumber, victimNumber);
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_drop()bool:
    [NAME_LEN + 20] char buf;
    register *Ship_t rsh;
    register uint i, damage;
    uint subNumber, desNumber, defender;
    uint aRow, aCol;

    if reqShip(&subNumber, "Sub to drop depth charge on? ") and
	doSkipBlanks() and
	reqShip(&desNumber, "Destroyer to drop depth charge? ")
    then
	server(rt_readShip, desNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	if rsh*.sh_owner ~= ES*.es_countryNumber then
	    userN3("You don't own ship \#", desNumber, "\n");
	else
	    server(rt_lockShip, desNumber);
	    updateShip(desNumber);
	    server(rt_unlockShip, desNumber);
	    if rsh*.sh_type ~= st_destroyer then
		userN3("Ship \#", desNumber, " isn't a destroyer\n");
	    elif rsh*.sh_efficiency < 60 then
		user("Destroyer not efficient enough to drop depth charge\n");
	    elif rsh*.sh_guns = 0 then
		user("No depth charge racks (guns) available\n");
	    elif readShipQuan(rsh, it_shells) < ES*.es_world.w_chargeCost then
		userN3("No depth charges (", ES*.es_world.w_chargeCost,
		       " shells each) on board\n");
	    else
		aRow := rsh*.sh_row;
		aCol := rsh*.sh_col;
		server(rt_readShip, subNumber);
		if rsh*.sh_owner = 0 then
		    userN3("Ship \#", subNumber,
		      " lies a-rusting at the bottom of the deep blue sea!\n");
		elif rsh*.sh_type ~= st_submarine then
		    userN3("Ship \#", subNumber, " isn't a submarine\n");
		elif rsh*.sh_row ~= aRow or rsh*.sh_col ~= aCol then
		    user("That submarine isn't under your destroyer!\n");
		else
		    defender := rsh*.sh_owner;
		    server(rt_lockShip, desNumber);
		    dropCost();
		    server(rt_unlockShip, desNumber);
		    user(&ES*.es_country.c_name[0]);
		    userN2(" destroyer \#", desNumber);
		    getPrompt(&buf[0]);
		    attackShip(subNumber,
			       random(ES*.es_world.w_chargeRand) +
				ES*.es_world.w_chargeBase,
			       at_drop, &buf[0]);
		    server(rt_lockShip, subNumber);
		    if readShipQuan(rsh, it_shells) >=
			    ES*.es_world.w_torpCost and
			rsh*.sh_guns ~= 0 and rsh*.sh_efficiency >= 60
		    then
			torpCost();
			server(rt_unlockShip, subNumber);
			user("Torpedo approaching!! ");
			uFlush();
			for i from 0 upto random(5) + 5 do
			    sleep(10);
			    userC('.');
			    uFlush();
			od;
			if random(100) < ES*.es_world.w_torpAcc0 then
			    damage := (random(ES*.es_world.w_torpRand) +
				       ES*.es_world.w_torpBase) *
				       ES*.es_world.w_shipDamage[st_submarine];
			    damage := umin(100, damage);
			    userN3("Kawhoomph! Torpedo does ",
				   damage, "% damage!\n");
			    server(rt_lockShip, desNumber);
			    damageShip(desNumber, damage);
			    server(rt_unlockShip, desNumber);
			else
			    user(" Missed!\n");
			fi;
		    else
			server(rt_unlockShip, subNumber);
		    fi;
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

/*
 * lookLand - lookout from ship to land.
 */

proc lookLand(int r, c)void:
    Sector_t s;

    server(rt_readSector, mapSector(r, c));
    if ES*.es_request.rq_u.ru_sector.s_owner ~= 0 and
	ES*.es_request.rq_u.ru_sector.s_owner ~= ES*.es_countryNumber
    then
	s := ES*.es_request.rq_u.ru_sector;
	server(rt_readCountry, s.s_owner);
	user(&ES*.es_request.rq_u.ru_country.c_name[0]);
	userS(" sector ", r, c, ", is a ");
	userN(s.s_efficiency / 10 * 10);
	user3("% efficient ", getDesigName(s.s_type), ".\n");
    fi;
corp;

/*
 * doLookout - lookout from somewhere to ships.
 */

proc doLookout(int vRow, vCol; uint rang; bool hasSonar)void:
    register *Ship_t rsh;
    Ship_t sh;
    uint shipNumber, distance, size, rangeSq;
    register int r, c;

    if ES*.es_world.w_shipNext ~= 0 then
	rsh := &ES*.es_request.rq_u.ru_ship;
	rangeSq := make(rang, ulong) * rang / (1000 * 1000);
	for shipNumber from 0 upto ES*.es_world.w_shipNext - 1 do
	    server(rt_readShip, shipNumber);
	    if rsh*.sh_owner ~= 0 then		/* wrecks don't show up */
		r := rowToMe(rsh*.sh_row);
		if r >= vRow + ES*.es_world.w_rows / 2 then
		    r := r - ES*.es_world.w_rows;
		elif r <= vRow - ES*.es_world.w_rows / 2 then
		    r := r + ES*.es_world.w_rows;
		fi;
		c := colToMe(rsh*.sh_col);
		if c >= vCol + ES*.es_world.w_columns / 2 then
		    c := c - ES*.es_world.w_columns;
		elif c <= vCol - ES*.es_world.w_columns / 2 then
		    c := c + ES*.es_world.w_columns;
		fi;
		distance := findDistance(r, c, vRow, vCol);
		size := ES*.es_world.w_shipSize[rsh*.sh_type];
		if rsh*.sh_type = st_submarine then
		    size := if hasSonar then 15 else 1 fi;
		fi;
		if distance < make(rangeSq, ulong) * size * size /
				    ES*.es_world.w_lookShipFact
		then
		    if rsh*.sh_type = st_submarine then
			user("Snorkel");
		    else
			sh := rsh*;
			server(rt_readCountry, sh.sh_owner);
			user(&ES*.es_request.rq_u.ru_country.c_name[0]);
			userSp();
			user(getShipName(sh.sh_type));
			userN2(" \#", shipNumber);
			userN3(" (", sh.sh_efficiency / 10 * 10,
			       "% efficient)");
		    fi;
		    userS(" at ", r, c, "\n");
		fi;
	    fi;
	od;
    fi;
corp;

proc cmd_lookout()bool:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    uint shipNumber, rang;
    register int r, c;
    int rReal, cReal;
    bool isShip, goodWeather, hasSonar;

    if reqSectorOrShip(&rReal, &cReal, &shipNumber, &isShip,
		       "Sector or ship to look out from? ")
    then
	rs := &ES*.es_request.rq_u.ru_sector;
	if isShip then
	    server(rt_readShip, shipNumber);
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
	    else
		accessShip(shipNumber);
		r := rowToMe(rsh*.sh_row);
		c := colToMe(rsh*.sh_col);
		goodWeather := weather(rsh*.sh_row, rsh*.sh_col) > STORM_FORCE;
		hasSonar :=
		    rsh*.sh_type = st_destroyer or rsh*.sh_type = st_submarine;
		rang :=
		   ES*.es_world.w_shipRange[rsh*.sh_type] * rsh*.sh_efficiency;
		if goodWeather then
		    lookLand(r - 1, c - 1);
		fi;
		lookLand(r - 1, c);
		if goodWeather then
		    lookLand(r - 1, c + 1);
		fi;
		lookLand(r, c - 1);
		lookLand(r, c + 1);
		if goodWeather then
		    lookLand(r + 1, c - 1);
		fi;
		lookLand(r + 1, c);
		if goodWeather then
		    lookLand(r + 1, c + 1);
		fi;
		doLookout(r, c, rang, hasSonar);
	    fi;
	else
	    r := rReal;
	    c := cReal;
	    server(rt_readSector, mapSector(r, c));
	    if rs*.s_owner ~= ES*.es_countryNumber then
		err("you don't own that sector");
	    else
		accessSector(r, c);
		goodWeather := weather(rowToAbs(r), colToAbs(c)) > STORM_FORCE;
		rang := make(rs*.s_efficiency, uint) * 40;
		if goodWeather then
		    lookLand(r - 1, c - 1);
		fi;
		lookLand(r - 1, c);
		if goodWeather then
		    lookLand(r - 1, c + 1);
		fi;
		lookLand(r, c - 1);
		lookLand(r, c + 1);
		if goodWeather then
		    lookLand(r + 1, c - 1);
		fi;
		lookLand(r + 1, c);
		if goodWeather then
		    lookLand(r + 1, c + 1);
		fi;
		doLookout(r, c, rang, false);
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_refurb()bool:
    register *Ship_t rsh;
    register *Sector_t rs @ rsh;
    register *Country_t rc @ rsh;
    uint shipNumber;
    register int r, c;
    uint shipTechLevel, couTechLevel, delta, aRow, aCol, mapped;
    int cost;
    bool aborting;

    if reqShip(&shipNumber,"Refurbish which ship: ") then
	server(rt_readShip, shipNumber);
	rsh := &ES*.es_request.rq_u.ru_ship;
	if rsh*.sh_owner ~= ES*.es_countryNumber then
	    err("You don't own that ship");
	else
	    accessShip(shipNumber);
	    aRow := rsh*.sh_row;
	    aCol := rsh*.sh_col;
	    shipTechLevel := rsh*.sh_techLevel;
	    r := rowToMe(aRow);
	    c := colToMe(aCol);
	    accessSector(r, c);
	    aborting := false;
	    if weather(aRow, aCol) <= STORM_FORCE then
		err("weather is too bad for refurb");
		aborting := true;
	    elif rs*.s_type = s_water or rs*.s_type = s_bridgeSpan then
		err("ship is at sea");
		aborting := true;
	    elif rs*.s_owner ~= ES*.es_countryNumber then
		if rs*.s_checkPoint = 0 then
		    userS("Sector ", r, c, " is owned by someone else\n");
		    aborting := true;
		else
		    if not verifyCheckPoint(r, c, rs) then
			aborting := true;
		    fi;
		fi;
	    fi;
	    if not aborting then
		if rs*.s_type ~= s_harbour then
		    userS("Sector ", r, c, " is not a harbour\n");
		else
		    couTechLevel := ES*.es_country.c_techLevel;
		    if shipTechLevel >= couTechLevel then
			err("ship is as advanced as your country can make it");
		    elif rs*.s_production = 0 then
			err("no production in harbour for refurb");
		    else
			delta := couTechLevel - shipTechLevel;
			if delta > rs*.s_production then
			    delta := rs*.s_production;
			fi;
			cost := delta * ES*.es_world.w_refurbCost;
			if cost > ES*.es_country.c_money then
			    err("you can't afford the refurb");
			else
			    mapped := mapAbsSector(aRow, aCol);
			    server(rt_lockSector, mapped);
			    if rs*.s_production < delta then
				delta := rs*.s_production;
				cost := delta * ES*.es_world.w_refurbCost;
			    fi;
			    rs*.s_production := rs*.s_production - delta;
			    server(rt_unlockSector, mapped);
			    server(rt_lockShip, shipNumber);
			    rsh*.sh_techLevel := rsh*.sh_techLevel + delta;
			    server(rt_unlockShip, shipNumber);
			    if rsh*.sh_techLevel = couTechLevel then
				user("Ship brought up to date.\n");
			    else
				user(
				 "Not enough production for a full refurb.\n");
				userN3("Ship brought to tech level ",
				       rsh*.sh_techLevel, ".\n");
			    fi;
			    server(rt_lockCountry, ES*.es_countryNumber);
			    rc*.c_money := rc*.c_money - cost;
			    server(rt_unlockCountry, ES*.es_countryNumber);
			    ES*.es_country.c_money := rc*.c_money;
			fi;
		    fi;
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;
