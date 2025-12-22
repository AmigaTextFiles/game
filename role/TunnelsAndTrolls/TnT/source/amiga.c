// INCLUDES---------------------------------------------------------------

#include <exec/types.h>
#include <exec/resident.h>
#include <dos/dos.h>
#include <dos/dostags.h>
#include <intuition/intuition.h>
#include <intuition/icclass.h>
#include <libraries/gadtools.h>
#include <intuition/sghooks.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#include <workbench/workbench.h>
#include <workbench/startup.h>

#include <proto/amigaguide.h>
#include <proto/asl.h>
#include <proto/diskfont.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/gadtools.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/wb.h>
#include <proto/listbrowser.h>
#include <proto/texteditor.h>
#include <clib/alib_protos.h>

#ifdef __SASC
    #include <dos.h> // geta4()
#else
    #define geta4()
#endif /* of __SASC */

#include <gadgets/clock.h>
#include <gadgets/texteditor.h>

#include <ctype.h> // isupper()
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <error.h> // errno
#include <sys/dir.h>

#include "openurl.h"

#include "tnt.h"

// DEFINES----------------------------------------------------------------

// #define USECLOCK
// whether to use clock.gadget

#define USETOPAZPLUS8
// whether to prefer Topaz+1200.font (otherwise Topaz.font)

// #define TRACKENTRY
// whether to log startup to console
#define TRACKDELAY 25

#define ZERO (BPTR) NULL

#define OS_ANY  0
#define OS_12  33
#define OS_13  34
#define OS_20  36
#define OS_204 37
#define OS_21  38
#define OS_30  39
#define OS_31  40
#define OS_35  44
#define OS_39  45
#define OS_32  47
#define OS_40  51
#define OS_41  53

#ifndef BITMAP_Transparent     // OS4-only tag
    #define BITMAP_Transparent (BITMAP_Dummy + 18)
#endif
#ifndef TextEditorObject       // OS4 defines this, OS3 doesn't
    #define TextEditorObject   NewObject(TEXTEDITOR_GetClass(), NULL
#endif
#ifndef TextEditorEnd          // OS4 defines this, OS3 doesn't
    #define TextEditorEnd      TAG_END)
#endif

#define AddHLayout        LAYOUT_AddChild, HLayoutObject
#define AddVLayout        LAYOUT_AddChild, VLayoutObject
#define AddSpace          LAYOUT_AddChild, SpaceObject, SpaceEnd
#define AddLabel(x)       LAYOUT_AddImage, LabelObject, LABEL_Text, x, LabelEnd
#define AddImage(x)       LAYOUT_AddImage, image[x], CHILD_NoDispose, TRUE
#define ListIsEmpty(x)    (!(((x)->lh_Head)->ln_Succ))
#define ListIsFull(x)     (((x)->lh_Head)->ln_Succ)

// main window
#define GID_LY1   0
#define GID_IN2   1
#define GID_IN3   2
#define GID_IN4   3
#define GID_IN5   4
#define GID_IN6   5
#define GID_IN7   6
#define GID_IN8   7
#define GID_IN9   8
#define GID_IN10  9
#define GID_IN15 10
#define GID_IN16 11
#define GID_IN17 12
#define GID_IN18 13
#define GID_IN19 14
#define GID_IN20 15
#define GID_IN21 16
#define GID_IN22 17
#define GID_IN23 18
#define GID_IN24 19
#define GID_LB1  20 // spells
#define GID_LB2  21 // items
#define GID_TE1  22
#define GID_SC1  23
#define GID_ST1  24 // input
#define GID_ST2  25 // location
#define GID_ST3  26 // time
#define GID_LY2  27
#define GID_BU1  28
#define GID_BU2  29
#define GID_BU3  30
#define GID_BU4  31
#define GID_BU5  32
#define GID_BU6  33
#define GID_BU7  34
#define GID_BU8  35
#define GID_BU9  36
#define GID_BU10 37
#define GID_BU11 38
#define GID_BU12 39
#define GID_BU13 40
#define GID_BU14 41
#define GID_BU15 42
#define GID_BU16 43
#define GID_BU17 44
#define GID_BU18 45
#define GID_BU19 46
#define GID_BU20 47
#define GID_BU21 48
#define GID_BU24 49
#define GID_CL1  50

// graphics window
#define GID_LY3  51

// about window
#define GID_BU22 52
#define GID_BU23 53

// reaction window
#define GID_LB3  54 // ReAction class versions

#define GIDS     GID_LB3

#define ARGUMENTS         3

#define BITMAP_LOGO       0
#define BITMAP_AMIGAN     1
#define BITMAP_REACTION   2
#define FIRSTBITMAP_ITEMS 3
#define LASTBITMAP_ITEMS  (FIRSTBITMAP_ITEMS + ITEMCATEGORIES - 1)
#define BITMAPS           (LASTBITMAP_ITEMS                   + 1)

#define SCAN_TAB  66
#define SCAN_ESC  69
#define SCAN_HELP 95

// menus
#define MN_PROJECT    0
#define MN_HELP       1

// Project menu
#define IN_ICONIFY    0
#define IN_QUIT       1

// Help menu
#define IN_MANUAL     0
// ---
#define IN_UPDATE     2
// ---
#define IN_REACTION   4
#define IN_ABOUT      5

#define CLOCKPEN_BLACK     0
#define CLOCKPEN_DARKBLUE  1
#define CLOCKPEN_GREY      2
#define CLOCKPENS          3

// EXPORTED VARIABLES-----------------------------------------------------

EXPORT FLAG                    reactable        = FALSE;
EXPORT TEXT                    colourscreen[65536 + 1],
                               userinput[MAX_PATH + 1] = "";
EXPORT struct Window          *AboutWindowPtr   = NULL,
                              *MainWindowPtr    = NULL;
EXPORT struct Library         *AslBase          = NULL,
                              *BitMapBase       = NULL,
                              *BoingBallBase    = NULL,
                              *ButtonBase       = NULL,
                              *DiskfontBase     = NULL,
                              *IconBase         = NULL,
                              *IntegerBase      = NULL,
                              *LabelBase        = NULL,
                              *LayoutBase       = NULL,
                              *ListBrowserBase  = NULL,
                              *OpenURLBase      = NULL,
                              *ScrollerBase     = NULL,
                              *SocketBase       = NULL,
                              *SpaceBase        = NULL,
                              *StringBase       = NULL,
                              *TextFieldBase    = NULL,
                              *WindowBase       = NULL;
EXPORT struct ClassLibrary*    ClockBase        = NULL;
EXPORT        Class*           ClockClass       = NULL;
EXPORT struct ClockHandSize    shapeNoSecond    = { 0, 0, 0, 0, 0 };

/* #ifdef __SASC
    EXPORT char __near __stdiowin[] = "CON:0/0/658/512/T&T Output",
                       __stdiov37[] = "/AUTO/CLOSE";
#endif */

// IMPORTED VARIABLES-----------------------------------------------------

IMPORT int                     age,
                               class,
                               column,
                               gp, sp, cp,
                               height,
                               level, xp,
                               minutes,
                               module,
                               race,
                               room,
                               row,
                               sex,
                               sheet_chosen,
                               st, max_st, iq, lk, con, max_con, dex, chr, spd,
                               textcolour,
                               weight,
                               winwidth, winheight,
                               winx, winy;
IMPORT SWORD*                  exits;
IMPORT FLAG                    avail_armour,
                               avail_cast,
                               avail_drop,
                               avail_fight,
                               avail_get,
                               avail_hands,
                               avail_look,
                               avail_options,
                               avail_proceed,
                               avail_random,
                               avail_autofight,
                               avail_use,
                               avail_view,
                               colours,
                               gotman,
                               logconsole,
                               onekey,
                               rawmode,
                               showunimp;
IMPORT UBYTE                   gfx;
IMPORT TEXT                    ck_filename[MAX_PATH + 1],
                               imagename[MAX_PATH + 1],
                               name[80 + 1],
                               pathname[MAX_PATH + 1],
                               pictitle[60 + 1],
                               specialopt_long[8][20 + 1],
                               specialopt_short[8][10 + 1],
                               userstring[40 + 1],
                               vanillascreen[65536 + 1];
IMPORT FILE*                   LogfileHandle;
IMPORT const STRPTR            picname[],
                               table_classes[4],
                               table_sex[2];
IMPORT struct AbilityStruct    ability[ABILITIES];
IMPORT struct ItemStruct       items[ITEMS];
IMPORT struct ModuleInfoStruct moduleinfo[MODULES];
IMPORT struct RacesStruct      races[RACES];
IMPORT struct SpellStruct      spell[SPELLS];

IMPORT int                     errno; // special SAS/C variable

// MODULE VARIABLES-------------------------------------------------------

MODULE int                     fontx;
MODULE BPTR                    ProgLock      /* = ZERO */ ;
MODULE FLAG                    guideexists      = FALSE,
                               globaldone,
                               morphos          = FALSE,
                               needabout        = FALSE,
                               needgfx          = FALSE;
MODULE TEXT                    screenname[MAXPUBSCREENNAME + 1],
                               titlebarstr[80 + 1];
MODULE UWORD                   wbver,
                               wbrev;
MODULE LONG                    pens[CLOCKPENS];
MODULE ULONG                   AboutSignal      = 0,
                               AppSignal,
                               GfxSignal        = 0,
                               MainSignal;
MODULE struct List             ItemsList,
                               SpellsList;
MODULE struct DrawInfo*        DrawInfoPtr      = NULL;
MODULE struct Image*           image[BITMAPS];
MODULE struct Menu*            MenuPtr;
MODULE struct Gadget*          gadgets[GIDS + 1];
MODULE struct MsgPort*         AppPort          = NULL;
MODULE struct Screen*          ScreenPtr        = NULL;
MODULE struct TextAttr*        FontAttrPtr      = NULL;
MODULE struct TextFont*        FontPtr          = NULL;
MODULE struct VisualInfo*      VisualInfoPtr    = NULL;
MODULE struct WBArg*           WBArg;
MODULE struct WBStartup*       WBMsg;
MODULE struct Window*          GfxWindowPtr     = NULL;
MODULE Object                 *AboutWinObject   = NULL,
                              *imageptr         = NULL,
                              *GfxObject        = NULL,
                              *WinObject        = NULL;

#if defined(__SASC) || defined(__GNUC__) || defined(__STORM__)
    MODULE struct Library* VersionBase;
#endif

// MODULE ARRAYS----------------------------------------------------------

// (none)

// MODULE STRUCTURES------------------------------------------------------

MODULE struct TextAttr Topaz8 =
{   (STRPTR) "topaz.font"     , 8, FS_NORMAL, FPF_ROMFONT  | FPF_DESIGNED // "topaz.font" is case-sensitive
}
#ifdef USETOPAZPLUS8
, TopazPlus8 =
{   (STRPTR) "Topaz+1200.font", 8, FS_NORMAL, FPF_DISKFONT | FPF_DESIGNED
}
#endif
;

MODULE struct ColumnInfo ItemsColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    NULL,              /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { -1,
    (STRPTR)~0,
    -1
} }, SpellsColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    NULL,              /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { -1,
    (STRPTR)~0,
    -1
} };

MODULE struct TagItem SCtoTEmap[] = {
{ SCROLLER_Top,               GA_TEXTEDITOR_Prop_First   },
{ SCROLLER_Total,             GA_TEXTEDITOR_Prop_Entries },
{ SCROLLER_Visible,           GA_TEXTEDITOR_Prop_Visible },
{ TAG_END,                    0                          }
}, TEtoSCmap[] = {
{ GA_TEXTEDITOR_Prop_First,   SCROLLER_Top               },
{ GA_TEXTEDITOR_Prop_Entries, SCROLLER_Total             },
{ GA_TEXTEDITOR_Prop_Visible, SCROLLER_Visible           },
{ TAG_END,                    0                          }
};

MODULE struct NewMenu NewMenu[] =
{   { NM_TITLE, "Project"                            ,  0 , 0              ,  0     , 0},
    {  NM_ITEM, "Iconify"                            , "I", 0              ,  0     , 0},
    {  NM_ITEM, "Quit T&T"                           , "Q", 0              ,  0     , 0},
    { NM_TITLE, "Help"                               ,  0 , 0              ,  0     , 0},
    {  NM_ITEM, "Manual..."                          , "M", NM_ITEMDISABLED,  0     , 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0              ,  0     , 0},
    {  NM_ITEM, "Check for updates..."               , "U", 0              ,  0     , 0},
    {  NM_ITEM, NM_BARLABEL                          ,  0 , 0              ,  0     , 0},
    {  NM_ITEM, "About ReAction..."                  ,  0 , 0              ,  0     , 0},
    {  NM_ITEM, "About T&T..."                       , "?", 0              ,  0     , 0},
    {   NM_END, NULL                                 ,  0 , 0              ,  0     , 0}
};

// MODULE FUNCTIONS-------------------------------------------------------

MODULE void lockscreen(void);
MODULE void unlockscreen(void);
MODULE void lb_clearlist(struct List* ListPtr);
MODULE void write_integer(int gid, ULONG number);
MODULE void load_image(void);
MODULE void iconify(void);
MODULE void uniconify(void);
MODULE void handlemenus(UWORD code);
MODULE void about_loop(void);
MODULE void load_images(int thefirst, int thelast, FLAG transparent);
MODULE void parsewb(void);
MODULE void getclockpens(void);
MODULE void help_reaction(void);

