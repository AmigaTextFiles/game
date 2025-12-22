* $Id: lowlevel.s 1.1 1999/02/03 04:08:28 jotd Exp $

	IFD	HARRY
TEST_JOY_BUTTON:MACRO
	bclr	#JPB_BUTTON_\1,D0	; button released
	tst.l	D2
	bne.b	.rts_\1
	bset	#JPB_BUTTON_\1,D0	; button pressed
.rts_\1
	ENDM
	ELSE
TEST_JOY_BUTTON:MACRO
	bclr	#JPB_BUTTON_\1,D0	; button released
	tst.l	D2
	bne.b	.rts\@
	bset	#JPB_BUTTON_\1,D0	; button pressed
.rts\@
	ENDM
	ENDC

**************************************************************************
*   LOWLEVEL-LIBRARY                                                    *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

LOWLINIT	move.l	_lowlbase,d0
		beq	.init
		rts

.init		move.l	#162,d0		; reserved function
		move.l	#80,d1		; 20 variables: should be OK
		lea	_lowlname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_lowlbase
		
		patch	_LVOReadJoyPort(a0),READJOYPORT(pc)
		patch	_LVOSetJoyPortAttrsA(a0),SETJOYPORTATTRS(pc)
		patch	_LVOAddVBlankInt(a0),ADDVBLANKINT(pc)
		patch	_LVOAddKBInt(a0),ADDKBINT(pc)
		patch	_LVOAddTimerInt(a0),ADDTIMERINT(pc)
		patch	_LVORemVBlankInt(a0),MYRTS(pc)
		patch	_LVORemKBInt(a0),MYRTS(pc)
		patch	_LVOSystemControlA(a0),MYRTZ(pc)
		patch	_LVOGetLanguageSelection(a0),GETLANGSEL(pc)
		rts

GETLANGSEL:
	moveq.l	#2,D0	; british english
	rts

; adds a vblank interrupt
; < A0: intRoutine
; < A1: intData

ADDVBLANKINT:
	movem.l	D2-D7/A2-A6,-(A7)
	lea	.int_entry(pc),A3
	move.l	A0,(A3)
	lea	.caller_int(pc),A0

	lea	.int_struct(pc),A3
	move.b	#NT_INTERRUPT,8(A3)	; ln_Type = INTERRUPT
	move.b	#0,9(A3)		; Highest priority
	move.l	.vbname,10(A3)		; The name of the server (for monitor programs)
	move.l	A0,18(A3)		; The new interrupt server code to chain with
	move.l	A1,14(A3)		; The data to pass in A1 at each call
	move.l	#INTB_VERTB,D0		; Vertical Blank interrupt
	move.l	$4.W,A6
	move.l	A3,A1			; pointer on interrupt structure
	JSR	_LVOAddIntServer(A6)	; Adds the handler to the existing chain
	
	movem.l	(A7)+,D2-D7/A2-A6

	moveq.l	#1,D0			; returns !=0 because success
	rts

.caller_int:
	move.l	.int_entry(pc),A5	; as required in lowlevel autodoc
	jmp	(A5)

.int_entry:
	dc.l	0
.int_struct:
	ds.b	22
.vbname:	
	dc.b	"lowlevel vbl",0
	cnop	0,4

; adds a keyboard interrupt
; < A0: intRoutine
; < A1: intData

ADDKBINT:
	movem.l	D2-D7/A2-A6,-(A7)
	lea	.int_entry(pc),A3
	move.l	A0,(A3)
	lea	.caller_int(pc),A0

	lea	.int_struct(pc),A3
	move.b	#NT_INTERRUPT,8(A3)	; ln_Type = INTERRUPT
	move.b	#0,9(A3)		; Highest priority
	move.l	.vbname,10(A3)		; The name of the server (for monitor programs)
	move.l	A0,18(A3)		; The new interrupt server code to chain with
	move.l	A1,14(A3)		; The data to pass in A1 at each call
	move.l	#INTB_PORTS,D0		; Ports interrupt
	move.l	$4.W,A6
	move.l	A3,A1			; pointer on interrupt structure
	JSR	_LVOAddIntServer(A6)	; Adds the handler to the existing chain
	
	movem.l	(A7)+,D2-D7/A2-A6
	moveq.l	#1,D0			; returns !=0 because success
	rts

.caller_int:
	move.l	.int_entry(pc),A5	; as required in lowlevel autodoc
	move.b	$BFEC01,D0
	not.b	D0
	ror.b	#1,D0			; raw keycode
	jmp	(A5)

.int_entry:
	dc.l	0
.int_struct:
	ds.b	22
.vbname:	
	dc.b	"lowlevel kb",0
	cnop	0,4

; adds a timer interrupt
; < A0: intRoutine
; < A1: intData

CIA_TIME_SLICE = 46911

