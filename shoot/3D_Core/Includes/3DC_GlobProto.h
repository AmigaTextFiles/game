/****************************************/
/*** Global Data & Prototypes Include ***/
/***  v1.09  14/03/98  By J.Gregory   ***/
/****************************************/


/**************************/
/*** External functions ***/
/**************************/

void   ASM_ConvScreen(APTR chunky, APTR plane0);

void   ASM_ScaleSpriteN(APTR worksprite, APTR chunkytab);
void   ASM_ScaleSpriteT(APTR worksprite, APTR chunkytab);
void   ASM_FillMemLong(APTR ptr, ULONG count, ULONG pattern);
void   ASM_DrawClipChunky(APTR ckspr,APTR cktab, WORD x, WORD y, ULONG flg);
void   ASM_BoxChunky(APTR cktab, WORD x, WORD y, WORD w, WORD h, BYTE c);
void   ASM_DrawClipPlan(APTR plspr, APTR bmap, WORD x, WORD y);
LONG   ASM_ClipLine(struct Rect *line, struct Rect *scrsize);
void   ASM_DrawLine(struct Rect *line, APTR cktab, struct Rect *scrrect,
                    struct Rect *cliprect, LONG colour);
void   ASM_DrawPoly(APTR scrnwork, APTR cktab, struct Rect *scrrecr,
                    APTR vertlist, LONG vertcount, LONG colour);
void   ASM_ColTrans(APTR chnkscrn, APTR coltrntab, LONG longs);
UWORD  ASM_KeyStatus(APTR keyarray, ULONG keycode); /* 1=down 0=up */
void   ASM_QuickSort(APTR sortvalues, ULONG items);
void   ASM_Rotate_World(APTR RotWork,APTR ActObj,APTR DepList,
                        APTR TrigTab,APTR VPWobj); 
LONG   ASM_FindOctant(LONG x1, LONG y1, LONG x2, LONG y2);
LONG   ASM_FindAngle(LONG x1, LONG y1, LONG x2, LONG y2, APTR tantab);
LONG   ASM_ChkCol(struct ColWork *ColWork); 




/***************/
/*** Defines ***/
/***************/

/*** Main ***/

#define   GLOBPREFSNAME   "Game.Prefs"
#define   GLOBPREFSMAGIC  MAKE_ID('3','D','P','F')

#define   DEBUGLOGBOOL    TRUE
#define   DEBUGLOGNAME    "Debug.log"

/*** Image Support ***/

#define IMG_ID_CHNK MAKE_ID('C','H','N','K')
#define IMG_ID_PLAN MAKE_ID('P','L','A','N')

#define CHNKIMG_SIZE  sizeof(struct ChnkImg)
#define PLANIMG_SIZE  sizeof(struct PlanImg)
#define CHWKIMG_SIZE  sizeof(struct ChnkWork)   
#define IMGHEAD_SIZE  sizeof(struct ImgHead)
#define WALLIMG_TYPE  1

/*** View Support ***/

#define PLANES      6       /* Double buffered display parameters */
#define WIDTH       320
#define HALFWIDTH   160
#define HEIGHT      130
#define HALFHEIGHT  65

#define CTRLPLANES  5       /* Control panel display parameters */
#define CTRLWIDTH   320
#define CTRLHEIGHT  70

#define AREABUFSIZE 400     /* Size in bytes of vertex buffer for polydraw */

/*** Audio Support ***/

#define MAXSAMPLES    128
#define SAMP_DONE     0
#define SAMP_PENDING  1
#define SAMP_LAUNCHED 2

#define SNDLOWPRI     0     /* Standard Sound Playing Priorities */
#define SNDMEDPRI     40
#define SNDHIPRI      80


/*** Misc Support ***/

#define RANDTABSIZE   4096
#define RANDTABNAME   "Rand.Table"
#define COLTRAN64ID   MAKE_ID('C','T','6','4')
#define COLTRAN64SZ   64L

/*** Handlers ***/

#define HDLRFLG_DAMAGE    1               /* Flags presence of HP struct */
#define AHDLRLOID          500000         /* Valid Active Handler ID's   */
#define AHDLRHIID          599999
#define PHDLRLOID          600000         /* Valid Passive Handler ID's  */
#define PHDLRHIID          699999


/*** Object Support ***/

#define DEFHEAD1SIZE   sizeof(struct DefHeader1)
#define DEFHEAD2SIZE   sizeof(struct DefHeader2)
#define OBJDEFSIZE     sizeof(struct ObjDef)
#define OBJDEFMAGIC    MAKE_ID('O','B','D','F')
#define WOBJMAGIC      MAKE_ID('W','O','B','J')
#define DISKWOBJSIZE   sizeof(struct DiskWObj)
#define WOBJECTSIZE    sizeof(struct WObject)
#define ACTOBJSIZE     sizeof(struct ActObj)
#define COLAREASIZE    sizeof(struct ColArea)
#define DEPENTSIZE     sizeof(struct DepthEntry)
#define IMGVIEWS       8
#define MAXWOBJECT     2000
#define MAXCOLAREA     500 
#define MAXACTOBJ      500

#define SPINDEXSIZE    16384<<1       /* 128*128 WORDS SPIndexTab Size   */
#define SPZONES        16384          /* Number of SP Zones - 128*128    */
#define SPMAXBLOCKS    128            /* Number of SP Zones on each axis */
#define SPWOBRNGMAX    20             /* Max Active Wobject Range (Blks) */
#define SPWOBRNGDEF    4              /* Default Active Object Distance  */

