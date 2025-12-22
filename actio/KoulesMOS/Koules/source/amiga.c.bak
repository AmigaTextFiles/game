#define __USE_OLD_TIMEVAL__ // for OS4

#include <stdio.h>  // FILE*
#include <stdlib.h> // srand()
#include <string.h> // strlen()
#include <time.h>   // time()

#ifndef EXIT_SUCCESS
    #define EXIT_SUCCESS  0
#endif
#ifndef EXIT_FAILURE
    #define EXIT_FAILURE 20
#endif

// OS3 and MOS versions use Paula API, OS4 and AROS versions use AHI API
#if !defined(__amigaos4__) && !defined(__AROS__)
    #define USE_PAULA
#endif

#ifdef USE_PAULA
    #include <devices/audio.h>
#else
    #include <devices/ahi.h>
#endif /* USE_PAULA */
#include <devices/timer.h>
#include <exec/execbase.h>
#include <graphics/gfxbase.h>
#include <libraries/iffparse.h>
#include <devices/input.h>
#include <dos/dos.h>
#include <dos/dosextens.h>
#ifdef __amigaos4__
    #include <dos/obsolete.h> // CurrentDir()
    #include <libraries/application.h>
#endif
#ifdef __MORPHOS__
    #include <intuition/pointerclass.h>
#endif

#include "koules.h" // this must be done *after* struct timeval is declared
#define PENS 224
#include "system.h" // this must be done *after* koules.h

#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <proto/asl.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/lowlevel.h>
#include <proto/timer.h>
#include <proto/wb.h>
#include <clib/alib_protos.h>

#ifdef __SASC
    #include <dos.h> // geta4()
#else
    #define geta4()
#endif /* of __SASC */
#ifndef __AROS__
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#endif /*ifndef __AROS__*/
#ifdef __AROS__
    #include <aros/macros.h>
    #define BE2LONG(x) AROS_BE2LONG(x)
    #define BE2WORD(x) AROS_BE2WORD(x)
#else
    #define BE2LONG(x) (x)
    #define BE2WORD(x) (x)
#endif
#if defined(__MORPHOS__) || defined(__AROS__)
    #define chip
#endif
#ifdef __MORPHOS__
    #define USED __attribute__((used))
#endif
#ifndef __amigaos4__
    #define ZERO       (BPTR) NULL
    #define UNUSED
#endif

#define GID_LY1           0
#define GID_SP1           1
#define GIDS              2

#define SCAN_W           17
#define SCAN_I           23
#define SCAN_P           25
#define SCAN_A           32
#define SCAN_S           33
#define SCAN_D           34
#define SCAN_H           37
#define SCAN_J           38
#define SCAN_K           39
#define SCAN_L           40
#define SCAN_X           50
#define SCAN_ENTER       67
#define SCAN_RETURN      68
#define SCAN_ESCAPE      69
#define SCAN_UP          76
#define SCAN_DOWN        77
#define SCAN_RIGHT       78
#define SCAN_LEFT        79
#define SCAN_HELP        95
#define SCAN_LSHIFT      96
#define SCAN_RSHIFT      97
#define SCAN_CTRL        99
#define KEYUP           128
#define FIRSTQUALIFIER 0x60
#define LASTQUALIFIER  0x67

#define SOUNDS            7
#define CHANNELS          4 // this how many simultaneous sound effects we
                            // support; if we exceed this, the oldest
                            // sound is aborted to make room for the
                            // newest sound.
#define ARGUMENTS         1 // counting from 1

#define ID_8SVX           MAKE_ID('8','S','V','X')
#define ID_BODY           MAKE_ID('B','O','D','Y')
#define ID_VHDR           MAKE_ID('V','H','D','R')
#define PALCLOCK    3546895
#define NTSCCLOCK   3579545

#define CONFIGLENGTH     13 // entries are [0..12]

// from newmouse.h
#ifndef NM_WHEEL_UP
    #define NM_WHEEL_UP   (0x7A)
#endif
#ifndef NM_WHEEL_DOWN
    #define NM_WHEEL_DOWN (0x7B)
#endif

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
} samp[SOUNDS + 1];

EXPORT UWORD chip InvisiblePointerData[6] =
{   0x0000, 0x0000, // reserved

    0x0000, 0x0000, // 1st row 1st plane, 1st row 2nd plane

    0x0000, 0x0000  // reserved
}, CrossData[4 + (15 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    #### #### #### ###.
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....

    Plane 0 Plane 1 */
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0xFFFE, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,

    0x0000, 0x0000  // reserved
};

#if defined(__GNUC__) && !defined(__amigaos4__) && !defined(__AROS__)
    EXPORT struct Library* TimerBase = NULL;
#else
    EXPORT struct Device*  TimerBase = NULL;
#endif

EXPORT UBYTE                 display[WINHEIGHT][WINWIDTH],
                             fgc,
                             inactive       = FALSE,
                             pens[PENS],
                             starfield[MAPHEIGHT][WINWIDTH];
EXPORT struct ASLBase*       ASLBase        = NULL;
EXPORT struct GfxBase*       GfxBase        = NULL;
EXPORT struct IntuitionBase* IntuitionBase  = NULL;
EXPORT struct Library       *IconBase       = NULL,
                            *LowLevelBase   = NULL,
                            *LayoutBase     = NULL,
                            *SpaceBase      = NULL,
                            *WindowBase     = NULL;

IMPORT struct ExecBase*    SysBase;

IMPORT struct KoulesObject object[MAXOBJECT];
IMPORT FLAG                paused,
                           wheelup, wheeldown;
IMPORT int                 bkgrnd,
                           controller[MAXROCKETS],
                           difficulty,
                           startlevel,
                           level,
                           gamemode,
                           gameplan,
                           maxpoint,
                           MouseButtons,
                           MouseX,
                           MouseY,
                           nrockets,
                           keys[3][4],
                           ssound;
IMPORT UBYTE               hole_bitmap            [     HOLE_RADIUS * 2][     HOLE_RADIUS * 2],
                          ehole_bitmap            [     HOLE_RADIUS * 2][     HOLE_RADIUS * 2],
                            eye_bitmap[MAXROCKETS][      EYE_RADIUS * 2][      EYE_RADIUS * 2],
                           ball_bitmap            [     BALL_RADIUS * 2][     BALL_RADIUS * 2],
                          bball_bitmap            [    BBALL_RADIUS * 2][    BBALL_RADIUS * 2],
                      inspector_bitmap            [INSPECTOR_RADIUS * 2][INSPECTOR_RADIUS * 2],
                          lball_bitmap[NLETTERS]  [     BALL_RADIUS * 2][     BALL_RADIUS * 2],
                         rocket_bitmap[MAXROCKETS][   ROCKET_RADIUS * 2][   ROCKET_RADIUS * 2],
                          apple_bitmap            [    APPLE_RADIUS * 2][    APPLE_RADIUS * 2],
                        lunatic_bitmap            [  LUNATIC_RADIUS * 2][  LUNATIC_RADIUS * 2],
                           penter, pfire, pup, pdown, ph, pesc, pleft, pright,
                           solidcolour[MAXROCKETS];

MODULE int                   showpointer         = TRUE,
                             xoffset,
                             yoffset;
MODULE FLAG                  configloaded        = FALSE,
                             gotpen[PENS],
                             rc                  = FALSE,
                             reactable           = FALSE;
MODULE UBYTE                 currentbg,
                             KeyMatrix[64];
MODULE TEXT                  fn_game[MAX_PATH + 1],
                             screenname[MAXPUBSCREENNAME + 1] = "";
MODULE struct RastPort       wpa8rastport;
MODULE struct Screen*        ScreenPtr           = NULL;
MODULE struct Window*        MainWindowPtr       = NULL;
MODULE struct timerequest*   TimerIO             = NULL;
MODULE struct Gadget*        gadgets[GIDS + 1];
MODULE struct MsgPort*       AppPort             = NULL;
MODULE struct DiskObject*    IconifiedIcon;
MODULE struct WBStartup*     WBStartupPtr;
MODULE struct MsgPort       *AudioPortPtr[4]     = {NULL, NULL, NULL, NULL},
                            *InputPort           = NULL;
MODULE struct IOStdReq*      InputIO             = NULL;
MODULE BYTE                  InputDevice         = ~0, // MUST NOT be 0
                             TimerClosed         = ~0;
MODULE struct BitMap*        wpa8bitmap          = NULL;
MODULE struct WBArg*         WBArg               = NULL;
MODULE struct WBStartup*     WBMsg               = NULL;
MODULE Object*               WinObject           = NULL; // note that WindowObject is a reserved macro
MODULE FLAG                  AudioClosed         = TRUE,
                             eversent[4];
MODULE ULONG                 AppSignal           = 0,
                             AppLibSignal        = 0,
                             MainSignal,
                             receipter[4]        = {(ULONG) -1, (ULONG) -1, (ULONG) -1, (ULONG) -1},
                             Colours[1 + (PENS * 3) + 1] = {(256 << 16) + 0};
#ifdef USE_PAULA
    MODULE struct IOAudio*    AudioRqPtr[4]      = { NULL, NULL, NULL, NULL };
#else
    MODULE struct AHIRequest* AudioRqPtr[4]      = { NULL, NULL, NULL, NULL };
#endif /* USE_PAULA */
#ifdef __amigaos4__
    MODULE struct MsgPort*    AppLibPort         = NULL;
    MODULE ULONG              AppID              = 0; // not NULL!
#endif

MODULE void rq(STRPTR message);
MODULE void make_buffer(void);
MODULE void destroy_buffer(void);
MODULE void load_rc(void);
MODULE void save_rc(void);
MODULE void load_sounds(void);
MODULE void make_bkgrnd(void);
MODULE void lockscreen(void);
MODULE void unlockscreen(void);
MODULE void iconify(void);
MODULE void uniconify(void);
MODULE void getpens(void);
MODULE void freepens(void);
MODULE void movepointer(void);
MODULE void parsewb(void);
MODULE void blanker_on(void);
MODULE void blanker_off(void);
MODULE void handle_idcmp(ULONG class, UWORD code, UWORD qual, VOID* msg);
MODULE void setpointer(void);
MODULE void InitHook(struct Hook* hook, ULONG (*func)(), void* data);
MODULE ULONG MainHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg);

