#drinc:util.g
#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * startup.d - startup and library interface portion of Empire library.
 */

uint
    R_D0 = 0,
    R_A0 = 0,
    R_FP = 6,
    OP_MOVEL = 0x2000,
    OP_MOVEW = 0x3000,
    M_DDIR = 0,
    M_ADIR = 1,
    M_DISP = 5;

/*
 * user - send a string to the user.
 */

proc user(register *char str)void:
    register *char p;
    register uint lenLeft;
    register char ch;

    lenLeft := ES*.es_textOutPos;
    p := &ES*.es_textOut[lenLeft];
    lenLeft := OUTPUT_BUFFER_SIZE - lenLeft;
    while str* ~= '\e' do
	ch := str*;
	str := str + sizeof(char);
	p* := ch;
	p := p + sizeof(char);
	lenLeft := lenLeft - 1;
	if ch = '\n' and not ES*.es_noWrite or lenLeft = 0 then
	    ES*.es_textOutPos := OUTPUT_BUFFER_SIZE - lenLeft;
	    ES*.es_writeUser();
	    p := &ES*.es_textOut[0];
	    lenLeft := OUTPUT_BUFFER_SIZE;
	fi;
    od;
    ES*.es_textOutPos := OUTPUT_BUFFER_SIZE - lenLeft;
corp;

/*
 * userNL - a newline on user output.
 */

proc userNL()void:

    user("\n");
corp;

/*
 * userC - add a single character to the output.
 */

proc userC(char ch)void:
    [2] char buffer;

    buffer[0] := ch;
    buffer[1] := '\e';
    user(&buffer[0]);
corp;

/*
 * userSp - a single space on user output.
 */

proc userSp()void:

    user(" ");
corp;

/*
 * uFlush - flush the output buffer.
 */

proc uFlush()void:

    if ES*.es_textOutPos ~= 0 then
	ES*.es_writeUser();
	ES*.es_textOutPos := 0;
    fi;
corp;

/*
 * uPrompt - display a prompt to the user.
 */

proc uPrompt(*char prompt)void:

    user(prompt);
    uFlush();
corp;

/*
 * userN - output a 32 bit decimal value to the user stream.
 */

proc userN(register long n)void:
    [12] char buffer;
    register *char p;
    bool isNeg;

    if n >= 0 then
	n := -n;
	isNeg := false;
    else
	isNeg := true;
    fi;
    p := &buffer[11];
    p* := '\e';
    while
	p := p - sizeof(char);
	p* := -(n % 10) + '0';
	n := n / 10;
	n ~= 0
    do
    od;
    if isNeg then
	p := p - sizeof(char);
	p* := '-';
    fi;
    user(p);
corp;

/*
 * userF - output a decimal value using the given number of characters.
 */

proc userF(register long n; register int digits)void:
    [20] char buffer;
    register *char p;
    bool isNeg, pad;

    if digits < 0 then
	pad := true;
	digits := -digits;
    else
	pad := false;
    fi;
    if n >= 0 then
	n := -n;
	isNeg := false;
    else
	isNeg := true;
    fi;
    p := &buffer[19];
    p* := '\e';
    while
	p := p - sizeof(char);
	p* := -(n % 10) + '0';
	digits := digits - 1;
	n := n / 10;
	n ~= 0
    do
    od;
    if isNeg then
	p := p - sizeof(char);
	p* := '-';
	digits := digits - 1;
    fi;
    while digits ~= 0 do
	p := p - sizeof(char);
	p* := if pad then '0' else ' ' fi;
	digits := digits - 1;
    od;
    user(p);
corp;

/*
 * userX - output a value with the given number of hex digits.
 */

proc userX(register ulong n; register uint digits)void:
    [9] char buffer;
    register *char p;
    register uint digit;

    p := &buffer[8];
    p* := '\e';
    while digits ~= 0 do
	digits := digits - 1;
	digit := n & 0xf;
	p := p - sizeof(char);
	p* := if digit >= 10 then digit - 10 + 'A' else digit + '0' fi;
	n := n >> 4;
    od;
    user(p);
corp;

/*
 * user2 - write 2 strings to the user.
 */

