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

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_KEEF_LY1    0 // root layout
#define GID_KEEF_SB1    1 // toolbar
#define GID_KEEF_IN1    2 // strength %
#define GID_KEEF_IN2    3 // speed %
#define GID_KEEF_IN3    4 // constitution %
#define GID_KEEF_IN4    5 // wisdom %
#define GID_KEEF_IN5    6 // luck %
#define GID_KEEF_IN6    7 // charisma %
#define GID_KEEF_IN7    8 // disarming %
#define GID_KEEF_IN8    9 // stealing %
#define GID_KEEF_IN9   10 // unlocking %
#define GID_KEEF_IN10  11 // nutrition %
#define GID_KEEF_IN11  12 // sobriety %
#define GID_KEEF_IN12  13 // sleep %
#define GID_KEEF_IN13  14 // level
#define GID_KEEF_IN14  15 // gp
#define GID_KEEF_BU1   16 // maximize character
#define GID_KEEF_BU2   17 // invert weapons
#define GID_KEEF_CB1   18 //  1st   weapon
#define GID_KEEF_CB29  46 // 29th   weapon
#define GID_KEEF_CB30  47 //  1st   armour
#define GID_KEEF_CB44  61 // 15th   armour
#define GID_KEEF_BU6   62 // more #1...
#define GID_KEEF_BU7   63 // all    weapons
#define GID_KEEF_BU8   64 // none   weapons
#define GID_KEEF_BU15  65 // more #2...

// more #1 window
#define GID_KEEF_LY2   66
#define GID_KEEF_CB45  67 //  1st   item
#define GID_KEEF_CB83 105 // 39th   item
#define GID_KEEF_CB84 106 //  1st   artifact
#define GID_KEEF_CB89 111 //  6th   artifact
#define GID_KEEF_BU3  112 // invert armour
#define GID_KEEF_BU4  113 // invert items
#define GID_KEEF_BU5  114 // invert artifacts
#define GID_KEEF_BU9  115 // all    items
#define GID_KEEF_BU10 116 // none   items
#define GID_KEEF_BU11 117 // all    artifacts
#define GID_KEEF_BU12 118 // none   artifacts
#define GID_KEEF_BU13 119 // all    armour
#define GID_KEEF_BU14 120 // none   armour

// more #2 window
#define GID_KEEF_LY3  121
#define GID_KEEF_IN15 122 //  1st spell
#define GID_KEEF_IN40 147 // 26th spell
#define GID_KEEF_IN41 148 //  1st reagent
#define GID_KEEF_IN52 159 // 12th reagent

#define GIDS_KEEF     GID_KEEF_IN52

#define NewArmour(a,b)   LAYOUT_AddChild, gadgets[GID_KEEF_CB30 + a] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_KEEF_CB30 + a, GA_Selected, armour[a],   GA_Text, b, CheckBoxEnd
#define NewArtifact(a,b) LAYOUT_AddChild, gadgets[GID_KEEF_CB84 + a] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_KEEF_CB84 + a, GA_Selected, artifact[a], GA_Text, b, CheckBoxEnd
#define NewItem(a,b)     LAYOUT_AddChild, gadgets[GID_KEEF_CB45 + a] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_KEEF_CB45 + a, GA_Selected, item[a],     GA_Text, b, CheckBoxEnd
#define NewReagent(a)    LAYOUT_AddChild, gadgets[GID_KEEF_IN41 + a] = (struct Gadget*) IntegerObject       , GA_ID, GID_KEEF_IN41 + a, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 99, INTEGER_Number, reagent[a], INTEGER_MinVisible, 2 + 1, IntegerEnd
#define NewSpell(a)      LAYOUT_AddChild, gadgets[GID_KEEF_IN15 + a] = (struct Gadget*) IntegerObject       , GA_ID, GID_KEEF_IN15 + a, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 99, INTEGER_Number, spell[a],   INTEGER_MinVisible, 2 + 1, IntegerEnd
#define NewWeapon(a,b)   LAYOUT_AddChild, gadgets[GID_KEEF_CB1  + a] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_KEEF_CB1  + a, GA_Selected, weapon[a],   GA_Text, b, CheckBoxEnd

