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

#define GID_NITRO_LY1    0 // root layout
#define GID_NITRO_SB1    1 // toolbar
#define GID_NITRO_ST1    2 //  1st name
#define GID_NITRO_ST40  41 // 40th name
#define GID_NITRO_IN1   42 //  1st score
#define GID_NITRO_IN8   49 //  8th score
#define GID_NITRO_IN9   50 //  1st secs
#define GID_NITRO_IN40  81 // 32nd secs
#define GID_NITRO_IN41  82 //  1st hundredths
#define GID_NITRO_IN72 113 // 32nd hundredths
#define GID_NITRO_BU1  114 // clear high scores
#define GID_NITRO_BU2  115 // clear fastest times
#define GIDS_NITRO     GID_NITRO_IN72

#define NameGad(x)       LAYOUT_AddChild, gadgets[GID_NITRO_ST1  + x] = (struct Gadget*) StringObject,  GA_ID, GID_NITRO_ST1  + x, GA_TabCycle, TRUE, STRINGA_TextVal, name[x], STRINGA_MaxChars, 3 + 1, STRINGA_MinVisible, 3 + stringextra, StringEnd
#define ScoreGad(x)      LAYOUT_AddChild, gadgets[GID_NITRO_IN1  + x] = (struct Gadget*) IntegerObject, GA_ID, GID_NITRO_IN1  + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 999999, INTEGER_MinVisible, 6 + 1, IntegerEnd
#define SecsGad(x)       LAYOUT_AddChild, gadgets[GID_NITRO_IN9  + x] = (struct Gadget*) IntegerObject, GA_ID, GID_NITRO_IN9  + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum,     99, INTEGER_MinVisible, 2 + 1, IntegerEnd
#define HundredthsGad(x) LAYOUT_AddChild, gadgets[GID_NITRO_IN41 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_NITRO_IN41 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum,     99, INTEGER_MinVisible, 2 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void cleartimes(void);

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
IMPORT struct Hook          ToolHookStruct;
IMPORT struct HintInfo*     HintInfoPtr;
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

