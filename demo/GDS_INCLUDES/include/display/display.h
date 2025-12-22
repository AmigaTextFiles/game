#ifndef GS_DISPLAY
#define GS_DISPLAY

struct gs_rectangle           /* same as Commodore's Rectangle struct */
  {                           /* guarenteed usable even with old 1.3 gfx.h */
  short MinX,MinY;
  short MaxX,MaxY;
  };

struct gs_viewport
  {
  struct gs_viewport *next;   /* pointer to next viewport in display */
  unsigned long *color_table; /* ptr to color table for viewport */
  int num_colors;             /* number of color table entries */
  struct copper_struct *ucop; /* ptr to user copper list (or NULL if none) */
  int height;                 /* height of viewport in scan lines */
  int width;                  /* width of viewport in pixels */
  int depth;                  /* number of bitplanes to use for viewport */
  int bmheight;               /* bitmap height (in rows) (used only if allocating bitmap) */
  int bmwidth;                /* bitmap width (in pixels) (used only if allocating bitmap) */
  int top;                    /* viewport Y offset (in rows) from display start */
  int left;                   /* viewport X offset (in pixels) from display start */
  int xoff;                   /* X offset within bitmap (in pixels) */
  int yoff;                   /* Y offset within bitmap (in pixels) */
  unsigned long flags;        /* flags for display routines */
  void *vpe1;                 /* ptr to 2.xx & up ViewPortExtra struct (SYSTEM USE) */
  void *vpe2;                 /* ptr to 2.xx & up ViewPortExtra struct (SYSTEM USE) */
  struct BitMap *bitmap1;     /* ptr to 1st bitmap struct */
  struct BitMap *bitmap2;     /* ptr to 2nd bitmap struct */
  void *extension;            /* reserved for future expansion */
  struct gs_rectangle dclip;  /* display clip for 2.xx and up displays */
 /* ALL REMAINING FIELDS ARE USED ONLY BY THE GAMESMITH DISPLAY SYSTEM */
 /* HOWEVER, YOU MAY REFERENCE THE VIEWPORT AND RAASINFO STRUCTS IN YOUR PROGRAM */
  struct ViewPort *viewport1; /* system ViewPort struct for 1st display page */
  struct ViewPort *viewport2; /* system ViewPort struct for 2nd display page */
  struct RasInfo *rasinfo1;   /* system RasInfo struct for 1st viewport */
  struct RasInfo *rasinfo2;   /* system RasInfo struct for 2nd viewport */
  unsigned long LOF_BPLCON1;  /* offset to horizontal shift register copper instruction */
  unsigned long LOF_BPLPTR1;  /* offset to 1st bitplane pointer copper instruction */
  unsigned long SHF_BPLCON1;  /* offset to horizontal shift register copper instruction */
  unsigned long SHF_BPLPTR1;  /* offset to 1st bitplane pointer copper instruction */
  unsigned long LOF_BPLCON2;  /* offset to horizontal shift register copper instruction */
  unsigned long LOF_BPLPTR2;  /* offset to 1st bitplane pointer copper instruction */
  unsigned long SHF_BPLCON2;  /* offset to horizontal shift register copper instruction */
  unsigned long SHF_BPLPTR2;  /* offset to 1st bitplane pointer copper instruction */
  unsigned short pf1_scroll;  /* horizontal scroll value, playfield 1 */
  unsigned short pf2_scroll;  /* horizontal scroll value, playfield 2 */
  int xoff2;                  /* playfield 2 X offset within bitmap (system use ONLY!) */
  int yoff2;                  /* playfield 2 Y offset within bitmap (system use ONLY!) */
  unsigned short LOF_cop1;    /* offset to viewport copper list within display list */
  unsigned short SHF_cop1;
  unsigned short LOF_cop2;
  unsigned short SHF_cop2;
  unsigned char *LOF_planes1[8]; /* bitplane pointers for scroll reload */
  unsigned char *SHF_planes1[8]; /* bitplane pointers for scroll reload */
  unsigned char *LOF_planes2[8]; /* bitplane pointers for scroll reload */
  unsigned char *SHF_planes2[8]; /* bitplane pointers for scroll reload */
  };

