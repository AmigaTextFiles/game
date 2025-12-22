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
#define GID_TOA_LY1    0 // root layout
#define GID_TOA_SB1    1 // toolbar
#define GID_TOA_ST1    2 // name
#define GID_TOA_IN1    3 // sp
#define GID_TOA_IN2    4 // xp
#define GID_TOA_IN3    5 // iq
#define GID_TOA_IN4    6 // intuition
#define GID_TOA_IN5    7 // ego
#define GID_TOA_IN6    8 // str
#define GID_TOA_IN7    9 // con
#define GID_TOA_IN8   10 // dex
#define GID_TOA_IN9   11 // armour +
#define GID_TOA_IN10  12 // weapon +
#define GID_TOA_IN11  13 // normal arrows
#define GID_TOA_IN12  14 // magic arrows
#define GID_TOA_IN13  15 // salves
#define GID_TOA_IN14  16 // elixirs
#define GID_TOA_IN15  17 // room
#define GID_TOA_IN16  18 // fatigue
#define GID_TOA_IN17  19 // wounds
#define GID_TOA_CB1   20 // bow
#define GID_TOA_BU1   21 // maximize character
#define GID_TOA_CH1   22 // armour
#define GID_TOA_CH2   23 // weapon
#define GID_TOA_CH3   24 // shield
#define GID_TOA_CH4   25 // file type
#define GID_TOA_IN18  26 // 1st treasure
#define GID_TOA_IN19  27
#define GID_TOA_IN20  28
#define GID_TOA_IN21  29
#define GID_TOA_IN22  30
#define GID_TOA_IN23  31
#define GID_TOA_IN24  32
#define GID_TOA_IN25  33
#define GID_TOA_IN26  34
#define GID_TOA_IN27  35
#define GID_TOA_IN28  36
#define GID_TOA_IN29  37
#define GID_TOA_IN30  38
#define GID_TOA_IN31  39
#define GID_TOA_IN32  40
#define GID_TOA_IN33  41
#define GID_TOA_IN34  42
#define GID_TOA_IN35  43
#define GID_TOA_IN36  44
#define GID_TOA_IN37  45 // 20th treasure
#define GIDS_TOA      GID_TOA_IN37

#define FILETYPE_CHARACTER 0
#define FILETYPE_SAVEGAME  1

#define TreasureGadget(x,y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_RelVerify, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 127, INTEGER_MinVisible, 3 + 1, IntegerEnd, Label(y)

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
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
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
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

MODULE ULONG                iq,
                            intuition,
                            ego,
                            str,
                            con,
                            dex,
                            weapon,
                            armour,
                            weaponplus,
                            armourplus,
                            shield,
                            bow,
                            narrows,
                            marrows,
                            salves,
                            elixirs,
                            xp,
                            sp,
                            treasure[20],
                            room,
                            fatigue,
                            wounds,
                            filetype;
MODULE TEXT                 name[14 + 1];

