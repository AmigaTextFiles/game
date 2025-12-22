/*
* This file is part of Faery Tale Adventure Patch.
* Copyright (C) 1997 Peter McGavin
* 
* Faery Tale Adventure Patch is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Faery Tale Adventure Patch is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Faery Tale Adventure Patch.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <dos.h>

#include <exec/exec.h>
#include <dos/dos.h>
#include <dos/dosextens.h>
#include <graphics/gfx.h>
#include <intuition/intuition.h>
#include <libraries/iffparse.h>
#include <devices/audio.h>
#include <devices/gameport.h>
#include <clib/alib_stdio_protos.h>

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/iffparse.h>

struct ExecBase *SysBase;
struct DosLibrary *DOSBase = NULL;
struct GfxBase *GfxBase = NULL;
struct Library *IFFParseBase = NULL;
struct IntuitionBase *IntuitionBase = NULL;
static BPTR fhandle = NULL;
__far struct Message *wbmessage = NULL;

static struct TextAttr topaz8 = {
  "topaz.font", 8, FS_NORMAL, FPF_ROMFONT
};
__far struct TextFont *topaz8font = NULL;

static struct NewScreen ns = {
  0, 0, 640, 200, 2,
  1, 0,
  HIRES,
  CUSTOMSCREEN,
  &topaz8,
  NULL,
  NULL,
  NULL
};

static struct NewWindow nw = {
  0, 0, 640, 200,
  1, 0,
  0,
  WFLG_ACTIVATE | WFLG_BORDERLESS,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  640, 200, 640, 200,
  CUSTOMSCREEN
};

#define BIGBUF_SIZE ((160 * 11) << 9)
static char *bigbuf = NULL;

/**********************************************************************/

static BOOL request (struct Window *w, char *msg1, char *msg2);

static BOOL check_for (struct Window *w, char *filename);

int __asm PROGSTART (register __a0 char *cmdline,
                     register __d0 int cmdlength);

/**********************************************************************/

