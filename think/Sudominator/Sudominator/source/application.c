/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.3  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.bialystok.pl>       */
/*------------------------------------------*/

/* ApplicationClass code. */

//+ includes, defines

#include "application.h"
#include "main.h"
#include "sudokuarea.h"
#include "prefswin.h"

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/muimaster.h>
#include <proto/random.h>
#include <devices/clipboard.h>
#include <utility/tagitem.h>
#include <exec/rawfmt.h>
#include <dos/dostags.h>
#include <mui/Aboutbox_mcc.h>
#include <libraries/asl.h>
#include <libvstring.h>


extern struct Library *SysBase, *IntuitionBase, *MUIMasterBase;
struct MUI_CustomClass *ApplicationClass = 0;


struct StartMsg
{
	struct Message SysMsg;
	Object *App;
	Object *Field;
	LONG Result;
	LONG Iterations;
	LONG Sudoku[81];
};


struct ObjData
{
	Object *Win;
	Object *About;
	Object *PrefsWin;
	Object *Sudoku;
	Object *Status;
	Object *LiveBtn;
	Object *QuickBtn;
	Object *HintRBtn;
	Object *HintSBtn;
	UBYTE TextBuf[128];
	struct StartMsg StartMsg;
	struct Message Command;
	struct MsgPort *LivePort;
	struct MsgPort *CommandPort;
	struct MsgPort *RemotePort;
	struct Process *LiveSolver;
	struct FileRequester *Request;
	STRPTR WindowTitle;
};


struct TextClip
{
	ULONG Form;
	ULONG FormLength;
	ULONG Ftxt;
	ULONG Chrs;
	ULONG ChrsLength;
	char  Buffer[182];
};



LONG ApplicationDispatcher(void);
const struct EmulLibEntry ApplicationGate = {TRAP_LIB, 0, (void(*)(void))ApplicationDispatcher};


#define OBJ_SUDOKU    3284
#define OBJ_STATUS    9365

#define CMD_DIE       6
#define CMD_HALT      7
#define CMD_RUN       8


BOOL QuickSolver(LONG *sudoku, LONG *iters);
BOOL VerifySudoku(struct ObjData *d, LONG *sudoku);
LONG LiveSolverProcess(void);
void DosFault(Object *app, struct ObjData *d, STRPTR header, STRPTR path);
void UpdateWindowTitle(struct ObjData *d);
void WriteClip(struct ObjData *d, struct IOClipReq *crq);

/* Live solver results. */

#define LS_FAILED         0
#define LS_SOLVED         1
#define LS_UNRESOLVED     2
#define LS_BREAK          3

const UBYTE License[] =	
	"Permission to use, copy, modify, and/or distribute this\n"
	"software for any purpose with or without fee is hereby\n"
	"granted, provided that the above copyright notice and\n"
	"this permission notice appear in all copies.\n\n"
	"The software is provided \"as is\" and the author disclaims\n"
	"all warranties with regard to this software including all\n"
	"implied warranties of merchantability and fitness. In no\n"
	"event shall the author be liable for any special, direct,\n"
	"indirect, or consequential damages or any damages\n"
	"whatsoever resulting from loss of use, data or profits,\n"
	"whether in an action of contract, negligence or other\n"
	"tortious action, arising out of or in connection with the\n"
	"use or performance of this software.";

//-
//+ CreateApplicationClass()

struct MUI_CustomClass *CreateApplicationClass(void)
{
	struct MUI_CustomClass *cl;

	cl = MUI_CreateCustomClass(NULL, MUIC_Application, NULL, sizeof(struct ObjData),
	(APTR)&ApplicationGate);
	ApplicationClass = cl;
	return cl;
}


//-
//+ DeleteApplicationClass()

void DeleteApplicationClass(void)
{
	MUI_DeleteCustomClass(ApplicationClass);
}


//-
//+ CreateMainWindow()

static Object *CreateMainWindow(void)
{
	Object *obj, *x = NULL;

	obj = MUI_NewObjectM(MUIC_Window,
		MUIA_Window_Title, APP_NAME,
		MUIA_Window_ScreenTitle, APP_NAME " " APP_VER "." __SVNVERSION__ " © " APP_CYEARS " " APP_AUTHOR,
		MUIA_Window_RootObject, x = MUI_NewObjectM(MUIC_Group,
			MUIA_Group_Child, NewObject(SudokuAreaClass->mcc_Class, NULL,
				MUIA_UserData, OBJ_SUDOKU,
			TAG_END),
			MUIA_Group_Child, MUI_NewObjectM(MUIC_Group,
				MUIA_Group_Columns, 2,
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Font, MUIV_Font_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_InputMode, MUIV_InputMode_RelVerify,
					MUIA_Text_PreParse, "\33c",
					MUIA_Text_Contents, LCS(MSG_BUTTON_SOLVEQUICK, "Quick Solve"),
					MUIA_UserData, MSG_BUTTON_SOLVEQUICK,
					MUIA_ShortHelp, LCS(MSG_BUTTON_SOLVEQUICK_HELP, "Solves the sudoku instantly."),
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Font, MUIV_Font_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_InputMode, MUIV_InputMode_RelVerify,
					MUIA_Text_PreParse, "\33c",
					MUIA_Text_Contents, LCS(MSG_BUTTON_HINTRANDOM, "Hint Random Field"),
					MUIA_ShortHelp, LCS(MSG_BUTTON_HINTRANDOM_HELP, "Reveals one randomly selected field."),
					MUIA_UserData, MSG_BUTTON_HINTRANDOM,
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Font, MUIV_Font_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_InputMode, MUIV_InputMode_Toggle,
					MUIA_Text_PreParse, "\33c",
					MUIA_Text_Contents, LCS(MSG_BUTTON_SOLVELIVE, "Live Solve"),
					MUIA_UserData, MSG_BUTTON_SOLVELIVE,
					MUIA_ShortHelp, LCS(MSG_BUTTON_SOLVELIVE_HELP, "Solves the sudoku showing every step, "
					"about 50 steps per second."),
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Font, MUIV_Font_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_InputMode, MUIV_InputMode_Toggle,
					MUIA_Text_PreParse, "\33c",
					MUIA_Text_Contents, LCS(MSG_BUTTON_HINTSELECTED, "Hint Selected Field"),
					MUIA_UserData, MSG_BUTTON_HINTSELECTED,
					MUIA_ShortHelp, LCS(MSG_BUTTON_HINTSELECTED_HELP, "Reveals a field clicked with the left mouse button."),
				TAG_END),
			TAG_END),
			MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
				MUIA_Frame, MUIV_Frame_Text,
				MUIA_Background, MUII_TextBack,
				MUIA_UserData, OBJ_STATUS,
			TAG_END),
		TAG_END),
	TAG_END);

	xset(obj, MUIA_Window_DefaultObject, x);

	return obj;
}

