#include "main.h"
#include <ctype.h>

HiscoreView *CreateHiscoreView () {
	display *disp = global->disp;
	char *title = "- Hiscores -";
	char *str = "OK";
	HiscoreView *hiv;
	hiv = AllocMem(sizeof(*hiv), MEMF_PRIVATE|MEMF_CLEAR);
	if (hiv) {
		int32 mx, my, mw, mh;
		int32 tw, th;
		int32 hiw, hih;
		int32 cw, ch;

		cw = GetFontWidth(disp);
		ch = GetFontHeight(disp);
		tw = TextWidth(disp, title)+7; th = ch+5;
		hiw = 30*cw+4; hih = 11*ch+7;
		mw = hiw+12; mh = 2*th+hih+16;

		mx = (disp->db->width - mw) >> 1;
		my = (disp->db->height - mh) >> 1;
		hiv->menu = CreateMenu(mx, my, mw, mh);
		if (hiv->menu) {
			NODE *bt;

			hiv->menu->title = title;
			hiv->menu->tx = mx+(mw >> 1);
			hiv->menu->ty = my+6+((th - ch) >> 1);

			hiv->x = mx+6; hiv->y = my+6+th;
			hiv->x2 = hiv->x+hiw-1; hiv->y2 = hiv->y+hih-1;

			tw = 2*TextWidth(disp, str)+7;
			bt = CreateButton(1, str, mx+((mw-tw) >> 1), my+mh-th-6, tw, th);
			if (bt) {
				AddTail((struct List *)&hiv->menu->buttons, (struct Node *)bt);
				return hiv;
			}
		}
		DeleteHiscoreView(hiv);
	}
	return NULL;
}

void DeleteHiscoreView (HiscoreView *hiv) {
	if (hiv) {
		DeleteMenu(hiv->menu);
		FreeMem(hiv, sizeof(*hiv));
	}
}

void RenderHiscoreView (display *disp, HiscoreView *hiv) {
	int n;
	int32 x, y, x2, y2;
	int32 cw, ch;
	hiscore *hi;
	char *name;

	x = hiv->x; y = hiv->y; x2 = hiv->x2; y2 = hiv->y2;

	RenderMenu(disp, hiv->menu);
	disp->drm.mode = DRM_NORMAL;
	disp->drm.col.full = 0xFF000000;
	DrawRect(disp, x+2, y+1, x2-2, y2-1);
	DrawBevel(disp, x, y, x2, y2, BVL_PRESSED);

	cw = GetFontWidth(disp);
	ch = GetFontHeight(disp);

	x += 2; y += 2; x2 -= 2;
	disp->drm.col.full = 0xFFFFFFFF;
	DrawText(disp, "Name", x+3*cw, y, TXT_ALIGN_LEFT);
	DrawText(disp, "Score", x2, y, TXT_ALIGN_RIGHT);
	y += (ch+2);
	DrawLine(disp, x, y, x2, y);

	y += 2;
	for (n = 1, hi = global->hiscores; n <= 10; n++, hi++, y+=ch) {
		name = hi->name;
		DrawPrintf(disp, x, y, TXT_ALIGN_LEFT, "%2ld.%s", n, name);
		DrawPrintf(disp, x2, y, TXT_ALIGN_RIGHT, "%lu", hi->score);
	}
}

void BeginEditHiscore (display *disp, HiscoreView *hiv, int pos, char *buf, int32 size) {
	int32 cx, cy, cw, ch;
	hiv->edit.cw = cw = GetFontWidth(disp);
	hiv->edit.ch = ch = GetFontHeight(disp);
	hiv->edit.cx = cx = hiv->x + 2 + 3*cw;
	hiv->edit.cy = cy = hiv->y + 6 + (pos+1)*ch;
	hiv->edit.buf = buf;
	hiv->edit.pos = hiv->edit.len = strlen(buf);
	hiv->edit.maxlen = size-1;
	
	disp->drm.mode = DRM_NORMAL;
	disp->drm.col.full = 0xFF000000;
	DrawRect(disp, cx, cy, cx+(hiv->edit.maxlen+1)*cw-1, cy+ch-1);
	disp->drm.col.full = 0xFFFFFFFF;
	DrawText(disp, buf, cx, cy, TXT_ALIGN_LEFT);
	DrawMode(disp, DRM_BLEND, 0xFF, 0x7F, 0x00, 0x9F);
	cx += hiv->edit.pos*cw;
	DrawRect(disp, cx, cy, cx+cw-1, cy+ch-1);
}

