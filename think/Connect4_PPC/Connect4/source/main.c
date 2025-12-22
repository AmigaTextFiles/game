#ifdef __MORPHOS__
#undef USE_INLINE_STDARG
#endif

/* Uses Lamp.mcc */

#include "graphics_support.h"
#include "computer_player.h"

/* MUI */
#include <libraries/mui.h>
#include <mui/lamp_mcc.h>
#include <proto/muimaster.h>
#include "gameboardclass.h"

/* System */
#include <graphics/gfxmacros.h>
#include <workbench/workbench.h>
#include <exec/memory.h>
#include <libraries/iffparse.h>     // Also has MAKE_ID definition
#include <datatypes/pictureclass.h>

/* Prototypes */
#include <proto/alib.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/icon.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>
#include <proto/utility.h>
#include <proto/asl.h>
#include <proto/iffparse.h>

/* ANSI C */
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

/***********************************/
/***********************************/
/***********************************/

//extern struct Library *UtilityBase, *IconBase;
struct Library *MUIMasterBase=NULL;
struct Library *AslBase=NULL;
struct Library *IFFParseBase=NULL;

/***********************************/
/***********************************/
/***********************************/

#define PORT_LEN      10
#define NAME_LEN      20
#define TYPE_LEN      20
#define DETAIL_LEN    100
#define MAXPABENTRIES 200
/***********************************/
/***********************************/
/***********************************/

// Player Address Book - records player names, types and details
#pragma pack(2)
struct PAB_Entry
{
    STRPTR name, type, detail;
} *loaded_info[MAXPABENTRIES+1];

struct netstuff
{
    TEXT port[PORT_LEN];
    TEXT username[NAME_LEN];
} networkinfo = { "", "" };
#pragma pack()

STATIC APTR prefspool;

enum { MEN_NEWGAME=1, MEN_CONNECT4, MEN_ABOUTMUI, MEN_ICONIFY, MEN_QUIT, MEN_SETC4,
       MEN_SETMUI, MEN_SETLOAD, MEN_SETSAVE, MEN_SETDEFAULT };

STATIC CONST struct NewMenu connect4menu[] =
{
    { NM_TITLE, "Project",            0,  0, 0,    0                    },
    { NM_ITEM,    "New game",        "N", 0, 0,    (APTR)MEN_NEWGAME    },
    { NM_ITEM,    "About",            0,  0, 0,    0                    },
    { NM_SUB,       "Connect 4",     "?", 0, 0,    (APTR)MEN_CONNECT4   },
    { NM_SUB,       "MUI",            0,  0, 0,    (APTR)MEN_ABOUTMUI   },
    { NM_ITEM,    "Iconify",         "I", 0, 0,    (APTR)MEN_ICONIFY    },
    { NM_ITEM,    "Quit",            "Q", 0, 0,    (APTR)MEN_QUIT       },

    { NM_TITLE, "Settings",           0,  0, 0,    0                    },
    { NM_ITEM,    "Connect 4",       "C", 0, 0,    (APTR)MEN_SETC4      },
    { NM_ITEM,    "MUI",             "M", 0, 0,    (APTR)MEN_SETMUI     },
    { NM_ITEM,    "Load",            "L", 0, 0,    (APTR)MEN_SETLOAD    },
    { NM_ITEM,    "Save",            "S", 0, 0,    (APTR)MEN_SETSAVE    },
    { NM_ITEM,    "Save as default", "D", 0, 0,    (APTR)MEN_SETDEFAULT },

    { NM_END,NULL, 0, 0, 0, (APTR)0 }
};

STATIC CONST CONST_STRPTR Page_titles[] = { "Players", "Network", NULL };

STATIC CONST CONST_STRPTR cycle_playertype_strings[] = { "Local", "Remote", "Computer", NULL };

STATIC CONST CONST_STRPTR cycle_acceptnet_strings[] = { "from known players", "from everyone", NULL };

STATIC CONST CONST_STRPTR default_player_name[] = { "Player 1", "Player 2" };

/***********************************/
/***********************************/
/***********************************/

