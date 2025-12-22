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

proc cmd_change()void:
    register *char n;
    register uint i;
    ulong now, lastOn;
    uint what;
    [25] char buf;
    bool duplicate;

    if reqChoice(&what, "name\epassword\ecountry\enotify\e",
		 "Change what (name/password/country/notify): ")
    then
	if what = 3 then
	    ignore skipBlanks();
	    if reqChoice(&what, "telegram\emessage\eboth\e",
			 "Change to which (telegram/message/both): ")
	    then
		server(rt_lockCountry, ES*.es_countryNumber);
		ES*.es_request.rq_u.ru_country.c_notify := what + nt_telegram;
		server(rt_unlockCountry, ES*.es_countryNumber);
		ES*.es_country.c_notify :=
		    ES*.es_request.rq_u.ru_country.c_notify;
	    fi;
	elif what = 2 then
	    if reqCountry(&what, "Enter country to change to: ", true) then
		i := what;
		server(rt_readCountry, i);
		if ES*.es_request.rq_u.ru_country.c_loggedOn then
		    n := &ES*.es_request.rq_u.ru_country.c_name[0];
		    user3("Country ", n, " is already logged on.\n");
		    log3("Country ", n, " is already logged on.");
		elif getPassword("Enter password: ",
				 &ES*.es_request.rq_u.ru_country.c_password[0])
		then
		    what := ES*.es_countryNumber;
		    ES*.es_countryNumber := i;
		    ES*.es_country := ES*.es_request.rq_u.ru_country;
		    lastOn := ES*.es_country.c_lastOn;
		    n := &ES*.es_country.c_name[0];
		    if resetTimer() then
			user3("*** ", n, " is out of time for today\n");
			ES*.es_countryNumber := what;
			server(rt_readCountry, what);
			ES*.es_country := ES*.es_request.rq_u.ru_country;
		    else
			server(rt_lockCountry, what);
			now := ES*.es_request.rq_time;
			ES*.es_request.rq_u.ru_country.c_lastOn := now;
			ES*.es_request.rq_u.ru_country.c_loggedOn := false;
			server(rt_unlockCountry, what);
			n := &ES*.es_request.rq_u.ru_country.c_name[0];
			user2(n, " off at ");
			uTime(now);
			userNL();
			log3("Country ", n, " logged off.");
			server(rt_lockCountry, ES*.es_countryNumber);
			ES*.es_request.rq_u.ru_country.c_lastOn := now;
			ES*.es_request.rq_u.ru_country.c_loggedOn := true;
			server(rt_unlockCountry, ES*.es_countryNumber);
			ES*.es_country := ES*.es_request.rq_u.ru_country;
			user2(n, " on at ");
			uTime(now);
			user(" last on at ");
			uTime(lastOn);
			userNL();
			log3("Country ", n, " logged on.");
			server(rt_setCountry, ES*.es_countryNumber);
			telegramCheck();
		    fi;
		else
		    user("country not changed\n");
		fi;
	    fi;
	else
	    if getPassword("Enter your current password: ",
			   &ES*.es_country.c_password[0]) then
		if what = 0 then
		    uPrompt("Enter new country name: ");
		    if ES*.es_readUser() and ES*.es_textInPos* ~= '\e' then
			duplicate := false;
			for i from ES*.es_world.w_currCountries - 1 downto 0 do
			    server(rt_readCountry, i);
			    if i ~= ES*.es_countryNumber and
				CharsEqual(
				    &ES*.es_request.rq_u.ru_country.c_name[0],
				    &ES*.es_textIn[0])
			    then
				duplicate := true;
			    fi;
			od;
			if duplicate then
			    err("that name is already in use");
			else
			    server(rt_lockCountry, ES*.es_countryNumber);
			    CharsCopy(
				&ES*.es_request.rq_u.ru_country.c_name[0],
				&ES*.es_textIn[0]);
			    server(rt_unlockCountry, ES*.es_countryNumber);
			    ES*.es_country := ES*.es_request.rq_u.ru_country;
			    news(n_name_change, ES*.es_countryNumber, 0);
			fi;
		    fi;
		else
		    ignore newCountryPassword();
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_password :=
			ES*.es_country.c_password;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		fi;
	    else
		user("password not changed.\n");
	    fi;
	fi;
    fi;
