#ifndef MAKE_ID
#define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif

#ifdef _DCC
#define __inline
#endif

#include "GUI.h"

struct ObjApp * CreateApp(void)
{
	struct ObjApp * Object;

	APTR	MENU, MENU_PROJ, MENU_ABOUT, MENU_A_MUI, MENUBarLabel2, MENU_QUIT;
	APTR	GRP_ROOT, GRP_MAIN, SPACE1, TX_TITLE, SPACE2, LA_LIVES, SPACE3, LA_MONEY;
	APTR	SPACE4, GRP_HORIZ, SPACE5, BT_LOAD, BT_SAVE, SPACE6, SPACE7;

	if (!(Object = AllocVec(sizeof(struct ObjApp), MEMF_PUBLIC|MEMF_CLEAR)))
		return(NULL);

	Object->STR_TX_TITLE = "TA-Hack\n©1996 ALeX Kazik";
	Object->STR_TX_STATUS = NULL;

	Object->STR_GRP_PAGES[0] = "Main";
	Object->STR_GRP_PAGES[1] = "Players";
	Object->STR_GRP_PAGES[2] = "Load/Save";
	Object->STR_GRP_PAGES[3] = NULL;
	Object->CY_PLAYERContent[0] = "Player1";
	Object->CY_PLAYERContent[1] = "Player2";
	Object->CY_PLAYERContent[2] = NULL;

	SPACE1 = HVSpace;

	TX_TITLE = TextObject,
		MUIA_Background, MUII_FILLSHINE,
		MUIA_Frame, MUIV_Frame_Text,
		MUIA_Text_Contents, Object->STR_TX_TITLE,
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_SetMin, TRUE,
	End;

	SPACE2 = HVSpace;

	Object->TX_STATUS = TextObject,
		MUIA_Background, MUII_TextBack,
		MUIA_Frame, MUIV_Frame_Text,
		MUIA_Text_Contents, Object->STR_TX_STATUS,
		MUIA_Text_PreParse, "\033c",
	End;

	GRP_MAIN = GroupObject,
		Child, SPACE1,
		Child, TX_TITLE,
		Child, SPACE2,
		Child, Object->TX_STATUS,
	End;

	Object->CY_PLAYER = CycleObject,
		MUIA_Weight, 0,
		MUIA_Cycle_Entries, Object->CY_PLAYERContent,
	End;

	LA_LIVES = Label("Lives:");

	Object->STR_LIVES = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_String_Accept, "0123456789",
		MUIA_String_MaxLen, 3,
		MUIA_String_Format, MUIV_String_Format_Center,
	End;

	SPACE3 = HVSpace;

	LA_MONEY = Label("Money:");

	Object->STR_MONEY = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_String_Accept, "0123456789",
		MUIA_String_MaxLen, 7,
		MUIA_String_Format, MUIV_String_Format_Center,
	End;

	Object->GRP_PLAYER = GroupObject,
		MUIA_FramePhantomHoriz, TRUE,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_Group_Rows, 2,
		MUIA_Group_SameSize, TRUE,
		Child, Object->CY_PLAYER,
		Child, LA_LIVES,
		Child, Object->STR_LIVES,
		Child, SPACE3,
		Child, LA_MONEY,
		Child, Object->STR_MONEY,
	End;

	SPACE4 = HVSpace;

	SPACE5 = HVSpace;

	BT_LOAD = TextObject,
		ButtonFrame,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'l',
		MUIA_Text_Contents, "LOAD",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'l',
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	BT_SAVE = TextObject,
		ButtonFrame,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 's',
		MUIA_Text_Contents, "SAVE",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 's',
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	SPACE6 = HVSpace;

	GRP_HORIZ = GroupObject,
		MUIA_Group_Horiz, TRUE,
		Child, SPACE5,
		Child, BT_LOAD,
		Child, BT_SAVE,
		Child, SPACE6,
	End;

	SPACE7 = HVSpace;

	Object->GA_STATUS = GaugeObject,
		GaugeFrame,
		MUIA_FixHeight, 10,
		MUIA_Gauge_Horiz, TRUE,
		MUIA_Gauge_InfoText, "\0332Game in Memory.",
		MUIA_Gauge_Max, 100,
	End;

