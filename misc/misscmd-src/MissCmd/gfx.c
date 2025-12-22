#include "main.h"
#include <proto/layers.h>

#ifndef __amigaos4__
struct BackFillMessage
{
    struct Layer     *Layer;
    struct Rectangle  Bounds;
    LONG              OffsetX;
    LONG              OffsetY;
};
#endif

static struct Screen * myOpenScreen (display *disp);
struct Window * myOpenWindow (display *disp, struct Screen *scr);

static void CheckRGBMode (display *disp);

display *CreateDisplay () {
	display *disp;
	int32 width, height;

	disp = AllocMem(sizeof(*disp), MEMF_ANY|MEMF_CLEAR);
	if (!disp) return NULL;

	if (CFGBoolean("FULLSCREEN")) disp->mode |= DISP_MODE_FULLSCREEN;

	width = CFGInteger("WIDTH", 640);
	height = CFGInteger("HEIGHT", 480);
	disp->bm = p96AllocBitMap(width, height, 32, BMF_USERPRIVATE, NULL, RGBFB_A8R8G8B8);
	disp->db = CreateGfxFromBitMap(disp->bm);
	if (disp->db) {
		#if 0
		ClearDB(disp);
		#else
		memset(disp->db->gfx, 0, disp->db->height * disp->db->bpr);
		#endif
		disp->cliprect.x1 = 0;
		disp->cliprect.y1 = 0;
		disp->cliprect.x2 = width-1;
		disp->cliprect.y2 = height-1;

		disp->my_rp = AllocMem(sizeof(struct RastPort), MEMF_ANY);
		if (disp->my_rp) {
			InitRastPort(disp->my_rp);
			disp->my_rp->BitMap = disp->bm;

			if (disp->mode & DISP_MODE_FULLSCREEN) {
				disp->scr = myOpenScreen(disp);
				if (disp->scr) disp->win = myOpenWindow(disp, disp->scr);
			} else {
				disp->scr = NULL;
				disp->win = myOpenWindow(disp, NULL);
			}
			if (disp->win) {
				CreateIconifyGadget(disp, disp->win);
				disp->rp = disp->win->RPort;

				disp->bounds.MinX = disp->win->BorderLeft;
				disp->bounds.MinY = disp->win->BorderTop;
				disp->bounds.MaxX = disp->win->Width-disp->win->BorderRight-1;
				disp->bounds.MaxY = disp->win->Height-disp->win->BorderBottom-1;

				CheckRGBMode(disp);
				disp->showdb(disp);
				return disp;
			}
		}
	}
	DeleteDisplay(disp);
	return NULL;
}

void DeleteDisplay (display *disp) {
	if (!disp) return;
	if (disp->win) {
		DeleteIconifyGadget(disp);
		CloseWindow(disp->win);
	}
	if (disp->scr) p96CloseScreen(disp->scr);
	if (disp->my_rp) FreeMem(disp->my_rp, sizeof(struct RastPort));
	if (disp->db) FreeGfx(disp->db);
	if (disp->bm) p96FreeBitMap(disp->bm);
	FreeMem(disp, sizeof(*disp));
}

void ToggleFullscreen (display *disp) {
	struct Screen *scr;
	struct Window *win;
	if (disp->mode & DISP_MODE_FULLSCREEN) {
		scr = NULL;
		win = myOpenWindow(disp, NULL);
	} else {
		scr = myOpenScreen(disp);
		if (scr)
			win = myOpenWindow(disp, scr);
		else
			win = NULL;
	}
	if (win) {
		disp->mode ^= DISP_MODE_FULLSCREEN;
		CreateIconifyGadget(disp, win);
		CloseWindow(disp->win);
		if (disp->scr) p96CloseScreen(disp->scr);

		disp->scr = scr;
		disp->win = win;
		disp->rp = disp->win->RPort;

		disp->bounds.MinX = disp->win->BorderLeft;
		disp->bounds.MinY = disp->win->BorderTop;
		disp->bounds.MaxX = disp->win->Width-disp->win->BorderRight-1;
		disp->bounds.MaxY = disp->win->Height-disp->win->BorderBottom-1;

		CheckRGBMode(disp);
		disp->showdb(disp);
		return;
	}
	ScreenToFront(disp->win->WScreen);
	if (scr) p96CloseScreen(scr);
}

