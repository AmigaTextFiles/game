#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfxmacros.h>
#include <intuition/intuition.h>
#include <libraries/dos.h>
#include <libraries/iffparse.h>
#include <graphics/gels.h>
#include <math.h>
#include "h/graphics.h"

#define LOADIMAGENUM 24
#define RENDIMAGENUM 24

#define ID_BODY MAKE_ID('B','O','D','Y')
#define ID_BMHD MAKE_ID('B','M','H','D')
#define ID_ILBM MAKE_ID('I','L','B','M')
struct BitMapHeader *bmhd;

static UWORD Data[200][4][12];

extern struct imagedata id[800];
extern struct vectordata v[40];
extern struct imagelocation il;
extern struct RastPort *rp1[2];
extern struct BitMap *bm1[2];
extern struct RastPort *mwrp;
extern struct gameinfo gi;


LoadILBM(UBYTE *Name,LONG num)
{
struct IFFHandle *hand;
struct StoredProperty *prop;
struct ContextNode *contextnode;
UWORD *pdata;
LONG error,length;

hand = (struct IFFHandle *)AllocIFF();
if (hand == NULL) makerequest("IFFParse Error 001");
else
    {
	hand->iff_Stream=Open(Name,MODE_OLDFILE);
	if (hand->iff_Stream == NULL) makerequest("IFFParse Error 002");
	else
	    {
		InitIFFasDOS(hand);
		error = OpenIFF(hand,IFFF_READ);
		if (error != NULL) makerequest("IFFParse Error 003");
		else
		    {
			error = PropChunk(hand,ID_ILBM,ID_BMHD); /* Remember the voice header chunk if encountered. */
			if (error != NULL) makerequest("IFFParse Error 004");
			else
			    {
				error = StopChunk(hand,ID_ILBM,ID_BODY);
				if (error != NULL) makerequest("IFFParse Error 005");
				else
				    {
					error = ParseIFF(hand,IFFPARSE_SCAN);
					if (error != NULL) makerequest("IFFParse Error 006");
					else
					    {
						prop = (struct StoredProperty *)FindProp(hand,ID_ILBM,ID_BMHD);
						if (prop == NULL) makerequest("IFFParse Error 007");
						else
						    {
							bmhd = (struct BitMapHeader *)prop->sp_Data;

							contextnode = (struct ContextNode *)CurrentChunk(hand);
							if (contextnode == NULL) makerequest("IFFParse Error 008");
							else
							    {
								length = contextnode->cn_Size;

								pdata = (UWORD *)AllocMem(length,MEMF_CLEAR);
								if (pdata == NULL)
								    {
									makerequest("Temporary Image Allocation Error");
									Cleanup();
								    }
								else
								    {
									error = ReadChunkBytes(hand,pdata,length);
									if (error != length) makerequest("IFFParse Error 010");
									else	GetImageData(num,pdata,length);
									FreeMem(pdata,length);
								    }
							    }
						    }
					    }
				    }
			    }
			CloseIFF(hand);
			}
		Close(hand -> iff_Stream);
		}
	FreeIFF(hand);
	}
}



GetImageData(num,pdata,length)
LONG num;
UWORD *pdata;
LONG length;
{
LONG he,wi,de,comp;
LONG h,w,d;
LONG x=0;
BYTE string[30];

he = bmhd->h;
wi = bmhd->w;
de = bmhd->BitPlanes;
comp = bmhd->Compression;


if (comp == NULL)
    {
	for (h=0;h<he;h++)
   		for (d=0;d<de;d++)
         		for (w = 0; w<((wi-1)/16)+1; w++)
              		Data[h][d][w] = pdata[x++];
    }
else
    {
	UnpackImage(num,(BYTE *)pdata);
    }



id[num].he = he;
id[num].wi = wi;
id[num].wo = (wi-1)/16+1;
id[num].length = de*he*id[num].wo*2;
id[num].data = (UWORD *)AllocMem(id[num].length,MEMF_CHIP | MEMF_CLEAR);
if (id[num].data == NULL)
    {
	sprintf(string,"Image Allocation Error %d",num);
	makerequest(string);
	Cleanup();
    }

x=0;
for (d=0;d<de;d++)						/* calculate length */
	for (h=0; h<he; h++)
		for(w=0; w<((wi-1)/16)+1; w++)
			id[num].data[x++] = Data[h][d][w];
}


