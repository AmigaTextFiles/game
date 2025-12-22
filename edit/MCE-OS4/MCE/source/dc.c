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

#define GID_DC_LY1    0 // root layout
#define GID_DC_SB1    1 // toolbar
#define GID_DC_CH1    2 // game
#define GID_DC_CH2    3 // file type

// high scores
#define GID_DC_ST1    4 // 1st  initials
#define GID_DC_ST2    5
#define GID_DC_ST3    6
#define GID_DC_ST4    7
#define GID_DC_ST5    8
#define GID_DC_ST6    9
#define GID_DC_ST7   10
#define GID_DC_ST8   11
#define GID_DC_ST9   12
#define GID_DC_ST10  13 // 10th initials
#define GID_DC_IN1   14 // 1st  score
#define GID_DC_IN2   15
#define GID_DC_IN3   16
#define GID_DC_IN4   17
#define GID_DC_IN5   18
#define GID_DC_IN6   19
#define GID_DC_IN7   20
#define GID_DC_IN8   21
#define GID_DC_IN9   22
#define GID_DC_IN10  23 // 10th score
#define GID_DC_BU1   24 // clear high scores

// saved games
// CB1..8 must be consecutive and contiguous
#define GID_DC_CB1   25 // orb
#define GID_DC_CB2   26 // shield
#define GID_DC_CB3   27 // fireball
#define GID_DC_CB4   28 // top    left  orb
#define GID_DC_CB5   29 // top    right orb
#define GID_DC_CB6   30 // middle left  orb
#define GID_DC_CB7   31 // middle right orb
#define GID_DC_CB8   32 // bottom       orb
// IN11..18 must be consecutive and contiguous
#define GID_DC_IN11  33 // score
#define GID_DC_IN12  34 // lives
#define GID_DC_IN13  35 // bombs
#define GID_DC_IN14  36 // elixirs
#define GID_DC_IN15  37 // gas
#define GID_DC_IN16  38 // keys
#define GID_DC_IN17  39 // rocks
#define GID_DC_IN18  40 // slot
#define GID_DC_SL1   41 // slot
#define GID_DC_CH3   42 // difficulty
#define GID_DC_BU2   43 // maximize game

#define GIDS_DC      GID_DC_BU2

#define NameGad(x)  LAYOUT_AddChild, gadgets[GID_DC_ST1 + x] = (struct Gadget*) StringObject,  GA_ID, GID_DC_ST1 + x, GA_TabCycle, TRUE, STRINGA_TextVal, score[x].initials, STRINGA_MaxChars, 12 + 1, STRINGA_MinVisible, 12 + stringextra, StringEnd
#define ScoreGad(x) LAYOUT_AddChild, gadgets[GID_DC_IN1 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_DC_IN1 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, ((game == DC1) ? 0x7FFFFFFF : 99999999), INTEGER_MinVisible, 10 + 1, IntegerEnd

#define DC1           0
#define DC2           1

#define FT_HISCORES   0
#define FT_SAVEGAME   1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void maximize_game(void);

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
IMPORT LONG                 gamesize;
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

MODULE ULONG                difficulty = 0,
                            filetype,
                            game,
                            slot       = 0;

MODULE const STRPTR DifficultyOptions[3 + 1] =
{ "Beginner",
  "Intermediate",
  "Advanced",
  NULL
}, GameOptions[2 + 1] =
{ "Dark Castle",
  "Beyond Dark Castle",
  NULL
}, FiletypeOptions[2 + 1] =
{ "High score table",
  "Saved games",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG amount;
    TEXT  initials[12 + 1];
} score[10];

MODULE struct
{   ULONG score,
          object[3],
          rocks,
          lives,
          keys,
          elixirs,
          bombs,
          gas,
          orb[5];
} save[3][5];

// 8. CODE ---------------------------------------------------------------

