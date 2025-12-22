/*
    MUI custom class for mine field window
*/
#include "MUIMine.h"
#include "MFStrings.h"
#include "LevelData.h"
#include "MFWindow.h"
#include "BTWindow.h"
#include "LEWindow.h"
#include "MineField.h"
#include "FaceButton.h"
#include "Digits.h"


/*
    instance data
*/
struct MFWindowData
{
    struct NewMenu * NewMenus;  // NewMenu's for Menustrip
    Object * FaceButton;        // window's 'Start Game' button
    Object * MinesDisp;         // window's 'Mines Left' string
    Object * TimeDisp;          // window's 'Time Taken' string
    Object * MineField;         // window's minefield object
    Object * LevelMenu;         // Level menu
    struct LevelDataList Levels;// level info
    int      LastGameTime;      // time taken for the last succesfull game
    ULONG    LevelMenuCheck;    // id of checked level menu item
    Object * MUIAboutWindow;    // MUI about window object
    char  LastBestTimeName[BT_NAME_SIZE];   // last best time name entered
};


/*
    defines for difficulty levels
*/
#define DEFAULT_LEVEL       MUIV_MFWindow_Level_Beginner

#define MAX_NUM_LEVELS      30


/*
    global data items
*/

struct MUI_CustomClass *mccMineField  = NULL;
struct MUI_CustomClass *mccFaceButton = NULL;
struct MUI_CustomClass *mccDigits     = NULL;
struct MUI_CustomClass *mccBTWindow   = NULL;
struct MUI_CustomClass *mccLEWindow   = NULL;


/*
    window's menu data
*/

#define MENU_GAME           100
#define MENU_GAME_START     101
#define MENU_GAME_BESTTIMES 102
#define MENU_GAME_LEVELS    103
#define MENU_GAME_INFO      110
#define MENU_GAME_QUIT      199
#define MENU_LEVEL          200
#define MENU_LEVEL_BASE     201
#define MENU_MUI            300
#define MENU_MUI_ABOUT      301
#define MENU_MUI_SETTINGS   302


/*
    default NewMenus for MFWindowNewMenu
*/

struct NewMenu MFWindowNewMenu[] =
{
    {NM_TITLE, (STRPTR)MSG_MENUTITLE_GAME,          NULL, 0, 0, (APTR)MENU_GAME},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_GAMESTART,      NULL, 0, 0, (APTR)MENU_GAME_START},
    { NM_ITEM, NM_BARLABEL,                         NULL, 0, 0, NULL},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_GAMEBESTTIMES,  NULL, 0, 0, (APTR)MENU_GAME_BESTTIMES},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_GAMELEVELSETUP, NULL, 0, 0, (APTR)MENU_GAME_LEVELS},
    { NM_ITEM, NM_BARLABEL,                         NULL, 0, 0, NULL},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_GAMEINFO,       NULL, 0, 0, (APTR)MENU_GAME_INFO},
    { NM_ITEM, NM_BARLABEL,                         NULL, 0, 0, NULL},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_GAMEQUIT,       NULL, 0, 0, (APTR)MENU_GAME_QUIT},
    {NM_TITLE, (STRPTR)MSG_MENUTITLE_LEVEL,         NULL, 0, 0, (APTR)MENU_LEVEL},
    {NM_TITLE, (STRPTR)MSG_MENUTITLE_MUI,           NULL, 0, 0, (APTR)MENU_MUI},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_MUIABOUT,       NULL, 0, 0, (APTR)MENU_MUI_ABOUT},
    { NM_ITEM, (STRPTR)MSG_MENUITEM_MUISETTINGS,    NULL, 0, 0, (APTR)MENU_MUI_SETTINGS},
    {NM_END,   NULL,                                NULL, 0, 0, NULL}
};

/*
    level menu comm keys
*/
#define NUM_LEVEL_COMM_KEYS     10
STRPTR LevelCommKeys[] =
{
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
};



/*
    function prototypes
*/

static void SetLevel(Object * obj, struct MFWindowData * data, ULONG level);
static void CheckBestTime(Object * obj, struct MFWindowData * data);
static BOOL GetBestTimeName(Object * obj, struct LevelData * pLevel, int rank);
static void ShowBestTimes(Object * obj, struct LevelDataList * lList, int hiRank);
static void SetupLevels(Object *, struct MFWindowData * data);
static void ShowProgInfo(Object * obj);


