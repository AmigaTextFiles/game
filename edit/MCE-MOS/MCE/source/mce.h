#define DECIMALVERSION    "15.6"
#define INTEGERVERSION    "15.60"
#define VERSIONSTRING     "\0$VER: MCE " INTEGERVERSION " (13.8.2025)" // always d.m.y format
#define RELEASEDATE       "13 August 2025" // full month and year
#define COPYRIGHT         "© 2011-2025 James Jacobs of Amigan Software"
#define TITLEBARTEXT      "MCE " DECIMALVERSION

/* 1. KEYWORDS -----------------------------------------------------------

Defined by AmigaOS are: IMPORT, UBYTE, UWORD, ULONG. */

#define TRANSIENT         auto   /* automatic variables */
#define MODULE            static /* external static (file-scope) */
#define PERSIST           static /* internal static (function-scope) */
#define FAST              static /* internal static (function-scope) */
#define DISCARD           (void) /* discarded return values */
#define elif              else if
#define acase             break; case
#define adefault          break; default
#define EXPORT
#define EOS               0
#define NUL               EOS
#define ENDOF(x)          &x[strlen(x)]

#define AddHLayout        LAYOUT_AddChild, HLayoutObject
#define AddVLayout        LAYOUT_AddChild, VLayoutObject
#define AddImage(x)       LAYOUT_AddImage, image[x], CHILD_NoDispose, TRUE
#define AddFImage(x)      LAYOUT_AddImage, fimage[x], CHILD_NoDispose, TRUE
#define AddSpace          LAYOUT_AddChild, SpaceObject, SpaceEnd
#define AddLabel(x)       LAYOUT_AddImage, LabelObject, LABEL_Text, x, LabelEnd
#define PopUpEnd          ChooserEnd
#define ListIsEmpty(x)    (!(((x)->lh_Head)->ln_Succ))
#define ListIsFull(x)     (((x)->lh_Head)->ln_Succ)

#ifndef DateBrowserObject           // OS4 defines this, OS3 doesn't
    #define DateBrowserObject       NewObject(DATEBROWSER_GetClass(), NULL
#endif
#ifndef DateBrowserEnd              // OS4 defines this, OS3 doesn't
    #define DateBrowserEnd          TAG_END)
#endif
#ifndef TextEditorObject            // OS4 defines this, OS3 doesn't
    #define TextEditorObject        NewObject(TEXTEDITOR_GetClass(), NULL
#endif
#ifndef TextEditorEnd               // OS4 defines this, OS3 doesn't
    #define TextEditorEnd           TAG_END)
#endif
#ifndef WA_ThinSizeGadget           // OS3 defines this, OS4 doesn't
    #define WA_ThinSizeGadget       (WA_Dummy + 97)
#endif
#ifndef BITMAP_Transparent          // OS4-only tag
    #define BITMAP_Transparent      (BITMAP_Dummy + 18)
#endif
#ifndef LABEL_VerticalAlignment     // OS4-only tag
    #define LABEL_VerticalAlignment (LABEL_Dummy + 9)
#endif
#ifndef WINDOW_Qualifier
    #define WINDOW_Qualifier        (WINDOW_Dummy + 53)
#endif
#ifndef LVALIGN_BASELINE            // OS4-only tag
    #define LVALIGN_BASELINE        1
#endif
#define TickOrCheckBoxObject        CheckBoxObject
#ifndef WPOS_ENTIRESCREEN // V47 tag
    #define WPOS_ENTIRESCREEN       (6L)
#endif
#ifndef REQ_Image                   // OS3.2 & OS4 tag
    #define REQ_Image               (REQ_Dummy+7)
#endif
#ifndef REQIMAGE_INFO
    #define REQIMAGE_INFO           1
#endif
#ifndef REQIMAGE_WARNING
    #define REQIMAGE_WARNING        2
#endif
#ifndef REQIMAGE_ERROR
    #define REQIMAGE_ERROR          3
#endif
#ifndef CIF_CENTER
    #define CIF_CENTER              16
#endif
#ifndef CIF_RIGHT
    #define CIF_RIGHT               32
#endif
#ifndef LBMSORT_FORWARD
    #define LBMSORT_FORWARD         0 // down arrow
#endif
#ifndef LBMSORT_REVERSE
    #define LBMSORT_REVERSE         1 // up arrow
#endif
#ifndef LBNCA_FillPen
    #define LBNCA_FillPen           (LBNA_Dummy+29)
#endif
#ifndef LISTBROWSER_AutoWheel       // OS3.2 tag
    #define LISTBROWSER_AutoWheel   (LISTBROWSER_Dummy + 64)
#endif
#ifndef LISTBROWSER_Striping
    #define LISTBROWSER_Striping    (LISTBROWSER_Dummy + 62)
#endif
#ifndef LBS_ROWS
    #define LBS_ROWS                1
#endif
#ifndef STRINGA_AlignPart           // OS3.2+BB2 tag
    #define STRINGA_AlignPart       (REACTION_Dummy + 0x0055018)
#endif
#ifndef BUTTON_TextPadding
    #define BUTTON_TextPadding      (BUTTON_Dummy + 40)
#endif

#ifndef __amigaos4__
    #define GetHead(x) ((x)->lh_Head) // wants struct List*
    #define GetSucc(x) ((x)->ln_Succ) // wants struct Node*. Note: OS4 version works differently!
#endif

#define ZButtonObject ButtonObject, GA_TabCycle, TRUE

#ifdef MEASUREWINDOWS
    #define SPECIALWPOS     WPOS_CENTERMOUSE
#else
    #ifdef __amigaos4__
        #define SPECIALWPOS (CustomScreenPtr ? WPOS_CENTERMOUSE : WPOS_FULLSCREEN)
    #else
        #define SPECIALWPOS ((WindowBase->lib_Version >= 47) ? WPOS_ENTIRESCREEN : (CustomScreenPtr ? WPOS_CENTERMOUSE : WPOS_FULLSCREEN))
    #endif
#endif

#ifndef __LCLINT__
    #ifndef __amigaos4__
        #define USED
        #define ZERO       (BPTR) NULL
        #ifndef __MORPHOS__
            #define ASM    __asm
            #define REG(x) register __ ## x
        #else
            #define ASM
            #define REG(x)
        #endif
    #endif
#endif
#ifndef __amigaos4__
    #define UNUSED
#endif

#ifdef __SASC
    #define CHIP               __chip
    typedef signed char        FLAG;    /*  8-bit signed quantity (replaces BOOL) */
    typedef signed char        SBYTE;   /*  8-bit signed quantity (replaces Amiga BYTE) */
    typedef signed short       SWORD;   /* 16-bit signed quantity (replaces Amiga WORD) */
    typedef signed long        SLONG;   /* 32-bit signed quantity (same as LONG) */
#else
    #define CHIP
#endif

#if defined(__GNUC__) || defined(__VBCC__)
    typedef signed char        FLAG;
    typedef signed char        SBYTE;   /*  8-bit signed quantity (replaces Amiga BYTE) */
    typedef signed short       SWORD;   /* 16-bit signed quantity (replaces Amiga WORD) */
    typedef signed long        SLONG;   /* 32-bit signed quantity (same as LONG) */
    #if EXIT_FAILURE == 1
        #undef  EXIT_FAILURE
        #define EXIT_FAILURE   20
    #endif
#endif

#if defined(__MORPHOS__) || defined(__amigaos4__)
    #define __aligned
#endif

// from newmouse.h
#ifndef NM_WHEEL_UP
    #define NM_WHEEL_UP   (0x7A)
#endif
#ifndef NM_WHEEL_DOWN
    #define NM_WHEEL_DOWN (0x7B)
#endif

#ifndef IDCMP_EXTENDEDMOUSE
    // ie. when compiling on OS3.x systems
    #define IDCMP_EXTENDEDMOUSE 0x08000000
    struct IntuiWheelData
    {   UWORD Version;
        UWORD Reserved;
        WORD  WheelX;
        WORD  WheelY;
    };
    #define IMSGCODE_INTUIWHEELDATA (1<<15)
#endif

// 2. DEFINES ------------------------------------------------------------

// #define VERBOSE
// if you want extra information

#define OS_ANY  0
#define OS_12  33
#define OS_13  34
#define OS_20  36
#define OS_204 37
#define OS_21  38
#define OS_30  39
#define OS_31  40
#define OS_35  44
#define OS_39  45
#define OS_32  47
#define OS_40  51
#define OS_41  53

#define CUSTOMSCREENX     1024
#ifdef __amigaos4__
    #define CUSTOMSCREENY  900
#else
    #define CUSTOMSCREENY  768
#endif

#define IOBUFFERSIZE    901120 // enough for Grand Monster Slam

#define GIDS_MAX           601 // GIDS_PIR + 3 for About/RA subwindows
#define MAXWIDTH          1024 // rogue (ss=1024,          rogue= 640, wime=640, gar=512, rorke=508,   sla=500, pir=320, ce =272, q2 =270, fta=256,   cov=241,  p3=204, hf=200, dw=192, zerg=180)
#define MAXHEIGHT         1024 // p3    (ss=1024, sw=1024,    if=1020,   p3=512, gar=512,  wime=400, rorke=275, q2 =270, fta=256, sla=244, cov=241, rogue=224, pir=201, dw=192, hf=185, zerg=184, ce=128)
#define DISPLAY1HEIGHT MAXHEIGHT
#define DISPLAY1SIZE   1048576

