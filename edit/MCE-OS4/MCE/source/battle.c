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
#define GID_BA_LY1    0 // root layout
#define GID_BA_SB1    1 // toolbar
#define GID_BA_BU1    2 // maximize man
#define GID_BA_CH1    3 // name
#define GID_BA_CH2    4 // armour
#define GID_BA_CH3    5 // weapon
#define GID_BA_CH4    6 // bow & blade skill
#define GID_BA_CH5    7 // pistol      skill
#define GID_BA_CH6    8 // rifle       skill
#define GID_BA_CH7    9 // gunnery     skill
#define GID_BA_CH8   10 // piloting    skill
#define GID_BA_CH9   11 // tech        skill
#define GID_BA_CH10  12 // medical     skill
#define GID_BA_IN1   13 // money
#define GID_BA_IN2   14 // current armour points
#define GID_BA_IN3   15 // maximum armour points
#define GID_BA_IN4   16 // 1st investment
#define GID_BA_IN5   17 // 2nd investment
#define GID_BA_IN6   18 // 3rd investment
#define GIDS_BA      GID_BA_IN6

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
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

/* 6. MODULE VARIABLES --------------------------------------------------- */

MODULE ULONG                armourtype,
                            armourpoints,
                            gp,
                            investment[3],
                            name,
                            skill[7],
                            weapon;
