// 1. INCLUDES -----------------------------------------------------------

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

#define GID_IM2_LY1   0 // root layout
#define GID_IM2_SB1   1 // toolbar
#define GID_IM2_ST1   2 // 1st  name
#define GID_IM2_ST2   3
#define GID_IM2_ST3   4
#define GID_IM2_ST4   5
#define GID_IM2_ST5   6
#define GID_IM2_ST6   7
#define GID_IM2_ST7   8
#define GID_IM2_ST8   9
#define GID_IM2_ST9  10
#define GID_IM2_ST10 11
#define GID_IM2_ST11 12
#define GID_IM2_ST12 13 // 12th name
#define GID_IM2_IN1  14 // 1st  score
#define GID_IM2_IN2  15
#define GID_IM2_IN3  16
#define GID_IM2_IN4  17
#define GID_IM2_IN5  18
#define GID_IM2_IN6  19
#define GID_IM2_IN7  20
#define GID_IM2_IN8  21
#define GID_IM2_IN9  22
#define GID_IM2_IN10 23
#define GID_IM2_IN11 24
#define GID_IM2_IN12 25 // 12th score
#define GID_IM2_IN13 26 // lift resets
#define GID_IM2_IN14 27 // platform moves
#define GID_IM2_IN15 28 // electric plugs
#define GID_IM2_IN16 29 // time bombs
#define GID_IM2_IN17 30 // mines
#define GID_IM2_IN18 31 // light bulbs
#define GID_IM2_IN19 32 // hours
#define GID_IM2_IN20 33 // minutes
#define GID_IM2_IN21 34 // seconds
#define GID_IM2_IN22 35 // tower
#define GID_IM2_BU1  36 // maximize game
#define GID_IM2_BU2  37 // clear high scores
#define GID_IM2_CH1  38 // file type
#define GIDS_IM2     GID_IM2_CH1

#define FILETYPE_HISCORES  0
#define FILETYPE_SAVEDGAME 1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void maximize_man(void);
MODULE void im2_ghost(void);
MODULE void clearscores(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT LONG                 gamesize;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG               filetype,
                           hours,
                           lifts,
                           minutes,
                           platforms,
                           plugs,
                           seconds,
                           timebombs,
                           tower,
                           mines,
                           lightbulbs;
MODULE const STRPTR        FiletypeOptions[2 + 1] =
{ "High score table",
  "Saved game",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG amount;
    TEXT  name[5 + 1];
} score[12];

// 8. CODE ---------------------------------------------------------------

EXPORT void im2_main(void)
{   tool_open  = im2_open;
    tool_loop  = im2_loop;
    tool_save  = im2_save;
    tool_close = im2_close;
    tool_exit  = im2_exit;

    if (loaded != FUNC_IM2 && !im2_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_IM2;

    make_speedbar_list(GID_IM2_SB1);
    load_images(163, 168);
    load_fimage(FUNC_IM2);
    load_aiss_images(9, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_IM2_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_IM2_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddVLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_IM2_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_IM2_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &FiletypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_IM2),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "High Score Table",
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[0].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#1:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[1].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#2:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[2].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#3:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[3].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#4:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[4].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#5:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[5].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#6:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST7] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST7,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[6].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#7:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST8] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST8,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[7].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#8:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST9] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST9,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[8].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN9,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#9:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST10] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST10,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[9].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN10,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#10:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST11] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST11,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[10].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN11,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#11:"),
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_ST12] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_IM2_ST12,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[11].name,
                            STRINGA_MaxChars,              5 + 1,
                            STRINGA_MinVisible,            5 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        AddLabel("00"),
                    LayoutEnd,
                    Label("#12:"),
                    ClearButton(GID_IM2_BU2, "Clear High Scores"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Saved Game",
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Items",
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(163),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Lift resets:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN13] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN13,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            lifts,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(164),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Platform moves:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN14] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN14,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            platforms,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(165),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Electric plugs:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN15] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN15,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            plugs,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(166),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Time bombs:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN16] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN16,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            timebombs,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(167),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Mines:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN17] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN17,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            mines,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddImage(168),
                            CHILD_WeightedWidth,           0,
                            AddLabel("Light bulbs:"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN18] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN18,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            lightbulbs,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddSpace,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN19] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN19,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_Number,            hours,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            AddLabel(":"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN20] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN20,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_Number,            minutes,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            AddLabel(":"),
                            LAYOUT_AddChild,               gadgets[GID_IM2_IN21] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_IM2_IN21,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_Number,            seconds,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Time left:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_IM2_IN22] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_IM2_IN22,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               8,
                            INTEGER_Number,                tower,
                            INTEGER_MinVisible,            1 + 1,
                        IntegerEnd,
                        Label("Tower:"),
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    MaximizeButton(GID_IM2_BU1, "Maximize Game"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_IM2_SB1);
    writegadgets();
    if (filetype == FILETYPE_HISCORES)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_IM2_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_IM2_ST1]);
    } else
    {   DISCARD ActivateLayoutGadget(gadgets[GID_IM2_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_IM2_IN13]);
    }
    loop();
    readgadgets();
    closewindow();
}