STATIC BOOL loadsettings(CONST_STRPTR filename)
{
    BPTR fp_in;
    LONG filelength;
    UBYTE *prefsfile, *prefsfilerover;
    static const char fileheader[]={19, 31, 30, 30, 21, 19, 36, 4}; // ASCII values of each char in "CONNECT4" minus 48

    // Attempt to load the user prefs (player and network details)
    if (fp_in=Open (filename, MODE_OLDFILE))
    {
        struct FileInfoBlock fib;

        ExamineFH(fp_in, &fib);

        filelength = fib.fib_Size;

        prefsfile=(UBYTE *)malloc(filelength); // reserve space in memory
                                               // for user prefs data
        FRead (fp_in, prefsfile, 1, filelength);
        Close (fp_in);
        prefsfilerover=prefsfile;

        DeletePool(prefspool);
        if (prefspool=(UBYTE *)CreatePool(MEMF_FAST, 2000, 2000))
        {
            if (filelength>8)
            {
                if (*prefsfilerover==fileheader[0])
                {
                    prefsfilerover++;
                    if (*prefsfilerover==fileheader[1])
                    {
                        prefsfilerover++;
                        if (*prefsfilerover==fileheader[2])
                        {
                            prefsfilerover++;
                            if (*prefsfilerover==fileheader[3])
                            {
                                prefsfilerover++;
                                if (*prefsfilerover==fileheader[4])
                                {
                                    prefsfilerover++;
                                    if (*prefsfilerover==fileheader[5])
                                    {
                                        prefsfilerover++;
                                        if (*prefsfilerover==fileheader[6])
                                        {
                                            prefsfilerover++;
                                            if (*prefsfilerover==fileheader[7])
                                            {
                                                ULONG i=0;

                                                prefsfilerover++;
                                                while (*prefsfilerover!=1 && i<MAXPABENTRIES)
                                                {
                                                    loaded_info[i]=AllocPooled(prefspool, sizeof(struct PAB_Entry));
                                                    loaded_info[i]->name=AllocPooled(prefspool, NAME_LEN);
                                                    loaded_info[i]->type=AllocPooled(prefspool, TYPE_LEN);
                                                    loaded_info[i]->detail=AllocPooled(prefspool, DETAIL_LEN);
                                                    strncpy(loaded_info[i]->name, prefsfilerover, NAME_LEN);
                                                    prefsfilerover+=strlen(prefsfilerover)+1;
                                                    strncpy(loaded_info[i]->type, prefsfilerover, TYPE_LEN);
                                                    prefsfilerover+=strlen(prefsfilerover)+1;
                                                    strncpy(loaded_info[i]->detail, prefsfilerover, DETAIL_LEN);
                                                    prefsfilerover+=strlen(prefsfilerover)+1;
                                                    i++;
                                                }
                                                loaded_info[i]=NULL;

                                                prefsfilerover++; // skip the section seperator
                                                strcpy (networkinfo.port, prefsfilerover);
                                                prefsfilerover+=strlen(prefsfilerover)+1;
                                                strcpy (networkinfo.username, prefsfilerover);

                                                free (prefsfile); // don't need the raw data anymore
                                                return TRUE;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // If we get this far it is not a Connect 4 preferences file
        }

        free (prefsfile);
    }

    return FALSE;     // Prefs file not found

}

/***********************************/
/***********************************/
/***********************************/

STATIC void savesettings (CONST_STRPTR filename, APTR playerlist, APTR netport, APTR netname)
{
    BPTR fp_out;
    static const char fileheader[]={19, 31, 30, 30, 21, 19, 36, 4}; // ASCII values of each char in "CONNECT4" minus 48
    const char section_separator[]={1};
    CONST_STRPTR stringptr;
    struct PAB_Entry *tempentryptr;

    if (fp_out=Open(filename, MODE_NEWFILE))
    {
        Write(fp_out, (APTR)&fileheader, 8);  // Write weird encoding of "CONNECT4" as file header
        // Get player details from the playerlist object
        {
            char i;

            for (i=0;;i++)
            {
                DoMethod(playerlist, MUIM_List_GetEntry, i, &tempentryptr);
                if (!tempentryptr)
                    break;

                FPuts(fp_out, tempentryptr->name);
                FPutC(fp_out, 0);
                FPuts(fp_out, tempentryptr->type);
                FPutC(fp_out, 0);
                FPuts(fp_out, tempentryptr->detail);
                FPutC(fp_out, 0);
            }
        }
        Flush(fp_out);  // Because we're moving from buffered to unbuffered I/O
        Write(fp_out, (APTR)&section_separator, 1);
        // Get the network details from the netport and netname objects
        get(netport, MUIA_String_Contents, &stringptr);
        FPuts(fp_out, stringptr);
        FPutC(fp_out, 0);
        get(netname, MUIA_String_Contents, &stringptr);
        FPuts(fp_out, stringptr);
        FPutC(fp_out, 0);
        Close(fp_out);
    }
}

/***********************************/
/***********************************/
/***********************************/

STATIC void problem_window (APTR app, CONST_STRPTR windowtitle, CONST_STRPTR errmsg)
{
    enum {okpressed=500};

    APTR problemwin=0,
         okbutton;
    TEXT formattederrmsg[100];
    LONG i;

    for (i=0; i<100; i++)
        formattederrmsg[i]=0;

    strcpy(formattederrmsg, MUIX_C);
    strcat(formattederrmsg, errmsg);

    problemwin = WindowObject,
        MUIA_Window_Title, windowtitle,
        MUIA_Window_ScreenTitle, "Connect 4",
        MUIA_Window_CloseGadget, FALSE,

        WindowContents,
            VGroup,
                MUIA_Background, MUII_SHINEBACK,
                Child, TextObject,
                    MUIA_Frame, MUIV_Frame_Text,
                    MUIA_Background, MUII_TextBack,
                    MUIA_Text_Contents, formattederrmsg,
                End,
                Child, HGroup,
                    Child, RectangleObject, End,
                    Child, okbutton = TextObject,
                             MUIA_Text_Contents, "OK",
                             MUIA_Text_SetMax, TRUE,
                             MUIA_Frame, MUIV_Frame_Button,
                             MUIA_InputMode, MUIV_InputMode_RelVerify,
                             MUIA_Background, MUII_ButtonBack,
                    End,
                    Child, RectangleObject, End,
                End,
            End,
    End;

    if (problemwin)
    {
        DoMethod(app, OM_ADDMEMBER, problemwin);
        DoMethod(okbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                 app, 2, MUIM_Application_ReturnID, okpressed);
        set(problemwin, MUIA_Window_Open, TRUE);

        {
            ULONG sigs = 0;

            while (DoMethod(app, MUIM_Application_NewInput, &sigs)!=okpressed)
            {
                if (sigs)
                    sigs = Wait(sigs);
            }
        }

        set(problemwin, MUIA_Window_Open, FALSE);
        DoMethod(app, OM_REMMEMBER, problemwin);
        MUI_DisposeObject(problemwin);
    }
}



/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS APTR PAB_constructor_function (struct Hook *hook, APTR pool, struct PAB_Entry *entry)
{
    struct PAB_Entry *entry_copy;
    
    if (entry_copy=AllocPooled(pool, sizeof(struct PAB_Entry)))
    {
        if (entry_copy->name=AllocPooled(pool, NAME_LEN))
        {
            if (entry_copy->type=AllocPooled(pool, TYPE_LEN))
            {
                if (entry_copy->detail=AllocPooled(pool, DETAIL_LEN))
                {
                    strcpy(entry_copy->name, entry->name);
                    strcpy(entry_copy->type, entry->type);
                    strcpy(entry_copy->detail, entry->detail);
                    return (entry_copy);
                }
                FreePooled(pool, entry_copy->type, TYPE_LEN);
            }
            FreePooled(pool, entry_copy->name, NAME_LEN);
        }
        FreePooled(pool, entry_copy, sizeof(struct PAB_Entry));
    }
    return NULL;
}

// Player Address Book list constructor hook
static struct Hook PAB_constructor_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)&PAB_constructor_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void PAB_destructor_function (struct Hook *hook, APTR pool, struct PAB_Entry *entry)
{
    FreePooled(pool, entry->name, NAME_LEN);
    FreePooled(pool, entry->type, TYPE_LEN);
    FreePooled(pool, entry->detail, DETAIL_LEN);
    FreePooled(pool, entry, sizeof(struct PAB_Entry));
}

// Player Address Book list destructor hook
static struct Hook PAB_destructor_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)&PAB_destructor_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

// Player Address Book list display function
STATIC SAVEDS LONG PAB_display_function (struct Hook *hook, const char **array, struct PAB_Entry *entry)
{
      if (entry)
      {
          *array++=entry->name;
          *array++=entry->type;
          *array  =entry->detail;
      }
      else
      {
          *array++="Name";
          *array++="Type";
          *array  ="Detail";
      }

      return 0;
}

// Player Address Book list display hook
static struct Hook PAB_display_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)PAB_display_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

// Player Address Book list compare function
STATIC SAVEDS LONG PAB_compare_function (struct Hook *hook, struct PAB_Entry *entry1, struct PAB_Entry *entry2)
{
    return(strcmp(entry2->name, entry1->name));
}

// Player Address Book list compare hook
static struct Hook PAB_compare_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)PAB_compare_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void menu_save_function (struct Hook *hook, APTR obj, ULONG *data)
{
    APTR playerlist=(APTR)*data++;
    APTR netport=(APTR)*data++;
    APTR netname=(APTR)*data;
    struct TagItem frsavetags[] =
    {
        ASLFR_TitleText, (ULONG)"Save a prefs file...",
        ASLFR_DoSaveMode, TRUE,
        ASLFR_InitialHeight, (WORD)300,
        TAG_DONE
    };
    struct FileRequester *fr;   // ASL file requester

    fr=(struct FileRequester *)MUI_AllocAslRequest(ASL_FileRequest, frsavetags);

    if (!(MUI_AslRequest(fr, NULL)))
    {
        MUI_FreeAslRequest(fr);
    }
    else
    {
        savesettings(fr->fr_File, playerlist, netport, netname);
        MUI_FreeAslRequest(fr);
    }
}

static struct Hook menu_save_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)menu_save_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void menu_savedefault_function (struct Hook *hook, APTR obj, ULONG *data)
{
    APTR playerlist=(APTR)*data++;
    APTR netport=(APTR)*data++;
    APTR netname=(APTR)*data;

    savesettings("default.prefs", playerlist, netport, netname);
}

static struct Hook menu_savedefault_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)menu_savedefault_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void menu_load_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR app=(APTR)*data++;
    APTR playerlist=(APTR)*data++;
    APTR poplist1=(APTR)*data++;
    APTR poplist2=(APTR)*data++;
    APTR netport=(APTR)*data++;
    APTR netname=(APTR)*data;
    struct TagItem frloadtags[] =
    {
        ASLFR_TitleText, (ULONG)"Load a prefs file...",
        ASLFR_InitialHeight, (WORD)300,
        TAG_DONE
    };
    struct FileRequester *fr;   // ASL file requester

    fr=(struct FileRequester *)MUI_AllocAslRequest(ASL_FileRequest, frloadtags);
      
    if (!(MUI_AslRequest(fr, NULL)))
    {
        MUI_FreeAslRequest(fr);
    }
    else
    {
        // Copy network data from prefs file, if it exists
        if (loadsettings(fr->fr_File))
        {
            // Clear the list objects
            DoMethod(playerlist, MUIM_List_Clear);
            DoMethod(poplist1,   MUIM_List_Clear);
            DoMethod(poplist2,   MUIM_List_Clear);

            // Copy the player data
            DoMethod(playerlist, MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);
            DoMethod(poplist1,   MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);
            DoMethod(poplist2,   MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);

            // Copy the network data
            set(netport, MUIA_String_Contents, networkinfo.port);
            set(netname, MUIA_String_Contents, networkinfo.username);
        }
        else
            problem_window(app, "Error", "Unable to load preferences file");

        MUI_FreeAslRequest(fr);
    }
}

static struct Hook menu_load_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)menu_load_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void delete_player_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR playerlist=(APTR)*data++;
    APTR poplist1=(APTR)*data++;
    APTR poplist2=(APTR)*data;
    LONG pos;

    get(playerlist, MUIA_List_Active, &pos);
    if (pos!=MUIV_List_Active_Off)
    {
        DoMethod(playerlist, MUIM_List_Remove, pos);
        DoMethod(poplist1,   MUIM_List_Remove, pos);
        DoMethod(poplist2,   MUIM_List_Remove, pos);
    }
}   

