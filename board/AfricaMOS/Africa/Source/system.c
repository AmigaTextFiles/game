// #define TESTING
// fully automated demo

// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <utility/tagitem.h>
#include <diskfont/diskfont.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <libraries/gadtools.h>    // struct NewMenu
#define __NOLIBBASE__
#include <libraries/locale.h>
#undef __NOLIBBASE__
#include <devices/timer.h>         // struct timeval
#include <dos/dosextens.h>         // struct Process
#define ASL_PRE_V38_NAMES          // this is needed for OS4
#include <libraries/asl.h>         // ASL_FileRequest
#include <dos/dostags.h>           // SYS_Output
#include <dos/datetime.h>          // struct DateTime
#include <libraries/amigaguide.h>
#ifdef __amigaos4__
    #include <dos/obsolete.h>      // CurrentDir()
    #include <libraries/application.h>
#endif
#include <intuition/gadgetclass.h> // GA_Disabled

#ifdef __SASC
    #include <dos.h>               // geta4()
#else
    #define geta4()
#endif /* of __SASC */

#include <ctype.h>                 // toupper()
#include <stdlib.h>                /* EXIT_SUCCESS, etc. */
#include <stdio.h>
#include <string.h>                // strcpy(), etc.
// #define ASSERT
#include <assert.h>
#include <time.h>

#include "shared.h"
#include "africa.h"

#ifdef __MORPHOS__
    #define USE_INLINE_STDARG
    #include <proto/openurl.h>
#else
    #ifndef __amigaos4__
        #define USE_LOCAL_OPENURL
    #endif
    #ifdef USE_LOCAL_OPENURL
        #include "openurl.h"
    #else
        #define __USE_INLINE__
        #include <proto/openurl.h>
        #include <libraries/openurl.h>
    #endif
#endif

#include <proto/exec.h>      // OpenLibrary()
#include <proto/icon.h>      // GetDiskObject()
#include <proto/intuition.h> // Object
#include <proto/graphics.h>
#include <proto/dos.h>
#include <proto/gadtools.h>
#define __NOLIBBASE__
#include <proto/locale.h>    // GetCatalogStr()
#undef __NOLIBBASE__
#include <proto/asl.h>
#include <proto/diskfont.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <clib/alib_protos.h>

#define CATCOMP_NUMBERS
#define CATCOMP_CODE
#define CATCOMP_BLOCK
#include "africa_strings.h"

// 2. DEFINES ------------------------------------------------------------

// #define DEBUGPENS
// to print info about what pens are being allocated

#define CONFIGLENGTH     51 // counting from 1 (so 0..CONFIGLENGTH-1)

#define TSBG              MAPBACKGROUND

#define SCOREDISTANCE    13
#define HINTX           520
#define MESSAGEY        476

#define MAXSPEED          7

#ifndef __amigaos4__
    #define UNUSED
#endif

/* we  = which european
   wa  = which african
   war = which army
   wh  = which hex
   wo  = which order
   wc  = which city */

#define MN_PROJECT           0
#define MN_SETTINGS          1
#define MN_HELP              2

#define IN_NEW               0
#define IN_OPEN              1
// ---                       2
#define IN_SAVE              3
#define IN_SAVEAS            4
// ---                       5
#define IN_QUITTITLE         6
#define IN_QUITDOS           7

#define IN_SHOW_TITLEBAR     0
// ---                       1
#define IN_WATCH_AMIGA       2

#define IN_GAME_SUMMARY      0
#define IN_SCORE_GRAPH       1
// ---                       2
#define IN_MANUAL            3
// ---                       4
#define IN_ABOUT             5

#define INDEX_PROJECT        0
#define INDEX_NEW            1
#define INDEX_OPEN           2
// ---                       3
#define INDEX_SAVE           4
#define INDEX_SAVE_AS        5
// ---                       6
#define INDEX_QUITTITLE      7
#define INDEX_QUITDOS        8
#define INDEX_SETTINGS       9
#define INDEX_SHOW_TITLEBAR 10
// ---                      11
#define INDEX_WATCH_AMIGA   12
#define INDEX_HELP          13
#define INDEX_GAME_SUMMARY  14
#define INDEX_SCORE_GRAPH   15
// ---                      16
#define INDEX_MANUAL        17
// ---                      18
#define INDEX_ABOUT         19

#define SUMMARYWIDTH       206
#define SUMMARYHEIGHT       54 // +11 per free african nation

#define MAX_NODELENGTH     (80 + 1)

#define WHOXPIXEL          224
#define WHOYPIXEL          174
#define EORDERSXPIXEL      556
#define EORDERSYPIXEL      119
#define MAXXSIZE          1280
#define MAXYSIZE          1024

#define SAVELENGTH        1912

#define COLUMNWIDTH        (16 + 1)
#define ROWHEIGHT           11

#define ARGPOS_FIRSTPLAYER   0 // players are 0..4
#define ARGPOS_SCREENMODE    5
#define ARGPOS_PUBSCREEN     6
#define ARGPOS_FILE          7
#define ARGS                 8

/* 3. EXPORTED VARIABLES -------------------------------------------------

We use asl, diskfont, dos, exec, gadtools, graphics, intuition. */

EXPORT SBYTE                 NewPri                     = 0;
EXPORT UBYTE                 remapit[64];
EXPORT SLONG                 xhex,
                             yhex,
                             players                    = 5,
                             eattack_country,
                             eattack_army,
                             aattack_country[MAX_ARMIES],
                             aattack_army[MAX_ARMIES],
                             score[EUROPEANS][MAX_ROUNDS + 1],
                             theround,
                             rounds                     = 10;
EXPORT WORD                  AboutXPos                  = (SCREENXPIXEL / 2) - (ABOUTXPIXEL / 2),
                             AboutYPos                  = (SCREENYPIXEL / 2) - (ABOUTYPIXEL / 2);
EXPORT UWORD                 DisplayDepth               = DEPTH;
EXPORT TEXT                  pathname[MAX_PATH + 1],
                             saystring[256 + 1],
                             screenname[MAXPUBSCREENNAME] = "",
                             WhoTitle[80 + 1];
EXPORT ULONG                 AppSignal,
                             AppLibSignal               = 0,
                             DisplayID                  = HIRES_KEY | PAL_MONITOR_ID | LACE, // $8000 | $21000 | $4 = $29004
                             DisplayWidth               = SCREENXPIXEL,
                             DisplayHeight              = SCREENYPIXEL,
                             WindowWidth                = SCREENXPIXEL,
                             WindowHeight               = SCREENYPIXEL,
                             enabled[EUROPEANS + RAFRICANS],
                             MainSignal;
EXPORT BOOL                  autosetup                  = TRUE,
                             colonial                   = FALSE,
                             endless                    = FALSE,
                             maintain                   = TRUE,
                             ukiu                       = FALSE;
EXPORT FLAG                  customscreen               = TRUE,
                             escaped,
                             fallen[RAFRICANS],
                             fresh[RAFRICANS],
                             ingame                     = FALSE,
                             morphos                    = FALSE,
                             urlopen                    = FALSE,
                             watchamiga                 = TRUE;
EXPORT int                   fontx                      = 8,
                             fonty                      = 8;
EXPORT struct Catalog       *CatalogPtr                 = NULL,
                            *StdCatalogPtr              = NULL;
EXPORT struct Process*       ProcessPtr                 = NULL;
EXPORT struct Screen*        ScreenPtr                  = NULL;
EXPORT struct TextFont*      FontPtr                    = NULL;
EXPORT struct VisualInfo*    VisualInfoPtr              = NULL;
EXPORT struct Window*        MainWindowPtr              = NULL;
EXPORT struct OrderStruct    order[EUROPEANS][MAX_ORDERS];
EXPORT struct RastPort       OffScreenRastPort;
EXPORT struct Library       *AmigaGuideBase             = NULL,
                            *AslBase                    = NULL,
                            *DiskfontBase               = NULL,
                            *GadToolsBase               = NULL,
                            *IconBase                   = NULL,
                            *LocaleBase                 = NULL,
                            *OpenURLBase                = NULL;

#ifdef __amigaos4__
EXPORT ULONG                    AppID                = 0; // not NULL!
EXPORT struct Library          *ApplicationBase      = NULL,
                               *GfxBase              = NULL,
                               *IntuitionBase        = NULL;
EXPORT struct ApplicationIFace* IApplication         = NULL;
EXPORT struct IntuitionIFace*   IIntuition           = NULL;
EXPORT struct IconIFace*        IIcon                = NULL;
EXPORT struct AmigaGuideIFace*  IAmigaGuide          = NULL;
EXPORT struct OpenURLIFace*     IOpenURL             = NULL;
EXPORT struct GadToolsIFace*    IGadTools            = NULL;
EXPORT struct DiskfontIFace*    IDiskfont            = NULL;
EXPORT struct AslIFace*         IAsl                 = NULL;
EXPORT struct GraphicsIFace*    IGraphics            = NULL;
EXPORT struct LocaleIFace*      ILocale              = NULL;
#endif

// this is required as GCC optimizes out any if (0) statement;
// as a result the version embedding was not working correctly.
USED const STRPTR verstag = VERSION;

// 4. IMPORTED VARIABLES -------------------------------------------------

#ifndef __amigaos4__
    IMPORT struct ExecBase*     SysBase;
#endif

/* The AfroStruct.aruler element can have these values:
          -1: nation is conquered, but not by any single nation
          wa: nation is independent.
0..RAFRICANS: nation is conquered by... */

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE int                   globalrc                      = WAITING,
                             ignore                        = 0,
                             maxlen,
                             xoffset,
                             yoffset;
MODULE UBYTE                 saycolour;
MODULE SLONG                 eventmode,
                             tickspeed[MAXSPEED + 1]    = {0, 2, // <4 interferes with menu selections!
                                                           4, 8, 12, 16, 20, -1};
MODULE WORD                  speed                      = 1,
                             EOrdersXPos, EOrdersYPos,
                             HexHelpXPos, HexHelpYPos,
                             ScoreXPos,   ScoreYPos,
                             WhoXPos,     WhoYPos;
// summary (ie. declared wars) window doesn't remember it's position
// because its size is dynamic
MODULE APTR                  OldWindowPtr /* = NULL */ ;
MODULE FLAG                  cliload                    /* = FALSE */ ,
                             gotpen[64],
                             loaded,
                             saveconfig                 /* = FALSE */ ,
                             screenmode                    = FALSE    ,
                             titlebar                      = TRUE     ;
MODULE TEXT                  cyclename[EUROPEANS][16 + 1 + 1],
                             EOrdersTitle[80 + 1],
                             fn_game[MAX_PATH + 1],
                             hintstring1[40 + 1],
                             hintstring2[40 + 1],
                             lowerstring[80 + 1],
                             MainTitle[80 + 1],
                             oldpathname[MAX_PATH + 1],
                             upperstring1[80 + 1],
                             upperstring2[80 + 1];
MODULE STRPTR                aname[2][RAFRICANS];
MODULE UBYTE                 IOBuffer[SAVELENGTH];
MODULE struct LocaleInfo     li;
MODULE struct DiskObject*    IconifiedIcon;
MODULE struct Window*        EOrdersWindowPtr           = NULL;
MODULE struct RDArgs*        ArgsPtr                    /* = NULL  */ ;
MODULE struct FileRequester* ASLRqPtr                   /* = NULL  */ ;
MODULE struct Menu*          MenuPtr                       = NULL     ;
MODULE struct Gadget        *AutoSetupGadgetPtr            = NULL     ,
                            *SpeedGadgetPtr             /* = NULL  */ ,
                            *RoundsGadgetPtr            /* = NULL  */ ,
                            *UKIUGadgetPtr              /* = NULL  */ ,
                            *ColonialGadgetPtr          /* = NULL  */ ,
                            *MaintainGadgetPtr          /* = NULL  */ ,
                            *EndlessGadgetPtr           /* = NULL  */ ,
                            *StartGadgetPtr             /* = NULL  */ ,
                            *CycleGadgetPtr[EUROPEANS]  /* = {NULL, NULL, NULL, NULL, NULL} */ ,
                            *PlayersGadgetPtr           /* = NULL  */ ,
                            *MainGListPtr                  = NULL     , // important that this is NULL!
                            *EOrdersGListPtr               = NULL     , // important that this is NULL!
                            *PrevGadgetPtr1             /* = NULL  */ ;
MODULE struct List           EList1,
                             EList2;
MODULE struct BitMap*        OffScreenBitMapPtr            = NULL;
MODULE struct IntuitionBase* TheIntuitionBase;
MODULE struct WBArg*         WBArg                         = NULL;
MODULE struct WBStartup*     WBMsg                         = NULL;
#ifdef DEBUGPENS
    MODULE UBYTE             hostred[256], hostgreen[256], hostblue[256];
#endif

// 6. EXPORTED ARRAYS-----------------------------------------------------

EXPORT SLONG hexowner[MAPROWS][MAPCOLUMNS] =
{ { NON, NON, NON, CON, ZAI, ZAI, ZAI, ZAI, UGA, UGA, KEN, KEN, KEN       },
  {   GAB, CON, CON, ZAI, ZAI, ZAI, ZAI, ZAI, UGA, UGA, KEN, KEN    , NON },
  { GAB, GAB, CON, ZAI, ZAI, ZAI, ZAI, ZAI, UGA, NON, KEN, KEN, KEN       },
  {   CON, CON, CON, ZAI, ZAI, ZAI, ZAI, TAN, TAN, TAN, TAN, KEN    , NON },
  { NON, ZAI, ZAI, ZAI, ZAI, ZAI, ZAI, ZAI, TAN, TAN, TAN, TAN, NON       },
  {   NON, ANG, ANG, ZAI, ANG, ZAI, ZAI, ZAI, TAN, TAN, TAN, NON    , NON },
  { NON, NON, ANG, ANG, ANG, ZAI, ZAI, ZAM, ZAM, ZAM, TAN, TAN, NON       },
  {   NON, ANG, ANG, ANG, ANG, ZAM, ZAI, ZAM, ZAM, MAL, MOZ, MOZ    , NON },
  { NON, NON, ANG, ANG, ANG, ZAM, ZAM, ZAM, ZAM, MAL, MOZ, MOZ, NON       },
  {   NON, ANG, ANG, ANG, ANG, ZAM, ZAM, RHO, MOZ, MAL, MOZ, NON    , NON },
  { NON, NON, NAM, NAM, NAM, BOT, RHO, RHO, RHO, MOZ, MOZ, NON, NON       },
  {   NON, NAM, NAM, NAM, BOT, BOT, RHO, RHO, MOZ, NON, NON, NON    , NON },
  { NON, NON, NAM, NAM, BOT, BOT, BOT, SAF, MOZ, MOZ, NON, NON, NON       },
  {   NON, NON, NAM, NAM, BOT, SAF, SAF, SAF, MOZ, NON, NON, NON    , NON },
  { NON, NON, NON, NAM, SAF, SAF, SAF, SAF, SAF, NON, NON, NON, NON       },
  {   NON, NON, NON, SAF, SAF, SAF, SAF, SAF, NON, NON, NON, NON    , NON },
  { NON, NON, NON, NON, SAF, SAF, SAF, SAF, NON, NON, NON, NON, NON       },
  {   NON, NON, NON, SAF, SAF, NON, NON, NON, NON, NON, NON, NON    , NON }
};

/* To the Amiga it looks like this:
EXPORT SLONG hexowner[MAPROWS][MAPCOLUMNS] =
{ { NON, NON, NON, CON, ZAI, ZAI, ZAI, ZAI, UGA, UGA, KEN, KEN, KEN },
  { GAB, CON, CON, ZAI, ZAI, ZAI, ZAI, ZAI, UGA, UGA, KEN, KEN, NON },
  { GAB, GAB, CON, ZAI, ZAI, ZAI, ZAI, ZAI, UGA, NON, KEN, KEN, KEN },
  { CON, CON, CON, ZAI, ZAI, ZAI, ZAI, TAN, TAN, TAN, TAN, KEN, NON },
  { NON, ZAI, ZAI, ZAI, ZAI, ZAI, ZAI, ZAI, TAN, TAN, TAN, TAN, NON },
  { NON, ANG, ANG, ZAI, ANG, ZAI, ZAI, ZAI, TAN, TAN, TAN, NON, NON },
  { NON, NON, ANG, ANG, ANG, ZAI, ZAI, ZAM, ZAM, ZAM, TAN, TAN, NON },
  { NON, ANG, ANG, ANG, ANG, ZAM, ZAI, ZAM, ZAM, MAL, MOZ, MOZ, NON },
  { NON, NON, ANG, ANG, ANG, ZAM, ZAM, ZAM, ZAM, MAL, MOZ, MOZ, NON },
  { NON, ANG, ANG, ANG, ANG, ZAM, ZAM, RHO, MOZ, MAL, MOZ, NON, NON },
  { NON, NON, NAM, NAM, NAM, BOT, RHO, RHO, RHO, MOZ, MOZ, NON, NON },
  { NON, NAM, NAM, NAM, BOT, BOT, RHO, RHO, MOZ, NON, NON, NON, NON },
  { NON, NON, NAM, NAM, BOT, BOT, BOT, SAF, MOZ, MOZ, NON, NON, NON },
  { NON, NON, NAM, NAM, BOT, SAF, SAF, SAF, MOZ, NON, NON, NON, NON },
  { NON, NON, NON, NAM, SAF, SAF, SAF, SAF, SAF, NON, NON, NON, NON },
  { NON, NON, NON, SAF, SAF, SAF, SAF, SAF, NON, NON, NON, NON, NON },
  { NON, NON, NON, NON, SAF, SAF, SAF, SAF, NON, NON, NON, NON, NON },
  { NON, NON, NON, SAF, SAF, NON, NON, NON, NON, NON, NON, NON, NON }
}; */

// 7. MODULE ARRAYS-------------------------------------------------------

MODULE UWORD chip CornerData[4][42] = {
{ 0x0000, // top left
  0x0600,
  0x1E00,
  0x3800,
  0x3600,
  0x6E00,
  0x6E00,
  /* Plane 1 */
  0x0000,
  0x0000,
  0x0000,
  0x0600,
  0x0800,
  0x1000,
  0x1000,
  /* Plane 2 */
  0x0600,
  0x1E00,
  0x3E00,
  0x7E00,
  0x7E00,
  0xFE00,
  0xFE00,
  /* Plane 3 */
  0x0600,
  0x1E00,
  0x3E00,
  0x7E00,
  0x7E00,
  0xFE00,
  0xFE00,
  /* Plane 4 */
  0x0600,
  0x1E00,
  0x3E00,
  0x7E00,
  0x7E00,
  0xFE00,
  0xFE00,
  /* Plane 5 */
  0x0000,
  0x0000,
  0x0600,
  0x0E00,
  0x1E00,
  0x3C00,
  0x3800
},
{ 0x0000, // top right
  0xC000,
  0xF000,
  0x3800,
  0xD800,
  0xEC00,
  0xEC00,
  /* Plane 1 */
  0x0000,
  0x0000,
  0x0000,
  0xC000,
  0x2000,
  0x1000,
  0x1000,
  /* Plane 2 */
  0xC000,
  0xF000,
  0xF800,
  0xFC00,
  0xFC00,
  0xFE00,
  0xFE00,
  /* Plane 3 */
  0xC000,
  0xF000,
  0xF800,
  0xFC00,
  0xFC00,
  0xFE00,
  0xFE00,
  /* Plane 4 */
  0xC000,
  0xF000,
  0xF800,
  0xFC00,
  0xFC00,
  0xFE00,
  0xFE00,
  /* Plane 5 */
  0x0000,
  0x0000,
  0xC000,
  0xE000,
  0xF000,
  0x7800,
  0x3800
},
{ 0x6E00, // bottom left
  0x6E00,
  0x3600,
  0x3800,
  0x1E00,
  0x0600,
  0x0000,
  /* Plane 1 */
  0x1000,
  0x1000,
  0x0800,
  0x0600,
  0x0000,
  0x0000,
  0x0000,
  /* Plane 2 */
  0xFE00,
  0xFE00,
  0x7E00,
  0x7E00,
  0x3E00,
  0x1E00,
  0x0600,
  /* Plane 3 */
  0xFE00,
  0xFE00,
  0x7E00,
  0x7E00,
  0x3E00,
  0x1E00,
  0x0600,
  /* Plane 4 */
  0xFE00,
  0xFE00,
  0x7E00,
  0x7E00,
  0x3E00,
  0x1E00,
  0x0600,
  /* Plane 5 */
  0x3800,
  0x3C00,
  0x1E00,
  0x0E00,
  0x0600,
  0x0000,
  0x0000
},
{ 0xEC00, // bottom right
  0xEC00,
  0xD800,
  0x3800,
  0xF000,
  0xC000,
  0x0000,
  /* Plane 1 */
  0x1000,
  0x1000,
  0x2000,
  0xC000,
  0x0000,
  0x0000,
  0x0000,
  /* Plane 2 */
  0xFE00,
  0xFE00,
  0xFC00,
  0xFC00,
  0xF800,
  0xF000,
  0xC000,
  /* Plane 3 */
  0xFE00,
  0xFE00,
  0xFC00,
  0xFC00,
  0xF800,
  0xF000,
  0xC000,
  /* Plane 4 */
  0xFE00,
  0xFE00,
  0xFC00,
  0xFC00,
  0xF800,
  0xF000,
  0xC000,
  /* Plane 5 */
  0x3800,
  0x7800,
  0xF000,
  0xE000,
  0xC000,
  0x0000,
  0x0000
} };