#define GSVP_ALLOCBM    0x01  /* let the display setup routine allocate bitmap(s) */
#define GSVP_DCLIP      0x02  /* user specified display clip */
#define GSVP_DPF        0x04  /* set viewport to operate in dual playfield mode */

struct display_struct
  {
  struct View *oldview;       /* ptr to previous display view */
  void *ve1;                  /* 2.xx & up ViewExtra struct */
  void *ve2;                  /* 2.xx & up ViewExtra struct */
  int DxOffset;               /* display X offset (in pixels) for 1.3 OS */
  int DyOffset;               /* display Y offset (in rows) for 1.3 OS */
  int modes;                  /* display mode ID */
  unsigned long flags;        /* flags for display routines */
  struct gs_viewport *vp;     /* pointer to 1st viewport in display */
  void *extension;            /* reserved for future expansion */
  struct View *view1;         /* system View struct for 1st display page */
  struct View *view2;         /* system View struct for 2nd display page */
  unsigned short *LOF_cop1;   /* ptr to long frame hardware copper list for view 1 */
  unsigned short *SHF_cop1;   /* ptr to short frame hardware copper list for view 1 */
  unsigned short *LOF_cop2;   /* ptr to long frame hardware copper list for view 1 */
  unsigned short *SHF_cop2;   /* ptr to short frame hardware copper list for view 1 */
  unsigned long LOF_len1;     /* number of words in 1st long frame copper list */
  unsigned long SHF_len1;     /* number of words in 1st short frame copper list */
  unsigned long LOF_len2;     /* number of words in 1st long frame copper list */
  unsigned long SHF_len2;     /* number of words in 1st short frame copper list */
  };

#define GSV_DOUBLE      0x0001   /* double buffered display */
#define GSV_PAGE1       0x0002   /* SYSTEM FLAG: page 1 currently displayed */
#define GSV_EASY        0x0004   /* SYSTEM FLAG: display set up through easy call */
#define GSV_DISPLAYED   0x0008   /* SYSTEM FLAG: custom display has been shown on screen */
#define GSV_FLIP        0x0010   /* set by gs_flip_display & cleared when new page shown */
#define GSV_SCROLL1     0x0020   /* SYSTEM FLAG: reload copper list with new scroll values */
#define GSV_SCROLL2     0x0040   /* SYSTEM FLAG: reload copper list with new scroll values */
#define GSV_ECSENA      0x0080   /* SYSTEM FLAG: used by AGA chipset scroll handling */
#define GSV_BPAGEM      0x0100   /* SYSTEM FLAG: used by AGA chipset scroll handling */
#define GSV_BPL32       0x0200   /* SYSTEM FLAG: used by AGA chipset scroll handling */
#define GSV_AGA_SCROLL  0x0400   /* SYSTEM FLAG: use enhanced AGA scrolling methods */
#define GSV_SUPER       0x0800   /* SYSTEM FLAG: used by AGA chipset scroll handling */
#define GSV_SCROLLABLE  0x1000   /* allow view to be scrolled */
#define GSV_DDFADJUST   0x2000   /* display system adjusted data fetch for smooth scrolling */

/* return values for gs_scroll_vp: */

#define GSVP_PF1_LEFT   0x01  /* playfield 1 display at leftmost edge */
#define GSVP_PF1_RIGHT  0x02  /* playfield 1 display at rightmost edge */
#define GSVP_PF1_TOP    0x04  /* playfield 1 display at topmost edge */
#define GSVP_PF1_BOTTOM 0x08  /* playfield 1 display at bottom most edge */
#define GSVP_PF2_LEFT   0x10  /* playfield 2 display at leftmost edge */
#define GSVP_PF2_RIGHT  0x20  /* playfield 2 display at rightmost edge */
#define GSVP_PF2_TOP    0x40  /* playfield 2 display at topmost edge */
#define GSVP_PF2_BOTTOM 0x80  /* playfield 2 display at bottom most edge */
#define GSVP_NOVP       -1    /* invalid viewport specified */

/* return values from LoadRGB and SetRGB */

/* GSVP_NOVP */
#define GSVP_RANGE      -2    /* color register out of range */

#endif