static struct Hook delete_player_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)delete_player_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void menu_aboutmui_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR aboutmuiwin=(APTR)*data++;
    APTR mainwindow=(APTR)*data++;
    APTR app=(APTR)*data;

    if (!aboutmuiwin)
    {
       aboutmuiwin = AboutmuiObject,
          MUIA_Window_RefWindow, mainwindow,
          MUIA_Aboutmui_Application, app,
       End;
    }

    if (aboutmuiwin)
        set(aboutmuiwin,MUIA_Window_Open,TRUE);
    else
        DisplayBeep(0);
}

static struct Hook menu_aboutmui_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)menu_aboutmui_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void popchoice_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR poplist=(APTR)*data++;
    APTR name=(APTR)*data++;
    APTR pop=(APTR)*data;
    struct PAB_Entry *tempentryptr;

    // get entry name
    DoMethod(poplist, MUIM_List_GetEntry, MUIV_List_GetEntry_Active, &tempentryptr);
    // copy entry name to name string gadget
    set(name, MUIA_String_Contents, tempentryptr->name);
    // close PopListview
    DoMethod(pop, MUIM_Popstring_Close, TRUE);
}

static struct Hook popchoice_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)popchoice_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void existing_player_edit_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR settingswin=(APTR)*data++;
    APTR playerlist=(APTR)*data++;
    APTR pew_name=(APTR)*data++;
    APTR pew_detail=(APTR)*data++;
    APTR pew_cycle=(APTR)*data++;
    APTR playereditwin=(APTR)*data;
    struct PAB_Entry *tempentryptr;

    // Put settings window to sleep
    set(settingswin, MUIA_Window_Sleep, TRUE);

    // Get the details of the item the user double clicked on
    DoMethod(playerlist, MUIM_List_GetEntry, MUIV_List_GetEntry_Active, &tempentryptr);

    // Copy them over to the existing details edit window
    set(pew_name, MUIA_String_Contents, tempentryptr->name);

    if (strcmp(tempentryptr->type, cycle_playertype_strings[1])==0) // Remote
    {
        set(pew_cycle, MUIA_Cycle_Active, 1);
        set(pew_detail, MUIA_String_Contents, tempentryptr->detail);
    }
    else if (strcmp(tempentryptr->type, cycle_playertype_strings[2])==0) // Computer
    {
        set(pew_cycle, MUIA_Cycle_Active, 2);
        set(pew_detail, MUIA_String_Contents, tempentryptr->detail);
    }
    else // Local
    {
        set(pew_cycle, MUIA_Cycle_Active, 0);
        set(pew_detail, MUIA_String_Contents, "");
        set(pew_detail, MUIA_Disabled, TRUE);
    }

    // Open the existing details editor window
    set(playereditwin, MUIA_Window_Open, TRUE);
}

