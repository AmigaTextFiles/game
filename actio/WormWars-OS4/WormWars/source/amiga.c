// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#include <exec/types.h>
#include <exec/execbase.h>
#include <exec/resident.h>
#include <devices/audio.h>
#include <devices/gameport.h>
#include <graphics/gfxbase.h>
#include <hardware/cia.h>
#define ASL_PRE_V38_NAMES          // needed for OS4
#include <libraries/asl.h>
#define __USE_OLD_TIMEVAL__        // needed for OS4
#include <devices/timer.h>
#include <libraries/amigaguide.h>
#include <intuition/gadgetclass.h> // GA_Disabled, STRINGA_ReplaceMode
#include <dos/dostags.h>           // SYS_Output, etc.
#include <dos/datetime.h>          // struct DateTime
#define __NOLIBBASE__
#include <libraries/locale.h>
#undef __NOLIBBASE__
#ifdef __amigaos4__
    #include <libraries/application.h>
#endif

#include <stdio.h>
#include <stdlib.h>                // size_t
#include <string.h>                // stricmp()

#include "shared.h"
#include "amiga.h"
#include "ww.h"

#ifndef __MORPHOS__
    #ifdef __amigaos4__
        #include "proto/medplayer.h"
    #else
        #include "libproto.h"
    #endif
    #ifndef __amigaos4__
        #define USE_LOCAL_OPENURL
    #endif
#endif

#ifdef __MORPHOS__
    #define USE_INLINE_STDARG
    #include <proto/openurl.h>
#else
    #ifdef USE_LOCAL_OPENURL
        #include "openurl.h"
    #else
        #define __USE_INLINE__
        #include <proto/openurl.h>
        #include <libraries/openurl.h>
    #endif
#endif

#ifdef __AROS__
#include <aros/macros.h>
#define BE2LONG(x) AROS_BE2LONG(x)
#define BE2WORD(x) AROS_BE2WORD(x)
#else
#define BE2LONG(x) (x)
#define BE2WORD(x) (x)
#endif

#if defined(__AROS) || defined(__MORPHOS__)
    // wrappers for some non-existing functions and structs
    EXPORT void ContModule(struct MMD0* module)   { ; }
    EXPORT void FreePlayer()                      { ; }
    EXPORT LONG GetPlayer(UWORD midi)             { return FALSE; }
    EXPORT struct MMD0 *LoadModule(char* name)    { return NULL;  }
    EXPORT void PlayModule(struct MMD0* module)   { ; }
    EXPORT void SetJoyPortAttrs()                 { ; }
    EXPORT void StopPlayer()                      { ; }
    EXPORT void UnLoadModule(struct MMD0* module) { ; }
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #define ASSERT
#include <assert.h>
#include <time.h>
#include <ctype.h>

#include <proto/amigaguide.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <proto/asl.h>
#include <proto/exec.h>
#include <proto/diskfont.h>
#include <proto/dos.h>
#include <proto/gadtools.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#define __NOLIBBASE__
#include <proto/locale.h>
#include <proto/utility.h>
#undef __NOLIBBASE__
#include <proto/lowlevel.h>
#include <proto/timer.h>
#include <clib/alib_protos.h>

#ifdef __amigaos4__
    #include <dos/obsolete.h>      // pr_TaskNum
#endif

#define CATCOMP_NUMBERS
#define CATCOMP_CODE
#define CATCOMP_BLOCK
#include "ww_strings.h"

#if defined(__amigaos4__) || defined(__MORPHOS__)
    #include <errno.h>
#else
    #define howmany(x, y) (((x)+((y)-1))/(y))

    extern int errno;
#endif

// 2. DEFINES ------------------------------------------------------------

// #define BLACKBG
// for black background instead of grey

typedef LONG Fixed;          /* A fixed-point value, 16 bits to the left
                                of the point and 16 to the right. A Fixed
                                is a number of 2**16ths, ie. 65536ths. */
typedef struct
{   ULONG oneShotHiSamples,  /* # samples in the high octave 1-shot part */
          repeatHiSamples,   /* # samples in the high octave repeat part */
          samplesPerHiCycle; /* # samples/cycle in high octave, else 0 */
    UWORD samplesPerSec;     /* data sampling rate */
    UBYTE ctOctave,          /* # of octaves of waveforms */
          sCompression;      /* data compression technique used */
    Fixed volume;            /* playback nominal volume from 0 to Unity
                                (full volume). Map this value into the
                                output hardware's dynamic range (0-64). */
} Voice8Header;

#define TIMEOUT         50 // in INTUITICKs
#define CONFIGLENGTH    33 // counting from 1

#define ONE_BILLION 1000000000

/* joysticks */

#define JOYUP          1
#define JOYDOWN        2
#define JOYLEFT        4
#define JOYRIGHT       8
#define JOYFIRE1      16
#define JOYFIRE2      32
#define POTGOR         *(UWORD*)0xDFF016

#define OLD            1
#define NEW            0

/* Help|About... window */

#define ABOUTLINES     8

#define COMPILEDX    188
#define COMPILEDY     79
#define VERSIONX     188
#define VERSIONY      88
#define PRIORITYX    188
#define PRIORITYY     97
#define PROCESSX     188
#define PROCESSY     106

/* fxable/musicable */

#define FAILED         0 // tried and failed
#define SUCCEEDED      1 // tried and succeeded
#define UNTRIED        2 // untried, will try at startup
#define DEFER          3 // untried, will try when needed

/* miscellaneous */

#define ANIMDELAY        1800
#define MAXXSIZE         1280
#define MAXYSIZE         1024

/* constant strings used more than once */

#define PATTERN            "(#?.lset)"
#define OLDKICKSTART       "Worm Wars: Can't open intuition.library V37+!\n"
// can't localize this because it's for very old Amigas

#define ID_8SVX            MAKE_ID('8','S','V','X')
#define ID_BODY            MAKE_ID('B','O','D','Y')
#define ID_VHDR            MAKE_ID('V','H','D','R')
#define PALCLOCK      3546895
#define NTSCCLOCK     3579545

#define INTROTILEX         (FIELDCENTREXPIXEL - 149)
#define INTROTEXTX         (FIELDCENTREXPIXEL - 129)

#define CREATUREHELPS      37 // counting from 1

#define ANIMPOS_BIRD        2
#define ANIMPOS_EEL        10
#define ANIMPOS_SQUID      33
#define ANIMPOS_TURTLE     35

// #define TRACKENTRY
// #define TRACKEXIT
#define TRACKDELAY         25

#define ARGPOS_USELOWLEVEL  0
#define ARGPOS_NOPRELOAD    1
#define ARGPOS_NOANIMS      2
#define ARGPOS_NOICONS      3
#define ARGPOS_PRI          4
#define ARGPOS_SCREENMODE   5
#define ARGPOS_SHUFFLE      6
#define ARGPOS_QUIET        7
#define ARGPOS_GREEN        8
#define ARGPOS_RED          9
#define ARGPOS_BLUE        10
#define ARGPOS_YELLOW      11
#define ARGPOS_PUBSCREEN   12
#define ARGPOS_WINWIDTH    13
#define ARGPOS_WINHEIGHT   14
#define ARGPOS_FILE        15
#define ARGS               16

#define SOUNDMODE_NONE      0
#define SOUNDMODE_FX        1
#define SOUNDMODE_MUSIC     2

// 3. EXPORTED VARIABLES -------------------------------------------------

EXPORT int                       fontx          = 8,
                                 fonty          = 8,
                                 xoffset,
                                 yoffset;
EXPORT SBYTE                     NewPri         = 0;
EXPORT WORD                      AboutXPos      = (SCREENXPIXEL / 2) - (ABOUTXPIXEL / 2),
                                 AboutYPos      = (SCREENYPIXEL / 2) - (ABOUTYPIXEL / 2);
EXPORT UWORD                     DisplayDepth   = DEPTH;
EXPORT UWORD                    *AboutData      = NULL,
                                *Background1Data = NULL,
                                *Background2Data = NULL,
                                *BoingData[6],
                                *LogoData       = NULL,
                                *SquaresData[ARRAYSIZE + 1];
EXPORT ULONG                     AppLibSignal   = 0,
                                 DisplayID      = HIRES_KEY | PAL_MONITOR_ID | LACE,
                                 DisplayWidth   = SCREENXPIXEL,
                                 DisplayHeight  = SCREENYPIXEL,
                                 WindowWidth    = SCREENXPIXEL,
                                 WindowHeight   = SCREENYPIXEL;
EXPORT struct Catalog*           CatalogPtr     = NULL;
EXPORT struct Menu*              MenuPtr        = NULL;
EXPORT struct VisualInfo*        VisualInfoPtr  = NULL;
EXPORT struct timerequest*       TimerRqPtr     = NULL;
EXPORT struct Screen*            ScreenPtr      = NULL;
EXPORT struct TextFont          *FontPtr        = NULL,
                                *BoldFontPtr    = NULL;
EXPORT struct Process*           ProcessPtr     = NULL;
EXPORT FLAG                      alt            = FALSE,
                                 customscreen   = TRUE,
                                 ctrl           = FALSE,
                                 createicons    = TRUE,
                                 gotpen[16],
                                 morphos        = FALSE,
                                 pointer        = TRUE,
                                 shift          = FALSE,
                                 titlebar       = TRUE,
                                 urlopen        = FALSE;
EXPORT TEXT                      saystring[256 + 1],
                                 screenname[MAXPUBSCREENNAME] = "";
EXPORT struct Window            *HelpWindowPtr  = NULL,
                                *MainWindowPtr  = NULL;
EXPORT struct Library           *AmigaGuideBase = NULL,
                                *AslBase        = NULL,
                                *DiskfontBase   = NULL,
                                *GadToolsBase   = NULL,
                                *IconBase       = NULL,
                                *LocaleBase     = NULL,
                                *LowLevelBase   = NULL,
                                *MEDPlayerBase  = NULL, // must be EXPORTed!
                                *OpenURLBase    = NULL;
EXPORT struct LocaleInfo         li;
#if defined(__MORPHOS__) && !defined(__VBCC__)
    EXPORT struct Library*       TimerBase      = NULL;
#else
    EXPORT struct Device*        TimerBase      = NULL;
#endif
#if (defined(__VBCC__) && defined(__amigaos4__)) || defined(__SASC) || (!defined(__VBCC__) && defined(__MORPHOS__))
    EXPORT struct Library*          UtilityBase       = NULL;
#else
    EXPORT struct UtilityBase*      UtilityBase       = NULL;
#endif
#ifdef __amigaos4__
    EXPORT struct Library          *GfxBase           = NULL,
                                   *IntuitionBase     = NULL;
#else
    EXPORT struct GfxBase*          GfxBase           = NULL;
    EXPORT struct IntuitionBase*    IntuitionBase     = NULL;
#endif
#ifdef __amigaos4__
    EXPORT struct Library*          ApplicationBase   = NULL;

    EXPORT struct ApplicationIFace* IApplication      = NULL;
    EXPORT struct IntuitionIFace*   IIntuition        = NULL;
    EXPORT struct AmigaGuideIFace*  IAmigaGuide       = NULL;
    EXPORT struct OpenURLIFace*     IOpenURL          = NULL;
    EXPORT struct GadToolsIFace*    IGadTools         = NULL;
    EXPORT struct DiskfontIFace*    IDiskfont         = NULL;
    EXPORT struct AslIFace*         IAsl              = NULL;
    EXPORT struct GraphicsIFace*    IGraphics         = NULL;
    EXPORT struct LocaleIFace*      ILocale           = NULL;
    EXPORT struct LowLevelIFace*    ILowLevel         = NULL;
    EXPORT struct IconIFace*        IIcon             = NULL;
    EXPORT struct MEDPlayerIFace*   IMEDPlayer        = NULL;
    EXPORT struct TimerIFace*       ITimer            = NULL;
    EXPORT struct UtilityIFace*     IUtility          = NULL;
    EXPORT ULONG                    AppID             = 0; // not NULL!
#endif

EXPORT UWORD OCSColours[16] =
{   0x000, // black
    0xBBB, // light grey
    0x586, // dark green
    0x985, // dark yellow
    0x888, // medium grey
    0x66C, // dark blue
    0x88F, // light blue
    0x7B7, // light green
    0xB55, // dark red
    0x630, // brown
    0xF55, // light red
    0xBB6, // light yellow
    0x555, // dark grey
    0xF98, // orange
    0xF8F, // purple
    0xFFF, // white
};

EXPORT struct TextAttr Topaz8 =
{   "topaz.font", // ta_Name (case-sensitive)
    8,            // ta_YSize
    FS_NORMAL,    // ta_Style
    FPF_ROMFONT   // ta_Flags
}, BoldTopaz8 =
{   "topaz.font", // ta_Name (case-sensitive)
    8,            // ta_YSize
    FSF_BOLD,     // ta_Style
    FPF_ROMFONT   // ta_Flags
};

// 4. IMPORTED VARIABLES -------------------------------------------------

#ifndef __amigaos4__
    IMPORT struct ExecBase*      SysBase;
#endif

IMPORT FLAG                      aborted,
                                 anims,
                                 autosave,
                                 clipboarded,
                                 engraved,
                                 levels_modified,
                                 scores_modified,
                                 shuffle,
                                 sticky,
                                 superturbo,
                                 turbo;
IMPORT TEXT                      pathname[MAX_PATH + 1],
                                 date[DATELENGTH + 1],
                                 times[TIMELENGTH + 1],
                                 stattext[7 + 1];
IMPORT UBYTE                     remapit[16];
IMPORT UWORD                     brush,
                                 board[MAXLEVELS + 1][MINFIELDX + 1][MINFIELDY + 1],
                                 field[MAXFIELDX + 1][MAXFIELDY + 1],
                                 missileframes[4][MISSILEFRAMES + 1],
                                 birdframes[BIRDFRAMES + 1],
                                 eelframes[EELFRAMES + 1],
                                 squidframes[SQUIDFRAMES + 1],
                                 turtleframes[TURTLEFRAMES];
IMPORT SBYTE                     a, level, levels, players, sourcelevel,
                                 startx[MAXLEVELS + 1], starty[MAXLEVELS + 1];
IMPORT SWORD                     secondsleft, secondsperlevel,
                                 fieldx, fieldy;
IMPORT ULONG                     delay,
                                 difficulty,
                                 r,
                                 quantity[5][3];
IMPORT int                       fex, fey,
                                 introframe,
                                 pseudotop[PSEUDOGADGETS],
                                 showing;
IMPORT STRPTR                    fruitname[LASTFRUIT - FIRSTFRUIT + 1];
IMPORT struct CreatureInfoStruct creatureinfo[SPECIES + 1];
IMPORT struct HiScoreStruct      hiscore[4][HISCORES + 1];
IMPORT struct ObjectInfoStruct   objectinfo[LASTOBJECT + 1];
IMPORT struct WormStruct         worm[4];
IMPORT struct Image              About,
                                 Background1,
                                 Background2,
                                 Logo,
                                 Squares;

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                      clockdrawn          = FALSE,
                                 eversent[4],
                                 evertimed           = FALSE,
                                 first               = TRUE,
                                 ignore              = FALSE,
                                 quiet               = FALSE,
                                 saveconfig          = FALSE,
                                 screenmode          = FALSE,
                                 uselowlevel         = TRUE;
MODULE UBYTE                     ConfigBuffer[CONFIGLENGTH],
                                 fxable              = UNTRIED,
                                 soundmode           = SOUNDMODE_NONE,
                                 musicable           = UNTRIED,
                                 OldStdPortState[2]  = {0, 0},
                                 song                = 0,
#if defined(__MORPHOS__) || defined(__AROS__)
                                 wantedmode          = SOUNDMODE_FX;
#else
                                 wantedmode          = SOUNDMODE_MUSIC;
#endif
MODULE SBYTE                     AudioClosed         = TRUE,
                                 hiframe             = -1,
                                 OldPri              = 0,
                                 TimerClosed         = TRUE;
MODULE ULONG                     fsize,
                                 millielapsed,
                                 receipter[4]        = {(ULONG) -1, (ULONG) -1, (ULONG) -1, (ULONG) -1};
MODULE UBYTE*                    fbase               = NULL;
MODULE BPTR                      FilePtr             = ZERO;
MODULE APTR                      OldWindowPtr        = NULL;
MODULE TEXT                      d_shortcut          = 'D',
                                 s_shortcut          = 'S',
                                 SoundText[3 + 1][18 + 4 + 1];
MODULE STRPTR                    CycleOptions[4][5 + 1],
                                 DifficultyOptions[4 + 1],
                                 SoundOptions[3 + 1];
MODULE struct Gadget            *CycleGadgetPtr[4]   = {NULL, NULL, NULL, NULL},
                                *DifficultyGadgetPtr = NULL,
                                *GListPtr            = NULL,
                                *LevelEditGadgetPtr  = NULL,
                                *PrevGadgetPtr       = NULL,
                                *ShuffleGadgetPtr    = NULL,
                                *SoundGadgetPtr      = NULL,
                                *StartGadgetPtr      = NULL,
                                *StringGadgetPtr[5]  = {NULL, NULL, NULL, NULL, NULL};
MODULE struct MsgPort           *AudioPortPtr[4]     = {NULL, NULL, NULL, NULL},
                                *TimerPortPtr        = NULL;
MODULE struct timeval           *TimeValPtr          = NULL;
MODULE struct RDArgs*            ArgsPtr             = NULL;
MODULE struct FileRequester*     ASLRqPtr            = NULL;
MODULE struct IOAudio*           AudioRqPtr[4]       = {NULL, NULL, NULL, NULL};
MODULE struct MMD0*              SongPtr[SONGS];
MODULE struct GfxBase*           TheGfxBase;
MODULE struct WBArg*             WBArg               = NULL;
MODULE struct WBStartup*         WBMsg               = NULL;

#if !defined(__AROS__) && !defined(__MORPHOS__) && !defined(__amigaos4__)
MODULE struct CIA*               CIAPtr              = (struct CIA*) 0xBFE001;
#endif

// 6. MODULE ARRAYS/STRUCTURES--------------------------------------------

EXPORT UWORD chip PointerData[6] =
{   0x0000, 0x0000, // reserved

    0x0000, 0x0000, // 1st row 1st plane, 1st row 2nd plane

    0x0000, 0x0000  // reserved
};