MODULE UWORD OriginalLogoData[5040] = {
  /* Plane 0 */
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF7F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC7F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xF87F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE07F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xC07F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xE07F,0xFFFF,0xFFF8,0x0FFF,0xFFFF,0xFFFF,0xC07F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF00,0x0000,0x007F,0xFFFF,0xFFC0,0x03FF,0xFFFF,0xFFFF,0x807F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF00,0x0000,0x003F,0xFFFF,0xFF80,0x00FF,0xFFFF,0xFFFF,0x007F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF21,0x0840,0x003F,0xFFFF,0xFE00,0x007F,0xFFFF,0xFFFF,0x007E,0x03FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF73,0x9CE7,0xFFFF,0xFFFF,0xFC00,0x003F,0xFFFF,0xFFFE,0x0030,0x0FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF21,0x0847,0xFFFF,0xFFFF,0xF800,0x001F,0xFFFF,0xFFFF,0x80C0,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF52,0x94A7,0xFFFF,0xFFFF,0xF000,0x000F,0xFFFF,0xE000,0x6100,0x7FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF00,0x0007,0xFFFF,0xFFFF,0xF020,0x0007,0xFFFF,0x0000,0x1A00,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF00,0x0007,0xFFFF,0xFFFF,0xF810,0x0007,0xFFFF,0xE000,0x0C01,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF00,0x0000,0x000F,0xFFFF,0xFC10,0x0003,0xFFFF,0xF800,0x0603,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF21,0x0840,0x000F,0xFFFF,0xFC18,0x0001,0xFFFF,0xFE00,0x0203,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF73,0x9CE0,0x0007,0xFFFF,0xF818,0x0000,0xFFFF,0xFF00,0x0107,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF21,0x0840,0x0007,0xFFFF,0xFC18,0x0000,0xFFFF,0xFF80,0x0108,0x000F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFCA0,0x0003,0xFFFF,0x6F18,0x0000,0xFFFF,0xFFC0,0x0090,0x0003,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xF000,0x0003,0xFFFF,0x03B8,0x0000,0x7FFF,0xFFCF,0xF890,0x0001,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xF007,0xFFFF,0xFFFF,0x01F0,0x0000,0x7FFF,0xFFF0,0x06A0,0x0001,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xF007,0xFFFF,0xFFFF,0x00F0,0xFC00,0x7FFF,0xFF80,0x05A0,0x000F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xE847,0xFFFF,0xFFFF,0x00F1,0xFE00,0xFFFF,0xFC00,0x08C0,0x007F,0xFBFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFCE7,0xFFFF,0xFFFE,0x43FB,0xFE00,0xFFFF,0xF000,0x0840,0x03FF,0x801F,0xFE00,0x39FF,0xFFC0,
  0xFFFF,0xC847,0xFFFF,0xFFFE,0xFF9B,0xFF03,0xFFFF,0xE000,0x1020,0x3FFC,0x0007,0xFE00,0x381F,0xFFC0,
  0xFFFF,0xD4A3,0x8000,0xFFFF,0xC807,0xFF07,0xFFFF,0xC000,0x103F,0xFFF8,0x0003,0xFE00,0x380F,0xFFC0,
  0xFFFF,0x8007,0x8000,0xFFFF,0x8007,0xFF8F,0xFFFF,0x0000,0x2010,0x1FF0,0x0000,0xFE00,0x3803,0xFFC0,
  0xFFFF,0x8007,0x8000,0xFFFF,0x0007,0xFF9F,0xFFFF,0x1FFE,0x2010,0x0FE0,0x0000,0x7E00,0x3801,0xFFC0,
  0xFFFF,0x0007,0x8000,0x7FFE,0x0007,0xFFBF,0xFFFF,0xFF81,0xE008,0x07C0,0x0000,0x7E00,0x3801,0xFFC0,
  0xFFFF,0x084F,0x8000,0x7FFE,0x0007,0xFFFF,0xFFFF,0xFF80,0x4008,0x0780,0x0000,0x7E00,0x3801,0xFFC0,
  0xFFFF,0x9CEF,0x8000,0x3FFE,0x000F,0xFFFF,0xFFFF,0xFF00,0x4008,0x0300,0x0000,0x7E00,0x3801,0xFFC0,
  0xFFFF,0x084F,0xFFFF,0xFFFE,0x0007,0xFFFF,0xFFFF,0xFE00,0x4008,0x0200,0x0000,0x7F00,0x3801,0xFFC0,
  0xFFFE,0x94BF,0xFFFF,0xFFFE,0x0007,0xFFFF,0xFFFF,0xFE00,0x4008,0x0200,0x0000,0x7F80,0x3801,0xDFC0,
  0xFFFE,0x001F,0xFFFF,0xFFFE,0x0003,0xFFFF,0xF9FF,0xFC00,0x400F,0xC100,0x0000,0x7FC0,0x3801,0xDFC0,
  0xFFFC,0x001F,0xFFFF,0xE000,0x0000,0x7FFF,0x81FF,0xFC00,0xC00F,0xF900,0x0000,0xFFE0,0x3801,0xDFC0,
  0xFFFC,0x003F,0xFFFF,0xE000,0x0000,0x0FF8,0x01FF,0xF803,0xE00F,0xFF20,0x03E0,0xFFF0,0x3801,0xCFC0,
  0xFFFD,0x087F,0xC000,0x0000,0x0000,0x07E0,0x01FF,0xF807,0xE00F,0xF870,0x0FF8,0xFFF8,0x3801,0xCFC0,
  0xFFFF,0x9CFF,0xC000,0x0000,0x0000,0x07E0,0x01FF,0xF80F,0xE00F,0xF020,0x1FFC,0xFEFC,0x3801,0xCFC0,
  0xFFF9,0x087F,0xC000,0x0000,0x0000,0x07E0,0x01FF,0xF83F,0x900F,0xF050,0x1FFE,0xFE7E,0x3801,0xCFC0,
  0xFFFA,0x94BF,0xC000,0x0000,0x0000,0x07E0,0x01FF,0xF9FF,0x901F,0xF000,0x3FFF,0xFE3F,0x3801,0xDFC0,
  0xFFF8,0x003F,0xE000,0x0000,0x0000,0x07E0,0x01FF,0xFFFF,0x883F,0xE004,0x3FFF,0xFFFF,0xF801,0xFFC0,
  0xFFF0,0x003F,0xE000,0x0000,0x0000,0x07E0,0x00FF,0xFFFF,0x885F,0xFF0E,0x3FFF,0xFFFF,0xFC01,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xF800,0x0000,0x07E0,0x0007,0xFFFF,0x889F,0xFE04,0x7FFF,0xFFFF,0xFC01,0xF7C0,
  0xFFFF,0xFFFF,0xFFFF,0xF800,0x0000,0x07E0,0x0007,0xFFFF,0x871F,0xFC0A,0x7FFF,0xFFFF,0xFE01,0xE7C0,
  0xFFFF,0xFFFF,0xFFFF,0xF800,0x0000,0x07E0,0x0007,0xFFFF,0x841F,0xF800,0x7FFF,0xFFFF,0xFE01,0xC7C0,
  0xFFFF,0xFFFF,0xFFFF,0xFC00,0x0000,0x07E0,0x0007,0xFFFF,0x801F,0xF004,0x7FFF,0xFFFF,0xFE01,0xC7C0,
  0xFFFF,0xFFFF,0xFFFF,0xFC00,0x0000,0x07E0,0x0007,0xFFFF,0x801F,0xF80E,0x7FFF,0xFFFF,0xFE01,0xFFC0,
  0xFFE0,0x0000,0x0000,0x03FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0xD804,0xFFFF,0xFFFF,0xFE01,0xFFC0,
  0xFFE0,0x0000,0x0000,0x03FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0xCC0A,0xFFFF,0xFFFF,0xFE01,0xFFC0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0xC400,0xFFFF,0xFFFF,0xFE00,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8020,0xFFFF,0xFFE0,0x0000,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8070,0xFFFF,0xFFC0,0x0000,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8020,0xFFFF,0xFF80,0x0000,0x03C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8050,0xFFFF,0xFF00,0x0000,0x03C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8000,0xFFFF,0xFE00,0x0000,0x03C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x0007,0xFFFF,0x801F,0x8000,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x000F,0xFFFF,0x801F,0x8000,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8001,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFF00,0x000F,0xF000,0x00FE,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8001,0xFFFF,0xFC00,0x0E00,0x03C0,
  0xFF00,0x003F,0xF800,0x00FE,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8001,0xFFFE,0xFFFF,0xFF81,0xFFC0,
  0xFE00,0x007F,0xF800,0x00FE,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8001,0xFFFE,0xFFFF,0xFFC1,0xFFC0,
  0xFE00,0x007F,0xFC00,0x007E,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8001,0xFFFC,0xF81F,0xFFC1,0x81C0,
  0xFE00,0x00FF,0xFE00,0x007E,0x0001,0xFFE0,0x001F,0xFFFF,0x801F,0x8000,0xFFFC,0xF83F,0x7FE1,0xC1C0,
  0xFC00,0x00FF,0xFE00,0x007E,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0xFFF8,0xF87E,0x7FE1,0xE1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0xFFF0,0xF8FC,0x7FE1,0xF1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0xFFE0,0xF9F8,0x7FE1,0xF9C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0x7FC0,0xFBF0,0x7FE1,0xFDC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0x3F80,0xFFC0,0xFFE1,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xC000,0x0000,0xFF81,0xFFC1,0xDFC0,
  0xF000,0x07FF,0xFF80,0x001C,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xE000,0x0000,0xFF03,0xFF01,0xCFC0,
  0xF000,0x07FF,0xFF80,0x001C,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xE000,0x0000,0xFE07,0xB801,0xC7C0,
  0xFE00,0x07FF,0xFFC0,0x0018,0x0001,0xFFE0,0x001F,0xFFFF,0x800F,0xE000,0x0000,0xFC0F,0x3801,0xC3C0,
  0xFFC0,0x0FFF,0xFFC0,0x0038,0x0001,0xFFE0,0x001F,0xFFFF,0x8007,0xF000,0x0000,0xFC1E,0x3801,0xC1C0,
  0xFFFC,0x0FFF,0xFFC0,0x0038,0x0001,0xFFE0,0x001F,0xFFFF,0x8007,0xF800,0x0000,0xFE3C,0x3801,0xC1C0,
  0xFFFF,0x9FFF,0xFFE0,0x0038,0x0001,0xFFE0,0x001F,0xFFFF,0x8007,0xF800,0x0000,0xFE78,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFF8,0x0001,0xFFE0,0x001F,0xFFFF,0x8007,0xFC00,0x0000,0xFFF0,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x0001,0xFFE0,0x001F,0xFFFF,0x8007,0xFE00,0x0000,0xFFE0,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE001,0xFFE0,0x001F,0xFFFF,0x8007,0xFF00,0x0001,0xFFC0,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC01,0xFFE0,0x001F,0xFFFF,0x8003,0xFF80,0x0003,0xFFE0,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF01,0xFFE0,0x001F,0xFFFF,0x8003,0xFFE0,0x000F,0xFFFC,0x3801,0xC1C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC1,0xFFE0,0x001F,0xFFFF,0x8003,0xFFF0,0x001F,0xFFFF,0xFF81,0xDFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF1,0xFFE0,0x001F,0xFFFF,0x8003,0xFFFE,0x00FF,0xFFFF,0xFF80,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFD,0xFFE0,0x001F,0xFFFF,0x8001,0xFFFF,0xC7FF,0xFFFF,0xFF9F,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFE0,0x001F,0xFFFF,0xFE01,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFE0,0x001F,0xFFFF,0xFFF1,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  /* Plane 1 */
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF1F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFCBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFBBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0FFF,0xFFFF,0xFFFF,0xE7BF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0x801F,0xFFFF,0xFFE0,0x03FF,0xFFFF,0xFFFF,0xDFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x001F,0xFFFF,0xFF80,0x00FF,0xFFFF,0xFFFF,0xBFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x1F9F,0xFFFF,0xFE07,0xF07F,0xFFFF,0xFFFF,0xBFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFF8F,0xFFFF,0xFC3F,0xFC3F,0xFFFF,0xFFFF,0x7FBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFFCF,0xFFFF,0xF87F,0xFF1F,0xFFFF,0xFFFE,0xFFBE,0x00FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC21,0x0847,0xFFC7,0xFFFF,0xF1FF,0xFF8F,0xFFFF,0xFFFE,0xFFB1,0xFCFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC73,0x9CE7,0xFFE7,0xFFFF,0xE3FF,0xFFC7,0xFFFF,0xFFFD,0xFFCF,0xF3FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC21,0x0847,0xFFE7,0xFFFF,0xC7FF,0xFFE3,0xFFFF,0xE000,0x7F3F,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC52,0x94A7,0xFFE3,0xFFFF,0x8FFF,0xFFF1,0xFFFF,0x1FFF,0x9EFF,0x9FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFFF3,0xFFFF,0x0FDF,0xFFF8,0xFFFE,0xFFFF,0xE5FF,0x3FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFFF3,0xFFFF,0x07EF,0xFFF8,0xFFFC,0x1FFF,0xF3FE,0x7FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFFF1,0xFFFF,0x03EF,0xFFFC,0x7FFF,0xE7FF,0xF9FC,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC21,0x0847,0xFFF1,0xFFFE,0x03E7,0xFFFE,0x3FFF,0xF9FF,0xFDFD,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC73,0x9CE7,0xFFF9,0xFFFE,0x07E7,0xFFFF,0x3FFF,0xFEFF,0xFEF8,0x7FC7,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC21,0x0847,0xFFF8,0xFFFC,0x03E7,0xFFFF,0x1FFF,0xFF7F,0xFEF7,0xFFF3,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x04A7,0xFFFC,0xFFFC,0x90E7,0xFFFF,0x1FFF,0xFFBF,0xFF6F,0xFFFD,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0007,0xFFFC,0xFFFC,0xFC47,0xFFFF,0x8FFF,0xFFB0,0x076F,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xC007,0xFFFC,0x7FF8,0xFE0F,0xFFFF,0x8FFF,0xFF8F,0xF95F,0xFFFE,0xC03F,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0x8007,0xFFFE,0x7FF8,0xFF0F,0x03FF,0x87FF,0xFC7F,0xFA5F,0xFFF0,0x0007,0xF800,0x007F,0xFFC0,
  0xFFFF,0x8847,0xFFFE,0x7FF8,0xFF0E,0x01FF,0x0FFF,0xF3FF,0xF73F,0xFF80,0x0403,0xF800,0x000F,0xFFC0,
  0xFFFF,0x1CE7,0xFFFE,0x3FF9,0xBC04,0x31FF,0x1FFF,0xEFFF,0xF7BF,0xFC60,0x7FE0,0xF800,0x3E03,0xFFC0,
  0xFFFF,0x0847,0xFFFF,0x3FF9,0x0064,0x78FC,0x3FFF,0x9FFF,0xEFDF,0xC3C3,0xFFF8,0x7800,0x3FE1,0xFFC0,
  0xFFFF,0x14A4,0x7FFF,0x3FF8,0x37F8,0xFCF8,0x7FFF,0x3FFF,0xEFC0,0x1F87,0xFFFC,0x3800,0x3FF0,0x7FC0,
  0xFFFE,0x0000,0x7FFF,0x1FF8,0x7FF8,0xFC70,0xFFFE,0xFFFF,0xDFEF,0xEF0F,0xFFFF,0x1800,0x3FFC,0x3FC0,
  0xFFFE,0x0000,0x7FFF,0x1FF8,0xFFF9,0xFC61,0xFFFE,0xE001,0xDFEF,0xF61F,0xFFFF,0x9800,0x3FFE,0x3FC0,
  0xFFFC,0x0000,0x7FFF,0x9FF9,0xFFF9,0xFE43,0xFFFD,0x1F7E,0x1FF7,0xF83F,0xFFFF,0x9800,0x3FFF,0x1FC0,
  0xFFFC,0x0840,0x7FFF,0x8FF9,0xFFF9,0xFE07,0xFFF8,0xFF7F,0xBFF7,0xF87F,0xFFFF,0x9800,0x3FFF,0x8FC0,
  0xFFFC,0x9CE0,0x7FFF,0xCFF9,0xFFF1,0xFE0F,0xFFFB,0xFEFF,0xBFF7,0xFCFF,0xFFFF,0x9800,0x3FFF,0xC7C0,
  0xFFF9,0x0840,0x7FFF,0xC001,0xFFF8,0xFE1F,0xF03F,0xFDFF,0xBFF7,0xFDFF,0xFFFF,0x9900,0x3FFF,0xC7C0,
  0xFFF8,0x94A2,0x7FFF,0xC001,0xFFF8,0x1F3E,0x003F,0xE1FF,0xBFF7,0xFDFF,0xFFFF,0x9980,0x3FFF,0xC7C0,
  0xFFF0,0x0002,0x7FFF,0xE001,0xFFFC,0x03E0,0x003F,0xC3FF,0xBFF0,0x3EFF,0xFFFF,0x99C0,0x3FFF,0xC3C0,
  0xFFF0,0x0006,0x7FFF,0xFFFF,0xFFFF,0x8080,0x003F,0x03FF,0x3FF7,0xC6FF,0xFFFF,0x19E0,0x3FFF,0xC3C0,
  0xFFF0,0x0006,0x7FFF,0xFFFF,0xFFFF,0xF080,0x003E,0x17FC,0xDFF7,0xE0DF,0xFC1F,0x19F0,0x3FFF,0xC3C0,
  0xFFF1,0x0846,0x3FFF,0xFFFF,0xFFFF,0xF880,0x003C,0x77FB,0xDFF7,0xC78F,0xF007,0x19F8,0x3FFF,0xC3C0,
  0xFFE3,0x9CCE,0x3FFF,0xFFFF,0xFFFF,0xF880,0x0038,0xF7F7,0xDFF7,0xCFDF,0xE003,0x19FC,0x3FFF,0xC1C0,
  0xFFE1,0x084F,0x3FFF,0xFFFF,0xFFFF,0xF880,0x0039,0xF7C7,0xEFF7,0xCFAF,0xE3E1,0x19FE,0x3FFF,0xC9C0,
  0xFFE2,0x948F,0x3FFF,0xFFFF,0xFFFF,0xF880,0x0031,0xF627,0xEFE7,0x8FFF,0xC7F0,0x19FF,0x3FFF,0xD9C0,
  0xFFC0,0x000F,0x1FFF,0xFFFF,0xFFFF,0xF880,0x0003,0xF027,0xF7C7,0x9FFB,0xC7F8,0x1800,0x0FFF,0xF9C0,
  0xFFC0,0x000F,0x1FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFF27,0xF7A7,0x80F1,0xCFFC,0x1800,0x03FF,0xF9C0,
  0xFFCF,0xFF8F,0x9FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFF27,0xF767,0x01FB,0x8FFE,0x1FFF,0xE3FF,0xF8C0,
  0xFFCF,0xFF8F,0x9FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFF27,0xF8E7,0x03F5,0x8FFF,0x1FFF,0xE1FF,0xF8C0,
  0xFF9F,0xFF9F,0x9FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFF27,0xFBE7,0x07FF,0x8FFF,0x9FFF,0xF1FF,0xF8C0,
  0xFF9F,0xFF80,0x0FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFF27,0xFFE7,0x0FFB,0x9FFF,0xFFFF,0xF1FF,0xF8C0,
  0xFF9F,0xFF80,0x0FFF,0xFFFF,0xFFFF,0xF880,0x0007,0xFE27,0xFFE7,0x07F1,0x9FFF,0xFFFF,0xF1FF,0xFCC0,
  0xFF1F,0xFFFF,0xFFFF,0xFC01,0xFFFE,0x0080,0x0007,0xFE27,0xFFE6,0x27FB,0x1FFF,0xFFFF,0xF1FF,0xFCC0,
  0xFF1F,0xFFFF,0xFFFF,0xFC01,0xFFFE,0x0080,0x0007,0xFE27,0xFFE6,0x33F5,0x1FFF,0xFFC0,0x01FF,0xFCC0,
  0xFF3F,0xFFFF,0xFFFF,0xFE79,0xFFFE,0x3880,0x0007,0xFE27,0xFFE6,0x3BFF,0x1FFF,0xFF00,0x01FF,0xFCC0,
  0xFE3F,0xFFFF,0xFFFF,0xFE79,0xFFFE,0x3F80,0x0007,0xFE27,0xFFE6,0x7FDF,0x1FFF,0xFE1F,0xFFFF,0xFCC0,
  0xFE3F,0xFFFF,0xFFFF,0xFE79,0xFFFE,0x3F80,0x0007,0xFE67,0xFFE6,0x7F8F,0x3FFF,0xFC3F,0xFFFF,0xFCC0,
  0xFE3F,0xFFFF,0xFFFF,0xFE39,0xFFFE,0x3F80,0x0007,0x0067,0xFFE6,0x7FDF,0x3FFF,0xF87F,0xFFFF,0xFCC0,
  0xFE7F,0xFFFF,0xFFFF,0xFF39,0xFFFE,0x3F80,0x0004,0x0067,0xFFE6,0x7FAF,0x3FFF,0xF8FF,0xFFFF,0xFC40,
  0xFC7F,0xFFFF,0xFFFF,0xFF39,0xFFFE,0x3F80,0x0000,0xFC67,0xFFE6,0x7FFF,0x3FFF,0xF1FF,0xFFFF,0xFC40,
  0xFCFF,0xFFFF,0xFFFF,0xFF39,0xFFFE,0x3F80,0x0001,0xFE47,0xFFE6,0x7FFF,0x3FFE,0x73FF,0xFFFF,0xFC40,
  0xFCFF,0xFFFF,0xFFFF,0xFF39,0xFFFE,0x3F80,0x0001,0xFFC7,0xFFE6,0x7FFF,0x3FFC,0x73FF,0xFFFF,0xFC40,
  0xFCFF,0xFFFC,0x3FFF,0xFF39,0xFFFE,0x3F80,0x0003,0xFFC7,0xFFE6,0x7FFE,0x3FFC,0x23FF,0xFFFF,0xFC40,
  0xF8FF,0xFFF0,0x0FFF,0xFF19,0xFFFE,0x3F80,0x0003,0xFFC7,0xFFE6,0x7FFE,0x3FF8,0x23FF,0xF1FF,0xFC40,
  0xF8FF,0xFFC3,0xC7FF,0xFF11,0xFFFE,0x3F80,0x0007,0xFFC7,0xFFE2,0x7FFE,0x3FF9,0x27FF,0xC07F,0xFE40,
  0xF9FF,0xFF87,0xC7FF,0xFF11,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFE2,0x7FFE,0x3FF1,0x27FF,0xCE3F,0xFE40,
  0xF1FF,0xFF8F,0xE3FF,0xFF91,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFE2,0x7FFE,0x3FE3,0x201F,0x9F3F,0xFE40,
  0xF1FF,0xFF1F,0xF1FF,0xFF91,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFE2,0x7FFF,0x3FC3,0x203F,0x9F9F,0xFE40,
  0xF3FF,0xFF3F,0xF1FF,0xFF81,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF2,0x3FFF,0x3FC7,0x207F,0x9F9F,0xFE40,
  0xE3FF,0xFE3F,0xF9FF,0xFF81,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF2,0x3FFF,0x1F8F,0x20FF,0x9F9F,0xFE40,
  0xE7FF,0xFE7F,0xF9FF,0xFFC3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF2,0x3FFF,0x0E1F,0x21FF,0x9F9F,0xFE40,
  0xE7FF,0xFC7F,0xF8FF,0xFFC3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF3,0x3FFF,0x803F,0x23FF,0x8F1F,0xFE40,
  0xCFFF,0xFCFF,0xFCFF,0xFFC3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF1,0x3FFF,0xC07F,0x27FF,0xC21F,0xFE40,
  0xCFFF,0xFCFF,0xFCFF,0xFFC3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF1,0x3FFF,0xFFFF,0x27FF,0xE03F,0xDE40,
  0x8FFF,0xF8FF,0xFC7F,0xFFE3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF1,0x1FFF,0xFFFF,0x27FF,0xF8FF,0xCE00,
  0x0FFF,0xF9FF,0xFE7F,0xFFE3,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF1,0x1FFF,0xFFFF,0x23FF,0xBFFF,0xC600,
  0x81FF,0xF9FF,0xFE3F,0xFFE7,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF1,0x9FFF,0xFFFF,0x23FF,0x3FFF,0xC200,
  0xE03F,0xF1FF,0xFE3F,0xFFC7,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF9,0x8FFF,0xFFFF,0x33FE,0x3FFF,0xC000,
  0xFC03,0xF3FF,0xFF3F,0xFFC7,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF8,0xC7FF,0xFFFF,0x31FC,0x3FFF,0xC000,
  0xFF80,0x63FF,0xFF1F,0xFFC7,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF8,0xC7FF,0xFFFF,0x31F8,0x3FFF,0xC000,
  0xFFF0,0x03FF,0xFF00,0x0007,0xFFFE,0x3F80,0x0007,0xFFCF,0xFFF8,0xE3FF,0xFFFF,0x38F0,0x3FFF,0xC000,
  0xFFFF,0x87FF,0xFF80,0x0000,0xFFFE,0x3F80,0x0007,0xFF8F,0xFFF8,0xF1FF,0xFFFF,0x3C60,0x3FFF,0xC000,
  0xFFFF,0xE7FF,0xFFFF,0xFFC0,0x1FFE,0x3F80,0x0007,0xFF8F,0xFFF8,0xF8FF,0xFFFE,0x3E00,0x3FFF,0xC000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x03FE,0x3F80,0x0007,0xFF9F,0xFFFC,0x7C7F,0xFFFC,0x7F00,0x3FFF,0xC000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xC0FE,0x3F80,0x0007,0xFF9F,0xFFFC,0x7E1F,0xFFF0,0xFF80,0x3FFF,0xC000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xF03E,0x3F80,0x0007,0xFF9F,0xFFFC,0x7F0F,0xFFE1,0xFFC0,0x387F,0xC000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC0E,0x3F80,0x0007,0xFF9F,0xFFFC,0x7F81,0xFF03,0xFFF0,0x007F,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF02,0x3F80,0x0007,0xFF83,0xFFFE,0x3FE0,0x380F,0xFFFE,0x0060,0x01C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,0x3F80,0x0007,0xFF80,0x01FE,0x3FFC,0x003F,0xFFFF,0xFE00,0x7FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF0,0x3F80,0x0007,0xFFF8,0x000E,0x3FFF,0x83FF,0xFFFF,0xFF07,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x3F80,0x0007,0xFFFF,0xE000,0x3FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x3F80,0x0007,0xFFFF,0xFE00,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF0,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x0FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  /* Plane 2 */
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF1F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFCBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFBBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE7BF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xDFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xBFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xE07F,0xFFFF,0xFFF8,0x0FFF,0xFFFF,0xFFFF,0xBFBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x007F,0xFFFF,0xFFC0,0x03FF,0xFFFF,0xFFFF,0x7FBF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x003F,0xFFFF,0xFF80,0x00FF,0xFFFF,0xFFFE,0xFFBE,0x00FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFDE,0xF7B8,0x003F,0xFFFF,0xFE00,0x007F,0xFFFF,0xFFFE,0xFFB1,0xFCFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF8C,0x6318,0x001F,0xFFFF,0xFC00,0x003F,0xFFFF,0xFFFD,0xFFCF,0xF3FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFDE,0xF7B8,0x001F,0xFFFF,0xF800,0x001F,0xFFFF,0xE000,0x7F3F,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFAD,0x6B58,0x001F,0xFFFF,0xF000,0x000F,0xFFFF,0x1FFF,0x9EFF,0x9FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x000F,0xFFFF,0xF020,0x0007,0xFFFE,0xFFFF,0xE5FF,0x3FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x000F,0xFFFF,0xF810,0x0007,0xFFFC,0x1FFF,0xF3FE,0x7FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x000F,0xFFFF,0xFC10,0x0003,0xFFFF,0xE7FF,0xF9FC,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFDE,0xF7B8,0x000F,0xFFFF,0xFC18,0x0001,0xFFFF,0xF9FF,0xFDFD,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFF8C,0x6318,0x0007,0xFFFF,0xF818,0x0000,0xFFFF,0xFEFF,0xFEF8,0x7FC7,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFDE,0xF7B8,0x0007,0xFFFF,0xFC18,0x0000,0xFFFF,0xFF7F,0xFEF7,0xFFF3,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFB58,0x0003,0xFFFF,0x6F18,0x0000,0xFFFF,0xFFBF,0xFF6F,0xFFFD,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x0003,0xFFFF,0x03B8,0x0000,0x7FFF,0xFFB0,0x076F,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x0003,0xFFFF,0x01F0,0x0000,0x7FFF,0xFF8F,0xF95F,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFF8,0x0001,0xFFFF,0x00F0,0xFC00,0x7FFF,0xFC7F,0xFA5F,0xFFF7,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xF7B8,0x0001,0xFFFF,0x00F1,0xFE00,0xFFFF,0xF3FF,0xF73F,0xFF87,0xFBFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xE318,0x0001,0xFFFE,0x43FB,0xFE00,0xFFFF,0xEFFF,0xF7BF,0xFC7F,0x801F,0xFFFF,0xC1FF,0xFFC0,
  0xFFFF,0xF7B8,0x0000,0xFFFE,0xFF9B,0xFF03,0xFFFF,0x9FFF,0xEFDF,0xC3FC,0x0007,0xFFFF,0xC01F,0xFFC0,
  0xFFFF,0xEB5B,0x8000,0xFFFF,0xC807,0xFF07,0xFFFF,0x3FFF,0xEFC0,0x1FF8,0x0003,0xFFFF,0xC00F,0xFFC0,
  0xFFFF,0xFFFF,0x8000,0xFFFF,0x8007,0xFF8F,0xFFFE,0xFFFF,0xDFEF,0xEFF0,0x0000,0xFFFF,0xC003,0xFFC0,
  0xFFFF,0xFFFF,0x8000,0xFFFF,0x0007,0xFF9F,0xFFFE,0xE001,0xDFEF,0xF7E0,0x0000,0x7FFF,0xC001,0xFFC0,
  0xFFFF,0xFFFF,0x8000,0x7FFE,0x0007,0xFFBF,0xFFFC,0x1F7E,0x1FF7,0xFBC0,0x0000,0x7FFF,0xC000,0xFFC0,
  0xFFFF,0xF7BF,0x8000,0x7FFE,0x0007,0xFFFF,0xFFF8,0xFF7F,0xBFF7,0xFB80,0x0000,0x7FFF,0xC000,0x7FC0,
  0xFFFF,0x631F,0x8000,0x3FFE,0x000F,0xFFFF,0xFFFB,0xFEFF,0xBFF7,0xFF00,0x0000,0x7FFF,0xC000,0x3FC0,
  0xFFFE,0xF7BF,0x8000,0x3FFE,0x0007,0xFFFF,0xFFFF,0xFDFF,0xBFF7,0xFE00,0x0000,0x7EFF,0xC000,0x3FC0,
  0xFFFF,0x6B5F,0x8000,0x3FFE,0x0007,0xFFFF,0xFFFF,0xFDFF,0xBFF7,0xFC00,0x0000,0x7E7F,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0x8000,0x1FFE,0x0003,0xFFFF,0xFFFF,0xFBFF,0xBFF0,0x3E00,0x0000,0x7E3F,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0x8000,0x0000,0x0000,0x7FFF,0xFFFF,0xF3FF,0x3FF7,0xC600,0x0000,0xFE1F,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0x8000,0x0000,0x0000,0x0FFF,0xFFFF,0xE7FC,0x1FF7,0xF820,0x03E0,0xFE0F,0xC000,0x3FC0,
  0xFFFE,0xF7BF,0xC000,0x0000,0x0000,0x07FF,0xFFFF,0x87F8,0x1FF7,0xF870,0x0FF8,0xFE07,0xC000,0x3FC0,
  0xFFFC,0x633F,0xC000,0x0000,0x0000,0x07FF,0xFFFF,0x07F8,0x1FF7,0xF020,0x1FFC,0xFE03,0xC000,0x3FC0,
  0xFFFE,0xF7BF,0xC000,0x0000,0x0000,0x07FF,0xFFFE,0x07D8,0x0FF7,0xF050,0x1FFE,0xFE01,0xC000,0x37C0,
  0xFFFD,0x6B7F,0xC000,0x0000,0x0000,0x07FF,0xFFFE,0x06F8,0x0FEF,0xF000,0x3FFF,0xFE00,0xC000,0x27C0,
  0xFFFF,0xFFFF,0xE000,0x0000,0x0000,0x07FF,0xFFFC,0x00F8,0x07DF,0xE004,0x3FFF,0xFFFF,0xF000,0x07C0,
  0xFFFF,0xFFFF,0xE000,0x0000,0x0000,0x07FF,0xFFF8,0x00F8,0x079F,0xFF0E,0x3FFF,0xFFFF,0xFC00,0x07C0,
  0xFFF0,0x007F,0xE000,0x0000,0x0000,0x07FF,0xFFF8,0x00F8,0x071F,0xFE04,0x7FFF,0xFFFF,0xFC00,0x07C0,
  0xFFF0,0x007F,0xE000,0x0000,0x0000,0x07FF,0xFFF8,0x00F8,0x001F,0xFC0A,0x7FFF,0xFFFF,0xFE00,0x07C0,
  0xFFE0,0x007F,0xE000,0x0000,0x0000,0x07FF,0xFFF8,0x00F8,0x001F,0xF800,0x7FFF,0xFFFF,0xFE00,0x07C0,
  0xFFE0,0x007F,0xF000,0x0000,0x0000,0x07FF,0xFFF8,0x00F8,0x001F,0xF004,0x7FFF,0xFFFF,0xFE00,0x07C0,
  0xFFE0,0x007F,0xF000,0x0000,0x0000,0x07FF,0xFFF8,0x01F8,0x001F,0xF80E,0x7FFF,0xFFFF,0xFE00,0x03C0,
  0xFFE0,0x0000,0x0000,0x03FE,0x0001,0xFFFF,0xFFF8,0x01F8,0x001F,0xD804,0xFFFF,0xFFFF,0xFE00,0x03C0,
  0xFFE0,0x0000,0x0000,0x03FE,0x0001,0xFFFF,0xFFF8,0x01F8,0x001F,0xCC0A,0xFFFF,0xFFFF,0xFE00,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFFF,0xFFF8,0x01F8,0x001F,0xC400,0xFFFF,0xFFFF,0xFE00,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFFF,0xFFF8,0x01F8,0x001F,0x8020,0xFFFF,0xFFE0,0x0000,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFFF,0xFFF8,0x01F8,0x001F,0x8070,0xFFFF,0xFFC0,0x0000,0x03C0,
  0xFFC0,0x0000,0x0000,0x01FE,0x0001,0xFFFF,0xFFF8,0xFFF8,0x001F,0x8020,0xFFFF,0xFF80,0x0000,0x03C0,
  0xFF80,0x0000,0x0000,0x00FE,0x0001,0xFFFF,0xFFFB,0xFFF8,0x001F,0x8050,0xFFFF,0xFF00,0x0000,0x03C0,
  0xFF80,0x0000,0x0000,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8000,0xFFFF,0xFE00,0x0000,0x03C0,
  0xFF00,0x0000,0x0000,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8000,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFF00,0x0000,0x0000,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8000,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFF00,0x0003,0xC000,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8001,0xFFFF,0xFC00,0x0000,0x03C0,
  0xFF00,0x000F,0xF000,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8001,0xFFFF,0xFC00,0x0E00,0x03C0,
  0xFF00,0x003F,0xF800,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF8,0x001F,0x8001,0xFFFE,0xF800,0x3F80,0x01C0,
  0xFE00,0x007F,0xF800,0x00FE,0x0001,0xFFFF,0xFFFF,0xFFF0,0x001F,0x8001,0xFFFE,0xF800,0x3FC0,0x01C0,
  0xFE00,0x007F,0xFC00,0x007E,0x0001,0xFFFF,0xFFFF,0xFFF0,0x001F,0x8001,0xFFFC,0xFFE0,0x7FC0,0x01C0,
  0xFE00,0x00FF,0xFE00,0x007E,0x0001,0xFFFF,0xFFFF,0xFFF0,0x001F,0x8000,0xFFFC,0xFFC0,0x7FE0,0x01C0,
  0xFC00,0x00FF,0xFE00,0x007E,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0xFFF8,0xFF80,0x7FE0,0x01C0,
  0xFC00,0x01FF,0xFE00,0x007E,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0xFFF0,0xFF00,0x7FE0,0x01C0,
  0xF800,0x01FF,0xFE00,0x003C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0xFFE0,0xFE00,0x7FE0,0x01C0,
  0xF800,0x03FF,0xFF00,0x003C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0x7FC0,0xFC00,0x7FE0,0x01C0,
  0xF000,0x03FF,0xFF00,0x003C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0x3F80,0xF800,0x3FE0,0x01C0,
  0xF000,0x03FF,0xFF00,0x003C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xC000,0x0000,0xF800,0x1FC0,0x21C0,
  0xF000,0x07FF,0xFF80,0x001C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xE000,0x0000,0xF800,0x0700,0x31C0,
  0xF000,0x07FF,0xFF80,0x001C,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xE000,0x0000,0xFC00,0x4000,0x39C0,
  0xFE00,0x07FF,0xFFC0,0x0018,0x0001,0xFFFF,0xFFFF,0xFFF0,0x000F,0xE000,0x0000,0xFC00,0xC000,0x3DC0,
  0xFFC0,0x0FFF,0xFFC0,0x0038,0x0001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xF000,0x0000,0xFC01,0xC000,0x3FC0,
  0xFFFC,0x0FFF,0xFFC0,0x0038,0x0001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xF800,0x0000,0xFE03,0xC000,0x3FC0,
  0xFFFF,0x9FFF,0xFFE0,0x0038,0x0001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xF800,0x0000,0xFE07,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFF8,0x0001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xFC00,0x0000,0xFF0F,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x0001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xFE00,0x0000,0xFF9F,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE001,0xFFFF,0xFFFF,0xFFF0,0x0007,0xFF00,0x0001,0xFFFF,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC01,0xFFFF,0xFFFF,0xFFE0,0x0003,0xFF80,0x0003,0xFFFF,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF01,0xFFFF,0xFFFF,0xFFE0,0x0003,0xFFE0,0x000F,0xFFFF,0xC000,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC1,0xFFFF,0xFFFF,0xFFE0,0x0003,0xFFF0,0x001F,0xFFFF,0xC780,0x3FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFDF1,0xFFFF,0xFFFF,0xFFE0,0x0003,0xFFFE,0x00FF,0xFFFF,0xFF80,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF7D,0xFFFF,0xFFFF,0xFFFC,0x0001,0xFFFF,0xC7FF,0xFFFF,0xFF9F,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFDF,0xFFFF,0xFFFF,0xFFFF,0xFE01,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF7,0xFFFF,0xFFFF,0xFFFF,0xFFF1,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  /* Plane 3 */
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF1F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC3F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xF83F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x0FFF,0xFFFF,0xFFFF,0xE03F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0x801F,0xFFFF,0xFFE0,0x03FF,0xFFFF,0xFFFF,0xC03F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x001F,0xFFFF,0xFF80,0x00FF,0xFFFF,0xFFFF,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x001F,0xFFFF,0xFE00,0x007F,0xFFFF,0xFFFF,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x000F,0xFFFF,0xFC00,0x003F,0xFFFF,0xFFFF,0x003F,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x000F,0xFFFF,0xF800,0x001F,0xFFFF,0xFFFE,0x003E,0x00FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0007,0xFFFF,0xF000,0x000F,0xFFFF,0xFFFE,0x0030,0x00FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0007,0xFFFF,0xE000,0x0007,0xFFFF,0xFFFC,0x0000,0x03FF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0007,0xFFFF,0xC000,0x0003,0xFFFF,0xE000,0x0000,0x0FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0003,0xFFFF,0x8000,0x0001,0xFFFF,0x0000,0x0000,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0003,0xFFFF,0x1020,0x0000,0xFFFE,0x0000,0x0000,0x3FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0003,0xFFFF,0x3810,0x0000,0xFFFC,0x0000,0x0000,0x7FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0001,0xFFFF,0x3C10,0x0000,0x7FFF,0xE000,0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0001,0xFFFE,0x7C18,0x0000,0x3FFF,0xF800,0x0001,0x803F,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0001,0xFFFE,0x7818,0x0000,0x3FFF,0xFE00,0x0000,0x0007,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0000,0xFFFC,0x7C18,0x0000,0x1FFF,0xFF00,0x0000,0x0003,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0000,0xFFFC,0x6F18,0x0000,0x1FFF,0xFF80,0x0000,0x0001,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFC00,0x0000,0x0000,0xFFFC,0x03B8,0x0000,0x0FFF,0xFF80,0x0000,0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xC000,0x0000,0x7FF8,0x01F0,0x0000,0x0FFF,0xFF80,0x0000,0x0000,0xC03F,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0x8000,0x0000,0x7FF8,0x00F0,0x0000,0x07FF,0xFC00,0x0000,0x0000,0x0007,0xF800,0x007F,0xFFC0,
  0xFFFF,0x8000,0x0000,0x7FF8,0x00F0,0x0000,0x0FFF,0xF000,0x0000,0x0000,0x0003,0xF800,0x000F,0xFFC0,
  0xFFFF,0x0000,0x0000,0x3FF8,0x43F8,0x3000,0x1FFF,0xE000,0x0000,0x0060,0x0000,0xF800,0x0003,0xFFC0,
  0xFFFF,0x0000,0x0000,0x3FF8,0xFF98,0x7800,0x3FFF,0x8000,0x0000,0x03C0,0x0000,0x7800,0x0001,0xFFC0,
  0xFFFF,0x0000,0x0000,0x3FF9,0xC800,0xFC00,0x7FFF,0x0000,0x0000,0x1F80,0x0000,0x3800,0x0000,0x7FC0,
  0xFFFE,0x0000,0x0000,0x1FF9,0x8000,0xFC00,0xFFFE,0x0000,0x0000,0x0F00,0x0000,0x1800,0x0000,0x3FC0,
  0xFFFE,0x0000,0x0000,0x1FF9,0x0001,0xFC01,0xFFFE,0x0000,0x0000,0x0600,0x0000,0x1800,0x0000,0x3FC0,
  0xFFFC,0x0000,0x0000,0x1FF8,0x0001,0xFE03,0xFFFC,0x1F00,0x0000,0x0000,0x0000,0x1800,0x0000,0x1FC0,
  0xFFFC,0x0000,0x0000,0x0FF8,0x0001,0xFE07,0xFFF8,0xFF00,0x0000,0x0000,0x0000,0x1800,0x0000,0x0FC0,
  0xFFFC,0x0000,0x0000,0x0FF8,0x0001,0xFE0F,0xFFFB,0xFE00,0x0000,0x0000,0x0000,0x1800,0x0000,0x07C0,
  0xFFF8,0x0000,0x0000,0x0000,0x0000,0xFE1F,0xF03F,0xFC00,0x0000,0x0000,0x0000,0x1800,0x0000,0x07C0,
  0xFFF8,0x0002,0x0000,0x0000,0x0000,0x1F3E,0x003F,0xE000,0x0000,0x0000,0x0000,0x1800,0x0000,0x07C0,
  0xFFF0,0x0002,0x0000,0x0000,0x0000,0x03E0,0x003F,0xC000,0x0000,0x0000,0x0000,0x1800,0x0000,0x03C0,
  0xFFF0,0x0006,0x0000,0x0000,0x0000,0x0080,0x003F,0x0000,0x0007,0xC000,0x0000,0x1800,0x0000,0x03C0,
  0xFFF0,0x0006,0x0000,0x0000,0x0000,0x0080,0x003E,0x0000,0x0007,0xE020,0x0000,0x1800,0x0000,0x03C0,
  0xFFF0,0x0006,0x0000,0x0000,0x0000,0x0080,0x003C,0x0000,0x0007,0xC070,0x0000,0x1800,0x0000,0x03C0,
  0xFFE0,0x000E,0x0000,0x0000,0x0000,0x0080,0x0038,0x0000,0x0007,0xC020,0x0000,0x1800,0x0000,0x01C0,
  0xFFE0,0x000F,0x0000,0x0000,0x0000,0x0080,0x0038,0x0000,0x0007,0xC050,0x03E0,0x1800,0x0000,0x01C0,
  0xFFE0,0x000F,0x0000,0x0000,0x0000,0x0080,0x0030,0x0020,0x0007,0x8000,0x07F0,0x1800,0x0000,0x01C0,
  0xFFC0,0x000F,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x8004,0x07F8,0x1800,0x0000,0x01C0,
  0xFFC0,0x000F,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x9F0E,0x0FFC,0x1800,0x0000,0x01C0,
  0xFFC0,0x000F,0x8000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x1E04,0x0FFE,0x1FFF,0xE000,0x00C0,
  0xFFC0,0x000F,0x8000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x3C0A,0x0FFF,0x1FFF,0xE000,0x00C0,
  0xFF80,0x001F,0x8000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x3800,0x0FFF,0x9FFF,0xF000,0x00C0,
  0xFF80,0x0000,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x3004,0x1FFF,0xFFFF,0xF000,0x00C0,
  0xFF80,0x0000,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0007,0x380E,0x1FFF,0xFFFF,0xF000,0x00C0,
  0xFF00,0x0000,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0006,0x1804,0x1FFF,0xFFFF,0xF000,0x00C0,
  0xFF00,0x0000,0x0000,0x0000,0x0000,0x0080,0x0000,0x0020,0x0006,0x0C0A,0x1FFF,0xFFC0,0x0000,0x00C0,
  0xFF00,0x0000,0x0000,0x0078,0x0000,0x3880,0x0000,0x0020,0x0006,0x0400,0x1FFF,0xFF00,0x0000,0x00C0,
  0xFE00,0x0000,0x0000,0x0078,0x0000,0x3F80,0x0000,0x0020,0x0006,0x0020,0x1FFF,0xFE00,0x0000,0x00C0,
  0xFE00,0x0000,0x0000,0x0078,0x0000,0x3F80,0x0000,0x0060,0x0006,0x0070,0x3FFF,0xFC00,0x0000,0x00C0,
  0xFE00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0000,0x0060,0x0006,0x0020,0x3FFF,0xF800,0x0000,0x00C0,
  0xFE00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0000,0x0060,0x0006,0x0050,0x3FFF,0xF800,0x0000,0x0040,
  0xFC00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0000,0xFC60,0x0006,0x0000,0x3FFF,0xF000,0x0000,0x0040,
  0xFC00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0001,0xFE40,0x0006,0x0000,0x3FFE,0x7000,0x0000,0x0040,
  0xFC00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0001,0xFFC0,0x0006,0x0000,0x3FFC,0x7000,0x0000,0x0040,
  0xFC00,0x0000,0x0000,0x0038,0x0000,0x3F80,0x0003,0xFFC0,0x0006,0x0000,0x3FFC,0x2000,0x0000,0x0040,
  0xF800,0x0000,0x0000,0x0018,0x0000,0x3F80,0x0003,0xFFC0,0x0006,0x0000,0x3FF8,0x2000,0x0000,0x0040,
  0xF800,0x0003,0xC000,0x0010,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x3FF8,0x2000,0x0000,0x0040,
  0xF800,0x0007,0xC000,0x0010,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x3FF0,0x2000,0x0E00,0x0040,
  0xF000,0x000F,0xE000,0x0010,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x3FE0,0x2000,0x1F00,0x0040,
  0xF000,0x001F,0xF000,0x0010,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x3FC0,0x2000,0x1F80,0x0040,
  0xF000,0x003F,0xF000,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x3FC0,0x2000,0x1F80,0x0040,
  0xE000,0x003F,0xF800,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x1F80,0x2000,0x1F80,0x0040,
  0xE000,0x007F,0xF800,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0002,0x0000,0x0E00,0x2000,0x1F80,0x0040,
  0xE000,0x007F,0xF800,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0003,0x0000,0x0000,0x2000,0x0F00,0x0040,
  0xC000,0x00FF,0xFC00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x0000,0x0000,0x2000,0x0200,0x0040,
  0xC000,0x00FF,0xFC00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x0000,0x0000,0x2000,0x0000,0x0040,
  0x8000,0x00FF,0xFC00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x0000,0x0000,0x2000,0x0000,0x0000,
  0x0000,0x01FF,0xFE00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x0000,0x0000,0x2000,0x0000,0x0000,
  0x8000,0x01FF,0xFE00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x8000,0x0000,0x2000,0x0000,0x0000,
  0xE000,0x01FF,0xFE00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0001,0x8000,0x0000,0x3000,0x0000,0x0000,
  0xFC00,0x03FF,0xFF00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0000,0xC000,0x0000,0x3000,0x0000,0x0000,
  0xFF80,0x03FF,0xFF00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0000,0xC000,0x0000,0x3000,0x0000,0x0000,
  0xFFF0,0x03FF,0xFF00,0x0000,0x0000,0x3F80,0x0007,0xFFC0,0x0000,0xE000,0x0000,0x3800,0x0000,0x0000,
  0xFFFF,0x87FF,0xFF80,0x0000,0x0000,0x3F80,0x0007,0xFF80,0x0000,0xF000,0x0000,0x3C00,0x0000,0x0000,
  0xFFFF,0xE7FF,0xFFFF,0xFFC0,0x0000,0x3F80,0x0007,0xFF80,0x0000,0xF800,0x0000,0x3E00,0x0000,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x0000,0x3F80,0x0007,0xFF80,0x0000,0x7C00,0x0000,0x7F00,0x0000,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xC000,0x3F80,0x0007,0xFF80,0x0000,0x7E00,0x0000,0xFF80,0x0000,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xF000,0x3F80,0x0007,0xFF80,0x0000,0x7F00,0x0001,0xFFC0,0x0000,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFC00,0x3F80,0x0007,0xFF80,0x0000,0x7F80,0x0003,0xFFF0,0x0000,0x0000,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFF00,0x3F80,0x0007,0xFF80,0x0000,0x3FE0,0x000F,0xFFFE,0x0000,0x01C0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,0x3F80,0x0007,0xFF80,0x0000,0x3FFC,0x003F,0xFFFF,0xFE00,0x7FC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF0,0x3F80,0x0007,0xFFF8,0x0000,0x3FFF,0x83FF,0xFFFF,0xFF07,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFC,0x3F80,0x0007,0xFFFF,0xE000,0x3FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x3F80,0x0007,0xFFFF,0xFE00,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFF0,0x1FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
  0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x0FFF,0xFFFF,0xFFFF,0xFFFF,0xFFC0,
};