#define DISPLAY2HEIGHT     512
#define DISPLAY2SIZE     70400
/* if        160*440=70,400
   silent   1024* 64=65,536
   qa        256*256=65,536
   sw        256*256=65,536
   garrison  128*512=65,536 
   druid2   1024* 32=32,768
   rf        448* 96=43,008
   bj        352* 32=11,264
   robin     132* 72= 9,504
   dm        264* 24= 6,336
   goal     not much */

#define SBGADGETS         2 // counting from 1
#define SBIMAGES          4 // counting from 1
#define AISSIMAGES       83 // counting from 1 (ie. 0..82)

#define MEDFIELD         32
#define LONGFIELD        64
#define VLONGFIELD      256
#define MAX_PATH        512 // OS3 supports about 255 chars for each of path and filename

#define ONE_BILLION      1000000000
#define THIRTYBITS       1410065407
#define TWO_BILLION      2000000000
#define SLONG_MAX        2147483647

#define FONTX             8
#define FONTY             8

#define MOVE_LEFT         move_leftorup
#define MOVE_RIGHT        move_rightordown
#define MOVE_UP           move_leftorup
#define MOVE_DOWN         move_rightordown

#define ROUNDTOLONG(x)    ((((x) + 15) >> 4) << 4)
#define GFXINIT(x,y)      (ROUNDTOLONG(x) * (y))

#define NewToolWindow WindowObject,             \
    WA_Activate,            TRUE,               \
    WA_CloseGadget,         TRUE,               \
    WA_DepthGadget,         TRUE,               \
    WA_DragBar,             TRUE,               \
    WA_IDCMP,               IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_INTUITICKS | IDCMP_MOUSEMOVE | IDCMP_NEWSIZE, \
    WINDOW_IDCMPHook,       &ToolHookStruct,    \
    WINDOW_IDCMPHookBits,   IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_INTUITICKS | IDCMP_MOUSEMOVE, \
    WA_PubScreen,           ScreenPtr,          \
    WA_ScreenTitle,         TITLEBARTEXT,       \
    WA_SmartRefresh,        TRUE,               \
    (winbox[function].Width  != -1) ? WA_InnerWidth   : TAG_IGNORE, (ULONG) winbox[function].Width,  \
    (winbox[function].Height != -1) ? WA_InnerHeight  : TAG_IGNORE, (ULONG) winbox[function].Height, \
    IconifiedIcon ? WINDOW_Icon       : TAG_IGNORE, IconifiedIcon, \
    WINDOW_AppPort,         AppPort,            \
    WINDOW_AppWindow,       TRUE,               \
    showtoolbar   ? WINDOW_GadgetHelp : TAG_IGNORE, TRUE,          \
    showtoolbar   ? WINDOW_HintInfo   : TAG_IGNORE, HintInfoPtr,   \
    WINDOW_IconifyGadget,   CustomScreenPtr ? FALSE : TRUE,        \
    WINDOW_IconTitle,       "MCE",              \
    WINDOW_JumpScreensMenu, TRUE,               \
    WINDOW_MenuStrip,       MenuPtr,            \
    WINDOW_PopupGadget,     TRUE,               \
    WINDOW_UniqueID,        getfimagename()

#define NewSubWindow WindowObject,              \
    WA_Activate,            TRUE,               \
    WA_CloseGadget,         TRUE,               \
    WA_DepthGadget,         TRUE,               \
    WA_DragBar,             TRUE,               \
    WA_IDCMP,               IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_INTUITICKS, \
    WA_PubScreen,           ScreenPtr,          \
    WA_ScreenTitle,         TITLEBARTEXT,       \
    WINDOW_IDCMPHook,       &ToolSubHookStruct, \
    WINDOW_IDCMPHookBits,   IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_INTUITICKS, \
    WINDOW_PopupGadget,     TRUE

#define AllButton(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                   \
    GA_ID,                 x,                   \
    GA_RelVerify,          TRUE,                \
    GA_Image,                                   \
    LabelObject,                                \
        LABEL_Image,       aissimage[6],        \
        CHILD_NoDispose,   TRUE,                \
        LABEL_DrawInfo,    DrawInfoPtr,         \
        LABEL_VerticalAlignment, LVALIGN_BASELINE, \
        LABEL_Text,        " All ",             \
    LabelEnd,                                   \
ButtonEnd

#define NoneButton(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                   \
    GA_ID,                 x,                   \
    GA_RelVerify,          TRUE,                \
    GA_Image,                                   \
    LabelObject,                                \
        LABEL_Image,       aissimage[7],        \
        CHILD_NoDispose,   TRUE,                \
        LABEL_DrawInfo,    DrawInfoPtr,         \
        LABEL_VerticalAlignment, LVALIGN_BASELINE, \
        LABEL_Text,        " None ",            \
    LabelEnd,                                   \
ButtonEnd

#define InvertButton(x)    LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                   \
    GA_ID,                 x,                   \
    GA_RelVerify,          TRUE,                \
    GA_Image,                                   \
    LabelObject,                                \
        LABEL_Image,       aissimage[8],        \
        CHILD_NoDispose,   TRUE,                \
        LABEL_DrawInfo,    DrawInfoPtr,         \
        LABEL_VerticalAlignment, LVALIGN_BASELINE, \
        LABEL_Text,        " Invert ",          \
    LabelEnd,                                   \
ButtonEnd

#define HTripleButton(x, y, z) AddHLayout,              \
                                   AllButton(   x),     \
                                   InvertButton(y),     \
                                   NoneButton(  z),     \
                               LayoutEnd,               \
                               CHILD_WeightedHeight, 0

#define VTripleButton(x, y, z) AllButton(       x),     \
                               CHILD_WeightedHeight, 0, \
                               InvertButton(    y),     \
                               CHILD_WeightedHeight, 0, \
                               NoneButton(      z),     \
                               CHILD_WeightedHeight, 0


#define ClearButton(x, y)  LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[9],          \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define ResetButton(x, y)  LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[17],         \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define MaximizeButton(x, y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[10],         \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define SortButton(x, y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[15],         \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define MapButton(x, y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[16],         \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define MapButton2(x, y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject,                                    \
    GA_ID,                 x,                     \
    GA_RelVerify,          TRUE,                  \
    GA_Image,                                     \
    LabelObject,                                  \
        LABEL_Image,       aissimage[79],         \
        CHILD_NoDispose,   TRUE,                  \
        LABEL_DrawInfo,    DrawInfoPtr,           \
        LABEL_VerticalAlignment, LVALIGN_BASELINE,\
        LABEL_Text,        " " y " ",             \
    LabelEnd,                                     \
ButtonEnd

#define AddToolbar(a)                                       \
showtoolbar ? LAYOUT_AddChild     : TAG_IGNORE, gadgets[a], \
showtoolbar ? CHILD_WeightedWidth : TAG_IGNORE, 0

// ASCII values (vanillakey)
#define EOS               0 /* end of string */
#define TAB               9 /* horizontal tab */
#define LF               10 /* linefeed */
#define CR               13 /* carriage return */
#define CTRLZ            26
#define ESCAPE           27
#define QUOTE            34 /* " */

#define FUNC_MENU         0
#define FUNC_ARAZOK       1
#define FUNC_PSYGNOSIS    2
#define FUNC_BT           3
#define FUNC_BATTLETECH   4
#define FUNC_BW           5
#define FUNC_BOMBJACK     6
#define FUNC_BUCK         7
#define FUNC_EPYX         8
#define FUNC_CF           9
#define FUNC_COS         10
#define FUNC_COK         11
#define FUNC_COV         12
#define FUNC_CSD         13
#define FUNC_CE          14
#define FUNC_DC          15
#define FUNC_ICOM        16
#define FUNC_DW          17
#define FUNC_DRA         18
#define FUNC_DRUID2      19
#define FUNC_DM          20
#define FUNC_EOB         21
#define FUNC_FA18        22
#define FUNC_FTA         23
#define FUNC_SS          24
#define FUNC_GARRISON    25
#define FUNC_GOAL        26
#define FUNC_GMS         27
#define FUNC_GIANA       28
#define FUNC_GRIDSTART   29
#define FUNC_ROGUE       30
#define FUNC_HOL         31
#define FUNC_HILLSFAR    32
#define FUNC_IM2         33
#define FUNC_IF          34
#define FUNC_ICFTD       35
#define FUNC_KEEF        36
#define FUNC_KQ          37
#define FUNC_LASTNINJA   38
#define FUNC_LOF         39
#define FUNC_LOL         40
#define FUNC_MERCENARY   41
#define FUNC_MM          42
#define FUNC_INTERPLAY   43
#define FUNC_NEUROMANCER 44
#define FUNC_NITRO       45
#define FUNC_POLARWARE   46
#define FUNC_PANZA       47
#define FUNC_PHANTASIE   48
#define FUNC_PINBALL     49
#define FUNC_PIRATES     50
#define FUNC_POR         51
#define FUNC_QUADRALIEN  52
#define FUNC_Q2          53
#define FUNC_RAGNAROK    54
#define FUNC_ROTJ        55
#define FUNC_ROBIN       56
#define FUNC_ROCKFORD    57
#define FUNC_RORKE       58
#define FUNC_SHADOW      59
#define FUNC_SIDEWINDER  60
#define FUNC_SINBAD      61
#define FUNC_SLAYGON     62
#define FUNC_SPEEDBALL   63
#define FUNC_SYNDICATE   64
#define FUNC_TOA         65
#define FUNC_TOL         66
#define FUNC_TVS         67
#define FUNC_ULTIMA      68
#define FUNC_WIME        69
#define FUNC_WIZ         70
#define FUNC_ZERG        71
#define FUNCTIONS        FUNC_ZERG // counting from 1 (not counting menu)

