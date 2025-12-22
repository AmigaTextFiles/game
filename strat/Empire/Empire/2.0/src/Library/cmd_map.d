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
 * near - return true if the addressed sector is near one owned by the given
 *	country.
 */

proc near(register int r, c; register uint cou; register *uint dir)bool:
    register *Sector_t s;
    uint dummy;
    register bool noDir;

    if dir = nil then
	noDir := true;
	dir := &dummy;
    else
	noDir := false;
    fi;
    s := &ES*.es_request.rq_u.ru_sector;
    server(rt_readSector, mapSector(r, c + 1));
    if s*.s_owner = cou and (noDir or s*.s_quantity[it_military] ~= 0) then
	dir* := 2;
	true
    else
	server(rt_readSector, mapSector(r, c - 1));
	if s*.s_owner = cou and (noDir or s*.s_quantity[it_military] ~= 0) then
	    dir* := 6;
	    true
	else
	    server(rt_readSector, mapSector(r + 1, c - 1));
	    if s*.s_owner = cou and (noDir or s*.s_quantity[it_military] ~= 0)
	    then
		dir* := 5;
		true
	    else
		server(rt_readSector, mapSector(r + 1, c));
		if s*.s_owner = cou and
		    (noDir or s*.s_quantity[it_military] ~= 0)
		then
		    dir* := 4;
		    true
		else
		    server(rt_readSector, mapSector(r + 1, c + 1));
		    if s*.s_owner = cou and
			(noDir or s*.s_quantity[it_military] ~= 0)
		    then
			dir* := 3;
			true
		    else
			server(rt_readSector,mapSector(r - 1, c - 1));
			if s*.s_owner = cou and
			    (noDir or s*.s_quantity[it_military] ~= 0)
			then
			    dir* := 7;
			    true
			else
			    server(rt_readSector, mapSector(r - 1, c));
			    if s*.s_owner = cou and
				(noDir or s*.s_quantity[it_military] ~= 0)
			    then
				dir* := 0;
				true
			    else
				server(rt_readSector,
				       mapSector(r - 1, c + 1));
				if s*.s_owner = cou and
				    (noDir or s*.s_quantity[it_military] ~= 0)
				then
				    dir* := 1;
				    true
				else
				    false
				fi
			    fi
			fi
		    fi
		fi
	    fi
	fi
    fi
corp;

/*
 * digit printing routines for mapping.
 */

/* digit0 - print the high digit of a 3 digit row or column number */

proc digit0(register int x)void:

    userC(
	if x <= -100 then
	    -x / 100 + '0'
	elif x < 0 then
	    '-'
	else
	    x / 100 + '0'
	fi
    );
corp;

/* colDigit1 - print the middle digit of a column number */

proc colDigit1(register int c)void:

    if ES*.es_bool3 then
	userC(|c / 10 % 10 + '0');
    else
	userC(
	    if c <= -10 then
		-c / 10 + '0'
	    elif c < 0 then
		'-'
	    else
		c / 10 + '0'
	    fi
	);
    fi;
corp;

/* digit2 - print the low digit of a row or column number */

proc digit2(int x)void:

    userC(|x % 10 + '0');
corp;

/* doDigit - print a line of one digit of the column numbers */

proc doDigit(uint which; int left, right;
	     bool extraSpace)void:
    register int c;

    user(if extraSpace then "   " else "  " fi);
    if ES*.es_bool2 then
	userSp();
    fi;
    for c from left upto right do
	if not ES*.es_bool1 then
	    userSp();
	fi;
	case which
	incase 0:
	    digit0(c);
	incase 1:
	    colDigit1(c);
	incase 2:
	    digit2(c);
	esac;
	if extraSpace then
	    userSp();
	fi;
    od;
    userNL();
corp;

/* coords - print 2 or 3 lines of column numbers */

proc coords(int left, right; bool extraSpace)void:

    if ES*.es_bool3 then
	doDigit(0, left, right, extraSpace);
    fi;
    doDigit(1, left, right, extraSpace);
    doDigit(2, left, right, extraSpace);
corp;

/*
 * doMap - part of cmd_map - called by scanning code
 */

proc doMap(int r, c; register *Sector_t s)void:
    SectorType_t desig;
    register char ch;

    desig := s*.s_type;
    ch := ES*.es_sectorChar[desig];
    if ES*.es_country.c_status = cs_deity and desig = s_water then
	ch := ' ';
    fi;
    if not ES*.es_bool1 then
	userSp();
    fi;
    userC(ch);