EXPORT UWORD OriginalAboutData[114 * ABOUTDEPTH] = {
  /* Plane 0 */
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0x87FF,0xFFF0,
  0xFFFF,0x87FF,0xFFF0,
  0xFFFF,0x0FFF,0xFFF0,
  0xFFFF,0x0FFF,0xFFF0,
  0xFFFE,0x1FFF,0xFFF0,
  0xFFFE,0x1FFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFF70,
  0xFFFF,0xFFFF,0xFEF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xC3F0,0xFFFE,0x0F30,
  0xC3F0,0xFFFF,0xFFF0,
  0xE1E1,0xFFFF,0xFFF0,
  0xE1E1,0xFFFF,0xFBF0,
  0xFFFF,0xFFFF,0xFBF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xF87F,0xFFFF,0xFFF0,
  0xF87F,0xFFFF,0xFFF0,
  0xFF0F,0xFFFF,0xFFF0,
  0xFF0F,0xFFFF,0xFFF0,
  0xFE1F,0xFFFF,0xFFF0,
  0xFE1F,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  /* Plane 1 */
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFBFF,0xFFF0,
  0xFFFF,0xFBFF,0xFFF0,
  0xFFFF,0xF1FF,0xFFF0,
  0xFFFF,0xF1FF,0xFFF0,
  0xFFFF,0xF0FF,0xFFF0,
  0xFFFF,0xF0FF,0xFFF0,
  0xFFFF,0xF87F,0xFBF0,
  0xFFFF,0xF87F,0xDB70,
  0xFFFF,0xFC3F,0xEEF0,
  0xFFFF,0xFC3F,0xFFF0,
  0xC3FF,0x0001,0xFFF0,
  0xC3FF,0x001F,0xFFF0,
  0xE1FE,0x1F0F,0xFFF0,
  0xE1FE,0x0F0F,0xFBF0,
  0xF0C3,0x8387,0xFBF0,
  0xF0C3,0xE187,0xFFF0,
  0xFF87,0xF843,0xFFF0,
  0xFF87,0xFC03,0xFFF0,
  0xFF0F,0xFF01,0xFFF0,
  0xFF0F,0xFF81,0xFFF0,
  0xFE1F,0xFFE0,0xFFF0,
  0xFE1F,0xFFF0,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  /* Plane 2 */
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0x83FF,0xFFF0,
  0xFFFF,0x83FF,0xFFF0,
  0xFFFF,0x01FF,0xFFF0,
  0xFFFF,0x01FF,0xFFF0,
  0xFFFE,0x10FF,0xFFF0,
  0xFFFE,0x10FF,0xFFF0,
  0xFFFC,0x387F,0xFBF0,
  0xFFFC,0x387F,0xFBF0,
  0xFFF8,0x7C3F,0xFFF0,
  0xFFF8,0x7C3F,0xFBF0,
  0xFFF0,0x0001,0xF1F0,
  0xFFF0,0x001F,0xFBF0,
  0xFFE0,0x1F0F,0xFEF0,
  0xFFE0,0x0F0F,0xFB70,
  0xFFC3,0x8387,0xFBF0,
  0xFFC3,0xE187,0xFFF0,
  0xFF87,0xF843,0xFFF0,
  0xFF87,0xFC03,0xFFF0,
  0xFF0F,0xFF01,0xFFF0,
  0xFF0F,0xFF81,0xFFF0,
  0xFE1F,0xFFE0,0xFFF0,
  0xFE1F,0xFFF0,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  0xFFFF,0xFFFF,0xFFF0,
  /* Plane 3 */
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0003,0xC000,0x0000,
  0x0003,0xC000,0x2080,
  0x0007,0x8000,0x1100,
  0x0007,0x8000,0x0000,
  0x000F,0x001F,0xF0C0,
  0x000F,0x0000,0x0000,
  0x001E,0x0000,0x0100,
  0x001E,0x0000,0x0080,
  0x003C,0x0000,0x0000,
  0x003C,0x0000,0x0000,
  0x0078,0x0000,0x0000,
  0x0078,0x0000,0x0000,
  0x00F0,0x0000,0x0000,
  0x00F0,0x0000,0x0000,
  0x01E0,0x0000,0x0000,
  0x01E0,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0E3B,0x91E3,0x8880,
  0x1124,0x9224,0x4C80,
  0x1124,0x9204,0x4C80,
  0x1F24,0x9207,0xCA80,
  0x1124,0x9264,0x4980,
  0x1124,0x9224,0x4980,
  0x1120,0x91E4,0x4880,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  /* Plane 4 */
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0003,0xC000,0x0400,
  0x0003,0xC000,0x0400,
  0x0007,0x8000,0x0000,
  0x0007,0x8000,0x0000,
  0x000F,0x0001,0xF000,
  0x000F,0x0000,0x0000,
  0x1E1E,0x0000,0x1000,
  0x1E1E,0x0000,0x2400,
  0x0F3C,0x0000,0x0400,
  0x0F3C,0x0000,0x0000,
  0x07F8,0x0000,0x0000,
  0x07F8,0x0000,0x0000,
  0x03F0,0x0000,0x0000,
  0x03F0,0x0000,0x0000,
  0x01E0,0x0000,0x0000,
  0x01E0,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0E3B,0x91E3,0x8880,
  0x1124,0x9224,0x4C80,
  0x1124,0x9204,0x4C80,
  0x1F24,0x9207,0xCA80,
  0x1124,0x9264,0x4980,
  0x1124,0x9224,0x4980,
  0x1120,0x91E4,0x4880,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  /* Plane 5 */
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0400,
  0x0000,0x0000,0x0400,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0400,
  0x0000,0x0000,0x0400,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000
};

IMPORT UWORD OriginalMapData[71700],
             OriginalAfroData[6][RAFRICANS][COUNTERHEIGHT * 2 * COUNTERDEPTH],
             OriginalEuroData[2][EUROPEANS][COUNTERHEIGHT * 2 * COUNTERDEPTH];

// 8. EXPORTED STRUCTURES ------------------------------------------------

EXPORT struct AfroStruct a[RAFRICANS];
EXPORT struct BoxStruct  box[6];
EXPORT struct EuroStruct e[EUROPEANS] =
{ { 2, 1 },
  { 1, 2 },
  { 0, 3 },
  { 1, 2 },
  { 3, 0 }
};

EXPORT struct SetupStruct setup[RAFRICANS] =
{ { USA   , 4, 7, 10, 10, 4, OTHER , SOUTHAFRICA}, // South Africa
  { USA   , 0, 0,  0,  5, 2, OTHER , SOUTHAFRICA}, // Namibia
  { UK    , 3, 4,  2,  3, 1, OTHER , BOTSWANA   }, // Botswana
  { USA   , 4, 7,  4,  5, 2, LEADER, RHODESIA   }, // Rhodesia
  { USSR  , 5, 5,  4,  5, 2, JUNTA , MOZAMBIQUE }, // Mozambique
  { USSR  , 7, 4,  4,  5, 2, JUNTA , ANGOLA     }, // Angola
  { UK    , 2, 5,  4,  5, 2, LEADER, ZAMBIA     }, // Zambia
  { UK    , 3, 5,  1,  1, 1, OTHER , MALAWI     }, // Malawi
  { FRANCE, 5, 5,  1,  1, 1, JUNTA , GABON      }, // Gabon
  { FRANCE, 4, 4,  2,  3, 1, LEADER, CONGO      }, // Congo
  { USA   , 5, 3,  4,  8, 2, LEADER, ZAIRE      }, // Zaire
  { CHINA , 7, 6,  4,  5, 2, JUNTA , TANZANIA   }, // Tanzania
  { UK    , 0, 3,  2,  3, 1, LEADER, UGANDA     }, // Uganda
  { UK    , 4, 6,  4,  5, 2, LEADER, KENYA      }, // Kenya
  { USA   , 0, 0,  0,  5, 0, OTHER , SOUTHAFRICA}, // South African rebels
  { USA   , 0, 0,  0,  5, 0, OTHER , SOUTHAFRICA}, // Namibian rebels
  { UK    , 0, 0,  0,  3, 0, OTHER , BOTSWANA   }, // Botswanan rebels
  { USA   , 0, 0,  0,  5, 0, OTHER , RHODESIA   }, // Rhodesian rebels
  { USSR  , 0, 0,  0,  5, 0, OTHER , MOZAMBIQUE }, // Mozambiquan rebels
  { USSR  , 0, 0,  0,  5, 0, OTHER , ANGOLA     }, // Angolan rebels
  { UK    , 0, 0,  0,  5, 0, OTHER , ZAMBIA     }, // Zambian rebels
  { UK    , 0, 0,  0,  1, 0, OTHER , MALAWI     }, // Malawian rebels
  { FRANCE, 0, 0,  0,  1, 0, OTHER , GABON      }, // Gabonese rebels
  { FRANCE, 0, 0,  0,  3, 0, OTHER , CONGO      }, // Congolese rebels
  { USSR  , 4, 3,  2,  5, 1, OTHER , ZAIRE_R    }, // Zairean rebels
  { CHINA , 0, 0,  0,  5, 0, OTHER , TANZANIA   }, // Tanzanian rebels
  { UK    , 0, 0,  0,  3, 0, OTHER , UGANDA     }, // Ugandan rebels
  { UK    , 0, 0,  0,  5, 0, OTHER , KENYA      }, // Kenyan rebels
}; // .cities is used only for setting up. so it is safe to set it to only 2 for Zaire, and 0 for most rebels.

EXPORT struct CityStruct city[CITIES] =
{ { 0,  1, 1, "Libreville"     , "Libreville"      , GABON      }, //  0
  { 5,  1, 2, "Kisangani"      , "Stanleyville"    , ZAIRE      },
  { 8,  1, 2, "Kampala"        , "Kampala"         , UGANDA     },
  {10,  2, 2, "Nairobi"        , "Nairobi"         , KENYA      },
  { 1,  3, 2, "Brazzaville"    , "Brazzaville"     , CONGO      },
  {11,  3, 2, "Mombasa"        , "Mombasa"         , KENYA      }, //  5
  { 2,  4, 2, "Kinshasa"       , "Leopoldville"    , ZAIRE      },
  { 8,  4, 2, "Kigoma"         , "Kigoma"          , TANZANIA   },
  {10,  5, 2, "Dar-Es-Salaam"  , "Dar-Es-Salaam"   , TANZANIA   },
  { 2,  6, 2, "Luanda"         , "Loanda"          , ANGOLA     },
  { 6,  6, 2, "Lubumbashi"     , "Elisabethville"  , ZAIRE      }, // 10
  { 7,  7, 2, "Mpika"          , "Mpika"           , ZAMBIA     },
  { 2,  8, 2, "Mossamedes"     , "Mossamedes"      , ANGOLA     },
  {11,  8, 2, "Mozambique City", "Mozambique City" , MOZAMBIQUE },
  { 6,  9, 2, "Lusaka"         , "Lusaka"          , ZAMBIA     },
  { 9,  9, 1, "Zomba"          , "Zomba"           , MALAWI     }, // 15
  { 8, 10, 2, "Salisbury"      , "Salisbury"       , RHODESIA   },
  { 9, 10, 2, "Maputo"         , "Lourenco Marques", MOZAMBIQUE },
  { 6, 11, 2, "Bulawayo"       , "Bulawayo"        , RHODESIA   },
  { 2, 12, 2, "Swakopmund"     , "Swakopmund"      , NAMIBIA    },
  { 3, 12, 2, "Windhoek"       , "Windhoek"        , NAMIBIA    }, // 20
  { 5, 12, 2, "Gaberones"      , "Gaberones"       , BOTSWANA   },
  { 6, 13, 2, "Johannesberg"   , "Johannesberg"    , SOUTHAFRICA},
  { 5, 15, 2, "Kimberley"      , "Kimberley"       , SOUTHAFRICA},
  { 7, 15, 2, "Durban"         , "Port Natal"      , SOUTHAFRICA},
  { 3, 17, 2, "Cape Town"      , "Cape Town"       , SOUTHAFRICA}  // 25
};

EXPORT struct TextAttr Topaz8 =
{   "topaz.font", // ta_Name (case-sensitive)
    8,            // ta_YSize
    FS_NORMAL,    // ta_Style
    FPF_ROMFONT   // ta_Flags
};

// 7. MODULE STRUCTURES --------------------------------------------------

/* MODULE */ struct NameNode
{   struct Node nn_Node;
    UBYTE       nn_Data[MAX_NODELENGTH];
};

MODULE STRPTR CycleOptions[2 + 1]  = {"", "Amiga", NULL};
MODULE STRPTR PlayerOptions[4 + 1] = {"2", "3", "4", "5", NULL};

MODULE struct NewMenu NewMenu[] =
{   { NM_TITLE, ""         ,  0 , 0,                    0, 0}, //  0 INDEX_PROJECT
    {  NM_ITEM, ""         , "N", 0,                    0, 0}, //  1 INDEX_NEW
    {  NM_ITEM, ""         , "O", 0,                    0, 0}, //  2 INDEX_OPEN
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //  3
    {  NM_ITEM, ""         , "S", 0,                    0, 0}, //  4 INDEX_SAVE
    {  NM_ITEM, ""         , "A", 0,                    0, 0}, //  5 INDEX_SAVE_AS
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //  6
    {  NM_ITEM, ""         ,  0 , 0,                    0, 0}, //  7 INDEX_QUITTITLE
    {  NM_ITEM, ""         , "Q", 0,                    0, 0}, //  8 INDEX_QUITDOS
    { NM_TITLE, ""         ,  0 , 0,                    0, 0}, //  9 INDEX_SETTINGS
    {  NM_ITEM, ""         , "B", CHECKIT | MENUTOGGLE, 0, 0}, // 10 INDEX_SHOW_TITLEBAR
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 11
    {  NM_ITEM, ""         , "W", CHECKIT | MENUTOGGLE, 0, 0}, // 12 INDEX_WATCH_AMIGA
    { NM_TITLE, ""         ,  0 , 0,                    0, 0}, // 13 INDEX_HELP
    {  NM_ITEM, ""         , "G", 0,                    0, 0}, // 14 INDEX_GAME_SUMMARY
    {  NM_ITEM, ""         , "H", 0,                    0, 0}, // 15 INDEX_SCORE_GRAPH
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 16
    {  NM_ITEM, ""         ,  0 , NM_ITEMDISABLED,      0, 0}, // 17 INDEX_MANUAL
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 18
    {  NM_ITEM, ""         , "?", 0,                    0, 0}, // 19 INDEX_ABOUT
    {   NM_END, NULL       ,  0 , 0,                    0, 0}  // 20
};

#define ORDER_PI             0
#define ORDER_RAISE_IS       1
#define ORDER_LOWER_IS       2
#define ORDER_INSTALL_LEADER 3
#define ORDER_INSTALL_JUNTA  4
#define ORDER_BUILD_IU       5
#define ORDER_MAINTAIN_IU    6
#define ORDER_GIVE_MONEY     7
#define ORDER_DONE           8

// If a country is not under its own leadership (ie. if it has been
// conquered, eg. Namibia), it effectively does not exist.

// These are better to not be allocated on the stack
MODULE ULONG table1[] = {(17 << 16) + 0,
    0x00000000, 0x00000000, 0x00000000, //   0 BLACK
    0x88888888, 0x88888888, 0x88888888, //   1 GREY
    0xFFFFFFFF, 0x00000000, 0x00000000, //   2 RED              (used by counters)
    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, //   3 WHITE            (used by counters)
    0x00000000, 0x00000000, 0xFFFFFFFF, //   4 BLUE             (used by counters)
    0x00000000, 0x00000000, 0x00000000, //   5 map black (eg. hex borders)
    0xAAAAAAAA, 0xFFFFFFFF, 0xAAAAAAAA, //   6 GREEN
    0x00000000, 0x00000000, 0x00000000, //   7 counter black    (used by counters)
    0x66666666, 0x66666666, 0x66666666, //   8 DARKGREY
    0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB, //   9 LIGHTGREY
    0x77777777, 0x77777777, 0xFFFFFFFF, //  10 colour of USA    (blue)
    0xFFFFFFFF, 0x55555555, 0x55555555, //  11 colour of USSR   (red)
    0x55555555, 0xFFFFFFFF, 0x55555555, //  12 colour of CHINA  (green)
    0xFFFFFFFF, 0xFFFFFFFF, 0x55555555, //  13 colour of FRANCE (yellow)
    0xFFFFFFFF, 0x55555555, 0xFFFFFFFF, //  14 colour of UK     (purple)
    0x99999999, 0x99999999, 0x99999999, //  15 MAPBACKGROUND
    0x00000000, 0xAAAAAAAA, 0x00000000, //  16 DARKGREEN        (used by counters)
    // 17-19 are pointer colours.
0},
table2[] = {(44 << 16) + 20,
    0x00000000, 0x88888888, 0xFFFFFFFF, //  20 Amigan logo (blue-cyan)
    0x00000000, 0xFFFFFFFF, 0xFFFFFFFF, //  21 Amigan logo (cyan)
    0x00000000, 0xFFFFFFFF, 0x88888888, //  22 Amigan logo (cyan-green)
    0x00000000, 0xFFFFFFFF, 0x00000000, //  23 Amigan logo (green)
    0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, //  24 Amigan logo (yellow)
    0xFFFFFFFF, 0xCCCCCCCC, 0x00000000, //  25 Amigan logo
    0xFFFFFFFF, 0x88888888, 0x00000000, //  26 Amigan logo
    0xFFFFFFFF, 0x44444444, 0x00000000, //  27 Amigan logo
    0x00000000, 0x00000000, 0x00000000, //  28 dimmest border   (not used          in public screen mode)
    0x00000000, 0x00000000, 0x00000000, //  29 dimmer border    (not used          in public screen mode)
    0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB, //  30 poor city on map (becomes LIGHTGREY in public screen mode)
    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, //  31 rich city on map (becomes WHITE     in public screen mode) & counter white
    0x00000000, 0x00000000, 0x00000000, //  32 South Africa
    0x00000000, 0x00000000, 0x00000000, //  33 Namibia
    0x00000000, 0x00000000, 0x00000000, //  34 Botswana
    0x00000000, 0x00000000, 0x00000000, //  35 Rhodesia-Zimbabwe
    0x00000000, 0x00000000, 0x00000000, //  36 Mozambique
    0x00000000, 0x00000000, 0x00000000, //  37 Angola
    0x00000000, 0x00000000, 0x00000000, //  38 Zambia
    0x00000000, 0x00000000, 0x00000000, //  39 Malawi
    0x00000000, 0x00000000, 0x00000000, //  40 Gabon
    0x00000000, 0x00000000, 0x00000000, //  41 Congo
    0x00000000, 0x00000000, 0x00000000, //  42 Zaire
    0x00000000, 0x00000000, 0x00000000, //  43 Tanzania
    0x00000000, 0x00000000, 0x00000000, //  44 Uganda
    0x00000000, 0x00000000, 0x00000000, //  45 Kenya
    0x00000000, 0x00000000, 0x00000000, //  46 South African rebels
    0x00000000, 0x00000000, 0x00000000, //  47 Namibian rebels
    0x00000000, 0x00000000, 0x00000000, //  48 Botswanan rebels
    0x00000000, 0x00000000, 0x00000000, //  49 Rhodesian rebels
    0x00000000, 0x00000000, 0x00000000, //  50 Mozambiquan rebels
    0x00000000, 0x00000000, 0x00000000, //  51 Angolan rebels
    0x00000000, 0x00000000, 0x00000000, //  52 Zambian rebels
    0x00000000, 0x00000000, 0x00000000, //  53 Malawian rebels
    0x00000000, 0x00000000, 0x00000000, //  54 Gabonese rebels
    0x00000000, 0x00000000, 0x00000000, //  55 Congolese rebels
    0x00000000, 0x00000000, 0x00000000, //  56 Zairean rebels
    0x00000000, 0x00000000, 0x00000000, //  57 Tanzanian rebels
    0x00000000, 0x00000000, 0x00000000, //  58 Ugandan rebels
    0x00000000, 0x00000000, 0x00000000, //  59 Kenyan rebels
    0xFFFFFFFF, 0xBBBBBBBB, 0x77777777, //  60 BARCOLOUR        (always becomes DARKGREEN) (not used in public screen mode)
    0x00000000, 0xFFFFFFFF, 0x00000000, //  61 brighter border           (not used in public screen mode)
    0x00000000, 0xFFFFFFFF, 0x88888888, //  62 brightest border          (not used in public screen mode)
    0x00000000, 0x00000000, 0x00000000, //  63 highlighted GadTools text (not used in public screen mode)
0};