int __asm __saveds _main (register __a0 char *cmdline,
                          register __d0 int cmdlength)
{
  int retcode;
  struct Screen *s = NULL;
  struct Window *w = NULL;
  UWORD *emptypointer = NULL;
  static UWORD colortable[4] = {0x05a, 0xfff, 0x002, 0xf80};
  struct Process *myprocess;
  struct MsgPort *audio_mp = NULL;
  struct IOAudio *audio_io = NULL;
  struct MsgPort *gameport_mp = NULL;
  struct IOStdReq *gameport_io = NULL;
  BYTE controller_type;
  static UBYTE chans[] = {1,2,4,8};
  BOOL audio_is_open = FALSE;
  BOOL gameport_is_open = FALSE;
  BOOL gameport_is_allocated = FALSE;
  BOOL ok = TRUE;

  retcode = 10;
  SysBase = *(struct ExecBase **)4;
  myprocess = (struct Process *)FindTask (NULL);
  if (myprocess->pr_CLI == NULL) {
    WaitPort (&myprocess->pr_MsgPort);
    wbmessage = GetMsg (&myprocess->pr_MsgPort);
  }

  if ((DOSBase = (struct DosLibrary *)OpenLibrary ("dos.library", 0)) == NULL ||
      (GfxBase = (struct GfxBase *)OpenLibrary ("graphics.library", 0)) == NULL ||
      (IntuitionBase = (struct IntuitionBase *)OpenLibrary ("intuition.library", 0)) == NULL ||
      (topaz8font = OpenFont (&topaz8)) == NULL ||
      (s = OpenScreen (&ns)) == NULL)
    ok = request (NULL, "Can't open libs or Screen", NULL);

  IFFParseBase = OpenLibrary ("iffparse.library", 0);

  if (ok) {
    LoadRGB4 (&s->ViewPort, colortable, 4);
    Delay (2);
    ScreenToFront (s);
    Delay (2);
    nw.Screen = s;
    if ((w = OpenWindow (&nw)) == NULL)
      ok = request (NULL, "Can't open Window", NULL);
  }

  if (ok)
    if ((fhandle = Open ("progdir:faery_disk_image.dat", MODE_OLDFILE)) == NULL)
      ok = request (w, "Can't open progdir:faery_disk_image.dat", NULL);

  if (ok)
    ok = check_for (w, "progdir:hiscreen") &&
         check_for (w, "progdir:page0") &&
         check_for (w, "progdir:winpic") &&
         check_for (w, "progdir:songs") &&
         check_for (w, "progdir:v6") &&
         check_for (w, "progdir:p1a") &&
         check_for (w, "progdir:p1b") &&
         check_for (w, "progdir:p2a") &&
         check_for (w, "progdir:p2b") &&
         check_for (w, "progdir:p3a") &&
         check_for (w, "progdir:p3b") &&
         check_for (w, "progdir:fonts/amber.font") &&
         check_for (w, "progdir:fonts/amber/9");

  if (ok) {
    SetAPen (w->RPort, 3);
    Move (w->RPort, 320 - 4 * 10, 120);
    Text (w->RPort, "Loading...", 10);
    if ((bigbuf = AllocMem (BIGBUF_SIZE, MEMF_FAST)) != NULL &&
        (TypeOfMem (bigbuf) & MEMF_FAST) != 0) {
      if (Read (fhandle, bigbuf, BIGBUF_SIZE) != BIGBUF_SIZE)
        ok = request (w, "Error reading progdir:faery_disk_image.dat", NULL);
      Close (fhandle);
      fhandle = NULL;
    }
  }

  if (ok)
    if ((audio_mp = CreatePort (NULL, 0)) == NULL ||
        (audio_io = (struct IOAudio *)AllocMem (sizeof(struct IOAudio),
                                           MEMF_PUBLIC | MEMF_CLEAR)) == NULL ||
        (gameport_mp = CreatePort (NULL, 0)) == NULL ||
        (gameport_io = (struct IOStdReq *)CreateExtIO
                                (gameport_mp, sizeof(struct IOStdReq))) == NULL)
      ok = request (w, "Can't create port", NULL);

  if (ok) {
    audio_io->ioa_Request.io_Message.mn_ReplyPort = audio_mp;
    audio_io->ioa_AllocKey = 0;
    audio_io->ioa_Request.io_Message.mn_Node.ln_Pri = 127;
    audio_io->ioa_Data = chans;
    audio_io->ioa_Length = sizeof(chans);
    if (OpenDevice (AUDIONAME, 0, (struct IORequest *)audio_io, 0) != 0)
      ok = request (w, "Can't get audio channels", NULL);
  }

  if (ok) {
    audio_is_open = TRUE;
    if (OpenDevice ("gameport.device", 1, (struct IORequest *)gameport_io, 0) != 0)
      ok = request (w, "Can't get gameport", NULL);
  }

  if (ok) {
    gameport_is_open = TRUE;
    Forbid ();
    gameport_io->io_Command = GPD_ASKCTYPE;
    gameport_io->io_Length = 1;
    gameport_io->io_Data = &controller_type;
    DoIO ((struct IORequest *)gameport_io);
    if (controller_type != GPCT_NOCONTROLLER) {
      Permit ();
      ok = request (w, "Can't get gameport", NULL);
    }
  }

  if (ok) {
    controller_type = GPCT_ALLOCATED;
    gameport_io->io_Command = GPD_SETCTYPE;
    gameport_io->io_Length = 1;
    gameport_io->io_Data = &controller_type;
    DoIO ((struct IORequest *)gameport_io);
    gameport_is_allocated = TRUE;
    Permit ();
    if ((emptypointer = (UWORD *)AllocMem (12, MEMF_CHIP | MEMF_CLEAR)) == NULL)
      ok = request (w, "Out of chip memory", NULL);
  }

  if (ok) {
    SetPointer (w, emptypointer, 1, 16, 0, 0);
    retcode = PROGSTART (cmdline, cmdlength);
  }

  if (emptypointer != NULL)
    FreeMem (emptypointer, 12);

  if (gameport_is_allocated) {
    controller_type = GPCT_NOCONTROLLER;
    gameport_io->io_Command = GPD_SETCTYPE;
    gameport_io->io_Length = 1;
    gameport_io->io_Data = &controller_type;
    DoIO ((struct IORequest *)gameport_io);
  }
  if (gameport_is_open)
    CloseDevice ((struct IORequest *)gameport_io);
  if (gameport_io != NULL)
    DeleteExtIO ((struct IORequest *)gameport_io);
  if (gameport_mp != NULL)
    DeletePort (gameport_mp);

  if (audio_is_open)
    CloseDevice ((struct IORequest *)audio_io);
  if (audio_io != NULL)
    FreeMem (audio_io, sizeof(struct IOAudio));
  if (audio_mp != NULL)
    DeletePort (audio_mp);

  if (bigbuf != NULL)
    FreeMem (bigbuf, BIGBUF_SIZE);
  if (fhandle != NULL)
    Close (fhandle);
  if (w != NULL)
    CloseWindow (w);
  if (s != NULL)
    CloseScreen (s);
  if (topaz8font != NULL)
    CloseFont (topaz8font);

  if (IFFParseBase != NULL)
    CloseLibrary(IFFParseBase);
  if (IntuitionBase != NULL)
    CloseLibrary((struct Library *)IntuitionBase);
  if (GfxBase != NULL)
    CloseLibrary((struct Library *)GfxBase);
  if (DOSBase != NULL)
    CloseLibrary((struct Library *)DOSBase);

  if (wbmessage != NULL) {
    Forbid ();
    ReplyMsg (wbmessage);
  }

  return retcode;
}

