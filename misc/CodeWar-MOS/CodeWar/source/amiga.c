// INCLUDES --------------------------------------------------------------

#if defined(_lint) || defined(__VBCC__)
    #define AMIGA
#endif
#define __USE_OLD_TIMEVAL__

#include <exec/types.h>
#include <exec/execbase.h>
#include <exec/resident.h>
#include <dos/dostags.h>
#include <dos/dosextens.h>
#ifdef __amigaos4__
    #include <dos/obsolete.h>          // CurrentDir()
#endif
#include <graphics/gfxbase.h>
#include <intuition/intuition.h>
#include <intuition/icclass.h>
#define ASL_PRE_V38_NAMES
#include <libraries/asl.h>
#include <libraries/amigaguide.h>
#include <libraries/gadtools.h>
#ifdef __amigaos4__
    #include <intuition/menuclass.h>
    #include <libraries/application.h>
#endif
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#include <workbench/startup.h>
#include <devices/audio.h>
#include <devices/timer.h>

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include <proto/amigaguide.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <proto/asl.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/gadtools.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/timer.h>
#include <proto/wb.h>
#include <clib/alib_protos.h>

#include "amiga.h"
#include "cw.h"
#include "codewar.h"

#ifndef __MORPHOS__
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
        #include <proto/openurl.h>
        #include <libraries/openurl.h>
    #endif
#endif

// DEFINES----------------------------------------------------------------

// #define TESTJUMP
/* enables an additional CLI argument: JUMPSCREEN=<address>, where
<address> is in hexadecimal format and gives the address of a public
screen to which you want the program to jump when the J key is pressed.
(For testing of OS4 screen jumping functionality under OS3/MOS. */

#define FIRSTINITIMAGE      2
#define LASTINITIMAGE      33
#define OS4IMAGES           5

#define AddSeparator MA_AddChild, MSeparator, MEnd

#define ARGPOS_ATOMICS      0
#define ARGPOS_BOMBS        1
#define ARGPOS_BOUNDARY     2
#define ARGPOS_CANNONS      3
#define ARGPOS_DAMAGE       4
#define ARGPOS_ENERGY       5
#define ARGPOS_FORCE        6
#define ARGPOS_GFXWIDTH     7
#define ARGPOS_GFXHEIGHT    8
#define ARGPOS_INTERVAL     9
#define ARGPOS_MASS        10
#define ARGPOS_MISSILES    11
#define ARGPOS_PRI         12
#define ARGPOS_PUBSCREEN   13
#define ARGPOS_SHIELDS     14
#define ARGPOS_SOUND       15
#define ARGPOS_TURBO       16
#define ARGPOS_WORLDWIDTH  17
#define ARGPOS_WORLDHEIGHT 18
#define ARGPOS_ROBOT1      19
#define ARGPOS_ROBOT2      20
#define ARGPOS_ROBOT3      21
#define ARGPOS_ROBOT4      22
#define ARGPOS_ROBOT5      23
#define ARGPOS_ROBOT6      24
#define ARGPOS_ROBOT7      25
#define ARGPOS_ROBOT8      26
#ifdef TESTJUMP
    #define ARGPOS_JUMPSCREEN 27
    #define ARGUMENTS         28 // counting from 1
#else
    #define ARGUMENTS         27 // counting from 1
#endif

#define MN_PROJECT          0
#define MN_TOOLS            1
#define MN_SETTINGS         2
#define MN_HELP             3

// Project menu
#define IN_OPEN             0
// ---                      1
#define IN_ICONIFY          2
#define IN_QUIT             3

// Tools menu
#define IN_ENERGIZE         0
#define IN_HEAL             1
#define IN_REARM            2
#define IN_REPOSITION       3

// Settings menu
#define IN_PAUSED           0
#define IN_TURBO            1
#define IN_SPEED            2
// ---                      3
#define IN_SOUND            4
// ---                      5
#define IN_STARFIELD        6

// Help menu
#define IN_MANUAL           0
// ---                      1
#define IN_ABOUT            2

#define BITMAP_AMIGAN       0
#define BITMAP_LOGO         1
#define BITMAP_ATOMIC       2 // FIRSTINITIMAGE
#define BITMAP_BOMB         3
#define BITMAP_CANNON       4
#define BITMAP_MISSILE      5
#define BITMAPS            34

#define STARDENSITY 256
// lower numbers mean denser stars (there is 1 star per STARDENSITY pixels)

#define CONFIGLENGTH        6

#ifdef __MORPHOS__
    #include <intuition/extensions.h>
#else
    #define WA_ExtraGadget_Iconify (WA_Dummy + 153)
    #define WA_SkinInfo            (WA_Dummy + 159)
    #define ETI_Dummy              (0xFFD0)
    #define ETI_Iconify            (ETI_Dummy)
#endif

#ifndef WINDOW_PopupGadget
    #define WINDOW_PopupGadget     (WINDOW_Dummy + 60)
#endif
#ifndef WINDOW_JumpScreensMenu
    #define WINDOW_JumpScreensMenu (WINDOW_Dummy + 63)
#endif
#ifndef WMHI_JUMPSCREEN
    #define WMHI_JUMPSCREEN        (18L<<16)
#endif

#define AddInteger(x)              LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_ReadOnly, TRUE, INTEGER_Arrows, FALSE, INTEGER_MinVisible, 3, IntegerEnd
#define AddHLayout                 LAYOUT_AddChild, HLayoutObject
#define AddVLayout                 LAYOUT_AddChild, VLayoutObject
#define AddLabel(x)                LAYOUT_AddImage, LabelObject, LABEL_Text, x, LabelEnd
#define AddSpace                   LAYOUT_AddChild, SpaceObject, SpaceEnd

#define CHANNELS          4 // this how many simultaneous sound effects we
                            // support; if we exceed this, the oldest
                            // sound is aborted to make room for the
                            // newest sound.
#define ID_8SVX           MAKE_ID('8','S','V','X')
#define ID_BODY           MAKE_ID('B','O','D','Y')
#define ID_VHDR           MAKE_ID('V','H','D','R')
#define PALCLOCK    3546895
#define NTSCCLOCK   3579545

typedef LONG IFFFixed;       /* A fixed-point value, 16 bits to the left
                                of the point and 16 to the right. A Fixed
                                is a number of 2**16ths, ie. 65536ths. */
typedef struct
{      ULONG oneShotHiSamples,  /* # samples in the high octave 1-shot part */
             repeatHiSamples,   /* # samples in the high octave repeat part */
             samplesPerHiCycle; /* # samples/cycle in high octave, else 0 */
       UWORD samplesPerSec;     /* data sampling rate */
       UBYTE ctOctave,          /* # of octaves of waveforms */
             sCompression;      /* data compression technique used */
    IFFFixed volume;            /* playback nominal volume from 0 to Unity
                                (full volume). Map this value into the
                                output hardware's dynamic range (0-64). */
} Voice8Header;

EXPORT struct Chunk // can't be MODULE for MorphOS reasons
{   LONG          ckID;
    LONG          ckSize;
    LONG          ckType;
    void*         ckData;
    struct Chunk* ckNext;
};

MODULE struct
{   ULONG  length[2], size, speed, bank;
    UBYTE* base;
} samp[SAMPLES + 1];

// EXPORTED VARIABLES-----------------------------------------------------

EXPORT LONG                     pens[PENS];
EXPORT struct CodeWarSglMsg*    SglMsgPtr;
EXPORT struct CodeWarDblMsg*    DblMsgPtr;
// EXPORT struct ExecBase*      TheExecBase     = NULL;
EXPORT struct GfxBase*          GfxBase         = NULL;
EXPORT struct IntuitionBase*    IntuitionBase   = NULL;
EXPORT struct Library          *AmigaGuideBase  = NULL,
                               *AslBase         = NULL,
                               *BitMapBase      = NULL,
                               *ButtonBase      = NULL,
                               *ClickTabBase    = NULL,
                               *FuelGaugeBase   = NULL,
                               *GadToolsBase    = NULL,
                               *IconBase        = NULL,
                               *IntegerBase     = NULL,
                               *LabelBase       = NULL,
                               *LayoutBase      = NULL,
                               *OpenURLBase     = NULL,
                               *SliderBase      = NULL,
                               *SpaceBase       = NULL,
                               *StringBase      = NULL,
                               *WindowBase      = NULL,
                               *WorkbenchBase   = NULL;
#ifdef __amigaos4__
EXPORT struct Library*          ApplicationBase = NULL;

EXPORT struct AmigaGuideIFace*  IAmigaGuide     = NULL;
EXPORT struct ApplicationIFace* IApplication    = NULL;
EXPORT struct AslIFace*         IAsl            = NULL;
EXPORT struct BitMapIFace*      IBitMap         = NULL;
EXPORT struct ButtonIFace*      IButton         = NULL;
EXPORT struct ClickTabIFace*    IClickTab       = NULL;
EXPORT struct FuelGaugeIFace*   IFuelGauge      = NULL;
EXPORT struct GadToolsIFace*    IGadTools       = NULL;
EXPORT struct GraphicsIFace*    IGraphics       = NULL;
EXPORT struct IconIFace*        IIcon           = NULL;
EXPORT struct IntegerIFace*     IInteger        = NULL;
EXPORT struct IntuitionIFace*   IIntuition      = NULL;
EXPORT struct LabelIFace*       ILabel          = NULL;
EXPORT struct LayoutIFace*      ILayout         = NULL;
EXPORT struct OpenURLIFace*     IOpenURL        = NULL;
EXPORT struct SliderIFace*      ISlider         = NULL;
EXPORT struct SpaceIFace*       ISpace          = NULL;
EXPORT struct StringIFace*      IString         = NULL;
EXPORT struct TimerIFace*       ITimer          = NULL;
EXPORT struct WindowIFace*      IWindow         = NULL;
EXPORT struct WorkbenchIFace*   IWorkbench      = NULL;
#endif

#if defined(__GNUC__) && !defined(__amigaos4__)
    EXPORT struct Library*     TimerBase       = NULL;
#else
    EXPORT struct Device*      TimerBase       = NULL;
#endif

// IMPORTED VARIABLES-----------------------------------------------------

IMPORT FLAG                  hangon,
                             keydown[ROBOTS],
                             paused,
                             show_stars,
                             sound,
                             turbo;
IMPORT TEXT                  globalstring[ROBOTS][256 + 1],
                             output_buffer[256 + 1];
IMPORT UBYTE                *BodyPtr[ROBOTS],
                            *display,
                            *stars;
IMPORT ULONG                 animframe;
IMPORT int                   damage_max,
                             dft_atomics,
                             dft_bombs,
                             dft_cannons,
                             dft_energy,
                             dft_force,
                             dft_mass,
                             dft_missiles,
                             dft_shields,
                             interval,
                             speedup,
                             wall_type;
IMPORT const int             speedupnum[SPEED_MAX - SPEED_MIN + 1];
IMPORT Config                config;
IMPORT game_window           battle;
IMPORT Player                player[ROBOTS];

#ifdef __SASC
    IMPORT struct ExecBase* SysBase;
#endif

// MODULE VARIABLES-------------------------------------------------------

MODULE int                   xoffset,
                             yoffset;
MODULE FLAG                  AudioClosed     = TRUE,
                             eversent[4],
                             gotpen[PENS],
                             guideexists     = FALSE,
                             os4menus        = FALSE,
                             pending         = FALSE,
                             reopen_about    = FALSE,
                             reopen_speed    = FALSE,
                             soundopen       = FALSE,
                             urlopen         = FALSE;
MODULE UWORD                 wbver,
                             wbrev;
MODULE SBYTE                 OldPri          = 0;
MODULE TEXT                  fn_emu[MAX_PATH + 1],
                             fn_robot[ROBOTS][MAX_PATH + 1],
                             screenname[MAXPUBSCREENNAME + 1],
                             speedtitle[12 + 1]; // enough for "Speed (800%)"
MODULE SLONG                 args[ARGUMENTS + 1];
MODULE ULONG                 AboutSignal     = 0,
                             AppSignal,
                             AppLibSignal    = 0,
                             functab         = 0,
                             MainSignal,
                             morphos         = FALSE,
                             lame            = FALSE,
                             receipter[4]    = {(ULONG) -1, (ULONG) -1, (ULONG) -1, (ULONG) -1},
                             SpeedSignal     = 0;
MODULE UBYTE                 ConfigBuffer[CONFIGLENGTH];
MODULE BYTE                  TimerClosed     = ~0;
MODULE BPTR                  ProgLock        = ZERO;
MODULE struct List           ClickTabsList;
MODULE struct RastPort       wpa8rastport;
MODULE struct DiskObject*    IconifiedIcon;
MODULE struct BitMap*        wpa8bitmap      = NULL;
MODULE struct Gadget*        gadgets[GIDS + 1];
MODULE struct IOAudio*       AudioRqPtr[4]   = { NULL, NULL, NULL, NULL };
MODULE struct Menu*          MenuPtr         = NULL;
MODULE struct Process*       ProcessPtr      = NULL;
MODULE struct RDArgs*        ArgsPtr         = NULL;
MODULE struct timerequest*   TimerIO         = NULL;
MODULE struct VisualInfo*    VisualInfoPtr   = NULL;
MODULE struct FileRequester* ASLRqPtr        = NULL;
MODULE struct WBArg*         WBArg           = NULL;
MODULE struct WBStartup*     WBMsg           = NULL;
MODULE Object               *AboutWinObject  = NULL,
                            *image[BITMAPS],
                            *SpeedWinObject  = NULL,
                            *SplashWinObject = NULL,
                            *WinObject       = NULL; // note that WindowObject is a reserved macro
MODULE struct MsgPort       *AppPort         = NULL,
                            *AudioPortPtr[4] = { NULL, NULL, NULL, NULL },
                            *PublicPort      = NULL,
                            *ReplyPortPtr[ROBOTS];
MODULE struct Screen        *newscr,
                            *ScreenPtr       = NULL;
MODULE struct Window        *AboutWindowPtr  = NULL,
                            *MainWindowPtr   = NULL,
                            *SpeedWindowPtr  = NULL,
                            *SplashWindowPtr = NULL;
#if defined(__SASC) || defined(__GNUC__)
    MODULE struct Library*  VersionBase;
#endif
#ifdef __amigaos4__
    MODULE LONG              menuimagesize  = 16; // overridden by user's MenuImageSize environment variable
    MODULE ULONG             AppID           = 0; // not NULL!
    MODULE struct MsgPort*   AppLibPort      = NULL;
    MODULE struct Image*     menuimage[OS4IMAGES]; // they go from 0..OS4IMAGES-1
#endif
#ifdef TESTJUMP
    MODULE struct Screen*    futurejump     = NULL;
#endif

MODULE struct EasyStruct EasyStruct =
{   sizeof(struct EasyStruct),
    0,
    NULL,
    NULL,
    NULL,
#ifdef __amigaos4__
    NULL,
    NULL,
#endif
};

MODULE const STRPTR PageOptionsOS3[2] =
{   "1-4",
    "5-8"
    // no NULL is required
}, PageOptionsOS4[4] =
{   "1-2",
    "3-4",
    "5-6",
    "7-8"
    // no NULL is required
}, imagename[BITMAPS] =
{   "amigan",       //  0
    "logo",         //  1
    "atomic",       //  2
    "bomb",         //  3
    "cannon",       //  4
    "missile",      //  5
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile",
    "atomic",
    "bomb",
    "cannon",
    "missile"
}, RobotName[ROBOTS] =
{   "Robot #1 (blue)",
    "Robot #2 (red)",
    "Robot #3 (green)",
    "Robot #4 (yellow)",
    "Robot #5 (orange)",
    "Robot #6 (purple)",
    "Robot #7 (cyan)",
    "Robot #8 (pink)"
};
/* MODULE struct TagItem CTtoPAmap[] = {
{ CLICKTAB_Current, PAGE_Current     },
{ TAG_END,          0                }
}, PAtoCTmap[] = {
{ PAGE_Current,     CLICKTAB_Current },
{ TAG_END,          0                }
}; */

// this is required as GCC optimizes out any if (0) statement;
// as a result the version embedding was not working correctly.
USED const STRPTR verstag = VERSION;

