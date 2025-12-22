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
 * examineCountry - part of cmd_examine
 */

proc examineCountry(uint who)void:
    register *Country_t c;
    register uint i, col;

    server(rt_readCountry, who);
    c := &ES*.es_request.rq_u.ru_country;
    user3("Country: '", &c*.c_name[0], "'; password: '");
    user3(&c*.c_password[0], "'; status: ",
	    case c*.c_status
	    incase cs_deity:
		"DEITY"
	    incase cs_active:
		"Active"
	    incase cs_dead:
		"Destroyed"
	    incase cs_quit:
		"Resigned"
	    incase cs_idle:
		"Idle"
	    incase cs_visitor:
		"Visitor"
	    default:
		"<UNKNOWN>"
	    esac);
    userNL();
    userS("Capital at: ", c*.c_centerRow, c*.c_centerCol, "; last on at: ");
    uTime(c*.c_lastOn);
    userN3("; sectors: ", c*.c_sectorCount, "\n");
    userN2("BTU's left: ", c*.c_btu);
    userN2("; minutes left: ", c*.c_timeLeft);
    userN3("; bank balance: ", c*.c_money, "\n");
    userN2("Tech level: ", c*.c_techLevel);
    userN2("; Research level: ", c*.c_resLevel);
    user("; realms:\n    ");
    for i from 0 upto REALM_MAX - 1 do
	userN(i);
	userN2(" = (", c*.c_realms[i].r_top);
	userN2(":", c*.c_realms[i].r_bottom);
	userN2(",", c*.c_realms[i].r_left);
	userN2(":", c*.c_realms[i].r_right);
	user(")  ");
	if i % 2 = 1 then
	    userNL();
	    if i ~= REALM_MAX - 1 then
		user("    ");
	    fi;
	fi;
    od;
    user("Relations: \n");
    for i from 0 upto ES*.es_world.w_currCountries - 1 do
	userC(
	    case c*.c_relations[i]
	    incase r_neutral:
		'n'
	    incase r_allied:
		'a'
	    incase r_war:
		'w'
	    esac
	);
    od;
    userNL();
    user("Fleets: ");
    col := 11;
    for i from 0 upto 26 + 26 - 1 do
	if c*.c_fleets[i] ~= NO_FLEET then
	    if col > 73 then
		userNL();
		user("          ");
		col := 11;
	    fi;
	    userC(
		("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" + i)*);
	    userN3(":", c*.c_fleets[i], " ");
	fi;
    od;
    userNL();
    if c*.c_loggedOn then
	user("Currently marked as logged on\n");
    else
	user("Currently not marked as logged on\n");
    fi;
corp;

/*
 * examineSector - part of cmd_examine
 */

proc examineSector(int r, c)void:
    Sector_t s;
    register ItemType_t it;

    server(rt_readSector, mapSector(r, c));
    s := ES*.es_request.rq_u.ru_sector;
    userS("Sector ", r, c, " - ");
    userC(ES*.es_sectorChar[s.s_type]);
    user(": lastUpdate = ");
    uTime(s.s_lastUpdate);
    userN3(", owner = ", s.s_owner, " (");
    server(rt_readCountry, s.s_owner);
    user2(&ES*.es_request.rq_u.ru_country.c_name[0], ")\n");
    userN2("iron = ", s.s_iron);
    userN2(", gold = ", s.s_gold);
    userN3(", checkPoint = ", s.s_checkPoint, ", type = ");
    userC(ES*.es_sectorChar[s.s_type]);
    userN3(", shipCount = ", s.s_shipCount, "\n");
    userN2("production = ", s.s_production);
    userN2(", mobility = ", s.s_mobility);
    userN3(", efficiency = ", s.s_efficiency, "\n");
    userN2("plagueStage, ", s.s_plagueStage);
    userN3(", plagueTime = ", s.s_plagueTime, ", defender = ");
    userX(s.s_defender, 2);
    userN3(", price = ", s.s_price, "\n");
    for it from it_first upto it_last do
	user(getItemName(it));
	userN2(": quantity ", s.s_quantity[it]);
	userN2(", direction ", s.s_direction[it]);
	userN3(", threshold ", s.s_threshold[it], "\n");
    od;
corp;

/*
 * examineShip - part of cmd_examine
 */

proc examineShip(uint shipNumber)void:
    Ship_t ship;

    server(rt_readShip, shipNumber);
    ship := ES*.es_request.rq_u.ru_ship;
    userN3("Ship \#", shipNumber, " (");
    user2(getShipName(ship.sh_type), "): lastUpdate ");
    uTime(ship.sh_lastUpdate);
    userN3(", owner ", ship.sh_owner, "(");
    server(rt_readCountry, ship.sh_owner);
    user2(&ES*.es_request.rq_u.ru_country.c_name[0], ")\n");
    if ship.sh_price > 0 then
	userN3("price = ", ship.sh_price, " per ton");
    else
	user("NOT FOR SALE");
    fi;
    user(", fleet = ");
    userC(ship.sh_fleet);
    userS(", at ", ship.sh_row, ship.sh_col, ", effic = ");
    userN(ship.sh_efficiency);
    userN2(", mobil = ", ship.sh_mobility);
    userN3(", tech level = ", ship.sh_techLevel, "\n");
    userN2("crew = ", ship.sh_crew);
    userN2(", shells = ", ship.sh_shells);
    userN2(", guns = ", ship.sh_guns);
    userN2(", planes = ", ship.sh_planes);
    userN2(", ore = ", ship.sh_ore);
    userN3(", bars = ", ship.sh_bars, "\n");
