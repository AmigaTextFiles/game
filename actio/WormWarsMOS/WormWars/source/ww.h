// 1. INCLUDES------------------------------------------------------------

#ifdef ANDROID
    #include <jni.h>

    #define EWINIT
    #define EWUNINIT
#endif

#if defined(ANDROID) || defined(GBA)
    #define EXPORT
    #define IMPORT         extern
    #define MODULE         static
    #define TRANSIENT      auto
    #define PERSIST        static
    #define FAST           static
    #define DISCARD        (void)
    #define TRUE           (~0)
    #define FALSE          0
    #define EXIT_SUCCESS   0
    #define EOS            '\0'
    #define acase          break; case
    #define adefault       break; default
    #define elif           else if
    typedef signed   char  FLAG;
    typedef signed   char  BYTE;
    typedef signed   char  SBYTE;
    typedef unsigned char  UBYTE;
    typedef signed   short SWORD;
    typedef unsigned short UWORD;
    typedef signed   long  SLONG;
    typedef unsigned long  ULONG;
    typedef char           TEXT;
    typedef char*          STRPTR;
    typedef UBYTE          SCANCODE;
    typedef ULONG          COLOUR;

    #define DEFAULTSET     "WormWars.lset"
    #define MAX_PATH       (1024 + 1)
    #define SQUAREX        12
    #define SQUAREY        12
    #define DEPTH           4

    #define BLACK      0
    #define LIGHTGREY  1
    #define DARKGREEN  2
    #define DARKYELLOW 3
    #define MEDIUMGREY 4
    #define DARKBLUE   5
    #define BLUE       6
    #define GREEN      7
    #define DARKRED    8
    // brown is 9
    #define RED       10
    #define YELLOW    11
    #define DARKGREY  12
    #define ORANGE    13
    #define PURPLE    14
    #define WHITE     15

    #define GetCatalogStr(a, b, c) c
#endif

// 2. DEFINES ------------------------------------------------------------

#define DECIMALVERSION   "9.36"
#define INTEGERVERSION   "9.36"
#define VERSION          "\0$VER: Worm Wars " INTEGERVERSION " (30.12.2024)" /* always d.m.y format */
#define RELEASEDATE      "30-12-24" // always dd.mm.yy format
#define RELEASEDATE_LONG "30 December 2024"
#define COPYRIGHT        "© 1993-2024 Amigan Software"
#define TITLEBAR         "Worm Wars " DECIMALVERSION

// #define TESTING
// automated test harness for ibm
// (click close gadget to quit)

// #define ASSERT
// ibm: when #defining this, also remove NDEBUG from
// "Project|Settings|C/C++|Preprocessor definitions".

#define OC               openconsole()

#define ENDOF(x)         &x[strlen(x)]
#define FAST             static

#define DELAY            50 // in milliseconds
#define DATELENGTH        8 /* DD/MM/YY */
#define TIMELENGTH        5 /* HH:MM */
#ifdef GBA
    #define DEFAULTLEVELS 50
#else
    #define DEFAULTLEVELS  5
#endif
#define HISCORES          4
#define MAXLEVELS        80 /* assert (MAXLEVELS >= 1 && MAXLEVELS <= 99); */
#define NAMELENGTH       21 /* 0..20 are TEXT, 21 is NULL */
#define NOMODE            0
#define NUMKEYS          30
#define HISCORESIZE      (6 + NAMELENGTH + 1 + DATELENGTH + 1 + TIMELENGTH + 1)
#define LSETSIZE         (10 + (4 * (HISCORES + 1) * HISCORESIZE) + (MAXLEVELS * (2 + (MINFIELDY * ((MINFIELDX / 2) + MINFIELDXODD)))) + 40) // + 40 is to cover version string
#define SAYLIMIT         60 /* in characters */

#define MINFIELDX        44 /* in squares */
#define MINFIELDXODD      1 // 0..44 means 45 squares which is an odd number
#define MINFIELDY        39 /* in squares */
#define MAXFIELDX        97 /* in squares */
#define MAXFIELDY        82 /* in squares */
#define LEVELSIZE        ((MINFIELDX + 1) * (MINFIELDY + 1))
#define ARROWX           (fieldx + 1)
#define ENDXPIXEL        ((STARTXPIXEL + SQUAREX * (fieldx + 1)) - 1)
#define ENDYPIXEL        ((STARTYPIXEL + SQUAREY * (fieldy + 1)) - 1)
#define WW_LEFTGAP       ((fieldx - MINFIELDX) / 2)
#define WW_TOPGAP        ((fieldy - MINFIELDY) / 2)
#define WW_RIGHTGAP      (fieldx - MINFIELDX - WW_LEFTGAP)
#define WW_BOTTOMGAP     (fieldy - MINFIELDY - WW_TOPGAP)

#define FIELDCENTREX     (STARTXPIXEL + ((fieldx / 2) * SQUAREX)) /* pixel coord of X-centre of field */
#define FIELDCENTREY     (STARTYPIXEL + ((fieldy / 2) * SQUAREY)) /* pixel coord of Y-centre of field */

#define TUTORIALS        12

#define BONUS_TAIL        1
#define BONUS_GLOW        2
#define BONUS_TIME       10
#define BONUS_NUMBER     50
#define BONUS_LEVEL     100

// ASCII values
#define LF               10
#define CR               13

/* songs */

#define SONG_TITLE        0
#define SONG_EDITOR       1
#define SONG_BONUS        2
#define SONG_GAMEOVER     3
#define SONG_GAME         4
#define SONGS             9 // [0..8]

/* samples */

#define FXBORN_DOG        0
#define FXBORN_RAIN       1
#define FXGET_LIGHTNING   2
#define FXBORN_MISSILE    3
#define FXBORN_PROTECTOR  4
#define FXDEATH_WORM      5
#define FXDO_ENCLOSE      6
#define FXBORN_FRAGMENT   7
#define FXGET_AMMO        8
#define FXGET_CYCLONE     9
#define FXGET_RAIN       10
#define FXGET_GROWER     11
#define FXGET_OBJECT     12
#define FXGET_POWERUP    13
#define FXGET_GRAVE      14
#define FXHELP           15
#define FXUSE_AMMO       16
#define FXUSE_ARMOUR     17
#define FXUSE_BOMB       18
#define FXUSE_TELEPORT   19
#define FXBORN_BIRD      20
#define FXPAIN           21 /* 21..24 */
#define FXAPPLAUSE       25 /* after each new hiscore */
#define FXGAMEOVER       26 /* if all worms are dead */
#define FXCLICK          27 /* rundown, keypresses */
#define FXSIREN          28 /* out of time */
#define FXDING           29
#define FXBORN_BULL      30
#define FXBORN_SNAKE     31
#define FXBORN_RHINO     32
#define FXGET_BUTTERFLY  33
#define FXBORN_ELEPHANT  34
#define FXBORN_HORSE     35
#define FXBORN_MONKEY    36
#define SAMPLES          37 // [0..36]

#define BONUSLEVEL_ORBS        0
#define BONUSLEVEL_BANANAS     1
#define BONUSLEVEL_RAIN        2
#define BONUSLEVEL_TREASURY    3
#define BONUSLEVEL_BUTTERFLIES 4
#define BONUSLEVEL_RABBITS     5
#define BONUSLEVEL_ENCLOSE     6
#define BONUSLEVEL_CHERRIES    7
#define BONUSLEVEL_PATH        8
#define BONUSLEVEL_DOGS        9
#define BONUSLEVEL_SNAKES     10
#define BONUSLEVEL_BULLS      11
#define BONUSLEVEL_JUMP       12
#define BONUSLEVELS           13 // [0..12]

