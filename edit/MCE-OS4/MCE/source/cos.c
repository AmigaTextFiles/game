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

// main window
#define GID_COS_LY1    0 // root layout
#define GID_COS_SB1    1 // toolbar
#define GID_COS_ST1    2 // name
#define GID_COS_IN1    3 // hidden 1
#define GID_COS_IN2    4 // str
#define GID_COS_IN3    5 // att
#define GID_COS_IN4    6 // def
#define GID_COS_IN5    7 // con
#define GID_COS_IN6    8 // hidden 2
#define GID_COS_IN7    9 // hidden 3
#define GID_COS_IN8   10 // hidden 4
#define GID_COS_IN9   11 // man
#define GID_COS_IN10  12 // men
#define GID_COS_BU1   13 // maximize character
#define GID_COS_BU2   14 // clear roster
#define GIDS_COS      GID_COS_BU2

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void clear_roster(void);
MODULE void eithergadgets(void);
MODULE UBYTE encrypt(int input);
MODULE int decrypt(UBYTE input);

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
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
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

MODULE ULONG                str[250],
                            att[250],
                            def[250],
                            con[250],
                            hidden1[250],
                            hidden2[250],
                            hidden3[250],
                            hidden4[250],
                            men,
                            who = 0;
MODULE TEXT                 name[250][10 + 1];

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void cos_main(void)
{   tool_open  = cos_open;
    tool_loop  = cos_loop;
    tool_save  = cos_save;
    tool_close = cos_close;
    tool_exit  = cos_exit;

    if (loaded != FUNC_COS && !cos_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_COS;

    make_speedbar_list(GID_COS_SB1);
    load_fimage(FUNC_COS);
    load_aiss_images(9, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_COS_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_COS_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_COS),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddLabel("Character #:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN9] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN9,
                    GA_RelVerify,                          TRUE,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       1,
                    INTEGER_Maximum,                       250,
                    INTEGER_Number,                        who + 1,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                AddLabel("of"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN10] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN10,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       250,
                    INTEGER_Number,                        men,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_AddChild,                           gadgets[GID_COS_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                                 GID_COS_ST1,
                    GA_TabCycle,                           TRUE,
                    STRINGA_TextVal,                       name[who],
                    STRINGA_MaxChars,                      10 + 1,
                    STRINGA_MinVisible,                    10 + stringextra,
                StringEnd,
                Label("Name:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN2] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN2,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Strength:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN3] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN3,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Attack Force:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN4] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN4,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Defence Force:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN5,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Constitution:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN1] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN1,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Hidden #1:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN6,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Hidden #2:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN7] = (struct Gadget*)
                IntegerObject,    
                    GA_ID,                                 GID_COS_IN7,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Hidden #3:"),
                LAYOUT_AddChild,                           gadgets[GID_COS_IN8] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_COS_IN8,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999,
                    INTEGER_MinVisible,                    3 + 1,
                IntegerEnd,
                Label("Hidden #4:"),
                MaximizeButton(GID_COS_BU1, "Maximize Character"),
            LayoutEnd,
            ClearButton(GID_COS_BU2, "Clear Roster"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_COS_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_COS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_COS_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void cos_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_COS_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_COS_BU2:
        // readgadgets() not needed since we clear everything anyway
        clear_roster();
        writegadgets();
    acase GID_COS_IN9:
        readgadgets();
        writegadgets();
}   }

/* We support loading of the old (eg. WHDLoad slave V1.1) format (16384
bytes) and the new (eg. WHDLoad slave V1.2) format (16100 bytes). */
EXPORT FLAG cos_open(FLAG loadas)
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
    (   page != FUNC_COS
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    DISCARD SetGadgetAttrs
    (   gadgets[GID_COS_IN9], MainWindowPtr, NULL,
        INTEGER_Number, who + 1,
    TAG_END); // autorefreshes
}

MODULE void eithergadgets(void)
{   either_st(GID_COS_ST1 ,  name[who]);
    either_in(GID_COS_IN2 , &str[who]);
    either_in(GID_COS_IN3 , &att[who]);
    either_in(GID_COS_IN4 , &def[who]);
    either_in(GID_COS_IN5 , &con[who]);
    either_in(GID_COS_IN1 , &hidden1[who]);
    either_in(GID_COS_IN6 , &hidden2[who]);
    either_in(GID_COS_IN7 , &hidden3[who]);
    either_in(GID_COS_IN8 , &hidden4[who]);
    either_in(GID_COS_IN10, &men);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();

    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_COS_IN9], (ULONG*) &who);
    who--;
}

MODULE void serialize(void)
{   int i,
        where,
        whichman;

    offset = 4; // skip "VOL3"
    serialize1(&men);

    if (serializemode == SERIALIZE_READ)
    {   for (whichman = 0; whichman < 250; whichman++)
        {   name[whichman][0] = decrypt(IOBuffer[101 + (whichman * 64)]);
            name[whichman][1] = decrypt(IOBuffer[100 + (whichman * 64)]);
            name[whichman][2] = decrypt(IOBuffer[103 + (whichman * 64)]);
            name[whichman][3] = decrypt(IOBuffer[102 + (whichman * 64)]);
            name[whichman][4] = decrypt(IOBuffer[105 + (whichman * 64)]);
            name[whichman][5] = decrypt(IOBuffer[104 + (whichman * 64)]);
            name[whichman][6] = decrypt(IOBuffer[107 + (whichman * 64)]);
            name[whichman][7] = decrypt(IOBuffer[106 + (whichman * 64)]);
            name[whichman][8] = decrypt(IOBuffer[109 + (whichman * 64)]);
            name[whichman][9] = decrypt(IOBuffer[108 + (whichman * 64)]);
            name[whichman][10] = EOS;

            for (i = 9; i >= 0; i--)
            {   if (name[whichman][i] == ' ')
                {   name[whichman][i] = EOS;
                } else
                {   break;
            }   }

            hidden1[whichman] =  decrypt(IOBuffer[110 + (whichman * 64)])
                              + (decrypt(IOBuffer[111 + (whichman * 64)]) * 256);
            str[whichman]     =  decrypt(IOBuffer[112 + (whichman * 64)])
                              + (decrypt(IOBuffer[113 + (whichman * 64)]) * 256);
            att[whichman]     =  decrypt(IOBuffer[114 + (whichman * 64)])
                              + (decrypt(IOBuffer[115 + (whichman * 64)]) * 256);
            def[whichman]     =  decrypt(IOBuffer[116 + (whichman * 64)])
                              + (decrypt(IOBuffer[117 + (whichman * 64)]) * 256);
            con[whichman]     =  decrypt(IOBuffer[118 + (whichman * 64)])
                              + (decrypt(IOBuffer[119 + (whichman * 64)]) * 256);
            hidden2[whichman] =  decrypt(IOBuffer[120 + (whichman * 64)])
                              + (decrypt(IOBuffer[121 + (whichman * 64)]) * 256);
            hidden3[whichman] =  decrypt(IOBuffer[122 + (whichman * 64)])
                              + (decrypt(IOBuffer[123 + (whichman * 64)]) * 256);
            hidden4[whichman] =  decrypt(IOBuffer[124 + (whichman * 64)])
                              + (decrypt(IOBuffer[125 + (whichman * 64)]) * 256);
    }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        for (whichman = 0; whichman < 250; whichman++)
        {   where = strlen(name[whichman]);
            if (where <= 9)
            {   for (i = where; i <= 9; i++)
                {   name[whichman][i] = ' ';
            }   }
            name[whichman][10] = EOS;

            IOBuffer[100 + (whichman * 64)] = encrypt(name[whichman][1]);
            IOBuffer[101 + (whichman * 64)] = encrypt(name[whichman][0]);
            IOBuffer[102 + (whichman * 64)] = encrypt(name[whichman][3]);
            IOBuffer[103 + (whichman * 64)] = encrypt(name[whichman][2]);
            IOBuffer[104 + (whichman * 64)] = encrypt(name[whichman][5]);
            IOBuffer[105 + (whichman * 64)] = encrypt(name[whichman][4]);
            IOBuffer[106 + (whichman * 64)] = encrypt(name[whichman][7]);
            IOBuffer[107 + (whichman * 64)] = encrypt(name[whichman][6]);
            IOBuffer[108 + (whichman * 64)] = encrypt(name[whichman][9]);
            IOBuffer[109 + (whichman * 64)] = encrypt(name[whichman][8]);

            IOBuffer[110 + (whichman * 64)] = encrypt(hidden1[whichman] % 256);
            IOBuffer[111 + (whichman * 64)] = encrypt(hidden1[whichman] / 256);
            IOBuffer[112 + (whichman * 64)] = encrypt(str[whichman]     % 256);
            IOBuffer[113 + (whichman * 64)] = encrypt(str[whichman]     / 256);
            IOBuffer[114 + (whichman * 64)] = encrypt(att[whichman]     % 256);
            IOBuffer[115 + (whichman * 64)] = encrypt(att[whichman]     / 256);
            IOBuffer[116 + (whichman * 64)] = encrypt(def[whichman]     % 256);
            IOBuffer[117 + (whichman * 64)] = encrypt(def[whichman]     / 256);
            IOBuffer[118 + (whichman * 64)] = encrypt(con[whichman]     % 256);
            IOBuffer[119 + (whichman * 64)] = encrypt(con[whichman]     / 256);
            IOBuffer[120 + (whichman * 64)] = encrypt(hidden2[whichman] % 256);
            IOBuffer[121 + (whichman * 64)] = encrypt(hidden2[whichman] / 256);
            IOBuffer[122 + (whichman * 64)] = encrypt(hidden3[whichman] % 256);
            IOBuffer[123 + (whichman * 64)] = encrypt(hidden3[whichman] / 256);
            IOBuffer[124 + (whichman * 64)] = encrypt(hidden4[whichman] % 256);
            IOBuffer[125 + (whichman * 64)] = encrypt(hidden4[whichman] / 256);
}   }   }

MODULE UBYTE encrypt(int input)
{   return (UBYTE)
    (   ((input & 128) >> 7) // bit 7 goes in bit 0
      + ((input &  64) >> 5) // bit 6 goes in bit 1
      + ((input &  32) >> 3) // bit 5 goes in bit 2
      + ((input &  16) >> 1) // bit 4 goes in bit 3
      + ((input &   8) << 1) // bit 3 goes in bit 4
      + ((input &   4) << 3) // bit 2 goes in bit 5
      + ((input &   2) << 5) // bit 1 goes in bit 6
      + ((input &   1) << 7) // bit 0 goes in bit 7
    );
}
MODULE int decrypt(UBYTE input)
{   return
    (   ((input & 128) >> 7) // bit 7 goes in bit 0
      + ((input &  64) >> 5) // bit 6 goes in bit 1
      + ((input &  32) >> 3) // bit 5 goes in bit 2
      + ((input &  16) >> 1) // bit 4 goes in bit 3
      + ((input &   8) << 1) // bit 3 goes in bit 4
      + ((input &   4) << 3) // bit 2 goes in bit 5
      + ((input &   2) << 5) // bit 1 goes in bit 6
      + ((input &   1) << 7) // bit 0 goes in bit 7
    );
}

EXPORT void cos_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?SAVEGAME#?", "Chambers of Shaolin", saveas, 16100, FLAG_R, FALSE);
}

EXPORT void cos_close(void) { ; }
EXPORT void cos_exit(void)  { ; }

MODULE void maximize_man(void)
{   str[who]     =
    att[who]     =
    def[who]     =
    con[who]     =
    hidden1[who] =
    hidden2[who] =
    hidden3[who] =
    hidden4[who] = 999;
}

MODULE void clear_roster(void)
{   int i, j;

    for (i = 0; i < 250; i++)
    {   str[i]     =
        att[i]     =
        def[i]     =
        con[i]     =
        hidden1[i] =
        hidden2[i] =
        hidden3[i] =
        hidden4[i] = 0;
        for (j = 0; j < 10 + 1; j++)
        {   name[i][j] = EOS;
    }   }

    men = 0;
    who = 0; // becomes "1" as far as the user is concerned
}
