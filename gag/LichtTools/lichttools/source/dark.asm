;-------------------------------
;-- Great "DARK" for no View  --
;-- by magic mike             --
;-------------------------------


;exec.library
	ExecBase     = 4
	OpenLib      = -408
	CloseLibrary = -414

;graphics.library
	ActiView = 34
	copinit  = 38

	LoadView = -222
	WaitTOF  = -270


; Some often used MACROS...

oplib:  macro			;oplib name,base,error
	move.l	ExecBase,a6
	lea	?1,a1
	jsr	OpenLib(a6)
	move.l	d0,?2
	beq	?3
	endm

cllib:  macro			;cllib base
	move.l	ExecBase,a6
	move.l	?1,a1
	jsr	CloseLibrary(a6)
	endm
;----------------------------------------------------------

Start:
	oplib	GFXName,GFXBase,err1

	move.l	GFXBase(pc),a6
	move.l	ActiView(a6),OldView

	move.l	#0,a1			;no View
	jsr	LoadView(a6)
	jsr	WaitTOF(a6)
	jsr	WaitTOF(a6)		;interlace frame

	move	#$0080,$dff096
	move	$dff07c,d0
	and.w	#6,d0
	bne.L	NoAGA
	move	#0,$dff106           ;little bug in v39
	move	#0,$dff1fc	     ;Sprites to normal

NoAGA:
	move.w	#$4000,$dff09a		; normal Copper init
	move.l	#CopList,$dff080
	clr.l	$dff088			; copjmp1
	move.w	#$8080,$dff096

SetCol:
	move.w	#$0000,$dff180
	move.w	#$0000,$dff182

	btst	#6,$bfe001
	bne.s	SetCol

	move.l	GFXBase(pc),a6
	move.l	OldView(pc),a1
	jsr	LoadView(a6)
	jsr	WaitTOF(a6)		;interlace frame
	jsr	WaitTOF(a6)		;interlace frame
	move.l	copinit(a6),$dff080
	cllib	GFXBase
	moveq	#0,d0

err1:	rts

OldView:dc.l	0
GFXBase:dc.l	0
GFXName:dc.b	'graphics.library',0,0

CopList:
	dc.w	$0100,$1200
	dc.w	$008E,$3081,$0090,$30C1
	dc.w	$0092,$0038,$0094,$00D0
	dc.w	$0108,$0000,$010A,$0000
	dc.w	$0102,$0000,$0104,$0024
	dc.w	$E0,0,$E2,0
	dc.w	$0180,$0000,$0182,$0000
	dc.w	$FFFF,$FFFE