/* The samples to load */
MODULE STRPTR filename[SOUNDS] =
{   (STRPTR) "PROGDIR:sounds/start.8svx",
    (STRPTR) "PROGDIR:sounds/end.8svx",
    (STRPTR) "PROGDIR:sounds/collide.8svx",
    (STRPTR) "PROGDIR:sounds/destroy1.8svx",
    (STRPTR) "PROGDIR:sounds/destroy2.8svx",
    (STRPTR) "PROGDIR:sounds/creator1.8svx",
    (STRPTR) "PROGDIR:sounds/creator2.8svx"
};

EXPORT void usleep(unsigned long s)
{   PERSIST ULONG          waittill   = 0,
                           nowtime;        // PERSISTent for speed
    PERSIST struct timeval thetimeval;     // PERSISTent for speed
#ifdef __amigaos4__
    PERSIST struct TimeVal TheTimeVal;     // PERSISTent for speed
#endif

    /* Wait for s microseconds.

       As soon as we have finished waiting, we calculate how much we
       should wait next time. This way the time consumed in running the
       game is taken into account.

       The way it is implemented, it will return immediately on the
       first frame, but all subsequent frames are timed correctly. */

    waittill += (s / 1000);

#ifdef __amigaos4__
    GetSysTime(&TheTimeVal);
    thetimeval.tv_secs  = TheTimeVal.Seconds;
    thetimeval.tv_micro = TheTimeVal.Microseconds;
#else
    GetSysTime(&thetimeval);
#endif
    nowtime = (thetimeval.tv_secs  * 1000)
            + (thetimeval.tv_micro / 1000);
    if (nowtime > waittill)
    {
#ifdef __amigaos4__
        GetSysTime(&TheTimeVal);
        thetimeval.tv_secs  = TheTimeVal.Seconds;
        thetimeval.tv_micro = TheTimeVal.Microseconds;
#else
        GetSysTime(&thetimeval);
#endif
        waittill = (thetimeval.tv_secs  * 1000)
                 + (thetimeval.tv_micro / 1000);
    }
#ifdef __amigaos4__
    if (nowtime < waittill)
    {   MicroDelay((waittill - nowtime) * 1000);
    }
#else
    while (nowtime < waittill)
    {   GetSysTime(&thetimeval);
        nowtime = (thetimeval.tv_secs  * 1000)
                + (thetimeval.tv_micro / 1000);
    }
#endif /* __amigaos4__ */
}

EXPORT int main(int argc, char* argv[])
{   TRANSIENT int            i;
    TRANSIENT struct WBArg*  WBArgPtr;
    TRANSIENT struct RDArgs* ArgsPtr;
    TRANSIENT SLONG          args[ARGUMENTS + 1];
    TRANSIENT BPTR           OldDir;
    TRANSIENT FLAG           big;
    PERSIST   struct Hook    MainHookStruct; // doesn't work as TRANSIENT!

    // Start of program.

#if defined(__amigaos4__) || defined(__MORPHOS__)
    // version embedding into executable
    USED static const STRPTR version = VERSION;
#else
    if (0) printf(VERSION);
#endif

    for (i = 0; i < 64; i++)
    {   KeyMatrix[i] = 0;
    }
    for (i = 0; i < PENS; i++)
    {   gotpen[i] = FALSE;
    }
    for (i = 0; i <= ARGUMENTS; i++)
    {   args[i] = 0;
    }
    keys[0][0] = SCAN_W;
    keys[0][1] = SCAN_S;
    keys[0][2] = SCAN_A;
    keys[0][3] = SCAN_D;
    keys[1][0] = SCAN_I;
    keys[1][1] = SCAN_K;
    keys[1][2] = SCAN_J;
    keys[1][3] = SCAN_L;
    keys[2][0] = SCAN_UP;
    keys[2][1] = SCAN_DOWN;
    keys[2][2] = SCAN_LEFT;
    keys[2][3] = SCAN_RIGHT;

    // hopefully all the preceding code is safe for any CPU type

#ifndef __AROS__
    if (!((SysBase->AttnFlags) & AFF_68020))
    {   printf("Koules: Need 68020+!\n");
        exit(EXIT_FAILURE);
    }
#endif

#if !defined(__amigaos4__) && !defined(__MORPHOS__) && !defined(__AROS__)
    if (!((SysBase->AttnFlags) & AFF_68020))
    {   printf("Koules: Need 68020+!\n");
        exit(EXIT_FAILURE); // we haven't allocated anything yet
    }
#endif

    if (SysBase->LibNode.lib_Version < 40)
    {   printf("Koules: Need exec.library V40+!\n");
        cleanexit(EXIT_FAILURE);
    }

    srand((unsigned int) time(NULL));

    if (!(TimerIO = (struct timerequest*) AllocMem(sizeof(struct timerequest), MEMF_PUBLIC | MEMF_CLEAR)))
    {   rq((STRPTR) "Out of memory!");
    }
    if ((TimerClosed = OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest*) TimerIO, 0)))
    {   rq((STRPTR) "Can't open timer.device!");
    }
