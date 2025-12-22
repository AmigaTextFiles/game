#include "main.h"

void DrawMode (display *disp, int mode, uint8 red, uint8 green, uint8 blue, uint8 alpha) {
	disp->drm.mode = mode;

	disp->drm.col.part.alpha = alpha;
	disp->drm.col.part.red = red;
	disp->drm.col.part.green = green;
	disp->drm.col.part.blue = blue;

	switch (mode) {
		case DRM_ALPHA_BLEND:
			disp->drm.col2.part.alpha = 255-alpha;
			disp->drm.col2.part.red = (red*alpha)>>8;
			disp->drm.col2.part.green = (green*alpha)>>8;
			disp->drm.col2.part.blue = (blue*alpha)>>8;
			break;
	}
}

static inline void alpha_blend (display *disp, argb32_pixel *pix) {
	unsigned int alpha = disp->drm.col2.part.alpha;
	pix->part.red = ((pix->part.red*alpha)>>8) + disp->drm.col2.part.red;
	pix->part.green = ((pix->part.green*alpha)>>8) + disp->drm.col2.part.green;
	pix->part.blue = ((pix->part.blue*alpha)>>8) + disp->drm.col2.part.blue;
}

static inline void alpha_add (display *disp, argb32_pixel *pix) {
	int red = pix->part.red + disp->drm.col.part.red;
	int green = pix->part.green + disp->drm.col.part.green;
	int blue = pix->part.blue + disp->drm.col.part.blue;
	pix->part.red = (red > 255) ? 255 : red;
	pix->part.green = (red > 255) ? 255 : green;
	pix->part.blue = (red > 255) ? 255 : blue;
}

static inline void alpha_sub (display *disp, argb32_pixel *pix) {
	int red = (int)pix->part.red - disp->drm.col.part.red;
	int green = (int)pix->part.green - disp->drm.col.part.green;
	int blue = (int)pix->part.blue - disp->drm.col.part.blue;
	pix->part.red = (red < 0) ? 0 : red;
	pix->part.green = (red < 0) ? 0 : green;
	pix->part.blue = (red < 0) ? 0 : blue;
}

#define TOP 4
#define BOTTOM 8
#define LEFT 1
#define RIGHT 2

static inline uint8 outcode (display *disp, int32 x, int32 y) {
	uint8 c = 0;
	if (x > disp->cliprect.x2) c = RIGHT;
	else if (x < disp->cliprect.x1) c = LEFT;
	if (y > disp->cliprect.y2) c |= BOTTOM;
	else if (y < disp->cliprect.y1) c |= TOP;
	return c;
}

void DrawLine (display *disp, int32 x1, int32 y1, int32 x2, int32 y2) {
	/* clip it first */
	{
		uint8 c1, c2, c;
		int32 x, y;
		c1 = outcode(disp, x1, y1);
		c2 = outcode(disp, x2, y2);
		while (c1 || c2) {
			if (c1 & c2) return;
			c = c1 ? c1 : c2;
			if (c & BOTTOM) {
				y = disp->cliprect.y2;
				x = x1 + ((x2-x1)*(y-y1)/(y2-y1));
			} else if (c & TOP) {
				y = disp->cliprect.y1;
				x = x1 + ((x2-x1)*(y-y1)/(y2-y1));
			} else if (c & RIGHT) {
				x = disp->cliprect.x2;
				y = y1 + ((y2-y1)*(x-x1)/(x2-x1));
			} else if (c & LEFT) {
				x = disp->cliprect.x1;
				y = y1 + ((y2-y1)*(x-x1)/(x2-x1));
			}
			if (c == c1) {
				x1 = x; y1 = y;
				c1 = outcode(disp, x1, y1);
			} else {
				x2 = x; y2 = y;
				c2 = outcode(disp, x2, y2);
			}
		}
	}
	/* draw it */
	{
		int dy = y2 - y1;
		int dx = x2 - x1;
		int32 stepx, stepy;
		int32 pitch = disp->db->bpr;
		uint32 col = disp->drm.col.full;
		uint8 *ras = (uint8 *)disp->db->gfx;

		if (dy < 0) { dy = -dy; stepy = -pitch; } else { stepy = pitch; }
		if (dx < 0) { dx = -dx; stepx = -4; } else { stepx = 4; }
		dy <<= 1; dx <<= 1;
		y1 *= pitch; y2 *= pitch;
		x1 <<= 2; x2 <<= 2;
		*(uint32 *)(ras+x1+y1) = col;
		if (dx > dy) {
			int frac = dy - (dx >> 1);
			while (x1 != x2) {
				if (frac >= 0) {
					y1 += stepy;
					frac -= dx;
				}
				x1 += stepx;
				frac += dy;
				*(uint32 *)(ras+x1+y1) = col;
			}
		} else {
			int frac = dx - (dy >> 1);
			while (y1 != y2) {
				if (frac >= 0) {
					x1 += stepx;
					frac -= dy;
				}
				y1 += stepy;
				frac += dx;
				*(uint32 *)(ras+x1+y1) = col;
			}
		}
	}
}

static void drawhoriz_normal (display *disp, int32 x, int32 y, int32 ln) {
	int32 x2 = x+ln-1;
	argb32_pixel *ras;
	uint32 col = disp->drm.col.full;

	if (y < disp->cliprect.y1 || y > disp->cliprect.y2) return;
	if (x2 < disp->cliprect.x1 || x > disp->cliprect.x2) return;

	if (x < disp->cliprect.x1) x = disp->cliprect.x1;
	if (x2 > disp->cliprect.x2) x2 = disp->cliprect.x2;

	ras = (argb32_pixel *)((uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2));
	for (; x <= x2; x++) {
		ras->full = col;
		ras++;
	}
}