/*
    function :    clears the existing Level menu by removing and disposing
                  of all the menu's items

    parameters :  data = pointer to the MFWindow data

    return :      none
*/
static void ClearLevelMenu(struct MFWindowData * data)
{
    /*
        make sure we have a Level menu to play with
    */
    if (data->LevelMenu)
    {
        int i;
        struct LevelData * pLevel = data->Levels.LevelList;

        for (i = data->Levels.NumLevels; i > 0; i--)
        {
            if (pLevel->MenuItem)
            {
                DoMethod(data->LevelMenu, MUIM_Family_Remove, pLevel->MenuItem);
                MUI_DisposeObject(pLevel->MenuItem);
                pLevel->MenuItem = NULL;
            }
            pLevel->MenuId = 0;
            pLevel++;
        }
    }
}

/*
    function :    builds the Level menu items from the LevelDataList and
                  add them to the LevelMenu

    parameters :  data = pointer to the MFWindow data

    return :      none
*/
static void BuildLevelMenu(struct MFWindowData * data)
{
    /*
        make sure we have a Level menu to play with
    */
    if (data->LevelMenu)
    {
        int i, n;
        ULONG menuId;
        ULONG mxBit;
        STRPTR commKey;
        struct LevelData * pLevel;

        /*
            make sure any existing Level menu items are removed
        */
        ClearLevelMenu(data);

        pLevel = data->Levels.LevelList;
        menuId = MENU_LEVEL_BASE;
        mxBit = 1;
        for (n = 0, i = data->Levels.NumLevels; i > 0  &&  n < MAX_NUM_LEVELS; i--)
        {
            commKey = (n < NUM_LEVEL_COMM_KEYS) ? LevelCommKeys[n] : NULL;

            pLevel->MenuItem = MUI_MakeObject(MUIO_Menuitem, pLevel->Name,
                                                commKey, CHECKIT, menuId);
            if (pLevel->MenuItem)
            {
                pLevel->MenuId = menuId;
                SetAttrs(pLevel->MenuItem,
                            MUIA_Menuitem_Exclude, (0x7FFFFFF & ~mxBit),
                            TAG_DONE);
                DoMethod(data->LevelMenu, MUIM_Family_AddTail, pLevel->MenuItem);

                n++;
                menuId++;
                mxBit = mxBit << 1;
            }

            pLevel++;
        }
    }
}


/*
    function :    create and initialize the NewMenu list for the window

    parameters :  none

    return :      pointer to the new menu structure
*/
struct NewMenu * CreateNewMenus(void)
{
    int i, n;
    struct NewMenu *nm, *pNewMenu;

    /*
        determine the number of NewMenu entries that need to be allocated
    */
    n = sizeof(MFWindowNewMenu) / sizeof(struct NewMenu);

    /*
        attempt to allocate the NewMenu array
    */
    if (!(nm = AllocVec(sizeof(struct NewMenu) * n, 0)))
    {
        return NULL;
    }

    /*
        build the standard menus from the MFWindowNewMenu array
    */
    for (pNewMenu = nm, i = 0; i < n; i++, pNewMenu++)
    {
        *pNewMenu = MFWindowNewMenu[i];

        if (pNewMenu->nm_Label != NM_BARLABEL  &&
            pNewMenu->nm_Type  != NM_END)
        {
            pNewMenu->nm_CommKey = GetStr((LONG)pNewMenu->nm_Label);
            pNewMenu->nm_Label = pNewMenu->nm_CommKey+2;

            if (pNewMenu->nm_CommKey[0] == ' ')
            {
                pNewMenu->nm_CommKey = NULL;
            }
        }
    }

    return nm;
}


