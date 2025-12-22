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

/* negative codes for a unit to be compared: */

int
    U_EFFICIENCY	= -1,
    U_MOBILITY		= -2,
    U_DEFENDED		= -3,
    U_MILITARY		= -4,
    U_PLANES		= -5,
    U_MINERALS		= -6,
    U_PRODUCTION	= -7,
    U_CONTRACTED	= -8,
    U_SHELLS		= -9,
    U_ORE		= -10,
    U_GOLD		= -11,
    U_CHECKPOINT	= -12,
    U_CIVILIANS 	= -13,
    U_GUNS		= -14,
    U_BARS		= -15,
    U_DESIGNATION	= -16,
    U_OWNER		= -17;

*char UNITS =
    "efficiency\e"
    "mobility\e"
    "defended\e"
    "military\e"
    "planes\e"
    "minerals\e"
    "production\e"
    "contracted\e"
    "shells\e"
    "ore\e"
    "gold\e"
    "checkpoint\e"
    "civilians\e"
    "guns\e"
    "bars\e"
    "designation\e"
    "owner\e";

/*
 * member -
 *	return true if character is in string
 */

proc member(register *char set; register char element)bool:

    while set* ~= '\e' and set* ~= element do
	set := set + sizeof(char);
    od;
    set* = element
corp;

/*
 * getValue -
 *	get a value for a condition.
 */

proc getValue(register *ConditionSet_t cs;
	      bool isRight, isShip)bool:
    register *char inputPtr;
    *char p;
    uint res;
    register int valu;
    char ch;
    register bool ok;

    inputPtr := ES*.es_textInPos;
    ok := true;
    if inputPtr* >= '0' and inputPtr* <= '9' then
	/* a simple numeric value */
	valu := 0;
	while inputPtr* >= '0' and inputPtr* <= '9' do
	    valu := valu * 10 + (inputPtr* - '0');
	    inputPtr := inputPtr + sizeof(char);
	od;
    elif (inputPtr + 1)* < 'a' or (inputPtr + 1)* > 'z' then
	/* assume its a one-character designation character */
	ch := inputPtr*;
	inputPtr := inputPtr + sizeof(char);
	if isShip then
	    if not member(&ES*.es_shipChar[0], ch) then
		err("invalid ship designation in condition");
		ok := false;
	    else
		valu := getIndex(&ES*.es_shipChar[0], ch);
	    fi;
	else
	    if not member(&ES*.es_sectorChar[0], ch) then
		err("invalid sector designation in condition");
		ok := false;
	    else
		valu := getIndex(&ES*.es_sectorChar[0], ch);
	    fi;
	fi;
    else
	p := inputPtr;
	while inputPtr* >= 'a' and inputPtr* <= 'z' do
	    inputPtr := inputPtr + sizeof(char);
	od;
	ch := inputPtr*;
	inputPtr* := '\e';
	res := lookupCommand(UNITS, p);
	if res = 0 then
	    err("invalid unit in condition");
	    ok := false;
	elif res = 1 then
	    err("ambiguous unit in condition");
	    ok := false;
	else
	    inputPtr* := ch;
	    valu := 1 - make(res, int);
	fi;
    fi;
    if ok then
	if isRight then
	    cs*.cs_condition[cs*.cs_conditionCount].c_right := valu;
	else
	    cs*.cs_condition[cs*.cs_conditionCount].c_left := valu;
	fi;
    fi;
    ES*.es_textInPos := inputPtr;
    ok
corp;

/*
 * getOperator -
 *	get a valid condition operator.
 */

proc getOperator(*ConditionSet_t cs)bool:
    register char ch;

    ch := ES*.es_textInPos*;
    if ch = '<' or ch = '>' or ch = '=' or ch = '\#' then
	cs*.cs_condition[cs*.cs_conditionCount].c_operator := ch;
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	true
    else
	err("invalid operator in condition");
	false
    fi
corp;

/*
 * parseConditions -
 *	parse a set of conditions from the command line, and store them into
 *	the condition array. 'isShip' is true if we want conditions that will
 *	apply to ship (some limitations). We return 'true' if all went well.
 */

