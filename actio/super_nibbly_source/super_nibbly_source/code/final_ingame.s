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
color0:		equ	$dff1c0
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

GFXSIZE  = 40*182*4*9+40*182		;9 gamescreens 320x182x4
					;1 plane maskbuffer
				 
HEADLEFT  = 6*4*44
HEADUP    = 6*4*66
HEADRIGHT = 0
HEADDOWN  = 6*4*22

	;		SECTION Prog,CODE_C

j:
	move.l	a7,savepc

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
	
	move.l	sharemem,a0
	move.l	24(a0),oldcopper

	move.l	4.w,a6
	move.l	#0,a1
	jsr	-294(a6)	;findtask
	move.l	sharemem,a0
	move.l	d0,16(a0)

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
	move.l	d1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-318(a6)	;wait

	move.l	sharemem,a0
	cmp.w	#0,2(a0)
	beq	noshare
	cmp.w	#2,2(a0)
	bne	restart
	
			
	move.l	sharemem,a0
	move.w	6(a0),d0
	move.w	d0,levelcounter+2
	
	bra	the_game
	

goto_map:	
	move.l	savepc,a7
	bsr	cleanup

	tst.w	mustquit
	bne	special_event
	
	move.l	sharemem,a0
	move.w	levelcounter+2,6(a0)
	
	move.l	sharemem,a0
	move.w	#1,2(a0)	
	move.l	sharemem,a0
	move.w	#2,4(a0)

	move.l	sharemem,a0
	move.l	12(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)
	
	bra	restart


special_event
	move.l	sharemem,a0
	move.w	mustquit,(a0)
	move.w	#1,2(a0)
	move.w	#1,4(a0)

	move.l	20(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal

	bra	restart
	
	

noshare:
	move.l  gfxbase,a1
        move.l  4,a6
	jsr	closelibrary(a6)

	move.l	#0,d0
	rts


savepc:	dc.l	0
sharemem:	dc.l	0
mustquit:	dc.w	0


the_game:

	move.w	#0,mustquit

	
	move.l	#-1,lastlevel
	move.w	#0,statecount
	move.w	#-1,musicinmem
	move.w	#0,firsttime
	move.w	$dff014,number
	move.w	$dff006,d0
	eor.w	d0,number
	move.w	$dff004,d0
	eor.w	d0,number

	move.w	#$aa6,floor+2*16*4
	lea	$dff000,a5
	move.l	execbase,a6
	jsr	forbid(a6)

	move.l	#GFXSIZE,d0
	move.l	#$10002,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,bitplanes
	tst.l	d0
	beq	error

	add.l	#40*182*4*9,d0
	move.l	d0,maskbuffer


	move.l	#40*182*4,d0
	move.l	#$2,d1		;Chip
	jsr	allocmem(a6)
	move.l	d0,restorebuffer
	tst.l	d0
	beq	error

	move.l	#35500,d0
	move.l	#$1,d1	
	jsr	allocmem(a6)
	move.l	d0,mainmusic
	tst.l	d0
	beq	error

	move.l	#35500,d0
	move.l	#$2,d1	
	jsr	allocmem(a6)
	move.l	d0,mt_data
	tst.l	d0
	beq	error

	move.l	#1000,d0
	move.l	#$10002,d1	;CLR & CHIP
	jsr	allocmem(a6)
	move.l	d0,copperbase


	jsr	make_paint_copperlist
	jsr	paintcopper

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	move.l	#$ffffffff,bltafwm(a5)

	bsr	initlevel

main:
	btst	#7,$bfe001
	bne	notfire

	tst.w	pucks
	beq	.no_puck_available
	bsr	do_puck
.no_puck_available

notfire:
	move.b	$bfe001,button

	cmp.b	#$cd,$bfec01
	bne	nopause

	bsr	music_off

.releasekey
	cmp.b	#$cd,$bfec01
	beq	.releasekey


	move.l	usedcolors,a1
	add.l	#48,a1

	move.l	savea0,a0
	move.l	#$0180,d0
.cloop1
	move.b	(a1)+,d3
	lsr.w	#4,d3
	and.w	#$f,d3
	sub.b	#8,d3
	bpl	.ok1
	move.w	#0,d3
.ok1
	lsl.w	#8,d3
	move.b	(a1)+,d4
	lsr.w	#4,d4
	and.w	#$f,d4
	sub.b	#8,d4
	bpl	.ok2
	move.w	#0,d4
.ok2
	lsl.w	#4,d4
	or.w	d4,d3
	move.b	(a1)+,d1
	lsr.w	#4,d1
	and.w	#$f,d1
	sub.b	#8,d1
	bpl	.ok3
	move.w	#0,d1
.ok3
	or.w	d1,d3
	
	move.w	d0,(a0)+
	move.w	d3,(a0)+
	add.w	#2,d0
	

	tst.w	flashscreen
	beq	.nodark1
	cmp.w	#$19a,d0
	beq	.exit1
	cmp.w	#$184,d0
	bne	.nodark1
	add.w	#4,d0
	lea	8(a0),a0
	lea	6(a1),a1
.nodark1
	
	cmp.w	#$01a2,d0
	bne	.cloop1
.exit1

.conplay
	cmp.b	#$45,$bfec01
	bne	.nocheat2
	btst	#7,$bfe001
	bne	.nocheat2
	move.w	#1,cheat
	move.w	#$fff,$dff180
.nocheat2
	cmp.b	#$cd,$bfec01
	bne	.conplay

.releasekey2
	cmp.b	#$cd,$bfec01
	beq	.releasekey2

	move.l	usedcolors,a1
	add.l	#48,a1

	move.l	savea0,a0
	move.l	#$0180,d0
.cloop2
	move.w	#0,d1
	move.b	(a1)+,d1
	lsl.w	#4,d1
	or.b	(a1)+,d1
	lsl.w	#4,d1
	or.b	(a1)+,d1
	lsr.w	#4,d1
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	add.w	#2,d0

	tst.w	flashscreen
	beq	.nodark2
	cmp.w	#$19a,d0
	beq	.exit2
	cmp.w	#$184,d0
	bne	.nodark2
	add.w	#4,d0
	lea	8(a0),a0
	lea	6(a1),a1
.nodark2

	cmp.w	#$01a2,d0
	bne	.cloop2
.exit2

	bsr	music_on
nopause:


	cmp.b	#77,$bfec01
	bne	.notf10
	move.w	#0,addlifes
	move.w	#0,islifes
	move.w	#2,died
.notf10

	cmp.b	#$75,$bfec01
	bne	.notesc
	tst.w	died
	bne	.notesc
	move.w	#2,died
.notesc

	bsr	dospecialsprite
	bsr	showspecialsprite
	bsr	doexplosion

	bsr	togglesprite
	
	bsr	sizefruit
	bsr	nextextra
	add.w	#1,timer


	tst.w	cheat
	beq	.nocheat
	move.w	#0,cheat
	add.l	#1,levelcounter
	move.w	#1,addlifes
	cmp.l	#60,levelcounter
	bne	.normal
	move.w	#2,mustquit
	bra	bogomier	
.normal
	bsr	music_off
	bsr	initlevel
.nocheat

	bra	joystick
return:

	tst.w	died
	beq	stillalive
	cmp.w	#2,died
	beq	.der_is_tot
	cmp.w	#2,nummoves
	bne	stillalive
.der_is_tot
	bsr	music_off

	lea	jingle_ouch,a0
	move.l	mt_data,a1
	move.l	#15000/2,d0
.muscopy
	move.w	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.muscopy

	bsr	stop_sound

	move.w	#0,player4
	bsr	music_on

	sub.w	#1,addlifes
	move.w	islifes,d1
	add.w	addlifes,d1
	tst.w	d1
	bmi	.nomoreleben
	bsr	showohno
	bra	.nochlife
.nomoreleben
	bsr	showgameover
	move.w	#1,mustquit
.nochlife

	move.l	#130-32,d0
.waitmusic
	bsr	vposup
	sub.l	#1,d0
	bne	.waitmusic
	
	
	bsr	music_off	

	tst.w	mustquit
	bne	bogomier
	
	bsr	initlevel
stillalive:

	;btst	#7,$bfe001
	;beq	faster
	bsr	vposup
;faster:

	bsr	soundmanager

	bsr	showscore

	tst.b	time
	bne	still_enough_time
	tst.w	timec
	bne	still_enough_time
	move.w	#6,whichsound
	;move.w	#1,force
still_enough_time:

	tst.w	moving
	beq	no_switching
	move.w	#$0a0,color0
	bsr	switch
	bsr	moveflups
	bsr	showscreen

	tst.w   movedone
	beq	no_switching
	move.w	#0,movedone
	tst.w	numfruits
	bne	no_switching
leveldone:
	add.l	#1,levelcounter
	bsr	music_off

	lea	jingle_welldone,a0
	move.l	mt_data,a1
	move.l	#30000/2,d0
.muscopy
	move.w	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.muscopy

	move.w	#0,player4
	bsr	music_on

	bsr	showwelldone

	move.l	#150-32,d0
.waitmusic
	bsr	vposup
	sub.l	#1,d0
	bne	.waitmusic
	
	bsr	music_off
	cmp.l	#60,levelcounter
	bne	.normal
	move.w	#2,mustquit
	bra	bogomier	
.normal
	bsr	initlevel
no_switching:

	tst.w   movedone
	beq	not_end_of_level
	move.w	#0,movedone
	tst.w	numfruits
	bne	no_switching
	bra	leveldone
not_end_of_level

	tst.w	moving
	bne	.no_potion
	tst.w	gelbtrank
	beq	.no_yellow_potion
.more_schrumpf2
	move.w	#500,sspeed
	move.w	gelbtrank,d0
	lsl.w	#4,d0
	sub.w	d0,sspeed
	bsr	schrumpf
	cmp.w	#1,flupssize
	beq	.schrumpf_ende
	add.w	#1,gelbtrank
	cmp.w	#17,gelbtrank
	bne	.more_schrumpf2
.schrumpf_ende
	move.w	#0,gelbtrank
.no_yellow_potion

	tst.w	turktrank
	beq	.no_cyan_potion
	move.w	#200,sspeed
.more_schrumpf
	move.w	flupssize,d0
	lsl.w	#4,d0
	add.w	d0,sspeed
	bsr	schrumpf
	cmp.w	#1,flupssize
	bne	.more_schrumpf
	move.w	#0,turktrank
.no_cyan_potion
.no_potion

	bsr	flashout
	bsr	flashin

	move.l	savea0,a0
	move.w	2(a0),color0

bogomier:	
	
	;btst	#6,$bfe001		;Test for quit
	tst.w	mustquit
	beq	main
	move.l	savepc,a7
	bra	goto_map
	

cleanup:
	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)

	bsr	stop_sound
	tst.w	musicstatus
	beq	.nostop
	bsr	music_off
.nostop

	LEA	$DFF096,A0
	CLR.W	$12(A0)
	CLR.W	$22(A0)
	CLR.W	$32(A0)
	CLR.W	$42(A0)

	move.l	execbase,a6
	jsr	permit(a6)

	move.l	#$dff000,a5
	jsr	oldcopperbase

	move.l	execbase,a6
	move.l	mainmusic,a1
	move.l	#35500,d0
	jsr	freemem(a6)
	move.l	mt_data,a1
	move.l	#35500,d0
	jsr	freemem(a6)
	move.l	bitplanes,a1
	move.l	#GFXSIZE,d0
	jsr	freemem(a6)
	move.l	copperbase,a1
	move.l	#1000,d0 
	jsr	freemem(a6)
	move.l	restorebuffer,a1
	move.l	#40*182*4,d0
	jsr	freemem(a6)

quit:
	moveq	#00,d0
	rts


music_on:
	move.l	mt_data,a0
	jsr	mt_init
	move.l	$6c.w,oldvbl+2
	move.l	#newvbl,$6c.w
	move.w	#1,musicstatus
	rts
	
music_off:
	move.l	oldvbl+2,$6c.w
	jsr	mt_end
	move.w	#1,musicstatus
	rts	
	
	
	
newvbl:
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	mt_music
	movem.l	(sp)+,d0-d7/a0-a6
oldvbl:
	jmp	0

cheat:	dc.w	0


button:	dc.w	0

error:
	move.l	#10000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts

nextextra:
	move.w	timer,d0
	move.w	nexttrigger,d1
	cmp.w	d1,d0
	blt	noch_zu_frueh	

	tst.w	moving
	bne	nicht_mitten_drin

	tst.w	extraaktiv
	bne	.no_more_init_extra
	move.w	#1,extraaktiv
	move.l	extrapointer,a0
	move.b	(a0)+,d0
	move.l	a0,extrapointer
	and.l	#$ff,d0
	cmp.b	#0,d0
	bne	.extra_is_ok
	add.w	#512,nexttrigger
	move.w	#0,extraaktiv
	rts	
.extra_is_ok
	cmp.w	#1,flashscreen
	bne	.no_flasher
	move.w	#11,d0
.no_flasher
	move.w	d0,extratype
	bsr	getsprite
.no_more_init_extra

	cmp.w	#1,extraaktiv
	bne	.no_pos_needed
	bsr	getspritepos
	move.w	#2,extraaktiv
.no_pos_needed

	cmp.w	#2,extraaktiv
	bne	is_on_screen
	bsr	showsprite	
	move.w	#2,whichsound
	move.w	#1,force
	move.w	#3,extraaktiv
is_on_screen

	cmp.w	#3,extraaktiv
	bne	.noch_nicht_bereit
	move.w	nexttrigger,d1
	add.w	#400,d1
	move.w	timer,d0
	cmp.w	d1,d0
	blt	.noch_nicht_bereit
	move.w	#0,togenable
	move.l	#0,d0
	bsr	getsprite
	bsr	showsprite
	add.w	#512,nexttrigger
	move.w	#0,extraaktiv
	move.w	#3,whichsound
	move.w	#1,force
	move.l	spritex,explx
 	move.w	#1,expltype
.noch_nicht_bereit


nicht_mitten_drin
	cmp.w	#3,extraaktiv
	bne	.extra_taken
	move.w	spritex,d0
	move.w	spritey,d1
	addq.w	#1,d0
	addq.w	#1,d1
	lsl.w	#4,d0
	lsl.w	#4,d1
	
	move.w	clrxpos,d2
	move.w	clrxpos+2,d3
	
	cmp.w	d0,d2
	bne	.extra_taken
	cmp.w	d1,d3
	bne	.extra_taken
	move.l	#0,d0
	bsr	getsprite
	bsr	showsprite
	add.w	#512,nexttrigger
	move.w	#0,extraaktiv
	move.w	#4,whichsound
	move.w	#1,force

	move.w	extratype,d0	;Extra ausführen	
	cmp.w	#1,d0
	bne	.nix_puck
	add.w	#1,addpucks
.nix_puck
	cmp.w	#2,d0
	bne	.nix_kopf
	move.w	#2,died
.nix_kopf
	cmp.w	#3,d0
	bne	.nix_gtrank
	move.w	#1,gelbtrank
.nix_gtrank
	cmp.w	#4,d0
	bne	.nix_ttrank
	move.w	#1,turktrank
.nix_ttrank
	cmp.w	#5,d0
	bne	.nix_life
	add.w	#1,addlifes
.nix_life
	cmp.w	#6,d0
	bne	.nix_frucht
	
	cmp.w	#1,fruitextra
	bne	.not_nr_100
	add.l	#100,addscore
	move.w	#1,is_a_fruit
.not_nr_100
	cmp.w	#2,fruitextra
	bne	.not_nr_200
	add.l	#200,addscore
	move.w	#2,is_a_fruit
.not_nr_200
	cmp.w	#3,fruitextra
	bne	.not_nr_400
	add.l	#400,addscore
	move.w	#3,is_a_fruit
.not_nr_400
	cmp.w	#4,fruitextra
	bne	.not_nr_800
	add.l	#800,addscore
	move.w	#4,is_a_fruit
.not_nr_800
	cmp.w	#5,fruitextra
	bne	.not_nr_life
	add.w	#1,addlifes
	move.w	#5,is_a_fruit
.not_nr_life
	add.w	#1,fruitextra
	cmp.w	#6,fruitextra
	bne	.nix_frucht
	move.w	#1,fruitextra
.nix_frucht
	cmp.w	#7,d0
	bne	.nix_solved
	move.w	#0,numfruits
.nix_solved
	cmp.w	#8,d0
	bne	.nix_time
	add.w	#40,addtime
.nix_time
	cmp.w	#9,d0
	bne	.nix_shrink
	move.w	#0,togenable
	move.w	togsprite,d0
	tst.w	d0
	bne	.isbig
	move.b	#1,fruittype+1
	bra	.nix_shrink
.isbig
	move.b	#$ff,fruittype+1
.nix_shrink
	cmp.w	#1,flashscreen
	bne	.nix_flash
	move.w	#1,has2flash
.nix_flash

.extra_taken
	
noch_zu_frueh
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
		move	d7,$180(a6)
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

closedos:
	move.l	execbase,a6
	move.l	dosbase,a1
	jsr	closelibrary(a6)
	rts

handle:	dc.l	0

closefile:
	move.l	handle,d1
	move.l	dosbase,a6
	jsr	-36(a6)		;close
	rts

musicinmem:	dc.w	-1

loadmusic:
	move.l	levelcounter,d0
	lsr.w	#2,d0
	divu	#5,d0
	swap	d0
	add.w	d0,d0
	add.w	d0,d0

	cmp.w	musicinmem,d0
	beq	noload

	move.w	d0,musicinmem

	lea	mustab,a0
	move.l	(a0,d0.w),d1

	move.l	d1,-(sp)

	bsr	opendos

	move.l	(sp)+,d1
	move.l	#1005,d2
	move.l	dosbase,a6
	jsr	-30(a6)		;open
	tst.l	d0
	beq	fileerror
	move.l	d0,handle	

	move.l	handle,d1
	move.l	mainmusic,d2
	move.l	#34900,d3
	move.l	dosbase,a6
	jsr	-42(a6)		;read

	bsr	closefile

	bsr	closedos
	move.l	4.w,a6
	jsr	forbid(a6)
noload:
	rts


fileerror:
	move.l	#100000,d0
.ferloop:
	move.w	#$f00,$dff180
	move.w	#$000,$dff180
	sub.l	#1,d0
	bne	.ferloop
	move.l	4.w,a6
	jsr	forbid(a6)
	rts

mustab:
	dc.l	music3
	dc.l	music2
	dc.l	music4
	dc.l	music1
	dc.l	music5

music1:	dc.b	"nibbly:nibbly/ingame/mod.ingame1",0
	even
music2:	dc.b	"nibbly:nibbly/ingame/mod.ingame2",0
	even
music3:	dc.b	"nibbly:nibbly/ingame/mod.ingame3",0
	even
music4:	dc.b	"nibbly:nibbly/ingame/mod.ingame4",0
	even
music5:	dc.b	"nibbly:nibbly/ingame/mod.ingame5",0
	even




flashsaver:	dc.w	0
has2flash:	dc.w	0

flashin:
	tst.w	has2flash
	beq	.noflashin

	cmp.w	#3,has2flash
	bge	.noflashin

	cmp.w	#1,has2flash
	bne	.nottriggered
	move.w	#2,has2flash
	move.w	#$f,flashsaver
.nottriggered

	cmp.w	#2,has2flash
	bne	.tooearly
	tst.w	flashsaver
	bpl	.tooearly
	move.w	#3,has2flash
	bra	.noflashin
.tooearly

	move.w	flashsaver,d7
	
	move.l	savea0,a0
	lea	realcolors,a1
	lea	10(a0),a0

	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	lea	40(a0),a0
	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	sub.w	#1,flashsaver
.noflashin
	rts

flashout:
	cmp.w	#3,has2flash
	blt	.noflashout
	
	add.w	#1,has2flash
	cmp.w	#100,has2flash
	blt	.noflashout
	
	cmp.w	#100,has2flash
	bne	.nottriggered
	move.w	#101,has2flash
	move.w	#0,flashsaver
.nottriggered

	cmp.w	#101,has2flash
	blt	.tooearly
	cmp.w	#$10,flashsaver
	bne	.tooearly
	move.w	#0,has2flash
	bra	.noflashout
.tooearly

	move.w	flashsaver,d7

	move.l	savea0,a0
	lea	realcolors,a1
	lea	10(a0),a0

	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	lea	40(a0),a0
	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	lea	4(a0),a0
	bsr	calcfade
	add.w	#1,flashsaver

.noflashout
	rts
	
calcfade:
	move.w	(a1)+,d0
	move.w	d0,d1
	lsr.w	#8,d1
	and.w	#$f,d1
	sub.w	d7,d1
	bpl	.isok1
	move.w	#0,d1
.isok1
	move.w	d1,d2
	lsl.w	#4,d2

	move.w	d0,d1
	lsr.w	#4,d1
	and.w	#$f,d1
	sub.w	d7,d1
	bpl	.isok2
	move.w	#0,d1
.isok2
	or.b	d1,d2
	lsl.w	#4,d2

	move.w	d0,d1
	and.w	#$f,d1
	sub.w	d7,d1
	bpl	.isok3
	move.w	#0,d1
.isok3
	or.b	d1,d2
	
	move.w	d2,(a0)
	rts

	
	
gelbtrank:	dc.w	0
turktrank:	dc.w	0
timer:		dc.w	0
extratype:	dc.w	0
nexttrigger:	dc.w	0
extraaktiv:	dc.w	0
extrapointer:	dc.l	0

specials1:	dc.l	0
specials2:	dc.l	0
specialx:	dc.w	0
specialy:	dc.w	0
specheight:	dc.w	0
is_a_fruit:	dc.w	0
symove:		dc.w	0
fruitextra:	dc.w	0

dospecialsprite:
	tst.w	is_a_fruit
	beq	.no_special_needed
	
	cmp.w	#1,is_a_fruit
	bne	.not_type_100
	move.l	#bonus100,specials1
	move.l	#bonus100+44,specials2
.not_type_100
	cmp.w	#2,is_a_fruit
	bne	.not_type_200
	move.l	#bonus200,specials1
	move.l	#bonus200+44,specials2
.not_type_200
	cmp.w	#3,is_a_fruit
	bne	.not_type_400
	move.l	#bonus400,specials1
	move.l	#bonus400+44,specials2
.not_type_400
	cmp.w	#4,is_a_fruit
	bne	.not_type_800
	move.l	#bonus800,specials1
	move.l	#bonus800+44,specials2
.not_type_800
	cmp.w	#5,is_a_fruit
	bne	.not_type_life
	move.l	#bonuslife,specials1
	move.l	#bonuslife+44,specials2
.not_type_life

	move.w	spritex,d0
	lsl.w	#4,d0
	move.w	d0,specialx
	move.w	spritey,d0
	lsl.w	#4,d0
	move.w	d0,specialy
	move.w	#9,specheight
	move.w	#0,symove

.no_special_needed
	rts


showspecialsprite:
	cmp.w	#-1,symove
	beq	no_special_sp

	move.l	specials1,a0
	move.w	specialx,d0
	move.w	specialy,d1

	and.w	#$ff0,d0
	and.w	#$ff0,d1
	move.w	symove,d2
	lsr.w	#3,d2
	sub.w	d2,d1
	add.w	#1,symove
	cmp.w	#40,symove
	bne	.still_ok
	move.w	#-1,symove
.still_ok

	add.w	#139,d0
	add.w	#76,d1
	
	move.w	d1,d2
	lsl.w	#8,d2
	
	move.w	d0,d3
	lsr.w	#1,d3
	or.w	d3,d2
	
	move.w	d2,(a0)		;erstes Kontrollwort
	
	move.w	d1,d3
	add.w	specheight,d3
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

	move.l	specials2,a1
	move.l	(a0),(a1)

put_special:
	move.l	savesprite2,a0		
	move.l	specials1,d0
	move.w	#spr2pt,d1
	bsr	inssprite
	move.l	specials2,d0
	move.w	#spr3pt,d1
	bsr	inssprite
	move.w	#0,is_a_fruit
	rts

no_special_sp:
	move.l	#offsprite,specials1
	move.l	#offsprite,specials2
	bra	put_special


;**********************************************************
;**********************************************************

expltype:	dc.w	0	;0/1/2=none/in/out

doexplosion:
	tst.w	expltype	
	beq	.noexplosion

	cmp.w	#1,expltype
	bne	.prep_in
	bsr	killexplosion
	move.w	#8,explosion
	move.w	#3,expltype
	bra	selectexpl
.prep_in

	cmp.w	#2,expltype
	bne	.prep_out
	bsr	killexplosion
	move.w	#0,explosion
	move.w	#4,expltype
	bra	selectexpl
.prep_out

	cmp.w	#3,expltype
	bne	.do_in
	add.w	#1,slowexpl
	cmp.w	#3,slowexpl
	bne	.do_in
	move.w	#0,slowexpl
	sub.w	#1,explosion
	bpl	selectexpl
	move.w	#-1,expltype
.do_in

	cmp.w	#4,expltype
	bne	.do_out
	add.w	#1,slowexpl
	cmp.w	#3,slowexpl
	bne	.do_out
	move.w	#0,slowexpl
	add.w	#1,explosion
	cmp.w	#8,explosion
	bls	selectexpl
	move.w	#-1,expltype
.do_out

	cmp.w	#-1,expltype
	bne	.stillexploding
	move.w	#0,expltype
	move.w	#0,slowexpl
	bra	killexplosion
.stillexploding

.noexplosion
	rts

slowexpl:	dc.w	0

selectexpl:
	move.w	explosion,d0
	tst.w	d0
	bmi	killexplosion
	and.l	#%111,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	.exploders,a0
	add.l	d0,a0
	jmp	(a0)
.exploders
	bra	.exp1
	bra	.exp2
	bra	.exp3
	bra	.exp4
	bra	.exp5
	bra	.exp6
	bra	.exp7
	bra	.exp8
.exp1
	move.l	#expo1,expls1
	move.l	#expo1+72,expls2
	bra	showexplsprite
.exp2
	move.l	#expo2,expls1
	move.l	#expo2+72,expls2
	bra	showexplsprite
.exp3
	move.l	#expo3,expls1
	move.l	#expo3+72,expls2
	bra	showexplsprite
