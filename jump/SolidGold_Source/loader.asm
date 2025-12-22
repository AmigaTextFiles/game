*
* Display the "Night OWL Design" logo and load/decrunch the main program.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

	include	"exec/io.i"
	include	"exec/memory.i"
	include	"exec/execbase.i"
	include	"devices/trackdisk.i"

	include	"loader.i"
	include	"custom.i"


; exec.library LVOs
Supervisor	equ	-30
AllocMem	equ	-198
AllocAbs	equ	-204
FreeMem		equ	-210
CloseLibrary	equ	-414
DoIO		equ	-456
OpenLibrary	equ	-552

; graphics.library LVOs
LoadView	equ	-222
WaitBlit	equ	-228
WaitTOF		equ	-270

; maximum program size
MAXPROGSIZE	equ	$60000



	code


;---------------------------------------------------------------------------
start:
; Started out of the boot block at a fixed address in Chip RAM.
; d0 = main program disk offset
; a5 = IOStdReq
; a6 = SysBase

	move.l	d0,-(sp)		; remember main program disk offset

	; display the Night OWL Design logo
	bsr	show_logo

	; allocate block buffer
	move.l	#TD_SECTOR,d0
	move.l	#MEMF_CHIP,d1
	jsr	AllocMem(a6)
	tst.l	d0
	beq	nomemerr
	move.l	d0,a2			; a2 buffer for a single block

	; First find out how much memory is needed for the program, by
	; reading the first block, which holds the bytekiller-header:
	; 0: crunched size
	; 4: decrunced size
	; 8: checksum

	move.l	(sp)+,d2		; d2 main program disk offset
	move.l	d2,d0
	bsr	read_block
	bne	readerr
	movem.l	(a2),d5-d7		; d5=crunched, d6=decrunched, d7=chk

	; Allocate a suitable memory block at the end of a memory region,
	; preferably not Chip RAM.

	move.l	MemList(a6),a0
	bra	.2
.1:	move.l	a0,a4			; a4 possible memory header
	btst	#MEMB_CHIP,MH_ATTRIBUTES+1(a0)
	beq	.3			; Fast/Slow RAM found, quit loop
	move.l	d0,a0
.2:	move.l	LN_SUCC(a0),d0		; next memory header
	bne	.1

	; Allocate from top of memory region.
	; Request eight extra bytes, so we can move the program code
	; to a 64-bit aligned address and remember the size of the
	; program in the first longword.
.3:	move.l	MH_UPPER(a4),a3
	sub.l	#MAXPROGSIZE,a3
.4:	move.l	a3,a1
	move.l	d6,d0
	addq.l	#8,d0
	jsr	AllocAbs(a6)
	tst.l	d0
	bne	.gotmem

	sub.w	#$1000,a3		; try it again at a 4K lower address
	cmp.l	MH_FIRST(a4),a3
	bhs	.4
	bra	nomemerr		; no suitable block found

.gotmem:
	; calculate pointer to end of program in allocated memory block
	move.l	d0,a4
	move.l	d6,(a4)+		; remember size
	add.l	d6,a4			; a4 end of decrunched area
	move.l	d0,d6
	addq.l	#4,d6			; d6 start of decrunched data

	; disk offset for the last word of the crunched file
	add.l	d2,d5
	addq.l	#8,d5			; d5 last word in file

	; get the last block of the crunched program into the buffer
	move.l	#-TD_SECTOR,d0
	and.l	d5,d0
	bsr	read_block
	bne	readerr

	bsr	decrunch
	bne	chksumerr

	; free the block buffer
	move.l	a2,a1
	move.l	#TD_SECTOR,d0
	jsr	FreeMem(a6)

	; Relocate the program. The offset table is located in front of
	; the code, where the first longword gives the number of entries.

	subq.l	#4,a4
	move.l	(a4)+,d1		; d1 size of allocated memory chunk
	subq.l	#8,d1
	move.l	(a4)+,d2		; d2 entries in reloc table
	move.l	a4,a0			; a0 reloc table
	move.l	d2,d0
	lsl.l	#2,d0
	add.l	d0,a4			; a4 start of code
	sub.l	d0,d1			; d1 size of code

	; Make sure code is aligned to 64 bits.
	; Alignment varies with the number of entries in the reloc table.
	move.l	a4,d4
	moveq	#7,d0
	and.l	d4,d0
	beq	.relocate

	; move the code 4 bytes away, making it 64-bit aligned again
	add.l	d1,a4
	move.l	a4,a1
	addq.l	#4,a4
.5:	move.b	-(a1),-(a4)
	subq.l	#1,d1
	bne	.5
	move.l	a4,d4

