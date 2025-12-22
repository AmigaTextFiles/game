/*
 * markers.h
 * =========
 * The markers.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef MARKERS_H
#define MARKERS_H

#include <exec/types.h>


#define WHITE_COLOR   1
#define BLACK_COLOR   8

#define LMARKER_W   17
#define LMARKER_H   15

#define SMARKER_W   7
#define SMARKER_H   7


extern BOOL InitMarkers(struct Screen *scr);
extern VOID FreeMarkers(struct Screen *scr);

extern BOOL UseColoredMarkers(VOID);
extern VOID SetColoredMarkers(BOOL b);

extern VOID DrawLargeMarker(struct RastPort *rp, struct DrawInfo *dri,
			    LONG x, LONG y, UBYTE color);
extern VOID DrawSmallMarker(struct RastPort *rp, struct DrawInfo *dri,
			    LONG x, LONG y, UBYTE color);

#endif /* MARKERS_H */
