*
* Simple monitor for debugging CPU exceptions.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initdebug(d0=cputype.b)
* exitdebug()
* debug()
*

	ifd	DEBUG

	include	"custom.i"
	include	"cia.i"

	macro	BANNER
	dc.b	"Solid Gold internal debugger V1.0"
	endm

NUM_VECTORS	equ	62

DB_DISPW	equ	640
DB_DISPH	equ	200
DB_BPR		equ	DB_DISPW/8
DB_PLANESIZE	equ	DB_BPR*DB_DISPH

BITMAPADDR	equ	$7a000
CLISTADDR	equ	BITMAPADDR+DB_PLANESIZE

FONTWIDTH	equ	8
FONTHEIGHT	equ	8
COLS		equ	DB_DISPW/FONTWIDTH
ROWS		equ	DB_DISPH/FONTHEIGHT

LINEBUFSIZE	equ	78

KBDHANDSHAKE	equ	65		; 02 clocks

; from linker
	xref	_LinkerDB

; from startup.asm
	xref	startup

; from end.asm
	xref	BSSEnd

; from os.asm
	xref	AutoVecBase

; from display.asm
	xref	CurrentClist



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initdebug
initdebug:
; Save all exception vectors and install ours.
; d0.b = CPU type, 0 means 68000 CPU

	tst.b	d0
	seq	MC68000(a4)

	; save all CPU exception vectors
	move.l	AutoVecBase(a4),a0
	addq.l	#8,a0			; Bus Error vector
	lea	Oldvecs(a4),a1
	bsr	copyvecs

	; Set new vectors and redirect all exceptions to our handler.
	lea	exceptionTable(pc),a0
	move.l	AutoVecBase(a4),a1
	addq.l	#8,a1
	moveq	#NUM_VECTORS-1,d0
.1:	move.l	a0,(a1)+
	addq.l	#2,a0
	dbf	d0,.1

	rts


;---------------------------------------------------------------------------
	xdef	exitdebug
exitdebug:
; Restore all exception vectors.

	; restore all CPU exception vectors
	lea	Oldvecs(a4),a0
	move.l	AutoVecBase(a4),a1
	addq.l	#8,a1			; Bus Error vector


;---------------------------------------------------------------------------
copyvecs:
; copy NUM_VECTORS pointers
; a0 = source
; a1 = destination

	moveq	#NUM_VECTORS-1,d0
.1:	move.l	(a0)+,(a1)+
	dbf	d0,.1
	rts


;---------------------------------------------------------------------------
	xdef	debug
debug:
; Direct entry into the debugger is shown as exception vector #0.
	bsr.w	exception_handler
	nop


;---------------------------------------------------------------------------
exceptionTable:
	rept	NUM_VECTORS
	bsr.b	exception_handler
	endr
	nop


;---------------------------------------------------------------------------
exception_handler:
; This exception handler is called by a BSR.B from exceptionTable,
; which means that we can determine the original exception vector by
; looking at the return address.

	; save all registers
	movem.l	d0-d7/a0-a6,Registers

	; init small data base and CUSTOM base
	lea	_LinkerDB,a4
	lea	CUSTOM,a6

	; save DMACON, INTENA, INTREQ state on debugger entry
	move.w	DMACONR(a6),Saved_dmacon(a4)
	move.w	INTENAR(a6),Saved_intena(a4)
	move.w	INTREQR(a6),Saved_intreq(a4)

	; init display and print banner
	bsr	init_display
	lea	BannerTxt(pc),a0
	bsr	print

	; determine exception vector, which had been called, and print it
	lea	ExceptTxt(pc),a0
	bsr	print
	move.l	(sp)+,d7
	move.l	sp,a2			; a2 remember real SSP
	lea	exceptionTable-2(pc),a0
	sub.l	a0,d7
	lsr.w	#1,d7			; d7 Exception vector number
	move.w	d7,d0
	bsr	hexout

	; vector 2 or 3 (bus/address error) on an 68000 need special handling
	move.l	a2,a3			; a3 Exception frame
	cmp.w	#4,d7
	bhs	.1
	tst.b	MC68000(a4)
	beq	.1

	; 68000 saves 4 extra words before the status and PC, skip them
	addq.l	#8,a3

	; print fault PC