proc user2(*char m1, m2)void:

    user(m1);
    user(m2);
corp;

/*
 * user3 - write 3 strings to the user.
 */

proc user3(*char m1, m2, m3)void:

    user(m1);
    user(m2);
    user(m3);
corp;

/*
 * userN2 - write 1 string and a number to the user.
 */

proc userN2(*char m1; long n)void:

    user(m1);
    userN(n);
corp;

/*
 * userN3 - write 2 strings and a number to the user.
 */

proc userN3(*char m1; long n; *char m2)void:

    user(m1);
    userN(n);
    user(m2);
corp;

/*
 * userS - output 2 messages and a sector coordinate.
 */

proc userS(*char m1; int r, c; *char m2)void:

    user(m1);
    userN(r);
    user(",");
    userN(c);
    user(m2);
corp;

/*
 * userTarget - output 2 messages and a sector coordinate translated to the
 *	scheme of the given country.
 *	NOTE: this routine reads in the target country in order to find its
 *	origin, thus it wipes out the request structure!
 */

proc userTarget(uint country; *char m1; int r, c; *char m2)void:

    user(m1);
    userN(rowToCou(country, rowToAbs(r)));
    user(",");
    userN(colToCou(country, colToAbs(c)));
    user(m2);
corp;

/*
 * userM3 - output a monetary value with a decimal point, and 2 messages.
 */

proc userM3(*char m1; uint price; *char m2)void:

    user(m1);
    userN(price / 10);
    userC('.');
    userN(price % 10);
    userC('0');
    user(m2);
corp;

/*
 * getPrompt - get a prompt from the output buffer.
 */

proc getPrompt(*char buffer)void:

    ES*.es_textOut[ES*.es_textOutPos] := '\e';
    CharsCopy(buffer, &ES*.es_textOut[0]);
    ES*.es_textOutPos := 0;
corp;

/*
 * ask - get a yes/no answer from the user.
 */

proc ask(*char question)bool:
    register char ch;

    uPrompt(question);
    if ES*.es_readUser() then
	ch := skipBlanks()*;
	ES*.es_textInPos := &ES*.es_textIn[0];
	ES*.es_textIn[0] := '\e';
	ch = 'y' or ch = 'Y' or ch = 'o' or ch = 'O'
    else
	false
    fi
corp;

/*
 * server - simple interface stub to do a server request.
 */

proc server(RequestType_t rt; uint whichUnit)void:

    ES*.es_request.rq_type := rt;
    ES*.es_request.rq_whichUnit := whichUnit;
    ES*.es_serverRequest();
corp;

/*
 * server2 - similar interface, but for a pair.
 */

proc server2(RequestType_t rt; uint whichUnit, otherUnit)void:

    ES*.es_request.rq_type := rt;
    ES*.es_request.rq_whichUnit := whichUnit;
    ES*.es_request.rq_otherUnit := otherUnit;
    ES*.es_serverRequest();
corp;

/*
 * log3 - write a 3 - part log message to the log file.
 *	NOTE: there is NO checking for overflow on this. BE CAREFUL!
 */

proc log3(*char m1, m2, m3)void:
    register *char p, q;

    p := &ES*.es_request.rq_u.ru_text[0];
    q := m1;
    while q* ~= '\e' do
	p* := q*;
	p := p + sizeof(char);
	q := q + sizeof(char);
    od;
    q := m2;
    while q* ~= '\e' do
	p* := q*;
	p := p + sizeof(char);
	q := q + sizeof(char);
    od;
    q := m3;
    while q* ~= '\e' do
	p* := q*;
	p := p + sizeof(char);
	q := q + sizeof(char);
    od;
    p* := '\e';
    server(rt_log, 0);
corp;

/*
 * cmd_flush - deity command to tell the server to flush the files.
 */

proc cmd_flush()void:

    if ES*.es_country.c_status ~= cs_deity then
	err("only the deity can use this command");
    else
	server(rt_flush, 0);
    fi;
corp;

/*
 * cmd_tickle - deity command to bring the time on all sectors, ships, etc.
 *	forward by the time the game has been idle.
 */

