*
* Input devices
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initControllers()
* initKeyboard()
* exitKeyboard()
* d0=status = readController(d0=port)
* d0=key = getkey()
* clearkeys()
*

	include	"custom.i"
	include	"cia.i"

; duration for keyboard SP handshaking
KBDHANDSHAKE    equ     65              ; 02 clocks

; size of key buffer, must be a power of 2, below 256
KEYQUEUESIZE	equ	16

; key FIFO, implemented as ring buffer
		rsreset
KQWrite		rs.w	1		; FIFO write index
KQRead		rs.w	1		; FIFO read index
KQBuffer	rs.b	KEYQUEUESIZE	; FIFO buffer
KQ_sizeof	rs.b	0


; from os.asm
	xref	AutoVecBase

; from debug.asm
	xref	debug



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initControllers
initControllers:
; Initialize joystick/joypad controllers.
; Set all POTGO lines to output and pull them up to logical 1. This makes
; sure the 2nd button signal is stable, even when no joypad is connected.

	move.w	#$ff00,POTGO(a6)
	rts


;---------------------------------------------------------------------------
	xdef	readController
readController:
; Read joystick button and directions for port d0.
; The 2nd button on joypads is treated like the joystick's up-direction.
; Left is -1, right is 1. Up is -1, down is 1.
; d0 = port (0 or 1)
; -> d0.l = button.b << 24 | updown.b << 16 | leftright.b

	move.l	d2,a0
	tst.b	d0
	bne	.2

	; port 0, check button
	moveq	#0,d0
	btst	#2,POTGOR(a6)
	seq	d0		; 2nd button is 'up'
	btst	#6,CIAA+CIAPRA
	bne	.1
	or.w	#$ff00,d0
.1:	move.w	JOY0DAT(a6),d1
	bra	.4

	; port 1, check button
.2:	moveq	#0,d0
	btst	#6,POTGOR(a6)
	seq	d0		; 2nd button is 'up'
	btst	#7,CIAA+CIAPRA
	bne	.3
	or.w	#$ff00,d0
.3:	move.w	JOY1DAT(a6),d1

.4:	move.w	d1,d2
	lsr.w	#1,d2
	eor.w	d1,d2

	and.b	#$01,d2
	beq	.5
	addq.b	#1,d0		; down
	bra	.6
.5:	and.w	#$0100,d2
	beq	.6
	subq.b	#1,d0		; up

.6:	swap	d0

	and.b	#$02,d1
	beq	.7
	addq.b	#1,d0		; right
	bra	.8
.7:	and.w	#$0200,d1
	beq	.8
	subq.b	#1,d0		; left

.8:	move.l	a0,d2
	rts


;---------------------------------------------------------------------------
	xdef	initKeyboard
initKeyboard:
; Establish keyboard interrupt handler.

	move.l	a2,-(sp)
	lea	CIAA,a2

	; disable all PORTS interrupts
	moveq	#8,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)

	; disable all CIA-A interrupts
	move.b	#$7f,CIAICR(a2)

	; stop TimerB, set to one-shot mode and load with handshake-length
	move.b	#KBDHANDSHAKE&$ff,CIATBLO(a2)
	move.b	#KBDHANDSHAKE>>8,CIATBHI(a2)
	move.b	#%00011000,CIACRB(a2)

	; set level 2 interrupt handler
	move.l	AutoVecBase(a4),a0
	move.l	$68(a0),OldLev2Vec(a4)
	lea	lev2_handler(pc),a1
	move.l	a1,$68(a0)		; Level 2 Interrupt Vector

	; enable PORTS interrupts and CIA-A SP interupt for the keyboard
	move.w	#$c008,INTENA(a6)
	move.b	#$88,CIAICR(a2)

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	exitKeyboard
exitKeyboard:
; Remove our keyboard interrupt handler. Restore original interrupt.

	; disable PORTS interrupts
	moveq	#8,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)

	; restore old level 2 interrupt handler
	move.l	AutoVecBase(a4),a0
	move.l	OldLev2Vec(a4),$68(a0)

	; Reset CIA-A to its original state. TimerB was $ffff.
	; AmigaOS enables TA, TB, ALRM and SP interrupts (still blocked
	; by INTENA at this point).
	lea	CIAA,a0
	moveq	#-1,d0
	move.b	d0,CIATBLO(a0)		; TB=$ffff
	move.b	d0,CIATBHI(a0)
	move.b	#$8f,CIAICR(a0)		; enable CIA-A interrupts for AmigaOS
	rts


