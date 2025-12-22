#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#else
    #define ZERO (BPTR) NULL
#endif

// INCLUDES --------------------------------------------------------------

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/dos.h>
#include <proto/gadtools.h>
#include <proto/locale.h>
#include <proto/amigaguide.h>
#include <proto/asl.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <clib/alib_protos.h>      // HookEntry

#include <exec/exec.h>             // struct Resident
#include <intuition/intuition.h>   // struct EasyStruct
#include <dos/datetime.h>          // struct DateTime
#include <dos/dostags.h>           // SYS_Output
#include <libraries/gadtools.h>    // struct NewGadget
#include <libraries/amigaguide.h>  // struct NewAmigaGuide
#include <libraries/asl.h>         // ASL_FileRequest
#ifdef __amigaos4__
    #include <libraries/application.h>
#endif
#include <intuition/gadgetclass.h> // GA_Disabled

#ifdef __SASC
    #include <dos.h>               // geta4()
#else
    #define geta4()
#endif /* of __SASC */

#ifdef __AROS__
    #include <workbench/workbench.h>
    #include <workbench/startup.h>
#endif

#include <ctype.h>                 // size_t
#include <stdio.h>                 // sprintf()
#include <string.h>                // strcpy()

#include "shared.h"
#ifdef GAME_AFRICA
    #define GAMENAME "Africa"
    #include "africa.h"
#endif
#ifdef GAME_SAGA
    #define GAMENAME "Saga"
    #include "saga.h"
#endif
#ifdef GAME_WORMWARS
    #define GAMENAME "Worm Wars"
    #include "amiga.h"
    #include "ww.h"
#endif

#ifndef __MORPHOS__
    #if !defined(__amigaos4__) && !defined(__AROS__)
        #define USE_LOCAL_OPENURL
    #endif
#endif
#ifdef __MORPHOS__
    #define USE_INLINE_STDARG
    #include <proto/openurl.h>
#else
    #ifdef USE_LOCAL_OPENURL
        #include "openurl.h"
    #else
        #define __USE_INLINE__
        #include <proto/openurl.h>
        #include <libraries/openurl.h>
    #endif
#endif

#define CATCOMP_NUMBERS
#define CATCOMP_CODE
#define CATCOMP_BLOCK
#ifdef GAME_AFRICA
    #include "africa_strings.h"
#endif
#ifdef GAME_SAGA
    #include "saga_strings.h"
#endif
#ifdef GAME_WORMWARS
    #include "ww_strings.h"
#endif

// DEFINES ---------------------------------------------------------------

#define ABOUTLINES          11 // 0..10

#define DIPF_IS_RTG 0x80000000 /* mode is RTG and does not use the native chip set */

// EXPORTED VARIABLES ----------------------------------------------------

EXPORT struct Library*     VersionBase   = NULL;

// IMPORTED VARIABLES ----------------------------------------------------

IMPORT SBYTE               NewPri;
IMPORT FLAG                customscreen,
                           morphos,
                           urlopen;
IMPORT TEXT                pathname[MAX_PATH + 1],
                           saystring[256 + 1],
                           screenname[MAXPUBSCREENNAME];
IMPORT UBYTE               remapit[16];
IMPORT WORD                AboutXPos,
                           AboutYPos;
IMPORT UWORD               DisplayDepth;
IMPORT UWORD               AboutData[114 * 8];
IMPORT ULONG               AppLibSignal,
                           DisplayID,
                           DisplayWidth,
                           DisplayHeight;
IMPORT int                 fonty;
IMPORT struct Image        About;
IMPORT struct TextAttr     Topaz8;
IMPORT struct Process*     ProcessPtr;
IMPORT struct TextFont*    FontPtr;
IMPORT struct Screen*      ScreenPtr;
IMPORT struct VisualInfo*  VisualInfoPtr;
IMPORT struct Window*      MainWindowPtr;
IMPORT struct Catalog*     CatalogPtr;

IMPORT struct Library*     OpenURLBase;
#ifdef __amigaos4__
    IMPORT ULONG                    AppID;
    IMPORT struct Library*          ApplicationBase;
    IMPORT struct ApplicationIFace* IApplication;
#endif

// MODULE VARIABLES ------------------------------------------------------

MODULE struct Gadget*      AboutGListPtr = NULL; // important that this is NULL!
MODULE struct Window*      HelpWindowPtr = NULL;
#ifdef __amigaos4__
    MODULE struct MsgPort* AppLibPort    = NULL; // important that this is NULL!
#endif
#ifdef __AROS__
    MODULE BPTR            ProgLock;
#endif

