#define DECIMALVERSION   "1.95"
#define INTEGERVERSION   "1.95"
#define VERSIONSTRING    "\0$VER: Saga " INTEGERVERSION " (31.12.2024)" // d.m.yyyy format
#define RELEASEDATE      "31-12-24"
#define COPYRIGHT        "© 2002-2024 Amigan Software"
#define TITLEBAR         "Saga " DECIMALVERSION

// 2. DEFINES ------------------------------------------------------------

// #define EXTRAVERBOSE

#define MAPSIZE     127491 // 624*467 pixels * 7 planes / 16 bits per word = 127,491 words
                           // (image is 623 columns wide we must round up to the next multiple of 4)

#define LEFTSIDE         0
#define RIGHTSIDE        1
#define MAXLINES        47

#define NONE             0
#define HUMAN            1
#define CONTROL_AMIGA    2

#define HIDDEN_X      (-48)
#define HIDDEN_Y         0

#define AMSIR            0
#define EON              1
#define GEOFU            2
#define ING              3
#define OGAL             4
#define SYGIL            5

#define LAND             0
#define SEA              1
#define ISLE             2
#define PENINSULA        3

#define BALMUNG          0
#define DRAGVENDILL      1
#define GRAM             2
#define HRUNTING         3
#define LOVI             4
#define TYRFING          5

#define TURNS           20

#define RUNES            5

#define BROSUNGNECKLACE  0
#define FREYFAXI         1
#define MAGICSHIRT       2
#define MAILCOAT         3
#define HEALINGPOTION    4
#define INVISIBILITYRING 5
#define MAGICCROWN       6
#define TELEPORTSCROLL   7

#define BEOWULF          0
#define BRUNHILD         1
#define EGIL             2
#define RAGNAR           3
#define SIEGFRIED        4
#define STARKAD          5

#define MULTIKEYBOARD    0
#define COUNTRY          1
#define COUNTER          2
#define ANYKEY           3
#define YNKEYBOARD       4
#define GLKEYBOARD       5
#define WRKEYBOARD       6
#define GAMEOVERSCREEN   7

#define ONEKEY_YES       0
#define ONEKEY_NO        1
#define ONEKEY_WITHDRAW  2
#define ONEKEY_RESTART   3
#define ONEKEY_TRANSFER  4
#define ONEKEY_GLORY     5
#define ONEKEY_LUCK      6
#define ONEKEYS          ONEKEY_LUCK

#define FREY             0
#define LOKI             1
#define NJORD            2
#define ODIN             3
#define THOR             4
#define TYR              5

#define UPPER            0
#define LOWER            1

#define COUNTERWIDTH      2 // in words (24 pixels, rounded up)
#define COUNTERHEIGHT    24 // in pixels
#define ABOUTDEPTH        4
#define ABOUTDEPTHMASK  0xF
#define MINDEPTH          7
#define DEPTH             7 // in bitplanes
#define MAXDEPTH          8
#define CONNECTIONS       7

// double buffering subsystem
#define OK_REDRAW             1
#define OK_SWAPIN             2

// types of things
#define HERO                  0
#define JARL                  1
#define MONSTER               2
#define TREASURE              3
#define SORD                  4
#define KINGDOM               5

// quantities of things, counting from 0
#define HEROES               ( 6 - 1)
#define JARLS                (18 - 1)
#define MONSTERS             (32 - 1)
#define SORDS                ( 6 - 1)
#define TREASURES            ( 8 - 1)

#define BLACK                 0
#define WHITE                 1
#define LIGHTGREY             2
#define MEDIUMGREY            3
#define DARKGREY              4
#define GREEN                 5
#define FIRSTHEROCOLOUR       6 // 6..11 are heroes
#define COLOUR_SEA           12

#define FACEUP                0
#define FACEDOWN              1

