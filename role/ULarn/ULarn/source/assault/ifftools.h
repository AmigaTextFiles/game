/* ========================================================================
**
** FILENAME:    iff_tools.h
**
** DESCRIPTION:
**
** IFF ILBM format file reader.
**
**
** -----------------------------------------------------------------------
*/

#ifndef _IFF_TOOLS_H
#define _IFF_TOOLS_H

#include <graphics/gfx.h>


void FreeBitmap(struct BitMap *Bitmap);

struct BitMap *ReadIff(char *FileName, ULONG *Palette);


#endif