// MODULE STRUCTURES -----------------------------------------------------

MODULE struct EasyStruct EasyStruct =
{   sizeof(struct EasyStruct),
    0,
    NULL,
    NULL,
    NULL
};

MODULE struct
{   WORD x, y;
    TEXT text[80 + 1];
} about[ABOUTLINES] =
{   { 67,  14, TITLEBAR  }, // name
    { 67,  24, ""        }, // date
    { 67,  44, ""        }, // credits
    { 67,  54, COPYRIGHT }, // copyright
    { 11,  74, ""        }, // compiled for
    { 11,  84, ""        }, // running on
    { 11,  94, ""        }, // priority
    { 11, 104, ""        }, // process number
    { 11, 114, ""        }, // public screen name
    { 11, 134, ""        }, // translation by
    { 11, 144, ""        }, // translator
};

// MODULE ARRAYS ---------------------------------------------------------

// (None)

// MODULE FUNCTIONS ------------------------------------------------------

MODULE void closeabout(void);
MODULE void getosversion(STRPTR output);
MODULE void getreleasedate(STRPTR output);

// CODE ------------------------------------------------------------------

EXPORT void help_about(void)
{   TRANSIENT SBYTE                line,
                                   temppri;
    TRANSIENT FLAG                 done                = FALSE;
    TRANSIENT ULONG                class;
    TRANSIENT UWORD                code, qual;
    TRANSIENT struct IntuiMessage* MsgPtr;
    TRANSIENT struct Gadget       *AboutPrevGadgetPtr,
                                  *addr,
                                  *EmailGadgetPtr,
                                  *WebsiteGadgetPtr;
    TRANSIENT int                  tbwidth,
                                   tbheight;
    struct NewGadget     EmailGadget =
    {   11,  172,
        274,  13,
        (STRPTR) "amigansoftware@gmail.com",
        NULL,
        0,
        0,
        NULL,
        NULL
    },                   WebsiteGadget =
    {   11,  158,
        274,  13,
        (STRPTR) "amigan.1emu.net/releases/",
        NULL,
        0,
        0,
        NULL,
        NULL
    };

      EmailGadget.ng_VisualInfo =
    WebsiteGadget.ng_VisualInfo = VisualInfoPtr;

      EmailGadget.ng_TextAttr   =
    WebsiteGadget.ng_TextAttr   = &Topaz8;

#ifdef GAME_AFRICA
    if (!(HelpWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          AboutXPos,
        WA_Top,           AboutYPos,
        WA_InnerWidth,    ABOUTXPIXEL,
        WA_InnerHeight,   ABOUTYPIXEL,
        WA_IDCMP,         IDCMP_CLOSEWINDOW
                        | IDCMP_RAWKEY
                        | IDCMP_MOUSEBUTTONS
                        | IDCMP_REFRESHWINDOW
                        | BUTTONIDCMP,
        WA_Title,         (ULONG) LLL(MSG_ABOUT, "About Africa"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }
#endif
#ifdef GAME_SAGA
    if (!(HelpWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          AboutXPos,
        WA_Top,           AboutYPos,
        WA_InnerWidth,    ABOUTXPIXEL,
        WA_InnerHeight,   ABOUTYPIXEL,
        WA_IDCMP,         IDCMP_CLOSEWINDOW
                        | IDCMP_RAWKEY
                        | IDCMP_MOUSEBUTTONS
                        | IDCMP_REFRESHWINDOW
                        | BUTTONIDCMP,
        WA_Title,         (ULONG) LLL(MSG_ABOUT, "About Saga"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }
#endif
#ifdef GAME_WORMWARS
    if (!(HelpWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          AboutXPos,
        WA_Top,           AboutYPos,
        WA_InnerWidth,    ABOUTXPIXEL,
        WA_InnerHeight,   ABOUTYPIXEL,
        WA_IDCMP,         IDCMP_CLOSEWINDOW
                        | IDCMP_RAWKEY
                        | IDCMP_MOUSEBUTTONS
                        | IDCMP_REFRESHWINDOW
                        | BUTTONIDCMP,
        WA_Title,         (ULONG) LLL(MSG_HAIL_ABOUT, "About Worm Wars"),
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
    TAG_DONE)))
    {   rq("Can't open window!");
    }
#endif

    tbwidth  = (int) HelpWindowPtr->BorderLeft;
    tbheight = (int) HelpWindowPtr->BorderTop;
      EmailGadget.ng_LeftEdge += tbwidth;
    WebsiteGadget.ng_LeftEdge += tbwidth;
      EmailGadget.ng_TopEdge  += tbheight;
    WebsiteGadget.ng_TopEdge  += tbheight;

    // assert(AboutGListPtr);
    if (!(AboutPrevGadgetPtr = (struct Gadget*) CreateContext(&AboutGListPtr)))
    {   rq("Can't create GadTools context!");
    }
    EmailGadgetPtr = AboutPrevGadgetPtr = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        AboutPrevGadgetPtr,
        &EmailGadget,
        GA_Disabled,      (!OpenURLBase && !urlopen),
        GA_RelVerify,     TRUE,
    TAG_DONE);
    WebsiteGadgetPtr = AboutPrevGadgetPtr = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        AboutPrevGadgetPtr,
        &WebsiteGadget,
        GA_Disabled,      (!OpenURLBase && !urlopen),
        GA_RelVerify,     TRUE,
    TAG_DONE);

    SetFont(HelpWindowPtr->RPort, FontPtr);
    SetAPen(HelpWindowPtr->RPort, remapit[MEDIUMGREY]);
    SetDrMd(HelpWindowPtr->RPort, JAM1);
    RectFill
    (   HelpWindowPtr->RPort,
        tbwidth  + 2,
        tbheight + 2,
        tbwidth  + ABOUTXPIXEL - 4,
        tbheight + ABOUTYPIXEL - 4
    );

    RefreshGadgets(AboutGListPtr, HelpWindowPtr, NULL);
    GT_RefreshWindow(HelpWindowPtr, NULL);

    getreleasedate(about[1].text);
    sprintf
    (   about[2].text,
        "%s James Jacobs",
        LLL(MSG_BY, "By")
    );
    sprintf
    (   about[4].text,
        "%-24s %s",
        (STRPTR) LLL(MSG_COMPILEDFOR   , "Compiled for:"),
        #ifdef __MORPHOS__
            "MorphOS PPC"
        #else
            #ifdef __amigaos4__
                "AmigaOS 4" // no room for anything longer
            #else
                #ifdef __AROS__
                    "AROS"
                #else
                    "AmigaOS 3" // no room for anything longer
                #endif
            #endif
        #endif
    );
    sprintf
    (   about[5].text,
        "%-24s ",
        (STRPTR) LLL(MSG_RUNNINGON     , "Running on:")
    );
    getosversion(&about[5].text[25]);
    // we reread the priority each time in case it has been changed in
    // the meantime
    temppri = NewPri;
    NewPri = SetTaskPri((struct Task *) ProcessPtr, NewPri);
    if (NewPri != temppri)
    {   NewPri = temppri;
        DISCARD SetTaskPri((struct Task *) ProcessPtr, NewPri);
    }
    sprintf
    (   about[6].text,
        "%-24s %d",
        (STRPTR) LLL(MSG_PRIORITY      , "Priority:"),
        (int) NewPri
    );
    sprintf
    (   about[7].text,
        "%-24s %d",
        (STRPTR) LLL(MSG_PROCESSNUMBER , "Process number:"),
#ifdef __amigaos4__
        (int) ProcessPtr->pr_CliNum
#else
        (int) ProcessPtr->pr_TaskNum
#endif
    );
    sprintf
    (   about[8].text,
        "%-24s %.9s",
        (STRPTR) LLL(MSG_PUBSCREEN     , "Public screen name:"),
        customscreen ? (TEXT*) "n/a" : screenname
    );
    strcpy(about[ 9].text, (STRPTR) LLL(MSG_TRANSLATOR1, "English translation by"));
    strcpy(about[10].text, (STRPTR) LLL(MSG_TRANSLATOR2, "James Jacobs"));

    for (line = 0; line < ABOUTLINES; line++)
    {   if (line == 0)
        {   DISCARD SetSoftStyle(HelpWindowPtr->RPort, FSF_BOLD,  FSF_BOLD);
        } else
        {   DISCARD SetSoftStyle(HelpWindowPtr->RPort, FS_NORMAL, FSF_BOLD);
        }
        shadowtext(HelpWindowPtr->RPort, about[line].text, WHITE, tbwidth + about[line].x, tbheight + about[line].y);
    }

    DrawImage(HelpWindowPtr->RPort, &About, tbwidth + 13, tbheight + 13);

#ifdef GAME_WORMWARS
    effect(FXHELP);
#endif

    while (!done)
    {   if (Wait((1 << HelpWindowPtr->UserPort->mp_SigBit) | SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C)
        {   closeabout();
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(HelpWindowPtr->UserPort)))
        {   addr  = (struct Gadget*) MsgPtr->IAddress;
            class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_CLOSEWINDOW:
            case IDCMP_MOUSEBUTTONS:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if
                (   !(qual & IEQUALIFIER_REPEAT)
                 && code < KEYUP
                 && code != NM_WHEEL_UP
                 && code != NM_WHEEL_DOWN
                 && (code < FIRSTQUALIFIER || code > LASTQUALIFIER)
                )
                {   if
                    (   code == SCAN_ESCAPE
                     && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    )
                    {
#ifdef GAME_WORMWARS
                        if (verify())
#else
                        if (1)
#endif
                        {   closeabout();
                            cleanexit(EXIT_SUCCESS);
                    }   }
                    else
                    {   done = TRUE;
                }   }
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(HelpWindowPtr);
                GT_EndRefresh(HelpWindowPtr, TRUE);
            acase IDCMP_GADGETUP:
                if (addr == WebsiteGadgetPtr)
                {   openurl("http://amigan.1emu.net/releases/");
                } elif (addr == EmailGadgetPtr)
                {   openurl("mailto:amigansoftware@gmail.com");
    }   }   }   }

    closeabout();
}