MODULE struct NewGadget StringGadget =
{   0, 0,
    179, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, ShuffleGadget =
{   0, 0,
    0, 0,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
}, CycleGadget =
{   0, 0,
    192, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
}, DifficultyGadget =
{   0, 0,
    192, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
}, SoundGadget =
{   0, 0,
    192, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
}, StartGadget =
{   0, 0,
    320, 39,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, LevelEditGadget =
{   0, 0,
    320, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
};

MODULE struct
{   STRPTR filename;
    ULONG  length[2], size, speed, bank;
    UBYTE* base;
} samp[SAMPLES] =
{   {      "PROGDIR:fx/dog.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_DOG */
    {     "PROGDIR:fx/rain.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_RAIN */
    {"PROGDIR:fx/lightning.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_LIGHTNING */
    {  "PROGDIR:fx/missile.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_MISSILE */
    {"PROGDIR:fx/protector.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_PROTECTOR */
    {    "PROGDIR:fx/death.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXDEATH_WORM */
    {  "PROGDIR:fx/enclose.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXDO_ENCLOSE */
    { "PROGDIR:fx/fragment.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_FRAGMENT */
    {     "PROGDIR:fx/ammo.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_AMMO */
    {  "PROGDIR:fx/cyclone.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_CYCLONE */
    {  "PROGDIR:fx/getrain.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_RAIN */
    {   "PROGDIR:fx/grower.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_GROWER */
    {   "PROGDIR:fx/object.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_OBJECT */
    {  "PROGDIR:fx/powerup.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_POWERUP */
    {    "PROGDIR:fx/grave.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGET_GRAVE */
    {   "PROGDIR:fx/amigan.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXHELP */
    {    "PROGDIR:fx/shoot.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXUSE_AMMO */
    {   "PROGDIR:fx/armour.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXUSE_ARMOUR */
    {     "PROGDIR:fx/bomb.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXUSE_BOMB */
    { "PROGDIR:fx/teleport.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXUSE_TELEPORT */
    {     "PROGDIR:fx/bird.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_BIRD */
    {    "PROGDIR:fx/green.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXPAIN */
    {      "PROGDIR:fx/red.8svx", {0, 0}, 0, 0, 0, NULL},
    {     "PROGDIR:fx/blue.8svx", {0, 0}, 0, 0, 0, NULL},
    {   "PROGDIR:fx/yellow.8svx", {0, 0}, 0, 0, 0, NULL},
    { "PROGDIR:fx/applause.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXAPPLAUSE (after each new hiscore) */
    { "PROGDIR:fx/gameover.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXGAMEOVER (if all worms are dead) */
    {    "PROGDIR:fx/click.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXCLICK (rundown, keypresses) */
    {    "PROGDIR:fx/siren.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXSIREN (out of time) */
    {     "PROGDIR:fx/ding.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXDING */
    {     "PROGDIR:fx/bull.8svx", {0, 0}, 0, 0, 0, NULL}, /* FXBORN_BULL */
    {    "PROGDIR:fx/snake.8svx", {0, 0}, 0, 0, 0, NULL}, // FXBORN_SNAKE
    {    "PROGDIR:fx/rhino.8svx", {0, 0}, 0, 0, 0, NULL}, // FXBORN_RHINO
    {"PROGDIR:fx/butterfly.8svx", {0, 0}, 0, 0, 0, NULL}, // FXGET_BUTTERFLY
    { "PROGDIR:fx/elephant.8svx", {0, 0}, 0, 0, 0, NULL}, // FXBORN_ELEPHANT
    {    "PROGDIR:fx/horse.8svx", {0, 0}, 0, 0, 0, NULL}, // FXBORN_HORSE
    {   "PROGDIR:fx/monkey.8svx", {0, 0}, 0, 0, 0, NULL}, // FXBORN_MONKEY
};

MODULE struct NewMenu NewMenu[] =
{   { NM_TITLE, "",           0 , 0,                    0, 0}, //  0 Project
    {  NM_ITEM, "",          "N", 0,                    0, 0}, //
    {  NM_ITEM, "",          "O", 0,                    0, 0}, //
    {  NM_ITEM, "",          "R", 0,                    0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "S", 0,                    0, 0}, //  5
    {  NM_ITEM, "",          "A", 0,                    0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "D", 0,                    0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, // 10
    {  NM_ITEM, "",          "Q", 0,                    0, 0}, //
    { NM_TITLE, "",           0 , 0,                    0, 0}, // 12 Edit
    {  NM_ITEM, "",          "X", NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",          "C", NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",          "V", NM_ITEMDISABLED,      0, 0}, // 15
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "E", NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, // 20
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",           0 , 0,                    0, 0}, //
    { NM_TITLE, "",           0 , 0,                    0, 0}, // 23 View
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, // 25
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "P", CHECKIT | MENUTOGGLE, 0, 0}, //
    {  NM_ITEM, "",          "B", CHECKIT | MENUTOGGLE, 0, 0}, //
    { NM_TITLE, "",           0 , 0,                    0, 0}, // 29 Settings
    {  NM_ITEM, "",          "T", CHECKIT | MENUTOGGLE, 0, 0}, // 30 animations
    {  NM_ITEM, "",           0 , CHECKIT | MENUTOGGLE, 0, 0}, //    autosave
    {  NM_ITEM, "",          "I", CHECKIT | MENUTOGGLE, 0, 0}, //    create icons
    {  NM_ITEM, "",           0 , CHECKIT | MENUTOGGLE, 0, 0}, //    engrave squares
    { NM_TITLE, "",           0 , 0,                    0, 0}, // 34 Help
    {  NM_ITEM, "",          "1", 0,                    0, 0}, // 35
    {  NM_ITEM, "",          "2", 0,                    0, 0}, //
    {  NM_ITEM, "",          "3", 0,                    0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "M", NM_ITEMDISABLED,      0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 40
    {  NM_ITEM, "",           0 , 0,                    0, 0}, //
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //
    {  NM_ITEM, "",          "?", 0,                    0, 0}, //
    {   NM_END, NULL,         0 , 0,                    0, 0}  // 44
};

MODULE const STRPTR sfxerror[] =
{   "No errors.",
    "Can't open file!",
    "Can't read file!",
    "Not an IFF 8SVX; too short!",
    "Not an IFF FORM!",
    "No memory for read!",
    "Read error!",
    "Malformed IFF; too short!",
    "Not an IFF 8SVX!",
    "No chip memory!"
};

MODULE struct
{   UBYTE scancode;
    SBYTE player, deltax, deltay, special;
    BOOL  down;
} key[NUMKEYS + 1] =
{   {SCAN_Q,               0, -1, -1, MOVE,     FALSE},
    {SCAN_W,               0,  0, -1, MOVE,     FALSE},
    {SCAN_E,               0,  1, -1, MOVE,     FALSE},
    {SCAN_A,               0, -1,  0, MOVE,     FALSE},
    {SCAN_S,               0,  0,  1, MOVE,     FALSE},
    {SCAN_D,               0,  1,  0, MOVE,     FALSE},
    {SCAN_Z,               0, -1,  1, MOVE,     FALSE},
    {SCAN_X,               0,  1,  1, MOVE,     FALSE},
    {SCAN_C,               0,  1,  1, MOVE,     FALSE},
    {SCAN_N7,              1, -1, -1, MOVE,     FALSE},
    {SCAN_N8,              1,  0, -1, MOVE,     FALSE},
    {SCAN_N9,              1,  1, -1, MOVE,     FALSE},
    {SCAN_N4,              1, -1,  0, MOVE,     FALSE},
    {SCAN_N5,              1,  0,  1, MOVE,     FALSE},
    {SCAN_N6,              1,  1,  0, MOVE,     FALSE},
    {SCAN_N1,              1, -1,  1, MOVE,     FALSE},
    {SCAN_N2,              1,  0,  1, MOVE,     FALSE},
    {SCAN_N3,              1,  1,  1, MOVE,     FALSE},
    {SCAN_UP,              1,  0, -1, ONEHUMAN, FALSE},
    {SCAN_DOWN,            1,  0,  1, ONEHUMAN, FALSE},
    {SCAN_RIGHT,           1,  1,  0, ONEHUMAN, FALSE},
    {SCAN_LEFT,            1, -1,  0, ONEHUMAN, FALSE},
    {SCAN_SPACEBAR,        0,  0,  0, AMMO,     FALSE},
    {SCAN_V,               0,  0,  0, AMMO,     FALSE},
    {SCAN_N0,              1,  0,  0, AMMO,     FALSE},
    {SCAN_ENTER,           1,  0,  0, AMMO,     FALSE},
    {SCAN_HELP,            0,  0,  0, TRAINER,  FALSE},
    {SCAN_NUMERICSLASH,    0,  0,  0, TRAINER,  FALSE},
    {SCAN_NUMERICASTERISK, 0,  0,  0, TRAINER,  FALSE},
    {SCAN_NUMERICPLUS,     0,  0,  0, TRAINER,  FALSE},
    {SCAN_NUMERICMINUS,    0,  0,  0, TRAINER,  FALSE},
}; /* Never leave unused keys in this structure. */

struct Chunk
{   LONG          ckID;
    LONG          ckSize;
    LONG          ckType;
    void*         ckData;
    struct Chunk* ckNext;
};

MODULE UWORD chip CheckmarkData[32] =
{ 0xFFAC,
  0xFFAC,
  0xFFAC,
  0xB08C,
  0xC01C,
  0xE01C,
  0xED6C,
  0xDBB4,
  /* Plane 1 */
  0xFFAC,
  0xFFAC,
  0xFFAC,
  0xB0DC,
  0xC01C,
  0xE01C,
  0xED6C,
  0xDBB4,
  /* Plane 2 */
  0xFFAC,
  0xFFAC,
  0xFFAC,
  0xB08C,
  0xC01C,
  0xE01C,
  0xED6C,
  0xDBB4,
  /* Plane 3 */
  0xFFAC,
  0xFFAC,
  0xFFAC,
  0xB0DC,
  0xC01C,
  0xE01C,
  0xED6C,
  0xDBB4
};

MODULE struct ColorSpec Colours[] =
{   { 0, 0x0, 0x0, 0x0}, // black
    { 1, 0xB, 0xB, 0xB}, // light grey
    { 2, 0x5, 0x8, 0x6}, // dark green
    { 3, 0x9, 0x8, 0x5}, // dark yellow
    { 4, 0x8, 0x8, 0x8}, // medium grey
    { 5, 0x6, 0x6, 0xC}, // dark blue
    { 6, 0x8, 0x8, 0xF}, // light blue
    { 7, 0x7, 0xB, 0x7}, // light green
    { 8, 0xB, 0x5, 0x5}, // dark red
    { 9, 0x6, 0x3, 0x0}, // brown
    {10, 0xF, 0x5, 0x5}, // light red
    {11, 0xB, 0xB, 0x6}, // light yellow
    {12, 0x5, 0x5, 0x5}, // dark grey
    {13, 0xF, 0x9, 0x8}, // orange
    {14, 0xF, 0x8, 0xF}, // purple
    {15, 0xF, 0xF, 0xF}, // white
    {16, 0x3, 0x3, 0x3},
    {17, 0xA, 0xA, 0xA}, // 1st pointer colour
    {18, 0x5, 0x5, 0x5}, // 2nd pointer colour
    {19, 0x6, 0x6, 0x6}, // 3rd pointer colour
    {20, 0x7, 0x7, 0x7},
    {21, 0x8, 0x8, 0x8},
    {22, 0x9, 0x9, 0x9},
    {23, 0x4, 0x4, 0x4},
    {-1,   0,   0,   0}
};

MODULE struct Image Checkmark =
{    0, 0,
    14, 8,
     4,
    CheckmarkData,
    0x0f,0x0,
    NULL
};

MODULE struct EasyStruct EasyStruct =
{   sizeof(struct EasyStruct),
    0,
    NULL,
    NULL,
    NULL
};

// 7. MODULE FUNCTIONS ---------------------------------------------------

MODULE FLAG beginfx(void);
MODULE FLAG firebutton(void);
MODULE void freefx(void);
MODULE void loadthefx(void);
MODULE void loadthemusic(void);
MODULE UBYTE ReadJoystick(UWORD joynum);
MODULE void titlescreen(void);
MODULE void playgame(void);
MODULE void matchtool(SBYTE player, char* s);
MODULE void parsewb(void);
MODULE void ww_shadowtext(int x, int y, STRPTR thetext, int colour);
MODULE FLAG playersactive(void);
MODULE void shadowit(struct Window* win, int x, int y, STRPTR string);
MODULE FLAG handlemenus(UWORD code);
#ifdef __SASC__
    int  CXBRK(void)    { return 0; } /* Disable SAS/C Ctrl-C handling */
    void chkabort(void) { ;         } /* really */
#endif

// 8. CODE ---------------------------------------------------------------

MODULE FLAG beginfx(void)
{   TRANSIENT int   i;
    PERSIST   UBYTE chan[] = {15};

    for (i = 0; i <= 3; i++)
    {   eversent[i] = FALSE;
        if (!(AudioPortPtr[i] = (struct MsgPort*) CreateMsgPort()))
        {   freefx();
            draw(MUSICICONX, ICONY, BLACKENED);
            soundmode = SOUNDMODE_NONE;
            say(LLL( MSG_NOPORT,   "No port for sound effects!"  ), RED);
            anykey(TRUE, TRUE);
            return FALSE;
        } elif (!(AudioRqPtr[i] = (struct IOAudio*) CreateIORequest(AudioPortPtr[i], sizeof(struct IOAudio))))
        {   freefx();
            draw(MUSICICONX, ICONY, BLACKENED);
            soundmode = SOUNDMODE_NONE;
            say(LLL( MSG_NOMEMORY, "No memory for sound effects!"), RED);
            anykey(TRUE, TRUE);
            return FALSE;
    }   }
    AudioRqPtr[0]->ioa_Request.io_Message.mn_ReplyPort      = AudioPortPtr[0];
    AudioRqPtr[0]->ioa_Request.io_Message.mn_Node.ln_Pri    = 127;
    AudioRqPtr[0]->ioa_AllocKey                             = 0;
    AudioRqPtr[0]->ioa_Data                                 = chan;
    AudioRqPtr[0]->ioa_Length                               = 1;
    if ((AudioClosed = OpenDevice(AUDIONAME, 0L, (struct IORequest*) AudioRqPtr[0], 0L)))
    {   freefx();
        draw(MUSICICONX, ICONY, BLACKENED);
        soundmode = SOUNDMODE_NONE;
        say(LLL( MSG_NOCHANNELS, "Can't allocate all channels!"), RED);
        anykey(TRUE, TRUE);
        return FALSE;
    } else
    {   for (i = 1; i <= 3; i++)
        {   CopyMem(AudioRqPtr[0], AudioRqPtr[i], sizeof(struct IOAudio));
        }
        return TRUE;
}   }

MODULE FLAG firebutton(void)
{   PERSIST   FLAG  fresh = TRUE;
    TRANSIENT UBYTE PortState;

    PortState = ReadJoystick(1);

    if (PortState & JOYFIRE1) // don't check JOYFIRE2
    {   if (fresh)
        {   fresh = FALSE;
            OldStdPortState[1] = PortState;
            return TRUE;
    }   }
    else
    {   fresh = TRUE;
    }
    OldStdPortState[1] = PortState;
    return FALSE;
}

MODULE void freefx(void)
{   int i;

    stopfx();
    if (!AudioClosed)
    {   CloseDevice((struct IORequest*) AudioRqPtr[0]);
        AudioClosed = TRUE;
    }
    for (i = 0; i <= 3; i++)
    {   if (AudioRqPtr[i])
        {   DeleteIORequest((struct IORequest*) AudioRqPtr[i]);
            AudioRqPtr[i] = NULL;
        }
        if (AudioPortPtr[i])
        {   DeleteMsgPort(AudioPortPtr[i]);
            AudioPortPtr[i] = NULL;
    }   }
    if (fbase)
    {   FreeMem(fbase, fsize);
        fbase = NULL;
    }
    if (FilePtr)
    {   DISCARD Close(FilePtr);
        FilePtr = ZERO;
}   }

MODULE void loadthefx(void)
{   UBYTE*        p8data;
    TEXT          saystring[SAYLIMIT + 1];
    SBYTE         code          = 0,
                  i,
                  iobuffer[8]; /* buffer for 8SVX.VHDR  */
    SBYTE*        psample[2];  /* sample pointers */
    struct Chunk* p8Chunk;     /* pointers for 8SVX parsing */
    Voice8Header* pVoice8Header = NULL; // only set to NULL to avoid spurious warnings
    ULONG         rd8count;

    say(LLL( MSG_LOADINGFX, "Loading sound effects..."), WHITE);
    fxable = SUCCEEDED;

    for (i = 0; i < SAMPLES; i++)
    {   samp[i].base = NULL;
    }

    for (i = 0; i < SAMPLES; i++)
    {   if (!(FilePtr = Open(samp[i].filename, MODE_OLDFILE)))
        {   code = 1;                               /* can't open file */
        } else
        {   rd8count = (ULONG) Read(FilePtr, iobuffer, 8);
            if (rd8count == -1)
            {   code = 2;                           /* can't read file */
            } elif (rd8count < 8)
            {   code = 3;                           /* not an IFF 8SVX; too short */
            } else
            {   p8Chunk = (struct Chunk*) iobuffer;
                p8Chunk->ckID = BE2LONG(p8Chunk->ckID);
                p8Chunk->ckSize = BE2LONG(p8Chunk->ckSize);
                if (p8Chunk->ckID != ID_FORM)
                    code = 4;                       /* not an IFF FORM */
                elif (!(fbase = (UBYTE*) AllocMem(fsize = (ULONG) p8Chunk->ckSize, MEMF_CLEAR)))
                    code = 5;                       /* no memory for read */
                else
                {   p8data = fbase;
                    rd8count = (ULONG) Read(FilePtr, p8data, p8Chunk->ckSize);
                    if (rd8count == -1)
                        code = 6;                   /* read error */
                    elif (rd8count < (ULONG) p8Chunk->ckSize)
                        code = 7;                   /* malformed IFF; too short */
                    elif (MAKE_ID(*p8data, *(p8data + 1), *(p8data + 2), *(p8data + 3)) != ID_8SVX)
                        code = 8;                   /* not an IFF 8SVX */
                    else
                    {   p8data = p8data + 4;
                        while (p8data < fbase + fsize)
                        {   p8Chunk = (struct Chunk*) p8data;
                            p8Chunk->ckID = BE2LONG(p8Chunk->ckID);
                            p8Chunk->ckSize = BE2LONG(p8Chunk->ckSize);
                            switch (p8Chunk->ckID)
                            {
                            case ID_VHDR:
                                pVoice8Header     = (Voice8Header*) (p8data + 8L);
                                pVoice8Header->oneShotHiSamples = BE2LONG(pVoice8Header->oneShotHiSamples);
                                pVoice8Header->repeatHiSamples = BE2LONG(pVoice8Header->repeatHiSamples);
                                pVoice8Header->samplesPerHiCycle = BE2LONG(pVoice8Header->samplesPerHiCycle);
                                pVoice8Header->samplesPerSec = BE2WORD(pVoice8Header->samplesPerSec);
                            acase ID_BODY:
                                psample[0]        = (SBYTE*) (p8data + 8L);
                                psample[1]        = psample[0] + pVoice8Header->oneShotHiSamples;
                                samp[i].length[0] = (ULONG) pVoice8Header->oneShotHiSamples;
                                samp[i].length[1] = (ULONG) pVoice8Header->repeatHiSamples;

                                /* To grab the volume level from the IFF
                                8SVX file itself, add this line here:

                                samp[i].volume    = (SBYTE) (pVoice8Header->volume / 156); */
                            }
                            p8data += 8 + p8Chunk->ckSize;
                            if ((p8Chunk->ckSize & 1) == 1)
                            {   p8data++;
                        }   }
                        if (samp[i].length[0] == 0)
                        {   samp[i].bank = 1;
                        } else
                        {   samp[i].bank = 0;
                        }
                        if (samp[i].length[samp[i].bank] <= 102400)
                        {   samp[i].size = samp[i].length[samp[i].bank];
                        } else
                        {   samp[i].size = 102400;
                        }
                        samp[i].base = (UBYTE*) AllocMem(samp[i].size, MEMF_CHIP | MEMF_CLEAR);
                        if (!samp[i].base)
                            code = 9; /* no chip memory */
                        else
                        {   CopyMem(psample[samp[i].bank], samp[i].base, samp[i].size);
                            psample[samp[i].bank] += samp[i].size;
                            if (TheGfxBase->DisplayFlags & REALLY_PAL) // PAL clock
                            {   samp[i].speed = PALCLOCK / pVoice8Header->samplesPerSec;
                            } else // NTSC clock
                            {   samp[i].speed = NTSCCLOCK / pVoice8Header->samplesPerSec;
                            }

/* "The maximum frequency achievable depends on the screen rate because
the Paula audio DMA period depends on the horizontal refresh rate, but the
actual clock rate of Paula by which the audio DA converters are driven
depends really only on the clock rate.

It's fixed for either PAL or NTSC machines, NOT for PAL or NTSC screen
modes. Hence just the two values that are given in the RKRMs are
completely sufficient. Note that running an NTSC screen on a PAL machine
does not change the system clock and hence neither the audio frequency.
It changes horizontal timing and vertical timing, and hence the minimal
audio period." - Thomas `Thor' Richter. */

                            if (fbase)
                            {   FreeMem(fbase, fsize);
                                fbase = NULL;
                            }
                            if (FilePtr)
                            {   DISCARD Close(FilePtr);
                                FilePtr = ZERO;
        }   }   }   }   }   }
        if (code)
        {   freefx();
            fxable = FAILED;
            strcpy(saystring, samp[i].filename);
            strcat(saystring, ": ");
            strcat(saystring, sfxerror[code]);
            say(saystring, RED);
            anykey(TRUE, TRUE);
            break;
}   }   }

MODULE void loadthemusic(void)
{
#ifdef __MORPHOS__
    ;
#else
#ifdef __amigaos4__
    if (!Exists("L:Mem-Handler"))
    {   ScreenToFront(NULL); // so the user sees the "MEM-Handler not installed or not enabled"
    }
#endif
    if (!(MEDPlayerBase = (struct Library*) OpenLibrary("medplayer.library", 0L)))
    {
#ifdef __amigaos4__
        ScreenToFront(ScreenPtr); // now that they have seen the "MEM-Handler not installed or not enabled"
#endif
        say("Can't open MEDPlayer.library!", RED);
        anykey(TRUE, TRUE);
    } else
    {   ;
#ifdef __amigaos4__
        if (!(IMEDPlayer = (struct MEDPlayerIFace*) GetInterface((struct Library*) MEDPlayerBase,  "main", 1, NULL)))
        {   rq("Can't get MEDPlayer.library interface!");
        }
#endif
#if defined(__SASC) || defined(__amigaos4__)
        say(LLL( MSG_LOADINGMUSIC, "Loading music..."), WHITE);
        if
        (   (SongPtr[0] = (struct MMD0*) LoadModule("PROGDIR:music/title.med"   ))
         && (SongPtr[1] = (struct MMD0*) LoadModule("PROGDIR:music/editor.med"  ))
         && (SongPtr[2] = (struct MMD0*) LoadModule("PROGDIR:music/bonus.med"   ))
         && (SongPtr[3] = (struct MMD0*) LoadModule("PROGDIR:music/gameover.med"))
         && (SongPtr[4] = (struct MMD0*) LoadModule("PROGDIR:music/game1.med"   ))
         && (SongPtr[5] = (struct MMD0*) LoadModule("PROGDIR:music/game2.med"   ))
         && (SongPtr[6] = (struct MMD0*) LoadModule("PROGDIR:music/game3.med"   ))
         && (SongPtr[7] = (struct MMD0*) LoadModule("PROGDIR:music/game4.med"   ))
         && (SongPtr[8] = (struct MMD0*) LoadModule("PROGDIR:music/game5.med"   ))
        )
        {   musicable = SUCCEEDED;
        } else
        {   say("Can't load music!", RED);
            anykey(TRUE, TRUE);
        }
#endif
    }
#endif
}

MODULE void matchtool(SBYTE player, char* s)
{   if (player <= 1 && (MatchToolValue(s, "KYBD") || MatchToolValue(s, "KEYBOARD")))
    {   worm[player].control = KEYBOARD;
    } elif (MatchToolValue(s, "JOY") || MatchToolValue(s, "STICK") || MatchToolValue(s, "JOYSTICK"))
    {   worm[player].control = JOYSTICK;
    } elif (MatchToolValue(s, "GAMEPAD") || MatchToolValue(s, "PAD"))
    {   worm[player].control = GAMEPAD;
    } elif (MatchToolValue(s, "AMIGA"))
    {   worm[player].control = THEAMIGA;
    } elif (MatchToolValue(s, "NONE"))
    {   worm[player].control = NONE;
}   }

MODULE void parsewb(void)
{   struct DiskObject* DiskObject;
    STRPTR*            ToolArray;
    STRPTR             s;

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        if ((s = (STRPTR) FindToolType(ToolArray, "NOLOWLEVEL")))
        {   uselowlevel = FALSE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "NOPRELOAD" )))
        {   fxable = musicable = DEFER;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "NOANIMS"   )))
        {   anims = FALSE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "NOICONS"   )))
        {   createicons = FALSE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "SCREENMODE")))
        {   screenmode = TRUE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "SHUFFLE"   )))
        {   shuffle = TRUE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "QUIET"     )))
        {   quiet = TRUE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "GREEN"     )))
        {   matchtool(0, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "RED"       )))
        {   matchtool(1, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "BLUE"      )))
        {   matchtool(2, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "YELLOW"    )))
        {   matchtool(3, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "PUBSCREEN" )))
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayWidth  = 640;
                DisplayHeight = 512;
            }
            strcpy(screenname, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "WINWIDTH"  )))
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayHeight = 512;
            }
            DisplayWidth = atoi(s);
            if   (DisplayWidth  < 640     ) DisplayWidth  = 640;
            elif (DisplayWidth  > MAXXSIZE) DisplayWidth  = MAXXSIZE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "WINHEIGHT" )))
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayWidth  = 640;
            }
            DisplayHeight = atoi(s);
            if   (DisplayHeight < 512     ) DisplayHeight = 512;
            elif (DisplayHeight > MAXYSIZE) DisplayHeight = MAXYSIZE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "FILE"      )))
        {   strcpy(pathname, WBArg->wa_Name);
        }

        FreeDiskObject(DiskObject);
}   }

MODULE UBYTE ReadJoystick(UWORD joynum)
{
#if defined(__AROS__) || defined(__MORPHOS__) || defined(__amigaos4__)
    return 0;
#else
    extern struct Custom far custom;
           UBYTE             ret = 0;
           UWORD             joy;

    if (joynum == 0)
    {   joy = custom.joy0dat;
    } else
    {   joy = custom.joy1dat;
    }

    ret += (joy >> 1 ^ joy) & 0x0100 ? JOYUP : 0;
    ret += (joy >> 1 ^ joy) & 0x0001 ? JOYDOWN : 0;
    ret += joy & 0x0200 ? JOYLEFT : 0;
    ret += joy & 0x0002 ? JOYRIGHT : 0;

    if (joynum == 0)
    {   ret += !(CIAPtr->ciapra & 0x0040) ? JOYFIRE1 : 0; /* read firebuttons */
        ret += !(POTGOR & 0x0400) ? JOYFIRE2 : 0;         /* on joyport 0 */
    } else
    {   ret += !(CIAPtr->ciapra & 0x0080) ? JOYFIRE1 : 0; /* read firebuttons */
        ret += !(POTGOR & 0x0400) ? JOYFIRE2 : 0;         /* on joyport 1 */
    }

    return ret;
#endif
}

// 8. EXPORTED FUNCTIONS -------------------------------------------------

