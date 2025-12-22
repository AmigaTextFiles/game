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

#define GID_GMS_LY1   0 // root layout
#define GID_GMS_SB1   1 // toolbar
#define GID_GMS_ST1   2 // 1st name
#define GID_GMS_ST2   3
#define GID_GMS_ST3   4
#define GID_GMS_ST4   5
#define GID_GMS_ST5   6
#define GID_GMS_ST6   7
#define GID_GMS_ST7   8
#define GID_GMS_ST8   9 // 8th name
#define GID_GMS_IN1  10 // 1st score
#define GID_GMS_IN2  11
#define GID_GMS_IN3  12
#define GID_GMS_IN4  13
#define GID_GMS_IN5  14
#define GID_GMS_IN6  15
#define GID_GMS_IN7  16
#define GID_GMS_IN8  17 // 8th score
#define GID_GMS_BU1  18
#define GIDS_GMS     GID_GMS_BU1

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

/* 6. MODULE VARIABLES ---------------------------------------------------

(none)

7. MODULE STRUCTURES -------------------------------------------------- */

MODULE struct
{   ULONG amount;
    TEXT  name[21 + 1];
} score[8];

// 8. CODE ---------------------------------------------------------------

EXPORT void gms_main(void)
{   tool_open  = gms_open;
    tool_loop  = gms_loop;
    tool_save  = gms_save;
    tool_close = gms_close;
    tool_exit  = gms_exit;

    if (loaded != FUNC_GMS && !gms_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_GMS;

    make_speedbar_list(GID_GMS_SB1);
    load_fimage(FUNC_GMS);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_GMS_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            AddToolbar(GID_GMS_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_GMS),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "High Score Table",
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST1,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[0].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN1,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#1:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST2,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[1].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN2,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#2:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST3] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST3,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[2].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN3,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#3:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST4] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST4,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[3].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN4,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#4:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST5] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST5,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[4].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN5] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN5,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#5:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST6] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST6,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[5].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN6] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN6,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#6:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST7] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST7,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[6].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN7] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN7,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#7:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_ST8] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_GMS_ST8,
                        GA_TabCycle,                   TRUE,
                        STRINGA_TextVal,               score[7].name,
                        STRINGA_MaxChars,              21 + 1,
                        STRINGA_MinVisible,            21 + stringextra,
                    StringEnd,
                    LAYOUT_AddChild,                   gadgets[GID_GMS_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_GMS_IN8,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99999999,
                        INTEGER_MinVisible,            8 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("#8:"),
                ClearButton(GID_GMS_BU1, "Clear High Scores"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_GMS_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_GMS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_GMS_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void gms_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_GMS_BU1:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG gms_open(FLAG loadas)
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
    (   page != FUNC_GMS
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 8; i++)
    {   either_st(GID_GMS_ST1 + i,  score[i].name);
        either_in(GID_GMS_IN1 + i, &score[i].amount);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int  i, j;
    FLAG clearing;

    offset = 0x1600;

    if (serializemode == SERIALIZE_WRITE)
    {   sortscores();

        // add spaces
        for (i = 0; i < 8; i++)
        {   clearing = FALSE;
            for (j = 0; j <= 20; j++)
            {   if (!clearing && score[i].name[j] == EOS)
                {   clearing = TRUE;
                }
                if (clearing)
                {   score[i].name[j] = ' ';
            }   }
            score[i].name[21] = EOS;
    }   }

    for (i = 0; i < 8; i++)
    {   if (serializemode == SERIALIZE_READ)
        {   zstrncpy(score[i].name, (char*) &IOBuffer[offset], 21); //  $0..$14
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            zstrncpy((char*) &IOBuffer[offset], score[i].name, 21); //  $0..$14
        }
        offset += 22;                                               //  $0..$15
        serialize4(&score[i].amount);                               // $16..$19
    }

    // remove spaces
    for (i = 0; i < 8; i++)
    {   for (j = 20; j >= 0; j--)
        {   if (score[i].name[j] == ' ')
            {   score[i].name[j] = EOS;
            } else
            {   break;
}   }   }   }

EXPORT void gms_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?Disk.1#?", "Grand Monster Slam", saveas, 901120, FLAG_H, FALSE);
}

EXPORT void gms_close(void) { ; }
EXPORT void gms_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[21 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 8 - 1; i++)
    {   for (j = 0; j < 8 - i - 1; j++)
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

    for (i = 0; i < 8; i++)
    {   score[i].name[0] = EOS;
        score[i].amount  = 0;
}   }