#define ARMOURS        15
#define ARTIFACTS       6
#define ITEMS          39
#define REAGENTS       12
#define SPELLS         26
#define WEAPONS        29

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void more1window(void);
MODULE void more1eithergadgets(void);
MODULE void more2window(void);

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
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                strength,
                            speed,
                            constitution,
                            wisdom,
                            luck,
                            charisma,
                            disarming,
                            stealing,
                            unlocking,
                            nutrition,
                            sobriety,
                            sleep,
                            gp,
                            level,
                            armour[ARMOURS],
                            artifact[ARTIFACTS],
                            item[ITEMS],
                            reagent[REAGENTS],
                            spell[SPELLS],
                            weapon[WEAPONS];

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void keef_main(void)
{   tool_open      = keef_open;
    tool_loop      = keef_loop;
    tool_save      = keef_save;
    tool_close     = keef_close;
    tool_exit      = keef_exit;
    tool_subgadget = keef_subgadget;

    if (loaded != FUNC_KEEF && !keef_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_KEEF;

    make_speedbar_list(GID_KEEF_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_KEEF_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_KEEF_SB1),
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                AddVLayout,
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN1,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                strength,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Strength:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN2,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                speed,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Speed:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN3,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                constitution,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Constitution:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN4,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                wisdom,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Wisdom:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN5] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN5,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                luck,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Luck:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN6] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN6,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                charisma,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Charisma:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN7] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN7,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                disarming,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Disarming:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN8,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                stealing,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Stealing:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN9] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN9,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                unlocking,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Unlocking:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN10,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                nutrition,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Nutrition:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN11,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                sobriety,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Sobriety:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN12] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN12,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                sleep,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Sleep:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN13] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN13,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                level,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Level:"),
                    LAYOUT_AddChild,                   gadgets[GID_KEEF_IN14] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_KEEF_IN14,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_Number,                gp,
                        INTEGER_MinVisible,            5 + 1,
                    IntegerEnd,
                    Label("Gold pieces:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Weapons",
                    AddHLayout,
                        AddVLayout,
                            NewWeapon( 0, "Bare Hands"),
                            NewWeapon( 1, "Tree Branch"),
                            NewWeapon( 2, "Spiked Club"),
                            NewWeapon( 3, "Spiked Gloves"),
                            NewWeapon( 4, "Sickle"),
                            NewWeapon( 5, "Scythe"),
                            NewWeapon( 6, "Dirk"),
                            NewWeapon( 7, "Throwing Dagger"),
                            NewWeapon( 8, "Axe"),
                            NewWeapon( 9, "Blessed Axe"),
                            NewWeapon(10, "Whirling Death"),
                            NewWeapon(11, "Halberd"),
                            NewWeapon(12, "Bola"),
                            NewWeapon(13, "Long Bow"),
                            NewWeapon(14, "Crossbow"),
                        LayoutEnd,
                        AddVLayout,
                            NewWeapon(15, "Holy Bow"),
                            NewWeapon(16, "Short Sword"),
                            NewWeapon(17, "Blood Blade"),
                            NewWeapon(18, "Bruce"),
                            NewWeapon(19, "Bahb el Buhd"),
                            NewWeapon(20, "Yin"),
                            NewWeapon(21, "Yang"),
                            NewWeapon(22, "Yin Yang"),
                            NewWeapon(23, "Charles"),
                            NewWeapon(24, "St. George"),
                            NewWeapon(25, "David"),
                            NewWeapon(26, "Neptune"),
                            NewWeapon(27, "Nischtarr"),
                            NewWeapon(28, "The Hare"),
                        LayoutEnd,
                    LayoutEnd,
                    HTripleButton(GID_KEEF_BU7, GID_KEEF_BU2, GID_KEEF_BU8),
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                LAYOUT_AddChild,                           gadgets[GID_KEEF_BU6] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                 GID_KEEF_BU6,
                    GA_RelVerify,                          TRUE,
                    GA_Text,                               "Armour, Artifacts, Items...",
                ButtonEnd,
                LAYOUT_AddChild,                           gadgets[GID_KEEF_BU15] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                 GID_KEEF_BU15,
                    GA_RelVerify,                          TRUE,
                    GA_Text,                               "Spells, Reagents...",
                ButtonEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            MaximizeButton(GID_KEEF_BU1, "Maximize Character"),
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_KEEF_SB1);
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void keef_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_KEEF_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_KEEF_BU2:
        readgadgets();
        for (i = 0; i < WEAPONS; i++)
        {   if (weapon[i])
            {   weapon[i] = FALSE;
            } else
            {   weapon[i] = TRUE;
        }   }
        writegadgets();
    acase GID_KEEF_BU6:
        more1window();
    acase GID_KEEF_BU7:
        readgadgets();
        for (i = 0; i < WEAPONS; i++)
        {   weapon[i] = TRUE;
        }
        writegadgets();
    acase GID_KEEF_BU8:
        readgadgets();
        for (i = 0; i < WEAPONS; i++)
        {   weapon[i] = FALSE;
        }
        writegadgets();
    acase GID_KEEF_BU15:
        more2window();
}   }