.1:	lea	AtPCTxt(pc),a0
	bsr	print
	move.l	2(a3),d0
	bsr	hex4out
	move.l	2(a3),d0
	bsr	showoffset

	; print SR
	lea	SRTxt(pc),a0
	bsr	print
	move.w	(a3),d0
	move.l	a2,a0
	btst	#13,d0			; save USP or SSP as A7
	bne	.2
	move	usp,a0
.2:	move.l	a0,Registers+15*4(a4)
	bsr	hex2out

	; print USP
	lea	USPTxt(pc),a0
	bsr	print
	move	usp,a0
	move.l	a0,d0
	bsr	hex4out

	; print SSP
	lea	SSPTxt(pc),a0
	bsr	print
	move.l	a2,d0
	bsr	hex4out

	bsr	newline

	; print d0-d7 and a0-a7
	bsr	printregs

	; print supervisor stack
	lea	SSTxt(pc),a0
	bsr	printstack

	; print user stack
	lea	USTxt(pc),a0
	move	usp,a2
	bsr	printstack

	; print custom chip registers
	lea	DMACONTxt(pc),a0
	bsr	print
	move.w	Saved_dmacon(a4),d0
	bsr	hex2out
	lea	INTENATxt(pc),a0
	bsr	print
	move.w	Saved_intena(a4),d0
	bsr	hex2out
	lea	INTREQTxt(pc),a0
	bsr	print
	move.w	Saved_intreq(a4),d0
	bsr	hex2out
	lea	COP1LCTxt(pc),a0
	bsr	print
	move.l	CurrentClist(a4),d0
	bsr	hex4out

	bsr	newline

	clr.b	Qualifiers(a4)

cmd_loop:
	lea	PromptTxt(pc),a0
	bsr	print
	bsr	getline

	; check for command code
	moveq	#-$21,d0
	and.b	(a0)+,d0
.1:	cmp.b	#' ',(a0)+		; skip following blanks
	beq	.1
	subq.l	#1,a0

	sub.b	#'M',d0			; m <addr> [lines] : memory dump
	beq	memdump

	subq.b	#3,d0			; p <addr> : print offset
	beq	printoffset

	subq.b	#1,d0			; q : quit (reboot)
	beq	quit

	subq.b	#1,d0			; r : register dump
	beq	regdump

	subq.b	#6,d0			; x : exit (reboot)
	beq	quit

	bra	cmd_loop


printstack:
; Print top 12 words from the stack.
; a0 = header text
; a2 = pointer to stack

	bsr	print
	moveq	#11,d2
.1:	lea	SpcTxt(pc),a0
	bsr	print
	move.w	(a2)+,d0
	bsr	hex2out
	dbf	d2,.1
	bra	newline


	cnop	0,4
quit:
; Quit the debugger. Reboot the machine.
	lea	2.l,a0			; do not optimize to 2.w!
	reset
	jmp	(a0)


;---------------------------------------------------------------------------
memdump:
; Do a memory dump from given address.
; a0 = pointer to ASCII hex address

	; dump 8 lines by default
	moveq	#7,d2

	; read start address argument
	bsr	readhex
	move.l	d0,a2
	cmp.b	#' ',(a0)+
	bne	.lineloop

	; read optional number of lines argument
	bsr	readhex
	tst.l	d0
	beq	.lineloop
	cmp.w	#16,d0
	bhi	.lineloop
	move.w	d0,d2
	subq.w	#1,d2

.lineloop:
	; print address
	move.l	a2,d0
	bsr	hex4out
	lea	ColonTxt(pc),a0
	bsr	print

	; print 16 bytes
	moveq	#15,d3
	lea	Buffer(a4),a3
	move.b	#$22,(a3)+
.byteloop:
	move.b	(a2)+,d0
	move.b	d0,d1
	cmp.b	#$20,d1
	blo	.1
	cmp.b	#$80,d1
	blo	.2
.1:	moveq	#'.',d1
.2:	move.b	d1,(a3)+
	bsr	hexout
	cmp.w	#8,d3
	bne	.3
	lea	DashTxt(pc),a0
	bra	.4
.3:	lea	SpcTxt(pc),a0
.4:	bsr	print
	dbf	d3,.byteloop

	; print the 16 characters (when printable)
	move.b	#$22,(a3)+
	move.b	#10,(a3)+
	clr.b	(a3)
	lea	Buffer(a4),a0
	bsr	print
	dbf	d2,.lineloop

	bra	cmd_loop

