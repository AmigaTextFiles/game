/* ===================================================================== *
 *							+-----------+	 *
 *	:ts=8						| V15.08.87 |	 *
 *							+-----------+	 *
 *	POPLIFE, by Olaf Seibert (KosmoSoft)				 *
 *									 *
 *	Based on both Life by Tomas Rokicki (Fish #31) and		 *
 *	the PDP-11 code presented in "Life Algorithms" by Mark Niemieck, *
 *	in Byte 4:1, January 1979, and					 *
 *	Popcli II by John Toebes and the Software Distillery (Fish #40). *
 *									 *
 * ===================================================================== */


#include "structures.h"

/* --------------------------------------------------------------------- *
 * 	Static data for the DoGeneration() routine.			 *
 *	Also used by Initialize() and Cleanup().			 *
 * --------------------------------------------------------------------- */

WORD *Plane0, *Plane1, *Plane2, *Plane3, *Plane4;
WORD *Temp1=NULL, *Temp2=NULL, *Temp3=NULL, *Temp4=NULL, *Temp5=NULL;
short NoPlanes = 1;
BOOL UseBlitter = TRUE;
struct AdresRegs {
	LONG A0;	/* Current longword pointer */
	LONG A1;	/* Current longword pointer in new generation */
	LONG A2;	/* End of screen, sortof */
	LONG A3;	/* One line above current longword */
	LONG A4;	/* One line below current longword */
} ARegs;

int GlobHSizeMin2;
int GlobVSize;
int GlobVSizeMin2;
int GlobModulo;

/* --------------------------------------------------------------------- *
 *	Library Base Pointers.						 *
 * --------------------------------------------------------------------- */

struct GfxBase *GfxBase = NULL;			/* the GfxBase */
struct IntuitionBase *IntuitionBase = NULL;	/* the IntuitionBase */

/* --------------------------------------------------------------------- *
 *	External Routines and Data Structures.				 *
 * --------------------------------------------------------------------- */

extern struct CommandLineInterface *_argcli;
/* extern struct Custom custom; */	/* Aztec 3.40a doesn't need this */

/* extern APTR             AllocMem(); */
/* extern struct MsgPort  *CreatePort(); */
/* extern void             DeletePort(); */
/* extern struct IOStdReq *CreateStdIO(); */
/* extern void             DeleteStdIO(); */
/* extern struct task     *FindTask(); */

/* --------------------------------------------------------------------- *
 *	Forward Declarations.						 *
 * --------------------------------------------------------------------- */

VOID		InitBlitData();
VOID		Blit();
BOOL		Initialize();
VOID		Cleanup();
VOID		DoGeneration();
ULONG		LookForKeys();
VOID            HandlerInterface();

/* --------------------------------------------------------------------- */

/*
 *   This include file includes the defines for all the blitter functions.
 *   It only allows use of the `blit' operations; for area fills or line
 *   drawing, it will need to be extended.
 *
 *   Information gleaned from the Hardware Reference Manual.
 *   [A little to much, so too little compatibility... [Olaf Seibert]]
 */

#define BLTADD (&custom.bltcon0)

/*
 *   This structure contains everything we need to know.
 *   Do not do a structure copy into this!  Instead, assign
 *   each field.  The last field assigned must be bltsize; that
 *   starts up the blitter.  Also note that all of these are
 *   write only, and you can't read them.
 */

struct BltStruct {
	WORD con0;
	WORD con1;
	WORD afwm;
	WORD alwm;
	WORD *csource, *bsource, *asource, *dsource;
	WORD bltsize;
	WORD dmy1, dmy2, dmy3;
	WORD cmod, bmod, amod, dmod;
};
struct BltStruct *Blitter = (struct BltStruct *)BLTADD;

/* --------------------------------------------------------------------- *
 *
 *   Static data for the BLITTER routine.
 *
 *   We need an array which tells what to use
 *   for all 256 possible operations.
 *
 * --------------------------------------------------------------------- */

UBYTE ToUse[256];	/* Which DMA channels we need per minterm */
UWORD FwmA[16];		/* First word mask for A source */
UWORD LwmA[16];		/* Last word mask for A source */

/*
 *   Call InitBlitData() once on startup before you ever call Blit().
 *   Have a look in the Hardware Reference Manual for the mysterious
 *   bit patterns. They are quite obvious then!
 */

