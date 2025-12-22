	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        ExtGfx.s
* Version:     6
* Revision:    0
* Created:     ??/??/????
* By:          FNC Slothouber
* Last Update: 12-IV-1993
* By:          FNC Slothouber
* 
*
*==========================================

	XREF	_IntuitionBase
	XREF	_GfxBase
	XREF	_DOSBase

	XDEF	AllocRasters
	XDEF	FreeRasters
	XDEF	EG_AllocBitMap
	XDEF	EG_FreeBitMap
	XDEF	GetPicture
	XDEF	ClearBitMap
	XDEF	GetDisplay
	XDEF	FreeDisplay
	XDEF	CreatePort
	XDEF	DeletePort
	XDEF	CreateStdIO
	XDEF	CreateExtIO
	XDEF	DeleteStdIO
	XDEF	DeleteExtIO

	incdir	"include:"
	include	exec/types.i
	include	exec/nodes.i
	include	exec/lists.i
	include	exec/io.i
	include	exec/exec_lib.i
	include	exec/libraries.i
	include	exec/initializers.i
	include	exec/resident.i
	include	exec/memory.i
	include	exec/alerts.i
	include	graphics/graphics_lib.i
	include	graphics/view.i		; For GetDisplay.
	include	hardware/custom.i	; For BlitCopyMem.
	include	libraries/dos_lib.i
	include libraries/dos.i
	include	extgfx.i

***********  MACRO's  ************************

beginlnk macro
count	set	0
	endm
long	macro
count	set	count-4
\1	equ	count
	endm
word	macro
count	set	count-2
\1	equ	count
	endm
sizze	macro
\1	equ	count
	endm

CALLSYS	macro		same as CALLEX
	CALLLIB	_LVO\1
	endm

CLEAR	macro		quick method to clear a register
	MOVEQ #0,\1
	endm

CALLEX	macro
	move.l	a6,-(sp)
	move.l	4,a6
	jsr	_LVO\1(a6)
	move.l	(sp)+,a6
	endm

CALLGFX	macro
	move.l	a6,-(sp)
	move.l	_GfxBase,a6
	jsr	_LVO\1(a6)
	move.l	(sp)+,a6
	endm

CALLDOSF macro
	move.l	a6,-(sp)
	move.l	_DOSBase,a6
	jsr	_LVO\1(a6)
	move.l	(sp)+,a6
	endm

CALLINTF macro
	move.l	a6,-(sp)
	move.l	_IntuitionBase,a6
	jsr	_LVO\1(a6)
	move.l	(sp)+,a6
	endm

******* ExtGfx.s/AllocRasters ******************************************
*
*   NAME	
*	AllocRasters -- Allocate a number of bitplanes (rasters).
*   SYNOPSIS
*	succes = AllocRasters(BitMap)
*	d0		      A0
*	LONG AllocRaster(struct BitMap *)
*   FUNCTION
*	Allocate "depth" BitPlanes, using the size given in the
*	bitmap structure.
*   INPUTS
*	BitMap - A pointer to a bitmap structure containing the magic
*	    numbers.
*   RESULT
*	The plane-pointers will point to the allocated bitplanes. A
*	none zero value will be returned to indicate everything is OK.
*	If the allocation of one of the bitplanes failed, the
*	already allocated bitplanes will be deallocated, and the
*	return value will be zero.
*   EXAMPLE
*
*   NOTES
*	Use this routine only if you supply your own bitmap structure,
*	normaly EG_AllocBitMap performs this task for you.
*   BUGS
*	Only possible if the you request a depth of 8 bitplanes or more.
*   SEE ALSO
*	FreeRasters()
******************************************************************************
*
*

AlR_reg	reg	a2/a3/d2

AllocRasters
	movem.l	AlR_reg,-(sp)

	move.l	a0,a2		; Pointer to the head of the bitmap stucture.
	move.l	a0,a3		; Pointer to the bitplane pointers.

	adda.l	#bm_Planes,a3	; Get the number of bitplanes the user wants.
	moveq	#0,d2
	move.b	bm_Depth(a2),d2
	beq	.ll2		; User don't want bitplanes !

	subq.w  #1,d2
.ll1	moveq	#0,d0 		; Because of move.w
	moveq	#0,d1
	move.w  bm_BytesPerRow(a2),d0
	lsl.w	#3,d0 		; Calc. number of pixels.
	move.w  bm_Rows(a2),d1	; Height.
	CALLGFX AllocRaster	; Try to allocate a bitplane.
	move.l	d0,(a3)+
	beq	.geterr		; It failed.
	dbra	d2,.ll1		; Next bitplane.

.ll2	movem.l	(sp)+,AlR_reg
	moveq   #-1,d0 		; Every thing OK.
	rts

.geterr	move.l	a2,a0		; An error occured
	bsr	FreeRasters	; Give back the allocated bitplanes.
	movem.l	(sp)+,AlR_reg
	clr.l	d0		; ERROR!!
	rts

******* ExtGfx.s/FreeRasters ******************************************
*
*   NAME	
*	FreeRasters -- Deallocate all bitplanes of a BitMap.
*   SYNOPSIS
*	FreeRasters(BitMap)
*		    A0
*	void FreeRasters(struct BitMap *)
*   FUNCTION
*	Dealocate all bitplanes. Using the bitplane pointers given
*	in the bitmap structure.
*   INPUTS
*	BitMap - A pointer to a bitmap structure
*   RESULT
*	None
*   EXAMPLE
*
*   NOTES
*	You can AllocRaster(NULL).
*   BUGS
*
*   SEE ALSO
*	AllocRasters()
******************************************************************************
*
*