MODULE void closeabout(void)
{   AboutXPos = HelpWindowPtr->LeftEdge;
    AboutYPos = HelpWindowPtr->TopEdge;
    clearkybd_normal(HelpWindowPtr);
    CloseWindow(HelpWindowPtr);
    HelpWindowPtr = NULL;
    if (AboutGListPtr)
    {   FreeGadgets(AboutGListPtr);
        AboutGListPtr = NULL;
    }
    clearkybd_gt(MainWindowPtr);
}

MODULE void getosversion(STRPTR output)
{   if ((VersionBase = (struct Library*) OpenLibrary("version.library", OS_ANY)))
    {   switch (VersionBase->lib_Version)
        {
        case 39:
            strcpy(    output, "OS3.0");
        acase 40:
        case 41:
        case 42:
        case 43:
            strcpy(    output, "OS3.1");
        acase 44:
            strcpy(    output, "OS3.5+");
            switch (VersionBase->lib_Revision)
            {
            case 2:
                strcat(output, "BB0"); // the Amiga Down Under 1999 show prerelease also uses this revision number
            acase 4: // guess
                strcat(output, "BB1");
            acase 5:
                strcat(output, "BB2");
            adefault:
                strcat(output, "?");
            }
        acase 45:
            strcpy(    output, "OS3.");
            switch (VersionBase->lib_Revision)
            {
            case    1: strcat(output, "9+BB0");
            acase   2: strcat(output, "9+BB1");
            acase   3: strcat(output, "9+BB2"); // Cloanto OS3.X crap falsely claims this version number
            acase   4: strcat(output, "9+BB3");
            acase   5: strcat(output, "9+BB4");
            acase 194: strcat(output, "1.4");
            adefault:  strcat(output, "?");
            }
        acase 46:
            strcpy(    output, "OS3.1.4(.1)"); // 3.1.4.1 doesn't have an upgraded version.library
        acase 47:
            strcpy(    output, "OS3.2+BB");
            switch (VersionBase->lib_Revision)
            {
            case    2: strcat(output, "0");
            acase   3: strcat(output, "1");
            acase   4: strcat(output, "2(.1)"); // 3.2.2.1 doesn't have an upgraded version.library
            acase   5: strcat(output, "3");
            adefault:  strcat(output, "?");
            }
        acase 48:
            strcpy(    output, "OS3.3");
        acase 50:
        {   struct Resident* rt = FindResident("MorphOS");

            sprintf(   output, "MorphOS %d", (int) rt->rt_Version);
        }
        acase 51:
        case 52:
            strcpy(    output, "OS4.0");
        acase 53:
            strcpy(    output, "OS4.1");
            if (VersionBase->lib_Revision >= 14)
            {   switch (VersionBase->lib_Revision)
                {
                case  14: strcat(output, "FEu0");
                acase 15: strcat(output, "FEu1");
                acase 17:                         // OS4.1FEu2 without hotfix
                case  18: strcat(output, "FEu2"); // OS4.1FEu2 with    hotfix
                adefault: strcat(output, "FEu?");
            }   }
        acase 54:
            strcpy(    output, "OS4.2?");
        adefault:
            strcpy(    output, "?");
        }
        CloseLibrary(VersionBase);
        VersionBase = NULL;
    } else
    {   strcpy(        output, "?");
}   }

