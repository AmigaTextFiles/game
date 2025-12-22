/************************************************************************
*																		*
* Display functions for Dragon game.									*
*																		*
*						Copyright ©1994 Nick Christie					*
*																		*
*************************************************************************/

/************************************************************************
******************************  INCLUDES  *******************************
*************************************************************************/

#include "DragonDefs.h"
#include "Dragon.h"

#define READBUFSIZE		8192

/************************************************************************
*************************  EXTERNAL REFERENCES  *************************
*************************************************************************/

extern UWORD TopLevelTile(BOARD board,UWORD x,UWORD y);
extern BOOL  CanMoveTile(BOARD board,UWORD x,UWORD y,UWORD z);

extern struct RastPort	*BufRPort;
extern UWORD 			PairsLeft;
extern struct ColorSpec ScrnClrs[];

/************************************************************************
*****************************  PROTOTYPES  ******************************
*************************************************************************/

BOOL OpenBufRPort(void);
void CloseBufRPort(void);

void LoadBackground(char *fname);
void UnloadBackground(void);

BOOL LoadTileImages(char *fname);
void UnloadTileImages(void);

BOOL LoadILBM(char *fname,UBYTE *dest,UBYTE *cmap,
	UWORD width,UWORD height,UBYTE depth);
BOOL ReadBODY(struct IFFHandle *iff,UBYTE *destmem,
	UWORD width,UWORD height,UBYTE depth);
BOOL UnPackRow(struct IFFHandle *iff,UBYTE *dst,ULONG dstlen);

BOOL InitReadBuf(void);
void CloseReadBuf(void);
BOOL ReadBufByte(struct IFFHandle *iff,UBYTE *buf);

void DrawBoard(BOARD board,struct RastPort *rp);
void DrawOneTile(UBYTE tile,struct RastPort *rp,UWORD x,UWORD y);
void DisplayStats(BOARD board,struct RastPort *rp);
UWORD PossibleMoves(BOARD board);
void SelectStats(UBYTE tile,BOARD board,struct RastPort *rp);

/************************************************************************
********************************  DATA  *********************************
*************************************************************************/

/*
 * All the drawing takes place off-screen in an allocated rastport,
 * to which this points. It gets a bitmap attached to it.
 */

struct RastPort	*BufRPort = NULL;

/*
 * This is the image structure used for filling in the background.
 * The boolean indicates if the background image was loaded okay.
 */

BOOL BgndOkay = FALSE;

struct Image BgndImage = {
		0, 0, 320, 256, 4, NULL, 0x0f, 0x10, NULL
};

/*
 * Here's where we keep a pointer to the chip mem allocated for
 * storing the tile images. These are loaded on startup. Also here
 * is a bitmap structure, which we fill in.
 */

UBYTE			*TileImages = 0;
struct BitMap	TileImageBitMap;

/************************************************************************
***************************  OPENBUFRPORT()  ****************************
*************************************************************************
* Creates & initializes the buffer rastport, used for drawing into so that
* updates are invisible.
*
*************************************************************************/

BOOL OpenBufRPort(void)
{
UWORD	i = 0;
BOOL	okay = TRUE;

if (BufRPort = (struct RastPort *) AllocMem(
					sizeof(struct RastPort),MEMF_PUBLIC|MEMF_CLEAR))
	{
	InitRastPort(BufRPort);
	if (BufRPort->BitMap = (struct BitMap *) AllocMem(
					sizeof(struct BitMap),MEMF_PUBLIC|MEMF_CLEAR))
		{
		InitBitMap(BufRPort->BitMap,SCRDEPTH,SCRWIDTH,SCRHEIGHT);

		for(i=0; i<SCRDEPTH && okay; i++)
			{
			if (!(BufRPort->BitMap->Planes[i] = AllocRaster(
					SCRWIDTH,SCRHEIGHT))) okay = FALSE;
			}
		}
	else
		okay = FALSE;
	}
else
	okay = FALSE;

return(okay);
}

