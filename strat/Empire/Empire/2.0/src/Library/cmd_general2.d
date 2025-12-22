#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g
#Scan.g
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
 * doDeliver - part of cmd_deliver
 */

proc doDeliver(register int r, c; register *Sector_t s)void:
    [100] char buf;
    register ItemType_t what;
    uint mapped, thresh;
    int r1, c1, bundleSize;
    ushort dir;
    bool failing;

    bundleSize := getBundleSize(s*.s_type, ES*.es_itemType1);
    if s*.s_type ~= s_exchange then
	ES*.es_bool1 := true;
	mapped := mapSector(r, c);
	what := ES*.es_itemType1;
	if ES*.es_bool2 then
	    if s*.s_direction[what] ~= NO_DELIVER then
		userS("Sector ", r, c, " (");
		user(getDesigName(s*.s_type));
		userN3(") threshold ",
		       s*.s_threshold[what] * bundleSize, "\n");
	    fi;
	elif ES*.es_bool3 then
	    if s*.s_direction[what] ~= NO_DELIVER then
		if ES*.es_int1 > 127 * bundleSize then
		    userS("Threshold too big at ", r, c, "; ");
		    userN(bundleSize * 127);
		    user(" used.\n");
		    thresh := 127;
		else
		    thresh := ES*.es_int1 / bundleSize;
		fi;
		server(rt_lockSector, mapped);
		ES*.es_request.rq_u.ru_sector.s_threshold[what] := thresh;
		server(rt_unlockSector, mapped);
	    fi;
	else
	    userS("destination for sector ", r, c, ": ");
	    getPrompt(&buf[0]);
	    failing := false;
	    while
		if reqSector(&r1, &c1, &buf[0]) then
		    |(r1 - r) > 1 or |(c1 - c) > 1
		else
		    failing := true;
		    false
		fi
	    do
		err("unreachable sector");
	    od;
	    if not failing then
		ignore skipBlanks();
		ES*.es_int2 := ES*.es_int1;
		if ES*.es_textInPos* ~= '\e' then
		    if ES*.es_textInPos* = '(' then
			ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
			if getNumber(&ES*.es_int2) then
			    if ES*.es_textInPos* = ')' then
				ES*.es_textInPos :=
				    ES*.es_textInPos + sizeof(char);
			    else
				err("missing ')'");
				failing := true;
			    fi;
			else
			    failing := true;
			fi;
		    else
			err("invalid threshold");
			failing := true;
		    fi;
		fi;
	    fi;
	    if not failing then
		if ES*.es_int2 > 127 * bundleSize then
		    userS("Threshold too big at ", r, c, "; ");
		    userN(bundleSize * 127);
		    user(" used.\n");
		    thresh := 127;
		else
		    thresh := ES*.es_int2 / bundleSize;
		fi;
		dir :=
		    if r1 = r - 1 then
			if c1 = c - 1 then
			    7
			elif c1 = c then
			    0
			else
			    1
			fi
		    elif r1 = r then
			if c1 = c - 1 then
			    6
			elif c1 = c then
			    NO_DELIVER
			else
			    2
			fi
		    else
			if c1 = c - 1 then
			    5
			elif c1 = c then
			    4
			else
			    3
			fi
		    fi;
		server(rt_lockSector, mapped);
		ES*.es_request.rq_u.ru_sector.s_threshold[what] := thresh;
		ES*.es_request.rq_u.ru_sector.s_direction[what] := dir;
		server(rt_unlockSector, mapped);
	    fi;
	fi;
    fi;
corp;