#define INDEX_PAUSED    10
#define INDEX_TURBO     11
#define INDEX_SOUND     14
#define INDEX_STARFIELD 16
MODULE struct NewMenu NewMenu[] =
{   { NM_TITLE, "Project",                  0 , 0,                    0, 0}, //  0
    {  NM_ITEM, "Open...",                 "O", 0,                    0, 0},
    {  NM_ITEM, NM_BARLABEL,                0 , 0,                    0, 0},
    {  NM_ITEM, "Iconify",                 "I", 0,                    0, 0},
    {  NM_ITEM, "Quit CodeWar",            "Q", 0,                    0, 0}, //  4
    { NM_TITLE, "Tools",                    0 , 0,                    0, 0},
    {  NM_ITEM, "Energize (E)",             0 , 0,                    0, 0},
    {  NM_ITEM, "Heal (H)",                 0 , 0,                    0, 0},
    {  NM_ITEM, "Rearm (A)",                0 , 0,                    0, 0},
    {  NM_ITEM, "Reposition (R)",           0 , 0,                    0, 0},
    { NM_TITLE, "Settings",                 0 , 0,                    0, 0}, //  9
    {  NM_ITEM, "Paused? (P)",              0 , CHECKIT | MENUTOGGLE, 0, 0}, // 10 (INDEX_PAUSED)
    {  NM_ITEM, "Turbo? (T)",              "T", CHECKIT | MENUTOGGLE, 0, 0}, // 11 (INDEX_TURBO)
    {  NM_ITEM, "Speed...",                 0 , 0,                    0, 0}, // 12
    {  NM_ITEM, NM_BARLABEL,                0 , 0,                    0, 0}, // 13
    {  NM_ITEM, "Sound? (S)",              "U", CHECKIT | MENUTOGGLE, 0, 0}, // 14 (INDEX_SOUND)
    {  NM_ITEM, NM_BARLABEL,                0 , 0,                    0, 0}, // 15
    {  NM_ITEM, "Starfield? (B)",           0 , CHECKIT | MENUTOGGLE, 0, 0}, // 16 (INDEX_STARFIELD)
    { NM_TITLE, "Help",                     0 , 0,                    0, 0}, // 17
    {  NM_ITEM, "Manual...",               "M", NM_ITEMDISABLED,      0, 0}, // 18
    {  NM_ITEM, NM_BARLABEL,                0 , 0,                    0, 0}, // 19
    {  NM_ITEM, "About CodeWar...",        "?", 0,                    0, 0}, // 20
    {   NM_END, NULL,                       0 , 0,                    0, 0}  // 21
};

// MODULE FUNCTIONS-------------------------------------------------------

MODULE void cleanexit(int rc);
MODULE void clearmsgs(void);
// MODULE BOOL ClickTabNodes(struct List *list, UBYTE **labels);
MODULE void ct_makelist(struct List* ListPtr, const STRPTR* NamesArray, int elements);
MODULE void ct_clearlist(struct List* ListPtr);
MODULE void destroy_buffer(void);
MODULE void disable(int gid);
MODULE LONG easyrequest(void);
MODULE void enable(int gid);
MODULE void freefx(void);
MODULE void freepens(void);
MODULE void getpens(void);
MODULE void graphics_setup_display(void);
MODULE void handlemsgs(void);
MODULE void iconify(void);
MODULE FLAG load_robot(STRPTR pathname);
MODULE void load_samples(void);
MODULE void lockscreen(void);
MODULE void make_buffer(void);
MODULE void make_os3pagegad(int whichpage);
MODULE void make_os4pagegad(int whichpage);
MODULE void make_robotgads(void);
MODULE void make_stars(void);
MODULE void printusage(STRPTR progname);
MODULE int register_program(struct Task* processid);
MODULE ULONG thetime(void);
MODULE void uniconify(void);
MODULE void unlockscreen(void);
MODULE void handlemenus(UWORD code);
MODULE void help_manual(void);
MODULE void load_images(int thefirst, int thelast, FLAG splashing);
MODULE void help_about(void);
MODULE void about_loop(void);
MODULE void close_about(void);
MODULE void openurl(STRPTR command);
MODULE FLAG Exists(STRPTR name);
MODULE void rethinkrobots(void);
MODULE void loadconfig(void);
MODULE void saveconfig(void);
MODULE void file_open(void);
MODULE void open_speed(void);
MODULE void close_speed(void);
MODULE void speed_loop(void);
#ifdef __amigaos4__
    MODULE void load_menuimages(void);
#endif
MODULE void say(STRPTR text);

// CODE-------------------------------------------------------------------