/************************************************************************
***************************  CLOSEBUFRPORT()  ***************************
*************************************************************************
* Releases any resources allocated by OpenBufRPort(), if any.
*
*************************************************************************/

void CloseBufRPort(void)
{
PLANEPTR p;
UWORD	 i;

if (BufRPort)
	{
	if (BufRPort->BitMap)
		{
		for(i=0;i<SCRDEPTH;i++)
			{
			if (p = BufRPort->BitMap->Planes[i])
				FreeRaster(p,SCRWIDTH,SCRHEIGHT);
			}
		FreeMem((APTR)BufRPort->BitMap,sizeof(struct BitMap));
		}
	FreeMem((APTR)BufRPort,sizeof(struct RastPort));
	}
}

/************************************************************************
***************************  LOADBACKGROUND() ***************************
*************************************************************************
* Tries the load the named background picture (an IFF ILBM). This must be
* 320*256*4 and be compressed with ByteRun1. It will be blitted each
* time the board is drawn (behind the tiles) into bps 1-4 of the screen.
* Screen colour pens 20-31 are set to those in pens 4-15 of the image.
* If the file can't be loaded for any reason, no error is returned, but
* BgndOkay will be FALSE and no background will be rendered. Only the
* bitplane memory is allocated, no other system structures.
*
*************************************************************************/

void LoadBackground(char *fname)
{
UBYTE	*bgnddata,*creg,colourmap[32*3];
UWORD	pen;

if (!(bgnddata = AllocMem(320*256*4/8,MEMF_CHIP|MEMF_PUBLIC)))
	return;

BgndImage.ImageData = (UWORD *) bgnddata;

if (LoadILBM(fname,bgnddata,colourmap,320,256,4))
	{
	BgndOkay = TRUE;

	creg = &colourmap[4*sizeofColorRegister];

	for(pen=20;pen<32;pen++)
		{
		ScrnClrs[pen].Red = *creg++;
		ScrnClrs[pen].Green = *creg++;
		ScrnClrs[pen].Blue = *creg++;
		}
	}
}

/************************************************************************
*************************  UNLOADBACKGROUND()  **************************
*************************************************************************
* Release all resources allocated by LoadBackground(), if any. This will
* only be the image data.
*
*************************************************************************/

void UnloadBackground(void)
{
if (BgndImage.ImageData) FreeMem((UBYTE *)BgndImage.ImageData,320*256*4/8);
}

/************************************************************************
**************************  LOADTILEIMAGES()  ***************************
*************************************************************************
* Load the named IFF ILBM file containing the tile images into some
* allocated bitplane memory. This must be a 320*96*4 brush, with the
* tiles laid out in a particular fashion. See "Template.pic" for the
* correct positions. It should be saved with ByteRun1 compression.
* We initialize a bitmap structure here for it, so that we can blit
* the individual tile images around. Colours 2-15 in the screen are
* set to those of the tiles.
*
*************************************************************************/

BOOL LoadTileImages(char *fname)
{
UBYTE	*planeptr,*creg,colourmap[32*3];
UWORD	i;

if (!(TileImages = AllocMem(320*96*4/8,MEMF_CHIP|MEMF_PUBLIC)))
	return(FALSE);

InitBitMap(&TileImageBitMap,4,320,96);

planeptr = TileImages;
for(i=0;i<4;i++)
	{
	TileImageBitMap.Planes[i] = (PLANEPTR) planeptr;
	planeptr += 320*96/8;
	}

if (LoadILBM(fname,TileImages,colourmap,320,96,4))
	{
	creg = &colourmap[2*sizeofColorRegister];

	for(i=2;i<16;i++)
		{
		ScrnClrs[i].Red = *creg++;
		ScrnClrs[i].Green = *creg++;
		ScrnClrs[i].Blue = *creg++;
		}

	return(TRUE);
	}

return(FALSE);
}