MODULE struct NewGadget SpeedGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, RoundsGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, PlayersGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, UKIUGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, EndlessGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
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
}, AutoSetupGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, ColonialGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, MaintainGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, CycleGadget[EUROPEANS] =
{ { 0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
} },
EList1Gadget =
{     8, 24,
    160, 90,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, EList2Gadget =
{   173, 24,
    375, 90,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, DoneGadget =
{   322,  6,
    112, 14,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, RedoGadget =
{   436,  6,
    112, 14,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
};

EXPORT UWORD *AfroData[6][RAFRICANS],
             *EuroData[2][EUROPEANS];
MODULE UWORD *AboutData = NULL,
             *LogoData  = NULL,
             *MapData   = NULL;

EXPORT struct Image About =
{   0, 0,
    44, 38, 8,
    NULL,
    0xff, 0x0,
    NULL
}, Counter =
{   0, 0,
    21, COUNTERHEIGHT, 8,
    NULL,
    0xFF, 0,
    NULL
}, MapImage =
{   0, 0,
    391, 478, 8,
    NULL,
    0xFF, 0x0,
    NULL
};

MODULE struct Image Logo =
{   0, 0,
    218, 90, 8,
    NULL,
    0xff, 0x0,
    NULL
}, Corner =
{   0, 0,
    7, 7, 6,
    NULL,
    0x3f, 0x0,
    NULL
};

// 9. MODULE FUNCTIONS ---------------------------------------------------

MODULE void gameloop(void);
MODULE void system_newgame(void);
MODULE void titlescreen(void);
MODULE void savegame(FLAG saveas, FLAG autosaving);
MODULE SLONG checkcountry(WORD mousex, WORD mousey);
MODULE void cycle(SLONG we, UWORD qual);
#ifdef __amigaos4__
    MODULE void AddNameToTail(struct List* ListPtr, const char* name);
#else
    MODULE void AddNameToTail(struct List* ListPtr, STRPTR name);
#endif
MODULE void FreeNameNodes(struct List* ListPtr);
MODULE void showcountry(SLONG wa);
MODULE void afrocolours(void);
MODULE void close_eorders(void);
MODULE void changerounds(void);
MODULE void changespeed(void);
MODULE void clearscreen(void);
MODULE void shadowtext_right(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y);
MODULE void shadowtextn(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y, ULONG length);
MODULE void declaredwars(void);
MODULE void scoregraph(void);
MODULE void hexhelp(void);
MODULE void drawborder(WORD leftx, WORD topy, WORD rightx, WORD bottomy);
MODULE void border(SLONG we);
MODULE FLAG handlemenu(UWORD code, FLAG ingame);
MODULE void parsewb(void);
MODULE void handle_idcmp(ULONG class, UWORD code, UWORD qual, WORD mousex, WORD mousey, struct Gadget* addr, VOID* msg);

// 10. EXPORTED (PUBLIC) FUNCTIONS ---------------------------------------

EXPORT int main(int argc, char** argv)
{   TRANSIENT int                           i, j,
                                            len1, len2;
    TRANSIENT BPTR                          FileHandle /* = ZERO */ ,
                                            OldDir;
    TRANSIENT FLAG                          ok;
    TRANSIENT TEXT                          supergels[2];
    TRANSIENT SLONG                         we,
                                            args[ARGS + 1];
    TRANSIENT ULONG                         memflags = MEMF_CLEAR;
    TRANSIENT UWORD                         Pens[46] =
    {   BLACK,     /* DETAILPEN             text in title bar */
        WHITE,     /* BLOCKPEN              fill title bar */
        BLACK,     /* TEXTPEN               regular text on BACKGROUNDPEN */
        LIGHTGREY, /* SHINEPEN              bright edge */
        DARKGREY,  /* SHADOWPEN             dark edge */
        BARCOLOUR, /* FILLPEN               filling active window borders
                                            and selected gadgets */
        BLACK,     /* FILLTEXTPEN           text rendered over FILLPEN */
        GREY,      /* BACKGROUNDPEN         background colour */
        BARCOLOUR, /* HIGHLIGHTTEXTPEN      highlighted text on BACKGROUNDPEN
                                            and used against BLOCKPEN in ASL
                                            save requesters */
        BLACK,     /* BARDETAILPEN          text/detail in screen-bar/menus */
        WHITE,     /* BARBLOCKPEN           screen-bar/menus fill */
        BLACK,     /* BARTRIMPEN            trim under screen-bar */
// for OS4.0 only...
        WHITE,     /* BARCONTOURPEN         contour above screen-bar */
        GREY,      /* FOREGROUNDPEN         inside of unselected gadgets */
        LIGHTGREY, /* FORESHINEPEN          bright edges of unselected gadgets */
        DARKGREY,  /* FORESHADOWPEN         dark edges of unselected gadgets */
        LIGHTGREY, /* FILLSHINEPEN          bright edges for FILLPEN */
        DARKGREY,  /* FILLSHADOWPEN         dark edges for FILLPEN */
        GREY,      /* INACTIVEFILLPEN       inactive window borders fill */
        LIGHTGREY, /* INACTIVEFILLTEXTPEN   text over INACTIVEFILLPEN           */
        DARKGREY,  /* INACTIVEFILLSHINEPEN  bright edges for INACTIVEFILLPEN    */
        GREY,      /* INACTIVEFILLSHADOWPEN dark edges for INACTIVEFILLPEN      */
        GREY,      /* DISABLEDPEN           background of disabled elements     */
        LIGHTGREY, /* DISABLEDTEXTPEN       text of disabled string gadgets     */
        LIGHTGREY, /* DISABLEDSHINEPEN      bright edges of disabled elements   */
        DARKGREY,  /* DISABLEDSHADOWPEN     dark edges of disabled elements     */
        GREY,      /* MENUBACKGROUNDPEN     background of menus                 */
        BLACK,     /* MENUTEXTPEN           normal text in menus                */
        LIGHTGREY, /* MENUSHINEPEN          bright edges of menus               */
        DARKGREY,  /* MENUSHADOWPEN         dark edges of menus                 */
        BARCOLOUR, /* SELECTPEN             background of selected items        */
        WHITE,     /* SELECTTEXTPEN         text of selected items              */
        LIGHTGREY, /* SELECTSHINEPEN        bright edges of selected items      */
        DARKGREY,  /* SELECTSHADOWPEN       dark edges of selected items        */
        WHITE,     /* GLYPHPEN              system gadget glyphs, outlines      */
        BARCOLOUR, /* GLYPHFILLPEN          system gadget glyphs, colored areas */
        GREY,      /* INACTIVEGLYPHPEN      system gadget glyphs, inact. windows*/
        0,         /* RESERVEDPEN           reserved - don't use                */
        BLACK,     /* GADGETPEN             gadget symbols (arrows, cycle, etc.)*/
        WHITE,     /* TITLEPEN              title of gadget groups              */
        LIGHTGREY, /* HALFSHINEPEN          half-bright edge on 3D objects      */
        DARKGREY,  /* HALFSHADOWPEN         half-dark edge on 3D objects        */
        GREY,      /* FLATBORDERPEN         flat (non-3D) borders and frames    */
        BARCOLOUR, /* FILLFLATPEN           flat outlines of active windows     */
        GREY,      /* INACTIVEFILLFLATPEN   flat outlines of inactive windows   */
        (UWORD) ~0 /* and used against BLOCKPEN in ASL save requesters */
    };
    PERSIST   TEXT                          donetext[13 + 1], redotext[13 + 1];

    // Start of program.

    srand((unsigned int) time(NULL));

    // before the first possible point of failure
    NewList(&EList1);
    NewList(&EList2);
    init_counters();
    pathname[0] = EOS;
    for (i = 0; i <= ARGS; i++)
    {   args[i] = 0;
    }
    for (i = 0; i < 6; i++)
    {   for (j = 0; j < RAFRICANS; j++)
        {   AfroData[i][j] = NULL;
    }   }
    for (i = 0; i < 2; i++)
    {   for (j = 0; j < EUROPEANS; j++)
        {   EuroData[i][j] = NULL;
    }   }
    for (i = 0; i < 64; i++)
    {   gotpen[i] = FALSE;
    }

    if (
#ifdef __amigaos4__
        SysBase->lib_Version         < OS_20 // should never happen
#else
        SysBase->LibNode.lib_Version < OS_20
#endif
    )
    {   strcpy(saystring, "Africa: Need OS3.0+!\n");
        DISCARD Write(Output(), saystring, (LONG) strlen(saystring));
        cleanexit(EXIT_FAILURE);
    }

#ifdef __amigaos4__
    if (!(IntuitionBase = (struct Library*) OpenLibrary("intuition.library", OS_30)))
    {   Printf("Africa: Can't open intuition.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GfxBase = (struct Library*) OpenLibrary("graphics.library", OS_30)))
    {   Printf("Africa: Can't open graphics.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
#else
    if (!(IntuitionBase = (struct IntuitionBase*) OpenLibrary("intuition.library", OS_30)))
    {   Printf("Africa: Can't open intuition.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GfxBase = (struct GfxBase*) OpenLibrary("graphics.library", OS_30)))
    {   Printf("Africa: Can't open graphics.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
#endif
    if (!(AslBase = (struct Library*) OpenLibrary("asl.library", OS_21)))
    {   Printf("Africa: Can't open asl.library V38+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(DiskfontBase = (struct Library*) OpenLibrary("diskfont.library", OS_ANY))) // maybe we need a higher version?
    {   Printf("Africa: Can't open diskfont.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GadToolsBase = (struct Library*) OpenLibrary("gadtools.library", OS_ANY)))
    {   Printf("Africa: Can't open gadtools.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IconBase = (struct Library*) OpenLibrary("icon.library", OS_ANY)))
    {   Printf("Africa: Can't open icon.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(LocaleBase   = (struct Library*) OpenLibrary("locale.library", OS_ANY)))
    {   Printf("Africa: Can't open locale.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    AmigaGuideBase = (struct Library*) OpenLibrary("amigaguide.library", OS_ANY);

#ifdef __amigaos4__
    if (!(IIntuition = (struct IntuitionIFace*) GetInterface((struct Library*) IntuitionBase, "main", 1, NULL)))
    {   Printf("Africa: Can't get intuition.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IGraphics  = (struct GraphicsIFace* ) GetInterface((struct Library*) GfxBase,       "main", 1, NULL)))
    {   Printf("Africa: Can't get graphics.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IAsl       = (struct AslIFace*      ) GetInterface((struct Library*) AslBase,       "main", 1, NULL)))
    {   Printf("Africa: Can't get asl.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IDiskfont  = (struct DiskfontIFace* ) GetInterface((struct Library*) DiskfontBase,  "main", 1, NULL)))
    {   Printf("Africa: Can't get diskfont.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IAmigaGuide = (struct AmigaGuideIFace*) GetInterface((struct Library*) AmigaGuideBase, "main", 1, NULL)))
    {   Printf("Africa: Can't get amigaguide.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IGadTools   = (struct GadToolsIFace*  ) GetInterface((struct Library*) GadToolsBase,   "main", 1, NULL)))
    {   Printf("Africa: Can't get gadtools.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IIcon       = (struct IconIFace*      ) GetInterface((struct Library*) IconBase,       "main", 1, NULL)))
    {   Printf("Africa: Can't get icon.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(ILocale     = (struct LocaleIFace*    ) GetInterface((struct Library*) LocaleBase,     "main", 1, NULL)))
    {   Printf("Africa: Can't get locale.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
#endif

    if (FindResident("MorphOS"))
    {   morphos = TRUE;
    }
    if
    (   !morphos
     && (    execver >  53
         || (execver == 53 && execrev >= 12)
    )   ) // if (OS4.1.1) or later
    {   urlopen = TRUE;
    } else
    {   if ((OpenURLBase = (struct Library*) OpenLibrary("openurl.library", OS_ANY)))
        {   ;
#ifdef __amigaos4__
            if (!(IOpenURL    = (struct OpenURLIFace*   ) GetInterface((struct Library*) OpenURLBase,    "main", 1, NULL)))
            {   Printf("Africa: Can't get openurl.library interface!\n");
                cleanexit(EXIT_FAILURE);
            }
#endif
    }   }

    if (morphos)
    {   Topaz8.ta_Flags = FPF_DISKFONT;
    }
    if (DiskfontBase)
    {   FontPtr = (struct TextFont*) OpenDiskFont(&Topaz8);
    }

    ProcessPtr = (struct Process*) FindTask(NULL);
    TheIntuitionBase = (struct IntuitionBase*) IntuitionBase; // needed for OS4

    if (GetVar("cybergfx/supergels", supergels, 2, 0) == 1)
    {   if (supergels[0] == '1')
        {   DISCARD Printf("Africa: ENV:cybergfx/supergels must be cleared to 0 before playing!\n");
            cleanexit(EXIT_FAILURE);
    }   }

    e[USA   ].control = CONTROL_AMIGA;
    e[USSR  ].control = CONTROL_AMIGA;
    e[CHINA ].control = CONTROL_AMIGA;
    e[FRANCE].control = CONTROL_AMIGA;
    e[UK    ].control = CONTROL_HUMAN;

    li.li_Catalog = NULL;
    if (LocaleBase)
    {   li.li_LocaleBase = LocaleBase;
        li.li_Catalog    =
        CatalogPtr       = OpenCatalog(NULL, "Africa.catalog" , TAG_DONE);
        StdCatalogPtr    = OpenCatalog(NULL, "generic.catalog", TAG_DONE);
    }

    len1   = strlen((STRPTR) LLL(MSG_INFINITE, "Infinite"  ))    ;
    len2   = strlen((STRPTR) LLL(MSG_SECS,     "%d.%d secs")) - 2;
    maxlen = (len1 > len2) ? len1 : len2;

    NewMenu[ 0].nm_Label      = (STRPTR) LLL(MSG_MENU_PROJECT     , "Project"                    );
    NewMenu[ 1].nm_Label      = (STRPTR) LLL(MSG_MENU_NEW         , "New"                        );
    NewMenu[ 1].nm_CommKey    = (STRPTR) LLL(MSG_KEY_NEW          , "N"                          );
    NewMenu[ 2].nm_Label      = (STRPTR) LLL(MSG_MENU_OPEN        , "Open..."                    );
    NewMenu[ 2].nm_CommKey    = (STRPTR) LLL(MSG_KEY_OPEN         , "O"                          );
    NewMenu[ 4].nm_Label      = (STRPTR) LLL(MSG_MENU_SAVE1       , "Save"                       );
    NewMenu[ 4].nm_CommKey    = (STRPTR) LLL(MSG_KEY_SAVE         , "S"                          );
    NewMenu[ 5].nm_Label      = (STRPTR) LLL(MSG_MENU_SAVEAS      , "Save as..."                 );
    NewMenu[ 5].nm_CommKey    = (STRPTR) LLL(MSG_KEY_SAVEAS       , "A"                          );
    NewMenu[ 7].nm_Label      = (STRPTR) LLL(MSG_QUITTITLE        , "Quit to title screen"       );
    NewMenu[ 8].nm_Label      = (STRPTR) LLL(MSG_MENU_QUITWB      , "Quit Africa"                );
    NewMenu[ 8].nm_CommKey    = (STRPTR) LLL(MSG_KEY_QUIT         , "Q"                          );
    NewMenu[ 9].nm_Label      = (STRPTR) LLL(MSG_MENU_SETTINGS    , "Settings"                   );
    NewMenu[10].nm_Label      = (STRPTR) LLL(MSG_SHOW_TITLEBAR    , "Show titlebar?"             );
    NewMenu[12].nm_Label      = (STRPTR) LLL(MSG_W_A_M            , "Watch Amiga movements?"     );
    NewMenu[13].nm_Label      = (STRPTR) LLL(MSG_MENU_HELP        , "Help"                       );
    NewMenu[14].nm_Label      = (STRPTR) LLL(MSG_DECLARED_WARS    , "Declared wars..."           );
    NewMenu[15].nm_Label      = (STRPTR) LLL(MSG_H_S_G            , "Historical score graph..."  );
    NewMenu[17].nm_Label      = (STRPTR) LLL(MSG_MENU_MANUAL      , "Manual..."                  );
    NewMenu[17].nm_CommKey    = (STRPTR) LLL(MSG_KEY_MANUAL       , "M"                          );
    NewMenu[19].nm_Label      = (STRPTR) LLL(MSG_ABOUT2           , "About Africa..."            );
    NewMenu[19].nm_CommKey    = (STRPTR) LLL(MSG_KEY_ABOUT        , "?"                          );
    CycleOptions[0]           = (STRPTR) LLL(MSG_HUMAN            , "Human"                      );
    StartGadget.ng_GadgetText = (STRPTR) LLL(MSG_RETURN_START_GAME, "Start Game (ENTER/Spacebar)");

    e[0].name            = (STRPTR) LLL(MSG_EURO_USA     , "USA"                      ) ;
    e[1].name            = (STRPTR) LLL(MSG_EURO_USSR    , "USSR"                     ) ;
    e[2].name            = (STRPTR) LLL(MSG_EURO_CHINA   , "China"                    ) ;
    e[3].name            = (STRPTR) LLL(MSG_EURO_FRANCE  , "France"                   ) ;
    e[4].name            = (STRPTR) LLL(MSG_EURO_UK      , "UK"                       ) ;
    e[0].adjective       = (STRPTR) LLL(MSG_AMERICAN     , "American"                 ) ;
    e[1].adjective       = (STRPTR) LLL(MSG_SOVIET       , "Soviet"                   ) ;
    e[2].adjective       = (STRPTR) LLL(MSG_CHINESE      , "Chinese"                  ) ;
    e[3].adjective       = (STRPTR) LLL(MSG_FRENCH       , "French"                   ) ;
    e[4].adjective       = (STRPTR) LLL(MSG_BRITISH      , "British"                  ) ;
    sprintf(cyclename[0], "%s:",    LLL(MSG_EURO_USA     , "USA"                      ));
    sprintf(cyclename[1], "%s:",    LLL(MSG_EURO_USSR    , "USSR"                     ));
    sprintf(cyclename[2], "%s:",    LLL(MSG_EURO_CHINA   , "China"                    ));
    sprintf(cyclename[3], "%s:",    LLL(MSG_EURO_FRANCE  , "France"                   ));
    sprintf(cyclename[4], "%s:",    LLL(MSG_EURO_UK      , "UK"                       ));
    sprintf(donetext, "%s (_D)",    LLL(MSG_GAD_DONE     , "Done"                     ));
    DoneGadget.ng_GadgetText      = donetext;
    sprintf(redotext, "%s (_R)",    LLL(MSG_GAD_REDO     , "Redo"                     ));
    RedoGadget.ng_GadgetText      = redotext;
    aname[0][ 0] = (STRPTR) LLL(MSG_SOUTHAFRICA       , "South Africa"             );
    aname[0][ 1] = (STRPTR) LLL(MSG_NAMIBIA           , "Namibia"                  );
    aname[0][ 2] = (STRPTR) LLL(MSG_BOTSWANA          , "Botswana"                 );
    aname[0][ 3] = (STRPTR) LLL(MSG_RHODESIA          , "Rhodesia"                 );
    aname[0][ 4] = (STRPTR) LLL(MSG_MOZAMBIQUE        , "Mozambique"               );
    aname[0][ 5] = (STRPTR) LLL(MSG_ANGOLA            , "Angola"                   );
    aname[0][ 6] = (STRPTR) LLL(MSG_ZAMBIA            , "Zambia"                   );
    aname[0][ 7] = (STRPTR) LLL(MSG_MALAWI            , "Malawi"                   );
    aname[0][ 8] = (STRPTR) LLL(MSG_GABON             , "Gabon"                    );
    aname[0][ 9] = (STRPTR) LLL(MSG_CONGO             , "Congo"                    );
    aname[0][10] = (STRPTR) LLL(MSG_ZAIRE             , "Zaire"                    );
    aname[0][11] = (STRPTR) LLL(MSG_TANZANIA          , "Tanzania"                 );
    aname[0][12] = (STRPTR) LLL(MSG_UGANDA            , "Uganda"                   );
    aname[0][13] = (STRPTR) LLL(MSG_KENYA             , "Kenya"                    );
    aname[0][14] = (STRPTR) LLL(MSG_REB_SOUTHAFRICA   , "South African rebels"     );
    aname[0][15] = (STRPTR) LLL(MSG_REB_NAMIBIA       , "Namibian rebels"          );
    aname[0][16] = (STRPTR) LLL(MSG_REB_BOTSWANA      , "Botswanan rebels"         );
    aname[0][17] = (STRPTR) LLL(MSG_REB_RHODESIA      , "Rhodesian rebels"         );
    aname[0][18] = (STRPTR) LLL(MSG_REB_MOZAMBIQUE    , "Mozambiquan rebels"       );
    aname[0][19] = (STRPTR) LLL(MSG_REB_ANGOLA        , "Angolan rebels"           );
    aname[0][20] = (STRPTR) LLL(MSG_REB_ZAMBIA        , "Zambian rebels"           );
    aname[0][21] = (STRPTR) LLL(MSG_REB_MALAWI        , "Malawian rebels"          );
    aname[0][22] = (STRPTR) LLL(MSG_REB_GABON         , "Gabonese rebels"          );
    aname[0][23] = (STRPTR) LLL(MSG_REB_CONGO         , "Congolese rebels"         );
    aname[0][24] = (STRPTR) LLL(MSG_REB_ZAIRE         , "Zairean rebels"           );
    aname[0][25] = (STRPTR) LLL(MSG_REB_TANZANIA      , "Tanzanian rebels"         );
    aname[0][26] = (STRPTR) LLL(MSG_REB_UGANDA        , "Ugandan rebels"           );
    aname[0][27] = (STRPTR) LLL(MSG_REB_KENYA         , "Kenyan rebels"            );
    aname[1][ 0] = (STRPTR) LLL(MSG_OLD_SOUTHAFRICA   , "South Africa"             );
    aname[1][ 1] = (STRPTR) LLL(MSG_OLD_NAMIBIA       , "German SW Africa"         );
    aname[1][ 2] = (STRPTR) LLL(MSG_OLD_BOTSWANA      , "Bechuanaland"             );
    aname[1][ 3] = (STRPTR) LLL(MSG_OLD_RHODESIA      , "S. Rhodesia"              );
    aname[1][ 4] = (STRPTR) LLL(MSG_OLD_MOZAMBIQUE    , "Portuguese E. Africa"     );
    aname[1][ 5] = (STRPTR) LLL(MSG_OLD_ANGOLA        , "Portuguese W. Africa"     );
    aname[1][ 6] = (STRPTR) LLL(MSG_OLD_ZAMBIA        , "N. Rhodesia"              );
    aname[1][ 7] = (STRPTR) LLL(MSG_OLD_MALAWI        , "Nyasaland"                );
    aname[1][ 8] = (STRPTR) LLL(MSG_OLD_GABON         , "Gabon"                    );
    aname[1][ 9] = (STRPTR) LLL(MSG_OLD_CONGO         , "French Congo"             );
    aname[1][10] = (STRPTR) LLL(MSG_OLD_ZAIRE         , "Belgian Congo"            );
    aname[1][11] = (STRPTR) LLL(MSG_OLD_TANZANIA      , "German E. Africa"         );
    aname[1][12] = (STRPTR) LLL(MSG_OLD_UGANDA        , "Uganda"                   );
    aname[1][13] = (STRPTR) LLL(MSG_OLD_KENYA         , "British E. Africa"        );
    aname[1][14] = (STRPTR) LLL(MSG_OLDREB_SOUTHAFRICA, "South African rebels"     );
    aname[1][15] = (STRPTR) LLL(MSG_OLDREB_NAMIBIA    , "German SW African rebels" );
    aname[1][16] = (STRPTR) LLL(MSG_OLDREB_BOTSWANA   , "Bechuanan rebels"         );
    aname[1][17] = (STRPTR) LLL(MSG_OLDREB_RHODESIA   , "S. Rhodesian rebels"      );
    aname[1][18] = (STRPTR) LLL(MSG_OLDREB_MOZAMBIQUE , "Port. E. African rebels"  );
    aname[1][19] = (STRPTR) LLL(MSG_OLDREB_ANGOLA     , "Port. W. African rebels"  );
    aname[1][20] = (STRPTR) LLL(MSG_OLDREB_ZAMBIA     , "N. Rhodesian rebels"      );
    aname[1][21] = (STRPTR) LLL(MSG_OLDREB_MALAWI     , "Nyasan rebels"            );
    aname[1][22] = (STRPTR) LLL(MSG_OLDREB_GABON      , "Gabonese rebels"          );
    aname[1][23] = (STRPTR) LLL(MSG_OLDREB_CONGO      , "French Congolese rebels"  );
    aname[1][24] = (STRPTR) LLL(MSG_OLDREB_ZAIRE      , "Belgian Congolese rebels" );
    aname[1][25] = (STRPTR) LLL(MSG_OLDREB_TANZANIA   , "German E. African rebels" );
    aname[1][26] = (STRPTR) LLL(MSG_OLDREB_UGANDA     , "Ugandan rebels"           );
    aname[1][27] = (STRPTR) LLL(MSG_OLDREB_KENYA      , "British E. African rebels");

    city[25].nname = city[25].oname = (STRPTR) LLL(MSG_CAPETOWN, "Cape Town"       );

    DoneGadget.ng_TextAttr =
    RedoGadget.ng_TextAttr = &Topaz8;

    ok = FALSE;

    if ((FileHandle = Open("PROGDIR:Africa.config", MODE_OLDFILE)))
    {   if
        (   Read(FileHandle, IOBuffer, CONFIGLENGTH) == CONFIGLENGTH
         && IOBuffer[43] == 6 // version (6 means V1.5+)
        )
        {   ok = TRUE;
            for (we = 0; we < EUROPEANS; we++)
            {   e[we].control = (SLONG) ((SBYTE) IOBuffer[we]);
            }
            DisplayID     = (ULONG) (  (IOBuffer[ 5] * 16777216)
                                     + (IOBuffer[ 6] *    65536)
                                     + (IOBuffer[ 7] *      256)
                                     +  IOBuffer[ 8]            );
            DisplayWidth  = (ULONG) (  (IOBuffer[ 9] * 16777216)
                                     + (IOBuffer[10] *    65536)
                                     + (IOBuffer[11] *      256)
                                     +  IOBuffer[12]            );
            if (DisplayWidth  < SCREENXPIXEL)
            {   DisplayWidth  = SCREENXPIXEL;
            }
            DisplayHeight = (ULONG) (  (IOBuffer[13] * 16777216)
                                     + (IOBuffer[14] *    65536)
                                     + (IOBuffer[15] *      256)
                                     +  IOBuffer[16]            );
            if (DisplayHeight < SCREENYPIXEL)
            {   DisplayHeight = SCREENYPIXEL;
            }
            DisplayDepth  = (UWORD) (  (IOBuffer[17] *      256)
                                     +  IOBuffer[18]            );
            speed         = (WORD)      IOBuffer[19];
            titlebar      = (FLAG)      IOBuffer[20];
            players       = (SLONG)     IOBuffer[21];
            rounds        = (SLONG)     IOBuffer[22];
            AboutXPos     = (WORD)  (  (IOBuffer[23] *      256)
                                     +  IOBuffer[24]            );
            AboutYPos     = (WORD)  (  (IOBuffer[25] *      256)
                                     +  IOBuffer[26]            );
            EOrdersXPos   = (WORD)  (  (IOBuffer[27] *      256)
                                     +  IOBuffer[28]            );
            EOrdersYPos   = (WORD)  (  (IOBuffer[29] *      256)
                                     +  IOBuffer[30]            );
            HexHelpXPos   = (WORD)  (  (IOBuffer[31] *      256)
                                     +  IOBuffer[32]            );
            HexHelpYPos   = (WORD)  (  (IOBuffer[33] *      256)
                                     +  IOBuffer[34]            );
            WhoXPos       = (WORD)  (  (IOBuffer[35] *      256)
                                     +  IOBuffer[36]            );
            WhoYPos       = (WORD)  (  (IOBuffer[37] *      256)
                                     +  IOBuffer[38]            );
            ScoreXPos     = (WORD)  (  (IOBuffer[39] *      256)
                                     +  IOBuffer[40]            );
            ScoreYPos     = (WORD)  (  (IOBuffer[41] *      256)
                                     +  IOBuffer[42]            );
            // version is IOBuffer[43]
            ukiu          = (BOOL)      IOBuffer[44];
            endless       = (BOOL)      IOBuffer[45];
            colonial      = (BOOL)      IOBuffer[46];
            maintain      = (BOOL)      IOBuffer[47];
            autosetup     = (BOOL)      IOBuffer[48];
            watchamiga    = (BOOL)      IOBuffer[49];
            customscreen  = (FLAG)      IOBuffer[50];
        }
        DISCARD Close(FileHandle);
        // FileHandle = NULL;
    }

    /* argument parsing */

    if (argc) /* started from CLI */
    {   if (!(ArgsPtr = (struct RDArgs*) ReadArgs
        (   "USA/K,USSR/K,CHINA/K,FRANCE/K,UK/K,SCREENMODE/S,PUBSCREEN/K,FILE",
            (LONG*) args,
            NULL
        )))
        {   DISCARD Printf
            (   "Usage: %s "
                "[USA=HUMAN|AMIGA|NONE] "
                "[USSR=HUMAN|AMIGA|NONE] "
                "[CHINA=HUMAN|AMIGA|NONE] "
                "[FRANCE=HUMAN|AMIGA|NONE] "
                "[UK=HUMAN|AMIGA|NONE] "
                "[SCREENMODE] "
                "[PUBSCREEN=<screenname>] "
                "[[FILE=]<savedgame>]\n",
                (long unsigned int) argv[0]
            );
            cleanexit(EXIT_FAILURE);
        }

        for (we = 0; we < EUROPEANS; we++)
        {   if (args[ARGPOS_FIRSTPLAYER + we])
            {   if     (!stricmp((STRPTR) args[ARGPOS_FIRSTPLAYER + we], "HUMAN"))
                {   e[we].control = CONTROL_HUMAN;
                } elif (!stricmp((STRPTR) args[ARGPOS_FIRSTPLAYER + we], "AMIGA"))
                {   e[we].control = CONTROL_AMIGA;
                } else
                {   DISCARD Printf("%s: Player control must be HUMAN or AMIGA\n", (long unsigned int) argv[0]); // localize this
        }   }   }
        if (args[ARGPOS_SCREENMODE])
        {   screenmode = TRUE;
        }
        if (args[ARGPOS_PUBSCREEN])
        {   strcpy(screenname, (STRPTR) args[ARGPOS_PUBSCREEN]);
        }
        if (args[ARGPOS_FILE])
        {   strcpy(pathname, (STRPTR) args[ARGPOS_FILE]);
            cliload = TRUE;
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
                cliload = TRUE;
    }   }   }

#if defined(__AROS__) && (AROS_BIG_ENDIAN == 0)
    swap_byteorder((UWORD*) OriginalAfroData,  sizeof(OriginalAfroData)  / 2);
    swap_byteorder((UWORD*) OriginalMapData,   sizeof(OriginalMapData)   / 2);
    swap_byteorder((UWORD*) OriginalAboutData, sizeof(OriginalAboutData) / 2);
    swap_byteorder((UWORD*) OriginalLogoData,  sizeof(OriginalLogoData)  / 2);
    swap_byteorder((UWORD*) OriginalEuroData,  sizeof(OriginalEuroData)  / 2);
#endif

    if ((!ok || screenmode) && !screenname[0])
    {   getscreenmode();
    }
    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }
    EOrdersXPos  = (DisplayWidth  / 2) - (EORDERSXPIXEL / 2);
    EOrdersYPos  = (DisplayHeight / 2) - (EORDERSYPIXEL / 2);
    HexHelpXPos  = (DisplayWidth  / 2) - (HEXHELPXPIXEL / 2);
    HexHelpYPos  = (DisplayHeight / 2) - (HEXHELPYPIXEL / 2);
        WhoXPos  = (DisplayWidth  / 2) - (    WHOXPIXEL / 2);
        WhoYPos  = (DisplayHeight / 2) - (    WHOYPIXEL / 2);

    WindowWidth  =  DisplayWidth;
    WindowHeight =  DisplayHeight;

    strcpy((char*) fn_game, "PROGDIR:");
    if (argc) // started from CLI
    {   AddPart((char*) fn_game, FilePart(argv[0]), MAX_PATH);
    } else // started from WB
    {   WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList;
        AddPart((char*) fn_game, (char*) WBArg->wa_Name, MAX_PATH);
    }
    IconifiedIcon = GetDiskObjectNew((char*) fn_game);

#ifdef __amigaos4__
    registerapp();
#endif

    if (customscreen)
    {   ScreenPtr = (struct Screen*) OpenScreenTags
        (   NULL,
            SA_Width,         DisplayWidth,
            SA_Height,        DisplayHeight,
            SA_Depth,         DisplayDepth,
            SA_Behind,        TRUE,
            SA_AutoScroll,    TRUE,
            SA_ShowTitle,     titlebar ? TRUE : FALSE,
            SA_Title,         (ULONG) TITLEBAR,
            SA_Font,          (ULONG) &Topaz8,
            SA_Colors32,      (ULONG) table1,
            SA_DisplayID,     DisplayID,
            SA_LikeWorkbench, TRUE, // to get sticky menu support on OS4, but not handled correctly by AROS
            SA_Pens,          (ULONG) Pens,
        TAG_DONE);
        if (!ScreenPtr)
        {   rq("Can't open screen!");
        }
        LoadRGB32(&(ScreenPtr->ViewPort), table2);
#ifdef __AROS__
        SetAPen(&ScreenPtr->RastPort, 0);
        RectFill
        (   &ScreenPtr->RastPort,
            0,
            ScreenPtr->BarHeight,
            ScreenPtr->Width - 1,
            ScreenPtr->Height - 1
        );
#endif
    } else
    {   lockscreen();

        DisplayDepth = 8;
        DisplayID    = GetVPModeID(&(ScreenPtr->ViewPort));
    }
    if ((DisplayID & PAL_MONITOR_ID) == PAL_MONITOR_ID || (DisplayID & NTSC_MONITOR_ID) == NTSC_MONITOR_ID)
    {   memflags |= MEMF_CHIP;
    }

    saveconfig = TRUE;

    // this must be done before the menus are set up
    if (!customscreen)
    {   titlebar = TRUE;
        NewMenu[INDEX_SHOW_TITLEBAR].nm_Flags |= NM_ITEMDISABLED;
    }
    if (titlebar)
    {   NewMenu[INDEX_SHOW_TITLEBAR].nm_Flags |= CHECKED;
    }
    if (watchamiga)
    {   NewMenu[INDEX_WATCH_AMIGA  ].nm_Flags |= CHECKED;
    }

    if (!(OffScreenBitMapPtr = (struct BitMap*) AllocBitMap((ULONG) SCREENXPIXEL, (ULONG) SCREENYPIXEL, DisplayDepth, 0, ScreenPtr->RastPort.BitMap)))
    {   rq("Can't allocate friendly bitmap!");
    }
    InitRastPort(&OffScreenRastPort); // no return code
    OffScreenRastPort.BitMap = OffScreenBitMapPtr;
    SetFont(&OffScreenRastPort, FontPtr);
    fontx = OffScreenRastPort.TxWidth;
    fonty = OffScreenRastPort.TxHeight;

    if (!(VisualInfoPtr = (APTR) GetVisualInfo(ScreenPtr, TAG_DONE)))
    {   rq("Can't get GadTools visual info!");
    }
    if (!(MenuPtr = (struct Menu*) CreateMenus(NewMenu, TAG_DONE)))
    {   rq("Can't create menus!");
    }
    if (!(LayoutMenus(MenuPtr, VisualInfoPtr, GTMN_NewLookMenus, TRUE, TAG_DONE)))
    {   rq("Can't lay out menus!");
    }

    if (!(MainWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,         customscreen ? 0 : ((ScreenPtr->Width  - WindowWidth ) / 2),
        WA_Top,          customscreen ? 0 : ((ScreenPtr->Height - WindowHeight) / 2),

        customscreen ? TAG_IGNORE : WA_Title,       (ULONG) "Africa " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_ScreenTitle, (ULONG) "Africa " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_DepthGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_DragBar,     TRUE,
        customscreen ? TAG_IGNORE : WA_CloseGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_SizeGadget,  FALSE,
        WA_IDCMP,               IDCMP_RAWKEY
                              | IDCMP_MOUSEBUTTONS
                              | IDCMP_INTUITICKS
                              | IDCMP_CLOSEWINDOW
                              | IDCMP_REFRESHWINDOW
                              | IDCMP_MENUPICK
                              | IDCMP_MENUVERIFY
                              | IDCMP_ACTIVEWINDOW
                              | CYCLEIDCMP
                              | CHECKBOXIDCMP
                              | BUTTONIDCMP
                              | SLIDERIDCMP,
        WA_Activate,            TRUE,
        WA_NewLookMenus,        TRUE,
        customscreen ? WA_Backdrop     : TAG_IGNORE,     TRUE,
        customscreen ? WA_Borderless   : TAG_IGNORE,     TRUE,
        customscreen ? WA_CustomScreen : TAG_IGNORE,     (ULONG) ScreenPtr,
        customscreen ? WA_Width        : WA_InnerWidth,  WindowWidth,
        customscreen ? WA_Height       : WA_InnerHeight, WindowHeight,
    TAG_DONE)))
    {   rq("Can't open window!");
    }
    DISCARD SetMenuStrip(MainWindowPtr, MenuPtr);

    if (customscreen)
    {   xoffset = yoffset = 0;
    } else
    {   xoffset = ScreenPtr->WBorLeft;
        yoffset = ScreenPtr->WBorTop + ScreenPtr->Font->ta_YSize + 1; // not fonty, as it can be a different font!
    }

    for (we = 0; we < EUROPEANS; we++)
    {   CycleGadget[we].ng_VisualInfo = VisualInfoPtr;
        CycleGadget[we].ng_LeftEdge   = (WORD) LEFTGAP + 301;
        CycleGadget[we].ng_TopEdge    = (WORD) TOPGAP  + 200 + (we * 13);
        CycleGadget[we].ng_TextAttr   = &Topaz8;
    }
      PlayersGadget.ng_VisualInfo =
        SpeedGadget.ng_VisualInfo =
       RoundsGadget.ng_VisualInfo =
         UKIUGadget.ng_VisualInfo =
     MaintainGadget.ng_VisualInfo =
    AutoSetupGadget.ng_VisualInfo =
      EndlessGadget.ng_VisualInfo =
     ColonialGadget.ng_VisualInfo =
        StartGadget.ng_VisualInfo = VisualInfoPtr;

      PlayersGadget.ng_LeftEdge   =
        SpeedGadget.ng_LeftEdge   =
       RoundsGadget.ng_LeftEdge   = (WORD) LEFTGAP + 301;
         UKIUGadget.ng_LeftEdge   =
     MaintainGadget.ng_LeftEdge   =
    AutoSetupGadget.ng_LeftEdge   =
      EndlessGadget.ng_LeftEdge   =
     ColonialGadget.ng_LeftEdge   = (WORD) LEFTGAP + 403;
        StartGadget.ng_LeftEdge   = (WORD) LEFTGAP + 160;

      PlayersGadget.ng_TopEdge    = (WORD) TOPGAP + 187;
        SpeedGadget.ng_TopEdge    = (WORD) TOPGAP + 281;
       RoundsGadget.ng_TopEdge    = (WORD) TOPGAP + 295;

         UKIUGadget.ng_TopEdge    = (WORD) TOPGAP + 325;
     MaintainGadget.ng_TopEdge    = (WORD) TOPGAP + 339;
    AutoSetupGadget.ng_TopEdge    = (WORD) TOPGAP + 353;
      EndlessGadget.ng_TopEdge    = (WORD) TOPGAP + 367;
     ColonialGadget.ng_TopEdge    = (WORD) TOPGAP + 381;

        StartGadget.ng_TopEdge    = (WORD) TOPGAP + 407;

      PlayersGadget.ng_TextAttr   =
         UKIUGadget.ng_TextAttr   = // yes, needed even for checkbox gadgets! (for correct positioning)
     MaintainGadget.ng_TextAttr   =
    AutoSetupGadget.ng_TextAttr   =
      EndlessGadget.ng_TextAttr   =
     ColonialGadget.ng_TextAttr   =
        StartGadget.ng_TextAttr   = &Topaz8;

    if (!(PrevGadgetPtr1 = (struct Gadget*) CreateContext(&MainGListPtr)))
    {   rq("Can't create GadTools context!");
    }

    for (we = 0; we < EUROPEANS; we++)
    {   CycleGadgetPtr[we] = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
        (   CYCLE_KIND,
            PrevGadgetPtr1,
            &CycleGadget[we],
            GTCY_Labels, (ULONG) CycleOptions,
            GTCY_Active, e[we].control,
        TAG_DONE);
    }
    SpeedGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   SLIDER_KIND,
        PrevGadgetPtr1,
        &SpeedGadget,
        GA_RelVerify,     TRUE,
        GTSL_Min,         0,
        GTSL_Max,         MAXSPEED,
        GTSL_Level,       speed,
    TAG_DONE);
    RoundsGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   SLIDER_KIND,
        PrevGadgetPtr1,
        &RoundsGadget,
        GA_RelVerify,     TRUE,
        GTSL_Min,         MIN_ROUNDS,
        GTSL_Max,         MAX_ROUNDS,
        GTSL_Level,       rounds,
    TAG_DONE);
    UKIUGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr1,
        &UKIUGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) ukiu,
    TAG_DONE);
    EndlessGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr1,
        &EndlessGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) endless,
    TAG_DONE);
    ColonialGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr1,
        &ColonialGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) colonial,
    TAG_DONE);
    MaintainGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr1,
        &MaintainGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) maintain,
    TAG_DONE);
    PlayersGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CYCLE_KIND,
        PrevGadgetPtr1,
        &PlayersGadget,
        GA_RelVerify,     TRUE,
        GTCY_Labels,      (ULONG) PlayerOptions,
        GTCY_Active,      players - 2,
    TAG_DONE);
    AutoSetupGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr1,
        &AutoSetupGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) autosetup,
    TAG_DONE);
    StartGadgetPtr = PrevGadgetPtr1 = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        PrevGadgetPtr1,
        &StartGadget,
        GA_RelVerify,     TRUE,
    TAG_DONE);

    AddGList(MainWindowPtr, MainGListPtr, 0, -1, NULL);
    RefreshGadgets(MainGListPtr, MainWindowPtr, NULL);
    GT_RefreshWindow(MainWindowPtr, NULL);

    /* redirection of AmigaDOS system requesters */
    OldWindowPtr = ProcessPtr->pr_WindowPtr;
    ProcessPtr->pr_WindowPtr = (APTR) MainWindowPtr;
    MainSignal = 1 << MainWindowPtr->UserPort->mp_SigBit;

    SetFont(MainWindowPtr->RPort, FontPtr);

    if
    (   !(AboutData = AllocMem(      114 * 8 * 2, memflags))
     || !(LogoData  = AllocMem( 5040 / 4 * 8 * 2, memflags))
     || !(MapData   = AllocMem(71700 / 6 * 8 * 2, memflags))
    )
    {   if         (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }
    for (i = 0; i < 6; i++)
    {   for (j = 0; j < RAFRICANS; j++)
        {   if (!(AfroData[i][j] = AllocMem(COUNTERHEIGHT * 2 * 8 * 2, memflags)))
            {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }   }   }
    for (i = 0; i < 2; i++)
    {   for (j = 0; j < EUROPEANS; j++)
        {   if (!(EuroData[i][j] = AllocMem(COUNTERHEIGHT * 2 * 8 * 2, memflags)))
            {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }   }   }

    remap();
    SetBPen(MainWindowPtr->RPort, remapit[BLACK]);

    if (!(ASLRqPtr = (struct FileRequester*) AllocAslRequestTags(ASL_FileRequest,
        ASL_Pattern, (ULONG) "#?.africa",
        ASL_Window,  (ULONG) MainWindowPtr,
    TAG_DONE)))
    {   rq("Can't create ASL file request!");
    }

    clearscreen();
    if (DisplayWidth > SCREENXPIXEL && DisplayHeight > SCREENYPIXEL)
    {   // assert(customscreen);

        SetRast(MainWindowPtr->RPort, BLACK);
        SetAPen(MainWindowPtr->RPort, MAPBACKGROUND);
        RectFill(MainWindowPtr->RPort, LEFTGAP, TOPGAP, LEFTGAP + SCREENXPIXEL - 1, TOPGAP + SCREENYPIXEL - 1);
        drawborder(LEFTGAP - 8, TOPGAP - 8, LEFTGAP + SCREENXPIXEL - 1, TOPGAP + SCREENYPIXEL - 1);
    } elif (customscreen)
    {   SetRast(MainWindowPtr->RPort, remapit[MAPBACKGROUND]);
    }
    border(-1);

    if (cliload)
    {   if (Exists(pathname))
        {   if (loadgame(FALSE))
            {   loaded = TRUE;
                ScreenToFront(ScreenPtr);
            } else
            {   cliload = FALSE;
        }   }
        elif (strlen(pathname) <= 7 || stricmp(&pathname[strlen(pathname) - 7], ".africa"))
        {   strcat(pathname, ".africa");
            if (loadgame(FALSE))
            {   loaded = TRUE;
                ScreenToFront(ScreenPtr);
            } else
            {   cliload = FALSE;
        }   }
        else
        {   cliload = FALSE;
    }   }

    if (!cliload)
    {   titlescreen();
    }

    for (;;)
    {   gameloop();
        titlescreen();
}   }

EXPORT void cleanexit(SLONG rc)
{   BPTR  FileHandle /* = NULL */ ;
    SLONG we;
    int   i, j;

    close_eorders();

    if (ASLRqPtr)
    {   FreeAslRequest(ASLRqPtr);
        ASLRqPtr = NULL;
    }
    if (OldWindowPtr && ProcessPtr)
    {   ProcessPtr->pr_WindowPtr = OldWindowPtr;
    }

    /* It does not matter whether there are outstanding messages for a
    window when it is closed, provided that the window does not use a
    shared IDCMP message port. */

    if (MainWindowPtr)
    {   ClearMenuStrip(MainWindowPtr); // important!
        CloseWindow(MainWindowPtr);
        MainWindowPtr = NULL;
    }
    if (MainGListPtr)
    {   FreeGadgets(MainGListPtr);
        MainGListPtr = NULL;
    }
    if (MenuPtr)
    {   FreeMenus(MenuPtr);
        MenuPtr = NULL;
    }
    if (VisualInfoPtr)
    {   FreeVisualInfo(VisualInfoPtr);
        VisualInfoPtr = NULL;
    }

    if (customscreen)
    {   if (ScreenPtr)
        {   DISCARD CloseScreen(ScreenPtr);
            ScreenPtr = NULL;
    }   }
    else
    {   for (i = 0; i < 64; i++)
        {   if (gotpen[i])
            {   ReleasePen(ScreenPtr->ViewPort.ColorMap, remapit[i]);
#ifdef DEBUGPENS
                printf("Released pen %d.\n", i);
#endif
                gotpen[i] = FALSE;
        }   }
        unlockscreen();
    }

    if (AboutData)
    {   FreeMem(AboutData,      114 * 8 * 2);
        // AboutData = NULL;
    }
    if (LogoData)
    {   FreeMem(LogoData,  5040 / 4 * 8 * 2);
        // LogoData = NULL;
    }
    if (MapData)
    {   FreeMem(MapData,  71700 / 6 * 8 * 2);
        // MapData = NULL;
    }
    for (i = 0; i < 6; i++)
    {   for (j = 0; j < RAFRICANS; j++)
        {   if (AfroData[i][j])
            {   FreeMem(AfroData[i][j], COUNTERHEIGHT * 2 * 8 * 2);
                // AfroData[i][j] = NULL;
    }   }   }
    for (i = 0; i < 2; i++)
    {   for (j = 0; j < EUROPEANS; j++)
        {   if (EuroData[i][j])
            {   FreeMem(EuroData[i][j], COUNTERHEIGHT * 2 * 8 * 2);
                // EuroData[i][j] = NULL;
    }   }   }

    if (OffScreenBitMapPtr)
    {   FreeBitMap(OffScreenBitMapPtr);
        OffScreenBitMapPtr = NULL;
    }
    if (FontPtr)
    {   CloseFont(FontPtr);
        FontPtr = NULL;
    }
    if (LocaleBase)
    {   if (   CatalogPtr) CloseCatalog(   CatalogPtr);
        if (StdCatalogPtr) CloseCatalog(StdCatalogPtr);
    }
    if (IntuitionBase)
    {   DISCARD OpenWorkBench();
    }
    if (ArgsPtr)
    {   FreeArgs(ArgsPtr);
        ArgsPtr = NULL;
    }

    if (saveconfig)
    {   for (we = 0; we < EUROPEANS; we++)
        {   IOBuffer[we] = (UBYTE) e[we].control;
        }
        IOBuffer[ 5] = (UBYTE)   (DisplayID     / 16777216);
        IOBuffer[ 6] = (UBYTE)  ((DisplayID     % 16777216) / 65536);
        IOBuffer[ 7] = (UBYTE)  ((DisplayID                 % 65536) / 256);
        IOBuffer[ 8] = (UBYTE)   (DisplayID                          % 256);
        IOBuffer[ 9] = (UBYTE)   (DisplayWidth  / 16777216);
        IOBuffer[10] = (UBYTE)  ((DisplayWidth  % 16777216) / 65536);
        IOBuffer[11] = (UBYTE)  ((DisplayWidth              % 65536) / 256);
        IOBuffer[12] = (UBYTE)   (DisplayWidth                       % 256);
        IOBuffer[13] = (UBYTE)   (DisplayHeight / 16777216);
        IOBuffer[14] = (UBYTE)  ((DisplayHeight % 16777216) / 65536);
        IOBuffer[15] = (UBYTE)  ((DisplayHeight             % 65536) / 256);
        IOBuffer[16] = (UBYTE)   (DisplayHeight                      % 256);
        IOBuffer[17] = (UBYTE)   (DisplayDepth  / 256);
        IOBuffer[18] = (UBYTE)   (DisplayDepth  % 256);
        IOBuffer[19] = (UBYTE)    speed;
        IOBuffer[20] = (UBYTE)    titlebar;
        IOBuffer[21] = (UBYTE)    players;
        IOBuffer[22] = (UBYTE)    rounds;
        IOBuffer[23] = (UBYTE)   (AboutXPos     / 256);
        IOBuffer[24] = (UBYTE)   (AboutXPos     % 256);
        IOBuffer[25] = (UBYTE)   (AboutYPos     / 256);
        IOBuffer[26] = (UBYTE)   (AboutYPos     % 256);
        IOBuffer[27] = (UBYTE)   (EOrdersXPos   / 256);
        IOBuffer[28] = (UBYTE)   (EOrdersXPos   % 256);
        IOBuffer[29] = (UBYTE)   (EOrdersYPos   / 256);
        IOBuffer[30] = (UBYTE)   (EOrdersYPos   % 256);
        IOBuffer[31] = (UBYTE)   (HexHelpXPos   / 256);
        IOBuffer[32] = (UBYTE)   (HexHelpXPos   % 256);
        IOBuffer[33] = (UBYTE)   (HexHelpYPos   / 256);
        IOBuffer[34] = (UBYTE)   (HexHelpYPos   % 256);
        IOBuffer[35] = (UBYTE)   (WhoXPos       / 256);
        IOBuffer[36] = (UBYTE)   (WhoXPos       % 256);
        IOBuffer[37] = (UBYTE)   (WhoYPos       / 256);
        IOBuffer[38] = (UBYTE)   (WhoYPos       % 256);
        IOBuffer[39] = (UBYTE)   (ScoreXPos     / 256);
        IOBuffer[40] = (UBYTE)   (ScoreXPos     % 256);
        IOBuffer[41] = (UBYTE)   (ScoreYPos     / 256);
        IOBuffer[42] = (UBYTE)   (ScoreYPos     % 256);
        IOBuffer[43] =            6; // version (6 means V1.5+)
        IOBuffer[44] = (UBYTE)    ukiu;
        IOBuffer[45] = (UBYTE)    endless;
        IOBuffer[46] = (UBYTE)    colonial;
        IOBuffer[47] = (UBYTE)    maintain;
        IOBuffer[48] = (UBYTE)    autosetup;
        IOBuffer[49] = (UBYTE)    watchamiga;
        IOBuffer[50] = (UBYTE)    customscreen;

        if ((FileHandle = Open("PROGDIR:Africa.config", MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, IOBuffer, CONFIGLENGTH);
            DISCARD Close(FileHandle);
            // FileHandle = NULL;
    }   }

#ifdef __amigaos4__
    if (AppID)
    {   // assert(ApplicationBase);
        // assert(IApplication);
        UnregisterApplication(AppID, TAG_DONE);
        // AppID = 0;
    }

    if (IApplication)    { DropInterface((struct Interface*) IApplication); }
    if (IAmigaGuide)     { DropInterface((struct Interface*) IAmigaGuide ); }
    if (IAsl)            { DropInterface((struct Interface*) IAsl        ); }
    if (IDiskfont)       { DropInterface((struct Interface*) IDiskfont   ); }
    if (IGadTools)       { DropInterface((struct Interface*) IGadTools   ); }
    if (IGraphics)       { DropInterface((struct Interface*) IGraphics   ); }
    if (IIcon)           { DropInterface((struct Interface*) IIcon       ); }
    if (IIntuition)      { DropInterface((struct Interface*) IIntuition  ); }
    if (ILocale)         { DropInterface((struct Interface*) ILocale     ); }
    if (IOpenURL)        { DropInterface((struct Interface*) IOpenURL    ); }

    if (ApplicationBase) { CloseLibrary(ApplicationBase);                 ApplicationBase = NULL; }
#endif
    if (AmigaGuideBase)  { CloseLibrary(AmigaGuideBase);                  AmigaGuideBase  = NULL; }
    if (AslBase)         { CloseLibrary(AslBase);                         AslBase         = NULL; }
    if (DiskfontBase)    { CloseLibrary(DiskfontBase);                    DiskfontBase    = NULL; }
    if (GadToolsBase)    { CloseLibrary((struct Library*) GadToolsBase);  GadToolsBase    = NULL; }
    if (GfxBase)         { CloseLibrary((struct Library*) GfxBase);       GfxBase         = NULL; }
    if (IconBase)        { CloseLibrary((struct Library*) IconBase);      IconBase        = NULL; }
    if (IntuitionBase)   { CloseLibrary((struct Library*) IntuitionBase); IntuitionBase   = NULL; }
    if (LocaleBase)      { CloseLibrary((struct Library*) LocaleBase);    LocaleBase      = NULL; }
    if (OpenURLBase)     { CloseLibrary(OpenURLBase);                     OpenURLBase     = NULL; }

    exit((int) rc); // End of program.
}

EXPORT void say(SLONG position, UBYTE colour, STRPTR leftstring, STRPTR rightstring)
{   int   length;
    SLONG i,
          where = 0; // to avoid spurious compiler warnings

    if (position == UPPER)
    {   length = (ULONG) strlen(saystring);
        if (length > 84)
        {   saystring[81] =
            saystring[82] =
            saystring[83] = '.';
            saystring[84] = EOS;
            length = 84;
        }
        if (length > 42)
        {   for (i = 41; i >= 0; i--)
            {   if (saystring[i] == ' ')
                {   where = i + 1;
                    break;
            }   }
            // assert(where >= 1 && where <= 42);

            zstrncpy(upperstring1, saystring, where);
            strcpy(upperstring2, &saystring[where]);
        } else
        {   strcpy(upperstring1, saystring);
            upperstring2[0] = EOS;
        }

        saycolour = colour;

        sprintf
        (   hintstring1,
            "%s%s",
            LLL(MSG_LMB, "LMB="),
            leftstring
        );
        sprintf
        (   hintstring2,
            ",%s%s",
            LLL(MSG_RMB, "RMB="),
            rightstring
        );
    } else
    {   // assert(position == LOWER);

        strcpy(lowerstring, saystring);
        if (lowerstring[0] != '-')
        {   strcat(lowerstring, ". ");
            strcat(lowerstring, LLL(MSG_PRESSHELP, "Press Help for info."));
#ifdef __AROS__
            strcat(lowerstring, " [F11]");
#endif
    }   }

    updatescreen();
}

EXPORT void resay(void)
{   // upper

    SetAPen(&OffScreenRastPort, remapit[MAPBACKGROUND]);
    RectFill
    (   &OffScreenRastPort,
        4,
        MESSAGEY - 2,
        4 + 345,
        MESSAGEY + 31
    );
    RectFill
    (   &OffScreenRastPort,
        4 + 346,
        MESSAGEY + 21,
        4 + 632,
        MESSAGEY + 31
    );
    shadowtext(&OffScreenRastPort, upperstring1, saycolour, 4, MESSAGEY +  6);
    shadowtext(&OffScreenRastPort, upperstring2, saycolour, 4, MESSAGEY + 17);

    // border

    if (saycolour >= AFROCOLOUR)
    {   border(a[saycolour - AFROCOLOUR].eruler);
    } else
    {   border(saycolour - EUROCOLOUR);
    }

    // hint

    shadowtext_right
    (   &OffScreenRastPort,
        hintstring1,
        saycolour,
        HINTX,
        MESSAGEY + 6
    );
    shadowtext
    (   &OffScreenRastPort,
        hintstring2,
        saycolour,
        HINTX,
        MESSAGEY + 6
    );

    // lower

    shadowtext(&OffScreenRastPort, lowerstring, WHITE, 4, MESSAGEY + 29);
}

EXPORT SLONG getevent(SLONG mode)
{   WORD                 mousex, mousey;
    UWORD                code,
                         qual;
    ULONG                class;
    struct Gadget*       addr;
    struct IntuiMessage* MsgPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    // getevent(YESNO) are ONLY allowed to return YES and NO!
    // NO is defined as -1.

    if (mode == YESNO)
    {   clearkybd_gt(MainWindowPtr);
    }
    globalrc = WAITING;
    eventmode = mode;

    do
    {   if
        (   Wait
            (   MainSignal
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   addr   = (struct Gadget*) MsgPtr->IAddress;
            class  = MsgPtr->Class;
            code   = MsgPtr->Code;
            mousex = MsgPtr->MouseX;
            mousey = MsgPtr->MouseY;
            qual   = MsgPtr->Qualifier;
            handle_idcmp(class, code, qual, mousex, mousey, addr, MsgPtr);
            if (morphos && MsgPtr->Code == MENUCANCEL) // workaround for a MOS bug
            {   ReplyMsg((struct Message*) MsgPtr);
            } else
            {   GT_ReplyIMsg(MsgPtr);
        }   }

#ifdef __amigaos4__
        rc = handle_applibport(FALSE);
        if (rc == 1 || rc == 3) // hard or soft quit
        {   cleanexit(EXIT_SUCCESS);
        } elif (rc == 2 && eventmode == TITLESCREEN)
        {   globalrc = NON;
            loaded = TRUE;
        }
#endif
    } while (globalrc == WAITING);

    return globalrc;
}

MODULE void handle_idcmp(ULONG class, UWORD code, UWORD qual, WORD mousex, WORD mousey, struct Gadget* addr, VOID* msg)
{   TRANSIENT LONG           country;
    TRANSIENT SLONG          ticks   = 0;
    TRANSIENT ULONG          IBaseLock;
    TRANSIENT struct Window* ActiveWindowPtr;
    TRANSIENT int            we;
    PERSIST   FLAG           wasdown = FALSE;

    switch (class)
    {
    case IDCMP_MENUVERIFY:
        if (eventmode != TITLESCREEN && code == MENUHOT && mousey > ScreenPtr->BarHeight) // this is no mistake
        {   ((struct IntuiMessage*) msg)->Code = MENUCANCEL;
        }
    acase IDCMP_CLOSEWINDOW:
        cleanexit(EXIT_SUCCESS);
    acase IDCMP_ACTIVEWINDOW:
        if (eventmode != TITLESCREEN)
        {   ignore = 2; // ignore 2 messages (SELECTDOWN then SELECTUP)
        }
    acase IDCMP_REFRESHWINDOW:
        GT_BeginRefresh(MainWindowPtr);
        GT_EndRefresh(MainWindowPtr, TRUE);
    acase IDCMP_MOUSEBUTTONS:
        // assert(!(qual & IEQUALIFIER_REPEAT)); // does this even have meaning for mousebuttons?
        if (code == SELECTDOWN || code == SELECTUP)
        {   if (ignore)
            {   ignore--;
            } elif (code == SELECTUP && wasdown)
            {   wasdown = FALSE;
            } else
            {   if (code == SELECTDOWN)
                {   wasdown = TRUE;
                }

                /* Some screen coords are apparently still affected by the invisible disabled GadTools gadgets behind
                them; in these cases we won't receive the SELECTDOWN, only the SELECTUP */

                switch (eventmode)
                {
                case ANYKEY:
                case ROUND:
                case GAMEOVER:
                    globalrc = NON;
                acase HEX:
                    country = checkcountry(mousex, mousey);
#ifdef EXTRAVERBOSE
                    printf("Mouse X,Y is %d,%d. Country is %d. Hex X,Y is %d,%d.\n", mousex, mousey, (int) country, (int) xhex, (int) yhex);
#endif
                    showcountry(country);
                    globalrc = country;
                acase YESNO:
                    globalrc = YES;
        }   }   }
        elif (code == MIDDLEDOWN || code == MENUUP)
        {   if (eventmode == YESNO)
            {   globalrc = NO;
            } else
            {   escaped = TRUE;
                globalrc = NON;
        }   }
    acase IDCMP_INTUITICKS:
        if (eventmode != TITLESCREEN && eventmode != GAMEOVER)
        {   IBaseLock = LockIBase(0);
            ActiveWindowPtr = TheIntuitionBase->ActiveWindow;
            UnlockIBase(IBaseLock);
            if (eventmode == ANYKEY && tickspeed[speed] != -1)
            {   ticks++;
                if (ticks >= tickspeed[speed])
                {   globalrc = NON;
            }   }
            if (ActiveWindowPtr == MainWindowPtr)
            {   country = checkcountry(mousex, mousey);
                showcountry(country);
        }   }
    acase IDCMP_MENUPICK:
        DISCARD handlemenu(code, TRUE);
    acase IDCMP_GADGETUP:
        if (eventmode == TITLESCREEN)
        {   if (addr == SpeedGadgetPtr)
            {   speed = (WORD) code;
                changespeed();
            } elif (addr == RoundsGadgetPtr)
            {   rounds = (SLONG) code;
                changerounds();
            } elif (addr == UKIUGadgetPtr)
            {   if (UKIUGadgetPtr->Flags & GFLG_SELECTED)
                {   ukiu = TRUE;
                } else
                {   ukiu = FALSE;
            }   }
            elif (addr == EndlessGadgetPtr)
            {   if (EndlessGadgetPtr->Flags & GFLG_SELECTED)
                {   endless = TRUE;
                } else
                {   endless = FALSE;
            }   }
            elif (addr == ColonialGadgetPtr)
            {   if (ColonialGadgetPtr->Flags & GFLG_SELECTED)
                {   colonial = TRUE;
                } else
                {   colonial = FALSE;
            }   }
            elif (addr == MaintainGadgetPtr)
            {   if (MaintainGadgetPtr->Flags & GFLG_SELECTED)
                {   maintain = TRUE;
                } else
                {   maintain = FALSE;
            }   }
            elif (addr == AutoSetupGadgetPtr)
            {   if (AutoSetupGadgetPtr->Flags & GFLG_SELECTED)
                {   autosetup = TRUE;
                } else
                {   autosetup = FALSE;
            }   }
            elif (addr == PlayersGadgetPtr)
            {   players = 2 + (SLONG) code;
                for (we = CHINA; we <= UK; we++)
                {   if (players > we)
                    {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
                    } else
                    {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, TRUE,  TAG_DONE);
            }   }   }
            elif (addr == StartGadgetPtr)
            {   globalrc = NON;
            } else
            {   for (we = 0; we < EUROPEANS; we++)
                {   if (addr == CycleGadgetPtr[we])
                    {   e[we].control = (SLONG) code;
                        break; // for speed
        }   }   }   }
    acase IDCMP_RAWKEY:
        if (eventmode == TITLESCREEN)
        {   switch (code)
            {
            case SCAN_F1:
                cycle(USA, qual);
            acase SCAN_F2:
                cycle(USSR, qual);
            acase SCAN_F3:
                if (players >= 3)
                {   cycle(CHINA, qual);
                }
            acase SCAN_F4:
                if (players >= 4)
                {   cycle(FRANCE, qual);
                }
            acase SCAN_F5:
                if (players >= 5) // or could have used ==
                {   cycle(UK, qual);
                }
            acase SCAN_A:
                endless = endless ? FALSE : TRUE;
                GT_SetGadgetAttrs(EndlessGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, endless, TAG_DONE);
            acase SCAN_C:
                colonial = colonial ? FALSE : TRUE;
                GT_SetGadgetAttrs(ColonialGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, colonial, TAG_DONE);
            acase SCAN_M:
                maintain = maintain ? FALSE : TRUE;
                GT_SetGadgetAttrs(MaintainGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, maintain, TAG_DONE);
            acase SCAN_P:
                if
                (   (qual & IEQUALIFIER_LSHIFT)
                 || (qual & IEQUALIFIER_RSHIFT)
                )
                {   if (players == 2)
                    {   players = EUROPEANS;
                    } else
                    {   players--;
                    }
                    GT_SetGadgetAttrs(PlayersGadgetPtr, MainWindowPtr, NULL, GTCY_Active, players - 2, TAG_DONE);
                    for (we = CHINA; we <= UK; we++)
                    {   if (players > we)
                        {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
                        } else
                        {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, TRUE,  TAG_DONE);
                }   }   }
                else
                {   if (players == EUROPEANS)
                    {   players = 2;
                    } else
                    {   players++;
                    }
                    GT_SetGadgetAttrs(PlayersGadgetPtr, MainWindowPtr, NULL, GTCY_Active, players - 2, TAG_DONE);

                    for (we = CHINA; we <= UK; we++)
                    {   if (players > we)
                        {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
                        } else
                        {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, TRUE,  TAG_DONE);
                }   }   }
            acase SCAN_R:
                if
                (   (qual & IEQUALIFIER_LSHIFT)
                 || (qual & IEQUALIFIER_RSHIFT)
                )
                {   if (rounds > MIN_ROUNDS)
                    {   rounds--;
                        GT_SetGadgetAttrs(RoundsGadgetPtr, MainWindowPtr, NULL, GTSL_Level, rounds, TAG_DONE);
                        changerounds();
                }   }
                else
                {   if (rounds < MAX_ROUNDS)
                    {   rounds++;
                        GT_SetGadgetAttrs(RoundsGadgetPtr, MainWindowPtr, NULL, GTSL_Level, rounds, TAG_DONE);
                        changerounds();
                }   }
            acase SCAN_S:
                autosetup = autosetup ? FALSE : TRUE;
                GT_SetGadgetAttrs(AutoSetupGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, autosetup, TAG_DONE);
            acase SCAN_U:
                ukiu = ukiu ? FALSE : TRUE;
                GT_SetGadgetAttrs(     UKIUGadgetPtr, MainWindowPtr, NULL, GTCB_Checked, ukiu,      TAG_DONE);
            acase SCAN_HELP:
                help_about();
            acase SCAN_LEFT:
                if (speed > 0)
                {   if
                    (   (qual & IEQUALIFIER_LSHIFT )
                     || (qual & IEQUALIFIER_RSHIFT )
                     || (qual & IEQUALIFIER_LALT   )
                     || (qual & IEQUALIFIER_RALT   )
                     || (qual & IEQUALIFIER_CONTROL)
                    )
                    {   speed = 0;
                    } else speed--;
                    GT_SetGadgetAttrs(SpeedGadgetPtr, MainWindowPtr, NULL, GTSL_Level, speed, TAG_DONE);
                    changespeed();
                }
            acase SCAN_RIGHT:
                if (speed < MAXSPEED)
                {   if
                    (   (qual & IEQUALIFIER_LSHIFT )
                     || (qual & IEQUALIFIER_RSHIFT )
                     || (qual & IEQUALIFIER_LALT   )
                     || (qual & IEQUALIFIER_RALT   )
                     || (qual & IEQUALIFIER_CONTROL)
                    )
                    {   speed = MAXSPEED;
                    } else speed++;
                    GT_SetGadgetAttrs(SpeedGadgetPtr, MainWindowPtr, NULL, GTSL_Level, speed, TAG_DONE);
                    changespeed();
                }
            acase SCAN_SPACEBAR:
            case SCAN_RETURN:
            case SCAN_ENTER:
                globalrc = NON;
            acase SCAN_ESCAPE:
                if (!(qual & IEQUALIFIER_REPEAT))
                {   cleanexit(EXIT_SUCCESS);
                }
            acase SCAN_A1:
            case SCAN_N1:
                cycle(USA, qual);
            acase SCAN_A2:
            case SCAN_N2:
                cycle(USSR, qual);
            acase SCAN_A3:
            case SCAN_N3:
                if (players >= 3)
                {   cycle(CHINA, qual);
                }
            acase SCAN_A4:
            case SCAN_N4:
                if (players >= 4)
                {   cycle(FRANCE, qual);
                }
            acase SCAN_A5:
            case SCAN_N5:
                if (players >= 5)
                {   cycle(UK, qual);
        }   }   }
        else
        {   switch (code)
            {
            case SCAN_HELP:
                if (eventmode != GAMEOVER)
                {   country = checkcountry(mousex, mousey);
                    showcountry(country);
                    if (country != -1 && valid(xhex, yhex))
                    {   hexhelp();
                }   }
            acase SCAN_SPACEBAR:
            case SCAN_RETURN:
            case SCAN_ENTER:
                if (eventmode == ROUND || eventmode == GAMEOVER || eventmode == ANYKEY)
                {   globalrc = NON;
                }
            acase SCAN_ESCAPE:
                if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                {   cleanexit(EXIT_SUCCESS);
                } elif (eventmode == ROUND)
                {   clearkybd_gt(MainWindowPtr);
                    globalrc = QUITTOTITLE;
                } elif ((eventmode != ANYKEY || tickspeed[speed] == -1) && eventmode != YESNO)
                {   escaped = TRUE;
                    globalrc = NON;
                }
            acase SCAN_BACKSPACE:
                if (eventmode == HEX)
                {   globalrc = -2;
                } elif (eventmode != YESNO)
                {   globalrc = NON;
                }
            acase SCAN_J: // "Ja"  (German)
            case  SCAN_S: // "Si"  (Italian)
            case  SCAN_Y: // "Yes" (English)
            case  SCAN_Z: // for QWERTZ keyboards
                if (!(qual & IEQUALIFIER_REPEAT))
                {   globalrc = YES;
                }
            acase SCAN_N: // "Nein"/"No"/"No"
                if (!(qual & IEQUALIFIER_REPEAT))
                {   globalrc = NO;
                }
            adefault:
                if
                (   eventmode        == ANYKEY
                 && code             <  KEYUP
                 && code             != NM_WHEEL_UP
                 && code             != NM_WHEEL_DOWN
                 && tickspeed[speed] == -1
                )
                {   globalrc = NON;
}   }   }   }   }

EXPORT void updatescreen(void)
{   int wa, war, wb, we;

    // assert(eventmode != TITLESCREEN);

    if (eventmode != GAMEOVER)
    {   drawmap();
    }

    resay(); // must be *after* drawmap()!

    if (eventmode != GAMEOVER)
    {   for (wa = 0; wa < RAFRICANS; wa++)
        {   for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (a[wa].army[war].xpixel != HIDDEN_X && a[wa].army[war].ypixel != HIDDEN_Y)
                {   Counter.ImageData = AfroData[a[wa].army[war].state][wa];
                    DrawImage(&OffScreenRastPort, &Counter, a[wa].army[war].xpixel, a[wa].army[war].ypixel);
        }   }   }

        for (we = 0; we < EUROPEANS; we++)
        {   if (e[we].iuxpixel != HIDDEN_X && e[we].iuypixel != HIDDEN_Y)
            {   Counter.ImageData = EuroData[e[we].iustate][we];
                DrawImage(&OffScreenRastPort, &Counter, e[we].iuxpixel, e[we].iuypixel);
        }   }

        for (wb = 0; wb < 6; wb++)
        {   if (box[wb].x != -1 && box[wb].y != -1)
            {   switch (box[wb].kind)
                {
                case 0:
                    SetAPen(&OffScreenRastPort, remapit[BLACK]);
                    RectFill
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  + 14 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 16 + (box[wb].y * 26),
                        640 -  4 - MapImage.Width  + 16 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 18 + (box[wb].y * 26)
                    );
                acase 1:
                    SetAPen(&OffScreenRastPort, remapit[WHITE]);
                    RectFill
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  + 14 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 16 + (box[wb].y * 26),
                        640 -  4 - MapImage.Width  + 16 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 18 + (box[wb].y * 26)
                    );
                acase 2:
                    SetAPen(&OffScreenRastPort, remapit[WHITE]);
                    Move
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  +  5 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height +  8 + (box[wb].y * 26)
                    );
                    Draw
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  + 25 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height +  8 + (box[wb].y * 26)
                    );
                    Draw
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  + 25 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 28 + (box[wb].y * 26)
                    );
                    Draw
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  +  5 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height + 28 + (box[wb].y * 26)
                    );
                    Draw
                    (   &OffScreenRastPort,
                        640 -  4 - MapImage.Width  +  5 + (box[wb].x * 30) + ((box[wb].y % 2) ? 15 : 0),
                        512 - 20 - MapImage.Height +  9 + (box[wb].y * 26)
                    );
    }   }   }   }

    ClipBlit(&OffScreenRastPort, 0, 0, MainWindowPtr->RPort, LEFTGAP, TOPGAP, SCREENXPIXEL, SCREENYPIXEL, 0xC0);
}

EXPORT void anykey(void)
{   clearkybd_gt(MainWindowPtr);
    DISCARD getevent(ANYKEY);
}

EXPORT void drawtables(void)
{   SLONG score,
          wa,
          we;
    TEXT  numberstring1[3 + 1],
          numberstring2[3 + 1],
          numberstring3[3 + 1];
#ifndef __amigaos4__
    TEXT  namestring[16 + 1];
#endif

    afrocolours();

    numberstring1[0] = '$';
    SetDrMd(&OffScreenRastPort, JAM1);

    for (we = 0; we < EUROPEANS; we++)
    {   SetAPen(&OffScreenRastPort, remapit[EUROCOLOUR + we]);
        RectFill
        (   &OffScreenRastPort,
              5, 25 + (13 * we),
            231, 36 + (13 * we)
        );
        SetAPen(&OffScreenRastPort, remapit[BLACK]);
        Move(&OffScreenRastPort,   4, 37 + (we * 13));
        Draw(&OffScreenRastPort, 232, 37 + (we * 13));

        if (we < players)
        {   stcl_d(&numberstring1[1], e[we].treasury);
            // calculate score
            score = 0;
            for (wa = 0; wa < RAFRICANS; wa++)
            {   if (a[wa].eruler == we && a[wa].aruler == wa)
                {   score += a[wa].pi;
            }   }
            stcl_d(numberstring2, score);
            shadowtext(&OffScreenRastPort, e[we].name            , WHITE,   8, 33 + (13 * we));
            shadowtext(&OffScreenRastPort, numberstring1         , WHITE, 146, 33 + (13 * we));
            shadowtext(&OffScreenRastPort, numberstring2         , WHITE, 182, 33 + (13 * we));
    }   }

    for (wa = 0; wa < RAFRICANS; wa++)
    {   SetAPen(&OffScreenRastPort, remapit[AFROCOLOUR + wa]);

        RectFill
        (   &OffScreenRastPort,
              5, 108 + (13 * wa),
            231, 119 + (13 * wa)
        );
        SetAPen(&OffScreenRastPort, remapit[BLACK]);
        Move(&OffScreenRastPort,   4, 120 + (wa * 13));
        Draw(&OffScreenRastPort, 232, 120 + (wa * 13));

        if (a[wa].aruler == wa)
        {   stcl_d(&numberstring1[1], a[wa].treasury);
            stcl_d(numberstring2, a[wa].is);
            stcl_d(numberstring3, a[wa].pi);
#ifdef __amigaos4__
            shadowtext(&OffScreenRastPort, a[wa % LAFRICANS].name, WHITE,   8, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring1         , WHITE, 146, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring2         , WHITE, 182, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring3         , WHITE, 210, 116 + (13 * wa));
#else
            strncpy(namestring, a[wa % LAFRICANS].name, 16);
            namestring[16] = EOS; // important because strncpy() is crap
            shadowtext(&OffScreenRastPort, namestring            , WHITE,   8, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring1         , WHITE, 146, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring2         , WHITE, 182, 116 + (13 * wa));
            shadowtext(&OffScreenRastPort, numberstring3         , WHITE, 210, 116 + (13 * wa));
#endif
    }   }

    shadowtext(        &OffScreenRastPort, (STRPTR) LLL(MSG_SCORE, "Score"), WHITE, 182,  20);
    shadowtext(        &OffScreenRastPort, (STRPTR) LLL(MSG_IS   , "IS"   ), WHITE, 182, 103);
    shadowtext(        &OffScreenRastPort, (STRPTR) LLL(MSG_PI   , "PI"   ), WHITE, 210, 103);

    SetAPen(&OffScreenRastPort, remapit[BLACK]);

    // between name and treasury
    Move(&OffScreenRastPort, 141,  24);
    Draw(&OffScreenRastPort, 141,  89);
    Move(&OffScreenRastPort, 141, 107);
    Draw(&OffScreenRastPort, 141, 471);
    // between treasury and IS
    Move(&OffScreenRastPort, 176,  24);
    Draw(&OffScreenRastPort, 176,  89);
    Move(&OffScreenRastPort, 176, 107);
    Draw(&OffScreenRastPort, 176, 471);
    // between IS and PI
    Move(&OffScreenRastPort, 204, 107);
    Draw(&OffScreenRastPort, 204, 471);

    // top
    Move(&OffScreenRastPort,   4,  24);
    Draw(&OffScreenRastPort, 232,  24);
    Move(&OffScreenRastPort,   4, 107);
    Draw(&OffScreenRastPort, 232, 107);
    // left
    Move(&OffScreenRastPort,   4,  24);
    Draw(&OffScreenRastPort,   4,  89);
    Move(&OffScreenRastPort,   4, 107);
    Draw(&OffScreenRastPort,   4, 471);
    // right
    Move(&OffScreenRastPort, 232,  24);
    Draw(&OffScreenRastPort, 232,  89);
    Move(&OffScreenRastPort, 232, 107);
    Draw(&OffScreenRastPort, 232, 471);

    updatescreen();
}

EXPORT SLONG dowho(SLONG we, FLAG quick, SLONG* amountvar, SLONG maxamount)
{   TRANSIENT struct Window*       WhoWindowPtr;
    TRANSIENT struct IntuiMessage* MsgPtr;
    TRANSIENT UWORD                code,
                                   qual;
    TRANSIENT ULONG                class;
    TRANSIENT FLAG                 done;
    TRANSIENT SLONG                amount =  1,
                                   result = -1, // to avoid spurious compiler warnings
                                   count,
                                   only   = -1, // to avoid spurious compiler warnings
                                   wa,
                                   we2,
                                   included,
                                   selected = 0;
    TRANSIENT struct Gadget       *LocalGListPtr = NULL, // important that this is NULL!
                                  *PrevGadgetPtr2,
                                  *AmountGadgetPtr,
                                  *WhoGadgetPtr,
                                  *addr;
    TRANSIENT struct List          WhoList;
    TRANSIENT int                  tbwidth,
                                   tbheight;
    PERSIST   FLAG                 first  = TRUE;
#ifdef __amigaos4__
    TRANSIENT int                  rc;
#endif

    PERSIST   struct NewGadget
    WhoGadget =
    {                       8, 8,
        (WORD) WHOXPIXEL - 16, 0,
        (STRPTR) "",
        NULL,
        0,
        0,
        NULL,
        NULL
    }, AmountGadget =
    {   176, (WORD) WHOYPIXEL - 27,
         40,                    20,
        (STRPTR) "",
        NULL,
        0,
        0,
        NULL,
        NULL
    };

    if (amountvar)
    {   WhoGadget.ng_Height = (WORD) WHOYPIXEL - 40;
    } else
    {   WhoGadget.ng_Height = (WORD) WHOYPIXEL - 16;
    }
    WhoGadget.ng_TextAttr    =
    AmountGadget.ng_TextAttr = &Topaz8;

    NewList(&WhoList);
    count = 0;
    for (we2 = 0; we2 < EUROPEANS; we2++)
    {   if (enabled[we2])
        {   AddNameToTail(&WhoList, e[we2].name);
            only = we2;
            count++;
    }   }
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (enabled[EUROPEANS + wa])
        {   AddNameToTail(&WhoList, a[wa].name);
            only = EUROPEANS + wa;
            count++;
    }   }
    if (count == 0)
    {   return -1;
    } elif (count == 1 && quick)
    {   return only;
    }

       WhoGadget.ng_VisualInfo =
    AmountGadget.ng_VisualInfo = VisualInfoPtr;

    if (!(WhoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          WhoXPos,
        WA_Top,           WhoYPos,
        WA_InnerWidth,    WHOXPIXEL,
        WA_InnerHeight,   WHOYPIXEL,
        WA_IDCMP,         IDCMP_CLOSEWINDOW
                        | IDCMP_RAWKEY
                        | IDCMP_REFRESHWINDOW
                        | LISTVIEWIDCMP,
        WA_Title,         (ULONG) WhoTitle,
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }

    tbwidth  = (int) WhoWindowPtr->BorderLeft;
    tbheight = (int) WhoWindowPtr->BorderTop;
    if (first)
    {   WhoGadget.ng_LeftEdge    += tbwidth;
        AmountGadget.ng_LeftEdge += tbwidth;

        WhoGadget.ng_TopEdge     += tbheight;
        AmountGadget.ng_TopEdge  += tbheight;

        first = FALSE;
    }

    if (!(PrevGadgetPtr2 = (struct Gadget*) CreateContext(&LocalGListPtr)))
    {   rq("Can't create GadTools context!");
    }
    WhoGadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
    (   LISTVIEW_KIND,
        PrevGadgetPtr2,
        &WhoGadget,
        GTLV_Labels,        (ULONG) &WhoList,
        GTLV_ShowSelected,  (ULONG) NULL,
        GTLV_Selected,      (ULONG) selected,
    TAG_DONE);
    if (amountvar)
    {   AmountGadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
        (   INTEGER_KIND,
            PrevGadgetPtr2,
            &AmountGadget,
            GA_RelVerify,   TRUE,
            GTIN_Number,    (ULONG) amount,
            GTIN_MaxChars,  1 + 1,
        TAG_DONE);
    } else
    {   AmountGadgetPtr = NULL;
    }

    SetFont(WhoWindowPtr->RPort, FontPtr);
    SetAPen(WhoWindowPtr->RPort, remapit[10 + we]);
    RectFill(WhoWindowPtr->RPort, tbwidth + 2, tbheight + 2, tbwidth + WHOXPIXEL - 4, tbheight + WHOYPIXEL - 4);
    AddGList(WhoWindowPtr, LocalGListPtr, 0, -1, NULL);
    RefreshGadgets(LocalGListPtr, WhoWindowPtr, NULL);
    GT_RefreshWindow(WhoWindowPtr, NULL);
    if (amountvar)
    {   shadowtext_right
        (   WhoWindowPtr->RPort,
            (STRPTR) LLL(MSG_AMOUNT, "Amount:"),
            WHITE,
            tbwidth  + 172,
            tbheight + WHOYPIXEL - 15
        );
    }

    done = FALSE;
    do
    {   if
        (   Wait
            (   (1 << WhoWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   WhoXPos = WhoWindowPtr->LeftEdge;
            WhoYPos = WhoWindowPtr->TopEdge;
            CloseWindow(WhoWindowPtr);
            FreeGadgets(LocalGListPtr);
            FreeNameNodes(&WhoList);
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(WhoWindowPtr->UserPort)))
        {   addr  = (struct Gadget*) MsgPtr->IAddress;
            class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_CLOSEWINDOW:
                result = -1;
                done = TRUE;
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(WhoWindowPtr);
                GT_EndRefresh(WhoWindowPtr, TRUE);
            acase IDCMP_GADGETUP:
                if (addr == WhoGadgetPtr)
                {   result = (SLONG) code;
                    if (amountvar)
                    {   DISCARD ActivateGadget(AmountGadgetPtr, WhoWindowPtr, NULL);
                    } else
                    {   done = TRUE;
                }   }
                elif (addr == AmountGadgetPtr)
                {   amount = ((struct StringInfo*) AmountGadgetPtr->SpecialInfo)->LongInt;
                    if (amount > maxamount)
                    {   amount = maxamount;
                        GT_SetGadgetAttrs(AmountGadgetPtr, WhoWindowPtr, NULL, GTIN_Number, amount, TAG_DONE);
                    } elif (amount < 0)
                    {   amount = 0;
                        GT_SetGadgetAttrs(AmountGadgetPtr, WhoWindowPtr, NULL, GTIN_Number, amount, TAG_DONE);
                    } else
                    {   done = TRUE; // we close the window automagically for the user
                }   }
            acase IDCMP_RAWKEY:
                if (code < KEYUP && (code < FIRSTQUALIFIER || code > LASTQUALIFIER))
                {   if (code == SCAN_ESCAPE && !(qual & IEQUALIFIER_REPEAT))
                    {   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        {   // WhoXPos = WhoWindowPtr->LeftEdge;
                            // WhoYPos = WhoWindowPtr->TopEdge;
                            CloseWindow(WhoWindowPtr);
                            FreeGadgets(LocalGListPtr);
                            FreeNameNodes(&WhoList);
                            cleanexit(EXIT_SUCCESS);
                        } else
                        {   result = -1;
                            done = TRUE;
                    }   }
                    elif (code == SCAN_DOWN || code == NM_WHEEL_DOWN)
                    {   if (selected < count - 1)
                        {   if
                            (   (qual & IEQUALIFIER_LSHIFT )
                             || (qual & IEQUALIFIER_RSHIFT )
                             || (qual & IEQUALIFIER_LALT   )
                             || (qual & IEQUALIFIER_RALT   )
                             || (qual & IEQUALIFIER_CONTROL)
                            )
                            {   selected = count - 1;
                            } else
                            {   selected++;
                            }
                            GT_SetGadgetAttrs(WhoGadgetPtr, WhoWindowPtr, NULL, GTLV_Selected, selected, GTLV_MakeVisible, selected, TAG_DONE);
                    }   }
                    elif (code == SCAN_UP || code == NM_WHEEL_UP)
                    {   if (selected > 0)
                        {   if
                            (   (qual & IEQUALIFIER_LSHIFT )
                             || (qual & IEQUALIFIER_RSHIFT )
                             || (qual & IEQUALIFIER_LALT   )
                             || (qual & IEQUALIFIER_RALT   )
                             || (qual & IEQUALIFIER_CONTROL)
                            )
                            {   selected = 0;
                            } else
                            {   selected--;
                            }
                            GT_SetGadgetAttrs(WhoGadgetPtr, WhoWindowPtr, NULL, GTLV_Selected, selected, GTLV_MakeVisible, selected, TAG_DONE);
                    }   }
                    elif
                    (   (   code == SCAN_RETURN
                         || code == SCAN_ENTER
                         || code == SCAN_TAB
                        )
                     && !(qual & IEQUALIFIER_REPEAT)
                    )
                    {   result = selected;
                        if (amountvar)
                        {   DISCARD ActivateGadget(AmountGadgetPtr, WhoWindowPtr, NULL);
                        } else
                        {   done = TRUE;
        }   }   }   }   }

#ifdef __amigaos4__
        rc = handle_applibport(FALSE);
        if (rc == 1 || rc == 3)
        {   WhoXPos = WhoWindowPtr->LeftEdge;
            WhoYPos = WhoWindowPtr->TopEdge;
            CloseWindow(WhoWindowPtr);
            FreeGadgets(LocalGListPtr);
            FreeNameNodes(&WhoList);
            cleanexit(EXIT_SUCCESS);
        }
#endif
    } while (!done);

    if (result == -1)
    {   count  = -1;
        amount =  0;
    } else
    {   included = 0;
        for (we2 = 0; we2 < RAFRICANS + EUROPEANS; we2++)
        {   if (enabled[we2])
            {   if (included == result)
                {   count = we2;
                    break;
                }
                included++;
        }   }
        if (amountvar)
        {   amount = ((struct StringInfo*) AmountGadgetPtr->SpecialInfo)->LongInt;
            if (amount > maxamount)
            {   amount = maxamount;
            } elif (amount < 0)
            {   amount = 0;
        }   }
        else
        {   amount = 0;
    }   }
    if (amountvar)
    {   *(amountvar) = amount;
    }

    WhoXPos = WhoWindowPtr->LeftEdge;
    WhoYPos = WhoWindowPtr->TopEdge;
    CloseWindow(WhoWindowPtr);
    FreeGadgets(LocalGListPtr);
    FreeNameNodes(&WhoList);

    clearkybd_gt(MainWindowPtr);

    return count;
}

EXPORT void setbarcolour(SLONG we)
{   if (!customscreen)
    {   return;
    }

    switch (we)
    {
    case  USA:    SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR,  7,  7, 15); // blue
    acase USSR:   SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR, 15,  7,  7); // red
    acase CHINA:  SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR,  7, 15,  7); // green
    acase FRANCE: SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR, 15, 15,  7); // yellow
    acase UK:     SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR, 15,  7, 15); // purple
    adefault:     SetRGB4(&ScreenPtr->ViewPort, BARCOLOUR, 15, 11,  7); // white
    }

    border(we);
}

EXPORT ULONG goodrand(void)
{   ULONG seconds, micros,
          value;

    // SAS/C rand() is crap and never returns certain numbers, so
    // we adjust the value with the timer to increase the randomness
    // (otherwise endless loops can happen).

    CurrentTime(&seconds, &micros);
    value = rand() + micros + seconds;

    return (ULONG) (value & 0x7FFFFFFF);
}

EXPORT void writeorders_human(SLONG we)
{   TRANSIENT FLAG                 done,
                                   iudone,
                                   installed[RAFRICANS],
                                   mistake,
                                   reallydone,
                                   redo;
    TRANSIENT TEXT                 tempstring[80 + 1],
                                   numberstring[3 + 1];
    TRANSIENT UWORD                code,
                                   qual;
    TRANSIENT SLONG                selected,
                                   count,
                                   hm[12], // less than 12 kinds of order exist
                                   wa,
                                   we2,
                                   wo,
                                   wo2,
                                   cash,
                                   writeorder;
    TRANSIENT ULONG                class;
    TRANSIENT int                  tbwidth,
                                   tbheight;
    TRANSIENT struct IntuiMessage* MsgPtr;
    TRANSIENT struct Gadget       *PrevGadgetPtr2,
                                  *EList1GadgetPtr,
                                  *EList2GadgetPtr,
                                  *RedoGadgetPtr,
                                  *DoneGadgetPtr,
                                  *addr;
    PERSIST   FLAG                 first = TRUE;

    NewList(&EList1);
    NewList(&EList2);
    EList1Gadget.ng_VisualInfo =
    EList2Gadget.ng_VisualInfo =
    RedoGadget.ng_VisualInfo   =
    DoneGadget.ng_VisualInfo   = VisualInfoPtr;

    setbarcolour(we);

    do
    {   redo   =
        iudone = FALSE;
        for (wa = 0; wa < RAFRICANS; wa++)
        {   installed[wa] = FALSE;
        }

        // If the player had no money, we could skip this, but they will
        // ALWAYS have some money at this point (at least $12, in fact).

        sprintf
        (   EOrdersTitle,
            LLL(MSG_WRITEORDERS, "%s, write orders..."),
            e[we].name
        );
        if (!(EOrdersWindowPtr = (struct Window*) OpenWindowTags(NULL,
            WA_Left,         EOrdersXPos,
            WA_Top,          EOrdersYPos,
            WA_InnerWidth,   EORDERSXPIXEL,
            WA_InnerHeight,  EORDERSYPIXEL,
            WA_IDCMP,        IDCMP_CLOSEWINDOW   |
                             IDCMP_RAWKEY        |
                             IDCMP_REFRESHWINDOW |
                             LISTVIEWIDCMP       |
                             BUTTONIDCMP,
            WA_Title,        (ULONG) EOrdersTitle,
            WA_CustomScreen, (ULONG) ScreenPtr,
            WA_DragBar,      TRUE,
            WA_CloseGadget,  FALSE,
            WA_Activate,     TRUE,
        TAG_DONE)))
        {   rq("Can't open window!");
        }

        tbwidth  = (int) EOrdersWindowPtr->BorderLeft;
        tbheight = (int) EOrdersWindowPtr->BorderTop;
        if (first)
        {   EList1Gadget.ng_LeftEdge   += tbwidth;
            EList2Gadget.ng_LeftEdge   += tbwidth;
            RedoGadget.ng_LeftEdge     += tbwidth;
            DoneGadget.ng_LeftEdge     += tbwidth;

            EList1Gadget.ng_TopEdge    += tbheight;
            EList2Gadget.ng_TopEdge    += tbheight;
            RedoGadget.ng_TopEdge      += tbheight;
            DoneGadget.ng_TopEdge      += tbheight;

            first = FALSE;
        }

        EList1Gadget.ng_TextAttr =
        EList2Gadget.ng_TextAttr = &Topaz8;

        if (!(PrevGadgetPtr2 = (struct Gadget*) CreateContext(&EOrdersGListPtr)))
        {   rq("Can't create GadTools context!");
        }
        EList1GadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
        (   LISTVIEW_KIND,
            PrevGadgetPtr2,
            &EList1Gadget,
            GTLV_Labels,       (ULONG) &EList1,
            GTLV_ShowSelected, (ULONG) NULL,
        TAG_DONE);
        EList2GadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
        (   LISTVIEW_KIND,
            PrevGadgetPtr2,
            &EList2Gadget,
            GTLV_Labels,       (ULONG) &EList2,
            GTLV_ReadOnly,     TRUE,
        TAG_DONE);
        DoneGadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
        (   BUTTON_KIND,
            PrevGadgetPtr2,
            &DoneGadget,
            GT_Underscore,     '_',
        TAG_DONE);
        RedoGadgetPtr = PrevGadgetPtr2 = (struct Gadget*) CreateGadget
        (   BUTTON_KIND,
            PrevGadgetPtr2,
            &RedoGadget,
            GT_Underscore,     '_',
        TAG_DONE);

        SetFont(EOrdersWindowPtr->RPort, FontPtr);
        SetAPen(EOrdersWindowPtr->RPort, remapit[10 + we]);
        RectFill(EOrdersWindowPtr->RPort, tbwidth + 2, tbheight + 2, tbwidth + EORDERSXPIXEL - 4, tbheight + EORDERSYPIXEL - 4);
        AddGList(EOrdersWindowPtr, EOrdersGListPtr, 0, -1, NULL);
        RefreshGadgets(EOrdersGListPtr, EOrdersWindowPtr, NULL);
        GT_RefreshWindow(EOrdersWindowPtr, NULL);

        cash = e[we].treasury;
        wo = 0;

        reallydone = FALSE;
        do
        {   // assert(wo < MAX_ORDERS);
            GT_SetGadgetAttrs(EList1GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Labels, (ULONG) ~0, TAG_DONE);
            FreeNameNodes(&EList1);
            NewList(&EList1);

            count = 0;

            if (cash >= 4)
            {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_APPLYPI, "Apply influence"));
                hm[count++] = ORDER_PI;
                // We assume there are countries we can apply influence to; that is a fairly safe assumption.
                AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_RAISEIS, "Raise stability"));
                hm[count++] = ORDER_RAISE_IS;
                AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_LOWERIS, "Lower stability"));
                hm[count++] = ORDER_LOWER_IS;
                // We assume there are countries we can raise and lower the stability of; that is a fairly safe assumption.
            }

            if (cash >= 2)
            {   if (spareleader(we))
                {   // do we have a suitable country?

                    for (wa = 0; wa < RAFRICANS; wa++)
                    {   if
                        (   a[wa].aruler == wa
                         && a[wa].eruler == we
                         && a[wa].pi >= POLITICAL_CONTROL
                         && a[wa].govt == OTHER
                         && hasarmy(wa)
                         && !installed[wa]
                        )
                        {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_INSTALLLEADER, "Install leader"));
                            hm[count++] = ORDER_INSTALL_LEADER;
                            break;
                }   }   }

                if (sparejunta(we))
                {   // do we have a suitable country?

                    for (wa = 0; wa < RAFRICANS; wa++)
                    {   if
                        (   a[wa].aruler == wa
                         && a[wa].eruler == we
                         && a[wa].pi >= POLITICAL_CONTROL
                         && a[wa].govt == OTHER
                         && hasarmy(wa)
                         && !installed[wa]
                        )
                        {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_INSTALLJUNTA, "Install junta"));
                            hm[count++] = ORDER_INSTALL_JUNTA;
                            break;
            }   }   }   }

            if
            (   (cash >= 4 && (we == USA   || we == USSR  ))
             || (cash >= 2 && (we == CHINA || we == FRANCE || (we == UK && ukiu)))
            )
            {   if (e[we].iu && !iudone)
                {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_MAINTAINIU, "Maintain IU"));
                    hm[count++] = ORDER_MAINTAIN_IU;
                } elif (!iudone)
                {   for (wa = 0; wa < RAFRICANS; wa++)
                    {   if (a[wa].aruler == wa && a[wa].eruler == we && a[wa].pi >= MILITARY_CONTROL)
                        {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_BUILDIU, "Build IU"));
                            hm[count++] = ORDER_BUILD_IU;
                            break;
            }   }   }   }

            if (cash >= 1)
            {   AddNameToTail(&EList1, (STRPTR) LLL(MSG_OPT_GIVEMONEY, "Give money"));
                hm[count++] = ORDER_GIVE_MONEY;
            }

            GT_SetGadgetAttrs(EList2GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Labels, (ULONG) ~0, TAG_DONE);
            FreeNameNodes(&EList2);
            NewList(&EList2);

            if (wo > 0)
            {   for (wo2 = 0; wo2 < wo; wo2++)
                {   switch (order[we][wo2].command)
                    {
                    case ORDER_PI:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_APPLYPI, "Apply %d influence to %s"),
                            order[we][wo2].data1,
                            a[order[we][wo2].dest].name
                        );
                    acase ORDER_INSTALL_LEADER:
                    case ORDER_INSTALL_JUNTA:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_INSTALLGOVT, "Install %s in %s"),
                            (order[we][wo2].command == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                            a[order[we][wo2].dest].name
                        );
                    acase ORDER_GIVE_MONEY:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_GIVEMONEY, "Give $%d to %s"),
                            order[we][wo2].fee,
                            (order[we][wo2].dest < EUROPEANS) ? e[order[we][wo2].dest].name : a[order[we][wo2].dest - EUROPEANS].name
                        );
                    acase ORDER_BUILD_IU:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_BUILDIU, "Build IU for %s"),
                            a[order[we][wo2].dest].name
                        );
                    acase ORDER_MAINTAIN_IU:
                        sprintf
                        (   tempstring,
                            LLL(MSG_OPT_MAINTAINIU, "Maintain IU")
                        );
                    acase ORDER_RAISE_IS:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_RAISEIS, "Raise stability of %s by %d"),
                            a[order[we][wo2].dest].name,
                            order[we][wo2].data1
                        );
                    acase ORDER_LOWER_IS:
                        sprintf
                        (   tempstring,
                            LLL(MSG_ORD_LOWERIS, "Lower stability of %s by %d"),
                            a[order[we][wo2].dest].name,
                            order[we][wo2].data1
                        );
                    }
                    AddNameToTail(&EList2, tempstring);
                    // Printf("%s\n", tempstring);
            }   }

            // done is whether the user has finished one order.
            // reallydone is whether the user has finished all orders.

            selected = 0;
            GT_SetGadgetAttrs(EList1GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Labels, (ULONG) &EList1, GTLV_Selected, selected, TAG_DONE);
            GT_SetGadgetAttrs(EList2GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Labels, (ULONG) &EList2, TAG_DONE);

            sprintf(numberstring, "$%d", (int) cash);
            if (strlen(numberstring) == 2)
            {   strcat(numberstring, " ");
            }
            // assert(strlen(numberstring) == 3);

            SetAPen(EOrdersWindowPtr->RPort, remapit[DARKGREY]);
            RectFill(EOrdersWindowPtr->RPort, tbwidth + 8, tbheight + 7, tbwidth + 36, tbheight + 18);
            shadowtext(EOrdersWindowPtr->RPort, numberstring, we + 10, tbwidth + 10, tbheight + 15);

            sprintf
            (   saystring,
                LLL(MSG_WRITEORDERS, "%s, write orders..."),
                e[we].name
            );
            say(UPPER, EUROCOLOUR + we, "-", "-");

            done = FALSE;
            while (!done)
            {   if
                (   Wait
                    (   (1 << EOrdersWindowPtr->UserPort->mp_SigBit)
                      | AppLibSignal
                      | SIGBREAKF_CTRL_C
                    ) & SIGBREAKF_CTRL_C
                )
                {   cleanexit(EXIT_SUCCESS); // this calls close_eorders() for us
                }

                while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(EOrdersWindowPtr->UserPort)))
                {   addr  = (struct Gadget*) MsgPtr->IAddress;
                    class = MsgPtr->Class;
                    code  = MsgPtr->Code;
                    qual  = MsgPtr->Qualifier;
                    GT_ReplyIMsg(MsgPtr);
                    writeorder = -1;
                    switch (class)
                    {
                    case IDCMP_CLOSEWINDOW: // unlikely we would get one of these since we lack the gadget
                        reallydone = done = TRUE;
                    acase IDCMP_REFRESHWINDOW:
                        GT_BeginRefresh(EOrdersWindowPtr);
                        GT_EndRefresh(EOrdersWindowPtr, TRUE);
                    acase IDCMP_GADGETUP:
                        if (addr == RedoGadgetPtr)
                        {   redo = reallydone = done = TRUE;
                        } elif (addr == DoneGadgetPtr)
                        {   reallydone = done = TRUE;
                        } elif (addr == EList1GadgetPtr)
                        {   selected = (SLONG) code;
                            writeorder = hm[selected];
                        }
                    acase IDCMP_RAWKEY:
                        if (code == SCAN_ESCAPE && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT)))
                        {   cleanexit(EXIT_SUCCESS);
                        } elif (code == SCAN_D)
                        {   reallydone = done = TRUE;
                        } elif (code == SCAN_R)
                        {   redo = reallydone = done = TRUE;
                        } elif
                        (   (code == SCAN_RETURN || code == SCAN_ENTER)
                         && !(qual & IEQUALIFIER_REPEAT)
                        )
                        {   if (count > 0)
                            {   writeorder = hm[selected];
                        }   }
                        elif (code == SCAN_DOWN || code == NM_WHEEL_DOWN)
                        {   if (selected < count - 1)
                            {   if
                                (   (qual & IEQUALIFIER_LSHIFT )
                                 || (qual & IEQUALIFIER_RSHIFT )
                                 || (qual & IEQUALIFIER_LALT   )
                                 || (qual & IEQUALIFIER_RALT   )
                                 || (qual & IEQUALIFIER_CONTROL)
                                )
                                {   selected = count - 1;
                                } else
                                {   selected++;
                                }
                                GT_SetGadgetAttrs(EList1GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Selected, selected, GTLV_MakeVisible, selected, TAG_DONE);
                        }   }
                        elif (code == SCAN_UP || code == NM_WHEEL_UP)
                        {   if (selected > 0)
                            {   if
                                (   (qual & IEQUALIFIER_LSHIFT )
                                 || (qual & IEQUALIFIER_RSHIFT )
                                 || (qual & IEQUALIFIER_LALT   )
                                 || (qual & IEQUALIFIER_RALT   )
                                 || (qual & IEQUALIFIER_CONTROL)
                                )
                                {   selected = 0;
                                } else
                                {   selected--;
                                }
                                GT_SetGadgetAttrs(EList1GadgetPtr, EOrdersWindowPtr, NULL, GTLV_Selected, selected, GTLV_MakeVisible, selected, TAG_DONE);
                    }   }   }

                    if (writeorder != -1)
                    {   mistake = FALSE;
                        done = TRUE;
                        order[we][wo].command = writeorder;

                        switch (writeorder)
                        {
                        case ORDER_PI:
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   enabled[we2] = FALSE;
                            }
                            for (wa = 0; wa < RAFRICANS; wa++)
                            {   if (a[wa].aruler == wa)
                                {   enabled[EUROPEANS + wa] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa] = FALSE; // conquered country has no PI to adjust
                            }   }
                            sprintf
                            (   saystring,
                                LLL(MSG_PROMPT_APPLYPI, "%s, apply political influence to..."),
                                e[we].name
                            );
                            say(UPPER, EUROCOLOUR + we, "-", "-");
                            strcpy
                            (   WhoTitle,
                                LLL(MSG_HAIL_APPLYPI, "Apply PI to:")
                            );
                            order[we][wo].dest = dowho(we, TRUE, &order[we][wo].data1, cash / 4);
                            clearkybd_gt(EOrdersWindowPtr);
                            if (order[we][wo].dest == -1 || order[we][wo].data1 == 0)
                            {   mistake = TRUE;
                            } else
                            {   order[we][wo].dest -= EUROPEANS;
                                order[we][wo].fee  =  4 * order[we][wo].data1;
                                clearkybd_gt(EOrdersWindowPtr);
                            }
                        acase ORDER_RAISE_IS:
                        case ORDER_LOWER_IS:
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   enabled[we2] = FALSE;
                            }
                            for (wa = 0; wa < RAFRICANS; wa++)
                            {   if (a[wa].aruler == wa)
                                {   enabled[EUROPEANS + wa] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa] = FALSE; // conquered country has no IS to adjust
                            }   }
                            if (writeorder == ORDER_RAISE_IS)
                            {   sprintf
                                (   saystring,
                                    LLL(MSG_PROMPT_RAISEIS, "%s, raise internal stability of..."),
                                    e[we].name
                                );
                                strcpy(WhoTitle, LLL(MSG_HAIL_RAISEIS, "Raise IS of:"));
                            } else
                            {   // assert(writeorder == ORDER_LOWER_IS);
                                sprintf
                                (   saystring,
                                    LLL(MSG_PROMPT_LOWERIS, "%s, lower internal stability of..."),
                                    e[we].name
                                );
                                strcpy(WhoTitle, LLL(MSG_HAIL_LOWERIS, "Lower IS of:"));
                            }
                            say(UPPER, EUROCOLOUR + we, "-", "-");
                            order[we][wo].dest = dowho(we, TRUE, &order[we][wo].data1, cash / 4);
                            clearkybd_gt(EOrdersWindowPtr);
                            if (order[we][wo].dest == -1 || order[we][wo].data1 == 0)
                            {   mistake = TRUE;
                            } else
                            {   order[we][wo].dest -= EUROPEANS;
                                order[we][wo].fee  =  4 * order[we][wo].data1;
                                clearkybd_gt(EOrdersWindowPtr);
                            }
                        acase ORDER_INSTALL_LEADER:
                        case ORDER_INSTALL_JUNTA:
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   enabled[we2] = FALSE;
                            }
                            for (wa = 0; wa < RAFRICANS; wa++)
                            {   if
                                (   a[wa].aruler == wa
                                 && a[wa].eruler == we
                                 && a[wa].pi     >= POLITICAL_CONTROL
                                 && a[wa].govt   == OTHER
                                 && hasarmy(wa)
                                 && !installed[wa]
                                )
                                {   enabled[EUROPEANS + wa] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa] = FALSE; // conquered country has no IS to adjust
                            }   }
                            sprintf
                            (   saystring,
                                LLL(MSG_PROMPT_INSTALLGOVT, "%s, install %s in..."),
                                e[we].name,
                                (writeorder == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta")
                            );
                            sprintf
                            (   WhoTitle,
                                LLL(MSG_HAIL_INSTALLGOVT, "Install %s in:"),
                                (writeorder == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta")
                            );
                            say(UPPER, EUROCOLOUR + we, "-", "-");
                            order[we][wo].dest = dowho(we, TRUE, NULL, 0);
                            clearkybd_gt(EOrdersWindowPtr);
                            if (order[we][wo].dest == -1)
                            {   mistake = TRUE;
                            } else
                            {   order[we][wo].dest -= EUROPEANS;
                                order[we][wo].fee = 2;
                                installed[order[we][wo].dest] = TRUE;
                            }
                        acase ORDER_BUILD_IU:
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   enabled[we2] = FALSE;
                            }
                            for (wa = 0; wa < RAFRICANS; wa++)
                            {   if
                                (   a[wa].aruler == wa
                                 && a[wa].eruler == we
                                 && a[wa].pi     >= MILITARY_CONTROL
                                )
                                {   enabled[EUROPEANS + wa] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa] = FALSE;
                            }   }
                            sprintf
                            (   saystring,
                                LLL(MSG_PROMPT_BUILDIU, "%s, build Intervention Unit for..."),
                                e[we].name
                            );
                            say(UPPER, EUROCOLOUR + we, "-", "-");
                            strcpy(WhoTitle, LLL(MSG_HAIL_BUILDIU, "Build IU for:"));
                            order[we][wo].dest = dowho(we, TRUE, NULL, 0);
                            clearkybd_gt(EOrdersWindowPtr);
                            if (order[we][wo].dest == -1)
                            {   mistake = TRUE;
                            } else
                            {   order[we][wo].dest -= EUROPEANS;
                                if (we == USA || we == USSR)
                                {   order[we][wo].fee = 4;
                                } else
                                {   order[we][wo].fee = 2;
                                }
                                iudone = TRUE;
                            }
                        acase ORDER_GIVE_MONEY:
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   if (we2 < players && we != we2)
                                {   enabled[we2] = TRUE;
                                } else
                                {   enabled[we2] = FALSE;
                            }   }
                            for (wa = 0; wa < RAFRICANS; wa++)
                            {   if (a[wa].aruler == wa)
                                {   enabled[EUROPEANS + wa] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa] = FALSE; // can't give to conquered country
                            }   }

                            sprintf
                            (   saystring,
                                LLL(MSG_PROMPT_GIVEMONEY, "%s, give to..."),
                                e[we].name
                            );
                            say(UPPER, EUROCOLOUR + we, "-", "-");
                            strcpy(WhoTitle, LLL(MSG_HAIL_GIVEMONEY, "Give to:"));
                            order[we][wo].dest = dowho(we, TRUE, &order[we][wo].data1, cash);
                            clearkybd_gt(EOrdersWindowPtr);
                            if (order[we][wo].dest == NON || order[we][wo].data1 == 0)
                            {   mistake = TRUE;
                            } else
                            {   clearkybd_gt(EOrdersWindowPtr);
                                order[we][wo].fee = order[we][wo].data1;
                            }
                        acase ORDER_MAINTAIN_IU:
                            if (we == USA || we == USSR)
                            {   order[we][wo].fee = 4;
                            } else
                            {   order[we][wo].fee = 2;
                            }
                            iudone = TRUE;
                        }
                        if (!mistake)
                        {   cash -= order[we][wo].fee;
                            wo++;
        }   }   }   }   }
        while (!reallydone);

        order[we][wo].command = ORDER_DONE;

        EOrdersXPos = EOrdersWindowPtr->LeftEdge;
        EOrdersYPos = EOrdersWindowPtr->TopEdge;
        CloseWindow(EOrdersWindowPtr);
        EOrdersWindowPtr = NULL;

        clearkybd_gt(MainWindowPtr);
    } while (redo);

    FreeGadgets(EOrdersGListPtr);
    EOrdersGListPtr = NULL;
    FreeNameNodes(&EList1);
    FreeNameNodes(&EList2);
}

