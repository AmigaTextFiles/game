// 1.  INCLUDES -----------------------------------------------------------

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
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>                           /* FILE, printf() */
#include <stdlib.h>                          /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>                         // geta4()
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_CSD_LY1     0 // root layout
#define GID_CSD_SB1     1 // toolbar
#define GID_CSD_BU1     2 //   1st board square
#define GID_CSD_BU225 226 // 225th board square
#define GID_CSD_BU226 227 // clear board
#define GID_CSD_SL1   228 //   1st skill
#define GID_CSD_SL2   229 //   2nd skill
#define GID_CSD_SL3   230 //   3rd skill
#define GID_CSD_SL4   231 //   4th skill
#define GID_CSD_IN1   232 //   1st score
#define GID_CSD_IN2   233 //   2nd score
#define GID_CSD_IN3   234 //   3rd score
#define GID_CSD_IN4   235 //   4th score
#define GID_CSD_IN5   236 // players
#define GID_CSD_ST1   237 //   1st name
#define GID_CSD_ST2   238 //   2nd name
#define GID_CSD_ST3   239 //   3rd name
#define GID_CSD_ST4   240 //   4th name
#define GID_CSD_ST5   241 //   1st rack
#define GID_CSD_ST6   242 //   2nd rack
#define GID_CSD_ST7   243 //   3rd rack
#define GID_CSD_ST8   244 //   4th rack
#define GID_CSD_IN6   245 // 'A's in pile
#define GID_CSD_IN31  270 // 'Z's in pile
#define GID_CSD_IN32  271 // blanks in pile
#define GID_CSD_CH1   272 // whose turn
#define GID_CSD_CB1   273 // 1st human
#define GID_CSD_CB2   274 // 2nd human
#define GID_CSD_CB3   275 // 3rd human
#define GID_CSD_CB4   276 // 4th human

// letter window
#define GID_CSD_LY2   277
#define GID_CSD_RA1   278
#define GID_CSD_ST9   279

#define GIDS_CSD      GID_CSD_ST9

#define BoardSquare(x, y) \
LAYOUT_AddChild, gadgets[GID_CSD_BU1 + (y * 15) + x] = (struct Gadget*) \
ZButtonObject,                                                \
    GA_ID,               GID_CSD_BU1 + (y * 15) + x,         \
    GA_RelVerify,        TRUE,                               \
    GA_Text,             " ",                                \
    BUTTON_DomainString, "#",                                \
ButtonEnd

#define BoardRow(y)     \
AddHLayout,             \
    BoardSquare( 0, y), \
    BoardSquare( 1, y), \
    BoardSquare( 2, y), \
    BoardSquare( 3, y), \
    BoardSquare( 4, y), \
    BoardSquare( 5, y), \
    BoardSquare( 6, y), \
    BoardSquare( 7, y), \
    BoardSquare( 8, y), \
    BoardSquare( 9, y), \
    BoardSquare(10, y), \
    BoardSquare(11, y), \
    BoardSquare(12, y), \
    BoardSquare(13, y), \
    BoardSquare(14, y), \
LayoutEnd

#define PileGad(a, b)                                        \
LAYOUT_AddChild, gadgets[GID_CSD_IN6 + a] = (struct Gadget*) \
IntegerObject,                                               \
    GA_ID,              GID_CSD_IN6 + a,                     \
    GA_TabCycle,        TRUE,                                \
    INTEGER_Minimum,    0,                                   \
    INTEGER_Maximum,    255,                                 \
    INTEGER_MinVisible, 3 + 1,                               \
IntegerEnd,                                                  \
CHILD_WeightedWidth,    0,                                   \
Label(b)

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void letterwindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 pens[PENS];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE TEXT                 board[15][15],
                            letterstring[1 + 1],
                            name[4][8 + 1],
                            rack[4][7 + 1];
MODULE ULONG                human[4],
                            pile[27],
                            players,
                            score[4],
                            skill[4],
                            squaretype,
                            turn;