VOID InitBlitData()
{
	register WORD i;
	register UWORD s;

	for (i=0; i<256; i++) {
		s = DEST >> 8;
		if ((i >> 4) != (i & 15))	  /* 15 is 0000 1111 */
			s += SRCA >> 8;
		if (((i >> 2) & 51) != (i & 51))  /* 51 is 0011 0011 */
			s += SRCB >> 8;
		if (((i >> 1) & 85) != (i & 85))  /* 85 is 0101 0101 */
			s += SRCC >> 8;
		ToUse[i] = s;
	}
	s = 0xFFFF;
	for (i=0; i<16; i++) {
		FwmA[i] = s;
		s >>= 1;
		LwmA[i] = 0xffff - s;
	}
}

/* --------------------------------------------------------------------- *
 *
 *   This is the major user interface.  Takes addresses and offsets for
 *   all four locations, a modulo and sizes, and a function.
 *   Assumes the modulos for all sources and destination are the same.
 *   You might want to add some arguments or delete some.
 *
 *   All arguments are in pixels (except the addresses and function.)
 *
 *   Before you call this routine, call OwnBlitter(); after you have
 *   called it as many times as you need, call DisownBlitter().  Remember
 *   that you cannot do any printf's or anything else which requires the
 *   blitter when you own the blitter, so be careful with the debug code.
 *   The machine will lock but will not crash.
 *
 *   Note that only the A and B source can be shifted, and that only A
 *   has a first- and last word mask.
 *   Because of this, it is in general recommendable that the low 4 bits
 *   of the C and D x position are the same.
 *   Also note that the complete words that fall in the D area are touched.
 *
 * --------------------------------------------------------------------- */

VOID Blit(	aaddress, ax, ay,
		baddress, bx, by,
		caddress, cx, cy,
		daddress, dx, dy,
		modulo, xsize, ysize, function)
WORD *aaddress, *baddress, *caddress, *daddress;
int ax, ay, bx, by, cx, cy, dx, dy, modulo, xsize, ysize, function;
{
	WORD *t;

/*
 *   Divide the modulo by 16 because we need words.
 */
	modulo >>= 4;
/*
 *   Wait for the blitter to finish whatever it needs to do.
 */
	WaitBlit();
/*
 *   Calculate the real addresses for d and c.
 */
	Blitter->dsource = daddress + modulo * dy + (dx >> 4);
	Blitter->csource = caddress + modulo * cy + (cx >> 4);
/*
 *   Mask out the low order bits of dx; add these to the xsize.  (The
 *   first bits will be masked using the first word mask.)
 */
	dx &= 15;
	xsize += dx;
	Blitter->afwm = FwmA[dx];
	Blitter->alwm = LwmA[(xsize - 1) & 15];
/*
 *   Now calculate the shifts for the A and B operands.  The barrel
 *   shifter counts appear to be to the left instead of the more
 *   intuitive to the right.  Note that I take dx into account.
 */
	t = aaddress + modulo * ay + (ax >> 4);
	ax = dx - (ax & 15);
	if (ax < 0) {
		t++;
		ax += 16;
	}
	Blitter->asource = t;
	t = baddress + modulo * by + (bx >> 4);
	bx = dx - (bx & 15);
	if (bx < 0) {
		t++;
		bx += 16;
	}
	Blitter->bsource = t;
/*
 *   Now calculate the two control words.  If you want to do
 *   the addresses in reverse order, set the appropriate bit in con1.
 */
	Blitter->con0 = (ax << 12) + (ToUse[function] << 8) + function;
	Blitter->con1 = (bx << 12);
/*
 *   Calculate the final total xsize in words, and the modulos.  The
 *   modulos are in bytes when written from the 68000.
 */
	xsize = (xsize + 15) >> 4;
	Blitter->amod = Blitter->bmod = Blitter->cmod = Blitter->dmod =
	    2 * (modulo - xsize);
/*
 *   This last assignment starts up the blitter.
 */
	Blitter->bltsize = (ysize << 6) + xsize;
}

/* --------------------------------------------------------------------- */

/*
 *   Here we set things up. (Or do we upset them? :-)
 */

BOOL Initialize(Screen)
struct Screen *Screen;
{
	register struct BitMap *BitMap = &Screen->BitMap;
	register long Xsize, Ysize;
	register long BytesPerRow;

	InitBlitData();

	Plane0 = (WORD *) (BitMap->Planes[0]);
	Plane1 = (WORD *) (BitMap->Planes[1]);
	Plane2 = (WORD *) (BitMap->Planes[2]);
	Plane3 = (WORD *) (BitMap->Planes[3]);
	Plane4 = (WORD *) (BitMap->Planes[4]);