EXPORT int main(int argc, char** argv)
{   int   i,
          number;
    FLAG  changepri = FALSE;
    SBYTE NewPri    = 0;
#ifdef __amigaos4__
    TEXT  envbuffer[13 + 1];
#endif

    /* seed random numbers */
    srand(time(NULL) % RAND_MAX);

    engine_setup();

    screenname[0]          = EOS;
    for (i = 0; i < ROBOTS; i++)
    {   fn_robot[i][0]     = EOS;
        BodyPtr[i]         = NULL;
        keydown[i]         = FALSE;
    }
    for (i = 0; i <= ARGUMENTS; i++)
    {   args[i]            = 0;
    }
    for (i = 0; i < PENS; i++)
    {   gotpen[i]          = FALSE;
    }
    for (i = 0; i < BITMAPS; i++)
    {   image[i]           = NULL;
    }
#ifdef __amigaos4
    for (i = 0; i < OS4IMAGES; i++)
    {   menuimage[i] = NULL;
    }
#endif
    NewList(&ClickTabsList);

    ProcessPtr = (struct Process*) FindTask(NULL);
    // TheExecBase = (struct ExecBase*) &(SysBase->LibNode);

    if     (!(VersionBase     = (struct Library*) OpenLibrary("version.library",         OS_39)))
    {   printf("Need OS3.9+BB1!");
        cleanexit(EXIT_FAILURE);
    } elif (!(AslBase         = OpenLibrary("asl.library",                               OS_21)))
    {   printf("Can't open asl.library V38+!");
        cleanexit(EXIT_FAILURE);
    } elif (!(GadToolsBase    = OpenLibrary("gadtools.library",                          OS_21)))
    {   printf("Can't open gadtools.library V38+!");
        cleanexit(EXIT_FAILURE);
    } elif (!(GfxBase         = (struct GfxBase*) OpenLibrary("graphics.library",        OS_31)))
    {   printf("Can't open graphics.library V40+!");
        cleanexit(EXIT_FAILURE);
    } elif (!(IconBase        = OpenLibrary("icon.library",                              OS_32)))
    {   printf("Can't open icon.library V41+!");
        cleanexit(EXIT_FAILURE);
    } elif (!(IntuitionBase   = (struct IntuitionBase*) OpenLibrary("intuition.library", OS_31)))
    {   printf("Can't open intuition.library V40+!");
        cleanexit(EXIT_FAILURE);
    } elif (!(BitMapBase      = OpenLibrary("images/bitmap.image",         OS_35 )))
    {   printf("Need bitmap.image V44+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(ButtonBase      = OpenLibrary("gadgets/button.gadget",       OS_ANY)))
    {   printf("Need button.gadget!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(ClickTabBase    = OpenLibrary("gadgets/clicktab.gadget",     42    )))
    {   printf("Need clicktab.gadget V42+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(FuelGaugeBase   = OpenLibrary("gadgets/fuelgauge.gadget",    OS_ANY)))
    {   printf("Need fuelgauge.gadget!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(IntegerBase     = OpenLibrary("gadgets/integer.gadget",      OS_35 )))
    {   printf("Need integer.gadget V44+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(LabelBase       = OpenLibrary("images/label.image",          OS_35 )))
    {   printf("Need label.image V44+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(LayoutBase      = OpenLibrary("gadgets/layout.gadget",       OS_35 )))
    {   printf("Need layout.gadget V44+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(SliderBase      = OpenLibrary("gadgets/slider.gadget",       OS_ANY)))
    {   printf("Need slider.gadget!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(SpaceBase       = OpenLibrary("gadgets/space.gadget",        OS_35 )))
    {   printf("Need space.gadget V44+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(StringBase      = OpenLibrary("gadgets/string.gadget",       OS_39 )))
    {   printf("Need string.gadget V45+!\n");
        cleanexit(EXIT_FAILURE);
    } elif (!(WindowBase      = OpenLibrary("window.class",                OS_31 )))
    {   printf("Need window.class V39+!\n");
        cleanexit(EXIT_FAILURE);
        // window.class requires layout.gadget!
    } elif (!(WorkbenchBase   = OpenLibrary("workbench.library",           OS_35 )))
    {   printf("Need workbench.library V44+!\n");
        cleanexit(EXIT_FAILURE);
    }

#ifdef __amigaos4__
    if
    (    IntuitionBase->LibNode.lib_Version >  54
     || (IntuitionBase->LibNode.lib_Version == 54 && IntuitionBase->LibNode.lib_Revision >= 6)
    )
    {   os4menus = TRUE;
    }
#endif

    wbver  = VersionBase->lib_Version;
    wbrev  = VersionBase->lib_Revision;
    if
    (   wbver > 53
     || (wbver == 53 && SysBase->LibNode.lib_Revision >= 12)
    ) // if (OS4.1.1) or later
    {   urlopen = TRUE;
    }

    if (!urlopen)
    {   OpenURLBase = OpenLibrary("openurl.library", 0);
#ifdef __amigaos4__
        if (OpenURLBase)
        {   IOpenURL = (struct OpenURLIFace*)
                       GetInterface(OpenURLBase, "main", 1, 0);
        }
#endif
    }

    if (FindResident("MorphOS"))
    {   morphos = TRUE;

        AmigaGuideBase = OpenLibrary("amigaguide.library", OS_ANY);
#ifdef __amigaos4__
        if (AmigaGuideBase)
        {   IAmigaGuide = (struct AmigaGuideIFace*)
                          GetInterface(AmigaGuideBase, "main", 1, 0);
        }
#endif
    }
    if (SysBase->LibNode.lib_Version >= OS_40)
    {   lame = TRUE; // MOS or OS4
    }

#ifdef __amigaos4__
    if
    (   !(IGraphics       = (struct GraphicsIFace*)       GetInterface((struct Library*) GfxBase,       "main", 1, 0))
     || !(IIcon           = (struct IconIFace*)           GetInterface((struct Library*) IconBase,      "main", 1, 0))
     || !(IIntuition      = (struct IntuitionIFace*)      GetInterface((struct Library*) IntuitionBase, "main", 1, 0))
     || !(IAsl            = (struct AslIFace*)            GetInterface(AslBase,            "main", 1, 0))
     || !(IBitMap         = (struct BitMapIFace*)         GetInterface(BitMapBase,         "main", 1, 0))
     || !(IButton         = (struct ButtonIFace*)         GetInterface(ButtonBase,         "main", 1, 0))
     || !(IClickTab       = (struct ClickTabIFace*)       GetInterface(ClickTabBase,       "main", 1, 0))
     || !(IFuelGauge      = (struct FuelGaugeIFace*)      GetInterface(FuelGaugeBase,      "main", 1, 0))
     || !(IGadTools       = (struct GadToolsIFace*)       GetInterface(GadToolsBase,       "main", 1, 0))
     || !(IInteger        = (struct IntegerIFace*)        GetInterface(IntegerBase,        "main", 1, 0))
     || !(ILabel          = (struct LabelIFace*)          GetInterface(LabelBase,          "main", 1, 0))
     || !(ILayout         = (struct LayoutIFace*)         GetInterface(LayoutBase,         "main", 1, 0))
     || !(ISlider         = (struct SliderIFace*)         GetInterface(SliderBase,         "main", 1, 0))
     || !(ISpace          = (struct SpaceIFace*)          GetInterface(SpaceBase,          "main", 1, 0))
     || !(IString         = (struct StringIFace*)         GetInterface(StringBase,         "main", 1, 0))
     || !(IWindow         = (struct WindowIFace*)         GetInterface(WindowBase,         "main", 1, 0))
     || !(IWorkbench      = (struct WorkbenchIFace*)      GetInterface(WorkbenchBase,      "main", 1, 0))
    )
    {   DISCARD printf("CodeWar for OS4: Need AmigaOS 4.0+!\n");
        cleanexit(EXIT_FAILURE);
    }

    if
    (   (ApplicationBase = OpenLibrary("application.library", OS_ANY))
     && (IApplication    = (struct ApplicationIFace*)
                           GetInterface(ApplicationBase, "main", 2, 0))
    )
    {   AppID = RegisterApplication
        (   "CodeWar",
            REGAPP_Description,       "A game for programmers",
            REGAPP_URLIdentifier,     "amigan.1emu.net",
            REGAPP_AllowsBlanker,     TRUE, // or perhaps FALSE?
            REGAPP_HasIconifyFeature, TRUE,
        TAG_DONE);
        GetApplicationAttrs(AppID, APPATTR_Port, &AppLibPort, TAG_END);
        AppLibSignal = 1 << AppLibPort->mp_SigBit;
    }
#endif

    ProgLock = GetProgramDir(); // never unlock this!

    // this must be done before the menus are set up
    if (paused)     NewMenu[INDEX_PAUSED].nm_Flags    |= CHECKED;
    if (turbo)      NewMenu[INDEX_TURBO].nm_Flags     |= CHECKED;
    if (sound)      NewMenu[INDEX_SOUND].nm_Flags     |= CHECKED;
    if (show_stars) NewMenu[INDEX_STARFIELD].nm_Flags |= CHECKED;

    lockscreen();
    if (GetVPModeID(&(ScreenPtr->ViewPort)) == INVALID_ID)
    {   rq("Invalid default public screen mode ID!");
    }
    if (!(VisualInfoPtr = (struct VisualInfo*) GetVisualInfo(ScreenPtr, TAG_DONE)))
    {   rq("Can't get GadTools visual info!");
    }
    unlockscreen();

    if (!(AppPort = CreateMsgPort()))
    {   rq("Can't create message port!");
    }

    if (!(TimerIO = (struct timerequest*) AllocMem(sizeof(struct timerequest), MEMF_PUBLIC | MEMF_CLEAR)))
    {   rq((STRPTR) "Out of memory!");
    }
    if ((TimerClosed = OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest*) TimerIO, 0)))
    {   rq((STRPTR) "Can't open timer.device!");
    }

#if defined(__GNUC__) && !defined(__amigaos4__)
    TimerBase = (struct Library*) TimerIO->tr_node.io_Device;
#else
    TimerBase = (struct Device*)  TimerIO->tr_node.io_Device;
#endif

#ifdef __amigaos4__
    if (!(ITimer = (struct TimerIFace*) GetInterface((struct Library*) TimerBase, "main", 1, 0)))
    {   rq((STRPTR) "Can't get interface for timer.device!");
    }
#endif /* __amigaos4__ */

    guideexists = Exists("PROGDIR:CodeWar.guide");

    loadconfig(); // CLI arguments override config file

    strcpy(fn_emu, "PROGDIR:");
    if (argc) // started from CLI
    {   AddPart(fn_emu, FilePart(argv[0]), MAX_PATH);

#ifdef TESTJUMP
        if (!(ArgsPtr = ReadArgs
        (    "ATOMICS/K/N," //  0
               "BOMBS/K/N," //  1
              "BOUNDARY/K," //  2
             "CANNONS/K/N," //  3
              "DAMAGE/K/N," //  4
              "ENERGY/K/N," //  5
               "FORCE/K/N," //  6
            "GFXWIDTH/K/N," //  7
           "GFXHEIGHT/K/N," //  8
            "INTERVAL/K/N," //  9
                "MASS/K/N," // 10
            "MISSILES/K/N," // 11
                 "PRI/K/N," // 12
             "PUBSCREEN/K," // 13
             "SHIELDS/K/N," // 14
                 "SOUND/K," // 15
                 "TURBO/K," // 16
          "WORLDWIDTH/K/N," // 17
         "WORLDHEIGHT/K/N," // 18
                  "ROBOT1," // 19
                  "ROBOT2," // 20
                  "ROBOT3," // 21
                  "ROBOT4," // 22
                  "ROBOT5," // 23
                  "ROBOT6," // 24
                  "ROBOT7," // 25
                  "ROBOT8," // 26
            "JUMPSCREEN/K", // 27
            (LONG*) args,
            NULL
        )))
        {   printusage(argv[0]);
        }
#else
        if (!(ArgsPtr = ReadArgs
        (    "ATOMICS/K/N," //  0
               "BOMBS/K/N," //  1
              "BOUNDARY/K," //  2
             "CANNONS/K/N," //  3
              "DAMAGE/K/N," //  4
              "ENERGY/K/N," //  5
               "FORCE/K/N," //  6
            "GFXWIDTH/K/N," //  7
           "GFXHEIGHT/K/N," //  8
            "INTERVAL/K/N," //  9
                "MASS/K/N," // 10
            "MISSILES/K/N," // 11
                 "PRI/K/N," // 12
             "PUBSCREEN/K," // 13
             "SHIELDS/K/N," // 14
                 "SOUND/K," // 15
                 "TURBO/K," // 16
          "WORLDWIDTH/K/N," // 17
         "WORLDHEIGHT/K/N," // 18
                  "ROBOT1," // 19
                  "ROBOT2," // 20
                  "ROBOT3," // 21
                  "ROBOT4," // 22
                  "ROBOT5," // 23
                  "ROBOT6," // 24
                  "ROBOT7," // 25
                  "ROBOT8", // 26
            (LONG*) args,
            NULL
        )))
        {   printusage(argv[0]);
        }
#endif

        if (args[ARGPOS_ATOMICS])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_ATOMICS]));
            if (number >= 0)
            {   dft_atomics = number;
            } else
            {   printf("%s: ATOMICS must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_BOMBS])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_BOMBS]));
            if (number >= 0)
            {   dft_bombs = number;
            } else
            {   printf("%s: BOMBS must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_BOUNDARY])
        {   if     (!stricmp((CONST_STRPTR) args[ARGPOS_BOUNDARY], "ABYSS"))
            {   wall_type = ABYSS;
            } elif (!stricmp((CONST_STRPTR) args[ARGPOS_BOUNDARY], "RUBBER"))
            {   wall_type = RUBBER;
            } elif (!stricmp((CONST_STRPTR) args[ARGPOS_BOUNDARY], "STONE"))
            {   wall_type = STONE;
            } elif (!stricmp((CONST_STRPTR) args[ARGPOS_BOUNDARY], "TWILIGHT"))
            {   wall_type = TWILIGHT;
            } else
            {   DISCARD printf("%s: BOUNDARY must be ABYSS, RUBBER, STONE or TWILIGHT!\n", argv[0]);
        }   }
        if (args[ARGPOS_CANNONS])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_CANNONS]));
            if (number >= 0)
            {   dft_cannons = number;
            } else
            {   printf("%s: CANNONS must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_DAMAGE])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_DAMAGE]));
            if (number >= 1)
            {   damage_max = number;
            } else
            {   printf("%s: DAMAGE must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_ENERGY])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_ENERGY]));
            if (number >= 0)
            {   dft_energy = number;
            } else
            {   printf("%s: ENERGY must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_FORCE])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_FORCE]));
            if (number >= 0)
            {   dft_force = number;
            } else
            {   printf("%s: FORCE must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_GFXWIDTH])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_GFXWIDTH]));
            if (number >= 1 && number % 4 == 0)
            {   battle.width = (float) number;
            } else
            {   printf("%s: GFXWIDTH must be >= 1 && GFXWIDTH %% 4 must be 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_GFXHEIGHT])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_GFXHEIGHT]));
            if (number >= 1)
            {   battle.height = (float) number;
            } else
            {   printf("%s: GFXHEIGHT must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_INTERVAL])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_INTERVAL]));
            if (number >= 1)
            {   interval = number;
            } else
            {   printf("%s: INTERVAL must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_MASS])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_MASS]));
            if (number >= 0)
            {   dft_mass = number;
            } else
            {   printf("%s: MASS must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_MISSILES])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_MISSILES]));
            if (number >= 0)
            {   dft_missiles = number;
            } else
            {   printf("%s: MISSILES must be >= 0!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_PRI])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_PRI]));
            if (number < -128 || number > 5)
            {   DISCARD printf("%s: Priority range is -128 to 5!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
            }
            NewPri = (SBYTE) number;
            changepri = TRUE;
        }
        if (args[ARGPOS_PUBSCREEN])
        {   DISCARD strcpy(screenname, (STRPTR) args[ARGPOS_PUBSCREEN]);
        }
        if (args[ARGPOS_SHIELDS])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_SHIELDS]));
            if (number >= 0 && number <= 100)
            {   dft_shields = number;
            } else
            {   printf("%s: SHIELDS must be >= 0 && <= 100!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_SOUND])
        {   if (!stricmp((CONST_STRPTR) args[ARGPOS_SOUND], "ON"))
            {   sound       = TRUE;
            } elif (!stricmp((CONST_STRPTR) args[ARGPOS_SOUND], "OFF"))
            {   sound       = FALSE;
            } else
            {   DISCARD printf("%s: SOUND must be ON or OFF!\n", argv[0]);
        }   }
        if (args[ARGPOS_TURBO])
        {   if (!stricmp((CONST_STRPTR) args[ARGPOS_TURBO], "ON"))
            {   turbo       = TRUE;
            } elif (!stricmp((CONST_STRPTR) args[ARGPOS_TURBO], "OFF"))
            {   turbo       = FALSE;
            } else
            {   DISCARD printf("%s: TURBO must be ON or OFF!\n", argv[0]);
        }   }
        if (args[ARGPOS_WORLDWIDTH])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_WORLDWIDTH]));
            if (number >= 1)
            {   config.field[X_AXIS] = (float) number;
            } else
            {   printf("%s: WORLDWIDTH must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_WORLDHEIGHT])
        {   number = (SLONG) (*((SLONG*) args[ARGPOS_WORLDHEIGHT]));
            if (number >= 1)
            {   config.field[Y_AXIS] = (float) number;
            } else
            {   printf("%s: WORLDHEIGHT must be >= 1!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[ARGPOS_ROBOT1]) strcpy(fn_robot[0], (const STRPTR) args[ARGPOS_ROBOT1]);
        if (args[ARGPOS_ROBOT2]) strcpy(fn_robot[1], (const STRPTR) args[ARGPOS_ROBOT2]);
        if (args[ARGPOS_ROBOT3]) strcpy(fn_robot[2], (const STRPTR) args[ARGPOS_ROBOT3]);
        if (args[ARGPOS_ROBOT4]) strcpy(fn_robot[3], (const STRPTR) args[ARGPOS_ROBOT4]);
        if (args[ARGPOS_ROBOT5]) strcpy(fn_robot[4], (const STRPTR) args[ARGPOS_ROBOT5]);
        if (args[ARGPOS_ROBOT6]) strcpy(fn_robot[5], (const STRPTR) args[ARGPOS_ROBOT6]);
        if (args[ARGPOS_ROBOT7]) strcpy(fn_robot[6], (const STRPTR) args[ARGPOS_ROBOT7]);
        if (args[ARGPOS_ROBOT8]) strcpy(fn_robot[7], (const STRPTR) args[ARGPOS_ROBOT8]);
#ifdef TESTJUMP
        if (args[ARGPOS_JUMPSCREEN])
        {   DISCARD stch_l((char const*) args[ARGPOS_JUMPSCREEN], (long*) &futurejump);
        }
#endif

        // assert(ArgsPtr);
        FreeArgs(ArgsPtr);
        ArgsPtr = NULL;
    } else /* started from WB */
    {   WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList; /* head of the arg list */

/* When double-clicking the tool:
    There is 1 arg
    arg 0 is the filename (eg. CodeWar-NoFPU) (note: no path component)

   When double-clicking the project:
    There are 2 args
    arg 0 is the tool filename (eg. AmiArcadia) (note: no path component)
    arg 1 is the project filename (eg. MoonlandingFor2.pgm) (note: no path
     component)

   When clicking one or more projects and then shift-double-clicking the
    tool:
    There are 2 or more args
    arg 0 is the tool filename (eg. AmiArcadia) (note: no path component)
    arg 1 is the first project filename (eg. MoonlandingFor2.pgm) (note:
     no path component)
    args 2+ are the other project filenames (note: no path component) */

        for
        (   i = 0;
            i < (int)(ULONG) WBMsg->sm_NumArgs;
            i++, WBArg++
        )
        {   if (i == 0)
            {   AddPart(fn_emu, WBArg->wa_Name, MAX_PATH);
            } /* elif (i <= ROBOTS)
            {   DISCARD NameFromLock(WBArg->wa_Lock, fn_robot[i], MAX_PATH);
                DISCARD AddPart(fn_robot[i], WBArg->wa_Name, MAX_PATH);
            } */
    }   }

    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }

#ifdef __amigaos4__
    if (GetVar("MenuImageSize", envbuffer, 13 + 1, 0) != -1)
    {   menuimagesize = atol(envbuffer);
        if (menuimagesize == 0)
        {   os4menus = FALSE;
    }   }
#endif

    SplashWinObject =
    WindowObject,
        WA_PubScreen,                     ScreenPtr,
        WA_ScreenTitle,                   "CodeWar " DECIMALVERSION,
        WA_Title,                         "CodeWar " DECIMALVERSION,
        WA_DragBar,                       TRUE,
        WA_DepthGadget,                   TRUE,
        WA_Width,                         256,
        WINDOW_Position,                  WPOS_CENTERSCREEN,
        WINDOW_FrontBack,                 WT_FRONT,
        WINDOW_ParentGroup,               gadgets[GID_LY14] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_AddChild,              gadgets[GID_FG1] = (struct Gadget*)
            FuelGaugeObject,
                GA_ID,                    GID_FG1,
                GA_Text,                  "Loading...",
                FUELGAUGE_Min,            0,
#ifdef __amigaos4__
                FUELGAUGE_Max,            LASTINITIMAGE - FIRSTINITIMAGE + 1 + (os4menus ? OS4IMAGES : 0),
#else
                FUELGAUGE_Max,            LASTINITIMAGE - FIRSTINITIMAGE + 1,
#endif
                FUELGAUGE_Level,          0,
                FUELGAUGE_Percent,        FALSE,
                FUELGAUGE_Justification,  FGJ_CENTER,
                FUELGAUGE_TickSize,       0,
            FuelGaugeEnd,
            CHILD_WeightedHeight,         0,
        LayoutEnd,
    End;
    if (SplashWinObject)
    {   SplashWindowPtr = RA_OpenWindow(SplashWinObject);
    }
    unlockscreen();
    if (!SplashWinObject || !SplashWindowPtr)
    {   rq("Can't create splash window!"); // better if we were more tolerant of this situation
    }

    load_images(FIRSTINITIMAGE, LASTINITIMAGE, TRUE);
#ifdef __amigaos4__
    if (os4menus)
    {   load_menuimages();
    }
#endif

    // clear messages first?
    // assert(SplashWinObject);
    DisposeObject(SplashWinObject);
    SplashWinObject = NULL;
    SplashWindowPtr = NULL;

#ifdef __amigaos4__
    if (os4menus)
    {   MenuPtr = (struct Menu*)
        MStrip,
            MA_FreeImage,        FALSE,
            MA_AddChild,         MTitle("Project"                            ), MA_ID, FULLMENUNUM(MN_PROJECT,  NOITEM,        NOSUB         ) + 1,
                MA_AddChild,     MItem( "Open..."                            ), MA_ID, FULLMENUNUM(MN_PROJECT,  IN_OPEN,       NOSUB         ) + 1, MA_Key, "O", MA_Image, menuimage[0], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Iconify"                            ), MA_ID, FULLMENUNUM(MN_PROJECT,  IN_ICONIFY,    NOSUB         ) + 1, MA_Key, "I", MA_Image, menuimage[1], MEnd,
                MA_AddChild,     MItem( "Quit CodeWar"                       ), MA_ID, FULLMENUNUM(MN_PROJECT,  IN_QUIT,       NOSUB         ) + 1, MA_Key, "Q", MA_Image, menuimage[2], MEnd,
            MEnd,
            MA_AddChild,         MTitle("Tools"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,    NOITEM,        NOSUB         ) + 1,
                MA_AddChild,     MItem( "Energize (E)"                       ), MA_ID, FULLMENUNUM(MN_TOOLS,    IN_ENERGIZE,   NOSUB         ) + 1,                                      MEnd,
                MA_AddChild,     MItem( "Heal (H)"                           ), MA_ID, FULLMENUNUM(MN_TOOLS,    IN_HEAL,       NOSUB         ) + 1,                                      MEnd,
                MA_AddChild,     MItem( "Rearm (A)"                          ), MA_ID, FULLMENUNUM(MN_TOOLS,    IN_REARM,      NOSUB         ) + 1,                                      MEnd,
                MA_AddChild,     MItem( "Reposition (R)"                     ), MA_ID, FULLMENUNUM(MN_TOOLS,    IN_REPOSITION, NOSUB         ) + 1,                                      MEnd,
            MEnd,
            MA_AddChild,         MTitle("Settings"                           ), MA_ID, FULLMENUNUM(MN_SETTINGS, NOITEM,        NOSUB         ) + 1,
                MA_AddChild,     MItem( "Paused? (P)"                        ), MA_ID, FULLMENUNUM(MN_SETTINGS, IN_PAUSED,     NOSUB         ) + 1, MA_Key, "T", MA_Toggle, TRUE,        MEnd,
                MA_AddChild,     MItem( "Turbo? (T)"                         ), MA_ID, FULLMENUNUM(MN_SETTINGS, IN_TURBO,      NOSUB         ) + 1,              MA_Toggle, TRUE,        MEnd,
                MA_AddChild,     MItem( "Speed..."                           ), MA_ID, FULLMENUNUM(MN_SETTINGS, IN_SPEED,      NOSUB         ) + 1,                                      MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Sound? (S)"                         ), MA_ID, FULLMENUNUM(MN_SETTINGS, IN_SOUND,      NOSUB         ) + 1, MA_Key, "U", MA_Toggle, TRUE,        MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Starfield? (B)"                     ), MA_ID, FULLMENUNUM(MN_SETTINGS, IN_STARFIELD,  NOSUB         ) + 1,              MA_Toggle, TRUE,        MEnd,
            MEnd,
            MA_AddChild,         MTitle("Help"                               ), MA_ID, FULLMENUNUM(MN_HELP,     NOITEM,        NOSUB         ) + 1,
                MA_AddChild,     MItem( "Manual..."                          ), MA_ID, FULLMENUNUM(MN_HELP,     IN_MANUAL,     NOSUB         ) + 1, MA_Key, "M", MA_Image, menuimage[3], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "About CodeWar..."                   ), MA_ID, FULLMENUNUM(MN_HELP,     IN_ABOUT,      NOSUB         ) + 1, MA_Key, "?", MA_Image, menuimage[4], MEnd,
            MEnd,
        MEnd;
    } else
#endif
    {   if (!(MenuPtr = (struct Menu*) CreateMenus(NewMenu, TAG_DONE)))
        {   rq("Can't create menus!");
        }
        if (!(LayoutMenus(MenuPtr, VisualInfoPtr, GTMN_NewLookMenus, TRUE, TAG_DONE)))
        {   rq("Can't lay out menus!");
    }   }

    ct_makelist
    (   &ClickTabsList,
        lame ? PageOptionsOS4 : PageOptionsOS3,
        lame ? 4              : 2
    );

    if (sound)
    {   start_sounds();
    }
    make_bodies();
    graphics_setup_display();

    OldPri = SetTaskPri((struct Task*) ProcessPtr, NewPri);
    if (!changepri)
    {   NewPri = OldPri;
        DISCARD SetTaskPri((struct Task*) ProcessPtr, NewPri);
    }

    // assert(MainWindowPtr);
    if (!(ASLRqPtr = (struct FileRequester*) AllocAslRequestTags(ASL_FileRequest, ASL_Pattern, "~(#?.info)", ASL_Window, MainWindowPtr, TAG_DONE)))
    {   rq("Can't create ASL requester!");
    }

    if (!(PublicPort = CreateMsgPort()))
    {   rq("Can't create message port!");
    }
    PublicPort->mp_Node.ln_Name = "CodeWar";
    PublicPort->mp_Node.ln_Pri  = 0;
    AddPort(PublicPort);

    for (i = 0; i < ROBOTS; i++)
    {   if (fn_robot[i][0])
        {   load_robot(fn_robot[i]);
    }   }

    cw_server_process();

    return 0; // we never reach here
}

MODULE void make_robotgads(void)
{   int robot;

    for (robot = 0; robot < ROBOTS; robot++)
    {   gadgets[GID_LY2 + robot] = (struct Gadget*)
        VLayoutObject,
         // LAYOUT_TextPen,                      pens[robot], // doesn't work for some reason!
            LAYOUT_FillPen,                      pens[robot],
            LAYOUT_BevelStyle,                   BVS_GROUP,
#ifndef __amigaos4__
            LAYOUT_Label,                        RobotName[robot],
#endif
            LAYOUT_AddChild,                     gadgets[GID_ST1 + robot] = (struct Gadget*)
            StringObject,
                GA_ID,                           GID_ST1 + robot,
                GA_ReadOnly,                     TRUE,
            StringEnd,
            CHILD_WeightedHeight,                0,
            LAYOUT_AddChild,                     gadgets[GID_ST9 + robot] = (struct Gadget*)
            StringObject,
                GA_ID,                           GID_ST9 + robot,
                GA_ReadOnly,                     TRUE,
            StringEnd,
            CHILD_WeightedHeight,                0,
            AddHLayout,
                LAYOUT_VertAlignment,            LALIGN_CENTER,
                LAYOUT_AddChild,                 gadgets[GID_ST25 + robot] = (struct Gadget*)
                StringObject,
                    GA_ID,                       GID_ST25 + robot,
                    GA_ReadOnly,                 TRUE,
                    STRINGA_Justification,       GACT_STRINGRIGHT,
                StringEnd,
                Label("Acc:"),
                LAYOUT_AddChild,                 gadgets[GID_ST17 + robot] = (struct Gadget*)
                StringObject,
                    GA_ID,                       GID_ST17 + robot,
                    GA_ReadOnly,                 TRUE,
                    STRINGA_Justification,       GACT_STRINGRIGHT,
                StringEnd,
                Label("Vel:"),
            LayoutEnd,
            CHILD_WeightedHeight,                0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_AddImage,                 image[BITMAP_ATOMIC  + (4 * robot)],
                    CHILD_NoDispose,                 TRUE,
                 // CHILD_WeightedWidth,             0,
                    LAYOUT_AddImage,                 image[BITMAP_BOMB    + (4 * robot)],
                    CHILD_NoDispose,                 TRUE,
                 // CHILD_WeightedWidth,             0,
                    LAYOUT_AddImage,                 image[BITMAP_CANNON  + (4 * robot)],
                    CHILD_NoDispose,                 TRUE,
                 // CHILD_WeightedWidth,             0,
                    LAYOUT_AddImage,                 image[BITMAP_MISSILE + (4 * robot)],
                    CHILD_NoDispose,                 TRUE,
                 // CHILD_WeightedWidth,             0,
                LayoutEnd,
             // CHILD_WeightedWidth,                 0,
                AddVLayout,
                    AddInteger(GID_IN17 + robot),
                    AddInteger(GID_IN25 + robot),
                    AddInteger(GID_IN33 + robot),
                    AddInteger(GID_IN41 + robot),
                LayoutEnd,
                AddVLayout,
                    AddLabel("Dmg:"),
                    AddLabel("Shd:"),
                    AddLabel("Egy:"),
                    AddLabel("X:"),
                LayoutEnd,
                CHILD_WeightedWidth,                 0,
                AddVLayout,
                    AddInteger(GID_IN49 + robot),
                    AddInteger(GID_IN65 + robot),
                    AddInteger(GID_IN81 + robot),
                    AddInteger(GID_IN1  + robot),
                LayoutEnd,
                AddVLayout,
                    AddLabel("/"),
                    AddLabel("/"),
                    AddLabel("/"),
                    AddLabel("Y:"),
                LayoutEnd,
                CHILD_WeightedWidth,                 0,
                AddVLayout,
                    AddInteger(GID_IN57 + robot),
                    AddInteger(GID_IN73 + robot),
                    AddInteger(GID_IN89 + robot),
                    AddInteger(GID_IN9  + robot),
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                    0,
        LayoutEnd;
}   }

MODULE void make_os3pagegad(int whichpage)
{   gadgets[GID_LY10 + whichpage] = (struct Gadget*)
    VLayoutObject,
        LAYOUT_AddChild,                         gadgets[GID_LY2 + (whichpage * 4)],
        CHILD_WeightedHeight,                    0,
        AddSpace,
        LAYOUT_AddChild,                         gadgets[GID_LY3 + (whichpage * 4)],
        CHILD_WeightedHeight,                    0,
        AddSpace,
        LAYOUT_AddChild,                         gadgets[GID_LY4 + (whichpage * 4)],
        CHILD_WeightedHeight,                    0,
        AddSpace,
        LAYOUT_AddChild,                         gadgets[GID_LY5 + (whichpage * 4)],
        CHILD_WeightedHeight,                    0,
    LayoutEnd;
}

MODULE void make_os4pagegad(int whichpage)
{   gadgets[GID_LY10 + whichpage] = (struct Gadget*)
    VLayoutObject,
        LAYOUT_AddChild,                         gadgets[GID_LY2 + (whichpage * 2)],
        CHILD_WeightedHeight,                    0,
        AddSpace,
        LAYOUT_AddChild,                         gadgets[GID_LY3 + (whichpage * 2)],
        CHILD_WeightedHeight,                    0,
    LayoutEnd;
}

MODULE void graphics_setup_display(void)
{   int i;

    battle.scale[X_AXIS] = (float) battle.width  / (float) config.field[X_AXIS];
    battle.scale[Y_AXIS] = (float) battle.height / (float) config.field[Y_AXIS];

     /* It uses its normal icon for iconification.
        We could instead use a different icon if desired.

        ReAction frees the icon automatically when the window is
        closed (unfortunately). */

    getpens();
    make_robotgads();

    if (lame)
    {   make_os4pagegad(0);
        make_os4pagegad(1);
        make_os4pagegad(2);
        make_os4pagegad(3);
    } else
    {   make_os3pagegad(0);
        make_os3pagegad(1);
    }

    IconifiedIcon = GetDiskObjectNew(fn_emu);

    lockscreen();
    if (!(WinObject =
    WindowObject,
        WA_PubScreen,                                         ScreenPtr,
        WA_ScreenTitle,                                       "CodeWar " DECIMALVERSION,
        WA_Title,                                             "CodeWar " DECIMALVERSION,
        WA_Activate,                                          TRUE,
        WA_DepthGadget,                                       TRUE,
        WA_DragBar,                                           TRUE,
        WA_CloseGadget,                                       TRUE,
        WA_SizeGadget,                                        FALSE,
        WA_IDCMP,                                             IDCMP_RAWKEY /* | IDCMP_NEWSIZE */ ,
        WINDOW_MenuStrip,                                     MenuPtr,
     // morphos ? WA_SkinInfo : TAG_IGNORE,                   NULL,
        WINDOW_IconifyGadget,                                 TRUE,
        WINDOW_IconTitle,                                     "CodeWar",
        IconifiedIcon ? WINDOW_Icon : TAG_IGNORE,             IconifiedIcon,
     // morphos ? WA_ExtraGadget_Iconify : TAG_IGNORE,        TRUE,
        WINDOW_PopupGadget,                                   TRUE, // for OS4 users
        WINDOW_JumpScreensMenu,                               TRUE, // for OS4 users
        WINDOW_AppPort,                                       AppPort,
        WINDOW_AppWindow,                                     TRUE,
        WINDOW_Position,                                      WPOS_CENTERSCREEN,
        WINDOW_ParentGroup,                                   gadgets[GID_LY1] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_AddChild,                                  gadgets[GID_CT1] = (struct Gadget*)
            ClickTabObject,
                GA_ID,                                        GID_CT1,
                GA_RelVerify,                                 TRUE,
                CLICKTAB_Labels,                              &ClickTabsList,
                CLICKTAB_PageGroup,                           gadgets[GID_PA1] = (struct Gadget*)
                PageObject,
                    LAYOUT_DeferLayout,                       TRUE,
                    PAGE_Add,                                 gadgets[GID_LY10],
                    PAGE_Add,                                 gadgets[GID_LY11],
                    lame ? PAGE_Add : TAG_IGNORE,             gadgets[GID_LY12],
                    lame ? PAGE_Add : TAG_IGNORE,             gadgets[GID_LY13],
//                  ICA_MAP,                                  PAtoCTmap,
                    PAGE_Current,                             functab,
                PageEnd,
                CLICKTAB_Current,                             functab,
//              ICA_MAP,                                      CTtoPAmap,
            ClickTabEnd,
            AddVLayout,
                AddSpace,
                LAYOUT_AddChild,                              gadgets[GID_SP1] = (struct Gadget*)
                SpaceObject,
                    GA_ID,                                    GID_SP1,
                    SPACE_MinWidth,                           battle.width,
                    SPACE_MinHeight,                          battle.height,
                    SPACE_BevelStyle,                         BVS_FIELD,
                SpaceEnd,
                CHILD_WeightedWidth,                          0,
                CHILD_WeightedHeight,                         0,
                AddSpace,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();

    if (!(MainWindowPtr = (struct Window*) RA_OpenWindow(WinObject)))
    {   rq("Can't open window!");
    }

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = 1 << AppPort->mp_SigBit;
    if (guideexists && (!morphos || AmigaGuideBase))
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL, NOSUB));
    }

    for (i = 0; i < ROBOTS; i++)
    {   disable(GID_ST1  + i);
        disable(GID_ST9  + i);
        disable(GID_ST17 + i);
        disable(GID_ST25 + i);
        disable(GID_IN1  + i);
        disable(GID_IN9  + i);
        disable(GID_IN17 + i);
        disable(GID_IN25 + i);
        disable(GID_IN33 + i);
        disable(GID_IN41 + i);
        disable(GID_IN49 + i);
        disable(GID_IN57 + i);
        disable(GID_IN65 + i);
        disable(GID_IN73 + i);
        disable(GID_IN81 + i);
        disable(GID_IN89 + i);
    }

    rethinkrobots();

    make_buffer();
    setup_backdrop();

    updateticks();
}

MODULE void cleanexit(int rc)
{   int             i,
                    robot;
    struct Message* MsgPtr;

#ifdef TRACKEXIT
    printf("1...\n"); Delay(TRACKDELAY);
#endif

    close_about();
    close_speed();
    // clear messages first?
    if (SplashWinObject)
    {   DisposeObject(SplashWinObject);
        SplashWinObject = NULL;
        SplashWindowPtr = NULL;
    }

    if (PublicPort)
    {   if (PublicPort->mp_Node.ln_Name)
        {   RemPort(PublicPort);
        }
#ifdef TRACKEXIT
        printf("1a...\n"); Delay(TRACKDELAY);
#endif

/*      while ((SglMsgPtr = (struct CodeWarSglMsg*) GetMsg(PublicPort)))
        {   if (player[SglMsgPtr->cw_Robot - 1].alive)
            {   ReplyMsg((struct Message*) SglMsgPtr);
                // we don't handle the messages nor set a return code, but this is unimportant
        }   }
*/

#ifdef TRACKEXIT
    printf("1b...\n"); Delay(TRACKDELAY);
#endif
        DeleteMsgPort(PublicPort);
        PublicPort = NULL;
    }

#ifdef TRACKEXIT
    printf("2...\n"); Delay(TRACKDELAY);
#endif

    // now that there are no messages (nor a port for them), we kill off
    // any robots that are still alive
    for (robot = 0; robot < ROBOTS; robot++)
    {   if (player[robot].alive)
        {   remove_player(robot, FALSE);
        }
        if (BodyPtr[robot])
        {   free(BodyPtr[robot]);
            BodyPtr[robot] = NULL;
    }   }
#ifdef TRACKEXIT
    printf("3...\n"); Delay(TRACKDELAY);
#endif

    if (WinObject) // NOT if (MainWindowPtr) (because it might be iconified)
    {   // Forbid();
        clearmsgs();
        DisposeObject(WinObject);
        /* "Disposing of the window object will also close the window
           if it is already opened, and it will dispose of the layout
           object attached to it." - checkboxexample.c */
        // Permit();
        WinObject     = NULL;
        MainWindowPtr = NULL;
    }

#ifdef TRACKEXIT
    printf("4...\n"); Delay(TRACKDELAY);
#endif
    freepens();
#ifdef TRACKEXIT
    printf("5...\n"); Delay(TRACKDELAY);
#endif
    destroy_buffer();

#ifdef TRACKEXIT
    printf("6...\n"); Delay(TRACKDELAY);
#endif

    freefx();

#ifdef TRACKEXIT
    printf("7...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (os4menus && MenuPtr)
    {   DisposeObject((Object*) MenuPtr);
        MenuPtr = NULL;
    }
#endif

    for (i = 0; i < BITMAPS; i++)
    {   if (image[i])
        {   DisposeObject(image[i]);
            image[i] = NULL;
    }   }
#ifdef __amigaos4__
    for (i = 0; i < OS4IMAGES; i++)
    {   if (menuimage[i])
        {   DisposeObject((Object*) menuimage[i]);
            menuimage[i] = NULL;
    }   }
#endif

    if (AppPort)
    {   while ((MsgPtr = GetMsg(AppPort)))
        {   ReplyMsg(MsgPtr);
        }
        DeleteMsgPort(AppPort);
        AppPort = NULL;
    }

#ifdef TRACKEXIT
    printf("8...\n"); Delay(TRACKDELAY);
#endif

    DISCARD SetTaskPri((struct Task*) ProcessPtr, OldPri);

#ifdef TRACKEXIT
    printf("9...\n"); Delay(TRACKDELAY);
#endif

    if (!os4menus && MenuPtr)
    {   FreeMenus(MenuPtr);
        MenuPtr = NULL;
    }
    if (VisualInfoPtr)
    {   FreeVisualInfo(VisualInfoPtr);
        VisualInfoPtr = NULL;
    }
    if (ASLRqPtr)
    {   FreeAslRequest(ASLRqPtr);
        ASLRqPtr = NULL;
    }

#ifdef TRACKEXIT
    printf("10...\n"); Delay(TRACKDELAY);
#endif

    if (!TimerClosed)
    {   // assert((TimerIO);
        CloseDevice((struct IORequest*) TimerIO);
        // TimerClosed = ~0;
    }
#ifdef TRACKEXIT
    printf("11...\n"); Delay(TRACKDELAY);
#endif
    if (TimerIO)
    {   FreeMem(TimerIO, sizeof(struct timerequest));
        // TimerIO = NULL;
    }
#ifdef TRACKEXIT
    printf("12...\n"); Delay(TRACKDELAY);
#endif

    if (ClickTabBase)
    {   ct_clearlist(&ClickTabsList);
    }

    if (rc == EXIT_SUCCESS)
    {   saveconfig();
    }

#ifdef TRACKEXIT
    printf("13...\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (IAmigaGuide)     DropInterface((struct Interface*) IAmigaGuide);
    if (IAsl)            DropInterface((struct Interface*) IAsl);
    if (IBitMap)         DropInterface((struct Interface*) IBitMap);
    if (IButton)         DropInterface((struct Interface*) IButton);
    if (IClickTab)       DropInterface((struct Interface*) IClickTab);
    if (IFuelGauge)      DropInterface((struct Interface*) IFuelGauge);
    if (IGadTools)       DropInterface((struct Interface*) IGadTools);
    if (IInteger)        DropInterface((struct Interface*) IInteger);
    if (ILabel)          DropInterface((struct Interface*) ILabel);
    if (ILayout)         DropInterface((struct Interface*) ILayout);
    if (IOpenURL)        DropInterface((struct Interface*) IOpenURL);
    if (ISlider)         DropInterface((struct Interface*) ISlider);
    if (ISpace)          DropInterface((struct Interface*) ISpace);
    if (IString)         DropInterface((struct Interface*) IString);
    if (ITimer)          DropInterface((struct Interface*) ITimer);
    if (IWorkbench)      DropInterface((struct Interface*) IWorkbench);
    if (IGraphics)       DropInterface((struct Interface*) IGraphics);
    if (IIcon)           DropInterface((struct Interface*) IIcon);
    if (IIntuition)      DropInterface((struct Interface*) IIntuition);

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

#ifdef TRACKEXIT
    printf("14...\n"); Delay(TRACKDELAY);
#endif

    if     (AmigaGuideBase) CloseLibrary(AmigaGuideBase);
    if            (AslBase) CloseLibrary(AslBase);
    if       (GadToolsBase) CloseLibrary(GadToolsBase);
    if            (GfxBase) CloseLibrary((struct Library*) GfxBase);
    if         (BitMapBase) CloseLibrary(BitMapBase);
    if         (ButtonBase) CloseLibrary(ButtonBase);
    if       (ClickTabBase) CloseLibrary(ClickTabBase);
    if      (FuelGaugeBase) CloseLibrary(FuelGaugeBase);
    if        (IntegerBase) CloseLibrary(IntegerBase);
    if          (LabelBase) CloseLibrary(LabelBase);
    if        (OpenURLBase) CloseLibrary(OpenURLBase);
    if         (SliderBase) CloseLibrary(SliderBase);
    if          (SpaceBase) CloseLibrary(SpaceBase);
    if         (StringBase) CloseLibrary(StringBase);
    if         (WindowBase) CloseLibrary(WindowBase);
    // window.class requires layout.gadget!
    if         (LayoutBase) CloseLibrary(LayoutBase);
    if        (VersionBase) CloseLibrary(VersionBase);
    if      (WorkbenchBase) CloseLibrary(WorkbenchBase);

#ifdef TRACKEXIT
    printf("15...\n"); Delay(TRACKDELAY);
#endif

    exit(rc);

#ifdef TRACKEXIT
    printf("16...\n"); Delay(TRACKDELAY); // we should never see this
#endif
}

EXPORT void updatescreen(void)
{   // assert(MainWindowPtr);

    xoffset = gadgets[GID_SP1]->LeftEdge;
    yoffset = gadgets[GID_SP1]->TopEdge;

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        (ULONG) xoffset,
        (ULONG) yoffset,
        (ULONG) (xoffset + battle.width  - 1),
        (ULONG) (yoffset + battle.height - 1),
        display,
        &wpa8rastport
    );
}

EXPORT void msgpump(void)
{   UWORD                  code;
    ULONG                  result;
    struct AppMessage*     AppMsg;
    struct List*           ScreenListPtr /* = NULL */ ;
    struct PubScreenNode*  NodePtr;
    struct WBArg*          ArgPtr;
#ifdef __amigaos4__
    struct ApplicationMsg* AppLibMsg;
    ULONG                  msgtype,
                           msgval,
                           os4code;
#endif

    if (paused)
    {   if ((Wait(MainSignal | AboutSignal | AppSignal | AppLibSignal | SpeedSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
        {   cleanexit(EXIT_SUCCESS);
    }   }
    else
    {   if (SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C)
        {   cleanexit(EXIT_SUCCESS);
    }   }

    about_loop();
    speed_loop();

    while ((AppMsg = (struct AppMessage*) GetMsg(AppPort)))
    {   switch (AppMsg->am_Type)
        {
        case AMTYPE_APPWINDOW:
            /* Get a pointer to the start of the Workbench
             * argument list.

             * The lock will be on the directory in
             * which the file resides. If there is no
             * filename, either a volume or window was
             * dropped on us. */

            ArgPtr = AppMsg->am_ArgList;
            if
            (   AppMsg->am_NumArgs == 1
             && ArgPtr->wa_Name[0]
             && ArgPtr->wa_Lock
             && NameFromLock(ArgPtr->wa_Lock, fn_robot[0], MAX_PATH + 1)
             && AddPart(fn_robot[0], ArgPtr->wa_Name, MAX_PATH + 1)
            )
            {   if (!load_robot(fn_robot[0]))
                {   DisplayBeep(NULL);
            }   }
        adefault:
            DisplayBeep(NULL);
        }
        ReplyMsg((struct Message*) AppMsg);
    }

    /* We should reply quicker than this!
       (Ideally, copy the fields we need, then reply to the message.)

       The code above (drag & drop support) must precede the code below
       (ReAction input handler). */

    while ((result = DoMethod(WinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_ICONIFY:
            iconify();
        acase WMHI_CLOSEWINDOW:
            cleanexit(EXIT_SUCCESS);
        acase WMHI_GADGETUP:
            switch (result & WMHI_GADGETMASK)
            {
            case GID_CT1:
                DISCARD GetAttr(CLICKTAB_Current, (Object*) gadgets[GID_CT1], &functab);
                DISCARD SetGadgetAttrs
                (   gadgets[GID_PA1],
                    MainWindowPtr, NULL,
                    PAGE_Current,  functab,
                TAG_DONE);
                rethinkrobots();
                if (paused)
                {   updatescreen();
                }
         /* acase ETI_Iconify:
                if (morphos)
                {   iconify();
                } */
            }
     /* acase WMHI_NEWSIZE:
            rethinkrobots(); */
        acase WMHI_MENUPICK:
#ifdef __amigaos4__
            if (os4menus)
            {   os4code = NO_MENU_ID;
                while ((os4code = IDoMethod((Object*) MenuPtr, MM_NEXTSELECT, 0, os4code)) != NO_MENU_ID)
                {   handlemenus(os4code - 1);
            }   }
            else
#endif
            {   handlemenus(code);
            }
        acase WMHI_JUMPSCREEN:
#ifdef __amigaos4__
            GetAttr
            (   WA_PubScreen,
                WinObject,
                (uint32*) &newscr
            );
#else
            GetAttr
            (   WA_PubScreen,
                WinObject,
                (ULONG*) &newscr
            );
#endif
            if (newscr)
            {   pending = TRUE;
            }
        acase WMHI_RAWKEY:
            /* raw key event, lower byte are the keycode, qualifiers only in hook-routine */
            code &= 0xFF;
            switch (code)
            {
            case SCAN_ESCAPE:
                cleanexit(EXIT_SUCCESS);
#ifdef TESTJUMP
            acase SCAN_J:
                if (futurejump)
                {   newscr = futurejump;
                    pending = TRUE;
                } else
                {   DisplayBeep(NULL);
                }
#endif
            acase SCAN_HELP:
                if (guideexists)
                {   help_manual();
                }
            acase KEYUP + SCAN_A1:
                keydown[0] = FALSE;
            acase KEYUP + SCAN_A2:
                keydown[1] = FALSE;
            acase KEYUP + SCAN_A3:
                keydown[2] = FALSE;
            acase KEYUP + SCAN_A4:
                keydown[3] = FALSE;
            acase KEYUP + SCAN_A5:
                keydown[4] = FALSE;
            acase KEYUP + SCAN_A6:
                keydown[5] = FALSE;
            acase KEYUP + SCAN_A7:
                keydown[6] = FALSE;
            acase KEYUP + SCAN_A8:
                keydown[7] = FALSE;
            adefault:
                handlekybd(code);
    }   }   }

#ifdef __amigaos4__
    if (AppLibPort)
    {   while ((AppLibMsg = (struct ApplicationMsg*) GetMsg(AppLibPort)))
        {   msgtype = AppLibMsg->type;
            msgval  = (ULONG) ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName;
            ReplyMsg((struct Message*) AppLibMsg);

            switch (msgtype)
            {
            acase APPLIBMT_Quit:
            case APPLIBMT_ForceQuit:
                cleanexit(EXIT_SUCCESS);
            acase APPLIBMT_Hide:
                iconify();
            acase APPLIBMT_ToFront:
                lockscreen();
                ScreenToFront(ScreenPtr);
                unlockscreen();
                // assert(MainWindowPtr);
                WindowToFront(MainWindowPtr);
                ActivateWindow(MainWindowPtr);
            acase APPLIBMT_OpenDoc:
                strcpy(fn_robot[0], ((struct ApplicationOpenPrintDocMsg*) AppMsg)->fileName);
                if (!load_robot(fn_robot[0]))
                {   DisplayBeep(NULL);
    }   }   }   }
#endif

    if (pending)
    {   pending = FALSE;

        clearmsgs();
        DisposeObject(WinObject);
        /* "Disposing of the window object will also close the window
           if it is already opened, and it will dispose of the layout
           object attached to it." - checkboxexample.c */
        WinObject     = NULL;
        MainWindowPtr = NULL;

        freepens();

        // assert(newscr);
        screenname[0] = EOS; // in case we can't find the screen
        ScreenListPtr = LockPubScreenList();
        NodePtr = (struct PubScreenNode*) ScreenListPtr->lh_Head;
        while ((NodePtr = (struct PubScreenNode*) NodePtr->psn_Node.ln_Succ))
        {   if (NodePtr->psn_Screen == newscr)
            {   strcpy(screenname, NodePtr->psn_Node.ln_Name);
                break; // for speed
        }   }
        UnlockPubScreenList();

        // ScreenListPtr = NULL;
        if (!screenname[0]) // in case we can't find the screen
        {   GetDefaultPubScreen(screenname);
        }
        // assert(newscr);
        ScreenPtr = newscr;

        graphics_setup_display();
    }

    handlemsgs();
}

MODULE void handlemsgs(void)
{   struct Message* CWMsgPtr;
    int robot;

    while ((CWMsgPtr = GetMsg(PublicPort)))
    {   SglMsgPtr = (struct CodeWarSglMsg*) CWMsgPtr;
        DblMsgPtr = (struct CodeWarDblMsg*) CWMsgPtr;

        robot = SglMsgPtr->cw_Robot - 1;

        switch (SglMsgPtr->cw_Operation)
        {
        case MT_REGISTER_PROGRAM:
#ifdef LOGTASKS
            printf("Simulator: Registering robot at $%X.\n", (int) (SglMsgPtr->cw_Number));
#endif
            robot = register_program((struct Task*) (SglMsgPtr->cw_Number));
            if (robot == -1)
            {   SglMsgPtr->cw_Result = 0;
            } else
            {   SglMsgPtr->cw_Result = robot + 1;
                ReplyPortPtr[robot] = SglMsgPtr->cw_Msg.mn_ReplyPort;
            }
        acase MT_ATOMIC:
            srv_Atomic(robot);
        acase MT_BOMB:
            srv_Bomb(robot);
        acase MT_BOOST_SHIELDS:
            srv_Boost_Shields(robot, SglMsgPtr->cw_Number);
        acase MT_CANNON:
            srv_Cannon(robot);
        acase MT_HALT:
            srv_Halt(robot);
        acase MT_MISSILE:
            srv_Missile(robot);
        acase MT_POWER:
            srv_Power(robot);
        acase MT_PRINT_BUFFER:
            strcpy(globalstring[robot], SglMsgPtr->cw_String);
            srv_Print_Buffer(robot);
        acase MT_SET_NAME:
            strcpy(globalstring[robot], SglMsgPtr->cw_String);
            set_name(robot);
        acase MT_GET_ATOMICS:
            SglMsgPtr->cw_Result       = player[robot].atomics;
        acase MT_GET_BOMBS:
            SglMsgPtr->cw_Result       = player[robot].bombs;
        acase MT_GET_BOUNDARYTYPE:
            SglMsgPtr->cw_Result       = wall_type;
        acase MT_GET_CANNONS:
            SglMsgPtr->cw_Result       = player[robot].cannons;
        acase MT_GET_DAMAGE:
            SglMsgPtr->cw_Result       = player[robot].damage;
        acase MT_GET_DAMAGE_MAX:
            SglMsgPtr->cw_Result       = damage_max;
        acase MT_GET_ENERGY:
            SglMsgPtr->cw_Result       = player[robot].energy;
        acase MT_GET_FORCE:
            SglMsgPtr->cw_Result       = dft_force;
        acase MT_GET_MASS:
            SglMsgPtr->cw_Result       = player[robot].mass;
        acase MT_GET_MISSILES:
            SglMsgPtr->cw_Result       = player[robot].missiles;
        acase MT_GET_SHIELDS:
            SglMsgPtr->cw_Result       = player[robot].shields;
        acase MT_GET_TIMEINTERVAL:
            SglMsgPtr->cw_Result       = interval;
        acase MT_SCAN:
            srv_Scan(robot);
            SglMsgPtr->cw_ResultSgl1   = player[robot].scan;
        acase MT_TURN:
            srv_Turn(robot);
        acase MT_GET_ACCELERATION:
            SglMsgPtr->cw_ResultSgl1   = player[robot].acc[X_AXIS];
            SglMsgPtr->cw_ResultSgl2   = player[robot].acc[Y_AXIS];
        acase MT_GET_FIELDLIMITS:
            SglMsgPtr->cw_ResultSgl1   = config.field[X_AXIS];
            SglMsgPtr->cw_ResultSgl2   = config.field[Y_AXIS];
        acase MT_GET_POSITION:
            SglMsgPtr->cw_ResultSgl1   = player[robot].position[X_AXIS];
            SglMsgPtr->cw_ResultSgl2   = player[robot].position[Y_AXIS];
        acase MT_GET_VELOCITY:
            SglMsgPtr->cw_ResultSgl1   = player[robot].velocity[X_AXIS];
            SglMsgPtr->cw_ResultSgl2   = player[robot].velocity[Y_AXIS];
        acase MT_GET_VERSION:
            SglMsgPtr->cw_ResultSgl1   = CW_VERSION;
        acase MT_GET_ELAPSEDTIME:
            SglMsgPtr->cw_ResultSgl1   = config.elapsed_time;
        }

        if (player[robot].alive)
        {   ReplyMsg((struct Message*) CWMsgPtr);
}   }   }

MODULE ULONG thetime(void)
{   PERSIST struct timeval thetimeval; // PERSISTent for speed
#ifdef __amigaos4__
    PERSIST struct TimeVal TheTimeVal; // PERSISTent for speed
#endif

#ifdef __amigaos4__
    GetSysTime(&TheTimeVal);
    thetimeval.tv_secs  = TheTimeVal.Seconds;
    thetimeval.tv_micro = TheTimeVal.Microseconds;
#else
    GetSysTime(&thetimeval);
#endif

    return (thetimeval.tv_secs  * 1000)
         + (thetimeval.tv_micro / 1000);
}

EXPORT void thewait(void)
{   PERSIST   ULONG waittill = 0;
    TRANSIENT ULONG newtime;

    newtime = thetime();
    if (newtime < waittill)
    {   for (;;)
        {   newtime = thetime();
            if (newtime >= waittill)
            {   break;
            }
            Delay(1);
    }   }
    else
    {   waittill = newtime;
    }
    waittill += (interval * 100) / speedupnum[speedup];
}

MODULE void printusage(STRPTR progname)
{   printf
    (   "Usage: %s\n"
        "[ATOMICS     <number>]\n"
        "[BOMBS       <number>]\n"
        "[BOUNDARY    ABYSS|RUBBER|STONE|TWILIGHT]\n"
        "[CANNONS     <number>]\n"
        "[DAMAGE      <number>]\n"
        "[ENERGY      <number>]\n"
        "[FORCE       <number>]\n"
        "[GFXWIDTH    <number>]\n"
        "[GFXHEIGHT   <number>]\n"
        "[INTERVAL    <number>]\n"
        "[MASS        <number>]\n"
        "[MISSILES    <number>]\n"
        "[PRI         <priority>]\n"
        "[PUBSCREEN   <screen>]\n"
        "[SHIELDS     <number>]\n"
        "[SOUND       ON|OFF]\n"
        "[TURBO       ON|OFF]\n"
        "[WORLDWIDTH  <number>]\n"
        "[WORLDHEIGHT <number>]\n"
        "[<filename1>..<filename8>]\n"
        , progname
    );

    cleanexit(EXIT_FAILURE);
}

EXPORT void garbled(UNUSED int robot, int errornum)
{   PERSIST TEXT extrastring[256];

    sprintf(extrastring, "Simulator: Error %d", errornum);
    rq(extrastring);
}

EXPORT void Line(int x1, int y1, int x2, int y2)
{   int    dx,      // deltas
           dy,
           dx2,     // scaled deltas
           dy2,
           ix,      // increase rate on the x axis
           iy,      // increase rate on the y axis
           err,     // the error term
           i;       // looping variable
    UBYTE* ptr_vid;

    ptr_vid = &display[(y1 * battle.width) + x1]; // identify the first pixel

    // difference between starting and ending points
    dx = x2 - x1;
    dy = y2 - y1;

    // calculate direction of the vector and store in ix and iy
    if (dx >= 0)
    {   ix =  1;
    } elif (dx < 0)
    {   dx = -dx;
        ix = -1;
    } else
    {   ix = 0;
    }

    if (dy >= 0)
    {   iy = battle.width;
    } elif (dy < 0)
    {   dy = -dy;
        iy = -battle.width;
    } else
    {   iy = 0;
    }

    // scale deltas and store in dx2 and dy2
    dx2 = dx * 2;
    dy2 = dy * 2;

    if (dx > dy) // dx is the major axis
    {   // initialize the error term
        err = dy2 - dx;

        for (i = 0; i <= dx; i++)
        {   if (valid(x1, y1))
            {   *ptr_vid = (UBYTE) pens[WHITE];
            }
            if (err >= 0)
            {   err -= dx2;
                ptr_vid += iy;
                y1 += (iy / battle.width);
            }
            err += dy2;
            ptr_vid += ix;
            x1 += ix;
    }   }
    else // dy is the major axis
    {   // initialize the error term
        err = dx2 - dy;

        for (i = 0; i <= dy; i++)
        {   if (valid(x1, y1))
            {   *ptr_vid = (UBYTE) pens[WHITE];
            }
            if (err >= 0)
            {   err -= dy2;
                ptr_vid += ix;
                x1 += ix;
            }
            err += dx2;
            ptr_vid += iy;
            y1 += (iy / battle.width);
}   }   }

MODULE int register_program(struct Task* processid)
{   int robot;

    for (robot = 0; robot < ROBOTS; robot++)
    {   if (!player[robot].alive)
        {   initrobot(robot);
            player[robot].position[X_AXIS] = (float) (goodrand() % (int) (config.field[X_AXIS]));
            player[robot].position[Y_AXIS] = (float) (goodrand() % (int) (config.field[Y_AXIS]));
            player[robot].processid        = processid;
            player[robot].theirwindow      = 0;
            player[robot].pain             = 0;

            // maybe we should pend (defer) some of this work
            // until after we have ReplyMsg()'d.

            strcpy(player[robot].name, RobotName[robot]);
            updatename(robot);

            play_sample(FX_BORN);

            enable(GID_ST1  + robot);
            enable(GID_ST1  + robot);
            enable(GID_ST9  + robot);
            enable(GID_ST17 + robot);
            enable(GID_ST25 + robot);
            enable(GID_IN1  + robot);
            enable(GID_IN9  + robot);
            enable(GID_IN17 + robot);
            enable(GID_IN25 + robot);
            enable(GID_IN33 + robot);
            enable(GID_IN41 + robot);
            enable(GID_IN49 + robot);
            enable(GID_IN57 + robot);
            enable(GID_IN65 + robot);
            enable(GID_IN73 + robot);
            enable(GID_IN81 + robot);
            enable(GID_IN89 + robot);

            return robot;
    }   }

    return -1;
}

MODULE void lockscreen(void)
{   if (screenname[0])
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) screenname)))
        {   rq("Can't lock specified public screen!");
    }   }
    else
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) NULL)))
        {   rq("Can't lock default public screen!");
}   }   }
MODULE void unlockscreen(void)
{   if (ScreenPtr)
    {   if (screenname[0])
        {   UnlockPubScreen(screenname, ScreenPtr);
            ScreenPtr = NULL;
        } else
        {   UnlockPubScreen(NULL, ScreenPtr);
            ScreenPtr = NULL;
}   }   }

EXPORT void rq(STRPTR text)
{   unlockscreen(); // harmless even if already unlocked

    EasyStruct.es_TextFormat   = text;
    EasyStruct.es_Title        = (STRPTR) "Fatal Error";
    EasyStruct.es_GadgetFormat = (STRPTR) "Quit"       ;
    DISCARD easyrequest();

    cleanexit(EXIT_FAILURE);
}

MODULE void say(STRPTR text)
{   EasyStruct.es_TextFormat   = text;
    EasyStruct.es_Title        = (STRPTR) "Error";
    EasyStruct.es_GadgetFormat = (STRPTR) "OK";
    DISCARD easyrequest();
}

MODULE LONG easyrequest(void)
{   LONG rc;

    if (MainWindowPtr)
    {   rc = EasyRequest(MainWindowPtr, &EasyStruct, NULL);
    } else // no main window open
    {   rc = EasyRequest(NULL,          &EasyStruct, NULL);
    }

    return rc;
}

MODULE void clearmsgs(void)
{   struct Message* MsgPtr; // really an IntuiMessage

    if (!MainWindowPtr)
    {   return; // important!
    }

    ModifyIDCMP(MainWindowPtr, 0);
    while ((MsgPtr = GetMsg(MainWindowPtr->UserPort)))
    {   ReplyMsg(MsgPtr);
}   }

MODULE void iconify(void)
{   struct AppMessage*     AppMsg;
    struct WBArg*          ArgPtr;
#ifdef __amigaos4__
    struct ApplicationMsg* AppLibMsg;
    ULONG                  msgtype,
                           msgval;
#endif

    if (!MainWindowPtr)
    {   return;
    }

    if (AboutWindowPtr)
    {   DisposeObject(AboutWinObject);
        AboutWinObject = NULL;
        AboutWindowPtr = NULL;
        reopen_about = TRUE;
    }
    if (SpeedWindowPtr)
    {   DisposeObject(SpeedWinObject);
        SpeedWinObject = NULL;
        SpeedWindowPtr = NULL;
        reopen_speed = TRUE;
    }

    DISCARD RA_Iconify(WinObject);
    // the WinObject must stay a valid pointer
    MainWindowPtr = NULL;
    // freepens();

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    do
    {   if (Wait
        (   AppSignal // *NOT* MainSignal!
          | AppLibSignal // *NOT* MainSignal!
          | SIGBREAKF_CTRL_C
        ) & SIGBREAKF_CTRL_C)
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((AppMsg = (struct AppMessage*) GetMsg(AppPort)))
        {   switch (AppMsg->am_Type)
            {
            case AMTYPE_APPICON:
                /* Get a pointer to the start of the Workbench
                 * argument list.

                 * The lock will be on the directory in
                 * which the file resides. If there is no
                 * filename, either a volume or window was
                 * dropped on us. */

                ArgPtr = AppMsg->am_ArgList;
                if
                (   AppMsg->am_NumArgs == 1
                 && ArgPtr->wa_Name[0]
                 && ArgPtr->wa_Lock
                 && NameFromLock(ArgPtr->wa_Lock, fn_robot[0], MAX_PATH)
                 && AddPart(fn_robot[0], ArgPtr->wa_Name, MAX_PATH)
                )
                {   if (load_robot(fn_robot[0]))
                    {   uniconify(); // we just do this as a courtesy
                    } else
                    {   DisplayBeep(NULL);
                    }
                } else
                {   uniconify();
            }   }
            ReplyMsg((struct Message*) AppMsg);
            // We should reply quicker than this!
            // (Ideally, copy the fields we need, then reply to the message.)
        }

#ifdef __amigaos4__
        if (AppLibPort)
        {   while ((AppLibMsg = (struct ApplicationMsg*) GetMsg(AppLibPort)))
            {   msgtype = AppLibMsg->type;
                msgval  = (ULONG) ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName;
                ReplyMsg((struct Message*) AppLibMsg);

                switch (msgtype)
                {
                case APPLIBMT_Quit:
                case APPLIBMT_ForceQuit:
                    cleanexit(EXIT_SUCCESS);
                acase APPLIBMT_Unhide:
                    uniconify();
                acase APPLIBMT_ToFront:
                    uniconify();
                    lockscreen();
                    ScreenToFront(ScreenPtr);
                    unlockscreen();
                    // assert(MainWindowPtr);
                    WindowToFront(MainWindowPtr);
                    ActivateWindow(MainWindowPtr);
                acase APPLIBMT_OpenDoc:
                    strcpy(fn_robot[0], ((struct ApplicationOpenPrintDocMsg*) AppMsg)->fileName);
                    if (load_robot(fn_robot[0]))
                    {   uniconify();
                    } else
                    {   DisplayBeep(NULL);
        }   }   }   }
#endif

    } while (!MainWindowPtr);
}
MODULE void uniconify(void)
{   // assert(!MainWindowPtr);

    // getpens();
    // make_stars();
    // setup_backdrop();

    if (!(MainWindowPtr = (struct Window*) RA_Uniconify(WinObject)))
    {   rq("Can't open window!");
    }
    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    rethinkrobots();

    if (reopen_about)
    {   reopen_about = FALSE;
        help_about();
    }
    if (reopen_speed)
    {   reopen_speed = FALSE;
        open_speed();
    }
    ActivateWindow(MainWindowPtr);

    if (paused)
    {   updatescreen();
}   }

EXPORT void remove_player(int robot, FLAG playsound)
{   FLAG         found;
    struct Node* NodePtr;

    // assert(player[robot].alive);

#ifdef LOGTASKS
    printf("Simulator: Killing robot #%d at address $%X.\n", robot, (int) player[robot].processid);
#endif

    if (morphos)
    {   found = TRUE;
    } else
    {   found = FALSE;
        Forbid();

        for
        (   NodePtr = GetHead(&(SysBase->TaskReady));
#ifdef __amigaos4__
            NodePtr != NULL;
/* "Note when using these functions, don't check for currentNode->ln_Succ,
   just check currentNode != NULL." - exec.library/GetSucc() autodoc in
   OS4 SDK. */
#else
            GetSucc((struct Node*) NodePtr);
#endif
            NodePtr = GetSucc((struct Node*) NodePtr)
        )
        {   if (NodePtr == (struct Node*) player[robot].processid)
            {   found = TRUE;
                break;
        }   }

        if (!found)
        {   for
            (   NodePtr = GetHead(&(SysBase->TaskReady));
#ifdef __amigaos4__
                NodePtr != NULL;
/* "Note when using these functions, don't check for currentNode->ln_Succ,
   just check currentNode != NULL." - exec.library/GetSucc() autodoc in
   OS4 SDK. */
#else
                GetSucc((struct Node*) NodePtr);
#endif
                NodePtr = GetSucc((struct Node*) NodePtr)
            )
            {   if (NodePtr == (struct Node*) player[robot].processid)
                {   found = TRUE;
                    break;
    }   }   }   }

    if (found)
    {   DeleteMsgPort(ReplyPortPtr[robot]);
        RemTask(player[robot].processid);
    }

    if (!morphos)
    {   Permit();
    }

#ifdef LOGTASKS
    if (found)
    {   printf("Simulator: Killed it.\n");
    } else
    {   printf("Simulator: Couldn't find it.\n");
    }
#endif

    player[robot].window = NULL;
    player[robot].alive = FALSE;
    if (playsound)
    {   play_sample(FX_DIE);
    }

    updateinteger(GID_IN49 + robot, (int) player[robot].damage);
    disable(GID_ST1  + robot);
    disable(GID_ST9  + robot);
    disable(GID_ST17 + robot);
    disable(GID_ST25 + robot);
    disable(GID_IN1  + robot);
    disable(GID_IN9  + robot);
    disable(GID_IN17 + robot);
    disable(GID_IN25 + robot);
    disable(GID_IN33 + robot);
    disable(GID_IN41 + robot);
    disable(GID_IN49 + robot);
    disable(GID_IN57 + robot);
    disable(GID_IN65 + robot);
    disable(GID_IN73 + robot);
    disable(GID_IN81 + robot);
    disable(GID_IN89 + robot);
}

MODULE void disable(int gid)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        GA_Disabled, TRUE,
    TAG_DONE);
    RefreshPageGadget((struct Gadget*) gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL);
}
MODULE void enable(int gid)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        GA_Disabled, FALSE,
    TAG_DONE);
    RefreshPageGadget((struct Gadget*) gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL);
}

MODULE void make_buffer(void)
{   display = malloc(battle.width * battle.height * sizeof(UBYTE));

    // assert(MainWindowPtr);

    InitRastPort(&wpa8rastport);

    if (!(wpa8bitmap = AllocBitMap
    (   battle.width,
        battle.height,
        8,
        0,
        MainWindowPtr->RPort->BitMap // NULL for Frodo! (doesn't seem to matter)
    )))
    {   rq((STRPTR) "AllocBitMap() failed!");
    }

    wpa8rastport.BitMap = wpa8bitmap;

    stars = malloc(battle.width * battle.height * sizeof(UBYTE));
    make_stars();
    setup_backdrop();
}

MODULE void destroy_buffer(void)
{   if (wpa8bitmap)
    {   FreeBitMap(wpa8bitmap);
        wpa8bitmap = NULL;
    }

    if (display)
    {   free(display);
        display = NULL;
    }

    if (stars)
    {   free(stars);
        stars = NULL;
}   }

MODULE void getpens(void)
{   TRANSIENT       int   i;
    TRANSIENT       ULONG red,
                          green,
                          blue;
    PERSIST   const struct
{   ULONG red,
          green,
          blue;
} colours[8] = {
  { 0x40404040, 0x40404040, 0xFFFFFFFF }, // # 0: blue
  { 0xFFFFFFFF, 0x40404040, 0x40404040 }, // # 1: red
  { 0x40404040, 0xFFFFFFFF, 0x40404040 }, // # 2: green
  { 0xFFFFFFFF, 0xFFFFFFFF, 0x40404040 }, // # 3: yellow
  { 0xFFFFFFFF, 0x80808080, 0x40404040 }, // # 4: orange
  { 0xFFFFFFFF, 0x40404040, 0xFFFFFFFF }, // # 5: purple
  { 0x40404040, 0xFFFFFFFF, 0xFFFFFFFF }, // # 6: cyan
  { 0xFFFFFFFF, 0x80808080, 0x80808080 }, // # 7: pink
};
//  0.. 7 are robot colours
//  8..23 are greyscale

    lockscreen();

    for (i = 0; i < PENS; i++)
    {   // assert(!gotpen[i]);

        if (i < 8)
        {   red   = colours[i].red;
            green = colours[i].green;
            blue  = colours[i].blue;
        } else
        {   red   =
            green =
            blue  = 0x11111111 * (((ULONG) i) - 8);
        }
        pens[i] = (LONG) ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            (ULONG) -1,
            red,
            green,
            blue,
            PEN_EXCLUSIVE | PEN_NO_SETCOLOR
        );
        // it doesn't seem to actually get these exclusively
        // eg. it will work in a 2-colour (monochrome) host screenmode!
        if (pens[i] == -1)
        {   pens[i] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                red,
                green,
                blue,
                -1
            );

#ifdef VERBOSE
            zprintf("Sharing pen %d for guest colour %d.\n", pens[i], i);
#endif
            // For some reason, ObtainPen() doesn't work on our own screen.
        } else
        {   gotpen[i] = TRUE;
            SetRGB32
            (   &ScreenPtr->ViewPort,
                (ULONG) pens[i],
                red,
                green,
                blue
            );
#ifdef VERBOSE
            zprintf("Allocated pen %d exclusively for guest colour %d.\n", pens[i], i);
#endif
        }

        // assert(pens[i] >=   0);
        // assert(pens[i] <= 255);
    }

    unlockscreen();
}

MODULE void freepens(void)
{   int i;

    lockscreen();

    for (i = 0; i < PENS; i++)
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
    }   }

    unlockscreen();
}

EXPORT ULONG goodrand(void)
{   PERSIST ULONG seconds, micros; // PERSISTent for speed

    // SAS/C rand() is shithouse and never returns certain numbers, so
    // we adjust the value with the timer to increase the randomness
    // (otherwise endless loops can happen).

    CurrentTime(&seconds, &micros);
    return (ULONG) (rand() + (micros - seconds) * micros);
}

EXPORT void updateinteger(int gid, int number)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        INTEGER_Number, number,
    TAG_DONE); // this autorefreshes?

}
EXPORT void updatestring(int gid)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[gid], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        STRINGA_TextVal, output_buffer,
    TAG_DONE); // this autorefreshes
}
EXPORT void updatename(int whichrobot)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[GID_ST1 + whichrobot], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        STRINGA_TextVal, player[whichrobot].name,
    TAG_DONE); // this autorefreshes
}
EXPORT void updatemessage(int whichrobot)
{   DISCARD SetPageGadgetAttrs
    (   gadgets[GID_ST9 + whichrobot], (Object*) gadgets[GID_PA1], MainWindowPtr, NULL,
        STRINGA_TextVal, player[whichrobot].message,
    TAG_DONE); // this autorefreshes
}

MODULE FLAG load_robot(STRPTR pathname)
{   DISCARD SystemTags
    (   (CONST_STRPTR) pathname,
        SYS_Asynch, TRUE,
        SYS_Input,  NULL,
        SYS_Output, NULL,
    TAG_DONE);

    return TRUE;
}

MODULE void load_samples(void)
{   UBYTE*        p8data;
    TEXT          saystring[80 + 1];
    SBYTE         code = 0, i,
                  iobuffer[8]; /* buffer for 8SVX.VHDR  */
    SBYTE*        psample[2];  /* sample pointers */
    struct Chunk* p8Chunk;     /* pointers for 8SVX parsing */
    Voice8Header* pVoice8Header = NULL; // only set to NULL to avoid spurious warnings
    ULONG         rd8count;
    BPTR          FilePtr;
    UBYTE*        fbase         = NULL;
    ULONG         fsize         = 0;    // initialized to avoid spurious SAS/C compiler warnings
    PERSIST const STRPTR sfxerror[] =
{   (STRPTR) "No errors.",
    (STRPTR) "Can't open file!",
    (STRPTR) "Can't read file!",
    (STRPTR) "Not an IFF 8SVX; too short!",
    (STRPTR) "Not an IFF FORM!",
    (STRPTR) "No memory for read!",
    (STRPTR) "Read error!",
    (STRPTR) "Malformed IFF; too short!",
    (STRPTR) "Not an IFF 8SVX!",
    (STRPTR) "No chip memory!"
}, filename[SAMPLES] =
{   (STRPTR) "PROGDIR:sounds/atomic.8svx",
    (STRPTR) "PROGDIR:sounds/bomb.8svx",
    (STRPTR) "PROGDIR:sounds/cannon.8svx",
    (STRPTR) "PROGDIR:sounds/missile.8svx",
    (STRPTR) "PROGDIR:sounds/fire.8svx",
    (STRPTR) "PROGDIR:sounds/born.8svx",
    (STRPTR) "PROGDIR:sounds/die.8svx",
    (STRPTR) "PROGDIR:sounds/amigan.8svx",
    (STRPTR) "PROGDIR:sounds/bounce.8svx",
};

    for (i = 0; i < SAMPLES; i++)
    {   samp[i].base = NULL;
    }

    for (i = 0; i < SAMPLES; i++)
    {   if (!(FilePtr = Open((CONST_STRPTR) filename[i], MODE_OLDFILE)))
        {   code = 1;                               /* can't open file */
        } else
        {   rd8count = (ULONG) Read(FilePtr, iobuffer, 8);
            if (rd8count == (ULONG) -1)
                code = 2;                           /* can't read file */
            elif (rd8count < 8)
                code = 3;                           /* not an IFF 8SVX; too short */
            else
            {   p8Chunk = (struct Chunk*) iobuffer;
                if (p8Chunk->ckID != ID_FORM)
                    code = 4;                       /* not an IFF FORM */
                elif (!(fbase = (UBYTE*) AllocMem(fsize = (ULONG) p8Chunk->ckSize, MEMF_PUBLIC | MEMF_CLEAR)))
                    code = 5;                       /* no memory for read */
                else
                {   p8data = fbase;
                    rd8count = Read(FilePtr, p8data, p8Chunk->ckSize);
                    if (rd8count == (ULONG)-1)
                        code = 6;                   /* read error */
                    elif (rd8count < (ULONG) p8Chunk->ckSize)
                        code = 7;                   /* malformed IFF; too short */
                    elif (MAKE_ID(*p8data, *(p8data + 1), *(p8data + 2), *(p8data + 3)) != ID_8SVX)
                        code = 8;                   /* not an IFF 8SVX */
                    else
                    {   p8data = p8data + 4;
                        while (p8data < fbase + fsize)
                        {   p8Chunk = (struct Chunk*) p8data;
                            switch (p8Chunk->ckID)
                            {
                            case ID_VHDR:
                                pVoice8Header     = (Voice8Header*) (p8data + 8L);
                            acase ID_BODY:
                                psample[0]        = (SBYTE*) (p8data + 8);
                                psample[1]        = psample[0] + pVoice8Header->oneShotHiSamples;
                                samp[i].length[0] = (ULONG) pVoice8Header->oneShotHiSamples;
                                samp[i].length[1] = (ULONG) pVoice8Header->repeatHiSamples;

                                /* To grab the volume level from the IFF
                                8SVX file itself, add this line here:

                                samp[i].volume    = (SBYTE) (pVoice8Header->volume / 156); */
                            }
                            p8data += 8 + p8Chunk->ckSize;
                            if ((p8Chunk->ckSize & 1) == 1)
                                p8data++;
                        }
                        if (samp[i].length[0] == 0)
                            samp[i].bank = 1;
                        else samp[i].bank = 0;
                        if (samp[i].length[samp[i].bank] <= 102400)
                            samp[i].size = samp[i].length[samp[i].bank];
                        else samp[i].size = 102400;
                        samp[i].base = (UBYTE*) AllocMem(samp[i].size, MEMF_CHIP | MEMF_CLEAR);
                        if (!samp[i].base)
                            code = 9; /* no chip memory */
                        else
                        {   CopyMem(psample[samp[i].bank], samp[i].base, samp[i].size);
                            psample[samp[i].bank] += samp[i].size;
                            if (GfxBase->DisplayFlags & PAL) // PAL clock
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
        {   if (fbase)
            {   FreeMem(fbase, fsize);
                // fbase = NULL;
            }
            if (FilePtr)
            {   DISCARD Close(FilePtr);
                // FilePtr = NULL;
            }
            freefx();
            strcpy((char*) saystring, (char*) filename[i]);
            strcat((char*) saystring, ": ");
            strcat((char*) saystring, (char*) sfxerror[code]);
            rq(saystring);
}   }   }

EXPORT void play_sample(int which)
{   TRANSIENT SBYTE i;
    TRANSIENT SBYTE ok            = -1;
    TRANSIENT ULONG oldestreceipt = (ULONG) -1;
    PERSIST   ULONG nextreceipt   = 1;

    /* oldestreceipt = temporary variable for ascertaining oldest
                       sound still playing.
    nextreceipt = next unused receipt number (monotonically incrementing). */

    if (!sound)
    {   return;
    }

    /* decide on a channel */
    for (i = 0; i <= 3; i++)
    {   if (ok == -1)
        {   if (!eversent[i])
            {   ok = i;
            } elif (CheckIO((struct IORequest*) AudioRqPtr[i]))
            {   WaitIO((struct IORequest*) AudioRqPtr[i]);
                ok = i;
    }   }   }
    if (ok == -1)
    {   for (i = 0; i <= 3; i++)
        {   if (receipter[i] < oldestreceipt)
            {   ok = i;
                oldestreceipt = receipter[i];
        }   }
        AbortIO((struct IORequest*) AudioRqPtr[ok]);
        WaitIO((struct IORequest*) AudioRqPtr[ok]);
    }

    eversent[ok]  = TRUE;
    receipter[ok] = nextreceipt;

    AudioRqPtr[ok]->ioa_Cycles              = 1;
    AudioRqPtr[ok]->ioa_Request.io_Command  = CMD_WRITE;
    AudioRqPtr[ok]->ioa_Request.io_Flags    = ADIOF_PERVOL;
    AudioRqPtr[ok]->ioa_Request.io_Unit     = (struct Unit*) (1 << ok);
    AudioRqPtr[ok]->ioa_Volume              = 64;
    AudioRqPtr[ok]->ioa_Period              = (UWORD) samp[which].speed;
    AudioRqPtr[ok]->ioa_Request.io_Message.mn_ReplyPort
                                            = AudioPortPtr[ok];
    AudioRqPtr[ok]->ioa_Data                = (UBYTE*) samp[which].base;
    AudioRqPtr[ok]->ioa_Length              = samp[which].length[samp[which].bank];
    BeginIO((struct IORequest*) AudioRqPtr[ok]);
}

MODULE void freefx(void)
{   int i;

    stop_sounds();
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
    for (i = 0; i < SAMPLES; i++)
    {   if (samp[i].base)
        {   FreeMem(samp[i].base, samp[i].size);
            samp[i].base = NULL;
    }   }

    soundopen = FALSE;
}

EXPORT void start_sounds(void)
{   TRANSIENT int   i;
    PERSIST   UBYTE chan[] = {15, 10, 5};

    if (soundopen)
    {   return;
    } // implied else

    load_samples();

    for (i = 0; i <= 3; i++)
    {   eversent[i] = FALSE;
        if (!(AudioPortPtr[i] = (struct MsgPort*) CreateMsgPort()))
        {   freefx();
            say((STRPTR) "No port for effects!");
            sound = FALSE;
            if (MainWindowPtr)
            {   updateticks();
            }
            return;
        } // implied else
        if (!(AudioRqPtr[i] = (struct IOAudio*) CreateIORequest(AudioPortPtr[i], sizeof(struct IOAudio))))
        {   freefx();
            say((STRPTR) "No I/O memory for effects!");
            sound = FALSE;
            if (MainWindowPtr)
            {   updateticks();
            }
            return;
    }   }
    AudioRqPtr[0]->ioa_Request.io_Message.mn_ReplyPort      = AudioPortPtr[0];
    AudioRqPtr[0]->ioa_Request.io_Message.mn_Node.ln_Pri    = 127;
    AudioRqPtr[0]->ioa_AllocKey                             = 0;
    AudioRqPtr[0]->ioa_Data                                 = chan;
    AudioRqPtr[0]->ioa_Length                               = 3;
    if ((AudioClosed = (FLAG) OpenDevice(AUDIONAME, 0, (struct IORequest*) AudioRqPtr[0], 0)))
    {   freefx();
        say((STRPTR) "Can't allocate all channels for effects!");
        sound = FALSE;
        if (MainWindowPtr)
        {   updateticks();
        }
        return;
    } // implied else
    for (i = 1; i <= 3; i++)
    {   CopyMem(AudioRqPtr[0], AudioRqPtr[i], sizeof(struct IOAudio));
    }

    soundopen = TRUE;
}

EXPORT void stop_sounds(void)
{   int i;

    for (i = 0; i <= 3; i++)
    {   if (eversent[i] && AudioRqPtr[i])
        {   AbortIO((struct IORequest*) AudioRqPtr[i]);
            WaitIO((struct IORequest*) AudioRqPtr[i]);
            eversent[i] = FALSE;
}   }   }

/* MODULE BOOL ClickTabNodes(struct List *list, UBYTE **labels)
{
	struct Node *node;
	WORD i = 0;

        NewList(list);

	while (*labels)
	{
		if (node = (struct Node*)AllocClickTabNode(
			TNA_Text, *labels,
			TNA_Number, i,
			TNA_Enabled, TRUE,
			TNA_Spacing, 6,
			TAG_DONE))
		{
			AddTail(list, node);
		}
		labels++;
		i++;
	}
	return(TRUE);
} */

MODULE void ct_makelist(struct List* ListPtr, const STRPTR* NamesArray, int elements)
{   int          i;
    struct Node* ClickTabNodePtr;

    NewList(ListPtr);
    for (i = 0; i < elements; i++)
    {   if (!(ClickTabNodePtr = (struct Node*) AllocClickTabNode
        (   TNA_Text,   NamesArray[i],
            TNA_Number, i,
        TAG_END)))
        {   rq("Can't create ReAction clicktab.gadget node(s)!");
        }
        AddTail(ListPtr, ClickTabNodePtr); // AddTail() has no return code
}   }
MODULE void ct_clearlist(struct List* ListPtr)
{   struct Node *NodePtr,
                *NextNodePtr;

    /* Requirements: clicktab.gadget must be already open, and list
    must be detached from gadget. List may be empty or non-empty, and
    may be single- or multi-columnar. */

    if (ListIsFull(ListPtr))
    {
#ifdef __amigaos4__
        for (NodePtr = GetHead(ListPtr); NodePtr != NULL; NodePtr = NextNodePtr)
        {   NextNodePtr = GetSucc(NodePtr);
            FreeClickTabNode(NodePtr);
        }
#else
        NodePtr = GetHead(ListPtr);
        while ((NextNodePtr = GetSucc(NodePtr)))
        {   FreeClickTabNode(NodePtr);
            NodePtr = NextNodePtr;
        }
#endif
    }

    NewList(ListPtr); // prepare for reuse
}

MODULE void make_stars(void)
{   int i, j,
        xy;

    for (xy = 0; xy < battle.width * battle.height; xy++)
    {   stars[xy] = (UBYTE) pens[BLACK];
    }

    j = (battle.width * battle.height) / STARDENSITY;
    for (i = 0; i < j; i++)
    {   xy = goodrand() % (battle.width * battle.height);
        stars[xy] = (UBYTE) pens[goodrand() % 8]; // pens[0..7]
}   }

EXPORT void page_left(void)
{   if (functab > 0)
    {   functab--;

        DISCARD SetGadgetAttrs
        (   gadgets[GID_CT1],
            MainWindowPtr,    NULL,
            CLICKTAB_Current, functab,
        TAG_DONE);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_PA1],
            MainWindowPtr,    NULL,
            PAGE_Current,     functab,
        TAG_DONE);

        rethinkrobots();
        if (paused)
        {   updatescreen();
}   }   }

EXPORT void page_right(void)
{   if (functab < (lame ? (4 - 1) : (2 - 1)))
    {   functab++;

        DISCARD SetGadgetAttrs
        (   gadgets[GID_CT1],
            MainWindowPtr,    NULL,
            CLICKTAB_Current, functab,
        TAG_DONE);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_PA1],
            MainWindowPtr,    NULL,
            PAGE_Current,     functab,
        TAG_DONE);

        rethinkrobots();
        if (paused)
        {   updatescreen();
}   }   }

MODULE void handlemenus(UWORD code)
{   struct MenuItem* ItemPtr;

    if (code != MENUNULL) /* while (code != MENUNULL) */
    {   ItemPtr = ItemAddress(MenuPtr, code);
        switch (MENUNUM(code))
        {
        case MN_PROJECT:
            switch (ITEMNUM(code))
            {
            case IN_OPEN:
                file_open();
            acase IN_ICONIFY:
                iconify();
            acase IN_QUIT:
                cleanexit(EXIT_SUCCESS);
            }
        acase MN_TOOLS:
            switch (ITEMNUM(code))
            {
            case IN_ENERGIZE:
                energize();
            acase IN_HEAL:
                heal();
            acase IN_REARM:
                rearm();
            acase IN_REPOSITION:
                reposition();
            }
        acase MN_SETTINGS:
            switch (ITEMNUM(code))
            {
            case IN_PAUSED:
                paused     = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                updateticks();
            acase IN_TURBO:
                turbo      = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                updateticks();
            acase IN_SPEED:
                open_speed();
            acase IN_SOUND:
                sound      = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                if (sound)
                {   start_sounds();
                } else
                {   stop_sounds();
                }
                updateticks();
            acase IN_STARFIELD:
                show_stars = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                updateticks();
            }
        acase MN_HELP:
            switch (ITEMNUM(code))
            {
            case IN_MANUAL:
                help_manual();
            acase IN_ABOUT:
                help_about();
        }   }
        /* Doing things the above way disables multi-selection,
        but prevents `endless selection'.
        code = ItemPtr->NextSelect; */
}   }

MODULE void help_manual(void)
{   TRANSIENT BPTR                 OldDir;
    PERSIST   struct NewAmigaGuide nag =
    {   ZERO,                        // nag_Lock
        "PROGDIR:CodeWar.guide",     // nag_Name
        NULL,                        // nag_Screen
        NULL,                        // nag_PubScreen
        NULL,                        // nag_HostPort
        NULL,                        // nag_ClientPort
        NULL,                        // nag_BaseName
        0,                           // nag_Flags
        NULL,                        // nag_Context
        NULL,                        // nag_Node
        0,                           // nag_Line
        NULL,                        // nag_Extens
        NULL                         // nag_Client
    };

    if (morphos)
    {   /* MorphOS OpenWorkbenchObject() function is a non-functional
           dummy; therefore we use OpenAmigaGuide() when running under
           MorphOS. */

        if (!AmigaGuideBase)
        {   return;
        }

        nag.nag_Node = NULL;
        lockscreen();
        nag.nag_Screen = ScreenPtr;
        DISCARD OpenAmigaGuide(&nag, TAG_DONE);
        unlockscreen();
    } else
    {   OldDir = CurrentDir(ProgLock);
        DISCARD OpenWorkbenchObject
        (   "CodeWar.guide",
            WBOPENA_ArgLock, ProgLock,
            WBOPENA_ArgName, "CodeWar.guide",
        TAG_DONE);
        DISCARD CurrentDir(OldDir);
}   }

MODULE void help_about(void)
{   TRANSIENT SBYTE           OldPri;
    PERSIST   FLAG            first = TRUE;
    PERSIST   TEXT            prioritystr[4 + 1], // "-128"
                              processstr[11 + 1], // "-1222333444"
                              wbstr[20 + 1];
    PERSIST   struct Process* ProcessPtr;
    PERSIST   STRPTR          compiledfor,
                              compiledwith;

    if (AboutWindowPtr)
    {   return;
    }

    if (first)
    {   load_images(0, 1, FALSE);

        ProcessPtr = (APTR) FindTask(NULL);
#ifdef __amigaos4__
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_CliNum));
#else
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_TaskNum));
#endif

#ifdef __MORPHOS__
    #ifdef __VBCC__
        compiledwith = "VBCC";
    #else
        compiledwith = "GCC";
    #endif
        compiledfor  = "MorphOS PPC";
#else
    #ifdef __amigaos4__
        compiledwith = "GCC";
        compiledfor  = "AmigaOS 4 PPC";
    #else
        #ifdef __SASC
            compiledwith = "SAS/C 6.59";
        #else
            compiledwith = "?";
        #endif
        compiledfor = "AmigaOS 3 68K";
    #endif
#endif

        switch (wbver)
        {
        case 45:
            strcpy(wbstr, "OS3.9+BB");
            switch (wbrev)
            {
            case 1:
                strcat(wbstr, "0"); // should never happen (as we require BB2+)
            acase 2:
                strcat(wbstr, "1"); // should never happen (as we require BB2+)
            acase 3:
                strcat(wbstr, "2");
            acase 4:
                strcat(wbstr, "3");
            acase 5:
                strcat(wbstr, "4");
            adefault:
                strcat(wbstr, "?");
            }
        acase 50:
            {   struct Resident* rt = FindResident("MorphOS");

                sprintf(wbstr, "MorphOS %d", rt->rt_Version);
            }
        acase 51:
        case 52: // guess
            strcpy(wbstr, "OS4.0");
        acase 53:
            strcpy(wbstr, "OS4.1");
            switch (wbrev)
            {
            case 14:
                strcat(wbstr, "FE");
            acase 15:
                strcat(wbstr, "FEu1");
            adefault:
                if (wbrev >= 16)
                {   strcat(wbstr, "FEu?");
            }   }
        acase 54:
            strcpy(wbstr, "OS4.2?");
        adefault:
            strcpy(wbstr, "?");
        }

        first = FALSE;
    }

    // we reread the priority each time in case it has been changed in
    // the meantime
    OldPri = SetTaskPri((struct Task*) ProcessPtr, 0);
    if (OldPri != 0) // so as not to needlessly call SetTaskPri() again
    {   DISCARD SetTaskPri((struct Task*) ProcessPtr, OldPri);
    }
    DISCARD sprintf(prioritystr, "%d", (int) OldPri);

    lockscreen();
    if (!(AboutWinObject =
    WindowObject,
        WA_PubScreen,                              ScreenPtr,
        WA_ScreenTitle,                            "CodeWar " DECIMALVERSION,
        WA_Title,                                  "About CodeWar",
        WA_Activate,                               TRUE,
        WA_DepthGadget,                            TRUE,
        WA_DragBar,                                TRUE,
        WA_CloseGadget,                            TRUE,
        WINDOW_Position,                           WPOS_CENTERSCREEN,
        WINDOW_ParentGroup,
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            LAYOUT_DeferLayout,                    TRUE,
            AddLabel(" "),
            AddHLayout,
                AddSpace,
                AddVLayout,
                    AddSpace,
                    LAYOUT_AddImage,               image[BITMAP_AMIGAN],
                    CHILD_NoDispose,               TRUE,
                    CHILD_WeightedHeight,          0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,               0,
                AddLabel(" "),
                CHILD_WeightedWidth,               0,
                LAYOUT_AddImage,                   image[BITMAP_LOGO],
                CHILD_NoDispose,                   TRUE,
                CHILD_WeightedWidth,               0,
                AddSpace,
            LayoutEnd,
            AddLabel(" "),
            AddVLayout,
                LAYOUT_VertAlignment,              LALIGN_CENTER,
                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_AddImage,
                LabelObject,
                    LABEL_SoftStyle,               FSF_BOLD,
                    LABEL_Text,                    "CodeWar " DECIMALVERSION,
                LayoutEnd,
                CHILD_WeightedHeight,              0,
                AddLabel(RELEASEDATE),
                AddLabel(" "),
                AddLabel("A game for programmers"),
                AddLabel(COPYRIGHT),
                AddLabel(" "),
                AddHLayout,
                    AddVLayout,
                        LAYOUT_HorizAlignment,     LALIGN_CENTER,
                        AddLabel("Compiled for:"),
                        AddLabel("Compiled with:"),
                        AddLabel("Running on:"),
                        AddLabel("Priority:"),
                        AddLabel("Process number:"),
                        AddLabel("Public screen name:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,           50,
                    AddLabel(" "),
                    CHILD_WeightedWidth,           0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,     LALIGN_CENTER,
                        AddLabel(compiledfor),
                        AddLabel(compiledwith),
                        AddLabel(wbstr),
                        AddLabel(prioritystr),
                        AddLabel(processstr),
                        AddLabel(screenname),
                    LayoutEnd,
                    CHILD_WeightedWidth,           50,
                LayoutEnd,
                AddLabel(" "),
            LayoutEnd,
            LAYOUT_AddChild,                       gadgets[GID_BU1] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_BU1,
                GA_RelVerify,                      TRUE,
                GA_Text,                           "http://amigan.1emu.net/releases/",
                GA_Disabled,                       (!OpenURLBase && !urlopen),
            ButtonEnd,
            LAYOUT_AddChild,                       gadgets[GID_BU2] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_BU2,
                GA_RelVerify,                      TRUE,
                GA_Text,                           "mailto:amigansoftware@gmail.com",
                GA_Disabled,                       (!OpenURLBase && !urlopen),
            ButtonEnd,
        End,
    End))
    {   rq("Can't create ReAction objects!");
    }
    unlockscreen();

    if (!(AboutWindowPtr = (struct Window*) DoMethod((Object*) AboutWinObject, WM_OPEN, NULL)))
    {   rq("Can't open ReAction window!");
    }
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_ABOUT, NOSUB));
    LendMenus(AboutWindowPtr, MainWindowPtr);

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, AboutWinObject, &AboutSignal);

    play_sample(FX_AMIGAN);
}

MODULE void load_images(int thefirst, int thelast, FLAG splashing)
{   int  i;
    TEXT theimagename[MAX_PATH + 1];

    lockscreen();
    for (i = thefirst; i <= thelast; i++)
    {   if (!image[i])
        {   strcpy(theimagename, "PROGDIR:images/");
            strcat(theimagename, imagename[i]);
            strcat(theimagename, ".ilbm");
            if (!(image[i] =
            BitMapObject,
                BITMAP_SourceFile,                               theimagename,
                (i == BITMAP_LOGO) ? BITMAP_Width  : TAG_IGNORE, 353, // These *must* be given for
                (i == BITMAP_LOGO) ? BITMAP_Height : TAG_IGNORE,  48, // transparent IFFs
                // Ideally we wouldn't hardcode the width/height but instead read them from the file
                BITMAP_Screen,                                   ScreenPtr,
                BITMAP_Masking,                                  (i == BITMAP_LOGO) ? TRUE : FALSE,
                (lame && !morphos && i == BITMAP_LOGO) ? BITMAP_Transparent : TAG_IGNORE, TRUE,
            End))
            {   rq("Can't create ReAction image(s)!");
            }
            if (splashing)
            {   // assert(SplashWinObject);
                // assert(SplashWindowPtr);
                DISCARD SetGadgetAttrs
                (   gadgets[GID_FG1], SplashWindowPtr, NULL,
                    FUELGAUGE_Level, i - thefirst + 1,
                TAG_END); // this autorefreshes
    }   }   }
    unlockscreen();
}

MODULE void about_loop(void)
{   UWORD code;
    FLAG  aboutdone = FALSE;
    ULONG result;

    // Processes any messages for the About... window.

    if (!AboutWinObject)
    {   return;
    }

    while ((result = DoMethod(AboutWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_CLOSEWINDOW:
            aboutdone = TRUE;
        acase WMHI_RAWKEY:
            if (code < 128) // ie. key down not key up
            // it would be better if we could check that IEQUALIFIER_REPEAT is false
            {   aboutdone = TRUE;
            }
        acase WMHI_GADGETUP:
            switch (result & WMHI_GADGETMASK)
            {
            case GID_BU1:
                openurl("http://amigan.1emu.net/releases/");
            acase GID_BU2:
                openurl("mailto:amigansoftware@gmail.com");
    }   }   }

    if (aboutdone)
    {   close_about();
}   }

MODULE void close_about(void)
{   if (!AboutWinObject)
    {   return;
    }

    DisposeObject(AboutWinObject);
    AboutWindowPtr = NULL;
    AboutWinObject = NULL;
    AboutSignal    = 0;
    OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP    , IN_ABOUT, NOSUB));
}
MODULE void close_speed(void)
{   if (!SpeedWinObject)
    {   return;
    }

    DisposeObject(SpeedWinObject);
    SpeedWindowPtr = NULL;
    SpeedWinObject = NULL;
    SpeedSignal    = 0;
    OnMenu(MainWindowPtr, FULLMENUNUM(MN_SETTINGS, IN_SPEED, NOSUB));
}

MODULE void openurl(STRPTR command)
{   PERSIST       TEXT           localstring[80 + 1];
#ifndef __amigaos4__
    PERSIST const struct TagItem URLTags[1] = {{TAG_DONE, (ULONG) NULL}};
#endif

    // assert(OpenURLBase || urlopen);

    if (urlopen)
    {   strcpy(localstring, "URLOpen \"");
        strcat(localstring, command);
        strcat(localstring, "\"");
        DISCARD SystemTags
        (   localstring,
            SYS_Asynch, TRUE,
            SYS_Input,  NULL,
            SYS_Output, NULL,
        TAG_DONE);
    } else
    {
#ifdef __amigaos4__
        DISCARD URL_Open(command, TAG_DONE);
#else
        DISCARD URL_OpenA(command, (struct TagItem*) URLTags);
#endif
}   }

MODULE FLAG Exists(STRPTR name)
{   struct Process* self = (APTR) FindTask(NULL);
    APTR            oldwinptr;
    BPTR            lock;

    oldwinptr = self->pr_WindowPtr;
    self->pr_WindowPtr = (APTR) -1;

    lock = Lock(name, MODE_OLDFILE);

    self->pr_WindowPtr = oldwinptr;

    if (lock)
    {   UnLock(lock);
        return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void rethinkrobots(void)
{   int i,
        firstrobot,
        lastrobot;

    DISCARD RethinkLayout(gadgets[GID_LY1], MainWindowPtr, NULL, TRUE);

    if (lame)
    {   firstrobot = functab * 2;
        lastrobot  = firstrobot + 1;
    } else
    {   firstrobot = functab * 4;
        lastrobot  = firstrobot + 3;
    }

    for (i = firstrobot; i <= lastrobot; i++)
    {   DISCARD RethinkLayout(gadgets[GID_LY2 + i], MainWindowPtr, NULL, TRUE);
        RefreshGList((struct Gadget *) gadgets[GID_LY2 + i], MainWindowPtr, NULL, 1);
}   }

EXPORT void updateticks(void)
{   // assert(MainWindowPtr);
    // assert(MenuPtr);

    ClearMenuStrip(MainWindowPtr);
    if (paused)
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_PAUSED   , NOSUB))->Flags |=   CHECKED ;
    } else
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_PAUSED   , NOSUB))->Flags &= ~(CHECKED);
    }
    if (turbo)
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_TURBO    , NOSUB))->Flags |=   CHECKED ;
    } else
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_TURBO    , NOSUB))->Flags &= ~(CHECKED);
    }
    if (sound)
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_SOUND    , NOSUB))->Flags |=   CHECKED ;
    } else
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_SOUND    , NOSUB))->Flags &= ~(CHECKED);
    }
    if (show_stars)
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_STARFIELD, NOSUB))->Flags |=   CHECKED ;
    } else
    {   ItemAddress(MenuPtr, FULLMENUNUM(MN_SETTINGS, IN_STARFIELD, NOSUB))->Flags &= ~(CHECKED);
    }
    DISCARD ResetMenuStrip(MainWindowPtr, MenuPtr);

    if (paused)
    {   setup_backdrop();
        draw_player_positions();
        draw_glyph(GLYPHPOS_PAUSED);
    }
    if (turbo) draw_glyph(GLYPHPOS_TURBO);
    if (sound) draw_glyph(GLYPHPOS_SOUND);

    if (paused)
    {   updatescreen();
}   }