MODULE int                  whichsquare;

MODULE const STRPTR TurnOptions[4 + 1] =
{   "Player #1", // 0
    "Player #2",
    "Player #3",
    "Player #4",
    NULL         // 4
}, LetterOptions[3 + 1] =
{   "Empty square",             // 0
    "Ordinary letter (choose)", // 1
    "Wildcard letter (choose)", // 2
    NULL                        // 3
};

MODULE const UBYTE defboard[15][15] =
{ { 6,2,2,3,2,2,2,6,2,2,2,3,2,2,6 },
  { 2,5,2,2,2,4,2,2,2,4,2,2,2,5,2 },
  { 2,2,5,2,2,2,3,2,3,2,2,2,5,2,2 },
  { 3,2,2,5,2,2,2,3,2,2,2,5,2,2,3 },
  { 2,2,2,2,5,2,2,2,2,2,5,2,2,2,2 },
  { 2,4,2,2,2,4,2,2,2,4,2,2,2,4,2 },
  { 2,2,3,2,2,2,3,2,3,2,2,2,3,2,2 },
  { 6,2,2,3,2,2,2,7,2,2,2,3,2,2,6 },
  { 2,2,3,2,2,2,3,2,3,2,2,2,3,2,2 },
  { 2,4,2,2,2,4,2,2,2,4,2,2,2,4,2 },
  { 2,2,2,2,5,2,2,2,2,2,5,2,2,2,2 },
  { 3,2,2,5,2,2,2,3,2,2,2,5,2,2,3 },
  { 2,2,5,2,2,2,3,2,3,2,2,2,5,2,2 },
  { 2,5,2,2,2,4,2,2,2,4,2,2,2,5,2 },
  { 6,2,2,3,2,2,2,6,2,2,2,3,2,2,6 },
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  DDD. .... .... ....    . = Transparent (%00)
    DLDD .... .... ....    L = Light grey  (%01)
    DLLD D... .... ....    D = Dark  grey  (%10)
    DWLL DD.. .... ....    W = off-White   (%11)
    DWWL LDD. .... ....
    DWWW LLDD .... ....
    DWWW WLLD D... ....
    DWWW WWLL D... ....
    DWWW WLDD D... ....
    DWWD WLDD .... ....
    DDDD DWLD .... ....
    .... DWLD D... ....
    .... DDWL D... ....
    .... .DWL DD.. ....
    .... .DDW LD.. ....
    .... ..DD DD.. ....

    Plane 0 Plane 1 */
    0x0000, 0xE000,
    0x4000, 0xB000,
    0x6000, 0x9800,
    0x7000, 0xCC00,
    0x7800, 0xE600,
    0x7C00, 0xF300,
    0x7E00, 0xF980,
    0x7F00, 0xFC80,
    0x7C00, 0xFB80,
    0x6C00, 0xFB00,
    0x0600, 0xFD00,
    0x0600, 0x0B80,
    0x0300, 0x0E80,
    0x0300, 0x06C0,
    0x0180, 0x0740,
    0x0000, 0x03C0,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void csd_main(void)
{   tool_open      = csd_open;
    tool_loop      = csd_loop;
    tool_save      = csd_save;
    tool_close     = csd_close;
    tool_exit      = csd_exit;
    tool_subgadget = csd_subgadget;

    if (loaded != FUNC_CSD && !csd_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_CSD;

    make_speedbar_list(GID_CSD_SB1);
    load_aiss_images(9, 10);

    csd_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_CSD_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_CSD_SB1),
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddLabel("Number of players:"),
                CHILD_WeightedWidth,                       0,
                LAYOUT_AddChild,                           gadgets[GID_CSD_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_CSD_IN5,
                    GA_TabCycle,                           TRUE,
                    GA_RelVerify,                          TRUE,
                    INTEGER_Minimum,                       2,
                    INTEGER_Maximum,                       4,
                    INTEGER_MinVisible,                    1 + 1,
                IntegerEnd,
                CHILD_WeightedWidth,                       50,
                AddLabel("Whose turn:"),
                CHILD_WeightedWidth,                       0,
                LAYOUT_AddChild,                           gadgets[GID_CSD_CH1] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_CSD_CH1,
                    CHOOSER_LabelArray,                    &TurnOptions,
                PopUpEnd,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Players",
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Names",
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST1,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name[0],
                        STRINGA_MaxChars,                  8 + 1,
                        STRINGA_MinVisible,                8 + stringextra,
                    StringEnd,
                    Label("#1:"),
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST2,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name[1],
                        STRINGA_MaxChars,                  8 + 1,
                        STRINGA_MinVisible,                8 + stringextra,
                    StringEnd,
                    Label("#2:"),
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST3] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST3,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name[2],
                        STRINGA_MaxChars,                  8 + 1,
                        STRINGA_MinVisible,                8 + stringextra,
                    StringEnd,
                    Label("#3:"),
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST4] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST4,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name[3],
                        STRINGA_MaxChars,                  8 + 1,
                        STRINGA_MinVisible,                8 + stringextra,
                    StringEnd,
                    Label("#4:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Skill",
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_CB1] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_CSD_CB1,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       "Human ",
                        End,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_CB2] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_CSD_CB2,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       "Human ",
                        End,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_CB3] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_CSD_CB3,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       "Human ",
                        End,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_CB4] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_CSD_CB4,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       "Human ",
                        End,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_SL1] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_CSD_SL1,
                            SLIDER_Min,                    1,
                            SLIDER_Max,                    8,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  8, // how many ticks to display
                        SliderEnd,
                        CHILD_MinWidth,                    128,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_SL2] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_CSD_SL2,
                            SLIDER_Min,                    1,
                            SLIDER_Max,                    8,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  8, // how many ticks to display
                        SliderEnd,
                        CHILD_MinWidth,                    128,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_SL3] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_CSD_SL3,
                            SLIDER_Min,                    1,
                            SLIDER_Max,                    8,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  8, // how many ticks to display
                        SliderEnd,
                        CHILD_MinWidth,                    128,
                        LAYOUT_AddChild,                   gadgets[GID_CSD_SL4] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_CSD_SL4,
                            SLIDER_Min,                    1,
                            SLIDER_Max,                    8,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  8, // how many ticks to display
                        SliderEnd,
                        CHILD_MinWidth,                    128,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Scores",
                    LAYOUT_AddChild,                       gadgets[GID_CSD_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CSD_IN1,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   32767,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CSD_IN2,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   32767,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CSD_IN3,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   32767,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CSD_IN4,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   32767,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Racks",
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST5] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST5,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   rack[0],
                        STRINGA_MaxChars,                  7 + 1,
                        STRINGA_MinVisible,                7 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST6] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST6,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   rack[1],
                        STRINGA_MaxChars,                  7 + 1,
                        STRINGA_MinVisible,                7 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST7] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST7,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   rack[2],
                        STRINGA_MaxChars,                  7 + 1,
                        STRINGA_MinVisible,                7 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                       gadgets[GID_CSD_ST8] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_CSD_ST8,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   rack[3],
                        STRINGA_MaxChars,                  7 + 1,
                        STRINGA_MinVisible,                7 + stringextra,
                    StringEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,                            
            CHILD_WeightedHeight,                          0,
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Pile",
                    AddVLayout,
                        PileGad( 0, "A:"),
                        PileGad( 1, "B:"),
                        PileGad( 2, "C:"),
                        PileGad( 3, "D:"),
                        PileGad( 4, "E:"),
                        PileGad( 5, "F:"),
                        PileGad( 6, "G:"),
                        PileGad( 7, "H:"),
                        PileGad( 8, "I:"),
                    LayoutEnd,
                    AddVLayout,
                        PileGad( 9, "J:"),
                        PileGad(10, "K:"),
                        PileGad(11, "L:"),
                        PileGad(12, "M:"),
                        PileGad(13, "N:"),
                        PileGad(14, "O:"),
                        PileGad(15, "P:"),
                        PileGad(16, "Q:"),
                        PileGad(17, "R:"),
                    LayoutEnd,
                    AddVLayout,
                        PileGad(18, "S:"),
                        PileGad(19, "T:"),
                        PileGad(20, "U:"),
                        PileGad(21, "V:"),
                        PileGad(22, "W:"),
                        PileGad(23, "X:"),
                        PileGad(24, "Y:"),
                        PileGad(25, "Z:"),
                        PileGad(26, " :"), // give it a better name if you can think of one
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Board",
                    BoardRow( 0),
                    BoardRow( 1),
                    BoardRow( 2),
                    BoardRow( 3),
                    BoardRow( 4),
                    BoardRow( 5),
                    BoardRow( 6),
                    BoardRow( 7),
                    BoardRow( 8),
                    BoardRow( 9),
                    BoardRow(10),
                    BoardRow(11),
                    BoardRow(12),
                    BoardRow(13),
                    BoardRow(14),
                LayoutEnd,
            LayoutEnd,
            ClearButton(GID_CSD_BU226, "Clear Board"),
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_CSD_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void csd_loop(ULONG gid, UNUSED ULONG code)
{   int x, y;

    switch (gid)
    {
    case GID_CSD_IN5:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_CSD_IN5], &players);
        writegadgets();
    acase GID_CSD_CB1:
        readgadgets();
        DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_CSD_CB1], &human[0]);
        writegadgets();
    acase GID_CSD_CB2:
        readgadgets();
        DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_CSD_CB2], &human[1]);
        writegadgets();
    acase GID_CSD_CB3:
        readgadgets();
        DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_CSD_CB3], &human[2]);
        writegadgets();
    acase GID_CSD_CB4:
        readgadgets();
        DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_CSD_CB4], &human[3]);
        writegadgets();
    acase GID_CSD_BU226:
        for (y = 0; y < 15; y++)
        {   for (x = 0; x < 15; x++)
            {   if (board[y][x] & 0x80)
                {   pile[26]++;
                } elif (board[y][x] >= 'A' && board[y][x] <= 'Z')
                {   pile[board[y][x] - 'A']++;
                }
                board[y][x] = defboard[y][x];
        }   }
        writegadgets();
    adefault:
        if (gid >= GID_CSD_BU1 && gid <= GID_CSD_BU225)
        {   readgadgets();
            whichsquare = gid - GID_CSD_BU1;
            letterwindow();
            writegadgets();
}   }   }

