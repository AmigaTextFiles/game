allocmem:	equ	-198
freemem:	equ	-210
openlibrary:	equ	-552
closelibrary:	equ	-414
forbid:		equ	-132
permit:		equ	-138
ownblitter	equ	-456
disownblitter	equ	-462
execbase:	equ	 4
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

BITMAP=56*280*5*3
;+42*192*5
CHART=1000

		SECTION Prog,CODE_C
		
j:

start:
	cmp.b	#"J",(a0)+
	bne	.notright
	cmp.b	#"T",(a0)+
	beq	.isright

.notright
	move.l	#0,d0
	rts

.isright


        move.l  4,a6
        lea     gfxname,a1
	move.l	#0,d0
        jsr     openlibrary(a6)
        tst.l   d0
        beq     nogfx
        move.l  d0,gfxbase
	

	move.l	4.w,a6
	jsr	forbid(a6)
	move.l	#$dff000,a5

	move.l	#CHART,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,chartab
	
	move.l	4,a6
	move.l	#BITMAP,d0
	move.l	#clear,d1
	jsr	allocmem(a6)
	move.l	d0,bitplanes
	tst.l	d0
	beq	error
	bsr	cls

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)
	
	move.l	bitplanes,d0
	add.l	#56*280*5*3,d0
	;move.l	d0,maskbuffer
	move.l	#mymask,maskbuffer

	move.l	bitplanes,d0
	move.l	d0,activeplanes1
	add.l	#56*5*280,d0
	move.l	d0,activeplanes2

	;bsr	makemask
	bsr	builtscreen
	bsr	newcopper
	bsr	vposup
	bsr 	vposup
	bsr	fuckcopper

	bsr	mt_init
	move.l	$6c.w,oldvbl+2
	move.l	#newvbl,$6c.w

	move.w	#100,d0
.wait
	bsr	vposup
	dbra	d0,.wait
	
	bsr	dothemove

	move.w	#50,d0
.wait2
	bsr	vposup
	dbra	d0,.wait2

	bsr	switch

	bsr	scroller

mtas:	btst	#7,$bfe001
	bne	mtas

cleanup:

	move.l	oldvbl+2,$6c.w
	bsr	mt_end

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)
	
	bsr	oldcopper
	move.l	4.w,a6
	move.l	bitplanes,a1
	move.l	#BITMAP,d0
	jsr	freemem(a6)
	move.l	chartab,a1
	move.l	#CHART,d0
	jsr	freemem(a6)

	move.l	#0,d0
	rts

scroller:

	move.l	#chartext,charpointer

	move.l	chartab,a0
	lea	charchars,a1
	clr.l	d0
	clr.w	d1
.chaloop:
	move.b	(a1)+,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d2,d2
	move.l	d0,(a0,d2.w)
	cmp.b	#'U',d1
	bne	.no_modulo
	add.l	#3528,d0
.no_modulo
	add.w	#2,d0
	cmp.b	#32,d1
	bne	.chaloop

maus:
	move.l	#chartext,charpointer
	move.w	#0,charsx
	move.w	#4,charsy
	
rowloop
	move.l	charpointer,a0
	move.b	(a0)+,d4
	tst.b	d4
	bne	.notzero
	bra	maus
.notzero
	cmp.b	#10,d4
	bne	.noteol
	move.w	#0,charsx
	add.l	#1,charpointer
	add.w	#19,charsy
	bra	rowloop
.noteol
	cmp.b	#12,d4
	bne	.notcls
	add.l	#1,charpointer
	move.w	#0,charsx
	move.w	#4,charsy
	move.l	#200,d0
.wait
	bsr	vposup
	sub.l	#1,d0
	bne	.wait
	bsr	clearscreen
	bra	rowloop
.notcls
	move.l	a0,charpointer
	bsr 	putchar		
	add.w	#16,charsx

	bsr	vposup
	bsr	vposup

	btst	#7,$bfe001
	bne	rowloop
	rts

clearscreen:
	move.l	bitplanes,d1
	move.l	d1,d0
	add.l	#56*5*280*1,d0
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltdmod(a5)
	move.w	#280*2*64+28,bltsize(a5)
	bsr	waitblit
	move.w	#280*3*64+28,bltsize(a5)
	rts
	
putchar:
	bsr	shadow
	move.w	charsx,d0
	move.w	charsy,d1
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	move.w	d0,d3
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	cmp.b	#32,d4
	beq	space
	and.w	#$ff,d4
	move.l	chartab,a3
	add.w	d4,d4
	add.w	d4,d4
	move.l	(a3,d4.w),d4

	move.l	d4,d5
	add.l	#chars,d4
	add.l	#charsm,d5

	add.l	bitplanes,d1
	;add.l	#56*5*280*2,d1
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$0ff2,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.w	#40,bltamod(a5)
	move.w	#40,bltbmod(a5)
	move.w	#54,bltcmod(a5)
	move.w	#54,bltdmod(a5)
	move.w	#17*5*64+1,bltsize(a5)
	rts

shadow:
	move.w	d4,-(sp)
	move.w	charsx,d0
	move.w	charsy,d1
	add.w	#1,d1
	
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	move.w	d0,d3
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	cmp.b	#32,d4
	beq	.isspace
	and.w	#$ff,d4
	move.l	chartab,a3
	add.w	d4,d4
	add.w	d4,d4
	move.l	(a3,d4.w),d4

	move.l	d4,d5
	add.l	#charsm,d4
	add.l	#charsm,d5

	add.l	bitplanes,d1
	;add.l	#56*5*280*2,d1
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$1ff2,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.w	#40,bltamod(a5)
	move.w	#40,bltbmod(a5)
	move.w	#54,bltcmod(a5)
	move.w	#54,bltdmod(a5)
	move.w	#17*5*64+1,bltsize(a5)
.isspace
	move.w	(sp)+,d4
	rts

space:
	rts
	add.l	bitplanes,d1
	move.l	d1,d0
	add.l	#56*5*280*1,d0
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.w	#54,bltamod(a5)
	move.w	#54,bltdmod(a5)
	move.w	#17*5*64+1,bltsize(a5)
	rts

charchars:	dc.b	"ABCDEFGHIJKLMNOPQRSTU"
		dc.b	"VWXYZ0123456789+.:!- ",0
		
	EVEN
chartab:	dc.l	0
charsy:		dc.w	0
charsx:		dc.w	0
chartext:
		dc.b	10
		dc.b	"      YEEEEP!",10
		dc.b	10
		dc.b	"  FINALLY YOU SEE",10
		dc.b	"      THE END",10
		dc.b	"  OF SUPER NIBBLY",10
		dc.b	10
		dc.b	10
		dc.b	"  WE HOPE YOU DID",10
		dc.b	"  ENJOY THIS GAME.",12
		
		dc.b	"   SUPER-NIBBLY",10
		dc.b	"       IS A",10
		dc.b	"  COSMOS-DESIGNS",10
		dc.b	"    PRODUCTION.",10
		dc.b 	10
		dc.b	"PROGRAMMING:",10
		dc.b	"   CHRISANTH LEDERER",10
		dc.b	10
		dc.b	"GRAFIC + DESIGN:",10
		dc.b	"       HANNES SOMMER",10
		dc.b	10
		dc.b	"SOUNDWORK:",10
		dc.b	"   DIDI GOESSERINGER",12
		
		dc.b	10,10
		dc.b	"PRODUCER:",10
		dc.b	"       HANNES SOMMER",10
		dc.b	10,10
		dc.b	" EVERYTHING SEEN IN",10
		dc.b	"HERE COPYRIGHT  1993",10
		dc.b	"  ART DEPARTMENT !",10
		dc.b	12
		
		dc.b	10
		dc.b	10
		dc.b 	"CONTACT US:",10
		dc.b	10
		dc.b	"      COSMOS-DESIGNS",10
		dc.b	"         TALENTEBANK",10
		dc.b	"        POSTFACH 457",10
		dc.b	"      THEATERPLATZ 1",10
		dc.b	"     9020 KLAGENFURT",10
		dc.b	"             AUSTRIA",10
		dc.b	"     TEL:+463 502147",12
		
		dc.b	10,10,10,10
		dc.b	"    WATCH OUT FOR",10
		dc.b	"     FREDS BACK",10
		dc.b	"      ALSO BY",10
		dc.b	"   COSMOS-DESIGNS!",12
		
		dc.b	0
	EVEN

charpointer:	dc.l	0



newvbl:
	movem.l	d0-d7/a0-a6,-(sp)	
	bsr	mt_music
	movem.l	(sp)+,d0-d7/a0-a6
oldvbl:
	jmp	0

error:
	move.l	#$10000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts

oldcopper:
	move.l	4,a6
	jsr	permit(a6)
	lea	gfxname,a1
	jsr	openlibrary(a6)
	tst.l	d0
	beq	nogfx
	move.l	d0,gfxlib

	move.l	#$dff000,a5
	move.w	#$03e0,dmacon(a5)
	move.l	gfxlib,a4
	move.l	startlist(a4),cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83e0,dmacon(a5)

	move.l	4.w,a6
	move.l	gfxlib,a1
	jsr	closelibrary(a6)
nogfx:
	rts

newcopper:
	lea	colors,a0
	lea	gfx+42*5*192,a1
	move.w	#$180,d0
.cloop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	addq.w	#2,d0
	cmp.w	#$1c0,d0
	bne	.cloop

	move.w	#$444,colors+32*4-2

	move.w	#$fff,colors+2

	move.l	bitplanes,d0	
	add.l	#16,d0
	move.w	d0,planes+6
	swap	d0
	move.w	d0,planes+2
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+14
	swap	d0
	move.w	d0,planes+10
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+22
	swap	d0
	move.w	d0,planes+18
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+30
	swap	d0
	move.w	d0,planes+26
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+38
	swap	d0
	move.w	d0,planes+34

fuckcopper:
	move.w	#$03e0,dmacon(a5)
	move.l	#clist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts

cls:	
	rts
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltdpth(a5)
	move.w	#$0100,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltdmod(a5)
	move.w	#512*64+28,bltsize(a5)
	bsr	waitblit
	rts

builtscreen:
	move.w	#28,d0
	move.w	#30,d1
	bsr	putwolke1

	move.w	#200,d0
	move.w	#110,d1
	bsr	putwolke1

	move.w	#48,d0
	move.w	#180,d1
	bsr	putwolke2

	bsr	copyback
	rts


dothemove:
	move.w	#0,fliegoff
	move.w	#0,xpos
	move.w	#-100,ypos
	move.l	xpos,cxpos
	move.l	xpos,cxpos2
	move.w	#0,count


	lea	child1,a0
	move.w	#90,(a0)
	move.w	#27,2(a0)
	move.w	#27+24,4(a0)
	move.w	#140,6(a0)
	move.w	#0,8(a0)
	move.l	#cshowtab,10(a0)

	lea	child2,a0
	move.w	#100,(a0)
	move.w	#42,2(a0)
	move.w	#33+24,4(a0)
	move.w	#155,6(a0)
	move.w	#0,8(a0)
	move.l	#cshowtab,10(a0)

	lea	child3,a0
	move.w	#105,(a0)
	move.w	#35,2(a0)
	move.w	#17+24,4(a0)
	move.w	#150,6(a0)
	move.w	#0,8(a0)
	move.l	#cshowtab,10(a0)


.yloop
	bsr	vposup
	bsr	switch
	add.w	#1,count

	move.w	cxpos2,d0	
	move.w	cypos2,d1
	move.w	#8,d2
	move.w	#82,d3
	bsr	restore

	bsr	crotor

	move.w	count,d0
	cmp.w	#621,d0
	bne	.killsign
	bsr	killasign
	bsr	killasign2
.killsign
	move.w	count,d0
	cmp.w	#622,d0
	bne	.killsign2
	bsr	killasign
	bsr	killasign2
.killsign2

	
	cmp.w	#145,count
	bne	.no_help1
	move.w	#1,firsttime
.no_help1

	cmp.w	#230,count
	bge	.nohungry1
	cmp.w	#150,count
	blt	.nohungry12
	move.w	#70,d0
	move.w	#45,d1
	bsr	puthungry
	bra	.nohungry12
.nohungry1
	cmp.w	#232,count
	bge	.nohungry12
	move.w	#70,d0
	move.w	#45,d1
	bsr	clrhungry
.nohungry12

	cmp.w	#245,count
	bne	.no_help2
	move.w	#1,firsttime
.no_help2


	cmp.w	#310,count
	bge	.nohungry21
	cmp.w	#250,count
	blt	.nohungry22
	move.w	#80,d0
	move.w	#42,d1
	bsr	puthungry
	bra	.nohungry22
.nohungry21
	cmp.w	#312,count
	bge	.nohungry22
	move.w	#80,d0
	move.w	#42,d1
	bsr	clrhungry
.nohungry22


	cmp.w	#345,count
	bne	.no_help3
	move.w	#1,firsttime
.no_help3

	cmp.w	#450,count
	bge	.nohungry31
	cmp.w	#350,count
	blt	.nohungry32
	move.w	#72,d0
	move.w	#45,d1
	bsr	puthungry
	bra	.nohungry32
.nohungry31
	cmp.w	#452,count
	bge	.nohungry32
	move.w	#72,d0
	move.w	#45,d1
	bsr	clrhungry
.nohungry32

	cmp.w	#475,count
	bne	.no_help4
	move.w	#1,firsttime
.no_help4

	cmp.w	#580,count
	bge	.nohungry41
	cmp.w	#480,count
	blt	.nohungry42
	move.w	#82,d0
	move.w	#41,d1
	bsr	puthungry
	bra	.nohungry42
.nohungry41
	cmp.w	#582,count
	bge	.nohungry42
	move.w	#82,d0
	move.w	#41,d1
	bsr	clrhungry
.nohungry42


	lea	child3,a0
	bsr	dochild

	add.w	#2,fliegoff
	move.w	fliegoff,d2
	lea	fliegxtab,a0
	move.w	(a0,d2.w),d0
	cmp.w	#$4711,d0
	beq	stopflight
	add.w	d0,xpos
	lea	fliegytab,a0
	move.w	(a0,d2.w),d0
	add.w	d0,ypos

	move.w	xpos,d0	
	move.w	ypos,d1
	move.w	#8,d2
	move.w	#82,d3
	
	cmp.w	#620,count
	bge	.thisone
	cmp.w	#80,count
	bge	.otherone
.thisone
	move.l	#gfx+16,d4
	move.l	maskbuffer,d5	
	add.l	#16,d5
	bra	.otherone2
.otherone
	move.l	#gfx,d4
	move.l	maskbuffer,d5	
.otherone2
	bsr	bitblit

	lea	child1,a0
	bsr	dochild
	lea	child2,a0
	bsr	dochild

	move.w	xpos,d0	
	add.w	#27,d0
	move.w	ypos,d1
	add.w	#43,d1
	move.w	#3,d2
	move.w	#35,d3
	move.l	#gfx+4+42*5*106,d4
	move.l	maskbuffer,d5	
	add.l	#4+42*5*106,d5
	bsr	bitblit
				
	bsr	rotor


;****************************
;Sign 1
;****************************
	move.w	count,d0
	cmp.w	#620,d0
	bge	.nopuffy

	move.w	count,d0
	cmp.w	#100,d0		
	blt	.nopuffy
	bsr	smallpuffy
.nopuffy

	move.w	count,d0
	cmp.w	#100,d0		;sign 1 timer
	bne	.nosign1
	move.w	#1,d4
	bsr	putasign
.nosign1
	move.w	count,d0
	cmp.w	#101,d0		;sign 1 timer2
	bne	.nosign12
	move.w	#1,d4
	bsr	putasign
.nosign12

;****************************
;****************************
;****************************

;****************************
;Sign 2
;****************************

	move.w	count,d0
	cmp.w	#300,d0		;sign 2 timer
	bne	.nosign2
	move.w	#2,d4
	bsr	putasign
.nosign2
	move.w	count,d0
	cmp.w	#301,d0		;sign 2 timer2
	bne	.nosign22
	move.w	#2,d4
	bsr	putasign
.nosign22

;****************************
;****************************
;****************************

;****************************
;Sign 3
;****************************

	move.w	count,d0
	cmp.w	#500,d0		;sign 3 timer
	bne	.nosign3
	move.w	#3,d4
	bsr	putasign
.nosign3
	move.w	count,d0
	cmp.w	#501,d0		;sign 3 timer2
	bne	.nosign32
	move.w	#3,d4
	bsr	putasign
.nosign32

;****************************
;****************************
;****************************

	move.l	cxpos,cxpos2
	move.l	xpos,cxpos

	bra	.yloop

stopflight:

	move.w	#30,d0
.wait2
	bsr	vposup
	dbra	d0,.wait2

	bsr	vposup
		
	move.w	#256+128-16,d0
	move.w	#50,d1
	move.w	#5,d2
	move.w	#41,d3
	move.l	#gfx+32+42*5*62,d4
	move.l	maskbuffer,d5
	add.l	#32+42*5*62,d5
	bsr	bitblit

	bsr	vposdown
	bsr	switch

	move.w	#100,d0
.wait1
	bsr	vposup
	dbra	d0,.wait1

	bsr	vposdown
	bsr	switch
	move.w	#256+128-16,d0
	move.w	#50,d1
	move.w	#5,d2
	move.w	#41,d3
	bsr	restore

stopflight2:
	rts

firsttime:	dc.w	0

xpos:	dc.w	0
ypos:	dc.w	0
cxpos:	dc.w	0
cypos:	dc.w	0
cxpos2:	dc.w	0
cypos2:	dc.w	0
trot:	dc.w	0
count:	dc.w	0

activeplanes1:	dc.l	0
activeplanes2:	dc.l	0

child1:	dc.w	0	;+0  showtimer
	dc.w	0	;+2  xoff
	dc.w	0	;+4  yoff
	dc.w	0	;+6  crytimer
	dc.w	0	;+8  crystate
	dc.l	0	;+10 showoffset	
child2:	dc.w	0	;+0  showtimer
	dc.w	0	;+2  xoff
	dc.w	0	;+4  yoff
	dc.w	0	;+6  crytimer
	dc.w	0	;+8  crystate
	dc.l	0	;+10 showoffset	
child3:	dc.w	0	;+0  showtimer
	dc.w	0	;+2  xoff
	dc.w	0	;+4  yoff
	dc.w	0	;+6  crytimer
	dc.w	0	;+8  crystate
	dc.l	0	;+10 showoffset	

cshowtab:	dc.w	-3,-3,-3,-2,-2,-2,-2,-1,-1,-1,-1,-1,-1,-1
		dc.w	$4711