proc parseConditions(register *ConditionSet_t cs;
		     bool isShip)bool:
    char operator, desig;
    register char ch;
    bool done, hadError;

    ch := ES*.es_textInPos*;
    if ch = '/' then
	/* special case, allow '/x' to mean '?des=x' */
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	cs*.cs_conditionCount := 0;
	cs*.cs_condition[0].c_left := U_DESIGNATION;
	cs*.cs_condition[0].c_operator := '=';
	if getValue(cs, true, isShip) then
	    if cs*.cs_condition[0].c_right < 0 then
		err("must use designation letter with '/'");
		false
	    else
		cs*.cs_conditionCount := 1;
		true
	    fi
	else
	    false
	fi
    else
	cs*.cs_conditionCount := 0;
	if ch = '?' then
	    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    done := false;
	    hadError := false;
	    while not done and not hadError do
		ch := ES*.es_textInPos*;
		if ch = '\e' or ch = ' ' or ch = '\t' then
		    /* no more conditions */
		    done := true;
		elif cs*.cs_conditionCount = MAX_CONDITIONS then
		    err("too many conditions");
		    hadError := true;
		elif getValue(cs, false, isShip) and
		    getOperator(cs) and
		    getValue(cs, true, isShip)
		then
		    if cs*.cs_condition[cs*.cs_conditionCount].c_left =
			    U_DESIGNATION and
			cs*.cs_condition[cs*.cs_conditionCount].c_right < 0 or
			cs*.cs_condition[cs*.cs_conditionCount].c_right =
			    U_DESIGNATION and
			cs*.cs_condition[cs*.cs_conditionCount].c_left < 0
		    then
			err("invalid use of designation character");
			hadError := true;
		    elif cs*.cs_condition[cs*.cs_conditionCount].c_left>= 0 and
			cs*.cs_condition[cs*.cs_conditionCount].c_right >= 0
		    then
			err("invalid condition - no field");
			hadError := true;
		    else
			cs*.cs_conditionCount := cs*.cs_conditionCount + 1;
			ch := ES*.es_textInPos*;
			if ch = '&' then
			    ES*.es_textInPos := ES*.es_textInPos+ sizeof(char);
			elif ch ~= '\e' and ch ~= ' ' and ch ~= '\t' then
			    err("syntax error in conditions");
			    hadError := true;
			fi;
		    fi;
		else
		    hadError := true;
		fi;
	    od;
	    not hadError
	else
	    true
	fi
    fi
corp;

/*
 * getShips -
 *	get a ships specifier
 */

proc getShips(register *ShipScan_t shs)bool:
    register *char p;
    register uint shipNumber;
    register char ch;
    register bool hadError, done;

    ch := ES*.es_textInPos*;
    if ch = '?' or ch = '/' then
	shs*.shs_shipPatternType := shp_none;
	parseConditions(&shs*.shs_cs, true)
    elif ch = '*' or ch >= 'a' and ch <= 'z' or ch >= 'A' and ch <= 'Z' then
	shs*.shs_shipPatternType := shp_fleet;
	shs*.shs_shipFleet := ch;
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	parseConditions(&shs*.shs_cs, true)
    elif ch = '-' or ch = '\#' then
	shs*.shs_shipPatternType := shp_box;
	getBox(&shs*.shs_cs.cs_boxTop, &shs*.shs_cs.cs_boxBottom,
	       &shs*.shs_cs.cs_boxLeft, &shs*.shs_cs.cs_boxRight) and
	    parseConditions(&shs*.shs_cs, true)
    elif ch < '0' or ch > '9' then
	err("invalid ships specification");
	false
    else
	p := ES*.es_textInPos;
	while p* >= '0' and p* <= '9' do
	    p := p + sizeof(char);
	od;
	if p* = ',' or p* = ':' then
	    shs*.shs_shipPatternType := shp_box;
	    getBox(&shs*.shs_cs.cs_boxTop, &shs*.shs_cs.cs_boxBottom,
		   &shs*.shs_cs.cs_boxLeft, &shs*.shs_cs.cs_boxRight) and
		parseConditions(&shs*.shs_cs, true)
	else
	    /* we have a list of ship numbers separated by '/'s */
	    p := ES*.es_textInPos;
	    shs*.shs_shipPatternType := shp_list;
	    shs*.shs_shipCount := 0;
	    hadError := false;
	    done := false;
	    while not done and not hadError do
		if shs*.shs_shipCount = MAX_SHIPS then
		    err("too many ships listed");
		    hadError := true;
		elif p* < '0' or p* > '9' then
		    err("invalid ship number");
		    hadError := true;
		else
		    shipNumber := 0;
		    while p* >= '0' and p* <= '9' do
			shipNumber := shipNumber * 10 + (p* - '0');
			p := p + sizeof(char);
		    od;
		    if shipNumber >= ES*.es_world.w_shipNext then
			err("ship number too big");
			hadError := true;
		    fi;
		    shs*.shs_shipList[shs*.shs_shipCount] := shipNumber;
		    shs*.shs_shipCount := shs*.shs_shipCount + 1;
		    if p* = '/' then
			p := p + sizeof(char);
		    elif p* = '\e' or p* = '?' or p* = ' ' or p* = '\t' then
			done := true;
		    else
			err("invalid character in ship list");
			hadError := true;
		    fi;
		fi;
	    od;
	    ES*.es_textInPos := p;
	    not hadError and parseConditions(&shs*.shs_cs, true)
	fi
    fi