.exp4
	move.l	#expo4,expls1
	move.l	#expo4+72,expls2
	bra	showexplsprite
.exp5
	move.l	#expo5,expls1
	move.l	#expo5+72,expls2
	bra	showexplsprite
.exp6
	move.l	#expo6,expls1
	move.l	#expo6+72,expls2
	bra	showexplsprite
.exp7
	move.l	#expo7,expls1
	move.l	#expo7+72,expls2
	bra	showexplsprite
.exp8
	move.l	#expo8,expls1
	move.l	#expo8+72,expls2
	bra	showexplsprite

explosion:	dc.w	0	
expls1:	dc.l	0
expls2:	dc.l	0
explx:	dc.w	0
exply:	dc.w	0

showexplsprite:	
	move.l	expls1,a0
	move.w	explx,d0
	move.w	exply,d1

	lsl.w	#4,d0
	lsl.w	#4,d1

	add.w	#138,d0
	add.w	#71,d1

	move.w	d1,d2
	lsl.w	#8,d2
	
	move.w	d0,d3
	lsr.w	#1,d3
	or.w	d3,d2
	
	move.w	d2,(a0)		;erstes Kontrollwort
	
	move.w	d1,d3
	add.w	#17,d3		;Höhe
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

	move.l	expls2,a1
	move.l	(a0),(a1)

put_expl
	move.l	savesprite3,a0		
	move.l	expls1,d0
	move.w	#spr4pt,d1
	bsr	inssprite
	move.l	expls2,d0
	move.w	#spr5pt,d1
	bsr	inssprite
	rts

killexplosion:
	move.l	#offsprite,expls1
	move.l	#offsprite,expls2
	bra	put_expl


getsprite:
	move.w	#16,height

	cmp.w	#1,d0	;Puck
	bne	nopuckspr
	move.l	#sprpuck,sprite1		
	move.l	#sprpuck+72,sprite2	
	rts
nopuckspr:

	cmp.w	#2,d0	;Totenkopf
	bne	nokopfspr
	move.l	#sprtod,sprite1		
	move.l	#sprtod+72,sprite2	
	rts
nokopfspr:

	cmp.w	#3,d0	;Trank GELB
	bne	notrankgelb
	move.l	#sprtrankgelb,sprite1		
	move.l	#sprtrankgelb+72,sprite2	
	rts
notrankgelb:

	cmp.w	#4,d0	;Trank TÜRKIS
	bne	notrankturk
	move.l	#sprtrankblau,sprite1		
	move.l	#sprtrankblau+72,sprite2	
	rts
notrankturk:

	cmp.w	#5,d0	;Life
	bne	nolife
	move.l	#sprlife,sprite1		
	move.l	#sprlife+72,sprite2	
	rts
nolife:

	cmp.w	#6,d0	;Frucht
	bne	nofrucht
	move.l	#sprfrucht,sprite1		
	move.l	#sprfrucht+72,sprite2	
	rts
nofrucht:

	cmp.w	#7,d0	;Solved
	bne	nosolved
	move.l	#sprsolved,sprite1		
	move.l	#sprsolved+72,sprite2	
	rts
nosolved:

	cmp.w	#8,d0	;Time
	bne	notime
	move.l	#sprtime,sprite1		
	move.l	#sprtime+72,sprite2	
	rts
notime:

	cmp.w	#9,d0	;Bigger
	bne	nobigger
	move.l	#sprsmaller,sprite1		
	move.l	#sprsmaller+72,sprite2	
	move.w	#1,togenable
	move.w	#1,togcount
	rts
nobigger:

	cmp.w	#11,d0	;Flash
	bne	noflash
	move.l	#sprflash,sprite1
	move.l	#sprflash+72,sprite2	
	rts
noflash:

	cmp.w	#0,d0		;Nosprite
	bne	nosprite

	move.w	#0,height
	move.l	#offsprite,sprite1		
	move.l	#offsprite,sprite2	
nosprite:
	rts

togglesprite:
	tst.w	togenable
	beq	.notoggel

	sub.w	#1,togcount
	tst.w	togcount
	bne	.notoggel

	move.w	#25,togcount
	
	not.w	togsprite

	tst.w	togsprite
	beq	.take_other
	move.l	#sprsmaller,sprite1		
	move.l	#sprsmaller+72,sprite2	
	bra	.useit
.take_other
	move.l	#sprbigger,sprite1		
	move.l	#sprbigger+72,sprite2	
.useit
	move.w	#16,height

	bsr	showsprite
.notoggel
	rts


togenable:	dc.w	0
togcount:	dc.w	0
togsprite:	dc.w	0



getspritepos:
	move.w	#200,d1
	bsr	rnd
back:
	move.w	d0,d1
	
	lea	diebuffer,a0

.noch_einmal	
	cmp.b	#0,(a0,d1.w)
	beq	.hier_her
.retry
	addq.w	#1,d1

	cmp.w	#200,d1
	blt	.noch_nicht
	move.w	#21,d1
.noch_nicht

	bra	.noch_einmal
.hier_her

	cmp.b	#2,1(a0,d1.w)
	beq	.retry
	cmp.b	#3,20(a0,d1.w)
	beq	.retry

	divu	#20,d1
	move.w	d1,d3
	swap	d1
	move.w	d1,d2
	
	subq.w	#1,d2
	subq.w	#1,d3

	move.w	d2,spritex
	move.w	d3,spritey

	move.l	savea0,a0
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
	eor.w	d2,d0
	move.w	$dff004,d2
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

	
	
showsprite:
	move.l	sprite1,a0
	move.w	spritex,d0
	move.w	spritey,d1

	lsl.w	#4,d0
	lsl.w	#4,d1

	add.w	#138,d0
	add.w	#72,d1
	
	move.w	d1,d2
	lsl.w	#8,d2
	
	move.w	d0,d3
	lsr.w	#1,d3
	or.w	d3,d2
	
	move.w	d2,(a0)		;erstes Kontrollwort
	
	move.w	d1,d3
	add.w	height,d3
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

	move.l	sprite2,a1
	move.l	(a0),(a1)

	move.l	savesprite,a0	
	move.l	sprite1,d0
	move.w	#spr0pt,d1
	bsr	inssprite
	move.l	sprite2,d0
	move.w	#spr1pt,d1
	bsr	inssprite
	rts
	
spritex:	dc.w	0
spritey:	dc.w	0
sprite1:	dc.l	0
sprite2:	dc.l	0
height:		dc.w	0

stop_sound:
	move.w 	#$0008,dmacon(a5)	
	move.l	#dummysample,aud3lc(a5)
	move.w	#2,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#300,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	rts

play_plopp:
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_plopp+100,aud3lc(a5)
	move.w	#415,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	sspeed,d0
	move.w	d0,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	rts

sspeed:	dc.w	0

playsnd1:	;Frucht aufheben
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_pickup+100,aud3lc(a5)
	move.w	#1110,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#300,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#0,sdelay
	rts

playsnd2:	;Extra taucht auf
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_auftauchen+100,aud3lc(a5)
	move.w	#2607,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#300,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#15,sdelay
	rts

playsnd3:	;Extra verschwindet
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_pop+100,aud3lc(a5)
	move.w	#2614,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#300,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#15,sdelay
	rts

playsnd4:	;Extra genommen
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_bonustaken+100,aud3lc(a5)
	move.w	#3181,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#300,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#30,sdelay
	rts

playsnd5:	;Früchte vergrößern
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_fruitsize+100,aud3lc(a5)
	move.w	#2113,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#900,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#30,sdelay
	rts

playsnd6:	;Zeit geht aus
	move.w 	#$0008,dmacon(a5)
	move.l	#sfx_signal+100,aud3lc(a5)
	move.w	#1454,aud3len(a5)
	move.w	#64,aud3vol(a5)
	move.w	#428,aud3per(a5)
	move.w	#$00ff,adkcon(a5)
	move.w	#$8008,dmacon(a5)
	move.w	#10,sdelay
	rts


soundmanager:
	cmp.w	#3,ssequence
	bne	.no_turn_off
	tst.w	force
	bne	.newsound
	bsr	stop_sound
	move.w	#0,ssequence
.no_turn_off
	
	cmp.w	#2,ssequence
	bne	.no_sound_start
	tst.w	force
	bne	.newsound
	cmp.w	#1,takesound
	bne	.not_sound_1
	bsr	playsnd1
.not_sound_1
	cmp.w	#2,takesound
	bne	.not_sound_2
	bsr	playsnd2
.not_sound_2
	cmp.w	#3,takesound
	bne	.not_sound_3
	bsr	playsnd3
.not_sound_3
	cmp.w	#4,takesound
	bne	.not_sound_4
	bsr	playsnd4
.not_sound_4
	cmp.w	#6,takesound
	bne	.not_sound_6
	bsr	playsnd6
.not_sound_6
	move.w	#3,ssequence
	move.w	#0,whichsound
	move.w	#0,takesound
.no_sound_start

	tst.w	sdelay
	beq	.is_null
	subq.w	#1,sdelay
.is_null

.newsound
	tst.w	whichsound
	beq	.make_sound_ready
	tst.w	force
	bne	.neu_sound
	tst.w	ssequence
	bne	.make_sound_ready
	tst.w	sdelay	
	bne	.make_sound_ready
.neu_sound
	move.w	whichsound,takesound
	move.w 	#$0008,dmacon(a5)
	move.w	#2,ssequence
	move.w	#0,force
.make_sound_ready

	rts

takesound:	dc.w	0
sdelay:		dc.w	0
whichsound:	dc.w	0
force:		dc.w	0
ssequence:	dc.w	0

notstretch:	dc.w	0

lastlevel:	dc.l	0

initlevel:
	bsr	killallsprites
	lea	scolors,a1
	bsr	sprcolors

	bsr	stop_sound


	move.l	lastlevel,d0
	cmp.l	levelcounter,d0
	beq	.nochweiter
	move.l	levelcounter,lastlevel
	add.w	#1,statecount
	cmp.w	#5,statecount
	bne	.nochweiter
	move.l	savepc,a7
	bra	goto_map
.nochweiter


	move.l	gfxbase,a6
	jsr	disownblitter(a6)

	bsr	loadmusic

	move.l	gfxbase,a6
	jsr	ownblitter(a6)

	lea	$dff000,a5
	move.l	#$ffffffff,bltafwm(a5)
	

	move.l	mainmusic,a0
	move.l	mt_data,a1
	move.l	#34900/2,d0
.muscopy
	move.w	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.muscopy

	move.w	#0,player4
	bsr	music_on

	tst.w	firsttime
	beq	.isfirst
	bsr	fade_out
.isfirst
	move.w	#-1,firsttime	
	
	move.l	#0,d0
	bsr	getsprite
	bsr	showsprite

	move.w	#-1,expltype
	bsr	doexplosion
	bsr	no_special_sp	
	
	move.w	#5,d1				;take_a_floor
	bsr	rnd
	move.w	d0,d1
	and.l	#$f,d1
	
	lsl.w	#7,d1
	add.l	#boeden,d1
	move.l	d1,a0
	lea	floor,a1
	
	move.w	#16*4-1,d0
.flcop
	move.w	(a0)+,(a1)+
	dbra	d0,.flcop
	

	move.w	#0,has2flash
	move.w	#1,fruitextra
	move.w	#0,is_a_fruit
	move.w	#-1,symove
	move.w	#0,fruittype
	move.w	#0,togenable
	move.w	#0,timer
	move.w	#0,extratype
	move.w	#50,nexttrigger
	move.w	#0,extraaktiv
	move.w	#0,flashscreen
	move.w	#0,notstretch
	move.w	#0,last_direction
	move.w	#0,first_for_ever
	move.w	#0,abridge
	move.w	#0,died
	move.l	#0,secpointer
	move.w	#4*6*22-1,d0
	lea	secbuffer,a0
cbuf:
	move.w	#0,(a0)+
	dbra	d0,cbuf	

	move.l	levelcounter,d0
	lsl.l	#8,d0
	move.l	#levels,a0
	add.l	d0,a0

	move.w	#0,numfruits

	bsr	builtlevel

	move.w	#144,xpos
	move.w	#144,ypos
	move.l	#0,xoff

	move.l	bitplanes,activeplanes

	move.l	#positions,a0
	move.l	#16,d0
fillposi:
	move.l	#$00900090,(a0)+
	dbra	d0,fillposi


	move.l	#positions2,a0
	move.l	#16,d0
fillposi2:
	move.l	#$00900090,(a0)+
	dbra	d0,fillposi2

	move.l	#positions+16*4,posstart
	move.l	#positions,posend

	move.l	#HEADUP,head

	move.w	#0,nummoves
	move.w	#0,moving
	move.w	#0,oldmove
	move.w	#0,oldmove2
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#0,mleft
	move.l	#0,vlock
	move.w	#0,insert

	move.l	usedlevel,a0
	move.b	255(a0),d0
	move.b	d0,fruittype
	and.l	#$f,d0
	lsl.w	#4,d0
	add.l	#list4,d0
	move.l	d0,activelist	
	move.w	#0,listoff

	move.w	xpos,d0
	move.w	ypos,d1
	lea	levelbuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	#$ff,(a0,d1.w)

	move.l	#flups,d2
	add.l	head,d2
	move.l	d2,activehead
	bsr	maskflups
	move.w	#1,flupssize

	bsr	showscreen

	move.l	levelcounter,d0
	add.w	#1,d0
	divu	#10,d0
	move.b	d0,round
	swap	d0
	move.b	d0,round+1

	move.l	#scoretext+40*4*15+2,d0
	move.b	lifes,d1
	bsr	copychar
	move.b	lifes+1,d1
	add.l	#2,d0
	bsr	copychar

	move.l	#scoretext+40*4*15+2*10+10,d0
	add.l	#2,d0
	move.b	round,d1
	add.l	#2,d0
	bsr	copychar
	move.b	round+1,d1
	add.l	#2,d0
	bsr	copychar

	bsr	fade_in

	move.l	#0,realcolors
	move.l	#0,realcolors+4
	move.w	#0,realcolors+8

	lea	levelbuffer+239,a1
	cmp.b	#1,(a1)
	beq	flashthescreen
	
	cmp.l	#11,levelcounter
	beq	flashthescreen

	cmp.l	#3,levelcounter
	bne	noprepflash

flashthescreen:	
	move.l	usedcolors,a0
	add.l	#48,a0
	move.w	#$0,4*3(a0)
	move.b	#$0,4*3+2(a0)

	move.l	savea0,a0
	move.w	#0,4*4+2(a0)	

	move.w	#1,flashscreen
	move.l	savea0,a0
	move.w	10(a0),realcolors
	move.w	14(a0),realcolors+2
	move.w	54(a0),realcolors+4
	move.w	58(a0),realcolors+6
	move.w	62(a0),realcolors+8
	move.w	#70,has2flash
.fadeemout
	bsr	flashout
	bsr	vposup
	tst.w	has2flash
	bne	.fadeemout
noprepflash
	rts

	even

realcolors:	dc.w	0,0,0,0,0
score:		dc.b	0,0,0,0,0,0
isscore:  	dc.l	0
addscore: 	dc.l	0
timec:		dc.w	0
time:		dc.b	1,2
istime:		dc.w	0
addtime: 	dc.w	0
lifes:		dc.b	0,3
islifes: 	dc.w	3
addlifes: 	dc.w	0
pucks:		dc.b	0,0
ispucks: 	dc.w	0
addpucks:	dc.w	0
round:		dc.b	0,0

showscore:
	tst.w	addlifes
	beq	.no_new_lifes
	moveq.l	#0,d0
	move.w	islifes,d0
	add.w	addlifes,d0
	move.w	d0,islifes
	move.w	#0,addlifes
	divu	#10,d0
	move.b	d0,lifes
	swap	d0
	move.b	d0,lifes+1
	move.l	#scoretext+40*4*15+2,d0
	move.b	lifes,d1
	bsr	copychar
	move.b	lifes+1,d1
	add.l	#2,d0
	bsr	copychar
.no_new_lifes


	tst.w	addpucks
	beq	.no_new_pucks
	moveq.l	#0,d0
	move.w	ispucks,d0
	add.w	addpucks,d0
	move.w	d0,ispucks
	move.w	#0,addpucks	
	divu	#10,d0
	move.b	d0,pucks
	swap	d0
	move.b	d0,pucks+1
	move.l	#scoretext+40*4*15+24,d0
	add.l	#2,d0
	move.b	pucks,d1
	add.l	#2,d0
	bsr	copychar
	move.b	pucks+1,d1
	add.l	#2,d0
	bsr	copychar
.no_new_pucks


	add.w	#1,timec
	cmp.w	#50,timec
	bne	not50frames
	move.w	#0,timec
	add.w	#-1,addtime
not50frames:


	tst.w	addtime
	beq	.no_new_time
	move.l	#0,d0
	move.w	istime,d0
	add.w	addtime,d0
	move.w	#0,addtime
	move.w	d0,istime
	cmp.w	#0,istime
	bne	.still_some_time
	move.w	#2,died
.still_some_time
	divu	#10,d0
	move.b	d0,time
	swap	d0
	move.b	d0,time+1

	move.l	#scoretext+40*4*15+4,d0
	add.l	#2,d0
	move.b	time,d1
	add.l	#2,d0
	bsr	copychar
	move.b	time+1,d1
	add.l	#2,d0
	bsr	copychar
.no_new_time

	tst.l	addscore
	beq	.no_new_score
	move.l	#0,d1
	move.l	isscore,d0
	add.l	addscore,d0
	move.l	d0,isscore
	move.l	#0,addscore

	divu	#10,d0
	move.w	d0,d1
	swap	d0
	and.b	#$f,d0
	move.b	d0,score+5

	and.l	#$ffff,d1
	divu	#10,d1
	move.w	d1,d0
	swap	d1
	and.b	#$f,d1
	move.b	d1,score+4

	and.l	#$ffff,d0
	divu	#10,d0
	move.w	d0,d1
	swap	d0
	and.b	#$f,d0
	move.b	d0,score+3

	and.l	#$ffff,d1
	divu	#10,d1
	move.w	d1,d0
	swap	d1
	and.b	#$f,d1
	move.b	d1,score+2

	and.l	#$ffff,d0
	divu	#10,d0
	move.w	d0,d1
	swap	d0
	and.b	#$f,d0
	move.b	d0,score+1

	and.l	#$ffff,d1
	divu	#10,d1
	move.w	d1,d0
	swap	d1
	and.b	#$f,d1
	move.b	d1,score

	move.l	#scoretext+40*4*15+10,d0
	add.l	#2,d0
	move.b	score,d1
	add.l	#2,d0
	bsr	copychar
	move.b	score+1,d1
	add.l	#2,d0
	bsr	copychar
	move.b	score+2,d1
	add.l	#2,d0
	bsr	copychar
	move.b	score+3,d1
	add.l	#2,d0
	bsr	copychar
	move.b	score+4,d1
	add.l	#2,d0
	bsr	copychar
	move.b	score+5,d1
	add.l	#2,d0
	bsr	copychar
.no_new_score

	rts

copychar:	
	and.l	#$f,d1
	add.b	d1,d1
	add.l	#scorechars,d1
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d1,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#18,bltamod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#17*64*4+1,bltsize(a5)
	rts

killallsprites:
	move.l	savesprite,a0
	move.l	#offsprite,d0
	move.w	#spr0pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
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
	rts

showohno:
	move.l	#ohno,a0
	move.l	restorebuffer,a1
	move.l	#oncolors-ohno,d0
	lsr.w	#2,d0
.copygover
	move.l	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.copygover
	move.w	#0,oncolors+4
	lea	oncolors+2,a1
	bsr	sprcolors
	bra	dotheshit

showgameover:
	move.l	#gover,a0
	move.l	restorebuffer,a1
	move.l	#gocolors-gover,d0
	lsr.w	#2,d0
.copygover
	move.l	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.copygover
	move.w	#0,gocolors+4
	lea	gocolors+2,a1
	bsr	sprcolors
	bra	dotheshit

showwelldone:
	move.l	#wdone,a0
	move.l	restorebuffer,a1
	move.l	#wcolors-wdone,d0
	lsr.w	#2,d0
.copygover
	move.l	(a0)+,(a1)+
	sub.l	#1,d0
	bne	.copygover
	move.w	#0,wcolors+4
	lea	wcolors+2,a1
	bsr	sprcolors
	bra	dotheshit

dotheshit:
	move.l	restorebuffer,a0
	move.l	#$807caa00,(a0)
	lea	176(a0),a0
	move.l	#$807caa80,(a0)
	lea	176(a0),a0

	move.l	#$8084aa00,(a0)
	lea	176(a0),a0
	move.l	#$8084aa80,(a0)
	lea	176(a0),a0

	move.l	#$808caa00,(a0)
	lea	176(a0),a0
	move.l	#$808caa80,(a0)
	lea	176(a0),a0

	move.l	#$8094aa00,(a0)
	lea	176(a0),a0
	move.l	#$8094aa80,(a0)
	lea	176(a0),a0

	move.l	savesprite,a0

	move.l	restorebuffer,d7
	move.l	d7,d0
	move.w	#spr0pt,d1
	bsr	inssprite
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr1pt,d1
	bsr	inssprite

	move.l	savesprite2,a0
	
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr2pt,d1
	bsr	inssprite
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr3pt,d1
	bsr	inssprite
	
	move.l	savesprite3,a0

	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr4pt,d1
	bsr	inssprite
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr5pt,d1
	bsr	inssprite

	move.l	savesprite4,a0
	
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr6pt,d1
	bsr	inssprite
	add.l	#176,d7
	move.l	d7,d0
	move.w	#spr7pt,d1
	bsr	inssprite


	move.l	savesprcolors,a0
	move.w	#0,d0
.heller
	move.w	d0,6(a0)
	bsr	vposup
	add.w	#$111,d0
	cmp.w	#$1110,d0
	bne	.heller

	move.w	#$fff,d0
.dunkler
	move.w	d0,6(a0)
	bsr	vposup
	sub.w	#$111,d0
	cmp.w	#$feef,d0
	bne	.dunkler
	
	rts



do_direction:
	cmp.w	#$81,last_direction	
	bne	.test_right
	add.w	#16,d0
	move.w	#2,movx
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#1,mright
	move.w	#0,mleft
	move.w	#-16,disx
	move.w	#0,disy
.test_right
	cmp.w	#$82,last_direction
	bne	.test_left
	sub.w	#16,d0
	move.w	#-2,movx
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#1,mleft
	move.w	#16,disx
	move.w	#0,disy
.test_left
	cmp.w	#$83,last_direction	
	bne	.test_down
	add.w	#16,d1
	move.w	#2,movy
	move.w	#0,mup
	move.w	#1,mdown
	move.w	#0,mright
	move.w	#0,mleft
	move.w	#0,disx
	move.w	#-16,disy
.test_down
	cmp.w	#$84,last_direction	
	bne	.test_up
	sub.w	#16,d1
	move.w	#-2,movy
	move.w	#1,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#0,mleft
	move.w	#0,disx
	move.w	#16,disy
.test_up
	rts


kill_it:
	move.l	posstart,d0	;2. Teil (hinter dem Kopf)
	sub.l	#4*8,d0
	cmp.l	#positions,d0
	bge	.no_under_pos
	add.l	#400*4*8,d0
.no_under_pos
	move.l	d0,a0
	move.w	(a0),d0
	move.w	2(a0),d1

	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1

	lea	dirbuffer2,a2
	lea	dirbuffer2,a3
	lea	dirbuffer2,a4

	add.l	d1,a2
	add.l	d1,a3
	add.l	d1,a4

	move.b	(a2),d0
	move.b	(a3),d1
	move.b	(a4),d2
	
	and.w	#$ff,d0
	and.w	#$ff,d1
	and.w	#$ff,d2
	
	cmp.b	#9,d0
	bls	.not_change1
	move.b	#0,(a2)
.not_change1

	cmp.b	#9,d1
	bls	.not_change2
	move.b	#0,(a3)
.not_change2

	cmp.b	#9,d2
	bls	.not_change3
	move.b	#0,(a4)
.not_change3
	rts


high_low:	dc.w	0



fade_out:
	move.l	#0,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	sub.b	d7,d1
	bpl	.ok0
	move.b	#0,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	sub.b	d7,d2
	bpl	.ok1
	move.b	#0,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	sub.b	d7,d2
	bpl	.ok2
	move.b	#0,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0
	cmp.w	#$01a0,d0
	bne	.cloop2

	add.w	#1,d7
	cmp.w	#$10,d7
	bne	.dofade

	rts

fade_in:
	move.l	#$f,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	sub.b	d7,d1
	bpl	.ok0
	move.b	#0,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	sub.b	d7,d2
	bpl	.ok1
	move.b	#0,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	sub.b	d7,d2
	bpl	.ok2
	move.b	#0,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0
	cmp.w	#$01a0,d0
	bne	.cloop2

	sub.w	#1,d7
	bpl	.dofade

	rts


screen_flash_light:
	move.l	#0,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	add.b	d7,d1
	cmp.b	#$10,d1
	blt	.ok0
	move.b	#$f,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok1
	move.b	#$f,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok2
	move.b	#$f,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0
	cmp.w	#$01a0,d0
	bne	.cloop2

	add.w	#1,d7
	cmp.w	#$10,d7
	bne	.dofade

	rts

screen_flash_dark:
	move.l	#$f,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	add.b	d7,d1
	cmp.b	#$10,d1
	blt	.ok0
	move.b	#$f,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok1
	move.b	#$f,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok2
	move.b	#$f,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0
	cmp.w	#$01a0,d0
	bne	.cloop2

	sub.w	#1,d7
	bpl	.dofade

	rts


back_flash_light:
	move.l	#0,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	add.b	d7,d1
	cmp.b	#$10,d1
	blt	.ok0
	move.b	#$f,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok1
	move.b	#$f,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok2
	move.b	#$f,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0

	add.w	#1,d7
	cmp.w	#$10,d7
	bne	.dofade

	rts

back_flash_dark:
	move.l	#$f,d7

.dofade
	bsr	vposup

	move.l	savea0,a0
	move.l	usedcolors,a1
	add.l	#48,a1
	move.l	#$0180,d0
