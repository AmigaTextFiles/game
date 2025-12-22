/*
 * boardgadget.c
 * =============
 * The board gadget.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <intuition/gadgetclass.h>
#include <intuition/imageclass.h>
#include <libraries/gadtools.h>

extern ULONG __far RangeSeed;  /* amiga.lib */
extern UWORD __stdargs RangeRand(ULONG); /* amiga.lib */

#include <clib/alib_protos.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/utility.h>

#include "boardgadget.h"
#include "panelgadget.h"
#include "markers.h"


typedef struct {
  UBYTE showSolution;
  Opponent opponent;
  CorrectionMethod corrMethod;
  BYTE activeRow;
  BYTE activeHole;
  UBYTE filledHoles;
  UBYTE guess[10][4];
  UBYTE answer[10][4];
  UBYTE solution[4];
  struct Gadget *panel;
  struct Gadget *enterBtn;
  struct Image *frame;
  struct Image *smallFrame;
  struct Image *largeFrame;
} BoardClassData;


static VOID SetGuess(BoardClassData *data, UBYTE row, UBYTE hole,
		     UBYTE color) {
  data->guess[row][hole] = color;
}


static UBYTE GetGuess(BoardClassData *data, UBYTE row, UBYTE hole) {
  return data->guess[row][hole];
}


static VOID SetAnswer(BoardClassData *data, UBYTE row, UBYTE hole,
		      UBYTE color) {
  data->answer[row][hole] = color;
}


static UBYTE GetAnswer(BoardClassData *data, UBYTE row, UBYTE hole) {
  return data->answer[row][hole];
}


static VOID SetSolution(BoardClassData *data, UBYTE hole, UBYTE color) {
  data->solution[hole] = color;
}


static UBYTE GetSolution(BoardClassData *data, UBYTE hole) {
  return data->solution[hole];
}


static VOID SetMarker(BoardClassData *data, UBYTE row, UBYTE hole,
		      UBYTE color) {
  if (row < 10) {
    SetGuess(data, row, hole, color);
  } else {
    SetSolution(data, hole, color);
  }
}


static UBYTE GetMarker(BoardClassData *data, UBYTE row, UBYTE hole) {
  if (row < 10) {
    return GetGuess(data, row, hole);
  } else {
    return GetSolution(data, hole);
  }
}


static VOID InitGame(BoardClassData *data) {
  UBYTE i, j;

  data->activeRow = (data->opponent == OPPONENT_HUMAN) ? 10 : 0;
  data->activeHole = -1;
  data->filledHoles = 0;
  for (i = 0; i < 10; i++) {
    for (j = 0; j < 4; j++) {
      SetGuess(data, i, j, 0);
      SetAnswer(data, i, j, 0);
    }
  }
  if (data->opponent == OPPONENT_COMPUTER) {
    ULONG numColors;

    GetAttr(PANEL_NumColors, data->panel, &numColors);
    for (i = 0; i < 4; i++) {
      SetSolution(data, i, RangeRand(numColors) + 1);
    }
    data->showSolution = FALSE;
  } else {
    for (i = 0; i < 4; i++) {
      SetSolution(data, i, 0);
    }
    data->showSolution = TRUE;
  }
}


static VOID PlaceLargeMarker(struct Gadget *obj, BoardClassData *data,
			     struct RastPort *rp, struct DrawInfo *dri,
			     BYTE row, BYTE hole, UBYTE color) {
  if (row >= 0 && hole >= 0) {
    DrawLargeMarker(rp, dri,
		    (LONG)obj->LeftEdge - data->frame->LeftEdge +
		    row * (data->largeFrame->Width + INTERWIDTH / 2) -
		    data->largeFrame->LeftEdge,
		    (LONG)obj->TopEdge - data->frame->TopEdge +
		    data->smallFrame->Height + INTERHEIGHT / 2 +
		    hole * (LMARKER_H + INTERHEIGHT / 2) -
		    data->largeFrame->TopEdge,
		    color);
  }
}