corp;

proc cmd_translate()void:
    uint cRow, cCol, aRow, aCol;
    int r, c;
    uint country;

    if ES*.es_country.c_status = cs_deity then
	if reqCountry(&country, "Country to translate sector from? ", true) and
	    doSkipBlanks() and
	    reqSector(&r, &c, "Sector in that country to translate? ")
	then
	    cRow := ES*.es_country.c_centerRow;
	    cCol := ES*.es_country.c_centerCol;
	    server(rt_readCountry, country);
	    ES*.es_country.c_centerRow :=
		ES*.es_request.rq_u.ru_country.c_centerRow;
	    ES*.es_country.c_centerCol :=
		ES*.es_request.rq_u.ru_country.c_centerCol;
	    aRow := rowToAbs(r);
	    aCol := colToAbs(c);
	    ES*.es_country.c_centerRow := cRow;
	    ES*.es_country.c_centerCol := cCol;
	    user(&ES*.es_request.rq_u.ru_country.c_name[0]);
	    userS(" sector ", r, c, "");
	    userS(" is at absolute ", rowToMe(aRow), colToMe(aCol), "\n");
	fi;
    else
	err("only a deity can use this command");
    fi;
corp;

proc cmd_untranslate()void:
    uint cRow, cCol;
    int r, c;
    uint country;

    if ES*.es_country.c_status = cs_deity then
	if reqCountry(&country, "Country to translate sector to? ", true) and
	    doSkipBlanks() and reqSector(&r, &c, "Sector to translate? ")
	then
	    userS("Absolute sector ", r, c, " is at ");
	    userTarget(country, "", r, c, " in country ");
	    user(&ES*.es_request.rq_u.ru_country.c_name[0]);
	    userNL();
	fi;
    else
	err("only a deity can use this command");
    fi;
corp;

/*
 * printCountry - part of cmd_country
 */

proc printCountry(uint i)void:
    register *Country_t c;

    server(rt_readCountry, i);
    c := &ES*.es_request.rq_u.ru_country;
    if c*.c_status ~= cs_idle or ES*.es_country.c_status = cs_deity then
	if c*.c_loggedOn then
	    user("   currently logged on  ");
	else
	    uTime(c*.c_lastOn);
	fi;
	user(" [");
	userF(c*.c_timeLeft, 4);
	user("] [");
	userF(c*.c_btu, 3);
	user("]   ");
	user(
	    case c*.c_status
	    incase cs_deity:
		"DEITY    "
	    incase cs_active:
		"Active   "
	    incase cs_dead:
		"Destroyed"
	    incase cs_quit:
		"Resigned "
	    incase cs_idle:
		"Idle     "
	    incase cs_visitor:
		"Visitor  "
	    default:
		 "UNKNOWN "
	    esac);
	user3(" ", &c*.c_name[0], "\n");
    fi;
corp;

/*
 * strLess - compare strings, ignoring case. Return 'true' if the first is
 *	less than the second.
 */

proc strLess(register *char a, b)bool:
    register char a1, b1;

    while
	a1 := a*;
	if a1 >= 'a' and a1 <= 'z' then
	    a1 := a1 - 'a' + 'A';
	fi;
	b1 := b*;
	if b1 >= 'a' and b1 <= 'z' then
	    b1 := b1 - 'a' + 'A';
	fi;
	a* ~= '\e' and a1 = b1
    do
	a := a + sizeof(char);
	b := b + sizeof(char);
    od;
    a1 < b1
corp;