EXPORT void dc_main(void)
{   tool_open  = dc_open;
    tool_loop  = dc_loop;
    tool_save  = dc_save;
    tool_close = dc_close;
    tool_exit  = dc_exit;

    if (loaded != FUNC_DC && !dc_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_DC;

    make_speedbar_list(GID_DC_SB1);
    load_fimage(FUNC_DC);
    load_aiss_images(9, 10);
    load_images(548, 555);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_CloseGadget,                                    FALSE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_DC_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_DC_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddVLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_DC_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_DC_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    LAYOUT_AddChild,                       gadgets[GID_DC_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_DC_CH2,
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
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "High Score Table",
                    AddHLayout,
                        AddVLayout,
                            NameGad(0),
                            Label("#1:"),
                            NameGad(1),
                            Label("#2:"),
                            NameGad(2),
                            Label("#3:"),
                            NameGad(3),
                            Label("#4:"),
                            NameGad(4),
                            Label("#5:"),
                            NameGad(5),
                            Label("#6:"),
                            NameGad(6),
                            Label("#7:"),
                            NameGad(7),
                            Label("#8:"),
                            NameGad(8),
                            Label("#9:"),
                            NameGad(9),
                            Label("#10:"),
                        LayoutEnd,
                        AddVLayout,
                            ScoreGad(0),
                            ScoreGad(1),
                            ScoreGad(2),
                            ScoreGad(3),
                            ScoreGad(4),
                            ScoreGad(5),
                            ScoreGad(6),
                            ScoreGad(7),
                            ScoreGad(8),
                            ScoreGad(9),
                        LayoutEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_DC),
                        CHILD_WeightedWidth,               0,
                        AddSpace,
                    LayoutEnd,
                    ClearButton(GID_DC_BU1, "Clear High Scores"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Saved Games",
                    LAYOUT_AddChild,                       gadgets[GID_DC_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_DC_CH3,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_LabelArray,                &DifficultyOptions,
                        CHOOSER_Selected,                  (WORD) difficulty,
                    ChooserEnd,
                    Label("Difficulty:"),
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_DC_SL1] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_DC_SL1,
                            GA_RelVerify,                  TRUE,
                            SLIDER_Min,                    1,
                            SLIDER_Level,                  slot + 1,
                            SLIDER_Max,                    5,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  5, // how many ticks to display
                        SliderEnd,
                        LAYOUT_AddChild,                   gadgets[GID_DC_IN18] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_DC_IN18,
                            GA_RelVerify,                  TRUE,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Number,                slot + 1,
                            INTEGER_Maximum,               5,
                            INTEGER_MinVisible,            1 + 1,
                        IntegerEnd,
                        CHILD_WeightedWidth,               0,
                        AddLabel("of 5"),
                        CHILD_WeightedWidth,               0,
                    LayoutEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                        LAYOUT_SpaceOuter,                 TRUE,
                        AddLabel(""),
                        LAYOUT_AddChild,                   gadgets[GID_DC_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_DC_IN11,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99999999,
                            INTEGER_MinVisible,            8 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_DC_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_DC_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Lives:"),
                        CHILD_WeightedHeight,              0,
                        AddLabel(""),
                        AddHLayout,
                            AddVLayout,
                                AddImage(551),
                                AddImage(552),
                                AddImage(553),
                                AddImage(554),
                                AddImage(555),
                            LayoutEnd,
                            CHILD_WeightedWidth,           0,
                            AddVLayout,
                                AddLabel("Bombs:"),
                                AddLabel("Elixirs:"),
                                AddLabel("Gas:"),
                                AddLabel("Keys:"),
                                AddLabel("Rocks:"),
                            LayoutEnd,
                            CHILD_WeightedWidth,           0,
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_DC_IN13] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_DC_IN13,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       65535,
                                    INTEGER_MinVisible,    5 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,           gadgets[GID_DC_IN14] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_DC_IN14,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       65535,
                                    INTEGER_MinVisible,    5 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,           gadgets[GID_DC_IN15] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_DC_IN15,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       65535,
                                    INTEGER_MinVisible,    5 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,           gadgets[GID_DC_IN16] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_DC_IN16,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       65535,
                                    INTEGER_MinVisible,    5 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,           gadgets[GID_DC_IN17] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_DC_IN17,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       65535,
                                    INTEGER_MinVisible,    5 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddLabel(""),
                        AddHLayout,
                            AddImage(548),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_DC_CB1] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                     GID_DC_CB1,
                                GA_Text,                   "Orb",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            AddImage(549),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_DC_CB2] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                     GID_DC_CB2,
                                GA_Text,                   "Shield",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            AddImage(550),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_DC_CB3] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                     GID_DC_CB3,
                                GA_Text,                   "Fireball",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddLabel(""),
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Ante Room Orbs",
                            AddHLayout,
                                LAYOUT_AddChild,           gadgets[GID_DC_CB4] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_DC_CB4,
                                End,
                                CHILD_WeightedWidth,       0,
                                AddSpace,
                                LAYOUT_AddChild,           gadgets[GID_DC_CB5] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_DC_CB5,
                                End,
                                CHILD_WeightedWidth,       0,
                            LayoutEnd,
                            AddHLayout,
                                AddSpace,
                                LAYOUT_AddChild,           gadgets[GID_DC_CB6] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_DC_CB6,
                                End,
                                CHILD_WeightedWidth,       0,
                                AddSpace,
                                LAYOUT_AddChild,           gadgets[GID_DC_CB7] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_DC_CB7,
                                End,
                                CHILD_WeightedWidth,       0,
                                AddSpace,
                            LayoutEnd,
                            AddHLayout,
                                AddSpace,
                                LAYOUT_AddChild,           gadgets[GID_DC_CB8] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_DC_CB8,
                                End,
                                CHILD_WeightedWidth,       0,
                                AddSpace,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                        MaximizeButton(GID_DC_BU2, "Maximize Game"),
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_DC_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_DC_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_DC_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void dc_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_DC_BU1:
        clearscores();
        writegadgets();
    acase GID_DC_BU2:
        maximize_game();
        writegadgets();
    acase GID_DC_CH3:
        gadmode = SERIALIZE_READ;
        either_ch(GID_DC_CH3, &difficulty);
        writegadgets();
    acase GID_DC_IN18:
        gadmode = SERIALIZE_READ;
        either_in(GID_DC_IN18, &slot);
        slot--;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_DC_SL1], MainWindowPtr, NULL,
            SLIDER_Level, slot + 1,
        TAG_DONE); // this autorefreshes
        writegadgets();
    acase GID_DC_SL1:
        gadmode = SERIALIZE_READ;
        either_sl(GID_DC_SL1, &slot);
        slot--;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_DC_IN18], MainWindowPtr, NULL,
            INTEGER_Number, slot + 1,
        TAG_DONE); // this autorefreshes
        writegadgets();
}   }