corp;

/*
 * examineFleet - part of cmd_examine.
 */

proc examineFleet(uint fleetNumber)void:
    register *Fleet_t fleet;
    register uint i;

    server(rt_readFleet, fleetNumber);
    fleet := &ES*.es_request.rq_u.ru_fleet;
    if fleet*.f_count = 0 then
	userN3("No ships in fleet \#", fleetNumber, "\n");
    else
	userN3("Ships in fleet \#", fleetNumber, ": ");
	for i from 0 upto fleet*.f_count - 1 do
	    userN(fleet*.f_ship[i]);
	    if i ~= fleet*.f_count - 1 then
		userC('/');
	    fi;
	od;
	userNL();
    fi;
corp;

/*
 * examineLoan - part of cmd_examine.
 */

proc examineLoan(uint loanNumber)void:
    Loan_t loan;

    server(rt_readLoan, loanNumber);
    loan := ES*.es_request.rq_u.ru_loan;
    userN3("Loan \#", loanNumber, " offered by ");
    server(rt_readCountry, loan.l_loaner);
    user2(&ES*.es_request.rq_u.ru_country.c_name[0], " to ");
    server(rt_readCountry, loan.l_loanee);
    user2(&ES*.es_request.rq_u.ru_country.c_name[0], "\n");
    user("lastPay = ");
    uTime(loan.l_lastPay);
    user(", dueDate = ");
    uTime(loan.l_dueDate);
    userNL();
    userN2("amount = ", loan.l_amount);
    userN2(", paid = ", loan.l_paid);
    userN2(", duration = ", loan.l_duration);
    userN2(", rate = ", loan.l_rate);
    user3(", state = ",
	case loan.l_state
	incase l_offered:
	    "offered"
	incase l_declined:
	    "declined"
	incase l_outstanding:
	    "outstanding"
	incase l_paidUp:
	    "paid up"
	esac,
	"\n");
corp;

/*
 * examineWorld - part of cmd_examine.
 */

proc examineWorld()void:

    user3("Country creation password: ", &ES*.es_world.w_password[0], "\n");
    userN2("Weather: hiRowInc = ", ES*.es_world.w_weather.we_hiRowInc);
    userN2(", hiColInc = ", ES*.es_world.w_weather.we_hiColInc);
    userN2(", loRowInc = ", ES*.es_world.w_weather.we_loRowInc);
    userN3(", loColInc = ", ES*.es_world.w_weather.we_loColInc, "\n");
    userN2("         hiRow = ", ES*.es_world.w_weather.we_hiRow);
    userN2(", hiCol = ", ES*.es_world.w_weather.we_hiCol);
    userN2(", loRow = ", ES*.es_world.w_weather.we_loRow);
    userN3(", loCol = ", ES*.es_world.w_weather.we_loCol, "\n");
    userN2("         hiPressure = ", ES*.es_world.w_weather.we_hiPressure);
    userN3(", loPressure = ", ES*.es_world.w_weather.we_loPressure, "\n");
corp;

proc cmd_examine()void:
    uint what, n;
    int r, c;

    if ES*.es_country.c_status = cs_deity then
	if reqChoice(&what, "country\esector\eship\efleet\eloan\eworld\e",
		     "Examine what (country/sector/ship/fleet/loan/world)? ")
	then
	    ignore skipBlanks();
	    case what
	    incase 0:
		if reqCountry(&n, "Examine which country? ", true) then
		    examineCountry(n);
		fi;
	    incase 1:
		if reqSector(&r, &c, "Examine which sector? ") then
		    examineSector(r, c);
		fi;
	    incase 2:
		if reqShip(&n, "Examine which ship? ") then
		    examineShip(n);
		fi;
	    incase 3:
		if ES*.es_world.w_fleetNext = 0 then
		    err("there are no fleets yet");
		else
		    if reqPosRange(&n, ES*.es_world.w_fleetNext - 1,
				   "Examine which fleet? ")
		    then
			examineFleet(n);
		    fi;
		fi;
	    incase 4:
		if ES*.es_world.w_loanNext = 0 then
		    err("there are no loans yet");
		else
		    if reqPosRange(&n, ES*.es_world.w_loanNext - 1,
				   "Examine which loan? ")
		    then
			examineLoan(n);
		    fi;
		fi;
	    incase 5:
		examineWorld();
	    esac;
	fi;
    else
	err("only a deity can examine things");
    fi;
corp;

/*
 * getLNumber - read in a long signed number.
 */

proc getLNumber(*long pNum)bool:
    register *char inputPtr;
    register long n;
    register bool isNeg;

    inputPtr := ES*.es_textInPos;
    if inputPtr* = '-' then
	isNeg := true;
	inputPtr := inputPtr + sizeof(char);
    elif inputPtr* = '+' then
	isNeg := false;
	inputPtr := inputPtr + sizeof(char);
    else
	isNeg := false;
    fi;
    if inputPtr* >= '0' and inputPtr* <= '9' then
	n := 0;
	while inputPtr* >= '0' and inputPtr* <= '9' do
	    n := n * 10 + (inputPtr* - '0');
	    inputPtr := inputPtr + sizeof(char);
	od;
	ES*.es_textInPos := inputPtr;
	pNum* := if isNeg then -n else n fi;
	true
    else
	if inputPtr* = '\e' then
	    err("missing number");
	else
	    err("invalid number");
	    inputPtr* := '\e';
	fi;
	ES*.es_textInPos := inputPtr;
	false
    fi