proc cmd_deliver()bool:
    SectorScan_t ss;
    register *char inputPtr;
    bool failing;

    if reqCmsgpob(&ES*.es_itemType1,
	"Enter type of thing to set delivery for: ") and
	doSkipBlanks() and
	reqSectors(&ss, "Enter sectors specification for delivery: ")
    then
	inputPtr := skipBlanks();
	failing := false;
	ES*.es_int1 := 0;
	ES*.es_bool3 := false;
	ES*.es_bool2 := false;
	if inputPtr* ~= '\e' then
	    if inputPtr* = '(' then
		ES*.es_textInPos := inputPtr + sizeof(char);
		if getNumber(&ES*.es_int1) then
		    if ES*.es_textInPos* = ')' then
			ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
		    else
			err("missing ')' after threshold");
			failing := true;
		    fi;
		else
		    failing := true;
		fi;
	    elif inputPtr* = '+' then
		ES*.es_textInPos := inputPtr + sizeof(char);
		if getNumber(&ES*.es_int1) then
		    ES*.es_bool3 := true;
		else
		    failing := true;
		fi;
	    elif inputPtr* = '-' and
		((inputPtr + 1)* = ' ' or (inputPtr + 1)* = '\t' or
		 (inputPtr + 1)* = '\e')
	    then
		ES*.es_textInPos := inputPtr + sizeof(char);
		ES*.es_bool2 := true;
	    elif (inputPtr* < '0' or inputPtr* > '9') and inputPtr* ~= '-' then
		err("invalid threshold specification");
		failing := true;
	    fi;
	fi;
	if not failing then
	    ignore skipBlanks();
	    ES*.es_bool1 := false;
	    if scanSectors(&ss, doDeliver) = 0 then
		err("no sectors matched");
	    elif not ES*.es_bool1 then
		err("can't deliver from an exchange");
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
 * doEnlist1 - part of cmd_enlist
 */

proc doEnlist1(int r, c; *Sector_t s)void:

    if s*.s_type ~= s_urban and readQuan(s, it_civilians) ~= 1 then
	ES*.es_ulong1 := ES*.es_ulong1 + readQuan(s, it_civilians);
    fi;
corp;

/*
 * doEnlist2 - another part of cmd_enlist
 */

proc doEnlist2(int r, c; register *Sector_t s)void:
    register uint enlisted;
    uint mapped;

    if s*.s_type ~= s_urban and readQuan(s, it_civilians) ~= 1 then
	mapped := mapSector(r, c);
	server(rt_lockSector, mapped);
	s := &ES*.es_request.rq_u.ru_sector;
	enlisted :=
	    min(127 - readQuan(s, it_military),
		readQuan(s, it_civilians) * ES*.es_uint1 / 100);
	writeQuan(s, it_civilians, readQuan(s, it_civilians) - enlisted);
	writeQuan(s, it_military, readQuan(s, it_military) + enlisted);
	server(rt_unlockSector, mapped);
	if enlisted ~= 0 then
	    ES*.es_ulong1 := ES*.es_ulong1 + enlisted;
	    userN(enlisted);
	    userS(" civilians answered the call at ", r, c, "\n");
	fi;
    fi;
corp;

proc cmd_enlist()bool:
    SectorScan_t ss;
    int wanted;

    if reqSectors(&ss, "Enter sectors for enlistment: ") and
	doSkipBlanks() and
	reqNumber(&wanted, "Total number to enlist: ")
    then
	ES*.es_ulong1 := 0;
	ignore scanSectors(&ss, doEnlist1);
	ES*.es_uint1 := make(wanted, ulong) * 100 / ES*.es_ulong1;
	if ES*.es_uint1 > 50 then
	    ES*.es_uint1 := 50;
	fi;
	ES*.es_ulong1 := 0;
	ignore scanSectors(&ss, doEnlist2);
	if ES*.es_ulong1 = 0 then
	    err("nobody answered the call - not very patriotic!");
	else
	    userN(ES*.es_ulong1);
	    user(" new enlistees.\n");
	fi;
	true
    else
	false
    fi
corp;

/*
 * doDefend - part of cmd_defend
 */

