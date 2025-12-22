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
 * doBuild - part of cmd_build
 */

proc doBuild(register int r, c; register *Sector_t s)void:
    [100] char buf;
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register *Country_t rc @ rs;
    register *World_t rw @ rs;
    register int rSpan, cSpan;
    uint cost, mapped1, mapped2, shipNumber;
    ShipType_t typ;
    char dir;

    mapped1 := mapSector(r, c);
    server(rt_lockSector, mapped1);
    updateSector(r, c);
    rs := &ES*.es_request.rq_u.ru_sector;
    if rs*.s_type = s_bridgeHead then
	server(rt_unlockSector, mapped1);
	ES*.es_bool1 := true;
	if rs*.s_production = 127 and
	    ES*.es_country.c_money >= make(ES*.es_world.w_bridgeCost, int)
	then
	    ES*.es_bool3 := true;
	    userS("Bridge head at ", r, c,
		  "; build span in what direction? (udlr) ");
	    getPrompt(&buf[0]);
	    if reqBridgeDirection(&dir, &buf[0]) then
		rSpan := r;
		cSpan := c;
		case dir
		incase 'u':
		    rSpan := rSpan - 1;
		incase 'd':
		    rSpan := rSpan + 1;
		incase 'l':
		    cSpan := cSpan - 1;
		incase 'r':
		    cSpan := cSpan + 1;
		esac;
		mapped2 := mapSector(rSpan, cSpan);
		server(rt_readSector, mapped2);
		rs := &ES*.es_request.rq_u.ru_sector;
		if rs*.s_type = s_water then
		    server(rt_lockSector, mapped2);
		    rs*.s_type := s_bridgeSpan;
		    rs*.s_owner := ES*.es_countryNumber;
		    rs*.s_efficiency := 100;
		    writeQuan(rs, it_shells, 0);	/* zap any mines */
		    rs*.s_lastUpdate := timeNow();
		    server(rt_unlockSector, mapped2);
		    server(rt_lockSector, mapped1);
		    rs*.s_production := 0;
		    server(rt_unlockSector, mapped1);
		    server(rt_lockCountry, ES*.es_countryNumber);
		    rc*.c_money := rc*.c_money - ES*.es_world.w_bridgeCost;
		    rc*.c_sectorCount := rc*.c_sectorCount + 1;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    ES*.es_country.c_money := rc*.c_money;
		    ES*.es_country.c_sectorCount := rc*.c_sectorCount;
		    ES*.es_uint2 := ES*.es_uint2 + ES*.es_world.w_bridgeCost;
		    userS("Bridge span built over ", rSpan, cSpan, ".\n");
		else
		    err("can only build bridge spans over water");
		fi;
	    fi;
	fi;
    elif rs*.s_type = s_harbour then
	ES*.es_bool2 := true;
	userN(rs*.s_production);
	userS(" production units in harbor at ", r, c, "; kind of ship? ");
	getPrompt(&buf[0]);
	if reqShipType(&typ, &buf[0]) then
	    cost := ES*.es_world.w_shipCost[typ];
	    if cost > rs*.s_production then
		server(rt_unlockSector, mapped1);
		err("insufficient production units");
	    elif make(cost * ES*.es_world.w_shipCostMult, int) >
		ES*.es_country.c_money
	    then
		server(rt_unlockSector, mapped1);
		err("you don't have enough money");
	    else
		rs*.s_production := rs*.s_production - cost;
		rs*.s_shipCount := rs*.s_shipCount + 1;
		server(rt_unlockSector, mapped1);
		cost := cost * ES*.es_world.w_shipCostMult;
		server(rt_lockCountry, ES*.es_countryNumber);
		rc*.c_money := rc*.c_money - cost;
		server(rt_unlockCountry, ES*.es_countryNumber);
		ES*.es_country.c_money := rc*.c_money;
		ES*.es_uint2 := ES*.es_uint2 + cost;
		server(rt_lockWorld, 0);
		shipNumber := rw*.w_shipNext;
		rw*.w_shipNext := shipNumber + 1;
		server(rt_unlockWorld, 0);
		ES*.es_world.w_shipNext := rw*.w_shipNext;
		rsh*.sh_lastUpdate := timeNow();
		rsh*.sh_price := 0;
		rsh*.sh_type := typ;
		rsh*.sh_fleet := '*';
		rsh*.sh_owner := ES*.es_countryNumber;
		rsh*.sh_efficiency := 50;
		rsh*.sh_row := rowToAbs(r);
		rsh*.sh_col := colToAbs(c);
		rsh*.sh_techLevel := ES*.es_country.c_techLevel;
		rsh*.sh_crew := 0;
		rsh*.sh_shells := 0;
		rsh*.sh_guns := 0;
		rsh*.sh_planes := 0;
		rsh*.sh_ore := 0;
		rsh*.sh_bars := 0;
		rsh*.sh_mobility := 0;
		server(rt_createShip, shipNumber);
		user3("Built ", getShipName(typ), " number ");
		userN(shipNumber);
		userS(" at ", r, c, ".\n");
	    fi;
	else
	    server(rt_unlockSector, mapped1);
	fi;
    else
	server(rt_unlockSector, mapped1);
    fi;
    ES*.es_textInPos := &ES*.es_textIn[ES*.es_uint1];