static struct Screen * myOpenScreen (display *disp) {
	uint16 pens[] = {~0};
	return p96OpenScreenTags(
				P96SA_Title,		VERS,
				P96SA_ShowTitle,	FALSE,
				P96SA_Width,		disp->db->width,
				P96SA_Height,		disp->db->height,
				P96SA_Depth,		CFGInteger("DEPTH", 32),
				P96SA_Pens,		pens,
				TAG_END);
}

struct Window * myOpenWindow (display *disp, struct Screen *scr) {
	struct Screen *pubscr = NULL;
	struct Window *win;
	uint32 wtags[] = {
		WA_PubScreen,		(uint32)NULL,
		WA_Title,				(uint32)VERS,
		WA_Left,				0,
		WA_Top,				0,
		WA_InnerWidth,		0,
		WA_InnerHeight,		0,
		WA_Flags,			WFLG_NOCAREREFRESH|WFLG_ACTIVATE|WFLG_REPORTMOUSE|WFLG_CLOSEGADGET|WFLG_DRAGBAR|WFLG_DEPTHGADGET,
		WA_IDCMP,			IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY|IDCMP_MOUSEMOVE|IDCMP_CLOSEWINDOW|IDCMP_GADGETUP,
		TAG_END
	};
	char *ref;

	wtags[2*4+1] = disp->db->width;
	wtags[2*5+1] = disp->db->height;

	if (scr) {
		wtags[2*0] = WA_CustomScreen;
		wtags[2*0+1] = (uint32)scr;
		wtags[2*1] = TAG_IGNORE;
		wtags[2*6+1] = WFLG_NOCAREREFRESH|WFLG_ACTIVATE|WFLG_REPORTMOUSE|WFLG_BACKDROP|WFLG_BORDERLESS;
		wtags[2*7+1] = IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY|IDCMP_MOUSEMOVE;
	} else {
		char *title;
		title = CFGString("PUBSCREEN", "");
		if (title[0] == '\0') title = NULL;
		pubscr = LockPubScreen(title);
		wtags[2*0+1] = (uint32)pubscr;
		if (pubscr) {
			wtags[2*2+1] = (pubscr->Width - (disp->db->width + pubscr->WBorLeft
				+ pubscr->WBorRight)) >> 1;
			wtags[2*3+1] = (pubscr->Height - (disp->db->height + pubscr->WBorTop
				+ pubscr->Font->ta_YSize + 1 + pubscr->WBorBottom)) >> 1;
		}
	}

	ref = CFGString("REFRESH", "");
	if (!stricmp(ref, "SIMPLE"))
		wtags[2*6+1] |= WFLG_SIMPLE_REFRESH;
	else if (!stricmp(ref, "SMART"))
		wtags[2*6+1] |= WFLG_SMART_REFRESH;

	//Printf("IDCMP: %08lx\n", wtags[2*7+1]);
	win = OpenWindowTagList(NULL, (struct TagItem *)wtags);
	if (win) {
		ScreenToFront(win->WScreen);
	}
	UnlockPubScreen(NULL, pubscr);
	return win;
}

void ShowDB_generic (display *disp);
void ShowDB_dohookcliprects (display *disp);

uint32 RenderARGB32 (REG(a0, struct Hook *hook), REG(a2, struct RastPort *rp),
	REG(a1, struct BackFillMessage *msg));
uint32 RenderBGRA32 (REG(a0, struct Hook *hook), REG(a2, struct RastPort *rp),
	REG(a1, struct BackFillMessage *msg));