FrR_r reg	a2/d2/a3

FreeRasters
	move.l	a0,d0
	beq.s	.exit
	movem.l	FrR_r,-(sp)

	move.l	a0,a2
	move.l	a0,a3
	move.w  #7,d2		; Try to deallocate all the 8 bitbplanes.
	adda.l	#bm_Planes,a3
.ll1	movea.l	(a3)+,a0	; Raster Pointer
	cmp.l	#0,a0		; Is the bitplane home ?
	beq.s	.ll2		; No then don't deallocate it.
	moveq	#0,d0
	moveq	#0,d1
	move.w  bm_BytesPerRow(a2),d0
	lsl.w	#3,d0		; Calc. display width in pix.
	move.w  bm_Rows(a2),d1	; Display height.
	CALLGFX FreeRaster	; Deallocate bitplane.
.ll2	dbra	d2,.ll1

	movem.l	(sp)+,FrR_r
.exit	rts

******* ExtGfx.s/EG_AllocBitMap ******************************************
*
*   NAME	
*	EG_AllocBitMap -- Allocate memory for a bitmap structure,
*	initialize it, and allocate Rasters.
*   SYNOPSIS
*	BitMap,errorcode = EG_AllocBitMap(depth,width,height)
*	d0     d1		       d0   ,d1   ,d2
*	struct BitMap *EG_AllocBitMap(ULONG,ULONG,ULONG)
*   FUNCTION
*	This function will allocate a bitmap structure, initialize
*	it with the magic numbers and allocate the number of rasters
*	you requested for.
*   INPUTS
*	Depth - Depth of the BitMap [0..8]
*	Width - Width of the BitMap
*	Height - Height of the BitMap
*   RESULT
*	A pointer to an initialized BitMap structure
*	If there was an error, all the memory will be deallocated,
*	and the function will return a NULL pointer and an error code.
*
*	ErrorCode:
*	1 = No memory for a bitmap.
*	2 = No memory for the rasters.
*   EXAMPLE
*
*   NOTES
*
*   BUGS
*
*   SEE ALSO
*	EG_FreeBitMap()
******************************************************************************
*
*


EG_AllocBitMap
	move.l	d7,-(sp)

	movem.l	d0/d1,-(sp)
	move.l	#bm_SIZEOF,d0	; Alloc. mem. for bitmap.
	move.l	#MEMF_PUBLIC|MEMF_CLEAR,d1
	CALLEX	AllocMem
	tst.l	d0
	bne.s	.ll1
	movem.l	(sp)+,d0/d1
	moveq	#1,d7		; Error code 1 no mem.
	bra	.err1

.ll1	move.l	d0,a0		; Init. bitmap.
	movem.l	(sp)+,d0/d1
	move.l	a0,-(sp)
	CALLGFX InitBitMap

	move.l	(sp),a0		; Alloc. bitplanes.
	bsr	AllocRasters
	tst.l	d0		; No error?
	bne	.ll2
	moveq	#2,d7		; Errorcode 2 no bitplane mem. 
	bra	.err2

.ll2	move.l	(sp)+,d0	; Pointer to the bitmap.
	move.l	(sp)+,d7
	rts

.err2	move.l	(sp)+,a1	; Dealloc. bitmap.
	move.l	#bm_SIZEOF,d0
	CALLEX	FreeMem
.err1	moveq	#0,d0		; Something went wrong.
	move.l	d7,d1		; Error code in d2
	move.l	(sp)+,d7
	rts


******* ExtGfx.s/EG_FreeBitMap ******************************************
*
*   NAME	
*	EG_FreeBitMap --Deallocate all the memory use by the bitmap.
*   SYNOPSIS
*	EG_FreeBitMap(BitMap)
*		   A0
*	void EG_FreeBitMap(struct BitMap *)
*   FUNCTION
*	The function FreeRasters is used to deallocate the memory
*	used by the bitplanes. Then the memory allocated to store the
*	bitmap stucture is deallocted.
*   INPUTS
*	BitMap - A pointer to a BitMap structure
*   RESULT
*	None
*   EXAMPLE
*
*   NOTES
*	You can EG_FreeBitMap(NULL)
*   BUGS
*
*   SEE ALSO
*	FreeRasters(), EG_AllocBitMap()
******************************************************************************
*
*

EG_FreeBitMap
	move.l	a0,d0
	beq.s	.exit
	move.l	a0,-(sp)
	bsr	FreeRasters 
	move.l	(sp)+,a1 
	move.l	#bm_SIZEOF,d0
	CALLEX	FreeMem
.exit	rts