//-
//+ CreateMenu()

static Object* CreateMenu(void)
{
	Object *obj;

	obj = MUI_NewObjectM(MUIC_Menustrip,
		MUIA_Family_Child, MUI_NewObjectM(MUIC_Menu,
			MUIA_Menu_Title, LCS(MSG_MENU_PROJECT, "Project"),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_NEW, "New"),
				MUIA_Menuitem_Shortcut, "N",
				MUIA_UserData, MSG_MENUITEM_NEW,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_OPEN, "Open..."),
				MUIA_Menuitem_Shortcut, "O",
				MUIA_UserData, MSG_MENUITEM_OPEN,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_SAVE, "Save..."),
				MUIA_Menuitem_Shortcut, "S",
				MUIA_UserData, MSG_MENUITEM_SAVE,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_ABOUT, "About..."),
				MUIA_Menuitem_Shortcut, "?",
				MUIA_UserData, MSG_MENUITEM_ABOUT,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, -1,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_QUIT, "Quit"),
				MUIA_Menuitem_Shortcut, "Q",
				MUIA_UserData, MSG_MENUITEM_QUIT,
			TAG_END),
		TAG_END),
		MUIA_Family_Child, MUI_NewObjectM(MUIC_Menu,
			MUIA_Menu_Title, LCS(MSG_MENU_SETTINGS, "Edit"),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_EDIT_COPY, "Copy"),
				MUIA_Menuitem_Shortcut, "C",
				MUIA_UserData, MSG_MENUITEM_EDIT_COPY,
			TAG_END),
		TAG_END),
		MUIA_Family_Child, MUI_NewObjectM(MUIC_Menu,
			MUIA_Menu_Title, LCS(MSG_MENU_SETTINGS, "Settings"),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_SETTINGS_SUDOMINATOR, "Sudominator..."),
				MUIA_UserData, MSG_MENUITEM_SETTINGS_SUDOMINATOR,
			TAG_END),
			MUIA_Family_Child, MUI_NewObjectM(MUIC_Menuitem,
				MUIA_Menuitem_Title, LCS(MSG_MENUITEM_SETTINGS_MUI, "MUI..."),
				MUIA_UserData, MSG_MENUITEM_SETTINGS_MUI,
			TAG_END),
		TAG_END),
	TAG_END);

	return obj;
}


//-

//+ SendMessage()

void SendMessage(struct ObjData *d, LONG cmd)
{
	d->Command.mn_Node.ln_Type = NT_MESSAGE;
	d->Command.mn_Node.ln_Name = (char*)cmd;
	d->Command.mn_ReplyPort = d->CommandPort;
	d->Command.mn_Length = sizeof(struct Message);
	PutMsg(d->RemotePort, &d->Command);
	WaitPort(d->CommandPort);
	GetMsg(d->CommandPort);
}


//-
//+ ApplicationNew()
//==============================================================================

IPTR ApplicationNew(Class *cl, Object *obj, struct opSet *msg)
{
	Object *newobj = NULL, *win, *about, *prefs_win;

	if (obj = DoSuperNewM(cl, obj,
		MUIA_Application_Window, win = CreateMainWindow(),
		MUIA_Application_Window, prefs_win = NewObject(PrefsWinClass->mcc_Class, NULL,
		TAG_END),
		MUIA_Application_Window, about = MUI_NewObjectM(MUIC_Aboutbox,
			MUIA_Aboutbox_Credits, "\33b%p\33n\n\tGrzegorz Kraszewski",
			MUIA_Aboutbox_Build, APP_BUILD,
			MUIA_Window_RootObject, MUI_NewObjectM(MUIC_Group,
				MUIA_Group_Horiz, TRUE,
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Font, MUIV_Font_Tiny,
					MUIA_Text_Contents, LCS(MSG_PROGRAM_LICENSE, License),
				TAG_END),
			TAG_END),
		TAG_END),
		MUIA_Application_Menustrip, CreateMenu(),
	TAG_MORE, msg->ops_AttrList))
	{
		struct ObjData *d = INST_DATA(cl, obj);

		d->Win = win;
		d->PrefsWin = prefs_win;
		d->About = about;
		d->Sudoku = findobj(OBJ_SUDOKU, win);
		d->Status = findobj(OBJ_STATUS, win);
		d->LiveBtn = findobj(MSG_BUTTON_SOLVELIVE, win);
		d->QuickBtn = findobj(MSG_BUTTON_SOLVEQUICK, win);
		d->HintRBtn = findobj(MSG_BUTTON_HINTRANDOM, win);
		d->HintSBtn = findobj(MSG_BUTTON_HINTSELECTED, win);

		if (d->LivePort = CreateMsgPort())
		{
			if (d->CommandPort = CreateMsgPort())
			{
				if (d->Request = MUI_AllocAslRequestTags(ASL_FileRequest,
					ASLFR_InitialDrawer, (IPTR)"PROGDIR:",
				TAG_END))
				{
					if (d->WindowTitle = StrNew((STRPTR)"Sudominator"))
					{
						newobj = obj;
					}
				}
			}
		}

		if (!newobj) CoerceMethod(cl, obj, OM_DISPOSE);
	}

	return (IPTR)newobj;
}