// key types
#define MOVE              0 /* not AMMO, TRAINER, ONEHUMAN */
#define TRAINER           2 /* not MOVE, AMMO, ONEHUMAN */
#define ONEHUMAN          3 /* not MOVE, AMMO, TRAINER */

#define SPEED_STOPPED     0
#define SPEED_VERYFAST    1
#define SPEED_FAST        2
#define SPEED_NORMAL      4
#define SPEED_SLOW        8
#define SPEED_VERYSLOW   16 /* must be non-0 */

// pseudo-gadgets
#define PSEUDOGADGETS    10  // [0..9]
#define GADGETX        (WW_LEFTGAP - 2) // negatives must be within parentheses
#define EMPTYGADGET    ((fieldy / 2) - 9)
#define SILVERGADGET   ((fieldy / 2) - 7)
#define GOLDGADGET     ((fieldy / 2) - 5)
#define DYNAMITEGADGET ((fieldy / 2) - 3)
#define WOODGADGET     ((fieldy / 2) - 1)
#define STONEGADGET    ((fieldy / 2) + 1)
#define METALGADGET    ((fieldy / 2) + 3)
#define FROSTGADGET    ((fieldy / 2) + 5)
#define UPGADGET       ((fieldy / 2) + 7)
#define DOWNGADGET     ((fieldy / 2) + 9)
#define PSEUDOLEFT     (STARTXPIXEL - 4 + ((WW_LEFTGAP - 2) * SQUAREX))

// don't change these!
#define DIFFICULTY_EASY     0
#define DIFFICULTY_NORMAL   1
#define DIFFICULTY_HARD     2
#define DIFFICULTY_VERYHARD 3

// scoring
#define POINTS_EMPTY      1
#define POINTS_SILVER     5
#define POINTS_ENCLOSE    5
#define POINTS_GOLD      10
#define POINTS_BANANA    20
#define POINTS_BULLBONUS 25
#define POINTS_OBJECT    30
#define POINTS_CHERRY    50
#define POINTS_NUMBER   100
#define POINTS_GRAVE    100
#define POINTS_FLOWER   100
#define POINTS_FRUIT   1000

/* The constant NORMAL is used for several purposes:
    a)  as a speed (therefore must not be VERYFAST, FAST, SLOW
        or VERYSLOW);
    b)  as a mouse pointer (therefore must not be anything that can be
        a brush).

objects... */
#define AFFIXER              0
#define AMMO                 1
#define ARMOUR               2
#define AUTOJUMP             3
#define AUTOTURN             4
#define BACKWARDS            5
#define BONUS                6
#define BRAKES               7
#define CUTTER               8
#define CYCLONE_O            9
#define ENCLOSER            10
#define FORWARDS            11
#define GLOW                12
#define GRABBER             13
#define GRENADE             14
#define GROWER              15
#define ICE                 16
#define LIGHTNING           17
#define MINIBOMB            18
#define MINIHEALER          19
#define MINIPULSE           20
#define MISSILE_O           21
#define MULTIPLIER          22
#define POWER               23
#define PROTECTOR           24
#define PUSHER              25
#define REMNANTS            26
#define SIDESHOT            27
#define SLAYER              28
#define SLOWER              29
#define SUPERBOMB           30
#define SUPERHEALER         31
#define SUPERPULSE          32
#define SWITCHER            33
#define TAMER               34
#define TREASURE            35
#define UMBRELLA            36
/* field contents... */
#define FIRSTNUMBER        (5 +  32)
#define LASTNUMBER         (5 +  40)
#define EMPTY              (5 +  41)
#define SILVER             (5 +  42)
#define GOLD               (5 +  43)
#define DYNAMITE           (5 +  44)
#define WOOD               (5 +  45)
#define STONE              (5 +  46)
#define METAL              (5 +  47)
#define FROST              (5 +  48)
#define SLIME              (5 +  49)
#define TELEPORT           (5 +  50)
#define ARROWUP            (5 +  51)
#define ARROWDOWN          (5 +  52)
#define START              (5 +  53)
/* colour sets... */
#define FIRSTARROW         (5 +  54)
#define  LASTARROW         (5 +  57)
#define FIRSTRAIN          (5 +  58)
#define  LASTRAIN          (5 +  61)
#define FIRSTMISSILE       (5 +  62)
#define  LASTMISSILE       (5 +  65)
#define FIRSTPROTECTOR     (5 +  66)
#define  LASTPROTECTOR     (5 +  69)
#define FIRSTTAIL          (5 +  70)
#define  LASTTAIL          (5 +  73)
#define FIRSTDIM           FIRSTTAIL
#define  LASTDIM            LASTTAIL
#define FIRSTGLOW          (5 +  74)
#define  LASTGLOW          (5 +  77)
#define FIRSTFIRE          (5 +  78)
#define  LASTFIRE          (5 +  81)
#define FIRSTGRAVE         (5 +  82)
#define  LASTGRAVE         (5 +  85)
#define FIRSTPAIN          (5 +  86)
#define  LASTPAIN          (5 +  89)
#define FIRSTHEAD          (5 +  90)
#define  LASTHEAD          (5 +  93)
#define FIRSTCHERRY        (5 +  94)
#define  LASTCHERRY        (5 +  97)
#define FIRSTFLOWER        (5 +  98)
#define  LASTFLOWER        (5 + 101)
#define FIRSTBANANA        (5 + 102)
#define  LASTBANANA        (5 + 105)
#define FIRSTFRUIT         (5 + 106)
#define  LASTFRUIT        (10 + 125)

#define MUSIC             (10 + 126)
#define FX                (10 + 127)
#define ALL               (10 + 128)
#define BLACKARROW        (10 + 129)
#define BLACKENED         (10 + 130)
#define WHITENED          (10 + 131)
#define FIRSTBIRDFRAME    (10 + 132)
#define LASTBIRDFRAME     (10 + 135)
#define BULLRIGHT         (10 + 136)
#define DOGAWAKENING      (10 + 137)
#define DOGDORMANT        (10 + 138)
#define FROGRIGHT         (10 + 139)
#define FROGMOUTHLEFT     (10 + 140)
#define FROGMOUTHRIGHT    (10 + 141)
#define FROGTONGUE        (10 + 142)
#define FIRSTMISSILEFRAME (10 + 143)
#define LASTMISSILEFRAME  (10 + 162)
#define RABBITRIGHT       (10 + 163)
#define CLOCK             (10 + 164)
#define FIRSTORB          (10 + 165)
#define LASTORB           (10 + 168)
#define BOTH              (10 + 169)
#define FIRSTREVNUMBER    (10 + 170)
#define LASTREVNUMBER     (10 + 178)
#define CLUSTER           (10 + 179)
#define SQUIDLEFT         (10 + 180)
#define SQUIDRIGHT        (10 + 181)
#define FIRSTEELFRAME     (10 + 182)
#define LASTEELFRAME      (10 + 184)
/* creatures... */
#define ANT                195
#define BIRD               196
#define BULL               197
#define CAMEL              198
#define CLOUD              199
#define CYCLONE_C          200
#define DOG                201
#define FISH               202
#define FRAGMENT           203
#define FROG               204
#define GIRAFFE            205
#define KANGAROO           206
#define MISSILE_C          207
#define MONKEY             208
#define MOUSE              209
#define OCTOPUS            210
#define ORB                211
#define OTTER              212
#define RABBIT             213
#define RAIN               214
#define SALAMANDER         215
#define SNAIL              216
#define SPIDER             217
#define GOOSE              218
#define HORSE              219
#define BEAR               220
#define ELEPHANT           221
#define CHICKEN            222
#define ZEBRA              223
#define RHINOCEROS         224
#define SNAKE              225
#define PANDA              226
#define EEL                227
#define BUTTERFLY          228
#define KOALA              229
#define SQUID              230
#define TURTLE             231
#define LEMMING            232
#define PORCUPINE          233
#define TERMITE            234
// #define BAT             235
#define CURVER             SPIDER
#define LASTCREATURE       TERMITE

