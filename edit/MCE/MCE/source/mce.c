#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char* STRPTR;
    typedef char* CONST_STRPTR;
    typedef char  TEXT;
    #define ASM
    #define REG(x)
    #define __inline
#endif

#include <exec/types.h>
#include <exec/nodes.h>
#include <exec/memory.h>
#include <exec/resident.h>
#include <exec/execbase.h>
#include <dos/dos.h>
#include <dos/dostags.h>
#include <dos/dosextens.h>
#ifdef __amigaos4__
    #include <dos/obsolete.h>          // CurrentDir()
#endif
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/displayinfo.h>
#include <workbench/icon.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <intuition/icclass.h>
#define ASL_PRE_V38_NAMES
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <libraries/amigaguide.h>
#ifdef __amigaos4__
    #include <intuition/menuclass.h>
    #include <libraries/application.h>
#endif
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#include <utility/tagitem.h>
#include <workbench/workbench.h>       /* struct DiskObject */
#include <gadgets/gradientslider.h>
#include <gadgets/virtual.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/amigaguide.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <proto/asl.h>
#include <proto/datatypes.h>
#include <proto/diskfont.h>
#include <proto/gadtools.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/utility.h>
#include <proto/wb.h>
#include <clib/alib_protos.h>

#include <proto/chooser.h>
#include <proto/listbrowser.h>
#include <proto/string.h>
#ifdef __MORPHOS__
    #include <intuition/pointerclass.h>
    #define TextFieldBase TextEditorBase
#else
    #include <gadgets/clock.h>
#endif

#include <ctype.h>
#include <stdio.h>                     /* FILE, printf() */
#include <stdlib.h>                    /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef __SASC
    #include <dos.h>                   // geta4()
#endif

#include "mce.h"

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
        #include <proto/openurl.h>
        #include <libraries/openurl.h>
    #endif
#endif

#ifdef __MORPHOS__
#define SKETCHBOARD_GetClass() LP0(30, Class*, SKETCHBOARD_GetClass, , \
SketchBoardBase, 0, 0, 0, 0, 0, 0)
//Class* SKETCHBOARD_GetClass();
#define SGTOOL_FREEHAND_DOTS  0 /* default */
#define SGTOOL_FREEHAND       1
#define SGTOOL_ELLIPSE        2
#define SGTOOL_ELLIPSE_FILLED 3
#define SGTOOL_RECT           4
#define SGTOOL_RECT_FILLED    5
#define SGTOOL_LINE           6
#define SGTOOL_FILL           7
#define SGTOOL_GETPEN         8
#define SGTOOL_SELECT        10
#define SGTOOL_MOVE          11
#define SKETCHBOARD_Dummy   (REACTION_Dummy + 0x24600)
#define SGA_BitMap          (SKETCHBOARD_Dummy + 0L)
#define SGA_Width           (SKETCHBOARD_Dummy + 3L)
#define SGA_Height          (SKETCHBOARD_Dummy + 4L)
#define SGA_APen            (SKETCHBOARD_Dummy + 5L)
#define SGA_Tool            (SKETCHBOARD_Dummy + 6L)
#define SGA_UndoAvailable   (SKETCHBOARD_Dummy + 7L)
#define SGA_RedoAvailable   (SKETCHBOARD_Dummy + 8L)
#define SGA_ShowGrid        (SKETCHBOARD_Dummy + 9L)
#define SGA_Scale           (SKETCHBOARD_Dummy + 10L)
#define SGA_TopLayerBitmap  (SKETCHBOARD_Dummy + 27L)
#define SGA_TopLayerWidth   (SKETCHBOARD_Dummy + 28L)
#define SGM_Clear           (0x580100L) 
#define SGM_Undo            (0x580101L)
#define SGM_Redo            (0x580102L)
#else
#include <gadgets/sketchboard.h>
#include <proto/sketchboard.h>
#endif
#if defined(__amigaos4__) || defined(__MORPHOS__)
#define SGA_MaxScale        (SKETCHBOARD_Dummy + 33L)
#endif

// 2. DEFINES ------------------------------------------------------------

// #define TRACKEXIT
#define TRACKDELAY 15

#define OS4IMAGES         10

// main window
#define GID_0_LY1          0
#define GID_0_CT1          1
#define GID_0_PA1          2
#define GID_0_ST1          3

// splash window
#define GID_0_FG1          4

// main window (again)
#define GID_0_BU1          5 // the function buttons must start from GID_0_BU1,
                             // and must all be consecutive.

// About window (as this is modeless the gadget IDs must be unique)
#define GID_0_BU100       598 // site link in About window
#define GID_0_BU101       599 // email link in About window

// ReAction window
#define GID_0_LB1         600 // ReAction class versions

#define GIDS_0            GID_0_LB1

#define CONFIGLENGTH      4 // data goes from 0..CONFIGLENGTH-1
#define CONFIGVERSION     1 // means V15.1+
#define CONFIGMAGIC       5

#define ONE_BILLION       1000000000

#define AddSeparator MA_AddChild, MSeparator, MEnd

#define GameButton(x)     LAYOUT_AddChild, gadgets[GID_0_BU1 + x] = (struct Gadget*) \
ButtonObject, \
    GA_ID,                GID_0_BU1 + x, \
    GA_RelVerify,         TRUE, \
    GA_Image,             menufimage[x + 1], \
    BUTTON_BackgroundPen, bgpen, \
    BUTTON_FillPen,       bgpen, \
    BUTTON_Justification, BCJ_LEFT, \
ButtonEnd, \
CHILD_WeightedWidth,      0
#define ThreeRow(x)       AddHLayout, AddSpace, GameButton(x), GameButton(x + 1), GameButton(x + 2), AddSpace, LayoutEnd
#define FourRow(x)        AddHLayout, GameButton(x), GameButton(x + 1), GameButton(x + 2), GameButton(x + 3),  LayoutEnd

#define PAGES             5 // Zerg :-)

#define ARGUMENTS         6 // counting from 1 (they go 0..5)

#if defined(__amigaos4__) || defined(__MORPHOS__)
    #ifdef __MORPHOS__
        #define _SYS_SOCKET_H_
        struct sockaddr
        {   u_char  sa_len;                 /* total length */
            u_char  sa_family;              /* address family */
            char    sa_data[14];            /* actually longer; address value */
        };
        struct msghdr
        {   caddr_t msg_name;               /* optional address */
            u_int   msg_namelen;            /* size of address */
            struct  iovec *msg_iov;         /* scatter/gather array */
            u_int   msg_iovlen;             /* # elements in msg_iov */
            caddr_t msg_control;            /* ancillary data, see below */
            u_int   msg_controllen;         /* ancillary data buffer len */
            int     msg_flags;              /* flags on received message */
        };
        struct hostent
        {   char*          h_name;
            char**         h_aliases;
            int            h_addrtype;
            int            h_length;
            char**         h_addr_list;
        };

        #define SOCK_STREAM    1 /* stream socket */
        #define AF_INET        2 /* internetwork: UDP, TCP, etc. */
    #endif

    #include <sys/socket.h>
    #include <proto/socket.h>
    #ifndef __MORPHOS__
        #include <netdb.h>
    #endif
    #include <errno.h>
#else
    struct sockaddr
    {   UBYTE sa_len;      /* total length */
        UBYTE sa_family;   /* address family */
        char  sa_data[14]; /* actually longer; address value */
    };
    struct in_addr
    {   ULONG          s_addr;
    };
    struct sockaddr_in
    {   UBYTE          sin_len;
        UBYTE          sin_family;
        USHORT         sin_port;
        struct in_addr sin_addr;
        char           sin_zero[8];
    };
    struct hostent
    {   char*          h_name;
        char**         h_aliases;
        int            h_addrtype;
        int            h_length;
        char**         h_addr_list;
    };

    #define howmany(x, y)   (((x)+((y)-1))/(y))
    #define SOCK_STREAM    1 /* stream socket */
    #define AF_INET        2 /* internetwork: UDP, TCP, etc. */

    extern int errno;

    struct hostent* gethostbyname(const UBYTE* name);
    LONG recv(LONG s, UBYTE* buf, LONG len, LONG flags); /* V3 */
    LONG CloseSocket(LONG d);
    LONG connect(LONG s, const struct sockaddr* name, LONG namelen);
    LONG send(LONG s, const UBYTE* msg, LONG len, LONG flags);
    LONG socket(LONG domain, LONG type, LONG protocol);
    LONG shutdown(LONG s, LONG how);
    char* Inet_NtoA(struct in_addr in);
    ULONG inet_addr(char* cp);

    #pragma libcall SocketBase gethostbyname D2 801
    #pragma libcall SocketBase recv 4E 218004
    #pragma libcall SocketBase CloseSocket 78 001
    #pragma libcall SocketBase connect 36 18003
    #pragma libcall SocketBase send 42 218004
    #pragma libcall SocketBase socket 1E 21003
    #pragma libcall SocketBase shutdown 54 1002
    #pragma libcall SocketBase Inet_NtoA AE 001
    #pragma libcall SocketBase inet_addr B4 801
#endif

#define NEVER FALSE

// 3. EXPORTED VARIABLES -------------------------------------------------

EXPORT FLAG                    cancelling,
                               cliname          = FALSE,
                               crosshair,
                               lame             = FALSE,
                               morphos          = FALSE,
                               narrowchoosers,
                               os4menus         = FALSE,
                               titlemode        = FALSE;
EXPORT TEXT                    cpu[5 + 1],
                               filename[MAX_PATH + 1],
                               fpu[5 + 1],
                               pathname[MAX_PATH + 1],
                               weekdaystring[LEN_DATSTRING],
                               datestring[LEN_DATSTRING],
                               timestring[LEN_DATSTRING];
EXPORT UBYTE                   convert[256], // convert from the pen we actually allocated to our own pen number
                               convert2[256], // convert from the pen we actually allocated to our own pen number
                               IOBuffer[IOBUFFERSIZE],
                               ScrnData[64000],
                               stamp,
                               TileData[320000], // enough for 5*320*200 (for Rockford)
                               tileplanes[256]; // enough for SideWinder 1
EXPORT __aligned UBYTE         scrndisplay[GFXINIT(320, 200)];
EXPORT UBYTE*                  scrnbyteptr[200];
EXPORT const UBYTE             from_platform[16],
                               to_platform[16];
EXPORT SWORD                   screenwidth      =  1024,
                               screenheight     =   768;
EXPORT ULONG                   AboutSignal,
                               currenttool      = 1,
                               fgpen_intable    = 0,
                               fgpen_real,
                               game             = ~0,
                               MainSignal,
                               offset,
                               pending          = 0,
                               redoable,
                               rf_world         = 0,
                               showgrid         = TRUE,
                               showtoolbar      = TRUE,
                               undoable;
EXPORT LONG                    pens[PENS],
                               gamesize,
                               whitepen;
EXPORT int                     bu3, bu4, pl1, sb2, sb3, sk1,
                               function,
                               gadmode,
                               loaded           = FUNC_MENU,
                               n1, n2,
                               page,
                               penoffset,
                               scalex,
                               scaley,
                               serializemode,
                               stringextra,
                               propfontx,
                               propfonty,
                               tilewidth,
                               tileheight,
                               xoffset,
                               yoffset;
EXPORT struct IBox             winbox[FUNCTIONS + 1];
EXPORT struct List             SexList,
                               SpeedBarList;
EXPORT struct HintInfo*        HintInfoPtr;
EXPORT struct TextFont*        FontPtr          = NULL;
EXPORT struct Menu*            MenuPtr          = NULL;
EXPORT struct Screen          *CustomScreenPtr  = NULL,
                              *ScreenPtr        = NULL;
EXPORT struct Window          *MainWindowPtr    = NULL,
                              *SplashWindowPtr  = NULL,
                              *SubWindowPtr     = NULL;
EXPORT struct VisualInfo*      VisualInfoPtr    = NULL;
EXPORT struct ExAllData*       EADataPtr        = NULL;
EXPORT Object                 *WinObject        = NULL, // note that WindowObject is a reserved macro
                              *SplashWinObject  = NULL,
                              *SubWinObject     = NULL;
EXPORT struct Node*            SpeedBarNodePtr[SBGADGETS];
EXPORT struct DiskObject*      IconifiedIcon /* = NULL */ ;
EXPORT struct MsgPort*         AppPort          = NULL;
EXPORT struct DrawInfo*        DrawInfoPtr   /* = NULL */ ;
EXPORT struct Image           *aissimage[AISSIMAGES],
                              *fimage[FUNCTIONS + 1],
                              *image[BITMAPS];
EXPORT struct Hook             ToolHookStruct,
                               ToolSubHookStruct;
EXPORT struct RastPort         sketchrastport,
                               wpa8rastport[2],
                               wpa8tilerastport;
EXPORT struct Gadget*          gadgets[GIDS_MAX + 1];
EXPORT struct BitMap*          wpa8bitmap[2]    = { NULL, NULL };
EXPORT UBYTE                  *byteptr1[DISPLAY1HEIGHT],
                              *byteptr2[DISPLAY2HEIGHT];
EXPORT __aligned UBYTE         display1[DISPLAY1SIZE],
                               display2[DISPLAY2SIZE];
EXPORT struct Library         *BitMapBase       = NULL,
                              *BoingBallBase    = NULL,
                              *ButtonBase       = NULL,
                              *CheckBoxBase     = NULL,
                              *ChooserBase      = NULL,
                              *ClickTabBase     = NULL,
                              *DatatypesBase    = NULL,
                              *DiskfontBase     = NULL,
                              *FuelGaugeBase    = NULL,
                              *GetColorBase     = NULL,
                              *GradientSliderBase = NULL,
                              *IFFParseBase     = NULL,
                              *IntegerBase      = NULL,
                              *LabelBase        = NULL,
                              *LayoutBase       = NULL,
                              *ListBrowserBase  = NULL,
                              *PaletteBase      = NULL,
                              *RadioButtonBase  = NULL,
                              *RequesterBase    = NULL,
                              *ScrollerBase     = NULL,
                              *SketchBoardBase  = NULL,
                              *SliderBase       = NULL,
                              *SpaceBase        = NULL,
                              *SpeedBarBase     = NULL,
                              *StringBase       = NULL,
                              *TextFieldBase    = NULL,
                           // *UtilityBase      = NULL,
                              *VirtualBase      = NULL,
                              *WindowBase       = NULL,
                              *AmigaGuideBase   = NULL,
                              *AslBase          = NULL,
                              *GadToolsBase     = NULL,
                              *IconBase         = NULL,
                              *OpenURLBase      = NULL,
                              *SocketBase       = NULL,
                              *VersionBase      = NULL,
                              *WorkbenchBase    = NULL;
#if (defined(__VBCC__) && defined(__amigaos4__)) || defined(__SASC) || (!defined(__VBCC__) && defined(__MORPHOS__))
    EXPORT struct Library*         UtilityBase        = NULL;
#else
    EXPORT struct UtilityBase*     UtilityBase        = NULL;
#endif
#if defined(__VBCC__) && defined(__amigaos4__)
    EXPORT struct Library         *GfxBase            = NULL,
                                  *IntuitionBase      = NULL;
#else
    EXPORT struct GfxBase*         GfxBase            = NULL;
    EXPORT struct IntuitionBase*   IntuitionBase      = NULL;
#endif
#ifndef __MORPHOS__
    EXPORT struct ClassLibrary*    ClockBase          = NULL;
    EXPORT        Class*           ClockClass         = NULL;
    EXPORT struct ClockHandSize    shapeNoSecond      = { 0, 0, 0, 0, 0 }, // probably these
                                   shapeNoMinute      = { 0, 0, 0, 0, 0 }; // can be merged
    EXPORT UWORD*                  MouseData;
#endif

#ifdef __amigaos4__
EXPORT struct AmigaGuideIFace*     IAmigaGuide        = NULL;
EXPORT struct ApplicationIFace*    IApplication       = NULL;
EXPORT struct AslIFace*            IAsl               = NULL;
EXPORT struct DataTypesIFace*      IDataTypes         = NULL;
EXPORT struct DiskfontIFace*       IDiskfont          = NULL;
EXPORT struct GadToolsIFace*       IGadTools          = NULL;
EXPORT struct GraphicsIFace*       IGraphics          = NULL;
EXPORT struct IconIFace*           IIcon              = NULL;
EXPORT struct IFFParseIFace*       IIFFParse          = NULL;
EXPORT struct IntuitionIFace*      IIntuition         = NULL;
EXPORT struct OpenURLIFace*        IOpenURL           = NULL;
EXPORT struct SocketIFace*         ISocket            = NULL;
EXPORT struct UtilityIFace*        IUtility           = NULL;
EXPORT struct WorkbenchIFace*      IWorkbench         = NULL;

EXPORT struct BitMapIFace*         IBitMap            = NULL;
EXPORT struct ButtonIFace*         IButton            = NULL;
EXPORT struct CheckBoxIFace*       ICheckBox          = NULL;
EXPORT struct ChooserIFace*        IChooser           = NULL;
EXPORT struct ClickTabIFace*       IClickTab          = NULL;
EXPORT struct FuelGaugeIFace*      IFuelGauge         = NULL;
EXPORT struct GetColorIFace*       IGetColor          = NULL;
EXPORT struct GradientSliderIFace* IGradientSlider    = NULL;
EXPORT struct IntegerIFace*        IInteger           = NULL;
EXPORT struct LabelIFace*          ILabel             = NULL;
EXPORT struct LayoutIFace*         ILayout            = NULL;
EXPORT struct ListBrowserIFace*    IListBrowser       = NULL;
EXPORT struct PaletteIFace*        IPalette           = NULL;
EXPORT struct RadioButtonIFace*    IRadioButton       = NULL;
EXPORT struct RequesterIFace*      IRequester         = NULL;
EXPORT struct ScrollerIFace*       IScroller          = NULL;
EXPORT struct SketchBoardIFace*    ISketchBoard       = NULL;
EXPORT struct SliderIFace*         ISlider            = NULL;
EXPORT struct SpaceIFace*          ISpace             = NULL;
EXPORT struct SpeedBarIFace*       ISpeedBar          = NULL;
EXPORT struct StringIFace*         IString            = NULL;
EXPORT struct TextEditorIFace*     ITextEditor        = NULL;
EXPORT struct VirtualIFace*        IVirtual           = NULL;
EXPORT struct WindowIFace*         IWindow            = NULL;

EXPORT struct Library*             ApplicationBase    = NULL;
EXPORT struct Image*               menuimage[OS4IMAGES]; // they go from 0..OS4IMAGES-1
#endif

EXPORT struct HintInfo thehintinfo[] = {
{  0,  1, "Open (Amiga-O)", 0},
{  0,  2, "Save (Amiga-S)", 0},
{ -1, -1, NULL            , 0}  // terminator
};

EXPORT struct EasyStruct EasyStruct =
{   sizeof(struct EasyStruct),
    0,
    NULL,
    NULL,
    NULL
#ifdef __amigaos4__
  , NULL
  , NULL
#endif
};

EXPORT struct TagItem CTtoPAmap[] = {
{ CLICKTAB_Current, PAGE_Current     },
{ TAG_END,          0                }
}, PAtoCTmap[] = {
{ PAGE_Current,     CLICKTAB_Current },
{ TAG_END,          0                }
};

EXPORT const UBYTE from_platform[16] = {
 6, //  0 $02E
 0, //  1 $000 (or make it 8?)
 4, //  2 $CA6
12, //  3 $ECA
 2, //  4 $862
10, //  5 $AAA
 6, //  6 $02E
14, //  7 $0AE
 1, //  8 $640
 9, //  9 $888
 5, // 10 $EC8
13, // 11 $E00
 3, // 12 $ECA
11, // 13 $CCC
 7, // 14 $800 (cycling)
15, // 15 $EEE
}, to_platform[16] = {
 1, //  0
 8, //  1
 4, //  2
12, //  3
 2, //  4
10, //  5
 6, //  6 (or make it 0?)
14, //  7
 1, //  8
 9, //  9
 5, // 10
13, // 11
 3, // 12
11, // 13
 7, // 14
15, // 15
}, from_bg[16][5] = {
{  0,  0,  0,  0,  0 }, //  0
{  6,  6,  3,  3,  1 }, //  1
{ 14,  2,  2,  2,  2 }, //  2
{  1,  5,  4,  1,  3 }, //  3
{  2,  9,  5, 14,  4 }, //  4
{  9,  1,  1,  5, 15 }, //  5
{  3,  3,  9,  4, 15 }, //  6
{ 10, 10,  6,  9, 15 }, //  7
{  4,  4, 10, 10,  9 }, //  8
{ 11, 11, 11,  6,  5 }, //  9
{ 13, 13, 15, 11, 10 }, // 10
{  5, 12, 15, 13, 11 }, // 11
{ 12, 15, 15, 12, 13 }, // 12
{ 15, 15, 15, 15,  6 }, // 13
{ 15, 15, 15, 15, 15 }, // 14
{ 15, 15, 15, 15, 15 }, // 15
};

// function pointers
EXPORT FLAG (* tool_open)      (FLAG loadas);
EXPORT void (* tool_save)      (FLAG saveas);
EXPORT void (* tool_close)     (void);
EXPORT void (* tool_loop)      (ULONG gid, ULONG code);
EXPORT void (* tool_exit)      (void);
EXPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 4. IMPORTED VARIABLES -------------------------------------------------

#ifndef __amigaos4__
    IMPORT struct ExecBase*    SysBase;
#endif

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                    bb1sk             = FALSE,
                               broken,
                               globaldone,
                               guideexists       = FALSE,
                               loaded_fimages    = FALSE,
                               reopen            = FALSE,
                               specifiedscreen   = FALSE,
                               urlopen           = FALSE,
                               wasrun[FUNCTIONS + 1];
MODULE TEXT                    asldir[MAX_PATH + 1] = "PROGDIR:Examples",
                               aslfile[MAX_PATH + 1],
                               aslresult[MAX_PATH + 1],
                               replystring[1000],
                               screenname[MAXPUBSCREENNAME + 1],
                               titlebartext[80 + MAX_PATH + 1];
MODULE UWORD                   wbver,
                               wbrev;
MODULE SLONG                   closer            = 0;
MODULE LONG                    clockpens[CLOCKPENS];
MODULE ULONG                   AppSignal         = 0,
                               AppLibSignal      = 0,
#ifdef __MORPHOS__
                               custompointer     = FALSE,
#else
                               custompointer     = TRUE,
#endif
                               functab           = 0,
                               newpage;
MODULE int                     firstgad[PAGES],
                               speedbar;
MODULE UBYTE*                  tilebyteptr[64];
MODULE BPTR                    ProgLock          = ZERO;
MODULE __aligned UBYTE         tiledisplay[GFXINIT(64, 64)];
MODULE struct List             CommandBarList,
                               PaintBarList;
MODULE        Object*          AboutWinObject    = NULL;
MODULE struct BitMap          *sketchbitmap      = NULL,
                              *wpa8tilebitmap    = NULL;
MODULE struct Image*           menufimage[FUNCTIONS + 1];
MODULE struct RDArgs*          ArgsPtr           = NULL;
MODULE struct Screen*          newscr;
MODULE struct Window*          AboutWindowPtr    = NULL;
MODULE struct WBArg*           WBArg             = NULL;
MODULE struct WBStartup*       WBMsg             = NULL;
MODULE struct SpeedBarNode    *CommandBarNodePtr[COMMANDNODES],
                              *PaintBarNodePtr[PAINTNODES];

#ifdef __amigaos4__
    MODULE LONG                menuimagesize     = 16; // overridden by user's MenuImageSize environment variable
    MODULE ULONG               AppID             = 0; // not NULL!
    MODULE struct MsgPort*     AppLibPort        = NULL;
#endif
#ifndef __MORPHOS__
    MODULE FLAG                changedcolours    = FALSE;
    MODULE ULONG               colour17,
                               colour18,
                               colour19;
#endif                               

// this is required as GCC optimizes out any if (0) statement;
// as a result the version embedding was not working correctly.
USED const STRPTR verstag = VERSIONSTRING;

MODULE const ULONG painttool[] = {
SGTOOL_FREEHAND_DOTS,
SGTOOL_FREEHAND,
SGTOOL_LINE,
SGTOOL_RECT,
SGTOOL_RECT_FILLED,
SGTOOL_ELLIPSE,
SGTOOL_ELLIPSE_FILLED,
SGTOOL_FILL,
SGTOOL_GETPEN,
#ifndef __amigaos4__
SGTOOL_SELECT,
SGTOOL_MOVE,
#endif
};

// 6. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   const STRPTR pathname;
    const FLAG   transparent;
} imagename[BITMAPS] = {
{ "amigan"                 , FALSE }, //   0 (BITMAP_AMIGAN)
{ "cov/jedi"               , FALSE }, //   1 COV
{ "cov/arcturian"          , FALSE }, //   2
{ "cov/ant"                , FALSE }, //   3
{ "cov/denk"               , FALSE }, //   4
{ "cov/elf"                , FALSE }, //   5
{ "cov/lizard"             , FALSE }, //   6
{ "u4/mage"                , FALSE }, //   7 U4
{ "u4/bard"                , FALSE }, //   8
{ "u4/fighter"             , FALSE }, //   9
{ "u4/druid"               , FALSE }, //  10
{ "u4/tinker"              , FALSE }, //  11
{ "u4/paladin"             , FALSE }, //  12
{ "u4/ranger"              , FALSE }, //  13
{ "u4/shepherd"            , FALSE }, //  14
{ "fta/arrow"              , FALSE }, //  15 FTA
{ "fta/birdtotem"          , FALSE }, //  16
{ "fta/bluekey"            , FALSE }, //  17
{ "fta/bluestone"          , FALSE }, //  18
{ "fta/bone"               , FALSE }, //  19
{ "fta/book"               , FALSE }, //  20
{ "fta/bow"                , FALSE }, //  21
{ "fta/crystalorb"         , FALSE }, //  22
{ "fta/dirk"               , FALSE }, //  23
{ "fta/fruit"              , FALSE }, //  24
{ "fta/glassvial"          , FALSE }, //  25
{ "fta/goldkey"            , FALSE }, //  26
{ "fta/goldring"           , FALSE }, //  27
{ "fta/goldstatue"         , FALSE }, //  28
{ "fta/greenjewel"         , FALSE }, //  29
{ "fta/greenkey"           , FALSE }, //  30
{ "fta/greykey"            , FALSE }, //  31
{ "fta/herb"               , FALSE }, //  32
{ "fta/jadeskull"          , FALSE }, //  33
{ "fta/lasso"              , FALSE }, //  34
{ "fta/mace"               , FALSE }, //  35
{ "fta/redkey"             , FALSE }, //  36
{ "fta/rose"               , FALSE }, //  37
{ "fta/shard"              , FALSE }, //  38
{ "fta/shell"              , FALSE }, //  39
{ "fta/sunstone"           , FALSE }, //  40
{ "fta/sword"              , FALSE }, //  41
{ "fta/talisman"           , FALSE }, //  42
{ "fta/wand"               , FALSE }, //  43
{ "fta/whitekey"           , FALSE }, //  44
{ "fta/writ"               , FALSE }, //  45
{ "u3/cleric"              , FALSE }, //  46 (U3_IMAGE_CLERIC)
{ "u3/fighter"             , FALSE }, //  47 (U3_IMAGE_FIGHTER)
{ "u3/lark"                , FALSE }, //  48 (U3_IMAGE_LARK)
{ "u3/ranger"              , FALSE }, //  49 (U3_IMAGE_RANGER)
{ "u3/thief"               , FALSE }, //  50 (U3_IMAGE_THIEF)
{ "u3/wizard"              , FALSE }, //  51 (U3_IMAGE_WIZARD)
{ "u5/avatar"              , FALSE }, //  52 U5
{ "u5/bard"                , FALSE }, //  53
{ "u5/fighter"             , FALSE }, //  54
{ "u5/mage"                , FALSE }, //  55
{ ""                       , FALSE }, //  56 (spare)
{ "q2/none"                , FALSE }, //  57 Q2
{ "q2/bird"                , FALSE }, //  58
{ "q2/ship"                , FALSE }, //  59
{ "q2/donkey"              , FALSE }, //  60
{ "q2/horse"               , FALSE }, //  61
{ "q2/camel"               , FALSE }, //  62
{ "q2/plebe"               , FALSE }, //  63
{ "q2/adventurer"          , FALSE }, //  64
{ "q2/scout"               , FALSE }, //  65
{ "q2/apprentice"          , FALSE }, //  66
{ "q2/knight"              , FALSE }, //  67
{ "q2/priest"              , FALSE }, //  68
{ "hillsfar/chime"         , FALSE }, //  69 HF
{ "hillsfar/locksmith"     , FALSE }, //  70
{ "hillsfar/potion"        , FALSE }, //  71
{ "hillsfar/ring"          , FALSE }, //  72
{ "hillsfar/rod"           , FALSE }, //  73
{ "tol/knight"             , TRUE  }, //  74 TOL
{ "tol/valkyrie"           , TRUE  }, //  75
{ "tol/barbarian"          , TRUE  }, //  76
{ "tol/food"               , TRUE  }, //  77
{ "tol/gold"               , TRUE  }, //  78
{ "tol/axe"                , TRUE  }, //  79
{ "tol/boots"              , TRUE  }, //  80
{ "tol/brownpotion"        , TRUE  }, //  81
{ "tol/brownscroll"        , TRUE  }, //  82
{ "tol/confession"         , TRUE  }, //  83
{ "tol/chime"              , TRUE  }, //  84
{ "tol/dagger"             , TRUE  }, //  85
{ "tol/greenkey"           , TRUE  }, //  86
{ "tol/greenpotion"        , TRUE  }, //  87
{ "tol/greenscroll"        , TRUE  }, //  88
{ "tol/holywater"          , TRUE  }, //  89
{ "tol/medallion"          , TRUE  }, //  90
{ "tol/note"               , TRUE  }, //  91
{ "tol/orangekey"          , TRUE  }, //  92
{ "tol/photo"              , TRUE  }, //  93
{ "tol/ring"               , TRUE  }, //  94
{ "tol/rock"               , TRUE  }, //  95
{ "tol/sphere"             , TRUE  }, //  96
{ "tol/tablet"             , TRUE  }, //  97
{ "tol/urn"                , TRUE  }, //  98
{ "tol/whitekey"           , TRUE  }, //  99
{ "tol/whitepotion"        , TRUE  }, // 100
{ "tol/whitescroll"        , TRUE  }, // 101
{ "tol/whitescroll"        , TRUE  }, // 102 (scroll of life)
{ "u6/class"               , FALSE }, // 103 U6
{ "pirates/spanish"        , FALSE }, // 104 PIR
{ "pirates/english"        , FALSE }, // 105
{ "pirates/french"         , FALSE }, // 106
{ "pirates/dutch"          , FALSE }, // 107
{ "pirates/other"          , FALSE }, // 108
{ "w6/fire"                , FALSE }, // 109 W6
{ "w6/water"               , FALSE }, // 110
{ "w6/air"                 , FALSE }, // 111
{ "w6/earth"               , FALSE }, // 112
{ "w6/mental"              , FALSE }, // 113
{ "w6/magic"               , FALSE }, // 114
{ "w6/rebirths"            , FALSE }, // 115
{ "w6/asleep"              , FALSE }, // 116
{ "w6/blind"               , FALSE }, // 117
{ ""                       , FALSE }, // 118 (spare)
{ "bard/shoppe2"           , FALSE }, // 119 BT
{ "lol/key"                , FALSE }, // 120 LOL
{ "lol/axe"                , FALSE }, // 121
{ "lol/lantern"            , FALSE }, // 122
{ "lol/amulet"             , FALSE }, // 123
{ "lol/compass"            , FALSE }, // 124
{ "lol/orb"                , FALSE }, // 125
{ "lol/rose"               , FALSE }, // 126
{ "lol/mirror"             , FALSE }, // 127
{ "lol/wood"               , FALSE }, // 128
{ "lol/rope"               , FALSE }, // 129
{ "lol/unicorn"            , FALSE }, // 130
{ "lol/horn"               , FALSE }, // 131
{ "lol/spellbook"          , FALSE }, // 132
{ "lol/gem"                , FALSE }, // 133
{ "lol/potion"             , FALSE }, // 134
{ "u6/portrait-1"          , FALSE }, // 135 U6
{ "u6/portrait-2"          , FALSE }, // 136
{ "u6/portrait-3"          , FALSE }, // 137
{ "u6/portrait-4"          , FALSE }, // 138
{ "u6/portrait-5"          , FALSE }, // 139
{ "u6/portrait-6"          , FALSE }, // 140
{ "u6/portrait-7"          , FALSE }, // 141
{ "u6/portrait-8"          , FALSE }, // 142
{ "u6/portrait-9"          , FALSE }, // 143
{ "u6/portrait-10"         , FALSE }, // 144
{ "u6/portrait-11"         , FALSE }, // 145
{ "u6/portrait-12"         , FALSE }, // 146
{ "bw/gs"                  , FALSE }, // 147 BW
{ "bw/yc"                  , FALSE }, // 148
{ "bw/rh"                  , FALSE }, // 149
{ "bw/bd"                  , FALSE }, // 150
{ "bw/ys"                  , FALSE }, // 151
{ "bw/rc"                  , FALSE }, // 152
{ "bw/bh"                  , FALSE }, // 153
{ "bw/gd"                  , FALSE }, // 154
{ "bw/rs"                  , FALSE }, // 155
{ "bw/bc"                  , FALSE }, // 156
{ "bw/gh"                  , FALSE }, // 157
{ "bw/yd"                  , FALSE }, // 158
{ "bw/bs"                  , FALSE }, // 159
{ "bw/gc"                  , FALSE }, // 160
{ "bw/yh"                  , FALSE }, // 161
{ "bw/rd"                  , FALSE }, // 162
{ "im2/lift"               , FALSE }, // 163 IM2
{ "im2/platform"           , FALSE }, // 164
{ "im2/plug"               , FALSE }, // 165
{ "im2/timebomb"           , FALSE }, // 166
{ "im2/mine"               , FALSE }, // 167
{ "im2/lightbulb"          , FALSE }, // 168
{ ""                       , FALSE }, // 169 (spare)
{ "ph/dwarf"               , FALSE }, // 170 Phantasie. dwarf
{ "ph/human"               , FALSE }, // 171 elemental
{ "ph/elf"                 , FALSE }, // 172 elf
{ "ph/gnoll"               , FALSE }, // 173 gnoll
{ "ph/gnome"               , FALSE }, // 174 gnome
{ "ph/goblin"              , FALSE }, // 175 goblin
{ "ph/gnome"               , FALSE }, // 176 halfling
{ "ph/human"               , FALSE }, // 177 human
{ "ph/goblin"              , FALSE }, // 178 kobold
{ "ph/lizardman"           , FALSE }, // 179 lizard man
{ "ph/minotaur"            , FALSE }, // 180 minotaur
{ "ph/gnoll"               , FALSE }, // 181 ogre
{ "ph/goblin"              , FALSE }, // 182 orc
{ "ph/sprite"              , FALSE }, // 183 pixie
{ "ph/sprite"              , FALSE }, // 184 sprite
{ "ph/troll"               , FALSE }, // 185 troll
{ "ph/undead"              , FALSE }, // 186 undead
{ "ln/pouch"               , FALSE }, // 187 LN
{ "ln/key"                 , FALSE }, // 188
{ "ln/apple"               , FALSE }, // 189
{ "ln/claw"                , FALSE }, // 190
{ "ln/glove"               , FALSE }, // 191
{ "ln/amulet"              , FALSE }, // 192
{ "ln/flower"              , FALSE }, // 193
{ "ln/rope"                , FALSE }, // 194
{ "ln/bottle"              , FALSE }, // 195
{ "ln/scrolls"             , FALSE }, // 196
{ "ln/sword"               , FALSE }, // 197
{ "ln/nunchakus"           , FALSE }, // 198
{ "ln/staff"               , FALSE }, // 199
{ "ln/shuriken"            , FALSE }, // 200
{ "ln/bomb"                , FALSE }, // 201
{ "syndicate/none"         , FALSE }, // 202
{ "syndicate/persuadertron", FALSE }, // 203
{ "syndicate/pistol"       , FALSE }, // 204
{ "syndicate/gauss"        , FALSE }, // 205
{ "syndicate/shotgun"      , FALSE }, // 206
{ "syndicate/uzi"          , FALSE }, // 207
{ "syndicate/mini-gun"     , FALSE }, // 208
{ "syndicate/laser"        , FALSE }, // 209
{ "syndicate/flamer"       , FALSE }, // 210
{ "syndicate/longrange"    , FALSE }, // 211
{ "syndicate/scanner"      , FALSE }, // 212
{ "syndicate/medikit"      , FALSE }, // 213
{ "syndicate/timebomb"     , FALSE }, // 214
{ "syndicate/accesscard"   , FALSE }, // 215
{ "syndicate/energyshield" , FALSE }, // 216
{ "pirates/spanish"        , FALSE }, // 217
{ "pirates/english"        , FALSE }, // 218
{ "pirates/french"         , FALSE }, // 219
{ "pirates/dutch"          , FALSE }, // 220
{ "fta/dirk"               , FALSE }, // 221
{ "fta/mace"               , FALSE }, // 222
{ "fta/sword"              , FALSE }, // 223
{ "fta/bow"                , FALSE }, // 224
{ "fta/wand"               , FALSE }, // 225
{ "male"                   , TRUE  }, // 226
{ "female"                 , TRUE  }, // 227
{ "hol/goldmoon"           , FALSE }, // 228
{ "hol/sturm"              , FALSE }, // 229
{ "hol/caramon"            , FALSE }, // 230
{ "hol/raistlin"           , FALSE }, // 231
{ "hol/tanis"              , FALSE }, // 232
{ "hol/tasslehoff"         , FALSE }, // 233
{ "hol/riverwind"          , FALSE }, // 234
{ "hol/flint"              , FALSE }, // 235
{ "hol/gilthanas"          , FALSE }, // 236
{ "hol/laurana"            , FALSE }, // 237
{ "hol/eben"               , FALSE }, // 238
{ "hol/empty"              , FALSE }, // 239
{ "bard/archmage"          , FALSE }, // 240
{ "bard/bard"              , FALSE }, // 241
{ "bard/chronomancer"      , FALSE }, // 242
{ "bard/conjurer"          , FALSE }, // 243
{ "bard/chronomancer"      , FALSE }, // 244 (geomancer)
{ "bard/hunter"            , FALSE }, // 245
{ "bard/monster"           , FALSE }, // 246 (illusion)
{ "bard/magician"          , FALSE }, // 247
{ "bard/monk"              , FALSE }, // 248
{ "bard/monster"           , FALSE }, // 249
{ "bard/paladin"           , FALSE }, // 250
{ "bard/rogue"             , FALSE }, // 251
{ "bard/sorcerer"          , FALSE }, // 252
{ "bard/warrior"           , FALSE }, // 253
{ "bard/wizard"            , FALSE }, // 254
{ ""                       , FALSE }, // 255 (spare)
{ ""                       , FALSE }, // 256 (spare)
{ ""                       , FALSE }, // 257 (spare)
{ ""                       , FALSE }, // 258 (spare)
{ "ok"                     , TRUE  }, // 259
{ "cancel"                 , TRUE  }, // 260
{ "reaction"               , TRUE  }, // 261
{ "rorke/private"          , TRUE  }, // 262
{ "rorke/sergeant"         , TRUE  }, // 263
{ "rorke/officer"          , TRUE  }, // 264
{ "rorke/medic"            , TRUE  }, // 265
{ "rorke/storeman"         , TRUE  }, // 266
{ "bard/bank"              , FALSE }, // 267
{ "bard/shoppe1"           , FALSE }, // 268
{ "polarware/1-1"          , FALSE }, // 269
{ "polarware/1-2"          , FALSE }, // 270
{ "polarware/1-3"          , FALSE }, // 271
{ "polarware/1-4"          , FALSE }, // 272
{ "polarware/1-5"          , FALSE }, // 273
{ "polarware/1-6"          , FALSE }, // 274
{ "polarware/1-7"          , FALSE }, // 275
{ "polarware/1-8"          , FALSE }, // 276
{ "polarware/1-9"          , FALSE }, // 277
{ "polarware/1-10"         , FALSE }, // 278
{ "polarware/1-11"         , FALSE }, // 279
{ "polarware/1-12"         , FALSE }, // 280
{ "polarware/1-13"         , FALSE }, // 281
{ "polarware/1-14"         , FALSE }, // 282
{ "polarware/1-15"         , FALSE }, // 283
{ "polarware/1-16"         , FALSE }, // 284
{ "polarware/1-17"         , FALSE }, // 285
{ "polarware/1-18"         , FALSE }, // 286
{ "polarware/1-19"         , FALSE }, // 287
{ "polarware/1-20"         , FALSE }, // 288
{ "polarware/1-21"         , FALSE }, // 289
{ "polarware/1-22"         , FALSE }, // 290
{ "polarware/1-23"         , FALSE }, // 291
{ "polarware/1-24"         , FALSE }, // 292
{ "polarware/1-25"         , FALSE }, // 293
{ "polarware/1-26"         , FALSE }, // 294
{ "polarware/1-27"         , FALSE }, // 295
{ "polarware/1-28"         , FALSE }, // 296
{ "polarware/1-29"         , FALSE }, // 297
{ "polarware/1-30"         , FALSE }, // 298
{ "polarware/1-31"         , FALSE }, // 299
{ "polarware/1-32"         , FALSE }, // 300
{ "polarware/1-33"         , FALSE }, // 301
{ "polarware/1-34"         , FALSE }, // 302
{ "polarware/1-35"         , FALSE }, // 303
{ "polarware/1-36"         , FALSE }, // 304
{ "polarware/1-37"         , FALSE }, // 305
{ "polarware/1-38"         , FALSE }, // 306
{ "polarware/1-39"         , FALSE }, // 307
{ "polarware/1-40"         , FALSE }, // 308
{ "polarware/2-1"          , FALSE }, // 309
{ "polarware/2-2"          , FALSE }, // 310
{ "polarware/2-3"          , FALSE }, // 311
{ "polarware/2-4"          , FALSE }, // 312
{ "polarware/2-5"          , FALSE }, // 313
{ "polarware/2-6"          , FALSE }, // 314
{ "polarware/2-7"          , FALSE }, // 315
{ "polarware/2-8"          , FALSE }, // 316
{ "polarware/2-9"          , FALSE }, // 317
{ "polarware/2-10"         , FALSE }, // 318
{ "polarware/2-11"         , FALSE }, // 319
{ "polarware/2-12"         , FALSE }, // 320
{ "polarware/2-13"         , FALSE }, // 321
{ "polarware/2-14"         , FALSE }, // 322
{ "polarware/2-15"         , FALSE }, // 323
{ "polarware/2-16"         , FALSE }, // 324
{ "polarware/2-17"         , FALSE }, // 325
{ "polarware/2-18"         , FALSE }, // 326
{ "polarware/2-19"         , FALSE }, // 327
{ "polarware/2-20"         , FALSE }, // 328
{ "polarware/2-21"         , FALSE }, // 329
{ "polarware/2-22"         , FALSE }, // 330
{ "polarware/2-23"         , FALSE }, // 331
{ "polarware/2-24"         , FALSE }, // 332
{ "polarware/2-25"         , FALSE }, // 333
{ "polarware/2-26"         , FALSE }, // 334
{ "polarware/2-27"         , FALSE }, // 335
{ "polarware/2-28"         , FALSE }, // 336
{ "polarware/2-29"         , FALSE }, // 337
{ "polarware/2-30"         , FALSE }, // 338
{ "polarware/2-31"         , FALSE }, // 339
{ "polarware/2-32"         , FALSE }, // 340
{ "polarware/2-33"         , FALSE }, // 341
{ "polarware/2-34"         , FALSE }, // 342
{ "ce/nato"                , TRUE  }, // 343
{ "ce/wp"                  , TRUE  }, // 344
{ "ce/neutral"             , TRUE  }, // 345
{ "ce/wp"                  , TRUE  }, // 346
{ "ce/neutral"             , TRUE  }, // 347
{ "sb1/verna-grn"          , FALSE }, // 348
{ "sb1/lacerta-grn"        , FALSE }, // 349
{ "sb1/draco-grn"          , FALSE }, // 350
{ ""                       , FALSE }, // 351 (spare)
{ "oblit/pistol"           , TRUE  }, // 352
{ "oblit/rifle"            , TRUE  }, // 353
{ "oblit/blaster"          , TRUE  }, // 354
{ "oblit/bazooka"          , TRUE  }, // 355
{ "oblit/engine"           , FALSE }, // 356
{ "oblit/shields"          , FALSE }, // 357
{ "oblit/weapons"          , FALSE }, // 358
{ "oblit/shuttle"          , FALSE }, // 359
{ "oblit/datapack"         , FALSE }, // 360
{ "cf/pte"                 , TRUE  }, // 361
{ "cf/cpl"                 , TRUE  }, // 362
{ "cf/sgt"                 , TRUE  }, // 363
{ "cf/ssgt"                , TRUE  }, // 364
{ "cf/sfc"                 , TRUE  }, // 365
{ "cf/msg"                 , TRUE  }, // 366
{ "cf/sgm"                 , TRUE  }, // 367
{ "cf/sp4"                 , TRUE  }, // 368
{ "cf/sp6"                 , TRUE  }, // 369
{ "cf/wo"                  , TRUE  }, // 370
{ "cf/cwo"                 , TRUE  }, // 371
{ "cf/capt"                , TRUE  }, // 372
{ "cf/maj"                 , TRUE  }, // 373
{ "cf/col"                 , TRUE  }, // 374
{ "cf/brig"                , TRUE  }, // 375
{ "cf/gen"                 , TRUE  }, // 376
{ "sb1/verna-red"          , FALSE }, // 377
{ "sb1/lacerta-red"        , FALSE }, // 378
{ "sb1/draco-red"          , FALSE }, // 379
{ "polarware/3-1"          , FALSE }, // 380
{ "polarware/3-2"          , FALSE }, // 381
{ "polarware/3-3"          , FALSE }, // 382
{ "polarware/3-4"          , FALSE }, // 383
{ "polarware/3-5"          , FALSE }, // 384
{ "polarware/3-6"          , FALSE }, // 385
{ "polarware/3-7"          , FALSE }, // 386
{ "polarware/3-8"          , FALSE }, // 387
{ "polarware/3-9"          , FALSE }, // 388
{ "polarware/3-10"         , FALSE }, // 389
{ "polarware/3-11"         , FALSE }, // 390
{ "polarware/3-12"         , FALSE }, // 391
{ "polarware/3-13"         , FALSE }, // 392
{ "polarware/3-14"         , FALSE }, // 393
{ "polarware/3-15"         , FALSE }, // 394
{ "polarware/3-16"         , FALSE }, // 395
{ "polarware/3-17"         , FALSE }, // 396
{ "polarware/3-18"         , FALSE }, // 397
{ "polarware/3-19"         , FALSE }, // 398
{ "polarware/3-20"         , FALSE }, // 399
{ "polarware/3-21"         , FALSE }, // 400
{ "polarware/3-22"         , FALSE }, // 401
{ "polarware/3-23"         , FALSE }, // 402
{ "polarware/3-24"         , FALSE }, // 403
{ "polarware/3-25"         , FALSE }, // 404
{ "polarware/3-26"         , FALSE }, // 405
{ "polarware/3-27"         , FALSE }, // 406
{ "polarware/3-28"         , FALSE }, // 407
{ "polarware/3-29"         , FALSE }, // 408
{ "polarware/3-30"         , FALSE }, // 409
{ "polarware/3-31"         , FALSE }, // 410
{ "polarware/3-32"         , FALSE }, // 411
{ "polarware/3-33"         , FALSE }, // 412
{ "polarware/3-34"         , FALSE }, // 413 pure white imagery
{ "polarware/3-35"         , FALSE }, // 414
{ "polarware/3-36"         , FALSE }, // 415
{ "polarware/3-37"         , FALSE }, // 416
{ "polarware/3-38"         , FALSE }, // 417
{ "polarware/3-39"         , FALSE }, // 418
{ "polarware/3-40"         , FALSE }, // 419
{ "polarware/3-41"         , FALSE }, // 420
{ "polarware/3-42"         , FALSE }, // 421
{ "polarware/3-43"         , FALSE }, // 422
{ "polarware/3-44"         , FALSE }, // 423
{ "polarware/3-45"         , FALSE }, // 424
{ "polarware/3-46"         , FALSE }, // 425
{ "polarware/3-47"         , FALSE }, // 426
{ "polarware/3-48"         , FALSE }, // 427
{ "polarware/3-49"         , FALSE }, // 428
{ "polarware/3-50"         , FALSE }, // 429
{ "polarware/3-51"         , FALSE }, // 430
{ "polarware/3-52"         , FALSE }, // 431
{ "polarware/3-53"         , FALSE }, // 432
{ "polarware/3-34"         , FALSE }, // 433 room #54 uses same imagery as room #34
{ "polarware/3-55"         , FALSE }, // 434 pure black imagery
{ "polarware/3-56"         , FALSE }, // 435
{ "polarware/3-57"         , FALSE }, // 436
{ "polarware/3-58"         , FALSE }, // 437
{ "polarware/3-59"         , FALSE }, // 438
{ "polarware/3-60"         , FALSE }, // 439
{ "polarware/3-61"         , FALSE }, // 440
{ "polarware/3-62"         , FALSE }, // 441
{ "polarware/3-63"         , FALSE }, // 442
{ "polarware/3-63"         , FALSE }, // 443 room #64 uses same imagery as room #63
{ "polarware/3-63"         , FALSE }, // 444 room #65 uses same imagery as room #63
{ "polarware/3-63"         , FALSE }, // 445 room #66 uses same imagery as room #63
{ "polarware/3-31"         , FALSE }, // 446 room #67 uses same imagery as room #31
{ "polarware/3-23"         , FALSE }, // 447 room #68 uses same imagery as room #23
{ "quadralien/jack"        , TRUE  }, // 448
{ "quadralien/scooter"     , TRUE  }, // 449
{ "quadralien/martina"     , TRUE  }, // 450
{ "quadralien/rambot"      , TRUE  }, // 451
{ "quadralien/spud"        , TRUE  }, // 452
{ "quadralien/barney"      , TRUE  }, // 453
{ "arazok/1"               , FALSE }, // 454
{ "arazok/2"               , FALSE }, // 455
{ "arazok/3"               , FALSE }, // 456
{ "arazok/4"               , FALSE }, // 457
{ "arazok/5"               , FALSE }, // 458
{ "arazok/6"               , FALSE }, // 459
{ "arazok/7"               , FALSE }, // 460
{ "arazok/8"               , FALSE }, // 461
{ "arazok/6"               , FALSE }, // 462 room  #9 uses same imagery as room  #6
{ "arazok/10"              , FALSE }, // 463
{ "arazok/11"              , FALSE }, // 464
{ "arazok/11"              , FALSE }, // 465 room #12 uses same imagery as room #11
{ "arazok/13"              , FALSE }, // 466
{ "arazok/14"              , FALSE }, // 467
{ "arazok/15"              , FALSE }, // 468
{ "arazok/16"              , FALSE }, // 469
{ "arazok/17"              , FALSE }, // 470
{ "arazok/18"              , FALSE }, // 471
{ "arazok/18"              , FALSE }, // 472 room #19 uses same imagery as room #18
{ "arazok/18"              , FALSE }, // 473 room #20 uses same imagery as room #18
{ "arazok/21"              , FALSE }, // 474
{ "arazok/22"              , FALSE }, // 475
{ "arazok/23"              , FALSE }, // 476
{ "arazok/24"              , FALSE }, // 477
{ "arazok/25"              , FALSE }, // 478
{ "arazok/26"              , FALSE }, // 479
{ "arazok/21"              , FALSE }, // 480 room #27 uses same imagery as room #21
{ "arazok/28"              , FALSE }, // 481
{ "arazok/29"              , FALSE }, // 482
{ "arazok/14"              , FALSE }, // 483 room #30 uses same imagery as room #14
{ "arazok/31"              , FALSE }, // 484
{ "arazok/32"              , FALSE }, // 485
{ "arazok/21"              , FALSE }, // 486 room #33 uses same imagery as room #21
{ "arazok/25"              , FALSE }, // 487 room #34 uses same imagery as room #25
{ "arazok/15"              , FALSE }, // 488 room #35 uses same imagery as room #15
{ "arazok/21"              , FALSE }, // 489 room #36 uses same imagery as room #21
{ "arazok/17"              , FALSE }, // 490 room #37 uses same imagery as room #17
{ "arazok/18"              , FALSE }, // 491 room #38 uses same imagery as room #18
{ "arazok/18"              , FALSE }, // 492 room #39 uses same imagery as room #18
{ "arazok/40"              , FALSE }, // 493
{ "arazok/22"              , FALSE }, // 494 room #41 uses same imagery as room #22
{ "arazok/42"              , FALSE }, // 495
{ "arazok/24"              , FALSE }, // 496 room #43 uses same imagery as room #24
{ "arazok/44"              , FALSE }, // 497
{ "arazok/6"               , FALSE }, // 498 room #45 uses same imagery as room  #6
{ "arazok/46"              , FALSE }, // 499
{ "wime/orb"               , TRUE  }, // 500
{ "wime/sceptre"           , TRUE  }, // 501
{ "wime/rope"              , TRUE  }, // 502
{ "wime/arrow"             , TRUE  }, // 503
{ "wime/vial"              , TRUE  }, // 504
{ "wime/flask"             , TRUE  }, // 505
{ "wime/potion"            , TRUE  }, // 506
{ "wime/cloak"             , TRUE  }, // 507
{ "wime/palantir"          , TRUE  }, // 508
{ "wime/mail"              , TRUE  }, // 509
{ "wime/hammer"            , TRUE  }, // 510
{ "wime/blade"             , TRUE  }, // 511
{ "wime/sword"             , TRUE  }, // 512
{ "wime/staff"             , TRUE  }, // 513
{ "wime/ring"              , TRUE  }, // 514
{ "wime/ring"              , TRUE  }, // 515
{ "wime/blank"             , TRUE  }, // 516
{ "wime/brand"             , TRUE  }, // 517
{ "wime/cavalry"           , TRUE  }, // 518
{ "wime/dain"              , TRUE  }, // 519
{ "wime/dunlendings"       , TRUE  }, // 520
{ "wime/dwarves"           , TRUE  }, // 521
{ "wime/handorcs"          , TRUE  }, // 522
{ "wime/hobbit"            , TRUE  }, // 523
{ "wime/imrahil"           , TRUE  }, // 524
{ "wime/infantry1"         , TRUE  }, // 525
{ "wime/infantry2"         , TRUE  }, // 526
{ "wime/ltinfantry"        , TRUE  }, // 527
{ "wime/nazgul"            , TRUE  }, // 528
{ "wime/orcs"              , TRUE  }, // 529
{ "wime/thranduil"         , TRUE  }, // 530
{ "wime/trolls"            , TRUE  }, // 531
{ "ragnarok/odin"          , TRUE  }, // 532
{ "ragnarok/einherjar"     , TRUE  }, // 533
{ "ragnarok/white1"        , TRUE  }, // 534
{ "ragnarok/white2"        , TRUE  }, // 535
{ "ragnarok/white3"        , TRUE  }, // 536
{ "ragnarok/white4"        , TRUE  }, // 537
{ "ragnarok/white5"        , TRUE  }, // 538
{ "ragnarok/white6"        , TRUE  }, // 539
{ "ragnarok/giant"         , TRUE  }, // 540
{ "ragnarok/black1"        , TRUE  }, // 541
{ "ragnarok/black2"        , TRUE  }, // 542
{ "ragnarok/black3"        , TRUE  }, // 543
{ "ragnarok/black4"        , TRUE  }, // 544
{ "ragnarok/black5"        , TRUE  }, // 545
{ "ragnarok/black6"        , TRUE  }, // 546
{ "ragnarok/none"          , TRUE  }, // 547
{ "dc/orb"                 , FALSE }, // 548
{ "dc/shield"              , FALSE }, // 549
{ "dc/fireball"            , FALSE }, // 550
{ "dc/bombs"               , FALSE }, // 551
{ "dc/elixirs"             , FALSE }, // 552
{ "dc/gas"                 , FALSE }, // 553
{ "dc/keys"                , FALSE }, // 554
{ "dc/rocks"               , FALSE }, // 555
{ "bw/pocket"              , FALSE }, // 556
{ "bw/1"                   , FALSE }, // 557
{ "bw/2"                   , FALSE }, // 558
{ "bw/3"                   , FALSE }, // 559
{ "bw/4"                   , FALSE }, // 560
{ "bw/5"                   , FALSE }, // 561
{ "bw/6"                   , FALSE }, // 562
{ "bw/7"                   , FALSE }, // 563
{ "bw/8"                   , FALSE }, // 564
{ "bw/9"                   , FALSE }, // 565
{ "bw/10"                  , FALSE }, // 566
{ "bw/11"                  , FALSE }, // 567
{ "bw/12"                  , FALSE }, // 568
{ "bw/13"                  , FALSE }, // 569
{ "bw/14"                  , FALSE }, // 570
{ "bw/15"                  , FALSE }, // 571
{ "bw/16"                  , FALSE }, // 572
{ "bw/17"                  , FALSE }, // 573
{ "bw/18"                  , FALSE }, // 574
{ "bw/19"                  , FALSE }, // 575
{ "bw/20"                  , FALSE }, // 576
{ "bw/21"                  , FALSE }, // 577
{ "bw/22"                  , FALSE }, // 578
{ "bw/23"                  , FALSE }, // 579
{ "bw/24"                  , FALSE }, // 580
{ "bw/25"                  , FALSE }, // 581
{ "bw/26"                  , FALSE }, // 582
{ "bw/27"                  , FALSE }, // 583
{ "bw/28"                  , FALSE }, // 584
{ "bw/29"                  , FALSE }, // 585
{ "bw/30"                  , FALSE }, // 586
{ "bw/31"                  , FALSE }, // 587
{ "bw/32"                  , FALSE }, // 588
{ "bw/33"                  , FALSE }, // 589
{ "bw/34"                  , FALSE }, // 590
{ "bw/35"                  , FALSE }, // 591
{ "bw/36-1"                , FALSE }, // 592
{ "bw/37-1"                , FALSE }, // 593
{ "bw/38-1"                , FALSE }, // 594
{ "bw/39"                  , FALSE }, // 595
{ "bw/40-1"                , FALSE }, // 596
{ "bw/41-1"                , FALSE }, // 597
{ "bw/42-1"                , FALSE }, // 598
{ "bw/43"                  , FALSE }, // 599
{ "bw/44"                  , FALSE }, // 600
{ "bw/45"                  , FALSE }, // 601
{ "bw/46"                  , FALSE }, // 602
{ "bw/47"                  , FALSE }, // 603
{ "bw/48"                  , FALSE }, // 604
{ "bw/49"                  , FALSE }, // 605
{ "bw/50-1"                , FALSE }, // 606
{ "bw/51"                  , FALSE }, // 607
{ "bw/52"                  , FALSE }, // 608
{ "bw/53-1"                , FALSE }, // 609
{ "bw/54-1"                , FALSE }, // 610
{ "bw/55"                  , FALSE }, // 611
{ "bw/56-1"                , FALSE }, // 612
{ "bw/57-1"                , FALSE }, // 613
{ "bw/58"                  , FALSE }, // 614
{ "bw/59-1"                , FALSE }, // 615
{ "bw/60-1"                , FALSE }, // 616
{ "bw/61"                  , FALSE }, // 617
{ "bw/62"                  , FALSE }, // 618
{ "bw/63"                  , FALSE }, // 619
{ "bw/green"               , FALSE }, // 620 64
{ "bw/yellow"              , FALSE }, // 621 65
{ "bw/red"                 , FALSE }, // 622 66
{ "bw/blue"                , FALSE }, // 623 67
{ "bw/yellow"              , FALSE }, // 624 68
{ "bw/red"                 , FALSE }, // 625 69
{ "bw/blue"                , FALSE }, // 626 70
{ "bw/green"               , FALSE }, // 627 71
{ "bw/red"                 , FALSE }, // 628 72
{ "bw/blue"                , FALSE }, // 629 73
{ "bw/green"               , FALSE }, // 630 74
{ "bw/yellow"              , FALSE }, // 631 75
{ "bw/blue"                , FALSE }, // 632 76
{ "bw/green"               , FALSE }, // 633 77
{ "bw/yellow"              , FALSE }, // 634 78
{ "bw/red"                 , FALSE }, // 635 79
{ "bw/80"                  , FALSE }, // 636
{ "bw/81"                  , FALSE }, // 637
{ "bw/82"                  , FALSE }, // 638
{ "bw/83"                  , FALSE }, // 639
{ "bw/84"                  , FALSE }, // 640
{ "bw/85"                  , FALSE }, // 641
{ "bw/86"                  , FALSE }, // 642
{ "bw/87"                  , FALSE }, // 643
{ "bw/88"                  , FALSE }, // 644
{ "bw/89"                  , FALSE }, // 645
{ "bw/90"                  , FALSE }, // 646
{ "bw/91"                  , FALSE }, // 647
{ "bw/92"                  , FALSE }, // 648
{ "bw/93"                  , FALSE }, // 649
{ "bw/94"                  , FALSE }, // 650
{ "bw/95"                  , FALSE }, // 651
{ "bw/96"                  , FALSE }, // 652
{ "bw/97"                  , FALSE }, // 653
{ "bw/98"                  , FALSE }, // 654
{ "bw/99"                  , FALSE }, // 655
{ "bw/100"                 , FALSE }, // 656
{ "bw/101"                 , FALSE }, // 657
{ "bw/102"                 , FALSE }, // 658
{ "bw/103"                 , FALSE }, // 659
{ "bw/104"                 , FALSE }, // 660
{ "bw/105"                 , FALSE }, // 661
{ "bw/106"                 , FALSE }, // 662
{ "bw/107"                 , FALSE }, // 663
{ "bw/108"                 , FALSE }, // 664
{ "bw/109"                 , FALSE }, // 665
{ "bw/lefthand"            , FALSE }, // 666
{ "bw/righthand"           , FALSE }, // 667
{ "bw/torso"               , FALSE }, // 668
{ "bw/shield"              , FALSE }, // 669
{ "bw/lefthand"            , FALSE }, // 670
{ "bw/righthand"           , FALSE }, // 671
{ "bw/torso"               , FALSE }, // 672
{ "bw/shield"              , FALSE }, // 673
{ "bw/pocket"              , FALSE }, // 674
{ "bw/pocket"              , FALSE }, // 675
{ "bw/pocket"              , FALSE }, // 676
{ "bw/pocket"              , FALSE }, // 677
{ "bw/pocket"              , FALSE }, // 678
{ "bw/pocket"              , FALSE }, // 679
{ "bw/pocket"              , FALSE }, // 680
{ "bw/pocket"              , FALSE }, // 681
{ "bw/1"                   , FALSE }, // 682
{ "bw/2"                   , FALSE }, // 683
{ "bw/3"                   , FALSE }, // 684
{ "bw/4"                   , FALSE }, // 685
{ "bw/36-2"                , FALSE }, // 686
{ "bw/37-2"                , FALSE }, // 687
{ "bw/38-2"                , FALSE }, // 688
{ "bw/40-2"                , FALSE }, // 689
{ "bw/41-2"                , FALSE }, // 690
{ "bw/42-2"                , FALSE }, // 691
{ "bw/50-2"                , FALSE }, // 692
{ "bw/53-2"                , FALSE }, // 693
{ "bw/54-2"                , FALSE }, // 694
{ "bw/56-2"                , FALSE }, // 695
{ "bw/57-2"                , FALSE }, // 696
{ "bw/59-2"                , FALSE }, // 697
{ "bw/60-2"                , FALSE }, // 698
{ "sb2/jams"               , FALSE }, // 699
{ "sb2/norman"             , FALSE }, // 700
{ "sb2/caza"               , FALSE }, // 701
{ "sb2/weiss"              , FALSE }, // 702
{ "sb2/garrik"             , FALSE }, // 703
{ "sb2/roscopp"            , FALSE }, // 704
{ "sb2/montez"             , FALSE }, // 705
{ "sb2/shorn"              , FALSE }, // 706
{ "sb2/quiss"              , FALSE }, // 707
{ "sb2/quaid"              , FALSE }, // 708
{ "sb2/rocco"              , FALSE }, // 709
{ "sb2/luthor"             , FALSE }, // 710
{ "sb2/jenson"             , FALSE }, // 711
{ "sb2/cooper"             , FALSE }, // 712
{ "sb2/stavia"             , FALSE }, // 713
{ "sb2/midia"              , FALSE }, // 714
{ "sb2/seline"             , FALSE }, // 715
{ "sb2/bodini"             , FALSE }, // 716
{ "sb2/barry"              , FALSE }, // 717
{ "sb2/colin"              , FALSE }, // 718
{ "sb2/justin"             , FALSE }, // 719
{ "sb2/nigel"              , FALSE }, // 720
{ "sb2/darren"             , FALSE }, // 721
{ "sb2/graham"             , FALSE }, // 722
{ "sb2/arnold"             , FALSE }, // 723
{ "sb2/robin"              , FALSE }, // 724
{ "sb2/trevor"             , FALSE }, // 725
{ "sb2/stuart"             , FALSE }, // 726
{ "sb2/gordon"             , FALSE }, // 727
{ "sb2/kevin"              , FALSE }, // 728
{ "robin/health"           , FALSE }, // 729
{ "robin/strength"         , FALSE }, // 730
{ "robin/gold"             , FALSE }, // 731
{ "robin/hood"             , TRUE  }, // 732
{ "robin/lightning"        , TRUE  }, // 733
{ "robin/ring"             , TRUE  }, // 734
{ "robin/horn"             , TRUE  }, // 735
{ "robin/toadstool"        , TRUE  }, // 736
{ "robin/feather"          , TRUE  }, // 737
{ "robin/orb"              , TRUE  }, // 738
{ "hol/goldmoon"           , FALSE }, // 739
{ "hol/sturm"              , FALSE }, // 740
{ "hol/caramon"            , FALSE }, // 741
{ "hol/raistlin"           , FALSE }, // 742
{ "hol/tanis"              , FALSE }, // 743
{ "hol/tasslehoff"         , FALSE }, // 744
{ "hol/riverwind"          , FALSE }, // 745
{ "hol/flint"              , FALSE }, // 746
{ "hol/gilthanas"          , FALSE }, // 747
{ "hol/laurana"            , FALSE }, // 748
{ "hol/eben"               , FALSE }, // 749
{ "ms/0"                   , FALSE }, // 750
{ "ms/1"                   , FALSE }, // 751
{ "ms/2"                   , FALSE }, // 752
{ "ms/3"                   , FALSE }, // 753
{ "ms/4"                   , FALSE }, // 754
{ "ms/5"                   , FALSE }, // 755
{ "ms/6"                   , FALSE }, // 756
{ "ms/6"                   , FALSE }, // 757 this is no mistake
{ "ms/8"                   , FALSE }, // 758
{ "ms/9"                   , FALSE }, // 759
{ "ms/10"                  , FALSE }, // 760
{ "ms/11"                  , FALSE }, // 761
{ "ms/12"                  , FALSE }, // 762
{ "ms/13"                  , FALSE }, // 763
{ "ms/14"                  , FALSE }, // 764
{ "ms/15"                  , FALSE }, // 765
{ "ms/16"                  , FALSE }, // 766
{ "ms/17"                  , FALSE }, // 767
{ "ms/18"                  , FALSE }, // 768
{ "ms/18"                  , FALSE }, // 769 this is no mistake
{ "ms/20"                  , FALSE }, // 770
{ "ms/21"                  , FALSE }, // 771
{ "ms/22"                  , FALSE }, // 772
{ "ms/20"                  , FALSE }, // 773 this is no mistake
{ "ms/24"                  , FALSE }, // 774
{ "bt/0"                   , FALSE }, // 775
{ "bt/1"                   , FALSE }, // 776
{ "bt/2"                   , FALSE }, // 777
{ "bt/3"                   , FALSE }, // 778
{ "bt/4"                   , FALSE }, // 779
{ "bt/5"                   , FALSE }, // 780
{ "bt/6"                   , FALSE }, // 781
{ "bt/7"                   , FALSE }, // 782
{ "bt/8"                   , FALSE }, // 783
{ "bt/9"                   , FALSE }, // 784
{ "bt/10"                  , FALSE }, // 785
{ "bt/11"                  , FALSE }, // 786
{ "bt/12"                  , FALSE }, // 787
{ "bt/13"                  , FALSE }, // 788
{ "bt/14"                  , FALSE }, // 789
{ "bt/15"                  , FALSE }, // 790
{ "bt/16"                  , FALSE }, // 791
{ "bt/17"                  , FALSE }, // 792
{ "bt/18"                  , FALSE }, // 793
{ "bt/19"                  , FALSE }, // 794
{ "bt/20"                  , FALSE }, // 795
{ "bt/21"                  , FALSE }, // 796
{ "bt/22"                  , FALSE }, // 797
{ "ttitt/0"                , FALSE }, // 798
{ "ttitt/1"                , FALSE }, // 799
{ "ttitt/2"                , FALSE }, // 800
{ "ttitt/3"                , FALSE }, // 801
{ "ttitt/4"                , FALSE }, // 802
{ "ttitt/5"                , FALSE }, // 803
{ "ttitt/6"                , FALSE }, // 804
{ "ttitt/7"                , FALSE }, // 805
{ "ttitt/8"                , FALSE }, // 806
{ "ttitt/9"                , FALSE }, // 807
{ "ttitt/10"               , FALSE }, // 808
{ "ttitt/11"               , FALSE }, // 809
{ "ttitt/12"               , FALSE }, // 810
{ "ttitt/13"               , FALSE }, // 811
{ "ttitt/14"               , FALSE }, // 812
{ "ttitt/15"               , FALSE }, // 813
{ "ttitt/16"               , FALSE }, // 814
{ "ttitt/17"               , FALSE }, // 815
{ "ttitt/18"               , FALSE }, // 816
{ "ttitt/19"               , FALSE }, // 817
{ "ttitt/20"               , FALSE }, // 818
{ "kq1/1"                  , FALSE }, // 819
{ "kq1/2"                  , FALSE }, // 820
{ "kq1/3"                  , FALSE }, // 821
{ "kq1/4"                  , FALSE }, // 822
{ "kq1/5"                  , FALSE }, // 823
{ "kq1/6"                  , FALSE }, // 824
{ "kq1/7"                  , FALSE }, // 825
{ "kq1/8"                  , FALSE }, // 826
{ "kq1/9"                  , FALSE }, // 827
{ "kq1/10"                 , FALSE }, // 828
{ "kq1/11"                 , FALSE }, // 829
{ "kq1/12"                 , FALSE }, // 830
{ "kq1/13"                 , FALSE }, // 831
{ "kq1/14"                 , FALSE }, // 832
{ "kq1/15"                 , FALSE }, // 833
{ "kq1/16"                 , FALSE }, // 834
{ "kq1/17"                 , FALSE }, // 835
{ "kq1/18"                 , FALSE }, // 836
{ "kq1/19"                 , FALSE }, // 837
{ "kq1/20"                 , FALSE }, // 838
{ "kq1/21"                 , FALSE }, // 839
{ "kq1/22"                 , FALSE }, // 840
{ "kq1/23"                 , FALSE }, // 841
{ "kq1/24"                 , FALSE }, // 842
{ "kq1/25"                 , FALSE }, // 843
{ "kq1/26"                 , FALSE }, // 844
{ "kq1/27"                 , FALSE }, // 845
{ "kq1/28"                 , FALSE }, // 846
{ "kq1/29"                 , FALSE }, // 847
{ "kq1/30"                 , FALSE }, // 848
{ "kq1/31"                 , FALSE }, // 849
{ "kq1/32"                 , FALSE }, // 850
{ "kq1/33"                 , FALSE }, // 851
{ "kq1/34"                 , FALSE }, // 852
{ "kq1/35"                 , FALSE }, // 853
{ "kq1/36"                 , FALSE }, // 854
{ "kq1/37"                 , FALSE }, // 855
{ "kq1/38"                 , FALSE }, // 856
{ "kq1/39"                 , FALSE }, // 857
{ "kq1/40"                 , FALSE }, // 858
{ "kq1/41"                 , FALSE }, // 859
{ "kq1/42"                 , FALSE }, // 860
{ "kq1/43"                 , FALSE }, // 861
{ "kq1/44"                 , FALSE }, // 862
{ "kq1/45"                 , FALSE }, // 863
{ "kq1/46"                 , FALSE }, // 864
{ "kq1/47"                 , FALSE }, // 865
{ "kq1/48"                 , FALSE }, // 866
{ "kq1/49"                 , FALSE }, // 867
{ "kq1/50"                 , FALSE }, // 868
{ "kq1/51"                 , FALSE }, // 869
{ "kq1/52"                 , FALSE }, // 870
{ "kq1/53"                 , FALSE },
{ "kq1/54"                 , FALSE },
{ "kq1/55"                 , FALSE },
{ "kq1/56"                 , FALSE },
{ "kq1/57"                 , FALSE },
{ "kq1/58"                 , FALSE },
{ "kq1/59"                 , FALSE },
{ "kq1/60"                 , FALSE },
{ "kq1/61"                 , FALSE },
{ "kq1/62"                 , FALSE }, // 880
{ "kq1/63"                 , FALSE },
{ "kq1/64"                 , FALSE },
{ "kq1/65"                 , FALSE },
{ "kq1/66"                 , FALSE },
{ "kq1/67"                 , FALSE },
{ "kq1/68"                 , FALSE },
{ "kq1/69"                 , FALSE },
{ "kq1/70"                 , FALSE },
{ "kq1/71"                 , FALSE },
{ "kq1/72"                 , FALSE }, // 890
{ "kq1/73"                 , FALSE },
{ "kq1/74"                 , FALSE },
{ "kq1/75"                 , FALSE },
{ "kq1/76"                 , FALSE },
{ "kq1/77"                 , FALSE },
{ "kq1/78"                 , FALSE },
{ "kq1/79"                 , FALSE },
{ "kq1/80"                 , FALSE }, // 898
{ "kq2/1"                  , FALSE }, // 899
{ "kq2/2"                  , FALSE }, // 900
{ "kq2/3"                  , FALSE },
{ "kq2/4"                  , FALSE },
{ "kq2/5"                  , FALSE },
{ "kq2/6"                  , FALSE },
{ "kq2/7"                  , FALSE },
{ "kq2/8"                  , FALSE },
{ "kq2/9"                  , FALSE },
{ "kq2/10"                 , FALSE },
{ "kq2/11"                 , FALSE },
{ "kq2/12"                 , FALSE }, // 910
{ "kq2/13"                 , FALSE },
{ "kq2/14"                 , FALSE },
{ "kq2/15"                 , FALSE },
{ "kq2/16"                 , FALSE },
{ "kq2/17"                 , FALSE },
{ "kq2/18"                 , FALSE },
{ "kq2/19"                 , FALSE },
{ "kq2/20"                 , FALSE },
{ "kq2/21"                 , FALSE },
{ "kq2/22"                 , FALSE }, // 920
{ "kq2/23"                 , FALSE },
{ "kq2/24"                 , FALSE },
{ "kq2/25"                 , FALSE },
{ "kq2/26"                 , FALSE },
{ "kq2/27"                 , FALSE },
{ "kq2/28"                 , FALSE },
{ "kq2/29"                 , FALSE },
{ "kq2/30"                 , FALSE },
{ "kq2/31"                 , FALSE },
{ "kq2/32"                 , FALSE }, // 930
{ "kq2/33"                 , FALSE },
{ "kq2/34"                 , FALSE },
{ "kq2/35"                 , FALSE },
{ "kq2/36"                 , FALSE },
{ "kq2/37"                 , FALSE },
{ "kq2/38"                 , FALSE },
{ "kq2/39"                 , FALSE },
{ "kq2/40"                 , FALSE },
{ "kq2/41"                 , FALSE },
{ "kq2/42"                 , FALSE }, // 940
{ "kq2/43"                 , FALSE },
{ "kq2/44"                 , FALSE },
{ "kq2/45"                 , FALSE },
{ "kq2/46"                 , FALSE },
{ "kq2/47"                 , FALSE },
{ "kq2/48"                 , FALSE },
{ "kq2/49"                 , FALSE },
{ "kq2/50"                 , FALSE },
{ "kq2/51"                 , FALSE },
{ "kq2/52"                 , FALSE }, // 950
{ "kq2/53"                 , FALSE },
{ "kq2/54"                 , FALSE },
{ "kq2/55"                 , FALSE },
{ "kq2/56"                 , FALSE },
{ "kq2/57"                 , FALSE },
{ "kq2/58"                 , FALSE },
{ "kq2/59"                 , FALSE },
{ "kq2/60"                 , FALSE },
{ "kq2/61"                 , FALSE },
{ "kq2/62"                 , FALSE }, // 960
{ "kq2/63"                 , FALSE },
{ "kq2/64"                 , FALSE },
{ "kq2/65"                 , FALSE },
{ "kq2/66"                 , FALSE },
{ "kq2/67"                 , FALSE },
{ "kq2/68"                 , FALSE },
{ "kq2/69"                 , FALSE },
{ "kq2/70"                 , FALSE },
{ "kq2/71"                 , FALSE },
{ "kq2/72"                 , FALSE }, // 970
{ "kq2/73"                 , FALSE },
{ "kq2/74"                 , FALSE },
{ "kq2/75"                 , FALSE },
{ "kq2/76"                 , FALSE },
{ "kq2/77"                 , FALSE },
{ "kq2/78"                 , FALSE },
{ "kq2/79"                 , FALSE },
{ "kq2/80"                 , FALSE },
{ "kq2/81"                 , FALSE },
{ "kq2/82"                 , FALSE }, // 980
{ "kq2/83"                 , FALSE },
{ "kq2/84"                 , FALSE },
{ "kq2/85"                 , FALSE },
{ "kq2/86"                 , FALSE },
{ "kq2/87"                 , FALSE },
{ "kq2/88"                 , FALSE },
{ "kq2/89"                 , FALSE },
{ "kq2/90"                 , FALSE },
{ "kq2/91"                 , FALSE },
{ "kq2/92"                 , FALSE }, // 990
{ "kq2/93"                 , FALSE },
{ "kq3/1"                  , FALSE },
{ "kq3/2"                  , FALSE },
{ "kq3/3"                  , FALSE },
{ "kq3/4"                  , FALSE },
{ "kq3/5"                  , FALSE },
{ "kq3/6"                  , FALSE },
{ "kq3/7"                  , FALSE },
{ "kq3/8"                  , FALSE },
{ "kq3/9"                  , FALSE }, // 1000
{ "kq3/10"                 , FALSE },
{ "kq3/11"                 , FALSE },
{ "kq3/12"                 , FALSE },
{ "kq3/13"                 , FALSE },
{ "kq3/14"                 , FALSE },
{ "kq3/15"                 , FALSE },
{ "kq3/16"                 , FALSE },
{ "kq3/17"                 , FALSE },
{ "kq3/18"                 , FALSE },
{ "kq3/19"                 , FALSE }, // 1010
{ "kq3/20"                 , FALSE },
{ "kq3/21"                 , FALSE },
{ "kq3/22"                 , FALSE },
{ "kq3/23"                 , FALSE },
{ "kq3/24"                 , FALSE },
{ "kq3/25"                 , FALSE },
{ "kq3/26"                 , FALSE },
{ "kq3/27"                 , FALSE },
{ "kq3/28"                 , FALSE },
{ "kq3/29"                 , FALSE }, // 1020
{ "kq3/30"                 , FALSE },
{ "kq3/31"                 , FALSE },
{ "kq3/32"                 , FALSE },
{ "kq3/33"                 , FALSE },
{ "kq3/34"                 , FALSE },
{ "kq3/35"                 , FALSE },
{ "kq3/36"                 , FALSE },
{ "kq3/37"                 , FALSE },
{ "kq3/38"                 , FALSE },
{ "kq3/39"                 , FALSE }, // 1030
{ "kq3/40"                 , FALSE },
{ "kq3/41"                 , FALSE },
{ "kq3/42"                 , FALSE },
{ "kq3/48"                 , FALSE },
{ "kq3/49"                 , FALSE },
{ "kq3/50"                 , FALSE },
{ "kq3/51"                 , FALSE },
{ "kq3/52"                 , FALSE },
{ "kq3/53"                 , FALSE },
{ "kq3/54"                 , FALSE }, // 1040
{ "kq3/55"                 , FALSE },
{ "kq3/56"                 , FALSE },
{ "kq3/57"                 , FALSE },
{ "kq3/58"                 , FALSE },
{ "kq3/59"                 , FALSE },
{ "kq3/60"                 , FALSE },
{ "kq3/61"                 , FALSE },
{ "kq3/62"                 , FALSE },
{ "kq3/63"                 , FALSE },
{ "kq3/64"                 , FALSE }, // 1050
{ "kq3/65"                 , FALSE },
{ "kq3/66"                 , FALSE },
{ "kq3/67"                 , FALSE },
{ "kq3/68"                 , FALSE },
{ "kq3/69"                 , FALSE },
{ "kq3/71"                 , FALSE },
{ "kq3/72"                 , FALSE },
{ "kq3/73"                 , FALSE },
{ "kq3/74"                 , FALSE },
{ "kq3/75"                 , FALSE }, // 1060
{ "kq3/76"                 , FALSE },
{ "kq3/78"                 , FALSE },
{ "kq3/79"                 , FALSE },
{ "kq3/80"                 , FALSE },
{ "kq3/81"                 , FALSE },
{ "kq3/82"                 , FALSE },
{ "kq3/83"                 , FALSE },
{ "kq3/84"                 , FALSE },
{ "kq3/85"                 , FALSE },
{ "kq3/86"                 , FALSE }, // 1070
{ "sq1/1"                  , FALSE }, // 1071
{ "sq1/2"                  , FALSE },
{ "sq1/3"                  , FALSE },
{ "sq1/4"                  , FALSE },
{ "sq1/5"                  , FALSE },
{ "sq1/6"                  , FALSE },
{ "sq1/7"                  , FALSE },
{ "sq1/8"                  , FALSE },
{ "sq1/9"                  , FALSE },
{ "sq1/10"                 , FALSE }, // 1080
{ "sq1/11"                 , FALSE },
{ "sq1/12"                 , FALSE },
{ "sq1/13"                 , FALSE },
{ "sq1/14"                 , FALSE },
{ "sq1/15"                 , FALSE },
{ "sq1/16"                 , FALSE },
{ "sq1/17"                 , FALSE },
{ "sq1/18"                 , FALSE },
{ "sq1/19"                 , FALSE },
{ "sq1/20"                 , FALSE }, // 1090
{ "sq1/21"                 , FALSE },
{ "sq1/22"                 , FALSE },
{ "sq1/23"                 , FALSE },
{ "sq1/24"                 , FALSE },
{ "sq1/25"                 , FALSE },
{ "sq1/26"                 , FALSE },
{ "sq1/27"                 , FALSE },
{ "sq1/28"                 , FALSE },
{ "sq1/29"                 , FALSE },
{ "sq1/30"                 , FALSE }, // 1100
{ "sq1/31"                 , FALSE },
{ "sq1/32"                 , FALSE },
{ "sq1/33"                 , FALSE },
{ "sq1/34"                 , FALSE },
{ "sq1/35"                 , FALSE },
{ "sq1/36"                 , FALSE },
{ "sq1/37"                 , FALSE },
{ "sq1/38"                 , FALSE },
{ "sq1/39"                 , FALSE },
{ "sq1/41"                 , FALSE }, // 1110
{ "sq1/42"                 , FALSE },
{ "sq1/43"                 , FALSE },
{ "sq1/45"                 , FALSE },
{ "sq1/46"                 , FALSE },
{ "sq1/47"                 , FALSE },
{ "sq1/48"                 , FALSE },
{ "sq1/49"                 , FALSE },
{ "sq1/50"                 , FALSE }, // 1118
{ "sq1/51"                 , FALSE },
{ "sq1/52"                 , FALSE },
{ "sq1/53"                 , FALSE },
{ "sq1/54"                 , FALSE },
{ "sq1/55"                 , FALSE },
{ "sq1/56"                 , FALSE },
{ "sq1/57"                 , FALSE },
{ "sq1/58"                 , FALSE },
{ "sq1/59"                 , FALSE },
{ "sq1/60"                 , FALSE },
{ "sq1/61"                 , FALSE },
{ "sq1/62"                 , FALSE }, // 1130
{ "sq1/64"                 , FALSE },
{ "sq1/65"                 , FALSE },
{ "sq1/70"                 , FALSE },
{ "sq1/71"                 , FALSE },
{ "sq1/73"                 , FALSE },
{ "sq1/75"                 , FALSE },
{ "sq1/80"                 , FALSE },
{ "sq1/81"                 , FALSE },
{ "sq1/82"                 , FALSE },
{ "sq1/83"                 , FALSE }, // 1140
{ "sq1/uniform-0"          , TRUE  },
{ "sq1/uniform-1"          , TRUE  },
{ "sq1/uniform-2"          , TRUE  },
{ "sq1/uniform-3"          , TRUE  },
{ "sq1/uniform-4"          , TRUE  }, // 1145
};

MODULE const STRPTR aissname[AISSIMAGES] = {
"open"                 , //  0
"save"                 , //  1
"open_s"               , //  2
"save_s"               , //  3 // speedbar imagery must be indices 0..SBIMAGES-1
"page_previous"        , //  4
"page_next"            , //  5
"selectall"            , //  6
"selectnone"           , //  7
"selecttoggle"         , //  8
"del"                  , //  9
"arrowup"              , // 10
"nav_north"            , // 11
"nav_east"             , // 12
"nav_south"            , // 13
"nav_west"             , // 14
"sortdown"             , // 15
"map"                  , // 16
"reset"                , // 17
"paint"                , // 18
"freehandpoints"       , // 19
"freehandpoints_s"     , // 20
"freehand"             , // 21
"freehand_s"           , // 22
"line"                 , // 23
"line_s"               , // 24
"rectangle"            , // 25
"rectangle_s"          , // 26
"rectanglefilled"      , // 27
"rectanglefilled_s"    , // 28
"elypse"               , // 29
"elypse_s"             , // 30
"elypsefilled"         , // 31
"elypsefilled_s"       , // 32
"fill"                 , // 33
"fill_s"               , // 34
"selectcolour"         , // 35
"selectcolour_s"       , // 36
"select"               , // 37
"select_s"             , // 38
"hand"                 , // 39
"hand_s"               , // 40
"gridvisible"          , // 41
"gridvisible_s"        , // 42
"cut"                  , // 43
"cut_s"                , // 44
"copy"                 , // 45
"copy_s"               , // 46
"paste"                , // 47
"paste_s"              , // 48
"del"                  , // 49
"del_s"                , // 50
"undo"                 , // 51
"undo_s"               , // 52
"redo"                 , // 53
"redo_s"               , // 54
"eye"                  , // 55
"gadget_frameiclass"   , // 56 IMAGE_UNAVAILABLE
"gadget_bitmap"        , // 57
"gadget_button"        , // 58
"gadget_checkbox"      , // 59
"gadget_chooser"       , // 60
"gadget_clicktab"      , // 61
"gadget_clock"         , // 62
"gadget_fuelgauge"     , // 63
"gadget_gradientslider", // 64
"gadget_integer"       , // 65
"gadget_label"         , // 66
"gadget_layout"        , // 67
"gadget_listbrowser"   , // 68
"gadget_palette"       , // 69
"gadget_radiobutton"   , // 70
"gadget_scroller"      , // 71
"gadget_sketchboard"   , // 72
"gadget_slider"        , // 73
"gadget_space"         , // 74
"gadget_speedbar"      , // 75
"gadget_string"        , // 76
"gadget_texteditor"    , // 77
"gadget_virtual"       , // 78
"map"                  , // 79 used by ph.c (MapButton2 macro)
"linkamiga"            , // 80
"sendtomail"           , // 81
"sound"                , // 82
}, PageOptions[PAGES + 1] =
{   "A-C",
    "D-Gre",
    "Gri-M",
    "N-Roc",
    "Ror-Z", // Zerg! :-)
    NULL
};

MODULE const struct
{   STRPTR longname,
           shortname,
           defaultfile,
           pattern,
           example;
    int    kind,
           filesize;
    SLONG  itemnum,
           subnum;
    STRPTR fimagename;
    FLAG   custompointer;
} funcinfo[FUNCTIONS + 1] = {
{ TITLEBARTEXT ": Choose Game"           , "MCE: Main Menu"                    , ""            , ""                             , ""                             , 0                                ,      0, IN_MAINMENU, NOSUB         , NULL           , NEVER },
// 1st page  
{ "Arazok's Tomb"                        , "Arazok's Tomb"                     , ""            , "#?.GAM"                       , "ArazoksTomb/ArazoksTomb.GAM"  , FLAG_S                           ,      0, IN_PAGE1   , SN_ARAZOK     , "arazok"       , NEVER },
{ "Barbarian 2 (Psygnosis) & Obliterator", "Barbarian 2/Obliterator"           , ""            , "(Barbarian2Psy.save|FNIAA)"   , "Obliterator/FNIAA"            , FLAG_S                           ,      0, IN_PAGE1   , SN_PSYGNOSIS  , "psygnosis"    , TRUE  },
{ "Bard's Tale 1-3 & Construction Set"   , "BT1-3/BTCS"                        , ""            , "#?"                           , "BardsTale3/game.sav"          , FLAG_C | FLAG_I | FLAG_R | FLAG_S,      0, IN_PAGE1   , SN_BT         , "bardstale"    , TRUE  },
{ "BattleTech"                           , "BattleTech"                        , ""            , "Game?"                        , "BattleTech/GAME1"             , FLAG_S                           ,   3929, IN_PAGE1   , SN_BA         , "battletech"   , TRUE  },
{ "Bloodwych & Extended Levels"          , "Bloodwych"                         , ""            , "bloodsave?|bextsave?"         , "Bloodwych/bloodsave0"         , FLAG_S                           ,  50688, IN_PAGE1   , SN_BW         , "bloodwych"    , NEVER },
{ "Bomb Jack 1"                          , "Bomb Jack 1"                       , "bj"          , "#?bj#?"                       , "BombJack1/bj"                 , FLAG_G | FLAG_L                  ,  46212, IN_PAGE1   , SN_BOMBJACK   , "bombjack"     , NEVER },
{ "Buck Rogers: Countdown to Doomsday"   , "Buck Rogers"                       , ""            , "#?.WHO"                       , "BuckRogers/BUCKROGERS.WHO"    , FLAG_C                           ,    402, IN_PAGE1   , SN_BUCK       , "buck"         , TRUE  },
{ "California 1 & 2/Winter/World Games"  , "California 1/2/Winter/World Games" , ""            , "menu.cmp|cgii|WGWR.DAT|d0.bin", "CaliforniaGames1/menu.cmp"    , FLAG_H                           ,      0, IN_PAGE1   , SN_EPYX       , "epyx"         , NEVER },
{ "Cannon Fodder 1 & 2"                  , "Cannon Fodder 1 & 2"               , ""            , "#?"                           , "CANNONF1"                     , FLAG_S                           ,   1832, IN_PAGE1   , SN_CF         , "cf"           , NEVER },
{ "Chambers of Shaolin"                  , "Chambers of Shaolin"               , "SAVEGAME"    , "#?SAVEGAME#?"                 , "ChambersOfShaolin/savegame"   , FLAG_R                           ,      0, IN_PAGE1   , SN_COS        , "cos"          , NEVER },
{ "Champions of Krynn 1-3"               , "Champions of Krynn 1-3"            , ""            , "#?.???"                       , "COK1.who"                     , FLAG_C                           ,      0, IN_PAGE1   , SN_COK        , "cok"          , TRUE  },
{ "Citadel of Vras"                      , "Citadel of Vras"                   , "savedgame"   , "#?savedgame#?"                , "CitadelOfVras/savedgame"      , FLAG_S                           ,      0, IN_PAGE1   , SN_COV        , "cov"          , NEVER },
{ "Computer Scrabble Deluxe"             , "Scrabble"                          , ""            , "#?"                           , "Scrabble"                     , FLAG_S                           ,    748, IN_PAGE1   , SN_CSD        , "csd"          , TRUE  },
{ "Conflict Europe"                      , "Conflict Europe"                   , ""            , "#?.gam"                       , "ConflictEurope.gam"           , FLAG_S                           ,      0, IN_PAGE1   , SN_CE         , "ce"           , NEVER },
// 2nd page
{ "Dark Castle & Beyond Dark Castle"     , "Dark Castle 1/2"                   , ""            , "HighScor|Disk.?"              , "DarkCastle1/HighScor"         , FLAG_H | FLAG_S                  ,      0, IN_PAGE2   , SN_DC         , "darkcastle"   , NEVER },
{ "Deja Vu 1 & 2/Shadowgate/Uninvited"   , "Deja Vu 1/2/Shadowgate/Uninvited"  , ""            , "#?"                           , "DejaVu1"                      , FLAG_S                           ,      0, IN_PAGE2   , SN_ICOM       , "icom"         , NEVER },
{ "Demon's Winter"                       , "Demon's Winter"                    , "PARTY.DAT"   , "#?PARTY.DAT#?"                , "DemonsWinter/party.dat"       , FLAG_S                           ,   1494, IN_PAGE2   , SN_DW         , "demonswinter" , TRUE  },
{ "Dragon Wars"                          , "Dragon Wars"                       , ""            , "#?.dwgame"                    , "DragonWars.dwgame"            , FLAG_S                           ,  12014, IN_PAGE2   , SN_DRA        , "dragonwars"   , TRUE  },
{ "Druid 2: Enlightenment"               , "Druid 2"                           , ""            , "(level#?|hi_scores)"          , "Druid2/level6"                , FLAG_H | FLAG_L                  ,      0, IN_PAGE2   , SN_DRUID2     , "druid2"       , FALSE },
{ "Dungeon Master 1-2 & Chaos Strikes Back","DM1-2 & CSB"                      , ""            , "#?.DAT"                       , "DungeonMaster/DMGAME_0.DAT"   , FLAG_S | FLAG_L                  ,      0, IN_PAGE2   , SN_DM         , "dm"           , TRUE  },
{ "Eye of the Beholder 1 & 2"            , "EOB1/2"                            , ""            , "EOBDATA#?.SAV"                , "EyeOfTheBeholder1/EOBDATA.SAV", FLAG_S                           ,      0, IN_PAGE2   , SN_EOB        , "eob"          , TRUE  },
{ "F/A-18 Interceptor"                   , "F/A-18 Interceptor"                , "config"      , "#?config#?"                   , "Interceptor/config"           , FLAG_C                           ,     78, IN_PAGE2   , SN_FA18       , "fa18"         , FALSE },
{ "Faery Tale Adventure"                 , "Faery Tale Adventure"              , ""            , "#?.faery"                     , "A.faery"                      , FLAG_S                           ,      0, IN_PAGE2   , SN_FTA        , "fta"          , TRUE  },
{ "Firepower & Turbo"                    , "Firepower/Turbo"                   , ""            , "T?"                           , "Firepower/t1"                 , FLAG_G | FLAG_L                  ,      0, IN_PAGE2   , SN_SS         , "silent"       , FALSE },
{ "Garrison 1 & 2"                       , "Garrison 1/2"                      , "Disk.2"      , "#?Disk.2#?"                   , ""                             , FLAG_H | FLAG_L                  , 737280, IN_PAGE2   , SN_GARRISON   , "garrison"     , FALSE },
{ "Goal!"                                , "Goal!"                             , "Disk.3"      , "#?Disk.3#?"                   , ""                             , FLAG_R                           , 901120, IN_PAGE2   , SN_GOAL       , "goal"         , FALSE },
{ "Grand Monster Slam"                   , "Grand Monster Slam"                , "Disk.1"      , "#?Disk.1#?"                   , ""                             , FLAG_H                           , 901120, IN_PAGE2   , SN_GMS        , "gms"          , FALSE },
{ "Great Giana Sisters/Hard 'n' Heavy"   , "GGS/HnH"                           , ""            , "#?high#?"                     , "gianahigh"                    , FLAG_H                           ,      0, IN_PAGE2   , SN_GIANA      , "giana"        , FALSE },
// 3rd page
{ "GridStart 1-3"                        , "GridStart 1-3"                     , "topScores"   , "#?topScores#?"                , "GridStart/topScores"          , FLAG_H                           ,    206, IN_PAGE3   , SN_GRIDSTART  , "gridstart"    , FALSE },
{ "HackLite/Larn/Moria/Rogue"            , "HackLite/Larn/Moria/Rogue"         , ""            , "#?"                           , "HackLite/HackLite"            , FLAG_H | FLAG_S                  ,      0, IN_PAGE3   , SN_ROGUE      , "rogue"        , TRUE  },
{ "Heroes of the Lance & Dragons of Flame","HOTL/DOF"                          , ""            , "(D&DDL?.SAV|D&DDL1B.PRG|Disk.?)","HeroesOfTheLance/D&DDL9.SAV" , FLAG_H | FLAG_S                  ,      0, IN_PAGE3   , SN_HOL        , "hol"          , FALSE },
{ "Hillsfar"                             , "Hillsfar"                          , ""            , "#?.HIL"                       , "Hillsfar.HIL"                 , FLAG_C                           ,    188, IN_PAGE3   , SN_HILLSFAR   , "hillsfar"     , FALSE },
{ "Impossible Mission 2"                 , "Impossible Mission 2"              , ""            , "(game|score)"                 , "ImpossibleMission2/GAME"      , FLAG_H | FLAG_S                  ,      0, IN_PAGE3   , SN_IM2        , "im2"          , FALSE },
{ "Insanity Fight"                       , "Insanity Fight"                    , "Disk.1"      , "#?Disk.1#?"                   , ""                             , FLAG_G | FLAG_L                  , 901120, IN_PAGE3   , SN_IF         , "if"           , FALSE },
{ "It Came from the Desert 1 & 2"        , "ICFTD 1/2"                         , ""            , "#?ICFTD#?"                    , "ICFTD"                        , FLAG_S                           ,      0, IN_PAGE3   , SN_ICFTD      , "icftd"        , NEVER },
{ "Keef the Thief"                       , "Keef the Thief"                    , "SG"          , "#?SG#?"                       , "KeefTheThief/SG"              , FLAG_S                           ,   2000, IN_PAGE3   , SN_KEEF       , "keef"         , NEVER },
{ "King's Quest 1-3 & Space Quest 1"     , "KQ1-3/SQ1"                         , ""            , "#?sg.#?"                      , "sqsg.1"                       , FLAG_S                           ,      0, IN_PAGE3   , SN_KQ         , "kq"           , TRUE  },
{ "Last Ninja Remix"                     , "Last Ninja Remix"                  , "Disk.1"      , "#?Disk.1#?"                   , ""                             , FLAG_S                           , 819200, IN_PAGE3   , SN_LASTNINJA  , "lastninja"    , FALSE },
{ "Legend of Faerghail"                  , "Legend of Faerghail"               , "ROST"        , "#?ROST#?"                     , "LegendOfFaerghail/ROST"       , FLAG_S                           ,      0, IN_PAGE3   , SN_LOF        , "lof"          , TRUE  },
{ "Legend of Lothian"                    , "Legend of Lothian"                 , ""            , "#?.save"                      , "LegendOfLothian.save"         , FLAG_S                           ,     96, IN_PAGE3   , SN_LOL        , "lol"          , TRUE  },
{ "Mercenary: Escape from Targ & The Second City", "Mercenary"                 , ""            , "Mercenary?.save?"             , "Mercenary1.save0"             , FLAG_S                           ,   5162, IN_PAGE3   , SN_MERCENARY  , "mercenary"    , FALSE },
{ "Might & Magic 2 & 3"                  , "Might & Magic 2 & 3"               , ""            , "(ROSTER.DAT|save??.mm3)"      , "Might&Magic2/roster.dat"      , FLAG_S                           ,      0, IN_PAGE3   , SN_MM         , "mm"           , TRUE  },
{ "Mindshadow & Borrowed Time & Tass Times in Tonetown", "Mindshadow/Borrowed Time/TTITT", ""  , "SV?"                          , "Mindshadow/SVB"               , FLAG_S                           ,      0, IN_PAGE3   , SN_INTERPLAY  , "interplay"    , FALSE },
// 4th page
{ "Neuromancer"                          , "Neuromancer"                       , ""            , "Game#?"                       , "Neuromancer/game1"            , FLAG_S                           ,   1564, IN_PAGE4   , SN_NEUROMANCER, "neuromancer"  , TRUE  },
{ "Nitro"                                , "Nitro"                             , "high"        , "#?high#?"                     , "Nitro/high"                   , FLAG_H                           ,    320, IN_PAGE4   , SN_NITRO      , "nitro"        , FALSE },
{ "Oo-Topos & Transylvania 1 & 2"        , "Oo-Topos/Transylvania 1/2"         , ""            , "ccgdt?.yyy"                   , "Oo-Topos/CCGDT0.YYY"          , FLAG_S                           ,      0, IN_PAGE4   , SN_POLARWARE  , "polarware"    , TRUE  },
{ "Panza Kickboxing 1 & 2"               , "Panza Kickboxing 1 & 2"            , ""            , "BOXER.00?"                    , "BOXER.00A"                    , FLAG_C                           ,      0, IN_PAGE4   , SN_PANZA      , "panza"        , FALSE },
{ "Phantasie 1 & 3"                      , "Phantasie 1/3"                     , ""            , "(GUILD.DAT|GAMESAVE.DAT)"     , "Phantasie1/guild.dat"         , FLAG_S                           ,      0, IN_PAGE4   , SN_PHANTASIE  , "phantasie"    , TRUE  },
{ "Pinball Dreams/Fantasies/Illusions"   , "Pinball Dreams/Fantasies/Illusions", ""            , "#?"                           , "PinballDreams/HIGH"           , FLAG_H                           ,      0, IN_PAGE4   , SN_PINBALL    , "pinball"      , FALSE },
{ "Pirates! & Pirates! Gold"             , "Pirates!/Pirates! Gold"            , ""            , "(#?.pir|PG32|nvram)"          , "Pirates.pir"                  , FLAG_S                           ,      0, IN_PAGE4   , SN_PIRATES    , "pirates"      , FALSE },
{ "Pool of Radiance 1-4"                 , "Pool of Radiance 1-4"              , ""            , "#?"                           , "PoolOfRadiance/POR.cha"       , FLAG_C                           ,      0, IN_PAGE4   , SN_POR        , "por"          , TRUE  },
{ "Quadralien"                           , "Quadralien"                        , ""            , "#?"                           , "Quadralien"                   , FLAG_S                           ,  12530, IN_PAGE4   , SN_QUADRALIEN , "quadralien"   , FALSE },
{ "Questron 2"                           , "Questron 2"                        , "G1"          , "G?"                           , "Questron2/G1"                 , FLAG_S                           ,    255, IN_PAGE4   , SN_Q2         , "q2"           , TRUE  },
{ "Ragnarok"                             , "Ragnarok"                          , "SAVEGAME"    , "#?savegame#?"                 , "Ragnarok/SAVEGAME"            , FLAG_S                           ,   5120, IN_PAGE4   , SN_RAGNAROK   , "ragnarok"     , NEVER },
{ "Return of the Jedi"                   , "Return of the Jedi"                , "hiscores"    , "#?hiscores#?"                 , "ReturnOfTheJedi/hiscores"     , FLAG_H                           ,    290, IN_PAGE4   , SN_ROTJ       , "rotj"         , FALSE },
{ "Robin Hood & Rome: AD92"              , "Robin Hood/Rome: AD92"             , "Disk.2"      , "(Disk.2|Rome92ad.save)"       , "RobinHood/Disk.2"             , FLAG_S                           ,      0, IN_PAGE4   , SN_ROBIN      , "robinhood"    , FALSE },
{ "Rockford"                             , "Rockford"                          , ""            , "(maps|Rockford.hi)"           , "Rockford1/maps"               , FLAG_G | FLAG_H | FLAG_L         ,      0, IN_PAGE4   , SN_ROCKFORD   , "rockford"     , FALSE },
// 5th page
{ "Rorke's Drift"                        , "Rorke's Drift"                     , ""            , "RD?.DAT"                      , "RD1.BAT"                      , FLAG_A                           ,  49202, IN_PAGE5   , SN_RORKE      , "rorke"        , TRUE  },
{ "Shadowlands & Shadoworlds"            , "Shadowlands & Shadoworlds"         , "Disk.3"      , "#?Disk.3#?"                   , "Shadowlands/Disk.3"           , FLAG_S                           ,      0, IN_PAGE5   , SN_SHADOW     , "shadow"       , NEVER },
{ "SideWinder 1 & 2"                     , "SideWinder 1/2"                    , ""            , "(level?.m|level?.dat)"        , "SideWinder1/level1.m"         , FLAG_G | FLAG_L                  ,      0, IN_PAGE5   , SN_SIDEWINDER , "sidewinder"   , FALSE },
{ "Sinbad and the Throne of the Falcon"  , "Sinbad"                            , ""            , "#?"                           , "Sinbad"                       , FLAG_S                           ,   1248, IN_PAGE5   , SN_SINBAD     , "sinbad"       , NEVER },
{ "Slaygon"                              , "Slaygon"                           , ""            , "#?slaygon.save#?"             , "slaygon.save"                 , FLAG_S                           ,  64684, IN_PAGE5   , SN_SLAYGON    , "slaygon"      , TRUE  },
{ "Speedball 1 & 2"                      , "Speedball 1/2"                     , ""            , "#?.sav#?"                     , "Speedball1/league"            , FLAG_S                           ,      0, IN_PAGE5   , SN_SPEEDBALL  , "speedball"    , FALSE },
{ "Syndicate"                            , "Syndicate"                         , ""            , "0?.gam"                       , "Syndicate/00.gam"             , FLAG_S                           ,  10288, IN_PAGE5   , SN_SYNDICATE  , "syndicate"    , TRUE  },
{ "Temple of Apshai"                     , "Temple of Apshai"                  , ""            , "#?"                           , "TempleOfApshai/cip"           , FLAG_C | FLAG_S                  ,      0, IN_PAGE5   , SN_TOA        , "toa"          , NEVER },
{ "Times of Lore"                        , "Times of Lore"                     , "SAVEGAME.DAT", "#?SAVEGAME.DAT#?"             , "TimesOfLore/SAVEGAME.DAT"     , FLAG_S                           ,   5782, IN_PAGE5   , SN_TOL        , "tol"          , NEVER },
{ "TV Sports Baseball/Basketball/Boxing/Football", "TVS Bsbl/Bsktbl/Bxng/Ftbl" , ""            , "(BOXRDATA.BLT|seas.blt|tdat)" , "TVSportsBaseball/seas.blt"    , FLAG_R                           ,      0, IN_PAGE5   , SN_TVS        , "tvs"          , FALSE },
{ "Ultima 3-6"                           , "Ultima 3-6"                        , ""            , "#?"                           , "Ultima3/ROST.BIN"             , FLAG_C | FLAG_S                  ,      0, IN_PAGE5   , SN_ULTIMA     , "ultima"       , TRUE  },
{ "War in Middle Earth"                  , "War in Middle Earth"               , "ARCHIVE.DAT" , "#?ARCHIVE.DAT#?"              , "WarInMiddleEarth/ARCHIVE.DAT" , FLAG_S                           ,   8330, IN_PAGE5   , SN_WIME       , "wime"         , NEVER },
{ "Wizardry 6"                           , "Wizardry 6"                        , "SAVEGAME.DBS", "#?SAVEGAME.DBS#?"             , "Wizardry6/SAVEGAME.DBS"       , FLAG_S                           ,      0, IN_PAGE5   , SN_WIZ        , "w6"           , TRUE  },
{ "Zerg"                                 , "Zerg"                              , "SAVE"        , "#?SAVE#?"                     , "Zerg/save"                    , FLAG_S                           ,   2026, IN_PAGE5   , SN_ZERG       , "zerg"         , NEVER },
};

MODULE struct NewMenu NewMenu[] =
{   { NM_TITLE, "Project"                            ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Open..."                            , "O", 0                   , 0, 0},
    {  NM_ITEM, "Revert"                             , "R", 0                   , 0, 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Save"                               , "S", 0                   , 0, 0},
    {  NM_ITEM, "Save as..."                         , "A", 0                   , 0, 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Iconify"                            , "I", 0                   , 0, 0},
    {  NM_ITEM, "Quit MCE"                           , "Q", 0                   , 0, 0},
    { NM_TITLE, "View"                               ,  0,  0                   , 0, 0},
#ifdef __MORPHOS__
    {  NM_ITEM, "Custom mouse pointer?"              , "P", CHECKIT | MENUTOGGLE | NM_ITEMDISABLED, 0, 0},
#else
    {  NM_ITEM, "Custom mouse pointer?"              , "P", CHECKIT | MENUTOGGLE                  , 0, 0},
#endif
    {  NM_ITEM, "Toolbar?"                           , "H", CHECKIT | MENUTOGGLE, 0, 0},
    { NM_TITLE, "Tools"                              ,  0,  0                   , 0, 0},
    {  NM_ITEM, "Main Menu"                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "A-C"                                ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Arazok's Tomb"                      , "1", 0                   , 0, 0},
    {   NM_SUB, "Barbarian 2 (Psygnosis) & Obliterator","2",0                   , 0, 0},
    {   NM_SUB, "Bard's Tale 1-3 & Construction Set" , "3", 0                   , 0, 0},
    {   NM_SUB, "BattleTech"                         , "4", 0                   , 0, 0},
    {   NM_SUB, "Bloodwych & Extended Levels"        , "5", 0                   , 0, 0},
    {   NM_SUB, "Bomb Jack 1"                        , "6", 0                   , 0, 0},
    {   NM_SUB, "Buck Rogers"                        , "7", 0                   , 0, 0},
    {   NM_SUB, "California 1 & 2/Winter/World Games", "8", 0                   , 0, 0},
    {   NM_SUB, "Cannon Fodder 1 & 2"                , "9", 0                   , 0, 0},
    {   NM_SUB, "Chambers of Shaolin"                , "0", 0                   , 0, 0},
    {   NM_SUB, "Champions of Krynn 1-3"             , "-", 0                   , 0, 0},
    {   NM_SUB, "Citadel of Vras"                    , "=", 0                   , 0, 0},
    {   NM_SUB, "Computer Scrabble Deluxe"           ,"\\", 0                   , 0, 0},
    {   NM_SUB, "Conflict Europe"                    ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "D-Gre"                              ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Dark Castle & Beyond Dark Castle"   , "!", 0                   , 0, 0},
    {   NM_SUB, "Deja Vu 1 & 2/Shadowgate/Uninvited" , "@", 0                   , 0, 0},
    {   NM_SUB, "Demon's Winter"                     , "#", 0                   , 0, 0},
    {   NM_SUB, "Dragon Wars"                        , "$", 0                   , 0, 0},
    {   NM_SUB, "Druid 2"                            , "%", 0                   , 0, 0},
    {   NM_SUB, "Dungeon Master 1-2 & Chaos Strikes Back","^",0                 , 0, 0},
    {   NM_SUB, "Eye of the Beholder 1 & 2"          , "&", 0                   , 0, 0},
    {   NM_SUB, "F/A-18 Interceptor"                 , "*", 0                   , 0, 0},
    {   NM_SUB, "Faery Tale Adventure"               , "(", 0                   , 0, 0},
    {   NM_SUB, "Firepower & Turbo"                  , ")", 0                   , 0, 0},
    {   NM_SUB, "Garrison 1 & 2"                     , "_", 0                   , 0, 0},
    {   NM_SUB, "Goal!"                              , "+", 0                   , 0, 0},
    {   NM_SUB, "Grand Monster Slam"                 , "|", 0                   , 0, 0},
    {   NM_SUB, "Great Giana Sisters/Hard 'n' Heavy" ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Gri-M"                              ,  0 , 0                   , 0, 0},
    {   NM_SUB, "GridStart 1-3"                      ,  0 , 0                   , 0, 0},
    {   NM_SUB, "HackLite/Larn/Moria/Rogue"          ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Heroes of the Lance & Dragons of Flame",0, 0                   , 0, 0},
    {   NM_SUB, "Hillsfar"                           ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Impossible Mission 2"               ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Insanity Fight"                     ,  0 , 0                   , 0, 0},
    {   NM_SUB, "It Came from the Desert 1 & 2"      ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Keef the Thief"                     ,  0 , 0                   , 0, 0},
    {   NM_SUB, "King's Quest 1-3 & Space Quest 1"   ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Last Ninja Remix"                   ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Legend of Faerghail"                ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Legend of Lothian"                  ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Mercenary"                          ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Might & Magic 2 & 3"                ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Mindshadow/Borrowed Time/Tass Times",  0 , 0                   , 0, 0},
    {  NM_ITEM, "N-Roc"                              ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Neuromancer"                        ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Nitro"                              ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Oo-Topos & Transylvania 1 & 2"      ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Panza Kickboxing 1 & 2"             ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Phantasie 1 & 3"                    ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Pinball Dreams/Fantasies/Illusions" ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Pirates! & Pirates! Gold"           ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Pool of Radiance 1-4"               ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Quadralien"                         ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Questron 2"                         ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Ragnarok"                           ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Return of the Jedi"                 ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Robin Hood & Rome: AD92"            ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Rockford"                           ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Ror-Z"                              ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Rorke's Drift"                      ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Shadowlands & Shadoworlds"          ,  0 , 0                   , 0, 0},
    {   NM_SUB, "SideWinder 1 & 2"                   ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Sinbad and the Throne of the Falcon",  0 , 0                   , 0, 0},
    {   NM_SUB, "Slaygon"                            ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Speedball 1 & 2"                    ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Syndicate"                          ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Temple of Apshai"                   ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Times of Lore"                      ,  0 , 0                   , 0, 0},
    {   NM_SUB, "TV Sports Base/Basket/Football"     ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Ultima 3-6"                         ,  0 , 0                   , 0, 0},
    {   NM_SUB, "War in Middle Earth"                ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Wizardry 6"                         ,  0 , 0                   , 0, 0},
    {   NM_SUB, "Zerg"                               ,  0 , 0                   , 0, 0},
    { NM_TITLE, "Help"                               ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "File formats..."                    ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Manual..."                          , "M", 0                   , 0, 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "Check for updates..."               , "U", 0                   , 0, 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "About ReAction..."                  ,  0 , 0                   , 0, 0},
    {  NM_ITEM, "About MCE..."                       , "?", 0                   , 0, 0},
    {   NM_END, NULL                                 ,  0 , 0                   , 0, 0}
};

// This isn't a structure but is put here for convenience
MODULE const int numgads[PAGES] =
{   14,
    14,
    15,
    14,
    14,
}; // Zerg! :-)

MODULE const STRPTR SexOptions[2] =
{ "Male",
  "Female"
};

MODULE struct HintInfo sketchboard_hintinfo[] = {
// hi_GadgetID is initialized later
{  0, COMMAND_CUT         + 1, "Cut (X)"               , 0},
{  0, COMMAND_COPY        + 1, "Copy (C)"              , 0},
{  0, COMMAND_PASTE       + 1, "Paste (V)"             , 0},
{  0, COMMAND_ERASE       + 1, "Erase"                 , 0},
{  0, COMMAND_UNDO        + 1, "Undo (Z)"              , 0},
{  0, COMMAND_REDO        + 1, "Redo (Y)"              , 0},
{  1, PAINT_FREEHANDDOT   + 1, "Freehand dot (D)"      , 0},
{  1, PAINT_FREEHANDLINE  + 1, "Freehand line (H)"     , 0},
{  1, PAINT_LINE          + 1, "Line (L)"              , 0},
{  1, PAINT_RECT          + 1, "Unfilled rectangle (R)", 0},
{  1, PAINT_FILLEDRECT    + 1, "Filled rectangle (I)"  , 0},
{  1, PAINT_ELLIPSE       + 1, "Unfilled ellipse (E)"  , 0},
{  1, PAINT_FILLEDELLIPSE + 1, "Filled ellipse (P)"    , 0},
{  1, PAINT_FLOODFILL     + 1, "Flood fill (F)"        , 0},
{  1, PAINT_SELECTCOLOUR  + 1, "Select colour (S)"     , 0},
#ifndef __amigaos4__
{  1, PAINT_MARK          + 1, "Select area (A)"       , 0},
{  1, PAINT_MOVE          + 1, "Move (M)"              , 0},
#endif
{  1, PAINT_GRID          + 1, "Toggle grid on/off (G)", 0},
{ -1, -1                     , NULL                    , 0}  // terminator
};
// Used   are A CDEFGHI  LM  P RS  V XYZ
// Unused are  B       JK  NO Q  TU W

#ifndef __MORPHOS__
MODULE const UWORD CHIP CrossData[4 + (15 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    .... ...# .... ....
    #### ###. #### ###.
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
    0xFEFE, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,
    0x0100, 0x0000,

    0x0000, 0x0000  // reserved
}, WestwoodMouseData[4 + (15 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .L.. .... .... ....    . = Transparent (%00)
    KLL. .... .... ....    D = Dark red    (%01)
    KDLL .... .... ....    K = Black       (%10)
    KDLL L... .... ....    L = Light red   (%11)
    KDDL LL.. .... ....
    KDDL LLL. .... ....
    KDDD LLLL .... ....
    KDDD LLLL L... ....
    KDDD DLKK K... ....
    KDDK DL.. .... ....
    KDKK KDL. .... ....
    KKK. KDL. .... ....
    KK.. KKDL .... ....
    .... .KDL .... ....
    .... .KK. .... ....

    Plane 0 Plane 1 */
    0x4000, 0x4000,
    0x6000, 0xE000,
    0x7000, 0xB000,
    0x7800, 0xB800,
    0x7C00, 0x9C00,
    0x7E00, 0x9E00,
    0x7F00, 0x8F00,
    0x7F80, 0x8F80,
    0x7C00, 0x8780,
    0x6C00, 0x9400,
    0x4600, 0xBA00,
    0x0600, 0xEA00,
    0x0300, 0xCD00,
    0x0300, 0x0500,
    0x0000, 0x0600,

    0x0000, 0x0000  // reserved
};
#endif

// 7. MODULE FUNCTIONS ---------------------------------------------------

MODULE void menu(void);
MODULE void menu_loop(ULONG gid, UNUSED ULONG code);
MODULE void about_loop(void);
MODULE ULONG Hook0Func(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg);
MODULE void help_manual(void);
MODULE void iconify(void);
MODULE void uniconify(void);
MODULE void openurl(STRPTR command);
MODULE void parsewb(void);
MODULE void addtype(int kind, STRPTR thestring, FLAG editor);
MODULE void help_update(void);
MODULE void load_fimages(FLAG startup);
MODULE void changepage(void);
MODULE void settitle(FLAG subwin);
MODULE void getpens(void);

// sketchboard
MODULE void changetool(ULONG newtool, FLAG keyboard);
MODULE void undo(void);
MODULE void redo(void);
MODULE FLAG edit_cut(void);
MODULE void edit_erase(void);
MODULE FLAG edit_copy(void);
MODULE FLAG edit_paste(void);
MODULE void ghostundos(void);
MODULE void sketchboard_subtick(SWORD mousex, SWORD mousey);

// 8. CODE ---------------------------------------------------------------

#ifdef __SASC
    int  CXBRK(void)    { return 0; } /* Disable SAS/C Ctrl-C handling */
    void chkabort(void) { ;         } /* really */
#endif

EXPORT int main(int argc, char** argv)
{   SWORD            wbwidth,
                     wbheight;
    SLONG            args[ARGUMENTS + 1],
                     number;
    ULONG            newwidth, newheight;
    int              i;
    BPTR             TheHandle /* = ZERO */ ,
                     OldDir;
#ifdef __amigaos4__
    TEXT             envbuffer[13 + 1];
#endif

    // Start of program

    screenname[0]     =
    aslfile[0]        = EOS;
    for (i = 0; i <= ARGUMENTS; i++)
    {   args[i]       = 0;
    }
    for (i = 0; i < BITMAPS; i++)
    {   image[i]      = NULL;
    }
    for (i = 0; i <= FUNCTIONS; i++)
    {   fimage[i]     =
        menufimage[i] = NULL;
        wasrun[i]     = FALSE;
    }
#ifdef __amigaos4
    for (i = 0; i < OS4IMAGES; i++)
    {   menuimage[i] = NULL;
    }
#endif
    for (i = 0; i < AISSIMAGES; i++)
    {   aissimage[i] = NULL;
    }
    for (i = 0; i <= FUNCTIONS; i++)
    {   winbox[i].Left   =
        winbox[i].Top    =
        winbox[i].Width  =
        winbox[i].Height = -1;
    }
    NewList(&SexList);
    NewList(&SpeedBarList);
    NewList(&CommandBarList);
    NewList(&PaintBarList);

    firstgad[0] = GID_0_BU1;
    for (i = 1; i < PAGES; i++)
    {   firstgad[i] = firstgad[i - 1] + numgads[i - 1];
    }

    // Check for OS3.9+...

#if !defined(__amigaos4__) && !defined(__MORPHOS__)
    if (SysBase->LibNode.lib_Version < OS_31)
    {   Printf("MCE: Need exec.library V40+!\n");
        cleanexit(EXIT_FAILURE);
    }
#endif

    if
    (   !(VersionBase     = (struct Library*) OpenLibrary("version.library",            OS_39 ))
     || !(ButtonBase      = (struct Library*) OpenLibrary("gadgets/button.gadget",      OS_35 ))
     || !(CheckBoxBase    = (struct Library*) OpenLibrary("gadgets/checkbox.gadget",    OS_35 ))
     || !(ChooserBase     = (struct Library*) OpenLibrary("gadgets/chooser.gadget",     OS_39 )) // 44.5  and earlier: not OK. 45.7  and later: OK.
     || !(LabelBase       = (struct Library*) OpenLibrary("images/label.image",         OS_35 ))
     || !(LayoutBase      = (struct Library*) OpenLibrary("gadgets/layout.gadget",      OS_35 ))
     || !(ListBrowserBase = (struct Library*) OpenLibrary("gadgets/listbrowser.gadget", OS_ANY))
     || !(StringBase      = (struct Library*) OpenLibrary("gadgets/string.gadget",      OS_39 )) // 44.2  and earlier: not OK. 45.16 and later: OK.
     || !(TextFieldBase   = (struct Library*) OpenLibrary("gadgets/texteditor.gadget",  OS_ANY))
     || !(WindowBase      = (struct Library*) OpenLibrary("window.class",               OS_31 ))
     || !(VirtualBase     = (struct Library*) OpenLibrary("gadgets/virtual.gadget",     OS_ANY))
#if defined(__amigaos4__) && defined(__VBCC__)
     || !(IntuitionBase   =                         OpenLibrary("intuition.library",    OS_31 ))
#else
     || !(IntuitionBase   = (struct IntuitionBase*) OpenLibrary("intuition.library",    OS_31 ))
#endif
     || !(AslBase         = (struct Library*) OpenLibrary("asl.library",                OS_ANY))
     || !(DatatypesBase   = (struct Library*) OpenLibrary("datatypes.library",          OS_ANY))
     || !(DiskfontBase    = (struct Library*) OpenLibrary("diskfont.library",           OS_ANY))
     || !(IconBase        = (struct Library*) OpenLibrary("icon.library",               41    ))
     || !(IFFParseBase    = (struct Library*) OpenLibrary("iffparse.library",           OS_ANY))
     || !(WorkbenchBase   = (struct Library*) OpenLibrary("workbench.library",          OS_35 ))
    )
    {   DISCARD Printf("MCE: Need AmigaOS 3.9+BB2!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(BitMapBase      = (struct Library*) OpenLibrary("images/bitmap.image",        OS_35 )))
    {   DISCARD Printf("MCE: Need bitmap.image V44+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(FuelGaugeBase   = (struct Library*) OpenLibrary("gadgets/fuelgauge.gadget",   OS_ANY)))
    {   DISCARD Printf("MCE: Need fuelgauge.gadget!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GradientSliderBase = (struct Library*) OpenLibrary("gadgets/gradientslider.gadget", OS_ANY)))
    {   DISCARD Printf("MCE: Need gradientslider.gadget!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IntegerBase     = (struct Library*) OpenLibrary("gadgets/integer.gadget",     OS_35 )))
    {   DISCARD Printf("MCE: Need integer.gadget V44+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(PaletteBase     = (struct Library*) OpenLibrary("gadgets/palette.gadget",     OS_ANY)))
    {   DISCARD Printf("MCE: Need palette.gadget!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(ScrollerBase    = (struct Library*) OpenLibrary("gadgets/scroller.gadget",    OS_ANY)))
    {   DISCARD Printf("MCE: Need scroller.gadget!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(SliderBase      = (struct Library*) OpenLibrary("gadgets/slider.gadget",      OS_ANY))) // not sure which version is needed
    {   DISCARD Printf("MCE: Need slider.gadget!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(SpeedBarBase    = (struct Library*) OpenLibrary("gadgets/speedbar.gadget",    41    )))
    {   DISCARD Printf("MCE: Need speedbar.gadget V41+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(ClickTabBase    = (struct Library*) OpenLibrary("gadgets/clicktab.gadget",    OS_39 ))) // 44.45 and earlier: not OK. 45.3  and later: OK.
    {   DISCARD Printf("MCE: Need clicktab.gadget V45+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(RadioButtonBase = (struct Library*) OpenLibrary("gadgets/radiobutton.gadget", OS_39 ))) // 44.1  and earlier: not OK. 45.4  and later: OK.
    {   DISCARD Printf("MCE: Need radiobutton.gadget V45+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(SpaceBase       = (struct Library*) OpenLibrary("gadgets/space.gadget",       OS_35 )))
    {   DISCARD Printf("MCE: Need space.gadget V44+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GadToolsBase    = (struct Library*) OpenLibrary("gadtools.library",           OS_21 )))
    {   DISCARD Printf("MCE: Need gadtools.library V38+!\n");
        cleanexit(EXIT_FAILURE);
    }
#if defined(__VBCC__) && defined(__amigaos4__)
    if (!(GfxBase         =                   OpenLibrary("graphics.library",           OS_ANY)))
#else
    if (!(GfxBase         = (struct GfxBase*) OpenLibrary("graphics.library",           OS_ANY)))
#endif
    {   DISCARD Printf("MCE: Need graphics.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(AmigaGuideBase  = (struct Library*) OpenLibrary("amigaguide.library",         OS_ANY)))
    {   DISCARD Printf("MCE: Need amigaguide.library!\n");
        cleanexit(EXIT_FAILURE);
    }
#if defined(__SASC) || defined(__MORPHOS__) || defined(__VBCC__)
    if (!(UtilityBase =                       OpenLibrary("utility.library", 0)))
#else
    if (!(UtilityBase = (struct UtilityBase*) OpenLibrary("utility.library", 0)))
#endif
    {   DISCARD Printf("MCE: Need utility.library!\n");
        cleanexit(EXIT_FAILURE);
    }

#ifndef __MORPHOS__
    if ((ClockBase = (struct ClassLibrary*) OpenLibrary("gadgets/clock.gadget", OS_ANY)))
    {   ClockClass = ClockBase->cl_Class;
    }
#endif

    RequesterBase = OpenLibrary("requester.class", 47);
#ifdef __amigaos4__
    if (RequesterBase && !((IRequester = (struct RequesterIFace*) GetInterface(RequesterBase, "main", 1, 0))))
    {   CloseLibrary(RequesterBase);
        RequesterBase = NULL;
    }
#endif

    GetColorBase    = OpenLibrary("gadgets/getcolor.gadget"   , OS_ANY);

    if ((SketchBoardBase = OpenLibrary("gadgets/sketchboard.gadget", OS_ANY)))
    {   if
        (   SketchBoardBase->lib_Version < 50
         && (    SketchBoardBase->lib_Version >  47
             || (SketchBoardBase->lib_Version == 47 && SketchBoardBase->lib_Revision >= 19)
        )   )
        {   bb1sk = TRUE;
    }   }

#ifdef __amigaos4__
    if
    (
#ifdef __VBCC__
        (    IntuitionBase->lib_Version         >  54
         || (IntuitionBase->lib_Version         == 54 && IntuitionBase->lib_Revision         >= 6)
#else
        (    IntuitionBase->LibNode.lib_Version >  54
         || (IntuitionBase->LibNode.lib_Version == 54 && IntuitionBase->LibNode.lib_Revision >= 6)
#endif

        )
     && Exists("TBImages:")
    )
    {   os4menus = TRUE;
    }
#endif

    wbver = VersionBase->lib_Version;
    wbrev = VersionBase->lib_Revision;
    // assert(VersionBase);
    CloseLibrary(VersionBase);
    VersionBase = NULL;

    if
    (   wbver > 53
#if defined(__amigaos4__) && defined(__VBCC__)
     || (wbver == 53 && SysBase->lib_Revision         >= 12)
#else
     || (wbver == 53 && SysBase->LibNode.lib_Revision >= 12)
#endif
    ) // if (OS4.1.1) or later
    {   urlopen = TRUE;
    } else
    {   OpenURLBase = OpenLibrary("openurl.library", 0);
#ifdef __amigaos4__
        if (OpenURLBase)
        {   IOpenURL = (struct OpenURLIFace*)
                       GetInterface(OpenURLBase, "main", 1, 0);
        }
#endif
    }
    stringextra = (StringBase->lib_Version >= 47) ? 0 : 1;
    if (FindResident("MorphOS"))
    {   morphos = TRUE;
    }
    if (SpeedBarBase->lib_Version == 47 && SpeedBarBase->lib_Revision <=  8)
    {   broken = TRUE;
    } else
    {   broken = FALSE;
    }
    if
    (   (ChooserBase->lib_Version == 47 &&  ChooserBase->lib_Revision >= 16)
     || (ChooserBase->lib_Version == 48 &&  ChooserBase->lib_Revision >=  5)
     ||  ChooserBase->lib_Version == 49
    )
    {   narrowchoosers = TRUE;
    } else
    {   narrowchoosers = FALSE;
    }

#ifdef __amigaos4__
    if
    (   !(IAmigaGuide     = (struct AmigaGuideIFace*)     GetInterface(AmigaGuideBase,     "main", 1, 0))
     || !(IAsl            = (struct AslIFace*)            GetInterface(AslBase,            "main", 1, 0))
     || !(IDataTypes      = (struct DataTypesIFace*)      GetInterface(DatatypesBase,      "main", 1, 0))
     || !(IDiskfont       = (struct DiskfontIFace*)       GetInterface((struct Library*) DiskfontBase,   "main", 1, 0))
     || !(IGadTools       = (struct GadToolsIFace*)       GetInterface(GadToolsBase,       "main", 1, 0))
     || !(IGraphics       = (struct GraphicsIFace*)       GetInterface((struct Library*) GfxBase,        "main", 1, 0))
     || !(IIcon           = (struct IconIFace*)           GetInterface(IconBase,           "main", 1, 0))
     || !(IIFFParse       = (struct IFFParseIFace*)       GetInterface(IFFParseBase,       "main", 1, 0))
     || !(IIntuition      = (struct IntuitionIFace*)      GetInterface((struct Library*) IntuitionBase,  "main", 1, 0))
#ifdef __VBCC__
     || !(IUtility        = (struct UtilityIFace*)        GetInterface(UtilityBase,        "main", 1, 0))
#else
     || !(IUtility        = (struct UtilityIFace*)        GetInterface((struct Library*) UtilityBase,    "main", 1, 0))
#endif
     || !(IWorkbench      = (struct WorkbenchIFace*)      GetInterface(WorkbenchBase,      "main", 1, 0))
     || !(IBitMap         = (struct BitMapIFace*)         GetInterface(BitMapBase,         "main", 1, 0))
     || !(IButton         = (struct ButtonIFace*)         GetInterface(ButtonBase,         "main", 1, 0))
     || !(ICheckBox       = (struct CheckBoxIFace*)       GetInterface(CheckBoxBase,       "main", 1, 0))
     || !(IChooser        = (struct ChooserIFace*)        GetInterface(ChooserBase,        "main", 1, 0))
     || !(IClickTab       = (struct ClickTabIFace*)       GetInterface(ClickTabBase,       "main", 1, 0))
     || !(IFuelGauge      = (struct FuelGaugeIFace*)      GetInterface(FuelGaugeBase,      "main", 1, 0))
     || !(IGetColor       = (struct GetColorIFace*)       GetInterface(GetColorBase,       "main", 1, 0))
     || !(IGradientSlider = (struct GradientSliderIFace*) GetInterface(GradientSliderBase, "main", 1, 0))
     || !(IInteger        = (struct IntegerIFace*)        GetInterface(IntegerBase,        "main", 1, 0))
     || !(ILabel          = (struct LabelIFace*)          GetInterface(LabelBase,          "main", 1, 0))
     || !(ILayout         = (struct LayoutIFace*)         GetInterface(LayoutBase,         "main", 1, 0))
     || !(IListBrowser    = (struct ListBrowserIFace*)    GetInterface(ListBrowserBase,    "main", 1, 0))
     || !(IPalette        = (struct PaletteIFace*)        GetInterface(PaletteBase,        "main", 1, 0))
     || !(IRadioButton    = (struct RadioButtonIFace*)    GetInterface(RadioButtonBase,    "main", 1, 0))
     || !(IRequester      = (struct RequesterIFace*)      GetInterface(RequesterBase,      "main", 1, 0))
     || !(IScroller       = (struct ScrollerIFace*)       GetInterface(ScrollerBase,       "main", 1, 0))
     || !(ISlider         = (struct SliderIFace*)         GetInterface(SliderBase,         "main", 1, 0))
     || !(ISpace          = (struct SpaceIFace*)          GetInterface(SpaceBase,          "main", 1, 0))
     || !(ISpeedBar       = (struct SpeedBarIFace*)       GetInterface(SpeedBarBase,       "main", 1, 0))
     || !(IString         = (struct StringIFace*)         GetInterface(StringBase,         "main", 1, 0))
     || !(ITextEditor     = (struct TextEditorIFace*)     GetInterface(TextFieldBase,      "main", 1, 0))
     || !(IVirtual        = (struct VirtualIFace*)        GetInterface(VirtualBase,        "main", 1, 0))
     || !(IWindow         = (struct WindowIFace*)         GetInterface(WindowBase,         "main", 1, 0))
    )
    {   DISCARD Printf("MCE: Can't get library interface(s)!\n");
        cleanexit(EXIT_FAILURE);
    }

    if
    (   SketchBoardBase
     && !(ISketchBoard    = (struct SketchBoardIFace*)    GetInterface(SketchBoardBase,    "main", 1, 0))
    )
    {   DISCARD Printf("MCE: Can't get sketchboard.gadget interface!\n");
        cleanexit(EXIT_FAILURE);
    }
#else // boingball.image does not exist on OS4
    BoingBallBase = OpenLibrary("images/boingball.image", 47); // older versions don't work at all
#endif

    ProgLock = GetProgramDir(); // never unlock this!

    if ((TheHandle = (BPTR) Open("PROGDIR:MCE.config", MODE_OLDFILE)))
    {   if
        (   Read(TheHandle, IOBuffer, CONFIGLENGTH) == CONFIGLENGTH
         && IOBuffer[0]                             == CONFIGMAGIC
         && IOBuffer[1]                             == CONFIGVERSION
        )
        {   custompointer = IOBuffer[2] ? TRUE : FALSE;
            showtoolbar   = IOBuffer[3] ? TRUE : FALSE;
        }
        DISCARD Close(TheHandle);
        // TheHandle = ZERO;
    }

    if (argc) // started from CLI
    {   if (!(ArgsPtr = (struct RDArgs*) ReadArgs
        (    "FUNCTION/N," \
            "PUBSCREEN/K," \
        "SCREENWIDTH/K/N," \
       "SCREENHEIGHT/K/N," \
                 "TEST/S," \
                  "FILE", // if you use /F, you get lumbered with trailing spaces, etc.
            (LONG*) args,
            NULL
        )))
        {   DISCARD Printf
            (   "Usage: %s " \
                "[[FUNCTION] <function>] " \
                "[PUBSCREEN <screen>] " \
                "[SCREENWIDTH <width>] " \
                "[SCREENHEIGHT <height>] " \
                "[[FILE] <filename>]\n",
                argv[0]
            );
            cleanexit(EXIT_FAILURE);
        }

        if (args[0])
        {   number = (SLONG) (*((SLONG*) args[0]));
            if (number >= 1 && number <= FUNCTIONS)
            {   closer = function = page = number;
                functab = funcinfo[function].itemnum - IN_PAGE1;
            } else
            {   DISCARD Printf("%s: <function> must be 1-%ld!\n", argv[0], FUNCTIONS);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[1])
        {   strcpy(screenname, (STRPTR) args[1]);
            specifiedscreen = TRUE;
        }
        if (args[2])
        {   number = (SLONG) (*((SLONG*) args[2]));
            if (number >= 1 && number <= 32767)
            {   screenwidth = (SWORD) number;
            } else
            {   DISCARD Printf("%s: Illegal number for SCREENWIDTH!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[3])
        {   number = (SLONG) (*((SLONG*) args[3]));
            if (number >= 1 && number <= 32767)
            {   screenheight = (SWORD) number;
            } else
            {   DISCARD Printf("%s: Illegal number for SCREENHEIGHT!\n", argv[0]);
                cleanexit(EXIT_FAILURE);
        }   }
        if (args[4])
        {   strcpy(pathname, "PROGDIR:Examples/");
            strcat(pathname, funcinfo[function].example); // depends on function already being set correctly
            cliname = TRUE;
            zstrncpy(asldir, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        }
        if (args[5])
        {   strcpy(pathname, (STRPTR) args[5]);
            cliname = TRUE;
            zstrncpy(asldir, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
    }   }
    else // started from WB
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
    if ((ScreenPtr = LockPubScreen(screenname)))
    {

#ifdef VERBOSE
        printf("Found \"%s\" screen\n", screenname);
#endif

        UnlockPubScreen(NULL, ScreenPtr);
        ScreenPtr = NULL;
    } else
    {   ScreenPtr = LockPubScreen(NULL); // or perhaps we should use "Workbench"
        wbwidth  = ScreenPtr->Width;
        wbheight = ScreenPtr->Height;
        UnlockPubScreen(NULL, ScreenPtr);
        ScreenPtr = NULL;

        newwidth  = (screenwidth  > wbwidth ) ? screenwidth  : wbwidth;
        newheight = (screenheight > wbheight) ? screenheight : wbheight;

#ifdef VERBOSE
        printf("Screen size: %d,%d\n", screenwidth, screenheight);
        printf("Workbench size: %d,%d\n", wbwidth, wbheight);
        printf("Opening \"%s\" screen of size %d,%d\n", screenname, newwidth, newheight);
#endif

        CustomScreenPtr = OpenScreenTags
        (   NULL,
            SA_LikeWorkbench, TRUE,
            SA_AutoScroll,    TRUE,
            SA_Width,         newwidth,
            SA_Height,        newheight,
            SA_PubName,       screenname,
        TAG_DONE);
        if (!CustomScreenPtr)
        {   rq("Can't open screen!");
        }
        PubScreenStatus(CustomScreenPtr, 0);
    }
    lockscreen();
    ScreenToFront(ScreenPtr);
    unlockscreen();

#ifdef __amigaos4__
    if (GetVar("MenuImageSize", envbuffer, 13 + 1, 0) != -1)
    {   menuimagesize = atol(envbuffer);
        if (menuimagesize == 0)
        {   os4menus = FALSE;
    }   }
#endif

    if (function == FUNC_MENU || os4menus)
    {   load_fimages(TRUE);
    }

#ifdef __amigaos4__
    if
    (   (ApplicationBase = OpenLibrary("application.library", OS_ANY))
     && (IApplication    = (struct ApplicationIFace*)
                           GetInterface(ApplicationBase, "application", 2, 0))
    )
    {   AppID = RegisterApplication
        (   "MCE",
            REGAPP_Description,       "Saved game editor",
            REGAPP_URLIdentifier,     "amigan.1emu.net",
            REGAPP_AllowsBlanker,     TRUE,
            REGAPP_HasIconifyFeature, TRUE,
        TAG_DONE);
        GetApplicationAttrs(AppID, APPATTR_Port, &AppLibPort, TAG_END);
        AppLibSignal = 1 << AppLibPort->mp_SigBit;
    }
#endif

    // RKM Libraries, p. 59-61:
    lockscreen();
    if (GetVPModeID(&(ScreenPtr->ViewPort)) == INVALID_ID)
    {   rq("Invalid default public screen mode ID!");
    }
    if (!(VisualInfoPtr = (struct VisualInfo*) GetVisualInfo(ScreenPtr, TAG_DONE)))
    {   rq("Can't get GadTools visual info!");
    }
    DrawInfoPtr = (struct DrawInfo*) GetScreenDrawInfo(ScreenPtr);
    propfontx = DrawInfoPtr->dri_Font->tf_XSize;
    propfonty = DrawInfoPtr->dri_Font->tf_YSize;
    whitepen = FindColor
    (   ScreenPtr->ViewPort.ColorMap,
        0xFFFFFFFF,
        0xFFFFFFFF,
        0xFFFFFFFF,
        -1
    );
    unlockscreen();

#ifdef __amigaos4__
    if (os4menus)
    {   MenuPtr = (struct Menu*)
        MStrip,
            MA_EmbeddedKey,      FALSE,
            MA_FreeImage,        FALSE,
            MA_AddChild,         MTitle("Project"                            ), MA_ID, FULLMENUNUM(MN_PROJECT, NOITEM,      NOSUB         ) + 1,
                MA_AddChild,     MItem( "Open..."                            ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_OPEN,     NOSUB         ) + 1, MA_Key, "O", MA_Image, menuimage[0], MEnd,
                MA_AddChild,     MItem( "Revert"                             ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_REVERT,   NOSUB         ) + 1, MA_Key, "R", MA_Image, menuimage[1], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Save"                               ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_SAVE,     NOSUB         ) + 1, MA_Key, "S", MA_Image, menuimage[2], MEnd,
                MA_AddChild,     MItem( "Save as..."                         ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,   NOSUB         ) + 1, MA_Key, "A", MA_Image, menuimage[3], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Iconify"                            ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_ICONIFY,  NOSUB         ) + 1, MA_Key, "I", MA_Image, menuimage[4], MEnd,
                MA_AddChild,     MItem( "Quit MCE"                           ), MA_ID, FULLMENUNUM(MN_PROJECT, IN_QUIT,     NOSUB         ) + 1, MA_Key, "Q", MA_Image, menuimage[5], MEnd,
            MEnd,
            MA_AddChild,         MTitle("View"                               ), MA_ID, FULLMENUNUM(MN_VIEW,    NOITEM,      NOSUB         ) + 1,
                MA_AddChild,     MItem( "Custom mouse pointer?"              ), MA_ID, FULLMENUNUM(MN_VIEW,    IN_POINTER,  NOSUB         ) + 1, MA_Key, "P",                         MA_Toggle, TRUE, MEnd,
                MA_AddChild,     MItem( "Toolbar?"                           ), MA_ID, FULLMENUNUM(MN_VIEW,    IN_TOOLBAR,  NOSUB         ) + 1, MA_Key, "H", MA_Image, menuimage[9], MA_Toggle, TRUE, MEnd,
            MEnd,
            MA_AddChild,         MTitle("Tools"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   NOITEM,      NOSUB         ) + 1,
                MA_AddChild,     MItem( "Main Menu"                          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_MAINMENU, NOSUB         ) + 1,                                      MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "A-C"                                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    NOSUB         ) + 1,
                    MA_AddChild, MItem( "Arazok's Tomb"                      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_ARAZOK     ) + 1, MA_Key, "1",                         MEnd,
                    MA_AddChild, MItem( "Barbarian 2 (Psygnosis) & Obliterator"),MA_ID,FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_PSYGNOSIS  ) + 1, MA_Key, "2",                         MEnd,
                    MA_AddChild, MItem( "Bard's Tale 1-3 & Construction Set" ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_BT         ) + 1, MA_Key, "3",                         MEnd,
                    MA_AddChild, MItem( "BattleTech"                         ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_BA         ) + 1, MA_Key, "4",                         MEnd,
                    MA_AddChild, MItem( "Bloodwych & Extended Levels"        ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_BW         ) + 1, MA_Key, "5",                         MEnd,
                    MA_AddChild, MItem( "Bomb Jack 1"                        ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_BOMBJACK   ) + 1, MA_Key, "6",                         MEnd,
                    MA_AddChild, MItem( "Buck Rogers"                        ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_BUCK       ) + 1, MA_Key, "7",                         MEnd,
                    MA_AddChild, MItem( "California 1 & 2/Winter/World Games"), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_EPYX       ) + 1, MA_Key, "8",                         MEnd,
                    MA_AddChild, MItem( "Cannon Fodder 1 & 2"                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_CF         ) + 1, MA_Key, "9",                         MEnd,
                    MA_AddChild, MItem( "Chambers of Shaolin"                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_COS        ) + 1, MA_Key, "0",                         MEnd,
                    MA_AddChild, MItem( "Champions of Krynn 1-3"             ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_COK        ) + 1, MA_Key, "-",                         MEnd,
                    MA_AddChild, MItem( "Citadel of Vras"                    ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_COV        ) + 1, MA_Key, "=",                         MEnd,
                    MA_AddChild, MItem( "Computer Scrabble Deluxe"           ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_CSD        ) + 1, MA_Key, "\\",                        MEnd,
                    MA_AddChild, MItem( "Conflict Europe"                    ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE1,    SN_CE         ) + 1,                                      MEnd,
                MEnd,
                MA_AddChild,     MItem( "D-Gre"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    NOSUB         ) + 1, 
                    MA_AddChild, MItem( "Dark Castle & Beyond Dark Castle"   ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_DC         ) + 1, MA_Key, "!",                         MEnd,
                    MA_AddChild, MItem( "Deja Vu 1 & 2/Shadowgate/Uninvited" ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_ICOM       ) + 1, MA_Key, "\"",                        MEnd,
                    MA_AddChild, MItem( "Demon's Winter"                     ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_DW         ) + 1, MA_Key, "#",                         MEnd,
                    MA_AddChild, MItem( "Dragon Wars"                        ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_DRA        ) + 1, MA_Key, "$",                         MEnd,
                    MA_AddChild, MItem( "Druid 2"                            ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_DRUID2     ) + 1, MA_Key, "%",                         MEnd,
                    MA_AddChild, MItem( "Dungeon Master 1-2 & Chaos Strikes Back"),MA_ID,FULLMENUNUM(MN_TOOLS, IN_PAGE2,    SN_DM         ) + 1, MA_Key, "^",                         MEnd,
                    MA_AddChild, MItem( "Eye of the Beholder 1 & 2"          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_EOB        ) + 1, MA_Key, "&",                         MEnd,
                    MA_AddChild, MItem( "F/A-18 Interceptor"                 ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_FA18       ) + 1, MA_Key, "*",                         MEnd,
                    MA_AddChild, MItem( "Faery Tale Adventure"               ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_FTA        ) + 1, MA_Key, "(",                         MEnd,
                    MA_AddChild, MItem( "Firepower & Turbo"                  ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_SS         ) + 1, MA_Key, ")",                         MEnd,
                    MA_AddChild, MItem( "Garrison 1 & 2"                     ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_GARRISON   ) + 1, MA_Key, "_",                         MEnd,
                    MA_AddChild, MItem( "Goal!"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_GOAL       ) + 1, MA_Key, "+",                         MEnd,
                    MA_AddChild, MItem( "Grand Monster Slam"                 ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_GMS        ) + 1, MA_Key, "|",                         MEnd,
                    MA_AddChild, MItem( "Great Giana Sisters/Hard 'n' Heavy" ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE2,    SN_GIANA      ) + 1,                                      MEnd,
                MEnd,
                MA_AddChild,     MItem( "Gri-M"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    NOSUB         ) + 1,
                    MA_AddChild, MItem( "GridStart 1-3"                      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_GRIDSTART  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "HackLite/Larn/Moria/Rogue"          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_ROGUE      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Heroes of the Lance & Dragons of Flame"),MA_ID,FULLMENUNUM(MN_TOOLS,  IN_PAGE3,    SN_HOL        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Hillsfar"                           ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_HILLSFAR   ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Impossible Mission 2"               ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_IM2        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Insanity Fight"                     ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_IF         ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "It Came from the Desert 1 & 2"      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_ICFTD      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Keef the Thief"                     ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_KEEF       ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "King's Quest 1-3 & Space Quest 1"   ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_KQ         ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Last Ninja Remix"                   ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_LASTNINJA  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Legend of Faerghail"                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_LOF        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Legend of Lothian"                  ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_LOL        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Mercenary"                          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_MERCENARY  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Might & Magic 2 & 3"                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_MM         ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Mindshadow/Borrowed Time/Tass Times"), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE3,    SN_MM         ) + 1,                                      MEnd,
                MEnd,
                MA_AddChild,     MItem( "N-Roc"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    NOSUB         ) + 1,
                    MA_AddChild, MItem( "Neuromancer"                        ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_NEUROMANCER) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Nitro"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_NITRO      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Oo-Topos & Transylvania 1 & 2"      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_POLARWARE  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Panza Kickboxing 1 & 2"             ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_PANZA      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Phantasie 1 & 3"                    ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_PHANTASIE  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Pinball Dreams/Fantasies/Illusions" ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_PINBALL    ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Pirates! & Pirates! Gold"           ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_PIRATES    ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Pool of Radiance 1-4"               ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_POR        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Quadralien"                         ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_QUADRALIEN ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Questron 2"                         ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_Q2         ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Ragnarok"                           ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_RAGNAROK   ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Return of the Jedi"                 ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_ROTJ       ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Robin Hood & Rome: AD92"            ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_ROBIN      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Rockford"                           ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE4,    SN_ROCKFORD   ) + 1,                                      MEnd,
                MEnd,
                MA_AddChild,     MItem( "Ror-Z"                              ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    NOSUB         ) + 1,
                    MA_AddChild, MItem( "Rorke's Drift"                      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_RORKE      ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Shadowlands & Shadoworlds"          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SHADOW     ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "SideWinder 1 & 2"                   ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SIDEWINDER ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Sinbad and the Throne of the Falcon"), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SINBAD     ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Slaygon"                            ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SLAYGON    ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Speedball 1 & 2"                    ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SPEEDBALL  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Syndicate"                          ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_SYNDICATE  ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Temple of Apshai"                   ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_TOA        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Times of Lore"                      ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_TOL        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "TV Sports Base/Basket/Football"     ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_TVS        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Ultima 3-6"                         ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_ULTIMA     ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "War in Middle Earth"                ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_WIME       ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Wizardry 6"                         ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_WIZ        ) + 1,                                      MEnd,
                    MA_AddChild, MItem( "Zerg"                               ), MA_ID, FULLMENUNUM(MN_TOOLS,   IN_PAGE5,    SN_ZERG       ) + 1,                                      MEnd,
                MEnd,
            MEnd,
            MA_AddChild,         MTitle("Help"                               ), MA_ID, FULLMENUNUM(MN_HELP,    NOITEM,      NOSUB         ) + 1,
                MA_AddChild,     MItem( "File formats..."                    ), MA_ID, FULLMENUNUM(MN_HELP,    IN_FORMATS,  NOSUB         ) + 1,                                      MEnd,
                MA_AddChild,     MItem( "Manual..."                          ), MA_ID, FULLMENUNUM(MN_HELP,    IN_MANUAL,   NOSUB         ) + 1, MA_Key, "M", MA_Image, menuimage[6], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "Check for updates..."               ), MA_ID, FULLMENUNUM(MN_HELP,    IN_UPDATE,   NOSUB         ) + 1, MA_Key, "U", MA_Image, menuimage[8], MEnd,
                AddSeparator,
                MA_AddChild,     MItem( "About ReAction..."                  ), MA_ID, FULLMENUNUM(MN_HELP,    IN_REACTION, NOSUB         ) + 1,                                      MEnd,
                MA_AddChild,     MItem( "About MCE..."                       ), MA_ID, FULLMENUNUM(MN_HELP,    IN_ABOUT,    NOSUB         ) + 1, MA_Key, "?", MA_Image, menuimage[7], MEnd,
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

    if (!(AppPort = (struct MsgPort*) CreateMsgPort()))
    {   rq("CreateMsgPort() failed!");
    }

    guideexists = Exists("PROGDIR:MCE.guide");

    for (;;)
    {   function = page;

     /* It uses its normal icon for iconification.
        We could instead use a different icon if desired.

        We would probably be better to get the name of the icon from
        argv[0] (when started from CLI) or the WBStartup message (when
        started from Workbench), rather than hardcoded
        "PROGDIR:MCE" (".info" is automatically appended).

        ReAction frees the icon automatically when the window is
        closed (unfortunately). */

        if (CustomScreenPtr)
        {   IconifiedIcon = NULL;
        } else
        {   IconifiedIcon = (struct DiskObject*) GetDiskObjectNew("PROGDIR:MCE");
        }

        wasrun[page] = TRUE;
        switch (page)
        {
        case  FUNC_MENU:        menu();
        acase FUNC_ARAZOK:      arazok_main();
        acase FUNC_PSYGNOSIS:   psyg_main();
        acase FUNC_BT:          bt_main();
        acase FUNC_BATTLETECH:  ba_main();
        acase FUNC_BW:          bw_main();
        acase FUNC_BOMBJACK:    bj_main();
        acase FUNC_BUCK:        buck_main();
        acase FUNC_EPYX:        epyx_main();
        acase FUNC_CF:          cf_main();
        acase FUNC_COS:         cos_main();
        acase FUNC_COK:         cok_main();
        acase FUNC_COV:         cov_main();
        acase FUNC_CSD:         csd_main();
        acase FUNC_CE:          ce_main();
        acase FUNC_DC:          dc_main();
        acase FUNC_ICOM:        icom_main();
        acase FUNC_DW:          dw_main();
        acase FUNC_DRA:         dra_main();
        acase FUNC_DRUID2:      druid2_main();
        acase FUNC_DM:          dm_main();
        acase FUNC_EOB:         eob_main();
        acase FUNC_FA18:        fa18_main();
        acase FUNC_FTA:         fta_main();
        acase FUNC_SS:          ss_main();
        acase FUNC_GARRISON:    gar_main();
        acase FUNC_GOAL:        goal_main();
        acase FUNC_GMS:         gms_main();
        acase FUNC_GIANA:       giana_main();
        acase FUNC_GRIDSTART:   gs_main();
        acase FUNC_ROGUE:       rogue_main();
        acase FUNC_HOL:         hol_main();
        acase FUNC_HILLSFAR:    hf_main();
        acase FUNC_IM2:         im2_main();
        acase FUNC_IF:          if_main();
        acase FUNC_ICFTD:       icftd_main();
        acase FUNC_KEEF:        keef_main();
        acase FUNC_KQ:          kq_main();
        acase FUNC_LASTNINJA:   ln_main();
        acase FUNC_LOF:         lof_main();
        acase FUNC_LOL:         lol_main();
        acase FUNC_MERCENARY:   merc_main();
        acase FUNC_MM:          mm_main();
        acase FUNC_INTERPLAY:   interplay_main();
        acase FUNC_NEUROMANCER: nm_main();
        acase FUNC_NITRO:       nitro_main();
        acase FUNC_POLARWARE:   polar_main();
        acase FUNC_PANZA:       panza_main();
        acase FUNC_PHANTASIE:   ph_main();
        acase FUNC_PINBALL:     pin_main();
        acase FUNC_PIRATES:     pir_main();
        acase FUNC_POR:         por_main();
        acase FUNC_QUADRALIEN:  qa_main();
        acase FUNC_Q2:          q2_main();
        acase FUNC_RAGNAROK:    lor_main();
        acase FUNC_ROTJ:        rotj_main();
        acase FUNC_ROBIN:       robin_main();
        acase FUNC_ROCKFORD:    rf_main();
        acase FUNC_RORKE:       rorke_main();
        acase FUNC_SHADOW:      shadow_main();
        acase FUNC_SIDEWINDER:  sw_main();
        acase FUNC_SINBAD:      sb_main();
        acase FUNC_SLAYGON:     sla_main();
        acase FUNC_SPEEDBALL:   speedb_main();
        acase FUNC_SYNDICATE:   syn_main();
        acase FUNC_TOA:         toa_main();
        acase FUNC_TOL:         tol_main();
        acase FUNC_TVS:         tvs_main();
        acase FUNC_ULTIMA:      ultima_main();
        acase FUNC_WIME:        wime_main();
        acase FUNC_WIZ:         wiz_main();
        acase FUNC_ZERG:        zerg_main();
}   }   }

EXPORT void load_images(int thefirst, int thelast)
{   int  i;
    TEXT theimagename[MAX_PATH + 1];

    for (i = thefirst; i <= thelast; i++)
    {   if (!image[i])
        {   goto DONE;
    }   }
    return;

DONE:
    SetAttrs(WinObject, WA_BusyPointer, TRUE, TAG_END);
    lockscreen();

    for (i = thefirst; i <= thelast; i++)
    {   if (!image[i])
        {   strcpy(theimagename, "PROGDIR:images/");
            strcat(theimagename, imagename[i].pathname);
            strcat(theimagename, ".iff");

#ifdef VERBOSE
            printf("Loading image \"%s\"...\n", theimagename);
#endif

            if (!(image[i] = (struct Image*)
            BitMapObject,
                BITMAP_SourceFile, theimagename,
                BITMAP_Screen,     ScreenPtr,
                BITMAP_Masking,    imagename[i].transparent ? TRUE : FALSE,
                // BITMAP_Transparent isn't necessary (as they are always IFF ILBMs)
            End))
            {   rq("Can't create image(s)!");
    }   }   }

    unlockscreen();
    SetAttrs(WinObject, WA_BusyPointer, FALSE, TAG_END);
}

MODULE void menu(void)
{   struct Hook Hook0Struct;
    LONG        bgpen;

    tool_open      = NULL;
    tool_save      = NULL;
    tool_close     = NULL;
    tool_exit      = NULL;
    tool_subgadget = NULL;
    tool_loop      = menu_loop;

    InitHook(&Hook0Struct, (ULONG (*)()) Hook0Func, NULL);

    if (!loaded_fimages)
    {   load_fimages(FALSE);
    }

    lockscreen();
    bgpen = FindColor
    (   ScreenPtr->ViewPort.ColorMap,
        0x96969696,
        0x96969696,
        0x96969696,
        -1
    );
    if (!(WinObject =
    WindowObject,
        WA_PubScreen,                                ScreenPtr,
        WA_ScreenTitle,                              TITLEBARTEXT,
        WA_Title,                                    "MCE: Main Menu",
        IconifiedIcon ? WINDOW_Icon : TAG_IGNORE,    IconifiedIcon,
        WA_Activate,                                 TRUE,
        WA_DepthGadget,                              TRUE,
        WA_DragBar,                                  TRUE,
        WA_CloseGadget,                              TRUE,
        WA_IDCMP,                                    IDCMP_RAWKEY | IDCMP_INTUITICKS,
        WINDOW_IDCMPHook,                            &Hook0Struct,
        WINDOW_IDCMPHookBits,                        IDCMP_RAWKEY | IDCMP_INTUITICKS,
        WINDOW_MenuStrip,                            MenuPtr,
        WINDOW_Position,                             WPOS_CENTERSCREEN,
        WINDOW_IconifyGadget,                        CustomScreenPtr ? FALSE : TRUE,
        WINDOW_IconTitle,                            "MCE",
        WINDOW_AppPort,                              AppPort,
     // WINDOW_AppWindow,                            TRUE, // not needed as main menu doesn't support loading files
        WINDOW_PopupGadget,                          TRUE, // for OS4 users
        WINDOW_JumpScreensMenu,                      TRUE, // for OS4 users
        WINDOW_ParentGroup,                          gadgets[GID_0_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                       TRUE,
            LAYOUT_AddChild,                         gadgets[GID_0_CT1] = (struct Gadget*)
            ClickTabObject,
                GA_ID,                               GID_0_CT1,
                GA_RelVerify,                        TRUE,
                GA_Text,                             PageOptions,
                CLICKTAB_PageGroup,                  gadgets[GID_0_PA1] = (struct Gadget*)
                PageObject,
                    LAYOUT_DeferLayout,              TRUE,
                    PAGE_Current,                    functab,
                    PAGE_Add,
                    VLayoutObject, // Zerg :-)
                        LAYOUT_SpaceOuter,           TRUE,
                        LAYOUT_DeferLayout,          TRUE,
                        ThreeRow( 0),
                        FourRow(  3),
                        FourRow(  7),
                        ThreeRow(11),
                    LayoutEnd,
                    PAGE_Add,
                    VLayoutObject,
                        LAYOUT_SpaceOuter,           TRUE,
                        LAYOUT_DeferLayout,          TRUE,
                        ThreeRow(14),
                        FourRow( 17),
                        FourRow( 21),
                        ThreeRow(25),
                    LayoutEnd,
                    PAGE_Add,
                    VLayoutObject,
                        LAYOUT_SpaceOuter,           TRUE,
                        LAYOUT_DeferLayout,          TRUE,
                        FourRow( 28),
                        FourRow( 32),
                        FourRow( 36),
                        ThreeRow(40),
                    LayoutEnd,
                    PAGE_Add,
                    VLayoutObject,
                        LAYOUT_SpaceOuter,           TRUE,
                        LAYOUT_DeferLayout,          TRUE,
                        ThreeRow(43),
                        FourRow( 46),
                        FourRow( 50),
                        ThreeRow(54),
                    LayoutEnd,
                    PAGE_Add,
                    VLayoutObject,
                        LAYOUT_SpaceOuter,           TRUE,
                        LAYOUT_DeferLayout,          TRUE,
                        ThreeRow(57),
                        FourRow( 60),
                        FourRow( 64),
                        ThreeRow(68),
                    LayoutEnd,
                    ICA_MAP,                         PAtoCTmap,
                PageEnd,
                CLICKTAB_Current,                    functab,
                ICA_MAP,                             CTtoPAmap,
            ClickTabEnd,
            LAYOUT_AddChild,                         gadgets[GID_0_ST1] = (struct Gadget*)
            StringObject,
                GA_ID,                               GID_0_ST1,
                GA_ReadOnly,                         TRUE,
                STRINGA_TextVal,                     funcinfo[FUNC_MENU].longname,
            StringEnd,
            CHILD_WeightedHeight,                    0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();

    openwindow(-1);
    loop();
    closewindow();
}

EXPORT void cleanexit(SBYTE rc)
{   ULONG           i;
    BPTR            TheHandle /* = ZERO */ ;
    struct Message* MsgPtr;

    // ASL requesters are assumed to be already closed.

#ifdef TRACKEXIT
    DISCARD Printf("1!\n"); Delay(TRACKDELAY);
#endif

    if (AboutWindowPtr)
    {   DisposeObject(AboutWinObject);
        AboutWinObject  = NULL;
        AboutWindowPtr  = NULL;
    }
    if (SplashWinObject)
    {   DisposeObject(SplashWinObject);
        SplashWinObject = NULL;
        SplashWindowPtr = NULL;
    }
    if (SubWinObject)
    {   DisposeObject(SubWinObject);
        SubWinObject    = NULL;
        SubWindowPtr    = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("2!\n"); Delay(TRACKDELAY);
#endif

    unlockscreen(); // in case the screen is locked
#ifdef TRACKEXIT
    DISCARD Printf("2.1!\n"); Delay(TRACKDELAY);
#endif
    closewindow();

#ifdef TRACKEXIT
    DISCARD Printf("3!\n"); Delay(TRACKDELAY);
#endif

    /* This is necessary because if there is a failure between
       creating the window object and opening the window
       (ie. if the window is not open), closewindow() will not
       dispose of the object.

       Allocating the window object seems to lose about 16K which
       we are unable to recover.
         If you know why, please tell us! */

    if (WinObject)
    {   DisposeObject(WinObject);
        WinObject     = NULL;
        MainWindowPtr = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("4!\n"); Delay(TRACKDELAY);
#endif

    sb_clearlist(&SpeedBarList);
    sb_clearlist(&CommandBarList);
    sb_clearlist(&PaintBarList);

    if (!os4menus && MenuPtr)
    {   FreeMenus(MenuPtr);
        MenuPtr = NULL;
    }
    if (VisualInfoPtr)
    {   FreeVisualInfo(VisualInfoPtr);
        VisualInfoPtr = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("5!\n"); Delay(TRACKDELAY);
#endif

    if (wasrun[FUNC_BT         ]) bt_die();
    if (wasrun[FUNC_BW         ]) bw_die();
    if (wasrun[FUNC_CF         ]) cf_die();
    if (wasrun[FUNC_COK        ]) cok_die();
    if (wasrun[FUNC_COV        ]) cov_die();
    if (wasrun[FUNC_DW         ]) dw_die();
    if (wasrun[FUNC_DRA        ]) dra_die();
    if (wasrun[FUNC_LOF        ]) lof_die();
    if (wasrun[FUNC_MERCENARY  ]) merc_die();
    if (wasrun[FUNC_MM         ]) mm_die();
    if (wasrun[FUNC_NEUROMANCER]) nm_die();
    if (wasrun[FUNC_PHANTASIE  ]) ph_die();
    if (wasrun[FUNC_POR        ]) por_die();
    if (wasrun[FUNC_Q2         ]) q2_die();
    if (wasrun[FUNC_SINBAD     ]) sb_die();
    if (wasrun[FUNC_SYNDICATE  ]) syn_die();
    if (wasrun[FUNC_ULTIMA     ]) ultima_die();

#ifdef TRACKEXIT
    DISCARD Printf("6!\n"); Delay(TRACKDELAY);
#endif

    if (ArgsPtr)
    {   FreeArgs(ArgsPtr);
        ArgsPtr = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("7!\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (os4menus && MenuPtr)
    {   DisposeObject((Object*) MenuPtr);
        MenuPtr = NULL;
    }
#endif

    // Dispose the images ourselves as button.gadget doesn't
    // do this for its GA_Image (although LAYOUT_AddImage does)...

    for (i = 0; i < BITMAPS; i++)
    {   if (image[i])
        {   DisposeObject((Object*) image[i]);
            image[i] = NULL;
    }   }

#ifdef TRACKEXIT
    DISCARD Printf("8!\n"); Delay(TRACKDELAY);
#endif
    for (i = 0; i <= FUNCTIONS; i++)
    {   if (fimage[i])
        {   DisposeObject((Object*) fimage[i]);
            fimage[i] = NULL;
        }
        if (menufimage[i])
        {   DisposeObject((Object*) menufimage[i]);
            menufimage[i] = NULL;
    }   }
#ifdef __amigaos4__
    for (i = 0; i < OS4IMAGES; i++)
    {   if (menuimage[i])
        {   DisposeObject((Object*) menuimage[i]);
            menuimage[i] = NULL;
    }   }
#endif
#ifdef TRACKEXIT
    DISCARD Printf("9!\n"); Delay(TRACKDELAY);
#endif
    for (i = 0; i < AISSIMAGES; i++)
    {   if (aissimage[i])
        {   DisposeObject((Object*) aissimage[i]);
            aissimage[i] = NULL;
    }   }

#ifdef TRACKEXIT
    DISCARD Printf("10!\n"); Delay(TRACKDELAY);
#endif

    // Don't close this screen until all imagery has been disposed (eg. speedbar imagery)!
    if (CustomScreenPtr)
    {   PubScreenStatus(CustomScreenPtr, PSNF_PRIVATE);
        CloseScreen(CustomScreenPtr);
        CustomScreenPtr = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("11!\n"); Delay(TRACKDELAY);
#endif

    if (rc == EXIT_SUCCESS)
    {   if ((TheHandle = (BPTR) Open("PROGDIR:MCE.config", MODE_NEWFILE)))
        {   IOBuffer[0] = CONFIGMAGIC;
            IOBuffer[1] = CONFIGVERSION;
            IOBuffer[2] = (UBYTE) custompointer;
            IOBuffer[3] = (UBYTE) showtoolbar;
            DISCARD Write(TheHandle, IOBuffer, CONFIGLENGTH);
            DISCARD Close(TheHandle);
            // TheHandle = ZERO;
    }   }

    if (AppPort)
    {   while ((MsgPtr = (struct Message*) GetMsg(AppPort)))
        {   ReplyMsg(MsgPtr);
        }
        // PatchWork says that there are still unreplied messages at
        // the AppPort, odd...
        DeleteMsgPort(AppPort);
        AppPort = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("12!\n"); Delay(TRACKDELAY);
#endif

#ifdef __amigaos4__
    if (IBitMap)         DropInterface((struct Interface*) IBitMap);
    if (IButton)         DropInterface((struct Interface*) IButton);
    if (ICheckBox)       DropInterface((struct Interface*) ICheckBox);
    if (IChooser)        DropInterface((struct Interface*) IChooser);
    if (IClickTab)       DropInterface((struct Interface*) IClickTab);
    if (IFuelGauge)      DropInterface((struct Interface*) IFuelGauge);
    if (IGetColor)       DropInterface((struct Interface*) IGetColor);
    if (IGradientSlider) DropInterface((struct Interface*) IGradientSlider);
    if (IInteger)        DropInterface((struct Interface*) IInteger);
    if (ILabel)          DropInterface((struct Interface*) ILabel);
    if (ILayout)         DropInterface((struct Interface*) ILayout);
    if (IListBrowser)    DropInterface((struct Interface*) IListBrowser);
    if (IPalette)        DropInterface((struct Interface*) IPalette);
    if (IRadioButton)    DropInterface((struct Interface*) IRadioButton);
    if (IRequester)      DropInterface((struct Interface*) IRequester);
    if (IScroller)       DropInterface((struct Interface*) IScroller);
    if (ISketchBoard)    DropInterface((struct Interface*) ISketchBoard);
    if (ISlider)         DropInterface((struct Interface*) ISlider);
    if (ISpace)          DropInterface((struct Interface*) ISpace);
    if (ISpeedBar)       DropInterface((struct Interface*) ISpeedBar);
    if (IString)         DropInterface((struct Interface*) IString);
    if (ITextEditor)     DropInterface((struct Interface*) ITextEditor);
    if (IVirtual)        DropInterface((struct Interface*) IVirtual);
    if (IWindow)         DropInterface((struct Interface*) IWindow);

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

    if (IAmigaGuide)     DropInterface((struct Interface*) IAmigaGuide);
    if (IAsl)            DropInterface((struct Interface*) IAsl       );
    if (IDataTypes)      DropInterface((struct Interface*) IDataTypes );
    if (IDiskfont)       DropInterface((struct Interface*) IDiskfont  );
    if (IGadTools)       DropInterface((struct Interface*) IGadTools  );
    if (IGraphics)       DropInterface((struct Interface*) IGraphics  );
    if (IIFFParse)       DropInterface((struct Interface*) IIFFParse  );
    if (IIcon)           DropInterface((struct Interface*) IIcon      );
    if (IIntuition)      DropInterface((struct Interface*) IIntuition );
    if (IOpenURL)        DropInterface((struct Interface*) IOpenURL   );
    if (IUtility)        DropInterface((struct Interface*) IUtility   );
    if (IWorkbench)      DropInterface((struct Interface*) IWorkbench );
#endif

#ifdef TRACKEXIT
    DISCARD Printf("13!\n"); Delay(TRACKDELAY);
#endif

    CloseLibrary(BitMapBase);
    CloseLibrary(BoingBallBase);
    CloseLibrary(ButtonBase);
    CloseLibrary(CheckBoxBase);
    CloseLibrary(ChooserBase);
    CloseLibrary(ClickTabBase);
#ifndef __MORPHOS__
    CloseLibrary((struct Library*) ClockBase);
#endif
    CloseLibrary(DatatypesBase);
    CloseLibrary(DiskfontBase);
    CloseLibrary(FuelGaugeBase);
    CloseLibrary(GetColorBase);
    CloseLibrary(GradientSliderBase);
    CloseLibrary(IntegerBase);
    CloseLibrary(LabelBase);
    CloseLibrary(LayoutBase);
    CloseLibrary(ListBrowserBase);
    CloseLibrary(PaletteBase);
    CloseLibrary(RadioButtonBase);
    CloseLibrary(RequesterBase);
    CloseLibrary(ScrollerBase);
    CloseLibrary(SketchBoardBase);
    CloseLibrary(SliderBase);
    CloseLibrary(SpaceBase);
    CloseLibrary(SpeedBarBase);
    CloseLibrary(StringBase);
    CloseLibrary(TextFieldBase);
    CloseLibrary(VirtualBase);
    CloseLibrary(WindowBase);

#ifdef TRACKEXIT
    DISCARD Printf("14!\n"); Delay(TRACKDELAY);
#endif

    CloseLibrary(AmigaGuideBase);
    CloseLibrary(AslBase);
    CloseLibrary(GadToolsBase);
    CloseLibrary((struct Library*) GfxBase);
    CloseLibrary(IconBase);
    CloseLibrary(IFFParseBase);
    CloseLibrary(OpenURLBase);
    CloseLibrary((struct Library*) UtilityBase);
    CloseLibrary(VersionBase);
    CloseLibrary(WorkbenchBase);

#ifdef TRACKEXIT
    DISCARD Printf("15!\n"); Delay(TRACKDELAY);
#endif

    if (IntuitionBase)
    {   DISCARD OpenWorkBench();
        CloseLibrary((struct Library*) IntuitionBase);
        // IntuitionBase = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("16!\n"); Delay(TRACKDELAY);
#endif

    exit(rc); // End of program.
}

EXPORT void clearkybd(void)
{   struct Message* MsgPtr;

    while ((MsgPtr = (struct Message*) GetMsg(MainWindowPtr->UserPort)))
    {   ReplyMsg(MsgPtr);
}   }

EXPORT void help_reaction(void)
{   UWORD                   code,
                            qual;
    ULONG                   result,
                            ReActionSignal,
                            value;
    FLAG                    done;
    int                     curgad               = -1,
                            i,
                            next                 = 0       ;
    Object*                 ReActionWinObject /* = NULL */ ;
    struct List             ReActionList;
    struct ListBrowserNode* ListBrowserNodePtr;
    struct Window*          ReActionWindowPtr /* = NULL */ ;
    struct Image*           boingimage           = NULL    ;
PERSIST const struct
{   const STRPTR name;
    const int    image;
} ReAction[] = {
{ "bitmap.image"      , IMAGE_BITMAP      }, //  0
#ifndef __amigaos4__
{ "boingball.image"   , IMAGE_UNAVAILABLE }, //  1
#endif
{         "button.gadget", IMAGE_BUTTON         },
{       "checkbox.gadget", IMAGE_CHECKBOX       },
{        "chooser.gadget", IMAGE_CHOOSER        },
{       "clicktab.gadget", IMAGE_CLICKTAB       },
{          "clock.gadget", IMAGE_CLOCK          },
{      "fuelgauge.gadget", IMAGE_FUELGAUGE      },
{       "getcolor.gadget", IMAGE_PALETTE        },
{ "gradientslider.gadget", IMAGE_GRADIENTSLIDER },
{        "integer.gadget", IMAGE_INTEGER        },
{          "label.image" , IMAGE_LABEL          },
{         "layout.gadget", IMAGE_LAYOUT         },
{    "listbrowser.gadget", IMAGE_LISTBROWSER    },
{        "palette.gadget", IMAGE_PALETTE        },
{    "radiobutton.gadget", IMAGE_RADIOBUTTON    },
{      "requester.class" , IMAGE_UNAVAILABLE    },
{       "scroller.gadget", IMAGE_SCROLLER       },
{    "sketchboard.gadget", IMAGE_SKETCHBOARD    },
{         "slider.gadget", IMAGE_SLIDER         },
{          "space.gadget", IMAGE_SPACE          },
{       "speedbar.gadget", IMAGE_SPEEDBAR       },
{         "string.gadget", IMAGE_STRING         },
{     "texteditor.gadget", IMAGE_TEXTEDITOR     },
{        "virtual.gadget", IMAGE_VIRTUAL        },
{         "window.class" , IMAGE_UNAVAILABLE    }, // 25 (or less)
};
PERSIST TEXT              ReActionVersions[25 + 1][11 + 1]; // enough for "12345.12345"
PERSIST struct ColumnInfo ReActionColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    "Class",           /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    "Version",
    CIF_FIXED
  },
  { -1,
    (STRPTR)~0,
    -1
} };

    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      BitMapBase->lib_Version, (int)      BitMapBase->lib_Revision);
#ifndef __amigaos4__
    if (BoingBallBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int)   BoingBallBase->lib_Version, (int)   BoingBallBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
#endif
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      ButtonBase->lib_Version, (int)      ButtonBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)    CheckBoxBase->lib_Version, (int)    CheckBoxBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)     ChooserBase->lib_Version, (int)     ChooserBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)    ClickTabBase->lib_Version, (int)    ClickTabBase->lib_Revision);
#ifndef __MORPHOS__
    if (ClockBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int)ClockBase->cl_Lib.lib_Version, (int)ClockBase->cl_Lib.lib_Revision);
    } else
#endif
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)   FuelGaugeBase->lib_Version, (int)   FuelGaugeBase->lib_Revision);
    if (GetColorBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int)    GetColorBase->lib_Version, (int)    GetColorBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",  (int) GradientSliderBase->lib_Version, (int) GradientSliderBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)     IntegerBase->lib_Version, (int)     IntegerBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)       LabelBase->lib_Version, (int)       LabelBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      LayoutBase->lib_Version, (int)      LayoutBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int) ListBrowserBase->lib_Version, (int) ListBrowserBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)     PaletteBase->lib_Version, (int)     PaletteBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int) RadioButtonBase->lib_Version, (int) RadioButtonBase->lib_Revision);
    if (RequesterBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int)   RequesterBase->lib_Version, (int)   RequesterBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)    ScrollerBase->lib_Version, (int)    ScrollerBase->lib_Revision);
    if (SketchBoardBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int) SketchBoardBase->lib_Version, (int) SketchBoardBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      SliderBase->lib_Version, (int)      SliderBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)       SpaceBase->lib_Version, (int)       SpaceBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)    SpeedBarBase->lib_Version, (int)    SpeedBarBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      StringBase->lib_Version, (int)      StringBase->lib_Revision);
#ifndef __MORPHOS__
    if (TextFieldBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d", (int)   TextFieldBase->lib_Version, (int)   TextFieldBase->lib_Revision);
    } else
#endif
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)     VirtualBase->lib_Version, (int)     VirtualBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",     (int)      WindowBase->lib_Version, (int)      WindowBase->lib_Revision);

    // we expect version  numbers to be <=  99, but theoretically they can be <= 32767
    // we expect revision numbers to be <= 999, but theoretically they can be <= 32767

    NewList(&ReActionList);
    for (i = 0; i < next; i++)
    {   if (!(ListBrowserNodePtr = (struct ListBrowserNode*) AllocListBrowserNode
        (   2,                       // columns
            /* LBNCA_#? tags are those that apply to the specific column. */
            LBNA_Column,             0,
            LBNCA_Text,              ReAction[i].name,
            LBNA_Column,             1,
            LBNCA_Text,              ReActionVersions[i],
        TAG_END)))
        {   FreeListBrowserList(&ReActionList);
            rq((STRPTR) "Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&ReActionList, (struct Node *) ListBrowserNodePtr); // AddTail() has no return code
    }
    ReActionColumnInfo[0].ci_Width = propfontx * (21 + 2);

    load_images(BITMAP_REACTION, BITMAP_REACTION);
    load_aiss_images(FIRSTGADGETIMAGE, LASTGADGETIMAGE);

    lockscreen();
    if (BoingBallBase)
    {   boingimage = (struct Image*) NewObject(NULL, "boingball.image", PENMAP_Screen, ScreenPtr, TAG_END);
    }
    if (!(ReActionWinObject =
    WindowObject,
        WA_PubScreen,                              ScreenPtr,
        WA_ScreenTitle,                            TITLEBARTEXT,
        WA_Title,                                  "About ReAction",
        WA_Activate,                               TRUE,
        WA_DepthGadget,                            TRUE,
        WA_DragBar,                                TRUE,
        WA_CloseGadget,                            TRUE,
        WA_IDCMP,                                  IDCMP_INTUITICKS,
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,
        HLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            LAYOUT_HorizAlignment,                 LALIGN_CENTER,
            LAYOUT_DeferLayout,                    TRUE,
            AddVLayout,
                AddLabel(""),
                AddHLayout,
                    AddSpace,
                    LAYOUT_AddImage,               aissimage[IMAGE_UNAVAILABLE],
                    CHILD_WeightedWidth,           0,
                    CHILD_NoDispose,               TRUE,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedHeight,              0,
                AddSpace,
                LAYOUT_AddImage,                   image[BITMAP_REACTION],
                CHILD_NoDispose,                   TRUE,
                CHILD_WeightedHeight,              0,
                AddSpace,
                AddHLayout,
                    AddSpace,
                    boingimage ? LAYOUT_AddImage     : TAG_IGNORE, boingimage,
                    boingimage ? CHILD_MinWidth      : TAG_IGNORE, 24,
                    boingimage ? CHILD_MinHeight     : TAG_IGNORE, 24,
                    boingimage ? CHILD_WeightedWidth : TAG_IGNORE, 0,
                    boingimage ? CHILD_NoDispose     : TAG_IGNORE, TRUE,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedHeight,              0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedWidth,                   0,
            AddVLayout,
                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                LAYOUT_VertAlignment,              LALIGN_CENTER,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_AddImage,
                LabelObject,
                    LABEL_SoftStyle,               FSF_BOLD,
                    LABEL_DrawInfo,                DrawInfoPtr,
                    LABEL_Text,                    "ReAction GUI",
                End,
                CHILD_WeightedHeight,              0,
                LAYOUT_AddChild,                   gadgets[GID_0_LB1] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                         GID_0_LB1,
                    GA_RelVerify,                  TRUE,
                    LISTBROWSER_ShowSelected,      TRUE,
                    LISTBROWSER_Labels,            &ReActionList,
                    LISTBROWSER_ColumnTitles,      TRUE,
                    LISTBROWSER_ColumnInfo,        (ULONG) &ReActionColumnInfo,
                    LISTBROWSER_MinVisible,        next,
                    LISTBROWSER_VerticalProp,      FALSE,
                ListBrowserEnd,
                CHILD_MinWidth,                    propfontx * (21 + 2 + 9),
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   unlockscreen();
        say("Can't create gadgets!", REQIMAGE_WARNING);
        goto ABORT;
    }
    unlockscreen();

    if (!(ReActionWindowPtr = (struct Window*) RA_OpenWindow(ReActionWinObject)))
    {   DisposeObject(ReActionWinObject);
        // ReActionWinObject = NULL;
        say("Can't open window!", REQIMAGE_WARNING);
        goto ABORT;
    }
    DISCARD GetAttr(WINDOW_SigMask, ReActionWinObject, &ReActionSignal);

    settitle(TRUE);

    for (i = FIRSTGADGETIMAGE + 1; i <= LASTGADGETIMAGE; i++)
    {   aissimage[i]->LeftEdge = aissimage[FIRSTGADGETIMAGE]->LeftEdge;
        aissimage[i]->TopEdge  = aissimage[FIRSTGADGETIMAGE]->TopEdge;
    }

    done = FALSE;
    while (!done)
    {   if ((Wait(ReActionSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
        {   DisposeObject(ReActionWinObject);
            // ReActionWinObject = NULL;
            FreeListBrowserList(&ReActionList);
            if (boingimage)
            {   DisposeObject((Object*) boingimage);
                // boingimage = NULL;
            }
            cleanexit(EXIT_SUCCESS);
        }
        while ((result = DoMethod(ReActionWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   switch (result & WMHI_CLASSMASK)
            {
            case WMHI_CLOSEWINDOW:
                done = TRUE;
            acase WMHI_INTUITICK:
                DISCARD DoMethod((Object*) boingimage, IM_MOVE, ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
            acase WMHI_RAWKEY:
                if (code < KEYUP) // it would be better if we checked that IEQUALIFIER_REPEAT is false
                {   DISCARD GetAttr(WINDOW_Qualifier, ReActionWinObject, &value);
                    qual = (UWORD) (value & 0x003B); // keep actual qualifiers only
                    switch (code)
                    {
                    case SCAN_UP:
                    case NM_WHEEL_UP:
                        if (curgad != 0)
                        {   if (curgad == -1 || (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT)))
                            {   curgad = 0;
                            } else
                            {   curgad--;
                            }
                            SetGadgetAttrs
                            (   gadgets[GID_0_LB1], ReActionWindowPtr, NULL,
                                LISTBROWSER_Selected, curgad,
                            TAG_DONE); // this autorefreshes
                            DoMethod((Object*) aissimage[ReAction[curgad].image], IM_ERASE, ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
                            DoMethod((Object*) aissimage[ReAction[curgad].image], IM_DRAW , ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
                        }
                    acase SCAN_DOWN:
                    case NM_WHEEL_DOWN:
                        if (curgad != next - 1)
                        {   if (curgad == -1 || (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT)))
                            {   curgad = next - 1;
                            } else
                            {   curgad++;
                            }
                            SetGadgetAttrs
                            (   gadgets[GID_0_LB1], ReActionWindowPtr, NULL,
                                LISTBROWSER_Selected, curgad,
                            TAG_DONE); // this autorefreshes
                            DoMethod((Object*) aissimage[ReAction[curgad].image], IM_ERASE, ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
                            DoMethod((Object*) aissimage[ReAction[curgad].image], IM_DRAW , ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
                        }
                    adefault:
                        if (!qual)
                        {   done = TRUE;
                }   }   }
            acase WMHI_GADGETUP:
                switch (result & WMHI_GADGETMASK)
                {
                case GID_0_LB1:
                    curgad = code;
                    DoMethod((Object*) aissimage[ReAction[curgad].image], IM_ERASE, ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
                    DoMethod((Object*) aissimage[ReAction[curgad].image], IM_DRAW , ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
    }   }   }   }

    DisposeObject(ReActionWinObject);
    // ReActionWinObject = NULL;

ABORT:
    FreeListBrowserList(&ReActionList);
    if (boingimage)
    {   DisposeObject((Object*) boingimage);
        // boingimage = NULL;
    }
    settitle(FALSE);
    clearkybd();
}

EXPORT void help_about(void)
{   TRANSIENT SBYTE           OldPri;
    PERSIST   FLAG            first = TRUE;
    PERSIST   TEXT            compiledwith[80 + 1],
                              prioritystr[4 + 1], // "-128"
                              processstr[11 + 1], // "-1222333444"
                              wbstr[20 + 1];
    PERSIST   struct Process* ProcessPtr;
    PERSIST   STRPTR          compiledfor;

    if (AboutWindowPtr)
    {   return;
    }

    load_images(0, 0);
    load_aiss_images(80, 81);

    if (first)
    {   ProcessPtr = (APTR) FindTask(NULL);
#ifdef __amigaos4__
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_CliNum));
#else
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_TaskNum));
#endif

#ifdef __GNUC__
    strcpy(compiledwith, "GCC " __VERSION__);
#else
    #ifdef __VBCC__
        strcpy(compiledwith, "VBCC");
    #else
        #ifdef __SASC
            strcpy(compiledwith, "SAS/C 6.59");
        #else
            strcpy(compiledwith, "?");
        #endif
    #endif
#endif
#ifdef __MORPHOS__
    compiledfor = "MorphOS PPC";
#else
    #ifdef __amigaos4__
        compiledfor = "AmigaOS 4 PPC";
    #else
        compiledfor = "AmigaOS 3 68000+";
    #endif
#endif

        switch (wbver)
        {
        case 45:
            strcpy(wbstr, "OS3.");
            switch (wbrev)
            {
            case    1: strcat(wbstr, "9+BB0"); // should never happen (as we require BB2+)
            acase   2: strcat(wbstr, "9+BB1"); // should never happen (as we require BB2+)
            acase   3: strcat(wbstr, "9+BB2");
            acase   4: strcat(wbstr, "9+BB3");
            acase   5: strcat(wbstr, "9+BB4");
            acase 194: strcat(wbstr, "1.4");
            adefault:  strcat(wbstr, "?");
            }
        acase 46:
            strcpy(wbstr, "OS3.1.4(.1)"); // 3.1.4.1 doesn't have an upgraded version.library
        acase 47:
            strcpy(wbstr, "OS3.2+BB");
            switch (wbrev)
            {
            case    2: strcat(wbstr, "0");
            acase   3: strcat(wbstr, "1");
            acase   4: strcat(wbstr, "2(.1)"); // 3.2.2.1 doesn't have an upgraded version.library
            acase   5: strcat(wbstr, "3");
            adefault:  strcat(wbstr, "?");
            }
        acase 48:
            strcpy(wbstr, "OS3.3");
        acase 50:
            {   struct Resident* rt = FindResident("MorphOS");

                sprintf(wbstr, "MorphOS %d", (int) rt->rt_Version);
            }
        acase 51:
        case 52: // guess
            strcpy(wbstr, "OS4.0");
        acase 53:
            strcpy(wbstr, "OS4.1");
            if (wbrev >= 14)
            {   switch (wbrev)
                {
                case  14: strcat(wbstr, "FEu0");
                acase 15: strcat(wbstr, "FEu1");
                acase 17:                        // OS4.1FEu2 without hotfix
                case  18: strcat(wbstr, "FEu2"); // OS4.1FEu2 with    hotfix
                adefault: strcat(wbstr, "FEu?");
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
        WA_ScreenTitle,                            TITLEBARTEXT,
        WA_Title,                                  "About MCE",
        WA_Activate,                               TRUE,
        WA_DepthGadget,                            TRUE,
        WA_DragBar,                                TRUE,
        WA_CloseGadget,                            TRUE,
        WINDOW_Position,                           WPOS_CENTERSCREEN,
        WINDOW_ParentGroup,
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            LAYOUT_DeferLayout,                    TRUE,
            AddHLayout,
                AddVLayout,
                    LAYOUT_VertAlignment,          LALIGN_TOP,
                    LAYOUT_AddImage,               image[BITMAP_AMIGAN],
                    CHILD_NoDispose,               TRUE,
                End,
                AddVLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_HorizAlignment,         LALIGN_CENTER,
                    LAYOUT_SpaceOuter,             TRUE,
                    LAYOUT_AddImage,
                    LabelObject,
                        LABEL_SoftStyle,           FSF_BOLD,
                        LABEL_Text,                "Multi-game Character Editor " DECIMALVERSION,
                    End,
                    CHILD_WeightedHeight,          0,
                    AddLabel(RELEASEDATE),
                    AddLabel(" "),
                    AddLabel("An editor of game data files"),
                    AddLabel(COPYRIGHT),
                    AddLabel(" "),
                    AddHLayout,
                        AddVLayout,
                            LAYOUT_HorizAlignment, LALIGN_CENTER,
                            AddLabel("Compiled for:"),
                            AddLabel("Compiled with:"),
                            AddLabel("Running on:"),
                            AddLabel("Priority:"),
                            AddLabel("Process number:"),
                            AddLabel("Public screen name:"),
                        End,
                        CHILD_WeightedWidth,       50,
                        AddLabel(" "),
                        CHILD_WeightedWidth,       0,
                        AddVLayout,
                            LAYOUT_HorizAlignment, LALIGN_CENTER,
                            AddLabel(compiledfor),
                            AddLabel(compiledwith),
                            AddLabel(wbstr),
                            AddLabel(prioritystr),
                            AddLabel(processstr),
                            AddLabel(screenname),
                        End,
                        CHILD_WeightedWidth,       50,
                    End,
                    AddLabel(" "),
                End,
            End,
            LAYOUT_AddChild,                       gadgets[GID_0_BU100] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_0_BU100,
                GA_RelVerify,                      TRUE,
                GA_Disabled,                       (!OpenURLBase && !urlopen),
                GA_Image,
                LabelObject,
                    LABEL_Image,                   aissimage[80],
                    CHILD_NoDispose,               TRUE,
                    LABEL_DrawInfo,                DrawInfoPtr,
                    LABEL_VerticalAlignment,       LVALIGN_BASELINE,
                    LABEL_Text,                    " amigan.1emu.net/releases/",
                LabelEnd,
            ButtonEnd,
            LAYOUT_AddChild,                       gadgets[GID_0_BU101] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_0_BU101,
                GA_RelVerify,                      TRUE,
                GA_Disabled,                       (!OpenURLBase && !urlopen),
                GA_Image,
                LabelObject,
                    LABEL_Image,                   aissimage[81],
                    CHILD_NoDispose,               TRUE,
                    LABEL_DrawInfo,                DrawInfoPtr,
                    LABEL_VerticalAlignment,       LVALIGN_BASELINE,
                    LABEL_Text,                    " amigansoftware@gmail.com",
                LabelEnd,
            ButtonEnd,
        End,
    End))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();

    if (!(AboutWindowPtr = (struct Window*) DoMethod((Object*) AboutWinObject, WM_OPEN, NULL)))
    {   DisposeObject(AboutWinObject);
        rq("Can't open window!");
    }
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_ABOUT, NOSUB));
    LendMenus(AboutWindowPtr, MainWindowPtr);

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, AboutWinObject, &AboutSignal);
}

MODULE void help_manual(void)
{   TRANSIENT BPTR                 OldDir;
    PERSIST   struct NewAmigaGuide nag =
    {   ZERO,                 // nag_Lock
        "PROGDIR:MCE.guide",  // nag_Name
        NULL,                 // nag_Screen
        NULL,                 // nag_PubScreen
        NULL,                 // nag_HostPort
        NULL,                 // nag_ClientPort
        NULL,                 // nag_BaseName
        0,                    // nag_Flags
        NULL,                 // nag_Context
        NULL,                 // nag_Node
        0,                    // nag_Line
        NULL,                 // nag_Extens
        NULL                  // nag_Client
    };
    PERSIST STRPTR helpnode[FUNCTIONS + 1] =
    {   "MAIN",               // main menu
        "ArazoksTomb",
        "Psygnosis",          // Barbarian 2 (Psygnosis) & Obliterator
        "BardsTale",
        "MAIN",               // BattleTech
        "Bloodwych",
        "BombJack",
        "BuckRogers",
        "Epyx",               // California 1 & 2/Winter/World Games
        "CannonFodder",
        "ChambersOfShaolin",
        "ChampionsOfKrynn",
        "CitadelOfVras",
        "Scrabble",
        "ConflictEurope",
        "DarkCastle",
        "Icom",               // Deja Vu 1 & 2/Shadowgate/Uninvited
        "DemonsWinter",
        "DragonWars",
        "Druid2",
        "DungeonMaster",      // Dungeon Master 1-2 & Chaos Strikes Back
        "EyeOfTheBeholder",
        "Interceptor",
        "FaeryTaleAdventure",
        "SilentSoftware",     // Firepower & Turbo
        "MAIN",               // Garrison 1 & 2
        "Goal",
        "MAIN",               // Grand Monster Slam
        "MAIN",               // Great Giana Sisters/Hard 'n' Heavy
        "MAIN",               // GridStart 1-3
        "Rogue",              // HackLite/Larn/Moria/Rogue
        "HeroesOfTheLance",   // Heroes of the Lance & Dragons of Flame
        "Hillsfar",
        "ImpossibleMission2",
        "InsanityFight",
        "ICFTD",              // It Came from the Desert
        "KeefTheThief",
        "KingsQuest",
        "LastNinjaRemix",
        "LegendOfFaerghail",
        "MAIN",               // Legend of Lothian
        "Mercenary1",
        "Might&Magic",        // Might & Magic 2 & 3
        "MAIN",               // Mindshadow/Borrowed Times/Tass Times in Tonetown
        "Neuromancer",
        "MAIN",               // Nitro
        "Polarware",          // Oo-Topos & Transylvania 1 & 2
        "Panza",
        "Phantasie",
        "Pinball",            // Pinball Dreams/Fantasies/Illusions
        "Pirates",            // Pirates! & Pirates! Gold
        "PoolOfRadiance",
        "Quadralien",
        "Questron2",
        "Ragnarok",
        "MAIN",               // Return of the Jedi
        "RobinHood",          // Robin Hood & Rome: AD92
        "Rockford",
        "RorkesDrift",
        "Shadow",             // Shadowlands & Shadoworlds
        "SideWinder",         // SideWinder 1 & 2
        "Sinbad",
        "Slaygon",
        "Speedball",          // Speedball 1 & 2
        "Syndicate",
        "TempleOfApshai",
        "TimesOfLore",
        "TVSports",
        "Ultima",             // Ultima 3-6
        "WarInMiddleEarth",
        "Wizardry6",
        "Zerg",
    };

    if (!guideexists)
    {   return;
    }

    if (morphos || function != FUNC_MENU)
    {   /* MorphOS OpenWorkbenchObject() function is a non-functional
           dummy; therefore we use OpenAmigaGuide() when running under
           MorphOS. */

        // assert(function >= 0 && function <= FUNCTIONS);
        nag.nag_Node = helpnode[function];
        lockscreen();
        nag.nag_Screen = ScreenPtr;
        DISCARD OpenAmigaGuide(&nag, TAG_DONE);
        unlockscreen();
    } else
    {   OldDir = CurrentDir(ProgLock);
        DISCARD OpenWorkbenchObject
        (   "MCE.guide",
            WBOPENA_ArgLock, ProgLock,
            WBOPENA_ArgName, "MCE.guide",
        TAG_DONE);
        DISCARD CurrentDir(OldDir);
}   }

EXPORT void closewindow(void)
{
#ifdef TRACKEXIT
    DISCARD Printf("2.2!\n"); Delay(TRACKDELAY);
#endif

    if (WinObject) // NOT if (MainWindowPtr) (because it might be iconified)
    {   clearkybd();
#ifdef TRACKEXIT
    DISCARD Printf("2.3!\n"); Delay(TRACKDELAY);
#endif

        /* page will have already been changed to point to the desired new
           window, so we use closer. function is not changed to the
           new function until later. */

        if (function != FUNC_MENU)
        {   tool_close();
        }
#ifdef TRACKEXIT
    DISCARD Printf("2.4!\n"); Delay(TRACKDELAY);
#endif

        OnMenu(MainWindowPtr, FULLMENUNUM(MN_TOOLS, funcinfo[closer].itemnum, funcinfo[closer].subnum));

        if (MainWindowPtr)
        {   winbox[function].Left   = MainWindowPtr->LeftEdge;
            winbox[function].Top    = MainWindowPtr->TopEdge;
            winbox[function].Width  = MainWindowPtr->Width  - MainWindowPtr->BorderLeft - MainWindowPtr->BorderRight;
            winbox[function].Height = MainWindowPtr->Height - MainWindowPtr->BorderTop  - MainWindowPtr->BorderBottom;
        }
        // GetAttr(WA_Width/Height/InnerWidth/InnerHeight) seems not to work (always gives 1), on OS3.9 at least.

#ifndef __MORPHOS__
        if (changedcolours) // this has to be done *before* closing the window (on RTG)
        {   changedcolours = FALSE;
            lockscreen();
            SetRGB4(&(ScreenPtr->ViewPort), 17, (colour17 & 0x00000F00) >> 8, (colour17 & 0x000000F0) >> 4, colour17 & 0x0000000F);
            SetRGB4(&(ScreenPtr->ViewPort), 18, (colour18 & 0x00000F00) >> 8, (colour18 & 0x000000F0) >> 4, colour18 & 0x0000000F);
            SetRGB4(&(ScreenPtr->ViewPort), 19, (colour19 & 0x00000F00) >> 8, (colour19 & 0x000000F0) >> 4, colour19 & 0x0000000F);
            unlockscreen();
        }
#endif

#ifdef TRACKEXIT
    DISCARD Printf("2.5!\n"); Delay(TRACKDELAY);
#endif

        /* Disposing of the window object will also close the window if it is
         * already opened, and it will dispose of the layout object attached to it.
         */
        DisposeObject(WinObject);
        WinObject = NULL;
        MainWindowPtr = NULL;
    }

#ifdef TRACKEXIT
    DISCARD Printf("2.6!\n"); Delay(TRACKDELAY);
#endif

    if (function != FUNC_MENU)
    {   tool_exit();
#ifdef TRACKEXIT
    DISCARD Printf("2.7!\n"); Delay(TRACKDELAY);
#endif
        free_bm(0);
#ifdef TRACKEXIT
    DISCARD Printf("2.8!\n"); Delay(TRACKDELAY);
#endif
        free_bm(1);
    }
#ifdef TRACKEXIT
    DISCARD Printf("2.9!\n"); Delay(TRACKDELAY);
#endif
}

EXPORT FLAG asl(STRPTR message, STRPTR pattern, FLAG saving)
{   TRANSIENT struct FileRequester* ASLRqPtr;
    TRANSIENT FLAG                  success;
    TRANSIENT ULONG                 flags;
    PERSIST   TEXT                  hailstring[VLONGFIELD + 1];

    strcpy(hailstring, "MCE: ");
    strcat(hailstring, message);

    // asldir is the directory that the ASL requester will start in.

    if (!(ASLRqPtr = (struct FileRequester*) AllocAslRequestTags(ASL_FileRequest,
        ASL_Pattern, pattern,
        ASL_Window,  MainWindowPtr,
    TAG_DONE)))
    {   rq("Can't create ASL request!");
    }
    if (saving)
    {   flags = FILF_PATGAD | FILF_SAVE;
    } else
    {   flags = FILF_PATGAD;
    }
    if
    (   (AslRequestTags(ASLRqPtr,
            ASL_Dir,           asldir,
            ASL_File,          aslfile,
            ASL_Hail,          hailstring,
            ASL_FuncFlags,     flags,
            ASLFR_RejectIcons, TRUE,
        TAG_DONE))
     && *(ASLRqPtr->rf_File) != 0
    )
    {   strcpy(asldir, ASLRqPtr->rf_Dir);
        if (ASLRqPtr->rf_Dir[0])
        {   strcpy(aslresult, ASLRqPtr->rf_Dir);
            if (!AddPart(aslresult, ASLRqPtr->rf_File, MAX_PATH))
            {   FreeAslRequest(ASLRqPtr);
                rq("Can't add filename to pathname!");
        }   }
        else
        {   strcpy(aslresult, ASLRqPtr->rf_File);
        }
        success = TRUE;
        strcpy(filename, ASLRqPtr->rf_File);
    } else
    {   // either the user chose Cancel, or clicked OK with an empty filename
        aslresult[0] = EOS;
        success = FALSE;
    }
    assert((int) ASLRqPtr);
    FreeAslRequest(ASLRqPtr);
    return success;
}

EXPORT void loop(void)
{   UWORD                  code;
    int                    oldpage          = page    ;
    ULONG                  gid,
                           result;
    FLAG                   done             = FALSE   ;
    struct List*           ScreenListPtr /* = NULL */ ;
    struct PubScreenNode*  NodePtr;
    struct AppMessage*     AppMsg;
    struct WBArg*          ArgPtr;
#ifdef __amigaos4__
    struct ApplicationMsg* AppLibMsg;
    ULONG                  msgtype,
                           msgval,
                           os4code;
#endif

    closer = page;
    while (page == oldpage && !done)
    {   if (AboutWindowPtr)
        {   about_loop();
        } else
        {   if ((Wait(MainSignal | AppSignal | AppLibSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
            {   cleanexit(EXIT_SUCCESS);
        }   }

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
                 && NameFromLock(ArgPtr->wa_Lock, filename, MAX_PATH + 1)
                 && AddPart(filename, ArgPtr->wa_Name, MAX_PATH + 1)
                )
                {   project_open(FALSE);
                }
            adefault:
                DisplayBeep(NULL); // lame user error :-)
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
            case WMHI_MENUPICK:
#ifdef __amigaos4__
                if (os4menus)
                {   os4code = NO_MENU_ID;
                    while ((os4code = IDoMethod((Object*) MenuPtr, MM_NEXTSELECT, 0, os4code)) != NO_MENU_ID)
                    {   if (handlemenus(os4code - 1))
                        {   done = TRUE;
                }   }   }
                else
#endif
                {   if (handlemenus(code))
                    {   done = TRUE;
                }   }
            acase WMHI_CLOSEWINDOW:
                if (page == 0)
                {   cleanexit(EXIT_SUCCESS);
                } else
                {   page = 0;
                }
            acase WMHI_ICONIFY:
                iconify();
            acase WMHI_GADGETUP:
                gid = result & WMHI_GADGETMASK;
                if (gid == (ULONG) speedbar)
                {   switch (code)
                    {
                    case 1:
                        DISCARD tool_open(TRUE);
                    acase 2:
                        tool_save(FALSE);
                }   }
                else
                {   tool_loop(gid, code);
                }
            acase WMHI_NEWSIZE:
                pending |= PENDING_RESIZE;
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
                {   pending |= PENDING_JUMPSCREEN;
        }   }   }

#ifdef __amigaos4__
        if (AppLibPort)
        {   while ((AppLibMsg = (struct ApplicationMsg*) GetMsg(AppLibPort)))
            {   msgtype = AppLibMsg->type;
                msgval  = (ULONG) ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName;
                ReplyMsg((struct Message *) AppLibMsg);

                switch (msgtype)
                {
                case APPLIBMT_Quit:
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
                    if (function == FUNC_MENU)
                    {   DisplayBeep(NULL);
                    } else
                    {   strcpy(filename, ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName);
                        project_open(FALSE);
                        lockscreen();
                        // we should really only do this if successfully loaded
                        ScreenToFront(ScreenPtr);
                        unlockscreen();
                        // assert(MainWindowPtr);
                        WindowToFront(MainWindowPtr);
                        ActivateWindow(MainWindowPtr);
        }   }   }   }
#endif

        if (pending & PENDING_MAPREFRESH)
        {   pending &= ~(PENDING_MAPREFRESH);
            hf_maprefresh();
        }
        if (pending & PENDING_CHANGEPAGE)
        {   pending &= ~(PENDING_CHANGEPAGE);
            changepage();
        }
        if (pending & PENDING_QUIT)
        {   // pending &= ~(PENDING_QUIT);
            cleanexit(EXIT_SUCCESS);
        }
        if (pending & PENDING_JUMPSCREEN)
        {   pending &= ~(PENDING_JUMPSCREEN);
            done = TRUE;
            switch (function)
            {
            case  FUNC_BOMBJACK:     bj_freepens();
            acase FUNC_DRUID2:   druid2_freepens();
            acase FUNC_SS:           ss_freepens();
            acase FUNC_ROCKFORD:     rf_freepens();
            acase FUNC_SIDEWINDER:   sw_freepens();
            }

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

            getpens();
        }
        if (pending & PENDING_RESIZE)
        {   pending &= ~(PENDING_RESIZE);
            switch (function)
            {
            case  FUNC_BOMBJACK:      bj_drawmap(TRUE);
            acase FUNC_COV:          cov_drawmap();
            acase FUNC_CE:            ce_drawmap();
            acase FUNC_DW:            dw_drawmap();
            acase FUNC_DRUID2:    druid2_resize();
                                  druid2_drawmap(TRUE);
            acase FUNC_DM:            dm_drawmap();
            acase FUNC_FTA:          fta_drawmap();
            acase FUNC_SS:            ss_resize();
                                      ss_drawmap(TRUE);
            acase FUNC_GARRISON:     gar_drawmap(TRUE);
            acase FUNC_GOAL:        goal_resize();
            acase FUNC_HILLSFAR:      hf_drawmap();
            acase FUNC_IF:            if_resize();
                                      if_drawmap();
            acase FUNC_MERCENARY:   merc_drawmap();
            acase FUNC_PIRATES:      pir_drawmap();
            acase FUNC_QUADRALIEN:    qa_drawmap(TRUE);
            acase FUNC_Q2:            q2_drawmap();
            acase FUNC_ROBIN:      robin_drawmap();
            acase FUNC_ROCKFORD:      rf_drawmap(TRUE);
            acase FUNC_RORKE:      rorke_drawmap();
            acase FUNC_SIDEWINDER:    sw_resize();
                                      sw_drawmap(0, 0, TRUE);
            acase FUNC_SLAYGON:      sla_drawmap();
         // acase FUNC_TOL:          tol_drawmap();     (not actually resizable)
            acase FUNC_WIME:        wime_drawmap();
            acase FUNC_ZERG:        zerg_drawmap();
}   }   }   }

EXPORT void writeout(STRPTR pathname, int size)
{   BPTR FileHandle;

    if (!(FileHandle = (BPTR) Open(pathname, MODE_NEWFILE)))
    {   rq("Can't open file for writing!");
    }
    if (Write(FileHandle, IOBuffer, (LONG) size) == -1)
    {   DISCARD Close(FileHandle);
        rq("Can't write to file!");
    }
    DISCARD Close(FileHandle);
}

EXPORT void rq(STRPTR text)
{   Object* reqobj;

    if
    (   RequesterBase
     && ((reqobj = RequesterObject,
            REQ_Type,       REQTYPE_INFO,
            REQ_Image,      REQIMAGE_ERROR,
            REQ_TitleText,  (Tag) "MCE: Fatal Error",
            REQ_BodyText,   (Tag) text,
            REQ_GadgetText, (Tag) "Quit",
        TAG_END)))
    )
    {   OpenRequester(reqobj, MainWindowPtr); // OK even if MainWindowPtr is NULL
        DisposeObject(reqobj);
    } else
    {   EasyStruct.es_Title        = (STRPTR) "MCE: Fatal Error";
        EasyStruct.es_TextFormat   = (STRPTR) text;
        EasyStruct.es_GadgetFormat = (STRPTR) "Quit";
        EasyRequest(MainWindowPtr, &EasyStruct, NULL); // OK even if MainWindowPtr is NULL
    }

    cleanexit(EXIT_FAILURE);
}

EXPORT void say(STRPTR text, ULONG reqimage)
{   Object* reqobj;

    if
    (   RequesterBase
     && ((reqobj = RequesterObject,
            REQ_Type,       REQTYPE_INFO,
            REQ_Image,      reqimage,
            REQ_TitleText,  (Tag) ((reqimage == REQIMAGE_WARNING) ? "MCE: Error/Warning" : "MCE: Message"),
            REQ_BodyText,   (Tag) text,
            REQ_GadgetText, (Tag) "OK",
        TAG_END)))
    )
    {   OpenRequester(reqobj, MainWindowPtr); // OK even if MainWindowPtr is NULL
        DisposeObject(reqobj);
    } else
    {   EasyStruct.es_Title        = (STRPTR) ((reqimage == REQIMAGE_WARNING) ? "MCE: Error/Warning" : "MCE: Message");
        EasyStruct.es_TextFormat   = (STRPTR) text;
        EasyStruct.es_GadgetFormat = (STRPTR) "OK";
        EasyRequest(MainWindowPtr, &EasyStruct, NULL); // OK even if MainWindowPtr is NULL
}   }

MODULE void parsewb(void)
{   struct DiskObject* DiskObject;
    STRPTR*            ToolArray;
    STRPTR             s;
    int                i,
                       number;
    TEXT               tempstring[80 + 1]; // this can theoretically overflow

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        if ((s = FindToolType(ToolArray, "FILE")))
        {   strcpy(pathname, s);
            cliname = TRUE;
            zstrncpy(asldir, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        }
        if ((s = FindToolType(ToolArray, "FUNCTION")))
        {   for (i = 1; i <= FUNCTIONS; i++)
            {   DISCARD stcl_d(tempstring, (long) i);
                if (MatchToolValue(s, tempstring))
                {   closer = function = page = i;
                    functab = funcinfo[function].itemnum - IN_PAGE1;
                    break; // for speed
        }   }   }
        if ((s = FindToolType(ToolArray, "PUBSCREEN")))
        {   strcpy(screenname, s);
        }
        if ((s = FindToolType(ToolArray, "SCREENWIDTH")))
        {   number = atoi(s);
            if (number >= 1 && number <= 32767)
            {   screenwidth = (SWORD) number;
        }   }
        if ((s = FindToolType(ToolArray, "SCREENHEIGHT")))
        {   number = atoi(s);
            if (number >= 1 && number <= 32767)
            {   screenheight = (SWORD) number;
        }   }
        FreeDiskObject(DiskObject);
}   }

MODULE void about_loop(void)
{   UWORD code;
    ULONG aboutdone = 0,
          result;

    // Processes any messages for the About... window.

    if ((Wait(AboutSignal | MainSignal | AppSignal | AppLibSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
    {   aboutdone = 2;
    }

    while ((result = DoMethod(AboutWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_CLOSEWINDOW:
            aboutdone = 1;
        acase WMHI_RAWKEY:
            if (code < 128 && code != NM_WHEEL_UP && code != NM_WHEEL_DOWN)
            // it would be better if we could check that IEQUALIFIER_REPEAT is false
            {   aboutdone = 1;
            }
        acase WMHI_GADGETUP:
            switch (result & WMHI_GADGETMASK)
            {
            case GID_0_BU100:
                openurl("http://amigan.1emu.net/releases/");
            acase GID_0_BU101:
                openurl("mailto:amigansoftware@gmail.com");
    }   }   }

    if (aboutdone >= 1)
    {   DisposeObject(AboutWinObject);
        AboutWindowPtr = NULL;
        AboutWinObject = NULL;
        OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_ABOUT, NOSUB));
        if (aboutdone == 2)
        {   cleanexit(EXIT_SUCCESS);
}   }   }

EXPORT FLAG handlemenus(UWORD code)
{   FLAG             rc = FALSE;
    int              i;
    struct MenuItem* ItemPtr;

    if (code != MENUNULL) // while (code != MENUNULL)
    {   ItemPtr = ItemAddress(MenuPtr, code);
        switch (MENUNUM(code))
        {
        case MN_PROJECT:
            switch (ITEMNUM(code))
            {
            case IN_OPEN:
                project_open(TRUE);
            acase IN_REVERT:
                project_open(FALSE);
            acase IN_SAVE:
                if (function != FUNC_MENU)
                {   tool_save(FALSE);
                }
            acase IN_SAVEAS:
                if (function != FUNC_MENU)
                {   tool_save(TRUE);
                }
            acase IN_ICONIFY:
                iconify();
            acase IN_QUIT:
                cleanexit(EXIT_SUCCESS);
            }
        acase MN_VIEW:
            switch (ITEMNUM(code))
            {
            case IN_POINTER:
                if (ItemPtr->Flags & CHECKED)
                {   custompointer = TRUE;
                } else
                {   custompointer = FALSE;
                }
                setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
            acase IN_TOOLBAR:
                if (ItemPtr->Flags & CHECKED)
                {   showtoolbar = TRUE;
                } else
                {   showtoolbar = FALSE;
                }
                rc = TRUE;
            }
        acase MN_TOOLS:
            for (i = 0; i <= FUNCTIONS; i++)
            {   if (ITEMNUM(code) == funcinfo[i].itemnum && SUBNUM(code) == funcinfo[i].subnum)
                {   page = i;
                    break; // for speed
            }   }
        acase MN_HELP:
            switch (ITEMNUM(code))
            {
            case IN_FORMATS:
                // assert(OpenURLBase || urlopen);
                openurl("http://amigan.1emu.net/releases/ami-form.txt");
            acase IN_MANUAL:
                // assert(guideexists && (!morphos || AmigaGuideBase));
                help_manual();
            acase IN_UPDATE:
                help_update();
            acase IN_REACTION:
                help_reaction();
            acase IN_ABOUT:
                help_about();
        }   }
        // code = ItemPtr->NextSelect;
    }

    return rc;
}

EXPORT void lockscreen(void)
{   if (!IntuitionBase)
    {   return;
    }

    if (CustomScreenPtr)
    {   ScreenPtr = CustomScreenPtr;
    } elif (screenname[0])
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) screenname)))
        {   rq("Can't lock specified public screen!");
    }   }
    else
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) NULL)))
        {   rq("Can't lock default public screen!");
}   }   }

EXPORT void unlockscreen(void)
{   if (!IntuitionBase)
    {   return;
    }

    if (!CustomScreenPtr && ScreenPtr)
    {   if (screenname[0])
        {   UnlockPubScreen(screenname, ScreenPtr);
            ScreenPtr = NULL;
        } else
        {   UnlockPubScreen(NULL, ScreenPtr);
            ScreenPtr = NULL;
}   }   }

MODULE void menu_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_0_CT1:
        DISCARD GetAttr(CLICKTAB_Current, (Object*) gadgets[GID_0_CT1], &functab);
        // page gadget gets updated automatically via gadget interconnect
        DISCARD RethinkLayout(gadgets[GID_0_LY1], MainWindowPtr, NULL, TRUE);
    adefault:
        if (gid >= GID_0_BU1 && gid < GID_0_BU1 + FUNCTIONS)
        {   page = gid - GID_0_BU1 + 1;
}   }   }

MODULE ULONG Hook0Func(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg)
{   /* "When the hook is called, the data argument points to the
    window object and message argument to the IntuiMessage."

    These IntuiMessages do not need to be replied to by the appliprog. */

    TRANSIENT UWORD code,
                    qual;
    TRANSIENT ULONG class,
                    newover;
    TRANSIENT SWORD mousex, mousey;
    TRANSIENT int   i;
    PERSIST   ULONG over = FUNCTIONS;

#ifdef __SASC
    geta4(); // wait till here before doing anything
#endif

    class  = ((struct IntuiMessage*) msg)->Class;
    code   = ((struct IntuiMessage*) msg)->Code;
    qual   = ((struct IntuiMessage*) msg)->Qualifier;
    mousex = ((struct IntuiMessage*) msg)->MouseX;
    mousey = ((struct IntuiMessage*) msg)->MouseY;

    switch (class)
    {
    case IDCMP_RAWKEY:
        switch (code)
        {
        case SCAN_HELP:
            help_manual();
        acase SCAN_ESCAPE:
            pending |= PENDING_QUIT;
        acase SCAN_LEFT:
            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
            {   newpage = 0;
            } else
            {   if (functab > 0)
                {   newpage = functab - 1;
                } else
                {   newpage = 0;
            }   }
            if (newpage != functab)
            {   pending |= PENDING_CHANGEPAGE;
            }
        acase SCAN_RIGHT:
            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
            {   newpage = PAGES - 1;
            } else
            {   if (functab < PAGES - 1)
                {   newpage = functab + 1;
                } else
                {   newpage = PAGES - 1;
            }   }
            if (newpage != functab)
            {   pending |= PENDING_CHANGEPAGE;
            }
        acase SCAN_SPACEBAR:
            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
            {   if (functab > 0)
                {   newpage = functab - 1;
                } else
                {   newpage = PAGES - 1;
            }   }
            else
            {   if (functab < PAGES - 1)
                {   newpage = functab + 1;
                } else
                {   newpage = 0;
            }   }
            pending |= PENDING_CHANGEPAGE;
        adefault:
            newpage = functab;
            switch (code)
            {
            case  SCAN_A: case SCAN_B: case SCAN_C:                           newpage = 0;
            acase SCAN_D: case SCAN_E: case SCAN_F: case SCAN_G:              newpage = 1;
            acase SCAN_H: case SCAN_I: case SCAN_K: case SCAN_L: case SCAN_M: newpage = 2;
            acase SCAN_N: case SCAN_O: case SCAN_P: case SCAN_Q: case SCAN_R: newpage = 3;
            acase SCAN_S: case SCAN_T: case SCAN_U: case SCAN_W: case SCAN_Z: newpage = 4; // Zerg! :-)
            }
            if (newpage != functab)
            {   pending |= PENDING_CHANGEPAGE;
        }   }
    acase IDCMP_INTUITICKS:
        newover = FUNC_MENU;
        for (i = 0; i < numgads[functab]; i++)
        {   if
            (   mousex >= gadgets[firstgad[functab] + i]->LeftEdge
             && mousex <= gadgets[firstgad[functab] + i]->LeftEdge + gadgets[firstgad[functab] + i]->Width  - 1
             && mousey >= gadgets[firstgad[functab] + i]->TopEdge
             && mousey <= gadgets[firstgad[functab] + i]->TopEdge  + gadgets[firstgad[functab] + i]->Height - 1
            )
            {   newover = 1 + (firstgad[functab] + i) - GID_0_BU1;
                break; // for speed
        }   }
        if (newover != over)
        {   over = newover;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_0_ST1], MainWindowPtr, NULL,
                STRINGA_TextVal, funcinfo[over].longname,
            TAG_DONE); // this autorefreshes
    }   }

    return 1;
}

EXPORT ULONG ToolHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg)
{   /* "When the hook is called, the data argument points to the
    window object and message argument to the IntuiMessage." */

    ULONG class;
    UWORD code, qual;
    SWORD mousex, mousey;

#ifdef LATTICE
    geta4(); /* wait till here before doing anything */
#endif

     class = ((struct IntuiMessage*) msg)->Class;
      code = ((struct IntuiMessage*) msg)->Code;
      qual = ((struct IntuiMessage*) msg)->Qualifier;
    mousex = ((struct IntuiMessage*) msg)->MouseX;
    mousey = ((struct IntuiMessage*) msg)->MouseY;

    switch (class)
    {
    case IDCMP_RAWKEY:
        switch (code)
        {
        case SCAN_HELP:
            help_manual();
        acase SCAN_ESCAPE:
            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
            {   pending |= PENDING_QUIT;
            } else
            {   page = 0;
            }
        adefault:
            if (code <= 0x7F)
            {   switch (function)
                {
                case  FUNC_PSYGNOSIS:   psyg_key(code                      );
                acase FUNC_BT:            bt_key(code, qual, mousex, mousey);
                acase FUNC_BOMBJACK:      bj_key(code                      );
                acase FUNC_COK:          cok_key(code, qual                );
                acase FUNC_COV:          cov_key(code, qual                );
                acase FUNC_CE:            ce_key(code, qual                );
                acase FUNC_ICOM:        icom_key(code, qual                );
                acase FUNC_DW:            dw_key(code, qual, mousex, mousey);
                acase FUNC_DRA:          dra_key(code, qual                );
                acase FUNC_DRUID2:    druid2_key(code, qual, mousex, mousey);
                acase FUNC_DM:            dm_key(code                      );
                acase FUNC_FTA:          fta_key(code, qual                );
                acase FUNC_SS:            ss_key(code, qual, mousex, mousey);
                acase FUNC_GARRISON:     gar_key(code, qual                );
                acase FUNC_GOAL:        goal_key(code, qual                );
                acase FUNC_ROGUE:      rogue_key(code, qual                );
                acase FUNC_HOL:          hol_key(code                      );
                acase FUNC_IF:            if_key(code, qual                );
                acase FUNC_MERCENARY:   merc_key(code, qual                );
                acase FUNC_MM:            mm_key(code, qual                );
                acase FUNC_INTERPLAY: interplay_key(code,qual              );
                acase FUNC_PHANTASIE:     ph_key(code, qual                );
                acase FUNC_PIRATES:      pir_key(code, qual, mousex, mousey);
                acase FUNC_POR:          por_key(code, qual, mousex, mousey);
                acase FUNC_Q2:            q2_key(code, qual, mousex, mousey);
                acase FUNC_RAGNAROK:     lor_key(code, qual                );
                acase FUNC_ROBIN:      robin_key(code, qual, mousex, mousey);
                acase FUNC_ROCKFORD:      rf_key(code                      );
                acase FUNC_RORKE:      rorke_key(code, qual                );
                acase FUNC_SHADOW:    shadow_key(code                      );
                acase FUNC_SIDEWINDER:    sw_key(code, qual                );
                acase FUNC_SLAYGON:      sla_key(code, qual                );
                acase FUNC_TVS:          tvs_key(code                      );
                acase FUNC_WIME:        wime_key(code, qual                );
                acase FUNC_WIZ:          wiz_key(code, qual                );
                acase FUNC_ZERG:        zerg_key(code, qual                );
        }   }   }
    acase IDCMP_MOUSEBUTTONS:
        switch (function)
        {
        case  FUNC_BOMBJACK:      bj_lmb(mousex, mousey, code);
        acase FUNC_COV:          cov_lmb(mousex, mousey);
        acase FUNC_CE:            ce_lmb(mousex, mousey);
        acase FUNC_DW:            dw_lmb(mousex, mousey);
        acase FUNC_DRUID2:    druid2_lmb(mousex, mousey, code);
        acase FUNC_DM:            dm_lmb(mousex, mousey, code);
        acase FUNC_FTA:          fta_lmb(mousex, mousey);
        acase FUNC_SS:            ss_mb( mousex, mousey, code);
        acase FUNC_GARRISON:     gar_lmb(mousex, mousey, code);
        acase FUNC_GOAL:        goal_lmb(mousex, mousey, code);
        acase FUNC_HILLSFAR:      hf_lmb(mousex, mousey, code);
        acase FUNC_IF:            if_mb( mousex, mousey, code);
        acase FUNC_MERCENARY:   merc_lmb(mousex, mousey, code);
        acase FUNC_PIRATES:      pir_lmb(mousex, mousey, code);
        acase FUNC_ROBIN:      robin_lmb(mousex, mousey, code);
        acase FUNC_ROCKFORD:      rf_lmb(mousex, mousey, code);
        acase FUNC_RORKE:      rorke_lmb(mousex, mousey, code);
        acase FUNC_QUADRALIEN:    qa_lmb(mousex, mousey, code);
        acase FUNC_Q2:            q2_lmb(mousex, mousey);
        acase FUNC_SIDEWINDER:    sw_lmb(mousex, mousey, code);
        acase FUNC_SLAYGON:      sla_lmb(mousex, mousey);
        acase FUNC_WIME:        wime_mb( mousex, mousey, code);
        acase FUNC_ZERG:        zerg_lmb(mousex, mousey);
        }
    acase IDCMP_MENUVERIFY:
        if
        (   code == MENUHOT
         && (   (function == FUNC_IF   &&   if_wantrmb(mousex, mousey))
             || (function == FUNC_SS   &&   ss_wantrmb(mousex, mousey))
             || (function == FUNC_WIME && wime_wantrmb(mousex, mousey))
        )   )
        {   ((struct IntuiMessage*) msg)->Code = MENUCANCEL;
        }
    acase IDCMP_INTUITICKS:
        switch (function)
        {
        case  FUNC_BOMBJACK:      bj_tick(mousex, mousey);
        acase FUNC_COV:          cov_tick(mousex, mousey);
        acase FUNC_CE:            ce_tick(mousex, mousey);
        acase FUNC_DW:            dw_tick(mousex, mousey);
        acase FUNC_DRUID2:    druid2_tick(mousex, mousey);
        acase FUNC_DM:            dm_tick(mousex, mousey);
        acase FUNC_FTA:          fta_tick(mousex, mousey);
        acase FUNC_SS:            ss_tick(mousex, mousey);
        acase FUNC_GARRISON:     gar_tick(mousex, mousey);
        acase FUNC_HILLSFAR:      hf_tick(mousex, mousey);
        acase FUNC_IF:            if_tick(mousex, mousey);
        acase FUNC_MERCENARY:   merc_tick(mousex, mousey);
        acase FUNC_PIRATES:      pir_tick(mousex, mousey);
        acase FUNC_QUADRALIEN:    qa_tick(mousex, mousey);
        acase FUNC_Q2:            q2_tick(mousex, mousey);
        acase FUNC_ROBIN:      robin_tick(mousex, mousey);
        acase FUNC_ROCKFORD:      rf_tick(mousex, mousey);
        acase FUNC_RORKE:      rorke_tick(mousex, mousey);
        acase FUNC_SIDEWINDER:    sw_tick(mousex, mousey);
        acase FUNC_SLAYGON:      sla_tick(mousex, mousey);
        acase FUNC_WIME:        wime_tick(mousex, mousey);
        acase FUNC_ZERG:        zerg_tick(mousex, mousey);
        }
    acase IDCMP_MOUSEMOVE:
        switch (function)
        {
        case  FUNC_BOMBJACK:      bj_mouse(mousex, mousey);
        acase FUNC_DRUID2:    druid2_mouse(mousex, mousey);
        acase FUNC_DM:            dm_mouse(mousex, mousey);
        acase FUNC_GARRISON:     gar_mouse(mousex, mousey);
        acase FUNC_GOAL:        goal_mouse(mousex, mousey);
        acase FUNC_IF:            if_mouse(mousex, mousey);
        acase FUNC_QUADRALIEN:    qa_mouse(mousex, mousey);
        acase FUNC_ROBIN:      robin_mouse(mousex, mousey);
        acase FUNC_ROCKFORD:      rf_mouse(mousex, mousey);
        acase FUNC_SIDEWINDER:    sw_mouse(mousex, mousey);
        acase FUNC_SS:            ss_mouse(mousex, mousey);
        }
    acase IDCMP_REFRESHWINDOW:
        pending |= PENDING_RESIZE;
    }

    return 1;
}

EXPORT ULONG ToolSubHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg)
{   /* "When the hook is called, the data argument points to the
    window object and message argument to the IntuiMessage." */

    ULONG class;
    UWORD code, qual;
    SWORD mousex, mousey;

#ifdef LATTICE
    geta4(); /* wait till here before doing anything */
#endif

     class = ((struct IntuiMessage *) msg)->Class;
      code = ((struct IntuiMessage *) msg)->Code;
      qual = ((struct IntuiMessage *) msg)->Qualifier;
    mousex = ((struct IntuiMessage *) msg)->MouseX;
    mousey = ((struct IntuiMessage *) msg)->MouseY;

    switch (class)
    {
    case IDCMP_RAWKEY:
        switch (code)
        {
        case SCAN_HELP:
            help_manual();
        acase SCAN_ESCAPE:
            globaldone = cancelling = TRUE;
        adefault:
            if (code <= 0x7F)
            {   switch (function)
                {
                case  FUNC_ARAZOK:      globaldone =      arazok_subkey(code                      );
                acase FUNC_BT:          globaldone =          bt_subkey(code, qual                );
                acase FUNC_BW:          globaldone =          bw_subkey(code, qual                );
                acase FUNC_CF:          globaldone =          cf_subkey(code, qual                );
                acase FUNC_COV:         globaldone =         cov_subkey(code, qual                );
                acase FUNC_ICOM:        globaldone =        icom_subkey(code, qual                );
                acase FUNC_DW:          globaldone =          dw_subkey(code, qual                );
                acase FUNC_EOB:         globaldone =         eob_subkey(code, qual                );
                acase FUNC_GARRISON:    globaldone =         gar_subkey(code                      );
                acase FUNC_ROGUE:       globaldone =       rogue_subkey(code, qual                );
                acase FUNC_HOL:         globaldone =         hol_subkey(code, qual                );
                acase FUNC_KEEF:        globaldone =        keef_subkey(code                      );
                acase FUNC_KQ:          globaldone =          kq_subkey(code                      );
                acase FUNC_LOF:         globaldone =         lof_subkey(code, qual                );
                acase FUNC_MERCENARY:   globaldone =        merc_subkey(code, qual                );
                acase FUNC_MM:          globaldone =          mm_subkey(code, qual, mousex, mousey);
                acase FUNC_INTERPLAY:   globaldone =   interplay_subkey(code, qual                );
                acase FUNC_NEUROMANCER: globaldone =          nm_subkey(code, qual                );
                acase FUNC_POLARWARE:   globaldone =       polar_subkey(code                      );
                acase FUNC_PANZA:       globaldone =       panza_subkey(code, qual                );
                acase FUNC_PHANTASIE:   globaldone =          ph_subkey(code, qual                );
                acase FUNC_PIRATES:     globaldone =         pir_subkey(code, qual                );
                acase FUNC_POR:         globaldone =         por_subkey(code, qual                );
                acase FUNC_SINBAD:      globaldone =          sb_subkey(code, qual                );
                acase FUNC_SPEEDBALL:   globaldone =      speedb_subkey(code                      );
                acase FUNC_SYNDICATE:   globaldone =         syn_subkey(code, qual                );
                acase FUNC_ULTIMA:      globaldone =      ultima_subkey(code, qual                );
                acase FUNC_WIME:        globaldone =        wime_subkey(code                      );
                acase FUNC_BOMBJACK:
                case  FUNC_SS:
                case  FUNC_IF:
                case  FUNC_ROCKFORD:
                case  FUNC_SIDEWINDER:  globaldone = sketchboard_subkey(code                      );
        }   }   }
    acase IDCMP_MOUSEBUTTONS:
        if (code == SELECTDOWN)
        {   switch (function)
            {
            case  FUNC_BT:                               bt_sublmb(mousex, mousey);
            acase FUNC_ROGUE:                         rogue_sublmb(mousex, mousey);
            acase FUNC_PHANTASIE:                        ph_sublmb(mousex, mousey);
        }   }
    acase IDCMP_INTUITICKS:
        switch (function)
        {
        case  FUNC_ARAZOK:          arazok_subtick(mousex, mousey);
        acase FUNC_BOMBJACK:
        case  FUNC_SS:
        case  FUNC_IF:
        case  FUNC_ROCKFORD:
        case  FUNC_SIDEWINDER: sketchboard_subtick(mousex, mousey);
        acase FUNC_ROGUE:            rogue_subtick(mousex, mousey);
        acase FUNC_KQ:                  kq_subtick(mousex, mousey);
        acase FUNC_PHANTASIE:           ph_subtick(mousex, mousey);
        acase FUNC_POLARWARE:        polar_subtick(mousex, mousey);
    }   }

    return 1;
}

EXPORT void InitHook(struct Hook* hook, ULONG (*func)(), void* data)
{   // Make sure a pointer was passed

    if (hook)
    {   // Fill in the Hook fields
        #ifdef __amigaos4__
            hook->h_Entry = func;
        #else
            hook->h_Entry = (ULONG (*)()) HookEntry;
        #endif
        hook->h_SubEntry  = func;
        hook->h_Data      = data;
    } else
    {   rq("Can't initialize hook!");
}   }

// Function to free an Exec List of ReAction ListBrowser nodes.
EXPORT void lb_clearlist(struct List* ListPtr)
{   /* Requirements: listbrowser class must be already open, and list
    must be detached from gadget. List may be empty or non-empty, and
    may be single- or multi-columnar. */

    if (ListIsFull(ListPtr))
    {   FreeListBrowserList(ListPtr);
    }
    NewList(ListPtr); // prepare for reuse
}

// Function to free an Exec List of ReAction SpeedBar nodes.
EXPORT void sb_clearlist(struct List* ListPtr)
{   struct Node *NodePtr,
                *NextNodePtr;

#ifdef __amigaos4__
    for (NodePtr = GetHead(ListPtr); NodePtr != NULL; NodePtr = NextNodePtr)
    {   NextNodePtr = GetSucc(NodePtr);
        FreeSpeedButtonNode(NodePtr);
    }
#else
    NodePtr = GetHead(ListPtr);
    while ((NextNodePtr = GetSucc(NodePtr)))
    {   FreeSpeedButtonNode(NodePtr);
        NodePtr = NextNodePtr;
    }
#endif

    NewList(ListPtr); // prepare for reuse
}

EXPORT void ch_clearlist(struct List* ListPtr)
{   struct Node *NodePtr,
                *NextNodePtr;

    /* Requirements: chooser class must be already open, and list
    must be detached from gadget. List may be empty or non-empty, and
    may be single- or multi-columnar. */

#ifdef __amigaos4__
    for (NodePtr = GetHead(ListPtr); NodePtr != NULL; NodePtr = NextNodePtr)
    {   NextNodePtr = GetSucc(NodePtr);
        FreeChooserNode(NodePtr);
    }
#else
    NodePtr = GetHead(ListPtr);
    while ((NextNodePtr = GetSucc(NodePtr)))
    {   FreeChooserNode(NodePtr);
        NodePtr = NextNodePtr;
    }
#endif

    NewList(ListPtr); // prepare for reuse
}

EXPORT void openwindow(int gid)
{
#ifndef __MORPHOS__
    MouseData = NULL;
#endif
    crosshair = FALSE;

    if (!(MainWindowPtr = (struct Window*) RA_OpenWindow(WinObject)))
    {   DisposeObject(WinObject);
        rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf("%d×%d\n", MainWindowPtr->Width, MainWindowPtr->Height);
#endif

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = 1 << AppPort->mp_SigBit;

    if (function == FUNC_MENU)
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,           NOSUB           ));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_REVERT,         NOSUB           ));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,           NOSUB           ));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,         NOSUB           ));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_TOOLBAR,        NOSUB           ));
    } else
    {    OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,           NOSUB           ));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_REVERT,         NOSUB           ));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,           NOSUB           ));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,         NOSUB           ));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_TOOLBAR,        NOSUB           ));
        settitle(FALSE);
    }
    OffMenu(    MainWindowPtr, FULLMENUNUM(MN_TOOLS  , funcinfo[function].itemnum, funcinfo[function].subnum));
    if (OpenURLBase || urlopen)
    {    OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP   , IN_FORMATS,        NOSUB           ));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP   , IN_FORMATS,        NOSUB           ));
    }
    if (guideexists && (!morphos || AmigaGuideBase))
    {    OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP   , IN_MANUAL,         NOSUB           ));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP   , IN_MANUAL,         NOSUB           ));
    }

    if (funcinfo[function].custompointer)
    {    OnMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_POINTER,        NOSUB           ));
    } else
    {   OffMenu(MainWindowPtr, FULLMENUNUM(MN_VIEW   , IN_POINTER,        NOSUB           ));
    }

#ifdef __amigaos4__
    if (os4menus)
    {   DISCARD SetAttrs
        (   (Object*) IDoMethod((Object*) MenuPtr, MM_FINDID, 0, FULLMENUNUM(MN_VIEW, IN_POINTER, NOSUB) + 1),
            MA_Selected, custompointer ? TRUE : FALSE,
        TAG_DONE);
        DISCARD SetAttrs
        (   (Object*) IDoMethod((Object*) MenuPtr, MM_FINDID, 0, FULLMENUNUM(MN_VIEW, IN_TOOLBAR, NOSUB) + 1),
            MA_Selected, showtoolbar ? TRUE : FALSE,
        TAG_DONE);
    } else
#endif
    {   ClearMenuStrip(MainWindowPtr);
        if (custompointer)
        {   ItemAddress(MenuPtr, FULLMENUNUM(MN_VIEW, IN_POINTER, NOSUB))->Flags |= CHECKED;
        } else
        {   ItemAddress(MenuPtr, FULLMENUNUM(MN_VIEW, IN_POINTER, NOSUB))->Flags &= ~(CHECKED);
        }
        if (showtoolbar)
        {   ItemAddress(MenuPtr, FULLMENUNUM(MN_VIEW, IN_TOOLBAR, NOSUB))->Flags |= CHECKED;
        } else
        {   ItemAddress(MenuPtr, FULLMENUNUM(MN_VIEW, IN_TOOLBAR, NOSUB))->Flags &= ~(CHECKED);
        }
        DISCARD ResetMenuStrip(MainWindowPtr, MenuPtr);
    }

    if (showtoolbar && gid != -1)
    {   DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            SPEEDBAR_Window, MainWindowPtr,
        TAG_DONE);
    }
    speedbar = gid;
}

EXPORT FLAG checkbreak(ULONG gid)
{   ULONG result;
    UWORD code;

    while ((result = DoMethod(WinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_RAWKEY:
            if (code == SCAN_ESCAPE)
            {   return TRUE;
            }
        acase WMHI_CLOSEWINDOW:
            return TRUE;
        acase WMHI_GADGETUP:
            if ((result & (WMHI_GADGETMASK)) == gid) // these parentheses are needed!
            {   return TRUE;
    }   }   }

    return FALSE;
}

EXPORT void lb_addnode(struct List* ListPtr, STRPTR text)
{   // This is only for single-column lists.

    struct ListBrowserNode* ListBrowserNodePtr;

    if (!(ListBrowserNodePtr = (struct ListBrowserNode*) AllocListBrowserNode
    (   1,                   // columns,
        LBNCA_CopyText,      TRUE,
        LBNCA_Text,          text,
        TAG_END
    )))
    {   rq("Can't create listbrowser.gadget node(s) (out of memory?)!");
    }
    AddTail(ListPtr, (struct Node*) ListBrowserNodePtr); // AddTail() has no return code
}

EXPORT void make_speedbar_list(int gid)
{   TRANSIENT ULONG i;
    PERSIST   FLAG  first = TRUE;

    if (!showtoolbar)
    {   return;
    }

    if (first)
    {   load_aiss_images(0, SBIMAGES - 1);

        NewList(&SpeedBarList);
        for (i = 0; i < SBGADGETS; i++)
        {   if
            ((  SpeedBarNodePtr[i] = (struct Node*)
                AllocSpeedButtonNode((UWORD) (i + 1), /* speed button ID */
                                     SBNA_Image,     aissimage[            i],
                                     SBNA_SelImage,  aissimage[SBGADGETS + i],
                                     SBNA_Enabled,   TRUE,
                                     SBNA_Spacing,   2,
                                     SBNA_Highlight, SBH_IMAGE,
                                     TAG_DONE)
            ))
            {   AddTail(&SpeedBarList, SpeedBarNodePtr[i]);
            } else
            {   rq("Can't allocate speedbar images (out of memory?)!");
        }   }

        first = FALSE;
    }

    for (i = 0; i < SBGADGETS; i++)
    {   thehintinfo[i].hi_GadgetID = gid;
    }
    HintInfoPtr = (struct HintInfo*) &thehintinfo;

    gadgets[gid] = (struct Gadget*)
    SpeedBarObject,
        GA_ID,               gid,
        GA_RelVerify,        TRUE,
        SPEEDBAR_Buttons,    &SpeedBarList,
        SPEEDBAR_StrumBar,   TRUE,         
        SPEEDBAR_BevelStyle, BVS_NONE,     
    SpeedBarEnd;
}

EXPORT void load_aiss_images(int thefirst, int thelast)
{   int  i;
    TEXT localpathname[MAX_PATH];

    for (i = thefirst; i <= thelast; i++)
    {   if (!image[i])
        {   goto DONE;
    }   }
    return;

DONE:
    SetAttrs(WinObject, WA_BusyPointer, TRUE, TAG_END);
    lockscreen();

    for (i = thefirst; i <= thelast; i++)
    {   if (!aissimage[i])
        {   strcpy(localpathname, "PROGDIR:images/aiss/");
            strcat(localpathname, aissname[i]);
            if (!(Exists(localpathname)))
            {   strcpy(localpathname, "TBImages:");
                strcat(localpathname, aissname[i]);
            }
            if (!(aissimage[i] = (struct Image*)
            BitMapObject,
                BITMAP_SourceFile,  localpathname,
                BITMAP_Screen,      ScreenPtr,
                BITMAP_Masking,     TRUE,
                BITMAP_Transparent, TRUE,
            End))
            {   rq("Can't create image(s) (missing or invalid files?)!");
    }   }   }

    unlockscreen();
    SetAttrs(WinObject, WA_BusyPointer, FALSE, TAG_END);
}

#ifndef __SASC
EXPORT int stcl_d(char* out, long lvalue)
{   if (lvalue < 0)
    {   out[0] = '-';
        return stcul_d(out + 1, (unsigned long int) abs((int) lvalue)) + 1;
    }
    return stcul_d(out, (unsigned long int) lvalue);
}

EXPORT int stcul_d(char* out, unsigned long lvalue)
{   ULONG calc,
          i,
          where   = 0;
    FLAG  started = FALSE;

    for (i = ONE_BILLION; i >= 1; i /= 10)
    {   calc = lvalue / i;
        assert(calc < 10);
        if (calc || started || i == 1)
        {   *(out + where) = (char) ('0' + calc);
            where++;
            started = TRUE;
        }
        lvalue %= i;
    }

    *(out + where) = EOS;
    return (int) where;
}

EXPORT int stcl_h(char* out, long lvalue)
{   ULONG calc,
          i,
          where   = 0;
    FLAG  started = FALSE;
    ULONG uvalue  = (ULONG) lvalue;

    for (i = 0x10000000; i >= 1; i /= 16)
    {   calc = uvalue / i;
        assert(calc < 16);
        if (calc || started || i == 1)
        {   if (calc <= 9)
            {   *(out + where) = (char) ('0' + calc);
            } else
            {   *(out + where) = (char) ('A' + calc - 10);
            }
            where++;
            started = TRUE;
        }
        uvalue %= i;
    }

    *(out + where) = EOS;
    return (int) where;
}
#endif

EXPORT FLAG Exists(STRPTR name)
{   struct Process* self = (APTR) FindTask(NULL);
    APTR            oldwinptr;
    BPTR            lock;

    oldwinptr = self->pr_WindowPtr;
    self->pr_WindowPtr = (APTR) -1;

    lock = Lock(name, ACCESS_READ);

    self->pr_WindowPtr = oldwinptr;

    if (lock)
    {   UnLock(lock);
        return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void iconify(void)
{   UWORD                  code;
    ULONG                  result;
    struct AppMessage*     AppMsg;
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
        reopen = TRUE;
    }

    DISCARD RA_Iconify(WinObject);
    // the WinObject must stay a valid pointer
    MainWindowPtr = NULL;

#ifndef __MORPHOS__
    if (changedcolours)
    {   changedcolours = FALSE;
        lockscreen();
        SetRGB4(&(ScreenPtr->ViewPort), 17, (colour17 & 0x00000F00) >> 8, (colour17 & 0x000000F0) >> 4, colour17 & 0x0000000F);
        SetRGB4(&(ScreenPtr->ViewPort), 18, (colour18 & 0x00000F00) >> 8, (colour18 & 0x000000F0) >> 4, colour18 & 0x0000000F);
        SetRGB4(&(ScreenPtr->ViewPort), 19, (colour19 & 0x00000F00) >> 8, (colour19 & 0x000000F0) >> 4, colour19 & 0x0000000F);
        unlockscreen();
    }
#endif

    // DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit);

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
                /* The lock will be on the directory in which the file
                   resides. If there is no filename, either a volume or
                   window was dropped on us.
                     Note that AMTYPE_APPICON messages are generated even
                   for ordinary uniconify double-clicks, not just drag
                   and drop. */

                ArgPtr = AppMsg->am_ArgList;
                uniconify();
                if
                (   AppMsg->am_NumArgs == 1
                 && ArgPtr->wa_Name[0]
                 && ArgPtr->wa_Lock
                )
                {   if
                    (   function != FUNC_MENU
                     && NameFromLock(ArgPtr->wa_Lock, filename, MAX_PATH)
                     && AddPart(filename, ArgPtr->wa_Name, MAX_PATH)
                    )
                    {   project_open(FALSE);
        }   }   }   }

#ifdef __amigaos4__
        if (AppLibPort)
        {   while ((AppLibMsg = (struct ApplicationMsg*) GetMsg(AppLibPort)))
            {   msgtype = AppLibMsg->type;
                msgval  = (ULONG) ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName;
                ReplyMsg((struct Message *) AppLibMsg);

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
                    if (function == FUNC_MENU)
                    {   DisplayBeep(NULL);
                    } else
                    {   uniconify();
                        strcpy(filename, ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName);
                        project_open(FALSE);
                        lockscreen();
                        // we should really only do this if successfully loaded
                        ScreenToFront(ScreenPtr);
                        unlockscreen();
                        // assert(MainWindowPtr);
                        WindowToFront(MainWindowPtr);
                        ActivateWindow(MainWindowPtr);
        }   }   }   }
#endif

        if (!MainWindowPtr)
        {   while ((result = RA_HandleInput(WinObject, &code)) != WMHI_LASTMSG)
            {   switch (result & WMHI_CLASSMASK)
                {
                case WMHI_UNICONIFY:
                    uniconify();
    }   }   }   }
    while (!MainWindowPtr);
}
MODULE void uniconify(void)
{   // assert(!MainWindowPtr);

    if (!(MainWindowPtr = (struct Window*) RA_Uniconify(WinObject)))
    {   rq("Can't reopen window!");
    }
    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);

    switch (function)
    {
    case  FUNC_ARAZOK:     arazok_uniconify();
    acase FUNC_BT:             bt_uniconify();
    acase FUNC_BOMBJACK:       bj_uniconify();
    acase FUNC_COV:           cov_uniconify();
    acase FUNC_CSD:           csd_uniconify();
    acase FUNC_CE:             ce_uniconify();
    acase FUNC_DW:             dw_uniconify();
    acase FUNC_DRUID2:     druid2_uniconify();
    acase FUNC_DM:             dm_uniconify();
    acase FUNC_FA18:         fa18_uniconify();
    acase FUNC_FTA:           fta_uniconify();
    acase FUNC_SS:             ss_uniconify();
    acase FUNC_GARRISON:      gar_uniconify();
    acase FUNC_GOAL:         goal_uniconify();
    acase FUNC_ROGUE:       rogue_uniconify();
    acase FUNC_HILLSFAR:       hf_uniconify();
    acase FUNC_ICFTD:       icftd_uniconify();
    acase FUNC_IF:             if_uniconify();
    acase FUNC_KQ:             kq_uniconify();
    acase FUNC_MERCENARY:    merc_uniconify();
    acase FUNC_POLARWARE:   polar_uniconify();
    acase FUNC_PIRATES:       pir_uniconify();
    acase FUNC_QUADRALIEN:     qa_uniconify();
    acase FUNC_Q2:             q2_uniconify();
    acase FUNC_RAGNAROK:      lor_uniconify();
    acase FUNC_ROBIN:       robin_uniconify();
    acase FUNC_ROCKFORD:       rf_uniconify();
    acase FUNC_RORKE:       rorke_uniconify();
    acase FUNC_SIDEWINDER:     sw_uniconify();
    acase FUNC_SINBAD:         sb_uniconify();
    acase FUNC_SLAYGON:       sla_uniconify();
    acase FUNC_TOL:           tol_uniconify();
    acase FUNC_TVS:           tvs_uniconify();
    acase FUNC_ULTIMA:     ultima_uniconify();
    acase FUNC_WIME:         wime_uniconify();
    acase FUNC_ZERG:         zerg_uniconify();
    }

    if (reopen)
    {   reopen = FALSE;
        help_about();
        ActivateWindow(MainWindowPtr);
}   }

EXPORT UBYTE getubyte(void)
{   UBYTE value;

    value = IOBuffer[offset];
    offset++;
    return value;
}
EXPORT SBYTE getsbyte(void)
{   SBYTE value;

    value = (SBYTE) IOBuffer[offset];
    offset++;
    return value;
}
EXPORT UWORD getuword(void)
{   UWORD value;

    value = (IOBuffer[offset    ] * 256) +
             IOBuffer[offset + 1];
    offset += 2;
    return value;
}
EXPORT SWORD getiword(void)
{   SWORD value;

    value = (            IOBuffer[offset]
           +      (256 * IOBuffer[offset + 1])
            );
    offset += 2;
    return value;
}
EXPORT ULONG getulong(void)
{   ULONG value;

    value =  (IOBuffer[offset    ] * 16777216)
          +  (IOBuffer[offset + 1] *    65536)
          +  (IOBuffer[offset + 2] *      256)
          +   IOBuffer[offset + 3];
    offset += 4;
    return value;
}
EXPORT SLONG getilong(void)
{   SLONG value;

    value = (            IOBuffer[offset]
           + (     256 * IOBuffer[offset + 1])
           + (   65536 * IOBuffer[offset + 2])
           + (16777216 * IOBuffer[offset + 3])
            );
    offset += 4;
    return value;
}
EXPORT void serialize2uword(UWORD* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = getuword();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) (*(thevar) / 256);
        IOBuffer[offset++] = (UBYTE) (*(thevar) % 256);
}   }
EXPORT void serialize2ulong(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = (ULONG) getuword();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) (*(thevar) / 256);
        IOBuffer[offset++] = (UBYTE) (*(thevar) % 256);
}   }
EXPORT void serialize2iword(UWORD* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = getiword();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) (*(thevar) % 256);
        IOBuffer[offset++] = (UBYTE) (*(thevar) / 256);
}   }
EXPORT void serialize2ilong(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = (ULONG) getiword();
     // printf("Read little-endian word $%X at offset $%X!\n", *(thevar), offset - 2);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) (*(thevar) % 256);
        IOBuffer[offset++] = (UBYTE) (*(thevar) / 256);
     // printf("Wrote little-endian word $%X at offset $%X!\n", *(thevar), offset - 2);
}   }
EXPORT void serialize4(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = getulong();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) ( *(thevar) / 16777216         );
        IOBuffer[offset++] = (UBYTE) ((*(thevar) % 16777216) / 65536);
        IOBuffer[offset++] = (UBYTE) ((*(thevar) %    65536) /   256);
        IOBuffer[offset++] = (UBYTE) ( *(thevar) %      256         );
}   }
EXPORT void serialize4i(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *(thevar) = getilong();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = (UBYTE) ( *(thevar) %      256         );
        IOBuffer[offset++] = (UBYTE) ((*(thevar) %    65536) /   256);
        IOBuffer[offset++] = (UBYTE) ((*(thevar) % 16777216) / 65536);
        IOBuffer[offset++] = (UBYTE) ( *(thevar) / 16777216         );
}   }

EXPORT FLAG confirm(void)
{   EasyStruct.es_TextFormat   = (STRPTR) "Are you sure?";
    EasyStruct.es_Title        = (STRPTR) "MCE: Question";
    EasyStruct.es_GadgetFormat = (STRPTR) "Yes|No";
    if (EasyRequest(MainWindowPtr, &EasyStruct, NULL) != 0)
    {   return TRUE;
    } // implied else
    return FALSE;
}
EXPORT int ask(STRPTR question, STRPTR answers)
{   LONG rc;

    EasyStruct.es_TextFormat   = question;
    EasyStruct.es_Title        = (STRPTR) "MCE: Question";
    EasyStruct.es_GadgetFormat = answers;
    rc = EasyRequest(MainWindowPtr, &EasyStruct, NULL);
    return rc ? 0 : 1;
}

EXPORT BPTR LockQuiet(const char* name, LONG mode)
{   struct Process* self = (APTR) FindTask(NULL);
    APTR            oldwinptr;
    BPTR            lock;

    oldwinptr = self->pr_WindowPtr;
    self->pr_WindowPtr = (APTR) -1;

    lock = Lock(name, mode);

    self->pr_WindowPtr = oldwinptr;

    return lock;
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

EXPORT void serialize1to1(UBYTE* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   (*thevar) = getubyte();
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = *(thevar);
}   }
EXPORT void serialize1(ULONG* thevar)
{   UBYTE temp;

    if (serializemode == SERIALIZE_READ)
    {   temp = getubyte();
        (*thevar) = (ULONG) temp;
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        temp = (UBYTE) (*thevar);
        IOBuffer[offset++] = temp;
}   }
EXPORT void serialize1s(SLONG* thevar)
{   SBYTE temp;

    if (serializemode == SERIALIZE_READ)
    {   temp = getsbyte();
        (*thevar) = (SLONG) temp;
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        temp = (SBYTE) (*thevar);
        IOBuffer[offset++] = (UBYTE) temp;
}   }

EXPORT void serstring(STRPTR thestring)
{   if (serializemode == SERIALIZE_READ)
    {   strcpy(thestring, (char*) &IOBuffer[offset]);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset], thestring);
    }

    // Note that it doesn't adjust the offset.
    // Also it relies on the NUL terminator being present.
}

EXPORT void serialize_bcd1(ULONG* thevar)
{   UBYTE temp;

    if (serializemode == SERIALIZE_READ)
    {   temp = getubyte();
        (*thevar) = (ULONG) (
          (((temp & 0xF0) >> 4) * 10)
        +   (temp & 0x0F)            );
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        temp = (UBYTE) (
        (((*thevar) / 10) << 4)
      |  ((*thevar) % 10)      );
        IOBuffer[offset++] = temp;
}   }

EXPORT void serialize_bcd2(ULONG* thevar)
{   UWORD temp;

    if (serializemode == SERIALIZE_READ)
    {   temp = getuword();
        (*thevar) = (ULONG) (
          (((temp & 0xF000) >> 12) * 1000)
        + (((temp & 0x0F00) >>  8) *  100)
        + (((temp & 0x00F0) >>  4) *   10)
        +   (temp & 0x000F)               );
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        temp = (UWORD) (
         (((*thevar) / 1000)        << 12)
      | ((((*thevar) % 1000) / 100) <<  8)
      | ((((*thevar) %  100) /  10) <<  4)
      |   ((*thevar) %   10)              );
        IOBuffer[offset++] = (UBYTE) (temp / 256);
        IOBuffer[offset++] = (UBYTE) (temp % 256);
}   }

EXPORT void serialize_bcd3(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *thevar = (((IOBuffer[offset    ] & 0xF0) >> 4) *     100000)
                + ( (IOBuffer[offset    ] & 0x0F)       *      10000)
                + (((IOBuffer[offset + 1] & 0xF0) >> 4) *       1000)
                + ( (IOBuffer[offset + 1] & 0x0F)       *        100)
                + (((IOBuffer[offset + 2] & 0xF0) >> 4) *         10)
                +   (IOBuffer[offset + 2] & 0x0F);
        offset += 3;
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = ((((*thevar) % 1000000) / 100000) << 4)
                           |  (((*thevar) %  100000) /  10000);
        IOBuffer[offset++] = ((((*thevar) %   10000) /   1000) << 4)
                           |  (((*thevar) %    1000) /    100);
        IOBuffer[offset++] = ((((*thevar) %     100) /     10) << 4)
                           |   ((*thevar) %      10)          ;
}   }

EXPORT void serialize_bcd4(ULONG* thevar)
{   if (serializemode == SERIALIZE_READ)
    {   *thevar = (((IOBuffer[offset    ] & 0xF0) >> 4) *   10000000)
                + ( (IOBuffer[offset    ] & 0x0F)       *    1000000)
                + (((IOBuffer[offset + 1] & 0xF0) >> 4) *     100000)
                + ( (IOBuffer[offset + 1] & 0x0F)       *      10000)
                + (((IOBuffer[offset + 2] & 0xF0) >> 4) *       1000)
                + ( (IOBuffer[offset + 2] & 0x0F)       *        100)
                + (((IOBuffer[offset + 3] & 0xF0) >> 4) *         10)
                + ( (IOBuffer[offset + 3] & 0x0F)                   );
        offset += 4;
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[offset++] = ((((*thevar) % 100000000) / 10000000) << 4)
                           |  (((*thevar) %  10000000) /  1000000);
        IOBuffer[offset++] = ((((*thevar) %   1000000) /   100000) << 4)
                           |  (((*thevar) %    100000) /    10000);
        IOBuffer[offset++] = ((((*thevar) %     10000) /     1000) << 4)
                           |  (((*thevar) %      1000) /      100);
        IOBuffer[offset++] = ((((*thevar) %       100) /       10) << 4)
                           |   ((*thevar) %        10)            ;
}   }

MODULE void settitle(FLAG subwin)
{   strcpy(titlebartext, funcinfo[function].shortname);
    if (funcinfo[function].kind)
    {   addtype(funcinfo[function].kind, titlebartext, TRUE);
        strcat(titlebartext, (char*) FilePart(pathname));
    }
    if (subwin)
    {   strcat(titlebartext, " (close subwindow)");
    }
    if (WinObject)
    {   DISCARD SetAttrs((Object*) WinObject, WA_Title, titlebartext, TAG_DONE);
        // Must use SetAttrs(WA_Title) rather than SetWindowTitles(), so
        // that ReAction gives it the correct title after uniconifying it
}   }

EXPORT void either_in(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            INTEGER_Number, *(var),
        TAG_END); // this autorefreshes
}   }

EXPORT void either_pl(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(PALETTE_Colour, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            PALETTE_Colour, *(var),
        TAG_END); // this autorefreshes
}   }

EXPORT void either_st(int gid, STRPTR thestring)
{   STRPTR stringptr;

    if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(STRINGA_TextVal, (Object*) gadgets[gid], (ULONG*) &stringptr);
        strcpy(thestring, stringptr);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            STRINGA_TextVal, thestring,
        TAG_END); // this autorefreshes
}   }

EXPORT void either_cb(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(GA_Selected, (Object*) gadgets[gid], var);
        if (*(var))
        {   *(var) = 1;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            GA_Selected, *(var) ? TRUE : FALSE,
        TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL);
}   }

EXPORT void subeither_cb(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(GA_Selected, (Object*) gadgets[gid], var);
        if (*(var))
        {   *(var) = 1;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], SubWindowPtr, NULL,
            GA_Selected, *(var) ? TRUE : FALSE,
        TAG_END);
        RefreshGadgets((struct Gadget *) gadgets[gid], SubWindowPtr, NULL);
}   }

EXPORT void either_ch(int gid, ULONG* var)
{   ULONG theulong;

    if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        theulong = *var;
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            CHOOSER_Selected, (WORD) theulong,
        TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL);
}   }

EXPORT void either_ra(int gid, ULONG* var)
{   ULONG theulong;

    if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        theulong = *var;
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            RADIOBUTTON_Selected, (WORD) theulong,
        TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL);
}   }

EXPORT void write_ra(int gid, ULONG theulong)
{   DISCARD SetGadgetAttrs
    (   gadgets[gid], MainWindowPtr, NULL,
        RADIOBUTTON_Selected, (WORD) theulong,
    TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL);
}

EXPORT void either_sl(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(SLIDER_Level, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            SLIDER_Level, *(var),
        TAG_END); // this autorefreshes
}   }

EXPORT void either_gs(int gid, ULONG* var)
{   if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(GRAD_CurVal, (Object*) gadgets[gid], var);
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], MainWindowPtr, NULL,
            GRAD_CurVal, *(var),
        TAG_END); // this autorefreshes
}   }

EXPORT void subloop(void)
{   ULONG LocalSignal;
    UWORD code;
    ULONG event,
          result;

    settitle(TRUE);

    if (funcinfo[function].custompointer)
    {   setpointer(FALSE, SubWinObject, SubWindowPtr, TRUE);
    }

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, SubWinObject, (ULONG*) &LocalSignal);

    globaldone = FALSE;
    while (!globaldone)
    {   DISCARD Wait(LocalSignal);
        while ((result = DoMethod(SubWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   event = result & WMHI_CLASSMASK;
            switch (event)
            {
            case WMHI_CLOSEWINDOW:
                globaldone = TRUE;
            acase WMHI_GADGETUP:
                if (tool_subgadget(result & WMHI_GADGETMASK, code))
                {   globaldone = TRUE;
    }   }   }   }

    settitle(FALSE);
    clearkybd();
}

EXPORT void lb_makelist(struct List* ListPtr, const STRPTR* NamesArray, int elements)
{   int          i;
    struct Node* ListBrowserNodePtr;

    NewList(ListPtr);
    for (i = 0; i < elements; i++)
    {   if (!(ListBrowserNodePtr = (struct Node*) AllocListBrowserNode
        (   1,              /* columns, */
            LBNA_Column,    0,
            LBNCA_CopyText, TRUE,
            LBNCA_Text,     NamesArray[i],
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(ListPtr, ListBrowserNodePtr); /* AddTail() has no return code */
}   }

EXPORT void lb_makechecklist(struct List* ListPtr, const STRPTR* NamesArray, int elements)
{   int          i;
    struct Node* ListBrowserNodePtr;

    NewList(ListPtr);
    for (i = 0; i < elements; i++)
    {   if (!(ListBrowserNodePtr = (struct Node*) AllocListBrowserNode
        (   1,              /* columns, */
            LBNA_CheckBox,  TRUE,
            LBNA_Column,    0,
            LBNCA_CopyText, TRUE, // probably not needed
            LBNCA_Text,     NamesArray[i],
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(ListPtr, ListBrowserNodePtr); /* AddTail() has no return code */
}   }

EXPORT void load_fimage(int which)
{   PERSIST TEXT theimagename[MAX_PATH + 1];

    if (fimage[which])
    {   return;
    } // implied else

    lockscreen();

    strcpy(theimagename, "PROGDIR:images/games/");
    strcat(theimagename, funcinfo[which].fimagename);
    strcat(theimagename, ".iff");
    if (!(fimage[which] = (struct Image*)
    BitMapObject,
        IA_Left,           0,
        IA_Top,            0,
        IA_Width,          120,
        IA_Height,         96,
        BITMAP_SourceFile, theimagename,
        BITMAP_Screen,     ScreenPtr,
    End))
    {   unlockscreen();
        rq("Can't create image(s)!");
    }

    unlockscreen();
}

MODULE void load_fimages(FLAG startup)
{   TRANSIENT     int    i;
    PERSIST       TEXT   theimagename[MAX_PATH + 1];
#ifdef __amigaos4__
    PERSIST CONST STRPTR menuimagename[OS4IMAGES] = {
"open",    // 0
"reload",  // 1 revert
"save",    // 2
"saveas",  // 3
"iconify", // 4
"quit",    // 5
"help",    // 6 manual
"info",    // 7 about
"update",  // 8 update
"toolbar", // 9
};
#endif

    // assert(!loaded_fimages);

    lockscreen();
    SplashWinObject =
    WindowObject,
        WA_PubScreen,                     ScreenPtr,
        WA_ScreenTitle,                   "MCE " DECIMALVERSION,
        WA_Title,                         "MCE " DECIMALVERSION,
        WA_DragBar,                       TRUE,
        WA_DepthGadget,                   TRUE,
        WA_Width,                         256,
        WINDOW_Position,                  WPOS_CENTERSCREEN,
        WINDOW_FrontBack,                 WT_FRONT,
        WINDOW_ParentGroup,               gadgets[GID_0_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_AddChild,              gadgets[GID_0_FG1] = (struct Gadget*)
            FuelGaugeObject,
                GA_ID,                    GID_0_FG1,
                GA_Text,                  "Loading...",
                FUELGAUGE_Min,            0,
#ifdef __amigaos4__
                FUELGAUGE_Max,            FUNCTIONS + 1 + (os4menus ? OS4IMAGES : 0),
#else
                FUELGAUGE_Max,            FUNCTIONS + 1,
#endif
                FUELGAUGE_Level,          0,
                FUELGAUGE_Percent,        FALSE,
                FUELGAUGE_Justification,  FGJ_CENTER,
                FUELGAUGE_TickSize,       0,
                FUELGAUGE_Ticks,          0,
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

    lockscreen();
    for (i = 1; i <= FUNCTIONS; i++)
    {   strcpy(theimagename, "PROGDIR:images/games/");
        strcat(theimagename, funcinfo[i].fimagename);
        strcat(theimagename, ".iff");
        if (!(menufimage[i] = (struct Image*)
        BitMapObject,
            BITMAP_SourceFile, theimagename,
            BITMAP_Screen,     ScreenPtr,
        End))
        {   unlockscreen();
            rq("Can't load image(s)!");
        }
        DISCARD SetGadgetAttrs
        (   gadgets[GID_0_FG1], SplashWindowPtr, NULL,
            FUELGAUGE_Level,   i + 1,
        TAG_END); // this autorefreshes
    }

#ifdef __amigaos4__
    if (os4menus && startup)
    {   for (i = 0; i < OS4IMAGES; i++)
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
            {   rq("Can't create image(s)!");
            }
            DISCARD SetGadgetAttrs
            (   gadgets[GID_0_FG1], SplashWindowPtr, NULL,
                FUELGAUGE_Level,    FUNCTIONS + i + 1,
            TAG_END); // this autorefreshes
    }   }
#endif

    unlockscreen();

    DisposeObject(SplashWinObject);
    SplashWinObject = NULL;
    SplashWindowPtr = NULL;

    loaded_fimages = TRUE;
}

EXPORT void project_open(FLAG loadas)
{   if (function == FUNC_MENU)
    {   DisplayBeep(NULL);
    } else
    {   DISCARD tool_open(loadas);
}   }

EXPORT FLAG gameopen(FLAG loadas)
{   BPTR  FileHandle /* = ZERO */ ;
    TEXT  tempstring[80 + 1];
    LONG  size;
    char* thefilepart;

    if (loadas && !cliname)
    {   if (pathname[0])
        {   strcpy(aslfile, FilePart(pathname));
        } elif (funcinfo[function].defaultfile[0])
        {   strcpy(aslfile, funcinfo[function].defaultfile);
        }
        strcpy(tempstring, "Load ");
        strcat(tempstring, funcinfo[function].shortname);
        addtype(funcinfo[function].kind, tempstring, FALSE);

        if (!(asl(tempstring, funcinfo[function].pattern, FALSE)))
        {   return FALSE;
        } // implied else
        strcpy(pathname, aslresult);
    }
    cliname = FALSE;

#ifdef VERBOSE
    printf("Loading \"%s\"...\n", pathname);
#endif

    if (!Exists(pathname))
    {   say("File doesn't exist!", REQIMAGE_WARNING);
        return FALSE;
    }
    thefilepart = (char*) FilePart(pathname);
    if (thefilepart[0] == EOS)
    {   say("No file specified!", REQIMAGE_WARNING);
        return FALSE;
    }

    size = getsize(pathname);
    if (size > IOBUFFERSIZE || (funcinfo[function].filesize && size != funcinfo[function].filesize))
    {   say("File is the wrong size!", REQIMAGE_WARNING);
        return FALSE;
    } // implied else
    gamesize = size;

    if (function == FUNC_LOF)
    {   return TRUE;
    } // implied else

    if (!(FileHandle = (BPTR) Open(pathname, MODE_OLDFILE)))
    {   say("Can't open file!", REQIMAGE_WARNING);
        return FALSE;
    } // implied else

    if (Read(FileHandle, IOBuffer, (LONG) size) != size)
    {   DISCARD Close(FileHandle);
        // FileHandle = ZERO;
        say("Can't read file!", REQIMAGE_WARNING);
        return FALSE;
    } // implied else

    DISCARD Close(FileHandle);
    // FileHandle = ZERO;

    settitle(FALSE);

    return TRUE;
}

EXPORT FLAG gamesave(STRPTR pattern, STRPTR gamename, FLAG saveas, LONG goodsize, int kind, FLAG quiet)
{   TEXT tempstring[80 + 1];
    FLAG ok = FALSE;
    int  length;

    if (!pathname[0] || saveas) // if we need a filename
    {   if (pathname[0])
        {   strcpy(aslfile, FilePart(pathname));
        } else
        {   aslfile[0] = EOS;
        }
        strcpy(tempstring, "Save ");
        strcat(tempstring, gamename);
        addtype(kind, tempstring, FALSE);
        if (asl(tempstring, pattern, TRUE))
        {   if (aslresult[0])
            {   strcpy(pathname, aslresult);
                ok = TRUE;
    }   }   }
    else
    {   ok = TRUE;
    }

    if (!ok || function == FUNC_LOF)
    {   return FALSE;
    } // implied else

    if (function == FUNC_ARAZOK)
    {   length = strlen(pathname);
        if (length < 5 || stricmp(&pathname[length - 4], ".GAM"))
        {   strcat(pathname, ".GAM");
    }   }

    writeout(pathname, goodsize);
    settitle(FALSE);
    if (!quiet)
    {   say("Saved file.", REQIMAGE_INFO);
    }

    return TRUE;
}

EXPORT struct List* getlist(int gad)
{   ULONG ListPtr;

    DISCARD GetAttr
    (   LISTBROWSER_Labels, (Object*) gadgets[gad],
        &ListPtr
    );

    return (struct List*) ListPtr;
}
EXPORT void detach(int gad)
{   DISCARD SetGadgetAttrs
    (   gadgets[gad],
        MainWindowPtr,
        NULL,
        LISTBROWSER_Labels, ~0,
    TAG_END);
}
EXPORT void reattach(int gad, struct List* ListPtr)
{   DISCARD SetGadgetAttrs
    (   gadgets[gad], MainWindowPtr, NULL,
        LISTBROWSER_Labels, ListPtr,
    TAG_END);
}
EXPORT void lb_select(int gad, ULONG value) // select() is reserved under OS4
{   DISCARD SetGadgetAttrs
    (   gadgets[gad], MainWindowPtr, NULL,
        LISTBROWSER_Selected, value,
    TAG_END);
    DISCARD SetGadgetAttrs
    (   gadgets[gad], MainWindowPtr, NULL,
        LISTBROWSER_MakeVisible, value,
    TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[gad], MainWindowPtr, NULL);
}

MODULE void changepage(void)
{   // assert(functab != newpage);

    functab = newpage;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_0_CT1],
        MainWindowPtr,    NULL,
        CLICKTAB_Current, functab,
    TAG_DONE);

/* This is not needed since CT1 and PA1 are linked...
    DISCARD SetGadgetAttrs
    (   gadgets[GID_0_PA1],
        MainWindowPtr,    NULL,
        PAGE_Current,     functab,
    TAG_DONE); */

    DISCARD RethinkLayout(gadgets[GID_0_LY1], MainWindowPtr, NULL, TRUE);
}

EXPORT ULONG getsize(STRPTR filename)
{   BPTR                  FileHandle /* = ZERO */ ;
    ULONG                 size;
#ifdef __amigaos4__
    int64                 filesize;
#else
    struct FileInfoBlock* FIBPtr;
#endif

#ifdef __amigaos4__
    if (!(FileHandle = (BPTR) Open(filename, MODE_OLDFILE)))
    {   return 0;
    }
    filesize = GetFileSize(FileHandle);
    if (filesize == -1LL)
    {   size = 0;
    } else
    {   size = (ULONG) filesize;
    }
    Close(FileHandle);
    // FileHandle = NULL;
#else
    if (!(FileHandle = (BPTR) Lock(filename, ACCESS_READ)))
    {   return 0;
    }
    if (!(FIBPtr = (struct FileInfoBlock*) AllocDosObject(DOS_FIB, NULL)))
    {   UnLock(FileHandle);
        // FileHandle = NULL;
        return 0;
    }
    if (!(Examine(FileHandle, FIBPtr)))
    {   FreeDosObject(DOS_FIB, FIBPtr);
        // FIBPtr = NULL;
        UnLock(FileHandle);
        // FileHandle = NULL;
        return 0;
    }
    size = (ULONG) FIBPtr->fib_Size;
    FreeDosObject(DOS_FIB, FIBPtr);
    // FIBPtr = NULL;
    UnLock(FileHandle);
    // FileHandle = NULL;
#endif

    return size;
}

EXPORT void vi_scroll_left(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = (ULONG) -5000;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp = (ULONG)  -100;
    } else
    {   lbp = (ULONG)   -10;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        VIRTUALA_ScrollX, lbp,
    TAG_END);
}
EXPORT void vi_scroll_right(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = 5000;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp =  100;
    } else
    {   lbp =   10;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        VIRTUALA_ScrollX, lbp,
    TAG_END);
}
EXPORT void vi_scroll_up(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = (ULONG) -5000;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp = (ULONG)  -100;
    } else
    {   lbp = (ULONG)   -10;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        VIRTUALA_ScrollY, lbp,
    TAG_END);
}
EXPORT void vi_scroll_down(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = 5000;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp =  100;
    } else
    {   lbp =   10;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        VIRTUALA_ScrollY, lbp,
    TAG_END);
}

EXPORT void lb_scroll_up(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = LBP_TOP;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp = LBP_PAGEUP;
    } else
    {   lbp = LBP_LINEUP;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        LISTBROWSER_Position, lbp,
    TAG_END);
}
EXPORT void lb_scroll_down(int gid, struct Window* WindowPtr, UWORD qual)
{   ULONG lbp;

    // assert(WindowPtr);

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   lbp = LBP_BOTTOM;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   lbp = LBP_PAGEDOWN;
    } else
    {   lbp = LBP_LINEDOWN;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[gid], WindowPtr, NULL,
        LISTBROWSER_Position, lbp,
    TAG_END);
}

EXPORT FLAG lb_move_up(int gid, struct Window* WindowPtr, UWORD qual, ULONG* thevar, ULONG min, int jump)
{   ULONG newvar;

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   newvar = min;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   if (*(thevar) < (ULONG) jump) // to avoid underflow
        {   newvar = 0;
        } else
        {   newvar = *(thevar) - jump;
        }
    } else
    {   if (*(thevar) < 1) // to avoid underflow
        {   newvar = 0;
        } else
        {   newvar = *(thevar) - 1;
    }   }
    if (newvar < min)
    {   newvar = min;
    }

    if (newvar != *(thevar))
    {   *(thevar) = newvar;
        DISCARD SetGadgetAttrs
        (   gadgets[gid], WindowPtr, NULL,
            LISTBROWSER_Selected, (ULONG) (*thevar),
        TAG_END);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], WindowPtr, NULL,
            LISTBROWSER_MakeVisible, (ULONG) (*thevar),
        TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[gid], WindowPtr, NULL);
        return TRUE;
    } // implied else

    return FALSE;
}

EXPORT FLAG lb_move_down(int gid, struct Window* WindowPtr, UWORD qual, ULONG* thevar, ULONG max, int jump)
{   ULONG newvar;

    if
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   newvar = max;
    } elif
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   newvar = *(thevar) + jump;
    } else
    {   newvar = *(thevar) + 1;
    }
    if (newvar > max)
    {   newvar = max;
    }

    if (newvar != *(thevar))
    {   *(thevar) = newvar;
        DISCARD SetGadgetAttrs
        (   gadgets[gid], WindowPtr, NULL,
            LISTBROWSER_Selected, (ULONG) (*thevar),
        TAG_END);
        DISCARD SetGadgetAttrs
        (   gadgets[gid], WindowPtr, NULL,
            LISTBROWSER_MakeVisible, (ULONG) (*thevar),
        TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[gid], WindowPtr, NULL);
        return TRUE;
    } // implied else

    return FALSE;
}

EXPORT void move_leftorup(UWORD qual, int* thevar, int unit, int jump)
{   if
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   *(thevar) = 0;
    } elif
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   if (*(thevar) > jump)
        {   *(thevar) -= jump;
        } else
        {   *(thevar) = 0;
    }   }
    elif (*(thevar) > unit)
    {   (*thevar) -= unit;
    } else
    {   (*thevar) = 0;
}   }
EXPORT void move_rightordown(UWORD qual, int* thevar, int unit, int jump, ULONG max)
{   if
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   *(thevar) = max;
    } elif
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   if (*(thevar) < (int) (max - jump))
        {   *(thevar) += jump;
        } else
        {   *(thevar) = max;
    }   }
    elif (*(thevar) < (int) max - unit)
    {   (*thevar) += unit;
    } else
    {   (*thevar) = max;
}   }

MODULE void addtype(int kind, STRPTR thestring, FLAG editor)
{   FLAG added = FALSE;

    strcat(thestring, " ");

    if (kind & FLAG_A) {                                    strcat(thestring, "Army"       ); added = TRUE; }
    if (kind & FLAG_C) { if (added) strcat(thestring, "/"); strcat(thestring, "Character"  ); added = TRUE; }
    if (kind & FLAG_G) { if (added) strcat(thestring, "/"); strcat(thestring, "Graphics"   ); added = TRUE; }
    if (kind & FLAG_H) { if (added) strcat(thestring, "/"); strcat(thestring, "High Scores"); added = TRUE; }
    if (kind & FLAG_I) { if (added) strcat(thestring, "/"); strcat(thestring, "Items"      ); added = TRUE; }
    if (kind & FLAG_L) { if (added) strcat(thestring, "/"); strcat(thestring, "Level"      ); added = TRUE; }
    if (kind & FLAG_R) { if (added) strcat(thestring, "/"); strcat(thestring, "Roster"     ); added = TRUE; }
    if (kind & FLAG_S) { if (added) strcat(thestring, "/"); strcat(thestring, "Saved Game" );               }

    if (editor)
    {   strcat(thestring, " Editor: ");
}   }

MODULE void help_update(void)
{   double             oldver,
                       newver;
    STRPTR             message;
    int                hSocket = -1,
                       i, j,
                       length;
    char               ip[15 + 1]; // enough for "208.115.246.164"
    TEXT               tempstring[80 + 1];
    struct sockaddr_in INetSocketAddr;
#ifndef __amigaos4__
    struct hostent*    HostAddr;
    struct in_addr**   addr_list;
#endif

    DISCARD SetAttrs(WinObject, WA_BusyPointer, TRUE, TAG_END);
    if (!(SocketBase = OpenLibrary("bsdsocket.library", 0)))
    {   say("Can't open bsdsocket.library!", REQIMAGE_WARNING);
        goto DONE;
    }
#ifdef __amigaos4__
    if (!(ISocket = (struct SocketIFace*) GetInterface((struct Library*) SocketBase,  "main", 1, NULL)))
    {   say("Can't get bsdsocket.library interface!", REQIMAGE_WARNING);
        goto DONE;
    }

    strcpy(ip, "216.245.218.214"); // was 208.115.246.164
#else
    if ((HostAddr = gethostbyname("amigan.1emu.net")))
    {   // Cast the h_addr_list to in_addr, since h_addr_list also has the IP address in long format only
        addr_list = (struct in_addr**) HostAddr->h_addr_list;
        for (i = 0; addr_list[i] != NULL; i++)
        {
#ifdef __MORPHOS__
            strcpy(ip, Inet_NtoA((*addr_list[i]).s_addr));
#else
            strcpy(ip, (char*) Inet_NtoA(*addr_list[i]));
#endif
    }   }
    else
    {   strcpy(ip, "208.115.246.164");
    }
#endif

    hSocket = (int) socket(AF_INET, SOCK_STREAM, 0);
    if (hSocket == -1)
    {   say("Socket allocation failed!", REQIMAGE_WARNING);
        goto DONE;
    }

    INetSocketAddr.sin_family      = AF_INET;
    INetSocketAddr.sin_len         = 16; // sizeof(INetSocketAddr)
    INetSocketAddr.sin_port        = 80; // HTTP
    INetSocketAddr.sin_addr.s_addr = inet_addr(ip);
    for (i = 0; i < 8; i++)
    {   INetSocketAddr.sin_zero[i] = 0;
    }

#ifdef __amigaos4__
    if (connect(hSocket, (      struct sockaddr*) &INetSocketAddr, 16) == -1)
#else
    if (connect(hSocket, (const struct sockaddr*) &INetSocketAddr, 16) == -1)
#endif
    {   say("Socket connection failed (no Internet connection?)!", REQIMAGE_WARNING);
        goto DONE;
    }

#ifdef __MORPHOS__
    message = "GET /releases/mce-mos.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
#else
    #ifdef __amigaos4__
        message = "GET /releases/mce-os4.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
    #else
        message = "GET /releases/mce-os3.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
    #endif
#endif

    if (send(hSocket, message, strlen(message), 0) < 0)
    {   say("Can't send query to server!", REQIMAGE_WARNING);
        goto DONE;
    }

    length = (int) recv(hSocket, replystring, 1000, 0);
    if (length < 0)
    {   say("Can't receive response from server!", REQIMAGE_WARNING);
        goto DONE;
    } else
    {   replystring[length] = EOS;
    }

    length = strlen(replystring);
    i = length - 4;
    j = length;
    while (i >= 0)
    {   if (replystring[i] == CR && replystring[i + 1] == LF && replystring[i + 2] == CR && replystring[i + 3] == LF)
        {   j = i + 4;
            break;
        } else
        {   i--;
    }   }

    if (j == length)
    {   say("Invalid response from server!", REQIMAGE_WARNING);
        goto DONE;
    } elif (replystring[j] == 239 && replystring[j + 1] == 187 && replystring[j + 2] == 191) // because sometimes it is prepended with "ï»¿"
    {   j += 3; // skip crap
    }

    if (replystring[j] < '0' || replystring[j] > '9')
    {   say("Can't download update file!", REQIMAGE_WARNING);
        goto DONE;
    }

    oldver = atof(DECIMALVERSION);
    newver = atof(&replystring[j]);

    if (newver > oldver)
    {   sprintf(tempstring, "MCE %.2f %s!", (float) newver, "is available"); // we would prefer eg. 25.0 instead of 25.00
        say(tempstring, REQIMAGE_INFO);
        openurl("http://amigan.1emu.net/releases/#mce");
    }
    else
    {   say("You are up to date.", REQIMAGE_INFO);
    }

DONE:
    DISCARD SetAttrs(WinObject, WA_BusyPointer, FALSE, TAG_END);
    if (hSocket != -1)
    {   DISCARD CloseSocket(hSocket);
        // hSocket = -1; (dead assignment)
    }
#ifdef __amigaos4__
    if (ISocket)
    {   DropInterface((struct Interface*) ISocket);
        ISocket = NULL;
    }
#endif
    if (SocketBase)
    {   CloseLibrary(SocketBase);
        SocketBase = NULL;
}   }

EXPORT void ch_load_images(int thefirst, int thelast, const STRPTR* ChooserOptions, struct List* ListPtr)
{   int                 i;
    struct ChooserNode* ChooserNodePtr;

    load_images(thefirst, thelast);

    for (i = 0; i <= thelast - thefirst; i++)
    {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
        (   CNA_Text,  ChooserOptions[i],
            CNA_Image, image[thefirst + i],
        TAG_DONE)))
        {   rq("Can't create chooser.gadget node(s)!");
        }
        AddTail(ListPtr, (struct Node*) ChooserNodePtr); // AddTail() has no return code
}   }
EXPORT void ch_load_aiss_images(int thefirst, int thelast, const STRPTR* ChooserOptions, struct List* ListPtr)
{   int                 i;
    struct ChooserNode* ChooserNodePtr;

    load_aiss_images(thefirst, thelast);

    for (i = 0; i <= thelast - thefirst; i++)
    {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
        (   CNA_Text,  ChooserOptions[i],
            CNA_Image, aissimage[thefirst + i],
        TAG_DONE)))
        {   rq("Can't create chooser.gadget node(s)!");
        }
        AddTail(ListPtr, (struct Node*) ChooserNodePtr); // AddTail() has no return code
}   }

EXPORT void makesexlist(void)
{   ch_load_images(BITMAP_MALE, BITMAP_FEMALE, SexOptions, &SexList);
}

EXPORT void map_leftorup(UWORD qual, int width, int* location, int gid, struct Window* WindowPtr)
{   if
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   *location = 0;
    } elif
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   if (*location < 5)
        {   *location += width;
        }
        *location -= 5;
    } elif (*location == 0)
    {   *location = width - 1;
    } else
    {   (*location)--;
    }
    if (WindowPtr)
    {   DISCARD SetGadgetAttrs(gadgets[gid], WindowPtr, NULL, INTEGER_Number, *location, TAG_END); // this autorefreshes
}   }
EXPORT void map_rightordown(UWORD qual, int width, int* location, int gid, struct Window* WindowPtr)
{   if
    (   (qual & IEQUALIFIER_LSHIFT)
     || (qual & IEQUALIFIER_RSHIFT)
     || (qual & IEQUALIFIER_CONTROL)
    )
    {   *location = width - 1;
    } elif
    (   (qual & IEQUALIFIER_LALT)
     || (qual & IEQUALIFIER_RALT)
    )
    {   *location += 5;
        if (*location >= width)
        {   *location -= width;
    }   }
    elif (*location == width - 1)
    {   *location = 0;
    } else
    {   (*location)++;
    }
    if (WindowPtr)
    {   DISCARD SetGadgetAttrs(gadgets[gid], WindowPtr, NULL, INTEGER_Number, *location, TAG_END); // this autorefreshes
}   }

EXPORT FLAG mouseisover(int gid, SWORD mousex, SWORD mousey)
{   if
    (   mousex >= gadgets[gid]->LeftEdge
     && mousex <= gadgets[gid]->LeftEdge + gadgets[gid]->Width  - 1
     && mousey >= gadgets[gid]->TopEdge
     && mousey <= gadgets[gid]->TopEdge  + gadgets[gid]->Height - 1
    )
    {   return TRUE;
    } // implied else
    return FALSE;
}

EXPORT void getclockpens(void)
{
#ifndef __MORPHOS__
    if (ClockBase)
    {   lockscreen();

        clockpens[CLOCKPEN_BLACK   ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);
        clockpens[CLOCKPEN_DARKBLUE] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x50505050, 0x50505050, 0xFFFFFFFF, -1);
        clockpens[CLOCKPEN_GREY    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1);
        clockpens[CLOCKPEN_RED     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);

        unlockscreen();
    }
#else
    ;
#endif
}

EXPORT void make_clock(int gid)
{
#ifdef __MORPHOS__
    ;
#else
    if (ClockBase)
    {   getclockpens();

        gadgets[gid] = (struct Gadget*)
        NewObject(ClockClass, NULL,
            GA_ID,                                gid,
            GA_RelVerify,                         TRUE,
//          CLOCKGA_Time,                         ((hour * 60) + minute) * 60,
            CLOCKGA_HourHand_Pen,                 clockpens[CLOCKPEN_BLACK   ],
            CLOCKGA_MinuteHand_Pen,               clockpens[CLOCKPEN_DARKBLUE],
            CLOCKGA_Shadows_Pen,                  clockpens[CLOCKPEN_GREY    ],
            (function == FUNC_BT) ? CLOCKGA_MinuteHand_Size : TAG_IGNORE, &shapeNoMinute,
            CLOCKGA_SecondHand_Size,              &shapeNoSecond,
            CLOCKGA_Move_Hands,                   CLOCKF_MOVE_MINUTES | CLOCKF_MOVE_HOURS,
            CLOCKGA_AntiAlias,                    0,
        End;
    }
#endif
}

EXPORT void make_seconds_clock(int gid)
{
#ifdef __MORPHOS__
    ;
#else
    if (ClockBase)
    {   getclockpens();

        gadgets[gid] = (struct Gadget*)
        NewObject(ClockClass, NULL,
            GA_ID,                                gid,
            GA_RelVerify,                         TRUE,
//          CLOCKGA_Time,                         ((hour * 60) + minute) * 60,
            CLOCKGA_HourHand_Pen,                 clockpens[CLOCKPEN_BLACK   ],
            CLOCKGA_MinuteHand_Pen,               clockpens[CLOCKPEN_DARKBLUE],
            CLOCKGA_SecondHand_Pen,               clockpens[CLOCKPEN_RED     ],
            CLOCKGA_Shadows_Pen,                  clockpens[CLOCKPEN_GREY    ],
            CLOCKGA_Move_Hands,                   CLOCKF_MOVE_MINUTES | CLOCKF_MOVE_HOURS | CLOCKF_MOVE_SECONDS,
            CLOCKGA_AntiAlias,                    0,
        End;
    }
#endif
}

EXPORT void zstrncpy(char* to, const char* from, size_t n)
{   DISCARD strncpy(to, from, n);
    to[n] = EOS;
}

EXPORT void setup_bm(int which, int width, int height, struct Window* WindowPtr)
{   int y;

    InitRastPort(&wpa8rastport[which]);
    if (!(wpa8bitmap[which] = AllocBitMap
    (   (ULONG) (((width + 15) >> 4) << 1),
        height,
        8,
        BMF_DISPLAYABLE,
        WindowPtr->RPort->BitMap
    )))
    {   rq("AllocBitMap() failed!");
    }
    wpa8rastport[which].BitMap = wpa8bitmap[which];
    if (which == 0)
    {   for (y = 0; y < height; y++)
        {   byteptr1[y] = &display1[y * ROUNDTOLONG(width)];
    }   }
    else
    {   for (y = 0; y < height; y++)
        {   byteptr2[y] = &display2[y * ROUNDTOLONG(width)];
}   }   }

EXPORT void free_bm(int which)
{   if (wpa8bitmap[which])
    {   FreeBitMap(wpa8bitmap[which]);
        wpa8bitmap[which] = NULL;
}   }

EXPORT void ghost(int gid, int logic)
{   // Sufficient for button, chooser, integer and listbrowser gadgets (at least).
    DISCARD SetGadgetAttrs(gadgets[gid], MainWindowPtr, NULL, GA_Disabled, logic, TAG_END);
}
EXPORT void ghost_st(int gid, int logic)
{   // Required for slider, string and checkbox gadgets (at least).
    ghost(gid, logic);
    RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL);
}

MODULE void getpens(void)
{   switch (function)
    {
    case  FUNC_ARAZOK:                 arazok_getpens();
    acase FUNC_BT:                         bt_getpens();
    acase FUNC_BOMBJACK:                   bj_getpens();
    acase FUNC_COV:                       cov_getpens();
    acase FUNC_CSD:                       csd_getpens();
    acase FUNC_CE:                         ce_getpens();
    acase FUNC_DW:                         dw_getpens();
    acase FUNC_DRUID2:                 druid2_getpens();
    acase FUNC_DM:                         dm_getpens();
    acase FUNC_FTA:                       fta_getpens();
    acase FUNC_SS:                         ss_getpens();
    acase FUNC_GARRISON:                  gar_getpens();
    acase FUNC_GOAL:                     goal_getpens();
    acase FUNC_HILLSFAR:                   hf_getpens();
    acase FUNC_IF:                         if_getpens();
    acase FUNC_KQ:                         kq_getpens();
    acase FUNC_MERCENARY:                merc_getpens();
    acase FUNC_POLARWARE:               polar_getpens();
    acase FUNC_PIRATES:                   pir_getpens();
    acase FUNC_PHANTASIE:                  ph_getpens();
    acase FUNC_QUADRALIEN:                 qa_getpens();
    acase FUNC_Q2:                         q2_getpens();
    acase FUNC_RAGNAROK:                  lor_getpens();
    acase FUNC_ROBIN:                   robin_getpens();
    acase FUNC_ROCKFORD:                   rf_getpens();
    acase FUNC_ROGUE:                   rogue_getpens();
    acase FUNC_RORKE:                   rorke_getpens();
    acase FUNC_SIDEWINDER:                 sw_getpens();
    acase FUNC_SINBAD:                     sb_getpens();
    acase FUNC_SLAYGON:                   sla_getpens();
    acase FUNC_TOL:                       tol_getpens();
    acase FUNC_TVS:                       tvs_getpens();
    acase FUNC_WIME:                     wime_getpens();
    acase FUNC_ZERG:                     zerg_getpens();
    acase FUNC_FA18:
    case  FUNC_ICFTD:
    case  FUNC_ULTIMA:                   getclockpens();
}   }

EXPORT void setpointer(FLAG newcrosshair, UNUSED Object* winobj, struct Window* winptr, FLAG force)
{   if (force || crosshair != newcrosshair)
    {   crosshair = newcrosshair;
#ifdef __MORPHOS__
        DISCARD SetAttrs(winobj, WA_PointerType, crosshair ? POINTERTYPE_AIMING : POINTERTYPE_NORMAL, TAG_END);
#else
        if (crosshair)                           // Y   X   XOf     YOf
        {   if (changedcolours)
            {   changedcolours = FALSE;
                lockscreen();
                SetRGB4(&(ScreenPtr->ViewPort), 17, (colour17 & 0x00000F00) >> 8, (colour17 & 0x000000F0) >> 4, colour17 & 0x0000000F);
                SetRGB4(&(ScreenPtr->ViewPort), 18, (colour18 & 0x00000F00) >> 8, (colour18 & 0x000000F0) >> 4, colour18 & 0x0000000F);
                SetRGB4(&(ScreenPtr->ViewPort), 19, (colour19 & 0x00000F00) >> 8, (colour19 & 0x000000F0) >> 4, colour19 & 0x0000000F);
                unlockscreen();
            }
            SetPointer(winptr, (UWORD*) CrossData, 15, 15,  -9 + 1, -7);
        } elif (custompointer && MouseData)
        {   switch (function)
            {
            case FUNC_PSYGNOSIS:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0x5, 0x3, 0x2, // dark   brown
                        0x6, 0x4, 0x3, // medium brown
                        0x7, 0x5, 0x4  // light  brown
                    );
                }
                SetPointer(winptr, MouseData,  8, 16,  -3 + 1,  0);
            acase  FUNC_BT:
                if (winptr == MainWindowPtr)
                {   if (game == BTCS)
                    {   pointercolours
                        (   0xF, 0xB,   0, // yellow
                            0xE,   9,   0, // orange
                              0,   9,   0  // unused
                        );
                    } else
                    {   pointercolours
                        (     9, 0xE,   3, // green
                              8,   0, 0xF, // purple (unused)
                              1,   6, 0xF  // blue
                        );
                }   }
                SetPointer(winptr, MouseData, 21, 16,   0 + 1,  0);
            acase FUNC_BATTLETECH:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     9,   1,   1, // dark  red
                          0,   0,   0, // black
                        0xF,   0,   0  // light red
                    );
                }
                SetPointer(winptr, MouseData, 15,  9,  -1 + 1,  0);
            acase FUNC_BUCK:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xA, 0xA, 0xA, // light grey    
                          5,   5,   5, // dark  grey
                        0xF, 0xF, 0xF  // white
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,  -2 + 1,  0);
            acase FUNC_COK:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     5,   5,   5, // dark  grey
                         10,  10,  10, // light grey
                         15,  15,  15  // white
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,   0 + 1,  0);
            acase FUNC_CSD:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     8,   9,   7, // light grey
                          3,   3,   3, // dark  grey
                        0xD, 0xD, 0xD  // off-white
                    );
                }
                SetPointer(winptr, MouseData, 16, 10,   0 + 1,  0);
            acase FUNC_DW:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xD,   2,   2, // red
                        0xD, 0xB,   0, // black  (unused)
                        0xF, 0xC, 0xA  // bone   (unused)
                    );
                }
                SetPointer(winptr, MouseData, 13, 14,  -1 + 1,  0);
            acase FUNC_DRA:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xF, 0xF, 0xF, // white
                        0xC, 0xB,   0  // yellow
                    );
                }
                SetPointer(winptr, MouseData, 16, 12, -12 + 1,  0);
            acase FUNC_DM:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     6,   2,   0, // brown
                         12,   8,   6, // skin
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,   0 + 1,  0);
            acase FUNC_EOB:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     9,   0,   0, // dark red
                          0,   0,   0, // black
                        0xF,   5,   5  // light red
                    );
                }
                SetPointer(winptr, MouseData, 16, 10,  -2 + 1,  0); // height, width, xoffset, yoffset
            acase FUNC_FTA:
                // pointercolours() is handled in fta.c
                SetPointer(winptr, MouseData, 16, 16,  -2 + 1,  0);
            acase FUNC_ROGUE:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xD,   2,   2, // light red
                          7,   0,   0, // dark  red
                        0xF, 0xD,   9  // bone
                    );
                }
                SetPointer(winptr, MouseData, 15, 15,  -2 + 1,  0);
            acase FUNC_KQ:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (    13,   2,   2, // red
                          0,   0,   0, // black
                         15,  12,  10  // yellow/bone
                    );
                }
                SetPointer(winptr, MouseData, 11,  8,   0 + 1,  0);
            acase FUNC_LOF:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xA, 0xA, 0xA, // medium grey
                        0xC, 0xC, 0xC, // light  grey
                          6,   6,   6  // dark   grey
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,   0 + 1,  0); // height, width, xoffset, yoffset
            acase FUNC_LOL:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xF, 0xF, 0xF, // white
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,  -1 + 1,  0);
            acase FUNC_MM:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0, 0xF, // blue
                        0x5, 0xA, 0xA, // cyan
                        0xB, 0x7,   4  // unused
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,  -1 + 1, -1);
            acase FUNC_NEUROMANCER:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xE, 0x5, 0x2, // orange
                        0xF, 0xC, 0xA, // skin
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData,  8, 16,   0 + 1, -1);
            acase FUNC_POLARWARE:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xF, 0xC, 0xA, // skin
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,  -1 + 1,  0);
            acase FUNC_PHANTASIE:
                if (game == PHANTASIE1)
                {   if (winptr == MainWindowPtr)
                    {   pointercolours
                        (   0xD,   2,   2, // red
                              0,   0,   0, // black
                              0,   0,   0  // unused
                        );
                    }
                    SetPointer(winptr, MouseData, 16, 16, -2 + 1, 0);
                } else
                {   if (winptr == MainWindowPtr)
                    {   pointercolours
                        (     9,   1,   1, // dark  red
                              0,   0,   0, // black
                            0xF,   0,   0  // light red
                        );
                    }
                    SetPointer(winptr, MouseData, 15, 9, -1 + 1, 0);
                }
            acase FUNC_POR:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0x9,   9,   9, // grey
                        0xB, 0xA,   0, // dark  yellow
                        0xD, 0xC,   0  // light yellow
                    );
                }
                SetPointer(winptr, MouseData, 16, 16,   0 + 1,  0);
            acase FUNC_QUADRALIEN:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xF,   0,   0, // unused
                          0, 0xF,   8, // green/cyan
                        0xA,   2,   2  // dark red
                    );
                }
                SetPointer(winptr, MouseData, 16, 11,   0 + 1, -1);
            acase FUNC_Q2:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     9,   1,   1, // dark  red
                          0,   0,   0, // black
                        0xF,   0,   0  // light red
                    );
                }
                SetPointer(winptr, MouseData, 15,  9,  -1 + 1,  0);
            acase FUNC_RORKE:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (   0xF, 0xF, 0xF, // white
                          0,   0,   0, // black
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 15,  9,   0 + 1,  0);
            acase FUNC_SLAYGON:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xD,   2,   2, // red
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 16, 11,  -1 + 1, -1); // height, width, xoffset, yoffset
            acase FUNC_SYNDICATE:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xF, 0xF, 0xF, // white
                          0,   0,   0  // unused
                    );
                }
                SetPointer(winptr, MouseData, 11, 11,   0 + 1,  0);
            acase FUNC_ULTIMA:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     2,   2,   2, // dark   grey
                          7,   7,   8, // medium grey
                         12,  12,  13  // light  grey
                    );
                }
                SetPointer(winptr, MouseData, 14, 10,   0 + 1,  0);
            acase FUNC_WIZ:
                if (winptr == MainWindowPtr)
                {   pointercolours
                    (     0,   0,   0, // black
                        0xA,   0,   0, // red
                        0xF, 0xF,   5  // yellow
                    );
                }
                SetPointer(winptr, MouseData, 12, 12,  -1 + 1,  0);
        }   }
        else
        {   if (changedcolours)
            {   changedcolours = FALSE;
                lockscreen();
                SetRGB4(&(ScreenPtr->ViewPort), 17, (colour17 & 0x00000F00) >> 8, (colour17 & 0x000000F0) >> 4, colour17 & 0x0000000F);
                SetRGB4(&(ScreenPtr->ViewPort), 18, (colour18 & 0x00000F00) >> 8, (colour18 & 0x000000F0) >> 4, colour18 & 0x0000000F);
                SetRGB4(&(ScreenPtr->ViewPort), 19, (colour19 & 0x00000F00) >> 8, (colour19 & 0x000000F0) >> 4, colour19 & 0x0000000F);
                unlockscreen();
            }
            ClearPointer(winptr);
        }
#endif
}   }

EXPORT void westwood(void)
{
#ifdef __MORPHOS__
    ;
#else
    MouseData = (UWORD*) WestwoodMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
}

EXPORT void pointercolours(UBYTE red17, UBYTE green17, UBYTE blue17, UBYTE red18, UBYTE green18, UBYTE blue18, UBYTE red19, UBYTE green19, UBYTE blue19)
{
#ifdef __MORPHOS__
    ;
#else
    if (!changedcolours)
    {   lockscreen();
        colour17 = GetRGB4(ScreenPtr->ViewPort.ColorMap, 17);
        colour18 = GetRGB4(ScreenPtr->ViewPort.ColorMap, 18);
        colour19 = GetRGB4(ScreenPtr->ViewPort.ColorMap, 19);
        SetRGB4(&(ScreenPtr->ViewPort), 17, red17, green17, blue17);
        SetRGB4(&(ScreenPtr->ViewPort), 18, red18, green18, blue18);
        SetRGB4(&(ScreenPtr->ViewPort), 19, red19, green19, blue19);
        unlockscreen();
        changedcolours = TRUE;
    }
#endif
}

EXPORT FLAG sketchboard_subgadget(ULONG gid, UWORD code)
{   if ((int) gid == sb2)
    {   switch (code - 1)
        {
        case  COMMAND_CUT:   edit_cut();
        acase COMMAND_COPY:  edit_copy();
        acase COMMAND_PASTE: edit_paste();
        acase COMMAND_ERASE: edit_erase();
        acase COMMAND_UNDO:  undo();
        acase COMMAND_REDO:  redo();
    }   }
    elif ((int) gid == sb3)
    {   changetool(code - 1, FALSE);
    } elif ((int) gid == sk1)
    {   if (currenttool == PAINT_SELECTCOLOUR)
        {   DISCARD GetAttr(SGA_APen, (Object*) gadgets[sk1], (ULONG*) &fgpen_real);
            switch (function)
            {
            case  FUNC_BOMBJACK:   bj_realpen_to_table();
            acase FUNC_SS:         ss_realpen_to_table();
            acase FUNC_IF:         if_realpen_to_table();
            acase FUNC_ROCKFORD:   rf_realpen_to_table();
            acase FUNC_SIDEWINDER: sw_realpen_to_table();
            }
            DISCARD SetGadgetAttrs
            (   gadgets[pl1], SubWindowPtr, NULL,
                PALETTE_Colour, fgpen_intable,
            TAG_DONE); // this refreshes automatically
        } else
        {   ghostundos();
    }   }
    elif ((int) gid == pl1)
    {   DISCARD GetAttr(PALETTE_Colour, (Object*) gadgets[pl1], (ULONG*) &fgpen_intable);
        switch (function)
        {
        case  FUNC_BOMBJACK:   bj_tablepen_to_real();
        acase FUNC_SS:         ss_tablepen_to_real();
        acase FUNC_IF:         if_tablepen_to_real();
        acase FUNC_ROCKFORD:   rf_tablepen_to_real();
        acase FUNC_SIDEWINDER: sw_tablepen_to_real();
        }
        DISCARD SetGadgetAttrs
        (   gadgets[sk1], SubWindowPtr, NULL,
            SGA_APen, pens[fgpen_real],
        TAG_DONE);
    } elif ((int) gid == bu3)
    {   return TRUE;
    } elif ((int) gid == bu4)
    {   cancelling = TRUE;
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG sketchboard_subkey(UWORD code)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_ESCAPE:
        cancelling = TRUE;
        return TRUE;
    acase SCAN_D: changetool(PAINT_FREEHANDDOT  , TRUE);
    acase SCAN_H: changetool(PAINT_FREEHANDLINE , TRUE);
    acase SCAN_L: changetool(PAINT_LINE         , TRUE);
    acase SCAN_R: changetool(PAINT_RECT         , TRUE);
    acase SCAN_I: changetool(PAINT_FILLEDRECT   , TRUE);
    acase SCAN_E: changetool(PAINT_ELLIPSE      , TRUE);
    acase SCAN_P: changetool(PAINT_FILLEDELLIPSE, TRUE);
    acase SCAN_F: changetool(PAINT_FLOODFILL    , TRUE);
    acase SCAN_S: changetool(PAINT_SELECTCOLOUR , TRUE);
#ifndef __amigaos4__
    acase SCAN_A: changetool(PAINT_MARK         , TRUE);
    acase SCAN_M: changetool(PAINT_MOVE         , TRUE);
#endif
    acase SCAN_G: changetool(PAINT_GRID         , TRUE);
    acase SCAN_X: edit_cut();
    acase SCAN_C: edit_copy();
    acase SCAN_V: edit_paste();
    acase SCAN_Y: redo();
    acase SCAN_Z: undo();
    }

    return FALSE;
}

MODULE void changetool(ULONG newtool, FLAG keyboard)
{   if (newtool == PAINT_GRID)
    {   if (keyboard)
        {   showgrid = ~showgrid;
            SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, ~0, TAG_DONE);
            SetSpeedButtonNodeAttrs((struct Node*) PaintBarNodePtr[PAINT_GRID], SBNA_Selected, showgrid, TAG_DONE);
            SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, &PaintBarList, TAG_DONE); // this refreshes automatically
        } else
        {   GetSpeedButtonNodeAttrs
            (   (struct Node*) PaintBarNodePtr[PAINT_GRID],
                SBNA_Selected, (ULONG*) &showgrid,
            TAG_DONE);
        }
        SetGadgetAttrs(gadgets[sk1], SubWindowPtr, NULL, SGA_ShowGrid, showgrid, TAG_DONE);
        RefreshGadgets((struct Gadget*) gadgets[sk1], SubWindowPtr, NULL); // this is needed
    } else
    {   SetGadgetAttrs(gadgets[sk1], SubWindowPtr, NULL, SGA_Tool, painttool[newtool], TAG_DONE);

        SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, ~0, TAG_DONE);
        SetSpeedButtonNodeAttrs((struct Node*) PaintBarNodePtr[newtool], SBNA_Selected, TRUE, TAG_DONE);
        if (keyboard && currenttool != newtool)
        {   SetSpeedButtonNodeAttrs((struct Node*) PaintBarNodePtr[currenttool], SBNA_Selected, FALSE, TAG_DONE);
        }
        SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, &PaintBarList, TAG_DONE); // this refreshes automatically

        currenttool = newtool;
}   }

MODULE void undo(void)
{   DoMethod((Object*) gadgets[sk1], SGM_Undo, NULL);
    RefreshGadgets((struct Gadget*) gadgets[sk1], SubWindowPtr, NULL); // this is needed
    ghostundos();
}
MODULE void redo(void)
{   DoMethod((Object*) gadgets[sk1], SGM_Redo, NULL);
    RefreshGadgets((struct Gadget*) gadgets[sk1], SubWindowPtr, NULL); // this is needed
    ghostundos();
}

MODULE FLAG edit_cut(void)
{   if (edit_copy())
    {   edit_erase();

        return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void edit_erase(void)
{   SetGadgetAttrs(    gadgets[sk1], SubWindowPtr, NULL, SGA_APen, 0,                TAG_DONE);
    DoMethod((Object*) gadgets[sk1], SGM_Clear,    NULL);
    RefreshGList(      gadgets[sk1], SubWindowPtr, NULL, 1);
    SetGadgetAttrs(    gadgets[sk1], SubWindowPtr, NULL, SGA_APen, pens[fgpen_real], TAG_DONE);
}

MODULE FLAG edit_copy(void)
{   FLAG                  result = FALSE;
    ULONG                 modeid,
                          ncolours,
                          selectwidth, selectheight;
    ULONG*                cregs;
    int                   i;
    struct BitMap        *anotherbitmap,
                         *theirselectbitmap;
    struct BitMapHeader*  bmhd;
    struct ColorRegister* cmap;
    Object*               o;
    struct dtGeneral      dtg;

    DISCARD SetGadgetAttrs
    (   gadgets[sk1], SubWindowPtr, NULL,
        GA_ReadOnly, TRUE,
    TAG_DONE);

#ifdef __amigaos4__
    GetAttr(SGA_BitMap,         (Object*) gadgets[sk1], (ULONG*) &theirselectbitmap);
    selectwidth = tilewidth;
#else
    GetAttr(SGA_TopLayerBitmap, (Object*) gadgets[sk1], (ULONG*) &theirselectbitmap);
    GetAttr(SGA_TopLayerWidth,  (Object*) gadgets[sk1], (ULONG*) &selectwidth);
#endif
    selectheight = GetBitMapAttr(theirselectbitmap, BMA_HEIGHT);
    lockscreen();
    modeid = GetVPModeID(&ScreenPtr->ViewPort);
    unlockscreen();
    ncolours = 1 << theirselectbitmap->Depth;

    if ((anotherbitmap = AllocBitMap(selectwidth, selectheight, theirselectbitmap->Depth, BMF_CLEAR, NULL)))
    {   if ((o = NewDTObject("MCE",
            DTA_SourceType, DTST_RAM,
            DTA_GroupID,    GID_PICTURE,
            PDTA_NumColors, ncolours,
            PDTA_BitMap,    anotherbitmap,
            PDTA_ModeID,    modeid,
        TAG_DONE)))
        {   if
            (   GetDTAttrs
                (   o,
                    PDTA_BitMapHeader,   &bmhd,
                    PDTA_ColorRegisters, (ULONG) &cmap,
                    PDTA_CRegs,          &cregs,
                TAG_DONE) == 3
            )
            {   bmhd->bmh_Width      = selectwidth;
                bmhd->bmh_Height     = selectheight;
                bmhd->bmh_Depth      = theirselectbitmap->Depth;
                bmhd->bmh_PageWidth  = 320;
                bmhd->bmh_PageHeight = 200;

                lockscreen();
                GetRGB32(ScreenPtr->ViewPort.ColorMap, 0, ncolours, cregs);
                unlockscreen();

                for (i = 0; i < (int) ncolours; i++)
                {   /* Set the master color table */
                    cmap->red   = (UBYTE) (cregs[i * 3 + 0] >> 24);
                    cmap->green = (UBYTE) (cregs[i * 3 + 1] >> 24);
                    cmap->blue  = (UBYTE) (cregs[i * 3 + 2] >> 24);
                    cmap++;
                }

                BltBitMap(theirselectbitmap, 0, 0, anotherbitmap, 0, 0, selectwidth, selectheight, 0xC0, 0xFF, NULL);

                dtg.MethodID = DTM_COPY;
                if (DoDTMethodA(o, NULL, NULL, (Msg) &dtg))
                {   result = TRUE;
                }

                DisposeDTObject(o);
            }
            else
            {
                FreeBitMap(anotherbitmap);
    }   }   }

    DISCARD SetGadgetAttrs
    (   gadgets[sk1], SubWindowPtr, NULL,
        GA_ReadOnly, FALSE,
    TAG_DONE);

    return result;
}

MODULE FLAG edit_paste(void)
{   FLAG                 result = FALSE;
 // ULONG                depth;
    struct BitMapHeader* bmhd;
    struct gpLayout      gpl;
    struct BitMap*       bm;
    Object*              o;

 /* lockscreen();
    depth = GetBitMapAttr(ScreenPtr->RastPort.BitMap, BMA_DEPTH);
    if (depth < 8) depth = 8; */

    /* Get a pointer to the object */
    if ((o = NewDTObject
    (   0,                // means unit 0
        DTA_SourceType,   DTST_CLIPBOARD,
        DTA_GroupID,      GID_PICTURE,
// ThoR: "Putting a screen here is a bad idea because
// it makes the picture.datatype believe that it may
// create a bitmap that is a friend of the bitmap
// of the screen. However, this program cannot
// handle such bitmaps..."
//      PDTA_Screen,      ScreenPtr,
        PDTA_NumSparse,   (function == FUNC_BOMBJACK) ? 16 : 32,
        PDTA_SparseTable, pens,
        PDTA_Remap,       TRUE,
    TAG_DONE)))
    {   gpl.MethodID    = DTM_PROCLAYOUT;
        gpl.gpl_GInfo   = NULL;
        gpl.gpl_Initial = 1;

        if (DoMethodA(o, (Msg) &gpl))
        {   if ((GetDTAttrs(o,
                PDTA_BitMapHeader, &bmhd,
                PDTA_BitMap,       &bm,
            TAG_DONE) == 2) && bm)
            {   result = TRUE;

                WaitBlit();

#ifdef __amigaos4__
                SetGadgetAttrs
                (   gadgets[sk1], SubWindowPtr, NULL,
                    SGA_BitMap,         bm,
                TAG_DONE);
                RefreshGadgets((struct Gadget*) gadgets[sk1], SubWindowPtr, NULL); // this is needed
#else
                SetGadgetAttrs
                (   gadgets[sk1], SubWindowPtr, NULL,
                    SGA_TopLayerBitmap, bm,
                    SGA_TopLayerWidth,  bmhd->bmh_Width,
                TAG_DONE);
#endif
        }   }
        DisposeDTObject(o);
    }

 // unlockscreen();

    return result;
}

MODULE void ghostundos(void)
{   ULONG newredoable,
          newundoable;

    DISCARD GetAttr(SGA_UndoAvailable, (Object*) gadgets[sk1], (ULONG*) &newundoable);
    DISCARD GetAttr(SGA_RedoAvailable, (Object*) gadgets[sk1], (ULONG*) &newredoable);
    if (newundoable != undoable || newredoable != redoable)
    {   undoable = newundoable;
        redoable = newredoable;
        SetGadgetAttrs(gadgets[sb2], SubWindowPtr, NULL, SPEEDBAR_Buttons, ~0, TAG_DONE);
        SetSpeedButtonNodeAttrs((struct Node*) CommandBarNodePtr[COMMAND_UNDO ], SBNA_Disabled, undoable ? FALSE : TRUE, TAG_DONE);
        SetSpeedButtonNodeAttrs((struct Node*) CommandBarNodePtr[COMMAND_REDO ], SBNA_Disabled, redoable ? FALSE : TRUE, TAG_DONE);
        SetGadgetAttrs(gadgets[sb2], SubWindowPtr, NULL, SPEEDBAR_Buttons, &CommandBarList, TAG_DONE); // this refreshes automatically
}   }

EXPORT void gfxwindow(void)
{   TRANSIENT FLAG           oldcrosshair;
    TRANSIENT ULONG          scale = 0; // initialized to prevent a spurious SAS/C warning
    TRANSIENT int            i,
                             x, xx,
                             y, yy;
    TRANSIENT struct BitMap* theirbitmap;
    TRANSIENT struct Gadget* InstructionObject;
    PERSIST   FLAG           first = TRUE;
    PERSIST   WORD           leftx = -1,
                             topy  = -1;
    PERSIST   UWORD          ThisColourTable[32]; // this must stay valid

    if (!SketchBoardBase)
    {   return;
    }

    if (first)
    {
#ifdef __amigaos4__
        load_aiss_images(19, 36);
        // 37..40 are not used on OS4
        load_aiss_images(41, 54);
#else
        load_aiss_images(19, 54);
#endif
        load_images(BITMAP_OK, BITMAP_CANCEL);

        NewList(&CommandBarList);
        for (i = 0; i < COMMANDNODES; i++)
        {   if
            ((  CommandBarNodePtr[i] = (struct SpeedBarNode*) AllocSpeedButtonNode((UWORD) (i + 1), /* speed button ID */
                    SBNA_Image,     aissimage[43 + (i * 2)],
                    SBNA_SelImage,  aissimage[44 + (i * 2)],
                    SBNA_Enabled,   TRUE,
                    SBNA_Spacing,   2,
                    SBNA_Highlight, SBH_IMAGE,
                    SBNA_Toggle,    FALSE,
                    SBNA_Disabled,  (i == COMMAND_UNDO || i == COMMAND_REDO) ? TRUE : FALSE,
            TAG_END)))
            {   AddTail(&CommandBarList, (struct Node*) CommandBarNodePtr[i]);
            } else
            {   rq("Can't allocate speedbar images (out of memory?)!");
        }   }

        NewList(&PaintBarList);
        for (i = 0; i < PAINTNODES; i++)
        {
#ifdef __amigaos4__
            if
            ((  PaintBarNodePtr[i] = (struct SpeedBarNode*) AllocSpeedButtonNode((UWORD) (i + 1), /* speed button ID */
                    SBNA_Image,     aissimage[(i == PAINT_GRID) ? 41 : (19 + (i * 2))],
                    SBNA_SelImage,  aissimage[(i == PAINT_GRID) ? 42 : (20 + (i * 2))],
                    SBNA_Enabled,   TRUE,
                    SBNA_Spacing,   (i == PAINT_GRID) ? 16 : 2,
                    SBNA_Highlight, SBH_IMAGE,
                    SBNA_Toggle,    TRUE,
                    SBNA_MXGroup,             (i == PAINT_GRID) ? (~0) :   0,
            TAG_END)))
#else
            if
            ((  PaintBarNodePtr[i] = (struct SpeedBarNode*) AllocSpeedButtonNode((UWORD) (i + 1), /* speed button ID */
                    SBNA_Image,     aissimage[                          19 + (i * 2) ],
                    SBNA_SelImage,  aissimage[                          20 + (i * 2) ],
                    SBNA_Enabled,   TRUE,
                    SBNA_Spacing,   (   ( broken && i == PAINT_MOVE)
                                     || (!broken && i == PAINT_GRID)
                                    ) ? 16 : 2,
                    SBNA_Highlight, SBH_IMAGE,
                    SBNA_Toggle,    TRUE,
                    SBNA_MXGroup,             (i == PAINT_GRID) ? (~0) :   0,
            TAG_END)))
#endif
            {   AddTail(&PaintBarList, (struct Node*) PaintBarNodePtr[i]);
            } else
            {   rq("Can't allocate speedbar images (out of memory?)!");
        }   }

        first = FALSE;
    }

    sketchboard_hintinfo[ 0].hi_GadgetID =
    sketchboard_hintinfo[ 1].hi_GadgetID =
    sketchboard_hintinfo[ 2].hi_GadgetID =
    sketchboard_hintinfo[ 3].hi_GadgetID =
    sketchboard_hintinfo[ 4].hi_GadgetID =
    sketchboard_hintinfo[ 5].hi_GadgetID = sb2;
    sketchboard_hintinfo[ 6].hi_GadgetID =
    sketchboard_hintinfo[ 7].hi_GadgetID =
    sketchboard_hintinfo[ 8].hi_GadgetID =
    sketchboard_hintinfo[ 9].hi_GadgetID =
    sketchboard_hintinfo[10].hi_GadgetID =
    sketchboard_hintinfo[11].hi_GadgetID =
    sketchboard_hintinfo[12].hi_GadgetID =
    sketchboard_hintinfo[13].hi_GadgetID =
    sketchboard_hintinfo[14].hi_GadgetID = sb3;
#ifndef __amigaos4__
    sketchboard_hintinfo[15].hi_GadgetID =
    sketchboard_hintinfo[16].hi_GadgetID = sb3;
#endif
    sketchboard_hintinfo[17].hi_GadgetID = sb3;

    InitRastPort(&wpa8tilerastport);
    if (!(wpa8tilebitmap = AllocBitMap
    (   titlemode ? 320 : tilewidth,
        titlemode ? 200 : tileheight,
        8,
        0,
        NULL
    )))
    {   rq("AllocBitMap() failed!");
    }
    wpa8tilerastport.BitMap = wpa8tilebitmap;

    if (titlemode)
    {   for (y = 0; y < 200; y++)
        {   scrnbyteptr[y] = &scrndisplay[y * 320];
    }   }
    else
    {   for (y = 0; y < tileheight; y++)
        {   tilebyteptr[y] = &tiledisplay[y * tilewidth];
    }   }

    InitRastPort(&sketchrastport);
    if (!(sketchbitmap = AllocBitMap
    (   titlemode ? 320 : tilewidth,
        titlemode ? 200 : tileheight,
        8,
        0,
        NULL
    )))
    {   // assert(wpa8tilebitmap);
        FreeBitMap(wpa8tilebitmap);
        wpa8tilebitmap = NULL;
        rq("AllocBitMap() failed!");
    }
    sketchrastport.BitMap = sketchbitmap;

    // assert(tileplanes[stamp] >= 1);

    if (fgpen_intable >= (ULONG) (1 << tileplanes[stamp]))
    {   fgpen_intable = 0;
    }

    switch (function)
    {
    case FUNC_BOMBJACK:
        bj_tablepen_to_real();
        for (i = 0; i < 16; i++)
        {   ThisColourTable[i] = (UWORD) pens[from_platform[i]];
        }
        for (y = 0; y < tileheight; y++)
        {   for (x = 0; x < tilewidth; x++)
            {   *(tilebyteptr[y] + x) = pens[from_platform[TileData[(((stamp * tileheight) + y) * tilewidth) + x]]];
        }   }
        scale = bb1sk ? 24 : 16;
    acase FUNC_SS:
        ss_tablepen_to_real();
        switch (tileplanes[stamp])
        {
        case 1:
            ThisColourTable[0] = pens[(game == FIREPOWER) ? 1 : 0];
            ThisColourTable[1] = pens[(game == FIREPOWER) ? 3 : 2];
        acase 3:
            // assert(game == FIREPOWER);
            if (stamp == 32 || stamp == 36)
            {   for (i = 0; i < 4; i++)
                {   ThisColourTable[    i] = pens[     i];
                    ThisColourTable[4 + i] = pens[16 + i];
            }   }
            else
            {   for (i = 0; i < 8; i++)
                {   ThisColourTable[    i] = pens[     i];
            }   }
        acase 4:
            // assert(game == FIREPOWER);
            for (i = 0; i < 8; i++)
            {   ThisColourTable[    i] = pens[     i];
                ThisColourTable[8 + i] = pens[16 + i];
            }
        adefault:
            for (i = 0; i < (1 << tileplanes[stamp]); i++)
            {   ThisColourTable[    i] = pens[     i];
        }   }
        for (y = 0; y < tileheight; y++)
        {   for (x = 0; x < tilewidth; x++)
            {   *(tilebyteptr[y] + x) = pens[              TileData[(((stamp * tileheight) + y) * tilewidth) + x] ];
        }   }
        scale = 8;
    acase FUNC_ROCKFORD:
        rf_tablepen_to_real();
        if (titlemode)
        {   for (i = 0; i < 32; i++)
            {   ThisColourTable[i] = (UWORD) pens[32 + i];
            }
            scale = 2;
            for (y = 0; y < 200; y++)
            {   for (x = 0; x < 320; x++)
                {   *(scrnbyteptr[y] + x) = pens[32 + ScrnData[(y * 320) + x]];
        }   }   }
        else
        {   for (i = 0; i < 32; i++)
            {   ThisColourTable[i] = (UWORD) pens[i];
            }
            scale = bb1sk ? 24 : 16;
            rf_gettilepos(&x, &y);
            for (yy = 0; yy < tileheight; yy++)
            {   for (xx = 0; xx < tilewidth; xx++)
                {   *(tilebyteptr[yy] + xx) = pens[TileData[( rf_world * 64000)
                                                          + ((y + yy)  *   320)
                                                          +   x + xx
                                                  ]        ];
        }   }   }
    acase FUNC_IF:
        if_tablepen_to_real();
        for (i = 0; i < 8; i++)
        {   ThisColourTable[i] = (UWORD) pens[penoffset + i];
        }
        scale = bb1sk ? 24 : 16;
        for (y = 0; y < tileheight; y++)
        {   for (x = 0; x < tilewidth; x++)
            {   *(tilebyteptr[y] + x) = pens[if_getpixel(x, y)];
        }   }
    acase FUNC_SIDEWINDER:
        sw_tablepen_to_real();
        for (i = 0; i < ((game == SIDEWINDER1) ? 32 : 16); i++) // these parentheses are needed!
        {   ThisColourTable[i] = (UWORD) pens[i];
        }
        if (titlemode)
        {   scale = 2;
            for (y = 0; y < 200; y++)
            {   for (x = 0; x < 320; x++)
                {   *(scrnbyteptr[y] + x) = pens[ScrnData[(y * 320) + x]];
        }   }   }
        else
        {   scale = bb1sk ? 24 : 16;
            for (y = 0; y < tileheight; y++)
            {   for (x = 0; x < tilewidth; x++)
                {   *(tilebyteptr[y] + x) = pens[sw_getpixel(x, y)];
    }   }   }   }

    if (titlemode)
    {   DISCARD WritePixelArray8
        (   &sketchrastport,
            0,
            0,
            320 - 1,
            200 - 1,
            scrndisplay,
            &wpa8tilerastport
        );

        InstructionObject = (struct Gadget*)
        HLayoutObject,
            AddSpace,
            AddLabel("Use Ctrl key and mouse wheel to zoom."),
            CHILD_WeightedWidth, 0,
            AddSpace,
        LayoutEnd;
    } else
    {   DISCARD WritePixelArray8
        (   &sketchrastport,
            0,
            0,
            tilewidth  - 1,
            tileheight - 1,
            tiledisplay,
            &wpa8tilerastport
        );

        InstructionObject = NULL; // initialized to avoid a spurious SAS/C warning
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                  titlemode ? "Edit Title Screen" : "Edit Tile Graphics",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_GadgetHelp,                         TRUE,
        WINDOW_HintInfo,                           &sketchboard_hintinfo,
        WINDOW_UniqueID,                           "sketchboard",
        WINDOW_ParentGroup,
        VLayoutObject,
            LAYOUT_AddChild,                       gadgets[sb2] = (struct Gadget*)
            SpeedBarObject,
                GA_ID,                             sb2,
                GA_RelVerify,                      TRUE,
                SPEEDBAR_Buttons,                  &CommandBarList,
                SPEEDBAR_StrumBar,                 TRUE,
                SPEEDBAR_BevelStyle,               BVS_NONE,
            SpeedBarEnd,
            CHILD_WeightedHeight,                  0,
            LAYOUT_AddChild,                       gadgets[sb3] = (struct Gadget*)
            SpeedBarObject,
                GA_ID,                             sb3,
                GA_RelVerify,                      TRUE,
                SPEEDBAR_Buttons,                  &PaintBarList,
                SPEEDBAR_StrumBar,                 TRUE,
                SPEEDBAR_BevelStyle,               BVS_NONE,
            SpeedBarEnd,
            CHILD_WeightedHeight,                  0,
            AddHLayout,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_AddChild,                   gadgets[sk1] = (struct Gadget*)
                NewObject(SKETCHBOARD_GetClass(), NULL,
                    GA_ID,                         sk1,
                    GA_RelVerify,                  TRUE,
                    SGA_Width,                     titlemode ? 320 : tilewidth,
                    SGA_Height,                    titlemode ? 200 : tileheight,
                    SGA_MaxScale,                  24,
                    SGA_Scale,                     scale,
                    SGA_BitMap,                    sketchbitmap,
                    SGA_APen,                      pens[fgpen_real],
                    SGA_ShowGrid,                  showgrid,
                End,
                CHILD_WeightedWidth,               0,
                LAYOUT_AddChild,                   gadgets[pl1] = (struct Gadget*)
                PaletteObject,
                    GA_ID,                         pl1,
                    GA_RelVerify,                  TRUE,
                    PALETTE_NumColours,            1 << tileplanes[stamp],
                    PALETTE_ColourTable,           ThisColourTable,
                    PALETTE_Colour,                fgpen_intable,
                PaletteEnd,
                CHILD_MinWidth,                    64,
            LayoutEnd,
            titlemode ? LAYOUT_AddChild      : TAG_IGNORE, InstructionObject,
            titlemode ? CHILD_WeightedHeight : TAG_IGNORE, 0,
            AddHLayout,
                LAYOUT_AddChild,                   gadgets[bu3] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         bu3,
                    GA_RelVerify,                  TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,               image[BITMAP_OK],
                        CHILD_NoDispose,           TRUE,
                        LABEL_DrawInfo,            DrawInfoPtr,
                        LABEL_Text,                " ",
                        LABEL_Text,                "OK (ENTER)",
                    LabelEnd,
                ButtonEnd,
                LAYOUT_AddChild,                   gadgets[bu4] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         bu4,
                    GA_RelVerify,                  TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,               image[BITMAP_CANCEL],
                        CHILD_NoDispose,           TRUE,
                        LABEL_DrawInfo,            DrawInfoPtr,
                        LABEL_Text,                " ",
                        LABEL_Text,                "Cancel (Esc)",
                    LabelEnd,
                ButtonEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   // assert(sketchbitmap);
        FreeBitMap(sketchbitmap);
        sketchbitmap = NULL;
        // assert(wpa8tilebitmap);
        FreeBitMap(wpa8tilebitmap);
        wpa8tilebitmap = NULL;
        rq("Can't create gadgets!");
    }

    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   // assert(SubWinObject);
        DisposeObject(SubWinObject);
        SubWinObject = NULL;
        // assert(!SubWindowPtr);
        // assert(sketchbitmap);
        FreeBitMap(sketchbitmap);
        sketchbitmap = NULL;
        // assert(wpa8tilebitmap);
        FreeBitMap(wpa8tilebitmap);
        wpa8tilebitmap = NULL;
        rq("Can't open window!");
    }

    SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, ~0, TAG_DONE);
    SetSpeedButtonNodeAttrs((struct Node*) PaintBarNodePtr[PAINT_GRID], SBNA_Selected, showgrid, TAG_DONE);
    SetGadgetAttrs(gadgets[sb3], SubWindowPtr, NULL, SPEEDBAR_Buttons, &PaintBarList, TAG_DONE); // this refreshes automatically

    undoable = redoable = FALSE;
    changetool(currenttool, FALSE);
    oldcrosshair = crosshair;
    cancelling = crosshair = FALSE;

    subloop();

    crosshair = oldcrosshair;

    if (!cancelling)
    {   DISCARD SetGadgetAttrs
        (   gadgets[sk1], SubWindowPtr, NULL,
            GA_ReadOnly, TRUE,
        TAG_DONE);
        DISCARD GetAttr(SGA_BitMap, (Object*) gadgets[sk1], (ULONG*) &theirbitmap);
        BltBitMapRastPort
        (   theirbitmap,
            0, 0,
            &sketchrastport,
            0, 0,
            titlemode ? 320 : tilewidth,
            titlemode ? 200 : tileheight,
            0xC0
        );
        switch (function)
        {
        case FUNC_BOMBJACK:
            ReadPixelArray8
            (   &sketchrastport,
                0, 0,
                tilewidth  - 1,
                tileheight - 1,
                &TileData[stamp * tileheight * tilewidth],
                &wpa8tilerastport
            );
            for (y = 0; y < tileheight; y++)
            {   for (x = 0; x < tilewidth; x++)
                {   TileData[(((stamp * tileheight) + y) * tilewidth) + x] = to_platform[convert[
                    TileData[(((stamp * tileheight) + y) * tilewidth) + x]]];
            }   }
            bj_drawmap(TRUE);
        acase FUNC_SS:
            ReadPixelArray8
            (   &sketchrastport,
                0, 0,
                tilewidth  - 1,
                tileheight - 1,
                &TileData[stamp * tileheight * tilewidth],
                &wpa8tilerastport
            );
            for (y = 0; y < tileheight; y++)
            {   for (x = 0; x < tilewidth; x++)
                {   TileData[(((stamp * tileheight) + y) * tilewidth) + x] = convert[
                    TileData[(((stamp * tileheight) + y) * tilewidth) + x]];
            }   }
            ss_drawmap(TRUE);
        acase FUNC_IF:
            ReadPixelArray8
            (   &sketchrastport,
                0, 0,
                tilewidth  - 1,
                tileheight - 1,
                TileData,
                &wpa8tilerastport
            );      
            if_readsketchboard(TileData);
            if_drawmap();
        acase FUNC_ROCKFORD:
            if (titlemode)
            {   rf_readtitlescreen();
            } else
            {   rf_gettilepos(&x, &y);
                for (yy = 0; yy < tileheight; yy++)
                {   ReadPixelLine8
                    (   &sketchrastport,
                        0, yy,
                        tilewidth  - 1,
                        &TileData[(rf_world * 64000) + ((y + yy) * 320) + x],
                        &wpa8tilerastport
                    );
                    for (xx = 0; xx < tilewidth; xx++)
                    {   TileData[ (rf_world * 64000) + ((y + yy) * 320) + x + xx] = convert[
                        TileData[ (rf_world * 64000) + ((y + yy) * 320) + x + xx]          ];
                }   }
                rf_drawmap(TRUE);
            }
        acase FUNC_SIDEWINDER:
            if (titlemode)
            {   sw_readtitlescreen();
            } else
            {   ReadPixelArray8
                (   &sketchrastport,
                    0, 0,
                    tilewidth  - 1,
                    tileheight - 1,
                    TileData,
                    &wpa8tilerastport
                );      
                sw_readsketchboard(TileData);
                sw_drawmap(0, 0, TRUE);
    }   }   }

    leftx = SubWindowPtr->LeftEdge;
    topy  = SubWindowPtr->TopEdge;

    // assert(SubWinObject);
    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    // assert(sketchbitmap);
    FreeBitMap(sketchbitmap);
    sketchbitmap = NULL;

    // assert(wpa8tilebitmap);
    FreeBitMap(wpa8tilebitmap);
    wpa8tilebitmap = NULL;
}

MODULE void sketchboard_subtick(SWORD mousex, SWORD mousey)
{   if (mouseisover(sk1, mousex, mousey))
    {   setpointer(TRUE , SubWinObject, SubWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, SubWinObject, SubWindowPtr, FALSE);
}   }

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
EXPORT int strnicmp(const char *s1, const char *s2, size_t len)
{   int diff = 0;

    while (len-- && *s1 && *s2)
    {   if (*s1 != *s2)
        {   if ((diff = (int) ToLower(*s1) - (int) ToLower(*s2)))
            {   break;
        }   }
        s1++;
        s2++;
    }
    return diff;
}
EXPORT char* strupr(char* s)
{   char* s2;

    s2 = s;
    while (*s2 != EOS)
    {   *s2 = toupper(*s2);
        s2++;
    }

    return s;
}
EXPORT double strtod(const char* string, char** endPtr)
{   int sign, expSign = FALSE;
    double fraction, dblExp, *d;
    register const char *p;
    register int c;
    int exp = 0;		/* Exponent read from "EX" field. */
    int fracExp = 0;		/* Exponent that derives from the fractional
				 * part.  Under normal circumstatnces, it is
				 * the negative of the number of digits in F.
				 * However, if I is very long, the last digits
				 * of I get dropped (otherwise a long I with a
				 * large negative exponent could cause an
				 * unnecessary overflow on I alone).  In this
				 * case, fracExp is incremented one for each
				 * dropped digit. */
    int mantSize;		/* Number of digits in mantissa. */
    int decPt;			/* Number of mantissa digits BEFORE decimal
				 * point. */
    const char *pExp;		/* Temporarily holds location of exponent
				 * in string. */
PERSIST double powersOf10[] = {	/* Table giving binary powers of 10.  Entry */
    10.,			/* is 10^2^i.  Used to convert decimal */
    100.,			/* exponents into floating-point numbers. */
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
	mantSize -= 1;			/* One of the digits was the point. */
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

EXPORT void drawarrow(int x, int y, int dir)
{   int colour,
        i;

    for (i = 1; i >= 0; i--)
    {   if (i == 0)
        {   colour = MAZEWHITE;
        } else
        {   colour = MAZEBLACK;
        }

        if (dir == 0 || dir == 2) // north/south
        {   *(byteptr1[    (y * scaley) - yoffset + 3 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 4 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 5 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 7 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 8 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 9 + i] + xoffset + (x * scalex) + 6 + i) = pens[colour];

            if (dir == 0) // north
            {   *(byteptr1[(y * scaley) - yoffset + 4 + i] + xoffset + (x * scalex) + 5 + i) =
                *(byteptr1[(y * scaley) - yoffset + 4 + i] + xoffset + (x * scalex) + 7 + i) =
                *(byteptr1[(y * scaley) - yoffset + 5 + i] + xoffset + (x * scalex) + 4 + i) =
                *(byteptr1[(y * scaley) - yoffset + 5 + i] + xoffset + (x * scalex) + 8 + i) =
                *(byteptr1[(y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 3 + i) =
                *(byteptr1[(y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 9 + i) = pens[colour];
            } else // south
            {   *(byteptr1[(y * scaley) - yoffset + 8 + i] + xoffset + (x * scalex) + 5 + i) =
                *(byteptr1[(y * scaley) - yoffset + 8 + i] + xoffset + (x * scalex) + 7 + i) =
                *(byteptr1[(y * scaley) - yoffset + 7 + i] + xoffset + (x * scalex) + 4 + i) =
                *(byteptr1[(y * scaley) - yoffset + 7 + i] + xoffset + (x * scalex) + 8 + i) =
                *(byteptr1[(y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 3 + i) =
                *(byteptr1[(y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 9 + i) = pens[colour];
        }   }
        else
        {   // assert(dir == 1 || dir == 3); // east/west
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 3 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 4 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 5 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 6 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 7 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 8 + i) =
            *(byteptr1[    (y * scaley) - yoffset + 6 + i] + xoffset + (x * scalex) + 9 + i) = pens[colour];

            if (dir == 1) // east
            {   *(byteptr1[(y * scaley) - yoffset + 9 + i] + xoffset + (x * scalex) + 6 + i) =
                *(byteptr1[(y * scaley) - yoffset + 3 + i] + xoffset + (x * scalex) + 6 + i) =
                *(byteptr1[(y * scaley) - yoffset + 8 + i] + xoffset + (x * scalex) + 7 + i) =
                *(byteptr1[(y * scaley) - yoffset + 4 + i] + xoffset + (x * scalex) + 7 + i) =
                *(byteptr1[(y * scaley) - yoffset + 7 + i] + xoffset + (x * scalex) + 8 + i) =
                *(byteptr1[(y * scaley) - yoffset + 5 + i] + xoffset + (x * scalex) + 8 + i) = pens[colour];
            } else // west
            {   *(byteptr1[(y * scaley) - yoffset + 5 + i] + xoffset + (x * scalex) + 4 + i) =
                *(byteptr1[(y * scaley) - yoffset + 7 + i] + xoffset + (x * scalex) + 4 + i) =
                *(byteptr1[(y * scaley) - yoffset + 4 + i] + xoffset + (x * scalex) + 5 + i) =
                *(byteptr1[(y * scaley) - yoffset + 8 + i] + xoffset + (x * scalex) + 5 + i) =
                *(byteptr1[(y * scaley) - yoffset + 3 + i] + xoffset + (x * scalex) + 6 + i) =
                *(byteptr1[(y * scaley) - yoffset + 9 + i] + xoffset + (x * scalex) + 6 + i) = pens[colour];
}   }   }   }

EXPORT void drawsquare(int x, int y, int colour)
{   int xx, yy;

    for (yy = 0; yy <= scaley; yy++)
    {   for (xx = 0; xx <= scalex; xx++)
        {   *(byteptr1[(y * scaley) + yy - yoffset] + xoffset + (x * scalex) + xx) = pens[colour];
}   }   }

EXPORT void drawtriangle(int x, int y, int dir, int colour)
{   // assert(dir == 0 || dir == 2); // north/south

    if (dir == 0) // north (up)
    {   *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 3) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 8) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 9) =
        *(byteptr1[(y * scaley) + 8 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 7 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 6 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 5 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 4 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 4 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 5 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 6 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 7 - yoffset] + (x * scalex) + xoffset + 8) =
        *(byteptr1[(y * scaley) + 8 - yoffset] + (x * scalex) + xoffset + 8) = pens[colour];
    } else // south (down)
    {   *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 3) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 8) =
        *(byteptr1[(y * scaley) + 3 - yoffset] + (x * scalex) + xoffset + 9) =
        *(byteptr1[(y * scaley) + 4 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 5 - yoffset] + (x * scalex) + xoffset + 4) =
        *(byteptr1[(y * scaley) + 6 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 7 - yoffset] + (x * scalex) + xoffset + 5) =
        *(byteptr1[(y * scaley) + 8 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 9 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 8 - yoffset] + (x * scalex) + xoffset + 6) =
        *(byteptr1[(y * scaley) + 7 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 6 - yoffset] + (x * scalex) + xoffset + 7) =
        *(byteptr1[(y * scaley) + 5 - yoffset] + (x * scalex) + xoffset + 8) =
        *(byteptr1[(y * scaley) + 4 - yoffset] + (x * scalex) + xoffset + 8) = pens[colour];
}   }

EXPORT void drawhoriz(int x, int y, int colour, int mapheight, FLAG door)
{   int xx;


/*   -----         -------
   ---###--- or ----#####----
     -----         -------   
*/

    if (door)
    {   for (xx = 0; xx < n1; xx++)
        {   *(byteptr1[    (y * scaley) - yoffset     ] + xoffset + (x * scalex) + xx) = pens[MAZEBLACK];
        }
        for (xx = n1; xx < n2; xx++)
        {   *(byteptr1[    (y * scaley) - yoffset     ] + xoffset + (x * scalex) + xx) = pens[colour];
        }
        for (xx = n2; xx <= scalex; xx++)
        {   *(byteptr1[    (y * scaley) - yoffset     ] + xoffset + (x * scalex) + xx) = pens[MAZEBLACK];
        }
        for (xx = n1 - 1; xx <= n2; xx++)
        {   if (yoffset || y > 0)
            {   *(byteptr1[(y * scaley) - yoffset -  1] + xoffset + (x * scalex) + xx) = pens[MAZEBLACK];
            }
            if (yoffset || y < mapheight)
            {   *(byteptr1[(y * scaley) - yoffset +  1] + xoffset + (x * scalex) + xx) = pens[MAZEBLACK];
    }   }   }
    else
    {   for (xx = 0; xx <= scalex; xx++)
        {   *(byteptr1[    (y * scaley) - yoffset     ] + xoffset + (x * scalex) + xx) = pens[colour];
}   }   }

EXPORT void drawvert(int x, int y, int colour, int mapwidth, FLAG door)
{   int yy;

    if (door)
    {   for (yy = 0; yy < n1; yy++)
        {   *(byteptr1[    (y * scaley) - yoffset + yy] + xoffset + (x * scalex)     ) = pens[MAZEBLACK];
        }
        for (yy = n1; yy < n2; yy++)
        {   *(byteptr1[    (y * scaley) - yoffset + yy] + xoffset + (x * scalex)     ) = pens[colour];
        }
        for (yy = n2; yy <= scalex; yy++)
        {   *(byteptr1[    (y * scaley) - yoffset + yy] + xoffset + (x * scalex)     ) = pens[MAZEBLACK];
        }
        for (yy = n1 - 1; yy <= n2; yy++)
        {   if (xoffset || x > 0)
            {   *(byteptr1[(y * scaley) - yoffset + yy] + xoffset + (x * scalex) -  1) = pens[MAZEBLACK];
            }
            if (xoffset || x < mapwidth)
            {   *(byteptr1[(y * scaley) - yoffset + yy] + xoffset + (x * scalex) +  1) = pens[MAZEBLACK];
    }   }   }
    else
    {   for (yy = 0; yy <= scaley; yy++)
        {   *(byteptr1[    (y * scaley) - yoffset + yy] + xoffset + (x * scalex)     ) = pens[colour];
}   }   }

EXPORT ULONG getfimagename(void)
{   return (ULONG) funcinfo[function].fimagename; // cast for use as a tag
}
