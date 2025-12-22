// global.h -- global definitions header

// various types of headers
#include <dos/dos.h>
#include <intuition/intuition.h>
#include <intuition/screens.h>
#include <intuition/gadgetclass.h>
#include <libraries/gadtools.h>
#include <libraries/asl.h>

#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/gadtools_protos.h>

#include <exec/memory.h>

#include <proto/intuition.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/diskfont.h>
#include <proto/graphics.h>
#include <proto/gadtools.h>
#include <proto/asl.h>

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

#undef strcpy

#include <libraries/reqtools.h>
#include <proto/reqtools.h>

// These make the code easier to follow.
#define FI }
#define OD }
#define Bool(a) ((a)!=0)   // explicitly converts any numeric or bit value
                           // to TRUE or FALSE

// sound and music support
#include "sound_protos.h"
#include "libproto.h"

// These common default tags for my EZ Requesters
#define RT_DEFAULT RT_Window,map_window,RT_ReqPos,REQPOS_CENTERWIN,RT_LockWindow,TRUE

#define IDCMP_MAPEDIT (IDCMP_MENUPICK|IDCMP_MOUSEBUTTONS|IDCMP_MOUSEMOVE|SCROLLERIDCMP|IDCMP_RAWKEY|IDCMP_VANILLAKEY)
#define IDCMP_PLAYGAME (IDCMP_MENUPICK|IDCMP_MOUSEBUTTONS|SCROLLERIDCMP|IDCMP_RAWKEY|IDCMP_VANILLAKEY|IDCMP_INTUITICKS)

extern ULONG __far RangeSeed;  // This is needed for random number generation.

// the parameters that get me a standard busy pointer
#define BUSY_POINTER busy_pointer_data,16,16,-6,0

// locations of the special map objects in my graphics bitmap
#define MAP_CURSOR 242,30
#define MAP_MARKER 242,48
#define MAP_BLAST 154,30

// pen colors
#define LT_GRAY   0
#define BLACK     1
#define WHITE     2
#define LT_BLUE   3
#define TAN       4
#define DK_GRAY   5
#define PURPLE    6
#define ORANGE    7
#define RED       8
#define DK_BLUE   9
#define BLUE      10
#define BROWN     11
#define GRAY      12
#define DK_GREEN  13
#define LT_GREEN  14
#define GREEN     15

// terrain hex ID codes
#define HEX_UNEXPLORED  0
#define HEX_PLAINS      1
#define HEX_DESERT      2
#define HEX_FORBID      3
#define HEX_ARCTIC      3
#define HEX_BRUSH       4
#define HEX_FOREST      5
#define HEX_JUNGLE      6
#define HEX_RUGGED      7
#define HEX_HILLS       8
#define HEX_MOUNTAINS   9
#define HEX_PEAKS       10
#define HEX_SWAMP       11
#define HEX_SHALLOWS    12
#define HEX_OCEAN       13
#define HEX_DEPTH       14
#define HEX_ICE         15
#define HEX_CITY        16    // not a real hex, but a valid brush value
#define HEX_ROADS       17    // ditto!

// following macro easily determines if a hex is ocean (ice doesn't count)
#define OCEAN_P(a) (a>=HEX_SHALLOWS&&a<=HEX_DEPTH)

#define VALID_HEX(a,b) ((BOOL)(a>=0&&a<width&&b>=0&&b<height))

#define GRID_SIZE ((long)((width+width%2)*height/2+1))

#define ROAD 1     // flags show presence of roads or minefields
#define MINE 2

// unit-icon ID codes
// the first 12 are also used to identify unit types
#define RIFLE        0
#define ARMOR        1
#define AIRCAV       2
#define BOMBER       3
#define FIGHTER      4
#define TRANSPORT    5
#define SUB          6
#define DESTROYER    7
#define CRUISER      8
#define BATTLESHIP   9
#define CARRIER      10
#define AIRBASE      11

