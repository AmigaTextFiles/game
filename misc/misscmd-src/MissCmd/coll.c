#include "main.h"

#define TOP 4
#define BOTTOM 8
#define LEFT 1
#define RIGHT 2

static inline uint8 outcode (int32 x, int32 y, int32 max_x, int32 max_y) {
	uint8 c = 0;
	if (x > max_x) c = RIGHT;
	else if (x < 0) c = LEFT;
	if (y > max_y) c |= BOTTOM;
	else if (y < 0) c |= TOP;
	return c;
}

int LineGfxColl (int32 x1, int32 y1, int32 x2, int32 y2, int32 gfx_x1, int32 gfx_y1, gfx *gfx) {
	int32 max_x, max_y;
	max_x = gfx->width-1;
	max_y = gfx->height-1;
	x1 -= gfx_x1; y1 -= gfx_y1;
	x2 -= gfx_x1; y2 -= gfx_y1;
	/* clip line first */
	{
		uint8 c1, c2, c;
		int32 x, y;
		c1 = outcode(x1, y1, max_x, max_y);
		c2 = outcode(x2, y2, max_x, max_y);
		while (c1 || c2) {
			if (c1 & c2) return FALSE;
			c = c1 ? c1 : c2;
			if (c & BOTTOM) {
				y = max_y;
				x = x1 + ((x2-x1)*(y-y1)/(y2-y1));
			} else if (c & TOP) {
				y = 0;
				x = x1 + ((x2-x1)*(y-y1)/(y2-y1));
			} else if (c & RIGHT) {
				x = max_x;
				y = y1 + ((y2-y1)*(x-x1)/(x2-x1));
			} else if (c & LEFT) {
				x = 0;
				y = y1 + ((y2-y1)*(x-x1)/(x2-x1));
			}
			if (c == c1) {
				x1 = x; y1 = y;
				c1 = outcode(x1, y1, max_x, max_y);
			} else {
				x2 = x; y2 = y;
				c2 = outcode(x2, y2, max_x, max_y);
			}
		}
	}
	{
		int dy = y2 - y1;
		int dx = x2 - x1;
		int32 stepx, stepy;
		int32 pitch = gfx->bpr;
		uint8 *ras = (uint8 *)gfx->gfx;
		switch (gfx->fmt) {
			case GFX_FMT_ARGB32:
				if (dy < 0) { dy = -dy; stepy = -pitch; } else { stepy = pitch; }
				if (dx < 0) { dx = -dx; stepx = -4; } else { stepx = 4; }
				x1 <<= 2; x2 <<= 2;
				break;
			case GFX_FMT_CLUT8:
				if (dy < 0) { dy = -dy; stepy = -pitch; } else { stepy = pitch; }
				if (dx < 0) { dx = -dx; stepx = -1; } else { stepx = 1; }
				break;
		}
		dy <<= 1; dx <<= 1;
		y1 *= pitch; y2 *= pitch;
		if (*(uint8 *)(ras+x1+y1) > 0) return TRUE;
		if (dx > dy) {
			int frac = dy - (dx >> 1);
			while (x1 != x2) {
				if (frac >= 0) {
					y1 += stepy;
					frac -= dx;
				}
				x1 += stepx;
				frac += dy;
				if (*(uint8 *)(ras+x1+y1) > 0) return TRUE;
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
				if (*(uint8 *)(ras+x1+y1) > 0) return TRUE;
			}
		}
	}
	return FALSE;
}
