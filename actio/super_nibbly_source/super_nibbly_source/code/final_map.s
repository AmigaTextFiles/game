;* SOS *
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

intena  = $9a
intreq  = $9c
aud3lc  = $d0
aud3len = $d4
aud3per = $d6
aud3vol = $d8
aud1lc  = $b0
aud1len = $b4
aud1per = $b6
aud1vol = $b8
adkcon  = $9e

GFXSIZE = 42*256*5*2
				 

j:
.suchen
	cmp.b	#'$',(a0)+
	bne	.suchen

	clr.l	d1
	move.w	#7,d2
.insert
	lsl.l	#4,d1
	move.b	(a0)+,d0
	sub.b	#48,d0
	or.b	d0,d1
	dbra	d2,.insert

	move.l	d1,sharemem

        move.l  4,a6
        lea     gfxname,a1
	move.l	#0,d0
        jsr     openlibrary(a6)
        move.l  d0,gfxbase
	
	move.l	#85600,d0
	move.l	#0,d1	
	move.l	4.w,a6
	jsr	allocmem(a6)
	move.l	d0,cdata

	move.l	execbase,a6
	clr.l	d0
	lea	dosname,a1
	jsr	openlibrary(a6)
	move.l	d0,dosbase

	move.l	#musicfile,d1
	move.l	#1005,d2
	move.l	dosbase,a6
	jsr	-30(a6)		;open
	tst.l	d0
	beq	fileerror
	move.l	d0,handle	

	move.l	handle,d1
	move.l	cdata,d2
	move.l	#85542,d3
	move.l	dosbase,a6
	jsr	-42(a6)		;read

	move.l	handle,d1
	move.l	dosbase,a6
	jsr	-36(a6)		;close

	move.l	dosbase,a1
	move.l	4.w,a6
	jsr	-414(a6)




	move.l	sharemem,a0
	move.l	24(a0),oldcopper

	move.l	#0,a1
	move.l	4.w,a6
	jsr	-294(a6)

	move.l	sharemem,a0
	move.l	d0,12(a0)

	move.l	20(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal

restart:	
	move.l	sharemem,a0	
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-318(a6)	;wait

	move.l	sharemem,a0
	cmp.w	#0,4(a0)
	beq	noshare
	cmp.w	#2,4(a0)
	bne	restart
	
	move.w	6(a0),d0
	lsr.w	#2,d0	
	move.w	d0,citynum

	bsr	the_map

	move.l	sharemem,a0
	move.w	#1,4(a0)
	move.w	#2,2(a0)

	move.l	sharemem,a0
	move.l	16(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)

	bra	restart
	
noshare:	
	move.l  gfxbase,a1
        move.l  4,a6
	jsr	closelibrary(a6)

	move.l	cdata,a1
	move.l	#85600,d0 
	move.l	4.w,a6
	jsr	freemem(a6)
	rts


musicfile:	dc.b	"nibbly:nibbly/map/music"
		even
savepc:		dc.l	0
sharemem:	dc.l	0

	
	
the_map:
	lea	$dff000,a5
	move.l	4.w,a6
	jsr	forbid(a6)
	move.w	$dff014,number
	move.w	$dff006,d0
	eor.w	d0,number
	move.w	$dff004,d0
	eor.w	d0,number

	move.l	#GFXSIZE,d0
	move.l	#2,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,bitplanes
	tst.l	d0
	beq	error

	move.l	d0,these_planes

	move.l	bitplanes,bitplanes2
	add.l	#42*5*256,bitplanes2
	move.l	bitplanes,saveplanes

	move.l	#6200,d0
	move.l	#2,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,town
	tst.l	d0
	beq	error

	move.l	#85550,d0
	move.l	#2,d1	;CLR & CHIP
	jsr	allocmem(a6)
	tst.l	d0
	beq	error
	move.l	d0,mt_main
	add.l	#37066,d0
	move.l	d0,mt_jingle1
	add.l	#11234,d0
	move.l	d0,mt_jingle2

	move.l	#85544/2,d0
	move.l	mt_main,a0
	move.l	cdata,a1
.cxloop	
	move.w	(a1)+,(a0)+
	sub.l	#1,d0
	bne	.cxloop

	move.l	#2000,d0
	move.l	#2,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,copperbase
	tst.l	d0
	beq	error

	move.l	#81500+14600,d0
	move.l	#2,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,mapgfx
	tst.l	d0
	beq	error

	move.l	d0,animations1
	add.l	#18360,d0
	move.l	d0,animations1_m
	add.l	#18360,d0
	move.l	d0,wuminger
	add.l	#6240,d0
	move.l	d0,wuminger_m
	add.l	#6240,d0
	move.l	d0,wolkinger
	add.l	#1680,d0
	move.l	d0,wolkinger_m
	add.l	#1680,d0
	move.l	d0,sprechingers
	add.l	#14280,d0
	move.l	d0,sprechingers_m

	bsr	loadgfx

	move.l	#61000,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,map
	tst.l	d0
	beq	error

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	lea	$dff000,a5
	move.l	#$ffffffff,bltafwm(a5)

	move.l	#crmap,a4
	move.l	map,a0
	bsr	decruncher

	bsr	make_paint_copperlist

	lea	$dff000,a5
	move.l	#$ffffffff,bltafwm(a5)

	lea	berglist,a0
	lea	berg2list,a1
	lea	somedata,a2
	move.l	#7,d0
.ccshit
	move.l	(a2),(a0)+
	move.l	(a2)+,(a1)+
	dbra	d0,.ccshit

nexttown:
	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)

	bsr	loadtown

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	lea	$dff000,a5
	move.l	#$ffffffff,bltafwm(a5)

	move.l	#scrolldat1,berg1tab
	move.l	#scrollende1,berg1end
	move.l	#scrolldat1,berg2tab
	move.l	#scrollende1,berg2end

	cmp.w	#14,citynum
	beq	.water
	cmp.w	#5,citynum
	beq	.water
	cmp.w	#3,citynum
	bne	.nowater
.water
	move.l	#scrolldat2,berg1tab
	move.l	#scrollende2,berg1end
	move.l	#scrolldat2,berg2tab
	move.l	#scrollende2,berg2end
.nowater
	
	move.l	berg1tab,bergoff
	move.l	berg2tab,berg2off

	bsr	mt_end

	cmp.w	#0,citynum
	bne	.nostart
	move.l	berg2tab,berg2off
	move.l	berg1tab,bergoff
	move.w	#1,jingle1
	move.w	#0,jingle2
	move.w	#0,music
.nostart

	move.w	#1,stop
	move.w	#0,timer
	move.w	#0,trigger
	move.l	#anim,animtabpointer
	cmp.w	#0,citynum
	beq	.anfang
	move.l	#gleichlos,animtabpointer
	move.w	#1,music
	move.w	#0,jingle1
	move.w	#0,jingle2
.anfang
	move.w	#0,animoff
	move.w	#0,reach
	move.w	#0,mtimer
	bsr	initcity

	bsr	paintcopper


;***********************************************
;*  M A I N
;***********************************************	
main:
	cmp.w	#1,jingle1
	bne	.nixjing1
	bsr	mt_end
	move.l	mt_jingle1,a0
	bsr	mt_init
	move.w	#2,jingle1
	move.w	#1,mactive
.nixjing1

	cmp.w	#2,jingle1
	bne	.notstep2
	cmp.w	#150,timer
	bne	.notstep2
	bsr	mt_end
	move.w	#0,jingle1
	move.w	#1,music
.notstep2

	tst.w	music
	beq	.nixmusic
	bsr	mt_end
	move.l	mt_main,a0
	bsr	mt_init
	move.w	#0,music
	move.w	#1,mactive