static struct Hook existing_player_edit_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)existing_player_edit_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void reset_values_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR playerlist=(APTR)*data++;
    APTR pew_name=(APTR)*data++;
    APTR pew_detail=(APTR)*data++;
    APTR pew_cycle=(APTR)*data;
    struct PAB_Entry *tempentryptr;

    // Get the details of the item the user double clicked on
    DoMethod(playerlist, MUIM_List_GetEntry, MUIV_List_GetEntry_Active, &tempentryptr);

    set(pew_name, MUIA_String_Contents, tempentryptr->name);

    if (strcmp(tempentryptr->type, cycle_playertype_strings[1])==0)
    {
        set(pew_cycle, MUIA_Cycle_Active, 1);
        set(pew_detail, MUIA_String_Contents, tempentryptr->detail);
    }
    else if (strcmp(tempentryptr->type, cycle_playertype_strings[2])==0)
    {
        set(pew_cycle, MUIA_Cycle_Active, 2);
        set(pew_detail, MUIA_String_Contents, tempentryptr->detail);
    }
    else
    {
        set(pew_cycle, MUIA_Cycle_Active, 0);
        set(pew_detail, MUIA_String_Contents, "");
        set(pew_detail, MUIA_Disabled, TRUE);
    }
}  

static struct Hook reset_values_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)reset_values_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void commit_player_function (struct Hook *hook, APTR obj, APTR *data)
{
    UBYTE *temppool=(UBYTE *)*data++;
    APTR pew_name=(APTR)*data++;
    APTR pew_detail=(APTR)*data++;
    APTR pew_cycle=(APTR)*data++;
    APTR playerlist=(APTR)*data++;
    APTR poplist1=(APTR)*data++;
    APTR poplist2=(APTR)*data++;
    APTR playereditwin=(APTR)*data++;
    APTR settingswin=(APTR)*data++;
    BOOL changeexistingplayer=(BOOL)*data;
    LONG selectedpos, cyclestate;
    struct PAB_Entry *tempentry;    // For space to hold struct PAB_Entry ->name and ->type pointers
                                    // (only the pointers!! - not the space for the strings!)

    tempentry=AllocPooled(temppool, sizeof(struct PAB_Entry));
    
    if (changeexistingplayer)
    {
        // Remove current entry from list
        get(playerlist, MUIA_List_Active, &selectedpos);
        if (selectedpos!=MUIV_List_Active_Off)
        {
            DoMethod(playerlist, MUIM_List_Remove, selectedpos);
            DoMethod(poplist1,   MUIM_List_Remove, selectedpos);
            DoMethod(poplist2,   MUIM_List_Remove, selectedpos);
        }
    }

    // Get new values from string gadgets
    get(pew_name, MUIA_String_Contents, &tempentry->name);
    get(pew_cycle, MUIA_Cycle_Active, &cyclestate);
    tempentry->type=AllocPooled(temppool, TYPE_LEN);
    strcpy(tempentry->type, cycle_playertype_strings[cyclestate]);