/*
    function :    OM_NEW method handler for MFWindow class
*/
static ULONG mNew(struct IClass *cl, Object *obj, struct opSet *msg)
{
    ULONG level;
    struct MFWindowData *data;
    struct LevelDataList levels;
    struct LevelData * pLevel;
    struct NewMenu * nm;
    Object *minesdisp, *timedisp, *facebutt,
           *minefield, *strip, *levelmenu;

    /*
        initialize pointers to allocated data
    */
    strip = NULL;
    levelmenu = NULL;
    levels.NumLevels = 0;
    levels.CurrentLevel = 0;
    levels.Flags = 0;
    levels.LevelList = NULL;

    /*
        load the level data
    */
    LoadLevelData(&levels, NULL);

    /*
        create the menustrip for the window, do not fail if we fail to
        create the menustrip as we can live without it
    */
    nm = CreateNewMenus();
    if (nm)
    {
        strip = MUI_MakeObject(MUIO_MenustripNM, nm, 0);
        if (strip)
        {
            levelmenu = (APTR)DoMethod(strip, MUIM_FindUData, MENU_LEVEL);
        }
        else
        {
            FreeVec(nm);
            DisposeLevelData(&levels);
            nm = NULL;
        }
    }

    /*
        create the window object
    */
    obj = (Object *)DoSuperNew(cl, obj,
            MUIA_Window_Title, GetStr(MSG_MFWINDOW_TITLE),
            MUIA_Window_ID, MAKE_ID('M','I','N','E'),
            (strip) ? MUIA_Window_Menustrip : TAG_IGNORE, strip,
            WindowContents, VGroup,
                Child, HGroup,
                    GroupFrame,
                    Child, minesdisp = NewObject(mccDigits->mcc_Class, NULL,
                        TextFrame,
                        MUIA_InputMode, MUIV_InputMode_None,
                        MUIA_ShortHelp, GetStr(MSG_MINESLEFT_HELP),
                        TAG_DONE),

                    Child, HSpace(0),

                    Child, facebutt = NewObject(mccFaceButton->mcc_Class, NULL,
                        MUIA_InputMode, MUIV_InputMode_RelVerify,
                        MUIA_ShortHelp, GetStr(MSG_STARTBUTT_HELP),
                        TAG_DONE),

                    Child, HSpace(0),

                    Child, timedisp = NewObject(mccDigits->mcc_Class, NULL,
                        TextFrame,
                        MUIA_InputMode, MUIV_InputMode_None,
                        MUIA_ShortHelp, GetStr(MSG_TIMETAKEN_HELP),
                        TAG_DONE),
                    End,

                Child, minefield = NewObject(mccMineField->mcc_Class,NULL,
                    TextFrame,
                    TAG_DONE),
                End,

            TAG_MORE, msg->ops_AttrList);

    if (obj)
    {
        /*
            initialize instance data
        */
        data = INST_DATA(cl, obj);

        data->NewMenus = nm;
        data->MinesDisp = minesdisp;
        data->TimeDisp = timedisp;
        data->FaceButton = facebutt;
        data->MineField = minefield;
        data->LevelMenu = levelmenu;
        data->Levels = levels;
        data->MUIAboutWindow = NULL;
        data->LastBestTimeName[0] = 0;

        /*
           initialize level to none set
        */
        level = levels.CurrentLevel;
        data->LevelMenuCheck = 0;
        data->Levels.CurrentLevel = 0;

        /*
            build the level menu items
        */
        BuildLevelMenu(data);

        /*
            set the mine field difficulty level
        */
        pLevel = FindLevel(&data->Levels, level);
        level = (pLevel)
                    ? pLevel->Level
                    : (data->Levels.LevelList)
                        ? data->Levels.LevelList->Level
                        : DEFAULT_LEVEL;

        SetLevel(obj, data, level);

        /*
            setup notifications between the child objects
        */
        DoMethod(data->FaceButton, MUIM_Notify, MUIA_Pressed, FALSE,
                    data->MineField, 1, MUIM_MineField_Init);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_MinesLeft, MUIV_EveryTime,
                    data->MinesDisp, 3, MUIM_Set, MUIA_Digits_Number, MUIV_TriggerValue);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_GameWon, TRUE,
                    data->FaceButton, 3, MUIM_Set, MUIA_FaceButton_ImageIdx,
                                                    MUIV_FaceButton_ImageIdx_Good);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_GameWon, TRUE,
                    obj, 1, MUIM_MFWindow_CheckBestTime);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_GameLost, TRUE,
                    data->FaceButton, 3, MUIM_Set, MUIA_FaceButton_ImageIdx,
                                                    MUIV_FaceButton_ImageIdx_Bad);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_GameInitialized, TRUE,
                    data->FaceButton, 3, MUIM_Set, MUIA_FaceButton_ImageIdx,
                                                    MUIV_FaceButton_ImageIdx_Normal);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_LMBDown, TRUE,
                    data->FaceButton, 3, MUIM_Set, MUIA_FaceButton_ImageIdx,
                                                    MUIV_FaceButton_ImageIdx_Oh);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_LMBDown, FALSE,
                    data->FaceButton, 3, MUIM_Set, MUIA_FaceButton_ImageIdx,
                                                    MUIV_FaceButton_ImageIdx_Normal);

        DoMethod(data->MineField, MUIM_Notify, MUIA_MineField_TimeTaken, MUIV_EveryTime,
                    data->TimeDisp, 3, MUIM_Set, MUIA_Digits_Number, MUIV_TriggerValue);

    }
    else
    {
        /*
            super class could not be created, delete the new menu
            array if it was allocated and dispose of the level data
        */
        if (nm)
        {
            FreeVec((APTR)nm);
        }
        DisposeLevelData(&levels);
    }

    return (ULONG)obj;
}