EXPORT void openurl(STRPTR command)
{   PERSIST       TEXT           localstring[80 + 1];
#ifndef __amigaos4__
    PERSIST const struct TagItem URLTags[1] = {{TAG_DONE, (ULONG) NULL}};
#endif

    // assert(OpenURLBase || urlopen);

    if (urlopen)
    {   sprintf(localstring, "URLOpen \"%s\"", command);
        DISCARD SystemTags
        (   localstring,
            SYS_Asynch, TRUE,
            SYS_Input,  NULL,
            SYS_Output, NULL,
        TAG_DONE);
    } else
    {
#ifdef __amigaos4__
        DISCARD URL_Open(command, TAG_DONE);
#else
        DISCARD URL_OpenA(command, (struct TagItem*) URLTags);
#endif
}   }

EXPORT void shadowtext(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y)
{        SetDrMd(RastPortPtr, JAM1);
         SetAPen(RastPortPtr, remapit[BLACK]);
            Move(RastPortPtr, x + 1, y + 1);
    DISCARD Text(RastPortPtr, text, strlen(text));
         SetAPen(RastPortPtr, remapit[colour]);
            Move(RastPortPtr, x, y);
    DISCARD Text(RastPortPtr, text, strlen(text));
}

EXPORT void InitHook(struct Hook* hook, ULONG (*func)(), void* data)
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
    {   rq("Can't initialize hook!");
}   }