proc doDefend(register int r, c; register *Sector_t s)void:
    *char savePtr;
    uint mapped;
    [50] char buf;
    int rDefender, cDefender;

    if ES*.es_bool1 then
	if s*.s_defender ~= NO_DEFEND then
	    getDefender(r, c, s, &rDefender, &cDefender);
	    userS("Sector ", r, c, " is defended by fortress at ");
	    userS("", rDefender, cDefender, "\n");
	fi;
    else
	savePtr := ES*.es_textInPos;
	userS("Defender for sector ", r, c, ": ");
	getPrompt(&buf[0]);
	if reqSector(&rDefender, &cDefender, &buf[0]) then
	    server(rt_readSector, mapSector(rDefender, cDefender));
	    s := &ES*.es_request.rq_u.ru_sector;
	    if s*.s_owner ~= ES*.es_countryNumber then
		err("you don't own that sector");
	    elif |(rDefender - r) >= 8 or |(cDefender - c) >= 8 then
		ES*.es_textInPos := savePtr;
		userS("Sector ", rDefender, cDefender, "");
		userS(" is too far away from sector ", r, c, "\n");
	    elif s*.s_type ~= s_fortress and (rDefender ~= r or cDefender ~= c)
	    then
		userS("Sector ", rDefender, cDefender, " is not a fortress\n");
	    else
		ES*.es_textInPos := savePtr;
		mapped := mapSector(r, c);
		server(rt_lockSector, mapped);
		putDefender(r, c, s, rDefender, cDefender);
		server(rt_unlockSector, mapped);
	    fi;
	fi;
    fi;
corp;

proc cmd_defend()bool:
    SectorScan_t ss;
    bool aborting;

    if reqSectors(&ss, "Enter sectors to defend: ") then
	ignore skipBlanks();
	ES*.es_bool1 := false;
	aborting := false;
	if ES*.es_textInPos* = '%' then
	    ES*.es_bool1 := true;
	    aborting := not getPassword("Enter your current password: ",
					&ES*.es_country.c_password[0]);
	    userNL();
	fi;
	if not aborting then
	    if scanSectors(&ss, doDefend) = 0 then
		err("no sectors matched");
	    fi;
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