******* ExtGfx.s/GetPicture ******************************************
*
*   NAME	
*	GetPicture -- Load an IFF picture file from disk
*   SYNOPSIS
*	error = GetPicture(filename,BitMap,Colors)
*	D0		   A0	    A1     A2
*	ULONG GetPicture(STRPTR,struct BitMap *,UWORD *)
*   FUNCTION
*	The file is loaded into memory. If Colors <> NULL the
*	colors of the picture are placed in the array Colors is pointing
*	to. If the size of the picture is unequal to the size of the
*	bitmap the picture will be clipped.
*   INPUTS
*	filename - A null terminated string.
*	BitMap - A pointer to a BitMap structure.
*	Colors - A pointer to a Array of at least 32 Words, to store the
*	   Colors
*   RESULT
*	Error:
*	0 = OK
*	1 = File Not Found
*	2 = Out Of Memory
*	3 = Read Error (I/O error)  Use IOerr for more information.
*	4 = Not a IFF File
*	5 = Bad Unpack
*	6 = No BMHD
*	7 = No BODY
*	8 = No CMAP
*	9 = Bad CMAP ( To many colors )
*	10 = Compression method not supported.
*   EXAMPLE
*
*   NOTES
*	A bitmap with a depth of 0 can be used to extract the colors
*	of picture.
*   BUGS
*	The routine can only handle packed pictures. (using the
*	byte-run algorithm.), and plain (unpacked) pictures, all
*	other compression methods are not supported. Howerever at
*	this writing byte-run is the only compression method used.
*   SEE ALSO
*
******************************************************************************
*
*

	beginlnk
	long	GP_filename
	long	GP_filehd
	long	GP_mem1
	long	GP_mem2
	long	GP_mem3
	long	GP_sizemem2
	word	GP_depth	; Number of bitplanes needed.
	word	GP_width	; Width of the picture
	word	GP_height	; Height of the picture
	word	GP_compr	; type of compression
	long	GP_nr_packed	; Nuber of bytes that form the picture.
	long	GP_bitmap	; User supplied bitmap
	sizze	GP_sizeof

GP_regs	reg	d2-d7/a2-a6

GetPicture
	movem.l	GP_regs,-(sp)
	link	a5,#GP_sizeof
	move.l	a0,GP_filename(a5)
	move.l	a1,GP_bitmap(a5)
	moveq	#0,d0
	move.l	d0,GP_mem1(a5)	; So error knows what is allocated
	move.l	d0,GP_mem2(a5)	; and what's not.
	move.l	d0,GP_mem3(a5)
	move.l	d0,GP_filehd(a5)

	move.l	a0,d1		; Open the file.
	move.l	#MODE_OLDFILE,d2
	CALLDOSF Open
	move.l	d0,GP_filehd(a5)
	bne.s .ll1
	moveq	#1,d7
	bra	GP_error	; Open failed !
.ll1
	moveq	#8,d0 		; Allocate public mem.
	move.l	#1,d1		; 8 bytes
	CALLEX  AllocMem
	move.l	d0,GP_mem1(a5)
	bne.s	.ll2
	moveq	#2,d7
	bra	GP_error
.ll2
	move.l	GP_filehd(a5),d1	; Read the first 8
	move.l	GP_mem1(a5),d2		; bytes.
	moveq	#8,d3
	CALLDOSF Read
	bpl.s 	.ll3
	moveq	#3,d7
	bra	GP_error		; IOerr
.ll3
	move.l	GP_mem1(a5),a0		; Is it a FORM file.
	cmp.l	#"FORM",(a0)
	beq	.ll4
	moveq	#4,d7
	bra	GP_error		; No
.ll4
	move.l	4(a0),GP_sizemem2(a5)	; Size of the IFF file.

	move.l	4(a0),d0		; Alloceer public mem.
	move.l	#1,d1
	CALLEX  AllocMem
	move.l	d0,GP_mem2(a5)
	bne.s 	.ll5
	moveq 	#5,d7
	bra	GP_error
.ll5
	move.l	GP_sizemem2(a5),d3	; Load file.
	move.l	GP_filehd(a5),d1
	move.l	GP_mem2(a5),d2
	CALLDOSF Read
	cmp.l	#-1,d0
	bne.s 	.ll6
	moveq	#3,d7
	bra	GP_error
.ll6
	move.l	#8*4,d0			; Public mem for bitplane
	move.l	#1,d1			; pointers.
	CALLEX  AllocMem
	move.l	d0,GP_mem3(a5)
	bne	.ll7
	moveq	 #6,d7
	bra	GP_error

** Copy bitplane pointers

.ll7
	moveq	#7,d0
	move.l	GP_bitmap(a5),a0
	adda.l	#bm_Planes,a0
	move.l	GP_mem3(a5),a1
.ll8
	move.l	(a0)+,(a1)+
	dbra	d0,.ll8

	cmp.l	#0,a2			; Does the user wants colors ?
	beq	.geencol

** Find color header "CMAP"

	move.l	GP_mem2(a5),a0
	clr.l	d0
.col0	addq.l	#1,d0
	cmp.l	GP_sizemem2(a5),d0	; End of file ?
	bne.s	.col1
	moveq	#8,d7			; Yes error #8, no CMAP
	bra	GP_error
.col1
	cmp.b	#'C',(a0)+
	bne.s	.col0
	cmp.b	#'M',(a0)
	bne.s	.col0
	cmp.b	#'A',1(a0)
	bne.s	.col0
	cmp.b	#'P',2(a0)
	bne.s	.col0

	clr.l	d1
	clr.l	d2
	adda.l	#3,a0
	move.l	(a0)+,d0	; Number of entries
	cmp.l	#3*32,d0
	bls.s	.col2
	moveq	#9,d7		; Get colors error.
	bra	GP_error