MODULE const STRPTR ArmourOptions[6 + 1] =
{ "None",
  "Leather",
  "Ringmail",
  "Chainmail",
  "Partial Plate",
  "Full Plate",
  NULL
}, FileTypeOptions[2 + 1] =
{ "Character",
  "Saved game",
  NULL
}, ShieldOptions[3 + 1] =
{ "None",
  "Small",
  "Large",
  NULL
}, WeaponOptions[7 + 1] =
{ "None",
  "Dagger",
  "Shortsword",
  "Broadsword",
  "Bastardsword",
  "Greatsword",
  "Magic sword",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void toa_main(void)
{   tool_open  = toa_open;
    tool_loop  = toa_loop;
    tool_save  = toa_save;
    tool_close = toa_close;
    tool_exit  = toa_exit;

    if (loaded != FUNC_TOA && !toa_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_TOA;

    make_speedbar_list(GID_TOA_SB1);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_TOA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                AddToolbar(GID_TOA_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_TOA_CH4] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_TOA_CH4,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &FileTypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "General",
                        LAYOUT_AddChild,                   gadgets[GID_TOA_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_TOA_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name,
                            STRINGA_MaxChars,              14 + 1,
                        StringEnd,
                        Label("Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               0x7FFFFFFF,
                            INTEGER_Number,                sp,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Silver Pieces:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               0x7FFFFFFF,
                            INTEGER_Number,                xp,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Experience Points:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN15] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN15,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               60,
                            INTEGER_Number,                room,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Room:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_TOA_IN16] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_TOA_IN16,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            fatigue,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            AddLabel("%"),
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        Label("Energy (\"Fatigue\"):"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_TOA_IN17] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_TOA_IN17,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            wounds,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            AddLabel("%"),
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        Label("Health (\"Wounds\"):"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "Attributes",
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                iq,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Intelligence:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                intuition,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Intuition:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                ego,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Ego:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                str,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Strength:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                con,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Constitution:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               127,
                            INTEGER_Number,                dex,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Dexterity:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "Items",
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN13] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN13,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                salves,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Salves:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN14] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN14,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                elixirs,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Elixirs:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN11,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                narrows,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Normal Arrows:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_TOA_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                marrows,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Magic Arrows:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_TOA_CH1] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_TOA_CH1,
                                CHOOSER_LabelArray,        &ArmourOptions,
                            PopUpEnd,
                            LAYOUT_AddChild,               gadgets[GID_TOA_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_TOA_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_Number,            armourplus,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                            Label("+:"),
                        LayoutEnd,
                        Label("Armour:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_TOA_CH3,
                            CHOOSER_LabelArray,            &ShieldOptions,
                        PopUpEnd,
                        Label("Shield:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_TOA_CH2] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_TOA_CH2,
                                CHOOSER_LabelArray,        &WeaponOptions,
                            PopUpEnd,
                            LAYOUT_AddChild,               gadgets[GID_TOA_IN10] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_TOA_IN10,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_Number,            weaponplus,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           0,
                            Label("+:"),
                        LayoutEnd,
                        Label("Weapon:"),
                        LAYOUT_AddChild,                   gadgets[GID_TOA_CB1] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_TOA_CB1,
                            GA_Text,                       "Bow",
                        End,
                        Label(""), // bow
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Treasures",
                    TreasureGadget(GID_TOA_IN18, "#1:" ),
                    TreasureGadget(GID_TOA_IN19, "#2:" ),
                    TreasureGadget(GID_TOA_IN20, "#3:" ),
                    TreasureGadget(GID_TOA_IN21, "#4:" ),
                    TreasureGadget(GID_TOA_IN22, "#5:" ),
                    TreasureGadget(GID_TOA_IN23, "#6:" ),
                    TreasureGadget(GID_TOA_IN24, "#7:" ),
                    TreasureGadget(GID_TOA_IN25, "#8:" ),
                    TreasureGadget(GID_TOA_IN26, "#9:" ),
                    TreasureGadget(GID_TOA_IN27, "#10:"),
                    TreasureGadget(GID_TOA_IN28, "#11:"),
                    TreasureGadget(GID_TOA_IN29, "#12:"),
                    TreasureGadget(GID_TOA_IN30, "#13:"),
                    TreasureGadget(GID_TOA_IN31, "#14:"),
                    TreasureGadget(GID_TOA_IN32, "#15:"),
                    TreasureGadget(GID_TOA_IN33, "#16:"),
                    TreasureGadget(GID_TOA_IN34, "#17:"),
                    TreasureGadget(GID_TOA_IN35, "#18:"),
                    TreasureGadget(GID_TOA_IN36, "#19:"),
                    TreasureGadget(GID_TOA_IN37, "#20:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            MaximizeButton(GID_TOA_BU1, "Maximize Character"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_TOA_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_TOA_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_TOA_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void toa_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_TOA_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
}   }

EXPORT FLAG toa_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 114)
        {   filetype = FILETYPE_CHARACTER;
        } elif (gamesize == 338)
        {   filetype = FILETYPE_SAVEGAME;
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
    (   page != FUNC_TOA
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
    {   either_ch(GID_TOA_CH4, &filetype);

        for (i = 0; i < 20; i++)
        {   ghost(GID_TOA_IN18 + i, filetype != FILETYPE_SAVEGAME); // treasure
        }
        ghost(GID_TOA_IN15, filetype != FILETYPE_SAVEGAME); // room
        ghost(GID_TOA_IN16, filetype != FILETYPE_SAVEGAME); // fatigue
        ghost(GID_TOA_IN17, filetype != FILETYPE_SAVEGAME); // wounds
    }

    either_st(GID_TOA_ST1,   name      );
    either_in(GID_TOA_IN1,  &sp        );
    either_in(GID_TOA_IN2,  &xp        );
    either_in(GID_TOA_IN3,  &iq        );
    either_in(GID_TOA_IN4,  &intuition );
    either_in(GID_TOA_IN5,  &ego       );
    either_in(GID_TOA_IN6,  &str       );
    either_in(GID_TOA_IN7,  &con       );
    either_in(GID_TOA_IN8,  &dex       );
    either_in(GID_TOA_IN9,  &armourplus);
    either_in(GID_TOA_IN10, &weaponplus);
    either_in(GID_TOA_IN11, &narrows   );
    either_in(GID_TOA_IN12, &marrows   );
    either_in(GID_TOA_IN13, &salves    );
    either_in(GID_TOA_IN14, &elixirs   );
    either_in(GID_TOA_IN15, &room      );
    either_in(GID_TOA_IN16, &fatigue   );
    either_in(GID_TOA_IN17, &wounds    );
    for (i = 0; i < 20; i++)
    {   either_in(GID_TOA_IN18 + i, &treasure[i]);
    }
    either_ch(GID_TOA_CH1,  &armour    );
    either_ch(GID_TOA_CH2,  &weapon    );
    either_ch(GID_TOA_CH3,  &shield    );
    either_cb(GID_TOA_CB1,  &bow       );
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    if (filetype == FILETYPE_CHARACTER)
    {   offset = 0x10;
    } else
    {   offset = 0;
    }

    if (serializemode == SERIALIZE_READ)
    {   strcpy(name, (char*) &IOBuffer[offset]);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset], name);
    }

    offset += 0x14;                   // savegame character
    serialize1(&iq);                  // $14      $24
    serialize1(&intuition);           // $15      $25
    serialize1(&ego);                 // $16      $26
    serialize1(&str);                 // $17      $27
    serialize1(&con);                 // $18      $28
    serialize1(&dex);                 // $19      $29
    serialize1(&weapon);              // $1A      $2A
    serialize1(&armour);              // $1B      $2B
    serialize1(&weaponplus);          // $1C      $2C
    serialize1(&armourplus);          // $1D      $2D
    serialize1(&shield);              // $1E      $2E
    serialize1(&bow);                 // $1F      $2F
    serialize1(&narrows);             // $20      $30
    serialize1(&marrows);             // $21      $31
    serialize1(&salves);              // $22      $32
    serialize1(&elixirs);             // $23      $33
    serialize4(&xp);                  // $24..$27 $34..$37
    serialize4(&sp);                  // $28..$2B $38..$3B
    if (filetype == FILETYPE_SAVEGAME)
    {   for (i = 0; i < 20; i++)
        {   serialize1(&treasure[i]); // $2C..$3F -------- 20 bytes
        }
        offset += 4;                  // $40..$43 --------  4 bytes
        serialize1(&room);            // $44      --------  1 byte
        offset += 4;                  // $45..$48 --------  4 bytes
        serialize1(&fatigue);         // $49      --------  1 byte
        offset += 3;                  // $4A..$4C --------  3 bytes
        serialize1(&wounds);          // $4D      --------  1 byte
    } else
    {   // assert(filetype == FILETYPE_CHARACTER);
        fatigue =
        wounds  = 0;
        room    = 1;
        for (i = 0; i < 20; i++)
        {   treasure[i] = 0;
}   }   }

EXPORT void toa_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?", "Temple of Apshai", saveas, gamesize, (filetype == FILETYPE_CHARACTER) ? FLAG_C : FLAG_S, FALSE);
}

EXPORT void toa_close(void) { ; }
EXPORT void toa_exit(void)  { ; }

MODULE void maximize_man(void)
{   int i;

    bow             =           1;
    shield          =           2;
    armour          =           5;
    weapon          =           6;
    weaponplus      =
    armourplus      =           9;
    iq              =
    intuition       =
    ego             =
    str             =
    con             =
    dex             =
    narrows         =
    marrows         =
    salves          =
    elixirs         =          90;
    fatigue         =
    wounds          =         100;
    for (i = 0; i < 20; i++)
    {   treasure[i] =         120;
    }
    xp              =
    sp              = ONE_BILLION;
}