static VOID PlaceSmallMarker(struct Gadget *obj, BoardClassData *data,
			     struct RastPort *rp, struct DrawInfo *dri,
			     UBYTE row, UBYTE hole) {
  DrawSmallMarker(rp, dri,
		  (LONG)obj->LeftEdge - data->frame->LeftEdge +
		  row * (data->largeFrame->Width + INTERWIDTH / 2) -
		  data->smallFrame->LeftEdge +
		  (hole > 1) * (data->smallFrame->Width +
				2 * data->smallFrame->LeftEdge - SMARKER_W),
		  (LONG)obj->TopEdge - data->frame->TopEdge -
		  data->smallFrame->TopEdge +
		  (hole & 1) * (data->smallFrame->Height +
				2 * data->smallFrame->TopEdge - SMARKER_H),
		  GetAnswer(data, row, hole));
}


static BOOL CorrectRow(struct Gadget *obj, BoardClassData *data,
		       struct RastPort *rp, struct DrawInfo *dri, UBYTE row) {
  UBYTE i, j;
  UBYTE holeMask1 = 0, holeMask2;
  UBYTE nextHole = 0;
  BOOL correct;

  for (i = 0; i < 4; i++) {
    if (GetGuess(data, row, i) == GetSolution(data, i)) {
      UBYTE hole = ((data->corrMethod == CORRECTION_METHOD_ADULTS) ?
		    nextHole++ : i);

      SetAnswer(data, row, hole, BLACK_COLOR);
      if (rp != NULL) {
	PlaceSmallMarker(obj, data, rp, dri, row, hole);
      }
      holeMask1 |= 1 << i;
    }
  }
  correct = (holeMask1 == 0xF);
  if (!correct) {
    holeMask2 = holeMask1;
    for (i = 0; i < 4; i++) {
      if (!(holeMask1 & (1 << i))) {
	for (j = 0; j < 4; j++) {
	  if (i != j && !(holeMask2 & (1 << j)) &&
	      GetGuess(data, row, i) == GetSolution(data, j)) {
	    UBYTE hole = ((data->corrMethod == CORRECTION_METHOD_ADULTS) ?
			  nextHole++ : i);

	    SetAnswer(data, row, hole, WHITE_COLOR);
	    if (rp != NULL) {
	      PlaceSmallMarker(obj, data, rp, dri, row, hole);
	    }
	    holeMask1 |= 1 << i;
	    holeMask2 |= 1 << j;
	    j = 3;
	  }
	}
      }
    }
  }

  return correct;
}


static BOOL BoardNew(Class *cl, struct Gadget *obj, struct opSet *msg) {
  BoardClassData *data = INST_DATA(cl, obj);
  struct TagItem *ti, *tstate = msg->ops_AttrList;
  struct IBox contentsBox;

  data->opponent = OPPONENT_HUMAN;
  data->corrMethod = CORRECTION_METHOD_ADULTS;
  while ((ti = NextTagItem(&tstate)) != NULL) {
    switch (ti->ti_Tag) {
    case BOARD_Opponent:
      data->opponent = ti->ti_Data;
      break;
    case BOARD_CorrectionMethod:
      data->corrMethod = ti->ti_Data;
      break;
    case BOARD_Panel:
      data->panel = (struct Gadget *)ti->ti_Data;
      break;
    case BOARD_EnterButton:
      data->enterBtn = (struct Gadget *)ti->ti_Data;
      break;
    }
  }
  data->frame = (struct Image *)NewObject(NULL, "frameiclass",
					  IA_EdgesOnly, TRUE,
					  IA_FrameType, FRAME_BUTTON,
					  TAG_DONE);
  data->smallFrame = (struct Image *)NewObject(NULL, "frameiclass",
					       IA_Recessed, TRUE,
					       IA_EdgesOnly, TRUE,
					       IA_FrameType, FRAME_BUTTON,
					       TAG_DONE);
  data->largeFrame = (struct Image *)NewObject(NULL, "frameiclass",
					       IA_Recessed, TRUE,
					       IA_EdgesOnly, TRUE,
					       IA_FrameType, FRAME_BUTTON,
					       TAG_DONE);
  if (data->frame == NULL ||
      data->smallFrame == NULL || data->largeFrame == NULL) {
    return FALSE;
  }

  contentsBox.Left = 0;
  contentsBox.Top = 0;
  contentsBox.Width = LMARKER_W;
  contentsBox.Height = LMARKER_H;
  DoMethod((Object *)data->smallFrame, IM_FRAMEBOX,
	   &contentsBox, IM_BOX(data->smallFrame), NULL, 0);
  contentsBox.Height = 4 * LMARKER_H + 3 * (INTERHEIGHT / 2);
  DoMethod((Object *)data->largeFrame, IM_FRAMEBOX,
	   &contentsBox, IM_BOX(data->largeFrame), NULL, 0);
  contentsBox.Width = 11 * data->largeFrame->Width + 10 * (INTERWIDTH / 2);
  contentsBox.Height = data->smallFrame->Height + INTERHEIGHT / 2 +
    data->largeFrame->Height;
  DoMethod((Object *)data->frame, IM_FRAMEBOX,
	   &contentsBox, IM_BOX(data->frame), NULL, 0);

  obj->Width = data->frame->Width;
  obj->Height = data->frame->Height;

  InitGame(data);

  return TRUE;
}