MODULE void loadconfig(void)
{   FILE* LocalHandle /* = NULL */ ;

    if ((LocalHandle = fopen("PROGDIR:CodeWar.cfg", "rb")))
    {   if (fread(ConfigBuffer, CONFIGLENGTH, 1, LocalHandle) == 1)
        {   if (ConfigBuffer[0] == 3) // means V1.63+
            {   paused     = ConfigBuffer[1];
                turbo      = ConfigBuffer[2];
                sound      = ConfigBuffer[3];
                show_stars = ConfigBuffer[4];
                speedup    = ConfigBuffer[5];
        }   }
        DISCARD fclose(LocalHandle);
        // LocalHandle = NULL;
}   }

MODULE void saveconfig(void)
{   FILE* LocalHandle /* = NULL */ ;

    if ((LocalHandle = fopen("PROGDIR:CodeWar.cfg", "wb")))
    {   ConfigBuffer[0] = (UBYTE) 3; // means V1.63+
        ConfigBuffer[1] = (UBYTE) paused;
        ConfigBuffer[2] = (UBYTE) turbo;
        ConfigBuffer[3] = (UBYTE) sound;
        ConfigBuffer[4] = (UBYTE) show_stars;
        ConfigBuffer[5] = (UBYTE) speedup;

        DISCARD fwrite(ConfigBuffer, CONFIGLENGTH, 1, LocalHandle);
        DISCARD fclose(LocalHandle);
        // LocalHandle = NULL;
}   }