#define LOSTABSIZE     2048           /* Define LOS Sort Table Size      */
#define LOSTABCNT      512            /* Max LOSTab LONG's (size/4)      */

#define TRIGTABSIZE    8192L
#define TRIGTABNAME    "SinCos.Table"
#define HEADINGTABSIZE 8192L
#define HEADINGTABNAME "Heading.Table"
#define TANTABSIZE     1024L+512L
#define TANTABNAME     "Tan.Table"

#define MAPSCALESHIFT  8
#define MAPSCALE       256L
#define SLIVERWIDTH    24

#define WORLDXMIN      (-39999 << 8)  /* All multiplied by 256 */
#define WORLDXMAX      ( 39999 << 8)
#define WORLDYMIN      (-39999 << 8)
#define WORLDYMAX      ( 39999 << 8)
#define WORLDHMIN      (-10000 << 8)
#define WORLDHMAX      ( 10000 << 8)

#define WOBMOVED       1L         /* Moved flag Only used on VP Object */
#define NULLCOORD      500000000  /* Standard out of range coord       */




/*****************************/
/*** Structure Definitions ***/
/*****************************/

/*** Main ***/

struct C3DPrefs {       /*** 3D_Core Prefs Struct ***/
  LONG  Magic;          /* Preferences Magic ID     */
  LONG  DxOffset;       /* Current View DxOffset    */
  LONG  DyOffset;       /* Current View DyOffset    */
  UBYTE KeyFwd;         /***  Current Key Prefs   ***/
  UBYTE KeyBak;
  UBYTE KeyLft;
  UBYTE KeyRgt;
  UBYTE KeySide;
  UBYTE KeyAct1;
  UBYTE KeyAct2;
  };

/*** Image Support ***/

/* NOTE - Entries from >nn< onwards aditional to disk strutures */
/*        also 1st 12 bytes of header structs must stay same.   */

/* Also note that the image data follows directly after feader  */
/* and in the case of chunky images the line table is directly  */
/* after the image data.  Pointers are calc'd for ease of use.  */

/* Note wall images have the WALLIMG_TYPE bit set in their flags field */ 
/* and are only 1 pixel wide !!!                                       */

struct ChnkImg {          /**** Chunky Image Header  ****/
  ULONG Magic;            /*  00  Magic file ID "CHNK"  */
  UWORD ID;               /*  04  Image ID Number       */  
  UWORD PxWidth;          /*  06  Pixel width of image  */
  UWORD PxHeight;         /*  08  Pixel Height of image */
  UWORD Depth;            /*  10  Colour Depth (Planes) */
  ULONG Flags;            /*  12  Images Flags Lonword  */
  struct ChnkImg *Next;   /*  16  Pointer to next image */
  ULONG *Data;            /* >20< Pointer to image data */
  ULONG *LineTab;         /*  24  Pointer to line table */
  ULONG Size;             /*  28  Image size in bytes   */
  struct ChnkImg *Prev;   /*  32  Pointer to previous   */
  };                      /* [36] Image is allways 1byte per pixel */

struct PlanImg {          /**** Plannar image header ****/
  ULONG Magic;            /*  00  Magic file ID "PLAN"  */
  UWORD ID;               /*  04  Image ID Number       */
  UWORD EbWidth;          /*  06  Even byte image width */
  UWORD PxHeight;         /*  08  Pixel height of image */
  UWORD Depth;            /*  10  Colour depth (Planes) */
  ULONG Flags;            /*  12  Image Flags Longword  */
  struct PlanImg *Next;   /*  16  Pointer to next image */
  ULONG Size;             /* >20< Plane size in bytes   */
  struct PlanImg *Prev;   /*  24  Pointer to previous   */
  };                      /* [28] Planes follow header  */

struct ImgHead {          /**** Typeless image header****/
  ULONG Magic;            /* Magic file ID              */
  UWORD ID;               /* Image ID Number            */
  UWORD Width;            /* Width unit depends on type */
  UWORD Height;           /* Height of image            */
  UWORD Depth;            /* Image Depth (planes)       */
  ULONG Flags;            /* Image Flags Field          */
  struct ImgHead *Next;   /* Pointer to next image N/A  */
  };                      /* [20] Bytes                 */

/* Following structure is temporary work structure used by scaler */
/* items marked with ! are filled in by sprite scaler to allow    */
/* Area checking after rendering.                                 */

struct ChnkWork {         /*** Chunky scaler work struct ***/
  UWORD ID;               /* 00 Image ID Number            */
  UWORD PxWidth;          /* 02 Pixel width of image       */
  UWORD PxHeight;         /* 04 Pixel height of image      */
  ULONG Size;             /* 06 Size in bytes of image     */
  WORD  XCentre;          /* 10 Images centre X-coord      */
  WORD  YCentre;          /* 12 Images centre Y-coord      */
  UWORD Scale;            /* 14 Required scale (512=x1)    */
  UWORD ScWidth;          /* 16+ Scaled width              */
  UWORD ScHeight;         /* 18+ Scaled height             */
  WORD  ScaledX;          /* 20+ Left edge of scaled image */
  WORD  ScaledY;          /* 22+ Top edge of scaled image  */
  ULONG *Data;            /* 24 Pointer to image data      */
  ULONG *LineTab;         /* 28 Pointer to line table      */
  struct ChnkWork *Next;  /* 32 Pointer to next work iamge */
  };                      /* [36] Bytes                    */

