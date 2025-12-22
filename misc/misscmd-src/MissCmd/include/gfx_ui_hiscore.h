#ifndef GFX_UI_HISCORE_H
#define GFX_UI_HISCORE_H

typedef struct {
	Menu *menu;
	int32 x, y, x2, y2;

	struct {
		int32 cw, ch;
		int32 cx, cy;
		char *buf;
		int32 pos, len, maxlen;
	} edit;
} HiscoreView;

/* gfx_ui_hiscore.c */
HiscoreView *CreateHiscoreView ();
void DeleteHiscoreView (HiscoreView *hiv);
void RenderHiscoreView (display *disp, HiscoreView *hiv);
void BeginEditHiscore (display *disp, HiscoreView *hiv, int pos, char *buf, int32 size);
int EditHiscore (display *disp, HiscoreView *hiv);
void EndEditHiscore (display *disp, HiscoreView *hiv);

#endif