#define SLOTS      (HEROES + 1 + JARLS + 1 + MONSTERS + 1 + TREASURES + 1 + SORDS + 1 - 1)
#define ATTACKS    (HEROES + 1 + JARLS + 1 + MONSTERS + 1 + 36)

#define FIRSTIMAGE_HERO      0
#define FIRSTIMAGE_JARL      6
#define FIRSTIMAGE_MONSTER  25
#define FIRSTIMAGE_SORD     57
#define FIRSTIMAGE_TREASURE 63
#define SELCOUNTERIMAGES    (HEROES + 1 + JARLS + 2 + MONSTERS + 1)
#define COUNTERIMAGES       (HEROES + 1 + JARLS + 2 + MONSTERS + 1 + SORDS + 1 + TREASURES + 2)
/* 0.. 5:  6   heroes
   6..24: 18+1 jarls
  25..56: 32   monsters
  57..62:  6   swords
  63..71:  8+1 treasures */

// 3. GLOBAL FUNCTIONS ---------------------------------------------------

// system.c
EXPORT void cleanexit(SLONG rc);
EXPORT void updatescreen(void);
EXPORT void darken(void);
EXPORT void say(SLONG position, UBYTE whichcolour);
EXPORT void hint(CONST_STRPTR thehint1, CONST_STRPTR thehint2);
EXPORT SLONG getevent(SLONG mode, UBYTE whichcolour);
EXPORT void border(SLONG whichhero);
EXPORT void clearkybd(void);
EXPORT void rq(STRPTR text);
EXPORT FLAG loadgame(FLAG aslwindow);
EXPORT void remap(void);
EXPORT void allocpen(int whichpen, ULONG red, ULONG green, ULONG blue, FLAG exclusive);
EXPORT void drawborder(int leftx, int topy, int rightx, int bottomy, FLAG outer);
EXPORT SLONG goodrand(void);

// themap.c
EXPORT void drawmap(void);

// gfx.c
EXPORT void drawlogo(void);
EXPORT void clearscreen(void);
EXPORT void fillwindow(struct Window* WindowPtr);

// engine.c
EXPORT void place_monsters(void);
EXPORT void showcountry(SLONG country);
EXPORT void withdraw(SLONG whichhero);
EXPORT void phase1(void);
EXPORT void phase2(void);
EXPORT void phase3(void);
EXPORT UBYTE saywho(SLONG countertype, SLONG counter, FLAG comma, FLAG lowercase);
EXPORT void place_jarls(void);
EXPORT void print_paralyzed(SLONG paralyzed_value, SLONG index);
EXPORT void print_location(SLONG whichcountry, SLONG index);
EXPORT void print_sea(SLONG sea_value, SLONG index);
EXPORT void print_hagall(SLONG hagall_value, SLONG index);
EXPORT void print_routed(SLONG routed_value, SLONG index);
EXPORT void promote(SLONG whichhero, SLONG whichjarl);
EXPORT SLONG getusualmoves(SLONG countertype, SLONG whichcounter);
EXPORT void faxi_disappear(void);
EXPORT void pad(STRPTR thestring);
EXPORT SLONG getstrength(SLONG countertype, SLONG counter, FLAG defending);
EXPORT void newhero(SLONG whichhero, FLAG givesord);
EXPORT void anykey(void);
EXPORT void treasure_disappear(SLONG whichtreasure);
EXPORT int calcscore(int whichhero);

