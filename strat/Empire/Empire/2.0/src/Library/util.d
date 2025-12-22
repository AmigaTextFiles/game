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
 * util.d - some utility routines.
 */

/*
 * timeRound - round a seconds time value down to a number of ETUs.
 */

proc timeRound(ulong t)ulong:

    t / ES*.es_world.w_secondsPerETU * ES*.es_world.w_secondsPerETU
corp;

/*
 * timeNow - return a rounded down time from the current request.
 */

proc timeNow()ulong:

    ES*.es_request.rq_time / ES*.es_world.w_secondsPerETU *
	ES*.es_world.w_secondsPerETU
corp;

/*
 * random - return a random number 0 - passed range.
 */

proc random(uint rang)uint:
    register uint seed;

    if rang = 0 then
	0
    else
	seed := ES*.es_seed * 17137 + 4287;
	seed := (seed >> 8) >< (seed << 8);
	ES*.es_seed := seed;
	seed % rang
    fi
corp;

/*
 * lookupCommand - look up a command in a table of command names.
 *	If the name is unambiguous, return it's code number (2 - n + 2).
 *	Return 0 if the command is not found, 1 if it's ambiguous.
 */

proc lookupCommand(register *char commandList, command)uint:
    register *char p;
    register uint i, which, found;

    i := 2;
    found := 0;
    while commandList* ~= '\e' do
	p := command;
	while p* = commandList* and p* ~= '\e' do
	    p := p + 1;
	    commandList := commandList + 1;
	od;
	if p* = '\e' then
	    which := i;
	    found := found + 1;
	fi;
	while commandList* ~= '\e' do
	    commandList := commandList + 1;
	od;
	commandList := commandList + 1;
	i := i + 1;
    od;
    if found = 0 then
	0
    elif found = 1 then
	which
    else
	1
    fi
corp;

/*
 * dash - utility to print a line of dashes.
 */

proc dash(register uint count)void:

    while count ~= 0 do
	count := count - 1;
	userC('-');
    od;
    userNL();
corp;

/*
 * rowToAbs - translate country row number to absolute row number.
 */

proc rowToAbs(register int r)uint:

    r := r + ES*.es_country.c_centerRow;
    while r < 0 do
	r := r + ES*.es_world.w_rows;
    od;
    r % ES*.es_world.w_rows
corp;

/*
 * colToAbs - translate user column number to absolute column number.
 */

proc colToAbs(register int c)uint:

    c := c + ES*.es_country.c_centerCol;
    while c < 0 do
	c := c + ES*.es_world.w_columns;
    od;
    c % ES*.es_world.w_columns
corp;

/*
 * rowToCou - translate an absolute row to the coords of the given country.
 */

proc rowToCou(uint country, rp)int:
    uint centerRow @ country;
    register int r;

    if country = ES*.es_countryNumber then
	centerRow := ES*.es_country.c_centerRow;
    else
	server(rt_readCountry, country);
	centerRow := ES*.es_request.rq_u.ru_country.c_centerRow;
    fi;
    r := make(rp % ES*.es_world.w_rows, int) - centerRow;
    if r >= make(ES*.es_world.w_rows, int) / 2 then
	r - make(ES*.es_world.w_rows, int)
    elif r < - make(ES*.es_world.w_rows, int) / 2 then
	r + make(ES*.es_world.w_rows, int)
    else
	r
    fi
corp;

/*
 * colToCou - translate an absolute column to the coords of the country.
 *	Peculiar convention: the country to translate to is currently in
 *	the request if it is not my country. This prevents an extra read
 *	of the country record in the very common case of calling 'rowToCou'
 *	and then 'colToCou'.
 */

