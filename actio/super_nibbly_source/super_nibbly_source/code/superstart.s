	incdir	"p1:include/"
	include "exec/types.i"
	include	"exec/memory.i"
	include	"exec/tasks.i"
	include "exec/exec_lib.i"
	include "libraries/dos_lib.i"



cop1lc:		equ	$80
copjmp1:	equ	$88
diwstrt:	equ	$8e
diwstop:	equ	$90
ddfstrt:	equ	$92
ddfstop:	equ	$94
dmacon:		equ	$96
bpl1pth:	equ	$e0
bpl1ptl:	equ	$e2
bpl2pth:	equ	$e4
bpl2ptl:	equ	$e6
bpl3pth:	equ	$e8
bpl3ptl:	equ	$ea
bpl4pth:	equ	$ec
bpl4ptl:	equ	$ee
bpl5pth:	equ	$f0
bpl5ptl:	equ	$f2
bpl6pth:	equ	$f4
bpl6ptl:	equ	$f6
bplcon0:	equ	$100
bplcon1:	equ	$102
bplcon2:	equ	$104
bpl1mod:	equ	$108
bpl2mod:	equ	$10a
spr0pt:		equ	$120
spr1pt:		equ	$124
spr2pt:		equ	$128
spr3pt:		equ	$12c
spr4pt:		equ	$130
spr5pt:		equ	$134
spr6pt:		equ	$138
spr7pt:		equ	$13c
color00:	equ	$180
ciaapra:	equ	$bfe001
clear:	  	equ	$10002
startlist:	equ	38
bltcon0:	equ	$40
bltcon1:	equ	$42
bltafwm:	equ	$44
bltalwm:	equ	$46
bltsize:	equ	$58
bltamod:	equ	$64
bltbmod:	equ	$62
bltcmod:	equ	$60
bltdmod:	equ	$66
bltapth:	equ	$50
bltbpth:	equ	$4c	
bltcpth:	equ	$48
bltdpth:	equ	$54
dmaconr:	equ	$02

BITMAP=80*256*4

		SECTION Prog,CODE_F
		
j:

;Open Dos Library
        move.l  4,a6
        lea     dosname,a1
	move.l	#0,d0
        jsr     _LVOOpenLibrary(a6)
        tst.l   d0
        beq     nodos
        move.l  d0,dosbase

start:
	move.l	#$dff000,a5
	bsr	newcopper

	move.l	dosbase,a6
	move.l	#file1,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)


mtas:	btst	#6,$bfe001
	bne	mtas

	bsr	oldcopper

	move.l  dosbase,a1
        move.l  4,a6
	jsr	_LVOCloseLibrary(a6)
nodos:
exit:
	move.l	#0,d0
	rts
	

error:
	move.l	#$10000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts

oldcopper:
	lea	gfxname,a1
	move.l	4.w,a6
	jsr	_LVOOpenLibrary(a6)
	tst.l	d0
	beq	nogfx
	move.l	d0,gfxlib

	move.l	#$dff000,a5
	move.w	#$03c0,dmacon(a5)
	move.l	gfxlib,a4
	move.l	startlist(a4),cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)

	move.l	4.w,a6
	move.l	gfxlib,a1
	jsr	_LVOCloseLibrary(a6)

nogfx:
	rts

newcopper:
	move.w	#$03c0,dmacon(a5)
	move.l	#clist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts


gfxlib:	dc.l	0

	 even
gfxname: dc.b	"graphics.library",0
	 cnop 0,2

		SECTION Daten,DATA_C

	even

clist:	dc.w	$0001,$ff00,dmacon,$0100,bplcon0,$0000
	dc.w	bplcon1,0,bplcon2,0
	dc.w	$180,$0
	dc.w	$3801,$ff00,dmacon,$8100,$ed01,$ff00
	dc.w	bplcon0,0000,$ffff,$fffe
		
	 even
ende:





file1:		dc.b    "p2:nibbly/titel.exe",0
        	even

file2:		dc.b    "p2:nibbly/start "
adresse:	dc.b	0,0,0,0,0,0,0,0
		dc.b	0
        	even


dosbase: 	dc.l    0
dosname:	dc.b    "dos.library",0