	/* NoPlanes = BitMap->Depth; */

	BytesPerRow = BitMap->BytesPerRow;
	Xsize = BytesPerRow * 8;
	Ysize = BitMap->Rows;

	GlobHSizeMin2 = Xsize - 2;
	GlobVSize = Ysize;
	GlobVSizeMin2 = Ysize - 2;
	GlobModulo = (Xsize + 15) & ~15;

	if (Temp1)	/* This really shouldn't happen... */
		return FALSE;

	Temp1 = AllocRaster(Xsize, Ysize);

	if (UseBlitter && Temp1) {
		Temp2 = AllocRaster(Xsize, Ysize);
		Temp3 = AllocRaster(Xsize, Ysize);
		Temp4 = AllocRaster(Xsize, Ysize);
		Temp5 = AllocRaster(Xsize, Ysize);

		if (Temp2 && Temp3 && Temp4 && Temp5) {
			SetAPen(&Screen->RastPort, 0L);
			SetDrMd(&Screen->RastPort, JAM1);
			Move(&Screen->RastPort, 0L, 0L);
			Draw(&Screen->RastPort, Xsize-1, 0L);
			Move(&Screen->RastPort, 0L, Ysize-1);
			Draw(&Screen->RastPort, Xsize-1, Ysize-1);
			return FALSE;
		}

	} 
	
	if (Temp1) {	/* We can use the slower algorithm */
		if (Temp2) FreeRaster(Temp2, Xsize, Ysize);
		if (Temp3) FreeRaster(Temp3, Xsize, Ysize);
		if (Temp4) FreeRaster(Temp4, Xsize, Ysize);
		if (Temp5) FreeRaster(Temp5, Xsize, Ysize);

		Temp2 = Temp3 = Temp4 = Temp5 = NULL;

		ARegs.A1 = ((LONG) Temp1) + BytesPerRow;
		ARegs.A2 = ((LONG) Plane0) + BytesPerRow * (Ysize - 1L);
		ARegs.A3 = (LONG) Plane0;
		ARegs.A0 = ARegs.A3 + BytesPerRow;
		ARegs.A4 = ARegs.A0 + BytesPerRow;

		return FALSE;
	}

	Cleanup(Screen);
	return TRUE;
}


/*
 *   Deallocation routine.
 */

VOID Cleanup(Screen)
struct Screen *Screen;
{
	register struct BitMap *BitMap = &Screen->BitMap;
	register long Xsize, Ysize;

	Xsize = BitMap->BytesPerRow * 8;
	Ysize = BitMap->Rows;

	if (Temp1) FreeRaster(Temp1, Xsize, Ysize);
	if (Temp2) FreeRaster(Temp2, Xsize, Ysize);
	if (Temp3) FreeRaster(Temp3, Xsize, Ysize);
	if (Temp4) FreeRaster(Temp4, Xsize, Ysize);
	if (Temp5) FreeRaster(Temp5, Xsize, Ysize);

	Temp1 = Temp2 = Temp3 = Temp4 = Temp5 = NULL;
}

/* --------------------------------------------------------------------- *
 *		           --   - -   --
 *   SUM3:	D = ABC + ABC + ABC + ABC = A XOR B XOR C.
 *	Adds the value of the pixels in A, B and C. Ignores carry.
 *			    -    -    -
 *   CARRY3:	D = ABC + ABC + ABC + ABC.
 *	Gets the carry for SUM3.
 *		     -   - 
 *   SUM2:	D = AB + AB = A XOR C.
 *	Adds the value of the pixels in A and B. Ignores carry.
 *
 *   CARRY2:	D = AB.
 *	Gets the carry for SUM2.
 *		     --   --
 *   SPECIAL1:	D = ABC + ABC.
 *	A = Temp1  (2) low bit of high sum
 *	B = Temp4  (4) high bit of high sum
 *	C = Temp3  (2) high bit of low sum, carry
 *	D = Temp2  Only 1 if sum is 2 or 3: Not 4 and exactly one 2 value
 *			    -    -
 *   SPECIAL2:	D = ABC + ABC + ABC.
 *	A = Temp2  Only 1 if 2 or 3 neighbours: only place where can be a cell
 *	B = Temp5  Only 1 if odd # of neighbours
 *	C = last generation
 *	D = new generation
 *
 * --------------------------------------------------------------------- */

