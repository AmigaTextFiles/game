*
* Input devices
*
* d0=status = readController(d0=port)
* kbdhandler()
*

	include	"custom.i"
	include	"cia.i"

KBDHANDSHAKE	equ	65	; 65us for keybord handshaking


; from main.asm
	xref	process_keycode



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	readController
readController:
; Read joystick button and directions for port d0.
; Left is -1, right is 1. Up is -1, down is 1.
; d0 = port (0 or 1)
; -> d0.l = button.b << 24 | updown.b << 16 | leftright.b

	move.l	d2,a0
	tst.b	d0
	bne	.2

	; port 0, check button
	moveq	#0,d0
	btst	#6,CIAA+CIAPRA
	bne	.1
	move.w	#$ff00,d0
.1:	move.w	JOY0DAT(a6),d1
	bra	.4

	; port 1, check button
.2:	moveq	#0,d0
	btst	#7,CIAA+CIAPRA
	bne	.3
	move.w	#$ff00,d0
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
	xdef	kbdhandler
kbdhandler:
; Handle CIA-A interrupts and receive key codes.
; All registers except d0, a4 and a5 must be restored when used!
; a4 = SmallData Base
; a6 = CUSTOM

	lea	CIAA,a5
	moveq	#8,d0
	and.b	CIAICR(a5),d0
	beq	.4

	; SP interrupt, get key code
	move.b	CIASDR(a5),d0

	; save original CRA, set SP to output for handshaking
	swap	d0
	move.b	CIACRA(a5),d0
	or.b	#%01000000,CIACRA(a5)

	; TimerA is running with 709 or 716 kHz. So we need approximately
	; 65 (KBDHANDSHAKE) timer cycles for the handshake.

	; stop TimerA, load with handshake-length and start it in one-shot mode
	and.b	#%11010110,CIACRA(a5)
	move.b	#KBDHANDSHAKE>>8,CIATAHI(a5)
	move.b	#KBDHANDSHAKE&$ff,CIATALO(a5)
	or.b	#%00011001,CIACRA(a5)

	; process the key code in the meantime
	swap	d0
	not.b	d0
	lsr.b	#1,d0
	bsr	process_keycode

	; wait until TimerA underflows, finish handshaking and restore CRA
.1:	btst	#0,CIAICR(a5)
	beq	.1
	swap	d0
	move.b	d0,CIACRA(a5)

.4:	rts