proc cmd_country()void:
    type
	countryList_t = struct {
	    [NAME_LEN] char cl_name;
	    uint cl_which;
	};
    [COUNTRY_MAX] countryList_t names;
    countryList_t clTemp;
    uint countryCount;
    register uint i, j;

    user("Current time ");
    uTime(ES*.es_request.rq_time);
    user(", world created ");
    uTime(ES*.es_world.w_buildDate);
    userNL();
    if ES*.es_world.w_sortCountries then
	if ES*.es_country.c_status = cs_deity then
	    user(
       " \#  last access              time  BTU's   status    country name\n");
	    dash(63);
	    for i from 0 upto ES*.es_world.w_maxCountries - 1 do
		userF(i, 2);
		userSp();
		printCountry(i);
	    od;
	else
	    user(
	   " last access              time  BTU's   status    country name\n");
	    dash(60);
	    countryCount := ES*.es_world.w_currCountries;
	    for i from countryCount - 1 downto 0 do
		server(rt_readCountry, i);
		names[i].cl_name := ES*.es_request.rq_u.ru_country.c_name;
		names[i].cl_which := i;
	    od;
	    if countryCount > 1 then
		for i from 0 upto countryCount - 2 do
		    for j from i downto 0 do
			if strLess(&names[j].cl_name[0],
				   &names[j + 1].cl_name[0])
			then
			    clTemp := names[j];
			    names[j] := names[j + 1];
			    names[j + 1] := clTemp;
			fi;
		    od;
		od;
	    fi;
	    i := countryCount;
	    while not ES*.es_gotControlC() and i ~= 0 do
		i := i - 1;
		printCountry(names[i].cl_which);
	    od;
	fi;
    else
	user(
       " \#  last access              time  BTU's   status    country name\n");
	dash(63);
	i := 0;
	while not ES*.es_gotControlC() and i ~= ES*.es_world.w_currCountries do
	    userF(i, 2);
	    userSp();
	    printCountry(i);
	    i := i + 1;
	od;
    fi;
    userNL();
corp;

/*
 * doCensus - part of cmd_census
 */

proc doCensus(int r, c; register *Sector_t s)void:
    [9] char DELIVERY = ('0','1','2','3','4','5','6','7',' ');

    if ES*.es_country.c_status = cs_deity then
	userF(s*.s_owner, 2);
	userSp();
    fi;
    userC(if s*.s_price = 0 then ' ' else '$' fi);
    userC(if s*.s_checkPoint = 0 then ' ' else '*' fi);
    if s*.s_type = s_exchange then
	user("xxxxxxx");
    else
	userC(DELIVERY[s*.s_direction[it_civilians]]);
	userC(DELIVERY[s*.s_direction[it_military]]);
	userC(DELIVERY[s*.s_direction[it_shells]]);
	userC(DELIVERY[s*.s_direction[it_guns]]);
	userC(DELIVERY[s*.s_direction[it_planes]]);
	userC(DELIVERY[s*.s_direction[it_ore]]);
	userC(DELIVERY[s*.s_direction[it_bars]]);
    fi;
    userC(if s*.s_defender = NO_DEFEND then ' ' else '%' fi);
    userSp();
    userC(ES*.es_sectorChar[s*.s_type]);
    user("  ");
    userF(s*.s_efficiency, 3);
    userSp();
    userF(s*.s_iron, 3);
    user("  ");
    userF(s*.s_gold, 3);
    userSp();
    userF(s*.s_mobility, 3);
    userSp();
    userF(readQuan(s, it_civilians), 4);
    userSp();
    userF(readQuan(s, it_military), 3);
    userSp();
    userF(readQuan(s, it_shells), 4);
    userSp();
    userF(readQuan(s, it_guns), 4);
    userSp();
    userF(readQuan(s, it_planes), 3);
    userSp();
    userF(readQuan(s, it_ore), 4);
    userSp();
    userF(readQuan(s, it_bars), 3);
    userSp();
    userF(s*.s_production, 3);
    user("  ");
    userF(r, 3);
    userC(',');
    userN(c);
    userNL();
corp;

proc cmd_census()void:
    SectorScan_t ss;

    if reqSectors(&ss, "Enter sectors specification for census: ") then
	if ES*.es_country.c_status = cs_deity then
	    user(" \# ");
	fi;
	user(
	"  cmsgpob des eff min gold mob civl mil   sh  gun  pl  ore bar prod\n"
	);
	dash(if ES*.es_country.c_status = cs_deity then 70 else 67 fi);
	if scanSectors(&ss, doCensus) = 0 then
	    err("no sectors matched");
	else
	    userNL();
	fi;
    fi;