.col2
	move.b	(a0)+,d1	; Assemble colors
	lsl.l	#4,d1		; and put them in an array.
	or.b	(a0)+,d1
	move.b	(a0)+,d2
	lsr.b	#4,d2
	or.b	d2,d1
	move.w	d1,(a2)+
	subq.w	#3,d0
	bpl.s	.col3
	moveq	#9,d7		; Get colors error.
	bra	GP_error
.col3	bne.s	.col2

.geencol

** format of the picture.
** find "BMHD"

	move.l	GP_mem2(a5),a0
	clr.l	d0
.bmh0	addq.l	#1,d0
	cmp.l	GP_sizemem2(a5),d0	; End of file ?
	bne.s	.bmh1
	moveq	#6,d7			; Yes error #6, no BMHD
	bra	GP_error
.bmh1
	cmp.b	#'B',(a0)+
	bne.s	.bmh0
	cmp.b	#'M',(a0)
	bne.s	.bmh0
	cmp.b	#'H',1(a0)
	bne.s	.bmh0
	cmp.b	#'D',2(a0)
	bne.s	.bmh0
	adda.l	#3+4,a0

	move.w	(a0)+,GP_width(a5)	; Found width.
	move.w	(a0)+,GP_height(a5)	; Found height
	addq.l	#4,a0 			; SKIP x and y position.
	move.b	(a0)+,GP_depth(a5)	; Found depth
	addq.l	#1,a0			; SKIP masking
	move.b	(a0)+,d0
	move.b	d0,GP_compr(A5)		; Type of compression
	cmp.b	#2,d0			; Compression type supported ?
	blt.s	.bmh2
	moveq	#10,d7
	bra	GP_error		; Compression type not supported
.bmh2
	

** Find body

	move.l	GP_mem2(a5),a0
	moveq	#0,d0
.bod0	addq.l	#1,d0
	cmp.l	GP_sizemem2(a5),d0	; End of file ?
	bne.s	.bod1
	moveq	#7,d7			; Yes error #7, no BODY
	bra	GP_error
.bod1	cmp.b	#'B',(a0)+
	bne.s	.bod0
	cmp.b	#'O',(a0)
	bne.s	.bod0
	cmp.b	#'D',1(a0)
	bne.s	.bod0
	cmp.b	#'Y',2(a0)
	bne.s	.bod0
	adda.l	#3,a0

	move.l	(a0)+,GP_nr_packed(a5) ; Number of bytes in body.


** Restore picture

.unp	moveq	#0,d3
	move.w	GP_width(a5),d3		; Width pic. in bytes.
	lsr.l	#3,d3
	move.l	GP_bitmap(a5),a1
	moveq	#0,d4
	move.w	bm_BytesPerRow(a1),d4	; Width BitMap in bytes.
	move.l	d4,d5
	sub.l	d3,d5			; modulo = W_BM - W_pic.

	move.l	GP_bitmap(a5),a1	; Number of lines.
	clr.l	d7
	move.w	bm_Rows(a1),d7
	cmp.w	GP_height(a5),d7	; H_pic. < H_bm ?
	bls	.unp0
	move.w	GP_height(a5),d7	; Yes use height pic.
.unp0	subq.w	#1,d7
	
.unp3	move.l	GP_mem3(a5),a2

	clr.w	d6
	move.b	GP_depth(a5),d6		; Number of bitplanes
	subq.w	#1,d6

.unp2	move.l	(a2)+,a1
	tst.b	GP_compr(a5)		; Compression used ?
	bne.s	.unp5			
	bsr	restoreline		; No just copy line
	bra.s	.unp4			; No error possible !
.unp5	bsr	unpackaline
	tst.l	d0			; Error while unpacking ?
	bne	.unp4
	moveq	#5,d7			; Yes error #5 bad unpack 
	bra	GP_error
.unp4	move.l	a1,-4(a2)

	dbra	d6,.unp2		; Next bitplane.
	
	dbra	d7,.unp3		; Next line.

GP_exit
	clr.l d7 			; No errors.
GP_error
	move.l	GP_filehd(a5),d1
	beq	.ll1
	CALLDOSF Close
.ll1
	move.l	GP_mem1(a5),d1
	beq	.ll2
	move.l	d1,a1
	moveq #8,d0
	CALLEX FreeMem
.ll2
	move.l	GP_mem2(a5),d1
	beq	.ll3
	move.l	d1,a1
	move.l	GP_sizemem2(a5),d0
	CALLEX FreeMem
.ll3
	move.l	GP_mem3(a5),d1
	beq	.ll4
	move.l	d1,a1
	move.l	#8*4,d0
	CALLEX FreeMem
.ll4
	move.l	d7,d0
	unlk	a5
	movem.l	(sp)+,GP_regs
	rts

restoreline	; (source,dest,widthpic/8,widthbm/8),a0,a1,d3,d4

	suba.l	a3,a3		; Make a NULL
	cmp.l	a3,a1		; Bitplane Home ?
	beq.s	.res1
	
	move.l	a0,a3
	move.l	a1,a4
	cmp.w	d4,d3
	bls.s	.res3		; pic <= bitmap
	move.w	d4,d0		; no width = width bitmap
	bra.s	.res4
.res3	move.w	d3,d0		; yes width = width pic

.res4	subq.w	#1,d0
.res2	move.b	(a3)+,(a4)+	; copy line pic to line bitmap
	dbra	d0,.res2
	add.l	d4,a1		; next line in bitmap

.res1	add.l	d3,a0		; next line in pic	
	moveq	#-1,d0		; all OK
	rts	