/**********************************************************************/

static BOOL request (struct Window *w, char *msg1, char *msg2)
{
  static struct IntuiText bodytext[] = {
    {0, 1, JAM2, 10, 8, &topaz8, NULL, &bodytext[1]},
    {0, 1, JAM2, 10, 16, &topaz8, NULL, NULL}
  };
  static struct IntuiText negtext = {0, 1, JAM2, 6, 3, &topaz8, "Ok", NULL};

  bodytext[0].IText = msg1;
  if (msg2 == NULL)
    bodytext[0].NextText = NULL;
  else
    bodytext[1].IText = msg2;
  AutoRequest (w, &bodytext[0], NULL, &negtext, 0, 0, 320, 60);
  return FALSE;
}

/**********************************************************************/

static BOOL check_for (struct Window *w, char *filename)
{
  BPTR lock;

  if ((lock = Lock (filename, ACCESS_READ)) == NULL) {
    request (w, "Can't find required file", filename);
    return FALSE;
  }
  UnLock (lock);
  return (TRUE);
}

/**********************************************************************/

#define	ID_ILBM MAKE_ID('I','L','B','M')
#define	ID_BMHD MAKE_ID('B','M','H','D')
#define	ID_CMAP MAKE_ID('C','M','A','P')
#define	ID_CAMG MAKE_ID('C','A','M','G')
#define	ID_BODY MAKE_ID('B','O','D','Y')

#define	cmpNone			0
#define	cmpByteRun1		1

typedef struct {
	UWORD	w, h;		/* Width, height in pixels */
	WORD	x, y;		/* x, y position for this bitmap  */
	UBYTE	nPlanes;	/* # of planes (not including mask) */
	UBYTE	masking;	/* a masking technique listed above */
	UBYTE	compression;	/* cmpNone or cmpByteRun1 */
	UBYTE	flags;		/* as defined or approved by Commodore */
	UWORD	transparentColor;
	UBYTE	xAspect, yAspect;
	WORD	pageWidth, pageHeight;
} BitMapHeader;

#define RowBytes(w)	((((w) + 15) >> 4) << 1)

#define IFF_OKAY	0L
#define	CLIENT_ERROR	1L
#define NOFILE          5L

#define MAXSAVEDEPTH 8

/* This macro computes the worst case packed size of a "row" of bytes. */
#define MaxPackedSize(rowSize)  ( (rowSize) + ( ((rowSize)+127) >> 7 ) )

static BYTE *PutDump(BYTE *, int);
static BYTE *PutRun(BYTE *,int,int);

#define DUMP	0
#define RUN	1

#define MinRun 3	
#define MaxRun 128
#define MaxDat 128

/* When used on global definitions, static means private.
 * This keeps these names, which are only referenced in this
 * module, from conficting with same-named objects in your program.
 */ 
static LONG putSize;
static char buf[256];	/* [TBD] should be 128?  on stack?*/

#define GetByte()	(*source++)
#define PutByte(c)	{*dest++ = (c); ++putSize;}

static __inline BYTE *PutDump (BYTE *dest, int nn)
{
  int i;

  PutByte (nn - 1);
  for (i = 0; i < nn; i++)
    PutByte (buf[i]);
  return (dest);
}

static __inline BYTE *PutRun (BYTE *dest, int nn, int cc)
{
  PutByte (-(nn - 1));
  PutByte (cc);
  return (dest);
}