#define FIRSTBANANAFRAME   236
#define FIRSTTURTLEFRAME   264
#define LEMMINGLEFT        267
#define FIRST25POINTS      268
#define FIRST50POINTS      272
#define FIRST100POINTS     276
#define FIRST200POINTS     280
#define FIRSTPATTERN       284
#define LASTPATTERN        305
#define ENGRAVINGS         (LASTPATTERN - FIRSTPATTERN + 1)

#define GHOSTAFFIXER       306
#define GHOSTARMOUR        307
#define GHOSTAUTOJUMP      308
#define GHOSTBACKWARDS     309
#define GHOSTCUTTER        310
#define GHOSTENCLOSER      311
#define GHOSTFORWARDS      312
#define GHOSTGLOW          313
#define GHOSTGRENADE       314
#define GHOSTPUSHER        315
#define GHOSTREMNANTS      316
#define GHOSTSIDESHOT      317
#define GHOSTAUTOTURN      318

#define SPIDERSILK         319

/* no imagery... */
#define TEMPFROST          1000
#define TEMPWOOD           1001
#define TEMPSLIME          1002
#define TEMPLIGHTNING      1003
#define TEMPSILVER         1004
#define TEMPGOLD           1005
#define NOSQUARE           1006
#define BANGEDDYNAMITE     1007
#define BANGINGDYNAMITE    1008
#define TEMPDYNAMITE       1009
#define TEMPGLOW           1010

/* FIRSTOBJECT is always 0. */
#define LASTOBJECT         UMBRELLA
#define FIRSTEMPTY         EMPTY
#define LASTEMPTY          GOLD
#define FIRSTCREATURE      ANT
#define BULLLEFT           BULL
#define DOGCHASING         DOG
#define FROGLEFT           FROG
#define HEAD               FIRSTHEAD
#define RABBITLEFT         RABBIT
#define LEMMINGRIGHT       LEMMING
#define BANANA             FIRSTBANANA
#define ANYTHING           STONE /* should be something that is valid field contents */

/* heads */
#define HEADSOFFSET        320
#define GREENHEADUP        (HEADSOFFSET +   0)
#define GREENHEADDOWN      (HEADSOFFSET +   1)
#define GREENHEADLEFT      (HEADSOFFSET +   2)
#define GREENHEADRIGHT     (HEADSOFFSET +   3)
#define GREENHEAD_NW       (HEADSOFFSET +   4)
#define GREENHEAD_NE       (HEADSOFFSET +   5)
#define GREENHEAD_SW       (HEADSOFFSET +   6)
#define GREENHEAD_SE       (HEADSOFFSET +   7)
#define GREENGLOWUP        (HEADSOFFSET +   8)
#define GREENGLOWDOWN      (HEADSOFFSET +   9)
#define GREENGLOWLEFT      (HEADSOFFSET +  10)
#define GREENGLOWRIGHT     (HEADSOFFSET +  11)
#define GREENGLOW_NW       (HEADSOFFSET +  12)
#define GREENGLOW_NE       (HEADSOFFSET +  13)
#define GREENGLOW_SW       (HEADSOFFSET +  14)
#define GREENGLOW_SE       (HEADSOFFSET +  15)
#define REDHEADUP          (HEADSOFFSET +  16)
#define REDHEADDOWN        (HEADSOFFSET +  17)
#define REDHEADLEFT        (HEADSOFFSET +  18)
#define REDHEADRIGHT       (HEADSOFFSET +  19)
#define REDHEAD_NW         (HEADSOFFSET +  20)
#define REDHEAD_NE         (HEADSOFFSET +  21)
#define REDHEAD_SW         (HEADSOFFSET +  22)
#define REDHEAD_SE         (HEADSOFFSET +  23)
#define REDGLOWUP          (HEADSOFFSET +  24)
#define REDGLOWDOWN        (HEADSOFFSET +  25)
#define REDGLOWLEFT        (HEADSOFFSET +  26)
#define REDGLOWRIGHT       (HEADSOFFSET +  27)
#define REDGLOW_NW         (HEADSOFFSET +  28)
#define REDGLOW_NE         (HEADSOFFSET +  29)
#define REDGLOW_SW         (HEADSOFFSET +  30)
#define REDGLOW_SE         (HEADSOFFSET +  31)
#define BLUEHEADUP         (HEADSOFFSET +  32)
#define BLUEHEADDOWN       (HEADSOFFSET +  33)
#define BLUEHEADLEFT       (HEADSOFFSET +  34)
#define BLUEHEADRIGHT      (HEADSOFFSET +  35)
#define BLUEHEAD_NW        (HEADSOFFSET +  36)
#define BLUEHEAD_NE        (HEADSOFFSET +  37)
#define BLUEHEAD_SW        (HEADSOFFSET +  38)
#define BLUEHEAD_SE        (HEADSOFFSET +  39)
#define BLUEGLOWUP         (HEADSOFFSET +  40)
#define BLUEGLOWDOWN       (HEADSOFFSET +  41)
#define BLUEGLOWLEFT       (HEADSOFFSET +  42)
#define BLUEGLOWRIGHT      (HEADSOFFSET +  43)
#define BLUEGLOW_NW        (HEADSOFFSET +  44)
#define BLUEGLOW_NE        (HEADSOFFSET +  45)
#define BLUEGLOW_SW        (HEADSOFFSET +  46)
#define BLUEGLOW_SE        (HEADSOFFSET +  47)
#define YELLOWHEADUP       (HEADSOFFSET +  48)
#define YELLOWHEADDOWN     (HEADSOFFSET +  49)
#define YELLOWHEADLEFT     (HEADSOFFSET +  50)
#define YELLOWHEADRIGHT    (HEADSOFFSET +  51)
#define YELLOWHEAD_NW      (HEADSOFFSET +  52)
#define YELLOWHEAD_NE      (HEADSOFFSET +  53)
#define YELLOWHEAD_SW      (HEADSOFFSET +  54)
#define YELLOWHEAD_SE      (HEADSOFFSET +  55)
#define YELLOWGLOWUP       (HEADSOFFSET +  56)
#define YELLOWGLOWDOWN     (HEADSOFFSET +  57)
#define YELLOWGLOWLEFT     (HEADSOFFSET +  58)
#define YELLOWGLOWRIGHT    (HEADSOFFSET +  59)
#define YELLOWGLOW_NW      (HEADSOFFSET +  60)
#define YELLOWGLOW_NE      (HEADSOFFSET +  61)
#define YELLOWGLOW_SW      (HEADSOFFSET +  62)
#define YELLOWGLOW_SE      (HEADSOFFSET +  63)

