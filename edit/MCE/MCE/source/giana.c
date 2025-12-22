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

/* 2. DEFINES ------------------------------------------------------------

Great Giana Sisters:
 For score climbers, we track name, score and level.
Hard 'n' Heavy:
 For score climbers, we track name and score.
 For level climbers, we track name, percent and level. */

#define GID_GIANA_LY1    0 // root layout
#define GID_GIANA_SB1    1 // toolbar
#define GID_GIANA_ST1    2 // 1st  name
#define GID_GIANA_ST2    3
#define GID_GIANA_ST3    4
#define GID_GIANA_ST4    5
#define GID_GIANA_ST5    6
#define GID_GIANA_ST6    7
#define GID_GIANA_ST7    8
#define GID_GIANA_ST8    9
#define GID_GIANA_ST9   10
#define GID_GIANA_ST10  11 // 10th name
#define GID_GIANA_IN1   12 // 1st score
#define GID_GIANA_IN2   13
#define GID_GIANA_IN3   14
#define GID_GIANA_IN4   15
#define GID_GIANA_IN5   16 // 5th score
#define GID_GIANA_IN6   17 // 1st level (score climbers table)
#define GID_GIANA_IN7   18
#define GID_GIANA_IN8   19
#define GID_GIANA_IN9   20
#define GID_GIANA_IN10  21 // 5th level (score climbers table)
#define GID_GIANA_IN11  22 // 1st percent
#define GID_GIANA_IN12  23
#define GID_GIANA_IN13  24
#define GID_GIANA_IN14  25
#define GID_GIANA_IN15  26 // 5th percent
#define GID_GIANA_IN16  27 // 6th level (level climbers table)
#define GID_GIANA_IN17  28
#define GID_GIANA_IN18  29
#define GID_GIANA_IN19  30
#define GID_GIANA_IN20  31 // 10th level (level climbers table)
#define GID_GIANA_CH1   32 // game
#define GID_GIANA_BU1   33 // clear high scores
#define GID_GIANA_BU2   34 // clear high levels
#define GIDS_GIANA      GID_GIANA_BU2

#define GIANA1           0
#define GIANA2           1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void serialize_name(int whichname);
MODULE void clearscores(void);
MODULE void clearlevels(void);

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

MODULE TEXT  name[10][10 + 1]; // [0..4] are score climbers, [5..9] are level climbers
MODULE ULONG game,
             score[5],         // [0..4] are score climbers
             level[10],        // [0..4] are score climbers, [5..9] are level climbers
             percent[5];       // [0..4] are level climbers