MODULE TEXT                 name[40][3 + 1];
MODULE ULONG                score[8],
                            secs[32], hundredths[32];

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void nitro_main(void)
{   tool_open  = nitro_open;
    tool_loop  = nitro_loop;
    tool_save  = nitro_save;
    tool_close = nitro_close;
    tool_exit  = nitro_exit;

    if (loaded != FUNC_NITRO && !nitro_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_NITRO;

    load_fimage(FUNC_NITRO);
    make_speedbar_list(GID_NITRO_SB1);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_NITRO_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddToolbar(GID_NITRO_SB1),
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "High Scores",
                        AddHLayout,
                            NameGad(0),
                            ScoreGad(0),
                        LayoutEnd,
                        Label("#1:"),
                        AddHLayout,
                            NameGad(1),
                            ScoreGad(1),
                        LayoutEnd,
                        Label("#2:"),
                        AddHLayout,
                            NameGad(2),
                            ScoreGad(2),
                        LayoutEnd,
                        Label("#3:"),
                        AddHLayout,
                            NameGad(3),
                            ScoreGad(3),
                        LayoutEnd,
                        Label("#4:"),
                        AddHLayout,
                            NameGad(4),
                            ScoreGad(4),
                        LayoutEnd,
                        Label("#5:"),
                        AddHLayout,
                            NameGad(5),
                            ScoreGad(5),
                        LayoutEnd,
                        Label("#6:"),
                        AddHLayout,
                            NameGad(6),
                            ScoreGad(6),
                        LayoutEnd,
                        Label("#7:"),
                        AddHLayout,
                            NameGad(7),
                            ScoreGad(7),
                        LayoutEnd,
                        Label("#8:"),
                        ClearButton(GID_NITRO_BU1, "Clear High Scores"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_NITRO),
                        CHILD_WeightedWidth,               0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Fastest Times",
                    AddHLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "City",
                            AddHLayout,
                                NameGad(8),
                                SecsGad(0),
                                AddLabel("."),
                                HundredthsGad(0),
                            LayoutEnd,
                            Label("#1:"),
                            AddHLayout,
                                NameGad(9),
                                SecsGad(1),
                                AddLabel("."),
                                HundredthsGad(1),
                            LayoutEnd,
                            Label("#2:"),
                            AddHLayout,
                                NameGad(10),
                                SecsGad(2),
                                AddLabel("."),
                                HundredthsGad(2),
                            LayoutEnd,
                            Label("#3:"),
                            AddHLayout,
                                NameGad(11),
                                SecsGad(3),
                                AddLabel("."),
                                HundredthsGad(3),
                            LayoutEnd,
                            Label("#4:"),
                            AddHLayout,
                                NameGad(12),
                                SecsGad(4),
                                AddLabel("."),
                                HundredthsGad(4),
                            LayoutEnd,
                            Label("#5:"),
                            AddHLayout,
                                NameGad(13),
                                SecsGad(5),
                                AddLabel("."),
                                HundredthsGad(5),
                            LayoutEnd,
                            Label("#6:"),
                            AddHLayout,
                                NameGad(14),
                                SecsGad(6),
                                AddLabel("."),
                                HundredthsGad(6),
                            LayoutEnd,
                            Label("#7:"),
                            AddHLayout,
                                NameGad(15),
                                SecsGad(7),
                                AddLabel("."),
                                HundredthsGad(7),
                            LayoutEnd,
                            Label("#8:"),
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Forest",
                            AddHLayout,
                                NameGad(8 + 8),
                                SecsGad(8 + 0),
                                AddLabel("."),
                                HundredthsGad(8 + 0),
                            LayoutEnd,
                            Label("#1:"),
                            AddHLayout,
                                NameGad(8 + 9),
                                SecsGad(8 + 1),
                                AddLabel("."),
                                HundredthsGad(8 + 1),
                            LayoutEnd,
                            Label("#2:"),
                            AddHLayout,
                                NameGad(8 + 10),
                                SecsGad(8 + 2),
                                AddLabel("."),
                                HundredthsGad(8 + 2),
                            LayoutEnd,
                            Label("#3:"),
                            AddHLayout,
                                NameGad(8 + 11),
                                SecsGad(8 + 3),
                                AddLabel("."),
                                HundredthsGad(8 + 3),
                            LayoutEnd,
                            Label("#4:"),
                            AddHLayout,
                                NameGad(8 + 12),
                                SecsGad(8 + 4),
                                AddLabel("."),
                                HundredthsGad(8 + 4),
                            LayoutEnd,
                            Label("#5:"),
                            AddHLayout,
                                NameGad(8 + 13),
                                SecsGad(8 + 5),
                                AddLabel("."),
                                HundredthsGad(8 + 5),
                            LayoutEnd,
                            Label("#6:"),
                            AddHLayout,
                                NameGad(8 + 14),
                                SecsGad(8 + 6),
                                AddLabel("."),
                                HundredthsGad(8 + 6),
                            LayoutEnd,
                            Label("#7:"),
                            AddHLayout,
                                NameGad(8 + 15),
                                SecsGad(8 + 7),
                                AddLabel("."),
                                HundredthsGad(8 + 7),
                            LayoutEnd,
                            Label("#8:"),
                        LayoutEnd,
                    LayoutEnd,
                    AddHLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Desert",
                            AddHLayout,
                                NameGad(16 + 8),
                                SecsGad(16 + 0),
                                AddLabel("."),
                                HundredthsGad(16 + 0),
                            LayoutEnd,
                            Label("#1:"),
                            AddHLayout,
                                NameGad(16 + 9),
                                SecsGad(16 + 1),
                                AddLabel("."),
                                HundredthsGad(16 + 1),
                            LayoutEnd,
                            Label("#2:"),
                            AddHLayout,
                                NameGad(16 + 10),
                                SecsGad(16 + 2),
                                AddLabel("."),
                                HundredthsGad(16 + 2),
                            LayoutEnd,
                            Label("#3:"),
                            AddHLayout,
                                NameGad(16 + 11),
                                SecsGad(16 + 3),
                                AddLabel("."),
                                HundredthsGad(16 + 3),
                            LayoutEnd,
                            Label("#4:"),
                            AddHLayout,
                                NameGad(16 + 12),
                                SecsGad(16 + 4),
                                AddLabel("."),
                                HundredthsGad(16 + 4),
                            LayoutEnd,
                            Label("#5:"),
                            AddHLayout,
                                NameGad(16 + 13),
                                SecsGad(16 + 5),
                                AddLabel("."),
                                HundredthsGad(16 + 5),
                            LayoutEnd,
                            Label("#6:"),
                            AddHLayout,
                                NameGad(16 + 14),
                                SecsGad(16 + 6),
                                AddLabel("."),
                                HundredthsGad(16 + 6),
                            LayoutEnd,
                            Label("#7:"),
                            AddHLayout,
                                NameGad(16 + 15),
                                SecsGad(16 + 7),
                                AddLabel("."),
                                HundredthsGad(16 + 7),
                            LayoutEnd,
                            Label("#8:"),
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Apocalypse",
                            AddHLayout,
                                NameGad(24 + 8),
                                SecsGad(24 + 0),
                                AddLabel("."),
                                HundredthsGad(24 + 0),
                            LayoutEnd,
                            Label("#1:"),
                            AddHLayout,
                                NameGad(24 + 9),
                                SecsGad(24 + 1),
                                AddLabel("."),
                                HundredthsGad(24 + 1),
                            LayoutEnd,
                            Label("#2:"),
                            AddHLayout,
                                NameGad(24 + 10),
                                SecsGad(24 + 2),
                                AddLabel("."),
                                HundredthsGad(24 + 2),
                            LayoutEnd,
                            Label("#3:"),
                            AddHLayout,
                                NameGad(24 + 11),
                                SecsGad(24 + 3),
                                AddLabel("."),
                                HundredthsGad(24 + 3),
                            LayoutEnd,
                            Label("#4:"),
                            AddHLayout,
                                NameGad(24 + 12),
                                SecsGad(24 + 4),
                                AddLabel("."),
                                HundredthsGad(24 + 4),
                            LayoutEnd,
                            Label("#5:"),
                            AddHLayout,
                                NameGad(24 + 13),
                                SecsGad(24 + 5),
                                AddLabel("."),
                                HundredthsGad(24 + 5),
                            LayoutEnd,
                            Label("#6:"),
                            AddHLayout,
                                NameGad(24 + 14),
                                SecsGad(24 + 6),
                                AddLabel("."),
                                HundredthsGad(24 + 6),
                            LayoutEnd,
                            Label("#7:"),
                            AddHLayout,
                                NameGad(24 + 15),
                                SecsGad(24 + 7),
                                AddLabel("."),
                                HundredthsGad(24 + 7),
                            LayoutEnd,
                            Label("#8:"),
                        LayoutEnd,
                    LayoutEnd,
                    ClearButton(GID_NITRO_BU2, "Clear Fastest Times"),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_NITRO_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_NITRO_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_NITRO_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void nitro_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_NITRO_BU1:
        clearscores();
        writegadgets();
    acase GID_NITRO_BU2:
        cleartimes();
        writegadgets();
}   }