/*
    function :    OM_DELETE method handler for MFWindow class
*/
static ULONG mDispose(struct IClass *cl, Object *obj, Msg msg)
{
    struct MFWindowData *data = INST_DATA(cl, obj);

    if (data->NewMenus)
    {
        FreeVec((APTR)data->NewMenus);
    }
    SaveLevelData(&data->Levels, NULL);
    DisposeLevelData(&data->Levels);

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    OM_SET method handler for MFWindow class
*/
static ULONG mSet(struct IClass *cl, Object *obj, struct opSet * msg)
{
    struct MFWindowData *data = INST_DATA(cl,obj);
    struct TagItem *tags, *tag;
    ULONG WinOpen = FALSE;
    ULONG ret;

    for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
    {
        switch (tag->ti_Tag)
        {
            case MUIA_MFWindow_Level:
            {
                SetLevel(obj, data, tag->ti_Data);
                break;
            }

            case MUIA_Window_Open:
            {
                WinOpen = tag->ti_Data;
                break;
            }

            case MUIA_Window_MenuAction:
            {
                switch (tag->ti_Data)
                {
                    case MENU_GAME_START:
                    {
                        DoMethod(data->MineField, MUIM_MineField_Init);
                        break;
                    }

                    case MENU_GAME_BESTTIMES:
                    {
                        ShowBestTimes(obj, &data->Levels, -1);
                        break;
                    }

                    case MENU_GAME_LEVELS:
                    {
                        SetupLevels(obj, data);
                        break;
                    }

                    case MENU_GAME_INFO:
                    {
                        ShowProgInfo(obj);
                        break;
                    }

                    case MENU_GAME_QUIT:
                    {
                        SetAttrs(obj, MUIA_Window_CloseRequest, TRUE, TAG_DONE);
                        break;
                    }

                    case MENU_MUI_ABOUT:
                    {
                        if (!data->MUIAboutWindow)
                        {
                            data->MUIAboutWindow = AboutmuiObject,
                                MUIA_Window_RefWindow, obj,
                                MUIA_Aboutmui_Application, _app(obj),
                                End;
                        }

                        if (data->MUIAboutWindow)
                        {
                            SetAttrs(data->MUIAboutWindow, MUIA_Window_Open, TRUE,
                                                           TAG_DONE);
                        }
                        break;
                    }

                    case MENU_MUI_SETTINGS:
                    {
                        DoMethod(_app(obj), MUIM_Application_OpenConfigWindow, 0);
                        break;
                    }

                    default:
                    {
                        struct LevelData * pLevel = FindMenuId(&data->Levels,
                                                                tag->ti_Data);
                        if (pLevel)
                        {
                            SetLevel(obj, data, pLevel->Level);
                        }
                        break;
                    }
                }
            }
        }
    }

    ret = DoSuperMethodA(cl, obj, (APTR)msg);

    /*
        if the window was opened then check that it did actually open
        and if it did not then display an error requester, set the
        current level to the default level (because the window may have
        failed to open because the mine field was too large for the
        screen) and exit the application
    */
    if (WinOpen)
    {
        DoMethod(obj, OM_GET, MUIA_Window_Open, &WinOpen);
        if (!WinOpen)
        {
            MUI_RequestA(_app(obj), NULL, 0, GetStr(MSG_MFWINDOW_TITLE),
                                             GetStr(MSG_EXIT_GADGET),
                                             GetStr(MSG_MFWINDOW_OPEN_ERR),
                                             NULL);
            data->Levels.CurrentLevel = DEFAULT_LEVEL;
            DoMethod(_app(obj), MUIM_Application_ReturnID,
                                MUIV_Application_ReturnID_Quit);
        }
    }

    return ret;
}

/*
    function :    OM_GET method handler for MFWindow class
*/
static ULONG mGet(struct IClass *cl, Object *obj, struct opGet * msg)
{
    struct MFWindowData *data = INST_DATA(cl, obj);
    ULONG *store = msg->opg_Storage;

    if (msg->opg_AttrID == MUIA_MFWindow_Level)
    {
        *store = (ULONG)data->Levels.CurrentLevel;
        return TRUE;
    }

    return DoSuperMethodA(cl, obj, (APTR)msg);
}

/*
    function :    MUIM_MFWindow_CheckBestTime method handler for MFWindow class
*/
static ULONG mCheckBestTime(struct IClass *cl, Object *obj, Msg msg)
{
    struct MFWindowData * data = INST_DATA(cl, obj);
    CheckBestTime(obj, data);
    return 0;
}

/*
    function :    class dispatcher
*/
SAVEDS ASM ULONG MFWindowDispatcher(
        REG(a0) struct IClass *cl,
        REG(a2) Object *obj,
        REG(a1) Msg msg)
{
    switch (msg->MethodID)
    {
        case OM_NEW:     return mNew    (cl, obj, (APTR)msg);
        case OM_DISPOSE: return mDispose(cl, obj, (APTR)msg);
        case OM_SET:     return mSet    (cl, obj, (APTR)msg);
        case OM_GET:     return mGet    (cl, obj, (APTR)msg);

        case MUIM_MFWindow_CheckBestTime:
            return mCheckBestTime(cl, obj, (APTR)msg);
    }

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    sets the difficulty level

    parameters :  obj = pointer to the MFWindow object
                  data = pointer to the MFWindow data
                  level = new difficulty level to set
*/
static void SetLevel(Object * obj, struct MFWindowData * data, ULONG level)
{
    static char WinTitle[64];

    /*
        check for non-NULL level and if the level has actually changed
    */
    if (level  &&  level != data->Levels.CurrentLevel)
    {
        struct LevelData * pLevel;
        ULONG opened = 0, menuid = 0;

        /*
            set the new level in the window data
        */
        data->Levels.CurrentLevel = level;

        /*
            detemine if this is a defined level and if it is then
            get the menu item for this level
        */
        pLevel = FindLevel(&data->Levels, level);
        if (pLevel)
        {
            menuid = pLevel->MenuId;
            sprintf(WinTitle, GetStr(MSG_MFWINDOW_TITLE_FMT), pLevel->Name);
        }
        else
        {
            strcpy(WinTitle, GetStr(MSG_MFWINDOW_TITLE));
        }

        /*
            check if the window is opened and if so close it
            to make the changes to mine field
        */
        DoMethod(obj, OM_GET, MUIA_Window_Open, &opened);
        if (opened)
        {
            SetAttrs(obj, MUIA_Window_Open, FALSE, TAG_DONE);
        }

        /*
            make the changes to the mine field
        */
        SetAttrs(data->MineField, MUIA_MineField_Width, LVL_WIDTH(level),
                                  MUIA_MineField_Height, LVL_HEIGHT(level),
                                  MUIA_MineField_NumMines, LVL_MINES(level),
                                  TAG_DONE);

        /*
            set window title for this level
        */
        SetAttrs(obj, MUIA_Window_Title, WinTitle, TAG_DONE);

        /*
            reopen the window if it was previously open
        */
        if (opened)
        {
            SetAttrs(obj, MUIA_Window_Open, TRUE, TAG_DONE);
        }

        /*
            if there is a menu item for the level then check it
            otherwise uncheck any checked level menu item
        */
        if (menuid)
        {
            DoMethod(obj, MUIM_Window_SetMenuCheck, menuid, TRUE);
            data->LevelMenuCheck = menuid;
        }
        else if (data->LevelMenuCheck)
        {
            DoMethod(obj, MUIM_Window_SetMenuCheck, data->LevelMenuCheck, FALSE);
            data->LevelMenuCheck = 0;
        }
    }
}

/*
    function :    checks the last game time for a best time for the
                  current difficulty level

    parameters :  obj = pointer to the MFWindow object
                  data = pointer to obj's MFWindowData

    return :      none
*/
static void CheckBestTime(Object * obj, struct MFWindowData * data)
{
    /*
        first check if the current level is a named level
    */
    struct LevelData * pLevel = FindCurrentLevel(&data->Levels);
    if (pLevel)
    {
        /*
            get the time taken from the minefield and make sure it is
            valid i.e. greater than zero
        */
        LONG lastTime = -1;
        DoMethod(data->MineField, OM_GET, MUIA_MineField_TimeTaken, &lastTime);
        if (lastTime > 0)
        {
            int i;
            struct BestTime * p;
            /*
                check if the last game's time is less than any of the
                three best times for the level
            */
            for (i = 0, p = pLevel->BestTimes; i < 3; i++, p++)
            {
                if (p->Time <= 0  ||  lastTime < p->Time)
                {
                    break;
                }
            }
            if (i < 3)
            {
                /*
                    we have a new best time, move the best time being
                    displaced and all later best times down one in the
                    list, instert the new best time and get the name of
                    the player
                */
                int j;
                for (j = 2; j > i; j--)
                {
                    pLevel->BestTimes[j] = pLevel->BestTimes[j - 1];
                }
                p->Time = lastTime;
                if (data->LastBestTimeName[0])
                {
                    strcpy(p->Name, data->LastBestTimeName);
                }
                GetBestTimeName(obj, pLevel, i);
                if (p->Name[0])
                {
                    strcpy(data->LastBestTimeName, p->Name);
                }
                /*
                    show the new best times
                */
                ShowBestTimes(obj, &data->Levels, i);
            } // new best time
        } // (lastTime > 0)
    } // (pLevel)
}




#define BTNW_Done   101

static BOOL GetBestTimeName(Object * obj, struct LevelData * pLevel, int rank)
{
    BOOL ret = FALSE;
    Object *win, *namestr, *okbutt;
    static char msgbuff[256];
    static LONG rankid[3] = {MSG_BESTTIME_RANK_1,
                             MSG_BESTTIME_RANK_2,
                             MSG_BESTTIME_RANK_3};

    /*
        format the message with the level's name
    */
    sprintf(msgbuff, GetStr(MSG_BESTTIME_FMT), GetStr(rankid[rank]), pLevel->Name);

    /*
        create the best time name window
    */
    win = WindowObject,
        MUIA_Window_Title, GetStr(MSG_BESTTIME_NAME_TITLE),
        MUIA_Window_RefWindow, obj,
        MUIA_Window_LeftEdge, MUIV_Window_LeftEdge_Centered,
        MUIA_Window_TopEdge, MUIV_Window_TopEdge_Centered,
        WindowContents, VGroup,
            Child, TextObject,
                TextFrame,
                MUIA_Background, MUII_TextBack,
                MUIA_Text_SetMax, TRUE,
                MUIA_Text_SetMin, TRUE,
                MUIA_Text_Contents, msgbuff,
                End,

            Child, namestr = StringObject,
                StringFrame,
                MUIA_CycleChain, 1,
                MUIA_String_MaxLen, BT_NAME_SIZE,
                MUIA_String_Contents, pLevel->BestTimes[rank].Name,
                End,

            Child, okbutt = TextObject,
                ButtonFrame,
                MUIA_Background, MUII_ButtonBack,
                MUIA_Text_PreParse, "\033c",
                MUIA_Text_Contents, GetStr(MSG_OKBUTT_TEXT),
                MUIA_ControlChar, '\r',
                MUIA_InputMode, MUIV_InputMode_RelVerify,
                End,

            End,
        End;

    /*
        check if window was successfully created
    */
    if (win)
    {
        ULONG sigs = 0;
        BOOL running = TRUE;
        Object * app = _app(obj);

        /*
            put parent window to sleep
        */
        SetAttrs(obj, MUIA_Window_Sleep, TRUE, TAG_DONE);
        /*
            add the best time name window to the application
        */
        DoMethod(app, OM_ADDMEMBER, win);
        /*
            setup notifications
        */
        DoMethod(win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                    app, 2, MUIM_Application_ReturnID, BTNW_Done);

        DoMethod(okbutt, MUIM_Notify, MUIA_Pressed, FALSE,
                    app, 2, MUIM_Application_ReturnID, BTNW_Done);

        DoMethod(namestr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_TriggerValue,
                    app, 2, MUIM_Application_ReturnID, BTNW_Done);

        /*
            open the best time name window
        */
        SetAttrs(win, MUIA_Window_Open, TRUE,
                      MUIA_Window_DefaultObject, okbutt,
                      MUIA_Window_ActiveObject, namestr,
                      TAG_DONE);

        /*
            enter the input loop
        */
        while (running)
        {
            switch (DoMethod(app, MUIM_Application_NewInput, &sigs))
            {
                case MUIV_Application_ReturnID_Quit:
                    /*
                        re-send the quit id so the main app loop can exit
                    */
                    DoMethod(app, MUIM_Application_ReturnID,
                                  MUIV_Application_ReturnID_Quit);
                    running = FALSE;
                    break;

                case BTNW_Done:
                    /*
                        user done with best time name window
                    */
                    ret = TRUE;
                    running = FALSE;
                    break;

                default:
                    if (sigs)
                    {
                        sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                        if (sigs & SIGBREAKF_CTRL_C)
                        {
                            DoMethod(app, MUIM_Application_ReturnID,
                                          MUIV_Application_ReturnID_Quit);
                            running = FALSE;
                        }
                    }
                break;
            }
        }

        /*
            close the window
        */
        SetAttrs(win, MUIA_Window_Open, FALSE, TAG_DONE);

        /*
            check if we left the input loop because the window was closed
            or because the application is terminating
        */
        if (ret)
        {
            /*
                the window closed normally so get the name from the
                window's name string and copy it to the LevelData
                and to the last best time name
            */
            STRPTR pName = NULL;

            DoMethod(namestr, OM_GET, MUIA_String_Contents, &pName);
            if (pName)
            {
                strcpy(pLevel->BestTimes[rank].Name, pName);
            }
        }

        /*
            detach the window from the app and dispose of it
        */
        DoMethod(app, OM_REMMEMBER, win);
        MUI_DisposeObject(win);

        /*
            wake up the parent window
        */
        SetAttrs(obj, MUIA_Window_Sleep, FALSE, TAG_DONE);
    }

    return ret;
}


/*
    function :      shows the best times window

    parameters :    obj = pointer to the parent window object
                    lList = level data list with the best time data
                    hiRank = ranking of current level to highlight or -1
*/

#define BTW_Done    101

static void ShowBestTimes(Object * obj, struct LevelDataList * lList, int hiRank)
{
    Object *win;

    /*
        create the best time name window
    */
    win =  NewObject(mccBTWindow->mcc_Class,NULL,
        MUIA_Window_RefWindow, obj,
        MUIA_Window_LeftEdge, MUIV_Window_LeftEdge_Centered,
        MUIA_Window_TopEdge, MUIV_Window_TopEdge_Centered,
        MUIA_BTWindow_LevelList, lList,
        MUIA_BTWindow_HighlightRank, hiRank,
        End;

    /*
        check if window was successfully created
    */
    if (win)
    {
        ULONG sigs = 0;
        BOOL running = TRUE;
        Object * app = _app(obj);

        /*
            put parent window to sleep
        */
        SetAttrs(obj, MUIA_Window_Sleep, TRUE, TAG_DONE);
        /*
            add the best time window to the application
        */
        DoMethod(app, OM_ADDMEMBER, win);
        /*
            setup notifications
        */
        DoMethod(win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                    app, 2, MUIM_Application_ReturnID, BTW_Done);

        /*
            open the best time window
        */
        SetAttrs(win, MUIA_Window_Open, TRUE, TAG_DONE);

        /*
            enter the input loop
        */
        while (running)
        {
            switch (DoMethod(app, MUIM_Application_NewInput, &sigs))
            {
                case MUIV_Application_ReturnID_Quit:
                    /*
                        re-send the quit id so the main app loop can exit
                    */
                    DoMethod(app, MUIM_Application_ReturnID,
                                  MUIV_Application_ReturnID_Quit);
                    running = FALSE;
                    break;

                case BTW_Done:
                    /*
                        user done with best time window
                    */
                    running = FALSE;
                    break;

                default:
                    if (sigs)
                    {
                        sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                        if (sigs & SIGBREAKF_CTRL_C)
                        {
                            DoMethod(app, MUIM_Application_ReturnID,
                                          MUIV_Application_ReturnID_Quit);
                            running = FALSE;
                        }
                    }
                    break;
            }
        }

        /*
            close the window
        */
        SetAttrs(win, MUIA_Window_Open, FALSE, TAG_DONE);

        /*
            detach the window from the app and dispose of it
        */
        DoMethod(app, OM_REMMEMBER, win);
        MUI_DisposeObject(win);

        /*
            wake up the parent window
        */
        SetAttrs(obj, MUIA_Window_Sleep, FALSE, TAG_DONE);
    }
}


/*
    function :    create and show a level edit window for this window's
                  level data, if the level data is changed then clear
                  the level menu, delete the old level data, set and save
                  the new level data for the window and rebuild the level
                  menu

    parameters :  obj = the mine field window whose level data is to be edited
                  data = instance data for the mine field window

    return :      none
*/
#define LEW_DONE    101

static void SetupLevels(Object * obj, struct MFWindowData * data)
{
    Object *win;
    struct LevelDataList rList;

    /*
        initialize the return level data list
    */
    rList.NumLevels = 0;
    rList.Flags = 0;
    rList.LevelList = NULL;

    /*
        create the level editor window
    */
    win =  NewObject(mccLEWindow->mcc_Class,NULL,
                        MUIA_Window_RefWindow, obj,
                        MUIA_Window_LeftEdge, MUIV_Window_LeftEdge_Centered,
                        MUIA_Window_TopEdge, MUIV_Window_TopEdge_Centered,
                        MUIA_LEWindow_GivenLevels, &data->Levels,
                        MUIA_LEWindow_ReturnLevels, &rList,
                        TAG_DONE);

    /*
        check if window was successfully created
    */
    if (win)
    {
        ULONG sigs = 0;
        BOOL running = TRUE;
        Object * app = _app(obj);

        /*
            put parent window to sleep
        */
        SetAttrs(obj, MUIA_Window_Sleep, TRUE, TAG_DONE);
        /*
            add the best time window to the application
        */
        DoMethod(app, OM_ADDMEMBER, win);
        /*
            setup notifications
        */
        DoMethod(win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
                    app, 2, MUIM_Application_ReturnID, LEW_DONE);

        /*
            open the best time window
        */
        SetAttrs(win, MUIA_Window_Open, TRUE, TAG_DONE);

        /*
            enter the input loop
        */
        while (running)
        {
            switch (DoMethod(app, MUIM_Application_NewInput, &sigs))
            {
                case MUIV_Application_ReturnID_Quit:
                    /*
                        re-send the quit id so the main app loop can exit
                    */
                    DoMethod(app, MUIM_Application_ReturnID,
                                  MUIV_Application_ReturnID_Quit);
                    running = FALSE;
                    break;

                case LEW_DONE:
                    /*
                        user done with best time window
                    */
                    running = FALSE;
                    break;

                default:
                    if (sigs)
                    {
                        sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                        if (sigs & SIGBREAKF_CTRL_C)
                        {
                            DoMethod(app, MUIM_Application_ReturnID,
                                          MUIV_Application_ReturnID_Quit);
                            running = FALSE;
                        }
                    }
                    break;
            }
        }

        /*
            close the window
        */
        SetAttrs(win, MUIA_Window_Open, FALSE, TAG_DONE);

        /*
            detach the window from the app and dispose of it
        */
        DoMethod(app, OM_REMMEMBER, win);
        MUI_DisposeObject(win);

        /*
            check the return level data list to see if level data was updated
        */
        if (rList.NumLevels)
        {
            /*
                the level data has changed, clear the old level menu, dispose
                of the existing level data, set and save the new level data,
                rebuild the level menu and restart the game with the previous
                difficulty level
            */
            ULONG CurrentLevel = data->Levels.CurrentLevel;
            rList.CurrentLevel = CurrentLevel;
            ClearLevelMenu(data);
            DisposeLevelData(&data->Levels);
            data->Levels = rList;
            SaveLevelData(&rList, NULL);
            BuildLevelMenu(data);
            data->Levels.CurrentLevel = 0;
            SetLevel(obj, data, CurrentLevel);
        }

        /*
            wake up the parent window
        */
        SetAttrs(obj, MUIA_Window_Sleep, FALSE, TAG_DONE);
    }
}

/*
    function :      shows the program info window

    parameters :    obj = pointer to the parent window object
*/
#define INFO_FMT        "\033c%s - %s\n%s\n%s%c%s%c%s"

static void ShowProgInfo(Object * obj)
{
    Object *app;
    STRPTR appTitle, appDescription, appVersion, appCopyright,
           strCredits, strTranslator;
    char ch1, ch2;

    /*
        get string pointers for info window
    */
    app = _app(obj);
    DoMethod(app, OM_GET, MUIA_Application_Title, &appTitle);
    DoMethod(app, OM_GET, MUIA_Application_Description, &appDescription);
    DoMethod(app, OM_GET, MUIA_Application_Version, &appVersion);
    DoMethod(app, OM_GET, MUIA_Application_Copyright, &appCopyright);
    strCredits = GetStr(MSG_PROGINFO_CREDITS);
    strTranslator = GetStr(MSG_PROGINFO_TRANSLATOR);
    ch1 = (*strCredits) ? '\n' : 0;
    ch2 = (*strTranslator) ? '\n' : 0;

    MUI_Request(app, obj, 0, GetStr(MSG_PROGINFO_TITLE),
                              GetStr(MSG_CONTINUE_GADGET),
                              INFO_FMT, appTitle, appDescription,
                              appVersion, appCopyright,
                              ch1, strCredits,
                              ch2, strTranslator);
}


/*
    function :  create the MFWindow custom class also creating
                any child custom classes

    return :    pointer to the MFWindow custom class if all
                the custom classes were successfully created
                otherwise NULL
*/
struct MUI_CustomClass * CreateMFWindowClass(void)
{
    if ((mccMineField = CreateMineFieldClass()))
    {
        if ((mccFaceButton = CreateFaceButtonClass()))
        {
            if ((mccDigits = CreateDigitsClass()))
            {
                if ((mccBTWindow = CreateBTWindowClass()))
                {
                    if ((mccLEWindow = CreateLEWindowClass()))
                    {
                        struct MUI_CustomClass * cmfw;
                        cmfw = MUI_CreateCustomClass(NULL, MUIC_Window, NULL,
                                                       sizeof(struct MFWindowData),
                                                       MFWindowDispatcher);
                        if (cmfw)
                        {
                            return cmfw;
                        }

                        DeleteLEWindowClass(mccLEWindow);
                        mccLEWindow = NULL;
                    }
                    DeleteBTWindowClass(mccBTWindow);
                    mccBTWindow = NULL;
                }
                DeleteDigitsClass(mccDigits);
                mccDigits = NULL;
            }
            DeleteFaceButtonClass(mccFaceButton);
            mccFaceButton = NULL;
        }
        DeleteMineFieldClass(mccMineField);
        mccMineField = NULL;
    }

    return NULL;
}

/*
    function :    delete the MFWindow custom class

    parameters :  mfwc = pointer to the MFWindow custom class to delete

    return :      none
*/
void DeleteMFWindowClass(struct MUI_CustomClass * mfwc)
{
    if (mfwc)
    {
        MUI_DeleteCustomClass(mfwc);
    }

    if (mccMineField)
    {
        DeleteMineFieldClass(mccMineField);
        mccMineField = NULL;
    }

    if (mccFaceButton)
    {
        DeleteFaceButtonClass(mccFaceButton);
        mccFaceButton = NULL;
    }

    if (mccDigits)
    {
        DeleteDigitsClass(mccDigits);
        mccDigits = NULL;
    }

    if (mccBTWindow)
    {
        DeleteBTWindowClass(mccBTWindow);
        mccBTWindow = NULL;
    }

    if (mccLEWindow)
    {
        DeleteLEWindowClass(mccLEWindow);
        mccLEWindow = NULL;
    }
}