int EditHiscore (display *disp, HiscoreView *hiv) {
	struct IntuiMessage *msg;
	int update = FALSE;
	int done = FALSE;
	while (msg = GetGameInput()) {
		switch (msg->Class) {
			
			case IDCMP_VANILLAKEY:
				if (isprint(msg->Code) && hiv->edit.len < hiv->edit.maxlen) {
					MoveMem(hiv->edit.buf+hiv->edit.pos, hiv->edit.buf+hiv->edit.pos+1,
						strlen(hiv->edit.buf+hiv->edit.pos)+1);
					hiv->edit.buf[hiv->edit.pos++] = msg->Code;
					hiv->edit.len++;
					update = TRUE;
				} else {
					switch (msg->Code) {
						case 0x7F: /* delete */
							if (hiv->edit.pos >= hiv->edit.len) break;
							hiv->edit.pos++;
							/* fall through */
						case 0x08: /* backspace */
							if (hiv->edit.pos <= 0) break;
							MoveMem(hiv->edit.buf+hiv->edit.pos, hiv->edit.buf+hiv->edit.pos-1,
								strlen(hiv->edit.buf+hiv->edit.pos)+1);
							hiv->edit.pos--;
							hiv->edit.len--;
							update = TRUE;
							break;
						case 0x0D: /* return/enter */
							done = TRUE;
							break;
					}
				}
				break;

			case IDCMP_RAWKEY:
				if (msg->Code & KEYUP) break;
				switch (msg->Code) {
					case KEY_DELETE:
						if (hiv->edit.pos >= hiv->edit.len) break;
						hiv->edit.pos++;
						/* fall through */
					case KEY_BACKSPACE:
						if (hiv->edit.pos <= 0) break;
						MoveMem(hiv->edit.buf+hiv->edit.pos, hiv->edit.buf+hiv->edit.pos-1,
							strlen(hiv->edit.buf+hiv->edit.pos)+1);
						hiv->edit.pos--;
						hiv->edit.len--;
						update = TRUE;
						break;
					case KEY_RETURN:
						done = TRUE;
						break;
					case KEY_LEFT:
						if (hiv->edit.pos <= 0) break;
						hiv->edit.pos--;
						update = TRUE;
						break;
					case KEY_RIGHT:
						if (hiv->edit.pos >= hiv->edit.len) break;
						hiv->edit.pos++;
						update = TRUE;
						break;
				}
				break;

		}
		ReplyMsg((struct Message *)msg);
	}
	if (update) {
		int32 cx = hiv->edit.cx, cy = hiv->edit.cy;
		int32 cw = hiv->edit.cw, ch = hiv->edit.ch;
		char *buf = hiv->edit.buf;

		disp->drm.mode = DRM_NORMAL;
		disp->drm.col.full = 0xFF000000;
		DrawRect(disp, cx, cy, cx+(hiv->edit.maxlen+1)*cw-1, cy+ch-1);
		disp->drm.col.full = 0xFFFFFFFF;
		DrawText(disp, buf, cx, cy, TXT_ALIGN_LEFT);
		DrawMode(disp, DRM_BLEND, 0xFF, 0x7F, 0x00, 0x9F);
		cx += hiv->edit.pos*cw;
		DrawRect(disp, cx, cy, cx+cw-1, cy+ch-1);
	}
	return done;
}

void EndEditHiscore (display *disp, HiscoreView *hiv) {
	hiv->edit.buf = NULL;
	hiv->edit.pos = hiv->edit.len = hiv->edit.maxlen = 0;
}