#if defined(__SASC) || defined(__STORM__) || defined(__amigaos4__)
    TimerBase = (struct Device*)    (TimerIO->tr_node.io_Device);
#else
    #ifdef __MORPHOS__
    TimerBase = (struct Library*)   (TimerIO->tr_node.io_Device);
    #else
    TimerBase = (struct TimerBase*) (TimerIO->tr_node.io_Device);
    #endif
#endif

    if (!(ASLBase       = (struct ASLBase*      ) OpenLibrary("asl.library"          ,  0))) { rq((STRPTR) "Can't open ASL.library!");       }
    if (!(GfxBase       = (struct GfxBase*      ) OpenLibrary("graphics.library"     ,  0))) { rq((STRPTR) "Can't open graphics.library!");  }
    if (!(IconBase      =                         OpenLibrary("icon.library"         ,  0))) { rq((STRPTR) "Can't open icon.library!");      }
    if (!(IntuitionBase = (struct IntuitionBase*) OpenLibrary("intuition.library"    ,  0))) { rq((STRPTR) "Can't open intuition.library!"); }
    if (!(LowLevelBase  =                         OpenLibrary("lowlevel.library"     , 40))) { rq((STRPTR) "Can't open lowlevel.library!");  }

    LayoutBase          =                         OpenLibrary("gadgets/layout.gadget",  0);
    SpaceBase           =                         OpenLibrary("gadgets/space.gadget" ,  0);
    WindowBase          =                         OpenLibrary("window.class"         ,  0);
    if (LayoutBase && SpaceBase && WindowBase)
    {   reactable = TRUE;
    }

    if (!(InputPort = (struct MsgPort*) CreateMsgPort()))
    {   rq("CreateMsgPort() failed!");
    }
    if (!(InputIO = (struct IOStdReq*) CreateIORequest(InputPort, sizeof(struct IOStdReq))))
    {   rq("Out of memory!");
    }
    if ((InputDevice = OpenDevice("input.device", 0, (struct IORequest*) InputIO, 0)))
    {   rq("Can't open input.device!");
    }

    if (!(AppPort = CreateMsgPort()))
    {   rq((char*) "Can't create message port!");
    }

#ifdef __amigaos4__
    if
    (   !(ILayout    = (struct LayoutIFace*)    GetInterface(                  LayoutBase,    "main", 1, 0))
     || !(ISpace     = (struct SpaceIFace*)     GetInterface(                  SpaceBase,     "main", 1, 0))
     || !(IWindow    = (struct WindowIFace*)    GetInterface(                  WindowBase,    "main", 1, 0))
     || !(IAsl       = (struct AslIFace*)       GetInterface(                  AslBase,       "main", 1, 0))
     || !(IGraphics  = (struct GraphicsIFace*)  GetInterface((struct Library*) GfxBase,       "main", 1, 0))
     || !(IIcon      = (struct IconIFace*)      GetInterface(                  IconBase,      "main", 1, 0))
     || !(IIntuition = (struct IntuitionIFace*) GetInterface((struct Library*) IntuitionBase, "main", 1, 0))
     || !(ITimer     = (struct TimerIFace*)     GetInterface((struct Library*) TimerBase,     "main", 1, 0))
     || !(ILowLevel  = (struct LowLevelIFace*)  GetInterface((struct Library*) LowLevelBase,  "main", 1, 0))
    )
    {   DISCARD printf("Can't get library interfaces!\n");
        cleanexit(EXIT_FAILURE);
    }

    if
    (   (ApplicationBase = OpenLibrary("application.library", 0))
     && (IApplication    = (struct ApplicationIFace*)
                           GetInterface(ApplicationBase, "application", 2, 0))
    )
    {   AppID = RegisterApplication
        (   "Koules",
            REGAPP_Description,       "Arcade game",
            REGAPP_URLIdentifier,     "amigan.1emu.net",
            REGAPP_AllowsBlanker,     FALSE,
            REGAPP_HasIconifyFeature, TRUE,
            REGAPP_CanCreateNewDocs,  FALSE,
            REGAPP_CanPrintDocs,      FALSE,
        TAG_DONE);
        GetApplicationAttrs(AppID, APPATTR_Port, &AppLibPort, TAG_END);
        AppLibSignal = 1 << AppLibPort->mp_SigBit;
        DISCARD SetApplicationAttrs
        (   AppID,
            APPATTR_NeedsGameMode,    TRUE,
        TAG_DONE);
    }
#endif /* __amigaos4__ */

    if (argc) // started from CLI
    {   if (!(ArgsPtr = (struct RDArgs*) ReadArgs
        (   "PUBSCREEN/K",
            (LONG*) args,
            NULL
        )))
        {   DISCARD Printf
            (   "Usage: %s [PUBSCREEN <screen>]\n",
                argv[0]
            );
            cleanexit(EXIT_FAILURE);
        }

        if (args[0])
        {   strcpy(screenname, (STRPTR) args[0]);
        }
        FreeArgs(ArgsPtr);
        // ArgsPtr = NULL;
    } else // started from WB
    {   WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList; // head of the arg list
        for (i = 0; i < WBMsg->sm_NumArgs; i++, WBArg++)
        {   if (WBArg->wa_Lock)
            {   // something that does not support locks
                parsewb();
            } else
            {   // lock supported; change to the proper directory
                OldDir = CurrentDir(WBArg->wa_Lock);
                parsewb();
                DISCARD CurrentDir(OldDir);
            }
            if (i == 1)
            {   ; // we were started from a project icon, which is
                  // currently unsupported
    }   }   }

    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }

    load_rc();

    for (i = 0; i < PENS; i++)
    {   Colours[1 + (i * 3) + 0] = ((colours[i] & 0x00FF0000) <<  8)
                                 |  (colours[i] & 0x00FF0000)
                                 | ((colours[i] & 0x00FF0000) >>  8)
                                 | ((colours[i] & 0x00FF0000) >> 16);
        Colours[1 + (i * 3) + 1] = ((colours[i] & 0x0000FF00) << 16)
                                 | ((colours[i] & 0x0000FF00) <<  8)
                                 |  (colours[i] & 0x0000FF00)
                                 | ((colours[i] & 0x0000FF00) >>  8);
        Colours[1 + (i * 3) + 2] = ((colours[i] & 0x000000FF) << 24)
                                 | ((colours[i] & 0x000000FF) << 16)
                                 | ((colours[i] & 0x000000FF) <<  8)
                                 |  (colours[i] & 0x000000FF)       ;
    }
    Colours[1 + (PENS * 3)] = 0;

    lockscreen();
    big = (ScreenPtr->Width > 640 && ScreenPtr->Height > 512) ? TRUE : FALSE;

    strcpy((char*) fn_game, "PROGDIR:");
    if (argc) // started from CLI
    {   AddPart((char*) fn_game, FilePart(argv[0]), MAX_PATH);
    } else // started from WB
    {   WBStartupPtr = (struct WBStartup*) argv;
        WBArgPtr     = WBStartupPtr->sm_ArgList;
        AddPart((char*) fn_game, (char*) WBArgPtr->wa_Name, MAX_PATH);
    }
    IconifiedIcon = GetDiskObjectNew((char*) fn_game);

    getpens();
    make_bkgrnd();