proc cmd_power()void:
    PowerHead_t ph;
    [COUNTRY_MAX] PowerData_t pd;
    PowerData_t temp;
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register *PowerData_t d;
    *char ptr;
    register uint i, j, cou @ j, shipNumber @ j;
    register int r @ i, c @ j;
    bool needRecalc, aborted;

    needRecalc := false;
    aborted := false;
    rs := &ES*.es_request.rq_u.ru_sector;
    ptr := ES*.es_textInPos;
    if ptr* ~= '\e' then
	skipWord()* := '\e';
	if CharsEqual(ptr, "force") then
	    if ES*.es_country.c_status = cs_deity or
		ES*.es_world.w_nonDeityPower
	    then
		needRecalc := true;
	    else
		err("Only a deity can force a new power - option ignored");
	    fi;
	else
	    err("unknown option to 'power'");
	fi;
    fi;

    if not needRecalc then
	/* read any existing power report */
	server(rt_readPower, 1);
	if ES*.es_request.rq_whichUnit = 0 then
	    err("power report not available");
	    aborted := true;
	else
	    ph := ES*.es_request.rq_u.ru_powerHead;
	    i := 0;
	    while
		server(rt_readPower, 1);
		ES*.es_request.rq_whichUnit ~= 0
	    do
		/* just in case we have a garbage file! */
		if i < COUNTRY_MAX then
		    pd[i] := ES*.es_request.rq_u.ru_powerData;
		    i := i + 1;
		fi;
	    od;
	    if i ~= ph.ph_countryCount then
		err("power report invalid");
		aborted := true;
	    else
		if ph.ph_lastTime <
		    ES*.es_request.rq_time - ES*.es_world.w_secondsPerETU * 48
		    and (ES*.es_country.c_status = cs_deity or
			 ES*.es_world.w_nonDeityPower) and
		    ask("Power report is stale. Recompute? ")
		then
		    needRecalc := true;
		fi;
	    fi;
	fi;
    fi;

    if needRecalc then
	user("Please wait, recomputing power...\n");

	/* initialize the slots for the various countries */

	for cou from ES*.es_world.w_currCountries - 1 downto 0 do
	    server(rt_readCountry, cou);
	    d := &pd[cou];
	    d*.pd_country := cou;
	    d*.pd_sect := 0;
	    d*.pd_civ := 0;
	    d*.pd_mil := 0;
	    d*.pd_shell := 0;
	    d*.pd_gun := 0;
	    d*.pd_plane := 0;
	    d*.pd_bar := 0;
	    d*.pd_effic := 0;
	    d*.pd_ship := 0;
	    d*.pd_tons := 0;
	    d*.pd_money := ES*.es_request.rq_u.ru_country.c_money;
	od;

	/* add up the contents of all of the sectors in the world */

	r := 0;
	while r ~= ES*.es_world.w_rows and not aborted do
	    c := 0;
	    while c ~= ES*.es_world.w_columns and not aborted do
		/* do NOT update the sector */
		server(rt_readSector, mapSector(r, c));
		d := &pd[rs*.s_owner];
		d*.pd_sect  := d*.pd_sect  + 1;
		d*.pd_civ   := d*.pd_civ   + readQuan(rs, it_civilians);
		d*.pd_mil   := d*.pd_mil   + readQuan(rs, it_military);
		d*.pd_shell := d*.pd_shell + readQuan(rs, it_shells);
		d*.pd_gun   := d*.pd_gun   + readQuan(rs, it_guns);
		d*.pd_plane := d*.pd_plane + readQuan(rs, it_planes);
		d*.pd_bar   := d*.pd_bar   + readQuan(rs, it_bars);
		d*.pd_effic := d*.pd_effic + rs*.s_efficiency;
		c := c + 1;
		aborted := ES*.es_gotControlC();
	    od;
	    r := r + 1;
	    if ES*.es_gotControlC() then
		aborted := true;
	    fi;
	od;

	/* add in the contents of all of the ships */

	if ES*.es_world.w_shipNext ~= 0 and not aborted then
	    shipNumber := 0;
	    while shipNumber ~= ES*.es_world.w_shipNext and not aborted do
		server(rt_readShip, shipNumber);
		d := &pd[rsh*.sh_owner];
		d*.pd_ship  := d*.pd_ship  + 1;
		d*.pd_tons  := d*.pd_tons  +
		    ES*.es_world.w_shipCost[rsh*.sh_type];
		if rsh*.sh_type = st_freighter then
		    d*.pd_civ := d*.pd_civ + rsh*.sh_crew;
		else
		    d*.pd_mil := d*.pd_mil + rsh*.sh_crew;
		fi;
		d*.pd_shell := d*.pd_shell + rsh*.sh_shells;
		d*.pd_gun   := d*.pd_gun   + rsh*.sh_guns;
		d*.pd_plane := d*.pd_plane + rsh*.sh_planes;
		d*.pd_bar   := d*.pd_bar   + rsh*.sh_bars;
		shipNumber := shipNumber + 1;
		aborted := ES*.es_gotControlC();
	    od;
	fi;

	if not aborted then

	    /* calculate the power for each country based on the stats */

	    for cou from 1 upto ES*.es_world.w_currCountries - 1 do
		d := &pd[cou];
		d*.pd_power :=
		    (d*.pd_effic + d*.pd_gun) / 3 +
		    (d*.pd_civ + d*.pd_mil + d*.pd_shell + d*.pd_tons) / 10 +
		    d*.pd_money / 100 + d*.pd_plane +
		    d*.pd_ship + d*.pd_bar * 5;
	    od;

	    /* if enough countries, sort them by power */

	    if ES*.es_world.w_currCountries > 2 then
		for i from ES*.es_world.w_currCountries - 2 downto 1 do
		    for j from 1 upto i do
			if pd[j].pd_power < pd[j + 1].pd_power then
			    temp := pd[j];
			    pd[j] := pd[j + 1];
			    pd[j + 1] := temp;
			fi;
		    od;
		od;
	    fi;
	    ph.ph_lastTime := ES*.es_request.rq_time;
	    ph.ph_countryCount := ES*.es_world.w_currCountries;
	    for i from 1 upto ph.ph_countryCount - 1 do
		d := &pd[i];
		server(rt_readCountry, d*.pd_country);
		if ES*.es_country.c_status = cs_deity and
		    ES*.es_request.rq_u.ru_country.c_sectorCount ~= d*.pd_sect
		then
		    user3("NOTE: Country ",
			  &ES*.es_request.rq_u.ru_country.c_name[0],
			  " has ");
		    userN(d*.pd_sect);
		    userN3(" sectors, but country record shows ",
			   ES*.es_request.rq_u.ru_country.c_sectorCount,
			   " sectors!\n");
		fi;
	    od;

	    /* try to write the resulting power file */

	    ES*.es_request.rq_u.ru_powerHead := ph;
	    server(rt_writePower, 1);
	    if ES*.es_request.rq_whichUnit = 0 then
		err("error writing power file");
		aborted := true;
	    else
		i := 0;
		while i ~= ES*.es_world.w_currCountries do
		    ES*.es_request.rq_u.ru_powerData := pd[i];
		    i := i + 1;
		    server(rt_writePower, 1);
		    if ES*.es_request.rq_whichUnit = 0 then
			err("error writing power file");
			aborted := true;
			i := ES*.es_world.w_currCountries;
		    fi;
		od;
		if not aborted then
		    server(rt_writePower, 0);
		    user("Power report updated\n\n");
		fi;
	    fi;
	fi;
    fi;

    if not aborted then
	user("Empire power report as of ");
	uTime(ph.ph_lastTime);
	user(":\n");
	user(
" sect    civ    mil    sh   gun  pl  bar   % ship    $     pow  country\n"
	);
	dash(75);
	for i from 1 upto ph.ph_countryCount - 1 do
	    d := &pd[i];
	    server(rt_readCountry, d*.pd_country);
	    if ES*.es_request.rq_u.ru_country.c_status = cs_active then
		userF(d*.pd_sect, 5);
		userF(d*.pd_civ, 7);
		userF(d*.pd_mil, 7);
		userF(d*.pd_shell, 6);
		userF(d*.pd_gun, 5);
		userF(d*.pd_plane, 5);
		userF(d*.pd_bar, 5);
		userF(d*.pd_effic / d*.pd_sect, 4);
		userF(d*.pd_ship, 4);
		userF(d*.pd_money, 8);
		userF(d*.pd_power, 6);
		user3("  ", &ES*.es_request.rq_u.ru_country.c_name[0], "\n");
	    fi;
	od;
	userNL();
    fi;
