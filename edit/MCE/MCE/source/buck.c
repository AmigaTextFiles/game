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
#define GID_BUCK_LY1     0 // root layout
#define GID_BUCK_SB1     1 // toolbar
#define GID_BUCK_ST1     2 // name
#define GID_BUCK_BU1     3 // maximize
#define GID_BUCK_CH1     4 // sex
#define GID_BUCK_CH2     5 // status
#define GID_BUCK_CH3     6 // race
#define GID_BUCK_CH4     7 // class
#define GID_BUCK_CH5     8 //  1st wpn spec slot
#define GID_BUCK_CH14   17 // 10th wpn spec slot
#define GID_BUCK_IN1    18 // age
#define GID_BUCK_IN2    19 // movement rate
#define GID_BUCK_IN3    20 // cur hp
#define GID_BUCK_IN4    21 // max hp
#define GID_BUCK_IN5    22 // xp
#define GID_BUCK_IN6    23 // str
#define GID_BUCK_IN7    24 // tch
#define GID_BUCK_IN8    25 // iq
#define GID_BUCK_IN9    26 // wis
#define GID_BUCK_IN10   27 // dex
#define GID_BUCK_IN11   28 // con
#define GID_BUCK_IN12   29 // cha
#define GID_BUCK_IN13   30 // credits
#define GID_BUCK_IN14   31 // level
#define GID_BUCK_IN15   32 // ac
#define GID_BUCK_BU2    33 // skills

// skills subwindow
#define GID_BUCK_LY2    34
#define GID_BUCK_IN16   35 //  1st skill
#define GID_BUCK_IN69   88 // 54th skill

#define GIDS_BUCK       GID_BUCK_IN69

#define SKILLS          54

#define AddSkill(x)     LAYOUT_AddChild,           gadgets[GID_BUCK_IN16 + x] = (struct Gadget*) \
                        IntegerObject, \
                            GA_ID,                 GID_BUCK_IN16 + x, \
                            GA_TabCycle,           TRUE,  \
                            GA_Disabled,           (x >= 13 && x <= 20 && man.theclass != MEDIC) ? TRUE : FALSE, /* perhaps we should zero the gadget contents too */ \
                            INTEGER_Minimum,       0,     \
                            INTEGER_Maximum,       32767, \
                            INTEGER_MinVisible,    5 + 1, \
                            INTEGER_Number,        man.skill[x], \
                        IntegerEnd
#define AddSpecialty(x) LAYOUT_AddChild,           gadgets[GID_BUCK_CH5 + x] = (struct Gadget*) \
                        PopUpObject, \
                            GA_ID,                 GID_BUCK_CH5 + x, \
                            CHOOSER_LabelArray,    &WpnSpecOptions, \
                            CHOOSER_MaxLabels,     16, \
                            CHOOSER_Justification, CHJ_LEFT, \
                        End

#define ROCKETJOCK 0
#define MEDIC      1
#define WARRIOR    2
#define ENGINEER   3
#define ROGUE      4
#define SCOUT      5

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(void);
MODULE void serialize(void);
MODULE void skillwindow(void);

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
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
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

MODULE struct
{   TEXT  name[15 + 1];
    ULONG str, iq, wis, dex, con, cha, tch,
          curhp, maxhp, xp, age,
          sex, race, theclass,
          credits, level,
          status, movement,
          skill[SKILLS],
          wpnspec[10];
    SLONG ac;
} man;

MODULE const STRPTR ClassOptions[] =
{ "Rocket Jock",
  "Medic",
  "Warrior",
  "Engineer",
  "Rogue",
  "Scout",
  NULL // required
}, RaceOptions[] =
{ "Monster",
  "Terran",
  "Martian",
  "Venusian",
  "Mercurian",
  "Tinker",
  "Desert Runner",
  "Lunarian",
  "Lowlander",
  NULL // required
}, StatusOptions[] =
{ "OK",
  "Gone",
  "Dead",
  "Dying",
  "Unconscious",
  "Fleeing",
  "Poisoned",
  "Comatose",
  NULL // required
}, WpnSpecOptions[] =
{ "-",
  "Knife",
  "Mono Knife",
  "Cutlass",
  "Sword",
  "D.R. X-Bow",
  "Needle Gun",
  "Bolt Gun",
  "Mono Sword",
  "Laser Pistol",
  "Rocket Pistol",
  "Rocket Rifle",
  "Microwave Gun",
  "Laser Rifle",
  "Heat Gun",
  "Sonic Stunner",
  NULL // required
};

