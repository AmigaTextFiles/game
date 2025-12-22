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

#define GID_WIZ_LY1    0 // root layout
#define GID_WIZ_SB1    1 // toolbar
#define GID_WIZ_ST1    2 // name
#define GID_WIZ_BU1    3 // maximize man
#define GID_WIZ_BU2    4 // maximize party
#define GID_WIZ_BU3    5 // invert selection
#define GID_WIZ_LB1    6 // spells
#define GID_WIZ_IN1    7 // 1st  skill
#define GID_WIZ_IN2    8
#define GID_WIZ_IN3    9
#define GID_WIZ_IN4   10
#define GID_WIZ_IN5   11
#define GID_WIZ_IN6   12
#define GID_WIZ_IN7   13
#define GID_WIZ_IN8   14
#define GID_WIZ_IN9   15
#define GID_WIZ_IN10  16
#define GID_WIZ_IN11  17
#define GID_WIZ_IN12  18
#define GID_WIZ_IN13  19
#define GID_WIZ_IN14  20
#define GID_WIZ_IN15  21
#define GID_WIZ_IN16  22
#define GID_WIZ_IN17  23
#define GID_WIZ_IN18  24
#define GID_WIZ_IN19  25
#define GID_WIZ_IN20  26
#define GID_WIZ_IN21  27
#define GID_WIZ_IN22  28
#define GID_WIZ_IN23  29
#define GID_WIZ_IN24  30
#define GID_WIZ_IN25  31
#define GID_WIZ_IN26  32
#define GID_WIZ_IN27  33
#define GID_WIZ_IN28  34
#define GID_WIZ_IN29  35
#define GID_WIZ_IN30  36 // 30th skill
#define GID_WIZ_IN31  37 // str
#define GID_WIZ_IN32  38 // iq
#define GID_WIZ_IN33  39 // pie
#define GID_WIZ_IN34  40 // vit
#define GID_WIZ_IN35  41 // dex
#define GID_WIZ_IN36  42 // spd
#define GID_WIZ_IN37  43 // per
#define GID_WIZ_IN38  44 // kar
#define GID_WIZ_IN39  45 // cur hit points
#define GID_WIZ_IN40  46 // max hit points
#define GID_WIZ_IN41  47 // cur stamina
#define GID_WIZ_IN42  48 // max stamina
#define GID_WIZ_IN43  49 // level
#define GID_WIZ_IN44  50 // gp
#define GID_WIZ_IN45  51 // experience
#define GID_WIZ_IN46  52 // man
#define GID_WIZ_IN47  53 // men
#define GID_WIZ_IN48  54 // body count
#define GID_WIZ_IN49  55 // rebirths
#define GID_WIZ_IN50  56 // cur fire
#define GID_WIZ_IN51  57 // max fire
#define GID_WIZ_IN52  58 // cur water
#define GID_WIZ_IN53  59 // max water
#define GID_WIZ_IN54  60 // cur air
#define GID_WIZ_IN55  61 // max air
#define GID_WIZ_IN56  62 // cur earth
#define GID_WIZ_IN57  63 // max earth
#define GID_WIZ_IN58  64 // cur mental
#define GID_WIZ_IN59  65 // max mental
#define GID_WIZ_IN60  66 // cur magic
#define GID_WIZ_IN61  67 // max magic
#define GID_WIZ_IN62  68 // rank
#define GID_WIZ_IN63  69 // portrait
#define GID_WIZ_CH1   70 // class
#define GID_WIZ_CH2   71 // race
#define GID_WIZ_CH3   72 // sex
#define GID_WIZ_CB1   73 // asleep
#define GID_WIZ_CB2   74 // blind
#define GID_WIZ_BU4   75 // all
#define GID_WIZ_BU5   76 // none
#define GIDS_WIZ      GID_WIZ_BU5

#define AddSkill(x)   LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 255, INTEGER_MinVisible, 3 + 1, IntegerEnd

#define SKILLS        30

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

MODULE ULONG                men,
                            who;
MODULE struct List          SpellsList;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  KKKK KKKK K... ....    . = Transparent (%00)
    KYYY YYYY K... ....    R = Red         (%01) ($A00)
    KYRR RRYR K... ....    K = Black       (%10) ($000)
    KYYR RYRK .... ....    Y = Yellow      (%11) ($FF5)
    KYRR YYKK .... ....
    KYRY YYRK K... ....
    KYYR KYYR KK.. ....
    KYRK KKYY RKK. ....
    KKK. .KKY YRKK ....
    .... ..KK YYRK ....
    .... ...K KYKK ....
    .... .... KKK. ....

          Plane 1                Plane 0
    KKKK KKKK K... ....    .... .... .... ....
    KYYY YYYY K... ....    .YYY YYYY .... ....
    KY.. ..Y. K... ....    .YRR RRYR .... .... 
    KYY. .Y.K .... ....    .YYR RYR. .... ....
    KY.. YYKK .... ....    .YRR YY.. .... ....
    KY.Y YY.K K... ....    .YRY YYR. .... ....
    KYY. KYY. KK.. ....    .YYR .YYR .... ....
    KY.K KKYY .KK. ....    .YR. ..YY R... ....
    KKK. .KKY Y.KK ....    .... ...Y YR.. ....
    .... ..KK YY.K ....    .... .... YYR. ....
    .... ...K KYKK ....    .... .... .Y.. ....
    .... .... KKK. ....    .... .... .... ....
      Yellow & blacK          Yellow & Red

    Plane 1 Plane 0 */
    0xFF80, 0x0000,
    0xFF80, 0x7F00,
    0xC280, 0x7F00,
    0xE500, 0x7E00,
    0xCF00, 0x7C00,
    0xDD80, 0x7E00,
    0xEEC0, 0x7700,
    0xDF60, 0x6380,
    0xE7B0, 0x01C0,
    0x03D0, 0x00E0,
    0x01F0, 0x0040,
    0x00E0, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

MODULE const STRPTR ClassNames[14 + 1] = {
"Fighter",         //  0
"Mage",            //  1
"Priest",          //  2
"Thief",           //  3
"Ranger",          //  4
"Alchemist",       //  5
"Bard",            //  6
"Psionic",         //  7
"Valkyrie",        //  8
"Bishop",          //  9
"Lord",            // 10
"Samurai",         // 11
"Monk",            // 12
"Ninja",           // 13
NULL               // 14
}, RaceNames[11 + 1] = {
"Human",           //  0
"Elf",             //  1
"Dwarf",           //  2
"Gnome",           //  3
"Hobbit",          //  4
"Faerie",          //  5
"Lizardman",       //  6
"Dracon",          //  7
"Felpurr",         //  8
"Rawulf",          //  9
"Mook",            // 10
NULL               // 11
}, SpellNames[80] = {
"Energy Blast",    //  0 $188 bit 0 Fire
"Blinding Flash",  //  1 $188 bit 1 Fi
"Fireball",        //  2 $188 bit 2 Fi
"Fire Shield",     //  3 $188 bit 3 Fi
"Fire Bomb",       //  4 $188 bit 4 Fi
"Lightning",       //  5 $188 bit 5 Fi
"Prismic Missile", //  6 $188 bit 6 Fi
"Firestorm",       //  7 $188 bit 7 Fi
"Nuclear Blast",   //  8 $189 bit 0 Fi
"Chilling Touch",  //  9 $189 bit 1 Water
"Stamina",         // 10 $189 bit 2 Wa
"Terror",          // 11 $189 bit 3 Wa
"Weaken",          // 12 $189 bit 4 Wa
"Slow",            // 13 $189 bit 5 Wa
"Haste",           // 14 $189 bit 6 Wa
"Cure Paralysis",  // 15 $189 bit 7 Wa
"Ice Shield",      // 16 $18A bit 0 Wa
"Iceball",         // 17 $18A bit 1 Wa
"Paralyze",        // 18 $18A bit 2 Wa
"Deep Freeze",     // 19 $18A bit 3 Wa
"Poison",          // 20 $18A bit 4 Air
"Missile Shield",  // 21 $18A bit 5 Ai
"Stink Bomb",      // 22 $18A bit 6 Ai
"Air Pocket",      // 23 $18A bit 7 Ai
"Silence",         // 24 $18B bit 0 Ai
"Poison Gas",      // 25 $18B bit 1 Ai
"Cure Poison",     // 26 $18B bit 2 Ai
"Whirlwind",       // 27 $18B bit 3 Ai
"Purify Air",      // 28 $18B bit 4 Ai
"Deadly Poison",   // 29 $18B bit 5 Ai
"Levitate",        // 30 $18B bit 6 Ai
"Toxic Vapours",   // 31 $18B bit 7 Ai
"Noxious Fumes",   // 32 $18C bit 0 Ai
"Asphyxiation",    // 33 $18C bit 1 Ai
"Deadly Air",      // 34 $18C bit 2 Ai
"Acid Splash",     // 35 $18C bit 3 Earth
"Itching Skin",    // 36 $18C bit 4 Ea
"Armour Shield",   // 37 $18C bit 5 Ea
"Direction",       // 38 $18C bit 6 Ea
"Knock-Knock",     // 39 $18C bit 7 Ea
"Blades",          // 40 $18D bit 0 Ea
"Armourplate",     // 41 $18D bit 1 Ea
"Web",             // 42 $18D bit 2 Ea
"Acid Bomb",       // 43 $18D bit 3 Ea
"Armourmelt",      // 44 $18D bit 4 Ea
"Create Life",     // 45 $18D bit 5 Ea
"Cure Stone",      // 46 $18D bit 6 Ea
"Mental Attack",   // 47 $18D bit 7 Mental
"Sleep",           // 48 $18E bit 0 Me
"Bless",           // 49 $18E bit 1 Me
"Charm",           // 50 $18E bit 2 Me
"Cure Lesser Cnd", // 51 $18E bit 3 Me
"Divine Trap",     // 52 $18E bit 4 Me
"Detect Secret",   // 53 $18E bit 5 Me
"Identify",        // 54 $18E bit 6 Me
"Hold Monsters",   // 55 $18E bit 7 Me
"Mindread",        // 56 $18F bit 0 Me
"Sane Mind",       // 57 $18F bit 1 Me
"Psionic Blast",   // 58 $18F bit 2 Me
"Illusion",        // 59 $18F bit 3 Me
"Wizard Eye",      // 60 $18F bit 4 Me
"Death",           // 61 $18F bit 5 Me
"Locate Object",   // 62 $18F bit 6 Me
"Mind Flay",       // 63 $18F bit 7 Me
"Heal Wounds",     // 64 $190 bit 0 Magic
"Make Wounds",     // 65 $190 bit 1 Ma
"Magic Missile",   // 66 $190 bit 2 Ma
"Dispel Undead",   // 67 $190 bit 3 Ma
"Enchanted Blade", // 68 $190 bit 4 Ma
"Blink",           // 69 $190 bit 5 Ma
"Magic Screen",    // 70 $190 bit 6 Ma
"Conjuration",     // 71 $190 bit 7 Ma
"Anti-Magic",      // 72 $191 bit 0 Ma
"Remove Curse",    // 73 $191 bit 1 Ma
"Lifesteal",       // 74 $191 bit 2 Ma
"Astral Gate",     // 75 $191 bit 3 Ma
"Word of Death",   // 76 $191 bit 4 Ma
"Resurrection",    // 77 $191 bit 5 Ma
"Death Wish",      // 78 $191 bit 6 Ma
"Holy Water"       // 79 $191 bit 7 Ma
// no NULL is required
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG str,
          iq,
          pie,
          vit,
          dex,
          spd,
          per,
          kar,
          curhp,
          maxhp,
          curstm,
          maxstm,
          curfire,
          maxfire,
          curwater,
          maxwater,
          curair,
          maxair,
          curearth,
          maxearth,
          curmental,
          maxmental,
          curmagic,
          maxmagic,
          asleep,
          blind,
          bodycount,
          gp,
          level,
          portrait,
          race,
          rank,
          rebirths,
          sex,
          skill[SKILLS],
          spell[80],
          theclass,
          xp;
    TEXT  name[7 + 1];
} man[6];

// 8. CODE ---------------------------------------------------------------

EXPORT void wiz_main(void)
{   TRANSIENT int          i;
 // TRANSIENT ULONG        imagery;
    TRANSIENT struct Node* NodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // wiz_preinit()
        NewList(&SpellsList);
    }

    tool_open  = wiz_open;
    tool_loop  = wiz_loop;
    tool_save  = wiz_save;
    tool_close = wiz_close;
    tool_exit  = wiz_exit;

    if (loaded != FUNC_WIZ && !wiz_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_WIZ;

    load_images(109, 117);
    for (i = 0; i < 80; i++)
    {   /* if (i <= 8)
        {   imagery = 109; // fire
        } elif (i <= 19)
        {   imagery = 110; // water
        } elif (i <= 34)
        {   imagery = 111; // air
        } elif (i <= 46)
        {   imagery = 112; // earth
        } elif (i <= 63)
        {   imagery = 113; // mental
        } else
        {   imagery = 114; // magic
        } */

        NodePtr = (struct Node*) AllocListBrowserNode
        (   1,                      // columns,
            LBNA_CheckBox,          TRUE,
            LBNCA_Text,             SpellNames[i],
        TAG_END);
        // we should check NodePtr is non-zero
        AddTail(&SpellsList, (struct Node*) NodePtr);
    }
    make_speedbar_list(GID_WIZ_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                             TRUE,
        WA_ThinSizeGadget,                                         TRUE,
        WINDOW_Position,                                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                        gadgets[GID_WIZ_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                     TRUE,
            LAYOUT_SpaceInner,                                     TRUE,
            AddHLayout,
                AddToolbar(GID_WIZ_SB1),
                AddSpace,
                CHILD_WeightedWidth,                               50,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                          50,
                    MaximizeButton(GID_WIZ_BU2, "Maximize Party"),
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
                LAYOUT_AddChild,                                   gadgets[GID_WIZ_IN46] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                         GID_WIZ_IN46,
                    GA_RelVerify,                                  TRUE,
                    GA_TabCycle,                                   TRUE,
                    INTEGER_Minimum,                               1,
                    INTEGER_Maximum,                               men,
                    INTEGER_Number,                                who + 1,
                    INTEGER_MinVisible,                            1 + 1,
                IntegerEnd,
                Label("Character #:"),
                AddLabel("of"),
                CHILD_WeightedWidth,                               0,
                LAYOUT_AddChild,                                   gadgets[GID_WIZ_IN47] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                         GID_WIZ_IN47,
                    GA_ReadOnly,                                   TRUE,
                    INTEGER_Arrows,                                FALSE,
                    INTEGER_Number,                                men,
                    INTEGER_MinVisible,                            1 + 1,
                IntegerEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                                  0,
            AddVLayout,
                LAYOUT_BevelStyle,                                 BVS_GROUP,
                LAYOUT_SpaceOuter,                                 TRUE,
                LAYOUT_Label,                                      "Character",
                AddHLayout,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,                     BVS_GROUP,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "General",
                            AddHLayout,
                                LAYOUT_SpaceOuter,                 TRUE,
                                AddVLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    AddLabel("Name:"),
                                    AddLabel("Hit Points:"),
                                    AddLabel("Stamina:"),
                                    AddLabel("Level:"),
                                    AddLabel("Gold Pieces:"),
                                    AddLabel("Experience:"),
                                    AddLabel("Body Count:"),
                                    AddHLayout,
                                       LAYOUT_VertAlignment,       LALIGN_CENTER,
                                       AddImage(115),
                                       CHILD_WeightedWidth,        0,
                                       AddLabel("Rebirths:"),
                                    LayoutEnd,
                                    CHILD_WeightedHeight,          0,
                                    AddLabel("Race:"),
                                    AddLabel("Sex:"),
                                    AddLabel("Class:"),
                                    AddLabel("Rank:"),
                                    AddLabel("Portrait:"),
                                LayoutEnd,
                                AddVLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_ST1] = (struct Gadget*)
                                    StringObject,
                                        GA_ID,                     GID_WIZ_ST1,
                                        GA_TabCycle,               TRUE,
                                        STRINGA_TextVal,           man[who].name,
                                        STRINGA_MaxChars,          12 + 1,
                                    StringEnd,
                                    AddHLayout,
                                        LAYOUT_VertAlignment,      LALIGN_CENTER,
                                        LAYOUT_AddChild,           gadgets[GID_WIZ_IN39] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,                 GID_WIZ_IN39,
                                            GA_TabCycle,           TRUE,
                                            INTEGER_Minimum,       0,
                                            INTEGER_Maximum,       9999,
                                            INTEGER_MinVisible,    4 + 1,
                                        IntegerEnd,
                                        AddLabel("of"),
                                        LAYOUT_AddChild,           gadgets[GID_WIZ_IN40] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,                 GID_WIZ_IN40,
                                            GA_TabCycle,           TRUE,
                                            INTEGER_Minimum,       0,
                                            INTEGER_Maximum,       9999,
                                            INTEGER_MinVisible,    4 + 1,
                                        IntegerEnd,
                                    LayoutEnd,
                                    AddHLayout,
                                        LAYOUT_VertAlignment,      LALIGN_CENTER,
                                        LAYOUT_AddChild,           gadgets[GID_WIZ_IN41] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,                 GID_WIZ_IN41,
                                            GA_TabCycle,           TRUE,
                                            INTEGER_Minimum,       0,
                                            INTEGER_Maximum,       9999,
                                            INTEGER_MinVisible,    4 + 1,
                                        IntegerEnd,
                                        AddLabel("of"),
                                        LAYOUT_AddChild,           gadgets[GID_WIZ_IN42] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,                 GID_WIZ_IN42,
                                            GA_TabCycle,           TRUE,
                                            INTEGER_Minimum,       0,
                                            INTEGER_Maximum,       9999,
                                            INTEGER_MinVisible,    4 + 1,
                                        IntegerEnd,
                                    LayoutEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN43] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN43,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN44] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN44,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           9999999,
                                        INTEGER_MinVisible,        7 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN45] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN45,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           0x7FFFFFFF,
                                        INTEGER_MinVisible,        10 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN48] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN48,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           0x7FFFFFFF,
                                        INTEGER_MinVisible,        10 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN49] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN49,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_CH2] = (struct Gadget*)
                                    PopUpObject,
                                        GA_ID,                     GID_WIZ_CH2,
                                        CHOOSER_LabelArray,        RaceNames,
                                    PopUpEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_CH3] = (struct Gadget*)
                                    PopUpObject,
                                        GA_ID,                     GID_WIZ_CH3,
                                        CHOOSER_Labels,            &SexList,
                                    PopUpEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_CH1] = (struct Gadget*)
                                    PopUpObject,
                                        GA_ID,                     GID_WIZ_CH1,
                                        CHOOSER_LabelArray,        ClassNames,
                                        CHOOSER_MaxLabels,         14,
                                    PopUpEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN62] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN62,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           7,
                                        INTEGER_MinVisible,        1 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN63] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN63,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           41,
                                        INTEGER_MinVisible,        2 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                CHILD_WeightedHeight,              0,
                            LayoutEnd,
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_VertAlignment,                  LALIGN_CENTER,
                            LAYOUT_BevelStyle,                     BVS_GROUP,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Attributes",
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN31] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN31,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Strength:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN32] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN32,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Intelligence:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN33] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN33,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Piety:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN34] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN34,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Vitality:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN35] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN35,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Dexterity:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN36] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN36,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Speed:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN37] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN37,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Personality:"),
                            LAYOUT_AddChild,                       gadgets[GID_WIZ_IN38] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                             GID_WIZ_IN38,
                                GA_TabCycle,                       TRUE,
                                INTEGER_Minimum,                   0,
                                INTEGER_MinVisible,                2 + 1,
                                INTEGER_Maximum,                   99,
                            IntegerEnd,
                            Label("Karma:"),
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_VertAlignment,                  LALIGN_CENTER,
                            LAYOUT_BevelStyle,                     BVS_GROUP,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Condition",
                            AddHLayout,
                                LAYOUT_VertAlignment,              LALIGN_CENTER,
                                AddImage(116),
                                CHILD_WeightedWidth,               0,
                                LAYOUT_AddChild,                   gadgets[GID_WIZ_CB1] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_WIZ_CB1,
                                    GA_Text,                       "Asleep",
                                End,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,              LALIGN_CENTER,
                                AddImage(117),
                                CHILD_WeightedWidth,               0,
                                LAYOUT_AddChild,                   gadgets[GID_WIZ_CB2] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                         GID_WIZ_CB2,
                                    GA_Text,                       "Blind",
                                End,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                        AddHLayout,
                            LAYOUT_VertAlignment,                  LALIGN_CENTER,
                            LAYOUT_BevelStyle,                     BVS_GROUP,
                            LAYOUT_SpaceOuter,                     TRUE,
                            LAYOUT_Label,                          "Spell Groups",
                            AddVLayout,
                                AddImage(109),
                                AddImage(110),
                                AddImage(111),
                                AddImage(112),
                                AddImage(113),
                                AddImage(114),
                            LayoutEnd,
                            CHILD_WeightedWidth,                   0,
                            AddVLayout,
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN50] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN50,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN51] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN51,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Fire:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN52] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN52,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN53] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN53,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Water:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN54] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN54,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN55] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN55,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Air:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN56] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN56,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN57] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN57,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Earth:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN58] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN58,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN59] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN59,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Mental:"),
                                AddHLayout,
                                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN60] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN60,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,               gadgets[GID_WIZ_IN61] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                     GID_WIZ_IN61,
                                        GA_TabCycle,               TRUE,
                                        INTEGER_Minimum,           0,
                                        INTEGER_Maximum,           999,
                                        INTEGER_MinVisible,        3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Magic:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                      0,
                        AddSpace,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                         BVS_GROUP,
                        LAYOUT_SpaceOuter,                         TRUE,
                        LAYOUT_Label,                              "Skills",
                        AddSkill(GID_WIZ_IN1),
                        Label("Wand & Dagger:"), // Weaponry
                        AddSkill(GID_WIZ_IN2),
                        Label("Sword:"),         // We
                        AddSkill(GID_WIZ_IN3),
                        Label("Axe:"),           // We
                        AddSkill(GID_WIZ_IN4),
                        Label("Mace & Flail:"),  // We
                        AddSkill(GID_WIZ_IN5),
                        Label("Pole & Staff:"),  // We
                        AddSkill(GID_WIZ_IN6),
                        Label("Throwing:"),      // We
                        AddSkill(GID_WIZ_IN7),
                        Label("Sling:"),         // We
                        AddSkill(GID_WIZ_IN8),
                        Label("Bows:"),          // We
                        AddSkill(GID_WIZ_IN9),
                        Label("Shield:"),        // We
                        AddSkill(GID_WIZ_IN10),
                        Label("Hands & Feet:"),  // We
                        AddSkill(GID_WIZ_IN11),
                        Label("Swimming:"),      // Physical
                        AddSkill(GID_WIZ_IN12),
                        Label("Scouting:"),      // Ph
                        AddSkill(GID_WIZ_IN13),
                        Label("Music:"),         // Ph
                        AddSkill(GID_WIZ_IN14),
                        Label("Oratory:"),       // Ph
                        AddSkill(GID_WIZ_IN15),
                        Label("Legerdemain:"),   // Ph
                        AddSkill(GID_WIZ_IN16),
                        Label("Skulduggery:"),   // Ph
                        AddSkill(GID_WIZ_IN17),
                        Label("Ninjutsu:"),      // Ph
                        AddSkill(GID_WIZ_IN18),
                        Label("Defence:"),       // Personal
                        AddSkill(GID_WIZ_IN19),
                        Label("Speed:"),         // Pe
                        AddSkill(GID_WIZ_IN20),
                        Label("Movement:"),      // Pe
                        AddSkill(GID_WIZ_IN21),
                        Label("Aim:"),           // Pe
                        AddSkill(GID_WIZ_IN22),
                        Label("Power:"),         // Pe
                        AddSkill(GID_WIZ_IN23),
                        Label("Artifacts:"),     // Academia
                        AddSkill(GID_WIZ_IN24),
                        Label("Mythology:"),     // Ac
                        AddSkill(GID_WIZ_IN25),
                        Label("Scribe"),         // Ac
                        AddSkill(GID_WIZ_IN26),
                        Label("Alchemy:"),       // Ac
                        AddSkill(GID_WIZ_IN27),
                        Label("Theology:"),      // Ac
                        AddSkill(GID_WIZ_IN28),
                        Label("Theosophy:"),     // Ac
                        AddSkill(GID_WIZ_IN29),
                        Label("Thaumaturgy:"),   // Ac
                        AddSkill(GID_WIZ_IN30),
                        Label("Kirijutsu:"),     // Ac
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                         BVS_GROUP,
                        LAYOUT_Label,                              "Spells",
                        LAYOUT_AddChild,                           gadgets[GID_WIZ_LB1] = (struct Gadget*)
                        ListBrowserObject,
                            GA_ID,                                 GID_WIZ_LB1,
                            GA_RelVerify,                          TRUE,
                            LISTBROWSER_Labels,                    (ULONG) &SpellsList,
                            LISTBROWSER_ShowSelected,              TRUE,
                            LISTBROWSER_AutoWheel,                 FALSE,
                        ListBrowserEnd,
                        HTripleButton(GID_WIZ_BU4, GID_WIZ_BU3, GID_WIZ_BU5),
                    LayoutEnd,
                LayoutEnd,
                MaximizeButton(GID_WIZ_BU1, "Maximize Character"),
                CHILD_WeightedHeight,                              0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                         TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_WIZ_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_WIZ_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_WIZ_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void wiz_loop(ULONG gid, UNUSED ULONG code)
{   int i,
        whichman;

    switch (gid)
    {
    case GID_WIZ_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_WIZ_BU2:
        readgadgets();
        for (whichman = 0; whichman < (int) men; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
    acase GID_WIZ_BU3:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = 0;
            } else
            {   man[who].spell[i] = 1;
        }   }
        writegadgets();
    acase GID_WIZ_BU4:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   man[who].spell[i] = 1;
        }
        writegadgets();
    acase GID_WIZ_BU5:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   man[who].spell[i] = 0;
        }
        writegadgets();
    acase GID_WIZ_IN46:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_WIZ_IN46], (ULONG*) &who);
        who--;
        writegadgets();
}   }

EXPORT FLAG wiz_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if
        (   gamesize != 50288
         && gamesize != 50720
         && gamesize != 51152
         && gamesize != 51584
         && gamesize != 52016
         && gamesize != 52448
        )
        {   DisplayBeep(NULL);
            return FALSE;
        }

        serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else

    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_WIZ
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

        DISCARD SetGadgetAttrs(gadgets[GID_WIZ_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                  TAG_END);
        i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[whichman].spell[i], TAG_END);
            i++;
        }
        DISCARD SetGadgetAttrs(gadgets[GID_WIZ_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_WIZ_LB1], MainWindowPtr, NULL);
    }

    for (i = 0; i < SKILLS; i++)
    {   either_in(GID_WIZ_IN1 + i, &man[whichman].skill[i]);
    }

    either_st(GID_WIZ_ST1,   man[whichman].name);

    either_in(GID_WIZ_IN31, &man[whichman].str);
    either_in(GID_WIZ_IN32, &man[whichman].iq);
    either_in(GID_WIZ_IN33, &man[whichman].pie);
    either_in(GID_WIZ_IN34, &man[whichman].vit);
    either_in(GID_WIZ_IN35, &man[whichman].dex);
    either_in(GID_WIZ_IN36, &man[whichman].spd);
    either_in(GID_WIZ_IN37, &man[whichman].per);
    either_in(GID_WIZ_IN38, &man[whichman].kar);
    either_in(GID_WIZ_IN39, &man[whichman].curhp);
    either_in(GID_WIZ_IN40, &man[whichman].maxhp);
    either_in(GID_WIZ_IN41, &man[whichman].curstm);
    either_in(GID_WIZ_IN42, &man[whichman].maxstm);
    either_in(GID_WIZ_IN43, &man[whichman].level);
    either_in(GID_WIZ_IN44, &man[whichman].gp);
    either_in(GID_WIZ_IN45, &man[whichman].xp);
    either_in(GID_WIZ_IN48, &man[whichman].bodycount);
    either_in(GID_WIZ_IN49, &man[whichman].rebirths);
    either_in(GID_WIZ_IN50, &man[whichman].curfire);
    either_in(GID_WIZ_IN51, &man[whichman].maxfire);
    either_in(GID_WIZ_IN52, &man[whichman].curwater);
    either_in(GID_WIZ_IN53, &man[whichman].maxwater);
    either_in(GID_WIZ_IN54, &man[whichman].curair);
    either_in(GID_WIZ_IN55, &man[whichman].maxair);
    either_in(GID_WIZ_IN56, &man[whichman].curearth);
    either_in(GID_WIZ_IN57, &man[whichman].maxearth);
    either_in(GID_WIZ_IN58, &man[whichman].curmental);
    either_in(GID_WIZ_IN59, &man[whichman].maxmental);
    either_in(GID_WIZ_IN60, &man[whichman].curmagic);
    either_in(GID_WIZ_IN61, &man[whichman].maxmagic);
    either_in(GID_WIZ_IN62, &man[whichman].rank);
    either_in(GID_WIZ_IN63, &man[whichman].portrait);

    either_ch(GID_WIZ_CH1,  &man[whichman].theclass);
    either_ch(GID_WIZ_CH2,  &man[whichman].race);
    either_ch(GID_WIZ_CH3,  &man[whichman].sex);

    either_cb(GID_WIZ_CB1,  &man[whichman].asleep);
    either_cb(GID_WIZ_CB2,  &man[whichman].blind);

    if (gadmode == SERIALIZE_WRITE)
    {   either_in(GID_WIZ_IN47, &men);
        DISCARD SetGadgetAttrs(gadgets[GID_WIZ_IN46], MainWindowPtr, NULL, INTEGER_Maximum, men, TAG_END); // this autorefreshes
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets(who);
}

MODULE void serialize(void)
{   int i, j,
        length,
        whichman;

    men = (gamesize - 0xC2C0) / 432;
    // assert(men >= 1 && men <= 6);

    for (whichman = 0; whichman < (int) men; whichman++)
    {   offset = 0xC2C0 + (432 * whichman);

        if (serializemode == SERIALIZE_READ)
        {   zstrncpy(man[whichman].name, (char*) &IOBuffer[offset], 7); // 0..7
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);

            length = strlen(man[whichman].name);
            if (length < 7)
            {   for (i = length; i < 7; i++)
                {   man[whichman].name[i] = EOS;
            }   }
            for (i = 0; i < 7; i++)
            {   IOBuffer[offset++] = man[whichman].name[i];
        }   }

        offset = 0xC2C0 + (432 * whichman) + 0xC;
        serialize4(&man[whichman].xp);             // $00C..$00F
        serialize4(&man[whichman].bodycount);      // $010..$013
        serialize4(&man[whichman].gp);             // $014..$017
        serialize2ulong(&man[whichman].curhp);     // $018..$019
        serialize2ulong(&man[whichman].maxhp);     // $01A..$01B
        serialize2ulong(&man[whichman].curstm);    // $01C..$01D
        serialize2ulong(&man[whichman].maxstm);    // $01E..$01F

        offset = 0xC2C0 + (432 * whichman) + 0x24;
        serialize2ulong(&man[whichman].level);     // $024..$025
        serialize2ulong(&man[whichman].rebirths);  // $026..$027
        serialize2ulong(&man[whichman].curfire);   // $028..$029
        serialize2ulong(&man[whichman].maxfire);   // $02A..$02B
        serialize2ulong(&man[whichman].curwater);  // $02C..$02D
        serialize2ulong(&man[whichman].maxwater);  // $02E..$02F
        serialize2ulong(&man[whichman].curair);    // $030..$031
        serialize2ulong(&man[whichman].maxair);    // $032..$033
        serialize2ulong(&man[whichman].curearth);  // $034..$035
        serialize2ulong(&man[whichman].maxearth);  // $036..$037
        serialize2ulong(&man[whichman].curmental); // $038..$039
        serialize2ulong(&man[whichman].maxmental); // $03A..$03B
        serialize2ulong(&man[whichman].curmagic);  // $03C..$03D
        serialize2ulong(&man[whichman].maxmagic);  // $03E..$03F

        offset = 0xC2C0 + (432 * whichman) + 0x124;
        serialize1(&man[whichman].asleep);         // $124
        offset++;                                  // $125
        serialize1(&man[whichman].blind);          // $126
        offset += 5;                               // $127..$12B
        serialize1(&man[whichman].str);            // $12C
        serialize1(&man[whichman].iq);             // $12D
        serialize1(&man[whichman].pie);            // $12E
        serialize1(&man[whichman].vit);            // $12F
        serialize1(&man[whichman].dex);            // $130
        serialize1(&man[whichman].spd);            // $131
        serialize1(&man[whichman].per);            // $132
        serialize1(&man[whichman].kar);            // $133

        for (i = 0; i < SKILLS; i++)
        {   serialize1(&man[whichman].skill[i]);   // $134..$151
        }

        offset = 0xC2C0 + (432 * whichman) + 0x188;

        for (i = 0; i < 10; i++)                   // $188..$191
        {   for (j = 0; j < 8; j++)
            {   if (serializemode == SERIALIZE_READ)
                {   if (IOBuffer[offset] & (1 << j))
                    {   man[whichman].spell[(i * 8) + j] = 1;
                    } else
                    {   man[whichman].spell[(i * 8) + j] = 0;
                }   }
                else
                {   // assert(serializemode == SERIALIZE_WRITE);

                    if (man[whichman].spell[(i * 8) + j])
                    {   IOBuffer[offset] |= 1 << j;
                    } else
                    {   IOBuffer[offset] &= ~(1 << j);
            }   }   }
            offset++;
        }

        offset = 0xC2C0 + (432 * whichman) + 0x19C;
        serialize1(&man[whichman].portrait);       // $19C
        serialize1(&man[whichman].race);           // $19D
        serialize1(&man[whichman].sex);            // $19E
        serialize1(&man[whichman].theclass);       // $19F
        serialize1(&man[whichman].rank);           // $1A0
}   }