EXPORT FLAG dc_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 80)
        {   game = DC1;
            filetype = FT_HISCORES;
        } elif (gamesize == 812032)
        {   game = DC2;
            if     (!stricmp("Disk.1", (char*) FilePart(pathname)))
            {   filetype = FT_HISCORES;
            } elif (!stricmp("Disk.2", (char*) FilePart(pathname)))
            {   filetype = FT_SAVEGAME;
            } else
            {   if (ask("What do you want to edit?", "High scores|Saved games") == 0) // high scores
                {   filetype = FT_HISCORES;
                } else
                {   filetype = FT_SAVEGAME;
        }   }   }
        else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_DC
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    either_ch(GID_DC_CH1, &game);
    either_ch(GID_DC_CH2, &filetype);
    eithergadgets();

    for (i = 0; i < 10; i++)
    {   ghost_st(GID_DC_ST1  + i, filetype != FT_HISCORES);
        ghost(   GID_DC_IN1  + i, filetype != FT_HISCORES);
    }
    for (i = 0; i < 8; i++)
    {   ghost_st(GID_DC_CB1  + i, filetype != FT_SAVEGAME);
        ghost(   GID_DC_IN11 + i, filetype != FT_SAVEGAME);
    }
    ghost(       GID_DC_BU1     , filetype != FT_HISCORES);
    ghost(       GID_DC_BU2     , filetype != FT_SAVEGAME);
    ghost(       GID_DC_SL1     , filetype != FT_SAVEGAME);
    ghost(       GID_DC_CH3     , filetype != FT_SAVEGAME);
}