corp;

/*
 * repNum - request a replacement for a long signed numeric value.
 */

proc repNum(long oldValue, minValue, maxValue; *char prompt)long:
    long n;
    [100] char promptBuffer;

    user(prompt);
    userN2(" (", minValue);
    userN3(" - ", maxValue, "): ");
    getPrompt(&promptBuffer[0]);
    user(&promptBuffer[0]);
    userN(oldValue);
    userNL();
    if not ES*.es_bool1 then
	while
	    uPrompt(&promptBuffer[0]);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		n := oldValue;
		false
	    else
		ignore skipBlanks();
		if getLNumber(&n) then
		    if n < minValue then
			err("value too small");
			true
		    elif n > maxValue then
			err("value too large");
			true
		    else
			false
		    fi
		else
		    true
		fi
	    fi
	do
	od;
    else
	n := oldValue;
    fi;
    n
corp;

/*
 * repScale - replace a scale factor that can be 10 - 1000.
 */

proc repScale(*uint pNum; *char prompt)void:

    pNum* := repNum(pNum*, 1, 1000, prompt);
corp;

/*
 * repMob - replace a mobility - value 0 - 100.
 */

proc repMob(*uint pCost; *char name)void:

    pCost* := repNum(pCost*, 0, 100, name);
corp;

/*
 * repCost - replace a cost - value is 10 - 128.
 */

proc repCost(*uint pCost; *char prompt)void:

    pCost* := repNum(pCost*, 10, 128, prompt);
corp;

/*
 * repRand - replace a base/rand pair.
 */

proc repRand(*uint pBase, pRand; *char what)void:
    [50] char buffer;

    user2(what, " base");
    getPrompt(&buffer[0]);
    pBase* := repNum(pBase*, 0, 127, &buffer[0]);
    user2(what, " rand");
    getPrompt(&buffer[0]);
    pRand* := repNum(pRand*, 1, 128, &buffer[0]);
corp;

/*
 * repBool - replace a boolean flag value.
 */

proc repBool(*bool pFlag; *char what)void:
    register *char p, q;
    bool flag;
    [100] char promptBuffer;

    user(what);
    user(": ");
    getPrompt(&promptBuffer[0]);
    user(&promptBuffer[0]);
    user(if pFlag* then "true" else "false" fi);
    userNL();
    if not ES*.es_bool1 then
	while
	    uPrompt(&promptBuffer[0]);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		false
	    else
		p := skipBlanks();
		skipWord()* := '\e';
		q := p;
		while q* ~= '\e' do
		    if q* >= 'A' and q* <= 'Z' then
			q* := q* - 'A' + 'a';
		    fi;
		    q := q + sizeof(char);
		od;
		if CharsEqual(p, "true") or CharsEqual(p, "yes") or
		    CharsEqual(p, "ok") or CharsEqual(p, "y")
		then
		    pFlag* := true;
		    false
		elif CharsEqual(p, "false") or CharsEqual(p, "no") or
		    CharsEqual(p, "n")
		then
		    pFlag* := false;
		    false
		else
		    err("unknown boolean value");
		    true
		fi
	    fi
	do
	od;
    fi;
corp;

/*
 * editCountry - part of cmd_edit
 */

proc editCountry(uint who)void:
    [30] char buf;
    Country_t c;
    register uint i;

    server(rt_readCountry, who);
    c := ES*.es_request.rq_u.ru_country;
    user3("Name: ", &c.c_name[0], "\n");
    uPrompt("Name: ");
    if ES*.es_readUser() and ES*.es_textInPos* ~= '\e' then
	ES*.es_textIn[NAME_LEN - 1] := '\e';
	CharsCopy(&c.c_name[0], &ES*.es_textIn[0]);
    fi;
    c.c_status := repNum(c.c_status - cs_deity, 0, 5, "Status") + cs_deity;
    c.c_sectorCount := repNum(c.c_sectorCount, 0, 0xffff, "Sector count");
    c.c_techLevel := repNum(c.c_techLevel, 0, 0xffff, "Technology level");
    c.c_resLevel := repNum(c.c_resLevel, 0, 0xffff, "Research level");
    c.c_money := repNum(c.c_money, -0x80000000, 0x7fffffff, "Money");
    c.c_btu := repNum(c.c_btu, 0, ES*.es_world.w_maxBTUs, "BTU's");
    c.c_timeLeft :=
	repNum(c.c_timeLeft, 0, ES*.es_world.w_maxConnect,
	       "Remaining play time");
    c.c_centerRow :=
	repNum(c.c_centerRow, 0, ES*.es_world.w_rows - 1, "center row");
    c.c_centerCol :=
	repNum(c.c_centerCol, 0, ES*.es_world.w_columns - 1, "center column");
    user("Password: *******\n");
    uPrompt("Password: ");
    if ES*.es_readUser() and ES*.es_textInPos* ~= '\e' then
	ES*.es_textIn[PASSWORD_LEN - 1] := '\e';
	CharsCopy(&c.c_password[0], &ES*.es_textIn[0]);
    fi;
    if c.c_loggedOn then
	if ask("Marked as logged on. Mark as not logged on? ") then
	    c.c_loggedOn := false;
	fi;
    else
	if ask("Marked as not logged on. Mark as logged on? ") then
	    c.c_loggedOn := true;
	fi;
    fi;
    if ask("Edit fleets? ") then
	for i from 0 upto 26 + 26 - 1 do
	    user("Fleet ");
	    userC(if i < 26 then i + 'a' else i - 26 + 'A' fi);
	    getPrompt(&buf[0]);
	    c.c_fleets[i] := repNum(c.c_fleets[i], 0, 0xffff, &buf[0]);
	od;
    fi;
    server(rt_lockCountry, who);
    ES*.es_request.rq_u.ru_country := c;
    server(rt_unlockCountry, who);
