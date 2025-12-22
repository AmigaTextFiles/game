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
#define GID_DRA_LY1    0 // root layout
#define GID_DRA_SB1    1 // toolbar
#define GID_DRA_ST1    2 // name
#define GID_DRA_BU1    3 // maximize man
#define GID_DRA_BU2    4 // maximize party
#define GID_DRA_BU3    5 // invert selection
#define GID_DRA_LB1    6 // spells
#define GID_DRA_IN1    7 // 1st  skill
#define GID_DRA_IN2    8
#define GID_DRA_IN3    9
#define GID_DRA_IN4   10
#define GID_DRA_IN5   11
#define GID_DRA_IN6   12
#define GID_DRA_IN7   13
#define GID_DRA_IN8   14
#define GID_DRA_IN9   15
#define GID_DRA_IN10  16
#define GID_DRA_IN11  17
#define GID_DRA_IN12  18
#define GID_DRA_IN13  19
#define GID_DRA_IN14  20
#define GID_DRA_IN15  21
#define GID_DRA_IN16  22
#define GID_DRA_IN17  23
#define GID_DRA_IN18  24
#define GID_DRA_IN19  25
#define GID_DRA_IN20  26
#define GID_DRA_IN21  27
#define GID_DRA_IN22  28
#define GID_DRA_IN23  29
#define GID_DRA_IN24  30
#define GID_DRA_IN25  31
#define GID_DRA_IN26  32
#define GID_DRA_IN27  33 // 27th skill
#define GID_DRA_IN28  34 // cur str
#define GID_DRA_IN29  35 // max str
#define GID_DRA_IN30  36 // cur dex
#define GID_DRA_IN31  37 // max dex
#define GID_DRA_IN32  38 // cur int
#define GID_DRA_IN33  39 // max int
#define GID_DRA_IN34  40 // cur spr
#define GID_DRA_IN35  41 // max spr
#define GID_DRA_IN36  42 // cur health
#define GID_DRA_IN37  43 // max health
#define GID_DRA_IN38  44 // cur stun
#define GID_DRA_IN39  45 // max stun
#define GID_DRA_IN40  46 // cur power
#define GID_DRA_IN41  47 // max power
#define GID_DRA_IN42  48 // level
#define GID_DRA_IN43  49 // gp
#define GID_DRA_IN44  50 // experience
#define GID_DRA_IN45  51 // points
#define GID_DRA_IN46  52 // man
// GID_DRA_IN47 is spare
#define GID_DRA_ST2   53 // 1st  item name
#define GID_DRA_ST3   54
#define GID_DRA_ST4   55
#define GID_DRA_ST5   56
#define GID_DRA_ST6   57
#define GID_DRA_ST7   58
#define GID_DRA_ST8   59
#define GID_DRA_ST9   60
#define GID_DRA_ST10  61
#define GID_DRA_ST11  62
#define GID_DRA_ST12  63
#define GID_DRA_ST13  64 // 12th item name
#define GID_DRA_CB1   65 // 1st  item equipped
#define GID_DRA_CB2   66
#define GID_DRA_CB3   67
#define GID_DRA_CB4   68
#define GID_DRA_CB5   69
#define GID_DRA_CB6   70
#define GID_DRA_CB7   71
#define GID_DRA_CB8   72
#define GID_DRA_CB9   73
#define GID_DRA_CB10  74
#define GID_DRA_CB11  75
#define GID_DRA_CB12  76 // 12th item equipped
#define GID_DRA_IN48  77 // X-location
#define GID_DRA_IN49  78 // Y-location
#define GID_DRA_IN50  79 // 1st  item minimum
#define GID_DRA_IN51  80
#define GID_DRA_IN52  81
#define GID_DRA_IN53  82
#define GID_DRA_IN54  83
#define GID_DRA_IN55  84
#define GID_DRA_IN56  85
#define GID_DRA_IN57  86
#define GID_DRA_IN58  87
#define GID_DRA_IN59  88
#define GID_DRA_IN60  89
#define GID_DRA_IN61  90 // 12th item minimum
#define GID_DRA_CH1   91 // facing
#define GID_DRA_CH2   92 // 1st  item category
#define GID_DRA_CH3   93
#define GID_DRA_CH4   94
#define GID_DRA_CH5   95
#define GID_DRA_CH6   96
#define GID_DRA_CH7   97
#define GID_DRA_CH8   98
#define GID_DRA_CH9   99
#define GID_DRA_CH10 100
#define GID_DRA_CH11 101
#define GID_DRA_CH12 102
#define GID_DRA_CH13 103 // 12th item category
#define GID_DRA_BU4  104 // all
#define GID_DRA_BU5  105 // none
#define GIDS_DRA     GID_DRA_BU5

