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
 * skipBlanks - skip past blanks in the input line.
 */

proc skipBlanks()*char:
    register *char p;

    p := ES*.es_textInPos;
    while p* = ' ' or p* = '\t' do
	p := p + sizeof(char);
    od;
    ES*.es_textInPos := p;
    p
corp;

/*
 * skipWord - skip up to blanks or end of string in input line.
 */

proc skipWord()*char:
    register *char p;

    p := ES*.es_textInPos;
    while p* ~= ' ' and p* ~= '\e' and p* ~= '\t' do
	p := p + sizeof(char);
    od;
    ES*.es_textInPos := p;
    p
corp;

/*
 * doSkipBlanks - skip blanks, return 'true'
 */

proc doSkipBlanks()bool:

    ignore skipBlanks();
    true
corp;

/*
 * getNumber - read in a number.
 */

proc getNumber(*int pNum)bool:
    register *char inputPtr;
    register int n;
    bool isNeg;

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
	pNum* := if isNeg then -n else n fi;
	ES*.es_textInPos := inputPtr;
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
 * reqNumber - get (and prompt for if needed) a number.
 */

proc reqNumber(*int pN; *char prompt)bool:
    bool gotOne;
    ushort stat;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getNumber(pN)
	    fi
	do
	    err("invalid number, try again");
	od;
	gotOne
    else
	getNumber(pN)
    fi
corp;

/*
 * getPosRange - get a positive value less than or equal to a given amount
 */

proc getPosRange(*uint pQuan; uint maximum)bool:
    int n;

    if getNumber(&n) then
	if n < 0 or make(n, uint) > maximum then
	    userN3("*** value must be 0 - ", maximum, " ***\n");
	    false
	else
	    pQuan* := n;
	    true
	fi
    else
	false
    fi
corp;

/*
 * reqPosRange - get/request a positive value
 */

