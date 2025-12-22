/*
 * panelgadget.c
 * =============
 * The panel gadget.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <intuition/gadgetclass.h>
#include <libraries/gadtools.h>

#include <clib/alib_protos.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/utility.h>

#include "panelgadget.h"
#include "markers.h"


typedef struct {
  UBYTE numColors;
  UBYTE activeColor;
  UBYTE nextColor;
} PanelClassData;


static BOOL PanelNew(Class *cl, struct Gadget *obj, struct opSet *msg) {
  PanelClassData *data = INST_DATA(cl, obj);
  struct TagItem *ti, *tstate = msg->ops_AttrList;

  data->numColors = 6;
  data->activeColor = data->nextColor = 0;
  while ((ti = NextTagItem(&tstate)) != NULL) {
    switch (ti->ti_Tag) {
    case PANEL_NumColors:
      data->numColors = ti->ti_Data;
      break;
    case PANEL_ActiveColor:
      data->activeColor = ti->ti_Data;
      break;
    }
  }
  obj->Width = 8 * (LMARKER_W + INTERWIDTH) - INTERWIDTH;
  obj->Height = LMARKER_H;

  return TRUE;
}


static VOID PanelSet(Class *cl, struct Gadget *obj, struct opSet *msg) {
  PanelClassData *data = INST_DATA(cl, obj);
  struct TagItem *ti, *tstate = msg->ops_AttrList;
  struct RastPort *rp;

  while ((ti = NextTagItem(&tstate)) != NULL) {
    switch (ti->ti_Tag) {
    case PANEL_NumColors:
      rp = ObtainGIRPort(msg->ops_GInfo);
      if (rp != NULL) {
	if (ti->ti_Data < data->numColors) {
	  EraseRect(rp,
		    (LONG)obj->LeftEdge +
		    ti->ti_Data * (LMARKER_W + INTERWIDTH),
		    (LONG)obj->TopEdge,
		    (LONG)obj->LeftEdge + obj->Width - 1,
		    (LONG)obj->TopEdge + obj->Height - 1);
	}
	if (ti->ti_Data != data->numColors) {
	  data->numColors = ti->ti_Data;
	  data->activeColor = 0;
	  DoMethod((Object *)obj,
		   GM_RENDER, msg->ops_GInfo, rp, GREDRAW_REDRAW);
	} else {
	  data->nextColor = 0;
	  DoMethod((Object *)obj,
		   GM_RENDER, msg->ops_GInfo, rp, GREDRAW_UPDATE);
	  data->activeColor = 0;
	}
	ReleaseGIRPort(rp);
      } else {
	data->numColors = ti->ti_Data;
	data->activeColor = 0;
      }
      break;
    case PANEL_ActiveColor:
      if (ti->ti_Data != data->activeColor) {
	data->nextColor = ti->ti_Data;
	rp = ObtainGIRPort(msg->ops_GInfo);
	if (rp != NULL) {
	  DoMethod((Object *)obj,
		   GM_RENDER, msg->ops_GInfo, rp, GREDRAW_UPDATE);
	  ReleaseGIRPort(rp);
	}
	data->activeColor = data->nextColor;
      }
      break;
    }
  }
}


static BOOL PanelGet(Class *cl, struct Gadget *obj, struct opGet *msg) {
  PanelClassData *data = INST_DATA(cl, obj);

  switch (msg->opg_AttrID) {
  case PANEL_NumColors:
    *msg->opg_Storage = (ULONG)data->numColors;
    break;
  case PANEL_ActiveColor:
    *msg->opg_Storage = (ULONG)data->activeColor;
    break;
  default:
    return FALSE;
  }

  return TRUE;
}


static VOID PanelRender(Class *cl, struct Gadget *obj, struct gpRender *msg) {
  PanelClassData *data = INST_DATA(cl, obj);

  if (msg->gpr_Redraw == GREDRAW_REDRAW) {
    UBYTE i;

    for (i = 0; i < data->numColors; i++) {
      DrawLargeMarker(msg->gpr_RPort, msg->gpr_GInfo->gi_DrInfo,
		      (LONG)obj->LeftEdge + i * (LMARKER_W + INTERWIDTH),
		      (LONG)obj->TopEdge + (obj->Height - LMARKER_H) / 2,
		      ((i + 1 == data->activeColor) ? 0 : i + 1));
    }
  } else { /* gpr_Redraw == GREDRAW_UPDATE */
    if (data->activeColor != 0) {
      DrawLargeMarker(msg->gpr_RPort, msg->gpr_GInfo->gi_DrInfo,
		      (LONG)obj->LeftEdge +
		      (data->activeColor - 1) * (LMARKER_W + INTERWIDTH),
		      (LONG)obj->TopEdge + (obj->Height - LMARKER_H) / 2,
		      data->activeColor);
    }
    if (data->nextColor != 0) {
      DrawLargeMarker(msg->gpr_RPort, msg->gpr_GInfo->gi_DrInfo,
		      (LONG)obj->LeftEdge +
		      (data->nextColor - 1) * (LMARKER_W + INTERWIDTH),
		      (LONG)obj->TopEdge + (obj->Height - LMARKER_H) / 2,
		      0);
    }
  }
}