/* tails */
#define TAILSOFFSET        (HEADSOFFSET +  64)
#define GN_START           (TAILSOFFSET +   0)
#define GG_START           (TAILSOFFSET +  29)
#define RN_START           (TAILSOFFSET +  58)
#define RG_START           (TAILSOFFSET +  87)
#define BN_START           (TAILSOFFSET + 116)
#define BG_START           (TAILSOFFSET + 145)
#define YN_START           (TAILSOFFSET + 174)
#define YG_START           (TAILSOFFSET + 203)

#define GN_E_NE  (GN_START +   0)
#define GN_E_S   (GN_START +   1)
#define GN_E_SE  (GN_START +   2)
#define GN_NE_SE (GN_START +   3)
#define GN_NE_SW (GN_START +   4)
#define GN_NW_E  (GN_START +   5)
#define GN_NW_NE (GN_START +   6)
#define GN_NW_SE (GN_START +   7)
#define GN_NW_SW (GN_START +   8)
#define GN_N_E   (GN_START +   9)
#define GN_N_NE  (GN_START +  10)
#define GN_N_NW  (GN_START +  11)
#define GN_N_S   (GN_START +  12)
#define GN_N_SE  (GN_START +  13)
#define GN_N_SW  (GN_START +  14)
#define GN_N_W   (GN_START +  15)
#define GN_SW_E  (GN_START +  16)
#define GN_SW_SE (GN_START +  17)
#define GN_S_NE  (GN_START +  18)
#define GN_S_NW  (GN_START +  19)
#define GN_S_SE  (GN_START +  20)
#define GN_S_SW  (GN_START +  21)
#define GN_W_E   (GN_START +  22)
#define GN_W_NE  (GN_START +  23)
#define GN_NW_W  (GN_START +  24)
#define GN_W_S   (GN_START +  25)
#define GN_W_SE  (GN_START +  26)
#define GN_W_SW  (GN_START +  27)
#define GN_ALL   (GN_START +  28)

#define GG_E_NE  (GG_START +   0)
#define GG_E_S   (GG_START +   1)
#define GG_E_SE  (GG_START +   2)
#define GG_NE_SE (GG_START +   3)
#define GG_NE_SW (GG_START +   4)
#define GG_NW_E  (GG_START +   5)
#define GG_NW_NE (GG_START +   6)
#define GG_NW_SE (GG_START +   7)
#define GG_NW_SW (GG_START +   8)
#define GG_N_E   (GG_START +   9)
#define GG_N_NE  (GG_START +  10)
#define GG_N_NW  (GG_START +  11)
#define GG_N_S   (GG_START +  12)
#define GG_N_SE  (GG_START +  13)
#define GG_N_SW  (GG_START +  14)
#define GG_N_W   (GG_START +  15)
#define GG_SW_E  (GG_START +  16)
#define GG_SW_SE (GG_START +  17)
#define GG_S_NE  (GG_START +  18)
#define GG_S_NW  (GG_START +  19)
#define GG_S_SE  (GG_START +  20)
#define GG_S_SW  (GG_START +  21)
#define GG_W_E   (GG_START +  22)
#define GG_W_NE  (GG_START +  23)
#define GG_NW_W  (GG_START +  24)
#define GG_W_S   (GG_START +  25)
#define GG_W_SE  (GG_START +  26)
#define GG_W_SW  (GG_START +  27)
#define GG_ALL   (GG_START +  28)

#define RN_E_NE  (RN_START +   0)
#define RN_E_S   (RN_START +   1)
#define RN_E_SE  (RN_START +   2)
#define RN_NE_SE (RN_START +   3)
#define RN_NE_SW (RN_START +   4)
#define RN_NW_E  (RN_START +   5)
#define RN_NW_NE (RN_START +   6)
#define RN_NW_SE (RN_START +   7)
#define RN_NW_SW (RN_START +   8)
#define RN_N_E   (RN_START +   9)
#define RN_N_NE  (RN_START +  10)
#define RN_N_NW  (RN_START +  11)
#define RN_N_S   (RN_START +  12)
#define RN_N_SE  (RN_START +  13)
#define RN_N_SW  (RN_START +  14)
#define RN_N_W   (RN_START +  15)
#define RN_SW_E  (RN_START +  16)
#define RN_SW_SE (RN_START +  17)
#define RN_S_NE  (RN_START +  18)
#define RN_S_NW  (RN_START +  19)
#define RN_S_SE  (RN_START +  20)
#define RN_S_SW  (RN_START +  21)
#define RN_W_E   (RN_START +  22)
#define RN_W_NE  (RN_START +  23)
#define RN_NW_W  (RN_START +  24)
#define RN_W_S   (RN_START +  25)
#define RN_W_SE  (RN_START +  26)
#define RN_W_SW  (RN_START +  27)
#define RN_ALL   (RN_START +  28)

#define RG_E_NE  (RG_START +   0)
#define RG_E_S   (RG_START +   1)
#define RG_E_SE  (RG_START +   2)
#define RG_NE_SE (RG_START +   3)
#define RG_NE_SW (RG_START +   4)
#define RG_NW_E  (RG_START +   5)
#define RG_NW_NE (RG_START +   6)
#define RG_NW_SE (RG_START +   7)
#define RG_NW_SW (RG_START +   8)
#define RG_N_E   (RG_START +   9)
#define RG_N_NE  (RG_START +  10)
#define RG_N_NW  (RG_START +  11)
#define RG_N_S   (RG_START +  12)
#define RG_N_SE  (RG_START +  13)
#define RG_N_SW  (RG_START +  14)
#define RG_N_W   (RG_START +  15)
#define RG_SW_E  (RG_START +  16)
#define RG_SW_SE (RG_START +  17)
#define RG_S_NE  (RG_START +  18)
#define RG_S_NW  (RG_START +  19)
#define RG_S_SE  (RG_START +  20)
#define RG_S_SW  (RG_START +  21)
#define RG_W_E   (RG_START +  22)
#define RG_W_NE  (RG_START +  23)
#define RG_NW_W  (RG_START +  24)
#define RG_W_S   (RG_START +  25)
#define RG_W_SE  (RG_START +  26)
#define RG_W_SW  (RG_START +  27)
#define RG_ALL   (RG_START +  28)

#define BN_E_NE  (BN_START +   0)
#define BN_E_S   (BN_START +   1)
#define BN_E_SE  (BN_START +   2)
#define BN_NE_SE (BN_START +   3)
#define BN_NE_SW (BN_START +   4)
#define BN_NW_E  (BN_START +   5)
#define BN_NW_NE (BN_START +   6)
#define BN_NW_SE (BN_START +   7)
#define BN_NW_SW (BN_START +   8)
#define BN_N_E   (BN_START +   9)
#define BN_N_NE  (BN_START +  10)
#define BN_N_NW  (BN_START +  11)
#define BN_N_S   (BN_START +  12)
#define BN_N_SE  (BN_START +  13)
#define BN_N_SW  (BN_START +  14)
#define BN_N_W   (BN_START +  15)
#define BN_SW_E  (BN_START +  16)
#define BN_SW_SE (BN_START +  17)
#define BN_S_NE  (BN_START +  18)
#define BN_S_NW  (BN_START +  19)
#define BN_S_SE  (BN_START +  20)
#define BN_S_SW  (BN_START +  21)
#define BN_W_E   (BN_START +  22)
#define BN_W_NE  (BN_START +  23)
#define BN_NW_W  (BN_START +  24)
#define BN_W_S   (BN_START +  25)
#define BN_W_SE  (BN_START +  26)
#define BN_W_SW  (BN_START +  27)
#define BN_ALL   (BN_START +  28)