.nixmusic

	tst.w	reach
	beq	.nojing2
	tst.w	jingle2
	bne	.nojing2
	bsr	mt_end
	move.l	mt_jingle2,a0
	bsr	mt_init
	move.w	#1,mactive
	move.w	#1,jingle2
	move.w	#0,mustime
.nojing2

	tst.w	jingle2
	beq	.wait4stop
	add.w	#1,mustime
	cmp.w	#230,mustime
	bne	.wait4stop
	bsr	mt_end
	bra	cleanup
.wait4stop


	tst.w	mactive
	beq	.no_music
	bsr	mt_music
.no_music

	;btst	#7,$bfe001
	bra	notpause
	tst.w	reach
	beq	notpause
	


;now_we_wait:
	;btst	#7,$bfe001
	;bne	now_we_wait	

	
;.wait_release
	;btst	#7,$bfe001
	;beq	.wait_release
	add.w	#1,citynum

	cmp.w	#15,citynum
	bne	.aaddff2
	move.w	#0,citynum
.aaddff2

	bra	nexttown

	;move.w	#0,stop
	;move.l	#$10000,d0
pause:
	;sub.l	#1,d0
	;bne	pause
notpause:

	bsr	movecity

	bsr	next_action
	
	bsr	vposup
	bsr	switch
	move.l	bitplanes,activeplanes
	bsr	innen
	bsr	scrollall
	bsr	flups_action
	bsr	scrollall2
	bsr	clrleftright

	add.w	#1,timer

	;btst	#6,$bfe001
	bra	main

cleanup:
	bsr	mt_end

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)
	
	move.l	#$dff000,a5
	bsr	oldcopperbase

	move.l	4.w,a6
	jsr	permit(a6)
	move.l	these_planes,a1
	move.l	#GFXSIZE,d0
	jsr	freemem(a6)
	move.l	copperbase,a1
	move.l	#2000,d0 
	jsr	freemem(a6)
	move.l	town,a1
	move.l	#6200,d0
	jsr	freemem(a6)
	move.l	map,a1
	move.l	#61000,d0
	jsr	freemem(a6)
	move.l	mapgfx,a1
	move.l	#81500+14600,d0
	jsr	freemem(a6)
	move.l	#85550,d0
	move.l	mt_main,a1
	jsr	freemem(a6)

quit:
	moveq	#00,d0
	rts

these_planes:	dc.l	0

error:
	move.l	#50000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts

;************************************************************
;a0.l destination
;a4.l source
;************************************************************
decruncher:
		bsr	dcrunch
		lea	$dff000,a5
		rts

dcrunch:
		lea	$dff000,a6
		lea	12(a4),a5
		add.l	8(a4),a5		;bitlen
		move.l	a0,a3
		add.l	4(a4),a0		;lenght
		moveq	#127,d3
		moveq	#0,d4
		moveq	#3,d5
		moveq	#7,d6
		move.b	3(a4),d4		;scanbit

		move.l	-(a5),d7
deloop:		lsr.l	#1,d7
		bne.s	not_empty0
		move.l	-(a5),d7
		roxr.l	#1,d7
not_empty0:	bcc.s	copydata
		moveq	#0,d2
bytekpl:	move	d5,d1
		bsr.s	getbits
		add	d0,d2
		cmp	d6,d0
		beq.s	bytekpl
		subq	#1,d2
byteloop:	move	d6,d1
bytebits:	lsr.l	#1,d7
		bne.s	not_empty2
		move.l	-(a5),d7
		roxr.l	#1,d7
not_empty2:	roxr.b	#1,d0
		dbf	d1,bytebits
		move.b	d0,-(a0)
		dbf	d2,byteloop
		bra.s	test

copydata:	moveq	#2-1,d1
		bsr.s	getfast
		moveq	#0,d1
		move.l	d0,d2
		move.b	0(a4,d0.w),d1
		cmp	d5,d0
		bne.s	copyfast
		lsr.l	#1,d7
		bne.s	not_empty3
		move.l	-(a5),d7
		roxr.l	#1,d7
not_empty3:	bcs.s	copykpl

copykpl127:	move	d6,d1
		bsr.s	getbits
		add	d0,d2
		cmp	d3,d0
		beq.s	copykpl127
		add	d6,d2
		add	d6,d2
		bra.s	copyskip

copykpl:	move	d5,d1
		bsr.s	getbits
		add	d0,d2
		cmp	d6,d0
		beq.s	copykpl
copyskip:	move	d4,d1
copyfast:	addq	#1,d2
		bsr.s	getfast
copyloop:	move.b	0(a0,d0.w),-(a0)
		dbf	d2,copyloop
test:		cmp.l	a0,a3
		blo.s	deloop
		rts

getbits:	subq	#1,d1
getfast:	moveq	#0,d0
bitloop:	lsr.l	#1,d7
		bne.s	not_empty1
		move.l	-(a5),d7
		roxr.l	#1,d7
not_empty1:	addx.l	d0,d0
		dbf	d1,bitloop
		rts

opendos:
	move.l	4.w,a6
	jsr	permit(a6)

	move.l	execbase,a6
	clr.l	d0
	lea	dosname,a1
	jsr	openlibrary(a6)
	move.l	d0,dosbase
	rts

closefile:
	move.l	handle,d1
	move.l	dosbase,a6
	jsr	-36(a6)		;close
	rts

loadgfx:
	bsr	opendos

	move.l	#gfxfile,d1
	move.l	#1005,d2
	move.l	dosbase,a6
	jsr	-30(a6)		;open
	tst.l	d0
	beq	fileerror
	move.l	d0,handle	

	move.l	handle,d1
	move.l	mapgfx,d2
	add.l	#81500,d2
	move.l	#14600,d3
	move.l	dosbase,a6
	jsr	-42(a6)		;read

	bsr	closefile
	
	move.l	mapgfx,a4
	add.l	#81500,a4
	move.l	mapgfx,a0
	bsr	decruncher

	move.l	dosbase,a1
	move.l	4.w,a6
	jsr	-414(a6)

	move.l	4.w,a6
	jsr	forbid(a6)
	rts


loadtown:
	bsr	opendos
	
	move.w	citynum,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	townnames,a0
	move.l	(a0,d0.w),d1
	
	move.l	#1005,d2
	move.l	dosbase,a6
	jsr	-30(a6)		;open
	tst.l	d0
	beq	fileerror
	move.l	d0,handle	

	move.l	handle,d1
	move.l	map,d2
	add.l	#54000,d2
	move.l	#6500,d3
	move.l	dosbase,a6
	jsr	-42(a6)		;read

	bsr	closefile
		
	move.l	map,a4
	add.l	#54000,a4
	move.l	town,a0
	bsr	decruncher

	bsr	copymapfromfast

	move.l	dosbase,a1
	move.l	4.w,a6
	jsr	-414(a6)
	
	move.l	4.w,a6
	jsr	forbid(a6)
	rts

fileerror:
	move.l	#50000,d0
.ferloop:
	move.w	#$f00,$dff180
	move.w	#$000,$dff180
	sub.l	#1,d0
	bne	.ferloop
	bsr	copymapfromfast
	move.l	4.w,a6
	jsr	forbid(a6)
	rts

gfxfile:	dc.b	"nibbly:nibbly/map/mapgfx.pak",0
	even
	
handle:	dc.l	0
townnames:	dc.l	town1	
		dc.l	town2	
		dc.l	town3	
		dc.l	town4	
		dc.l	town5	
		dc.l	town6	
		dc.l	town7	
		dc.l	town8	
		dc.l	town9	
		dc.l	town10	
		dc.l	town11	
		dc.l	town12	
		dc.l	town13	
		dc.l	town14	
		dc.l	town15	
		dc.l	town16	

