#include "main.h"

static void RenderButton (display *disp, NODE *node, int state);
static NODE *MenuHitTest (Menu *m, int32 x, int32 y);
static inline struct IntuiMessage *GetMenuInput (Menu *m);

const uint32 _pens[] = { 0xFF0E3307, 0xFFFFFFFF, 0xFF44A133, 0xFF000000 };

void DrawBevel (display *disp, int32 x1, int32 y1, int32 x2, int32 y2, int state) {
	if (state == BVL_NORMAL)
		DrawMode(disp, DRM_BLEND, 0xFF, 0xFF, 0xFF, 0x66);
	else
		DrawMode(disp, DRM_BLEND, 0x00, 0x00, 0x00, 0x66);
	DrawRect(disp, x1, y1, x2, y1);
	DrawRect(disp, x1, y1, x1, y2);
	if (state == BVL_NORMAL)
		DrawMode(disp, DRM_BLEND, 0xFF, 0xFF, 0xFF, 0x33);
	else
		DrawMode(disp, DRM_BLEND, 0x00, 0x00, 0x00, 0x33);
	DrawRect(disp, x1+2, y1+1, x2-2, y1+1);
	DrawRect(disp, x1+1, y1+1, x1+1, y2-1);
	if (state == BVL_NORMAL)
		DrawMode(disp, DRM_BLEND, 0x00, 0x00, 0x00, 0x66);
	else
		DrawMode(disp, DRM_BLEND, 0xFF, 0xFF, 0xFF, 0x66);
	DrawRect(disp, x2, y1, x2, y2);
	DrawRect(disp, x1+1, y2, x2, y2);
	if (state == BVL_NORMAL)
		DrawMode(disp, DRM_BLEND, 0x00, 0x00, 0x00, 0x33);
	else
		DrawMode(disp, DRM_BLEND, 0xFF, 0xFF, 0xFF, 0x33);
	DrawRect(disp, x1+2, y2-1, x2-2, y2-1);
	DrawRect(disp, x2-1, y1+1, x2-1, y2-1);
}

NODE *CreateButton (int id, char *label, int32 x, int32 y, int32 w, int32 h) {
	Button *bt;
	bt = CreateNode(sizeof(Button));
	if (bt) {
		bt->id = id;
		bt->label = label;

		bt->x = x; bt->y = y;
		//bt->w = w; bt->h = h;
		bt->x2 = x+w-1; bt->y2 = y+h-1;

		bt->lbl_x = bt->x + (w >> 1);
		bt->lbl_y = bt->y + ((h - TextHeight(global->disp)) >> 1);
	}
	return (NODE *)bt;
}

static void RenderButton (display *disp, NODE *node, int state) {
	static const gradspec grad[2] = {
		{ GTYP_VERT, DRM_NORMAL, { 0x33, 0x90, 0x22, 0xFF}, { 0x0E, 0x33, 0x07, 0xFF} },
		{ GTYP_VERT, DRM_NORMAL, { 0x0E, 0x33, 0x07, 0xFF}, { 0x33, 0x90, 0x22, 0xFF} },
	};
	Button *bt = (Button *)node;
	disp->drm.col.full = _pens[DRP_BKG];
	//DrawRect(disp, bt->x, bt->y, bt->x2, bt->y2);
	DrawGradient(disp, &grad[state], bt->x, bt->y, bt->x2, bt->y2);

	switch (state) {

		case BTST_NORMAL:
			disp->drm.col.full = _pens[DRP_SHADOW];
			DrawText(disp, bt->label, bt->lbl_x+1, bt->lbl_y+1, TXT_ALIGN_CENTER);
			disp->drm.col.full = _pens[DRP_TEXT];
			DrawText(disp, bt->label, bt->lbl_x, bt->lbl_y, TXT_ALIGN_CENTER);
			break;

		case BTST_PRESSED:
			disp->drm.col.full = _pens[DRP_TEXT];
			DrawText(disp, bt->label, bt->lbl_x+1, bt->lbl_y+1, TXT_ALIGN_CENTER);
			break;

	}
	DrawBevel(disp, bt->x, bt->y, bt->x2, bt->y2, state);
}

Menu *CreateMenu(int32 x, int32 y, int32 w, int32 h) {
	Menu *m;
	m = AllocMem(sizeof(*m), MEMF_PRIVATE|MEMF_CLEAR);
	if (m) {
		m->x = x; m->y = y;
		//m->w = w; m->h = h;
		m->x2 = x+w-1; m->y2 = y+h-1;
		NewMinList(&m->buttons);
	}
	return m;
}

Menu *CreateMainMenu (char *title, char **labels) {
	Menu *m;
	display *disp = global->disp;
	char ** cstr;
	int32 mx, my, mw, mh;
	int32 bx, by, bw, bh, w;
	int nb = 0, id;

	bw = TextWidth(disp, title);
	for (cstr = labels; *cstr; cstr++) {
		nb++;
		w = TextWidth(disp, *cstr);
		if (w > bw) bw = w;
	}
	bw += 7;
	bh = TextHeight(disp) + 5;
	mw = bw+12;
	mh = (title ? bh : 0) + nb*bh + ((nb-1) << 2) + 12;
	mx = (disp->db->width - mw) >> 1;
	my = (disp->db->height - mh) >> 1;
	m = CreateMenu(mx, my, mw, mh);
	if (m) {
		NODE *bt;
		bx = mx + 6;
		by = my + 6;
		if (title) {
			m->title = title;
			m->tx = bx + (bw >> 1);
			m->ty = by + ((bh - TextHeight(disp)) >> 1);
			by += bh;
		}
		for (cstr = labels, id = 1; *cstr; cstr++, id++, by+=(bh+4)) {
			bt = CreateButton(id, *cstr, bx, by, bw, bh);
			if (!bt) {
				DeleteMenu(m);
				return NULL;
			}
			AddTail((struct List *)&m->buttons, (struct Node *)bt);
		}
	}
	return m;
}