proc cmd_tickle()void:
    register ulong delta;
    uint i;
    register uint j, mapped;

    if ES*.es_country.c_status ~= cs_deity then
	err("only the deity can use this command");
    else
	delta := timeNow() - timeRound(ES*.es_world.w_lastRun);
	if ES*.es_world.w_loanNext ~= 0 then
	    for i from 0 upto ES*.es_world.w_loanNext - 1 do
		server(rt_lockLoan, i);
		ES*.es_request.rq_u.ru_loan.l_lastPay :=
		    ES*.es_request.rq_u.ru_loan.l_lastPay + delta;
		ES*.es_request.rq_u.ru_loan.l_dueDate :=
		    ES*.es_request.rq_u.ru_loan.l_dueDate + delta;
		server(rt_unlockLoan, i);
	    od;
	fi;
	if ES*.es_world.w_shipNext ~= 0 then
	    for i from 0 upto ES*.es_world.w_shipNext - 1 do
		server(rt_lockShip, i);
		ES*.es_request.rq_u.ru_ship.sh_lastUpdate :=
		    ES*.es_request.rq_u.ru_ship.sh_lastUpdate + delta;
		server(rt_unlockShip, i);
	    od;
	fi;
	for i from 0 upto ES*.es_world.w_rows - 1 do
	    for j from 0 upto ES*.es_world.w_columns - 1 do
		mapped := mapAbsSector(i, j);
		server(rt_lockSector, mapped);
		ES*.es_request.rq_u.ru_sector.s_lastUpdate :=
		    ES*.es_request.rq_u.ru_sector.s_lastUpdate + delta;
		server(rt_unlockSector, mapped);
	    od;
	od;
	server(rt_lockWorld, 0);
	ES*.es_world.w_lastRun := ES*.es_world.w_lastRun + delta;
	server(rt_unlockWorld, 0);
	server(rt_flush, 0);
    fi;
corp;

/*
 * cmd_log - allow local player to enable logging.
 */

proc cmd_log()void:
    *char p;

    if ES*.es_textInPos* = '\e' then
	p := nil;
	code(OP_MOVEL | R_A0 << 9 | M_ADIR << 6 | M_DISP << 3 | R_FP, p);
	if ES*.es_log(/* nil */) then
	    err("logging turned off");
	fi;
    else
	p := ES*.es_textInPos;
	ignore skipWord();
	code(OP_MOVEL | R_A0 << 9 | M_ADIR << 6 | M_DISP << 3 | R_FP, p);
	if ES*.es_log(/* p */) then
	    err("logging turned on");
	else
	    err("cannot turn logging on (only allowed for a local player)");
	fi;
    fi;
corp;

/*
 * sleep - call the sleep routine to sleep a bit.
 */

proc sleep(uint tenthsOfSeconds)void:

    if tenthsOfSeconds ~= 0 then
	code(OP_MOVEW | R_D0 << 9 | M_DDIR << 6 | M_DISP << 3 | R_FP,
	     tenthsOfSeconds);
	ES*.es_sleep();
    fi;
corp;

/*
 * uTime - add a given time value to the output.
 */

proc uTime(ulong time)void:
    [25] char buffer;

    ConvTime(time, &buffer[0]);
    user(&buffer[0]);
corp;

/*
 * printFile - interface to the client's printFile routine.
 */

proc printFile(*char fileName; FileType_t ft)bool:
    register *char p, q;
    register uint len;
    register char ch;
    register bool abort;

    CharsCopy(&ES*.es_request.rq_u.ru_text[0], fileName);
    server(
	case ft
	incase ft_normal:
	    rt_readFile
	incase ft_help:
	    rt_readHelp
	incase ft_doc:
	    rt_readDoc
	esac, 0);
    if ES*.es_request.rq_whichUnit = 0 then
	false
    else
	abort := false;
	q := &ES*.es_textOut[0];
	while
	    len := ES*.es_request.rq_whichUnit;
	    len ~= 0
	do
	    if not abort then
		p := &ES*.es_request.rq_u.ru_text[0];
		while not abort and len ~= 0 do
		    while
			len := len - 1;
			ch := p*;
			p := p + sizeof(char);
			q* := ch;
			q := q + sizeof(char);
			ch ~= '\n' and len ~= 0
		    do
		    od;
		    if ch = '\n' then
			ES*.es_textOutPos := q - &ES*.es_textOut[0];
			ES*.es_writeUser();
			q := &ES*.es_textOut[0];
			abort := ES*.es_gotControlC();
		    fi;
		od;
	    fi;
	    server(rt_moreFile, 0);
	od;
	ES*.es_textOutPos := 0;
	true
    fi