// 10. COMPILER SPECIFICS ------------------------------------------------

#ifdef LATTICE
    int  CXBRK(void)    { return 0; } /* Disable SAS/C Ctrl-C handling */
    void chkabort(void) { ;         } /* really */
#endif

// 11. MODULE (PRIVATE) FUNCTIONS-----------------------------------------

MODULE void gameloop(void)
{   SLONG we,
          wa,
          war,
          highest,
          winner = -1; // to avoid spurious compiler warnings
    FLAG  won;
    TEXT  numberstring[3 + 1],
          tempstring[80 + 1];
    int   tied;

    do
    {   sprintf
        (   saystring,
            LLL(MSG_WHICHROUND, "Round %d of %d"),
            theround,
            rounds
        );
        sprintf(MainTitle, "%s: %s", TITLEBAR, saystring);
        SetWindowTitles(MainWindowPtr, MainTitle, MainTitle); // this is not copied, it is a pointer
        strcat(saystring, "...");
        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));

         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,       NOSUB));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,      NOSUB));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,    NOSUB));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE, NOSUB));

        strcpy(oldpathname, pathname);
        strcpy(pathname, "PROGDIR:Autosave.africa");
        savegame(FALSE, TRUE);
        strcpy(pathname, oldpathname);

#ifndef TESTING
        DISCARD getevent(ROUND);
