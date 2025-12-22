#ifndef GFX_UI_H
#define GFX_UI_H

typedef struct {
	NODE *sel;
	int sel_hi, bt_id;

	char *title;
	int32 tx, ty;
	int32 x, y, x2, y2;
	LIST buttons;
} Menu;

typedef struct {
	NODE node;
	int id;

	char *label;
	int32 lbl_x, lbl_y;
	int32 x, y, x2, y2;
} Button;

extern const uint32 _pens[];

enum {
	DRP_BKG = 0,
	DRP_TEXT,
	DRP_HILIGHT,
	DRP_SHADOW
};

enum {
	BTST_NORMAL = 0,
	BTST_PRESSED
};

enum {
	BVL_NORMAL = 0,
	BVL_PRESSED
};

/* game.c */
struct IntuiMessage *GetGameInput ();

/* gfx_ui.c */
void DrawBevel (display *disp, int32 x1, int32 y1, int32 x2, int32 y2, int state);
NODE *CreateButton (int id, char *label, int32 x, int32 y, int32 w, int32 h);
Menu *CreateMenu(int32 x, int32 y, int32 w, int32 h);
Menu *CreateMainMenu (char *title, char **labels);
void ResetMenu (Menu *m);
void DeleteMenu (Menu *m);
void RenderMenu (display *disp, Menu *m);
int MenuInput (Menu *menu);

#endif /* GFX_UI_H */