MODULE void InitHook(struct Hook* hook, ULONG (*func)(), void* data);
MODULE ULONG MainHookFunc(struct Hook* h, VOID* o, VOID* msg);
MODULE ULONG StringHookFunc(struct Hook* hook, struct SGWork* sgw, ULONG* msg);

// CODE-------------------------------------------------------------------

EXPORT int main(int argc, char** argv)
{   int            i;
    SLONG          args[ARGUMENTS + 1];
    struct RDArgs* ArgsPtr;

    // Start of program.

    engine_init();

    screenname[0] = EOS;
    for (i = 0; i <= ARGUMENTS; i++)
    {   args[i] = 0;
    }
    for (i = 0; i < BITMAPS; i++)
    {   image[i] = NULL;
    }
    NewList(&ItemsList);
    NewList(&SpellsList);

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("1...\n"); Delay(TRACKDELAY);
#endif

    if ((VersionBase     = (struct Library*) OpenLibrary("version.library",
       OS_ANY)))
    {   wbver = VersionBase->lib_Version;
        wbrev = VersionBase->lib_Revision;
        CloseLibrary(VersionBase);
        VersionBase = NULL;
    } else
    {   wbver = OS_20;
        wbrev = 0;
    }

    ProgLock = GetProgramDir(); // never unlock this!
    guideexists = Exists((STRPTR) "PROGDIR:TnT.guide");

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("2...\n"); Delay(TRACKDELAY);
#endif

    if
    (   (BitMapBase      = (struct Library*) OpenLibrary("images/bitmap.image",        OS_35 ))
     && (ButtonBase      = (struct Library*) OpenLibrary("gadgets/button.gadget",      OS_ANY))
     && (DiskfontBase    = (struct Library*) OpenLibrary("diskfont.library",           OS_ANY))
     && (IconBase        = (struct Library*) OpenLibrary("icon.library",               OS_ANY))
     && (IntegerBase     = (struct Library*) OpenLibrary("gadgets/integer.gadget",     OS_35 ))
     && (LabelBase       = (struct Library*) OpenLibrary("images/label.image",         OS_35 ))
     && (LayoutBase      = (struct Library*) OpenLibrary("gadgets/layout.gadget",      OS_35 ))
     && (ListBrowserBase = (struct Library*) OpenLibrary("gadgets/listbrowser.gadget", OS_ANY))
     && (WindowBase      = (struct Library*) OpenLibrary("window.class",               OS_31 ))
     && (ScrollerBase    = (struct Library*) OpenLibrary("gadgets/scroller.gadget",    OS_ANY))
     && (SpaceBase       = (struct Library*) OpenLibrary("gadgets/space.gadget",       OS_35 ))
     && (StringBase      = (struct Library*) OpenLibrary("gadgets/string.gadget",      OS_ANY))
    )
    {   reactable = TRUE;

#ifdef USECLOCK
        if ((ClockBase = (struct ClassLibrary*) OpenLibrary("gadgets/clock.gadget",    OS_ANY)))
        {   ClockClass = ClockBase->cl_Class;
        }
#endif
    }
    BoingBallBase = OpenLibrary("images/boingball.image", OS_32); // older versions don't work at all

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("3...\n"); Delay(TRACKDELAY);
#endif

    if (FindResident("MorphOS"))
    {   morphos = TRUE;

        AmigaGuideBase = OpenLibrary("amigaguide.library", OS_ANY);
    } elif (reactable)
    {   TextFieldBase  = (struct Library*) OpenLibrary("gadgets/texteditor.gadget",    OS_ANY);
    }

    OpenURLBase = OpenLibrary("openurl.library"  , 0);
    SocketBase  = OpenLibrary("bsdsocket.library", 3);
    AslBase     = OpenLibrary("asl.library"      , 0);

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("4...\n"); Delay(TRACKDELAY);
#endif

    if (!(AppPort = CreateMsgPort()))
    {   printf("Can't create message port!\n");
        quit(EXIT_FAILURE);
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("5...\n"); Delay(TRACKDELAY);
#endif

    if (argc) // started from CLI
    {   if (!(ArgsPtr = (struct RDArgs*) ReadArgs
        (   "PUBSCREEN/K," \
               "USERID/K," \
                   "FILE",
            (LONG*) args,
            NULL
        )))
        {   printf
            (   "Usage: %s [PUBSCREEN <screen>] [USERID <userid>] [[FILE] <filename>]\n",
                argv[0]
            );
            quit(EXIT_FAILURE);
        }

        if (args[0])
        {   strcpy(screenname, (STRPTR) args[0]);
        }
        if (args[1])
        {   strcpy(userstring, (STRPTR) args[1]);
        }
        if (args[2])
        {   strcpy(name, (STRPTR) args[2]);
            name[0] = toupper(name[0]);
        }

        FreeArgs(ArgsPtr);
        // ArgsPtr = NULL;
    } else // started from WB
    {   BPTR OldDir;

        WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList; // head of the arg list
        for (i = 0; i < (int) WBMsg->sm_NumArgs; i++, WBArg++)
        {   if (WBArg->wa_Lock)
            {   // something that does not support locks
                parsewb();
            } else
            {   // lock supported; change to the proper directory
                OldDir = CurrentDir(WBArg->wa_Lock);
                parsewb();
                DISCARD CurrentDir(OldDir);
            }
            if (i == 1)
            {   ; // we were started from a project icon, which is
                  // currently unsupported
    }   }   }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("6...\n"); Delay(TRACKDELAY);
#endif

    if (userstring[0])
    {   reactable = FALSE;
    }

    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }
    lockscreen();
    DrawInfoPtr = (struct DrawInfo*) GetScreenDrawInfo(ScreenPtr);
    unlockscreen();

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("7...\n"); Delay(TRACKDELAY);
#endif

    engine_main();

    // control never reaches here
}

EXPORT void system_die2(void)
{   int             i;
    struct Message* MsgPtr;

    unlockscreen();

    close_about();

    for (i = 0; i < BITMAPS; i++)
    {   if (image[i])
        {   DisposeObject((Object*) image[i]);
            image[i] = NULL;
    }   }

    if (FontPtr)
    {   CloseFont(FontPtr);
        FontPtr = NULL;
    }

    if (AppPort)
    {   while ((MsgPtr = GetMsg(AppPort)))
        {   ReplyMsg(MsgPtr);
        }
        DeleteMsgPort(AppPort);
        AppPort = NULL;
    }

    if  (AmigaGuideBase) CloseLibrary(AmigaGuideBase);
    if         (AslBase) CloseLibrary(AslBase);
    if      (BitMapBase) CloseLibrary(BitMapBase);
    if   (BoingBallBase) CloseLibrary(BoingBallBase);
    if      (ButtonBase) CloseLibrary(ButtonBase);
    if       (ClockBase) CloseLibrary((struct Library*) ClockBase);
    if    (DiskfontBase) CloseLibrary(DiskfontBase);
    if        (IconBase) CloseLibrary(IconBase);
    if     (IntegerBase) CloseLibrary(IntegerBase);
    if       (LabelBase) CloseLibrary(LabelBase);
    if      (LayoutBase) CloseLibrary(LayoutBase);
    if (ListBrowserBase) CloseLibrary(ListBrowserBase);
    if     (OpenURLBase) CloseLibrary(OpenURLBase);
    if    (ScrollerBase) CloseLibrary(ScrollerBase);
    if      (SocketBase) CloseLibrary(SocketBase);
    if       (SpaceBase) CloseLibrary(SpaceBase);
    if      (StringBase) CloseLibrary(StringBase);
    if   (TextFieldBase) CloseLibrary(TextFieldBase);
    if      (WindowBase) CloseLibrary(WindowBase);
}

EXPORT void open_gfx(void)
{   BPTR OldDir /* = ZERO */ ;
    TEXT tempstring[80 + 1];

    if (!gfx || userstring[0] || imagename[0] == EOS)
    {   return;
    }

    if (reactable)
    {   load_image();
        lockscreen();
        if (!(GfxObject =
        WindowObject,
            WA_PubScreen,                                      ScreenPtr,
            WA_Title,                                          pictitle,
            WA_ScreenTitle,                                    "Tunnels & Trolls " DECIMALVERSION,
            WA_Activate,                                       FALSE,
            WA_DepthGadget,                                    TRUE,
            WA_DragBar,                                        TRUE,
            WA_CloseGadget,                                    TRUE,
            WA_SizeGadget,                                     FALSE,
            WINDOW_Position,                                   WPOS_CENTERMOUSE,
            WINDOW_ParentGroup,                                gadgets[GID_LY3] =
            VLayoutObject,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_SpaceInner,                             TRUE,
                LAYOUT_DeferLayout,                            TRUE,
                LAYOUT_AddImage,                               imageptr,
                CHILD_NoDispose,                               TRUE,
            LayoutEnd,
        WindowEnd))
        {   printf("Can't create graphics window gadgets!\n");
            quit(EXIT_FAILURE);
        }
        if (!(GfxWindowPtr = (struct Window*) RA_OpenWindow(GfxObject)))
        {   printf("Can't open graphics window!\n");
            quit(EXIT_FAILURE);
        }
        MoveWindow
        (   GfxWindowPtr,
            ScreenPtr->Width - GfxWindowPtr->Width - GfxWindowPtr->LeftEdge,
            -(GfxWindowPtr->TopEdge)
        );
        unlockscreen();
        MoveWindowInFrontOf(MainWindowPtr, GfxWindowPtr);

        DISCARD GetAttr(WINDOW_SigMask, GfxObject, &GfxSignal);

        LendMenus(GfxWindowPtr, MainWindowPtr);
    } else
    {   if (wbver >= OS_30)
        {   printf("Close the illustration window to continue.\n");
            OldDir = CurrentDir(ProgLock);
            sprintf(tempstring, "SYS:Utilities/MultiView %s", &imagename[8]); // to skip "PROGDIR:" component
            DISCARD SystemTags(tempstring, TAG_DONE);
            DISCARD CurrentDir(OldDir);
            // ActivateWindow(ConsoleWindowPtr);
}   }   }