proc colToCou(uint country, cp)int:
    uint centerCol @ country;
    register int c;

    if country = ES*.es_countryNumber then
	centerCol := ES*.es_country.c_centerCol;
    else
	/* server(rt_readCountry, country); */
	centerCol := ES*.es_request.rq_u.ru_country.c_centerCol;
    fi;
    c := make(cp % ES*.es_world.w_columns, int) - centerCol;
    if c >= make(ES*.es_world.w_columns, int) / 2 then
	c - make(ES*.es_world.w_columns, int)
    elif c < - make(ES*.es_world.w_columns, int) / 2 then
	c + make(ES*.es_world.w_columns, int)
    else
	c
    fi
corp;

/*
 * rowToMe - translate an absolute row number to the current country.
 */

proc rowToMe(uint rp)int:
    register int r;

    r := make(rp % ES*.es_world.w_rows, int) - ES*.es_country.c_centerRow;
    if r >= make(ES*.es_world.w_rows, int) / 2 then
	r - make(ES*.es_world.w_rows, int)
    elif r < - make(ES*.es_world.w_rows, int) / 2 then
	r + make(ES*.es_world.w_rows, int)
    else
	r
    fi
corp;

/*
 * colToMe - translate an absolute col number to the current country.
 */

proc colToMe(uint cp)int:
    register int c;

    c := make(cp % ES*.es_world.w_columns, int) - ES*.es_country.c_centerCol;
    if c >= make(ES*.es_world.w_columns, int) / 2 then
	c - make(ES*.es_world.w_columns, int)
    elif c < - make(ES*.es_world.w_columns, int) / 2 then
	c + make(ES*.es_world.w_columns, int)
    else
	c
    fi
corp;

/*
 * err - print an error message.
 */

proc err(*char mess)void:

    user3("*** ", mess, " ***\n");
corp;

/*
 * getDesigName - return the full string for a sector type name.
 */

proc getDesigName(SectorType_t desig)*char:

     case desig
     incase s_water:
	  "sea"
     incase s_mountain:
	  "mountain"
     incase s_wilderness:
	  "wilderness"
     incase s_sanctuary:
	  "sanctuary"
     incase s_capital:
	  "capital"
     incase s_urban:
	  "urban area"
     incase s_defense:
	  "defense plant"
     incase s_industry:
	  "shell industry"
     incase s_ironMine:
	  "mine"
     incase s_goldMine:
	  "gold mine"
     incase s_harbour:
	  "harbor"
     incase s_warehouse:
	  "warehouse"
     incase s_technical:
	  "technical center"
     incase s_fortress:
	  "fortress"
     incase s_airport:
	  "airport"
     incase s_research:
	  "research laboratory"
     incase s_highway:
	  "highway"
     incase s_radar:
	  "radar station"
     incase s_weather:
	  "weather station"
     incase s_bridgeHead:
	  "bridge head"
     incase s_bridgeSpan:
	  "bridge span"
     incase s_bank:
	  "bank"
     incase s_exchange:
	  "exchange"
     default:
	  "?bad desig?"
     esac
corp;

/*
 * getItemName - return the full string name for a commodity.
 */

proc getItemName(ItemType_t item)*char:

    case item
    incase it_civilians:
	"civilians"
    incase it_military:
	"military"
    incase it_shells:
	"shells"
    incase it_guns:
	"guns"
    incase it_planes:
	"planes"
    incase it_ore:
	"ore"
    incase it_bars:
	"bars"
    default:
	"?bad item?"
    esac
corp;

/*
 * getShipName - return the full string name for a ship.
 */

proc getShipName(ShipType_t typ)*char:

    case typ
    incase st_PTBoat:
	"PT boat"
    incase st_mineSweeper:
	"minesweeper"
    incase st_destroyer:
	"destroyer"
    incase st_submarine:
	"submarine"
    incase st_freighter:
	"freighter"
    incase st_tender:
	"tender"
    incase st_battleship:
	"battleship"
    incase st_carrier:
	"carrier"
    default:
	"?bad ship?"
    esac
corp;

/*
 * getIndex - return the index of a character in a character array.
 */