EXPORT void im2_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_IM2_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_IM2_BU2:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG im2_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if     (gamesize == 1715)
        {   filetype = FILETYPE_SAVEDGAME;
        } elif (gamesize ==   96)
        {   filetype = FILETYPE_HISCORES;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
        }
        serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_IM2
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    im2_ghost();
    gadmode = SERIALIZE_WRITE;
    either_ch(GID_IM2_CH1, &filetype);
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 12; i++)
    {   either_st(GID_IM2_ST1 + i,  score[i].name);
        either_in(GID_IM2_IN1 + i, &score[i].amount);
    }
    either_in(GID_IM2_IN13, &lifts);
    either_in(GID_IM2_IN14, &platforms);
    either_in(GID_IM2_IN15, &plugs);
    either_in(GID_IM2_IN16, &timebombs);
    either_in(GID_IM2_IN17, &mines);
    either_in(GID_IM2_IN18, &lightbulbs);
    either_in(GID_IM2_IN19, &hours);
    either_in(GID_IM2_IN20, &minutes);
    either_in(GID_IM2_IN21, &seconds);
    either_in(GID_IM2_IN22, &tower);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j;

    if (filetype == FILETYPE_HISCORES)
    {   if (serializemode == SERIALIZE_WRITE)
        {   sortscores();
        }

        tower      = 1;
        hours      =
        minutes    =
        seconds    =
        plugs      =
        platforms  =
        lifts      =
        timebombs  =
        mines      =
        lightbulbs = 0;

        offset = 0;

        for (i = 0; i < 12; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   for (j = 0; j < 5; j++)
                {   score[i].name[j] = IOBuffer[offset++];   // $00..$04
                }

                score[i].name[5] = EOS;
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                for (j = 0; j < 5; j++)
                {   IOBuffer[offset++] = score[i].name[j];
            }   }

            offset++;                                        // $05

            serialize2ulong(&score[i].amount);               // $06..$07
    }   }
    else
    {   for (i = 0; i < 12; i++)
        {   score[i].name[0] = EOS;
            score[i].amount  = 0;
        }

        offset = 0x4D2;
        tower--;
        serialize1(&tower);                                  // $4D2
        tower++;

        offset = 0x613; serialize1(&hours);                  // $613
                        serialize1(&minutes);                // $614
                        serialize1(&seconds);                // $615
        offset = 0x62E; serialize1(&plugs);
        offset = 0x638; serialize1(&platforms);
        offset = 0x642; serialize1(&lifts);
        offset = 0x64C; serialize1(&timebombs);
        offset = 0x656; serialize1(&mines);
        offset = 0x660; serialize1(&lightbulbs);
}   }

EXPORT void im2_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (filetype == FILETYPE_HISCORES)
    {   gamesave("#?score#?", "Impossible Mission 2", saveas,   96, FLAG_H, FALSE);
    } else
    {   gamesave("#?game#?" , "Impossible Mission 2", saveas, 1715, FLAG_S, FALSE);
}   }

EXPORT void im2_close(void) { ; }
EXPORT void im2_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[5 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 12 - 1; i++)
    {   for (j = 0; j < 12 - i - 1; j++)
        {   if
            (   score[j    ].amount
              < score[j + 1].amount
            )
            {   tempnum             = score[j    ].amount;
                score[j    ].amount = score[j + 1].amount;
                score[j + 1].amount = tempnum;

                strcpy(tempstr,           score[j    ].name);
                strcpy(score[j    ].name, score[j + 1].name);
                strcpy(score[j + 1].name, tempstr);
    }   }   }

    writegadgets();
}

MODULE void maximize_man(void)
{   hours      =  9;
    minutes    =
    seconds    = 59;
    lifts      =
    platforms  =
    plugs      =
    timebombs  =
    mines      =
    lightbulbs = 99;
}

MODULE void im2_ghost(void)
{   int i;

    for (i = 0; i < 12; i++)
    {   ghost(   GID_IM2_IN1 + i, (filetype == FILETYPE_SAVEDGAME));
        ghost_st(GID_IM2_ST1 + i, (filetype == FILETYPE_SAVEDGAME));
    }
    ghost(GID_IM2_BU2,  (filetype == FILETYPE_SAVEDGAME));

    ghost(GID_IM2_IN13, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN14, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN15, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN16, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN17, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN18, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN19, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN20, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN21, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_IN22, (filetype == FILETYPE_HISCORES));
    ghost(GID_IM2_BU1,  (filetype == FILETYPE_HISCORES));
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 12; i++)
    {   score[i].name[0] = EOS;
        score[i].amount  = 0;
}   }

