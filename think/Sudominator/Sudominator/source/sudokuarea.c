/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.5  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.edu.pl>             */
/*------------------------------------------*/

/* SudokuAreaClass code. */

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/cybergraphics.h>
#include <proto/utility.h>
#include <devices/rawkeycodes.h>
#include <cybergraphx/cybergraphics.h>

#include <proto/dos.h>

#include "sudokuarea.h"
#include "main.h"
#include "prefswin.h"


struct MUI_CustomClass *SudokuAreaClass;

struct RawKey2Digit
{
	BYTE RawKey;
	BYTE Digit;
};

const struct RawKey2Digit KeyMapping[20] = {
	{ RAWKEY_1, 1 },
	{ RAWKEY_KP_1, 1 },
	{ RAWKEY_2, 2 },
	{ RAWKEY_KP_2, 2 },
	{ RAWKEY_3, 3 },
	{ RAWKEY_KP_3, 3 },
	{ RAWKEY_4, 4 },
	{ RAWKEY_KP_4, 4 },
	{ RAWKEY_5, 5 },
	{ RAWKEY_KP_5, 5 },
	{ RAWKEY_6, 6 },
	{ RAWKEY_KP_6, 6 },
	{ RAWKEY_7, 7 },
	{ RAWKEY_KP_7, 7 },
	{ RAWKEY_8, 8 },
	{ RAWKEY_KP_8, 8 },
	{ RAWKEY_9, 9 },
	{ RAWKEY_KP_9, 9 },
	{ RAWKEY_0, 0 },
	{ RAWKEY_KP_0, 0 }
};

//+ dispatcher prototype

IPTR SudokuAreaDispatcher(void);
const struct EmulLibEntry SudokuAreaGate = {TRAP_LIB, 0, (void(*)(void))SudokuAreaDispatcher};

//-
//+ SudokuAreaData

struct SudokuAreaData
{
	LONG Unit;            // internal size of one square in pixels
	LONG Sudoku[81];      // sudoku table
	LONG Active;          // index of active field
	LONG ToRedraw;        // index of field to be redrawn
	LONG ToRestore;       // index of field redrawn previously
	struct MUI_EventHandlerNode Event;
	BOOL Disabled;
	BOOL Full;            // TRUE if all fields filled
	LONG SudokuPen;       // pen number used for drawing the field
	LONG ActiveEffect;    // darken/brighten depth (negative values for darken).
	LONG PenChange;       // Realloc sudoku pen in the next MUIM_Draw().
	LONG ClickedField;    // Index of field, the LMB has been released over lately.
};


//-
//+ other prototypes

void PrintDigits(struct SudokuAreaData *d, Object *obj);
LONG GetFieldIndex(struct SudokuAreaData *d, Object *obj, LONG x, LONG y);
void RedrawField(struct SudokuAreaData *d, Object *obj, LONG index, LONG color);


//-
//+ MapRawDigit()

BYTE MapRawDigit(UBYTE keycode)
{
	LONG i;

	for (i = 0; i < 20; i++)
	{
		if (KeyMapping[i].RawKey == keycode) return KeyMapping[i].Digit;
	}

	return -1;
}


//-
//+ SudokuIsFull()

BOOL SudokuIsFull(LONG *sudoku)
{
	LONG i;
	BOOL full = TRUE;

	for (i = 0; i < 81; i++)
	{
		if (sudoku[i] == 0)
		{
			full = FALSE;
			break;
		}
	}

	return full;
}


//-
//+ CreateSudokuAreaClass()

struct MUI_CustomClass *CreateSudokuAreaClass(void)
{
	struct MUI_CustomClass *cl;

	cl = MUI_CreateCustomClass(NULL, MUIC_Area, NULL, sizeof(struct SudokuAreaData), (APTR)&SudokuAreaGate);
	SudokuAreaClass = cl;
	return cl;
}


//-
//+ DeleteSudokuAreaClass()

void DeleteSudokuAreaClass(void)
{
	if (SudokuAreaClass) MUI_DeleteCustomClass(SudokuAreaClass);
}


//-

//+ SudokuAreaNew()