static VOID BoardDispose(Class *cl, struct Gadget *obj) {
  BoardClassData *data = INST_DATA(cl, obj);

  DisposeObject(data->frame);
  DisposeObject(data->smallFrame);
  DisposeObject(data->largeFrame);
}


static VOID BoardSet(Class *cl, struct Gadget *obj, struct opSet *msg) {
  BoardClassData *data = INST_DATA(cl, obj);
  struct TagItem *ti, *tstate = msg->ops_AttrList;
  struct RastPort *rp;

  while ((ti = NextTagItem(&tstate)) != NULL) {
    switch (ti->ti_Tag) {
    case BOARD_Opponent:
      data->opponent = ti->ti_Data;
      break;
    case BOARD_CorrectionMethod:
      data->corrMethod = ti->ti_Data;
      break;
    case BOARD_NewGame:
      SetGadgetAttrs(data->enterBtn, msg->ops_GInfo->gi_Window,
		     msg->ops_GInfo->gi_Requester,
		     GA_Disabled, TRUE, TAG_DONE);
      InitGame(data);
      rp = ObtainGIRPort(msg->ops_GInfo);
      if (rp != NULL) {
	DoMethod((Object *)obj,
		 GM_RENDER, msg->ops_GInfo, rp, GREDRAW_REDRAW);
	ReleaseGIRPort(rp);
      }
      SetGadgetAttrs(data->panel, msg->ops_GInfo->gi_Window,
		     msg->ops_GInfo->gi_Requester,
		     GA_Disabled, FALSE, TAG_DONE);
      break;
    case BOARD_EnterRow:
      SetGadgetAttrs(data->enterBtn, msg->ops_GInfo->gi_Window,
		     msg->ops_GInfo->gi_Requester,
		     GA_Disabled, TRUE, TAG_DONE);
      SetGadgetAttrs(data->panel, msg->ops_GInfo->gi_Window,
		     msg->ops_GInfo->gi_Requester,
		     PANEL_ActiveColor, 0, TAG_DONE);
      data->activeHole = -1;
      data->filledHoles = 0;
      rp = ObtainGIRPort(msg->ops_GInfo);
      if (data->activeRow == 10) {
	data->activeRow = 0;
	data->showSolution = FALSE;
	if (rp != NULL) {
	  DoMethod((Object *)obj,
		   GM_RENDER, msg->ops_GInfo, rp, GREDRAW_UPDATE);
	}
      } else if (CorrectRow(obj, data, rp, msg->ops_GInfo->gi_DrInfo,
			    data->activeRow) ||
		 ++data->activeRow == 10) {
	SetGadgetAttrs(data->panel, msg->ops_GInfo->gi_Window,
		       msg->ops_GInfo->gi_Requester,
		       GA_Disabled, TRUE, TAG_DONE);
	data->activeRow = -1;
	data->showSolution = TRUE;
	if (rp != NULL) {
	  DoMethod((Object *)obj,
		   GM_RENDER, msg->ops_GInfo, rp, GREDRAW_UPDATE);
	}
      }
      if (rp != NULL) {
	ReleaseGIRPort(rp);
      }
      break;
    }
  }
}