#define OutDump(nn)   dest = PutDump(dest, nn)
#define OutRun(nn,cc) dest = PutRun(dest, nn, cc)

/*----------- packrow --------------------------------------------------*/
/* Given POINTERS TO POINTERS, packs one row, updating the source and
 * destination pointers.  RETURNs count of packed bytes.
 */
static LONG packrow (BYTE **pSource, BYTE **pDest, LONG rowSize)
{
  BYTE *source, *dest;
  char c,lastc = '\0';
  BOOL mode = DUMP;
  short nbuf = 0;		/* number of chars in buffer */
  short rstart = 0;		/* buffer index current run starts */

  source = *pSource;
  dest = *pDest;
  putSize = 0;
  buf[0] = lastc = c = GetByte();  /* so have valid lastc */
  nbuf = 1;
  rowSize--;	/* since one byte eaten.*/

  for (;  rowSize;  --rowSize) {
    buf[nbuf++] = c = GetByte();
    switch (mode) {
    case DUMP:
      /* If the buffer is full, write the length byte, then the data */
      if (nbuf > MaxDat) {
        OutDump (nbuf - 1);  
        buf[0] = c; 
        nbuf = 1;
        rstart = 0; 
        break;
      }

      if (c == lastc) {
        if (nbuf - rstart >= MinRun) {
          if (rstart > 0)
            OutDump(rstart);
          mode = RUN;
        } else if (rstart == 0)
          mode = RUN;	/* no dump in progress, so can't lose by making these 2 a run.*/
      }	else
        rstart = nbuf - 1;		/* first of run */ 
      break;

    case RUN:
      if (c != lastc || nbuf - rstart > MaxRun) {
        /* output run */
        OutRun (nbuf - 1 - rstart, lastc);
        buf[0] = c;
        nbuf = 1;
        rstart = 0;
        mode = DUMP;
      }
      break;
    }

    lastc = c;
  }

  switch (mode) {
  case DUMP:
    OutDump (nbuf);
    break;
  case RUN:
    OutRun (nbuf - rstart, lastc);
    break;
  }
  *pSource = source;
  *pDest = dest;
  return (putSize);
}

/*---------- putbody ---------------------------------------------------*/
/* NOTE: This implementation could be a LOT faster if it used more of the
 * supplied buffer. It would make far fewer calls to IFFWriteBytes (and
 * therefore to DOS Write).
 *
 * Incorporates modification by Jesper Steen Moller to accept source
 * rows wider than dest rows, with one modulo variable for source bitplane
 * rows and one for the ILBM bitmap rows.
 */
static long putbody (struct IFFHandle *iff,
                     struct BitMap *bitmap,
                     BitMapHeader *bmhd,
                     BYTE *buffer,
                     LONG bufsize)
{
  LONG rowBytes = bitmap->BytesPerRow;	   /* for source modulo only */
  LONG FileRowBytes = RowBytes (bmhd->w);  /* width to write in bytes */
  int dstDepth = bmhd->nPlanes;
  UBYTE compression = bmhd->compression;
  int planeCnt;		/* number of bit planes including mask */
  register int iPlane, iRow;
  register LONG packedRowBytes;
  BYTE *buf;
  BYTE *planes[MAXSAVEDEPTH]; /* array of ptrs to planes & mask */

  if (bufsize < MaxPackedSize(FileRowBytes) ||	/* Must buffer a comprsd row*/
      compression > cmpByteRun1 ||		/* bad arg */
      bitmap->Rows != bmhd->h ||		/* inconsistent */
      rowBytes < FileRowBytes ||	        /* inconsistent*/
      bitmap->Depth < dstDepth ||		/* inconsistent */
      dstDepth > MAXSAVEDEPTH)			/* too many for this routine*/
    return (CLIENT_ERROR);

  planeCnt = dstDepth;

  /* Copy the ptrs to bit & mask planes into local array "planes" */
  for (iPlane = 0; iPlane < dstDepth; iPlane++)
    planes[iPlane] = (BYTE *)bitmap->Planes[iPlane];

  /* Write out the BODY contents */
  for (iRow = bmhd->h; iRow > 0; iRow--)  {
    for (iPlane = 0; iPlane < planeCnt; iPlane++)  {

      buf = buffer;
      packedRowBytes = packrow(&planes[iPlane], &buf, FileRowBytes);
      /* Note that packrow incremented planes already by FileRowBytes */
      planes[iPlane] += rowBytes - FileRowBytes; /* Possibly skipping unused bytes */
      if (WriteChunkBytes (iff, buffer, packedRowBytes) != packedRowBytes)
        return (IFFERR_WRITE);
    }
  }

  return (0);
}