//             A0              A2               A1
ULONG HookFunc(struct Hook* h, VOID* requester, VOID* screenmode)
{   struct DimensionInfo DimInfo;
#ifdef __amigaos4__
    struct DisplayInfo   DisInfo;
#endif

#ifdef __SASC
    geta4(); // wait till here before doing anything
#endif

#ifndef GAME_WORMWARS
    if ((ULONG) screenmode == (SUPER_KEY | PAL_MONITOR_ID | LACE)) // reject 1024*512 AGA
    {   return (ULONG) FALSE;
    }
#endif

    if (!(GetDisplayInfoData
    (   NULL,
        (UBYTE*) &DimInfo,
        sizeof(struct DimensionInfo),
        DTAG_DIMS,
        (ULONG) screenmode
    )))
    {   return((ULONG) FALSE);
    } // implied else

#ifdef __amigaos4__
    if (!(GetDisplayInfoData
    (   NULL,
        (UBYTE*) &DisInfo,
        sizeof(struct DisplayInfo),
        DTAG_DISP,
        (ULONG) screenmode
    )))
    {   return((ULONG) FALSE);
    } // implied else
#endif

    if
    (

#if defined(GAME_AFRICA) || defined(GAME_SAGA)
        (DimInfo.MaxDepth >= MINDEPTH && DimInfo.MaxDepth <= MAXDEPTH)
#endif
#ifdef GAME_WORMWARS
         DimInfo.MaxDepth >= (morphos ? 9 : DEPTH)
#endif
#ifdef __amigaos4__
     && (DisInfo.PropertyFlags & DIPF_IS_RTG)
#endif
     &&  DimInfo.Nominal.MaxX - DimInfo.Nominal.MinX + 1 >= SCREENXPIXEL
     &&  DimInfo.Nominal.MaxY - DimInfo.Nominal.MinY + 1 >= SCREENYPIXEL
    )
    {   return((ULONG) TRUE);
    } // implied else
    return((ULONG) FALSE);
}

EXPORT void msg(void)
{   EasyStruct.es_TextFormat   =                     (STRPTR) saystring;
    sprintf((STRPTR) EasyStruct.es_Title, "%s: %s", GAMENAME, LLL(MSG_RECOVERABLE, "Recoverable Error"));
    EasyStruct.es_GadgetFormat =                     (STRPTR) LLL(MSG_OK         , "OK");

    DISCARD EasyRequest(MainWindowPtr, &EasyStruct, NULL); // MainWindowPtr must be valid or NULL
}

EXPORT void rq(STRPTR text)
{   EasyStruct.es_TextFormat   = (STRPTR) text;
    sprintf((STRPTR) EasyStruct.es_Title, "%s: %s", GAMENAME, LLL(MSG_FATAL      , "Fatal Error"));
    EasyStruct.es_GadgetFormat =                     (STRPTR) LLL(MSG_MENU_QUITWB, "Quit"); // actually "Quit Worm Wars" or whatever

    DISCARD EasyRequest(MainWindowPtr, &EasyStruct, NULL); // MainWindowPtr must be valid or NULL
    cleanexit(EXIT_FAILURE);
}