EXPORT FLAG csd_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int          bgc,
                 i,
                 x, y;
    TEXT         thetext[1 + 1];
    ULONG        fgc;
    struct List* ListPtr;
    struct Node* NodePtr;

    if
    (   page != FUNC_CSD
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    for (y = 0; y < 15; y++)
    {   for (x = 0; x < 15; x++)
        {   if (board[y][x] >= 2 && board[y][x] <= 6)
            {   bgc = board[y][x] - 2;
                strcpy(thetext, " ");
                fgc = (ULONG) ~0; // doesn't matter
            } elif (board[y][x] == 7)
            {   bgc = 3;
                strcpy(thetext, "*");
                fgc = (ULONG) ~0;
            } else
            {   bgc = 5;
                thetext[0] = board[y][x] & 0x7F;
                thetext[1] = EOS;
                if (board[y][x] & 0x80)
                {   fgc = pens[2];
                } else
                {   fgc = (ULONG) ~0;
            }   }

            DISCARD SetGadgetAttrs
            (   gadgets[GID_CSD_BU1 + (y * 15) + x], MainWindowPtr, NULL,
                GA_Text,              thetext,
                BUTTON_BackgroundPen, pens[bgc],
                BUTTON_TextPen,       fgc,
            TAG_DONE); // this autorefreshes
    }   }

    DISCARD SetGadgetAttrs(gadgets[GID_CSD_IN3], MainWindowPtr, NULL, GA_Disabled, (players < 3) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_ST3], MainWindowPtr, NULL, GA_Disabled, (players < 3) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_ST7], MainWindowPtr, NULL, GA_Disabled, (players < 3) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_CB3], MainWindowPtr, NULL, GA_Disabled, (players < 3) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically

    DISCARD SetGadgetAttrs(gadgets[GID_CSD_IN4], MainWindowPtr, NULL, GA_Disabled, (players < 4) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_ST4], MainWindowPtr, NULL, GA_Disabled, (players < 4) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_ST8], MainWindowPtr, NULL, GA_Disabled, (players < 4) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs(gadgets[GID_CSD_CB4], MainWindowPtr, NULL, GA_Disabled, (players < 4) ? TRUE : FALSE, TAG_DONE); // this refreshes automatically

    if (turn >= players) // turn is 0..3, players is 1..4
    {   turn = 0;
    }

    DISCARD GetAttr(CHOOSER_Labels, (Object*) gadgets[GID_CSD_CH1], (ULONG*) &ListPtr);
    // assert(ListPtr->lh_Head->ln_Succ); // the list is non-empty
    // walk the list
    i = 0;
    for
    (   NodePtr = (struct Node*) ListPtr->lh_Head;
        NodePtr->ln_Succ;
        NodePtr = (struct Node*) NodePtr->ln_Succ
    )
    {   if (i >= 2)
        {   SetChooserNodeAttrs
            (   NodePtr,
                CNA_ReadOnly, (i >= (int) players) ? TRUE : FALSE,
                CNA_Disabled, (i >= (int) players) ? TRUE : FALSE,
            TAG_DONE);
        }
        i++;
    }

    for (i = 0; i < 4; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_CSD_SL1 + i], MainWindowPtr, NULL,
            GA_Disabled, (human[i] || (int) players <= i) ? TRUE : FALSE,
        TAG_DONE); // this autorefreshes
    }

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_sl(GID_CSD_SL1, &skill[0]);
    either_sl(GID_CSD_SL2, &skill[1]);
    either_sl(GID_CSD_SL3, &skill[2]);
    either_sl(GID_CSD_SL4, &skill[3]);
    either_in(GID_CSD_IN1, &score[0]);
    either_in(GID_CSD_IN2, &score[1]);
    either_in(GID_CSD_IN3, &score[2]);
    either_in(GID_CSD_IN4, &score[3]);
    either_in(GID_CSD_IN5, &players);
    either_st(GID_CSD_ST1,  name[0]);
    either_st(GID_CSD_ST2,  name[1]);
    either_st(GID_CSD_ST3,  name[2]);
    either_st(GID_CSD_ST4,  name[3]);
    either_st(GID_CSD_ST5,  rack[0]);
    either_st(GID_CSD_ST6,  rack[1]);
    either_st(GID_CSD_ST7,  rack[2]);
    either_st(GID_CSD_ST8,  rack[3]);
    either_ch(GID_CSD_CH1, &turn);
    either_cb(GID_CSD_CB1, &human[0]);
    either_cb(GID_CSD_CB2, &human[1]);
    either_cb(GID_CSD_CB3, &human[2]);
    either_cb(GID_CSD_CB4, &human[3]);

    for (i = 0; i < 27; i++)
    {   either_in(GID_CSD_IN6 + i, &pile[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   UBYTE t;
    ULONG tiles,
          wholepile;
    int   i, j, k,
          x, y;

    if (serializemode == SERIALIZE_WRITE)
    {   offset = 0;
        for (i = 0; i < 4; i++)
        {   tiles = 7;
            for (j = 0; j <= 6; j++)
            {   if (rack[i][j] >= 'a' && rack[i][j] <= 'z')
                {   rack[i][j] -= 'a';
                    rack[i][j] += 'A';
                } elif (rack[i][j] == EOS)
                {   tiles = j;
                    if (j <= 5)
                    {   for (k = j + 1; k <= 6; k++)
                        {   rack[i][k] = EOS;
                    }   }
                    break;
                } elif (rack[i][j] < 'A' || rack[i][j] > 'Z')
                {   rack[i][j] = ' ';
            }   }
            serialize1(&tiles);              //   $0..  $3
    }   }
    else
    {   offset = 4;
    }

    for (i = 0; i < 4; i++)
    {   for (j = 0; j <= 6; j++)
        {   serialize1to1((UBYTE*) &rack[i][j]); // $4..$1F
        }
        rack[i][7] = EOS;
    }

    for (i = 0; i < 4; i++)
    {   offset = 0x24 + (9 * i);
        serstring(name[i]);                  //  $24.. $47
    }

    offset = 0x48; // needed!
    serialize2ulong(&score[0]);              //  $48.. $49
    serialize2ulong(&score[1]);              //  $4A.. $4B
    serialize2ulong(&score[2]);              //  $4C.. $4D
    serialize2ulong(&score[3]);              //  $4E.. $4F

    if (serializemode == SERIALIZE_WRITE)
    {   for (i = 0; i < 4; i++)
        {   if (human[i])
            {   IOBuffer[offset++] = 0;      //  $50.. $53
            } else
            {   serialize1(&skill[i]);       //  $50.. $53
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_READ);
        for (i = 0; i < 4; i++)
        {   serialize1(&skill[i]);           //  $50.. $53
            human[i] = skill[i] ? FALSE : TRUE;
            if (skill[i] == 0)
            {   skill[i] = 1;
    }   }   }

    serialize1(&players);                    //  $54
    if
    (   serializemode == SERIALIZE_READ
     && players > 4
    )
    {   say("Warning: too many players!", REQIMAGE_WARNING);
        players = 4;
    }

    offset = 0xB0;
    for (y = 0; y < 15; y++)
    {   for (x = 0; x < 15; x++)
        {   serialize1to1((UBYTE*) &board[y][x]); //  $B0..$190
    }   }
    if (serializemode == SERIALIZE_WRITE)
    {   for (x = 0; x < 15; x++)
        {   for (y = 0; y < 15; y++)
            {   serialize1to1((UBYTE*) &board[y][x]); // $191..$271
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_READ);
        for (x = 0; x < 15; x++)
        {   for (y = 0; y < 15; y++)
            {   serialize1to1(&t);
                if (t != board[y][x])
                {   say("Warning: board arrays do not match!", REQIMAGE_WARNING);
                    break;
    }   }   }   }

    offset = 0x2A9;
    wholepile = 0;
    for (i = 0; i < 27; i++)
    {   serialize1(&pile[i]);                // $2A9..$2C3
        wholepile += pile[i];
    }

    offset = 0x2DF;
    serialize1(&wholepile);                  // $2DF

    offset = 0x2E8;
    serialize1(&turn);                       // $2E8
    if
    (   serializemode == SERIALIZE_READ
     && turn >= players
    )
    {   say("Warning: turn is incorrect!", REQIMAGE_WARNING);
        turn = 0;
    }

    t = 0;
    for (i = 0; i < 747; i++)
    {   t += IOBuffer[i]; // overflow is OK
    }
    if (serializemode == SERIALIZE_WRITE)
    {   IOBuffer[747] = t;               // $2EB
    } else
    {   // assert(serializemode == SERIALIZE_READ);
        if (IOBuffer[747] != t)
        {   say("Warning: checksum is incorrect!", REQIMAGE_WARNING);
}   }   }

EXPORT void csd_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?", "Scrabble", saveas, 748, FLAG_S, FALSE);

    writegadgets(); // because racks get fixed up just before saving
}

EXPORT void csd_close(void) { ; }
EXPORT void csd_exit(void)  { ; }

EXPORT void csd_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x22222222, 0x77777777, 0x22222222, -1); // dark  green
    pens[1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0xCCCCCCCC, 0xFFFFFFFF, -1); // light blue
    pens[2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x66666666, 0xCCCCCCCC, -1); // dark  blue
    pens[3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xAAAAAAAA, 0xAAAAAAAA, -1); // light red
    pens[4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0x22222222, 0x22222222, -1); // dark  red
    pens[5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xEEEEEEEE, 0xEEEEEEEE, 0xAAAAAAAA, -1); // light yellow

    unlockscreen();
}

EXPORT void csd_uniconify(void)
{   csd_getpens();
}

MODULE void letterwindow(void)
{   TRANSIENT int    x, y;
    TRANSIENT STRPTR stringptr;
    PERSIST   WORD   leftx = -1,
                     topy  = -1;

    x = whichsquare % 15;
    y = whichsquare / 15;
    if (board[y][x] >= 2 && board[y][x] <= 7)
    {   squaretype = 0;
        letterstring[0] = EOS;
    } elif (board[y][x] < 0x80)
    {   squaretype = 1;
        letterstring[0] = board[y][x];
    } else
    {   squaretype = 2;
        letterstring[0] = board[y][x] & 0x7F;
    }
    letterstring[1] = EOS;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Square Contents",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_GadgetHelp,                     TRUE,
        WINDOW_UniqueID,                       "csd-1",
        WINDOW_ParentGroup,                    gadgets[GID_CSD_LY2] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_CSD_RA1] = (struct Gadget*)
            RadioButtonObject,
                GA_ID,                         GID_CSD_RA1,
                GA_RelVerify,                  TRUE,
                GA_Text,                       LetterOptions,
                RADIOBUTTON_Selected,          squaretype,
            RadioButtonEnd,
            AddVLayout,
                AddSpace,
                LAYOUT_AddChild,               gadgets[GID_CSD_ST9] = (struct Gadget*)
                StringObject,
                    GA_ID,                     GID_CSD_ST9,
                    GA_TabCycle,               TRUE,
                    GA_RelVerify,              TRUE,
                    GA_Disabled,               (squaretype == 0) ? TRUE : FALSE,
                    STRINGA_TextVal,           letterstring,
                    STRINGA_MaxChars,          1 + 1,
                    STRINGA_MinVisible,        1 + stringextra,
                StringEnd,
                CHILD_WeightedHeight,          0,
            LayoutEnd,
            CHILD_WeightedWidth,               0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }

    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    if (squaretype >= 1)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_CSD_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_CSD_ST9]);
    }

    subloop();

    DISCARD GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_CSD_ST9], (ULONG*) &stringptr);
    strcpy(letterstring, stringptr);

    if (squaretype == 0)
    {   board[y][x] = defboard[y][x];
    } else
    {   if (letterstring[0] >= 'a' && letterstring[0] <= 'z')
        {   letterstring[0] -= 'a';
            letterstring[0] += 'A';
        }
        if (letterstring[0] >= 'A' && letterstring[0] <= 'Z')
        {   board[y][x] = letterstring[0];
            if (squaretype == 2)
            {   board[y][x] += 0x80;
    }   }   }

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG csd_subgadget(ULONG gid, UWORD code)
{   switch (gid)
    {
    case GID_CSD_RA1:
        squaretype = code;
        if (squaretype == 0)
        {   return TRUE;
        } else
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_CSD_ST9], SubWindowPtr, NULL,
                GA_Disabled, FALSE,
            TAG_DONE);
            RefreshGadgets((struct Gadget *) gadgets[GID_CSD_ST9], SubWindowPtr, NULL); // needed
            DISCARD ActivateLayoutGadget(gadgets[GID_CSD_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_CSD_ST9]);
        }
    acase GID_CSD_ST9:
        return TRUE;
    }

    return FALSE;
}
