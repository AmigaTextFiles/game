/*
 * ilbmraw.c
 *
 * a simple program to convert IFF ILBM pictures to raw bitplane data
 *
 * by Timo Rossi
 *
 */

/* TODO:
	Prints errors to stderr. Should give 'em to the editor...

	Doesn't handle all possible files perfectly. A very messed up ILBM
	might crash the program. This is a developer's tool only though.
	Not to be distributed. And doesn't matter. Who would load a zapped
	ILBM file anyway?

*/

/* Edited:

	15.9.1991 by N.Paasivirta
		- Works with Night Run Editor
	16.9.1991 by N.Paasivirta
		- More stuff added to Picture structure
	17.9.1992 by N.Paasivirta
		- MaskPlane added

*/

#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <exec/memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <proto/all.h>

#include "ilbm.h"

extern struct GfxBase *GfxBase;

/* Prototypes */
static void skip_pad(FILE *);
static UBYTE *unpackrow(UBYTE *, UBYTE *, int);
struct Picture *SimpleLoadILBM(char *);
void FreePicture(struct Picture *);

static void skip_pad(FILE *fp)
{
  char dummy;
  fread(&dummy, 1, 1, fp);
}

/*
 *  unpacks a single row of cmpByteRun packed data, returns amount to
 *  advance source pointer or zero on error condition.
 *  skips data only if dest==NULL
 */
static UBYTE *unpackrow(UBYTE *ptr, UBYTE *dest, int length)
{
  int len = 0;
  int b, c;

  while(len < length)
    {
      b = *ptr++;
      if(b < 128)
	{
	   if(++b > length - len) return NULL; /* doesn't fit... */
	   if(dest)
	     {
		movmem(ptr, dest, b);
		dest += b;
	     }
	   ptr += b;
	   len += b;
	}
      else if(b > 128)
	{
	   if((b = 257-b) > length - len) return NULL; /* doesn't fit... */
	   c = *ptr++;
	   if(dest)
	     {
		setmem(dest, b, c);
		dest += b;
	     }
	   len += b;
	}
    }
  return ptr;
}

/* Load IFF ILBM file

   Return pointer to an allocated Picture structure (yes, we can have many
   pictures in the memory at the same time). Picture structure contains
   a ready BitMap structure and colortable.

   Failure gives a NULL and an error to stderr (:-( should go to editor...)

   All memory is hopefully freed in the case of failure.

*/

struct Picture *SimpleLoadILBM(char *filename)
{
  int i, y, pl;
  FILE *fp = NULL;
  ULONG tmp[3];
  UBYTE ctab[3];
  struct BitMapHeader BMHD;
  ULONG DisplayMode;
  UWORD ColorTable[32];
  UWORD ColorTableSize = 0;
  BOOL BMHDFound = FALSE, CMAPFound = FALSE, CAMGFound = FALSE;
  UWORD rowBytes;
  UBYTE *BodyBuf = NULL;
  UBYTE *ptr;
  static UBYTE *Planes[MAXPLANES];
  struct Picture *picture = NULL;

  if((fp = fopen(filename,"r")) == NULL)
     {
	fprintf(stderr,"Can't find file '%s'\n",filename);
	return (NULL);
     }

  if(fread((char *)tmp, 4, 3, fp) != 3) goto read_error;
  if(tmp[0] != ID_FORM)
     {
	fprintf(stderr,"Not an IFF FORM type file!\n");
	fclose(fp);
	return(NULL);
     }

#ifdef DEBUG
fprintf(stderr,"SimpleLoadILBM:  FORM Length = %ld\n",tmp[1]);
#endif

  if (tmp[2] != ID_ILBM)
     {
	fprintf(stderr,"Not an IFF ILBM picture file!\n");
	fclose(fp);
	return(NULL);
     }

  /* Allocate and build Picture structure */
  if ((picture = AllocMem(PICSIZE, MEMF_CLEAR))==NULL)
	goto out_of_memory;