/************************************************************************
*************************  UNLOADTILEIMAGES()  **************************
*************************************************************************
* Release whatever LoadTileImages() got, if anything.
*
*************************************************************************/

void UnloadTileImages(void)
{
if (TileImages) FreeMem((UBYTE *)TileImages,320*96*4/8);
}

/************************************************************************
*****************************  LOADILBM()  ******************************
*************************************************************************
* Read the ILBM file, name supplied, into the destination bitplanes
* supplied (they must be a contiguous block), with the given width,
* height and depth. The colourmap chunk is copied to the buffer supplied
* for the purpose, which must be large enough for 32 pens. The RGB
* values are right-shifted before copying. The ILBM must be ByteRun1
* compressed.
*
*************************************************************************/

BOOL LoadILBM(char *fname,UBYTE *dest,UBYTE *cmap,
	UWORD width,UWORD height,UBYTE depth)
{
struct IFFHandle		*iff;
struct StoredProperty	*prop;
BitMapHeader			*bmhd;
UBYTE					*creg;
UWORD					i;
BOOL					okay = FALSE;

if (iff = AllocIFF())
	{
	if (iff->iff_Stream = Open(fname,MODE_OLDFILE))
		{
		InitIFFasDOS(iff);
		if (OpenIFF(iff,IFFF_READ) == 0)
			{
			if (PropChunk(iff,ID_ILBM,ID_BMHD)) goto abortiff;
			if (PropChunk(iff,ID_ILBM,ID_CMAP)) goto abortiff;
			if (StopChunk(iff,ID_ILBM,ID_BODY)) goto abortiff;
			if (ParseIFF(iff,IFFPARSE_SCAN)) goto abortiff;

			if (!(prop = FindProp(iff,ID_ILBM,ID_BMHD))) goto abortiff;

			bmhd = (BitMapHeader *) prop->sp_Data;

			if ((bmhd->w != width) || (bmhd->h != height) ||
				(bmhd->nPlanes != depth) || (bmhd->compression != cmpByteRun1))
				goto abortiff;

			if (!(prop = FindProp(iff,ID_ILBM,ID_CMAP))) goto abortiff;

			creg = (UBYTE *) prop->sp_Data;

			for(i=0; i<prop->sp_Size; i++)
				*cmap++ = *creg++ >> 4;

			okay = ReadBODY(iff,dest,width,height,depth);

abortiff:

			CloseIFF(iff);
			}
		Close(iff->iff_Stream);
		}
	FreeIFF(iff);
	}

return(okay);
}

/************************************************************************
*****************************  READBODY()  ******************************
*************************************************************************
* Read the BODY from the IFFHandle, where it has stopped, putting the
* data in the given bitplane memory. We are given the dimensions to
* expect, and can assume that the destination memory is large enough for
* all the contiguous bitplane data. We can also assume ByteRun1.
*
*************************************************************************/

BOOL ReadBODY(struct IFFHandle *iff,UBYTE *destmem,
	UWORD width,UWORD height,UBYTE depth)
{
ULONG	rastoff,rastsize;
UWORD	bytesprow;
UBYTE	*planptr,*destptr,plane;

if (!InitReadBuf()) return(FALSE);

bytesprow = width >> 3;
rastsize = bytesprow * height;

for (rastoff=0; rastoff<rastsize; rastoff+=bytesprow)
	{
	planptr = destmem;
	for (plane=0; plane<depth; plane++)
		{
		destptr = planptr + rastoff;
		planptr += rastsize;
		if (!UnPackRow(iff,destptr,bytesprow))
			{
			CloseReadBuf();
			return(FALSE);
			}
		}
	}

CloseReadBuf();

return(TRUE);
}