#define BG_E_NE  (BG_START +   0)
#define BG_E_S   (BG_START +   1)
#define BG_E_SE  (BG_START +   2)
#define BG_NE_SE (BG_START +   3)
#define BG_NE_SW (BG_START +   4)
#define BG_NW_E  (BG_START +   5)
#define BG_NW_NE (BG_START +   6)
#define BG_NW_SE (BG_START +   7)
#define BG_NW_SW (BG_START +   8)
#define BG_N_E   (BG_START +   9)
#define BG_N_NE  (BG_START +  10)
#define BG_N_NW  (BG_START +  11)
#define BG_N_S   (BG_START +  12)
#define BG_N_SE  (BG_START +  13)
#define BG_N_SW  (BG_START +  14)
#define BG_N_W   (BG_START +  15)
#define BG_SW_E  (BG_START +  16)
#define BG_SW_SE (BG_START +  17)
#define BG_S_NE  (BG_START +  18)
#define BG_S_NW  (BG_START +  19)
#define BG_S_SE  (BG_START +  20)
#define BG_S_SW  (BG_START +  21)
#define BG_W_E   (BG_START +  22)
#define BG_W_NE  (BG_START +  23)
#define BG_NW_W  (BG_START +  24)
#define BG_W_S   (BG_START +  25)
#define BG_W_SE  (BG_START +  26)
#define BG_W_SW  (BG_START +  27)
#define BG_ALL   (BG_START +  28)

#define YN_E_NE  (YN_START +   0)
#define YN_E_S   (YN_START +   1)
#define YN_E_SE  (YN_START +   2)
#define YN_NE_SE (YN_START +   3)
#define YN_NE_SW (YN_START +   4)
#define YN_NW_E  (YN_START +   5)
#define YN_NW_NE (YN_START +   6)
#define YN_NW_SE (YN_START +   7)
#define YN_NW_SW (YN_START +   8)
#define YN_N_E   (YN_START +   9)
#define YN_N_NE  (YN_START +  10)
#define YN_N_NW  (YN_START +  11)
#define YN_N_S   (YN_START +  12)
#define YN_N_SE  (YN_START +  13)
#define YN_N_SW  (YN_START +  14)
#define YN_N_W   (YN_START +  15)
#define YN_SW_E  (YN_START +  16)
#define YN_SW_SE (YN_START +  17)
#define YN_S_NE  (YN_START +  18)
#define YN_S_NW  (YN_START +  19)
#define YN_S_SE  (YN_START +  20)
#define YN_S_SW  (YN_START +  21)
#define YN_W_E   (YN_START +  22)
#define YN_W_NE  (YN_START +  23)
#define YN_NW_W  (YN_START +  24)
#define YN_W_S   (YN_START +  25)
#define YN_W_SE  (YN_START +  26)
#define YN_W_SW  (YN_START +  27)
#define YN_ALL   (YN_START +  28)

#define YG_E_NE  (YG_START +   0)
#define YG_E_S   (YG_START +   1)
#define YG_E_SE  (YG_START +   2)
#define YG_NE_SE (YG_START +   3)
#define YG_NE_SW (YG_START +   4)
#define YG_NW_E  (YG_START +   5)
#define YG_NW_NE (YG_START +   6)
#define YG_NW_SE (YG_START +   7)
#define YG_NW_SW (YG_START +   8)
#define YG_N_E   (YG_START +   9)
#define YG_N_NE  (YG_START +  10)
#define YG_N_NW  (YG_START +  11)
#define YG_N_S   (YG_START +  12)
#define YG_N_SE  (YG_START +  13)
#define YG_N_SW  (YG_START +  14)
#define YG_N_W   (YG_START +  15)
#define YG_SW_E  (YG_START +  16)
#define YG_SW_SE (YG_START +  17)
#define YG_S_NE  (YG_START +  18)
#define YG_S_NW  (YG_START +  19)
#define YG_S_SE  (YG_START +  20)
#define YG_S_SW  (YG_START +  21)
#define YG_W_E   (YG_START +  22)
#define YG_W_NE  (YG_START +  23)
#define YG_NW_W  (YG_START +  24)
#define YG_W_S   (YG_START +  25)
#define YG_W_SE  (YG_START +  26)
#define YG_W_SW  (YG_START +  27)
#define YG_ALL   (YG_START +  28)

#define ZERONUMBER     (YG_ALL + 1)
#define COLON          (YG_ALL + 2)
#define MULTIPLICATION (YG_ALL + 3)
#define EQUALS         (YG_ALL + 4)
#define ARRAYSIZE       EQUALS // counting from 0 (ie. elements are 0..ARRAYSIZE)

#define GN_SE_NW      GN_NW_SE
#define GN_SE_N       GN_N_SE
#define GN_SE_NE      GN_NE_SE
#define GN_SE_W       GN_W_SE
#define GN_SE_E       GN_E_SE
#define GN_SE_SW      GN_SW_SE
#define GN_SE_S       GN_S_SE
#define GN_S_N        GN_N_S
#define GN_S_W        GN_W_S
#define GN_S_E        GN_E_S
#define GN_SW_NW      GN_NW_SW
#define GN_SW_N       GN_N_SW
#define GN_SW_NE      GN_NE_SW
#define GN_SW_W       GN_W_SW
#define GN_SW_S       GN_S_SW
#define GN_E_NW       GN_NW_E
#define GN_E_N        GN_N_E
#define GN_E_W        GN_W_E
#define GN_E_SW       GN_SW_E
#define GN_W_NW       GN_NW_W
#define GN_W_N        GN_N_W
#define GN_NE_NW      GN_NW_NE
#define GN_NE_N       GN_N_NE
#define GN_NE_W       GN_W_NE
#define GN_NE_E       GN_E_NE
#define GN_NE_S       GN_S_NE
#define GN_NW_N       GN_N_NW
#define GN_NW_S       GN_S_NW

#define GG_SE_NW      GG_NW_SE
#define GG_SE_N       GG_N_SE
#define GG_SE_NE      GG_NE_SE
#define GG_SE_W       GG_W_SE
#define GG_SE_E       GG_E_SE
#define GG_SE_SW      GG_SW_SE
#define GG_SE_S       GG_S_SE
#define GG_S_N        GG_N_S
#define GG_S_W        GG_W_S
#define GG_S_E        GG_E_S
#define GG_SW_NW      GG_NW_SW
#define GG_SW_N       GG_N_SW
#define GG_SW_NE      GG_NE_SW
#define GG_SW_W       GG_W_SW
#define GG_SW_S       GG_S_SW
#define GG_E_NW       GG_NW_E
#define GG_E_N        GG_N_E
#define GG_E_W        GG_W_E
#define GG_E_SW       GG_SW_E
#define GG_W_NW       GG_NW_W
#define GG_W_N        GG_N_W
#define GG_NE_NW      GG_NW_NE
#define GG_NE_N       GG_N_NE
#define GG_NE_W       GG_W_NE
#define GG_NE_E       GG_E_NE
#define GG_NE_S       GG_S_NE
#define GG_NW_N       GG_N_NW
#define GG_NW_S       GG_S_NW