static ULONG BoardHitTest(Class *cl, struct Gadget *obj,
			  struct gpHitTest *msg) {
  WORD x = msg->gpht_Mouse.X;
  WORD y = msg->gpht_Mouse.Y;

  return (ULONG)((x >= 0 && y >= 0 && x < obj->Width && y < obj->Height) ?
		 GMR_GADGETHIT : 0);
}


static VOID RenderSolution(struct Gadget *obj, BoardClassData *data,
			   struct RastPort *rp, struct DrawInfo *dri) {
  UBYTE j;

  DrawImageState(rp, data->largeFrame,
		 (LONG)obj->LeftEdge - data->frame->LeftEdge +
		 10 * (data->largeFrame->Width + INTERWIDTH / 2) -
		 data->smallFrame->LeftEdge,
		 (LONG)obj->TopEdge - data->frame->TopEdge +
		 data->smallFrame->Height + INTERHEIGHT / 2 -
		 data->largeFrame->TopEdge,
		 (data->showSolution ? IDS_NORMAL : IDS_SELECTED), dri);
  if (data->showSolution) {
    for (j = 0; j < 4; j++) {
      PlaceLargeMarker(obj, data, rp, dri, 10, j, GetSolution(data, j));
    }
  } else {
    EraseRect(rp,
	      (LONG)obj->LeftEdge - data->frame->LeftEdge +
	      10 * (data->largeFrame->Width + INTERWIDTH / 2) -
	      data->smallFrame->LeftEdge,
	      (LONG)obj->TopEdge - data->frame->TopEdge +
	      data->smallFrame->Height + INTERHEIGHT / 2 -
	      data->largeFrame->TopEdge,
	      (LONG)obj->LeftEdge - data->frame->LeftEdge +
	      10 * (data->largeFrame->Width + INTERWIDTH / 2) -
	      data->smallFrame->LeftEdge + LMARKER_W - 1,
	      (LONG)obj->TopEdge - data->frame->TopEdge +
	      data->smallFrame->Height + INTERHEIGHT /2 -
	      data->largeFrame->TopEdge +
	      4 * LMARKER_H + 3 * (INTERHEIGHT / 2) - 1);
  }
}


static VOID BoardRender(Class *cl, struct Gadget *obj, struct gpRender *msg) {
  BoardClassData *data = INST_DATA(cl, obj);

  if (msg->gpr_Redraw == GREDRAW_REDRAW) {
    UBYTE i, j;

    DrawImageState(msg->gpr_RPort, data->frame,
		   (LONG)obj->LeftEdge - data->frame->LeftEdge,
		   (LONG)obj->TopEdge - data->frame->TopEdge,
		   IDS_NORMAL, msg->gpr_GInfo->gi_DrInfo);
    for (i = 0; i < 10; i++) {
      DrawImageState(msg->gpr_RPort, data->smallFrame,
		     (LONG)obj->LeftEdge - data->frame->LeftEdge +
		     i * (data->largeFrame->Width + INTERWIDTH / 2) -
		     data->smallFrame->LeftEdge,
		     (LONG)obj->TopEdge - data->frame->TopEdge -
		     data->smallFrame->TopEdge,
		     IDS_NORMAL, msg->gpr_GInfo->gi_DrInfo);
      DrawImageState(msg->gpr_RPort, data->largeFrame,
		     (LONG)obj->LeftEdge - data->frame->LeftEdge +
		     i * (data->largeFrame->Width + INTERWIDTH / 2) -
		     data->largeFrame->LeftEdge,
		     (LONG)obj->TopEdge - data->frame->TopEdge +
		     data->smallFrame->Height + INTERHEIGHT / 2 -
		     data->largeFrame->TopEdge,
		     IDS_NORMAL, msg->gpr_GInfo->gi_DrInfo);
      for (j = 0; j < 4; j++) {
	PlaceSmallMarker(obj, data, msg->gpr_RPort,
			 msg->gpr_GInfo->gi_DrInfo, i, j);
	PlaceLargeMarker(obj, data, msg->gpr_RPort,
			 msg->gpr_GInfo->gi_DrInfo, i, j,
			 GetGuess(data, i, j));
      }
    }
    RenderSolution(obj, data, msg->gpr_RPort, msg->gpr_GInfo->gi_DrInfo);
  } else { /* gpr_Redraw == GREDRAW_UPDATE */
    RenderSolution(obj, data, msg->gpr_RPort, msg->gpr_GInfo->gi_DrInfo);
  }
}