.relocate:
	move.l	(a0)+,d0
	add.l	d4,(a4,d0.l)
	subq.l	#1,d2
	bne	.relocate

	; Flush the caches to make the decrunched and relocated
	; code visible to the CPU.

	btst	#AFB_68020,AttnFlags+1(a6)
	beq	.6
	lea	flushCaches(pc),a5
	jsr	Supervisor(a6)

	; run the main program and pass a pointer to the boot logo color table
.6:	move.l	a5,a6
	lea	Colortable(pc),a0
	jmp	(a4)


;---------------------------------------------------------------------------
decrunch:
; a2 = block buffer
; a4 = pointer to end of decrunched area
; a5 = trackdisk IoStdReq
; a6 = SysBase
; d5 = offset of last word in crunched file
; d6 = pointer to start of decrunched area

	; init bytekiller decruncher, get first word
	move.l	#TD_SECTOR-1,d0
	and.l	d5,d0
	lea	(a2,d0.l),a0		; a0 ptr to current word to decrunch
	move.l	(a0),d0
	eor.l	d0,d7

bytekiller_decrunch:
	lsr.l	#1,d0
	bne	.1
	bsr	nextword
.1:	bcs	.cmd1xx
	moveq	#8-1,d4
	moveq	#1,d3
	lsr.l	#1,d0
	bne	.2
	bsr	nextword
.2:	bcs	.copy_n_from_d

	; cmd 00: nnn [dddd dddd]  -  copy n+1 times next d to *dest
	moveq	#3-1,d4
	bsr	getbits
	move.w	d2,d3

.copy_d_from_stream:
; copy n+1 times next 8-bit word from stream to *dest
; d3 = n
	moveq	#8-1,d4
.3:	lsr.l	#1,d0
	bne	.4
	bsr	nextword
.4:	roxl.l	#1,d2
	dbf	d4,.3
	move.b	d2,-(a4)
	dbf	d3,.copy_d_from_stream
	bra	check_done

.cmd111:
	; cmd 111: nnnn nnnn [dddd dddd]  -  copy n+9 times next d to *dest
	moveq	#8-1,d4
	bsr	getbits
	move.w	d2,d3
	addq.w	#8,d3			; n+8
	bra	.copy_d_from_stream

.cmd1xx:
	moveq	#2-1,d4
	bsr	getbits
	cmp.b	#2,d2
	blt	.cmd10x
	cmp.b	#3,d2
	beq	.cmd111

	; cmd 110: nnnn nnnn dddd dddd dddd
	; copy n+1 times *(dest+d) to *dest
	moveq	#8-1,d4
	bsr	getbits			; n
	move.w	d2,d3
	moveq	#12-1,d4		; 12 d-bits
	bra	.copy_n_from_d

.cmd10x:
	; cmd 100: dddd dddd d  -  copy 3 times *(dest+d) to *dest
	; cmd 101: dddd dddd dd -  copy 4 times *(dest+d) to *dest
	moveq	#9-1,d4
	add.w	d2,d4			; 9 or 10 d-bits
	addq.w	#2,d2
	move.w	d2,d3			; n = cmd&3 + 2

.copy_n_from_d:
	; copy n+1 times from *(dest+d) to *dest
	; d4 = bitcount for d -1
	; d3 = n
	bsr	getbits			; get d -> d2
	lea	(a4,d2.w),a1
.copyloop:
	move.b	-(a1),-(a4)
	dbf	d3,.copyloop

check_done:
	cmp.l	a4,d6
	blt	bytekiller_decrunch

	move.l	d7,d0			; return checksum
	rts

getbits:
; d4 = bits to get - 1
; -> d2 = result, extended to 16 bits

	clr.w	d2
.1:	lsr.l	#1,d0
	bne	.2
	bsr	nextword
.2:	roxl.l	#1,d2
	dbf	d4,.1
	rts


nextword:
; Get the next 32-bit word into the decrunching stream.
; Load the next block from disk when needed.
; a0 = pointer to current word in stream
; a2 = block buffer
; a5 = trackdisk IoStdReq
; a6 = SysBase
; d5 = offset of current word in stream
; d7 = checksum
; -> d7 = new checksum
; -> d0 = next word, X/C = next bit

	subq.l	#4,d5
	cmp.l	a2,a0
	bhi	.1

	; Start of buffer already reached. We have to fetch the next block.
	move.l	d5,d0
	and.l	#-TD_SECTOR,d0
	bsr	read_block
	bne	readerr
	lea	TD_SECTOR(a2),a0

.1:	move.l	-(a0),d0
	eor.l	d0,d7
	move.w	#$10,ccr
	roxr.l	#1,d0
	rts


;---------------------------------------------------------------------------
read_block:
; Read a block from disk into the provided buffer.
; a2 = block buffer
; a5 = trackdisk IoStdReq
; a6 = SysBase
; d0 = block offset
; -> d0/Z = ok/error

	move.l	a5,a1
	move.l	#TD_SECTOR,IO_LENGTH(a1)
	move.l	a2,IO_DATA(a1)
	move.l	d0,IO_OFFSET(a1)
	jsr	DoIO(a6)
	tst.b	d0
	rts


