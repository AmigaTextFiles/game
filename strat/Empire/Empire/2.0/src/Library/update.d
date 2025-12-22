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
 * weatherRandom - return a random number 0 - passed range.
 */

proc weatherRandom(register *Weather_t we; uint rang)uint:

    if rang = 0 then
	0
    else
	we*.we_seed := we*.we_seed * 17137 + 4287;
	we*.we_seed := (we*.we_seed >> 8) >< (we*.we_seed << 8);
	we*.we_seed % rang
    fi
corp;

/*
 * weatherStep - step the weather forward one half-hour.
 */

proc weatherStep()void:
    register *Weather_t we;
    register uint r4, c4;

    we := &ES*.es_world.w_weather;
    r4 := make(ES*.es_world.w_rows, uint) * 4;
    c4 := make(ES*.es_world.w_columns, uint) * 4;
    we*.we_hiRow := make(we*.we_hiRow + we*.we_hiRowInc + r4, uint) % r4;
    we*.we_hiCol := make(we*.we_hiCol + we*.we_hiColInc + c4, uint) % c4;
    we*.we_loRow := make(we*.we_loRow + we*.we_loRowInc + r4, uint) % r4;
    we*.we_loCol := make(we*.we_loCol + we*.we_loColInc + c4, uint) % c4;
    if weatherRandom(we, 10) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_hiRowInc ~= 4 then
		we*.we_hiRowInc := we*.we_hiRowInc + 1;
	    fi;
	else
	    if we*.we_hiRowInc ~= -4 then
		we*.we_hiRowInc := we*.we_hiRowInc - 1;
	    fi;
	fi;
    fi;
    if weatherRandom(we, 10) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_hiColInc ~= 4 then
		we*.we_hiColInc := we*.we_hiColInc + 1;
	    fi;
	else
	    if we*.we_hiColInc ~= -4 then
		we*.we_hiColInc := we*.we_hiColInc - 1;
	    fi;
	fi;
    fi;
    if weatherRandom(we, 10) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_loRowInc ~= 4 then
		we*.we_loRowInc := we*.we_loRowInc + 1;
	    fi;
	else
	    if we*.we_loRowInc ~= -4 then
		we*.we_loRowInc := we*.we_loRowInc - 1;
	    fi;
	fi;
    fi;
    if weatherRandom(we, 10) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_loColInc ~= 4 then
		we*.we_loColInc := we*.we_loColInc + 1;
	    fi;
	else
	    if we*.we_loColInc ~= -4 then
		we*.we_loColInc := we*.we_loColInc - 1;
	    fi;
	fi;
    fi;
    if weatherRandom(we, 5) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_hiPressure < we*.we_hiMax then
		we*.we_hiPressure := we*.we_hiPressure + 1;
	    fi;
	else
	    if we*.we_hiPressure > we*.we_hiMin then
		we*.we_hiPressure := we*.we_hiPressure - 1;
	    fi;
	fi;
    fi;
    if weatherRandom(we, 5) = 0 then
	if weatherRandom(we, 2) = 0 then
	    if we*.we_loPressure > we*.we_loMin then
		we*.we_loPressure := we*.we_loPressure - 1;
	    fi;
	else
	    if we*.we_loPressure < we*.we_loMax then
		we*.we_loPressure := we*.we_loPressure + 1;
	    fi;
	fi;
    fi;
corp;

/*
 * weatherUpdate - update weather to current time.
 */

proc weatherUpdate()void:
    ulong now;

    server(rt_readWeather, 0);
    now := ES*.es_request.rq_time;
    if ES*.es_request.rq_u.ru_weather.we_update < now then
	server(rt_lockWeather, 0);
	ES*.es_world.w_weather := ES*.es_request.rq_u.ru_weather;
	if ES*.es_world.w_weather.we_update = 0 then
	    ES*.es_world.w_weather.we_update := now;
	fi;
	while ES*.es_world.w_weather.we_update < now do
	    ES*.es_world.w_weather.we_update :=
		ES*.es_world.w_weather.we_update+ES*.es_world.w_secondsPerETU;
	    weatherStep();
	od;
	ES*.es_request.rq_u.ru_weather := ES*.es_world.w_weather;
	server(rt_unlockWeather, 0);
    fi;
corp;

/*
 * weather - return a pressure at a given sector, expressed in absolute
 *	coordinates.
 */

proc weather(uint r, c)int:
    uint loDist, hiDist;

    hiDist := findDistance(r, c,
			   ES*.es_world.w_weather.we_hiRow / 4,
			   ES*.es_world.w_weather.we_hiCol / 4);
    loDist := findDistance(r, c,
			   ES*.es_world.w_weather.we_loRow / 4,
			   ES*.es_world.w_weather.we_loCol / 4);
    (ES*.es_world.w_weather.we_hiPressure * ES*.es_world.w_rows * 10 /
	    (hiDist + ES*.es_world.w_rows) +
	ES*.es_world.w_weather.we_loPressure * ES*.es_world.w_rows * 10 /
	    (loDist + ES*.es_world.w_rows)) / 10