EXPORT void help_manual(void)
{   PERSIST struct NewAmigaGuide nag =
    {   ZERO,   // nag_Lock
        NULL,   // nag_Name (initialized later)
        NULL,   // nag_Screen (initialized later)
        NULL,   // nag_PubScreen
        NULL,   // nag_HostPort
        NULL,   // nag_ClientPort
        NULL,   // nag_BaseName
        0,      // nag_Flags
        NULL,   // nag_Context
        "MAIN", // nag_Node
        0,      // nag_Line
        NULL,   // nag_Extens
        NULL    // nag_Client
    };

    // assert(AmigaGuideBase);
    // assert(ScreenPtr);

#ifdef GAME_SAGA
    nag.nag_Name = (STRPTR) LLL(FILENAME_MANUAL, "PROGDIR:Saga_E.guide");
#endif
#ifdef GAME_AFRICA
    nag.nag_Name = (STRPTR) "PROGDIR:Africa.guide";
#endif
#ifdef GAME_WORMWARS
    nag.nag_Name = (STRPTR) "PROGDIR:WormWars.guide";
#endif

#ifdef __AROS__
    if (!customscreen)
    {   if (!ProgLock)
        {   ProgLock = GetProgramDir(); // never unlock this!
        }

        BPTR OldDir = CurrentDir(ProgLock);

        DISCARD OpenWorkbenchObject
#ifdef GAME_AFRICA
        (   "Africa.guide",
            WBOPENA_ArgName, (ULONG) "Africa.guide",
#endif
#ifdef GAME_SAGA
        (   "Saga_E.guide",
            WBOPENA_ArgName, (ULONG) "Saga_E.guide",
#endif
#ifdef GAME_WORMWARS
        (   "WormWars.guide",
            WBOPENA_ArgName, (ULONG) "WormWars.guide",
#endif
            WBOPENA_ArgLock, (ULONG) ProgLock,
        TAG_DONE);

        DISCARD CurrentDir(OldDir);
    }
#endif

    nag.nag_Screen = ScreenPtr;
    DISCARD OpenAmigaGuide
    (   &nag,
    TAG_DONE);
    ScreenToFront(ScreenPtr);
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

MODULE void getreleasedate(STRPTR output)
{   TEXT            datestring[LEN_DATSTRING],
                    weekdaystring[LEN_DATSTRING];
    struct DateTime DateTime;

    DateTime.dat_Format          = FORMAT_CDN;
    DateTime.dat_Flags           = 0;
    DateTime.dat_StrDate         = (STRPTR) RELEASEDATE;
    DateTime.dat_StrDay          = NULL;
    DateTime.dat_StrTime         = NULL;
    DateTime.dat_Stamp.ds_Minute = 0;
    DateTime.dat_Stamp.ds_Tick   = 0;
    if (StrToDate(&DateTime))
    {   // DateTime.dat_Stamp is now filled
        DateTime.dat_Format  = FORMAT_DEF;
        DateTime.dat_Flags   = 0;
        DateTime.dat_StrDate = (STRPTR) datestring;
        DateTime.dat_StrDay  = (STRPTR) weekdaystring;
        DateTime.dat_StrTime = NULL;
        if (DateToStr(&DateTime))
        {   sprintf(output, "%s %s", weekdaystring, datestring);
}   }   }

EXPORT void clearkybd_normal(struct Window* WindowPtr)
{   struct IntuiMessage* MsgPtr;

    while ((MsgPtr = (struct IntuiMessage*) GetMsg(WindowPtr->UserPort)))
    {   ReplyMsg((struct Message*) MsgPtr);
}   }

EXPORT void clearkybd_gt(struct Window* WindowPtr)
{   // UWORD             code;
    struct IntuiMessage* MsgPtr;

    // Only use this on GadTools windows!

    while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(WindowPtr->UserPort)))
    {   /* code  = MsgPtr->Code;
        if (code == IDCMP_MENUPICK)
        {   handlemenu(code, ingame);
        } */
        GT_ReplyIMsg(MsgPtr);
}   }

#if defined(__AROS__) && (AROS_BIG_ENDIAN == 0)
EXPORT void swap_byteorder(UWORD* imagedata, ULONG size)
{   int i;

    for (i = 0; i < size; i++)
    {   imagedata[i] = ((imagedata[i] & 0xff00) >> 8) | ((imagedata[i] & 0xff) << 8);
}   }
#endif

EXPORT void getscreenmode(void)
{   TEXT                        smrstring[80 + 1];
    int                         borderwidth, borderheight,
                                sparewidth,  spareheight;
    struct DimensionInfo        QueryInfo;
    struct Hook                 HookStruct;
    struct ScreenModeRequester* smr;

    lockscreen();
    borderwidth  = ScreenPtr->WBorLeft +             ScreenPtr->WBorRight;
    borderheight = ScreenPtr->WBorTop  + fonty + 1 + ScreenPtr->WBorBottom;
    sparewidth   = ScreenPtr->Width    - borderwidth;
    spareheight  = ScreenPtr->Height   - borderheight;
    unlockscreen();

    if (sparewidth >= 640 && spareheight >= 512)
    {   EasyStruct.es_TextFormat   = (STRPTR) LLL(MSG_WHATSCREEN, "What screen do you want to run the game on?");
        EasyStruct.es_Title        = (STRPTR) TITLEBAR;
        EasyStruct.es_GadgetFormat = (STRPTR) LLL(MSG_CUSTOMWB,   "Custom screen|Workbench screen");
        if (EasyRequest(NULL, &EasyStruct, NULL) == 0) // return codes go 1, 0!
        {   customscreen = FALSE;
#ifdef GAME_WORMWARS
            if   (sparewidth  >= 1280) DisplayWidth  = 1280;
            elif (sparewidth  >= 1024) DisplayWidth  = 1024;
            elif (sparewidth  >=  800) DisplayWidth  =  800;
            else                       DisplayWidth  =  640;
            if   (spareheight >= 1024) DisplayHeight = 1024;
            elif (spareheight >=  768) DisplayHeight =  768;
            elif (spareheight >=  600) DisplayHeight =  600;
            else                       DisplayHeight =  512;
#else
            DisplayWidth  = 640;
            DisplayHeight = 512;
#endif
#if defined(__AROS__) && !defined(GAME_WORMWARS)
        }
        return;
#else
            return;
        }
#endif
    }

    InitHook(&HookStruct, (ULONG (*)())HookFunc, NULL);

    sprintf(smrstring, "%s: %s", GAMENAME, LLL(MSG_S_M_R, "Screen Mode Requester"));

#if defined(GAME_AFRICA) || defined(GAME_SAGA)
    if (!(smr = (struct ScreenModeRequester*) AllocAslRequestTags
    (   ASL_ScreenModeRequest,
        ASLSM_TitleText,           (ULONG) smrstring,
        ASLSM_InitialDisplayID,    HIRES_KEY | PAL_MONITOR_ID | LACE,
        ASLSM_DoDepth,             TRUE,
        ASLSM_MinDepth,            MINDEPTH,
        ASLSM_MaxDepth,            MAXDEPTH,
        ASLSM_InitialDisplayDepth, DEPTH,
        ASLSM_FilterFunc,          (ULONG) &HookStruct,
    TAG_DONE)))
    {   rq("Can't create ASL screen mode requester!");
    }
#endif
#ifdef GAME_WORMWARS
    if (!(smr = (struct ScreenModeRequester*) AllocAslRequestTags
    (   ASL_ScreenModeRequest,
        ASLSM_TitleText,           (ULONG) smrstring,
        ASLSM_InitialDisplayID,    HIRES_KEY | PAL_MONITOR_ID | LACE,
        ASLSM_DoDepth,             TRUE,
        ASLSM_MinDepth,            morphos ? 9 : DEPTH,
        ASLSM_MinWidth,            SCREENXPIXEL,
        ASLSM_MinHeight,           SCREENYPIXEL,
        ASLSM_InitialDisplayDepth, DEPTH,
        ASLSM_FilterFunc,          (ULONG) &HookStruct,
    TAG_DONE)))
    {   rq("Can't create ASL screen mode requester!");
    }
#endif

    if (AslRequest(smr, 0))
    {   DisplayID     = smr->sm_DisplayID;
        DisplayDepth  = smr->sm_DisplayDepth;
        FreeAslRequest(smr);

        if (!(GetDisplayInfoData
        (   NULL,
            (UBYTE*) &QueryInfo,
            sizeof(struct DimensionInfo),
            DTAG_DIMS,
            DisplayID
        )))
        {   rq("Can't get display info data!");
        }

        DisplayWidth  = QueryInfo.Nominal.MaxX - QueryInfo.Nominal.MinX + 1;
        if (DisplayWidth < SCREENXPIXEL)
        {   DisplayWidth = SCREENXPIXEL;
        }
        DisplayHeight = QueryInfo.Nominal.MaxY - QueryInfo.Nominal.MinY + 1;
        if (DisplayHeight < SCREENYPIXEL)
        {   DisplayHeight = SCREENYPIXEL;
        }

        AboutXPos = (DisplayWidth  / 2) - (  ABOUTXPIXEL / 2);
        AboutYPos = (DisplayHeight / 2) - (  ABOUTYPIXEL / 2);
    } else
    {   FreeAslRequest(smr);
        cleanexit(EXIT_SUCCESS);
    }

    // assert(DisplayWidth  >= SCREENXPIXEL);
    // assert(DisplayHeight >= SCREENYPIXEL);
    // assert(DisplayDepth  >= MINDEPTH    );
}