#define	SUM3		(int) (ABC   | ANBNC | NABNC | NANBC)	/* 0x96 */
#define	CARRY3		(int) (ABC   | ABNC  | ANBC  | NABC)	/* 0xE8 */
#define	SUM2		(int) (ANBC  | ANBNC | NABC  | NABNC)	/* 0x3C */
#define	CARRY2		(int) (ABC   | ABNC)			/* 0xC0 */
#define	SPECIAL1	(int) (ANBNC | NANBC)			/* 0x12 */
#define	SPECIAL2	(int) (ABC   | ABNC  | ANBC)		/* 0xE0 */
#define	COPY		(int) (A_TO_D)				/* 0xF0 */

/* --------------------------------------------------------------------- *
 *									 *
 *   Does one LIFE generation.  Fancy algorithm uses only 10 blits.  If  *
 *   anyone can improve this, please let me know.			 *
 *   [If only I could determine `3 or 4' in one blit: it would save	 *
 *   TWO blits!]							 *
 *									 *
 * --------------------------------------------------------------------- */

VOID DoGeneration()
{
	register int HSizeMin2 = GlobHSizeMin2;
	register int VSize     = GlobVSize;
	register int VSizeMin2 = GlobVSizeMin2;
	register int Modulo    = GlobModulo;

	if (Temp2) {	/* We have 5 temporary planes. Use the blitter! */
	OwnBlitter();
/*
 *   Take horizontal sums.
 *   Every pair of pixels in Temp1/Temp2 is the sum of the three horizontal
 *   pixels of which that one is the middle.
 */
	Blit(	Plane0, 0, 0,	/* A pixel left */
		Plane0, 2, 0,	/* A pixel right */
		Plane0, 1, 0,	/* The middle pixel */
		Temp1,  1, 0,	/* Low bit of the sum */
		Modulo, HSizeMin2, VSize, SUM3);
	Blit(	Plane0, 0, 0,
		Plane0, 2, 0,
		Plane0, 1, 0,
		Temp2,  1, 0,	/* High bit of the same */
		Modulo, HSizeMin2, VSize, CARRY3);
/*
 *   Take sums for middle row.
 *   Every pair of pixels in Temp3/Temp4 is the sum of the two horizontal
 *   pixels next to the one in the middle.
 */
	Blit(	Plane0, 0, 0,	/* Pixel left */
		Plane0, 2, 0,	/* Pixel right */
		NULL,   0, 0,	/* This is ignored */
		Temp3,  1, 0,	/* Low bit of the sum */
		Modulo, HSizeMin2, VSize, SUM2);
	Blit(	Plane0, 0, 0,
		Plane0, 2, 0,
		NULL,   0, 0,
		Temp4,  1, 0,	/* High bit of the same */
		Modulo, HSizeMin2, VSize, CARRY2);
/*
 *   Now, sum each of the three columns.
 *   Add vertically low bits of up -o+, down -o+, and -+, to Temp5/Temp3.
 *   For a proper addition, this carry should be added to
 *   the sum of the high bits.
 */
	Blit(	Temp1, 1, 0,	/* 3 bits above */
		Temp1, 1, 2,	/* 3 bits below */
		Temp3, 1, 1,	/* 2 bits left and right */
		Temp5, 1, 1,	/* Low bit of sum of low bits, value 1 */
		Modulo, HSizeMin2, VSizeMin2, SUM3);
	Blit(	Temp1, 1, 0,
		Temp1, 1, 2,
		Temp3, 1, 1,
		Temp3, 1, 1,	/* Carry of sum of low bits, value 2 */
		Modulo, HSizeMin2, VSizeMin2, CARRY3);
/*
 *   Add the high bits of the same to Temp1/Temp4.
 */
	Blit(	Temp2, 1, 0,	/* 3 bits above, high bit */
		Temp2, 1, 2,	/* 3 bits below, high bit */
		Temp4, 1, 1,	/* 2 bits left & right, high bit */
		Temp1, 1, 1,	/* Low bit of sum of high bits, value 2 */
		Modulo, HSizeMin2, VSizeMin2, SUM3);
	Blit(	Temp2, 1, 0,
		Temp2, 1, 2,
		Temp4, 1, 1,
		Temp4, 1, 1,	/* High bit of sum of high bits, value 4 */
		Modulo, HSizeMin2, VSizeMin2, CARRY3);
/*
 *   Now, the situation is as follows: If the number of neighbours is
 *        0  1  2  2  3  3  4  4  5  5  6  6  7  7  8  Value
 *   Temp5 | 0  1  0  0  1  1  0  0  1  1  0  0  1  1  0   = 1 Low sum
 *   Temp3 | 0  0  1  0  1  0  1  0  1  0  1  0  1  0  1   = 2 Low carry
 *   Temp1 | 0  0  0  1  0  1  1  0  1  0  0  1  0  1  1   = 2 High sum
 *   Temp4 | 0  0  0  0  0  0  0  1  0  1  1  1  1  1  1   = 4 High carry
 *
 *   Now, check high two order bits, then combine with original and
 *   low order bit.	ANBNC + NANBC. -- Temp1./Temp4./Temp3 + /Temp1./Temp4.Temp3
 */
	Blit(	Temp1, 1, 1,	/* Either Temp1 or Temp3 must be 1 */
		Temp4, 1, 1,	/* but Temp4 certainly not, */
		Temp3, 1, 1,	/* so the result */
		Temp2, 1, 1,	/* gets 1 if the sum is 2 or 3. */
		Modulo, HSizeMin2, VSizeMin2, SPECIAL1);
/*
 *   Before we do the final write, we copy bits down one generation.
 *   Pushing zeros for ignored arguments is faster than any
 *   other value.
 */
	switch (NoPlanes) {
	case 5:
		Blit(	Plane3, 1, 1,
			NULL,   0, 0,
			NULL,   0, 0,
			Plane4, 1, 1,
			Modulo, HSizeMin2, VSizeMin2, COPY);
	case 4:
		Blit(	Plane2, 1, 1,
			NULL,   0, 0,
			NULL,   0, 0,
			Plane3, 1, 1,
			Modulo, HSizeMin2, VSizeMin2, COPY);
	case 3:
		Blit(	Plane1, 1, 1,
			NULL,   0, 0,
			NULL,   0, 0,
			Plane2, 1, 1,
			Modulo, HSizeMin2, VSizeMin2, COPY);
	case 2:
		Blit(	Plane0, 1, 1,
			NULL,   0, 0,
			NULL,   0, 0,
			Plane1, 1, 1,
			Modulo, HSizeMin2, VSizeMin2, COPY);
	default: 
		;
	}

	Blit(	Temp2,  1, 1,
		Temp5,  1, 1,
		Plane0, 1, 1,
		Plane0, 1, 1,
		Modulo, HSizeMin2, VSizeMin2, SPECIAL2);

	DisownBlitter();
	} else {	/* Not enough Temp space. Use processor instead. */
#asm
	xdef	slow
	xdef	again
slow:
	movem.l	D2-D4/D7/A2-A4,-(sp)	;Save registers except A0, A1, D0, D1

;;	Register usage:
;;	A0 = pointer to current longword in screen
;;	A1 = pointer to current longword in temp storage
;;	A2 = pointer beyond last longword in screen we use
;;	A3 = pointer to -80(A0) for hires and -40(A0) for lores: line above
;;	A4 = pointer to 80(A0) for hires and 40(A0) for lores: line below

	movem.l	_ARegs,A0-A4		;Get precalculated pointers

;;	From this point on, DO NOT access memory 'absolute'ly 
;;	since the assembler wants to use A4 as a base register.
;;	Fortunately, we don't need to.
;;
;;	1 2 3	The cells are numbered like this.
;;	7 . 8
;;	4 5 6

;;	(D1,D0) = neighbours 1+2. D1 contains the 32 high bits.

again:
	move.l	(A3),D0			;Get the bits above
	move.l	D0,D1
	move.l	D0,D2			;Save this for #3
	move.b	-1(A3),D7		;Get number 1
	roxr.b	#1,D7			; and shift it into D0
	roxr.l	#1,D0

	eor.l	D1,D0			;trick to add 2 bits x 32: low bit
	or.l	D0,D1
	eor.l	D0,D1			;high bit of sum

;;	(D1,D0) = neighbours 1+2+3.

	move.b	4(A3),D7		;Get bit for # 3
	roxl.b	#1,D7			; into X bit
	roxl.l	#1,D2			; to D2

	eor.l	D2,D0			;low bit of new number
	or.l	D0,D2
	eor.l	D0,D2
	or.l	D2,D1			;high bit of sum

;;	(D3,D2) = neighbours 4+5

	move.l	(A4),D2
	move.l	D2,D3
	move.l	D2,D4
	move.b	-1(A4),D7
	roxr.b	#1,D7
	roxr.l	#1,D2			;# 4 shifted right

	eor.l	D3,D2			;low bit of sum
	or.l	D2,D3
	eor.l	D2,D3

;;	(D3,D2) = neighbours 4+5+6

	move.b	4(A4),D7
	roxl.b	#1,D7
	roxl.l	#1,D4			;#6 shifted left

	eor.l	D4,D2			;low bits
	or.l	D2,D4
	eor.l	D2,D4
	or.l	D4,D3			;carry over


;;	(D2,D1,D0) = neighbours 1+2+3+4+5+6
;;	Add (D3,D2) to (D1,D0)

	eor.l	D2,D0			;low bits
	or.l	D0,D2
	eor.l	D0,D2			;carry of low bits

	eor.l	D2,D1			;carry of low bits to high bits
	or.l	D1,D2
	eor.l	D1,D2

	eor.l	D3,D1			;sum high bits
	or.l	D1,D3
	eor.l	D1,D3
	or.l	D3,D2			

;;	(D4,D3) = neighbours 7+8

	move.l	(A0),D3
	move.l	D3,D4
	move.b	-1(A0),D7
	roxr.b	#1,D7
	roxr.l	#1,D3			;bits for #7 shifted right
	move.b	4(A0),D7

	roxl.b	#1,D7
	roxl.l	#1,D4			;bits for #8 shifted left

	eor.l	D4,D3
	or.l	D3,D4
	eor.l	D3,D4

;;	(D2,D1,D0) = neighbours 1+2+3+4+5+6+7+8
;;	Note that carry is ignored, so 8 == 0, but fortunately
;;	both are wrong, and so is 1.

	eor.l	D3,D0			;low bits
	or.l	D0,D3
	eor.l	D0,D3

	eor.l	D3,D1			;carry over to mid bits
	or.l	D1,D3
	eor.l	D1,D3

	eor.l	D4,D1			;sum mid bits
	or.l	D1,D4
	eor.l	D1,D4

	or.l	D3,D2
	or.l	D4,D2

;;	Next generation

	or.l	(A0)+,D0		;Give existing cells an odd # (2->3)
	not.l	D2			;A 4-worth bit is wrong
	and.l	D2,D0			;and both the 1-worth and the
	and.l	D1,D0			;2-worth must be 1 for a sum of 3

	move.l	D0,(A1)+		;Get it into the destination

	lea	4(A3),A3		;Advance other pointers
	lea	4(A4),A4

	cmp.l	A2,A0			;See if we are done yet
	blt	again

	movem.l	(sp)+,D2-D4/D7/A2-A4	;Restore registers

#endasm
		OwnBlitter();
		Blit(	Temp1,  1, 1,
			NULL,   0, 0,
			NULL,   0, 0,
			Plane0, 1, 1,
			Modulo, HSizeMin2, VSizeMin2, COPY);
		DisownBlitter();
	}	/* End if we may use blitter */
}