#define AddSkill(x)  LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 255, INTEGER_MinVisible, 3 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(int whichman);
MODULE void eithergadgets(int whichman);

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
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
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

MODULE ULONG                facing,
                            location_x,
                            location_y,
                            who = 0;
MODULE struct List          FacingList,
                            SpellsList;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .... .... .K.. ....    . = Transparent (%00)
    .... .... KWK. ....    W = White       (%01)
    .... ...K YYK. ....    K = Black       (%10)
    .... ..KY YK.. ....    Y = Yellow      (%11) ($CB0)
    .... .KYW K... ....
    ..KK KKYK YK.. ....
    .KWW YKKW WK.. ....
    .KYY WWKW KWK. ....
    .KWY KKKK WWK. ....
    .KYW YKKW WKWK ....
    .KYW YKKK WWYK ....
    KKYY YWWK KKK. ....
    KWKK YWWW YK.. ....
    KKWK KYYY K... ....
    .KKY YYKK .... ....
    ..KK KK.. .... ....

          Plane 1                Plane 0
    .... .... .K.. ....    .... .... .... ....
    .... .... K.K. ....    .... .... .W.. ....
    .... ...K YYK. ....    .... .... YY.. ....
    .... ..KY YK.. ....    .... ...Y Y... ....
    .... .KY. K... ....    .... ..YW .... ....
    ..KK KKYK YK.. ....    .... ..Y. Y... ....
    .K.. YKK. .K.. ....    ..WW Y..W W... ....
    .KYY ..K. K.K. ....    ..YY WW.W .W.. ....
    .K.Y KKKK ..K. ....    ..WY .... WW.. ....
    .KY. YKK. .K.K ....    ..YW Y..W W.W. ....
    .KY. YKKK ..YK ....    ..YW Y... WWY. ....
    KKYY Y..K KKK. ....    ..YY YWW. .... ....
    K.KK Y... YK.. ....    .W.. YWWW Y... ....
    KK.K KYYY K... ....    ..W. .YYY .... ....
    .KKY YYKK .... ....    ...Y YY.. .... ....
    ..KK KK.. .... ....    .... .... .... ....
      Yellow & blacK         Yellow & White

    Plane 1 Plane 0 */
    0x0040, 0x0000,
    0x00A0, 0x0040,
    0x01E0, 0x00C0,
    0x03C0, 0x0180,
    0x0680, 0x0300,
    0x3FC0, 0x0280,
    0x4E40, 0x3980,
    0x72A0, 0x3D40,
    0x5F20, 0x30C0,
    0x6E50, 0x39A0,
    0x6F30, 0x38E0,
    0xF9E0, 0x3E00,
    0xB8C0, 0x4F80,
    0xDF80, 0x2700,
    0x7F00, 0x1C00,
    0x3C00, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