corp;

/*
 * editSector - part of cmd_edit
 */

proc editSector(int r, c)void:
    Sector_t s;
    ItemType_t it;
    uint country;

    server(rt_readSector, mapSector(r, c));
    s := ES*.es_request.rq_u.ru_sector;
    userS("Sector ", r, c, " - ");
    userC(ES*.es_sectorChar[s.s_type]);
    user(", lastUpdate = ");
    uTime(s.s_lastUpdate);
    userNL();
    server(rt_readCountry, s.s_owner);
    user3("Owner: ", &ES*.es_request.rq_u.ru_country.c_name[0], "\n");
    if reqCountry(&country, "Owner: ", true) then
	s.s_owner := country;
    fi;
    s.s_iron := repNum(s.s_iron, 0, 255, "Mineral sample");
    s.s_gold := repNum(s.s_gold, 0, 255,"Gold sample");
    s.s_checkPoint := repNum(s.s_checkPoint, -128, 127, "Checkpoint code");
    s.s_shipCount := repNum(s.s_shipCount, 0, 0xffff, "Ship count");
    s.s_production := repNum(s.s_production, 0, 255, "Production units");
    s.s_mobility := repNum(s.s_mobility, 0, 255, "Mobility ");
    s.s_efficiency := repNum(s.s_efficiency, 0, 100, "Efficiency");
    s.s_plagueStage := repNum(s.s_plagueStage, 0, 4, "Plague stage");
    s.s_plagueTime := repNum(s.s_plagueTime, 0, 127, "Plague time");
    s.s_price := repNum(s.s_price, 0, 255, "Contract price");
    for it from it_first upto it_last do
	writeQuan(&s, it, repNum(readQuan(&s, it), 0, 1270, getItemName(it)));
    od;
    if not ES*.es_bool1 then
	server(rt_lockSector, mapSector(r, c));
	ES*.es_request.rq_u.ru_sector := s;
	server(rt_unlockSector, mapSector(r, c));
    fi;
corp;

/*
 * editShip - part of cmd_edit
 */

proc editShip(uint shipNumber)void:
    Ship_t ship;
    uint country;

    server(rt_readShip, shipNumber);
    ship := ES*.es_request.rq_u.ru_ship;
    userN3("Ship \#", shipNumber, " (");
    user(getShipName(ship.sh_type));
    user(" in fleet ");
    userC(ship.sh_fleet);
    user("): lastUpdate = ");
    uTime(ship.sh_lastUpdate);
    userNL();
    server(rt_readCountry, ship.sh_owner);
    user3("Owner: ", &ES*.es_request.rq_u.ru_country.c_name[0], "\n");
    if reqCountry(&country, "Owner: ", true) then
	ship.sh_owner := country;
    fi;
    ship.sh_price := repNum(ship.sh_price, 0, 127, "Price");
    ship.sh_efficiency := repNum(ship.sh_efficiency, 0, 100, "Efficiency");
    ship.sh_mobility := repNum(ship.sh_mobility, -128, 127, "Mobility");
    ship.sh_row :=
	repNum(ship.sh_row, 0, ES*.es_world.w_rows - 1, "Current row");
    ship.sh_col :=
	repNum(ship.sh_col, 0, ES*.es_world.w_columns - 1, "Current col");
    ship.sh_techLevel := repNum(ship.sh_techLevel, 0, 9999, "Tech level");
    ship.sh_crew := repNum(ship.sh_crew, 0, 127, "Crew");
    ship.sh_shells := repNum(ship.sh_shells, 0, 127, "Shells");
    ship.sh_guns := repNum(ship.sh_guns, 0, 127, "Guns");
    ship.sh_planes := repNum(ship.sh_planes, 0, 127, "Planes");
    ship.sh_ore := repNum(ship.sh_ore, 0, 127, "Ore");
    ship.sh_bars := repNum(ship.sh_bars, 0, 127, "Bars");
    if not ES*.es_bool1 then
	server(rt_lockShip, shipNumber);
	ES*.es_request.rq_u.ru_ship := ship;
	server(rt_unlockShip, shipNumber);
    fi;
corp;

/*
 * putWorld - update the master copy of the world.
 */

proc putWorld()void:

    if not ES*.es_bool1 then
	server(rt_lockWorld, 0);
	ES*.es_request.rq_u.ru_world := ES*.es_world;
	server(rt_unlockWorld, 0);
    fi;
corp;

/*
 * editWorld - part of cmd_edit.
 */