EXPORT void wiz_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?SAVEGAME.DBS#?", "Wizardry 6", saveas, gamesize, FLAG_S, FALSE);
}

EXPORT void wiz_close(void) { ; }

EXPORT void wiz_exit(void)
{   lb_clearlist(&SpellsList);
    ch_clearlist(&SexList);
}

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].asleep    =
    man[whichman].blind     =
    man[whichman].rebirths  =                                 0;

    man[whichman].str       =
    man[whichman].iq        =
    man[whichman].pie       =
    man[whichman].vit       =
    man[whichman].dex       =
    man[whichman].spd       =
    man[whichman].per       =
    man[whichman].kar       =                                90;

    man[whichman].curhp     = man[whichman].maxhp     =
    man[whichman].curstm    = man[whichman].maxstm    =
    man[whichman].curfire   = man[whichman].maxfire   =
    man[whichman].curwater  = man[whichman].maxwater  =
    man[whichman].curair    = man[whichman].maxair    =
    man[whichman].curearth  = man[whichman].maxearth  =
    man[whichman].curmental = man[whichman].maxmental =
    man[whichman].curmagic  = man[whichman].maxmagic  =
    man[whichman].level     =                               900;

    man[whichman].gp        =                           9000000;

    man[whichman].xp        =
    man[whichman].bodycount =                        1000000000;

    for (i = 0; i < 80; i++)
    {   man[whichman].spell[i] =                              1;
    }

    for (i = 0; i < SKILLS; i++)
    {   man[whichman].skill[i] =                             90;
}   }

EXPORT void wiz_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_WIZ_LB1, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_WIZ_LB1, MainWindowPtr, qual);
}   }