.cloop2
	move.w	d0,(a0)+
	move.b	(a1)+,d1
	lsr.b	#4,d1
	add.b	d7,d1
	cmp.b	#$10,d1
	blt	.ok0
	move.b	#$f,d1
.ok0
	lsl.w	#4,d1

	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok1
	move.b	#$f,d2
.ok1
	or.b	d2,d1
	lsl.w	#4,d1
	move.b	(a1)+,d2
	lsr.b	#4,d2
	add.b	d7,d2
	cmp.b	#$10,d2
	blt	.ok2
	move.b	#$f,d2
.ok2
	or.b	d2,d1
	and.w	#$fff,d1
	move.w	d1,(a0)+
	add.w	#2,d0

	sub.w	#1,d7
	bpl	.dofade

	rts



saveactivescreen:	dc.l	0
oldbyte:	dc.w	0
oldoff:		dc.l	0
fruittype:	dc.w	$0000

sizefruit:
aaa:
	tst.b	fruittype+1
	bne	.change_needed
	rts
.change_needed

	tst.w	moving
	bne	end_size

	cmp.b	#1,fruittype+1
	bne	.notmore
	cmp.b	#4,fruittype
	bne	.is_gut
	move.b	#0,fruittype+1
	rts
.notmore

	cmp.b	#$ff,fruittype+1
	bne	.notless
	cmp.b	#0,fruittype
	bne	.is_gut
	move.b	#0,fruittype+1
	rts
.notless

.is_gut

	move.w 	#$0008,dmacon(a5)

	move.l	activeplanes,saveactivescreen

	move.w	#0,numfruits
	lea 	levelbuffer,a0
	
	move.b	fruittype,d0
	add.b	fruittype+1,d0
	bpl	.ispos
	move.b	#0,d0
.ispos
	cmp.b	#4,d0
	bls	.isok
	move.b	#4,d0
.isok
	move.b	d0,fruittype
	move.b	#0,fruittype+1
	move.b	#4,d1
	sub.b	d0,d1
	and.l	#$f,d1
	mulu	#4*16*4,d1
 	move.l	d1,d0
	add.l	#fruits,d0
	add.l	#fruits_m,d1
	move.l	d0,blob
	move.l	d1,blobmask

	move.l	bitplanes,d0
	add.l	#40*182*4*8,d0
	move.l	d0,activeplanes


	move.b	fruittype,d0
	and.l	#$f,d0
	lsl.w	#4,d0
	add.l	#list4,d0
	move.l	d0,activelist	
	move.w	#0,listoff


	lea 	dirbuffer,a0
	move.w	xpos,d0
	move.w	ypos,d1

	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	and.l	#$ffff,d1
	add.l	d1,a0
	move.b	(a0),oldbyte
	move.l	a0,oldoff

	move.b	oldbyte,d0
	cmp.b	#0,d0
	beq	.oktoput
	cmp.b	#1,d0
	beq	.oktoput
	bra	.notput
.oktoput
	move.b	#$ff,(a0)
.notput

	bsr	vposup
	bsr	vposdown
	bsr	playsnd5

	lea 	dirbuffer,a0
	bsr	fillscreen2

	move.l	#dummysample,aud3lc(a5)
	move.w	#2,aud3len(a5)
	
	move.l	oldoff,a0
	move.b	oldbyte,(a0)
	
	move.l	saveactivescreen,activeplanes

	move.l	#7*4,d6
.putthemall2
	bsr	switch
	bsr	clrmaskbuffer

	move.l	#0,d7
	move.w	flupssize,d7
.putthemall
	move.l	posstart,d0
	sub.l	#positions,d0
	move.l	d7,d1
	lsl.w	#5,d1
	sub.l	d1,d0
	sub.l	d6,d0
	tst.l	d0
	bpl	.no_under_pos
	add.l	#400*4*8,d0
.no_under_pos
	lea	positions2,a0
	add.l	d0,a0
	move.w	(a0),d0
	move.w	2(a0),d1
	bsr	put_a_flups

	sub.w	#1,d7
	bpl	.putthemall
	bsr	vposdown
	bsr	schmapfalles

	sub.l	#4,d6
	bpl	.putthemall2

end_size:
	rts


schmapfalles:
	move.w	#4,d2
	
	move.l	bitplanes,d0
	add.l	#40*182*4*8,d0
	
	move.l	activeplanes,d1

.other_planes	
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$0fB8,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	maskbuffer,bltbpth(a5)
	move.l	d1,bltcpth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#120,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#120,bltcmod(a5)
	move.w	#120,bltdmod(a5)
	move.w	#182*64+20,bltsize(a5)

	add.l	#40,d0
	add.l	#40,d1
	sub.w	#1,d2
	bne	.other_planes

	rts



clrmaskbuffer:
	bsr	waitblit
	move.w	#$0100,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	maskbuffer,bltdpth(a5)
	move.w	#0,bltdmod(a5)
	move.w	#182*64+20,bltsize(a5)
	rts


nowx:	dc.w	0
nowy:	dc.w	0

schmeiss_rein:
	bsr	checkon
	bsr	putflupsmask
	bsr	checkunder
	
	bsr	ausmaskieren

	bsr	do_the_rest	
	bsr	copyflups
	rts


ausmaskieren:		
ugu:
	move.l	xpos,d0
	move.w	d0,d1
	swap	d0
	
	and.l	#$ff0,d0
	and.l	#$ff0,d1

	move.w	d0,nowx
	move.w	d1,nowy

	cmp.w	#1,mright
	bne	.not_m_r
	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#32,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#32,d0
	bsr	look4part
.not_m_r


	cmp.w	#1,mleft
	bne	.not_m_l
	move.w	nowx,d0
	move.w	nowy,d1
	sub.w	#16,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	bsr	look4part
.not_m_l


	cmp.w	#1,mup
	bne	.not_m_u
	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	sub.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d1
	bsr	look4part
.not_m_u


	cmp.w	#1,mdown
	bne	.not_m_d
	move.w	nowx,d0
	move.w	nowy,d1
	sub.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	add.w	#16,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#16,d0
	add.w	#32,d1
	bsr	look4part

	move.w	nowx,d0
	move.w	nowy,d1
	add.w	#32,d1
	bsr	look4part
.not_m_d
	

	rts

thisxy:	dc.l	0

look4part:	
	move.w	d0,thisxy
	move.w	d1,thisxy+2
	
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	lea	dirbuffer2,a3
	add.l	d1,a3
	lea	dirbuffer3,a4
	add.l	d1,a4

	move.b	(a3),d0
	bsr	ist_das_einer
	tst.w	d0
	bne	.eine_maske

	move.b	(a4),d0
	bsr	ist_das_einer
	tst.w	d0
	bne	.eine_maske

	rts
	
.eine_maske
	move.w	d0,d4	
	move.w	thisxy,d2
	move.w	thisxy+2,d3
	bsr	where_am_i
	
	sub.w	#6,d0
	
	bsr	put_a_body_mask
	
	rts


;returns: real x and real y in d0,d1
;	  up/low = 1/0 in d2
;needs:	active xpos,ypos (in d2,d3)
;	direction in d4	($81 r,$82 l,$83 d,$84 u)
;	
;uses: d0,d1,d2,d3,d4,d5, a0


ist_das_einer:
	and.w	#$ff,d0
	cmp.w	#$81,d0
	bge	.koennt_sein
	move.w	#0,d0
	rts
.koennt_sein
	cmp.w	#$84,d0
	bgt	.is_nicht
	rts	
.is_nicht
	move.w	#0,d0
	rts
	



flycount: dc.w	0
movx:	dc.w	0
movy:	dc.w	0

thisadress:	dc.l	0
thisbyte:	dc.w	0
wo_samma:	dc.w	0
savexy3:	dc.l	0

disx:	dc.w	0
disy:	dc.w	0

oldhead:	dc.l	0
chead:		dc.w	0
heads:		dc.l	HEADRIGHT,HEADDOWN,HEADLEFT,HEADUP

do_puck:
	tst.w	moving
	bne	nix_puck
	tst.w	last_direction
	beq	nix_puck

	move.w	#-1,addpucks

	move.l	head,oldhead

	move.w	last_direction,d0

	cmp.w	#$81,d0
	bne	.nmr
	move.w	#0,chead	
.nmr
	cmp.w	#$82,d0
	bne	.nml
	move.w	#8,chead	
.nml
	cmp.w	#$83,d0
	bne	.nmd
	move.w	#4,chead	
.nmd
	cmp.w	#$84,d0
	bne	.nmu
	move.w	#12,chead	
.nmu
	
	

	bsr	saveswitch
	
	move.w	#7,d7
.flatter
	bsr	switch
	sub.w	#1,d7
	bne	.flatter

	bsr	switchswitch

	move.l	xpos,savexy
	bsr	savemoves
	bsr	savelock



	move.l	posend,a0
	move.l	a0,a1
	bsr	getdirection

	bsr	dir2num

	move.l	posend,a0
	move.w	(a0),d0
	move.w	2(a0),d1

	lea	dirbuffer2,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a3

	move.b	(a3),d0

	move.l	a3,thisadress
	move.b	d0,thisbyte
	move.b	d4,thisbyte+1
	

	bsr	restoremoves


	move.l	xpos,savexy3


	bsr	checkon
	
	move.w	xpos,d0
	move.w	ypos,d1
	
	sub.w	xoff,d0
	sub.w	yoff,d1
	move.w	d0,segx
	move.w	d1,segy	
	
	move.w	#14,nummoves

	bsr	do_direction

	move.w	disx,d0
	move.w	disy,d1

	move.l	xpos,clrsave
	
	add.w	d0,clrsave
	add.w	d1,clrsave+2

	move.l	clrsave,rememberxy

	move.l	thisadress,a3
	move.b	thisbyte+1,d0
	move.b	d0,(a3)

	bsr	copyflups2

	move.l	thisadress,a3
	move.b	thisbyte,d0
	move.b	d0,(a3)

	
	move.l	posstart,d0	;2. Teil (hinter dem Kopf)
	sub.l	#4*8,d0
	cmp.l	#positions,d0
	bge	.no_under_pos
	add.l	#400*4*8,d0
.no_under_pos
	move.l	d0,a0
	move.w	(a0),xpos
	move.w	2(a0),ypos
	move.l	#flups+88*4*6,activehead

	move.l	a0,a1
	bsr	getdirection

	bsr	schmeiss_rein

	move.l	savexy3,xpos


	
next_square

maa

	;btst	#10,$dff016
	;bne	nofir

fir
	;btst	#10,$dff016
	;beq	fir

	;bsr	oldcopperbase
fuck:
	nop

nofir
	;btst	#6,$bfe001
	;bne	maa


	move.w	xpos,d0
	move.w	ypos,d1

	move.l	xpos,clrsave

	move.l	#0,movx

	
	bsr	do_direction


	move.w	d0,clrxpos
	move.w	d1,clrypos

	bsr	getblock
	cmp.b	#1,d0
	beq	.end_of_flight



	move.w	clrxpos,d2
	move.w	clrypos,d3

	move.w	d2,d0
	move.w	d3,d1

	bsr	getblock3

	
	cmp.b	#$ff,d0
	bne	.not_self
	move.w	#$f00,$dff180
	move.w	#2,died
.not_self

	move.w	d2,d0
	move.w	d3,d1
	

	lea	dirbuffer,a2
	lea	dirbuffer2,a3
	lea	dirbuffer3,a4
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a2
	add.l	d1,a3
	add.l	d1,a4

	move.w	last_direction,d4
	move.w	d2,d0
	move.w	d3,d1
	bsr	correct_height



	cmp.w	#0,d2
	bne	.not_on_ground
	move.l	a3,a0
	bra	.on_ground
.not_on_ground
	move.l	a4,a0
.on_ground


	move.b	(a0),d0
	and.w	#$ff,d0
	
	cmp.w	#$81,d0
	bge	.could_be
	bra	.na_is_not
.could_be
	cmp.w	#$84,d0
	bgt	.na_is_not

	move.w	#2,died	
	move.l	#10000,d0
.putput
	move.w	#$f0f,$dff180
	sub.l	#1,d0
	bne	.putput
.na_is_not

.nogo



	move.w	#0,nummoves
	move.w	#8,flycount
.fly_fly

	move.w	movx,d0
	move.w	movy,d1
	add.w	d0,xpos
	add.w	d1,ypos


	bsr	switchswitch
	bsr	switch

	move.w	nummoves,-(sp)

	add.w	#14,nummoves
	and.w	#$f,nummoves


	move.l	xpos,savexy2

	move.w	xpos,d0
	move.w	ypos,d1
	bsr	getblock2
	cmp.b	#0,d0
	bne	.nofloor
	move.b	#$50,(a0,d1.w)
	sub.w	#1,numfruits
.nofloor

	bsr	clear_a_tile	;Boden neu aufbauen
	move.l	savexy2,xpos
	move.w	#0,may_put_body

	move.l	thisadress,a3
	move.b	thisbyte+1,d0
	move.b	d0,(a3)

	move.w	#1,smode
	
	bsr	removefruit

	move.w	#0,smode

	move.l	thisadress,a3
	move.b	thisbyte,d0
	move.b	d0,(a3)


	move.l	savexy2,xpos
	move.w	(sp)+,nummoves


	bsr	switchswitch
	

	bsr	checkon	
	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	xoff,d0
	sub.w	yoff,d1
	bsr	save_square

	bsr	vposup

	lea	heads,a0
	move.w	chead,d0
	move.l	(a0,d0.w),d1
	move.l	d1,head

	move.l	#flups,d2	;Kopf hineinkopieren
	add.l	head,d2
	move.l	d2,activehead


	bsr	checkon
	bsr	putflupsmask
	bsr	checkunder
	
	bsr	ausmaskieren
	
	bsr	do_the_rest
	bsr	copyflups


	btst	#10,$dff016
	bne	.not_right
	move.l	#100000,d0
.wait
	sub.l	#1,d0
	bne	.wait
.not_right
	
	
	tst.w	died
	beq	.noch_am_leben
	
	move.w	#50,d7
.some_time
	bsr	vposup
	sub.w	#1,d7
	bne	.some_time	
	
	bra 	.end_of_flight
.noch_am_leben

	bsr	vposdown

	bsr	rest_square

	add.w	#2,nummoves

	subq.w	#1,flycount
	bne	.fly_fly

	add.w	#4,chead
	and.w	#%1111,chead

	bra	next_square





.end_of_flight
	move.l	oldhead,head

	tst.w	died
	bne	has_died

	move.w	xpos,d0
	move.w	ypos,d1
	lsr.w	#4,d0
	lsr.w	#4,d1
	sub.w	#1,d0
	sub.w	#1,d1
	move.w	d0,explx
	move.w	d1,exply

	move.w	#0,nummoves
	move.w	#8,flycount
.fly_fly2
	move.w	movx,d0
	move.w	movy,d1
	add.w	d0,xpos
	add.w	d1,ypos
	bsr	switchswitch
	bsr	switch
	move.w	nummoves,-(sp)
	add.w	#14,nummoves
	and.w	#$f,nummoves
	move.l	xpos,savexy2
	move.w	xpos,d0
	move.w	ypos,d1
	bsr	getblock2
	cmp.b	#0,d0
	bne	.nofloor2
	move.b	#$50,(a0,d1.w)
	sub.w	#1,numfruits
.nofloor2
	;bsr	clear_a_tile
	move.l	savexy2,xpos
	move.w	#0,may_put_body
	move.l	thisadress,a3
	move.b	thisbyte+1,d0
	move.b	d0,(a3)
	move.w	#1,smode
	bsr	removefruit
	move.w	#0,smode
	move.l	thisadress,a3
	move.b	thisbyte,d0
	move.b	d0,(a3)
	move.l	savexy2,xpos
	move.w	(sp)+,nummoves
	bsr	switchswitch
	add.w	#2,nummoves
	subq.w	#1,flycount
	bne	.fly_fly2

bogo:
	move.l	savexy,xpos
	bsr	restorelock


	move.l	posstart,d0
	sub.l	#4,d0
	cmp.l	#positions,d0
	bge	.no_under_pos2bbb
	add.l	#400*4*8,d0
.no_under_pos2bbb
	move.l	d0,a0
	move.l	a0,a1
	bsr	getdirection


	move.l	posstart,d0
	sub.l	#4*8,d0
	cmp.l	#positions,d0
	bge	.no_under_pos2bbbaaa
	add.l	#400*4*8,d0
.no_under_pos2bbbaaa
	move.l	d0,a0
	move.w	(a0),clrsave
	move.w	2(a0),clrsave+2

	move.w	#14,nummoves
	move.w	#1,expltype
	
.stillexploding
	bsr	vposup
	bsr	doexplosion
	tst.w	expltype
	bne	.stillexploding

	move.w	#2,expltype
	move.w	xpos,d0
	move.w	ypos,d1
	lsr.w	#4,d0
	lsr.w	#4,d1
	sub.w	#1,d0
	sub.w	#1,d1
	move.w	d0,explx
	move.w	d1,exply
	
.stillexploding2
	bsr	vposup
	bsr	doexplosion
	tst.w	expltype
	bne	.stillexploding2

	move.l	#flups,d2	;Kopf hineinkopieren
	add.l	head,d2
	move.l	d2,activehead

	bsr	maskflups



has_died:

	move.l	savexy,xpos
	bsr	restoremoves
	move.w	#0,nummoves
	bsr	restorelock
	move.w	#1,movedone

nix_puck:	
	rts


savevlock:	dc.l	0
savehlock:	dc.l	0


savelock:
	move.l	vlock,savevlock
	move.l	hlock,savehlock
	rts

restorelock:
	move.l	savevlock,vlock
	move.l	savehlock,hlock
	rts

save_square:
	sub.w	#6,d0
	mulu	#160,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	move.l	d0,d2
	add.l	activeplanes,d0
	add.l	restorebuffer,d2

	move.l	d0,save1
	move.l	d2,save2

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*4*64+3,bltsize(a5)
	rts

save1:	dc.l	0
save2:	dc.l	0


rest_square:
	move.l	save1,d2
	move.l	save2,d0

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*4*64+3,bltsize(a5)
	rts



schrumpf:
	cmp.w	#1,flupssize
	beq	too_short
	tst.w	moving
	beq	no_movement

too_short:	
	rts
	
no_movement:
	bsr	vposup
	bsr	play_plopp

	move.w	#0,nummoves
	move.l	xpos,savexy

	bsr	clrdie

	move.l	posend,d0
	add.l	#4*8,d0
	cmp.l	#positions+400*4*8,d0
	blt	.not_over_posit
	move.l	#positions,d0
.not_over_posit
	move.l	d0,a0
	move.l	(a0),clrsave
	
	move.w	#8,schcount
schloop:
	move.l	posend,d0
	addq.l	#4,d0
	cmp.l	#positions+400*4*8,d0
	blt	.not_over_posit
	move.l	#positions,d0
.not_over_posit
	move.l	d0,posend

	bsr	switch
	bsr	savemoves
	bsr	kill_last_segment
	bsr	restoremoves

	bsr	savemoves

	move.l	posend,d0
	add.l	#4*8,d0
	cmp.l	#positions+400*4*8,d0
	blt	.not_over_posit2
	move.l	#positions,d0
.not_over_posit2
	move.l	d0,a0

	move.w	(a0),xpos
	move.w	2(a0),ypos

	move.l	a0,a1
	bsr	getdirection

	cmp.w	#0,nummoves
	bne	.set_dir
	move.l	mright,allmoves
	move.l	mup,allmoves+4
.set_dir

	cmp.w	#0,nummoves
	beq	.dir_allready_set
	move.l	allmoves,mright
	move.l	allmoves+4,mup
.dir_allready_set
	

	move.l	#flups+88*4*6,d2
	move.l	d2,activehead
	bsr	maskflups

	bsr	restoremoves


	add.w	#2,nummoves

	sub.w	#1,schcount
	bne	schloop


	bsr	savedir
	bsr	cleardir

	sub.w	#1,flupssize
	move.w	#0,nummoves
	move.l	savexy,xpos

	bsr	stop_sound
	rts


schcount:	dc.w	0




saveactive:	dc.l	0
savexy:		dc.l	0
savexy2:	dc.l	0
activehead:	dc.l	0
omoves:		dc.w	0,0,0,0
allmoves:	dc.l	0,0
oclrsave:	dc.l	0
lastheight:	dc.w	0
last_direction:	dc.w	0

moveflups:
	tst.w	moving
	beq	is_not_moving

	tst.w	first_for_ever
	bne	.already_done
	bsr	dir2num

	move.w	#1,first_for_ever

	move.w	clrsave,d0
	move.w	clrsave+2,d1
	lea	dirbuffer,a2
	lea	dirbuffer2,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	
	add.l	d1,a2
	add.l	d1,a3
	
	move.b	d4,(a2)
	move.b	d4,(a3)
.already_done
	

	move.l	xpos,savexy

	cmp.w	#1,mup
	bne	no_up_move
	subq	#2,ypos
no_up_move:

	cmp.w	#1,mdown
	bne	no_down_move
	addq	#2,ypos
no_down_move:

	cmp.w	#1,mright
	bne	no_right_move
	addq	#2,xpos
no_right_move:

	cmp.w	#1,mleft
	bne	no_left_move
	subq	#2,xpos
no_left_move:


;returns: real x and real y in d0,d1
;	  up/low = 1/0 in d2
;needs:	active xpos,ypos (in d2,d3)
;	direction in d4	($81 r,$82 l,$83 d,$84 u)
;	

	tst.w	nummoves
	bne	only_one_time

	bsr	dir2num
	
	move.w	d4,last_direction
	
	
	move.w	xpos,d2
	move.w	ypos,d3

	;move.w	savexy,d2
	;move.w	savexy+2,d3
	bsr	where_am_i
	move.w	d2,d4
	
	tst.w	d4
	beq	.is_e_low
	move.w	lastheight,d0
	tst.w	d0
	bne	.alles_paletti
	move.w	#1,lastheight
	move.w	#0,d4
	bra	.alles_paletti
.is_e_low
	move.w	d4,lastheight
.alles_paletti

	bsr	putdir

	;bsr	put_a_mark

only_one_time:


	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	xoff,d0
	sub.w	yoff,d1
	move.w	d0,laterpsetxy
	move.w	d1,laterpsetxy+2

	bsr	put_in_queue	

	move.l	xpos,savexy2
	bsr	clear_a_tile	;Boden neu aufbauen
	move.l	savexy2,xpos

	
	tst.w	insert
	bne	noinsert
	bsr	savemoves
	bsr	kill_last_segment
	bsr	restoremoves
noinsert:

	move.l	posstart,d0	;2. Teil (hinter dem Kopf)
	sub.l	#4*8,d0
	cmp.l	#positions,d0
	bge	.no_under_pos
	add.l	#400*4*8,d0
.no_under_pos
	move.l	d0,a0
	move.w	(a0),xpos
	move.w	2(a0),ypos
	move.l	xpos,clrsave2

	bsr	seccopy

	;move.l	savexy2,xpos
	;bsr	checkon
	;bsr	checkunder	

	move.l	savexy2,xpos

	move.l	#flups,d2	;Kopf hineinkopieren
	add.l	head,d2
	move.l	d2,activehead

	bsr	maskflups

	bsr	secflups

	move.w	#1,may_put_body
	bsr	removefruit

	move.l	savexy2,xpos

	move.w	flupssize,d1	;vorletzten Teil neu aufbauen
	lsl.w	#5,d1
	and.l	#$ffff,d1
	
	move.l	posstart,d0
	sub.l	d1,d0
	cmp.l	#positions,d0
	bge	.no_under_pos2bbb
	add.l	#400*4*8,d0
.no_under_pos2bbb
	move.l	d0,a0

	move.w	nummoves,d1
	addq.w	#2,d1
	add.w	d1,d1
	and.w	#$ffff,d1
	sub.l	d1,d0
	cmp.l	#positions,d0
	bge	.no_under_pos22bbb
	add.l	#400*4*8,d0
.no_under_pos22bbb
	move.l	d0,a1

	move.l	(a0),d0
	move.w	d0,d1
	swap	d0

	move.w	d0,xpos
	move.w	d1,ypos
	bsr	savemoves
	move.l	(a1),clrsave
	move.l	a0,a1
	bsr	getdirection
	
	cmp.w	#0,nummoves
	bne	set_dir
	move.l	mright,allmoves
	move.l	mup,allmoves+4
set_dir:

	cmp.w	#0,nummoves
	beq	dir_allready_set
	move.l	allmoves,mright
	move.l	allmoves+4,mup
dir_allready_set:

	move.l	#flups+88*4*6,d2
	move.l	d2,activehead
	bsr	maskflups
	move.l	savexy2,xpos
	bsr	restoremoves

	move.l	savexy2,xpos

	bsr	checkon
	bsr	checkunder	

nolast:


	add.w	#2,nummoves
	cmp.w	#16,nummoves
	bne	is_not_moving
	move.w	oldmove,oldmove2
	move.w	#1,movedone
	move.w	#0,insert
	move.w	#0,nummoves
	move.w	#0,moving
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#0,mleft

	bsr	savedir
	bsr	cleardir

	move.w	clrxpos,d0
	move.w	clrxpos+2,d1
	bsr	putblock


is_not_moving:
	rts


movedone: dc.w  0
clrsave2: dc.l  0


clear_a_tile:
	move.w	#1,mode
	move.w 	clrxpos,d0
	move.w 	clrypos,d1
	move.w	d0,xpos
	move.w	d1,ypos
	bsr	puttilemask
	bsr	checkon
	bsr	checkunder	
	bsr	do_the_rest
	bsr	clrtile		
	move.w	#0,mode
	rts



jumptab:
	dc.l	overlaptab0
	dc.l	overlaptab1
	dc.l	overlaptab2
	dc.l	overlaptab3
	dc.l	overlaptab4
	dc.l	overlaptab5
	dc.l	overlaptab6
	dc.l	overlaptab7

		;Nr.,Dir,dataoffset,xoff,yoff