unpackaline	; (source,dest,widthpic/8,widthbm/8),a0,a1,d3,d4

*!!!!! Internal Routine !!!!

	suba.l	a3,a3		; Make a NULL
	clr.w	d0		; nr = 0
un1
	clr.w	d1
	move.b	(a0)+,d1
	cmp.b	#128,d1		; NOP
	beq	npover
	tst.b	d1
	bpl.s	plus

	move.b (a0)+,d2
	neg.b   d1

** Herhaal volgende byte (-n)+1 maal
un2	cmp.l	a3,a1		; Bitplane home ?
	beq.s	.ll1		; No, don't dump bytes.
	cmp.w	d4,d0
	bhs.s	.ll1		; bm line full, don't dump bytes

	move.b	d2,(a1)+	
.ll1	addq.w  #1,d0		; nr=nr+1
	cmp.w	d3,d0
	bhi.s	UpL_error	; UnPack error to many bytes in one line!
	dbf	d1,un2
	bra.s	npover

**  copieer (n)+1 bytes
plus	move.b	(a0)+,d2

	cmp.l	a3,a1		; Bitplane home ?
	beq.s	.ll1		; No, don't dump bytes.
	cmp.w	d4,d0
	bhs.s	.ll1		; bm line full, don't dump bytes

	move.b	d2,(a1)+ 
.ll1	addq.w  #1,d0		; nr=nr+1
	cmp.w	d3,d0
	bhi.s	UpL_error	; Unpack Error to many bytes in one line!
	dbf	d1,plus
npover
	cmp.w   d3,d0
	bne.s	un1

	cmp.l	a3,a1		; Bitplane Home ?
	beq.s	.ll1		; No, then we don't need a modulo.
	tst.l	d5		; Do we really need a modulo?
	bmi.s	.ll1
	adda.l	d5,a1		; Yes, wilst bitmap larger then piciture.

.ll1	moveq	#-1,d0		; No error.
	rts
UpL_error
	moveq	#0,d0		; Panic an error !!
	rts

******* ExtGfx.s/ClearBitMap ******************************************
*
*   NAME	
*	ClearBitMap -- Clear all bitplanes
*   SYNOPSIS
*	ClearBitMap(BitMap)
*		    A0
*	void ClearBitMap(struct BitMap *)
*   FUNCTION
*	Clear all bitplanes defined in the bitmap using the blitter.
*   INPUTS
*	BitMap - A pointer to a bitmap structure.
*   RESULT
*
*   EXAMPLE
*
*   NOTES
*
*   BUGS
*	Possible because of a bug in the blitter.
*   SEE ALSO
*
******************************************************************************
*
*

ClearBitMap
	movem.l	a2/a3,-(sp)

	move.l	a0,a3
	move.w	bm_BytesPerRow(a3),d0
	lsr.w	#1,d0			; Number of words
	move.w	bm_Rows(a3),d1
	lsl.w	#6,d1
	or.w	d0,d1			; Calc size of blit.

	clr.w	d0
	move.b	bm_Depth(a3),d0
	subq.w	#1,d0			; Number of blits.
	adda.l	#8,a3			; Pointer to bitplane pointers

	move.l	#$dff000,a2		; Custom Chip base addr.

	CALLGFX WaitBlit
	CALLGFX OwnBlitter
** Falid for every blit.
	move.w	#0,bltdmod(a2)		; Mod D = 0
	move.w	#$01f0,bltcon0(a2)	; Use D , D=A
	move.w	#$0000,bltcon1(a2)	; no shift etc
	move.w	#$ffff,bltafwm(a2)	; ?
	move.w	#$ffff,bltalwm(a2)	; ?
	move.w	#$0000,bltadat(a2)	; 0 -> DEST
.ll1
	move.l	(a3)+,bltdpt(a2)	; Clear bitplane.
	move.w	d1,bltsize(a2)		; Start  blitter
	CALLGFX WaitBlit		; Blitter finished ?
	dbra	d0,.ll1			; Next bitplane

	CALLGFX DisownBlitter
	CALLGFX WaitBlit		; ???
	movem.l	(sp)+,a2/a3
	rts