static void drawhoriz_alpha_blend (display *disp, int32 x, int32 y, int32 ln) {
	int32 x2 = x+ln-1;
	argb32_pixel *ras;

	if (y < disp->cliprect.y1 || y > disp->cliprect.y2) return;
	if (x2 < disp->cliprect.x1 || x > disp->cliprect.x2) return;

	if (x < disp->cliprect.x1) x = disp->cliprect.x1;
	if (x2 > disp->cliprect.x2) x2 = disp->cliprect.x2;

	ras = (argb32_pixel *)((uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2));
	for (; x <= x2; x++) {
		alpha_blend(disp, ras);
		ras++;
	}
}

static void drawhoriz_alpha_add (display *disp, int32 x, int32 y, int32 ln) {
	int32 x2 = x+ln-1;
	argb32_pixel *ras;

	if (y < disp->cliprect.y1 || y > disp->cliprect.y2) return;
	if (x2 < disp->cliprect.x1 || x > disp->cliprect.x2) return;

	if (x < disp->cliprect.x1) x = disp->cliprect.x1;
	if (x2 > disp->cliprect.x2) x2 = disp->cliprect.x2;

	ras = (argb32_pixel *)((uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2));
	for (; x <= x2; x++) {
		alpha_add(disp, ras);
		ras++;
	}
}

static void drawhoriz_alpha_sub (display *disp, int32 x, int32 y, int32 ln) {
	int32 x2 = x+ln-1;
	argb32_pixel *ras;

	if (y < disp->cliprect.y1 || y > disp->cliprect.y2) return;
	if (x2 < disp->cliprect.x1 || x > disp->cliprect.x2) return;

	if (x < disp->cliprect.x1) x = disp->cliprect.x1;
	if (x2 > disp->cliprect.x2) x2 = disp->cliprect.x2;

	ras = (argb32_pixel *)((uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2));
	for (; x <= x2; x++) {
		alpha_sub(disp, ras);
		ras++;
	}
}

void DrawCircle (display *disp, int32 cx, int32 cy, int32 r) {
	int32 prevy, x = 0, y = r, p = 1-r;
	void (*drawhoriz)(display *, int32, int32, int32);

	switch (disp->drm.mode) {

		default:
			drawhoriz = drawhoriz_normal;
			break;

		case DRM_ALPHA_BLEND:
			drawhoriz = drawhoriz_alpha_blend;
			break;

		case DRM_ALPHA_ADD:
			drawhoriz = drawhoriz_alpha_add;
			break;

		case DRM_ALPHA_SUB:
			drawhoriz = drawhoriz_alpha_sub;
			break;

	}

	drawhoriz(disp, cx-y, cy+x, y << 1);
	while (x < (y-1)) {
		prevy = y;
		x++;
		if (p < 0) {
			p = p+(x << 1)+1;
		} else {
			y--;
			p = p+((x-y) << 1)+1;
		}
		if (y < prevy && x < y) {
			drawhoriz(disp, cx-x, cy+y, x << 1);
			drawhoriz(disp, cx-x, cy-y, x << 1);
		}
		drawhoriz(disp, cx-y, cy+x, y << 1);
		drawhoriz(disp, cx-y, cy-x, y << 1);
	}
}

void DrawRect (display *disp, int32 x1, int32 y1, int32 x2, int32 y2) {
	uint8 *ras;
	int32 w, h, mod;

	/* clip it */
	if (x1 < disp->cliprect.x1) x1 = disp->cliprect.x1;
	if (x2 > disp->cliprect.x2) x2 = disp->cliprect.x2;
	w = x2-x1+1;
	if (y1 < disp->cliprect.y1) y1 = disp->cliprect.y1;
	if (y2 > disp->cliprect.y2) y2 = disp->cliprect.y2;
	h = y2-y1+1;
	if (w <= 0 || h <= 0) return;

	/* draw it */
	ras = (uint8 *)disp->db->gfx+(y1*disp->db->bpr)+(x1<<2);
	mod = disp->db->bpr - (w<<2);
	switch (disp->drm.mode) {

		default:
			{
			uint32 col = disp->drm.col.full;
			for (y1 = 0; y1 < h; y1++) {
				for (x1 = 0; x1 < w; x1++) {
					*(uint32 *)ras = col;
					ras += 4;
				}
				ras += mod;
			}
			}
			break;

		case DRM_ALPHA_BLEND:
			for (y1 = 0; y1 < h; y1++) {
				for (x1 = 0; x1 < w; x1++) {
					alpha_blend(disp, (argb32_pixel *)ras);
					ras += 4;
				}
				ras += mod;
			}
			break;

		case DRM_ALPHA_ADD:
			for (y1 = 0; y1 < h; y1++) {
				for (x1 = 0; x1 < w; x1++) {
					alpha_add(disp, (argb32_pixel *)ras);
					ras += 4;
				}
				ras += mod;
			}
			break;

		case DRM_ALPHA_SUB:
			for (y1 = 0; y1 < h; y1++) {
				for (x1 = 0; x1 < w; x1++) {
					alpha_sub(disp, (argb32_pixel *)ras);
					ras += 4;
				}
				ras += mod;
			}
			break;

	}
}