//-
//+ ApplicationDispose()

LONG ApplicationDispose(Class *cl, Object *obj, Msg msg)
{
	struct ObjData *d = INST_DATA(cl, obj);

	DoMethod(obj, APPM_StopLiveSolver);
	if (d->WindowTitle) StrFree(d->WindowTitle);
	if (d->Request) MUI_FreeAslRequest(d->Request);
	if (d->LivePort) DeleteMsgPort(d->LivePort);
	if (d->CommandPort) DeleteMsgPort(d->CommandPort);
	
	return DoSuperMethodA(cl, obj, msg);
}


//-
//+ ApplicationMainLoop()

LONG ApplicationMainLoop(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	ULONG signals;
	ULONG livemask = 1 << d->LivePort->mp_SigBit;

	xset(d->Win, MUIA_Window_Open, TRUE);

	while (DoMethod(obj, MUIM_Application_NewInput, (ULONG)&signals)
	 != (ULONG)MUIV_Application_ReturnID_Quit)
	{
		if (signals)
		{
			signals = Wait(signals | SIGBREAKF_CTRL_C | livemask);

			if (signals & SIGBREAKF_CTRL_C) break;

			if (signals & livemask)
			{
				d->LiveSolver = NULL;
				xset(d->LiveBtn, MUIA_Selected, FALSE);
				xset(d->QuickBtn, MUIA_Disabled, FALSE);
				xset(d->Sudoku, SUAA_Disabled, FALSE);

				switch (d->StartMsg.Result)
				{
					case LS_FAILED:
						xset(d->Status, MUIA_Text_Contents, LCS(MSG_CANT_START_LIVESOLVER,
                         "Can't start live solver!"));
					break;

					case LS_SOLVED:
						DoMethod(obj, APPM_FinalReport, d->StartMsg.Iterations);
					break;

					case LS_UNRESOLVED:
						xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_UNRESOLVABLE,
                         "This sudoku is unresolvable."));
					break;

					case LS_BREAK:
						xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_STOPPED, "Stopped."));
					break;
				}
			}
		}
	}

	xset(d->Win, MUIA_Window_Open, FALSE);
	return 0;
}


//-
//+ ApplicationNotifications()

LONG ApplicationNotifications(Class *cl, Object *obj, UNUSED Msg msg)
{
	struct ObjData *d = INST_DATA(cl, obj);

	DoMethod(d->Win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		MUIV_Notify_Application, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_QUIT,
		MUIV_Notify_Application, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_NEW,
		MUIV_Notify_Application, 1, APPM_Clear);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_SAVE,
		MUIV_Notify_Application, 1, APPM_Save);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_OPEN,
		MUIV_Notify_Application, 1, APPM_Load);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_ABOUT,
		(IPTR)d->About, 3, MUIM_Set, MUIA_Window_Open, TRUE);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_SETTINGS_MUI,
		MUIV_Notify_Application, 3, MUIM_Application_OpenConfigWindow, 0, NULL);

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_SETTINGS_SUDOMINATOR,
		(IPTR)d->PrefsWin, 3, MUIM_Set, MUIA_Window_Open, TRUE);

	DoMethod(d->QuickBtn, MUIM_Notify, MUIA_Pressed, FALSE,
		MUIV_Notify_Application, 1, APPM_QuickSolve);

	DoMethod(d->LiveBtn, MUIM_Notify, MUIA_Selected, TRUE,
		MUIV_Notify_Application, 1, APPM_LiveSolve);

	DoMethod(d->LiveBtn, MUIM_Notify, MUIA_Selected, FALSE,
		MUIV_Notify_Application, 1, APPM_StopLiveSolver);

	DoMethod(d->PrefsWin, MUIM_Notify, PRWA_SettingsUpdated, MUIV_EveryTime,
		(IPTR)d->Sudoku, 1, SUAM_Update);

	DoMethod(d->HintRBtn, MUIM_Notify, MUIA_Pressed, FALSE,
		MUIV_Notify_Application, 1, APPM_HintRandom);

	DoMethod(d->Sudoku, MUIM_Notify, SUAA_Full, MUIV_EveryTime,
		MUIV_Notify_Application, 6, MUIM_MultiSet, MUIA_Disabled, MUIV_TriggerValue,
		(IPTR)d->HintRBtn, (IPTR)d->HintSBtn, NULL);

	DoMethod(d->Sudoku, MUIM_Notify, SUAA_ClickedField, MUIV_EveryTime,
		MUIV_Notify_Application, 2, APPM_HintSelected, MUIV_TriggerValue);

	/* Display a message on the status bar after clicking "Hint Selected" button. */

	DoMethod(d->HintSBtn, MUIM_Notify, MUIA_Selected, TRUE,
		(IPTR)d->Status, 3, MUIM_Set, MUIA_Text_Contents, (IPTR)LCS(MSG_STATUS_SELECT_FIELD, "Select a field..."));

	/* Copy sudoku to the clipboard after using "Copy" menuitem. */

	DoMethod(obj, MUIM_Notify, MUIA_Application_MenuAction, MSG_MENUITEM_EDIT_COPY,
		MUIV_Notify_Application, 1, APPM_Copy);

	return 0;
}