MODULE const STRPTR CategoryOptions[27 + 1] = {
"General item",           //  0
"Shield",
"Full shield",
"Axe",
"Flail",
"Sword",                  //  5
"2-handed sword",
"Mace",
"Bow",
"Crossbow",
"Gun",                    // 10
"Thrown weapon",
"Ammunition",
"Gloves",
"Mage gloves",
"Ammo clip",              // 15
"Cloth armour",
"Leather armour",
"Cuir bouilli armr",
"Brigandine armour",
"Scale armour",           // 20
"Chain armour",
"Plate & chain armr",
"Full plate armour",
"Helmet",
"Scroll",                 // 25
"Pair of boots",          // 26
NULL                      // 27
}, FacingOptions[4] = {
"North",
"East",
"South",
"West"
}, SpellNames[61] = {
"Mage Fire",         // $3C bit 7 (Low)
"Disarm",            // $3C bit 6 (Low)
"Charm",             // $3C bit 5 (Low)
"Luck",              // $3C bit 4 (Low)
"Lesser Heal",       // $3C bit 3 (Low)
"Mage Light",        // $3C bit 2 (Low)
"Fire Light",        // $3C bit 1 (High)
"Elvar's Fire",      // $3C bit 0 (High)
"Poog's Vortex",     // $3D bit 7 (High)
"Ice Chill",         // $3D bit 6 (High)
"Big Chill",         // $3D bit 5 (High)
"Dazzle",            // $3D bit 4 (High)
"Mystic Might",      // $3D bit 3 (High)
"Reveal Glamour",    // $3D bit 2 (High)
"Sala's Swift",      // $3D bit 1 (High)
"Vorn's Guard",      // $3D bit 0 (High)
"Cowardice",         // $3E bit 7 (High)
"Healing",           // $3E bit 6 (High)
"Group Heal",        // $3E bit 5 (High)
"Cloak Arcane",      // $3E bit 4 (High)
"Sense Traps",       // $3E bit 3 (High)
"Air Summon",        // $3E bit 2 (High)
"Earth Summon",      // $3E bit 1 (High)
"Water Summon",      // $3E bit 0 (High)
"Fire Summon",       // $3F bit 7 (High)
"Death Curse",       // $3F bit 6 (Druid)
"Fire Blast",        // $3F bit 5 (Druid)
"Insect Plague",     // $3F bit 4 (Druid)
"Whirl Wind",        // $3F bit 3 (Druid)
"Scare",             // $3F bit 2 (Druid)
"Brambles",          // $3F bit 1 (Druid)
"Greater Healing",   // $3F bit 0 (Druid)
"Cure All",          // $40 bit 7 (Druid)
"Create Wall",       // $40 bit 6 (Druid)
"Soften Stone",      // $40 bit 5 (Druid)
"Invoke Spirit",     // $40 bit 4 (Druid)
"Beast Call",        // $40 bit 3 (Druid)
"Wood Spirit",       // $40 bit 2 (Druid)
"Sun Stroke",        // $40 bit 1 (Sun)
"Exorcism",          // $40 bit 0 (Sun)
"Rage of Mithras",   // $41 bit 7 (Sun)
"Wrath of Mithras",  // $41 bit 6 (Sun)
"Fire Storm",        // $41 bit 5 (Sun)
"Inferno",           // $41 bit 4 (Sun)
"Holy Aim",          // $41 bit 3 (Sun)
"Battle Power",      // $41 bit 2 (Sun)
"Column of Fire",    // $41 bit 1 (Sun)
"Mithras' Bless",    // $41 bit 0 (Sun)
"Light Flash",       // $42 bit 7 (Sun)
"Armour of Light",   // $42 bit 6 (Sun)
"Sun Light",         // $42 bit 5 (Sun)
"Heal",              // $42 bit 4 (Sun)
"Major Healing",     // $42 bit 3 (Sun)
"Disarm Trap",       // $42 bit 2 (Sun)
"Guidance",          // $42 bit 1 (Sun)
"Radiance",          // $42 bit 0 (Sun)
"Summon Salamander", // $43 bit 7 (Sun)
"Charger",           // $43 bit 6 (Sun)
"Zak's Speed",       // $43 bit 5 (Other)
"Kill Ray",          // $43 bit 4 (Other)
"Prison"             // $43 bit 3 (Other)
// no NULL is required
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG curstr,
          maxstr,
          curdex,
          maxdex,
          curint,
          maxint,
          curspr,
          maxspr,
          curhp,
          maxhp,
          curstun,
          maxstun,
          curpower,
          maxpower,
          equipped[12],
          gp,
          itemcat[12],
          itemmin[12],
          skill[27],
          spell[61],
          points,
          level,
          xp;
    TEXT  itemname[12][12 + 1],
          name[12 + 1];
} man[7];

// 8. CODE ---------------------------------------------------------------

