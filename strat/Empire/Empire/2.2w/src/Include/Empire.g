/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * Empire.g - include file for Amiga Empire.
 *
 *      Date: October 24, 1987, last updated March 1990
 *      Author: Chris Gray
 * $Id: Empire.g,v 1.17 90/08/21 00:29:04 DaveWT Exp $
 * $Log:	Empire.g,v $
Revision 1.17  90/08/21  00:29:04  DaveWT
Changed w_tmp3 to w_doingPower. Set to TRUE if a country is updating the
power report.

Revision 1.16  90/08/15  00:21:18  DaveWT
Changed the w_tmp4 field to w_userFlush to allow users to use the flush
command.

Revision 1.15  90/06/02  01:31:35  DaveWT
Added boolean flag "w_doFlush" to World_t structure. If true, then
buffers are flushed whenever a country logs out or changes country,
just like version 2.0.

Revision 1.14  90/05/04  23:17:03  DaveWT
Allocated the c_tmp1 element for use as the default value for compressed
maps. Using the ! or compressed flags will temporarily invert the value.

Revision 1.13  90/04/30  18:18:21  DaveWT
Added the boolean flags inChat, temp1, and temp2 to the country struct.
All appears to work well, after converting the country data file.
inChat indicates whether a country is in chat mode.

Revision 1.12  90/04/13  10:01:22  DaveWT
Added 1 char to the password length, so that the scripts and docs don't
have to be changed. The default password of "creationpassword" was one
character longer than the 16 char limit allowed.

 */

/*
 * adjustable parameters - if you want to change these, be careful, and then
 *      recompile everything, including EmpCre.
 */

uint
    NAME_LEN               = 32,        /* max length of country name*/
    PASSWORD_LEN           = 17,        /* max length of password */
    INPUT_LENGTH           = 500,       /* max length of input line */
    COUNTRY_MAX            = 45,        /* max number of countries */
    REALM_MAX              = 6,         /* max number of realms */
    FLEET_MAX              = 100,       /* max ships in a fleet */
    MAX_NAV_SHIPS          = 32,        /* max ships in a nav list */
    MIN_SHIP_EFFIC         = 60,        /* min ship effic for operation */
    NOBODY                 = COUNTRY_MAX, /* author of automatic message */
    SINGLE_SECTOR          = 0xffff;    /* single sector in scanSectors */

*char
    EMPIRE_PORT_NAME = "Empire port",   /* The IPC port for Empire */

    CONNECT_MESSAGE_FILE   = "empire.conMess", /* displayed at connect */
    LOGIN_MESSAGE_FILE     = "empire.logMess", /* displayed after log on */
    LOGOUT_MESSAGE_FILE    = "empire.hangMess",/* displayed at log out */
    BULLETIN_FILE          = "empire.bulletin",/* displayed in news    */
    ACCESS_FILE            = "empire.access",  /* how to get on the system */
    POWER_FILE             = "empire.power";   /* power report file    */

int
    HURRICANE_FORCE = -9,               /* <= this does damage */
    MONSOON_FORCE = -6,                 /* <= this stops work */
    STORM_FORCE = -2;                   /* <= this slows work */

/*
 * do not change anything from here on down
 */

ushort
    NO_DELIVER = 8,                     /* item not being delivered */
    NO_DEFEND = 0x88;                   /* sector not being defended */

uint
    NO_FLEET = 0xffff;                  /* country has no such fleet */

type
    ItemType_t = enum {                 /* item (commodity) types */
        it_civilians,
        it_military,
        it_shells,
        it_guns,
        it_planes,
        it_ore,
        it_bars
    };

ItemType_t it_first = it_civilians, it_last = it_bars;

[range(ItemType_t) + 1] char ITEM_CHAR = "cmsgpob";

type
    SectorType_t = enum {               /* sector designations */
        s_sanctuary,
        s_wilderness,
        s_water,
        s_mountain,
        s_capital,
        s_urban,
        s_defense,
        s_industry,
        s_ironMine,
        s_goldMine,
        s_harbour,
        s_warehouse,
        s_technical,
        s_fortress,
        s_research,
        s_highway,
        s_airport,
        s_radar,
        s_weather,
        s_bridgeHead,
        s_bridgeSpan,
        s_bank,
        s_exchange,
        s_bootCamp
    };