corp;

proc doEnumerate(int r, c; *Sector_t s)void:
corp;

proc cmd_enumerate()void:
    SectorScan_t ss;
    uint n;

    if reqSectors(&ss, "Enter sectors specification for enumerate: ") then
	n := scanSectors(&ss, doEnumerate);
	if n = SINGLE_SECTOR then
	    n := 1;
	fi;
	userN(n);
	user(" sectors matched.\n");
    fi;
corp;

/*
 * isHead - return 'true' if the sector is a bridge head.
 */

proc isHead(int r, c)bool:

    server(rt_readSector, mapSector(r, c));
    ES*.es_request.rq_u.ru_sector.s_type = s_bridgeHead and
	ES*.es_request.rq_u.ru_sector.s_efficiency >= 20
corp;

/*
 * checkCollapse -
 *	see if a given sector is an unsupported bridge span - smash it!!!!
 */

proc checkCollapse(register int r, c)void:
    register uint mapped;

    mapped := mapSector(r, c);
    server(rt_readSector, mapped);
    if ES*.es_request.rq_u.ru_sector.s_type = s_bridgeSpan and
	    not isHead(r - 1, c) and
	    not isHead(r, c - 1) and
	    not isHead(r, c + 1) and
	    not isHead(r + 1, c)
    then
	server(rt_lockSector, mapped);
	zapSpan(&ES*.es_request.rq_u.ru_sector);
	server(rt_unlockSector, mapped);
	user("Skreeetch! SPLASH!!!!\n");
    fi;
corp;

/*
 * collapseSpans -
 *	A bridge head is being torn down.
 *	Collapse any bridge spans that depend on it for support.
 */

proc collapseSpans(register int r, c)void:

    checkCollapse(r - 1, c);
    checkCollapse(r, c - 1);
    checkCollapse(r, c + 1);
    checkCollapse(r + 1, c);
corp;

/*
 * doDesignate - part of cmd_designate
 */

proc doDesignate(int r, c; register *Sector_t s)void:
    register *Sector_t s1;
    uint mapped;
    register SectorType_t oldDesig;
    register ItemType_t it;

    oldDesig := s*.s_type;
    if ES*.es_country.c_status = cs_deity or
	oldDesig ~= s_mountain and oldDesig ~= s_bridgeSpan and
	oldDesig ~= s_water
    then
	if r = 0 and c = 0 and ES*.es_country.c_status ~= cs_deity then
	    err("can't redesignate your current capital");
	else
	    mapped := mapSector(r, c);
	    server(rt_lockSector, mapped);
	    updateSector(r, c);
	    if oldDesig = s_sanctuary then
		if ES*.es_country.c_status ~= cs_deity then
		    user("You are breaking sanctuary!!!\n");
		    news(n_broke_sanctuary, ES*.es_countryNumber, NOBODY);
		fi;
	    elif s*.s_efficiency ~= 0 and oldDesig ~= s_wilderness and
		ES*.es_sectorType1 ~= oldDesig
	    then
		if ES*.es_sectorType1 = s_highway then
		    user("Paving over ");
		else
		    user("Tearing down ");
		fi;
		userN(s*.s_efficiency);
		user2("% efficient ", getDesigName(oldDesig));
		userS(" at ", r, c, "\n");
	    fi;
	    s1 := &ES*.es_request.rq_u.ru_sector;
	    if oldDesig = s_exchange and ES*.es_sectorType1 ~= s_exchange or
		oldDesig ~= s_exchange and ES*.es_sectorType1 = s_exchange
	    then
		for it from it_first upto it_last do
		    s1*.s_direction[it] := NO_DELIVER;
		    s1*.s_threshold[it] := 0;
		od;
	    fi;
	    s1*.s_type := ES*.es_sectorType1;
	    for it from it_first upto it_last do
		writeQuan(s1, it, readQuan(s, it));
	    od;
	    if ES*.es_sectorType1 ~= oldDesig then
		s1*.s_efficiency := 0;
		s1*.s_production := 0;
		s1*.s_price := 0;
	    fi;
	    server(rt_unlockSector, mapped);
	    s* := s1*;
	    if oldDesig = s_bridgeHead and ES*.es_sectorType1 ~= s_bridgeHead
	    then
		collapseSpans(r, c);
	    fi;
	    if ES*.es_sectorType1 = s_capital and
		ES*.es_country.c_status ~= cs_deity
	    then
		server(rt_lockCountry, ES*.es_countryNumber);
		ES*.es_request.rq_u.ru_country.c_centerRow := rowToAbs(r);
		ES*.es_request.rq_u.ru_country.c_centerCol := colToAbs(c);
		ES*.es_country := ES*.es_request.rq_u.ru_country;
		server(rt_unlockCountry, ES*.es_countryNumber);
		user(
"WARNING: your co-ordinate system has shifted to center on your new capital!\n"
		);
	    fi;
	fi;
    fi;
