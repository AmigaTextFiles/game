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

#define GID_GS_LY1    0 // root layout
#define GID_GS_SB1    1 // toolbar
#define GID_GS_ST1    2 //  1st name
#define GID_GS_ST30  31 // 30th name
#define GID_GS_IN1   32 //  1st score
#define GID_GS_IN30  61 // 30th score
#define GID_GS_BU1   62 // clear high scores
#define GIDS_GS     GID_GS_BU1

#define NameGad(x)  LAYOUT_AddChild, gadgets[GID_GS_ST1  + x] = (struct Gadget*) StringObject,  GA_ID, GID_GS_ST1 + x, GA_TabCycle, TRUE, STRINGA_TextVal, name[x], STRINGA_MaxChars, 3 + 1, STRINGA_MinVisible, 3 + stringextra, STRINGA_ReplaceMode, TRUE, StringEnd
#define ScoreGad(x) LAYOUT_AddChild, gadgets[GID_GS_IN1  + x] = (struct Gadget*) IntegerObject, GA_ID, GID_GS_IN1 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 999, INTEGER_MinVisible, 3 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
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

MODULE TEXT                 name[30][3 + 1];
MODULE ULONG                score[30];

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void gs_main(void)
{   tool_open  = gs_open;
    tool_loop  = gs_loop;
    tool_save  = gs_save;
    tool_close = gs_close;
    tool_exit  = gs_exit;

    if (loaded != FUNC_GRIDSTART && !gs_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_GRIDSTART;

    make_speedbar_list(GID_GS_SB1);
    load_fimage(FUNC_GRIDSTART);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_LockHeight,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_GS_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            AddToolbar(GID_GS_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_GRIDSTART),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "High Score Tables",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Professional",
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
                        AddHLayout,
                            NameGad(8),
                            ScoreGad(8),
                        LayoutEnd,
                        Label("#9:"),
                        AddHLayout,
                            NameGad(9),
                            ScoreGad(9),
                        LayoutEnd,
                        Label("#10:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Amateur",
                        AddHLayout,
                            NameGad(10 + 0),
                            ScoreGad(10 + 0),
                        LayoutEnd,
                        Label("#1:"),
                        AddHLayout,
                            NameGad(10 + 1),
                            ScoreGad(10 + 1),
                        LayoutEnd,
                        Label("#2:"),
                        AddHLayout,
                            NameGad(10 + 2),
                            ScoreGad(10 + 2),
                        LayoutEnd,
                        Label("#3:"),
                        AddHLayout,
                            NameGad(10 + 3),
                            ScoreGad(10 + 3),
                        LayoutEnd,
                        Label("#4:"),
                        AddHLayout,
                            NameGad(10 + 4),
                            ScoreGad(10 + 4),
                        LayoutEnd,
                        Label("#5:"),
                        AddHLayout,
                            NameGad(10 + 5),
                            ScoreGad(10 + 5),
                        LayoutEnd,
                        Label("#6:"),
                        AddHLayout,
                            NameGad(10 + 6),
                            ScoreGad(10 + 6),
                        LayoutEnd,
                        Label("#7:"),
                        AddHLayout,
                            NameGad(10 + 7),
                            ScoreGad(10 + 7),
                        LayoutEnd,
                        Label("#8:"),
                        AddHLayout,
                            NameGad(10 + 8),
                            ScoreGad(10 + 8),
                        LayoutEnd,
                        Label("#9:"),
                        AddHLayout,
                            NameGad(10 + 9),
                            ScoreGad(10 + 9),
                        LayoutEnd,
                        Label("#10:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Novice",
                        AddHLayout,
                            NameGad(20 + 0),
                            ScoreGad(20 + 0),
                        LayoutEnd,
                        Label("#1:"),
                        AddHLayout,
                            NameGad(20 + 1),
                            ScoreGad(20 + 1),
                        LayoutEnd,
                        Label("#2:"),
                        AddHLayout,
                            NameGad(20 + 2),
                            ScoreGad(20 + 2),
                        LayoutEnd,
                        Label("#3:"),
                        AddHLayout,
                            NameGad(20 + 3),
                            ScoreGad(20 + 3),
                        LayoutEnd,
                        Label("#4:"),
                        AddHLayout,
                            NameGad(20 + 4),
                            ScoreGad(20 + 4),
                        LayoutEnd,
                        Label("#5:"),
                        AddHLayout,
                            NameGad(20 + 5),
                            ScoreGad(20 + 5),
                        LayoutEnd,
                        Label("#6:"),
                        AddHLayout,
                            NameGad(20 + 6),
                            ScoreGad(20 + 6),
                        LayoutEnd,
                        Label("#7:"),
                        AddHLayout,
                            NameGad(20 + 7),
                            ScoreGad(20 + 7),
                        LayoutEnd,
                        Label("#8:"),
                        AddHLayout,
                            NameGad(20 + 8),
                            ScoreGad(20 + 8),
                        LayoutEnd,
                        Label("#9:"),
                        AddHLayout,
                            NameGad(20 + 9),
                            ScoreGad(20 + 9),
                        LayoutEnd,
                        Label("#10:"),
                    LayoutEnd,
                LayoutEnd,
                ClearButton(GID_GS_BU1, "Clear High Scores"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_GS_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_GS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_GS_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void gs_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_GS_BU1:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG gs_open(FLAG loadas)
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
    (   page != FUNC_GRIDSTART
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 30; i++)
    {   either_st(GID_GS_ST1 + i,  name[i]);
        either_in(GID_GS_IN1 + i, &score[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j;

    if (serializemode == SERIALIZE_WRITE)
    {   sortscores();
    }

    offset = 2;

    for (i = 0; i < 3; i++)
    {   for (j = 0; j < 10; j++)
        {   serialize1to1((UBYTE*) &name[(i * 10) + j][0]); // 0
            serialize1to1((UBYTE*) &name[(i * 10) + j][1]); // 1
            serialize1to1((UBYTE*) &name[(i * 10) + j][2]); // 2
            name[(i * 10) + j][3] = EOS;
            offset++;                                       // 3
            serialize2ulong(&score[(i * 10) + j]);          // 4..5
        }
        offset += 6;
}   }

EXPORT void gs_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?topScores#?", "GridStart 1-3", saveas, 206, FLAG_H, FALSE);
}

EXPORT void gs_close(void) { ; }
EXPORT void gs_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j, k;
    TEXT  tempstr[3 + 1];
    ULONG tempnum;

    for (i = 0; i < 30; i++)
    {   for (j = 0; j < 3; j++)
        {   if (name[i][j] == EOS)
            {   name[i][j] = ' ';
            } else
            {   name[i][j] = toupper(name[i][j]);
    }   }   }

    for (i = 0; i < 3; i++)
    {   for (j = 0; j < 10 - 1; j++)
        {   for (k = 0; k < 10 - j - 1; k++)
            {   if
                (   score[(i * 10) + k    ]
                  < score[(i * 10) + k + 1]
                )
                {   tempnum                 = score[(i * 10) + k    ];
                    score[(i * 10) + k    ] = score[(i * 10) + k + 1];
                    score[(i * 10) + k + 1] = tempnum;

                    strcpy(tempstr,                name[(i * 10) + k    ]);
                    strcpy(name[(i * 10) + k    ], name[(i * 10) + k + 1]);
                    strcpy(name[(i * 10) + k + 1], tempstr);
    }   }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 30; i++)
    {   name[i][0] =
        name[i][1] =
        name[i][2] = ' ';
        name[i][3] = EOS;
        score[i]   = 0;
}   }