void ResetMenu (Menu *m) {
	m->sel = NULL;
	m->sel_hi = FALSE;
	m->bt_id = 0;
}

void DeleteMenu (Menu *m) {
	if (m) {
		NODE *bt, *next_bt;
		for (bt = m->buttons.mlh_Head; next_bt = bt->mln_Succ; bt = next_bt)
			DeleteNode(bt);
		FreeMem(m, sizeof(*m));
	}
}

void RenderMenu (display *disp, Menu *m) {
	NODE *bt, *next_bt;
	static const gradspec grad = {
		GTYP_HORIZ, DRM_NORMAL,
		{ 0x14, 0x60, 0x0A, 0xFF},
		{ 0x0E, 0x22, 0x07, 0xFF}
	};

	disp->drm.col.full = _pens[DRP_BKG];
	//DrawRect(disp, m->x, m->y, m->x2, m->y2);
	DrawGradient(disp, &grad, m->x, m->y, m->x2, m->y2);
	DrawBevel(disp, m->x, m->y, m->x2, m->y2, BVL_NORMAL);
	AddClearRect(&global->dmglist, m->x, m->y, m->x2, m->y2);

	if (m->title) {
		disp->drm.col.full = _pens[DRP_SHADOW];
		DrawText(disp, m->title, m->tx+1, m->ty+1, TXT_ALIGN_CENTER);
		disp->drm.col.full = _pens[DRP_TEXT];
		DrawText(disp, m->title, m->tx, m->ty, TXT_ALIGN_CENTER);
	}

	for (bt = m->buttons.mlh_Head; next_bt = bt->mln_Succ; bt = next_bt)
		RenderButton(disp, bt, BTST_NORMAL);
}

static NODE *MenuHitTest (Menu *m, int32 x, int32 y) {
	Button *bt, *next_bt;
	if (x < m->x || x > m->x2 || y < m->y || y > m->y2)
		return NULL;
	for (bt = (Button *)m->buttons.mlh_Head; next_bt = (Button *)bt->node.mln_Succ; bt = next_bt) {
		if (x >= bt->x && x <= bt->x2 && y >= bt->y && y <= bt->y2)
			return (NODE *)bt;
	}
	return NULL;
}

static inline struct IntuiMessage *GetMenuInput (Menu *m) {
	display *disp = global->disp;
	struct IntuiMessage *msg;

	while (msg = GetGameInput()) {
		switch (msg->Class) {

			case IDCMP_MOUSEMOVE:
				if (m->sel) {
					int32 x, y;
					x = msg->MouseX; y = msg->MouseY;
					if ( x >= disp->bounds.MinX && x <= disp->bounds.MaxX
						&& y >= disp->bounds.MinY && y <= disp->bounds.MaxY)
					{
						x -= disp->bounds.MinX; y -= disp->bounds.MinY;
						if (MenuHitTest(m, x, y) == m->sel) {
							if (!m->sel_hi) {
								m->sel_hi = TRUE;
								RenderButton(disp, m->sel, BTST_PRESSED);
							}
						} else {
							if (m->sel_hi) {
								m->sel_hi = FALSE;
								RenderButton(disp, m->sel, BTST_NORMAL);
							}
						}
					}
				}
				break;

			case IDCMP_MOUSEBUTTONS:
				if (msg->Code == SELECTDOWN) {
					int32 x, y;
					x = msg->MouseX; y = msg->MouseY;
					if ( x >= disp->bounds.MinX && x <= disp->bounds.MaxX
						&& y >= disp->bounds.MinY && y <= disp->bounds.MaxY)
					{
						x -= disp->bounds.MinX; y -= disp->bounds.MinY;
						m->sel = MenuHitTest(m, x, y);
						if (m->sel) {
							m->sel_hi = TRUE;
							RenderButton(disp, m->sel, BTST_PRESSED);
						}
					}
				} else if (msg->Code == SELECTUP && m->sel) {
					int32 x, y;
					x = msg->MouseX; y = msg->MouseY;
					if ( x >= disp->bounds.MinX && x <= disp->bounds.MaxX
						&& y >= disp->bounds.MinY && y <= disp->bounds.MaxY)
					{
						x -= disp->bounds.MinX; y -= disp->bounds.MinY;
						if (MenuHitTest(m, x, y) == m->sel) {
							m->bt_id = ((Button *)m->sel)->id;
						}
						if (m->sel_hi) {
							m->sel_hi = FALSE;
							RenderButton(disp, m->sel, BTST_NORMAL);
						}
					}
					m->sel = NULL;
				}
				break;

		}
		return msg;
	}
	return NULL;
}

int MenuInput (Menu *menu) {
	display *disp = global->disp;
	struct IntuiMessage *msg;
	int bt_id;

	while (msg = GetMenuInput(menu)) {
		switch (msg->Class) {

			/* do nothing */

		} /* switch */
		ReplyMsg((struct Message *)msg);
	} /* while */

	bt_id = menu->bt_id; menu->bt_id = 0;
	return bt_id;
}