#define SERIALIZE_READ    0
#define SERIALIZE_WRITE   1

#define SCAN_Q           16
#define SCAN_W           17
#define SCAN_E           18
#define SCAN_R           19
#define SCAN_T           20
#define SCAN_Y           21
#define SCAN_U           22
#define SCAN_I           23
#define SCAN_O           24
#define SCAN_P           25
#define SCAN_N1          29
#define SCAN_N2          30
#define SCAN_N3          31
#define SCAN_A           32
#define SCAN_S           33
#define SCAN_D           34
#define SCAN_F           35
#define SCAN_G           36
#define SCAN_H           37
#define SCAN_J           38
#define SCAN_K           39
#define SCAN_L           40
#define SCAN_N4          45
#define SCAN_N5          46
#define SCAN_N6          47
#define SCAN_Z           49
#define SCAN_X           50
#define SCAN_C           51
#define SCAN_V           52
#define SCAN_B           53
#define SCAN_N           54
#define SCAN_M           55
#define SCAN_PERIOD      57
#define SCAN_SLASH       58
#define SCAN_N7          61
#define SCAN_N8          62
#define SCAN_N9          63
#define SCAN_SPACEBAR    64
#define SCAN_BACKSPACE   65
#define SCAN_TAB         66
#define SCAN_ENTER       67 // numeric ENTER
#define SCAN_RETURN      68
#define SCAN_ESCAPE      69
#define SCAN_DEL         70
#define SCAN_MI          74 // numeric -
#define SCAN_UP          76
#define SCAN_DOWN        77
#define SCAN_RIGHT       78
#define SCAN_LEFT        79
#define SCAN_PL          94 // numeric +
#define SCAN_HELP        95

#define MALE              0
#define FEMALE            1

#define BITMAP_AMIGAN     0
//   6 COV bitmaps (  1..  6)
//   8 U4  bitmaps (  7.. 14)
//  31 FTA bitmaps ( 15.. 45) + 5 (221..225)
//   6 U3  bitmaps ( 46.. 51)
//   4 U5  bitmaps ( 52.. 55)
//   1 spare       ( 56     )
//  12 Q2  bitmaps ( 57.. 68)
//   5 HF  bitmaps ( 69.. 73)
//  29 TOL bitmaps ( 74..102)
//   1 U6  bitmap  (103     ) here
//   5 Pir bitmaps (104..108) + 4 (217..220)
//   9 W6  bitmaps (109..117)
//   1 spare       (118     )
//   1 BT  bitmap  (119     ) here
//  15 LOL bitmaps (120..134)
//  12 U6  bitmaps (135..146)
//  16 BW  bitmaps (147..162)
//   6 IM2 bitmaps (163..168)
//   1 spare       (169     )
//  17 Pha bitmaps (170..186)
//  15 LN  bitmaps (187..201)
//  15 Syn bitmaps (202..216)
//   4 Pirates ones here
//   5 FTA ones here
#define BITMAP_MALE     226
#define BITMAP_FEMALE   227
//  12 HOL ones here
//  15 Bard's Tale ones here
//   4 spare ones here
#define BITMAP_OK       259
#define BITMAP_CANCEL   260
#define BITMAP_REACTION 261
//   5 Rorke's Drift ones here
//   2 Bard's Tale ones here
//  74 Transylvania one here
//   5 Conflict Europe ones here
//   3 Speedball ones here
//   1 spare one here
//   9 Obliterator ones here
//  16 Cannon Fodder ones here
//   3 Speedball 1 ones here
//  68 Oo-Topos ones here
//   6 Quadralien ones here
//  46 Arazok's Tomb ones here
//  31 War in Middle Earth ones here
//  16 Ragnarok ones here
//   8 Dark Castle ones here
// 143 Bloodwych ones here
//  30 Speedball 2 ones here
//  10 Robin Hood ones here
//  11 HOL ones here
//  25 Mindshadow ones here
//  23 Borrowed Time ones here
//  21 TTITT ones here
//  80 KQ1 ones here
//  93 KQ2 ones here
//  79 KQ3 ones here
//  75 SQ1 ones here
#define BITMAPS       (1145 + 1)

#define IMAGE_UNAVAILABLE    56
#define IMAGE_BITMAP         57
#define IMAGE_BUTTON         58
#define IMAGE_CHECKBOX       59
#define IMAGE_CHOOSER        60
#define IMAGE_CLICKTAB       61
#define IMAGE_CLOCK          62
#define IMAGE_FUELGAUGE      63
#define IMAGE_GRADIENTSLIDER 64
#define IMAGE_INTEGER        65
#define IMAGE_LABEL          66
#define IMAGE_LAYOUT         67
#define IMAGE_LISTBROWSER    68
#define IMAGE_PALETTE        69
#define IMAGE_RADIOBUTTON    70
#define IMAGE_SCROLLER       71
#define IMAGE_SKETCHBOARD    72
#define IMAGE_SLIDER         73
#define IMAGE_SPACE          74
#define IMAGE_SPEEDBAR       75
#define IMAGE_STRING         76
#define IMAGE_TEXTEDITOR     77
#define IMAGE_VIRTUAL        78

#define FIRSTGADGETIMAGE     56
#define LASTGADGETIMAGE      78

#define FIRSTQUALIFIER 0x60
#define LASTQUALIFIER  0x67
#define KEYUP          0x80 /* key release */

// menus

#define MN_PROJECT        0
#define MN_VIEW           1
#define MN_TOOLS          2
#define MN_HELP           3

// Project menu

#define IN_OPEN           0
#define IN_REVERT         1
// ---------------------- 2
#define IN_SAVE           3
#define IN_SAVEAS         4
// ---------------------- 5
#define IN_ICONIFY        6
#define IN_QUIT           7

// View menu

#define IN_POINTER        0
#define IN_TOOLBAR        1

// Tools menu

#define IN_MAINMENU       0
// ---------------------  1
#define IN_PAGE1          2
#define IN_PAGE2          3
#define IN_PAGE3          4
#define IN_PAGE4          5
#define IN_PAGE5          6

// A-C submenu (page 1) (14 items)
#define SN_ARAZOK         0
#define SN_PSYGNOSIS      1
#define SN_BT             2
#define SN_BA             3
#define SN_BW             4
#define SN_BOMBJACK       5
#define SN_BUCK           6
#define SN_EPYX           7
#define SN_CF             8
#define SN_COS            9
#define SN_COK           10
#define SN_COV           11
#define SN_CSD           12
#define SN_CE            13

// D-Gre submenu (page 2) (14 items)
#define SN_DC             0
#define SN_ICOM           1
#define SN_DW             2
#define SN_DRA            3
#define SN_DRUID2         4
#define SN_DM             5
#define SN_EOB            6
#define SN_FA18           7
#define SN_FTA            8
#define SN_SS             9
#define SN_GARRISON      10
#define SN_GOAL          11
#define SN_GMS           12
#define SN_GIANA         13

// Gri-M submenu (page 3) (15 items)
#define SN_GRIDSTART      0
#define SN_ROGUE          1
#define SN_HOL            2
#define SN_HILLSFAR       3
#define SN_IM2            4
#define SN_IF             5
#define SN_ICFTD          6
#define SN_KEEF           7
#define SN_KQ             8
#define SN_LASTNINJA      9
#define SN_LOF           10
#define SN_LOL           11
#define SN_MERCENARY     12
#define SN_MM            13
#define SN_INTERPLAY     14

// N-Roc submenu (page 4) (14 items)
#define SN_NEUROMANCER    0
#define SN_NITRO          1
#define SN_POLARWARE      2
#define SN_PANZA          3
#define SN_PHANTASIE      4
#define SN_PINBALL        5
#define SN_PIRATES        6
#define SN_POR            7
#define SN_QUADRALIEN     8
#define SN_Q2             9
#define SN_RAGNAROK      10
#define SN_ROTJ          11
#define SN_ROBIN         12
#define SN_ROCKFORD      13