  for(;;) /* Chunk loop */
     {
	if(fread((char *)tmp, 4, 2, fp) != 2) goto read_error;
#ifdef DEBUG
	fprintf(stderr,"SimpleLoadILBM: Chunk id = '%c%c%c%c', Length = %ld\n", tmp[0]>>24,
		tmp[0]>>16,tmp[0]>>8,tmp[0],tmp[1]);
#endif

	switch(tmp[0])
	   {
	     case ID_BMHD:
		if(tmp[1] != sizeof(struct BitMapHeader)) goto iff_error;
		if(fread((char *)&BMHD, sizeof(struct BitMapHeader), 1, fp)
			!= 1) goto read_error;
		BMHDFound = TRUE;

		rowBytes = ((BMHD.width+15)/16)*2;
		picture->PlaneSize = rowBytes * BMHD.height;

		/* Allocate mask plane */
		if ((picture->MaskPlane = (PLANEPTR)AllocMem(picture->PlaneSize,
				MEMF_CHIP | MEMF_CLEAR)) == NULL)
			goto out_of_memory;

		break;

	     case ID_CMAP:
		if(tmp[1] % 3) goto iff_error;
		ColorTableSize = tmp[1]/3;
		if(ColorTableSize > 32)
		    {
			fprintf(stderr,"Sorry, can't handle color table with >32 colors!\n");
			fclose(fp);
			return(NULL);
		    }
		for(i = 0; i < ColorTableSize; i++)
		    {
			if(fread((char *)ctab, 3, 1, fp) != 1) goto read_error;
			ColorTable[i] = (((ctab[0]>>4)&0x0f)<<8) |
				(((ctab[1]>>4)&0x0f)<<4) |
				((ctab[2]>>4)&0x0f);
		    }
		if(tmp[1]&1) skip_pad(fp);
		CMAPFound = TRUE;
		break;

	     case ID_CAMG:
		if(fread((char *)&DisplayMode, 4, 1, fp) != 1) goto read_error;
		CAMGFound = TRUE;
		break;

	     case ID_BODY:
		if(!BMHDFound || !CMAPFound) goto iff_error;

#ifdef DEBUG
		fprintf(stderr,"'%s': %d x %d x %d (%d colors)\n",filename,
			BMHD.width, BMHD.height,
			BMHD.nPlanes, ColorTableSize);
#endif

		if(BMHD.nPlanes > MAXPLANES)
		    {
			fprintf(stderr,"Sorry, this can only handle 8 planes maximum\n");
			fclose(fp);
			return(NULL);
		    }
		if((BodyBuf = (UBYTE *)malloc(tmp[1])) == NULL)
			goto out_of_memory;
		if(fread((char *)BodyBuf, tmp[1], 1, fp) != 1)
			goto read_error;

		for(i = 0; i< BMHD.nPlanes; i++)
		    {
			if((Planes[i] = AllocMem(picture->PlaneSize,
					MEMF_CHIP|MEMF_CLEAR)) == NULL)
				goto out_of_memory;
		    }

		ptr = BodyBuf;

		switch(BMHD.compression)
		   {
		     case 0: /* no compression */
			for(y = 0; y < BMHD.height; y++)
			   {
			      for(pl = 0; pl < BMHD.nPlanes; pl++)
				movmem(ptr, Planes[pl]+rowBytes*y, rowBytes);
			      if(BMHD.masking == 1)
				movmem(ptr, picture->MaskPlane + rowBytes*y,
					rowBytes);
			   }
			break;
		     case 1: /* cmbByteRun1 */
			for(y = 0; y < BMHD.height; y++)
			   {
			     for(pl = 0; pl < BMHD.nPlanes; pl++)
			       {
				if((ptr = unpackrow(ptr, Planes[pl] +
				   rowBytes*y, rowBytes)) == NULL)
				    {
				unpack_error:
					fprintf(stderr,"unpacking error, row %d!\n", y);
					return(NULL);
				    }
			       }
			     if(BMHD.masking == 1) {
				if((ptr = unpackrow(ptr, (UBYTE *)
				 (picture->MaskPlane +
				   rowBytes*y), rowBytes)) == NULL)
					goto unpack_error;
			     }
			   }
			break;

		     default:
			fprintf(stderr,"Unknown compression algorithm (%d)\n",
				BMHD.compression);
			return(NULL);
		   }
		free(BodyBuf);
		BodyBuf = 0;
		if(tmp[1]&1) skip_pad(fp);
		goto read_done;
	     default:
#ifdef DEBUG
fprintf(stderr,"SimpleLoadILBM: Skipping unknown chunk\n");
#endif
		if(tmp[1]&1) tmp[1]++; /* round to even... */
		if(fseek(fp, tmp[1], 1) < 0) goto read_error;
		break;
	   }
     }

read_done:
  fclose(fp);
  fp = NULL;

  InitBitMap(&picture->bitmap,BMHD.nPlanes,BMHD.width,BMHD.height);

  if(CAMGFound) picture->DisplayMode = DisplayMode;

  picture->Width = BMHD.width; picture->Height = BMHD.height;

  for(i=0;i < BMHD.nPlanes ;i++)
	picture->bitmap.Planes[i] = (PLANEPTR)Planes[i];

  for(i=0;i<32;i++) picture->ColorTable[i] = ColorTable[i];

  if (BMHD.masking != 1) {
	/* Make maskplane */
	for(i = 0; i < BMHD.nPlanes; i++) {

		register UBYTE *goppa, *kwagga;
		register int lenghti;

		goppa = picture->bitmap.Planes[i];
		kwagga = picture->MaskPlane;
		lenghti = picture->PlaneSize;

//	printf("plane: %lx, mask: %lx, lengthi %d\n", goppa, kwagga, lenghti);

		while(lenghti--) {
			*kwagga++ |= *goppa++;
		}
	
	}
  }

/* Everything's quite OK, now just return the address! */
  return(picture);


iff_error:
  fclose(fp);
  fprintf(stderr,"SimpleLoadILBM: IFF file error!\n");
  return(NULL);

read_error:
  fclose(fp);
  fprintf(stderr,"SimpleLoadILBM: Read error!\n");
  return(NULL);

out_of_memory:
  fprintf(stderr,"SimpleLoadILBM: Out of memory!\n");

  if (picture) {
	if (picture->MaskPlane) FreeMem(picture->MaskPlane, picture->PlaneSize);
	FreeMem(picture, PICSIZE);
  }

  for(i=0;i < BMHD.nPlanes; i++)
	if(Planes[i]) FreeMem(Planes[i],picture->PlaneSize);
  if(BodyBuf) free(BodyBuf);
  if(fp) fclose(fp);

  return(NULL);
}

/* Don't free picture twice, btw... */
void FreePicture(struct Picture *picture)
{
  int i;

  if(!picture) return;

  for(i=0; i < picture->bitmap.Depth ;i++)
	if(picture->bitmap.Planes[i])
		FreeMem(picture->bitmap.Planes[i],picture->PlaneSize);

  if (picture->MaskPlane) FreeMem(picture->MaskPlane,picture->PlaneSize);

  FreeMem(picture,PICSIZE);
}