#ifndef __AROS__
    if (reactable)
    {   InitHook(&MainHookStruct, (ULONG (*)()) MainHookFunc, NULL);

        if (!(WinObject = (Object*)
        WindowObject,
            WA_PubScreen,                     ScreenPtr,
            WA_ScreenTitle,                   "Koules",
            big ? WA_Title : TAG_IGNORE,      "Koules",
            WA_Activate,                      TRUE,
            WA_DepthGadget,                   big ? TRUE : FALSE,
            WA_DragBar,                       big ? TRUE : FALSE,
            WA_CloseGadget,                   big ? TRUE : FALSE,
            WA_Borderless,                    big ? FALSE : TRUE,
            WA_SizeGadget,                    FALSE,
            WA_IDCMP,                         IDCMP_RAWKEY
                                            | IDCMP_MENUVERIFY
                                            | IDCMP_MOUSEBUTTONS
                                            | IDCMP_ACTIVEWINDOW
                                            | IDCMP_INACTIVEWINDOW
                                            | IDCMP_CLOSEWINDOW,
            WINDOW_IDCMPHook,                 &MainHookStruct,
            WINDOW_IDCMPHookBits,             IDCMP_RAWKEY
                                            | IDCMP_MENUVERIFY
                                            | IDCMP_MOUSEBUTTONS
                                            | IDCMP_ACTIVEWINDOW
                                            | IDCMP_INACTIVEWINDOW
                                            | IDCMP_CLOSEWINDOW,
            WINDOW_IconifyGadget,             big ? TRUE : FALSE,
            WINDOW_IconTitle,                 "Koules",
            WINDOW_Icon,                      IconifiedIcon,
            WINDOW_Position,                  big ? WPOS_CENTERSCREEN : WPOS_TOPLEFT,
            WINDOW_AppPort,                   AppPort,
            WINDOW_ParentGroup,               gadgets[GID_LY1] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_AddChild,              gadgets[GID_SP1] = (struct Gadget*)
                SpaceObject,
                    GA_ID,                    GID_SP1,
                    SPACE_MinWidth,           WINWIDTH,
                    SPACE_MinHeight,          WINHEIGHT,
                    SPACE_BevelStyle,         BVS_NONE,
                SpaceEnd,
                CHILD_WeightedWidth,          0,
                CHILD_WeightedHeight,         0,
            LayoutEnd,
        WindowEnd))
        {   rq((STRPTR) "Can't create window!");
        }

        if (!(MainWindowPtr = (struct Window*) RA_OpenWindow(WinObject)))
        {   rq((STRPTR) "Can't open window!");
        }

        xoffset = gadgets[GID_SP1]->LeftEdge;
        yoffset = gadgets[GID_SP1]->TopEdge;

        DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
        AppSignal = 1 << AppPort->mp_SigBit;
    } else
#endif /*ifndef __AROS__*/
    {   if (!(MainWindowPtr = (struct Window*) OpenWindowTags(NULL,
            WA_PubScreen,                     ScreenPtr,
            WA_ScreenTitle,                   "Koules",
            big ? WA_Title : TAG_IGNORE,      "Koules",
            WA_Activate,                      TRUE,
            WA_DepthGadget,                   big ? TRUE : FALSE,
            WA_DragBar,                       big ? TRUE : FALSE,
            WA_CloseGadget,                   big ? TRUE : FALSE,
            WA_Borderless,                    big ? FALSE : TRUE,
            WA_SizeGadget,                    FALSE,
            WA_IDCMP,                         IDCMP_RAWKEY
                                            | IDCMP_MENUVERIFY
                                            | IDCMP_MOUSEBUTTONS
                                            | IDCMP_ACTIVEWINDOW
                                            | IDCMP_INACTIVEWINDOW
                                            | IDCMP_CLOSEWINDOW,
            WA_Left,                          (ScreenPtr->Width  - WINWIDTH ) / 2, // doesn't take borders into account
            WA_Top,                           (ScreenPtr->Height - WINHEIGHT) / 2, // doesn't take borders into account
            WA_InnerWidth,                    WINWIDTH,
            WA_InnerHeight,                   WINHEIGHT,
        TAG_DONE)))
        {   rq("Can't open window!");
        }

        xoffset = MainWindowPtr->BorderLeft;
        yoffset = MainWindowPtr->BorderTop;

        MainSignal = 1 << MainWindowPtr->UserPort->mp_SigBit;
    }

    setpointer();
    make_buffer();
    if (ssound)
    {   start_sounds();
    }
    create_bitmaps();
    make_logo();
    clearscreen();
    draw_logo();
    init_objects();
    game();
    cleanexit(EXIT_SUCCESS);

#ifdef __amigaos4__
    return EXIT_SUCCESS; // never executed but otherwise GCC complains
#endif
}

EXPORT FLAG UpdateInput(void)
{   TRANSIENT UWORD                  code,
                                     qual;
    TRANSIENT ULONG                  class,
                                     result,
                                     val;
    TRANSIENT struct IntuiMessage*   MsgPtr;
#ifdef __amigaos4__
    TRANSIENT ULONG                  msgtype,
                                     msgval;
    TRANSIENT struct ApplicationMsg* AppLibMsg;
#endif

    movepointer();
    MouseX = (int) (MainWindowPtr->MouseX - xoffset);
    MouseY = (int) (MainWindowPtr->MouseY - yoffset);
#ifndef __AROS__
    if (reactable)
    {   while ((result = DoMethod(WinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   switch (result & WMHI_CLASSMASK)
            {
            case WMHI_ICONIFY:
                iconify();
    }   }   }
    else
#endif /*ifndef __AROS__*/
    {   while ((MsgPtr = (struct IntuiMessage*) GetMsg(MainWindowPtr->UserPort)))
        {   class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            handle_idcmp(class, code, qual, MsgPtr);
            ReplyMsg((struct Message*) MsgPtr); // can't reply until after handle_idcmp()
    }   }

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
            acase APPLIBMT_Hide:
                iconify();
            acase APPLIBMT_ToFront:
                ScreenToFront(ScreenPtr);
                WindowToFront(MainWindowPtr);
                ActivateWindow(MainWindowPtr);
    }   }   }
#endif

    val = ReadJoyPort(0) | ReadJoyPort(1) | ReadJoyPort(2) | ReadJoyPort(3);
    if
    (   (val & JPF_BUTTON_RED    )
     || (val & JPF_BUTTON_BLUE   )
     || (val & JPF_BUTTON_GREEN  )
     || (val & JPF_BUTTON_YELLOW )
     || (val & JPF_BUTTON_PLAY   )
     || (val & JPF_BUTTON_REVERSE)
     || (val & JPF_BUTTON_FORWARD)
    )
    {   pfire = 1;
        rc = TRUE;
    } else
    {   pfire = 0;
    }

    if (rc)
    {   rc = FALSE;
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE ULONG MainHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg)
{   /* "When the hook is called, the data argument points to the
    window object and message argument to the IntuiMessage." */

    TRANSIENT ULONG class;
    TRANSIENT UWORD code, qual;
 // TRANSIENT SWORD mousex, mousey;

    geta4(); // wait till here before doing anything

    class  = ((struct IntuiMessage*) msg)->Class;
    code   = ((struct IntuiMessage*) msg)->Code;
    qual   = ((struct IntuiMessage*) msg)->Qualifier;
 // mousex = ((struct IntuiMessage*) msg)->MouseX;
 // mousey = ((struct IntuiMessage*) msg)->MouseY;

    handle_idcmp(class, code, qual, msg);

    return 1;
}