//-
//+ ApplicationQuickSolve()

LONG ApplicationQuickSolve(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	LONG sudoku[81];
	LONG iters = 0;

	DoMethod(d->Sudoku, SUAM_GetSudoku, (LONG)sudoku);
	xset(obj, MUIA_Application_Sleep, TRUE);

	if (VerifySudoku(d, sudoku))
	{
		if (QuickSolver(sudoku, &iters))
		{
			DoMethod(d->Sudoku, SUAM_SetSudoku, (LONG)sudoku);
			DoMethod(obj, APPM_FinalReport, iters);
		}
		else xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_UNRESOLVABLE,
         "This sudoku is unresolvable."));
	}

	xset(obj, MUIA_Application_Sleep, FALSE);
	return 0;
}

//-
//+ ApplicationClear()

LONG ApplicationClear(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	LONG i;
	LONG sudoku[81];

	if (d->LiveSolver)
	{
		LONG response;

		SendMessage(d, CMD_HALT);

		/* Solver process is now paused. */

		response = MUI_Request(obj, d->Win, 0, "Sudominator",
		 (char*)LCS(MSG_CLEAR_LIVE_SOLVER_REQUESTER_BUTTONS, "*_Continue|_Stop"),
		 (char*)LCS(MSG_CLEAR_LIVE_SOLVER_REQUESTER_TEXT, "Live solver is still running.\nDo you want to stop it?"));

		if (response == 1)   // continue
		{
			SendMessage(d, CMD_RUN);
			return 0;
		}
		else DoMethod(obj, APPM_StopLiveSolver);
	}

	for (i = 0; i < 81; i++) sudoku[i] = 0;
	DoMethod(d->Sudoku, SUAM_SetSudoku, (LONG)sudoku);
	return 0;
}


//-
//+ ApplicationStopLiveSolver()

LONG ApplicationStopLiveSolver(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);

	if (d->LiveSolver)
	{
		SendMessage(d, CMD_DIE);
		WaitPort(d->LivePort);
		GetMsg(d->LivePort);
		d->LiveSolver = NULL;
	}

	return 0;
}


//-
//+ ApplicationLiveSolve()

LONG ApplicationLiveSolve(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);

	DoMethod(d->Sudoku, SUAM_GetSudoku, (LONG)d->StartMsg.Sudoku);

	if (VerifySudoku(d, d->StartMsg.Sudoku))
	{
		d->StartMsg.SysMsg.mn_Node.ln_Type = NT_MESSAGE;
		d->StartMsg.SysMsg.mn_Length = sizeof(struct StartMsg);
		d->StartMsg.SysMsg.mn_ReplyPort = d->LivePort;
		d->StartMsg.App = obj;
		d->StartMsg.Field = d->Sudoku;
		d->StartMsg.Result = LS_FAILED;
		d->StartMsg.Iterations = 0;

		d->LiveSolver = CreateNewProcTags(
			NP_Entry, (IPTR)LiveSolverProcess,
			NP_CodeType, CODETYPE_PPC,
			NP_Priority, 0,
			NP_PPCStackSize, 32768,
			NP_Name, (IPTR)"Sudominator Live Solver",
			NP_StartupMsg, (IPTR)&d->StartMsg,
			NP_TaskMsgPort, (IPTR)&d->RemotePort,
		TAG_END);

		if (d->LiveSolver)
		{
			xset(d->QuickBtn, MUIA_Disabled, TRUE);
			xset(d->Sudoku, SUAA_Disabled, TRUE);
		}
		else
		{
			xset(d->Status, MUIA_Text_Contents, LCS(MSG_CANT_START_LIVESOLVER, "Can't start live solver!"));
			xnset(d->LiveBtn, MUIA_Selected, FALSE);
		}
	}
	else xnset(d->LiveBtn, MUIA_Selected, FALSE);

	return 0;
}


//-
//+ ApplicationLiveReport()

LONG ApplicationLiveReport(Class *cl, Object *obj, struct APPP_Report *msg)
{
	struct ObjData *d = INST_DATA(cl, obj);

	NewRawDoFmt(LCS(MSG_LIVE_SOLVING_REPORT, "Solving, %ld steps..."), RAWFMTFUNC_STRING, d->TextBuf,
     msg->Iterations);
	xset(d->Status, MUIA_Text_Contents, d->TextBuf);

	return 0;
}


//-
//+ ApplicationFinalReport()

LONG ApplicationFinalReport(Class *cl, Object *obj, struct APPP_Report *msg)
{
	struct ObjData *d = INST_DATA(cl, obj);

	NewRawDoFmt(LCS(MSG_STATUS_SOLVED, "Solved in %ld steps."), RAWFMTFUNC_STRING,
     d->TextBuf, msg->Iterations);
	xset(d->Status, MUIA_Text_Contents, d->TextBuf);

	return 0;
}


//-
//+ ApplicationSave()