corp;

/*
 * special routines called if we set the map hook.
 */

/* setSizes - determine row and column number sizes based on the range
	given to us by the scanning code */

proc setSizes(int top, bottom, left, right)void:

    ES*.es_bool2 := | top >= 100 or | bottom >= 100;
    ES*.es_bool3 := | left >= 100 or | right >= 100;
corp;

/* mapCoords - print header or trailer column numbers for a map */

proc mapCoords(int left, right)void:

    coords(left, right, false);
corp;

/* rowDigit1 - print the middle digit of a row number */

proc rowDigit1(register int r)void:

    if ES*.es_bool2 then
	userC(|r / 10 % 10 + '0');
    else
	userC(
	    if r <= -10 then
		-r / 10 + '0'
	    elif r < 0 then
		'-'
	    else
		r / 10 + '0'
	    fi
	);
    fi;
corp;

/* digits - print 2 or 3 digits of a row number */

proc digits(int r)void:

    if ES*.es_bool2 then
	digit0(r);
    fi;
    rowDigit1(r);
    digit2(r);
corp;

/* mapRowStart - scanning code calls this to print beginning of map line */

proc mapRowStart(int r)void:

    digits(r);
corp;

/* mapRowEnd - scanning code calls this to print end of map line */

proc mapRowEnd(int r)void:

    if not ES*.es_bool1 then
	userSp();
    fi;
    digits(r);
    userNL();
corp;

/* mapEmpty - scanning code calls this to print an unknown map sector */

proc mapEmpty()void:

    if ES*.es_bool1 then
	userSp();
    else
	user("  ");
    fi;
corp;

/*
 * readRow - part of 'doSimpleMap'
 */

proc readRow(register int r, c1, c2; *[256 * 2 + 4] bool pOwn;
	     *[256 * 2 + 4] char pChar)void:
    register *Sector_t rs;
    register int c;

    rs := &ES*.es_request.rq_u.ru_sector;
    for c from c1 upto c2 do
	server(rt_readSector, mapSector(r, c));
	pChar*[c - c1] := ES*.es_sectorChar[rs*.s_type];
	if rs*.s_owner = ES*.es_countryNumber or
	    ES*.es_country.c_status = cs_deity
	then
	    pOwn*[c - c1] := true;
	    if rs*.s_type = s_water and ES*.es_country.c_status = cs_deity then
		pChar*[c - c1] := ' ';
	    fi;
	else
	    pOwn*[c - c1] := false;
	    if rs*.s_type ~= s_mountain and rs*.s_owner ~= 0 then
		pChar*[c - c1] := '?';
	    fi;
	fi;
    od;
corp;

/*
 * doSimpleMap - do mapping assuming there were no conditions on the region
 *	given. This means that all sectors we can see will be shown.
 */

proc doSimpleMap(register *SectorScan_t ss)void:
    register *Sector_t rs;
    register int r, c, r1, c1;
    int count;
    [256 * 2 + 4] bool ownNext, ownThis, ownPrev;
    [256 * 2 + 4] char charNext, charThis;
    bool abort;

    if ss*.ss_cs.cs_boxRight - ss*.ss_cs.cs_boxLeft >= 256 * 2 + 4 then
	/* I won't bother trying to do this right - if the columns requested
	   are too large, I just trim the right one down. */
	ss*.ss_cs.cs_boxRight := ss*.ss_cs.cs_boxLeft + (256 * 2 + 4 - 1);
    fi;
    rs := &ES*.es_request.rq_u.ru_sector;
    r1 := ss*.ss_cs.cs_boxTop - 1;
    c1 := ss*.ss_cs.cs_boxLeft - 1;
    for c from c1 upto ss*.ss_cs.cs_boxRight + 1 do
	server(rt_readSector, mapSector(r1, c));
	ownThis[c - c1] := rs*.s_owner = ES*.es_countryNumber;
    od;
    readRow(ss*.ss_cs.cs_boxTop, c1, ss*.ss_cs.cs_boxRight + 1,
	    &ownNext, &charNext);
    setSizes(ss*.ss_cs.cs_boxTop, ss*.ss_cs.cs_boxBottom,
	     ss*.ss_cs.cs_boxLeft, ss*.ss_cs.cs_boxRight);
    coords(ss*.ss_cs.cs_boxLeft, ss*.ss_cs.cs_boxRight, false);
    userNL();
    count := ss*.ss_cs.cs_boxRight - ss*.ss_cs.cs_boxLeft + 1;
    r := ss*.ss_cs.cs_boxTop;
    abort := false;
    while not abort and r <= ss*.ss_cs.cs_boxBottom do
	ownPrev := ownThis;
	ownThis := ownNext;
	charThis := charNext;
	readRow(r + 1, c1, ss*.ss_cs.cs_boxRight + 1, &ownNext, &charNext);
	mapRowStart(r);
	for c from 1 upto count do
	    if not ES*.es_bool1 then
		userSp();
	    fi;
	    if ES*.es_country.c_status = cs_deity or
		ownThis[c] or ownThis[c - 1] or ownThis[c + 1] or
		ownPrev[c - 1] or ownPrev[c] or ownPrev[c + 1] or
		ownNext[c - 1] or ownNext[c] or ownNext[c + 1]
	    then
		userC(charThis[c]);
	    else
		userSp();
	    fi;
	od;
	mapRowEnd(r);
	r := r + 1;
	abort := ES*.es_gotControlC();
    od;
    if not abort then
	userNL();
	coords(ss*.ss_cs.cs_boxLeft, ss*.ss_cs.cs_boxRight, false);
    fi;