proc getIndex(register *char types; register char typ)uint:
    register uint index;

    index := 0;
    while types* ~= typ do
	types := types + sizeof(char);
	index := index + 1;
    od;
    index
corp;

/*
 * getShipIndex - return the index of the given ship type code.
 */

proc getShipIndex(char shipType)uint:

    getIndex(&ES*.es_shipChar[0], shipType)
corp;

/*
 * getItemIndex - return the index of the given item type code.
 */

proc getItemIndex(char itemType)uint:

    getIndex(&ES*.es_itemChar[0], itemType)
corp;

/*
 * min - return the minimum of two ints.
 */

proc min(int a, b)int:

    if a < b then a else b fi
corp;

/*
 * umin - return the minimum of two uints.
 */

proc umin(uint a, b)uint:

    if a < b then a else b fi
corp;

/*
 * mapAbsSector - map an absolute sector co-ordinate to a server one.
 */

proc mapAbsSector(uint r, c)uint:

    r % ES*.es_world.w_rows * ES*.es_world.w_columns +
	c % ES*.es_world.w_columns
corp;

/*
 * mapSector - map a user's coordinate idea of a sector to a server one.
 */

proc mapSector(register int r, c)uint:

    /* we inline the contents of 'rowToAbs' and 'colToAbs' */
    r := r + ES*.es_country.c_centerRow;
    while r < 0 do
	r := r + ES*.es_world.w_rows;
    od;
    c := c + ES*.es_country.c_centerCol;
    while c < 0 do
	c := c + ES*.es_world.w_columns;
    od;
    r % ES*.es_world.w_rows * ES*.es_world.w_columns +
	c % ES*.es_world.w_columns
corp;

/*
 * accessSector - someone is looking at a sector, but in a way which will
 *	force it to be updated.
 */

proc accessSector(int row, col)void:
    uint mapped;

    mapped := mapSector(row, col);
    ES*.es_noWrite := true;
    server(rt_lockSector, mapped);
    updateSector(row, col);
    server(rt_unlockSector, mapped);
    ES*.es_noWrite := false;
    uFlush();
corp;

/*
 * accessShip - similar thing for a ship.
 */

proc accessShip(uint shipNumber)void:

    ES*.es_noWrite := true;
    server(rt_lockShip, shipNumber);
    updateShip(shipNumber);
    server(rt_unlockShip, shipNumber);
    ES*.es_noWrite := false;
    uFlush();
corp;

/*
 * getBundleSize - get the size of the storage bundle for given types.
 */

proc getBundleSize(register SectorType_t sectorType;
		   register ItemType_t thingType)uint:

    if sectorType = s_warehouse then
	if thingType = it_shells or thingType = it_guns or thingType = it_ore
	then
	     10
	else
	     1
	fi
    elif sectorType = s_urban then
	if thingType = it_civilians then 10 else 1 fi
    elif sectorType = s_bank then
	if thingType = it_bars then 4 else 1 fi
    else
	1
    fi
corp;

/*
 * readQuan - return the current quantity of the indicated commodity at the
 *	  passed sector.
 */

proc readQuan(*Sector_t s; ItemType_t what)uint:

    getBundleSize(s*.s_type, what) * s*.s_quantity[what]
corp;

/*
 * writeQuan - write the given quantity of the indicated commodity to the
 *	  passed sector. Any excess is discarded silently.
 */

proc writeQuan(*Sector_t s; ItemType_t what; uint quan)void:
    char desig;

    s*.s_quantity[what] := umin(127, quan / getBundleSize(s*.s_type, what));
corp;

/*
 * getTransportCost - get the transportion cost of moving the given quantity
 *	of the given thing out of the given type of sector. Note that the
 *	cost is rounded up to the next shipment bundle size. We assume that
 *	the quantity is already rounded up to the storage bundle size.
 */

