*
* Memory management.
* Gets all the needed Chip RAM from the OS at start, so game functions
* can request it when needed.
* When KILLOS is defined, we use $400 - $80000 and do not care about
* overwriting OS structures.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* d0=err = initmem()
* exitmem()
* d0=ptr = alloc_chipmem(d0=nbytes)
* d0=ptr = save_chipmem()
* restore_chipmem(a0=ptr)
* free_topchipmem()
*
* AllocFromTop
*

	include	"exec/memory.i"


; Memory debug flag. Writes all allocations to the specified address.
MEMDEBUG	equ	$7f000

; AmigaOS constants
EXECBASE	equ	4

; exec LVOs
Forbid		equ	-132
Permit		equ	-138
AllocMem	equ	-198
FreeMem		equ	-210
AvailMem	equ	-216

CHIPLOWER	equ	$400
	ifd	MEMDEBUG
CHIPUPPER	equ	MEMDEBUG
	else
CHIPUPPER	equ	$80000
	endif


; from main.asm
	xref	panic



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initmem
initmem:
; Find the largest Chip RAM block and allocate it for our memory management.
; The OS must still be alive, when calling this function!

	ifd	KILLOS
	lea	CHIPLOWER.w,a0
	move.l	a0,ChipBase(a4)
	move.l	#CHIPUPPER-CHIPLOWER,ChipSize(a4)
	move.l	a0,ChipPtr(a4)
	move.l	#CHIPUPPER,ChipTopPtr(a4)

	ifd	MEMDEBUG
	lea	MEMDEBUG,a1
	move.l	a0,(a1)+
	move.l	#CHIPUPPER-CHIPLOWER,(a1)+
	move.l	a1,MemDebug(a4)
	endif	; MEMDEBUG

	rts

	else	; KILLOS

	move.l	a6,-(sp)
	move.l	(EXECBASE).w,a6

	jsr	Forbid(a6)

	move.l	#MEMF_CHIP|MEMF_LARGEST,d1
	jsr	AvailMem(a6)
	move.l	d0,ChipSize(a4)

	move.l	#MEMF_CHIP,d1
	jsr	AllocMem(a6)
	move.l	d0,ChipBase(a4)
	move.l	d0,ChipPtr(a4)
	move.l	ChipSize(a4),d1
	move.l	d0,a0
	add.l	d1,a0
	move.l	a0,ChipTopPtr(a4)

	ifd	MEMDEBUG
	lea	MEMDEBUG,a0
	move.l	d0,(a0)+
	add.l	d1,d0
	cmp.l	#MEMDEBUG,d0
	bls	.1
	sub.l	#MEMDEBUG,d0
	sub.l	d0,ChipSize(a4)
	sub.l	d0,d1
.1:	move.l	d1,(a0)+
	move.l	a0,MemDebug(a4)
	endif	; MEMDEBUG

	jsr	Permit(a6)

	move.l	(sp)+,a6
	rts
	endif	; KILLOS


;---------------------------------------------------------------------------
	xdef	exitmem
exitmem:
; Give all Chip RAM back to the OS.

	ifnd	KILLOS
	move.l	a6,-(sp)
	move.l	(EXECBASE).w,a6

	move.l	ChipBase(a4),a1
	move.l	ChipSize(a4),d0
	jsr	FreeMem(a6)

	move.l	(sp)+,a6
	endif
	rts


;---------------------------------------------------------------------------
	xdef	alloc_chipmem
alloc_chipmem:
; Allocate another chunk of Chip RAM. Always aligns to an even address.
; d0 = number of bytes
; -> d0 = pointer to allocated memory block

	addq.l	#1,d0
	moveq	#-2,d1
	and.l	d0,d1

	tst.b	AllocFromTop(a4)
	bne	alloc_topchipmem

	ifd	MEMDEBUG
	move.l	MemDebug(a4),a1
	move.l	d1,(a1)+
	endif

	move.l	ChipPtr(a4),d0
	add.l	d0,d1

	ifd	MEMDEBUG
	move.l	d1,(a1)+
	move.l	a1,MemDebug(a4)
	endif

	cmp.l	ChipTopPtr(a4),d1
	bhi	.outofmemory

	move.l	d1,ChipPtr(a4)
	rts

.outofmemory:
	move.w	#$00f,d0
	bra	panic		; blue means out of chip memory


;---------------------------------------------------------------------------
alloc_topchipmem:
; Allocate a chunk of memory from the top of Chip RAM.
; d1 = number of bytes (even)
; -> d0 = pointer to allocated memory block

	ifd	MEMDEBUG
	move.l	d1,d0
	neg.l	d0
	move.l	MemDebug(a4),a1
	move.l	d0,(a1)+
	endif

	move.l	ChipTopPtr(a4),d0
	sub.l	d1,d0

	ifd	MEMDEBUG
	move.l	d0,(a1)+
	move.l	a1,MemDebug(a4)
	endif

	cmp.l	ChipPtr(a4),d0
	blo	.outofmemory

	move.l	d0,ChipTopPtr(a4)
	rts

.outofmemory:
	move.w	#$80f,d0
	bra	panic		; violet-blue means out of chip mem from top


;---------------------------------------------------------------------------
	xdef	save_chipmem
save_chipmem:
; Remember the current Chip RAM allocation. It can be restored using
; restore_chipmem(), to free all memory we allocated since then.

	move.l	ChipPtr(a4),d0
	rts


;---------------------------------------------------------------------------
	xdef	restore_chipmem
restore_chipmem:
; Free all memory allocated since save_chipmem().
; a0 = pointer from save_chipmem()

	move.l	a0,d0
	beq	.1
	move.l	d0,ChipPtr(a4)

	ifd	MEMDEBUG
	move.l	MemDebug(a4),a0
	clr.l	(a0)+
	move.l	d0,(a0)+
	move.l	a0,MemDebug(a4)
	endif

.1:	rts


;---------------------------------------------------------------------------
	xdef	free_topchipmem
free_topchipmem:
; Restore all Chip RAM allocated from the top.

	move.l	ChipBase(a4),d0
	add.l	ChipSize(a4),d0
	move.l	d0,ChipTopPtr(a4)

	ifd	MEMDEBUG
	move.l	MemDebug(a4),a0
	moveq	#-1,d1
	move.l	d1,(a0)+
	move.l	d0,(a0)+
	move.l	a0,MemDebug(a4)
	endif

	rts



	section	__MERGED,bss


	; base address and size of all available Chip RAM
ChipBase:
	ds.l	1
ChipSize:
	ds.l	1

	; pointer to the next free Chip memory block
ChipPtr:
	ds.l	1
ChipTopPtr:
	ds.l	1

	ifd	MEMDEBUG
MemDebug:
	ds.l	1
	endif

	; flag is set when new memory should be allocated from top of Chip RAM
	xdef	AllocFromTop
AllocFromTop:
	ds.b	1
	even