ColonTxt:
	dc.b	": ",0
DashTxt:
	dc.b	"-",0
	even


;---------------------------------------------------------------------------
printoffset:
; Print offset to program base, for given address.
; a0 = pointer to ASCII hex address

	bsr	readhex
	bsr	showoffset
	bsr	newline
	bra	cmd_loop


;---------------------------------------------------------------------------
regdump:
; Print d0-d7, a0-a7.

	bsr	printregs
	bra	cmd_loop


;---------------------------------------------------------------------------
printregs:
; Print all registers.

	movem.l	d2/a2-a3,-(sp)

	lea	Registers(a4),a2
	lea	RegTxt(a4),a3
	moveq	#7,d2
	move.w	#'d0',(a3)

.1:	move.b	#'d',(a3)
	move.l	a3,a0
	bsr	print
	move.l	(a2),d0
	bsr	hex4out
	move.l	(a2),d0
	bsr	showoffset

	move.b	#'a',(a3)
	move.l	a3,a0
	bsr	print
	move.l	8*4(a2),d0
	bsr	hex4out
	move.l	8*4(a2),d0
	bsr	showoffset
	bsr	newline

	addq.w	#1,(a3)
	addq.l	#4,a2
	dbf	d2,.1

	movem.l	(sp)+,d2/a2-a3
	rts


BannerTxt:
	BANNER
	dc.b	10
LFTxt:
	dc.b	10,0
ExceptTxt:
	dc.b	"CPU Exception #",0
AtPCTxt:
	dc.b	" at"
SpcTxt:
	dc.b	" ",0
SRTxt:
	dc.b	"SR=",0
USPTxt:
	dc.b	" USP=",0
SSPTxt:
	dc.b	" SSP=",0
SSTxt:
	dc.b	"SS:",0
USTxt:
	dc.b	"US:",0
DMACONTxt:
	dc.b	"DMACON=",0
INTENATxt:
	dc.b	" INTENA=",0
INTREQTxt:
	dc.b	" INTREQ=",0
COP1LCTxt:
	dc.b	" COP1LC=",0
PromptTxt:
	dc.b	"> ",0
	even


;---------------------------------------------------------------------------
readhex:
; Convert a hex string into its value.
; a0 = hex string pointer
; -> a0 = new string pointer
; -> d0 = value

	moveq	#0,d0
.1:	moveq	#-$21,d1
	and.b	(a0)+,d1
	sub.b	#'0'-$20,d1
	blo	.3
	cmp.b	#9,d1
	bls	.2
	cmp.b	#'A'-('0'-$20),d1
	blo	.3
	cmp.b	#'F'-('0'-$20),d1
	bhi	.3
	sub.b	#'A'-('0'-$20)-10,d1
.2:	lsl.l	#4,d0
	or.b	d1,d0
	bra	.1
.3:	subq.l	#1,a0
	rts


;---------------------------------------------------------------------------
init_display:
; Set up a hires display window with a single bit plane.
; -> a5 = bitmap base
; No registers saved!

	; disable DMA and interrupts
	move.w	#$7fff,d0
	move.w	d0,INTENA(a6)
	move.w	d0,DMACON(a6)

	; disarm sprite channels
	moveq	#0,d0
	moveq	#15,d1
	lea	SPR0POS(a6),a0
.1:	move.l	d0,(a0)+
	dbf	d1,.1

	; clear the bitmap
	lea	BITMAPADDR,a5		; a5 bitmap base
	bsr	clear_screen

	; copy the copper list into Chip RAM
	lea	CLISTADDR,a2		; a2 copper list
	lea	DebugCList(pc),a0
	move.l	a2,a1
	moveq	#(DebugCListEnd-DebugCList)>>2-1,d0
.2:	move.l	(a0)+,(a1)+
	dbf	d0,.2

	; start the copper list
	move.l	a2,COP1LC(a6)
	tst.w	COPJMP1(a6)

	; enable bitplane and copper DMA
	move.w	#$8380,DMACON(a6)
	rts