EXPORT int main(int argc, char** argv)
{
BPTR                        FileHandle,
                            OldDir;
SBYTE                       player,
                            which;
TEXT                        saystring[SAYLIMIT + 1];
SLONG                       args[ARGS + 1],
                            i,
                            number;
ULONG                       memflags = MEMF_CLEAR;
FLAG                        ok;
int                         FieldWidth,
                            FieldHeight,
                            length;
STRPTR                      stringptr;
UWORD Pens[46] =
{ BLACK,      // DETAILPEN             text in title bar
  WHITE,      // BLOCKPEN              fill title bar
  BLACK,      // TEXTPEN               regular text on BACKGROUNDPEN
  LIGHTGREY,  // SHINEPEN              bright edge
  DARKGREY,   // SHADOWPEN             dark edge
  BLUE,       // FILLPEN               filling active window borders
              //                       and selected gadgets
  BLACK,      // FILLTEXTPEN           text rendered over FILLPEN
  LIGHTGREY,  // BACKGROUNDPEN         background colour
  RED,        // HIGHLIGHTTEXTPEN      highlighted text on BACKGROUNDPEN
  BLACK,      // BARDETAILPEN          text/detail in screen-bar/menus
  WHITE,      // BARBLOCKPEN           screen-bar/menus fill
  BLACK,      // BARTRIMPEN            trim under screen-bar
              // and used against BLOCKPEN in ASL save requesters
// for OS4.x only...
  WHITE,      // BARCONTOURPEN         contour above screen-bar
  MEDIUMGREY, // FOREGROUNDPEN         inside of unselected gadgets
  LIGHTGREY,  // FORESHINEPEN          bright edges of unselected gadgets
  DARKGREY,   // FORESHADOWPEN         dark edges of unselected gadgets
  LIGHTGREY,  // FILLSHINEPEN          bright edges for FILLPEN
  DARKGREY,   // FILLSHADOWPEN         dark edges for FILLPEN
  MEDIUMGREY, // INACTIVEFILLPEN       inactive window borders fill
  LIGHTGREY,  // INACTIVEFILLTEXTPEN   text over INACTIVEFILLPEN
  DARKGREY,   // INACTIVEFILLSHINEPEN  bright edges for INACTIVEFILLPEN
  MEDIUMGREY, // INACTIVEFILLSHADOWPEN dark edges for INACTIVEFILLPEN
  MEDIUMGREY, // DISABLEDPEN           background of disabled elements
  LIGHTGREY,  // DISABLEDTEXTPEN       text of disabled string gadgets
  LIGHTGREY,  // DISABLEDSHINEPEN      bright edges of disabled elements
  DARKGREY,   // DISABLEDSHADOWPEN     dark edges of disabled elements
  MEDIUMGREY, // MENUBACKGROUNDPEN     background of menus
  BLACK,      // MENUTEXTPEN           normal text in menus
  LIGHTGREY,  // MENUSHINEPEN          bright edges of menus
  DARKGREY,   // MENUSHADOWPEN         dark edges of menus
  BLUE,       // SELECTPEN             background of selected items
  WHITE,      // SELECTTEXTPEN         text of selected items
  LIGHTGREY,  // SELECTSHINEPEN        bright edges of selected items
  DARKGREY,   // SELECTSHADOWPEN       dark edges of selected items
  WHITE,      // GLYPHPEN              system gadget glyphs, outlines
  BLUE,       // GLYPHFILLPEN          system gadget glyphs, colored areas
  MEDIUMGREY, // INACTIVEGLYPHPEN      system gadget glyphs, inact. windows
  0,          // RESERVEDPEN           reserved - don't use
  BLACK,      // GADGETPEN             gadget symbols (arrows, cycle, etc.)
  WHITE,      // TITLEPEN              title of gadget groups
  LIGHTGREY,  // HALFSHINEPEN          half-bright edge on 3D objects
  DARKGREY,   // HALFSHADOWPEN         half-dark edge on 3D objects
  MEDIUMGREY, // FLATBORDERPEN         flat (non-3D) borders and frames
  BLUE,       // FILLFLATPEN           flat outlines of active windows
  MEDIUMGREY, // INACTIVEFILLFLATPEN   flat outlines of inactive windows
  (UWORD) ~0
};

    // Start of program.

#ifdef TRACKENTRY
    printf("1...\n"); Delay(TRACKDELAY);
#endif

    // version embedding into executable
    if (0) /* that is, never */
    {   say(VERSION, ANYTHING);
    }

    for (i = 0; i < SAMPLES; i++)
    {   samp[i].base = NULL;
    }
    for (i = 0; i < SONGS; i++)
    {   SongPtr[i] = NULL;
    }
    for (i = 0; i <= ARGS; i++)
    {   args[i] = 0;
    }
    for (i = 0; i < 16; i++)
    {   gotpen[i] = FALSE;
    }
    for (i = 0; i < 6; i++)
    {   BoingData[i] = NULL;
    }
    for (i = 0; i <= ARRAYSIZE; i++)
    {   SquaresData[i] = NULL;
    }

#ifdef TRACKENTRY
    printf("2...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (!(IntuitionBase = (struct Library*) OpenLibrary("intuition.library", OS_204)))
#else
    if (!(IntuitionBase = (struct IntuitionBase*) OpenLibrary("intuition.library", OS_204)))
#endif
    {   DISCARD Write(Output(), OLDKICKSTART, (LONG) strlen(OLDKICKSTART));
        cleanexit(EXIT_FAILURE);
    }

#ifdef TRACKENTRY
    printf("3...\n"); Delay(TRACKDELAY);
#endif
    enginesetup();
#ifdef TRACKENTRY
    printf("4...\n"); Delay(TRACKDELAY);
#endif
    ProcessPtr = (struct Process*) FindTask(NULL);

    if
    (
#ifdef __amigaos4__
        SysBase->lib_Version         < OS_20 // should never happen
#else
        SysBase->LibNode.lib_Version < OS_20
#endif
    )
    {   rq("Need exec.library V36+!");
    }
#ifdef __amigaos4__
    if (!(GfxBase = (struct Library*) OpenLibrary("graphics.library", OS_30)))
#else
    if (!(GfxBase = (struct GfxBase*) OpenLibrary("graphics.library", OS_30)))
#endif
    {   rq("Need graphics.library V39+!");
    }
    TheGfxBase = (struct GfxBase*) GfxBase; // needed for OS4
    if (!(GadToolsBase = (struct Library*) OpenLibrary("gadtools.library", OS_204)))
    {   rq("Can't open GadTools.library V37+!");
    }
#ifdef TRACKENTRY
    printf("5...\n"); Delay(TRACKDELAY);
#endif
    if (!(LocaleBase = (struct Library*) OpenLibrary("locale.library", OS_ANY)))
    {   rq("Can't open locale.library!");
    }
#ifdef TRACKENTRY
    printf("6...\n"); Delay(TRACKDELAY);
#endif
    if (!(AslBase = (struct Library*) OpenLibrary("asl.library", OS_21)))
    {   rq("Can't open ASL.library!");
    }
#if defined(__amigaos4__) && !defined(__VBCC__)
    if (!(UtilityBase = (struct UtilityBase*) OpenLibrary("utility.library", OS_ANY)))
#else
    if (!(UtilityBase = (struct Library*    ) OpenLibrary("utility.library", OS_ANY)))
#endif
    {   rq("Can't open utility.library!");
    }
    if (!(IconBase = (struct Library*) OpenLibrary("icon.library", OS_ANY)))
    {   rq("Can't open icon.library!");
    }
    if (!(AmigaGuideBase = (struct Library*) OpenLibrary("amigaguide.library", OS_ANY)))
    {   rq("Can't open amigaguide.library!");
    }

#ifdef TRACKENTRY
    printf("7...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (!(IIntuition  = (struct IntuitionIFace* ) GetInterface((struct Library*) IntuitionBase,  "main", 1, NULL)))
    {   rq("Can't get intuition.library interface!");
    }
    if (!(IGraphics   = (struct GraphicsIFace*  ) GetInterface((struct Library*) GfxBase,        "main", 1, NULL)))
    {   rq("Can't get graphics.library interface!");
    }
    if (!(IAsl        = (struct AslIFace*       ) GetInterface((struct Library*) AslBase,        "main", 1, NULL)))
    {   rq("Can't get asl.library interface!");
    }
    if (!(IAmigaGuide = (struct AmigaGuideIFace*) GetInterface((struct Library*) AmigaGuideBase, "main", 1, NULL)))
    {   rq("Can't get amigaguide.library interface!");
    }
    if (!(IGadTools   = (struct GadToolsIFace*  ) GetInterface((struct Library*) GadToolsBase,   "main", 1, NULL)))
    {   rq("Can't get gadtools.library interface!");
    }
    if (!(IIcon       = (struct IconIFace*      ) GetInterface((struct Library*) IconBase,       "main", 1, NULL)))
    {   rq("Can't get intuition.library interface!");
    }
    if (!(ILocale     = (struct LocaleIFace*    ) GetInterface((struct Library*) LocaleBase,     "main", 1, NULL)))
    {   rq("Can't get locale.library interface!");
    }
    if (!(IUtility    = (struct UtilityIFace*   ) GetInterface((struct Library*) UtilityBase,    "main", 1, NULL)))
    {   rq("Can't get utility.library interface!");
    }
#endif

#ifdef TRACKENTRY
    printf("8...\n"); Delay(TRACKDELAY);
#endif

#ifdef __AROS__
    musicable = FAILED;
#endif
    if (FindResident("MorphOS"))
    {   morphos = TRUE;
        musicable = FAILED;
    }
    if
    (   !morphos
     && (    execver >  53
         || (execver == 53 && execrev >= 12)
    )   ) // if (OS4.1.1) or later
    {   urlopen = TRUE;
    } else
    {   OpenURLBase = (struct Library*) OpenLibrary("openurl.library", OS_ANY);
#ifdef __amigaos4__
        if (!(IOpenURL    = (struct OpenURLIFace*   ) GetInterface((struct Library*) OpenURLBase,    "main", 1, NULL)))
        {   rq("Can't get openurl.library interface!");
        }
#endif
    }

#ifdef TRACKENTRY
    printf("9...\n"); Delay(TRACKDELAY);
#endif

    // assert(LocaleBase);
    li.li_LocaleBase = LocaleBase;
    li.li_Catalog    =
    CatalogPtr       = OpenCatalog(NULL, "WormWars.catalog", TAG_DONE);

#ifdef TRACKENTRY
    printf("10...\n"); Delay(TRACKDELAY);
#endif

    enginesetup2();

#ifdef TRACKENTRY
    printf("11...\n"); Delay(TRACKDELAY);
#endif

    NewMenu[INDEX_PROJECT].nm_Label         = LLL( MSG_MENU_PROJECT           , "Project"                     );
    NewMenu[INDEX_NEW].nm_Label             = LLL( MSG_MENU_NEW               , "New"                         );
    NewMenu[INDEX_NEW].nm_CommKey           = LLL( MSG_KEY_NEW                , "N"                           );
    NewMenu[INDEX_OPEN].nm_Label            = LLL( MSG_MENU_OPEN              , "Open..."                     );
    NewMenu[INDEX_OPEN].nm_CommKey          = LLL( MSG_KEY_OPEN               , "O"                           );
    NewMenu[INDEX_REVERT].nm_Label          = LLL( MSG_MENU_REVERT            , "Revert"                      );
    NewMenu[INDEX_REVERT].nm_CommKey        = LLL( MSG_KEY_REVERT             , "R"                           );
    NewMenu[INDEX_SAVE].nm_Label            = LLL( MSG_MENU_SAVE1             , "Save"                        );
    NewMenu[INDEX_SAVE].nm_CommKey          = LLL( MSG_KEY_SAVE               , "S"                           );
    NewMenu[INDEX_SAVEAS].nm_Label          = LLL( MSG_MENU_SAVEAS            , "Save as..."                  );
    NewMenu[INDEX_SAVEAS].nm_CommKey        = LLL( MSG_KEY_SAVEAS             , "A"                           );
    NewMenu[INDEX_PROJECTDELETE].nm_Label   = LLL( MSG_MENU_PROJECTDELETE     , "Delete..."                   );
    NewMenu[INDEX_PROJECTDELETE].nm_CommKey = LLL( MSG_SHORTCUT_PROJECTDELETE , "D"                           );
    NewMenu[INDEX_QUITTITLE].nm_Label       = LLL( MSG_MENU_QUITTITLE         , "Quit to title screen (Space)");
    NewMenu[INDEX_QUITDOS].nm_Label         = LLL( MSG_MENU_QUITWB            , "Quit Worm Wars"              );
    NewMenu[INDEX_QUITDOS].nm_CommKey       = LLL( MSG_KEY_QUIT               , "Q"                           );

    NewMenu[INDEX_EDIT].nm_Label            = LLL( MSG_MENU_EDIT              , "Edit"                        );
    NewMenu[INDEX_CUT].nm_Label             = LLL( MSG_MENU_CUT               , "Cut"                         );
    NewMenu[INDEX_CUT].nm_CommKey           = LLL( MSG_KEY_CUT                , "X"                           );
    NewMenu[INDEX_COPY].nm_Label            = LLL( MSG_MENU_COPY              , "Copy"                        );
    NewMenu[INDEX_COPY].nm_CommKey          = LLL( MSG_KEY_COPY               , "C"                           );
    NewMenu[INDEX_PASTE].nm_Label           = LLL( MSG_MENU_PASTE             , "Paste"                       );
    NewMenu[INDEX_PASTE].nm_CommKey         = LLL( MSG_KEY_PASTE              , "V"                           );
    NewMenu[INDEX_ERASE].nm_Label           = LLL( MSG_MENU_ERASE             , "Erase"                       );
    NewMenu[INDEX_ERASE].nm_CommKey         = LLL( MSG_KEY_ERASE              , "E"                           );
    NewMenu[INDEX_EDITDELETE].nm_Label      = LLL( MSG_MENU_EDITDELETE        , "Delete"                      );
    NewMenu[INDEX_INSERT].nm_Label          = LLL( MSG_MENU_INSERT            , "Insert"                      );
    NewMenu[INDEX_APPEND].nm_Label          = LLL( MSG_MENU_APPEND            , "Append"                      );
    NewMenu[INDEX_CLEARHS].nm_Label         = LLL( MSG_MENU_CLEARHS           , "Clear high scores"           );

    NewMenu[INDEX_VIEW].nm_Label            = LLL( MSG_MENU_VIEW              , "View"                        );
    NewMenu[INDEX_PREVIOUS].nm_Label        = LLL( MSG_MENU_PREVIOUS          , "Previous level (Del)"        );
    NewMenu[INDEX_NEXT].nm_Label            = LLL( MSG_MENU_NEXT              , "Next level (Help)"           );
    NewMenu[INDEX_VIEWPOINTER].nm_Label     = LLL( MSG_MENU_POINTER           , "Pointer?"                    );
    NewMenu[INDEX_VIEWPOINTER].nm_CommKey   = LLL( MSG_SHORTCUT_POINTER       , "P"                           );
    NewMenu[INDEX_VIEWTITLEBAR].nm_Label    = LLL( MSG_MENU_TITLEBAR          , "Titlebar?"                   );
    NewMenu[INDEX_VIEWTITLEBAR].nm_CommKey  = LLL( MSG_SHORTCUT_TITLEBAR      , "B"                           );

    NewMenu[INDEX_SETTINGS].nm_Label        = LLL( MSG_MENU_SETTINGS          , "Settings"                    );
    NewMenu[INDEX_ANIMATIONS].nm_Label      = LLL( MSG_MENU_ANIMATIONS        , "Animations?"                 );
    NewMenu[INDEX_ANIMATIONS].nm_CommKey    = LLL( MSG_SHORTCUT_ANIMATIONS    , "T"                           );
    NewMenu[INDEX_AUTOSAVE].nm_Label        = LLL( MSG_AUTOSAVE               , "Autosave levelsets?"         );
    NewMenu[INDEX_CREATEICONS].nm_Label     = LLL( MSG_MENU_CREATEICONS       , "Create icons?"               );
    NewMenu[INDEX_CREATEICONS].nm_CommKey   = LLL( MSG_KEY_CREATEICONS        , "I"                           );
    NewMenu[INDEX_ENGRAVEDSQUARES].nm_Label = LLL( MSG_MENU_ENGRAVEDSQUARES   , "Engraved squares?"           );

    NewMenu[INDEX_HELP].nm_Label            = LLL( MSG_MENU_HELP              , "Help"                        );
    NewMenu[INDEX_CREATURES].nm_Label       = LLL( MSG_MENU_CREATURES         , "Creatures..."                ); // Amiga-1 shortcut isn't localized
    NewMenu[INDEX_OBJECTS].nm_Label         = LLL( MSG_MENU_OBJECTS           , "Objects..."                  ); // Amiga-2 shortcut isn't localized
    NewMenu[INDEX_FRUITS].nm_Label          = LLL( MSG_MENU_FRUITS            , "Fruits..."                   ); // Amiga-3 shortcut isn't localized
    NewMenu[INDEX_MANUAL].nm_Label          = LLL( MSG_MENU_MANUAL            , "Manual..."                   );
    NewMenu[INDEX_MANUAL].nm_CommKey        = LLL( MSG_KEY_MANUAL             , "M"                           );
    NewMenu[INDEX_UPDATE].nm_Label          = LLL( MSG_MENU_UPDATE            , "Check for updates..."        );
    NewMenu[INDEX_UPDATE].nm_CommKey        = LLL( MSG_KEY_UPDATE             , "U"                           );
    NewMenu[INDEX_ABOUT].nm_Label           = LLL( MSG_MENU_ABOUTWW           , "About Worm Wars..."          );
    NewMenu[INDEX_ABOUT].nm_CommKey         = LLL( MSG_KEY_ABOUT              , "?"                           );

    for (i = 0; i < 4; i++)
    {   CycleOptions[i][0]        = LLL( MSG_NONE,      "None"      );
        CycleOptions[i][1]        = "Amiga";
        CycleOptions[i][5]        = NULL;
    }
    CycleOptions[0][2]            = LLL( MSG_JOYSTICK3, "Joystick 3");
    CycleOptions[0][3]            = LLL( MSG_GAMEPAD3,  "Gamepad 3" );
    CycleOptions[0][4]            = LLL( MSG_LEFTKYBD,  "Lt. Kybd"  );
    CycleOptions[1][2]            = LLL( MSG_JOYSTICK4, "Joystick 4");
    CycleOptions[1][3]            = LLL( MSG_GAMEPAD4,  "Gamepad 4" );
    CycleOptions[1][4]            = LLL( MSG_RIGHTKYBD, "Rt. Kybd"  );
    CycleOptions[2][2]            = LLL( MSG_JOYSTICK2, "Joystick 2");
    CycleOptions[2][3]            = LLL( MSG_GAMEPAD2,  "Gamepad 2" );
    CycleOptions[3][2]            = LLL( MSG_JOYSTICK1, "Joystick 1");
    CycleOptions[3][3]            = LLL( MSG_GAMEPAD1,  "Gamepad 1" );

    DifficultyOptions[0]          = LLL( MSG_EASY,      "Easy"      );
    DifficultyOptions[1]          = LLL( MSG_NORMAL,    "Normal"    );
    DifficultyOptions[2]          = LLL( MSG_HARD,      "Hard"      );
    DifficultyOptions[3]          = LLL( MSG_VERYHARD,  "Very Hard" );

    strcpy(SoundText[0],            LLL( MSG_NONE,      "None"));
    strcpy(SoundText[1],            LLL( MSG_FX,        "Sound Effects"));
    strcat(SoundText[1],            " (F)");
#if defined(__SASC) || defined(__amigaos4__)
    strcpy(SoundText[2],            LLL( MSG_MUSIC,     "Music"));
    strcat(SoundText[2],            " (M)");
    SoundOptions[2]               = SoundText[2];
#else
    SoundOptions[2]               = NULL;
#endif
    SoundOptions[0]               = SoundText[0];
    SoundOptions[1]               = SoundText[1];

    StartGadget.ng_GadgetText     = (STRPTR) LLL(MSG_STARTGAME,    "Start Game (ENTER)"     );
    LevelEditGadget.ng_GadgetText = (STRPTR) LLL(MSG_LEVELEDITOR3, "Level Editor (Spacebar)");

#ifdef TRACKENTRY
    printf("12...\n"); Delay(TRACKDELAY);
#endif

    CycleOptions[2][4]   =
    CycleOptions[3][4]   =
    DifficultyOptions[4] =
    SoundOptions[3]      = NULL;

    stringptr = LLL( MSG_SHUFFLE,     "_Shuffle Levels?");
    length = strlen(stringptr);
    if (length >= 2)
    {   for (i = 0; i < length - 1; i++)
        {   if (stringptr[i] == '_')
            {   s_shortcut = toupper(stringptr[i + 1]);
                break;
    }   }   }
    stringptr = LLL( MSG_DIFFICULTY,  "_Difficulty:");
    length = strlen(stringptr);
    if (length >= 2)
    {   for (i = 0; i < length - 1; i++)
        {   if (stringptr[i] == '_')
            {   d_shortcut = toupper(stringptr[i + 1]);
                break;
    }   }   }

#ifdef TRACKENTRY
    printf("13...\n"); Delay(TRACKDELAY);
#endif

    if (execver >= OS_40 && !morphos)
    {   titlebar = FALSE;
    }

    ok = FALSE;
    if ((FileHandle = Open("PROGDIR:WormWars.config", MODE_OLDFILE)))
    {   if
        (   Read(FileHandle, ConfigBuffer, CONFIGLENGTH) == CONFIGLENGTH
         && ConfigBuffer[24] == 7 // means V9.2+
        )
        {   ok = TRUE;
            for (player = 0; player <= 3; player++)
            {   worm[player].control = (UBYTE) ConfigBuffer[player];
            }
            DisplayID     = (ULONG) (  (ConfigBuffer[ 4] * 16777216)
                                     + (ConfigBuffer[ 5] *    65536)
                                     + (ConfigBuffer[ 6] *      256)
                                     +  ConfigBuffer[ 7]            );
            DisplayWidth  = (ULONG) (  (ConfigBuffer[ 8] * 16777216)
                                     + (ConfigBuffer[ 9] *    65536)
                                     + (ConfigBuffer[10] *      256)
                                     +  ConfigBuffer[11]            );
            DisplayHeight = (ULONG) (  (ConfigBuffer[12] * 16777216)
                                     + (ConfigBuffer[13] *    65536)
                                     + (ConfigBuffer[14] *      256)
                                     +  ConfigBuffer[15]            );
            DisplayDepth  = (UWORD) (  (ConfigBuffer[16] *      256)
                                     +  ConfigBuffer[17]            );
            shuffle       = (FLAG)      ConfigBuffer[18];
            createicons   = (FLAG)      ConfigBuffer[19];
            anims         = (FLAG)      ConfigBuffer[20];
            titlebar      = (FLAG)      ConfigBuffer[21];
            engraved      = (FLAG)      ConfigBuffer[22];
            pointer       = (FLAG)      ConfigBuffer[23];
                                                 // [24] is version byte
            difficulty    = (ULONG)     ConfigBuffer[25];
            wantedmode    =             ConfigBuffer[26];
            AboutXPos     = (WORD)  (  (ConfigBuffer[27] *      256)
                                     +  ConfigBuffer[28]            );
            AboutYPos     = (WORD)  (  (ConfigBuffer[29] *      256)
                                     +  ConfigBuffer[30]            );
            customscreen  = (FLAG)      ConfigBuffer[31];
            autosave      = (FLAG)      ConfigBuffer[32];
        }
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    }

#ifdef TRACKENTRY
    printf("15...\n"); Delay(TRACKDELAY);
#endif

    // argument parsing

    if (argc) /* started from CLI */
    {   if (!(ArgsPtr = (struct RDArgs*) ReadArgs
        (    "NOLOWLEVEL/S," \
           "-N=NOPRELOAD/S," \
             "-A=NOANIMS/S," \
             "-I=NOICONS/S," \
               "-P=PRI/K/N," \
             "SCREENMODE/S," \
             "-S=SHUFFLE/S," \
               "-Q=QUIET/S," \
                  "GREEN/K," \
                    "RED/K," \
                   "BLUE/K," \
                 "YELLOW/K," \
              "PUBSCREEN/K," \
             "WINWIDTH/K/N," \
            "WINHEIGHT/K/N," \
                     "FILE",
            (LONG*) args,
            NULL
        )))
        {   DISCARD Printf
            (   "Usage: %s " \
                "[NOLOWLEVEL] " \
                "[-n=NOPRELOAD] " \
                "[-a=NOANIMS] " \
                "[-i=NOICONS] " \
                "[-p=PRI <priority>] " \
                "[SCREENMODE] " \
                "[-s=SHUFFLE] " \
                "[-q=QUIET] " \
                "[GREEN=JOY|PAD|AMIGA|NONE|KYBD] " \
                  "[RED=JOY|PAD|AMIGA|NONE|KYBD] " \
                 "[BLUE=JOY|PAD|AMIGA|NONE] " \
               "[YELLOW=JOY|PAD|AMIGA|NONE] " \
               "[PUBSCREEN=<screenname>] " \
                "[WINWIDTH=<width>] " \
               "[WINHEIGHT=<height>] " \
                "[[FILE=]<levelset>]\n",
                (long unsigned int) argv[0]
            );
            cleanexit(EXIT_FAILURE);
        }

        if (args[ARGPOS_USELOWLEVEL])
        {   uselowlevel = FALSE;
        }
        if (args[ARGPOS_NOPRELOAD])
        {   fxable = musicable = DEFER;
        }
        if (args[ARGPOS_NOANIMS])
        {   anims = FALSE;
        }
        if (args[ARGPOS_NOICONS])
        {   createicons = FALSE;
        }
        if (args[ARGPOS_PRI])
        {   if (args[ARGPOS_PRI] < -128 || args[ARGPOS_PRI] > 5)
            {   DISCARD Printf("%s: Priority range is -128 to +5\n", (long unsigned int) argv[0]);
                cleanexit(EXIT_FAILURE);
            }
            number = (SLONG) (*((SLONG *) args[ARGPOS_PRI]));
            NewPri = (int) number;
            OldPri = SetTaskPri((struct Task*) ProcessPtr, NewPri);
        }
        if (args[ARGPOS_SCREENMODE])
        {   screenmode = TRUE;
        }
        if (args[ARGPOS_SHUFFLE])
        {   shuffle = TRUE;
        }
        if (args[ARGPOS_QUIET])
        {   quiet = TRUE;
        }
        for (player = 0; player <= 3; player++)
        {   if (args[ARGPOS_GREEN + player])
            {   if
                (   player <= 1
                 && (   (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "KYBD"    ))
                     || (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "KEYBOARD"))
                )   )
                {   worm[player].control = KEYBOARD;
                } elif
                (   (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "JOY"     ))
                 || (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "STICK"   ))
                 || (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "JOYSTICK"))
                )
                {   worm[player].control = JOYSTICK;
                } elif
                (   (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "GAMEPAD"))
                 || (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "PAD"    ))
                )
                {   worm[player].control = GAMEPAD;
                } elif (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "AMIGA"))
                {   worm[player].control = THEAMIGA;
                } elif (!stricmp((STRPTR) args[ARGPOS_GREEN + player], "NONE"))
                {   worm[player].control = NONE;
                } else
                {   if (player <= 1)
                    {   DISCARD Printf("%s: Worm %ld control must be JOY|PAD|AMIGA|NONE|KYBD\n", (SLONG) player, (long unsigned int) argv[0]);
                    } else
                    {   DISCARD Printf("%s: Worm %ld control must be JOY|PAD|AMIGA|NONE\n", (SLONG) player, (long unsigned int) argv[0]);
                    }
                    cleanexit(EXIT_FAILURE);
        }   }   }
        if (args[ARGPOS_PUBSCREEN])
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayWidth  = 640;
                DisplayHeight = 512;
            }
            strcpy(screenname, (STRPTR) args[ARGPOS_PUBSCREEN]);
        }
        if (args[ARGPOS_WINWIDTH])
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayHeight = 512;
            }
            number = (SLONG) (*((SLONG *) args[ARGPOS_WINWIDTH]));
            DisplayWidth = (int) number;
            if   (DisplayWidth  < 640     ) DisplayWidth  = 640;
            elif (DisplayWidth  > MAXXSIZE) DisplayWidth  = MAXXSIZE;
        }
        if (args[ARGPOS_WINHEIGHT])
        {   if (customscreen)
            {   customscreen  = FALSE;
                DisplayWidth  = 640;
            }
            number = (SLONG) (*((SLONG *) args[ARGPOS_WINHEIGHT]));
            DisplayHeight = (int) number;
            if   (DisplayHeight < 512     ) DisplayHeight = 512;
            elif (DisplayHeight > MAXYSIZE) DisplayHeight = MAXYSIZE;
        }
        if (args[ARGPOS_FILE])
        {   strcpy(pathname, (STRPTR) args[ARGPOS_FILE]);
    }   }
    else // started from WB
    {   WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList; // head of the arg list

        for
        (   i = 0;
            i < WBMsg->sm_NumArgs;
            i++, WBArg++
        )
        {   if (WBArg->wa_Lock)
            {   // something that does not support locks
                parsewb();
            }
            else
            {   // locks supported, change to the proper directory
                OldDir = CurrentDir(WBArg->wa_Lock);
                parsewb();
                CurrentDir(OldDir);
            }
            if (i == 1)
            {   strcpy(pathname, WBArg->wa_Name);
    }   }   }

#ifdef TRACKENTRY
    printf("16...\n"); Delay(TRACKDELAY);
#endif

    if (uselowlevel)
    {   LowLevelBase = (struct Library*) OpenLibrary("lowlevel.library", OS_ANY);
#ifdef __amigaos4__
        if (!(ILowLevel = (struct LowLevelIFace*) GetInterface((struct Library*) LowLevelBase, "main", 1, NULL)))
        {   rq("Can't get lowlevel.library interface!");
        }
#endif
    }
    if (!LowLevelBase)
    {   if (worm[0].control == JOYSTICK || worm[0].control == GAMEPAD) worm[0].control = KEYBOARD;
        if (worm[1].control == JOYSTICK || worm[1].control == GAMEPAD) worm[1].control = KEYBOARD;
        if (worm[2].control == JOYSTICK || worm[2].control == GAMEPAD) worm[2].control = KEYBOARD;
        if (worm[3].control == JOYSTICK || worm[3].control == GAMEPAD) worm[3].control = KEYBOARD;
    }

    if (!(TimeValPtr = (struct timeval*) AllocMem(sizeof(struct timeval), MEMF_CLEAR)))
    {   rq("Can't allocate timer value structure!");
    }
    if (!(TimerPortPtr = (struct MsgPort*) CreateMsgPort()))
    {   rq("Can't allocate timer message port!");
    }
    if (!(TimerRqPtr = (struct timerequest*) CreateIORequest(TimerPortPtr, sizeof(struct timerequest))))
    {   rq("Can't create timer I/O request!");
    }
    if ((TimerClosed = OpenDevice(TIMERNAME, UNIT_VBLANK, (struct IORequest*) TimerRqPtr, 0)))
    {   rq("Can't open timer.device!");
    }
#if defined(__SASC) || defined(__amigaos4__) || (defined(__MORPHOS__) && defined(__VBCC__))
    TimerBase = (struct Device*)    (TimerRqPtr->tr_node.io_Device);
#else
    #ifdef __MORPHOS__
    TimerBase = (struct Library*)   (TimerRqPtr->tr_node.io_Device);
    #else
    TimerBase = (struct TimerBase*) (TimerRqPtr->tr_node.io_Device);
    #endif
#endif
#ifdef __amigaos4__
    if (!(ITimer      = (struct TimerIFace*     ) GetInterface((struct Library*) TimerBase,      "main", 1, NULL)))
    {   rq("Can't get timer.device interface!");
    }
#endif

#ifdef TRACKENTRY
    printf("17...\n"); Delay(TRACKDELAY);
#endif

/* Fix endiannes of imagedata on AROS little endian machines */
#if defined(__AROS__) && (AROS_BIG_ENDIAN == 0)
    swap_byteorder(CheckmarkData, sizeof(CheckmarkData) / 2);
    gfx_swap_byteorder();
    squares_swap_byteorder();
#endif

#ifdef TRACKENTRY
    printf("18...\n"); Delay(TRACKDELAY);
#endif

    if (customscreen && (!ok || screenmode))
    {   getscreenmode();
    }
    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }

#ifdef TRACKENTRY
    printf("19...\n"); Delay(TRACKDELAY);
#endif

    if (morphos)
    {   Topaz8.ta_Flags     =
        BoldTopaz8.ta_Flags = FPF_DISKFONT;
    }
    if ((DiskfontBase = (struct Library*) OpenLibrary("diskfont.library", OS_ANY)))
    {
#ifdef __amigaos4__
        if (!(IDiskfont = (struct DiskfontIFace* ) GetInterface((struct Library*) DiskfontBase, "main", 1, NULL)))
        {   rq("Can't get diskfont.library interface!");
        }
#endif
        FontPtr = (struct TextFont*) OpenDiskFont(&Topaz8);
        fontx = FontPtr->tf_XSize;
        fonty = FontPtr->tf_YSize;
        BoldFontPtr = (struct TextFont*) OpenDiskFont(&BoldTopaz8);
    }