corp;

proc cmd_grant()bool:
    register *Sector_t rs;
    register *Country_t rc @ rs;
    uint who, mapped;
    int r, c;

    if reqSector(&r, &c, "Sector to grant? ") and doSkipBlanks() and
	reqCountry(&who, "Country to grant it to? ", false)
    then
	mapped := mapSector(r, c);
	server(rt_readSector, mapped);
	rs := &ES*.es_request.rq_u.ru_sector;
	if rs*.s_owner ~= ES*.es_countryNumber then
	    err("you don't own that sector");
	else
	    server(rt_lockSector, mapped);
	    updateSector(r, c);
	    server(rt_unlockSector, mapped);
	    if rs*.s_owner ~= ES*.es_countryNumber then
		err("sector lost on update");
	    elif rs*.s_type = s_capital or rs*.s_type = s_sanctuary then
		err("can't grant capitals or sanctuaries");
	    else
		server(rt_readCountry, who);
		if rc*.c_status ~= cs_active then
		    err("that country is not active");
		elif near(r, c, who, nil) then
		    server(rt_lockSector, mapped);
		    rs*.s_owner := who;
		    rs*.s_defender := NO_DEFEND;
		    rs*.s_checkPoint := 0;
		    server(rt_unlockSector, mapped);
		    server(rt_lockCountry, who);
		    rc*.c_sectorCount := rc*.c_sectorCount + 1;
		    server(rt_unlockCountry, who);
		    server(rt_lockCountry, ES*.es_countryNumber);
		    rc*.c_sectorCount := rc*.c_sectorCount - 1;
		    ES*.es_country.c_sectorCount := rc*.c_sectorCount;
		    if rc*.c_sectorCount = 0 then
			rc*.c_status := cs_dead;
			ES*.es_country.c_status := cs_dead;
		    fi;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    if ES*.es_country.c_status = cs_dead then
			user("You have just given away your last sector!!\n");
			news(n_dissolve, ES*.es_countryNumber, NOBODY);
		    fi;
		    user(&ES*.es_country.c_name[0]);
		    userTarget(who, " has granted you sector ", r, c, ".");
		    notify(who);
		    news(n_grant_sector, ES*.es_countryNumber, who);
		else
		    err("that country has no adjacent sector");
		fi;
	    fi;
	fi;
	true
    else
	false
    fi