EXPORT FLAG keef_open(FLAG loadas)
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
    (   page != FUNC_KEEF
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_KEEF_IN1,  &strength    );
    either_in(GID_KEEF_IN2,  &speed       );
    either_in(GID_KEEF_IN3,  &constitution);
    either_in(GID_KEEF_IN4,  &wisdom      );
    either_in(GID_KEEF_IN5,  &luck        );
    either_in(GID_KEEF_IN6,  &charisma    );
    either_in(GID_KEEF_IN7,  &disarming   );
    either_in(GID_KEEF_IN8,  &stealing    );
    either_in(GID_KEEF_IN9,  &unlocking   );
    either_in(GID_KEEF_IN10, &nutrition   );
    either_in(GID_KEEF_IN11, &sobriety    );
    either_in(GID_KEEF_IN12, &sleep       );
    either_in(GID_KEEF_IN13, &level       );
    either_in(GID_KEEF_IN14, &gp          );

    for (i = 0; i < WEAPONS; i++)
    {   either_cb(GID_KEEF_CB1  + i, &weapon[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 2;
    serialize2ulong(&strength);        //  $02.. $03
    serialize2ulong(&speed);           //  $04.. $05
    serialize2ulong(&constitution);    //  $06.. $07
    serialize2ulong(&wisdom);          //  $08.. $09
    serialize2ulong(&luck);            //  $0A.. $0B
    serialize2ulong(&charisma);        //  $0C.. $0D
    serialize2ulong(&disarming);       //  $0E.. $0F
    serialize2ulong(&stealing);        //  $10.. $11
    serialize2ulong(&unlocking);       //  $12.. $13
    serialize2ulong(&nutrition);       //  $14.. $15
    serialize2ulong(&sobriety);        //  $16.. $17
    serialize2ulong(&sleep);           //  $18.. $19
    serialize2ulong(&gp);              //  $1A.. $1B
    offset = 0x20;
    serialize2ulong(&level);           //  $20.. $21
    for (i = 0; i < SPELLS; i++)
    {   serialize2ulong(&spell[i]);    //  $22.. $55
    }
    offset = 0x5E;
    for (i = 0; i < REAGENTS; i++)
    {   serialize2ulong(&spell[i]);    //  $5E.. $75
    }
    offset = 0x8E;
    for (i = 0; i < WEAPONS; i++)
    {   serialize2ulong(&weapon[i]);   //  $8E.. $C7
    }
    for (i = 0; i < ARMOURS; i++)
    {   serialize2ulong(&armour[i]);   //  $C8.. $E5
    }
    offset = 0x278;
    for (i = 0; i < ITEMS; i++)
    {   serialize2ulong(&item[i]);     // $278..$2C5
    }
    offset = 0x2D4;
    for (i = 0; i < ARTIFACTS; i++)
    {   serialize2ulong(&artifact[i]); // $2D4..$2DF
}   }

EXPORT void keef_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?SG#?", "Keef the Thief", saveas, 2000, FLAG_S, FALSE);
}

EXPORT void keef_close(void)   { ; }
EXPORT void keef_exit(void)    { ; }

MODULE void maximize_man(void)
{   int i;

    strength        =
    speed           =
    constitution    =
    wisdom          =
    luck            =
    charisma        =
    disarming       =
    stealing        =
    unlocking       =
    nutrition       =
    sobriety        =
    sleep           =   100;

    level           =
    gp              = 32000;

    for (i = 0; i < SPELLS; i++)
    {   spell[i]    = 99;
    }
    for (i = 0; i < REAGENTS; i++)
    {   reagent[i]  = 99;
    }
    for (i = 0; i < ARMOURS; i++)
    {   armour[i]   = TRUE;
    }
    for (i = 0; i < ARTIFACTS; i++)
    {   artifact[i] = TRUE;
    }
    for (i = 0; i < ITEMS; i++)
    {   item[i]     = TRUE;
    }
    for (i = 0; i < WEAPONS; i++)
    {   weapon[i]   = TRUE;
}   }

MODULE void more1window(void)
{   InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Armour/Artifacts/Items",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "keef-1",
        WINDOW_ParentGroup,                    gadgets[GID_KEEF_LY2] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            AddVLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,         BVS_GROUP,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_Label,              "Items",
                    AddHLayout,
                        AddVLayout,
                            NewItem( 0, "Jungle Map"),
                            NewItem( 1, "Book of Lore"),
                            NewItem( 2, "Antique Book"),
                            NewItem( 3, "Book of Swords"),
                            NewItem( 4, "Scroll of Unity"),
                            NewItem( 5, "Scroll of Power"),
                            NewItem( 6, "Scroll of Force"),
                            NewItem( 7, "Scroll of Infinity"),
                            NewItem( 8, "Flower of Mem"),
                            NewItem( 9, "Telloc's Log"),
                            NewItem(10, "Roses"),
                            NewItem(11, "Daffodils"),
                            NewItem(12, "Bad Poetry"),
                        LayoutEnd,
                        AddVLayout,
                            NewItem(13, "Rope"),
                            NewItem(14, "Lock Pick Set"),
                            NewItem(15, "Oil"),
                            NewItem(16, "Grappling Hook"),
                            NewItem(17, "Knife"),
                            NewItem(18, "Flint & Steel"),
                            NewItem(19, "Homin Horse"),
                            NewItem(20, "Clydesdale"),
                            NewItem(21, "Porche Art"),
                            NewItem(22, "Landscape"),
                            NewItem(23, "Shard of Mem"),
                            NewItem(24, "Used Scrolls"),
                            NewItem(25, "Credits"),
                        LayoutEnd,
                        AddVLayout,
                            NewItem(26, "Telloc's Skull"),
                            NewItem(27, "Passport"),
                            NewItem(28, "Hermit's Key"),
                            NewItem(29, "Key of Koran"),
                            NewItem(30, "Mermaid's Ring"),
                            NewItem(31, "Porche Sketch"),
                            NewItem(32, "Tea Pot"),
                            NewItem(33, "Dog"),
                            NewItem(34, "Toothbrush"),
                            NewItem(35, "Plate"),
                            NewItem(36, "Goblet"),
                            NewItem(37, "Green Necklace"),
                            NewItem(38, "Ruby Necklace"),
                        LayoutEnd,
                    LayoutEnd,
                    HTripleButton(GID_KEEF_BU9, GID_KEEF_BU4, GID_KEEF_BU10),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Artifacts",
                    NewArtifact( 0, "Gem of Wisdom"),
                    NewArtifact( 1, "Globe of Power"),
                    NewArtifact( 2, "Plate of Strength"),
                    NewArtifact( 3, "Arm of Wealth"),
                    NewArtifact( 4, "Arm of Love"),
                    NewArtifact( 5, "Artifact of Mem"),
                    HTripleButton(GID_KEEF_BU11, GID_KEEF_BU5, GID_KEEF_BU12),
                LayoutEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Armour",
                NewArmour( 0, "Bare Skin"),
                NewArmour( 1, "Cloth Robe"),
                NewArmour( 2, "Leather Tunic"),
                NewArmour( 3, "Light Mail"),
                NewArmour( 4, "Silver Ring"),
                NewArmour( 5, "Serpent Skin"),
                NewArmour( 6, "Dragon Hide"),
                NewArmour( 7, "Achilles"),
                NewArmour( 8, "Small Shield"),
                NewArmour( 9, "Large Shield"),
                NewArmour(10, "Leather Cap"),
                NewArmour(11, "Ogre Skull"),
                NewArmour(12, "Moe"),
                NewArmour(13, "Gauntlets"),
                NewArmour(14, "The Tortoise"),
                VTripleButton(GID_KEEF_BU13, GID_KEEF_BU3, GID_KEEF_BU14),
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window *) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

 /* not needed...
    gadmode = SERIALIZE_WRITE;
    more1eithergadgets(); */

    subloop();

    gadmode = SERIALIZE_READ;
    more1eithergadgets();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG keef_subgadget(ULONG gid, UNUSED UWORD code)
{   int i;

    switch (gid)
    {
    case GID_KEEF_BU3:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARMOURS; i++)
        {   if (armour[i])
            {   armour[i] = FALSE;
            } else
            {   armour[i] = TRUE;
        }   }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU4:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ITEMS; i++)
        {   if (item[i])
            {   item[i] = FALSE;
            } else
            {   item[i] = TRUE;
        }   }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU5:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARTIFACTS; i++)
        {   if (artifact[i])
            {   artifact[i] = FALSE;
            } else
            {   artifact[i] = TRUE;
        }   }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU9:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ITEMS; i++)
        {   item[i] = TRUE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU10:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ITEMS; i++)
        {   item[i] = FALSE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU11:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARTIFACTS; i++)
        {   artifact[i] = TRUE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU12:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARTIFACTS; i++)
        {   artifact[i] = FALSE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU13:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARMOURS; i++)
        {   armour[i] = TRUE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    acase GID_KEEF_BU14:
        gadmode = SERIALIZE_READ;
        more1eithergadgets();
        for (i = 0; i < ARMOURS; i++)
        {   armour[i] = FALSE;
        }
        gadmode = SERIALIZE_WRITE;
        more1eithergadgets();
    }

    return FALSE;
}