IPTR ApplicationSave(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	BOOL save = FALSE;
	LONG sudoku[81];

	xset(d->Win, MUIA_Window_Sleep, TRUE);

	if (d->LiveSolver)
	{
		LONG response;

		SendMessage(d, CMD_HALT);
		response = MUI_Request(obj, d->Win, 0, "Sudominator",
		 (char*)LCS(MSG_SAVE_LIVE_SOLVER_REQUESTER_BUTTONS, (STRPTR)"*_Cancel|_Save"),
		 (char*)LCS(MSG_SAVE_LIVE_SOLVER_REQUESTER_TEXT,  (STRPTR)"Live solver is running. Do you want\nto save current, paused state?"));
		if (response == 0) save = TRUE;
	}
	else save = TRUE;

	if (save)
	{
		if (MUI_AslRequestTags(d->Request,
			ASLFR_TitleText, (IPTR)LCS(MSG_SAVE_REQUESTER_WINDOW_TITLE, "Save Sudoku"),
			ASLFR_DoSaveMode, TRUE,
		TAG_END))
		{
			LONG path_length;
			STRPTR path;

			path_length = StrLen(d->Request->fr_File) + StrLen(d->Request->fr_Drawer) + 8;

			if (path = AllocTaskPooled(path_length))
			{
				StrCopy(d->Request->fr_Drawer, path);

				if (AddPart(path, d->Request->fr_File, path_length))
				{
					BPTR filehandle;

					if (filehandle = Open(path, MODE_NEWFILE))
					{
						LONG x, j = 0;
						UBYTE m, t[41];

						DoMethod(d->Sudoku, SUAM_GetSudoku, (IPTR)&sudoku);

						for (x = 0; x < 80; x += 2)
						{
							m = (sudoku[x] & 0xF) << 4;
							m += sudoku[x + 1] & 0xF;
							t[j++] = m;
						}

						t[40] = (sudoku[80] & 0xF) << 4;

						if (Write(filehandle, t, 41) == 41)
						{
							UpdateWindowTitle(d);
						}
						else DosFault(obj, d, LCS(MSG_ERROR_WRITING_SUDOKU, "Error writing \"%s\":\n%s."), path);

						Close(filehandle);
					}
					else DosFault(obj, d, LCS(MSG_ERROR_OPENING_FOR_WRITE, "Error opening \"%s\":\n%s."), path);
				}

				FreeTaskPooled(path, path_length);
			}
		}
	}

	if (d->LiveSolver) SendMessage(d, CMD_RUN);
	xset(d->Win, MUIA_Window_Sleep, FALSE);

	return 0;
}

//-
//+ ApplicationLoad()

IPTR ApplicationLoad(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	BOOL load = FALSE;
	LONG sudoku[81];

	xset(d->Win, MUIA_Window_Sleep, TRUE);

	if (d->LiveSolver)
	{
		LONG response;

		SendMessage(d, CMD_HALT);
		response = MUI_Request(obj, d->Win, 0, "Sudominator",
		 (char*)LCS(MSG_LOAD_LIVE_SOLVER_REQUESTER_BUTTONS, "*_Cancel|_Open"),
		 (char*)LCS(MSG_LOAD_LIVE_SOLVER_REQUESTER_TEXT,  "Live solver is running. Do you want\nto stop it and open a new sudoku?"));

		if (response == 0)
		{
			DoMethod(obj, APPM_StopLiveSolver);
			load = TRUE;
		}
		else SendMessage(d, CMD_RUN);
	}
	else load = TRUE;

	if (load)
	{
		if (MUI_AslRequestTags(d->Request,
			ASLFR_TitleText, (IPTR)LCS(MSG_SAVE_REQUESTER_WINDOW_TITLE, "Open Sudoku"),
			ASLFR_DoSaveMode, FALSE,
		TAG_END))
		{
			LONG path_length;
			STRPTR path;

			path_length = StrLen(d->Request->fr_File) + StrLen(d->Request->fr_Drawer) + 8;

			if (path = AllocTaskPooled(path_length))
			{
				StrCopy(d->Request->fr_Drawer, path);

				if (AddPart(path, d->Request->fr_File, path_length))
				{
					BPTR filehandle;

					if (filehandle = Open(path, MODE_OLDFILE))
					{
						LONG x, j = 0;
						UBYTE t[41];
						BOOL valid = TRUE;

						if (Read(filehandle, t, 41) == 41)
						{
							for (x = 0; x < 40; x++)
							{
								sudoku[j++] = (t[x] >> 4) & 0xF;
								sudoku[j++] = t[x] & 0xF;
							}

							sudoku[80] = t[40] >> 4;

							for (x = 0; x < 81; x++)
							{
								if (sudoku[x] > 9) valid = FALSE;
							}

							if (valid)
							{
								DoMethod(d->Sudoku, SUAM_SetSudoku, (IPTR)sudoku);
								xset(d->Status, MUIA_Text_Contents, "");
								UpdateWindowTitle(d);
							}
							else
							{
								MUI_Request(obj, d->Win, 0, "Sudominator",
								 (char*)LCS(MSG_LOAD_ERROR_SUDOKU_INVALID_BUTTON, "*_OK"),
								 (char*)LCS(MSG_LOAD_ERROR_SUDOKU_INVALID_TEXT, "Not a valid sudoku file."));
							}
						}
						else DosFault(obj, d, LCS(MSG_ERROR_READING_SUDOKU, "Error reading \"%s\":\n%s."), path);

						Close(filehandle);
					}
					else DosFault(obj, d, LCS(MSG_ERROR_OPENING_FOR_WRITE, "Error opening \"%s\":\n%s."), path);
				}

				FreeTaskPooled(path, path_length);
			}
		}
	}

	if (d->LiveSolver) SendMessage(d, CMD_RUN);
	xset(d->Win, MUIA_Window_Sleep, FALSE);

	return 0;
}

//-
//+ ApplicationHintRandom()

IPTR ApplicationHintRandom(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	LONG original[81], solution[81];
	LONG iters = 0;

	xset(obj, MUIA_Application_Sleep, TRUE);
	DoMethod(d->Sudoku, SUAM_GetSudoku, (LONG)original);
	CopyMem(original, solution, 81 * sizeof(LONG));

	if (VerifySudoku(d, solution))
	{
		if (QuickSolver(solution, &iters))
		{
			LONG fb;
			BOOL found = FALSE;

			while (!found)
			{
				fb = RandomByte() / 3;

				if ((fb < 81) && (original[fb] == 0)) found = TRUE;
			}

			DoMethod(d->Sudoku, SUAM_SetField, solution[fb], fb);
			DoMethod(d->Sudoku, SUAM_FlashOneField, fb);
			xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_RANDOM_FIELD_DONE, "A random field has been revealed."));
		}
		else xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_UNRESOLVABLE, "This sudoku is unresolvable."));
	}

	xset(obj, MUIA_Application_Sleep, FALSE);
	return 0;
}