town1:	dc.b	"nibbly:nibbly/map/townpic1.pak",0
	even
town2:	dc.b	"nibbly:nibbly/map/townpic2.pak",0
	even
town3:	dc.b	"nibbly:nibbly/map/townpic3.pak",0
	even
town4:	dc.b	"nibbly:nibbly/map/townpic4.pak",0
	even
town5:	dc.b	"nibbly:nibbly/map/townpic5.pak",0
	even
town6:	dc.b	"nibbly:nibbly/map/townpic6.pak",0
	even
town7:	dc.b	"nibbly:nibbly/map/townpic7.pak",0
	even
town8:	dc.b	"nibbly:nibbly/map/townpic8.pak",0
	even
town9:	dc.b	"nibbly:nibbly/map/townpic9.pak",0
	even
town10:	dc.b	"nibbly:nibbly/map/townpic10.pak",0
	even
town11:	dc.b	"nibbly:nibbly/map/townpic11.pak",0
	even
town12:	dc.b	"nibbly:nibbly/map/townpic12.pak",0
	even
town13:	dc.b	"nibbly:nibbly/map/townpic13.pak",0
	even
town14:	dc.b	"nibbly:nibbly/map/townpic14.pak",0
	even
town15:	dc.b	"nibbly:nibbly/map/townpic15.pak",0
	even
town16:	dc.b	"nibbly:nibbly/map/townpic16.pak",0
	even

killthesprite
	move.w	#450,blobx
	bsr	putsprite
	bra	backtotown

puttown:
	cmp.w	#2,citynum
	beq	killthesprite
	cmp.w	#5,citynum
	beq	killthesprite
	cmp.w	#6,citynum
	beq	killthesprite
	cmp.w	#7,citynum
	beq	killthesprite
backtotown:

	move.l	town,d2
	
	move.w	#144,d0
	move.w	#100,d1
	mulu	#210,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	bitplanes,d0
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#28,bltdmod(a5)
	move.w	#88*5*64+7,bltsize(a5)

	move.w	#144,d0
	move.w	#100,d1
	mulu	#210,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	bitplanes2,d0
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#28,bltdmod(a5)
	move.w	#88*5*64+7,bltsize(a5)
	rts
	





initcity:
	move.w	citynum,d0
	lsl.w	#3,d0
	lea	citystart,a0
	move.w	(a0,d0.w),blobx
	add.w	#126,blobx
	move.w	2(a0,d0.w),bloby
	add.w	#37,bloby
	move.w	4(a0,d0.w),citydx
	move.w	6(a0,d0.w),citydy
	move.w	8(a0,d0.w),destx
	add.w	#126,destx
	move.w	10(a0,d0.w),desty
	add.w	#37,desty
	;move.w	#0,reach
	bsr	putsprite

	
	move.w	citynum,d0
	mulu	#48,d0
	add.l	#bodencolors,d0
	move.l	d0,a1

	move.l	savebodenfarbe,a0	
	move.w	#$51,d0
.bcol
	lea	6(a0),a0
	move.w	(a1)+,(a0)+
	lea	8(a0),a0
	add.w	#1,d0
	cmp.w	#$69,d0
	bne	.bcol


	cmp.w	#0,citynum
	bne	.not_city0
	move.l	animations1,d0
	move.l	d0,grossberg	
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg
	move.l	d0,bighouse
	add.l	#36*5*4,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg_m
	move.l	d0,bighouse_m
	add.l	#36*5*4,d0
	move.l	d0,smallhouse_m
	rts
.not_city0

	cmp.w	#1,citynum
	bne	.not_city1
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse_m
	rts
.not_city1

	cmp.w	#2,citynum
	bne	.not_city2
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*3,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*3,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*3,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*3,d0
	move.l	d0,smallhouse_m
	rts
.not_city2

	cmp.w	#3,citynum
	bne	.not_city3
	move.l	#0,grossberg	
	move.l	animations1,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg
	move.l	animations1_m,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg_m
	move.l	#0,bighouse
	move.l	#0,bighouse_m
	move.l	#0,smallhouse
	move.l	#0,smallhouse_m
	rts
.not_city3

	cmp.w	#4,citynum
	bne	.not_city4
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5,d0
	move.l	d0,smallhouse_m
	rts
.not_city4

	cmp.w	#5,citynum
	bne	.not_city5
	move.l	#0,grossberg	
	move.l	animations1,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg
	move.l	animations1_m,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg_m
	move.l	#0,bighouse
	move.l	#0,bighouse_m
	move.l	#0,smallhouse
	move.l	#0,smallhouse_m
	rts
.not_city5

	cmp.w	#6,citynum
	bne	.not_city6
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse_m
	rts
.not_city6

	cmp.w	#7,citynum
	bne	.not_city7
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse_m
	rts
.not_city7

	cmp.w	#8,citynum
	bne	.not_city8
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse_m
	rts
.not_city8

	cmp.w	#9,citynum
	bne	.not_city9
	move.l	animations1,d0
	move.l	d0,grossberg	
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg
	move.l	d0,bighouse
	add.l	#36*5*4,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg_m
	move.l	d0,bighouse_m
	add.l	#36*5*4,d0
	move.l	d0,smallhouse_m
	rts
.not_city9

	cmp.w	#10,citynum
	bne	.not_city10
	move.l	animations1,d0
	move.l	d0,grossberg	
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg
	move.l	d0,bighouse
	add.l	#36*5*4,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg_m
	move.l	d0,bighouse_m
	add.l	#36*5*4,d0
	move.l	d0,smallhouse_m
	rts
.not_city10

	cmp.w	#11,citynum
	bne	.not_city11
	move.l	animations1,d0
	move.l	d0,grossberg	
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg
	move.l	d0,bighouse
	add.l	#36*5*4,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18,d1
	move.l	d1,kleinberg_m
	move.l	d0,bighouse_m
	add.l	#36*5*4,d0
	move.l	d0,smallhouse_m
	rts
.not_city11

	cmp.w	#12,citynum
	bne	.not_city12
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*2,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*2,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*2,d0
	move.l	d0,smallhouse_m
	rts
.not_city12

	cmp.w	#13,citynum
	bne	.not_city13
	move.l	animations1,d0
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,grossberg	
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*3,d1
	move.l	d1,kleinberg
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,bighouse
	add.l	#36*5*4+36*24*5*3,d0
	move.l	d0,smallhouse
	move.l	animations1_m,d0
	move.l	d0,d1
	add.l	#36*5*18+36*24*5*3,d1
	move.l	d1,kleinberg_m
	move.l	d0,d1
	add.l	#36*24*5*3,d1
	move.l	d1,bighouse_m
	add.l	#36*5*4+36*24*5*3,d0
	move.l	d0,smallhouse_m
	rts
.not_city13

	cmp.w	#14,citynum
	bne	.not_city14
	move.l	#0,grossberg	
	move.l	animations1,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg
	move.l	animations1_m,d0
	add.l	#36*24*5*4,d0
	move.l	d0,kleinberg_m
	move.l	#0,bighouse
	move.l	#0,bighouse_m
	move.l	#0,smallhouse
	move.l	#0,smallhouse_m
	rts
.not_city14
	rts



himmelcolors:
	dc.w	$9af,$9bf,$acf,$adf,$bdf,$bdf,$bdf,$bdf,$adf,$adf
	dc.w	$acf,$acf,$9cf,$9cf,$9bf,$9bf,$8bf,$8af,$8af,$89e
	dc.w	$78e,$77e,$77e,$76e,$76e,$85e,$85e,$95d,$95d,$a5d
	dc.w	$a4d,$b4d