overlaptab0:
	dc.w	1,$83,-20,0,-14
	dc.w	3,$81,-1,-14,0
	dc.w	40,$82,1,14,0	
	dc.w	41,$81,1,18,0	
	dc.w	42,$84,1,16,-2	
	dc.w	43,$83,1,16,2
	dc.w	70,$83,20,0,18	
	dc.w	71,$82,20,-2,16	
	dc.w	72,$84,20,0,14	
	dc.w	73,$81,20,2,16
	dc.w	80,$83,21,16,18	
	dc.w	81,$82,21,14,16	
	dc.w	82,$84,21,16,14	
	dc.w	83,$81,21,18,16	
	dc.w	-1

overlaptab1:
	dc.w	1,$83,-20,0,-12
	dc.w	3,$81,-1,-12,0
	dc.w	40,$82,1,12,0	
	dc.w	41,$81,1,20,0	
	dc.w	42,$84,1,16,-4
	dc.w	43,$83,1,16,4
	dc.w	70,$83,20,0,20	
	dc.w	71,$82,20,-4,16	
	dc.w	72,$84,20,0,12	
	dc.w	73,$81,20,4,16
	dc.w	80,$83,21,16,20	
	dc.w	81,$82,21,12,16	
	dc.w	82,$84,21,16,12
	dc.w	83,$81,21,20,16	
	dc.w	-1

overlaptab2:
	dc.w	1,$83,-20,0,-10
	dc.w	2,$83,-19,16,-10
	dc.w	3,$81,-1,-10,0
	dc.w	40,$82,1,10,0	
	dc.w	42,$84,1,16,-6
	dc.w	43,$83,1,16,6
	dc.w	6,$81,19,-10,16
	dc.w	71,$82,20,-6,16	
	dc.w	72,$84,20,0,10	
	dc.w	73,$81,20,6,16
	dc.w	81,$82,21,10,16	
	dc.w	82,$84,21,16,10
	dc.w	-1

overlaptab3:
	dc.w	1,$83,-20,0,-8
	dc.w	2,$83,-19,16,-8
	dc.w	3,$81,-1,-8,0
	dc.w	40,$82,1,8,0	
	dc.w	42,$84,1,16,-8
	dc.w	43,$83,1,16,8
	dc.w	6,$81,19,-8,16
	dc.w	71,$82,20,-8,16	
	dc.w	72,$84,20,0,8	
	dc.w	73,$81,20,8,16
	dc.w	81,$82,21,8,16	
	dc.w	82,$84,21,16,8
	dc.w	-1

overlaptab4:
	dc.w	1,$83,-20,0,-6
	dc.w	2,$83,-19,16,-6
	dc.w	3,$81,-1,-6,0
	dc.w	40,$82,1,6,0	
	dc.w	42,$84,1,16,-10
	dc.w	43,$83,1,16,10
	dc.w	6,$81,19,-6,16
	dc.w	71,$82,20,-10,16	
	dc.w	72,$84,20,0,6	
	dc.w	73,$81,20,10,16
	dc.w	81,$82,21,6,16	
	dc.w	82,$84,21,16,6
	dc.w	-1

overlaptab5:
	dc.w	1,$83,-20,0,-4
	dc.w	2,$83,-19,16,-4
	dc.w	3,$81,-1,-4,0
	dc.w	40,$82,1,4,0	
	dc.w	43,$83,1,16,12
	dc.w	5,$82,2,20,0
	dc.w	6,$81,19,-4,16
	dc.w	72,$84,20,0,4	
	dc.w	73,$81,20,12,16
	dc.w	81,$82,21,4,16	
	dc.w	82,$84,21,16,4
	dc.w	9,$84,40,0,20
	dc.w	10,$84,41,16,20
	dc.w	11,$82,22,20,16
	dc.w	-1

overlaptab6:
	dc.w	1,$83,-20,0,-2
	dc.w	2,$83,-19,16,-2
	dc.w	3,$81,-1,-2,0
	dc.w	40,$82,1,2,0	
	dc.w	43,$83,1,16,14
	dc.w	5,$82,2,18,0
	dc.w	6,$81,19,-2,16
	dc.w	72,$84,20,0,2	
	dc.w	73,$81,20,14,16
	dc.w	81,$82,21,2,16	
	dc.w	82,$84,21,16,2
	dc.w	9,$84,40,0,18
	dc.w	10,$84,41,16,18
	dc.w	11,$82,22,18,16
	dc.w	-1

overlaptab7:
	dc.w	1,$83,-20,0,0
	dc.w	2,$83,-19,16,0
	dc.w	3,$81,-1,0,0
	dc.w	40,$82,1,0,0	
	dc.w	43,$83,1,16,16
	dc.w	5,$82,2,16,0
	dc.w	6,$81,19,0,16
	dc.w	72,$84,20,0,0	
	dc.w	73,$81,20,16,16
	dc.w	81,$82,21,0,16	
	dc.w	82,$84,21,16,0
	dc.w	9,$84,40,0,16
	dc.w	10,$84,41,16,16
	dc.w	11,$82,22,16,16
	dc.w	-1

may_put_body:	dc.w	0



smode:	dc.w	0

removefruit:
	move.l	clrsave,xpos
	bsr	addtilemask

	move.l	savexy2,xpos

	tst.w	may_put_body
	beq	.not_put
	move.w	xpos,d0
	move.w	ypos,d1
	subq.w	#6,d0
	bsr	put_a_body_mask
.not_put
	
	tst.w	smode
	beq	.no_puck_moving

	move.w	flycount,d0
	move.w	#8,d1
	sub.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	and.l	#$ff,d1

	add.l	#32,d1

	move.l	posend,d0
	add.l	d1,d0
	cmp.l	#positions+400*4*8,d0
	blt	.not_over
	sub.l	#400*4*8,d0
.not_over
	move.l	d0,a0
	
	move.w	(a0),d0
	move.w	2(a0),d1

	subq.w	#6,d0
	bsr	put_a_body_mask
	
.no_puck_moving

	move.w	nummoves,d0
	add.w	d0,d0
	lea	jumptab,a0
	move.l	(a0,d0.w),a1


	move.w	clrsave,d5
	move.w	clrsave+2,d6

	move.w	d5,d0
	move.w	d6,d1
	lea	dirbuffer,a2
	lea	dirbuffer2,a3
	lea	dirbuffer3,a4
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	
	add.l	d1,a2
	add.l	d1,a3
	add.l	d1,a4
	

	move.b	(a2),d0

	cmp.b	#9,d0
	bls	.couldbe
	bra	checkarea
.couldbe
	cmp.b	#1,d0
	beq	checkarea	
	cmp.b	#0,d0
	beq	checkarea	
	rts

checkarea:
	move.w	(a1)+,d0
	cmp.w	#-1,d0
	beq	endoftab
	move.w	(a1)+,d2	;Richtung
	move.w	(a1)+,d3	;Datenoffset
	move.w	(a1)+,d0	;xoff
	move.w	(a1)+,d1	;yoff
	;cmp.b	(a2,d3.w),d2
	;beq	.nextstep
	cmp.b	(a3,d3.w),d2	;Dirbuffer2 / lower
	beq	.nextstep
	cmp.b	(a4,d3.w),d2	;Dirbuffer3 / upper
	beq	.nextstep
	bra	checkarea
	
.nextstep

	move.b	(a2,d3.w),d5
	move.w	d2,d4
	add.w	clrsave,d0
	add.w	clrsave+2,d1

	move.w	d0,d2
	move.w	d1,d3

	cmp.b	#9,d5
	bls	.couldbe
	bra	.no_offset_needed
.couldbe
	cmp.b	#1,d5
	beq	checkarea	
	cmp.b	#0,d5
	beq	checkarea	
	bsr	where_am_i

.no_offset_needed
	subq.w	#6,d0
	bsr	put_a_body_mask
	
	bra	checkarea
	
endoftab:		

	move.l	clrsave,xpos

	move.w	xpos,d0
	move.w	ypos,d1

	add.w	#6,d1	
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	move.l	d0,d2
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4

	add.l	bitplanes,d2
	add.l	#40*182*4*8,d2

	move.l	aktivepos2,d1

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	#$0fe2,bltcon0(a5)
	move.w	#36+40*3,bltamod(a5)
	move.w	#36,bltbmod(a5)
	move.w	#36+40*3,bltcmod(a5)
	move.w	#36+40*3,bltdmod(a5)

	bsr	xcopy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	xcopy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	xcopy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	xcopy_one_plane2

	rts
			
xcopy_one_plane2:
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d2,bltapth(a5)
	move.l	d1,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#16*64+2,bltsize(a5)
	rts	
	

addtilemask:
	move.w	xpos,d0
	move.w	ypos,d1
	add.w	#6,d1
	mulu	#40,d1
	move.w	d0,d4
	and.w	#$f,d4
	ror.w	#4,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d0,d1
	add.l	maskbuffer,d1
	move.l	d1,aktivepos2
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	or.w	#$09f0,d4
	move.w	d4,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	#tile,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#16*64+2,bltsize(a5)
	rts

aktivepos2:	dc.l	0

	
savemoves:
	move.w	mup,omoves
	move.w	mdown,omoves+2
	move.w	mleft,omoves+4
	move.w	mright,omoves+6
	move.l	clrsave,oclrsave
	rts
	
restoremoves:
	move.w	omoves,mup
	move.w	omoves+2,mdown
	move.w	omoves+4,mleft
	move.w	omoves+6,mright
	move.l	oclrsave,clrsave
	rts


nummoves:	dc.w	0
insert:		dc.w	0
laterpsetxy:	dc.l	0
rememberxy:	dc.l	0
rememberdirs:	dc.l	0,0

kill_last_segment:
	move.l	posend,a0
	move.l	a0,a1

	bsr	getdirection
	
	move.l	segx,xpos

	cmp.w	#0,nummoves
	bne	set_dir2
	move.l	posend,d0
	sub.l	#4,d0
	cmp.l	#positions,d0
	bge	.no_under
	add.l	#400*4*8,d0
.no_under
	move.l	d0,a0
	move.l	(a0),rememberxy
	move.l	mright,rememberdirs
	move.l	mup,rememberdirs+4
set_dir2:

	cmp.w	#0,nummoves
	beq	dir_allready_set2
	move.l	rememberdirs,mright
	move.l	rememberdirs+4,mup
dir_allready_set2:

	bsr	checkon
	bsr	checkunder	

	move.l	xpos,d2
	move.l	d2,save4chckseg2
	move.w	d2,d3
	swap	d2
	sub.w	xoff,d2
	sub.w	yoff,d3
	move.w	d2,segx
	move.w	d3,segy	

	bsr	copyflups2
	rts

save4chckseg2:	dc.l	0
saxpos22:	dc.l	0

copyflups2:
	bsr	putflupsmask		;needs xpos,ypos,xoff,yoff

	bsr	checkon
	bsr	checkunder
	bsr	do_the_rest

	move.l	rememberxy,d0
	move.l	clrsave,rememberxy
	move.l	d0,clrsave

	bsr	checksegments

	move.l	rememberxy,d0
	move.l	clrsave,rememberxy
	move.l	d0,clrsave

	move.l	segx,xpos		;segx=xpos+xoff

	move.w	segx,d0
	move.w	segy,d1
	sub.w	#6,d0
	
	mulu	#160,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	move.l	d0,d2
	add.l	activeplanes,d0

	move.l	d2,d4		;Offset für restorescreen
	add.l	restorebuffer,d4

	add.l	bitplanes,d2
	add.l	#40*182*4*8,d2	;9. Screen ist Original

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d4,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*4*64+3,bltsize(a5)

	bsr	what2restore
	bsr	restorethewall

	move.l	d4,d2	

	move.l	aktivepos,d1

	bsr	waitblit
	
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	#$0fe2,bltcon0(a5)
	move.w	#34+40*3,bltamod(a5)
	move.w	#34,bltbmod(a5)
	move.w	#34+40*3,bltcmod(a5)
	move.w	#34+40*3,bltdmod(a5)

	bsr	copy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	copy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	copy_one_plane2
	add.l	#40,d2
	add.l	#40,d0
	bsr	copy_one_plane2
	rts
			
copy_one_plane2:
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d2,bltapth(a5)
	move.l	d1,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#22*64+3,bltsize(a5)
	rts


look4special:
	movem.l	d0-d7/a0-a6,-(sp)

	cmp.w	#1,mleft
	bne	.not_m_left	
	
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d0
        lea	dirbuffer,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a3

	move.b	(a3),d0
	cmp.b	#4,d0
	bne	.nottype4
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d0
	sub.w	#16,d1
	bsr	putspec1	
.nottype4

	move.b	1(a3),d0
	cmp.b	#4,d0
	bne	.nottype42
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d1
	bsr	putspec1	
.nottype42

.not_m_left



	cmp.w	#1,mup
	bne	.not_m_up
	
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d1
        lea	dirbuffer,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a3

	move.b	(a3),d0
	cmp.b	#6,d0
	bne	.nottype6
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d0
	sub.w	#16,d1
	bsr	putspec2	
.nottype6
	

	move.b	20(a3),d0
	cmp.b	#6,d0
	bne	.nottype62
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	sub.w	#16,d0
	bsr	putspec2	
.nottype62

.not_m_up



	movem.l	(sp)+,d0-d7/a0-a6
	rts


putspec1:
	add.w	#12,d1

	sub.w	#6,d0
	mulu	#160,d1	

	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	#wall+6*4*12,d5
	move.l	#special+6*4*9,d6

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d5,bltapth(a5)
	move.l	d6,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#8*4*64+3,bltsize(a5)
	rts


putspec2:
	sub.w	#6,d0
	mulu	#160,d1	

	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	#wall,d5
	move.l	#special,d6

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d5,bltapth(a5)
	move.l	d6,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#9*4*64+3,bltsize(a5)
	rts



waitblit:
	move.l	gfxbase,a6
	jsr	-228(a6)
	rts

vposup:
vpos11
	tst.b	5(a5)
	beq	vpos11
vpos22
	tst.b	5(a5)
	bne	vpos22
	rts

vposdown:
vpos1
	tst.b	5(a5)
	bne	vpos1
vpos2
	tst.b	5(a5)
	beq	vpos2
	rts


restorethewall:
	;tst.w	abridge
	;beq	getscho
	
	;bra	getscho
	
	tst.w	btype
	beq	xnotonabridge
	bra	look4special
xnotonabridge:
	tst.w	btype2
	beq	xnotonabridge2
	bra	look4special
xnotonabridge2:


getscho:

	movem.l	d0-d6/a0/a3/a4,-(sp)	

	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	
	move.w	d0,d2
	move.w	d1,d3
	
        lea	dirbuffer,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a3


;********************
;* downdowndowndown
;********************
	tst.w	mdown
	beq	downdown
	move.w	#-20,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall1
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d1
	bsr	putwallpart1
.reswall1

	move.w	#-1,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall2
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	bsr	putwallpart2
.reswall2

	move.w	#19,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	add.w	#16,d1
	bsr	putwallpart2
.reswall3
downdown:


;********************
;* upupupupupupup
;********************
	tst.w	mup
	beq	upupup
	move.w	#-40,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall1
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#32,d1
	bsr	putwallpart1
.reswall1

	move.w	#-21,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall2
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	sub.w	#16,d1
	bsr	putwallpart2
.reswall2

	move.w	#-1,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	bsr	putwallpart2
.reswall3
upupup:


;********************
;* rightrightright
;********************
	tst.w	mright
	beq	rightright
	move.w	#-20,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall1
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d1
	bsr	putwallpart1
.reswall1

	move.w	#-19,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall2
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	sub.w	#16,d1
	bsr	putwallpart1
.reswall2

	move.w	#-1,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	bsr	putwallpart2
.reswall3
rightright:


;********************
;* leftleftleft
;********************
	tst.w	mleft
	beq	leftleft
	move.w	#-21,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall1
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d1
	sub.w	#16,d0
	bsr	putwallpart1
.reswall1

	move.w	#-20,d1	
	cmp.b	#1,(a3,d1.w)
	bne	.reswall2
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d1
	bsr	putwallpart1
.reswall2

	move.w	#-2,d1
	cmp.b	#1,(a3,d1.w)
	bne	.reswall3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#32,d0
	bsr	putwallpart2
.reswall3
leftleft:




	movem.l	(sp)+,d0-d6/a0/a3/a4
	rts

vergises:
	rts

putwallpart1:
	sub.w	#6,d0		;for top
	add.w	#15,d1
	tst.w	d0
	bmi	vergises
	
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	;add.l	activeplanes,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	#wall+15*6*4,d5
	move.l	#wall_m+15*6*4,d6

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d5,bltapth(a5)
	move.l	d6,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#7*4*64+3,bltsize(a5)
	rts

putwallpart2:
	sub.w	#6,d0
	mulu	#160,d1		;for side
	tst.w	d0
	bmi	vergises

	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	;add.l	activeplanes,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	#wall,d5
	move.l	#wall_m,d6

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d5,bltapth(a5)
	move.l	d6,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*4*64+3,bltsize(a5)
	rts



segx:	dc.w	0
segy:	dc.w	0


what2restore:
	;tst.w	abridge
	;beq	getscho2

	;rts

	;tst.w	btype
	;beq	xxnotonabridge
	;rts
xxnotonabridge:
	;tst.w	btype2
	;beq	xxnotonabridge2
	;rts
xxnotonabridge2:

getscho2:

	movem.l	d0-d6/a0/a3/a4,-(sp)	

	bsr	dir2num
	
	move.w	d4,mydir

	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	move.w	d0,d2
	move.w	d1,d3
	
	bsr	where_am_i
	move.w	d2,myprio

	
	move.l	rememberxy,d0
	move.w	d0,d1
	swap	d0
	move.w	d0,d2
	move.w	d1,d3
	
        lea	dirbuffer,a2
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a2

	lea	dirbuffer2,a3
	add.l	d1,a3
	lea	dirbuffer3,a4
	add.l	d1,a4
	
;needs MYPRIO,MYDIR
;some offsets in:
;	a2 dirbuffer 
;	a3 dirbuffer2 
;	a4 dirbuffer3 

	bsr	remove_unneeded


	bsr	getrestab

checkthem:
	move.w	(a1)+,d0
	cmp.w	#-1,d0
	beq	endoflist2

	move.w	(a1)+,d0 ;Dir
	move.w	(a1)+,d1 ;DataOffset
	move.w	(a1)+,d5 ;xoff
	move.w	(a1)+,d6 ;yoff
	move.w	(a1)+,d7 ;type
	
	cmp.b	(a2,d1.w),d0
	beq	.nextstep
	cmp.b	(a3,d1.w),d0	;Dirbuffer2 / lower
	beq	.nextstep
	cmp.b	(a4,d1.w),d0	;Dirbuffer3 / upper
	beq	.nextstep
	bra	checkthem

.nextstep

;returns: real x and real y in d0,d1
;	  up/low = 1/0 in d2
;needs:	active xpos,ypos (in d2,d3)
;	direction in d4	($81 r,$82 l,$83 d,$84 u)
;	

	move.w	d0,d4

	move.w	rememberxy,d2
	move.w	rememberxy+2,d3
	add.w	d5,d2
	add.w	d6,d3
	bsr	where_am_i

	movem.w	d0/d1,-(sp)

	bsr	taketheright

	movem.w	(sp)+,d0/d1

	tst.w	showmepos
	beq	.notshowing
	
	;subq.w	#6,d0
	;bsr	put_a_mark
.notshowing

	bra	checkthem
	

endoflist2:
	bsr	restore_areas

	movem.l	(sp)+,d0-d6/a0/a3/a4
	rts


taketheright:
	subq.w	#1,d7
	lea	jmplist,a0
	and.l	#$ffff,d7
	add.w	d7,d7
	add.w	d7,d7
	add.l	d7,a0
	jmp	(a0)
	
jmplist:
	bra	putres1
	bra	putres2
	bra	putres3
	bra	putres4
	bra	putres5

getrestab:
	tst.w	mup
	beq	noupmov
	clr.l	d0
	move.w	nummoves,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	.tab0,a1
	add.l	d0,a1
	jmp	(a1)	
.tab0
	lea	restab0up,a1
	rts
	lea	restab2up,a1
	rts
	lea	restab4up,a1
	rts
	lea	restab6up,a1
	rts
	lea	restab8up,a1
	rts
	lea	restab10up,a1
	rts
	lea	restab12up,a1
	rts
	lea	restab14up,a1
	rts
noupmov:


	tst.w	mdown
	beq	nodownmov
	clr.l	d0
	move.w	nummoves,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	.tab0,a1
	add.l	d0,a1
	jmp	(a1)	
.tab0
	lea	restab0down,a1
	rts
	lea	restab2down,a1
	rts
	lea	restab4down,a1
	rts
	lea	restab6down,a1
	rts
	lea	restab8down,a1
	rts
	lea	restab10down,a1
	rts
	lea	restab12down,a1
	rts
	lea	restab14down,a1
	rts
nodownmov:


	tst.w	mright
	beq	norightmov
	clr.l	d0
	move.w	nummoves,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	.tab0,a1
	add.l	d0,a1
	jmp	(a1)	
.tab0
	lea	restab0right,a1
	rts
	lea	restab2right,a1
	rts
	lea	restab4right,a1
	rts
	lea	restab6right,a1
	rts
	lea	restab8right,a1
	rts
	lea	restab10right,a1
	rts
	lea	restab12right,a1
	rts
	lea	restab14right,a1
	rts
norightmov:


	tst.w	mleft
	beq	noleftmov
	clr.l	d0
	move.w	nummoves,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	.tab0,a1
	add.l	d0,a1
	jmp	(a1)	
.tab0
	lea	restab0left,a1
	rts
	lea	restab2left,a1
	rts
	lea	restab4left,a1
	rts
	lea	restab6left,a1
	rts
	lea	restab8left,a1
	rts
	lea	restab10left,a1
	rts
	lea	restab12left,a1
	rts
	lea	restab14left,a1
	rts
noleftmov:

	rts


		;Nr.,Dir.,DataOffset,xoff,yoff,type
restab0up:	dc.w	12,$84,-21,-16,-18,5
		dc.w	4,$82,-21,-18,-16,5
		dc.w	2,$83,-21,-16,-14,2
		dc.w	10,$84,-1,-16,-2,2
		dc.w	7,$82,-1,-18,0,2
		dc.w	1,$83,-1,-16,2,2
		dc.w	-1,0,0,0,0,0
restab2up:	dc.w	12,$84,-21,-16,-20,5
		dc.w	2,$83,-21,-16,-12,2
		dc.w	10,$84,-1,-16,-4,2
		dc.w	1,$83,-1,-16,4,2
		dc.w	-1,0,0,0,0,0
restab4up:	dc.w	12,$84,-21,-16,-22,5
		dc.w	2,$83,-21,-16,-10,2
		dc.w	10,$84,-1,-16,-6,2
		dc.w	1,$83,-1,-16,6,2
		dc.w	-1,0,0,0,0,0
restab6up:	dc.w	12,$84,-21,-16,-24,5
		dc.w	3,$83,-41,-16,-24,2
		dc.w	2,$83,-21,-16,-8,2	
		dc.w	10,$84,-1,-16,-8,2
		dc.w	-1,0,0,0,0,0
restab8up:	dc.w	12,$84,-21,-16,-26,5
		dc.w	3,$83,-41,-16,-22,2
		dc.w	2,$83,-21,-16,-6,2	
		dc.w	10,$84,-1,-16,-10,2
		dc.w	-1,0,0,0,0,0
restab10up:	dc.w	12,$84,-21,-16,-28,5
		dc.w	13,$81,-41,-4,-32,4
		dc.w	3,$83,-41,-16,-20,2
		dc.w	6,$81,-22,-20,-16,2
		dc.w	2,$83,-21,-16,-4,2	
		dc.w	10,$84,-1,-16,-12,2
		dc.w	-1,0,0,0,0,0
restab12up:	dc.w	12,$84,-21,-16,-30,5
		dc.w	13,$81,-41,-2,-32,4
		dc.w	9,$82,-40,-14,-32,5
		dc.w	8,$82,-39,2,-32,4
		dc.w	14,$83,-60,0,-34,4
		dc.w	3,$83,-41,-16,-18,2
		dc.w	6,$81,-22,-18,-16,2
		dc.w	2,$83,-21,-16,-2,2
		dc.w	10,$84,-1,-16,-14,2
		dc.w	-1,0,0,0,0,0
restab14up:	dc.w	12,$84,-21,-16,-32,5
		dc.w	13,$81,-41,0,-32,4
		dc.w	9,$82,-40,-16,-32,5
		dc.w	8,$82,-39,0,-32,4
		dc.w	14,$83,-60,0,-32,4
		dc.w	5,$83,-61,-16,-32,5
		dc.w	11,$81,-42,-16,-32,5
		dc.w	3,$83,-41,-16,-16,2
		dc.w	6,$81,-22,-16,-16,2
		dc.w	2,$83,-21,-16,-0,2
		dc.w	10,$84,-1,-16,-16,2
		dc.w	-1,0,0,0,0,0




restab0down:	dc.w	13,$83,-21,-16,-14,5
		dc.w	8,$81,-21,-14,-16,4
		dc.w	9,$81,-20,2,-16,4
		dc.w	11,$84,-20,0,-18,3
		dc.w	10,$82,-20,-2,-16,4
		dc.w	1,$84,-1,-16,-2,2
		dc.w	5,$82,-20,-2,-16,4
		dc.w	12,$83,-1,-16,2,2
		dc.w	4,$82,-1,-18,0,2
		dc.w	-1,0,0,0,0,0
restab2down:	dc.w	13,$83,-21,-16,-12,5
		dc.w	10,$82,-20,-4,-16,4
		dc.w	1,$84,-1,-16,-4,2
		dc.w	5,$82,-20,-4,-16,4
		dc.w	4,$82,-1,-20,0,2
		dc.w	12,$83,-1,-16,4,2
		dc.w	2,$84,19,-16,12,2
		dc.w	-1,0,0,0,0,0
restab4down:	dc.w	13,$83,-21,-16,-10,5
		dc.w	1,$84,-1,-16,-6,2
		dc.w	12,$83,-1,-16,6,2
		dc.w	2,$84,19,-16,10,2
		dc.w	-1,0,0,0,0,0