corp;

proc cmd_build()bool:
    SectorScan_t ss;

    if reqSectors(&ss, "Sectors to build in? ") then
	ignore skipBlanks();
	ES*.es_uint1 := (ES*.es_textInPos - &ES*.es_textIn[0]) / sizeof(char);
	ES*.es_bool1 := false;
	ES*.es_bool2 := false;
	ES*.es_bool3 := false;
	ES*.es_uint2 := 0;
	ignore scanSectors(&ss, doBuild);
	if not ES*.es_bool1 and not ES*.es_bool2 then
	    err("can only build at bridge spans or harbors");
	elif ES*.es_bool1 and not ES*.es_bool3 then
	    err("insufficient money/production");
	elif ES*.es_uint2 ~= 0 then
	    userN3("That just cost you $", ES*.es_uint2, "!\n");
	fi;
	true
    else
	false
    fi
corp;

proc cmd_declare()bool:
    uint country, what;

    if reqChoice(&what, "neutrality\ealliance\ewar\e",
		"Enter relationship: ") and
	doSkipBlanks() and
	reqCountry(&country, "Declare with which country? ", false)
    then
	if country = ES*.es_countryNumber then
	    err("your relation to yourself is none of Empire's concern");
	    false
	else
	    if ES*.es_country.c_relations[country] = r_war then
		news(n_disavow_war, ES*.es_countryNumber, country);
	    elif ES*.es_country.c_relations[country] = r_allied then
		news(n_disavow_ally, ES*.es_countryNumber, country);
	    fi;
	    ES*.es_country.c_relations[country] := r_neutral + what;
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_relations[country] :=
		r_neutral + what;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    news(
		case r_neutral + what
		incase r_neutral:
		    n_decl_neut
		incase r_war:
		    n_decl_war
		incase r_allied:
		    n_decl_ally
		esac, ES*.es_countryNumber, country);
	    true
	fi
    else
	false
    fi
corp;

proc cmd_lend()bool:
    register *Loan_t rl;
    uint loanNumber, loanee, amount, rate, duration;

    loanNumber := ES*.es_country.c_money;
    if loanNumber <= 0 then
	err("you have no money to lend");
	true
    elif reqCountry(&loanee, "Country to loan to? ", false) and
	doSkipBlanks() and
	reqPosRange(&amount, loanNumber, "Amount to loan? ") and
	doSkipBlanks() and
	reqPosRange(&rate, 127, "Interest over the duration (max 127%)? ") and
	doSkipBlanks() and
	reqPosRange(&duration, 127, "Duration in \"days\" (max 127)? ")
    then
	if loanee = ES*.es_countryNumber then
	    err("can't lend yourself money");
	    false
	elif amount = 0 or duration = 0 then
	    err("loan aborted");
	    false
	else
	    server(rt_lockWorld, 0);
	    loanNumber := ES*.es_request.rq_u.ru_world.w_loanNext;
	    ES*.es_request.rq_u.ru_world.w_loanNext := loanNumber + 1;
	    server(rt_unlockWorld, 0);
	    ES*.es_world.w_loanNext := ES*.es_request.rq_u.ru_world.w_loanNext;
	    rl := &ES*.es_request.rq_u.ru_loan;
	    rl*.l_lastPay := timeNow();
	    rl*.l_dueDate :=
		rl*.l_lastPay + ES*.es_world.w_secondsPerETU * (2 * 24) *
		    make(duration, ulong);
	    rl*.l_amount := amount;
	    rl*.l_paid := 0;
	    rl*.l_duration := duration;
	    rl*.l_rate := rate;
	    rl*.l_loaner := ES*.es_countryNumber;
	    rl*.l_loanee := loanee;
	    rl*.l_state := l_offered;
	    server(rt_createLoan, loanNumber);
	    user(&ES*.es_country.c_name[0]);
	    userN3(" has offered you loan \#", loanNumber, ".");
	    notify(loanee);
	    userN3("You have offered loan \#", loanNumber, ".\n");
	    true
	fi
    else
	false
    fi