static void CheckRGBMode (display *disp) {
	uint32 rgbfmt;
	rgbfmt = p96GetBitMapAttr(disp->rp->BitMap, P96BMA_RGBFORMAT);

	disp->ri.Memory = disp->db->gfx;
	disp->ri.BytesPerRow = disp->db->bpr;
	disp->ri.RGBFormat = RGBFB_A8R8G8B8;

	switch (rgbfmt) {
		case RGBFB_A8R8G8B8:
			disp->rh.h_Entry = (HOOKFUNC)RenderARGB32;
			disp->rh.h_Data = disp;
			disp->showdb = ShowDB_dohookcliprects;
			break;
		case RGBFB_B8G8R8A8:
			disp->rh.h_Entry = (HOOKFUNC)RenderBGRA32;
			disp->rh.h_Data = disp;
			disp->showdb = ShowDB_dohookcliprects;
			break;
		default:
			disp->showdb = ShowDB_generic;
			break;
	}
}

void ShowDB_generic (display *disp) {
	p96WritePixelArray(&disp->ri, 0, 0, disp->rp, disp->bounds.MinX, disp->bounds.MinY, disp->db->width, disp->db->height);
}

void ShowDB_dohookcliprects (display *disp) {
	DoHookClipRects(&disp->rh, disp->rp, &disp->bounds);
}

uint32 RenderARGB32 (REG(a0, struct Hook *hook), REG(a2, struct RastPort *rp),
	REG(a1, struct BackFillMessage *msg))
{
	struct RenderInfo ri;
	uint32 lock;
	display *disp = (display *)hook->h_Data;

	int32 sx = msg->OffsetX - disp->bounds.MinX;
	int32 sy = msg->OffsetY - disp->bounds.MinY;
	int32 width = msg->Bounds.MaxX - msg->Bounds.MinX + 1;
	int32 height = msg->Bounds.MaxY - msg->Bounds.MinY + 1;

	uint8 *src, *dst;
	int32 len;
	int32 src_mod, dst_mod;

	int32 x, y;

	lock = p96LockBitMap(rp->BitMap, (uint8 *)&ri, sizeof(struct RenderInfo));

	src = (uint8 *)disp->db->gfx + (sy * disp->db->bpr) + (sx << 2);
	dst = (uint8 *)ri.Memory + (msg->Bounds.MinY * ri.BytesPerRow) + (msg->Bounds.MinX << 2);
	len = width<<2;
	src_mod = disp->db->bpr; //- len;
	dst_mod = ri.BytesPerRow; //- len;

	for (y = 0; y < height; y++) {
		/*for (x = 0; x < width; x++) {
			*(uint32 *)dst = *(uint32 *)src;
			dst += 4; src += 4;
		}*/
		memcpy(dst, src, len);
		dst += dst_mod;
		src += src_mod;
	}

	p96UnlockBitMap(rp->BitMap, lock);

	return 0;
}

uint32 RenderBGRA32 (REG(a0, struct Hook *hook), REG(a2, struct RastPort *rp),
	REG(a1, struct BackFillMessage *msg))
{
	struct RenderInfo ri;
	uint32 lock;
	display *disp = (display *)hook->h_Data;

	int32 sx = msg->OffsetX - disp->bounds.MinX;
	int32 sy = msg->OffsetY - disp->bounds.MinY;
	int32 width = msg->Bounds.MaxX - msg->Bounds.MinX + 1;
	int32 height = msg->Bounds.MaxY - msg->Bounds.MinY + 1;

	uint8 *src, *dst;
	int32 src_mod, dst_mod;

	int32 x, y;

	lock = p96LockBitMap(rp->BitMap, (uint8 *)&ri, sizeof(struct RenderInfo));

	src = (uint8 *)disp->db->gfx + (sy * disp->db->bpr) + (sx << 2);
	dst = (uint8 *)ri.Memory + (msg->Bounds.MinY * ri.BytesPerRow) + (msg->Bounds.MinX << 2);
	src_mod = disp->db->bpr - (width << 2);
	dst_mod = ri.BytesPerRow - (width << 2);

	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			write_le32((uint32 *)dst, *(uint32 *)src);
			dst += 4; src += 4;
		}
		dst += dst_mod;
		src += src_mod;
	}

	p96UnlockBitMap(rp->BitMap, lock);

	return 0;
}

