#ifndef GFX_GRADIENT_H
#define GFX_GRADIENT_H

typedef struct {
	int type, drmode;
	uint8 rgbstart[4];
	uint8 rgbend[4];
} gradspec;

enum {
	GTYP_VERT = 0,
	GTYP_HORIZ
};

/* gfx_gradient.c */
#undef DrawGradient
void DrawGradient (display *disp, const gradspec *grad, int32 x1, int32 y1, int32 x2, int32 y2);

#endif