bodencolors:
	;town 0
	dc.w	$184,$284,$294,$3a4,$3a4,$3b4,$3b4,$3c3		
	dc.w	$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3
	dc.w	$3d3,$4d4,$5e4,$6e5,$7f5,$7d5,$6c5,$5a4
	
	;town 1
	dc.w	$961,$a61,$b71,$b81,$c82,$c92,$ca2,$da2
	dc.w	$da2,$da2,$da2,$da2,$da2,$da2,$da2,$da2
	dc.w	$db2,$eb2,$ec3,$fd3,$fe3,$fd3,$ec3,$eb2
	
	;town 2
	dc.w	$c82,$c92,$da2,$db2,$eb3,$ec3,$fd3,$fe3
	dc.w	$fe3,$fe3,$fe3,$fe3,$fe3,$fe3,$fe3,$fe3
	dc.w	$db2,$dc3,$ed3,$ee4,$ff5,$ee4,$ed3,$dc3

	;town 3
	dc.w	$30c,$01d,$53d,$54d,$74d,$74d,$75d,$76d
	dc.w	$76d,$76d,$76d,$76d,$76d,$76d,$76d,$76d
	dc.w	$64d,$65d,$65d,$77d,$87d,$88d,$88e,$88f

	;town 4
	dc.w	$68e,$79e,$7ae,$8ae,$8be,$9bf,$9cf,$acf
	dc.w	$acf,$acf,$acf,$acf,$acf,$acf,$acf,$acf
	dc.w	$8ae,$8be,$9be,$acf,$bdf,$acf,$ace,$9be

	;town 3
	dc.w	$30c,$01d,$53d,$54d,$74d,$74d,$75d,$76d
	dc.w	$76d,$76d,$76d,$76d,$76d,$76d,$76d,$76d
	dc.w	$64d,$65d,$65d,$77d,$87d,$88d,$88e,$88f

	;town 1
	dc.w	$961,$a61,$b71,$b81,$c82,$c92,$ca2,$da2
	dc.w	$da2,$da2,$da2,$da2,$da2,$da2,$da2,$da2
	dc.w	$db2,$eb2,$ec3,$fd3,$fe3,$fd3,$ec3,$eb2

	;town 1
	dc.w	$961,$a61,$b71,$b81,$c82,$c92,$ca2,$da2
	dc.w	$da2,$da2,$da2,$da2,$da2,$da2,$da2,$da2
	dc.w	$db2,$eb2,$ec3,$fd3,$fe3,$fd3,$ec3,$eb2

	;town 1
	dc.w	$961,$a61,$b71,$b81,$c82,$c92,$ca2,$da2
	dc.w	$da2,$da2,$da2,$da2,$da2,$da2,$da2,$da2
	dc.w	$db2,$eb2,$ec3,$fd3,$fe3,$fd3,$ec3,$eb2

	;town 0
	dc.w	$184,$284,$294,$3a4,$3a4,$3b4,$3b4,$3c3		
	dc.w	$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3
	dc.w	$3d3,$4d4,$5e4,$6e5,$7f5,$7d5,$6c5,$5a4

	;town 0
	dc.w	$184,$284,$294,$3a4,$3a4,$3b4,$3b4,$3c3		
	dc.w	$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3
	dc.w	$3d3,$4d4,$5e4,$6e5,$7f5,$7d5,$6c5,$5a4

	;town 0
	dc.w	$184,$284,$294,$3a4,$3a4,$3b4,$3b4,$3c3		
	dc.w	$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3,$3c3
	dc.w	$3d3,$4d4,$5e4,$6e5,$7f5,$7d5,$6c5,$5a4

	;town 1
	dc.w	$961,$a61,$b71,$b81,$c82,$c92,$ca2,$da2
	dc.w	$da2,$da2,$da2,$da2,$da2,$da2,$da2,$da2
	dc.w	$db2,$eb2,$ec3,$fd3,$fe3,$fd3,$ec3,$eb2

	;town 2
	dc.w	$c82,$c92,$da2,$db2,$eb3,$ec3,$fd3,$fe3
	dc.w	$fe3,$fe3,$fe3,$fe3,$fe3,$fe3,$fe3,$fe3
	dc.w	$db2,$dc3,$ed3,$ee4,$ff5,$ee4,$ed3,$dc3

	;town 3
	dc.w	$30c,$01d,$53d,$54d,$74d,$74d,$75d,$76d
	dc.w	$76d,$76d,$76d,$76d,$76d,$76d,$76d,$76d
	dc.w	$64d,$65d,$65d,$77d,$87d,$88d,$88e,$88f


citynum:	dc.w	0
		

		;xpos,ypos,delx,dely
citystart:	dc.w	42,92,2,1
		dc.w	74,108,2,2
		dc.w	106,140,2,-1
		dc.w	154,116,4,0
		dc.w	266,116,1,1
		dc.w	282,132,-4,1
		dc.w	154,164,1,-3
		dc.w	162,140,-1,-1
		dc.w	154,132,-2,1
		dc.w	90,164,-2,2
		dc.w	66,188,4,1
		dc.w	98,196,-2,2
		dc.w	74,220,4,0
		dc.w	154,220,1,-1
		dc.w	170,204,4,1
		dc.w	234,220,0,0


citydx:	dc.w	0
citydy:	dc.w	0
destx:	dc.w	0
desty:	dc.w	0
reach:	dc.w	0

movecity:
	tst.w	stop
	bne	no_more_moving
	tst.w	reach
	bne	no_more_moving

	add.w	#1,mtimer

	move.w	mtimer,d0
	and.w	#31,d0
	tst.w	d0
	bne	not_half
	move.w	citydx,d0
	add.w	d0,blobx
	move.w	citydy,d1
	add.w	d1,bloby
not_half:
	
	bsr	putsprite
	
	move.w	blobx,d0
	cmp.w	destx,d0
	bne	.not_reached
	move.w	bloby,d0
	cmp.w	desty,d0
	bne	.not_reached
	move.w	#1,reach
	move.w	#0,animoff
	move.w	#$ffff,sprechtype
.not_reached

no_more_moving:
	rts

copymapfromfast:
	move.l	map,a0
	move.l	saveplanes,a1
	move.w	#21*256*5-1,d0
coploop:
	move.w	(a0)+,(a1)+
	dbra	d0,coploop

	move.l	map,a0
	move.w	#21*256*5-1,d0
coploop2:
	move.w	(a0)+,(a1)+
	dbra	d0,coploop2
	rts

innen:
	move.l	bitplanes,d0
	add.l	#10*42*5+2,d0

	bsr	waitblit
	move.w	#$0100,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltdpth(a5)
	move.w	#30,bltdmod(a5)
	move.w	#32*5*64+6,bltsize(a5)

	move.l	map,a4
	add.l	#10*42*5+2+42*5*32,a4
	move.l	bitplanes,a6
	add.l	#10*42*5+2+42*5*32,a6
	move.w	#55-32,d4
clrloop:
	move.l	(a4),(a6)
	move.l	4(a4),4(a6)
	move.l	8(a4),8(a6)

	move.l	42(a4),42(a6)
	move.l	46(a4),46(a6)
	move.l	50(a4),50(a6)

	move.l	84(a4),84(a6)
	move.l	88(a4),88(a6)
	move.l	92(a4),92(a6)

	move.l	126(a4),126(a6)
	move.l	130(a4),130(a6)
	move.l	134(a4),134(a6)

	move.l	168(a4),168(a6)
	move.l	172(a4),172(a6)
	move.l	176(a4),176(a6)

	add.l	#42*5,a4
	add.l	#42*5,a6
	dbra	d4,clrloop

	move.l	map,a4
	add.l	#10*42*5+2+42*5*4+9,a4
	move.l	bitplanes,a6
	add.l	#10*42*5+2+42*5*4+9,a6
	move.w	#5*7-1,d0