MODULE void handle_idcmp(ULONG class, UWORD code, UWORD qual, VOID* msg)
{   PERSIST FLAG shifted = FALSE;
    PERSIST int  ignore  = 0;

    switch (class)
    {
    case IDCMP_MENUVERIFY:
        if (code == MENUHOT)
        {   ((struct IntuiMessage*) msg)->Code = MENUCANCEL;
        }
    acase IDCMP_RAWKEY:
        if (!(qual & IEQUALIFIER_REPEAT))
        {   if (code < KEYUP)
            {   rc = TRUE;
                KeyMatrix[code / 8] |= (1 << (code % 8));
                switch (code)
                {
                case SCAN_LSHIFT:
                case SCAN_RSHIFT:
                    shifted = TRUE;
                acase SCAN_RETURN:
                case SCAN_ENTER:
                    penter = 1;
                acase SCAN_ESCAPE:
                    if (gamemode == MENU || shifted)
                    {   cleanexit(EXIT_SUCCESS);
                    } // implied else
                    pesc = 1;
                    paused = FALSE;
                    blanker_off();
                acase SCAN_UP:
                    pup = 1;
                acase NM_WHEEL_UP:
                    if (gamemode == MENU)
                    {   wheelup = TRUE;
                    }
                acase SCAN_DOWN:
                    pdown = 1;
                acase NM_WHEEL_DOWN:
                    if (gamemode == MENU)
                    {   wheeldown = TRUE;
                    }
                acase SCAN_LEFT:
                    pleft = 1;
                acase SCAN_RIGHT:
                    pright = 1;
                acase SCAN_H:
                case SCAN_HELP:
                    ph = 1;
                acase SCAN_P:
                    if (paused)
                    {   paused = rc = FALSE;
                        blanker_off();
                    } else
                    {   paused = TRUE;
                        DrawWhiteText((MAPWIDTH / 2) - (4 * 6), 140, "PAUSED");
                        updatescreen();
                        blanker_on();
                    }
                acase SCAN_X:
                    if (KeyMatrix[SCAN_CTRL / 8] & (1 << (SCAN_CTRL % 8)))
                    {   if (showpointer)
                        {   showpointer = FALSE;
                        } else
                        {   showpointer = TRUE;
                        }
                        setpointer();
                    }
                acase SCAN_S:
                    if (KeyMatrix[SCAN_CTRL / 8] & (1 << (SCAN_CTRL % 8)))
                    {   setsound();
            }   }   }
            else
            {   KeyMatrix[(code - KEYUP) / 8] &= (255 - (1 << ((code - KEYUP) % 8)));
                switch (code - KEYUP)
                {
                case SCAN_LSHIFT:
                case SCAN_RSHIFT:
                    shifted = FALSE;
                acase SCAN_RETURN:
                case SCAN_ENTER:
                    penter = 0;
                acase SCAN_ESCAPE:
                    pesc = 0;
                acase SCAN_UP:
                    pup = 0;
                acase SCAN_DOWN:
                    pdown = 0;
                acase SCAN_LEFT:
                    pleft = 0;
                acase SCAN_RIGHT:
                    pright = 0;
                acase SCAN_H:
                case SCAN_HELP:
                    ph = 0;
        }   }   }
    acase IDCMP_ACTIVEWINDOW:
        inactive = FALSE;
        ignore = 2; // because we get sent a SELECTDOWN and then a SELECTUP
    acase IDCMP_INACTIVEWINDOW:
        inactive = TRUE;
        if (gamemode == GAME)
        {   paused = TRUE;
            DrawWhiteText((MAPWIDTH / 2) - (4 * 6), 140, "PAUSED");
            updatescreen();
            blanker_on();
        }
    acase IDCMP_CLOSEWINDOW:
        cleanexit(EXIT_SUCCESS);
    acase IDCMP_MOUSEBUTTONS:
        if (ignore)
        {   ignore--;
        } elif (code == SELECTDOWN)
        {   MouseButtons = 1;
            rc = TRUE;
        } elif (code == SELECTUP)
        {   MouseButtons = 0;
}   }   }

EXPORT void updatescreen(void)
{   DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        (ULONG) xoffset,
        (ULONG) yoffset,
        (ULONG) (xoffset + WINWIDTH  - 1),
        (ULONG) (yoffset + WINHEIGHT - 1),
        &display[0][0],
        &wpa8rastport
    );
}