/*** View Support ***/

struct Rect {             /*** Rectangle Data Structure  ***/
  LONG  X1;
  LONG  Y1;
  LONG  X2;
  LONG  Y2;
  };                      /* [16] Bytes                    */

/*** Interupt Support ***/

struct VBData {
  LONG Count;            /* Vertical Blank count            */
  LONG TermAud[4];       /* Audio Channel Termination times */
  };                     /* [20] Bytes                      */

/*** Audio Support ***/

struct Sample {       /** Sample Header Structure **/
  BYTE *Data;         /* Pointer to sample data    */
  LONG Length;        /* Length of sample in bytes */
  };                  /* [8] Byes                  */

struct Channel {      /** Pending Channel Sample  **/
  BYTE  *Data;        /* Pointer to sample data    */
  UWORD Length;       /* Length of sample in bytes */ 
  WORD  Volume;       /* Volume to play at         */
  WORD  Period;       /* Byte Period               */
  BYTE  Pri;          /* Sound priority            */
  BYTE  Status;       /* Sample status             */
  WORD  Handle;       /* Sound play handle         */
  LONG  Blanks;       /* VBlanks duration (calced) */
  };                  /* [20] Bytes                */

/*** Handlers ***/

/* DataSize & Flags fields are compulsory
   in all extended data structures

   The hitpoints structure must be next if
   Flag HDLRFLG_DAMAGE is set !

   QuadHP[0] = Front
   QuadHP[1] = Right
   QuadHP[2] = Back
   QuadHP[3] = Left
*/

struct ExtDatHdr {                        /* Generic Data struct start   */
  LONG DataSize;                          /* Size of ext data structure  */
  LONG Flags;                             /* compulsory flags field      */
  LONG ExtData;                           /* Replace this with user data */
  };                                      /* [12] Bytes                  */

struct HitPoints {                        /* Damage Capacity structure   */
  WORD TotHP;                             /* Total Hit Points            */
  WORD QuadHP[4];                         /* Hit pts for each quadrant   */
  WORD Damage;                            /* Damage done by this Object  */
  };                                      /* [12] Bytes                  */

/* Active  Object handler ID's from 500000->599999 - Handler = *WObject
   Passive Object handler ID's from 600000->699999 - handler = *ColFunc
*/

struct HandlerInfo {
  struct HandlerInfo *Next;          /* Pointer to next handler in chain */
  LONG  ID;                          /* Handler ID (used to bind to map) */
  LONG  ID2;                         /* Handler ID (End if range of id's)*/
  BYTE  Info[25];                    /* Handler text (misc info)         */
  APTR  Handler;                     /* Pointer to WOBject or Handler    */
  };                                 /* [37] Bytes                       */

struct Binder {
  struct Binder *Next;                 /* Next Potential Handler Binding */
  LONG ID;                             /* Start ID of required Handler   */
  LONG Wx;                             /* Store Map Objects Key Data     */
  LONG Wy;
  LONG Hgt;
  LONG Head;
  LONG Size;
  LONG Radius;
  LONG ObjDef[4];
  };                                   /* [40] Bytes                     */

/*** Object Support ***/

struct DefHeader1 {     /***      Objdef file header   ***/
  ULONG Magic;          /* Magic file ID "OBDF"          */
  ULONG Count;          /* Number of object defs in file */
  };                    /* [8] Bytes                     */

struct DefHeader2 {     /*** WObject/ColArea file header ***/
  ULONG Magic;          /* Magic file ID "WOBJ"            */
  ULONG Count1;         /* Number of objects in file       */
  ULONG Count2;         /* Number of colarea in file       */
  };                    /* [12] Bytes                      */

/* The above structure is the disk header for an object definition
group, only one such group can be loaded at one time */

struct ObjDef  {        /*** Object definition   ***/
  ULONG ID;             /* Object Definition ID    */
  UBYTE Name[16];       /* Objects Definition Name */
  UWORD Size;           /* Object size             */
  UWORD Frames;         /* Number of anim frames   */   
  UWORD Views;          /* Number of views 1/8/16  */
  UWORD FDelay;         /* Frame delay (VBlanks)   */
  ULONG Flags;          /* Object definition flags */ 
  ULONG ImgID[32];      /* Chunky image ID's       */
  };                    /* [160] Bytes             */