restab6down:	dc.w	13,$83,-21,-16,-8,5
		dc.w	1,$84,-1,-16,-8,2
		dc.w	2,$84,19,-16,8,2
		dc.w	12,$83,-1,-16,8,2
		dc.w	-1,0,0,0,0,0
restab8down:	dc.w	13,$83,-21,-16,-6,5
		dc.w	12,$83,-1,-16,10,2
		dc.w	2,$84,19,-16,6,2
		dc.w	-1,0,0,0,0,0
restab10down:	dc.w	13,$83,-21,-16,-4,5
		dc.w	2,$84,19,-16,4,2
		dc.w	12,$83,-1,-16,12,2
		dc.w	3,$84,39,-16,20,2
		dc.w	-1,0,0,0,0,0
restab12down:	dc.w	13,$83,-21,-16,-2,5
		dc.w	7,$81,-2,-18,0,4
		dc.w	2,$84,19,-16,2,2
		dc.w	3,$84,39,-16,18,2
		dc.w	12,$83,-1,-16,14,2
		dc.w	6,$81,18,-18,16,2
		dc.w	-1,0,0,0,0,0
restab14down:	dc.w	13,$83,-21,-16,0,5
		dc.w	7,$81,-2,-16,0,5
		dc.w	2,$84,19,-16,0,2
		dc.w	3,$84,39,-16,16,2
		dc.w	12,$83,-1,-16,16,2
		dc.w	6,$81,18,-16,16,2
		dc.w	-1,0,0,0,0,0




restab0right:	dc.w	5,$83,-21,-16,-14,2
		dc.w	10,$81,-21,-14,-16,5
		dc.w	1,$82,-20,-2,-16,4
		dc.w	9,$81,-20,2,-16,4
		dc.w	7,$84,-20,0,-18,4
		dc.w	4,$83,-1,-16,2,2
		dc.w	6,$82,-1,-18,0,2
		dc.w	8,$84,-1,-16,-2,2
		dc.w	-1,0,0,0,0,0
restab2right:	dc.w	10,$81,-21,-12,-16,5
		dc.w	1,$82,-20,-4,-16,4
		dc.w	7,$84,-20,0,-20,4
		dc.w	9,$81,-20,4,-16,4
		dc.w	2,$82,-19,12,-16,4
		dc.w	8,$84,-1,-16,-4,2
		dc.w	-1,0,0,0,0,0
restab4right:	dc.w	10,$81,-21,-10,-16,5
		dc.w	1,$82,-20,-6,-16,4
		dc.w	9,$81,-20,6,-16,4
		dc.w	2,$82,-19,10,-16,4
		dc.w	-1,0,0,0,0,0
restab6right:	dc.w	10,$81,-21,-8,-16,5
		dc.w	1,$82,-20,-8,-16,4
		dc.w	9,$81,-20,8,-16,4
		dc.w	2,$82,-19,8,-16,4
		dc.w	-1,0,0,0,0,0
restab8right:	dc.w	10,$81,-21,-6,-16,5
		dc.w	9,$81,-20,10,-16,4
		dc.w	2,$82,-19,6,-16,4
		dc.w	-1,0,0,0,0,0
restab10right:	dc.w	10,$81,-21,-4,-16,5
		dc.w	9,$81,-20,12,-16,4
		dc.w	2,$82,-19,4,-16,4
		dc.w	3,$82,-18,20,-16,4
		dc.w	-1,0,0,0,0,0
restab12right:	dc.w	10,$81,-21,-2,-16,5
		dc.w	9,$81,-20,14,-16,4
		dc.w	12,$83,-40,0,-18,5
		dc.w	2,$82,-19,2,-16,4
		dc.w	11,$83,-39,16,-18,4
		dc.w	3,$82,-18,18,-16,4
		dc.w	-1,0,0,0,0,0
restab14right:	dc.w	10,$81,-21,0,-16,5
		dc.w	9,$81,-20,16,-16,4
		dc.w	12,$83,-40,0,-16,5
		dc.w	2,$82,-19,0,-16,4
		dc.w	11,$83,-39,16,-16,4
		dc.w	3,$82,-18,16,-16,4
		dc.w	-1,0,0,0,0,0



restab0left:	dc.w	9,$84,-21,-16,-18,4
		dc.w	7,$82,-21,-18,-16,5
		dc.w	13,$84,-20,0,-18,4
		dc.w	8,$82,-20,-2,-16,4
		dc.w	2,$81,-21,-14,-16,4
		dc.w	1,$81,-20,2,-16,4
		dc.w	-1,0,0,0,0,0
restab2left:	dc.w	7,$82,-21,-20,-16,5
		dc.w	8,$82,-20,-4,-16,4
		dc.w	2,$81,-21,-12,-16,4
		dc.w	1,$81,-20,4,-16,4
		dc.w	-1,0,0,0,0,0
restab4left:	dc.w	7,$82,-21,-22,-16,5
		dc.w	8,$82,-20,-6,-16,4
		dc.w	2,$81,-21,-10,-16,4
		dc.w	-1,0,0,0,0,0
restab6left:	dc.w	7,$82,-21,-24,-16,5
		dc.w	8,$82,-20,-8,-16,4
		dc.w	3,$81,-22,-24,-16,4
		dc.w	2,$81,-21,-8,-16,4
		dc.w	-1,0,0,0,0,0
restab8left:	dc.w	7,$82,-21,-26,-16,5
		dc.w	8,$82,-20,-10,-16,4
		dc.w	3,$81,-22,-22,-16,4
		dc.w	2,$81,-21,-6,-16,4
		dc.w	-1,0,0,0,0,0
restab10left:	dc.w	7,$82,-21,-28,-16,5
		dc.w	6,$83,-41,-16,-20,4
		dc.w	8,$82,-20,-12,-16,4
		dc.w	3,$81,-22,-20,-16,4
		dc.w	2,$81,-21,-4,-16,4
		dc.w	10,$83,-22,-32,-4,2
		dc.w	-1,0,0,0,0,0
restab12left:	dc.w	7,$82,-21,-30,-16,5
		dc.w	6,$83,-41,-16,-18,4
		dc.w	8,$82,-20,-14,-16,4
		dc.w	3,$81,-22,-18,-16,4
		dc.w	5,$84,-2,-32,-14,4
		dc.w	4,$81,-3,-34,0,2
		dc.w	14,$84,18,-32,2,2
		dc.w	10,$83,-22,-32,-2,2
		dc.w	-1,0,0,0,0,0
restab14left:	dc.w	11,$83,-42,-32,-16,5
		dc.w	7,$82,-21,-32,-16,5
		dc.w	12,$81,-23,-32,-16,5
		dc.w	6,$83,-41,-16,-16,4
		dc.w	8,$82,-20,-16,-16,4
		dc.w	3,$81,-22,-16,-16,4
		dc.w	5,$84,-2,-32,-16,5
		dc.w	4,$81,-3,-32,0,2
		dc.w	14,$84,18,-32,0,2
		dc.w	10,$83,-22,-32,0,2
		dc.w	-1,0,0,0,0,0

	
putres1:
	add.w	#13,d0
	add.w	#7,d1
	tst.w	d0
	bmi	vergises

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	#restore,bltapth(a5)
	move.l	#restore_m,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#12*4*64+2,bltsize(a5)
	rts

putres2:
	add.w	#10,d0
	add.w	#4,d1
	tst.w	d0
	bmi	vergises

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	#restore+4*12*4,bltapth(a5)
	move.l	#restore_m+4*12*4,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#17*4*64+2,bltsize(a5)
	rts

putres3:
	add.w	#1,d0
	add.w	#19,d1
	tst.w	d0
	bmi	vergises

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	#restore+4*29*4,bltapth(a5)
	move.l	#restore_m+4*29*4,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#3*4*64+2,bltsize(a5)
	rts

putres4:
	add.w	#-2,d0
	add.w	#16,d1
	tst.w	d0
	bmi	vergises

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	#restore+4*33*4,bltapth(a5)
	move.l	#restore_m+4*33*4,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#6*4*64+2,bltsize(a5)
	rts

putres5:
	add.w	#8,d0
	add.w	#14,d1
	tst.w	d0
	bmi	vergises

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$0fff,d0
	add.l	d1,d0
	add.l	restorebuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	#restore+4*39*4,bltapth(a5)
	move.l	#restore_m+4*39*4,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#7*4*64+2,bltsize(a5)
	rts


getdirection:
	move.l	(a0),d0
	move.w	d0,d1
	swap	d0

	add.l	#4,a1
	cmp.l	#positions+400*4*8,a1
	blt	notoverpos
	sub.l	#400*4*8,a1
notoverpos:
	move.l	(a1),d2
	move.w	d2,d3
	swap	d2

	sub.w	d0,d2
	sub.w	d1,d3

	move.w	#0,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#0,mleft

	tst.w	d2
	bpl	notoleft
	tst.w	d3
	bne	notoleft
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#1,mleft
notoleft:
	tst.w	d2
	bmi	notoright
	tst.w	d3
	bne	notoright
	move.w	#0,mup
	move.w	#0,mdown
	move.w	#1,mright
	move.w	#0,mleft
notoright:
	tst.w	d3
	bpl	notoup
	tst.w	d2
	bne	notoup
	move.w	#1,mup
	move.w	#0,mdown
	move.w	#0,mright
	move.w	#0,mleft
notoup:
	tst.w	d3
	bmi	notodown
	tst.w	d2
	bne	notodown
	move.w	#0,mup
	move.w	#1,mdown
	move.w	#0,mright
	move.w	#0,mleft
notodown:

	move.w	d0,segx
	move.w	d1,segy
	rts
	
	
	
put_in_queue:
	move.l	posstart,a0
	addq.l	#4,a0
	cmp.l	#positions+400*4*8,a0
	blt	not_over_end
	move.l	#positions,a0
not_over_end:
	move.l	a0,posstart
	
	move.w	xpos,d0
	move.w	ypos,d1
	swap	d0
	move.w	d1,d0
	move.l	d0,(a0)

	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	xoff,d0
	sub.w	yoff,d1
	swap	d0
	move.w	d1,d0
	move.l	d0,(400*8*4+8)(a0)

	tst.w	insert
	bne	noinsert2

	move.l	posend,d0
	addq.l	#4,d0
	cmp.l	#positions+400*4*8,d0
	blt	not_over_posit
	move.l	#positions,d0
not_over_posit:
	move.l	d0,posend
noinsert2:
	rts

	 	dc.w	0
boff:	 	dc.w	0,0,0,0,0,1,2,3, 4,5,6,7,7,7,7,7, 7,7,7,7,6,5,3,2,1
		dc.w	0,0,0,0,0,0,0,0
boff2:	 	dc.w	7,7,7,7,7,6,5,4, 4,5,6,7,7,7,7,7

;boff:	 	dc.w	0,0,0,0,1,2,3,4, 6,7,8,8,8,8,8,8, 8,8,8,8,7,6,4,2,1
		;dc.w	0,0,0,0,0,0,0,0
;boff2:	 	dc.w	8,8,8,8,7,6,5,4, 4,5,6,7,8,8,8,8


brix:		dc.w	0
briy:		dc.w	0
brix2:		dc.w	0
briy2:		dc.w	0
brix3:		dc.w	0
briy3:		dc.w	0
btype:		dc.w	0
btype2:		dc.w	0
vlock:		dc.w	0
hlock:		dc.w	0


maskflups:
	bsr	checkon
	bsr	putflupsmask
	bsr	checkunder
	bsr	checksegments
	bsr	do_the_rest
	bsr	copyflups
	rts


;needs MYPRIO,MYDIR
;some offsets in:
;	a2 dirbuffer 
;	a3 dirbuffer2 
;	a4 dirbuffer3 
remove_unneeded:
	bsr	preserve_areas

	cmp.w	#1,myprio
	bne	fffnot_on_a_bridge

	cmp.w	#$84,mydir
	bne	fahre_nicht_nach_oben

	cmp.b	#2,(a2)
	bne	.not_on_type_2
	move.b	#0,-1(a2)
	move.b	#0,1(a2)
	move.b	#0,-1(a3)
	move.b	#0,1(a3)
	move.b	#0,-1(a4)
	move.b	#0,1(a4)
	move.b	#0,-2(a2)
	move.b	#0,2(a2)
	move.b	#0,-2(a3)
	move.b	#0,2(a3)
	move.b	#0,-2(a4)
	move.b	#0,2(a4)
	move.b	#0,(a2)
	move.b	#0,(a3)
.not_on_type_2


	cmp.b	#2,-20(a2)
	bne	.not_on_type_22
	move.b	#0,-1-20(a2)
	move.b	#0,1-20(a2)
	move.b	#0,-1-20(a3)
	move.b	#0,1-20(a3)
	move.b	#0,-1-20(a4)
	move.b	#0,1-20(a4)
	move.b	#0,-2-20(a2)
	move.b	#0,2-20(a2)
	move.b	#0,-2-20(a3)
	move.b	#0,2-20(a3)
	move.b	#0,-2-20(a4)
	move.b	#0,2-20(a4)
	move.b	#0,-20(a2)
	move.b	#0,-20(a3)
.not_on_type_22

fahre_nicht_nach_oben:


	cmp.w	#$83,mydir
	bne	fahre_nicht_nach_unten

	cmp.b	#2,40(a2)
	bne	.not_on_type_22
	move.b	#0,39(a2)
	move.b	#0,41(a2)
	move.b	#0,39(a3)
	move.b	#0,41(a3)
	move.b	#0,39(a4)
	move.b	#0,41(a4)
	move.b	#0,38(a2)
	move.b	#0,42(a2)
	move.b	#0,38(a3)
	move.b	#0,42(a3)
	move.b	#0,38(a4)
	move.b	#0,42(a4)
	move.b	#0,40(a2)
	move.b	#0,40(a3)
.not_on_type_22


	cmp.b	#2,20(a2)
	bne	.not_on_type_5
	move.b	#0,19(a2)
	move.b	#0,21(a2)
	move.b	#0,19(a3)
	move.b	#0,21(a3)
	move.b	#0,19(a4)
	move.b	#0,21(a4)
	move.b	#0,18(a2)
	move.b	#0,22(a2)
	move.b	#0,18(a3)
	move.b	#0,22(a3)
	move.b	#0,18(a4)
	move.b	#0,22(a4)
	move.b	#0,20(a2)
	move.b	#0,20(a3)
.not_on_type_5

	cmp.b	#2,(a2)
	bne	.not_on_type_2
	move.b	#0,-1(a2)
	move.b	#0,1(a2)
	move.b	#0,-1(a3)
	move.b	#0,1(a3)
	move.b	#0,-1(a4)
	move.b	#0,1(a4)
	move.b	#0,-2(a2)
	move.b	#0,2(a2)
	move.b	#0,-2(a3)
	move.b	#0,2(a3)
	move.b	#0,-2(a4)
	move.b	#0,2(a4)
	move.b	#0,(a2)
	move.b	#0,(a3)
.not_on_type_2

	cmp.b	#7,(a2)
	bne	.not_on_type_7
	move.b	#0,-21(a2)
	move.b	#0,-19(a2)
	move.b	#0,-21(a3)
	move.b	#0,-19(a3)
	move.b	#0,-21(a4)
	move.b	#0,-19(a4)
	move.b	#0,-22(a2)
	move.b	#0,-18(a2)
	move.b	#0,-22(a3)
	move.b	#0,-18(a3)
	move.b	#0,-22(a4)
	move.b	#0,-18(a4)
	move.b	#0,-20(a2)
	move.b	#0,-20(a3)
.not_on_type_7

	cmp.b	#8,(a2)
	bne	.not_on_type_8
	move.b	#0,-21(a2)
	move.b	#0,-19(a2)
	move.b	#0,-21(a3)
	move.b	#0,-19(a3)
	move.b	#0,-21(a4)
	move.b	#0,-19(a4)
	move.b	#0,-22(a2)
	move.b	#0,-18(a2)
	move.b	#0,-22(a3)
	move.b	#0,-18(a3)
	move.b	#0,-22(a4)
	move.b	#0,-18(a4)
	
	move.b	#0,-20(a2)
	move.b	#0,-20(a3)
.not_on_type_8


fahre_nicht_nach_unten:



	cmp.w	#$81,mydir
	bne	fahre_nicht_nach_rechts

	cmp.b	#4,1(a2)
	bne	.not_on_type_4
	move.b	#0,-18(a2)
	move.b	#0,22(a2)
	move.b	#0,-18(a3)
	move.b	#0,22(a3)
	move.b	#0,-18(a4)
	move.b	#0,22(a4)
	move.b	#0,-38(a2)
	move.b	#0,42(a2)
	move.b	#0,-38(a3)
	move.b	#0,42(a3)
	move.b	#0,-38(a4)
	move.b	#0,42(a4)
	move.b	#0,2(a2)
	move.b	#0,2(a3)	
.not_on_type_4

	cmp.b	#3,1(a2)
	bne	.not_on_type_3
	move.b	#0,-19(a2)
	move.b	#0,21(a2)
	move.b	#0,-19(a3)
	move.b	#0,21(a3)
	move.b	#0,-19(a4)
	move.b	#0,21(a4)
	move.b	#0,-39(a2)
	move.b	#0,41(a2)
	move.b	#0,-39(a3)
	move.b	#0,41(a3)
	move.b	#0,-39(a4)
	move.b	#0,41(a4)
	move.b	#0,1(a2)
	move.b	#0,1(a3)	
.not_on_type_3


	cmp.b	#5,1(a2)
	bne	.not_on_type_5
	move.b	#0,-20(a2)
	move.b	#0,20(a2)
	move.b	#0,-20(a3)
	move.b	#0,20(a3)
	move.b	#0,-20(a4)
	move.b	#0,20(a4)
	move.b	#0,-40(a2)
	move.b	#0,40(a2)
	move.b	#0,-40(a3)
	move.b	#0,40(a3)
	move.b	#0,-40(a4)
	move.b	#0,40(a4)
	move.b	#0,(a2)
	move.b	#0,(a3)	
.not_on_type_5

	cmp.b	#5,(a2)
	bne	.not_on_type_55
	move.b	#0,-21(a2)
	move.b	#0,19(a2)
	move.b	#0,-21(a3)
	move.b	#0,19(a3)
	move.b	#0,-21(a4)
	move.b	#0,19(a4)
	move.b	#0,-41(a2)
	move.b	#0,39(a2)
	move.b	#0,-41(a3)
	move.b	#0,39(a3)
	move.b	#0,-41(a4)
	move.b	#0,39(a4)
	move.b	#0,-1(a2)
	move.b	#0,-1(a3)	
.not_on_type_55


	cmp.b	#9,1(a2)
	bne	.not_on_type_9
	move.b	#0,-20(a2)
	move.b	#0,20(a2)
	move.b	#0,-20(a3)
	move.b	#0,20(a3)
	move.b	#0,-20(a4)
	move.b	#0,20(a4)
	move.b	#0,-40(a2)
	move.b	#0,40(a2)
	move.b	#0,-40(a3)
	move.b	#0,40(a3)
	move.b	#0,-40(a4)
	move.b	#0,40(a4)
	move.b	#0,(a2)
	move.b	#0,(a3)	
.not_on_type_9


	cmp.b	#9,(a2)
	bne	.not_on_type_99
	move.b	#0,-21(a2)
	move.b	#0,19(a2)
	move.b	#0,-21(a3)
	move.b	#0,19(a3)
	move.b	#0,-21(a4)
	move.b	#0,19(a4)
	move.b	#0,-41(a2)
	move.b	#0,39(a2)
	move.b	#0,-41(a3)
	move.b	#0,39(a3)
	move.b	#0,-41(a4)
	move.b	#0,39(a4)
	move.b	#0,-1(a2)
	move.b	#0,-1(a3)	
.not_on_type_99


fahre_nicht_nach_rechts:


	cmp.w	#$82,mydir
	bne	fahre_nicht_nach_links

	cmp.b	#5,(a2)
	bne	.not_on_type_5
	move.b	#0,-21(a2)
	move.b	#0,19(a2)
	move.b	#0,-21(a3)
	move.b	#0,19(a3)
	move.b	#0,-21(a4)
	move.b	#0,19(a4)
	move.b	#0,-41(a2)
	move.b	#0,39(a2)
	move.b	#0,-41(a3)
	move.b	#0,39(a3)
	move.b	#0,-41(a4)
	move.b	#0,39(a4)
	move.b	#0,-1(a2)
	move.b	#0,-1(a3)	
.not_on_type_5

	cmp.b	#3,(a2)
	bne	.not_on_type_3
	move.b	#0,-20(a2)
	move.b	#0,20(a2)
	move.b	#0,-20(a3)
	move.b	#0,20(a3)
	move.b	#0,-20(a4)
	move.b	#0,20(a4)
	move.b	#0,-40(a2)
	move.b	#0,40(a2)
	move.b	#0,-40(a3)
	move.b	#0,40(a3)
	move.b	#0,-40(a4)
	move.b	#0,40(a4)
	move.b	#0,(a2)
	move.b	#0,(a3)	
.not_on_type_3

	cmp.b	#9,(a2)
	bne	.not_on_type_9
	move.b	#0,-21(a2)
	move.b	#0,19(a2)
	move.b	#0,-21(a3)
	move.b	#0,19(a3)
	move.b	#0,-21(a4)
	move.b	#0,19(a4)
	move.b	#0,-41(a2)
	move.b	#0,39(a2)
	move.b	#0,-41(a3)
	move.b	#0,39(a3)
	move.b	#0,-41(a4)
	move.b	#0,39(a4)
	move.b	#0,-1(a2)
	move.b	#0,-1(a3)	
.not_on_type_9

fahre_nicht_nach_links:

fffnot_on_a_bridge:


	cmp.w	#1,myprio
	bne	fffnot_on_a_bridge2

fffnot_on_a_bridge2



	cmp.w	#0,myprio
	bne	fffnot_under_a_bridge


fffnot_under_a_bridge:
	rts








rowx:	dc.w	0
rowy:	dc.w	0

rowx2:	dc.w	0
rowy2:	dc.w	0

oldmove2:	dc.w	0

where_is_it: dc.l	0

checksegments:
	movem.l	d2/d3,-(sp)


	bsr	dir2num
	
	move.w	d4,mydir
	
	move.w	xpos,d2
	move.w	ypos,d3

	bsr	where_am_i
	move.w	d2,myprio

	move.w	clrsave,d5
	move.w	clrsave+2,d6

	move.w	d5,d0
	move.w	d6,d1
	lea	dirbuffer,a2
	lea	dirbuffer2,a3
	lea	dirbuffer3,a4
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	
	add.l	d1,a2
	add.l	d1,a3
	add.l	d1,a4

	move.w	d1,startoffset
	
	move.b	(a2),mytype

	bsr	remove_unneeded
;********************
;* PHASE 0
;********************

	cmp.w	#0,nummoves
	bne	cphase0

	tst.w	mup
	beq	.notmup
	lea	p0mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p0md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p0mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p0ml,a1
	bra	docheckseg
.notmleft
cphase0:

;********************
;* PHASE 2
;********************

	cmp.w	#2,nummoves
	bne	cphase2

	tst.w	mup
	beq	.notmup
	lea	p1mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p1md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p1mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p1ml,a1
	bra	docheckseg
.notmleft
cphase2:


;********************
;* PHASE 4
;********************

	cmp.w	#4,nummoves
	bne	cphase4

	tst.w	mup
	beq	.notmup
	lea	p2mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p2md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p2mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p2ml,a1
	bra	docheckseg
.notmleft
cphase4:

;********************
;* PHASE 6
;********************

	cmp.w	#6,nummoves
	bne	cphase6

	tst.w	mup
	beq	.notmup
	lea	p3mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p3md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p3mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p3ml,a1
	bra	docheckseg
.notmleft
cphase6:

;********************
;* PHASE 8
;********************

	cmp.w	#8,nummoves
	bne	cphase8

	tst.w	mup
	beq	.notmup
	lea	p4mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p4md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p4mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p4ml,a1
	bra	docheckseg
.notmleft
cphase8:

;********************
;* PHASE 10
;********************

	cmp.w	#10,nummoves
	bne	cphase10

	tst.w	mup
	beq	.notmup
	lea	p5mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p5md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p5mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p5ml,a1
	bra	docheckseg
.notmleft
cphase10:

;********************
;* PHASE 12
;********************

	cmp.w	#12,nummoves
	bne	cphase12

	tst.w	mup
	beq	.notmup
	lea	p6mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p6md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p6mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p6ml,a1
	bra	docheckseg
.notmleft
cphase12:

;********************
;* PHASE 14
;********************

	cmp.w	#14,nummoves
	bne	cphase14

	tst.w	mup
	beq	.notmup
	lea	p7mu,a1
	bra	docheckseg
.notmup
	tst.w	mdown
	beq	.notmdown
	lea	p7md,a1
	bra	docheckseg
.notmdown
	tst.w	mright
	beq	.notmright
	lea	p7mr,a1
	bra	docheckseg
.notmright
	tst.w	mleft
	beq	.notmleft
	lea	p7ml,a1
	bra	docheckseg
.notmleft
cphase14:

	bra	non_of_all

docheckseg:
	move.w	(a1)+,d0
	cmp.w	#-1,d0
	beq	endoflist
	move.w	(a1)+,d2	;Richtung
	move.w	(a1)+,d3	;Datenoffset
	move.w	(a1)+,d0	;xoff
	move.w	(a1)+,d1	;yoff
	cmp.b	(a2,d3.w),d2
	beq	.nextstep
	cmp.b	(a3,d3.w),d2	;Dirbuffer2 / lower
	beq	.nextstep
	cmp.b	(a4,d3.w),d2	;Dirbuffer3 / upper
	beq	.nextstep
	bra	docheckseg

.nextstep

;returns: real x and real y in d0,d1
;	  up/low = 1/0 in d2
;needs:	active xpos,ypos (in d2,d3)
;	direction in d4	($81 r,$82 l,$83 d,$84 u)
;	
	move.w	d2,d4

	move.w	xpos,d2
	move.w	ypos,d3
	add.w	d0,d2
	add.w	d1,d3
	bsr	where_am_i


	movem.w	d0/d1,-(sp)

	subq.w	#6,d0
	bsr	put_a_body_mask

	movem.w	(sp)+,d0/d1

	tst.w	showmepos
	beq	.notshowing
	
	;bsr	put_a_mark