EXPORT void dra_main(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* NodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // dra_preinit()
        NewList(&SpellsList);
        NewList(&FacingList);

        // dra_init()
        for (i = 0; i < 61; i++)
        {   NodePtr = (struct Node*) AllocListBrowserNode
            (   1,
                LBNCA_Text,    SpellNames[i],
                LBNA_CheckBox, TRUE,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList, NodePtr);
    }   }

    tool_open  = dra_open;
    tool_loop  = dra_loop;
    tool_save  = dra_save;
    tool_close = dra_close;
    tool_exit  = dra_exit;

    if (loaded != FUNC_DRA && !dra_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_DRA;

    make_speedbar_list(GID_DRA_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                             TRUE,
        WA_ThinSizeGadget,                                         TRUE,
        WINDOW_Position,                                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                        gadgets[GID_DRA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                     TRUE,
            LAYOUT_SpaceInner,                                     TRUE,
            LAYOUT_DeferLayout,                                    TRUE,
            AddHLayout,
                AddToolbar(GID_DRA_SB1),
                AddSpace,
                CHILD_WeightedWidth,                               50,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                    MaximizeButton(GID_DRA_BU2, "Maximize Party"),
                    CHILD_WeightedHeight,                          0,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                LayoutEnd,
                CHILD_WeightedWidth,                               0,
                AddSpace,
                CHILD_WeightedWidth,                               50,
            LayoutEnd,
            CHILD_WeightedHeight,                                  0,
            AddHLayout,
                LAYOUT_VertAlignment,                              LALIGN_CENTER,
                AddLabel("Character #:"),
                LAYOUT_AddChild,                                   gadgets[GID_DRA_IN46] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                         GID_DRA_IN46,
                    GA_RelVerify,                                  TRUE,
                    GA_TabCycle,                                   TRUE,
                    INTEGER_Minimum,                               1,
                    INTEGER_Maximum,                               7,
                    INTEGER_Number,                                who + 1,
                    INTEGER_MinVisible,                            1 + 1,
                IntegerEnd,
                AddLabel("of 7"),
            LayoutEnd,
            CHILD_WeightedHeight,                                  0,
            AddVLayout,
                LAYOUT_BevelStyle,                                 BVS_GROUP,
                LAYOUT_SpaceOuter,                                 TRUE,
                LAYOUT_Label,                                      "Character",
                AddHLayout,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "General",
                            AddVLayout,
                                LAYOUT_VertAlignment,              LALIGN_CENTER,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST1] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST1,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].name,
                                    STRINGA_MaxChars,              12 + 1,
                                StringEnd,
                                Label("Name:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN36] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN36,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN37] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN37,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Health:"),
                                CHILD_WeightedHeight,              0,
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN38] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN38,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN39] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN39,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Stun:"),
                                CHILD_WeightedHeight,              0,
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN40] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN40,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN41] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN41,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           65535,
                                        INTEGER_MinVisible,        5 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Power:"),
                                CHILD_WeightedHeight,              0,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN42] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN42,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               65535,
                                    INTEGER_MinVisible,            5 + 1,
                                IntegerEnd,
                                Label("Level:"),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN43] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN43,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               0x7FFFFFFF,
                                    INTEGER_MinVisible,            10 + 1,
                                IntegerEnd,
                                Label("Gold Pieces:"),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN44] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN44,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               0x7FFFFFFF,
                                    INTEGER_MinVisible,            10 + 1,
                                IntegerEnd,
                                Label("Experience:"),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN45] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN45,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                Label("Points:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                        AddVLayout,
                            LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Attributes",
                            AddVLayout,
                                LAYOUT_VertAlignment,              LALIGN_CENTER,
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN28] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN28,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_MinVisible,        3 + 1,
                                        INTEGER_Maximum,           255,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN29] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN29,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Strength:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN30] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN30,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN31] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN31,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Dexterity:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN32] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN32,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN33] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN33,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Intelligence:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN34] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN34,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_DRA_IN35] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_DRA_IN35,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           255,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Spirit:"),
                            LayoutEnd,
                            CHILD_WeightedHeight,                  0,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                        AddHLayout,
                            LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Skills",
                            AddVLayout,
                                AddLabel("Arcane Lore:"),
                                AddLabel("Cave Lore:"),
                                AddLabel("Forest Lore:"),
                                AddLabel("Mntn Lore:"),
                                AddLabel("Town Lore:"),
                                AddLabel("Bandage:"),
                                AddLabel("Climb:"),
                                AddLabel("Fistfighting:"),
                                AddLabel("Hiding:"),
                                AddLabel("Lockpick:"),
                                AddLabel("Pickpocket:"),
                                AddLabel("Swim:"),
                                AddLabel("Tracker:"),
                                AddLabel("Bureaucracy:"),
                            LayoutEnd,
                            AddVLayout,
                                AddSkill(GID_DRA_IN1),
                                AddSkill(GID_DRA_IN2),
                                AddSkill(GID_DRA_IN3),
                                AddSkill(GID_DRA_IN4),
                                AddSkill(GID_DRA_IN5),
                                AddSkill(GID_DRA_IN6),
                                AddSkill(GID_DRA_IN7),
                                AddSkill(GID_DRA_IN8),
                                AddSkill(GID_DRA_IN9),
                                AddSkill(GID_DRA_IN10),
                                AddSkill(GID_DRA_IN11),
                                AddSkill(GID_DRA_IN12),
                                AddSkill(GID_DRA_IN13),
                                AddSkill(GID_DRA_IN14),
                            LayoutEnd,
                            AddVLayout,
                                AddLabel("Druid Magic:"),
                                AddLabel("High Magic:"),
                                AddLabel("Low Magic:"),
                                AddLabel("Merchant:"),
                                AddLabel("Sun Magic:"),
                                AddLabel("Axes:"),
                                AddLabel("Flails:"),
                                AddLabel("Maces:"),
                                AddLabel("Swords:"),
                                AddLabel("2-Handers:"),
                                AddLabel("Bows:"),
                                AddLabel("Crossbows:"),
                                AddLabel("Thrown Wpns:"),
                            LayoutEnd,
                            AddVLayout,
                                AddSkill(GID_DRA_IN15),
                                AddSkill(GID_DRA_IN16),
                                AddSkill(GID_DRA_IN17),
                                AddSkill(GID_DRA_IN18),
                                AddSkill(GID_DRA_IN19),
                                AddSkill(GID_DRA_IN20),
                                AddSkill(GID_DRA_IN21),
                                AddSkill(GID_DRA_IN22),
                                AddSkill(GID_DRA_IN23),
                                AddSkill(GID_DRA_IN24),
                                AddSkill(GID_DRA_IN25),
                                AddSkill(GID_DRA_IN26),
                                AddSkill(GID_DRA_IN27),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                           0,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Items",
                            AddVLayout,
                                AddLabel(""),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB1] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB1,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB2] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB2,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB3] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB3,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB4] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB4,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB5] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB5,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB6] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB6,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB7] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB7,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB8] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB8,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB9] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB9,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB10] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB10,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB11] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB11,
                                End,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CB12] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_DRA_CB12,
                                End,
                            LayoutEnd,
                            CHILD_WeightedWidth,                   0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                                AddLabel("Name"),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST2] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST2,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[0],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST3] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST3,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[1],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST4] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST4,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[2],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST5] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST5,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[3],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST6] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST6,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[4],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST7] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST7,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[5],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST8] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST8,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[6],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST9] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST9,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[7],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST10] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST10,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[8],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST11] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST11,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[9],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST12] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST12,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[10],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_ST13] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                         GID_DRA_ST13,
                                    GA_TabCycle,                   TRUE,
                                    STRINGA_TextVal,               man[who].itemname[11],
                                    STRINGA_MaxChars,              12 + 1,
                                    STRINGA_MinVisible,            12 + stringextra,
                                StringEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,                   0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                                AddLabel("Type"),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH2] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH2,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH3] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH3,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH4] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH4,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH5] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH5,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH6] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH6,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH7] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH7,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH8] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH8,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH9] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH9,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH10] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH10,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH11] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH11,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH12] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH12,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_CH13] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                         GID_DRA_CH13,
                                    CHOOSER_LabelArray,            CategoryOptions,
                                    CHOOSER_MaxLabels,             27,
                                PopUpEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,                   0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                                AddLabel("Min."),
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN50] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN50,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN51] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN51,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN52] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN52,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN53] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN53,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN54] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN54,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN55] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN55,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN56] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN56,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN57] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN57,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN58] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN58,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN59] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN59,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN60] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN60,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,                   gadgets[GID_DRA_IN61] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                         GID_DRA_IN61,
                                    GA_TabCycle,                   TRUE,
                                    INTEGER_Minimum,               0,
                                    INTEGER_Maximum,               255,
                                    INTEGER_MinVisible,            3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                        AddVLayout,
                            LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Spells",
                            LAYOUT_AddChild,                       gadgets[GID_DRA_LB1] = (struct Gadget*)
                            ListBrowserObject,
                                GA_ID,                             GID_DRA_LB1,
                                GA_RelVerify,                      TRUE,
                                LISTBROWSER_Labels,                (ULONG) &SpellsList,
                                LISTBROWSER_ShowSelected,          TRUE,
                                LISTBROWSER_AutoWheel,             FALSE,
                            ListBrowserEnd,
                            HTripleButton(GID_DRA_BU4, GID_DRA_BU3, GID_DRA_BU5),
                        LayoutEnd,
                    LayoutEnd,
                LayoutEnd,
                MaximizeButton(GID_DRA_BU1, "Maximize Character"),
               CHILD_WeightedHeight,                               0,
            LayoutEnd,
            AddHLayout,
                LAYOUT_BevelStyle,                                 BVS_GROUP,
                LAYOUT_SpaceOuter,                                 TRUE,
                LAYOUT_Label,                                      "Location",
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                    LAYOUT_AddChild,                               gadgets[GID_DRA_IN48] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                     GID_DRA_IN48,
                        GA_TabCycle,                               TRUE,
                        INTEGER_Minimum,                           0,
                        INTEGER_Maximum,                           255,
                        INTEGER_MinVisible,                        3 + 1,
                    IntegerEnd,
                    Label("X:"),
                    CHILD_WeightedHeight,                          0,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                LayoutEnd,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                    LAYOUT_AddChild,                               gadgets[GID_DRA_IN49] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                     GID_DRA_IN49,
                        GA_TabCycle,                               TRUE,
                        INTEGER_Minimum,                           0,
                        INTEGER_Maximum,                           255,
                        INTEGER_MinVisible,                        3 + 1,
                    IntegerEnd,
                    Label("Y:"),
                    CHILD_WeightedHeight,                          0,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                LayoutEnd,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                    LAYOUT_AddChild,                               gadgets[GID_DRA_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                     GID_DRA_CH1,
                        CHOOSER_Labels,                            &FacingList,
                    PopUpEnd,
                    Label("Facing:"),
                    CHILD_WeightedHeight,                          0,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                                  0,
        LayoutEnd,
        CHILD_NominalSize,                                         TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_DRA_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_DRA_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_DRA_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void dra_loop(ULONG gid, UNUSED ULONG code)
{   int i,
        whichman;

    switch (gid)
    {
    case GID_DRA_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_DRA_BU2:
        readgadgets();
        for (whichman = 0; whichman < 7; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
    acase GID_DRA_BU3:
        readgadgets();
        for (i = 0; i < 61; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = 0;
            } else
            {   man[who].spell[i] = 1;
        }   }
        writegadgets();
    acase GID_DRA_BU4:
        readgadgets();
        for (i = 0; i < 61; i++)
        {   man[who].spell[i] = 1;
        }
        writegadgets();
    acase GID_DRA_BU5:
        readgadgets();
        for (i = 0; i < 61; i++)
        {   man[who].spell[i] = 0;
        }
        writegadgets();
    acase GID_DRA_IN46:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_DRA_IN46], (ULONG*) &who);
        who--;
        writegadgets();
}   }

