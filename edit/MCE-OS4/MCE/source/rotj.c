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

#define GID_ROTJ_LY1   0 // root layout
#define GID_ROTJ_SB1   1 // toolbar
#define GID_ROTJ_ST1   2 // 1st  name
#define GID_ROTJ_ST2   3
#define GID_ROTJ_ST3   4
#define GID_ROTJ_ST4   5
#define GID_ROTJ_ST5   6
#define GID_ROTJ_ST6   7
#define GID_ROTJ_ST7   8
#define GID_ROTJ_ST8   9
#define GID_ROTJ_ST9  10
#define GID_ROTJ_ST10 11 // 10th name
#define GID_ROTJ_IN1  12 // 1st  score
#define GID_ROTJ_IN2  13
#define GID_ROTJ_IN3  14
#define GID_ROTJ_IN4  15
#define GID_ROTJ_IN5  16
#define GID_ROTJ_IN6  17
#define GID_ROTJ_IN7  18
#define GID_ROTJ_IN8  19
#define GID_ROTJ_IN9  20
#define GID_ROTJ_IN10 21 // 10th score
#define GID_ROTJ_BU1  22
#define GIDS_ROTJ     GID_ROTJ_BU1

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
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct HintInfo*     HintInfoPtr;
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

/* 6. MODULE VARIABLES ---------------------------------------------------

(none)

7. MODULE STRUCTURES -------------------------------------------------- */

MODULE struct
{   ULONG amount;
    TEXT  name[15 + 1];
} score[10];

// 8. CODE ---------------------------------------------------------------

EXPORT void rotj_main(void)
{   tool_open  = rotj_open;
    tool_loop  = rotj_loop;
    tool_save  = rotj_save;
    tool_close = rotj_close;
    tool_exit  = rotj_exit;

    if (loaded != FUNC_ROTJ && !rotj_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ROTJ;

    make_speedbar_list(GID_ROTJ_SB1);
    load_fimage(FUNC_ROTJ);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_ROTJ_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_ROTJ_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_ROTJ),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "High Score Table",
                AddHLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    AddVLayout,
                        AddLabel("#1:"),
                        AddLabel("#2:"),
                        AddLabel("#3:"),
                        AddLabel("#4:"),
                        AddLabel("#5:"),
                        AddLabel("#6:"),
                        AddLabel("#7:"),
                        AddLabel("#8:"),
                        AddLabel("#9:"),
                        AddLabel("#10:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[0].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[1].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[2].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[3].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[4].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[5].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST7] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST7,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[6].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST8] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST8,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[7].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST9] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST9,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[8].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_ST10] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROTJ_ST10,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               score[9].name,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN9,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ROTJ_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ROTJ_IN10,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
                ClearButton(GID_ROTJ_BU1, "Clear High Scores"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ROTJ_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_ROTJ_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ROTJ_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void rotj_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_ROTJ_BU1:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG rotj_open(FLAG loadas)
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
    (   page != FUNC_ROTJ
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   either_st(GID_ROTJ_ST1 + i,  score[i].name);
        either_in(GID_ROTJ_IN1 + i, &score[i].amount);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j,
        length;

    offset = 0;

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < 10; i++)
        {   score[i].amount  = (((IOBuffer[offset    ] & 0xF0) >> 4) *     100000)
                             + ( (IOBuffer[offset    ] & 0x0F)       *      10000)
                             + (((IOBuffer[offset + 1] & 0xF0) >> 4) *       1000)
                             + ( (IOBuffer[offset + 1] & 0x0F)       *        100)
                             + (((IOBuffer[offset + 2] & 0xF0) >> 4) *         10)
                             +   (IOBuffer[offset + 2] & 0x0F);
            offset += 3;
        }

        // assert(offset == 0x1E);

        for (i = 0; i < 10; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   offset += 9;

                for (j = 0; j < 16; j++)
                {   score[i].name[j] = IOBuffer[offset++];
                }

                offset++;
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        sortscores();

        for (i = 0; i < 10; i++)
        {   IOBuffer[offset++] = (( score[i].amount               /     100000) << 4)
                               |  ((score[i].amount %     100000) /      10000);
            IOBuffer[offset++] = (((score[i].amount %      10000) /       1000) << 4)
                               |  ((score[i].amount %       1000) /        100);
            IOBuffer[offset++] = (((score[i].amount %        100) /         10) << 4)
                               |   (score[i].amount %         10)             ;
        }

        // assert(offset == 0x1E);

        for (i = 0; i < 10; i++)
        {   IOBuffer[offset    ] = '0' + ((score[i].amount % 1000000) / 100000);
            IOBuffer[offset + 1] = '0' + ((score[i].amount %  100000) /  10000);
            IOBuffer[offset + 2] = '0' + ((score[i].amount %   10000) /   1000);
            IOBuffer[offset + 3] = '0' + ((score[i].amount %    1000) /    100);
            IOBuffer[offset + 4] = '0' + ((score[i].amount %     100) /     10);
            IOBuffer[offset + 5] = '0' + ((score[i].amount %      10) /      1);

            for (j = 0; j < 5; j++)
            {   if (IOBuffer[offset + j] == '0')
                {   IOBuffer[offset + j] = ' ';
                } else
                {   break;
            }   }

            IOBuffer[offset + 6] = ' ';
            IOBuffer[offset + 7] = '-';
            IOBuffer[offset + 8] = ' ';

            offset += 9;

            // pad with spaces
            length = strlen(score[i].name);
            if (length < 15)
            {   for (j = length; j < 15; j++)
                {   score[i].name[j] = ' ';
            }   }
            score[i].name[15] = EOS;
            strcpy((char*) &IOBuffer[offset], score[i].name);

            offset += 16;

            IOBuffer[offset++] = EOS;
    }   }

    // remove spaces
    for (i = 0; i < 10; i++)
    {   for (j = 14; j >= 0; j--)
        {   if (score[i].name[j] == ' ')
            {   score[i].name[j] = EOS;
            } else
            {   break;
}   }   }   }

EXPORT void rotj_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?hiscores#?", "Return of the Jedi", saveas, 290, FLAG_H, FALSE);
}

EXPORT void rotj_close(void) { ; }
EXPORT void rotj_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[15 + 1];
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

                strcpy(tempstr,           score[j    ].name);
                strcpy(score[j    ].name, score[j + 1].name);
                strcpy(score[j + 1].name, tempstr);
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   score[i].amount  = 0;
        score[i].name[0] = EOS;
}   }