    switch (cyclestate)
    {
        case 0:
            tempentry->detail=AllocPooled(temppool, DETAIL_LEN);
            strcpy(tempentry->detail, "");
            // copy them to the main player list and poplists
            if (tempentry->name[0]!=0)
            {
                DoMethod(playerlist, MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
                DoMethod(poplist1,   MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
                DoMethod(poplist2,   MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
            }
            FreePooled(temppool, tempentry->detail, DETAIL_LEN);
            break;

        case 1:
        case 2:
            get(pew_detail, MUIA_String_Contents, &tempentry->detail);
            // copy them to the main player list and poplists
            if (tempentry->name[0]!=0)
            {
                DoMethod(playerlist, MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
                DoMethod(poplist1,   MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
                DoMethod(poplist2,   MUIM_List_InsertSingle, tempentry, MUIV_List_Insert_Sorted);
            }
            break;
        
    }

    FreePooled(temppool, tempentry->type, TYPE_LEN);

    // close the edit window and awaken the settings window
    set(playereditwin, MUIA_Window_Open, FALSE);
    set(settingswin, MUIA_Window_Sleep, FALSE);

    FreePooled(temppool, tempentry, sizeof(struct PAB_Entry));
}

static struct Hook commit_player_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)commit_player_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void winner_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR winning_player=(APTR)*data++;
    APTR winnerwin=(APTR)*data++;
    APTR ply1name=(APTR)*data++;
    APTR ply2name=(APTR)*data++;
    APTR winnertext=(APTR)*data++;
    APTR board=(APTR)*data++;
    APTR mainwindow=(APTR)*data;
    const char *playername;
    UBYTE formattedname[40], i;

    for (i=0; i<40; i++)
        formattedname[i]=0;

    strcpy(formattedname, MUIX_C);

    set(board, MUIA_Gameboard_Inputactive, FALSE);
    set(mainwindow, MUIA_Window_Sleep, TRUE);

    if (winning_player==red_player)
    {
        get(ply1name, MUIA_Text_Contents, &playername);
        strcat(formattedname, playername);
        strcat(formattedname, "\n(red)");
    }
    else
    {
        get(ply2name, MUIA_Text_Contents, &playername);
        strcat(formattedname, playername);
        strcat(formattedname, "\n(yellow)");
    }

    set(winnertext, MUIA_Text_Contents, formattedname);
    set(winnerwin, MUIA_Window_Open, TRUE);
}

static struct Hook winner_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)winner_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void problem_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR app=(APTR)*data++;
    char *windowtitle=(APTR)*data++;
    char *errmsg=(APTR)*data;

    problem_window(app, windowtitle, errmsg);
}

static struct Hook problem_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)problem_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void react_move_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR board=(APTR)*data;
    ULONG player, playertype;
    
    get(board, MUIA_Gameboard_CurrentPlayer, &player);
    
    if (player==red_player)
        get(board, MUIA_Gameboard_RedPlayer, &playertype);
    else
        get(board, MUIA_Gameboard_YellowPlayer, &playertype);
    
    switch (playertype)
    {
        case PlayerType_Local:
            set(board, MUIA_Gameboard_Inputactive, TRUE);
            break;

        case PlayerType_Computer:
            set(board, MUIA_Gameboard_Inputactive, FALSE);
            DoMethod(board, MUIM_Gameboard_MakeMove);
            break;

    }
    
}

static struct Hook react_move_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)react_move_function,
    NULL
};

/***********************************/
/***********************************/
/***********************************/

STATIC SAVEDS void start_game_function (struct Hook *hook, APTR obj, APTR *data)
{
    APTR name1=(APTR)*data++;
    APTR name2=(APTR)*data++;
    APTR ply1name=(APTR)*data++;
    APTR ply2name=(APTR)*data++;
    APTR poplist1=(APTR)*data++;
    APTR poplist2=(APTR)*data++;
    APTR board=(APTR)*data;
    CONST_STRPTR nameptr;
    LONG activepos;

    // Copy names to main window, filling in blank names if appropriate
    get(name1, MUIA_String_Contents, &nameptr);
    if (nameptr[0]==0)
        set(name1, MUIA_String_Contents, default_player_name[red_player]);
    set(ply1name, MUIA_Text_Contents, nameptr);

    get(name2, MUIA_String_Contents, &nameptr);
    if (nameptr[0]==0)
        set(name2, MUIA_String_Contents, default_player_name[yellow_player]);
    set(ply2name, MUIA_Text_Contents, nameptr);

    // find out what type each player is, and tell the gameboard
    get(poplist1, MUIA_List_Active, &activepos);
    if (activepos==MUIV_List_Active_Off)
    {
        // must be something the user typed into the string gadget, and hence Local
        set(board, MUIA_Gameboard_RedPlayer, PlayerType_Local);
    }
    else
    {
        // the user has highlighted something on the list - this may or may not match
        // the contents of the string gadget, and may or may not have been highlighted
        // by a doubleclick (it is possible to select an entry, and then exit the list
        // from the dropdown button without initiating the doubleclick-activated name
        // copying routine
        struct PAB_Entry *entry;
        DoMethod(poplist1, MUIM_List_GetEntry, activepos, &entry);
        get(name1, MUIA_String_Contents, &nameptr);
        if (strcmp(nameptr, entry->name)==0)
        {
            if (strcmp(entry->type, cycle_playertype_strings[2])==0) // computer player
            {
                set(board, MUIA_Gameboard_RedPlayer, PlayerType_Computer);
                set(board, MUIA_Gameboard_RedDetail, atoi(entry->detail));
            }
            else if (strcmp(entry->type, cycle_playertype_strings[0])==0) // local player
            {
                set(board, MUIA_Gameboard_RedPlayer, PlayerType_Local);
            }
            else // remote player - handle like local for now...
            {
                set(board, MUIA_Gameboard_RedPlayer, PlayerType_Local);
            }
        }
        else    // names didn't match, so assume the user chose something, then decided to type
        {       // a name in instead
            set(board, MUIA_Gameboard_RedPlayer, PlayerType_Local);
        }
    }

    get(poplist2, MUIA_List_Active, &activepos);
    if (activepos==MUIV_List_Active_Off)
    {
        // must be something the user typed into the string gadget, and hence Local
        set(board, MUIA_Gameboard_YellowPlayer, PlayerType_Local);
    }
    else
    {
        // the user has highlighted something on the list - this may or may not match
        // the contents of the string gadget, and may or may not have been highlighted
        // by a doubleclick (it is possible to select an entry, and then exit the list
        // from the dropdown button without initiating the doubleclick-activated name
        // copying routine
        struct PAB_Entry *entry;
        DoMethod(poplist2, MUIM_List_GetEntry, activepos, &entry);
        get(name2, MUIA_String_Contents, &nameptr);
        if (strcmp(nameptr, entry->name)==0)
        {
            if (strcmp(entry->type, cycle_playertype_strings[2])==0) // computer player
            {
                set(board, MUIA_Gameboard_YellowPlayer, PlayerType_Computer);
                set(board, MUIA_Gameboard_YellowDetail, atoi(entry->detail));
            }
            else if (strcmp(entry->type, cycle_playertype_strings[0])==0) // local player
            {
                set(board, MUIA_Gameboard_YellowPlayer, PlayerType_Local);
            }
            else // remote player - handle like local for now...
            {
                set(board, MUIA_Gameboard_YellowPlayer, PlayerType_Local);
            }
        }
        else    // names didn't match, so assume the user chose something, then decided to type
        {       // a name in instead
            set(board, MUIA_Gameboard_YellowPlayer, PlayerType_Local);
        }
    }
    
    // Re-seed the computer player for this go...
    computer_player(0, NULL, NULL, 0, TRUE);

    // Get things going with this call. This allows any type of player to go first,
    // instead of hardwiring the code to be always human going first
    DoMethod(board, MUIM_CallHook, &react_move_hook, board);
}