#if 0
void ClearDB (display *disp) {
	uint8 *ras;
	int32 x, y, width, height, pad;

	ras = (uint8 *)disp->db->gfx;
	width = disp->db->width;
	height = disp->db->height;
	pad = disp->db->pad;

	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x+=8) {
			((uint32 *)ras)[0] = 0;
			((uint32 *)ras)[1] = 0;
			((uint32 *)ras)[2] = 0;
			((uint32 *)ras)[3] = 0;
			((uint32 *)ras)[4] = 0;
			((uint32 *)ras)[5] = 0;
			((uint32 *)ras)[6] = 0;
			((uint32 *)ras)[7] = 0;
			ras += 32;
		}
		ras += pad;
	}
}
#endif

gfx *CreateGfx (uint32 fmt, int32 width, int32 height) {
	gfx *gfx;
	gfx = AllocMem(sizeof(*gfx), MEMF_ANY|MEMF_CLEAR);
	if (!gfx) return NULL;

	switch (gfx->fmt = fmt) {
		case GFX_FMT_CLUT8:
			gfx->bpp = 1;
			break;
		case GFX_FMT_ARGB32:
			gfx->bpp = 4;
			break;
	}

	gfx->width = width;
	gfx->height = height;
	gfx->bpr = width*gfx->bpp;

	gfx->gfx = AllocMem(gfx->bpr*height, MEMF_ANY|MEMF_CLEAR);
	if (gfx->gfx) {
		return gfx;
	}

	FreeGfx(gfx);
	return NULL;
}

gfx *CreateGfxFromBitMap (struct BitMap *bm) {
	gfx *gfx;

	if (!bm) return NULL;

	if (!p96GetBitMapAttr(bm, P96BMA_ISP96) ||
		p96GetBitMapAttr(bm, P96BMA_RGBFORMAT) != RGBFB_A8R8G8B8)
	{
		return NULL;
	}

	gfx = AllocMem(sizeof(*gfx), MEMF_ANY|MEMF_CLEAR);
	if (!gfx) return NULL;

	gfx->bm = bm;
	gfx->fmt = GFX_FMT_ARGB32;
	gfx->width = p96GetBitMapAttr(bm, P96BMA_WIDTH);
	gfx->height = p96GetBitMapAttr(bm, P96BMA_HEIGHT);
	gfx->bpp = 4;
	gfx->bpr = p96GetBitMapAttr(bm, P96BMA_BYTESPERROW);
	gfx->pad = gfx->bpr - (gfx->width << 2);
	gfx->gfx = (void *)p96GetBitMapAttr(bm, P96BMA_MEMORY);

	return gfx;
}

color *AllocCLUT (gfx *gfx, int32 ncols) {
	if (gfx->clut) FreeMem(gfx->clut, gfx->ncols*sizeof(color));
	gfx->clut = AllocMem(ncols*sizeof(color), MEMF_ANY|MEMF_CLEAR);
	if (gfx->clut)
		gfx->ncols = ncols;
	else
		gfx->ncols = 0;
	return gfx->clut;
}

void FreeGfx (gfx *gfx) {
	if (!gfx) return;
	if (gfx->clut) FreeMem(gfx->clut, gfx->ncols*sizeof(color));
	if (!gfx->bm) {
		if (gfx->gfx) FreeMem(gfx->gfx, gfx->bpr*gfx->height);
	}
	FreeMem(gfx, sizeof(*gfx));
}

void VanillaKeys (display *disp, int recv) {
	uint32 idcmp = 0;

	#ifdef __amigaos4__
	if (GetWindowAttr(disp->win, WA_IDCMP, &idcmp, sizeof(idcmp)) != sizeof(idcmp)) return;
	#else
	idcmp = disp->win->IDCMPFlags;
	#endif

	if (recv)
		idcmp |= IDCMP_VANILLAKEY;
	else
		idcmp &= ~IDCMP_VANILLAKEY;

	#ifdef __amigaos4__
	SetWindowAttr(disp->win, WA_IDCMP, (void *)idcmp, sizeof(idcmp));
	#else
	ModifyIDCMP(disp->win, idcmp);
	#endif
}