.notshowing
	bra	docheckseg
	
	
endoflist:	
	bsr	waitblit
non_of_all:
	
	tst.w	showmepos
	bne	notrestre


notrestre:

	bsr	restore_areas

	movem.l (sp)+,d2/d3
	rts

startoffset:	dc.w	0
myprio:		dc.w	0
mytype:		dc.b	0,0
mydir:		dc.w	0
showmepos:	dc.w	0

sbuff1:		dcb.b	5*5,0
		dc.b	0
sbuff2:		dcb.b	5*5,0
		dc.b	0
sbuff3:		dcb.b	5*5,0
		dc.b	0


preserve_areas:
	move.l	a2,a0
	lea	sbuff1,a1
	bsr	savebufferarea
	move.l	a3,a0
	lea	sbuff2,a1
	bsr	savebufferarea
	move.l	a4,a0
	lea	sbuff3,a1
	bsr	savebufferarea
	rts

restore_areas:
	move.l	a2,a0
	lea	sbuff1,a1
	bsr	restbufferarea
	move.l	a3,a0
	lea	sbuff2,a1
	bsr	restbufferarea
	move.l	a4,a0
	lea	sbuff3,a1
	bsr	restbufferarea
	rts

;a0 source
;a1 destination
savebufferarea:
	lea	-42(a0),a0
	move.w	#4,d0
.saloop
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	lea	15(a0),a0
	dbra	d0,.saloop
	rts	

restbufferarea:
	lea	-42(a0),a0
	move.w	#4,d0
.saloop
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	lea	15(a0),a0
	dbra	d0,.saloop
	rts	
	

	;	Nr,BYTE,OFFSET,Xoff,Yoff
;* PHASE 0
p0mu:	dc.w	1,$83,1,16,4
	dc.w	4,$84,1,16,0
	dc.w	6,$81,20,2,18
	dc.w	7,$82,20,-2,18
	dc.w	8,$82,21,14,18
	dc.w	10,$84,20,0,16
	dc.w	11,$83,20,0,20
	dc.w	12,$82,1,14,2
	dc.w	15,$81,1,18,2
	dc.w	-1
p0md:	dc.w	1,$84,1,16,-4
	dc.w	2,$84,21,16,12
	dc.w	4,$81,1,18,-2
	dc.w	6,$83,1,16,0
	dc.w	11,$83,20,0,16
	dc.w	12,$82,20,-2,14
	dc.w	13,$81,20,2,14
	dc.w	14,$82,1,14,-2
	dc.w	-1
p0mr:	dc.w	1,$82,20,-4,16
	dc.w	2,$82,21,12,16
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	9,$84,1,14,-2
	dc.w	10,$83,1,14,2
	dc.w	12,$83,20,-2,18
	dc.w	13,$84,20,-2,14
	dc.w	-1
p0ml:	dc.w	1,$81,20,4,16
	dc.w	4,$83,20,2,18
	dc.w	6,$84,1,18,-2
	dc.w	7,$83,1,18,2
	dc.w	8,$82,1,16,0	
	dc.w	10,$84,20,2,14	
	dc.w	11,$82,20,0,16
	dc.w	-1

;* PHASE 2
p1mu:	dc.w	1,$83,1,16,8
	dc.w	2,$83,-19,16,-8
	dc.w	4,$84,1,16,0
	dc.w	6,$81,20,4,20
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,12,4
	dc.w	15,$81,1,20,4
	dc.w	-1
p1md:	dc.w	1,$84,1,16,-8
	dc.w	2,$84,21,16,8
	dc.w	6,$83,1,16,0
	dc.w	11,$83,20,0,16
	dc.w	12,$82,20,-4,12
	dc.w	13,$81,20,4,12
	dc.w	14,$82,1,12,-4
	dc.w	-1
p1mr:	dc.w	1,$82,20,-8,16
	dc.w	2,$82,21,8,16
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	9,$84,1,12,-4
	dc.w	10,$83,1,12,4
	dc.w	13,$84,20,-4,12
	dc.w	-1
p1ml:	dc.w	1,$81,20,8,16
	dc.w	2,$81,19,-8,16
	dc.w	4,$83,20,4,20
	dc.w	7,$83,1,20,4
	dc.w	8,$82,1,16,0	
	dc.w	10,$84,20,4,12	
	dc.w	11,$82,20,0,16
	dc.w	-1


;* PHASE 4
p2mu:	dc.w	1,$83,1,16,12
	dc.w	2,$83,-19,16,-4
	dc.w	4,$84,1,16,0
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,10,6
	dc.w	-1
p2md:
	dc.w	2,$84,21,16,4
	dc.w	6,$83,1,16,0
	dc.w	11,$83,20,0,16
	dc.w	12,$82,20,-6,10
	dc.w	13,$81,20,6,10
	dc.w	14,$82,1,10,-6
	dc.w	-1
p2mr:	
	dc.w	2,$82,21,4,16
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	9,$84,1,10,-6
	dc.w	10,$83,1,10,6
	dc.w	13,$84,20,-6,10
	dc.w	-1
p2ml:	dc.w	1,$81,20,12,16
	dc.w	2,$81,19,-4,16
	dc.w	8,$82,1,16,0	
	dc.w	10,$84,20,6,10	
	dc.w	11,$82,20,0,16
	dc.w	-1


;* PHASE 6
p3mu:	dc.w	1,$83,1,16,16
	dc.w	2,$83,-19,16,0
	dc.w	4,$84,1,16,0
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,8,8
	dc.w	-1
p3md:
	dc.w	2,$84,21,16,0
	dc.w	3,$84,41,16,16
	dc.w	6,$83,1,16,0
	dc.w	11,$83,20,0,16
	dc.w	12,$82,20,-8,8
	dc.w	13,$81,20,8,8
	dc.w	14,$82,1,8,-8
	dc.w	-1
p3mr:	
	dc.w	2,$82,21,0,16
	dc.w	3,$82,22,16,16
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	9,$84,1,8,-8
	dc.w	10,$83,1,8,8
	dc.w	13,$84,20,-8,8
	dc.w	-1
p3ml:	
	dc.w	1,$81,20,16,16
	dc.w	2,$81,19,0,16
	dc.w	8,$82,1,16,0	
	dc.w	10,$84,20,8,8	
	dc.w	11,$82,20,0,16
	dc.w	-1


;* PHASE 8
p4mu:	
	dc.w	2,$83,-19,16,4
	dc.w	4,$84,1,16,0
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,6,10
	dc.w	13,$81,-1,-6,10
	dc.w	14,$81,-20,10,-6
	dc.w	-1
p4md:
	dc.w	2,$84,21,16,-4
	dc.w	3,$84,41,16,12
	dc.w	6,$83,1,16,0
	dc.w	11,$83,20,0,16
	dc.w	13,$81,20,10,6
	dc.w	-1
p4mr:	
	dc.w	2,$82,21,-4,16
	dc.w	3,$82,22,12,16
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	10,$83,1,6,10
	dc.w	-1
p4ml:	
	dc.w	2,$81,19,4,16
	dc.w	8,$82,1,16,0	
	dc.w	9,$83,-20,10,-6	
	dc.w	10,$84,20,10,6	
	dc.w	11,$82,20,0,16
	dc.w	12,$83,-1,-6,10
	dc.w	-1


;* PHASE 10
p5mu:	
	dc.w	2,$83,-19,16,8
	dc.w	3,$83,-39,16,-8
	dc.w	4,$84,1,16,0
	dc.w	5,$82,-18,20,-4
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,4,12
	dc.w	13,$81,-1,-4,12
	dc.w	14,$81,-20,12,-4
	dc.w	-1
p5md:
	dc.w	2,$84,21,16,-8
	dc.w	3,$84,41,16,8
	dc.w	5,$82,22,20,4
	dc.w	6,$83,1,16,0
	dc.w	9,$82,41,4,20
	dc.w	11,$83,20,0,16
	dc.w	13,$81,20,12,4
	dc.w	-1
p5mr:	
	dc.w	2,$82,21,-8,16
	dc.w	3,$82,22,8,16
	dc.w	4,$84,22,20,4
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	10,$83,1,4,12
	dc.w	14,$84,41,4,20
	dc.w	-1
p5ml:	
	dc.w	2,$81,19,8,16
	dc.w	3,$81,18,-8,16
	dc.w	5,$84,39,-4,20
	dc.w	8,$82,1,16,0	
	dc.w	9,$83,-20,12,-4	
	dc.w	10,$84,20,12,4	
	dc.w	11,$82,20,0,16
	dc.w	12,$83,-1,-4,12
	dc.w	-1


;* PHASE 12
p6mu:	
	dc.w	2,$83,-19,16,12
	dc.w	3,$83,-39,16,-4
	dc.w	4,$84,1,16,0
	dc.w	5,$82,-18,18,-2
	dc.w	9,$82,2,18,14
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,2,14
	dc.w	13,$81,-1,-2,14
	dc.w	14,$81,-20,14,-2
	dc.w	-1
p6md:
	dc.w	3,$84,41,16,4
	dc.w	5,$82,22,18,2
	dc.w	6,$83,1,16,0
	dc.w	7,$81,40,14,18
	dc.w	8,$81,39,-2,18
	dc.w	9,$82,41,2,18
	dc.w	10,$84,60,0,20
	dc.w	11,$83,20,0,16
	dc.w	13,$81,20,14,2
	dc.w	-1
p6mr:	
	dc.w	3,$82,22,4,16
	dc.w	4,$84,22,18,2
	dc.w	5,$83,2,18,14
	dc.w	6,$83,-18,18,-2
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	10,$83,1,2,14
	dc.w	11,$82,3,20,0
	dc.w	14,$84,41,2,18
	dc.w	-1
p6ml:	
	dc.w	2,$81,19,12,16
	dc.w	3,$81,18,-4,16
	dc.w	5,$84,39,-2,18
	dc.w	8,$82,1,16,0	
	dc.w	9,$83,-20,14,-2	
	dc.w	10,$84,20,14,2	
	dc.w	11,$82,20,0,16
	dc.w	12,$83,-1,-2,14
	dc.w	-1

;* PHASE 14
p7mu:	
	dc.w	2,$83,-19,16,16
	dc.w	3,$83,-39,16,0
	dc.w	4,$84,1,16,0
	dc.w	5,$82,-18,16,0
	dc.w	9,$82,2,16,16
	dc.w	10,$84,20,0,16
	dc.w	12,$82,1,0,16
	dc.w	13,$81,-1,0,16
	dc.w	14,$81,-20,16,0
	dc.w	-1
p7md:
	dc.w	3,$84,41,16,0
	dc.w	5,$82,22,16,0
	dc.w	6,$83,1,16,0
	dc.w	8,$81,39,0,16
	dc.w	9,$82,41,0,16
	dc.w	10,$84,60,0,16
	dc.w	11,$83,20,0,16
	dc.w	13,$81,20,16,0
	dc.w	15,$84,61,16,16
	dc.w	-1
p7mr:	
	dc.w	3,$82,22,0,16
	dc.w	4,$84,22,16,0
	dc.w	6,$83,-18,16,0
	dc.w	7,$81,1,16,0
	dc.w	8,$81,20,0,16
	dc.w	10,$83,1,0,16
	dc.w	11,$82,3,16,0
	dc.w	14,$84,41,0,16
	dc.w	15,$82,23,16,16
	dc.w	-1
p7ml:	
	dc.w	2,$81,19,16,16
	dc.w	3,$81,18,0,16
	dc.w	5,$84,39,0,16
	dc.w	8,$82,1,16,0	
	dc.w	9,$83,-20,16,0	
	dc.w	10,$84,20,16,0	
	dc.w	11,$82,20,0,16
	dc.w	12,$83,-1,0,16
	dc.w	13,$84,40,16,16
	dc.w	-1

		

		
checkon:
	move.l	#0,xoff
	move.l	#0,brix
	move.l	#0,brix2
	move.l	#0,brix3
	move.l	#0,btype
	move.l	#0,vlock

	move.w	xpos,d2
	move.w	ypos,d3
	and.b	#$f0,d3
	and.b	#$f0,d2

;***********************************************************
;* check if flups is ON horizontal bridge
;***********************************************************

	tst.w	mup
	bne	not_on_bridge_Mrightleft
	tst.w	mdown
	bne	not_on_bridge_Mrightleft

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#4,d0
	bne	not_up_ramp1
	lea	boff,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#16,brix
	add.w	#7,briy
	move.w	#1,btype
not_up_ramp1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#3,d0
	bne	not_mid_part1
	lea	boff+16,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#7,briy
	move.w	#1,btype
	move.w	#1,hlock
not_mid_part1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#5,d0
	bne	not_down_ramp1
	lea	boff+28,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix
	move.w	d3,briy
	sub.w	#16,brix
	add.w	#7,briy
	move.w	#1,btype
	move.w	#1,hlock
not_down_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#9,d0
	bne	not_down_up_ramp1
	lea	boff2,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix
	move.w	d3,briy
	sub.w	#16,brix
	add.w	#7,briy
	move.w	#1,btype
	move.w	d2,brix2
	move.w	d3,briy2
	add.w	#16,brix2
	add.w	#7,briy2
	move.w	#1,btype2
	move.w	#1,hlock
not_down_up_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#5,d0
	bne	not_down_ramp2
	lea	boff+32+6*2,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix2
	move.w	d3,briy2
	sub.w	#32,brix2
	add.w	#7,briy2
	move.w	#1,btype2
not_down_ramp2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#9,d0
	bne	not_up_ramp2
	lea	boff2+16,a0
	move.w	xpos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),yoff
	move.w	d2,brix2
	move.w	d3,briy2
	sub.w	#32,brix2
	add.w	#7,briy2
	move.w	#1,btype2
not_up_ramp2:

not_on_bridge_Mrightleft:


;***********************************************************
;* check if flups is ON vertical bridge
;***********************************************************

	tst.w	mleft
	bne	not_on_bridge_Mupdown
	tst.w	mright
	bne	not_on_bridge_Mupdown

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#6,d0
	bne	ud_not_up_ramp1
	lea	boff,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#2,brix
	add.w	#24,briy
	move.w	#2,btype
ud_not_up_ramp1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#2,d0
	bne	ud_not_mid_part1
	lea	boff+16,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#2,brix
	add.w	#8,briy
	move.w	#2,btype
	move.w	#1,vlock
ud_not_mid_part1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#7,d0
	bne	ud_not_down_ramp1
	lea	boff+28,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#2,brix
	sub.w	#8,briy
	move.w	#2,btype
	move.w	#1,vlock
ud_not_down_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#8,d0
	bne	ud_not_down_up_ramp1
	lea	boff2,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix
	move.w	d3,briy
	add.w	#2,brix
	sub.w	#8,briy
	move.w	#2,btype
	move.w	d2,brix2
	move.w	d3,briy2
	add.w	#2,brix2
	add.w	#24,briy2
	move.w	#2,btype2
	move.w	#1,vlock
ud_not_down_up_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#7,d0
	bne	ud_not_down_ramp2
	lea	boff+32+6*2,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix2
	move.w	d3,briy2
	add.w	#2,brix2
	sub.w	#24,briy2
	move.w	#2,btype2
ud_not_down_ramp2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#8,d0
	bne	ud_not_up_ramp2
	lea	boff2+16,a0
	move.w	ypos,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),xoff
	move.w	d2,brix2
	move.w	d3,briy2
	add.w	#2,brix2
	sub.w	#24,briy2
	move.w	#2,btype2
ud_not_up_ramp2:

not_on_bridge_Mupdown:

	rts




putflupsmask:
	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	xoff,d0
	sub.w	yoff,d1

	subq	#6,d0

	move.w	d0,aktivex		
	move.w	d1,aktivey	

	mulu	#40,d1
	move.w	d0,d4
	and.w	#$f,d4
	ror.w	#4,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d0,d1
	add.l	maskbuffer,d1
	move.l	d1,aktivepos

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	d4,bltcon1(a5)
	or.w	#$09f0,d4
	move.w	d4,bltcon0(a5)
	move.l	#flups_m,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#6*3,bltamod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*64+3,bltsize(a5)

	rts


puttilemask:
	move.w	xpos,d0
	move.w	ypos,d1
	add.w	#6,d1
	mulu	#40,d1
	move.w	d0,d4
	and.w	#$f,d4
	ror.w	#4,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d0,d1
	add.l	maskbuffer,d1
	move.l	d1,aktivepos

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	#tile,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#2,bltamod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#16*64+1,bltsize(a5)
	rts


clrtile:
	move.w	clrxpos,d0
	move.w	clrypos,d1
	add.w	#6,d1
	mulu	#160,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0

	add.l	bitplanes,d0
	add.l	#40*182*4*8,d0

	move.l	aktivepos,d1

	move.l	#floor,d2

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	#$0fe2,bltcon0(a5)
	move.w	#6,bltamod(a5)
	move.w	#38,bltbmod(a5)
	move.w	#38+40*3,bltcmod(a5)
	move.w	#38+40*3,bltdmod(a5)

	bsr	copy_one_plane3
	add.l	#40,d0
	add.l	#2,d2
	bsr	copy_one_plane3
	add.l	#40,d0
	add.l	#2,d2
	bsr	copy_one_plane3
	add.l	#40,d0
	add.l	#2,d2
	bsr	copy_one_plane3
	rts
			
copy_one_plane3:
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d2,bltapth(a5)
	move.l	d1,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#16*64+1,bltsize(a5)
	rts


checkunder:
	move.w	ypos,d3
	move.w	xpos,d2
	and.b	#$f0,d3
	and.b	#$f0,d2


;***********************************************************
;* check if flups is UNDER vertical bridge
;***********************************************************

	tst.w	mup
	bne	under_the_bridge_mh
	tst.w	mdown
	bne	under_the_bridge_mh

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#2,d0
	bne	not_under1
	move.w	d2,d0
	move.w	d3,d1
	add.w	#3,d0
	sub.w	#8,d1
	bsr	put_a_under_bridge_mask_v
not_under1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#32,d0
	bsr	getblock
	cmp.w	#2,d0
	bne	not_under2
	move.w	d2,d0
	move.w	d3,d1
	add.w	#19,d0
	sub.w	#8,d1
	bsr	put_a_under_bridge_mask_v
not_under2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#2,d0
	bne	not_under3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#13,d0
	sub.w	#8,d1
	move.w	#1,hlock
	bsr	put_a_under_bridge_mask_v
not_under3:

under_the_bridge_mh:

;***********************************************************
;* check if flups is UNDER horizontal bridge
;***********************************************************

	tst.w	mleft
	bne	under_the_bridge_mv
	tst.w	mright
	bne	under_the_bridge_mv

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#3,d0
	bne	hnot_under1
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	add.w	#8,d1
	bsr	put_a_under_bridge_mask_h
hnot_under1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#32,d1
	bsr	getblock
	cmp.w	#3,d0
	bne	hnot_under2
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	add.w	#24,d1
	bsr	put_a_under_bridge_mask_h
hnot_under2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#3,d0
	bne	hnot_under3
	move.w	d2,d0
	move.w	d3,d1
	sub.w	#16,d0
	sub.w	#8,d1
	move.w	#1,vlock
	bsr	put_a_under_bridge_mask_h
hnot_under3:

under_the_bridge_mv:

	rts


do_the_rest:
	cmp.w	#1,btype
	bne	nobridge_h
	tst.l	brix
	beq	nobridge_h
	move.w	brix,d0
	move.w	briy,d1
	bsr	put_a_bridge_mask_h
nobridge_h:

	cmp.w	#1,btype2
	bne	nobridge_h_updown
	tst.l	brix2
	beq	nobridge_h_updown
	move.w	brix2,d0
	move.w	briy2,d1
	bsr	put_a_bridge_mask_h
nobridge_h_updown:

	cmp.w	#2,btype
	bne	nobridge_v
	tst.l	brix
	beq	nobridge_v
	move.w	brix,d0
	move.w	briy,d1
	bsr	put_a_bridge_mask_v
nobridge_v:

	cmp.w	#2,btype2
	bne	nobridge_v_updown
	tst.l	brix2
	beq	nobridge_v_updown
	move.w	brix2,d0
	move.w	briy2,d1
	bsr	put_a_bridge_mask_v
nobridge_v_updown:


	move.w	xpos,d2
	move.w	ypos,d3
	sub.w	xoff,d0
	sub.w	yoff,d1
	and.b	#$f0,d2
	and.b	#$f0,d3

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$10,d0
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall1	
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$10,d0
	bsr	put_a_wall_mask
no_wall1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$10,d0
	add.w	#$10,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall2
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$10,d0
	add.w	#$10,d1
	bsr	put_a_wall_mask
no_wall2:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$10,d0
	add.w	#$20,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall3
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$10,d0
	add.w	#$20,d1
	bsr	put_a_wall_mask
no_wall3:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$10,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall4
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$10,d1
	bsr	put_a_wall_mask
no_wall4:


	tst.w	mup
	bne	no_wall5
	tst.w	mdown
	bne	no_wall5

	move.w	d2,d0
	move.w	d3,d1
	sub.w	#$10,d0
	add.w	#$10,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall5
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	sub.w	#$10,d0
	add.w	#$10,d1
	bsr	put_a_wall_mask
no_wall5:


	move.w	d2,d0
	move.w	d3,d1
	add.w	#$20,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall6
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$20,d1
	bsr	put_a_wall_mask
no_wall6:

	tst.w	mup
	bne	no_wall7
	tst.w	mdown
	bne	no_wall7

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$20,d0
	add.w	#$10,d1
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall7
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$20,d0
	add.w	#$10,d1
	bsr	put_a_wall_mask
no_wall7:

	tst.w	mup
	bne	no_wall8
	tst.w	mdown
	bne	no_wall8

	move.w	d2,d0
	move.w	d3,d1
	add.w	#$20,d0
	bsr	getblock

	cmp.b	#1,d0
	bne	no_wall8
	move.w	d2,d0
	move.w	d3,d1
	subq	#6,d0
	add.w	#$20,d0
	bsr	put_a_wall_mask
no_wall8:

	move.l	activehead,d2
	move.l	activeplanes,d3
	rts

secflups:
	move.l	secpointer,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	add.l	#secbuffer,d0

	move.l	aktivepos,d1
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	#$09f0,bltcon0(a5)
	move.l	d1,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#7*6,bltdmod(a5)
	move.w	#22*64+3,bltsize(a5)

	move.l	secpointer,d0
	add.w	d0,d0
	lea	ringxy,a0
	move.l	secx,(a0,d0.w)
 
	add.l	#2,secpointer
	and.l	#$f,secpointer
	rts

seccopy:
	lea	ringxy,a0
	move.l	secpointer,d2
	add.w	d2,d2
	move.w	(a0,d2.w),d0	
	move.w	2(a0,d2.w),d1
	tst.w	d0
	beq	noseccopy
	subq	#6,d0
	mulu	#160,d1
	move.w	d0,d4
	and.w	#$f,d4
	ror.w	#4,d4
	or.w	#$0fe2,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0

	move.l	secpointer,d1
	move.w	d1,d2
	add.w	d1,d1
	add.w	d2,d1
	add.l	#secbuffer,d1

	move.l	#flups+88*4*6,d2

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	d4,bltcon0(a5)
	move.w	#6*3,bltamod(a5)
	move.w	#7*6,bltbmod(a5)
	move.w	#34+40*3,bltcmod(a5)
	move.w	#34+40*3,bltdmod(a5)

	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
noseccopy:
	rts

secx:	dc.w	0
secy:	dc.w	0

copyflups:
	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	xoff,d0
	sub.w	yoff,d1
	move.w	d0,secx
	move.w	d1,secy
	subq	#6,d0
	mulu	#160,d1
	move.w	d0,d4
	and.w	#$f,d4
	ror.w	#4,d4
	or.w	#$0fe2,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	d3,d0

	move.l	aktivepos,d1

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#0,bltcon1(a5)
	move.w	d4,bltcon0(a5)
	move.w	#6*3,bltamod(a5)
	move.w	#34,bltbmod(a5)
	move.w	#34+40*3,bltcmod(a5)
	move.w	#34+40*3,bltdmod(a5)

	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
	addq	#6,d2
	add.l	#40,d0
	bsr	copy_one_plane
	rts
			
copy_one_plane:
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d2,bltapth(a5)
	move.l	d1,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#22*64+3,bltsize(a5)
	rts

aktivex:	dc.w	0
aktivey:	dc.w	0
aktivepos:	dc.l	0

put_a_flups:
	sub.w	#6,d0
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0dfc,d4
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#flups_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*64+3,bltsize(a5)
	rts


put_a_wall_mask:
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#wall_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*64+3,bltsize(a5)
	rts

put_a_body_mask:
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#flups_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*64+3,bltsize(a5)
	rts

put_a_bridge_mask_h:
	tst.w	mode
	bne	.mode2
	sub.w	#2,d1
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_h_m+6*4*29,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#16*64+3,bltsize(a5)
	rts
.mode2	
	sub.w	#2+13,d1
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_h_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#29*64+3,bltsize(a5)
	rts


put_a_bridge_mask_v:
	tst.w	mode
	bne	.mode2
	sub.w	#3,d0
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_v_m+6*4*36,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#36,bltamod(a5)
	move.w	#2+6*3,bltbmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#36*64+2,bltsize(a5)
	rts
.mode2
	sub.w	#3+13,d0
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_v_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#36*64+3,bltsize(a5)
	rts

mode:	dc.w	0


put_a_under_bridge_mask_v:
	subq.w	#1,d0
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_v_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#35*64+3,bltsize(a5)
	rts


put_a_under_bridge_mask_h:
	mulu	#40,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	maskbuffer,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	move.w	#$0d30,d4	
	move.w	d4,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	#bridge_h_m,bltbpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#34,bltamod(a5)
	move.w	#6*3,bltbmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#29*64+3,bltsize(a5)
	rts



list4:	dc.w	0,1,0,1,0,0,1,0
list3:	dc.w	1,0,1,0,1,0,1,0
list2:	dc.w	1,0,1,0,1,1,0,1
list1:	dc.w	1,1,1,0,1,1,1,0
list0:	dc.w	1,1,1,1,1,1,1,0