corp;

/*
 * reqShips - request/get a ships list
 */

proc reqShips(*ShipScan_t shs; *char prompt)bool:
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
		not getShips(shs)
	    fi
	do
	od;
	gotOne
    else
	getShips(shs)
    fi
corp;

/*
 * getShipCondVal - return the int giving the appropriate value for a ship cond
 */

proc getShipCondVal(register *ShipScan_t shs; int valu)int:

    if valu >= 0 then
	valu
    else
	case valu
	incase U_CIVILIANS:
	incase U_MILITARY:
	    make(shs*.shs_currentShip.sh_crew, int)
	incase U_SHELLS:
	    shs*.shs_currentShip.sh_shells
	incase U_GUNS:
	    shs*.shs_currentShip.sh_guns
	incase U_PLANES:
	    shs*.shs_currentShip.sh_planes
	incase U_ORE:
	    shs*.shs_currentShip.sh_ore
	incase U_BARS:
	    shs*.shs_currentShip.sh_bars
	incase U_DESIGNATION:
	    shs*.shs_currentShip.sh_type - st_first
	incase U_EFFICIENCY:
	    shs*.shs_currentShip.sh_efficiency
	incase U_MOBILITY:
	    shs*.shs_currentShip.sh_mobility
	incase U_OWNER:
	    shs*.shs_currentShip.sh_owner
	default:
	    err("unknown ship unit");
	    0
	esac
    fi
corp;

/*
 * checkShipCond -
 *	see if the setup conditions match the current ship
 */

proc checkShipCond(register *ShipScan_t shs)bool:
    register *ConditionSet_t cs;
    register uint condition;
    register int left, right;
    register bool matching;

    cs := &shs*.shs_cs;
    matching := true;
    condition := 0;
    while condition ~= cs*.cs_conditionCount and matching do
	left  := getShipCondVal(shs, cs*.cs_condition[condition].c_left);
	right := getShipCondVal(shs, cs*.cs_condition[condition].c_right);
	matching :=
	    case cs*.cs_condition[condition].c_operator
	    incase '<':
		left < right
	    incase '>':
		left > right
	    incase '=':
		left = right
	    incase '\#':
		left ~= right
	    esac;
	condition := condition + 1;
    od;
    matching
corp;

/*
 * scanShips -
 *	The actual ship scanning routine. It calls its argument proc
 *	for each ship that meets the set up specs and conditions.
 */