EXPORT void open_sheet(void)
{   TRANSIENT struct Node*       NodePtr;
    TRANSIENT struct TextAttr*   DesiredFontPtr;
    TRANSIENT struct DiskObject* IconifiedIcon;
    PERSIST   struct Hook        MainHookStruct,
                                 StringHookStruct;

    // assert(!MainWindowPtr);

    if (!reactable)
    {   return;
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("8...\n"); Delay(TRACKDELAY);
#endif

    if (gotman)
    {   sprintf
        (   titlebarstr,
            "%s%s (%s %s %s)",
            ability[122].known ? ((sex == FEMALE) ? "Dame " : "Sir ") : "",
            name,
            table_sex[sex],
            races[race].singular,
            table_classes[class]
        );
    } else
    {   strcpy(titlebarstr, "Tunnels & Trolls ");
        strcat(titlebarstr, DECIMALVERSION);
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("9...\n"); Delay(TRACKDELAY);
#endif

    load_images(FIRSTBITMAP_ITEMS, LASTBITMAP_ITEMS, TRUE);

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("10...\n"); Delay(TRACKDELAY);
#endif

    NodePtr = (struct Node *) AllocListBrowserNode
    (   6,
        LBNA_Column, 0,
        LBNCA_Text,  "",
        LBNA_Column, 1,
        LBNCA_Text,  "",
        LBNA_Column, 2,
        LBNCA_Text,  "",
        LBNA_Column, 3,
        LBNCA_Text,  "",
        LBNA_Column, 4,
        LBNCA_Text,  "",
        LBNA_Column, 5,
        LBNCA_Text,  "",
    TAG_END);
    // we should check NodePtr is non-zero
    AddTail(&ItemsList, (struct Node *) NodePtr);
#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("11...\n"); Delay(TRACKDELAY);
#endif
    NodePtr = (struct Node *) AllocListBrowserNode
    (   4,
        LBNA_Column, 0,
        LBNCA_Text,  "",
        LBNA_Column, 1,
        LBNCA_Text,  "",
        LBNA_Column, 2,
        LBNCA_Text,  "",
        LBNA_Column, 3,
        LBNCA_Text,  "",
    TAG_END);
    // we should check NodePtr is non-zero
    AddTail(&SpellsList, (struct Node *) NodePtr);
#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("12...\n"); Delay(TRACKDELAY);
#endif

    InitHook(&MainHookStruct,   (ULONG (*)()) MainHookFunc,   NULL);
    InitHook(&StringHookStruct, (ULONG (*)()) StringHookFunc, NULL);

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("13...\n"); Delay(TRACKDELAY);
#endif

#ifdef USETOPAZPLUS8
    DesiredFontPtr = &TopazPlus8;
    if ((FontPtr = (struct TextFont*) OpenDiskFont(DesiredFontPtr)))
    {   FontAttrPtr = DesiredFontPtr;
    } else
    {
#endif
        DesiredFontPtr = &Topaz8;
        if ((FontPtr = (struct TextFont*) OpenDiskFont(DesiredFontPtr)))
        {   FontAttrPtr = DesiredFontPtr;
        }
#ifdef USETOPAZPLUS8
    }
#endif

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("14...\n"); Delay(TRACKDELAY);
#endif

    fontx    = FontPtr->tf_XSize;
 // fonty    = FontPtr->tf_YSize;
 // baseline = FontPtr->tf_Baseline; // distance from the top of char to baseline

    if (TextFieldBase)
    {   gadgets[GID_LY2] =
        HLayoutObject,
            LAYOUT_AddChild,                               gadgets[GID_TE1] = (struct Gadget*)
            TextEditorObject,
                GA_ID,                                     GID_TE1,
                GA_ReadOnly,                               TRUE,
                GA_RelVerify,                              TRUE, // maybe unnecessary
                FontAttrPtr ? GA_TextAttr : TAG_IGNORE,    FontAttrPtr,
                ICA_MAP,                                   TEtoSCmap,
            TextEditorEnd,
            CHILD_MinWidth,                                660, // this is the minimum for poker cards to not get word-wrapped
            LAYOUT_AddChild,                               gadgets[GID_SC1] = (struct Gadget*)
            ScrollerObject,
                GA_ID,                                     GID_SC1,
                GA_RelVerify,                              TRUE,
                SCROLLER_Orientation,                      SORIENT_VERT,
                SCROLLER_Arrows,                           TRUE, // this is the default anyway
                ICA_MAP,                                   SCtoTEmap,
            ScrollerEnd,
            CHILD_WeightedWidth,                           0,
        LayoutEnd;
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("15...\n"); Delay(TRACKDELAY);
#endif

    if (ClockBase)
    {   getclockpens();

        gadgets[GID_CL1] = (struct Gadget*)
        NewObject(ClockClass, NULL,
            GA_ID,                                GID_CL1,
            GA_RelVerify,                         TRUE,
            CLOCKGA_HourHand_Pen,                 pens[CLOCKPEN_BLACK   ],
            CLOCKGA_MinuteHand_Pen,               pens[CLOCKPEN_DARKBLUE],
            CLOCKGA_Shadows_Pen,                  pens[CLOCKPEN_GREY    ],
            CLOCKGA_SecondHand_Size,              &shapeNoSecond,
            CLOCKGA_AntiAlias,                    0,
        TAG_DONE);
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("16...\n"); Delay(TRACKDELAY);
#endif

    IconifiedIcon = GetDiskObjectNew("PROGDIR:TnT");

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("17...\n"); Delay(TRACKDELAY);
#endif

    lockscreen();

    if (!(VisualInfoPtr = (struct VisualInfo*) GetVisualInfo(ScreenPtr, TAG_DONE)))
    {   printf("Can't get GadTools visual info!\n");
        quit(EXIT_FAILURE);
    }
    if (!(MenuPtr = (struct Menu*) CreateMenus(NewMenu, TAG_DONE)))
    {   printf("Can't create menus!\n");
        quit(EXIT_FAILURE);
    }
    if (!(LayoutMenus(MenuPtr, VisualInfoPtr, GTMN_NewLookMenus, TRUE, TAG_DONE)))
    {   printf("Can't lay out menus!\n");
        quit(EXIT_FAILURE);
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("18...\n"); Delay(TRACKDELAY);
#endif

    if (!(WinObject =
    WindowObject,
        WA_PubScreen,                                      ScreenPtr,
        WA_Title,                                          titlebarstr,
        WA_ScreenTitle,                                    "Tunnels & Trolls " DECIMALVERSION,
        WA_Activate,                                       TRUE,
        WA_DepthGadget,                                    TRUE,
        WA_DragBar,                                        TRUE,
        WA_CloseGadget,                                    TRUE,
        WA_SizeGadget,                                     TRUE,
        WA_Left,                                           (winx      == -1) ? 0                   : ((ULONG) winx),
        WA_Top,                                            (winy      == -1) ? 0                   : ((ULONG) winy),
        WA_Width,                                          (winwidth  == -1) ? 640                 : ((ULONG) winwidth),
        WA_Height,                                         (winheight == -1) ? (ScreenPtr->Height) : ((ULONG) winheight),
        WA_IDCMP,                                          IDCMP_MOUSEBUTTONS,
        WINDOW_IconifyGadget,                              TRUE,
        WINDOW_IconTitle,                                  "T&T",
        IconifiedIcon ? WINDOW_Icon : TAG_IGNORE,          IconifiedIcon,
        WINDOW_AppPort,                                    AppPort,
        WINDOW_IDCMPHook,                                  &MainHookStruct,
        WINDOW_IDCMPHookBits,                              IDCMP_MOUSEBUTTONS,
        WINDOW_MenuStrip,                                  MenuPtr,
        WINDOW_ParentGroup,                                gadgets[GID_LY1] =
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            TextFieldBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_LY2],
            TextFieldBase ? CHILD_WeightedHeight : TAG_IGNORE, 70,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Commands",
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    AddLabel(">"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_ST1,
                        GA_RelVerify,                      TRUE,
                        GA_TabCycle,                       TRUE, // otherwise Tab key causes crap to be inserted
                        STRINGA_TextVal,                   userinput,
                        STRINGA_Buffer,                    userinput,
                        STRINGA_MaxChars,                  MAX_PATH + 1,
                        STRINGA_ExitHelp,                  TRUE,
                        STRINGA_EditHook,                  &StringHookStruct,
                    StringEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_BU1] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU1,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU2] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU2,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU3] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU3,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU4] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU4,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU5] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU5,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU6] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU6,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU7] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU7,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU8] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU8,
                        GA_RelVerify,                      TRUE,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "-",
                        LabelEnd,
                    ButtonEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_BU9] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU9,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "A",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "rmour",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU10] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU10,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "C",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ast",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU11] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU11,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "D",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "rop",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU12] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU12,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "F",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ight",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU13] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU13,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "G",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "et",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU14] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU14,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "H",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ands",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU15] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU15,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "L",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ook",
                        LabelEnd,
                    ButtonEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_BU16] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU16,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "O",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ptions",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU17] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU17,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "P",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "roceed",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU18] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU18,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "Q",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "uit",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU24] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU24,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "R",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "andom",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU19] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU19,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "au",
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "T",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "ofight",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU20] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU20,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "U",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "se",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_BU21] = (struct Gadget*)
                    ButtonObject,
                        GA_ID,                             GID_BU21,
                        GA_RelVerify,                      TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_DrawInfo,                DrawInfoPtr, // needed!
                            LABEL_SoftStyle,               FSF_BOLD,
                            LABEL_Text,                    "V",
                            LABEL_SoftStyle,               FS_NORMAL,
                            LABEL_Text,                    "iew",
                        LabelEnd,
                    ButtonEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    AddHLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "General",
                        AddVLayout,
                            AddLabel("Level:"),
                            AddLabel("Carried:"),
                            AddLabel("GP:"),
                            AddLabel("Location:"),
                            AddLabel("Time:"),
                        LayoutEnd,
                        CHILD_WeightedWidth,               0,
                        AddVLayout,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                LAYOUT_AddChild,           gadgets[GID_IN15] =
                                IntegerObject,
                                    GA_ID,                 GID_IN15,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                IntegerEnd,
                                AddLabel("AP:"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_IN16] =
                                IntegerObject,
                                    GA_ID,                 GID_IN16,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                IntegerEnd,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                LAYOUT_AddChild,           gadgets[GID_IN20] =
                                IntegerObject,
                                    GA_ID,                 GID_IN20,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                 // INTEGER_MinVisible,    5,
                                IntegerEnd,
                                AddLabel("."),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_IN21] =
                                IntegerObject,
                                    GA_ID,                 GID_IN21,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                    INTEGER_MinVisible,    1,
                                IntegerEnd,
                                CHILD_WeightedWidth,       0,
                                AddLabel("# of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_IN22] =
                                IntegerObject,
                                    GA_ID,                 GID_IN22,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                 // INTEGER_MinVisible,    5,
                                IntegerEnd,
                                AddLabel("#"),
                                CHILD_WeightedWidth,       0,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                LAYOUT_AddChild,           gadgets[GID_IN17] =
                                IntegerObject,
                                    GA_ID,                 GID_IN17,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                IntegerEnd,
                                AddLabel("SP:"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_IN18] =
                                IntegerObject,
                                    GA_ID,                 GID_IN18,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                IntegerEnd,
                                AddLabel("CP:"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_IN19] =
                                IntegerObject,
                                    GA_ID,                 GID_IN19,
                                    GA_ReadOnly,           TRUE,
                                    INTEGER_Arrows,        FALSE,
                                IntegerEnd,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ST2] = (struct Gadget*)
                            StringObject,
                                GA_ID,                     GID_ST2,
                                GA_ReadOnly,               TRUE,
                                STRINGA_TextVal,           "",
                            StringEnd,
                            LAYOUT_AddChild,               gadgets[GID_ST3] = (struct Gadget*)
                            StringObject,
                                GA_ID,                     GID_ST3,
                                GA_ReadOnly,               TRUE,
                                STRINGA_TextVal,           "",
                            StringEnd,
                        LayoutEnd,
                        ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_CL1],
                        ClockBase ? CHILD_MinWidth       : TAG_IGNORE,  64,
                        ClockBase ? CHILD_MinHeight      : TAG_IGNORE,  64,
                        ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 100,
                        ClockBase ? CHILD_WeightedWidth  : TAG_IGNORE, 100,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Adds",
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        AddLabel("Melee:"),
                        CHILD_WeightedWidth,               0,
                        LAYOUT_AddChild,                   gadgets[GID_IN23] =
                        IntegerObject,
                            GA_ID,                         GID_IN23,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                        AddLabel("Missile:"),
                        CHILD_WeightedWidth,               0,
                        LAYOUT_AddChild,                   gadgets[GID_IN24] =
                        IntegerObject,
                            GA_ID,                         GID_IN24,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Attributes",
                    AddVLayout,
                        AddLabel("Strength:"),
                        AddLabel("Intelligence:"),
                        AddLabel("Luck:"),
                        AddLabel("Constitution:"),
                        AddLabel("Dexterity:"),
                        AddLabel("Charisma:"),
                        AddLabel("Speed:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_IN2] =
                            IntegerObject,
                                GA_ID,                     GID_IN2,
                                GA_ReadOnly,               TRUE,
                                INTEGER_Arrows,            FALSE,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,               gadgets[GID_IN3] =
                            IntegerObject,
                                GA_ID,                     GID_IN3,
                                GA_ReadOnly,               TRUE,
                                INTEGER_Arrows,            FALSE,
                            IntegerEnd,
                        LayoutEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IN4] =
                        IntegerObject,
                            GA_ID,                         GID_IN4,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IN5] =
                        IntegerObject,
                            GA_ID,                         GID_IN5,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_IN6] =
                            IntegerObject,
                                GA_ID,                     GID_IN6,
                                GA_ReadOnly,               TRUE,
                                INTEGER_Arrows,            FALSE,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,               gadgets[GID_IN7] =
                            IntegerObject,
                                GA_ID,                     GID_IN7,
                                GA_ReadOnly,               TRUE,
                                INTEGER_Arrows,            FALSE,
                            IntegerEnd,
                        LayoutEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IN8] =
                        IntegerObject,
                            GA_ID,                         GID_IN8,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IN9] =
                        IntegerObject,
                            GA_ID,                         GID_IN9,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_IN10] =
                        IntegerObject,
                            GA_ID,                         GID_IN10,
                            GA_ReadOnly,                   TRUE,
                            INTEGER_Arrows,                FALSE,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Items",
                    LAYOUT_AddChild,                       gadgets[GID_LB2] =
                    ListBrowserObject,
                        GA_ID,                             GID_LB2,
                        GA_RelVerify,                      TRUE,
                        GA_Disabled,                       TRUE,
                        FontAttrPtr ? GA_TextAttr : TAG_IGNORE, FontAttrPtr,
                        LISTBROWSER_ColumnInfo,            (ULONG) &ItemsColumnInfo,
                        LISTBROWSER_Labels,                (ULONG) &ItemsList,
                        LISTBROWSER_Selected,              ~0,
                        LISTBROWSER_ColumnTitles,          FALSE,
                        LISTBROWSER_AutoFit,               TRUE,
                    ListBrowserEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Spells",
                    LAYOUT_AddChild,                       gadgets[GID_LB1] =
                    ListBrowserObject,
                        GA_ID,                             GID_LB1,
                        GA_RelVerify,                      TRUE,
                        GA_Disabled,                       TRUE,
                        FontAttrPtr ? GA_TextAttr : TAG_IGNORE, FontAttrPtr,
                        LISTBROWSER_ColumnInfo,            (ULONG) &SpellsColumnInfo,
                        LISTBROWSER_Labels,                (ULONG) &SpellsList,
                        LISTBROWSER_Selected,              ~0,
                        LISTBROWSER_ColumnTitles,          FALSE,
                        LISTBROWSER_AutoFit,               TRUE,
                    ListBrowserEnd,
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          30,
        LayoutEnd,
    WindowEnd))
    {   lb_clearlist(&ItemsList);
        lb_clearlist(&SpellsList);
        printf("Can't create sheet window gadgets!\n");
        quit(EXIT_FAILURE);
    }
    unlockscreen();

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("19...\n"); Delay(TRACKDELAY);
#endif

    if (!(MainWindowPtr = (struct Window*) RA_OpenWindow(WinObject)))
    {   printf("Can't open sheet window!\n");
        quit(EXIT_FAILURE);
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("20...\n"); Delay(TRACKDELAY);
#endif

    if (guideexists)
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL, NOSUB));
    }

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = 1 << AppPort->mp_SigBit;

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("21...\n"); Delay(TRACKDELAY);
#endif

    if (TextFieldBase)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_TE1], MainWindowPtr, NULL,
            ICA_TARGET, gadgets[GID_SC1],
        TAG_DONE);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_SC1], MainWindowPtr, NULL,
            ICA_TARGET, gadgets[GID_TE1],
        TAG_DONE);
        RefreshGList((struct Gadget*) gadgets[GID_TE1], MainWindowPtr, NULL, 1); // important!
        RefreshGList((struct Gadget*) gadgets[GID_SC1], MainWindowPtr, NULL, 1); // important!
    }

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("22...\n"); Delay(TRACKDELAY);
#endif

    update_sheet();