#ifdef TRACKENTRY
    printf("20...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    registerapp();
#endif

    if (customscreen)
    {
#ifdef __AROS__
        ScreenPtr = (struct Screen*) OpenScreenTags
        (   NULL,
            SA_Width,         DisplayWidth,
            SA_Height,        DisplayHeight,
            SA_Depth,         DisplayDepth,
            SA_DisplayID,     DisplayID,
            SA_Behind,        TRUE,
            SA_AutoScroll,    TRUE,
            SA_ShowTitle,     titlebar ? TRUE : FALSE,
            SA_Title,         (ULONG) TITLEBAR,
            SA_Colors,        (ULONG) Colours,
            SA_Font,          (ULONG) &Topaz8,
            SA_Pens,          (ULONG) Pens,
        TAG_DONE);
#else
        ScreenPtr = (struct Screen*) OpenScreenTags
        (   NULL,
            SA_Width,         DisplayWidth,
            SA_Height,        DisplayHeight,
            SA_Depth,         DisplayDepth,
            SA_DisplayID,     DisplayID,
            SA_Behind,        TRUE,
            SA_AutoScroll,    TRUE,
            SA_ShowTitle,     titlebar ? TRUE : FALSE,
            SA_Title,         (ULONG) TITLEBAR,
            SA_Colors,        (ULONG) Colours,
            SA_Font,          (ULONG) &Topaz8,
            SA_LikeWorkbench, TRUE, // to get sticky menu support on OS4, but not handled correctly by AROS
            SA_Pens,          (ULONG) Pens,
        TAG_DONE);
#endif
        if (!ScreenPtr)
        {   rq("Can't open screen!"); // maybe fall back to using the WB screen
    }   }
    else
    {   lockscreen();
    }

    WindowWidth = DisplayWidth;
    if (DisplayWidth > MAXXSIZE)
    {   FieldWidth  = MAXXSIZE;
        xoffset     = (DisplayWidth  - MAXXSIZE) / 2;
    } else
    {   FieldWidth  = DisplayWidth;
        xoffset     = 0;
    }
    WindowHeight = DisplayHeight;
    if (DisplayHeight > MAXYSIZE)
    {   FieldHeight = MAXYSIZE;
        yoffset     = (DisplayHeight - MAXYSIZE) / 2;
    } else
    {   FieldHeight = DisplayHeight;
        yoffset     = 0;
    }
    if ((DisplayID & PAL_MONITOR_ID) == PAL_MONITOR_ID || (DisplayID & NTSC_MONITOR_ID) == NTSC_MONITOR_ID)
    {   memflags |= MEMF_CHIP;
    }

    saveconfig = TRUE;

    fieldx = ((FieldWidth  - 88         ) / 12) - 2;
    fieldy = ((FieldHeight - 16 - TBSIZE) / 12) - 1;

#ifdef TRACKENTRY
    printf("21...\n"); Delay(TRACKDELAY);
#endif

    /* These must be done before the menus are set up */
    if (pointer    ) NewMenu[INDEX_VIEWPOINTER    ].nm_Flags |= CHECKED;
    if (titlebar   ) NewMenu[INDEX_VIEWTITLEBAR   ].nm_Flags |= CHECKED;
    if (anims      ) NewMenu[INDEX_ANIMATIONS     ].nm_Flags |= CHECKED;
    if (autosave   ) NewMenu[INDEX_AUTOSAVE       ].nm_Flags |= CHECKED;
    if (createicons) NewMenu[INDEX_CREATEICONS    ].nm_Flags |= CHECKED;
    if (engraved   ) NewMenu[INDEX_ENGRAVEDSQUARES].nm_Flags |= CHECKED;

    /* GadTools */
    if
    (   !(       CycleGadget.ng_VisualInfo
          =     StringGadget.ng_VisualInfo
          =    ShuffleGadget.ng_VisualInfo
          = DifficultyGadget.ng_VisualInfo
          =      SoundGadget.ng_VisualInfo
          =      StartGadget.ng_VisualInfo
          =  LevelEditGadget.ng_VisualInfo
          =                     VisualInfoPtr
          = (APTR) GetVisualInfo(ScreenPtr, TAG_DONE)
    )   )
    {   rq("Can't get GadTools visual info!");
    }
    if (!(MenuPtr = (struct Menu*) CreateMenus(NewMenu, TAG_DONE)))
    {   rq("Can't create menus!");
    }
    if (!(LayoutMenus(MenuPtr, VisualInfoPtr, GTMN_NewLookMenus, TRUE, TAG_DONE)))
    {   rq("Can't lay out menus!");
    }
    if (!(PrevGadgetPtr = (struct Gadget*) CreateContext(&GListPtr)))
    {   rq("Can't create GadTools context!");
    }

#ifdef TRACKENTRY
    printf("22...\n"); Delay(TRACKDELAY);
#endif

    for (player = 0; player <= 3; player++)
    {   CycleGadget.ng_LeftEdge = CENTREXPIXEL - (9 * fontx);
        CycleGadget.ng_TopEdge  = YSTART + 229 + (player * 13);
        CycleGadget.ng_TextAttr = &Topaz8;
        CycleGadgetPtr[player] = PrevGadgetPtr = (struct Gadget*) CreateGadget
        (   CYCLE_KIND,
            PrevGadgetPtr,
            &CycleGadget,
            GTCY_Labels,   (ULONG) CycleOptions[player],
            GTCY_Active,   worm[player].control,
            GT_Underscore, '_',
            GA_Disabled,   TRUE,
        TAG_DONE);
    }

    ShuffleGadget.ng_LeftEdge = CENTREXPIXEL - (9 * fontx) + 192 - 26;
    ShuffleGadget.ng_TopEdge  = YSTART + 296;
    ShuffleGadget.ng_TextAttr = &Topaz8;
    ShuffleGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr,
        &ShuffleGadget,
        GTCB_Checked,  shuffle,
        GT_Underscore, '_',
        GA_Disabled,   TRUE,
    TAG_DONE);

    DifficultyGadget.ng_LeftEdge = CENTREXPIXEL - (9 * fontx);
    DifficultyGadget.ng_TopEdge  = YSTART + 321;
    DifficultyGadget.ng_TextAttr = &Topaz8;
    DifficultyGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   CYCLE_KIND,
        PrevGadgetPtr,
        &DifficultyGadget,
        GTCY_Labels,   (ULONG) DifficultyOptions,
        GTCY_Active,   difficulty,
        GT_Underscore, '_',
        GA_Disabled,   TRUE,
    TAG_DONE);

    SoundGadget.ng_LeftEdge = CENTREXPIXEL - (9 * fontx);
    SoundGadget.ng_TopEdge  = YSTART + 334;
    SoundGadget.ng_TextAttr = &Topaz8;
    SoundGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   CYCLE_KIND,
        PrevGadgetPtr,
        &SoundGadget,
        GTCY_Labels,   (ULONG) SoundOptions,
        GTCY_Active,   (ULONG) soundmode,
        GA_Disabled,   TRUE,
    TAG_DONE);

    StartGadget.ng_LeftEdge = CENTREXPIXEL - 160;
    StartGadget.ng_TopEdge  = YSTART + 365;
    StartGadget.ng_TextAttr = &BoldTopaz8;
    StartGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        PrevGadgetPtr,
        &StartGadget,
        GA_RelVerify,  TRUE,
        GA_Disabled,   TRUE,
    TAG_DONE);

    LevelEditGadget.ng_LeftEdge = CENTREXPIXEL - 160;
    LevelEditGadget.ng_TopEdge  = YSTART + 405;
    LevelEditGadget.ng_TextAttr = &Topaz8;
    LevelEditGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        PrevGadgetPtr,
        &LevelEditGadget,
        GA_RelVerify,  TRUE,
        GA_Disabled,   TRUE,
    TAG_DONE);

    for (which = 0; which <= HISCORES; which++)
    {   StringGadget.ng_LeftEdge = CENTREXPIXEL - 81;
        StringGadget.ng_TopEdge  = YSTART + 134 + (which * HISCOREDISTANCE);
        StringGadget.ng_TextAttr = &Topaz8; // important!
        StringGadgetPtr[which] = PrevGadgetPtr = (struct Gadget*) CreateGadget
        (   STRING_KIND,
            PrevGadgetPtr,
            &StringGadget,
            GTST_MaxChars,       NAMELENGTH,
            STRINGA_ReplaceMode, TRUE,
            GA_Disabled,         TRUE,
        TAG_DONE);
    }

    if (!PrevGadgetPtr)
    {   rq("Can't create GadTools gadgets!");
    }

#ifdef TRACKENTRY
    printf("23...\n"); Delay(TRACKDELAY);
#endif

    /* main window */
    if (!(MainWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,         customscreen ? 0 : ((ScreenPtr->Width  - WindowWidth ) / 2),
        WA_Top,          customscreen ? 0 : ((ScreenPtr->Height - WindowHeight) / 2),
        customscreen ? TAG_IGNORE : WA_Title,       (ULONG) "Worm Wars " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_ScreenTitle, (ULONG) "Worm Wars " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_DepthGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_DragBar,     TRUE,
        customscreen ? TAG_IGNORE : WA_CloseGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_SizeGadget,  FALSE,
        WA_IDCMP,        IDCMP_RAWKEY
                       | IDCMP_VANILLAKEY
                       | IDCMP_MOUSEBUTTONS
                       | IDCMP_CLOSEWINDOW
                       | IDCMP_ACTIVEWINDOW
                       | IDCMP_MENUPICK
                       | IDCMP_MENUVERIFY
                       | IDCMP_REFRESHWINDOW
                       | IDCMP_INTUITICKS
                       | CYCLEIDCMP
                       | CHECKBOXIDCMP
                       | BUTTONIDCMP
                       | STRINGIDCMP,
        WA_Gadgets,      (ULONG) GListPtr,
        WA_Activate,     TRUE,
        WA_ReportMouse,  TRUE,
        WA_RptQueue,     16,
        WA_NewLookMenus, TRUE,
        customscreen ? WA_Checkmark    : TAG_IGNORE,     (ULONG) &Checkmark,
        customscreen ? WA_Backdrop     : TAG_IGNORE,     TRUE,
        customscreen ? WA_Borderless   : TAG_IGNORE,     TRUE,
        customscreen ? WA_CustomScreen : TAG_IGNORE,     (ULONG) ScreenPtr,
        customscreen ? WA_Width        : WA_InnerWidth,  WindowWidth,
        customscreen ? WA_Height       : WA_InnerHeight, WindowHeight,
    TAG_DONE)))
    {   rq("Can't open main window!");
    }

#ifdef TRACKENTRY
    printf("24...\n"); Delay(TRACKDELAY);
#endif

    /* redirection of AmigaDOS system requesters */
    OldWindowPtr = ProcessPtr->pr_WindowPtr;
    ProcessPtr->pr_WindowPtr = (APTR) MainWindowPtr;

    SetFont(MainWindowPtr->RPort, FontPtr);
    fontx = MainWindowPtr->RPort->TxWidth;
    fonty = MainWindowPtr->RPort->TxHeight;

    if
    (   !(AboutData          = AllocVec(     114 * 8 * 2, memflags)) //  3 words ( 44 pixels) per row *  38 rows =  114 words per plane
     || !(LogoData           = AllocVec(    2090 * 8 * 2, memflags)) // 19 words (295 pixels) per row * 110 rows = 2090 words per plane
     || !(Background1Data    = AllocVec(      64 * 8 * 2, memflags)) //  2 words ( 32 pixels) per row *  32 rows =   64 words per plane
     || !(Background2Data    = AllocVec(      48 * 8 * 2, memflags)) //  2 words ( 32 pixels) per row *  24 rows =   48 words per plane
    )
    {   rq("Out of memory!");
    }
    for (i = 0; i < 6; i++)
    {   if (!(BoingData[i]   = AllocMem(      50 * 8 * 2, memflags))) // 2 words ( 29 pixels) per row *  25 rows =   50 words per plane
        {   rq("Out of memory!");
    }   }
    for (i = 0; i <= ARRAYSIZE; i++)
    {   if (!(SquaresData[i] = AllocMem( SQUAREY * 8 * 2, memflags))) // 1 word  ( 12 pixels) per row *  12 rows =   12 words per plane
        {   rq("Out of memory!");
    }   }
    About.ImageData       = AboutData;
    Logo.ImageData        = LogoData;
    Background1.ImageData = Background1Data;
    Background2.ImageData = Background2Data;

#ifdef TRACKENTRY
    printf("25...\n"); Delay(TRACKDELAY);
#endif

    remap();
    SetBPen(MainWindowPtr->RPort, remapit[BLACK]);
    if (!customscreen)
    {   xoffset = MainWindowPtr->BorderLeft;
        yoffset = MainWindowPtr->BorderTop;
    }

    pseudotop[0] = STARTYPIXEL - 4 + (   EMPTYGADGET * SQUAREY);
    pseudotop[1] = STARTYPIXEL - 4 + (  SILVERGADGET * SQUAREY);
    pseudotop[2] = STARTYPIXEL - 4 + (    GOLDGADGET * SQUAREY);
    pseudotop[3] = STARTYPIXEL - 4 + (DYNAMITEGADGET * SQUAREY);
    pseudotop[4] = STARTYPIXEL - 4 + (    WOODGADGET * SQUAREY);
    pseudotop[5] = STARTYPIXEL - 4 + (   STONEGADGET * SQUAREY);
    pseudotop[6] = STARTYPIXEL - 4 + (   METALGADGET * SQUAREY);
    pseudotop[7] = STARTYPIXEL - 4 + (   FROSTGADGET * SQUAREY);
    pseudotop[8] = STARTYPIXEL - 4 + (      UPGADGET * SQUAREY);
    pseudotop[9] = STARTYPIXEL - 4 + (    DOWNGADGET * SQUAREY);

    if (!pointer)
    {   SetPointer(MainWindowPtr, PointerData, 1, 1, 0, 0);
    }

    if (!(ASLRqPtr = (struct FileRequester*) AllocAslRequestTags
    (   ASL_FileRequest,
        ASL_Pattern, (ULONG) PATTERN,
        ASL_Window,  (ULONG) MainWindowPtr,
    TAG_DONE)))
    {   rq("Can't create ASL requester!");
    }

    ScreenToFront(ScreenPtr);

#ifdef TRACKENTRY
    printf("27...\n"); Delay(TRACKDELAY);
#endif

    if (musicable == UNTRIED)
    {   loadthemusic();
    }
    if (fxable == UNTRIED)
    {   loadthefx();
    }

    if (musicable  == SUCCEEDED && wantedmode == SOUNDMODE_MUSIC)
    {   toggle(SCAN_M);
    } elif (fxable == SUCCEEDED && wantedmode == SOUNDMODE_FX)
    {   toggle(SCAN_F);
    }

#ifdef TRACKENTRY
    printf("28...\n"); Delay(TRACKDELAY);
#endif

    sprintf
    (   saystring,
        LLL(MSG_LOADING, "Loading %s..."),
        pathname
    );
    say(saystring, WHITE);

#ifdef TRACKENTRY
    printf("29...\n"); Delay(TRACKDELAY);
#endif

    if (loadfields(pathname))
    {   if (!quiet)
        {   sprintf
            (   saystring,
                LLL(MSG_CANTOPEN, "Can't open %s!"),
                pathname
            );
            say(saystring, RED);
        }
        newfields();
        if (!quiet)
        {   anykey(TRUE, TRUE);
    }   }

#ifdef TRACKENTRY
    printf("30...\n"); Delay(TRACKDELAY);
#endif

    for (;;)
    {   titlescreen();

        switch (a)
        {
        case LEVELEDIT:
            fieldedit();
        acase PLAYGAME:
            playgame();
}   }   }

MODULE void playgame(void)
{   int   i;
    SWORD oldsecondsleft = -1;

    turbo = superturbo = FALSE;
    newgame();
    clearkybd();
    Forbid();
    MainWindowPtr->Flags |= WFLG_RMBTRAP;
    Permit();
    if (!(ModifyIDCMP // remove vanilla keys
    (   MainWindowPtr,
        IDCMP_RAWKEY
      | IDCMP_MOUSEBUTTONS
      | IDCMP_CLOSEWINDOW
      | IDCMP_ACTIVEWINDOW
      | IDCMP_MENUPICK
      | IDCMP_MENUVERIFY
      | IDCMP_REFRESHWINDOW
      | IDCMP_INTUITICKS
      | CYCLEIDCMP
      | CHECKBOXIDCMP
      | BUTTONIDCMP
      | STRINGIDCMP
    )))
    {   rq("ModifyIDCMP() failed!");
    }

    for (i = 0; i <= 3; i++)
    {   if (worm[i].control == GAMEPAD)
        {   DISCARD SetJoyPortAttrs(worm[i].port, SJA_Type, SJA_TYPE_GAMECTLR, TAG_DONE);
        } elif (worm[i].control == JOYSTICK)
        {   DISCARD SetJoyPortAttrs(worm[i].port, SJA_Type, SJA_TYPE_JOYSTK,   TAG_DONE);
    }   }
    secondsleft = secondsperlevel;

    // MAIN GAME LOOP ------------------------------------------------

    while (a == PLAYGAME)
    {   millielapsed += (delay / 1000);
        r++;
        secondsleft = secondsperlevel - (millielapsed / 1000);
        if (secondsleft != oldsecondsleft)
        {   timeloop();
            oldsecondsleft = secondsleft;
        }
        if (!turbo)
        {   TimerRqPtr->tr_node.io_Command  = TR_ADDREQUEST;
            TimerRqPtr->tr_time.tv_secs     = 0;
            TimerRqPtr->tr_time.tv_micro    = delay;
            SendIO((struct IORequest*) TimerRqPtr);
            evertimed = TRUE;
        }
        gameloop();
        if (CheckIO((struct IORequest*) TimerRqPtr))
        {   if (!clockdrawn)
            {   draw(CLOCKICONX, ICONY, CLOCK);
                clockdrawn = TRUE;
        }   }
        else
        {   if (clockdrawn)
            {   draw(CLOCKICONX, ICONY, BLACKENED);
                clockdrawn = FALSE;
        }   }
        if (!turbo)
        {   WaitIO((struct IORequest*) TimerRqPtr);
}   }   }

EXPORT FLAG anykey(FLAG timeout, FLAG allowrmb)
{   FLAG                 done       = FALSE;
    SBYTE                count      = 0;
    UWORD                code, qual;
    ULONG                class;
    struct IntuiMessage* MsgPtr;

    clearkybd();
    Forbid();
    MainWindowPtr->Flags |= WFLG_RMBTRAP;
    Permit();

    while (!done && !firebutton())
    {   while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_VANILLAKEY:
                if (!(qual & IEQUALIFIER_REPEAT))
                {   if (code == 'F' || code == 'f')
                    {   toggle(SCAN_F);
                    } elif (code == 'M' || code == 'm')
                    {   toggle(SCAN_M);
                    } else
                    {   done = TRUE;
                }   }
            acase IDCMP_RAWKEY:
                if ((!(qual & IEQUALIFIER_REPEAT)) && code < KEYUP && (code < FIRSTQUALIFIER || code > LASTQUALIFIER))
                {   if (code == SCAN_M)
                    {   toggle(SCAN_M);
                    } elif (code == SCAN_F)
                    {   toggle(SCAN_F);
                    } else
                    {   done = TRUE;
                        if (code == SCAN_ESCAPE)
                        {   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                            {   if (verify())
                                {   cleanexit(EXIT_SUCCESS);
                                } else
                                {   if (allowrmb)
                                    {   Forbid();
                                        MainWindowPtr->Flags &= ~WFLG_RMBTRAP;
                                        Permit();
                                    }
                                    return FALSE;
                }   }   }   }   }
            acase IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
            acase IDCMP_ACTIVEWINDOW:
                ignore = TRUE;
            acase IDCMP_MOUSEBUTTONS:
                if ((code == SELECTDOWN || code == MENUDOWN) && !(qual & IEQUALIFIER_REPEAT))
                {   if (ignore)
                    {   ignore = FALSE;
                    } else
                    {   done = TRUE;
                }   }
            acase IDCMP_INTUITICKS:
                if (timeout && ++count > TIMEOUT)
                {   done = TRUE;
    }   }   }   }

    if (allowrmb)
    {   Forbid();
        MainWindowPtr->Flags &= ~WFLG_RMBTRAP;
        Permit();
    }
    return TRUE;
}

EXPORT void celebrate(void)
{   FLAG                 done = FALSE;
    ULONG                class;
    UWORD                code, qual;
    struct IntuiMessage* MsgPtr;
    int                  bestscore = -1,
                         player,
                         winner    =  0;

    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE)
        {   if (worm[player].score >= worm[player].hiscore)
            {   worm[player].hiscore = worm[player].score;
            }
            if (worm[player].score > bestscore)
            {   bestscore = worm[player].score;
                winner = player;
    }   }   }
    say(LLL(MSG_CONGRATULATIONS, "*** CONGRATULATIONS! ***"), worm[winner].colour);

    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE && worm[player].score >= worm[player].hiscore)
        {   worm[player].hiscore = worm[player].score;
    }   }

    waitasec();
    clearkybd();
    while (!done && !firebutton())
    {   while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_RAWKEY:
                if (code == SCAN_M)
                {   toggle(SCAN_M);
                } elif (code == SCAN_F)
                {   toggle(SCAN_F);
                } elif (code == SCAN_ESCAPE)
                {   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    {   if (verify())
                        {   cleanexit(EXIT_SUCCESS);
                    }   }
                    else
                    {   done = TRUE;
                }   }
                elif (code == SCAN_RETURN || code == SCAN_ENTER || code == SCAN_SPACEBAR)
                {   done = TRUE;
                }
            acase IDCMP_MOUSEBUTTONS:
                if (code == SELECTDOWN && !(qual & IEQUALIFIER_REPEAT))
                {   if (ignore)
                    {   ignore = FALSE;
                    }
                    else
                    {   done = TRUE;
                }   }
            acase IDCMP_ACTIVEWINDOW:
                ignore = TRUE;
            acase IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
        }   }
        draw
        (   rand() % (fieldx + 1),
            rand() % (fieldy + 1),
            rand() % (LASTOBJECT + 1)
        );
    }
    a = GAMEOVER;
}