EXPORT FLAG nitro_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_NITRO
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 40; i++)
    {   either_st(GID_NITRO_ST1  + i,  name[i]);
    }
    for (i = 0; i < 8; i++)
    {   either_in(GID_NITRO_IN1  + i, &score[i]);
    }
    for (i = 0; i < 32; i++)
    {   either_in(GID_NITRO_IN9  + i, &secs[i]);
        either_in(GID_NITRO_IN41 + i, &hundredths[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int   i;
    ULONG temp;

    if (serializemode == SERIALIZE_WRITE)
    {   sortscores();
    }

    offset = 0;

    for (i = 0; i < 8; i++)
    {   serialize4(&score[i]);               // 0..3
        serialize1to1((UBYTE*) &name[i][0]); // 4
        serialize1to1((UBYTE*) &name[i][1]); // 5
        serialize1to1((UBYTE*) &name[i][2]); // 6
        offset++;                            // 7
        name[i][3] = EOS;
    }

    for (i = 0; i < 32; i++)
    {   if (serializemode == SERIALIZE_WRITE)
        {   temp = (secs[i] * 100) + hundredths[i];
        }
        serialize4(&temp);                       // 0..3
        if (serializemode == SERIALIZE_READ)
        {   secs[i]       = temp / 100;
            hundredths[i] = temp % 100;
        }
        serialize1to1((UBYTE*) &name[8 + i][0]); // 4
        serialize1to1((UBYTE*) &name[8 + i][1]); // 5
        serialize1to1((UBYTE*) &name[8 + i][2]); // 6
        offset++;                                // 7
        name[8 + i][3] = EOS;
    }

    for (i = 0; i < 40; i++)
    {   if (name[i][2] == ' ')
        {   name[i][2] = EOS;
            if (name[i][1] == ' ')
            {   name[i][1] = EOS;
                if (name[i][0] == ' ')
                {   name[i][0] = EOS;
}   }   }   }   }

EXPORT void nitro_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?high#?", "Nitro", saveas, 320, FLAG_H, FALSE);

    writegadgets(); // important for name gadgets!
}

EXPORT void nitro_close(void) { ; }
EXPORT void nitro_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[3 + 1];
    ULONG tempnum;

    for (i = 0; i < 40; i++)
    {   for (j = 0; j < 3; j++)
        {   if (name[i][j] == EOS)
            {   name[i][j] = ' ';
            } else
            {   name[i][j] = toupper(name[i][j]);
    }   }   }

    for (i = 0; i < 8 - 1; i++)
    {   for (j = 0; j < 8 - i - 1; j++)
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
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 8; i++)
    {   name[i][0] =
        name[i][1] =
        name[i][2] = ' ';
        name[i][3] = EOS;
        score[i]   = 0;
}   }

MODULE void cleartimes(void)
{   int i;

    for (i = 0; i < 32; i++)
    {   name[8 + i][0] =
        name[8 + i][1] =
        name[8 + i][2] = ' ';
        name[8 + i][3] = EOS;
        secs[i]        =
        hundredths[i]  = 99;
}   }