/* The above structure is a base object definition with the
following features :-

FRAME COUNT SYNC ANIMS
======================
Framecount sync'd animations are signified by a frame
count > 32.  The animation frame in this case is calculated
from the frame count so all objects are sync'd regardless
of how long they have been vissible.  Restrictions on these
objects areas follows :-

1> May not have more than 1 view
2> Must be 2,4,8,16 or 32 frames

The frame count is based on the frame count minus 32, this
is then used as a shift value, so :-

33=2  Frame sync anim
34=4  Frame sync anim
35=8  Frame sync anim
36=16 Frame sync anim
37=32 Frame sync anim

The frame delay for sync'd objects is a shift value so :-
(0=50fps, 1=25fps, 2=12.5fps, 3=6.25fps etc)

VIEW FRAME ORDERING
===================
Image Ordering 1 Front
               2 Front Left
               3 Left
               4 Back Left
               5 Back
               6 Back Right
               7 Right
               8 Front Right

OBJID RESOLUTION & IMAGE TYPE FLAGS
===================================               
The object ID's are resolved into pointers to Chnkimg
structures when loaded from disk.  The above structures
are stores on disk in a group file which is basically an
array of structures with a magic ID & item count.

Defined flags - Bit 0 WALLIMG_TYPE objdef flagged as wall
                if nay image has this flags set !!!!!!
                1 View plus sliver scaling used to SLIVERWIDTH.

WOBJECT FLAGS
=============

Defined flags - Bit 0 - WOBMOVED - WObject has moved if set (VP Only)

IMAGE VIEW TYPES ETC.
=====================
1 View    32 Anim frames max
Ordered 1 to n  (May be frame sync'd)

8 Views   4 Anim frames max
Ordered 1(FRONT) to 8(FRONT RIGHT)

16 Views  2 Anim frames max
Ordered 1(FRONT) to 16(FRONT FRONT RIGHT)

*/

struct ActObj {
  struct WObject *Obj;    /*** Pointer back to parent object           ***/
  UWORD  Frame;           /* Current frame of objdef                     */
  ULONG  Time;            /* Time of last frame anim change (VBlanks)    */
  UWORD  Angle;           /* Angle to Obj falls in (only if obj in view) */
  UWORD  VPAng;           /* Angle to VP (may or may not be set)         */
  struct ObjDef *ActDef;  /* Pointer to current ObjDef                   */
  struct ChnkWork Chky;   /* Chunky sprite work structure                */
  LONG   Vx;              /* Object View point Relative X Co-ord         */
  LONG   Vy;              /* Object View point Relative Y Co-ord         */
  LONG   Rx;              /* Object World Transformed (rotated) X Co-ord */
  LONG   Ry;              /* Object World Transformed (rotated) Y Co-ord */
  LONG   Dist;            /* Accurate Distance to Object                 */
  };                      /* [74] Bytes                                  */

struct WObject {          /*** Full blown internal version of WObject  ***/
  LONG  Wx;               /* Object X World Co-ord                       */
  LONG  Wy;               /* Object Y World Co-ord                       */
  LONG  Height;           /* Object Height (Vertical Position)           */
  WORD  Heading;          /* Object Heading (Degrees)                    */
  LONG  Size;             /* Object Size (Size multiplier for scaling)   */
  LONG  Radius;           /* Collision radius                            */
  LONG  Speed;            /* Current object speed                        */
  ULONG ObjDef[4];        /* Array of ID's or later Pointers to ObjDef's */
  UWORD ActObj;           /* Index number of active object data          */
  APTR  Data;             /* Pointer User Data                           */
  LONG  Flags;            /* Optional WObject type                       */
  LONG  ID;               /* WObjects ID (Optional)                      */
  ULONG  IntID;           /* Internal WObject Allocation ID              */
  struct WObject *Next;   /* Next object pointer for list constructs     */
  struct WObject *Prev;   /* Prev object pointer for list constructs     */
  void  (*MovFunc) (struct WObject *host);
  WORD  (*ColFunc) (struct WObject *host, struct WObject *target);
  };                      /* [76] Bytes                                  */

struct DiskWObj {         /** Disk Version of WObject From World Editor **/
  LONG  Wx;               /* All Elements of same name related           */
  LONG  Wy;               /* Note co-ord base of editor is 256 times     */
  LONG  Height;           /* smaller than internal co-ord so upon load   */
  LONG  Heading;          /* shift left by MAPSCALESHIFT to multiply up  */
  LONG  Size;             /* This Scaling applies to Radius,Height and   */
  LONG  Radius;           /* speed as well as Wx & Wy                    */
  LONG  Speed;
  LONG  ObID;             /* Object ID/Type                              */
  ULONG ObjDef[4];        /* [48] Bytes                                  */
  };

struct DepthEntry {       /*** Visible Object Depth Lsit for Sort ***/
  ULONG  Depth;           /* Distance ahead of viewpoint            */
  struct ActObj *AOb;     /* Pointer back to related actobj         */
  };                      /* [8] Bytes                              */

struct ColArea {          /***  Collsion area Definition   ***/  
  LONG    Wx;             /* Left Edge X Co-ord of ColArea   */
  LONG    Wy;             /* Top Edge Y Co-ord of ColArea    */
  LONG    Wx2;            /* Width/Right Edge X Co-ord       */ 
  LONG    Wy2;            /* Depth/Bottom Edge Y Co-ord      */
  LONG    Floor;          /* Floor of ColArea                */
  LONG    Ceil;           /* Ceiling of ColArea              */
  LONG    ID;             /* Collision Areas ID (Optional)   */
  };                      /* [28] Bytes                      */