#endif

        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,       NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,      NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,    NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE, NOSUB));

        won = FALSE;
        if (globalrc != QUITTOTITLE)
        {   oneround();
            won = calcscores();
            theround++;
    }   }
    while (theround <= rounds && globalrc != QUITTOTITLE && !won);

    for (we = 0; we < EUROPEANS; we++)
    {   remove_iu(we, FALSE);
    }
    for (wa = 0; wa < RAFRICANS; wa++)
    {   for (war = 0; war < setup[wa].maxarmies; war++)
        {   remove_army(wa, war, FALSE);
    }   }
    // no reason to call updatescreen() as we are about to blank the screen
    clearscreen();

    if (globalrc != QUITTOTITLE)
    {   theround--;

        SetAPen(&OffScreenRastPort, remapit[GREY]);
        RectFill
        (   &OffScreenRastPort,
            320 - 98, 187,
            320 + 98, 198
        );

        shadowtext(      &OffScreenRastPort, (STRPTR) LLL(MSG_PLAYER, "Player"), WHITE, 320 - 98 + 4, 195);
        shadowtext_right(&OffScreenRastPort, (STRPTR) LLL(MSG_SCORE , "Score" ), WHITE, 320 + 98 - 4, 195);

        for (we = 0; we < players; we++)
        {   SetAPen(&OffScreenRastPort, remapit[EUROCOLOUR + we]);
            RectFill
            (   &OffScreenRastPort,
                320 - 98, 200 + (we * 13),
                320 + 98, 211 + (we * 13)
            );

            shadowtext(      &OffScreenRastPort, e[we].name,   WHITE, 320 - 98 + 4, 208 + (we * 13));
            stcl_d(numberstring, score[we][theround]);
            shadowtext_right(&OffScreenRastPort, numberstring, WHITE, 320 + 98 - 4, 208 + (we * 13));

            SetAPen(&OffScreenRastPort, remapit[BLACK]);
            // underline (beneath)
            Move(&OffScreenRastPort, 320 - 98, 212 + (we * 13));
            Draw(&OffScreenRastPort, 320 + 98, 212 + (we * 13));
        }

        // overline (above)
        Move(&OffScreenRastPort, 320 - 98               , 186                 );
        Draw(&OffScreenRastPort, 320 + 98               , 186                 );
        // underline (beneath)
        Move(&OffScreenRastPort, 320 - 98               , 199                 );
        Draw(&OffScreenRastPort, 320 + 98               , 199                 );
        // vertical lines
        Move(&OffScreenRastPort, 320 - 98 - 1           , 186                 );
        Draw(&OffScreenRastPort, 320 - 98 - 1           , 199 + (players * 13));
        Move(&OffScreenRastPort, 320 - 98 + (fontx * 17), 186                 );
        Draw(&OffScreenRastPort, 320 - 98 + (fontx * 17), 199 + (players * 13));
        Move(&OffScreenRastPort, 320 + 98 + 1           , 186                 );
        Draw(&OffScreenRastPort, 320 + 98 + 1           , 199 + (players * 13));

        for (we = 0; we < EUROPEANS; we++)
        {   remove_iu(we, FALSE);
        }
        for (wa = 0; wa < RAFRICANS; wa++)
        {   for (war = 0; war < setup[wa].maxarmies; war++)
            {   remove_army(wa, war, FALSE);
        }   }
        // updatescreen() not needed

        highest = -1;
        for (we = 0; we < players; we++)
        {   if (score[we][theround] > highest)
            {   highest = score[we][theround];
                winner = we;
        }   }
        tied = 0;
        for (we = 0; we < players; we++)
        {   if (score[we][theround] == highest)
            {   tied++;
        }   }

        strcpy(saystring, LLL(MSG_GAMEOVER, "Game over!"));
        if (tied < 2)
        {   sprintf
            (   tempstring,
                " %s %s!",
                e[winner].name,
                LLL(MSG_WINS, "wins")
            );
            strcat(saystring, tempstring);
        }
        eventmode = GAMEOVER; // for updatescreen() via say()
        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        strcpy(saystring, "-"); // not saystring[0] = EOS;
        say(LOWER, WHITE, "", "");

        Delay(50);
        clearkybd_gt(MainWindowPtr);
        DISCARD getevent(GAMEOVER);
}   }