#ifdef __amigaos4__
EXPORT void registerapp(void)
{   if
    (   (ApplicationBase = OpenLibrary("application.library", OS_ANY))
     && (IApplication    = (struct ApplicationIFace*)
                           GetInterface(ApplicationBase, "application", 2, 0))
    )
    {
#if defined(GAME_AFRICA) || defined(GAME_SAGA)
        AppID = RegisterApplication
        (   GAMENAME,
            REGAPP_Description,       (ULONG) LLL(MSG_APPDESC, "Board game"),
            REGAPP_AllowsBlanker,     TRUE,
            REGAPP_URLIdentifier,     (ULONG) "amigan.1emu.net",
            REGAPP_HasIconifyFeature, FALSE,
        TAG_DONE);
#endif
#ifdef GAME_WORMWARS
        AppID = RegisterApplication
        (   GAMENAME,
            REGAPP_Description,       (ULONG) LLL(MSG_APPDESC, "Arcade game"),
            REGAPP_AllowsBlanker,     FALSE,
            REGAPP_URLIdentifier,     (ULONG) "amigan.1emu.net",
            REGAPP_HasIconifyFeature, FALSE,
        TAG_DONE);
#endif
    }
    GetApplicationAttrs(AppID, APPATTR_Port, &AppLibPort, TAG_END);
    AppLibSignal = 1 << AppLibPort->mp_SigBit;
}