EXPORT void cleanexit(SLONG rc)
{   int  i;
    BPTR FileHandle;

#ifdef TRACKEXIT
    if (ScreenPtr)
    {   ScreenToFront(NULL); // so the user can see all the output
    }
    printf("1...\n"); Delay(TRACKDELAY);
#endif
    if (TimerRqPtr && evertimed)
    {   AbortIO((struct IORequest*) TimerRqPtr);
        WaitIO((struct IORequest*) TimerRqPtr);
    }
#ifdef TRACKEXIT
    printf("2...\n"); Delay(TRACKDELAY);
#endif

    freefx();
#ifdef TRACKEXIT
    printf("3...\n"); Delay(TRACKDELAY);
#endif
    for (i = 0; i < SAMPLES; i++)
    {   if (samp[i].base)
        {   FreeMem(samp[i].base, samp[i].size);
    }   }
#ifdef TRACKEXIT
    printf("4...\n"); Delay(TRACKDELAY);
#endif

    if (soundmode == SOUNDMODE_MUSIC)
    {   StopPlayer();
    }
#ifdef TRACKEXIT
    printf("5...\n"); Delay(TRACKDELAY);
#endif

    for (i = 0; i < SONGS; i++)
    {   if (SongPtr[i])
        {   UnLoadModule(SongPtr[i]);
    }   }
#ifdef TRACKEXIT
    printf("6...\n"); Delay(TRACKDELAY);
#endif

    if (MEDPlayerBase)
    {   FreePlayer();
#ifdef __amigaos4__
        if (IMEDPlayer)
        {    DropInterface((struct Interface*) IMEDPlayer);
        }
#endif
        CloseLibrary((struct Library*) MEDPlayerBase);
    }
#ifdef TRACKEXIT
    printf("7...\n"); Delay(TRACKDELAY);
#endif

    if (ASLRqPtr)        FreeAslRequest(ASLRqPtr);
    if (OldWindowPtr)    ProcessPtr->pr_WindowPtr = OldWindowPtr;

    if (MainWindowPtr)   {   clearkybd();
                             ClearMenuStrip(MainWindowPtr);
                             CloseWindow(MainWindowPtr);
                         }
#ifdef TRACKEXIT
    printf("8...\n"); Delay(TRACKDELAY);
#endif

    if (GListPtr)        FreeGadgets(GListPtr);
    if (MenuPtr)         FreeMenus(MenuPtr);
    if (VisualInfoPtr)   FreeVisualInfo(VisualInfoPtr);

    if (customscreen)
    {   if (ScreenPtr)   DISCARD CloseScreen(ScreenPtr);
    } else
    {   for (i = 0; i < 16; i++)
        {   if (gotpen[i])
            {   ReleasePen(ScreenPtr->ViewPort.ColorMap, remapit[i]);
                gotpen[i] = FALSE;
        }   }
        unlockscreen();
    }

    if (AboutData)
    {   FreeVec(AboutData);
        // AboutData = NULL;
    }
    if (LogoData)
    {   FreeVec(LogoData);
        // LogoData = NULL;
    }
    if (Background1Data)
    {   FreeVec(Background1Data);
        // Background1Data = NULL;
    }
    if (Background2Data)
    {   FreeVec(Background2Data);
        // Background2Data = NULL;
    }
    for (i = 0; i < 6; i++)
    {   if (BoingData[i])
        {   FreeMem(BoingData[i], 50 * 8 * 2);
            // BoingData[i] = NULL;
    }   }
    for (i = 0; i <= ARRAYSIZE; i++)
    {   if (SquaresData[i])
        {   FreeMem(SquaresData[i], SQUAREY * 8 * 2);
            // SquaresData[i] = NULL;
    }   }

    if (FontPtr)         CloseFont(FontPtr);
    if (BoldFontPtr)     CloseFont(BoldFontPtr);
#ifdef __amigaos4__
    if (ITimer)          DropInterface((struct Interface*) ITimer);
#endif
    if (!TimerClosed)    CloseDevice((struct IORequest*) TimerRqPtr);
    if (TimerRqPtr)      DeleteIORequest((struct IORequest*) TimerRqPtr);
    if (TimerPortPtr)    DeleteMsgPort(TimerPortPtr);
    if (TimeValPtr)      FreeMem(TimeValPtr, sizeof(struct timeval));

#ifdef TRACKEXIT
    printf("9...\n"); Delay(TRACKDELAY);
#endif

    if (LocaleBase)
    {   if (CatalogPtr)  CloseCatalog(CatalogPtr);
#ifdef __amigaos4__
        if (ILocale)
        {    DropInterface((struct Interface*) ILocale);
        }
#endif
        CloseLibrary(LocaleBase);
    }

#ifdef TRACKEXIT
    printf("10...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (IOpenURL)        { DropInterface((struct Interface*) IOpenURL   ); }
    if (IAmigaGuide)     { DropInterface((struct Interface*) IAmigaGuide); }
    if (IAsl)            { DropInterface((struct Interface*) IAsl       ); }
    if (IGadTools)       { DropInterface((struct Interface*) IGadTools  ); }
    if (IDiskfont)       { DropInterface((struct Interface*) IDiskfont  ); }
    if (IGraphics)       { DropInterface((struct Interface*) IGraphics  ); }
    if (IIcon)           { DropInterface((struct Interface*) IIcon      ); }
    if (IUtility)        { DropInterface((struct Interface*) IUtility   ); }
    if (IApplication)
    {   if (AppID)
        {   // assert(ApplicationBase);
            // assert(IApplication);
            UnregisterApplication(AppID, TAG_DONE);
            // AppID = 0;
        }
        DropInterface((struct Interface*) IApplication);
    }
    if (ApplicationBase) CloseLibrary(ApplicationBase); // ApplicationBase = NULL;
#endif

    if (DiskfontBase)    CloseLibrary((struct Library*) DiskfontBase);
    if (OpenURLBase)     CloseLibrary(OpenURLBase);
    if (AmigaGuideBase)  CloseLibrary(AmigaGuideBase);

#ifdef TRACKEXIT
    printf("11...\n"); Delay(TRACKDELAY);
#endif

    if (LowLevelBase)
    {   for (i = 0; i <= 3; i++)
        {   DISCARD SetJoyPortAttrs(worm[i].port, SJA_Reinitialize, TRUE, TAG_DONE);
    }   }
#ifdef __amigaos4__
    if (ILowLevel)       DropInterface((struct Interface*) ILowLevel);
#endif
    if (LowLevelBase)    CloseLibrary((struct Library*) LowLevelBase); // LowLevelBase = NULL;

#ifdef TRACKEXIT
    printf("12...\n"); Delay(TRACKDELAY);
#endif

    if (UtilityBase)     CloseLibrary((struct Library*) UtilityBase);
    if (AslBase)         CloseLibrary((struct Library*) AslBase);
    if (GadToolsBase)    CloseLibrary((struct Library*) GadToolsBase);
    if (GfxBase)         CloseLibrary((struct Library*) GfxBase);
    if (IconBase)        CloseLibrary((struct Library*) IconBase);

#ifdef __amigaos4__
    if (IIntuition)      DropInterface((struct Interface*) IIntuition);
#endif
    if (IntuitionBase)
    {   DISCARD OpenWorkBench();
        CloseLibrary((struct Library*) IntuitionBase);
    }

    SetTaskPri((struct Task*) ProcessPtr, OldPri);
    if (ArgsPtr)         FreeArgs(ArgsPtr);

#ifdef TRACKEXIT
    printf("13...\n"); Delay(TRACKDELAY);
#endif

    if (saveconfig)
    {   for (i = 0; i <= 3; i++)
        {   ConfigBuffer[i] = worm[i].control;
        }
        ConfigBuffer[ 4] = (UBYTE)   (DisplayID     / 16777216);
        ConfigBuffer[ 5] = (UBYTE)  ((DisplayID     % 16777216) / 65536);
        ConfigBuffer[ 6] = (UBYTE)  ((DisplayID                 % 65536) / 256);
        ConfigBuffer[ 7] = (UBYTE)   (DisplayID                          % 256);
        ConfigBuffer[ 8] = (UBYTE)   (DisplayWidth  / 16777216);
        ConfigBuffer[ 9] = (UBYTE)  ((DisplayWidth  % 16777216) / 65536);
        ConfigBuffer[10] = (UBYTE)  ((DisplayWidth              % 65536) / 256);
        ConfigBuffer[11] = (UBYTE)   (DisplayWidth                       % 256);
        ConfigBuffer[12] = (UBYTE)   (DisplayHeight / 16777216);
        ConfigBuffer[13] = (UBYTE)  ((DisplayHeight % 16777216) / 65536);
        ConfigBuffer[14] = (UBYTE)  ((DisplayHeight             % 65536) / 256);
        ConfigBuffer[15] = (UBYTE)   (DisplayHeight                      % 256);
        ConfigBuffer[16] = (UBYTE)   (DisplayDepth                       / 256);
        ConfigBuffer[17] = (UBYTE)   (DisplayDepth                       % 256);
        ConfigBuffer[18] = (UBYTE) shuffle;
        ConfigBuffer[19] = (UBYTE) createicons;
        ConfigBuffer[20] = (UBYTE) anims;
        ConfigBuffer[21] = (UBYTE) titlebar;
        ConfigBuffer[22] = (UBYTE) engraved;
        ConfigBuffer[23] = (UBYTE) pointer;
        ConfigBuffer[24] = (UBYTE) 7; // means V9.2+
        ConfigBuffer[25] = (UBYTE) difficulty;
        ConfigBuffer[26] = (UBYTE) soundmode;
        ConfigBuffer[27] = (UBYTE)   (AboutXPos                          / 256);
        ConfigBuffer[28] = (UBYTE)   (AboutXPos                          % 256);
        ConfigBuffer[29] = (UBYTE)   (AboutYPos                          / 256);
        ConfigBuffer[30] = (UBYTE)   (AboutYPos                          % 256);
        ConfigBuffer[31] = (UBYTE) customscreen;
        ConfigBuffer[32] = (UBYTE) autosave;

        if ((FileHandle = Open("PROGDIR:WormWars.config", MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, ConfigBuffer, CONFIGLENGTH);
            DISCARD Close(FileHandle);
            // FileHandle = NULL;
    }   }

#ifdef TRACKEXIT
    printf("14...\n"); Delay(TRACKDELAY);
#endif

    exit((int) rc); /* End of program. */

#ifdef TRACKEXIT
    printf("15...\n"); Delay(TRACKDELAY); // this should never get executed
#endif
}

EXPORT void clearkybd(void)
{   struct IntuiMessage* MsgPtr;

    while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        GT_ReplyIMsg(MsgPtr);
}

EXPORT void effect(int index)
{   TRANSIENT int   i,
                    ok            = -1;
    TRANSIENT ULONG oldestreceipt = (ULONG) -1;
    PERSIST   ULONG nextreceipt   = 1;

    /* oldestreceipt = temporary variable for ascertaining oldest
                       sound still playing.
    nextreceipt = next unused receipt number (monotonically incrementing). */

    if (soundmode == SOUNDMODE_FX)
    {   for (i = 0; i <= 3; i++)
        {   /* decide on a channel */

            if (ok == -1)
            {   if (!eversent[i])
                {   ok = i;
                } elif (CheckIO((struct IORequest*) AudioRqPtr[i]))
                {   WaitIO((struct IORequest*) AudioRqPtr[i]);
                    ok = i;
        }   }   }
        if (ok == -1)
        {   for (i = 0; i <= 3; i++)
                if (receipter[i] < oldestreceipt)
                {   ok = i;
                    oldestreceipt = receipter[i];
                }
            AbortIO((struct IORequest*) AudioRqPtr[ok]);
            WaitIO((struct IORequest*) AudioRqPtr[ok]);
        }
        eversent[ok] = TRUE;
        AudioRqPtr[ok]->ioa_Cycles              = 1;
        AudioRqPtr[ok]->ioa_Request.io_Command  = CMD_WRITE;
        AudioRqPtr[ok]->ioa_Request.io_Flags    = ADIOF_PERVOL;
        AudioRqPtr[ok]->ioa_Request.io_Unit     = (struct Unit*) (1 << ok);
        AudioRqPtr[ok]->ioa_Volume              = 64;
        AudioRqPtr[ok]->ioa_Period              = (UWORD) samp[index].speed;
        AudioRqPtr[ok]->ioa_Request.io_Message.mn_ReplyPort
                                                = AudioPortPtr[ok];
        AudioRqPtr[ok]->ioa_Data                = (UBYTE*) samp[index].base;
        AudioRqPtr[ok]->ioa_Length              = samp[index].length[samp[index].bank];
        BeginIO((struct IORequest*) AudioRqPtr[ok]);
        receipter[ok] = nextreceipt;
}   }

EXPORT void help(UBYTE type)
{   TEXT   tempstring[5 + 1]; // enough for "20000"
    STRPTR titlestr = NULL; // initialized to avoid spurious SAS/C optimizer warnings
    int    i, j,
           length,
           x = 0, y = 0; // initialized to avoid spurious SAS/C optimizer warnings

    switch (type)
    {
    case ORB:
        x        = 28 + (22 * fontx);
        y        = (SWORD) 26 + (SQUAREY *  CREATUREHELPS              );
        titlestr = (STRPTR) LLL(MSG_HAIL_CREATURES, "Creatures");
    acase AFFIXER:
        x        = 24 + (42 * fontx);
        y        = (SWORD) 26 + (SQUAREY *  LASTOBJECT                 );
        titlestr = (STRPTR) LLL(MSG_HAIL_OBJECTS,   "Objects"  );
    acase FIRSTFRUIT:
        x        = 28 + (22 * fontx);
        y        = (SWORD) 26 + (SQUAREY * (LASTFRUIT - FIRSTFRUIT + 1));
        titlestr = (STRPTR) LLL(MSG_HAIL_FRUITS,    "Fruits"   );
    }

    if (!(HelpWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (ULONG) ((DisplayWidth  / 2) - (x / 2)),
        WA_Top,           (ULONG) ((DisplayHeight / 2) - (y / 2)),
        WA_InnerWidth,    (ULONG) x,
        WA_InnerHeight,   (ULONG) y,
        WA_IDCMP,         IDCMP_CLOSEWINDOW
                        | IDCMP_RAWKEY
                        | IDCMP_MOUSEBUTTONS
                        | IDCMP_INTUITICKS,
        WA_Title,         (ULONG) titlestr,
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   say("Can't open help window!", RED);
        anykey(TRUE, TRUE);
        return;
    } // implied else

    SetFont(HelpWindowPtr->RPort, FontPtr);
    SetAPen(HelpWindowPtr->RPort, remapit[BLACK]);
    SetBPen(HelpWindowPtr->RPort, remapit[BLACK]);
    RectFill
    (   HelpWindowPtr->RPort,
        HelpWindowPtr->BorderLeft,
        HelpWindowPtr->BorderTop,
        HelpWindowPtr->BorderLeft + x - 1,
        HelpWindowPtr->BorderTop  + y - 1
    );
    SetAPen(HelpWindowPtr->RPort, remapit[WHITE]);
    SetDrMd(HelpWindowPtr->RPort, JAM1);

    switch (type)
    {
    case ORB:
        length = strlen(LLL(MSG_POINTS, "Pts"));
        shadowit
        (   HelpWindowPtr,
            HelpWindowPtr->BorderLeft + MORERT +  22 + ((22 - length) * fontx),
            HelpWindowPtr->BorderTop  + MOREDN +  13,
            LLL(MSG_POINTS, "Pts")
        );

        j = 0;
        for (i = 0; i <= SPECIES; i++)
        {   if (creatureinfo[i].user)
            {   Squares.ImageData = SquaresData[creatureinfo[i].symbol];
                DrawImage
                (   HelpWindowPtr->RPort,
                    &Squares,
                    HelpWindowPtr->BorderLeft + MORERT +  6,
                    HelpWindowPtr->BorderTop  + MOREDN + 17 + (j * SQUAREY)
                );

                shadowit
                (   HelpWindowPtr,
                    HelpWindowPtr->BorderLeft + MORERT + 22,
                    HelpWindowPtr->BorderTop  + MOREDN + 26 + (j * SQUAREY),
                    creatureinfo[i].name
                );

                stcl_d(tempstring, creatureinfo[i].score);
                align(tempstring, 3, ' ');
                shadowit
                (   HelpWindowPtr,
                    HelpWindowPtr->BorderLeft + MORERT + 22 + (19 * fontx  ),
                    HelpWindowPtr->BorderTop  + MOREDN + 26 + (j  * SQUAREY),
                    tempstring
                );

                j++;
        }   }

        // this line must be drawn last
        Move
        (   HelpWindowPtr->RPort,
            HelpWindowPtr->BorderLeft + MORERT + 22,
            HelpWindowPtr->BorderTop  + MOREDN + 16
        );
        Draw
        (   HelpWindowPtr->RPort,
            HelpWindowPtr->BorderLeft + MORERT + 22 + (fontx * 22),
            HelpWindowPtr->BorderTop  + MOREDN + 16
        );
    acase AFFIXER:
        for (i = 0; i <= LASTOBJECT; i++)
        {   Squares.ImageData = SquaresData[i];
            DrawImage
            (   HelpWindowPtr->RPort,
                &Squares,
                HelpWindowPtr->BorderLeft + MORERT +  6,
                HelpWindowPtr->BorderTop  + MOREDN +  6 + (i  * SQUAREY)
            );
            shadowit
            (   HelpWindowPtr,
                HelpWindowPtr->BorderLeft + MORERT + 22,
                HelpWindowPtr->BorderTop  + MOREDN + 15 + (i  * SQUAREY),
                objectinfo[i].desc
            );
        }
    acase FIRSTFRUIT:
        length = strlen(LLL(MSG_POINTS, "Pts"));
        shadowit
        (   HelpWindowPtr,
            HelpWindowPtr->BorderLeft + MORERT +  22 + ((22 - length) * fontx),
            HelpWindowPtr->BorderTop  + MOREDN +  13,
            LLL(MSG_POINTS, "Pts")
        );

        for (i = 0; i <= LASTFRUIT - FIRSTFRUIT; i++)
        {   Squares.ImageData = SquaresData[FIRSTFRUIT + i];
            DrawImage
            (   HelpWindowPtr->RPort,
                &Squares,
                HelpWindowPtr->BorderLeft + MORERT +  6,
                HelpWindowPtr->BorderTop  + MOREDN + 17 + (i  * SQUAREY)
            );

            shadowit
            (   HelpWindowPtr,
                HelpWindowPtr->BorderLeft + MORERT + 22,
                HelpWindowPtr->BorderTop  + MOREDN + 26 + (i  * SQUAREY),
                fruitname[i]
            );

            stcl_d(tempstring, POINTS_FRUIT * (i + 1));
            align(tempstring, 5, ' ');
            shadowit
            (   HelpWindowPtr,
                HelpWindowPtr->BorderLeft + MORERT + 22 + (17 * fontx  ),
                HelpWindowPtr->BorderTop  + MOREDN + 26 + (i  * SQUAREY),
                tempstring
            );
        }

        // this line must be drawn last
        Move
        (   HelpWindowPtr->RPort,
            HelpWindowPtr->BorderLeft + MORERT + 22,
            HelpWindowPtr->BorderTop  + MOREDN + 16
        );
        Draw
        (   HelpWindowPtr->RPort,
            HelpWindowPtr->BorderLeft + MORERT + 22 + (fontx * 22),
            HelpWindowPtr->BorderTop  + MOREDN + 16
        );
    }

    helploop(type);
}

EXPORT void helploop(UBYTE type)
{   FLAG                 done = FALSE;
    UWORD                code, qual;
    SBYTE                birddir     =  1,
                         birdframe   = -1,
                         eelframe    =  0,
                         squidframe  =  0,
                         turtledir   =  1,
                         turtleframe = -1;
    ULONG                class;
    struct IntuiMessage* MsgPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    while (!done)
    {   if
        (   Wait
            (   (1 << HelpWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   CloseWindow(HelpWindowPtr);
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GetMsg(HelpWindowPtr->UserPort)))
        {   class  = MsgPtr->Class;
            code   = MsgPtr->Code;
            qual   = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            switch (class)
            {
            case IDCMP_INTUITICKS:
                if (type == ORB && anims)
                {   birdframe += birddir;
                    Squares.ImageData = SquaresData[birdframes[birdframe]];
                    DrawImage
                    (   HelpWindowPtr->RPort,
                        &Squares,
                        HelpWindowPtr->BorderLeft + MORERT +  6,
                        HelpWindowPtr->BorderTop  + MOREDN + 17 + (ANIMPOS_BIRD   * SQUAREY)
                    );
                    if (birdframe == 0)
                    {   birddir = 1;
                    } elif (birdframe == BIRDFRAMES)
                    {   birddir = -1;
                    }

                    Squares.ImageData = SquaresData[eelframes[eelframe]];
                    DrawImage
                    (   HelpWindowPtr->RPort,
                        &Squares,
                        HelpWindowPtr->BorderLeft + MORERT +  6,
                        HelpWindowPtr->BorderTop  + MOREDN + 17 + (ANIMPOS_EEL    * SQUAREY)
                    );
                    if (eelframe == EELFRAMES)
                    {   eelframe = 0;
                    } else
                    {   eelframe++;
                    }

                    Squares.ImageData = SquaresData[squidframes[squidframe]];
                    DrawImage
                    (   HelpWindowPtr->RPort,
                        &Squares,
                        HelpWindowPtr->BorderLeft + MORERT +  6,
                        HelpWindowPtr->BorderTop  + MOREDN + 17 + (ANIMPOS_SQUID  * SQUAREY)
                    );
                    if (squidframe == SQUIDFRAMES)
                    {   squidframe = 0;
                    } else
                    {   squidframe++;
                    }

                    turtleframe += turtledir;
                    Squares.ImageData = SquaresData[turtleframes[turtleframe]];
                    DrawImage
                    (   HelpWindowPtr->RPort,
                        &Squares,
                        HelpWindowPtr->BorderLeft + MORERT +  6,
                        HelpWindowPtr->BorderTop  + MOREDN + 17 + (ANIMPOS_TURTLE * SQUAREY)
                    );
                    if (turtleframe == 0)
                    {   turtledir = 1;
                    } elif (turtleframe == TURTLEFRAMES - 1)
                    {   turtledir = -1;
                }   }
            acase IDCMP_CLOSEWINDOW:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if
                (   code == SCAN_SPACEBAR
                 || code == SCAN_RETURN
                 || code == SCAN_ENTER
                 || code == SCAN_HELP
                )
                {   done = TRUE;
                } elif (code == SCAN_ESCAPE)
                {   if (qual & IEQUALIFIER_LSHIFT || qual & IEQUALIFIER_RSHIFT)
                    {   if (verify())
                        {   CloseWindow(HelpWindowPtr);
                            cleanexit(EXIT_SUCCESS);
                    }   }
                    else
                    {   done = TRUE;
        }   }   }   }

#ifdef __amigaos4__
        rc = handle_applibport(FALSE);
        if (rc == 1 || (rc == 3 && verify()))
        {   cleanexit(EXIT_SUCCESS);
        }
#endif
    }

    CloseWindow(HelpWindowPtr);
    HelpWindowPtr = NULL;
    clearkybd();
}

EXPORT void filedelete(void)
{   TEXT newpathname[MAX_PATH + 1],
         tempstring[80 + MAX_PATH + 1];

    if
    (   AslRequestTags
        (   ASLRqPtr,
            ASL_Hail,          (ULONG) LLL(MSG_DELETELSET, "Delete Levelset"),
            ASL_FuncFlags,     FILF_PATGAD | FILF_SAVE,
            ASLFR_RejectIcons, TRUE,
        TAG_DONE)
     && *(ASLRqPtr->rf_File) != EOS
    )
    {   strcpy(newpathname, ASLRqPtr->rf_Dir);
        DISCARD AddPart(newpathname, ASLRqPtr->rf_File, 254);
        if (DeleteFile(newpathname))
        {   sprintf
            (   tempstring,
                LLL(MSG_DELETED,    "Deleted %s."),
                newpathname
            );
        } else
        {   sprintf
            (   tempstring,
                LLL(MSG_CANTDELETE, "Can't delete %s!"),
                newpathname
            );
        }
        say(tempstring, WHITE);
}   }

EXPORT void fileopen(FLAG revert)
{   TEXT newpathname[MAX_PATH + 1],
         tempstring[80 + MAX_PATH + 1];

    if
    (   (revert && pathname[0] == EOS)
     || ((!revert || !autosave) && !verify())
    )
    {   return;
    }

    if
    (   revert
     || (   AslRequestTags
            (   ASLRqPtr,
                ASL_Hail,          (ULONG) LLL(MSG_OPENLSET, "Open Levelset"), // we should have a separate hail string
                ASL_FuncFlags,     FILF_PATGAD,
                ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         && *(ASLRqPtr->rf_File) != EOS
    )   )
    {   if (revert)
        {   strcpy(newpathname, pathname);
        } else
        {   strcpy(newpathname, ASLRqPtr->rf_Dir);
            DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
        }
        if (!loadfields(newpathname))
        {   strcpy(pathname, newpathname);

            sprintf
            (   tempstring,
                LLL(MSG_OPENED,   "Opened %s (%d levels)."),
                newpathname,
                levels
            );

            if (a == LEVELEDIT)
            {   if (level > levels)
                {   level = levels;
                }
                le_drawfield();
            } else
            {   renderhiscores_amiga();
            }
            updatemenu(); // this updates "clear high scores" menu item
        } else
        {   sprintf
            (   tempstring,
                LLL(MSG_CANTOPEN, "Can't open %s!"),
                newpathname
            );
        }

        say(tempstring, WHITE);
}   }

EXPORT void filesaveas(FLAG saveas)
{   PERSIST   TEXT               newpathname[MAX_PATH + 1],
                                 tempstring[80 + MAX_PATH + 1];
    TRANSIENT struct DiskObject* InfoHandle;

    strcpy(newpathname, pathname);

    if (saveas || newpathname[0] == EOS)
    {   if
        (   strlen(newpathname) < 5
         || stricmp(&newpathname[strlen(newpathname) - 5], ".lset")
        )
        {   strcat(newpathname, ".lset");
        }

        if
        (   !AslRequestTags
            (   ASLRqPtr,
                ASL_Hail,          (ULONG) LLL(MSG_SAVELSET, "Save Levelset"), // we should have a separate hail string
                ASL_FuncFlags,     FILF_PATGAD | FILF_SAVE,
                ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         || *(ASLRqPtr->rf_File) == EOS
        )
        {   return;
        } // implied else

        strcpy(newpathname, ASLRqPtr->rf_Dir);
        DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);

        if
        (   strlen(newpathname) < 5
         || stricmp(&newpathname[strlen(newpathname) - 5], ".lset")
        )
        {   strcat(newpathname, ".lset");
    }   }

    sprintf
    (   tempstring,
        LLL(MSG_SAVING, "Saving %s..."),
        newpathname
    );
    say(tempstring, WHITE);

    if (savefields(newpathname))
    {   strcpy(pathname, newpathname);

// OS4 version apparently crashes between here...
        if (createicons && execver < OS_40)
        {   if ((InfoHandle = (struct DiskObject*) GetDiskObjectNew(DEFAULTSET)))
            {   InfoHandle->do_CurrentX = NO_ICON_POSITION;
                InfoHandle->do_CurrentY = NO_ICON_POSITION;
                if (!PutDiskObject(pathname, InfoHandle))
                {   say("Couldn't write .info file!", RED);
                    anykey(TRUE, TRUE);
                }
                FreeDiskObject(InfoHandle);
            } else
            {   say("Can't read .info file!", RED);
                anykey(TRUE, TRUE);
        }   }
// ...and here

        levels_modified = scores_modified = FALSE;
        sprintf
        (   tempstring,
            LLL(MSG_SAVED,    "Saved %s (%d levels)."),
            pathname,
            levels
        );
    } else
    {   sprintf
        (   tempstring,
            LLL(MSG_CANTSAVE, "Can't save %s!"),
            newpathname
        );
    }

    say(tempstring, WHITE);
}

EXPORT void gameinput(void)
{   FLAG                 allowed,
                         done;
    UWORD                code,
                         qual;
    ULONG                class;
    struct IntuiMessage* MsgPtr;
    SBYTE                keyplayer, i;
    UBYTE                which;
#ifdef __amigaos4__
    int                  rc;
#endif

    for (which = 0; which <= NUMKEYS; which++)
    {   key[which].down = FALSE;
    }

    /* keyboard */

    while (((MsgPtr = (struct IntuiMessage*) GetMsg(MainWindowPtr->UserPort))))
    {   class = MsgPtr->Class;
        code  = MsgPtr->Code;
        qual  = MsgPtr->Qualifier;
        ReplyMsg((struct Message*) MsgPtr);
        switch (class)
        {
        case IDCMP_RAWKEY:
            if (!(qual & IEQUALIFIER_REPEAT) && code < KEYUP)
            {   switch (code)
                {
                case SCAN_M:
                    toggle(SCAN_M);
                acase SCAN_F:
                    toggle(SCAN_F);
                acase SCAN_T:
                    // check whether any human worms are playing
                    allowed = TRUE;
                    for (i = 0; i <= 3; i++)
                    {   if
                        (   worm[i].control != THEAMIGA
                         && worm[i].control != NONE
                         && worm[i].lives
                        )
                        {   allowed = FALSE;
                            break;
                    }   }
                    if (allowed)
                    {   if (turbo)
                        {   turbo = superturbo = FALSE;
                        } else
                        {   turbo      = TRUE;
                            superturbo = FALSE;
                            draw(CLOCKICONX, ICONY, CLOCK);
                    }   }
                acase SCAN_B:
                    // check whether any human worms are playing
                    allowed = TRUE;
                    for (i = 0; i <= 3; i++)
                    {   if
                        (   worm[i].control != THEAMIGA
                         && worm[i].control != NONE
                         && worm[i].lives
                        )
                        {   allowed = FALSE;
                            break;
                    }   }
                    if (allowed)
                    {   if (turbo)
                        {   turbo = superturbo = FALSE;
                        } else
                        {   draw(CLOCKICONX, ICONY, CLOCK);
                            // order-dependent!
                            turbo = superturbo = TRUE;
                    }   }
                acase SCAN_P:
                    clearkybd();
                    Forbid();
                    MainWindowPtr->Flags &= ~WFLG_RMBTRAP;
                    Permit();
                    say(LLL( MSG_PAUSED, "Paused...press P to unpause"), WHITE);
                    done = FALSE;
                    while (!done)
                    {   if
                        (   Wait
                            (   (1 << MainWindowPtr->UserPort->mp_SigBit)
                              | AppLibSignal
                              | SIGBREAKF_CTRL_C
                            ) & SIGBREAKF_CTRL_C
                        )
                        {   cleanexit(EXIT_SUCCESS);
                        }
                        while ((MsgPtr = (struct IntuiMessage*) GetMsg(MainWindowPtr->UserPort)))
                        {   class = MsgPtr->Class;
                            code  = MsgPtr->Code;
                            qual  = MsgPtr->Qualifier;
                            ReplyMsg((struct Message*) MsgPtr);

                            switch (class)
                            {
                            case IDCMP_CLOSEWINDOW:
                                cleanexit(EXIT_SUCCESS);
                            acase IDCMP_RAWKEY:
                                if (!(qual & IEQUALIFIER_REPEAT))
                                {   if (code == SCAN_ESCAPE)
                                    {   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                                        {   if (verify())
                                            {   cleanexit(EXIT_SUCCESS);
                                        }   }
                                        else
                                        {   a = GAMEOVER;
                                            done = aborted = TRUE;
                                            worm[0].lives = worm[1].lives = worm[2].lives = worm[3].lives = 0;
                                    }   }
                                    elif (code == SCAN_M)
                                    {   toggle(SCAN_M);
                                    } elif (code == SCAN_F)
                                    {   toggle(SCAN_F);
                                    } elif (code == SCAN_P)
                                    {   say(LLL( MSG_UNPAUSED, "Unpaused"), WHITE);
                                        done = TRUE;
                                }   }
                            acase IDCMP_MENUPICK:
                                done = handlemenus(code);
                        }   }

#ifdef __amigaos4__
                        rc = handle_applibport(FALSE);
                        if (rc == 1 || (rc == 3 && verify()))
                        {   cleanexit(EXIT_SUCCESS);
                        }
#endif
                    }
                    Forbid();
                    MainWindowPtr->Flags |= WFLG_RMBTRAP;
                    Permit();
                acase SCAN_ESCAPE:
                    if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    {   if (verify())
                            cleanexit(EXIT_SUCCESS);
                    } else
                    {   a = GAMEOVER;
                        aborted = TRUE;
                        worm[0].lives = worm[1].lives = worm[2].lives = worm[3].lives = 0;
                    }
                adefault:
                    for (which = 0; which <= NUMKEYS; which++)
                    {   if (code == key[which].scancode)
                        {   key[which].down = TRUE;
            }   }   }   }
        acase IDCMP_CLOSEWINDOW:
            cleanexit(EXIT_SUCCESS);
        acase IDCMP_REFRESHWINDOW:
            GT_BeginRefresh(MainWindowPtr);
            GT_EndRefresh(MainWindowPtr, TRUE);
    }   }

    for (which = 0; which <= NUMKEYS; which++)
    {   if (key[which].down)
        {   if (key[which].special == ONEHUMAN)
            {   if (worm[0].control == KEYBOARD && worm[1].control != KEYBOARD)
                {   wormqueue(0, key[which].deltax, key[which].deltay);
                } elif (worm[1].control == KEYBOARD)
                {   wormqueue(1, key[which].deltax, key[which].deltay);
            }   }
            elif (key[which].special == MOVE || key[which].special == AMMO)
            {   if (worm[key[which].player].control == KEYBOARD)
                {   keyplayer = key[which].player;
                } elif
                (   key[which].player == 1
                 && (worm[0].control == KEYBOARD && worm[1].control != KEYBOARD)
                )
                {   keyplayer = 0;
                } elif
                (   key[which].player == 0
                 && (worm[1].control == KEYBOARD && worm[0].control != KEYBOARD)
                )
                {   keyplayer = 1;
                } else keyplayer = -1;
                if (keyplayer != -1)
                {   wormqueue(keyplayer, key[which].deltax, key[which].deltay);
            }   }
            else
            {   // assert(key[which].special == TRAINER);
                train(key[which].scancode);
}   }   }   }

EXPORT void renderhiscores_amiga(void)
{   SBYTE which;
    TEXT  tempstring[NAMELENGTH + 1];

 /* #################################################### # = shadow
    #   #   #   #                      #     #         % % = shine
    #   #   #   #                      #     #         %
    #   #   #   #                      #     #         %
    #   #   #   #                      #     #         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

    hiframe = 0;
    SetDrMd(MainWindowPtr->RPort, JAM1);
    for (which = 0; which <= HISCORES; which++)
    {   if (hiscore[difficulty][which].player == -1)
        {   SetAPen(MainWindowPtr->RPort, remapit[LIGHTGREY]);
        } else
        {   SetAPen(MainWindowPtr->RPort, (ULONG) remapit[worm[hiscore[difficulty][which].player].colour]);
        }
        RectFill
        (   MainWindowPtr->RPort,
            CENTREXPIXEL - 220,
            YSTART + 134 + (which * HISCOREDISTANCE),
            CENTREXPIXEL + 220,
            YSTART + 146 + (which * HISCOREDISTANCE)
        );
        if (hiscore[difficulty][which].player == 0)
            SetAPen(MainWindowPtr->RPort, remapit[DARKGREEN]);
        elif (hiscore[difficulty][which].player == 1)
            SetAPen(MainWindowPtr->RPort, remapit[DARKRED]);
        elif (hiscore[difficulty][which].player == 2)
            SetAPen(MainWindowPtr->RPort, remapit[DARKBLUE]);
        elif (hiscore[difficulty][which].player == 3)
            SetAPen(MainWindowPtr->RPort, remapit[DARKYELLOW]);
        else SetAPen(MainWindowPtr->RPort, remapit[DARKGREY]);
        Move(MainWindowPtr->RPort, CENTREXPIXEL - 221, YSTART + 147 + (which * HISCOREDISTANCE));
        Draw(MainWindowPtr->RPort, CENTREXPIXEL - 221, YSTART + 133 + (which * HISCOREDISTANCE));
        Draw(MainWindowPtr->RPort, CENTREXPIXEL + 221, YSTART + 133 + (which * HISCOREDISTANCE));

        if (hiscore[difficulty][which].player != -1)
        {   /* divider bars */

            Move(MainWindowPtr->RPort, CENTREXPIXEL - 197, YSTART + 133 + (which * HISCOREDISTANCE));
            Draw(MainWindowPtr->RPort, CENTREXPIXEL - 197, YSTART + 146 + (which * HISCOREDISTANCE));
            Move(MainWindowPtr->RPort, CENTREXPIXEL - 125, YSTART + 133 + (which * HISCOREDISTANCE));
            Draw(MainWindowPtr->RPort, CENTREXPIXEL - 125, YSTART + 146 + (which * HISCOREDISTANCE));
            Move(MainWindowPtr->RPort, CENTREXPIXEL -  81, YSTART + 133 + (which * HISCOREDISTANCE));
            Draw(MainWindowPtr->RPort, CENTREXPIXEL -  81, YSTART + 146 + (which * HISCOREDISTANCE));
            Move(MainWindowPtr->RPort, CENTREXPIXEL +  96, YSTART + 133 + (which * HISCOREDISTANCE));
            Draw(MainWindowPtr->RPort, CENTREXPIXEL +  96, YSTART + 146 + (which * HISCOREDISTANCE));
            Move(MainWindowPtr->RPort, CENTREXPIXEL + 146, YSTART + 133 + (which * HISCOREDISTANCE));
            Draw(MainWindowPtr->RPort, CENTREXPIXEL + 146, YSTART + 146 + (which * HISCOREDISTANCE));
        }
        SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
        Move(MainWindowPtr->RPort, CENTREXPIXEL - 221, YSTART + 147 + (which * HISCOREDISTANCE));
        Draw(MainWindowPtr->RPort, CENTREXPIXEL + 221, YSTART + 147 + (which * HISCOREDISTANCE));
        Draw(MainWindowPtr->RPort, CENTREXPIXEL + 221, YSTART + 134 + (which * HISCOREDISTANCE));
        SetAPen(MainWindowPtr->RPort, remapit[BLACK]);

        if (hiscore[difficulty][which].player == -1)
        {   Squares.ImageData = SquaresData[METAL];
        } else
        {   stcl_d(tempstring, which + 1);
            tempstring[1] = '.';
            Move(MainWindowPtr->RPort, CENTREXPIXEL - 218, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, tempstring, 2);
            stcl_d(tempstring, (int) hiscore[difficulty][which].score);
            align(tempstring, 7, ' ');
            Move(MainWindowPtr->RPort, CENTREXPIXEL - 186, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, tempstring, 7);
            if (hiscore[difficulty][which].level == -1)
            {   strcpy(tempstring, LLL(MSG_ALL, "All"));
            } else
            {   stcl_d(tempstring, hiscore[difficulty][which].level);
            }
            align(tempstring, 4, ' ');

            Move(MainWindowPtr->RPort, CENTREXPIXEL - 118, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, tempstring, 4);
            Move(MainWindowPtr->RPort, CENTREXPIXEL -  75, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, hiscore[difficulty][which].name, strlen(hiscore[difficulty][which].name));
            Move(MainWindowPtr->RPort, CENTREXPIXEL + 102, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, hiscore[difficulty][which].time, strlen(hiscore[difficulty][which].time));
            Move(MainWindowPtr->RPort, CENTREXPIXEL + 152, YSTART + 143 + (which * HISCOREDISTANCE));
            DISCARD Text(MainWindowPtr->RPort, hiscore[difficulty][which].date, strlen(hiscore[difficulty][which].date));

            Squares.ImageData = SquaresData[missileframes[hiscore[difficulty][which].player][0]];
        }
        DrawImage(MainWindowPtr->RPort, &Squares, CENTREXPIXEL + 224, YSTART + 134 + (which * HISCOREDISTANCE));
    }
    SetDrMd(MainWindowPtr->RPort, JAM2);
}

EXPORT void hiscorenames(void)
{   ULONG                class;
    FLAG                 done;
    SBYTE                which;
    struct IntuiMessage* MsgPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    for (which = 0; which <= HISCORES; which++)
    {   if (hiscore[difficulty][which].fresh)
        {   GT_SetGadgetAttrs
            (   StringGadgetPtr[which],
                MainWindowPtr,
                NULL,
                GA_Disabled, FALSE,
                GTST_String, (ULONG) worm[hiscore[difficulty][which].player].name,
            TAG_DONE);
            DISCARD ActivateGadget(StringGadgetPtr[which], MainWindowPtr, NULL);

            done = FALSE;
            while (!done)
            {   if
                (   Wait
                    (   (1 << MainWindowPtr->UserPort->mp_SigBit)
                      | AppLibSignal
                      | SIGBREAKF_CTRL_C
                    ) & SIGBREAKF_CTRL_C
                )
                {   cleanexit(EXIT_SUCCESS);
                }

                while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
                {   class = MsgPtr->Class;
                    GT_ReplyIMsg(MsgPtr);
                    switch (class)
                    {
                    case IDCMP_GADGETUP:
                        done = TRUE;
                    acase IDCMP_MOUSEBUTTONS:
                        DISCARD ActivateGadget(StringGadgetPtr[which], MainWindowPtr, NULL);
                    acase IDCMP_REFRESHWINDOW:
                        GT_BeginRefresh(MainWindowPtr);
                        GT_EndRefresh(MainWindowPtr, TRUE);
                }   }

#ifdef __amigaos4__
                rc = handle_applibport(FALSE);
                if (rc == 1 || (rc == 3 && verify()))
                {   cleanexit(EXIT_SUCCESS);
                }
#endif
            }

            GT_SetGadgetAttrs(StringGadgetPtr[which], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
            effect(FXAPPLAUSE);
            strcpy(hiscore[difficulty][which].name, (char*) ((struct StringInfo*) (StringGadgetPtr[which]->SpecialInfo))->Buffer);
            if (hiscore[difficulty][which].name[0] >= 'a' && hiscore[difficulty][which].name[0] <= 'z')
            {   hiscore[difficulty][which].name[0] -= 32;
            }
            strcpy(worm[hiscore[difficulty][which].player].name, hiscore[difficulty][which].name);
            hiscore[difficulty][which].fresh = FALSE;
            renderhiscores_amiga();
}   }   }

EXPORT void resettime(void)
{   millielapsed = 0;

    srand((unsigned int) time(NULL));
}

#define RUNDOWNX           (FIELDCENTREXPIXEL - 176)
#define RUNDOWNX_1ST       32
#define RUNDOWNX_2ND       (32 + (fontx * 20))
#define RUNDOWNX_3RD       (32 + (fontx * 27))
#define RUNDOWNX_4TH       (32 + (fontx * 34))
#define RUNDOWNY           (FIELDCENTREYPIXEL - 32)
#define RUNDOWNY_2ND       12
#define RUNSTRINGLENGTH    33

EXPORT void outro(void)
{   TEXT                 tempstring[6],
                         runstring[5][RUNSTRINGLENGTH + 1];
    int                  cornerx, cornery,
                         i,
                         whichstat = 0,
                         x, y;
    UWORD                code, qual;
    ULONG                class;
    struct IntuiMessage* MsgPtr;

    sprintf
    (   runstring[0],
        "%18s:   ## %s #### =",
        LLL(MSG_LEVELBONUS,  "Level Bonus"),
        LLL(MSG_MULTIPLIER,  "×")
    );
    sprintf
    (   runstring[1],
        "%18s:   ## %s #### =",
        LLL(MSG_NUMBERBONUS, "Number Bonus"),
        LLL(MSG_MULTIPLIER,  "×")
    );
    sprintf
    (   runstring[2],
        "%18s: #:## %s #### =",
        LLL(MSG_TIMEBONUS,   "Time Bonus"),
        LLL(MSG_MULTIPLIER,  "×")
    );
    sprintf
    (   runstring[3],
        "%18s:   ## %s #### =",
        LLL(MSG_DIMBONUS,    "Dim Bonus"),
        LLL(MSG_MULTIPLIER,  "×")
    );
    sprintf
    (   runstring[4],
        "%18s:   ## %s #### =",
        LLL(MSG_GLOWBONUS,   "Glow Bonus"),
        LLL(MSG_MULTIPLIER,  "×")
    );

    ami_drawbox(RUNDOWNX, RUNDOWNY, 352, 66);
    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    RectFill
    (   MainWindowPtr->RPort,
        RUNDOWNX +   1,
        RUNDOWNY +   1,
        RUNDOWNX + 350,
        RUNDOWNY +  64
    );
    SetAPen(MainWindowPtr->RPort, remapit[worm[showing].colour]);

    cornerx = RUNDOWNX - 17;
    cornery = RUNDOWNY - 15;

    for (x = 1; x < 31; x++)
    {   raw_draw(cornerx + ( x * SQUAREX), cornery                , GG_W_E + (showing * 58));
        raw_draw(cornerx + ( x * SQUAREX), cornery + (7 * SQUAREY), GG_W_E + (showing * 58));
    }
    for (y = 1; y < 7; y++)
    {   raw_draw(cornerx                 , cornery + (y * SQUAREY), GG_N_S + (showing * 58));
        raw_draw(cornerx + (31 * SQUAREX), cornery + (y * SQUAREY), GG_N_S + (showing * 58));
    }
    raw_draw(    cornerx                 , cornery                , GG_E_S + (showing * 58));
    raw_draw(    cornerx                 , cornery + (7 * SQUAREY), GG_N_E + (showing * 58));
    raw_draw(    cornerx + (31 * SQUAREX), cornery                , GG_W_S + (showing * 58));
    raw_draw(    cornerx + (31 * SQUAREX), cornery + (7 * SQUAREY), GG_N_W + (showing * 58));

    raw_draw(   RUNDOWNX +   8           , RUNDOWNY + 3           , TREASURE);
    if (worm[showing].numbers == 0)
    {   raw_draw(RUNDOWNX +  8           , RUNDOWNY + 3 + SQUAREY , FIRSTPAIN + showing);
    } else
    {   raw_draw(RUNDOWNX +  8           , RUNDOWNY + 3 + SQUAREY , FIRSTNUMBER + worm[showing].numbers - 1);
    }
    raw_draw(   RUNDOWNX +   8           , RUNDOWNY + 3 + (2 * SQUAREY), CLOCK);
    raw_draw(   RUNDOWNX +   8           , RUNDOWNY + 3 + (3 * SQUAREY), FIRSTTAIL + showing);
    raw_draw(   RUNDOWNX +   8           , RUNDOWNY + 3 + (4 * SQUAREY), FIRSTGLOW + showing);

    for (i = 0; i <= 4; i++)
    {   Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_1ST, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * i));
        DISCARD Text(MainWindowPtr->RPort, runstring[i], RUNSTRINGLENGTH);
        if (i == 2)
        {   if (quantity[2][0])
            {   tempstring[0] = 48 + (quantity[2][0] / 60);
                tempstring[1] = ':';
                if (quantity[2][0] % 60)
                {   tempstring[2] = 48 + ((quantity[2][0] % 60) / 10);
                    tempstring[3] = 48 + ((quantity[2][0] % 60) % 10);
                } else
                {   tempstring[2] =
                    tempstring[3] = '0';
            }   }
            else
            {   strcpy(tempstring, "0:00");
        }   }
        else
        {   stcl_d(tempstring, (int) quantity[i][0]);
            align(tempstring, 4, ' ');
        }
        Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_2ND, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * i));
        DISCARD Text(MainWindowPtr->RPort, tempstring, 4);
        stcl_d(tempstring, (int) quantity[i][1]);
        align(tempstring, 4, ' ');
        Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_3RD, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * i));
        DISCARD Text(MainWindowPtr->RPort, tempstring, 4);
    }

    for (i = 0; i <= 4; i++)
    {   stcl_d(tempstring, (int) quantity[i][2]);
        align(tempstring, 5, ' ');
        Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_4TH, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * i));
        DISCARD Text(MainWindowPtr->RPort, tempstring, 5);
    }

    for (;;)
    {   // it would be better to sleep until we are signalled
        if ((MsgPtr = (struct IntuiMessage*) GetMsg(MainWindowPtr->UserPort)))
        {   class  = MsgPtr->Class;
            code   = MsgPtr->Code;
            qual   = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            if (class == IDCMP_RAWKEY && (!(qual & IEQUALIFIER_REPEAT)) && code < KEYUP)
            {   wormscore_unscaled
                (   showing,
                  + quantity[0][2]
                  + quantity[1][2]
                  + quantity[2][2]
                  + quantity[3][2]
                  + quantity[4][2]
                );
                quantity[0][2] =
                quantity[1][2] =
                quantity[2][2] =
                quantity[3][2] =
                quantity[4][2] = 0;
                for (i = 0; i <= 4; i++)
                {   stcl_d(tempstring, (int) quantity[i][2]);
                    align(tempstring, 5, ' ');
                    Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_4TH, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * i));
                    DISCARD Text(MainWindowPtr->RPort, tempstring, 5);
                }
                return;
            } elif (class == IDCMP_INTUITICKS)
            {   effect(FXCLICK);
                if (quantity[whichstat][2])
                {   if (quantity[whichstat][2] >= 1000)
                    {   quantity[whichstat][2] -= 1000;
                        wormscore_unscaled(showing, 1000);
                    } elif (quantity[whichstat][2] >= 100)
                    {   quantity[whichstat][2] -= 100;
                        wormscore_unscaled(showing, 100);
                    } elif (quantity[whichstat][2] >= 10)
                    {   quantity[whichstat][2] -= 10;
                        wormscore_unscaled(showing, 10);
                    } elif (quantity[whichstat][2] >= 1)
                    {   quantity[whichstat][2]--;
                        wormscore_unscaled(showing, 1);
                    }

                    stcl_d(tempstring, (int) quantity[whichstat][2]);
                    align(tempstring, 5, ' ');
                    Move(MainWindowPtr->RPort, RUNDOWNX + RUNDOWNX_4TH, RUNDOWNY + RUNDOWNY_2ND + (SQUAREY * whichstat));
                    DISCARD Text(MainWindowPtr->RPort, tempstring, 5);
                } elif (whichstat == 4)
                {   return;
                } else
                {   whichstat++;
}   }   }   }   }

