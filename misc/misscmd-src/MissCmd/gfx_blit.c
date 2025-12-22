#include "main.h"

void BlitGfx (display *disp, gfx *gfx, int32 x, int32 y) {
	uint8 *src;
	int32 w, h;
	src = (uint8 *)gfx->gfx;
	w = gfx->width; h = gfx->height;

	/* handle clipping */
	{
		int32 x2, y2;
		int32 r1, r2;
		y2 = y+h-1; x2 = x+w-1;
		r1 = disp->cliprect.y1 - y;
		r2 = y2 - disp->cliprect.y2;
		if (r1 > 0) { src += (r1*gfx->bpr); h -= r1; y = disp->cliprect.y1; }
		if (r2 > 0) { h -= r2; y2 = disp->cliprect.y2; }
		r1 = disp->cliprect.x1 - x;
		r2 = x2 - disp->cliprect.x2;
		if (r1 > 0) { src += (r1*gfx->bpp); w -= r1; x = disp->cliprect.x1; }
		if (r2 > 0) { w -= r2; x2 = disp->cliprect.x2; }
	}
	if (w <= 0 || h <= 0) return;

	/* blit it */
	if (gfx->fmt == GFX_FMT_CLUT8) {
		uint8 *dst;
		uint32 *clut;
		int32 src_mod, dst_mod;

		clut = (uint32 *)gfx->clut;
		dst = (uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2);
		src_mod = gfx->bpr - w;
		dst_mod = disp->db->bpr - (w<<2);

		for (y = 0; y < h; y++) {
			for (x = 0; x < w; x++) {
				if (*src) *(uint32 *)dst = clut[*src];
				dst += 4; src++;
			}
			src += src_mod;
			dst += dst_mod;
		}
	} else {
		uint8 *dst;
		int32 src_mod, dst_mod;

		dst = (uint8 *)disp->db->gfx+(y*disp->db->bpr)+(x<<2);
		src_mod = gfx->bpr - (w<<2);
		dst_mod = disp->db->bpr - (w<<2);

		for (y = 0; y < h; y++) {
			for (x = 0; x < w; x++) {
				if (*src == 255) {
					*(uint32 *)dst = *(uint32 *)src;
					dst += 4; src += 4;
				} else if (*src > 0) {
					unsigned int a1, a2;
					a1 = *src++; a2 = 255-a1;
					*dst++ = 0xFF;
					*dst = ( ((unsigned int)*dst * a2) + ((unsigned int)*src * a1) ) >> 8;
					dst++; src++;
					*dst = ( ((unsigned int)*dst * a2) + ((unsigned int)*src * a1) ) >> 8;
					dst++; src++;
					*dst = ( ((unsigned int)*dst * a2) + ((unsigned int)*src * a1) ) >> 8;
					dst++; src++;
				} else {
					dst += 4; src += 4;
				}
			}
			src += src_mod;
			dst += dst_mod;
		}
	}
}