IPTR SudokuAreaNew(Class *cl, Object *obj, struct opSet *msg)
{
	IPTR newobj = 0;

	if (obj = DoSuperNewM(cl, obj,
		MUIA_Frame, MUIV_Frame_InputList,
		MUIA_Font, MUIV_Font_Big,
		MUIA_Background, MUII_ListBack,
		MUIA_ShortHelp, LCS(MSG_SUDOKUAREA_HELP, "Select a field with mouse or cursor keys. "
		"Enter digits with keyboard, use 0 or spacebar to clear a field. Use menu to clear the "
		"whole sudoku."),
	TAG_MORE, msg->ops_AttrList))
	{
		struct SudokuAreaData *d = INST_DATA(cl, obj);

		d->Active = 0;
		d->ToRedraw = -1;
		d->ToRestore = -1;
		newobj = (IPTR)obj;
	}

	return newobj;
}


//-
//+ SudokuAreaDispose()

IPTR SudokuAreaDispose(Class *cl, Object *obj, Msg msg)
{
//	  struct SudokuAreaData *d = INST_DATA(cl, obj);

	return DoSuperMethodA(cl, obj, msg);
}


//-
//+ SudokuAreaSet()

IPTR SudokuAreaSet(Class *cl, Object *obj, struct opSet *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);
	struct TagItem *tag, *tagptr = msg->ops_AttrList;
	IPTR tagcnt = 0;

	while (tag = NextTagItem(&tagptr))
	{
		switch (tag->ti_Tag)
		{
			case SUAA_Disabled:
				d->Disabled = tag->ti_Data;
				tagcnt++;
			break;

			case SUAA_Full:
				d->Full = tag->ti_Data;
				tagcnt++;
			break;

			case SUAA_ClickedField:
				d->ClickedField = tag->ti_Data;
				tagcnt++;
			break;
		}
	}

	return tagcnt + DoSuperMethodA(cl, obj, msg);
}


//-
//+ SudokuAreaGet()

IPTR SudokuAreaGet(Class *cl, Object *obj, struct opGet *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	switch (msg->opg_AttrID)
	{
		case SUAA_Full:
			*msg->opg_Storage = d->Full;
		return TRUE;

		case SUAA_ClickedField:
			*msg->opg_Storage = d->ClickedField;
		return TRUE;
	}

	return DoSuperMethodA(cl, obj, msg);
}


//-
//+ SudokuAreaDraw()

IPTR SudokuAreaDraw(Class *cl, Object *obj, struct MUIP_Draw *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);
	struct RastPort *rp = _rp(obj);
	LONG x, y, t, b, l, r;

	DoSuperMethodA(cl, obj, (Msg)msg);

	if (d->PenChange)
	{
		MUI_ReleasePen(muiRenderInfo(obj), d->SudokuPen);
		d->SudokuPen = MUI_ObtainPen(muiRenderInfo(obj), (struct MUI_PenSpec*)xget(PrefsWin, PRWA_SudokuColor), 0);
		d->PenChange = FALSE;
	}

	if (msg->flags & MADF_DRAWOBJECT)
	{
		SetAPen(rp, MUIPEN(d->SudokuPen));

		x = _mleft(obj);
		t = _mtop(obj);
		b = _mbottom(obj);

		RectFill(rp, x, t, x + 1, b);   x += d->Unit + 2;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x + 1, b);   x += d->Unit + 2;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x + 1, b);   x += d->Unit + 2;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x, b);       x += d->Unit + 1;
		RectFill(rp, x, t, x + 1, b);
		
		y = _mtop(obj);
		l = _mleft(obj);
		r = _mright(obj);

		RectFill(rp, l, y, r, y + 1);   y += d->Unit + 2;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y + 1);   y += d->Unit + 2;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y + 1);   y += d->Unit + 2;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y);       y += d->Unit + 1;
		RectFill(rp, l, y, r, y + 1);

		PrintDigits(d, obj);
	}

	if (msg->flags & MADF_DRAWUPDATE)
	{
		if (d->ToRestore >= 0)
		{
			RedrawField(d, obj, d->ToRestore, 0);
			d->ToRestore = -1;
		}

		if (d->ToRedraw >= 0)
		{
			RedrawField(d, obj, d->ToRedraw, 3);
			d->ToRedraw = -1;
		}
	}

	return 0;
}


//-
//+ SudokuAreaAskMinMax()

IPTR SudokuAreaAskMinMax(Class *cl, Object *obj, struct MUIP_AskMinMax *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);
	LONG dim;

	DoSuperMethodA(cl, obj, (Msg)msg);

	d->Unit = _font(obj)->tf_YSize;
	dim = d->Unit * 9 + 14;

	msg->MinMaxInfo->MinWidth += dim;
	msg->MinMaxInfo->DefWidth += dim;
	msg->MinMaxInfo->MaxWidth += dim;

	msg->MinMaxInfo->MinHeight += dim;
	msg->MinMaxInfo->DefHeight += dim;
	msg->MinMaxInfo->MaxHeight += dim;

	return 0;
}