#ifdef TRACKENTRY
    Delay(TRACKDELAY); printf("23...\n"); Delay(TRACKDELAY);
#endif
}

EXPORT void update_sheet(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* NodePtr;
    PERSIST   TEXT         itemstring1[ITEMS][ 1 + 1],
                           itemstring2[ITEMS][10 + 1], // "1234567890"
                           itemstring3[ITEMS][12 + 1], // "123456789.0#"
                           itemstring4[ITEMS][ 9 + 1], // "1234+1234"
                           spellstring1[SPELLS][2 + 1],
                           spellstring2[SPELLS][3 + 1],
                           locationstring[5 + 1],
                           timestring[40 + 1];

    if (!MainWindowPtr)
    {   return;
    }

    if (gotman)
    {   sprintf
        (   titlebarstr,
            "%s%s (%s %s %s)",
            ability[122].known ? ((sex == FEMALE) ? "Dame " : "Sir ") : "",
            name,
            table_sex[sex],
            races[race].singular,
            table_classes[class]
        );
    } else
    {   strcpy(titlebarstr, "Tunnels & Trolls ");
        strcat(titlebarstr, DECIMALVERSION);
    }
    // assert(WinObject);
    DISCARD SetAttrs((Object *) WinObject, WA_Title, titlebarstr, TAG_DONE);

    write_integer(GID_IN2,  st);
    write_integer(GID_IN3,  max_st);
    write_integer(GID_IN4,  iq);
    write_integer(GID_IN5,  lk);
    write_integer(GID_IN6,  con);
    write_integer(GID_IN7,  max_con);
    write_integer(GID_IN8,  dex);
    write_integer(GID_IN9,  chr);
    write_integer(GID_IN10, spd);
    write_integer(GID_IN15, level);
    write_integer(GID_IN16, xp);
    write_integer(GID_IN17, gp);
    write_integer(GID_IN18, sp);
    write_integer(GID_IN19, cp);
    write_integer(GID_IN20, carrying() / 10);
    write_integer(GID_IN21, carrying() % 10);
    write_integer(GID_IN22, getlimit() / 10);
    write_integer(GID_IN23, gotman ? calc_personaladds(st, lk, dex) : 0);
    write_integer(GID_IN24, gotman ? calc_missileadds( st, lk, dex) : 0);

    sprintf(locationstring, "%s%d", moduleinfo[module].name, room);
    DISCARD SetGadgetAttrs(gadgets[GID_ST2], MainWindowPtr, NULL, STRINGA_TextVal, locationstring, TAG_END); // this autorefreshes

    sprintf(timestring, "%02d:%02d on day %d", (minutes % ONE_DAY) / 60, minutes % 60, (minutes / ONE_DAY) + 1);
    DISCARD SetGadgetAttrs(gadgets[GID_ST3], MainWindowPtr, NULL, STRINGA_TextVal, timestring, TAG_END); // this autorefreshes
    if (ClockBase)
    {   DISCARD SetGadgetAttrs(gadgets[GID_CL1], MainWindowPtr, NULL, CLOCKGA_Time, (minutes % ONE_DAY) * 60, TAG_END); // autorefreshes
    }

    DISCARD SetGadgetAttrs(gadgets[GID_LB2 ], MainWindowPtr, NULL,
        LISTBROWSER_Labels,   ~0,
        LISTBROWSER_Selected, ~0,
    TAG_END);
    lb_clearlist(&ItemsList);
    for (i = 0; i < ITEMS; i++)
    {   if (items[i].owned)
        {   sprintf(itemstring1[i], "%c", getsymbol(i));
            sprintf(itemstring2[i], "%d", items[i].owned);
            sprintf(itemstring3[i], "%d.%d#", (items[i].owned * items[i].weight) / 10, (items[i].owned * items[i].weight) % 10);
            if (items[i].dice || items[i].adds)
            {   sprintf(itemstring4[i], "%d+%d", items[i].dice, items[i].adds);
            } elif (items[i].hits)
            {   sprintf(itemstring4[i], "%d", items[i].hits);
            } else
            {   strcpy(itemstring4[i], "-");
            }
            NodePtr = (struct Node *) AllocListBrowserNode
            (   6,
                LBNA_UserData,       i,
                LBNA_Column,         0,
                LBNCA_Justification, LCJ_RIGHT,
                LBNCA_Text,          itemstring1[i],
                LBNA_Column,         1,
                LBNCA_Justification, LCJ_CENTRE,
                LBNCA_Text,          itemstring2[i],
                LBNA_Column,         2,
                LBNCA_Justification, LCJ_RIGHT,
                LBNCA_Text,          itemstring3[i],
                LBNA_Column,         3,
                LBNCA_Justification, LCJ_CENTRE,
                LBNCA_Text,          itemstring4[i],
                LBNA_Column,         4,
                LBNCA_Justification, LCJ_CENTRE,
                LBNCA_Image,         image[FIRSTBITMAP_ITEMS + items[i].type],
                LBNA_Column,         5,
                LBNCA_Justification, LCJ_LEFT,
                LBNCA_Text,          items[i].name,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&ItemsList, (struct Node *) NodePtr);
    }   }
    DISCARD SetGadgetAttrs(gadgets[GID_LB2 ], MainWindowPtr, NULL, LISTBROWSER_Labels , &ItemsList , LISTBROWSER_Selected, ~0, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_LB2 ], MainWindowPtr, NULL, LISTBROWSER_AutoFit, TRUE       , TAG_DONE);
    RefreshGadgets((struct Gadget *) gadgets[GID_LB2], MainWindowPtr, NULL);

    DISCARD SetGadgetAttrs(gadgets[GID_LB1 ], MainWindowPtr, NULL, LISTBROWSER_Labels , ~0         , LISTBROWSER_Selected, ~0, TAG_DONE);
    lb_clearlist(&SpellsList);
    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].known)
        {   sprintf(spellstring1[i], "%d", spell[i].level);
            sprintf(spellstring2[i], "%d", spell[i].st);
            NodePtr = (struct Node *) AllocListBrowserNode
            (   4,
                LBNA_UserData,       i,
                LBNA_Column,         0,
                LBNCA_Justification, LCJ_RIGHT,
                LBNCA_Text,          spellstring1[i],
                LBNA_Column,         1,
                LBNCA_Justification, LCJ_RIGHT,
                LBNCA_Text,          spellstring2[i],
                LBNA_Column,         2,
                LBNCA_Justification, LCJ_CENTRE,
                LBNCA_Text,          spell[i].abbrev,
                LBNA_Column,         3,
                LBNCA_Justification, LCJ_LEFT,
                LBNCA_Text,          spell[i].corginame,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList, (struct Node *) NodePtr);
    }   }
    DISCARD SetGadgetAttrs(gadgets[GID_LB1 ], MainWindowPtr, NULL, LISTBROWSER_Labels , &SpellsList, LISTBROWSER_Selected, ~0, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_LB1 ], MainWindowPtr, NULL, LISTBROWSER_AutoFit, TRUE       , TAG_DONE);
    RefreshGadgets((struct Gadget *) gadgets[GID_LB1], MainWindowPtr, NULL);
}

EXPORT void close_sheet(void)
{   if (WinObject)
    {   if (MainWindowPtr)
        {   winx      = MainWindowPtr->LeftEdge;
            winy      = MainWindowPtr->TopEdge;
            winwidth  = MainWindowPtr->Width  /* - 14 */ ;
            winheight = MainWindowPtr->Height /* -  1 */ ;
        }

        /* Disposing of the window object will also close the window if it
           is already opened, and it will dispose of the layout object
           attached to it. */
        DisposeObject(WinObject);
        WinObject = NULL;
        MainWindowPtr = NULL;

        lb_clearlist(&ItemsList);
        lb_clearlist(&SpellsList);

        // MainSignal = 0;
    }

    if (VisualInfoPtr)
    {   FreeVisualInfo(VisualInfoPtr);
        VisualInfoPtr = NULL;
}   }

EXPORT void close_gfx(FLAG zeroname)
{   if (GfxObject)
    {   /* Disposing of the window object will also close the window if it
           is already opened, and it will dispose of the layout object
           attached to it. */
        DisposeObject(GfxObject);
        GfxObject = NULL;
        GfxWindowPtr = NULL;

        if (imageptr)
        {   DisposeObject(imageptr);
            imageptr = NULL;
        }

        GfxSignal = 0;
    }

    if (zeroname)
    {   imagename[0] = EOS;
}   }

MODULE void lockscreen(void)
{   if (ScreenPtr)
    {   return;
    }

    if (screenname[0])
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) screenname)))
        {   printf("Can't lock public screen \"%s\"!\n", screenname);
            quit(EXIT_FAILURE);
    }   }
    else
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) NULL)))
        {   printf("Can't lock default public screen!\n");
            quit(EXIT_FAILURE);
}   }   }
MODULE void unlockscreen(void)
{   if (ScreenPtr)
    {   if (screenname[0])
        {   UnlockPubScreen(screenname, ScreenPtr);
            ScreenPtr = NULL;
        } else
        {   UnlockPubScreen(NULL, ScreenPtr);
            ScreenPtr = NULL;
}   }   }

// Function to free an Exec List of ReAction ListBrowser nodes.
MODULE void lb_clearlist(struct List* ListPtr)
{   /* Requirements: listbrowser class must be already open, and list
    must be detached from gadget. List may be empty or non-empty, and
    may be single- or multi-columnar. */

    if (ListIsFull(ListPtr))
    {   FreeListBrowserList(ListPtr);
    }
    NewList(ListPtr); // prepare for reuse
}

MODULE void write_integer(int gid, ULONG number)
{   DISCARD SetGadgetAttrs(gadgets[gid], MainWindowPtr, NULL, INTEGER_Number, number, TAG_END); // this autorefreshes
}

MODULE void load_image(void)
{   BPTR OldDir /* = ZERO */ ;

    if (imagename[0] == EOS)
    {   return;
    }

    // assert(!imageptr);

    lockscreen();
    OldDir = CurrentDir(ProgLock);
    if
    (   !Exists(imagename)
     || !(imageptr =
        BitMapObject,
            BITMAP_SourceFile, imagename,
            BITMAP_Screen,     ScreenPtr,
            BITMAP_Masking,    FALSE,
        End)
    )
    {   imagename[0] = EOS;
    }
    DISCARD CurrentDir(OldDir);
    unlockscreen();
}