******* ExtGfx.s/GetDisplay ******************************************
*
*   NAME	
*	GetDisplay - Allocate and initialize a display structure.
*   SYNOPSIS
*	display, error code =
*	D0	 D1	
*	    GetDisplay(new_Display,BitMap1,BitMap2)
*		       A2          A0      [A1]
*	struct Display *GetDisplay(struct new_Display *,
*	    struct BitMap *,struct BitMap *)
*   FUNCTION
*	Allocate and initialize a Display Structure
*	- Allocate memory for a display structure.
*	- Allocate a colormap.
*	- Initialize a rasinfo.
*	- Initialize a Viewport.
*	- Initialize a View.
*	- Link the bitmap, rasinfo, viewport and view together.
*	if DUALPFIELD then
*		Allocate a second RastInfo.
*		Link second RasInfo to first RasInfo.
*		Initialize the second RasInfo.
*		Link second Bitmap to second RasInfo.
*
*	If an error occurs all memory allocated will be deallocated.
*
*   INPUTS
*	new_Display - A pointer to a new Display structure
*	    Defining: The width (in pixels) of the display. If the size
*	   	 is equal to -1, the width of the bitmap will be used.
*		The height (in pixels) of the display. If the height
*	    	is equal to -1, the height of the bitmap will be used.
*		The display mode (V_HAM, V_HIRES, V_DUALPLFLD, V_LACE).
*	BitMap1 - A pointer to a initialized bitmap structure.
*	BitMap2 - A pointer to a initialized BitMap structure. (Only
*	   needed if you request DUALPLAYFIELD).
*
*   RESULT
*	A pointer to a display structure which contains a pointer to
*	a view, a viewport and a rasinfo structure. All you need to
*	create a display now, is a call to makevport, mrgcopper and
*	loadview.
*
*	If there was an error:
*	A Nill pointer and a error code.
*	1 = No memory for the display structure.
*	2 = GetColorMap failed. 
*	3 = No memory for extra RasInfo structure.
*
*   EXAMPLE
*
*	...
*	move.l	my_bitmap,a0
*	sub.l	a1,a1			; only one bitmap
*	lea	new_display,a2
*	CALLEXT	GetDisplay
*	move.l	d0,display
*	beq 	error
*
*	move.l	display,a2
*	move.l	dsp_View(a2),a0		; Get the allocated view
*	move.l	dsp_ViewPort(a2),a1	; Get the allocated viewport
*	CALLGRAF MakeVPort
*	move.l	dsp_View(a2),a1
*	CALLGRAF MrgCop			; Mrg all copper list
*	move.l	dsp_View(a2),a1
*	CALLGRAF LoadView		; Show the display
*	...
*
* new_display
*	dc.w	-1			; USE THE SIZE GIVEN IN THE BITMAP
*	dc.w	-1,d1			; USE THE SIZE GIVEN IN THE BITMAP.
*	dc.w	V_HAM			; A HOLD AND MODIFY DISPLAY
*
*	The display structure can be found in the file extgfx.i
*   NOTES
*
*   BUGS
*
*   SEE ALSO
*	FreeDisplay()
******************************************************************************
*
*

	beginlnk
	long	gdp_BM1
	long	gdp_BM2
	long	gdp_ColorMap
	long	gdp_dsp
	word	gdp_Width
	word	gdp_Height
	word	gdp_Modes
	sizze	gdp_sizeof

GDP_regs	reg	a2/d7
GetDisplay
	movem.l	GDP_regs,-(sp)

	link	a5,#gdp_sizeof

	clr.l	gdp_ColorMap(a5)
	move.w	new_dsp_width(a2),gdp_Width(a5)
	move.w	new_dsp_height(a2),gdp_Height(a5)
	move.w	new_dsp_modes(a2),gdp_Modes(a5)
	move.l	a0,gdp_BM1(a5)
	move.l	a1,gdp_BM2(a5)

	lea	dsp_Template(pc),a0	; Allocate memory for a view, 
	CALLEX	AllocEntry		; a viewport and a rasinfo structure
	move.l	d0,gdp_dsp(a5)
	bpl.s	.ll1
	moveq.l	#1,d7
	beq	gdp_error

.ll1	moveq.l	#32,d0			; Make a colormap.
	CALLGFX	GetColorMap
	move.l	d0,gdp_ColorMap(a5)
	bne.s	.ll2
	moveq.l	#2,d7
	beq	gdp_error

.ll2	move.l	gdp_BM1(a5),a0		; Use bitmap format or use user
	tst.w	gdp_Width(a5)		; supplied format ?
	bpl.s	.ll3
	move.w	bm_BytesPerRow(a0),d0	; Use bytesperrow to calculate
	lsl.w	#3,d0			; the width of the display
	move.w	d0,gdp_Width(a5)

.ll3	tst.w	gdp_Height(a5)
	bpl.s	.ll4
	move.w	bm_Rows(a0),gdp_Height(a5)

.ll4	move.l	gdp_dsp(a5),a2
	move.l	dsp_ViewPort(a2),a0
	CALLGFX InitVPort
	move.l	dsp_ViewPort(a2),a1
	move.l	dsp_RasInfo(a2),vp_RasInfo(a1)		; Link RI - VP
	move.l	gdp_ColorMap(a5),vp_ColorMap(a1)	; Link CM - VP
	move.w	gdp_Width(a5),vp_DWidth(a1)		; Set Width
	move.w	gdp_Height(a5),vp_DHeight(a1)		; and height VP
	move.w	gdp_Modes(a5),vp_Modes(a1)		; Set DispMode

	move.l	dsp_View(a2),a1
	CALLGFX	InitView
	move.l	dsp_View(a2),a1
	move.l	dsp_ViewPort(a2),v_ViewPort(a1)		; LINK VP - V
	move.w	gdp_Modes(a5),v_Modes(a1)

	move.l	dsp_RasInfo(a2),a1			; LINK BM - RI
	move.l	gdp_BM1(a5),ri_BitMap(a1)

	andi.w	#V_DUALPF,gdp_Modes(a5)
	beq	.ll5
** Dualplay field , we need an extra Bitmap and RasInfo.
	move.l	#ri_SIZEOF,d0
	move.l	#MEMF_CLEAR!MEMF_PUBLIC,d1
	CALLEX	AllocMem
	move.l	gdp_dsp(a5),a1
	move.l	dsp_RasInfo(a1),a1
	move.l	d0,ri_Next(a1)		; Link RasInfo1 with RasInfo2 
	bne	.ll6
	moveq.l	#3,d7
	bra	gdp_error