SectorType_t s_first = s_sanctuary, s_last = s_bootCamp;

[range(SectorType_t) + 1] char SECTOR_CHAR = "s-.^cudimghwtfr+*)!\#=bxa";

type
    Sector_t = struct {
        ulong s_lastUpdate;             /* time sector last updated */
        uint s_shipCount;               /* number of ships here */
        SectorType_t s_type;            /* designation of this sector */
        short s_checkPoint;             /* checkpoint code */
        ushort
            s_owner,                    /* country number of owner */
            s_iron,                     /* iron ore deposit value */
            s_gold,                     /* gold ore deposit value */
            s_efficiency,               /* efficiency of this sector */
            s_mobility,                 /* mobility available here */
            s_production,               /* production available here */
            s_price,                    /* contract price in nickels */
            s_defender,                 /* offset of defending fort */
            s_plagueStage,              /* 0, 1, 2 or 3 */
            s_plagueTime;               /* time until next stage */
        [range(ItemType_t)] ushort
            s_direction,                /* item delivery directions */
            s_threshold,                /* item delivery thresholds */
            s_quantity;                 /* item quantities here */
    },

    ShipType_t = enum {                 /* ship types */
        st_PTBoat,
        st_submarine,
        st_battleship,
        st_destroyer,
        st_freighter,
        st_mineSweeper,
        st_tender,
        st_carrier
    };

ShipType_t st_first = st_PTBoat, st_last = st_carrier;

[range(ShipType_t) + 1] char SHIP_CHAR = "psbdfmtc";