EXPORT BOOL IsPressed(int which)
{   if
    (    (KeyMatrix[which     / 8] & (1 << (which     % 8)))
     && !(KeyMatrix[SCAN_CTRL / 8] & (1 << (SCAN_CTRL % 8)))
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT int ReadJoystick(int joynum)
{   ULONG val;

    // joynum will be '0' if they want the SECONDARY port
    // joynum will be '1' if they want the PRIMARY   port
    // joynum will be '2' if they want the 1st parallel port joystick/gamepad
    // joynum will be '3' if they want the 2nd parallel port joystick/gamepad

    val = ReadJoyPort((ULONG) joynum);
    if ((val & JPF_JOY_UP   ) && (val & JPF_JOY_LEFT )) return 1;
    if ((val & JPF_JOY_UP   ) && (val & JPF_JOY_RIGHT)) return 2;
    if ((val & JPF_JOY_DOWN ) && (val & JPF_JOY_RIGHT)) return 3;
    if ((val & JPF_JOY_DOWN ) && (val & JPF_JOY_LEFT )) return 4;
    if ( val & JPF_JOY_LEFT                           ) return 5;
    if ( val & JPF_JOY_RIGHT                          ) return 6;
    if ( val & JPF_JOY_UP                             ) return 7;
    if ( val & JPF_JOY_DOWN                           ) return 8;

    return 0;
}

MODULE void load_rc(void)
{   FILE* ConfigHandle;
    UBYTE ConfigBuffer[CONFIGLENGTH];
    int   i;

    if ((ConfigHandle = fopen("PROGDIR:Koules.config", "rb")))
    {   if (fread(ConfigBuffer, CONFIGLENGTH, 1, ConfigHandle) == 1)
        {   if (ConfigBuffer[0] >= 7) // means R1.3+
            {   configloaded = TRUE;

                // byte 0: version (7 means R1.3+)
                for (i = 0; i <= 4; i++)
                {   controller[i] = (int) ConfigBuffer[i + 1];
                }
                nrockets          = (int) ConfigBuffer[ 6];
                gameplan          = (int) ConfigBuffer[ 7];
                difficulty        = (int) ConfigBuffer[ 8];
                ssound            = (int) ConfigBuffer[ 9];
                level             = (int) ConfigBuffer[10];
                showpointer       = (int) ConfigBuffer[11];
                bkgrnd            = (int) ConfigBuffer[12];
        }   }
        DISCARD fclose(ConfigHandle);
        // ConfigHandle = NULL;
}   }

MODULE void save_rc(void)
{   FILE* ConfigHandle;
    UBYTE ConfigBuffer[CONFIGLENGTH];
    int   i;

    ConfigBuffer[ 0] = 7; // means R1.3+
    for (i = 0; i <= 4; i++)
    {   ConfigBuffer[i + 1] = (UBYTE) controller[i];
    }
    ConfigBuffer[ 6]        = (UBYTE) nrockets;
    ConfigBuffer[ 7]        = (UBYTE) gameplan;
    ConfigBuffer[ 8]        = (UBYTE) difficulty;
    ConfigBuffer[ 9]        = (UBYTE) ssound;
    ConfigBuffer[10]        = (UBYTE) startlevel;
    ConfigBuffer[11]        = (UBYTE) showpointer;
    ConfigBuffer[12]        = (UBYTE) bkgrnd;

    if ((ConfigHandle = fopen("PROGDIR:Koules.config", "wb")))
    {   DISCARD fwrite(ConfigBuffer, CONFIGLENGTH, 1, ConfigHandle);
        DISCARD fclose(ConfigHandle);
        // ConfigHandle = NULL;
}   }

EXPORT void cleanexit(SBYTE rc)
{   int             i;
    struct Message* MsgPtr;

    save_rc();

    freefx(); // calls stop_sounds()
    for (i = 0; i < SOUNDS; i++)
    {   if (samp[i].base)
        {   FreeMem(samp[i].base, samp[i].size);
            samp[i].base = NULL;
    }   }

    if (reactable)
    {   if (WinObject) // NOT if (MainWindowPtr) (because it might be iconified)
        {   DisposeObject(WinObject);
            /* "Disposing of the window object will also close the window
               if it is already opened, and it will dispose of the layout
               object attached to it." - checkboxexample.c */
            WinObject     = NULL;
            MainWindowPtr = NULL;
    }   }
    else
    {   if (MainWindowPtr)
        {   CloseWindow(MainWindowPtr);
            // MainWindowPtr = NULL;
    }   }
    destroy_buffer();

    if (AppPort)
    {   while ((MsgPtr = GetMsg(AppPort)))
        {   ReplyMsg(MsgPtr);
        }
        DeleteMsgPort(AppPort);
        AppPort = NULL;
    }

    freepens();
    unlockscreen();

    if (!InputDevice)
    {   // assert((int) InputIO);
        CloseDevice((struct IORequest*) InputIO);
        InputDevice = ~0;
    }
    if (InputIO)
    {   DeleteExtIO((struct IORequest*) InputIO);
        InputIO = NULL;
    }
    if (InputPort)
    {   // what about unreplied msgs?
        DeletePort(InputPort);
        InputPort = NULL;
    }

    if (LowLevelBase)
    {   for (i = 0; i < 4; i++)
        {   SetJoyPortAttrs(i, SJA_Reinitialize, NULL, TAG_END); // to free potgo bits
    }   }

#ifdef __amigaos4__
    if (ITimer    ) { DropInterface((struct Interface*) ITimer    ); /* ITimer     = NULL; */ }
#endif
    if (!TimerClosed)
    {   // assert((TimerIO);
        CloseDevice((struct IORequest*) TimerIO);
        // TimerClosed = ~0;
    }
    if (TimerIO)
    {   FreeMem(TimerIO, sizeof(struct timerequest));
        // TimerIO = NULL;
    }

#ifdef __amigaos4__
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

    if (ILayout   ) { DropInterface((struct Interface*) ILayout   ); /* ILayout    = NULL; */ }
    if (ISpace    ) { DropInterface((struct Interface*) ISpace    ); /* ISpace     = NULL; */ }
    if (IWindow   ) { DropInterface((struct Interface*) IWindow   ); /* IWindow    = NULL; */ }
    if (IAsl      ) { DropInterface((struct Interface*) IAsl      ); /* IAsl       = NULL; */ }
    if (IGraphics ) { DropInterface((struct Interface*) IGraphics ); /* IGraphics  = NULL; */ }
    if (IIcon     ) { DropInterface((struct Interface*) IIcon     ); /* IIcon      = NULL; */ }
    if (IIntuition) { DropInterface((struct Interface*) IIntuition); /* IIntuition = NULL; */ }
    if (ILowLevel ) { DropInterface((struct Interface*) ILowLevel ); /* ILowLevel  = NULL; */ }
#endif

    if (LayoutBase   ) { CloseLibrary((struct Library*) LayoutBase   ); /* LayoutBase    = NULL; */ }
    if (SpaceBase    ) { CloseLibrary((struct Library*) SpaceBase    ); /* SpaceBase     = NULL; */ }
    if (WindowBase   ) { CloseLibrary((struct Library*) WindowBase   ); /* WindowBase    = NULL; */ }
    if (ASLBase      ) { CloseLibrary((struct Library*) ASLBase      ); /* ASLBase       = NULL; */ }
    if (GfxBase      ) { CloseLibrary((struct Library*) GfxBase      ); /* GfxBase       = NULL; */ }
    if (IconBase     ) { CloseLibrary((struct Library*) IconBase     ); /* IconBase      = NULL; */ }
    if (IntuitionBase) { CloseLibrary((struct Library*) IntuitionBase); /* IntuitionBase = NULL; */ }
    if (LowLevelBase ) { CloseLibrary(                  LowLevelBase ); /* LowLevelBase  = NULL; */ }

    exit(rc);
}

MODULE void load_sounds(void)
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
};

    for (i = 0; i < SOUNDS; i++)
    {   samp[i].base = NULL;
    }

    for (i = 0; i < SOUNDS; i++)
    {   if (!(FilePtr = Open((CONST_STRPTR) filename[i], MODE_OLDFILE)))
        {   code = 1;                               /* can't open file */
        } else
        {   rd8count = (ULONG) Read(FilePtr, iobuffer, 8L);
            if (rd8count == (ULONG) -1)
                code = 2;                           /* can't read file */
            elif (rd8count < 8)
                code = 3;                           /* not an IFF 8SVX; too short */
            else
            {   p8Chunk = (struct Chunk*) iobuffer;
                p8Chunk->ckID = BE2LONG(p8Chunk->ckID);
                p8Chunk->ckSize = BE2LONG(p8Chunk->ckSize);
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
                            p8data += 8L + p8Chunk->ckSize;
                            if ((p8Chunk->ckSize & 1L) == 1)
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
#ifdef USE_PAULA
                            if (GfxBase->DisplayFlags & PAL) // PAL clock
                            {   samp[i].speed = PALCLOCK / pVoice8Header->samplesPerSec;
                            } else // NTSC clock
                            {   samp[i].speed = NTSCCLOCK / pVoice8Header->samplesPerSec;
                            }
#else
                            samp[i].speed = pVoice8Header->samplesPerSec;
#endif /* USE_PAULA */

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

EXPORT void play_sound(int which)
{
#ifdef NOSOUND
    ;
#else
    TRANSIENT SBYTE i;
    TRANSIENT SBYTE ok            = -1;
    TRANSIENT ULONG oldestreceipt = (ULONG) -1L;
    PERSIST   ULONG nextreceipt   = 1L;

    /* oldestreceipt = temporary variable for ascertaining oldest
                       sound still playing.
    nextreceipt = next unused receipt number (monotonically incrementing). */

    if (!ssound)
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

#ifdef USE_PAULA
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
#else
    AudioRqPtr[ok]->ahir_Std.io_Command     = CMD_WRITE;
    AudioRqPtr[ok]->ahir_Link               = NULL;
    AudioRqPtr[ok]->ahir_Std.io_Offset      = 0;
    AudioRqPtr[ok]->ahir_Type               = AHIST_M8S;
    AudioRqPtr[ok]->ahir_Position           = 0x8000; // in AHI sounds are always centered
    AudioRqPtr[ok]->ahir_Volume             = 0x10000; // full volume
    AudioRqPtr[ok]->ahir_Frequency          = samp[which].speed;
    AudioRqPtr[ok]->ahir_Std.io_Message.mn_ReplyPort
                                            = AudioPortPtr[ok];
    AudioRqPtr[ok]->ahir_Std.io_Data        = samp[which].base;
    AudioRqPtr[ok]->ahir_Std.io_Length      = samp[which].length[samp[which].bank];
#endif /* USE_PAULA */
    BeginIO((struct IORequest*) AudioRqPtr[ok]);
#endif
}

EXPORT void freefx(void)
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
}   }   }

MODULE void rq(STRPTR message)
{   printf((char*) "%s\n", message);
    cleanexit(EXIT_FAILURE);
}

MODULE void make_buffer(void)
{   // assert(MainWindowPtr);

    InitRastPort(&wpa8rastport);

    if (!(wpa8bitmap = AllocBitMap
    (   WINWIDTH,
        WINHEIGHT,
        8,
        0,
        MainWindowPtr->RPort->BitMap // NULL for Frodo! (doesn't seem to matter)
    )))
    {   rq((STRPTR) "AllocBitMap() failed!");
    }

    wpa8rastport.BitMap = wpa8bitmap;
}

MODULE void destroy_buffer(void)
{   if (wpa8bitmap)
    {   FreeBitMap(wpa8bitmap);
        wpa8bitmap = NULL;
}   }

EXPORT void start_sounds(void)
{
#ifdef NOSOUND
    ;
#else
    TRANSIENT int   i;
    PERSIST   FLAG  first  = TRUE;
#ifdef USE_PAULA
    PERSIST   UBYTE chan[] = {15,10,5};
#endif /* USE_PAULA */

    if (first)
    {   load_sounds();
        first = FALSE;
    }

    for (i = 0; i <= 3; i++)
    {   eversent[i] = FALSE;
        if (!(AudioPortPtr[i] = (struct MsgPort*) CreateMsgPort()))
        {   freefx();
            rq((STRPTR) "No port for effects!");
        }

#ifdef USE_PAULA
        if (!(AudioRqPtr[i] = (struct IOAudio*) CreateIORequest(AudioPortPtr[i], sizeof(struct IOAudio))))
#else
        if (!(AudioRqPtr[i] = (struct AHIRequest*) CreateIORequest(AudioPortPtr[i], sizeof(struct AHIRequest))))
#endif /* USE_PAULA */
        {   freefx();
            rq((STRPTR) "No I/O memory for effects!");
    }   }

#ifdef USE_PAULA
    AudioRqPtr[0]->ioa_Request.io_Message.mn_ReplyPort      = AudioPortPtr[0];
    AudioRqPtr[0]->ioa_Request.io_Message.mn_Node.ln_Pri    = 127;
    AudioRqPtr[0]->ioa_AllocKey                             = 0;
    AudioRqPtr[0]->ioa_Data                                 = chan;
    AudioRqPtr[0]->ioa_Length                               = 3;
    if ((AudioClosed = (FLAG) OpenDevice(AUDIONAME, 0, (struct IORequest*) AudioRqPtr[0], 0)))
#else
    AudioRqPtr[0]->ahir_Version = 4;
    if ((AudioClosed = (FLAG) OpenDevice(AHINAME  , 0, (struct IORequest*) AudioRqPtr[0], 0)))
#endif
    {   freefx();
        ssound = 0;
        // rq((STRPTR) "Can't allocate all channels for effects!");
    } else
    {   for (i = 1; i <= 3; i++)
#ifdef USE_PAULA
        {   CopyMem(AudioRqPtr[0], AudioRqPtr[i], sizeof(struct IOAudio));
#else
        {   CopyMem(AudioRqPtr[0], AudioRqPtr[i], sizeof(struct AHIRequest));
#endif /* USE_PAULA */
    }   }
#endif
}

EXPORT void stop_sounds(void)
{
#ifdef NOSOUND
    ;
#else
    int i;

    for (i = 0; i <= 3; i++)
    {   if (eversent[i] && AudioRqPtr[i])
        {   AbortIO((struct IORequest*) AudioRqPtr[i]);
            WaitIO((struct IORequest*) AudioRqPtr[i]);
        }
        eversent[i] = FALSE;
    }
#endif
}

EXPORT void checkpointer(void) { ; }
EXPORT void checksound(void)   { ; }

MODULE void make_bkgrnd(void)
{   int colour,
        i, j,
        x, y;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < WINWIDTH; x++)
        {   starfield[y][x] = pens[BLACK];
    }   }

    j = (WINWIDTH * MAPHEIGHT) / STARDENSITY;
    for (i = 0; i < j; i++)
    {   x = rand() % WINWIDTH;
        y = rand() % MAPHEIGHT;
        colour = OFFSET_STARS + (rand() % 14);
        if (colour == 24)
        {   colour = WHITE;
        }
        starfield[y][x] = pens[colour];
}   }

