#ifndef GAME_GFX_H
#define GAME_GFX_H 1

#define ALPHA_MASK	0xFF000000
#define RED_MASK		0x00FF0000
#define GREEN_MASK	0x0000FF00
#define BLUE_MASK	0x000000FF
#define ALPHA_SHIFT	24
#define RED_SHIFT		16
#define GREEN_SHIFT	8
#define BLUE_SHIFT	0

#define ALPHA_VAL(col)	(((uint32)(col) & ALPHA_MASK) >> ALPHA_SHIFT)
#define RED_VAL(col)	(((uint32)(col) & RED_MASK) >> RED_SHIFT)
#define GREEN_VAL(col)	(((uint32)(col) & GREEN_MASK) >> GREEN_SHIFT)
#define BLUE_VAL(col)	(((uint32)(col) & BLUE_MASK) >> BLUE_SHIFT)

typedef union {
	uint32 full;
	struct {
		uint8 alpha, red, green, blue;
	} part;
} argb32_pixel;

typedef struct {
	uint8 alpha, red, green, blue;
} color;

typedef struct gfx {
	void *gfx;
	void *clut; /* only if colormapped */
	struct BitMap *bm;

	uint32 fmt;
	int32 width, height;
	/* bpp = bytesperpixel
	 * bpr = bytesperrow
	 * pad = interrow padding (usually 0) */
	int32 bpp, bpr, pad;
	int32 ncols; /* only if colormapped */

	struct {
		int32 x, y;
	} handle;
} gfx;

#define GFX_FMT_UNKNOWN 0
#define GFX_FMT_CLUT8 1
#define GFX_FMT_ARGB32 2

typedef struct disp {
	uint32	mode;

	struct BitMap		*bm;
	struct RastPort		*my_rp;
	gfx				*db;

	struct Screen		*scr; /* NULL if windowed */
	struct Window		*win;

	struct RastPort		*rp;
	struct Rectangle	bounds;

	void (*showdb) (struct disp *disp);

	struct {
		int32 x1, y1;
		int32 x2, y2;
	} cliprect;

	struct {
		int			mode;
		argb32_pixel	col;
		argb32_pixel	col2;
	} drm;

	struct Hook		rh;
	struct RenderInfo	ri;

	struct DrawInfo	*dri;
	struct Image		*icoimg;
	struct Gadget		*icogad;
} display;

#define DISP_MODE_FULLSCREEN 1

#define ShowDB(DSP) DSP->showdb(DSP)

#define GID_ICONIFY 1

enum {
	MENUA_Dummy = 0x80001000,
	MENUA_Id,
	MENUA_Disabled
};

enum {
	DRM_NORMAL = 0,
	DRM_ALPHA_BLEND,
	DRM_ALPHA_ADD,
	DRM_ALPHA_SUB
};

#define DRM_BLEND DRM_ALPHA_BLEND
#define DRM_ADD DRM_ALPHA_ADD
#define DRM_SUB DRM_ALPHA_SUB

enum {
	TXT_ALIGN_LEFT = 0,
	TXT_ALIGN_CENTER,
	TXT_ALIGN_RIGHT
};

/* gfx.c */
display *CreateDisplay ();
void DeleteDisplay (display *disp);
void ToggleFullscreen (display *disp);
void ClearDB (display *disp);
gfx *CreateGfx (uint32 fmt, int32 width, int32 height);
gfx *CreateGfxFromBitMap (struct BitMap *bm);
color *AllocCLUT (gfx *gfx, int32 ncols);
void FreeGfx (gfx *gfx);
void VanillaKeys (display *disp, int recv);

/* iconify.c */
void CreateIconifyGadget (display *disp, struct Window *win);
void DeleteIconifyGadget (display *disp);
void DoIconify (display *disp);

/* pointer.c */
Object *LoadPointerGfxDT (char * filename);
void SetPointerGfx (display *disp, Object *ptr);

/* gfx_io.c */
gfx **LoadGfxArray(char **filenames);
void FreeGfxArray(gfx **array);
#define NumGfx(array) (*((uint32 *)(array) - 1))
gfx *LoadGfxDT (char *filename);

/* gfx_blit.c */
void BlitGfx (display *disp, gfx *gfx, int32 x, int32 y);

/* gfx_primitives.c */
void DrawMode (display *disp, int mode, uint8 red, uint8 green, uint8 blue, uint8 alpha);
void DrawLine (display *disp, int32 x1, int32 y1, int32 x2, int32 y2);
void DrawCircle (display *disp, int32 cx, int32 cy, int32 r);
void DrawRect (display *disp, int32 x1, int32 y1, int32 x2, int32 y2);

/* gfx_text.c */
#define GetFontWidth(disp) disp->my_rp->Font->tf_XSize
#define GetFontHeight(disp) disp->my_rp->Font->tf_YSize
int32 TextWidth (display *disp, char *txt);
#define TextHeight(disp) GetFontHeight(disp)
void DrawText (display *disp, char *txt, int32 x, int32 y, int align);
#ifdef __amigaos4__
VARARGS68K void DrawPrintf (display *disp, int32 x, int32 y, int align, char *fmt, ...);
#else
void DrawPrintf (display *disp, int32 x, int32 y, int align, char *fmt, uint32 arg1, ...);
#endif

#endif /* GAME_GFX_H */
