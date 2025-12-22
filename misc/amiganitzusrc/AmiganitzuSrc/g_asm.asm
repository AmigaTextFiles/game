	
	INCDIR "include:"
	INCLUDE "exec/types.i"
	INCLUDE "exec/io.i"
	INCLUDE "devices/inputevent.i"
	INCLUDE  "hardware/custom.i"

	XDEF _AsmHandler
	XDEF _JoyTest
	XDEF _VertBServer

	XREF _custom
	XREF _vbcounter

	STRUCTURE InputStruct, 0
		WORD b1
		WORD b2
		WORD mx
		WORD my
		UWORD key
		UWORD keys

	STRUCTURE joydata,0
		UWORD	fire
		UWORD	up
		UWORD	down
		UWORD	left
		UWORD	right
	LABEL joyd_SIZEOF

	section code

	

	; vertical blanking interrupt
_VertBServer
	add.l	#1, _vbcounter
	rts

	; input handler
_AsmHandler:
	move.l  a0,-(sp)							; save the address to the stack
CheckLoop:
	cmp.b	#IECLASS_POINTERPOS, ie_Class(a0)	; is this a pointer pos event?
	beq.s	PointerPos							; if so go to CheckPos
	cmp.b	#IECLASS_RAWMOUSE, ie_Class(a0)		; is this a raw mouse event?
	beq.s	ButtonClick							; if so go to ButtonClick
	cmp.b	#IECLASS_RAWKEY, ie_Class(a0)		; is this a raw key event?
	beq.s	KeyClick							; if so go to KeyClick
	jmp		NextEvent							; unwanted input, go to nect event
KeyClick:
	move.w	ie_Code(a0), d1
	move.w	ie_Code(a0), key(a1)
	bclr.b	#7, d1								; test and clear the MSB
	beq		key_down
												; key is up, set to zero
	move.b	d1, d2								; multiply the number by 2 (WORD is 2 BYTES)
	add.b	d2, d1
	move.w	#0, keys(a1, d1)
	jmp	key_continue

key_down:										; key is down, set to one
	move.b	d1, d2
	add.b	d2, d1
	move.w	#1, keys(a1, d1)
	

key_continue:
	move.l	(sp)+, d0							; get the start address back and put in d0
	move.l	#0, d0								; just kidding, return NULL
	rts

ButtonClick:
	move.w	ie_X(a0), mx(a1)					; copy x and y position
	move.w	ie_Y(a0), my(a1)
	move.w	ie_Code(a0), d0						; Get code...
	cmp.w	#IECODE_LBUTTON, d0					; Check for left down...
	beq.s	LeftButtonDown
	cmp.w	#IECODE_RBUTTON, d0					; Check for right down...
	beq.s	RightButtonDown
	move.w	ie_Code(a0), d0
	move.w	d0, d1								; Save...
	and.w	#$7F, d0							; Mask UP_PREFIX
	cmp.w	#IECODE_LBUTTON, d0					; Check for Left...
	beq.s	LeftButtonUp
	cmp.w	#IECODE_RBUTTON, d0					; Check for Left...
	beq.s	RightButtonUp
	jmp		NextEvent
PointerPos:
	; this is a message for intuition to move the mouse
	; it was probably sent by me, so return it down the list
	move.l	(sp)+, d0							; get the start address back and put in d0
	rts
LeftButtonDown:
	move.w	#1, b1(a1)
	jmp		NextEvent
LeftButtonUp:
	move.w	#0, b1(a1)
	jmp		NextEvent
RightButtonDown:
	move.w	#1, b2(a1)
	jmp		NextEvent
RightButtonUp:
	move.w	#0, b2(a1)
	jmp		NextEvent
NextEvent:
	move.l	(a0), d0							; Get next event
	move.l	d0, a0								; into a0...
	bne.s	CheckLoop							; Do some more.
	; finished
	move.l	(sp)+, d0							; get the start address back and put in d0
	move.l	#0, d0								; just kidding return NULL
	rts

	; get the joystick state
_JoyTest
	lea		_custom, a1
	; test the fire button
	clr.l	d0
	move.b	#%00111111, d0
	and.b	d0, $BFE201				; we must AND 00111111 int ddra0 ($BFE201)
	move.b	$BFE001, d0				; move pra0 to d0
	and.b	#%10000000, d0			; and out all the bits, leave fire button
	move.b	d0, fire(a0)
	; test directions - JOY1DAT is at DFF00C
	move.w	#0, right(a0)
	move.w	#0, left(a0)
	move.w	#0, up(a0)
	move.w	#0, down(a0)
	move.w	joy1dat(a1), d0				; register address
	btst.w	#1, d0
	beq		.not_right
	move.w	#1, right(a0)
.not_right
	btst.w	#9, d0
	beq		.not_left
	move.w	#1, left(a0)
.not_left
	move.w	d0, d1
	lsr.w	#1, d1
	eor.w	d0, d1
	btst.w	#0, d1
	beq		.not_down
	move.w	#1, down(a0)
.not_down
	btst.w	#8, d1
	beq		.not_up
	move.w	#1, up(a0)
.not_up

	rts

	END