DebugCList:
	dc.w	BPLCON0,$9200		; Hires, 1 bit plane
	dc.w	BPLCON1,0		; no scrolling
	dc.w	DDFSTRT,$003c
	dc.w	DDFSTOP,$00d4
	dc.w	DIWSTRT,$2c81		; 640x200 display window
	dc.w	DIWSTOP,$f4c1
	dc.w	BPL1MOD,0
	dc.w	BPL2MOD,0
	dc.w	COLOR00,$888		; background grey
	dc.w	COLOR01,$dda		; foreground light-yellow
	dc.w	BPL1PTH,BITMAPADDR>>16
	dc.w	BPL1PTL,BITMAPADDR&$ffff
	dc.w	$ffff,$fffe
DebugCListEnd:


;---------------------------------------------------------------------------
clear_screen:
; Clear the bitmap and place the cursor in the top left edge.
; a5 = bitmap base
; -> d6 = 0
; -> d7 = 0

	move.l	a5,a0
	move.w	#DB_PLANESIZE>>2-1,d0
.1:	clr.l	(a0)+
	dbf	d0,.1

	moveq	#0,d6
	moveq	#0,d7
	movem.w	d6-d7,Cxpos(a4)

;---------------------------------------------------------------------------
draw_cursor:
; Draw the cursor by inverting the 8x8-pixel area at Cxpos/Cypos.
; d6 = cursor-row
; d7 = cursor-column

	move.w	#DB_BPR*FONTHEIGHT,d0
	mulu	d7,d0
	add.w	d6,d0
	lea	(a5,d0.w),a0		; cursor location on bitmap

	moveq	#7,d0
.1:	eor.b	#$ff,(a0)
	add.w	#DB_BPR,a0
	dbf	d0,.1

	rts


;---------------------------------------------------------------------------
showoffset:
; Print offset to program start, when address is between startup and BSSEnd.
; d0 = address
; a5 = bitmap base

	move.l	d2,-(sp)
	lea	startup,a0
	move.l	d0,d2
	cmp.l	a0,d2
	blo	.1
	cmp.l	#BSSEnd,d2
	bhs	.1

	; this is a programm address, print 24-bit offset
	sub.l	a0,d2
	lea	.lpar(pc),a0
	bsr	print
	swap	d2
	move.b	d2,d0
	bsr	hexout
	rol.l	#8,d2
	move.l	d2,d0
	bsr	hexout
	rol.l	#8,d2
	move.b	d2,d0
	bsr	hexout
	lea	.rpar(pc),a0
	bsr	print
	bra	.2

	; no programm address, print empty parentheses
.1:	lea	.empty(pc),a0
	bsr	print

.2:	move.l	(sp)+,d2
	rts

.lpar:	dc.b	" (*+",0
.empty:	dc.b	" (   --   "
.rpar:	dc.b	")  ",0
	even


;---------------------------------------------------------------------------
hex4out:
; Print a hex-longword.
; d0 = longword
; a5 = bitmap base

	move.l	d2,-(sp)
	rol.l	#8,d0
	move.l	d0,d2
	bsr	hexout
	rol.l	#8,d2
	move.b	d2,d0
	bsr	hexout
	rol.l	#8,d2
	move.b	d2,d0
	bsr	hexout
	rol.l	#8,d2
	move.b	d2,d0
	bsr	hexout
	move.l	(sp)+,d2
	rts


;---------------------------------------------------------------------------
hex2out:
; Print a hex-word.
; d0 = word
; a5 = bitmap base

	move.l	d2,-(sp)
	move.b	d0,d2
	lsr.w	#8,d0
	bsr	hexout
	move.b	d2,d0
	bsr	hexout
	move.l	(sp)+,d2
	rts


;---------------------------------------------------------------------------
hexout:
; Print a hex-byte.
; d0 = byte
; a5 = bitmap base

	move.l	#$30300000,-(sp)	; "00\0\0"
	moveq	#15,d1
	and.b	d0,d1
	cmp.b	#10,d1
	blo	.1
	add.b	#'A'-'0'-10,d1
.1:	lsl.w	#4,d0
	and.w	#$0f00,d0
	cmp.w	#$0a00,d0
	blo	.2
	add.w	#('A'-'0'-10)<<8,d0
.2:	move.b	d1,d0
	add.w	d0,(sp)
	move.l	sp,a0
	bsr	print
	addq.l	#4,sp
	rts


;---------------------------------------------------------------------------
newline:
; Move cursor to the beginning of the next line.
; a5 = bitmap base

	lea	LFTxt(pc),a0