EXPORT void intro(void)
{   TEXT  tempstring[80 + 1];
    int   i;
    char* stringptr /* = NULL */ ;

    // showing = 5;

    Forbid();
    MainWindowPtr->Flags |= WFLG_RMBTRAP;
    Permit();

    if (level <= TUTORIALS)
    {   ami_drawbox
        (   FIELDCENTREXPIXEL - 253,
            FIELDCENTREYPIXEL - 201,
            506,
            124
        );
#ifdef BLACKBG
        SetAPen(MainWindowPtr->RPort, remapit[MEDIUMGREY]);
#else
        SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
#endif
        RectFill
        (   MainWindowPtr->RPort,
            FIELDCENTREXPIXEL - 252,
            FIELDCENTREYPIXEL - 200,
            FIELDCENTREXPIXEL + 251,
            FIELDCENTREYPIXEL -  79
        );
    }
    ami_drawbox
    (   FIELDCENTREXPIXEL - 237,
        FIELDCENTREYPIXEL - 26,
        474,
        67
    );
#ifdef BLACKBG
    SetAPen(MainWindowPtr->RPort, remapit[MEDIUMGREY]);
#else
    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
#endif
    RectFill
    (   MainWindowPtr->RPort,
        FIELDCENTREXPIXEL - 236,
        FIELDCENTREYPIXEL -  25,
        FIELDCENTREXPIXEL + 236 - 1,
        FIELDCENTREYPIXEL +  40 - 1
    );
    SetAPen(MainWindowPtr->RPort, remapit[WHITE]);

    for (i = 0; i <= SPECIES; i++)
    {   if (creatureinfo[i].introlevel == level)
        {   raw_draw(INTROTILEX, INTROY + 3 + (2 * SQUAREY), creatureinfo[i].symbol);
            break; // for speed
    }   }
    for (i = 0; i <= LASTOBJECT; i++)
    {   if (objectinfo[i].introlevel == level)
        {   raw_draw(INTROTILEX, INTROY + 3 + (3 * SQUAREY), i);
            break; // for speed
    }   }
    if (level < LASTFRUIT - FIRSTFRUIT + 1)
    {   raw_draw(    INTROTILEX, INTROY + 3 + (4 * SQUAREY), level + FIRSTFRUIT - 1);
    }

    if (level >= 1 && level <= TUTORIALS)
    {   stringptr = getintrotext(); // sets up stringptr
        dotext
        (   FIELDCENTREXPIXEL - (strlen(stringptr) * (fontx / 2)),
            INTROY - (SQUAREY * 13),
            stringptr
        );
    }

    stringptr = LLL(MSG_INTRODUCING, "Introducing:");
    dotext(INTROTEXTX, INTROY + (SQUAREY * 2), stringptr);
    for (i = 0; i <= SPECIES; i++)
    {   if (creatureinfo[i].introlevel == level)
        {   dotext(INTROTEXTX, INTROY + (SQUAREY * 3), creatureinfo[i].name);
            break; // for speed
    }   }
    for (i = 0; i <= LASTOBJECT; i++)
    {   if (objectinfo[i].introlevel == level)
        {   dotext(INTROTEXTX, INTROY + (SQUAREY * 4), objectinfo[i].desc);
            break; // for speed
    }   }
    if (level < LASTFRUIT - FIRSTFRUIT + 1)
    {   sprintf
        (   tempstring,
            "%s: %d %s.",
            fruitname[level - 1],
            POINTS_FRUIT * level,
            LLL(MSG_POINTS2, "points")
        );
        dotext(INTROTEXTX, INTROY + (SQUAREY * 5), tempstring);
    }

    saylevel(WHITE);
}

EXPORT void say(STRPTR sentence, COLOUR colour)
{   SWORD length  = (SBYTE) strlen(sentence),
          centrex;

    centrex = (SWORD) STARTXPIXEL + ((ENDXPIXEL - STARTXPIXEL) / 2);

    /* truncate text */
    if (length > SAYLIMIT)
    {   *(sentence + SAYLIMIT) = EOS;
        length = SAYLIMIT;
    }

    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    RectFill
    (   MainWindowPtr->RPort,
        STARTXPIXEL,
        STARTYPIXEL - 14,
        ENDXPIXEL,
        STARTYPIXEL -  1
    );

    /* render shadow text */
    SetAPen(MainWindowPtr->RPort, remapit[MEDIUMGREY]);
    Move(MainWindowPtr->RPort, centrex - (length * fontx / 2) + 1, STARTYPIXEL - 4);
    DISCARD Text(MainWindowPtr->RPort, sentence, (ULONG) length);

    /* render actual text */
    SetDrMd(MainWindowPtr->RPort, JAM1);
    SetAPen(MainWindowPtr->RPort, remapit[colour]);
    Move(MainWindowPtr->RPort, centrex - (length * fontx / 2)    , STARTYPIXEL - 5);
    DISCARD Text(MainWindowPtr->RPort, sentence, (ULONG) length);
    SetDrMd(MainWindowPtr->RPort, JAM2);
}

EXPORT void printstat(int player, int theline)
{   if (superturbo)
    {   return;
    }

    Move
    (   MainWindowPtr->RPort,
        xoffset + 24,
        STARTYPIXEL + (player * SQUAREY * 10) + 8 + (theline * SQUAREY)
    );
    DISCARD Text(MainWindowPtr->RPort, stattext, 7);
}

EXPORT void stopfx(void)
{   int i;

    for (i = 0; i <= 3; i++)
    {   if (eversent[i] && AudioRqPtr[i])
        {   AbortIO((struct IORequest*) AudioRqPtr[i]);
            WaitIO( (struct IORequest*) AudioRqPtr[i]);
}   }   }