// Ror-Z submenu (page 5) (14 items)
#define SN_RORKE          0
#define SN_SHADOW         1
#define SN_SIDEWINDER     2
#define SN_SINBAD         3
#define SN_SLAYGON        4
#define SN_SPEEDBALL      5
#define SN_SYNDICATE      6
#define SN_TOA            7
#define SN_TOL            8
#define SN_TVS            9
#define SN_ULTIMA        10
#define SN_WIME          11
#define SN_WIZ           12
#define SN_ZERG          13

// Help menu

#define IN_FORMATS        0
#define IN_MANUAL         1
// ---------------------- 2
#define IN_UPDATE         3
// ---------------------- 4
#define IN_REACTION       5
#define IN_ABOUT          6

#define PENDING_QUIT         1
#define PENDING_LEFT         2
#define PENDING_RIGHT        4
#define PENDING_JUMPSCREEN   8
#define PENDING_RESIZE      16
#define PENDING_CHANGEPAGE  32
#define PENDING_MAPREFRESH  64

#ifndef WINDOW_PopupGadget
    #define WINDOW_PopupGadget     (WINDOW_Dummy + 60)
#endif
#ifndef WINDOW_JumpScreensMenu
    #define WINDOW_JumpScreensMenu (WINDOW_Dummy + 63)
#endif
#ifndef WINDOW_UniqueID
    #define WINDOW_UniqueID        (WINDOW_Dummy + 64)
#endif
#ifndef WMHI_JUMPSCREEN
    #define WMHI_JUMPSCREEN        (18L<<16)
#endif

#define FLAG_A             1 // basically the same as "R"
#define FLAG_C             2
#define FLAG_G             4
#define FLAG_H             8
#define FLAG_I            16
#define FLAG_L            32
#define FLAG_R            64 // basically the same as "A"
#define FLAG_S           128

#define CLOCKPEN_BLACK       0
#define CLOCKPEN_DARKBLUE    1
#define CLOCKPEN_GREY        2
#define CLOCKPEN_RED         3
#define CLOCKPENS            4

#define MAZEBLACK            0
#define MAZEWHITE            1
#define PENS                64 // used by rf.c

#define DRAWPOINT(x, y, colour) *(byteptr1[y] + x) = pens[colour]

#define COMMAND_CUT          0
#define COMMAND_COPY         1
#define COMMAND_PASTE        2
#define COMMAND_ERASE        3
#define COMMAND_UNDO         4
#define COMMAND_REDO         5
#define COMMANDNODES         6 // 0.. 5

#define PAINT_FREEHANDDOT    0
#define PAINT_FREEHANDLINE   1
#define PAINT_LINE           2
#define PAINT_RECT           3
#define PAINT_FILLEDRECT     4
#define PAINT_ELLIPSE        5
#define PAINT_FILLEDELLIPSE  6
#define PAINT_FLOODFILL      7
#define PAINT_SELECTCOLOUR   8
#ifdef __amigaos4__
#define PAINT_GRID           9
#define PAINTNODES          10 // 0..10
#else
#define PAINT_MARK           9
#define PAINT_MOVE          10
#define PAINT_GRID          11
#define PAINTNODES          12 // 0..11
#endif

// bard
#define BT1                  0
#define BT2                  1
#define BT3                  2
#define BTCS                 3
// silent
#define FIREPOWER            0
#define TURBO                1
// ph
#define PHANTASIE1           0
#define PHANTASIE3           1
// sw
#define SIDEWINDER1          0
#define SIDEWINDER2          1

// 3. GLOBAL FUNCTIONS ---------------------------------------------------