proc scanShips(register *ShipScan_t shs;
	proc(uint shipNumber; *Ship_t sh)void scanner)uint:
    Fleet_t fleet;
    register uint shipNumber, i, count;
    int r, c;

    count := 0;
    if ES*.es_world.w_shipNext ~= 0 then
	if shs*.shs_shipPatternType = shp_list then
	    i := 0;
	    while i ~= shs*.shs_shipCount and not ES*.es_gotControlC() do
		shipNumber := shs*.shs_shipList[i];
		server(rt_readShip, shipNumber);
		shs*.shs_currentShip := ES*.es_request.rq_u.ru_ship;
		if shs*.shs_currentShip.sh_owner = ES*.es_countryNumber or
		    ES*.es_country.c_status = cs_deity
		then
		    if checkShipCond(shs) then
			count := count + 1;
			scanner(shipNumber, &shs*.shs_currentShip);
		    fi;
		fi;
		i := i + 1;
	    od;
	elif shs*.shs_shipPatternType = shp_fleet and shs*.shs_shipFleet ~= '*'
	then
	    i := ES*.es_country.c_fleets[fleetPos(shs*.shs_shipFleet)];
	    if i = NO_FLEET then
		err("you have no such fleet");
	    else
		server(rt_readFleet, i);
		fleet := ES*.es_request.rq_u.ru_fleet;
		if fleet.f_count = 0 then
		    err("fleet has no ships");
		else
		    i := 0;
		    while i ~= fleet.f_count and not ES*.es_gotControlC() do
			server(rt_readShip, fleet.f_ship[i]);
			shs*.shs_currentShip := ES*.es_request.rq_u.ru_ship;
			if checkShipCond(shs) then
			    count := count + 1;
			    scanner(fleet.f_ship[i],&shs*.shs_currentShip);
			fi;
			i := i + 1;
		    od;
		fi;
	    fi;
	else
	    shipNumber := 0;
	    while shipNumber ~= ES*.es_world.w_shipNext and
		not ES*.es_gotControlC()
	    do
		server(rt_readShip, shipNumber);
		if ES*.es_request.rq_u.ru_ship.sh_owner =
			ES*.es_countryNumber or
		    ES*.es_country.c_status = cs_deity
		then
		    shs*.shs_currentShip := ES*.es_request.rq_u.ru_ship;
		    if
			case shs*.shs_shipPatternType
			incase shp_none:
			    true
			incase shp_box:
			    r := rowToMe(shs*.shs_currentShip.sh_row);
			    c := colToMe(shs*.shs_currentShip.sh_col);
			    r >= shs*.shs_cs.cs_boxTop and
				r <= shs*.shs_cs.cs_boxBottom and
				c >= shs*.shs_cs.cs_boxLeft and
				c <= shs*.shs_cs.cs_boxRight
			incase shp_fleet:	/* '*' fleet */
			    shs*.shs_currentShip.sh_fleet = shs*.shs_shipFleet
			esac
		    then
			if checkShipCond(shs) then
			    count := count + 1;
			    scanner(shipNumber, &shs*.shs_currentShip);
			fi;
		    fi;
		fi;
		shipNumber := shipNumber + 1;
	    od;
	fi;
    fi;
    count
corp;

/*
 * getSectors -
 *	get a sectors specifier
 */

proc getSectors(register *SectorScan_t ss)bool:

    getBox(&ss*.ss_cs.cs_boxTop, &ss*.ss_cs.cs_boxBottom,
	   &ss*.ss_cs.cs_boxLeft, &ss*.ss_cs.cs_boxRight) and
	parseConditions(&ss*.ss_cs, false)
corp;

/*
 * reqSectors - request/get a sectors specification
 */

proc reqSectors(*SectorScan_t ss;*char prompt)bool:
    bool gotOne;

    ss*.ss_mapHook := false;
    if ES*.es_textInPos* = '\e' then
	gotOne := true;
	while
	    uPrompt(prompt);
	    if not ES*.es_readUser() or ES*.es_textInPos* = '\e' then
		gotOne := false;
		false
	    else
		ignore skipBlanks();
		not getSectors(ss)
	    fi
	do
	od;
	gotOne
    else
	getSectors(ss)
    fi
corp;

/*
 * getSectCondVal -
 *	return the int giving the appropriate value for a condition.
 */

