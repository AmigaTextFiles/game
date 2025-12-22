/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * EmpPrivate.g - definitions private to the Empire library.
 */

uint
    INPUT_BUFFER_SIZE = 500,
    OUTPUT_BUFFER_SIZE = 500;

type

    Request_t = unknown REQUEST_PRIVATE_SIZE + 20 + 4 * 2 + 2 * 2 + 1 * 2,

    EmpireState_t = struct {

	/* fields used to interface to the library caller */

	proc()void es_serverRequest;
	proc()void es_writeUser;
	proc()bool es_readUser;
	proc()void es_echoOff;
	proc()void es_echoOn;
	proc()bool es_gotControlC;
	proc(/* uint tenthsOfSecond */)void es_sleep;
	proc(/* *char fileName */)bool es_log;
	Request_t es_request;
	[INPUT_BUFFER_SIZE] char es_textIn;
	[OUTPUT_BUFFER_SIZE] char es_textOut;
	*char es_textInPos;
	uint es_textOutPos;

	/* fields which cache values used often or required in general */

	World_t es_world;
	Country_t es_country;
	uint es_countryNumber;
	[range(SectorType_t) + 1]char es_sectorChar;
	[range(ShipType_t) + 1]char es_shipChar;
	[range(ItemType_t) + 1]char es_itemChar;
	uint es_seed;
	ulong es_contractEarnings, es_interestEarnings, es_improvementCost,
	    es_militaryCost, es_utilitiesCost;
	bool es_noWrite, es_quietUpdate, es_verboseUpdate;

	/* used during the 'forecast' command */

	Weather_t es_wTemp;

	/* used during the 'navigate' command */

	[MAX_NAV_SHIPS] Nav_t es_movingShips;
	uint es_movingShipCount;

	/* general utility fields used by various commands */

	ulong es_ulong1, es_ulong2, es_ulong3, es_ulong4;
	long es_long1, es_long2, es_long3, es_long4;
	uint es_uint1, es_uint2, es_uint3, es_uint4;
	int es_int1, es_int2, es_int3, es_int4;
	bool es_bool1, es_bool2, es_bool3, es_bool4;
	SectorType_t es_sectorType1, es_sectorType2;
	ShipType_t es_shipType1, es_shipType2;
	ItemType_t es_itemType1, es_itemType2;
    },

    FileType_t = enum {ft_normal, ft_help, ft_doc};

/* functions exported from the various source files */