/************************************************************************
*****************************  UNPACKROW()  *****************************
*************************************************************************
* Unpack byterun1 compressed bytes from iff handle to dest until dstlen
* bytes written. Returns false on error. Compression consists of
* control byte followed by one or more data bytes as follows :-
* 	n = 0 to 127	copy following n+1 bytes literally.
* 	n = -1 to -127	replicate following byte (-n)+1 times.
* 	n = -128		do nothing.
*
**************************************************************************/

BOOL UnPackRow(struct IFFHandle *iff,UBYTE *dst,ULONG dstlen)
{
ULONG	written;
UBYTE	ctrl,data;

written = 0;

while (written != dstlen)
	{
	if (!ReadBufByte(iff,&ctrl)) return(FALSE);

	if (ctrl != 0x80)					/* not a NOP */
		{
		if (ctrl & 0x80)				/* replicate run */
			{
			ctrl = ~ctrl + 2;			/* ctrl = (-ctrl) + 1 */
			if (!ReadBufByte(iff,&data)) return(FALSE);
			do
				{
				if (++written > dstlen) return(FALSE);
				*dst++ = data;
				}
			while (--ctrl != 0);
			}
		else							/* literal run */
			{
			ctrl++;
			do
				{
				if (++written > dstlen) return(FALSE);
				if (!ReadBufByte(iff,dst++)) return(FALSE);
				}
			while (--ctrl != 0);
			}

		} /* endif not NOP */
	} /* endwhile written != dstlen */

return(TRUE);
}

/************************************************************************
****************************  INITREADBUF()  ****************************
*************************************************************************
* Allocate a read buffer and initialize it. Return false on failure.
*
*************************************************************************/

UBYTE	*ReadBuf;
ULONG	BufBytes,BufOffset;

BOOL InitReadBuf(void)
{
if (!(ReadBuf = AllocMem(READBUFSIZE,MEMF_PUBLIC))) return(FALSE);
BufOffset = BufBytes = 0;
return(TRUE);
}

/************************************************************************
***************************  CLOSEREADBUF()  ****************************
*************************************************************************
* Free the read buffer previously succesfully alloc'd by InitReadBuf().
* Do NOT call if Init() failed.
*
*************************************************************************/

void CloseReadBuf(void)
{
FreeMem(ReadBuf,READBUFSIZE);
}

/************************************************************************
****************************  READBUFBYTE()  ****************************
*************************************************************************
* Return the next byte from the read buffer, re-filling it if necessary,
* and returning an error BOOL. EOF is treated as error.
*
*************************************************************************/

BOOL ReadBufByte(struct IFFHandle *iff,UBYTE *buf)
{
LONG actual;

if (BufBytes == 0)
	{
	actual = ReadChunkBytes(iff,ReadBuf,READBUFSIZE);
	if (actual <= 0) return(FALSE);
	BufBytes = actual;
	BufOffset = 0;
	}

*buf = ReadBuf[BufOffset++];
BufBytes--;

return(TRUE);
}

/************************************************************************
*****************************  DRAWBOARD()  *****************************
*************************************************************************
* Take a tile array and a rastport & draw the tile graphics into it.
* The graphics are initially drawn in the buffer rastport, then blitted
* across.
*
*************************************************************************/

void DrawBoard(BOARD board,struct RastPort *rp)
{
UWORD		i,j,k;
UWORD		sx,sy,x,y;
UBYTE		t;

if (BgndOkay)
	DrawImage(BufRPort,&BgndImage,0,0);
else
	SetRast(BufRPort,0);

sx = BRDLEFTEDGE; sy = BRDTOPEDGE;

for(i=0;i<BOARDZ;i++)
	{
	y = sy;
	for(j=0;j<BOARDY;j++)
		{
		x = sx;
		for(k=0;k<BOARDX;k++)
			{
			if (t = board[i][j][k]) DrawOneTile(t,BufRPort,x,y);
			x += TILEXSPACE;
			}
		y += TILEYSPACE;
		}
	sx -= LEVELXADJ;
	sy -= LEVELYADJ;
	}

DisplayStats(board,BufRPort);

BltBitMapRastPort(BufRPort->BitMap,0,0,rp,0,0,
					SCRWIDTH,SCRHEIGHT,0xc0);

}