EXPORT FLAG Exists(STRPTR name)
{   struct Process* self = (APTR) FindTask(NULL);
    APTR            oldwinptr;
    BPTR            lock;

    oldwinptr = self->pr_WindowPtr;
    self->pr_WindowPtr = (APTR) -1;

    lock = Lock(name, ACCESS_READ);

    self->pr_WindowPtr = oldwinptr;

    if (lock)
    {   UnLock(lock);
        return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void help_manual(void)
{   struct NewAmigaGuide nag =
    {   ZERO,                // nag_Lock
        "PROGDIR:TnT.guide", // nag_Name
        NULL,                // nag_Screen
        NULL,                // nag_PubScreen
        NULL,                // nag_HostPort
        NULL,                // nag_ClientPort
        NULL,                // nag_BaseName
        0,                   // nag_Flags
        NULL,                // nag_Context
        "MAIN",              // nag_Node
        0,                   // nag_Line
        NULL,                // nag_Extens
        NULL                 // nag_Client
    };
    BPTR OldDir /* = ZERO */ ;

    if (!guideexists)
    {   return;
    }

    if (morphos)
    {   /* MorphOS OpenWorkbenchObject() function is a non-functional
           dummy; therefore we use OpenAmigaGuide() when running under
           MorphOS. */

        if (!AmigaGuideBase)
        {   return;
        }
        lockscreen();
        nag.nag_Screen = ScreenPtr;
        DISCARD OpenAmigaGuide(&nag, TAG_DONE);
        unlockscreen();
    } else
    {   OldDir = CurrentDir(ProgLock);
        DISCARD OpenWorkbenchObject
        (   "TnT.guide",
            WBOPENA_ArgLock, ProgLock,
            WBOPENA_ArgName, "TnT.guide",
        TAG_DONE);
        DISCARD CurrentDir(OldDir);
}   }

EXPORT void show_output(void)
{   int length;

    if (MainWindowPtr && TextFieldBase)
    {   // remove trailing newline, if there is one
        length = strlen(vanillascreen);
        if (length >= 1 && vanillascreen[length - 1] == '\n')
        {   vanillascreen[length - 1] = EOS;
        }

        // no need to bother with screen[]

        DISCARD SetGadgetAttrs
        (   gadgets[GID_TE1], MainWindowPtr, NULL,
            GA_TEXTEDITOR_Contents, vanillascreen,
        TAG_DONE);
        RefreshGList((struct Gadget*) gadgets[GID_TE1], MainWindowPtr, NULL, 1);
    }

    colourscreen[0] = vanillascreen[0] = EOS;
}

EXPORT void loop(FLAG onekeyable)
{   ULONG                      cursorpos,
                               entries,
                               gid,
                               result,
                               visible;
    UWORD                      code;
    int                        theonekey;
    struct ListBrowserNodePtr* NodePtr;

    if (!reactable)
    {   for (;;)
        {   printf(">");
            flushall();
            row = column = 0;

            if (onekeyable && onekey)
            {   // while (getch() != EOF); // clear input buffer
                // (but since it doesn't return until a key is pressed, it's an infinite loop)
                do
                {   theonekey = getch();
                    // Ctrl-C (or dropped carrier?) produces $03 (ETX)
                } while (theonekey == EOF);
                // if Ctrl-C was pressed, it has quit (via _CXBRK()) by now
                userinput[0] = (TEXT) theonekey;
                if (userinput[0] == CR) // this is no mistake
                {   userinput[0] = EOS;
                } else
                {   printf("%c\n", userinput[0]);
                }
                userinput[1] = EOS;
            } else
            {   gets(userinput);
            }

            if (!stricmp(userinput, "###PANIC"))
            {   printf("Dropped carrier detected!\n");
                quit(EXIT_SUCCESS);
            } elif (!stricmp(userinput, "Q") || !stricmp(userinput, "QUIT"))
            {   quit(EXIT_SUCCESS);
            } else return;
    }   }
    // implied else

    userinput[0] = EOS;
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ST1], MainWindowPtr, NULL,
        STRINGA_TextVal, userinput,
        STRINGA_Buffer,  userinput,
    TAG_DONE);
    RefreshGList((struct Gadget*) gadgets[GID_ST1], MainWindowPtr, NULL, 1);
    DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);

    update_sheet();
    column = 0;

    sheet_chosen = -1;
    globaldone = FALSE;
    do
    {   if (AboutWindowPtr)
        {   about_loop();
        } else
        {   if ((Wait(MainSignal | GfxSignal | AppSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
            {   quit(EXIT_SUCCESS);
        }   }

        while ((result = DoMethod(WinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   switch (result & WMHI_CLASSMASK)
            {
            case WMHI_MENUPICK:
                handlemenus(code);
            acase WMHI_CLOSEWINDOW:
                quit(EXIT_SUCCESS);
            acase WMHI_ICONIFY:
                iconify();
            acase WMHI_ACTIVE:
            case WMHI_CHANGEWINDOW: // eg. user dragged titlebar
                DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
            acase WMHI_GADGETUP:
                gid = result & WMHI_GADGETMASK;
                switch (gid)
                {
                case GID_ST1:
                    DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
                    if (code == SCAN_HELP)
                    {   if (TextFieldBase)
                        {   DISCARD GetAttr(GA_TEXTEDITOR_Prop_First,   (Object*) gadgets[GID_TE1], (ULONG*) &cursorpos);
                            DISCARD GetAttr(GA_TEXTEDITOR_Prop_Visible, (Object*) gadgets[GID_TE1], (ULONG*) &visible);
                            DISCARD GetAttr(GA_TEXTEDITOR_Prop_Entries, (Object*) gadgets[GID_TE1], (ULONG*) &entries);
                            if (cursorpos + visible >= entries)
                            {   cursorpos = 0;
                            } elif (cursorpos + visible > entries - visible)
                            {   cursorpos = entries - visible;
                            } else
                            {   cursorpos += visible - 1;
                            }
                            DISCARD SetGadgetAttrs
                            (   gadgets[GID_TE1], // pointer to gadget
                                MainWindowPtr,   // pointer to window (not window object!)
                                NULL,             // pointer to requester
                                GA_TEXTEDITOR_Prop_First, cursorpos,
                            TAG_DONE); // this autorefreshes
                            DISCARD SetGadgetAttrs
                            (   gadgets[GID_SC1], // pointer to gadget
                                MainWindowPtr,   // pointer to window (not window object!)
                                NULL,             // pointer to requester
                                SCROLLER_Top, cursorpos,
                            TAG_DONE); // this autorefreshes
                    }   }
                    else
                    {   globaldone = TRUE;
                    }
                acase GID_LB1:
                    DISCARD GetAttr(LISTBROWSER_SelectedNode, gadgets[GID_LB1], (ULONG*) &NodePtr);
                    // assert(NodePtr);
                    GetListBrowserNodeAttrs((struct Node*) NodePtr, LBNA_UserData, &sheet_chosen, TAG_DONE);
                    DISCARD SetGadgetAttrs(gadgets[GID_LB1], MainWindowPtr, NULL, LISTBROWSER_Selected, ~0, TAG_DONE);
                    strcpy(userinput, "C");
                    globaldone = TRUE;
                acase GID_LB2:
                    DISCARD GetAttr(LISTBROWSER_SelectedNode, gadgets[GID_LB2], (ULONG*) &NodePtr);
                    // assert(NodePtr);
                    GetListBrowserNodeAttrs((struct Node*) NodePtr, LBNA_UserData, &sheet_chosen, TAG_DONE);
                    DISCARD SetGadgetAttrs(gadgets[GID_LB2], MainWindowPtr, NULL, LISTBROWSER_Selected, ~0, TAG_DONE);
                    strcpy(userinput, "U");
                    globaldone = TRUE;
                acase GID_TE1:
                case GID_SC1:
                    DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
                acase GID_BU1:
                case GID_BU2:
                case GID_BU3:
                case GID_BU4:
                case GID_BU5:
                case GID_BU6:
                case GID_BU7:
                case GID_BU8:
                    sprintf(userinput, "%s", specialopt_short[gid - GID_BU1]);
                    globaldone = TRUE;
                acase GID_BU9:  strcpy(userinput, "A"); globaldone = TRUE;
                acase GID_BU10: strcpy(userinput, "C"); globaldone = TRUE;
                acase GID_BU11: strcpy(userinput, "D"); globaldone = TRUE;
                acase GID_BU12: strcpy(userinput, "F"); globaldone = TRUE;
                acase GID_BU13: strcpy(userinput, "G"); globaldone = TRUE;
                acase GID_BU14: strcpy(userinput, "H"); globaldone = TRUE;
                acase GID_BU15: strcpy(userinput, "L"); globaldone = TRUE;
                acase GID_BU16: strcpy(userinput, "O"); globaldone = TRUE;
                acase GID_BU17: strcpy(userinput, "P"); globaldone = TRUE;
                acase GID_BU18: quit(EXIT_SUCCESS);  // globaldone = TRUE;
                acase GID_BU24: strcpy(userinput, "R"); globaldone = TRUE;
                acase GID_BU19: strcpy(userinput, "T"); globaldone = TRUE;
                acase GID_BU20: strcpy(userinput, "U"); globaldone = TRUE;
                acase GID_BU21: strcpy(userinput, "V"); globaldone = TRUE;
                }
            acase WMHI_RAWKEY:
                switch (code)
                {
                case SCAN_TAB:
                    DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
                acase SCAN_ESC:
                    quit(EXIT_SUCCESS);
                }
         /* adefault:
                printf("Unknown message $%X!\n", (result & WMHI_CLASSMASK)); */
        }   }

        if (GfxObject)
        {   while ((result = DoMethod(GfxObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
            {   switch (result & WMHI_CLASSMASK)
                {
                case WMHI_CLOSEWINDOW:
                    close_gfx(TRUE);
    }   }   }   }
    while (!globaldone);
    if (!stricmp(userinput, "Q") || !stricmp(userinput, "QUIT"))
    {   quit(EXIT_SUCCESS);
}   }

MODULE void InitHook(struct Hook* hook, ULONG (*func)(), void* data)
{   // Make sure a pointer was passed

    if (hook)
    {   // Fill in the Hook fields
        #ifdef __amigaos4__
            hook->h_Entry    = func;
        #else
            hook->h_Entry    = (ULONG (*)()) HookEntry;
        #endif
        hook->h_SubEntry = func;
        hook->h_Data     = data;
    } else
    {   printf("Can't initialize hook!\n");
        quit(EXIT_FAILURE);
}   }

MODULE ULONG MainHookFunc(struct Hook* h, VOID* o, VOID* msg)
{   /* "When the hook is called, the data argument points to the
    window object and message argument to the IntuiMessage." */

    ULONG theclass;
 // UWORD code;
 // UWORD qual;
 // SWORD mousex, mousey;

    geta4();

    theclass = ((struct IntuiMessage*) msg)->Class;
 // code     = ((struct IntuiMessage*) msg)->Code;
 // qual     = ((struct IntuiMessage*) msg)->Qualifier;
 // mousex   = ((struct IntuiMessage*) msg)->MouseX;
 // mousey   = ((struct IntuiMessage*) msg)->MouseY;

    switch (theclass)
    {
    case IDCMP_MOUSEBUTTONS:
        // Unfortunately, if the user clicks on a read-only gadget such as
        // GID_TE1, we hear neither IDCMP_MOUSEBUTTONS nor IDCMP_GADGETUP
        // (under OS3.2+BB1, at least).
        ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
    }

    return 1;
}

/* EXPORT void say(STRPTR thestring)
{   struct EasyStruct TheEasyStruct =
    {   sizeof(struct EasyStruct),
        0,
        "T&T: Error",
        NULL,
        "OK"
    };

    if (logconsole || !reactable)
    {   aprintf("%s\n", thestring);
    }
    if (LogfileHandle)
    {   DISCARD fwrite(thestring, strlen(thestring), 1, LogfileHandle);
        DISCARD fwrite("\n",                      1, 1, LogfileHandle);
    }
    if (reactable)
    {   TheEasyStruct.es_TextFormat = thestring;
        DISCARD EasyRequest(MainWindowPtr, &TheEasyStruct, NULL); // OK even if MainWindowPtr is NULL
}   }

EXPORT void msg(STRPTR thestring)
{   struct EasyStruct TheEasyStruct =
    {   sizeof(struct EasyStruct),
        0,
        "T&T: Message",
        NULL,
        "OK"
    };

    if (logconsole || !reactable)
    {   aprintf("%s\n", thestring);
    }
    if (LogfileHandle)
    {   DISCARD fwrite(thestring, strlen(thestring), 1, LogfileHandle);
        DISCARD fwrite("\n",                      1, 1, LogfileHandle);
    }
    if (reactable)
    {   TheEasyStruct.es_TextFormat = thestring;
        DISCARD EasyRequest(MainWindowPtr, &TheEasyStruct, NULL); // OK even if MainWindowPtr is NULL
}   } */

EXPORT void enable_spells(FLAG enabled)
{   DISCARD SetGadgetAttrs
    (   gadgets[GID_LB1], MainWindowPtr, NULL,
        GA_Disabled, enabled ? FALSE : TRUE,
    TAG_DONE); // this refreshes automatically
}
EXPORT void enable_items(FLAG enabled)
{   DISCARD SetGadgetAttrs
    (   gadgets[GID_LB2], MainWindowPtr, NULL,
        GA_Disabled, enabled ? FALSE : TRUE,
    TAG_DONE); // this refreshes automatically
}

EXPORT void openconsole(void) { ; }

EXPORT void system_die1(void)
{   if (userstring[0])
    {   printf("\x1b" "[0;39;39m");
}   }

EXPORT void setconcolour(int colour)
{   PERSIST const STRPTR ansi[16] =
    {   "\x1b" "[0;30;40m", //  0 black
        "\x1b" "[0;31;40m", //  1 red
        "\x1b" "[0;32;40m", //  2 green
        "\x1b" "[0;33;40m", //  3 brown
        "\x1b" "[0;34;40m", //  4 blue
        "\x1b" "[0;35;40m", //  5 purple
        "\x1b" "[0;36;40m", //  6 cyan
        "\x1b" "[0;37;40m", //  7 light  grey
        "\x1b" "[1;30;40m", //  8 dark   grey
        "\x1b" "[1;31;40m", //  9 bright red
        "\x1b" "[1;32;40m", // 10 bright green
        "\x1b" "[1;33;40m", // 11 bright yellow
        "\x1b" "[1;34;40m", // 12 bright blue
        "\x1b" "[1;35;40m", // 13 bright purple
        "\x1b" "[1;36;40m", // 14 bright cyan
        "\x1b" "[1;37;40m", // 15 bright white
    };

    if (userstring[0] == EOS || !colours || textcolour == colour)
    {   return;
    }
    textcolour = colour;

    printf("%s", ansi[textcolour]);

}

MODULE void iconify(void)
{   struct AppMessage* AppMsg;

    if (!MainWindowPtr)
    {   return;
    }

    if (GfxWindowPtr)
    {   needgfx = TRUE;
        close_gfx(FALSE);
    }
    if (AboutWindowPtr)
    {   needabout = TRUE;
        close_about();
    }

    DISCARD RA_Iconify(WinObject);
    // the WinObject must stay a valid pointer
    MainWindowPtr = NULL;

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    do
    {   if ((Wait
        (   AppSignal
          | MainSignal
          | SIGBREAKF_CTRL_C
        )) & SIGBREAKF_CTRL_C)
        {   quit(EXIT_SUCCESS);
        }

        while ((AppMsg = (struct AppMessage*) GetMsg(AppPort)))
        {   switch (AppMsg->am_Type)
            {
            case AMTYPE_APPICON:
                uniconify();
            }
            ReplyMsg((struct Message*) AppMsg);
    }   }
    while (!MainWindowPtr);
}

MODULE void uniconify(void)
{   // assert(!MainWindowPtr);

    getclockpens();

    if (!(MainWindowPtr = (struct Window*) RA_Uniconify(WinObject)))
    {   printf("Can't reopen sheet window!\n");
        quit(EXIT_FAILURE);
    }

    if (needgfx)
    {   needgfx = FALSE;
        open_gfx();
    }
    if (needabout)
    {   needabout = FALSE;
        help_about();
    }

    DISCARD GetAttr(WINDOW_SigMask, WinObject, &MainSignal);
    AppSignal = (1 << AppPort->mp_SigBit); // maybe unnecessary?

    ActivateWindow(MainWindowPtr);
}

EXPORT void do_opts(void)
{   TRANSIENT int  i, j,
                   length;
    TRANSIENT FLAG ok;
    PERSIST   TEXT boldstring[8][15 + 1],
                   unboldstring1[8][15 + 1],
                   unboldstring2[8][15 + 1];

    if (!MainWindowPtr)
    {   return;
    }

    for (i = 0; i < 8; i++)
    {   length = strlen(specialopt_long[i]);
        if (length)
        {   ok = FALSE;
            for (j = 0; j < length; j++)
            {   if (specialopt_long[i][j] >= 'A' && specialopt_long[i][j] <= 'Z')
                {   if (j >= 1)
                    {   zstrncpy(unboldstring1[i], specialopt_long[i], j);
                    } else
                    {   unboldstring1[i][0] = EOS;
                    }
                    boldstring[i][0] = specialopt_long[i][j];
                    boldstring[i][1] = EOS;
                    if (j == length - 1)
                    {   unboldstring2[i][0] = EOS;
                    } else
                    {   zstrncpy(unboldstring2[i], &specialopt_long[i][j + 1], 8);
                    }
                    ok = TRUE;
                    break;
            }   }
            if (!ok)
            {   unboldstring1[i][0] =
                unboldstring2[i][0] = EOS;
                zstrncpy(boldstring[i], specialopt_long[i], 8);
        }   }

        DISCARD SetGadgetAttrs
        (   gadgets[GID_BU1 + i],
            MainWindowPtr,
            NULL,
            GA_Image,
            LabelObject,
                LABEL_DrawInfo,                DrawInfoPtr, // needed!
                LABEL_SoftStyle,               FS_NORMAL,
                LABEL_Text,                    unboldstring1[i],
                LABEL_SoftStyle,               FSF_BOLD,
                LABEL_Text,                    boldstring[i],
                LABEL_SoftStyle,               FS_NORMAL,
                LABEL_Text,                    unboldstring2[i],
            LabelEnd,
            GA_Disabled, (strcmp(specialopt_long[i], "-") ? FALSE : TRUE),
        TAG_DONE); // this refreshes automatically
    }

    DISCARD SetGadgetAttrs(gadgets[GID_BU9 ], MainWindowPtr, NULL, GA_Disabled, avail_armour    ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU10], MainWindowPtr, NULL, GA_Disabled, avail_cast      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU11], MainWindowPtr, NULL, GA_Disabled, avail_drop      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU12], MainWindowPtr, NULL, GA_Disabled, avail_fight     ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU13], MainWindowPtr, NULL, GA_Disabled, avail_get       ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU14], MainWindowPtr, NULL, GA_Disabled, avail_hands     ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU15], MainWindowPtr, NULL, GA_Disabled, avail_look      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU16], MainWindowPtr, NULL, GA_Disabled, avail_options   ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU17], MainWindowPtr, NULL, GA_Disabled, avail_proceed   ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU24], MainWindowPtr, NULL, GA_Disabled, avail_random    ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU19], MainWindowPtr, NULL, GA_Disabled, avail_autofight ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU20], MainWindowPtr, NULL, GA_Disabled, avail_use       ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU21], MainWindowPtr, NULL, GA_Disabled, avail_view      ? FALSE : TRUE, TAG_DONE);
    // those refresh automatically
}