corp;

proc cmd_designate()void:
    SectorScan_t ss;
    uint count;
    bool ok;

    if reqSectors(&ss, "Enter sectors specification for designate: ") and
	doSkipBlanks() and
	reqDesig(&ES*.es_sectorType1, "Enter type to designate: ")
    then
	if (ES*.es_sectorType1 = s_mountain or ES*.es_sectorType1 = s_water or
	    ES*.es_sectorType1 = s_sanctuary or
	    ES*.es_sectorType1 = s_bridgeSpan) and
	    ES*.es_country.c_status ~= cs_deity
	then
	    err("only a deity can make a mountain, ocean or sanctuary");
	else
	    ok := ES*.es_country.c_btu >= 1;
	    if ES*.es_sectorType1 = s_capital and
		ES*.es_country.c_btu < 1
	    then
		server(rt_readSector, mapSector(0, 0));
		if ES*.es_request.rq_u.ru_sector.s_owner ~=
			ES*.es_countryNumber and
		    ES*.es_country.c_btu = 0
		then
		    err("free designate of capital");
		    ok := true;
		fi;
	    fi;
	    if ok then
		if ES*.es_country.c_btu >= 1 then
		    ES*.es_country.c_btu := ES*.es_country.c_btu - 1;
		fi;
		server(rt_lockCountry, ES*.es_countryNumber);
		ES*.es_request.rq_u.ru_country.c_btu := ES*.es_country.c_btu;
		server(rt_unlockCountry, ES*.es_countryNumber);
		ES*.es_country := ES*.es_request.rq_u.ru_country;
		count := scanSectors(&ss, doDesignate);
		if count = 0 then
		    err("no sectors matched");
		elif count ~= SINGLE_SECTOR then
		    userN(count);
		    user(" sectors designated\n");
		fi;
	    else
		user("You don't have enough BTU's remaining!\n");
	    fi;
	fi;
    fi;
corp;

/*
 * doCheckpoint - part of cmd_checkpoint
 */

proc doCheckpoint(int r, c; *Sector_t s)void:
    [100] char prompt;
    uint mapped;
    int n;

    user("Enter new checkpoint code for sector ");
    userN(r);
    userN3(",", c, ": ");
    getPrompt(&prompt[0]);
    if reqNumber(&n, &prompt[0]) then
	if n < -128 or n > 127 then
	    err("invalid checkpoint code - not changed");
	else
	    mapped := mapSector(r, c);
	    server(rt_lockSector, mapped);
	    ES*.es_request.rq_u.ru_sector.s_checkPoint := n;
	    server(rt_unlockSector, mapped);
	fi;
    else
	err("checkpoint code not changed");
    fi;
corp;

proc cmd_checkpoint()bool:
    SectorScan_t ss;

    if reqSectors(&ss, "Checkpoint which sectors? ") then
	ignore skipBlanks();
	if getPassword("Enter your password to verify: ",
		       &ES*.es_country.c_password[0])
	then
	    ES*.es_textInPos := &ES*.es_textIn[0];
	    ES*.es_textInPos* := '\e';
	    if scanSectors(&ss, doCheckpoint) = 0 then
		err("no sectors matched");
	    fi;
	    true
	else
	    user("no sectors checkpointed\n");
	    false
	fi
    else
	false
    fi