MODULE const STRPTR GameOptions[2 + 1] =
{ "Great Giana Sisters",
  "Hard 'n' Heavy",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void giana_main(void)
{   tool_open  = giana_open;
    tool_loop  = giana_loop;
    tool_save  = giana_save;
    tool_close = giana_close;
    tool_exit  = giana_exit;

    if (loaded != FUNC_GIANA && !giana_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_GIANA;

    make_speedbar_list(GID_GIANA_SB1);
    load_fimage(FUNC_GIANA);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_GIANA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                AddToolbar(GID_GIANA_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_GIANA_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_GIANA_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_GIANA),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Score Climbers Table",
                AddHLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[0],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#1: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[1],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#2: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[2],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#3: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[3],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#4: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[4],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#5: Name:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN9,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN10,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        Label("Score:"),
                    LayoutEnd,
                LayoutEnd,
                ClearButton(GID_GIANA_BU1, "Clear Score Climbers Table"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Level Climbers Table",
                AddHLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[5],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#1: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST7] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST7,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[6],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#2: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST8] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST8,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[7],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#3: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST9] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST9,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[8],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#4: Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_ST10] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GIANA_ST10,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name[9],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("#5: Name:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN16] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN16,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN17] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN17,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN18] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN18,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN19] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN19,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN20] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN20,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN11,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Percentage:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Percentage:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN13] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN13,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Percentage:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN14] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN14,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Percentage:"),
                        LAYOUT_AddChild,                   gadgets[GID_GIANA_IN15] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GIANA_IN15,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Percentage:"),
                    LayoutEnd,
                LayoutEnd,
                ClearButton(GID_GIANA_BU2, "Clear Level Climbers Table"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_GIANA_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_GIANA_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_GIANA_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void giana_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_GIANA_BU1:
        clearscores();
        writegadgets();
    acase GID_GIANA_BU2:
        clearlevels();
        writegadgets();
}   }

EXPORT FLAG giana_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 96)
        {   game = GIANA1;
        } elif (gamesize == 180)
        {   game = GIANA2;
        } else
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
{   if
    (   page != FUNC_GIANA
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    if (gadmode == SERIALIZE_WRITE)
    {   either_ch(GID_GIANA_CH1, &game);

        for (i = 0; i < 5; i++)
        {   ghost(GID_GIANA_ST6  + i, game != GIANA2); // level climber names
            ghost(GID_GIANA_IN6  + i, game != GIANA1); // score climber levels
            ghost(GID_GIANA_IN11 + i, game != GIANA2); // level climber percents
            ghost(GID_GIANA_IN16 + i, game != GIANA2); // level climber levels
    }   }

    for (i = 0; i < 10; i++)
    {   either_st(GID_GIANA_ST1  + i, name[i]);
    }
    for (i = 0; i < 5; i++)
    {   either_in(GID_GIANA_IN1  + i, &score[i]);     // score climber scores
        either_in(GID_GIANA_IN6  + i, &level[i]);     // score climber levels
        either_in(GID_GIANA_IN11 + i, &percent[i]);   // level climber percents
        either_in(GID_GIANA_IN16 + i, &level[i + 5]); // level climber levels
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    if (serializemode == SERIALIZE_WRITE)
    {   sortscores();
    }

    offset = 0;
    for (i = 0; i < 5; i++)
    {   serialize_name(i); // score climber names
    }
    offset = 51;
    for (i = 0; i < 5; i++)
    {   serialize_bcd3(&score[i]); // score climber scores
    }

    if (game == GIANA1)
    {   offset = 73;
        for (i = 0; i < 5; i++)
        {   serialize_bcd1(&level[i]); // score climber levels
            offset += 3;

            name[i + 5][0] = EOS; // level climber names
            percent[i]     =      // level climber percents
            level[i + 5]   = 0;   // level climber levels
    }   }
    else
    {   // assert(game == GIANA2);
        offset = 90;
        for (i = 5; i < 10; i++)
        {   serialize_name(i); // level climber names
        }
        offset = 143;
        for (i = 0; i < 5; i++)
        {   serialize_bcd1(&percent[i]); // level climber percents
            offset += 3;

            level[i] = 0; // score climber levels
        }
        for (i = 5; i < 10; i++)
        {   serialize_bcd1(&level[i]); // level climber levels
            offset += 3;
}   }   }

EXPORT void giana_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (game == GIANA1)
    {   gamesave("#?gianahigh#?", "Great Giana Sisters", saveas,  96, FLAG_H, FALSE);
    } else
    {   // assert(game == GIANA2);
        gamesave("#?hnhhigh#?",   "Hard 'n' Heavy"     , saveas, 180, FLAG_H, FALSE);
}   }

EXPORT void giana_close(void) { ; }
EXPORT void giana_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[10 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    // score climbers table (sorted by score)
    for (i = 0; i < 5 - 1; i++)
    {   for (j = 0; j < 5 - i - 1; j++)
        {   if
            (   score[j    ]
              < score[j + 1]
            )
            {   tempnum      = score[j    ];
                score[j    ] = score[j + 1];
                score[j + 1] = tempnum;

                strcpy(tempstr,     name[j    ]);
                strcpy(name[j    ], name[j + 1]);
                strcpy(name[j + 1], tempstr);

                tempnum      = level[j    ];
                level[j    ] = level[j + 1];
                level[j + 1] = tempnum;
    }   }   }

    // level climbers table (sorted by level)
    for (i = 0; i < 5 - 1; i++)
    {   for (j = 0; j < 5 - i - 1; j++)
        {   if
            (   level[5 + j    ]
              < level[5 + j + 1]
            )
            {   tempnum          = level[5 + j    ];
                level[5 + j    ] = level[5 + j + 1];
                level[5 + j + 1] = tempnum;

                strcpy(tempstr,         name[5 + j    ]);
                strcpy(name[5 + j    ], name[5 + j + 1]);
                strcpy(name[5 + j + 1], tempstr);

                tempnum          = percent[j    ];
                percent[j    ]   = percent[j + 1];
                percent[j + 1]   = tempnum;
    }   }   }

    writegadgets();
}

MODULE void serialize_name(int whichname)
{   int i,
        length;

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < 10; i++)
        {   name[whichname][i] = IOBuffer[offset++];
        }
        for (i = 9; i >= 0; i--)
        {   if (name[whichname][i] == ' ')
            {   name[whichname][i] = EOS;
            } else
            {   break;
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        length = strlen(name[whichname]);
        if (length < 10)
        {   for (i = length; i < 10; i++)
            {   name[whichname][i] = ' ';
        }   }
        for (i = 0; i < 10; i++)
        {   IOBuffer[offset++] = name[whichname][i];
        }
        name[whichname][length] = EOS;
}   }

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 5; i++)
    {   name[i][0] = EOS;
        level[i]   =
        score[i]   = 0;
}   }

MODULE void clearlevels(void)
{   int i;

    for (i = 0; i < 5; i++)
    {   name[5 + i][0] = EOS;
        level[5 + i]   =
        percent[i]     = 0;
}   }