MODULE void titlescreen(void)
{   SBYTE                i,
                         player;
    ULONG                class;
    UWORD                code, qual;
    TEXT                 tempstring[80 + 1];
    struct IntuiMessage* MsgPtr;
    struct Gadget*       WhichGadgetPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    a = TITLESCREEN;

    Forbid();
    MainWindowPtr->Flags &= ~WFLG_RMBTRAP;
    Permit();
    if (!(ModifyIDCMP // add vanilla keys
    (   MainWindowPtr,
        IDCMP_VANILLAKEY
      | IDCMP_RAWKEY
      | IDCMP_MOUSEBUTTONS
      | IDCMP_CLOSEWINDOW
      | IDCMP_ACTIVEWINDOW
      | IDCMP_MENUPICK
      | IDCMP_MENUVERIFY
      | IDCMP_REFRESHWINDOW
      | IDCMP_INTUITICKS
      | CYCLEIDCMP
      | CHECKBOXIDCMP
      | BUTTONIDCMP
      | STRINGIDCMP
    )))
    {   rq("ModifyIDCMP() failed!");
    }

    clearscreen();
    drawlogo();

    DISCARD SetMenuStrip(MainWindowPtr, MenuPtr);
    if (AmigaGuideBase)
    {   OnMenu( MainWindowPtr, FULLMENUNUM(MN_HELP   , IN_MANUAL       , NOSUB));
    }
    if (!customscreen)
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_VIEWTITLEBAR , NOSUB));
    }
    OffMenu(    MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE    , NOSUB));
    updatemenu();

    for (player = 0; player <= 3; player++)
    {   GT_SetGadgetAttrs(CycleGadgetPtr[player], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
    }
    GT_SetGadgetAttrs(   ShuffleGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
    GT_SetGadgetAttrs(DifficultyGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
    GT_SetGadgetAttrs(     SoundGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCY_Active, (ULONG) soundmode, TAG_DONE);
    GT_SetGadgetAttrs( LevelEditGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
    GT_SetGadgetAttrs(     StartGadgetPtr, MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
    RefreshGadgets(GListPtr, MainWindowPtr, NULL);
    SetDrMd(MainWindowPtr->RPort, JAM1);

    strcpy(tempstring, LLL(MSG_WORM1, "Worm _1:"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx), 239, tempstring, GREEN );

    strcpy(tempstring, LLL(MSG_WORM2, "Worm _2:"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx), 252, tempstring, RED   );

    strcpy(tempstring, LLL(MSG_WORM3, "Worm _3:"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx), 265, tempstring, BLUE  );

    strcpy(tempstring, LLL(MSG_WORM4, "Worm _4:"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx), 278, tempstring, YELLOW);

    strcpy(tempstring, LLL(MSG_SHUFFLE, "_Shuffle Levels?"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx) + 192 - 26, 304, tempstring, WHITE);

    strcpy(tempstring, LLL(MSG_DIFFICULTY, "_Difficulty:"));
    ww_shadowtext(CENTREXPIXEL - (( 9 + strlen(tempstring)) * fontx), 330, tempstring, WHITE);

    strcpy(tempstring, LLL(MSG_SOUND2, "Sound:"));
    ww_shadowtext(CENTREXPIXEL - ((10 + strlen(tempstring)) * fontx), 343, tempstring, WHITE);

    clearkybd();
    renderhiscores_amiga();
    hiscorenames();
    updatemenu(); // because "Edit|Clear high scores" may need unghosting
    playsong(SONG_TITLE);

    do
    {   if
        (   Wait
            (   (1 << MainWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   WhichGadgetPtr = (struct Gadget*) MsgPtr->IAddress;
            class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_VANILLAKEY:
                if (!(qual & IEQUALIFIER_REPEAT))
                {   switch (code)
                    {
                    case 'F':
                    case 'f':
                        toggle(SCAN_F);
                    acase 'M':
                    case 'm':
                        toggle(SCAN_M);
                    acase ' ':
                        a = LEVELEDIT;
                    acase '1':
                        effect(FXCLICK);
                        if (worm[0].control == 4)
                        {   worm[0].control = 0;
                        } else
                        {   worm[0].control++;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[0], MainWindowPtr, NULL, GTCY_Active, worm[0].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '2':
                        effect(FXCLICK);
                        if (worm[1].control == 4)
                        {   worm[1].control = 0;
                        } else
                        {   worm[1].control++;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[1], MainWindowPtr, NULL, GTCY_Active, worm[1].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '3':
                        effect(FXCLICK);
                        if (worm[2].control == 3)
                        {   worm[2].control = 0;
                        } else
                        {   worm[2].control++;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[2], MainWindowPtr, NULL, GTCY_Active, worm[2].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '4':
                        effect(FXCLICK);
                        if (worm[3].control == 3)
                        {   worm[3].control = 0;
                        } else
                        {   worm[3].control++;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[3], MainWindowPtr, NULL, GTCY_Active, worm[3].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '!':
                        effect(FXCLICK);
                        if (worm[0].control == 0)
                        {   worm[0].control = 4;
                        } else
                        {   worm[0].control--;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[0], MainWindowPtr, NULL, GTCY_Active, worm[0].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '@':
                    case '\"': // for UK users
                        effect(FXCLICK);
                        if (worm[1].control == 0)
                        {   worm[1].control = 4;
                        } else
                        {   worm[1].control--;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[1], MainWindowPtr, NULL, GTCY_Active, worm[1].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '#':
                        effect(FXCLICK);
                        if (worm[2].control == 0)
                        {   worm[2].control = 3;
                        } else
                        {   worm[2].control--;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[2], MainWindowPtr, NULL, GTCY_Active, worm[2].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase '$':
                        effect(FXCLICK);
                        if (worm[3].control == 0)
                        {   worm[3].control = 3;
                        } else
                        {   worm[3].control--;
                        }
                        GT_SetGadgetAttrs(CycleGadgetPtr[3], MainWindowPtr, NULL, GTCY_Active, worm[3].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase 13: // RETURN or ENTER
                        a = PLAYGAME;
                    acase 27: // ESCape
                        if (verify())
                        {   cleanexit(EXIT_SUCCESS);
                        }
                    adefault:
                        if (code == d_shortcut || code == tolower(d_shortcut))
                        {   effect(FXCLICK);
                            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                            {   if (difficulty == 0)
                                {   difficulty = 3;
                                } else
                                {   difficulty--;
                            }   }
                            else
                            {   if (difficulty == 3)
                                {   difficulty = 0;
                                } else
                                {   difficulty++;
                            }   }
                            GT_SetGadgetAttrs(DifficultyGadgetPtr, MainWindowPtr, NULL, GTCY_Active, difficulty, TAG_DONE);
                            renderhiscores_amiga();
                        } elif (code == s_shortcut || code == tolower(s_shortcut))
                        {   effect(FXCLICK);
                            shuffle = !shuffle;
                            GT_SetGadgetAttrs(ShuffleGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, shuffle, TAG_DONE);
                }   }   }
            acase IDCMP_RAWKEY:
                if (!(qual & IEQUALIFIER_REPEAT))
                {   switch (code)
                    {
                    case SCAN_F1:
                        effect(FXCLICK);
                        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        {   if (worm[0].control == 0)
                            {   worm[0].control = 4;
                            } else
                            {   worm[0].control--;
                        }   }
                        else
                        {   if (worm[0].control == 4)
                            {   worm[0].control = 0;
                            } else
                            {   worm[0].control++;
                        }   }
                        GT_SetGadgetAttrs(CycleGadgetPtr[0], MainWindowPtr, NULL, GTCY_Active, worm[0].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase SCAN_F2:
                        effect(FXCLICK);
                        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        {   if (worm[1].control == 0)
                            {   worm[1].control = 4;
                            } else
                            {   worm[1].control--;
                        }   }
                        else
                        {   if (worm[1].control == 4)
                            {   worm[1].control = 0;
                            } else
                            {   worm[1].control++;
                        }   }
                        GT_SetGadgetAttrs(CycleGadgetPtr[1], MainWindowPtr, NULL, GTCY_Active, worm[1].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase SCAN_F3:
                        effect(FXCLICK);
                        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        {   if (worm[2].control == 0)
                            {   worm[2].control = 3;
                            } else
                            {   worm[2].control--;
                        }   }
                        else
                        {   if (worm[2].control == 3)
                            {   worm[2].control = 0;
                            } else
                            {   worm[2].control++;
                        }   }
                        GT_SetGadgetAttrs(CycleGadgetPtr[2], MainWindowPtr, NULL, GTCY_Active, worm[2].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase SCAN_F4:
                        effect(FXCLICK);
                        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        {   if (worm[3].control == 0)
                            {   worm[3].control = 3;
                            } else
                            {   worm[3].control--;
                        }   }
                        else
                        {   if (worm[3].control == 3)
                            {   worm[3].control = 0;
                            } else
                            {   worm[3].control++;
                        }   }
                        GT_SetGadgetAttrs(CycleGadgetPtr[3], MainWindowPtr, NULL, GTCY_Active, worm[3].control, TAG_DONE);
                        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                    acase SCAN_HELP:
                        if (AmigaGuideBase)
                        {   help_manual();
                }   }   }
            acase IDCMP_MENUPICK:
                DISCARD handlemenus(code);
            acase IDCMP_MOUSEBUTTONS:
                if (code == SELECTDOWN && ignore)
                {   ignore = FALSE;
                }
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(MainWindowPtr);
                GT_EndRefresh(MainWindowPtr, TRUE);
            acase IDCMP_GADGETUP:
                if     (WhichGadgetPtr == ShuffleGadgetPtr)
                {   shuffle = !shuffle;
                } elif (WhichGadgetPtr == DifficultyGadgetPtr)
                {   difficulty = (ULONG) code;
                    renderhiscores_amiga();
                } elif (WhichGadgetPtr == SoundGadgetPtr)
                {   switch (code)
                    {
                    case SOUNDMODE_NONE:
                        if     (soundmode == SOUNDMODE_FX)
                        {   toggle(SCAN_F);
                        } elif (soundmode == SOUNDMODE_MUSIC)
                        {   toggle(SCAN_M);
                        }
                    acase SOUNDMODE_FX:
                        if (soundmode != SOUNDMODE_FX)
                        {   toggle(SCAN_F);
                        }
                    acase SOUNDMODE_MUSIC:
                        if (soundmode != SOUNDMODE_MUSIC)
                        {   toggle(SCAN_M);
                }   }   }
                elif   (WhichGadgetPtr == StartGadgetPtr)
                {   a = PLAYGAME;
                } elif (WhichGadgetPtr == LevelEditGadgetPtr)
                {   a = LEVELEDIT;
                } else
                {   for (player = 0; player <= 3; player++)
                    {   if (WhichGadgetPtr == CycleGadgetPtr[player])
                        {   worm[player].control = (UBYTE) code;
                            break;
                }   }   }
            acase IDCMP_ACTIVEWINDOW:
                ignore = TRUE;
            acase IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
            acase IDCMP_INTUITICKS:
                if (anims)
                {   drawboing();
                    // cyclecolours();

                    for (i = 0; i <= HISCORES; i++)
                    {   if (hiscore[difficulty][i].player == -1)
                        {   Squares.ImageData = SquaresData[METAL];
                        } else
                        {   Squares.ImageData = SquaresData[missileframes[hiscore[difficulty][i].player][hiframe]];
                            if (hiframe == MISSILEFRAMES)
                            {   hiframe = 0;
                            } else
                            {   hiframe++;
                        }   }
                        DrawImage(MainWindowPtr->RPort, &Squares, CENTREXPIXEL + 224, YSTART + 134 + (i * HISCOREDISTANCE));
        }   }   }   }

#ifdef __amigaos4__
        rc = handle_applibport(TRUE);
        if (rc == 1 || (rc == 3 && verify()))
        {   cleanexit(EXIT_SUCCESS);
        }
#endif

        if (firebutton())
        {   a = PLAYGAME;
        }

        if (a == PLAYGAME)
        {   if (!playersactive())
            {   say(LLL( MSG_NOWORMS, "No worms active!"), WHITE);
                a = TITLESCREEN;
            } elif
            (   !LowLevelBase &&
                (worm[0].control == GAMEPAD
              || worm[1].control == GAMEPAD
              || worm[2].control == GAMEPAD
              || worm[3].control == GAMEPAD
              || worm[0].control == JOYSTICK
              || worm[1].control == JOYSTICK
              || worm[2].control == JOYSTICK
              || worm[3].control == JOYSTICK
            )   )
            {   say("Need OS3.1+ and lowlevel.library for joystick/gamepad!", WHITE);
                anykey(TRUE, TRUE);
                a = TITLESCREEN;
    }   }   }
    while (a == TITLESCREEN);

    for (player = 0; player <= 3; player++)
    {   GT_SetGadgetAttrs(CycleGadgetPtr[player], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    }
    GT_SetGadgetAttrs(ShuffleGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(DifficultyGadgetPtr, MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(SoundGadgetPtr,      MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(LevelEditGadgetPtr,  MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(StartGadgetPtr,      MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
}

EXPORT void toggle(SBYTE key)
{   PERSIST FLAG songstarted = FALSE;

    switch (key)
    {
    case SCAN_F:
        if (soundmode == SOUNDMODE_FX) /* F in FX mode: no sound */
        {   freefx();
            soundmode = SOUNDMODE_NONE;
            draw(MUSICICONX, ICONY, BLACKENED);
        } elif (fxable != FAILED) /* F otherwise: change to FX mode */
        {   if (soundmode == SOUNDMODE_MUSIC) /* stop any music that is playing */
            {   StopPlayer();
                FreePlayer();
            }
            if (fxable == DEFER) /* load samples if needed */
            {   loadthefx();
            }
            if (fxable == SUCCEEDED) /* if we have samples in memory */
            {   if (beginfx())
                {   soundmode = SOUNDMODE_FX;
                    effect(FXGET_RAIN);
                    draw(MUSICICONX, ICONY, FX);
        }   }   }
    acase SCAN_M:
        if (soundmode == SOUNDMODE_MUSIC) /* M in MUSIC mode: no sound */
        {   StopPlayer();
            FreePlayer();
            soundmode = SOUNDMODE_NONE;
            draw(MUSICICONX, ICONY, BLACKENED);
        } elif (musicable != FAILED) /* M otherwise: change to music mode */
        {   if (soundmode == SOUNDMODE_FX) /* stop any samples that are playing */
            {   freefx();
            }
            /* Of course, these statements are ordered in this
            way for a reason, so don't change it. :-) */
            if (musicable == DEFER)
            {   loadthemusic();
            }
            if (musicable == SUCCEEDED)
            {   if (GetPlayer(0))
                {   say(LLL( MSG_NOCHANNELS, "Can't allocate all channels!"), RED);
                    anykey(TRUE, a == PLAYGAME ? FALSE : TRUE);
                    soundmode = SOUNDMODE_NONE;
                    draw(MUSICICONX, ICONY, BLACKENED);
                } else
                {   if (songstarted)
                    {   ContModule(SongPtr[song]);
                    } else
                    {   PlayModule(SongPtr[song]);
                        songstarted = TRUE;
                    }
                    soundmode = SOUNDMODE_MUSIC;
                    draw(MUSICICONX, ICONY, MUSIC);
    }   }   }   }

    if (a == TITLESCREEN)
    {   GT_SetGadgetAttrs(SoundGadgetPtr, MainWindowPtr, NULL, GTCY_Active, (ULONG) soundmode, TAG_DONE);
}   }

EXPORT FLAG verify(void)
{   LONG result;

    if (autosave && (levels_modified || scores_modified))
    {   if (pathname[0] == EOS)
        {   strcpy(pathname, DEFAULTSET);
        }
        filesaveas(FALSE);
        return TRUE;
    } // implied else
    if (FindTask("MCP")) // MCP has bugs relating to EasyRequest()!
    {   return TRUE;
    } // implied else

    if (levels_modified)
    {   EasyStruct.es_TextFormat = (STRPTR) LLL(MSG_MODIFIED,       "Level data has been modified.");
    } elif (scores_modified)
    {   EasyStruct.es_TextFormat = (STRPTR) LLL(MSG_MODIFIEDSCORES, "High scores have been modified.");
    } else
    {   return TRUE;
    }
    EasyStruct.es_Title              = (STRPTR) TITLEBAR;
    EasyStruct.es_GadgetFormat       = (STRPTR) LLL(MSG_CONTINUECANCEL, "Continue|Cancel");

    result = EasyRequest(MainWindowPtr, &EasyStruct, NULL);

    // restore colours in case eg. ReqAttack has modified them
    if (customscreen)
    {   LoadRGB4(&(ScreenPtr->ViewPort), OCSColours, 16);
    }

    return (FLAG) result;
}

EXPORT void waitasec(void)
{   Delay(50);
}

EXPORT void systemsetup(void)
{   worm[0].control = NONE;
    worm[1].control = KEYBOARD;
    worm[2].control = NONE;
    worm[3].control = THEAMIGA;
}

EXPORT FLAG ZOpen(STRPTR fieldname, FLAG write)
{   if (!write)
    {   if ((FilePtr = Open(fieldname, MODE_OLDFILE)))
        {   return TRUE;
        } else
        {   return FALSE;
    }   }
    else
    {   if ((FilePtr = Open(fieldname, MODE_NEWFILE)))
        {   return TRUE;
        } else
        {   return FALSE;
}   }   }
EXPORT FLAG ZRead(UBYTE* IOBuffer, ULONG length)
{   if (Read(FilePtr, IOBuffer, (LONG) length) == (LONG) length)
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG ZWrite(UBYTE* IOBuffer, ULONG length)
{   if (Write(FilePtr, IOBuffer, (LONG) length) == (LONG) length)
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG ZClose(void)
{   if (Close(FilePtr))
    {   FilePtr = ZERO;
        return TRUE;
    } else
    {   /* "If Close() returns DOSFALSE, the user has already cancelled an
        error requester and the function has already freed the FileHandle
        (and even marked it so any attempt to close it again will bring up
        the "Software Failure" requester). Therefore FilePtr should be set
        to zero in any case." - Jilles Tjoelker. */

        FilePtr = ZERO;
        return FALSE;
}   }

EXPORT void timing(void)
{   ;
}

EXPORT void clearscreen(void)
{   FLAG shorter;
    int  player,
         sparex, sparey,
         x, y;

    sparex = (MainWindowPtr->Width  - MainWindowPtr->BorderLeft - MainWindowPtr->BorderRight ) % Background1.Width;
    sparey = (MainWindowPtr->Height - MainWindowPtr->BorderTop  - MainWindowPtr->BorderBottom) % Background1.Height;
    // assert(Background1.Height >= Background2.Height);
    if (sparey >= Background2.Height)
    {   sparey -= Background2.Height;
        shorter = TRUE;
    } else
    {   shorter = FALSE;
    }
    if (!anims || sparex || sparey)
    {
#ifdef BLACKBG
        SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
#else
       SetAPen(MainWindowPtr->RPort, remapit[MEDIUMGREY]);
#endif
        RectFill
        (   MainWindowPtr->RPort,
            xoffset,
            yoffset,
            xoffset + WindowWidth  - 1,
            yoffset + WindowHeight - 1
        );
    }
    if (anims)
    {   x = MainWindowPtr->BorderLeft + (sparex / 2);
        y = 0; // to avoid a SAS/C warning
        while (x + Background1.Width <= MainWindowPtr->Width - MainWindowPtr->BorderRight)
        {   y = MainWindowPtr->BorderTop + (sparey / 2);
            while (y + Background1.Height <= MainWindowPtr->Height - MainWindowPtr->BorderBottom)
            {   DrawImage
                (   MainWindowPtr->RPort,
                    &Background1,
                    x,
                    y
                );
                y += Background1.Height;
            }
            x += Background1.Width;
        }
        if (shorter)
        {   x = MainWindowPtr->BorderLeft + (sparex / 2);
            while (x + Background2.Width <= MainWindowPtr->Width - MainWindowPtr->BorderRight)
            {   DrawImage
                (   MainWindowPtr->RPort,
                    &Background2,
                    x,
                    y
                );
                x += Background2.Width;
    }   }   }

    if     (soundmode == SOUNDMODE_MUSIC)
    {   draw(MUSICICONX, ICONY, MUSIC);
    } elif (soundmode == SOUNDMODE_FX)
    {   draw(MUSICICONX, ICONY, FX);
    } else
    {   // assert(soundmode == SOUNDMODE_NONE);
        draw(MUSICICONX, ICONY, BLACKENED);
    }

    if (turbo)
    {   draw(CLOCKICONX, ICONY, CLOCK);
    } else
    {   draw(CLOCKICONX, ICONY, BLACKENED);
    }
    clockdrawn = turbo;

    if (first)
    {   first = FALSE;
    } else
    {   if (a != LEVELEDIT)
        {   SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
            for (player = 0; player <= 3; player++)
            {   if (worm[player].control != NONE)
                {   RectFill
                    (   MainWindowPtr->RPort,
                        xoffset + 23,
                        STARTYPIXEL + (player * SQUAREY * 10),
                        xoffset + 23 + (fontx * 7) + 3,
                        STARTYPIXEL + (player * SQUAREY * 10) + (SQUAREY * 5)
                    );
        }   }   }

        dosidebar();
}   }

EXPORT void datestamp(void)
{   ULONG            seconds, micros;
    struct ClockData Date;
    TEXT             temp[5];

    CurrentTime(&seconds, &micros);
    Amiga2Date(seconds, &Date);
    stcl_d(times, (int) Date.hour); /* hh */
    align(times, 2, ' ');
    times[2] = ':';           /* hh: */
    times[3] = 0;
    stcl_d(temp, (int) Date.min);
    align(temp, 2, '0');
    temp[2] = 0;
    strcat(times, temp);      /* hh:mm */

    stcl_d(date, (int) Date.mday);  /* dd */
    align(date, 2, ' ');
    date[2] = '/';
    date[3] = 0;              /* dd/ */
    stcl_d(temp, (int) Date.month);
    align(temp, 2, ' ');
    temp[2] = 0;
    strcat(date, temp);       /* dd/mm */
    strcat(date, "/");        /* dd/mm/ */
    stcl_d(temp, (int) Date.year);
    temp[0] = temp[2];
    temp[1] = temp[3];
    temp[2] = 0;
    strcat(date, temp);       /* dd/mm/yy */
}

EXPORT void turborender(void)
{   UBYTE random;
    int   x, y, startx, starty, endx, endy;

    // assert(a != LEVELEDIT);

    if (a != PLAYGAME || !level || !shuffle)
    {   sourcelevel = level;
    }

    changefield();

    random = rand() % 4;
    switch (random)
    {
    case 0: // horizontal bars
        starty = 0;
        endy   = fieldy;
        do
        {   for (x = 0; x <= fieldx; x++)
            {   draw(x, starty, field[x][starty]);
                draw(x, endy,   field[x][endy]);
            }
            starty++;
            endy--;
        } while (starty <= endy);
    acase 1: // vertical bars
        startx = 0;
        endx   = fieldx;
        do
        {   for (y = 0; y <= fieldy; y++)
            {   draw(startx, y, field[startx][y]);
                draw(endx,   y, field[endx  ][y]);
            }
            startx++;
            endx--;
        } while (startx <= endx);
    acase 2: // spiral from outside in
        startx =
        starty = 0;
        endx   = fieldx;
        endy   = fieldy;
        do
        {   for (x = startx; x <= endx; x++)
            {   draw(x, starty, field[x][starty]);
            }
            for (y = starty; y <= endy; y++)
            {   draw(endx, y, field[endx][y]);
            }
            for (x = endx; x >= startx; x--)
            {   draw(x, endy, field[x][endy]);
            }
            for (y = endy; y >= starty; y--)
            {   draw(startx, y, field[startx][y]);
            }
            startx++;
            endx--;
            starty++;
            endy--;
            if (startx > endx)
            {   startx = endx;
            }
            if (starty > endy)
            {   starty = endy;
            }
        } while (startx != endx || starty != endy);
    acase 3: // spiral from inside out
        startx =
        endx   = fieldx / 2;
        starty =
        endy   = fieldy / 2;
        for (;;)
        {   for (x = startx; x <= endx; x++)
            {   draw(x, starty, field[x][starty]);
            }
            for (y = starty; y <= endy; y++)
            {   draw(endx, y, field[endx][y]);
            }
            for (x = endx; x >= startx; x--)
            {   draw(x, endy, field[x][endy]);
            }
            for (y = endy; y >= starty; y--)
            {   draw(startx, y, field[startx][y]);
            }
            if (startx == 0 && endx == fieldx && starty == 0 && endy == fieldy)
            {   break;
            }
            startx--;
            endx++;
            starty--;
            endy++;
            if (startx < 0)
            {   startx = 0;
            }
            if (endx > fieldx)
            {   endx = fieldx;
            }
            if (starty < 0)
            {   starty = 0;
            }
            if (endy > fieldy)
            {   endy = fieldy;
    }   }   }

    for (y = 0; y <= fieldy; y++)
    {   draw(ARROWX, y, BLACKARROW);
    }

    ami_draw(STARTXPIXEL    , ENDYPIXEL   + 1, ENDXPIXEL    , ENDYPIXEL + 1, MEDIUMGREY); // bottom
    ami_draw(ENDXPIXEL   + 1, STARTYPIXEL    , ENDXPIXEL + 1, ENDYPIXEL + 1, MEDIUMGREY); // right
    ami_draw(STARTXPIXEL + 1, ENDYPIXEL   + 2, ENDXPIXEL + 1, ENDYPIXEL + 2, BLACK);      // bottom
    ami_draw(ENDXPIXEL   + 2, STARTYPIXEL + 1, ENDXPIXEL + 2, ENDYPIXEL + 2, BLACK);      // right
}

EXPORT void ReadAdapterJoystick(UBYTE port)
{   TRANSIENT          UBYTE  PortState[2];
    TRANSIENT          FLAG   fire            = FALSE;
    TRANSIENT          SBYTE  xx              = 0,
                              yy              = 0,
                              player;
    TRANSIENT          UBYTE  firestate,
                              movestate;
    PERSIST            UBYTE  OldPortState[2] = {0, 0};
    PERSIST   volatile UBYTE *fireaddrPtr = (UBYTE*) 0xBFD000,
                             *moveaddrPtr = (UBYTE*) 0xBFE101;

/*  These bits are all active low:
    bit 7 of $BFE101 is right of joystick '4'
    bit 6 of $BFE101 is left  of joystick '4'
    bit 5 of $BFE101 is down  of joystick '4'
    bit 4 of $BFE101 is up    of joystick '4'
    bit 3 of $BFE101 is right of joystick '3'
    bit 2 of $BFE101 is left  of joystick '3'
    bit 1 of $BFE101 is down  of joystick '3'
    bit 0 of $BFE101 is up    of joystick '3'
    bit 2 of $BFD000 is fire  of joystick '3'
    bit 0 of $BFD000 is fire  of joystick '4' */

    port -= 2;
    player = port;

    if (worm[player].control == JOYSTICK && worm[player].lives)
    {   firestate = 255 - (*fireaddrPtr);
        movestate = 255 - (*moveaddrPtr);
        PortState[port] = 0;
        if (movestate & (1 << (port * 4)))
        {   PortState[port] |= JOYUP;
        }
        if (movestate & (2 << (port * 4)))
        {   PortState[port] |= JOYDOWN;
        }
        if (movestate & (4 << (port * 4)))
        {   PortState[port] |= JOYLEFT;
        }
        if (movestate & (8 << (port * 4)))
        {   PortState[port] |= JOYRIGHT;
        }
        if (firestate & (4 >> (port * 2)))
        {   PortState[port] |= JOYFIRE1;
        }

        if (PortState[port] != OldPortState[port])
        {   if (PortState[port] & JOYUP)
            {   yy = -1;
            } elif (PortState[port] & JOYDOWN)
            {   yy = 1;
            }
            if (PortState[port] & JOYLEFT)
            {   xx = -1;
            } elif (PortState[port] & JOYRIGHT)
            {   xx = 1;
            }
            if (PortState[port] & JOYFIRE1)
            {   fire = TRUE;
            }

            if (PortState[port] != 0) // if joystick is off-centre or firebutton is down
            {   if (fire)                      // if firebutton is down
                {   wormqueue(player, 0, 0);   // then shoot/jump
                } else                         // if firebutton is up
                {   wormqueue(player, xx, yy); // then move
        }   }   }
        OldPortState[port] = PortState[port];
}   }

EXPORT void ReadStandardJoystick(ULONG port)
{   UBYTE PortState[2];
    FLAG  fire = FALSE;
    SBYTE xx   = 0,
          yy   = 0,
          player;

    if (port == 1)
    {   player = 2; // blue worm
    } else
    {   // assert(port == 0);
        player = 3; // yellow worm
    }
    if (worm[player].control == JOYSTICK && worm[player].lives)
    {   PortState[port] = ReadJoystick((UWORD) port);
        if (PortState[port] != OldStdPortState[port])
        {   if     (PortState[port] & JOYUP)
            {   yy = -1;
            } elif (PortState[port] & JOYDOWN)
            {   yy = 1;
            }
            if     (PortState[port] & JOYLEFT)
            {   xx = -1;
            } elif (PortState[port] & JOYRIGHT)
            {   xx = 1;
            }
            if     (PortState[port] & JOYFIRE1)
            {   fire = TRUE;
            }

            if (PortState[port] != 0) // if joystick is off-centre or firebutton is down
            {   if (fire)                      // if firebutton is down
                {   wormqueue(player, 0, 0);   // then shoot/jump
                } else                         // if firebutton is up
                {   wormqueue(player, xx, yy); // then move
        }   }   }
        OldStdPortState[port] = PortState[port];
}   }

EXPORT void ReadGamepads(void)
{   TRANSIENT ULONG PortState;
    TRANSIENT FLAG  fire         = FALSE;
    TRANSIENT int   i,
                    xx           = 0,
                    yy           = 0;
    PERSIST   ULONG OldPortState = 0;

    for (i = 0; i <= 3; i++)
    {   if (worm[i].control == GAMEPAD && worm[i].lives)
        {   PortState = ReadJoyPort(worm[i].port);
            if (PortState != OldPortState)
            {   if (PortState & JP_BUTTON_MASK)
                {   fire = TRUE;
                }
                if (PortState & JPF_JOY_UP)
                {   yy = -1;
                } elif (PortState & JPF_JOY_DOWN)
                {   yy = 1;
                }
                if (PortState & JPF_JOY_LEFT)
                {   xx = -1;
                } elif (PortState & JPF_JOY_RIGHT)
                {   xx = 1;
                }
                if (fire)                 // if firebutton is down
                {   wormqueue(i, 0, 0);   // then shoot/jump
                } elif (xx || yy)
                {   wormqueue(i, xx, yy);
            }   }
            OldPortState = PortState;
}   }   }

EXPORT void whiteline(void)
{    SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
}
EXPORT void colourline(int player)
{    SetAPen(MainWindowPtr->RPort, remapit[worm[player].colour]);
}

EXPORT void playsong(UBYTE whichsong)
{   if (song != whichsong)
    {   song = whichsong;

        if (soundmode == SOUNDMODE_MUSIC && musicable)
        {   StopPlayer();
            PlayModule(SongPtr[song]);
}   }   }

EXPORT void dotext(int x, int y, STRPTR thestring)
{   Move(MainWindowPtr->RPort, x, y);
    DISCARD Text(MainWindowPtr->RPort, thestring, strlen(thestring));
}

/* =======================================================================
To convert volume levels from hardware (0-64) to IFF 8SVX
    Fixed ($0-$10000): HardwareVolume * 1024 = FixedVolume

10       $2800
20       $5000
30       $7800
40       $A000
50       $C800
60       $F000
64              $10000 */

#define INTROSPEED 200 // delay between frames in msec
EXPORT void introanim(void)
{   FLAG                 done;
    UWORD                code, qual;
    ULONG                class,
                         newtime,
                         oldtime;
    struct IntuiMessage* MsgPtr;
    struct timeval       newtimeval,
                         oldtimeval;
#ifdef __amigaos4__
    struct TimeVal       NewTimeVal,
                         OldTimeVal;
#endif

    if (!MainWindowPtr)
    {   return;
    }

    if (!(ModifyIDCMP // remove vanilla keys
    (   MainWindowPtr,
        IDCMP_RAWKEY
      | IDCMP_MOUSEBUTTONS
      | IDCMP_CLOSEWINDOW
      | IDCMP_ACTIVEWINDOW
      | IDCMP_MENUPICK
      | IDCMP_MENUVERIFY
      | IDCMP_REFRESHWINDOW
      | IDCMP_INTUITICKS
      | CYCLEIDCMP
      | CHECKBOXIDCMP
      | BUTTONIDCMP
      | STRINGIDCMP
    )))
    {   rq("ModifyIDCMP() failed!");
    }

    // assert(level <= 3);

    introframe = 0;
    for (;;)
    {   introanim_engine(introframe);
        if (introframe <= 31)
        {   introframe++;
        }

        clearkybd();
        done = FALSE;
#ifdef __amigaos4__
        GetSysTime(&OldTimeVal);
        oldtimeval.tv_secs  = OldTimeVal.Seconds;
        oldtimeval.tv_micro = OldTimeVal.Microseconds;
#else
        GetSysTime(&oldtimeval);
#endif
        oldtime = (oldtimeval.tv_secs  * 1000)
                + (oldtimeval.tv_micro / 1000);
        do
        {   while ((MsgPtr = (struct IntuiMessage*) GetMsg(MainWindowPtr->UserPort)))
            {   class  = MsgPtr->Class;
                code   = MsgPtr->Code;
                qual   = MsgPtr->Qualifier;
                ReplyMsg((struct Message*) MsgPtr);
                switch (class)
                {
                case IDCMP_CLOSEWINDOW:
                    done = TRUE;
                acase IDCMP_MOUSEBUTTONS:
                    if ((code == SELECTDOWN || code == MENUDOWN) && !(qual & IEQUALIFIER_REPEAT))
                    {   if (ignore)
                        {   ignore = FALSE;
                        } else
                        {   done = TRUE;
                    }   }
                acase IDCMP_RAWKEY:
                    if (code == SCAN_M || code == SCAN_F)
                    {   toggle(code);
                    } elif
                    (   code == SCAN_SPACEBAR
                     || code == SCAN_RETURN
                     || code == SCAN_ENTER
                     || code == SCAN_HELP
                    )
                    {   done = TRUE;
                    } elif (code == SCAN_ESCAPE)
                    {   if (qual & IEQUALIFIER_LSHIFT || qual & IEQUALIFIER_RSHIFT)
                        {   if (verify())
                            {   cleanexit(EXIT_SUCCESS);
                        }   }
                        else
                        {   done = TRUE;
            }   }   }   }

            if (firebutton())
            {   done = TRUE;
            }

#ifdef __amigaos4__
            GetSysTime(&NewTimeVal);
            newtimeval.tv_secs  = NewTimeVal.Seconds;
            newtimeval.tv_micro = NewTimeVal.Microseconds;
#else
            GetSysTime(&newtimeval);
#endif
            newtime = (newtimeval.tv_secs  * 1000)
                    + (newtimeval.tv_micro / 1000);
        } while (!done && newtime < oldtime + INTROSPEED);

        if (done)
        {   return;
}   }   }

EXPORT void writetext(int x, int y, UBYTE colour, STRPTR text)
{   SetDrMd(MainWindowPtr->RPort, JAM1);
    ww_shadowtext(x, y - YSTART, text, colour);
    SetDrMd(MainWindowPtr->RPort, JAM2);
}

EXPORT void rectfill_black(int leftx, int topy, int rightx, int bottomy)
{   SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    RectFill
    (   MainWindowPtr->RPort,
        leftx,
        topy,
        rightx,
        bottomy
    );
}
EXPORT void rectfill_grey(int leftx, int topy, int rightx, int bottomy)
{   SetAPen(MainWindowPtr->RPort, remapit[MEDIUMGREY]);
    RectFill
    (   MainWindowPtr->RPort,
        leftx,
        topy,
        rightx,
        bottomy
    );
}
EXPORT void rectfill_white(int leftx, int topy, int rightx, int bottomy)
{   SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
    RectFill
    (   MainWindowPtr->RPort,
        leftx,
        topy,
        rightx,
        bottomy
    );
}
EXPORT void rectfill_red(int leftx, int topy, int rightx, int bottomy)
{   SetAPen(MainWindowPtr->RPort, remapit[RED]);
    RectFill
    (   MainWindowPtr->RPort,
        leftx,
        topy,
        rightx,
        bottomy
    );
}

EXPORT void ami_draw(int firstx, int firsty, int secondx, int secondy, UBYTE colour)
{   SetAPen(MainWindowPtr->RPort, remapit[colour]);
    Move(MainWindowPtr->RPort, firstx,  firsty);
    Draw(MainWindowPtr->RPort, secondx, secondy);
}

EXPORT void le_loop(void)
{   TRANSIENT SWORD                mousex, mousey;
    TRANSIENT UWORD                code, qual;
    TRANSIENT ULONG                class;
    TRANSIENT struct IntuiMessage* MsgPtr;
    TRANSIENT int                  pointerx, pointery;
    PERSIST   FLAG                 lmb = FALSE;
#ifdef __amigaos4__
    TRANSIENT int                  rc;
#endif

    if (!(ModifyIDCMP
    (   MainWindowPtr,
        IDCMP_RAWKEY
      | IDCMP_MOUSEBUTTONS
      | IDCMP_CLOSEWINDOW
      | IDCMP_ACTIVEWINDOW
      | IDCMP_MENUPICK
      | IDCMP_MENUVERIFY
      | IDCMP_REFRESHWINDOW
      | IDCMP_INTUITICKS
      | IDCMP_MOUSEMOVE
    )))
    {   rq("ModifyIDCMP() failed!");
    }

    while (a == LEVELEDIT)
    {   if
        (   Wait
            (   (1 << MainWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   class    = MsgPtr->Class;
            code     = MsgPtr->Code;
            qual     = MsgPtr->Qualifier;
            mousex   = MsgPtr->MouseX;
            mousey   = MsgPtr->MouseY;
            if (class == IDCMP_MENUVERIFY && code == MENUHOT)
            {   pointerx = xpixeltosquare(mousex);
                pointery = ypixeltosquare(mousey);
                if
                (   pointerx >= 0
                 && pointerx <= MINFIELDX
                 && pointery >= 0
                 && pointery <= MINFIELDY
                 && !(qual & IEQUALIFIER_RCOMMAND)
                )
                {   MsgPtr->Code = MENUCANCEL;
            }   }
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_MOUSEMOVE:
                if (lmb)
                {   pointerx = xpixeltosquare(mousex);
                    pointery = ypixeltosquare(mousey);
                    if
                    (   (pointerx != fex || pointery != fey)
                     && valid(pointerx, pointery)
                    )
                    {   undot();
                        fex = pointerx;
                        fey = pointery;
                        stamp(brush);
                }   }
            acase IDCMP_MENUPICK:
                DISCARD handlemenus(code);
            acase IDCMP_RAWKEY:
                if (!(qual & IEQUALIFIER_REPEAT))
                {   effect(FXCLICK);
                }
                if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                {   shift = TRUE;
                } else
                {   shift = FALSE;
                }
                if (qual & IEQUALIFIER_CONTROL)
                {   ctrl = TRUE;
                } else
                {   ctrl = FALSE;
                }
                if ((qual & IEQUALIFIER_LALT) || (qual & IEQUALIFIER_RALT))
                {   alt = TRUE;
                } else
                {   alt = FALSE;
                }
                le_handlekybd(code);
            acase IDCMP_MOUSEBUTTONS:
                switch (code)
                {
                case SELECTDOWN:
                    lmb = TRUE;
                    le_leftdown((int) mousex, (int) mousey);
                acase SELECTUP:
                    lmb = FALSE;
                acase MENUUP:
                    le_rightdown((int) mousex, (int) mousey);
                }
            acase IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(MainWindowPtr);
                GT_EndRefresh(MainWindowPtr, TRUE);
         // adefault:
         //     IDCMP_MENUVERIFY, IDCMP_INTUITICKS, IDCMP_ACTIVEWINDOW
        }   }

#ifdef __amigaos4__
        rc = handle_applibport(TRUE);
        if (rc == 1 || (rc == 3 && verify()))
        {   cleanexit(EXIT_SUCCESS);
        }
#endif
    }

    if (!(ModifyIDCMP
    (   MainWindowPtr,
        IDCMP_VANILLAKEY
      | IDCMP_RAWKEY
      | IDCMP_MOUSEBUTTONS
      | IDCMP_CLOSEWINDOW
      | IDCMP_ACTIVEWINDOW
      | IDCMP_MENUPICK
      | IDCMP_MENUVERIFY
      | CYCLEIDCMP
      | CHECKBOXIDCMP
      | BUTTONIDCMP
      | STRINGIDCMP
      | IDCMP_REFRESHWINDOW
      | IDCMP_INTUITICKS
    )))
    {   rq("ModifyIDCMP() failed!");
    }

    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_CUT       , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_COPY      , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_PASTE     , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_ERASE     , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_EDITDELETE, NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_INSERT    , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_APPEND    , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_PREVIOUS  , NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_NEXT      , NOSUB));
}

EXPORT void ami_drawbox(int leftx, int topy, int width, int height)
{   /* WWB
       W B
       WBB */

    SetAPen(MainWindowPtr->RPort, remapit[LIGHTGREY]);
    Move(MainWindowPtr->RPort, leftx            , topy + height - 1);
    Draw(MainWindowPtr->RPort, leftx            , topy             );
    Draw(MainWindowPtr->RPort, leftx + width - 2, topy             );

    SetAPen(MainWindowPtr->RPort, remapit[DARKGREY]);
    Move(MainWindowPtr->RPort, leftx + width - 1, topy             );
    Draw(MainWindowPtr->RPort, leftx + width - 1, topy + height - 1);
    Draw(MainWindowPtr->RPort, leftx         + 1, topy + height - 1);
}

EXPORT void dot(void)
{   int x, xx, y, yy;

    /* Squares are dotted as follows:

         012345678901
        0............
        1............
        2............
        3............
        4....WWW.....
        5....WWWB....
        6....WWWB....
        7.....BBB....
        8............
        9............
       10............
       11............ */

        xx = ((fex + WW_LEFTGAP) * SQUAREX) + STARTXPIXEL;
        yy = ((fey +  WW_TOPGAP) * SQUAREY) + STARTYPIXEL;

    if (sticky)
    {   SetAPen(MainWindowPtr->RPort, remapit[RED]);
    } else
    {   SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
    }

    for (x = 4; x <= 6; x++)
    {   for (y = 4; y <= 6; y++)
        {   DISCARD WritePixel(MainWindowPtr->RPort, xx + x, yy + y);
    }   }
    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    DISCARD WritePixel(MainWindowPtr->RPort, xx + 7, yy + 5);
    DISCARD WritePixel(MainWindowPtr->RPort, xx + 7, yy + 6);
    DISCARD WritePixel(MainWindowPtr->RPort, xx + 5, yy + 7);
    DISCARD WritePixel(MainWindowPtr->RPort, xx + 6, yy + 7);
    DISCARD WritePixel(MainWindowPtr->RPort, xx + 7, yy + 7);
}

EXPORT void updatemenu(void)
{   if (pathname[0])
    {   OnMenu( MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_REVERT    , NOSUB));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_REVERT    , NOSUB));
    }
    if (hiscoresareclear())
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_CLEARHISCORES, NOSUB));
    } else
    {    OnMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_CLEARHISCORES, NOSUB));
    }

    if (a != LEVELEDIT)
    {   return;
    }

    OnMenu(     MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE , NOSUB));
    OnMenu(     MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_COPY      , NOSUB));
    OnMenu(     MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_ERASE     , NOSUB));
    OnMenu(     MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_PREVIOUS  , NOSUB));
    OnMenu(     MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_NEXT      , NOSUB));

    if (levels > 1)
    {   OnMenu( MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_CUT       , NOSUB));
        OnMenu( MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_EDITDELETE, NOSUB));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_CUT       , NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_EDITDELETE, NOSUB));
    }

    if (levels < MAXLEVELS)
    {   OnMenu( MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_INSERT    , NOSUB));
        OnMenu( MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_APPEND    , NOSUB));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_INSERT    , NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_APPEND    , NOSUB));
    }

    if (clipboarded)
    {   OnMenu( MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_PASTE     , NOSUB));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT   , IN_PASTE     , NOSUB));
}   }