corp;

/* cmd_map - top level entry for mapping code */

proc cmd_map()bool:
    SectorScan_t ss;
    *char p;
    bool failed;

    if reqSectors(&ss, "Enter sectors specification for map: ") then
	ES*.es_bool1 := false;
	failed := false;
	p := skipBlanks();
	if p* ~= '\e' then
	    skipWord()* := '\e';
	    if CharsEqual(p, "compressed") then
		ES*.es_bool1 := true;
	    else
		err("invalid flag on 'map' - only 'compressed' allowed");
		failed := true;
	    fi;
	fi;
	if failed then
	    false
	else
	    if ss.ss_cs.cs_conditionCount = 0 then
		doSimpleMap(&ss);
	    else
		ss.ss_mapHook := true;
		setSizes(ss.ss_cs.cs_boxTop, ss.ss_cs.cs_boxBottom,
			 ss.ss_cs.cs_boxLeft, ss.ss_cs.cs_boxRight);
		ignore scanSectors(&ss, doMap);
	    fi;
	    true
	fi
    else
	false
    fi
corp;

proc cmd_route()bool:
    [9] char
	TRANS_LEFT  = ('^', ' ', ' ', ' ', 'v', '/', '<','\\', ' '),
	TRANS_RIGHT = ('^', '/', '>','\\', 'v', ' ', ' ', ' ', ' ');
    SectorScan_t ss;
    register *Sector_t s;
    register int r, c;
    int left, right, top, bottom;
    ushort trans;
    ItemType_t what;
    bool abort;

    if reqCmsgpob(&what, "Enter type of thing to map routes for: ") and
	doSkipBlanks() and
	reqBox(&top, &bottom, &left, &right,
	       "Enter sectors specification for route map: ")
    then
	ES*.es_bool1 := false;
	setSizes(top, bottom, left, right);
	coords(left, right, true);
	userNL();
	s := &ES*.es_request.rq_u.ru_sector;
	r := top;
	abort := false;
	while not abort and r <= bottom do
	    digits(r);
	    userSp();
	    for c from left upto right do
		server(rt_readSector, mapSector(r, c));
		if ES*.es_country.c_status ~= cs_deity and
		    s*.s_owner ~= ES*.es_countryNumber
		then
		    user("   ");
		else
		    trans := s*.s_direction[what];
		    userC(TRANS_LEFT[trans]);
		    userC(ES*.es_sectorChar[s*.s_type]);
		    userC(TRANS_RIGHT[trans]);
		fi;
	    od;
	    userSp();
	    digits(r);
	    userNL();
	    r := r + 1;
	    abort := ES*.es_gotControlC();
	od;
	if not abort then
	    userNL();
	    coords(left, right, true);
	fi;
	true
    else
	false
    fi
corp;

/*
 * doRadar -
 *	given a position and a range (x 1000), do a radar scan from there.
 */