// these aren't properly unit types
#define LANDMINE     17
#define SEAMINE      18
#define MILITIA      20
#define CITY         21
#define ROADS        22

// map display info
// minimum width and height designed for NTSC, no overscan
#define MIN_WD 19
#define MIN_HT 14

// this is the visible overlap around the edges of the map when
// using wrap-around
#define WRAP_OVERLAP 3

extern BOOL fmail;

extern BOOL modem;

struct Hex_Coords {
   short col, row;
};

// global game options
struct Opt {
   int gametype;        // normal, file-mail, or modem
   BOOL wrap;           // wrap-around map
   BOOL defend_cities;  // units in a city help defend it
   BOOL fortification;  // allow units to dig in?
   BOOL stacking;       // none, partial (in movement), full
   BOOL landmines;      // landmines enabled?
   BOOL seamines;       // seamines enabled?
};    // opt;

struct OldCity {     // KEPT FOR COMPATIBILITY
   struct MinNode cnode;
   short col, row;   // location on map
   short unit_type;  // what it's producing
   short unit_wip;   // Work In Progress, how much it's already built
   short owner;      // who owns dis joint?
   short industry;   // production capacity, defaults to 50%
   APTR reserved;    // reserved for what, I just don't know
   char name[20];    // name of city
};

struct City {
   struct MinNode cnode;
   short col, row;   // location on map
   short unit_type;  // what it's producing
   short unit_wip;   // Work In Progress, how much it's already built
   short owner;      // who owns dis joint?
   short industry;   // production capacity, defaults to 50%
   short specialty;  // the unit type this city specializes in,
                     // or 12 (CITY) means no specialty
   short reserved;
   char name[20];    // name of city
   UBYTE recon[9];   // recon value for each player
};


// valid order codes that can be given
// each of these conditions has a graphical token associated with it
#define ORDER_NONE      0
#define ORDER_SENTRY    1
#define ORDER_FORTIFY   2
#define ORDER_FORTIFIED 3
#define ORDER_LOAD      4
#define ORDER_UNLOAD    5
#define ORDER_GOTO      6
#define ORDER_AIRBASE   7


// These two are NOT associated with graphical tokens - use carefully
#define ORDER_HOME      10
#define ORDER_PATROL    11

struct OldOrder { // obsolete; intended only for compatibility purposes
   short type;    // code for the type of order
   short orgx,  orgy;       // origin coordinates (Quit smirking!)
   short destx, desty;      // destination coordinates
   short etc;     // Estimated Time of Completion; the turn number when a
                  // non-movement activity will be finished, such as
                  // fortification, minelaying, etc.
   struct Unit *dest_unit;  // destination unit (i.e. aircraft carrier)
};

struct Order {
   short type;    // code for the type of order
   short orgx,  orgy;       // origin coordinates (Quit smirking!)
   short destx, desty;      // destination coordinates
   short etc;     // Estimated Time of Completion; the turn number when a
                  // non-movement activity will be finished, such as
                  // fortification, minelaying, etc.
   short reserved;
   BOOL processed;     // flag shows whether this unit has been processed
                       // by the order manager this turn
   struct Unit *dest_unit;  // destination unit (i.e. aircraft carrier)
};


/*
   If you change the UnitTemplate data structure, be sure to also change
   the wishbook[] initialization in data_struct.c!
*/

struct UnitTemplate {
   int type;         // type of unit to build (NOT USED)
   int build;        // amount of industry units needed to build one
   int range;        // number of movement units without refueling (-1 = unlimited)
   int speed;        // number of movement units per turn
   int hitpoints;    // number of hits it can take without being destroyed
   BOOL enabled;     // available in this game, true or false
   BOOL ship_flag;   // set TRUE if it can only be built in port cities
   char name[20];    // name of unit type "RIFLE", "TRANSPORT", etc.
};    // wishbook[12]

struct InfoTemplate {
   BOOL enabled;
};