MODULE void eithergadgets(void)
{   int i;

    switch (filetype)
    {
    case FT_HISCORES:
        for (i = 0; i < 10; i++)
        {   if (gadmode == SERIALIZE_WRITE)
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_DC_ST1 + i], MainWindowPtr, NULL,
                 // STRINGA_MaxChars, ((game == DC1) ? 3 : 12) + 1, (unfortunately STRINGA_MaxChars is only OM_NEWable, not OM_SETtable)
                    GA_Disabled,      (game == DC2 && i >= 5) ? TRUE : FALSE,
                TAG_DONE); // we must explicitly refresh
                RefreshGadgets((struct Gadget*) gadgets[GID_DC_ST1 + i], MainWindowPtr, NULL);

                DISCARD SetGadgetAttrs
                (   gadgets[GID_DC_IN1 + i], MainWindowPtr, NULL,
                    INTEGER_Maximum,  (game == DC1) ? 0x7FFFFFFF : 99999999,
                    GA_Disabled,      (game == DC2 && i >= 5) ? TRUE : FALSE,
                TAG_DONE); // this autorefreshes
            }

            either_in(GID_DC_IN1 + i, &score[i].amount);
            either_st(GID_DC_ST1 + i,  score[i].initials);
        }
    acase FT_SAVEGAME:
        either_in(GID_DC_IN11, &save[difficulty][slot].score);
        either_in(GID_DC_IN12, &save[difficulty][slot].lives);
        either_in(GID_DC_IN13, &save[difficulty][slot].bombs);
        either_in(GID_DC_IN14, &save[difficulty][slot].elixirs);
        either_in(GID_DC_IN15, &save[difficulty][slot].gas);
        either_in(GID_DC_IN16, &save[difficulty][slot].keys);
        either_in(GID_DC_IN17, &save[difficulty][slot].rocks);

        either_cb(GID_DC_CB1,  &save[difficulty][slot].object[0]);
        either_cb(GID_DC_CB2,  &save[difficulty][slot].object[1]);
        either_cb(GID_DC_CB3,  &save[difficulty][slot].object[2]);
        either_cb(GID_DC_CB4,  &save[difficulty][slot].orb[0]);
        either_cb(GID_DC_CB5,  &save[difficulty][slot].orb[1]);
        either_cb(GID_DC_CB6,  &save[difficulty][slot].orb[2]);
        either_cb(GID_DC_CB7,  &save[difficulty][slot].orb[3]);
        either_cb(GID_DC_CB8,  &save[difficulty][slot].orb[4]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j,
        length;

    if (filetype == FT_HISCORES && serializemode == SERIALIZE_WRITE)
    {   if (game == DC1)
        {   for (i = 0; i < 10; i++)
            {   score[i].initials[3] = EOS;
        }   }
        sortscores();
    }

    switch (game)
    {
    case DC1:
        // assert(filetype == FT_HISCORES);
        offset = 0;

        for (i = 0; i < 10; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   score[i].initials[0] = IOBuffer[offset++];
                score[i].initials[1] = IOBuffer[offset++];
                score[i].initials[2] = IOBuffer[offset++];
                score[i].initials[3] = EOS;

                score[i].amount  = (((IOBuffer[offset    ] & 0xF0) >> 4) * 1000000000)
                                 + ( (IOBuffer[offset    ] & 0x0F)       *  100000000)
                                 + (((IOBuffer[offset + 1] & 0xF0) >> 4) *   10000000)
                                 + ( (IOBuffer[offset + 1] & 0x0F)       *    1000000)
                                 + (((IOBuffer[offset + 2] & 0xF0) >> 4) *     100000)
                                 + ( (IOBuffer[offset + 2] & 0x0F)       *      10000)
                                 + (((IOBuffer[offset + 3] & 0xF0) >> 4) *       1000)
                                 + ( (IOBuffer[offset + 3] & 0x0F)       *        100)
                                 + (((IOBuffer[offset + 4] & 0xF0) >> 4) *         10)
                                 +   (IOBuffer[offset + 4] & 0x0F);
                offset += 5;
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);

                if (score[i].initials[0] == EOS)
                {   IOBuffer[offset++] = EOS;
                    IOBuffer[offset++] = EOS;
                    IOBuffer[offset++] = EOS;
                } else
                {   IOBuffer[offset++] = score[i].initials[0] ? score[i].initials[0] : '-';
                    IOBuffer[offset++] = score[i].initials[1] ? score[i].initials[1] : '-';
                    IOBuffer[offset++] = score[i].initials[2] ? score[i].initials[2] : '-';
                }

                IOBuffer[offset++] = (( score[i].amount               / 1000000000) << 4)
                                   |  ((score[i].amount % 1000000000) /  100000000);
                IOBuffer[offset++] = (((score[i].amount %  100000000) /   10000000) << 4)
                                   |  ((score[i].amount %   10000000) /    1000000);
                IOBuffer[offset++] = (((score[i].amount %    1000000) /     100000) << 4)
                                   |  ((score[i].amount %     100000) /      10000);
                IOBuffer[offset++] = (((score[i].amount %      10000) /       1000) << 4)
                                   |  ((score[i].amount %       1000) /        100);
                IOBuffer[offset++] = (((score[i].amount %        100) /         10) << 4)
                                   |   (score[i].amount %         10)             ;
        }   }
    acase DC2:
        if (filetype == FT_HISCORES)
        {   offset = 0x9600;

            for (i = 0; i < 5; i++)
            {   if (serializemode == SERIALIZE_READ)
                {   score[i].amount  = (((IOBuffer[offset + 0] & 0xF0) >> 4) *   10000000)
                                     + ( (IOBuffer[offset + 0] & 0x0F)       *    1000000)
                                     + (((IOBuffer[offset + 1] & 0xF0) >> 4) *     100000)
                                     + ( (IOBuffer[offset + 1] & 0x0F)       *      10000)
                                     + (((IOBuffer[offset + 2] & 0xF0) >> 4) *       1000)
                                     + ( (IOBuffer[offset + 2] & 0x0F)       *        100)
                                     + (((IOBuffer[offset + 3] & 0xF0) >> 4) *         10)
                                     +   (IOBuffer[offset + 3] & 0x0F);
                    offset += 4;
                    for (j = 0; j < 12; j++)
                    {   score[i].initials[j] = IOBuffer[offset++];
                    }
                    score[i].initials[12] = EOS;
                } else
                {   // assert(serializemode == SERIALIZE_WRITE);

                    IOBuffer[offset++] = (( score[i].amount               /   10000000) << 4)
                                       |  ((score[i].amount %   10000000) /    1000000);
                    IOBuffer[offset++] = (((score[i].amount %    1000000) /     100000) << 4)
                                       |  ((score[i].amount %     100000) /      10000);
                    IOBuffer[offset++] = (((score[i].amount %      10000) /       1000) << 4)
                                       |  ((score[i].amount %       1000) /        100);
                    IOBuffer[offset++] = (((score[i].amount %        100) /         10) << 4)
                                       |   (score[i].amount %         10)             ;
                    length = strlen(score[i].initials);
                    if (length < 12)
                    {   for (j = length; j <= 11; j++) // add trailing spaces
                        {   score[i].initials[j] = ' ';
                        }
                        score[i].initials[12] = EOS;
                    }

                    for (j = 0; j < 12; j++)
                    {   IOBuffer[offset++] = score[i].initials[j];
            }   }   }

            for (i = 5; i < 10; i++)
            {   score[i].amount      = 0;
                score[i].initials[0] = EOS;
        }   }
        else
        {   // assert(filetype == FT_SAVEGAME);
            offset = 0x10202;

            for (i = 0; i < 3; i++)
            {   for (j = 0; j < 5; j++)
                {   offset += 2;                            // $10202..$10203
                    serialize_bcd4( &save[i][j].score);     // $10204..$10207
                    offset += 4;                            // $10208..$1020B
                    serialize2ulong(&save[i][j].object[1]); // $1020C..$1020D shield
                    serialize2ulong(&save[i][j].object[2]); // $1020E..$1020F fireball
                    serialize2ulong(&save[i][j].rocks);     // $10210..$10211
                    serialize2ulong(&save[i][j].lives);     // $10212..$10213
                    serialize2ulong(&save[i][j].object[0]); // $10214..$10215 orb
                    serialize2ulong(&save[i][j].keys);      // $10216..$10217
                    serialize2ulong(&save[i][j].elixirs);   // $10218..$10219
                    serialize2ulong(&save[i][j].bombs);     // $1021A..$1021B
                    serialize2ulong(&save[i][j].gas);       // $1021C..$1021D
                    offset += 5;                            // $1021E..$10222
                    serialize1(&save[i][j].orb[0]);         // $10223
                    serialize1(&save[i][j].orb[1]);         // $10224
                    serialize1(&save[i][j].orb[2]);         // $10225
                    serialize1(&save[i][j].orb[3]);         // $10226
                    serialize1(&save[i][j].orb[4]);         // $10227
                    offset += 2;                            // $10228..$10229
}   }   }   }   }