static ULONG UpdateActiveHole(struct Gadget *obj, BoardClassData *data,
			      struct gpInput *msg) {
  ULONG activeColor;
  BYTE newHole;
  WORD x = msg->gpi_Mouse.X;
  WORD y = msg->gpi_Mouse.Y;
  WORD left, top;
  ULONG result;

  left = -data->frame->LeftEdge +
    data->activeRow * (data->largeFrame->Width + INTERWIDTH / 2);
  top = -data->frame->TopEdge + data->smallFrame->Height + INTERHEIGHT / 2;
  if (x >= left && y >= top &&
      x < left + data->largeFrame->Width &&
      y < top + data->largeFrame->Height) {
    newHole = (y - top) / (LMARKER_H + INTERHEIGHT / 2);
    if (newHole > 3) {
      newHole = 3;
    }
  } else {
    newHole = -1;
  }
  GetAttr(PANEL_ActiveColor, data->panel, &activeColor);
  if (newHole != data->activeHole) {
    struct RastPort *rp = ObtainGIRPort(msg->gpi_GInfo);

    if (rp != NULL) {
      PlaceLargeMarker(obj, data, rp, msg->gpi_GInfo->gi_DrInfo,
		       data->activeRow, data->activeHole,
		       GetMarker(data, data->activeRow,
				 data->activeHole));
      PlaceLargeMarker(obj, data, rp, msg->gpi_GInfo->gi_DrInfo,
		       data->activeRow, newHole, (UBYTE)activeColor);
      ReleaseGIRPort(rp);
    }
    data->activeHole = newHole;
  }
  if (msg->gpi_IEvent != NULL) {
    switch (msg->gpi_IEvent->ie_Code) {
    case IECODE_LBUTTON:
      if (data->activeHole != -1 && activeColor != 0) {
	if (GetMarker(data, data->activeRow, data->activeHole) == 0) {
	  data->filledHoles++;
	  if (data->filledHoles == 4) {
	    SetGadgetAttrs(data->enterBtn,
			   msg->gpi_GInfo->gi_Window,
			   msg->gpi_GInfo->gi_Requester,
			   GA_Disabled, FALSE, TAG_DONE);
	  }
	}
	SetMarker(data, data->activeRow, data->activeHole, (UBYTE)activeColor);
      }
      result = GMR_MEACTIVE;
      break;
    case IECODE_RBUTTON:
      if (data->activeHole != -1) {
	if (GetMarker(data, data->activeRow, data->activeHole) != 0) {
	  if (data->filledHoles == 4) {
	    SetGadgetAttrs(data->enterBtn,
			   msg->gpi_GInfo->gi_Window,
			   msg->gpi_GInfo->gi_Requester,
			   GA_Disabled, TRUE, TAG_DONE);
	  }
	  data->filledHoles--;
	}
	SetMarker(data, data->activeRow, data->activeHole, 0);
	result = GMR_MEACTIVE;
      } else {
	result = GMR_REUSE;
      }
      break;
    }
  } else {
    result = GMR_MEACTIVE;
  }

  return result;
}


static ULONG BoardGoActive(Class *cl, struct Gadget *obj,
			   struct gpInput *msg) {
  BoardClassData *data = INST_DATA(cl, obj);

  if (data->activeRow == -1) {
    return GMR_NOREUSE;
  }

  if (msg->gpi_IEvent == NULL) {
    UpdateActiveHole(obj, data, msg);
  }

  return GMR_MEACTIVE;
}