corp;

proc cmd_accept()bool:
    Loan_t save;
    register *Loan_t rl;
    register *Country_t rc @ rl;
    uint loanNumber, choice, loaner;

    if ES*.es_world.w_loanNext = 0 then
	err("there are no loans yet");
	false
    elif reqPosRange(&loanNumber, ES*.es_world.w_loanNext - 1,
		     "Loan to accept? ")
    then
	server(rt_readLoan, loanNumber);
	rl := &ES*.es_request.rq_u.ru_loan;
	if rl*.l_loanee ~= ES*.es_countryNumber then
	    err("that loan is not offered to you");
	    false
	elif rl*.l_state ~= l_offered then
	    err("that loan is not an outstanding loan offer");
	    false
	else
	    save := rl*;
	    server(rt_readCountry, save.l_loaner);
	    userN3("Loan \#", loanNumber, " offered by ");
	    user2(&rc*.c_name[0], " on ");
	    uTime(save.l_lastPay);
	    userNL();
	    userN2("Principal $", save.l_amount);
	    userN2(" at ", save.l_rate);
	    userN3("% interest lasting ", save.l_duration, " \"days\"\n");
	    user("This loan offer will be retracted if not accepted by ");
	    uTime(save.l_dueDate);
	    userNL();
	    ES*.es_textInPos* := '\e';
	    while not reqChoice(&choice, "accept\edecline\epostpone\e",
				"Accept/decline/postpone this loan? ")
	    do
	    od;
	    case choice
	    incase 0:
		server(rt_lockCountry, save.l_loaner);
		rc*.c_money := rc*.c_money - save.l_amount;
		server(rt_unlockCountry, save.l_loaner);
		server(rt_lockCountry, ES*.es_countryNumber);
		rc*.c_money := rc*.c_money + save.l_amount;
		server(rt_unlockCountry, ES*.es_countryNumber);
		ES*.es_country.c_money := rc*.c_money;
		server(rt_lockLoan, loanNumber);
		rl*.l_paid := 0;
		rl*.l_lastPay := timeNow();
		rl*.l_dueDate := rl*.l_lastPay +
		    ES*.es_world.w_secondsPerETU * (2 * 24) *
			make(rl*.l_duration, ulong);
		rl*.l_state := l_outstanding;
		server(rt_unlockLoan, loanNumber);
		loaner := rl*.l_loaner;
		userN3("Loan \#", loanNumber, " accepted by ");
		user(&ES*.es_country.c_name[0]);
		notify(save.l_loaner);
		news(n_make_loan, loaner, ES*.es_countryNumber);
		userN3("You are now $", save.l_amount, " richer (sort of)\n");
	    incase 1:
		server(rt_lockLoan, loanNumber);
		rl*.l_state := l_declined;
		server(rt_unlockLoan, loanNumber);
		userN3("Loan \#", loanNumber, " declined by ");
		user(&ES*.es_country.c_name[0]);
		notify(save.l_loaner);
		userN3("You declined loan \#", loanNumber, "\n");
	    incase 2:
		userN3("Loan \#", loanNumber, " considered by ");
		user(&ES*.es_country.c_name[0]);
		notify(save.l_loaner);
		user("Okay...\n");
	    esac;
	    true
	fi
    else
	false
    fi