//-
//+ ApplicationHintSelected()

IPTR ApplicationHintSelected(Class *cl, Object *obj, struct APPP_HintSelected *msg)
{
	struct ObjData *d = INST_DATA(cl, obj);
	LONG original[81], solution[81];
	LONG iters = 0;

	if (xget(d->HintSBtn, MUIA_Selected))
	{
		xset(obj, MUIA_Application_Sleep, TRUE);
		DoMethod(d->Sudoku, SUAM_GetSudoku, (LONG)original);

		if (original[msg->SelectedField] == 0)
		{
			CopyMem(original, solution, 81 * sizeof(LONG));

			if (VerifySudoku(d, solution))
			{
				if (QuickSolver(solution, &iters))
				{
					DoMethod(d->Sudoku, SUAM_SetField, solution[msg->SelectedField], msg->SelectedField);
					xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_SELECTED_FIELD_DONE, "The selected field has been revealed."));
				}
				else xset(d->Status, MUIA_Text_Contents, LCS(MSG_STATUS_UNRESOLVABLE, "This sudoku is unresolvable."));
			}
		}

		xset(d->HintSBtn, MUIA_Selected, FALSE);
		xset(obj, MUIA_Application_Sleep, FALSE);
	}
	return 0;
}

//-
//+ ApplicationCopy()

// Clipboard write support. No POST functionality, just simple write.

IPTR ApplicationCopy(Class *cl, Object *obj)
{
	struct ObjData *d = INST_DATA(cl, obj);
	struct MsgPort *cmp;
	struct IOClipReq *crq;

	if (cmp = CreateMsgPort())
	{
		if (crq = CreateIORequest(cmp, sizeof(struct IOClipReq)))
		{
			if (OpenDevice((STRPTR)"clipboard.device", 0, (struct IORequest*)crq, 0) == 0)
			{
				WriteClip(d, crq);
				CloseDevice((struct IORequest*)crq);
			}

			DeleteIORequest(crq);
		}

		DeleteMsgPort(cmp);
	}

	return 0;
}


//-

//+ ApplicationDispatcher()

LONG ApplicationDispatcher(void)
{
	Class *cl = (Class*)REG_A0;
	Object *obj = (Object*)REG_A2;
	Msg msg = (Msg)REG_A1;

	switch (msg->MethodID)
	{
		case OM_NEW:              return ApplicationNew(cl, obj, (struct opSet*)msg);
		case OM_DISPOSE:          return ApplicationDispose(cl, obj, msg);
		case APPM_Notifications:  return ApplicationNotifications(cl, obj, msg);
		case APPM_MainLoop:       return ApplicationMainLoop(cl, obj);
		case APPM_QuickSolve:     return ApplicationQuickSolve(cl, obj);
		case APPM_Validate:       return ApplicationClear(cl, obj);
		case APPM_Clear:          return ApplicationClear(cl, obj);
		case APPM_LiveSolve:      return ApplicationLiveSolve(cl, obj);
		case APPM_LiveReport:     return ApplicationLiveReport(cl, obj, (struct APPP_Report*)msg);
		case APPM_StopLiveSolver: return ApplicationStopLiveSolver(cl, obj);
		case APPM_FinalReport:    return ApplicationFinalReport(cl, obj, (struct APPP_Report*)msg);
		case APPM_Save:           return ApplicationSave(cl, obj);
		case APPM_Load:           return ApplicationLoad(cl, obj);
		case APPM_HintRandom:     return ApplicationHintRandom(cl, obj);
		case APPM_HintSelected:   return ApplicationHintSelected(cl, obj, (struct APPP_HintSelected*)msg);
		case APPM_Copy:           return ApplicationCopy(cl, obj);
		default:                  return DoSuperMethodA(cl, obj, msg);
	}
}


//-

// INTERNAL IMPLEMENTATION

//+ VerifyField()

BOOL VerifyField(struct ObjData *d, LONG *sudoku, LONG idx)
{
	LONG i2, i3, i2s, digit = sudoku[idx];

	if (digit == 0) return TRUE;

	/*-----------------------------*/
	/* row                         */
	/*-----------------------------*/

	i2s = idx - idx % 9;

	for (i2 = i2s; i2 < i2s + 9; i2++)
	{
		if ((i2 != idx) && (sudoku[i2] == digit))
		{
			NewRawDoFmt(LCS(MSG_STATUS_DUP_IN_ROW, "Digit %ld duplicated in row %ld."),
			 RAWFMTFUNC_STRING, d->TextBuf, digit, (idx / 9) + 1);
			xset(d->Status, MUIA_Text_Contents, d->TextBuf);
			DoMethod(d->Sudoku, SUAM_FlashTwoFields, idx, i2);  
			return FALSE;
		}
	}

	/*-----------------------------*/
	/* column                      */
	/*-----------------------------*/

	i2s = idx % 9;

	for (i2 = i2s; i2 < i2s + 81; i2 += 9)
	{
		if ((i2 != idx) && (sudoku[i2] == digit))
		{
			NewRawDoFmt(LCS(MSG_STATUS_DUP_IN_COLUMN, "Digit %ld duplicated in column %ld."),
			 RAWFMTFUNC_STRING, d->TextBuf,  digit, (idx % 9) + 1);
			xset(d->Status, MUIA_Text_Contents, d->TextBuf);
			DoMethod(d->Sudoku, SUAM_FlashTwoFields, idx, i2);  
			return FALSE;
		}
	}

	/*-----------------------------*/
	/* section                     */
	/*-----------------------------*/

	i2s = idx - idx % 27;
	i2s += idx % 9 - idx % 3;

	for (i2 = i2s; i2 < i2s + 27; i2 += 9)
	{
		for (i3 = i2; i3 < i2 + 3; i3++)
		{
			if ((i3 != idx) && (sudoku[i3] == digit))
			{
				NewRawDoFmt(LCS(MSG_STATUS_DUP_IN_BOX, "Digit %ld duplicated in box %ld.\n"),
				 RAWFMTFUNC_STRING, d->TextBuf,	digit, (idx / 27) * 3 + (idx % 9) / 3);
				xset(d->Status, MUIA_Text_Contents, d->TextBuf);
				DoMethod(d->Sudoku, SUAM_FlashTwoFields, idx, i3);  
				return FALSE;
			}
		}
	}

	return TRUE;
}


