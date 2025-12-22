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
#include <proto/graphics.h>
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
#define GID_POLAR_LY1      0 // root layout
#define GID_POLAR_SB1      1 // toolbar
#define GID_POLAR_IN1      2 // turn
#define GID_POLAR_CH1      3 // game
#define GID_POLAR_BU1      4 // maximize
#define GID_POLAR_BU2      5 //  1st Transylvania item     location
#define GID_POLAR_BU29    32 // 28th Transylvania item     location
#define GID_POLAR_BU30    33 //  1st Oo-Topos     item     location
#define GID_POLAR_BU60    63 // 31st Oo-Topos     item     location
#define GID_POLAR_BU61    64 //                   your     location
#define GID_POLAR_BU62    65 //  1st              creature location
#define GID_POLAR_BU79    82 // 18th              creature location

// location subwindow
#define GID_POLAR_LY2     83
#define GID_POLAR_BU80    84 // carried
#define GID_POLAR_BU81    85 // nowhere
#define GID_POLAR_BU82    86 //  1st map button
#define GID_POLAR_BU149  153 // 68th map button
#define GID_POLAR_ST1    154 // description

#define GIDS_POLAR       GID_POLAR_ST1

#define LocationButton(x) \
LAYOUT_AddChild, gadgets[x] = (struct Gadget*) \
ZButtonObject, \
    GA_ID,                x, \
    GA_RelVerify,         TRUE, \
    BUTTON_Justification, BCJ_LEFT, \
    BUTTON_FillPen,       pens[0], \
ButtonEnd

#define CARRIED            0

// 28 Transylvania items ( 0..27)
// 31 Oo-Topos     items (28..58)
#define YOU        (59 +  0)
// Transylvania creatures (12 entries)
#define CAT        (59 +  1)
#define FLIES      (59 +  2)
#define FROG       (59 +  3)
#define GOBLIN     (59 +  4)
#define MICE       (59 +  5)
#define OWL        (59 +  6)
#define ASLEEP     (59 +  7)
#define AWAKE      (59 +  8)
#define SAGE       (59 +  9)
#define VAMPIRE    (59 + 10)
#define WEREWOLF   (59 + 11)
#define ZOMBIE     (59 + 12)
// Oo-Topos creatures (6 entries)
#define GUARD      (59 + 13)
#define SNARL      (59 + 14)
#define CRAB       (59 + 15)
#define SNARLINBOX (59 + 16)
#define ROBOT      (59 + 17)
#define HUJA       (59 + 18)

#define MOVABLES   (28 + 31 + 1 + 12 + 6) // total number of objects + creatures

#define TRANSYLVANIA1      0
#define TRANSYLVANIA2      1
#define OOTOPOS            2

#define AddLocation(x)                                              \
LAYOUT_AddChild, gadgets[GID_POLAR_BU82 + x - 1] = (struct Gadget*) \
ZButtonObject,                                                      \
    GA_ID,           GID_POLAR_BU82 + x - 1,                        \
    GA_RelVerify,    TRUE,                                          \
    GA_Image,        image[firstimage[game] + x - 1],               \
    GA_Selected,     (location[whichitem] == x) ? TRUE : FALSE,     \
ButtonEnd,                                                          \
CHILD_MinWidth,      70 + 12,                                       \
CHILD_MinHeight,     40 + 12,                                       \
CHILD_WeightedWidth, 0

#define BlankLocation AddSpace

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void locationwindow(void);

// 4. EXPORTED VARIABLES -------------------------------------------------

// (none)

// 5. IMPORTED VARIABLES -------------------------------------------------

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT LONG                 gamesize,
                            pens[PENS];
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
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE int                  over,
                            whichitem;
MODULE FLAG                 carryable;
MODULE TEXT                 locationdisplay[MOVABLES][80 + 1];
MODULE ULONG                game,
                            location[MOVABLES],
                            turn;
// MODULE struct HintInfo   ts_hintinfo[40 + 1];
MODULE const int            nowhere[3] = { 0x29, 0x23, 0x45 };