EXPORT int handle_applibport(FLAG loadable)
{   ULONG                  msgtype,
                           msgval;
    struct ApplicationMsg* AppLibMsg;

    if (!AppLibPort)
    {   return FALSE;
    }

    while ((AppLibMsg = (struct ApplicationMsg*) GetMsg(AppLibPort)))
    {   msgtype = AppLibMsg->type;
        msgval  = (ULONG) ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName;
        ReplyMsg((struct Message *) AppLibMsg);

        switch (msgtype)
        {
        case APPLIBMT_Quit:
            return 3; // means soft quit
        case APPLIBMT_ForceQuit:
            return 1; // means hard quit
        acase APPLIBMT_Hide:
            ScreenToBack(ScreenPtr);
        acase APPLIBMT_ToFront:
            ScreenToFront(ScreenPtr);
            // WindowToFront(MainWindowPtr);
            ActivateWindow(MainWindowPtr);
        acase APPLIBMT_OpenDoc:
            if (loadable)
            {   strcpy(pathname, ((struct ApplicationOpenPrintDocMsg*) AppLibMsg)->fileName);
#ifdef GAME_WORMWARS
                fileopen(TRUE);
                ScreenToFront(ScreenPtr);
                // WindowToFront(MainWindowPtr);
                ActivateWindow(MainWindowPtr);
                return 2; // means loaded
#else
                if (loadgame(FALSE))
                {   ScreenToFront(ScreenPtr);
                    // WindowToFront(MainWindowPtr);
                    ActivateWindow(MainWindowPtr);
                    return 2; // means loaded
                } else
                {   DisplayBeep(ScreenPtr); // file I/O error
                }
#endif
            } else
            {   DisplayBeep(ScreenPtr);
    }   }   }

    return 0;
}
#endif

#ifndef __SASC
EXPORT int stcl_d(char* out, long lvalue)
{   return sprintf(out, "%d", (int) lvalue);
}
#endif

EXPORT void lockscreen(void)
{   if (ScreenPtr)
    {   return;
    }

    if (screenname[0])
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) screenname)))
        {   printf
            (   (STRPTR) LLL(MSG_CANTLOCK_NAMED, "Can't lock public screen \"%s\"!"),
                screenname
            );
            printf("\n");
            cleanexit(EXIT_FAILURE);
    }   }
    else
    {   if (!(ScreenPtr = (struct Screen*) LockPubScreen((CONST_STRPTR) NULL)))
        {   printf((STRPTR) LLL(MSG_CANTLOCK_DEFAULT, "Can't lock default public screen!"));
            printf("\n");
            cleanexit(EXIT_FAILURE);
}   }   }

EXPORT void unlockscreen(void)
{   if (ScreenPtr)
    {   if (screenname[0])
        {   UnlockPubScreen(screenname, ScreenPtr);
            ScreenPtr = NULL;
        } else
        {   UnlockPubScreen(NULL, ScreenPtr);
            ScreenPtr = NULL;
}   }   }

EXPORT void zstrncpy(char* to, const char* from, size_t n)
{   DISCARD strncpy(to, from, n);
    to[n] = EOS;
}