//-
//+ SudokuAreaSetup()

IPTR SudokuAreaSetup(Class *cl, Object *obj, Msg msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	if (DoSuperMethodA(cl, obj, (Msg)msg))
	{
		d->Event.ehn_Priority = 1;
		d->Event.ehn_Flags = 0;
		d->Event.ehn_Events = IDCMP_MOUSEMOVE | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS;
		d->Event.ehn_Object = obj;
		d->Event.ehn_Class = cl;
		DoMethod(_win(obj), MUIM_Window_AddEventHandler, (IPTR)&d->Event);
		d->SudokuPen = MUI_ObtainPen(muiRenderInfo(obj), (struct MUI_PenSpec*)xget(PrefsWin, PRWA_SudokuColor), 0);
		d->ActiveEffect = xget(PrefsWin, PRWA_EffectDepth);
		return TRUE;
	}

	return FALSE;
}


//-
//+ SudokuAreaCleanup()

IPTR SudokuAreaCleanup(Class *cl, Object *obj, Msg msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	MUI_ReleasePen(muiRenderInfo(obj), d->SudokuPen);
	DoMethod(_win(obj), MUIM_Window_RemEventHandler, (IPTR)&d->Event);

	return DoSuperMethodA(cl, obj, msg);
}


//-
//+ SudokuAreaHandleEvent()

IPTR SudokuAreaHandleEvent(Class *cl, Object *obj, struct MUIP_HandleEvent *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);
	LONG active = 0;
	LONG result = 0;

	if (msg->muikey != MUIKEY_NONE)
	{
		BOOL draw = FALSE;
		LONG b;

		if (!d->Disabled)
		{
			draw = TRUE;
			result = MUI_EventHandlerRC_Eat;

			switch (msg->muikey)
			{
				case MUIKEY_UP:
					active = (d->Active + 72) % 81;
				break;
				
				case MUIKEY_DOWN:
					active = (d->Active + 9) % 81;
				break;

				case MUIKEY_LEFT:
					b = d->Active / 9;
					active = d->Active + 8;
					if (active / 9 > b) active -= 9;
				break;
			
				case MUIKEY_RIGHT:
					b = d->Active / 9;
					active = d->Active + 1;
					if (active / 9 > b) active -= 9;
				break;

				case MUIKEY_TOGGLE:
					DoMethod(obj, SUAM_SetField, 0, d->Active);
					if (d->Active >= 0) active = (d->Active + 1) % 81;
					else draw = FALSE;
				break;

				default:
					draw = FALSE;
					result = 0;
				break;
			}
		}

		if (draw)
		{
			d->Active = active;
			d->ToRedraw = active;
			MUI_Redraw(obj, MADF_DRAWUPDATE);
			d->ToRestore = active;
		}
	}

	if (msg->imsg)
	{
		if (msg->imsg->Class == IDCMP_MOUSEMOVE)
		{
			LONG mx = msg->imsg->MouseX;
			LONG my = msg->imsg->MouseY;

			active = GetFieldIndex(d, obj, mx, my);

			if (!d->Disabled && (active != d->Active))
			{
				d->Active = active;
				d->ToRedraw = active;
				MUI_Redraw(obj, MADF_DRAWUPDATE);
				d->ToRestore = active;
			}
		}
		else if (msg->imsg->Class == IDCMP_RAWKEY)
		{
			UBYTE rawkey = msg->imsg->Code;
			BYTE digit;

			if (!d->Disabled)
			{
				digit = MapRawDigit(rawkey);

				if (digit >= 0)
				{
					if (d->Active >= 0)
					{
						DoMethod(obj, SUAM_SetField, digit, d->Active);
						d->Active = (d->Active + 1) % 81;
						d->ToRedraw = d->Active;
						MUI_Redraw(obj, MADF_DRAWUPDATE);
						d->ToRestore = d->Active;
					}

					result = MUI_EventHandlerRC_Eat;
				}
			}
		}
		else if (msg->imsg->Class == IDCMP_MOUSEBUTTONS)
		{
			if (msg->imsg->Code == IECODE_LBUTTON | IECODE_UP_PREFIX)
			{
				LONG mx = msg->imsg->MouseX;
				LONG my = msg->imsg->MouseY;

				active = GetFieldIndex(d, obj, mx, my);

				if (!d->Disabled && (active >= 0)) xset(obj, SUAA_ClickedField, active);
			}
		}
	}

	return result;
}