activelist:	dc.l 	0
listoff:	dc.w	0


sssxy:	dc.l	0

checkvalid:
	move.w	d0,sssxy	
	move.w	d1,sssxy+2	

	bsr	getblock2

	cmp.b	#0,d0
	bne	nofloor
	move.b	#$50,(a0,d1.w)
	sub.w	#1,numfruits
	tst.w	whichsound
	bne	.no_other_sound
	move.w	#1,whichsound
.no_other_sound
	add.l	#10,addscore

	add.w	#1,notstretch
	cmp.w	#2,notstretch
	bls	nofloor

	move.w	listoff,d2
	add.w	#2,d2
	cmp.b	#16,d2
	bne	notoverlistend
	move.w	#0,d2
notoverlistend:
	move.w	d2,listoff
	move.l	activelist,a0
	move.w	(a0,d2.w),insert
	cmp.w	#1,insert
	bne	nofloor
	add.w	#1,flupssize
nofloor:

	cmp.b	#1,d0
	beq	notvalid
	move.w	#1,d0
	rts
notvalid:
	move.w	#0,d0
	rts


clrdie:
	move.l	posend,d0
	add.l	#4*8,d0
	cmp.l	#positions+400*4*8,d0
	blt	.not_over_posit2
	sub.l	#400*4*8,d0
.not_over_posit2
	move.l	d0,a0
	move.w	(a0),d0
	move.w	2(a0),d1
	bsr	putblock2
	rts


putdie:
	bsr	clrdie
	
	move.w	sssxy,d0
	move.w	sssxy+2,d1

	bsr	getblock3
	cmp.b	#$ff,d0
	bne	no_bodypart
	move.w	#1,died
no_bodypart:
	rts


getblock2:
	lea	levelbuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	rts

putblock:
	lea	diebuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b 	(a0,d1.w),d0
	tst.b	d0
	bne	noput
	move.b	#$ff,(a0,d1.w)
noput:	rts

putblock2:
	lea	diebuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	cmp.w	#$ff,d0
	bne	noclrput
	move.b	#$0,(a0,d1.w)
noclrput:
	rts


putdir:
	move.w	clrsave,d0
	move.w	clrsave+2,d1
	tst.w	d4
	bne	.takethree
	lea	dirbuffer2,a0
	bra	.notthree
.takethree
	lea	dirbuffer3,a0	
.notthree
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	direc+1,(a0,d1.w)
	rts


getdir:
	move.l	(a0),d0
	move.w	d0,d1
	swap	d0
	
	move.l	a0,a1

	add.l	#4,a1
	cmp.l	#positions+400*4*8,a1
	blt	.notoverpos
	sub.l	#400*4*8,a1
.notoverpos
	move.l	(a1),d2
	move.w	d2,d3
	swap	d2

	sub.w	d0,d2
	sub.w	d1,d3

	move.w	#0,d4

	tst.w	d2
	bpl	.notoleftx
	tst.w	d3
	bne	.notoleftx
	move.w	#$82,d4
.notoleftx
	tst.w	d2
	bmi	.notorightx
	tst.w	d3
	bne	.notorightx
	move.w	#$81,d4
.notorightx
	tst.w	d3
	bpl	.notoupx
	tst.w	d2
	bne	.notoupx
	move.w	#$84,d4
.notoupx
	tst.w	d3
	bmi	.notodownx
	tst.w	d2
	bne	.notodownx
	move.w	#$83,d4
.notodownx
	rts



cleardir:
	move.l	posend,a0
	bsr	getdir

	move.l	posend,a1
	move.w	(a1),d0
	move.w	2(a1),d1
	
	lea	dirbuffer2,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	
	cmp.b	(a0,d1.w),d4
	bne	.not_on_lower
	move.b	#$20,(a0,d1.w)
.not_on_lower
	lea	dirbuffer3,a0
	cmp.b	(a0,d1.w),d4
	bne	.not_on_higher
	move.b	#$20,(a0,d1.w)
.not_on_higher
	rts


segputblock1:
	lea	dirbuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	cmp.b	#0,(a0,d1.w)
	beq	doblockput
	cmp.b	#$20,(a0,d1.w)
	bge	doblockput
	rts
doblockput:
	move.b	direc+1,(a0,d1.w)
	rts

segputblock2:
	lea	dirbuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	cmp.w	#$50,d0
	blt	nosegclrput
	move.b	#$20,(a0,d1.w)
nosegclrput:
	rts

seggetblock:
	lea	dirbuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	rts
	

getblock3:
	lea	diebuffer,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	rts


getblock:
	move.l	usedlevel,a0
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	rts


savedir:
	move.l	posend,a0
	move.w	(a0),d0
	move.w	2(a0),d1
	bsr	segputblock2
	rts


savedir2:
	move.w	clrsave,d0
	move.w	clrsave+2,d1
	bsr	segputblock1
	rts

myjoy:	dc.w	0

joystick:
	tst.w	moving
	bne	return
	move.w	$dff00c,d0
	move.w	d0,myjoy

	btst	#1,d0
	bne	rechts
returnrechts:
	move.w	myjoy,d0
	btst	#9,d0
	bne	links
returnlinks:
	move.w	myjoy,d0
	move.w	d0,d1
	lsr.w	#1,d1
	eor.w	d0,d1
	btst	#0,d1
	bne	hinten
returnhinten:
	move.w	myjoy,d0
	move.w	d0,d1
	lsr.w	#1,d1
	eor.w	d0,d1
	btst	#8,d1
	bne	vorne
	bra	return

rechts:
	tst.w	vlock
	bne	returnrechts
	cmp.w	#2,oldmove
	beq	returnrechts
	move.w	xpos,d0
	move.w	ypos,d1
	add.w	#16,d0
	bsr	checkvalid
	tst.w	d0
	beq	returnrechts
	bsr	putdie
	move.w	#1+$80,direc
	move.l	xpos,clrsave
	move.l	xpos,clrxpos
	add.w	#16,clrxpos
	bsr	checkbridge
	move.w	#1,oldmove
	move.l	#HEADRIGHT,head
	move.w	#1,moving
	move.w	#1,mright
	bsr	savedir2
	bra 	return
links:
	tst.w	vlock
	bne	returnlinks
	cmp.w	#1,oldmove
	beq	returnlinks
	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	#16,d0
	bsr	checkvalid
	tst.w	d0
	beq	returnlinks
	bsr	putdie
	move.w	#2+$80,direc
	move.l	xpos,clrsave
	move.l	xpos,clrxpos
	sub.w	#16,clrxpos
	bsr	checkbridge
	move.w	#2,oldmove
	move.l	#HEADLEFT,head
	move.w	#1,moving
	move.w	#1,mleft
	bsr	savedir2
	bra 	return
hinten:
	tst.w	hlock
	bne	returnhinten
	cmp.w	#4,oldmove
	beq	returnhinten
	move.w	xpos,d0
	move.w	ypos,d1
	add.w	#16,d1
	bsr	checkvalid
	tst.w	d0
	beq	returnhinten
	bsr	putdie
	move.w	#3+$80,direc
	move.l	xpos,clrsave
	move.l	xpos,clrxpos
	add.w	#16,clrypos
	bsr	checkbridge
	move.w	#3,oldmove
	move.l	#HEADDOWN,head
	move.w	#1,moving
	move.w	#1,mdown
	bsr	savedir2
	bra 	return
vorne:
	tst.w	hlock
	bne	return
	cmp.w	#3,oldmove
	beq	return
	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	#16,d1
	bsr	checkvalid
	tst.w	d0
	beq	return
	bsr	putdie
	move.w	#4+$80,direc
	move.l	xpos,clrsave
	move.l	xpos,clrxpos
	sub.w	#16,clrypos
	bsr	checkbridge
	move.w	#4,oldmove
	move.l	#HEADUP,head
	move.w	#1,moving
	move.w	#1,mup
	bsr	savedir2
	bra 	return

whereto: dc.l 0
clrxpos: dc.w 0
clrypos: dc.w 0
clrsave: dc.l 0 
direc:	 dc.w	0

tmin1:		dc.w	0
tmin2:		dc.w	0
abridge:	dc.w	0

checkbridge:
	move.w	tmin1,tmin2

	move.w	clrxpos,d0
	move.w	clrypos,d1

	lea	dirbuffer,a3
	lsr.w	#4,d0
	lsr.w	#4,d1
	mulu	#20,d1
	add.w	d0,d1
	add.l	d1,a3

	move.w	#0,tmin1

	cmp.b	#2,(a3)
	blt	notabridge
	cmp.b	#9,(a3)
	bgt	notabridge
	move.w	#1,tmin1
notabridge:
	
	move.w	tmin1,d0
	move.w	tmin2,d1
	or.w	d0,d1
	move.w	d1,abridge
	rts



;return direction in d4
dir2num:
	move.w	#0,d4
	tst.w	mup
	beq	.nupup
	move.w	#$84,d4
	rts
.nupup
	tst.w	mdown
	beq	.ndowndown
	move.w	#$83,d4
	rts
.ndowndown
	tst.w	mright
	beq	.nrighright
	move.w	#$81,d4
	rts
.nrighright
	tst.w	mleft
	beq	.nleftleft
	move.w	#$82,d4
	rts
.nleftleft
	rts


;needs xpos,ypos in d0,d1   direction in d4
;returns level up/down in d2
correct_height:
	bsr	getblock
	
	move.w	#0,d2

	cmp.w	#$81,d4
	beq	.is_2_right
	cmp.w	#$82,d4
	bne	.not_2_left
.is_2_right

	cmp.b	#4,d0
	bne	.not_four
	move.w	#1,d2
.not_four
	cmp.b	#3,d0
	bne	.not_three
	move.w	#1,d2
.not_three	
	cmp.b	#5,d0
	bne	.not_five
	move.w	#1,d2
.not_five
	cmp.b	#9,d0
	bne	.not_nine
	move.w	#1,d2
.not_nine


.not_2_left


	cmp.w	#$83,d4
	beq	.is_down
	cmp.w	#$84,d4
	bne	.not_up
.is_down

	cmp.b	#6,d0
	bne	.not_six
	move.w	#1,d2
.not_six
	cmp.b	#2,d0
	bne	.not_two
	move.w	#1,d2
.not_two
	cmp.b	#7,d0
	bne	.not_seven
	move.w	#1,d2
.not_seven
	cmp.b	#8,d0
	bne	.not_eight
	move.w	#1,d2
.not_eight

.not_up


	rts

;returns: real x and real y in d0,d1
;	  up/low = 1/0 in d2
;needs:	active xpos,ypos (in d2,d3)
;	direction in d4	($81 r,$82 l,$83 d,$84 u)
;	
;uses: d0,d1,d2,d3,d4,d5, a0

thatsx:	dc.w	0
thatsy:	dc.w	0

where_am_i:
	move.w	d2,thatsx
	move.w	d3,thatsy
;***********************************************************
;* check if flups is ON horizontal bridge
;***********************************************************

	cmp.w	#$84,d4
	beq	wwnot_on_bridge_Mrightleft
	cmp.w	#$83,d4
	beq	wwnot_on_bridge_Mrightleft

	move.w	#0,d5

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#4,d0
	bne	wwnot_up_ramp1
	lea	boff,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5	
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_up_ramp1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#3,d0
	bne	wwnot_mid_part1
	lea	boff+16,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_mid_part1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#5,d0
	bne	wwnot_down_ramp1
	lea	boff+28,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_down_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d0
	bsr	getblock
	cmp.w	#9,d0
	bne	wwnot_down_up_ramp1
	lea	boff2,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_down_up_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#5,d0
	bne	wwnot_down_ramp2
	lea	boff+32+6*2,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_down_ramp2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#9,d0
	bne	wwnot_up_ramp2
	lea	boff2+16,a0
	move.w	d2,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsy
	move.w	#1,d5
wwnot_up_ramp2:

	move.w	thatsx,d0
	move.w	thatsy,d1
	move.w	d5,d2
	rts
wwnot_on_bridge_Mrightleft:


;***********************************************************
;* check if flups is ON vertical bridge
;***********************************************************

	cmp.w	#$81,d4
	beq	wwnot_on_bridge_Mupdown
	cmp.w	#$82,d4
	beq	wwnot_on_bridge_Mupdown

	move.w	#0,d5

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#6,d0
	bne	wwud_not_up_ramp1
	lea	boff,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_up_ramp1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#2,d0
	bne	wwud_not_mid_part1
	lea	boff+16,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_mid_part1:
	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#7,d0
	bne	wwud_not_down_ramp1
	lea	boff+28,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_down_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	add.w	#16,d1
	bsr	getblock
	cmp.w	#8,d0
	bne	wwud_not_down_up_ramp1
	lea	boff2,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_down_up_ramp1:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#7,d0
	bne	wwud_not_down_ramp2
	lea	boff+32+6*2,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_down_ramp2:

	move.w	d2,d0
	move.w	d3,d1
	bsr	getblock
	cmp.w	#8,d0
	bne	wwud_not_up_ramp2
	lea	boff2+16,a0
	move.w	d3,d0
	and.w	#$e,d0
	move.w	(a0,d0.w),d5
	move.w	d2,thatsx
	move.w	d3,thatsy
	sub.w	d5,thatsx
	move.w	#1,d5
wwud_not_up_ramp2:

	move.w	thatsx,d0
	move.w	thatsy,d1
	move.w	d5,d2
	rts
wwnot_on_bridge_Mupdown:

	move.w	d2,d0
	move.w	d3,d1
	move.w	#0,d2
	rts	


checkkey:
	rts
	move.b	$bfec01,d0

	cmp.b	#$43,d0	
	bne	notplus
	move.b	#1,fruittype+1
	rts
notplus:
	cmp.b	#$6b,d0	
	bne	notminus
	move.b	#$ff,fruittype+1
	rts
notminus:


	move.l	#0,d2
	move.l	bitplanes,d1
	cmp.b	#95,d0
	bne	notf1
	move.l	d1,d2
notf1:
	cmp.b	#93,d0
	bne	notf2
	move.l	d1,d2
	add.l	#40*182*4,d2
notf2:
	cmp.b	#91,d0
	bne	notf3
	move.l	d1,d2
	add.l	#40*182*4*2,d2
notf3:
	cmp.b	#89,d0
	bne	notf4
	move.l	d1,d2
	add.l	#40*182*4*3,d2
notf4:
	cmp.b	#87,d0
	bne	notf5
	move.l	d1,d2
	add.l	#40*182*4*4,d2
notf5:
	cmp.b	#85,d0
	bne	notf6
	move.l	d1,d2
	add.l	#40*182*4*5,d2
notf6:
	cmp.b	#83,d0
	bne	notf7
	move.l	d1,d2
	add.l	#40*182*4*6,d2
notf7:
	cmp.b	#81,d0
	bne	notf8
	move.l	d1,d2
	add.l	#40*182*4*7,d2
notf8:
	cmp.b	#77,d0
	bne	notf10
	move.l	d1,d2
	add.l	#40*182*4*8,d2
notf10:
	tst.l	d2
	beq	nonewscreen
	move.l	d2,d0
	bsr	showscreen2
nonewscreen:	
	rts

planeoffset:	dc.l	0

saveploff:	dc.l	0
saveoldpl:	dc.l	0
saveactpl:	dc.l	0

saveswitch:
	move.l	planeoffset,saveploff
	move.l	oldplanes,saveoldpl
	move.l	activeplanes,saveactpl
	rts

switchswitch:
	move.l	saveploff,d0
	move.l	planeoffset,saveploff
	move.l	d0,planeoffset
	move.l	saveoldpl,d0
	move.l	oldplanes,saveoldpl
	move.l	d0,oldplanes
	move.l	saveactpl,d0
	move.l	activeplanes,saveactpl
	move.l	d0,activeplanes
	rts
	
switch:
	move.l	planeoffset,d0
	add.l	#40*182*4,d0
	cmp.l	#40*182*4*8,d0
	bne	notonscreen8
	move.l	#0,d0
notonscreen8:
	move.l	d0,planeoffset
	add.l	bitplanes,d0
	move.l	activeplanes,oldplanes
	move.l	d0,activeplanes
	rts
	
showscreen:
	move.l	activeplanes,d0
showscreen2:
	move.l	savea02,a0

	move.w 	#bpl1ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl1pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl2ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl2pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl3ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl3pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl4ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl4pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	rts



builtlevel:
	move.l	a0,usedlevel
	lea	levelbuffer,a1

	move.l	#255,d0
lcopy:
	move.b	(a0)+,(a1)+
	dbra	d0,lcopy	

	move.l	usedlevel,a0
	lea	diebuffer,a1

	move.l	#255,d0
lcopy2:
	move.b	(a0)+,(a1)+
	dbra	d0,lcopy2	

	move.l	usedlevel,a0
	lea	dirbuffer,a1

	move.l	#255,d0
lcopy3:
	move.b	(a0)+,(a1)+
	dbra	d0,lcopy3

	move.l	usedlevel,a0
	lea	240(a0),a0
	move.l	a0,extrapointer

	lea	dirbuffer2,a1
	move.l	#255,d0
clr1:
	move.b	#0,(a1)+
	dbra	d0,clr1

	lea	dirbuffer3,a1
	move.l	#255,d0
clr2:
	move.b	#0,(a1)+
	dbra	d0,clr2

	move.l	levelcounter,d0
	add.w	d0,d0
	add.w	d0,d0
	lea	leveldata,a0
	move.w	(a0,d0.w),d1
	mulu	#108,d1
	add.l	#colors,d1
	move.l	d1,usedcolors	
	
	move.w	2(a0,d0.w),d1
	mulu	#2400,d1
	add.l	#walls,d1
	move.l	d1,a1
	lea	wall,a2
	move.w	#1200-1,d0
wloop:
	move.w	(a1)+,(a2)+
	dbra	d0,wloop


	move.l	usedlevel,a0
	move.b	255(a0),d0
	move.b	#4,d1
	sub.b	d0,d1
	and.l	#$f,d1
	mulu	#4*16*4,d1
	move.l	d1,d0
	add.l	#fruits,d0
	add.l	#fruits_m,d1
	move.l	d0,blob
	move.l	d1,blobmask

	move.b	254(a0),d0
	and.w	#$f,d0
	move.w	d0,d1
	mulu	#10,d0
	add.w	d1,d0
	move.w	d0,istime
	move.w	#0,timec

	move.l	bitplanes,activeplanes

	move.w	#0,nofruits
	bsr	fillscreen

	move.l	bitplanes,d0
	add.l	#40*182*4*8,d0
	move.l	d0,activeplanes

	move.w	#0,nofruits
	bsr	fillscreen

	move.w	#6,d2
	move.l	bitplanes,d1
sloop:
	move.l	d1,d0
	add.l	#40*182*4,d1
	bsr	copyscreen
	dbra	d2,sloop

	rts

nofruits:	dc.w	0


fillscreen:
	move.w	#0,numfruits
	move.l	usedlevel,a0

fillscreen2:
	move.l	#0,d6
yloop:
	move.l	#0,d5
xloop:
	move.w	d5,d0
	move.w	d6,d1
	move.b	(a0)+,d2

	cmp.w	#144,d5
	bne	notonstart
	cmp.w	#144,d6
	bne	notonstart
	bra	headstart
notonstart:
	cmp.b	#0,d2
	beq	Boden
	cmp.b	#1,d2
	beq	Wand
	cmp.b	#2,d2
	beq	bridgev1
	cmp.b	#6,d2
	beq	bridgev2
	cmp.b	#7,d2
	beq	bridgev3	
	cmp.b	#8,d2
	beq	bridgev4
	cmp.b	#3,d2
	beq	bridgeh1
	cmp.b	#4,d2
	beq	bridgeh2
	cmp.b	#5,d2
	beq	bridgeh3
	cmp.b	#9,d2
	beq	bridgeh4
builtnext:
	add.w	#16,d5
	cmp.w	#320,d5
	bne	xloop

	add.w	#16,d6
	cmp.w	#176,d6
	bne	yloop

	rts
	

copyscreen:
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltdmod(a5)
	move.w	#91*4*64+40,bltsize(a5)
	rts


headstart:
	bsr	putfloor
	bra	builtnext

Boden:
	bsr	putfloor
	
	tst.w	nofruits
	bne	builtnext

	add.w	#1,numfruits
	
	move.w	d5,d0
	move.w	d6,d1

	move.l	blob,d2
	move.l	blobmask,d3

	add.w	#6,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#16*4*64+2,bltsize(a5)
	

	bra	builtnext
Wand:
	cmp.w	#0,d5
	bne	bigwall

	move.w	d5,d0
	move.w	d6,d1

	move.l	#wall+22*6*4,d2
	move.l	#wall_m+22*6*4,d3

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#2,bltamod(a5)
	move.w	#2,bltbmod(a5)
	move.w	#36,bltcmod(a5)
	move.w	#36,bltdmod(a5)
	move.w	#22*4*64+2,bltsize(a5)

	bra	builtnext

bigwall:
	sub.w	#6,d0
	move.l	#wall,d2
	move.l	#wall_m,d3

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#22*4*64+3,bltsize(a5)

	bra	builtnext

putfloor:
	move.l	#floor,d2
	add.w	#6,d1
	mulu	#160,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#16*4*64+1,bltsize(a5)
	rts


bridgev1:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_v+6*4*5,d2
	move.l	#bridge_v_m+6*4*5,d3

	sub.w	#14,d0
	sub.w	#3,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#20*4*64+3,bltsize(a5)

	move.w	d5,d0
	move.w	d6,d1
	add.w	#16,d0

	sub.w	#5,d0
	move.l	#wall+44*6*4,d2
	move.l	#wall_m+44*6*4,d3

	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#6*4*64+3,bltsize(a5)		

	bra	builtnext
bridgev2:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_v,d2
	move.l	#bridge_v_m,d3

	sub.w	#14,d0
	add.w	#6+2,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#33*4*64+3,bltsize(a5)

	bra	builtnext
bridgev3:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_v+24*6*4,d2
	move.l	#bridge_v_m+24*6*4,d3

	sub.w	#14,d0
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#12*4*64+3,bltsize(a5)

	bra	builtnext
bridgev4:
	bsr	putfloor
	
	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_v+72*6*4,d2
	move.l	#bridge_v_m+72*6*4,d3

	sub.w	#14,d0
	sub.w	#5,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#25*4*64+3,bltsize(a5)

	bra	builtnext

bridgeh1:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_h+2,d2
	move.l	#bridge_h_m+2,d3

	sub.w	#8,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#4,bltamod(a5)
	move.w	#4,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#29*4*64+1,bltsize(a5)

	bra	builtnext
bridgeh2:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_h,d2
	move.l	#bridge_h_m,d3

	sub.w	#8,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#4,bltamod(a5)
	move.w	#4,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#29*4*64+1,bltsize(a5)


	bra	builtnext
bridgeh3:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1

	move.l	#bridge_h+4,d2
	move.l	#bridge_h_m+4,d3
	
	sub.w	#8,d1
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#4,bltamod(a5)
	move.w	#4,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#29*4*64+1,bltsize(a5)

	bra	builtnext

bridgeh4:
	bsr	putfloor

	move.w	d5,d0
	move.w	d6,d1


	move.l	#bridge_v+97*6*4,d2
	move.l	#bridge_v_m+97*6*4,d3

	sub.w	#8,d1
	sub.w	#11,d0	
	mulu	#160,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0fe2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#34,bltcmod(a5)
	move.w	#34,bltdmod(a5)
	move.w	#29*4*64+3,bltsize(a5)
	bra	builtnext


oldcopperbase:
	move.l	#$dff000,a5
	move.w	#$03e0,dmacon(a5)
	move.l	oldcopper,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83e0,dmacon(a5)
	rts

paintcopper:
	move.l	#$dff000,a5
	move.w	#$03e0,dmacon(a5)
	move.l	copperbase,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$2081,diwstrt(a5)
	move.w	#$2fc1,diwstop(a5)
	move.w	#$0038,ddfstrt(a5)
	move.w	#$00d0,ddfstop(a5)
	move.w	#$83e0,dmacon(a5)
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


savesprcolors:	dc.l	0

sprcolors:
	move.l	savesprcolors,a0
	move.l	#$01a2,d0
.scloop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#2,d0
	cmp.w	#$01c0,d0
	bne	.scloop
	rts


make_paint_copperlist:
	move.l	copperbase,a0	
	move.w	#$0001,(a0)+
	move.w	#$ff00,(a0)+
	move.w	#dmacon,(a0)+
	move.w	#$8120,(a0)+
	move.w	#bplcon0,(a0)+
	move.w	#$0000,(a0)+
	move.w	#bplcon1,(a0)+
	move.w	#0,(a0)+
	move.w	#bplcon2,(a0)+
	move.w	#%100100,(a0)+
	move.w	#bpl1mod,(a0)+
	move.w	#120,(a0)+
	move.w	#bpl2mod,(a0)+
	move.w	#120,(a0)+

	move.l	a0,savea0

	move.l	#$0180,d0