corp;

/*
 * news - generate an item of news.
 */

proc news(NewsType_t verb; uint actor, victim)void:

    ES*.es_request.rq_u.ru_news.n_verb := verb;
    ES*.es_request.rq_u.ru_news.n_actor := actor;
    ES*.es_request.rq_u.ru_news.n_victim := victim;
    server(rt_news, 0);
corp;

/*
 * getPassword - prompt for and check a password.
 */

proc getPassword(*char prompt, password)bool:
    bool ok;

    if password* = '\e' then
	true
    else
	uPrompt(prompt);
	ES*.es_echoOff();
	ok := ES*.es_readUser();
	ES*.es_echoOn();
	if ok then
	    if CharsEqual(&ES*.es_textIn[0], password) then
		true
	    else
		user("Password incorrect. - ");     /* NO newline */
		false
	    fi
	else
	    false
	fi
    fi
corp;

/*
 * getCountryPassword - get and check the country's password.
 */

proc getCountryPassword()bool:

    getPassword("Enter country password: ", &ES*.es_country.c_password[0])
corp;

/*
 * newCountryPassword - get a new password for the country. Verify it.
 *	return 'true' if it is verified, and install into the country.
 */

proc newCountryPassword()bool:
    [PASSWORD_LEN] char password;
    bool ok;

    uPrompt("Enter new country password: ");
    ES*.es_echoOff();
    ok := ES*.es_readUser();
    ES*.es_echoOn();
    if ok then
	CharsCopy(&password[0], &ES*.es_textIn[0]);
	uPrompt("Re-enter password to verify: ");
	ES*.es_echoOff();
	ok := ES*.es_readUser();
	ES*.es_echoOn();
	if ok then
	    if CharsEqual(&password[0], &ES*.es_textIn[0]) then
		ES*.es_country.c_password := password;
		true
	    else
		user("Password not verified.\n");
		false
	    fi
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * updateTimer - updates connect time limit, returns 'false' if we should quit
 */

proc updateTimer()bool:
    ulong now, dt;

    weatherUpdate();
    now := ES*.es_request.rq_time;
    if ES*.es_country.c_status = cs_deity then
	false
    elif ES*.es_country.c_lastOn / (24 * 60 * 60) ~= now / (24 * 60 * 60) then
	/* it's now the next day - reset timer */
	server(rt_lockCountry, ES*.es_countryNumber);
	ES*.es_request.rq_u.ru_country.c_lastOn := now;
	ES*.es_request.rq_u.ru_country.c_timeLeft := ES*.es_world.w_maxConnect;
	ES*.es_country := ES*.es_request.rq_u.ru_country;
	server(rt_unlockCountry, ES*.es_countryNumber);
	false
    else
	if ES*.es_country.c_timeLeft < (now - ES*.es_country.c_lastOn) / 60
	then
	    /* he's been here too long! - he should go away */
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_timeLeft := 0;
	    ES*.es_country := ES*.es_request.rq_u.ru_country;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    true
	else
	    dt := (now - ES*.es_country.c_lastOn) / 60;
	    if dt >= 1 then
		server(rt_lockCountry, ES*.es_countryNumber);
		ES*.es_request.rq_u.ru_country.c_timeLeft :=
		    ES*.es_request.rq_u.ru_country.c_timeLeft - dt;
		ES*.es_request.rq_u.ru_country.c_lastOn :=
		    ES*.es_request.rq_u.ru_country.c_lastOn + dt * 60;
		ES*.es_country := ES*.es_request.rq_u.ru_country;
		server(rt_unlockCountry, ES*.es_countryNumber);
	    fi;
	    false
	fi
    fi
