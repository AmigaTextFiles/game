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
#define GID_LOL_LY1    0 // root layout
#define GID_LOL_SB1    1 // toolbar
#define GID_LOL_IN1    2 // gp
#define GID_LOL_IN2    3 // xp
#define GID_LOL_IN3    4 // cur hp
#define GID_LOL_IN4    5 // max hp
#define GID_LOL_IN5    6 // food
#define GID_LOL_IN6    7 // cur sta
#define GID_LOL_IN7    8 // max sta
#define GID_LOL_IN8    9 // level
#define GID_LOL_IN9   10 // ship X
#define GID_LOL_IN10  11 // ship Y
#define GID_LOL_IN11  12 // your X
#define GID_LOL_IN12  13 // your Y
#define GID_LOL_BU1   14 // maximize character
#define GID_LOL_CH1   15 // armour
#define GID_LOL_CH2   16 // weapon
#define GID_LOL_CH3   17 // sex
#define GID_LOL_CH4   18 // area
#define GID_LOL_CH5   19 // 1st  item slot
#define GID_LOL_CH6   20
#define GID_LOL_CH7   21
#define GID_LOL_CH8   22
#define GID_LOL_CH9   23
#define GID_LOL_CH10  24
#define GID_LOL_CH11  25
#define GID_LOL_CH12  26
#define GID_LOL_CH13  27
#define GID_LOL_CH14  28 // 10th item slot
#define GID_LOL_CB1   29 // compass
#define GID_LOL_CB2   30 // marsh
#define GID_LOL_CB3   31 // boarded
#define GIDS_LOL       GID_LOL_CB3

#define ItemChooser(x) LAYOUT_AddChild, gadgets[GID_LOL_CH5 + x] = (struct Gadget*) PopUpObject, GA_ID, GID_LOL_CH5 + x, CHOOSER_Labels, &ItemList, CHOOSER_AutoFit, TRUE, CHOOSER_MaxLabels, 16, PopUpEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE UBYTE encode(int number);
MODULE int decode(UBYTE number);

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
IMPORT struct List          SexList,
                            SpeedBarList;
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
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                area,
                            armour,
                            boarded,
                            compass,
                            food,
                            gp,
                            xp,
                            item[10],
                            level,
                            location_x,
                            location_y,
                            marsh,
                            sex,
                            ship_x,
                            ship_y,
                            curhp,
                            maxhp,
                            cursta,
                            maxsta,
                            weapon;
MODULE struct List          ItemList;

