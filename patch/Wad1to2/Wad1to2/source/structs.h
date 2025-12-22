struct wad_header
{
	char type[4];
	int num_entries;
	int dir_start;
};

struct directory
{
	int start;
	int length;
	char name[8];
};


/*- The level structures ---------------------------------------------------*/

struct Thing
{
   short xpos;      /* x position */
   short ypos;      /* y position */
   short angle;     /* facing angle */
   short type;      /* thing type */
   short when;      /* appears when? */
};

struct Vertex
{
   short x;         /* X coordinate */
   short y;         /* Y coordinate */
};

struct LineDef
{
   short start;     /* from this vertex ... */
   short end;       /* ... to this vertex */
   short flags;     /* see NAMES.C for more info */
   short type;      /* see NAMES.C for more info */
   short tag;       /* crossing this linedef activates the sector with the same tag */
   short sidedef1;  /* sidedef */
   short sidedef2;  /* only if this line adjoins 2 sectors */
};

struct SideDef
{
   short xoff;      /* X offset for texture */
   short yoff;      /* Y offset for texture */
   char tex1[8];	/* texture name for the part above */
   char tex2[8];	/* texture name for the part below */
   char tex3[8];	/* texture name for the regular part */
   short sector;    /* adjacent sector */
};

struct Sector
{
   short floorh;    /* floor height */
   short ceilh;     /* ceiling height */
   char floort[8];	/* floor texture */
   char ceilt[8];	/* ceiling texture */
   short light;     /* light level (0-255) */
   short special;   /* special behaviour (0 = normal, 9 = secret, ...) */
   short tag;       /* sector activated by a linedef with the same tag */
};