corp;

/*
 * doSpy - part of cmd_spy. NOT called via the scanning stuff.
 */

proc doSpy(register int r, c)void:
    register *Sector_t rs;
    register *Country_t rc @ rs;
    Sector_t save;
    uint mil, owner, dir, mapped;
    int spyR, spyC;
    Relation_t relation;

    mapped := mapSector(r, c);
    server(rt_readSector, mapped);
    rs := &ES*.es_request.rq_u.ru_sector;
    save := rs*;
    mil := readQuan(rs, it_military);
    owner := rs*.s_owner;
    if owner ~= ES*.es_countryNumber then
	server(rt_readCountry, owner);
	relation := rc*.c_relations[ES*.es_countryNumber];
    fi;
    if ES*.es_country.c_btu = 0 then
	if not ES*.es_bool2 then
	    ES*.es_bool2 := true;
	    err("you have run out of BTU's - spying aborted");
	fi;
    elif owner ~= ES*.es_countryNumber and rc*.c_status ~= cs_deity and
	near(r, c, ES*.es_countryNumber, &dir)
    then
	ES*.es_bool1 := true;
	ES*.es_country.c_btu := ES*.es_country.c_btu - 1;
	if relation ~= r_allied and random(ES*.es_world.w_spyFactor) < mil then
	    /* the spy is captured */
	    if relation = r_neutral then
		/* just deported */
		userS("Spy captured and deported from ", r, c, ".\n");
		user2("Spy from ", &ES*.es_country.c_name[0]);
		userTarget(owner, " captured and deported from ", r, c, ".");
		notify(owner);
	    else
		/* shot! */
		news(n_spy_shot, ES*.es_countryNumber, owner);
		userS("Spy captured and shot in ", r, c, ".\n");
		user2("Spy from ", &ES*.es_country.c_name[0]);
		userTarget(owner, " captured and shot in ", r, c, ".");
		notify(owner);
		ignore relativeSector(r, c, dir, &spyR, &spyC);
		mapped := mapSector(spyR, spyC);
		server(rt_lockSector, mapped);
		updateSector(spyR, spyC);
		mil := readQuan(rs, it_military);
		if mil ~= 0 then
		    writeQuan(rs, it_military, mil - 1);
		    if rs*.s_quantity[it_military] = 0 and
			rs*.s_quantity[it_civilians] = 0
		    then
			userS("You have deserted sector", spyR, spyC, "!\n");
			rs*.s_owner := 0;
			rs*.s_defender := NO_DEFEND;
			rs*.s_checkPoint := 0;
		    fi;
		fi;
		server(rt_unlockSector, mapped);
		if rs*.s_owner = 0 then
		    server(rt_lockCountry, ES*.es_countryNumber);
		    rc*.c_sectorCount := rc*.c_sectorCount - 1;
		    ES*.es_country.c_sectorCount := rc*.c_sectorCount;
		    if rc*.c_sectorCount = 0 then
			rc*.c_status := cs_dead;
			ES*.es_country.c_status := cs_dead;
		    fi;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    if ES*.es_country.c_status = cs_dead then
			user("You have just emptied your last sector!!\n");
			news(n_dissolve, ES*.es_countryNumber, NOBODY);
		    fi;
		fi;
	    fi;
	else
	    /* the spying is successful */
	    user(&rc*.c_name[0]);
	    userS(" sector ", r, c, " is a ");
	    userN((save.s_efficiency + 5) / 10 * 10);
	    user2("% ", getDesigName(save.s_type));
	    userN2(" with approximately\n",
		   (readQuan(&save, it_civilians) + 5) / 10 * 10);
	    userN2(" civilians, ", (readQuan(&save, it_military)+5) / 10 * 10);
	    userN2(" military, ",  (readQuan(&save, it_shells) + 5) / 10 * 10);
	    userN2(" shells, ", (readQuan(&save, it_planes) + 5) / 10 * 10);
	    userN2(" planes and ", (readQuan(&save, it_guns) + 5) / 10 * 10);
	    user(" guns.\n");
	fi;
    fi;