EXPORT void undo_opts(void)
{   int i;

    if (!MainWindowPtr)
    {   return; // important!
    }

    for (i = 0; i < 8; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_BU1 + i],
            MainWindowPtr,
            NULL,
            GA_Image,
            LabelObject,
                LABEL_DrawInfo,                DrawInfoPtr, // needed!
                LABEL_SoftStyle,               FS_NORMAL,
                LABEL_Text,                    "-",
            LabelEnd,
            GA_Disabled, TRUE,
        TAG_DONE); // this refreshes automatically
        strcpy(specialopt_long[i], "-");
    }

    DISCARD SetGadgetAttrs(gadgets[GID_BU9 ], MainWindowPtr, NULL, GA_Disabled, avail_armour    ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU10], MainWindowPtr, NULL, GA_Disabled, avail_cast      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU11], MainWindowPtr, NULL, GA_Disabled, avail_drop      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU12], MainWindowPtr, NULL, GA_Disabled, avail_fight     ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU13], MainWindowPtr, NULL, GA_Disabled, avail_get       ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU14], MainWindowPtr, NULL, GA_Disabled, avail_hands     ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU15], MainWindowPtr, NULL, GA_Disabled, avail_look      ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU16], MainWindowPtr, NULL, GA_Disabled, avail_options   ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU17], MainWindowPtr, NULL, GA_Disabled, avail_proceed   ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU24], MainWindowPtr, NULL, GA_Disabled, avail_random    ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU19], MainWindowPtr, NULL, GA_Disabled, avail_autofight ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU20], MainWindowPtr, NULL, GA_Disabled, avail_use       ? FALSE : TRUE, TAG_DONE);
    DISCARD SetGadgetAttrs(gadgets[GID_BU21], MainWindowPtr, NULL, GA_Disabled, avail_view      ? FALSE : TRUE, TAG_DONE);
    // those refresh automatically
}

MODULE void handlemenus(UWORD code)
{   struct MenuItem* ItemPtr;

    while (code != MENUNULL)
    {   ItemPtr = ItemAddress(MenuPtr, code);
        switch (MENUNUM(code))
        {
        case MN_PROJECT:
            switch (ITEMNUM(code))
            {
            case IN_ICONIFY:
                iconify();
            acase IN_QUIT:
                quit(EXIT_SUCCESS);
            }
        acase MN_HELP:
            switch (ITEMNUM(code))
            {
            case  IN_MANUAL:
                help_manual();
            acase IN_UPDATE:
                help_update();
            acase IN_REACTION:
                help_reaction();
            acase IN_ABOUT:
                help_about();
        }   }
        code = ItemPtr->NextSelect;
    }

    DISCARD ActivateLayoutGadget(gadgets[GID_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ST1]);
}