type
    Weather_t = struct {
        ulong we_update;                /* time of last weather update */
        int
            we_hiRowInc,                /* speed of high in rows */
            we_hiColInc,                /* speed of high in cols */
            we_loRowInc,                /* speed of low in rows */
            we_loColInc;                /* speed of low in cols */
        uint                            /* these are x 4 for accuracy */
            we_hiRow,                   /* row of current high pressure */
            we_hiCol,                   /* col of current high pressure */
            we_loRow,                   /* row of current low pressure */
            we_loCol,                   /* col of current low pressure */
            we_seed;                    /* private seed for weather gen */
        int
            we_hiPressure,              /* value of current high pressure */
            we_loPressure,              /* value of current low pressure */
            we_hiMin,                   /* minimum value for high */
            we_hiMax,                   /* maximum value for high */
            we_loMin,                   /* minimum value for low */
            we_loMax;                   /* maximum value for low */
    },

    World_t = struct {

        /* miscellaneous fixed fields */

        ulong w_lastRun;                /* time of last use of Empire */
        ulong w_buildDate;              /* date the world was built */
        [NAME_LEN] char w_winName;      /* Name of last winner         */
        ulong w_secondsPerETU;          /* length of an Empire time unit */
        uint
            w_rows,                     /* number of rows in world */
            w_columns,                  /* number of columns in world */
            w_maxCountries,             /* maximum allowed number of users */
            w_currCountries,            /* number of entered users */
            w_maxConnect,               /* max time in minutes per day */
            w_maxBTUs;                  /* max BTUs held by a country */
        [PASSWORD_LEN] char
            w_password;                 /* password for when create country */

        Weather_t w_weather;            /* represent the weather */

        /* global counters */

        uint
            w_loanNext,                 /* number of next loan */
            w_treatyNext,               /* number of next treaty */
            w_offerNext,                /* number of next sale offering */
            w_shipNext,                 /* number of next ship */
            w_fleetNext;                /* number of next fleet */

        /* production costs */

        uint
            w_resCost,                  /* production for one research */
            w_techCost,                 /* production for one tech */
            w_gunCost,                  /* production for one gun */
            w_shellCost,                /* production for one shell */
            w_planeCost,                /* production for one plane */
            w_barCost;                  /* production for one bar of gold */

        /* various mobility costs */

        uint
            w_mountMob,                 /* cost of move to mountain */
            w_wildMob,                  /* cost of move to wilderness */
            w_defMob,                   /* cost of move to regular */
            w_civMob,                   /* cost of moving 5 civilians */
            w_milMob,                   /*   "   "    "   5 military */
            w_shellMob,                 /*   "   "    "   5 shells */
            w_gunMob,                   /*   "   "    "   1 gun */
            w_planeMob,                 /*   "   "    "   1 plane */
            w_oreMob,                   /*   "   "    "   5 ore */
            w_barMob;                   /*   "   "    "   1 bar */

        /* plague adjusters */

        uint
            w_plagueKiller,             /* (227) divisor for die rate */
            w_plagueBooster,            /* replace the 100 in top */
            w_plagueOneBase,            /* duration of stage one */
            w_plagueOneRand,
            w_plagueTwoBase,            /* duration of stage two */
            w_plagueTwoRand,
            w_plagueThreeBase,          /* duration of stage three */
            w_plagueThreeRand;

        /* various monetary rates */

        uint
            w_efficCost,                /* cost of one unit of increase */
            w_milSuppliesCost,          /* (mil / 32) * dt / X => dollars */
            w_utilityRate,              /* is 1 in PSL */
            w_interestRate,             /* in percent */
            w_bridgeCost,               /* cost of a bridge span */
            w_shipCostMult,             /* in $ per build unit */
            w_refurbCost;               /* cost of 1 level of ship refurb */

        /* scale factors for production */

        uint
            w_resScale,                 /* X / 100 scales production */
            w_techScale,                /* X / 100 scales production */
            w_defenseScale,             /* X / 100 scales production */
            w_shellScale,               /* X / 100 scales production */
            w_airportScale,             /* X / 100 scales production */
            w_harborScale,              /* X / 100 scales production */
            w_bridgeScale,              /* X / 100 scales production */
            w_goldScale,                /* X / 100 scales production */
            w_ironScale,                /* X / 100 scales production */
            w_shipWorkScale;            /* X / 100 scales ship work */

        /* factors affecting sector updates */

        uint
            w_efficScale,               /* X / 100 scales increase */
            w_mobilScale,               /* X / 100 scales increase */
            w_urbanGrowthFactor,        /* replace the 100 in PSL formula */
            w_bridgeDieFactor,          /* replace the 400 in PSL formula */
            w_highGrowthFactor,         /* replace the 200 in PSL formula */
            w_lowGrowthFactor,          /* replace the 400 in PSL formula */
            w_BTUDivisor,               /* high gives less new BTU's */
            w_resDecreaser,             /* 10 x percent loss per day */
            w_techDecreaser,            /* 10 x percent loss per day */
            w_hurricaneLandBase,        /* hurricane damage to land */
            w_hurricaneLandRand,
            w_hurricaneSeaBase,         /* hurricane damage to ships */
            w_hurricaneSeaRand;

        /* various attack advantages */

        uint
            w_assFortAdv,               /* advantage under assault of fort */
            w_assCapAdv,                /*     "       "      "     " cap */
            w_assBankAdv,               /*     "       "      "     " bank */
            w_attFortAdv,               /* advantage under attack of fort */
            w_attCapAdv,                /*     "       "      "    " cap */
            w_attBankAdv,               /*     "       "      "    " bank */
            w_assAdv,                   /* X / 100 scales assault defense */
            w_fortAdv,                  /* advantage attacking from fort */
            w_boardAdv;                 /* X / 100 is adv of board defense */

        /* torpedoes, depth charges, and mines */

        uint
            w_torpCost,                 /* how many shells per torpedo */
            w_torpMobCost,              /* mobility cost for torpedoing */
            w_torpRange,                /* max range of torpedo */
            w_torpAcc0,                 /* percent hit at range 0 */
            w_torpAcc1,                 /*     "    "   "   "   1 */
            w_torpAcc2,                 /*     "    "   "   "   2 */
            w_torpAcc3,                 /*     "    "   "   "   3 or more */
            w_torpBase,                 /* damage done by torpedo */
            w_torpRand,
            w_chargeCost,               /* shells per depth charge */
            w_chargeMobCost,            /* mobility cost for depth charging */
            w_chargeBase,               /* damage done by depth charge */
            w_chargeRand,
            w_mineBase,                 /* damage by one mine */
            w_mineRand;

        /* airplane factors */

        uint
            w_fuelTankSize,             /* capacity of plane fuel tank */
            w_fuelRichness,             /* replace the normal 4 */
            w_flakFactor,               /* replace the 7 divisor, etc. */
            w_landScale,                /* X / 100 scales landing chances */
            w_bombBase,                 /* damage per bomb */
            w_bombRand,
            w_planeBase,                /* damage per crashing plane */
            w_planeRand;

        /* miscellaneous adjustable factors */

        uint
            w_contractScale,            /* X / 100 scales contract offers   */
            w_deathFactor,              /* BTU cost per death (* 100)       */
            w_gunMax,                   /* replace the normal 7             */
            w_rangeDivisor,             /* r ** 2 = (tech * guns) ** 2 / X  */
            w_gunScale,                 /* X / 100 scales gun damage        */
            w_lookShipFact,             /* see if d**2 < r**2 * sz**2 / X   */
            w_collectScale,             /* X / 100 scales collect price     */
            w_radarFactor,              /* replace 61 in land radar range   */
            w_spyFactor,                /* larger means spies better        */
            w_shipTechDecreaser;        /* 100 x percent loss per day       */

        /* various flag-type things */

        bool
            w_sendAll,                  /* Allow people to send public msgs */
            w_chaCou,                   /* Allow people to change country   */
            w_doFlush,                  /* Flush buffers on logout?         */
            w_doingPower,               /* true if a count is updtg pwr rpt */
            w_userFlush,                /* anyone can flush buffers         */
            w_nonDeityPower,            /* anyone can force a power         */
            w_sortCountries;            /* sort by name in 'country'        */

        /* mobility cost of attacking */

        [4, 4] uint
            w_attackMobilityCost;       /* cost of attacks in mobility */

        /* arrays of various ship factors */

        [range(ShipType_t)] uint
            w_shipCost,                 /* cost of ships */
            w_shipSize,                 /* size of ships */
            w_shipRange,                /* lookout range of ships */
            w_shipSpeed,                /* mobility cost of ships */
            w_shipShRange,              /* shelling range */
            w_shipDamage;               /* relative damageability */
        [range(ItemType_t)][range(ShipType_t)] uint
            w_shipCapacity;             /* how many of each they can carry */
    },

    CountryStatus_t = enum {
        cs_deity, cs_active, cs_dead, cs_quit, cs_idle, cs_visitor
    },

    Relation_t = enum {r_neutral, r_allied, r_war},

    Realm_t = struct {
        int r_top, r_bottom, r_left, r_right;
    },

    Country_t = struct {
        ulong
            c_lastOn,                   /* time of last connect */
            c_timeLeft,                 /* amount of real time left */
            c_telegramsNew,             /* offset of first new one */
            c_telegramsTail;            /* next available offset */
        long c_money;                   /* money he has */
        uint
            c_centerRow,                /* absolute row of capital */
            c_centerCol,                /* absolute column of capital */
            c_techLevel,                /* technology level */
            c_resLevel,                 /* research level */
            c_sectorCount,              /* number of sectors owned */
            c_btu;                      /* btu's remaining */
        [26 + 26] uint c_fleets;        /* map letters to fleet #'s */
        CountryStatus_t c_status;       /* current status */
        [NAME_LEN] char c_name;         /* country name */
        [PASSWORD_LEN] char c_password; /* password */
        [REALM_MAX] Realm_t c_realms;   /* his defined realms */
        [COUNTRY_MAX] Relation_t c_relations;   /* int'l relations */
        bool
            c_loggedOn,                 /* logged on right now */
            c_inChat,                   /* in chat mode        */
            c_compressed,               /* default mode for map*/
            c_tmp2;                     /* for future use      */
        enum {
            nt_telegram,                /* notify => telegram */
            nt_message,                 /* notify => message */
            nt_both                     /* notify => both */
        } c_notify;
    },

    Ship_t = struct {
        ulong sh_lastUpdate;            /* time of last update */
        uint sh_price;                  /* price if for sale */
        uint sh_techLevel;              /* technology level of ship */
        ShipType_t sh_type;             /* type of this ship */
        char sh_fleet;                  /* letter of fleet it's in */
        ushort
            sh_owner,                   /* who owns it */
            sh_efficiency,              /* current efficiency */
            sh_row,                     /* absolute row it's at */
            sh_col,                     /* absolute column it's at */
            sh_crew,                    /* # of civilians or military */
            sh_shells,                  /* # shells on board */
            sh_guns,                    /* # guns on board */
            sh_planes,                  /* # planes on board */
            sh_ore,                     /* amount of ore on board */
            sh_bars;                    /* # gold bars on board */
        short sh_mobility;              /* current amount of mobility */
    },

    Fleet_t = struct {
        uint f_count;                   /* number of ships now in fleet */
        [FLEET_MAX] uint f_ship;        /* the ships in the fleet */
    },

    Loan_t = struct {
        ulong
            l_lastPay,                  /* time of last payment */
            l_dueDate;                  /* when payment is due */
        uint
            l_amount,                   /* amount left to pay */
            l_paid;                     /* amount paid so far */
        ushort
            l_duration,                 /* duration in days */
            l_rate,                     /* interest rate (daily) */
            l_loaner,                   /* who made the loan */
            l_loanee;                   /* who the loan is to */
        enum {l_offered, l_declined, l_outstanding, l_paidUp} l_state;
    },

    Offer_t = struct {
        enum {of_ship, of_sector, of_none} of_state;
        ushort of_who;                  /* who is offering it */
        union {
            uint of_shipNumber;         /* ship offered */
            struct {
                ushort of_row, of_col;  /* exchange of offer */
            } of_sect;
        } of_;
    },

    NewsType_t = enum {
        n_nothing,                      /* dummy - no action */
        n_won_sector,                   /* actor won a sector */
        n_lost_sector,                  /* actor failed to win a sector */
        n_spy_shot,                     /* actor had a spy shot */
        n_sent_telegram,                /* actor sent a telegram */
        n_sign_treaty,                  /* actor signed a treaty */
        n_make_loan,                    /* actor made a loan */
        n_repay_loan,                   /* actor repaid a loan */
        n_make_sale,                    /* actor made a sale */
        n_grant_sector,                 /* actor granted a sector */
        n_shell_sector,                 /* actor shelled a sector */
        n_shell_ship,                   /* actor shelled a ship */
        n_took_unoccupied,              /* actor took an empty sector */
        n_torp_ship,                    /* actor torpedoed a ship */
        n_fire_back,                    /* actor fired in self-defense */
        n_broke_sanctuary,              /* actor broke sanctuary */
        n_bomb_sector,                  /* actor bombed a sector */
        n_bomb_ship,                    /* actor bombed a ship */
        n_board_ship,                   /* actor boarded a ship */
        n_failed_board,                 /* actor failed to board a ship */
        n_flak,                         /* actor fired on aircraft */
        n_sieze_sector,                 /* actor siezed a sector (loan) */
        n_honor_treaty,                 /* actor decided to honor treaty */
        n_violate_treaty,               /* actor violated a treaty */
        n_dissolve,                     /* actor disolved government */
        n_hit_mine,                     /* actor had a ship hit a mine */
        n_decl_ally,                    /* actor declared alliance */
        n_decl_neut,                    /* actor declared neutrality */
        n_decl_war,                     /* actor declared war */
        n_disavow_ally,                 /* actor disavowed former alliance */
        n_disavow_war,                  /* actor disavowed former war */
        n_storm_sector,                 /* actor had hurricane damage */
        n_storm_ship,                   /* actor had hurricane damage */
        n_plague_outbreak,              /* actor had outbreak of plague */
        n_plague_die,                   /* actor had plague deaths */
        n_name_change,                  /* actor changed country name */
        n_drop_sub,                     /* actor depth charged a sub */
        n_destroyed,                    /* actor has been destroyed */
        n_reborn,                       /* actor saved himself */
        n_spy_caught,                   /* actor had a spy caught deported  */
        n_ship_sunk,                    /* actor sunk a ship    */
        n_weather_dest,                 /* actor destroyed by bad weather   */
        n_plague_dest,                  /* actor destroyed by plague */
        n_suicide,                      /* actor committed national suicide */
        n_torp_sunk                     /* actor had a ship sunk by torp */
    },

    News_t = struct {
        ulong n_time;                   /* time when it happened */
        NewsType_t n_verb;              /* what he did */
        ushort
            n_actor,                    /* who did it */
            n_victim,                   /* who he did it to */
    },

    Nav_t = struct {
        uint n_ship;
        int n_mobil;
        bool n_active;
    },

    AttackType_t = enum {
        at_bomb,
        at_shell,
        at_torp,
        at_drop
    };