ADDTIMERINT:
	movem.l	D2-D7/A2-A6,-(A7)

	; just stores the values

	move.l	A0,cia_int_entry
	move.l	A1,cia_int_data

	move.l	$4.W,A6
	lea	_ciaaname,A1
	JSR	_LVOOpenResource
	move.l	D0,cia_resource_handler		; resource handler

	lea	cia_caller_int(pc),A0

	lea	cia_int_struct(pc),A3
	move.b	#NT_INTERRUPT,8(A3)	; ln_Type = INTERRUPT
	move.b	#127,9(A3)		; Lowest priority
	move.l	cia_int_name,10(A3)		; The name of the server (for monitor programs)
	move.l	A0,18(A3)		; The new interrupt server code to chain with
	move.l	A1,14(A3)		; The data to pass in A1 at each call
	move.l	#3,D0		

	move.l	cia_int_struct(pc),D0	; only 1 interrupt of this kind
	movem.l	(A7)+,D2-D7/A2-A6
	rts

; A1 <: intHandle (also interrupt structure, hack!)
; D0 <: time interval (in microseconds)
; D1 <: continuous (0: one shot)

STARTTIMERINT:
	movem.l	D2-D7/A2-A6,-(A7)

	move.l	d0,cia_time_interval

	move.l	cia_resource_handler,A6
	move.l	#3,D0	
	JSR	_LVOAddICRVector(A6)	; Adds the handler to the existing chain
	
	movem.l	(A7)+,D2-D7/A2-A6
	rts

; <A1: intHandle

STOPTIMERINT:
	movem.l	D2-D7/A2-A6,-(A7)

	moveq.l	#3,D0
	move.l	cia_resource_handler,A6
	JSR	_LVORemICRVector(A6)	; Removes the handler to the existing chain
	
	movem.l	(A7)+,D2-D7/A2-A6
	rts

; routine called by ICRVector

cia_caller_int:
	; time counter, to avoid calling user routine every time
	; we must check the frequence he requested

	;;to be continued
	;

	move.l	cia_int_entry(pc),A5	; as required in lowlevel autodoc
	move.l	cia_int_data(pc),A1	; as required in lowlevel autodoc
	jmp	(A5)

cia_resource_handler:
	dc.l	0
cia_time_interval:
	dc.l	0

cia_int_struct:
	ds.b	22
cia_int_name:	
	dc.b	"lowlevel timer",0
	cnop	0,4
cia_int_entry:
	dc.l	0
cia_int_data:
	dc.l	0


; forces a port to a controller type and allows to reset it

SETJOYPORTATTRS:
	moveq.l	#-1,D0	; all went OK
	rts

; reads joypads

READJOYPORT:
	cmp.w	#0,D0
	beq	.joy0
	cmp.w	#1,D0
	beq	.joy1

	move.l	#JP_TYPE_NOTAVAIL,D0
	rts
.joy0
	move.l	#JP_TYPE_GAMECTLR,D0	; joypad connected

	btst	#6,$bfe001
	bne	.nob1_0

	bset	#JPB_BUTTON_RED,D0	; fire/lmb
	
.nob1_0:

	btst	#6,potinp+$DFF000
	bne	.nob2_0

	bset	#JPB_BUTTON_BLUE,D0	; fire 2/rmb
	move.w	#$CC01,potgo+$DFF000	; reset ports
.nob2_0	
	; joystick moves

	lea	(joy0dat+_custom),A6
	bsr	.joy_test

	rts

.joy1
	move.l	#JP_TYPE_GAMECTLR,D0	; joypad connected

	btst	#7,$bfe001
	bne	.nob1_1

	bset	#JPB_BUTTON_RED,D0	; fire/lmb
	
.nob1_1:

;	btst	#14,potinp+$DFF000	; was wrong ?
	btst	#6,potinp+$DFF000
	bne	.nob2_1

	bset	#JPB_BUTTON_BLUE,D0	; fire 2/rmb
	move.w	#$CC01,(potgo+_custom)	; reset ports
.nob2_1:

	; joystick moves

	lea	(joy1dat+_custom),A6
	bsr	.joy_test
	move.l	D0,-(A7)
	movem.l	D1/D2,-(A7)
	move.l	old_buttonmask,D0
	bsr	.button_test
	movem.l	(A7)+,D1/D2
	move.l	D0,old_buttonmask
	or.l	(A7),D0
	move.l	D0,(A7)
	move.l	(A7)+,D0
	rts