proc getTransportCost(SectorType_t sectorType;
		      ItemType_t thingType; register uint quantity)uint:
    register uint bundleSize;

    bundleSize := getBundleSize(sectorType, thingType);
    case thingType
    incase it_civilians:
	/* civMob mobility per 5 bundles of civilians */
	(quantity + 4 * bundleSize) / (5 * bundleSize) * ES*.es_world.w_civMob
    incase it_military:
	/* milMob mobility per 5 bundles of military */
	(quantity + 4 * bundleSize) / (5 * bundleSize) * ES*.es_world.w_milMob
    incase it_shells:
	/* shellMob mobility per 5 bundles of shells */
	(quantity + 4 * bundleSize) / (5 * bundleSize)* ES*.es_world.w_shellMob
    incase it_guns:
	/* gunMob mobility per bundle of guns */
	quantity / bundleSize * ES*.es_world.w_gunMob
    incase it_planes:
	/* planeMob mobility per bundle of planes */
	quantity / bundleSize * ES*.es_world.w_planeMob
    incase it_ore:
	/* oreMob mobility per 5 bundles of ore */
	(quantity + 4 * bundleSize) / (5 * bundleSize) * ES*.es_world.w_oreMob
    incase it_bars:
	/* barMob mobility per bar, except barMob / 2 per bar leaving a bank */
	if sectorType = s_bank then
	    quantity * ES*.es_world.w_barMob / 2
	else
	    quantity * ES*.es_world.w_barMob
	fi
    default:
	err("bad item type in 'getTransportCost'");
	quantity
    esac
corp;

/*
 * getTerrainCost - scale the cost for movement onto the given sector.
 */

proc getTerrainCost(register *Sector_t s; register ulong cost)ulong:

    if s*.s_type = s_highway or s*.s_type = s_bridgeSpan then
	cost * (100 - s*.s_efficiency) / 100
    elif s*.s_type = s_mountain then
	cost * ES*.es_world.w_mountMob
    elif s*.s_type = s_wilderness then
	cost * ES*.es_world.w_wildMob
    else
	cost * ES*.es_world.w_defMob
    fi
corp;

/*
 * adjustForNewWorkers - new workers have just been moved into the sector -
 *	fix it up so as to not lose mobility or gain work.
 *	NOTE: we assume that 'rq_time' is relatively recent.
 */

proc adjustForNewWorkers(register *Sector_t s;
			 ItemType_t what; uint quantity)void:
    ulong now, dt, dt2, iwork;
    uint workForce;

    /* we have to keep any work pending in the target
       sector correct. We do this by moving its last
       update time forward as required. */
    /* workforce BEFORE the new guys added: */
    workForce :=
	if what = it_civilians then
	    quantity + s*.s_quantity[it_military] / 5
	else
	    s*.s_quantity[it_civilians] + quantity / 5
	fi;
    now := ES*.es_request.rq_time;
    if s*.s_lastUpdate = 0 or s*.s_lastUpdate > now or
	s*.s_lastUpdate < now - (7 * 24 * 60 * 60) and workForce ~= 0
    then
	s*.s_lastUpdate := timeRound(now);
    fi;
    dt := (now - s*.s_lastUpdate) / ES*.es_world.w_secondsPerETU;
    /* work pending in the sector: */
    iwork := workForce * dt;
    /* workforce AFTER the new guys added: */
    workForce := s*.s_quantity[it_civilians] + s*.s_quantity[it_military] / 5;
    /* time they would have taken to do the work: */
    dt2 := iwork / workForce;
    /* add mobility since it's not dependent on iwork: */
    s*.s_mobility := umin(127, s*.s_mobility + (dt - dt2));
    /* and crank the update time forward: */
    s*.s_lastUpdate := (now / ES*.es_world.w_secondsPerETU - dt2) *
			    ES*.es_world.w_secondsPerETU;
corp;

/*
 * getTechFactor - return the country's current technology factor.
 *	(range returned is 0 - 99)
 */