sun:
	move.b	(a4),(a6)
	add.l	#42,a4
	add.l	#42,a6
	dbra	d0,sun

	move.l	map,a4
	add.l	#10*42*5+2+42*5*43,a4
	move.w	scrolly,d0
	tst.w	stop
	bne	.noadd
	addq.b	#1,d0
.noadd
	and.b	#%11,d0
	move.w	d0,scrolly
	
	bne	lab1
	move.l	#%00000111111111000001111111110000,(a4)
	move.l	#%01111111110000011111111100000111,4(a4)
	move.l	#%11111100000111111111000001111111,8(a4) 
	rts
lab1:
	cmp.b	#1,d0
	bne	lab2
	move.l	#%00111111111000001111111110000011,(a4)
	move.l	#%11111110000011111111100000111111,4(a4)
	move.l	#%11100000111111111000001111111100,8(a4) 
	rts

lab2:	
	cmp.b	#2,d0
	bne	lab3
	move.l	#%11111110000011111111100000111111,(a4)
	move.l	#%11100000111111111000001111111110,4(a4)
	move.l	#%00001111111110000011111111000001,8(a4) 
	rts
	
lab3:	
	move.l	#%11110000011111111100000111111111,(a4)
	move.l	#%00000111111111000001111111110000,4(a4)
	move.l	#%01111111110000011111111000001111,8(a4) 
	rts

scrolly:	dc.w	0


scrollall:
	move.l	#wolken,a1
	bsr	do_wolke
	move.l	#wolken+12,a1
	bsr	do_wolke
	move.l	#wolken+24,a1
	bsr	do_wolke
	move.l	#wolken+36,a1
	bsr	do_wolke


	
	tst.w	stop
	bne	.nosub
	sub.l	#1,berglist
	move.l	berglist,d0
	cmp.l	#-32,d0
	bne	.nichtmin32
	move.l	berglist+8,berglist
	move.l	berglist+12,berglist+4
	move.l	berglist+16,berglist+8
	move.l	berglist+20,berglist+12
	move.l	berglist+24,berglist+16
	move.l	berglist+28,berglist+20
	move.l	#96,berglist+24
	add.l	#2,bergoff
	move.l	bergoff,a0
	move.l	berg1end,d0
	subq.l	#4,d0
	cmp.l	d0,a0
	blt	.notoverberg1
	move.l	berg1tab,bergoff
.notoverberg1
	move.w	(a0),berglist+30
	sub.l	#1,berglist
	move.l	berglist,d0
.nosub
.nichtmin32
	move.l	berglist,d0
	add.l	#16,d0
	move.w	#24,d1
	move.l	berglist+4,d2
	bsr	berg


	tst.w	stop
	bne	.nosub2
	sub.l	#1,berglist+8
.nosub2	move.l	berglist+8,d0
	add.l	#16,d0
	move.w	#24,d1
	move.l	berglist+12,d2
	bsr	berg

	tst.w	stop
	bne	.nosub3
	sub.l	#1,berglist+16
.nosub3	move.l	berglist+16,d0
	add.l	#16,d0
	move.w	#24,d1
	move.l	berglist+20,d2
	bsr	berg

	tst.w	stop
	bne	.nosub4
	sub.l	#1,berglist+24
.nosub4	move.l	berglist+24,d0
	add.l	#16,d0
	move.w	#24,d1
	move.l	berglist+28,d2
	bsr	berg





	tst.w	stop
	bne	.nosub5
	sub.l	#2,berg2list
	move.l	berg2list,d0
	cmp.l	#-32,d0
	bne	.nichtmin32_2
	move.l	berg2list+8,berg2list
	move.l	berg2list+12,berg2list+4
	move.l	berg2list+16,berg2list+8
	move.l	berg2list+20,berg2list+12
	move.l	berg2list+24,berg2list+16
	move.l	berg2list+28,berg2list+20
	move.l	#96,berg2list+24
	add.l	#2,berg2off
	move.l	berg2off,a0
	move.l	berg1end,d0
	subq.l	#4,d0
	cmp.l	d0,a0
	blt	.notoverberg2
	move.l	berg2tab,berg2off
.notoverberg2
	move.w	(a0),berg2list+30
	sub.l	#2,berg2list
	move.l	berg2list,d0
.nosub5
.nichtmin32_2
	move.l	berg2list,d0
	add.l	#16,d0
	move.w	#36,d1
	move.l	berg2list+4,d2
	bsr	berg2

	tst.w	stop
	bne	.nosub6
	sub.l	#2,berg2list+8
.nosub6	move.l	berg2list+8,d0
	add.l	#16,d0
	move.w	#36,d1
	move.l	berg2list+12,d2
	bsr	berg2

	tst.w	stop
	bne	.nosub7
	sub.l	#2,berg2list+16
.nosub7	move.l	berg2list+16,d0
	add.l	#16,d0
	move.w	#36,d1
	move.l	berg2list+20,d2
	bsr	berg2

	tst.w	stop
	bne	.nosub8
	sub.l	#2,berg2list+24
.nosub8	move.l	berg2list+24,d0
	add.l	#16,d0
	move.w	#36,d1
	move.l	berg2list+28,d2
	bsr	berg2


	move.l	#hausklein,a1
	bsr	do_small
	move.l	#hausklein+8,a1
	bsr	do_small
	move.l	#hausklein+16,a1
	bsr	do_small
	move.l	#hausklein+24,a1
	bsr	do_small
	rts
	
scrollall2:
	move.l	#hausgross,a1
	bsr	do_big
	move.l	#hausgross+8,a1
	bsr	do_big
	move.l	#hausgross+16,a1
	bsr	do_big
	move.l	#hausgross+24,a1
	bsr	do_big

	rts
	
	
flups_action:
	bsr	putsprech
	bsr	flups
	rts

next_action:
.restart
	cmp.w	#1,reach
	bne	.still_to_go
	move.w	#1,stop
	move.w	#2,reach
	move.l	wuminger,d1
	move.l	wuminger_m,d2
	move.l	d1,fimage
	move.l	d2,fimage_m
	bsr	puttown
.still_to_go

	cmp.w	#2,reach
	beq	.no_new
	
	move.w	timer,d0
	cmp.w	trigger,d0
	bne	.no_new
	
.restart2
	move.w	animoff,d0
	move.l	animtabpointer,a0
	
	move.w	(a0,d0.w),d1
	cmp.w	#$4711,d1
	beq	.no_new
	
	cmp.w	#-1,d1
	bne	.no_special
	move.l	animtabpointer,specialevent
	add.w	#8,animoff
	move.w	animoff,specialoff
	move.w	#11,d1
	bsr	rnd
	add.w	d0,d0
	add.w	d0,d0
	lea	specials,a0
	move.l	(a0,d0.w),animtabpointer
	move.w	#0,animoff
	move.l	#200,d1
	bsr	rnd
	add.w	#50,d0
	add.w	d0,trigger
	bra	.restart
.no_special

	cmp.w	#-2,d1
	bne	.no_special2
	move.l	specialevent,animtabpointer
	move.w	specialoff,animoff
	bra	.restart2
.no_special2
	
	add.w	d1,trigger
	move.w	2(a0,d0.w),d1
	and.l	#$ffff,d1
	mulu	#6*5*16,d1
	move.l	d1,d2
	add.l	wuminger,d1
	add.l	wuminger_m,d2
	move.l	d1,fimage
	move.l	d2,fimage_m

	move.w	6(a0,d0.w),stop

	move.w	4(a0,d0.w),d1
	cmp.w	#$ffff,d1
	beq	.nosprech
	and.l	#$ffff,d1
	sub.w	#1,d1
	add.w	d1,d1
	add.w	d1,d1
	add.l	#sprechers,d1
	move.l	d1,a1
	move.w	(a1),d1
	and.l	#$ffff,d1
	move.l	d1,d2
	add.l	sprechingers,d1
	add.l	sprechingers_m,d2
	move.l	d1,whatsprech
	move.l	d2,whatsprech2
	move.w	2(a1),sprechtype

	
	bra	.sprech_done
	