corp;

/*
 * loanValue - calculate the current value of a loan.
 */

proc loanValue(register *Loan_t rl)ulong:
    register ulong owed, due, now;
    ulong lastPay, rate, regularTime, extraTime;

    now := ES*.es_request.rq_time / ES*.es_world.w_secondsPerETU;
    due := rl*.l_dueDate / ES*.es_world.w_secondsPerETU;
    lastPay := rl*.l_lastPay / ES*.es_world.w_secondsPerETU;
    /* now, due and lastPay are now ETU values */
    rate := make(rl*.l_rate, ulong) * 1000;
    rate := rate / (make(rl*.l_duration, ulong) * (24 * 2));
    /* rate is now 1000 * interest per ETU */
    if now <= due then
	regularTime := now - lastPay;
	extraTime := 0;
    else
	if lastPay <= due then
	    regularTime := due - lastPay;
	    extraTime := now - due;
	else
	    regularTime := 0;
	    extraTime := now - lastPay;
	fi;
    fi;
    owed := ((regularTime + extraTime * 2) * rate / 100 + 1000) *
	    rl*.l_amount / 1000;
    if owed > 65535 then
	owed := 65535;
    fi;
    owed
corp;

proc cmd_repay()bool:
    Loan_t save;
    register *Loan_t rl;
    register *Country_t rc @ rl;
    uint loanNumber, amount;
    register ulong owed;

    if ES*.es_world.w_loanNext = 0 then
	err("there are no loans yet");
	false
    elif reqPosRange(&loanNumber, ES*.es_world.w_loanNext - 1,
		     "Repay which loan? ")
    then
	server(rt_readLoan, loanNumber);
	rl := &ES*.es_request.rq_u.ru_loan;
	if rl*.l_state ~= l_outstanding or rl*.l_loanee ~= ES*.es_countryNumber
	then
	    err("you don't owe any money on that loan");
	    false
	else
	    owed := loanValue(rl);
	    userN3("You owe $", owed, " on that loan.\n");
	    ignore skipBlanks();
	    if reqPosRange(&amount, owed, "Pay how much? ") then
		if make(amount, long) > ES*.es_country.c_money then
		    err("you don't have that much money");
		else
		    save := rl*;
		    server(rt_lockCountry, ES*.es_countryNumber);
		    rc*.c_money := rc*.c_money - amount;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    ES*.es_country.c_money := rc*.c_money;
		    server(rt_lockCountry, save.l_loaner);
		    rc*.c_money := rc*.c_money + amount;
		    server(rt_unlockCountry, save.l_loaner);
		    server(rt_lockLoan, loanNumber);
		    rl*.l_lastPay := timeNow();
		    if amount = owed then
			rl*.l_state := l_paidUp;
			server(rt_unlockLoan, loanNumber);
			user(&ES*.es_country.c_name[0]);
			userN2(" paid off loan \#", loanNumber);
			userN2(" with $", amount);
			notify(save.l_loaner);
			news(n_repay_loan, ES*.es_countryNumber,save.l_loaner);
			user("Congratulations, you've paid off he loan!\n");
		    else
			owed := owed - amount;
			if owed > 65535 then
			    owed := 65535;
			fi;
			rl*.l_amount := owed;
			if amount > 65535 - rl*.l_paid then
			    amount := 65535 - rl*.l_paid;
			fi;
			rl*.l_paid := rl*.l_paid + amount;
			server(rt_unlockLoan, loanNumber);
			user(&ES*.es_country.c_name[0]);
			userN2(" paid $", amount);
			userN2(" on loan \#", loanNumber);
			notify(save.l_loaner);
		    fi;
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
 * dumpLoan - part of cmd_ledger. Return 'true' if loan involves this user.
 */