corp;

proc cmd_update()bool:
    *char p, q;
    register uint count;
    register int r, c;
    int top, bottom, left, right;
    bool quit;

    p := skipBlanks();
    if
	if p* = '\e' then
	    reqBox(&top, &bottom, &left, &right, "Region to update? ")
	else
	    getBox(&top, &bottom, &left, &right)
	fi
    then
	p := skipBlanks();
	if p* ~= '\e' then
	    q := skipWord();
	    ignore skipBlanks();
	    q* := '\e';
	    if CharsEqual(p, "terse") then
		ES*.es_quietUpdate := true;
	    elif CharsEqual(p, "verbose") then
		ES*.es_verboseUpdate := true;
	    fi;
	fi;
	count := 0;
	quit := false;
	r := top;
	while not quit and r <= bottom do
	    c := left;
	    while not quit and c <= right do
		quit := ES*.es_gotControlC();
		accessSector(r, c);
		if ES*.es_request.rq_u.ru_sector.s_owner = ES*.es_countryNumber
		then
		    count := count + 1;
		fi;
		c := c + 1;
	    od;
	    r := r + 1;
	od;
	userN(count);
	user(" sectors updated.\n");
	true
    else
	false
    fi
corp;

proc cmd_nation()void:
    register *Country_t c;
    register uint i;
    bool hadOne;

    user3("Status of ", &ES*.es_country.c_name[0], " on ");
    uTime(ES*.es_request.rq_time);
    user(":\n\n");
    userN3("Number of sectors: ", ES*.es_country.c_sectorCount, "\n");
    userN3("Cash on hand: ", ES*.es_country.c_money, "\n");
    userN3("Technology level: ", ES*.es_country.c_techLevel, "\n");
    i := getTechFactor(ES*.es_countryNumber);
    userN3("Technology factor: ", i / 100, ".");
    userF(i % 100, -2);
    userNL();
    userN3("Research level: ", ES*.es_country.c_resLevel, "\n");
    server(rt_readSector, mapSector(0, 0));
    i := calcPlagueFactor(&ES*.es_country, &ES*.es_request.rq_u.ru_sector);
    userN3("Plague factor in capital: ", i / 100, ".");
    userF(i % 100, -2);
    userNL();
    user("Realms: ");
    for i from 0 upto REALM_MAX - 1 do
	userN3("\#", i, ": ");
	userN3("", ES*.es_country.c_realms[i].r_top, ":");
	userN3("", ES*.es_country.c_realms[i].r_bottom, ",");
	userN3("", ES*.es_country.c_realms[i].r_left, ":");
	userN3("", ES*.es_country.c_realms[i].r_right, " ");
	if i % 2 = 1 then
	    userNL();
	    if i ~= REALM_MAX - 1 then
		user("        ");
	    fi;
	fi;
    od;
    userNL();
    hadOne := false;
    c := &ES*.es_request.rq_u.ru_country;
    for i from 0 upto ES*.es_world.w_currCountries - 1 do
	server(rt_readCountry, i);
	if i ~= ES*.es_countryNumber and c*.c_status = cs_active then
	    if ES*.es_country.c_relations[i] ~= r_neutral then
		hadOne := true;
		user3(&ES*.es_country.c_name[0], " is ",
			case ES*.es_country.c_relations[i]
			incase r_allied:
			    "allied"
			incase r_war:
			    "at war"
			esac);
		user3(" with ", &c*.c_name[0], ".\n");
	    fi;
	    if c*.c_relations[ES*.es_countryNumber] ~= r_neutral then
		hadOne := true;
		user3(&c*.c_name[0], " is ",
			case c*.c_relations[ES*.es_countryNumber]
			incase r_allied:
			    "allied"
			incase r_war:
			    "at war"
			esac);
		user3(" with ", &ES*.es_country.c_name[0], ".\n");
	    fi;
	fi;
    od;
    if hadOne then
	userNL();
    fi;