corp;

/*
 * calcPlagueFactor - calculate plague factor in given sector.
 *	NOTE: assumes enough of the owning country is present in the request.
 */

proc calcPlagueFactor(*Country_t cou; register *Sector_t s)uint:

    (make(s*.s_quantity[it_civilians], ulong) + s*.s_quantity[it_military]) *
    100 / 254 *
    (cou*.c_techLevel + s*.s_quantity[it_ore] + ES*.es_world.w_plagueBooster) /
    (cou*.c_resLevel + s*.s_efficiency + s*.s_mobility + 100)
corp;

/*
 * relativeSector - return the coords of a sector which is a given direction
 *	from a given sector. Return the movement cost * 100.
 */

proc relativeSector(register int r, c; uint dir;
		    register *int pNewR, pNewC)uint:

    case dir
    incase 0:
	pNewR* := r - 1;
	pNewC* := c;
	100
    incase 1:
	pNewR* := r - 1;
	pNewC* := c + 1;
	141
    incase 2:
	pNewR* := r;
	pNewC* := c + 1;
	100	
    incase 3:
	pNewR* := r + 1;
	pNewC* := c + 1;
	141
    incase 4:
	pNewR* := r + 1;
	pNewC* := c;
	100
    incase 5:
	pNewR* := r + 1;
	pNewC* := c - 1;
	141
    incase 6:
	pNewR* := r;
	pNewC* := c - 1;
	100
    incase 7:
	pNewR* := r - 1;
	pNewC* := c - 1;
	141
    esac
corp;

/*
 * The following routines are all part of 'updateSector', which is at the
 * heart of proper Empire operation. Updating a sector needs access to the
 * country record of the owner of the sector. This is needed for check of
 * money, checks for the capital, plague factor calculation, etc. Thus, when
 * 'updateSector' is processing a sector, it reads and caches a copy of the
 * owning country (if it isn't the current country). A pointer to that copy
 * is passed around as needed.
 */

/*
 * deliverOnce - do deliver from the current sector for the set up commodity.
 *	Convention: when we enter, the current sector (the one we are
 *	delivering from) is locked in the request, and must be back there
 *	when we exit.
 */

proc deliverOnce(*uint pMobil; int r, c; register ItemType_t what)void:
    register *Sector_t rs;
    ulong cost, cost2;
    int rNew, cNew;
    register uint quan;
    uint mappedOld, mappedNew, mobil, bs1, bs2, space, quan1, quan2, owner;
    ushort direction, threshold;
    SectorType_t oldDesig;
    bool plague;

    mobil := pMobil*;
    rs := &ES*.es_request.rq_u.ru_sector;
    oldDesig := rs*.s_type;
    quan := readQuan(rs, what);
    quan1 := quan;
    direction := rs*.s_direction[what];
    threshold := rs*.s_threshold[what];
    bs1 := getBundleSize(oldDesig, what);
    /* we use threshold as 0-127 refering to 0-127 bundles */

    if direction ~= NO_DELIVER and quan >= threshold * bs1 and mobil ~= 0 then
	quan := quan - threshold * bs1;
	mappedOld := mapSector(r, c);
	/* remove units */
	writeQuan(rs, what, quan1 - quan);
	quan1 := quan;
	server(rt_unlockSector, mappedOld);
	owner := rs*.s_owner;
	plague := rs*.s_plagueStage = 2;

	cost := relativeSector(r, c, direction, &rNew, &cNew);
	mappedNew := mapSector(rNew, cNew);
	ES*.es_noWrite := true;
	server(rt_lockSector, mappedNew);
	bs2 := getBundleSize(rs*.s_type, what);
	quan2 := readQuan(rs, what);
	/* space is the capacity left in the target sector */
	space := 127 * bs2 - quan2;
	if quan > space then
	    /* not room enough for everything we have */
	    quan := space / bs1 * bs1;
	fi;
	if bs2 > bs1 then
	    /* we want the LARGEST of the two bundle sizes */
	    bs1 := bs2;
	    /* round quantity down so that is a number of full bundles */
	    quan := quan / bs1 * bs1;
	fi;
	/* remove bundles from 'quan' until we can afford to move them */
	while
	    if quan = 0 then
		cost2 := 0;
		false
	    else
		cost2 := getTransportCost(oldDesig, what, quan);
		cost2 := getTerrainCost(rs, cost2) * cost;
		cost2 > mobil
	    fi
	do
	    quan := quan - bs1;
	od;
	if quan ~= 0 then
	    if rs*.s_owner ~= owner and rs*.s_checkPoint = 0 then
		if owner = ES*.es_countryNumber and not ES*.es_quietUpdate then
		    userS("delivery walkout between ", r, c, " and ");
		    userS("", rNew, cNew, "\n");
		fi;
		cost2 := 0;
		quan := 0;
	    else
		writeQuan(rs, what, quan2 + quan);
		if what = it_civilians or what = it_military then
		    adjustForNewWorkers(rs, what, quan2 / bs2);
		fi;
		if plague and rs*.s_plagueStage = 0 then
		    rs*.s_plagueStage := 1;
		    rs*.s_plagueTime :=
			random(ES*.es_world.w_plagueOneRand) +
			    ES*.es_world.w_plagueOneBase;
		fi;
	    fi;
	fi;
	server(rt_unlockSector, mappedNew);
	ES*.es_noWrite := false;
	uFlush();

	/* put the remainder back in the source sector, and leave it locked */
	server(rt_lockSector, mappedOld);
	mobil := mobil - cost2;
	writeQuan(rs, what, readQuan(rs, what) + quan1 - quan);
	pMobil* := mobil;
    fi;