;---------------------------------------------------------------------------
show_logo:
; Disable system copper lists. Install new copper list to display
; the Night OWL Design logo.
; a6 = SysBase
; All registers, except a5/a6, are trashed!

	; open graphics.library (V33, Kickstart 1.2, is minimum)
	lea	GfxName(pc),a1
	moveq	#33,d0
	jsr	OpenLibrary(a6)
	tst.l	d0
	beq	oserr
	move.l	a6,-(sp)
	move.l	d0,a6

	; load a NULL view, disable system copper lists
	sub.l	a1,a1
	jsr	LoadView(a6)
	jsr	WaitTOF(a6)
	jsr	WaitTOF(a6)

	; disable Blitter-, Coppper-, Sprite-DMA
	lea	CUSTOM,a4
	move.w	#$01a0,DMACON(a4)
	move.w	#$0020,BEAMCON0(a4)	; force PAL, when possible (ECS)

	; disable AGA/ECS features, turn display off
	lea	BplconInit(pc),a0
	lea	BPLCON0(a4),a1
	moveq	#7-1,d0
.1:	move.w	(a0)+,(a1)+
	dbf	d0,.1

	; set OCS fetch-mode
	moveq	#0,d0
	move.w	d0,FMODE(a4)

	; load color table
	lea	Colortable(pc),a0
	lea	COLOR00(a4),a1
	moveq	#NCOLORS-1,d0
.2:	move.w	(a0)+,(a1)+
	dbf	d0,.2

	; disarm sprite channels
	moveq	#0,d0
	moveq	#15,d1
	lea	SPR0POS(a4),a0
.3:	move.l	d0,(a0)+
	dbf	d1,.3

	; write interleaved bitplane pointers to the copper list
	lea	Bitmap(pc),a0
	move.l	a0,d0
	lea	ClistPlanePtrs+2(pc),a1
	moveq	#PLANES-1,d1
	move.w	#BPR,a0

.4:	swap	d0
	move.w	d0,(a1)
	swap	d0
	move.w	d0,4(a1)
	add.l	a0,d0
	addq.l	#8,a1
	dbf	d1,.4

	; Work around the COPJMPx strobe bug, by making sure the blitter
	; is idle.
	jsr	WaitBlit(a6)

	; load the new copper list to display the logo
	lea	Copperlist(pc),a0
	move.l	a0,COP1LC(a4)
	tst.w	COPJMP1(a4)

	; enable bitplane/copper-DMA, sprite-DMA remains disabled
	move.w	#$8380,DMACON(a4)

	move.l	(sp)+,a6		; restore SysBase
	rts

BplconInit:	; Init. for BPLCON0..4, BPL1/2MOD
	dc.w	$0000,$0000,$0024,$0c00,(PLANES-1)*BPR,(PLANES-1)*BPR,$0011

GfxName:
	dc.b	"graphics.library",0
	even


;---------------------------------------------------------------------------
oserr:
	move.w	#$0ff,d0		; bad OS version (earlier than 1.2)
	bra	err
chksumerr:
	move.w	#$00f,d0		; checksum error after decrunching
	bra	err
nomemerr:
	move.w	#$f00,d0		; cannot find suitable memory
	bra	err
readerr:
	move.w	#$cc0,d0		; trackdisk read error
err:	move.w	d0,CUSTOM+COLOR00
	bra	err


;---------------------------------------------------------------------------
flushCaches:
; This code is run on 68020+ CPUs only and flushes all caches.

	mc68020
	movec	cacr,d0
	tst.w	d0
	bmi	.1			; 68040/68060 I-Cache enabled?

	; clear 68020/68030 caches
	or.w	#$808,d0
	movec	d0,cacr
	rte

	mc68040
	; clear 68040/68060 caches
.1:	nop
	cpusha	bc
	rte


;---------------------------------------------------------------------------
Copperlist:
	dc.w	BPLCON0,PLANES<<12|$200
	dc.w	DDFSTRT,DFETCHSTART
	dc.w	DDFSTOP,DFETCHSTOP
	dc.w	DIWSTRT,(VSTART&$ff)<<8|(HSTART&$ff)
	dc.w	DIWSTOP,(VEND&$ff)<<8|((HSTART+DISPW)&$ff)
ClistPlanePtrs:
	dc.w	BPL1PTH,0,BPL1PTL,0
	dc.w	BPL2PTH,0,BPL2PTL,0
	dc.w	BPL3PTH,0,BPL3PTL,0
	dc.w	BPL4PTH,0,BPL4PTL,0
	dc.w	$ffff,$fffe

Colortable:
	incbin	"gfx/NightOWLDesign.cmap"

Bitmap:
	incbin	"gfx/NightOWLDesign.bin"
