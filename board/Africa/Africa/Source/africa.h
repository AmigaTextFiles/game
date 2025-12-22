#define DECIMALVERSION   "1.57"
#define INTEGERVERSION   "1.57"
#define VERSION          "\0$VER: Africa " INTEGERVERSION " (31.12.2024)" // d.m.yyyy format
#define RELEASEDATE      "31-12-24" // dd-mm-yy format
#define COPYRIGHT        "© 2006-2024 Amigan Software"
#define TITLEBAR         "Africa " DECIMALVERSION

// 2. DEFINES ------------------------------------------------------------

// #define EXTRAVERBOSE
// for more information about eg. what the AI is thinking

// these are all counting from 1
#define EUROPEANS         5
#define LAFRICANS        14 // loyal Africans
#define RAFRICANS        28 // loyal+rebel Africans

#define USA              0
#define USSR             1
#define CHINA            2
#define FRANCE           3
#define UK               4

#define SOUTHAFRICA      0
#define NAMIBIA          1
#define BOTSWANA         2
#define RHODESIA         3
#define MOZAMBIQUE       4
#define ANGOLA           5
#define ZAMBIA           6
#define MALAWI           7
#define GABON            8
#define CONGO            9
#define ZAIRE           10
#define TANZANIA        11
#define UGANDA          12
#define KENYA           13
#define SOUTHAFRICA_R   14
#define NAMIBIA_R       15
#define BOTSWANA_R      16
#define RHODESIA_R      17
#define MOZAMBIQUE_R    18
#define ANGOLA_R        19
#define ZAMBIA_R        20
#define MALAWI_R        21
#define GABON_R         22
#define CONGO_R         23
#define ZAIRE_R         24
#define TANZANIA_R      25
#define UGANDA_R        26
#define KENYA_R         27

#define MAPROWS         18
#define MAPCOLUMNS      13

#define SAF SOUTHAFRICA      // 4 cities (6 at start)
#define NAM NAMIBIA          // 2 cities (0 at start)
#define BOT BOTSWANA         // 1 city
#define RHO RHODESIA         // 2 cities
#define MOZ MOZAMBIQUE       // 2 cities
#define ANG ANGOLA           // 2 cities
#define ZAM ZAMBIA           // 2 cities
#define MAL MALAWI           // ½ city
#define GAB GABON            // ½ city
#define CON CONGO            // 1 city
#define ZAI ZAIRE            // 3 cities (2 at start)
#define TAN TANZANIA         // 2 cities
#define UGA UGANDA           // 1 city
#define KEN KENYA            // 2 cities
#define SAF_R SOUTHAFRICA_R  // 4 cities
#define NAM_R NAMIBIA_R      // 2 cities
#define BOT_R BOTSWANA_R     // 1 city
#define RHO_R RHODESIA_R     // 2 cities
#define MOZ_R MOZAMBIQUE_R   // 2 cities
#define ANG_R ANGOLA_R       // 2 cities
#define ZAM_R ZAMBIA_R       // 2 cities
#define MAL_R MALAWI_R       // ½ city
#define GAB_R GABON_R        // ½ city
#define CON_R CONGO_R        // 1 city
#define ZAI_R ZAIRE_R        // 3 cities (2 at start)
#define TAN_R TANZANIA_R     // 2 cities
#define UGA_R UGANDA_R       // 1 city
#define KEN_R KENYA_R        // 2 cities
#define NON (-1)

#define CONTROL_HUMAN     0
#define CONTROL_AMIGA     1

#define HIDDEN_X       (-48)
#define HIDDEN_Y          0

#define OTHER             0
#define JUNTA             1
#define LEADER            2

#define CITIES           26

#define WAITING         (-4)
#define QUITTOTITLE     (-3)
// -1 and -2 are already used
#define ROUND             0
#define HEX               1
#define ANYKEY            2
#define GAMEOVER          3
#define YESNO             4
#define TITLESCREEN       5

#define UPPER             0
#define LOWER             1

#define COUNTERWIDTH      2 // in words (21 pixels, rounded up)
#define COUNTERHEIGHT    21 // in pixels
#define COUNTERDEPTH      6 // in bitplanes
#define MINDEPTH          6 // in bitplanes
#define MAXDEPTH          8 // in bitplanes
#define ABOUTDEPTH        6
#define ABOUTDEPTHMASK 0x3F // %00111111
#define DEPTH             6 // in bitplanes

#define STATE_NORMAL      0
#define STATE_SELECTED    1
#define STATE_LEADER      2
#define STATE_SELLEADER   3
#define STATE_JUNTA       4
#define STATE_SELJUNTA    5

// double buffering subsystem
#define OK_REDRAW         1
#define OK_SWAPIN         2

#define SCREENXPIXEL       640
#define SCREENYPIXEL       512
#define HEXHELPXPIXEL      348
#define HEXHELPYPIXEL       90

#define MAX_ARMIES          10
#define MAX_ORDERS          25 // (24 * $1) + (1 for ORDER_DONE)

#define BLACK                0
#define GREY                 1
#define MEDIUMGREY           GREY
#define WHITE                3
#define DARKGREY             8
#define LIGHTGREY            9
#define EUROCOLOUR          10
#define MAPBACKGROUND       15
#define DARKGREEN           16
#define AFROCOLOUR          32
#define BARCOLOUR           60

#define POLITICAL_CONTROL    4
#define MILITARY_CONTROL     7