UnpackImage(num,pdata)
LONG num;
BYTE *pdata;
{
UBYTE rowbytes,bytecount;
UBYTE info,data;
BYTE *ref;
LONG y,b,i;
BYTE *location;

info = *pdata;
ref = pdata;

rowbytes = ((bmhd->w-1)/8)+1;

for (y=0;y<bmhd->h;y++)
     for (b=0;b<bmhd->BitPlanes;b++)
          {
           bytecount = 0;
           location = (UBYTE *)&Data[y][b];  /*  DATA ARRAY STORAGE */
		 while (bytecount < rowbytes)
	    		   {
			    if (info < 128)
     	    		   {
				    movmem(ref+1,location+bytecount,info+1);
				    bytecount+=(info+1);
				    ref+=(info+1);
                       }

			    if (info > 128)
	         		   {
				    data = *(++ref);
				    for (i=bytecount;i<(bytecount+257-info);i++)
               	    *(location+i) = data;
				    bytecount+=(257-info);
                       }

			    info = *(++ref);    
    			    }
     	 }
}



freeimages()
{
LONG n,x;

for (x=0;x<LOADIMAGENUM;x++)
	if (id[x].data) FreeMem(id[x].data,id[x].length);

for (n=0;n<RENDIMAGENUM;n++)
	for (x=0;x<v[n].rots;x++)
		FreeRaster(id[x+v[n].zero].data,id[x+v[n].zero].wi,id[x+v[n].zero].he);
}




RendVectors()
{
LONG n,x,y;
LONG xmin,xmax,ymin,ymax;
DOUBLE theta,inc;
LONG cosx,siny;
LONG *dx,*dy;
LONG he,wi,wo;
struct RastPort trp;
struct BitMap tbm;


InitRastPort(&trp);
SetAPen(&trp,3);


dx = (LONG *)AllocMem(10000,MEMF_ANY);
dy = (LONG *)AllocMem(10000,MEMF_ANY);
if ((dx==NULL)||(dy==NULL))
    {
	makerequest("Temporary Vector Allocation Error");
	Cleanup();
    }


for (n=0;n<RENDIMAGENUM;n++)
{
xmin = 200;
xmax = 0;
ymin = 200;
ymax = 0;

inc = 360.0/((DOUBLE)v[n].rots);

for(x=0;x<v[n].rots;x++)
    {
	theta = (DOUBLE)((360-inc*(DOUBLE)x)/180.0*3.1415927);
	cosx = (LONG)(cos(theta)*1000.0);
	siny = (LONG)(sin(theta)*1000.0);
	for (y=0;y<v[n].num;y++)
	    {
		dx[30*x+y] = (640*v[n].x[y]*cosx/400+v[n].y[y]*siny)/1000;
		dy[30*x+y] = (v[n].y[y]*cosx-640*v[n].x[y]*siny/400)/1000;
		if (dx[30*x+y] < xmin) xmin = dx[30*x+y];
		if (dy[30*x+y] < ymin) ymin = dy[30*x+y];
		if (dx[30*x+y] > xmax) xmax = dx[30*x+y];
		if (dy[30*x+y] > ymax) ymax = dy[30*x+y];
	    }
    }

for(x=0;x<v[n].rots;x++)
    {
	he = id[x+v[n].zero].he = ymax-ymin+1;
	wi = id[x+v[n].zero].wi = xmax-xmin+1;
	wo = id[x+v[n].zero].wo = (id[x+v[n].zero].wi-1)/16+1;
	id[x+v[n].zero].mask = v[n].mask;
	id[x+v[n].zero].xc = xmin;
	id[x+v[n].zero].yc = ymin;
	id[x+v[n].zero].length = he*2*wo;

	InitBitMap(&tbm,1,wi,he);
	tbm.Planes[0] = (PLANEPTR)AllocRaster(wi,he);
	if (tbm.Planes[0] == NULL)
	    {
		makerequest("Vector Image Allocation Error");
		Cleanup();
	    }
	BltClear(tbm.Planes[0],RASSIZE(wi,he),NULL);

	trp.BitMap = &tbm;

	Move(&trp,wi/2+dx[30*x],he/2+dy[30*x]);
	for(y=1;y<v[n].num;y++)
		Draw(&trp,wi/2+dx[30*x+y],he/2+dy[30*x+y]);
	Draw(&trp,wi/2+dx[30*x],he/2+dy[30*x]);

	id[x+v[n].zero].data = (UWORD *)tbm.Planes[0];
    }
}

if (dx) FreeMem(dx,10000);
if (dy) FreeMem(dy,10000);
}