proc editWorld()void:

    ES*.es_world.w_maxCountries :=
	repNum(ES*.es_world.w_maxCountries, 2, COUNTRY_MAX,
	       "Maximum \# users");
    ES*.es_world.w_currCountries :=
	repNum(ES*.es_world.w_currCountries, 0, ES*.es_world.w_maxCountries,
	       "Current \# users");
    ES*.es_world.w_maxConnect := repNum(ES*.es_world.w_maxConnect, 1, 60 * 24,
		"Maximum connect time in minutes");
    ES*.es_world.w_maxBTUs := repNum(ES*.es_world.w_maxBTUs, 10, 999,
		"Maximum BTUs held by one country");
    user3("Country creation password: ", &ES*.es_world.w_password[0], "\n");
    uPrompt("Country creation password: ");
    if ES*.es_readUser() and ES*.es_textInPos* ~= '\e' then
	ES*.es_textIn[PASSWORD_LEN - 1] := '\e';
	CharsCopy(&ES*.es_world.w_password[0], &ES*.es_textIn[0]);
    fi;
    ES*.es_world.w_loanNext :=
	repNum(ES*.es_world.w_loanNext, 0, 0xffff, "Next loan");
    ES*.es_world.w_treatyNext :=
	repNum(ES*.es_world.w_treatyNext, 0, 0xffff,"Next treaty");
    ES*.es_world.w_offerNext :=
	repNum(ES*.es_world.w_offerNext, 0, 0xffff, "Next offer");
    ES*.es_world.w_shipNext :=
	repNum(ES*.es_world.w_shipNext, 0, 0xffff, "Next ship");
    ES*.es_world.w_fleetNext := 
	repNum(ES*.es_world.w_fleetNext, 0, 0xffff, "Next fleet");
    putWorld();
corp;

/*
 * editWeather - part of cmd_edit.
 */

proc editWeather()void:
    register *Weather_t wea;

    wea := &ES*.es_world.w_weather;
    wea*.we_hiRowInc := repNum(wea*.we_hiRowInc, -4, +4, "hiRowInc");
    wea*.we_hiColInc := repNum(wea*.we_hiColInc, -4, +4, "hiColInc");
    wea*.we_loRowInc := repNum(wea*.we_loRowInc, -4, +4, "loRowInc");
    wea*.we_loColInc := repNum(wea*.we_loColInc, -4, +4, "loColInc");
    wea*.we_hiRow :=
	repNum(wea*.we_hiRow, 0, ES*.es_world.w_rows * 4 - 1, "hiRow");
    wea*.we_hiCol :=
	repNum(wea*.we_hiCol, 0, ES*.es_world.w_columns * 4 - 1, "hiCol");
    wea*.we_loRow :=
	repNum(wea*.we_loRow, 0, ES*.es_world.w_rows * 4 - 1, "loRow");
    wea*.we_loCol :=
	repNum(wea*.we_loCol, 0, ES*.es_world.w_columns * 4 - 1, "loCol");
    wea*.we_hiMin := repNum(wea*.we_hiMin, 0, 20, "hiMin");
    wea*.we_hiMax := repNum(wea*.we_hiMax, 0, 20, "hiMax");
    wea*.we_loMin := repNum(wea*.we_loMin, -20, 0, "loMin");
    wea*.we_loMax := repNum(wea*.we_loMax, -20, 0, "loMax");
    wea*.we_hiPressure := repNum(wea*.we_hiPressure, wea*.we_hiMin,
	    wea*.we_hiMax, "hiPressure");
    wea*.we_loPressure := repNum(wea*.we_loPressure, wea*.we_loMin,
	    wea*.we_loMax, "loPressure");
    putWorld();
corp;

/*
 * editProduction - part of cmd_edit.
 */

proc editProduction()void:

    ES*.es_world.w_resCost :=
	repNum(ES*.es_world.w_resCost, 0, 127, "research cost");
    ES*.es_world.w_techCost :=
	repNum(ES*.es_world.w_techCost, 0, 127, "technology cost");
    ES*.es_world.w_gunCost :=
	repNum(ES*.es_world.w_gunCost, 0, 127, "gun cost");
    ES*.es_world.w_shellCost :=
	repNum(ES*.es_world.w_shellCost, 0, 127, "shell cost");
    ES*.es_world.w_planeCost :=
	repNum(ES*.es_world.w_planeCost, 0, 127, "plane cost");
    ES*.es_world.w_barCost :=
	repNum(ES*.es_world.w_barCost, 0, 127, "bar cost");
    putWorld();
corp;

/*
 * editMobilities - part of cmd_edit.
 */

proc editMobilities()void:
    register uint i, j;
    [100] char promptBuffer;

    repMob(&ES*.es_world.w_mountMob, "mountMob");
    repMob(&ES*.es_world.w_wildMob, "wildMob");
    repMob(&ES*.es_world.w_defMob, "defMob");
    repMob(&ES*.es_world.w_civMob, "civMob");
    repMob(&ES*.es_world.w_milMob, "milMob");
    repMob(&ES*.es_world.w_shellMob, "shellMob");
    repMob(&ES*.es_world.w_gunMob, "gunMob");
    repMob(&ES*.es_world.w_planeMob, "planeMob");
    repMob(&ES*.es_world.w_oreMob, "oreMob");
    repMob(&ES*.es_world.w_barMob, "barMob");
    for i from 0 upto 3 do
	for j from 0 upto 3 do
	    user("Cost of attack from ");
	    user3(
		case i
		incase 0:
		    "highway"
		incase 1:
		    "regular"
		incase 2:
		    "wilderness"
		incase 3:
		    "mountain"
		esac,
		" to ",
		case j
		incase 0:
		    "highway"
		incase 1:
		    "regular"
		incase 2:
		    "wilderness"
		incase 3:
		    "mountain"
		esac);
	    getPrompt(&promptBuffer[0]);
	    ES*.es_world.w_attackMobilityCost[i, j] :=
		repNum(ES*.es_world.w_attackMobilityCost[i, j], 0, 0xffff,
		       &promptBuffer[0]);
	od;
    od;
    putWorld();