/* --------------------------------------------------------------------- */
/* --------------------------------------------------------------------- */
/* --------------------------------------------------------------------- */

#define	ACTIVATEKEY	0x55	/* F6 */
#define	GENERATIONKEY	0x56	/* F7 */
#define	DYNASTYKEY	0x57	/* F8 */

/* --------------------------------------------------------------------- *
 *
 *	HandlerInterface()
 *
 *	This code is needed to convert the calling sequence performed by
 *	the input.task for the  input stream  management into  something
 *	that a C program can understand.
 *
 *	This routine expects a pointer to an InputEvent in A0, a pointer
 *	to a data area in A1.  These values are transferred to the stack
 *	in the order that a C program would need to find them. Since the
 *	actual handler is written in C, this works out fine. 
 *	If it wouldn't, we would do it another way :-)
 *
 *	Author: Rob Peck, 12/1/85
 *	Manxified by Olaf Seibert (KosmoSoft) (Not very much work...)
 *
 * --------------------------------------------------------------------- */

#asm
	xref	_MyHandler

_HandlerInterface:
	movem.L	A0/A1,-(SP)
	jsr	_MyHandler
	addq.L	#8,SP
	rts

#endasm

/* --------------------------------------------------------------------- *
 *	Global variables shared by the interrupt code.			 *
 * --------------------------------------------------------------------- */