proc getSectCondVal(register *SectorScan_t ss; int valu)int:

    if valu >= 0 then
	valu
    else
	case valu
	incase U_EFFICIENCY:
	    make(ss*.ss_currentSector.s_efficiency, int)
	incase U_MOBILITY:
	    ss*.ss_currentSector.s_mobility
	incase U_DEFENDED:
	    if ss*.ss_currentSector.s_defender = NO_DEFEND then
		0
	    else
		1
	    fi
	incase U_MILITARY:
	    readQuan(&ss*.ss_currentSector, it_military)
	incase U_PLANES:
	    readQuan(&ss*.ss_currentSector, it_planes)
	incase U_MINERALS:
	    ss*.ss_currentSector.s_iron
	incase U_PRODUCTION:
	    ss*.ss_currentSector.s_production
	incase U_CONTRACTED:
	    if ss*.ss_currentSector.s_price ~= 0 then
		1
	    else
		0
	    fi
	incase U_SHELLS:
	    readQuan(&ss*.ss_currentSector, it_shells)
	incase U_ORE:
	    readQuan(&ss*.ss_currentSector, it_ore)
	incase U_GOLD:
	    ss*.ss_currentSector.s_gold
	incase U_CHECKPOINT:
	    ss*.ss_currentSector.s_checkPoint
	incase U_CIVILIANS:
	    readQuan(&ss*.ss_currentSector, it_civilians)
	incase U_GUNS:
	    readQuan(&ss*.ss_currentSector, it_guns)
	incase U_BARS:
	    readQuan(&ss*.ss_currentSector, it_bars)
	incase U_DESIGNATION:
	    ss*.ss_currentSector.s_type - s_first
	incase U_OWNER:
	    ss*.ss_currentSector.s_owner
	default:
	    err("unknown sector unit");
	    0
	esac
    fi
corp;

/*
 * checkSectCond -
 *	see if the setup conditions match the current sector
 */

proc checkSectCond(register *SectorScan_t ss)bool:
    register *ConditionSet_t cs;
    register uint condition;
    register int left, right;
    register bool matching;

    cs := &ss*.ss_cs;
    matching := true;
    condition := 0;
    while condition ~= cs*.cs_conditionCount and matching do
	left  := getSectCondVal(ss, cs*.cs_condition[condition].c_left);
	right := getSectCondVal(ss, cs*.cs_condition[condition].c_right);
	matching :=
	    case cs*.cs_condition[condition].c_operator
	    incase '<':
		left < right
	    incase '>':
		left > right
	    incase '=':
		left = right
	    incase '\#':
		left ~= right
	    esac;
	condition := condition + 1;
    od;
    matching
corp;

/*
 * scanSectors -
 *	The actual sector scanning routine. It calls its argument proc
 *	for each sector that meets the set up specs and conditions.
 */

proc scanSectors(register *SectorScan_t ss;
	proc(int row, col; *Sector_t s)void scanner)uint:
    register uint count;
    register int r, c;
    bool aborted;

    count := 0;
    if ss*.ss_mapHook then
	mapCoords(ss*.ss_cs.cs_boxLeft, ss*.ss_cs.cs_boxRight);
	userNL();
    fi;
    aborted := false;
    r := ss*.ss_cs.cs_boxTop;
    while r <= ss*.ss_cs.cs_boxBottom and not aborted do
	if ss*.ss_mapHook then
	    mapRowStart(r);
	fi;
	c := ss*.ss_cs.cs_boxLeft;
	while c <= ss*.ss_cs.cs_boxRight and not aborted do
	    server(rt_readSector, mapSector(r, c));
	    ss*.ss_currentSector := ES*.es_request.rq_u.ru_sector;
	    if ES*.es_country.c_status = cs_deity or
		ss*.ss_currentSector.s_owner = ES*.es_countryNumber or
		ss*.ss_mapHook and ss*.ss_cs.cs_conditionCount = 0
	    then
		if checkSectCond(ss) then
		    count := count + 1;
		    scanner(r, c, &ss*.ss_currentSector);
		elif ss*.ss_mapHook then
		    mapEmpty();
		fi;
	    elif ss*.ss_mapHook then
		mapEmpty();
	    fi;
	    c := c + 1;
	    aborted := ES*.es_gotControlC();
	od;
	if ss*.ss_mapHook and not aborted then
	    mapRowEnd(r);
	fi;
	r := r + 1;
	if ES*.es_gotControlC() then
	    aborted := true;
	fi;
    od;
    if ss*.ss_mapHook and not aborted then
	userNL();
	mapCoords(ss*.ss_cs.cs_boxLeft, ss*.ss_cs.cs_boxRight);
    fi;
    if count = 1 and ss*.ss_cs.cs_boxTop = ss*.ss_cs.cs_boxBottom and
	ss*.ss_cs.cs_boxRight = ss*.ss_cs.cs_boxLeft and
	ss*.ss_cs.cs_conditionCount = 0
    then
	count := SINGLE_SECTOR;
    fi;
    count
corp;