MODULE const STRPTR LocationNames[3][0x44 + 2] = { {
"Carried",                                            // $00
"Facing an ancient stump covered with faint writing", // $01
"Standing near a broken horse-drawn wagon",           // $02
"In a dark area of the forest",                       // $03
"In a clearing with a statue",                        // $04
"In a gloomy cemetery",                               // $05
"Near a small clay hut",                              // $06
"Inside the clay hut",                                // $07
"Near a cave entrance shut by a rock slide",          // $08
"In a large dark cave",                               // $09
"In a small cave",                                    // $0A
"In a secret chamber under the cemetery",             // $0B
"At the crossing of north, west, and east paths",     // $0C
"Standing before a gloomy castle",                    // $0D
"In a dismal area of the forest",                     // $0E
"In the crown of a sleepy willow tree",               // $0F
"On a lakeshore near a willow tree",                  // $10
"Still in the forest",                                // $11
"In a foreboding part of the forest",                 // $12
"Facing a shack on a north/south dirt road",          // $13
"In a small grim shack",                              // $14
"Inside a log cabin",                                 // $15
"In a secret annex",                                  // $16
"Before an old but elegant frame house",              // $17
"In the house",                                       // $18
"In the attic",                                       // $19
"In a sandy field",                                   // $1A
"In the castle's north/south entranceway",            // $1B
"In a small room",                                    // $1C
"In a side room",                                     // $1D
"In a vast chamber",                                  // $1E
"In a cellar room with a vault door",                 // $1F
"Aboard a seaworthy sailboat",                        // $20
"In a dungeon chamber",                               // $21
"In a musty dungeon",                                 // $22
"In a low chamber",                                   // $23
"In a high castle chamber",                           // $24
"In a tower chamber bathed in moonlight",             // $25
"Inside a broken horse-drawn wagon",                  // $26
"Behind the house",                                   // $27
"In a dark cellar",                                   // $28
"Nowhere"                                             // $FF
// NULL is not needed
}, {
"Carried",                                                          // $00
"On a lake shore near a sleepy willow tree",                        // $01
"In the crown of a sleepy willow tree bathed in moonlight",         // $02
"In the woods",                                                     // $03
"In a subterranean crypt before two iron doors",                    // $04
"In a cave. On a stalagmite rests a pulsating crystal ball",        // $05
"In a musty crypt before a cairn of glowing stones",                // $06
"In a large, misty cavern",                                         // $07
"On a staircase which ends abruptly above a cavern some 20' below", // $08
"In an oddly-shaped cavern",                                        // $09
"In the gryphon's den",                                             // $0A
"Before a cave entrance",                                           // $0B
"At the crossroads of twisting paths which meander all directions", // $0C
"Facing an ancient stump covered with faint writing",               // $0D
"Under a large, shady tree facing a grassy clearing",               // $0E
"In a clearing",                                                    // $0F
"At a foreboding intersection of forest paths",                     // $10
"Before an abandoned house",                                        // $11
"Inside an abandoned house",                                        // $12
"In a large attic",                                                 // $13
"At the crossing of north and east paths",                          // $14
"Standing before a gloomy castle",                                  // $15
"In the north/south entranceway of a recently refurbished castle",  // $16
"In a large candle-lit chamber",                                    // $17
"In the cellar",                                                    // $18
"In the treasure chamber",                                          // $19
"In a high chamber",                                                // $1A
"In the chamber of the not-so-evil wizard Zin",                     // $1B
"Standing on a high ledge",                                         // $1C
"Standing before a mysterious cave",                                // $1D
"In a forlorn cemetery",                                            // $1E
"In a dark, underground annex",                                     // $1F
"In a damp cavern",                                                 // $20
"Before a giant cobra",                                             // $21
"In Fair Deal Sam's place of business",                             // $22
"Nowhere"                                                           // $FF
// NULL is not needed
}, {
"Carried",                                                          // $00
"In a prison cell",                                                 // $01
"In a north/south hallway that slopes sharply",                     // $02
"At a guard post",                                                  // $03
"At an intersection with halls leading north, south, and west",     // $04
"In an east/west passage",                                          // $05
"In a large hall with passages off in all directions",              // $06
"In the main gravtube room",                                        // $07
"In what seems to be a chemistry lab",                              // $08
"In what appears to be a garbage disposal",                         // $09
"In a biology or medical lab",                                      // $0A
"On a wide metallic staircase",                                     // $0B
"In a narrow room",                                                 // $0C
"In a vast chamber",                                                // $0D
"In a library",                                                     // $0E
"At a corridor intersection",                                       // $0F
"In a musty room with walls covered by empty bookcases",            // $10
"At the top of a medical amphitheatre",                             // $11
"Near the stage",                                                   // $12
"In a room with mirrored walls",                                    // $13
"In a lounge area",                                                 // $14
"In a room filled with strange radiation",                          // $15
"In a solarium",                                                    // $16
"Standing on a strange \"floor\" #23",                              // $17
"On the roof",                                                      // $18
"In a room with walls shining painfully-bright light",              // $19
"Looking down from the top of a long, wide tunnel",                 // $1A
"In the middle of a tunnel",                                        // $1B
"At the top of the pyramid-shaped steps",                           // $1C
"Inside a pyramid-shaped room",                                     // $1D
"Standing on a wide stone step, the base of the pyramid",           // $1E
"Standing on a strange \"floor\" #31",                              // $1F
"At the bottom of a wide tunnel",                                   // $20
"In a storage room",                                                // $21
"In a very cold room",                                              // $22
"On an east/west catwalk",                                          // $23
"At a wall of solid steel",                                         // $24
"In a room filled with food-processing equipment",                  // $25
"Next to a large viewscreen, with red and blue buttons",            // $26
"In a small clearing leading into the dense, shifting alien jungle",// $27
"In a lush, shifting jungle",                                       // $28
"In the jungle",                                                    // $29
"Standing on a strange \"floor\" #42",                              // $2A
"In a strange, alien jungle",                                       // $2B
"On an overgrown path in a jungle of shifting vegetation",          // $2C
"In a dense jungle",                                                // $2D
"In a jungle clearing",                                             // $2E
"Standing on a strange \"floor\" #47",                              // $2F
"On a beach by a pale, green sea",                                  // $30
"On the beach of a green sea #49",                                  // $31
"On the beach of a green sea #50",                                  // $32
"On a raised podium in a huge chamber",                             // $33
"Inside the airlock of your ship",                                  // $34
"On the bridge of the ship",                                        // $35
"It's too bright to see in here",                                   // $36
"It's too dark to see",                                             // $37
"In a small room where a sentinel scanner sits in the corner",      // $38
"By the computer console near the bridge of your ship",             // $39
"On the cargo hold",                                                // $3A
"On the port engine room",                                          // $3B
"On the starboard engine room",                                     // $3C
"Next to the life support station",                                 // $3D
"On a north/south catwalk",                                         // $3E
"Floating inside the gravtube #63",                                 // $3F
"Floating inside the gravtube #64",                                 // $40
"Floating inside the gravtube #65",                                 // $41
"Floating inside the gravtube #66",                                 // $42
"Standing on a strange \"floor\" #67",                              // $43
"Standing on a strange \"floor\" #68",                              // $44
"Nowhere"                                                           // $FF
// NULL is not needed
} }, GameOptions[3 + 1] =
{ "Transylvania 1",
  "Transylvania 2",
  "Oo-Topos",
  NULL
};

MODULE const int    firstimage[3] = { 269, 309,  380 },
                    locations[ 3] = {  40,  34, 0x44 };