static struct Hook start_game_hook =
{
    {NULL, NULL},
    (HOOKFUNC)&HookEntry,
    (void *)&start_game_function,
    NULL
};



/***********************************/
/***********************************/
/***********************************/

/*
SAVEDS void _function (REG(a0, struct Hook *hook),
                       REG(a2, Object *obj),
                       REG(a1, APTR *data))
{
    APTR =(APTR)*data++;
    APTR =(APTR)*data++;
    APTR =(APTR)*data;





}

static struct Hook _hook =
{
    {NULL, NULL},
    (void *)_function,
    NULL, NULL
};
*/



/***********************************/
/***********************************/
/***********************************/

STATIC void connect4 (struct MUI_CustomClass *gameboardmcc, UBYTE *temppool)
{
    APTR app,              // main application pointer
         mainwindow,       // the main window
         board,            // game board
         redlamp,          // red lamp for the red player
         yellowlamp,       // yellow lamp for the yellow player
         lagometer,        // network lag indicator
         strip,            // menu strip
         ply1name,         // player 1 name - uneditable!
         ply2name,         // player 2 name - uneditable!

         aboutc4win,       // pointer to Project=>About=>Connect 4 window
         ac4w_ok,          // OK button in Project=>About=>Connect 4 window

         aboutmuiwin=0,    // pointer to Project=>About=>MUI window

         settingswin,      // pointer to game settings window
         netacceptcycle,   // cycle gadget to set which game requests to accept
         netport,          // network port string
         netname,          // network user name
         addbutton,        // add player button - opens player input window
         deletebutton,     // delete player button
         clearbutton,      // clear list button
         playerlistview,   // listview for player list
         playerlist,       // this list is used to control the data

         playerinputwin,   // pointer player details input window
         piw_name,         // player name string - default=""
         piw_detail,       // player type string - default=""
         piw_cycle,        // player type cycle gadget
         piw_okbutton,     // OK button
         piw_cancelbutton, // Cancel button

         playereditwin,    // player edit window
         pew_name,         // player name string
         pew_detail,       // player type string
         pew_cycle,        // player type cycle gadget
         pew_okbutton,     // OK button
         pew_cancelbutton, // Cancel button
         pew_resetbutton,  // Reset button - resets to pre-edit value

         winnerwin,        // Winner's window
         winw_ok,          // OK button in Winner's window
         winnertext,       // the name of the winner

         gametiedwin,      // Window displayed when neither player wins
         gtw_ok,           // OK button

         newgamewin,       // window to start a new game
         startbutton,      // starts a game
         pop1, pop2,       // buttons to access known player list
         poplistview1,     // pointer to first PopListview
         poplistview2,     // pointer to second PopListview
         poplist1,         // pointer to first PopList
         poplist2,         // pointer to second PopList
         name1, name2,     // the two competitors

         wedontusethislastoneatall;

    UBYTE *gb_body;
    ULONG gb_width, gb_height, gb_colourdepth, gb_compression;
    ULONG *gb_colours;
    struct DiskObject *myicon=NULL;

    if (loadiff("PROGDIR:gfx/gameboard", &gb_width, &gb_height, &gb_colourdepth, &gb_compression, &gb_body, &gb_colours))
    {

        // Create the MUI application
        app = ApplicationObject,
           MUIA_Application_Title      , "Connect 4",
           MUIA_Application_Version    , "$VER: v0.5 (28.12.01)",
           MUIA_Application_Copyright  , "©2000-2001, Giles Burdett",
           MUIA_Application_Author     , "Giles Burdett",
           MUIA_Application_Description, "Connect 4 game with AI and network play",
           MUIA_Application_Base       , "CONNECT4",

           #include "window/mainwindow.c"
           #include "window/aboutc4win.c"
           #include "window/settingswin.c"
           #include "window/playerinputwin.c"
           #include "window/playereditwin.c"
           #include "window/winnerwin.c"
           #include "window/gametiedwin.c"
           #include "window/newgamewin.c"

        End;

        if (app)
        {
            if (myicon=GetDiskObject("PROGDIR:Connect4"))
                set(app, MUIA_Application_DiskObject, myicon);

            if (loadsettings("default.prefs"))
            {
                // Clear the list objects
                DoMethod(playerlist, MUIM_List_Clear);
                DoMethod(poplist1,   MUIM_List_Clear);
                DoMethod(poplist2,   MUIM_List_Clear);

                // Copy the player data
                DoMethod(playerlist, MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);
                DoMethod(poplist1,   MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);
                DoMethod(poplist2,   MUIM_List_Insert, loaded_info, -1, MUIV_List_Insert_Sorted);

                // Copy the network data
                set(netport, MUIA_String_Contents, networkinfo.port);
                set(netname, MUIA_String_Contents, networkinfo.username);
            }

            /*****************
            ** Menus
            *****************/
                // Enable Project=>New game
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_NEWGAME,
                         newgamewin, 3, MUIM_Set, MUIA_Window_Open, TRUE);

                // Enable Project=>About=>Connect 4...
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_CONNECT4,
                         aboutc4win, 3, MUIM_Set, MUIA_Window_Open, TRUE);

                // Enable Project=>About=>MUI (opens MUI's inbuilt "About MUI" window)
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_ABOUTMUI,
                         app, 5, MUIM_CallHook, &menu_aboutmui_hook, aboutmuiwin, mainwindow, app);

                // Enable Project=>Iconify
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_ICONIFY,
                         app, 3, MUIM_Set, MUIA_Application_Iconified, TRUE);

                // Enable Project=>Quit
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_QUIT,
                         app, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

                // Enable Settings=>Connect 4...
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETC4,
                         settingswin, 3, MUIM_Set, MUIA_Window_Open, TRUE);

                // Enable Settings=>MUI
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETMUI,
                         app, 2, MUIM_Application_OpenConfigWindow, 0);

                // Enable Settings=>Load
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETLOAD,
                         app, 7, MUIM_CallHook, &menu_load_hook, app, playerlist, poplist1, poplist2, netport, netname);

                // Enable Settings=>Save
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETSAVE,
                         app, 5, MUIM_CallHook, &menu_save_hook, playerlist, netport, netname);

                // Enable Settings=>Save as default
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETDEFAULT,
                         app, 5, MUIM_CallHook, &menu_savedefault_hook, playerlist, netport, netname);

            /*****************
            ** Main window
            *****************/
                // Enable main close gadget
                DoMethod(mainwindow, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                         app, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

                // Make lamps indicate red player's turn
                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, red_player,
                         redlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, red_player,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0L);

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, red_player,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Green, 0L);

                // Make lamps indicate yellow player's turn
                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, yellow_player,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, yellow_player,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Green, 0xFFFFFFFF);

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, yellow_player,
                         redlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0L);

                // React to player moves
                DoMethod(board, MUIM_Notify, MUIA_Gameboard_CurrentPlayer, MUIV_EveryTime,     
                         app, 3, MUIM_CallHook, &react_move_hook, board);


            /***************
            ** New Game window
            ***************/
                // Detect name selection from poplists with double click
                DoMethod(poplistview1, MUIM_Notify, MUIA_Listview_DoubleClick, TRUE,
                         app, 5, MUIM_CallHook, &popchoice_hook, poplist1, name1, pop1);

                DoMethod(poplistview2, MUIM_Notify, MUIA_Listview_DoubleClick, TRUE,
                         app, 5, MUIM_CallHook, &popchoice_hook, poplist2, name2, pop2);

                // Start button
                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         redlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0L);

                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Green, 0L);

                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         startbutton, 3, MUIM_Set, MUIA_Disabled, TRUE);

                // Disable New Game menu option on Start
                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         DoMethod(strip, MUIM_FindUData, MEN_NEWGAME), 3, MUIM_Set, MUIA_Menuitem_Enabled, FALSE);

                // Close this window when the player wants to start the game
                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         newgamewin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                // If someone's name is left blank, fill it with "Player 1" or "Player 2"
                // and copy the chosen names to the main window text objects
                DoMethod(startbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                         app, 9, MUIM_CallHook, &start_game_hook, name1, name2,
                                 ply1name, ply2name, poplist1, poplist2, board);

             /*************************
             ** Winner's window
             *************************/
                DoMethod(board, MUIM_Notify, MUIA_Gameboard_Winner, MUIV_EveryTime,
                         app, 9, MUIM_CallHook, &winner_hook, MUIV_TriggerValue,
                                 winnerwin, ply1name, ply2name, winnertext, board, mainwindow);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         winnerwin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         startbutton, 3, MUIM_Set, MUIA_Disabled, FALSE);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         redlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Green, 0xFFFFFFFF);

                // Enable New Game menu option on winw_ok
                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         DoMethod(strip, MUIM_FindUData, MEN_NEWGAME), 3, MUIM_Set, MUIA_Menuitem_Enabled, TRUE);

                DoMethod(winw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         board, 3, MUIM_Set, MUIA_Gameboard_Restart, TRUE);

             /****************************
             ** Game tied window
             ****************************/

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_Tiegame, MUIV_EveryTime,
                         gametiedwin, 3, MUIM_Set, MUIA_Window_Open, TRUE);

                DoMethod(board, MUIM_Notify, MUIA_Gameboard_Tiegame, MUIV_EveryTime,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, TRUE);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         gametiedwin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         startbutton, 3, MUIM_Set, MUIA_Disabled, FALSE);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         redlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Red, 0xFFFFFFFF);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         yellowlamp, 3, MUIM_Set, MUIA_Lamp_Green, 0xFFFFFFFF);

                // Enable New Game menu option on gtw_ok
                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         DoMethod(strip, MUIM_FindUData, MEN_NEWGAME), 3, MUIM_Set, MUIA_Menuitem_Enabled, TRUE);

                DoMethod(gtw_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         board, 3, MUIM_Set, MUIA_Gameboard_Restart, TRUE);

             /******************************
             ** About=>Connect 4 window
             ******************************/
                // Disable the main window
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_CONNECT4,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, TRUE);

                // Enable OK button
                DoMethod(ac4w_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         aboutc4win, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                // ...and awaken the main window when close gadget used
                DoMethod(ac4w_ok, MUIM_Notify, MUIA_Pressed, FALSE,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

             /*********************************
             ** Connect 4 settings  window
             *********************************/
                // Disable the main window
                DoMethod(app, MUIM_Notify, MUIA_Application_MenuAction, MEN_SETC4,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, TRUE);

                // Enable close gadget
                DoMethod(settingswin, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                         settingswin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                // ...and awaken the main window when close gadget used
                DoMethod(settingswin, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                         mainwindow, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

                // Enable double click editing in the player list view
                DoMethod(playerlistview, MUIM_Notify, MUIA_Listview_DoubleClick, TRUE,
                         app, 8, MUIM_CallHook, &existing_player_edit_hook,
                                 settingswin, playerlist, pew_name, pew_detail,
                                 pew_cycle, playereditwin);

                /****************************************************
                ** Player address book new player details window
                ****************************************************/
                    // Display the player details window when selected from add button
                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             playerinputwin, 3, MUIM_Set, MUIA_Window_Open, TRUE);
                    // ...and disable the main window
                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             settingswin, 3, MUIM_Set, MUIA_Window_Sleep, TRUE);

                    // Set the name, cycle and type gadgets to default values
                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             piw_name, 3, MUIM_Set, MUIA_String_Contents, "");

                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             piw_cycle, 3, MUIM_Set, MUIA_Cycle_Active, 0 /*Local*/);

                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             piw_detail, 3, MUIM_Set, MUIA_String_Contents, "");

                    // Disable the piw_detail string because piw_cycle is set to Local
                    DoMethod(addbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             piw_detail, 3, MUIM_Set, MUIA_Disabled, TRUE);

                    // When piw_cycle is Remote, enable piw_detail string gadget
                    DoMethod(piw_cycle, MUIM_Notify, MUIA_Cycle_Active, 1 /*Remote*/,
                             piw_detail, 3, MUIM_Set, MUIA_Disabled, FALSE);

                    // When piw_cycle is Local, disable piw_detail string gadget
                    DoMethod(piw_cycle, MUIM_Notify, MUIA_Cycle_Active, 0 /*Local*/,
                             piw_detail, 3, MUIM_Set, MUIA_Disabled, TRUE);

                    // When piw_cycle is Computer, enable piw_detail string gadget
                    DoMethod(piw_cycle, MUIM_Notify, MUIA_Cycle_Active, 2 /*Computer*/,
                             piw_detail, 3, MUIM_Set, MUIA_Disabled, FALSE);

                    // Enable the clear list button...
                    DoMethod(clearbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             playerlist, 1, MUIM_List_Clear);

                    // ...and propagate the clear command to the poplists
                    DoMethod(clearbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             poplist1, 1, MUIM_List_Clear);

                    DoMethod(clearbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             poplist2, 1, MUIM_List_Clear);

                    // Enable Delete button...
                    DoMethod(deletebutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             app, 5, MUIM_CallHook, &delete_player_hook, playerlist, poplist1, poplist2);

                    // Enable PIW Cancel button...
                    DoMethod(piw_cancelbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             playerinputwin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                    // ...and awaken the settings window when cancel button used
                    DoMethod(piw_cancelbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             settingswin, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

                    // Enable PIW OK button...
                    DoMethod(piw_okbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             app, 12, MUIM_CallHook, &commit_player_hook, temppool, piw_name, piw_detail,
                                      piw_cycle, playerlist, poplist1, poplist2, playerinputwin, settingswin, FALSE);

                /************************************
                ** Existing details edit window
                ************************************/
                    // When pew_cycle is Remote, enable pew_detail string gadget
                    DoMethod(pew_cycle, MUIM_Notify, MUIA_Cycle_Active, 1 /*Remote*/,
                             pew_detail, 3, MUIM_Set, MUIA_Disabled, FALSE);

                    // When pew_cycle is Local, disable pew_detail string gadget
                    DoMethod(pew_cycle, MUIM_Notify, MUIA_Cycle_Active, 0 /*Local*/,
                             pew_detail, 3, MUIM_Set, MUIA_Disabled, TRUE);

                    // When pew_cycle is Computer, enable pew_detail string gadget
                    DoMethod(pew_cycle, MUIM_Notify, MUIA_Cycle_Active, 2 /*Computer*/,
                             pew_detail, 3, MUIM_Set, MUIA_Disabled, FALSE);

                    // Enable OK button
                    DoMethod(pew_okbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             app, 12, MUIM_CallHook, &commit_player_hook, temppool, pew_name, pew_detail, pew_cycle,
                                      playerlist, poplist1, poplist2,  playereditwin, settingswin, TRUE);

                    // Enable Reset button
                    DoMethod(pew_resetbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             app, 6, MUIM_CallHook, &reset_values_hook, playerlist,
                                     pew_name, pew_detail, pew_cycle);

                    // Enable Cancel button (close the edit window and awaken the settings window)
                    DoMethod(pew_cancelbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             playereditwin, 3, MUIM_Set, MUIA_Window_Open, FALSE);

                    DoMethod(pew_cancelbutton, MUIM_Notify, MUIA_Pressed, FALSE,
                             settingswin, 3, MUIM_Set, MUIA_Window_Sleep, FALSE);

                /****************************
                ** Network settings panel
                ****************************/
                    DoMethod(netacceptcycle, MUIM_Notify, MUIA_Cycle_Active, MUIV_EveryTime,
                             app, 5, MUIM_CallHook, &problem_hook, app, "Sorry", "This setting has not been implemented yet");





            // This displays the GUI we have created
            set(mainwindow, MUIA_Window_Open, TRUE);
            set(newgamewin, MUIA_Window_Open, TRUE);

            // Main loop
            {
                ULONG sigs = 0;

                while (DoMethod(app, MUIM_Application_NewInput, &sigs)!=MUIV_Application_ReturnID_Quit)
                {
                    if (sigs)
                    {
                        sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                        if (sigs & SIGBREAKF_CTRL_C) break;
                    }
                }
            }

            /* This hides the GUI before we remove it from the system */
            set(newgamewin, MUIA_Window_Open, FALSE);
            set(mainwindow, MUIA_Window_Open, FALSE);

            if (myicon)
                FreeDiskObject(myicon);

            MUI_DisposeObject(app);
        }

        free(gb_body);
        free(gb_colours);
    }
}