typedef struct
{
	struct Task	*LifeTask;	/* Actually, Process */
	ULONG		 Activate;	/* Signal masks */
	ULONG		 Generation;
	ULONG		 Dynasty;
	BYTE		 Active;	/* Are we active (mem. allocated) */
	BYTE		 Padding00;
	struct Screen	*Screen;	/* Front screen */
	struct IntuitionBase *IBase;	/* Share the tasks pointer */
} GLOBAL_DATA;

GLOBAL_DATA		Global;
struct Interrupt	handlerStuff;

/* --------------------------------------------------------------------- */

ULONG LookForKeys(Code, gptr)
UBYTE Code;
register GLOBAL_DATA *gptr;
{
	if (Code == ACTIVATEKEY) {
		gptr->Screen = gptr->IBase->FirstScreen;
		gptr->Active = !gptr->Active;
		return gptr->Activate;
	}

	if (Code == GENERATIONKEY && gptr->Active)
		return gptr->Generation;

	if (Code == DYNASTYKEY && gptr->Active)
		return gptr->Dynasty;

	return 0;
}

/* --------------------------------------------------------------------- *
 * The handler subroutine - Called through the handler stub.		 *
 * --------------------------------------------------------------------- */

struct InputEvent *MyHandler(ev, gptr)
struct InputEvent *ev;		/* and a pointer to a list of events */
register GLOBAL_DATA *gptr;	/* Everything we need to know about */
{
	register struct InputEvent *ep, *laste;
	register ULONG Signals;

	int_start();	/* Manx peculiarity. Saves D2-D3 and A4. */

	/* Run down the list of events to see if they pressed	*/
	/* one of the magic buttons.				*/
	for (ep = ev, laste = NULL; ep != NULL; ep = ep->ie_NextEvent)
	{
		if ((ep->ie_Class == IECLASS_RAWKEY) &&
		    (ep->ie_Qualifier & IEQUALIFIER_LCOMMAND))
		{
			if (Signals = LookForKeys(ep->ie_Code, gptr)) {
				/* We can handle this event so take it off the chain */
				if (laste == NULL)
					ev = ep->ie_NextEvent;
				else
					laste->ie_NextEvent = ep->ie_NextEvent;
				/* Now tell him to do its thing */
				Signal(gptr->LifeTask, Signals);
			}
		}
		else
			laste = ep;

	}

	int_end();	/* Manx peculiarity */

	/* Pass on the pointer to the event */
	return ev;
}

