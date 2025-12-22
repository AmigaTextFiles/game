#include "main.h"

void DrawGradient (display *disp, const gradspec *grad, int32 x1, int32 y1, int32 x2, int32 y2) {
	uint8 rgb[4];
	int8 d_rgb[4], rgb_inc[4];
	int32 rgb_frac[4] = {0}, d_rgb_frac[4], w, h, x, y, ln;
	uint8 *ras2, *ras;
	int32 stepx, stepy;
	rgb[0] = grad->rgbstart[0]; rgb[1] = grad->rgbstart[1]; rgb[2] = grad->rgbstart[2];

	if (grad->type == GTYP_VERT) {
		w = x2 - x1;
		h = y2 - y1;
		stepx = 0;
		stepy = disp->db->bpr;
	} else {
		w = y2 - y1;
		h = x2 - x1;
		stepx = disp->db->bpr-4;
		stepy = 4;
	}

	d_rgb[0] = (grad->rgbend[0] - rgb[0]) / h; d_rgb_frac[0] = (grad->rgbend[0] - rgb[0]) % h;
	d_rgb[1] = (grad->rgbend[1] - rgb[1]) / h; d_rgb_frac[1] = (grad->rgbend[1] - rgb[1]) % h;
	d_rgb[2] = (grad->rgbend[2] - rgb[2]) / h; d_rgb_frac[2] = (grad->rgbend[2] - rgb[2]) % h;
	if (d_rgb_frac[0] < 0) { d_rgb_frac[0] = -d_rgb_frac[0]; rgb_inc[0] = -1; } else rgb_inc[0] = 1;
	if (d_rgb_frac[1] < 0) { d_rgb_frac[1] = -d_rgb_frac[1]; rgb_inc[1] = -1; } else rgb_inc[1] = 1;
	if (d_rgb_frac[2] < 0) { d_rgb_frac[2] = -d_rgb_frac[2]; rgb_inc[2] = -1; } else rgb_inc[2] = 1;

	ras2 = (uint8 *)disp->db->gfx + (y1 * disp->db->bpr) + (x1 << 2);
	//mod = disp->db->bpr - ((w+1) << 2);

	switch (grad->drmode) {
		default:
			for (y = 0; y <= h; y++) {
				ras = ras2;
				for (x = 0; x <= w; x++) {
					*ras++ = 0xFF;
					*ras++ = rgb[0];
					*ras++ = rgb[1];
					*ras++ = rgb[2];
					ras += stepx;
				}
				rgb[0] += d_rgb[0]; rgb_frac[0] += d_rgb_frac[0];
				rgb[1] += d_rgb[1]; rgb_frac[1] += d_rgb_frac[1];
				rgb[2] += d_rgb[2]; rgb_frac[2] += d_rgb_frac[2];
				if (rgb_frac[0] >= h) { rgb[0] += rgb_inc[0]; rgb_frac[0] -= h; }
				if (rgb_frac[1] >= h) { rgb[1] += rgb_inc[1]; rgb_frac[1] -= h; }
				if (rgb_frac[2] >= h) { rgb[2] += rgb_inc[2]; rgb_frac[2] -= h; }
				ras2 += stepy;
			}
			break;
		case DRM_ALPHA_BLEND:
			rgb[3] = grad->rgbstart[3];
			d_rgb[3] = (grad->rgbend[3] - rgb[3]) / h; d_rgb_frac[3] = (grad->rgbend[3] - rgb[3]) % h;
			if (d_rgb_frac[3] < 0) { d_rgb_frac[3] = -d_rgb_frac[3]; rgb_inc[3] = -1; } else rgb_inc[3] = 1;
			for (y = 0; y <= h; y++) {
				ras = ras2;
				for (x = 0; x <= w; x++) {
					*ras++ = 0xFF;
					*ras++ = ( ((int)*ras * (255 - rgb[3])) + ((int)rgb[0] * rgb[3]) ) >> 8;
					*ras++ = ( ((int)*ras * (255 - rgb[3])) + ((int)rgb[1] * rgb[3]) ) >> 8;
					*ras++ = ( ((int)*ras * (255 - rgb[3])) + ((int)rgb[2] * rgb[3]) ) >> 8;
					ras += stepx;
				}
				rgb[0] += d_rgb[0]; rgb_frac[0] += d_rgb_frac[0];
				rgb[1] += d_rgb[1]; rgb_frac[1] += d_rgb_frac[1];
				rgb[2] += d_rgb[2]; rgb_frac[2] += d_rgb_frac[2];
				rgb[3] += d_rgb[3]; rgb_frac[3] += d_rgb_frac[3];
				if (rgb_frac[0] >= h) { rgb[0] += rgb_inc[0]; rgb_frac[0] -= h; }
				if (rgb_frac[1] >= h) { rgb[1] += rgb_inc[1]; rgb_frac[1] -= h; }
				if (rgb_frac[2] >= h) { rgb[2] += rgb_inc[2]; rgb_frac[2] -= h; }
				if (rgb_frac[3] >= h) { rgb[3] += rgb_inc[3]; rgb_frac[3] -= h; }
				ras2 += stepy;
			}
			break;
	}
}