MODULE const ULONG          limit[6] =
{ 0,
  25,
  40,
  30,
  50,
  50
};
MODULE const STRPTR ArmourOptions[6 + 1] =
{ "None",                          //  0
  "Flak Vest",
  "Flak Suit",
  "Light Environment Suit",
  "Heavy Environment Suit",
  "Ablative",                      //  5
  NULL                             //  6
}, NameOptions[11 + 1] =
{ "Jason",                         //  0
  "Rex",
  "Edward",
  "Russ",
  "Rick",
  "Zeke",                          //  5
  "Possum",
  "Marco",
  "Rusty",
  "Hunter",
  "Hawk",                          // 10
  NULL                             // 11
}, SkillOptions[5 + 1] =
{ "Unskilled",                     //  0
  "Amateur",
  "Adequate",
  "Good",
  "Excellent",                     //  4
  NULL                             //  5
}, WeaponOptions[33 + 1] =
{ "Cudgel",                        //  0
  "Knife",
  "Sword",
  "VibroBlade",
  "Shortbow",
  "Longbow",                       //  5
  "Crossbow",
  "Pistol",
  "Rifle",
  "Machine Gun (man)",
  "Short Range Missiles (man)",    // 10
  "Inferno",
  "Laser Pistol",
  "Laser Rifle",
  "Flamer (man)",
  "Small Laser",                   // 15
  "Medium Laser",
  "Large Laser",
  "Phased Particle Cannon",
  "AutoCannon 2",
  "AutoCannon 5",                  // 20
  "AutoCannon 10",
  "AutoCannon 20",
  "Machine Gun (mech)",
  "Flamer (mech)",
  "Long Range Missiles 5",         // 25
  "Long Range Missiles 10",
  "Long Range Missiles 15",
  "Long Range Missiles 20",
  "Short Range Missiles 2 (mech)",
  "Short Range Missiles 4 (mech)", // 30
  "Short Range Missiles 6 (mech)",
  "Kick",                          // 32
  NULL                             // 33
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void ba_main(void)
{   tool_open  = ba_open;
    tool_loop  = ba_loop;
    tool_save  = ba_save;
    tool_close = ba_close;
    tool_exit  = ba_exit;

    if (loaded != FUNC_BATTLETECH && !ba_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_BATTLETECH;

    make_speedbar_list(GID_BA_SB1);
    load_fimage(FUNC_BATTLETECH);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_LockHeight,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_BA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            AddToolbar(GID_BA_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_BATTLETECH),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "General",
                LAYOUT_AddChild,                       gadgets[GID_BA_CH1] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH1,
                    CHOOSER_LabelArray,                &NameOptions,
                PopUpEnd,
                Label("Name:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH2] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH2,
                    GA_RelVerify,                      TRUE,
                    CHOOSER_LabelArray,                &ArmourOptions,
                PopUpEnd,
                Label("Armour type:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_BA_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_BA_IN2,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    AddLabel("of"),
                    LAYOUT_AddChild,                   gadgets[GID_BA_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_BA_IN3,
                        GA_ReadOnly,                   TRUE,
                        INTEGER_Arrows,                FALSE,
                        INTEGER_MinVisible,            2,
                    IntegerEnd,
                LayoutEnd,
                Label("Armour points:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH3] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH3,
                    CHOOSER_LabelArray,                &WeaponOptions,
                    CHOOSER_MaxLabels,                 33,
                PopUpEnd,
                Label("Weapon:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_IN1] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_BA_IN1,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   SLONG_MAX,
                    INTEGER_MinVisible,                13 + 1,
                IntegerEnd,
                Label("C-Bills:"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Skills",
                LAYOUT_AddChild,                       gadgets[GID_BA_CH4] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH4,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Bow & Blade:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH5] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH5,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Pistol:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH6] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH6,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Rifle:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH7] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH7,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Gunnery:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH8] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH8,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Piloting:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH9] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH9,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Technical:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_CH10] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_BA_CH10,
                    CHOOSER_LabelArray,                &SkillOptions,
                PopUpEnd,
                Label("Medical:"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Investments",
                LAYOUT_AddChild,                       gadgets[GID_BA_IN4] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_BA_IN4,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   SLONG_MAX,
                    INTEGER_MinVisible,                13 + 1,
                IntegerEnd,
                Label("Defiance Industries:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_BA_IN5,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   SLONG_MAX,
                    INTEGER_MinVisible,                13 + 1,
                IntegerEnd,
                Label("Nashsan Diversified:"),
                LAYOUT_AddChild,                       gadgets[GID_BA_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_BA_IN6,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   SLONG_MAX,
                    INTEGER_MinVisible,                13 + 1,
                IntegerEnd,
                Label("Baker Pharmaceuticals:"),
            LayoutEnd,
            MaximizeButton(GID_BA_BU1, "Maximize Character"),
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_BA_SB1);
    westwood();
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_BA_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_BA_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void ba_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_BA_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_BA_CH2:
        readgadgets(); // to set "armour points" fields properly
}   }

EXPORT FLAG ba_open(FLAG loadas)
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
    (   page != FUNC_BATTLETECH
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_ch(GID_BA_CH2, &armourtype);
    // assert(armourtype >= 0 && armourtype <= 5);
    DISCARD SetGadgetAttrs(gadgets[GID_BA_IN2], MainWindowPtr, NULL, INTEGER_Maximum, limit[armourtype], TAG_DONE); // this autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_BA_IN3], MainWindowPtr, NULL, INTEGER_Number,  limit[armourtype], TAG_DONE); // this autorefreshes
    either_in(GID_BA_IN2, &armourpoints);

    either_in(GID_BA_IN1, &gp);
    either_in(GID_BA_IN4, &investment[0]);
    either_in(GID_BA_IN5, &investment[1]);
    either_in(GID_BA_IN6, &investment[2]);

    either_ch(GID_BA_CH1, &name);
    either_ch(GID_BA_CH3, &weapon);
    for (i = 0; i < 7; i++)
    {   either_ch(GID_BA_CH4 + i, &skill[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 1;                 //   $0
    serialize1(&name);          //   $1
    offset += 3;                //   $2..$  4
    for (i = 0; i < 7; i++)
    {   serialize1(&skill[i]);  //   $5..$  B
        if (skill[i] > 4)
        {   skill[i] = 4;
    }   }
    serialize1(&weapon);        //   $C
    offset++;                   //   $D
    serialize1(&armourtype);    //   $E
    serialize1(&armourpoints);  //   $F
    offset = 0xD6D;             //  $10..$D6C
    serialize4(&gp);            // $D6D..$D70
    serialize4(&investment[0]); // $D71..$D74
    serialize4(&investment[1]); // $D75..$D78
    serialize4(&investment[2]); // $D79..$D7C
}

EXPORT void ba_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("Game?", "BattleTech", saveas, 3929, FLAG_S, FALSE);
}

EXPORT void ba_close(void) { ; }
EXPORT void ba_exit(void)  { ; }

MODULE void maximize_man(void)
{   gp            =
    investment[0] =
    investment[1] =
    investment[2] = ONE_BILLION;
    skill[0]      =
    skill[1]      =
    skill[2]      =
    skill[3]      =
    skill[4]      =
    skill[5]      =
    skill[6]      =           4; // excellent
    armourtype    =           5; // ablative
    armourpoints  =          50;
    weapon        =          13; // laser rifle
}