corp;

/*
 * editPlague - part of cmd_edit.
 */

proc editPlague()void:

    ES*.es_world.w_plagueKiller := repNum(ES*.es_world.w_plagueKiller,
	    0, 2270, "plagueKiller");
    repScale(&ES*.es_world.w_plagueBooster, "plagueBooster");
    repRand(&ES*.es_world.w_plagueOneBase,
	    &ES*.es_world.w_plagueOneRand, "plague stage one");
    repRand(&ES*.es_world.w_plagueTwoBase,
	    &ES*.es_world.w_plagueTwoRand, "plague stage two");
    repRand(&ES*.es_world.w_plagueThreeBase, &ES*.es_world.w_plagueThreeRand,
	    "plague stage three");
    putWorld();
corp;

/*
 * editCosts - edit various costs. (part of cmd_edit)
 */

proc editCosts()void:

    ES*.es_world.w_efficCost :=
	repNum(ES*.es_world.w_efficCost, 0, 1000, "efficCost");
    ES*.es_world.w_milSuppliesCost := repNum(ES*.es_world.w_milSuppliesCost,
	    0, 800, "milSuppliesCost");
    ES*.es_world.w_utilityRate :=
	repNum(ES*.es_world.w_utilityRate, 0, 100, "utilityRate");
    ES*.es_world.w_interestRate :=
	    repNum(ES*.es_world.w_interestRate, 0, 200, "interestRate");
    ES*.es_world.w_bridgeCost :=
	repNum(ES*.es_world.w_bridgeCost, 0, 32767, "bridge cost");
    ES*.es_world.w_shipCostMult :=
	    repNum(ES*.es_world.w_shipCostMult, 0, 100, "shipCostMult");
    ES*.es_world.w_refurbCost :=
	repNum(ES*.es_world.w_refurbCost, 0, 1000, "refurb cost");
    putWorld();
corp;

/*
 * editScales - part of cmd_edit.
 */

proc editScales()void:

    repScale(&ES*.es_world.w_resScale, "resScale");
    repScale(&ES*.es_world.w_techScale, "techScale");
    repScale(&ES*.es_world.w_defenseScale, "defenseScale");
    repScale(&ES*.es_world.w_shellScale, "shellScale");
    repScale(&ES*.es_world.w_airportScale, "airportScale");
    repScale(&ES*.es_world.w_harborScale, "harborScale");
    repScale(&ES*.es_world.w_bridgeScale, "bridgeScale");
    repScale(&ES*.es_world.w_goldScale, "goldScale");
    repScale(&ES*.es_world.w_ironScale, "ironScale");
    repScale(&ES*.es_world.w_shipWorkScale, "shipWorkScale");
    putWorld();
corp;

/*
 * editUpdates - part of cmd_edit.
 */

proc editUpdates()void:

    ES*.es_world.w_secondsPerETU := repNum(ES*.es_world.w_secondsPerETU,
	    1, 60 * 60 * 24, "secondsPerETU");
    repScale(&ES*.es_world.w_efficScale, "efficScale");
    repScale(&ES*.es_world.w_mobilScale, "mobilScale");
    repScale(&ES*.es_world.w_urbanGrowthFactor, "urbanGrowthFactor");
    ES*.es_world.w_bridgeDieFactor := repNum(ES*.es_world.w_bridgeDieFactor,
	    10, 4000, "bridgeDieFactor");
    ES*.es_world.w_highGrowthFactor := repNum(ES*.es_world.w_highGrowthFactor,
	    10, 2000, "highGrowthFactor");
    ES*.es_world.w_lowGrowthFactor := repNum(ES*.es_world.w_lowGrowthFactor,
	    10, 4000, "lowGrowthFactor");
    ES*.es_world.w_BTUDivisor := repNum(ES*.es_world.w_BTUDivisor,
	    500, 0xffff, "BTUDivisor");
    ES*.es_world.w_resDecreaser := repNum(ES*.es_world.w_resDecreaser,
	    480, 0xffff, "resDecreaser");
    ES*.es_world.w_techDecreaser := repNum(ES*.es_world.w_techDecreaser,
	    480, 0xffff, "techDecreaser");
    repRand(&ES*.es_world.w_hurricaneLandBase,
	    &ES*.es_world.w_hurricaneLandRand,
	    "hurricane land");
    repRand(&ES*.es_world.w_hurricaneSeaBase,
	    &ES*.es_world.w_hurricaneSeaRand,
	    "hurricane sea");
    putWorld();
corp;

/*
 * editFighting - part of cmd_edit.
 */