MODULE const int gad_to_slot[SKILLS] =
{ 0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
 10,
 12, // 11 -> 12 first aid
 13, // 12 -> 13 repair weapon
 15, // 13 -> 15 lst
 16, // 14 -> 16 tlw
 17, // 15 -> 17 tsw
 18, // 16 -> 18 tcw
 19, // 17 -> 19 tp
 20, // 18 -> 20 ts/p
 21, // 19 -> 21 td
 22, // 20 -> 22 diagnose
 26, // 21 -> 26 mathemetics
 29, // 22 -> 29 planetology
 30, // 23 -> 30 battle tactics
 35, // 24 -> 35 astronomy
 42, // 25 -> 42 programming
 44, // 26 -> 44 library search
 45, // 27 -> 45 astrogation
 46, // 28 -> 46 navigation
 49, // 29 -> 49 disguise
 50, // 30 -> 50 pilot rocket
 51, // 31 -> 51 pilot fixed wing
 52, // 32 -> 52 drive ground car
 53, // 33 -> 53 pilot rotor wing
 55, // 34 -> 55 use jetpack
 58, // 35 -> 56 drive jetcar
 60, // 36 -> 60 hide in shadows
 61, // 37 -> 61 move silently
 62, // 38 -> 62 pick pockets
 63, // 39 -> 63 acrobatics
 64, // 40 -> 64 climb
 66, // 41 -> 66 manoeuvre in 0G
 70, // 42 -> 70 act
 71, // 43 -> 71 intimidate
 72, // 44 -> 72 leadership
 73, // 45 -> 73 befriend animal
 75, // 46 -> 75 fast talk/convince
 76, // 47 -> 76 singing
 77, // 48 -> 77 distract
 78, // 49 -> 78 etiquette
 79, // 50 -> 79 tracking
 80, // 51 -> 80 shadowing
 82, // 52 -> 82 notice
 83, // 53 -> 83 planetary survival
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

 // Plane 0 Plane 1
    0xC000, 0xA000,
    0xE000, 0x5000,
    0x7000, 0xA800,
    0x6C00, 0x3E00,
    0x3600, 0x5F00,
    0x3900, 0x0E80,
    0x1F80, 0x2740,
    0x0FF8, 0x11B0,
    0x07BC, 0x08CC,
    0x02DE, 0x0762,
    0x036F, 0x02B1,
    0x03B0, 0x025C,
    0x03D4, 0x022C,
    0x038E, 0x015E,
    0x018E, 0x0106,
    0x0083, 0x0081,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void buck_main(void)
{   tool_open      = buck_open;
    tool_loop      = buck_loop;
    tool_save      = buck_save;
    tool_close     = buck_close;
    tool_exit      = buck_exit;
    tool_subgadget = buck_subgadget;

    if (loaded != FUNC_BUCK && !buck_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_BUCK;

    make_speedbar_list(GID_BUCK_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                         TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                    gadgets[GID_BUCK_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_SpaceInner,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            AddToolbar(GID_BUCK_SB1),
            AddVLayout,
                LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,             TRUE,
                LAYOUT_Label,                  "General",
                LAYOUT_AddChild,               gadgets[GID_BUCK_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                     GID_BUCK_ST1,
                    GA_TabCycle,               TRUE,
                    GA_RelVerify,              TRUE,
                    STRINGA_TextVal,           man.name,
                    STRINGA_MaxChars,          15 + 1,
                StringEnd,
                Label("Name:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_CH1] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                     GID_BUCK_CH1,
                    CHOOSER_Labels,            &SexList,
                PopUpEnd,
                Label("Sex:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_CH3] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                     GID_BUCK_CH3,
                    CHOOSER_LabelArray,        &RaceOptions,
                PopUpEnd,
                Label("Race:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_CH4] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                     GID_BUCK_CH4,
                    GA_RelVerify,              TRUE,
                    CHOOSER_LabelArray,        &ClassOptions,
                PopUpEnd,
                Label("Career:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_CH2] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                     GID_BUCK_CH2,
                    CHOOSER_LabelArray,        &StatusOptions,
                PopUpEnd,
                Label("Status:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN1] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN1,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           0,
                    INTEGER_Maximum,           65535,
                    INTEGER_MinVisible,        5 + 1,
                IntegerEnd,
                Label("Age:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN2] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN2,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           0,
                    INTEGER_Maximum,           32767,
                    INTEGER_MinVisible,        5 + 1,
                IntegerEnd,
                Label("Movement Rate:"),
                AddHLayout,
                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                    LAYOUT_AddChild,           gadgets[GID_BUCK_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_BUCK_IN3,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       9999,
                        INTEGER_MinVisible,    4 + 1,
                    IntegerEnd,
                    AddLabel("of"),
                    LAYOUT_AddChild,           gadgets[GID_BUCK_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_BUCK_IN4,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       1,
                        INTEGER_Maximum,       9999,
                        INTEGER_MinVisible,    4 + 1,
                    IntegerEnd,
                LayoutEnd,
                CHILD_WeightedHeight,          0,
                Label("Hit Points:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN5,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           0,
                    INTEGER_Maximum,           SLONG_MAX, // in practice limited to 1,410,065,407 by gadget
                    INTEGER_MinVisible,        13 + 1,
                IntegerEnd,
                Label("Experience Points:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN13] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN13,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           0,
                    INTEGER_Maximum,           SLONG_MAX, // in practice limited to 1,410,065,407 by gadget
                    INTEGER_MinVisible,        13 + 1,
                IntegerEnd,
                Label("Credits:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN14] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN14,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           255,
                    INTEGER_MinVisible,        3 + 1,
                IntegerEnd,
                Label("Level:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN15] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN15,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           -32711,
                    INTEGER_Maximum,           56,
                    INTEGER_MinVisible,        6 + 1,
                IntegerEnd,
                Label("Armour Class:"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,             TRUE,
                LAYOUT_Label,                  "Attributes",
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN6,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Strength:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN10] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN10,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Dexterity:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN11] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN11,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Constitution:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN8] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN8,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Intelligence:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN9] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN9,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Wisdom:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN12] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN12,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Charisma:"),
                LAYOUT_AddChild,               gadgets[GID_BUCK_IN7] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                     GID_BUCK_IN7,
                    GA_TabCycle,               TRUE,
                    INTEGER_Minimum,           1,
                    INTEGER_Maximum,           22,
                    INTEGER_MinVisible,        2 + 1,
                IntegerEnd,
                Label("Technology:"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,             TRUE,
                LAYOUT_Label,                  "Weapon Specializations",
                AddSpecialty(0),
                AddSpecialty(1),
                AddSpecialty(2),
                AddSpecialty(3),
                AddSpecialty(4),
                AddSpecialty(5),
                AddSpecialty(6),
                AddSpecialty(7),
                AddSpecialty(8),
                AddSpecialty(9),
            LayoutEnd,
            LAYOUT_AddChild,                   gadgets[GID_BUCK_BU2] = (struct Gadget*)
            ZButtonObject,
                GA_ID,                         GID_BUCK_BU2,
                GA_RelVerify,                  TRUE,
                GA_Text,                       "Skills...",
            ButtonEnd,
            CHILD_WeightedHeight,              0,
            MaximizeButton(GID_BUCK_BU1, "Maximize Character"),
            CHILD_WeightedHeight,              0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_BUCK_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_BUCK_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_BUCK_ST1]);

    loop();

    readgadgets();
    closewindow();
}

EXPORT void buck_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_BUCK_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_BUCK_BU2:
        skillwindow();
    acase GID_BUCK_CH4:
        readgadgets();
        writegadgets(); // this is overkill
}   }

EXPORT FLAG buck_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_BUCK
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    for (i = 0; i < 10; i++)
    {   ghost(GID_BUCK_CH5 + i, man.theclass != WARRIOR); // perhaps we should zero the gadget contents too
}   }

MODULE void serialize(void)
{   int i;

    offset = 0;
    if (serializemode == SERIALIZE_READ)
    {   strcpy(man.name,                  (char*) &IOBuffer[offset]); // $0..$E
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset], man.name);                  // $0..$E
    }
    offset = 0x10;
    serialize2ulong(&man.str);         //  $10.. $11
    serialize2ulong(&man.dex);         //  $12.. $13
    serialize2ulong(&man.con);         //  $14.. $15
    serialize2ulong(&man.iq);          //  $16.. $17
    serialize2ulong(&man.wis);         //  $18.. $19
    serialize2ulong(&man.cha);         //  $1A.. $1B
    serialize2ulong(&man.tch);         //  $1C.. $1D
    offset = 0x3C;
    serialize1(&man.sex);              //  $3C
    serialize1(&man.race);             //  $3D
    man.theclass++;
    serialize1(&man.theclass);         //  $3E
    man.theclass--;
    serialize1(&man.level);            //  $3F
    offset = 0x42;
    serialize4(&man.credits);          //  $42.. $45
    serialize4(&man.xp);               //  $46.. $49
    offset = 0x50;
    serialize2ulong(&man.movement);    //  $50.. $51
    man.ac = 56 - man.ac;
    serialize2ulong((ULONG*) &man.ac); //  $52.. $53
    man.ac = 56 - man.ac;
    serialize2ulong(&man.age);         //  $54.. $55
    offset = 0x6C;
    serialize2ulong(&man.maxhp);       //  $6C.. $6D

    for (i = 0; i < SKILLS; i++)
    {   offset = 0x76 + (gad_to_slot[i] * 2);
        serialize2ulong(&man.skill[i]);
    }

    offset = 0x14A;
    for (i = 0; i < 10; i++)
    {   serialize1(&man.wpnspec[i]);   // $14A..$153
    }    
    man.status++;
    serialize1(&man.status);           // $154
    man.status--;
    offset = 0x16E;
    serialize2ulong(&man.curhp);       // $16E..$16F
}

EXPORT void buck_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?.WHO", "Buck Rogers", saveas, 402, FLAG_C, FALSE);
}

EXPORT void buck_close(void) { ; }
EXPORT void buck_die(void)   { ; }

EXPORT void buck_exit(void)
{   ch_clearlist(&SexList);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_st(GID_BUCK_ST1,   man.name     );
    either_ch(GID_BUCK_CH1,  &man.sex      );
    either_ch(GID_BUCK_CH2,  &man.status   );
    either_ch(GID_BUCK_CH3,  &man.race     );
    either_ch(GID_BUCK_CH4,  &man.theclass );
    for (i = 0; i < 10; i++)
    {   either_ch(GID_BUCK_CH5 + i, &man.wpnspec[i]);
    }
    either_in(GID_BUCK_IN1,  &man.age      );
    either_in(GID_BUCK_IN2,  &man.movement );
    either_in(GID_BUCK_IN3,  &man.curhp    );
    either_in(GID_BUCK_IN4,  &man.maxhp    );
    either_in(GID_BUCK_IN5,  &man.xp       );
    either_in(GID_BUCK_IN6,  &man.str      );
    either_in(GID_BUCK_IN7,  &man.tch      );
    either_in(GID_BUCK_IN8,  &man.iq       );
    either_in(GID_BUCK_IN9,  &man.wis      );
    either_in(GID_BUCK_IN10, &man.dex      );
    either_in(GID_BUCK_IN11, &man.con      );
    either_in(GID_BUCK_IN12, &man.cha      );
    either_in(GID_BUCK_IN13, &man.credits  );
    either_in(GID_BUCK_IN14, &man.level    );
    either_in(GID_BUCK_IN15, (ULONG*) &man.ac);
}

MODULE void maximize_man(void)
{   int i;

    man.ac        =      -32000;
    man.status    =           0;
    man.str       =
    man.iq        =
    man.wis       =
    man.dex       =
    man.con       =
    man.cha       =
    man.tch       =          22;
    man.curhp     =
    man.maxhp     =        9000;
    man.movement  =       30000;
    man.credits   =
    man.xp        = ONE_BILLION;

    for (i = 0; i < SKILLS; i++)
    {   if (man.theclass != MEDIC && i >= 13 && i <= 20)
        {   man.skill[i] =     0; // non-medics can't learn medic skills
        } else
        {   man.skill[i] = 30000;
}   }   }

MODULE void skillwindow(void)
{   int i;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                      "Skills",
        WA_SizeGadget,                                 TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                               "buck-1",
        WINDOW_ParentGroup,                            gadgets[GID_BUCK_LY2] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            AddVLayout,
                AddLabel("Repair Electrical:"),
                AddLabel("Repair Mechanicall:"),
                AddLabel("Repair Nuclear Engine:"),
                AddLabel("Repair Life Support:"),
                AddLabel("Repair Rocket Hull:"),
                AddLabel("Jury Rig:"),
                AddLabel("Bypass Security:"),
                AddLabel("Open Lock:"),
                AddLabel("Commo Operation:"),
                AddLabel("Sensor Operation:"),
                AddLabel("Demolitions:"),
                AddLabel("First Aid:"),
                AddLabel("Repair Weapon:"),
                AddLabel("Life Suspension Tech:"),
                AddLabel("Treat Light Wounds:"),
                AddLabel("Treat Serious Wounds:"),
                AddLabel("Treat Critical Wounds:"),
                AddLabel("Treat Poisoning:"),
                AddLabel("Treat Stun/Paralysis:"),
                AddLabel("Treat Disease:"),
                AddLabel("Diagnose:"),
                AddLabel("Mathematics:"),
                AddLabel("Planetology:"),
                AddLabel("Battle Tactics:"),
                AddLabel("Astronomy:"),
                AddLabel("Programming:"),
                AddLabel("Library Search:"),
            LayoutEnd,
            CHILD_WeightedWidth,                   0,
            AddVLayout,
                AddSkill( 0),
                AddSkill( 1),
                AddSkill( 2),
                AddSkill( 3),
                AddSkill( 4),
                AddSkill( 5),
                AddSkill( 6),
                AddSkill( 7),
                AddSkill( 8),
                AddSkill( 9),
                AddSkill(10),
                AddSkill(11),
                AddSkill(12),
                AddSkill(13),
                AddSkill(14),
                AddSkill(15),
                AddSkill(16),
                AddSkill(17),
                AddSkill(18),
                AddSkill(19),
                AddSkill(20),
                AddSkill(21),
                AddSkill(22),
                AddSkill(23),
                AddSkill(24),
                AddSkill(25),
                AddSkill(26),
            LayoutEnd,
            AddVLayout,
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+TCH"),
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+INT"),
            LayoutEnd,
            CHILD_WeightedWidth,                   0,
            AddLabel("  "),
            CHILD_WeightedWidth,                   0,
            AddVLayout,
                AddLabel("Astrogation:"),
                AddLabel("Navigation:"),
                AddLabel("Disguise:"),
                AddLabel("Pilot Rocket:"),
                AddLabel("Pilot Fixed Wing:"),
                AddLabel("Drive Ground Car:"),
                AddLabel("Pilot Rotor Wing:"),
                AddLabel("Use Jetpack:"),
                AddLabel("Drive Jetcar:"),
                AddLabel("Hide in Shadows:"),
                AddLabel("Move Silently:"),
                AddLabel("Pick Pockets:"),
                AddLabel("Acrobatics:"),
                AddLabel("Climb:"),
                AddLabel("Manoeuvre in 0G:"),
                AddLabel("Act:"),
                AddLabel("Intimidate:"),
                AddLabel("Leadership:"),
                AddLabel("Befriend Animal:"),
                AddLabel("Fast Talk/Convince:"),
                AddLabel("Singing:"),
                AddLabel("Distract:"),
                AddLabel("Etiquette:"),
                AddLabel("Tracking:"),
                AddLabel("Shadowing:"),
                AddLabel("Notice:"),
                AddLabel("Planetary Survival:"),
            LayoutEnd,
            CHILD_WeightedWidth,                   0,
            AddVLayout,
                AddSkill(27),
                AddSkill(28),
                AddSkill(29),
                AddSkill(30),
                AddSkill(31),
                AddSkill(32),
                AddSkill(33),
                AddSkill(34),
                AddSkill(35),
                AddSkill(36),
                AddSkill(37),
                AddSkill(38),
                AddSkill(39),
                AddSkill(40),
                AddSkill(41),
                AddSkill(42),
                AddSkill(43),
                AddSkill(44),
                AddSkill(45),
                AddSkill(46),
                AddSkill(47),
                AddSkill(48),
                AddSkill(49),
                AddSkill(50),
                AddSkill(51),
                AddSkill(52),
                AddSkill(53),
            LayoutEnd,
            AddVLayout,
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+INT"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+DEX"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+CHA"),
                AddLabel("+WIS"),
                AddLabel("+WIS"),
                AddLabel("+WIS"),
                AddLabel("+WIS"),
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    subloop();

    for (i = 0; i < SKILLS; i++)
    {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_BUCK_IN16 + i], (ULONG*) &man.skill[i]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG buck_subgadget(UNUSED ULONG gid, UNUSED UWORD code)
{   return FALSE;
}