.nosprech
	move.w	#$ffff,sprechtype
	
.sprech_done
	add.w	#8,animoff	
.no_new
	rts	




	;timer,sequenz,Sprechinger,stop
anim:	dc.w	10,0,-1,1
	dc.w	5,1,-1,1
	dc.w	5,2,-1,1
	dc.w	50,3,-1,1
	dc.w	100,3,4,1
	dc.w	5,2,-1,1
gleichlos:
	dc.w	1,1,-1,0
	dc.w	-1,0,0,0
	dc.w	5,1,-1,0
	dc.w	$4711


specials:	dc.l	nothing
		dc.l	banana
		dc.l	myname
		dc.l	rightway
		dc.l	gobus
		dc.l	quitefar
		dc.l	jesus
		dc.l	god
		dc.l	fish
		dc.l	rules
		dc.l	love
		dc.l	nothing
		
nothing:	dc.w	200,1,-1,0
		dc.w	-2,0,0,0

gobus:	dc.w	150,1,23,0
	dc.w	-2,0,0,0

jesus:	dc.w	150,1,18,0
	dc.w	-2,0,0,0

god:	dc.w	150,1,22,0
	dc.w	-2,0,0,0

fish:	dc.w	150,1,20,0
	dc.w	-2,0,0,0

rules:	dc.w	150,1,18,0
	dc.w	-2,0,0,0

love:	dc.w	150,1,14,0
	dc.w	-2,0,0,0


rightway:	dc.w	5,1,-1,1
		dc.w	5,2,-1,1
		dc.w	5,3,-1,1
		dc.w	30,4,-1,1,5,3,-1,1,20,2,-1,1
		dc.w	150,3,10,1
		dc.w	5,2,-1,1
		dc.w	-2,0,0,0

quitefar:	dc.w	150,1,6,0
		dc.w	-2,0,0,0
		

myname:	dc.w	5,2,-1,0
	dc.w	150,3,21,0
	dc.w	5,2,-1,0
	dc.w	-2,0,0,0

banana:
	dc.w	5,5,-1,0,5,6,-1,0,5,7,-1,0,5,8,-1,0
	dc.w	5,5,-1,0,5,6,-1,0,5,7,-1,0,5,8,-1,0
	dc.w	5,5,-1,0,5,6,-1,0,5,7,-1,0,5,8,-1,0
	dc.w	5,5,-1,0,5,6,-1,0,5,7,-1,0,5,8,-1,0
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,9,-1,1,5,10,-1,1,5,11,-1,1	
	dc.w	5,0,-1,1
	dc.w	5,1,-1,1
	dc.w	5,2,-1,1
	dc.w	150,3,9,1
	dc.w	5,2,-1,1
	dc.w	-2,0,0,0


trigger:	dc.w	0
animoff:	dc.w	0
whatsprech:	dc.l	0
whatsprech2:	dc.l	0
sprechtype:	dc.w	0
animtabpointer:	dc.l	0
specialevent:	dc.l	0
specialoff:	dc.w	0

		;offset,size(1=klein/2=groﬂ)
		
sprechers:	dc.w	0,1		;K.O.
		dc.w	0,1		;? (muss geaendert werden !!)
		dc.w	0,1		;Leer (muss geaendert werden !!)
		dc.w	12*5*18,1	;Let`s start
		dc.w	12*5*18+4,2	;Those ughly technics
		dc.w	12*5*38,1	;Quite Far
		dc.w	12*5*38+4,2	;12∞ I guess ..
		dc.w	12*5*58,1	;One second
		dc.w	12*5*58+4,2	;*$%& I hate Bananas
		dc.w	12*5*78,1	;Right way ?	
		dc.w	12*5*78+4,2	;Hope fishes don
		dc.w	12*5*98,1	;I`m off		
		dc.w	12*5*98+4,2	;Come on .. !
		dc.w	12*5*118,1	;I love ...
		dc.w	12*5*118+4,2	;Are u deaf ..
		dc.w	12*5*138,1	;Chr.. Chr..
		dc.w	12*5*138+4,2	;No way !
		dc.w	12*5*158,1	;Jesus Rules
		dc.w	12*5*158+4,2	;OK ! You win.
		dc.w	12*5*178,1	;Fisch
		dc.w	12*5*178+4,2	;My name is Jean
		dc.w	12*5*198,1	;God is king
		dc.w	12*5*198+4,2	;Next Time i go
		dc.w	12*5*218,1	;-----
		dc.w	12*5*218+4,2	;Heaven ! The T1000


putsprite:
	move.w	blobx,d0
	move.w	bloby,d1
	lea	blobbo,a0
	lea	blobbo+28,a1

	move.w	d1,d2
	lsl.w	#8,d2
	
	move.w	d0,d3
	lsr.w	#1,d3
	or.w	d3,d2
	
	move.w	d2,(a0)		;erstes Kontrollwort
	
	move.w	d1,d3
	add.w	#5,d3
	subq.w	#1,d3
	move.w	d3,d2
	lsl.w	#8,d3
	or.b	#$80,d3		;Attach Bit
	
	lsr.w	#7,d2
	and.b	#%10,d2
	or.b	d2,d3
	
	move.b	d0,d2
	and.b	#1,d2
	or.b	d2,d3
	
	move.w	d1,d2
	lsr.w	#6,d2
	and.b	#%100,d2
	or.b	d2,d3
	
	move.w	d3,2(a0)	;zweites Kontrollwort

	move.l	(a0),(a1)
	
	rts

	
do_small:
	tst.w	stop
	bne	.nosub
	sub.l	#3,(a1)
	move.l	(a1),d0
	cmp.l	#-16,d0
	bgt	nichtmin16_1
	add.l	#96+16,(a1)
	move.w	#8,d1
	bsr	rnd
	move.w	d0,6(a1)
	sub.l	#2,(a1)
.nosub
nichtmin16_1:
	move.l	(a1),d0
	add.l	#16,d0
	move.l	4(a1),d2
	bsr	haus_baum_klein
	rts

do_wolke:
	tst.w	stop
	bne	.nosub
	not.w	8(a1)
	tst.w	8(a1)
	beq	nichtmin16_3
	sub.l	#1,(a1)
.nosub
	move.l	(a1),d0
	cmp.l	#-16,d0
	bgt	nichtmin16_3
	add.l	#96+16,(a1)
	move.w	#3,d1
	bsr	rnd
	move.w	d0,6(a1)
	sub.l	#2,(a1)
nichtmin16_3:
	move.l	(a1),d0
	add.l	#16,d0
	move.l	4(a1),d2
	bsr	wolke
	rts


do_big:
	tst.w	stop
	bne	.nosub
	sub.l	#4,(a1)
	move.l	(a1),d0
	cmp.l	#-32,d0
	bgt	nichtmin16_2
	add.l	#96+32,(a1)
	move.w	#8,d1
	bsr	rnd
	move.w	d0,6(a1)
	sub.l	#2,(a1)
.nosub
nichtmin16_2:
	move.l	(a1),d0
	add.l	#16,d0
	move.w	#45,d1
	move.l	4(a1),d2
	bsr	haus_baum_gross
	rts