proc editFighting()void:

    ES*.es_world.w_assFortAdv :=
	repNum(ES*.es_world.w_assFortAdv, 1, 10, "assFortAdv");
    ES*.es_world.w_assCapAdv :=
	repNum(ES*.es_world.w_assCapAdv, 1, 10, "assCapAdv");
    ES*.es_world.w_assBankAdv :=
	repNum(ES*.es_world.w_assBankAdv, 1, 10, "assBankAdv");
    ES*.es_world.w_attFortAdv :=
	repNum(ES*.es_world.w_attFortAdv, 1, 10, "attFortAdv");
    ES*.es_world.w_attCapAdv :=
	repNum(ES*.es_world.w_attCapAdv, 1, 10, "attCapAdv");
    ES*.es_world.w_attBankAdv :=
	repNum(ES*.es_world.w_attBankAdv, 1, 10, "attBankAdv");
    ES*.es_world.w_assAdv :=
	repNum(ES*.es_world.w_assAdv, 0, 1000, "assAdv");
    ES*.es_world.w_fortAdv :=
	repNum(ES*.es_world.w_fortAdv, 0, 10, "fortAdv");
    ES*.es_world.w_boardAdv :=
	repNum(ES*.es_world.w_boardAdv, 0, 10000, "boardAdv");
    putWorld();
corp;

/*
 * editSea - part of cmd_edit.
 */

proc editSea()void:

    ES*.es_world.w_torpCost :=
	repNum(ES*.es_world.w_torpCost, 0, 10, "torpCost");
    ES*.es_world.w_torpMobCost :=
	repNum(ES*.es_world.w_torpMobCost, 0, 127, "torpMobCost");
    ES*.es_world.w_torpRange :=
	repNum(ES*.es_world.w_torpRange, 0, 25, "torpRange");
    ES*.es_world.w_torpAcc0 :=
	repNum(ES*.es_world.w_torpAcc0, 0, 100, "torpAcc0");
    ES*.es_world.w_torpAcc1 :=
	repNum(ES*.es_world.w_torpAcc1, 0, 100, "torpAcc1");
    ES*.es_world.w_torpAcc2 :=
	repNum(ES*.es_world.w_torpAcc2, 0, 100, "torpAcc2");
    ES*.es_world.w_torpAcc3 :=
	repNum(ES*.es_world.w_torpAcc3, 0, 100, "torpAcc3");
    repRand(&ES*.es_world.w_torpBase, &ES*.es_world.w_torpRand,
	    "torpedo damage");
    ES*.es_world.w_chargeCost :=
	repNum(ES*.es_world.w_chargeCost, 0, 10, "chargeCost");
    ES*.es_world.w_chargeMobCost :=
	repNum(ES*.es_world.w_chargeMobCost, 0, 127, "chargeMobCost");
    repRand(&ES*.es_world.w_chargeBase, &ES*.es_world.w_chargeRand,
	    "depth charge damage");
    repRand(&ES*.es_world.w_mineBase, &ES*.es_world.w_mineRand,
	    "mine damage");
    putWorld();
corp;

/*
 * editAir - part of cmd_edit.
 */

proc editAir()void:

    ES*.es_world.w_fuelTankSize := repNum(ES*.es_world.w_fuelTankSize,
	    0, 500, "fuelTankSize");
    ES*.es_world.w_fuelRichness := repNum(ES*.es_world.w_fuelRichness,
	    0, 400, "fuelRichness");
    ES*.es_world.w_flakFactor :=
	repNum(ES*.es_world.w_flakFactor, 1, 100, "flakFactor");
    repScale(&ES*.es_world.w_landScale, "landScale");
    repRand(&ES*.es_world.w_bombBase, &ES*.es_world.w_bombRand,
	    "bomb damage");
    repRand(&ES*.es_world.w_planeBase, &ES*.es_world.w_planeRand,
	    "crashing plane damage");
    putWorld();
corp;

/*
 * editMisc - part of cmd_edit.
 */

proc editMisc()void:

    repScale(&ES*.es_world.w_contractScale, "contractScale");
    ES*.es_world.w_deathFactor :=
	repNum(ES*.es_world.w_deathFactor, 0, 500, "deathFactor");
    ES*.es_world.w_gunMax := repNum(ES*.es_world.w_gunMax, 1, 20, "gunMax");
    repScale(&ES*.es_world.w_rangeDivisor, "rangeDivisor");
    repScale(&ES*.es_world.w_gunScale, "gunScale");
    ES*.es_world.w_lookShipFact := repNum(ES*.es_world.w_lookShipFact,
	    10, 0xffff, "lookShipFact");
    repScale(&ES*.es_world.w_collectScale, "collectScale");
    repScale(&ES*.es_world.w_radarFactor, "radarFactor");
    ES*.es_world.w_spyFactor :=
	repNum(ES*.es_world.w_spyFactor, 1, 1000, "spyFactor");
    ES*.es_world.w_shipTechDecreaser :=
	repNum(ES*.es_world.w_shipTechDecreaser, 1, 1000, "shipTechDecreaser");
    putWorld();
corp;

/*
 * repNaval - replace values in a naval array.
 */

proc repNaval(*[range(ShipType_t)] uint pArray; *char what;
	      uint minVal, maxVal)void:
    [100] char promptBuffer;
    register ShipType_t st;

    for st from st_first upto st_last do
	user3(what, " of ", getShipName(st));
	getPrompt(&promptBuffer[0]);
	pArray*[st] := repNum(pArray*[st], minVal, maxVal, &promptBuffer[0]);
    od;
    putWorld();
corp;

/*
 * editNaval - edit ship parameters.
 */