MODULE void more1eithergadgets(void)
{   int i;

    for (i = 0; i < ARMOURS; i++)
    {   subeither_cb(GID_KEEF_CB30 + i, &armour[i]);
    }
    for (i = 0; i < ARTIFACTS; i++)
    {   subeither_cb(GID_KEEF_CB84 + i, &artifact[i]);
    }
    for (i = 0; i < ITEMS; i++)
    {   subeither_cb(GID_KEEF_CB45 + i, &item[i]);
}   }

EXPORT FLAG keef_subkey(UWORD code)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    }

    return FALSE;
}

MODULE void more2window(void)
{   int i;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                      "Choose Spells/Reagents",
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                               "keef-2",
        WINDOW_ParentGroup,                            gadgets[GID_KEEF_LY3] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddHLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Spells",
                AddVLayout,
                    AddLabel("Bandus Aidus:"),
                    AddLabel("Flickus Bickus:"),
                    AddLabel("Emmus Exesus:"),
                    AddLabel("Nudus Bunsus:"),
                    AddLabel("Generus Elektus:"),
                    AddLabel("Huvius Vacuumus:"),
                    AddLabel("Cygnus Arcenus:"),
                    AddLabel("Agenus Oranus:"),
                    AddLabel("Riteus Gardus:"),
                    AddLabel("Makus Foodus:"),
                    AddLabel("Takus Tylenus:"),
                    AddLabel("Dranus Liqus:"),
                    AddLabel("Qnus Arudes:"),
                LayoutEnd,
                AddVLayout,
                    NewSpell( 0),
                    NewSpell( 1),
                    NewSpell( 2),
                    NewSpell( 3),
                    NewSpell( 4),
                    NewSpell( 5),
                    NewSpell( 6),
                    NewSpell( 7),
                    NewSpell( 8),
                    NewSpell( 9),
                    NewSpell(10),
                    NewSpell(11),
                    NewSpell(12),
                LayoutEnd,
                AddVLayout,
                    AddLabel("Napus Almus:"),
                    AddLabel("Mutus Omahaus:"),
                    AddLabel("Bigus Litus:"),
                    AddLabel("Goodas Newus:"),
                    AddLabel("Usus Carus:"),
                    AddLabel("Pizaus Coldus:"),
                    AddLabel("Olus Gayus:"),
                    AddLabel("Lyodus Londus:"),
                    AddLabel("Barbus Rubinus:"),
                    AddLabel("Killus Deadus:"),
                    AddLabel("Wastus Em!:"),
                    AddLabel("Phonus Homus:"),
                    AddLabel("Elmus Pastus:"),
                LayoutEnd,
                AddVLayout,
                    NewSpell(13),
                    NewSpell(14),
                    NewSpell(15),
                    NewSpell(16),
                    NewSpell(17),
                    NewSpell(18),
                    NewSpell(19),
                    NewSpell(20),
                    NewSpell(21),
                    NewSpell(22),
                    NewSpell(23),
                    NewSpell(24),
                    NewSpell(25),
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Reagents",
                AddVLayout,
                    AddLabel("Dragon's Drool:"),
                    AddLabel("Peppermint Sprigs:"),
                    AddLabel("Scorpion Tail:"),
                    AddLabel("Skank Juice:"), // :-)
                    AddLabel("Eye of Owl:"),
                    AddLabel("Rhino Horn:"),
                    AddLabel("Glow Grass:"),
                    AddLabel("Wart Weed:"),
                    AddLabel("Kiki Root:"),
                    AddLabel("Black Pearl:"),
                    AddLabel("Narcissus Root:"),
                    AddLabel("Phoenix Egg:"),
                LayoutEnd,
                AddVLayout,
                    NewReagent( 0),
                    NewReagent( 1),
                    NewReagent( 2),
                    NewReagent( 3),
                    NewReagent( 4),
                    NewReagent( 5),
                    NewReagent( 6),
                    NewReagent( 7),
                    NewReagent( 8),
                    NewReagent( 9),
                    NewReagent(10),
                    NewReagent(11),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window *) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    subloop();

    for (i = 0; i < REAGENTS; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_KEEF_IN41 + i], &reagent[i]);
    }
    for (i = 0; i < SPELLS; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_KEEF_IN15 + i], &spell[i]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}