clrleftright:
	move.l	bitplanes,d0
	add.l	#10*42*5+2+12,d0

	bsr	waitblit
	move.w	#$0100,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltdpth(a5)
	move.w	#38,bltdmod(a5)
	move.w	#56*5*64+2,bltsize(a5)

	move.l	bitplanes,d0
	add.l	#10*42*5-2,d0

	bsr	waitblit
	move.w	#$0100,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltdpth(a5)
	move.w	#38,bltdmod(a5)
	move.w	#56*5*64+2,bltsize(a5)

	move.l	map,a4
	add.l	#10*42*5+2+12,a4
	move.l	bitplanes,a6
	add.l	#10*42*5+2+12,a6
	move.w	#55,d0
right:
	move.b	(a4),(a6)
	move.b	42(a4),42(a6)
	move.b	84(a4),84(a6)
	move.b	126(a4),126(a6)
	move.b	168(a4),168(a6)
	add.l	#42*5,a4
	add.l	#42*5,a6
	dbra	d0,right

	move.l	map,a4
	add.l	#10*42*5+1,a4
	move.l	bitplanes,a6
	add.l	#10*42*5+1,a6
	move.w	#55,d0
left:
	move.b	(a4),(a6)
	move.b	42(a4),42(a6)
	move.b	84(a4),84(a6)
	move.b	126(a4),126(a6)
	move.b	168(a4),168(a6)
	add.l	#42*5,a4
	add.l	#42*5,a6
	dbra	d0,left
	rts

flups:
	move.l	fimage,d2
	move.l	fimage_m,d3
	move.w	#64,d0
	move.w	#43,d1
	add.l	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	#$0ff2,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#4,bltamod(a5)
	move.w	#4,bltbmod(a5)
	move.w	#40,bltcmod(a5)
	move.w	#40,bltdmod(a5)
	move.w	#16*5*64+1,bltsize(a5)
	rts


wolke:
	cmp.w	#3,d2
	bne	wolkenot3
	rts
wolkenot3:
	add.b	d2,d2
	add.b	d2,d2
	move.w	#13,d1
	move.l	d2,d3
	add.l	wolkinger,d2
	add.l	wolkinger_m,d3
	add.l	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#20,bltamod(a5)
	move.w	#20,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#7*5*64+2,bltsize(a5)
	rts

	
putsprech:
	cmp.w	#$ffff,sprechtype
	bne	.is_eine
	rts
.is_eine
	cmp.w	#1,sprechtype
	beq	blase_klein
	cmp.w	#2,sprechtype
	beq	blase_gross
	rts

blase_klein:
	move.w	#64,d0
	move.w	#27,d1
	move.l	whatsprech,d2
	move.l	whatsprech2,d3
	add.w	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	#$0ff2,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#8,bltamod(a5)
	move.w	#8,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#19*5*64+2,bltsize(a5)
	rts

blase_gross:
	move.w	#32,d0
	move.w	#27,d1
	move.l	whatsprech,d2
	move.l	whatsprech2,d3
	add.w	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	#$9ff2,bltcon0(a5)
	move.w	#$9000,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#4,bltamod(a5)
	move.w	#4,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#19*5*64+4,bltsize(a5)
	rts



berg:
	tst.l	grossberg
	beq	.nobigberg
	add.l	#32,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#4,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	or.w	#$0dfc,d4
	add.l	grossberg,d2
	bsr	waitblit
	move.w	d4,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#30,bltamod(a5)
	move.w	#36,bltbmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#18*5*64+3,bltsize(a5)
.nobigberg
	rts


berg2:
	move.l	d2,d3
	add.l	kleinberg,d2
	add.l	kleinberg_m,d3
	add.l	#32,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#4,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#30,bltamod(a5)
	move.w	#30,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#6*5*64+3,bltsize(a5)
	rts

haus_baum_klein:
	cmp.w	#2,d2
	bgt	notzero
	rts
notzero:
	cmp.w	#3,d2
	bne	nottwo
	move.l	#4+2+4+2+4+2+4+4+6,d2
	move.l	#4+2+4+2+4+2+4+4+6,d3
	bra	oktouse
nottwo:
	move.l	#4+2+4+2+4+2+4,d2
	move.l	#4+2+4+2+4+2+4,d3
oktouse:
	tst.l	smallhouse
	beq	.nosmallhouse
	move.w	#36,d1
	move.l	d2,d3
	add.l	smallhouse,d2
	add.l	smallhouse_m,d3
	add.l	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#32,bltamod(a5)
	move.w	#32,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#18*5*64+2,bltsize(a5)
.nosmallhouse
	rts


haus_baum_gross:
	cmp.w	#2,d2
	bge	notzero2
	rts
notzero2:
	cmp.w	#3,d2
	bne	nottwo2
	move.l	#4+2+4+2+4+2+4+4,d2
	move.l	#4+2+4+2+4+2+4+4,d3
	bra	oktouse3
nottwo2:
	move.l	#4+2+4+2+4+2,d2
	move.l	#4+2+4+2+4+2,d3
oktouse2:
	tst.l	smallhouse
	beq	.nosmallhouse
	move.w	#45,d1
	move.l	d2,d3
	add.l	smallhouse,d2
	add.l	smallhouse_m,d3
	add.l	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#32,bltamod(a5)
	move.w	#32,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#21*5*64+2,bltsize(a5)
.nosmallhouse
	rts
oktouse3:
	tst.l	bighouse
	beq	.nobighouse
	move.w	#40,d1
	move.l	d2,d3
	add.l	bighouse,d2
	add.l	bighouse_m,d3
	add.l	#16,d0
	mulu	#210,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#30,bltamod(a5)
	move.w	#30,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#24*5*64+3,bltsize(a5)
.nobighouse
	rts



;**********************************************************
;* random number generator 
;*
;* d1.w	max. number
;*
;* result:
;* d0.w random number 
;**********************************************************

rnd:
	movem.w	d1-d2,-(a7)
	move.w	number,d0
	mulu	#221,d0
	addq.w	#1,d0
	move.w	$dff014,d2
	move.w	$dff006,d3
	eor.w	d3,d2
	move.w	$dff004,d3
	eor.w	d3,d2
	eor.w	d2,d0
	move.w	d0,number
	and.l	#$ffff,d0
	divu	d1,d0
	move.w	#0,d0
	swap	d0
	btst	#2,$dff006
	bne	noadd
	addq.w	#1,d0
noadd:
	movem.w	(a7)+,d1-d2
	rts

number:		dc.w	0


oldcopperbase:
	move.l	#$dff000,a5
	move.w	#$03e0,dmacon(a5)
	move.l	oldcopper,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83e0,dmacon(a5)
	rts

paintcopper:
	move.l	#$dff000,a5
	move.w	#$03c0,dmacon(a5)
	move.l	copperbase,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$2081,diwstrt(a5)
	move.w	#$2fc1,diwstop(a5)
	move.w	#$0038,ddfstrt(a5)
	move.w	#$00d0,ddfstop(a5)
	move.w	#$83e0,dmacon(a5)

	move.l	#0,$144(a5)
	move.l	#0,$14c(a5)
	move.l	#0,$154(a5)
	move.l	#0,$15c(a5)
	move.l	#0,$164(a5)
	move.l	#0,$16c(a5)
	move.l	#0,$174(a5)
	move.l	#0,$17c(a5)
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

inssprite:
	swap	d0
	move.w 	d1,(a0)+
	move.w	d0,(a0)+
	swap	d0
	add.w	#2,d1	
	move.w 	d1,(a0)+
	move.w	d0,(a0)+
	rts



make_paint_copperlist:
	move.l	copperbase,a0	
	move.w	#$0001,(a0)+
	move.w	#$ff00,(a0)+
	move.w	#dmacon,(a0)+
	move.w	#$0100,(a0)+
	move.w	#bplcon0,(a0)+
	move.w	#$5000,(a0)+
	move.w	#bplcon1,(a0)+
	move.w	#0,(a0)+
	move.w	#bplcon2,(a0)+
	move.w	#%100100,(a0)+
	move.w	#bpl1mod,(a0)+
	move.w	#170,(a0)+
	move.w	#bpl2mod,(a0)+
	move.w	#170,(a0)+

	move.l	a0,savea0

	move.l	map,a1
	add.l	#42*256*5,a1
	move.l	#$0180,d0