struct OldUnit {
   struct MinNode unode;
   short col, row;   // location of the piece
   short owner;      // who owns the piece
   short type;       // what kind of piece it is
   short damage;     // how many hits it has taken
   short attacks;    // how many attacks it has made this turn
   short cargo;      // how many cargo units are on board
   short move;       // how many 1/60 spaces it can move this turn
   short fuel;       // how many turns remain before refueling
   struct Unit *ship;     // ship that is carrying this unit or NULL
   struct Order *orders;  // pointer to the piece's current orders or NULL
   char *name;       // pointer to name of unit, otherwise NULL
};

struct Unit {
   struct MinNode unode;
   short col, row;   // location of the piece
   short owner;      // who owns the piece
   short type;       // what kind of piece it is
   short damage;     // how many hits it has taken
   short attacks;    // how many attacks it has made this turn
   short cargo;      // how many cargo units are on board
   short weight;     // how much cargo weight it's carrying
                     // (rifle=1, armor=2, fighter=1)
   short move;       // how many 1/60 spaces it can move this turn
   short fuel;       // how many turns remain before refueling
   long reserved;
   struct Unit *ship;     // ship that is carrying this unit or NULL
   struct Order *orders;  // pointer to the piece's current orders or NULL
   char *name;       // pointer to name of unit, otherwise NULL
};


#define mask(a) (1<<a) // used for bitwise tests

enum PlayerType { NOPLAYER, HUMAN, COMPUTER, NEUTRAL, COMP2, COMP3, AREXX };
enum SoundFX { SOUND_ALL, SOUND_BATTLE, SOUND_NONE };
enum PlayerStatus { ACTIVE, CRUSHED, SURRENDERED };

/*
   The following flag values define possible return values of unit_readiness().
   This has been changed from the previous method of using enumerated values,
   because I found it might be useful for some of the states to overlap.
*/
#define UNIT_UNREADY    1
#define UNIT_READY      (1<<1)
#define UNIT_ENGAGED    (1<<2)
#define UNIT_PROCESSED  (1<<3)

// these were the previous values...
// enum UnitStatus { UNIT_UNREADY, UNIT_READY, UNIT_ENGAGED, UNIT_PROCESSED };

#define ISHUMAN(x) (x==HUMAN)
#define NONHUMAN(x) (x>=COMPUTER&&x<=AREXX)

struct OldMapIcon {     // an object to display on the user's map
   struct MinNode inode;
   short col, row;   // location on player's map
   short type;       // icon number (or city)
   short owner;      // what player it belongs to
   short token;      // show order status
   BOOL stacked;     // draw heavy border
};

struct MapIcon {     // an object to display on the user's map
   struct MinNode inode;
   short col, row;   // location on player's map
   short type;       // icon number (or city)
   short owner;      // what player it belongs to
   short token;      // show order status
   short turn;       // turn number when the icon was made
   BOOL stacked;     // draw heavy border
};

struct OldPLayer {   // obsolete structure; kept only for compatibility
   char name[41];             // the player's chosen name
   char passkey[41];          // the player's encrypted password
   enum PlayerType type;      // human or computer?
   enum PlayerStatus status;  // active, crushed, surrendered, whatever...
   short color;               // the color used to indentify his units
   short prod;                // production efficiency, range 0 to 100
   short att;                 // attack efficiency, range 0 to 100
   short def;                 // defense efficiency, range 0 to 100
   short aggr;                // computer aggressiveness, range 1 to 10
   // these next few are user-set preferences
   short msg_delay;           // time delay for user event messages
   short battle_delay;        // time delay for combat events
   enum SoundFX soundfx;      // sound effects: none, all, or battle sounds only
   BOOL autorpt;              // show combat report automatically each turn?
   BOOL show_production;      // automatically show new units produced (not ships)
   // next two are for map data
   char *map;                 // the player's personal battle map
   struct MinList icons;      // list of icons to display for his map
   // eud[] & uld[] store statistics for the war report, have no effect on game
   short eud[11];             // Enemy Units Destroyed
   short ulc[11];             // Units Lost in Combat
};