proc getTechFactor(uint country)uint:
    register ulong level;

    if country = ES*.es_countryNumber then
	level := ES*.es_country.c_techLevel;
    else
	server(rt_readCountry, country);
	level := ES*.es_request.rq_u.ru_country.c_techLevel;
    fi;
    (250000 + 6175 * level) / (10000 + 61 * level)
corp;

/*
 * getShipTechFactor - return the ship's current technology factor.
 */

proc getShipTechFactor(*Ship_t sh)uint:
    ulong level;

    level := sh*.sh_techLevel;
    (250000 + 6175 * level) / (10000 + 61 * level)
corp;

/*
 * getDefender - return the coordinates of a defending fort.
 */

proc getDefender(int r, c; *Sector_t s; *int pRow, pCol)void:
    uint defender;

    defender := s*.s_defender;
    pRow* := r + (defender >> 4) - 8;
    pCol* := c + (defender & 0xf) - 8;
corp;

/*
 * putDefender - store a defender offset value.
 */

proc putDefender(int r, c; *Sector_t s; int rDefender, cDefender)void:

    s*.s_defender := make(rDefender + 8 - r, uint) << 4 |
			     make(cDefender + 8 - c, uint);
corp;

/*
 * findDistance - return the square of the distance between two locations.
 */

proc findDistance(int r1, c1, r2, c2)uint:
    register uint d1, d2;

    d1 := |(r1 - r2);
    while d1 >= ES*.es_world.w_rows do
	d1 := d1 - ES*.es_world.w_rows;
    od;
    if d1 > ES*.es_world.w_rows / 2 then
	d1 := ES*.es_world.w_rows - d1;
    fi;
    d2 := |(c1 - c2);
    while d2 >= ES*.es_world.w_columns do
	d2 := d2 - ES*.es_world.w_columns;
    od;
    if d2 > ES*.es_world.w_columns / 2 then
	d2 := ES*.es_world.w_columns - d2;
    fi;
    d1 * d1 + d2 * d2
corp;

/*
 * getItemCost - return the cost per unit of various items.
 */

proc getItemCost(ItemType_t what)uint:

    case what
    incase it_shells:
	ES*.es_world.w_shellCost
    incase it_guns:
	ES*.es_world.w_gunCost
    incase it_planes:
	ES*.es_world.w_planeCost
    incase it_bars:
	ES*.es_world.w_barCost
    default:
	/* ore, in particular */
	1
    esac
corp;

/*
 * readShipQuan - read the quantity of stuff the ship is carrying.
 */

proc readShipQuan(register *Ship_t sh; ItemType_t what)uint:

    case what
    incase it_civilians:
    incase it_military:
	sh*.sh_crew
    incase it_shells:
	sh*.sh_shells
    incase it_guns:
	sh*.sh_guns
    incase it_planes:
	sh*.sh_planes
    incase it_ore:
	sh*.sh_ore
    incase it_bars:
	sh*.sh_bars
    default:
	err("bad item type in 'readShipQuan'");
	0
    esac
corp;

/*
 * writeShipQuan - write the quantity of stuff to the ship.
 */

proc writeShipQuan(*Ship_t sh; ItemType_t what; uint quantity)void:

    quantity := umin(ES*.es_world.w_shipCapacity[what][sh*.sh_type], quantity);
    case what
    incase it_civilians:
    incase it_military:
	sh*.sh_crew := quantity;
    incase it_shells:
	sh*.sh_shells := quantity;
    incase it_guns:
	sh*.sh_guns := quantity;
    incase it_planes:
	sh*.sh_planes := quantity;
    incase it_ore:
	sh*.sh_ore := quantity;
    incase it_bars:
	sh*.sh_bars := quantity;
    default:
	err("bad item type in 'writeShipQuan'");
    esac;
corp;

/*
 * getNavCost - return the cost of navigating the given ship type one
 *	sector orthogonally. The result is x 10.
 */

