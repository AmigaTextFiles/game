/* Prototypes for functions defined in
cyber_data.c
 */

extern int AIDataFlag;

extern struct GovHist H;

extern struct rtHandlerInfo * AIhandle;

extern char outbuf[256];

extern int * MoveMap;

extern struct MinList GovList;

extern int NewGov;

extern int NewUnit;

extern struct GovReqs LastReq;

extern struct MinList OpenList;

extern struct MinList DoneList;

extern int * PathMap;

extern int PathMapX;

extern int PathMapY;

extern int Path[25];

extern int PathDiv;

extern int PathLength;

extern enum Direction const DirArray[8][6];

extern char const DirString[6][10];

extern char const ModeString[9][15];

extern char const UnitString[13][15];

extern struct GovPrefs const AI5_CITY_DEF_AIR;

extern struct GovPrefs const AI5_CITY_DEF_SEA;

extern struct GovPrefs const AI5_CITY_SEARCH_FIRST;

extern struct GovPrefs const AI5_CITY_SUPPORT_SEA;

extern struct GovPrefs const AI5_CITY_SUPPORT_LAND;

extern struct GovPrefs const AI5_ISLE_DEF_OWN;

extern struct GovPrefs const AI5_ISLE_DEF_AIR;

extern struct GovPrefs const AI5_ISLE_DEF_SEA;

extern struct GovPrefs const AI5_ISLE_SEARCH_FIRST;

extern struct GovPrefs const AI5_ISLE_SEARCH_OWN;

extern struct GovPrefs const AI5_ISLE_SEARCH_AIR;

extern struct GovPrefs const AI5_ISLE_SUPPORT;

extern struct GovPrefs const AI5_TRANS_ATTACK;

extern struct GovPrefs const AI5_TRANS_DEFEND;

extern struct GovPrefs const AI5_CARR_ATT_SEA;

extern struct GovPrefs const AI5_CARR_ATT_AIR;

extern struct GovPrefs const AI5_BATT_ATTACK;

extern struct GovPrefs const EXPLORE_PREFS;

extern struct GovPrefs const DEFEND_LAND_PREFS;

extern struct GovPrefs const DEFEND_PORT_PREFS;

extern struct GovPrefs const SEARCH_PORT_PREFS;

extern struct GovPrefs const SEARCH_PREFS;

extern struct GovPrefs const CONQUER_LAND_PREFS;

extern struct GovPrefs const CONQUER_AIR_PREFS;

extern struct GovPrefs const CONQUER_SEA_PREFS;

extern struct GovPrefs const CONQUER_AIR2_PREFS;

extern struct GovPrefs const CONQUER_SEA2_PREFS;

extern struct GovPrefs const OUTNUMBERED_SEA_PREFS;

extern struct GovPrefs const OUTNUMBERED_LAND_PREFS;

extern struct GovPrefs const SUPPORT_SEA_PREFS;

extern struct GovPrefs const SUPPORT_LAND_PREFS;

extern struct GovPrefs const ATTACK_LAND_PREFS;

extern struct GovPrefs const ATTACK_AIR_PREFS;

extern struct GovPrefs const ATTACK_SEA_PREFS;

extern struct GovPrefs const ATTACK_AIR2_PREFS;

extern struct GovPrefs const ATTACK_SEA2_PREFS;

extern int const GENERAL_MIN_TURNS[13];