#define ORDER_PI             0
#define ORDER_RAISE_IS       1
#define ORDER_LOWER_IS       2
#define ORDER_INSTALL_LEADER 3
#define ORDER_INSTALL_JUNTA  4
#define ORDER_BUILD_IU       5
#define ORDER_MAINTAIN_IU    6
#define ORDER_GIVE_MONEY     7
#define ORDER_DONE           8

#define YES                  1
#define NO                 (-1)

#define MIN_ROUNDS           2
#define MAX_ROUNDS          99

// 3. GLOBAL FUNCTIONS ---------------------------------------------------

// system.c
EXPORT void cleanexit(SLONG rc);
EXPORT void darken(void);
EXPORT void say(SLONG position, UBYTE colour, STRPTR lefttext, STRPTR righttext);
EXPORT void resay(void);
EXPORT SLONG getevent(SLONG mode);
EXPORT void drawtables(void);
EXPORT void anykey(void);
EXPORT void setbarcolour(SLONG we);
EXPORT ULONG goodrand(void);
EXPORT SLONG dowho(SLONG we, FLAG quick, SLONG* amountvar, SLONG maxamount);
EXPORT void writeorders_human(SLONG we);
EXPORT void updatescreen(void);
EXPORT void rq(STRPTR text);
EXPORT FLAG loadgame(FLAG aslwindow);
EXPORT void remap(void);
EXPORT void allocpen(int whichpen, ULONG red, ULONG green, ULONG blue, FLAG exclusive);
EXPORT void freepen(int whichpen);

#if (!defined(__SASC)) && (!defined(__VBCC__))
    EXPORT int stcl_d(char* out, long lvalue);
#endif

// engine.c
EXPORT SLONG govtx(SLONG wa);
EXPORT SLONG govty(SLONG wa);
EXPORT void oneround(void);
EXPORT FLAG valid(SLONG x, SLONG y);
EXPORT void engine_newgame(void);
EXPORT FLAG spareleader(SLONG we);
EXPORT FLAG sparejunta(SLONG we);
EXPORT SLONG ourarmy(SLONG wa, SLONG x, SLONG y);
EXPORT SLONG whosehex(SLONG x, SLONG y);
EXPORT FLAG nextto(SLONG sourcex, SLONG sourcey, SLONG destx, SLONG desty);
EXPORT FLAG canattack(SLONG wa, SLONG x, SLONG y);
EXPORT FLAG checkattack(SLONG wa, SLONG wa2, SLONG x, SLONG y, FLAG human);
EXPORT void eattack_human(SLONG we);
EXPORT void aattack_human(SLONG wa, SLONG war);
EXPORT FLAG hasarmy(SLONG wa);
EXPORT FLAG calcscores(void);
EXPORT int cityhere(SLONG x, SLONG y);

// map1.c
EXPORT void drawmap(void);

// counters.c
EXPORT void init_counters(void);
EXPORT void refreshcounters(void);
EXPORT void move_army(SLONG wa, SLONG war, FLAG display);
EXPORT void move_iu(SLONG we, FLAG display);
EXPORT void remove_army(SLONG wa, SLONG war, FLAG display);
EXPORT void remove_iu(SLONG we, FLAG display);
EXPORT void makeleader(SLONG wa, SLONG war, FLAG display);
EXPORT void makejunta(SLONG wa, SLONG war, FLAG display);
EXPORT void killgovt(SLONG wa, SLONG war, FLAG display);
EXPORT void select_army(SLONG wa, SLONG war, FLAG display);
EXPORT void deselect_army(SLONG wa, SLONG war, FLAG display);
EXPORT void select_iu(SLONG we, FLAG display);
EXPORT void deselect_iu(SLONG we, FLAG display);
EXPORT void shadowcounter_afro(struct Window* WindowPtr, int x, int y, int wa, int war);
EXPORT void shadowcounter_euro(struct Window* WindowPtr, int x, int y, int we);

// 4. GLOBAL STRUCTURES --------------------------------------------------

EXPORT struct EuroStruct
{   // initialized
    SLONG  maxleaders,
           maxjuntas;
    // uninitialized
    STRPTR name,
           adjective;
    SLONG  treasury,
           control,
           iux, iuoldx,
           iuy, iuoldy,
           iuhost;
    FLAG   iu;
    int    iuxpixel,
           iuypixel,
           iustate;
};
EXPORT struct AfroStruct
{   // uninitialized
    STRPTR name;
    SLONG  eruler, // ie. the player with the Political Influence
           aruler,
           pi,
           is,
           govt,
           govtarmy,
           treasury;
    FLAG   declared[RAFRICANS];
    struct
    {   FLAG  alive;
        SLONG x,
              y,
              oldx,
              oldy;
        int   xpixel,
              ypixel,
              state;
    } army[MAX_ARMIES];
};
EXPORT struct SetupStruct
{   SBYTE eruler,
          pi,
          is,
          initarmies,
          maxarmies,
          cities,
          govt,
          aruler;
};
EXPORT struct CityStruct
{   SLONG  x, y, worth;
    STRPTR nname,
           oname;
    SLONG  oaruler,
           aruler;
};
EXPORT struct OrderStruct
{   SLONG command,
          dest,
          data1,
          data2,
          fee;
};
EXPORT struct BoxStruct
{   SLONG x, y;
    int   kind;
};
