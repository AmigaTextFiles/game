#ifndef GS_ANIM
#define GS_ANIM

/* Custom blitter & collision detection structures: */

struct coll_bg_struct    /* object to background collision struct */
  {
  unsigned int mask;     /* collision enable mask */
  unsigned int area;     /* collision area number */
  unsigned short x1;     /* x coord to check */
  unsigned short y1;     /* y coord to check */
  struct coll_bg_struct *next;   /* ptr to next coll_bg_struct for image */
  };

struct collision_struct  /* object to object collision struct */
  {
  unsigned int type;     /* type of collision area */
  unsigned int mask;     /* collision enable mask */
  unsigned int area;     /* collision area number */
  unsigned short x1;     /* left edge of area */
  unsigned short y1;     /* top edge of area */
  unsigned short x2;     /* right edge of area */
  unsigned short y2;     /* bottom edge of area */
  struct collision_struct *next;  /* ptr to next collision struct for image */
  };

struct blit_struct
  {
  unsigned short *data;  /* pointer to blitter image data */
  unsigned short *mask;  /* pointer to mask image */
  unsigned short *save;  /* pointer to image save area */
  int depth;             /* number of bit planes in image */
  int planes;            /* defines which planes to draw into */
  int width;             /* width of data image (in words) */
  int height;            /* height of data image (scan lines) */
  int image_size;        /* size (in bytes) of image (width * height) */
  int x_off;             /* X offset from left edge of image for placement */
  int y_off;             /* Y offset from top edge of image for placement */
  int flags;             /* blitter flags (see below) */
                         /* collision list ptr (null if no collision detect) */
                         /* for background gfx */
  struct coll_bg_struct *coll_bg;
                         /* collision list ptr (null if no collision detect) */
                         /* for anim object area detect */
  struct collision_struct *collision;
  struct blit_struct *prev; /* ptr to previous image in an animation sequence */
  struct blit_struct *next; /* ptr to the next image in an animation sequence */
  int reserved[2];       /* reserved work/storage area for blitter routines */
  };

/* the blitter flags */

#define BLIT_MERGE          0x01000000  /* don't clear unaffected planes */
#define BLIT_1SHOT_FORWARD  0x02000000  /* anim does not repeat when played forward */
#define BLIT_1SHOT_BACKWARD 0x04000000  /* anim does not repeat when played backward */
#define BLIT_DATACOPY       0x08000000  /* data is a copy area, don't free (internal use) */
#define BLIT_CPUBLIT        0x10000000  /* use CPU to blit image instead of blitter */

/* animation structures: */

struct anim_cplx
  {
  unsigned short cnt;        /* number of anim sequences in the complex */
  unsigned short seq;        /* current anim sequence number (0 - n) */
  unsigned short width;      /* maximum width of complex (in bytes) */
  unsigned short height;     /* maximum height of complex (scan lines */
  unsigned short array_num;  /* array element number for duplicate complexes in an array */
  unsigned short label;      /* User label field/ID (actually a number) */
  struct anim_struct *list;  /* ptr to list of anim sequences */
  struct anim_struct *anim;  /* ptr to current anim obj on screen */
  };

struct anim_struct
  {
  struct blit_struct *list;  /* Ptr to 1st image in anim sequence */
  struct blit_struct *img;   /* Ptr to current image on screen */
  struct anim_struct *attach; /* Ptr to next attached anim */
  unsigned short array_num;  /* array element number for duplicate anims in an array */
  unsigned short label;      /* User label field/ID (actually a number) */
  unsigned short count;      /* number of images in the anim sequence */
  short x;                   /* Current X coord of image on screen */
  short y;                   /* Current Y coord of image on screen */
  short xa;                  /* Attached anim X offset from parent */
  short ya;                  /* Attached anim Y offset from parent */
  unsigned short width;      /* Maximum width of image (in bytes) */
  unsigned short height;     /* Maximum height of image (in scan lines) */
  unsigned short cell;       /* Current cell number on screen (0 - nn) */
  unsigned short prio;       /* Image display priority */
  unsigned long flags;       /* Anim flags (see below) */
         /* --------internal use-------- */
  unsigned short shift1;     /* Save area for blitter shift value */
  unsigned short shift2;     /* Save area for blitter shift value */
  void *save1;               /* Ptr to 1st background save area */
  void *save2;               /* Ptr to 2nd background save area */
  unsigned int offset1;      /* Screen offset for save area 1 */
  unsigned int offset2;      /* Screen offset for save area 2 */
  unsigned int savsiz;       /* Size of save area (number of bytes) */
  struct blit_struct *image1; /* Ptr to image displayed in area 1 */
  struct blit_struct *image2; /* Ptr to image displayed in area 2 */
  struct anim_struct *collide; /* Ptr to colliding anim */
  struct anim_struct *prev;  /* Ptr to previous anim obj in animation system */
  struct anim_struct *next;  /* Ptr to next anim obj in animation system */
  struct anim_struct *cplx_next; /* Ptr to next anim obj in anim complex */
  struct anim_cplx *cplx;    /* Ptr to anim_cplx that this obj belongs to */
  };