corp;

/*
 * resetTimer - Resets the timer when you enter the program if you haven't
 *	been in the program since 12 midnight. Also recalculate BTUS.
 *	Returns 'true' if you are out of time for the day.
 */

/*
%%%%% a problem was reported with trying to allow 24 hours per day
      connection by having maxtime = 1440. Look into if it is possible.
*/

proc resetTimer()bool:
    ulong now;
    bool timedOut;

    weatherUpdate();
    if ES*.es_country.c_status = cs_deity then
	server(rt_lockCountry, ES*.es_countryNumber);
	now := ES*.es_request.rq_time;
	ES*.es_request.rq_u.ru_country.c_timeLeft := 9999;
	timedOut := false;
    else
	accessSector(0, 0);
	/* Check to see if we changed days since the last access */
	server(rt_lockCountry, ES*.es_countryNumber);
	now := ES*.es_request.rq_time;
	if ES*.es_request.rq_u.ru_country.c_lastOn / (24 * 60 * 60) ~=
	    now / (24 * 60 * 60)
	then
	    ES*.es_request.rq_u.ru_country.c_timeLeft :=
		ES*.es_world.w_maxConnect;
	fi;
	timedOut := ES*.es_request.rq_u.ru_country.c_timeLeft = 0;
    fi;
    ES*.es_request.rq_u.ru_country.c_lastOn := now;
    server(rt_unlockCountry, ES*.es_countryNumber);
    ES*.es_country := ES*.es_request.rq_u.ru_country;
    timedOut
corp;

/*
 * internalEmpire - the entry point to the Empire library.
 */