	Object->GRP_LS = GroupObject,
		Child, SPACE4,
		Child, GRP_HORIZ,
		Child, SPACE7,
		Child, Object->GA_STATUS,
	End;

	Object->GRP_PAGES = RegisterObject,
		MUIA_Register_Titles, Object->STR_GRP_PAGES,
		MUIA_Frame, MUIV_Frame_Group,
		Child, GRP_MAIN,
		Child, Object->GRP_PLAYER,
		Child, Object->GRP_LS,
	End;

	GRP_ROOT = GroupObject,
		Child, Object->GRP_PAGES,
	End;

	MENU_ABOUT = MenuitemObject,
		MUIA_Menuitem_Title, "About...",
	End;

	MENU_A_MUI = MenuitemObject,
		MUIA_Menuitem_Title, "About MUI...",
	End;

	MENUBarLabel2 = MUI_MakeObject(MUIO_Menuitem, NM_BARLABEL, 0, 0, 0);

	MENU_QUIT = MenuitemObject,
		MUIA_Menuitem_Title, "Quit...",
	End;

	MENU_PROJ = MenuitemObject,
		MUIA_Menuitem_Title, "Project",
		MUIA_Family_Child, MENU_ABOUT,
		MUIA_Family_Child, MENU_A_MUI,
		MUIA_Family_Child, MENUBarLabel2,
		MUIA_Family_Child, MENU_QUIT,
	End;

	MENU = MenustripObject,
		MUIA_Family_Child, MENU_PROJ,
	End;

	Object->WINDOW = WindowObject,
		MUIA_Window_Title, "TA-Hack",
		MUIA_Window_Menustrip, MENU,
		MUIA_Window_ID, MAKE_ID('0', 'W', 'I', 'N'),
		MUIA_Window_SizeGadget, FALSE,
		WindowContents, GRP_ROOT,
	End;

	Object->App = ApplicationObject,
		MUIA_Application_Author, "ALeX Kazik",
		MUIA_Application_Base, "TA-HACK",
		MUIA_Application_Title, "TA-Hack",
		MUIA_Application_Version, "$VER: TA-Hack 1.0 (22.04.96)",
		MUIA_Application_Copyright, "Anyone",
		MUIA_Application_Description, "Tower Assault Hack Prog",
		SubWindow, Object->WINDOW,
	End;


	if (!Object->App)
	{
		FreeVec(Object);
		return(NULL);
	}

	DoMethod(MENU_ABOUT,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_ABOUT
		);

	DoMethod(MENU_A_MUI,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_ABOUT_MUI
		);

	DoMethod(MENU_QUIT,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit
		);

	DoMethod(Object->WINDOW,
		MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		Object->App,
		2,
		MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit
		);

	DoMethod(Object->GRP_PAGES,
		MUIM_Notify, MUIA_Group_ActivePage, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_PAGES
		);

	DoMethod(Object->CY_PLAYER,
		MUIM_Notify, MUIA_Cycle_Active, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_PLAYER
		);

	DoMethod(Object->STR_LIVES,
		MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_LIVES
		);

	DoMethod(Object->STR_MONEY,
		MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_MONEY
		);

	DoMethod(BT_LOAD,
		MUIM_Notify, MUIA_Pressed, FALSE,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_LOAD
		);

	DoMethod(BT_SAVE,
		MUIM_Notify, MUIA_Pressed, FALSE,
		Object->App,
		2,
		MUIM_Application_ReturnID, ID_SAVE
		);

	DoMethod(Object->WINDOW,
		MUIM_Window_SetCycleChain, Object->GRP_PAGES,
		Object->CY_PLAYER,
		Object->STR_LIVES,
		Object->STR_MONEY,
		BT_LOAD,
		BT_SAVE,
		NULL);

	set(Object->WINDOW,
		MUIA_Window_Open, TRUE
		);


	return(Object);
}

void DisposeApp(struct ObjApp * Object)
{
	MUI_DisposeObject(Object->App);
	FreeVec(Object);
}