;d4.w	number
;1 - Heey ! no fruit ..
;2 - Now I`m on ...
;3 - Well, but ...
putasign:
	cmp.w	#1,d4
	bne	.not_type_1
	move.l	#gfx+42*5*141,d4
	move.l	maskbuffer,d5
	add.l	#42*5*141,d5
	bra	.nextstep
.not_type_1
	cmp.w	#2,d4
	bne	.not_type_2
	move.l	#gfx+14+42*5*134,d4
	move.l	maskbuffer,d5
	add.l	#14+42*5*134,d5
	bra	.nextstep
.not_type_2
	cmp.w	#3,d4
	bne	.not_type_3
	move.l	#gfx+28+42*5*141,d4
	move.l	maskbuffer,d5
	add.l	#28+42*5*141,d5
	bra	.nextstep
.not_type_3
	rts
	
.nextstep
	move.w	#215,d0
	move.w	#10,d1
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	move.w	d0,d3
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	and.w	#$f,d3
	ror.w	#4,d3
	add.l	activeplanes1,d1
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d3,bltcon1(a5)
	or.w	#$ff2,d3	
	move.w	d3,bltcon0(a5)
	move.w	#28,bltamod(a5)
	move.w	#28,bltbmod(a5)
	move.w	#42,bltcmod(a5)
	move.w	#42,bltdmod(a5)
	move.w	#51*5*64+7,bltsize(a5)
	rts

killasign:
	move.w	#215,d0
	move.w	#10,d1
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1
	move.l	d1,d0
	add.l	activeplanes1,d1
	add.l	bitplanes,d0
	add.l	#56*5*280*2,d0

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#42,bltamod(a5)
	move.w	#42,bltdmod(a5)
	move.w	#51*5*64+7,bltsize(a5)
	rts

killasign2:
	move.w	#196,d0
	move.w	#57,d1
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1
	move.l	d1,d0
	add.l	activeplanes1,d1
	add.l	bitplanes,d0
	add.l	#56*5*280*2,d0

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#50,bltamod(a5)
	move.w	#50,bltdmod(a5)
	move.w	#24*5*64+3,bltsize(a5)
	rts



smallpuffy:
	move.w	#196,d0
	move.w	#57,d1
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	move.w	d0,d3
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	and.w	#$f,d3
	ror.w	#4,d3
	add.l	activeplanes1,d1

	move.l	#gfx+10+42*5*106,d4
	move.l	maskbuffer,d5
	add.l	#10+42*5*106,d5
			
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d3,bltcon1(a5)
	or.w	#$ff2,d3	
	move.w	d3,bltcon0(a5)
	move.w	#36,bltamod(a5)
	move.w	#36,bltbmod(a5)
	move.w	#50,bltcmod(a5)
	move.w	#50,bltdmod(a5)
	move.w	#24*5*64+3,bltsize(a5)
	rts


puthungry:
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	move.w	d0,d3
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	and.w	#$f,d3
	ror.w	#4,d3
	add.l	activeplanes1,d1

	move.l	#gfx+20+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#20+42*5*82,d5

	cmp.w	#2,firsttime
	bls	.isthefirst
	add.l	#42*5*20,d4
	add.l	#42*5*20,d5
	add.l	#56*5*20,d1

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d3,bltcon1(a5)
	or.w	#$ff2,d3	
	move.w	d3,bltcon0(a5)
	move.w	#32,bltamod(a5)
	move.w	#32,bltbmod(a5)
	move.w	#46,bltcmod(a5)
	move.w	#46,bltdmod(a5)
	move.w	#14*5*64+5,bltsize(a5)
	add.w	#1,firsttime
	rts
.isthefirst
	add.w	#1,firsttime
				
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d3,bltcon1(a5)
	or.w	#$ff2,d3	
	move.w	d3,bltcon0(a5)
	move.w	#32,bltamod(a5)
	move.w	#32,bltbmod(a5)
	move.w	#46,bltcmod(a5)
	move.w	#46,bltdmod(a5)
	move.w	#34*5*64+5,bltsize(a5)
	rts

clrhungry:
	add.w	#128,d0
	and.l	#$fff,d0
	and.l	#$fff,d1
	
	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1
	move.l	d1,d0
	add.l	activeplanes1,d1
	add.l	bitplanes,d0
	add.l	#56*5*280*2,d0

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#46,bltamod(a5)
	move.w	#46,bltdmod(a5)
	move.w	#34*5*64+5,bltsize(a5)
	rts

	
dochild:
	move.w	(a0),d0
	cmp.w	count,d0
	bgt	.too_early
	
	move.w	xpos,d0
	add.w	2(a0),d0
	move.w	4(a0),d1

	move.l	10(a0),a1
	move.w	(a1),d2
	cmp.w	#$4711,d2
	bne	.is_valid
	move.w	#0,d2
	sub.l	#2,10(a0)
.is_valid	
	add.w	d2,d1
	move.w	d1,4(a0)
	add.w	ypos,d1
	add.l	#2,10(a0)

	move.w	#2,d2
	move.w	#24,d3

	move.w	6(a0),d4
	cmp.w	count,d4
	bls	.has2cry
	
	move.l	#gfx+4+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#4+42*5*82,d5
	bsr	bitblit
	rts
.has2cry
	move.w	6(a0),d4
	cmp.w	count,d4
	bne	.crying1
	
	move.l	#gfx+8+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#8+42*5*82,d5
	bsr	bitblit
	rts
.crying1

	add.w	#1,8(a0)
	and.w	#%111,8(a0)
	cmp.w	#4,8(a0)
	bge	.crying2

	move.l	#gfx+12+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#12+42*5*82,d5
	bsr	bitblit
	rts
.crying2
	move.l	#gfx+16+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#16+42*5*82,d5
	bsr	bitblit
	rts
	
.too_early
	rts

switch:
	move.l	activeplanes1,d0
	move.l	activeplanes2,activeplanes1
	move.l	d0,activeplanes2

	move.l	activeplanes2,d0
	add.l	#16,d0
	move.w	d0,planes+6
	swap	d0
	move.w	d0,planes+2
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+14
	swap	d0
	move.w	d0,planes+10
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+22
	swap	d0
	move.w	d0,planes+18
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+30
	swap	d0
	move.w	d0,planes+26
	swap	d0
	add.l	#56,d0
	move.w	d0,planes+38
	swap	d0
	move.w	d0,planes+34
	rts

crotor:
	move.w	cxpos2,d0
	add.w	#101,d0	
	move.w	cypos2,d1
	add.w	#34,d1
	move.w	#1,d2
	move.w	#47,d3
	bsr	restore
	rts

rotor:	
	not.w	trot
	beq	.otherone

	move.w	xpos,d0	
	add.w	#101,d0
	move.w	ypos,d1
	add.w	#54,d1
	move.w	#2,d2
	move.w	#7,d3
	move.l	#gfx+42*5*129,d4
	move.l	maskbuffer,d5
	add.l	#42*5*129,d5
	bsr	bitblit

	rts
.otherone
	move.w	xpos,d0	
	add.w	#101,d0
	move.w	ypos,d1
	add.w	#34,d1
	move.w	#2,d2
	move.w	#47,d3
	move.l	#gfx+42*5*82,d4
	move.l	maskbuffer,d5
	add.l	#42*5*82,d5
	bsr	bitblit
	rts

copyback:
	move.l	bitplanes,d0
	move.l	d0,d1
	add.l	#56*5*280,d1

	bsr	vposup
	bsr	waitblit
	bsr	vposup
	bsr	waitblit

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltdmod(a5)
	move.w	#640*64+56,bltsize(a5)

	bsr	vposup
	bsr	waitblit
	bsr	vposup
	bsr	waitblit
	
	add.l	#56*5*280,d1
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltdmod(a5)
	move.w	#640*64+56,bltsize(a5)

	bsr	vposup
	bsr	waitblit
	bsr	vposup
	bsr	waitblit

	rts


;normale Wolke
;d0.w	xpos
;d1.w	ypos
putwolke1:	
	add.w	#128,d0
	and.l	#$ffff,d0
	move.w	d0,d4

	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	and.w	#$f,d4
	ror.w	#4,d4
	
	add.l	bitplanes,d1
	move.l	#gfx+42*5*103+28,d0
			
	or.w	#$9f0,d4	
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d4,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#28,bltamod(a5)
	move.w	#42,bltdmod(a5)
	move.w	#38*5*64+7,bltsize(a5)

	rts


;Wolke mit Pfeil
;d0.w	xpos
;d1.w	ypos
putwolke2:	
	add.w	#128,d0
	and.l	#$ffff,d0
	move.w	d0,d4

	mulu	#280,d1
	lsr.w	#4,d0
	add.w	d0,d0
	add.l	d0,d1

	and.w	#$f,d4
	ror.w	#4,d4
	
	add.l	bitplanes,d1
	move.l	#gfx+32,d0
			
	or.w	#$9f0,d4	
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	d4,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#32,bltamod(a5)
	move.w	#46,bltdmod(a5)
	move.w	#62*5*64+5,bltsize(a5)

	rts
	


;* d0.w  xpos
;* d1.w  ypos
;* d2.w	 woerter in x
;* d3.w	 Zeilen
;* d4.w	 pointer zum image	 
;* d5.w	 pointer zur maske	 
bitblit:
	tst.w	d1
	bpl	.ypos_ok
	move.w	d3,d7
	add.w	d1,d7
	bmi	.noblit		;ganzes	Objekt unsichtbar
	move.w	d3,d6		;Anzahl der sichtbaren Zeilen in D7
	sub.w	d7,d6		;Anzahl der unsichtbaren Zeilen in D6
	move.w	d7,d3
	tst.w	d7
	beq	.noblit
	
	mulu	#21,d6
	add.w	d6,d6

	move.w	d6,d7
	
	add.w	d6,d6
	add.w	d6,d6

	add.w	d7,d6
	and.l	#$ffff,d6
	add.l	d6,d4
	add.l	d6,d5		;Ueberspringen der unsichtbaren Zeilen
	
	move.w	#0,d1
.ypos_ok
	
	mulu	#280,d1
	move.w	d0,d6
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes1,d0
	and.w	#$f,d6
	ror.w	#4,d6
	
	bsr	waitblit
	move.w	d6,bltcon1(a5)
	or.w	#$0ff2,d6
	move.w	d6,bltcon0(a5)
	move.l	d4,bltapth(a5)
	move.l	d5,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#42,d0
	move.w	d2,d1
	add.w	d1,d1
	sub.w	d1,d0
	move.w	d0,bltamod(a5)
	move.w	d0,bltbmod(a5)
	move.w	#56,d0
	move.w	d2,d1
	add.w	d1,d1
	sub.w	d1,d0
	move.w	d0,bltcmod(a5)
	move.w	d0,bltdmod(a5)
	lsl.w	#6,d3
	move.w	d3,d0
	add.w	d3,d3
	add.w	d3,d3
	add.w	d0,d3
	add.w	d2,d3
	move.w	d3,bltsize(a5)

.noblit
	rts

;* d0.w	xpos
;* d1.w	ypos
;* d2.w	 woerter in x
;* d3.w	 Zeilen
restore:
	tst.w	d1
	bpl	.ypos_ok
	move.w	d3,d7
	add.w	d1,d7
	bmi	.noblit		;ganzes	Objekt unsichtbar
	move.w	d3,d6		;Anzahl der sichtbaren Zeilen in D7
	sub.w	d7,d6		;Anzahl der unsichtbaren Zeilen in D6
	move.w	d7,d3
	tst.w	d7
	beq	.noblit

	mulu	#21,d6
	add.w	d6,d6

	move.w	d6,d7
	
	add.w	d6,d6
	add.w	d6,d6

	add.w	d7,d6
	and.l	#$ffff,d6
	add.l	d6,d4
	add.l	d6,d5		;Ueberspringen der unsichtbaren Zeilen
	
	move.w	#0,d1
.ypos_ok

	
	mulu	#280,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	move.l	d0,d1

	move.l	d1,d0
	add.l	activeplanes1,d1
	add.l	bitplanes,d0
	add.l	#56*5*280*2,d0

	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)

	move.w	#56,d0
	move.w	d2,d1
	add.w	d1,d1
	sub.w	d1,d0
	move.w	d0,bltamod(a5)
	move.w	d0,bltdmod(a5)
	lsl.w	#6,d3
	move.w	d3,d0
	add.w	d3,d3
	add.w	d3,d3
	add.w	d0,d3
	add.w	d2,d3
	move.w	d3,bltsize(a5)

.noblit
	rts

	
makemask:
	move.l	#gfx,d0
	move.l	maskbuffer,d1

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	add.l	#42,d0
	move.l	d0,bltbpth(a5)
	add.l	#42,d0
	move.l	d0,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$0ffe,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#42*4,bltamod(a5)
	move.w	#42*4,bltbmod(a5)
	move.w	#42*4,bltcmod(a5)
	move.w	#42*4,bltdmod(a5)
	move.w	#192*64+21,bltsize(a5)

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	add.l	#42,d0
	move.l	d0,bltapth(a5)
	add.l	#42,d0
	move.l	d0,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$0ffe,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#42*4,bltamod(a5)
	move.w	#42*4,bltbmod(a5)
	move.w	#42*4,bltcmod(a5)
	move.w	#42*4,bltdmod(a5)
	move.w	#192*64+21,bltsize(a5)

	move.l	maskbuffer,d0
	move.l	d0,d1
	move.l	#3,d2
.ploop
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	add.l	#42,d1
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#42*4,bltamod(a5)
	move.w	#42*4,bltdmod(a5)
	move.w	#192*64+21,bltsize(a5)
	dbra	d2,.ploop
	rts


waitblit:
	move.l	gfxbase,a6
	jsr	-228(a6)
	rts


vposdown:
vpos1
	tst.b	5(a5)
	bne	vpos1
vpos2
	tst.b	5(a5)
	beq	vpos2
	rts


vposup:
vpos11
	tst.b	5(a5)
	beq	vpos11
vpos22
	tst.b	5(a5)
	bne	vpos22
	rts


mt_lev6use=		1		; 0=NO, 1=YES
mt_finetuneused=	0		; 0=NO, 1=YES

mt_init	LEA	mt_data,A0
	MOVE.L	A0,mt_SongDataPtr
	LEA	250(A0),A1
	MOVE.W	#511,D0
	MOVEQ	#0,D1
mtloop	MOVE.L	D1,D2
	SUBQ.W	#1,D0
mtloop2	MOVE.B	(A1)+,D1
	CMP.W	D2,D1
	BGT.S	mtloop
	DBRA	D0,mtloop2
	ADDQ	#1,D2

	MOVE.W	D2,D3
	MULU	#128,D3
	ADD.L	#766,D3
	ADD.L	mt_SongDataPtr(PC),D3
	MOVE.L	D3,mt_LWTPtr

	LEA	mt_SampleStarts(PC),A1
	MULU	#128,D2
	ADD.L	#762,D2
	ADD.L	(A0,D2.L),D2
	ADD.L	mt_SongDataPtr(PC),D2
	ADDQ.L	#4,D2
	MOVE.L	D2,A2
	MOVEQ	#30,D0
mtloop3	MOVE.L	A2,(A1)+
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	ADD.L	D1,D1
	ADD.L	D1,A2
	LEA	8(A0),A0
	DBRA	D0,mtloop3

	OR.B	#2,$BFE001
	lea	mt_speed(PC),A4
	MOVE.B	#6,(A4)
	CLR.B	mt_counter-mt_speed(A4)
	CLR.B	mt_SongPos-mt_speed(A4)
	CLR.W	mt_PatternPos-mt_speed(A4)
mt_end	LEA	$DFF096,A0
	CLR.W	$12(A0)
	CLR.W	$22(A0)
	CLR.W	$32(A0)
	CLR.W	$42(A0)
	MOVE.W	#$F,(A0)
	RTS

mt_music
	MOVEM.L	D0-D4/D7/A0-A6,-(SP)
	lea	mt_speed(pc),a4
	ADDQ.B	#1,mt_counter
	MOVE.B	mt_counter(PC),D0
	CMP.B	mt_speed(PC),D0
	BLO.S	mt_NoNewNote
	CLR.B	mt_counter
	TST.B	mt_PattDelTime2
	BEQ.S	mt_GetNewNote
	BSR.S	mt_NoNewAllChannels
	BRA.W	mt_dskip

mt_NoNewNote
	BSR.S	mt_NoNewAllChannels
	BRA.W	mt_NoNewPosYet

mt_NoNewAllChannels
	LEA	$DFF090,A5
	LEA	mt_chan1temp-44(PC),A6
	BSR.W	mt_CheckEfx
	BSR.W	mt_CheckEfx
	BSR.W	mt_CheckEfx
	BRA.W	mt_CheckEfx

mt_GetNewNote
	MOVE.L	mt_SongDataPtr(PC),A0
	LEA	(A0),A3
	LEA	122(A0),A2	;pattpo
	LEA	762(A0),A0	;patterndata
	CLR.W	mt_DMACONtemp

	LEA	$DFF090,A5
	LEA	mt_chan1temp-44(PC),A6
	BSR.S	mt_DoVoice
	BSR.S	mt_DoVoice
	BSR.B	mt_DoVoice
	BSR.B	mt_DoVoice
	BRA.W	mt_SetDMA

mt_DoVoice
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE.B	mt_SongPos(PC),D0
	LEA	128(A2),A2
	MOVE.B	(A2,D0.W),D1
	MOVE.W	mt_PatternPos(PC),D2
	LSL	#7,D1
	LSR.W	#1,D2
	ADD.W	D2,D1
	LEA	$10(A5),A5
	LEA	44(A6),A6

	TST.L	(A6)
	BNE.S	mt_plvskip
	BSR.W	mt_PerNop
mt_plvskip
	MOVE.W	(A0,D1.W),D1
	LSL.W	#2,D1
	MOVE.L	A0,-(sp)
	MOVE.L	mt_LWTPtr(PC),A0
	MOVE.L	(A0,D1.W),(A6)
	MOVE.L	(sp)+,A0
	MOVE.B	2(A6),D2
	AND.L	#$F0,D2
	LSR.B	#4,D2
	MOVE.B	(A6),D0
	AND.B	#$F0,D0
	OR.B	D0,D2
	BEQ.B	mt_SetRegs
	MOVEQ	#0,D3
	LEA	mt_SampleStarts(PC),A1
	SUBQ	#1,D2
	MOVE	D2,D4
	ADD	D2,D2
	ADD	D2,D2
	LSL	#3,D4
	MOVE.L	(A1,D2.L),4(A6)
	MOVE.W	(A3,D4.W),8(A6)
	MOVE.W	(A3,D4.W),40(A6)
	MOVE.W	2(A3,D4.W),18(A6)
	MOVE.L	4(A6),D2	; Get start
	MOVE.W	4(A3,D4.W),D3	; Get repeat
	BEQ.S	mt_NoLoop
	MOVE.W	D3,D0		; Get repeat
	ADD.W	D3,D3
	ADD.L	D3,D2		; Add repeat
	ADD.W	6(A3,D4.W),D0	; Add replen
	MOVE.W	D0,8(A6)

mt_NoLoop
	MOVE.L	D2,10(A6)
	MOVE.L	D2,36(A6)
	MOVE.W	6(A3,D4.W),14(A6)	; Save replen
	MOVE.B	19(A6),9(A5)	; Set volume
mt_SetRegs
	MOVE.W	(A6),D0
	AND.W	#$0FFF,D0
	BEQ.W	mt_CheckMoreEfx	; If no note


	MOVE.B	2(A6),D0
	AND.B	#$0F,D0
	CMP.B	#3,D0	; TonePortamento
	BEQ.S	mt_ChkTonePorta
	CMP.B	#5,D0
	BEQ.S	mt_ChkTonePorta
	CMP.B	#9,D0	; Sample Offset
	BNE.S	mt_SetPeriod
	BSR.W	mt_CheckMoreEfx
	BRA.S	mt_SetPeriod

mt_ChkTonePorta
	BSR.W	mt_SetTonePorta
	BRA.W	mt_CheckMoreEfx

mt_DoSetFineTune
	BSR.W	mt_SetFineTune

mt_SetPeriod
	MOVEM.L	D1/A1,-(SP)
	MOVE.W	(A6),D1
	AND.W	#$0FFF,D1

	MOVE.W	D1,16(A6)

	MOVEM.L	(SP)+,D1/A1

	MOVE.W	2(A6),D0
	AND.W	#$0FF0,D0
	CMP.W	#$0ED0,D0 ; Notedelay
	BEQ.W	mt_CheckMoreEfx

	MOVE.W	20(A6),$DFF096
	BTST	#2,30(A6)
	BNE.S	mt_vibnoc
	CLR.B	27(A6)
mt_vibnoc
	BTST	#6,30(A6)
	BNE.S	mt_trenoc
	CLR.B	29(A6)
mt_trenoc
	MOVE.L	4(A6),(A5)	; Set start
	MOVE.W	8(A6),4(A5)	; Set length
	MOVE.W	16(A6),6(A5)	; Set period
	MOVE.W	20(A6),D0
	OR.W	D0,mt_DMACONtemp
	BRA.W	mt_CheckMoreEfx
 
mt_SetDMA
	lea	$bfd000,a3
	move.b	#$7f,$d00(a3)
	move.w	#$2000,$dff09c
	move.w	#$a000,$dff09a
	move.l	$78.w,mt_oldirq
	move.l	#mt_irq1,$78.w
	moveq	#0,d0
	move.b	d0,$e00(a3)
	move.b	#$a8,$400(a3)
	move.b	d0,$500(a3)
	move.b	#$11,$e00(a3)
	move.b	#$81,$d00(a3)
	OR.W	#$8000,mt_DMACONtemp
	BRA.w	mt_dskip

mt_irq1:tst.b	$bfdd00
	MOVE.W	mt_dmacontemp(pc),$DFF096
	move.w	#$2000,$dff09c
	move.l	#mt_irq2,$78.w
	rte

mt_irq2:tst.b	$bfdd00
	movem.l	a5-a6,-(a7)

	LEA	$DFF0A0,A5
	LEA	mt_chan1temp(PC),A6
	MOVE.L	10(A6),(A5)
	MOVE.W	14(A6),4(A5)
	MOVE.L	54(A6),$10(A5)
	MOVE.W	58(A6),$14(A5)
	MOVE.L	98(A6),$20(A5)
	MOVE.W	102(A6),$24(A5)
	MOVE.L	142(A6),$30(A5)
	MOVE.W	146(A6),$34(A5)

	move.b	#0,$bfde00
	move.b	#$7f,$bfdd00
	move.l	mt_oldirq(pc),$78.w
	move.w	#$2000,$dff09c
	movem.l	(a7)+,a5-a6
	rte

mt_dskip
	lea	mt_speed(PC),A4
	ADDQ.W	#4,mt_PatternPos-mt_speed(A4)
	MOVE.B	mt_PattDelTime-mt_speed(A4),D0
	BEQ.S	mt_dskc
	MOVE.B	D0,mt_PattDelTime2-mt_speed(A4)
	CLR.B	mt_PattDelTime-mt_speed(A4)
mt_dskc	TST.B	mt_PattDelTime2-mt_speed(A4)
	BEQ.S	mt_dska
	SUBQ.B	#1,mt_PattDelTime2-mt_speed(A4)
	BEQ.S	mt_dska
	SUBQ.W	#4,mt_PatternPos-mt_speed(A4)
mt_dska	TST.B	mt_PBreakFlag-mt_speed(A4)
	BEQ.S	mt_nnpysk
	SF	mt_PBreakFlag-mt_speed(A4)
	MOVEQ	#0,D0
	MOVE.B	mt_PBreakPos(PC),D0
	CLR.B	mt_PBreakPos-mt_speed(A4)
	LSL	#2,D0
	MOVE.W	D0,mt_PatternPos-mt_speed(A4)
mt_nnpysk
	CMP.W	#256,mt_PatternPos-mt_speed(A4)
	BLO.S	mt_NoNewPosYet
mt_NextPosition	
	MOVEQ	#0,D0
	MOVE.B	mt_PBreakPos(PC),D0
	LSL	#2,D0
	MOVE.W	D0,mt_PatternPos-mt_speed(A4)
	CLR.B	mt_PBreakPos-mt_speed(A4)
	CLR.B	mt_PosJumpFlag-mt_speed(A4)
	ADDQ.B	#1,mt_SongPos-mt_speed(A4)
	AND.B	#$7F,mt_SongPos-mt_speed(A4)
	MOVE.B	mt_SongPos(PC),D1
	MOVE.L	mt_SongDataPtr(PC),A0
	CMP.B	248(A0),D1
	BLO.S	mt_NoNewPosYet
	CLR.B	mt_SongPos-mt_speed(A4)
mt_NoNewPosYet	
	TST.B	mt_PosJumpFlag-mt_speed(A4)
	BNE.S	mt_NextPosition
	MOVEM.L	(SP)+,D0-D4/D7/A0-A6
	RTS

mt_CheckEfx
	LEA	$10(A5),A5
	LEA	44(A6),A6
	BSR.W	mt_UpdateFunk
	MOVE.W	2(A6),D0
	AND.W	#$0FFF,D0
	BEQ.S	mt_PerNop
	MOVE.B	2(A6),D0
	MOVEQ	#$0F,D1
	AND.L	D1,D0
	BEQ.S	mt_Arpeggio
	SUBQ	#1,D0
	BEQ.W	mt_PortaUp
	SUBQ	#1,D0
	BEQ.W	mt_PortaDown
	SUBQ	#1,D0
	BEQ.W	mt_TonePortamento
	SUBQ	#1,D0
	BEQ.W	mt_Vibrato
	SUBQ	#1,D0
	BEQ.W	mt_TonePlusVolSlide
	SUBQ	#1,D0
	BEQ.W	mt_VibratoPlusVolSlide
	SUBQ	#8,D0
	BEQ.W	mt_E_Commands
SetBack	MOVE.W	16(A6),6(A5)
	ADDQ	#7,D0
	BEQ.W	mt_Tremolo
	SUBQ	#3,D0
	BEQ.W	mt_VolumeSlide
mt_Return2
	RTS

mt_PerNop
	MOVE.W	16(A6),6(A5)
	RTS

mt_Arpeggio
	MOVEQ	#0,D0
	MOVE.B	mt_counter(PC),D0
	DIVS	#3,D0
	SWAP	D0
	TST.W	D0
	BEQ.S	mt_Arpeggio2
	SUBQ	#2,D0
	BEQ.S	mt_Arpeggio1
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	LSR.B	#4,D0
	BRA.S	mt_Arpeggio3

mt_Arpeggio2
	MOVE.W	16(A6),6(A5)
	RTS

mt_Arpeggio1
	MOVE.B	3(A6),D0
	AND.W	#15,D0
mt_Arpeggio3
	ADD.W	D0,D0
	LEA	mt_PeriodTable(PC),A0

	MOVE.W	16(A6),D1
	MOVEQ	#36,D7
mt_arploop
	CMP.W	(A0)+,D1
	BHS.S	mt_Arpeggio4
	DBRA	D7,mt_arploop
	RTS

mt_Arpeggio4
	MOVE.W	-2(A0,D0.W),6(A5)
	RTS

mt_FinePortaUp
	TST.B	mt_counter
	BNE.S	mt_Return2
	MOVE.B	#$0F,mt_LowMask
mt_PortaUp
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	AND.B	mt_LowMask(PC),D0
	MOVE.B	#$FF,mt_LowMask
	SUB.W	D0,16(A6)
	MOVE.W	16(A6),D0
	AND.W	#$0FFF,D0
	CMP.W	#113,D0
	BPL.S	mt_PortaUskip
	AND.W	#$F000,16(A6)
	OR.W	#113,16(A6)
mt_PortaUskip
	MOVE.W	16(A6),D0
	AND.W	#$0FFF,D0
	MOVE.W	D0,6(A5)
	RTS	
 
mt_FinePortaDown
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	#$0F,mt_LowMask
mt_PortaDown
	CLR.W	D0
	MOVE.B	3(A6),D0
	AND.B	mt_LowMask(PC),D0
	MOVE.B	#$FF,mt_LowMask
	ADD.W	D0,16(A6)
	MOVE.W	16(A6),D0
	AND.W	#$0FFF,D0
	CMP.W	#856,D0
	BMI.S	mt_PortaDskip
	AND.W	#$F000,16(A6)
	OR.W	#856,16(A6)
mt_PortaDskip
	MOVE.W	16(A6),D0
	AND.W	#$0FFF,D0
	MOVE.W	D0,6(A5)
	RTS

mt_SetTonePorta
	MOVEM.L	A0,-(SP)
	MOVE.W	(A6),D2
	AND.W	#$0FFF,D2
	LEA	mt_PeriodTable(PC),A0

	MOVEQ	#0,D0
mt_StpLoop
	CMP.W	(A0,D0.W),D2
	BHS.S	mt_StpFound
	ADDQ	#2,D0
	CMP.W	#37*2,D0
	BLO.S	mt_StpLoop
	MOVEQ	#35*2,D0
mt_StpFound
	BTST	#3,18(A6)
	BEQ.S	mt_StpGoss
	TST.W	D0
	BEQ.S	mt_StpGoss
	SUBQ	#2,D0
mt_StpGoss
	MOVE.W	(A0,D0.W),D2
	MOVE.L	(SP)+,A0
	MOVE.W	D2,24(A6)
	MOVE.W	16(A6),D0
	CLR.B	22(A6)
	CMP.W	D0,D2
	BEQ.S	mt_ClearTonePorta
	BGE.W	mt_Return2
	MOVE.B	#1,22(A6)
	RTS

mt_ClearTonePorta
	CLR.W	24(A6)
	RTS

mt_TonePortamento
	MOVE.B	3(A6),D0
	BEQ.S	mt_TonePortNoChange
	MOVE.B	D0,23(A6)
	CLR.B	3(A6)
mt_TonePortNoChange
	TST.W	24(A6)
	BEQ.W	mt_Return2
	MOVEQ	#0,D0
	MOVE.B	23(A6),D0
	TST.B	22(A6)
	BNE.S	mt_TonePortaUp
mt_TonePortaDown
	ADD.W	D0,16(A6)
	MOVE.W	24(A6),D0
	CMP.W	16(A6),D0
	BGT.S	mt_TonePortaSetPer
	MOVE.W	24(A6),16(A6)
	CLR.W	24(A6)
	BRA.S	mt_TonePortaSetPer

mt_TonePortaUp
	SUB.W	D0,16(A6)
	MOVE.W	24(A6),D0
	CMP.W	16(A6),D0
	BLT.S	mt_TonePortaSetPer
	MOVE.W	24(A6),16(A6)
	CLR.W	24(A6)

mt_TonePortaSetPer
	MOVE.W	16(A6),D2
	MOVE.B	31(A6),D0
	AND.B	#$0F,D0
	BEQ.S	mt_GlissSkip
	LEA	mt_PeriodTable(PC),A0

	MOVEQ	#0,D0
mt_GlissLoop
	CMP.W	(A0,D0.W),D2
	BHS.S	mt_GlissFound
	ADDQ	#2,D0
	CMP.W	#36*2,D0
	BLO.S	mt_GlissLoop
	MOVEQ	#35*2,D0
mt_GlissFound
	MOVE.W	(A0,D0.W),D2
mt_GlissSkip
	MOVE.W	D2,6(A5) ; Set period
	RTS

mt_Vibrato
	MOVE.B	3(A6),D0
	BEQ.S	mt_Vibrato2
	MOVE.B	26(A6),D2
	AND.B	#$0F,D0
	BEQ.S	mt_vibskip
	AND.B	#$F0,D2
	OR.B	D0,D2
mt_vibskip
	MOVE.B	3(A6),D0
	AND.B	#$F0,D0
	BEQ.S	mt_vibskip2
	AND.B	#$0F,D2
	OR.B	D0,D2
mt_vibskip2
	MOVE.B	D2,26(A6)
mt_Vibrato2
	MOVE.B	27(A6),D0
	LEA	mt_VibratoTable(PC),A4
	LSR.W	#2,D0
	AND.W	#$001F,D0
	MOVE.B	30(A6),D2
	AND.W	#$03,D2
	BEQ.S	mt_vib_sine
	LSL.B	#3,D0
	CMP.B	#1,D2
	BEQ.S	mt_vib_rampdown
	MOVE.B	#255,D2
	BRA.S	mt_vib_set
mt_vib_rampdown
	TST.B	27(A6)
	BPL.S	mt_vib_rampdown2
	MOVE.B	#255,D2
	SUB.B	D0,D2
	BRA.S	mt_vib_set
mt_vib_rampdown2
	MOVE.B	D0,D2
	BRA.S	mt_vib_set
mt_vib_sine
	MOVE.B	0(A4,D0.W),D2
mt_vib_set
	MOVE.B	26(A6),D0
	AND.W	#15,D0
	MULU	D0,D2
	LSR.W	#7,D2
	MOVE.W	16(A6),D0
	TST.B	27(A6)
	BMI.S	mt_VibratoNeg
	ADD.W	D2,D0
	BRA.S	mt_Vibrato3
mt_VibratoNeg
	SUB.W	D2,D0
mt_Vibrato3
	MOVE.W	D0,6(A5)
	MOVE.B	26(A6),D0
	LSR.W	#2,D0
	AND.W	#$003C,D0
	ADD.B	D0,27(A6)
	RTS

mt_TonePlusVolSlide
	BSR.W	mt_TonePortNoChange
	BRA.W	mt_VolumeSlide

mt_VibratoPlusVolSlide
	BSR.S	mt_Vibrato2
	BRA.W	mt_VolumeSlide

mt_Tremolo
	MOVE.B	3(A6),D0
	BEQ.S	mt_Tremolo2
	MOVE.B	28(A6),D2
	AND.B	#$0F,D0
	BEQ.S	mt_treskip
	AND.B	#$F0,D2
	OR.B	D0,D2
mt_treskip
	MOVE.B	3(A6),D0
	AND.B	#$F0,D0
	BEQ.S	mt_treskip2
	AND.B	#$0F,D2
	OR.B	D0,D2
mt_treskip2
	MOVE.B	D2,28(A6)
mt_Tremolo2
	MOVE.B	29(A6),D0
	LEA	mt_VibratoTable(PC),A4
	LSR.W	#2,D0
	AND.W	#$001F,D0
	MOVEQ	#0,D2
	MOVE.B	30(A6),D2
	LSR.B	#4,D2
	AND.B	#$03,D2
	BEQ.S	mt_tre_sine
	LSL.B	#3,D0
	CMP.B	#1,D2
	BEQ.S	mt_tre_rampdown
	MOVE.B	#255,D2
	BRA.S	mt_tre_set
mt_tre_rampdown
	TST.B	27(A6)
	BPL.S	mt_tre_rampdown2
	MOVE.B	#255,D2
	SUB.B	D0,D2
	BRA.S	mt_tre_set
mt_tre_rampdown2
	MOVE.B	D0,D2
	BRA.S	mt_tre_set
mt_tre_sine
	MOVE.B	0(A4,D0.W),D2
mt_tre_set
	MOVE.B	28(A6),D0
	AND.W	#15,D0
	MULU	D0,D2
	LSR.W	#6,D2
	MOVEQ	#0,D0
	MOVE.B	19(A6),D0
	TST.B	29(A6)
	BMI.S	mt_TremoloNeg
	ADD.W	D2,D0
	BRA.S	mt_Tremolo3
mt_TremoloNeg
	SUB.W	D2,D0
mt_Tremolo3
	BPL.S	mt_TremoloSkip
	CLR.W	D0
mt_TremoloSkip
	CMP.W	#$40,D0
	BLS.S	mt_TremoloOk
	MOVE.W	#$40,D0
mt_TremoloOk
	MOVE.W	D0,8(A5)
	MOVE.B	28(A6),D0
	LSR.W	#2,D0
	AND.W	#$003C,D0
	ADD.B	D0,29(A6)
	RTS

mt_SampleOffset
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	BEQ.S	mt_sononew
	MOVE.B	D0,32(A6)
mt_sononew
	MOVE.B	32(A6),D0
	LSL.W	#7,D0
	CMP.W	8(A6),D0
	BGE.S	mt_sofskip
	SUB.W	D0,8(A6)
	ADD.W	D0,D0
	ADD.L	D0,4(A6)
	RTS
mt_sofskip
	MOVE.W	#$0001,8(A6)
	RTS

mt_VolumeSlide
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	LSR.B	#4,D0
	TST.B	D0
	BEQ.S	mt_VolSlideDown
mt_VolSlideUp
	ADD.B	D0,19(A6)
	CMP.B	#$40,19(A6)
	BMI.S	mt_vsuskip
	MOVE.B	#$40,19(A6)
mt_vsuskip
	MOVE.B	19(A6),9(A5)
	RTS

mt_VolSlideDown
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
mt_VolSlideDown2
	SUB.B	D0,19(A6)
	BPL.S	mt_vsdskip
	CLR.B	19(A6)
mt_vsdskip
	MOVE.B	19(A6),9(A5)
	RTS

mt_PositionJump
	MOVE.B	3(A6),D0
	SUBQ	#1,D0
	MOVE.B	D0,mt_SongPos
mt_pj2	CLR.B	mt_PBreakPos
	ST 	mt_PosJumpFlag
	RTS

mt_VolumeChange
	MOVE.B	3(A6),D0
	CMP.B	#$40,D0
	BLS.S	mt_VolumeOk
	MOVEQ	#$40,D0
mt_VolumeOk
	MOVE.B	D0,19(A6)
	MOVE.B	D0,9(A5)
	RTS

mt_PatternBreak
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	MOVE.W	D0,D2
	LSR.B	#4,D0
	ADD	D0,D0
	MOVE	D0,D1
	ADD	D0,D0
	ADD	D0,D0
	ADD	D1,D0
	AND.B	#$0F,D2
	ADD.B	D2,D0
	CMP.B	#63,D0
	BHI.S	mt_pj2
	MOVE.B	D0,mt_PBreakPos
	ST	mt_PosJumpFlag
	RTS

mt_SetSpeed
	MOVE.B	3(A6),D0
	BEQ.W	mt_Return2
	CLR.B	mt_counter
	MOVE.B	D0,mt_speed
	RTS

mt_CheckMoreEfx
	BSR.W	mt_UpdateFunk
	MOVE.B	2(A6),D0
	AND.B	#$0F,D0
	SUB.B	#9,D0
	BEQ.W	mt_SampleOffset
	SUBQ	#2,D0
	BEQ.W	mt_PositionJump
	SUBQ	#1,D0
	BEQ.B	mt_VolumeChange
	SUBQ	#1,D0
	BEQ.S	mt_PatternBreak
	SUBQ	#1,D0
	BEQ.S	mt_E_Commands
	SUBQ	#1,D0
	BEQ.S	mt_SetSpeed
	BRA.W	mt_PerNop

mt_E_Commands
	MOVE.B	3(A6),D0
	AND.W	#$F0,D0
	LSR.B	#4,D0
	BEQ.S	mt_FilterOnOff
	SUBQ	#1,D0
	BEQ.W	mt_FinePortaUp
	SUBQ	#1,D0
	BEQ.W	mt_FinePortaDown
	SUBQ	#1,D0
	BEQ.S	mt_SetGlissControl
	SUBQ	#1,D0
	BEQ.B	mt_SetVibratoControl

	SUBQ	#2,D0

	BEQ.B	mt_JumpLoop
	SUBQ	#1,D0
	BEQ.W	mt_SetTremoloControl
	SUBQ	#2,D0
	BEQ.W	mt_RetrigNote
	SUBQ	#1,D0
	BEQ.W	mt_VolumeFineUp
	SUBQ	#1,D0
	BEQ.W	mt_VolumeFineDown
	SUBQ	#1,D0
	BEQ.W	mt_NoteCut
	SUBQ	#1,D0
	BEQ.W	mt_NoteDelay
	SUBQ	#1,D0
	BEQ.W	mt_PatternDelay
	BRA.W	mt_FunkIt

mt_FilterOnOff
	MOVE.B	3(A6),D0
	AND.B	#1,D0
	ADD.B	D0,D0
	AND.B	#$FD,$BFE001
	OR.B	D0,$BFE001
	RTS	

mt_SetGlissControl
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	AND.B	#$F0,31(A6)
	OR.B	D0,31(A6)
	RTS

mt_SetVibratoControl
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	AND.B	#$F0,30(A6)
	OR.B	D0,30(A6)
	RTS

mt_SetFineTune
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	MOVE.B	D0,18(A6)
	RTS

mt_JumpLoop
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	BEQ.S	mt_SetLoop
	TST.B	34(A6)
	BEQ.S	mt_jumpcnt
	SUBQ.B	#1,34(A6)
	BEQ.W	mt_Return2
mt_jmploop 	MOVE.B	33(A6),mt_PBreakPos
	ST	mt_PBreakFlag
	RTS

mt_jumpcnt
	MOVE.B	D0,34(A6)
	BRA.S	mt_jmploop

mt_SetLoop
	MOVE.W	mt_PatternPos(PC),D0
	LSR	#2,D0
	MOVE.B	D0,33(A6)
	RTS

mt_SetTremoloControl
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	LSL.B	#4,D0
	AND.B	#$0F,30(A6)
	OR.B	D0,30(A6)
	RTS

mt_RetrigNote
	MOVE.L	D1,-(SP)
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
	BEQ.S	mt_rtnend
	MOVEQ	#0,d1
	MOVE.B	mt_counter(PC),D1
	BNE.S	mt_rtnskp
	MOVE.W	(A6),D1
	AND.W	#$0FFF,D1
	BNE.S	mt_rtnend
	MOVEQ	#0,D1
	MOVE.B	mt_counter(PC),D1
mt_rtnskp
	DIVU	D0,D1
	SWAP	D1
	TST.W	D1
	BNE.S	mt_rtnend
mt_DoRetrig
	MOVE.W	20(A6),$DFF096	; Channel DMA off
	MOVE.L	4(A6),(A5)	; Set sampledata pointer
	MOVE.W	8(A6),4(A5)	; Set length
	BSR.W	mt_WaitDMA
	MOVE.W	20(A6),D0
	BSET	#15,D0
	MOVE.W	D0,$DFF096
	BSR.W	mt_WaitDMA
	MOVE.L	10(A6),(A5)
	MOVE.L	14(A6),4(A5)
mt_rtnend
	MOVE.L	(SP)+,D1
	RTS

mt_VolumeFineUp
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	3(A6),D0
	AND.W	#$F,D0
	BRA.W	mt_VolSlideUp

mt_VolumeFineDown
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
	BRA.W	mt_VolSlideDown2

mt_NoteCut
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
	CMP.B	mt_counter(PC),D0
	BNE.W	mt_Return2
	CLR.B	19(A6)
	CLR.W	8(A5)
	RTS

mt_NoteDelay
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
	CMP.B	mt_Counter(PC),D0
	BNE.W	mt_Return2
	MOVE.W	(A6),D0
	BEQ.W	mt_Return2
	MOVE.L	D1,-(SP)
	BRA.W	mt_DoRetrig

mt_PatternDelay
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	3(A6),D0
	AND.W	#$0F,D0
	TST.B	mt_PattDelTime2
	BNE.W	mt_Return2
	ADDQ.B	#1,D0
	MOVE.B	D0,mt_PattDelTime
	RTS

mt_FunkIt
	TST.B	mt_counter
	BNE.W	mt_Return2
	MOVE.B	3(A6),D0
	AND.B	#$0F,D0
	LSL.B	#4,D0
	AND.B	#$0F,31(A6)
	OR.B	D0,31(A6)
	TST.B	D0
	BEQ.W	mt_Return2
mt_UpdateFunk
	MOVEM.L	D1/A0,-(SP)
	MOVEQ	#0,D0
	MOVE.B	31(A6),D0
	LSR.B	#4,D0
	BEQ.S	mt_funkend
	LEA	mt_FunkTable(PC),A0
	MOVE.B	(A0,D0.W),D0
	ADD.B	D0,35(A6)
	BTST	#7,35(A6)
	BEQ.S	mt_funkend
	CLR.B	35(A6)

	MOVE.L	10(A6),D0
	MOVEQ	#0,D1
	MOVE.W	14(A6),D1
	ADD.L	D1,D0
	ADD.L	D1,D0
	MOVE.L	36(A6),A0
	ADDQ.L	#1,A0
	CMP.L	D0,A0
	BLO.S	mt_funkok
	MOVE.L	10(A6),A0
mt_funkok
	MOVE.L	A0,36(A6)
	NEG.B	(A0)
	SUBQ.B	#1,(A0)
mt_funkend
	MOVEM.L	(SP)+,D1/A0
	RTS

mt_WaitDMA
	MOVEQ	#3,D0
mt_WaitDMA2
	MOVE.B	$DFF006,D1
mt_WaitDMA3
	CMP.B	$DFF006,D1
	BEQ.S	mt_WaitDMA3
	DBF	D0,mt_WaitDMA2
	RTS

mt_FunkTable dc.b 0,5,6,7,8,10,11,13,16,19,22,26,32,43,64,128

mt_VibratoTable	
	dc.b   0, 24, 49, 74, 97,120,141,161
	dc.b 180,197,212,224,235,244,250,253
	dc.b 255,253,250,244,235,224,212,197
	dc.b 180,161,141,120, 97, 74, 49, 24

mt_PeriodTable
; Tuning 0, Normal
	dc.w	856,808,762,720,678,640,604,570,538,508,480,453
	dc.w	428,404,381,360,339,320,302,285,269,254,240,226
	dc.w	214,202,190,180,170,160,151,143,135,127,120,113
; Tuning 1
	dc.w	850,802,757,715,674,637,601,567,535,505,477,450
	dc.w	425,401,379,357,337,318,300,284,268,253,239,225
	dc.w	213,201,189,179,169,159,150,142,134,126,119,113
; Tuning 2
	dc.w	844,796,752,709,670,632,597,563,532,502,474,447
	dc.w	422,398,376,355,335,316,298,282,266,251,237,224
	dc.w	211,199,188,177,167,158,149,141,133,125,118,112
; Tuning 3
	dc.w	838,791,746,704,665,628,592,559,528,498,470,444
	dc.w	419,395,373,352,332,314,296,280,264,249,235,222
	dc.w	209,198,187,176,166,157,148,140,132,125,118,111
; Tuning 4
	dc.w	832,785,741,699,660,623,588,555,524,495,467,441
	dc.w	416,392,370,350,330,312,294,278,262,247,233,220
	dc.w	208,196,185,175,165,156,147,139,131,124,117,110
; Tuning 5
	dc.w	826,779,736,694,655,619,584,551,520,491,463,437
	dc.w	413,390,368,347,328,309,292,276,260,245,232,219
	dc.w	206,195,184,174,164,155,146,138,130,123,116,109
; Tuning 6
	dc.w	820,774,730,689,651,614,580,547,516,487,460,434
	dc.w	410,387,365,345,325,307,290,274,258,244,230,217
	dc.w	205,193,183,172,163,154,145,137,129,122,115,109
; Tuning 7
	dc.w	814,768,725,684,646,610,575,543,513,484,457,431
	dc.w	407,384,363,342,323,305,288,272,256,242,228,216
	dc.w	204,192,181,171,161,152,144,136,128,121,114,108
; Tuning -8
	dc.w	907,856,808,762,720,678,640,604,570,538,508,480
	dc.w	453,428,404,381,360,339,320,302,285,269,254,240
	dc.w	226,214,202,190,180,170,160,151,143,135,127,120
; Tuning -7
	dc.w	900,850,802,757,715,675,636,601,567,535,505,477
	dc.w	450,425,401,379,357,337,318,300,284,268,253,238
	dc.w	225,212,200,189,179,169,159,150,142,134,126,119
; Tuning -6
	dc.w	894,844,796,752,709,670,632,597,563,532,502,474
	dc.w	447,422,398,376,355,335,316,298,282,266,251,237
	dc.w	223,211,199,188,177,167,158,149,141,133,125,118
; Tuning -5
	dc.w	887,838,791,746,704,665,628,592,559,528,498,470
	dc.w	444,419,395,373,352,332,314,296,280,264,249,235
	dc.w	222,209,198,187,176,166,157,148,140,132,125,118
; Tuning -4
	dc.w	881,832,785,741,699,660,623,588,555,524,494,467
	dc.w	441,416,392,370,350,330,312,294,278,262,247,233
	dc.w	220,208,196,185,175,165,156,147,139,131,123,117
; Tuning -3
	dc.w	875,826,779,736,694,655,619,584,551,520,491,463
	dc.w	437,413,390,368,347,328,309,292,276,260,245,232
	dc.w	219,206,195,184,174,164,155,146,138,130,123,116
; Tuning -2
	dc.w	868,820,774,730,689,651,614,580,547,516,487,460
	dc.w	434,410,387,365,345,325,307,290,274,258,244,230
	dc.w	217,205,193,183,172,163,154,145,137,129,122,115
; Tuning -1
	dc.w	862,814,768,725,684,646,610,575,543,513,484,457
	dc.w	431,407,384,363,342,323,305,288,272,256,242,228
	dc.w	216,203,192,181,171,161,152,144,136,128,121,114

mt_chan1temp	dcb.l	5,0
		dc.w	1
		dcb.w	21,0
		dc.w	2
		dcb.w	21,0
		dc.w	4
		dcb.w	21,0
		dc.w	8
		dcb.w	11,0

mt_SampleStarts	dcb.l	31,0

mt_SongDataPtr	dc.l 0
mt_LWTPtr	dc.l 0
mt_oldirq	dc.l 0

mt_speed	dc.b 6
mt_counter	dc.b 0
mt_SongPos	dc.b 0
mt_PBreakPos	dc.b 0
mt_PosJumpFlag	dc.b 0
mt_PBreakFlag	dc.b 0
mt_LowMask	dc.b 0
mt_PattDelTime	dc.b 0
mt_PattDelTime2	dc.b 0,0
mt_PatternPos	dc.w 0
mt_DMACONtemp	dc.w 0



gfxlib:		dc.l	0
gfxbase:	dc.l	0

	 even
gfxname: dc.b	"graphics.library",0
	 cnop 0,2

bitplanes:	dc.l 0

maskbuffer:	dc.l 0

fliegoff:	dc.w 0


fliegxtab:	dc.w	0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,3,3,3,3,2,2,2,2,2,2,2,1,1,1,1,1,1
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	$4711

fliegytab:	dc.w	0,8,8,8,8,8,8,8,7,7,7,7,7,6,6,6,6,6
		dc.w	6,5,5,5,5,5
		dc.w	4,4,4,4,3,3,3,3,2,2,2,2
		dc.w	1,1,1,1
		dc.w	0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,-1,0,-1,0,-1,-1,-1,-1,-2,-2,-2,-2
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1,0,-1,0,-1
		dc.w	0,0,0,0,1,0,1,0,1,1,1,1,2,2,2,2
		dc.w	3,3,3,3,3,3,3,3,2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,0,0,0,0,-1,0,-1,0,-1,0,-1,0	
		dc.w	-1,-1,-1,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-2,-2,-2
		dc.w	-1,-1,-1,-1,-1,-1,-1,-1,0,-1,0,-1,0,-1,0,-1
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0



		SECTION Daten,DATA_C

	even

clist:	dc.w	$0001,$ff00,dmacon,$0100,bplcon0,$5000
	dc.w	bplcon1,0,bplcon2,0,bpl1mod,240,bpl2mod,240
	dc.w	diwstrt,$2081,diwstop,$2fc1
	dc.w	ddfstrt,$0038,ddfstop,$00d0
colors:
	dcb.w	32*2,0
	dc.w	$2501,$ff00
planes:
	dc.w	bpl1pth,0,bpl1ptl,0
	dc.w	bpl2pth,0,bpl2ptl,0
	dc.w	bpl3pth,0,bpl3ptl,0
	dc.w	bpl4pth,0,bpl4ptl,0
	dc.w	bpl5pth,0,bpl5ptl,0
	dc.w	$2801,$ff00,dmacon,$8100
stripes:
	dc.w	$3001,$ff00
	dc.w	$0180,$0fff

	dc.w	$3801,$ff00
	dc.w	$0180,$0ffe
	dc.w	$3901,$ff00
	dc.w	$0180,$0fff
	dc.w	$3a01,$ff00
	dc.w	$0180,$0ffe

	dc.w	$4001,$ff00
	dc.w	$0180,$0ffd
	dc.w	$4101,$ff00
	dc.w	$0180,$0ffe
	dc.w	$4201,$ff00
	dc.w	$0180,$0ffd

	dc.w	$4801,$ff00
	dc.w	$0180,$0ffc
	dc.w	$4901,$ff00
	dc.w	$0180,$0ffd
	dc.w	$4a01,$ff00
	dc.w	$0180,$0ffc

	dc.w	$5001,$ff00
	dc.w	$0180,$0ffc
	dc.w	$5101,$ff00
	dc.w	$0180,$0ffd
	dc.w	$5201,$ff00
	dc.w	$0180,$0ffc

	dc.w	$5801,$ff00
	dc.w	$0180,$0ffb
	dc.w	$5901,$ff00
	dc.w	$0180,$0ffc
	dc.w	$5a01,$ff00
	dc.w	$0180,$0ffb

	dc.w	$6001,$ff00
	dc.w	$0180,$0ffb
	dc.w	$6101,$ff00
	dc.w	$0180,$0ffb
	dc.w	$6201,$ff00
	dc.w	$0180,$0ffb

	dc.w	$6801,$ff00
	dc.w	$0180,$0ffa
	dc.w	$6901,$ff00
	dc.w	$0180,$0ffb
	dc.w	$6a01,$ff00
	dc.w	$0180,$0ffa

	dc.w	$7001,$ff00
	dc.w	$0180,$0efa
	dc.w	$7101,$ff00
	dc.w	$0180,$0ffa
	dc.w	$7201,$ff00
	dc.w	$0180,$0efa

	dc.w	$7801,$ff00
	dc.w	$0180,$0dfa
	dc.w	$7901,$ff00
	dc.w	$0180,$0efa
	dc.w	$7a01,$ff00
	dc.w	$0180,$0dfa

	dc.w	$8001,$ff00
	dc.w	$0180,$0cfa
	dc.w	$8101,$ff00
	dc.w	$0180,$0dfa
	dc.w	$8201,$ff00
	dc.w	$0180,$0cfa

	dc.w	$8801,$ff00
	dc.w	$0180,$0bfa
	dc.w	$8901,$ff00
	dc.w	$0180,$0cfa
	dc.w	$8a01,$ff00
	dc.w	$0180,$0bfa

	dc.w	$9001,$ff00
	dc.w	$0180,$0afa
	dc.w	$9101,$ff00
	dc.w	$0180,$0bfa
	dc.w	$9201,$ff00
	dc.w	$0180,$0afa

	dc.w	$9801,$ff00
	dc.w	$0180,$0afb
	dc.w	$9901,$ff00
	dc.w	$0180,$0afa
	dc.w	$9a01,$ff00
	dc.w	$0180,$0afb

	dc.w	$a001,$ff00
	dc.w	$0180,$0afc
	dc.w	$a101,$ff00
	dc.w	$0180,$0afb
	dc.w	$a201,$ff00
	dc.w	$0180,$0afc

	dc.w	$a801,$ff00
	dc.w	$0180,$0afd
	dc.w	$a901,$ff00
	dc.w	$0180,$0afc
	dc.w	$aa01,$ff00
	dc.w	$0180,$0afd

	dc.w	$b001,$ff00
	dc.w	$0180,$0afe
	dc.w	$b101,$ff00
	dc.w	$0180,$0afd
	dc.w	$b201,$ff00
	dc.w	$0180,$0afe

	dc.w	$b801,$ff00
	dc.w	$0180,$0aff
	dc.w	$b901,$ff00
	dc.w	$0180,$0afe
	dc.w	$ba01,$ff00
	dc.w	$0180,$0aff

	dc.w	$c001,$ff00
	dc.w	$0180,$09ff
	dc.w	$c101,$ff00
	dc.w	$0180,$0aff
	dc.w	$c201,$ff00
	dc.w	$0180,$09ff

	dc.w	$c801,$ff00
	dc.w	$0180,$09ef
	dc.w	$c901,$ff00
	dc.w	$0180,$09ff
	dc.w	$ca01,$ff00
	dc.w	$0180,$09ef

	dc.w	$d001,$ff00
	dc.w	$0180,$09df
	dc.w	$d101,$ff00
	dc.w	$0180,$09ef
	dc.w	$d201,$ff00
	dc.w	$0180,$09df

	dc.w	$d801,$ff00
	dc.w	$0180,$09cf
	dc.w	$d901,$ff00
	dc.w	$0180,$09df
	dc.w	$da01,$ff00
	dc.w	$0180,$09cf

	dc.w	$e001,$ff00
	dc.w	$0180,$09bf
	dc.w	$e101,$ff00
	dc.w	$0180,$09cf
	dc.w	$e201,$ff00
	dc.w	$0180,$09bf

	dc.w	$e801,$ff00
	dc.w	$0180,$09af
	dc.w	$e901,$ff00
	dc.w	$0180,$09bf
	dc.w	$ea01,$ff00
	dc.w	$0180,$09af

	dc.w	$f001,$ff00
	dc.w	$0180,$099f
	dc.w	$f101,$ff00
	dc.w	$0180,$09af
	dc.w	$f201,$ff00
	dc.w	$0180,$099f

	dc.w	$f801,$ff00
	dc.w	$0180,$0a9f
	dc.w	$f901,$ff00
	dc.w	$0180,$099f
	dc.w	$fa01,$ff00
	dc.w	$0180,$0a9f
	
	dc.w	$ffdf,$fffe

	dc.w	$0001,$ff00
	dc.w	$0180,$0b9f
	dc.w	$0101,$ff00
	dc.w	$0180,$0a9f
	dc.w	$0201,$ff00
	dc.w	$0180,$0b9f

	dc.w	$0801,$ff00
	dc.w	$0180,$0c9f
	dc.w	$0901,$ff00
	dc.w	$0180,$0b9f
	dc.w	$0a01,$ff00
	dc.w	$0180,$0c9f

	dc.w	$1001,$ff00
	dc.w	$0180,$0d9f
	dc.w	$1101,$ff00
	dc.w	$0180,$0c9f
	dc.w	$1201,$ff00
	dc.w	$0180,$0d9f

	dc.w	$1801,$ff00
	dc.w	$0180,$0e9f
	dc.w	$1901,$ff00
	dc.w	$0180,$0d9f
	dc.w	$1a01,$ff00
	dc.w	$0180,$0e9f

	dc.w	$2001,$ff00
	dc.w	$0180,$0f9f
	dc.w	$2101,$ff00
	dc.w	$0180,$0e9f
	dc.w	$2201,$ff00
	dc.w	$0180,$0f9f

	dc.w	bplcon0,0000

	dc.w	$2801,$ff00
	dc.w	$0180,$0f8f
	dc.w	$2901,$ff00
	dc.w	$0180,$0f9f
	dc.w	$2a01,$ff00
	dc.w	$0180,$0f8f
	
	dc.w	$3001,$ff00
	dc.w	$0180,$0f7f
	dc.w	$3101,$ff00
	dc.w	$0180,$0f8f
	dc.w	$3201,$ff00
	dc.w	$0180,$0f7f
	dc.w	$ffff,$fffe
		
	 even

	incdir	"dh0:lo-res/nibbly2/"

gfx:	incbin	"end_anims_336x192x5.rb"
mymask:	incbin	"end_anims_336x192x5.mask"
chars:	incbin	"end_chars_336x34x5.rb"
charsm:	incbin	"end_chars_336x34x5.mask"

	incdir	"dh0:assem/nibbly/sound/"

mt_data:	incbin	"mod.nibbly-ending"
ende:
