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

#define GID_PIN_LY1    0 // root layout
#define GID_PIN_SB1    1 // toolbar
#define GID_PIN_ST1    2 // 1st table, 1st name
#define GID_PIN_ST2    3
#define GID_PIN_ST3    4
#define GID_PIN_ST4    5
#define GID_PIN_ST5    6
#define GID_PIN_ST6    7 // 2nd table, 1st name
#define GID_PIN_ST7    8
#define GID_PIN_ST8    9
#define GID_PIN_ST9   10
#define GID_PIN_ST10  11
#define GID_PIN_ST11  12 // 3rd table, 1st name
#define GID_PIN_ST12  13
#define GID_PIN_ST13  14
#define GID_PIN_ST14  15
#define GID_PIN_ST15  16
#define GID_PIN_ST16  17 // 4nd table, 1st name
#define GID_PIN_ST17  18
#define GID_PIN_ST18  19
#define GID_PIN_ST19  20
#define GID_PIN_ST20  21 // 1st table, 1st score
#define GID_PIN_ST21  22
#define GID_PIN_ST22  23
#define GID_PIN_ST23  24
#define GID_PIN_ST24  25
#define GID_PIN_ST25  26 // 2nd table, 1st score
#define GID_PIN_ST26  27
#define GID_PIN_ST27  28
#define GID_PIN_ST28  29
#define GID_PIN_ST29  30
#define GID_PIN_ST30  31 // 3rd table, 1st score
#define GID_PIN_ST31  32
#define GID_PIN_ST32  33
#define GID_PIN_ST33  34
#define GID_PIN_ST34  35
#define GID_PIN_ST35  36 // 4th table, 1st score
#define GID_PIN_ST36  37
#define GID_PIN_ST37  38
#define GID_PIN_ST38  39
#define GID_PIN_CH1   40 // game
#define GID_PIN_CH2   41 // 1st table name
#define GID_PIN_CH3   42 // 2nd table name
#define GID_PIN_CH4   43 // 3rd table name
#define GID_PIN_CH5   44 // 4th table name
#define GID_PIN_BU1   45 // clear high scores
#define GIDS_PIN      GID_PIN_BU1

#define PB1            0 // Pinball Dreams
#define PB2            1 // Pinball Fantasies
#define PB3            2 // Pinball Illusions

#define AddName(x, y)  LAYOUT_AddChild, gadgets[GID_PIN_ST1  + (x * 5) + y] = (struct Gadget*) \
StringObject,                                                  \
    GA_ID,                         GID_PIN_ST1 + (x * 5) + y,  \
    GA_TabCycle,                   TRUE,                       \
    STRINGA_TextVal,               name[x][y],                 \
    STRINGA_MaxChars,              3 + 1,                      \
    STRINGA_MinVisible,            3 + stringextra,            \
StringEnd
#define AddScore(x, y) LAYOUT_AddChild, gadgets[GID_PIN_ST20 + (x * 5) + y] = (struct Gadget*) \
StringObject,                                                  \
    GA_ID,                         GID_PIN_ST20 + (x * 5) + y, \
    GA_TabCycle,                   TRUE,                       \
    STRINGA_TextVal,               score[x][y],                \
    STRINGA_MaxChars,              11 + 1,                     \
    STRINGA_MinVisible,            11 + stringextra,           \
    STRINGA_Justification,         GACT_STRINGRIGHT,           \
StringEnd // enough for 99 billion

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void addzeroes(void);
MODULE void remzeroes(void);

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
IMPORT struct EasyStruct    EasyStruct;
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

MODULE TEXT  name[4][5][3 + 1],
             score[4][5][11 + 1];
MODULE ULONG game,
             level;
MODULE const STRPTR GameOptions[3 + 1] =
{ "Pinball Dreams",
  "Pinball Fantasies AGA",
  "Pinball Illusions AGA",
  NULL
}, Level1Options[3 + 1] =
{ "Ignition",
  "Partyland",
  "Law 'n' Justice",
  NULL
}, Level2Options[3 + 1] =
{ "Steel Wheel",
  "Speed Devils",
  "Babewatch",
  NULL
}, Level3Options[3 + 1] =
{ "Beat Box",
  "Billion Dollar Gameshow",
  "Extreme Sports",
  NULL
}, Level4Options[3 + 1] =
{ "Nightmare",
  "Stones 'n' Bones",
  "-",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void pin_main(void)
{   tool_open  = pin_open;
    tool_loop  = pin_loop;
    tool_save  = pin_save;
    tool_close = pin_close;
    tool_exit  = pin_exit;

    if (loaded != FUNC_PINBALL && !pin_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_PINBALL;

    make_speedbar_list(GID_PIN_SB1);
    load_fimage(FUNC_PINBALL);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_PIN_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            AddHLayout,
                AddToolbar(GID_PIN_SB1),
                AddSpace,
                CHILD_WeightedWidth,                   50,
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_PIN_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PIN_CH1,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,              0,
                LayoutEnd,
                CHILD_WeightedWidth,                   0,
                AddSpace,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_PINBALL),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                LAYOUT_EvenSize,                       TRUE,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_AddChild,                   gadgets[GID_PIN_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PIN_CH2,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &Level1Options,
                    ChooserEnd,
                    AddHLayout,
                        AddName( 0, 0),
                        AddScore(0, 0),
                    LayoutEnd,
                    Label("#1:"),
                    AddHLayout,
                        AddName( 0, 1),
                        AddScore(0, 1),
                    LayoutEnd,
                    Label("#2:"),
                    AddHLayout,
                        AddName( 0, 2),
                        AddScore(0, 2),
                    LayoutEnd,
                    Label("#3:"),
                    AddHLayout,
                        AddName( 0, 3),
                        AddScore(0, 3),
                    LayoutEnd,
                    Label("#4:"),
                    AddHLayout,
                        AddName( 0, 4),
                        AddScore(0, 4),
                    LayoutEnd,
                    Label("#5:"),
                LayoutEnd,
                CHILD_WeightedWidth,                   50,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_AddChild,                   gadgets[GID_PIN_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PIN_CH3,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &Level2Options,
                    ChooserEnd,
                    AddHLayout,
                        AddName( 1, 0),
                        AddScore(1, 0),
                    LayoutEnd,
                    Label("#1:"),
                    AddHLayout,
                        AddName( 1, 1),
                        AddScore(1, 1),
                    LayoutEnd,
                    Label("#2:"),
                    AddHLayout,
                        AddName( 1, 2),
                        AddScore(1, 2),
                    LayoutEnd,
                    Label("#3:"),
                    AddHLayout,
                        AddName( 1, 3),
                        AddScore(1, 3),
                    LayoutEnd,
                    Label("#4:"),
                    AddHLayout,
                        AddName( 1, 4),
                        AddScore(1, 4),
                    LayoutEnd,
                    Label("#5:"),
                LayoutEnd,
                CHILD_MinWidth,                        240,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            AddHLayout,
                LAYOUT_EvenSize,                       TRUE,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_AddChild,                   gadgets[GID_PIN_CH4] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PIN_CH4,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &Level3Options,
                    ChooserEnd,
                    AddHLayout,
                        AddName( 2, 0),
                        AddScore(2, 0),
                    LayoutEnd,
                    Label("#1:"),
                    AddHLayout,
                        AddName( 2, 1),
                        AddScore(2, 1),
                    LayoutEnd,
                    Label("#2:"),
                    AddHLayout,
                        AddName( 2, 2),
                        AddScore(2, 2),
                    LayoutEnd,
                    Label("#3:"),
                    AddHLayout,
                        AddName( 2, 3),
                        AddScore(2, 3),
                    LayoutEnd,
                    Label("#4:"),
                    AddHLayout,
                        AddName( 2, 4),
                        AddScore(2, 4),
                    LayoutEnd,
                    Label("#5:"),
                LayoutEnd,
                CHILD_WeightedWidth,                   50,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_AddChild,                   gadgets[GID_PIN_CH5] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PIN_CH5,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &Level4Options,
                    ChooserEnd,
                    AddHLayout,
                        AddName( 3, 0),
                        AddScore(3, 0),
                    LayoutEnd,
                    Label("#1:"),
                    AddHLayout,
                        AddName( 3, 1),
                        AddScore(3, 1),
                    LayoutEnd,
                    Label("#2:"),
                    AddHLayout,
                        AddName( 3, 2),
                        AddScore(3, 2),
                    LayoutEnd,
                    Label("#3:"),
                    AddHLayout,
                        AddName( 3, 3),
                        AddScore(3, 3),
                    LayoutEnd,
                    Label("#4:"),
                    AddSpace, // there really is no #5!
                LayoutEnd,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            ClearButton(GID_PIN_BU1, "Clear High Scores"),
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_PIN_SB1);
    writegadgets();
    if (game == PB3)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_PIN_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_PIN_ST1 + (level * 5)]);
    } else
    {   DISCARD ActivateLayoutGadget(gadgets[GID_PIN_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_PIN_ST1]);
    }
    loop();
    readgadgets();
    closewindow();
}

EXPORT void pin_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_PIN_BU1:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG pin_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if   (gamesize == 208) game = PB1;
        elif (gamesize == 260) game = PB2;
        elif (gamesize ==  50) game = PB3;
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
{   if
    (   page != FUNC_PINBALL
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i, j;

    if (gadmode == SERIALIZE_WRITE)
    {   either_ch(GID_PIN_CH1, &game);
        either_ch(GID_PIN_CH2, &game);
        either_ch(GID_PIN_CH3, &game);
        either_ch(GID_PIN_CH4, &game);
        either_ch(GID_PIN_CH5, &game);

        if (game == PB3)
        {   for (i = 0; i < 3; i++)
            {   for (j = 0; j < 5; j++)
                {   ghost(GID_PIN_ST1  + (i * 5) + j, (int) level != i); // name
                    ghost(GID_PIN_ST20 + (i * 5) + j, (int) level != i); // score
            }   }

            ghost(GID_PIN_ST16, TRUE ); // 4th table, 1st name
            ghost(GID_PIN_ST17, TRUE ); // 4th table, 2nd name
            ghost(GID_PIN_ST18, TRUE ); // 4th table, 3rd name
            ghost(GID_PIN_ST19, TRUE ); // 4th table, 4th name
            ghost(GID_PIN_ST35, TRUE ); // 4th table, 1st score
            ghost(GID_PIN_ST36, TRUE ); // 4th table, 2nd score
            ghost(GID_PIN_ST37, TRUE ); // 4th table, 3rd score
            ghost(GID_PIN_ST38, TRUE ); // 4th table, 4th score
        } else
        {   ghost(GID_PIN_ST5 , TRUE ); // 1st table, 5th name
            ghost(GID_PIN_ST24, TRUE ); // 1st table, 5th score
            ghost(GID_PIN_ST10, TRUE ); // 2nd table, 5th name
            ghost(GID_PIN_ST29, TRUE ); // 2nd table, 5th score
            ghost(GID_PIN_ST15, TRUE ); // 3rd table, 5th name
            ghost(GID_PIN_ST34, TRUE ); // 3rd table, 5th score

            ghost(GID_PIN_ST16, FALSE); // 4th table, 1st name
            ghost(GID_PIN_ST17, FALSE); // 4th table, 2nd name
            ghost(GID_PIN_ST18, FALSE); // 4th table, 3rd name
            ghost(GID_PIN_ST19, FALSE); // 4th table, 4th name
            ghost(GID_PIN_ST35, FALSE); // 4th table, 1st score
            ghost(GID_PIN_ST36, FALSE); // 4th table, 2nd score
            ghost(GID_PIN_ST37, FALSE); // 4th table, 3rd score
            ghost(GID_PIN_ST38, FALSE); // 4th table, 4th score
    }   }

    for (i = 0; i < 4; i++)
    {   for (j = 0; j < 5; j++)
        {   if (i == 3 && j == 4)
            {   break;
            }
            either_st(GID_PIN_ST1  + (i * 5) + j, name[ i][j]);
            either_st(GID_PIN_ST20 + (i * 5) + j, score[i][j]);
}   }   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int   i, j, k;
    UBYTE t;

    if (serializemode == SERIALIZE_WRITE)
    {   addzeroes();
        sortscores();
    }

    switch (game)
    {
    case PB1:
    case PB2:
        if (game == PB1)
        {   offset = 10;
        } else
        {   // assert(game == PB2);
            offset = 0;
        }
        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 4; i++)
            {   for (j = 0; j < 4; j++)
                {   for (k = 0; k < 3; k++)
                    {   name[i][j][k] = IOBuffer[offset++];
                    }
                    name[i][j][3] = EOS;
                    score[i][j][ 0] = '0';
                    offset += 4;
                    score[i][j][ 1] = '0' + ((IOBuffer[offset] & 0xF0) >> 4);
                    score[i][j][ 2] = '0' + ((IOBuffer[offset] & 0x0F)     );
                    offset++;
                    score[i][j][ 3] = '0' + ((IOBuffer[offset] & 0xF0) >> 4);
                    score[i][j][ 4] = '0' + ((IOBuffer[offset] & 0x0F)     );
                    offset++;
                    score[i][j][ 5] = '0' + ((IOBuffer[offset] & 0xF0) >> 4);
                    score[i][j][ 6] = '0' + ((IOBuffer[offset] & 0x0F)     );
                    offset++;
                    score[i][j][ 7] = '0' + ((IOBuffer[offset] & 0xF0) >> 4);
                    score[i][j][ 8] = '0' + ((IOBuffer[offset] & 0x0F)     );
                    offset++;
                    score[i][j][ 9] = '0' + ((IOBuffer[offset] & 0xF0) >> 4);
                    score[i][j][10] = '0' + ((IOBuffer[offset] & 0x0F)     );
                    offset++;
                    score[i][j][11] = EOS;
                }
                name[i][4][0] = EOS;
                strcpy(score[i][4], "00000000000");
                if (game == PB2 && i == 1)
                {   offset += 32;
        }   }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);
            for (i = 0; i < 4; i++)
            {   for (j = 0; j < 4; j++)
                {   for (k = 0; k < 3; k++)
                    {   IOBuffer[offset++] = name[i][j][k];
                    }
                    offset += 4;
                    t = ((score[i][j][ 1] - '0') << 4)
                      |  (score[i][j][ 2] - '0')     ;
                    IOBuffer[offset++] = t;
                    t = ((score[i][j][ 3] - '0') << 4)
                      |  (score[i][j][ 4] - '0')     ;
                    IOBuffer[offset++] = t;
                    t = ((score[i][j][ 5] - '0') << 4)
                      |  (score[i][j][ 6] - '0')     ;
                    IOBuffer[offset++] = t;
                    t = ((score[i][j][ 7] - '0') << 4)
                      |  (score[i][j][ 8] - '0')     ;
                    IOBuffer[offset++] = t;
                    t = ((score[i][j][ 9] - '0') << 4)
                      |  (score[i][j][10] - '0')     ;
                    IOBuffer[offset++] = t;
                    score[i][j][11] = EOS;
                }
                if (game == PB2 && i == 1)
                {   offset += 32;
        }   }   }
    acase PB3:
        offset = 0;
        if (serializemode == SERIALIZE_READ)
        {   if     (!stricmp((char*) FilePart(pathname), "Table001"))
            {   level = 0;
            } elif (!stricmp((char*) FilePart(pathname), "Table002"))
            {   level = 1;
            } elif (!stricmp((char*) FilePart(pathname), "Table003"))
            {   level = 2;
            } else
            {   EasyStruct.es_TextFormat   = (STRPTR) "Which table are these high scores for?";
                EasyStruct.es_Title        = (STRPTR) "MCE: Question";
                EasyStruct.es_GadgetFormat = (STRPTR) "Law 'n' Justice|Babewatch|Extreme Sports";
                                                    // 1              |2        |0
                level = EasyRequest(MainWindowPtr, &EasyStruct, NULL); // MainWindowPtr might be NULL but that isn't problematic
                if (level == 0)
                {   level = 2;
                } else
                {   level--;
            }   }

            for (i = 0; i < 4; i++)
            {   if (i == (int) level)
                {   continue;
                }
                for (j = 0; j < 5; j++)
                {   name[i][j][0] = EOS;
                    strcpy(score[i][j], "00000000000");
            }   }

            i = level;
            for (j = 0; j < 5; j++)
            {   for (k = 0; k < 3; k++)                                   // 0..2
                {   name[i][j][k] = IOBuffer[offset++];
                }
                name[i][j][3]  = EOS;
                if (level != 1)
                {   offset++;
                }
                score[i][j][ 0] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 3
                offset++;
                score[i][j][ 1] = '0' + ((IOBuffer[offset] & 0xF0) >> 4); // 4
                score[i][j][ 2] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 4
                offset++;
                score[i][j][ 3] = '0' + ((IOBuffer[offset] & 0xF0) >> 4); // 5
                score[i][j][ 4] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 5
                offset++;
                score[i][j][ 5] = '0' + ((IOBuffer[offset] & 0xF0) >> 4); // 6
                score[i][j][ 6] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 6
                offset++;
                score[i][j][ 7] = '0' + ((IOBuffer[offset] & 0xF0) >> 4); // 7
                score[i][j][ 8] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 7
                offset++;
                score[i][j][ 9] = '0' + ((IOBuffer[offset] & 0xF0) >> 4); // 8
                score[i][j][10] = '0' + ((IOBuffer[offset] & 0x0F)     ); // 8
                offset++;
                score[i][j][11] = EOS;
                if (level == 1 && offset == 36)
                {   offset += 4;
        }   }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);
            i = level;
            for (j = 0; j < 5; j++)
            {   for (k = 0; k < 3; k++)
                {   IOBuffer[offset++] = name[i][j][k];
                }
                if (level != 1)
                {   offset++;
                }
                t =  (score[i][j][ 0] - '0')     ;
                IOBuffer[offset++] = t;
                t = ((score[i][j][ 1] - '0') << 4)
                  |  (score[i][j][ 2] - '0')     ;
                IOBuffer[offset++] = t;
                t = ((score[i][j][ 3] - '0') << 4)
                  |  (score[i][j][ 4] - '0')     ;
                IOBuffer[offset++] = t;
                t = ((score[i][j][ 5] - '0') << 4)
                  |  (score[i][j][ 6] - '0')     ;
                IOBuffer[offset++] = t;
                t = ((score[i][j][ 7] - '0') << 4)
                  |  (score[i][j][ 8] - '0')     ;
                IOBuffer[offset++] = t;
                t = ((score[i][j][ 9] - '0') << 4)
                  |  (score[i][j][10] - '0')     ;
                IOBuffer[offset++] = t;
                if (level == 1 && offset == 36)
                {   offset += 4;
    }   }   }   }

    name[        3][4][0] = EOS;
    strcpy(score[3][4], "00000000000");
    remzeroes();
}

EXPORT void pin_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    writegadgets();
    if     (game == PB1)
    {   gamesave(    "#?HIGH#?"     , "Pinball Dreams"       , saveas, 208, FLAG_H, FALSE);
    } elif (game == PB2)
    {   gamesave(    "#?Highscore#?", "Pinball Fantasies AGA", saveas, 260, FLAG_H, FALSE);
    } else
    {   // assert(game == PB3);
        if     (level == 0)
        {   gamesave("#?Table001#?" , "Pinball Illusions AGA", saveas,  50, FLAG_H, FALSE);
        } elif (level == 1)
        {   gamesave("#?Table002#?" , "Pinball Illusions AGA", saveas,  50, FLAG_H, FALSE);
        } else
        {   // assert(level == 2);
            gamesave("#?Table003#?" , "Pinball Illusions AGA", saveas,  50, FLAG_H, FALSE);
}   }   }

EXPORT void pin_close(void) { ; }
EXPORT void pin_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j, k, l;
    TEXT  tempstr[11 + 1];
    FLAG  swap;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 4; i++) // level
    {   for (j = 0; j < 5 - 1; j++) // how many times
        {   for (k = 0; k < 5 - j - 1; k++) // rank
            {   swap = FALSE;
                for (l = 0; l < 11; l++) // digit
                {   if
                    (   score[i][k    ][l]
                      > score[i][k + 1][l]
                    )
                    {   break;
                    } // implied else
                    if
                    (   score[i][k    ][l]
                      < score[i][k + 1][l]
                    )
                    {   swap = TRUE;
                        break;
                }   }

                if (swap)
                {   strcpy(tempstr        , score[i][k    ]);
                    strcpy(score[i][k    ], score[i][k + 1]);
                    strcpy(score[i][k + 1], tempstr);

                    strcpy(tempstr        , name[ i][k    ]);
                    strcpy(name[ i][k    ], name[ i][k + 1]);
                    strcpy(name[ i][k + 1], tempstr);
    }   }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i, j;

    for (i = 0; i < 4; i++)
    {   for (j = 0; j < 5; j++)
        {   score[i][j][0] = '0';
            score[i][j][1] =
            name[ i][j][0] = EOS;
}   }   }

MODULE void addzeroes(void)
{   int  i, j, k,
         length;
    TEXT tempscore[11 + 1];

    for (i = 0; i < 4; i++)
    {   for (j = 0; j < 5; j++)
        {   length = strlen(name[i][j]);
            for (k = 0; k < length; k++)
            {   if (name[i][j][k] >= 'a' && name[i][j][k] <= 'z')
                {   name[i][j][k] -= 'a';
                    name[i][j][k] += 'A';
            }   }
            if (length < 3)
            {   name[i][j][2] = ' ';
                name[i][j][3] = EOS;
                if (length < 2)
                {   name[i][j][1] = ' ';
                    if (length < 1)
                    {   name[i][j][0] = ' ';
            }   }   }

            length = strlen(score[i][j]);
            for (k = 0; k < length; k++)
            {   if (score[i][j][k] < '0' || score[i][j][k] > '9')
                {   score[i][j][k] = '0';
            }   }
            if (length < 11)
            {   for (k = 0; k < 11 - length; k++)
                {   tempscore[k] = '0';
                }
                strcpy(&tempscore[11 - length], score[i][j]);
                strcpy(score[i][j], tempscore);
            }
            if (game != PB3 && score[i][j][0] != '0') // >= 10 billion
            {   strcpy(score[i][j], "9999999999"); // almost 10 billion
}   }   }   }

MODULE void remzeroes(void)
{   int  found,
         i, j, k;
    TEXT tempscore[11 + 1];

    for (i = 0; i < 4; i++)
    {   for (j = 0; j < 5; j++)
        {   // assert(strlen(score[i][j]) == 11);
            found = -1;
            for (k = 0; k < 11; k++)
            {   if (score[i][j][k] != '0')
                {   found = k;
                    break;
            }   }
            if (found == -1)
            {   score[i][j][0] = '0';
                score[i][j][1] = EOS;
            } else
            {   strcpy(tempscore, &score[i][j][found]);
                strcpy(score[i][j], tempscore);
}   }   }   }