; other joypad buttons by keyboard emulation
; even a real joypad does not work properly on a real amiga!
; (I don't really know why!)


.button_test:
	move.b	KBDVAL,D1

	; press/release

	moveq.l	#0,D2
	bclr	#7,D1
	beq.b	.pressed
	moveq.l	#1,D2
.pressed

	cmp.b	#$50,D1		; F1: Blue
	bne	.noblue
	TEST_JOY_BUTTON	BLUE	; fire 2/blue/rmb
	rts
.noblue
	cmp.b	#$51,D1		; F2: Green
	bne	.nogreen
	TEST_JOY_BUTTON	GREEN
	rts
.nogreen:
	cmp.b	#$52,D1		; F3: Yellow
	bne	.noyellow
	TEST_JOY_BUTTON	YELLOW
	rts
.noyellow:
	cmp.b	#$53,D1		; F4: Play/pause
	bne	.noplay
	TEST_JOY_BUTTON	PLAY
	rts
.noplay:
	cmp.b	#$54,D1		; F5: left ear
	bne	.nolear
	TEST_JOY_BUTTON	REVERSE
	rts
.nolear:
	cmp.b	#$55,D1		; F6: right ear
	bne	.norear
	TEST_JOY_BUTTON	FORWARD
.norear:
	rts

; tests joystick moves
; < A6: custom reg. of the selected joystick
; > D0: joystick bits set

.joy_test:
	movem.l	D4-D6,-(A7)

	move.w	(A6),D4
	move.w	D4,D5
	btst	#1,D4
	beq.b	.left_off
	bset	#JPB_JOY_RIGHT,D0
	bra.b	.vert_test
.left_off:
	btst	#9,D4
	beq.b	.vert_test
	bset	#JPB_JOY_LEFT,D0
.vert_test
	lsr.w	#1,D4
	eor.w	D5,D4
	btst	#0,D4
	beq.b	.back_off
	bset	#JPB_JOY_DOWN,D0
	bra.b	.exit
.back_off
	btst	#8,D4
	beq.b	.exit
	bset	#JPB_JOY_UP,D0
.exit

	movem.l	(A7)+,D4-D6
	rts

old_buttonmask:
	dc.l	0


LAB_00D7:
	MOVEM.L	D2/A4-A6,-(A7)		;16A8: 48E7200E
	MOVEA.L	A1,A4			;16AC: 2849
	MOVEQ	#0,D2			;16AE: 7400
	MOVE.B	$BFEC01,D2		;16B0: 143900BFEC01
	NOT.B	D2			;16B6: 4602
	ROR.B	#1,D2			;16B8: E21A
	MOVEA.L	(72,A4),A0		;16BA: 206C0048
	MOVEA.L	(14,A0),A1		;16BE: 2268000E
	MOVEA.L	(18,A0),A5		;16C2: 2A680012
	JSR	(A5)			;16C6: 4E95
	CMP	#$0078,D2		;16C8: B47C0078
	BEQ.S	LAB_00DD		;16CC: 6760
	MOVE	D2,D1			;16CE: 3202
	AND	#$0078,D1		;16D0: C27C0078
	CMP	#$0060,D1		;16D4: B27C0060
	BNE.S	LAB_00D8		;16D8: 6612
	MOVE	(40,A4),D0		;16DA: 302C0028
	MOVE	D2,D1			;16DE: 3202
	AND	#$0007,D1		;16E0: C27C0007
	BCHG	D1,D0			;16E4: 0340
	MOVE	D0,(40,A4)		;16E6: 39400028
	BRA.S	LAB_00DA		;16EA: 601E
LAB_00D8:
	BTST	#7,D2			;16EC: 08020007
	BNE.S	LAB_00D9		;16F0: 6606
	MOVE	D2,(42,A4)		;16F2: 3942002A
	BRA.S	LAB_00DA		;16F6: 6012
LAB_00D9:
	MOVE	D2,D1			;16F8: 3202
	BCLR	#7,D1			;16FA: 08810007
	CMP	(42,A4),D1		;16FE: B26C002A
	BNE.S	LAB_00DA		;1702: 6606
	ORI	#$00FF,(42,A4)		;1704: 006C00FF002A
LAB_00DA:
	MOVE	D2,D0			;170A: 3002
	SUBI	#$00F9,D2		;170C: 044200F9
	BPL.S	LAB_00DD		;1710: 6A1C
	MOVEA.L	(252,A4),A1		;1712: 226C00FC
	BRA.S	LAB_00DC		;1716: 600E
LAB_00DB:
	MOVEA.L	(18,A1),A5		;1718: 2A690012
	MOVEA.L	(14,A1),A1		;171C: 2269000E
	JSR	(A5)			;1720: 4E95
	MOVEA.L	(A7)+,A1		;1722: 225F
	MOVE	(A7)+,D0		;1724: 301F
LAB_00DC:
	MOVE	D0,-(A7)		;1726: 3F00
	MOVE.L	(A1),-(A7)		;1728: 2F11
	BNE.S	LAB_00DB		;172A: 66EC
	ADDQ	#6,A7			;172C: 5C4F
LAB_00DD:
	MOVEM.L	(A7)+,D2/A4-A6		;172E: 4CDF7004
	RTS				;1732: 4E75
	MOVE.L	(40,A6),D0		;1734: 202E0028
	RTS				;1738: 4E75