int __asm __saveds save_map (register __a0 struct View *view)
{
  int cmapsize, i;
  struct ViewPort *vp;
  struct RasInfo *ri;
  struct BitMap *bm;
  UWORD *tabw;
  UBYTE *c;
  struct IFFHandle *iff = NULL;
  BOOL ok;
  static BitMapHeader bmhd;
#define BUFSIZE 5004
  static UBYTE cmap[3*256], buffer[BUFSIZE];
  static char filename[20];
  static int mapindex = 0;

  sprintf (filename, "ram:map%3.3ld.iff", mapindex++);

  ok = IFFParseBase != NULL &&
       view != NULL &&
       (vp = view->ViewPort) != NULL &&
       (vp = vp->Next) != NULL &&
       (ri = vp->RasInfo) != NULL &&
       (bm = ri->BitMap) != NULL &&
       (iff = AllocIFF ()) != NULL &&
       (iff->iff_Stream = Open (filename, MODE_NEWFILE)) != NULL;

  if (ok) {
    bmhd.w = bm->BytesPerRow << 3;
    bmhd.h = bm->Rows;
    bmhd.x = 0;
    bmhd.y = 0;
    bmhd.nPlanes = bm->Depth;
    bmhd.masking = 0;
    bmhd.compression = cmpByteRun1;
    bmhd.flags = 0;
    bmhd.transparentColor = 0;
    bmhd.xAspect = 10;
    bmhd.yAspect = 11;
    bmhd.pageWidth = bm->BytesPerRow << 3;
    bmhd.pageHeight = bm->Rows;
    cmapsize = 3 * (1 << bm->Depth);
    tabw = vp->ColorMap->ColorTable;
    c = cmap;
    for (i = cmapsize; i > 0;  i -= 3) {
      c[0]  = (*tabw >> 4) & 0xf0;
      c[0] |= (c[0] >> 4);
      c[1]  = (*tabw     ) & 0xf0;
      c[1] |= (c[1] >> 4);
      c[2]  = (*tabw << 4) & 0xf0;
      c[2] |= (c[2] >> 4);
      tabw++;
      c += 3;
    }
    InitIFFasDOS (iff);
    ok = OpenIFF (iff, IFFF_WRITE) == 0 &&
         PushChunk (iff, ID_ILBM, ID_FORM, IFFSIZE_UNKNOWN) == 0 &&
         PushChunk (iff, ID_ILBM, ID_BMHD, sizeof(bmhd)) == 0 &&
         WriteChunkBytes (iff, &bmhd, sizeof (bmhd)) == sizeof(bmhd) &&
         PopChunk (iff) == 0 &&
         PushChunk (iff, ID_ILBM, ID_CMAP, cmapsize) == 0 &&
         WriteChunkBytes (iff, cmap, cmapsize) == cmapsize &&
         PopChunk (iff) == 0 &&
         PushChunk (iff, ID_ILBM, ID_BODY, IFFSIZE_UNKNOWN) == 0 &&
         putbody (iff, bm, &bmhd, buffer, BUFSIZE) == 0 &&
         PopChunk (iff) == 0 &&
         PopChunk (iff) == 0;
  }

  if (iff != NULL) {
    CloseIFF (iff);
    if (iff->iff_Stream != NULL)
      Close (iff->iff_Stream);
    FreeIFF (iff);
  }

  if (ok)
    return 0;
  else
    return 1;
}

/**********************************************************************/

void __stdargs __saveds trackdisk_read (ULONG starting_sector,
                                        ULONG num_sectors,
                                        char *buffer,
                                        UWORD io_index)
{
  if (fhandle != NULL) {
    Seek (fhandle, starting_sector << 9, OFFSET_BEGINNING);
    Read (fhandle, buffer, num_sectors << 9);
  } else if (bigbuf != NULL)
    CopyMemQuick (&bigbuf[starting_sector << 9], buffer, num_sectors << 9);
}

/**********************************************************************/