MODULE void system_newgame(void)
{   SLONG wa,  // which african
          wa2, // which other african
          wb,  // which box
          wc,  // which city
          we,  // which european
          war; // which army

    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_SCORE_GRAPH,  NOSUB));
    if (AmigaGuideBase)
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL, NOSUB));
    }

    pathname[0] = EOS;

    // SET UP

    for (we = 0; we < EUROPEANS; we++)
    {   e[we].treasury = 0;
        e[we].iu       = FALSE;
    }
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (colonial)
        {   a[wa].name = aname[1][wa];
        } else
        {   a[wa].name = aname[0][wa];
        }
        a[wa].eruler   = setup[wa].eruler;
        a[wa].pi       = setup[wa].pi;
        a[wa].is       = setup[wa].is;
        a[wa].govt     = setup[wa].govt;
        a[wa].aruler   = setup[wa].aruler;
        a[wa].treasury = 0;
        fresh[wa]  =
        fallen[wa] = FALSE;
        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
        {   a[wa].declared[wa2] = FALSE;
        }
        for (war = 0; war < setup[wa].maxarmies; war++)
        {   a[wa].army[war].alive = FALSE;
            a[wa].army[war].x =
            a[wa].army[war].y = -1;
            killgovt(wa, war, FALSE);
    }   }
    for (wb = 0; wb < 6; wb++)
    {   box[wb].x = box[wb].y = -1;
    }
    for (wc = 0; wc < CITIES; wc++)
    {   city[wc].aruler = city[wc].oaruler;
    }
    city[10].aruler = ZAIRE_R;
    city[19].aruler =
    city[20].aruler = SOUTHAFRICA; // Namibian cities
    a[SOUTHAFRICA].declared[NAMIBIA] = TRUE; // probably not necessary
    a[ZAIRE].declared[ZAIRE_R] =
    a[ZAIRE_R].declared[ZAIRE] = TRUE;

    setup[SOUTHAFRICA].cities = 6;
    setup[NAMIBIA].cities     = 0;
    hexowner[5][5] =
    hexowner[5][6] =
    hexowner[6][5] =
    hexowner[6][6] =
    hexowner[7][6] = ZAIRE_R;
    hexowner[10][2] =
    hexowner[10][3] =
    hexowner[10][4] =
    hexowner[11][1] =
    hexowner[11][2] =
    hexowner[11][3] =
    hexowner[12][2] =
    hexowner[12][3] =
    hexowner[13][2] =
    hexowner[13][3] =
    hexowner[14][3] = SOUTHAFRICA;

    clearscreen();
    drawtables(); // calls afrocolours()
    drawmap();

    engine_newgame();

    hexowner[10][2] =
    hexowner[10][3] =
    hexowner[10][4] =
    hexowner[11][1] =
    hexowner[11][2] =
    hexowner[11][3] =
    hexowner[12][2] =
    hexowner[12][3] =
    hexowner[13][2] =
    hexowner[13][3] =
    hexowner[14][3] = NAMIBIA;
    hexowner[5][5] =
    hexowner[5][6] =
    hexowner[6][5] =
    hexowner[6][6] =
    hexowner[7][6] = ZAIRE;
    setup[SOUTHAFRICA].cities = 4;
    setup[NAMIBIA].cities     = 2;

    theround = 1;
}

MODULE void titlescreen(void)
{   TRANSIENT TEXT  tempstring[3 + 1]; // "(#)"
    TRANSIENT SLONG we;
    PERSIST   FLAG  first = TRUE;

    ingame =
    loaded = FALSE;
    ignore = 0;

     OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE,    NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_SCORE_GRAPH,  NOSUB));
    if (AmigaGuideBase)
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL,       NOSUB));
    }

     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_ABOUT,        NOSUB)); // this shouldn't be necessary (but is for some reason!)

    SetWindowTitles(MainWindowPtr, TITLEBAR, TITLEBAR); // this is not copied, it is a pointer

    // this is different to clearscreen()!
    SetAPen(MainWindowPtr->RPort, remapit[TSBG]);
    RectFill(MainWindowPtr->RPort, LEFTGAP, TOPGAP, LEFTGAP + SCREENXPIXEL - 1, TOPGAP + SCREENYPIXEL - 1);

    if (DisplayWidth > SCREENXPIXEL && DisplayHeight > SCREENYPIXEL)
    {   // assert(customscreen);

        SetAPen(MainWindowPtr->RPort, 28);
        WritePixel(MainWindowPtr->RPort, LEFTGAP                   , TOPGAP);
        WritePixel(MainWindowPtr->RPort, LEFTGAP + SCREENXPIXEL - 1, TOPGAP);
        WritePixel(MainWindowPtr->RPort, LEFTGAP                   , TOPGAP + SCREENYPIXEL - 1);
        WritePixel(MainWindowPtr->RPort, LEFTGAP + SCREENXPIXEL - 1, TOPGAP + SCREENYPIXEL - 1);
    }

    DrawImage
    (   MainWindowPtr->RPort,
        &Logo,
        (DisplayWidth / 2) - (Logo.Width / 2),
        TOPGAP + 66
    );

    for (we = 0; we < EUROPEANS; we++)
    {   shadowtext_right(MainWindowPtr->RPort, cyclename[we], EUROCOLOUR + we, LEFTGAP + 292    , TOPGAP + 209 + (we * 13)    );
        sprintf(tempstring, "(%d)", (int) (we + 1));
        shadowtext(      MainWindowPtr->RPort, tempstring   , EUROCOLOUR + we, LEFTGAP + 438    , TOPGAP + 209 + (we * 13)    );
        shadowtext(      MainWindowPtr->RPort, "_"          , EUROCOLOUR + we, LEFTGAP + 438 + 8, TOPGAP + 209 + (we * 13) + 2);
    }

    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_PLAYERS     , "Players:"                      ), WHITE,           LEFTGAP + 292, TOPGAP + 196);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_DELAY       , "Message Delay:"                ), WHITE,           LEFTGAP + 292, TOPGAP + 289);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_ROUNDS      , "Rounds:"                       ), WHITE,           LEFTGAP + 292, TOPGAP + 303);

    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_ALLOWUK     , "Allow UK IU?"                  ), EUROCOLOUR + UK, LEFTGAP + 394, TOPGAP + 332);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_AUTOMAINTAIN, "Auto-maintain African armies?" ), WHITE,           LEFTGAP + 394, TOPGAP + 346);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_AUTOSETUP   , "Auto-setup game?"              ), WHITE,           LEFTGAP + 394, TOPGAP + 360);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_PLAYALL     , "Play all rounds?"              ), WHITE,           LEFTGAP + 394, TOPGAP + 374);
    shadowtext_right(MainWindowPtr->RPort, (STRPTR) LLL(MSG_COLONIAL    , "Use colonial names?"           ), WHITE,           LEFTGAP + 394, TOPGAP + 388);

    shadowtext(      MainWindowPtr->RPort, "(P)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 196    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 196 + 2);
    shadowtext(      MainWindowPtr->RPort, "(R)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 303    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 303 + 2);

    shadowtext(      MainWindowPtr->RPort, "(U)"            , EUROCOLOUR + UK, LEFTGAP + 438    , TOPGAP + 332    );
    shadowtext(      MainWindowPtr->RPort, "_"              , EUROCOLOUR + UK, LEFTGAP + 438 + 8, TOPGAP + 332 + 2);
    shadowtext(      MainWindowPtr->RPort, "(M)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 346    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 346 + 2);
    shadowtext(      MainWindowPtr->RPort, "(S)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 360    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 360 + 2);
    shadowtext(      MainWindowPtr->RPort, "(A)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 374    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 374 + 2);
    shadowtext(      MainWindowPtr->RPort, "(C)"            , WHITE,           LEFTGAP + 438    , TOPGAP + 388    );
    shadowtext(      MainWindowPtr->RPort, "_"              , WHITE,           LEFTGAP + 438 + 8, TOPGAP + 388 + 2);

    changespeed();
    changerounds();

    for (we = 0; we < EUROPEANS; we++)
    {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, (we >= players), GTCY_Active, e[we].control, TAG_DONE);
    }
    GT_SetGadgetAttrs(    SpeedGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTSL_Level,   speed,       TAG_DONE);
    GT_SetGadgetAttrs(   RoundsGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTSL_Level,   rounds,      TAG_DONE);
    GT_SetGadgetAttrs(  PlayersGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCY_Active,  players - 2, TAG_DONE);
    GT_SetGadgetAttrs(     UKIUGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCB_Checked, ukiu,        TAG_DONE);
    GT_SetGadgetAttrs(  EndlessGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCB_Checked, endless,     TAG_DONE);
    GT_SetGadgetAttrs( ColonialGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCB_Checked, colonial,    TAG_DONE);
    GT_SetGadgetAttrs( MaintainGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCB_Checked, maintain,    TAG_DONE);
    GT_SetGadgetAttrs(AutoSetupGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE, GTCB_Checked, autosetup,   TAG_DONE);
    GT_SetGadgetAttrs(    StartGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE,                            TAG_DONE);
    RefreshGadgets(MainGListPtr, MainWindowPtr, NULL);

    if (first)
    {   first = FALSE;
        ScreenToFront(ScreenPtr); // only really needed the first time
    }

    DISCARD getevent(TITLESCREEN);

    if (!loaded)
    {   for (we = 0; we < EUROPEANS; we++)
        {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        }
        GT_SetGadgetAttrs(SpeedGadgetPtr,     MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(RoundsGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(PlayersGadgetPtr,   MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(UKIUGadgetPtr,      MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(EndlessGadgetPtr,   MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(ColonialGadgetPtr,  MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(MaintainGadgetPtr,  MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(AutoSetupGadgetPtr, MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(StartGadgetPtr,     MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
     // RefreshGadgets(MainGListPtr, MainWindowPtr, NULL); seems not to be needed?

        system_newgame();
}   }

EXPORT FLAG loadgame(FLAG aslwindow)
{   SLONG offset,
          we,
          wc,
          wa,
          wa2,
          war;
    TEXT  newpathname[MAX_PATH + 1];
    BPTR  FileHandle /* = ZERO */ ;
    FLAG  ok;
    int   i;

    newpathname[0] = EOS;
    setbarcolour(-1);

    if (aslwindow)
    {   if
        (   AslRequestTags(ASLRqPtr,
                ASL_Hail,          (ULONG) LLL(MSG_HAIL_LOAD, "Load Game"),
                ASL_FuncFlags,     FILF_PATGAD,
                ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         && ASLRqPtr->rf_File[0] != EOS
        )
        {   strcpy(newpathname, ASLRqPtr->rf_Dir);
            DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
            ok = TRUE;
        } else
        {   ok = FALSE;
    }   }
    else
    {   ok = TRUE;
        strcpy(newpathname, pathname);
    }

    if (!ok || newpathname[0] == EOS)
    {   return FALSE;
    }

    if (!(FileHandle = Open(newpathname, MODE_OLDFILE)))
    {   strcpy(saystring, "Can't open file for reading!");
        msg();
        return FALSE;
    }

    // read file
    if (Read(FileHandle, IOBuffer, SAVELENGTH) != SAVELENGTH)
    {   DISCARD Close(FileHandle);
        // FileHandle = NULL;
        strcpy(saystring, "Can't read from file!");
        msg();
        return FALSE;
    }

    DISCARD Close(FileHandle);
    // FileHandle = NULL;

    if (strcmp((char*) IOBuffer, "Africa 1.3 "))
    {   strcpy(saystring, "This is not a valid Africa 1.3+ game file!"); // should localize this
        msg();
        return FALSE;
    }

    theround = (SLONG) ((SBYTE) IOBuffer[12]);
    rounds   = (SLONG) ((SBYTE) IOBuffer[13]);
    players  = (SLONG) ((SBYTE) IOBuffer[14]);
    ukiu     = (BOOL)  ((SBYTE) IOBuffer[15]);

    offset = 16;

    for (we = 0; we < EUROPEANS; we++)
    {   e[we].control  = (SLONG) ((SBYTE) IOBuffer[offset++]);
        e[we].treasury = (SLONG) ((SBYTE) IOBuffer[offset++]);
        e[we].iu       = (FLAG)  ((SBYTE) IOBuffer[offset++]);
        e[we].iux      = (SLONG) ((SBYTE) IOBuffer[offset++]);
        e[we].iuy      = (SLONG) ((SBYTE) IOBuffer[offset++]);
        e[we].iuhost   = (SLONG) ((SBYTE) IOBuffer[offset++]);
        for (i = 0; i <= 99; i++)
        {   score[we][i] = (SLONG) ((SBYTE) IOBuffer[offset++]);
    }   }

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (colonial)
        {   a[wa].name = aname[1][wa];
        } else
        {   a[wa].name = aname[0][wa];
        }

        a[wa].eruler   = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].aruler   = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].pi       = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].is       = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].treasury = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].govt     = (SLONG) ((SBYTE) IOBuffer[offset++]);
        a[wa].govtarmy = (SLONG) ((SBYTE) IOBuffer[offset++]);

        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
        {   a[wa].declared[wa2]   = (FLAG)       IOBuffer[offset++] ;
        }

        for (war = 0; war < setup[wa].maxarmies; war++)
        {   a[wa].army[war].alive = (FLAG)           IOBuffer[offset++] ;
            a[wa].army[war].x     = (SLONG) ((SBYTE) IOBuffer[offset++]);
            a[wa].army[war].y     = (SLONG) ((SBYTE) IOBuffer[offset++]);
    }   }

    for (wc = 0; wc < CITIES; wc++)
    {   city[wc].aruler = (SLONG) ((SBYTE) IOBuffer[offset++]);
    }

    strcpy(pathname, newpathname);

    for (we = 0; we < EUROPEANS; we++)
    {   GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    }
    GT_SetGadgetAttrs(SpeedGadgetPtr,     MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(RoundsGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(UKIUGadgetPtr,      MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(EndlessGadgetPtr,   MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(ColonialGadgetPtr,  MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(MaintainGadgetPtr,  MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(PlayersGadgetPtr,   MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(AutoSetupGadgetPtr, MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
    GT_SetGadgetAttrs(StartGadgetPtr,     MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);

    clearscreen();
    drawtables(); // calls afrocolours
    drawmap();

    for (we = 0; we < EUROPEANS; we++)
    {   if (e[we].iu)
        {   move_iu(we, FALSE);
        } else
        {   remove_iu(we, FALSE);
    }   }
    for (wa = 0; wa < RAFRICANS; wa++)
    {   for (war = 0; war < setup[wa].maxarmies; war++)
        {   if (a[wa].army[war].alive)
            {   move_army(wa, war, FALSE);
            } else
            {   remove_army(wa, war, FALSE);
        }   }
        if (a[wa].govtarmy != war)
        {   killgovt(wa, war, FALSE);
        }
        if (a[wa].govt == LEADER)
        {   makeleader(wa, a[wa].govtarmy, FALSE);
        } elif (a[wa].govt == JUNTA)
        {   makejunta(wa, a[wa].govtarmy, FALSE);
    }   }
    updatescreen();

    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_SCORE_GRAPH,  NOSUB));

    return TRUE;
}

MODULE void savegame(FLAG saveas, FLAG autosaving)
{   SLONG offset,
          we,
          wc,
          wa,
          wa2,
          war;
    TEXT  newpathname[MAX_PATH + 1];
    BPTR  FileHandle /* = ZERO */ ;
    int   i;

    setbarcolour(-1);

    strcpy(newpathname, pathname);
    if (saveas || newpathname[0] == EOS)
    {   if
        (   AslRequestTags(ASLRqPtr,
                ASL_Hail,          (ULONG) LLL(MSG_HAIL_SAVE, "Save Game"),
                ASL_FuncFlags,     FILF_PATGAD | FILF_SAVE,
                ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         && ASLRqPtr->rf_File[0] != EOS
        )
        {   strcpy(newpathname, ASLRqPtr->rf_Dir);
            DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
        } else
        {   return;
    }   }
                           // 012345678901
    strcpy((char*) IOBuffer, "Africa 1.3 ");
    IOBuffer[12] = (UBYTE) theround;
    IOBuffer[13] = (UBYTE) rounds;
    IOBuffer[14] = (UBYTE) players;
    IOBuffer[15] = (UBYTE) ukiu;

    offset = 16;
    for (we = 0; we < EUROPEANS; we++)
    {   IOBuffer[offset++] = (UBYTE) e[we].control;
        IOBuffer[offset++] = (UBYTE) e[we].treasury;
        IOBuffer[offset++] = (UBYTE) e[we].iu;
        IOBuffer[offset++] = (UBYTE) e[we].iux;
        IOBuffer[offset++] = (UBYTE) e[we].iuy;
        IOBuffer[offset++] = (UBYTE) e[we].iuhost;
        for (i = 0; i <= 99; i++)
        {   IOBuffer[offset++] = (UBYTE) score[we][i];
    }   }

    for (wa = 0; wa < RAFRICANS; wa++)
    {   IOBuffer[offset++] = (UBYTE) a[wa].eruler;
        IOBuffer[offset++] = (UBYTE) a[wa].aruler;
        IOBuffer[offset++] = (UBYTE) a[wa].pi;
        IOBuffer[offset++] = (UBYTE) a[wa].is;
        IOBuffer[offset++] = (UBYTE) a[wa].treasury;
        IOBuffer[offset++] = (UBYTE) a[wa].govt;
        IOBuffer[offset++] = (UBYTE) a[wa].govtarmy;

        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
        {   IOBuffer[offset++] = (UBYTE) a[wa].declared[wa2];
        }

        for (war = 0; war < setup[wa].maxarmies; war++)
        {   IOBuffer[offset++] = (UBYTE) a[wa].army[war].alive;
            IOBuffer[offset++] = (UBYTE) a[wa].army[war].x;
            IOBuffer[offset++] = (UBYTE) a[wa].army[war].y;
    }   }

    for (wc = 0; wc < CITIES; wc++)
    {   IOBuffer[offset++] = (UBYTE) city[wc].aruler;
    }

    if
    (   strlen(newpathname) < strlen(".africa") + 1
     || stricmp(&newpathname[strlen(newpathname) - strlen(".africa")], ".africa")
    )
    {   strcat(newpathname, ".africa");
    }

    if (!(FileHandle = Open(newpathname, MODE_NEWFILE)))
    {   strcpy(saystring, "Can't open ");
        strcat(saystring, newpathname);
        strcat(saystring, " for writing!");
        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        return;
    }

    if (Write(FileHandle, IOBuffer, offset) != offset)
    {   DISCARD Close(FileHandle);
        // FileHandle = NULL;
        strcpy(saystring, "Can't write to ");
        strcat(saystring, " ");
        strcat(saystring, newpathname);
        strcat(saystring, "!");
        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        return;
    }

#ifdef EXTRAVERBOSE
    DISCARD Printf("%d bytes written.\n", offset);
#endif

    // assert(offset == SAVELENGTH);

    DISCARD Close(FileHandle);
    // FileHandle = NULL;

    strcpy(pathname, newpathname);

    if (!autosaving)
    {   sprintf
        (   saystring,
            LLL(MSG_SAVED, "Saved \"%s\"."),
            pathname
        );
        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        // anykey() not needed!
}   }

MODULE void cycle(SLONG we, UWORD qual)
{   if (e[we].control == CONTROL_HUMAN)
    {   e[we].control = CONTROL_AMIGA;
    } else
    {   // assert(e[we].control == CONTROL_AMIGA);
        e[we].control = CONTROL_HUMAN;
    }
    GT_SetGadgetAttrs(CycleGadgetPtr[we], MainWindowPtr, NULL, GTCY_Active, e[we].control, TAG_DONE);
}

#ifdef __amigaos4__
MODULE void AddNameToTail(struct List* ListPtr, const char* name)
#else
MODULE void AddNameToTail(struct List* ListPtr, STRPTR name)
#endif
{   /* RKM Libraries, p. 496:

    "Allocate a NameNode structure, copy the given name into the
    structure, then add it [to] the...list." */

    struct NameNode* NameNodePtr;

    if (!(NameNodePtr = (struct NameNode*) AllocMem(sizeof(struct NameNode), MEMF_CLEAR)))
    {   rq("Out of memory!"); // hopefully we have enough memory to display this :-(
    }
    strcpy((STRPTR) NameNodePtr->nn_Data, name);
    NameNodePtr->nn_Node.ln_Name = (STRPTR) NameNodePtr->nn_Data;
    NameNodePtr->nn_Node.ln_Type = NT_USER;
    NameNodePtr->nn_Node.ln_Pri  = 0;
    AddTail((struct List*) ListPtr, (struct Node*) NameNodePtr);
}

MODULE void FreeNameNodes(struct List* ListPtr)
{   /* RKM Libraries, p. 496:

    "Free the entire list, including the header. The header is not
    updated as the list is freed. This function demonstrates how to
    avoid referencing freed memory when deallocating nodes." */

    struct NameNode *WorkNodePtr,
                    *NextNodePtr;

    WorkNodePtr = (struct NameNode*) (ListPtr->lh_Head); /* first node */
    while ((NextNodePtr = (struct NameNode*) (WorkNodePtr->nn_Node.ln_Succ)))
    {   FreeMem(WorkNodePtr, sizeof(struct NameNode));
        WorkNodePtr = NextNodePtr;
}   }

MODULE SLONG checkcountry(SWORD mousex, SWORD mousey)
{   TRANSIENT       int    xinhex, yinhex;
    PERSIST   const STRPTR hexshape[8] = {
"W--NNNNNNNNNNNNNNNNNNNNNNNNN--", // 0 (18)
"WWW--NNNNNNNNNNNNNNNNNNNNN--EE",
"WWWWW-NNNNNNNNNNNNNNNNNNN-EEEE",
"WWWWWW--NNNNNNNNNNNNNNN--EEEEE",
"WWWWWWWW--NNNNNNNNNNN--EEEEEEE",
"WWWWWWWWWW-NNNNNNNNN-EEEEEEEEE", // 5 (23)
"WWWWWWWWWWW--NNNNN--EEEEEEEEEE",
"WWWWWWWWWWWWW--N--EEEEEEEEEEEE", // 7 (25)
};

    /* Returns the country number, or NON for none.
       If it is a valid hex, xhex and yhex are also set as appropriate.

    Normalize coords with respect to the map */
    mousex -= (LEFTGAP + 640 -  4 - MapImage.Width);
    mousey -= ( TOPGAP + 512 - 19 - MapImage.Height);

    if (mousex < 0 || mousey < 0)
    {   return NON;
    }

    if (mousey < 8)
    {   yhex   = -1;
        yinhex = mousey + 18; // 0..7 -> 18..25
    } else
    {   yhex   = (mousey - 8) / 26;
        yinhex = (mousey - 8) % 26;
    }
    if (yhex % 2)
    {   mousex -= 15;
    }

    if (mousex / 30 >= MAPCOLUMNS) // too far right
    {   return NON;
    }

    xhex   = mousex / 30;
    xinhex = mousex % 30;

    if (yinhex >= 18)
    {   switch (hexshape[yinhex - 18][xinhex])
        {
        case 'W':
            yhex++;
            if (  yhex % 2 ) xhex--;
        acase 'E':
            yhex++;
            if (!(yhex % 2)) xhex++;
        acase '-':
            return NON; // borderline
    }   }
    elif (mousex % 30 == 0) // borderline
    {   return NON;
    }

    return whosehex(xhex, yhex);
}

MODULE void showcountry(SLONG wa)
{   SLONG wc;

    if (wa != NON)
    {   strcpy(saystring, a[wa].name);
        for (wc = 0; wc < CITIES; wc++)
        {   if (xhex == city[wc].x && yhex == city[wc].y)
            {   strcat(saystring, " (");
                strcat(saystring, colonial ? city[wc].oname : city[wc].nname);
                strcat(saystring, ")");
                break; // for speed
    }   }   }
    else
    {   strcpy(saystring, "-");
    }
    say(LOWER, WHITE, "", "");
}

MODULE void afrocolours(void)
{   ULONG intensity;
    SLONG wa;

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (customscreen || gotpen[AFROCOLOUR + wa])
        {   if (a[a[wa].aruler].pi <= 0)
            {   SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa], 8, 8, 8); // grey
            } else
            {   if (a[a[wa].aruler].pi <= 3)
                {   intensity = 9;
                } elif (a[a[wa].aruler].pi <= 6)
                {   intensity = 12;
                } else
                {   intensity = 15;
                }

            /* PI    Intensity
                1         9
                2         9
                3         9
                4        12
                5        12
                6        12
                7        15
                8        15
                9        15
               10        15 */

                switch (a[a[wa].aruler].eruler) // look at the aruler's eruler
                {
                case  USA:   SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa],         7,         7, intensity); // blue
                acase USSR:  SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa], intensity,         5,         5); // red
                acase CHINA: SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa],         5, intensity,         5); // green
                acase FRANCE:SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa], intensity, intensity,         5); // yellow
                acase UK:    SetRGB4(&ScreenPtr->ViewPort, remapit[AFROCOLOUR + wa], intensity,         5, intensity); // purple
}   }   }   }   }

MODULE void close_eorders(void)
{   if (EOrdersWindowPtr)
    {   EOrdersXPos = EOrdersWindowPtr->LeftEdge;
        EOrdersYPos = EOrdersWindowPtr->TopEdge;
        CloseWindow(EOrdersWindowPtr);
        EOrdersWindowPtr = NULL;

        if (EOrdersGListPtr)
        {   FreeGadgets(EOrdersGListPtr);
            EOrdersGListPtr = NULL;
        }

        FreeNameNodes(&EList1);
        FreeNameNodes(&EList2);
}   }

MODULE void changespeed(void)
{   TEXT tempstring[20 + 1];

    if (tickspeed[speed] == -1)
    {   strcpy(tempstring, (STRPTR) LLL(MSG_INFINITE, "Infinite"));
    } else
    {   sprintf
        (   tempstring,
            (STRPTR) LLL(MSG_SECS, "%d.%d secs"),
            tickspeed[speed] / 10,
            tickspeed[speed] % 10
        ); // maybe say "Instant" instead of "0.0 secs"
    }
    SetAPen(MainWindowPtr->RPort, remapit[TSBG]);
    RectFill
    (   MainWindowPtr->RPort,
        LEFTGAP + 438                   , TOPGAP + 282,
        LEFTGAP + 438 + (fontx * maxlen), TOPGAP + 291
    );
    shadowtext(MainWindowPtr->RPort, tempstring,   WHITE, LEFTGAP + 438, TOPGAP + 289);
    GT_SetGadgetAttrs(SpeedGadgetPtr, MainWindowPtr, NULL, GTSL_Level, speed, TAG_DONE);
}

MODULE void changerounds(void)
{   TEXT numberstring[2 + 1];

    stcl_d(numberstring, rounds);
    SetAPen(MainWindowPtr->RPort, remapit[TSBG]);
    RectFill
    (   MainWindowPtr->RPort,
        LEFTGAP + 438 + 32              , TOPGAP + 295,
        LEFTGAP + 455 + 32              , TOPGAP + 304
    );
    shadowtext(MainWindowPtr->RPort, numberstring, WHITE, LEFTGAP + 470, TOPGAP + 303);
}

MODULE void clearscreen(void)
{   SetRast(&OffScreenRastPort, remapit[MAPBACKGROUND]);

    if (DisplayWidth > SCREENXPIXEL && DisplayHeight > SCREENYPIXEL)
    {   // assert(customscreen);

        SetAPen(&OffScreenRastPort, 28);
        WritePixel(&OffScreenRastPort, 0               , 0);
        WritePixel(&OffScreenRastPort, SCREENXPIXEL - 1, 0);
        WritePixel(&OffScreenRastPort, 0               , SCREENYPIXEL - 1);
        WritePixel(&OffScreenRastPort, SCREENXPIXEL - 1, SCREENYPIXEL - 1);
}   }

MODULE void shadowtext_right(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y)
{        SetDrMd(RastPortPtr, JAM1);
         SetAPen(RastPortPtr, (ULONG) remapit[BLACK]);
            Move(RastPortPtr, x + 1 - (strlen(text) * fontx), y + 1);
    DISCARD Text(RastPortPtr, text, strlen(text));
         SetAPen(RastPortPtr, (ULONG) remapit[colour]);
            Move(RastPortPtr, x     - (strlen(text) * fontx), y    );
    DISCARD Text(RastPortPtr, text, strlen(text));
}
MODULE void shadowtextn(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y, ULONG length)
{        SetDrMd(RastPortPtr, JAM1);
         SetAPen(RastPortPtr, (ULONG) remapit[BLACK]);
            Move(RastPortPtr, x + 1, y + 1);
    DISCARD Text(RastPortPtr, text, length);
         SetAPen(RastPortPtr, (ULONG) remapit[colour]);
            Move(RastPortPtr, x, y);
    DISCARD Text(RastPortPtr, text, length);
}

MODULE void declaredwars(void)
{   SLONG                columns,
                         lines,
                         wa,
                         wa2;
    struct IntuiMessage* MsgPtr;
    struct Window*       InfoWindowPtr;
    FLAG                 done    = FALSE;
    ULONG                theclass;
    UWORD                code,
                         qual;
    int                  i,
                         tbwidth,
                         tbheight;

    lines = 0;
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa)
        {   lines++;
    }   }
    columns = lines;

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (DisplayWidth  / 2) - ((SUMMARYWIDTH  + (columns * COLUMNWIDTH)) / 2),
        WA_Top,           (DisplayHeight / 2) - ((SUMMARYHEIGHT + (lines   * ROWHEIGHT  )) / 2),
        WA_InnerWidth,                            SUMMARYWIDTH  + (columns * COLUMNWIDTH )     ,
        WA_InnerHeight,                           SUMMARYHEIGHT + (lines   * ROWHEIGHT   )     ,
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) LLL(MSG_HAIL_DECLAREDWARS, "Declared Wars"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }

    tbwidth  = InfoWindowPtr->BorderLeft;
    tbheight = InfoWindowPtr->BorderTop;

    SetFont(InfoWindowPtr->RPort, FontPtr);
    SetAPen(InfoWindowPtr->RPort, remapit[LIGHTGREY]);
    RectFill
    (   InfoWindowPtr->RPort,
        tbwidth  + 2,
        tbheight + 2,
        tbwidth  + SUMMARYWIDTH  + (columns * COLUMNWIDTH) - 4,
        tbheight + SUMMARYHEIGHT + (lines   * ROWHEIGHT  ) - 4
    );

    columns = 0;
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa)
        {   SetAPen(InfoWindowPtr->RPort, remapit[AFROCOLOUR + wa]);
            RectFill
            (   InfoWindowPtr->RPort,
                tbwidth  + 200 + (columns * COLUMNWIDTH),
                tbheight +   5,
                tbwidth  + 199 + (columns * COLUMNWIDTH) + COLUMNWIDTH,
                tbheight +  47
            );
            shadowtextn(InfoWindowPtr->RPort, a[wa].name,     WHITE, tbwidth + 201 + (columns * COLUMNWIDTH), tbheight + 18, 1);
            shadowtextn(InfoWindowPtr->RPort, &a[wa].name[1], WHITE, tbwidth + 205 + (columns * COLUMNWIDTH), tbheight + 29, 1);
            shadowtextn(InfoWindowPtr->RPort, &a[wa].name[2], WHITE, tbwidth + 209 + (columns * COLUMNWIDTH), tbheight + 40, 1);
            columns++;
    }   }

    lines = 0;
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa)
        {   SetAPen(InfoWindowPtr->RPort, remapit[AFROCOLOUR + wa]);
            RectFill
            (   InfoWindowPtr->RPort,
                tbwidth  +   5,
                tbheight +  49 + (lines   * ROWHEIGHT  ),
                tbwidth  + 200 + (columns * COLUMNWIDTH),
                tbheight +  49 + (lines   * ROWHEIGHT  ) + ROWHEIGHT - 2
            );
            shadowtext
            (   InfoWindowPtr->RPort,
                a[wa].name,
                WHITE,
                tbwidth  +  8,
                tbheight + 56 + (lines * ROWHEIGHT)
            );

            columns = 0;
            for (wa2 = 0; wa2 < RAFRICANS; wa2++)
            {   if (a[wa2].aruler == wa2)
                {   if (wa == wa2)
                    {   SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
                        RectFill
                        (   InfoWindowPtr->RPort,
                            tbwidth  + 201 + (columns * COLUMNWIDTH),
                            tbheight +  49 + (lines   * ROWHEIGHT  ),
                            tbwidth  + 201 + (columns * COLUMNWIDTH) + COLUMNWIDTH - 2,
                            tbheight +  49 + (lines   * ROWHEIGHT  ) + ROWHEIGHT   - 2
                        );
                    } elif (a[wa].declared[wa2])
                    {   SetAPen(InfoWindowPtr->RPort, remapit[WHITE]);
                        RectFill
                        (   InfoWindowPtr->RPort,
                            tbwidth  + 201 + (columns * COLUMNWIDTH),
                            tbheight +  49 + (lines   * ROWHEIGHT  ),
                            tbwidth  + 201 + (columns * COLUMNWIDTH) + COLUMNWIDTH - 2,
                            tbheight +  49 + (lines   * ROWHEIGHT  ) + ROWHEIGHT   - 2
                        );
                    }
                    columns++;
            }   }
            lines++;
    }   }

    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    // do columns
    Move(    InfoWindowPtr->RPort, tbwidth +   4                          , tbheight + 48                      );
    Draw(    InfoWindowPtr->RPort, tbwidth +   4                          , tbheight + 48 + (lines * ROWHEIGHT));
    for (i = 0; i <= columns; i++)
    {   Move(InfoWindowPtr->RPort, tbwidth + 200 + (i       * COLUMNWIDTH), tbheight +  5                      );
        Draw(InfoWindowPtr->RPort, tbwidth + 200 + (i       * COLUMNWIDTH), tbheight + 48 + (lines * ROWHEIGHT));
    }
    // do rows
    Move(    InfoWindowPtr->RPort, tbwidth + 200                          , tbheight +  4                      );
    Draw(    InfoWindowPtr->RPort, tbwidth + 200 + (columns * COLUMNWIDTH), tbheight +  4                      );
    for (i = 0; i <= columns; i++)
    {   Move(InfoWindowPtr->RPort, tbwidth +   5                          , tbheight + 48 + (i     * ROWHEIGHT));
        Draw(InfoWindowPtr->RPort, tbwidth + 200 + (columns * COLUMNWIDTH), tbheight + 48 + (i     * ROWHEIGHT));
    }

    while (!done)
    {   if
        (   Wait
            (   (1 << InfoWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   CloseWindow(InfoWindowPtr);
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GetMsg(InfoWindowPtr->UserPort)))
        {   theclass = MsgPtr->Class;
            code     = MsgPtr->Code;
            qual     = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            switch (theclass)
            {
            case IDCMP_CLOSEWINDOW:
            case IDCMP_MOUSEBUTTONS:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if (!(qual & IEQUALIFIER_REPEAT) && code < KEYUP && (code < FIRSTQUALIFIER || code > LASTQUALIFIER))
                {   if
                    (   code == SCAN_ESCAPE
                     && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    )
                    {   CloseWindow(InfoWindowPtr);
                        cleanexit(EXIT_SUCCESS);
                    } elif (code != NM_WHEEL_UP && code != NM_WHEEL_DOWN)
                    {   done = TRUE;
    }   }   }   }   }

    CloseWindow(InfoWindowPtr);

    clearkybd_gt(MainWindowPtr);
}