;---------------------------------------------------------------------------
print:
; Write a string into the bitmap. Scroll when the last row is reached.
; a0 = null-terminated string, '\n' starts a new line
; a5 = bitmap base

	movem.l	d6-d7/a2-a3,-(sp)
	move.l	a0,a2			; a2 string pointer

	; d6 = cursor-column, d7 = cursor-row
	movem.w	Cxpos(a4),d6-d7
	bsr	draw_cursor		; undraw cursor

.locate:
	; a3 = pointer to cursor location on the bitmap
	move.w	#DB_BPR*FONTHEIGHT,d0
	mulu	d7,d0
	add.w	d6,d0
	lea	(a5,d0.w),a3
	bra	.nextchar

.loop:
	cmp.b	#10,d0			; Newline?
	beq	.newline

	cmp.w	#12,d0			; Clear screen?
	bne	.writechar

	bsr	clear_screen
	bra	.locate

.newline:
	moveq	#0,d6
	addq.w	#1,d7
	cmp.w	#ROWS,d7
	blo	.locate

	; scroll the display one row up
	lea	DB_BPR*FONTHEIGHT(a5),a0
	move.l	a5,a1
	move.w	#((ROWS-1)*DB_BPR*FONTHEIGHT)>>2-1,d0
.scroll:
	move.l	(a0)+,(a1)+
	dbf	d0,.scroll

	moveq	#ROWS-1,d7
	lea	(ROWS-1)*DB_BPR*FONTHEIGHT(a5),a3
	moveq	#(DB_BPR*FONTHEIGHT)/8-1,d0
	move.l	a3,a0
.delrow:
	clr.l	(a0)+			; clear last row
	clr.l	(a0)+
	dbf	d0,.delrow
	bra	.nextchar

.writechar:
	sub.b	#' ',d0
	bmi	.nextcol		; ignore other control characters

	; draw the character
	ext.w	d0
	lsl.w	#3,d0
	lea	Font(pc,d0.w),a0
	move.b	(a0)+,(a3)
	move.b	(a0)+,1*DB_BPR(a3)
	move.b	(a0)+,2*DB_BPR(a3)
	move.b	(a0)+,3*DB_BPR(a3)
	move.b	(a0)+,4*DB_BPR(a3)
	move.b	(a0)+,5*DB_BPR(a3)
	move.b	(a0)+,6*DB_BPR(a3)
	move.b	(a0),7*DB_BPR(a3)

.nextcol:
	addq.w	#1,d6
	cmp.w	#COLS,d6
	bhs	.newline		; end of line reached
	addq.l	#1,a3

.nextchar:
	move.b	(a2)+,d0
	bne	.loop

	bsr	draw_cursor
	movem.w	d6-d7,Cxpos(a4)

	movem.l	(sp)+,d6-d7/a2-a3
	rts


	; 8x8 pixel font, with characters $20 to $7f
Font:
	incbin	"gfx/P0T-NOoDLE.bin"


;---------------------------------------------------------------------------
backspace:
; Move cursor to the left and delete the character there.
; a5 = bitmap base

	movem.l	d6-d7,-(sp)

	; d6 = cursor-column, d7 = cursor-row
	movem.w	Cxpos(a4),d6-d7
	bsr	draw_cursor		; undraw cursor

	subq.w	#1,d6
	bpl	.1

	; go to previous line
	moveq	#COLS-1,d6
	subq.w	#1,d7
	bpl	.1

	; top/left edge reached, no backspace possible
	moveq	#0,d6
	moveq	#0,d7

.1:	move.w	#DB_BPR*FONTHEIGHT,d0
	mulu	d7,d0
	add.w	d6,d0
	lea	(a5,d0.w),a0

	; clear chracter at this position
	moveq	#7,d0
.2:	clr.b	(a0)
	add.w	#DB_BPR,a0
	dbf	d0,.2

	bsr	draw_cursor
	movem.w	d6-d7,Cxpos(a4)

	movem.l	(sp)+,d6-d7
	rts


;---------------------------------------------------------------------------
getline:
; Read a line from the keyboard. Return pointer to input.
; a5 = bitmap base
; -> a0 = input buffer, terminated by zero

	movem.l	d2/a2-a3,-(sp)
	lea	CIAA,a3
	lea	Buffer(a4),a2		; a2 current input buffer pointer
	moveq	#LINEBUFSIZE,d2		; d2 bytes left in input buffer

	; disable CIA-A interrupts
	move.b	#$7f,CIAICR(a3)

	; stop TimerB, set to one-shot mode and load with handshake-length
	move.b	#KBDHANDSHAKE&$ff,CIATBLO(a3)
	move.b	#KBDHANDSHAKE>>8,CIATBHI(a3)
	move.b	#%00011000,CIACRB(a3)