//-
//+ VerifySudoku()

BOOL VerifySudoku(struct ObjData *d, LONG *sudoku)
{
	LONG index;

	for (index = 0; index < 81; index++)
	{
		if (!(VerifyField(d, sudoku, index))) return FALSE;
	}

	return TRUE;
}


//-
//+ CountConstraints()

LONG CountConstraints(LONG *sudoku, LONG index)
{
	LONG i2, i3, i2s, constraints = 0;

	/*-----------------------------*/
	/* row                         */
	/*-----------------------------*/

	i2s = index - index % 9;

	for (i2 = i2s; i2 < i2s + 9; i2++)
	{
		if (sudoku[i2]) constraints++;
	}

	/*-----------------------------*/
	/* column                      */
	/*-----------------------------*/

	i2s = index % 9;

	for (i2 = i2s; i2 < i2s + 81; i2 += 9)
	{
		if (sudoku[i2]) constraints++;
	}

	/*-----------------------------*/
	/* section                     */
	/*-----------------------------*/

	i2s = index - index % 27;
	i2s += index % 9 - index % 3;

	for (i2 = i2s; i2 < i2s + 27; i2 += 9)
	{
		for (i3 = i2; i3 < i2 + 3; i3++)
		{
			if (sudoku[i3]) constraints++;
		}
	}

	return constraints;
}


//-
//+ GetMostConstrainedField()

LONG GetMostConstrainedField(LONG *sudoku)
{
	LONG best_field = 81;
	LONG constr, max_constr = -1;
	LONG index;

	for (index = 0; index < 81; index++)
	{
		if (sudoku[index] == 0)
		{
			constr = CountConstraints(sudoku, index);

			if (constr > max_constr)
			{
				max_constr = constr;
				best_field = index;
			}
		}
	}

	return best_field;
}

//-
//+ Check()

static BOOL Check(LONG *sudoku, LONG index, LONG digit)
{
	LONG *p_sudoku;

	/* Sprawdzanie wiersza. */

	p_sudoku = sudoku + index - index % 9;
	if (p_sudoku[0] == digit) return FALSE;
	if (p_sudoku[1] == digit) return FALSE;
	if (p_sudoku[2] == digit) return FALSE;
	if (p_sudoku[3] == digit) return FALSE;
	if (p_sudoku[4] == digit) return FALSE;
	if (p_sudoku[5] == digit) return FALSE;
	if (p_sudoku[6] == digit) return FALSE;
	if (p_sudoku[7] == digit) return FALSE;
	if (p_sudoku[8] == digit) return FALSE;

	/* Sprawdzanie kolumny. */

	p_sudoku = sudoku + index % 9;
	if (p_sudoku[0] == digit) return FALSE;
	if (p_sudoku[9] == digit) return FALSE;
	if (p_sudoku[18] == digit) return FALSE;
	if (p_sudoku[27] == digit) return FALSE;
	if (p_sudoku[36] == digit) return FALSE;
	if (p_sudoku[45] == digit) return FALSE;
	if (p_sudoku[54] == digit) return FALSE;
	if (p_sudoku[63] == digit) return FALSE;
	if (p_sudoku[72] == digit) return FALSE;

	/* Sprawdzanie kwadracika. */

	p_sudoku = sudoku + index - index % 27 + index % 9 - index % 3;
	if (p_sudoku[0] == digit) return FALSE;
	if (p_sudoku[1] == digit) return FALSE;
	if (p_sudoku[2] == digit) return FALSE;
	if (p_sudoku[9] == digit) return FALSE;
	if (p_sudoku[10] == digit) return FALSE;
	if (p_sudoku[11] == digit) return FALSE;
	if (p_sudoku[18] == digit) return FALSE;
	if (p_sudoku[19] == digit) return FALSE;
	if (p_sudoku[20] == digit) return FALSE;

	return TRUE;
}


//-
//+ QuickSolver()

BOOL QuickSolver(LONG *sudoku, LONG *iters)
{
	LONG field;
	LONG digit;

	field = GetMostConstrainedField(sudoku);
	if (field == 81) return TRUE;

	for (digit = 1; digit <= 9; digit++)
	{
		if (Check(sudoku, field, digit))
		{
			int res;

			sudoku[field] = digit;
			(*iters)++;
			res = QuickSolver(sudoku, iters);
			if (res) return TRUE;
			else sudoku[field] = 0;
		}
	}

	return FALSE;
}


//-
//+ DosFault()

void DosFault(Object *app, struct ObjData *d, STRPTR header, STRPTR path)
{
	UBYTE dos_fault[96];
	STRPTR m;

	if (Fault(IoErr(), (STRPTR)"", dos_fault, 96))
	{
		if (m = FmtNew(header, path, &dos_fault[2]))
		{
			MUI_Request(app, d->Win, 0, "Sudominator", (char*)LCS(MSG_DOS_ERROR_REQUESTER_BUTTON, "*_OK"), (char*)m);
			StrFree(m);
		}
	}
}