.ll6	move.l	d0,a0
	move.l	gdp_BM2(a5),ri_BitMap(a0)	; Link Bitmap2 with RasInfo2

.ll5	move.l	gdp_dsp(a5),d0	; Return a pointer to the display struct. 
	unlk	a5
	movem.l	(sp)+,GDP_regs
	rts

gdp_error			; Deallocate the allocated.
	move.l	gdp_ColorMap(a5),d0
	beq	.ll1
	move.l	d0,a0
	CALLGFX	FreeColorMap
.ll1	move.l	gdp_dsp(a5),d0
	beq	.ll2
	move.l	d0,a0
	move.l	a0,-(sp)
	move.l	dsp_RasInfo(a0),a0	; Do we have an extra RasInfo?
	move.l	ri_Next(a0),d0
	beq	.ll1_1
	move.l	d0,a1
	move.l	#ri_SIZEOF,d0
	CALLEX	FreeMem
.ll1_1	move.l	(sp)+,a0
	CALLEX	FreeEntry
.ll2	clr.l	d0		; There was an error.
	move.l	d7,d1		; Error code.
	unlk	a5
	movem.l	(sp)+,GDP_regs
	rts

******* ExtGfx.s/FreeDisplay ******************************************
*
*   NAME	
*	FreeDisplay -- Dealocate the memory allocated by GetDisplay.
*   SYNOPSIS
*	FreeDisplay(Display)
*		    A0
*	void FreeDisplay(struct Display *)
*   FUNCTION
*	Deallocate the colormap.
*	Deallocate the memory for the display structure.
*	If there is an extra RasInfo then deallocate it.
*   INPUTS
*	Display - A pointer to a Display structure.
*   RESULT
*
*   EXAMPLE
*
*   NOTES
*	You can FreeDisplay(NULL) !
*   BUGS
*
*   SEE ALSO
*	GetDisplay()
******************************************************************************
*
*

FreeDisplay
	move.l	a0,d0
	beq.s	.exit
	move.l	a0,-(sp)
	move.l	dsp_RasInfo(a0),a0	; Do we have an extra RasInfo?
	move.l	ri_Next(a0),d0
	beq	.ll1
	move.l	d0,a1
	move.l	#ri_SIZEOF,d0
	CALLEX	FreeMem
.ll1	move.l	(sp),a0
	move.l	dsp_ViewPort(a0),a0
	move.l	vp_ColorMap(a0),a0
	CALLGFX	FreeColorMap
	move.l	(sp)+,a0
	CALLEX	FreeEntry
.exit	rts


******* ExtGfx.s/CreatePort ******************************************
*
*   NAME	
*	CreatePort -- Create a MessagePort.
*   SYNOPSIS
*	MsgPort=CreatePort(Name,Priority)
*	D0                 A0   D0
*	struct MsgPort *CreatePort(STRPTR *,INT)
*   FUNCTION
*	Allocates a SignalBit and memory for a MsgPort structure
*	and initializes the structure.
*   INPUTS
*	Name -  A null terminated string.
*	Priority - The priority for the port to be created.
*   RESULTS
*	A pointer to a to the Message Port.
*	A NULL pointer in case of an error.
*	If you supplied a name the port will be made public using the
*	funtion AddPort.
*   BUGS
*	?
*   SEE ALSO
*	DeletePort
******************************************************************************
*
*

CreatePort	; (Name,Priority),A0,D0 -> (MsgPort),D0

	move.l	a2,-(sp)

	movem.l	a0/d0,-(sp)		; Save name & pri

	move.l	#MP_SIZE,d0		; Alloc mem for msg-port.
	move.l	#MEMF_CLEAR!MEMF_PUBLIC,d1
	CALLEX	AllocMem
	move.l	d0,a2
	tst.l	d0
	beq	.err1			; Alloc mem failed

	moveq.l	#-1,d0			; Alloc signal for msg-port.
	CALLEX	AllocSignal
	move.b	d0,MP_SIGBIT(a2)	
	beq	.err2			; All signals in use.

	movem.l	(sp)+,a0/d0		; restore name & pri
	move.l	a0,LN_NAME(a2)		; link name to msgport
	move.b	d0,LN_PRI(a2)		; set pri for msgport
	move.b	#PA_SIGNAL,MP_FLAGS(a2)

	suba.l	a1,a1			; Find the Task that called
	CALLEX	FindTask		; this function.
	move.l	d0,MP_SIGTASK(a2)

	move.b	#NT_MSGPORT,LN_TYPE(a2)

	tst.l	LN_NAME(a2)		; test if the port has a name
	beq.s	.ll1	
	move.l	a2,a1
	CALLEX	AddPort			; if so make the port public
	move.l	a2,d0			; Point to the port in D0 (result)
	bra.s	.ll2
	
.ll1	move.l	a2,d0
	adda.l	#MP_MSGLIST,a2
	NEWLIST	a2

.ll2	move.l	(sp)+,a2
	rts
.err2
	move.l	a2,a1
	move.l	#MP_SIZE,d0
	CALLEX	FreeMem
.err1
	CLEAR	d0
	movem.l	(sp)+,a0/d0		remove name & pri from stack
	move.l	(sp)+,a2
	rts