// counters.c
EXPORT void init_counters(void);
EXPORT void move_hero(SLONG whichhero, FLAG display);
EXPORT void move_jarl(SLONG whichjarl, FLAG display);
EXPORT void move_monster(SLONG whichmonster, FLAG display);
EXPORT void move_treasure(SLONG whichtreasure, FLAG display);
EXPORT void move_sord(SLONG whichsord, FLAG display);
EXPORT void revealjarl(SLONG whichjarl, FLAG display);
EXPORT void hidejarl(SLONG whichjarl, FLAG display);
EXPORT void unslot_hero(SLONG whichhero);
EXPORT void unslot_jarl(SLONG whichjarl);
EXPORT void unslot_monster(SLONG whichmonster);
EXPORT void unslot_treasure(SLONG whichtreasure);
EXPORT void unslot_sord(SLONG whichsord);
EXPORT SLONG checkcounters(SWORD mousex, SWORD mousey);
EXPORT void select_hero(SLONG whichhero, FLAG display);
EXPORT void deselect_hero(SLONG whichhero, FLAG display);
EXPORT void select_jarl(SLONG whichjarl, FLAG display);
EXPORT void deselect_jarl(SLONG whichjarl, FLAG display);
EXPORT void select_monster(SLONG whichmonster, FLAG display);
EXPORT void deselect_monster(SLONG whichmonster, FLAG display);
EXPORT void remove_hero(SLONG whichhero, FLAG display);
EXPORT void remove_jarl(SLONG whichjarl, FLAG display);
EXPORT void remove_monster(SLONG whichmonster, FLAG display);
EXPORT void remove_treasure(SLONG whichtreasure, FLAG display);
EXPORT void remove_sord(SLONG whichsord, FLAG display);
EXPORT void reset_images(void);
EXPORT void hero_to_jarl(SLONG whichhero, SLONG whichjarl);
EXPORT void info(SLONG counter);
EXPORT void doc(SLONG number);
EXPORT void print_monster(SLONG x, SLONG y, SLONG which);
EXPORT void print_jarl(SLONG x, SLONG y, SLONG which);
EXPORT void print_treasure(SLONG x, SLONG y, SLONG which);

// 4. GLOBAL STRUCTURES --------------------------------------------------

EXPORT struct WorldStruct
{   // initialized

    SLONG  centrex, centrey, tax, type;
    STRPTR name;
    SLONG  connection[CONNECTIONS + 1];

    // uninitialized
    SLONG  hero;
    FLAG   is, slot[SLOTS + 1], visited;
};
EXPORT struct RuneStruct
{   STRPTR name, desc;
};
EXPORT struct HeroStruct
{   // all uninitialized

    STRPTR name;
    SLONG  strength, moves, glory, luck, control, sword, where, homewhere,
           wealth, slot, promoted, rune, god, sea, maidens;
    FLAG   alive, verydead, wounded, foundbob, moved, loseturn, hagall,
           routed, attacking, defending, passenger;
    SLONG  attacked[ATTACKS + 1],
           attacktype[ATTACKS + 1],
           score[100];
    SWORD  xpixel, ypixel;
    UWORD* image;
};
EXPORT struct JarlStruct
{   // initialized
    SLONG  strength,
           moves;
    STRPTR name;

    // uninitialized
    FLAG   taken, alive, foundbob, recruitable, loseturn, hagall, routed,
           attacking, defending, passenger;
    SLONG  where, homewhere, wealth, face, hero, slot, sea,
           attacked[ATTACKS + 1], attacktype[ATTACKS + 1];
    SWORD  xpixel, ypixel;
    UWORD* image;
};
EXPORT struct MonsterStruct
{   // initialized
    SLONG  species, strength, moves;
    STRPTR name;
    int    glory, luck;

    // uninitialized
    FLAG   taken, alive, foundbob, hagall;
    SLONG  where, slot, wealth, sea;
    SWORD  xpixel, ypixel;
    UWORD* image;
};
EXPORT struct TreasureStruct
{   // initialized
    STRPTR name;
    SWORD  y;

    // uninitialized
    SLONG  possessor, possessortype;
    FLAG   taken, foundbob;
    SLONG  where, slot;
    SWORD  xpixel, ypixel;
};
EXPORT struct SordStruct
{   // initialized
    STRPTR name;
    SWORD  y;

    // uninitialized
    SLONG  possessor, possessortype;
    FLAG   taken, foundbob;
    SLONG  where, slot;
    SWORD  xpixel, ypixel;
};