/***********************************/
/***********************************/
/***********************************/

int main (int argc, char **argv)
{
    if (AslBase=OpenLibrary("asl.library", 37L))
    {
        if (IFFParseBase=OpenLibrary("iffparse.library", 0L))
        {
            if (MUIMasterBase=OpenLibrary(MUIMASTER_NAME, MUIMASTER_VMIN))
            {
                // Make custom class
                struct MUI_CustomClass *gameboardmcc;
                if (gameboardmcc=MUI_CreateCustomClass(NULL, MUIC_Bodychunk, NULL, sizeof(struct gameboarddata), (APTR)&gameboardDispatcher))
                {
                    // Create memory pools
                    if (prefspool=(UBYTE *)CreatePool(MEMF_FAST, 2000, 2000))
                    {
                        UBYTE *temppool;
                        if (temppool=(UBYTE *)CreatePool(MEMF_FAST, 2000, 2000))
                        {
                            connect4(gameboardmcc, temppool);
                            DeletePool(temppool);
                        }
                        DeletePool(prefspool);
                    }
                    MUI_DeleteCustomClass(gameboardmcc);
                }
                CloseLibrary(MUIMasterBase);
            }
            CloseLibrary(IFFParseBase);
        }
        CloseLibrary(AslBase);
    }

    return 0;
}