struct  ColWork {         /***  Collision Check Data   ***/
  LONG  Wx;               /* Focus X Co-ord (WU)         */
  LONG  Wy;               /* Focus Y Co-ord (WU)         */
  LONG  Height;           /* Focus Height (WU)           */
  LONG  Radius;           /* Focus Radius                */
  APTR  ColArea;          /* ColArea array base          */
  APTR  WObject;          /* TWOb link list start        */
  APTR  SpcPart;          /* SP Pointers array base      */
  APTR  Ignore1;          /* Primary WObject to ignore   */
  APTR  Ignore2;          /* Secondary WObject to ignore */
  LONG  XMin;             /* X Min Boundary (WU)         */
  LONG  XMax;             /* X Max Boundary (WU)         */
  LONG  YMin;             /* Y Min Boundary (WU)         */
  LONG  YMax;             /* Y Max Boundary (WU)         */
  LONG  HMin;             /* Height Min Boundary (WU)    */
  LONG  HMax;             /* Height Max Boundary (WU)    */
  LONG  R1Start;          /* SP Row 1 start index        */
  LONG  R1End;            /* SP Row 1 end index          */
  LONG  R2Start;          /* SP Row 2 start index        */
  LONG  R2End;            /* SP Row 2 end index          */
  LONG  Ret[41];          /* Returns data array          */
  };                      /* [240] Bytes                 */

/* The WObject structure is the basic building block of the world, it
contains a list of object definitions associated with the object and
contains the objects world & view relative co-ords.  The ActObj
entry is an index into the active (possibly visible) object table, a
value of 0xFFFF in this field means the object is not active.

The Data pointers in the WObject structure are for non standard extended
information.  The 1st LONG of this data is the size of the extended
info block in bytes (including the length field).  This is allow for
object cloneing without knowing what is within a prototype extended
info block.  The info block it's self should be allocated using AllocVec
and will be freed when the object is free'd of deallocated.

NOTE - Extended info blocks must be on a longword boundary and a multiple
       of 4 in size as CopyMemQuick() is used to clone them.

**** ColAreas & WObjects must be free'd using the supplied functions ****

The ActObj structure contians all the information required to depth
sort & render an object if required.  These structures are held in an
array.  A NULL Obj pointer indicates the entry is free to be used.

A WObject array entry is dead and useable if the size is set to 0 !!!!
Free WObjects are recorded in a list, the list header is FreeWObHead,
a pointer to the next free WObject is stored in Next, the list is
terminated with NULL.  Allocated objects are also linked together in this
fashion using UsedWObHead.  The used list is also has a previous chain.

NOTE - ID Numbers must not be NULL as these are ignored.

An object is a non collision object if it's radius <=0, this allows for
non collision objects have an effect on LOS checking.

The MovFunc is called for each object prior to drawing the current
frame.  This routine is passed a pointer to the WObject and should
carry out any movement or proximity checking required.  If the required
move causes a collision the function ColFunc should be called for both
WObjects involved.

The ColFunc function is called for any WObject involved in a collision.

ColAreas them selves are totally inanimate collsion areas and do not have
move or collision functions.  The Wx2,Wy2 values are actually width and
depth values on disk and are converted at load time.

Invisible hazards will have to be WObjects with a null or very small
image.

The time field in ActObj is recorded when a frame change occures,
the next frame change can then be applied after a preset number of frames.
this should keep anim speed consistant.

Sine/Cosine table pointer points to 1024 LONGS SIN(0-359) Followed by
1024 LONGS COS(0-359) Totals 1024*4*2 = 8192 bytes.

An array of DepthEntry structures that are in front of viewpoint is
produced by the world to view transform (rotation), this is then
quick sorted.

Object Sizes follow scaling model with 512 being 1:1 1024 x 2 etc.

The ChnkWork structure within ActObj structure for a vissible object
contains info on where and how big it is on the screen.  This coupled
with the depthlist can be used for detemining what lies under any given
screen co-ordinate with certain limitations.

Collision Detection
===================
Some WObjects may not have a collsion radius this is signified by the
Radius field being <= 0.  The gobal variable FirstColWOb contains
a pointer into the WObject array that collsion objects start at.
This is to allow large numbers of non collsion objects to be used without
bogging down the collision detection functions.  The ColArea array is
terminated by a 0 Width entry, a negative Width entry is free for re-use.

For a more detailed description of the v2.0 collision checking see
docs/CollSys_v2.0
*/

struct RotateWork {   /*** Work structure passed to world rotate ***/
  WORD   Angle;       /* Angle to rotate world objects by          */
  UWORD  ObjCount;    /* Size of ActObj or DepthEntry array        */
  LONG   VPFlags;     /* Viewpoint flags (i.e. moved etc)          */
  LONG  *TanTable;    /* Pointer to HP Tangents Table              */
  WORD  *CosTable;    /* Pointer to HP Cosine Table                */
  };                  /* [14] Bytes                                */

/* The above structure is used as temporary workspace by World
   rotation code. On entry to rotation code ObjCount is set to
   size of ActObj array on exit it contains number of entries in
   new DepthList.


                  . 4 .       
  Octant 0        .   .       Normal view direction (Octant 0)
 0 Degrees      5  . .  3     is a 0 degree heading 
                   . .        
     |        ..    .    ..   View point heading rotation is
     V          ..  .  ..     closwise
              6   .....   2   
   Normal       ..  .  ..     Object heading rotations are 
    View      ..    .    ..   clockwise
 Direction         . .        
                7  . .  1     The octant ordering is
                  .   .       anti-clockwise
                  . 0 .       
                  
Find Octant has been replaced by ASM_FindAngle 


Random Floor Objects
====================
Added floor plain detail can be achieved by using random floor plane
objects.  The area within "FlrObjRange" is allways populated with
"FlrObjDensity" number of objects.  These objects are placed randomly.
When one is removed another is added on the oposite side of the range
clipping box.  The feature is anabled in the resource script using the
following :-

  FLROBJRANGE=<range> Range must be > 8192 and < than main clip range.
FLROBJDENSITY=<count> Count is the number of items within range. 
       FLROBJ=<ObdfID>,<Height>
       
There may be upto 10 FLROBJ entries.  One template is generated for
all floor objects and a seperate FlrObj template array contains the
variable info about the floor objects (E.G. ObjDef & Height).

A pointer "FirstFlrObj" points to a reserved block of WObjects used
for floor objects.  This block is allocated before "FirstColWOb" as
floor objects are not collisonable.  There are ALLWAYS "FlrObjDensity"
Floor objects in existance.

NOTE - A zero in FlrObjDensity dissables floor objects system
*/