corp;
	
proc cmd_spy()bool:
    register int r, c;
    int top, bottom, left, right;

    if reqBox(&top, &bottom, &left, &right,
	      "Enter sectors to try to spy into: ")
    then
	ES*.es_bool1 := false;
	ES*.es_bool2 := false;	/* re-use a field! */
	for r from top upto bottom do
	    for c from left upto right do
		doSpy(r, c);
	    od;
	od;
	if not ES*.es_bool1 then
	    err("none of those sectors are adjacent to your military");
	else
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_btu :=
		ES*.es_country.c_btu;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	fi;
	true
    else
	false
    fi
corp;

/*
 * doDump - part of cmd_dump
 */

proc doDump(register int r, c; register *Sector_t s)void:
    register ItemType_t it;

    while r < 0 do
	r := r + ES*.es_world.w_rows;
    od;
    while c < 0 do
	c := c + ES*.es_world.w_columns;
    od;
    userX(r, 2);
    userX(c, 2);
    userC(ES*.es_sectorChar[s*.s_type]);
    userX(s*.s_quantity[it_civilians], 2);
    userX(s*.s_quantity[it_military], 2);
    userX(s*.s_production, 2);
    userX(s*.s_mobility, 2);
    userX(s*.s_efficiency, 2);
    userX(s*.s_quantity[it_shells], 2);
    userX(s*.s_quantity[it_guns], 2);
    userX(s*.s_quantity[it_planes], 2);
    userX(s*.s_quantity[it_ore], 2);
    userX(s*.s_quantity[it_bars], 2);
    userX(s*.s_defender, 2);
    userX(s*.s_iron, 2);
    userX(s*.s_gold, 2);
    for it from it_civilians upto it_bars do
	userX(s*.s_direction[it], 1);
	userX(s*.s_threshold[it], 2);
    od;
    userX(if s*.s_price ~= 0 then 1 else 0 fi, 1);
    userX(if s*.s_checkPoint ~= 0 then 1 else 0 fi, 1);
    if ES*.es_country.c_status = cs_deity then
	userX(s*.s_owner, 2);
	userX(s*.s_plagueStage, 2);
	userX(s*.s_plagueTime, 2);
	userX(s*.s_lastUpdate, 8);
    fi;
    userNL();
corp;

proc cmd_dump()void:
    SectorScan_t ss;

    if reqSectors(&ss, "Sectors to dump? ") then
	uTime(ES*.es_request.rq_time);
	userNL();
	ignore scanSectors(&ss, doDump);
    fi;
corp;
