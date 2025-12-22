/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

uint
    MAX_CONDITIONS = 8, 		/* max # '?' conditions */
    MAX_SHIPS = 32;			/* max # specific ships */

type
    Condition_t = struct {
	int c_left;
	char c_operator;
	int c_right;
    },

    ShipPattern_t = enum {
	shp_none,				/* no conditions */
	shp_list,				/* list of ship numbers */
	shp_box,				/* sectors they are in */
	shp_fleet				/* a fleet they are in */
    },

    ConditionSet_t = struct {
	uint cs_conditionCount;
	[MAX_CONDITIONS] Condition_t cs_condition;
	int cs_boxTop, cs_boxBottom, cs_boxLeft, cs_boxRight;
    },

    ShipScan_t = struct {
	ConditionSet_t shs_cs;
	ShipPattern_t shs_shipPatternType;
	uint shs_shipCount;
	[MAX_SHIPS] uint shs_shipList;
	char shs_shipFleet;
	Ship_t shs_currentShip;
    },

    SectorScan_t = struct {
	ConditionSet_t ss_cs;
	Sector_t ss_currentSector;
	bool ss_mapHook;
    };