static ULONG PanelHitTest(Class *cl, struct Gadget *obj,
			  struct gpHitTest *msg) {
  PanelClassData *data = INST_DATA(cl, obj);
  WORD x = msg->gpht_Mouse.X;
  WORD y = msg->gpht_Mouse.Y;
  WORD d;

  d = (obj->Height - LMARKER_H) / 2;
  if (y < d || y >= d + LMARKER_H) {
    return 0;
  }
  d = x / (LMARKER_W + INTERWIDTH);
  if (d >= data->numColors || x - d * (LMARKER_W + INTERWIDTH) >= LMARKER_W) {
    return 0;
  }

  return GMR_GADGETHIT;
}


static ULONG PanelGoActive(Class *cl, struct Gadget *obj,
			   struct gpInput *msg) {
  PanelClassData *data = INST_DATA(cl, obj);

  if (msg->gpi_IEvent != NULL) {
    data->nextColor = msg->gpi_Mouse.X / (LMARKER_W + INTERWIDTH) + 1;
    if (data->nextColor != data->activeColor) {
      struct RastPort *rp;

      rp = ObtainGIRPort(msg->gpi_GInfo);
      if (rp != NULL) {
	DoMethod((Object *)obj,
		 GM_RENDER, msg->gpi_GInfo, rp, GREDRAW_UPDATE);
	ReleaseGIRPort(rp);
      }
      data->activeColor = data->nextColor;
    }
  }

  return GMR_NOREUSE;
}


static ULONG __saveds __asm PanelClassDispatch(register __a0 Class *cl,
					       register __a2 Object *obj,
					       register __a1 Msg msg) {
  ULONG result = 0;

  switch (msg->MethodID) {
  case OM_NEW:
    result = DoSuperMethodA(cl, obj, msg);
    if (result != NULL) {
      if (!PanelNew(cl, (struct Gadget *)result, (struct opSet *)msg)) {
	DoMethod((Object *)result, OM_DISPOSE);
	result = NULL;
      }
    }
    break;
  case OM_SET:
    DoSuperMethodA(cl, obj, msg);
    PanelSet(cl, (struct Gadget *)obj, (struct opSet *)msg);
    break;
  case OM_GET:
    if (PanelGet(cl, (struct Gadget *)obj, (struct opGet *)msg)) {
      result = 1;
    } else {
      result = DoSuperMethodA(cl, obj, msg);
    }
    break;
  case GM_RENDER:
    PanelRender(cl, (struct Gadget *)obj, (struct gpRender *)msg);
    break;
  case GM_HITTEST:
    result = PanelHitTest(cl, (struct Gadget *)obj, (struct gpHitTest *)msg);
    break;
  case GM_GOACTIVE:
    result = PanelGoActive(cl, (struct Gadget *)obj, (struct gpInput *)msg);
    break;
  default:
    result = DoSuperMethodA(cl, obj, msg);
    break;
  }

  return result;
}


Class *CreatePanelClass(VOID) {
  Class *cl;

  cl = MakeClass(NULL, "gadgetclass", NULL, sizeof(PanelClassData), 0);
  if (cl != NULL) {
    cl->cl_Dispatcher.h_SubEntry = NULL;
    cl->cl_Dispatcher.h_Entry = (HOOKFUNC)PanelClassDispatch;
    cl->cl_Dispatcher.h_Data = NULL;
  }

  return cl;
}