corp;

/*
 * doDeliveries - do any deliveries from this sector.
 *	Convention: the source sector is locked when we are called, and is
 *	still or again locked when we return.
 *	Note that since this routine is called at the end of 'updateSector',
 *	we don't really care if we get back something different for the
 *	sector when we relock it.
 */

proc doDeliveries(register int r, c)void:
    uint mobil;

    /* scale mobility for the deliveries */
    mobil := make(ES*.es_request.rq_u.ru_sector.s_mobility, uint) * 100;
    ES*.es_request.rq_u.ru_sector.s_mobility := 0;
    deliverOnce(&mobil, r, c, it_civilians);
    deliverOnce(&mobil, r, c, it_military);
    deliverOnce(&mobil, r, c, it_shells);
    deliverOnce(&mobil, r, c, it_guns);
    deliverOnce(&mobil, r, c, it_planes);
    deliverOnce(&mobil, r, c, it_ore);
    deliverOnce(&mobil, r, c, it_bars);
    ES*.es_request.rq_u.ru_sector.s_mobility := mobil / 100;
corp;

/*
 * makeProduction - produce production units in a sector.
 *	Convention: the sector is present and locked.
 *	Assumption: ES*.es_noWrite is set.
 *	Returns: the money made on the work. The caller ('updateSector')
 *	must eventually add it to the owning country.
 */

proc makeProduction(int r, c; ulong iwork; bool isMine;
		    register *Country_t cou)long:
    register *Sector_t rs;
    register uint q;
    long money;
    uint mapped, owner;

    mapped := mapSector(r, c);
    rs := &ES*.es_request.rq_u.ru_sector;
    owner := rs*.s_owner;
    q := umin(iwork * rs*.s_efficiency / 100, rs*.s_quantity[it_ore]);
    if rs*.s_price = 0 then
	/* not contracted, add in the production */
	if cou*.c_money > 0 then
	    if rs*.s_production = 127 then
		if isMine and not ES*.es_quietUpdate and q ~= 0 then
		    userS("Production backlog in ", r, c, "\n");
		fi;
		q := 0;
	    else
		if q > 127 - rs*.s_production then
		    q := 127 - rs*.s_production;
		fi;
		rs*.s_production := rs*.s_production + q;
	    fi;
	fi;
	money := 0;
    else
	/* sell the production units */
	money := q * rs*.s_price / 20;
	if isMine then
	    ES*.es_contractEarnings := ES*.es_contractEarnings + money;
	fi;
    fi;
    rs*.s_quantity[it_ore] := rs*.s_quantity[it_ore] - q;
    money
corp;

/*
 * updateSector - update the indicated sector.
 *	Convention: when we are called, the indicated sector is in the
 *	request, and is locked. When we return the sector will be still/back
 *	in the request and locked. We may do several partial writes during
 *	the update process.
 */