EXPORT void confine(void)   { ; }
EXPORT void unconfine(void) { ; }

MODULE void lockscreen(void)
{   // assert(!ScreenPtr);

    if (screenname[0])
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
#ifndef __AROS__
MODULE void iconify(void)
{   struct AppMessage*     AppMsg;
#ifdef __amigaos4__
    ULONG                  msgtype,
                           msgval;
    struct ApplicationMsg* AppLibMsg;
#endif

    if (!MainWindowPtr)
    {   return;
    }

    DISCARD RA_Iconify(WinObject);
    // the WinObject must stay a valid pointer
    MainWindowPtr = NULL;

    freepens();
    blanker_on();

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    do
    {   if ((Wait
        (   AppSignal
          | AppLibSignal
          | MainSignal
          | SIGBREAKF_CTRL_C
        )) & SIGBREAKF_CTRL_C)
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((AppMsg = (struct AppMessage*) GetMsg(AppPort)))
        {   switch (AppMsg->am_Type)
            {
            case AMTYPE_APPICON:
                uniconify();
            }
            ReplyMsg((struct Message*) AppMsg);
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
                    ScreenToFront(ScreenPtr);
                    // assert(MainWindowPtr);
                    WindowToFront(MainWindowPtr);
                    ActivateWindow(MainWindowPtr);
        }   }   }
#endif

    } while (!MainWindowPtr);
}

MODULE void uniconify(void)
{   // assert(!MainWindowPtr);

    getpens();
    changepen(currentbg);
    make_bkgrnd();

    if (!(MainWindowPtr = (struct Window*) RA_Uniconify(WinObject)))
    {   rq((char*) "Can't reopen window!");
    }
    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    draw_logo();
    draw_objects();
    if (!paused)
    {   blanker_off();
    }

    ActivateWindow(MainWindowPtr);
}
#endif /*ifndef __AROS__*/
MODULE void InitHook(struct Hook* hook, ULONG (*func)(), void* data)
{   // Make sure a pointer was passed

    if (hook)
    {   // Fill in the Hook fields
        #ifdef __amigaos4__
            hook->h_Entry    = func;
        #else
            hook->h_Entry    = (ULONG (*)()) HookEntry;
        #endif
        hook->h_SubEntry = func;
        hook->h_Data     = data;
    } else
    {   rq((char*) "Can't initialize hook!");
}   }