/* --------------------------------------------------------------------- *
 * 	Our initial greeting messages for the user.			 *
 *	PopLife - a joke thrown together by Olaf Seibert, KosmoSoft	 *
 * --------------------------------------------------------------------- */

char Header[] = "\n\
\x9B0;1;33mPopLife\x9B0;31m - a joke thrown together by \x9B33mOlaf Seibert, KosmoSoft\x9B31m\n\
";

char Greetings[] = "\
\x9B33mUsage:\x9B31m \x9B1mRUN PopLife\x9B0m\n\
\x9B33mKeys:\x9B31m  \x9B1mLeft Amiga F6:\x9B0m Initialize & Cleanup temporary storage\n\
       \x9B1mLeft Amiga F7:\x9B0m Single generation\n\
       \x9B1mLeft Amiga F8:\x9B0m Many generations\n\
";

char GoodBye[] = "\
\n\
Killing the other PopLife incarnation...\n\
";

char PortName[] = "poplife.input.device.port";

/* --------------------------------------------------------------------- *
 * 	A Cleanup support function. Close the IO if we are not a CLI.	 *
 * --------------------------------------------------------------------- */

VOID CloseFiles()
{
	register struct FileHandle *input, *output;

	/* - From  Workbench.  Let 'em read  the message. - */

	if (!_argcli) {
		input = Input();
		output = Output();

		if (IsInteractive(input))
			WaitForChar(input, 10 * 1000000);

		/* Unfortunately from the CLI we can't Close those files */
		/* because they are `given' to us. */
		/* (Unless we want to crash after we exit...) */
		/* Besides, it won't help because there is always an open */
		/* file to the console left: _argcli->cli_CurrentOutput */
		/* EVEN if we RUN PopLife <NIL: >NIL: */

		if (input != output)
			Close(input);
		Close(output);
	}
}

/* --------------------------------------------------------------------- *
 * 	The main program to do the PopLife stuff.			 *
 * --------------------------------------------------------------------- */