MODULE void ww_shadowtext(int x, int y, STRPTR thetext, int colour)
{   int  i,
         j,
         thelength,
         underwhere = -1;
    TEXT newtext[80 + 1];

    thelength = strlen(thetext);

    for (i = 0; i < thelength; i++)
    {   if (thetext[i] == '_')
        {   underwhere = i;
            break;
    }   }
    if (underwhere != -1)
    {   SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
        Move(MainWindowPtr->RPort, x + (fontx * underwhere) + 1, YSTART + y + 3);
        DISCARD Text(MainWindowPtr->RPort, "_", 1);

        SetAPen(MainWindowPtr->RPort, remapit[colour]);
        Move(MainWindowPtr->RPort, x + (fontx * underwhere)    , YSTART + y + 2);
        DISCARD Text(MainWindowPtr->RPort, "_", 1);

        j = 0;
        for (i = 0; i <= thelength; i++)
        {   if (thetext[i] != '_')
            {   newtext[j++] = thetext[i];
    }   }   }
    else
    {   strcpy(newtext, thetext);
    }

    thelength = strlen(newtext);

    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    Move(MainWindowPtr->RPort, x + 1, YSTART + y + 1);
    DISCARD Text(MainWindowPtr->RPort, newtext, thelength);

    SetAPen(MainWindowPtr->RPort, remapit[colour]);
    Move(MainWindowPtr->RPort, x, YSTART + y);
    DISCARD Text(MainWindowPtr->RPort, newtext, thelength);
}

MODULE FLAG playersactive(void)
{   if (worm[0].control == NONE && worm[1].control == NONE && worm[2].control == NONE && worm[3].control == NONE)
    {   return FALSE;
    } else
    {   return TRUE;
}   }

EXPORT void openconsole(void) { ; }

EXPORT void busypointer(void)
{   SetWindowPointer(MainWindowPtr, WA_BusyPointer, TRUE,  TAG_DONE);
}
EXPORT void normalpointer(void)
{   SetWindowPointer(MainWindowPtr, WA_BusyPointer, FALSE, TAG_DONE);
}

MODULE void shadowit(struct Window* win, int x, int y, STRPTR string)
{   int length = strlen(string);

    SetAPen(win->RPort, remapit[DARKGREY]);
    Move
    (   win->RPort,
        x + 1,
        y + 1
    );
    DISCARD Text(win->RPort, string, length);

    SetAPen(win->RPort, remapit[WHITE]);
    Move
    (   win->RPort,
        x,
        y
    );
    DISCARD Text(win->RPort, string, length);
}

MODULE FLAG handlemenus(UWORD code)
{   FLAG             quitting = FALSE;
    struct MenuItem* ItemPtr;

    while (code != MENUNULL)
    {   ItemPtr = (struct MenuItem*) ItemAddress(MenuPtr, code);

        switch (MENUNUM(code))
        {
        case MN_PROJECT:
            switch (ITEMNUM(code))
            {
            case IN_NEW:
                newfields();
                say(LLL( MSG_NEWDONE, "New done."), WHITE);
            acase IN_OPEN:
                fileopen(FALSE);
            acase IN_REVERT:
                fileopen(TRUE);
            acase IN_SAVE:
                filesaveas(FALSE);
            acase IN_SAVEAS:
                filesaveas(TRUE);
            acase IN_PROJECTDELETE:
                filedelete();
            acase IN_QUITTITLE:
                a = GAMEOVER;
                worm[0].lives = worm[1].lives = worm[2].lives = worm[3].lives = 0;
                aborted = quitting = TRUE;
            acase IN_QUITDOS:
                if (verify())
                {   cleanexit(EXIT_SUCCESS);
            }   }
        acase MN_EDIT:
            switch (ITEMNUM(code))
            {
            case IN_CUT:
                le_cut();
            acase IN_COPY:
                le_copy();
            acase IN_PASTE:
                le_paste();
            acase IN_ERASE:
                le_erase();
            acase IN_INSERT:
                le_insert();
            acase IN_EDITDELETE:
                le_delete();
            acase IN_APPEND:
                le_append();
            acase IN_CLEARHISCORES:
                scores_modified = TRUE;
                clearhiscores();
                if (a == TITLESCREEN)
                {   renderhiscores_amiga();
                }
                // assert(hiscoresareclear();
                OffMenu(MainWindowPtr, FULLMENUNUM(MN_EDIT, IN_CLEARHISCORES, NOSUB));
            }
        acase MN_VIEW:
            switch (ITEMNUM(code))
            {
            case IN_PREVIOUS:
                if (level == 0)
                {   level = levels;
                } else level--;
                le_drawfield();
            acase IN_NEXT:
                if (level == levels)
                {   level = 0;
                } else level++;
                le_drawfield();
            acase IN_VIEWPOINTER:
                if (ItemPtr->Flags & CHECKED)
                {   pointer = TRUE;
                    ClearPointer(MainWindowPtr);
                } else
                {   pointer = FALSE;
                    SetPointer(MainWindowPtr, PointerData, 1, 1, 0, 0);
                }
            acase IN_VIEWTITLEBAR:
                if (ItemPtr->Flags & CHECKED)
                {   titlebar = TRUE;
                } else
                {   titlebar = FALSE;
                }
                if (morphos)
                {   ShowTitle(ScreenPtr, titlebar ? FALSE : TRUE); // MOS seems to have a buggy implementation of ShowTitle()
                } else
                {   ShowTitle(ScreenPtr, titlebar ? TRUE  : FALSE);
            }   }
        acase MN_SETTINGS:
            switch (ITEMNUM(code))
            {
            case  IN_ANIMATIONS:      anims       = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
            acase IN_AUTOSAVE:        autosave    = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
            acase IN_CREATEICONS:     createicons = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
            acase IN_ENGRAVEDSQUARES: engraved    = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
            }
        acase MN_HELP:
            switch (ITEMNUM(code))
            {
            case IN_CREATURES:
                help(ORB);
            acase IN_OBJECTS:
                help(AFFIXER);
            acase IN_FRUIT:
                help(FIRSTFRUIT);
            acase IN_MANUAL:
                // assert(AmigaGuideBase);
                help_manual();
            acase IN_UPDATE:
                help_update();
            acase IN_ABOUT:
                help_about();
        }   }
        code = ItemPtr->NextSelect;
    }

    return quitting;
}

#ifdef __VBCC__
EXPORT int stricmp(const char* s1, const char* s2)
{   while (toupper(*s1) == toupper(*s2))
    {   if (*s1 == EOS)
        {   return 0;
        }
        s1++;
        s2++;
    }

    return toupper(*(unsigned const char *)s1) - toupper(*(unsigned const char *)(s2));
}
EXPORT double strtod(const char* string, char** endPtr)
{   int sign, expSign = FALSE;
    double fraction, dblExp, *d;
    register const char *p;
    register int c;
    int exp = 0;  /* Exponent read from "EX" field. */
    int fracExp = 0;  /* Exponent that derives from the fractional
                                 * part.  Under normal circumstatnces, it is
                                 * the negative of the number of digits in F.
                                 * However, if I is very long, the last digits
                                 * of I get dropped (otherwise a long I with a
                                 * large negative exponent could cause an
                                 * unnecessary overflow on I alone).  In this
                                 * case, fracExp is incremented one for each
                                 * dropped digit. */
    int mantSize;  /* Number of digits in mantissa. */
    int decPt;   /* Number of mantissa digits BEFORE decimal
                                 * point. */
    const char *pExp;  /* Temporarily holds location of exponent
                                 * in string. */
PERSIST double powersOf10[] = { /* Table giving binary powers of 10.  Entry */
    10.,   /* is 10^2^i.  Used to convert decimal */
    100.,   /* exponents into floating-point numbers. */
    1.0e4,
    1.0e8,
    1.0e16,
    1.0e32,
    1.0e64,
    1.0e128,
    1.0e256
};

    /*
     * Strip off leading blanks and check for a sign.
     */

    p = string;
    while (isspace(*p)) {
        p += 1;
    }
    if (*p == '-') {
        sign = TRUE;
        p += 1;
    } else {
        if (*p == '+') {
            p += 1;
        }
        sign = FALSE;
    }

    /*
     * Count the number of digits in the mantissa (including the decimal
     * point), and also locate the decimal point.
     */

    decPt = -1;
    for (mantSize = 0; ; mantSize += 1)
    {
        c = *p;
        if (!isdigit(c)) {
            if ((c != '.') || (decPt >= 0)) {
                break;
            }
            decPt = mantSize;
        }
        p += 1;
    }

    /*
     * Now suck up the digits in the mantissa.  Use two integers to
     * collect 9 digits each (this is faster than using floating-point).
     * If the mantissa has more than 18 digits, ignore the extras, since
     * they can't affect the value anyway.
     */

    pExp  = p;
    p -= mantSize;
    if (decPt < 0) {
        decPt = mantSize;
    } else {
        mantSize -= 1;   /* One of the digits was the point. */
    }
    if (mantSize > 18) {
        fracExp = decPt - 18;
        mantSize = 18;
    } else {
        fracExp = decPt - mantSize;
    }
    if (mantSize == 0) {
        fraction = 0.0;
        p = string;
        goto done;
    } else {
        int frac1, frac2;
        frac1 = 0;
        for ( ; mantSize > 9; mantSize -= 1)
        {
            c = *p;
            p += 1;
            if (c == '.') {
                c = *p;
                p += 1;
            }
            frac1 = 10*frac1 + (c - '0');
        }
        frac2 = 0;
        for (; mantSize > 0; mantSize -= 1)
        {
            c = *p;
            p += 1;
            if (c == '.') {
                c = *p;
                p += 1;
            }
            frac2 = 10*frac2 + (c - '0');
        }
        fraction = (1.0e9 * frac1) + frac2;
    }

    /*
     * Skim off the exponent.
     */

    p = pExp;
    if ((*p == 'E') || (*p == 'e')) {
        p += 1;
        if (*p == '-') {
            expSign = TRUE;
            p += 1;
        } else {
            if (*p == '+') {
                p += 1;
            }
            expSign = FALSE;
        }
        while (isdigit(*p)) {
            exp = exp * 10 + (*p - '0');
            p += 1;
        }
    }
    if (expSign) {
        exp = fracExp - exp;
    } else {
        exp = fracExp + exp;
    }

    /*
     * Generate a floating-point number that represents the exponent.
     * Do this by processing the exponent one bit at a time to combine
     * many powers of 2 of 10. Then combine the exponent with the
     * fraction.
     */

    if (exp < 0) {
        expSign = TRUE;
        exp = -exp;
    } else {
        expSign = FALSE;
    }
    if (exp > 511)
    {   exp = 511;
        errno = ERANGE;
    }
    dblExp = 1.0;
    for (d = powersOf10; exp != 0; exp >>= 1, d += 1) {
        if (exp & 01) {
            dblExp *= *d;
        }
    }
    if (expSign) {
        fraction /= dblExp;
    } else {
        fraction *= dblExp;
    }

done:
    if (endPtr != NULL) {
        *endPtr = (char *) p;
    }

    if (sign) {
        return -fraction;
    }
    return fraction;
}
#endif