MODULE const STRPTR AreaOptions[18 + 1] =
{ "Land of Mercia",
  "Town of Larkspur",
  "Lothian Castle (1st floor)",
  "Lothian Castle (2nd floor)",
  "Mountain cave",
  "Town of Asraela",
  "Forlorn Castle (1st floor)",
  "Forlorn Castle (2nd floor)",
  "Town of Rastun",
  "Ruins of Hesron",
  "Forlorn Dungeon",
  "Town of Wenhea",
  "Town of Marlot",
  "Shrine of Might",
  "Shrine of Protection",
  "Town of Trubly",
  "Evil Palace",
  "Evil Dungeon",
  NULL
}, ArmourOptions[7 + 1] =
{ "None",
  "Cloth",
  "Leather",
  "Ringmail",
  "Chainmail",
  "Plate",
  "Magical",
  NULL
}, ItemOptions[16] =
{ "Empty",
  "Skeleton key",
  "Axe",
  "Lantern",
  "Amulet",
  "Compass",
  "Orb of Sight",
  "Rose",
  "Hand mirror",
  "Magical wood",
  "Rope",
  "Unicorn",
  "Horn",
  "Spellbook",
  "Gem",
  "Potion"
  // no NULL is required
}, WeaponOptions[7 + 1] =
{ "None",
  "Club",
  "Dagger",
  "Mace",
  "Sword",
  "Crossbow",
  "Magical",
  NULL
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  KKK. .... .... ....    . = Transparent (%00)
    KWWK .... .... ....    K = Black       (%01)
    KWKW K... .... ....    W = White       (%10)
    .KWK WK.. .... ....    - = Unused      (%11)
    ..KW KWK. .... ....
    ...K WKWK .... ....
    .... KWKW K... .K..
    .... .KWK WK.. KWK.
    .... ..KW KWKK WWK.
    .... ...K WKKW WK..
    .... .... KKWW K...
    .... .... KWWK WK..
    .... ...K WWKW WWK.
    .... ..KW WK.K WWWK
    .... ...K K... KWWK
    .... .... .... .KK.

    Plane 0 Plane 1 */
    0xE000, 0x0000,
    0x9000, 0x6000,
    0xA800, 0x5000,
    0x5400, 0x2800,
    0x2A00, 0x1400,
    0x1500, 0x0A00,
    0x0A84, 0x0500,
    0x054A, 0x0284,
    0x02B2, 0x014C,
    0x0164, 0x0098,
    0x00C8, 0x0030,
    0x0094, 0x0068,
    0x0122, 0x00DC,
    0x0251, 0x018E,
    0x0189, 0x0006,
    0x0006, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void lol_main(void)
{   TRANSIENT int                 i;
    TRANSIENT struct ChooserNode* ChooserNodePtr;
    PERSIST   FLAG                first = TRUE;

    if (first)
    {   first = FALSE;

        // lol_preinit()
        NewList(&ItemList);
    }

    tool_open  = lol_open;
    tool_loop  = lol_loop;
    tool_save  = lol_save;
    tool_close = lol_close;
    tool_exit  = lol_exit;

    if (loaded != FUNC_LOL && !lol_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_LOL;

    load_images(120, 134);
    for (i = 0; i < 16; i++)
    {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
        (   CNA_Text,                        ItemOptions[i],
            i == 0 ? TAG_IGNORE : CNA_Image, image[120 + i - 1],
        TAG_DONE)))
        {   rq("Can't create chooser.gadget node(s)!");
        }
        AddTail(&ItemList, (struct Node*) ChooserNodePtr); /* AddTail() has no return code */
    }

    make_speedbar_list(GID_LOL_SB1);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);

    lockscreen();
    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_LOL_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddToolbar(GID_LOL_SB1),
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "General",
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_LOL_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_LOL_CH3,
                            CHOOSER_Labels,                &SexList,
                        PopUpEnd,
                        Label("Sex:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_LOL_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                level,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_LOL_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_Number,                xp,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        Label("Experience Points:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_Number,            curhp,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_Number,            maxhp,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("of"),
                        LayoutEnd,
                        Label("Health:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_Number,            cursta,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_Number,            maxsta,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("of"),
                        LayoutEnd,
                        Label("Stamina:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_LOL_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               9999,
                            INTEGER_Number,                gp,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        Label("Gold pieces:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_LOL_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999,
                            INTEGER_Number,                food,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Food:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_CH1] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_LOL_CH1,
                            CHOOSER_LabelArray,            &ArmourOptions,
                        PopUpEnd,
                        Label("Armour:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_LOL_CH2,
                            CHOOSER_LabelArray,            &WeaponOptions,
                        PopUpEnd,
                        Label("Weapon:"),
                        LAYOUT_AddChild,                   gadgets[GID_LOL_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_LOL_CH4,
                            CHOOSER_LabelArray,            &AreaOptions,
                            CHOOSER_MaxLabels,             18,
                        PopUpEnd,
                        Label("Area:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN11] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN11,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999, // 156,
                                INTEGER_Number,            location_x,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("X:"),
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN12] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN12,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999, // 80,
                                INTEGER_Number,            location_y,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Y:"),
                        LayoutEnd,
                        Label("Your location:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999, // 156,
                                INTEGER_Number,            ship_x,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("X:"),
                            LAYOUT_AddChild,               gadgets[GID_LOL_IN10] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOL_IN10,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999, // 80,
                                INTEGER_Number,            ship_y,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Y:"),
                        LayoutEnd,
                        Label("Ship location:"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    LAYOUT_AddChild,                       gadgets[GID_LOL_CB1] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_LOL_CB1,
                        GA_Selected,                       compass,
                        GA_Text,                           "Compass in use?",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_LOL_CB2] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_LOL_CB2,
                        GA_Selected,                       marsh,
                        GA_Text,                           "Immune to marshes?",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_LOL_CB3] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_LOL_CB3,
                        GA_Selected,                       boarded,
                        GA_Text,                           "Boarded ship?",
                    End,
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Items",
                    ItemChooser(0),
                    Label("#1:"),
                    ItemChooser(1),
                    Label("#2:"),
                    ItemChooser(2),
                    Label("#3:"),
                    ItemChooser(3),
                    Label("#4:"),
                    ItemChooser(4),
                    Label("#5:"),
                    ItemChooser(5),
                    Label("#6:"),
                    ItemChooser(6),
                    Label("#7:"),
                    ItemChooser(7),
                    Label("#8:"),
                    ItemChooser(8),
                    Label("#9:"),
                    ItemChooser(9),
                    Label("#10:"),
                LayoutEnd,
            LayoutEnd,
            MaximizeButton(GID_LOL_BU1, "Maximize Character"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_LOL_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_LOL_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_LOL_IN8]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void lol_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_LOL_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
}   }

EXPORT FLAG lol_open(FLAG loadas)
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
    (   page != FUNC_LOL
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_LOL_IN1,  &gp        );
    either_in(GID_LOL_IN2,  &xp        );
    either_in(GID_LOL_IN3,  &curhp     );
    either_in(GID_LOL_IN4,  &maxhp     );
    either_in(GID_LOL_IN5,  &food      );
    either_in(GID_LOL_IN6,  &cursta    );
    either_in(GID_LOL_IN7,  &maxsta    );
    either_in(GID_LOL_IN8,  &level     );
    either_in(GID_LOL_IN9,  &ship_x    );
    either_in(GID_LOL_IN10, &ship_y    );
    either_in(GID_LOL_IN11, &location_x);
    either_in(GID_LOL_IN12, &location_y);
    either_ch(GID_LOL_CH1,  &armour    );
    either_ch(GID_LOL_CH2,  &weapon    );
    either_ch(GID_LOL_CH3,  &sex       );
    either_ch(GID_LOL_CH4,  &area      );
    for (i = 0; i < 10; i++)
    {   either_ch(GID_LOL_CH5 + i, &item[i]);
    }
    either_cb(GID_LOL_CB1,  &compass   );
    either_cb(GID_LOL_CB2,  &marsh     );
    either_cb(GID_LOL_CB3,  &boarded   );
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE UBYTE encode(int number)
{   PERSIST const UBYTE encoded[10] =
    { 0x23,
      0x52,
      0x66,
      0x2A,
      0x77,
      0x41,
      0x56,
      0x21,
      0x32,
      0x69
    };

    return encoded[number];
}

MODULE int decode(UBYTE number)
{   switch (number)
    {
    case 0x24:
        return -1;
    case 0x23:
        return 0;
    case 0x52:
        return 1;
    case 0x66:
        return 2;
    case 0x2A:
        return 3;
    case 0x77:
        return 4;
    case 0x41:
        return 5;
    case 0x56:
        return 6;
    case 0x21:
        return 7;
    case 0x32:
        return 8;
    case 0x69:
        return 9;
    default:
        return 0; // should not happen with any validly generated file
}   }

MODULE void serialize(void)
{   int i;

    if (serializemode == SERIALIZE_READ)
    {   location_x = (decode(IOBuffer[ 0]) *  100)
                   + (decode(IOBuffer[ 1]) *   10)
                   +  decode(IOBuffer[ 2]);
        location_y = (decode(IOBuffer[ 3]) *  100)
                   + (decode(IOBuffer[ 4]) *   10)
                   +  decode(IOBuffer[ 5]);
        if (IOBuffer[6] == 0x24)
        {   area   = 0;
        } else
        {   area   = (decode(IOBuffer[ 6]) *   10)
                   +  decode(IOBuffer[ 7])
                   + 1;
        }
        xp         = (decode(IOBuffer[ 8]) * 1000)
                   + (decode(IOBuffer[ 9]) *  100)
                   + (decode(IOBuffer[10]) *   10)
                   +  decode(IOBuffer[11]);
        gp         = (decode(IOBuffer[12]) * 1000)
                   + (decode(IOBuffer[13]) *  100)
                   + (decode(IOBuffer[14]) *   10)
                   +  decode(IOBuffer[15]);
        food       = (decode(IOBuffer[16]) *  100)
                   + (decode(IOBuffer[17]) *   10)
                   +  decode(IOBuffer[18]);
        curhp      = (decode(IOBuffer[19]) *  100)
                   + (decode(IOBuffer[20]) *   10)
                   +  decode(IOBuffer[21]);
        maxhp      = (decode(IOBuffer[22]) *  100)
                   + (decode(IOBuffer[23]) *   10)
                   +  decode(IOBuffer[24]);
        cursta     = (decode(IOBuffer[25]) *  100)
                   + (decode(IOBuffer[26]) *   10)
                   +  decode(IOBuffer[27]);
        maxsta     = (decode(IOBuffer[28]) *  100)
                   + (decode(IOBuffer[29]) *   10)
                   +  decode(IOBuffer[30]);
        level      = (decode(IOBuffer[31]) *   10)
                   +  decode(IOBuffer[32]);
        weapon     =  decode(IOBuffer[33]);
        armour     =  decode(IOBuffer[34]);
        ship_x     = (decode(IOBuffer[36]) *  100)
                   + (decode(IOBuffer[37]) *   10)
                   +  decode(IOBuffer[38]);
        ship_y     = (decode(IOBuffer[39]) *  100)
                   + (decode(IOBuffer[40]) *   10)
                   +  decode(IOBuffer[41]);
        boarded    = (IOBuffer[43] == 0x52 ? TRUE : FALSE);
        sex        =  decode(IOBuffer[46]);
        compass    = (IOBuffer[48] == 0x52 ? TRUE : FALSE);
        marsh      = (IOBuffer[49] == 0x52 ? TRUE : FALSE);

        for (i = 0; i < 10; i++)
        {   if (IOBuffer[56 + (i * 2)] == 0x24)
            {   item[i] = 0;
            } else
            {   item[i] = (decode(IOBuffer[56 + (i * 2)]) * 10)
                        +  decode(IOBuffer[57 + (i * 2)])
                        + 1;
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        IOBuffer[ 0] = encode( location_x /  100);
        IOBuffer[ 1] = encode((location_x %  100) / 10);
        IOBuffer[ 2] = encode( location_x %   10);
        IOBuffer[ 3] = encode( location_y /  100);
        IOBuffer[ 4] = encode((location_y %  100) / 10);
        IOBuffer[ 5] = encode( location_y %   10);
        if (area == 0)
        {   IOBuffer[6] = 0x24;
            IOBuffer[7] = 0x52;
        } else
        {   IOBuffer[6] = encode((area - 1) /  10);
            IOBuffer[7] = encode((area - 1) %  10);
        }
        IOBuffer[ 8] = encode( xp         / 1000);
        IOBuffer[ 9] = encode((xp % 1000) /  100);
        IOBuffer[10] = encode((xp %  100) /   10);
        IOBuffer[11] = encode( xp         %   10);
        IOBuffer[12] = encode( gp         / 1000);
        IOBuffer[13] = encode((gp % 1000) /  100);
        IOBuffer[14] = encode((gp %  100) /   10);
        IOBuffer[15] = encode( gp         %   10);
        IOBuffer[16] = encode( food       /  100);
        IOBuffer[17] = encode((food       %  100) / 10);
        IOBuffer[18] = encode( food       %   10);
        IOBuffer[19] = encode( curhp      /  100);
        IOBuffer[20] = encode((curhp      %  100) / 10);
        IOBuffer[21] = encode( curhp      %   10);
        IOBuffer[22] = encode( maxhp      /  100);
        IOBuffer[23] = encode((maxhp      %  100) / 10);
        IOBuffer[24] = encode( maxhp      %   10);
        IOBuffer[25] = encode( cursta     /  100);
        IOBuffer[26] = encode((cursta     %  100) / 10);
        IOBuffer[27] = encode( cursta     %   10);
        IOBuffer[28] = encode( maxsta     /  100);
        IOBuffer[29] = encode((maxsta     %  100) / 10);
        IOBuffer[30] = encode( maxsta     %   10);
        IOBuffer[31] = encode( level      /   10);
        IOBuffer[32] = encode( level      %   10);
        IOBuffer[33] = encode( weapon);
        IOBuffer[34] = encode( armour);
        IOBuffer[36] = encode( ship_x     /  100);
        IOBuffer[37] = encode((ship_x     %  100) / 10);
        IOBuffer[38] = encode( ship_x     %   10);
        IOBuffer[39] = encode( ship_y     /  100);
        IOBuffer[40] = encode((ship_y     %  100) / 10);
        IOBuffer[41] = encode( ship_y     %   10);
        IOBuffer[43] = boarded ? 0x52 : 0x23;
        IOBuffer[46] = encode( sex);
        IOBuffer[48] = compass ? 0x52 : 0x23;
        IOBuffer[49] = marsh   ? 0x52 : 0x23;

        for (i = 0; i < 10; i++)
        {   if (item[i] == 0)
            {   IOBuffer[56 + (i * 2)] = 0x24;
                IOBuffer[57 + (i * 2)] = 0x52;
            } else
            {   IOBuffer[56 + (i * 2)] = encode((item[i] - 1) / 10);
                IOBuffer[57 + (i * 2)] = encode((item[i] - 1) % 10);
}   }   }   }

EXPORT void lol_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?.save", "Legend of Lothian", saveas, 96, FLAG_S, FALSE);
}

EXPORT void lol_exit(void)
{   ch_clearlist(&ItemList);
    ch_clearlist(&SexList);
}

EXPORT void lol_close(void) { ; }

MODULE void maximize_man(void)
{   compass =
    marsh   = TRUE;
    armour  =
    weapon  =    6;
    level   =   99;
    food    =
    curhp   =
    maxhp   =
    cursta  =
    maxsta  =  999;
    gp      =
    xp      = 9999;
}
