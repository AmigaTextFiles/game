#include "main.h"
#include <intuition/imageclass.h>
#ifndef USE_TITLEBAR_IMAGE
#include <intuition/sysiclass.h>
#else
#include <titlebar.h>
#include <proto/titlebarimage.h>
#endif

static int CalcIcoOffset (struct Window *win, int32 icow) {
	struct Gadget *gad;
	int32 depw;
	gad = win->FirstGadget;
	while (gad) {
		if ((gad->GadgetType & GTYP_SYSGADGET) &&
			(gad->GadgetType & GTYP_SYSTYPEMASK) == GTYP_WDEPTH)
		{
			depw = gad->Width;
			return icow ? -(icow + depw) : -(depw << 1);
		}
		gad = gad->NextGadget;
	}
	return icow ? -(icow << 1) : -32;
}

void CreateIconifyGadget (display *disp, struct Window *win) {
	DeleteIconifyGadget(disp);
	if (disp->mode & DISP_MODE_FULLSCREEN) return;
	disp->dri = GetScreenDrawInfo(win->WScreen);
	#ifndef USE_TITLEBAR_IMAGE
	disp->icoimg = (struct Image *)NewObject(NULL, "sysiclass",
		SYSIA_DrawInfo,	disp->dri,
		SYSIA_Which,	ICONIFYIMAGE,
		TAG_END);
	#else
	disp->icoimg = (struct Image *)NewObject(ObtainTBIClass(), NULL,
		SYSIA_DrawInfo,	disp->dri,
		SYSIA_Which,	TBIMG_ICONIFYIMAGE,
		TAG_END);
	#endif
	if (disp->icoimg) {
		#ifndef __amigaos4__
		int32 width = 0;
		GetAttr(IA_Width, disp->icoimg, &width);
		#endif
		disp->icogad = (struct Gadget *)NewObject(NULL, "buttongclass",
			GA_ID,			GID_ICONIFY,
			GA_RelVerify,	TRUE,
			GA_Image,		disp->icoimg,
			GA_TopBorder,	TRUE,
			#ifdef __amigaos4__
			GA_RelRight,	0,
			GA_Titlebar,	TRUE,
			#else
			GA_RelRight,	CalcIcoOffset(win, width),
			#endif
			TAG_END);
		if (disp->icogad) {
			AddGadget(win, disp->icogad, ~0);
			return;
		}
	}
	DeleteIconifyGadget(disp);
}

void DeleteIconifyGadget (display *disp) {
	if (disp->icogad) RemoveGadget(disp->win, disp->icogad);
	DisposeObject((Object *)disp->icogad);
	DisposeObject((Object *)disp->icoimg);
	if (disp->dri) FreeScreenDrawInfo(disp->win->WScreen, disp->dri);
	disp->icogad = NULL;
	disp->icoimg = NULL;
	disp->dri = NULL;
}

#ifndef __amigaos4__
struct Window * myOpenWindow (display *disp, struct Screen *scr);
#endif

void DoIconify (display *disp) {
	struct MsgPort *port;
	struct AppIcon *ico;
	struct AppMessage *msg;
	port = CreateMsgPort();
	if (!port) return;
	ico = AddAppIconA(0, 0, PROGNAME, port, (BPTR)NULL, global->icon, NULL);
	if (ico) {
		int done = FALSE;
		#ifdef __amigaos4__
		if (HideWindow(disp->win)) {
		#else
		uint32 idcmp;
		idcmp = disp->win->IDCMPFlags;
		CloseWindow(disp->win);
		disp->win = NULL;
		#endif
		while (!done) {
			WaitPort(port);
			while (msg = (struct AppMessage *)GetMsg(port)) {
				if (msg->am_Type == AMTYPE_APPICON) {
					if (msg->am_Class == AMCLASSICON_Open && msg->am_NumArgs == 0) {
						done = TRUE;
					}
				}
				ReplyMsg((struct Message *)msg);
			}
		}
		#ifdef __amigaos4__
		ShowWindow(disp->win, WINDOW_FRONTMOST);
		}
		#else
		while (!(disp->win = myOpenWindow(disp, disp->scr))) {
			Delay(50);
		}
		AddGadget(disp->win, disp->icogad, ~0);
		VanillaKeys(disp, idcmp & IDCMP_VANILLAKEY);
		#endif
		RemoveAppIcon(ico);
		ActivateWindow(disp->win);
	}
	while (msg = (struct AppMessage *)GetMsg(port)) ReplyMsg((struct Message *)msg);
	DeleteMsgPort(port);
}