proc getNavCost(*Ship_t sh)uint:
    uint tf;

    tf := getShipTechFactor(sh);
    make(ES*.es_world.w_shipSpeed[sh*.sh_type], ulong) *
	 (10000 / tf * 2) / (10000 / tf + 100) / 10
corp;

/*
 * damageUnit - do damage to one quantity randomly.
 */

proc damageUnit(register uint quantity, damage)uint:
    uint units, portion;

    if damage > 100 then
	damage := 100;
    fi;
    units := quantity * damage;
    portion := units % 100;
    quantity := quantity - units / 100;
    if random(100) < portion then
	quantity - 1
    else
	quantity
    fi
corp;

/*
 * zapSpan -
 *	waste a bridge span - also used in other places.
 */

proc zapSpan(register *Sector_t s)void:
    register ItemType_t it;

    s*.s_type := s_water;
    s*.s_owner := 0;
    s*.s_efficiency := 0;
    s*.s_mobility := 0;
    s*.s_defender := NO_DEFEND;
    s*.s_checkPoint := 0;
    for it from it_first upto it_last do
	s*.s_quantity[it] := 0;
    od;
corp;

/*
 * damageSector - do damage to a sector as a result of shelling, etc.
 *	Convention - the sector is locked.
 */

proc damageSector(register uint mapped, damage; uint responsible)void:
    register *Sector_t rs;
    register *Country_t rc @ rs;
    register uint owner;
    register ItemType_t it @ owner;

    rs := &ES*.es_request.rq_u.ru_sector;
    rs*.s_efficiency := damageUnit(rs*.s_efficiency, damage);
    rs*.s_mobility := damageUnit(rs*.s_mobility, damage);
    for it from it_first upto it_last do
	writeQuan(rs, it, damageUnit(readQuan(rs, it), damage));
    od;
    rs*.s_production := damageUnit(rs*.s_production, damage);
    owner := rs*.s_owner;
    if rs*.s_type = s_bridgeSpan and rs*.s_efficiency < 20 then
	zapSpan(rs);
    fi;
    if owner ~= 0 and
	rs*.s_quantity[it_civilians] = 0 and rs*.s_quantity[it_military] = 0
    then
	rs*.s_owner := 0;
	rs*.s_defender := NO_DEFEND;
	rs*.s_checkPoint := 0;
	server(rt_unlockSector, mapped);
	server(rt_lockCountry, owner);
	rc*.c_sectorCount := rc*.c_sectorCount - 1;
	if rc*.c_sectorCount = 0 then
	    rc*.c_status := cs_dead;
	    server(rt_unlockCountry, owner);
	    /* the target county is kaput!!!! */
	    user3("Country ", &rc*.c_name[0], " has been destroyed!!!\n");
	    news(n_destroyed, responsible, owner);
	else
	    server(rt_unlockCountry, owner);
	fi;
	if owner = ES*.es_countryNumber then
	    ES*.es_country := rc*;
	fi;
	server(rt_lockSector, mapped);
    fi;
corp;

/*
 * fleetPos - return the index of a fleet corresponding to the letter given.
 */

proc fleetPos(register char ch)uint:

    if ch >= 'a' and ch <= 'z' then
	ch - 'a'
    elif ch >= 'A' and ch <= 'Z' then
	ch - ('A' - 26)
    else
	0
    fi
corp;

/*
 * removeFromFleet - remove the given ship from whatever fleet it is in.
 *	Leave it saying it is in fleet '*'. We pass in 'owner', since the
 *	ship itself may have been updated to have some other owner.
 *	Convention: the ship is locked before and after the call.
 */

