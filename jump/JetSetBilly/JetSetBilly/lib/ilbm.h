#ifndef ILBM_H
#define ILBM_H

/* ilbm.h */

#define MAKEID(a,b,c,d) (((a)<<24)|((b<<16))|((c)<<8)|(d))

#define ID_FORM	MAKEID('F','O','R','M')
#define ID_ILBM MAKEID('I','L','B','M')
#define ID_BMHD MAKEID('B','M','H','D')
#define ID_CMAP MAKEID('C','M','A','P')
#define ID_CAMG MAKEID('C','A','M','G')
#define ID_BODY MAKEID('B','O','D','Y')

struct BitMapHeader {
  UWORD width, height;
  WORD x,y;
  UBYTE nPlanes;
  UBYTE masking;
  UBYTE compression;
  UBYTE pad;
  UWORD transparentColor;
  UBYTE xAspect, yAspect;
  UWORD pageWidth, pageHeight;
};

#define MAXPLANES 8

struct Picture
{
  struct BitMap bitmap;
  PLANEPTR	MaskPlane;
  UWORD		Width,Height;
  ULONG		DisplayMode;
  UWORD		ColorTable[32];
  ULONG		PlaneSize;
};

#define PICSIZE sizeof(struct Picture)

#endif /* ILBM_H */