corp;

/*
 * doContract - part of cmd_contract
 */

proc doContract(int r, c; register *Sector_t s)void:
    uint price, mapped;

    if s*.s_owner = ES*.es_countryNumber and
	(s*.s_type = s_industry or s*.s_type = s_defense or
	 s*.s_type = s_airport or s*.s_type = s_harbour or
	 s*.s_type = s_bridgeHead or s*.s_type = s_ironMine or
	 s*.s_type = s_goldMine or s*.s_type = s_research or
	 s*.s_type = s_technical)
    then
	price :=
	    case random(100)
	    incase 0 .. 1:
		random(40) + 1
	    incase 2 .. 97:
		random(60) + 40
	    incase 98 .. 99:
		random(140) + 100
	    esac * ES*.es_world.w_contractScale / 100;
	userN3("You are offered $", price * 5 / 100, ".");
	userF(price * 5 % 100, -2);
	userS(" for the production of sector ", r, c, "\n");
	mapped := mapSector(r, c);
	if ask("Do you accept? ") then
	    server(rt_lockSector, mapped);
	    ES*.es_request.rq_u.ru_sector.s_price := price;
	else
	    server(rt_lockSector, mapped);
	    ES*.es_request.rq_u.ru_sector.s_price := 0;
	fi;
	server(rt_unlockSector, mapped);
    fi;
corp;

proc cmd_contract()bool:
    SectorScan_t ss;

    if reqSectors(&ss, "Sector(s) to contract: ") then
	if scanSectors(&ss, doContract) = 0 then
	    err("no sectors matched");
	fi;
	true
    else
	false
    fi
corp;

/*
 * printRealm - part of cmd_realm.
 */

proc printRealm(uint realm)void:
    register *Realm_t r;

    r := &ES*.es_country.c_realms[realm];
    userN3("Realm ", realm, " is ");
    userF(r*.r_top, 4);
    userC(':');
    userF(r*.r_bottom, 4);
    userC(',');
    userF(r*.r_left, 4);
    userC(':');
    userF(r*.r_right, 4);
    user(".\n");
corp;

proc cmd_realm()void:
    int top, bottom, left, right, realm;

    if ES*.es_textInPos* = '\e' then
	for realm from 0 upto REALM_MAX - 1 do
	    printRealm(realm);
	od;
    elif getNumber(&realm) then
	if realm < 0 or realm >= REALM_MAX then
	    err("invalid realm number");
	else
	    ignore skipBlanks();
	    if ES*.es_textInPos* ~= '\e' then
		if getBox(&top, &bottom, &left, &right) then
		    ES*.es_country.c_realms[realm].r_top := top;
		    ES*.es_country.c_realms[realm].r_bottom := bottom;
		    ES*.es_country.c_realms[realm].r_left := left;
		    ES*.es_country.c_realms[realm].r_right := right;
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_realms[realm] :=
			ES*.es_country.c_realms[realm];
		    server(rt_unlockCountry, ES*.es_countryNumber);
		fi;
	    else
		printRealm(realm);
	    fi;
	fi;
    fi;
corp;

proc cmd_dissolve()void:

    if getPassword("Enter password: ", &ES*.es_country.c_password[0]) then
	if ask("Do you really want to dissolve your country? ") then
	    /* much, much, more should be done. P.L.'s manual says:
		all sectors back to deity
		    (I suggest that all defenses turned off, etc.)
		pays off any debts that it can
		voids any treaties
		ships decide own fate:
		    riot
		    go up for sale
		    scuttled
	    */
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_status := cs_quit;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    ES*.es_country := ES*.es_request.rq_u.ru_country;
	    user("Done.\n"
	    "*************************************************************\n"
	    "\n"
	    "'dissolve' currently does nothing more than change the status\n"
	    "of your country. It doesn't really work yet.\n"
	    "\n"
	    "*************************************************************\n");
	    news(n_dissolve, ES*.es_countryNumber, 0);
	else
	    user("OK, dissolve cancelled.\n");
	fi;
    else
	user("dissolve cancelled.\n");
    fi;
corp;