struct FlrObjTemp {       /*** Random floor object template array ***/
  LONG          Height;   /*  Height floor object is to appear at   */
  struct ObjDef *Obdf;    /*  Pointer to related object definition  */
  };                      /*  [8] Bytes                             */

/*
SPACE PARTITIONING
==================
All fixed terrain objects between FirstColWOb & LastNMovWOb are sorted
into 128 x 128 grid.  The world size is assumed to be 32768 in both X & Y
directions.  After the map has been loaded a table of 16384 base offsets
is created.  The offset is to the 1st pointer in an array of pointers to
the WObjects in that area.  
*/


/*******************/
/*** Global Data ***/
/*******************/

/*** Main ***/

struct IntuitionBase  *IntuitionBase  = NULL;
struct GfxBase        *GfxBase        = NULL;
struct Library        *IFFParseBase   = NULL;
struct Task           *C3D_Task       = NULL; /* Pointer to own task */

struct Custom *custom     = (struct Custom *) 0xDFF000; 
struct C3DPrefs *C3DPrefs = NULL;

BYTE *CurColTran = NULL; /* Current Active Colour Translation */

/*** Chunky Screen Support ***/

UBYTE *ChunkyScr = NULL;       /* Chunky screen pointer */
ULONG *ChunkyTab = NULL;       /* Pointer to chunky screen line table */
UBYTE *ColTran64 = NULL;       /* Pointer to 64 entry col trans table */

/*** Image Support ***/

struct ChnkImg  *FirstChnkImg  = NULL;  /* Pointer to 1st chunky image   */
struct PlanImg  *FirstPlanImg  = NULL;  /* Pointer to 1st plannar image  */
struct ChnkWork *FirstChnkWork = NULL;  /* Pointer to 1st work structure */
struct ChnkImg  *SkyImage      = NULL;  /* Pointer to SkyLine Image      */
struct ChnkImg  *FloorImage    = NULL;  /* Pointer to Ground image       */
struct ChnkImg  *Font6x9Image  = NULL;  /* Pointer to 6x9 Font Image     */

/*** View Support ***/

char ScrCMap[] = "CMap1.IFF";               /* Colour Map File Names  */
char PnlCMap[] = "CMap2.IFF";
 
struct View     view0,view1;                /* Global View Param Data */
struct View     *oldview    = NULL;
struct ViewPort viewport0   = {0};
struct ViewPort viewport1   = {0};
struct ViewPort viewport2   = {0};
struct RasInfo  rasinfo0,rasinfo1,rasinfo2;
struct BitMap   bmap0       = {0};
struct BitMap   bmap1       = {0};
struct BitMap   bmap2       = {0};
struct ColorMap *cmap0      = NULL;
struct ColorMap *cmap1      = NULL;
struct ColorMap *cmap2      = NULL;
struct RastPort *CPRPort    = NULL;
struct Rect     ScrnRect;
struct Rect     ClipRect;

UBYTE C3D_ViewStatus = 0;     /* 0=WB_view 1=view0 2=view1 */
UBYTE *C3D_ActPlane0 = NULL;  /* Pointer to plane 0 of active view */
LONG  *ScrnWork      = NULL;  /* Pointer to Screen Line Start/End table */

/*** InputSupport ***/

struct IOStdReq    *InReq    = NULL;
struct MsgPort     *InPort   = NULL;
struct Interrupt   *IHandler = NULL;

LONG   DevStat     = -1;
ULONG  C3D_Keys[]  = {0L,0L,0L,0L,0L};

/*****************************************************************/
/* NOTE: 1st 4 longs of C3D_Keys are organised on a byte by byte */
/* and contain a bit for each possible raw key code. the 5th     */
/* longword is a 24 bit flags field +an 8bit last key press store*/
/* Flags - bit 0 - 1 = Process KB events (&pass on)              */
/*               - 0 = Ignore KB events (&pass on)               */
/* For a given raw key code a bit is set in one of the 1st 16    */
/* bytes of C3D_Keys for a key down. byte to check is raw >> 3   */
/* bit to check is remainder (3 bits shifted out)                */ 
/* NOTE: Prior to enabling handler clear 1st 4 longs of C3D_Keys */
/*****************************************************************/

/*** Interupt Support ***/

struct Interrupt *VBInt     = NULL;           
struct VBData    VBD        = {NULL,NULL,NULL,NULL,NULL};
UBYTE            *VBIntName = "C3D VBlank";

/*** Audio Support ***/