MODULE void help_reaction(void)
{   UWORD                   code;
    ULONG                   result,
                            ReActionSignal;
    FLAG                    done;
    int                     i,
                            next                 = 0,
                            thisfontx;
    Object*                 ReActionWinObject /* = NULL */ ;
    struct List             ReActionList;
    struct ListBrowserNode* ListBrowserNodePtr;
    struct Window*          ReActionWindowPtr /* = NULL */ ;
    struct Image*           boingimage           = NULL    ;
PERSIST STRPTR ReActionNames[] =
{ "bitmap.image",       //  0
  "boingball.image",
  "button.gadget",
  "clock.gadget",
  "integer.gadget",
  "label.image",        //  5
  "layout.gadget",
  "listbrowser.gadget",
  "scroller.gadget",
  "space.gadget",
  "string.gadget",      // 10
  "texteditor.gadget",
  "window.class",       // 12
};
PERSIST TEXT              ReActionVersions[12 + 1][10 + 1];
PERSIST struct ColumnInfo ReActionColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    NULL,              /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    NULL,
    CIF_FIXED
  },
  { -1,
    (STRPTR)~0,
    -1
} };

    sprintf(ReActionVersions[next++], "%2d.%d",         BitMapBase->lib_Version,         BitMapBase->lib_Revision);
    if (BoingBallBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d",  BoingBallBase->lib_Version,      BoingBallBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",         ButtonBase->lib_Version,         ButtonBase->lib_Revision);
    if (ClockBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d",      ClockBase->cl_Lib.lib_Version,   ClockBase->cl_Lib.lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",        IntegerBase->lib_Version,        IntegerBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",          LabelBase->lib_Version,          LabelBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",         LayoutBase->lib_Version,         LayoutBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",    ListBrowserBase->lib_Version,    ListBrowserBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",       ScrollerBase->lib_Version,       ScrollerBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",          SpaceBase->lib_Version,          SpaceBase->lib_Revision);
    sprintf(ReActionVersions[next++], "%2d.%d",         StringBase->lib_Version,         StringBase->lib_Revision);
    if (TextFieldBase)
    {   sprintf(ReActionVersions[next++], "%2d.%d",  TextFieldBase->lib_Version,      TextFieldBase->lib_Revision);
    } else
    {   sprintf(ReActionVersions[next++], "  -");
    }
    sprintf(ReActionVersions[next++], "%2d.%d",         WindowBase->lib_Version,         WindowBase->lib_Revision);

    // we expect version  numbers to be <=  99, but theoretically they can be <= 32767
    // we expect revision numbers to be <= 999, but theoretically they can be <= 32767

    NewList(&ReActionList);
    for (i = 0; i < next; i++)
    {   if (!(ListBrowserNodePtr = (struct ListBrowserNode*) AllocListBrowserNode
        (   2,                  // columns
            /* LBNCA_ tags are those that apply to the specific column. */
            LBNA_Column,             0,
            LBNCA_Text,              ReActionNames[i],
            LBNA_Column,             1,
            LBNCA_Text,              ReActionVersions[i],
        TAG_END)))
        {   FreeListBrowserList(&ReActionList);
            aprintf("Can't create ReAction listbrowser.gadget node(s)!\n");
            return;
        }
        AddTail(&ReActionList, (struct Node *) ListBrowserNodePtr); // AddTail() has no return code
    }
    thisfontx = DrawInfoPtr->dri_Font->tf_XSize;
    ReActionColumnInfo[0].ci_Width = thisfontx * (18 + 2);

    load_images(BITMAP_REACTION, BITMAP_REACTION, TRUE);

    lockscreen();
    if (BoingBallBase)
    {   boingimage = (struct Image*) NewObject(NULL, "boingball.image", PENMAP_Screen, ScreenPtr, TAG_END);
    }
    if (!(ReActionWinObject =
    WindowObject,
        WA_PubScreen,                              ScreenPtr,
        WA_ScreenTitle,                            TITLEBARTEXT,
        WA_Title,                                  "About ReAction",
        WA_Activate,                               TRUE,
        WA_DepthGadget,                            TRUE,
        WA_DragBar,                                TRUE,
        WA_CloseGadget,                            TRUE,
        WA_IDCMP,                                  IDCMP_INTUITICKS,
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,
        HLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            LAYOUT_HorizAlignment,                 LALIGN_CENTER,
            LAYOUT_DeferLayout,                    TRUE,
            AddVLayout,
                AddSpace,
                LAYOUT_AddImage,                   image[BITMAP_REACTION],
                CHILD_NoDispose,                   TRUE,
                CHILD_WeightedHeight,              0,
                AddSpace,
                AddHLayout,
                    AddSpace,
                    boingimage ? LAYOUT_AddImage     : TAG_IGNORE, boingimage,
                    boingimage ? CHILD_MinWidth      : TAG_IGNORE, 24,
                    boingimage ? CHILD_MinHeight     : TAG_IGNORE, 24,
                    boingimage ? CHILD_WeightedWidth : TAG_IGNORE, 0,
                    boingimage ? CHILD_NoDispose     : TAG_IGNORE, TRUE,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedHeight,              0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedWidth,                   0,
            AddVLayout,
                LAYOUT_HorizAlignment,             LALIGN_CENTER,
                LAYOUT_VertAlignment,              LALIGN_CENTER,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_AddImage,
                LabelObject,
                    LABEL_SoftStyle,               FSF_BOLD,
                 // LABEL_DrawInfo,                DrawInfoPtr,
                    LABEL_Text,                    "ReAction GUI",
                End,
                CHILD_WeightedHeight,              0,
                LAYOUT_AddChild,                   gadgets[GID_LB3] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                         GID_LB3,
                    GA_ReadOnly,                   TRUE,
                    LISTBROWSER_ColumnInfo,        (ULONG) &ReActionColumnInfo,
                    LISTBROWSER_Labels,            &ReActionList,
                    LISTBROWSER_MinVisible,        next,
                    LISTBROWSER_VerticalProp,      FALSE,
                ListBrowserEnd,
                CHILD_MinWidth,                    thisfontx * (18 + 2 + 8),
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   unlockscreen();
        aprintf("Can't create gadgets!\n");
        goto ABORT;
    } // implied else
    unlockscreen();

    if (!(ReActionWindowPtr = (struct Window*) RA_OpenWindow(ReActionWinObject)))
    {   DisposeObject(ReActionWinObject);
        // ReActionWinObject = NULL;
        aprintf("Can't open window!\n");
        goto ABORT;
    } // implied else
    DISCARD GetAttr(WINDOW_SigMask, ReActionWinObject, &ReActionSignal);

    done = FALSE;
    while (!done)
    {   if ((Wait(ReActionSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
        {   DisposeObject(ReActionWinObject);
            // ReActionWinObject = NULL;
            if (boingimage)
            {   DisposeObject((Object*) boingimage);
                // boingimage = NULL;
            }
            quit(EXIT_SUCCESS);
        }
        while ((result = DoMethod(ReActionWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   switch (result & WMHI_CLASSMASK)
            {
            case WMHI_CLOSEWINDOW:
                done = TRUE;
            acase WMHI_INTUITICK:
                DISCARD DoMethod((Object*) boingimage, IM_MOVE, ReActionWindowPtr->RPort, 0, 0, IDS_NORMAL, DrawInfoPtr);
            acase WMHI_RAWKEY:
                if (code < 128) // ie. key down not key up
                // it would be better if we could check that IEQUALIFIER_REPEAT is false
                {   done = TRUE;
    }   }   }   }

    DisposeObject(ReActionWinObject);
    // ReActionWinObject = NULL;

ABORT:
    FreeListBrowserList(&ReActionList);
    if (boingimage)
    {   DisposeObject((Object*) boingimage);
        // boingimage = NULL;
}   }

EXPORT void help_about(void)
{   TRANSIENT SBYTE           OldPri;
    PERSIST   FLAG            first = TRUE;
    PERSIST   TEXT            prioritystr[4 + 1], // "-128"
                              processstr[11 + 1], // "-1222333444"
                              wbstr[20 + 1];
    PERSIST   struct Process* ProcessPtr;
    PERSIST   STRPTR          compiledfor,
                              compiledwith;

    if (!reactable)
    {   printf
        (   "*** TUNNELS AND TROLLS " DECIMALVERSION " for Amiga (" RELEASEDATE") ***\n" \
            "Programmed by James Jacobs of Amigan Software (amigan.1emu.net)\n\n"
        );
        row += 3;
        return;
    }
    if (AboutWindowPtr)
    {   return;
    }

    load_images(BITMAP_LOGO, BITMAP_AMIGAN, FALSE);

    if (first)
    {   ProcessPtr = (APTR) FindTask(NULL);
#ifdef __amigaos4__
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_CliNum));
#else
        DISCARD sprintf(processstr, "%d", (int) (ProcessPtr->pr_TaskNum));
#endif

#ifdef __MORPHOS__
    #ifdef __VBCC__
        compiledwith = "VBCC";
    #else
        compiledwith = "GCC";
    #endif
        compiledfor  = "MorphOS PPC";
#else
    #ifdef __amigaos4__
        compiledwith = "GCC 4.2.4";
        compiledfor  = "AmigaOS 4 PPC";
    #else
        #ifdef __SASC
            compiledwith = "SAS/C 6.59";
        #else
            compiledwith = "?";
        #endif
    #endif
    compiledfor  = "AmigaOS 3 68k";
#endif

        switch (wbver)
        {
        case 45:
            strcpy(wbstr, "OS3.");
            switch (wbrev)
            {
            case    1: strcat(wbstr, "9+BB0"); // should never happen (as we require BB2+)
            acase   2: strcat(wbstr, "9+BB1"); // should never happen (as we require BB2+)
            acase   3: strcat(wbstr, "9+BB2");
            acase   4: strcat(wbstr, "9+BB3");
            acase   5: strcat(wbstr, "9+BB4");
            acase 194: strcat(wbstr, "1.4");
            adefault:  strcat(wbstr, "?");
            }
        acase 46:
            strcpy(wbstr, "OS3.1.4(.1)"); // 3.1.4.1 doesn't have an upgraded version.library
        acase 47:
            strcpy(wbstr, "OS3.2+BB");
            switch (wbrev)
            {
            case    2: strcat(wbstr, "0");
            acase   3: strcat(wbstr, "1");
            acase   4: strcat(wbstr, "2(.1)"); // 3.2.2.1 doesn't have an upgraded version.library
            adefault:  strcat(wbstr, "?");
            }
        acase 48:
            strcpy(wbstr, "OS3.3");
        acase 50:
            {   struct Resident* rt = FindResident("MorphOS");

                if (rt)
                {   sprintf(wbstr, "MorphOS %d", rt->rt_Version);
                } else
                {   strcpy(wbstr, "OS4.0");
            }   }
        acase 51:
        case 52:
            strcpy(wbstr, "OS4.0");
        acase 53:
            strcpy(wbstr, "OS4.1");
            if (wbrev >= 14)
            {   switch (wbrev)
                {
                case  14: strcat(wbstr, "FEu0");
                acase 15: strcat(wbstr, "FEu1");
                acase 17:                        // OS4.1FEu2 without hotfix
                case  18: strcat(wbstr, "FEu2"); // OS4.1FEu2 with    hotfix
                adefault: strcat(wbstr, "FEu?");
            }   }
        acase 54:
            strcpy(wbstr, "OS4.2?");
        adefault:
            strcpy(wbstr, "?");
        }

        first = FALSE;
    }

    // we reread the priority each time in case it has been changed in
    // the meantime
    OldPri = SetTaskPri((struct Task*) ProcessPtr, 0);
    if (OldPri != 0) // so as not to needlessly call SetTaskPri() again
    {   DISCARD SetTaskPri((struct Task*) ProcessPtr, OldPri);
    }
    DISCARD sprintf(prioritystr, "%d", (int) OldPri);

    lockscreen();
    if (!(AboutWinObject =
    WindowObject,
        WA_PubScreen,                              ScreenPtr,
        WA_ScreenTitle,                            TITLEBARTEXT,
        WA_Title,                                  "About T&T",
        WA_Activate,                               TRUE,
        WA_DepthGadget,                            TRUE,
        WA_DragBar,                                TRUE,
        WA_CloseGadget,                            TRUE,
        WINDOW_Position,                           WPOS_CENTERSCREEN,
        WINDOW_ParentGroup,
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            LAYOUT_DeferLayout,                    TRUE,
            AddHLayout,
                AddHLayout,
                    LAYOUT_VertAlignment,          LALIGN_TOP,
                    LAYOUT_AddImage,               image[BITMAP_AMIGAN],
                    CHILD_NoDispose,               TRUE,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_HorizAlignment,         LALIGN_CENTER,
                    LAYOUT_SpaceOuter,             TRUE,
                    LAYOUT_AddImage,               image[BITMAP_LOGO],
                    CHILD_NoDispose,               TRUE,
                    CHILD_WeightedHeight,          0,
                    AddLabel(" "),
                    LAYOUT_AddImage,
                    LabelObject,
                        LABEL_SoftStyle,           FSF_BOLD,
                        LABEL_Text,                "Tunnels & Trolls " DECIMALVERSION,
                    End,
                    CHILD_WeightedHeight,          0,
                    AddLabel(RELEASEDATE),
                    AddLabel(" "),
                    AddLabel("An implementation of the T&T RPG"),
                    AddLabel(COPYRIGHT),
                    AddLabel(" "),
                    AddHLayout,
                        AddVLayout,
                            LAYOUT_HorizAlignment, LALIGN_CENTER,
                            AddLabel("Compiled for:"),
                            AddLabel("Compiled with:"),
                            AddLabel("Running on:"),
                            AddLabel("Priority:"),
                            AddLabel("Process number:"),
                            AddLabel("Public screen name:"),
                        End,
                        CHILD_WeightedWidth,       50,
                        AddLabel(" "),
                        CHILD_WeightedWidth,       0,
                        AddVLayout,
                            LAYOUT_HorizAlignment, LALIGN_CENTER,
                            AddLabel(compiledfor),
                            AddLabel(compiledwith),
                            AddLabel(wbstr),
                            AddLabel(prioritystr),
                            AddLabel(processstr),
                            AddLabel(screenname),
                        End,
                        CHILD_WeightedWidth,       50,
                    End,
                    AddLabel(" "),
                End,
            End,
            LAYOUT_AddChild,                       gadgets[GID_BU22] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_BU22,
                GA_RelVerify,                      TRUE,
                GA_Text,                           "amigan.1emu.net/releases/",
                GA_Disabled,                       !OpenURLBase,
            ButtonEnd,
            LAYOUT_AddChild,                       gadgets[GID_BU23] = (struct Gadget*)
            ButtonObject,
                GA_ID,                             GID_BU23,
                GA_RelVerify,                      TRUE,
                GA_Text,                           "amigansoftware@gmail.com",
                GA_Disabled,                       !OpenURLBase,
            ButtonEnd,
        End,
    End))
    {   printf("Can't create ReAction objects!\n");
        quit(EXIT_FAILURE);
    }
    unlockscreen();

    if (!(AboutWindowPtr = (struct Window*) DoMethod((Object*) AboutWinObject, WM_OPEN, NULL)))
    {   printf("Can't open ReAction window!\n");
        quit(EXIT_FAILURE);
    }
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_ABOUT, NOSUB));
    LendMenus(AboutWindowPtr, MainWindowPtr);

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, AboutWinObject, &AboutSignal);
}

EXPORT void openurl(STRPTR command)
{   if (OpenURLBase)
    {   DISCARD URL_Open(command, TAG_DONE);
}   }

MODULE void about_loop(void)
{   UWORD code;
    ULONG aboutdone = 0,
          result;

    // Processes any messages for the About... window.

    if ((Wait(AboutSignal | MainSignal | AppSignal | SIGBREAKF_CTRL_C)) & SIGBREAKF_CTRL_C)
    {   aboutdone = 2;
    }

    while ((result = DoMethod(AboutWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
    {   switch (result & WMHI_CLASSMASK)
        {
        case WMHI_CLOSEWINDOW:
            aboutdone = 1;
        acase WMHI_RAWKEY:
            if (code < 128) // ie. key down not key up
            // it would be better if we could check that IEQUALIFIER_REPEAT is false
            {   aboutdone = 1;
            }
        acase WMHI_GADGETUP:
            switch (result & WMHI_GADGETMASK)
            {
            case GID_BU22:
                openurl("http://amigan.1emu.net/releases/");
            acase GID_BU23:
                openurl("mailto:amigansoftware@gmail.com");
    }   }   }

    if (aboutdone >= 1)
    {   close_about();
        if (aboutdone == 2)
        {   quit(EXIT_SUCCESS);
}   }   }

MODULE void load_images(int thefirst, int thelast, FLAG transparent)
{   int  i;
    TEXT theimagename[MAX_PATH + 1];
PERSIST const STRPTR imagename[BITMAPS] =
{   "logo.iff",             //  0
    "amigan.iff",           //  1
    "reaction.iff",         //  2
    "glyphs/nonweapon.iff", //  3 FIRSTBITMAP_ITEMS + NONWEAPON
    "glyphs/sword.iff",     //  4 FIRSTBITMAP_ITEMS + WEAPON_SWORD
    "glyphs/hafted.iff",    //  5 FIRSTBITMAP_ITEMS + WEAPON_HAFTED
    "glyphs/pole.iff",      //  6 FIRSTBITMAP_ITEMS + WEAPON_POLE
    "glyphs/spear.iff",     //  7 FIRSTBITMAP_ITEMS + WEAPON_SPEAR
    "glyphs/dagger.iff",    //  8 FIRSTBITMAP_ITEMS + WEAPON_DAGGER
    "glyphs/bow.iff",       //  9 FIRSTBITMAP_ITEMS + WEAPON_BOW
    "glyphs/crossbow.iff",  // 10 FIRSTBITMAP_ITEMS + WEAPON_XBOW
    "glyphs/powder.iff",    // 11 FIRSTBITMAP_ITEMS + WEAPON_AMMO
    "glyphs/sling.iff",     // 12 FIRSTBITMAP_ITEMS + WEAPON_SLING
    "glyphs/thrown.iff",    // 13 FIRSTBITMAP_ITEMS + WEAPON_THROWN
    "glyphs/staff.iff",     // 14 FIRSTBITMAP_ITEMS + WEAPON_STAFF
    "glyphs/gunne.iff",     // 15 FIRSTBITMAP_ITEMS + WEAPON_GUNNE
    "glyphs/arrow.iff",     // 16 FIRSTBITMAP_ITEMS + WEAPON_ARROW
    "glyphs/stone.iff",     // 17 FIRSTBITMAP_ITEMS + WEAPON_STONE
    "glyphs/other.iff",     // 18 FIRSTBITMAP_ITEMS + WEAPON_OTHER
    "glyphs/quarrel.iff",   // 19 FIRSTBITMAP_ITEMS + WEAPON_QUARREL
    "glyphs/dart.iff",      // 20 FIRSTBITMAP_ITEMS + WEAPON_DART
    "glyphs/blowpipe.iff",  // 21 FIRSTBITMAP_ITEMS + WEAPON_BLOWPIPE
    "glyphs/armour.iff",    // 22 FIRSTBITMAP_ITEMS + ARMOUR_COMPLETE
    "glyphs/shield.iff",    // 23 FIRSTBITMAP_ITEMS + SHIELD
    "glyphs/potion.iff",    // 24 FIRSTBITMAP_ITEMS + POTION
    "glyphs/ring.iff",      // 25 FIRSTBITMAP_ITEMS + RING
    "glyphs/slave.iff",     // 26 FIRSTBITMAP_ITEMS + SLAVE
    "glyphs/poison.iff",    // 27 FIRSTBITMAP_ITEMS + POISON
    "glyphs/jewel.iff",     // 28 FIRSTBITMAP_ITEMS + JEWEL
    "glyphs/arms.iff",      // 29 FIRSTBITMAP_ITEMS + ARMOUR_ARMS
    "glyphs/head.iff",      // 30 FIRSTBITMAP_ITEMS + ARMOUR_HEAD
    "glyphs/legs.iff",      // 31 FIRSTBITMAP_ITEMS + ARMOUR_LEGS
    "glyphs/chest.iff",     // 32 FIRSTBITMAP_ITEMS + ARMOUR_CHEST
};

    lockscreen();

    for (i = thefirst; i <= thelast; i++)
    {   if (!image[i])
        {   strcpy(theimagename, "PROGDIR:images/");
            strcat(theimagename, imagename[i]);
            if (!(image[i] = (struct Image*)
            BitMapObject,
                BITMAP_SourceFile,  theimagename,
                BITMAP_Screen,      ScreenPtr,
                BITMAP_Masking,     transparent ? TRUE : FALSE,
                BITMAP_Transparent, transparent ? TRUE : FALSE,
            End))
            {   printf("Can't create ReAction image(s)!\n");
                quit(EXIT_FAILURE);
    }   }   }

    unlockscreen();
}

EXPORT void close_about(void)
{   if (AboutWinObject)
    {   DisposeObject(AboutWinObject);
        AboutWindowPtr = NULL;
        AboutWinObject = NULL;
        if (MainWindowPtr)
        {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_ABOUT, NOSUB));
}   }   }

MODULE void parsewb(void)
{   struct DiskObject* DiskObject;
    STRPTR*            ToolArray;
    STRPTR             s;

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        if ((s = FindToolType(ToolArray, "PUBSCREEN")))
        {   strcpy(screenname, s);
        }
        if ((s = FindToolType(ToolArray, "USERID")))
        {   strcpy(userstring, s);
        }
        if ((s = FindToolType(ToolArray, "FILE")))
        {   strcpy(name, s);
        }

        FreeDiskObject(DiskObject);
}   }

MODULE void getclockpens(void)
{   // assert(ClockBase);

    lockscreen();
    pens[CLOCKPEN_BLACK   ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);
    pens[CLOCKPEN_DARKBLUE] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x50505050, 0x50505050, 0xFFFFFFFF, -1);
    pens[CLOCKPEN_GREY    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1);
    unlockscreen();
}