proc removeFromFleet(uint owner, shipNumber)void:
    register *Ship_t rsh;
    register *Fleet_t rf @ rsh;
    register uint fleet, i;

    rsh := &ES*.es_request.rq_u.ru_ship;
    if rsh*.sh_fleet ~= '*' then
	i := fleetPos(rsh*.sh_fleet);
	server(rt_unlockShip, shipNumber);
	if owner = ES*.es_countryNumber then
	    fleet := ES*.es_country.c_fleets[i];
	else
	    server(rt_readCountry, owner);
	    fleet := ES*.es_request.rq_u.ru_country.c_fleets[i];
	fi;
	server(rt_lockFleet, fleet);
	i := 0;
	while rf*.f_ship[i] ~= shipNumber do
	    i := i + 1;
	od;
	while i ~= rf*.f_count - 1 do
	    rf*.f_ship[i] := rf*.f_ship[i + 1];
	    i := i + 1;
	od;
	rf*.f_count := rf*.f_count - 1;
	server(rt_unlockFleet, fleet);
	server(rt_lockShip, shipNumber);
	rsh*.sh_fleet := '*';
    fi;
corp;

/*
 * decrShipCount - decrement the ship count in the given sector.
 *	Assumption: nothing is locked.
 */

proc decrShipCount(uint mapped)void:

    server(rt_lockSector, mapped);
    ES*.es_request.rq_u.ru_sector.s_shipCount :=
	ES*.es_request.rq_u.ru_sector.s_shipCount - 1;
    server(rt_unlockSector, mapped);
corp;

/*
 * incrShipCount - decrement the ship count in the given sector.
 *	Assumption: nothing is locked.
 */

proc incrShipCount(uint mapped)void:

    server(rt_lockSector, mapped);
    ES*.es_request.rq_u.ru_sector.s_shipCount :=
	ES*.es_request.rq_u.ru_sector.s_shipCount + 1;
    server(rt_unlockSector, mapped);
corp;

/*
 * damageShip - do damage to a ship as a result of shelling, mine, etc.
 *	Convention - the ship is locked.
 */

proc damageShip(register uint shipNumber, damage)void:
    register *Ship_t rsh;
    uint owner;

    rsh := &ES*.es_request.rq_u.ru_ship;
    rsh*.sh_efficiency := damageUnit(rsh*.sh_efficiency, damage);
    rsh*.sh_crew := damageUnit(rsh*.sh_crew, damage);
    rsh*.sh_shells := damageUnit(rsh*.sh_shells, damage);
    rsh*.sh_guns := damageUnit(rsh*.sh_guns, damage);
    rsh*.sh_planes := damageUnit(rsh*.sh_planes, damage);
    rsh*.sh_ore := damageUnit(rsh*.sh_ore, damage);
    rsh*.sh_bars := damageUnit(rsh*.sh_bars, damage);
    if rsh*.sh_mobility > 0 then
	rsh*.sh_mobility := damageUnit(rsh*.sh_mobility, damage);
    fi;
    if rsh*.sh_efficiency < 20 then
	owner := rsh*.sh_owner;
	removeFromFleet(owner, shipNumber);
	rsh*.sh_owner := 0;
	server(rt_unlockShip, shipNumber);
	if owner = ES*.es_countryNumber then
	    user(getShipName(rsh*.sh_type));
	    userN3(" \#", shipNumber, " sunk!\n");
	fi;
	decrShipCount(mapAbsSector(rsh*.sh_row, rsh*.sh_col));
	server(rt_lockShip, shipNumber);
    fi;
corp;

/*
 * attackShip - the current player is attacking a ship.
 */