//-
//+ UpdateWindowTitle()

void UpdateWindowTitle(struct ObjData *d)
{
	STRPTR new_window_title;

	if (new_window_title = FmtNew((STRPTR)"Sudominator: %s", d->Request->fr_File))
	{
		StrFree(d->WindowTitle);
		d->WindowTitle = new_window_title;
		xset(d->Win, MUIA_Window_Title, d->WindowTitle);
	}
}


//-
//+ WriteClip()

// The clip contains 182 characters.

void WriteClip(struct ObjData *d, struct IOClipReq *crq)
{
	struct TextClip tclip;
	LONG i, field[81];
	char f, *p;

	tclip.Form = MAKE_ID('F','O','R','M');
	tclip.Ftxt = MAKE_ID('F','T','X','T');
	tclip.Chrs = MAKE_ID('C','H','R','S');
	tclip.ChrsLength = 182;
	tclip.FormLength = 194;
	p = tclip.Buffer;

	DoMethod(d->Sudoku, SUAM_GetSudoku, (IPTR)&field);

	for (i = 0; i < 81; i++)
	{
		f = field[i];

		if (f == 0) *p++ = ' ';
		else *p++ = f + '0';

		if (i % 9 == 8)
		{
			*p++ = 0x0A;
			if ((i == 26) || (i == 53)) *p++ = 0x0A;
		}
		else
		{
			*p++ = ' ';
			if (i % 3 == 2) *p++ = ' ';
		}
	}

	crq->io_Command = CMD_WRITE;
	crq->io_Data = (STRPTR)&tclip;
	crq->io_Length = 202;
	crq->io_Offset = 0;
	crq->io_ClipID = 0;

	if (DoIO((struct IORequest*)crq) == 0)
	{
		crq->io_Command = CMD_UPDATE;
		DoIO((struct IORequest*)crq);
	}
}


//-

// LIVE SOLVER PROCESS

//+ definitions

#define LOCAL_BASE(x) struct Library *x##Base = ld->x##Base

struct LData
{
	struct Library *SysBase;
	struct Library *DOSBase;
	struct Library *IntuitionBase;
//	  struct MsgPort *MessgaePort;
	struct MsgPort *CommandPort;
};


//-
//+ LiveSolver()

LONG LiveSolver(LONG *sudoku, struct LData *ld, struct StartMsg *sm)
{
	LOCAL_BASE(Sys);
	LOCAL_BASE(DOS);
	LONG field;
	LONG digit;
	LONG r = LS_UNRESOLVED;
	BOOL leave_out = FALSE;
	struct Message *cmd;

	while (cmd = GetMsg(ld->CommandPort))
	{
		LONG command = (LONG)cmd->mn_Node.ln_Name;

		ReplyMsg(cmd);

		if (command == CMD_DIE) leave_out = TRUE;
		if (command == CMD_HALT)
		{
			WaitPort(ld->CommandPort);
			cmd = GetMsg(ld->CommandPort);
			command = (LONG)cmd->mn_Node.ln_Name;
			if (command == CMD_DIE) leave_out = TRUE;
			ReplyMsg(cmd);
		}
	}

	if (leave_out) return LS_BREAK;

	field = GetMostConstrainedField(sudoku);

	if (field == 81) return LS_SOLVED;

	for (digit = 1; digit <= 9; digit++)
	{
		if (Check(sudoku, field, digit))
		{
			sudoku[field] = digit;
			sm->Iterations++;
			
			DoMethod(sm->App, MUIM_Application_PushMethod, (LONG)sm->Field, 3, SUAM_SetField, digit, field);
			DoMethod(sm->App, MUIM_Application_PushMethod, (LONG)sm->App, 2, APPM_LiveReport, sm->Iterations);
			Delay(1);
			
			if ((r = LiveSolver(sudoku, ld, sm)) != LS_UNRESOLVED) return r;
			else
			{
				sudoku[field] = 0;
				DoMethod(sm->App, MUIM_Application_PushMethod, (LONG)sm->Field, 3, SUAM_SetField, 0, field);
			}
		}
	}

	return LS_UNRESOLVED;
}

//-
//+ LiveSolverSetup()

BOOL LiveSolverSetup(struct LData *ld)
{
	LOCAL_BASE(Sys);

	if (!(ld->DOSBase = OpenLibrary((STRPTR)"dos.library", 50))) return FALSE;
	if (!(ld->IntuitionBase = OpenLibrary((STRPTR)"intuition.library", 50))) return FALSE;
	return TRUE;
}


//-
//+ LiveSolverCleanup()

void LiveSolverCleanup(struct LData *ld)
{
	LOCAL_BASE(Sys);

	if (ld->IntuitionBase) CloseLibrary(ld->IntuitionBase);
	if (ld->DOSBase) CloseLibrary(ld->DOSBase);
}


//-
//+ LiveSolverProcess()


LONG LiveSolverProcess(void)
{
	struct Library *SysBase = *(struct Library**)4L;
	struct LData ld;
	struct StartMsg *sm;

	ld.SysBase = SysBase;
	NewGetTaskAttrs(NULL, &sm, sizeof(APTR), TASKINFOTYPE_STARTUPMSG, TAG_END);
	NewGetTaskAttrs(NULL, &ld.CommandPort, sizeof(APTR), TASKINFOTYPE_TASKMSGPORT, TAG_END);

	if (!sm || !ld.CommandPort) return 0;   // general failure, can do nothing but exit

	if (LiveSolverSetup(&ld))
	{
		sm->Result = LiveSolver(sm->Sudoku, &ld, sm);
	}

	LiveSolverCleanup(&ld);
	return 0;
}

//-

