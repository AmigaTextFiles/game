/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.6  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.edu.pl>             */
/*------------------------------------------*/

/* PrefsWinClass code. */

#include "prefswin.h"
#include "main.h"

struct MUI_CustomClass *PrefsWinClass;

/// dispatcher prototype

IPTR PrefsWinDispatcher(void);
const struct EmulLibEntry PrefsWinGate = {TRAP_LIB, 0, (void(*)(void))PrefsWinDispatcher};


///
/// PrefsWinData

struct PrefsWinData
{
	Object *SudokuPen;
	Object *EffectSlider;
};


///
/// CreatePrefsWinClass()

struct MUI_CustomClass *CreatePrefsWinClass(void)
{
	struct MUI_CustomClass *cl;

	cl = MUI_CreateCustomClass(NULL, MUIC_Window, NULL, sizeof(struct PrefsWinData), (APTR)&PrefsWinGate);
	PrefsWinClass = cl;
	return cl;
}


///
/// DeletePrefsWinClass()

void DeletePrefsWinClass(void)
{
	if (PrefsWinClass) MUI_DeleteCustomClass(PrefsWinClass);
}


///
/// PrefsWinNew()

IPTR PrefsWinNew(Class *cl, Object *obj, struct opSet *msg)
{
	Object *poppen, *slider, *bt_use, *bt_save, *bt_cancel;

	if (obj = DoSuperNewM(cl, obj,
		MUIA_Window_Title, LCS(MSG_PREFS_WINDOW_TITLE, "Sudominator Settings"),
		MUIA_Window_ID, 0x50524546,   /* 'PREF' */
		MUIA_Window_RootObject, MUI_NewObjectM(MUIC_Group,
			MUIA_Group_Child, MUI_NewObjectM(MUIC_Group,
				MUIA_Group_Columns, 2,
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Text_Contents, LCS(MSG_PREFS_SUDOKU_FOREGROUND_COLOR_LABEL, "Sudoku Foreground Color:"),
					MUIA_Text_PreParse, "\33r",
					MUIA_Frame, MUIV_Frame_ImageButton,
					MUIA_HorizWeight, 0,
					MUIA_FramePhantomHoriz, TRUE,
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Group,
					MUIA_Group_Horiz, TRUE,
					MUIA_Group_Child, poppen = MUI_NewObjectM(MUIC_Poppen,
						MUIA_FixWidthTxt, "MMM",
						MUIA_ObjectID, 0x53554450,  /* "SUDP" */
					TAG_END),
					MUIA_Group_Child, MUI_NewObjectM(MUIC_Rectangle,
					TAG_END),
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Text,
					MUIA_Text_Contents, LCS(MSG_PREFS_SELECTED_FIELD_BRIGHTNESS_LABEL, "Selected Field Brightness:"),
					MUIA_Text_PreParse, "\33r",
					MUIA_Frame, MUIV_Frame_Slider,
					MUIA_HorizWeight, 0,
					MUIA_FramePhantomHoriz, TRUE,
				TAG_END),
				MUIA_Group_Child, slider = MUI_NewObjectM(MUIC_Slider,
					MUIA_Numeric_Min, -255,
					MUIA_Numeric_Default, 30,
					MUIA_Numeric_Max, 255,
					MUIA_Numeric_Format, "%+ld",
					MUIA_ObjectID, 0x45464644,  /* "EFFD" */
				TAG_END),
			TAG_END),
			MUIA_Group_Child, MUI_NewObjectM(MUIC_Rectangle,
				MUIA_Rectangle_HBar, TRUE,
				MUIA_FixHeight, 4,
			TAG_END),
			MUIA_Group_Child, MUI_NewObjectM(MUIC_Group,
				MUIA_Group_Horiz, TRUE,
				MUIA_Group_SameWidth, TRUE,
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Rectangle,
					MUIA_HorizWeight, 33,
				TAG_END),
				MUIA_Group_Child, bt_save = MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_Font, MUIV_Font_Button,
					MUIA_InputMode, MUIV_InputMode_RelVerify,
					MUIA_Text_Contents, LCS(MSG_PREFS_SAVE_BUTTON, "Save"),
					MUIA_ControlChar, LCS(MSG_PREFS_SAVE_BUTTON_HOTKEY, "s")[0],
					MUIA_Text_HiChar, LCS(MSG_PREFS_SAVE_BUTTON_HOTKEY, "s")[0],
					MUIA_Text_PreParse, "\33c",
				TAG_END),
				MUIA_Group_Child, bt_use = MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_Font, MUIV_Font_Button,
					MUIA_InputMode, MUIV_InputMode_RelVerify,
					MUIA_Text_Contents, LCS(MSG_PREFS_USE_BUTTON, "Use"),
					MUIA_ControlChar, LCS(MSG_PREFS_USE_BUTTON_HOTKEY, "u")[0],
					MUIA_Text_HiChar, LCS(MSG_PREFS_USE_BUTTON_HOTKEY, "u")[0],
					MUIA_Text_PreParse, "\33c",
				TAG_END),
				MUIA_Group_Child, bt_cancel = MUI_NewObjectM(MUIC_Text,
					MUIA_Frame, MUIV_Frame_Button,
					MUIA_Background, MUII_ButtonBack,
					MUIA_Font, MUIV_Font_Button,
					MUIA_InputMode, MUIV_InputMode_RelVerify,
					MUIA_Text_Contents, LCS(MSG_PREFS_CANCEL_BUTTON, "Cancel"),
					MUIA_ControlChar, LCS(MSG_PREFS_CANCEL_BUTTON_HOTKEY, "c")[0],
					MUIA_Text_HiChar, LCS(MSG_PREFS_CANCEL_BUTTON_HOTKEY, "c")[0],
					MUIA_Text_PreParse, "\33c",
				TAG_END),
				MUIA_Group_Child, MUI_NewObjectM(MUIC_Rectangle,
					MUIA_HorizWeight, 33,
				TAG_END),
			TAG_END),
		TAG_END),
	TAG_MORE, msg->ops_AttrList))
	{
		struct PrefsWinData *d = (struct PrefsWinData*)INST_DATA(cl, obj);

		PrefsWin = obj;
		d->SudokuPen = poppen;
		d->EffectSlider = slider;

		DoMethod(obj, MUIM_Notify, MUIA_Window_CloseRequest, MUIV_EveryTime,
			MUIV_Notify_Self, 3, MUIM_Set, MUIA_Window_Open, FALSE);

		DoMethod(bt_cancel, MUIM_Notify, MUIA_Pressed, FALSE,
			MUIV_Notify_Window, 3, MUIM_Set, MUIA_Window_Open, FALSE);

		DoMethod(bt_use, MUIM_Notify, MUIA_Pressed, FALSE,
			MUIV_Notify_Window, 2, PRWM_UseSettings, FALSE);

		DoMethod(bt_save, MUIM_Notify, MUIA_Pressed, FALSE,
			MUIV_Notify_Window, 2, PRWM_UseSettings, TRUE);
    }

	return (IPTR)obj;
}


