#ifndef _GFONT_HEADEG_
#define _GFONT_HEADEG_

bool LoadFontGFX();
void DestroyFont();
void DrawMyFontCenter(BITMAP *dst, int x, int y, int color, char *c);
int  GetFontID(char c);

#endif