struct Sample   *SampList  = NULL;     /* Pointer to Sample Array Base   */
struct MsgPort  *AudioMP   = NULL;     /* Pointer to Message port        */
struct IOAudio  *AudioIO   = NULL;     /* Pointer to IORequest           */
struct Channel  *ChanAlloc = NULL;     /* Pointer to Channel Allocations */
LONG            AudioStat  = -1;       /* Current audio device status    */
WORD            NextSamp   = 0;        /* Next free Sample Array slot    */
WORD            PlayHandle = 1;        /* Sample Play Handle (never < 1) */

/*** Misc Support ***/

WORD *RandTable = NULL;                   /* Pointer to Random Rable     */
WORD  RandSeed  = 0;                      /* Current offset within table */

/*** Handlers ***/

/* NOTE - Binder list is a temporary list used during map load to store
          potential handler binding objects
*/

struct HandlerInfo *HandlerInfo = NULL;   /* Pointer to 1st HandlerInfo  */
struct Binder      *Binder      = NULL;   /* 1st Hdlr Binding Object Ptr */
WORD               Interval     = 0;      /* Interval Base (0-31)        */

/*** Object Support ***/

struct ObjDef     *FirstObjDef = NULL; /* Ptr to ObjDef array            */
struct WObject    *WObject     = NULL; /* Ptr to world Objects array     */
struct ActObj     *ActObj      = NULL; /* Ptr to Active objects array    */
struct ColArea    *ColArea     = NULL; /* Ptr to Collsion Areas          */
struct DepthEntry *DepthList   = NULL; /* Ptr to DepthEntry List         */
struct ColWork    *ColWork     = NULL; /* Ptr to Collision Data Block    */
LONG              *SinCosTab   = NULL; /* Ptr to Sine & Cosine tables    */
LONG              *HeadingTab  = NULL; /* Ptr to Heading to X,Y table    */
LONG              *HP_TanTab   = NULL; /* Ptr to HP Tangent Table        */
WORD              *HP_CosTab   = NULL; /* Ptr to HP Cosine Table         */
LONG              FrameDelay   = 1;    /* FrameDelay in VBlanks          */
LONG              LastTime     = 0;    /* VBlank at end of prior frame   */
LONG              LastTimeA    = 0;    /* VBlank count for FPS limiting  */
LONG              ObjDefCount  = 0;    /* Number of object definitions   */
LONG              FlrObjRange  = 0;    /* Floor Object Active Range      */
LONG              FlrObjDensity= 0;    /* Number of Floor WObs in range  */
WORD              FlrObjCount  = 0;    /* Number of loaded Obdf ID's     */
WORD              LastPermAct  = -1;   /* Last Permanently Active ActObj */
WORD             *SPIndexTab   = NULL; /* Pointer to SP Index Table      */
LONG             *SPWObTab     = NULL; /* SP Table of Pointers to WOb's  */
LONG             *LOSTab       = NULL; /* LOS Sort Table base Pointer    */
ULONG             NextWobID    = 0;    /* WObject ID Number (Next)       */
struct WObject   *FlrTemplate  = NULL; /* Pointer to Floor Template      */
struct WObject   *FirstFlrWOb  = NULL; /* Pointer to 1st floor object    */
struct WObject   *FirstMapWOb  = NULL; /* Pointer to 1st map object      */
struct WObject   *FirstColWOb  = NULL; /* Pointer to 1st collision object*/
struct WObject   *LastNMovWOb  = NULL; /* Pointer to last non move object*/
struct WObject   *FreeWObHead  = NULL; /* 1st Free WObject in list       */
struct WObject   *UsedWObHead  = NULL; /* 1st Used WObject in list       */
struct WObject   *VP           = NULL; /* Ptr to VeiwPoint base class    */
struct FlrObjTemp FlrObjTemp[10];      /* Array for FlrObj Templates     */

LONG              ActiveRange  = SPWOBRNGDEF;  /* WOb Active Dist (Blks) */




/***************************/
/*** Function Prototypes ***/
/***************************/

/*** Main ***/

WORD  C3D_Init(char *res);
WORD  C3D_InitLibs(void);
WORD  C3D_LoadGlobPrefs(void);
WORD  C3D_SaveGlobPrefs(void);
WORD  C3D_OptsMenu(void);
void  C3D_FreeGlobPrefs(void);
void  C3D_Free(void);
void  C3D_FreeLibs(void);
void  C3D_PreMove(void);
void  C3D_DrawHUD(void);
void  C3D_InitLog(void); 
void  C3D_WriteLog(char *str); 

/*** Chunky Screen Support ***/

WORD C3D_InitChunkyScr(UWORD width,UWORD height);
void C3D_FreeChunky(void);

/*** Image Support ***/

WORD   C3D_LoadImage(UBYTE *file);
WORD   C3D_LoadChunky(BPTR handle, LONG size, struct ImgHead *ih);
WORD   C3D_LoadPlannar(BPTR handle, LONG size, struct ImgHead *ih);
void   C3D_FreeImages(void);
struct ChnkImg *C3D_FindChnkImg(UWORD ID);
struct PlanImg *C3D_FindPlanImg(UWORD ID);
void   C3D_FreeChnkImg(UWORD ID);
void   C3D_FreePlanImg(UWORD ID);
void   C3D_Text6x9(char *str,WORD x, WORD y, WORD cshift);

/*** View Support ***/