static ULONG BoardHandleInput(Class *cl, struct Gadget *obj,
			      struct gpInput *msg) {
  BoardClassData *data = INST_DATA(cl, obj);
  ULONG result;

  switch (msg->gpi_IEvent->ie_Class) {
  case IECLASS_RAWKEY:
    if ((msg->gpi_IEvent->ie_Qualifier & 0xFF) == IEQUALIFIER_RCOMMAND &&
	!(msg->gpi_IEvent->ie_Code >= 0x60 &&
	  msg->gpi_IEvent->ie_Code <= 0x67)) {
      result = GMR_REUSE;
    }
    break;
  case IECLASS_RAWMOUSE:
    if (GMR_GADGETHIT ==
	DoMethod((Object *)obj, GM_HITTEST, msg->gpi_GInfo, msg->gpi_Mouse)) {
      result = UpdateActiveHole(obj, data, msg);
    } else {
      result = GMR_REUSE;
    }
    break;
  default:
    result = GMR_MEACTIVE;
    break;
  }

  return result;
}


static VOID BoardGoInactive(Class *cl, struct Gadget *obj,
			    struct gpGoInactive *msg) {
  BoardClassData *data = INST_DATA(cl, obj);

  if (data->activeHole != -1) {
    struct RastPort *rp = ObtainGIRPort(msg->gpgi_GInfo);

    if (rp != NULL) {
      PlaceLargeMarker(obj, data, rp, msg->gpgi_GInfo->gi_DrInfo,
		       data->activeRow, data->activeHole,
		       ((data->activeRow < 10) ?
			GetGuess(data, data->activeRow,
				 data->activeHole) :
			GetSolution(data, data->activeHole)));
      ReleaseGIRPort(rp);
    }
    data->activeHole = -1;
  }
}


static ULONG __saveds __asm BoardClassDispatch(register __a0 Class *cl,
					       register __a2 Object *obj,
					       register __a1 Msg msg) {
  ULONG result = 0;

  switch (msg->MethodID) {
  case OM_NEW:
    result = DoSuperMethodA(cl, obj, msg);
    if (result != NULL) {
      if (!BoardNew(cl, (struct Gadget *)result, (struct opSet *)msg)) {
	DoMethod((Object *)result, OM_DISPOSE);
	result = NULL;
      }
    }
    break;
  case OM_DISPOSE:
    BoardDispose(cl, (struct Gadget *)obj);
    DoSuperMethodA(cl, obj, msg);
    break;
  case OM_SET:
    DoSuperMethodA(cl, obj, msg);
    BoardSet(cl, (struct Gadget *)obj, (struct opSet *)msg);
    break;
  case GM_HITTEST:
    result = BoardHitTest(cl, (struct Gadget *)obj, (struct gpHitTest *)msg);
    break;
  case GM_RENDER:
    BoardRender(cl, (struct Gadget *)obj, (struct gpRender *)msg);
    break;
  case GM_GOACTIVE:
    result = BoardGoActive(cl, (struct Gadget *)obj, (struct gpInput *)msg);
    break;
  case GM_HANDLEINPUT:
    result = BoardHandleInput(cl, (struct Gadget *)obj, (struct gpInput *)msg);
    break;
  case GM_GOINACTIVE:
    BoardGoInactive(cl, (struct Gadget *)obj, (struct gpGoInactive *)msg);
    break;
  default:
    result = DoSuperMethodA(cl, obj, msg);
    break;
  }

  return result;
}


Class *CreateBoardClass(VOID) {
  Class *cl;
  ULONG dummy;

  cl = MakeClass(NULL, "gadgetclass", NULL, sizeof(BoardClassData), 0);
  if (cl != NULL) {
    cl->cl_Dispatcher.h_SubEntry = NULL;
    cl->cl_Dispatcher.h_Entry = (HOOKFUNC)BoardClassDispatch;
    cl->cl_Dispatcher.h_Data = NULL;

    CurrentTime(&RangeSeed, &dummy);
  }

  return cl;
}


VOID BoardNewGame(struct Gadget *board, struct Window *win,
		  Opponent opponent, CorrectionMethod corrMethod) {
  SetGadgetAttrs(board, win, NULL,
		 BOARD_Opponent, opponent,
		 BOARD_CorrectionMethod, corrMethod,
		 TAG_DONE);
  SetGadgetAttrs(board, win, NULL, BOARD_NewGame, 0, TAG_DONE);
}


VOID BoardEnterRow(struct Gadget *board, struct Window *win) {
  SetGadgetAttrs(board, win, NULL, BOARD_EnterRow, 0, TAG_DONE);
}