EXPORT void dc_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (game == DC1)
    {   gamesave("#?highscor#?", "Dark Castle",        saveas,     80, FLAG_H         , FALSE);
    } else
    {   // assert(game == DC2);
        gamesave("Disk.1",       "Beyond Dark Castle", saveas, 812032, FLAG_H | FLAG_S, FALSE);
}   }

EXPORT void dc_close(void) { ; }
EXPORT void dc_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[12 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 10 - 1; i++)
    {   for (j = 0; j < 10 - i - 1; j++)
        {   if
            (   score[j    ].amount
              < score[j + 1].amount
            )
            {   tempnum             = score[j    ].amount;
                score[j    ].amount = score[j + 1].amount;
                score[j + 1].amount = tempnum;

                strcpy(tempstr,               score[j    ].initials);
                strcpy(score[j    ].initials, score[j + 1].initials);
                strcpy(score[j + 1].initials, tempstr);
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   score[i].initials[0] = EOS;
        score[i].amount      = 0;
}   }

MODULE void maximize_game(void)
{   save[difficulty][slot].object[0] =
    save[difficulty][slot].object[1] =
    save[difficulty][slot].object[2] =
    save[difficulty][slot].orb[0]    =
    save[difficulty][slot].orb[1]    =
    save[difficulty][slot].orb[2]    =
    save[difficulty][slot].orb[3]    =
    save[difficulty][slot].orb[4]    =        1;
    save[difficulty][slot].lives     =
    save[difficulty][slot].bombs     =
    save[difficulty][slot].elixirs   =
    save[difficulty][slot].gas       =
    save[difficulty][slot].keys      =
    save[difficulty][slot].rocks     =       99;
    save[difficulty][slot].score     = 90000000;
}