proc doRadar(int rRow, rCol;
	     uint rang; bool hasSonar)void:
    uint MAX_RANGE = 20;
    [MAX_RANGE * 2 + 1, MAX_RANGE * 2 + 1] char map;
    [MAX_RANGE * 2 + 1, MAX_RANGE * 2 + 1] uint biggestShip;
    register *Sector_t s;
    Ship_t sh;
    uint range1, rangeSq, distance, shipNumber, size;
    register int r, c;
    int top, bottom, left, right;
    SectorType_t desig;
    char ch;

    range1 := min(MAX_RANGE, rang / 1000 + 1);
    top := rRow - range1;
    bottom := rRow + range1;
    left := rCol - range1;
    right := rCol + range1;
    rangeSq := make(rang, ulong) * rang / (1000 * 1000);

    /* first, fill in the map with terrain values */

    s := &ES*.es_request.rq_u.ru_sector;
    for r from top upto bottom do
	for c from left upto right do
	    distance := findDistance(r, c, rRow, rCol);
	    if distance <= rangeSq then
		server(rt_readSector, mapSector(r, c));
		desig := s*.s_type;
		if desig ~= s_mountain and s*.s_owner ~= 0 and
		    s*.s_owner ~= ES*.es_countryNumber and
		    distance > rangeSq / 4
		then
		    ch := '?';
		else
		    ch := ES*.es_sectorChar[desig];
		fi;
	    else
		ch := ' ';
	    fi;
	    map[range1 + r - rRow, range1 + c - rCol] := ch;
	    biggestShip[range1 + r - rRow, range1 + c - rCol] := 0;
	od;
    od;

    /* next, fill in all ships that are in range */

    if ES*.es_world.w_shipNext ~= 0 then
	for shipNumber from 0 upto ES*.es_world.w_shipNext - 1 do
	    server(rt_readShip, shipNumber);
	    sh := ES*.es_request.rq_u.ru_ship;
	    if sh.sh_owner ~= 0 then		/* wrecks don't show up */
		r := rowToMe(sh.sh_row);
		if r >= rRow + ES*.es_world.w_rows / 2 then
		    r := r - ES*.es_world.w_rows;
		elif r <= rRow - ES*.es_world.w_rows / 2 then
		    r := r + ES*.es_world.w_rows;
		fi;
		c := colToMe(sh.sh_col);
		if c >= rCol + ES*.es_world.w_columns / 2 then
		    c := c - ES*.es_world.w_columns;
		elif c <= rCol - ES*.es_world.w_columns / 2 then
		    c := c + ES*.es_world.w_columns;
		fi;
		distance := findDistance(r, c, rRow, rCol);
		size := ES*.es_world.w_shipSize[sh.sh_type];
		if sh.sh_type = st_submarine then
		    size := if hasSonar then 15 else 0 fi;
		fi;
		if distance <= make(rangeSq, ulong) * size * size / 1018 then
		    if sh.sh_type ~= st_submarine then
			server(rt_readCountry, sh.sh_owner);
			user(&ES*.es_request.rq_u.ru_country.c_name[0]);
			userSp();
		    fi;
		    user(getShipName(sh.sh_type));
		    userN3(" \#", shipNumber, " at ");
		    userN(r);
		    userN3(",", c, "\n");
		    r := range1 + r - rRow;
		    c := range1 + c - rCol;
		    if size > biggestShip[r, c] then
			biggestShip[r, c] := size;
			if map[r, c] = ES*.es_sectorChar[s_water] then
			    map[r, c] := ES*.es_shipChar[sh.sh_type] - 32;
			fi;
		    fi;
		fi;
	    fi;
	od;
    fi;

    /* now display the resulting map */

    ES*.es_bool1 := false;
    setSizes(top, bottom, left, right);
    coords(left, right, false);
    userNL();
    for r from top upto bottom do
	digits(r);
	for c from left upto right do
	    userSp();
	    userC(map[range1 + r - rRow, range1 + c - rCol]);
	od;
	userSp();
	digits(r);
	userNL();
    od;
    userNL();
    coords(left, right, false);
corp;

proc cmd_radar()bool:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    int row, col;
    uint shipNumber;
    bool isShip;

    if reqSectorOrShip(&row, &col, &shipNumber, &isShip,
		       "Enter sector or ship to scan from: ")
    then
	if isShip then
	    server(rt_readShip, shipNumber);
	    if ES*.es_request.rq_u.ru_ship.sh_owner ~= ES*.es_countryNumber
	    then
		err("that ship doesn't belong to you");
	    else
		accessShip(shipNumber);
		rsh := &ES*.es_request.rq_u.ru_ship;
		doRadar(rowToMe(rsh*.sh_row), colToMe(rsh*.sh_col),
			make(ES*.es_world.w_shipRange[rsh*.sh_type], ulong) *
			    rsh*.sh_efficiency *
			    (100 - (100 - getShipTechFactor(rsh)) / 2) / 100,
			rsh*.sh_type = st_destroyer or
			    rsh*.sh_type = st_submarine);
	    fi;
	else
	    accessSector(row, col);
	    rs := &ES*.es_request.rq_u.ru_sector;
	    if rs*.s_owner ~= ES*.es_countryNumber then
		err("that sector doesn't belong to you");
	    elif rs*.s_type ~= s_radar then
		err("that sector isn't a radar station");
	    else
		doRadar(row, col, make(rs*.s_efficiency, ulong) *
			    ES*.es_world.w_radarFactor *
			    (100 -
			     (100 -getTechFactor(ES*.es_countryNumber)) / 2) /
			    100,
			false);
	    fi;
	fi;
	true
    else
	false
    fi