EXPORT FLAG dra_open(FLAG loadas)
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
    (   page != FUNC_DRA
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets(who);
}

MODULE void eithergadgets(int whichman)
{   int          i;
    struct Node* NodePtr;

    either_st(GID_DRA_ST1, man[whichman].name);
    for (i = 0; i < 12; i++)
    {   either_st(GID_DRA_ST2, man[whichman].itemname[i]);
    }

    if (gadmode == SERIALIZE_READ)
    {   i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man[whichman].spell[i]);
            i++;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);
        DISCARD SetGadgetAttrs(gadgets[GID_DRA_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                  TAG_END);
        i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[whichman].spell[i], TAG_END);
            i++;
        }
        DISCARD SetGadgetAttrs(gadgets[GID_DRA_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_DRA_LB1], MainWindowPtr, NULL);
    }

    for (i = 0; i < 27; i++)
    {   either_in(GID_DRA_IN1  + i, &man[whichman].skill[i]);
    }
    for (i = 0; i < 12; i++)
    {   either_cb(GID_DRA_CB1  + i, &man[whichman].equipped[i]);
        either_in(GID_DRA_IN50 + i, &man[whichman].itemmin[i]);
        either_ch(GID_DRA_CH2  + i, &man[whichman].itemcat[i]);
    }
    either_in(GID_DRA_IN28, &man[whichman].curstr);
    either_in(GID_DRA_IN29, &man[whichman].maxstr);
    either_in(GID_DRA_IN30, &man[whichman].curdex);
    either_in(GID_DRA_IN31, &man[whichman].maxdex);
    either_in(GID_DRA_IN32, &man[whichman].curint);
    either_in(GID_DRA_IN33, &man[whichman].maxint);
    either_in(GID_DRA_IN34, &man[whichman].curspr);
    either_in(GID_DRA_IN35, &man[whichman].maxspr);
    either_in(GID_DRA_IN36, &man[whichman].curhp);
    either_in(GID_DRA_IN37, &man[whichman].maxhp);
    either_in(GID_DRA_IN38, &man[whichman].curstun);
    either_in(GID_DRA_IN39, &man[whichman].maxstun);
    either_in(GID_DRA_IN40, &man[whichman].curpower);
    either_in(GID_DRA_IN41, &man[whichman].maxpower);
    either_in(GID_DRA_IN42, &man[whichman].level);
    either_in(GID_DRA_IN43, &man[whichman].gp);
    either_in(GID_DRA_IN44, &man[whichman].xp);
    either_in(GID_DRA_IN45, &man[whichman].points);

    either_in(GID_DRA_IN48, &location_x);
    either_in(GID_DRA_IN49, &location_y);
    either_ch(GID_DRA_CH1 , &facing);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets(who);
}