proc updateSector(int r, c)void:
    register *Sector_t rs;
    register *Country_t cou;
    register int regInt;
    ulong dt, iwork;
    register uint q, q2 @ regInt;
    Sector_t saveSector;
    Country_t country;
    ulong now;
    register long earnings;
    uint ownerNum, effic, civ, workForce, absRow, absCol, mapped;
    int ownerRow, ownerCol;
    SectorType_t desig;
    bool saveNoWrite, isMine, comment, plagued, hurricaned;

    rs := &ES*.es_request.rq_u.ru_sector;
    civ := rs*.s_quantity[it_civilians];
    ownerNum := rs*.s_owner;
    isMine := ownerNum = ES*.es_countryNumber;
    workForce := civ + rs*.s_quantity[it_military] / 5;
    now := ES*.es_request.rq_time;
    if rs*.s_lastUpdate = 0 or rs*.s_lastUpdate > now or
	rs*.s_lastUpdate < now - (14 * 24 * 60 * 60) and workForce ~= 0
    then
	rs*.s_lastUpdate := timeRound(now);
    fi;
    dt := (now - rs*.s_lastUpdate) / ES*.es_world.w_secondsPerETU;
    if dt > 256 then
	dt := 256;
    fi;

    iwork := dt * workForce;
    if iwork >= 100 and (isMine or iwork > 96 * 100) then

	if isMine then
	    cou := &ES*.es_country;
	else
	    saveSector := rs*;
	    server(rt_readCountry, ownerNum);
	    country := ES*.es_request.rq_u.ru_country;
	    cou := &country;
	    rs* := saveSector;
	fi;

	effic := rs*.s_efficiency;
	desig := rs*.s_type;
	comment := isMine and not ES*.es_quietUpdate;

	/* this routine gets hit a lot, so inline some easy stuff */

	/* absRow := rowToAbs(r); */
	regInt := r + ES*.es_country.c_centerRow;
	while regInt < 0 do
	    regInt := regInt + ES*.es_world.w_rows;
	od;
	absRow := regInt % ES*.es_world.w_rows;
	/* absCol := colToAbs(c); */
	regInt := c + ES*.es_country.c_centerCol;
	while regInt < 0 do
	    regInt := regInt + ES*.es_world.w_columns;
	od;
	absCol := regInt % ES*.es_world.w_columns;
	/* mapped := mapAbsSector(absRow, absCol); */
	mapped := absRow * ES*.es_world.w_columns + absCol;
	if isMine then
	    ownerRow := r;
	    ownerCol := c;
	else
	    /* ownerRow := rowToCou(ownerNum, absRow); */
	    regInt :=
		make(absRow % ES*.es_world.w_rows, int) - cou*.c_centerRow;
	    if regInt >= make(ES*.es_world.w_rows, int) / 2 then
		regInt := regInt - make(ES*.es_world.w_rows, int);
	    elif regInt < - make(ES*.es_world.w_rows, int) / 2 then
		regInt := ownerCol + make(ES*.es_world.w_rows, int);
	    fi;
	    ownerRow := regInt;
	    /* ownerCol := colToCou(ownerNum, absCol); */
	    regInt :=
		make(absCol % ES*.es_world.w_columns,int) - cou*.c_centerCol;
	    if regInt >= make(ES*.es_world.w_columns, int) / 2 then
		regInt := regInt - make(ES*.es_world.w_columns, int);
	    elif regInt < - make(ES*.es_world.w_columns, int) / 2 then
		regInt := regInt + make(ES*.es_world.w_columns, int);
	    fi;
	    ownerCol := regInt;
	fi;

	earnings := 0;
	saveNoWrite := ES*.es_noWrite;
	ES*.es_noWrite := true;

	plagued := false;
	hurricaned := false;
	regInt := weather(absRow, absCol);
	if regInt <= HURRICANE_FORCE then
	    saveSector := rs*;
	    news(n_storm_sector, ownerNum, NOBODY);
	    if isMine then
		if comment then
		    userS("Hurricane damage in ", r, c, "!\n");
		fi;
	    else
		userS("Hurricane damage in ", ownerRow, ownerCol, "!");
		notify(ownerNum);
	    fi;
	    rs* := saveSector;
	    q := random(ES*.es_world.w_hurricaneLandRand) +
		    ES*.es_world.w_hurricaneLandBase;
	    effic := effic * q / 100;
	    rs*.s_efficiency := effic;
	    rs*.s_mobility := make(rs*.s_mobility, uint) * q / 100;
	    if rs*.s_type = s_bridgeSpan and effic < 20 then
		zapSpan(rs);
		user("Skreeetch! SPLASH!!!!\n");
		hurricaned := true;
	    fi;
	elif regInt <= MONSOON_FORCE then
	    if comment and effic ~= 100 then
		userS("Bad weather halts construction in ", r, c, "!\n");
	    fi;
	else
	    q := 0;
	    if regInt <= STORM_FORCE then
		if cou*.c_money > 0 then
		    q := umin(iwork / 200, 100 - effic);
		    if comment and effic + q ~= 100 then
			userS("Bad weather delays construction in ", r, c,
			      ".\n");
		    fi;
		fi;
		rs*.s_mobility := umin(127, rs*.s_mobility +
			dt * ES*.es_world.w_mobilScale / 200);
	    else
		if cou*.c_money > 0 then
		    q := umin(iwork / 100, 100 - effic);
		fi;
		rs*.s_mobility := umin(127, rs*.s_mobility +
			dt * ES*.es_world.w_mobilScale / 100);
	    fi;
	    if effic ~= 100 then
		q := q * ES*.es_world.w_efficScale / 100;
		effic := effic + q;
		rs*.s_efficiency := effic;
		q := q * ES*.es_world.w_efficCost;
		earnings := earnings - q;
		if isMine then
		    ES*.es_improvementCost := ES*.es_improvementCost + q;
		fi;
	    fi;
	fi;

	q := dt * civ;
	if desig = s_urban then
	    q := umin(127, civ +
		umin(q / ES*.es_world.w_urbanGrowthFactor,
		     rs*.s_quantity[it_ore])) - civ;
	    civ := civ + q;
	    rs*.s_quantity[it_ore] := rs*.s_quantity[it_ore] - q;
	elif desig = s_bridgeSpan then
	    civ := civ - q / ES*.es_world.w_bridgeDieFactor;
	elif civ > 31 and civ < 97 then
	    civ := umin(127, civ + q / ES*.es_world.w_highGrowthFactor);
	else
	    civ := umin(127, civ + q / ES*.es_world.w_lowGrowthFactor);
	fi;
	rs*.s_quantity[it_civilians] := civ;
	rs*.s_lastUpdate :=
	    rs*.s_lastUpdate + dt * ES*.es_world.w_secondsPerETU;

	q := rs*.s_quantity[it_military] / 32 * dt /
		ES*.es_world.w_milSuppliesCost;
	if q ~= 0 then
	    earnings := earnings - q;
	    if isMine then
		ES*.es_militaryCost := ES*.es_militaryCost + q;
	    fi;
	fi;

	case rs*.s_plagueStage
	incase 3:
	    /* terminal plague stage - kill people off */
	    q := ((100 - effic) + (127 - rs*.s_mobility) + 113) * 100 /
		    ES*.es_world.w_plagueKiller;
	    q2 := umin(q * rs*.s_quantity[it_military] / 100,
		       rs*.s_quantity[it_military]);
	    q := umin(q * civ / 100, civ);
	    if q ~= 0 or q2 ~= 0 then
		civ := civ - q;
		rs*.s_quantity[it_civilians] := civ;
		rs*.s_quantity[it_military] :=
		    rs*.s_quantity[it_military] - q2;
		userN(if desig = s_urban then q * 10 else q fi);
		userN2(" civilians and ", q2);
		userS(" military died of the plague in ", ownerRow, ownerCol,
		      ".");
		saveSector := rs*;
		notify(ownerNum);
		news(n_plague_die, ownerNum, NOBODY);
		rs* := saveSector;
		if civ = 0 and rs*.s_quantity[it_military] = 0 then
		    plagued := true;
		    rs*.s_owner := 0;
		    rs*.s_defender := NO_DEFEND;
		    rs*.s_checkPoint := 0;
		fi;
	    fi;
	    if rs*.s_plagueTime <= dt then
		rs*.s_plagueStage := 0;
	    else
		rs*.s_plagueTime := rs*.s_plagueTime - dt;
	    fi;
	incase 2:
	    /* infectious stage */
	    if rs*.s_plagueTime <= dt then
		rs*.s_plagueStage := 3;
		rs*.s_plagueTime := random(ES*.es_world.w_plagueThreeRand) +
			ES*.es_world.w_plagueThreeBase;
	    else
		rs*.s_plagueTime := rs*.s_plagueTime - dt;
	    fi;
	incase 1:
	    /* gestatory stage */
	    if rs*.s_plagueTime <= dt then
		rs*.s_plagueStage := 2;
		rs*.s_plagueTime := random(ES*.es_world.w_plagueTwoRand) +
			ES*.es_world.w_plagueTwoBase;
		saveSector := rs*;
		userS("Outbreak of plague reported in ",ownerRow,ownerCol,"!");
		notify(ownerNum);
		news(n_plague_outbreak, ownerNum, NOBODY);
		rs* := saveSector;
	    else
		rs*.s_plagueTime := rs*.s_plagueTime - dt;
	    fi;
	incase 0:
	    /* not infected - see if sector should become infected. */
	    if random(100) < calcPlagueFactor(cou, rs) / 100 then
		rs*.s_plagueStage := 1;
		rs*.s_plagueTime := random(ES*.es_world.w_plagueOneRand) +
			ES*.es_world.w_plagueOneBase;
	    fi;
	esac;


	if effic >= 60 then
	    case desig
	    incase s_bank:
		q := dt * rs*.s_quantity[it_bars] * 4 *
			ES*.es_world.w_interestRate / 100;
		earnings := earnings + q;
		if isMine then
		    ES*.es_interestEarnings := ES*.es_interestEarnings + q;
		fi;

	    incase s_capital:
		q := dt * ES*.es_world.w_utilityRate;
		earnings := earnings - q;
		if isMine then
		    ES*.es_utilitiesCost := ES*.es_utilitiesCost + q;
		fi;
		if absRow = cou*.c_centerRow and absCol = cou*.c_centerCol and
		    cou*.c_status ~= cs_deity
		then
		    server(rt_unlockSector, mapped);
		    server(rt_lockCountry, ownerNum);
		    cou := &ES*.es_request.rq_u.ru_country;
		    cou*.c_btu :=
			umin(ES*.es_world.w_maxBTUs,
			     cou*.c_btu + dt * civ * effic /
					ES*.es_world.w_BTUDivisor);
		    /* research and technology levels go down by 1% per day */
		    cou*.c_resLevel :=
			cou*.c_resLevel - cou*.c_resLevel * dt *
			    ES*.es_world.w_resDecreaser / 48000;
		    cou*.c_techLevel :=
			cou*.c_techLevel - cou*.c_techLevel * dt *
			    ES*.es_world.w_techDecreaser / 48000;
		    server(rt_unlockCountry, ownerNum);
		    if isMine then
			ES*.es_country.c_btu := cou*.c_btu;
			ES*.es_country.c_resLevel := cou*.c_resLevel;
			ES*.es_country.c_techLevel := cou*.c_techLevel;
		    fi;
		    server(rt_lockSector, mapped);
		fi;

	    incase s_radar:
	    incase s_weather:
		q := dt * ES*.es_world.w_utilityRate;
		earnings := earnings - q;
		if isMine then
		    ES*.es_utilitiesCost := ES*.es_utilitiesCost + q;
		fi;

	    incase s_technical:
	    incase s_research:
		q := dt * ES*.es_world.w_utilityRate;
		earnings := earnings - q;
		if isMine then
		    ES*.es_utilitiesCost := ES*.es_utilitiesCost + q;
		fi;
		if cou*.c_money > 0 then
		    q2 :=
			if rs*.s_type = s_technical then
			    ES*.es_world.w_techCost
			else
			    ES*.es_world.w_resCost
			fi;
		    q := rs*.s_production / q2;
		    if q ~= 0 then
			rs*.s_production := rs*.s_production - q * q2;
			server(rt_unlockSector, mapped);
			server(rt_lockCountry, ownerNum);
			if desig = s_technical then
			    ES*.es_request.rq_u.ru_country.c_techLevel :=
				ES*.es_request.rq_u.ru_country.c_techLevel + q;
			    server(rt_unlockCountry, ownerNum);
			    cou*.c_techLevel :=
				ES*.es_request.rq_u.ru_country.c_techLevel;
			    if comment then
				userS("Technological advances at ",
				      r, c, "\n");
			    fi;
			else
			    ES*.es_request.rq_u.ru_country.c_resLevel :=
				ES*.es_request.rq_u.ru_country.c_resLevel + q;
			    server(rt_unlockCountry, ownerNum);
			    cou*.c_resLevel :=
				ES*.es_request.rq_u.ru_country.c_resLevel;
			    if comment then
				userS("Medical breakthroughs at ", r, c, "\n");
			    fi;
			fi;
			server(rt_lockSector, mapped);
		    fi;
		fi;
		earnings := earnings + makeProduction(r, c,
			iwork * if desig = s_technical then
				    ES*.es_world.w_techScale
				else
				    ES*.es_world.w_resScale
				fi / 100,
			isMine, cou);

	    incase s_defense:
		if cou*.c_money > 0 then
		    q := umin(rs*.s_production / ES*.es_world.w_gunCost,
			      127 - rs*.s_quantity[it_guns]);
		    rs*.s_production :=
			rs*.s_production - q * ES*.es_world.w_gunCost;
		    rs*.s_quantity[it_guns] := rs*.s_quantity[it_guns] + q;
		    if comment and q ~= 0 then
			userS("Guns built at ", r, c, "\n");
		    fi;
		fi;
		earnings := earnings + makeProduction(r, c,
			iwork * ES*.es_world.w_defenseScale / 100,isMine, cou);

	    incase s_industry:
		if cou*.c_money > 0 then
		    q := umin(rs*.s_production / ES*.es_world.w_shellCost,
			      127 - rs*.s_quantity[it_shells]);
		    rs*.s_production :=
			rs*.s_production - q * ES*.es_world.w_shellCost;
		    rs*.s_quantity[it_shells] := rs*.s_quantity[it_shells] + q;
		    if comment and q ~= 0 then
			userS("Shells built at ", r, c, "\n");
		    fi;
		fi;
		earnings := earnings + makeProduction(r, c,
			iwork * ES*.es_world.w_shellScale / 100, isMine, cou);

	    incase s_airport:
		if cou*.c_money > 0 then
		    q := umin(rs*.s_production / ES*.es_world.w_planeCost,
			      127 - rs*.s_quantity[it_planes]);
		    rs*.s_production :=
			rs*.s_production - q * ES*.es_world.w_planeCost;
		    rs*.s_quantity[it_planes] := rs*.s_quantity[it_planes] + q;
		    if comment and q ~= 0 then
			userS("Planes built at ", r, c, "\n");
		    fi;
		fi;
		earnings := earnings + makeProduction(r, c,
			iwork * ES*.es_world.w_airportScale / 100,isMine, cou);

	    incase s_harbour:
		earnings := earnings + makeProduction(r, c,
			iwork * ES*.es_world.w_harborScale / 100, isMine, cou);

	    incase s_bridgeHead:
		earnings := earnings + makeProduction(r, c,
			iwork * ES*.es_world.w_bridgeScale / 100, isMine, cou);

	    incase s_goldMine:
		q := umin(rs*.s_production / ES*.es_world.w_barCost,
			  127 - rs*.s_quantity[it_bars]);
		rs*.s_production :=
			rs*.s_production - q * ES*.es_world.w_barCost;
		rs*.s_quantity[it_bars] := rs*.s_quantity[it_bars] + q;
		q := rs*.s_gold * iwork * effic / 100 *
			ES*.es_world.w_goldScale / 1000000;
		q := umin(q, rs*.s_gold);
		if rs*.s_price = 0 then
		    /* not contracted, add in the production */
		    if cou*.c_money > 0 then
			if rs*.s_production = 127 then
			    if comment and q ~= 0 then
				userS("Production backlog in ", r, c, "\n");
			    fi;
			    q := 0;
			else
			    if q * 2 > 127 - rs*.s_production then
				q := (127 - rs*.s_production) / 2;
			    fi;
			    rs*.s_production := rs*.s_production + q * 2;
			fi;
		    fi;
		else
		    /* sell the production units */
		    q2 := q * 2 * rs*.s_price / 20;
		    earnings := earnings + q2;
		    if isMine then
			ES*.es_contractEarnings :=ES*.es_contractEarnings + q2;
		    fi;
		fi;
		rs*.s_gold := rs*.s_gold - q;

	    incase s_ironMine:
		q := rs*.s_iron * effic / 100 *
		    iwork * ES*.es_world.w_ironScale / 1000000;
		if rs*.s_price = 0 then
		    /* turn this work into ore */
		    if cou*.c_money > 0 then
			if rs*.s_quantity[it_ore] = 127 then
			    if comment and q ~= 0 then
				userS("Ore ready to move in ", r, c, "\n");
			    fi;
			else
			    rs*.s_quantity[it_ore] :=
				umin(127, rs*.s_quantity[it_ore] + q);
			fi;
		    fi;
		else
		    /* consider each unit of ore to be a unit of production */
		    q2 := q * rs*.s_price / 20;
		    earnings := earnings + q2;
		    if isMine then
			ES*.es_contractEarnings :=ES*.es_contractEarnings + q2;
		    fi;
		fi;
	    esac;
	fi;

	/* this is a rare case we have saved up so that we can do it when
	   it is safe to unlock the sector. */

	if plagued or hurricaned then
	    server(rt_unlockSector, mapped);
	    server(rt_lockCountry, ownerNum);
	    cou := &ES*.es_request.rq_u.ru_country;
	    cou*.c_sectorCount := cou*.c_sectorCount - 1;
	    if isMine then
		ES*.es_country.c_sectorCount := cou*.c_sectorCount;
	    fi;
	    if cou*.c_sectorCount = 0 then
		cou*.c_status := cs_dead;
		if isMine then
		    ES*.es_country.c_status := cou*.c_status;
		    if plagued then
			user("\nYour country has just expired due "
			     "to the plague!!\n\n");
		    else
			user("\nYour country has just expired due "
			     "to hurricane damage!!\n\n");
		    fi;
		fi;
		server(rt_unlockCountry, ownerNum);
		news(if plagued then n_plague_dest else n_hurricane_dest fi,
		     ownerNum, NOBODY);
	    else
		server(rt_unlockCountry, ownerNum);
	    fi;
	    server(rt_lockSector, mapped);
	fi;

	/* if the current player owns the sector, then the update of his
	   country will be done in 'commands' in 'commands.d'. Again, the
	   goal is to minimize locking/unlocking. */

	if earnings ~= 0 then
	    if isMine then
		ES*.es_country.c_money := ES*.es_country.c_money + earnings;
	    else
		server(rt_unlockSector, mapped);
		server(rt_lockCountry, ownerNum);
		ES*.es_request.rq_u.ru_country.c_money :=
		    ES*.es_request.rq_u.ru_country.c_money + earnings;
		server(rt_unlockCountry, ownerNum);
		/* If the sector made or lost money, there is a pretty fair
		   chance it will end up delivering something. */
		server(rt_lockSector, mapped);
	    fi;
	fi;

	doDeliveries(r, c);
	ES*.es_noWrite := saveNoWrite;
    fi;
