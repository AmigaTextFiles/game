	SECTION	CODE_F
	incdir	"dh0:include/"
	include	"exec/exec_lib.i"
	include	"intuition/intuition_lib.i"
	include	"intuition/intuition.i"
	include	"graphics/graphics_lib.i"
	include "libraries/dos_lib.i"


start:	lea	intname,a1		
	moveq	#0,d0
	CALLEXEC OpenLibrary
	tst.l	d0
	beq	abbruch
	move.l	d0,_IntuitionBase



main:	lea	newscreen,a0		
	CALLINT	OpenScreen
	tst.l	d0
	beq	ende
	move.l	d0,screen

.nmouse
	btst	#6,$bfe001
	bne	.nmouse

ende2:	move.l	screen,a0	
	CALLINT	CloseScreen

ende:	move.l	_IntuitionBase,a1	
	CALLEXEC CloseLibrary

abbruch:	rts



newscreen:	
	dc.w	0,0
	dc.w	320,20
	dc.w	1
	dc.b	0,1
	dc.w	0
	dc.w	CUSTOMSCREEN
	dc.l	0
	dc.l	0
	dc.l	0,0

screen:	dc.l	0

intname		dc.b	"intuition.library",0
grafname 	dc.b	"graphics.library",0
dosname		dc.b	"dos.library",0

	 
_IntuitionBase		ds.l	1

	END