;---------------------------------------------------------------------------
lev2_handler:
; Handle CIA-A interrupts and process key codes.

	movem.l	d0-d1/a0-a1,-(sp)
	lea	CIAA,a0

	; read CIA-A ICR and check for SP interrupt
	moveq	#8,d0
	and.b	CIAICR(a0),d0
	beq	.clrirq

	; SP interrupt detected, get key code
	move.b	CIASDR(a0),d0

	; start timer and initiate SP handshaking
	or.b	#$01,CIACRB(a0)
	or.b	#%01000000,CIACRA(a0)

	; process the keycode in the meantime
	not.b	d0
	lsr.b	#1,d0
	bcs	.handshake		; ignore key releases

	; translate keycode
	ifd	DEBUG
	cmp.b	#$5f,d0			; HELP key for debugging
	bne	.mapcode
	moveq	#-1,d0
.mapcode:
	endif
	cmp.b	#$47,d0
	bhi	.handshake		; ignore keycodes above $47
	move.b	Keymap(pc,d0.w),d0
	beq	.handshake		; ignore unmapped keys

	; stuff ASCII code into the FIFO queue
	lea	KeyFIFO,a1
	move.w	(a1),d1			; KQWrite
	move.b	d0,KQBuffer(a1,d1.w)
	addq.w	#1,d1
	and.w	#KEYQUEUESIZE-1,d1	; ring buffer
	move.w	d1,(a1)			; update KQWrite index

.handshake:
	; wait for timer underflow to finish handshaking
	moveq	#2,d1
	and.b	CIAICR(a0),d1
	beq	.handshake
	and.b	#%10111111,CIACRA(a0)	; switch SP back to input

.clrirq:
	; clear PORTS interrupt
	move.w	#8,CUSTOM+INTREQ

	ifd	DEBUG
	tst.b	d0
	endif

	movem.l	(sp)+,d0-d1/a0-a1

	ifd	DEBUG
	bpl	.exit
	jmp	debug			; branch into the debugger
	endif
.exit:
	nop
	rte

Keymap:
	dc.b	0,"1234567890-=",$5c,0,"0"	; $00-$0f
	dc.b	"QWERTYUIOP[]",0,"123"		; $10-$1f
	dc.b	"ASDFGHJKL;'",0,0,"456"		; $20-$2f
	dc.b	"<ZXCVBNM,./",0,".789"		; $30-$3f
	dc.b	' ',8,0,10,10,27,8,0		; $40-$47


;---------------------------------------------------------------------------
	xdef	getkey
getkey:
; Return next ASCII key from the FIFO. Return 0 when empty.
; The caller has to ensure that no keyboard interrupt occurs while
; reading the next character from the FIFO.
; -> d0.w = key, Z=1 when empty

	lea	KeyFIFO(a4),a0
	move.w	(a0)+,d0		; d0.w = KQWrite
	move.w	(a0)+,d1		; d1.w = KQRead
	cmp.w	d0,d1
	bne	.1

	; FIFO is empty
	moveq	#0,d0			; set Z-flag
	rts

.1:	move.b	(a0,d1.w),d0		; KQBuffer
	addq.w	#1,d1
	and.w	#KEYQUEUESIZE-1,d1	; ring buffer
	move.w	d1,-(a0)		; KQRead
	tst.b	d0			; clear Z flag
	rts


;---------------------------------------------------------------------------
	xdef	clearkeys
clearkeys:
; Clear the keyboard FIFO queue.

	clr.l	KeyFIFO(a4)		; KQWrite = KQRead = 0
	rts



	section	__MERGED,bss


OldLev2Vec:
	ds.l	1

	; FIFO queue for received keys
KeyFIFO:
	ds.b	KQ_sizeof