proc dumpLoan(uint loanNumber)bool:
    Loan_t save;
    register *Loan_t rl;
    register ulong due, rate, lastPay, now;
    ulong regularTime, extraTime, owed;

    server(rt_readLoan, loanNumber);
    rl := &ES*.es_request.rq_u.ru_loan;
    if (rl*.l_loaner = ES*.es_countryNumber or
	    rl*.l_loanee = ES*.es_countryNumber) and
	rl*.l_state ~= l_declined and rl*.l_state ~= l_paidUp
    then
	userNL();
	save := rl*;
	server(rt_readCountry, save.l_loaner);
	userN3("Loan \#", loanNumber, " from ");
	user2(&ES*.es_request.rq_u.ru_country.c_name[0], " to ");
	server(rt_readCountry, save.l_loanee);
	user2(&ES*.es_request.rq_u.ru_country.c_name[0], "\n");
	if save.l_state = l_offered then
	    userN2("(proposed) principal = $", save.l_amount);
	    userN2(" interest rate = ", save.l_rate);
	    userN3("% duration (\"days\") = ", save.l_duration, "\n");
	    if save.l_dueDate < timeNow() then
		user("This offer has expired\n");
		server(rt_lockLoan, loanNumber);
		rl*.l_state := l_paidUp;
		server(rt_unlockLoan, loanNumber);
	    else
		user("Loan must be accepted by ");
		uTime(save.l_dueDate);
		userNL();
	    fi;
	else
	    /* see loanValue for comments on these. We don't use loanValue
	       here since we need rate and lastPay below */
	    now := ES*.es_request.rq_time / ES*.es_world.w_secondsPerETU;
	    due := save.l_dueDate / ES*.es_world.w_secondsPerETU;
	    lastPay := save.l_lastPay / ES*.es_world.w_secondsPerETU;
	    rate := make(save.l_rate, ulong) * 1000;
	    rate := rate / (make(save.l_duration, ulong) * (24 * 2));
	    if now <= due then
		regularTime := now - lastPay;
		extraTime := 0;
	    else
		if lastPay <= due then
		    regularTime := due - lastPay;
		    extraTime := now - due;
		else
		    regularTime := 0;
		    extraTime := now - lastPay;
		fi;
	    fi;
	    owed := ((regularTime + extraTime * 2) * rate / 100 + 1000) *
		    save.l_amount / 1000;
	    userN3("Amount paid to date: $", save.l_paid, "\n");
	    userN3("Amount due if paid now: $", owed, "\n");
	    if extraTime = 0 then
		userN3("(if paid on due date): ",
			((due - lastPay) * rate / 100 + 1000) *
			    save.l_amount / 1000, "\n");
		user("Due date is: ");
		uTime(save.l_dueDate);
		userNL();
	    else
		user(" ** In Arrears **\n");
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc cmd_ledger()void:
    uint loanNumber;
    bool gotOne;

    if ES*.es_world.w_loanNext = 0 then
	err("there are no loans yet");
    elif ES*.es_textInPos* = '\e' then
	user3("        ... ", &ES*.es_country.c_name[0], " Ledger ...\n");
	gotOne := false;
	for loanNumber from 0 upto ES*.es_world.w_loanNext - 1 do
	    if dumpLoan(loanNumber) then
		gotOne := true;
	    fi;
	od;
	if not gotOne then
	    user("The slate is clean (i.e. no entries in ledger)\n");
	fi;
    elif getPosRange(&loanNumber, ES*.es_world.w_loanNext - 1) then
	if not dumpLoan(loanNumber) then
	    userN3("There is no entry in the ledger for loan \#", loanNumber,
		   "\n");
	fi;
    fi;
corp;