//-
//+ SudokuAreaSetField()

IPTR SudokuAreaSetField(Class *cl, Object *obj, struct SUAP_SetField *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	if ((LONG)msg->Index >= 0) d->Sudoku[msg->Index] = msg->Value;

	d->ToRedraw = (LONG)msg->Index;
	MUI_Redraw(obj, MADF_DRAWUPDATE);
	d->ToRestore = (LONG)msg->Index;
	xset(obj, SUAA_Full, (LONG)SudokuIsFull(d->Sudoku));

	return 0;
}


//-
//+ SudokuAreaGetSudoku()

IPTR SudokuAreaGetSudoku(Class *cl, Object *obj, struct SUAP_GetSudoku *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	CopyMem(d->Sudoku, msg->Field, 81 * sizeof(LONG));

	return 0;
}


//-
//+ SudokuAreaSetSudoku()

IPTR SudokuAreaSetSudoku(Class *cl, Object *obj, struct SUAP_SetSudoku *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	CopyMem(msg->Field, d->Sudoku, 81 * sizeof(LONG));
	MUI_Redraw(obj, MADF_DRAWOBJECT);
	xset(obj, SUAA_Full, (LONG)SudokuIsFull(d->Sudoku));

	return 0;
}


//-
//+ SudokuAreaUpdate()

IPTR SudokuAreaUpdate(Class *cl, Object *obj)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	d->PenChange = TRUE;
	d->ActiveEffect = xget(PrefsWin, PRWA_EffectDepth);
	MUI_Redraw(obj, MADF_DRAWOBJECT);

	return 0;
}


//-
//+ SudokuAreaFlashOneField()

IPTR SudokuAreaFlashOneField(Class *cl, Object *obj, struct SUAP_FlashOneField *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);
	LONG f, x, i;
	
	f = msg->Field;
	x = d->Sudoku[f];
		
	for (i = 0; i < 3; i++)
	{
		Delay(6);
		d->Sudoku[f] = 0;
		d->ToRestore = f;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
		Delay(6);
		d->Sudoku[f] = x;
		d->ToRestore = f;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
	}
	
	return 0;
}


//-
//+ SudokuAreaFlashTwoFields()

IPTR SudokuAreaFlashTwoFields(Class *cl, Object *obj, struct SUAP_FlashTwoFields *msg)
{
	struct SudokuAreaData *d = INST_DATA(cl, obj);

	LONG f1, f2, x1, x2, i;
	
	f1 = msg->Field1;
	f2 = msg->Field2;
	x1 = d->Sudoku[f1];
	x2 = d->Sudoku[f2];
		
	for (i = 0; i < 3; i++)
	{
		Delay(11);
		d->Sudoku[f1] = 0;
		d->ToRestore = f1;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
		d->Sudoku[f2] = 0;
		d->ToRestore = f2;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
		Delay(11);
		d->Sudoku[f1] = x1;
		d->ToRestore = f1;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
		d->Sudoku[f2] = x2;
		d->ToRestore = f2;
		MUI_Redraw(obj, MADF_DRAWUPDATE);
	}

	return 0;
}


//-

//+ SudokuAreaDispatcher()

IPTR SudokuAreaDispatcher(void)
{
	Class *cl = (Class*)REG_A0;
	Object *obj = (Object*)REG_A2;
	Msg msg = (Msg)REG_A1;
	switch (msg->MethodID)
	{
		case OM_NEW:               return (SudokuAreaNew(cl, obj, (struct opSet*)msg));
		case OM_DISPOSE:           return (SudokuAreaDispose(cl, obj, msg));
		case OM_SET:               return (SudokuAreaSet(cl, obj, (struct opSet*)msg));
		case OM_GET:               return (SudokuAreaGet(cl, obj, (struct opGet*)msg));
		case MUIM_Draw:            return (SudokuAreaDraw(cl, obj, (struct MUIP_Draw*)msg));
		case MUIM_AskMinMax:       return (SudokuAreaAskMinMax(cl, obj, (struct MUIP_AskMinMax*)msg));
		case MUIM_Setup:           return (SudokuAreaSetup(cl, obj, msg));
		case MUIM_Cleanup:         return (SudokuAreaCleanup(cl, obj, msg));
		case MUIM_HandleEvent:     return (SudokuAreaHandleEvent(cl, obj, (struct MUIP_HandleEvent*)msg));
		case SUAM_SetField:        return (SudokuAreaSetField(cl, obj, (struct SUAP_SetField*)msg));
		case SUAM_GetSudoku:       return (SudokuAreaGetSudoku(cl, obj, (struct SUAP_GetSudoku*)msg));
		case SUAM_SetSudoku:       return (SudokuAreaSetSudoku(cl, obj, (struct SUAP_SetSudoku*)msg));
		case SUAM_Update:          return (SudokuAreaUpdate(cl, obj));
		case SUAM_FlashOneField:   return (SudokuAreaFlashOneField(cl, obj, (struct SUAP_FlashOneField*)msg));
		case SUAM_FlashTwoFields:  return (SudokuAreaFlashTwoFields(cl, obj, (struct SUAP_FlashTwoFields*)msg));
		default:                   return (DoSuperMethodA(cl, obj, msg));
	}
}