proc attackShip(uint shipNumber, damage; AttackType_t at; *char prefix)void:
    register *Ship_t rsh;
    uint owner;

    server(rt_lockShip, shipNumber);
    updateShip(shipNumber);
    rsh := &ES*.es_request.rq_u.ru_ship;
    owner := rsh*.sh_owner;
    damage := damage * ES*.es_world.w_shipDamage[rsh*.sh_type];
    if damage > 100 then
	damage := 100;
    fi;
    damageShip(shipNumber, damage);
    server(rt_unlockShip, shipNumber);
    user(
	case at
	incase at_bomb:
	    "Bomb"
	incase at_shell:
	    "Shell"
	incase at_torp:
	    "Torpedo"
	incase at_drop:
	    "Splash! .. Kawhoomph! Depth charge"
	esac);
    userN3(" does ", damage, "% damage to ");
    user(getShipName(rsh*.sh_type));
    userN2(" \#", shipNumber);
    if rsh*.sh_owner = 0 then
	user(" - sunk");
    fi;
    user("!\n");
    if at = at_torp then
	/* don't know who the attacker was */
	news(n_torp_ship, owner, owner);
    else
	news(
	    case at
	    incase at_bomb:
		n_bomb_ship
	    incase at_shell:
		n_shell_ship
	    incase at_drop:
		n_drop_sub
	    esac,
	    ES*.es_countryNumber, owner);
    fi;
    user(prefix);
    userSp();
    user(
	case at
	incase at_bomb:
	    "bombed"
	incase at_shell:
	    "fired at"
	incase at_torp:
	    "torpedoed"
	incase at_drop:
	    "depth charged"
	esac);
    if rsh*.sh_owner = 0 then
	user(" and sank");
    fi;
    user2(" your ", getShipName(rsh*.sh_type));
    userN3(" \#", shipNumber, "!");
    notify(owner);
    if at = at_drop and rsh*.sh_owner = 0 then
	server(rt_readCountry, owner);
	user3("Debris bears the markings of ",
	      &ES*.es_request.rq_u.ru_country.c_name[0], "\n");
    fi;
corp;

/*
 * verifyCheckPoint - ask for and check a checkpoint code for access to
 *	another country's sector.
 */

proc verifyCheckPoint(int r, c; *Sector_t s)bool:
    int check;

    userS("Checkpoint code for sector ", r, c, ": ");
    uFlush();
    if not ES*.es_readUser() or not getNumber(&check) or
	check ~= s*.s_checkPoint
    then
	err("access denied!!");
	false
    else
	true
    fi
corp;

/*
 * torpCost - deduct mobility and shell cost for torpedoing.
 *	Assumption - the submarine is locked.
 */

proc torpCost()void:
    register *Ship_t rsh;
    register uint shells;

    rsh := &ES*.es_request.rq_u.ru_ship;
    shells := readShipQuan(rsh, it_shells);
    writeShipQuan(rsh, it_shells,
	if shells >= ES*.es_world.w_torpCost then
	    shells - ES*.es_world.w_torpCost
	else
	    0
	fi);
    if ES*.es_world.w_torpMobCost ~= 0 then
	rsh*.sh_mobility :=
	    if rsh*.sh_mobility >= 0 then
		-ES*.es_world.w_torpMobCost
	    elif rsh*.sh_mobility <=
		    make(-128 + ES*.es_world.w_torpMobCost, int)
	    then
		-128
	    else
		rsh*.sh_mobility - ES*.es_world.w_torpMobCost
	    fi;
    fi;
corp;

/*
 * dropCost - deduct mobility and shell cost for dropping a torpedo.
 *	Assumption - the destroyer is locked.
 */

proc dropCost()void:
    register *Ship_t rsh;
    register uint shells;

    rsh := &ES*.es_request.rq_u.ru_ship;
    shells := readShipQuan(rsh, it_shells);
    writeShipQuan(rsh, it_shells,
	if shells > ES*.es_world.w_chargeCost then
	    shells - ES*.es_world.w_chargeCost
	else
	    0
	fi);
    if ES*.es_world.w_chargeMobCost ~= 0 then
	rsh*.sh_mobility :=
	    if rsh*.sh_mobility >= 0 then
		-ES*.es_world.w_chargeMobCost
	    elif rsh*.sh_mobility <=
		make(-128 + ES*.es_world.w_chargeMobCost, int)
	    then
		-128
	    else
		rsh*.sh_mobility - ES*.es_world.w_chargeMobCost
	    fi;
    fi;
corp;
