/* --------------------------------------------------------------------- */
#define LO_RES

#ifdef HI_RES
#define XMAX 640
#define YMAX 200
#define PLANES 4
#define MAXCOL (1<<PLANES)
#define XASPECT 5
#define YASPECT 11
#endif

#ifdef LO_RES
#define XMAX 320
#define YMAX 200
#define PLANES 5
#define MAXCOL (1<<PLANES)
#define XASPECT 10
#define YASPECT 11
#endif

/* --------------------------------------------------------------------- */
/* EA handy make a long from 4 chars macros redone to work with Aztec*/
#define MAKE_ID(a, b, c, d)\
	( ((long)(a)<<24) + ((long)(b)<<16) + ((long)(c)<<8) + (long)(d) )

/* these are the IFF types I deal with */
#define FORM MAKE_ID('F', 'O', 'R', 'M')
#define ILBM MAKE_ID('I', 'L', 'B', 'M')
#define BMHD MAKE_ID('B', 'M', 'H', 'D')
#define CMAP MAKE_ID('C', 'M', 'A', 'P')
#define BODY MAKE_ID('B', 'O', 'D', 'Y')

/* and these are the IFF types I ignore but don't squawk about */
#define GRAB MAKE_ID('G', 'R', 'A', 'B')
#define DEST MAKE_ID('D', 'E', 'S', 'T')
#define SPRT MAKE_ID('S', 'P', 'R', 'T')
#define CAMG MAKE_ID('C', 'A', 'M', 'G')
#define CRNG MAKE_ID('C', 'R', 'N', 'G')
#define CCRT MAKE_ID('C', 'C', 'R', 'T')

/* --------------------------------------------------------------------- */
/* Some macros for raster memory allocation ... redefine if you're
   sensible and manage memory locally */

/* ralloc - raster alloc*/
#define ralloc(amount)  (PLANEPTR)AllocMem((long)(amount), MEMF_CHIP)
/* rfree - raster free*/
#define rfree(pt, amount)	FreeMem( (pt), (long)(amount) )

/*line_bytes = the number of words * 2 (for bytes) a raster line takes up */
#define line_bytes(width)	(((width+15)>>4)<<1)

/* psize - plane size in bytes (an even number) of a raster given
   width and height */
#define psize(width, height) ( line_bytes(width)*height)

/* the place to throw excess bits */
#define bit_bucket(file, length) fseek(file, (long)(length), 1)


/* --------------------------------------------------------------------- */
union bytes4
	{
	char b4_name[4];
	long b4_type;
	};

struct iff_chunk
	{
	union bytes4 iff_type;
	long iff_length;
	};

struct form_chunk
	{
	union bytes4 fc_type; /* == FORM */
	long fc_length;
	union bytes4 fc_subtype;
	};

struct BitMapHeader
	{
	UWORD w, h;
	UWORD x, y;
	UBYTE nPlanes;
	UBYTE masking;
	UBYTE compression;
	UBYTE pad1;
	UWORD transparentColor;
	UBYTE xAspect, yAspect;
	WORD pageWidth, pageHeight;
	};

/*ILBM_info is the structure read_iff returns, and is hopefully all
  you need to deal with out of the iff reader routines below*/
struct ILBM_info
	{
	struct BitMapHeader header;
	UBYTE cmap[MAXCOL*3];	/*say hey aztec don't like odd length structures*/
	struct BitMap bitmap;
	};


/* --------------------------------------------------------------------- */
struct ILBM_info *read_iff(char *, struct ILBM_info *, short);
int write_iff(char *, unsigned char *, register struct BitMap *, short, short, short, short);
void free_planes(register struct BitMap *);

/* Anyone know where some useful minterms are defined? */
#define COPY_MINTERM		0xc0