extern

    /* startup.d */

    user(*char str)void,
    userNL()void,
    userC(char ch)void,
    userSp()void,
    uFlush()void,
    uPrompt(*char prompt)void,
    userN(long n)void,
    userF(long n; int digits)void,
    userX(ulong n; uint digits)void,
    user2(*char m1, m2)void,
    user3(*char m1, m2, m3)void,
    userN2(*char m1; long n)void,
    userN3(*char m1; long n; *char m2)void,
    userS(*char m1; int r, c; *char m2)void,
    userTarget(uint country; *char m1; int r, c; *char m2)void,
    userM3(*char m1; uint price; *char m2)void,
    getPrompt(*char buffer)void,
    ask(*char question)bool,
    server(RequestType_t rt; uint whichUnit)void,
    server2(RequestType_t rt; uint whichUnit, otherUnit)void,
    log3(*char m1, m2, m3)void,
    cmd_flush()void,
    cmd_tickle()void,
    cmd_log()void,
    sleep(uint tenthsOfSeconds)void,
    uTime(ulong time)void,
    printFile(*char fileName; FileType_t ft)bool,
    news(NewsType_t verb; uint actor, victim)void,
    getPassword(*char prompt, password)bool,
    newCountryPassword()bool,
    updateTimer()bool,
    resetTimer()bool,

    /* util.d */

    timeRound(ulong t)ulong,
    timeNow()ulong,
    random(uint rang)uint,
    lookupCommand(*char commandList, command)uint,
    dash(uint count)void,
    rowToAbs(int r)uint,
    colToAbs(int c)uint,
    rowToCou(uint user, rp)int,
    colToCou(uint user, cp)int,
    rowToMe(uint rp)int,
    colToMe(uint rc)int,
    err(*char mess)void,
    getDesigName(SectorType_t desig)*char,
    getItemName(ItemType_t item)*char,
    getShipName(ShipType_t typ)*char,
    getIndex(*char types; char typ)uint,
    getShipIndex(char shipType)uint,
    getItemIndex(char itemType)uint,
    min(int a, b)int,
    umin(uint a, b)uint,
    mapAbsSector(uint r, c)uint,
    mapSector(int r, c)uint,
    accessSector(int r, c)void,
    accessShip(uint shipNumber)void,
    getBundleSize(SectorType_t sectorType; ItemType_t thingType)uint,
    readQuan(*Sector_t s; ItemType_t what)uint,
    writeQuan(*Sector_t s; ItemType_t what; uint quan)void,
    getTransportCost(SectorType_t sectorType;
		     ItemType_t thingType; uint quantity)uint,
    getTerrainCost(*Sector_t s; ulong cost)ulong,
    adjustForNewWorkers(*Sector_t s; ItemType_t what; uint quantity)void,
    getTechFactor(uint country)uint,
    getShipTechFactor(*Ship_t sh)uint,
    getDefender(int r, c; *Sector_t s; *int pRow, pCol)void,
    putDefender(int r, c; *Sector_t s; int rDefender, cDefender)void,
    findDistance(int r1, c1, r2, c2)uint,
    getItemCost(ItemType_t what)uint,
    readShipQuan(*Ship_t sh; ItemType_t what)uint,
    writeShipQuan(*Ship_t sh; ItemType_t what; uint quantity)void,
    getNavCost(*Ship_t sh)uint,
    damageUnit(uint quantity, damage)uint,
    zapSpan(*Sector_t s)void,
    damageSector(uint mapped, damage, responsible)void,
    fleetPos(char ch)uint,
    removeFromFleet(uint owner, shipNumber)void,
    decrShipCount(uint mapped)void,
    incrShipCount(uint mapped)void,
    damageShip(uint shipNumber, damage)void,
    attackShip(uint shipNumber, damage; AttackType_t at; *char prefix)void,
    verifyCheckPoint(int r, c; *Sector_t s)bool,
    torpCost()void,
    dropCost()void,

    /* parse.d */

    skipBlanks()*char,
    skipWord()*char,
    doSkipBlanks()bool,
    getNumber(*int pNum)bool,
    reqNumber(*int pNum; *char prompt)bool,
    getPosRange(*uint pQuan; uint maximum)bool,
    reqPosRange(*uint pQuan; uint maximum; *char prompt)bool,
    reqPosRange1(*uint pNum; uint maximum; *char prompt)bool,
    getBox(*int pA, pB, pC, pD)bool,
    reqBox(*int pA, pB, pC, pD; *char prompt)bool,
    reqSector(*int pA, pB; *char prompt)bool,
    reqChar(*char pChar, validSet, prompt, errMess)bool,
    reqCmsgpob(*ItemType_t pWhich; *char prompt)bool,
    reqDesig(*SectorType_t pDesig; *char prompt)bool,
    reqShipType(*ShipType_t pType; *char prompt)bool,
    reqBridgeDirection(*char pDir; *char prompt)bool,
    getCountry(*uint pCountry; bool visitorOK, blanksOK)bool,
    reqCountry(*uint pCountry; *char prompt; bool visitorOK)bool,
    getChoice(*uint pWhat; *char choices)bool,
    reqChoice(*uint pWhat; *char choices, prompt)bool,
    reqShip(*uint pShip; *char prompt)bool,
    reqSectorOrShip(*int pA, pB; *uint pS; *bool pIsShip; *char prompt)bool,
    reqShipOrFleet(*uint pShip; *char pFleet, prompt)bool,

    /* scan.d */

    getShips(*ShipScan_t shs)bool,
    reqShips(*ShipScan_t shs; *char prompt)bool,
    scanShips(*ShipScan_t shs;
	proc(uint shipNumber; *Ship_t sh)void scanner)uint,
    reqSectors(*SectorScan_t ss; *char prompt)bool,
    scanSectors(*SectorScan_t ss;
	proc(int row, col; *Sector_t s)void scanner)uint,

    /* commands.d */

    processCommands()void,

    /* cmd_edit.d */

    cmd_examine()void,
    cmd_edit()void,
    cmd_info()void,

    /* messages.d */

    getText(TextType_t tt; *char fileName; uint whichFile)bool,
    cmd_telegram()void,
    telegramCheck()void,
    messageCheck()void,
    cmd_read()void,
    cmd_headlines()void,
    cmd_newspaper()void,
    cmd_propaganda()bool,
    cmd_message()void,
    cmd_chat()void,
    notify(uint country)void,

    /* update.d */

    weatherPreserve()void,
    weatherRestore()void,
    weatherStep()void,
    weatherUpdate()void,
    weather(uint r, c)int,
    relativeSector(int r, c; uint dir; *int pNewR, pNewC)uint,
    calcPlagueFactor(*Country_t owner; *Sector_t s)uint,
    updateSector(int r, c)void,
    doShipDamage(uint shipNumber)void,
    updateShip(uint shipNumber)void,

    /* cmd_general1.d */

    cmd_change()void,
    cmd_translate()void,
    cmd_untranslate()void,
    cmd_country()void,
    cmd_census()void,
    cmd_enumerate()void,
    collapseSpans(int r, c)void,
    cmd_designate()void,
    cmd_checkpoint()bool,
    cmd_update()bool,
    cmd_nation()void,
    cmd_contract()bool,
    cmd_realm()void,
    cmd_dissolve()void,

    /* cmd_map.d */

    near(int r, c; uint country; *uint dir)bool,
    mapCoords(int left, right)void,
    mapRowStart(int r)void,
    mapRowEnd(int r)void,
    mapEmpty()void,
    cmd_map()bool,
    cmd_route()bool,
    cmd_radar()bool,
    cmd_weather()void,
    cmd_forecast()bool,

    /* cmd_move.d */

    cmd_move()bool,
    cmd_fly()bool,
    cmd_navigate()bool,

    /* cmd_general2.d */

    cmd_deliver()bool,
    cmd_enlist()bool,
    cmd_defend()bool,
    cmd_power()void,
    cmd_grant()bool,
    cmd_spy()bool,
    cmd_dump()void,

    /* cmd_general3.d */

    cmd_build()bool,
    cmd_declare()bool,
    cmd_lend()bool,
    cmd_accept()bool,
    cmd_repay()bool,
    cmd_ledger()void,
    cmd_collect()bool,

    /* cmd_general4.d */

    cmd_price()bool,
    cmd_report()bool,
    cmd_buy()bool,

    /* cmd_naval.d */

    cmd_ships()bool,
    cmd_load()bool,
    cmd_fleet()void,
    cmd_mine()bool,
    cmd_unload()bool,
    cmd_tend()bool,
    cmd_torpedo()bool,
    cmd_drop()bool,
    cmd_lookout()bool,
    cmd_refurb()bool,

    /* cmd_fight.d */

    cmd_attack()bool,
    cmd_fire()bool,
    cmd_board()bool,
    cmd_assault()bool;

register *EmpireState_t ES;