//-

//+ PrintDigits()

void PrintDigits(struct SudokuAreaData *d, Object *obj)
{
	LONG x, y, xp, yp, len;
	struct RastPort *rp = _rp(obj);

	yp = _mtop(obj) + _font(obj)->tf_Baseline + 1;
	SetFont(rp, _font(obj));

	for (y = 0; y < 9; y++)
	{
		if (y % 3 == 0) yp++;
		xp = _mleft(obj) + 2;

		for (x = 0; x < 9; x++)
		{
			UBYTE c = d->Sudoku[y * 9 + x] + '0';

			if (x % 3 == 0) xp++;

			if (c > '0')
			{
				len = TextLength(rp, &c, 1);
				Move(rp, xp + ((d->Unit - len) >> 1), yp);
				Text(rp, &c, 1);
			}

			xp += d->Unit + 1;
		}

		yp += d->Unit + 1;
	}
}


//-
//+ GetFieldIndex()

LONG GetFieldIndex(struct SudokuAreaData *d, Object *obj, LONG x, LONG y)
{
	LONG i, ix, iy = 0;

	x -= _mleft(obj);
	y -= _mtop(obj);

	for (i = 0; i < 10; i++)
	{
		ix = i;
		if ((x > 1) && (x < d->Unit + 2)) break;
		x -= d->Unit + 1;
		if (i % 3 == 2) x--;
	}

	if (ix > 8) return -1;

	for (i = 0; i < 10; i++)
	{
		iy = i;
		if ((y > 1) && (y < d->Unit + 2)) break;
		y -= d->Unit + 1;
		if (i % 3 == 2) y--;
	}

	if (iy > 8) return -1;

	return ix + iy * 9;
}


//-
//+ RedrawField()

#define MUIMRI_FASTPPA (1<<7) /* Set if screen has HW accelerated ProcessPixelArray(). */

void RedrawField(struct SudokuAreaData *d, Object *obj, LONG index, LONG color)
{
	LONG x, y;
	UBYTE c;
	struct RastPort *rp = _rp(obj);

	x = index % 9;
	y = index / 9;
	x = _mleft(obj) + 2 + x * (d->Unit + 1) + x / 3;
	y = _mtop(obj) + 2 + y * (d->Unit + 1) + y / 3;

	if (color)
	{
		if (muiRenderInfo(obj)->mri_Flags & MUIMRI_FASTPPA)
		{
			LONG effect = (d->ActiveEffect >= 0) ? POP_BRIGHTEN : POP_DARKEN;
			LONG depth = (d->ActiveEffect >= 0) ? d->ActiveEffect : -d->ActiveEffect;

			DoMethod(obj, MUIM_DrawBackground, x, y, d->Unit, d->Unit, 0, 0, 0);
			ProcessPixelArray(rp, x, y, d->Unit, d->Unit, effect, depth, NULL);
		}
		else
		{
			SetAPen(rp, color);
			RectFill(rp, x, y, x + d->Unit - 1, y + d->Unit - 1);
		}
	}
	else DoMethod(obj, MUIM_DrawBackground, x, y, d->Unit, d->Unit, 0, 0, 0);

	SetAPen(rp, MUIPEN(d->SudokuPen));
	c = d->Sudoku[index] + '0';

	if (c > '0')
	{
		SetFont(rp, _font(obj));
		Move(rp, x + ((d->Unit - TextLength(rp, &c, 1)) >> 1) + 1, y + _font(obj)->tf_Baseline);
		Text(rp, &c, 1);
	}
}


//-