.cloop
	move.w	d0,(a0)+
	move.w	#0,(a0)+
	add.w	#2,d0
	cmp.w	#$01a2,d0
	bne	.cloop

	move.l	a0,savesprcolors

	lea	scolors,a1
	bsr	sprcolors

	move.l	a0,savesprite

	move.l	#offsprite,d0
	move.w	#spr0pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr1pt,d1
	bsr	inssprite
	
	move.l	a0,savesprite2
	
	move.l	#offsprite,d0
	move.w	#spr2pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr3pt,d1
	bsr	inssprite
	
	move.l	a0,savesprite3

	move.l	#offsprite,d0
	move.w	#spr4pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr5pt,d1
	bsr	inssprite

	move.l	a0,savesprite4
	
	move.l	#offsprite,d0
	move.w	#spr6pt,d1
	bsr	inssprite
	move.l	#offsprite,d0
	move.w	#spr7pt,d1
	bsr	inssprite

	move.w	#$0501,(a0)+
	move.w	#$ff00,(a0)+

	move.l	a0,savea02	; Graphic screen

	move.l	bitplanes,d0
	move.w 	#bpl1ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl1pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl2ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl2pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl3ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl3pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl4ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl4pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	move.w	#$3701,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#bplcon0,(a0)+
	move.w	#$4000,(a0)+

	move.w	#$ed01,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#bplcon0,(a0)+
	move.w	#$0000,(a0)+

	move.w	#$f001,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#$0182,(a0)+
	move.w	#$0fff,(a0)+
	move.w	#$0192,(a0)+
	move.w	#$0444,(a0)+

	move.l	#scoretext,d0
	move.w 	#bpl1ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl1pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl2ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl2pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl3ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl3pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	add.l	#40,d0
	move.w 	#bpl4ptl,(a0)+
	move.w	d0,(a0)+
	move.w	#bpl4pth,(a0)+
	swap	d0
	move.w	d0,(a0)+
	swap	d0

	move.w	#bplcon1,(a0)+
	move.w	#0,(a0)+
	move.w	#bplcon2,(a0)+
	move.w	#0,(a0)+
	move.w	#bpl1mod,(a0)+
	move.w	#120,(a0)+
	move.w	#bpl2mod,(a0)+
	move.w	#120,(a0)+

	move.w	#$f501,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#bplcon0,(a0)+
	move.w	#$4000,(a0)+

	move.l	#$f501ff00,(a0)+
	move.l	#$018e0000,(a0)+
	move.l	#$0182000f,(a0)+
	move.l	#$f601ff00,(a0)+
	move.l	#$0182022f,(a0)+
	move.l	#$f701ff00,(a0)+
	move.l	#$0182045f,(a0)+
	move.l	#$f801ff00,(a0)+
	move.l	#$0182067f,(a0)+
	move.l	#$f901ff00,(a0)+
	move.l	#$0182099f,(a0)+
	move.l	#$fa01ff00,(a0)+
	move.l	#$01820bbf,(a0)+
	move.l	#$fb01ff00,(a0)+
	move.l	#$01820ddf,(a0)+
	move.l	#$fc01ff00,(a0)+
	move.l	#$01820fff,(a0)+

	move.l	#$ffdffffe,(a0)+
	move.l	#$01900830,(a0)+

	lea	scoretext+40*4*32+2,a1

	move.l	#$0182,d0
.cloop2
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#2,d0
	cmp.w	#$01a0,d0
	bne	.cloop2

	move.w	#$1501,(a0)+
	move.w	#$ff00,(a0)+

	move.w	#bplcon0,(a0)+
	move.w	#$0000,(a0)+

	move.l	#$fffffffe,(a0)
	
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
	move.w	#0,d0
	tst.w	player4
	beq	.no4th
	CLR.W	$42(A0)
	or.w	#8,d0
.no4th
	or.w	#%0111,d0
	MOVE.W	d0,(A0)
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
	tst.w	player4
	beq	.no4th
	BSR.W	mt_CheckEfx
.no4th
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
	tst.w	player4
	beq	.no4th
	BSR.B	mt_DoVoice
.no4th
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
	tst.w	player4
	beq	.no4th
	MOVE.L	142(A6),$30(A5)
	MOVE.W	146(A6),$34(A5)
.no4th

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


		dcb.b	20,0
		dcb.b	20,0
		dcb.b	20,0
levelbuffer:	dcb.b	256,0
		dcb.b	20,0
		dcb.b	20,0
diebuffer:	dcb.b	256,0
		dcb.b	20,0
		dcb.b	20,0
dirbuffer:	dcb.b	256,0
		dcb.b	20,0
		dcb.b	20,0
dirbuffer2:	dcb.b	256,0
		dcb.b	20,0
		dcb.b	20,0
dirbuffer3:	dcb.b	256,0
		dcb.b	20,0
		dcb.b	20,0

statecount:	dc.w 0
firsttime:	dc.w 0
copperbase:	dc.l 0
bitplanes:	dc.l 0
activeplanes:	dc.l 0
savea0:		dc.l 0
savea02:	dc.l 0
savea03:	dc.l 0
savecopper:	dc.l 0
oldcopper:	dc.l 0
gfxbase:	dc.l 0
dosbase:	dc.l 0
savesprite:	dc.l 0
savesprite2:	dc.l 0
savesprite3:	dc.l 0
savesprite4:	dc.l 0
key:		dc.w 0
blob:		dc.l 0
blobmask:	dc.l 0
usedlevel:	dc.l 0
levelcounter:	dc.l 0
numfruits:	dc.w 0	
usedcolors:	dc.l 0

		incdir	"dh1:nibbly/sources/"
levels:	incbin	"levels4"
	incbin	"level16-32"
	incbin	"level33-48"
	incbin	"level49-60"
		dcb.b	20,0

restorebuffer:	dc.l 0
head:		dc.l 0
moving: 	dc.w 0
mright:		dc.w 0
mleft:		dc.w 0
mup:		dc.w 0
mdown:		dc.w 0
oldmove:	dc.w 0

xpos:		dc.w 0
ypos:		dc.w 0
xoff:		dc.w 0
yoff:		dc.w 0

flashscreen:	dc.w 0

first_for_ever:	dc.w 0

more_than_one:	dc.w 0
oldplanes:	dc.l 0
maskbuffer:	dc.l 0

positions:	dcb.l 400*8,0
posstart:	dc.l  positions
posend:		dc.l  positions
positions2:	dcb.l 400*8,0

flupssize:	dc.w  0
died:	dc.w	0

scolors:	dc.w	$fff,$ddd,$4a1,$444,$f8d,$d46,$a11,$0ff
		dc.w	$fd3,$d83,$a53,$833,$3af,$26d,$13c

gfxname:	dc.b	"graphics.library",0
	even
dosname:	dc.b	"dos.library",0
	even
mt_data:	dc.l	0

player4:	dc.w	0
musicstatus:	dc.w	0

		incdir	"dh1:assem/nibbly/sound/"

mainmusic:	dc.l	0
jingle_ouch:		incbin	"mod.jingle-ouch"
jingle_welldone:	incbin	"mod.jingle-welldone"

		incdir	"dh1:lo-res/nibbly2/"

boeden:	incbin	"floors_16x96x4.rb"

gover: 		incbin	"gameover.dat"
gocolors:	incbin	"gameover.col"
wdone: 		incbin	"welldone.dat"
wcolors:	incbin	"welldone.col"
ohno: 		incbin	"ohno.dat"
oncolors:	incbin	"ohno.col"

		SECTION Daten,DATA_C

offsprite:	dc.w 0,0,0,0

sprpuck:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$03C0,$03C0
	dc.w	$0000,$0180,$0810,$0180,$2C34,$2184,$504A,$73CE
	dc.w	$43C2,$7C3E,$4FF2,$700E,$4FF2,$700E,$47E2,$781E
	dc.w	$23C4,$3C3C,$1008,$1FF8,$0C30,$0FF0,$03C0,$03C0
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$03C0,$0000
	dc.w	$0FF0,$0000,$17E8,$0000,$33CC,$0000,$7FFE,$0000
	dc.w	$7FFE,$0000,$7FFE,$0000,$7FFE,$0000,$7FFE,$0000
	dc.w	$3FFC,$0000,$1FF8,$0000,$0FF0,$0000,$03C0,$0000
	dc.w	$0000,$0000,$0000,$0000


sprtod:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0F80,$0F80
	dc.w	$2060,$3FE0,$5200,$7380,$4448,$6D68,$5210,$7390
	dc.w	$4C30,$7EF0,$2060,$3C60,$10E0,$1FE0,$0800,$0800
	dc.w	$0800,$0800,$0380,$0380,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0FE0,$0FE0,$3078,$3FF8
	dc.w	$401C,$7FFC,$8C7E,$F39E,$9EF6,$ED6E,$8C6E,$F39E
	dc.w	$810E,$FEFE,$439C,$7C7C,$2018,$3FF8,$17F0,$1830
	dc.w	$17F0,$1830,$0C60,$0FE0,$07C0,$07C0,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

sprtrankgelb:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$07C0,$07C0,$0820,$0820
	dc.w	$07C0,$07C0,$0440,$0440,$03C0,$0440,$03C0,$0440
	dc.w	$07A0,$0860,$0F90,$1070,$1FC8,$2038,$1FC8,$2038
	dc.w	$1F88,$2078,$0E08,$31F8,$0830,$1FF0,$07C0,$07C0
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$07C0,$0000,$0820
	dc.w	$0000,$07C0,$0000,$0440,$0000,$07C0,$0000,$04C0
	dc.w	$0000,$0CE0,$0000,$1CF0,$0000,$39F8,$0000,$33F8
	dc.w	$0000,$33F8,$0000,$3BF8,$0000,$1FF0,$0000,$07C0
	dc.w	$0000,$0000,$0000,$0000

sprtrankblau:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$07C0,$0000,$0820
	dc.w	$0000,$07C0,$0000,$0440,$0400,$0040,$0500,$0240
	dc.w	$0B40,$0020,$1360,$0010,$2630,$0108,$2C30,$0208
	dc.w	$2C70,$0008,$31F0,$0408,$1FC0,$0030,$0000,$07C0
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$07C0,$07C0,$0820,$0820
	dc.w	$07C0,$07C0,$0440,$0440,$0440,$07C0,$0440,$04C0
	dc.w	$0860,$0CE0,$1070,$1CF0,$2038,$38F8,$2038,$31F8
	dc.w	$2078,$33F8,$31F8,$3BF8,$1FF0,$1FF0,$07C0,$07C0
	dc.w	$0000,$0000,$0000,$0000

sprlife:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$1C70,$1C70,$2698,$3EF8,$5798,$6F78,$4B58,$77B8
	dc.w	$4038,$7FF8,$2070,$3FF0,$10E0,$1FE0,$0D80,$0F80
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$1C70,$0000,$3EF8,$0000,$77BC,$0000,$6F7C,$0000
	dc.w	$7FFC,$0000,$3FF8,$0000,$1FF0,$0000,$0FE0,$0000
	dc.w	$0380,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

sprfrucht:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$07C0,$07C0,$3C78,$3C78
	dc.w	$46E8,$6FF8,$E954,$BCF8,$95B4,$FBDC,$D61C,$CF7C
	dc.w	$E9B0,$BBF0,$BA6C,$F5FC,$1AF8,$3FF8,$37A8,$1FE8
	dc.w	$1DF0,$17F0,$0740,$0740,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$07C0,$07C0,$3FF8,$3C78
	dc.w	$6FFC,$7FF8,$FDFE,$FFFC,$FFFE,$FFFC,$DF7E,$FFFC
	dc.w	$FBFE,$FFF0,$FFFE,$FFFC,$7FFC,$3FF8,$7FFC,$3FE8
	dc.w	$3FF8,$1FF0,$1FF0,$0740,$07C0,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

sprsolved:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$78CC,$4224,$9EA4,$122C,$BEA4,$2240,$AEB8
	dc.w	$2210,$EEFC,$222A,$E6E6,$0A22,$E6E6,$062A,$7EE6
	dc.w	$3C66,$3C66,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$78CC,$78CC,$DEA4,$FEEC,$BEAC,$FEEC,$AEF8,$EEF8
	dc.w	$EEFC,$EEFC,$E6EE,$EEEE,$EEE6,$FEEE,$7EEE,$7EEE
	dc.w	$3C66,$3C66,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

sprtime:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$06C0,$0640,$1090
	dc.w	$1A30,$2088,$1E50,$0080,$2E28,$4084,$3E38,$4044
	dc.w	$1E70,$0080,$3FF8,$4004,$2FE8,$4004,$1FF0,$0000
	dc.w	$1BB0,$2008,$46C4,$5014,$5014,$66CC,$B83A,$C7C6
	dc.w	$FFFE,$FFFE,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$07C0,$0000,$1930,$0000,$2928,$0000
	dc.w	$4544,$0000,$612C,$0000,$9152,$0000,$8182,$0000
	dc.w	$E10E,$0000,$8002,$0000,$9012,$0000,$600C,$0000
	dc.w	$4444,$0000,$692C,$0000,$793C,$0000,$FFFE,$0000
	dc.w	$FFFE,$0000,$0000,$0000

sprbigger:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0100,$0000,$4104,$0000,$2008,$0000
	dc.w	$0000,$07C0,$07A0,$0860,$0FD0,$1030,$0FD0,$1030
	dc.w	$CFD6,$1030,$0F90,$1070,$0630,$19F0,$08E0,$0FE0
	dc.w	$07C0,$07C0,$2008,$0000,$4104,$0000,$0100,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0100,$0000,$4104,$0000,$2008
	dc.w	$0000,$07C0,$0000,$0FE0,$0000,$1CF0,$0000,$19F0
	dc.w	$0000,$D9F6,$0000,$1FF0,$0000,$1FF0,$0000,$0FE0
	dc.w	$0000,$07C0,$0000,$2008,$0000,$4104,$0000,$0100
	dc.w	$0000,$0000,$0000,$0000

sprsmaller:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0100,$0000,$0100,$0000,$2108,$0000
	dc.w	$1010,$0000,$0000,$0380,$0380,$0440,$0780,$0860
	dc.w	$E7AE,$0860,$0720,$08E0,$0040,$07C0,$0380,$0380
	dc.w	$1010,$0000,$2108,$0000,$0100,$0000,$0100,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0100,$0000,$0100,$0000,$2108
	dc.w	$0000,$1010,$0000,$0380,$0000,$07C0,$0000,$0CE0
	dc.w	$0000,$EDEE,$0000,$0FE0,$0000,$07C0,$0000,$0380
	dc.w	$0000,$1010,$0000,$2108,$0000,$0100,$0000,$0100
	dc.w	$0000,$0000,$0000,$0000


sprflash:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0014,$0021
	dc.w	$0003,$001D,$0007,$0221,$001B,$0545,$0135,$088F
	dc.w	$07AD,$101D,$0CD8,$2338,$1B30,$47F0,$56E0,$8EE0
	dc.w	$2C40,$5C40,$1800,$3800,$1000,$1000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$0031,$003B
	dc.w	$001F,$001F,$0227,$023F,$054F,$076F,$089F,$0EDF
	dc.w	$133D,$1B7D,$27F8,$37F8,$4FF0,$6FF0,$DEE0,$FEE0
	dc.w	$7C40,$7C40,$3800,$3800,$1000,$1000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

bonus100:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$77BC,$77BC,$FB5A,$CCE6,$FFFE,$894A
	dc.w	$FFFE,$894A,$FFFE,$C94A,$7FFE,$494A,$7B5A,$4CE6
	dc.w	$7BBC,$7BBC,$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$77BC,$0000,$FDEE,$0210,$DBDE,$2420
	dc.w	$DBDE,$0000,$DBDE,$0000,$5FFE,$2000,$7FFE,$0000
	dc.w	$7BBC,$0000,$0000,$0000,$0000,$0000

bonus200:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$7BDE,$7BDE,$B5AD,$CE73,$FFFF,$94A5
	dc.w	$7FFF,$64A5,$F7FF,$CCA5,$EFFF,$9CA5,$FDAD,$8673
	dc.w	$FDDE,$FDDE,$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$7BDE,$0000,$DEF7,$2108,$FDEF,$0210
	dc.w	$7DEF,$0000,$DDEF,$2000,$BDEF,$0210,$FFFF,$0000
	dc.w	$FDDE,$0000,$0000,$0000,$0000,$0000

bonus400:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$F3DE,$F3DE,$FDAD,$9E73,$FFFF,$94A5
	dc.w	$FFFF,$84A5,$FFFF,$E4A5,$3FFF,$24A5,$3DAD,$2673
	dc.w	$3DDE,$3DDE,$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$F3DE,$0000,$BEF7,$4108,$BDEF,$0000
	dc.w	$FDEF,$0000,$EDEF,$1210,$2FFF,$0000,$3FFF,$0000
	dc.w	$3DDE,$0000,$0000,$0000,$0000,$0000

bonus800:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$7BDE,$7BDE,$B5AD,$CE73,$FFFF,$94A5
	dc.w	$B7FF,$CCA5,$FFFF,$94A5,$FFFF,$94A5,$B5AD,$CE73
	dc.w	$79DE,$79DE,$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$7BDE,$0000,$DEF7,$0108,$BDEF,$4210
	dc.w	$FDEF,$0000,$BDEF,$0210,$BFFF,$4000,$FFFF,$0000
	dc.w	$79DE,$0000,$0000,$0000,$0000,$0000

bonuslife:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$E6EF,$E6EF,$FFFF,$9911,$FFFE,$9932
	dc.w	$FFFF,$9911,$FFFE,$9932,$FFFE,$9932,$FFFF,$8931
	dc.w	$F6CF,$F6CF,$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$E6EF,$0000,$FFBB,$0044,$BB76,$4488
	dc.w	$BB77,$0000,$BB76,$0088,$BB76,$4488,$FFFF,$0000
	dc.w	$F6CF,$0000,$0000,$0000,$0000,$0000

expo1:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$4002
	dc.w	$4002,$8001,$4002,$8001,$0000,$4002,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000
	
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0180,$0000,$03C0,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$4002
	dc.w	$0000,$C003,$0000,$C003,$0000,$4002,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$03C0
	dc.w	$0000,$0180,$0000,$0000

expo2:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0000,$0180
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$4002
	dc.w	$4002,$A005,$4002,$A005,$0000,$4002,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0180,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0180,$0000,$02C0,$0000,$0180
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$4002
	dc.w	$0000,$A005,$0000,$E007,$0000,$4002,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0180,$0000,$02C0
	dc.w	$0000,$0180,$0000,$0000


expo3:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000,$0000,$0000,$0000,$6006
	dc.w	$6006,$9009,$6006,$9009,$0000,$6006,$0000,$0000
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0180,$0000,$02C0,$0000,$03C0
	dc.w	$0000,$0180,$0000,$0000,$0000,$0000,$0000,$6006
	dc.w	$0000,$B00B,$0000,$F00F,$0000,$6006,$0000,$0000
	dc.w	$0000,$0000,$0000,$0180,$0000,$02C0,$0000,$03C0
	dc.w	$0000,$0180,$0000,$0000

expo4:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0180,$0240
	dc.w	$0180,$0240,$0000,$0180,$0000,$0000,$0000,$700E
	dc.w	$700E,$8811,$700E,$8811,$0000,$700E,$0000,$0000
	dc.w	$0000,$0180,$0180,$0240,$0180,$0240,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0180,$0000,$02C0,$0000,$02C0
	dc.w	$0000,$03C0,$0000,$0180,$0000,$0000,$0000,$700E
	dc.w	$0000,$9813,$0000,$F81F,$0000,$700E,$0000,$0000
	dc.w	$0000,$0180,$0000,$02C0,$0000,$02C0,$0000,$03C0
	dc.w	$0000,$0180,$0000,$0000


expo5:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0180,$0180,$0240,$0180,$0240
	dc.w	$0180,$0240,$0180,$0240,$0000,$0180,$0000,$781E
	dc.w	$781E,$8421,$781E,$8421,$0000,$781E,$0000,$0180
	dc.w	$0180,$0240,$0180,$0240,$0180,$0240,$0180,$0240
	dc.w	$0000,$0180,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0180,$0000,$02C0,$0000,$02C0
	dc.w	$0000,$02C0,$0000,$03C0,$0000,$0180,$0000,$781E
	dc.w	$0000,$8C23,$0000,$FC3F,$0000,$781E,$0000,$0180
	dc.w	$0000,$02C0,$0000,$02C0,$0000,$02C0,$0000,$03C0
	dc.w	$0000,$0180,$0000,$0000


expo6:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0180,$0180,$0240
	dc.w	$0180,$0240,$0180,$0240,$0180,$0240,$0000,$3DBC
	dc.w	$3C3C,$4242,$3C3C,$4242,$0000,$3DBC,$0180,$0240
	dc.w	$0180,$0240,$0180,$0240,$0180,$0240,$0000,$0180
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0180,$0000,$02C0
	dc.w	$0000,$02C0,$0000,$02C0,$0000,$03C0,$0000,$3DBC
	dc.w	$0000,$4646,$0000,$7E7E,$0000,$3DBC,$0000,$02C0
	dc.w	$0000,$02C0,$0000,$02C0,$0000,$03C0,$0000,$0180
	dc.w	$0000,$0000,$0000,$0000

expo7:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0180
	dc.w	$0180,$0240,$0180,$0240,$0180,$0660,$0180,$1E78
	dc.w	$1E78,$2184,$1E78,$2184,$0180,$1E78,$0180,$0660
	dc.w	$0180,$0240,$0180,$0240,$0000,$0180,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$0000,$0180
	dc.w	$0000,$02C0,$0000,$02C0,$0000,$06E0,$0000,$1FF8
	dc.w	$0000,$238C,$0000,$3FFC,$0000,$1EF8,$0000,$06E0
	dc.w	$0000,$02C0,$0000,$03C0,$0000,$0180,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

expo8:
	;Even ATTACH pair follows:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0180,$0180,$0240,$0180,$0660,$03C0,$0C30
	dc.w	$0FF0,$1008,$0FF0,$1008,$03C0,$0C30,$0180,$0660
	dc.w	$0180,$0240,$0000,$0180,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	;Odd ATTACH pair follows:
	dc.w	$0000,$0080,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0180,$0000,$02C0,$0000,$06E0,$0000,$0FF0
	dc.w	$0000,$1398,$0000,$1FF8,$0000,$0EF0,$0000,$06E0
	dc.w	$0000,$03C0,$0000,$0180,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000


			;ColorNr,WallNr	   for Level 0-15
leveldata:	dc.w	0,0		;0
		dc.w	1,0		;1
		dc.w	2,0		;2
		dc.w	3,0		;3
		dc.w	4,1		;4
		dc.w	0,1		;5
		dc.w	1,1		;6
		dc.w	2,1		;7
		dc.w	3,2		;8
		dc.w	4,2		;9
		dc.w	0,2		;10
		dc.w	1,2		;11
		dc.w	2,3		;12
		dc.w	3,3		;13
		dc.w	4,3		;14
		dc.w	0,3		;15

		dc.w	0,0		;16
		dc.w	1,0		;17
		dc.w	2,0		;18
		dc.w	3,0		;19
		dc.w	4,1		;20
		dc.w	0,1		;21
		dc.w	1,1		;22
		dc.w	2,1		;23
		dc.w	3,2		;24
		dc.w	4,2		;25
		dc.w	0,2		;26
		dc.w	1,2		;27
		dc.w	2,3		;28
		dc.w	3,3		;29
		dc.w	4,3		;30
		dc.w	0,3		;31

		dc.w	0,0		;32
		dc.w	1,0		;33
		dc.w	2,0		;34
		dc.w	3,0		;35
		dc.w	4,1		;36
		dc.w	0,1		;37
		dc.w	1,1		;38
		dc.w	2,1		;39
		dc.w	3,2		;40
		dc.w	4,2		;41
		dc.w	0,2		;42
		dc.w	1,2		;43
		dc.w	2,3		;44
		dc.w	3,3		;45
		dc.w	4,3		;46
		dc.w	0,3		;47

		dc.w	0,0		;48
		dc.w	1,0		;49
		dc.w	2,0		;50
		dc.w	3,0		;51
		dc.w	4,1		;52
		dc.w	0,1		;53
		dc.w	1,1		;54
		dc.w	2,1		;55
		dc.w	3,2		;56
		dc.w	4,2		;57
		dc.w	0,2		;58
		dc.w	1,2		;59

		incdir	"dh1:nibbly/lo-res/nibbly2/"

special:	incbin	"spec_mask_48x17x4.mask"
scoretext:	incbin	"score_Text_320x32x4.rb"		
scorechars:	incbin	"chars_160x17x4.rb"		
bridge_h:	incbin	"bridge_h_48x45x4.rb"
bridge_h_m:	incbin	"bridge_h_48x45x4.mask"
bridge_v:	incbin	"bridge_v_48x126x4.rb"
bridge_v_m:	incbin	"bridge_v_48x126x4.mask"
restore:	incbin	"restoreparts_32x46x4.rb"
restore_m:	incbin	"restoreparts_32x46x4.mask"
floor:		incbin	"floor_16x16x4.rb"
floor_m:	incbin	"floor_16x16x4.mask"
flups:		incbin	"flups_48x176x4.rb"
flups_m:	incbin	"flups_48x176x4.mask" 
fruits:		incbin	"fruits_32x80x4.rb"
fruits_m:	incbin	"fruits_32x80x4.mask" 
wall:		incbin	"wall_48x50x4.rb"
wall_m:		incbin	"wall_48x50x4.mask"
walls:		incbin	"wallmarmor_48x50x4.rb"
		incbin	"wallmarmor_48x50x4.mask"
		incbin	"wall2.2_48x50x4.rb"
		incbin	"wall2.2_48x50x4.mask"
		incbin	"wall_48x50x4.rb"
		incbin	"wall_48x50x4.mask"
		incbin	"wall2.4_48x50x4.rb"
		incbin	"wall2.4_48x50x4.mask"
colors:		incbin	"levelcolors_1.iff"
		incbin	"levelcolors_2.iff"
		incbin	"levelcolors_3.iff"
		incbin	"levelcolors_4.iff"
		incbin	"levelcolors_5.iff"
tile:		dc.w	$ffff,$0000,$ffff,$0000,$ffff,$0000,$ffff,$0000
		dc.w	$ffff,$0000,$ffff,$0000,$ffff,$0000,$ffff,$0000
		dc.w	$ffff,$0000,$ffff,$0000,$ffff,$0000,$ffff,$0000
		dc.w	$ffff,$0000,$ffff,$0000,$ffff,$0000,$ffff,$0000
secpointer:	dc.l	0
ringxy:	  	dcb.w	8*2,0
secbuffer:	dcb.b	8*6*22,0


dummysample:	dc.w	0,0,0,0
		incdir	"dh1:assem/nibbly/sound/"
sfx_pickup:	incbin	"sfx1.aufklauben"
sfx_plopp:	incbin	"sfx9.plopp1"
sfx_pop:	incbin	"sfx6.pop"
sfx_bonustaken:	incbin	"sfx8.bonustake"
sfx_auftauchen:	incbin	"sfx7.auftauchenI"
sfx_fruitsize:	incbin	"sfx.fruitresize"
sfx_signal:	incbin	"sfx.signal"

eoa:
;* END *