#define RN_SE_NW      RN_NW_SE
#define RN_SE_N       RN_N_SE
#define RN_SE_NE      RN_NE_SE
#define RN_SE_W       RN_W_SE
#define RN_SE_E       RN_E_SE
#define RN_SE_SW      RN_SW_SE
#define RN_SE_S       RN_S_SE
#define RN_S_N        RN_N_S
#define RN_S_W        RN_W_S
#define RN_S_E        RN_E_S
#define RN_SW_NW      RN_NW_SW
#define RN_SW_N       RN_N_SW
#define RN_SW_NE      RN_NE_SW
#define RN_SW_W       RN_W_SW
#define RN_SW_S       RN_S_SW
#define RN_E_NW       RN_NW_E
#define RN_E_N        RN_N_E
#define RN_E_W        RN_W_E
#define RN_E_SW       RN_SW_E
#define RN_W_NW       RN_NW_W
#define RN_W_N        RN_N_W
#define RN_NE_NW      RN_NW_NE
#define RN_NE_N       RN_N_NE
#define RN_NE_W       RN_W_NE
#define RN_NE_E       RN_E_NE
#define RN_NE_S       RN_S_NE
#define RN_NW_N       RN_N_NW
#define RN_NW_S       RN_S_NW

#define RG_SE_NW      RG_NW_SE
#define RG_SE_N       RG_N_SE
#define RG_SE_NE      RG_NE_SE
#define RG_SE_W       RG_W_SE
#define RG_SE_E       RG_E_SE
#define RG_SE_SW      RG_SW_SE
#define RG_SE_S       RG_S_SE
#define RG_S_N        RG_N_S
#define RG_S_W        RG_W_S
#define RG_S_E        RG_E_S
#define RG_SW_NW      RG_NW_SW
#define RG_SW_N       RG_N_SW
#define RG_SW_NE      RG_NE_SW
#define RG_SW_W       RG_W_SW
#define RG_SW_S       RG_S_SW
#define RG_E_NW       RG_NW_E
#define RG_E_N        RG_N_E
#define RG_E_W        RG_W_E
#define RG_E_SW       RG_SW_E
#define RG_W_NW       RG_NW_W
#define RG_W_N        RG_N_W
#define RG_NE_NW      RG_NW_NE
#define RG_NE_N       RG_N_NE
#define RG_NE_W       RG_W_NE
#define RG_NE_E       RG_E_NE
#define RG_NE_S       RG_S_NE
#define RG_NW_N       RG_N_NW
#define RG_NW_S       RG_S_NW

#define BN_SE_NW      BN_NW_SE
#define BN_SE_N       BN_N_SE
#define BN_SE_NE      BN_NE_SE
#define BN_SE_W       BN_W_SE
#define BN_SE_E       BN_E_SE
#define BN_SE_SW      BN_SW_SE
#define BN_SE_S       BN_S_SE
#define BN_S_N        BN_N_S
#define BN_S_W        BN_W_S
#define BN_S_E        BN_E_S
#define BN_SW_NW      BN_NW_SW
#define BN_SW_N       BN_N_SW
#define BN_SW_NE      BN_NE_SW
#define BN_SW_W       BN_W_SW
#define BN_SW_S       BN_S_SW
#define BN_E_NW       BN_NW_E
#define BN_E_N        BN_N_E
#define BN_E_W        BN_W_E
#define BN_E_SW       BN_SW_E
#define BN_W_NW       BN_NW_W
#define BN_W_N        BN_N_W
#define BN_NE_NW      BN_NW_NE
#define BN_NE_N       BN_N_NE
#define BN_NE_W       BN_W_NE
#define BN_NE_E       BN_E_NE
#define BN_NE_S       BN_S_NE
#define BN_NW_N       BN_N_NW
#define BN_NW_S       BN_S_NW

#define BG_SE_NW      BG_NW_SE
#define BG_SE_N       BG_N_SE
#define BG_SE_NE      BG_NE_SE
#define BG_SE_W       BG_W_SE
#define BG_SE_E       BG_E_SE
#define BG_SE_SW      BG_SW_SE
#define BG_SE_S       BG_S_SE
#define BG_S_N        BG_N_S
#define BG_S_W        BG_W_S
#define BG_S_E        BG_E_S
#define BG_SW_NW      BG_NW_SW
#define BG_SW_N       BG_N_SW
#define BG_SW_NE      BG_NE_SW
#define BG_SW_W       BG_W_SW
#define BG_SW_S       BG_S_SW
#define BG_E_NW       BG_NW_E
#define BG_E_N        BG_N_E
#define BG_E_W        BG_W_E
#define BG_E_SW       BG_SW_E
#define BG_W_NW       BG_NW_W
#define BG_W_N        BG_N_W
#define BG_NE_NW      BG_NW_NE
#define BG_NE_N       BG_N_NE
#define BG_NE_W       BG_W_NE
#define BG_NE_E       BG_E_NE
#define BG_NE_S       BG_S_NE
#define BG_NW_N       BG_N_NW
#define BG_NW_S       BG_S_NW

#define YN_SE_NW      YN_NW_SE
#define YN_SE_N       YN_N_SE
#define YN_SE_NE      YN_NE_SE
#define YN_SE_W       YN_W_SE
#define YN_SE_E       YN_E_SE
#define YN_SE_SW      YN_SW_SE
#define YN_SE_S       YN_S_SE
#define YN_S_N        YN_N_S
#define YN_S_W        YN_W_S
#define YN_S_E        YN_E_S
#define YN_SW_NW      YN_NW_SW
#define YN_SW_N       YN_N_SW
#define YN_SW_NE      YN_NE_SW
#define YN_SW_W       YN_W_SW
#define YN_SW_S       YN_S_SW
#define YN_E_NW       YN_NW_E
#define YN_E_N        YN_N_E
#define YN_E_W        YN_W_E
#define YN_E_SW       YN_SW_E
#define YN_W_NW       YN_NW_W
#define YN_W_N        YN_N_W
#define YN_NE_NW      YN_NW_NE
#define YN_NE_N       YN_N_NE
#define YN_NE_W       YN_W_NE
#define YN_NE_E       YN_E_NE
#define YN_NE_S       YN_S_NE
#define YN_NW_N       YN_N_NW
#define YN_NW_S       YN_S_NW

#define YG_SE_NW      YG_NW_SE
#define YG_SE_N       YG_N_SE
#define YG_SE_NE      YG_NE_SE
#define YG_SE_W       YG_W_SE
#define YG_SE_E       YG_E_SE
#define YG_SE_SW      YG_SW_SE
#define YG_SE_S       YG_S_SE
#define YG_S_N        YG_N_S
#define YG_S_W        YG_W_S
#define YG_S_E        YG_E_S
#define YG_SW_NW      YG_NW_SW
#define YG_SW_N       YG_N_SW
#define YG_SW_NE      YG_NE_SW
#define YG_SW_W       YG_W_SW
#define YG_SW_S       YG_S_SW
#define YG_E_NW       YG_NW_E
#define YG_E_N        YG_N_E
#define YG_E_W        YG_W_E
#define YG_E_SW       YG_SW_E
#define YG_W_NW       YG_NW_W
#define YG_W_N        YG_N_W
#define YG_NE_NW      YG_NW_NE
#define YG_NE_N       YG_N_NE
#define YG_NE_W       YG_W_NE
#define YG_NE_E       YG_E_NE
#define YG_NE_S       YG_S_NE
#define YG_NW_N       YG_N_NW
#define YG_NW_S       YG_S_NW