MODULE void getpens(void)
{   int  i;
    LONG rc;

    for (i = 0; i < PENS; i++)
    {   if (i >= 4 && i <= 12)
        {   continue;
        } // implied else

        rc = (LONG) ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            (ULONG) -1,
            Colours[1 + (i * 3)    ],
            Colours[1 + (i * 3) + 1],
            Colours[1 + (i * 3) + 2],
            PEN_EXCLUSIVE | PEN_NO_SETCOLOR
        );
        // it doesn't seem to actually get these exclusively
        // eg. it will work in a 2-colour (monochrome) host screenmode!
        if (rc == -1)
        {   gotpen[i] = FALSE;
            pens[i] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                Colours[1 + (i * 3)    ],
                Colours[1 + (i * 3) + 1],
                Colours[1 + (i * 3) + 2],
                -1
            );
        } else
        {   pens[i] = (UBYTE) rc;
            gotpen[i] = TRUE;
            SetRGB32
            (   &ScreenPtr->ViewPort,
                (ULONG) pens[i],
                Colours[1 + (i * 3)    ],
                Colours[1 + (i * 3) + 1],
                Colours[1 + (i * 3) + 2]
            );
}   }   }

MODULE void freepens(void)
{   int i;

    for (i = 0; i < PENS; i++)
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
}   }   }

MODULE void movepointer(void)
{   FLAG                  done;
    WORD                  x, y;
    int                   i;
    struct InputEvent     InputEvent;
    struct IEPointerPixel NewPixel;

    if (paused || gamemode != GAME)
    {   return;
    }

    done = TRUE;
    for (i = 0; i < nrockets; i++)
    {   if (controller[i] == MOUSE)
        {   done = FALSE;
            break; // for speed
    }   }

    if (done)
    {   return;
    } // implied else

    x = MainWindowPtr->MouseX;
    y = MainWindowPtr->MouseY;
    done = TRUE;
    if (x <  xoffset            ) { x = xoffset                ; done = FALSE; }
    if (x >= xoffset + WINWIDTH ) { x = xoffset + WINWIDTH  - 1; done = FALSE; }
    if (y <  yoffset + 1        ) { y = yoffset + 1            ; done = FALSE; } // +1 is just to make it less likely they will accidentally click titlebar gadgets
    if (y >= yoffset + MAPHEIGHT) { y = yoffset + MAPHEIGHT - 1; done = FALSE; }

/* The way that the limiting is done, the pointer can be momentarily out
of bounds. Watching IDCMP_MOUSEMOVE messages would probably enable such
movements to be intercepted in time. */

    if (!done)
    {   NewPixel.iepp_Screen        = (struct Screen*) ScreenPtr;
        NewPixel.iepp_Position.X    = MainWindowPtr->LeftEdge + x;
        NewPixel.iepp_Position.Y    = MainWindowPtr->TopEdge  + y;
        InputEvent.ie_EventAddress  = (APTR) &NewPixel;
        InputEvent.ie_NextEvent     = NULL;
        InputEvent.ie_Class         = IECLASS_NEWPOINTERPOS;
        InputEvent.ie_SubClass      = IESUBCLASS_PIXEL;
        InputEvent.ie_Code          = IECODE_NOBUTTON;
        InputEvent.ie_Qualifier     = 0; // works better than NULL under OS4
        InputIO->io_Data            = (APTR) &InputEvent;
        InputIO->io_Length          = sizeof(struct InputEvent);
        InputIO->io_Command         = (UWORD) IND_WRITEEVENT;
        DISCARD DoIO((struct IORequest*) InputIO);
}   }

EXPORT void changepen(int towhat)
{   LONG rc;

    if (gotpen[BGPEN])
    {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[BGPEN]);
        gotpen[BGPEN] = FALSE;
    }

    rc = (LONG) ObtainPen
    (   ScreenPtr->ViewPort.ColorMap,
        (ULONG) -1,
        Colours[1 + (towhat * 3)    ],
        Colours[1 + (towhat * 3) + 1],
        Colours[1 + (towhat * 3) + 2],
        PEN_EXCLUSIVE | PEN_NO_SETCOLOR
    );
    // it doesn't seem to actually get these exclusively
    // eg. it will work in a 2-colour (monochrome) host screenmode!
    if (rc == -1)
    {   gotpen[BGPEN] = FALSE;
        pens[BGPEN] = FindColor
        (   ScreenPtr->ViewPort.ColorMap,
            Colours[1 + (towhat * 3)    ],
            Colours[1 + (towhat * 3) + 1],
            Colours[1 + (towhat * 3) + 2],
            -1
        );
    } else
    {   pens[BGPEN] = (UBYTE) rc;
        gotpen[BGPEN] = TRUE;
        SetRGB32
        (   &ScreenPtr->ViewPort,
            (ULONG) pens[BGPEN],
            Colours[1 + (towhat * 3)    ],
            Colours[1 + (towhat * 3) + 1],
            Colours[1 + (towhat * 3) + 2]
        );
    }

    currentbg = towhat;
}

MODULE void parsewb(void)
{   struct DiskObject* DiskObject;
    STRPTR*            ToolArray;
    STRPTR             s;

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        if ((s = FindToolType(ToolArray, "PUBSCREEN")))
        {   strcpy(screenname, s);
        }
        FreeDiskObject(DiskObject);
}   }

MODULE void blanker_on(void)
{
#ifdef __amigaos4__
    if (AppID)
    {   // assert(ApplicationBase);
        // assert(IApplication);
        SetApplicationAttrs
        (   AppID,
            APPATTR_AllowsBlanker, TRUE,
        TAG_DONE);
    }
#else
    ;
#endif
}

MODULE void blanker_off(void)
{
#ifdef __amigaos4__
    if (AppID)
    {   // assert(ApplicationBase);
        // assert(IApplication);
        SetApplicationAttrs
        (   AppID,
            APPATTR_AllowsBlanker, FALSE,
        TAG_DONE);
    }
#else
    ;
#endif
}

EXPORT void clearkybd(void)
{   struct Message* MsgPtr;

    while ((MsgPtr = GetMsg(MainWindowPtr->UserPort)))
    {   ReplyMsg(MsgPtr);
}   }

EXPORT void waitforkey(void)
{   if ((Wait
    (   AppSignal
      | AppLibSignal
      | MainSignal
      | SIGBREAKF_CTRL_C
    )) & SIGBREAKF_CTRL_C)
    {   cleanexit(EXIT_SUCCESS);
}   }

MODULE void setpointer(void)
{   if (showpointer)
    {
#ifdef __MORPHOS__
        if (WinObject)
        {   DISCARD SetAttrs(WinObject, WA_PointerType, POINTERTYPE_AIMING,    TAG_END);
        } else
#else
        SetPointer(MainWindowPtr, (UWORD*) CrossData,            15, 15, -8, -7);
#endif
    } else
    {
#ifdef __MORPHOS__
        if (WinObject)
        {   DISCARD SetAttrs(WinObject, WA_PointerType, POINTERTYPE_INVISIBLE, TAG_END);
        } else
#else
        SetPointer(MainWindowPtr, (UWORD*) InvisiblePointerData,  1,  1,  0,  0);
#endif
}   }