proc editNaval()void:
    [80] char buff;
    uint what;
    register ItemType_t it;

    CharsCopy(&buff[0], 
	      "Edit what (cost/size/lrange/shrange/capacity/speed/damage)? ");
    if ES*.es_bool1 then
	buff[0] := 'I';
	buff[1] := 'n';
	buff[2] := 'f';
	buff[3] := 'o';
    fi;
    if reqChoice(&what,
		 "cost\esize\elrange\eshrange\ecapacity\espeed\edamage\e",
		 &buff[0])
    then
	case what
	incase 0:
	    repNaval(&ES*.es_world.w_shipCost, "cost", 0, 128);
	incase 1:
	    repNaval(&ES*.es_world.w_shipSize, "size", 0, 1000);
	incase 2:
	    repNaval(&ES*.es_world.w_shipRange, "lookout range", 0, 1000);
	incase 3:
	    repNaval(&ES*.es_world.w_shipShRange, "shelling range", 0, 1000);
	incase 4:
	    for it from it_first upto it_last do
		user2(getItemName(it), " capacity");
		getPrompt(&buff[0]);
		repNaval(&ES*.es_world.w_shipCapacity[it], &buff[0], 0, 127);
	    od;
	incase 5:
	    repNaval(&ES*.es_world.w_shipSpeed, "mobility cost", 0, 10000);
	incase 6:
	    repNaval(&ES*.es_world.w_shipDamage, "relative damage", 0, 10);
	esac;
    fi;
corp;

/*
 * editFlags - replace flag values.
 */

proc editFlags()void:

    repBool(&ES*.es_world.w_nonDeityPower, "nonDeityPower");
    repBool(&ES*.es_world.w_sortCountries, "sortCountries");
    putWorld();
corp;

/*
 * editFile - allow a deity to edit one of the special files.
 */

proc editFile()void:
    uint what;

    if reqChoice(&what, "conmess\elogmess\ehangmess\ebulletin\etemp\e",
		 "Edit which file (conmess/logmess/hangmess/bulletin/temp)? ")
    then
	ignore getText(tt_edit, "blah", what);
    fi;
corp;

proc doEdit()void:
    *char prompt;
    uint what, n;
    int r, c;

    if ES*.es_bool1 then
	/* info */
	prompt := "Info what (we/pr/mo/pl/cos/sc/up/fi/sea/ai/mi/na/fl)? ";
    else
	/* edit */
	prompt :=
   "Edit what (cou/sec/sh/wo/we/pr/mo/pl/cos/sc/up/fig/sea/ai/mi/na/fl/fil)? ";
    fi;
    if reqChoice(&what,
		 "country\e"
		 "sector\e"
		 "ship\e"
		 "world\e"
		 "weather\e"
		 "production\e"
		 "mobilities\e"
		 "plague\e"
		 "costs\e"
		 "scales\e"
		 "updates\e"
		 "fighting\e"
		 "sea\e"
		 "air\e"
		 "miscellaneous\e"
		 "naval\e"
		 "flags\e"
		 "file\e",
		 prompt)
    then
	ignore skipBlanks();
	case what
	incase 0:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		if reqCountry(&n, "Edit which country? ", true) then
		    editCountry(n);
		fi;
	    fi;
	incase 1:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		if reqSector(&r, &c, "Edit which sector? ") then
		    editSector(r, c);
		fi;
	    fi;
	incase 2:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		if reqShip(&n, "Edit which ship? ") then
		    editShip(n);
		fi;
	    fi;
	incase 3:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		editWorld();
	    fi;
	incase 4:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		editWeather();
	    fi;
	incase 5:
	    editProduction();
	incase 6:
	    editMobilities();
	incase 7:
	    editPlague();
	incase 8:
	    editCosts();
	incase 9:
	    editScales();
	incase 10:
	    editUpdates();
	incase 11:
	    editFighting();
	incase 12:
	    editSea();
	incase 13:
	    editAir();
	incase 14:
	    editMisc();
	incase 15:
	    editNaval();
	incase 16:
	    editFlags();
	incase 17:
	    if ES*.es_bool1 then
		err("no such info");
	    else
		editFile();
	    fi;
	esac;
    fi;
corp;

proc cmd_edit()void:

    if ES*.es_country.c_status = cs_deity then
	ES*.es_bool1 := false;
	doEdit();
    else
	err("Only a deity can edit things");
    fi;
corp;

proc cmd_info()void:

    if skipBlanks()* = '\e' then
	user("World created ");
	uTime(ES*.es_world.w_buildDate);
	user(".\n");
	userN2("World size: ", ES*.es_world.w_rows);
	userN3(" rows by ", ES*.es_world.w_columns, " columns.\n");
	userN2("There are currently ", ES*.es_world.w_currCountries);
	userN3(" countries out of a maximum of ", ES*.es_world.w_maxCountries,
	       ".\n");
	userN3("Maximum daily connect time is ", ES*.es_world.w_maxConnect,
	       " minutes.\n");
	userN3("An ETU (Empire Time Unit) is ", ES*.es_world.w_secondsPerETU,
	       " seconds.\n");
	userN2("The world has seen ", ES*.es_world.w_loanNext);
	userN2(" loans, ", ES*.es_world.w_offerNext);
	userN2(" offers, ", ES*.es_world.w_shipNext);
	userN3(" ships and ", ES*.es_world.w_fleetNext, " fleets.\n");
    else
	ES*.es_bool1 := true;
	doEdit();
    fi;
corp;