LoadAllImages()
{
LoadILBM("images/photon2",0);
LoadILBM("images/photon",1);
LoadILBM("images/exp1",2);
LoadILBM("images/exp2",3);
LoadILBM("images/exp3",4);
LoadILBM("images/exp4",5);
LoadILBM("images/exp5",6);
LoadILBM("images/exp6",7);
LoadILBM("images/exp7",8);
LoadILBM("images/exp8",9);

LoadILBM("images/shield",10);
LoadILBM("images/expander",11);

/*
LoadILBM("images/asteroid2",12);
LoadILBM("images/asteroid3",13);
*/

LoadILBM("images/sauceratt1",14);
LoadILBM("images/sauceratt2",15);
LoadILBM("images/sauceratt3",16);
LoadILBM("images/sauceratt4",17);
LoadILBM("images/sauceratt5",18);

LoadILBM("images/saucer1",19);
LoadILBM("images/saucer2",20);
LoadILBM("images/saucer3",21);
LoadILBM("images/saucer4",22);
LoadILBM("images/saucer5",23);

il.photon = 0;
il.explosion = 2;
il.shield = 10;
il.asaucer = 14;
il.saucer = 19;
il.expander = 11;
}


DefineShips()
{

/* player ship */
v[0].x[0] =  0;
v[0].y[0] = -10;
v[0].x[1] = 4;
v[0].y[1] = 4;
v[0].x[2] = 0;
v[0].y[2] = 8;
v[0].x[3] = -4;
v[0].y[3] = 4;
v[0].num  = 4;
v[0].pos  = 0;
v[0].rots  = 32;
v[0].mask  = 0xfd;
v[0].zero  = 24;

/* enemy heavy cruiser */
v[1].x[0] = 0;
v[1].y[0] = -10;
v[1].x[1] = 4;
v[1].y[1] = 5;
v[1].x[2] = 7;
v[1].y[2] = 5;
v[1].x[3] = 0;
v[1].y[3] = 14;
v[1].x[4] = -7;
v[1].y[4] = 5;
v[1].x[5] = -4;
v[1].y[5] = 4;
v[1].num  = 6;
v[1].pos  = 0;
v[1].rots  = 32;
v[1].mask  = 0xfe;
v[1].zero  = v[0].zero+v[0].rots;

/* enemy light cruiser */
v[2].x[0] = 0;
v[2].y[0] = -8;
v[2].x[1] = 3;
v[2].y[1] = 5;
v[2].x[2] = 0;
v[2].y[2] = 3;
v[2].x[3] = -3;
v[2].y[3] = 5;
v[2].num  = 4;
v[2].pos  = 0;
v[2].rots  = 32;
v[2].mask  = 0xfe;
v[2].zero  = v[1].zero+v[1].rots;

/* enemy star destroyer*/
v[3].x[0] = 0;
v[3].y[0] = -40;
v[3].x[1] = 14;
v[3].y[1] = 12;
v[3].x[2] = 0;
v[3].y[2] = 22;
v[3].x[3] = -14;
v[3].y[3] = 12;
v[3].num  = 4;
v[3].pos  = 0;
v[3].rots  = 32;
v[3].mask  = 0xfe;
v[3].zero  = v[2].zero+v[2].rots;

/* enemy escort cruiser */
v[4].x[0] = 0;
v[4].y[0] = -15;
v[4].x[1] = 3;
v[4].y[1] = 4;
v[4].x[2] = 0;
v[4].y[2] = 10;
v[4].x[3] = -3;
v[4].y[3] = 4;
v[4].num  = 4;
v[4].pos  = 0;
v[4].rots  = 32;
v[4].mask  = 0xfe;
v[4].zero  = v[3].zero+v[3].rots;

/* triangle */
v[5].x[0] = 0;
v[5].y[0] = -4;
v[5].x[1] = 3;
v[5].y[1] = 3;
v[5].x[2] = -3;
v[5].y[2] = 3;
v[5].num  = 3;
v[5].pos  = 0;
v[5].rots  = 16;
v[5].mask  = 0xff;
v[5].zero  = v[4].zero+v[4].rots;


/* mine */
v[6].x[0] = 0;
v[6].y[0] = -4;
v[6].x[1] = 0;
v[6].y[1] = 0;
v[6].x[2] = 2;
v[6].y[2] = 0;
v[6].x[3] = 0;
v[6].y[3] = 0;
v[6].x[4] = 0;
v[6].y[4] = 4;
v[6].x[5] = 0;
v[6].y[5] = 0;
v[6].x[6] = -2;
v[6].y[6] = 0;
v[6].x[7] = 0;
v[6].y[7] = 0;
v[6].num  = 8;
v[6].pos  = 0;
v[6].rots  = 16;
v[6].mask  = 0xff;
v[6].zero  = v[5].zero+v[5].rots;

/* box */
v[7].x[0] = -2;
v[7].y[0] = -3;
v[7].x[1] = 2;
v[7].y[1] = -3;
v[7].x[2] = 2;
v[7].y[2] = 3;
v[7].x[3] = -2;
v[7].y[3] = 3;
v[7].num  = 4;
v[7].pos  = 0;
v[7].rots  = 16;
v[7].mask  = 0xff;
v[7].zero  = v[6].zero+v[6].rots;

/* diamond */
v[8].x[0] = 0;
v[8].y[0] = -7;
v[8].x[1] = 2;
v[8].y[1] = 0;
v[8].x[2] = 0;
v[8].y[2] = 7;
v[8].x[3] = -2;
v[8].y[3] = 0;
v[8].num  = 4;
v[8].pos  = 0;
v[8].rots  = 32;
v[8].mask  = 0xff;
v[8].zero  = v[7].zero+v[7].rots;

/* line */
v[9].x[0] = 0;
v[9].y[0] = 5;
v[9].x[1] = 0;
v[9].y[1] = -5;
v[9].num  = 2;
v[9].pos  = 0;
v[9].rots  = 16;
v[9].mask  = 0xff;
v[9].zero  = v[8].zero+v[8].rots;

/* fighter */
v[10].x[0] = 0;
v[10].y[0] = -4;
v[10].x[1] = 2;
v[10].y[1] = 0;
v[10].x[2] = 0;
v[10].y[2] = 2;
v[10].x[3] = -2;
v[10].y[3] = 0;
v[10].num  = 4;
v[10].pos  = 0;
v[10].rots  = 16;
v[10].mask  = 0xfe;
v[10].zero  = v[9].zero+v[9].rots;

/* debris */
v[11].x[0] = 0;
v[11].y[0] = 7;
v[11].x[1] = 0;
v[11].y[1] = -7;
v[11].num  = 2;
v[11].pos  = 0;
v[11].rots  = 32;
v[11].mask  = 0xff;
v[11].zero  = v[10].zero+v[10].rots;

/* player2 */
v[12].x[0] = 0;
v[12].y[0] = -10;
v[12].x[1] = 5;
v[12].y[1] = 4;
v[12].x[2] = 2;
v[12].y[2] = 8;
v[12].x[3] = 0;
v[12].y[3] = 6;
v[12].x[4] = -2;
v[12].y[4] = 8;
v[12].x[5] = -5;
v[12].y[5] = 4;
v[12].num  = 6;
v[12].pos  = 0;
v[12].rots  = 32;
v[12].mask  = 0xfd;
v[12].zero  = v[11].zero+v[11].rots;


/* xcruiser */
v[13].x[0] = 0;
v[13].y[0] = -12;
v[13].x[1] = 0;
v[13].y[1] = -2;
v[13].x[2] = 4;
v[13].y[2] = -2;
v[13].x[3] = 0;
v[13].y[3] = 8;
v[13].x[4] = -4;
v[13].y[4] = 2;
v[13].num  = 5;
v[13].pos  = 0;
v[13].rots  = 32;
v[13].mask  = 0xfe;
v[13].zero  = v[12].zero+v[12].rots;

/* dreadnought */
v[14].x[0] = -2;
v[14].y[0] = -15;
v[14].x[1] = -7;
v[14].y[1] = -14;
v[14].x[2] = -10;
v[14].y[2] = 0;
v[14].x[3] = 0;
v[14].y[3] = 15;
v[14].x[4] = 10;
v[14].y[4] = 0;
v[14].x[5] = 7;
v[14].y[5] = -14;
v[14].x[6] = 2;
v[14].y[6] = -15;
v[14].x[7] = 5;
v[14].y[7] = -12;
v[14].x[8] = 7;
v[14].y[8] = 0;
v[14].x[9] = 0;
v[14].y[9] = 10;
v[14].x[10] = -7;
v[14].y[10] = 0;
v[14].x[11] = -5;
v[14].y[11] = -12;
v[14].num  = 12;
v[14].pos  = 0;
v[14].rots  = 32;
v[14].mask  = 0xfe;
v[14].zero  = v[13].zero+v[13].rots;

/* m cruiser */
v[15].x[0] = 0;
v[15].y[0] = -12;
v[15].x[1] = -3;
v[15].y[1] = -8;
v[15].x[2] = -2;
v[15].y[2] = 0;
v[15].x[3] = -5;
v[15].y[3] = 8;
v[15].x[4] = 0;
v[15].y[4] = 12;
v[15].x[5] = 5;
v[15].y[5] = 8;
v[15].x[6] = 2;
v[15].y[6] = 0;
v[15].x[7] = 3;
v[15].y[7] = -8;
v[15].num  = 8;
v[15].pos  = 0;
v[15].rots  = 32;
v[15].mask  = 0xfe;
v[15].zero  = v[14].zero+v[14].rots;

/* large asteroid */
v[16].x[0] = 0;
v[16].y[0] = -12;
v[16].x[1] = -8;
v[16].y[1] = -17;
v[16].x[2] = -11;
v[16].y[2] = -11;
v[16].x[3] = -9;
v[16].y[3] = -4;
v[16].x[4] = -12;
v[16].y[4] = 6;
v[16].x[5] = -7;
v[16].y[5] = 15;
v[16].x[6] = 5;
v[16].y[6] = 12;
v[16].x[7] = 10;
v[16].y[7] = 0;
v[16].x[8] = 7;
v[16].y[8] = -17;
v[16].num  = 9;
v[16].pos  = 0;
v[16].rots  = 64;
v[16].mask  = 0xfd;
v[16].zero  = v[15].zero+v[15].rots;

/* medium asteroid */
v[17].x[0] = -2;
v[17].y[0] = -6;
v[17].x[1] = -5;
v[17].y[1] = -11;
v[17].x[2] = -8;
v[17].y[2] = -7;
v[17].x[3] = -6;
v[17].y[3] = 2;
v[17].x[4] = -8;
v[17].y[4] = 7;
v[17].x[5] = -2;
v[17].y[5] = 12;
v[17].x[6] = 5;
v[17].y[6] = 7;
v[17].x[7] = 8;
v[17].y[7] = -4;
v[17].x[8] = 3;
v[17].y[8] = -10;
v[17].num  = 9;
v[17].pos  = 0;
v[17].rots  = 32;
v[17].mask  = 0xfd;
v[17].zero  = v[16].zero+v[16].rots;

/* small asteroid */
v[18].x[0] = -1;
v[18].y[0] = -7;
v[18].x[1] = -5;
v[18].y[1] = -1;
v[18].x[2] = -2;
v[18].y[2] = 7;
v[18].x[3] = 3;
v[18].y[3] = 5;
v[18].x[4] = 5;
v[18].y[4] = -2;
v[18].x[5] = 3;
v[18].y[5] = -5;
v[18].x[6] = 2;
v[18].y[6] = -4;
v[18].num  = 7;
v[18].pos  = 0;
v[18].rots  = 16;
v[18].mask  = 0xfd;
v[18].zero  = v[17].zero+v[17].rots;


/* displacer */
v[19].x[0] = 0;
v[19].y[0] = -6;
v[19].x[1] = -4;
v[19].y[1] = 0;
v[19].x[2] = 4;
v[19].y[2] = 0;
v[19].x[3] = 0;
v[19].y[3] = 6;
v[19].num  = 4;
v[19].pos  = 0;
v[19].rots  = 16;
v[19].mask  = 0xfd;
v[19].zero  = v[18].zero+v[18].rots;

/* saucer photon */
v[20].x[0] = 0;
v[20].y[0] = -3;
v[20].x[1] = 2;
v[20].y[1] = -3;
v[20].x[2] = 2;
v[20].y[2] = 0;
v[20].x[3] = -2;
v[20].y[3] = 0;
v[20].x[4] = -2;
v[20].y[4] = 3;
v[20].x[5] = 0;
v[20].y[5] = 3;
v[20].num  = 6;
v[20].pos  = 0;
v[20].rots  = 16;
v[20].mask  = 0xfd;
v[20].zero  = v[19].zero+v[19].rots;

/* dreadshield */
v[21].x[0] = -6;
v[21].y[0] = -16;
v[21].x[1] = -11;
v[21].y[1] = -8;
v[21].x[2] = -11;
v[21].y[2] = 8;
v[21].x[3] = -6;
v[21].y[3] = 16;
v[21].x[4] = 6;
v[21].y[4] = 16;
v[21].x[5] = 11;
v[21].y[5] = 8;
v[21].x[6] = 11;
v[21].y[6] = -8;
v[21].x[7] = 6;
v[21].y[7] = -16;
v[21].num  = 8;
v[21].pos  = 0;
v[21].rots  = 1;
v[21].mask  = 0xff;
v[21].zero  = v[20].zero+v[20].rots;

/* rectangle */
v[22].x[0] = -1;
v[22].y[0] = -6;
v[22].x[1] = 1;
v[22].y[1] = -6;
v[22].x[2] = 1;
v[22].y[2] = 6;
v[22].x[3] = -1;
v[22].y[3] = 6;
v[22].num  = 4;
v[22].pos  = 0;
v[22].rots  = 16;
v[22].mask  = 0xff;
v[22].zero  = v[21].zero+v[21].rots;

/* carrier */
v[23].x[0] = -1;
v[23].y[0] = -15;
v[23].x[1] = -3;
v[23].y[1] = -8;
v[23].x[2] = -1;
v[23].y[2] = -2;
v[23].x[3] = -10;
v[23].y[3] = 5;
v[23].x[4] = -10;
v[23].y[4] = 9;
v[23].x[5] = 0;
v[23].y[5] = 15;
v[23].x[6] = 10;
v[23].y[6] = 9;
v[23].x[7] = 10;
v[23].y[7] = 5;
v[23].x[8] = 2;
v[23].y[8] = -1;
v[23].x[9] = 3;
v[23].y[9] = -8;
v[23].x[10] = 1;
v[23].y[10] = -15;
v[23].num  = 11;
v[23].pos  = 0;
v[23].rots  = 32;
v[23].mask  = 0xfe;
v[23].zero  = v[22].zero+v[22].rots;

il.player = v[0].zero;
il.eheavy = v[1].zero;
il.elight = v[2].zero;
il.battleship = v[3].zero;
il.xcruiser = v[4].zero;
il.triangle = v[5].zero;
il.mine = v[6].zero;
il.box = v[7].zero;
il.diamond = v[8].zero;
il.line = v[9].zero;
il.fighter = v[10].zero;
il.debris = v[11].zero;
il.player2 = v[12].zero;
il.minelayer = v[13].zero;
il.dreadnought = v[14].zero;
il.magnetic = v[15].zero;
il.asteroid[0] = v[16].zero;
il.asteroid[1] = v[17].zero;
il.asteroid[2] = v[18].zero;
il.displacer = v[19].zero;
il.sauphot = v[20].zero;
il.dreadshield = v[21].zero;
il.rectangle = v[22].zero;
il.carrier = v[23].zero;
}