/************************************************************************
****************************  DRAWONETILE()  ****************************
*************************************************************************
* Draw the image corresponding to the given tile ID code into the given
* rastport at the given x,y location.
*
*************************************************************************/

void DrawOneTile(UBYTE tile,struct RastPort *rp,UWORD x,UWORD y)
{
UWORD	bmx,bmy;

bmx = ((tile-1) % 10) * 32;
bmy = ((tile-1) / 10) * 32;

BltBitMapRastPort(&TileImageBitMap,bmx,bmy,rp,x,y,
					TILEWIDTH,TILEHEIGHT,0xc0);
SetAPen(rp,0);
SetDrMd(rp,JAM1);
rp->Mask = 16;
RectFill(rp,x,y,x+TILEWIDTH-1,y+TILEHEIGHT-1);
rp->Mask = 255;

}

/************************************************************************
***************************  DISPLAYSTATS()  ****************************
*************************************************************************
* Display the statistics for # tiles left & # moves possible in the
* supplied rastport. Also prepare the area in which we will display the
* pairs remaining of the selected type (when one gets selected).
*
*************************************************************************/

void DisplayStats(BOARD board,struct RastPort *rp)
{
char	strbuf[4];
UWORD	possible;

SetDrMd(rp,JAM1);
SetOPen(rp,1);
SetAPen(rp,0);
RectFill(rp,6,165,27,177);
RectFill(rp,290,115,311,129);
RectFill(rp,290,145,311,159);
BNDRYOFF(rp);
SetAPen(rp,1);

sprintf(strbuf,"%2d",PairsLeft);
Move(rp,293,125);
Text(rp,strbuf,2);

possible = PossibleMoves(board);
sprintf(strbuf,"%2d",possible);
Move(rp,293,155);
Text(rp,strbuf,2);
}

/************************************************************************
***************************  POSSIBLEMOVES()  ***************************
*************************************************************************
* Calculate the number of tiles that can be moved in the given board.
*
*************************************************************************/

UWORD PossibleMoves(BOARD board)
{
UWORD	x,y,z;
UBYTE	histo[MAXTILETYPE+1],t;

memset(histo,0,MAXTILETYPE+1);

for(y=0;y<BOARDY;y++)
	{
	for(x=0;x<BOARDX;x++)
		{
		z = TopLevelTile(board,x,y);
		if (t = board[z][y][x])
			{
			if (CanMoveTile(board,x,y,z)) histo[t]++;
			}
		}
	}

for(x=0,t=1; t<MAXTILETYPE+1; t++) x += histo[t] / 2;

return(x);
}

/************************************************************************
****************************  SELECTSTATS()  ****************************
*************************************************************************
* Display statistics on the newly selected tile. This shows how many pairs
* of that type still remain on the board, and whether any can be removed.
* An area for the display has already been prepared with DisplayStats().
*
*************************************************************************/

void SelectStats(UBYTE tile,BOARD board,struct RastPort *rp)
{
UWORD	x,y,z;
UBYTE	tcnt = 0, mcnt = 0;
char	cbuf[2];

for(z=0;z<BOARDZ;z++)
	{
	for(y=0;y<BOARDY;y++)
		{
		for(x=0;x<BOARDX;x++)
			{
			if (board[z][y][x] == tile)
				{
				tcnt++;
				if (TopLevelTile(board,x,y) == z)
					{
					if (CanMoveTile(board,x,y,z)) mcnt++;
					}
				}
			}
		}
	}


cbuf[0] = (mcnt > 1) ? '*' : ' ';
cbuf[1] = (tcnt / 2) + '0';

SetDrMd(rp,JAM2);
SetAPen(rp,1);
SetBPen(rp,0);
Move(rp,9,174);
Text(rp,cbuf,2);
}