MODULE void file_open(void)
{   TEXT newpathname[MAX_PATH + 1];

    if
    (   AslRequestTags
        (   ASLRqPtr,
            ASL_Hail,      "Load Robot",
            ASL_FuncFlags, FILF_PATGAD,
        TAG_DONE)
     && *(ASLRqPtr->rf_File) != EOS
    )
    {   strcpy(newpathname, ASLRqPtr->rf_Dir);
        DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
        load_robot(newpathname);
}   }

EXPORT void openconsole(void) { ; }

MODULE void open_speed(void)
{   if (SpeedWindowPtr)
    {   return;
    }

    sprintf(speedtitle, "Speed (%d%%)", speedupnum[speedup]);

    lockscreen();
    if (!(SpeedWinObject =
    WindowObject,
        WA_PubScreen,                             ScreenPtr,
        WA_ScreenTitle,                           "CodeWar " DECIMALVERSION,
        WA_Title,                                 speedtitle,
        WA_Activate,                              TRUE,
        WA_DepthGadget,                           TRUE,
        WA_DragBar,                               TRUE,
        WA_CloseGadget,                           TRUE,
        WA_IDCMP,                                 IDCMP_RAWKEY,
        WINDOW_Position,                          WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,
        VLayoutObject,
            LAYOUT_SpaceOuter,                    TRUE,
            LAYOUT_AddChild,                      gadgets[GID_SL1] = (struct Gadget*)
            SliderObject,
                GA_ID,                            GID_SL1,
                GA_RelVerify,                     TRUE,
                SLIDER_Level,                     (ULONG) speedup,
                SLIDER_Min,                       SPEED_MIN,
                SLIDER_Max,                       SPEED_MAX,
                SLIDER_KnobDelta,                 1,
                SLIDER_Orientation,               SLIDER_HORIZONTAL,
                SLIDER_Ticks,                     SPEED_MAX + 1, // how many ticks to display
            SliderEnd,
            CHILD_MinWidth,                       256,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create ReAction objects!");
    }
    unlockscreen();

    if (!(SpeedWindowPtr = (struct Window*) DoMethod((Object*) SpeedWinObject, WM_OPEN, NULL)))
    {   DisposeObject(SpeedWinObject); // this should free the attached group gadgets
        SpeedWinObject = NULL;
        rq("Can't open ReAction window!");
    }
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_SETTINGS, IN_SPEED, NOSUB));
    LendMenus(SpeedWindowPtr, MainWindowPtr);

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, SpeedWinObject, &SpeedSignal);
}