MODULE void hexhelp(void)
{   int                  tbwidth,
                         tbheight;
    struct IntuiMessage* MsgPtr;
    struct Window*       InfoWindowPtr;
    FLAG                 done = FALSE,
                         ok;
    SLONG                wc,
                         we,
                         wa,
                         war;
    ULONG                theclass;
    UWORD                code,
                         qual;
    TEXT                 strength[1 + 1],
                         thestring[80 + 1];

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          HexHelpXPos,
        WA_Top,           HexHelpYPos,
        WA_InnerWidth,    HEXHELPXPIXEL,
        WA_InnerHeight,   HEXHELPYPIXEL,
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) LLL(MSG_HAIL_INFO, "Hex Information"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }

    tbwidth  = (int) InfoWindowPtr->BorderLeft;
    tbheight = (int) InfoWindowPtr->BorderTop;

    SetFont(InfoWindowPtr->RPort, FontPtr);
    SetAPen(InfoWindowPtr->RPort, remapit[LIGHTGREY]);
    RectFill(InfoWindowPtr->RPort, tbwidth + 2, tbheight + 2, tbwidth + HEXHELPXPIXEL - 4, tbheight + HEXHELPYPIXEL - 4);

    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_INCOUNTRY     , "In country:"     ), WHITE, tbwidth +  10, tbheight + 16);
    shadowtext(InfoWindowPtr->RPort,          a[hexowner[yhex][xhex]].name               , WHITE, tbwidth + 146, tbheight + 16);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_CONTROLLEDBY  , "Controlled by:"  ), WHITE, tbwidth +  10, tbheight + 26);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_CITY          , "City:"           ), WHITE, tbwidth +  10, tbheight + 36);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_ARMY2         , "Army:"           ), WHITE, tbwidth +  10, tbheight + 46);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_ATTACKSTRENGTH, "Attack strength:"), WHITE, tbwidth +  10, tbheight + 56);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_DEFENDSTRENGTH, "Defend strength:"), WHITE, tbwidth +  10, tbheight + 66);
    shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_GOVERNMENT    , "Government:"     ), WHITE, tbwidth +  10, tbheight + 76);

    ok = FALSE;
    strength[0] = '0';
    strength[1] = EOS;
    for (we = 0; we < players; we++)
    {   if (e[we].iu && e[we].iux == xhex && e[we].iuy == yhex)
        {   ok = TRUE;
            sprintf(thestring, LLL(MSG_WHOSEIU, "%s's IU"), e[we].name);
            if (we == USA || we == USSR)
            {   strength[0] = '2';
            } else
            {   strength[0] = '1';
    }   }   }
    if (!ok)
    {   for (wa = 0; wa < RAFRICANS; wa++)
        {   war = ourarmy(wa, xhex, yhex);
            if (war != -1)
            {   ok = TRUE;
                strcpy(thestring, a[wa].name);
                if (a[wa].is >= 7)
                {   strength[0] = '1';
                } else
                {   strength[0] = (TEXT) '½';
    }   }   }   }
    if (!ok)
    {   strcpy(thestring, LLL(MSG_NONE, "None"));
    }
    shadowtext(InfoWindowPtr->RPort, thestring, WHITE, tbwidth + 146, tbheight + 46);
    shadowtext(InfoWindowPtr->RPort, strength,  WHITE, tbwidth + 146, tbheight + 56);

    ok = FALSE;
    for (wc = 0; wc < CITIES; wc++)
    {   if (city[wc].x == xhex && city[wc].y == yhex)
        {   shadowtext(InfoWindowPtr->RPort, a[city[wc].aruler].name, WHITE, tbwidth + 146, tbheight + 26);
            sprintf
            (   thestring,
                "%s ($%d)",
                colonial ? city[wc].oname : city[wc].nname,
                (int) city[wc].worth
            );
            shadowtext(InfoWindowPtr->RPort, thestring,               WHITE, tbwidth + 146, tbheight + 36);
            ok = TRUE;
            break;
    }   }
    if (ok)
    {   if   (strength[0] == '2') strength[0] = '4';
        elif (strength[0] == '1') strength[0] = '2';
        elif (strength[0] == (TEXT) '½') strength[0] = '1'; // this cast is vital!
    } else
    {   if (whosehex(xhex, yhex) == -1)
        {   shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_VARIOUS, "Various"), WHITE, tbwidth + 146, tbheight + 26);
        } else
        {   shadowtext(InfoWindowPtr->RPort, a[whosehex(xhex, yhex)].name,         WHITE, tbwidth + 146, tbheight + 26);
        }
        shadowtext(InfoWindowPtr->RPort, (STRPTR) LLL(MSG_NONE, "None"),           WHITE, tbwidth + 146, tbheight + 36);
    }
    shadowtext(InfoWindowPtr->RPort, strength,                                     WHITE, tbwidth + 146, tbheight + 66);

    ok = FALSE;
    for (wa = 0; wa < RAFRICANS; wa++)
    {   war = ourarmy(wa, xhex, yhex);
        if
        (   war != -1
         && a[wa].govt != OTHER
         && govtx(wa) == xhex
         && govty(wa) == yhex
        )
        {   ok = TRUE;
            sprintf
            (   thestring,
                "%s %s",
                e[a[wa].eruler].adjective,
                (a[wa].govt == LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta")
            );
            break; // for speed
    }   }
    if (!ok)
    {   strcpy(thestring, LLL(MSG_NONE, "None"));
    }
    shadowtext(InfoWindowPtr->RPort, thestring, WHITE, tbwidth + 146, tbheight + 76);

    for (wa = 0; wa < RAFRICANS; wa++)
    {   for (war = 0; war < setup[wa].maxarmies; war++)
        {   if (a[wa].army[war].alive && a[wa].army[war].x == xhex && a[wa].army[war].y == yhex)
            {   shadowcounter_afro(InfoWindowPtr, HEXHELPXPIXEL - 10 - 21 + 1, tbheight + 10, wa, war);
                break; // for speed
    }   }   }
    for (we = 0; we < EUROPEANS; we++)
    {   if (e[we].iu && e[we].iux == xhex && e[we].iuy == yhex)
        {   shadowcounter_euro(InfoWindowPtr, HEXHELPXPIXEL - 10 - 21 + 1, tbheight + 10, we);
            break; // for speed
    }   }

    while (!done)
    {   if
        (   Wait
            (   (1 << InfoWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   HexHelpXPos = InfoWindowPtr->LeftEdge;
            HexHelpYPos = InfoWindowPtr->TopEdge;
            CloseWindow(InfoWindowPtr);
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GetMsg(InfoWindowPtr->UserPort)))
        {   theclass = MsgPtr->Class;
            code     = MsgPtr->Code;
            qual     = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            switch (theclass)
            {
            case IDCMP_CLOSEWINDOW:
            case IDCMP_MOUSEBUTTONS:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if (!(qual & IEQUALIFIER_REPEAT) && code < KEYUP && (code < FIRSTQUALIFIER || code > LASTQUALIFIER))
                {   if
                    (   code == SCAN_ESCAPE
                     && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    )
                    {   // HexHelpXPos = InfoWindowPtr->LeftEdge;
                        // HexHelpYPos = InfoWindowPtr->TopEdge;
                        CloseWindow(InfoWindowPtr);
                        cleanexit(EXIT_SUCCESS);
                    } elif (code != NM_WHEEL_UP && code != NM_WHEEL_DOWN)
                    {   done = TRUE;
    }   }   }   }   }

    HexHelpXPos = InfoWindowPtr->LeftEdge;
    HexHelpYPos = InfoWindowPtr->TopEdge;
    CloseWindow(InfoWindowPtr);

    clearkybd_gt(MainWindowPtr);
}

MODULE void border(SLONG we)
{   if (!customscreen)
    {   return;
    }

    switch (we)
    {
    case USA: // blue
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x44444444, 0x44444444, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0x66666666, 0x66666666, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0x88888888, 0x88888888, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0xAAAAAAAA, 0xAAAAAAAA, 0xFFFFFFFF);
    acase USSR: // red
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x99999999, 0x00000000, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0xBBBBBBBB, 0x22222222, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0xDDDDDDDD, 0x44444444, 0x44444444);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0xFFFFFFFF, 0x66666666, 0x66666666);
    acase CHINA: // green
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x00000000, 0x99999999, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0x22222222, 0xBBBBBBBB, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0x44444444, 0xDDDDDDDD, 0x44444444);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0x66666666, 0xFFFFFFFF, 0x66666666);
    acase FRANCE: // yellow
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x99999999, 0x99999999, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0xBBBBBBBB, 0xBBBBBBBB, 0x11111111);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0xDDDDDDDD, 0xDDDDDDDD, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0xFFFFFFFF, 0xFFFFFFFF, 0x33333333);
    acase UK: // purple
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x99999999, 0x00000000, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0xBBBBBBBB, 0x22222222, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0xDDDDDDDD, 0x44444444, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0xFFFFFFFF, 0x66666666, 0xFFFFFFFF);
    adefault:
        SetRGB32(&ScreenPtr->ViewPort,  28, 0x99999999, 0x99999999, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort,  29, 0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort,  61, 0xDDDDDDDD, 0xDDDDDDDD, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort,  62, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
    }

    drawborder(LEFTGAP - 8, TOPGAP - 8, LEFTGAP + SCREENXPIXEL - 1, TOPGAP + SCREENYPIXEL - 1); // needed for deep screens
}

MODULE void drawborder(WORD leftx, WORD topy, WORD rightx, WORD bottomy)
{   if (!customscreen)
    {   return;
    }

    // corners
    Corner.ImageData = CornerData[0];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        leftx + 1,
         topy + 1
    );
    Corner.ImageData = CornerData[1];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        rightx + 1,
          topy + 1
    );
    Corner.ImageData = CornerData[2];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
          leftx + 1,
        bottomy + 1
    );
    Corner.ImageData = CornerData[3];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
         rightx + 1,
        bottomy + 1
    );

    // darkest
    SetAPen(MainWindowPtr->RPort, 28);
/*  WritePixel(MainWindowPtr->RPort, leftx + 8, topy + 8);
    WritePixel(MainWindowPtr->RPort, rightx   , topy + 8);
    WritePixel(MainWindowPtr->RPort, leftx + 8, bottomy);
    WritePixel(MainWindowPtr->RPort, rightx   , bottomy); */
    // left
    Move(MainWindowPtr->RPort, leftx  + 1, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 1, bottomy    );
    Move(MainWindowPtr->RPort, leftx  + 7, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 7, bottomy    );
    // right
    Move(MainWindowPtr->RPort, rightx + 1, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 1, bottomy    );
    Move(MainWindowPtr->RPort, rightx + 7, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 7, bottomy    );
    // top
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 1);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 1);
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 7);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 7);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 1);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 1);
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 7);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 7);

    // nearly darkest
    SetAPen(MainWindowPtr->RPort, 29);
    // left
    Move(MainWindowPtr->RPort, leftx  + 2, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 2, bottomy    );
    Move(MainWindowPtr->RPort, leftx  + 6, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 6, bottomy    );
    // right
    Move(MainWindowPtr->RPort, rightx + 2, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 2, bottomy    );
    Move(MainWindowPtr->RPort, rightx + 6, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 6, bottomy    );
    // top
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 2);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 2);
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 6);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 6);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 2);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 2);
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 6);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 6);

    // nearly lightest
    SetAPen(MainWindowPtr->RPort, remapit[61]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 3, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 3, bottomy    );
    Move(MainWindowPtr->RPort, leftx  + 5, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 5, bottomy    );
    // right
    Move(MainWindowPtr->RPort, rightx + 3, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 3, bottomy    );
    Move(MainWindowPtr->RPort, rightx + 5, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 5, bottomy    );
    // top
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 3);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 3);
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 5);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 5);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 3);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 3);
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 5);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 5);

    // lightest
    SetAPen(MainWindowPtr->RPort, remapit[62]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 4, topy    + 8);
    Draw(MainWindowPtr->RPort, leftx  + 4, bottomy    );
    // right
    Move(MainWindowPtr->RPort, rightx + 4, topy    + 8);
    Draw(MainWindowPtr->RPort, rightx + 4, bottomy    );
    // top
    Move(MainWindowPtr->RPort, leftx  + 8, topy    + 4);
    Draw(MainWindowPtr->RPort, rightx    , topy    + 4);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 8, bottomy + 4);
    Draw(MainWindowPtr->RPort, rightx    , bottomy + 4);
}

MODULE void scoregraph(void)
{   struct IntuiMessage* MsgPtr;
    struct Window*       InfoWindowPtr;
    FLAG                 done    = FALSE;
    ULONG                theclass;
    UWORD                code,
                         qual;
    int                  firstturn,
                         i,
                         neededscore,
                         tbwidth,
                         tbheight;
    SLONG                we;

#define HISTX           4
#define HISTY           4
#define HISTWIDTH     351
#define HISTHEIGHT    200
#define HISTWINWIDTH  361
#define HISTWINHEIGHT 210

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (DisplayWidth  / 2) - (HISTWINWIDTH  / 2),
        WA_Top,           (DisplayHeight / 2) - (HISTWINHEIGHT / 2),
        WA_InnerWidth,    HISTWINWIDTH,
        WA_InnerHeight,   HISTWINHEIGHT,
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) LLL(MSG_HAIL_H_S_G, "Historical Score Graph"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }

    tbwidth  = InfoWindowPtr->BorderLeft;
    tbheight = InfoWindowPtr->BorderTop;

    SetFont(InfoWindowPtr->RPort, FontPtr);
    DrawBevelBox // bevel box for window client area
    (   InfoWindowPtr->RPort,
        tbwidth    + HISTX - 1,
        tbheight   + HISTY - 1,
        HISTWIDTH          + 3,
        HISTHEIGHT         + 3,
        GT_VisualInfo, (ULONG) VisualInfoPtr,
        GTBB_Recessed, TRUE,
    TAG_END);

    if (theround > 40)
    {   firstturn = theround - 40;
    } else
    {   firstturn = 0;
    }
    // lastturn = theround;

    DISCARD calcscores();

    // draw box
    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    RectFill(InfoWindowPtr->RPort, tbwidth + HISTX, tbheight + HISTY, tbwidth + HISTX + HISTWIDTH, tbheight + HISTY + HISTHEIGHT);
    for (i = 1; i <= 38; i++)
    {   SetAPen(InfoWindowPtr->RPort, remapit[i + firstturn == rounds ? WHITE : DARKGREY]);
        Move(InfoWindowPtr->RPort, tbwidth + HISTX + (i * 9), tbheight + HISTY             );
        Draw(InfoWindowPtr->RPort, tbwidth + HISTX + (i * 9), tbheight + HISTY + HISTHEIGHT);
    }
    neededscore = 120 / players;
    SetAPen(InfoWindowPtr->RPort, remapit[WHITE]);
    Move(InfoWindowPtr->RPort, tbwidth + HISTX            , tbheight + HISTY + HISTHEIGHT - (neededscore * 2));
    Draw(InfoWindowPtr->RPort, tbwidth + HISTX + HISTWIDTH, tbheight + HISTY + HISTHEIGHT - (neededscore * 2));

    // draw graph
    // up to 40 values (39 line segments) are displayed
    for (we = 0; we < players; we++)
    {   SetAPen(InfoWindowPtr->RPort, remapit[EUROCOLOUR + we]);
        Move(InfoWindowPtr->RPort, tbwidth + HISTX, tbheight + HISTY + HISTHEIGHT - score[we][firstturn]);

        for (i = 0; i < 39; i++)
        {   if (firstturn + i >= theround)
            {   break;
            }
            if (score[we][firstturn + i + 1] < 100)
            {   Draw
                (   InfoWindowPtr->RPort,
                    tbwidth + HISTX + ((i + 1) * 9),
                    tbheight + HISTY + HISTHEIGHT - (score[we][firstturn + i + 1] * 2)
                );
            } else
            {   Draw
                (   InfoWindowPtr->RPort,
                    tbwidth + HISTX + ((i + 1) * 9),
                    tbheight + HISTY
                );
    }   }   }

    while (!done)
    {   if
        (   Wait
            (   (1 << InfoWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   CloseWindow(InfoWindowPtr);
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GetMsg(InfoWindowPtr->UserPort)))
        {   theclass = MsgPtr->Class;
            code     = MsgPtr->Code;
            qual     = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            switch (theclass)
            {
            case IDCMP_CLOSEWINDOW:
            case IDCMP_MOUSEBUTTONS:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if (!(qual & IEQUALIFIER_REPEAT) && code < KEYUP && (code < FIRSTQUALIFIER || code > LASTQUALIFIER))
                {   if
                    (   code == SCAN_ESCAPE
                     && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    )
                    {   CloseWindow(InfoWindowPtr);
                        cleanexit(EXIT_SUCCESS);
                    } elif (code != NM_WHEEL_UP && code != NM_WHEEL_DOWN)
                    {   done = TRUE;
    }   }   }   }   }

    CloseWindow(InfoWindowPtr);

    clearkybd_gt(MainWindowPtr);
}

MODULE FLAG handlemenu(UWORD code, FLAG ingame)
{   FLAG             done = FALSE;
    struct MenuItem* ItemPtr;

    while (code != MENUNULL)
    {   ItemPtr = (struct MenuItem*) ItemAddress(MenuPtr, code);

        switch (MENUNUM(code))
        {
        case MN_PROJECT:
            switch (ITEMNUM(code))
            {
            case IN_NEW:
                if (ingame)
                {   globalrc = QUITTOTITLE;
                } else
                {   done = TRUE;
                }
            acase IN_OPEN:
                // assert(!ingame);
                if (loadgame(TRUE))
                {   done = TRUE;
                    loaded = TRUE;
                }
                if (morphos && customscreen)
                {   LoadRGB32(&(ScreenPtr->ViewPort), table1);
                    LoadRGB32(&(ScreenPtr->ViewPort), table2);
                    afrocolours();
                    setbarcolour(-1);
                }
            acase IN_SAVE: // -lint fallthrough
                // assert(ingame);
                savegame(FALSE, FALSE);
                if (morphos && customscreen)
                {   LoadRGB32(&(ScreenPtr->ViewPort), table1);
                    LoadRGB32(&(ScreenPtr->ViewPort), table2);
                    afrocolours();
                    setbarcolour(-1);
                }
            acase IN_SAVEAS:
                // assert(ingame);
                savegame(TRUE, FALSE);
                if (morphos && customscreen)
                {   LoadRGB32(&(ScreenPtr->ViewPort), table1);
                    LoadRGB32(&(ScreenPtr->ViewPort), table2);
                    afrocolours();
                    setbarcolour(-1);
                }
/*          acase IN_ICONIFY:
                iconify(); */
            acase IN_QUITTITLE:
                // assert(ingame);
                clearkybd_gt(MainWindowPtr);
                globalrc = QUITTOTITLE;
            acase IN_QUITDOS:
                cleanexit(EXIT_SUCCESS);
            }
        acase MN_SETTINGS:
            switch (ITEMNUM(code))
            {
            case IN_SHOW_TITLEBAR:
                if (ItemPtr->Flags & CHECKED)
                {   titlebar = TRUE;
                } else
                {   titlebar = FALSE;
                }
                if (morphos)
                {   ShowTitle(ScreenPtr, titlebar ? FALSE : TRUE );
                } else
                {   ShowTitle(ScreenPtr, titlebar ? TRUE  : FALSE);
                }
            acase IN_WATCH_AMIGA:
                watchamiga = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
            }
        acase MN_HELP:
            switch (ITEMNUM(code))
            {
            case IN_GAME_SUMMARY:
                // assert(ingame);
                declaredwars();
            acase IN_SCORE_GRAPH:
                // assert(ingame);
                scoregraph();
            acase IN_MANUAL:
                // assert(AmigaGuideBase);
                help_manual();
            acase IN_ABOUT:
                help_about();
        }   }
        code = ItemPtr->NextSelect;
    }

    return done;
}

MODULE void parsewb(void)
{   TRANSIENT       int                we;
    TRANSIENT       struct DiskObject* DiskObject;
    TRANSIENT       STRPTR*            ToolArray;
    TRANSIENT       STRPTR             s;
    PERSIST   const STRPTR             capseuroname[EUROPEANS] =
    { "USA",
      "USSR",
      "CHINA",
      "FRANCE",
      "UK"
    };

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        for (we = 0; we < EUROPEANS; we++)
        {   if ((s = (STRPTR) FindToolType(ToolArray, capseuroname[we])))
            {   if     (MatchToolValue(s, "HUMAN"))
                {   e[we].control = CONTROL_HUMAN;
                } elif (MatchToolValue(s, "AMIGA"))
                {   e[we].control = CONTROL_AMIGA;
        }   }   }
        if ((s = (STRPTR) FindToolType(ToolArray, "SCREENMODE")))
        {   screenmode = TRUE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "PUBSCREEN" )))
        {   strcpy(screenname, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "FILE"      )))
        {   strcpy(pathname, WBArg->wa_Name);
            cliload = TRUE;
        }

        FreeDiskObject(DiskObject);
}   }

EXPORT void remap(void)
{   int    colour,
           i, j, wa,
           wordwidth,
           x, xx, y;
    ULONG  red, green, blue;
    UWORD  thebit;
#ifdef DEBUGPENS
    UWORD* colour_table;
#endif

    About.ImageData    = AboutData;
    Logo.ImageData     = LogoData;
    MapImage.ImageData = MapData;

    if (customscreen)
    {   for (i = 0; i < 64; i++)
        {   remapit[i] = i;
        }

        for (i = 0; i < 5040; i++)
        {   LogoData[i] = OriginalLogoData[i];
        }
        Logo.Depth      = 4;
        Logo.PlanePick  = 0x0F;

        for (i = 0; i < 114 * ABOUTDEPTH; i++)
        {   AboutData[i] = OriginalAboutData[i];
        }
        About.Depth     = ABOUTDEPTH;
        About.PlanePick = ABOUTDEPTHMASK;

        for (i = 0; i < 2; i++)
        {   for (wa = 0; wa < EUROPEANS; wa++)
            {   for (j = 0; j < COUNTERHEIGHT * 2 * COUNTERDEPTH; j++)
                {   EuroData[i][wa][j] = OriginalEuroData[i][wa][j];
        }   }   }
        Counter.Depth        = COUNTERDEPTH;
        Counter.PlanePick    = 0x3F;

        for (i = 0; i < 71700; i++)
        {   MapData[i] = OriginalMapData[i];
        }
        MapImage.Depth       = 6;
        MapImage.PlanePick   = 0x3F;
    } else
    {
#ifdef DEBUGPENS
        colour_table = (UWORD*) ScreenPtr->ViewPort.ColorMap->ColorTable;
        for (i = 0; i <= 255; i++)
        {   hostred[i]   = (colour_table[i] & 0xF00) >> 8;
            hostgreen[i] = (colour_table[i] & 0x0F0) >> 4;
            hostblue[i]  =  colour_table[i] & 0x00F      ;
         // printf("Host pen #%d: RGB is %X%X%X!\n", i, hostred[i], hostgreen[i], hostblue[i]);
        }
#endif

        for (i = 32; i <= 59; i++) // 28 pens
        {   red   =  table2[1 + ((i - 20) * 3)];
            green =  table2[2 + ((i - 20) * 3)];
            blue  =  table2[3 + ((i - 20) * 3)];

            allocpen(i, red, green, blue, TRUE);
        }

        for (i = 0; i <= 16; i++) // 17 pens
        {   red   =  table1[1 + (i * 3)];
            green =  table1[2 + (i * 3)];
            blue  =  table1[3 + (i * 3)];

            allocpen(i, red, green, blue, FALSE);
        }

        for (i = 20; i <= 27; i++) // 8 pens
        {   red   =  table2[1 + ((i - 20) * 3)];
            green =  table2[2 + ((i - 20) * 3)];
            blue  =  table2[3 + ((i - 20) * 3)];

            allocpen(i, red, green, blue, FALSE);
    }   }

    wordwidth = 21 / 16;
    if (21 % 16) wordwidth++;
    for (i = 0; i < 6; i++)
    {   for (wa = 0; wa < RAFRICANS; wa++)
        {   for (y = 0; y < COUNTERHEIGHT; y++)
            {   for (x = 0; x < wordwidth; x++)
                {   for (xx = 0; xx <= ((x == 0) ? 15 : 4); xx++)
                    {   // get the colour of this pixel
                        colour = 0;
#ifdef __AROS__
                        thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                        thebit = 32768 >> xx;
#endif
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 0) + y) * wordwidth) + x] &  thebit) colour++;
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                        if (      OriginalAfroData[i][wa][(((COUNTERHEIGHT * 5) + y) * wordwidth) + x] &  thebit) colour += 32;

                        if   (colour == 60                 ) colour = DARKGREEN;
                        elif (colour == 31 && !customscreen) colour = WHITE;
                     /* elif (colour == 30) colour = LIGHTGREY; not used by any counters */

                        // now remap it
                        colour = remapit[colour];

                        // and set it
                        if (colour &   1) AfroData[i][wa][(((COUNTERHEIGHT * 0) + y) * wordwidth) + x] |= thebit;
                        if (colour &   2) AfroData[i][wa][(((COUNTERHEIGHT * 1) + y) * wordwidth) + x] |= thebit;
                        if (colour &   4) AfroData[i][wa][(((COUNTERHEIGHT * 2) + y) * wordwidth) + x] |= thebit;
                        if (colour &   8) AfroData[i][wa][(((COUNTERHEIGHT * 3) + y) * wordwidth) + x] |= thebit;
                        if (colour &  16) AfroData[i][wa][(((COUNTERHEIGHT * 4) + y) * wordwidth) + x] |= thebit;
                        if (colour &  32) AfroData[i][wa][(((COUNTERHEIGHT * 5) + y) * wordwidth) + x] |= thebit;
                        if (!customscreen) // for speed
                        {   if (colour &  64) AfroData[i][wa][(((COUNTERHEIGHT * 6) + y) * wordwidth) + x] |= thebit;
                            if (colour & 128) AfroData[i][wa][(((COUNTERHEIGHT * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }   }   }   }

    if (customscreen)
    {   return;
    }

    for (i = 0; i < 2; i++)
    {   for (wa = 0; wa < EUROPEANS; wa++)
        {   for (y = 0; y < COUNTERHEIGHT; y++)
            {   for (x = 0; x < wordwidth; x++)
                {   for (xx = 0; xx <= ((x == 0) ? 15 : 4); xx++)
                    {   // get the colour of this pixel
                        colour = 0;
#ifdef __AROS__
                        thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                        thebit = 32768 >> xx;
#endif
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 0) + y) * wordwidth) + x] &  thebit) colour++;
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                        if (      OriginalEuroData[i][wa][(((COUNTERHEIGHT * 5) + y) * wordwidth) + x] &  thebit) colour += 32;

                        if   (colour == 31) colour = WHITE;
                     /* elif (colour == 60) colour = DARKGREEN; not used by European counters
                        elif (colour == 30) colour = LIGHTGREY; not used by any counters */

                        // now remap it
                        colour = remapit[colour];

                        // and set it
                        if (colour &   1) EuroData[i][wa][(((COUNTERHEIGHT * 0) + y) * wordwidth) + x] |= thebit;
                        if (colour &   2) EuroData[i][wa][(((COUNTERHEIGHT * 1) + y) * wordwidth) + x] |= thebit;
                        if (colour &   4) EuroData[i][wa][(((COUNTERHEIGHT * 2) + y) * wordwidth) + x] |= thebit;
                        if (colour &   8) EuroData[i][wa][(((COUNTERHEIGHT * 3) + y) * wordwidth) + x] |= thebit;
                        if (colour &  16) EuroData[i][wa][(((COUNTERHEIGHT * 4) + y) * wordwidth) + x] |= thebit;
                        if (colour &  32) EuroData[i][wa][(((COUNTERHEIGHT * 5) + y) * wordwidth) + x] |= thebit;
                        if (colour &  64) EuroData[i][wa][(((COUNTERHEIGHT * 6) + y) * wordwidth) + x] |= thebit;
                        if (colour & 128) EuroData[i][wa][(((COUNTERHEIGHT * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }   }   }

    wordwidth = 391 / 16;
    if (391 % 16) wordwidth++;
    for (y = 0; y < 478; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalMapData[(((478 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalMapData[(((478 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalMapData[(((478 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                if (      OriginalMapData[(((478 * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                if (      OriginalMapData[(((478 * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                if (      OriginalMapData[(((478 * 5) + y) * wordwidth) + x] &  thebit) colour += 32;

                if     (colour == 30) // poor city
                {   colour = LIGHTGREY;
                } elif (colour == 31) // rich city
                {   colour = WHITE;
                }

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) MapData[(((478 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) MapData[(((478 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) MapData[(((478 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) MapData[(((478 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) MapData[(((478 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) MapData[(((478 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) MapData[(((478 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) MapData[(((478 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }

    wordwidth = 44 / 16;
    if (44 % 16) wordwidth++;
    for (y = 0; y < 38; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalAboutData[(((38 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalAboutData[(((38 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalAboutData[(((38 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                if (      OriginalAboutData[(((38 * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                if (      OriginalAboutData[(((38 * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                if (      OriginalAboutData[(((38 * 5) + y) * wordwidth) + x] &  thebit) colour += 32;

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) AboutData[(((38 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) AboutData[(((38 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) AboutData[(((38 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) AboutData[(((38 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) AboutData[(((38 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) AboutData[(((38 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) AboutData[(((38 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) AboutData[(((38 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }

    wordwidth = 218 / 16;
    if (218 % 16) wordwidth++;
    for (y = 0; y < 90; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalLogoData[(((90 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalLogoData[(((90 * 1) + y) * wordwidth) + x] &  thebit) colour += 2;
                if (      OriginalLogoData[(((90 * 2) + y) * wordwidth) + x] &  thebit) colour += 4;
                if (      OriginalLogoData[(((90 * 3) + y) * wordwidth) + x] &  thebit) colour += 8;

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) LogoData[(((90 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) LogoData[(((90 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) LogoData[(((90 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) LogoData[(((90 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) LogoData[(((90 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) LogoData[(((90 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) LogoData[(((90 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) LogoData[(((90 * 7) + y) * wordwidth) + x] |= thebit;
}   }   }   }

EXPORT void allocpen(int whichpen, ULONG red, ULONG green, ULONG blue, FLAG exclusive)
{   LONG  result;
#ifdef DEBUGPENS
    UBYTE nybblered, nybblegreen, nybbleblue;
 
    nybblered   = (red   & 0xF0000000) >> 28;
    nybblegreen = (green & 0xF0000000) >> 28;
    nybbleblue  = (blue  & 0xF0000000) >> 28;
#endif

    if (exclusive)
    {   result = ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            -1,
            red,
            green,
            blue,
            PEN_EXCLUSIVE
        );
        if (result == -1) // failed
        {   remapit[whichpen] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                0x88888888,
                0x88888888,
                0x88888888,
                -1
            );
#ifdef DEBUGPENS
            printf
            (   "NO:  Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
                whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]
            );
#endif
        } else
        {   gotpen[whichpen] = TRUE;
            remapit[whichpen] = result;
#ifdef DEBUGPENS
            printf
            (   "YES: Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
                whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]
            );
            printf
            (   "Setting host colour %3d to %X%X%X\n",
                remapit[whichpen], nybblered, nybblegreen, nybbleblue
            );
#endif
         /* SetRGB4
            (   &ScreenPtr->ViewPort,
                remapit[whichpen],
                nybblered,
                nybblegreen,
                nybbleblue
            ); not needed */
    }   }
    else
    {   result = ObtainBestPen
        (   ScreenPtr->ViewPort.ColorMap,
            red,
            green,
            blue,
            OBP_Precision, PRECISION_IMAGE,
        TAG_DONE);
        if (result == -1)
        {   remapit[whichpen] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                red,
                green,
                blue,
                -1
            );
#ifdef DEBUGPENS
            printf
            (   "No:  Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
                whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]
            );
#endif
        } else
        {   gotpen[whichpen] = TRUE;
            remapit[whichpen] = result;
#ifdef DEBUGPENS
            printf
            (   "Yes: Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
                whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]
            );
            printf
            (   "Setting host colour %3d to %X%X%X\n",
                remapit[whichpen], nybblered, nybblegreen, nybbleblue
            );
#endif
}   }   }