///
/// PrefsWinGet()

IPTR PrefsWinGet(Class *cl, Object *obj, struct opGet *msg)
{
	struct PrefsWinData *d = (struct PrefsWinData*)INST_DATA(cl, obj);
	int rv = FALSE;

	switch (msg->opg_AttrID)
	{
		case PRWA_SudokuColor:
			*((struct MUI_PenSpec**)msg->opg_Storage) = (struct MUI_PenSpec*)xget(d->SudokuPen, MUIA_Pendisplay_Spec);
			rv = TRUE;
		break;

		case PRWA_EffectDepth:
			*msg->opg_Storage = xget(d->EffectSlider, MUIA_Numeric_Value);
			rv = TRUE;
		break;

		case PRWA_SettingsUpdated:
			rv = TRUE;
		break;

		default: rv = (DoSuperMethodA(cl, obj, (Msg)msg));
	}

	return rv;
}


///
/// PrefsWinUseSettings()

IPTR PrefsWinUseSettings(UNUSED Class *cl, Object *obj, struct PRWP_UseSettings *msg)
{
	xset(obj, MUIA_Window_Open, FALSE);
	DoMethod(_app(obj), MUIM_Application_Save, (IPTR)MUIV_Application_Save_ENV);
	if (msg->Save) DoMethod(_app(obj), MUIM_Application_Save, (IPTR)MUIV_Application_Save_ENVARC);
	xset(obj, PRWA_SettingsUpdated, TRUE);
	return 0;
}


///
/// PrefsWinDispatcher()

IPTR PrefsWinDispatcher(void)
{
	Class *cl = (Class*)REG_A0;
	Object *obj = (Object*)REG_A2;
	Msg msg = (Msg)REG_A1;

	switch (msg->MethodID)
	{
		case OM_NEW:              return PrefsWinNew(cl, obj, (struct opSet*)msg);
		case OM_GET:              return PrefsWinGet(cl, obj, (struct opGet*)msg);
		case PRWM_UseSettings:    return PrefsWinUseSettings(cl, obj, (struct PRWP_UseSettings*)msg);
		default:                  return (DoSuperMethodA(cl, obj, msg));
	}
}

///