/*
   I have added a new value to the PLayer structure.  This is the "show" value
   which determines whether game actions for this player are displayed on
   screen.  Normally this will have a value of SHOW_NON for computer opponents
   and SHOW_ALL for human players.  However, it is possible to add other modes
   for demonstrations, debugging, etc.
*/
#define SHOW_NON   0  // show nothing on screen: no map display, etc.
#define SHOW_GRP   1  // show map display and graphics action
#define SHOW_SND   2  // play sounds
#define SHOW_REQ   4  // present requesters and other events requiring human input
#define SHOW_ALL   (SHOW_GRP|SHOW_SND|SHOW_REQ)

struct PLayer {
   char name[41];             // the player's chosen name
   char passkey[41];          // the player's encrypted password
   enum PlayerType type;      // human or computer?
   enum PlayerStatus status;  // active, crushed, surrendered, whatever...
   short show;   // display status of this player; see notes above
   short color;               // the color used to indentify his units
   short prod;                // production efficiency, range 0 to 100
   short att;                 // attack efficiency, range 0 to 100
   short def;                 // defense efficiency, range 0 to 100
   short aggr;                // computer aggressiveness, range 1 to 10
   short reserved1;
   // these next few are user-set preferences
   short snd_vol;             // sound effects volume
   short msg_delay;           // time delay for user event messages
   short battle_delay;        // time delay for combat events
   enum SoundFX soundfx;      // sound effects: none, all, or battle sounds only
   BOOL autorpt;              // show combat report automatically each turn?
   BOOL show_production;      // automatically show new units produced (not ships)
   // next two are for map data
   char *map;                 // the player's personal battle map
   struct MinList icons;      // list of icons to display for his map
   // eud[] & uld[] store statistics for the war report, have no effect on game
   short eud[11];             // Enemy Units Destroyed
   short ulc[11];             // Units Lost in Combat
}; // roster[9];

struct Options {
   short num_playing;         // number of players who started
   BOOL stacking;             // whether stacking rules are in force
   BOOL fmail;                // flag for an F-Mail game
   BOOL modem;                // flag for a modem game
   BOOL defend_cities;        // will units help protect a city?
   BOOL entrenchment;         // can troops dig in?
};

enum Direction { EAST, SOUTHEAST, SOUTHWEST, WEST, NORTHWEST, NORTHEAST };

#define PLAYER roster[player]

/*
   This following structure is used with a temporary file to store all
   the combat that takes place.
*/

struct BattleRecord {
   int turn;  // turn the battle took place
   int att_x, att_y;             // attacker and defender info
   int att_owner, att_type;
   int def_x, def_y;
   int def_owner;
   short white_icon, def_type;
   int winner;   // who won the battle
   int casualties;   // number of defending units destroyed
   int bombardment;  // true if winner does not move
   int seen_by;   // masks indicate who should see this report
   unsigned int blows;   // stores blow-by-blow account
};

/*
   The use of the "blows" variable demands more explanation.  The
   first byte of the value is an unsigned char from 1 to 24.  This is
   the number of explosions or "blows" delivered in the fight.  The
   remaining 24 bits each signify an explosion, with 1 being a hit against
   the defender and 0 being a hit against the attacker.
*/

// automatically generated prototypes
#include "main_menu_protos.h"
#include "map_editor_protos.h"
#include "map_editor2_protos.h"
#include "graphics_protos.h"
#include "map_grafx_protos.h"
#include "data_struct_protos.h"
#include "map_display_protos.h"
#include "game_play1_protos.h"
#include "game_play2_protos.h"
#include "options_protos.h"
#include "Gadgets_protos.h"
#include "Utils_protos.h"
#include "Sound.H"
#include "status_protos.h"
#include "cyber_protos.h"

// end of listing