/* game status */
#define GAMEOVER        0
#define PLAYGAME        1
#define LEVELEDIT       2
#define TITLESCREEN     3

/* indicator locations */
#define ICONY           (-1)
#define CLOCKICONX      (-2)
#define MUSICICONX      (-3)

/* control values */
#define NONE            0 /* must be 0 */
#define THEAMIGA        1
#define JOYSTICK        2
#define GAMEPAD         3
#define KEYBOARD        4
#define IBMPC           THEAMIGA

#define BANANAFRAMES      8 // counting from 1
#define BIRDFRAMES        4 // counting from 0
#define MISSILEFRAMES     5 // counting from 0
#define SQUIDFRAMES       3 // counting from 0
#define EELFRAMES         3 // counting from 0
#define TURTLEFRAMES      4 // counting from 1

#define PAIN_CREATURE     3
#define PAIN_HEAD         3
#define PAIN_PROTECTOR    3
#define PAIN_SLIME        1

/* 3. GLOBAL FUNCTIONS ---------------------------------------------------

(amiga|ibm).c */
EXPORT void playsong(UBYTE whichsong);
EXPORT void celebrate(void);
EXPORT void clearkybd(void);
EXPORT void clearscreen(void);
EXPORT void datestamp(void);
EXPORT void dotext(int x, int y, STRPTR thestring);
EXPORT void gameinput(void);
EXPORT void renderhiscores_amiga(void);
EXPORT void intro(void);
EXPORT void resettime(void);
EXPORT void systemsetup(void);
EXPORT void timing(void);
EXPORT void turborender(void);
EXPORT void waitasec(void);
EXPORT void whiteline(void);
EXPORT FLAG anykey(FLAG timeout, FLAG allowrmb);
EXPORT FLAG verify(void);
EXPORT void cleanexit(SLONG rc);
EXPORT void effect(int index);
EXPORT void fileopen(FLAG revert);
EXPORT void filesaveas(FLAG saveas);
EXPORT void say(STRPTR sentence, COLOUR colour);
EXPORT void stopfx(void);
EXPORT void ReadAdapterJoystick(UBYTE unit);
EXPORT void ReadStandardJoystick(ULONG port);
EXPORT void ReadGamepads(void);
EXPORT void printstat(int player, int theline);
EXPORT void help(UBYTE type);
EXPORT void help_about(void);
EXPORT void help_update(void);
EXPORT void helploop(UBYTE type);
EXPORT void toggle(SBYTE key);
EXPORT void filedelete(void);
EXPORT void colourline(int player);
EXPORT SLONG wormobject(int player, int x, int y);
EXPORT void bangdynamite(int x, int y);
EXPORT void putnumber(void);
EXPORT void turnworm(int player, int deltax, int deltay);
EXPORT void updatearrow(int arrowy);
EXPORT void protworm(int x, int y, int player1, int player2);
EXPORT void squareblast(UBYTE triggerer, int player, UWORD c, int x, int y, FLAG cutter, FLAG superbomb);
EXPORT void drawmissile(int x, int y, UBYTE which);
EXPORT FLAG blockedtel(UBYTE which, int deltax, int deltay);
EXPORT int isign(int value);
EXPORT FLAG  getnumber(int player);
EXPORT UBYTE speedup(UBYTE speed, int player);
EXPORT ULONG arand(ULONG number);
EXPORT UBYTE whichteleport(int x, int y);
EXPORT void stat(int player, int image);
EXPORT void teleportcreature(UBYTE i, UBYTE which);
EXPORT int createprotector(int player, int x, int y);
EXPORT void dosidebar(void);
EXPORT void introanim(void);
EXPORT void intro_draw(int x, int y, UWORD what);
EXPORT void rectfill_black(int leftx, int topy, int rightx, int bottomy);
EXPORT void rectfill_grey(int leftx, int topy, int rightx, int bottomy);
EXPORT void rectfill_white(int leftx, int topy, int rightx, int bottomy);
EXPORT void rectfill_red(int leftx, int topy, int rightx, int bottomy);
EXPORT void le_loop(void);
EXPORT void ami_drawbox(int leftx, int topy, int width, int height);
EXPORT void dot(void);
EXPORT void busypointer(void);
EXPORT void normalpointer(void);
#ifdef AMIGA
    EXPORT void rq(STRPTR text);
    EXPORT void writetext(int x, int y, UBYTE colour, STRPTR text);
    EXPORT void ami_draw(int firstx, int firsty, int secondx, int secondy, UBYTE colour);
    EXPORT void drawboing(void);
    EXPORT void drawlogo(void);
    #ifdef __VBCC__
        EXPORT int stricmp(const char* s1, const char* s2);
        EXPORT double strtod(const char* string, char** endPtr);
    #endif
#endif
#ifdef WIN32
    EXPORT void openconsole(void);
    EXPORT void writetext(int x, int y, COLOUR colour, STRPTR text);
    EXPORT void ami_draw(int firstx, int firsty, int secondx, int secondy, COLOUR colour);
    EXPORT void iconify(void);
    EXPORT double zatof(STRPTR inputstr);
    EXPORT void openurl(STRPTR command);
    EXPORT void releasepointer(void);
    EXPORT STRPTR GetCatalogStr(int catalog, LONG stringNum, STRPTR defaultString);
    EXPORT void handleinput(SCANCODE code);
    EXPORT FLAG busyloop(FLAG any);
    EXPORT void blacken(void);
#endif
#if defined(WIN32) || defined(GBA)
    EXPORT void stcl_d(STRPTR out, long integer);
#endif

// engine#?.c
EXPORT void changefield(void);
EXPORT void clearhiscores(void);
EXPORT void enginesetup(void);
EXPORT void enginesetup2(void);
EXPORT UWORD getarrowimage(int arrowy);
EXPORT UWORD getimage_creature(int which);
EXPORT UWORD getimage_head(int player);
EXPORT void newfields(void);
EXPORT void timeloop(void);
EXPORT void newfield(void);
EXPORT void icon(int player, int image);
EXPORT void saylevel(COLOUR colour);
EXPORT void train(SCANCODE scancode);
EXPORT void wormscore(int player, SLONG score);
EXPORT void wormscore_unscaled(int player, SLONG score);
EXPORT void align(STRPTR string, SBYTE size, TEXT filler);
EXPORT void wormcol(int player, int x, int y);
EXPORT void bombblast(UBYTE triggerer, int player, int centrex, int centrey, FLAG superbomb, int strength);
EXPORT void change1(int x, int y, UWORD image);
EXPORT void change2(int x, int y, UWORD real, UWORD gfximage);
EXPORT FLAG savefields(STRPTR pathname);
EXPORT FLAG valid(int x, int y);
EXPORT int xwrap(int x);
EXPORT int ywrap(int y);
EXPORT void introanim_engine(int introframe);
EXPORT STRPTR getintrotext(void);
EXPORT void bothcol(int player, int x, int y);
EXPORT void createcreature(UWORD species, UBYTE which, int x, int y, int deltax, int deltay, int player, UWORD subspecies, UBYTE creator);
EXPORT void creatureloop(UBYTE which);
EXPORT void wormkillcreature(int player, UBYTE which, FLAG showpoints);
EXPORT void protcreature(int player, UBYTE which);
EXPORT void wormcreature(int player, UBYTE which);
EXPORT void octopusfire(UBYTE which);
EXPORT UBYTE whichcreature(int x, int y, UWORD species, UBYTE exception);
EXPORT void wormloop(int player);
EXPORT void wormqueue(int player, int deltax, int deltay);
EXPORT FLAG blockedsquare(int x, int y);
EXPORT void drawcreature(int which);
EXPORT void stoppedwormloop(int player);
EXPORT UBYTE partner(UBYTE which);
EXPORT int sgn(int value);
EXPORT FLAG isempty(int x, int y);
EXPORT FLAG iswall(int x, int y);
EXPORT FLAG hiscoresareclear(void);
EXPORT UWORD getdigit(int number);
EXPORT void outro(void);