EXPORT ULONG getsize(const STRPTR filename)
{   BPTR                  LocalHandle /* = ZERO */ ;
    ULONG                 localsize;
    struct FileInfoBlock* FIBPtr;

    if (!(LocalHandle = (BPTR) Lock(filename, ACCESS_READ)))
    {   return 0;
    }
    if (!(FIBPtr = AllocDosObject(DOS_FIB, NULL)))
    {   UnLock(LocalHandle);
        // LocalHandle = NULL;
        return 0;
    }
    if (!(Examine(LocalHandle, FIBPtr)))
    {   FreeDosObject(DOS_FIB, FIBPtr);
        // FIBPtr = NULL;
        UnLock(LocalHandle);
        // LocalHandle = NULL;
        return 0;
    }

    if (FIBPtr->fib_DirEntryType < 0)
    {   // isdir     = FALSE;
        localsize = (ULONG) FIBPtr->fib_Size;
    } elif (FIBPtr->fib_DirEntryType > 0)
    {   // isdir     = TRUE;
        localsize = 0;
    } else
    {   // panic (value of 0 is undefined)!
        // isdir     = FALSE;
        localsize = 0;
    }
    FreeDosObject(DOS_FIB, FIBPtr);
    // FIBPtr = NULL;
    UnLock(LocalHandle);
    // LocalHandle = NULL;
    return localsize;
}

EXPORT void showfiles(void)
{   int            length;
    FLAG           found = FALSE;
    TEXT           dirname[40 + 1];
    DIR*           DirHandle;
    struct dirent* ent;

    if (userstring[0])
    {   sprintf(dirname, "PROGDIR:%s", userstring);
    } else
    {   dirname[0] = EOS;
    }

    if ((DirHandle = opendir(dirname)))
    {   /* print all the files and directories within directory */
        while ((ent = readdir(DirHandle)))
        {   length = strlen(ent->d_name);
            if (length >= 5 && !stricmp(&ent->d_name[length - 4], ".tnt"))
            {   found = TRUE;
                ent->d_name[length - 4] = EOS;
                aprintf("%s\n", ent->d_name);
        }   }
        closedir(DirHandle);
    } else
    {   aprintf("Can't open directory for reading!\n");
    }

    if (!found)
    {   aprintf("None\n");
    }
    aprintf("\n");
}

EXPORT void busypointer(void)
{   DISCARD SetAttrs(WinObject, WA_BusyPointer, TRUE, TAG_END);
}
EXPORT void normalpointer(void)
{   DISCARD SetAttrs(WinObject, WA_BusyPointer, FALSE, TAG_END);
}

EXPORT void __regargs _CXBRK(void)
{   printf("Dropped carrier detected!\n");
    quit(EXIT_SUCCESS); // perhaps this situation should be considered as a failure
}

EXPORT void maybelf(void)
{   strcat(colourscreen, "\n");
    strcat(vanillascreen, "\n");
    if (logconsole && !userstring[0])
    {   printf("\n"); // not aprintf()!
}   }

EXPORT void cls(void)
{   // assert(logconsole);

    printf("%c", 0x0C); // Form Feed. not zprintf()!

    row = column = 0;
}

EXPORT FLAG istrouble(TEXT thechar)
{   return FALSE;
}

EXPORT FLAG asl_load(void)
{   struct FileRequester* ASLRqPtr;

    if
    (   userstring[0]
     || !AslBase
     || !(ASLRqPtr = AllocAslRequestTags
        (   ASL_FileRequest,
            ASLFR_Window, MainWindowPtr,
        TAG_DONE))
    )
    {   showfiles();
        aprintf("Load which character?\n");
        show_output();
        loop(FALSE);
        if (userinput[0])
        {   strcpy(name, userinput);
            name[0] = toupper(name[0]);
            if (userstring[0])
            {   sprintf(pathname, "PROGDIR:%s/%s.tnt", userstring, name);
            } else
            {   sprintf(pathname, "PROGDIR:%s.tnt", name);
            }
            return TRUE;
        } else
        {   return FALSE;
    }   }
    // implied else

    if (!(AslRequestTags
    (   ASLRqPtr,
        ASLFR_TitleText,      "Load Character",
        ASLFR_InitialDrawer,  "PROGDIR:",
        ASLFR_InitialPattern, "#?.TNT",
        ASLFR_DoPatterns,     TRUE,
        ASLFR_RejectIcons,    TRUE,
    TAG_DONE)))
    {   // the user chose Cancel
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    if (*(ASLRqPtr->fr_File) == 0)
    {   // the user clicked OK with an empty filename
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    DISCARD strcpy(name, ASLRqPtr->fr_File);
    DISCARD strcpy(pathname, ASLRqPtr->fr_Drawer);
    if (!AddPart(pathname, ASLRqPtr->fr_File, MAX_PATH + 1))
    {   FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    FreeAslRequest(ASLRqPtr);
    return TRUE;
}

EXPORT FLAG asl_import(void)
{   int                   result;
    struct FileRequester* ASLRqPtr;

    // assert(userstring[0] == EOS);

    if
    (   !AslBase
     || !(ASLRqPtr = AllocAslRequestTags
        (   ASL_FileRequest,
            ASLFR_Window, MainWindowPtr,
        TAG_DONE))
    )
    {   result = getnumber("Which file number (ø0¢ for none)", 0, 5);
        if (result == 0)
        {   return FALSE;
        }
        sprintf(ck_filename, "CROS.%d", result);
        return TRUE;
    } // implied else

    if (!(AslRequestTags
    (   ASLRqPtr,
        ASLFR_TitleText,      "Import Crusaders of Khazan Character",
        ASLFR_InitialPattern, "CROS.?",
        ASLFR_DoPatterns,     TRUE,
        ASLFR_RejectIcons,    TRUE,
    TAG_DONE)))
    {   // the user chose Cancel
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    if (*(ASLRqPtr->fr_File) == 0)
    {   // the user clicked OK with an empty filename
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    DISCARD strcpy(ck_filename, ASLRqPtr->fr_Drawer);
    if (!AddPart(ck_filename, ASLRqPtr->fr_File, MAX_PATH + 1))
    {   FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    FreeAslRequest(ASLRqPtr);
    return TRUE;
}

EXPORT FLAG asl_delete(void)
{   struct FileRequester* ASLRqPtr;

    if
    (   userstring[0]
     || !AslBase
     || !(ASLRqPtr = AllocAslRequestTags
        (   ASL_FileRequest,
            ASLFR_Window, MainWindowPtr,
        TAG_DONE))
    )
    {   showfiles();
        aprintf("Delete which character?\n");
        show_output();
        loop(FALSE);
        if (userinput[0])
        {   userinput[0] = toupper(userinput[0]);
            if (userstring[0])
            {   sprintf(ck_filename, "PROGDIR:%s/%s.tnt", userstring, userinput);
            } else
            {   sprintf(ck_filename,            "%s.tnt",             userinput);
            }
            return TRUE;
        } else
        {   return FALSE;
    }   }
    // implied else

    if (!(AslRequestTags
    (   ASLRqPtr,
        ASLFR_TitleText,      "Delete Character",
        ASLFR_InitialDrawer,  "PROGDIR:",
        ASLFR_InitialPattern, "(#?.TNT|CROS.?)",
        ASLFR_DoPatterns,     TRUE,
        ASLFR_RejectIcons,    TRUE,
    TAG_DONE)))
    {   // the user chose Cancel
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    if (*(ASLRqPtr->fr_File) == 0)
    {   // the user clicked OK with an empty filename
        FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    DISCARD strcpy(ck_filename, ASLRqPtr->fr_Drawer);
    if (!AddPart(ck_filename, ASLRqPtr->fr_File, MAX_PATH + 1))
    {   FreeAslRequest(ASLRqPtr);
        return FALSE;
    }

    FreeAslRequest(ASLRqPtr);
    return TRUE;
}

MODULE ULONG StringHookFunc(struct Hook* hook, struct SGWork* sgw, ULONG* msg)
{   ULONG cursorpos,
          entries,
          retval = 0,
          visible;

    geta4();

    if (*msg == SGH_KEY)
    {   if (sgw->Actions & SGA_END)
        {   if (sgw->IEvent->ie_Code == SCAN_ESC)
            {   sgw->Code = SCAN_ESC;
                return ~0;
        }   }

        switch (sgw->IEvent->ie_Code)
        {
        case  CURSORUP:
            if (TextFieldBase)
            {   GetAttr(GA_TEXTEDITOR_Prop_First,   (Object*) gadgets[GID_TE1], (ULONG*) &cursorpos);
                GetAttr(GA_TEXTEDITOR_Prop_Visible, (Object*) gadgets[GID_TE1], (ULONG*) &visible);
             // GetAttr(GA_TEXTEDITOR_Prop_Entries, (Object*) gadgets[GID_TE1], (ULONG*) &entries);
                if (sgw->IEvent->ie_Qualifier & IEQUALIFIER_CONTROL)
                {   cursorpos = 0;
                } elif (sgw->IEvent->ie_Qualifier & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
                {   if (cursorpos > visible - 1)
                    {   cursorpos -= visible - 1;
                    } else
                    {   cursorpos = 0;
                }   }
                else
                {   if (cursorpos > 0)
                    {   cursorpos--;
                }   }
                DISCARD SetGadgetAttrs
                (   gadgets[GID_TE1], // pointer to gadget
                    MainWindowPtr,    // pointer to window (not window object!)
                    NULL,             // pointer to requester
                    GA_TEXTEDITOR_Prop_First, cursorpos,
                TAG_DONE); // this autorefreshes
                DISCARD SetGadgetAttrs
                (   gadgets[GID_SC1], // pointer to gadget
                    MainWindowPtr,    // pointer to window (not window object!)
                    NULL,             // pointer to requester
                    SCROLLER_Top, cursorpos,
                TAG_DONE); // this autorefreshes
            }

            sgw->Actions   &= ~SGA_END;
            sgw->Actions   |= SGA_USE | SGA_REDISPLAY;
            sgw->BufferPos =
            sgw->NumChars  =  strlen(sgw->WorkBuffer);

            retval = ~0;
        acase CURSORDOWN:
            if (TextFieldBase)
            {   GetAttr(GA_TEXTEDITOR_Prop_First,   (Object*) gadgets[GID_TE1], (ULONG*) &cursorpos);
                GetAttr(GA_TEXTEDITOR_Prop_Visible, (Object*) gadgets[GID_TE1], (ULONG*) &visible);
                GetAttr(GA_TEXTEDITOR_Prop_Entries, (Object*) gadgets[GID_TE1], (ULONG*) &entries);
                if (sgw->IEvent->ie_Qualifier & IEQUALIFIER_CONTROL)
                {   cursorpos = entries - visible;
                } elif (sgw->IEvent->ie_Qualifier & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
                {   if (cursorpos + visible > entries - visible)
                    {   cursorpos = entries - visible;
                    } else
                    {   cursorpos += visible - 1;
                }   }
                else
                {   if (cursorpos < entries - visible)
                    {   cursorpos++;
                }   }

                DISCARD SetGadgetAttrs
                (   gadgets[GID_TE1], // pointer to gadget
                    MainWindowPtr,    // pointer to window (not window object!)
                    NULL,             // pointer to requester
                    GA_TEXTEDITOR_Prop_First, cursorpos,
                TAG_DONE); // this autorefreshes
                DISCARD SetGadgetAttrs
                (   gadgets[GID_SC1], // pointer to gadget
                    MainWindowPtr,    // pointer to window (not window object!)
                    NULL,             // pointer to requester
                    SCROLLER_Top, cursorpos,
                TAG_DONE); // this autorefreshes
            }

            sgw->Actions   &= ~SGA_END;
            sgw->Actions   |= SGA_USE | SGA_REDISPLAY;
            sgw->BufferPos =
            sgw->NumChars  =  strlen(sgw->WorkBuffer);

            retval = ~0;
    }   }

    return retval;
}

EXPORT FLAG confirmed(void)
{   struct EasyStruct EasyStruct =
    {   sizeof(struct EasyStruct),
        0,
        "Tunnels & Trolls",
        "Really quit?",
        "Yes|No"
    };

    if (userstring[0])
    {   if (getyn("Really quit"))
        {   return TRUE;
        } // implied else
        return FALSE;
    } // implied else

    if (FindTask("MCP")) // MCP has bugs relating to EasyRequest()!
    {   return TRUE;
    } // implied else

    return (FLAG) EasyRequest(MainWindowPtr, &EasyStruct, NULL);
}