corp;

proc showWeather(int r, c)void:
    register int wea;

    wea := weather(rowToAbs(r), colToAbs(c));
    if wea < -9 then
	userC('-');
	userC(-wea - 10 + 'A');
    elif wea > 9 then
	userC('+');
	userC(wea - 10 + 'A');
    elif wea > 0 then
	userC('+');
	userN(wea);
    else
	if wea >= 0 then
	    userSp();
	fi;
	userN(wea);
    fi;
corp;

proc weatherExtremes()void:

    userN3("Extreme low pressure center at ",
	   rowToMe(ES*.es_world.w_weather.we_loRow / 4), ",");
    userN(colToMe(ES*.es_world.w_weather.we_loCol / 4));
    userN3(", extreme high at ",
	   rowToMe(ES*.es_world.w_weather.we_hiRow / 4), ",");
    userN(colToMe(ES*.es_world.w_weather.we_hiCol / 4));
    user(".\n");
corp;

proc cmd_weather()void:
    register int r, c;
    int top, bottom, left, right, w;
    bool abort;

    if reqBox(&top, &bottom, &left, &right, "Enter region to map: ") then
	ES*.es_bool1 := false;
	setSizes(top, bottom, left, right);
	coords(left, right, false);
	userNL();
	r := top;
	abort := false;
	while not abort and r <= bottom do
	    digits(r);
	    for c from left upto right do
		showWeather(r, c);
	    od;
	    userSp();
	    digits(r);
	    userNL();
	    r := r + 1;
	    abort := ES*.es_gotControlC();
	od;
	if not abort then
	    userNL();
	    coords(left, right, false);
	fi;
	weatherExtremes();
    fi;
corp;

proc cmd_forecast()bool:
    register *Sector_t rs;
    uint time, rang, range1, rangeSq, distance;
    register int r, c;
    int top, bottom, left, right, wRow, wCol, wea;

    if reqSector(&wRow, &wCol, "Sector of weather station? ") and
	doSkipBlanks() and
	reqPosRange(&time, 127,
		    "How many half-hours in the future? ")
    then
	accessSector(wRow, wCol);
	rs := &ES*.es_request.rq_u.ru_sector;
	if rs*.s_owner ~= ES*.es_countryNumber then
	    err("you don't own that sector");
	elif rs*.s_type ~= s_weather then
	    err("sector isn't a weather station");
	elif rs*.s_efficiency < 60 then
	    err("station isn't efficient enough for forecasting");
	elif time > getTechFactor(ES*.es_countryNumber) then
	    err("your country is not capable of that distant a forecast");
	elif time > readQuan(rs, it_civilians) then
	    err("not enough workers for that distant a forecast");
	else
	    ES*.es_wTemp := ES*.es_world.w_weather;
	    while time ~= 0 do
		time := time - 1;
		weatherStep();
	    od;
	    rang := make(rs*.s_efficiency, uint) * 70;
	    range1 := rang / 1000 + 1;
	    top := wRow - range1;
	    bottom := wRow + range1;
	    left := wCol - range1;
	    right := wCol + range1;
	    rangeSq := make(rang, ulong) * rang / (1000 * 1000);
	    ES*.es_bool1 := false;
	    setSizes(top, bottom, left, right);
	    coords(left, right, false);
	    userNL();
	    for r from top upto bottom do
		digits(r);
		for c from left upto right do
		    if findDistance(r, c, wRow, wCol) <= rangeSq then
			showWeather(r, c);
		    else
			user("  ");
		    fi;
		od;
		userSp();
		digits(r);
		userNL();
	    od;
	    userNL();
	    coords(left, right, false);
	    weatherExtremes();
	    ES*.es_world.w_weather := ES*.es_wTemp;
	fi;
	true
    else
	false
    fi
corp;