MODULE void serialize(void)
{   int i, j,
        length,
        whichman;

    for (whichman = 0; whichman < 7; whichman++)
    {   offset = 0x200 * whichman;

        if (serializemode == SERIALIZE_READ)
        {   zstrncpy(man[whichman].name, (char*) &IOBuffer[offset], 12); //  0..11
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);

            length = strlen(man[whichman].name);
            if (length >= 2)
            {   for (i = 0; i < length - 1; i++)
                {   man[whichman].name[i] |= 0x80;
            }   }
            strncpy((char*) &IOBuffer[offset], man[whichman].name, 12);
            // *not* zstrncpy() because we don't want to NUL-terminate it!
        }
        for (j = 0; j < 12; j++)
        {   if (man[whichman].name[j] >= 0x80)
            {   man[whichman].name[j] -= 0x80;
            } else
            {   man[whichman].name[j + 1] = EOS;
                break;
        }   }

        offset = (0x200 * whichman) + 0x0C;
        serialize1(&man[whichman].curstr);        // $0C
        serialize1(&man[whichman].maxstr);        // $0D
        serialize1(&man[whichman].curdex);        // $0E
        serialize1(&man[whichman].maxdex);        // $0F
        serialize1(&man[whichman].curint);        // $10
        serialize1(&man[whichman].maxint);        // $11
        serialize1(&man[whichman].curspr);        // $12
        serialize1(&man[whichman].maxspr);        // $13
        serialize2ilong(&man[whichman].curhp);    // $14..$15
        serialize2ilong(&man[whichman].maxhp);    // $16..$17
        serialize2ilong(&man[whichman].curstun);  // $18..$19
        serialize2ilong(&man[whichman].maxstun);  // $1A..$1B
        serialize2ilong(&man[whichman].curpower); // $1C..$1D
        serialize2ilong(&man[whichman].maxpower); // $1E..$1F
        for (i = 0; i < 27; i++)
        {   serialize1(&man[whichman].skill[i]);  // $20..$3A
        }
        serialize1(&man[whichman].points);        // $3B

        // assert(offset % 0x200 == 0x3C);
        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 61; i++)
            {   man[whichman].spell[i] = (IOBuffer[offset + (i / 8)] & (0x80 >> (i % 8))) ? 1 : 0;
        }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);
            for (i = 0; i < 61; i++)
            {   if (i % 8 == 0)
                {   IOBuffer[offset + (i / 8)] = 0; // we shouldn't really clear bits 2..0 of $43
                }
                IOBuffer[offset + (i / 8)] |= (man[whichman].spell[i] * 0x80) >> (i % 8);
        }   }

        offset = (0x200 * whichman) + 0x4F;
        serialize2ilong(&man[whichman].level);    // $4F..$50
        serialize4i(&man[whichman].xp);           // $51..$54
        serialize4i(&man[whichman].gp);           // $55..$58

        for (i = 0; i < 12; i++)
        {   offset = (0x200 * whichman) + 0xEC + (0x17 * i);

            if (man[whichman].equipped[i])
            {   man[whichman].equipped[i] = 0x80;
            }
            serialize1(&man[whichman].equipped[i]); // $EC
            if (man[whichman].equipped[i])
            {   man[whichman].equipped[i] = 1;
            }

            offset = (0x200 * whichman) + 0xEE + (0x17 * i);
            serialize1(&man[whichman].itemmin[i]);  // $EE

            offset = (0x200 * whichman) + 0xF1 + (0x17 * i);
            serialize1(&man[whichman].itemcat[i]);  // $F1

            offset = (0x200 * whichman) + 0xF7 + (0x17 * i);

            if (serializemode == SERIALIZE_READ)
            {   zstrncpy(man[whichman].itemname[i], (char*) &IOBuffer[offset], 12); //  0..11
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);

                length = strlen(man[whichman].itemname[i]);
                if (length >= 2)
                {   for (j = 0; j < length - 1; j++)
                    {   man[whichman].itemname[i][j] |= 0x80;
                }   }
                strncpy((char*) &IOBuffer[offset], man[whichman].itemname[i], 12);
                // *not* zstrncpy() because we don't want to NUL-terminate it!
            }
            for (j = 0; j < 12; j++)
            {   if (man[whichman].itemname[i][j] >= 0x80)
                {   man[whichman].itemname[i][j] -= 0x80;
                } else
                {   man[whichman].itemname[i][j + 1] = EOS;
                    break;
    }   }   }   }

    offset = 0xE00;
    serialize1(&location_x); // $E00
    serialize1(&location_y); // $E01
    serialize1(&facing);     // $E02
}

EXPORT void dra_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?.dwgame", "Dragon Wars", saveas, 12014, FLAG_S, FALSE);
}

EXPORT void dra_die(void)
{   lb_clearlist(&SpellsList);
}

EXPORT void dra_close(void) { ; }

EXPORT void dra_exit(void)
{   ch_clearlist(&FacingList);
}

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].curstr    = man[whichman].maxstr    =
    man[whichman].curdex    = man[whichman].maxdex    =
    man[whichman].curint    = man[whichman].maxint    =
    man[whichman].curspr    = man[whichman].maxspr    =
    man[whichman].points                              =        200;
    man[whichman].curhp     = man[whichman].maxhp     =
    man[whichman].curstun   = man[whichman].maxstun   =
    man[whichman].curpower  = man[whichman].maxpower  =
    man[whichman].level                               =      65000;
    man[whichman].gp                                  =
    man[whichman].xp                                  = 1000000000;

    for (i = 0; i < 27; i++)
    {   man[whichman].skill[i] = 250;
    }
    for (i = 0; i < 61; i++)
    {   man[whichman].spell[i] =   1;
}   }

EXPORT void dra_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_DRA_LB1, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_DRA_LB1, MainWindowPtr, qual);
}   }