// le.c
EXPORT void undot(void);
EXPORT void fieldedit(void);
EXPORT void fillfield(UBYTE which);
EXPORT void le_dosidebar(void);
EXPORT void le_drawfield(void);
EXPORT void le_handlekybd(SCANCODE scancode);
EXPORT void le_leftdown(int mousex, int mousey);
EXPORT void le_rightdown(int mousex, int mousey);
EXPORT void setbrush(UWORD newbrush);
EXPORT void stamp(UWORD square);
EXPORT void updatemenu(void);
EXPORT int xpixeltosquare(int x);
EXPORT int ypixeltosquare(int y);
EXPORT void le_cut(void);
EXPORT void le_copy(void);
EXPORT void le_paste(void);
EXPORT void le_append(void);
EXPORT void le_delete(void);
EXPORT void le_erase(void);
EXPORT void le_insert(void);

/* squares.c */
EXPORT void draw(int x, int y, UWORD image);
EXPORT void raw_draw(int x, int y, UWORD image);
EXPORT void le_draw(int x, int y, UWORD image);

#ifdef WIN32
    EXPORT void playmusic(void);
    EXPORT void stopmusic(void);
    EXPORT void toggle(SBYTE key);
    EXPORT void domusic(void);
    EXPORT void view_pointer(void);
    EXPORT void readibmgameport(int unit);
#endif

/* gfx.c */
#ifdef AMIGA
    EXPORT void remap(void);
    EXPORT void drawabout(void);
    EXPORT void drawbackground(void);
    EXPORT void drawboing(void);
    EXPORT void drawlogo(void);
    EXPORT void swap_byteorder(UWORD* imagedata, ULONG size);
    EXPORT void gfx_swap_byteorder(void);
    EXPORT void squares_swap_byteorder(void);
    EXPORT void heads_swap_byteorder(void);
    EXPORT void tails_swap_byteorder(void);
#endif

/* 4. GLOBAL STRUCTURES -------------------------------------------------- */

EXPORT struct HiScoreStruct
{   SBYTE player;
    SBYTE level;
    SLONG score;                /* the score itself    */
    TEXT  name[NAMELENGTH + 2]; /* name of the player  */
    FLAG  fresh;                /* is the entry new?   */
    TEXT  date[DATELENGTH + 1]; /* date of achievement */
    TEXT  time[TIMELENGTH + 1]; /* time of achievement */
};
EXPORT struct WormStruct
{   int    x,
           y,
           deltax,
           deltay,
           olddeltax,
           olddeltay,
           queuepos;
    SBYTE  position,
           posidir,
           statx,
           staty,
           levelreached,
           arrowy,
           numbers;
    FLAG   affixer,
           alive,
           autojump,
           autoturn,
           backwards,
           brakes,
           encloser,
           flashed,
           forwards,
           frosted,
           grenade,
           moved,
           pusher,
           rammed,
           remnants,
           sideshot,
           wait;
    UBYTE  speed,
           control,
           cause,
           last,
           multi,
           power,
           ammo;
    SWORD  armour,
           bias,
           cutter,
           lives,
           glow;
    SLONG  score,
           oldscore,
           hiscore,
           nextlife;
    ULONG  port;
    TEXT   name[NAMELENGTH + 1];
    COLOUR colour,
           dimcolour;
};
#define SPECIES 39 // counting from 0
EXPORT struct CreatureInfoStruct
{   UWORD  symbol;
    FLAG   wall; // does it naturally live on walls?
    UWORD  freq;
    UBYTE  speed;
    SLONG  score;
    STRPTR name;
    UBYTE  introlevel;
    FLAG   user; // is it shown to user?
};
EXPORT struct ObjectInfoStruct
{   UWORD  freq;
    UBYTE  introlevel;
    STRPTR desc;
};
EXPORT struct TeleportStruct
{   int x, y;
};
EXPORT struct PointStruct
{   UWORD final;
    int   time,
          x, y;
};

#ifdef ANDROID
// Java-accessible functions
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_MainActivity_cloadfields(    JNIEnv* env, jobject this, jstring passedname, jint length, jbyteArray ptr);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_MainActivity_csetoptions(    JNIEnv* env, jobject this, jint options);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_MainActivity_getbufsize(     JNIEnv* env, jobject this, jint whichchan);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_MainActivity_gethertz(       JNIEnv* env, jobject this, jint whichchan);

JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_csetoptions(    JNIEnv* env, jobject this, jint options);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_endgame(        JNIEnv* env, jobject this);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_enqueue(        JNIEnv* env, jobject this, jint deltax, jint deltay);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_gameloop(       JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_GameActivity_getdelay(       JNIEnv* env, jobject this);
JNIEXPORT jbyteArray JNICALL Java_com_amigan_wormwars_GameActivity_getsaystring(   JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_GameActivity_getsaycolour(   JNIEnv* env, jobject this);
JNIEXPORT jbyteArray JNICALL Java_com_amigan_wormwars_GameActivity_getsoundbuffer( JNIEnv* env, jobject this, jint whichchan);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_GameActivity_getsounds1(     JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_GameActivity_getsounds2(     JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_GameActivity_getstatus(      JNIEnv* env, jobject this);
JNIEXPORT jboolean   JNICALL Java_com_amigan_wormwars_GameActivity_getwaiting(     JNIEnv* env, jobject this);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_newgame(        JNIEnv* env, jobject this);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_redrawscreen(   JNIEnv* env, jobject this);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_setframebuffer( JNIEnv* env, jobject this, jobject oBuf, jint width, jint height);
JNIEXPORT void       JNICALL Java_com_amigan_wormwars_GameActivity_setstatbuffers( JNIEnv* env, jobject this, jobject oBuf1, jobject oBuf2);

JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_BottomView_getbullets(       JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_BottomView_getdelta(         JNIEnv* env, jobject this);
JNIEXPORT jint       JNICALL Java_com_amigan_wormwars_BottomView_getspeed(         JNIEnv* env, jobject this);

EXPORT void credrawscreen(void);
EXPORT void drawstat(int x, int y, UWORD image, int player);
EXPORT int loadfields(void);
EXPORT void stcl_d(STRPTR out, long integer);
#else
EXPORT void gameloop(void);
EXPORT int loadfields(STRPTR pathname);
EXPORT void newgame(void);
#endif