MODULE void speed_loop(void)
{   UWORD code;
    FLAG  speeddone = FALSE;
    ULONG result,
          whichgad;

    // Processes any messages for the Speed... window.

    if (!SpeedWinObject)
    {   return;
    }

    while ((result = DoMethod(SpeedWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_CLOSEWINDOW:
            speeddone = TRUE;
        acase WMHI_RAWKEY:
            /* raw key event, lower byte are the keycode, qualifiers only in hook-routine */
            code &= 0xFF;
            if (code < KEYUP)
            {   switch (code)
                {
                case SCAN_MI:
                case SCAN_LEFT:
                    if (speedup > SPEED_MIN)
                    {   speedup--;
                        DISCARD SetGadgetAttrs
                        (   gadgets[GID_SL1],
                            SpeedWindowPtr, NULL,
                            SLIDER_Level,   speedup,
                        TAG_DONE); // this refreshes automatically
                        sprintf(speedtitle, "Speed (%d%%)", speedupnum[speedup]);
                        SetWindowTitles(SpeedWindowPtr, speedtitle, (CONST_STRPTR) ~0);
                    }
                acase SCAN_PL:
                case SCAN_RIGHT:
                    if (speedup < SPEED_MAX)
                    {   speedup++;
                        DISCARD SetGadgetAttrs
                        (   gadgets[GID_SL1],
                            SpeedWindowPtr, NULL,
                            SLIDER_Level,   speedup,
                        TAG_DONE); // this refreshes automatically
                        sprintf(speedtitle, "Speed (%d%%)", speedupnum[speedup]);
                        SetWindowTitles(SpeedWindowPtr, speedtitle, (CONST_STRPTR) ~0);
                    }
                acase SCAN_ENTER:
                case SCAN_RETURN:
                    speeddone = TRUE;
            }   }
        acase WMHI_GADGETUP:
            whichgad = result & WMHI_GADGETMASK;
            switch (whichgad)
            {
            case GID_SL1:
                DISCARD GetAttr(SLIDER_Level, (Object*) gadgets[GID_SL1], (ULONG*) &speedup);
                sprintf(speedtitle, "Speed (%d%%)", speedupnum[speedup]);
                SetWindowTitles(SpeedWindowPtr, speedtitle, (CONST_STRPTR) ~0);
    }   }   }

    if (speeddone)
    {   close_speed();
}   }

#ifdef __amigaos4__
MODULE void load_menuimages(void)
{   TRANSIENT       TEXT   theimagename[MAX_PATH + 1];
    TRANSIENT       int    i;
    PERSIST   CONST STRPTR menuimagename[OS4IMAGES] = {
"open",    // 0
"iconify", // 1
"quit",    // 2
"help",    // 3 manual
"info",    // 4 about
};

    // assert(os4menus);

    lockscreen();
    for (i = 0; i < OS4IMAGES; i++)
    {   strcpy(theimagename, "TBImages:");
        strcat(theimagename, menuimagename[i]);
        if (!(menuimage[i] = (struct Image*)
        BitMapObject,
            BITMAP_SourceFile,  theimagename,
            BITMAP_Screen,      ScreenPtr,
            BITMAP_Masking,     TRUE,
            BITMAP_Transparent, TRUE,
            IA_Scalable,        TRUE,
            IA_Width,           menuimagesize,
            IA_Height,          menuimagesize,
        End))
        {   rq("Can't create ReAction image(s)!");
        }
        // assert(SplashWinObject);
        // assert(SplashWindowPtr);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_FG1], SplashWindowPtr, NULL,
            FUELGAUGE_Level,    LASTINITIMAGE - FIRSTINITIMAGE + 1 + i + 1,
        TAG_END); // this autorefreshes
    }
    unlockscreen();
}
#endif