cloop:
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#2,d0
	cmp.w	#$01c0,d0
	bne	cloop

	move.l	a0,savesprite
	
	move.l	#blobbo,d0
	move.w	#spr0pt,d1
	bsr	inssprite
	move.l	#blobbo+28,d0
	move.w	#spr1pt,d1
	bsr	inssprite
	
	move.l	#offsprite,d0
	move.w	#spr2pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr3pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr4pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr5pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr6pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr7pt,d1
	bsr	inssprite

	move.w	#$2701,(a0)+
	move.w	#$ff00,(a0)+

	move.l	a0,savea02	; Graphic screen

	move.l	bitplanes,d0
	move.w 	#bpl1ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl1pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl2ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl2pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl3ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl3pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl4ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl4pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl5ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl5pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	move.w	#$2601,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#dmacon,(a0)+
	move.w	#$83c0,(a0)+


	lea	himmelcolors,a1

	move.w	#$31,d0
.bcol
	move.w	d0,d1
	lsl.w	#8,d1
	move.b	#$45,d1
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a1)+,(a0)+

	add.b	#50,d1
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$087f,(a0)+

	add.w	#1,d0
	cmp.w	#$51,d0
	bne	.bcol


	move.l	a0,savebodenfarbe

	move.w	#$51,d0
.bcol2
	move.w	d0,d1
	lsl.w	#8,d1
	move.b	#$45,d1
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$0fff,(a0)+

	add.b	#52,d1
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$087f,(a0)+

	add.w	#1,d0
	cmp.w	#$69,d0
	bne	.bcol2

	move.l	#$ffe1fffe,(a0)+

	move.w	#$2501,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#bplcon0,(a0)+
	move.w	#$0000,(a0)+

	move.l	#$fffffffe,(a0)
	rts

savebodenfarbe:	dc.l	0

switch:
	move.l	savea02,a0

	move.l	bitplanes,d0
	move.w 	#bpl1ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl1pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl2ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl2pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl3ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl3pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl4ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl4pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#42,d0
	move.w 	#bpl5ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl5pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	move.l	bitplanes,d0
	move.l	bitplanes2,bitplanes
	move.l	d0,bitplanes2

	move.l	bitplanes,activeplanes
	rts

waitblit:
	move.l	gfxbase,a6
	jsr	-228(a6)
	rts


*****************************************
* Pro-Packer v2.1 Replay-Routine.	*
* Based upon the PT1.1B-Replayer	*
* by Lars 'ZAP' Hamre/Amiga Freelancers.*
* Modified by Estrup/Static Bytes.	*
*****************************************

mt_lev6use=		1		; 0=NO, 1=YES
mt_finetuneused=	0		; 0=NO, 1=YES

mt_init
	tst.w	mactive
	beq	.ok2init
	rts
.ok2init
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
mt_end
	tst.w	mactive
	beq	.nomusic
	LEA	$DFF096,A0
	CLR.W	$12(A0)
	CLR.W	$22(A0)
	CLR.W	$32(A0)
	CLR.W	$42(A0)
	MOVE.W	#$F,(A0)
	move.w	#0,mactive
.nomusic
	RTS

mt_music
	MOVEM.L	D0-D4/D7/A0-A6,-(SP)
	lea	mt_speed(PC),A4
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


berg1end:	dc.l	0
berg1tab:	dc.l	0
berg2end:	dc.l	0
berg2tab:	dc.l	0

somedata	dc.l	0,0,32,6,64,12,96,0

bergoff:	dc.l	scrolldat1
berglist:	dc.l	0,0,32,6,64,12,96,0

scrolldat1:	dc.w	6,12,6,12,6,12,6,12,6,12,6,12,6,12,6,12,6,12,6,12
scrollende1:	dc.w	6,12

berg2off:	dc.l	scrolldat1
berg2list:	dc.l	0,0,32,6,64,12,96,0

scrolldat2:	dc.w	6,0,6,12,0,6,0,6,12,6,0,0,6,0,6,0,6,12,6,0,6,0,0
		dc.w	6,0,6,0,0,6,0,6,12,6,0,0,6,0,6,0,6,12,6,0,6,0,0
		dc.w	6,0,6,12,0,6,0,6,12,6,0,12,6,0,6,0,6,12,6,0,6,0,0
scrollende2:	dc.w	6,6
			

hausklein:	dc.l	0,0,32,3,64,4,96,4

hausgross:	dc.l	0,0,16,4,48,1,80,0

wolken:		dc.l	0,0,0
		dc.l	32,1,0
		dc.l	64,2,0
		dc.l	96,3,0			
	
		incdir	"dh0:assem/nibbly2/"


copperbase:	dc.l 0
bitplanes:	dc.l 0
bitplanes2:	dc.l 0
activeplanes:	dc.l 0
savea0:		dc.l 0
savea02:	dc.l 0
savecopper:	dc.l 0
oldcopper:	dc.l 0
gfxbase:	dc.l 0
dosbase:	dc.l 0
savesprite:	dc.l 0
saveplanes:	dc.l 0

stop:		dc.w 0

town:		dc.l	0

fimage:		dc.l	0
fimage_m:	dc.l	0
timer:		dc.w	0
mtimer:		dc.w	0
blobx:		dc.w	0
bloby:		dc.w	0

grossberg:	dc.l	0
kleinberg:	dc.l	0
kleinberg_m:	dc.l	0
bighouse:	dc.l	0
bighouse_m:	dc.l	0
smallhouse:	dc.l	0
smallhouse_m:	dc.l	0

jingle1:	dc.w	0
jingle2:	dc.w	0
music:		dc.w	0
mactive:	dc.w	0
mustime:	dc.w	0
map:		dc.l	0

mapgfx:		dc.l	0
animations1:	dc.l	0
animations1_m:	dc.l	0
wuminger:	dc.l	0
wuminger_m:	dc.l	0
wolkinger:	dc.l	0
wolkinger_m:	dc.l	0
sprechingers:	dc.l	0
sprechingers_m:	dc.l	0


gfxname:	dc.b	"graphics.library",0
	even
dosname:	dc.b	"dos.library",0
	even

		incdir	"dh0:lo-res/nibbly2/"

crmap:		incbin	"landmap_336x256x5.pak"
		even


offsprite:	dc.w	0,0

		incdir	"p1:assem/nibbly/sound/"

mt_main:	dc.l	0
mt_jingle1:	dc.l	0	
mt_jingle2:	dc.l	0

cdata:		dc.l	0

		SECTION Daten,DATA_C

blobbo:
sspr1:	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000

sspr2:	dc.w	$0000,$0000
	dc.w	$6000,$6000
	dc.w	$F000,$9000
	dc.w	$F000,$9000
	dc.w	$6000,$6000
	dc.w	$0000,$0000
	dc.w	$0000,$0000

;gfxpak:
;xanimations1:	incbin	"animations1_288x102x5.rb"
;xanimations1_m:	incbin	"animations1_288x102x5.mask"
;xwuminger:	incbin	"wuminger_48x208x5.rb"
;xwuminger_m:	incbin	"wuminger_48x208x5.mask"
;xwolkinger:	incbin	"wolkinger_192x14x5.rb"
;xwolkinger_m:	incbin	"wolkinger_192x14x5.mask"
;xsprechingers:	incbin	"sprechingers_96x238x5.rb"
;xsprechingers_m:	incbin	"sprechingers_96x238x5.mask"
gfxend:

eoa:
;* END *
