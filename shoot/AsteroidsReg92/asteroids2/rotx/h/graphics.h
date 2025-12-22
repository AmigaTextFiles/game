typedef struct BitMapHeader 
{
 UWORD w,h;
 WORD  x,y;
 UBYTE BitPlanes;
 UBYTE Masking;
 UBYTE Compression;
 UBYTE PadByte;
 UWORD TransCol;
 UBYTE XAspect,YAspect;
 WORD  Width,Height;
};

typedef struct ColorRegister
{
 UBYTE red;
 UBYTE green;
 UBYTE blue;
};

typedef struct imagedata
{
 WORD xc,yc;
 WORD wi,he,wo;
 ULONG length;
 BYTE color;
 UWORD mask;
 UWORD *data;
};

typedef struct vectordata
{
 WORD zero;
 WORD x[30],y[30],num;
 WORD pos,rots;
 UWORD mask;
 BYTE color;
};

typedef struct imagelocation
{
 UWORD player,player2;
 UWORD photon;
 UWORD explosion;
 UWORD shield;
 UWORD asteroid[3];
 UWORD box,line,diamond,mine;
 UWORD asaucer,saucer;
 UWORD battleship;
 UWORD elight;
 UWORD eheavy;
 UWORD xcruiser;
 UWORD fighter;
 UWORD triangle;
 UWORD debris;
 UWORD minelayer;
 UWORD dreadnought;
 UWORD magnetic;
 UWORD expander;
 UWORD displacer;
 UWORD sauphot;
 UWORD dreadshield;
 UWORD rectangle;
 UWORD carrier;
 UWORD hold2;
 UWORD hold3;
 UWORD hold4;
};

typedef struct gameinfo
{
 WORD he,wi,de;
 WORD x1,y1;
 WORD x2,y2;
 WORD dx,dy;
 WORD processor;
};
