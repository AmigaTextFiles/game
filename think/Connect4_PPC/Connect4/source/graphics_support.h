#ifndef GRAPHICS_SUPPORT_H
#define GRAPHICS_SUPPORT_H

#include <graphics/gfx.h>
#include <graphics/view.h>

//Uncomment to debug remapbitmap()
//#define GRAPHICS_SUPPORT_DEBUG


struct pen {
    LONG number;
    ULONG red;
    ULONG green;
    ULONG blue;
};

void remapbitmap (struct BitMap *bitmap, struct ColorMap *cm, ULONG *palette, struct pen *pens, UWORD num_pens);
void freeallocatedpens (struct ColorMap *cm, struct pen *pens, UWORD num_pens);
struct BitMap *bodytobitmap (ULONG width, ULONG height, ULONG depth, CONST UBYTE *body);

// Pass NULL for compression if you don't want loadiff() to fill in this value
BOOL loadiff (CONST_STRPTR filename, ULONG *width, ULONG *height, ULONG *depth, ULONG *compression, UBYTE **body, ULONG **palette);

#endif


