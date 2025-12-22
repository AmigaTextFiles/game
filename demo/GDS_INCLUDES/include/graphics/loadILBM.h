#ifndef GS_LOADILBM
#define GS_LOADILBM

/* The BitMapHeader defined by Commodore: */

#ifndef BitMapHeader

typedef struct {
  UWORD w,h;                  /* raster width & height in pixels */
  WORD x,y;                   /* pixel position for image (same as xoff & yoff) */
  UBYTE nPlanes;              /* number of bitplanes (without mask if any) */
  UBYTE masking;              /* mask value (see CBM documentation on ILBMs) */
  UBYTE compression;          /* compression algorithm used on image data */
  UBYTE reserved;             /* reserved; ignore on read, write as 0 */
  UWORD transparentColor;     /* transparent color number, usually 0 (background) */
  UBYTE xAspect, yAspect;     /* pixel aspect, a ratio of width to height */
  WORD pageWidth, pageHeight; /* source "page" size in pixels (same as dwidth & dheight) */
} BitMapHeader;

#endif

struct loadILBM_struct
  {
  unsigned char *file;        /* ptr to ASCIIZ file name to load */
  struct BitMap *bitmap1;	   /* ptr to 1st bitmap struct */
  struct BitMap *bitmap2;     /* ptr to 2nd bitmap struct (if any) */
  unsigned long *color_table; /* ptr to color table for image */
  int num_colors;             /* number of color entries in color_table */
  int dheight;                /* display height (filled from file) */
  int dwidth;                 /* display width (filled) */
  int xoff,yoff;              /* X & Y display offsets (filled) */
  int modes;                  /* display modes (filled) */
  int loadx;                  /* X load offset (from left) in bytes */
  int loady;                  /* Y load offset (from top) in rows */
  int flags;                  /* flags */
  unsigned int fill;          /* mask of planes to fill in bitmap(s) */
  unsigned int select;        /* mask of planes to use from file */
  BitMapHeader *bmh;          /* if not NULL, this must point to a valid */
                              /* BitMapHeader defined by Commodore */
  };

/* the loadILBM flags: */

#define ILBM_COLOR    0x01    /* fill color map with colors from file */
#define ILBM_ALLOC1   0x02    /* allocate one bitmap before loading */
#define ILBM_ALLOC2   0x04    /* allocate two bitmaps before loading */

#endif