MODULE const STRPTR ItemNames[] = {
// Transylvania (28 entries)
"Acid"                  , //  0 BU2
"Box"                   ,
"Bread"                 ,
"Broom"                 ,
"Bullet"                ,
"Candle"                ,
"Censer"                ,
"Cloak"                 ,
"Coin"                  ,
"Cross"                 ,
"Diamond"               , // 10 BU12
"Elixir"                ,
"Flute"                 ,
"Flypaper"              ,
"Garlic"                ,
"Iron"                  ,
"Key"                   ,
"Lockpick"              ,
"Note"                  ,
"Pistol"                ,
"Ring"                  , // 20 BU22
"Sack"                  ,
"Scepter"               ,
"Scroll"                ,
"Sphere"                ,
"Sword"                 ,
"Tablet"                ,
"Vines"                 , // 27 BU29
// Oo-Topos (31 entries)
"Light-rod"             , // 28 BU30
"Data card"             ,
"Navchip"               , // 30 BU32
"Tachyon power cylinder",
"Shield unit"           ,
"Oxygen recirculator"   ,
"Cryon purifier"        ,
"Energy converter"      ,
"Stabilizing gyro"      ,
"Language translator"   ,
"Space suit"            ,
"Repair manual"         ,
"Laser"                 , // 40 BU42
"Pair of gloves"        ,
"Pair of blue goggles"  ,
"Space helmet"          ,
"Flask"                 ,
"Reed"                  ,
"Plastic bottle"        ,
"Hologram crystal"      ,
"Terran food"           ,
"Tiny golden ring"      ,
"Box"                   , // 50 BU52
"Ruby seashell"         ,
"Emerald"               ,
"Plasma sphere"         ,
"Block of Vegan silver" ,
"Moon jewel"            ,
"Psi cube"              ,
"Gravcar"               ,
"Vial"                  , // 58 BU60
// You
"You"                   , // 59 BU61
// Transylvania (12 entries)
"Cat"                   , // 60 BU62
"Flies"                 ,
"Frog"                  ,
"Goblin"                ,
"Mice/mouse"            ,
"Owl"                   ,
"Princess (asleep)"     ,
"Princess (awake)"      ,
"Sage"                  ,
"Vampire"               ,
"Werewolf"              , // 70 BU72
"Zombie"                , // 71 BU73
// Oo_Topos (6 entries)
"Alien guard"           , // 72 BU74   carryable
"Snarl (unboxed)"       , //           carryable
"Crab"                  , //           carryable
"Snarl (boxed)"         , //           carryable
"Robot"                 , //         uncarryable
"Huja"                  , // 77 BU79 uncarryable
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  ..KK .... .... ....    . = Transparent (%00)
    .KSS KK.. .... ....    S = Skin        (%01) ($FCA)
    .KKS SSK. .... ....    K = Black       (%10)
    ...K KSSK K... ....
    .... KKSS SK.. ....
    ..KK SSKS KKKK K...
    ..KS KSSK SSSS SK..
    .KKS SKKS SSKS SK..
    KSSK SSKK KKSS SSK.
    KKSS KKKK SKSS SSK.
    .KKK KKSS SKSS SSKK
    ..KS SSSS SSKS SSSK
    ...K SSSS SSSS SSSK
    .... KKSS SKSS SSSK
    .... ..KK KSSS SSSS
    .... .... KKSS SSSS

          Plane 1                Plane 0
    ..KK .... .... ....    .... .... .... ....
    .K.. KK.. .... ....    ..SS .... .... ....
    .KK. ..K. .... ....    ...S SS.. .... ....
    ...K K..K K... ....    .... .SS. .... ....
    .... KK.. .K.. ....    .... ..SS S... ....
    ..KK ..K. KKKK K...    .... SS.S .... ....
    ..K. K..K .... .K..    ...S .SS. SSSS S...
    .KK. .KK. ..K. .K..    ...S S..S SS.S S...
    K..K ..KK KK.. ..K.    .SS. SS.. ..SS SS..
    KK.. KKKK .K.. ..K.    ..SS .... S.SS SS..
    .KKK KK.. .K.. ..KK    .... ..SS S.SS SS..
    ..K. .... ..K. ...K    ...S SSSS SS.S SSS.
    ...K .... .... ...K    .... SSSS SSSS SSS.
    .... KK.. .K.. ...K    .... ..SS S.SS SSS.
    .... ..KK K... ....    .... .... .SSS SSSS
    .... .... KK.. ....    .... .... ..SS SSSS
           blacK                  Skin

    Plane 1 Plane 0 */
    0x3000, 0x0000,
    0x4C00, 0x3000,
    0x6200, 0x1C00,
    0x1980, 0x0600,
    0x0C40, 0x0380,
    0x32F8, 0x0D00,
    0x2904, 0x16F8,
    0x6624, 0x19D8,
    0x93C2, 0x6C3C,
    0xCF42, 0x30BC,
    0x7C43, 0x03BC,
    0x2021, 0x1FDE,
    0x1001, 0x0FFE,
    0x0C41, 0x03BE,
    0x0380, 0x007F,
    0x00C0, 0x003F,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void polar_main(void)
{   tool_open      = polar_open;
    tool_loop      = polar_loop;
    tool_save      = polar_save;
    tool_close     = polar_close;
    tool_exit      = polar_exit;
    tool_subgadget = polar_subgadget;

    if (loaded != FUNC_POLARWARE && !polar_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_POLARWARE;

    load_fimage(FUNC_POLARWARE);
    make_speedbar_list(GID_POLAR_SB1);
    load_aiss_images(10, 10);
    polar_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   SPECIALWPOS,
        WINDOW_ParentGroup,                                gadgets[GID_POLAR_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_POLAR_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_POLAR_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_POLAR_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                        LAYOUT_Label,                      "General",
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_AddChild,                   gadgets[GID_POLAR_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POLAR_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_Number,                turn,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Elapsed turns:"),
                        LocationButton(GID_POLAR_BU61),
                        Label("You:"),                     // $128/$128
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_POLARWARE),
                        CHILD_WeightedWidth,               0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                        LAYOUT_Label,                      "Transylvania Creatures",
                        LAYOUT_SpaceOuter,                 TRUE,
                        LocationButton(GID_POLAR_BU62 +  0),
                        Label("Cat:"),                     // $329/$2CB
                        LocationButton(GID_POLAR_BU62 +  1),
                        Label("Flies:"),                   // $318
                        LocationButton(GID_POLAR_BU62 +  2),
                        Label("Frog:"),                    // $319/$2DD
                        LocationButton(GID_POLAR_BU62 +  3),
                        Label("Goblin:"),                  // $31B
                        LocationButton(GID_POLAR_BU62 +  4),
                        Label("Mice/mouse:"),              // $325/$2D1
                        LocationButton(GID_POLAR_BU62 +  5),
                        Label("Owl:"),                     //      $2CE
                        LocationButton(GID_POLAR_BU62 +  6),
                        Label("Princess (asleep):"),       // $321
                        LocationButton(GID_POLAR_BU62 +  7),
                        Label("Princess (awake):"),        // $337
                        LocationButton(GID_POLAR_BU62 +  8),
                        Label("Sage:"),                    //      $2CA
                        LocationButton(GID_POLAR_BU62 +  9),
                        Label("Vampire:"),                 // $338
                        LocationButton(GID_POLAR_BU62 + 10),
                        Label("Werewolf:"),                // $333
                        LocationButton(GID_POLAR_BU62 + 11),
                        Label("Zombie:"),                  //      $2CD
                    LayoutEnd,
                    CHILD_WeightedHeight,                  66,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                        LAYOUT_Label,                      "Oo-Topos Creatures",
                        LAYOUT_SpaceOuter,                 TRUE,
                        LocationButton(GID_POLAR_BU62 + 12),
                        Label("Alien guard:"),
                        LocationButton(GID_POLAR_BU62 + 13),
                        Label("Snarl (unboxed):"),
                        LocationButton(GID_POLAR_BU62 + 14),
                        Label("Crab:"),
                        LocationButton(GID_POLAR_BU62 + 15),
                        Label("Snarl (boxed):"),
                        LocationButton(GID_POLAR_BU62 + 16),
                        Label("Robot:"),
                        LocationButton(GID_POLAR_BU62 + 17),
                        Label("Huja:"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  33,
                    MaximizeButton(GID_POLAR_BU1, "Maximize Game"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       33,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Transylvania Objects",
                    LAYOUT_SpaceOuter,                     TRUE,
                    LocationButton(GID_POLAR_BU2 +  0),
                    Label("Acid:"),                        // $312
                    LocationButton(GID_POLAR_BU2 +  1),
                    Label("Box:"),                         // $32C
                    LocationButton(GID_POLAR_BU2 +  2),
                    Label("Bread:"),                       // $31A
                    LocationButton(GID_POLAR_BU2 +  3),
                    Label("Broom:"),                       // $32A
                    LocationButton(GID_POLAR_BU2 +  4),
                    Label("Bullet:"),                      // $327
                    LocationButton(GID_POLAR_BU2 +  5),
                    Label("Candle:"),                      //      $2D3
                    LocationButton(GID_POLAR_BU2 +  6),
                    Label("Censer:"),                      //      $2D4
                    LocationButton(GID_POLAR_BU2 +  7),
                    Label("Cloak:"),                       // $314
                    LocationButton(GID_POLAR_BU2 +  8),
                    Label("Coin:"),                        //      $2D9
                    LocationButton(GID_POLAR_BU2 +  9),
                    Label("Cross:"),                       // $317
                    LocationButton(GID_POLAR_BU2 + 10),
                    Label("Diamond:"),                     //      $2DE
                    LocationButton(GID_POLAR_BU2 + 11),
                    Label("Elixir:"),                      // $335
                    LocationButton(GID_POLAR_BU2 + 12),
                    Label("Flute:"),                       //      $2DC
                    LocationButton(GID_POLAR_BU2 + 13),
                    Label("Flypaper:"),                    // $330
                    LocationButton(GID_POLAR_BU2 + 14),
                    Label("Garlic:"),                      // $331
                    LocationButton(GID_POLAR_BU2 + 15),
                    Label("Iron:"),                        // $31D
                    LocationButton(GID_POLAR_BU2 + 16),
                    Label("Key:"),                         // $31C
                    LocationButton(GID_POLAR_BU2 + 17),
                    Label("Lockpick:"),                    // $32B
                    LocationButton(GID_POLAR_BU2 + 18),
                    Label("Note:"),                        // $323
                    LocationButton(GID_POLAR_BU2 + 19),
                    Label("Pistol:"),                      // $322
                    LocationButton(GID_POLAR_BU2 + 20),
                    Label("Ring:"),                        // $316/$2D2
                    LocationButton(GID_POLAR_BU2 + 21),
                    Label("Sack:"),                        //      $2DB
                    LocationButton(GID_POLAR_BU2 + 22),
                    Label("Scepter:"),                     //      $2D0
                    LocationButton(GID_POLAR_BU2 + 23),
                    Label("Scroll:"),                      //      $2D8
                    LocationButton(GID_POLAR_BU2 + 24),
                    Label("Sphere:"),                      //      $2DA
                    LocationButton(GID_POLAR_BU2 + 25),
                    Label("Sword:"),                       //      $2DF
                    LocationButton(GID_POLAR_BU2 + 26),
                    Label("Tablet:"),                      //      $2D6
                    LocationButton(GID_POLAR_BU2 + 27),
                    Label("Vines:"),                       // $31F
                LayoutEnd,
                CHILD_WeightedWidth,                       33,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Oo-Topos Objects",
                    LAYOUT_SpaceOuter,                     TRUE,
                    LocationButton(GID_POLAR_BU30 +  0),
                    Label("Light-rod:"             ),      // $48F
                    LocationButton(GID_POLAR_BU30 +  1),
                    Label("Data card:"             ),      // $490
                    LocationButton(GID_POLAR_BU30 +  2),
                    Label("Navchip:"               ),      // $491
                    LocationButton(GID_POLAR_BU30 +  3),
                    Label("Tachyon power cylinder:"),      // $492
                    LocationButton(GID_POLAR_BU30 +  4),
                    Label("Shield unit:"           ),      // $493
                    LocationButton(GID_POLAR_BU30 +  5),
                    Label("Oxygen recirculator:"   ),      // $494
                    LocationButton(GID_POLAR_BU30 +  6),
                    Label("Cryon purifier:"        ),      // $495
                    LocationButton(GID_POLAR_BU30 +  7),
                    Label("Energy converter:"      ),      // $496
                    LocationButton(GID_POLAR_BU30 +  8),
                    Label("Stabilizing gyro:"      ),      // $497
                    LocationButton(GID_POLAR_BU30 +  9),
                    Label("Language translator:"   ),      // $498
                    LocationButton(GID_POLAR_BU30 + 10),
                    Label("Space suit:"            ),      // $499
                    LocationButton(GID_POLAR_BU30 + 11),
                    Label("Repair manual:"         ),      // $49A
                    LocationButton(GID_POLAR_BU30 + 12),
                    Label("Laser:"                 ),      // $49B
                    LocationButton(GID_POLAR_BU30 + 13),
                    Label("Pair of gloves:"        ),      // $49C
                    LocationButton(GID_POLAR_BU30 + 14),
                    Label("Pair of blue goggles:"  ),      // $49D
                    LocationButton(GID_POLAR_BU30 + 15),
                    Label("Space helmet:"          ),      // $49E
                    LocationButton(GID_POLAR_BU30 + 16),
                    Label("Flask:"                 ),      // $49F
                    LocationButton(GID_POLAR_BU30 + 17),
                    Label("Reed:"                  ),      // $4A0
                    LocationButton(GID_POLAR_BU30 + 18),
                    Label("Plastic bottle:"        ),      // $4A1
                    LocationButton(GID_POLAR_BU30 + 19),
                    Label("Hologram crystal:"      ),      // $4A2
                    LocationButton(GID_POLAR_BU30 + 20),
                    Label("Terran food:"           ),      // $4A3
                    LocationButton(GID_POLAR_BU30 + 21),
                    Label("Tiny golden ring:"      ),      // $4A5
                    LocationButton(GID_POLAR_BU30 + 22),
                    Label("Box:"                   ),      // $4A6
                    LocationButton(GID_POLAR_BU30 + 23),
                    Label("Ruby seashell:"         ),      // $4A8
                    LocationButton(GID_POLAR_BU30 + 24),
                    Label("Emerald:"               ),      // $4A9
                    LocationButton(GID_POLAR_BU30 + 25),
                    Label("Plasma sphere:"         ),      // $4AA
                    LocationButton(GID_POLAR_BU30 + 26),
                    Label("Block of Vegan silver:" ),      // $4AB
                    LocationButton(GID_POLAR_BU30 + 27),
                    Label("Moon jewel:"            ),      // $4AC
                    LocationButton(GID_POLAR_BU30 + 28),
                    Label("Psi cube:"              ),      // $4AD
                    LocationButton(GID_POLAR_BU30 + 29),
                    Label("Gravcar:"               ),      // $4AE
                    LocationButton(GID_POLAR_BU30 + 30),
                    Label("Vial:"                  ),      // $4B4
                LayoutEnd,
                CHILD_WeightedWidth,                       33,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_POLAR_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_POLAR_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_POLAR_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void polar_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_POLAR_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    adefault:
        if (gid >= GID_POLAR_BU2 && gid <= GID_POLAR_BU79)
        {   whichitem = gid - GID_POLAR_BU2;
            if (whichitem == YOU)
            {   carryable = FALSE;
            } else
            {   switch (game)
                {
                case TRANSYLVANIA1:
                case TRANSYLVANIA2:
                    if
                    (   whichitem == CAT
                     || whichitem == GOBLIN
                     || whichitem == OWL
                     || whichitem == AWAKE
                     || whichitem == SAGE
                     || whichitem == VAMPIRE
                     || whichitem == WEREWOLF
                     || whichitem == ZOMBIE
                    )
                    {   carryable = FALSE;
                    } else
                    {   carryable = TRUE;
                    }
                acase OOTOPOS:
                    if
                    (   whichitem == ROBOT
                     || whichitem == HUJA
                    )
                    {   carryable = FALSE;
                    } else
                    {   carryable = TRUE;
            }   }   }

            locationwindow();
}   }   }

EXPORT FLAG polar_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 1024)
        {   game = TRANSYLVANIA1;
        } elif (gamesize == 846)
        {   game = TRANSYLVANIA2;
        } elif (gamesize == 5572)
        {   game = OOTOPOS;
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
    (   page != FUNC_POLARWARE
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_POLAR_IN1, &turn);

    if (gadmode == SERIALIZE_WRITE)
    {   ghost(GID_POLAR_IN1,  game != TRANSYLVANIA1 && game != OOTOPOS);
        either_ch(GID_POLAR_CH1, &game);

        // 28 entries
        ghost(GID_POLAR_BU2  +  0, game != TRANSYLVANIA1); // acid
        ghost(GID_POLAR_BU2  +  1, game != TRANSYLVANIA1); // box
        ghost(GID_POLAR_BU2  +  2, game != TRANSYLVANIA1); // bread
        ghost(GID_POLAR_BU2  +  3, game != TRANSYLVANIA1); // broom
        ghost(GID_POLAR_BU2  +  4, game != TRANSYLVANIA1); // bullet
        ghost(GID_POLAR_BU2  +  5, game != TRANSYLVANIA2); // candle
        ghost(GID_POLAR_BU2  +  6, game != TRANSYLVANIA2); // censer
        ghost(GID_POLAR_BU2  +  7, game != TRANSYLVANIA1); // cloak
        ghost(GID_POLAR_BU2  +  8, game != TRANSYLVANIA2); // coin
        ghost(GID_POLAR_BU2  +  9, game != TRANSYLVANIA1); // cross
        ghost(GID_POLAR_BU2  + 10, game != TRANSYLVANIA2); // diamond
        ghost(GID_POLAR_BU2  + 11, game != TRANSYLVANIA1); // elixir
        ghost(GID_POLAR_BU2  + 12, game != TRANSYLVANIA2); // flute
        ghost(GID_POLAR_BU2  + 13, game != TRANSYLVANIA1); // flypaper
        ghost(GID_POLAR_BU2  + 14, game != TRANSYLVANIA1); // garlic
        ghost(GID_POLAR_BU2  + 15, game != TRANSYLVANIA1); // iron
        ghost(GID_POLAR_BU2  + 16, game != TRANSYLVANIA1); // key
        ghost(GID_POLAR_BU2  + 17, game != TRANSYLVANIA1); // lockpick
        ghost(GID_POLAR_BU2  + 18, game != TRANSYLVANIA1); // note
        ghost(GID_POLAR_BU2  + 19, game != TRANSYLVANIA1); // pistol
        ghost(GID_POLAR_BU2  + 20, game != TRANSYLVANIA1 && game != TRANSYLVANIA2); // ring
        ghost(GID_POLAR_BU2  + 21, game != TRANSYLVANIA2); // sack
        ghost(GID_POLAR_BU2  + 22, game != TRANSYLVANIA2); // scepter
        ghost(GID_POLAR_BU2  + 23, game != TRANSYLVANIA2); // scroll
        ghost(GID_POLAR_BU2  + 24, game != TRANSYLVANIA2); // sphere
        ghost(GID_POLAR_BU2  + 25, game != TRANSYLVANIA2); // sword
        ghost(GID_POLAR_BU2  + 26, game != TRANSYLVANIA2); // tablet
        ghost(GID_POLAR_BU2  + 27, game != TRANSYLVANIA1); // vines

        // 31 entries
        for (i = 0; i < 31; i++)
        {   ghost(GID_POLAR_BU30 + i, game != OOTOPOS);
        }

        // 1 entry
        //    GID_POLAR_BU61 (you) is for all

        // 12 entries
        ghost(GID_POLAR_BU62 +  0, game != TRANSYLVANIA1 && game != TRANSYLVANIA2); // cat
        ghost(GID_POLAR_BU62 +  1, game != TRANSYLVANIA1                         ); // flies
        ghost(GID_POLAR_BU62 +  2, game != TRANSYLVANIA1 && game != TRANSYLVANIA2); // frog
        ghost(GID_POLAR_BU62 +  3, game != TRANSYLVANIA1                         ); // goblin
        ghost(GID_POLAR_BU62 +  4, game != TRANSYLVANIA1 && game != TRANSYLVANIA2); // mice/mouse
        ghost(GID_POLAR_BU62 +  5, game != TRANSYLVANIA2                         ); // owl
        ghost(GID_POLAR_BU62 +  6, game != TRANSYLVANIA1                         ); // princess (asleep)
        ghost(GID_POLAR_BU62 +  7, game != TRANSYLVANIA1                         ); // princess (awake)
        ghost(GID_POLAR_BU62 +  8, game != TRANSYLVANIA2                         ); // sage
        ghost(GID_POLAR_BU62 +  9, game != TRANSYLVANIA1                         ); // vampire
        ghost(GID_POLAR_BU62 + 10, game != TRANSYLVANIA1                         ); // werewolf
        ghost(GID_POLAR_BU62 + 11, game != TRANSYLVANIA2                         ); // zombie

        // 6 entries
        ghost(GID_POLAR_BU62 + 12, game != OOTOPOS                               ); // guard
        ghost(GID_POLAR_BU62 + 13, game != OOTOPOS                               ); // snarl (unboxed)
        ghost(GID_POLAR_BU62 + 14, game != OOTOPOS                               ); // crab
        ghost(GID_POLAR_BU62 + 15, game != OOTOPOS                               ); // snarl (boxed)
        ghost(GID_POLAR_BU62 + 16, game != OOTOPOS                               ); // robot
        ghost(GID_POLAR_BU62 + 17, game != OOTOPOS                               ); // huja

        for (i = 0; i < MOVABLES; i++)
        {   strcpy(locationdisplay[i], LocationNames[game][location[i]]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_POLAR_BU2 + i], MainWindowPtr, NULL,
                GA_Text, locationdisplay[i],
            TAG_DONE); // this autorefreshes
}   }   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < MOVABLES; i++)
        {   location[i] = nowhere[game];
    }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);
        for (i = 0; i < MOVABLES; i++)
        {   if (location[i] == (ULONG) nowhere[game])
            {   location[i] = 0xFF;
    }   }   }

    offset = 0x128; serialize1(&location[YOU]);

    switch (game)
    {
    case TRANSYLVANIA1:
        offset =   0xC; serialize2ulong(&turn);

        offset = 0x312; serialize1(&location[ 0]); // acid
        offset = 0x32C; serialize1(&location[ 1]); // box
        offset = 0x31A; serialize1(&location[ 2]); // bread
        offset = 0x32A; serialize1(&location[ 3]); // broom
        offset = 0x327; serialize1(&location[ 4]); // bullet
        offset = 0x314; serialize1(&location[ 7]); // cloak
        offset = 0x317; serialize1(&location[ 9]); // cross
        offset = 0x335; serialize1(&location[11]); // elixir
        offset = 0x330; serialize1(&location[13]); // flypaper
        offset = 0x331; serialize1(&location[14]); // garlic
        offset = 0x31D; serialize1(&location[15]); // iron
        offset = 0x31C; serialize1(&location[16]); // key
        offset = 0x32B; serialize1(&location[17]); // lockpick
        offset = 0x323; serialize1(&location[18]); // note
        offset = 0x322; serialize1(&location[19]); // pistol
        offset = 0x316; serialize1(&location[20]); // ring
        offset = 0x31F; serialize1(&location[27]); // vines

        offset = 0x329; serialize1(&location[CAT     ]);
        offset = 0x318; serialize1(&location[FLIES   ]);
        offset = 0x319; serialize1(&location[FROG    ]);
        offset = 0x31B; serialize1(&location[GOBLIN  ]);
        offset = 0x325; serialize1(&location[MICE    ]);
        offset = 0x321; serialize1(&location[ASLEEP  ]);
        offset = 0x337; serialize1(&location[AWAKE   ]);
        offset = 0x338; serialize1(&location[VAMPIRE ]);
        offset = 0x333; serialize1(&location[WEREWOLF]);
    acase TRANSYLVANIA2:
        offset = 0x2D3; serialize1(&location[ 5]); // candle
        offset = 0x2D4; serialize1(&location[ 6]); // censer
        offset = 0x2D9; serialize1(&location[ 8]); // coin
        offset = 0x2DE; serialize1(&location[10]); // diamond
        offset = 0x2DC; serialize1(&location[12]); // flute
        offset = 0x2D2; serialize1(&location[20]); // ring
        offset = 0x2DB; serialize1(&location[21]); // sack
        offset = 0x2D0; serialize1(&location[22]); // scepter
        offset = 0x2D8; serialize1(&location[23]); // scroll
        offset = 0x2DA; serialize1(&location[24]); // sphere
        offset = 0x2DF; serialize1(&location[25]); // sword
        offset = 0x2D6; serialize1(&location[26]); // tablet

        offset = 0x2CB; serialize1(&location[CAT     ]);
        offset = 0x2DD; serialize1(&location[FROG    ]);
        offset = 0x2D1; serialize1(&location[MICE    ]);
        offset = 0x2CE; serialize1(&location[OWL     ]);
        offset = 0x2CA; serialize1(&location[SAGE    ]);
        offset = 0x2CD; serialize1(&location[ZOMBIE  ]);
    acase OOTOPOS:
        offset =   0x3; serialize2ulong(&turn);

        offset = 0x48F; serialize1(&location[28]); // Light-rod
        offset = 0x490; serialize1(&location[29]); // Universal activan data card
        offset = 0x491; serialize1(&location[30]); // Navchip
        offset = 0x492; serialize1(&location[31]); // Tachyon power cylinder
        offset = 0x493; serialize1(&location[32]); // Shield unit
        offset = 0x494; serialize1(&location[33]); // Oxygen recirculator
        offset = 0x495; serialize1(&location[34]); // Cryon purifier
        offset = 0x496; serialize1(&location[35]); // Energy converter
        offset = 0x497; serialize1(&location[36]); // Stabilizing gyro
        offset = 0x498; serialize1(&location[37]); // Language translator
        offset = 0x499; serialize1(&location[38]); // Space suit
        offset = 0x49A; serialize1(&location[39]); // Repair manual
        offset = 0x49B; serialize1(&location[40]); // Laser
        offset = 0x49C; serialize1(&location[41]); // Pair of gloves
        offset = 0x49D; serialize1(&location[42]); // Pair of blue goggles
        offset = 0x49E; serialize1(&location[43]); // Space helmet
        offset = 0x49F; serialize1(&location[44]); // Flask
        offset = 0x4A0; serialize1(&location[45]); // Reed
        offset = 0x4A1; serialize1(&location[46]); // Plastic bottle
        offset = 0x4A2; serialize1(&location[47]); // Hologram crystal
        offset = 0x4A3; serialize1(&location[48]); // Terran food
        offset = 0x4A5; serialize1(&location[49]); // Tiny golden ring
        offset = 0x4A6; serialize1(&location[50]); // Box
        offset = 0x4A8; serialize1(&location[51]); // Ruby seashell
        offset = 0x4A9; serialize1(&location[52]); // Emerald
        offset = 0x4AA; serialize1(&location[53]); // Plasma sphere
        offset = 0x4AB; serialize1(&location[54]); // Block of Vegan silver
        offset = 0x4AC; serialize1(&location[55]); // Moon jewel
        offset = 0x4AD; serialize1(&location[56]); // Psi cube
        offset = 0x4AE; serialize1(&location[57]); // Gravcar
        offset = 0x4B4; serialize1(&location[58]); // Vial

        offset = 0x4A4; serialize1(&location[GUARD     ]);
        offset = 0x4A7; serialize1(&location[SNARL     ]);
        offset = 0x4AF; serialize1(&location[CRAB      ]);
        offset = 0x4B0; serialize1(&location[SNARLINBOX]);
        offset = 0x4B1; serialize1(&location[ROBOT     ]);
        offset = 0x4B3; serialize1(&location[HUJA      ]);
    }

    for (i = 0; i < MOVABLES; i++)
    {   if (location[i] == 0xFF)
        {   location[i] = nowhere[game];
}   }   }