proc reqPosRange(*uint pQuan; uint maximum; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getPosRange(pQuan, maximum)
	    fi
	do
	od;
	gotOne
    else
	getPosRange(pQuan, maximum)
    fi
corp;

/*
 * getPosRange1 - get a number within a given range, with 1 decimal digit.
 */

proc getPosRange1(*uint pNum; uint maximum)bool:
    register *char inputPtr;
    register uint n;
    bool hadDecimal, bad;

    inputPtr := ES*.es_textInPos;
    hadDecimal := false;
    if inputPtr* >= '0' and inputPtr* <= '9' or inputPtr* = '.' then
	n := 0;
	while inputPtr* >= '0' and inputPtr* <= '9' do
	    n := n * 10 + (inputPtr* - '0');
	    inputPtr := inputPtr + sizeof(char);
	od;
	if inputPtr* = '.' then
	    inputPtr := inputPtr + sizeof(char);
	    if inputPtr* >= '0' and inputPtr* <= '9' then
		n := n * 10 + (inputPtr* - '0');
		inputPtr := inputPtr + sizeof(char);
		while inputPtr* >= '0' and inputPtr* <= '9' do
		    inputPtr := inputPtr + sizeof(char);
		od;
	    else
		n := n * 10;
	    fi;
	else
	    n := n * 10;
	fi;
	if inputPtr* ~= '\e' and inputPtr* ~= ' ' and inputPtr* ~= '\t' then
	    err("invalid digit");
	    bad := true;
	fi;
    else
	err("invalid digit");
	bad := true;
    fi;
    if not bad then
	if n > maximum then
	    err("value too large");
	    bad := true;
	else
	    pNum* := n;
	fi;
    fi;
    if bad then
	inputPtr* := '\e';
    fi;
    ES*.es_textInPos := inputPtr;
    not bad
corp;

/*
 * reqPosRange1 - req a number within a given range, with 1 decimal digit.
 */

proc reqPosRange1(*uint pNum; uint maximum; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getPosRange1(pNum, maximum)
	    fi
	do
	od;
	gotOne
    else
	getPosRange1(pNum, maximum)
    fi
corp;

/*
 * getPair - get a coordinate pair.
 */

proc getPair(*int pA, pB)bool:
    register char ch;

    if getNumber(pA) then
	ch := ES*.es_textInPos*;
	if ch = ':' then
	    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    getNumber(pB)
	elif ch = ',' or ch = '?' or ch = ' ' or
	    ch = '\t' or ch = '/' or ch = '\e'
	then
	    pB* := pA*;
	    true
	else
	    err("missing ':' for coordinate pair");
	    ES*.es_textInPos* := '\e';
	    false
	fi
    else
	false
    fi
corp;

/*
 * getBox - get a pair of sector designations (a rectangle).
 */

proc getBox(*int pA, pB, pC, pD)bool:
    register uint i;
    register char ch;

    if ES*.es_textInPos* = '\#' then
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	ch := ES*.es_textInPos*;
	if ch >= '0' and ch < '0' + REALM_MAX or ch = '\e' or
	    ch = ' ' or ch = '\t' or ch = '/' or ch = '?'
	then
	    if ch >= '0' and ch < '0' + REALM_MAX then
		i := ch - '0';
		ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    else
		i := 0;
	    fi;
	    pA* := ES*.es_country.c_realms[i].r_top;
	    pB* := ES*.es_country.c_realms[i].r_bottom;
	    pC* := ES*.es_country.c_realms[i].r_left;
	    pD* := ES*.es_country.c_realms[i].r_right;
	fi;
	ch := ES*.es_textInPos*;
	if ch ~= ' ' and ch ~= '\e' and ch ~= '\t' and ch ~= '/' and ch ~= '?'
	then
	    err("illegal characters in realm");
	    ES*.es_textInPos* := '\e';
	    false
	else
	    true
	fi
    elif getPair(pA, pB) then
	if ES*.es_textInPos* = ',' then
	    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    if getPair(pC, pD) then
		if pA* > pB* then
		    err("top > bottom");
		    false
		elif pC* > pD* then
		    err("right > left");
		    false
		else
		    true
		fi
	    else
		false
	    fi
	else
	    err("missing ',' for sectors specification");
	    ES*.es_textInPos* := '\e';
	    false
	fi
    else
	false
    fi
corp;

/*
 * reqBox - get (prompting for if necessary) a rectangle specification.
 */

proc reqBox(*int pA, pB, pC, pD; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getBox(pA, pB, pC, pD)
	    fi
	do
	od;
	gotOne
    else
	getBox(pA, pB, pC, pD)
    fi
corp;

/*
 * getSector - get a coordinate pair.
 */

proc getSector(*int pA, pB)bool:

    if getNumber(pA) then
	if ES*.es_textInPos* = ',' then
	    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    getNumber(pB)
	else
	    err("missing ',' for sector number");
	    ES*.es_textInPos* := '\e';
	    false
	fi
    else
	false
    fi
corp;

/*
 * reqSector - get (prompting if needed) a single sector spec.
 */

proc reqSector(*int pA, pB; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getSector(pA, pB)
	    fi
	do
	od;
	gotOne
    else
	getSector(pA, pB)
    fi
corp;

/*
 * reqChar - get (prompting if needed) a character in the given set.
 */

proc reqChar(*char pChar; register *char validSet;
	     *char prompt, errMess)bool:
    register *char p;
    register char ch;

    if ES*.es_textInPos* = '\e' then
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		ch := ' ';
		false
	    else
		ch := ES*.es_textInPos*;
		ES*.es_textInPos := ES*.es_textInPos + 1;
		p := validSet;
		while p* ~= ch and p* ~= '\e' do
		    p := p + sizeof(char);
		od;
		if p* = '\e' then
		    err(errMess);
		    true
		else
		    false
		fi
	    fi
	do
	od;
	pChar* := ch;
	ch ~= ' '
    else
	ch := ES*.es_textInPos*;
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	while validSet* ~= ch and validSet* ~= '\e' do
	    validSet := validSet + sizeof(char);
	od;
	if validSet* = '\e' then
	    err(errMess);
	    false
	else
	    pChar* := ch;
	    if ES*.es_textInPos* ~= '\e' and ES*.es_textInPos* ~= ' ' and
		ES*.es_textInPos* ~= '\t'
	    then
		err("excess characters after type on command line");
		false
	    else
		true
	    fi
	fi
    fi
corp;

/*
 * reqCmsgpob - get (prompting if needed) a cmsgpob type.
 */

proc reqCmsgpob(*ItemType_t pWhich; *char prompt)bool:
    char ch;

    if reqChar(&ch, &ES*.es_itemChar[0], prompt, "invalid item type") then
	pWhich* := getIndex(&ES*.es_itemChar[0], ch) + it_first;
	true
    else
	false
    fi
corp;

/*
 * reqDesig - get (prompting if needed) a sector designation character.
 */

proc reqDesig(*SectorType_t pDesig; *char prompt)bool:
    char ch;

    if reqChar(&ch, &ES*.es_sectorChar[0], prompt,
	       "invalid sector designation")
    then
	pDesig* := getIndex(&ES*.es_sectorChar[0], ch) + s_first;
	true
    else
	false
    fi
corp;

/*
 * reqShipType - get a ship type character.
 */

proc reqShipType(*ShipType_t pType; *char prompt)bool:
    char ch;

    if reqChar(&ch, &ES*.es_shipChar[0], prompt, "invalid ship type") then
	pType* := getIndex(&ES*.es_shipChar[0], ch) + st_first;
	true
    else
	false
    fi
corp;

/*
 * reqBridgeDirection - get a bridge span building direction.
 */

proc reqBridgeDirection(*char pDir, prompt)bool:

    reqChar(pDir, "udlr", prompt, "invalid span direction")
corp;

/*
 * getCountry - get a country name or number from the input line.
 */

proc getCountry(*uint pCountry; bool visitorOK, blanksOK)bool:
    register *Country_t rc;
    *char name, p;
    int n;
    register uint n1;

    if ES*.es_textInPos* = '\e' then
	false
    elif ES*.es_textInPos* >= '0' and ES*.es_textInPos* <= '9' then
	if getNumber(&n) then
	    n1 := n;
	    if n >= 0 and n1 < ES*.es_world.w_currCountries then
		server(rt_readCountry, n1);
		rc := &ES*.es_request.rq_u.ru_country;
		if rc*.c_status ~= cs_deity and rc*.c_status ~= cs_active and
		    (rc*.c_status ~= cs_visitor or not visitorOK) and
		    ES*.es_country.c_status ~= cs_deity
		then
		    err("that country is not active");
		    false
		else
		    pCountry* := n1;
		    true
		fi
	    elif ES*.es_country.c_status = cs_deity and n >= 0 and
		n1 < ES*.es_world.w_maxCountries
	    then
		pCountry* := n1;
		user(
		 "\n\n*** Warning - this country is still inactive ***\n\n\n");
		true
	    else
		err("country number out of range");
		false
	    fi
	else
	    false
	fi
    else
	name := ES*.es_textInPos;
	if not blanksOK then
	    p := skipWord();
	    ignore skipBlanks();
	    p* := '\e';
	fi;
	n1 := 0;
	while
	    if n1 >= ES*.es_world.w_currCountries then
		false
	    else
		server(rt_readCountry, n1);
		rc := &ES*.es_request.rq_u.ru_country;
		not CharsEqual(&rc*.c_name[0], name)
	    fi
	do
	    n1 := n1 + 1;
	od;
	if n1 = ES*.es_world.w_currCountries then
	    err("no country by that name");
	    false
	else
	    if rc*.c_status ~= cs_deity and rc*.c_status ~= cs_active and
		(rc*.c_status ~= cs_visitor or not visitorOK) and
		ES*.es_country.c_status ~= cs_deity
	    then
		err("that country is not active");
		false
	    else
		pCountry* := n1;
		true
	    fi
	fi
    fi
corp;

/*
 * reqCountry - get (promting if needed) a country name or number.
 */

proc reqCountry(*uint pCountry; *char prompt; bool visitorOK)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getCountry(pCountry, visitorOK, true)
	    fi
	do
	od;
	gotOne
    else
	getCountry(pCountry, visitorOK, false)
    fi
corp;

/*
 * getChoice - see below.
 */

proc getChoice(*uint pWhat; *char choices)bool:
    *char p, q;
    uint result;

    p := ES*.es_textInPos;
    q := skipWord();
    ignore skipBlanks();
    q* := '\e';
    result := lookupCommand(choices, p);
    if result = 0 then
	err("unknown 'what'");
	false
    elif result = 1 then
	err("ambiguous 'what'");
	false
    else
	pWhat* := result - 2;
	true
    fi
corp;

/*
 * reqChoice - get and check a word from a given set of choices. Just complain
 *	if it's from the command line, else prompt for a correct one. Return
 *	'true' if we get a correct choice and set the 'what' parameter to the
 *	index of the choice in choices (0 origin).
 */

proc reqChoice(*uint pWhat;
	       *char choices, prompt)bool:
    bool quit, gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getChoice(pWhat, choices)
	    fi
	do
	od;
	gotOne
    else
	getChoice(pWhat, choices)
    fi
corp;

/*
 * getShip - get a ship number from the input line.
 */

proc getShip(*uint pShip)bool:
    int n;
    uint n1;

    if ES*.es_textInPos* = '\e' then
	false
    else
	if getNumber(&n) then
	    n1 := n;
	    if n >= 0 and n1 < ES*.es_world.w_shipNext then
		pShip* := n1;
		true
	    else
		err("ship number out of range");
		false
	    fi
	else
	    false
	fi
    fi
corp;

/*
 * reqShip - get (promting if needed) a ship number.
 */

proc reqShip(*uint pShip; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getShip(pShip)
	    fi
	do
	od;
	gotOne
    else
	getShip(pShip)
    fi
corp;

/*
 * getSectorOrShip - get a sector or ship spec.
 */

proc getSectorOrShip(*int pA, pB;
		     *uint pS; *bool pIsShip)bool:
    register *char p;

    p := ES*.es_textInPos;
    if p* = '-' then
	/* has to be a sector spec */
	pIsShip* := false;
	getSector(pA, pB)
    else
	while p* >= '0' and p* <= '9' do
	    p := p + sizeof(char);
	od;
	if p* = ',' then
	    pIsShip* := false;
	    getSector(pA, pB)
	else
	    pIsShip* := true;
	    getShip(pS)
	fi
    fi
corp;

/*
 * reqSectorOrShip - get (prompting if needed) a single sector or ship spec.
 */

proc reqSectorOrShip(*int pA, pB; *uint pS;
		     *bool pIsShip; *char prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getSectorOrShip(pA, pB, pS, pIsShip)
	    fi
	do
	od;
	gotOne
    else
	getSectorOrShip(pA, pB, pS, pIsShip)
    fi
corp;

/*
 * getShipOrFleet - get a ship number or fleet letter.
 */

proc getShipOrFleet(*uint pShipNumber; *char pFleet)bool:
    register char ch;

    ch := ES*.es_textInPos*;
    if ch >= '0' and ch <= '9' then
	pFleet* := ' ';
	if getShip(pShipNumber) then
	    ch := ES*.es_textInPos*;
	    if ch = ' ' or ch = '\t' or ch = '\e' then
		true
	    else
		err("extraneous characters after ship number");
		false
	    fi
	else
	    false
	fi
    elif ch >= 'a' and ch <= 'z' or ch >= 'A' and ch <= 'Z' or ch = '*' then
	pFleet* := ch;
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	true
    else
	err("invalid fleet character");
	ES*.es_textInPos* := '\e';
	false
    fi
corp;

/*
 * reqShipOrFleet - request a ship number or fleet letter. Return a fleet
 *	letter of ' ' if a ship number is given.
 */

proc reqShipOrFleet(*uint pShipNumber; *char pFleet, prompt)bool:
    bool gotOne;

    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getShipOrFleet(pShipNumber, pFleet)
	    fi
	do
	od;
	gotOne
    else
	getShipOrFleet(pShipNumber, pFleet)
    fi
corp;