proc cmd_collect()bool:
    register *Loan_t rl;
    register *Sector_t rs @ rl;
    register *Country_t rc @ rl;
    register uint loanee;
    uint loanNumber, mapped;
    int r, c;
    register ulong val, owed;
    ulong now, due, lastPay, rate, regularTime, extraTime;
    register ItemType_t it;
    bool killed;

    if ES*.es_world.w_loanNext = 0 then
	err("there are no loans yet");
	false
    elif reqPosRange(&loanNumber, ES*.es_world.w_loanNext - 1,
		     "Loan to collect on? ")
    then
	server(rt_readLoan, loanNumber);
	rl := &ES*.es_request.rq_u.ru_loan;
	if rl*.l_state ~= l_outstanding or rl*.l_loaner ~= ES*.es_countryNumber
	then
	    user("You are not owed anything on that loan\n");
	    false
	elif rl*.l_dueDate >= timeNow() then
	    userN2("There has been no default on loan \#", loanNumber);
	    userNL();
	    false
	else
	    loanee := rl*.l_loanee;
	    owed := loanValue(rl);
	    userN3("You are owed $", owed, " on that loan\n");
	    ignore skipBlanks();
	    if reqSector(&r, &c, "Confiscate which sector? ") then
		if near(r, c, loanee, nil) then
		    mapped := mapSector(r, c);
		    server(rt_readSector, mapped);
		    if rs*.s_owner ~= loanee then
			server(rt_readCountry, loanee);
			user(&rc*.c_name[0]);
			userS(" doesn't own sector ", r, c, "\n");
		    else
			server(rt_lockSector, mapped);
			updateSector(r, c);
			val := (make(rs*.s_efficiency, uint) + 100) *
			    case rs*.s_type
			    incase s_sanctuary:
			    incase s_capital:
				127
			    incase s_ironMine:
			    incase s_goldMine:
			    incase s_harbour:
			    incase s_fortress:
			    incase s_radar:
				20
			    incase s_bridgeHead:
			    incase s_bridgeSpan:
				15
			    incase s_wilderness:
				5
			    default:
				10
			    esac;
			val := val + rs*.s_iron * 10;
			val := val + rs*.s_gold * 10;
			val := val + rs*.s_production * 10;
			val := val + rs*.s_mobility * 10;
			for it from it_first upto it_last do
			    val := val +
				readQuan(rs, it) * 10 * getItemCost(it);
			od;
			val := val * ES*.es_world.w_collectScale / 100;
			userN3("That sector (and its contents) is valued at $",
			       val, "\n");
			if val <= owed then
			    rs*.s_owner := ES*.es_countryNumber;
			    rs*.s_defender := NO_DEFEND;
			    rs*.s_checkPoint := 0;
			    server(rt_unlockSector, mapped);
			    server(rt_lockCountry, ES*.es_countryNumber);
			    rc*.c_sectorCount := rc*.c_sectorCount + 1;
			    server(rt_unlockCountry, ES*.es_countryNumber);
			    ES*.es_country.c_sectorCount := rc*.c_sectorCount;
			    server(rt_lockCountry, loanee);
			    rc*.c_sectorCount := rc*.c_sectorCount - 1;
			    killed := false;
			    if rc*.c_sectorCount = 0 then
				killed := true;
				rc*.c_status := cs_dead;
			    fi;
			    server(rt_unlockCountry, loanee);
			    news(n_sieze_sector, ES*.es_countryNumber, loanee);
			    if killed then
				user("You have just confiscated "
				     "that country's last sector!!\n");
				news(n_destroyed, ES*.es_countryNumber,loanee);
			    fi;
			    user(&ES*.es_country.c_name[0]);
			    userTarget(loanee, " siezed ", r, c, "");
			    if val * 105 / 100 >= owed or val + 100 >= owed
			    then
				news(n_repay_loan,ES*.es_countryNumber,loanee);
				userN2(" to satisfy loan \#", loanNumber);
				notify(loanee);
				user("That loan is now considered repaid\n");
				server(rt_lockLoan, loanNumber);
				rl*.l_state := l_paidUp;
			    else
				userN2(" in partial payment of loan \#",
				       loanNumber);
				notify(loanee);
				owed := owed - val;
				userN2("You are still owed $", owed);
				userN3(" on loan \#", loanNumber, "\n");
				server(rt_lockLoan, loanNumber);
				rl*.l_amount :=
				    if owed > 65535 then 65535 else owed fi;
				val := val + rl*.l_paid;
				rl*.l_paid :=
				    if val > 65535 then 65535 else val fi;
				rl*.l_lastPay :=
				    now * ES*.es_world.w_secondsPerETU;
			    fi;
			    server(rt_unlockLoan, loanNumber);
			else
			    server(rt_unlockSector, mapped);
			fi;
		    fi;
		else
		    userS("You are not adjacent to ", r, c, "\n");
		fi;
	    fi;
	    true
	fi
    else
	false
    fi
corp;