EXPORT void polar_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case TRANSYLVANIA1:
        gamesave("ccgdt?.yyy", "Transylvania 1", saveas, gamesize, FLAG_S, FALSE);
    acase TRANSYLVANIA2:
        gamesave("ccgdt?.yyy", "Transylvania 2", saveas, gamesize, FLAG_S, FALSE);
    acase OOTOPOS:
        gamesave("ccgdt?.yyy", "Oo-Topos"      , saveas, gamesize, FLAG_S, FALSE);
}   }

EXPORT void polar_close(void) { ; }
EXPORT void polar_exit(void)  { ; }

MODULE void maximize_man(void)
{   int i;

    turn = 0;

    for (i = 0; i < MOVABLES; i++)
    {   if
        (   i != YOU
         && i != CAT
         && i != GOBLIN
         && i != OWL
         && i != AWAKE
         && i != SAGE
         && i != VAMPIRE
         && i != WEREWOLF
         && i != ZOMBIE
         && i != ROBOT
         && i != HUJA
        )
        {   location[i] = CARRIED;
}   }   }

MODULE void locationwindow(void)
{   TEXT hailstring[60 + 1];
 // int  i;

    over = -2;
    sprintf(hailstring, "Choose Location of %s", ItemNames[whichitem]);

 /* for (i = 0; i < 40; i++)
    {   ts_hintinfo[i].hi_GadgetID = GID_POLAR_BU82 + i;
        ts_hintinfo[i].hi_Code     = -1;
        ts_hintinfo[i].hi_Text     = LocationNames[game][i + 1];
        ts_hintinfo[i].hi_Flags    = 0;
    }
    ts_hintinfo[40].hi_GadgetID    = -1;
    ts_hintinfo[40].hi_Code        = -1;
    ts_hintinfo[40].hi_Text        = NULL;
    ts_hintinfo[40].hi_Flags       = 0; */

    switch (game)
    {
    case  TRANSYLVANIA1: load_images(269, 308);
    acase TRANSYLVANIA2: load_images(309, 342);
    acase OOTOPOS:       load_images(380, 447);
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case TRANSYLVANIA1:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              hailstring,
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "polar-1",
            WINDOW_ParentGroup,                    gadgets[GID_POLAR_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_DeferLayout,                TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(31),
                    BlankLocation,
                    AddLocation(36),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(34),
                    AddLocation(33),
                    AddLocation(30),
                    AddLocation(25),
                    AddLocation(37),
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(35),
                    BlankLocation,
                    AddLocation(28),
                    AddLocation(27),
                    AddLocation(29),
                    AddLocation(24),
                    AddLocation(39),
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(11),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(14),
                    AddLocation(23),
                    AddLocation(40),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(4),
                    BlankLocation,
                    AddLocation(5),
                    AddLocation(13),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(17),
                    BlankLocation,
                    AddLocation(2),
                    AddLocation(12),
                    BlankLocation,
                    AddLocation(18),
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(38),
                    BlankLocation,
                    BlankLocation,
                    AddLocation(22),
                    AddLocation(6),
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(20),
                    AddLocation(19),
                    AddLocation(21),
                    AddLocation(10),
                    BlankLocation,
                    AddLocation(7),
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(32),
                    BlankLocation,
                    AddLocation(3),
                    AddLocation(8),
                    AddLocation(9),
                    BlankLocation,
                    BlankLocation,
                    AddLocation(26),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(16),
                    AddLocation(15),
                    AddLocation(1),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_POLAR_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_POLAR_ST1,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
                AddHLayout,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU80] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU80,
                        GA_Text,                   "Carried",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               carryable ? FALSE : TRUE,
                        GA_Selected,               (location[whichitem] == CARRIED) ? TRUE : FALSE,
                    ButtonEnd,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU81] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU81,
                        GA_Text,                   "Nowhere",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               (whichitem == YOU) ? TRUE : FALSE,
                        GA_Selected,               (location[whichitem] == (ULONG) nowhere[game]) ? TRUE : FALSE,
                    ButtonEnd,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase TRANSYLVANIA2:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              hailstring,
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "polar-2",
            WINDOW_ParentGroup,                    gadgets[GID_POLAR_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_DeferLayout,                TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(28),
                    AddLocation(10),
                    BlankLocation,
                    BlankLocation,
                    AddLocation(6),
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(34),
                    AddLocation(33),
                    AddLocation(9),
                    AddLocation(8),
                    AddLocation(7),
                    AddLocation(4),
                    AddLocation(5),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(27),
                    AddLocation(32),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(26),
                    AddLocation(29),
                    AddLocation(30),
                    AddLocation(31),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(24),
                    AddLocation(23),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(25),
                    AddLocation(22),
                    BlankLocation,
                    AddLocation(19),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(21),
                    BlankLocation,
                    AddLocation(18),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(20),
                    AddLocation(16),
                    AddLocation(17),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(15),
                    AddLocation(14),
                    AddLocation(12),
                    AddLocation(11),
                    AddLocation(2),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(13),
                    BlankLocation,
                    AddLocation(1),
                    AddLocation(3),
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_POLAR_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_POLAR_ST1,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
                AddHLayout,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU80] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU80,
                        GA_Text,                   "Carried",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               carryable ? FALSE : TRUE,
                        GA_Selected,               (location[whichitem] == CARRIED) ? TRUE : FALSE,
                    ButtonEnd,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU81] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU81,
                        GA_Text,                   "Nowhere",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               (whichitem == YOU) ? TRUE : FALSE,
                        GA_Selected,               (location[whichitem] == (ULONG) nowhere[game]) ? TRUE : FALSE,
                    ButtonEnd,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase OOTOPOS:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              hailstring,
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "polar-3",
            WINDOW_ParentGroup,                    gadgets[GID_POLAR_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_DeferLayout,                TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation( 1),
                    AddLocation( 2),
                    AddLocation( 3),
                    AddLocation( 4),
                    AddLocation( 5),
                    AddLocation( 6),
                    AddLocation( 7),
                    AddLocation( 8),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation( 9),
                    AddLocation(10),
                    AddLocation(11),
                    AddLocation(12),
                    AddLocation(13),
                    AddLocation(14),
                    AddLocation(15),
                    AddLocation(16),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(17),
                    AddLocation(18),
                    AddLocation(19),
                    AddLocation(20),
                    AddLocation(21),
                    AddLocation(22),
                    AddLocation(23),
                    AddLocation(24),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(25),
                    AddLocation(26),
                    AddLocation(27),
                    AddLocation(28),
                    AddLocation(29),
                    AddLocation(30),
                    AddLocation(31),
                    AddLocation(32),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(33),
                    AddLocation(34),
                    AddLocation(35),
                    AddLocation(36),
                    AddLocation(37),
                    AddLocation(38),
                    AddLocation(39),
                    AddLocation(40),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(41),
                    AddLocation(42),
                    AddLocation(43),
                    AddLocation(44),
                    AddLocation(45),
                    AddLocation(46),
                    AddLocation(47),
                    AddLocation(48),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(49),
                    AddLocation(50),
                    AddLocation(51),
                    AddLocation(52),
                    AddLocation(53),
                    AddLocation(54),
                    AddLocation(55),
                    AddLocation(56),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    AddLocation(57),
                    AddLocation(58),
                    AddLocation(59),
                    AddLocation(60),
                    AddLocation(61),
                    AddLocation(62),
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(63),
                    AddLocation(64),
                    AddLocation(65),
                    AddLocation(66),
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                    AddLocation(67),
                    AddLocation(68),
                    BlankLocation,
                    BlankLocation,
                    BlankLocation,
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_POLAR_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_POLAR_ST1,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
                AddHLayout,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU80] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU80,
                        GA_Text,                   "Carried",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               carryable ? FALSE : TRUE,
                        GA_Selected,               (location[whichitem] == CARRIED) ? TRUE : FALSE,
                    ButtonEnd,
                    LAYOUT_AddChild,               gadgets[GID_POLAR_BU81] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                     GID_POLAR_BU81,
                        GA_Text,                   "Nowhere",
                        GA_RelVerify,              TRUE,
                        GA_Disabled,               (whichitem == YOU) ? TRUE : FALSE,
                        GA_Selected,               (location[whichitem] == (ULONG) nowhere[game]) ? TRUE : FALSE,
                    ButtonEnd,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }

    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG polar_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_POLAR_BU80:
        if (carryable)
        {   location[whichitem] = CARRIED;

            strcpy(locationdisplay[whichitem], LocationNames[game][location[whichitem]]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_POLAR_BU2 + whichitem], MainWindowPtr, NULL,
                GA_Text, locationdisplay[whichitem],
            TAG_DONE); // this autorefreshes

            return TRUE;
        }
    acase GID_POLAR_BU81:
        if (whichitem != YOU)
        {   location[whichitem] = nowhere[game];

            strcpy(locationdisplay[whichitem], LocationNames[game][location[whichitem]]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_POLAR_BU2 + whichitem], MainWindowPtr, NULL,
                GA_Text, locationdisplay[whichitem],
            TAG_DONE); // this autorefreshes

            return TRUE;
        }
    adefault:
        if (gid >= GID_POLAR_BU82 && gid <= GID_POLAR_BU149)
        {   location[whichitem] = gid - GID_POLAR_BU82 + 1;

            strcpy(locationdisplay[whichitem], LocationNames[game][location[whichitem]]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_POLAR_BU2 + whichitem], MainWindowPtr, NULL,
                GA_Text, locationdisplay[whichitem],
            TAG_DONE); // this autorefreshes

            return TRUE;
    }   }

    return FALSE;
}

EXPORT void polar_subtick(SWORD mousex, SWORD mousey)
{   int i,
        newover = -1;

    if (!SubWindowPtr)
    {   return;
    }

    for (i = 0; i < locations[game]; i++)
    {   if
        (   mousex >= gadgets[GID_POLAR_BU82 + i]->LeftEdge
         && mousex <= gadgets[GID_POLAR_BU82 + i]->LeftEdge + gadgets[GID_POLAR_BU82 + i]->Width  - 1
         && mousey >= gadgets[GID_POLAR_BU82 + i]->TopEdge
         && mousey <= gadgets[GID_POLAR_BU82 + i]->TopEdge  + gadgets[GID_POLAR_BU82 + i]->Height - 1
        )
        {   newover = i;
            break; // for speed
    }   }

    if (newover != over)
    {   over = newover;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_POLAR_ST1], SubWindowPtr, NULL,
            STRINGA_TextVal, (over == -1) ? (STRPTR) "Hover over a button for more information." : LocationNames[game][over + 1],
        TAG_DONE);
}   }

EXPORT FLAG polar_subkey(UWORD code)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    }

    return FALSE;
}

EXPORT void polar_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);

    unlockscreen();
}

EXPORT void polar_uniconify(void)
{   polar_getpens();
}