/* The anim flags: */

#define ANIM_SAVE_BG   0x01000000 /* Flag: save background before blitting image */
#define ANIM_COLLISION 0x02000000 /* Flag: Obj to obj collision detection enable */
#define ANIM_ACTIVE    0x20000000 /* Anim is active in a display system */
#define ANIM_INVISIBLE 0x40000000 /* Flag: made invisible by clear_anim */
#define ANIM_ONSCREEN  0x80000000 /* Anim is displayed on screen */
#define ANIM_CLEAR     0x00010000 /* Flag: if NOT ANIM_SAVE_BG, clear blitter */
                                  /*       image before blitting image */
#define ANIM_COPY      0x00020000 /* Flag: use blit_copy instead of blit_image */
#define ANIM_REVERSE   0x00040000 /* Anim is running in reverse */
#define ANIM_PARENT    0x00080000 /* Flag: Anim is a parent with attached anims */
#define ANIM_MERGE     0x00100000 /* Flag: Merge image data with that on screen */
#define ANIM_FLICKER   0x00200000 /* Flag: Display object only on 1st bitmap */
#define ANIM_COLLISION_BG 0x00400000 /* Flag: Obj to background collision enable */
#define ANIM_IMGCOPY   0x00800000 /* Flag: anim uses copy of images, don't free (internal use) */
#define ANIM_BOUNDS_X1 0x00000100 /* anim obj tried to move past left edge of bounds */
#define ANIM_BOUNDS_Y1 0x00000200 /* anim obj tried to move past top edge of bounds */
#define ANIM_BOUNDS_X2 0x00000400 /* anim obj tried to move past right edge of bounds */
#define ANIM_BOUNDS_Y2 0x00000800 /* anim obj tried to move past bottom edge of bounds */
#define ANIM_CPUBLIT   0x00001000 /* CPU used to blit images in this anim */
#define ANIM_VSPACE    0x00002000 /* object lies in virtual space */
#define ANIM_VCOLLIDE  0x00004000 /* allow object-to-object collisions in virtual space */

struct anim_attach            /* undefined until next release */
  {
  int dummy;
  };

struct anim_load_struct       /* structure for loading binary anim objects from disk */
  {
  char *filename;             /* pointer to ASCIIZ string of file to load (user defined) */
  union
    {
    struct anim_struct *anim; /* pointer to anim struct if file is a simple anim (filled) */
    struct anim_cplx *cplx;   /* pointer to an anim cplx struct if file is a complex anim (filled) */
    } anim_ptr;
  struct anim_attach *attach; /* ptr to attachment array specification (filled) */
  unsigned long *cmap;        /* pointer to an array of color map entries (filled) */
  int cmap_entries;           /* number of color table entries (filled) */
  int cmap_size;              /* number of bits per color value (4 or 8) (user defined) */
  int type;                   /* type 0 = anim, type 1 = complex anim (filled) */
  int array_elements;         /* size of array to create from loaded object (1 - n) (user defined) */
  unsigned long flags;        /* load flags.  Set ONLY user bits.  Some used by CITAS */
  };

/* The user anim load bits */

#define ANIMLOAD_NOCOLOR   0x00000001    /* don't load color table */
#define ANIMLOAD_FASTRAM   0x00000002    /* load anim to Fast RAM if available */
#define ANIMLOAD_NOFASTRAM 0x00000004    /* don't use Fast RAM even if flagged in file */

/* save area allocation flags */

#define SINGLE_BUFF  0x00  /* object will be used in a single buffered display */
#define DOUBLE_BUFF  0x01  /* object will be used in a double buffered display */

#endif
