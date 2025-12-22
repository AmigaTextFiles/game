#include "main.h"
#include <stdarg.h>

int32 TextWidth (display *disp, char *txt) {
	struct RastPort *rp = disp->my_rp;
	return TextLength(rp, txt, strlen(txt));
}

void DrawText (display *disp, char *txt, int32 x, int32 y, int align) {
	struct RastPort *rp = disp->my_rp;
	uint16 len = strlen(txt);
	#ifdef __amigaos4__
	SetRPAttrs(rp,
		RPTAG_DrMd,			JAM1,
		RPTAG_APenColor,	disp->drm.col.full,
		TAG_END);
	#else
	SetDrMd(rp, JAM1);
	#endif
	switch (align) {
		case TXT_ALIGN_LEFT:
		default:
			Move(rp, x, y+rp->Font->tf_Baseline);
			break;
		case TXT_ALIGN_CENTER:
			Move(rp, x - (TextLength(rp, txt, len) >> 1), y+rp->Font->tf_Baseline);
			break;
		case TXT_ALIGN_RIGHT:
			Move(rp, x - TextLength(rp, txt, len), y+rp->Font->tf_Baseline);
			break;
	}
	Text(rp, txt, len);
}

#ifdef __amigaos4__
VARARGS68K void DrawPrintf (display *disp, int32 x, int32 y, int align, char *fmt, ...) {
#else
void DrawPrintf (display *disp, int32 x, int32 y, int align, char *fmt, uint32 arg1, ...) {
#endif
	#ifdef __amigaos4__
	char *txt;
	va_list args;
	va_startlinear(args, fmt);
	txt = VASPrintf(fmt, va_getlinearva(args, void *));
	va_end(args);
	if (txt) {
		DrawText(disp, txt, x, y, align);
		FreeVec(txt);
	}
	#else
	char txt[64];
	VSNPrintf(txt, 64, fmt, &arg1);
	DrawText(disp, txt, x, y, align);
	#endif
}
