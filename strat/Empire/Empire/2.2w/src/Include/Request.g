/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/* request structures passed between Empire server and clients */

uint
    REQUEST_PRIVATE_SIZE = 1000,
    TEXT_LENGTH = REQUEST_PRIVATE_SIZE,
    TELEGRAM_MAX = REQUEST_PRIVATE_SIZE - 3 * sizeof(uint) - sizeof(ulong),
    MESSAGE_MAX = REQUEST_PRIVATE_SIZE - 3 * sizeof(uint),

    TELE_DELETE = COUNTRY_MAX + 1,
    TELE_KEEP = COUNTRY_MAX + 2,

    MESSAGE_SENT = 0,
    MESSAGE_FAIL = 1,
    MESSAGE_NO_COUNTRY = 2;

type
    Message_t = unknown 20,

    /*
     * Types of requests:
     *
     *	The 'read' requests just return the current value of the resource.
     *	They will wait if someone has it locked. The 'lock' requests wait
     *	to lock the resource, the return the current value. The 'unlock'
     *	requests supply a new value for the resource and unlock it.
     */

    RequestType_t = enum {
	rt_nop,
	rt_log,
	rt_startClient,
	rt_stopClient,
	rt_shutDown,
	rt_flush,
	rt_poll,
	rt_writeWorld,
	rt_setCountry,
	rt_readFile,
	rt_moreFile,
	rt_readHelp,
	rt_readDoc,
	rt_message,
	rt_getMessage,
	rt_setChat,
	rt_sendChat,
	rt_news,
	rt_readNews,
	rt_propaganda,
	rt_readPropaganda,
	rt_sendTelegram,
	rt_checkMessages,
	rt_readTelegram,
	rt_writePower,
	rt_readPower,
	rt_readWorld,
	rt_lockWorld,
	rt_unlockWorld,
	rt_readWeather,
	rt_lockWeather,
	rt_unlockWeather,
	rt_readCountry,
	rt_lockCountry,
	rt_unlockCountry,
	rt_readSector,
	rt_lockSector,
	rt_unlockSector,
	rt_readShip,
	rt_lockShip,
	rt_unlockShip,
	rt_readFleet,
	rt_lockFleet,
	rt_unlockFleet,
	rt_readLoan,
	rt_lockLoan,
	rt_unlockLoan,
	rt_readOffer,
	rt_lockOffer,
	rt_unlockOffer,
	rt_readSectorPair,
	rt_lockSectorPair,
	rt_unlockSectorPair,
	rt_readShipPair,
	rt_lockShipPair,
	rt_unlockShipPair,
	rt_readSectorShipPair,
	rt_lockSectorShipPair,
	rt_unlockSectorShipPair,
	rt_createShip,
	rt_createFleet,
	rt_createLoan,
	rt_createOffer
    },

    MessageCheck_t = struct {
	bool mc_newWorld;
	bool mc_newCountry;
	bool mc_hasMessages;
	bool mc_hasNewTelegrams;
	bool mc_hasOldTelegrams;
    },

    Telegram_t = struct {
	uint te_to, te_from;
	uint te_length;
	ulong te_time;
	[TELEGRAM_MAX] char te_data;
    },

    PowerData_t = struct {
	uint pd_country;
	uint pd_sect;
	ulong pd_civ, pd_mil, pd_shell, pd_gun, pd_plane, pd_bar, pd_effic;
	uint pd_ship;
	ulong pd_tons, pd_power;
	long pd_money;
    },

    PowerHead_t = struct {
	ulong ph_lastTime;
	uint ph_countryCount;
    },

    SectorShipPair_t = struct {
	Sector_t p_s;
	Ship_t p_sh;
    },

    Request_t = struct {
	Message_t rq_message;
	ulong rq_clientId;
	ulong rq_time;
	uint rq_whichUnit;
	uint rq_otherUnit;
	RequestType_t rq_type;
	byte rq_pad;			/* to match the one in EmpLib.g */
	union {
	    MessageCheck_t ru_messageCheck;
	    Telegram_t ru_telegram;
	    News_t ru_news;
	    PowerHead_t ru_powerHead;
	    PowerData_t ru_powerData;
	    World_t ru_world;
	    Weather_t ru_weather;
	    Country_t ru_country;
	    Sector_t ru_sector;
	    Ship_t ru_ship;
	    Fleet_t ru_fleet;
	    Loan_t ru_loan;
	    Offer_t ru_offer;
	    [2] Ship_t ru_shipPair;
	    [2] Sector_t ru_sectorPair;
	    SectorShipPair_t ru_sectorShipPair;
	    [TEXT_LENGTH] char ru_text;
	    [REQUEST_PRIVATE_SIZE] byte ru_private;	/* match EmpLib.g */
	} rq_u;
    };