******* ExtGfx.s/DeletePort ******************************************
*
*   NAME	
*	DeletePort -- Free the memory and signal allocted
*		      for a MessagePort.
*   SYNOPSIS
*	DeletePort(MsgPort)
*	             A0   
*	void DeletePort(struct MsgPort *)
*   FUNCTION
*	Free the memory allocated for the MsgPort Structure, and
*	free the SignalBit used by the message port. If the port has a 
*	name and therefore is public it will be removed using RemPort.
*   INPUTS
*	A pointer to a message port.
*   RESULTS
*	None.
*   BUGS
*	?
*   SEE ALSO
*	CreatePort
*
******************************************************************************
*
*

DeletePort	; (MSGPort),a0

	tst.l	LN_NAME(a0)		test if the port has a name
	beq.s	.ll1			and therefore is public 
	move.l	a0,-(sp)
	move.l	a0,a1
	CALLEX	RemPort			remove the port from public use
	move.l	(sp)+,a0
	
.ll1	CLEAR	d0
	move.b	MP_SIGBIT(a0),d0
	CALLEX	FreeSignal		free signal bit
	move.l	a0,a1
	move.l	#MP_SIZE,d0		free memory allocted for port
	CALLEX	FreeMem

	rts

******* ExtGfx.s/CreateStdIO ******************************************
*
*   NAME	
*	CreatePort -- Create a MessagePort.
*   SYNOPSIS
*	StdIO=CreateStdIO(MsgPort)
*	d0	  	  a0
*	struct IORequest *CreateStdIO(MsgPort *)
*   FUNCTION
*	Allocates memory for a IORequest structure and initializes the
*	structure.
*   INPUTS
*	MsgPort - A pointer to an already initialized message port to
*		  be used for this I/O request's reply port.
*   RESULTS
*	Returns a pointer to the new I/O Request block, or NULL if.
*	the request failed.
*   BUGS
*	?
*   SEE ALSO
*	CreateExtIO, DeleteStdIO
******************************************************************************
*
*

CreateStdIO	; (MsgPort),a0

	move.l	#IOSTD_SIZE,d0
	jsr	CreateExtIO
	rts


******* ExtGfx.s/CreateExtIO ******************************************
*
*   NAME
*	CreateExtIO -- Create an I/O request.
*   SYNOPSIS
*	ExtIO=CreateExtIO(MsgPort,Size)
*	d0		  a0      d0
*	struct IORequest *CreateExtIO(struct MsgPort *,INT)
*   FUNCTION
*	Allocates memory for and initializes a new I/O request block
*	of a user-specified number of bytes. The number of bytes MUST
*	be greater than the length of a Exec message, or some very nasty
*	things will happen.
*	structure.
*   INPUTS
*	MsgPort - A pointer to an already initialized message port to
*		  be used for this I/O request's reply port.
*	size	- the size of the I/O request to be created.
*   RESULTS
*	Returns a pointer to the new I/O Request block, or NULL if.
*	the request failed.
*   BUGS
*	?
*   SEE ALSO
*	DeleteExtIO
******************************************************************************
*
*

CreateExtIO	; (Size,MsgPort),d0,a0 -> (IOReq),d0

	move.w	d0,-(sp)
	move.l	a0,-(sp)

	move.l	#MEMF_CLEAR!MEMF_PUBLIC,d1
	CALLEX	AllocMem
	tst.l	d0
	beq	.err
	move.l	d0,a1

	move.b	#NT_MESSAGE,LN_TYPE(a1)
	move.l	(sp)+,MN_REPLYPORT(a1)
	move.w	(sp)+,MN_LENGTH(a1)

	rts
.err
	move.l	(sp)+,a0
	move.w	(sp)+,d1

	rts


******* ExtGfx.s/DeleteStdIO ******************************************
*
*   NAME
*	DeleteStdIO -- 
*                   return memory allocated for Standard IO Structure.
*   SYNOPSIS
*	DeleteStdIO(StdIO)
*		       a0
*	void DeleteStdIO(struct IORequest *)
*   FUNCTION
*	Free the memory allocted for IO request.
*   INPUTS
*	A pointer to a standard IO structure.
*   RESULTS
*	None.
*   BUGS
*	?
******************************************************************************
*
*

******* ExtGfx.s/DeleteExtIO ******************************************
*
*   NAME
*	DeleteExtIO --
*                   return memory allocated for extended IO Structure.
*   SYNOPSIS
*	DeleteExtIO(ExtIO)
*		     a0
*	void DeleteExtIO(struct IORequest *)
*   FUNCTION
*	Free the memory allocted for IO request.
*   INPUTS
*	A pointer to a extended IO structure.
*   RESULTS
*	None.
*   BUGS
*	?
******************************************************************************
*
*

DeleteStdIO

DeleteExtIO	; (IOReq),a0

	move.b	#-1,LN_TYPE(a0)
	move.l	#-1,IO_DEVICE(a0)
	move.l	#-1,IO_UNIT(a0)
	clr.l	d0
	move.w	MN_LENGTH(a0),d0
	move.l	a0,a1
	CALLEX	FreeMem

	rts


******** DATA STRUCTURES ***********

dsp_Template
	dcb.b	LN_SIZE
	dc.w	3
	dc.l	MEMF_PUBLIC!MEMF_CLEAR
	dc.l	v_SIZEOF
	dc.l	MEMF_PUBLIC!MEMF_CLEAR
	dc.l	vp_SIZEOF
	dc.l	MEMF_PUBLIC!MEMF_CLEAR
	dc.l	ri_SIZEOF

	end