.loop:
	; wait for SP interrupt from the keyboard
	moveq	#8,d0
	and.b	CIAICR(a3),d0
	beq	.loop

	; get keycode
	move.b	CIASDR(a3),d0

	; start timer and initiate SP handshaking
	or.b	#$01,CIACRB(a3)
	or.b	#%01000000,CIACRA(a3)

	; process the keycode in the meantime
	not.b	d0
	lsr.b	#1,d0
	bcs	.released

	; new key pressed
	cmp.b	#$60,d0
	bhs	.setqualifier

	cmp.b	#$50,d0			; ignore codes between $50 and $5f
	bhs	.handshake

	moveq	#3,d1			; Shift-qualifiers mask
	and.b	Qualifiers(a4),d1
	beq	.getascii
	moveq	#ShiftKeymap-Keymap,d1

.getascii:
	add.w	d1,d0
	move.b	Keymap(pc,d0.w),d1
	beq	.handshake		; ignore this key

	cmp.b	#8,d1
	bne	.putascii

	; do backspace/delete
	cmp.w	#LINEBUFSIZE,d2
	bhs	.handshake		; already at the beginning
	bsr	backspace
	subq.l	#1,a2
.1:	addq.w	#1,d2
	bra	.handshake

.putascii:
	; put new ascii code into the line buffer and print it
	move.l	a2,a0
	subq.w	#1,d2
	beq	.1			; buffer is full, reject char
	cmp.b	#10,d1
	bne	.2
	moveq	#0,d2			; Enter terminates the input line
.2:	move.b	d1,(a2)+
	clr.b	(a2)
	bsr	print
	bra	.handshake

.setqualifier:
	; a qualifier key was pressed, set its flag
	sub.b	#$60,d0
	bset	d0,Qualifiers(a4)
	bra	.handshake

.released:
	sub.b	#$60,d0
	bmi	.handshake

	; a qualifier key was released, clear its flag
	bclr	d0,Qualifiers(a4)

.handshake:
	; wait for timer underflow to finish handshaking
	moveq	#2,d0
	and.b	CIAICR(a3),d0
	beq	.handshake
	and.b	#%10111111,CIACRA(a3)

	tst.w	d2
	bne	.loop

	; return with input buffer pointer in a0
	lea	Buffer(a4),a0
	movem.l	(sp)+,d2/a2-a3
	rts


Keymap:
	dc.b	"`1234567890-=",$5c,0,"0"
	dc.b	"qwertyuiop[]",0,"123"
	dc.b	"asdfghjkl;'",0,0,"456"
	dc.b	"<zxcvbnm,./",0,".789"
	dc.b	' ',8,0,10,10,0,8,0,0,0,'-',0,0,0,0,0
ShiftKeymap:
	dc.b	"~!@#$%^&*()_+|",0,"0"
	dc.b	"QWERTYUIOP{}",0,"123"
	dc.b	"ASDFGHJKL:",$22,0,0,"456"
	dc.b	">ZXCVBNM<>?",0,".789"
	dc.b	' ',8,0,10,10,0,8,0,0,0,'-',0,0,0,0,0



	section	__MERGED,data


RegTxt:
	dc.b	"d0=",0
	even



	section	__MERGED,bss


	; room to save all original exception vectors
Oldvecs:
	ds.l	NUM_VECTORS

	; registers before entering the exception
Registers:
	ds.l	16

	; cursor coordinates for output
Cxpos:
	ds.w	1
Cypos:
	ds.w	1

	; saved DMA und interrupt registers when entering the debugger
Saved_dmacon:
	ds.w	1
Saved_intena:
	ds.w	1
Saved_intreq:
	ds.w	1

	; 68000 CPU needs special handling for address and bus errors
MC68000:
	ds.b	1

	; depressed qualifier keys (bitmask), 0=lshift, 1=rshift,
	; 2=capslock, 3=ctrl, 4=lalt, 5=ralt, 6=lamiga, 7=ramiga
Qualifiers:
	ds.b	1


	; line input buffer
Buffer:
	ds.b	LINEBUFSIZE


	endif	; IFD DEBUG