proc internalEmpire(*EmpireState_t es)void:
    register *World_t w, rw;
    register *Country_t c @ w, rc @ rw;
    *char name, q;
    register uint i;
    ulong now, lastOn;
    bool aborting;

    ES := es;
    ES*.es_textOutPos := 0;
    ES*.es_noWrite := false;
    ES*.es_sectorChar := SECTOR_CHAR;
    ES*.es_shipChar := SHIP_CHAR;
    ES*.es_itemChar := ITEM_CHAR;
    user("           Welcome to Amiga Empire Version 2.1!!\n"
	     "                       by Chris Gray\n\n\n");
    ignore printFile(CONNECT_MESSAGE_FILE, ft_normal);
    aborting := false;
    uPrompt("Enter country name: ");
    if ES*.es_readUser() then
	/* trim leading space */
	name := skipBlanks();
	if name* = '\e' then
	    aborting := true;
	    log3("Empty country name entered.", "", "");
	fi;
    else
	aborting := true;
	log3("Error when reading country name.", "", "");
    fi;
    if not aborting then
	/* truncate the entered name to what we allow */
	q := name;
	while q* ~= '\e' do
	    q := q + sizeof(char);
	od;
	if (q - name) / sizeof(char) >= NAME_LEN then
	    (name + (NAME_LEN - 1))* := '\e';
	fi;
	server(rt_readWorld, 0);
	/* NOTE: we have overlayed register variables w & c; rw & rc; we
	   happen to know that all members of a union are at offset 0 in
	   that union, so setting 'rc' also serves to set 'wc'. I realize
	   that I should probably be shot for doing this kind of thing!! */
	w := &ES*.es_world;
	rc := &ES*.es_request.rq_u.ru_country;
	w* := rw*;
	i := 0;
	while
	    if i = w*.w_currCountries then
		false
	    else
		server(rt_readCountry, i);
		not CharsEqual(&rc*.c_name[0], name)
	    fi
	do
	    i := i + 1;
	od;
	if i = w*.w_currCountries then
	    /* p points to the country name in the input buffer. That is
	       very volatile, so copy the name to the country record, and
	       make p point at the name there. */
	    CharsCopy(&ES*.es_country.c_name[0], name);
	    name := &ES*.es_country.c_name[0];
	    user3("Country ", name, " does not exist.\n");
	    if i = w*.w_maxCountries then
		user("There is no space for more countries.\n");
		aborting := true;
		log3("Try to create country ",name," when no space left.");
	    elif ask("Do you wish to create it? ") then
		if getPassword("Enter creation password for this game: ",
			       &w*.w_password[0])
		then
		    if newCountryPassword() then
			/* be careful, someone else could have gone in and
			   taken the next country while we are fiddling
			   around */
			server(rt_lockWorld, 0);
			w* := rw*;
			i := w*.w_currCountries;
			if i = w*.w_maxCountries then
			    server(rt_unlockWorld, 0);
			    aborting := true;
			    user("Ooops, someone stole it out from "
				     "under you!\n");
			    log3("Country create clash, country ",name,"");
			else
			    w*.w_currCountries := i + 1;
			    rw*.w_currCountries := i + 1;
			    server(rt_unlockWorld, 0);
			    ES*.es_countryNumber := i;
			    server(rt_lockCountry, i);
			    /* we want the country name and password that we
			       have set up here, but the rest of the record
			       from what was set up by EmpCre */
			    c := &ES*.es_country;
			    rc*.c_password := c*.c_password;
			    rc*.c_name := c*.c_name;
			    c* := rc*;
			    c*.c_status := cs_active;
			    c*.c_lastOn := ES*.es_request.rq_time;
			    rc* := c*;
			    server(rt_unlockCountry, i);
			    ignore resetTimer();
			    log3("Country ", name, " created.");
			fi;
		    else
			aborting := true;
			log3("Unverified password, country ", name, "");
		    fi;
		else
		    user("reconnect to try again.\n");
		    aborting := true;
		    log3("Bad creation password, country ", name, "");
		fi;
	    else
		user("OK.\n");
		aborting := true;
		log3("Country ", name, " creation declined.");
	    fi;
	else
	    ES*.es_countryNumber := i;
	    ES*.es_country := rc*;
	    name := &ES*.es_country.c_name[0];
	    if not getCountryPassword() then
		user("try again.\n");
		if not getCountryPassword() then
		    user("try again.\n");
		    if not getCountryPassword() then
			user("aborting\n");
			log3("Country ", name, " denied - bad password.");
			aborting := true;
		    fi;
		fi;
	    fi;
	    if not aborting then
		if ES*.es_country.c_loggedOn and
		    ES*.es_country.c_status ~= cs_deity
		then
		    aborting := true;
		    user3("Country ", name, " is already logged on.\n");
		    log3("Country ", name, " is already logged on.");
		elif ES*.es_country.c_loggedOn then
		    user(
	   "\n*** Warning!!! This Deity was already marked as logged on!!!\n\n"
		    );
		fi;
	    fi;
	fi;
	if not aborting then
	    lastOn := ES*.es_country.c_lastOn;
	    if resetTimer() then
		user("Sorry, you are out of time for today."
		     " Come back tomorrow.\n");
		log3("Country ", name, " denied - no time left.");
	    else
		c := &ES*.es_country;
		server(rt_lockCountry, ES*.es_countryNumber);
		now := ES*.es_request.rq_time;
		rc*.c_loggedOn := true;
		rc*.c_lastOn := now;
		server(rt_unlockCountry, ES*.es_countryNumber);
		c* := rc*;
		user2(name, " on at ");
		uTime(now);
		user(" last on at ");
		uTime(lastOn);
		userNL();
		log3("Country ", name, " logged on.");
		ignore printFile(LOGIN_MESSAGE_FILE, ft_normal);
		server(rt_setCountry, ES*.es_countryNumber);
		telegramCheck();
		processCommands();
		server(rt_lockCountry, ES*.es_countryNumber);
		now := ES*.es_request.rq_time;
		rc*.c_loggedOn := false;
		rc*.c_lastOn := now;
		server(rt_unlockCountry, ES*.es_countryNumber);
		user2(name, " off at ");
		uTime(now);
		userNL();
		ignore printFile(LOGOUT_MESSAGE_FILE, ft_normal);
		server(rt_lockWorld, 0);
		ES*.es_request.rq_u.ru_world.w_lastRun := now;
		server(rt_unlockWorld, 0);
		log3("Country ", name, " logged off.");
	    fi;
	fi;
    fi;
corp;