VOID main(argc, argv)
int argc;		/* This should always be -1, since */
char *argv;		/* I use my own startup module */
{
	register struct Screen *Screen = NULL;
	struct MsgPort *inputDevPort;
	struct IOStdReq *inputRequestBlock;
	register ULONG WaitMask;
	ULONG Sig1 = 0, Sig2 = 0, Sig3 = 0;

	/* ------------------------------------------------------------- *
	 *	First find out if there is already another PopLife
	 *	hanging around. If so, kick it out of existance.
	 *	Handy for Workbench users, and our own protection.
	 *	There is a possibility of a race here ==> Forbid()...
	 * ------------------------------------------------------------- */

	Forbid();

	if (inputDevPort = FindPort(PortName)) {
		Signal(inputDevPort->mp_SigTask, SIGBREAKF_CTRL_C);
		Write(Output(), Header,  (long) sizeof(Header));
		Write(Output(), GoodBye, (long) sizeof(GoodBye));
		goto abortp;
	}

	if ((inputDevPort = CreatePort(PortName,0L)) == NULL) {
		goto abortp;
	}

	Permit();

	if ((inputRequestBlock = CreateStdIO(inputDevPort)) == NULL)
		goto abort;

	if ((GfxBase = (struct GfxBase *)
	    OpenLibrary("graphics.library", 0)) == NULL)
		goto abort;

	if ((IntuitionBase = (struct IntuitionBase *)
	    OpenLibrary("intuition.library", 0)) == NULL)
		goto abort;

	Global.IBase = IntuitionBase;

	Sig1 = AllocSignal(-1L);
	Sig2 = AllocSignal(-1L);
	Sig3 = AllocSignal(-1L);
	if (Sig1 < 0 || Sig2 < 0 || Sig3 < 0)
		goto abort;

	Global.Activate   = 1L << Sig1;
	Global.Generation = 1L << Sig2;
	Global.Dynasty    = 1L << Sig3;

	handlerStuff.is_Data = (APTR)&Global;
	handlerStuff.is_Code = HandlerInterface;
	handlerStuff.is_Node.ln_Succ =
	handlerStuff.is_Node.ln_Pred = NULL;
	handlerStuff.is_Node.ln_Type = NT_INTERRUPT;
	handlerStuff.is_Node.ln_Pri = 51;
	handlerStuff.is_Node.ln_Name = "PopLife.input.handler";

	if (OpenDevice("input.device",0L,inputRequestBlock,0L))
		goto abort;

	inputRequestBlock->io_Command = IND_ADDHANDLER;
	inputRequestBlock->io_Data    = (APTR)&handlerStuff;

	DoIO(inputRequestBlock);

	Global.LifeTask = FindTask(NULL);
	Global.Active = FALSE;

	/* - See if we should not use the blitter, to save memory - */

	if (argv[0] == '1')
		UseBlitter = FALSE;

	/* - Time to greet the user - if AmigaDOG will let us. - */

	{
		struct FileHandle *File;

		File = Output();
		Write(File, Header,    (long) sizeof(Header));
		Write(File, Greetings, (long) sizeof(Greetings));
		CloseFiles();
	}

	WaitMask = Global.Activate | Global.Generation | Global.Dynasty |
		   SIGBREAKF_CTRL_C;

	for(;;) {	/* - FOREVER - */
		ULONG Sig = Wait(WaitMask);

		if (Sig & SIGBREAKF_CTRL_C)
			break;

		if (Sig & Global.Activate) {
			if (Global.Active) {
				Screen = Global.Screen;
				if (Initialize(Screen)) {
					Global.Active = FALSE;
					DisplayBeep(NULL);
					Screen = NULL;
					continue;
				}
			} else {
				Cleanup(Screen);
				Screen = NULL;
				continue;
			}
		}

		if (Sig & Global.Dynasty) {
			do {	/* - Quite a dynasty! - */
				DoGeneration();
			} while (! (SetSignal(0L, 0L) & WaitMask));
			/* - Forget a second hit of the Dynasty key - */
			SetSignal(0L, Global.Dynasty);
			continue;
		}

		if (Sig & Global.Generation) {
			DoGeneration();
		}

	}	/* - End FOREVER - */

	inputRequestBlock->io_Command = IND_REMHANDLER;

	DoIO(inputRequestBlock);

abort:
	if (Screen)	Cleanup(Screen);

	if (Sig1 >= 0)	FreeSignal(Sig1);
	if (Sig2 >= 0)	FreeSignal(Sig2);
	if (Sig3 >= 0)	FreeSignal(Sig3);

	if (inputRequestBlock != NULL)	DeleteStdIO(inputRequestBlock);
	if (inputDevPort != NULL)	DeletePort(inputDevPort);

	if (IntuitionBase != NULL)	CloseLibrary(IntuitionBase);
	if (GfxBase != NULL)		CloseLibrary(GfxBase);

	return;

abortp:
	Permit();
	CloseFiles();
}