corp;

/*
 * doShipDamage - do ship damage either on update or when move into storm.
 *	Convention: the ship is locked in the request when we enter and
 *	also when we exit.
 */

proc doShipDamage(register uint shipNumber)void:
    Ship_t saveShip;
    register uint q;
    bool saveNoWrite;

    saveNoWrite := ES*.es_noWrite;
    ES*.es_noWrite := true;
    saveShip := ES*.es_request.rq_u.ru_ship;
    news(n_storm_ship, saveShip.sh_owner, NOBODY);
    user3("Hurricane damage to ", getShipName(saveShip.sh_type), " \#");
    userN(shipNumber);
    userC('!');
    q := random(ES*.es_world.w_hurricaneSeaRand) +
		ES*.es_world.w_hurricaneSeaBase;
    q := min(100, ES*.es_world.w_shipDamage[saveShip.sh_type] * q);
    q := 100 - q;
    if saveShip.sh_mobility > 0 then
	saveShip.sh_mobility := saveShip.sh_mobility * q / 100;
    fi;
    saveShip.sh_efficiency := saveShip.sh_efficiency * q / 100;
    if saveShip.sh_efficiency < 20 then
	ES*.es_request.rq_u.ru_ship := saveShip;
	server(rt_unlockShip, shipNumber);
	user(" It sinks!");
	notify(saveShip.sh_owner);
	removeFromFleet(saveShip.sh_owner, shipNumber);
	q := make(saveShip.sh_row, uint) * ES*.es_world.w_columns +
		saveShip.sh_col;
	server(rt_lockSector, q);
	ES*.es_request.rq_u.ru_sector.s_shipCount :=
	    ES*.es_request.rq_u.ru_sector.s_shipCount - 1;
	server(rt_unlockSector, q);
	server(rt_lockShip, shipNumber);
	ES*.es_request.rq_u.ru_ship.sh_owner := 0;
    else
	notify(saveShip.sh_owner);
	ES*.es_request.rq_u.ru_ship := saveShip;
    fi;
    ES*.es_noWrite := saveNoWrite;