WORD  C3D_InitDisplay(void);
WORD  C3D_LoadIFFCMap(BYTE *file, struct ViewPort *vp, UBYTE flags);
void  C3D_LoadView(void);
void  C3D_FreeView(void);
void  C3D_SwapView(void);
void  C3D_FreeDisplay(void);

struct RastPort *C3D_BuildRastPort(struct BitMap *bm, struct TextAttr *ta);
void   C3D_FreeRastPort(struct RastPort *rp);

void C3D_Hibernate(void);

/*** Input Support ***/

WORD C3D_InitIHandler(void);
void C3D_FreeIHandler(void);
void ASM_InputHandler(void);
void C3D_EnableIHandler(void);
void C3D_DissableIHandler(void);    /* See Also ASM_KeyStatus() */
WORD C3D_LastKey(void);
WORD C3D_ActionMenu(BYTE *itemstr,BYTE *keys,WORD bgnd,WORD cs1,WORD cs2);

/*** Interupt Support ***/

WORD   C3D_InitInts(void);
void   C3D_FreeInts(void);
void   ASM_VertBServer(void);

/*** Audio Support ***/

WORD C3D_InitAudio(void);
void C3D_FreeAudio(void);
WORD C3D_LoadSample(BYTE *filename);
void C3D_FreeSamples(void);
void C3D_InterruptSample(void); 
void C3D_StartSample(void);
WORD C3D_PlaySample(WORD chan, WORD samp, WORD vol, WORD period, BYTE pri, LONG x, LONG y);
WORD C3D_FindChannel(BYTE pri);
WORD C3D_PlayStatus(WORD handle);

/*** Misc Support ***/

WORD  C3D_InitMisc(void);
void  C3D_FreeMisc(void);
WORD  C3D_LoadRand(void);
WORD  C3D_GetRand(void);
WORD  C3D_LoadResource(BYTE *filename);

WORD  C3D_InitFlrObjSys(char *str);
WORD  C3D_SetFlrObjRange(char *str);
WORD  C3D_SetFlrObjTemp(char *str);
WORD  C3D_CheckFlrObj(void);
WORD  C3D_AllocFlrObj(void);
void  C3D_PopulateFlrObj(void);
void  C3D_UpdateFlrObj(void); 
WORD  C3D_SetSkyImage(char *str);
WORD  C3D_SetFlrImage(char *str);
WORD  C3D_Set6x9Image(char *str);
WORD  C3D_InitVP(char *str);
WORD  C3D_SetActRange(char *str);
WORD  C3D_LoadCT64(char *str);

/*** Handlers ***/

WORD  C3D_BuildTemplates(void);
void  C3D_ClearTemplateBases(void);

/*** Object Support ***/

WORD            C3D_LoadWobjMap(char *mapfile);
WORD            C3D_LoadObjDefs(UBYTE *filename);
void            C3D_FreeObjDefs(void);
WORD            C3D_FixObjDefImages(LONG defcount);
WORD            C3D_FixWObjID(struct WObject *obj);
WORD            C3D_InitObjects(void);
void            C3D_FreeObjects(void);
void            C3D_ClearObjects(void);
UWORD           C3D_FindFreeObject(void);
UWORD           C3D_FindFreeActObj(void);
UWORD           C3D_FindFreeColArea(void);
struct ObjDef  *C3D_FindObjDef(ULONG ID);
void            C3D_FreeActObj(UWORD index);
void            C3D_FreeWObject(UWORD index, struct WObject *obj );
void            C3D_FreeColObj(UWORD index);
WORD            C3D_AllocAct(struct WObject *obj, UWORD obdf, UWORD frame);
WORD            C3D_SetObjImage(UWORD aob, UWORD view);
WORD            C3D_CheckWObjRange(LONG x, LONG y, LONG brad);
void            C3D_CheckActiveWOb(LONG xl, LONG xh, LONG yl, LONG yh);

void            C3D_PlotDepthList(UWORD count,struct WObject *vpt);
void            C3D_MoveVP(void);
void            C3D_MoveWOB(struct WObject *wob, WORD mult);
void            C3D_MoveALL(struct WObject *start);
WORD            C3D_CloneWObject(struct WObject *src,LONG x,LONG y,
                                 LONG hgt,WORD head);
WORD            C3D_SetWObjectFunc(LONG id, void *movfunc, void *colfunc);
WORD            C3D_FindWObject(LONG id,WORD prev);
WORD            C3D_GetQuadrant(LONG x1, LONG y1, LONG x2, LONG y2);
void            C3D_DrawBackdrop(void);
void            C3D_FrameSync(void);  
WORD            C3D_BuildSPTables(void); 
void            C3D_FreeSPTables(void); 
LONG            C3D_Collision(struct WObject *wob, struct WObject *ign);
struct WObject *C3D_CheckLOS(LONG hgt, LONG x1, LONG y1, LONG x2, LONG y2);
WORD            C3D_CheckCollision(struct WObject *wob, struct WObject *ign);
void            C3D_ExchangeDamage(struct WObject *wob1, struct WObject *wob2); 
void            C3D_Damage(struct WObject *wob1, struct WObject *wob2, WORD damage);

void                C3D_FreeHInfo(void);
WORD                C3D_RegHInfo(LONG id,LONG id2, BYTE *name, struct WObject *tplt);
struct HandlerInfo *C3D_FindHInfo(LONG id);
void                C3D_ShowHInfo(void);
void                C3D_FreeBinders(void);
WORD                C3D_BindBinders(void);