// mce.c
EXPORT void load_aiss_images(int thefirst, int thelast);
EXPORT void load_fimage(int which);
// module support
EXPORT void loop(void);
EXPORT void rq(STRPTR text);
EXPORT void say(STRPTR text, ULONG reqimage);
EXPORT void cleanexit(SBYTE rc);
EXPORT void clearkybd(void);
EXPORT void closewindow(void);
EXPORT ULONG getfimagename(void);
EXPORT void help_reaction(void);
EXPORT void help_about(void);
EXPORT void openwindow(int gid);
EXPORT FLAG handlemenus(UWORD code);
EXPORT FLAG confirm(void);
EXPORT int ask(STRPTR question, STRPTR answers);
EXPORT void load_images(int thefirst, int thelast);
EXPORT void ch_load_images(int thefirst, int thelast, const STRPTR* ChooserOptions, struct List* ListPtr);
EXPORT void ch_load_aiss_images(int thefirst, int thelast, const STRPTR* ChooserOptions, struct List* ListPtr);
EXPORT void makesexlist(void);
EXPORT FLAG mouseisover(int gid, SWORD mousex, SWORD mousey);
EXPORT void setpointer(FLAG newcrosshair, Object* winobj, struct Window* winptr, FLAG force);
EXPORT void westwood(void);
// screen support
EXPORT void lockscreen(void);
EXPORT void unlockscreen(void);
// file support
EXPORT void writeout(STRPTR pathname, int size);
EXPORT ULONG getsize(STRPTR filename);
EXPORT UBYTE getubyte(void);
EXPORT SBYTE getsbyte(void);
EXPORT UWORD getuword(void);
EXPORT SWORD getiword(void);
EXPORT ULONG getulong(void);
EXPORT SLONG getilong(void);
EXPORT void serialize1to1(UBYTE* thevar);
EXPORT void serialize1(ULONG* thevar);
EXPORT void serialize1s(SLONG* thevar);
EXPORT void serialize2uword(UWORD* thevar);
EXPORT void serialize2ulong(ULONG* thevar);
EXPORT void serialize2iword(UWORD* thevar);
EXPORT void serialize2ilong(ULONG* thevar);
EXPORT void serialize4(ULONG* thevar);
EXPORT void serialize4i(ULONG* thevar);
EXPORT void serialize_bcd1(ULONG* thevar);
EXPORT void serialize_bcd2(ULONG* thevar);
EXPORT void serialize_bcd3(ULONG* thevar);
EXPORT void serialize_bcd4(ULONG* thevar);
EXPORT void serstring(STRPTR thestring);
EXPORT FLAG Exists(STRPTR name);
EXPORT BPTR LockQuiet(const char* name, LONG mode);
// ASL support
EXPORT FLAG asl(STRPTR message, STRPTR pattern, FLAG saving);
EXPORT void project_open(FLAG loadas);
// cli handling
EXPORT FLAG checkbreak(ULONG gid);
// hooks
EXPORT void InitHook(struct Hook* hook, ULONG (*func)(), void* data);
EXPORT ULONG ToolHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg);
EXPORT ULONG ToolSubHookFunc(UNUSED struct Hook* h, UNUSED VOID* o, VOID* msg);
// list handling
EXPORT void make_speedbar_list(int gid);
EXPORT void lb_makelist(struct List* ListPtr, const STRPTR* NamesArray, int elements);
EXPORT void lb_makechecklist(struct List* ListPtr, const STRPTR* NamesArray, int elements);
EXPORT void lb_addnode(struct List* ListPtr, STRPTR text);
EXPORT void lb_clearlist(struct List* ListPtr);
EXPORT void lb_scroll_up(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT void lb_scroll_down(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT FLAG lb_move_up(int gid, struct Window* WindowPtr, UWORD qual, ULONG* thevar, ULONG min, int jump);
EXPORT FLAG lb_move_down(int gid, struct Window* WindowPtr, UWORD qual, ULONG* thevar, ULONG min, int jump);
EXPORT void vi_scroll_left(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT void vi_scroll_right(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT void vi_scroll_up(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT void vi_scroll_down(int gid, struct Window* WindowPtr, UWORD qual);
EXPORT void ch_clearlist(struct List* ListPtr);
EXPORT void sb_clearlist(struct List* ListPtr);
EXPORT struct List* getlist(int gad);
EXPORT void detach(int gad);
EXPORT void reattach(int gad, struct List* ListPtr);
EXPORT void lb_select(int gad, ULONG value);
// EXPORT void printlist(struct List* ListPtr);
// gadget handling, etc.
EXPORT void either_in(int gid, ULONG* var);
EXPORT void either_cb(int gid, ULONG* var);
EXPORT void subeither_cb(int gid, ULONG* var);
EXPORT void either_ch(int gid, ULONG* var);
EXPORT void either_gs(int gid, ULONG* var);
EXPORT void either_pl(int gid, ULONG* var);
EXPORT void either_ra(int gid, ULONG* var);
EXPORT void either_st(int gid, STRPTR thestring);
EXPORT void either_sl(int gid, ULONG* var);
EXPORT void write_ra(int gid, ULONG theulong);
EXPORT void ghost(int gid, int logic);
EXPORT void ghost_st(int gid, int logic);
EXPORT void subloop(void);
EXPORT FLAG gameopen(FLAG loadas);
EXPORT FLAG gamesave(STRPTR pattern, STRPTR gamename, FLAG saveas, LONG goodsize, int kind, FLAG quiet);
EXPORT void map_leftorup(   UWORD qual, int width, int* location, int gid, struct Window* WindowPtr);
EXPORT void map_rightordown(UWORD qual, int width, int* location, int gid, struct Window* WindowPtr);
EXPORT void move_leftorup(UWORD qual, int* thevar, int unit, int jump);
EXPORT void move_rightordown(UWORD qual, int* thevar, int unit, int jump, ULONG max);
EXPORT void getclockpens(void);
EXPORT void make_clock(int gid);
EXPORT void make_seconds_clock(int gid);
EXPORT void zstrncpy(char* to, const char* from, size_t n);
EXPORT void setup_bm(int which, int width, int height, struct Window* WindowPtr);
EXPORT void free_bm(int which);
EXPORT void pointercolours(UBYTE red17, UBYTE green17, UBYTE blue17, UBYTE red18, UBYTE green18, UBYTE blue18, UBYTE red19, UBYTE green19, UBYTE blue19);
// sketchboard support
EXPORT void gfxwindow(void);
EXPORT FLAG sketchboard_subgadget(ULONG gid, UWORD code);
EXPORT FLAG sketchboard_subkey(UWORD code);
// 3D RPG map functions
EXPORT void drawarrow(int x, int y, int dir);
EXPORT void drawsquare(int x, int y, int colour);
EXPORT void drawtriangle(int x, int y, int dir, int colour);
EXPORT void drawhoriz(int x, int y, int colour, int mapheight, FLAG door);
EXPORT void drawvert(int x, int y, int colour, int mapwidth, FLAG door);

EXPORT void arazok_main(void);
EXPORT void arazok_close(void);
EXPORT void arazok_exit(void);
EXPORT FLAG arazok_open(FLAG loadas);
EXPORT void arazok_save(FLAG saveas);
EXPORT void arazok_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG arazok_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG arazok_subkey(UWORD code);
EXPORT void arazok_subtick(SWORD mousex, SWORD mousey);
EXPORT void arazok_getpens(void);
EXPORT void arazok_uniconify(void);

EXPORT void bt_main(void);
EXPORT void bt_die(void);
EXPORT void bt_close(void);
EXPORT void bt_exit(void);
EXPORT FLAG bt_open(FLAG loadas);
EXPORT void bt_save(FLAG saveas);
EXPORT void bt_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG bt_subgadget(ULONG gid, UWORD code);
EXPORT FLAG bt_subkey(UWORD code, UWORD qual);
EXPORT void bt_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT void bt_getpens(void);
EXPORT void bt_drawmap(void);
EXPORT void bt_sublmb(SWORD mousex, SWORD mousey);
EXPORT void bt_uniconify(void);

EXPORT void ba_main(void);
EXPORT void ba_close(void);
EXPORT void ba_exit(void);
EXPORT FLAG ba_open(FLAG loadas);
EXPORT void ba_save(FLAG saveas);
EXPORT void ba_loop(ULONG gid, UNUSED ULONG code);

EXPORT void bw_main(void);
EXPORT void bw_die(void);
EXPORT void bw_close(void);
EXPORT void bw_exit(void);
EXPORT FLAG bw_open(FLAG loadas);
EXPORT void bw_save(FLAG saveas);
EXPORT void bw_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG bw_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG bw_subkey(UWORD code, UWORD qual);

EXPORT void bj_main(void);
EXPORT void bj_close(void);
EXPORT void bj_exit(void);
EXPORT FLAG bj_open(FLAG loadas);
EXPORT void bj_save(FLAG saveas);
EXPORT void bj_loop(ULONG gid, UNUSED ULONG code);
EXPORT void bj_getpens(void);
EXPORT void bj_freepens(void);
EXPORT void bj_uniconify(void);
EXPORT void bj_drawmap(FLAG all);
EXPORT void bj_tick(SWORD mousex, SWORD mousey);
EXPORT void bj_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void bj_mouse(SWORD mousex, SWORD mousey);
EXPORT void bj_key(UBYTE scancode);
EXPORT void bj_realpen_to_table(void);
EXPORT void bj_tablepen_to_real(void);

EXPORT void buck_main(void);
EXPORT void buck_die(void);
EXPORT void buck_close(void);
EXPORT void buck_exit(void);
EXPORT FLAG buck_open(FLAG loadas);
EXPORT void buck_save(FLAG saveas);
EXPORT void buck_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG buck_subgadget(UNUSED ULONG gid, UNUSED UWORD code);

EXPORT void epyx_main(void);
EXPORT void epyx_close(void);
EXPORT void epyx_exit(void);
EXPORT FLAG epyx_open(FLAG loadas);
EXPORT void epyx_save(FLAG saveas);
EXPORT void epyx_loop(ULONG gid, UNUSED ULONG code);

EXPORT void cf_main(void);
EXPORT void cf_close(void);
EXPORT void cf_exit(void);
EXPORT void cf_die(void);
EXPORT FLAG cf_open(FLAG loadas);
EXPORT void cf_save(FLAG saveas);
EXPORT void cf_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG cf_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG cf_subkey(UWORD code, UWORD qual);

EXPORT void cos_main(void);
EXPORT void cos_close(void);
EXPORT void cos_exit(void);
EXPORT FLAG cos_open(FLAG loadas);
EXPORT void cos_save(FLAG saveas);
EXPORT void cos_loop(ULONG gid, UNUSED ULONG code);

EXPORT void cok_main(void);
EXPORT void cok_die(void);
EXPORT void cok_close(void);
EXPORT void cok_exit(void);
EXPORT FLAG cok_open(FLAG loadas);
EXPORT void cok_save(FLAG saveas);
EXPORT void cok_loop(ULONG gid, UNUSED ULONG code);
EXPORT void cok_key(UBYTE scancode, UWORD qual);

EXPORT void cov_main(void);
EXPORT void cov_die(void);
EXPORT void cov_close(void);
EXPORT void cov_exit(void);
EXPORT FLAG cov_open(FLAG loadas);
EXPORT void cov_save(FLAG saveas);
EXPORT void cov_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG cov_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG cov_subkey(UWORD code, UWORD qual);
EXPORT void cov_getpens(void);
EXPORT void cov_uniconify(void);
EXPORT void cov_drawmap(void);
EXPORT void cov_lmb(SWORD mousex, SWORD mousey);
EXPORT void cov_key(UBYTE scancode, UWORD qual);
EXPORT void cov_tick(SWORD mousex, SWORD mousey);

EXPORT void csd_main(void);
EXPORT void csd_close(void);
EXPORT void csd_exit(void);
EXPORT FLAG csd_open(FLAG loadas);
EXPORT void csd_save(FLAG saveas);
EXPORT void csd_loop(ULONG gid, UNUSED ULONG code);
EXPORT void csd_getpens(void);
EXPORT void csd_uniconify(void);
EXPORT FLAG csd_subgadget(ULONG gid, UWORD code);

EXPORT void ce_main(void);
EXPORT void ce_close(void);
EXPORT void ce_exit(void);
EXPORT FLAG ce_open(FLAG loadas);
EXPORT void ce_save(FLAG saveas);
EXPORT void ce_loop(ULONG gid, ULONG code);
EXPORT void ce_lmb(SWORD mousex, SWORD mousey);
EXPORT void ce_key(UBYTE scancode, UWORD qual);
EXPORT void ce_getpens(void);
EXPORT void ce_uniconify(void);
EXPORT void ce_drawmap(void);
EXPORT void ce_tick(SWORD mousex, SWORD mousey);

EXPORT void dc_main(void);
EXPORT void dc_close(void);
EXPORT void dc_exit(void);
EXPORT FLAG dc_open(FLAG loadas);
EXPORT void dc_save(FLAG saveas);
EXPORT void dc_loop(ULONG gid, UNUSED ULONG code);

EXPORT void icom_main(void);
EXPORT void icom_close(void);
EXPORT void icom_exit(void);
EXPORT FLAG icom_open(FLAG loadas);
EXPORT void icom_save(FLAG saveas);
EXPORT void icom_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG icom_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG icom_subkey(UWORD code, UWORD qual);
EXPORT void icom_key(UBYTE scancode, UWORD qual);

EXPORT void dra_main(void);
EXPORT void dra_die(void);
EXPORT void dra_close(void);
EXPORT void dra_exit(void);
EXPORT FLAG dra_open(FLAG loadas);
EXPORT void dra_save(FLAG saveas);
EXPORT void dra_loop(ULONG gid, UNUSED ULONG code);
EXPORT void dra_key(UBYTE scancode, UWORD qual);

EXPORT void druid2_main(void);
EXPORT void druid2_close(void);
EXPORT void druid2_exit(void);
EXPORT FLAG druid2_open(FLAG loadas);
EXPORT void druid2_save(FLAG saveas);
EXPORT void druid2_loop(ULONG gid, UNUSED ULONG code);
EXPORT void druid2_getpens(void);
EXPORT void druid2_freepens(void);
EXPORT void druid2_uniconify(void);
EXPORT void druid2_drawmap(FLAG all);
EXPORT void druid2_resize(void);
EXPORT void druid2_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void druid2_tick(SWORD mousex, SWORD mousey);
EXPORT void druid2_mouse(SWORD mousex, SWORD mousey);
EXPORT void druid2_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);

EXPORT void dw_main(void);
EXPORT void dw_die(void);
EXPORT void dw_close(void);
EXPORT void dw_exit(void);
EXPORT FLAG dw_open(FLAG loadas);
EXPORT void dw_save(FLAG saveas);
EXPORT void dw_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG dw_subgadget(ULONG gid, UWORD code);
EXPORT FLAG dw_subkey(UWORD code, UWORD qual);
EXPORT void dw_uniconify(void);
EXPORT void dw_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT void dw_getpens(void);
EXPORT void dw_drawmap(void);
EXPORT void dw_lmb(SWORD mousex, SWORD mousey);
EXPORT void dw_tick(SWORD mousex, SWORD mousey);

EXPORT void dm_main(void);
EXPORT void dm_close(void);
EXPORT void dm_exit(void);
EXPORT FLAG dm_open(FLAG loadas);
EXPORT void dm_save(FLAG saveas);
EXPORT void dm_loop(ULONG gid, ULONG code);
EXPORT void dm_drawmap(void);
EXPORT void dm_uniconify(void);
EXPORT void dm_getpens(void);
EXPORT void dm_key(UBYTE scancode);
EXPORT void dm_tick(SWORD mousex, SWORD mousey);
EXPORT FLAG dm_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT void dm_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void dm_mouse(SWORD mousex, SWORD mousey);

EXPORT void eob_main(void);
EXPORT void eob_close(void);
EXPORT void eob_exit(void);
EXPORT FLAG eob_open(FLAG loadas);
EXPORT void eob_save(FLAG saveas);
EXPORT void eob_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG eob_subgadget(ULONG gid, UWORD code);
EXPORT FLAG eob_subkey(UWORD code, UWORD qual);

EXPORT void fa18_main(void);
EXPORT void fa18_close(void);
EXPORT void fa18_exit(void);
EXPORT FLAG fa18_open(FLAG loadas);
EXPORT void fa18_save(FLAG saveas);
EXPORT void fa18_loop(ULONG gid, UNUSED ULONG code);
EXPORT void fa18_uniconify(void);

EXPORT void fta_main(void);
EXPORT void fta_close(void);
EXPORT void fta_exit(void);
EXPORT FLAG fta_open(FLAG loadas);
EXPORT void fta_save(FLAG saveas);
EXPORT void fta_loop(ULONG gid, UNUSED ULONG code);
EXPORT void fta_uniconify(void);
EXPORT void fta_drawmap(void);
EXPORT void fta_getpens(void);
EXPORT void fta_key(UBYTE scancode, UWORD qual);
EXPORT void fta_lmb(SWORD mousex, SWORD mousey);
EXPORT void fta_tick(SWORD mousex, SWORD mousey);

EXPORT void ss_main(void);
EXPORT void ss_close(void);
EXPORT void ss_exit(void);
EXPORT FLAG ss_open(FLAG loadas);
EXPORT void ss_save(FLAG saveas);
EXPORT void ss_loop(ULONG gid, UNUSED ULONG code);
EXPORT void ss_getpens(void);
EXPORT void ss_freepens(void);
EXPORT void ss_uniconify(void);
EXPORT void ss_mb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void ss_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT void ss_mouse(SWORD mousex, SWORD mousey);
EXPORT void ss_drawmap(FLAG all);
EXPORT void ss_resize(void);
EXPORT void ss_tick(SWORD mousex, SWORD mousey);
EXPORT void ss_realpen_to_table(void);
EXPORT void ss_tablepen_to_real(void);
EXPORT FLAG ss_wantrmb(SWORD mousex, SWORD mousey);

EXPORT void gar_main(void);
EXPORT void gar_close(void);
EXPORT void gar_exit(void);
EXPORT FLAG gar_open(FLAG loadas);
EXPORT void gar_save(FLAG saveas);
EXPORT void gar_loop(ULONG gid, UNUSED ULONG code);
EXPORT void gar_getpens(void);
EXPORT void gar_freepens(void);
EXPORT void gar_uniconify(void);
EXPORT void gar_drawmap(FLAG all);
EXPORT void gar_tick(SWORD mousex, SWORD mousey);
EXPORT void gar_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void gar_mouse(SWORD mousex, SWORD mousey);
EXPORT void gar_key(UBYTE scancode, UWORD qual);
EXPORT FLAG gar_subkey(UWORD code);
EXPORT FLAG gar_subgadget(ULONG gid);

EXPORT void goal_main(void);
EXPORT void goal_close(void);
EXPORT void goal_exit(void);
EXPORT FLAG goal_open(FLAG loadas);
EXPORT void goal_save(FLAG saveas);
EXPORT void goal_loop(ULONG gid, UNUSED ULONG code);
EXPORT void goal_key(UBYTE scancode, UWORD qual);
EXPORT void goal_getpens(void);
EXPORT void goal_uniconify(void);
EXPORT void goal_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void goal_resize(void);
EXPORT void goal_mouse(SWORD mousex, SWORD mousey);

EXPORT void gms_main(void);
EXPORT void gms_close(void);
EXPORT void gms_exit(void);
EXPORT FLAG gms_open(FLAG loadas);
EXPORT void gms_save(FLAG saveas);
EXPORT void gms_loop(ULONG gid, UNUSED ULONG code);

EXPORT void giana_main(void);
EXPORT void giana_close(void);
EXPORT void giana_exit(void);
EXPORT FLAG giana_open(FLAG loadas);
EXPORT void giana_save(FLAG saveas);
EXPORT void giana_loop(ULONG gid, UNUSED ULONG code);

EXPORT void gs_main(void);
EXPORT void gs_close(void);
EXPORT void gs_exit(void);
EXPORT FLAG gs_open(FLAG loadas);
EXPORT void gs_save(FLAG saveas);
EXPORT void gs_loop(ULONG gid, UNUSED ULONG code);

EXPORT void hol_main(void);
EXPORT void hol_close(void);
EXPORT void hol_exit(void);
EXPORT FLAG hol_open(FLAG loadas);
EXPORT void hol_save(FLAG saveas);
EXPORT void hol_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG hol_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG hol_subkey(UWORD code, UWORD qual);
EXPORT void hol_key(UBYTE scancode);

EXPORT void hf_main(void);
EXPORT void hf_die(void);
EXPORT void hf_close(void);
EXPORT void hf_exit(void);
EXPORT FLAG hf_open(FLAG loadas);
EXPORT void hf_save(FLAG saveas);
EXPORT void hf_loop(ULONG gid, UNUSED ULONG code);
EXPORT void hf_uniconify(void);
EXPORT void hf_drawmap(void);
EXPORT void hf_getpens(void);
EXPORT void hf_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void hf_tick(SWORD mousex, SWORD mousey);
EXPORT void hf_maprefresh(void);

EXPORT void im2_main(void);
EXPORT void im2_close(void);
EXPORT void im2_exit(void);
EXPORT FLAG im2_open(FLAG loadas);
EXPORT void im2_save(FLAG saveas);
EXPORT void im2_loop(ULONG gid, UNUSED ULONG code);

EXPORT void if_main(void);
EXPORT void if_close(void);
EXPORT void if_exit(void);
EXPORT FLAG if_open(FLAG loadas);
EXPORT void if_save(FLAG saveas);
EXPORT void if_loop(ULONG gid, UNUSED ULONG code);
EXPORT void if_mb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void if_key(UBYTE scancode, UWORD qual);
EXPORT void if_getpens(void);
EXPORT void if_uniconify(void);
EXPORT void if_drawmap(void);
EXPORT void if_tick(SWORD mousex, SWORD mousey);
EXPORT void if_resize(void);
EXPORT void if_mouse(SWORD mousex, SWORD mousey);
EXPORT void if_realpen_to_table(void);
EXPORT void if_tablepen_to_real(void);
EXPORT void if_readsketchboard(UBYTE* data);
EXPORT UBYTE if_getpixel(int x, int y);
EXPORT FLAG if_wantrmb(SWORD mousex, SWORD mousey);

EXPORT void icftd_main(void);
EXPORT void icftd_close(void);
EXPORT void icftd_exit(void);
EXPORT FLAG icftd_open(FLAG loadas);
EXPORT void icftd_save(FLAG saveas);
EXPORT void icftd_loop(ULONG gid, UNUSED ULONG code);
EXPORT void icftd_getpens(void);
EXPORT void icftd_uniconify(void);

EXPORT void keef_main(void);
EXPORT void keef_close(void);
EXPORT void keef_exit(void);
EXPORT FLAG keef_open(FLAG loadas);
EXPORT void keef_save(FLAG saveas);
EXPORT void keef_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG keef_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG keef_subkey(UWORD code);

EXPORT void kq_main(void);
EXPORT void kq_close(void);
EXPORT void kq_exit(void);
EXPORT FLAG kq_open(FLAG loadas);
EXPORT void kq_save(FLAG saveas);
EXPORT void kq_loop(ULONG gid, UNUSED ULONG code);
EXPORT void kq_uniconify(void);
EXPORT FLAG kq_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT void kq_subtick(SWORD mousex, SWORD mousey);
EXPORT void kq_getpens(void);
EXPORT FLAG kq_subkey(UWORD code);

EXPORT void ln_main(void);
EXPORT void ln_close(void);
EXPORT void ln_exit(void);
EXPORT FLAG ln_open(FLAG loadas);
EXPORT void ln_save(FLAG saveas);
EXPORT void ln_loop(ULONG gid, UNUSED ULONG code);

EXPORT void lof_main(void);
EXPORT void lof_die(void);
EXPORT void lof_close(void);
EXPORT void lof_exit(void);
EXPORT FLAG lof_open(FLAG loadas);
EXPORT void lof_save(FLAG saveas);
EXPORT void lof_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG lof_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG lof_subkey(UWORD code, UWORD qual);

EXPORT void lol_main(void);
EXPORT void lol_close(void);
EXPORT void lol_exit(void);
EXPORT FLAG lol_open(FLAG loadas);
EXPORT void lol_save(FLAG saveas);
EXPORT void lol_loop(ULONG gid, UNUSED ULONG code);

EXPORT void merc_main(void);
EXPORT void merc_close(void);
EXPORT void merc_exit(void);
EXPORT FLAG merc_open(FLAG loadas);
EXPORT void merc_save(FLAG saveas);
EXPORT void merc_loop(ULONG gid, UNUSED ULONG code);
EXPORT void merc_drawmap(void);
EXPORT void merc_getpens(void);
EXPORT void merc_uniconify(void);
EXPORT void merc_key(UBYTE scancode, UWORD qual);
EXPORT FLAG merc_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG merc_subkey(UWORD code, UWORD qual);
EXPORT void merc_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void merc_tick(SWORD mousex, SWORD mousey);
EXPORT void merc_die(void);

EXPORT void mm_main(void);
EXPORT void mm_die(void);
EXPORT void mm_close(void);
EXPORT void mm_exit(void);
EXPORT FLAG mm_open(FLAG loadas);
EXPORT void mm_save(FLAG saveas);
EXPORT void mm_loop(ULONG gid, UNUSED ULONG code);
EXPORT void mm_key(UBYTE scancode, UWORD qual);
EXPORT FLAG mm_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG mm_subkey(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);

EXPORT void interplay_main(void);
EXPORT void interplay_close(void);
EXPORT void interplay_exit(void);
EXPORT FLAG interplay_open(FLAG loadas);
EXPORT void interplay_save(FLAG saveas);
EXPORT void interplay_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG interplay_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG interplay_subkey(UWORD code, UWORD qual);
EXPORT void interplay_key(UBYTE scancode, UWORD qual);

EXPORT void nm_main(void);
EXPORT void nm_die(void);
EXPORT void nm_close(void);
EXPORT void nm_exit(void);
EXPORT FLAG nm_open(FLAG loadas);
EXPORT void nm_save(FLAG saveas);
EXPORT void nm_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG nm_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG nm_subkey(UWORD code, UWORD qual);

EXPORT void nitro_main(void);
EXPORT void nitro_close(void);
EXPORT void nitro_exit(void);
EXPORT FLAG nitro_open(FLAG loadas);
EXPORT void nitro_save(FLAG saveas);
EXPORT void nitro_loop(ULONG gid, UNUSED ULONG code);

EXPORT void psyg_main(void);
EXPORT void psyg_close(void);
EXPORT void psyg_exit(void);
EXPORT FLAG psyg_open(FLAG loadas);
EXPORT void psyg_save(FLAG saveas);
EXPORT void psyg_loop(ULONG gid, UNUSED ULONG code);
EXPORT void psyg_key(UBYTE scancode);

EXPORT void polar_main(void);
EXPORT void polar_close(void);
EXPORT void polar_exit(void);
EXPORT FLAG polar_open(FLAG loadas);
EXPORT void polar_save(FLAG saveas);
EXPORT void polar_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG polar_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG polar_subkey(UWORD code);
EXPORT void polar_subtick(SWORD mousex, SWORD mousey);
EXPORT void polar_getpens(void);
EXPORT void polar_uniconify(void);

EXPORT void panza_main(void);
EXPORT void panza_die(void);
EXPORT void panza_close(void);
EXPORT void panza_exit(void);
EXPORT FLAG panza_open(FLAG loadas);
EXPORT void panza_save(FLAG saveas);
EXPORT void panza_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG panza_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG panza_subkey(UWORD code, UWORD qual);

EXPORT void ph_main(void);
EXPORT void ph_die(void);
EXPORT void ph_close(void);
EXPORT void ph_exit(void);
EXPORT FLAG ph_open(FLAG loadas);
EXPORT void ph_save(FLAG saveas);
EXPORT void ph_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG ph_subgadget(ULONG gid, UWORD code);
EXPORT FLAG ph_subkey(UWORD code, UWORD qual);
EXPORT void ph_key(UBYTE scancode, UWORD qual);
EXPORT void ph_drawmap(void);
EXPORT void ph_getpens(void);
EXPORT void ph_sublmb(SWORD mousex, SWORD mousey);
EXPORT void ph_subtick(SWORD mousex, SWORD mousey);
EXPORT void ph_setpointer(struct Window* winptr);

EXPORT void pin_main(void);
EXPORT void pin_close(void);
EXPORT void pin_exit(void);
EXPORT FLAG pin_open(FLAG loadas);
EXPORT void pin_save(FLAG saveas);
EXPORT void pin_loop(ULONG gid, UNUSED ULONG code);

EXPORT void pir_main(void);
EXPORT void pir_close(void);
EXPORT void pir_exit(void);
EXPORT FLAG pir_open(FLAG loadas);
EXPORT void pir_save(FLAG saveas);
EXPORT void pir_loop(ULONG gid, UNUSED ULONG code);
EXPORT void pir_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT FLAG pir_subkey(UWORD code, UWORD qual);
EXPORT void pir_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void pir_getpens(void);
EXPORT void pir_uniconify(void);
EXPORT void pir_drawmap(void);
EXPORT FLAG pir_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT void pir_tick(SWORD mousex, SWORD mousey);

EXPORT void por_main(void);
EXPORT void por_die(void);
EXPORT void por_close(void);
EXPORT void por_exit(void);
EXPORT FLAG por_open(FLAG loadas);
EXPORT void por_save(FLAG saveas);
EXPORT void por_loop(ULONG gid, UNUSED ULONG code);
EXPORT void por_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT FLAG por_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG por_subkey(UWORD code, UWORD qual);

EXPORT void qa_main(void);
EXPORT void qa_close(void);
EXPORT void qa_exit(void);
EXPORT FLAG qa_open(FLAG loadas);
EXPORT void qa_save(FLAG saveas);
EXPORT void qa_loop(ULONG gid, UNUSED ULONG code);
EXPORT void qa_getpens(void);
EXPORT void qa_uniconify(void);
EXPORT void qa_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void qa_tick(SWORD mousex, SWORD mousey);
EXPORT void qa_drawmap(FLAG all);
EXPORT void qa_mouse(SWORD mousex, SWORD mousey);

EXPORT void q2_main(void);
EXPORT void q2_die(void);
EXPORT void q2_close(void);
EXPORT void q2_exit(void);
EXPORT FLAG q2_open(FLAG loadas);
EXPORT void q2_save(FLAG saveas);
EXPORT void q2_loop(ULONG gid, UNUSED ULONG code);
EXPORT void q2_lmb(SWORD mousex, SWORD mousey);
EXPORT void q2_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT void q2_getpens(void);
EXPORT void q2_uniconify(void);
EXPORT void q2_drawmap(void);
EXPORT void q2_tick(SWORD mousex, SWORD mousey);

EXPORT void lor_main(void);
EXPORT void lor_close(void);
EXPORT void lor_exit(void);
EXPORT FLAG lor_open(FLAG loadas);
EXPORT void lor_save(FLAG saveas);
EXPORT void lor_loop(ULONG gid, UNUSED ULONG code);
EXPORT void lor_getpens(void);
EXPORT void lor_uniconify(void);
EXPORT void lor_key(UBYTE scancode, UWORD qual);

EXPORT void rotj_main(void);
EXPORT void rotj_die(void);
EXPORT void rotj_close(void);
EXPORT void rotj_exit(void);
EXPORT FLAG rotj_open(FLAG loadas);
EXPORT void rotj_save(FLAG saveas);
EXPORT void rotj_loop(ULONG gid, UNUSED ULONG code);

EXPORT void robin_main(void);
EXPORT void robin_close(void);
EXPORT void robin_exit(void);
EXPORT FLAG robin_open(FLAG loadas);
EXPORT void robin_save(FLAG saveas);
EXPORT void robin_loop(ULONG gid, UNUSED ULONG code);
EXPORT void robin_getpens(void);
EXPORT void robin_uniconify(void);
EXPORT void robin_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey);
EXPORT void robin_drawmap(void);
EXPORT void robin_tick(SWORD mousex, SWORD mousey);
EXPORT void robin_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void robin_mouse(SWORD mousex, SWORD mousey);

EXPORT void rf_main(void);
EXPORT void rf_close(void);
EXPORT void rf_exit(void);
EXPORT FLAG rf_open(FLAG loadas);
EXPORT void rf_save(FLAG saveas);
EXPORT void rf_loop(ULONG gid, UNUSED ULONG code);
EXPORT void rf_drawmap(FLAG all);
EXPORT void rf_uniconify(void);
EXPORT void rf_exit(void);
EXPORT void rf_getpens(void);
EXPORT void rf_freepens(void);
EXPORT void rf_key(UBYTE scancode);
EXPORT void rf_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void rf_tick(SWORD mousex, SWORD mousey);
EXPORT void rf_mouse(SWORD mousex, SWORD mousey);
EXPORT void rf_realpen_to_table(void);
EXPORT void rf_tablepen_to_real(void);
EXPORT void rf_gettilepos(int* x, int* y);
EXPORT void rf_readtitlescreen(void);

EXPORT void rogue_main(void);
EXPORT void rogue_close(void);
EXPORT void rogue_exit(void);
EXPORT FLAG rogue_open(FLAG loadas);
EXPORT void rogue_save(FLAG saveas);
EXPORT void rogue_loop(ULONG gid, UNUSED ULONG code);
EXPORT void rogue_getpens(void);
EXPORT void rogue_uniconify(void);
EXPORT void rogue_drawmap(void);
EXPORT void rogue_sublmb(SWORD mousex, SWORD mousey);
EXPORT void rogue_key(UBYTE scancode, UWORD qual);
EXPORT FLAG rogue_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG rogue_subkey(UBYTE scancode, UWORD qual);
EXPORT void rogue_subtick(SWORD mousex, SWORD mousey);

EXPORT void rorke_main(void);
EXPORT void rorke_close(void);
EXPORT void rorke_exit(void);
EXPORT FLAG rorke_open(FLAG loadas);
EXPORT void rorke_save(FLAG saveas);
EXPORT void rorke_loop(ULONG gid, UNUSED ULONG code);
EXPORT void rorke_close(void);
EXPORT void rorke_key(UBYTE scancode, UWORD qual);
EXPORT void rorke_getpens(void);
EXPORT void rorke_uniconify(void);
EXPORT void rorke_drawmap(void);
EXPORT void rorke_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void rorke_tick(SWORD mousex, SWORD mousey);

EXPORT void shadow_main(void);
EXPORT void shadow_close(void);
EXPORT void shadow_exit(void);
EXPORT FLAG shadow_open(FLAG loadas);
EXPORT void shadow_save(FLAG saveas);
EXPORT void shadow_loop(ULONG gid, UNUSED ULONG code);
EXPORT void shadow_key(UBYTE scancode);

EXPORT void sw_main(void);
EXPORT void sw_close(void);
EXPORT void sw_exit(void);
EXPORT FLAG sw_open(FLAG loadas);
EXPORT void sw_save(FLAG saveas);
EXPORT void sw_loop(ULONG gid, UNUSED ULONG code);
EXPORT void sw_lmb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT void sw_key(UBYTE scancode, UWORD qual);
EXPORT void sw_getpens(void);
EXPORT void sw_uniconify(void);
EXPORT void sw_drawmap(int x, int y, FLAG full);
EXPORT void sw_tick(SWORD mousex, SWORD mousey);
EXPORT void sw_resize(void);
EXPORT void sw_mouse(SWORD mousex, SWORD mousey);
EXPORT void sw_freepens(void);
EXPORT void sw_realpen_to_table(void);
EXPORT void sw_tablepen_to_real(void);
EXPORT UBYTE sw_getpixel(int x, int y);
EXPORT void sw_readsketchboard(UBYTE* data);
EXPORT void sw_readtitlescreen(void);

EXPORT void sb_main(void);
EXPORT void sb_die(void);
EXPORT void sb_close(void);
EXPORT void sb_exit(void);
EXPORT FLAG sb_open(FLAG loadas);
EXPORT void sb_save(FLAG saveas);
EXPORT void sb_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG sb_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG sb_subkey(UWORD code, UWORD qual);
EXPORT void sb_getpens(void);
EXPORT void sb_uniconify(void);

EXPORT void sla_main(void);
EXPORT void sla_close(void);
EXPORT void sla_exit(void);
EXPORT FLAG sla_open(FLAG loadas);
EXPORT void sla_save(FLAG saveas);
EXPORT void sla_loop(ULONG gid, UNUSED ULONG code);
EXPORT void sla_getpens(void);
EXPORT void sla_uniconify(void);
EXPORT void sla_lmb(SWORD mousex, SWORD mousey);
EXPORT void sla_key(UBYTE scancode, UWORD qual);
EXPORT void sla_drawmap(void);
EXPORT void sla_tick(SWORD mousex, SWORD mousey);

EXPORT void speedb_main(void);
EXPORT void speedb_close(void);
EXPORT void speedb_exit(void);
EXPORT FLAG speedb_open(FLAG loadas);
EXPORT void speedb_save(FLAG saveas);
EXPORT void speedb_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG speedb_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG speedb_subkey(UWORD code);

EXPORT void syn_main(void);
EXPORT void syn_close(void);
EXPORT void syn_exit(void);
EXPORT void syn_die(void);
EXPORT FLAG syn_open(FLAG loadas);
EXPORT void syn_save(FLAG saveas);
EXPORT void syn_loop(ULONG gid, UNUSED ULONG code);
EXPORT FLAG syn_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG syn_subkey(UWORD code, UWORD qual);

EXPORT void toa_main(void);
EXPORT void toa_close(void);
EXPORT void toa_exit(void);
EXPORT FLAG toa_open(FLAG loadas);
EXPORT void toa_save(FLAG saveas);
EXPORT void toa_loop(ULONG gid, UNUSED ULONG code);

EXPORT void tol_main(void);
EXPORT void tol_close(void);
EXPORT void tol_exit(void);
EXPORT FLAG tol_open(FLAG loadas);
EXPORT void tol_save(FLAG saveas);
EXPORT void tol_loop(ULONG gid, UNUSED ULONG code);
EXPORT void tol_getpens(void);
EXPORT void tol_drawmap(void);
EXPORT void tol_uniconify(void);

EXPORT void tvs_main(void);
EXPORT void tvs_close(void);
EXPORT void tvs_exit(void);
EXPORT FLAG tvs_open(FLAG loadas);
EXPORT void tvs_save(FLAG saveas);
EXPORT void tvs_loop(ULONG gid, UNUSED ULONG code);
EXPORT void tvs_key(UBYTE scancode);
EXPORT void tvs_getpens(void);
EXPORT void tvs_uniconify(void);

EXPORT void ultima_main(void);
EXPORT void ultima_close(void);
EXPORT void ultima_exit(void);
EXPORT FLAG ultima_open(FLAG loadas);
EXPORT void ultima_save(FLAG saveas);
EXPORT void ultima_loop(ULONG gid, UNUSED ULONG code);
EXPORT void ultima_die(void);
EXPORT FLAG ultima_subgadget(ULONG gid, UWORD code);
EXPORT FLAG ultima_subkey(UWORD code, UWORD qual);
EXPORT void ultima_uniconify(void);

EXPORT void wiz_main(void);
EXPORT void wiz_close(void);
EXPORT void wiz_exit(void);
EXPORT FLAG wiz_open(FLAG loadas);
EXPORT void wiz_save(FLAG saveas);
EXPORT void wiz_loop(ULONG gid, UNUSED ULONG code);
EXPORT void wiz_key(UBYTE scancode, UWORD qual);

EXPORT void wime_main(void);
EXPORT void wime_close(void);
EXPORT void wime_exit(void);
EXPORT FLAG wime_open(FLAG loadas);
EXPORT void wime_save(FLAG saveas);
EXPORT void wime_loop(ULONG gid, UNUSED ULONG code);
EXPORT void wime_key(UWORD code, UWORD qual);
EXPORT FLAG wime_subgadget(ULONG gid, UNUSED UWORD code);
EXPORT FLAG wime_subkey(UWORD code);
EXPORT void wime_getpens(void);
EXPORT void wime_uniconify(void);
EXPORT void wime_drawmap(void);
EXPORT void wime_mb(SWORD mousex, SWORD mousey, UWORD code);
EXPORT FLAG wime_wantrmb(SWORD mousex, SWORD mousey);
EXPORT void wime_tick(SWORD mousex, SWORD mousey);

EXPORT void zerg_main(void);
EXPORT void zerg_close(void);
EXPORT void zerg_exit(void);
EXPORT FLAG zerg_open(FLAG loadas);
EXPORT void zerg_save(FLAG saveas);
EXPORT void zerg_loop(ULONG gid, UNUSED ULONG code);
EXPORT void zerg_lmb(SWORD mousex, SWORD mousey);
EXPORT void zerg_key(UBYTE scancode, UWORD qual);
EXPORT void zerg_getpens(void);
EXPORT void zerg_uniconify(void);
EXPORT void zerg_drawmap(void);
EXPORT void zerg_tick(SWORD mousex, SWORD mousey);

#ifndef __SASC
    EXPORT int stcl_d(char* out, long lvalue);
    EXPORT int stcul_d(char* out, unsigned long lvalue);
    EXPORT int stcl_h(char* out, long lvalue);
#endif
#ifdef __VBCC__
    EXPORT int stricmp(const char* s1, const char* s2);
    EXPORT int strnicmp(const char *s1, const char *s2, size_t len);
    EXPORT char* strupr(char* s);
    EXPORT double strtod(const char* string, char** endPtr);
#endif