corp;

/*
 * updateShip - update the passed ship, returning 'true' if anything changed.
 *	Convention: similar to 'updateSector' - the ship is locked.
 */

proc updateShip(uint shipNumber)void:
    register *Ship_t rsh;
    register ulong now, dt;
    int wea;
    bool isMine, saveNoWrite;

    rsh := &ES*.es_request.rq_u.ru_ship;
    now := ES*.es_request.rq_time;
    if rsh*.sh_lastUpdate = 0 or rsh*.sh_lastUpdate > now or
	rsh*.sh_lastUpdate < now - (14 * 24 * 60 * 60)
    then
	rsh*.sh_lastUpdate := timeRound(now);
    fi;
    dt := (now - rsh*.sh_lastUpdate) / ES*.es_world.w_secondsPerETU;
    if dt >= 3 then
	saveNoWrite := ES*.es_noWrite;
	ES*.es_noWrite := true;
	isMine := rsh*.sh_owner = ES*.es_countryNumber;
	rsh*.sh_lastUpdate :=
	    rsh*.sh_lastUpdate + dt * ES*.es_world.w_secondsPerETU;
	wea := weather(rsh*.sh_row, rsh*.sh_col);
	if wea <= HURRICANE_FORCE and rsh*.sh_type ~= st_submarine then
	    doShipDamage(shipNumber);
	elif wea <= MONSOON_FORCE and rsh*.sh_type ~= st_submarine then
	    if isMine and rsh*.sh_efficiency ~= 100 then
		user3("Bad weather halts construction on ",
		      getShipName(rsh*.sh_type), " \#");
		userN(shipNumber);
		userNL();
	    fi;
	else
	    if wea <= STORM_FORCE and rsh*.sh_type ~= st_submarine then
		dt := dt / 2;
		if isMine and rsh*.sh_efficiency ~= 100 then
		    user3("Bad weather delays construction on ",
			  getShipName(rsh*.sh_type), " \#");
		    userN(shipNumber);
		    userNL();
		fi;
	    fi;
	    dt := dt * ES*.es_world.w_shipWorkScale / 100;
	    rsh*.sh_mobility := min(127, rsh*.sh_mobility + make(dt, int));
	    rsh*.sh_efficiency := min(100, rsh*.sh_efficiency + dt);
	    rsh*.sh_techLevel := rsh*.sh_techLevel - rsh*.sh_techLevel * dt *
		    ES*.es_world.w_shipTechDecreaser / 480000;
	fi;
	ES*.es_noWrite := saveNoWrite;
    fi;
corp;
